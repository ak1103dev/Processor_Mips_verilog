module sign_extender(in, out);
	input[15:0] in;
	output reg [31:0] out;

	always @(in)
	begin
		if (in[15]) begin
			out[31:16] = 'hffff;
		   	out[15:0] = in;
		end
		else
			out = in;
	end
endmodule

/*
module test;
	reg [15:0] in;
	wire [31:0] out;
	sign_extender sss(in, out);
	initial begin
		in = 67;
		#1 $display("in = %b, out = %b", in, out);
		in = -200;
		#1 $display("in = %b, out = %b", in, out);
		$finish;
	end
endmodule
*/
