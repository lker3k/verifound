module one_bit_4to1muxV2 (s,u,v,w,x,m);
 
	input[1:0] s;
	input u,v,w,x;
	output reg m;
	
	reg t1, t2;
	
	always @(u,v,w,x,s[0]) begin
		if (s[0] == 1'b1) begin//complete)
			t1 <= v; //complete;
			t2 <= x;
		end else begin
			t1 <= u;//complete;
			t2 <= w;
		end
	end
 
 	//complete other always blocks
	always @(s[1], t1, t2) begin
		if (s[1] == 1'b1) begin
			m <= t2;
		end else begin
			m <= t1;
		end
	end
endmodule
