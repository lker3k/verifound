module instantiate_lab4_part4(SW,LEDR);
 
	input[9:0] SW ;
	output [9:0] LEDR;

	// instantiate and connect all 3 flip flops
	// Use same inputs (same switches for D, clk to all instances)
	// Use 3 separate LED outputs
	
	dff_pos dp (.D(SW[0]), .clk(SW[1]), .Q(LEDR[1]), .Qnot(LEDR[8]));

	dff_neg dn (.D(SW[0]), .clk(SW[1]), .Q(LEDR[2]), .Qnot(LEDR[9]));
	
	d_latch dl (.D(SW[0]), .clk(SW[1]), .Q(LEDR[0]), .Qnot(LEDR[7]));
	
endmodule