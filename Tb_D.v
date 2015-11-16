`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:40:45 11/11/2015
// Design Name:   Prueba_D
// Module Name:   C:/Lab Digitales/Servo_3.0/Tb_D.v
// Project Name:  Servo_3.0
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Prueba_D
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Tb_D#(parameter cant_bits = 13);

	// Inputs
	reg signed [12:0] Pot;
	reg Clk_G;
	reg Rst_G;
	reg Rx_En;

	// Outputs
	wire signed [25:0] R_Mul_D;

	// Instantiate the Unit Under Test (UUT)
	Prueba_D uut (
		.Pot(Pot), 
		.Clk_G(Clk_G), 
		.Rst_G(Rst_G), 
		.Rx_En(Rx_En), 
		.R_Mul_D(R_Mul_D)
	);

	initial begin
		// Initialize Inputs
		Pot = 0;
		Clk_G = 0;
		Rst_G = 1;
		Rx_En = 0;
		#10
		Rst_G = 0;
	end
     
reg signed [cant_bits-1:0] Array_IN1 [100:0];
integer j,Solo_I;


localparam T = 10;
 always
 begin
 Clk_G = 1'b1;
 #(T/2) ;
 Clk_G = 1'b0;
 #(T/2) ;
 end

initial 
	begin
		$readmemb("estimulac_bin.txt", Array_IN1,0,101);
		Solo_I = $fopen("Resultado_D.txt","w"); //Crea el archivo de la rampa donde se guarda el resultado
			for(j=0; j<101; j=j+1) 
			begin
				Pot = Array_IN1[j]; 
				Rx_En = 1'b1;
				repeat(1) @(posedge Clk_G); 
				Rx_En = 1'b0;
				repeat(15) @(posedge Clk_G); 
				$fwrite(Solo_I,"%b \n",R_Mul_D); 
			end
		$fclose(Solo_I); 
	end     
	
endmodule

