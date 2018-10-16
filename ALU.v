module ALU(R1, R2, alu_code, overflow_flag, zero_flag, alu_output);
	// Inputs / Outputs
	input[15:0] R1, R2, alu_output;
	input[3:0] alu_code;
	output overflow_flag, zero_flag;

	// Storage / results
	reg[15:0] alu_result_reg;
	wire [15:0] adder_input2;
	wire [15:0] adder_result, shifter_result;
	wire [6:0] reduction_result;

	// ALU control
	wire PG, GG, Ci, Sat_4bit, Sat_16bit;
	wire Mode;

	assign adder_input1 = (alu_code[3] & ~alu_code[2] & ~alu_code[1]) ? (R1 & 16'hFFFE): R1;
	assign adder_input2 = (~alu_code[3] & ~alu_code[2] & ~alu_code[1] & alu_code[0]) ? ~R2 : (alu_code[3] & ~alu_code[2] & ~alu_code[1]) ? (R2 << 1): R2;
	assign Ci = (~alu_code[3] & ~alu_code[2] & ~alu_code[1] & alu_code[0])?1:0; //0001
	assign Co = (~alu_code[3] & alu_code[2] & alu_code[1]& alu_code[0])?0:1; // 0111->0; 1 else
	assign saturate_4 = (~alu_code[3] & alu_code[2] & alu_code[1] & alu_code[0])?1:0; //0111
	assign saturate_16 = (~alu_code[3] & ~alu_code[2] & ~alu_code[1]);  //000x

	assign Mode =  alu_code[1];	

	cla_16bit adder_16 (.Ci(Ci), .Co(Co), .saturate_4(saturate_4), .saturate_16(saturate_16),.A(R1),.B(adder_input2),.Sum(adder_result),.PG(PG),.GG(GG));
	Shifter shifter_16 (.Shift_Out(shifter_result), .Shift_In(R1), .Shift_Val(R2[3:0]), .Mode(Mode));
	reduction reduction_16(.A(R1), .B(R2), .red_output(reduction_result));
	always @ (R1 or R2 or alu_code) begin
		case (alu_code) 
			// ADD (with saturation): Rd = sat(Rs + Rt)
			// SUB (with saturation): Rd = sat(Rs - Rt)
    		4'b0000 : alu_result_reg = adder_result; 
    		4'b0001 : alu_result_reg = adder_result; 
    		
		4'b0010 : alu_result_reg = R1 ^ R2; // XOR 
    		4'b0011 : alu_result_reg = reduction_result; // RED 
    		4'b0100 : alu_result_reg = shifter_result; // SLL : 00
    		4'b0101 : alu_result_reg = shifter_result; // SRA : 01 
    		4'b0110 : alu_result_reg = shifter_result; // ROR : 10
    		4'b0111 : alu_result_reg = adder_result; // PADDSAB
    		4'b1000 : alu_result_reg = adder_result; // LW
    		4'b1001 : alu_result_reg = adder_result; // SW
    		4'b1010 : alu_result_reg = (R1 & 16'hFF00) | R2; // LLB
		4'b1011 : begin alu_result_reg = (R1 & 16'h00FF) | (R2<<8); // LHB
						$display("R1 %d, R2 %d", R1, R2);
					  end

	    	default : $display("Error in alu_code: non-suppport"); 
 		endcase		
	end

	assign  alu_output = alu_result_reg;
   // output overflow, output zero,
    assign overflow_flag = (~alu_code[3]& ~alu_code[2]& ~alu_code[1])?(PG ^ GG):0;
    assign zero_flag = ~(|alu_output);
endmodule
