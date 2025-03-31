module circuitA (v, A);
	input [3:0] v;
	output [3:0] A;
  
  reg [3:0] out;
  assign A = out;
	always @(v) begin
		case (v)
		4'b0000 : begin out = 4'b0000; end
		4'b0001 : begin out = 4'b0001; end
		4'b0010 : begin out = 4'b0010; end
		4'b0011 : begin out = 4'b0011; end
		4'b0100 : begin out = 4'b0100; end
		4'b0101 : begin out = 4'b0101; end
		4'b0110 : begin out = 4'b0110; end
		4'b0111 : begin out = 4'b0111; end
		4'b1000 : begin out = 4'b1000; end
		4'b1001 : begin out = 4'b1001; end
		4'b1010 : begin out = 4'b0000; end
		4'b1011 : begin out = 4'b0001; end
		4'b1100 : begin out = 4'b0010; end
		4'b1101 : begin out = 4'b0011; end
		4'b1110 : begin out = 4'b0100; end
		4'b1111 : begin out = 4'b0101; end
		default : begin out = 4'b0000; end
	endcase
	end
endmodule