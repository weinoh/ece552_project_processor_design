
module control_unit(input [15:0]Instr, output RegSel, output RegWrite, output ALUSrc1, output Memwrite, output[1:0] ALUSrc, output [1:0] MemCtrl, output hlt, output[1:0] Branch);
//RegSel
assign RegSel = ~Instr[15] ? 0 : 1;
//RegWrite
assign RegWrite = ~Instr[15] | (Instr[13] & ~Instr[12]) | (Instr[15] & ~Instr[14] & Instr[13]) | (Instr[15:12] == 4'b1000);
//Memwrite
assign Memwrite = (Instr[15:12] == 4'b1001);
//ALUSrc
// The second input of the ALU unit, //might need to zero extened YY
// IF alusrc == 2, Sign Extended
// if alusrc == 1, Immediate
// if alusrc == 0, Rt

//assign ALUSrc = ~Instr[15] ? 0 : (Instr[13] ? 1: 2);

assign ALUSrc = (Instr[15:13] == 3'b101 | Instr[15:13] == 3'b010 | Instr[15:12] == 4'b0110) ? 2'b01 :
				(Instr[15:13] == 3'b100) ? 2'b10 : 2'b0;
				
//MemCtrl 00 Read data, 01 ALU, 10 PC+2
assign MemCtrl = (~Instr[15] | Instr[15:12] == 4'b1010 | Instr[15:12] == 4'b1011 ) 
					? 01 : Instr[13:12];
		 
		 
		 
assign hlt = (Instr[15:12] == 4'b1111) ? 1: 0;

// Branch
assign Branch = (Instr[15:12] == 4'b1100) ? 2'b10 : (Instr[15:12] == 4'b1101) ? 2'b11 : 2'b00;

// AluSrc1
assign ALUSrc1 = (Instr[15:12] == 4'b1011) ? 1 : ((Instr[15:12] == 4'b1010) ? 1 : 0 );

endmodule
