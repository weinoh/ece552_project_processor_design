module adder_1bit(A, B, Ci, Sum, Co);

//input A, B, Cin
input A, B, Ci;

//output S, Cout
output Sum, Co;

//assignment
assign Sum = A ^ B ^ Ci;
assign Co = (A & B) | (B & Ci) | (A & Ci);

endmodule
