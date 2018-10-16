module PC(input clk, input rst, input[15:0] PC_in, output[15:0] PC_val);


dff B0(.q(PC_val[0]), .d(PC_in[0]), .wen(1'b1), .clk(clk), .rst(rst));
dff B1(.q(PC_val[1]), .d(PC_in[1]), .wen(1'b1), .clk(clk), .rst(rst));
dff B2(.q(PC_val[2]), .d(PC_in[2]), .wen(1'b1), .clk(clk), .rst(rst));
dff B3(.q(PC_val[3]), .d(PC_in[3]), .wen(1'b1), .clk(clk), .rst(rst));
dff B4(.q(PC_val[4]), .d(PC_in[4]), .wen(1'b1), .clk(clk), .rst(rst));
dff B5(.q(PC_val[5]), .d(PC_in[5]), .wen(1'b1), .clk(clk), .rst(rst));
dff B6(.q(PC_val[6]), .d(PC_in[6]), .wen(1'b1), .clk(clk), .rst(rst));
dff B7(.q(PC_val[7]), .d(PC_in[7]), .wen(1'b1), .clk(clk), .rst(rst));
dff B8(.q(PC_val[8]), .d(PC_in[8]), .wen(1'b1), .clk(clk), .rst(rst));
dff B9(.q(PC_val[9]), .d(PC_in[9]), .wen(1'b1), .clk(clk), .rst(rst));
dff B10(.q(PC_val[10]), .d(PC_in[10]), .wen(1'b1), .clk(clk), .rst(rst));
dff B11(.q(PC_val[11]), .d(PC_in[11]), .wen(1'b1), .clk(clk), .rst(rst));
dff B12(.q(PC_val[12]), .d(PC_in[12]), .wen(1'b1), .clk(clk), .rst(rst));
dff B13(.q(PC_val[13]), .d(PC_in[13]), .wen(1'b1), .clk(clk), .rst(rst));
dff B14(.q(PC_val[14]), .d(PC_in[14]), .wen(1'b1), .clk(clk), .rst(rst));
dff B15(.q(PC_val[15]), .d(PC_in[15]), .wen(1'b1), .clk(clk), .rst(rst));

endmodule
