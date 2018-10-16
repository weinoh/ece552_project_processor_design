module Shifter_tb();

reg [15:0] Shift_In;
reg [3:0] Shift_Val;
reg Mode;
wire [15:0] Shift_Out; 

Shifter shift(.Shift_Out(Shift_Out),.Shift_In(Shift_In),.Shift_Val(Shift_Val),.Mode(Mode));

initial begin

Shift_In = 16'hF007;
Shift_Val = 4'h2;
Mode = 1'b1;

#10;

if(Shift_Out == 16'hFC01)begin
	$display("Signed Shift Right Correct");
end else begin
	$display("Signed Shift Right Incorrect");
end

#10;

Mode = 1'b1;
Shift_In = 16'h0007;
Shift_Val = 4'h6;
#10; 

if(Shift_Out == 16'h0)begin
	$display("Unsigned Shift Right Correct");
end else begin
	$display("Unsigned Shift Right Incorrect");
end
#10; 

Mode = 1'b0;
Shift_In = 16'hF007;
Shift_Val = 4'h2;
#10; 

if(Shift_Out == 16'hc01c)begin
	$display("Shift Left Correct");
end else begin
	$display("Shift Left Incorrect");
end
#10;

end
endmodule
