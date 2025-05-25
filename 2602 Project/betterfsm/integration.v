module integration (clk, rst);

	input clk, rst;
	
	
	parameter OP_SIZE = 4;
	parameter ARG_SIZE = 3;
	parameter ARG_NUM = 2;

	
	wire [OP_SIZE + ARG_NUM * ARG_SIZE - 1:0] instruction;
	
	wire [11:0] enable;
	wire [10:0]  tri_en;
	
	wire [2:0] bus;
	wire [2:0] A;
	wire [2:0] B;
	wire [2:0] G;
	wire [2:0] H;
	
	wire [2:0] data;
	
	wire done;
	
	wire [1:0] flags;
	
	// if assign last 3 bit, it will always be 3'b000 (instruction format) -> assign a value instead
	assign data = 3'b101;
	
	assign bus = (tri_en[8]) ? data : 3'bzzz; // load data onto the bus when there's command
	
	cpu_fsm fsm (.clk(clk), 
					.rst(rst), 
					.instruction(instruction), 
					.en_reg(enable), 
					.tri_reg(tri_en),
					.done(done), 
					.addclr(flags[0]), 
					.xorclr(flags[1]));
					
	memory memory (.clk(clk),
					 .rst(!rst),
					 .branch(0),
					 .done(done),
					 .branchaddress(0),
					 .instruction(instruction));

					 
	genvar i;
	generate 
		for (i = 0; i < 8; i = i + 1) begin : register_loop
			register register (
						  .clk(clk),
						  .R_in(enable[i]),
						  .R_out(tri_en[i]),
						  .rst(!rst),
						  .bus(bus));
		end
	endgenerate
	
	add_alu adder (.a(A), .b(bus), .g(G), .rst(!rst));
	xor_alu xor_  (.a(B), .b(bus), .g(H), .rst(!rst));
	
	A a (.A(A), .bus(bus), .a_in(enable[11]), .clk(clk), .rst(!rst));
	A b (.A(B), .bus(bus), .a_in(enable[9]), .clk(clk), .rst(!rst));
	
	alu_out g (.G(bus), .clk(clk), .rst(!rst), .G_in(enable[10]), .G_out(tri_en[10]), .alu_in(G));
				  
	alu_out h (.G(bus), .clk(clk), .rst(!rst), .G_in(enable[8]), .G_out(tri_en[9]), .alu_in(H));
endmodule