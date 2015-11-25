`timescale 1ns / 1ps

module ADC(
	input wire clk, rst, sdata, //serial data
	output wire [15:0] out, // 11 bits de salida
	output wire cs, sclk, desp_enable_A
	// cs: clock de muestreo de paquete de datos hacia el pmod
	//sclk: clock de muestreo de datos hacia el pmod
    );
	
	wire w_sclk, data_done;
	wire [11:0] dataout;
	wire [7:0] dataout_reg;
	wire signed [7:0] aux;
	reg ban;
	
	div_clk div_frec(clk,rst,w_sclk);
	
	adc1 adc_modulo(w_sclk,rst,sdata,1'b1,data_done,dataout,cs,desp_enable);
	
	reg_adc Reg(w_sclk,rst,data_done,dataout,dataout_reg);
	
	assign sclk = w_sclk;
	
	assign aux = dataout_reg - 8'd1;
	//assign out = {{8{aux[7]}},aux};			///probar a ver como se comporta
	//assign out = {{8'b0},aux};
	assign out = {aux,{8'b0}};
///////////////////////////////////////////////////////////////////////////////////////////
/*
integer cont;

always@(posedge clk,posedge rst)
	begin
		if(rst || !cs)
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
	end*/
	
//assign desp_enable_A = desp_enable;
assign desp_enable_A = cs;
	
endmodule


