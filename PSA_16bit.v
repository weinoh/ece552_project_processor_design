module PSA_16bit(Sum,Error,A,B);

input[15:0]A,B;
output[15:0]Sum;
output Error;

wire [4:0] most_significant;
wire [4:0] third_significant;
wire [4:0] second_significant;
wire [4:0] least_significant;

assign most_significant = {1'b0,{A[15:12]}} + {1'b0,B[15:12]};
assign third_significant = {1'b0,A[11:8]} + {1'b0,B[11:8]};
assign second_significant = {1'b0,A[7:4]} + {1'b0,B[7:4]};
assign least_significant = {1'b0,A[3:0]} + {1'b0,B[3:0]};

assign Error = most_significant[4] | third_significant[4] | second_significant[4] | least_significant[4];
assign Sum = {most_significant[3:0],third_significant[3:0],second_significant[3:0],least_significant[3:0]};

endmodule 
