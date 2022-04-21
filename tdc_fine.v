`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: The university of Bristol
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

module tdc_fine
	#(
    parameter NUM_DSP = 16,
    parameter NUM_CARRY = 192,
    parameter DATA_WIDTH = 8
)(
    input  clk,
    input  rst,
    input  trigger,
    input  stop,
    input  cali_en,
    output reg [15:0] dout
);
    

`ifdef CHARRY_CHAIN
(*dont_touch = "true"*) reg [NUM_CARRY*4-1:0] 	buff_1;
(*dont_touch = "true"*) reg [NUM_CARRY*4-1:0] 	buff_2;
(*dont_touch = "true"*) reg [NUM_CARRY*4-1:0] 	buff2_1;
(*dont_touch = "true"*) reg [NUM_CARRY*4-1:0] 	buff2_2;
(*dont_touch = "true"*) reg [NUM_CARRY*4-1:0] 	buff3_1;
(*dont_touch = "true"*) reg [NUM_CARRY*4-1:0] 	buff3_2;
(*dont_touch = "true"*) reg [NUM_CARRY*4-1:0] 	buff4_1;
(*dont_touch = "true"*) reg [NUM_CARRY*4-1:0] 	buff4_2;
(*dont_touch = "true"*) reg [NUM_CARRY*4-1:0] 	buff5_1;
(*dont_touch = "true"*) reg [NUM_CARRY*4-1:0] 	buff5_2;
(*dont_touch = "true"*) reg [NUM_CARRY*4-1:0] 	buff6_1;
(*dont_touch = "true"*) reg [NUM_CARRY*4-1:0] 	buff6_2;
(*dont_touch = "true"*) reg [NUM_CARRY*4-1:0] 	buff7_1;
(*dont_touch = "true"*) reg [NUM_CARRY*4-1:0] 	buff7_2;
(*dont_touch = "true"*) reg [NUM_CARRY*4-1:0] 	buff8_1;
(*dont_touch = "true"*) reg [NUM_CARRY*4-1:0] 	buff8_2;
(*dont_touch = "true"*) reg [NUM_CARRY*4-1:0] 	buff9_1;
(*dont_touch = "true"*) reg [NUM_CARRY*4-1:0] 	buff9_2;
(*dont_touch = "true"*) reg [NUM_CARRY*4-1:0] 	buff10_1;
(*dont_touch = "true"*) reg [NUM_CARRY*4-1:0] 	buff10_2;
(*dont_touch = "true"*) reg [NUM_CARRY*4-1:0] 	buff11_1;
(*dont_touch = "true"*) reg [NUM_CARRY*4-1:0] 	buff11_2;
(*dont_touch = "true"*) reg [NUM_CARRY*4-1:0] 	buff12_1;
(*dont_touch = "true"*) reg [NUM_CARRY*4-1:0] 	buff12_2;

 wire [NUM_CARRY*4-1:0] dout_tmp1;
 wire [NUM_CARRY*4-1:0] carry_chain1;
 wire [NUM_CARRY*4-1:0] dout_tmp2;
 wire [NUM_CARRY*4-1:0] carry_chain2;
 wire [NUM_CARRY*4-1:0] dout_tmp3;
 wire [NUM_CARRY*4-1:0] carry_chain3;
 wire [NUM_CARRY*4-1:0] dout_tmp4;
 wire [NUM_CARRY*4-1:0] carry_chain4;
 wire [NUM_CARRY*4-1:0] dout_tmp5;
 wire [NUM_CARRY*4-1:0] carry_chain5;
 wire [NUM_CARRY*4-1:0] dout_tmp6;
 wire [NUM_CARRY*4-1:0] carry_chain6;
 wire [NUM_CARRY*4-1:0] dout_tmp7;
 wire [NUM_CARRY*4-1:0] carry_chain7;
 wire [NUM_CARRY*4-1:0] dout_tmp8;
 wire [NUM_CARRY*4-1:0] carry_chain8;
 wire [NUM_CARRY*4-1:0] dout_tmp9;
 wire [NUM_CARRY*4-1:0] carry_chain9;
 wire [NUM_CARRY*4-1:0] dout_tmp10;
 wire [NUM_CARRY*4-1:0] carry_chain10;
 wire [NUM_CARRY*4-1:0] dout_tmp11;
 wire [NUM_CARRY*4-1:0] carry_chain11;
 wire [NUM_CARRY*4-1:0] dout_tmp12;
 wire [NUM_CARRY*4-1:0] carry_chain12;
`endif

`ifdef DSP_CHAIN
    (*dont_touch = "true"*) reg  [NUM_DSP*48 - 1:0] 	buff_1;
    (*dont_touch = "true"*) reg  [NUM_DSP*48 - 1:0] 	buff_2;
    (*dont_touch = "true"*) reg  [NUM_DSP*48 - 1:0] 	buff2_1;
    (*dont_touch = "true"*) reg  [NUM_DSP*48 - 1:0] 	buff2_2;
    (*dont_touch = "true"*) reg  [NUM_DSP*48 - 1:0] 	buff3_1;
    (*dont_touch = "true"*) reg  [NUM_DSP*48 - 1:0] 	buff3_2;
    (*dont_touch = "true"*) reg  [NUM_DSP*48 - 1:0] 	buff4_1;
    (*dont_touch = "true"*) reg  [NUM_DSP*48 - 1:0] 	buff4_2;
    (*dont_touch = "true"*) reg  [NUM_DSP*48 - 1:0] 	buff5_1;
    (*dont_touch = "true"*) reg  [NUM_DSP*48 - 1:0] 	buff5_2;
    (*dont_touch = "true"*) reg  [NUM_DSP*48 - 1:0] 	buff6_1;
    (*dont_touch = "true"*) reg  [NUM_DSP*48 - 1:0] 	buff6_2;
    (*dont_touch = "true"*) reg  [NUM_DSP*48 - 1:0] 	buff7_1;
    (*dont_touch = "true"*) reg  [NUM_DSP*48 - 1:0] 	buff7_2;
    (*dont_touch = "true"*) reg  [NUM_DSP*48 - 1:0] 	buff8_1;
    (*dont_touch = "true"*) reg  [NUM_DSP*48 - 1:0] 	buff8_2;
     (*dont_touch = "true"*) reg  [NUM_DSP*48 - 1:0] 	buff9_1;
    (*dont_touch = "true"*) reg  [NUM_DSP*48 - 1:0] 	buff9_2;
    (*dont_touch = "true"*) reg  [NUM_DSP*48 - 1:0] 	buff10_1;
    (*dont_touch = "true"*) reg  [NUM_DSP*48 - 1:0] 	buff10_2;
    (*dont_touch = "true"*) reg  [NUM_DSP*48 - 1:0] 	buff11_1;
    (*dont_touch = "true"*) reg  [NUM_DSP*48 - 1:0] 	buff11_2;
    (*dont_touch = "true"*) reg  [NUM_DSP*48 - 1:0] 	buff12_1;
    (*dont_touch = "true"*) reg  [NUM_DSP*48 - 1:0] 	buff12_2;
    (*dont_touch = "true"*) wire [NUM_DSP*48 - 1:0] 	carry_chain;
    (*dont_touch = "true"*) wire [NUM_DSP - 1:0] 		carry_cas;
    (*dont_touch = "true"*) wire [NUM_DSP*48 - 1:0] 	carry_chain2;
    (*dont_touch = "true"*) wire [NUM_DSP - 1:0] 		carry_cas2;
    (*dont_touch = "true"*) wire [NUM_DSP*48 - 1:0] 	carry_chain3;
    (*dont_touch = "true"*) wire [NUM_DSP - 1:0] 		carry_cas3;
    (*dont_touch = "true"*) wire [NUM_DSP*48 - 1:0] 	carry_chain4;
    (*dont_touch = "true"*) wire [NUM_DSP - 1:0] 		carry_cas4;
    (*dont_touch = "true"*) wire [NUM_DSP*48 - 1:0] 	carry_chain5;
    (*dont_touch = "true"*) wire [NUM_DSP - 1:0] 		carry_cas5;
    (*dont_touch = "true"*) wire [NUM_DSP*48 - 1:0] 	carry_chain6;
    (*dont_touch = "true"*) wire [NUM_DSP - 1:0] 		carry_cas6;
    (*dont_touch = "true"*) wire [NUM_DSP*48 - 1:0] 	carry_chain7;
    (*dont_touch = "true"*) wire [NUM_DSP - 1:0] 		carry_cas7;
    (*dont_touch = "true"*) wire [NUM_DSP*48 - 1:0] 	carry_chain8;
    (*dont_touch = "true"*) wire [NUM_DSP - 1:0] 		carry_cas8;
    (*dont_touch = "true"*) wire [NUM_DSP*48 - 1:0] 	carry_chain9;
    (*dont_touch = "true"*) wire [NUM_DSP - 1:0] 		carry_cas9;
    (*dont_touch = "true"*) wire [NUM_DSP*48 - 1:0] 	carry_chain10;
    (*dont_touch = "true"*) wire [NUM_DSP - 1:0] 		carry_cas10;
    (*dont_touch = "true"*) wire [NUM_DSP*48 - 1:0] 	carry_chain11;
    (*dont_touch = "true"*) wire [NUM_DSP - 1:0] 		carry_cas11;
    (*dont_touch = "true"*) wire [NUM_DSP*48 - 1:0] 	carry_chain12;
    (*dont_touch = "true"*) wire [NUM_DSP - 1:0] 		carry_cas12;
`endif


    wire [3:0] trigger_out;
    wire [3:0] trigger_out1;
    wire [3:0] trigger_out2;
    wire [3:0] trigger_out3;
    wire [3:0] trigger_out4;
    wire [3:0] trigger_out5;
    wire [3:0] trigger_out6;
    wire [3:0] trigger_out7;
    wire [3:0] trigger_out8;
    wire [3:0] trigger_out9;
    wire [3:0] trigger_out10;
    wire [3:0] trigger_out11;
    wire [3:0] trigger_out12;
    wire [3:0] trigger_out13;
    wire [3:0] trigger_out14;
    wire [3:0] trigger_out15;
    wire [3:0] trigger_out16;
    wire [3:0] trigger_out17;
    wire [3:0] trigger_out18;
    wire [3:0] trigger_out19;
    wire [3:0] trigger_out20;
    wire [3:0] trigger_out21;
    wire [3:0] trigger_out22;
    wire [3:0] trigger_out23;
    wire [3:0] trigger_out24;
    wire [3:0] trigger_out25;
    wire [3:0] trigger_out26;
    wire [3:0] trigger_out27;
    wire [3:0] trigger_out28;
    
    wire [15:0] dout1;
    wire [15:0] dout2;
    wire [15:0] dout3;
    wire [15:0] dout4;
    wire [15:0] dout5;
    wire [15:0] dout6;
    wire [15:0] dout7;
    wire [15:0] dout8;
    wire [15:0] dout9;
    wire [15:0] dout10;
    wire [15:0] dout11;
    wire [15:0] dout12;
    reg [15:0] doutf1;
    reg [15:0] doutf2;
    reg [15:0] doutf3;


`ifdef WAVE_UNION
	wave_union
    #(
    .NUM(16)
    )
    wave_union_inst
    (
        .trigger(trigger),
        .dout(trigger_out)
    );

`endif


/*
	The DATA_WIDTH is the width of output data. For example, we want to reach counting up to 15 (4 bit) 
*/

`ifdef CHARRY_CHAIN

 //Insert delay in different delay lines
//--------------------------------------------------------------------				
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst1 (
		.O(trigger_out1[3]), // LUT general output
		.I0(trigger) // LUT input
	);
	
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst2 (
		.O(trigger_out2[3]), // LUT general output
		.I0(trigger_out1[3]) // LUT input
	);
//--------------------------------------------------------------------				
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst3 (
		.O(trigger_out3[3]), // LUT general output
		.I0(trigger_out2[3]) // LUT input
	);
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst4 (
		.O(trigger_out4[3]), // LUT general output
		.I0(trigger_out3[3]) // LUT input
	);			
//--------------------------------------------------------------------	
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst5 (
		.O(trigger_out5[3]), // LUT general output
		.I0(trigger_out4[3]) // LUT input
	);
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst6 (
		.O(trigger_out6[3]), // LUT general output
		.I0(trigger_out5[3]) // LUT input
	);		
//--------------------------------------------------------------------
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst7 (
		.O(trigger_out7[3]), // LUT general output
		.I0(trigger_out6[3]) // LUT input
	);
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst8 (
		.O(trigger_out8[3]), // LUT general output
		.I0(trigger_out7[3]) // LUT input
	);
	//--------------------------------------------------------------------				
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst9 (
		.O(trigger_out9[3]), // LUT general output
		.I0(trigger_out8[3]) // LUT input
	);
	
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst10 (
		.O(trigger_out10[3]), // LUT general output
		.I0(trigger_out9[3]) // LUT input
	);
//--------------------------------------------------------------------				
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst11 (
		.O(trigger_out11[3]), // LUT general output
		.I0(trigger_out10[3]) // LUT input
	);
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst12 (
		.O(trigger_out12[3]), // LUT general output
		.I0(trigger_out11[3]) // LUT input
	);			
//--------------------------------------------------------------------	
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst13 (
		.O(trigger_out13[3]), // LUT general output
		.I0(trigger_out12[3]) // LUT input
	);
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst14 (
		.O(trigger_out14[3]), // LUT general output
		.I0(trigger_out13[3]) // LUT input
	);		
//--------------------------------------------------------------------
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst15 (
		.O(trigger_out15[3]), // LUT general output
		.I0(trigger_out14[3]) // LUT input
	);
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst16 (
		.O(trigger_out16[3]), // LUT general output
		.I0(trigger_out15[3]) // LUT input		
	);
//--------------------------------------------------------------------	
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst17 (
		.O(trigger_out17[3]), // LUT general output
		.I0(trigger_out16[3]) // LUT input
	);
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst18 (
		.O(trigger_out18[3]), // LUT general output
		.I0(trigger_out17[3]) // LUT input
	);		
//--------------------------------------------------------------------
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst19 (
		.O(trigger_out20[3]), // LUT general output
		.I0(trigger_out19[3]) // LUT input
	);
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst20 (
		.O(trigger_out20[3]), // LUT general output
		.I0(trigger_out19[3]) // LUT input		
	);
//(2^DATA_WIDTH - 2^2) A CARRY4 includes 4 outputs, and connects them into encoder as input that can be transform 2 bit  output for 8421 code.

// First delay line 
genvar ic;
generate
	for(ic = 0; ic < NUM_CARRY; ic = ic + 1) 
	begin
		if(ic == 0)
			CARRY4 CARRY4_inst(
				.CO(carry_chain1[3:0]),	// 4bit carry_out
				.CI(0),  // 4bit carry chain XOR data out 
				.CYINIT(buff10_1), // 1bit carry cascade input 
				.DI(0), // 4bit carry-MUX data in
				.S(4'b1111)); // 4bit carry MUX select input
		else
			CARRY4 CARRY4_inst(
				.CO(carry_chain1[ic*4+3:ic*4]),	// 4bit carry_out
				.CI(carry_chain1[ic*4-1]),  // 4bit carry chain XOR data out 
				.CYINIT(0), // 1bit carry cascade input 
				.DI(0), // 4bit carry-MUX data in
				.S(4'b1111)); // 4bit carry MUX select input
	end
endgenerate 


genvar iff1; // The index of flip flops (iff)
generate 
	for(iff1 = 0; iff1 < NUM_CARRY*4; iff1 = iff1 + 1) 
	begin
	
		always @(posedge clk or posedge rst) 
		begin
			if(rst) 
				buff_1[iff1] <= 0;
			else 
				if(stop)
					buff_1[iff1] <= carry_chain1[iff1];
				else		
					buff_1[iff1] <= 0;
		end
	end
endgenerate

genvar iff2;
generate 
	for(iff2 = 0; iff2 < NUM_CARRY*4; iff2 = iff2 + 1) 
	begin
		always @(posedge clk or posedge rst) 
		begin
			if(rst) 
				buff_2[iff2] <= 0;
			else 				
				buff_2[iff2] <= buff_1[iff2];
		end
	end
endgenerate





//// Second delay line 
//genvar ic2;
//generate
//	for(ic2 = 0; ic2 < NUM_CARRY; ic2 = ic2 + 1) 
//	begin
//		if(ic2 == 0)
//			CARRY4 CARRY4_inst(
//				.CO(carry_chain2[3:0]),	// 4bit carry_out
//				.CI(0),  // 4bit carry chain XOR data out 
//				.CYINIT(trigger_out1[3]), // 1bit carry cascade input 
//				.DI(0), // 4bit carry-MUX data in
//				.S(4'b1111)); // 4bit carry MUX select input
//		else
//			CARRY4 CARRY4_inst(
//				.CO(carry_chain2[ic2*4+3:ic2*4]),	// 4bit carry_out
//				.CI(carry_chain2[ic2*4-1]),  // 4bit carry chain XOR data out 
//				.CYINIT(0), // 1bit carry cascade input 
//				.DI(0), // 4bit carry-MUX data in
//				.S(4'b1111)); // 4bit carry MUX select input
//	end
//endgenerate 

//genvar iff2_1; // The index of flip flops (iff)
//generate 
//	for(iff2_1 = 0; iff2_1 < NUM_CARRY*4; iff2_1 = iff2_1 + 1) 
//	begin
//		always @(posedge clk or posedge rst) 
//		begin
//			if(rst) 
//				buff2_1[iff2_1] <= 0;
//			else 
//				if(stop)
//					buff2_1[iff2_1] <= carry_chain2[iff2_1];
//				else		
//					buff2_1[iff2_1] <= 0;
//		end
//	end
//endgenerate

//genvar iff2_2;
//generate 
//	for(iff2_2 = 0; iff2_2 < NUM_CARRY*4; iff2_2 = iff2_2 + 1) 
//	begin
//		always @(posedge clk or posedge rst) 
//		begin
//			if(rst) 
//				buff2_2[iff2_2] <= 0;
//			else 				
//				buff2_2[iff2_2] <= buff2_1[iff2_2];
//		end
//	end
//endgenerate


//// Third delay line 
//genvar ic3;
//generate
//	for(ic3 = 0; ic3 < NUM_CARRY; ic3 = ic3 + 1) 
//	begin
//		if(ic3 == 0)
//			CARRY4 CARRY4_inst(
//				.CO(carry_chain3[3:0]),	// 4bit carry_out
//				.CI(0),  // 4bit carry chain XOR data out 
//				.CYINIT(trigger_out2[3]), // 1bit carry cascade input 
//				.DI(0), // 4bit carry-MUX data in
//				.S(4'b1111)); // 4bit carry MUX select input
//		else
//			CARRY4 CARRY4_inst(
//				.CO(carry_chain3[ic3*4+3:ic3*4]),	// 4bit carry_out
//				.CI(carry_chain3[ic3*4-1]),  // 4bit carry chain XOR data out 
//				.CYINIT(0), // 1bit carry cascade input 
//				.DI(0), // 4bit carry-MUX data in
//				.S(4'b1111)); // 4bit carry MUX select input
//	end
//endgenerate 

//genvar iff3_1; // The index of flip flops (iff)
//generate 
//	for(iff3_1 = 0; iff3_1 < NUM_CARRY*4; iff3_1 = iff3_1 + 1) 
//	begin
//		always @(posedge clk or posedge rst) 
//		begin
//			if(rst) 
//				buff3_1[iff3_1] <= 0;
//			else 
//				if(stop)
//					buff3_1[iff3_1] <= carry_chain3[iff3_1];
//				else		
//					buff3_1[iff3_1] <= 0;
//		end
//	end
//endgenerate

//genvar iff3_2;
//generate 
//	for(iff3_2 = 0; iff3_2 < NUM_CARRY*4; iff3_2 = iff3_2 + 1) 
//	begin
//		always @(posedge clk or posedge rst) 
//		begin
//			if(rst) 
//				buff3_2[iff3_2] <= 0;
//			else 				
//				buff3_2[iff3_2] <= buff3_1[iff3_2];
//		end
//	end
//endgenerate


//// Fourth delay line
//genvar ic4;
//generate
//	for(ic4 = 0; ic4 < NUM_CARRY; ic4 = ic4 + 1) 
//	begin
//		if(ic4 == 0)
//			CARRY4 CARRY4_inst(
//				.CO(carry_chain4[3:0]),	// 4bit carry_out
//				.CI(0),  // 4bit carry chain XOR data out 
//				.CYINIT(trigger_out3[3]), // 1bit carry cascade input 
//				.DI(0), // 4bit carry-MUX data in
//				.S(4'b1111)); // 4bit carry MUX select input
//		else
//			CARRY4 CARRY4_inst(
//				.CO(carry_chain4[ic4*4+3:ic4*4]),	// 4bit carry_out
//				.CI(carry_chain4[ic4*4-1]),  // 4bit carry chain XOR data out 
//				.CYINIT(0), // 1bit carry cascade input 
//				.DI(0), // 4bit carry-MUX data in
//				.S(4'b1111)); // 4bit carry MUX select input
//	end
//endgenerate 

//genvar iff4_1; // The index of flip flops (iff)
//generate 
//	for(iff4_1 = 0; iff4_1 < NUM_CARRY*4; iff4_1 = iff4_1 + 1) 
//	begin
//		always @(posedge clk or posedge rst) 
//		begin
//			if(rst) 
//				buff4_1[iff4_1] <= 0;
//			else 
//				if(stop)
//					buff4_1[iff4_1] <= carry_chain4[iff4_1];
//				else		
//					buff4_1[iff4_1] <= 0;
//		end
//	end
//endgenerate

//genvar iff4_2;
//generate 
//	for(iff4_2 = 0; iff4_2 < NUM_CARRY*4; iff4_2 = iff4_2 + 1) 
//	begin
//		always @(posedge clk or posedge rst) 
//		begin
//			if(rst) 
//				buff4_2[iff4_2] <= 0;
//			else 				
//				buff4_2[iff4_2] <= buff4_1[iff4_2];
//		end
//	end
//endgenerate


//// Fifth delay line
//genvar ic5;
//generate
//	for(ic5 = 0; ic5 < NUM_CARRY; ic5 = ic5 + 1) 
//	begin
//		if(ic5 == 0)
//			CARRY4 CARRY4_inst(
//				.CO(carry_chain5[3:0]),	// 4bit carry_out
//				.CI(0),  // 4bit carry chain XOR data out 
//				.CYINIT(trigger_out4[3]), // 1bit carry cascade input 
//				.DI(0), // 4bit carry-MUX data in
//				.S(4'b1111)); // 4bit carry MUX select input
//		else
//			CARRY4 CARRY4_inst(
//				.CO(carry_chain5[ic5*4+3:ic5*4]),	// 4bit carry_out
//				.CI(carry_chain5[ic5*4-1]),  // 4bit carry chain XOR data out 
//				.CYINIT(0), // 1bit carry cascade input 
//				.DI(0), // 4bit carry-MUX data in
//				.S(4'b1111)); // 4bit carry MUX select input
//	end
//endgenerate 

//genvar iff5_1; // The index of flip flops (iff)
//generate 
//	for(iff5_1 = 0; iff5_1 < NUM_CARRY*4; iff5_1 = iff5_1 + 1) 
//	begin
//		always @(posedge clk or posedge rst) 
//		begin
//			if(rst) 
//				buff5_1[iff5_1] <= 0;
//			else 
//				if(stop)
//					buff5_1[iff5_1] <= carry_chain5[iff5_1];
//				else		
//					buff5_1[iff5_1] <= 0;
//		end
//	end
//endgenerate

//genvar iff5_2;
//generate 
//	for(iff5_2 = 0; iff5_2 < NUM_CARRY*4; iff5_2 = iff5_2 + 1) 
//	begin
//		always @(posedge clk or posedge rst) 
//		begin
//			if(rst) 
//				buff5_2[iff5_2] <= 0;
//			else 				
//				buff5_2[iff5_2] <= buff5_1[iff5_2];
//		end
//	end
//endgenerate


//// Sixth delay line
//genvar ic6;
//generate
//	for(ic6 = 0; ic6 < NUM_CARRY; ic6 = ic6 + 1) 
//	begin
//		if(ic6 == 0)
//			CARRY4 CARRY4_inst(
//				.CO(carry_chain6[3:0]),	// 4bit carry_out
//				.CI(0),  // 4bit carry chain XOR data out 
//				.CYINIT(trigger_out5[3]), // 1bit carry cascade input 
//				.DI(0), // 4bit carry-MUX data in
//				.S(4'b1111)); // 4bit carry MUX select input
//		else
//			CARRY4 CARRY4_inst(
//				.CO(carry_chain6[ic6*4+3:ic6*4]),	// 4bit carry_out
//				.CI(carry_chain6[ic6*4-1]),  // 4bit carry chain XOR data out 
//				.CYINIT(0), // 1bit carry cascade input 
//				.DI(0), // 4bit carry-MUX data in
//				.S(4'b1111)); // 4bit carry MUX select input
//	end
//endgenerate 

//genvar iff6_1; // The index of flip flops (iff)
//generate 
//	for(iff6_1 = 0; iff6_1 < NUM_CARRY*4; iff6_1 = iff6_1 + 1) 
//	begin
//		always @(posedge clk or posedge rst) 
//		begin
//			if(rst) 
//				buff6_1[iff6_1] <= 0;
//			else 
//				if(stop)
//					buff6_1[iff6_1] <= carry_chain6[iff6_1];
//				else		
//					buff6_1[iff6_1] <= 0;
//		end
//	end
//endgenerate

//genvar iff6_2;
//generate 
//	for(iff6_2 = 0; iff6_2 < NUM_CARRY*4; iff6_2 = iff6_2 + 1) 
//	begin
//		always @(posedge clk or posedge rst) 
//		begin
//			if(rst) 
//				buff6_2[iff6_2] <= 0;
//			else 				
//				buff6_2[iff6_2] <= buff6_1[iff6_2];
//		end
//	end
//endgenerate


//// Seventh delay line
//genvar ic7;
//generate
//	for(ic7 = 0; ic7 < NUM_CARRY; ic7 = ic7 + 1) 
//	begin
//		if(ic7 == 0)
//			CARRY4 CARRY4_inst(
//				.CO(carry_chain7[3:0]),	// 4bit carry_out
//				.CI(0),  // 4bit carry chain XOR data out 
//				.CYINIT(trigger_out6[3]), // 1bit carry cascade input 
//				.DI(0), // 4bit carry-MUX data in
//				.S(4'b1111)); // 4bit carry MUX select input
//		else
//			CARRY4 CARRY4_inst(
//				.CO(carry_chain7[ic7*4+3:ic7*4]),	// 4bit carry_out
//				.CI(carry_chain7[ic7*4-1]),  // 4bit carry chain XOR data out 
//				.CYINIT(0), // 1bit carry cascade input 
//				.DI(0), // 4bit carry-MUX data in
//				.S(4'b1111)); // 4bit carry MUX select input
//	end
//endgenerate 

//genvar iff7_1; // The index of flip flops (iff)
//generate 
//	for(iff7_1 = 0; iff7_1 < NUM_CARRY*4; iff7_1 = iff7_1 + 1) 
//	begin
//		always @(posedge clk or posedge rst) 
//		begin
//			if(rst) 
//				buff7_1[iff7_1] <= 0;
//			else 
//				if(stop)
//					buff7_1[iff7_1] <= carry_chain7[iff7_1];
//				else		
//					buff7_1[iff7_1] <= 0;
//		end
//	end
//endgenerate

//genvar iff7_2;
//generate 
//	for(iff7_2 = 0; iff7_2 < NUM_CARRY*4; iff7_2 = iff7_2 + 1) 
//	begin
//		always @(posedge clk or posedge rst) 
//		begin
//			if(rst) 
//				buff7_2[iff7_2] <= 0;
//			else 				
//				buff7_2[iff7_2] <= buff7_1[iff7_2];
//		end
//	end
//endgenerate

//// 8th delay line
//genvar ic8;
//generate
//	for(ic8 = 0; ic8 < NUM_CARRY; ic8 = ic8 + 1) 
//	begin
//		if(ic8 == 0)
//			CARRY4 CARRY4_inst(
//				.CO(carry_chain8[3:0]),	// 4bit carry_out
//				.CI(0),  // 4bit carry chain XOR data out 
//				.CYINIT(trigger_out7[3]), // 1bit carry cascade input 
//				.DI(0), // 4bit carry-MUX data in
//				.S(4'b1111)); // 4bit carry MUX select input
//		else
//			CARRY4 CARRY4_inst(
//				.CO(carry_chain8[ic8*4+3:ic8*4]),	// 4bit carry_out
//				.CI(carry_chain8[ic8*4-1]),  // 4bit carry chain XOR data out 
//				.CYINIT(0), // 1bit carry cascade input 
//				.DI(0), // 4bit carry-MUX data in
//				.S(4'b1111)); // 4bit carry MUX select input
//	end
//endgenerate 

//genvar iff8_1; // The index of flip flops (iff)
//generate 
//	for(iff8_1 = 0; iff8_1 < NUM_CARRY*4; iff8_1 = iff8_1 + 1) 
//	begin
//		always @(posedge clk or posedge rst) 
//		begin
//			if(rst) 
//				buff8_1[iff8_1] <= 0;
//			else 
//				if(stop)
//					buff8_1[iff8_1] <= carry_chain8[iff8_1];
//				else		
//					buff8_1[iff8_1] <= 0;
//		end
//	end
//endgenerate

//genvar iff8_2;
//generate 
//	for(iff8_2 = 0; iff8_2 < NUM_CARRY*4; iff8_2 = iff8_2 + 1) 
//	begin
//		always @(posedge clk or posedge rst) 
//		begin
//			if(rst) 
//				buff8_2[iff8_2] <= 0;
//			else 				
//				buff8_2[iff8_2] <= buff8_1[iff8_2];
//		end
//	end
//endgenerate



//// 9th delay line
//genvar ic9;
//generate
//	for(ic9 = 0; ic9 < NUM_CARRY; ic9 = ic9 + 1) 
//	begin
//		if(ic9 == 0)
//			CARRY4 CARRY4_inst(
//				.CO(carry_chain9[3:0]),	// 4bit carry_out
//				.CI(0),  // 4bit carry chain XOR data out 
//				.CYINIT(trigger_out8[3]), // 1bit carry cascade input 
//				.DI(0), // 4bit carry-MUX data in
//				.S(4'b1111)); // 4bit carry MUX select input
//		else
//			CARRY4 CARRY4_inst(
//				.CO(carry_chain9[ic9*4+3:ic9*4]),	// 4bit carry_out
//				.CI(carry_chain9[ic9*4-1]),  // 4bit carry chain XOR data out 
//				.CYINIT(0), // 1bit carry cascade input 
//				.DI(0), // 4bit carry-MUX data in
//				.S(4'b1111)); // 4bit carry MUX select input
//	end
//endgenerate 

//genvar iff9_1; // The index of flip flops (iff)
//generate 
//	for(iff9_1 = 0; iff9_1 < NUM_CARRY*4; iff9_1 = iff9_1 + 1) 
//	begin
//		always @(posedge clk or posedge rst) 
//		begin
//			if(rst) 
//				buff9_1[iff9_1] <= 0;
//			else 
//				if(stop)
//					buff9_1[iff9_1] <= carry_chain9[iff9_1];
//				else		
//					buff9_1[iff9_1] <= 0;
//		end
//	end
//endgenerate

//genvar iff9_2;
//generate 
//	for(iff9_2 = 0; iff9_2 < NUM_CARRY*4; iff9_2 = iff9_2 + 1) 
//	begin
//		always @(posedge clk or posedge rst) 
//		begin
//			if(rst) 
//				buff9_2[iff9_2] <= 0;
//			else 				
//				buff9_2[iff9_2] <= buff9_1[iff9_2];
//		end
//	end
//endgenerate


//// 10th delay line
//genvar ic10;
//generate
//	for(ic10 = 0; ic10 < NUM_CARRY; ic10 = ic10 + 1) 
//	begin
//		if(ic10 == 0)
//			CARRY4 CARRY4_inst(
//				.CO(carry_chain10[3:0]),	// 4bit carry_out
//				.CI(0),  // 4bit carry chain XOR data out 
//				.CYINIT(trigger_out9[3]), // 1bit carry cascade input 
//				.DI(0), // 4bit carry-MUX data in
//				.S(4'b1111)); // 4bit carry MUX select input
//		else
//			CARRY4 CARRY4_inst(
//				.CO(carry_chain10[ic10*4+3:ic10*4]),	// 4bit carry_out
//				.CI(carry_chain10[ic10*4-1]),  // 4bit carry chain XOR data out 
//				.CYINIT(0), // 1bit carry cascade input 
//				.DI(0), // 4bit carry-MUX data in
//				.S(4'b1111)); // 4bit carry MUX select input
//	end
//endgenerate 

//genvar iff10_1; // The index of flip flops (iff)
//generate 
//	for(iff10_1 = 0; iff10_1 < NUM_CARRY*4; iff10_1 = iff10_1 + 1) 
//	begin
//		always @(posedge clk or posedge rst) 
//		begin
//			if(rst) 
//				buff10_1[iff10_1] <= 0;
//			else 
//				if(stop)
//					buff10_1[iff10_1] <= carry_chain10[iff10_1];
//				else		
//					buff10_1[iff10_1] <= 0;
//		end
//	end
//endgenerate

//genvar iff10_2;
//generate 
//	for(iff10_2 = 0; iff10_2 < NUM_CARRY*4; iff10_2 = iff10_2 + 1) 
//	begin
//		always @(posedge clk or posedge rst) 
//		begin
//			if(rst) 
//				buff10_2[iff10_2] <= 0;
//			else 				
//				buff10_2[iff10_2] <= buff10_1[iff10_2];
//		end
//	end
//endgenerate

//// 11th delay line
//genvar ic11;
//generate
//	for(ic11 = 0; ic11 < NUM_CARRY; ic11 = ic11 + 1) 
//	begin
//		if(ic11 == 0)
//			CARRY4 CARRY4_inst(
//				.CO(carry_chain11[3:0]),	// 4bit carry_out
//				.CI(0),  // 4bit carry chain XOR data out 
//				.CYINIT(trigger_out10[3]), // 1bit carry cascade input 
//				.DI(0), // 4bit carry-MUX data in
//				.S(4'b1111)); // 4bit carry MUX select input
//		else
//			CARRY4 CARRY4_inst(
//				.CO(carry_chain11[ic11*4+3:ic11*4]),	// 4bit carry_out
//				.CI(carry_chain11[ic11*4-1]),  // 4bit carry chain XOR data out 
//				.CYINIT(0), // 1bit carry cascade input 
//				.DI(0), // 4bit carry-MUX data in
//				.S(4'b1111)); // 4bit carry MUX select input
//	end
//endgenerate 

//genvar iff11_1; // The index of flip flops (iff)
//generate 
//	for(iff11_1 = 0; iff11_1 < NUM_CARRY*4; iff11_1 = iff11_1 + 1) 
//	begin
//		always @(posedge clk or posedge rst) 
//		begin
//			if(rst) 
//				buff11_1[iff11_1] <= 0;
//			else 
//				if(stop)
//					buff11_1[iff11_1] <= carry_chain11[iff11_1];
//				else		
//					buff11_1[iff11_1] <= 0;
//		end
//	end
//endgenerate

//genvar iff11_2;
//generate 
//	for(iff11_2 = 0; iff11_2 < NUM_CARRY*4; iff11_2 = iff11_2 + 1) 
//	begin
//		always @(posedge clk or posedge rst) 
//		begin
//			if(rst) 
//				buff11_2[iff11_2] <= 0;
//			else 				
//				buff11_2[iff11_2] <= buff11_1[iff11_2];
//		end
//	end
//endgenerate


//// 12th delay line
//genvar ic12;
//generate
//	for(ic12 = 0; ic12 < NUM_CARRY; ic12 = ic12 + 1) 
//	begin
//		if(ic12 == 0)
//			CARRY4 CARRY4_inst(
//				.CO(carry_chain12[3:0]),	// 4bit carry_out
//				.CI(0),  // 4bit carry chain XOR data out 
//				.CYINIT(trigger_out11[3]), // 1bit carry cascade input 
//				.DI(0), // 4bit carry-MUX data in
//				.S(4'b1111)); // 4bit carry MUX select input
//		else
//			CARRY4 CARRY4_inst(
//				.CO(carry_chain12[ic12*4+3:ic12*4]),	// 4bit carry_out
//				.CI(carry_chain12[ic12*4-1]),  // 4bit carry chain XOR data out 
//				.CYINIT(0), // 1bit carry cascade input 
//				.DI(0), // 4bit carry-MUX data in
//				.S(4'b1111)); // 4bit carry MUX select input
//	end
//endgenerate 

//genvar iff12_1; // The index of flip flops (iff)
//generate 
//	for(iff12_1 = 0; iff12_1 < NUM_CARRY*4; iff12_1 = iff12_1 + 1) 
//	begin
//		always @(posedge clk or posedge rst) 
//		begin
//			if(rst) 
//				buff12_1[iff12_1] <= 0;
//			else 
//				if(stop)
//					buff12_1[iff12_1] <= carry_chain12[iff12_1];
//				else		
//					buff12_1[iff12_1] <= 0;
//		end
//	end
//endgenerate

//genvar iff12_2;
//generate 
//	for(iff12_2 = 0; iff12_2 < NUM_CARRY*4; iff12_2 = iff12_2 + 1) 
//	begin
//		always @(posedge clk or posedge rst) 
//		begin
//			if(rst) 
//				buff12_2[iff12_2] <= 0;
//			else 				
//				buff12_2[iff12_2] <= buff12_1[iff12_2];
//		end
//	end
//endgenerate
`endif





`ifdef DSP_CHAIN 

// Insert delay in different delay lines for multi-delay lines
    // If use wave union + single delay line, we can connect trigger_out signal to delay line directly.
    // 1st--------------------------------------------------------------------
   /* 
    CARRY4 CARRY4_inst1(
        .CO(trigger_out1[3:0]), // 4bit carry_out
        .CI(0), // 4bit carry chain XOR data out 
        .CYINIT(trigger), // 1bit carry cascade input 
        .DI(0), // 4bit carry-MUX data in
        .S(4'b1111)); // 4bit carry MUX select input

    CARRY4 CARRY4_inst2(
        .CO(trigger_out2[3:0]), // 4bit carry_out
        .CI(trigger_out1[3]), // 4bit carry chain XOR data out 
        .CYINIT(0), // 1bit carry cascade input 
        .DI(0), // 4bit carry-MUX data in
        .S(4'b1111)); // 4bit carry MUX select input
    // 2rd--------------------------------------------------------------------				
    CARRY4 CARRY4_inst3(
        .CO(trigger_out3[3:0]), // 4bit carry_out
        .CI(trigger_out2[3]), // 4bit carry chain XOR data out 
        .CYINIT(0), // 1bit carry cascade input 
        .DI(0), // 4bit carry-MUX data in
        .S(4'b1111)); // 4bit carry MUX select input

    CARRY4 CARRY4_inst4(
        .CO(trigger_out4[3:0]), // 4bit carry_out
        .CI(trigger_out3[3]), // 4bit carry chain XOR data out 
        .CYINIT(0), // 1bit carry cascade input 
        .DI(0), // 4bit carry-MUX data in
        .S(4'b1111)); // 4bit carry MUX select input

    // 3nd--------------------------------------------------------------------	
    CARRY4 CARRY4_inst5(
        .CO(trigger_out5[3:0]), // 4bit carry_out
        .CI(trigger_out4[3]), // 4bit carry chain XOR data out 
        .CYINIT(0), // 1bit carry cascade input 
        .DI(0), // 4bit carry-MUX data in
        .S(4'b1111)); // 4bit carry MUX select input

    CARRY4 CARRY4_inst6(
        .CO(trigger_out6[3:0]), // 4bit carry_out
        .CI(trigger_out5[3]), // 4bit carry chain XOR data out 
        .CYINIT(0), // 1bit carry cascade input 
        .DI(0), // 4bit carry-MUX data in
        .S(4'b1111)); // 4bit carry MUX select input
    // 4th--------------------------------------------------------------------		
    CARRY4 CARRY4_inst7(
        .CO(trigger_out7[3:0]), // 4bit carry_out
        .CI(trigger_out6[3]), // 4bit carry chain XOR data out 
        .CYINIT(0), // 1bit carry cascade input 
        .DI(0), // 4bit carry-MUX data in
        .S(4'b1111)); // 4bit carry MUX select input

    CARRY4 CARRY4_inst8(
        .CO(trigger_out8[3:0]), // 4bit carry_out
        .CI(trigger_out7[3]), // 4bit carry chain XOR data out 
        .CYINIT(0), // 1bit carry cascade input 
        .DI(0), // 4bit carry-MUX data in
        .S(4'b1111)); // 4bit carry MUX select input
    // 5th--------------------------------------------------------------------		
    CARRY4 CARRY4_inst9(
        .CO(trigger_out9[3:0]), // 4bit carry_out
        .CI(trigger_out8[3]), // 4bit carry chain XOR data out 
        .CYINIT(0), // 1bit carry cascade input 
        .DI(0), // 4bit carry-MUX data in
        .S(4'b1111)); // 4bit carry MUX select input

    CARRY4 CARRY4_inst10(
        .CO(trigger_out10[3:0]), // 4bit carry_out
        .CI(trigger_out9[3]), // 4bit carry chain XOR data out 
        .CYINIT(0), // 1bit carry cascade input 
        .DI(0), // 4bit carry-MUX data in
        .S(4'b1111)); // 4bit carry MUX select input
    // 6th--------------------------------------------------------------------		
    CARRY4 CARRY4_inst11(
        .CO(trigger_out11[3:0]), // 4bit carry_out
        .CI(trigger_out10[3]), // 4bit carry chain XOR data out 
        .CYINIT(0), // 1bit carry cascade input 
        .DI(0), // 4bit carry-MUX data in
        .S(4'b1111)); // 4bit carry MUX select input

    CARRY4 CARRY4_inst12(
        .CO(trigger_out12[3:0]), // 4bit carry_out
        .CI(trigger_out11[3]), // 4bit carry chain XOR data out 
        .CYINIT(0), // 1bit carry cascade input 
        .DI(0), // 4bit carry-MUX data in
        .S(4'b1111)); // 4bit carry MUX select input				
    // 7th--------------------------------------------------------------------		
    CARRY4 CARRY4_inst13(
        .CO(trigger_out13[3:0]), // 4bit carry_out
        .CI(trigger_out12[3]), // 4bit carry chain XOR data out 
        .CYINIT(0), // 1bit carry cascade input 
        .DI(0), // 4bit carry-MUX data in
        .S(4'b1111)); // 4bit carry MUX select input

    CARRY4 CARRY4_inst14(
        .CO(trigger_out14[3:0]), // 4bit carry_out
        .CI(trigger_out13[3]), // 4bit carry chain XOR data out 
        .CYINIT(0), // 1bit carry cascade input 
        .DI(0), // 4bit carry-MUX data in
        .S(4'b1111)); // 4bit carry MUX select input	
    // 8th--------------------------------------------------------------------		
    CARRY4 CARRY4_inst15(
        .CO(trigger_out15[3:0]), // 4bit carry_out
        .CI(trigger_out14[3]), // 4bit carry chain XOR data out 
        .CYINIT(0), // 1bit carry cascade input 
        .DI(0), // 4bit carry-MUX data in
        .S(4'b1111)); // 4bit carry MUX select input

    CARRY4 CARRY4_inst16(
        .CO(trigger_out16[3:0]), // 4bit carry_out
        .CI(trigger_out15[3]), // 4bit carry chain XOR data out 
        .CYINIT(0), // 1bit carry cascade input 
        .DI(0), // 4bit carry-MUX data in
        .S(4'b1111)); // 4bit carry MUX select input				
    // 9th--------------------------------------------------------------------		
    CARRY4 CARRY4_inst17(
        .CO(trigger_out17[3:0]), // 4bit carry_out
        .CI(trigger_out16[3]), // 4bit carry chain XOR data out 
        .CYINIT(0), // 1bit carry cascade input 
        .DI(0), // 4bit carry-MUX data in
        .S(4'b1111)); // 4bit carry MUX select input

    CARRY4 CARRY4_inst18(
        .CO(trigger_out18[3:0]), // 4bit carry_out
        .CI(trigger_out17[3]), // 4bit carry chain XOR data out 
        .CYINIT(0), // 1bit carry cascade input 
        .DI(0), // 4bit carry-MUX data in
        .S(4'b1111)); // 4bit carry MUX select input	
    // 10th--------------------------------------------------------------------		
    CARRY4 CARRY4_inst19(
        .CO(trigger_out19[3:0]), // 4bit carry_out
        .CI(trigger_out18[3]), // 4bit carry chain XOR data out 
        .CYINIT(0), // 1bit carry cascade input 
        .DI(0), // 4bit carry-MUX data in
        .S(4'b1111)); // 4bit carry MUX select input

    CARRY4 CARRY4_inst20(
        .CO(trigger_out20[3:0]), // 4bit carry_out
        .CI(trigger_out19[3]), // 4bit carry chain XOR data out 
        .CYINIT(0), // 1bit carry cascade input 
        .DI(0), // 4bit carry-MUX data in
        .S(4'b1111)); // 4bit carry MUX select input				
    // 11th--------------------------------------------------------------------		
    CARRY4 CARRY4_inst21(
        .CO(trigger_out21[3:0]), // 4bit carry_out
        .CI(trigger_out20[3]), // 4bit carry chain XOR data out 
        .CYINIT(0), // 1bit carry cascade input 
        .DI(0), // 4bit carry-MUX data in
        .S(4'b1111)); // 4bit carry MUX select input

    CARRY4 CARRY4_inst22(
        .CO(trigger_out22[3:0]), // 4bit carry_out
        .CI(trigger_out21[3]), // 4bit carry chain XOR data out 
        .CYINIT(0), // 1bit carry cascade input 
        .DI(0), // 4bit carry-MUX data in
        .S(4'b1111)); // 4bit carry MUX select input	
    // 12th--------------------------------------------------------------------		
    CARRY4 CARRY4_inst23(
        .CO(trigger_out23[3:0]), // 4bit carry_out
        .CI(trigger_out22[3]), // 4bit carry chain XOR data out 
        .CYINIT(0), // 1bit carry cascade input 
        .DI(0), // 4bit carry-MUX data in
        .S(4'b1111)); // 4bit carry MUX select input

    CARRY4 CARRY4_inst24(
        .CO(trigger_out24[3:0]), // 4bit carry_out
        .CI(trigger_out23[3]), // 4bit carry chain XOR data out 
        .CYINIT(0), // 1bit carry cascade input 
        .DI(0), // 4bit carry-MUX data in
        .S(4'b1111)); // 4bit carry MUX select input	
*/
//--------------------------------------------------------------------				
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst1 (
		.O(trigger_out1[3]), // LUT general output
		.I0(trigger) // LUT input
	);
	
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst2 (
		.O(trigger_out2[3]), // LUT general output
		.I0(trigger_out1[3]) // LUT input
	);
//--------------------------------------------------------------------				
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst3 (
		.O(trigger_out3[3]), // LUT general output
		.I0(trigger_out2[3]) // LUT input
	);
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst4 (
		.O(trigger_out4[3]), // LUT general output
		.I0(trigger_out3[3]) // LUT input
	);			
//--------------------------------------------------------------------	
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst5 (
		.O(trigger_out5[3]), // LUT general output
		.I0(trigger_out4[3]) // LUT input
	);
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst6 (
		.O(trigger_out6[3]), // LUT general output
		.I0(trigger_out5[3]) // LUT input
	);		
//--------------------------------------------------------------------
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst7 (
		.O(trigger_out7[3]), // LUT general output
		.I0(trigger_out6[3]) // LUT input
	);
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst8 (
		.O(trigger_out8[3]), // LUT general output
		.I0(trigger_out7[3]) // LUT input
	);
	//--------------------------------------------------------------------				
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst9 (
		.O(trigger_out9[3]), // LUT general output
		.I0(trigger_out8[3]) // LUT input
	);
	
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst10 (
		.O(trigger_out10[3]), // LUT general output
		.I0(trigger_out9[3]) // LUT input
	);
//--------------------------------------------------------------------				
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst11 (
		.O(trigger_out11[3]), // LUT general output
		.I0(trigger_out10[3]) // LUT input
	);
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst12 (
		.O(trigger_out12[3]), // LUT general output
		.I0(trigger_out11[3]) // LUT input
	);			
//--------------------------------------------------------------------	
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst13 (
		.O(trigger_out13[3]), // LUT general output
		.I0(trigger_out12[3]) // LUT input
	);
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst14 (
		.O(trigger_out14[3]), // LUT general output
		.I0(trigger_out13[3]) // LUT input
	);		
//--------------------------------------------------------------------
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst15 (
		.O(trigger_out15[3]), // LUT general output
		.I0(trigger_out14[3]) // LUT input
	);
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst16 (
		.O(trigger_out16[3]), // LUT general output
		.I0(trigger_out15[3]) // LUT input		
	);
//--------------------------------------------------------------------	
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst17 (
		.O(trigger_out17[3]), // LUT general output
		.I0(trigger_out16[3]) // LUT input
	);
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst18 (
		.O(trigger_out18[3]), // LUT general output
		.I0(trigger_out17[3]) // LUT input
	);		
//--------------------------------------------------------------------
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst19 (
		.O(trigger_out19[3]), // LUT general output
		.I0(trigger_out18[3]) // LUT input
	);
	LUT1 #(
		.INIT(2'b10) // Specify LUT Contents
	) LUT1_inst20 (
		.O(trigger_out20[3]), // LUT general output
		.I0(trigger_out19[3]) // LUT input		
	);

    // First Delay line
    genvar idsp;
    generate
        for(idsp = 0; idsp < NUM_DSP; idsp = idsp + 1)
        begin
            if(idsp == 0)
                xbip_dsp48_macro_1 your_instance_name
                (
                    .CARRYIN(trigger), // input wire CARRYIN
                    .C({48{1'b1}}), // input wire [47 : 0] C
                    .CARRYCASCOUT(carry_cas[idsp]), // output wire CARRYCASCOUT
                    .P(carry_chain[(idsp+1)*48-1:0]) // output wire [47 : 0] P
                );
            else
                xbip_dsp48_macro_0 your_instance_name
                (
                    .CARRYCASCIN(carry_cas[idsp-1]), // input wire CARRYCASCIN
                    .C({48{1'b1}}), // input wire [47 : 0] C
                    .CARRYOUT(0), // output wire CARRYOUT
                    .CARRYCASCOUT(carry_cas[idsp]), // output wire CARRYCASCOUT
                    .P(carry_chain[(idsp+1)*48-1:(idsp)*48]) // output wire [47 : 0] P
                );
        end
    endgenerate

    genvar iff1; // The index of flip flops (iff)
    generate
        for(iff1 = 0; iff1 < NUM_DSP*48; iff1 = iff1 + 1)
        begin
            always @(posedge clk or posedge rst)
            begin
                if(rst)
                    buff_1[iff1] <= 0;
                else
                    if(stop)
                        buff_1[iff1] <= carry_chain[iff1];
                    else
                        buff_1[iff1] <= 0;
            end
        end
    endgenerate

    genvar iff2;
    generate
        for(iff2 = 0; iff2 < NUM_DSP*48; iff2 = iff2 + 1)
        begin
            always @(posedge clk or posedge rst)
            begin
                if(rst)
                    buff_2[iff2] <= 0;
                else
                    buff_2[iff2] <= buff_1[iff2];
            end
        end
    endgenerate

 

    // Second Delay line
    genvar idsp2;
    generate
        for(idsp2 = 0; idsp2 < NUM_DSP; idsp2 = idsp2 + 1)
        begin
            if(idsp2 == 0)
                xbip_dsp48_macro_1
                (
                    .CARRYIN(trigger_out3[3]), // input wire CARRYIN
                    .C({48{1'b1}}), // input wire [47 : 0] C
                    .CARRYCASCOUT(carry_cas2[idsp2]), // output wire CARRYCASCOUT
                    .P(carry_chain2[(idsp2+1)*48-1:0]) // output wire [47 : 0] P
                );
            else
                xbip_dsp48_macro_0
                (
                    .CARRYCASCIN(carry_cas2[idsp2-1]), // input wire CARRYCASCIN
                    .C({48{1'b1}}), // input wire [47 : 0] C
                    .CARRYOUT(0), // output wire CARRYOUT
                    .CARRYCASCOUT(carry_cas2[idsp2]), // output wire CARRYCASCOUT
                    .P(carry_chain2[(idsp2+1)*48-1:(idsp2)*48]) // output wire [47 : 0] P
                );
        end
    endgenerate

    genvar iff2_1; // The index of flip flops (iff)
    generate
        for(iff2_1 = 0; iff2_1 < NUM_DSP*48; iff2_1 = iff2_1 + 1)
        begin
            always @(posedge clk or posedge rst)
            begin
                if(rst)
                    buff2_1[iff2_1] <= 0;
                else
                    if(stop)
                        buff2_1[iff2_1] <= carry_chain2[iff2_1];
                    else
                        buff2_1[iff2_1] <= 0;
            end
        end
    endgenerate

    genvar iff2_2;
    generate
        for(iff2_2 = 0; iff2_2 < NUM_DSP*48; iff2_2 = iff2_2 + 1)
        begin
            always @(posedge clk or posedge rst)
            begin
                if(rst)
                    buff2_2[iff2_2] <= 0;
                else
                    buff2_2[iff2_2] <= buff2_1[iff2_2];
            end
        end
    endgenerate

    // Third Delay line
    genvar idsp3;
    generate
        for(idsp3 = 0; idsp3 < NUM_DSP; idsp3 = idsp3 + 1)
        begin
            if(idsp3 == 0)
                xbip_dsp48_macro_1
                (
                    .CARRYIN(trigger_out6[3]), // input wire CARRYIN
                    .C({48{1'b1}}), // input wire [47 : 0] C
                    .CARRYCASCOUT(carry_cas3[idsp3]), // output wire CARRYCASCOUT
                    .P(carry_chain3[(idsp3+1)*48-1:0]) // output wire [47 : 0] P
                );
            else
                xbip_dsp48_macro_0
                (
                    .CARRYCASCIN(carry_cas3[idsp3-1]), // input wire CARRYCASCIN
                    .C({48{1'b1}}), // input wire [47 : 0] C
                    .CARRYOUT(0), // output wire CARRYOUT
                    .CARRYCASCOUT(carry_cas3[idsp3]), // output wire CARRYCASCOUT
                    .P(carry_chain3[(idsp3+1)*48-1:(idsp3)*48]) // output wire [47 : 0] P
                );
        end
    endgenerate

    genvar iff3_1; // The index of flip flops (iff)
    generate
        for(iff3_1 = 0; iff3_1 < NUM_DSP*48; iff3_1 = iff3_1 + 1)
        begin
            always @(posedge clk or posedge rst)
            begin
                if(rst)
                    buff3_1[iff3_1] <= 0;
                else
                    if(stop)
                        buff3_1[iff3_1] <= carry_chain3[iff3_1];
                    else
                        buff3_1[iff3_1] <= 0;
            end
        end
    endgenerate

    genvar iff3_2;
    generate
        for(iff3_2 = 0; iff3_2 < NUM_DSP*48; iff3_2 = iff3_2 + 1)
        begin
            always @(posedge clk or posedge rst)
            begin
                if(rst)
                    buff3_2[iff3_2] <= 0;
                else
                    buff3_2[iff3_2] <= buff3_1[iff3_2];
            end
        end
    endgenerate


    // Fourth Delay line
    genvar idsp4;
    generate
        for(idsp4 = 0; idsp4 < NUM_DSP; idsp4 = idsp4 + 1)
        begin
            if(idsp4 == 0)
                xbip_dsp48_macro_1
                (
                    .CARRYIN(trigger_out9[3]), // input wire CARRYIN
                    .C({48{1'b1}}), // input wire [47 : 0] C
                    .CARRYCASCOUT(carry_cas4[idsp4]), // output wire CARRYCASCOUT
                    .P(carry_chain4[(idsp4+1)*48-1:0]) // output wire [47 : 0] P
                );
            else
                xbip_dsp48_macro_0
                (
                    .CARRYCASCIN(carry_cas4[idsp4-1]), // input wire CARRYCASCIN
                    .C({48{1'b1}}), // input wire [47 : 0] C
                    .CARRYOUT(0), // output wire CARRYOUT
                    .CARRYCASCOUT(carry_cas4[idsp4]), // output wire CARRYCASCOUT
                    .P(carry_chain4[(idsp4+1)*48-1:(idsp4)*48]) // output wire [47 : 0] P
                );
        end
    endgenerate

    genvar iff4_1; // The index of flip flops (iff)
    generate
        for(iff4_1 = 0; iff4_1 < NUM_DSP*48; iff4_1 = iff4_1 + 1)
        begin
            always @(posedge clk or posedge rst)
            begin
                if(rst)
                    buff4_1[iff4_1] <= 0;
                else
                    if(stop)
                        buff4_1[iff4_1] <= carry_chain4[iff4_1];
                    else
                        buff4_1[iff4_1] <= 0;
            end
        end
    endgenerate

    genvar iff4_2;
    generate
        for(iff4_2 = 0; iff4_2 < NUM_DSP*48; iff4_2 = iff4_2 + 1)
        begin
            always @(posedge clk or posedge rst)
            begin
                if(rst)
                    buff4_2[iff4_2] <= 0;
                else
                    buff4_2[iff4_2] <= buff4_1[iff4_2];
            end
        end
    endgenerate


    // Fifth Delay line
    genvar idsp5;
    generate 
    	for(idsp5 = 0; idsp5 < NUM_DSP; idsp5 = idsp5 + 1) 
    	begin
    		if(idsp5 == 0)			 			 				
    			xbip_dsp48_macro_1
    				(
     				 .CARRYIN(trigger_out12[3]),            // input wire CARRYIN
      				 .C({48{1'b1}}),                        // input wire [47 : 0] C
                     .CARRYCASCOUT(carry_cas5[idsp5]),  // output wire CARRYCASCOUT
                     .P(carry_chain5[(idsp5+1)*48-1:0])                        // output wire [47 : 0] P
    			   );
    		else	
    			xbip_dsp48_macro_0
    				(
     				 .CARRYCASCIN(carry_cas5[idsp5-1]),    // input wire CARRYCASCIN
     				 .C({48{1'b1}}),                        // input wire [47 : 0] C
      				 .CARRYOUT(0),          // output wire CARRYOUT
      				 .CARRYCASCOUT(carry_cas5[idsp5]),  // output wire CARRYCASCOUT
      				 .P(carry_chain5[(idsp5+1)*48-1:(idsp5)*48])                        // output wire [47 : 0] P
    				);				
    	end
    endgenerate 

    genvar iff5_1; // The index of flip flops (iff)
    generate 
    	for(iff5_1 = 0; iff5_1 < NUM_DSP*48; iff5_1 = iff5_1 + 1) 
    	begin
    		always @(posedge clk or posedge rst) 
    		begin
    			if(rst) 
    				buff5_1[iff5_1] <= 0;
    			else 
    				if(stop)
    					buff5_1[iff5_1] <= carry_chain5[iff5_1];
    				else		
    					buff5_1[iff5_1] <= 0;
    		end
    	end
    endgenerate

    genvar iff5_2;
    generate 
    	for(iff5_2 = 0; iff5_2 < NUM_DSP*48; iff5_2 = iff5_2 + 1) 
    	begin
    		always @(posedge clk or posedge rst) 
    		begin
    			if(rst) 
    				buff5_2[iff5_2] <= 0;
    			else 				
    				buff5_2[iff5_2] <= buff5_1[iff5_2];
    		end
    	end
    endgenerate

    // Sixth Delay line
    genvar idsp6;
    generate 
    	for(idsp6 = 0; idsp6 < NUM_DSP; idsp6 = idsp6 + 1) 
    	begin
    		if(idsp6 == 0)			 			 				
    			xbip_dsp48_macro_1
    				(
     				 .CARRYIN(trigger_out14[3]),            // input wire CARRYIN
      				 .C({48{1'b1}}),                        // input wire [47 : 0] C
                     .CARRYCASCOUT(carry_cas6[idsp6]),  // output wire CARRYCASCOUT
                     .P(carry_chain6[(idsp6+1)*48-1:0])                        // output wire [47 : 0] P
    			   );
    		else	
    			xbip_dsp48_macro_0
    				(
     				 .CARRYCASCIN(carry_cas6[idsp6-1]),    // input wire CARRYCASCIN
     				 .C({48{1'b1}}),                        // input wire [47 : 0] C
      				 .CARRYOUT(0),          // output wire CARRYOUT
      				 .CARRYCASCOUT(carry_cas6[idsp6]),  // output wire CARRYCASCOUT
      				 .P(carry_chain6[(idsp6+1)*48-1:(idsp6)*48])                        // output wire [47 : 0] P
    				);				
    	end
    endgenerate 

    genvar iff6_1; // The index of flip flops (iff)
    generate 
    	for(iff6_1 = 0; iff6_1 < NUM_DSP*48; iff6_1 = iff6_1 + 1) 
    	begin
    		always @(posedge clk or posedge rst) 
    		begin
    			if(rst) 
    				buff6_1[iff6_1] <= 0;
    			else 
    				if(stop)
    					buff6_1[iff6_1] <= carry_chain6[iff6_1];
    				else		
    					buff6_1[iff6_1] <= 0;
    		end
    	end
    endgenerate

    genvar iff6_2;
    generate 
    	for(iff6_2 = 0; iff6_2 < NUM_DSP*48; iff6_2 = iff6_2 + 1) 
    	begin
    		always @(posedge clk or posedge rst) 
    		begin
    			if(rst) 
    				buff6_2[iff6_2] <= 0;
    			else 				
    				buff6_2[iff6_2] <= buff6_1[iff6_2];
    		end
    	end
    endgenerate

    // Seventh Delay line
    genvar idsp7;
    generate 
    	for(idsp7 = 0; idsp7 < NUM_DSP; idsp7 = idsp7 + 1) 
    	begin
    		if(idsp7 == 0)			 			 				
    			xbip_dsp48_macro_1
    				(
     				 .CARRYIN(trigger_out17[3]),            // input wire CARRYIN
      				 .C({48{1'b1}}),                        // input wire [47 : 0] C
                     .CARRYCASCOUT(carry_cas7[idsp7]),  // output wire CARRYCASCOUT
                     .P(carry_chain7[(idsp7+1)*48-1:0])                        // output wire [47 : 0] P
    			   );
    		else	
    			xbip_dsp48_macro_0
    				(
     				 .CARRYCASCIN(carry_cas7[idsp7-1]),    // input wire CARRYCASCIN
     				 .C({48{1'b1}}),                        // input wire [47 : 0] C
      				 .CARRYOUT(0),          // output wire CARRYOUT
      				 .CARRYCASCOUT(carry_cas7[idsp7]),  // output wire CARRYCASCOUT
      				 .P(carry_chain7[(idsp7+1)*48-1:(idsp7)*48])                        // output wire [47 : 0] P
    				);				
    	end
    endgenerate 

    genvar iff7_1; // The index of flip flops (iff)
    generate 
    	for(iff7_1 = 0; iff7_1 < NUM_DSP*48; iff7_1 = iff7_1 + 1) 
    	begin
    		always @(posedge clk or posedge rst) 
    		begin
    			if(rst) 
    				buff7_1[iff7_1] <= 0;
    			else 
    				if(stop)
    					buff7_1[iff7_1] <= carry_chain7[iff7_1];
    				else		
    					buff7_1[iff7_1] <= 0;
    		end
    	end
    endgenerate

    genvar iff7_2;
    generate 
    	for(iff7_2 = 0; iff7_2 < NUM_DSP*48; iff7_2 = iff7_2 + 1) 
    	begin
    		always @(posedge clk or posedge rst) 
    		begin
    			if(rst) 
    				buff7_2[iff7_2] <= 0;
    			else 				
    				buff7_2[iff7_2] <= buff7_1[iff7_2];
    		end
    	end
    endgenerate

    // Eight Delay line
    genvar idsp8;
    generate 
    	for(idsp8 = 0; idsp8 < NUM_DSP; idsp8 = idsp8 + 1) 
    	begin
    		if(idsp8 == 0)			 			 				
    			xbip_dsp48_macro_1
    				(
     				 .CARRYIN(trigger_out20[3]),            // input wire CARRYIN
      				 .C({48{1'b1}}),                        // input wire [47 : 0] C
                     .CARRYCASCOUT(carry_cas8[idsp8]),  // output wire CARRYCASCOUT
                     .P(carry_chain8[(idsp8+1)*48-1:0])                        // output wire [47 : 0] P
    			   );
    		else	
    			xbip_dsp48_macro_0
    				(
     				 .CARRYCASCIN(carry_cas8[idsp8-1]),    // input wire CARRYCASCIN
     				 .C({48{1'b1}}),                        // input wire [47 : 0] C
      				 .CARRYOUT(0),          // output wire CARRYOUT
      				 .CARRYCASCOUT(carry_cas8[idsp8]),  // output wire CARRYCASCOUT
      				 .P(carry_chain8[(idsp8+1)*48-1:(idsp8)*48])                        // output wire [47 : 0] P
    				);				
    	end
    endgenerate 

    genvar iff8_1; // The index of flip flops (iff)
    generate 
    	for(iff8_1 = 0; iff8_1 < NUM_DSP*48; iff8_1 = iff8_1 + 1) 
    	begin
    		always @(posedge clk or posedge rst) 
    		begin
    			if(rst) 
    				buff8_1[iff8_1] <= 0;
    			else 
    				if(stop)
    					buff8_1[iff8_1] <= carry_chain8[iff8_1];
    				else		
    					buff8_1[iff8_1] <= 0;
    		end
    	end
    endgenerate

    genvar iff8_2;
    generate 
    	for(iff8_2 = 0; iff8_2 < NUM_DSP*48; iff8_2 = iff8_2 + 1) 
    	begin
    		always @(posedge clk or posedge rst) 
    		begin
    			if(rst) 
    				buff8_2[iff8_2] <= 0;
    			else 				
    				buff8_2[iff8_2] <= buff8_1[iff8_2];
    		end
    	end
    endgenerate

   
/*  
    // 9th Delay line
    genvar idsp9;
    generate 
    	for(idsp9 = 0; idsp9 < NUM_DSP; idsp9 = idsp9 + 1) 
    	begin
    		if(idsp9 == 0)			 			 				
    			xbip_dsp48_macro_1
    				(
     				 .CARRYIN(trigger_out8[3]),            // input wire CARRYIN
      				 .C({48{1'b1}}),                        // input wire [47 : 0] C
                     .CARRYCASCOUT(carry_cas9[idsp9]),  // output wire CARRYCASCOUT
                     .P(carry_chain9[(idsp9+1)*48-1:0])                        // output wire [47 : 0] P
    			   );
    		else	
    			xbip_dsp48_macro_0
    				(
     				 .CARRYCASCIN(carry_cas9[idsp9-1]),    // input wire CARRYCASCIN
     				 .C({48{1'b1}}),                        // input wire [47 : 0] C
      				 .CARRYOUT(0),          // output wire CARRYOUT
      				 .CARRYCASCOUT(carry_cas9[idsp9]),  // output wire CARRYCASCOUT
      				 .P(carry_chain9[(idsp9+1)*48-1:(idsp9)*48])                        // output wire [47 : 0] P
    				);				
    	end
    endgenerate 

    genvar iff9_1; // The index of flip flops (iff)
    generate 
    	for(iff9_1 = 0; iff9_1 < NUM_DSP*48; iff9_1 = iff9_1 + 1) 
    	begin
    		always @(posedge clk or posedge rst) 
    		begin
    			if(rst) 
    				buff9_1[iff9_1] <= 0;
    			else 
    				if(stop)
    					buff9_1[iff9_1] <= carry_chain9[iff9_1];
    				else		
    					buff9_1[iff9_1] <= 0;
    		end
    	end
    endgenerate

    genvar iff9_2;
    generate 
    	for(iff9_2 = 0; iff9_2 < NUM_DSP*48; iff9_2 = iff9_2 + 1) 
    	begin
    		always @(posedge clk or posedge rst) 
    		begin
    			if(rst) 
    				buff9_2[iff9_2] <= 0;
    			else 				
    				buff9_2[iff9_2] <= buff9_1[iff9_2];
    		end
    	end
    endgenerate
    
    // 10th Delay line
    genvar idsp10;
    generate 
    	for(idsp10 = 0; idsp10 < NUM_DSP; idsp10 = idsp10 + 1) 
    	begin
    		if(idsp10 == 0)			 			 				
    			xbip_dsp48_macro_1
    				(
     				 .CARRYIN(trigger_out9[3]),            // input wire CARRYIN
      				 .C({48{1'b1}}),                        // input wire [47 : 0] C
                     .CARRYCASCOUT(carry_cas10[idsp10]),  // output wire CARRYCASCOUT
                     .P(carry_chain10[(idsp10+1)*48-1:0])                        // output wire [47 : 0] P
    			   );
    		else	
    			xbip_dsp48_macro_0
    				(
     				 .CARRYCASCIN(carry_cas10[idsp10-1]),    // input wire CARRYCASCIN
     				 .C({48{1'b1}}),                        // input wire [47 : 0] C
      				 .CARRYOUT(0),          // output wire CARRYOUT
      				 .CARRYCASCOUT(carry_cas10[idsp10]),  // output wire CARRYCASCOUT
      				 .P(carry_chain10[(idsp10+1)*48-1:(idsp10)*48])                        // output wire [47 : 0] P
    				);				
    	end
    endgenerate 
    
    genvar iff10_1; // The index of flip flops (iff)
    generate 
    	for(iff10_1 = 0; iff10_1 < NUM_DSP*48; iff10_1 = iff10_1 + 1) 
    	begin
    		always @(posedge clk or posedge rst) 
    		begin
    			if(rst) 
    				buff10_1[iff10_1] <= 0;
    			else 
    				if(stop)
    					buff10_1[iff10_1] <= carry_chain10[iff10_1];
    				else		
    					buff10_1[iff10_1] <= 0;
    		end
    	end
    endgenerate

    genvar iff10_2;
    generate 
    	for(iff10_2 = 0; iff10_2 < NUM_DSP*48; iff10_2 = iff10_2 + 1) 
    	begin
    		always @(posedge clk or posedge rst) 
    		begin
    			if(rst) 
    				buff10_2[iff10_2] <= 0;
    			else 				
    				buff10_2[iff10_2] <= buff10_1[iff10_2];
    		end
    	end
    endgenerate


    // 11th Delay line
    genvar idsp11;
    generate 
    	for(idsp11 = 0; idsp11 < NUM_DSP; idsp11 = idsp11 + 1) 
    	begin
    		if(idsp11 == 0)			 			 				
    			xbip_dsp48_macro_1
    				(
     				 .CARRYIN(trigger_out10[3]),            // input wire CARRYIN
      				 .C({48{1'b1}}),                        // input wire [47 : 0] C
                     .CARRYCASCOUT(carry_cas11[idsp11]),  // output wire CARRYCASCOUT
                     .P(carry_chain11[(idsp11+1)*48-1:0])                        // output wire [47 : 0] P
    			   );
    		else	
    			xbip_dsp48_macro_0
    				(
     				 .CARRYCASCIN(carry_cas11[idsp11-1]),    // input wire CARRYCASCIN
     				 .C({48{1'b1}}),                        // input wire [47 : 0] C
      				 .CARRYOUT(0),          // output wire CARRYOUT
      				 .CARRYCASCOUT(carry_cas11[idsp11]),  // output wire CARRYCASCOUT
      				 .P(carry_chain11[(idsp11+1)*48-1:(idsp11)*48])                        // output wire [47 : 0] P
    				);				
    	end
    endgenerate 
    
    genvar iff11_1; // The index of flip flops (iff)
    generate 
    	for(iff11_1 = 0; iff11_1 < NUM_DSP*48; iff11_1 = iff11_1 + 1) 
    	begin
    		always @(posedge clk or posedge rst) 
    		begin
    			if(rst) 
    				buff11_1[iff11_1] <= 0;
    			else 
    				if(stop)
    					buff11_1[iff11_1] <= carry_chain11[iff11_1];
    				else		
    					buff11_1[iff11_1] <= 0;
    		end
    	end
    endgenerate

    genvar iff11_2;
    generate 
    	for(iff11_2 = 0; iff11_2 < NUM_DSP*48; iff11_2 = iff11_2 + 1) 
    	begin
    		always @(posedge clk or posedge rst) 
    		begin
    			if(rst) 
    				buff11_2[iff11_2] <= 0;
    			else 				
    				buff11_2[iff11_2] <= buff11_1[iff11_2];
    		end
    	end
    endgenerate


    // 12th Delay line
    genvar idsp12;
    generate 
    	for(idsp12 = 0; idsp12 < NUM_DSP; idsp12 = idsp12 + 1) 
    	begin
    		if(idsp12 == 0)			 			 				
    			xbip_dsp48_macro_1
    				(
     				 .CARRYIN(trigger_out11[3]),            // input wire CARRYIN
      				 .C({48{1'b1}}),                        // input wire [47 : 0] C
                     .CARRYCASCOUT(carry_cas12[idsp12]),  // output wire CARRYCASCOUT
                     .P(carry_chain12[(idsp12+1)*48-1:0])                        // output wire [47 : 0] P
    			   );
    		else	
    			xbip_dsp48_macro_0
    				(
     				 .CARRYCASCIN(carry_cas12[idsp12-1]),    // input wire CARRYCASCIN
     				 .C({48{1'b1}}),                        // input wire [47 : 0] C
      				 .CARRYOUT(0),          // output wire CARRYOUT
      				 .CARRYCASCOUT(carry_cas12[idsp12]),  // output wire CARRYCASCOUT
      				 .P(carry_chain12[(idsp12+1)*48-1:(idsp12)*48])                        // output wire [47 : 0] P
    				);				
    	end
    endgenerate 
    
    genvar iff12_1; // The index of flip flops (iff)
    generate 
    	for(iff12_1 = 0; iff12_1 < NUM_DSP*48; iff12_1 = iff12_1 + 1) 
    	begin
    		always @(posedge clk or posedge rst) 
    		begin
    			if(rst) 
    				buff12_1[iff12_1] <= 0;
    			else 
    				if(stop)
    					buff12_1[iff12_1] <= carry_chain12[iff12_1];
    				else		
    					buff12_1[iff12_1] <= 0;
    		end
    	end
    endgenerate

    genvar iff12_2;
    generate 
    	for(iff12_2 = 0; iff12_2 < NUM_DSP*48; iff12_2 = iff12_2 + 1) 
    	begin
    		always @(posedge clk or posedge rst) 
    		begin
    			if(rst) 
    				buff12_2[iff12_2] <= 0;
    			else 				
    				buff12_2[iff12_2] <= buff12_1[iff12_2];
    		end
    	end
    endgenerate
*/

`endif

	
   encoder
    #(
    .DATA_WIDTH(DATA_WIDTH),
    .NUM_DSP(NUM_DSP),
    .NUM_CARRY(NUM_CARRY)
    )
    encoder_inst
    (
        .clk(clk),
        .rst(rst),
        .din(buff_2),
        .dout(dout1)
    );


    encoder
    #(
    .DATA_WIDTH(DATA_WIDTH),
    .NUM_DSP(NUM_DSP),
    .NUM_CARRY(NUM_CARRY)
    )
    encoder_inst2
    (
        .clk(clk),
        .rst(rst),
        .din(buff2_2),
        .dout(dout2)
    );

    encoder
    #(
    .DATA_WIDTH(DATA_WIDTH),
    .NUM_DSP(NUM_DSP),
    .NUM_CARRY(NUM_CARRY)
    )
    encoder_inst3
    (
        .clk(clk),
        .rst(rst),
        .din(buff3_2),
        .dout(dout3)
    );

    encoder
    #(
    .DATA_WIDTH(DATA_WIDTH),
    .NUM_DSP(NUM_DSP),
    .NUM_CARRY(NUM_CARRY)
    )
    encoder_inst4
    (
        .clk(clk),
        .rst(rst),
        .din(buff4_2),
        .dout(dout4)
    );


    encoder
    #(
    .DATA_WIDTH(DATA_WIDTH),
    .NUM_DSP(NUM_DSP),
    .NUM_CARRY(NUM_CARRY)
    )
    encoder_inst5
    (
        .clk(clk),
        .rst(rst),
        .din(buff5_2),
        .dout(dout5)
    );

    encoder
    #(
    .DATA_WIDTH(DATA_WIDTH),
    .NUM_DSP(NUM_DSP),
    .NUM_CARRY(NUM_CARRY)
    )
    encoder_inst6
    (
        .clk(clk),
        .rst(rst),
        .din(buff6_2),
        .dout(dout6)
    );

    encoder
    #(
    .DATA_WIDTH(DATA_WIDTH),
    .NUM_DSP(NUM_DSP),
    .NUM_CARRY(NUM_CARRY)
    )
    encoder_inst7
    (
        .clk(clk),
        .rst(rst),
        .din(buff7_2),
        .dout(dout7)
    );

    encoder
    #(
    .DATA_WIDTH(DATA_WIDTH),
    .NUM_DSP(NUM_DSP),
    .NUM_CARRY(NUM_CARRY)
    )
    encoder_inst8
    (
        .clk(clk),
        .rst(rst),
        .din(buff8_2),
        .dout(dout8)
    );
   
//    encoder
//    #(
//    .DATA_WIDTH(DATA_WIDTH),
//    .NUM_DSP(NUM_DSP),
//    .NUM_CARRY(NUM_CARRY)
//    )
//    encoder_inst9
//    (
//        .clk(clk),
//        .rst(rst),
//        .din(buff9_2),
//        .dout(dout9)
//    );

//    encoder
//    #(
//    .DATA_WIDTH(DATA_WIDTH),
//    .NUM_DSP(NUM_DSP),
//    .NUM_CARRY(NUM_CARRY)
//    )
//    encoder_inst10
//    (
//        .clk(clk),
//        .rst(rst),
//        .din(buff10_2),
//        .dout(dout10)
//    );
    
    
//    encoder
//    #(
//    .DATA_WIDTH(DATA_WIDTH),
//    .NUM_DSP(NUM_DSP),
//    .NUM_CARRY(NUM_CARRY)
//    )
//    encoder_inst11
//    (
//        .clk(clk),
//        .rst(rst),
//        .din(buff11_2),
//        .dout(dout11)
//    );

//    encoder
//    #(
//    .DATA_WIDTH(DATA_WIDTH),
//    .NUM_DSP(NUM_DSP),
//    .NUM_CARRY(NUM_CARRY)
//    )
//    encoder_inst12
//    (
//        .clk(clk),
//        .rst(rst),
//        .din(buff12_2),
//        .dout(dout12)
//    );


    always @(posedge clk or posedge rst) begin
        if(rst)
            doutf1 <= 0;
        else
            doutf1 <= (dout1) + (dout2) + (dout3) + (dout4);
    end

    always @(posedge clk or posedge rst) begin
    	if(rst)
    		doutf2 <= 0;
    	else
    		doutf2 <= (dout5) + (dout6) + (dout7)+ (dout8);
    end
    
//    always @(posedge clk or posedge rst) begin
//    	if(rst)
//    		doutf3 <= 0;
//    	else
//    		doutf3 <= (dout9) + (dout10) + (dout11) + (dout12);
//    end

    always @(posedge clk or posedge rst) begin
        if(rst)
            dout <= 0;
        else
            dout <= doutf1 + doutf2;
    end

    /*
calibration
	cali_inst
	(
		.clk(clk1),
		.rst(rst),
		.trigger(1),  	
  		.din(dout),
  		.dout(dout0)
  	);
*/

endmodule
