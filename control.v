`timescale 1ns / 1ps
//-------------------------------------------------------
// File name    : control.v
// Title        : Control Unit.
// Library      : nanoLADA
// Purpose      : Computer Architecture, Design and Verfication
// Developers   : Krerk Piromsopa, Ph. D.
//              : Chulalongkorn University.

module control(	
	output reg sel_pc,
	output reg sel_addpc,
	output reg sel_wr,
	output reg sel_b,
	output reg sel_data,
	output reg reg_wr,
	output reg mem_wr,
	output reg [1:0] ext_ops,
	output reg [5:0] alu_ops,
	input [5:0] opcode,
	input [5:0] funct,
	input z_flag
);


// R-type op=0
localparam RType = 6'b000000;

// R-type function 
localparam ADD = 6'h20;
localparam SUB = 6'h22;
localparam MUL = 6'h18;
localparam DIV = 6'h1a;
localparam AND = 6'h24;
localparam OR  = 6'h25;
localparam XOR = 6'h26;
localparam SLT = 6'h2a; // is less than


// I-type
localparam BEQ=6'h04;
localparam BNQ=6'h05;
localparam ORI=6'h0d;

// J-type
localparam JMP=6'h02;

wire is_rtype = opcode == 5'b00000;
wire is_ltype = opcode > 3;
// wire is_jtype = opcode == 2 || opcode == 3


// sel_pc
always @(opcode)
begin
	case (opcode)
		// JMP : sel_pc=1;
		default : sel_pc=0;
	endcase
end

// sel_addpc
always @(opcode or z_flag)
begin
	case (opcode)
		// BEQ : sel_addpc=z_flag;
		default : sel_addpc=0;
	endcase
end

// sel_wr
always @(opcode)
begin
	case (opcode)
		default : sel_wr=1;
	endcase
end

// sel_b
always @(opcode)
begin

	case (opcode)
		ORI : sel_b=0; // use immediat
		// ORUI : sel_b=1;
		// LW : sel_b=1;
		// SW : sel_b=1;
		default : sel_b=1;
	endcase
end

// sel_data
always @(opcode)
begin
	case (opcode)
		// LW : sel_data=1;
		default : sel_data=0;
	endcase
end

// reg_wr
always @(opcode)
begin
	case (opcode)
		default : reg_wr=1;
	endcase
end

// mem_wr
always @(opcode)
begin
	case (opcode)
		// SW : mem_wr=1;
		default : mem_wr=0;
	endcase
end

// ext_ops
always @(opcode)
begin
	case (opcode)
		// ORUI : ext_ops=2'b10;
		// LW : ext_ops=2'b01;
		// SW : ext_ops=2'b01;
		// BEQ : ext_ops=2'b01;
		default : ext_ops=2'b00;
	endcase
end

// alu_ops
always @(opcode)
begin
	if (is_rtype)
	begin
		alu_ops=funct;	
	end
	else
	begin
		case(opcode)
			ORI: alu_ops = OR;
			default: alu_ops = ADD;
		endcase
	end
end

endmodule
	
