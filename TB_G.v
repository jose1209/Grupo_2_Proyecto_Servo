`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:01:27 11/19/2015
// Design Name:   Proyecto_Servo
// Module Name:   C:/Lab Digitales/Servo_3.0/TB_G.v
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

module TB_G;

	// Inputs
	reg DataIn;
	reg Clk_P;
	reg Rst_P;
	reg a;
	reg b;
	reg c;
	reg d;
	reg Enable;

	// Outputs
	wire Salida_PWM;
	wire [6:0] Nadaout;
	wire [10:0] seven_segs;
	wire cs_1;
	wire sclk_1;

	// Instantiate the Unit Under Test (UUT)
	Proyecto_Servo uut (
		.DataIn(DataIn), 
		.Clk_P(Clk_P), 
		.Rst_P(Rst_P), 
		.a(a), 
		.b(b), 
		.c(c), 
		.d(d), 
		.Enable(Enable), 
		.Salida_PWM(Salida_PWM), 
		.Nadaout(Nadaout), 
		.seven_segs(seven_segs), 
		.cs_1(cs_1), 
		.sclk_1(sclk_1)
	);

	reg [15:0] datos[0:3];	/// cambiar la cantidad de datos
	reg [15:0] aux;
	integer i,j,arch_tex,num_datos = 4; //num_datos es la cantidad de estimulos para el ADC

	initial begin
		// Initialize Inputs
		
		DataIn = 0;
		Clk_P = 0;
		Rst_P = 1;
		a = 0;
		b = 0;
		c = 0;
		d = 0;
		Enable = 1;
		aux = 16'b0;
		i = 0;
		j = 0;
		#10
		Rst_P = 0;
		Enable = 0;
		
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
					@(posedge cs_1) $fwrite(arch_tex,"%b\n",Salida_PWM);
				end
			$stop;	
		end

	initial forever begin
			#5 Clk_P = ~Clk_P;
		end   
		
		
endmodule

