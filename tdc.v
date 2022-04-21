`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Bristol
// Engineer: Jiajun Lu, Zijie Wang
// 
// Create Date: 11/12/2021 04:21:54 AM
// Design Name: 
// Module Name: tdc
// Project Name: High resolution FPGA TDC based on Zedboard
// Target Devices: Zedboard
// Tool Versions: 1.1
// Description: The modified version has improved the structure of the Verilog code, which divides the TDC into 4 parts 
//					(Fine counting, Coarse counting, Pulse generation for auto-calibtation, System clock block) 
// 
// Dependencies: 
// 
// Revision: 
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "configuration.v"

module tdc(
	input i_clk,
	input i_reset,
	input i_trigger, 
	input i_control,
	output [15:0] o_dout
);


wire sys_clk;
wire pulse;  
wire stop;
(*mark_debug = "true"*) wire [15:0] dout;


//ila_0 ila_0_inst
//	(
//		.clk(sys_clk),
//		.probe0(dout)
//	);

crg crg_inst(
	.i_clk(i_clk),
	.i_reset(i_reset),
	.i_control(i_control),
	.o_clk(sys_clk),
	.o_pulse(pulse),
	.o_stop(stop)
);

//---------------------------------------------------------------------------------------------


// TDC fine counting component
tdc_fine  
	#(	
		.NUM_DSP(12),
		.NUM_CARRY(144),
		.DATA_WIDTH(8)
	 )
	fine_inst
	 (
    	.clk(sys_clk),
    	.rst(i_reset),
    	.stop(stop),
    	.cali_en(0),
    	.trigger(pulse),
 		.dout(dout)
    );

// TDC coarse counting component
assign o_dout = dout[15:0];

endmodule
