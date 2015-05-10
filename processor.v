`include "adder.v"
`include "inst_rom.v"
`include "controller.v"
`include "register.v"
`include "signextender.v"
`include "mux.v"
`include "alu.v"
`include "async_memory.v"
`include "serial_buf.v"
`include "data_memory.v"

module processor(
	input clock,
	input reset,
	input[7:0] serial_in,
	input serial_valid_in,
	input serial_ready_in,
	output[7:0] serial_out,
	output serial_rden_out,
	output serial_wren_out
);
	reg[31:0] pc;
	wire[31:0] pc_4;
	wire[31:0] pc_next;
	wire[31:0] instruction;
	wire[31:0] read_data_reg1, read_data_reg2;
	wire[31:0] write_back;
	wire[31:0] write_reg;

	wire RegDst;
	wire RegWrite;
	wire ALUSrc;
	wire MemRead;
	wire MemWrite;
	wire MemToReg;
	wire Jump;
	wire Branch;
	wire[1:0] size_in;

	wire[5:0] ALUOp;
	wire[31:0] immediate;

	wire[31:0] B_in;
	wire[31:0] result_alu;
	wire Branch_out;
	wire Jump_out;

	wire[31:0] address_branch;
	wire[31:0] address_noJump;
	wire[31:0] address_Jump;

	wire[31:0] read_data_mem;


	always @(posedge clock)
		pc <= pc_next;

	adder add_pc(pc, 4, pc_4);
    inst_rom instruction_memory(clock, 0, pc_next, instruction);
 	register regis_mod(clock, RegWrite, instruction[25:21], instruction[20:16], write_reg[4:0], write_back, read_data_reg1, read_data_reg2);
	controller control_unit(instruction[31:26], instruction[5:0], instruction[20:16], {RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemToReg, Jump, Branch}, ALUOp, size_in);
	mux2to1 writeRegSelector(RegDst, {27'b0, instruction[20:16]}, {27'b0, instruction[15:11]}, write_reg);
	sign_extender sign_ex16to32(instruction[15:0], immediate);
	mux2to1 alu_source(ALUSrc, read_data_reg2, immediate, B_in);
	alu alu(ALUOp, read_data_reg1, B_in, result_alu, Branch_out, Jump_out);

	assign is_branch = Branch_out & Branch;
	adder add_branch(pc_4, immediate<<2, address_branch);
	mux2to1 mux_branch(is_branch, pc_4, address_branch, address_noJump);
	assign address_Jump = instruction[25:0] << 2;
	mux2to1 mux_jump(Jump_out & Jump, address_noJump, address_Jump, pc_next);

	data_memory dataMemory(clock, 'b0, result_alu, read_data_reg2, MemRead, MemWrite, size_in, read_data_mem, serial_in, serial_valid_in, serial_ready_in, serial_out, serial_rden_out, serial_wren_out);

	mux2to1 mux_write_back(MemToReg, result_alu, read_data_mem, write_back);

endmodule
