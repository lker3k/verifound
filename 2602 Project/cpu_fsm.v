module cpu_fsm(clk, rst, instruction, en_reg, tri_reg, general_reg, done, addclr, xorclr);

    parameter OP_SIZE = 4;
    parameter ARG_SIZE = 3;
    parameter ARG_NUM = 2;

    input clk, rst;
    input [OP_SIZE + ARG_NUM * ARG_SIZE - 1:0] instruction;

    output reg  [5:0]   general_reg = 0; // non bus lines
    output reg  [7:0]   en_reg = 0;  // read from bus
    output reg  [10:0]  tri_reg = 0; // write to bus
    output reg done, addclr, xorclr; // used to incement program counter, clrs used to set add and xor to 0

    reg RX_en, RY_en, RX_tri, RY_tri, extern, g_en, g_tri, a_en, a_tri, b_en, b_tri, h_en, h_tri;
    reg [7:0] en_regX, en_regY, tri_regX, tri_regY = 0;

	 // take operater part of instruction
    wire [OP_SIZE - 1 : 0] operation = instruction[OP_SIZE + ARG_NUM * ARG_SIZE - 1: ARG_NUM * ARG_SIZE];
    wire [ARG_SIZE - 1 : 0] arg1 = instruction[ARG_SIZE * ARG_NUM - 1 : ARG_SIZE];
    wire [ARG_SIZE - 1 : 0] arg2 = instruction[ARG_SIZE - 1 : 0];
	 
	 
    // encode instructions
    localparam OP_LOAD    = 4'b0000;
    localparam OP_MOVE    = 4'b0001;
    localparam OP_ADD     = 4'b0010;
    localparam OP_XOR     = 4'b0011;

	 // register encoding
    localparam R0 = 3'b000;
    localparam R1 = 3'b001;
    localparam R2 = 3'b010;
    localparam R3 = 3'b011;
    localparam R4 = 3'b100;
    localparam R5 = 3'b101;
    localparam R6 = 3'b110;
    localparam PC = 3'b111;

    // state encoding
    parameter   IDLE = 4'b0000,
                LOAD = 4'b0001,
                MOVE = 4'b0010,
                ADD1 = 4'b0100,
                ADD2 = 4'b0101,
                ADD3 = 4'b0111,
                XOR1 = 4'b1000,
                XOR2 = 4'b1001,
                XOR3 = 4'b1011;
    reg [3:0] state = IDLE;
	 reg [3:0] next_state;

    // state machine
    always @(*) begin: next_state_logic
        next_state = state;
        case(state)
            IDLE: begin case(operation)
                    OP_LOAD : next_state = LOAD;
                    OP_MOVE : next_state = MOVE;
                    OP_ADD  : next_state = ADD1;
                    OP_XOR  : next_state = XOR1;
                    default : next_state = IDLE;
                endcase end
            LOAD: begin case(operation)
                    OP_LOAD : next_state = LOAD;
                    OP_MOVE : next_state = MOVE;
                    OP_ADD  : next_state = ADD1;
                    OP_XOR  : next_state = XOR1;
                    default : next_state = IDLE;
                endcase end // note an error here, it should go to next stage 
													  // base on instruction, not just straight back to IDLE
            MOVE: begin case(operation)
                    OP_LOAD : next_state = LOAD;
                    OP_MOVE : next_state = MOVE;
                    OP_ADD  : next_state = ADD1;
                    OP_XOR  : next_state = XOR1;
                    default : next_state = IDLE;
                endcase end
				
            ADD1: next_state = ADD2;
            ADD2: next_state = ADD3;
            ADD3: begin case(operation)
                    OP_LOAD : next_state = LOAD;
                    OP_MOVE : next_state = MOVE;
                    OP_ADD  : next_state = ADD1;
                    OP_XOR  : next_state = XOR1;
                    default : next_state = IDLE;
                endcase end
				
            XOR1: next_state = XOR2;
            XOR2: next_state = XOR3;
            XOR3: begin case(operation)
                    OP_LOAD : next_state = LOAD;
                    OP_MOVE : next_state = MOVE;
                    OP_ADD  : next_state = ADD1;
                    OP_XOR  : next_state = XOR1;
                    default : next_state = IDLE;
                endcase end
				
            default : next_state = IDLE;
        endcase
    end

    always @(posedge clk or negedge rst) begin : state_transition_logic
        if (!rst) begin // reset low
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin : output_logic
	 RX_en   = 1'b0;
    RY_en   = 1'b0;
    RX_tri  = 1'b0;
    RY_tri  = 1'b0;
    extern  = 1'b0;
    g_en    = 1'b0;
    g_tri   = 1'b0;
    a_en    = 1'b0;
    a_tri   = 1'b0;
    b_en    = 1'b0;
    b_tri   = 1'b0;
    h_en    = 1'b0;
    h_tri   = 1'b0;
    done    = 1'b0;
    addclr  = 1'b0;
    xorclr  = 1'b0;
        case(state)
            LOAD: begin
                RX_en 	= 1'b1; 
                extern 	= 1'b1;
                done 	= 1'b1;
            end
            MOVE: begin 
                RX_en 	= 1'b1;
                RY_tri 	= 1'b1;
                done 	= 1'b1;
            end
            ADD1: begin
                RX_tri 	= 1'b1;
                a_en 	= 1'b1;
            end
            ADD2: begin
                g_en 	= 1'b1;
                RY_tri 	= 1'b1;
		addclr 	= 1'b1;
            end
            ADD3: begin
                g_tri 	= 1'b1;
                RX_en 	= 1'b1;
                done 	= 1'b1;
            end
            XOR1: begin
                RX_tri 	= 1'b1;
                b_en 	= 1'b1;
            end
            XOR2: begin
                h_en 	= 1'b1;
                RY_tri 	= 1'b1;
		xorclr 	= 1'b1;
            end
            XOR3: begin
                g_tri 	= 1'b1;
                RX_en 	= 1'b1;
                done 	= 1'b1;
            end
            default : begin
                RX_en   = 1'b0;
                RY_en   = 1'b0;
                RX_tri  = 1'b0;
                RY_tri  = 1'b0;
                extern	= 1'b0;
                g_en    = 1'b0;
                g_tri   = 1'b0;
                a_en    = 1'b0;
                a_tri   = 1'b0;
                b_en    = 1'b0;
                b_tri   = 1'b0;
                h_en    = 1'b0;
                h_tri   = 1'b0;
                done	= 1'b0;
		addclr	= 1'b0;
		xorclr	= 1'b0;
            end
        endcase
    end

    always @(*) begin : bus_IO
			en_regX = 0;
			en_regY = 0;
			tri_regX = 0;
			tri_regY = 0;
			
        if (RX_en) begin
            case(arg1)
                R0 : en_regX = 8'b00000001;
                R1 : en_regX = 8'b00000010;
                R2 : en_regX = 8'b00000100;
                R3 : en_regX = 8'b00001000;
                R4 : en_regX = 8'b00010000;
                R5 : en_regX = 8'b00100000;
                R6 : en_regX = 8'b01000000;
                PC : en_regX = 8'b10000000;
                default : en_regX = 8'b00000000;
            endcase
        end
        if (RY_en) begin
            case(arg1)
                R0 : en_regY = 8'b00000001;
                R1 : en_regY = 8'b00000010;
                R2 : en_regY = 8'b00000100;
                R3 : en_regY = 8'b00001000;
                R4 : en_regY = 8'b00010000;
                R5 : en_regY = 8'b00100000;
                R6 : en_regY = 8'b01000000;
                PC : en_regY = 8'b10000000;
                default : en_regY = 8'b00000000;
            endcase
        end
			
			
			
        if (RX_tri) begin
            case(arg2)
                R0 : tri_regX = 8'b00000001;
                R1 : tri_regX = 8'b00000010;
                R2 : tri_regX = 8'b00000100;
                R3 : tri_regX = 8'b00001000;
                R4 : tri_regX = 8'b00010000;
                R5 : tri_regX = 8'b00100000;
                R6 : tri_regX = 8'b01000000;
                PC : tri_regX = 8'b10000000;
                default : tri_regX = 8'b00000000;
            endcase
        end
        else if (RY_tri) begin
            case(arg2)
                R0 : tri_regY = 8'b00000001;
                R1 : tri_regY = 8'b00000010;
                R2 : tri_regY = 8'b00000100;
                R3 : tri_regY = 8'b00001000;
                R4 : tri_regY = 8'b00010000;
                R5 : tri_regY = 8'b00100000;
                R6 : tri_regY = 8'b01000000;
                PC : tri_regY = 8'b10000000;
                default : tri_regY = 8'b00000000;
            endcase
        end

        general_reg = {a_en, a_tri, g_en, b_en, b_tri, h_en}; // used for add xor etc
        en_reg = en_regX | en_regY;
		  
        // only one register can write to the bus at a time
		if (g_tri) 			tri_reg = 11'b100_0000_0000; // prioritise adder output
	    else if (h_tri) 	tri_reg = 11'b010_0000_0000; // then xor output
        else if (extern) 	tri_reg = 11'b001_0000_0000; // then data
        else if (RX_tri)	tri_reg = {3'b000, tri_regX}; // then internal regs
        else if (RY_tri)	tri_reg = {3'b000, tri_regY};
        else                tri_reg = 11'b000_0000_0000;
    end
endmodule
