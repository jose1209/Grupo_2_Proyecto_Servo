`timescale 1ns / 1ps

module pwm #(parameter cant_bits = 8,sd = 39)(
				input wire clk,rst,
				input wire signed [cant_bits-1:0] PMW_in,
				output reg PWM_out
   );

wire signed [7:0] PWM_Suma;
assign PWM_Suma = PMW_in ;//+ 8'd128;

/*	
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
       
		 
assign PWM_out = counter[cant_bits];*/

 
reg[13:0] counter=0;

//------------suma de 128 para poner offset


//------------

always@(posedge clk)
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
