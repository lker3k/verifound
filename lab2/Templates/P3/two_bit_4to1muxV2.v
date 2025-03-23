module two_bit_4to1muxV2 (s,u,v,w,x,m);
 
	input[1:0] s;
	input[1:0] u,v,w,x;
	output reg[1:0] m;
	
	reg[1:0] t1, t2;
	
	//complete always blocks (look at one_bit_4to1muxV2.v for hints. Should look the same)
	always @(s, u, v, w, x) begin
		case (s)
			2'b00: begin m = u; end
			2'b01: begin m = v; end
			2'b10: begin m = w; end
			2'b11: begin m = x; end
			default: begin m = 2'b00; end
		endcase
	end
endmodule
