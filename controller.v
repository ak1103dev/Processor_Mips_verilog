module controller(
	input [5:0] opcode,
	input [5:0] func,
	input [4:0] rt,
	output reg [7:0] ctrl,
	output reg [5:0] aluOp
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
	parameter rType = 'b000000;
	parameter jump = 'b000010;
	parameter jal = 'b000011;
	parameter beq = 'b000100;
	parameter bne = 'b000101;
	parameter blez = 'b000110;
	parameter bgtz = 'b000111;
	parameter addi = 'b001000;
	parameter addiu = 'b001001;
	parameter slti = 'b001010;
	parameter sltiu = 'b001011;
	parameter andi = 'b001100;
	parameter ori = 'b001101;
	parameter xori = 'b001110;
	parameter lb = 'b100000;
	parameter lbu = 'b100100;
	parameter lh = 'b100001;
	parameter lhu = 'b100101;
	parameter lw = 'b100011;
	parameter sb = 'b101000;
	parameter sh = 'b101001;
	parameter sw = 'b101011;

	always @(opcode) begin
		case(opcode)
		rType :
		begin
			ctrl = 'b11000000;
			aluOp = func;
		end
		jump :
		begin
			ctrl = 'bx0000010;
			aluOp = 'b111010;
		end
		jal :
		begin
			ctrl = 'bx0000010;
			aluOp = 'b111010;
		end
		beq :
		begin
			ctrl = 'bx0000x01;
			aluOp = 'b111100;
		end
		bne :
		begin
			ctrl = 'bx0000x01;
			aluOp = 'b111101;
		end
		blez :
		begin
			ctrl = 'bx0100x01;
			aluOp = 'b111110;
		end
		bgtz :
		begin
			ctrl = 'bx0100x01;
			aluOp = 'b111111;
		end
		addi :
		begin
			ctrl = 'b01100000;
			aluOp = 'b100000;
		end
		addiu :
		begin
			ctrl = 'b01100000;
			aluOp = 'b100001;
		end
		slti :
		begin
			ctrl = 'b01100000;
			aluOp = 'b101010;
		end
		sltiu :
		begin
			ctrl = 'b01100000;
			aluOp = 'b101011;
		end
		andi :
		begin
			ctrl = 'b01100000;
			aluOp = 'b100100;
		end
		ori :
		begin
			ctrl = 'b01100000;
			aluOp = 'b100101;
		end
		xori :
		begin
			ctrl = 'b01100000;
			aluOp = 'b100110;
		end
		lb :
		begin
			ctrl = 'b01110100;
			aluOp = 'b100000;
		end
		lbu :
		begin
			ctrl = 'b01110100;
			aluOp = 'b100000;
		end
		lh :
		begin
			ctrl = 'b01110100;
			aluOp = 'b100000;
		end
		lhu :
		begin
			ctrl = 'b01110100;
			aluOp = 'b100000;
		end
		lw :
		begin
			ctrl = 'b01110100;
			aluOp = 'b100000;
		end
		sb :
		begin
			ctrl = 'bx0101x00;
			aluOp = 'b100000;
		end
		sh :
		begin
			ctrl = 'bx0101x00;
			aluOp = 'b100000;
		end
		sw :
		begin
			ctrl = 'bx0101x00;
			aluOp = 'b100000;
		end

		endcase

	end
endmodule

module test;
	reg [5:0] op, func;
	reg [4:0] rt;
	wire [7:0] c;
	wire [5:0] aluop;
	controller ccc(op, func, rt, c, aluop);
	initial begin
		$monitor("opcode = %b : rt = %b : control = %b : function = %b : aluop = %b", op, rt, c, func, aluop);
		op = 'b000000; func = 'b101010; rt = 'b11111;
		#2 op = 'b101000; func = 'bxxxxxx; rt = 'b11111;
	end
endmodule
