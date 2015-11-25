`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:39:58 11/18/2015
// Design Name:   Prueba_ADC_IPD_Trunk
// Module Name:   C:/Lab Digitales/Servo_3.0/Tb_Prueba_Adc_IPD.v
// Project Name:  Servo_3.0
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Prueba_ADC_IPD_Trunk
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Tb_Prueba_Adc_IPD;

	// Inputs
	reg Clk;
	reg Rest;
	reg DataIn;
	reg [15:0] referen;

	// Outputs
	wire [15:0] salida;
	wire cs_1;
	wire sclk_1;

	// Instantiate the Unit Under Test (UUT)
	Prueba_ADC_IPD_Trunk uut (
		.Clk(Clk), 
		.Rest(Rest), 
		.DataIn(DataIn), 
		.referen(referen), 
		.salida(salida), 
		.cs_1(cs_1), 
		.sclk_1(sclk_1)
	);
	
	reg [15:0] datos[0:3];	/// cambiar la cantidad de datos
	reg [15:0] aux;
	integer i,j,arch_tex,num_datos = 4; //num_datos es la cantidad de estimulos para el ADC

	initial begin
		// Initialize Inputs
		Clk = 0;
		Rest = 1;
		DataIn = 0;
		referen = 0;
		aux = 16'b0;
		i = 0;
		j = 0;
		#10;
		Rest = 0;
      referen = 16'sb0100101100000000;  

	end
	

	initial
		begin
			$readmemb("datos_sim.txt",datos);
			arch_tex = $fopen("Salida_trunk.txt","w");
			//$fwrite(arch_tex,"   Estímulos      Salida ADC\n");
			@(posedge cs_1)
			for(j=0;j<num_datos;j=j+1)//se recorren la cantidad de filas
				begin
					@(negedge cs_1) aux = datos[j];
					for(i=15;i>-1;i=i-1)//se recorren la cantidad de bits por fila (16 en este caso)	
						begin
							DataIn = aux[i];
							@(posedge sclk_1);
						end
					@(posedge cs_1) $fwrite(arch_tex,"%b\n",salida);
				end
			$stop;	
		end

	initial forever begin
			#5 Clk = ~Clk;
		end
      
endmodule

