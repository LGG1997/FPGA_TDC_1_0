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
		parameter NUM = 16
	 )(
    	input trigger,
    	output dout
    );


wire [3:0] carry_chain0;
wire [3:0] carry_chain1;
wire [3:0] carry_chain2;
wire [3:0] carry_chain3;
wire [3:0] carry_chain4;
wire [3:0] carry_chain5;
wire [3:0] carry_chain6;
wire [3:0] carry_chain7;
wire [3:0] carry_chain8;
wire [3:0] carry_chain9;
wire [3:0] carry_chain10;
wire [3:0] carry_chain11;
wire [3:0] carry_chain12;
wire [3:0] carry_chain13;

wire [8:0] net;

assign dout = carry_chain13[3];


CARRY4 C0
(
	.CO(carry_chain0),	// 4bit carry_out
	.CI(0),  // 4bit carry chain XOR data out 
	.CYINIT(trigger), // 1bit carry cascade input 
	.DI(4'b0000), // 4bit carry-MUX data in
	.S({4'b1111})
); // 4bit carry MUX select input

CARRY4 C1
(
	.CO(carry_chain1),	// 4bit carry_out
	.CI(carry_chain0[3]),  // 4bit carry chain XOR data out 
	.CYINIT(0), // 1bit carry cascade input 
	.DI(4'b0001), // 4bit carry-MUX data in
	.S({4'b1111})
); // 4bit carry MUX select input

// GEN 1 -------------------------------------------------------------------------
CARRY4 C2
	(
		.CO(carry_chain2),	// 4bit carry_out
		.CI(carry_chain1[3]),  // 4bit carry chain XOR data out 
		.CYINIT(0), // 1bit carry cascade input 
		.DI(4'b0001), // 4bit carry-MUX data in
		.S({4'b1111})
	); // 4bit carry MUX select input
	
CARRY4 C3
	(
		.CO(carry_chain3),	// 4bit carry_out
		.CI(carry_chain2[3]),  // 4bit carry chain XOR data out 
		.CYINIT(0), // 1bit carry cascade input 
		.DI(4'b0000), // 4bit carry-MUX data in
		.S({4'b1111})
	); // 4bit carry MUX select input
//-------------------------------------------------------------------------

CARRY4 C4
	(
		.CO(carry_chain4),	// 4bit carry_out
		.CI(carry_chain3[3]),  // 4bit carry chain XOR data out 
		.CYINIT(0), // 1bit carry cascade input 
		.DI(4'b0000), // 4bit carry-MUX data in
		.S({4'b1111})
	); // 4bit carry MUX select input
	
CARRY4 C5
	(
		.CO(carry_chain5),	// 4bit carry_out
		.CI(carry_chain4[3]),  // 4bit carry chain XOR data out 
		.CYINIT(0), // 1bit carry cascade input 
		.DI(4'b0001), // 4bit carry-MUX data in
		.S({4'b1111})
	); // 4bit carry MUX select input

// GEN 1-------------------------------------------------------------------------
	
CARRY4 C6
	(
		.CO(carry_chain6),	// 4bit carry_out
		.CI(carry_chain5[3]),  // 4bit carry chain XOR data out 
		.CYINIT(0), // 1bit carry cascade input 
		.DI(4'b0001), // 4bit carry-MUX data in
		.S({4'b1111})
	); // 4bit carry MUX select input
	
CARRY4 C7
	(
		.CO(carry_chain7),	// 4bit carry_out
		.CI(carry_chain6[3]),  // 4bit carry chain XOR data out 
		.CYINIT(0), // 1bit carry cascade input 
		.DI(4'b0000), // 4bit carry-MUX data in
		.S({4'b1111})
	); // 4bit carry MUX select input	
	
//GEN 0-------------------------------------------------------------------------

CARRY4 C8
	(
		.CO(carry_chain8),	// 4bit carry_out
		.CI(carry_chain7[3]),  // 4bit carry chain XOR data out 
		.CYINIT(0), // 1bit carry cascade input 
		.DI(4'b0000), // 4bit carry-MUX data in
		.S({4'b1111})
	); // 4bit carry MUX select input
	
CARRY4 C9
	(
		.CO(carry_chain9),	// 4bit carry_out
		.CI(carry_chain8[3]),  // 4bit carry chain XOR data out 
		.CYINIT(0), // 1bit carry cascade input 
		.DI(4'b0000), // 4bit carry-MUX data in
		.S({4'b1111})
	); // 4bit carry MUX select input

//GEN 1-------------------------------------------------------------------------
	
CARRY4 C10
	(
		.CO(carry_chain10),	// 4bit carry_out
		.CI(carry_chain9[3]),  // 4bit carry chain XOR data out 
		.CYINIT(0), // 1bit carry cascade input 
		.DI(4'b0001), // 4bit carry-MUX data in
		.S({4'b1111})
	); // 4bit carry MUX select input

CARRY4 C11
	(
		.CO(carry_chain11),	// 4bit carry_out
		.CI(carry_chain10[3]),  // 4bit carry chain XOR data out 
		.CYINIT(0), // 1bit carry cascade input 
		.DI(4'b0000), // 4bit carry-MUX data in
		.S({4'b1111})
	); // 4bit carry MUX select input	

//-------------------------------------------------------------------------
CARRY4 C12
	(
		.CO(carry_chain12),	// 4bit carry_out
		.CI(carry_chain11[3]),  // 4bit carry chain XOR data out 
		.CYINIT(0), // 1bit carry cascade input 
		.DI(4'b0000), // 4bit carry-MUX data in
		.S({3'b111,trigger})
	); // 4bit carry MUX select input

CARRY4 C13
	(
		.CO(carry_chain13),	// 4bit carry_out
		.CI(carry_chain12[3]),  // 4bit carry chain XOR data out 
		.CYINIT(0), // 1bit carry cascade input 
		.DI(4'b0000), // 4bit carry-MUX data in
		.S({4'b1111})
	); // 4bit carry MUX select input	
   
endmodule
