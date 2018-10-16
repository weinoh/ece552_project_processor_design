module BitCell( input clk,  input rst, input D, input WriteEnable, input ReadEnable1, input ReadEnable2, inout Bitline1, inout Bitline2);
	wire Q;
	// Instantiate D-Flip-Flop
	dff FF(.q(Q), .d(D), .wen(WriteEnable), .clk(clk), .rst(rst));
	
	// Instantiate two tri-states
	tri_buf read1 (.in(Q), .out(Bitline1), .enable(ReadEnable1));
	tri_buf read2 (.in(Q), .out(Bitline2), .enable(ReadEnable2));
	
	
endmodule
