module register(
	input clk,
	input reset,
	input write_enable,
	input[4:0] read_reg1, read_reg2, write_reg,
	input[31:0] write_d,
	output[31:0] read_d1, read_d2
);
	reg[31:0] r[0:31];
	assign read_d1 = r[read_reg1];
	assign read_d2 = r[read_reg2];
	integer i;
	always @(posedge clk)
	begin
		if(reset)
			for (i = 0; i < 32; i=i+1)
				r[i] <= 0;
		if(write_enable)
			r[write_reg] <= write_d;
	end
endmodule
/*
module test;
	reg clk, we, reset;
	reg [4:0] read_reg1, read_reg2, write_reg;
	reg[31:0] write_d;
	wire[31:0] read_d1, read_d2;
	register rrr(clk, reset, we, read_reg1, read_reg2, write_reg, write_d, read_d1, read_d2);
	always #1 clk = !clk;
	initial begin
		$monitor("clk = %b : reset = %b\nrreg1 = %b : rreg2 = %b : d1 = %b : d2 = %b\nwe = %b : wreg = %b : wd = %b\n", clk, reset, read_reg1, read_reg2, read_d1, read_d2, we, write_reg, write_d);
		clk = 1; reset = 1;
		read_reg1 = 5; read_reg2 = 6;
		we = 0;
		#2 reset = 0;we = 1; write_reg = 5; write_d = 500;
		#2 $finish;
	end
endmodule
*/
