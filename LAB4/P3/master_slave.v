module master_slave (clk, D, Q, Qnot);
   input  D, clk;
   output Q, Qnot;
   
   wire Qm, Qnm;
	
	gated_DLatch master (
		.clk(~clk),
		.D(D),
		.Q(Qm),
		.Qnot(Qnm)
	);
	
	
	gated_DLatch slave (
		.clk(clk),
		.D(Qm),
		.Q(Q),
		.Qnot(Qnot)
	);
	
	
endmodule