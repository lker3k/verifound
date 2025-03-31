module top_level (SW, HEX0, HEX1);
	input[9:0] SW;
	output [6:0] HEX0, HEX1;
	
	lab3_p2_v2 lab3 (.v(SW[3:0]), .d1(HEX0), .d2(HEX1));

endmodule