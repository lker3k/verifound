module t_flip_flop (t, clk, rst, q);
    input t, clk, rst;
    output reg q;


	always @(posedge clk) begin
		if (rst) begin
			q <= 0;
		end else if (t) begin
			q <= ~q;
		end 
	end
endmodule