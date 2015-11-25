`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:55:32 11/18/2015 
// Design Name: 
// Module Name:    Prueba_ADC_IPD_Trunk 
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
module Prueba_ADC_IPD_Trunk#(parameter cant_bits = 16)(
	input wire Clk,Rest,
	input wire signed DataIn,
	input wire signed [cant_bits-1:0] referen,
	output wire signed [cant_bits-1:0] salida,
	output wire cs_1,sclk_1
    );

wire enable;
wire signed [2*cant_bits-1:0] Cable;
wire signed [cant_bits-1:0] Entrada;

ADC_final instance_Prueba_Adc (
    .clk(Clk), 
    .rst(Rest), 
    .sdata(DataIn), 
    .cs(cs_1), 
    .sclk(sclk_1), 
    .desp_enable_1(enable), 
    .dato_final(Entrada)
    );

IPD instance_Prueba_IPD (
    .Pot(Entrada), 
    .Ref(referen), 
    .Clk_G(Clk), 
    .Rst_G(Rest), 
    .Rx_En(enable), 
    .Yk(Cable)
    );
	 
redondeo instance_Prueba_Trunk (
    .in(Cable), 
    .out(salida), 
    .nada(nada)
    );

endmodule
