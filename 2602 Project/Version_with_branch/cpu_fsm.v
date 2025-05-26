module cpu_fsm(clk, rst, instruction, en_reg, tri_reg, done, addclr, xorclr, branch, br_add, bxlr);

    parameter OP_SIZE = 4;
    parameter ARG_SIZE = 3;
    parameter ARG_NUM = 2;

    input clk, rst;
    input [OP_SIZE + ARG_NUM * ARG_SIZE - 1:0] instruction;


    output reg  [11:0]   en_reg = 0;  // read from bus
    output reg  [11:0]  tri_reg = 0; // write to bus
    output reg done, addclr, xorclr; // used to incement program counter, clrs used to set add and xor to 0
	 output reg branch;
	 output reg bxlr;
	 output      [5:0] br_add;

    reg RX_en, RY_en, a_en, g_en, b_en, h_en;
    reg [7:0] en_regX, en_regY, tri_regX, tri_regY = 0;
	 
	 reg [OP_SIZE + ARG_NUM * ARG_SIZE - 1:0] prev_instruction;
	 
	 always @(posedge clk or negedge rst) begin
		  if (!rst) begin
				prev_instruction <= 0;
		  end else if (done) begin
				prev_instruction <= instruction;
		  end
	 end

	 // take operater part of instruction
    wire [OP_SIZE - 1 : 0] operation = instruction[OP_SIZE + ARG_NUM * ARG_SIZE - 1: ARG_NUM * ARG_SIZE];
    wire [ARG_SIZE - 1 : 0] arg1 = prev_instruction[ARG_SIZE * ARG_NUM - 1 : ARG_SIZE];
    wire [ARG_SIZE - 1 : 0] arg2 = prev_instruction[ARG_SIZE - 1 : 0];
	 
	 assign br_add = (branch) ? prev_instruction[5:0] : 6'bz;
	 
	 
    // encode instructions
    localparam OP_LOAD    = 4'b0000;
    localparam OP_MOVE    = 4'b0001;
    localparam OP_ADD     = 4'b0010;
    localparam OP_XOR     = 4'b0011;
	 localparam OP_BRN	  = 4'b0100;
	 localparam OP_LDPC	  = 4'b0101;
	 localparam OP_BXLR    = 4'b0110;

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
	parameter   IDLE = 5'b00000,
					LOD1 = 5'b00001,
					LOD2 = 5'b00010,
					MOV1 = 5'b00011,
					MOV2 = 5'b00100,
					ADD1 = 5'b00101,
					ADD2 = 5'b00111,
					ADD3 = 5'b01000,
					XOR1 = 5'b01001,
					XOR2 = 5'b01010,
					XOR3 = 5'b01011,
					BRN1 = 5'b01100,
					BRN2 = 5'b01101,
					LDPC1 = 5'b01110,
					LDPC2 = 5'b01111,
					BXLR1 = 5'b10000,
					BXLR2 = 5'b10001;

    reg [4:0] state = IDLE;
	 reg [4:0] next_state;
	 
	 
	 	 localparam TRI_NONE   = 3'b000,
           TRI_G      = 3'b001,
           TRI_H      = 3'b010,
           TRI_EXTERN = 3'b011,
           TRI_RX     = 3'b100,
           TRI_RY     = 3'b101,
			  TRI_PC     = 3'b110;

	reg [2:0] tri_src;

    // state machine
    always @(*) begin: next_state_logic
        next_state = state;
        case(state)
            IDLE: begin case(operation)
                    OP_LOAD : next_state = LOD1;
                    OP_MOVE : next_state = MOV1;
                    OP_ADD  : next_state = ADD1;
                    OP_XOR  : next_state = XOR1;
						  OP_BRN  : next_state = BRN1;
						  OP_LDPC : next_state = LDPC1;
						  OP_BXLR : next_state = BXLR1;
                    default : next_state = IDLE;
                endcase end
				LOD1: next_state = LOD2;
            LOD2: begin case(operation)
                    OP_LOAD : next_state = LOD1;
                    OP_MOVE : next_state = MOV1;
                    OP_ADD  : next_state = ADD1;
                    OP_XOR  : next_state = XOR1;
						  OP_BRN  : next_state = BRN1;
						  OP_LDPC : next_state = LDPC1;
						  OP_BXLR : next_state = BXLR1;
                    default : next_state = IDLE;
                endcase end
				MOV1: next_state = MOV2;
            MOV2: begin case(operation)
                    OP_LOAD : next_state = LOD1;
                    OP_MOVE : next_state = MOV1;
                    OP_ADD  : next_state = ADD1;
                    OP_XOR  : next_state = XOR1;
						  OP_BRN  : next_state = BRN1;
						  OP_LDPC : next_state = LDPC1;
						  OP_BXLR : next_state = BXLR1;
                    default : next_state = IDLE;
                endcase end
				
            ADD1: next_state = ADD2;
            ADD2: next_state = ADD3;
            ADD3: begin case(operation)
                    OP_LOAD : next_state = LOD1;
                    OP_MOVE : next_state = MOV1;
                    OP_ADD  : next_state = ADD1;
                    OP_XOR  : next_state = XOR1;
						  OP_BRN  : next_state = BRN1;
						  OP_LDPC : next_state = LDPC1;
						  OP_BXLR : next_state = BXLR1;
                    default : next_state = IDLE;
                endcase end
				
            XOR1: next_state = XOR2;
            XOR2: next_state = XOR3;
            XOR3: begin case(operation)
                    OP_LOAD : next_state = LOD1;
                    OP_MOVE : next_state = MOV1;
                    OP_ADD  : next_state = ADD1;
                    OP_XOR  : next_state = XOR1;
						  OP_BRN  : next_state = BRN1;
						  OP_LDPC : next_state = LDPC1;
						  OP_BXLR : next_state = BXLR1;
                    default : next_state = IDLE;
                endcase end
				 BRN1: next_state = BRN2;
				 BRN2: next_state = IDLE;
				 
				 LDPC1: next_state = LDPC2;
				 LDPC2: next_state = IDLE;
				 
				 BXLR1: next_state = BXLR2;
				 BXLR2: next_state = IDLE;
				
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
		 g_en    = 1'b0;
		 a_en    = 1'b0;
		 b_en    = 1'b0;
		 h_en    = 1'b0;
		 done		= 1'b0;
		 addclr	= 1'b0;
		 xorclr	= 1'b0;
		 branch  = 1'b0;
		 bxlr		= 1'b0;
        case(state)
            LOD1: begin
                RX_en 	= 1'b1; 
                tri_src = TRI_EXTERN;
            end
				LOD2: begin
					done		=1'b1;
				end
            MOV1: begin 
                RX_en 	= 1'b1;
                tri_src = TRI_RY;
            end
				MOV2: begin
					done 		= 1'b1;
				end
            ADD1: begin
                tri_src = TRI_RX;
					 
                a_en 	= 1'b1;
            end
            ADD2: begin
                g_en 	= 1'b1;
                tri_src = TRI_RY;
					 addclr 	= 1'b1;
            end
            ADD3: begin
					 addclr	= 1'b0;
                tri_src = TRI_G;
                RX_en 	= 1'b1;
                done 	= 1'b1;
            end
            XOR1: begin
                tri_src = TRI_RX;
                b_en 	= 1'b1;
            end
            XOR2: begin
                h_en 	= 1'b1;
                tri_src = TRI_RY;
					xorclr 	= 1'b1;
            end
            XOR3: begin
					 xorclr	= 1'b0;
                tri_src = TRI_H;
                RX_en 	= 1'b1;
                done 	= 1'b1;
            end
				BRN1: begin 
					branch = 1'b1;
				end
				BRN2: begin
					done = 1'b1;
				end
				LDPC1: begin
					 tri_src = TRI_PC; // raise export pc flag
					 RX_en 	= 1'b1; // saving PC
				end
				LDPC2: begin
					branch = 1'b1; // raise the overwriting flag
					done = 1'b1;
				end
				BXLR1: begin
					bxlr = 1'b1;
					tri_src = TRI_RX;
				end 
            default : begin
                RX_en   = 1'b0;
                RY_en   = 1'b0;
                g_en    = 1'b0;
                a_en    = 1'b0;
                b_en    = 1'b0;
                h_en    = 1'b0;
                done		= 1'b0;
					 addclr	= 1'b0;
					 xorclr	= 1'b0;
					 branch  = 1'b0;
					 bxlr		= 1'b0;
            end
        endcase
    end

	 always @(*) begin : triregoutput
		tri_regX = 0;
		tri_regY = 0;
	 
		case (tri_src)
			TRI_RX : begin
				case(arg1)
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

        TRI_RY : begin
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
		  
		  default begin
				tri_regX = 8'b0000000;
				tri_regY = 8'b0000000;
		  end
		endcase

		 case (tri_src)
			  TRI_G:      tri_reg = 12'b0100_0000_0000;
			  TRI_H:      tri_reg = 12'b0010_0000_0000;
			  TRI_EXTERN: tri_reg = 12'b0001_0000_0000;
			  TRI_PC:     tri_reg = 12'b1000_0000_0000;
			  TRI_RX:     tri_reg = {4'b000, tri_regX};
			  TRI_RY:     tri_reg = {4'b000, tri_regY};
			  default:    tri_reg = 12'b000_0000_0000;
		 endcase
	end
	 
	 
    always @(*) begin : enregoutputs
			en_regX = 0;
			en_regY = 0;
			en_reg = 0;
			
        if (RX_en) begin
				if (tri_src == TRI_PC) begin
					en_regX = 8'b10000000;
				end else begin
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
		  end
        if (RY_en) begin
            case(arg2)
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
        en_reg = {a_en, g_en, b_en, h_en, (en_regX | en_regY)};
		end
endmodule
