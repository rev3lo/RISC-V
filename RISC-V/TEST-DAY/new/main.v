`timescale 1ns / 1ps
module main(input clk,output [31:0] inst,output [3:0] func,output [63:0] res,output reg [4:0] wa);
    wire [63:0] A,B,immed,mem_out,pc_out,pc4;
    wire [4:0] rs1,rs2,rd; 
    wire en,imm,mwr,out,ty;
    wire [1:0] wdsel,pcsel;
    reg [1:0] w1,w2;   
    reg [31:0] fetch;
    reg [63:0] val1,val2,out_val,to_mem,b1,b2,pc1,pc,pcx;
    reg [4:0] w_addr,wa2;
    reg [3:0] op;
    reg w_en,w_en2,w_en1,m1,m2,typ1,typ2;
    reg enable_IM=0;
    integer i=-1;
    always@(posedge clk) begin
        i=i+1;
        if(i%5==0)  enable_IM = 1;
        if(i%5==1)  enable_IM = 0;
    end    
    always@(posedge clk) begin
        fetch <= inst;
        op <= func;
        w_addr <= rd;
        wa2 <= w_addr;
        wa<=wa2;
        val1 <= A;
        val2 <= (imm==0)?B:immed;
        b1<=B;
        b2<=b1;
        w1<=wdsel;
        w2<=w1;
        to_mem <= res;
        pc1 <= pc4;
        pcx<=pc1;
        pc <= pcx;
        out_val <= (w2==2'b01)? mem_out : ( (w2==2'b0)?to_mem : ( (w2==2'b10)?pc:-1 ) );        
        w_en2 <= en;
        w_en1 <= w_en2;
        w_en <=w_en1;
        m1<=mwr;
        m2<=m1;
        typ1<=ty;
        typ2<=typ1;
    end
    PC PC(.clk(clk),.en(enable_IM),.pcsel(pcsel),.branch(res),.immed(immed),.pc(pc_out),.pc_4(pc4));
    IM mem(.pc(pc_out),.inst(inst));
    DECODER control(.inst(fetch),.rs1(rs1),.rs2(rs2),.rd(rd),.AluFunc(func),.bsel(imm),.immediate(immed),.wdsel(wdsel),.mwr(mwr),.werf(en),.pcsel(pcsel),.type(ty) );
    REG_FILE rf(.clk(clk),.RA1(rs1),.RA2(rs2),.WA(wa),.WD(out_val),.W_EN(en),.RD1(A),.RD2(B));
    ALU alu32(.A(val1),.B(val2),.op(op),.result(res));
    MEM data_memory(.clk(clk),.addr(to_mem),.W(b2),.mwr(m2),.out(mem_out),.type(typ2));
endmodule