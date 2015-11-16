`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ITCR
// Engineer: 
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
module disp_mux_SS(
	input wire clk,reset,
	input wire [3:0] st,
	output wire [3:0] an,
	output wire [6:0] sseg
	);
	
	// Declaración de señales
	reg [6:0] t3reg;
	reg [6:0] t2reg;
	reg [6:0] t1reg;
	reg [6:0] t0reg;
	
	disp_mux instance_Disp_mux (
    .clk(clk), 
    .reset(reset), 
    .in3(t3reg), 
    .in2(t2reg), 
    .in1(t1reg), 
    .in0(t0reg), 
    .anod(an), 
    .ssegg(sseg)
    );
	
	//registro para los patrones de los 4 7-Segmentos
	
	always@*
	begin		
		t3reg = 0;
		t2reg = 0;
		t1reg = 0;
		t0reg = 0;
		case(st)
		
		4'b0000:		
			begin
				t3reg = 7'b1111111;		//50°
				t2reg = 7'b0100100;
				t1reg = 7'b0000001;
				t0reg = 7'b0011100;
			end			
		4'b0001:
			begin
				t3reg = 7'b1111111;		//75°
				t2reg = 7'b0001111;
				t1reg = 7'b0100100;
				t0reg = 7'b0011100;
			end			
		4'b0010:
			begin
				t3reg = 7'b1001111;				//100°
				t2reg = 7'b0000001;
				t1reg = 7'b0000001;
				t0reg = 7'b0011100;
			end
		4'b0011:
			begin
				t3reg = 7'b1001111;				//150°
				t2reg = 7'b0100100;
				t1reg = 7'b0000001;
				t0reg = 7'b0011100;
			end
		
		4'b0100:
			begin
				t3reg = 7'b1001111;				//175°
				t2reg = 7'b0001111;
				t1reg = 7'b0100100;
				t0reg = 7'b0011100;
			end
			
		4'b0101:
			begin
				t3reg = 7'b0010010;				//200°
				t2reg = 7'b0000001;
				t1reg = 7'b0000001;
				t0reg = 7'b0011100;
			end	
			
		4'b0110:
			begin
				t3reg = 7'b0010010;				//225°
				t2reg = 7'b0010010;
				t1reg = 7'b0100100;
				t0reg = 7'b0011100;
			end
		
		4'b0111:
			begin
				t3reg = 7'b0010010;				//250°
				t2reg = 7'b0100100;
				t1reg = 7'b0000001;
				t0reg = 7'b0011100;
			end
		
		
		4'b1000:
			begin
				t3reg = 7'b0010010;				//275°
				t2reg = 7'b0001111;
				t1reg = 7'b0100100;
				t0reg = 7'b0011100;
			end
			
		4'b1001:
			begin
				t3reg = 7'b0000110;				//300°
				t2reg = 7'b0000001;
				t1reg = 7'b0000001;
				t0reg = 7'b0011100;
			end			
		
		endcase
	end
endmodule
