module Flag_Register(input clk, input rst, input overflow, input zero, input [15:0] ALUresult, output [2:0] flag);

dff FlagZ(.q(flag[2]), .d(zero), .wen(1'b1), .clk(clk), .rst(rst));
dff FlagV(.q(flag[1]), .d(overflow), .wen(1'b1), .clk(clk), .rst(rst));
dff FlagN(.q(flag[0]), .d(ALUresult[15]), .wen(1'b1), .clk(clk), .rst(rst));

endmodule