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
   	parameter NUM_DSP = 16,
   	parameter NUM_CARRY = 192
    )(
    	input clk,	
    	input rst,
//  		input [NUM_CARRY*4-1:0] din,
  		input [NUM_DSP*48-1:0] din,
  		output reg [15:0] dout
	 );

//-------------------------------------------------------------------------------------------------
// Edge detection block
//-------------------------------------------------------------------------------------------------

`ifdef DSP_CHAIN

wire [NUM_DSP*48-1:0] tmp_data;
wire [NUM_DSP*48-1:0] tmp_data1;
wire [NUM_DSP*48-1:0] tmp_data2;

// Detect negative edge
genvar id1;
generate 
	for(id1 = 2; id1 < NUM_DSP*48 - 1; id1 = id1 + 1) begin
		assign tmp_data1[id1] =  ~din[id1-2] & ~din[id1-1] & din[id1] & din[id1+1];
	end
endgenerate

// Detect positive edge
//genvar id2;
//generate 
//	for(id2 = 2; id2 < NUM_DSP*48 - 1; id2 = id2 + 1) begin
//		assign tmp_data2[id2] =  din[id2-2] & din[id2-1] & ~din[id2] & ~din[id2+1];
//	end
//endgenerate

assign tmp_data1[NUM_DSP*48-1:NUM_DSP*48-2] = 0;
assign tmp_data1[0] = {~din[0] & din[1] & din[2] & din[3]} ? 1'b1: 1'b0;
assign tmp_data1[1] = {~din[0] & ~din[1] & din[2] & din[3]} ? 1'b1: 1'b0;
//assign tmp_data1[3] = {~din[0] & ~din[1] & ~din[2] & din[3] & din[4]} ? 1'b1: 1'b0;

//assign tmp_data2[NUM_DSP*48-1:NUM_DSP*48-2] = 0;
//assign tmp_data2[0] = {din[0] & ~din[1] & ~din[2] & ~din[3]} ? 1'b1: 1'b0;
//assign tmp_data2[1] = {din[0] & din[1] & ~din[2] & ~din[3]} ? 1'b1: 1'b0;

assign tmp_data = tmp_data1;

`endif


`ifdef CHARRY_CHAIN

wire [NUM_CARRY*4-1:0] tmp_data;
wire [NUM_CARRY*4-1:0] tmp_data1;
wire [NUM_CARRY*4-1:0] tmp_data2;

genvar id1;
generate 
	for(id1 = 2; id1 < NUM_CARRY*4 - 1; id1 = id1 + 1) begin
		assign tmp_data1[id1] =  din[id1-2] & din[id1-1] & ~din[id1] & ~din[id1+1] ;
	end
endgenerate

genvar id2;
generate 
	for(id2 = 2; id2 < NUM_CARRY*4 - 1; id2 = id2 + 1) begin
		assign tmp_data2[id2] =  ~din[id2-2] & ~din[id2-1] & din[id2] & din[id2+1] ;
	end
endgenerate

assign tmp_data1[(NUM_CARRY*4-1):(NUM_CARRY*4-2)] = 0;
assign tmp_data1[0] = {din[0] & ~din[1] & ~din[2]} ? 1'b1: 1'b0;
assign tmp_data1[1] = {din[0] & din[1] & ~din[2] & ~din[3]} ? 1'b1: 1'b0;


assign tmp_data2[(NUM_CARRY*4-1):(NUM_CARRY*4-2)] = 0;
assign tmp_data2[0] = {~din[0] & din[1] & din[2]} ? 1'b1: 1'b0;
assign tmp_data2[1] = {~din[0] & ~din[1] & din[2] & din[3]} ? 1'b1: 1'b0;

assign tmp_data = tmp_data1 | tmp_data2;

`endif

//-------------------------------------------------------------------------------------------------



//-------------------------------------------------------------------------------------------------
// Encoder
//-------------------------------------------------------------------------------------------------

`ifdef THERMOMETER_ENCODER

wire [(2**DATA_WIDTH)-1:0] tmp[DATA_WIDTH-1:0]; //.....
wire [DATA_WIDTH-1:0] tmp_dout;

genvar i,j;
generate 
	for(i=0; i<DATA_WIDTH-1; i=i+1) 
	begin
		for(j=0; j<(2**(DATA_WIDTH-1-i)-1); j=j+1) 
		begin
			if(i == 0)
				assign tmp[0][j] = din[(2**(DATA_WIDTH-i))/2 - 1] ? din[j+((2**(DATA_WIDTH))/2)] : din[j];
			else
				assign tmp[i][j] = tmp[i-1][(2**(DATA_WIDTH-i))/2 - 1] ? tmp[i-1][j+((2**(DATA_WIDTH-i))/2)] : tmp[i-1][j];
		end
	end
endgenerate

genvar k;
generate 
	for(k=0; k<DATA_WIDTH; k=k+1) 
	begin	
		if(k == DATA_WIDTH-1)
			assign tmp_dout[DATA_WIDTH-1] = din[(2**(DATA_WIDTH))/2 - 1];
		else
			assign tmp_dout[k] = tmp[DATA_WIDTH-1-(k+1)][(2**(k+1))/2 - 1];
	end
endgenerate

always @(posedge clk or posedge rst) begin
	if(rst)
		dout <= 0;
	else 
		dout <= tmp_dout;
end

`endif


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
			_48_6_encoder 
			 #(
					.INDEX(iblk)		 	
	 			)encoder(
					.clk(clk),
			 		.rst(rst),
					.en(1'b1),
					.din(tmp_data[((iblk+1)*48 - 1) : (iblk*48)]),
    				.dout(tmp_ecdr_out[iblk]),
    				.offset(tmp_offset[iblk]),	
	 				.Yen(tmp_yen[iblk]),
	 				.Ynem(tmp_ynem[iblk])
    			);
	end
endgenerate


always @(posedge clk or posedge rst) begin
	if(rst)
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
//		if(tmp_ynem[15]) 
//		   tmp_out <= tmp_offset[15] + tmp_ecdr_out[15];	   
//		else if(tmp_ynem[14])
//			tmp_out <= tmp_offset[14] + tmp_ecdr_out[14]; 
//		else if(tmp_ynem[13])  
//			tmp_out <= tmp_offset[13] + tmp_ecdr_out[13]; 
//	    else if(tmp_ynem[12]) 
//			tmp_out <= tmp_offset[12] + tmp_ecdr_out[12]; 
		if(tmp_ynem[11]) 
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

always @(posedge clk or posedge rst) begin
	if(rst)
		dout <= 0;
	else
	`ifdef CHARRY_CHAIN
	   if(tmp_out >= 376)
	       dout = 0;
	   else 
		   dout = tmp_out;
    `else
       if(tmp_out >= 576)
	       dout = 0;
	   else 
		   dout = tmp_out;
    `endif
end

`endif



`ifdef MULTIEDGE_ENCODER

wire [15:0] tmp_sum_position[NUM_DSP - 1:0];
reg [15:0] dout1;
reg [15:0] dout2;
reg [15:0] dout3;
reg [15:0] dout4;
reg [15:0] dout5;
// Each edge_sum contains 4-level pipelines 
genvar iblk;
generate
	for(iblk = 0; iblk < NUM_DSP; iblk = iblk + 1) begin
 		edge_sum
	 	#(
	  		.INDEX(iblk)
	 	)
	 	edge_sum_inst
	 	(    
			.clk(clk),
			.rst(rst),
			.din(tmp_data[((iblk+1)*48-1):(iblk*48)]),
    		.sum_position(tmp_sum_position[iblk])
	 	);
	 end
endgenerate


// Level 1
always @(posedge clk or posedge rst) begin
	if(rst)
		dout1 <= 0;
	else 
		dout1 <= (tmp_sum_position[0] + tmp_sum_position[1]) + (tmp_sum_position[2] + tmp_sum_position[3]);
end

always @(posedge clk or posedge rst) begin
	if(rst)
		dout2 <= 0;
	else 
		dout2 <= (tmp_sum_position[4] + tmp_sum_position[5]) + (tmp_sum_position[6] + tmp_sum_position[7]);
end

always @(posedge clk or posedge rst) begin
	if(rst)
		dout3 <= 0;
	else 
		dout3 <= (tmp_sum_position[8] + tmp_sum_position[9]) + (tmp_sum_position[10] + tmp_sum_position[11]);
end

always @(posedge clk or posedge rst) begin
	if(rst)
		dout4 <= 0;
	else 
		dout4 <= (tmp_sum_position[12] + tmp_sum_position[13]) + (tmp_sum_position[14] + tmp_sum_position[15]);
end
 
always @(posedge clk or posedge rst) begin
	if(rst)
		dout5 <= 0;
	else 
		dout5 <= (tmp_sum_position[16] + tmp_sum_position[17]) + (tmp_sum_position[18] + tmp_sum_position[19]);
end			
	 
// Level 2		  
always @(posedge clk or posedge rst) begin
	if(rst)
		dout <= 0;
	else 
	   `ifdef CHARRY_CHAIN
	       if(((dout1 + dout2) + (dout3 + dout4) + dout5) >= 2800)
	          dout <= 0;
	       else 
		      dout <= (dout1 + dout2) + (dout3 + dout4) + dout5;
      `else
		      dout <= (dout1 + dout2) + (dout3 + dout4) + dout5;
      `endif

end

`endif

endmodule
