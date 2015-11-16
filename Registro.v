`timescale 1ns / 1ps

module Registro#(
	parameter R = 16
	)
	(
	input wire clk,rst,enable,
	input wire [R-1:0] A,
	output wire [R-1:0] Y
    );
	 
reg[R-1:0] data, data_next;

always@(posedge clk, posedge rst)
begin
	if(rst)
		data <= {R{1'b0}};
	else
		data <= data_next;
end
always@*
	begin
		data_next = data;
		if(enable)
			data_next = A;
	end
	
assign Y = data;

endmodule