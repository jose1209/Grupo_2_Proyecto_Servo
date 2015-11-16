`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:26:06 09/26/2015 
// Design Name: 
// Module Name:    redondeo 
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

// REVISAR


/* module redondeo#(parameter cant_bits = 12, ent = 2, frac = 10)(
					input wire signed [(2*ent+2*frac)-1:0] in,
					output reg signed [cant_bits-1:0] out
    );

initial out = 0;

localparam [cant_bits-1:0]	ceros = 0,
									unos = ~ceros;
								
reg [(2*ent+2*frac)-1:0] aux;
assign aux = in;
	 
always @ *
	begin
		if(in[(2*ent+2*frac)-1]==0 && in[2*cant_bits-3:2*frac+ent]>0)			//overflow
			out = {1'b0,unos};
		else if(in[2*ent+2*frac]==1 && (in[2*ent+2*frac-1:(2*frac+ent)])==0)		//overflow negativo	
			out = {1'b1,ceros};			
		else
			out = {in[2*ent+2*frac],in[2*frac+ent-1:frac]};
	end
endmodule*/


module redondeo#(parameter cant_bits = 13, ent = 6, frac = 7)(
					input wire signed [2*cant_bits-1:0] in,           /// 26 bits
					output reg signed [cant_bits-1:0] out ,              /// 3 bits
					output wire [frac-1:0] nada					/// 12 bits
    );

initial out = 0;


localparam [cant_bits-2:0]	ceros = 0,        // 12 bits
									unos = ~ceros;
									
wire signed [2*cant_bits-1:0] aux;		//	26 bits

assign aux = in;
	 
always @*

	begin
	
	if(aux[2*cant_bits-1] == 0 && (aux[2*cant_bits-2:(2*frac+ent)-1]) != 0)		//overflow
			out = {1'b0,unos};
		else if(aux[2*cant_bits-1] == 1 && (aux[2*cant_bits-2:(2*frac+ent)-1]) != 1)		//overflow negativo	
			out = {1'b1,ceros};			
		else
			out = {aux[2*cant_bits-1],aux[2*frac+ent-2:frac]};
			
			
	end
	
	assign nada = aux[frac-1:0] ;
	
endmodule