module top_level(KEY, SW, HEX0, HEX1, HEX2, HEX3);
	input[9:0] SW;
	input [3:0] KEY;
	output [6:0] HEX0, HEX1, HEX2, HEX3;
	
	wire [15:0] bus_out;
	
	integration main_cpu (.clk(KEY[0]),
								 .rst(KEY[3]),
								 .bus_out(bus_out));
								 
	hex_to_seg hex0 (.hex(bus_out[3:0]),
						  .seg(HEX0));
	
	hex_to_seg hex1 (.hex(bus_out[7:4]),
						  .seg(HEX1));
	hex_to_seg hex2 (.hex(bus_out[11:8]),
						  .seg(HEX2));
	hex_to_seg hex3 (.hex(bus_out[15:12]),
						  .seg(HEX3));				  
								 
	
endmodule