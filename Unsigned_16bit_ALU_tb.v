// i am applying this testbench on clock frequancy 100KHZ >> clock cycle = 10us

`timescale 1us/1ns   
module Unsigned_16bit_ALU_tb ();
    
    // signal declaration
    reg CLK;
    reg [15:0] A_tb, B_tb;
    reg [3:0] ALU_FUN_tb;
    wire [15:0] ALU_OUT_tb;
    wire Arith_Flag_tb, Logic_Flag_tb, CMP_Flag_tb, Shift_Flag_tb;

    // DUT Instantiation
    Unsigned_16bit_ALU DUT (
        .CLK(CLK), .A(A_tb), .B(B_tb),
        .ALU_FUN(ALU_FUN_tb), .ALU_OUT(ALU_OUT_tb),
        .Arith_Flag(Arith_Flag_tb), .Logic_Flag(Logic_Flag_tb),
        .CMP_Flag(CMP_Flag_tb), .Shift_Flag(Shift_Flag_tb)
    );

    // clock generator block
    always begin
        #(10/2) CLK = ~CLK;
    end

    // test stimulus 
    initial begin
        // initialize inputs
        CLK = 0;  A_tb = 16'd10;  B_tb = 16'd2;  
        // case(1) ADD
        ALU_FUN_tb = 4'b0000;
        #10
        if ((ALU_OUT_tb == 16'd12) && (Arith_Flag_tb) && (~Logic_Flag_tb) && (~CMP_Flag_tb) && (~Shift_Flag_tb)) 
            $display("Addition is correct");
        else
            $display("Addition is not correct");
        // case(2) SUB
        ALU_FUN_tb = 4'b0001;
        #10
        if ((ALU_OUT_tb == 16'd8) && (Arith_Flag_tb) && (~Logic_Flag_tb) && (~CMP_Flag_tb) && (~Shift_Flag_tb)) 
            $display("Subtraction is correct");
        else
            $display("Subtraction is not correct");
        // case(3) MUL
        ALU_FUN_tb = 4'b0010;
        #10
        if ((ALU_OUT_tb == 16'd20) && (Arith_Flag_tb) && (~Logic_Flag_tb) && (~CMP_Flag_tb) && (~Shift_Flag_tb)) 
            $display("Multplication is correct");
        else
            $display("Multplication is not correct");
        // case(4) DIV
        ALU_FUN_tb = 4'b0011;
        #10
        if ((ALU_OUT_tb == 16'd5) && (Arith_Flag_tb) && (~Logic_Flag_tb) && (~CMP_Flag_tb) && (~Shift_Flag_tb)) 
            $display("Div is correct");
        else
            $display("Div is not correct");
        // case(5) AND
        ALU_FUN_tb = 4'b0100;
        #10
        if ((ALU_OUT_tb == 16'b0010) && (~Arith_Flag_tb) && (Logic_Flag_tb) && (~CMP_Flag_tb) && (~Shift_Flag_tb)) 
            $display("AND is correct");
        else
            $display("AND is not correct");
        // case(6) OR
        ALU_FUN_tb = 4'b0101;
        #10
        if ((ALU_OUT_tb == 16'b1010) && (~Arith_Flag_tb) && (Logic_Flag_tb) && (~CMP_Flag_tb) && (~Shift_Flag_tb)) 
            $display("OR is correct");
        else
            $display("OR is not correct");
        // case(7) NAND
        ALU_FUN_tb = 4'b0110;
        #10                    
        if ((ALU_OUT_tb == 16'hFFFD) && (~Arith_Flag_tb) && (Logic_Flag_tb) && (~CMP_Flag_tb) && (~Shift_Flag_tb)) 
            $display("NAND is correct");
        else
            $display("NAND is not correct");
        // case#10) NOR
        ALU_FUN_tb = 4'b0111;
        #10
        if ((ALU_OUT_tb == 16'hFFF5) && (~Arith_Flag_tb) && (Logic_Flag_tb) && (~CMP_Flag_tb) && (~Shift_Flag_tb)) 
            $display("NOR is correct");
        else
            $display("NOR is not correct");
        // case(9) XOR
        ALU_FUN_tb = 4'b1000;
        #10
        if ((ALU_OUT_tb == 16'b1000) && (~Arith_Flag_tb) && (Logic_Flag_tb) && (~CMP_Flag_tb) && (~Shift_Flag_tb)) 
            $display("XOR is correct");
        else
            $display("XOR is not correct");
        // case(10) XNOR
        ALU_FUN_tb = 4'b1001;
        #10
        if ((ALU_OUT_tb == 16'hFFF7) && (~Arith_Flag_tb) && (Logic_Flag_tb) && (~CMP_Flag_tb) && (~Shift_Flag_tb)) 
            $display("XNOR is correct");
        else
            $display("XNOR is not correct");
        // case(11) equality
        ALU_FUN_tb = 4'b1010;
        #10
        if ((ALU_OUT_tb == 16'b0) && (~Arith_Flag_tb) && (~Logic_Flag_tb) && (CMP_Flag_tb) && (~Shift_Flag_tb)) 
            $display("equality check is correct");
        else
            $display("equality check is not correct");
        // case(12) greater then
        ALU_FUN_tb = 4'b1011;
        #10
        if ((ALU_OUT_tb == 16'd2) && (~Arith_Flag_tb) && (~Logic_Flag_tb) && (CMP_Flag_tb) && (~Shift_Flag_tb)) 
            $display("greater then check is correct");
        else
            $display("greater then check is not correct");
        // case(13) less than
        ALU_FUN_tb = 4'b1100;
        #10
        if ((ALU_OUT_tb == 16'b0) && (~Arith_Flag_tb) && (~Logic_Flag_tb) && (CMP_Flag_tb) && (~Shift_Flag_tb)) 
            $display("less then check is correct");
        else
            $display("less then check is not correct");
        // case(14) shift right
        ALU_FUN_tb = 4'b1101;
        #10
        if ((ALU_OUT_tb == 16'b0101) && (~Arith_Flag_tb) && (~Logic_Flag_tb) && (~CMP_Flag_tb) && (Shift_Flag_tb)) 
            $display("shift right check is correct");
        else
            $display("shift right check is not correct");
        // case(15) shift left
        ALU_FUN_tb = 4'b1110;
        #10
        if ((ALU_OUT_tb == 16'h0014) && (~Arith_Flag_tb) && (~Logic_Flag_tb) && (~CMP_Flag_tb) && (Shift_Flag_tb)) 
            $display("shift left check is correct");
        else
            $display("shift left check is not correct");
        // case(16) NOP
        ALU_FUN_tb = 4'b1111;
        #10
        if ((ALU_OUT_tb == 16'b0) && (~Arith_Flag_tb) && (~Logic_Flag_tb) && (~CMP_Flag_tb) && (~Shift_Flag_tb)) 
            $display("NOP check is correct");
        else
            $display("NOP check is not correct");
        #10 $stop;
    end
endmodule