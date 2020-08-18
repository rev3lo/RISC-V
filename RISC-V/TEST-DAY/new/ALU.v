`timescale 1ns / 1ps
module ALU(input [63:0] A, B,input [3:0] op,output reg [63:0] result);  

//  ADD : 0000
//  SUB : 0001
//  AND : 0010
//  OR  : 0011
//  XOR : 0100
//  SLL : 0101
//  SRL : 0110
//  SRA : 0111
//  BEQ : 1000
//  BNE : 1001
//  BLT : 1010
//  BGE : 1011
    always@(*) begin
        case(op)
            4'b0000 : result <= A + B;
            4'b0001 : result <= A - B;    
            4'b0010 : result <= A & B;
            4'b0011 : result <= A | B;
            4'b0100 : result <= A ^ B; 
            4'b0101 : result <= A << B;
            4'b0110 : result <= A >> B;
            4'b0111 : result <= $signed(A) >>> B;  
            4'b1000 : result <= (A==B) ? 1 : 0;
            4'b1001 : result <= (A!=B) ? 1 : 0;
            4'b1010 : result <= (A<B) ? 1 : 0;
            4'b1011 : result <= (A>=B) ? 1 : 0;
            
        endcase
    end
endmodule