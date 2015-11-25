`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:10:08 10/29/2015 
// Design Name: 
// Module Name:    Constantes_Mem 
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
module Constantes_Mem#(parameter cant_bits = 16)(
	input wire [3:0] estados,
	output reg signed [cant_bits-1:0] Constantes
    );

	always@*
      case (estados)
			4'b0000: Constantes = 16'sb0110010000000000; //200
			4'b0001: Constantes = 16'sb0110010000000000;//200
         4'b0010: Constantes = 16'sb0100101100000000;//150
         4'b0011: Constantes = 16'sb0010100000000000;//80
			4'b0100: Constantes = 16'sb0010110100000000;//90
			4'b0101: Constantes = 16'sb0011001000000000;//200
			4'b0110: Constantes = 16'sb0111111111111111;//300
			default: Constantes = 16'sb0000000000000000;
      endcase

endmodule
