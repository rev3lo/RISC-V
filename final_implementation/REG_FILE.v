`timescale 1ns / 1ps

module REG_FILE(input clk,input [4:0] RA1, RA2, WA,input [63:0] WD,input W_EN,output [63:0] RD1,RD2);
    
    reg [63:0] reg_array [31:0];
    integer file,i;
    reg en = 1;
    initial begin
        file = $fopen("C:\\Users\\student\\Desktop\\111801001\\RISC-V\\RF.txt","r");
        for(i=0;i<32;i=i+1)
            $fscanf(file,"%b\n",reg_array[i]);
        $fclose(file);
        en = 1;
    end
    assign RD1 = reg_array[RA1];
    assign RD2 = reg_array[RA2];
            
    always@(posedge clk) begin
        if(W_EN==1 && en == 1) begin
            if(WA == 5'b0)
                reg_array[WA] = 64'b0;
            else
                reg_array[WA] = WD;
            file = $fopen("C:\\Users\\student\\Desktop\\111801001\\RISC-V\\RF.txt","w");
            for(i=0;i<32;i=i+1)
                $fwrite(file,"%b\n",reg_array[i]);
            $fclose(file);
            en = 0;
        end
        else
            en = 1;
    end
    
endmodule