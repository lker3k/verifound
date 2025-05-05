module top_level (KEY, SW, LEDR, HEX0, HEX1);
	input [3:0] KEY;
	input [9:0] SW;
	
	output [9:0] LEDR;
	output [6:0] HEX0, HEX1;
	
	wire led;
	
	wire [3:0] state, next_state;
	
	
	L6 FSM (.clk(KEY[0]), .rst(SW[0]), .w(SW[1]), .z(led), .state(state), .next_state(next_state));
	
	hex_to_seg  hex0 (.hex(state), .seg(HEX0));
	
	genvar i;
	generate 
		for (i = 1; i < 10; i = i + 1) begin : led_loop
			assign LEDR[i] = led;
		end
	endgenerate

endmodule