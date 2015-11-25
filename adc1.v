`timescale 1ns / 1ps

module adc1(
	input wire sclk, //clock con frecuencia de 3200 Hz
	input wire rst, // reset
	input wire sdata, //serial data
	input wire rx_en, // parte del protocolo, se coloca en alto siempre
	output wire rx_done_tick, //bandera que indica que se tomaron los 12 bits
	output wire [11:0] dataout, // 12 bits de salida
	output wire	 cs1, // clock de muestreo 
	output wire desp_enable
    );
	 	 
		 reg cs;
		 BUFG BUFG_inst(
			.O(cs1),
			.I(cs)
		 );
		 
//Lógica para obtener los datos del ADC:

reg [11:0] reg_desp, reg_desp_next;

always @ (negedge sclk, posedge rst)
	if(rst)
		reg_desp <= 12'h800;
	else
		reg_desp <= reg_desp_next;

always @ *
	begin
		reg_desp_next = reg_desp;
		if(desp_enable)
			reg_desp_next = {reg_desp[10:0],sdata};
	end
	
//Lógica para generar el CS:	
	
reg state,state_next;
reg[3:0] contador, contador_next;

always@(posedge sclk, posedge rst)
	if(rst)
		begin
			state <= 1'b0;
			contador <= 4'b0;
		end
	else
		begin
			state <= state_next;
			contador <= contador_next;
		end
		
always @ *
	begin
		state_next = state;
		contador_next = 4'b0;
		cs = 1'b0;
		case(state)
			1'b0:
				begin
					cs = 1'b1;
					state_next = 1'b1;
				end
			1'b1:
				begin
					contador_next = contador + 1'b1;
					if(contador == 4'd15)
						begin
							state_next = 1'b0;
						end
				end
				
		endcase
	end

assign desp_enable = state;
assign rx_done_tick = ~state & rx_en;
assign dataout = reg_desp;
			
endmodule
