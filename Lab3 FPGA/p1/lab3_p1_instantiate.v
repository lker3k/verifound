module lab3_p1_instantiate(SW,HEX0);

	input[9:0] SW;
	output [6:0] HEX0;
	binary_to_7Seg instantiate_bto7seg(
		.binary(SW[3:0]),
		.sevenSeg(HEX0)
		);
	
endmodule