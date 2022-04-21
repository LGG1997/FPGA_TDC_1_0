`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2022 05:57:15 PM
// Design Name: 
// Module Name: crg
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


module crg(
input i_clk,
input i_reset,
input i_control,
output o_clk,
output o_pulse,
output o_stop
);
    
    
wire cali_control;
wire clk_1;
wire clk_2;
wire clk_3;

assign cali_control = ~i_control | i_reset;
//---------------------------------------------------------------------------------------------
// Using MMCM IP generates 172 MHz signal as a system clock.
// clk_wiz_0 generates two 100MHz clocks as input clock connecting to clk_wiz_1 and clk_wiz_2
clk_wiz_0 clk_inst0
(
	.clk_out1(clk_1),
	.clk_out2(clk_2),
	.reset(i_reset), 
	.clk_in1(i_clk)
);

// The block generates system clock (172MHz)
clk_wiz_1 clk_inst1
(
	.clk_out1(o_clk),
	.reset(i_reset),
	.clk_in1(clk_1)
);

// The block generates a clock for calibration module (172.02MHz)
clk_wiz_2 clk_inst2
(
	.clk_out1(clk_3),
	.reset(cali_control), 
	.clk_in1(clk_2)
);

// Pulse generation component for auto-calibration (172.02MHz)
pulse_gen pulse_inst
( 
	.i_clk(clk_3),
	.i_reset(i_reset),
	.i_en(1),
	.o_pulse(o_pulse),
	.o_stop(o_stop)
);

endmodule
