module PSA_16bit_tb();

reg[15:0]A,B;
wire[15:0]Sum;
wire Error;

PSA_16bit iDUT(.Sum(Sum),.Error(Error),.A(A),.B(B));

initial begin 

A = 16'h0008;
B = 16'h0008;

#10;

if(Sum == 0 & Error == 1'b1) begin
	$display("Least Significant Add and Carry Works");
end else begin
	$display("Least Significant Failed");
end
A = 16'h0080;
B = 16'h0080;

#10;

if(Sum == 0 & Error == 1'b1) begin
	$display("Second most Significant Add and Carry Works");
end else begin
	$display("Second most Significant Failed");
end
A = 16'h0800;
B = 16'h0800;

#10;

if(Sum == 0 & Error == 1'b1) begin
	$display("Third most Significant Add and Carry Works");
end else begin
	$display("Third most Significant Failed");
end
A = 16'h8000;
B = 16'h8000;

#10;

if(Sum == 0 & Error == 1'b1) begin
	$display("Most Significant Add and Carry Works");
end else begin
	$display("Most Significant Failed");
end
 
end
endmodule 
