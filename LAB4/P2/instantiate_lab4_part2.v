module instantiate_lab4_part2(SW,LEDR);
 
	input[9:0] SW ;
	output [9:0] LEDR;

	gated_DLatch instantiate_gated_DLatch (
	.clk(), 
	.D(), 
	.Q(), 
	.Qnot());
	
endmodule