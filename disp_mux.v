`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ITCR
// Engineer:
// 
// Create Date:   
// Design Name: 
// Module Name:    
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
module disp_mux(
    input wire clk,reset,
	 input [6:0] in3, in2, in1, in0,
	 output reg [3:0] anod,    
	 output reg [6:0] ssegg	 );
	 
	localparam N = 18;
	
	reg [N-1:0] q_reg;
	wire [N-1:0] q_next;
	
	always@(posedge clk , posedge reset)
		if(reset)
			q_reg <= 0 ;
		else
			q_reg <= q_next;
	
	assign q_next = q_reg + 1'b1;
			
	
	always@*
	begin
		anod = 0;
		ssegg = 0;
		case (q_reg [N-1: N-2])
			2'b00:
				begin
					anod = 4'b1110;
					ssegg = in0;
				end
			2'b01:
				begin
					anod = 4'b1101;
					ssegg = in1;
				end
			2'b10:
				begin
					anod = 4'b1011;
					ssegg = in2;
				end
			2'b11:
				begin
					anod = 4'b0111;
					ssegg = in3;
				end
		endcase
	end
endmodule
