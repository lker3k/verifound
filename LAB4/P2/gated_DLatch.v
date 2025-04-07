module gated_DLatch (clk, D, Q, Qnot);
   input  D, clk;
   output Q, Qnot;
	
	wire R, S;
	assign S = D;
	assign R = ~D;
	
	gated_RS dlatch (
		.clk(clk),
		.R(R),
		.S(S),
		.Q(Q),
		.Qnot(Qnot)
	);
	
endmodule