`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:58:02 10/14/2015 
// Design Name: 
// Module Name:    Truncador_PWM 
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
module Truncador_PWM#(parameter cant_bits = 16)(
	input wire signed [cant_bits-1:0] dato_infiltro, //Dato que sale del filtro
	output reg signed [7:0] dato_truncout); //Dato truncado para el PWM
	
wire signed [cant_bits-1:0] aux;

assign aux = dato_infiltro;

localparam [6:0]	ceros = 0,        // 12 bits
									unos = ~ceros;
									
always@*
		begin
			if(aux[cant_bits-2] != 0 && aux[cant_bits-1] == 0)		//overflow
				dato_truncout = {1'b0,unos};
			else if(aux[cant_bits-2] != 1 && aux[cant_bits-1] == 1)	//underflow
				dato_truncout = {1'b1,ceros};
			else
			begin
				//dato_truncout = {aux[cant_bits-3:7],~aux[6]};
				//dato_truncout = {aux[7:1],~aux[0]};
				dato_truncout = aux[cant_bits-3:6] + 8'd1;
			end
		end
	
	
/*
wire signed comp = {8{dato_infiltro[cant_bits-1]}} ;
reg signed [7:0] dato_trunc;
wire signed [cant_bits-1:0] aux;
assign aux = dato_infiltro;

always @*
	begin
		if (aux[cant_bits-1] == 1 && comp != aux[7:0]) dato_trunc <= 8'b0; //Para el caso de underflow
		else if (aux[cant_bits-1] == 0 && comp != aux [7:0]) dato_trunc <= 8'b11111111; //Para el caso de overflow
		else dato_trunc <= {aux[12:6],~{aux[5]}}; //El bit 1 negado es para sumar los 1
	end

assign dato_truncout = dato_trunc;



assign dato_truncout = {dato_infiltro[7:1],~{dato_infiltro[0]}};*/

endmodule
