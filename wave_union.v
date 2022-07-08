`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/04 22:00:50
// Design Name: 
// Module Name: wave_union
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

(*dont_touch = "true"*)
module wave_union
	#(
		parameter NUM_CARRY4 = 4
	 )(
    	input i_trigger,
    	output o_dout
    );

wire carry4_link[NUM_CARRY4: 0];


assign carry4_link[0] = i_trigger;
assign o_dout = carry4_link[NUM_CARRY4];

genvar icarry;
generate 
    for(icarry = 0; icarry < NUM_CARRY4; icarry = icarry + 1) begin : carry4_index
        if(icarry % 2 == 0) begin
            CARRY4 C0 (
                .CO(carry4_link[icarry+1]),	    // 4bit carry_out
                .CI(0),                         // 4bit carry chain XOR data out 
                .CYINIT(carry4_link[icarry]),   // 1bit carry cascade input     
                .DI(4'b0000),                   // 4bit carry-MUX data in
                .S({3'b111,i_trigger})
            );                                  // 4bit carry MUX select input
        end
        else begin
            CARRY4 C0 (
                .CO(carry4_link[icarry+1]),	    // 4bit carry_out
                .CI(0),                         // 4bit carry chain XOR data out 
                .CYINIT(carry4_link[icarry]),   // 1bit carry cascade input     
                .DI(4'b0001),                   // 4bit carry-MUX data in
                .S({3'b111,i_trigger})
            );                                  // 4bit carry MUX select input
        end 
    end
endgenerate
 
endmodule
