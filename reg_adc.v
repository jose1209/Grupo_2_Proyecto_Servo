`timescale 1ns / 1ps

module reg_adc#(parameter R = 12)(
	input wire clk,rst,enable,
	input wire [R-1:0] A,
	output wire [R-5:0] Y
    );
	 
reg [R-5:0] data, data_next;
wire [R-1:0] aux;
assign aux = A;

always@(posedge clk, posedge rst)
	if(rst)
		data <= {R{1'b0}};
	else
		data <= data_next;

always@*
	begin
		data_next = data;
		if(enable)
			data_next = aux[R-1:R-8];
	end
	
assign Y = data;

endmodule

