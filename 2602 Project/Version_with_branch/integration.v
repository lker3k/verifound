module integration (clk, rst, bus_out);

	input clk, rst;
	
	output [15:0] bus_out;
	parameter OP_SIZE = 4;
	parameter ARG_SIZE = 3;
	parameter ARG_NUM = 2;

	
	wire [OP_SIZE + ARG_NUM * ARG_SIZE - 1:0] instruction;
	
	wire [11:0] enable;
	wire [11:0]  tri_en;
	
	wire [15:0] bus;
	wire [15:0] A;
	wire [15:0] B;
	wire [15:0] G;
	wire [15:0] H;
	
	wire [15:0] data;
	
	wire done;
	
	wire [1:0] flags;
	
	wire branch;
	
	wire bxlr;
	
	wire [5:0] br_add;
	
	// if assign last 3 bit, it will always be 3'b000 (instruction format) -> assign a value instead
	assign data = 16'b0000_0000_0101;
	
	assign bus = (tri_en[8]) ? data : 16'bz; // load data onto the bus when there's command
	
	assign bus_out = bus;
	
	
	reg [5:0] branchaddress;
	
	always @(*) begin
		if (!rst) begin
			branchaddress = 0;
		end else if (branch) begin
			branchaddress = br_add;
		end else if (bxlr) begin
			branchaddress = bus[5:0];
		end else begin
			branchaddress = 6'bz;
		end
	end
	
	cpu_fsm fsm (.clk(clk), 
					.rst(rst), 
					.instruction(instruction), 
					.en_reg(enable),
				   .branch(branch),
				   .br_add(br_add),	
					.tri_reg(tri_en),
					.done(done), 
					.bxlr(bxlr),
					.addclr(flags[0]), 
					.xorclr(flags[1]));
					
	memory memory (.clk(clk),
					 .rst(!rst),
					 .branch(branch | bxlr),
					 .export_pc(tri_en[11]),
					 .done(done),
					 .branchaddress(branchaddress),
					 .out_pc(bus[5:0]),
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