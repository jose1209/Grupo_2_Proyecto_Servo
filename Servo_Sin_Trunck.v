`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:13:11 11/10/2015
// Design Name:   IPD
// Module Name:   C:/Lab Digitales/Servo_3.0/Servo_Sin_Trunck.v
// Project Name:  Servo_3.0
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: IPD
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Servo_Sin_Trunck#(parameter cant_bits = 16);

	// Inputs
	reg signed [cant_bits-1:0] Pot;
	reg signed [cant_bits-1:0] Ref;
	reg Clk_G;
	reg Rst_G;
	reg Rx_En;

	// Outputs
	wire signed [2*cant_bits-1:0] Yk;

	// Instantiate the Unit Under Test (UUT)
	IPD uut (
		.Pot(Pot), 
		.Ref(Ref), 
		.Clk_G(Clk_G), 
		.Rst_G(Rst_G), 
		.Rx_En(Rx_En), 
		.Yk(Yk)
	);

	initial begin
		// Initialize Inputs
		Pot = 0;
		Ref = 0;
		Clk_G = 0;
		Rst_G = 1;
		Rx_En = 0;
		#10
		Rst_G = 0;
	end
		
reg signed[cant_bits-1:0] Array_IN1 [100:0];
integer j,Filtro;


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
		Ref = 16'sb0100101100000000;
		$readmemb("estimulac_bin.txt", Array_IN1,0,101);
		Filtro = $fopen("ResServo2.txt","w"); //Crea el archivo de la rampa donde se guarda el resultado
			for(j=0; j<101; j=j+1) 
			begin
				Pot = Array_IN1[j]; 
				Rx_En = 1'b1;
				repeat(1) @(posedge Clk_G); 
				Rx_En = 1'b0;
				repeat(15) @(posedge Clk_G); 
				$fwrite(Filtro,"%b \n",Yk); 
			end
		$fclose(Filtro); 
	end      
		
endmodule