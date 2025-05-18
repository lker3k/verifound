module program_counter (
    input  wire clk,
    input  wire rst_n,
    input  wire branch,
    input  wire [7:0] branchaddress,
    output reg  [7:0] pc
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            pc <= 8'b0;
        else if (branch)
            pc <= branchaddress;
        else
            pc <= pc + 1;
    end
endmodule