module L6(clk, w, rst, z);

	input clk;
	input w;
	input rst;

	parameter A = 4'b0000, B = 4'b0001, C = 4'b0010, D = 4'b0011, E = 4'b0100, F = 4'b0101, G = 4'b0111, H = 4'b1000, I = 4'b1001;
	reg [3:0] state = A, next_state;

	output reg[1:0] z;
	
	always @(posedge clk or posedge rst) begin
    if (rst)
        state <= A;
    else
        state <= next_state;
	end
	
	always @(*) begin
    case (state)
      A: if (w == 1) next_state = F;
            else    next_state = B;
		B: if (w == 1) next_state = F;
			else next_state = C;
		C: if (w == 1) next_state = F;
			else next_state = D;
		D: if (w == 1) next_state = F;
			else next_state = E;
		E: if (w==1) next_state = F;
			else next_state = E;
		F: if (w==1) next_state = G;
			else next_state = B;
		G: if (w==1) next_state = H;
			else next_state = B;
		H: if (w==1) next_state = I;
			else next_state = B;
		I: if (w==1) next_state = I;
			else next_state = B;
      default: next_state = A;
    endcase
   end
	always @(*) begin
		case (state)
			A: z = 0;
			B: z = 0;
			C: z = 0;
			D: z = 0;
			E: z = 1;
			F: z = 0;
			G: z = 0;
			H: z = 0;
			I: z = 1;
			default: z = 0;
		endcase
	end
endmodule