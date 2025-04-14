module instantiate_lab4_part3(SW,LEDR);
 
	input[9:0] SW ;
	output [9:0] LEDR;

	// instantiate and connect master_slave
	master_slave ms (
		.D(SW[0]),
		.clk(SW[1]),
		.Q(LEDR[0]),
		.Qnot(LEDR[1]));
		
endmodule