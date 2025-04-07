module circuitA (v, A);
	input [3:0] v;
	output reg [3:0] A;
  
	always @(v) begin
		case (v)
		4'b1010 : begin A = 4'b0000; end //10
		4'b1011 : begin A = 4'b0001; end //11
		4'b1100 : begin A = 4'b0010; end //12
		4'b1101 : begin A = 4'b0011; end //13
		4'b1110 : begin A = 4'b0100; end //14
		4'b1111 : begin A = 4'b0101; end //15
		default : begin A = v; end
	endcase
	end
endmodule