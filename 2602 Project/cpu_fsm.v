module cpu_fsm(clk, rst, instruction);

    parameter OP_SIZE = 4;
    parameter ARG_SIZE = 3;
    parameter ARG_NUM = 2;

    input clk, rst;
    input [OP_SIZE + ARG_NUM * ARG_SIZE - 1:0] instruction;

    output reg RX_en, RY_en, RX_tri, RY_tri;
    output reg data_tri, g_en, g_tri, a_en, a_tri;

    

    // encode instructions
    localparam OP_LOAD    = 2'b0000;
    localparam OP_MOVE    = 2'b0001;
    localparam OP_ADD     = 2'b0010;
    localparam OP_XOR     = 2'b0011;

    // take operater part of instruction
    reg [OP_SIZE - 1 : 0] operation = instruction[OP_SIZE + ARG_NUM * ARG_SIZE - 1: ARG_NUM * ARG_SIZE];
    reg [ARG_SIZE - 1 : 0] arg1 = instruction[ARG_SIZE * ARG_NUM - 1 : ARG_SIZE];
    reg [ARG_SIZE - 1 : 0] arg2 = instruction[ARG_SIZE - 1 : 0];
    
    
    // states
    parameter   IDLE = 4'b0000,
                LOAD = 4'b0001,
                MOVE = 4'b0010,
                ADD1 = 4'b0100,
                ADD2 = 4'b0101,
                ADD3 = 4'b0111,
                XOR1 = 4'b1000,
                XOR2 = 4'b1001,
                XOR3 = 4'b1011;
    output reg [3:0] state = IDLE, next_state;

    // state machine
    always @(*) begin: next_state_logic
        next_state = state;
        case(state)
            IDLE: begin case(operater)
                    OP_LOAD : next_state = LOAD;
                    OP_MOVE : next_state = MOVE;
                    OP_ADD  : next_state = ADD1;
                    OP_XOR  : next_state = XOR1;
                    default : next_state = IDLE;
                endcase end
            LOAD    : next_state = IDLE;
            MOVE    : next_state = IDLE;
            ADD1    : next_state = ADD2;
            ADD2    : next_state = ADD3;
            ADD3    : next_state = IDLE;
            XOR1    : next_state = XOR2;
            XOR2    : next_state = XOR3;
            XOR3    : next_state = IDLE;
            default : next_state = IDLE;
        endcase
    end

    always @(posedge clk or negedge rst) begin : state_transition_logic
        if (rst) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin : output_logic
        case(state)
            IDLE:
            LOAD: RX_en = 1, data_tri = 1;
            MOVE: RX_en = 1, RY_tri = 1; // RY -> RX
            ADD1: RX_tri = 1, A_en = 1;
            ADD2: G_en = 1;
            ADD3: G_tri = 1, RX_en;
            XOR1: RX_tri = 1, B_en = 1;
            XOR2: H_en = 1;
            XOR3: G_tri = 1, RX_en;
            default : begin
                RX_en       = 0;
                RY_en       = 0;
                RX_tri      = 0;
                RY_tri      = 0;
                data_tri    = 0;
                g_en        = 0;
                g_tri       = 0;
                a_en        = 0;
                a_tri       = 0;
            end
        endcase
    end


    always @(*) begin : registers
        case(arg1)
            000 : RX_out = 00000001;
            001 : RX_out = 00000010;
            010 : RX_out = 00000100;
            011 : RX_out = 00001000;
            100 : RX_out = 00010000;
            101 : RX_out = 00100000;
            110 : RX_out = 01000000;
            111 : RX_out = 10000000;
        endcase
    end

endmodule