`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/15/2021 08:02:26 PM
// Design Name: 
// Module Name: sub_edge_sum
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


module sub_edge_sum(
	input clk,
	input rst,
	input [5:0] din,
	output reg [4:0] sum_position_tmp,
	output reg [2:0] num_edge_tmp
	);


always @(posedge clk or posedge rst) begin
	if(rst) begin
		sum_position_tmp <= 0;
		num_edge_tmp <= 0;	
	end
	else begin
		sum_position_tmp = din[0]*1 + din[1]*2 + din[2]*3 + din[3]*4 + din[4]*5 + din[5]*6;
		num_edge_tmp = din[0] + din[1] + din[2] + din[3] + din[4] + din[5];
	end
end

endmodule
