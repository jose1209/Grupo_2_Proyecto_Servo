`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:32:00 11/11/2015 
// Design Name: 
// Module Name:    Prueba_D 
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
module Prueba_D#(parameter cant_bits = 13)(
	input wire signed [cant_bits-1:0] Pot,
	input wire Clk_G,Rst_G,Rx_En,
	output reg signed [2*cant_bits-1:0] R_Mul_D
    );

reg [2:0] est_sig,est_act;
reg LD_G,Rx_En_Local;
reg signed[cant_bits-1:0] R_Mul_D_1;
wire signed[2*cant_bits-1:0] Sum_P;
wire signed[cant_bits-1:0] Mul_D;

//Modulo D

assign Mul_D = Pot - R_Mul_D_1;
assign Sum_P = Mul_D*13'sb0000010010110;//Kd

//Registro Y(k-1)

always@(posedge Clk_G, posedge Rst_G)
	begin
		if(Rst_G)
			begin
				R_Mul_D_1 <= 0;
			end
		else if(Rx_En_Local)
			begin		
				R_Mul_D_1 <= Pot;
			end
	end

//Registro D

always@(posedge Clk_G, posedge Rst_G)
	begin
		if(Rst_G)
			begin		
				R_Mul_D <= 0;
			end
		else if(LD_G)
			begin
				R_Mul_D <= Sum_P;
			end		
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
		est_sig = est_act;
			case(est_act)
				3'b000:
					begin
						if(Rx_En)
							est_sig = 3'b001;
						else 
							begin
								LD_G = 0;
								Rx_En_Local = 0;
								est_sig = 3'b000;
							end
					end
					
				3'b001:
					begin
						est_sig = 3'b010;
					end	
					
				3'b010:
					begin
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
