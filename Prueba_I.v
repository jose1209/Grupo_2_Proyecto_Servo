`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:27:02 11/11/2015 
// Design Name: 
// Module Name:    Prueba_I 
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
module Prueba_I#(parameter cant_bits = 13)(
	input wire Clk_G,Rst_G,Rx_En,
	input wire signed [cant_bits-1:0] Pot,Ref,
	output reg signed [2*cant_bits-1:0] R_I
    );

reg [2:0] est_sig,est_act;
reg LD_G,Rx_En_Local,Rx_En_Ek;
wire signed[cant_bits-1:0] Ek;
reg signed[cant_bits-1:0] R_Ek;
wire signed[2*cant_bits-1:0] Mul_I,Sum_I;
reg signed[2*cant_bits-1:0] R_I_1;
//Modulo I

//Calculando Ek

assign Ek = Ref - Pot;

//Registro Ek

always@(posedge Clk_G, posedge Rst_G)
	begin
		if(Rst_G)
			begin
				R_Ek <= 0;
			end
		else if(Rx_En_Ek)//Rx_En??LD_Ek/
			begin
				R_Ek <= Ek;
			end
	end

//Calculando I

assign Mul_I = R_Ek*13'sb0000000000111;//KI
assign Sum_I = R_I_1 + Mul_I;

//Registro I y I(k-1)

always@(posedge Clk_G, posedge Rst_G)
	begin
		if(Rst_G)
			begin
				R_I <= 0;
				R_I_1 <= 0;
			end
		else if(LD_G)
			R_I <= Sum_I;
		else if(Rx_En_Local)
			R_I_1 <= R_I;
	end

/////////////////////////////////////////////////////////////////////

//Control

always@(posedge Clk_G, posedge Rst_G)
	begin
		if(Rst_G)
			begin
				est_act <= 3'b000;
			end
		else
			est_act <= est_sig;
	end

always@*
	begin
		LD_G = 0;
		Rx_En_Local = 0;
		Rx_En_Ek = 0;
		est_sig = est_act;
			case(est_act)
				3'b000:
					begin
						if(Rx_En)
							est_sig = 3'b001;
						else 
							begin
								LD_G = 0;
								Rx_En_Ek = 0;
								Rx_En_Local = 0;
								est_sig = 3'b000;
							end
					end
					
				3'b001:
					begin
						Rx_En_Ek = 1;
						est_sig = 3'b010;
					end	
					
				3'b010:
					begin
						Rx_En_Ek = 0;
						LD_G = 1;
						est_sig = 3'b011;
					end
					
				3'b011:
					begin
						LD_G = 0;
						est_sig = 3'b100;
					end
				
				3'b100:
					begin
						Rx_En_Local = 1;
						est_sig = 3'b000;
					end
					
				default:
					begin
						Rx_En_Local = 0;
						LD_G = 0;
						est_sig = 3'b000;
					end
			endcase
	end

endmodule
