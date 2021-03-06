`timescale 1ns / 1ps

module tb();
    reg clk = 1;
    wire [31:0] IF;
    wire [3:0] DEC; 
    wire [63:0] EXE;
    wire [4:0] WB;
    
    initial begin
        forever #50 clk = ~clk;
    end
    main DUT( .clk(clk),.inst(IF),.func(DEC),.res(EXE),.wa(WB) );    
endmodule