`timescale 1ns / 1ps

module pwm #(parameter cant_bits = 8)(
				input wire clk,rst,
				input wire [cant_bits-1:0] PMW_in,
				output wire PWM_out
   );
	
reg [5:0] cuenta; 
reg s_clk; 					   
always @(posedge clk) 
begin
	if(rst)
		begin
			s_clk <= 6'b0;
			cuenta <= 1'b0;
		end 
	else 
		if(cuenta == 6'd50)
			begin                    
				cuenta <= 6'h0;  
				s_clk <= ~s_clk;  
			end 
		else 
			cuenta <= cuenta + 1'b1;
end	
	
	
	
	
   reg [cant_bits:0] counter;
     
   always@(posedge s_clk)
		
         counter <= counter[cant_bits-1:0] + PMW_in ;
       
		 
assign PWM_out = counter[cant_bits];
endmodule
