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
module concatena#(parameter cant_bits = 16)(
						input wire signed [11:0] dato,
						output wire signed [cant_bits-1:0] out
    );

reg signed [cant_bits-1:0]cable;

always @*
begin
	cable = $signed({dato[7:0]}); //modificacion por recomendacion
	//cable = {dato[11:4],4'b0};
end

assign out = cable - 16'd1;
endmodule
