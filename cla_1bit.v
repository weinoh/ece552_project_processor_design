// 1-bit adder with p, G output
module cla_1bit(A, B, Cin, Sum, P, G);

	input A, B, Cin;
	// sum, propogate, generate
	output Sum, P, G;
	wire P_int;
	// Output all three of these values:

	// generate bit
	assign G = A & B;
	// propogate bit	
	assign P_int = A ^ B;
	assign P = P_int;
	// sum bit
	assign Sum = P_int ^ Cin;

endmodule 
