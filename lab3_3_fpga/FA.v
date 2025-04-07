module FA(a,b,cin,cout,s);
	//all inputs and outputs are 1-bit
	input a, b, cin;
	output cout,s;
	
	wire ab;
	wire s_t, cout_t;

	
	assign	s = cin^ab;
	assign	ab = a^b;
	assign	cout = cout_t;

	one_bit_2to1mux mux1 (.s(ab), .x(b), .y(cin), .m(cout_t));
endmodule
