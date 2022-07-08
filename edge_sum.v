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


module edge_sum #(
	parameter INDEX = 0
)(    
	input i_clk,
	input i_rst,
	input [47:0] i_din,
    output reg [15:0] o_sum_position
);

wire [4:0]  sum_position[7:0];
wire [2:0]  num_edge[7:0];
//-----------------------------------------
reg [5:0]   tmp_num_edge_ff1;
reg [5:0]   tmp_num_edge_ff2;
reg [5:0]   tmp_num_edge_ff3;
reg [5:0]   tmp_num_edge_ff4;
reg [7:0]   tmp_sum_pos_ff1;
reg [7:0]   tmp_sum_pos_ff2;
reg [7:0]   tmp_sum_pos_ff3;
reg [7:0]   tmp_sum_pos_ff4;
reg [15:0]  tmp_num_edge_offset[7:0];
reg [15:0]  tmp_num_edge_offset_ff1;
reg [15:0]  tmp_num_edge_offset_ff2;
reg [15:0]  tmp_num_edge_offset_ff3;
reg [15:0]  sum_position_ff1;
reg [15:0]  sum_position_ff2;
//-----------------------------------------

genvar i;
generate 
	for(i = 0; i < 8; i = i + 1) begin	: sub_edge_sum_block
			sub_edge_sum U_SUB_EDGE_SUM_INST(
				.i_clk(i_clk),
				.i_rst(i_rst),
				.i_din(i_din[(i+1)*6-1:i*6]),
				.o_sum_position(sum_position[i]),
				.o_num_edge(num_edge[i])
			);
	end
endgenerate

// Calculating the number of edges in this block
always @(posedge i_clk or posedge i_rst) begin
	if(i_rst) begin
		tmp_num_edge_ff1 <= 0;
	    tmp_num_edge_ff2 <= 0;
	end
	else begin
		tmp_num_edge_ff1 <= (num_edge[0] + num_edge[1]) + (num_edge[2]) + (num_edge[3]);
		tmp_num_edge_ff2 <= (num_edge[4] + num_edge[5]) + (num_edge[6]) + (num_edge[7]);
    end
end 
always @(posedge i_clk or posedge i_rst) begin
	if(i_rst) begin
		tmp_num_edge_ff3 <= 0;
		tmp_num_edge_ff4 <= 0;
	end
	else begin
		tmp_num_edge_ff3 <= tmp_num_edge_ff1 + tmp_num_edge_ff2;
		tmp_num_edge_ff4 <= tmp_num_edge_ff3;
    end
end 

// Calculating the sum of the position of edges
always @(posedge i_clk or posedge i_rst) begin
	if(i_rst) begin
		tmp_sum_pos_ff1 <= 0;
		tmp_sum_pos_ff2 <= 0;
	end 
	else begin
		tmp_sum_pos_ff1 <= ((sum_position[0] + sum_position[1]) +  (sum_position[2] + sum_position[3]));
		tmp_sum_pos_ff2 <= ((sum_position[4] + sum_position[5]) + (sum_position[6] +  sum_position[7]));
	end
end 
always @(posedge i_clk or posedge i_rst) begin
	if(i_rst) begin
		tmp_sum_pos_ff3 <= 0;
		tmp_sum_pos_ff4 <= 0;
	end
	else begin
		tmp_sum_pos_ff3 <= tmp_sum_pos_ff1 + tmp_sum_pos_ff2;
		tmp_sum_pos_ff4 <= tmp_sum_pos_ff3;
	end
end 

/* 
The purpose of the part is to calculate the offset index used for cascading encoders, and the component requires 2-level pipelines to align "tmp_pos_2" and "tmp_num_edg_2"
The "edge_sum" block cannot work correctly without offset indexs. Because, such as suming the position of edges, each block just can sum the edge position range 1 to 48.
For example, two cascaded "edge_sum" blocks total catch 4 edges in 47th, 48th, 95th, 96th respectively. Both first and second encoders output the same result (95), 
while the correct answer shoule be 286 (47 + 48 + 95 + 96). Note: The formula can be expressed as (47 + 48 + ((47 + 48) + 48*2*1)), where "2" is the number of the edges 
caught in second block,and "1" is the block offset index. (The first block index is 0, second one is 1, third one is 2 ...).
Hence, the modified encoder should output (the sum of the edge position) + (the number of the edge * 48 * offset indexs).
*/
always @(posedge i_clk or posedge i_rst) begin
	if(i_rst) begin
		tmp_num_edge_offset[0] <= 0;
		tmp_num_edge_offset[1] <= 0;
		tmp_num_edge_offset[2] <= 0;
		tmp_num_edge_offset[3] <= 0;
		tmp_num_edge_offset[4] <= 0;
		tmp_num_edge_offset[5] <= 0;
		tmp_num_edge_offset[6] <= 0;
		tmp_num_edge_offset[7] <= 0;
	end
	else begin
		tmp_num_edge_offset[0] <= num_edge[0]*0;
		tmp_num_edge_offset[1] <= num_edge[1]*6;
		tmp_num_edge_offset[2] <= num_edge[2]*12;
		tmp_num_edge_offset[3] <= num_edge[3]*18;
		tmp_num_edge_offset[4] <= num_edge[4]*24;
		tmp_num_edge_offset[5] <= num_edge[5]*30;
		tmp_num_edge_offset[6] <= num_edge[6]*36;
		tmp_num_edge_offset[7] <= num_edge[7]*42;
	end		  		
end 

always @(posedge i_clk or posedge i_rst) begin
	if(i_rst) begin
		tmp_num_edge_offset_ff1 <= 0;
		tmp_num_edge_offset_ff2 <= 0;
    end
	else begin
		tmp_num_edge_offset_ff1 <= (tmp_num_edge_offset[0] + tmp_num_edge_offset[1]) + (tmp_num_edge_offset[2] + tmp_num_edge_offset[3]);
		tmp_num_edge_offset_ff2 <= (tmp_num_edge_offset[4] + tmp_num_edge_offset[5]) + (tmp_num_edge_offset[6] + tmp_num_edge_offset[7]);
	end			  		
end 

always @(posedge i_clk or posedge i_rst) begin
	if(i_rst) begin
		tmp_num_edge_offset_ff3 <= 0;
    end
	else begin
		tmp_num_edge_offset_ff3 <= (tmp_num_edge_offset_ff1 + tmp_num_edge_offset_ff2);
	end			  		
end 

always @(posedge i_clk or posedge i_rst) begin 
	if(i_rst) begin
		sum_position_ff1 <= 0;
		sum_position_ff2 <= 0;
    end
	else begin
		sum_position_ff1 <= (tmp_sum_pos_ff4 + tmp_num_edge_offset_ff3);
		sum_position_ff2 <= (tmp_num_edge_ff4*48*INDEX);
	end
end 

// Output
always @(posedge i_clk or posedge i_rst) begin
	if(i_rst)
		o_sum_position <= 0;
	else
		o_sum_position <= sum_position_ff1 + sum_position_ff2;
end 

endmodule
