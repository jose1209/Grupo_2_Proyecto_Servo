`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:39:41 08/30/2015 
// Design Name: 
// Module Name:    Junta1 
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
module ControlRef#(parameter cant_bits = 13)(

input wire CLK_G,En,
input wire reset_G,
input wire A,B,C,D,
output wire signed [cant_bits-1:0] Datos_out,
output wire [10:0] sssegs

    );
	 
	 
wire W,X,Y,Z;
wire [3:0] state;


// Registro para los SW (Referencia)
regs RegSW (
    .clk(CLK_G), 
    .En(En), 
    .A(A), 
    .B(B), 
    .C(C), 
    .D(D), 
    .W(W), 
    .X(X), 
    .Y(Y), 
    .Z(Z)
    );

disp_mux_SS instance_segmentos (
    .clk(CLK_G), 
    .reset(reset_G), 
    .st(state), 
    .an(sssegs[3:0]), 
    .sseg(sssegs[10:4])
    );

Constantes_Mem instance_Constantes (
    .estados(state), 
    .Constantes(Datos_out)
    );
	 

assign state[0] = W ;
assign state[1] = X ;
assign state[2] = Y ;
assign state[3] = Z ;


endmodule
