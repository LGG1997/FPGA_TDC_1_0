`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: The university of Bristol
// Engineer: Zijie Wang, Jiajun Lu
// 
// Create Date: 07/27/2021 08:19:21 PM
// Design Name: 
// Module Name: encoder
// Project Name: FPGA TDC
// Target Devices: Zedboard
// Tool Versions: 
// Description: Detect edges from delay lines and transfer them into binary code.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "configuration.v"

module encoder
   #(
   	parameter DATA_WIDTH = 8,
   	parameter NUM_DSP_PER_LINE = 16
    )(
    	input                   i_clk,	
    	input                   i_rst,
  		input [NUM_DSP_PER_LINE*48-1:0]  i_din,
  		output reg [15:0]       o_dout
	 );

//-------------------------------------------------------------------------------------------------
// Edge detection block
//-------------------------------------------------------------------------------------------------


wire [NUM_DSP_PER_LINE*48-1:0] tmp_data;
wire [NUM_DSP_PER_LINE*48-1:0] tmp_data1;
wire [NUM_DSP_PER_LINE*48-1:0] tmp_data2;

// Detect negative edge
genvar id1;
generate 
	for(id1 = 2; id1 < NUM_DSP_PER_LINE*48 - 1 ; id1 = id1 + 1) begin
		assign tmp_data1[id1] =  ~i_din[id1-2] & ~i_din[id1-1] & i_din[id1] & i_din[id1+1];
	end
endgenerate

// Detect positive edge
//genvar id2;
//generate 
//	for(id2 = 2; id2 < NUM_DSP*48 - 1; id2 = id2 + 1) begin
//		assign tmp_data2[id2] =  i_din[id2-2] & i_din[id2-1] & ~i_din[id2] & ~i_din[id2+1];
//	end
//endgenerate


assign tmp_data1[0] = {~i_din[0] & i_din[1] & i_din[2] & i_din[3]} ? 1'b1: 1'b0;
assign tmp_data1[1] = {~i_din[0] & ~i_din[1] & i_din[2] & i_din[3]} ? 1'b1: 1'b0;
assign tmp_data1[NUM_DSP_PER_LINE*48-1] = 0;
//assign tmp_data1[3] = {~i_din[0] & ~i_din[1] & ~i_din[2] & i_din[3] & i_din[4]} ? 1'b1: 1'b0;

//assign tmp_data2[NUM_DSP*48-1:NUM_DSP*48-2] = 0;
//assign tmp_data2[0] = {i_din[0] & ~i_din[1] & ~i_din[2] & ~i_din[3]} ? 1'b1: 1'b0;
//assign tmp_data2[1] = {i_din[0] & i_din[1] & ~i_din[2] & ~i_din[3]} ? 1'b1: 1'b0;

assign tmp_data = tmp_data1;


//-------------------------------------------------------------------------------------------------
// Encoder
//-------------------------------------------------------------------------------------------------

`ifdef PRIORITY_ENCODER

// define the number of required encoders
localparam NUM_ENC = 12;

wire [NUM_ENC-1:0] tmp_ynem;
wire [NUM_ENC-1:0] tmp_yen;
wire [5:0] tmp_ecdr_out [NUM_ENC-1:0];
wire [9:0] tmp_offset [NUM_ENC-1:0];
reg [10:0] tmp_out;

genvar iblk;
generate 
	for(iblk = 0; iblk < NUM_ENC; iblk = iblk + 1) begin
		_48_6_encoder #(
			.INDEX(iblk)		 	
	 	)U_48_6_ENCODER_INST (
			.i_clk(i_clk),
			.i_rst(i_rst),
			.i_en(1'b1),
			.i_din(tmp_data[((iblk+1)*48 - 1) : (iblk*48)]),
			.o_dout(tmp_ecdr_out[iblk]),
			.o_offset(tmp_offset[iblk]),	
			.o_Yen(tmp_yen[iblk]),
			.o_Ynem(tmp_ynem[iblk])
    		 );
	end
endgenerate


always @(posedge i_clk or posedge i_rst) begin
	if(i_rst)
		tmp_out <= 0;
	else     
//		if(tmp_ynem[19]) 
//			tmp_out <= tmp_offset[19] + tmp_ecdr_out[19]; 
//		else if(tmp_ynem[18]) 
//		   tmp_out <= tmp_offset[18] + tmp_ecdr_out[18]; 
//		else if(tmp_ynem[17]) 
//		   tmp_out <= tmp_offset[17] + tmp_ecdr_out[17]; 
//		else if(tmp_ynem[16]) 
//		   tmp_out <= tmp_offset[16] + tmp_ecdr_out[16]; 
		if(tmp_ynem[15]) 
		   tmp_out <= tmp_offset[15] + tmp_ecdr_out[15];	   
		else if(tmp_ynem[14])
		   tmp_out <= tmp_offset[14] + tmp_ecdr_out[14]; 
		else if(tmp_ynem[13])  
		   tmp_out <= tmp_offset[13] + tmp_ecdr_out[13]; 
	        else if(tmp_ynem[12]) 
		   tmp_out <= tmp_offset[12] + tmp_ecdr_out[12]; 
		else if(tmp_ynem[11]) 
		   tmp_out <= tmp_offset[11] + tmp_ecdr_out[11]; 
		else if(tmp_ynem[10]) 
	           tmp_out <= tmp_offset[10] + tmp_ecdr_out[10]; 
		else if(tmp_ynem[9]) 
		   tmp_out <= tmp_offset[9] + tmp_ecdr_out[9]; 
		else if(tmp_ynem[8]) 
		   tmp_out <= tmp_offset[8] + tmp_ecdr_out[8]; 
		else if(tmp_ynem[7]) 
		   tmp_out <= tmp_offset[7] + tmp_ecdr_out[7]; 
		else if(tmp_ynem[6]) 
		   tmp_out <= tmp_offset[6] + tmp_ecdr_out[6]; 	   
		else if(tmp_ynem[5]) 
		   tmp_out <= tmp_offset[5] + tmp_ecdr_out[5]; 
		else if(tmp_ynem[4]) 
		   tmp_out <= tmp_offset[4] + tmp_ecdr_out[4]; 
		else if(tmp_ynem[3]) 
		   tmp_out <= tmp_offset[3] + tmp_ecdr_out[3]; 
		else if(tmp_ynem[2]) 
		   tmp_out <= tmp_offset[2] + tmp_ecdr_out[2]; 
		else if(tmp_ynem[1]) 
		   tmp_out <= tmp_offset[1] + tmp_ecdr_out[1]; 
		else if(tmp_ynem[0]) 
		   tmp_out <= tmp_offset[0] + tmp_ecdr_out[0];
		else 
		   tmp_out <= 0;   	
end

always @(posedge i_clk or posedge i_rst) begin
	if(i_rst)
	   o_dout <= 0;
	else
	   o_dout = tmp_out;
end

`endif



`ifdef MULTIEDGE_ENCODER

wire [15:0] tmp_sum_position_ff [NUM_DSP_PER_LINE * NUM_DSP_PER_LINE - 1 : 0];

// Each edge_sum contains 4-level pipelines 
genvar iblk;
generate
	for(iblk = 0; iblk < NUM_DSP_PER_LINE; iblk = iblk + 1) begin : edge_sum_block
 		edge_sum #(
	  		.INDEX(iblk)
	 	) U_EDGE_SUM_INST (    
			.i_clk(i_clk),
			.i_rst(i_rst),
			.i_din(tmp_data[((iblk+1)*48-1):(iblk*48)]),
    		.o_sum_position(tmp_sum_position_ff[iblk])
	 	);
	 end
endgenerate

// =====================================================================================
// Pipelines for the sum of results from different delay lines
// =====================================================================================
genvar ipipe;
genvar iadder;
generate
    for(ipipe = 0; ipipe < $clog2(NUM_DSP_PER_LINE); ipipe = ipipe + 1) begin : pipeline
        for(iadder = 0; iadder < NUM_DSP_PER_LINE/(2**(ipipe+1)); iadder = iadder + 1) begin : adder
            c_addsub_0 U_ADDER_INST (                                                            
                .A(tmp_sum_position_ff[iadder*2+ipipe*NUM_DSP_PER_LINE]),
                .B(tmp_sum_position_ff[iadder*2+ipipe*NUM_DSP_PER_LINE+1]),
                .CLK(i_clk),
                .S(tmp_sum_position_ff[iadder+(ipipe+1)*NUM_DSP_PER_LINE])
            );
        end  
    end
endgenerate
	 
// Level 2		  
always @(posedge i_clk or posedge i_rst) begin
	if(i_rst)
		o_dout <= 0;
	else 
		o_dout <= tmp_sum_position_ff[$clog2(NUM_DSP_PER_LINE)*NUM_DSP_PER_LINE];
end

`endif

endmodule
