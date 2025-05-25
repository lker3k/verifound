module memory #(
    parameter OP_SIZE = 4,
    parameter ARG_SIZE = 3,
    parameter ARG_NUM = 2
)(
    input clk,
    input rst,
    input branch,
	 input done,
    input [3:0] branchaddress,
    output [OP_SIZE + ARG_NUM * ARG_SIZE - 1:0] instruction
);

    localparam OP_LOAD = 4'b0000;
    localparam OP_MOVE = 4'b0001;
    localparam OP_ADD  = 4'b0010;
    localparam OP_XOR  = 4'b0011;
    localparam OP_BR   = 4'b1000;

    reg [OP_SIZE + ARG_NUM * ARG_SIZE - 1:0] rom [0:15];
    reg [3:0] pc;

    localparam NA = 3'b000;
    localparam R1 = 3'b001;
    localparam R2 = 3'b010;
    localparam R3 = 3'b011;
    localparam R4 = 3'b100;
    localparam R5 = 3'b101;
    localparam R6 = 3'b110;
    localparam PC = 3'b111;

    initial begin
        rom[0] = {OP_LOAD, R1, NA};  // Example: LOAD R1, NA
        rom[1] = {OP_MOVE, R2, R1};  // Example: MOV R1, R2
        rom[2] = {OP_ADD, R1, R2};   // Example: ADD R1, R2
        rom[3] = {OP_ADD, R1, R2};   // Example: XOR R1, R2
		  rom[4] = {OP_XOR, R2, R1};
    end

    assign instruction = rom[pc];

    // Program counter update
    always @(posedge clk or posedge rst) begin
        if (rst)
            pc <= 4'b0;
        else if (branch)
            pc <= branchaddress;
        else if (done)
            pc <= pc + 1;
		else pc <= pc;
    end
endmodule
