module dff_neg (D, clk, Q, Qnot);
	input  D, clk;
	output Q, Qnot;
	reg    Q, Qnot;
	
	always @ (negedge clk) begin
		Q <= D;
		Qnot <= ~D;
	end 
endmodule