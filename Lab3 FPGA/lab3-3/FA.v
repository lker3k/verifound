module FA(a,b,cin,cout,s);
	//all inputs and outputs are 1-bit
	input a, b, cin;
	output cout, s;
	
	ab = a^b;
	s = cin^ab;
	one_bit_2to1mux mux1 (.s(ab), .x(b), .y(cin), .m(cout));
endmodule