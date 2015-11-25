`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:46:26 11/16/2015
// Design Name:   Solo_IPD_Truncamiento
// Module Name:   C:/Lab Digitales/Servo_3.0/Solo_IPD_Trunk.v
// Project Name:  Servo_3.0
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Solo_IPD_Truncamiento
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Solo_IPD_Trunk#(parameter cant_bits = 13);

	// Inputs
	reg [12:0] Pot;
	reg [12:0] Ref;
	reg clk;
	reg rst;
	reg en;

	// Outputs
	wire [12:0] salida;

	// Instantiate the Unit Under Test (UUT)
	Solo_IPD_Truncamiento uut (
		.Pot(Pot), 
		.Ref(Ref), 
		.clk(clk), 
		.rst(rst), 
		.en(en), 
		.salida(salida)
	);

	initial begin
		// Initialize Inputs
		Pot = 0;
		Ref = 0;
		clk = 0;
		rst = 1;
		en = 0;
		#10
		rst = 0;

	end
	

reg signed[cant_bits-1:0] Array_IN1 [100:0];
integer j,Filtro;


localparam T = 10;
 always
 begin
 clk = 1'b1;
 #(T/2) ;
 clk = 1'b0;
 #(T/2) ;
 end

initial 
	begin
		Ref = 13'sb0000011000100;
		$readmemb("estimulac_bin.txt", Array_IN1,0,101);
		Filtro = $fopen("ResServoTrun.txt","w"); //Crea el archivo de la rampa donde se guarda el resultado
			for(j=0; j<101; j=j+1) 
			begin
				Pot = Array_IN1[j]; 
				en = 1'b1;
				repeat(1) @(posedge clk); 
				en = 1'b0;
				repeat(15) @(posedge clk); 
				$fwrite(Filtro,"%b \n",salida); 
			end
		$fclose(Filtro); 
	end
      
endmodule

