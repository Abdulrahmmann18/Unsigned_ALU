// this is a module for unsigned 16-bit ALU

module Unsigned_16bit_ALU (
    // inputs and outputs
    input wire CLK,
    input wire [15:0] A, B,
    input wire [3:0] ALU_FUN,
    output reg [15:0] ALU_OUT,
    output reg Arith_Flag, Logic_Flag, CMP_Flag, Shift_Flag
);

    // internal signals
    reg [15:0] ALU_OUT_comb;
    reg Arith_Flag_comb, Logic_Flag_comb, CMP_Flag_comb, Shift_Flag_comb;

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // combinational always block for ALU_OUT
    always @(*) begin
        case (ALU_FUN)
            4'b0000 : ALU_OUT_comb = A + B;
            4'b0001 : ALU_OUT_comb = A - B;
            4'b0010 : ALU_OUT_comb = A * B;
            4'b0011 : ALU_OUT_comb = A / B;
            4'b0100 : ALU_OUT_comb = A & B;
            4'b0101 : ALU_OUT_comb = A | B;
            4'b0110 : ALU_OUT_comb = ~(A & B);
            4'b0111 : ALU_OUT_comb = ~(A | B);
            4'b1000 : ALU_OUT_comb = A ^ B;
            4'b1001 : ALU_OUT_comb = ~(A ^ B);
            4'b1010 : ALU_OUT_comb = (A == B) ? 16'd1 : 16'd0;
            4'b1011 : ALU_OUT_comb = (A > B) ? 16'd2 : 16'd0;
            4'b1100 : ALU_OUT_comb = (A < B) ? 16'd3 : 16'd0;
            4'b1101 : ALU_OUT_comb = A >> 1;
            4'b1110 : ALU_OUT_comb = A << 1; 
            default : ALU_OUT_comb = 16'b0;
        endcase
    end
    // combinational always block for Arith_Flag
    always @(*) begin
        case (ALU_FUN)
            4'b0000 : Arith_Flag_comb = 1'b1;
            4'b0001 : Arith_Flag_comb = 1'b1;
            4'b0010 : Arith_Flag_comb = 1'b1;
            4'b0011 : Arith_Flag_comb = 1'b1;
            default : Arith_Flag_comb = 1'b0;
        endcase
    end
    // combinational always block for Logic_Flag
    always @(*) begin
        case (ALU_FUN)
            4'b0100 : Logic_Flag_comb = 1'b1;
            4'b0101 : Logic_Flag_comb = 1'b1;
            4'b0110 : Logic_Flag_comb = 1'b1;
            4'b0111 : Logic_Flag_comb = 1'b1;
            4'b1000 : Logic_Flag_comb = 1'b1;
            4'b1001 : Logic_Flag_comb = 1'b1;
            default : Logic_Flag_comb = 1'b0;
        endcase
    end
    // combinational always block for CMP_Flag
    always @(*) begin
        case (ALU_FUN)
            4'b1010 : CMP_Flag_comb = 1'b1;
            4'b1011 : CMP_Flag_comb = 1'b1;
            4'b1100 : CMP_Flag_comb = 1'b1;
            default : CMP_Flag_comb = 1'b0;
        endcase
    end
    // combinational always block for Shift_Flag
    always @(*) begin
        case (ALU_FUN)
            4'b1101 : Shift_Flag_comb = 1'b1;
            4'b1110 : Shift_Flag_comb = 1'b1;
            default : Shift_Flag_comb = 1'b0;
        endcase
    end
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // sequintial always block for output
    always @(posedge CLK) begin
        ALU_OUT <= ALU_OUT_comb;
        Arith_Flag <= Arith_Flag_comb;
        Logic_Flag <= Logic_Flag_comb;
        CMP_Flag <= CMP_Flag_comb;
        Shift_Flag <= Shift_Flag_comb;
    end

endmodule