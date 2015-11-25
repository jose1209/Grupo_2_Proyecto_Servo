`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:18:42 11/23/2015 
// Design Name: 
// Module Name:    Listo 
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
module Listo(
	input wire Clk,Rst,Entrada,enable,A_a,B_b,C_c,D_d,
	output wire sclk_1,cs_1,salida//,prueba
    );

wire rx;
wire [15:0] cableA,cableB,cableC;
wire [31:0] cableD;
wire[7:0]cableH;
assign cableH = cableB[15:8];
//assign cableH = {cableB[13:6]};

ADC instance_S_Adc (
    .clk(Clk), 
    .rst(Rst), 
    .sdata(Entrada), 
    .out(cableA), 
    .cs(cs_1), 
    .sclk(sclk_1), 
    .desp_enable_A(rx)
    );

IPD instance_IPD (
    .Pot(cableA), 
    .Ref(cableC), 
    .Clk_G(Clk), 
    .Rst_G(Rst), 
    .Rx_En(rx), 
    .Yk(cableD)
    );

redondeo instance_TRUNK (
    .in(cableD), 
    .out(cableB), 
    .nada(nada)
    );

pwm instance_PWM (
    .clk(Clk), 
    .rst(Rst), 
    .PMW_in(cableH), 
    .PWM_out(salida)
    );

ControlRef instance_REF (
    .CLK_G(Clk), 
    .En(enable), 
    .reset_G(Rst), 
    .A(A_a), 
    .B(B_b), 
    .C(C_c), 
    .D(D_d), 
    .Datos_out(cableC)//, 
    //.sssegs(sssegs)
    );



endmodule
