`timescale 1ns / 1ps

module ADC_final#(parameter cant_bits = 13)(
	input wire clk,rst,sdata,
	output wire cs, sclk, desp_enable,
	output wire signed [cant_bits-1:0] dato_final
    );

wire signed[11:0] salidaADC;

ADC_wsclk adc_final (
    .clk(clk), 
    .rst(rst), 
    .sdata(sdata), 
    .dataout_reg(salidaADC), 
    .cs(cs), 
    .sclk(sclk), 
    .desp_enable(desp_enable)
    );
	 
concatena concat (
    .dato(salidaADC), 
    .out(dato_final)
    );

endmodule
