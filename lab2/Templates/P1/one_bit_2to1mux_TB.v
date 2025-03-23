`timescale 1ns / 1ps
 
module one_bit_2to1mux_TB;
 
	// ------------------ Instantiate module ------------------
	// We are instantiating the module mux2, naming it instantiate_mux2.
	// select, input1, input2 are controlled by the testbench, output is 
	// checked  within the testbench
 
	reg [3:0] count;
	reg select, input1, input2;
	wire output1;
	one_bit_2to1mux instantiate_mux2(.s(select),.x(input1),.y(input2),.m(output1));
 	
	initial begin 
		count = 4'b0000;
	end
	
	always begin
		#50
		count=count+4'b0001;
	end
	
	always @(count) begin
		case (count)
		4'b0000 : begin input1 = 1'b0; input2 = 1'b1; select = 1'b0; end
		4'b0001 : begin input1 = 1'b0; input2 = 1'b1; select = 1'b1; end
		4'b0010 : begin input1 = 1'b1; input2 = 1'b0; select = 1'b0; end 
		4'b0011 : begin input1 = 1'b1; input2 = 1'b0; select = 1'b1; end
		default : begin input1 = 1'b0; input2 = 1'b0; select = 1'b0; end
	endcase
	end

 
endmodule
