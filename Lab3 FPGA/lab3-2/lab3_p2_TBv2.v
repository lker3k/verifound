`timescale 1ns / 1ps
 
module lab3_p2_TBv2;
 
	// ------------------ Instantiate module ------------------
	// We are instantiating the module mux2, naming it instantiate_mux2.
	// select, input1, input2 are controlled by the testbench, output is 
	// checked  within the testbench
 
	reg [3:0] count;
	reg [3:0] input_binary;
	wire [6:0] output_7seg1, output_7seg2;
	
	lab3_p2_v2 instantiate_lab3_p2_v2(.v(), .d1(), .d2());
 	
	initial begin 
		count = 4'b0000;
	end
	
	always begin
		#50
		count=count+4'b0001;
	end
	
	always @(count) begin
		case (count)
		4'b0000 : begin input_binary = 4'b0000; end
		4'b0001 : begin input_binary = 4'b0101; end
		4'b0010 : begin input_binary = 4'b1010; end
		default : begin input_binary = 4'b0011; end
	endcase
	end

 
endmodule