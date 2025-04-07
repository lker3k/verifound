module lab3_p2_v1 (v, d1, d2);
    input [3:0] v; 
	output [6:0] d1, d2; 
	
	//Add any required intermediate wires here
	wire [3:0] wire1, wire2;
	wire wire3;
	
	circuitA inst_circA(.v(v),.A(wire1));
	comparator inst_comp(.v(v),.z(wire3));
	circuitB inst_circB(.z(wire3),.d1(d1));
	four_bit_2to1mux inst_mux(.sel(wire3),.a(v),.b(wire1),.chosen(wire2));
	binary_to_7Seg instantiate_bto7seg(.binary(wire2),.sevenSeg(d2));
	
endmodule