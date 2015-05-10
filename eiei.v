module controller(
	input [5:0] opcode,
	//input [5:0] func,
	//input zero,
	output reg [7:0] ctrl
);
	//control
	//output
	//7   : RegDst
	//6   : RegWrite
	//5   : ALUSrc
	//4   : MemRead
	//3   : MemWrite
	//2   : MemToReg
	//1   : Jump
	//0   : Branch
	always @(opcode) begin
		case(opcode)
			'b000000|R-Type
				ctrl = 'b110000zz;// R-type
			'b000001|branch reg, offset
				ctrl = 'bx0000xzz;// beq
				/*
			'b000010|j
			'b000011|jal
				ctrl = 'bx0000xzz;// jump
			'b000100|beq
			'b000101|bne
			'b000110|blez
			'b000111|bgtz
				ctrl = 'bx0000xzz;// beq
			'b001000|addi
			'b001001|addiu
			'b001010|slti
			'b001011|sltiu
			'b001100|andi
			'b001101|ori
			'b001110|xori
			'b001111|lui
				ctrl = 'b011000zz;// Arith Imm
			'b100000|lb
			'b100100|lbu
			'b100001|lh
			'b100101|lhu
			'b100011|lw
				ctrl = 'b011101zz;// load
			'b101000|sb
			'b101001|sh
			'b101011|sw
				ctrl = 'bx0101xzz;// store
				*/
		endcase
	end
endmodule
/*
module test;
	reg [5:0] op;
	wire [7:0] c;
	controller ccc(op, c);
	initial begin
		$monitor("opcode = %b : control = %b", op, c);
		op = 'b000000;
		#2 op = 'b000001;
	end
endmodule
*/
