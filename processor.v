'include "adder.v"
'include "inst_rom.v"
'include "controller.v"
'include "register.v"
'include "signextender.v"
'include "mux.v"
'include "alu.v"
'include "async_memory.v"
'include "serial_buf.v"
'include "data_memory.v"

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
	wire[31:0] pc_next;
	adder add(pc, 4, pc_next);
	always @(posedge clock)
		pc <= pc_next;
endmodule
/*
module mux2to1(selector, in0, in1, out);
module adder(a, b, sum);
module sign_extender(in, out);

module register(
	input clk,
	input write_enable,
	input[4:0] read_reg1, read_reg2, write_reg,
	input[31:0] write_d,
	output[31:0] read_d1, read_d2
);

module data_memory(
	input clock,
	input reset,

	input		[31:0]	addr_in,
	input		[31:0]	writedata_in,
	input					re_in,
	input					we_in,
	input		[1:0]		size_in,
	output	reg [31:0]	readdata_out,

	//serial port connection that need to be routed out of the process
	input		[7:0]		serial_in,
	input					serial_ready_in,
	input					serial_valid_in,
	output	[7:0]		serial_out,
	output				serial_rden_out,
	output				serial_wren_out
);

module inst_rom (
	input	clock,
	input reset,
	input [31:0] addr_in,
	output [31:0] data_out
);

module alu(
	input [5:0] Func_in,
	input [31:0] A_in,
	input [31:0] B_in,
	output reg [31:0] O_out,
	output reg Branch_out,
	output reg Jump_out
);
	// Mapping of Func_i to ALU Operations (X is don't care)
	// Func_in		O_out								"Operation"
	//--------------------------------------------------------------
	// 1000 0X		A + B								ADD
	// 1000 1X		A - B								SUB
	// 1001 00		A & B								AND
	// 1001 01		A | B								OR
	// 1001 10		A ^ B								XOR
	//	1001 11		~(A | B)							NOR
	//
	//	101 XX0		signed(A) < signed(B)		Set-Less-Than signed
	//	101 XX1		A < B								Set-Less-Than unsigned

	// 111 000		A									BLTZ
	//	111 001		A									BGEZ
	//	111 010		A									J/AL
	//	111 011		A									JR/AL
	//	111 100		A									BEQ
	//	111 101		A									BNE
	//	111 110		A									BLEZ
	//	111 111		A									BGTZ
