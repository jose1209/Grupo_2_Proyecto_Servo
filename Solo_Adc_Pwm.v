`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:29:39 11/13/2015 
// Design Name: 
// Module Name:    Solo_Adc_Pwm 
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
module Solo_Adc_Pwm#(parameter cant_bits = 13)(
	input wire Clk,entrada,Rst,
	output wire salida,cs_1,sclk_1
    );


wire signed [cant_bits-1:0] Pot_P;

ADC_final instance_Adc (
    .clk(Clk), 
    .rst(Rst), 
    .sdata(entrada), 
    .cs(cs_1), 
    .sclk(sclk_1), 
    .desp_enable(desp_enable), 
    .dato_final(Pot_P)
    );
	
pwm instance_Pwm (
    .clk(Clk), 
    .PMW_in(Pot_P), 
    .PWM_out(salida),
	 .rst(Rst)
    );


endmodule
