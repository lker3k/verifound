module gated_RS (clk, R, S, Q, Qnot);
   input  R, S, clk;
   output Q, Qnot;
	
   wire   R_g, S_g, Qa, Qb /* synthesis keep */;
	
   assign R_g = R & clk;
	assign S_g = S & clk;
	assign Qa = ~(R_g & Qb);
	assign Qb = ~(S_g * Qa);
	
	assign Q = Qa;
	assign Qnot = Qb;
	
endmodule