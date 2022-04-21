`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Bristol
// Engineer: Jiajun Lu, Zijie Wang
// 
// Create Date: 08/02/2021 07:03:20 AM
// Design Name: 
// Module Name: edge_sum
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


module edge_sum
	#(
		parameter INDEX = 0
	)(    
		input clk,
		input rst,
		input [47:0] din,
    	output reg [15:0] sum_position
	);


wire [4:0] sum_position_tmp[7:0];
wire [2:0] num_edge_tmp[7:0];
reg [7:0] num_edge_tmp_1[7:0];
reg [9:0] tmp_edg_1;
reg [9:0] tmp_edg_2;
reg [9:0] tmp_edg_buff;
reg [5:0] tmp_num_edg;
reg [5:0] tmp_num_edg_1;
reg [5:0] tmp_num_edg_buff1;
reg [5:0] tmp_num_edg_buff2;
reg [7:0] tmp_pos;
reg [7:0] tmp_pos_1;
reg [7:0] tmp_pos_buff1;
reg [7:0] tmp_pos_buff2;
reg [15:0] sum_position_tmp1;
reg [15:0] sum_position_tmp2;

genvar i;
generate 
	for(i = 0; i < 8; i = i + 1) begin	
			sub_edge_sum ses_inst(
				.clk(clk),
				.rst(rst),
				.din(din[(i+1)*6-1:i*6]),
				.sum_position_tmp(sum_position_tmp[i]),
				.num_edge_tmp(num_edge_tmp[i])
			);
	end
endgenerate


// Calculating the number of edges in this block
always @(posedge clk or posedge rst) begin
	if(rst)
		tmp_num_edg <= 0;
	else
		tmp_num_edg <= (num_edge_tmp[0] + num_edge_tmp[1]) + (num_edge_tmp[2]) + (num_edge_tmp[3]);
end 

always @(posedge clk or posedge rst) begin
	if(rst)
		tmp_num_edg_1 <= 0;
	else
		tmp_num_edg_1 <= (num_edge_tmp[4] + num_edge_tmp[5]) + (num_edge_tmp[6]) + (num_edge_tmp[7]);
end 

always @(posedge clk or posedge rst) begin
	if(rst)
		tmp_num_edg_buff1 <= 0;
	else
		tmp_num_edg_buff1 <= tmp_num_edg + tmp_num_edg_1;
end 

always @(posedge clk or posedge rst) begin
	if(rst)
		tmp_num_edg_buff2 <= 0;
	else
		tmp_num_edg_buff2 <= tmp_num_edg_buff1;
end 

// Calculating the sum of the position of edges
always @(posedge clk or posedge rst) begin
	if(rst)
		tmp_pos <= 0;
	else
		tmp_pos <= ((sum_position_tmp[0] + sum_position_tmp[1]) +  (sum_position_tmp[2] + sum_position_tmp[3]));
end 

always @(posedge clk or posedge rst) begin
	if(rst)
		tmp_pos_1 <= 0;
	else
		tmp_pos_1 <= ((sum_position_tmp[4] +  sum_position_tmp[5]) + (sum_position_tmp[6] +  sum_position_tmp[7]));
end 
 
always @(posedge clk or posedge rst) begin
	if(rst)
		tmp_pos_buff1 <= 0;
	else
		tmp_pos_buff1 <= tmp_pos + tmp_pos_1;
end 

always @(posedge clk or posedge rst) begin
	if(rst)
		tmp_pos_buff2 <= 0;
	else
		tmp_pos_buff2 <= tmp_pos_buff1;
end 


/* 
The purpose of the part is to calculate the offset index used for cascading encoders, and the component requires 2-level pipelines to align "tmp_pos_2" and "tmp_num_edg_2"
The "edge_sum" block cannot work correctly without offset indexs. Because, such as suming the position of edges, each block just can sum the edge position range 1 to 48.
For example, two cascaded "edge_sum" blocks total catch 4 edges in 47th, 48th, 95th, 96th respectively. Both first and second encoders output the same result (95), 
while the correct answer shoule be 286 (47 + 48 + 95 + 96). Note: The formula can be expressed as (47 + 48 + ((47 + 48) + 48*2*1)), where "2" is the number of the edges 
caught in second block,and "1" is the block offset index. (The first block index is 0, second one is 1, third one is 2 ...).
Hence, the modified encoder should output (the sum of the edge position) + (the number of the edge * 48 * offset indexs).
*/

always @(posedge clk or posedge rst) begin
	if(rst) begin
		num_edge_tmp_1[0] <= 0;
		num_edge_tmp_1[1] <= 0;
		num_edge_tmp_1[2] <= 0;
		num_edge_tmp_1[3] <= 0;
		num_edge_tmp_1[4] <= 0;
		num_edge_tmp_1[5] <= 0;
		num_edge_tmp_1[6] <= 0;
		num_edge_tmp_1[7] <= 0;
	end
	else begin
		num_edge_tmp_1[0] <= num_edge_tmp[0]*0;
		num_edge_tmp_1[1] <= num_edge_tmp[1]*6;
		num_edge_tmp_1[2] <= num_edge_tmp[2]*12;
		num_edge_tmp_1[3] <= num_edge_tmp[3]*18;
		num_edge_tmp_1[4] <= num_edge_tmp[4]*24;
		num_edge_tmp_1[5] <= num_edge_tmp[5]*30;
		num_edge_tmp_1[6] <= num_edge_tmp[6]*36;
		num_edge_tmp_1[7] <= num_edge_tmp[7]*42;
	end		  		
end 

always @(posedge clk or posedge rst) begin
	if(rst)
		tmp_edg_1 <= 0;
	else
		tmp_edg_1 <= (num_edge_tmp_1[0] + num_edge_tmp_1[1]) + (num_edge_tmp_1[2] + num_edge_tmp_1[3]);			  		
end 

always @(posedge clk or posedge rst) begin
	if(rst)
		tmp_edg_2 <= 0;
	else
		tmp_edg_2 <= (num_edge_tmp_1[4] + num_edge_tmp_1[5]) + (num_edge_tmp_1[6] + num_edge_tmp_1[7]);			  		
end 

always @(posedge clk or posedge rst) begin
	if(rst)
		tmp_edg_buff <= 0;
	else
		tmp_edg_buff <= tmp_edg_1 + tmp_edg_2;			  		
end 

// Output
always @(posedge clk or posedge rst) begin
	if(rst)
		sum_position_tmp1 <= 0;
	else
		sum_position_tmp1 <= (tmp_pos_buff2 + tmp_edg_buff);
end 

// Output
always @(posedge clk or posedge rst) begin
	if(rst)
		sum_position_tmp2 <= 0;
	else
		sum_position_tmp2 <= (tmp_num_edg_buff2*48*INDEX);
end

// Output
always @(posedge clk or posedge rst) begin
	if(rst)
		sum_position <= 0;
	else
		sum_position <= sum_position_tmp1 + sum_position_tmp2;
end 

endmodule
