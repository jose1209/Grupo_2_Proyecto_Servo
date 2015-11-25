`timescale 1ns / 1ps

module ADC(
	input wire clk, rst, sdata, //serial data
	output wire [10:0] out, // 11 bits de salida
	output wire cs, sclk, desp_enable
	// cs: clock de muestreo de paquete de datos hacia el pmod
	//sclk: clock de muestreo de datos hacia el pmod
    );
	
	wire w_sclk, data_done;
	wire [11:0] dataout;
	wire [7:0] dataout_reg;
	wire signed [7:0] aux;
	
	div_clk div_frec(clk,rst,w_sclk);
	
	adc1 adc_modulo(w_sclk,rst,sdata,1'b1,data_done,dataout,cs,desp_enable);
	
	reg_adc Reg(w_sclk,rst,data_done,dataout,dataout_reg);
	
	assign sclk = w_sclk;
	
	assign aux = dataout_reg - 8'd128;
	assign out = {{3{aux[7]}},aux};
	
endmodule

