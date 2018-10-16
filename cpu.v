module cpu(clk, rst_n, hlt, pc_out);
input clk;
input rst_n;
output hlt;
output [15:0] pc_out;


wire [15:0] pc_to_instruction_mem, WriteData, Rs, Rt, PC_control_to_PC, Sign_Extended_IMM;
wire [15:0] ALU_DataSrc2, ALU_Res, ALU_DataSrc1;

wire [3:0] register_2;
wire [15:0] instr_mem_out, mem_out;

wire [7:0] YY;

wire [2:0] FlagReg_Out;

wire zero, overflow;
wire RegSel, RegWrite, Memwrite, Hlt, ALUSrc1;
wire [1:0] ALUSrc, MemCtrl, Branch;

//second value to read into register is selected by RegSel;
assign register_2 = (RegSel) ? instr_mem_out[11:8] : instr_mem_out[3:0];

//Sign extend inst[8:0]
assign Sign_Extended_IMM = {{12{instr_mem_out[3]}}, instr_mem_out[3:0]};

assign YY = instr_mem_out[7:0];

// The second input of the ALU unit, //might need to zero extened YY
// IF alusrc == 2, Sign Extended
// if alusrc == 1, Immediate
// if alusrc == 0, Rt
assign ALU_DataSrc2 = ALUSrc[1] ? Sign_Extended_IMM : (ALUSrc[0] ? {{6{1'b0}},YY}: Rt);


//if AluSrc, then [11:8] else [7:4]
assign ALU_DataSrc1 = ALUSrc1 ? Rt: Rs;





// Mux to choose write data
// 0 LW ReadData from memory
// 1 LLB, LHB loadData from ALU_Res;
// 2 PC+2
assign WriteData = MemCtrl[1] ? PC_control_to_PC : (MemCtrl[0] ? ALU_Res : mem_out);


// Hlt
assign hlt = Hlt;

//pc_out
assign pc_out = pc_to_instruction_mem;

// PC module
PC PC_Module (.clk(clk), .rst(~rst_n), .PC_in(PC_control_to_PC), .PC_val(pc_to_instruction_mem));

//PC Control Unit
PC_control PCC(.C(instr_mem_out[11:9]), .I(instr_mem_out[8:0]), .F(FlagReg_Out), .PC_in(pc_to_instruction_mem), .PC_out(PC_control_to_PC), .hlt(Hlt), .rs(Rs), .branch(Branch));

//Instruction mem. Should not be written after the program runs
memory1c IM (.data_out(instr_mem_out), .data_in(), .addr(pc_to_instruction_mem), .enable(1'b1), .wr(1'b0), .clk(clk), .rst(~rst_n));

//Register File
RegisterFile RF(.clk(clk), .rst(~rst_n), 
.SrcReg1(instr_mem_out[7:4]), .SrcReg2(register_2), 
.DstReg(instr_mem_out[11:8]), .WriteReg(RegWrite), 
.DstData(WriteData), .SrcData1(Rs), 
.SrcData2(Rt));

//ALU
alu Alu(.R1(ALU_DataSrc1), .R2(ALU_DataSrc2), .alu_code(instr_mem_out[15:12]), .overflow(overflow), .zero(zero), .alu_result(ALU_Res));


//Flag register
Flag_Register FR(.clk(clk), .rst(~rst_n), .overflow(overflow), .zero(zero), .ALUresult(ALU_Res), .flag(FlagReg_Out));

// Memory File
memory1c MEM (.data_out(mem_out), .data_in(Rt), .addr(ALU_Res), .enable(1'b1), .wr(Memwrite), .clk(clk), .rst(~rst_n));

// Control Unit
control_unit CU (.Instr(instr_mem_out), .RegSel(RegSel), .RegWrite(RegWrite), .Memwrite(Memwrite), .ALUSrc(ALUSrc), .MemCtrl(MemCtrl), .hlt(Hlt), .Branch(Branch), .ALUSrc1(ALUSrc1));



endmodule
