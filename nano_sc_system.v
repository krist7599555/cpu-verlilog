`timescale 1ns / 1ps
//-------------------------------------------------------
// File name    : nano_sc_system.v
// Title        : nanoCPU Single Cycle system.
// Library      : nanoLADA
// Purpose      : Computer Architecture
// Developers   : Krerk Piromsopa, Ph. D.
//              : Chulalongkorn University.

module nano_sc_system();

wire 	[31:0]	p_address;
wire 	[31:0]	p_data;
wire	[31:0]	d_address;
wire		      mem_wr;
wire	[31:0]	d_data;
reg		        clock;
reg		        not_reset;

rom 	  PROGMEM(p_data, p_address[28:2]);
memory 	DATAMEM(d_data, d_address[28:2], mem_wr, clock);
nanocpu	CPU(p_address, p_data, d_address, d_data, mem_wr, clock, not_reset);

initial
begin
	$dumpfile("nano_sc_system.vcd");
	$dumpvars(4, nano_sc_system);

	clock=0;
	not_reset=0;
	#100;
	not_reset=1;
	#900;
	$finish;
end

always
begin : CLOCK
	#50
	clock = ~clock;
end


endmodule
