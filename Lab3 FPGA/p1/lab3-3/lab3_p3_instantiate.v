module lab3_p3_instantiate(SW,LEDR);

	input[9:0] SW;
	output [9:0] LEDR;
	
	//instantiate and connect fourBit_FA
	fourBit_FA fourbit (.a(SW[3:0]), .b(SW[7:4]), .cin(SW[8]), .cout(LEDR[0]), .s(LEDR[4:1]))
	
endmodule