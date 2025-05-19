module memory (
    input clk,
    input rst,
    input branch,
    input [3:0] branchaddress
    output reg [7:0] instruction
);
    reg [7:0] rom [0:15];
    reg [3:0] pc;
    localparam NA = 2'b00;
    localparam R1 = 2'b01;
    localparam R2 = 2'b10;

    initial begin
        rom[0] = {4'b0001, R1, NA};
        rom[1] = {4'b0010, R1, R2};
        rom[2] = {4'b0011, R1, R2};
        rom[3] = {4'b0100, R1, R2};
    end

    always @(*) begin
        instruction = rom[pc];
    end

    always @(posedge clk or posedge rst) begin
        if (rst)
            pc <=4'b0
        else if (branch)
            pc <= branchaddress;
        else
            pc <= pc + 1
    end
endmodule