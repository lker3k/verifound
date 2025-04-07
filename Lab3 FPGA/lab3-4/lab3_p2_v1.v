module lab3_p2_v1 (v, d1, d2);
    input [3:0] v; 
	output [6:0] d1, d2; 
	
	//Add any required intermediate wires here
	wire [3:0] Aout, wire2, wire3;
	wire comp_out;
	
	circuitA inst_circA(
		.v(v),
		.A(Aout)
	);
	
	comparator inst_comp(
		.v(v),
		.z(comp_out)
	);
	
	circuitB inst_circB(
		.z(comp_out),
		.d1(wire3)
	);
	
	four_bit_2to1mux inst_mux(
		.sel(comp_out),
		.a(v),
		.b(Aout),
		.chosen(wire2)
	);
	
		binary_to_7Seg instantiate_bto7seg1(
		.binary(wire3),
		.sevenSeg(d1)
	);
	
	binary_to_7Seg instantiate_bto7seg2(
		.binary(wire2),
		.sevenSeg(d2)
	);
	
endmodule