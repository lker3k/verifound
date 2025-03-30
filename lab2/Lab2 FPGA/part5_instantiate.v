module part5_instantiate(SW,HEX0);

	input[9:0] SW;
	output [6:0] HEX0;
	part5 instantiate_p5 (.s(SW[9:8]),.u(SW[7:6]),.v(SW[5:4]),.w(SW[3:2]),.x(SW[1:0])
							,.chosen_7segCode(HEX0));
	
endmodule