module L6_3(clk, w, rst, z, state, next_state, prev_state, counter, user_password, user_guess, password, guess);

	input clk;
	input w; 		// enable, 1 mean setting password, 0 mean guessing
	input rst;
	input [3:0] user_password;
	input [3:0] user_guess;

	parameter A = 4'b0000, B = 4'b0001, C = 4'b0010, D = 4'b0011, E = 4'b0100, F = 4'b0101, G = 4'b0110, H = 4'b0111, I = 4'b1000, J = 4'b1001, K = 4'b1010, L = 4'b1011, M = 4'b1100;
	output reg [3:0] state = A, next_state, prev_state;

	output reg [15:0] password;
	output reg [15:0] guess;
	output reg [1:0] z; // z0 for right password, z1 for wrong password
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
	
	/*
	always @(posedge clk or posedge rst) begin
		if (rst)		  counter <= 0;
		else if ((prev_state == B && state == F) || (prev_state == F && state == B)) counter <= 1;
		else if ((prev_state == I && state == B) || (prev_state == E && state == F)) counter <= 1;
		else if (state == B || state == F) counter <= counter + 1;
	end 
	*/
	always @(posedge clk or posedge rst) begin // password
		if (rst) begin
			password <= 0;
		end else begin
		case (state)
			B: password[15:12] <= user_password;
			C: password[11:8] <= user_password;
			D: password[7:4] <= user_password;
			E: password[3:0] <= user_password;
			default: password <= password;
		endcase
		end
	end
	
	always @(posedge clk or posedge rst) begin // guessing
		if (rst) begin
			guess <= 0;
		end else begin
		case(state)
			G: guess[15:12] <= user_guess;
			H: guess[11:8] <= user_guess;
			I: guess[7:4] <= user_guess;
			K: guess[3:0] <= user_guess;
			default: guess <= guess;
		endcase 
		end
	end
	
	always @(*) begin
    case (state)
      A: if (w == 1) next_state = B;
		B: next_state = C;
		C: next_state = D;
		D: next_state = E;
		E: next_state = F;
		F: if (w == 1) next_state = F;
			else next_state = G;
		G: next_state = H;
		H: next_state = I;
		I: next_state = J;
		J: next_state = K;
		K: if (guess == password) next_state = L;
			else next_state = M;
		L: next_state = L; // right password
		M: next_state = F; // wrong password
      default: next_state = A;
    endcase
   end
	always @(*) begin
		case (state)
			A: z = 0;
			B: z = 0;
			C: z = 0;
			D: z = 0;
			E: z = 0;
			F: z = 0;
			G: z = 0;
			H: z = 0;
			I: z = 0;
			J: z = 0;
			K: z = 0;
			L: begin 
				z[0] = 1;
				z[1] = 0;
			end
			M: begin
				z[0] = 0;
				z[1] = 1;
			end
			default: z = 0;
		endcase
	end
endmodule