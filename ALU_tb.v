module ALU_tb();
	reg signed [15:0] stimA, stimB;
	wire signed [15:0] alu_result;
	reg[3:0] Opcode;
	wire overflow_flag, zero_flag;
	ALU iDUT(.R1(stimA), .R2(stimB), .alu_code(Opcode), .overflow_flag(overflow_flag), .zero_flag(zero_flag), .alu_output(alu_result));
	integer errors;
	
	initial begin

		///////////////////////////////////////
		// Test ADD Opcode
		///////////////////////////////////////
		$display("**************************************************************************");
		$display("BEGIN: ADD tests -- Opcode 0000");
		$display("**************************************************************************");
		Opcode = 4'b0000;
		errors = 0;
	    	stimA = 16'h0000;
		stimB = 16'h0000;
		// Go through 100 random iterations
	    	repeat(100) begin
			#10 
			stimA = $random;
			stimB = $random;
			#5
			if (alu_result != stimA + stimB) begin
				if( alu_result == 16'h7FFF && (~stimA[15]) && (~stimB[15]) ) begin
					$display("CORRECT: alu result is %h, original sum %h was saturated", alu_result, (stimA + stimB));
				end
				else if(alu_result == 16'h8000 && (stimA[15]) && (stimB[15]) ) begin
					$display("CORRECT: alu result is %h, original sum %h was saturated", alu_result, (stimA + stimB));
				end
				else begin
					$display("INCORRECT: alu result is %h, it should be %h, with stimA: %h and stimB: %h", alu_result, (stimA + stimB), stimA, stimB);
					errors = errors + 1;
				end
			end
    		end
		if(errors == 0)
			$display("\nAll tests passed\n");
		$display("**************************************************************************");
		$display("END: ADD tests -- Opcode 0000");
		$display("**************************************************************************");
		#10;

		///////////////////////////////////////
		// Test SUB Opcode
		///////////////////////////////////////
		$display("**************************************************************************");
		$display("BEGIN: SUB tests -- Opcode 0001");
		$display("**************************************************************************");
		Opcode = 4'b0001;
		errors = 0;
	    	stimA = 16'h0000;
		stimB = 16'h0000;
	    	repeat(100) begin
			#10 
			stimA = $random;
			stimB = $random;
			#5
			if (alu_result != stimA - stimB) begin
				if( alu_result == 16'h7FFF && ((stimA[15] ^ stimB[15])) ) begin
					$display("CORRECT: alu result is %h, original difference %h calculated from stimA: %h and stimB: %h was saturated", alu_result, (stimA - stimB), stimA, stimB);
				end
				else if(alu_result == 16'h8000 && ((stimA[15] ^ stimB[15])) ) begin
					$display("CORRECT: alu result is %h, original difference %h calculated from stimA: %h and stimB: %h was saturated", alu_result, (stimA - stimB), stimA, stimB);
				end
				else begin
					$display("INCORRECT: alu result is %h, it should be %h, with stimA: %h and stimB: %h", alu_result, (stimA + stimB), stimA, stimB);
					errors = errors + 1;
				end
			end
	    	end
		if(errors == 0)
			$display("\nAll tests passed\n");
		$display("**************************************************************************");
		$display("END: SUB tests -- Opcode 0001");
		$display("**************************************************************************");
		#10;

		///////////////////////////////////////
		// Test XOR Opcode
		///////////////////////////////////////
		$display("**************************************************************************");
		$display("BEGIN: XOR tests -- Opcode 0010");
		$display("**************************************************************************");
		Opcode = 4'b0010;
		errors = 0;
	    	stimA = 16'h0000;
		stimB = 16'h0000;
	    	repeat(100) begin
			#10 
			stimA = $random;
			stimB = $random;
			#5
			if (alu_result != (stimA ^ stimB)) begin
				$display("alu result is %h, it should be %h",  alu_result, (stimA ^ stimB));
				errors = errors + 1;
			end
		
	    	end
		if(errors == 0)
			$display("\nAll tests passed\n");
		$display("**************************************************************************");
		$display("END: XOR tests -- Opcode 0010");
		$display("**************************************************************************");
		#10;
		/*
		///////////////////////////////////////
		// Test XOR Opcode
		///////////////////////////////////////
		assign Opcode = 2'b11;
	    	stim = 8'b0;
	    	repeat(100) begin
			#10 stim = $random;
			#5
			if (alu_result != stim[3:0] ^ stim[7:4])
				$display("alu result is %d, it should be %d",  alu_result, stim[3:0] ^ stim[7:4]);
			else
	                        $display("alu result is %d, it should be %d",  alu_result, stim[3:0] ^ stim[7:4]);
	    	end
	
		$display("XOR tests completed");
		#10;
*/
	end
endmodule