`timescale 1ns / 1ps

module pwm #(parameter cant_bits = 8,sd = 39)(
				input wire clk,rst,
				input wire signed [cant_bits-1:0] PMW_in,
				output reg PWM_out
   );

wire signed [7:0] PWM_Suma;
assign PWM_Suma = PMW_in + 8'd1;

reg[13:0] counter=0;

always@(posedge clk, posedge rst)
begin
	if(rst == 1) 
		PWM_out = 0;
	else 
		begin 
			counter = counter + 1'b1;
				if(counter <= PWM_Suma*sd)
					PWM_out = 1;
				else 
					PWM_out = 0;
				if(counter >= 10000) 
					counter = 0; 
		end
end	


endmodule
