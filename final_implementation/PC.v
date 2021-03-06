`timescale 1ns / 1ps

module PC(input clk,input en,input [1:0] pcsel,input [63:0] branch,immed,output reg [63:0] pc,output reg [63:0] pc_4);
    reg psel = 0;
    reg t1,t2,t3,t4,t5 = 0;
    reg [63:0] i,pc2;
    initial begin
        pc = -4;
    end
    always@(posedge clk ) begin
        case(pcsel)
            2'b01:begin
                if(branch[0] == 1) pc2 = pc + immed;
                else pc2 = pc + 4;
                t1 = 1;
                t2 = 0;
                t3 = 0;
                t4 = 0;
                t5 = 0;
            end
            2'b10:begin
                pc2 = branch & -2;   //JALR
                t1 = 0;
                t2 = 1;
                t3 = 0;
                t4 = 0;
                t5 = 0;
            end
            2'b11:begin
                pc2 = pc + branch;   //JAL
                t1 = 0;
                t2 = 0;
                t3 = 1;
                t4 = 0;
                t5 = 0;
            end
            default:begin
                pc2 = pc + 4;
                t1 = 0;
                t2 = 0;
                t3 = 0;
                t4 = 1;
                t5 = 0;
            end
        endcase
        if (en)
            pc = pc2;
            pc_4 = pc + 4;
            t5 = 1;
    end
endmodule