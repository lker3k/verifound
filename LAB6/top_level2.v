module top_level2 (KEY, SW, LEDR, HEX0, HEX1, HEX2, HEX3);
	input [3:0] KEY;
	input [9:0] SW;
	
	output [9:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2, HEX3;
	
	wire led;
	
	wire [3:0] state, next_state, counter;
	
	reg [3:0] user;
	
	
	L6_2 FSM (.clk(KEY[0]), .rst(SW[0]), .w(SW[1]), .z(led), .state(state), .next_state(next_state), .limit(user), .counter(counter));
	
	hex_to_seg  hex0 (.hex(counter), .seg(HEX0));
	hex_to_seg  hex1 (.hex(user), .seg(HEX1));
	hex_to_seg  hex2 (.hex(state), .seg(HEX2));
	hex_to_seg  hex3 (.hex(next_state), .seg(HEX3));
	
	genvar i;
	generate 
		for (i = 1; i < 10; i = i + 1) begin : led_loop
			assign LEDR[i] = led;
		end
	endgenerate
	
	
	always @(posedge KEY[3]) begin
		user <= SW [9:6];
	end

endmodule