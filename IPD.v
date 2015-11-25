`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:30:32 11/09/2015 
// Design Name: 
// Module Name:    IPD 
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
module IPD#(parameter cant_bits = 16)(
	input wire signed [cant_bits-1:0] Pot,Ref,
	input wire Clk_G,Rst_G,Rx_En,
	output reg signed [2*cant_bits-1:0] Yk
    );

reg [2:0] est_sig,est_act;
reg LD_2,LD_G,Rx_En_Local,Rx_En_Ek;
wire signed[cant_bits-1:0] Ek,Mul_D;
reg signed[cant_bits-1:0] R_Ek,R_Mul_D_1;
wire signed[2*cant_bits-1:0] Mul_P,Mul_I,Sum_I,Yk_AUX,Sum_P,AUX;
reg signed[2*cant_bits-1:0] R_Mul_P,R_Mul_D,R_I,R_I_1;

//Inicializacion

//Modulo P
assign Mul_P = Pot*16'sb0000000000010010;//Kp

//Registro P

always@(posedge Clk_G, posedge Rst_G)
	begin
		if(Rst_G)
			begin
				R_Mul_P <= 0;	
			end
		else if(LD_G)
			begin
				R_Mul_P <= Mul_P;
			end
	end

//////////////////////////////////////////////////////////////////////////

//Modulo D

assign Mul_D = Pot - R_Mul_D_1;
assign Sum_P = Mul_D*16'sb0000000010010110;//Kd

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

//////////////////////////////////////////////////////////////////////////

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

assign Mul_I = R_Ek*16'sb0000000000000111;//KI
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

/////////////////////////////////////////////////////////////////////////

//Calculando la Salida

assign AUX = R_I - R_Mul_P;
assign Yk_AUX = AUX - R_Mul_D;	

always@(posedge Clk_G, posedge Rst_G)
	begin
		if(Rst_G)
			begin
				Yk <= 0;
			end
		else if(LD_2)
			begin
				Yk <= Yk_AUX;
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
		LD_2 = 0;
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
								LD_2 = 0;
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
						est_sig = 3'b011;
					end
					
				3'b011:
					begin
						Rx_En_Ek = 0;
						LD_G = 1;
						est_sig = 3'b100;
					end
				
				3'b100:
					begin
						LD_2 = 1;
						LD_G = 0;
						Rx_En_Local = 1;
						est_sig = 3'b000;
					end
					
				default:
					begin
						LD_2 = 0;
						Rx_En_Local = 0;
						LD_G = 0;
						est_sig = 3'b000;
					end
			endcase
	end

endmodule
