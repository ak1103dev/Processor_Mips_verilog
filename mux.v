module mux2to1(selector, in0, in1, out);
	input selector;
	input[31:0] in0, in1;
	output reg [31:0] out;

	always @(selector or in0 or in1)
		if (selector) out = in1;
		else out = in0;
endmodule

/*
module test;
	reg [31:0] a, b;
	reg s;
	wire [31:0] c;
	mux2to1 mmm(s, a, b, c);

	initial begin
		a = 128; b = 200;
		s = 0;
		#1 $display("s = %b, a = %b, b = %b, output = %b", s, a, b, c);
		s = 1;
		#1 $display("s = %b, a = %b, b = %b, output = %b", s, a, b, c);
		$finish;
	end
endmodule
*/
