`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:49:28 11/06/2015 
// Design Name: 
// Module Name:    regs 
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
module regs(
	input wire A,B,C,D,
	input wire clk,En,
	output reg W,X,Y,Z
    );
	 
	always @ (posedge clk )
	begin
	
	if(En) begin
			W <= A;
			X <= B;
			Y <= C;
			Z <= D;
			end
			
		else begin
		   W <= W;
			X <= X;
			Y <= Y;
			Z <= Z;
			end
	end

endmodule
