module RegisterFile(input clk, input rst, input [3:0] SrcReg1, input [3:0] SrcReg2, input [3:0] DstReg, input WriteReg, input [15:0] DstData, inout [15:0] SrcData1, inout [15:0] SrcData2);
	wire[15:0] wireReg1, wireReg2, wireWrite;
	wire[15:0] res1, res2;
	//wire resD1, resD2;
	ReadDecoder_4_16 readDecoder1 (.RegId(SrcReg1), .Wordline(wireReg1));
	ReadDecoder_4_16 readDecoder2 (.RegId(SrcReg2), .Wordline(wireReg2));
	
	WriteDecoder_4_16 writeD (.RegId(DstReg), .WriteReg(WriteReg), .Wordline(wireWrite));


	Register r1 ( .clk(clk),  .rst(rst), .D(DstData), .WriteReg(wireWrite[0]), .ReadEnable1(wireReg1[0]), .ReadEnable2(wireReg2[0]), .Bitline1(res1), .Bitline2(res2));
	Register r2 ( .clk(clk),  .rst(rst), .D(DstData), .WriteReg(wireWrite[1]), .ReadEnable1(wireReg1[1]), .ReadEnable2(wireReg2[1]), .Bitline1(res1), .Bitline2(res2));
	Register r3 ( .clk(clk),  .rst(rst), .D(DstData), .WriteReg(wireWrite[2]), .ReadEnable1(wireReg1[2]), .ReadEnable2(wireReg2[2]), .Bitline1(res1), .Bitline2(res2));
	Register r4 ( .clk(clk),  .rst(rst), .D(DstData), .WriteReg(wireWrite[3]), .ReadEnable1(wireReg1[3]), .ReadEnable2(wireReg2[3]), .Bitline1(res1), .Bitline2(res2));
	Register r5 ( .clk(clk),  .rst(rst), .D(DstData), .WriteReg(wireWrite[4]), .ReadEnable1(wireReg1[4]), .ReadEnable2(wireReg2[4]), .Bitline1(res1), .Bitline2(res2));
	Register r6 ( .clk(clk),  .rst(rst), .D(DstData), .WriteReg(wireWrite[5]), .ReadEnable1(wireReg1[5]), .ReadEnable2(wireReg2[5]), .Bitline1(res1), .Bitline2(res2));
	Register r7 ( .clk(clk),  .rst(rst), .D(DstData), .WriteReg(wireWrite[6]), .ReadEnable1(wireReg1[6]), .ReadEnable2(wireReg2[6]), .Bitline1(res1), .Bitline2(res2));
	Register r8 ( .clk(clk),  .rst(rst), .D(DstData), .WriteReg(wireWrite[7]), .ReadEnable1(wireReg1[7]), .ReadEnable2(wireReg2[7]), .Bitline1(res1), .Bitline2(res2));
	Register r9 ( .clk(clk),  .rst(rst), .D(DstData), .WriteReg(wireWrite[8]), .ReadEnable1(wireReg1[8]), .ReadEnable2(wireReg2[8]), .Bitline1(res1), .Bitline2(res2));
	Register r10 ( .clk(clk), .rst(rst), .D(DstData), .WriteReg(wireWrite[9]), .ReadEnable1(wireReg1[9]), .ReadEnable2(wireReg2[9]), .Bitline1(res1), .Bitline2(res2));
	Register r11 ( .clk(clk), .rst(rst), .D(DstData), .WriteReg(wireWrite[10]), .ReadEnable1(wireReg1[10]), .ReadEnable2(wireReg2[10]), .Bitline1(res1), .Bitline2(res2));
	Register r12 ( .clk(clk), .rst(rst), .D(DstData), .WriteReg(wireWrite[11]), .ReadEnable1(wireReg1[11]), .ReadEnable2(wireReg2[11]), .Bitline1(res1), .Bitline2(res2));
	Register r13 ( .clk(clk), .rst(rst), .D(DstData), .WriteReg(wireWrite[12]), .ReadEnable1(wireReg1[12]), .ReadEnable2(wireReg2[12]), .Bitline1(res1), .Bitline2(res2));
	Register r14 ( .clk(clk), .rst(rst), .D(DstData), .WriteReg(wireWrite[13]), .ReadEnable1(wireReg1[13]), .ReadEnable2(wireReg2[13]), .Bitline1(res1), .Bitline2(res2));
	Register r15 ( .clk(clk), .rst(rst), .D(DstData), .WriteReg(wireWrite[14]), .ReadEnable1(wireReg1[14]), .ReadEnable2(wireReg2[14]), .Bitline1(res1), .Bitline2(res2));
	Register r16 ( .clk(clk), .rst(rst), .D(DstData), .WriteReg(wireWrite[15]), .ReadEnable1(wireReg1[15]), .ReadEnable2(wireReg2[15]), .Bitline1(res1), .Bitline2(res2));

	//assign resD1 = |((SrcReg1 ^ DstReg));
	
	//assign resD2 = |((SrcReg2 ^ DstReg));
	
	
	assign SrcData1 = res1;
	assign SrcData2 = res2;
	
endmodule
