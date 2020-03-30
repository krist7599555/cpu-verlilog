`timescale 10ns/10ns
//-------------------------------------------------------
// File name    : nanocpu.v
// Title        : nanoCPU.
// Library      : nanoLADA
// Purpose      : Computer Architecture
// Developers   : Krerk Piromsopa, Ph. D.
//              : Chulalongkorn University.
module nanocpu(
	output 	[31:0]	prog_address, 
	input 	[31:0]	prog_data, 
	output	[31:0]	data_address, 
	inout	  [31:0]	data_data, 
	output	  			mem_write, 
	input						clock,
	input						not_reset
);


wire [31:0]	instruction = prog_data;

wire	[5:0]	  opcode, funct;
wire	[4:0]	  rd, rs, rt, shamt;

assign { opcode, rd, rs, rt, shamt, funct } = instruction;

wire	[15:0]	imm  = { rt, shamt, funct };
wire	[25:0]	addr = { rd, rs, imm };



reg	  [31:0] pc;

// wire         sel_addpc;
// wire         sel_pc;
// wire 	[29:0] pc_add;
// wire         pc_cout;
// wire	[29:0] pc_add_b;
// wire	[29:0] addr_zeroext;
// wire	[29:0] pc_new;

assign prog_address=pc;
// assign addr_zeroext={{4{1'b0}},addr};

// adder	  #(.WIDTH(30)) PCADDER(pc_add, pc_cout, pc[31:2], pc_add_b, 1'b1);
// mux2_1	#(.WIDTH(30)) MUXADDPC(pc_add_b, {30{1'b0}}, imm_ext[29:0], sel_addpc);
// mux2_1	#(.WIDTH(30)) MUXSELPC(pc_new, pc_add, addr_zeroext, sel_pc);

// PC register
always @(posedge clock)
begin
	if (not_reset==0)
	begin
		pc=0;
	end
	else 
	begin
		pc=pc+4;
	end
end

wire	[31:0] imm_ext;
wire	[1:0]	 ext_ops;
extender EXTENDER(imm_ext, imm, ext_ops);

reg		z_flag;
reg		c_flag;

// wire	reg_wr;
// wire	sel_wr;
// wire	sel_data;
// wire	sel_b;
wire	z_new;
wire	c_new;

wire	[5:0]	alu_ops;

wire	[31:0]	A;
wire	[31:0]	B;
wire	[31:0]	data_selected;
wire	[31:0]	data_alu;
wire	[31:0]	data_M;
wire	[31:0]	B_selected;
wire	[4:0]	  rw = sel_wr ? rd : rt; // always rd


// assign data_address=data_alu;
// assign data_M=data_data;
// assign data_data=(mem_wr==1)?B:32'bz;

// mux2_1		#(.WIDTH(5)) MUXRW(rw,rd,rt,sel_wr);

// regfile		REGFILE(A, B, data_selected, rs, rt, rw, ~reg_wr, clock);

// mux2_1		MUXDATA(data_selected, data_alu, data_M, sel_data);
// mux2_1		MUXB(B_selected, B, imm_ext, sel_b);

alu		    ALU(data_alu, z_new, c_new, A, sel_b ? B : imm_ext, 1'b0, alu_ops);
regfile		REGFILE(A, B, data_alu, rs, rt, rw, ~reg_wr, clock);


localparam OR  = 6'h25;
control	CONTROLUNIT(
	// output
	sel_pc,
	sel_addpc,
	sel_wr,
	sel_b,
	sel_data,
	reg_wr,
	mem_wr,
	ext_ops,
	alu_ops,
	// input
	opcode,
	funct,
	z_new
);

// // flag
always @(posedge clock)
begin
	if (not_reset == 0)
	begin
		z_flag = 0;
		c_flag = 0;
	end
	else
	begin
		z_flag = z_new;
		c_flag = c_new;
	end
end


endmodule
