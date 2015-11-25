`timescale 1ns / 1ps

module ADC_wsclk(
	input wire clk,
	input wire rst, // reset
	input wire sdata, //serial data
	//output wire rx_done_tick,
	output wire [11:0] dataout_reg, // 12 bits de salida
	output wire cs, // clock de muestreo de paquete de datos hacia el pmod
	output wire sclk, //clock de muestreo de datos hacia el pmod
	output wire desp_enable,
	output reg ban
    );
	
	wire w_sclk;
	wire data_done,desp_enable_1;
	wire [11:0] dataout;
	
	//clk_div_sclk ADC_sclk(clk,rst,w_sclk);
	
	ADC ADC_modulo(w_sclk,rst,sdata,1'b1,data_done,dataout,cs,desp_enable_1);
	
	//Registro #(.R(12)) Reg(w_sclk,rst,data_done,dataout,dataout_reg);
	
	assign sclk = w_sclk;

//assign ban = desp_enable_1;
//assign desp_enable = desp_enable_1;

////////////////////////////////////////////////////////////////////////
//Corrige el error de sincronia generado en la codificacion con mas de un clk por lo que hace que el sistema se descoordine

integer cont;

always@(posedge clk,posedge rst)
	begin
		if(rst || !data_done)
			begin
				cont <= 0;
			end
			
		else
			cont <= cont + 1;
	end

always@*
	begin
		if(cont == 1)
			ban <= 1'b1;
		else
			ban <= 1'b0;
	end

	
endmodule
