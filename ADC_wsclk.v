`timescale 1ns / 1ps

module ADC_wsclk(
	input wire clk,
	input wire rst, // reset
	input wire sdata, //serial data
	//output wire rx_done_tick,
	output wire [11:0] dataout_reg, // 12 bits de salida
	output wire cs, // clock de muestreo de paquete de datos hacia el pmod
	output wire sclk, //clock de muestreo de datos hacia el pmod
	output wire desp_enable
    );
	
	wire w_sclk;
	wire data_done;
	wire [11:0] dataout;
	
	clk_div_sclk ADC_sclk(clk,rst,w_sclk);
	
	ADC ADC_modulo(w_sclk,rst,sdata,1'b1,data_done,dataout,cs,desp_enable);
	
	Registro #(.R(12)) Reg(w_sclk,rst,data_done,dataout,dataout_reg);
	
	assign sclk = w_sclk;
	
endmodule
