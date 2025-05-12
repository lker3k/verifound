module top_level4 (KEY, SW, LEDR, HEX0, HEX1, HEX2, HEX3);
	input [3:0] KEY;
	input [9:0] SW;
	
	output [9:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2, HEX3;
	
	wire [1:0] led;
	
	wire [3:0] state, next_state, counter;
	
	reg [3:0] user;
	
	wire [15:0] password, guess;
	
	
	
	
	L6_4 FSM (.clk(KEY[0]), 
				.rst(SW[8]), 
				.w(SW[9]), 
				.z(led), 
				.state(state), 
				.next_state(next_state), 
				.counter(counter), 
				.user_password(SW[3:0]), 
				.user_guess(SW[7:4]),
				.dis_password(password),
				.guess(guess));
	
	hex_to_seg  hex0 (.hex(password[3:0]), .seg(HEX0));
	hex_to_seg  hex1 (.hex(password[7:4]), .seg(HEX1));
	hex_to_seg  hex2 (.hex(password[11:8]), .seg(HEX2));
	hex_to_seg  hex3 (.hex(password[15:12]), .seg(HEX3));
	
	assign LEDR[3:0] = {4{led[0]}};
	assign LEDR[7:4] = {4{led[1]}};
	
	

endmodule