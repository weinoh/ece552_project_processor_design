module cla_16bit_tb;
reg [15:0] stimA, stimB;
reg Ci, saturate;

//Outputs
wire [15:0] Sum;
wire Co, PG, GG;
integer i, j;

// Instantiate iDUT
cla_16bit iDUT(.A(stimA), .B(stimB), .Ci(Ci), .saturate_16(1'b1), .saturate_4(1'b0), .Sum(Sum), .Co(Co), .PG(PG), .GG(GG));

//Stimulus block - all the input combinations are tested here.
//the number of errors are recorded in the signal named "error".
    initial begin
        //////////////////////////////////////////////////
	// Test for saturation HIGH with NO carry in
	//////////////////////////////////////////////////
        stimA = 16'h7FFF;
        stimB = 16'h000A;
        //for carry in =0
        Ci = 0;
        #10;
        if(Sum != 16'h7FFF)
		$display("Positive Saturation is incorrect: Sum: %b, \nstimA: %b, \nstimB: %b", Sum, stimA, stimB);
	if(Co != 0)
		$display("Carry Out is incorrect: Co should be 1, but is: %b. \nstimA: %b, \nstimB: %b, \nCi: %b", Co, stimA, stimB, Ci);

	//////////////////////////////////////////////////
	// Test for saturation HIGH WITH carry in
	//////////////////////////////////////////////////
	stimA = 16'h7FFF;
        stimB = 16'h0000;
        //for carry in =1
        Ci = 1;
        #10;
        if(Sum != 16'h7FFF)
		$display("Positive Saturation is incorrect: Sum: %b, \nstimA: %b, \nstimB: %b", Sum, stimA, stimB);
	if(Co != 0)
		$display("Carry Out is incorrect: Co should be 1, but is: %b. \nstimA: %b, \nstimB: %b, \nCi: %b", Co, stimA, stimB, Ci);

	//////////////////////////////////////////////////
	// Test for saturation LOW with NO carry in
	//////////////////////////////////////////////////
	stimA = 16'h8000;
        stimB = 16'hF000;
        //for carry in =1
        Ci = 0;
        #10;
        if(Sum != 16'h8000)
		$display("Positive Saturation is incorrect: Sum: %b, \nstimA: %b, \nstimB: %b", Sum, stimA, stimB);
	if(Co != 1)
		$display("Carry Out is incorrect: Co should be 1, but is: %b. \nstimA: %b, \nstimB: %b, \nCi: %b", Co, stimA, stimB, Ci);
	
	//////////////////////////////////////////////////
	// Test for addition WITHOUT carry
	//////////////////////////////////////////////////
	stimA = 16'h7228;
        stimB = 16'h0023;
        //for carry in =0
        Ci = 0;
        #10;
        if(Sum != 16'h724B)
		$display("Positive Saturation is incorrect: Sum: %b, \nstimA: %b, \nstimB: %b", Sum, stimA, stimB);
	if(Co != 0)
		$display("Carry Out is incorrect: Co should be 0, but is: %b. \nstimA: %b, \nstimB: %b, \nCi: %b", Co, stimA, stimB, Ci);

	//////////////////////////////////////////////////
	// Test for addition WITH carry
	//////////////////////////////////////////////////
	stimA = 16'h7228;
        stimB = 16'h0022;
        //for carry in =0
        Ci = 1;
        #10;
        if(Sum != 16'h724B)
		$display("Positive Saturation is incorrect: Sum: %b, \nstimA: %b, \nstimB: %b", Sum, stimA, stimB);
	if(Co != 0)
		$display("Carry Out is incorrect: Co should be 0, but is: %b. \nstimA: %b, \nstimB: %b, \nCi: %b", Co, stimA, stimB, Ci);
	
	

	$display("Done testing");

	end	
	/////////////////////////
	// END OF TESTING
	/////////////////////////
endmodule
