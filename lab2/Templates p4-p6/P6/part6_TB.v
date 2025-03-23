`timescale 1ns / 1ps
 
module part6_TB;
 
	// ------------------ Instantiate module ------------------
	// We are instantiating the module mux2, naming it instantiate_mux2.
	// select, input1, input2 are controlled by the testbench, output is 
	// checked  within the testbench
 
	reg [1:0] count;
	reg [1:0] S,U,V,W,X;
	
	wire [6:0] output_7seg1, output_7seg2, output_7seg3, output_7seg4;
	part6 instantiate_p6 (.s(S),.u(U),.v(V),.w(W),.x(X),
							.code1(output_7seg1),
							.code2(output_7seg2),
							.code3(output_7seg3),
							.code4(output_7seg4)
							);
 	
	initial begin 
		count = 2'b00;
	end
	
	always begin
		#50
		count=count+2'b01;
	end
	
	always @(count) begin
		case (count)
		2'b00 : begin U = 2'b00; V = 2'b01; W = 2'b10; X = 2'b11; S = 2'b00; end
		2'b01 : begin U = 2'b00; V = 2'b01; W = 2'b10; X = 2'b11; S = 2'b01; end
		2'b10 : begin U = 2'b00; V = 2'b01; W = 2'b10; X = 2'b11; S = 2'b10; end
		2'b11 : begin U = 2'b00; V = 2'b01; W = 2'b10; X = 2'b11; S = 2'b11; end
		default : begin {U, V, W, X, S} = ($urandom()); end
	endcase
	end

 
endmodule
