`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: The University of Bristol
// Engineer: Jiajun Lu, Zijie Wang
// 
// Create Date: 11/12/2021 04:18:40 AM
// Design Name: 
// Module Name: tdc_fine
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tdc_fine #(
    parameter NUM_DSP_PER_LINE = 16,
    parameter NUM_DELAY_LINE = 1,
    parameter DATA_WIDTH = 8 
)(
    input  i_clk,
    input  i_rst,
    input  i_trigger,
    input  i_stop,
    input  i_cali_en,
    output [15:0] o_dout
);

// Delay lines
wire [NUM_DSP_PER_LINE - 1 : 0] 	    dsp_link           [NUM_DELAY_LINE - 1 : 0];
wire [NUM_DSP_PER_LINE * 48 - 1 : 0] 	delay_line_dout    [NUM_DELAY_LINE - 1 : 0];
reg  [NUM_DSP_PER_LINE * 48 - 1 : 0] 	data_buff0         [NUM_DELAY_LINE - 1 : 0];
reg  [NUM_DSP_PER_LINE * 48 - 1 : 0] 	data_buff1         [NUM_DELAY_LINE - 1 : 0];
// Others
wire                                    lut_buff           [(NUM_DELAY_LINE - 1) * 2 : 0];
wire [15:0]                             tmp_enc_dout_ff    [NUM_DELAY_LINE * NUM_DELAY_LINE - 1 : 0];

// ====================================================================================================
// Wave Union Launcher
// ====================================================================================================
`ifdef WAVE_UNION
    wave_union #(
        .NUM_CARRY4(4)
    ) wave_union_inst(
        .i_trigger(i_trigger),
        .o_dout(trigger_out)
    );
    assign lut_buff[0] = trigger_out;
`else
    assign lut_buff[0] = i_trigger;
`endif


// ====================================================================================================
// Insert delay components in front of different delay lines for multi-delay lines
// ====================================================================================================
genvar i;
generate
    for(i = 0; i < (NUM_DELAY_LINE - 1) * 2; i = i + 2) begin
        LUT1 #(
            .INIT(2'b10)                // Specify LUT Contents
        ) U_LUT1_FF0_INST (
            .O(lut_buff[i+1]),            // LUT general output
            .I0(lut_buff[i])                // LUT input
        );                  
        LUT1 #(
            .INIT(2'b10)                // Specify LUT Contents
        ) U_LUT1_FF1_INST (
            .O(lut_buff[i+2]),          // LUT general output
            .I0(lut_buff[i+1])            // LUT input
        );
    end
endgenerate

// ==================================================================================================
//  Delay lines
// ==================================================================================================
genvar iline;
genvar idsp;
genvar iff; // The index of flip flops (iff)
generate
    // Number of delay lines
    for(iline = 0; iline < NUM_DELAY_LINE; iline = iline + 1) begin : dsp_delay_line
        // DSP per delay line
        for(idsp = 0; idsp < NUM_DSP_PER_LINE; idsp = idsp + 1) begin : dsp_index
            if(idsp == 0) begin
                xbip_dsp48_macro_0 U_DSP_TYPE0_INST (
                    .CARRYIN(lut_buff[iline*2]),                         // input wire CARRYIN
                    .C({48{1'b1}}),                                      // input wire [47 : 0]    
                    .CARRYCASCOUT(dsp_link[iline][idsp]),                // output wire CARRYCASCOUT
                    .ACOUT(),                                            // Unused
                    .P(delay_line_dout[iline][(idsp+1)*48-1:(idsp)*48])  // output wire [47 : 0] P                   
                );
            end
            else begin
                xbip_dsp48_macro_1 U_DSP_TYPE1_INST (
                    .CARRYCASCIN(dsp_link[iline][idsp-1]),              // input wire CARRYCASCIN
                    .C({48{1'b1}}),                                     // input wire [47 : 0] C
                    .CARRYCASCOUT(dsp_link[iline][idsp]),               // output wire CARRYCASCOUT
                    .ACOUT(),                                           // Unused
                    .P(delay_line_dout[iline][(idsp+1)*48-1:(idsp)*48]) // output wire [47 : 0] P
                );
            end
        end
        // The first level Flip-Flops   
        for(iff = 0; iff < NUM_DSP_PER_LINE * 48; iff = iff + 1) begin
            always @(posedge i_clk or posedge i_rst) begin
                if(i_rst) begin
                    data_buff0[iline][iff] <= 0;
                end
                else begin
                    if(i_stop) begin
                        data_buff0[iline][iff] <= delay_line_dout[iline][iff];
                    end
                    else begin
                        data_buff0[iline][iff] <= 0;
                    end
                end
            end
        end     
        // The second level Flip-Flops   
        for(iff = 0; iff < NUM_DSP_PER_LINE*48; iff = iff + 1) begin
            always @(posedge i_clk or posedge i_rst) begin
                if(i_rst) begin
                    data_buff1[iline][iff] <= 0;
                end
                else begin
                    data_buff1[iline][iff] <= data_buff0[iline][iff];
                end
            end
        end         
    end
endgenerate

// =====================================================================================
// Encoder 
// =====================================================================================
genvar iblk;
generate 
    for(iblk = 0; iblk < NUM_DELAY_LINE; iblk = iblk + 1) begin : encoder_block
        encoder #(
            .DATA_WIDTH(DATA_WIDTH),
            .NUM_DSP_PER_LINE(NUM_DSP_PER_LINE)
        ) U_ENCODER_INST (
            .i_clk(i_clk),
            .i_rst(i_rst),
            .i_din(data_buff1[iblk]),
            .o_dout(tmp_enc_dout_ff[iblk])
        );
    end
endgenerate

// =====================================================================================
// Pipelines for the sum of results from different delay lines
// =====================================================================================

genvar ipipe;
genvar iadder;
generate
    for(ipipe = 0; ipipe < $clog2(NUM_DELAY_LINE); ipipe = ipipe + 1) begin : pipeline
        for(iadder = 0; iadder < NUM_DELAY_LINE/(2**(ipipe+1)); iadder = iadder + 1) begin : adder
            c_addsub_0 U_ADDER_INST (                                                            
                .A(tmp_enc_dout_ff[iadder*2+ipipe*NUM_DELAY_LINE]),
                .B(tmp_enc_dout_ff[iadder*2+ipipe*NUM_DELAY_LINE+1]),
                .CLK(i_clk),
                .S(tmp_enc_dout_ff[iadder+(ipipe+1)*NUM_DELAY_LINE])
            );
        end  
    end
endgenerate


// Output to Top
assign o_dout = tmp_enc_dout_ff[$clog2(NUM_DELAY_LINE)*NUM_DELAY_LINE];

endmodule
