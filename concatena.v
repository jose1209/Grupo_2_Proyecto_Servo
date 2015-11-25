`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:03:31 09/26/2015 
// Design Name: 
// Module Name:    conversion 
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
module concatena#(parameter cant_bits = 13)(
						input wire signed [cant_bits-2:0] dato,
						output reg signed [cant_bits-1:0] out
    );

always @*
	out = {6'b0,{dato[11:5],~{dato[4]}}};
endmodule
