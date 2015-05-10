module adder(a, b, sum);
	input[31:0] a, b;
	output reg[31:0] sum;
	always @(a or b)
		sum = a + b;
endmodule
/*
module test;
	reg [31:0] a, b;
	wire [31:0] s;
	adder aaa(a, b, s);
	initial
	begin
		a = -4; b = 5;
		#1 $display("%b + %b = %b", a, b, s);
		$finish;
	end
endmodule
*/
