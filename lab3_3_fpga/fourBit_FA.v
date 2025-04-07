module fourBit_FA(a,b,cin,cout,s);
	//some inputs and outputs are 1-bit, some are 4-bit
	input [3:0] a, b;
	input cin;
	output reg [3:0] s;
	output reg cout;
	
	wire [2:0] c;
	wire cout_t;
	wire [3:0] s_t;
	
	FA fa0 (.a(a[0]), .b(b[0]), .cin(cin), .cout(c[0]), .s(s_t[0]));
	FA fa1 (.a(a[1]), .b(b[1]), .cin(c[0]), .cout(c[1]), .s(s_t[1]));
	FA fa2 (.a(a[2]), .b(b[2]), .cin(c[1]), .cout(c[2]), .s(s_t[2]));
	FA fa3 (.a(a[3]), .b(b[3]), .cin(c[2]), .cout(cout_t), .s(s_t[3]));
	
	always @(*) begin
		cout = cout_t;
		s = s_t;
	end
	
endmodule