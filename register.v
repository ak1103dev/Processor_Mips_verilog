module register(
	input clk,
	input write_enable,
	input[4:0] read_reg1, read_reg2, write_reg,
	input[31:0] write_d,
	output[31:0] read_d1, read_d2
);
	reg[31:0] register[0:31];
	assign read_d1 = register[read_reg1];
	assign read_d2 = register[read_reg2];
	always @(negedge clk)
	begin
		if(write_enable)
			register[write_reg] <= write_d;
	end
endmodule

/*
module test;
	reg clk, we;
	reg [4:0] read_reg1, read_reg2, write_reg;
	reg[31:0] write_d;
	wire[31:0] read_d1, read_d2;
	register rrr(clk, we, read_reg1, read_reg2, write_reg, write_d, read_d1, read_d2);
	always #1 clk = !clk;
	initial begin
		$monitor("clk = %b\nrreg1 = %b : rreg2 = %b : d1 = %b : d2 = %b\nwe = %b : wreg = %b : wd = %b\n", clk, read_reg1, read_reg2, read_d1, read_d2, we, write_reg, write_d);
		clk = 1; read_reg1 = 5; read_reg2 = 6;
		we = 0;
		#2 we = 1; write_reg = 5; write_d = 500;
		#2 $finish;
	end
endmodule
*/
