`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:49:36 11/09/2015
// Design Name:   Proyecto_Servo
// Module Name:   C:/Lab Digitales/Servo_3.0/Prueba.v
// Project Name:  Servo_3.0
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Proyecto_Servo
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Prueba#(parameter cant_bits = 13);

	// Inputs
	reg signed [cant_bits-1:0] Pot_P;
	reg signed [cant_bits-1:0] Ref_P;
	reg Clk_P;
	reg Rst_P;
	reg Rx_Tick;

	// Outputs
	wire signed[cant_bits-1:0] YkT;
	wire [9:0] Nadaout;

	// Instantiate the Unit Under Test (UUT)
	Proyecto_Servo uut (
		.Pot_P(Pot_P), 
		.Ref_P(Ref_P), 
		.Clk_P(Clk_P), 
		.Rst_P(Rst_P), 
		.Rx_Tick(Rx_Tick), 
		.YkT(YkT),
		.Nadaout(Nadaout)
	);

initial 
	begin
		// Initialize Inputs
		Pot_P = 0;
		Ref_P = 0;
		Clk_P = 0;
		Rst_P = 1;
		Rx_Tick = 0;
		#10
		Rst_P = 0;
	end


reg signed[cant_bits-1:0] Array_IN1 [100:0];
integer j,Filtro;


localparam T = 10;
 always
 begin
 Clk_P = 1'b1;
 #(T/2) ;
 Clk_P = 1'b0;
 #(T/2) ;
 end

initial 
	begin
		Ref_P = 13'sb0101000000000;
		$readmemb("estimulac_bin.txt", Array_IN1,0,101);
		Filtro = $fopen("ResServo.txt","w"); //Crea el archivo de la rampa donde se guarda el resultado
			for(j=0; j<101; j=j+1) 
			begin
				Pot_P = Array_IN1[j]; 
				Rx_Tick = 1'b1;
				repeat(1) @(posedge Clk_P); 
				Rx_Tick = 1'b0;
				repeat(15) @(posedge Clk_P); 
				$fwrite(Filtro,"%b \n",YkT); 
			end
		$fclose(Filtro); 
	end      
		
endmodule

