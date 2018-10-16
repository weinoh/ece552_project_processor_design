// TODO: Use SAT4_bit signal so that this can be used for other functions. 
module cla_4bit(A, B, Ci, saturate, Sum, Co, PG, GG);
	input [3:0] A, B;
	input Ci, saturate;
	output Co, PG, GG;
	output [3:0] Sum;
	
	// Generate and Propogate Values for each bit
	wire [3:0] G, P, raw_sum;
	wire[3:1] C;
	
	// Find Carry Values
	cla_logic carryLogic(.G(G), .P(P), .Ci(Ci), .C(C), .Co(Co), .PG(PG), .GG(GG));
	
	// Four 1 bit CLA 
	cla_1bit cla_bit0(.A(A[0]), .B(B[0]), .Cin(Ci), .Sum(raw_sum[0]), .P(P[0]), .G(G[0]));
	cla_1bit cla_bit1(.A(A[1]), .B(B[1]), .Cin(C[1]), .Sum(raw_sum[1]), .P(P[1]), .G(G[1]));
	cla_1bit cla_bit2(.A(A[2]), .B(B[2]), .Cin(C[2]), .Sum(raw_sum[2]), .P(P[2]), .G(G[2]));
	cla_1bit cla_bit3(.A(A[3]), .B(B[3]), .Cin(C[3]), .Sum(raw_sum[3]), .P(P[3]), .G(G[3]));
	
	
	assign Sum[3:0] =  saturate ? (( raw_sum[3] & (~A[3]) & (~B[3]) ) ? 4'b0111 : (~raw_sum[3] & (A[3]) & (B[3]) ) ? 4'b1000 : raw_sum[3:0]) : raw_sum[3:0];
	
endmodule

	
	
	// Carry lookahead logic for 4 bits
module cla_logic(G, P, Ci, C, Co, PG, GG);
	input [3:0] G, P;
	input Ci;
	output [3:1] C;
	output Co, PG, GG;

	wire GG_int, PG_int;
	
	// Each Carry Logic
	assign C[1] = G[0] | (P[0] & Ci);
	
	assign C[2]= G[1] | (P[1] & G[0]) | (P[1] & P[0] & Ci);
	
	assign C[3]= G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & Ci);
	
	// General/Overall Generate Logic
	assign GG_int = G[3] | (P[3] & G[2]) |(P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);
	// General/Overall Propogate Logic
	assign PG_int = P[3] & P[2] & P[1] & P[0] & Ci;
	assign GG = GG_int;
	assign PG = PG_int;
	assign Co = GG_int | (PG_int & Ci);
	
endmodule 
