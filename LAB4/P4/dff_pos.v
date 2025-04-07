module dff_pos (D, clk, Q, Qnot);
	input  D, clk;
	output Q, Qnot;
	reg    Q, Qnot;
	
	always @ (posedge clk) begin
		Q <= D;
		Qnot <= ~D;
	end 
endmodule