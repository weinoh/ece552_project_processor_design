// 16 bit carry lookahead adder
// TODO: USE SAT_16Bit signal so that this can be used for other functions.
module cla_16bit(A, B, Ci, saturate_16, saturate_4, Sum, Co, PG, GG);
	input [15:0] A, B;
	input Ci, saturate_16, saturate_4;
	output [15:0] Sum;
	output Co, PG, GG;
	wire [3:0] S0, S1, S2, S3, G, P;
	wire [3:1] C;
	wire dummy;
	
	cla_logic carryLogic(.G(G), .P(P), .Ci(Ci), .C(C), .Co(Co), .PG(PG), .GG(GG));
	
	cla_4bit CLA_0(.A(A[3:0]), .B(B[3:0]), .Ci(Ci), .saturate(saturate_4), .Sum(S0), .Co(dummy), .PG(P[0]), .GG(G[0]));
	cla_4bit CLA_1(.A(A[7:4]), .B(B[7:4]), .Ci(C[1]), .saturate(saturate_4), .Sum(S1), .Co(dummy), .PG(P[1]), .GG(G[1]));
	cla_4bit CLA_2(.A(A[11:8]), .B(B[11:8]), .Ci(C[2]), .saturate(saturate_4), .Sum(S2), .Co(dummy), .PG(P[2]), .GG(G[2]));
	cla_4bit CLA_3(.A(A[15:12]), .B(B[15:12]), .Ci(C[3]), .saturate(saturate_4), .Sum(S3), .Co(dummy), .PG(P[3]), .GG(G[3]));

	assign Sum = (S3[3] & (~A[15]) & (~B[15])) ? 16'h7FFF : (~S3[3] & (A[15]) & (B[15])) ? 16'h8000 : {S3, S2, S1, S0};
	assign Sum = saturate_16 ? ( (S3[3] & ((~A[15]) & (~B[15]))) ? 16'h7FFF : (~S3[3] & ((A[15]) & (B[15]))) ? 16'h8000 : {S3, S2, S1, S0}): {S3, S2, S1, S0};
endmodule

