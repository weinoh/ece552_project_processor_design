module PC_control(C, I, F, PC_in, PC_out, hlt, rs, branch);
	
	input [2:0] C;
	input [8:0] I;
	input[2:0] F;
	// Source register for BR
	input [15:0] rs; 
	input [15:0] PC_in;
	output [15:0] PC_out;
	// active low reset, halt, and B/BR flag
	input hlt;
	input [1:0] branch;

	

	wire[15:0] ADD_2, ADD_JUMP, SIGN_EXTENDED;
	
	wire Z, V, N, GT, GTE, OVFL, OVFL2;

	wire [15:0] CondOut;
	
	
	
	assign Z = F[2];
	assign V = F[1];
	assign N = F[0];
	
	assign GT = !(Z | N);
	assign GTE = Z | GT;
	
	assign cond = (C == 3'b000) ? !Z :
				  (C == 3'b001) ? Z  :
				  (C == 3'b010) ? GT :
				  (C == 3'b011) ? N  :
				  (C == 3'b100) ? Z | (GT) :
				  (C == 3'b101) ? !GT :
				  (C == 3'b110) ? V :
				  (C == 3'b111) ? 1 : 0;
	
	assign Pout = (branch[1]) ? cond : 0;
				  
	
	// pc + 2
	
	//PSA_16bit adder(.Sum(ADD_2), .Error(OVFL), .A(PC_in), .B(16'b10));
	
	cla_16 adder(.C0(1'b0), .Carry(1'b1), .Sat_4bit(1'b0), .Sat_16bit(1'b0), .A(PC_in), .B(16'b10), .Sum(ADD_2), .C15(), .C16());
	//Sign extended IMM
	assign SIGN_EXTENDED = {{6{I[8]}}, I[8:0], 1'b0}; 
	
	// PC + 2 + imm
	//PSA_16bit adderIm(.Sum(ADD_JUMP), .Error(OVFL2), .A(ADD_2), .B(SIGN_EXTENDED));
	cla_16 adderIm (.C0(1'b0), .Carry(1'b1), .Sat_4bit(1'b0), .Sat_16bit(1'b0), .A(ADD_2), .B(SIGN_EXTENDED), .Sum(ADD_JUMP), .C15(), .C16());
	
	// if branch is 0 it is B else it is BR, else simply add_2 to the pc
	assign CondOut = Pout ? ((branch[0]) ? rs : ADD_JUMP): ADD_2;
	
	
	// If reset is 0 PC_out = 0, if hlt is 1 PC_out = PC, else CondOut;
	
	assign PC_out = hlt ? PC_in: CondOut;
	
	endmodule
