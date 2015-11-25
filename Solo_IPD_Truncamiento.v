`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:36:21 11/16/2015 
// Design Name: 
// Module Name:    Solo_IPD_Truncamiento 
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
module Solo_IPD_Truncamiento#(parameter cant_bits = 16)(
	input wire signed [cant_bits-1:0] Pot,Ref,
	input wire clk,rst,en,
	output wire signed [cant_bits-1:0] salida
    );

wire signed [2*cant_bits-1:0] Yk_1;
wire signed [cant_bits-1:0] In,Refer;

assign In = Pot;
assign Refer = Ref;

IPD instance_Ipd (
    .Pot(In), 
    .Ref(Refer), 
    .Clk_G(clk), 
    .Rst_G(rst), 
    .Rx_En(en), 
    .Yk(Yk_1)
    );

redondeo instance_Trun(
    .in(Yk_1), 
    .out(salida), 
    .nada(nada)
    );
	 
endmodule
