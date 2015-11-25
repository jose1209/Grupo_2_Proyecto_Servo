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
module Constantes_Mem#(parameter cant_bits = 13)(
	input wire [3:0] estados,
	output reg signed [cant_bits-1:0] Constantes
    );

	 always@(estados)
      case (estados)
			/*4'b0000: Constantes = 13'sb0101000000000;
         4'b0001: Constantes = 13'sb0110010000000;
         4'b0010: Constantes = 13'sb0111100000000;
         4'b0011: Constantes = 13'sd60;
			4'b0100: Constantes = 13'sd70;
			4'b0101: Constantes = 13'sd80;
			4'b0110: Constantes = 13'sd90;
			4'b0111: Constantes = 13'sd100;
			4'b1000: Constantes = 13'sd110;
			4'b1001: Constantes = 13'sd120;
			4'b1010: Constantes = 13'sd135;
			4'b1011: Constantes = 13'sd150;
			4'b1100: Constantes = 13'sd160;
			4'b1101: Constantes = 13'sd170;
			4'b1110: Constantes = 13'sd190;
			4'b1111: Constantes = 13'sd270;*/
		
		
         4'b0000: Constantes = 13'sb0000011000100;
         4'b0001: Constantes = 13'sb0000010011111;
         4'b0010: Constantes = 13'sb0000001111010;
         4'b0011: Constantes = 13'sb0000000110001;
			4'b0100: Constantes = 13'sb0000000001100;
			4'b0101: Constantes = 13'sb1111111100111;
			4'b0110: Constantes = 13'sb1111111000010;
			4'b0111: Constantes = 13'sb1111110011110;
			4'b1000: Constantes = 13'sb1111101111001;
			4'b1001: Constantes = 13'sb1111101010100;
			default: Constantes = 13'sb0000000000000;
      endcase

endmodule
