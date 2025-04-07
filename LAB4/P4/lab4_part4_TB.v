`timescale 1ns / 1ps
 
module lab4_part4_TB;
 
	// ------------------ Instantiate module ------------------
	// We are instantiating the module gated_RS, naming it instantiate_gated_RS.
	
	reg [3:0] count;
	reg Din,Clkin;
	wire Qout1,Qnotout1,Qout2,Qnotout2,Qout3,Qnotout3;
	
	// instantiate and connect all 3 flip flops/latches
	// Use same inputs (same inputs for D, clk to all instances)
	// Use 3 separate outputs (see wires above)
	
	//dff_pos instantiate_dff_pos (();

	//dff_neg instantiate_dff_neg (();
	
	//d_latch instantiate_d_latch (();
	
	initial begin 
		count = 4'b0000;
		Clkin =1'b0;
	end
	
	always begin
		#50
		count=count+4'b0001;
	end
	
	always begin
		#100
		Clkin = 1'b0;
		#100
		Clkin = 1'b1;
	end	

	
	always @(count) begin
		case (count)
		4'b0000 : begin Din = 1'b0; end
		4'b0001 : begin Din = 1'b0; end
		4'b0010 : begin Din = 1'b0; end
		4'b0011 : begin Din = 1'b0; end
		4'b0100 : begin Din = 1'b1; end
		4'b0101 : begin Din = 1'b1; end
		4'b0110 : begin Din = 1'b1; end
		4'b0111 : begin Din = 1'b1; end
		4'b1000 : begin Din = 1'b1; end
		4'b1001 : begin Din = 1'b0; end
		4'b1010 : begin Din = 1'b0; end
		4'b1011 : begin Din = 1'b0; end
		4'b1100 : begin Din = 1'b1; end
		4'b1101 : begin Din = 1'b0; end
		4'b1110 : begin Din = 1'b0; end
		4'b1111 : begin Din = 1'b0; end
		default : begin Din = 1'b0; end
	endcase
	end

 
endmodule
