`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:41:46 11/23/2015 
// Design Name: 
// Module Name:    Juntos 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Juntos(
	input Clk,Rst,Data,
	output cs_1,sclk_1,salida
    );

wire [15:0] cable;

ADC instance_Adc (
    .clk(Clk), 
    .rst(Rst), 
    .sdata(Data), 
    .out(cable), 
    .cs(cs_1), 
    .sclk(sclk_1), 
    .desp_enable_1(desp_enable)
    );

pwm instance_Pwm (
    .clk(Clk), 
    .rst(Rst), 
    .PMW_in(cable[7:0]), 
    .PWM_out(salida)
    );


endmodule
