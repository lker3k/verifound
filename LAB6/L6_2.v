module L6_2(clk, w, rst, z, state, next_state, limit, prev_state, counter);

	input clk;
	input w;
	input rst;
	input [3:0] limit;

	parameter A = 4'b0000, B = 4'b0001, C = 4'b0010, D = 4'b0011, E = 4'b0100, F = 4'b0101, G = 4'b0110, H = 4'b0111, I = 4'b1000;
	output reg [3:0] state = A, next_state, prev_state;

	output reg z;
	
	output reg [3:0] counter;
	
	always @(posedge clk or posedge rst) begin
    if (rst) begin
        state <= A;
		  prev_state <= A;

	 end else begin
        state <= next_state;
		  prev_state <= state;
	 end
	end
	
	always @(posedge clk or posedge rst) begin
		if (rst)		  counter <= 0;
		else if ((prev_state == B && state == F) || (prev_state == F && state == B)) counter <= 1;
		else if ((prev_state == I && state == B) || (prev_state == E && state == F)) counter <= 1;
		else if (state == B || state == F) counter <= counter + 1;
	end 
	
	
	always @(*) begin
    case (state)
      A: if (w == 1) next_state = F;
            else    next_state = B;
		B: if (w == 1) next_state = F;
			else if (counter == limit-1) next_state = E;
		E: if (w==1) next_state = F;
			else next_state = E;
		F: if (w==0) next_state = B;
			else if (counter == limit-1) next_state = I;
		I: if (w==1) next_state = I;
			else next_state = B;
      default: next_state = A;
    endcase
   end
	always @(*) begin
		case (state)
			A: z = 0;
			B: z = 0;
			E: z = 1;
			F: z = 0;
			I: z = 1;
			default: z = 0;
		endcase
	end
endmodule