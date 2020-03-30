`timescale 1ns / 1ps
//-------------------------------------------------------
// File name    : alu.v
// Title        : ALU.
// Library      : nanoLADA
// Purpose      : Computer Architecture
// Developers   : Krerk Piromsopa, Ph. D.
//              : Chulalongkorn University.
module alu(
	output reg [31:0]	S, 
	output 	      z, 
	output reg 	  Cout, 
	input [31:0] 	A, 
	input [31:0] 	B, 
	input 	      Cin, 
	input [5:0] 	alu_ops
);

assign z = ~|S;

localparam ADD = 6'h20;
localparam SUB = 6'h22;
localparam AND = 6'h24;
localparam OR  = 6'h25;
localparam XOR = 6'h26;
localparam SLT = 6'h2a;


always @(A or B or alu_ops)
begin
	case (alu_ops)
		ADD: begin {Cout,S}=A+B+Cin; end
		SUB: begin {Cout,S}=A-B;     end
		OR : begin Cout=0; S=A|B;    end
		AND: begin Cout=0; S=A&B;    end
		XOR: begin Cout=0; S=A^B;    end
		SLT: begin Cout=0; S=A<B;    end
		default: begin Cout=0; S=0;  end
	endcase
end

endmodule
