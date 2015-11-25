`timescale 1ns / 1ps

module div_clk( //Divisor de frecuencia para obtener sclk 3200 Hz (16 veces 200 Hz)
	input wire clk ,rst,
	output reg sclk
    );
	 
reg [13:0] cuenta; 
 
always @(posedge clk) 
		if(rst)
			begin
				sclk <= 14'b0;
				cuenta <= 1'b0;
			end 
		else 	
			if(cuenta == 14'd15624)
				begin                    
					cuenta <= 14'h0;  
					sclk <= ~sclk;  
				end 
			else 
				cuenta <= cuenta + 1'b1;
 
endmodule
