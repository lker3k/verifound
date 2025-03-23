module circuitC (a,b,x);
	input[3:0] a, b;
	output[3:0] x;
	
	assign x = ~a ^ b;
endmodule