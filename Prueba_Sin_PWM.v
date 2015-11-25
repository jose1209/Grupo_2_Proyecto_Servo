`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:35:39 11/18/2015
// Design Name:   Prueba_ADC_IPD_Trunk
// Module Name:   C:/Lab Digitales/Servo_3.0/Prueba_Sin_PWM.v
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

module Prueba_Sin_PWM;

	// Inputs
	reg Clk;
	reg Rest;
	reg DataIn;

	// Instantiate the Unit Under Test (UUT)
	Prueba_ADC_IPD_Trunk uut (
		.Clk(Clk), 
		.Rest(Rest), 
		.DataIn(DataIn)
	);

	initial begin
		// Initialize Inputs
		Clk = 0;
		Rest = 0;
		DataIn = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

