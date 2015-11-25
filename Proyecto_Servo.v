`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:44:04 11/09/2015 
// Design Name: 
// Module Name:    Proyecto_Servo 
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
module Proyecto_Servo#(parameter cant_bits = 16)(
	input wire DataIn,
	input wire Clk_P,Rst_P,a,b,c,d,Enable,
	output wire Salida_PWM,
	output wire [6:0] Nadaout,
	output wire [10:0] seven_segs,
	output wire cs_1,sclk_1,
	output wire [7:0] prueba_prueba
    );
	 

wire signed [cant_bits-1:0] Ref_P,Pot_P,YkT;
wire signed [2*cant_bits-1:0] Cable;
wire [6:0] Nada;
wire [7:0] salida;
wire rx;

assign prueba_prueba = Ref_P[15:8];

ControlRef instance_Load_Reference (
    .CLK_G(Clk_P), 
    .En(Enable), 
    .reset_G(Rst_P), 
    .A(a), 
    .B(b), 
    .C(c), 
    .D(d), 
    .Datos_out(Ref_P), 
    .sssegs(seven_segs)
    );
	 
IPD instance_IPD (
    .Pot(Pot_P), 
    .Ref(Ref_P), 
    .Clk_G(Clk_P), 
    .Rst_G(Rst_P), 
    .Rx_En(rx), 
    .Yk(Cable)
    );

redondeo instance_Truck (
    .in(Cable), 
    .out(YkT),
	 .nada(Nada)
    );

ADC_final instance_ADC (
    .clk(Clk_P), 
    .rst(Rst_P), 
    .sdata(DataIn), 
    .cs(cs_1), 
    .sclk(sclk_1), 
    .desp_enable_1(rx), 
    .dato_final(Pot_P)
    );

Truncador_PWM instance_PwmTruck (
    .dato_infiltro(YkT), 
    .dato_truncout(salida)
    );


pwm instance_PWM (
    .clk(Clk_P), 
    .PMW_in(salida), 
    .PWM_out(Salida_PWM),
	 .rst(Rst_P)
    );
 
assign Nadaout = Nada;

endmodule
