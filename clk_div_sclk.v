`timescale 1ns / 1ps

module clk_div_sclk( //Divisor de frecuencia para obtener sclk 706,71 kHz (16 veces 44,1 kHz)
	input wire clk,rst,
	output wire sclk
    );

reg[14:0] contador_sclk, contador_sclk_next;
wire pulse_sclk;

always@(posedge clk, posedge rst)
	begin
		if(rst)
			contador_sclk <= 15'b0;
		else
			contador_sclk <= contador_sclk_next;
	end

always@*
	begin
		contador_sclk_next = (pulse_sclk)? 15'b0: contador_sclk + 1'b1;
	end

assign pulse_sclk = (contador_sclk == 15'd31250);
assign sclk = pulse_sclk;



endmodule
