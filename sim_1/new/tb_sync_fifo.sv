`timescale 1ns / 1ps

module tb_sync_fifo;

    parameter DATA_WIDTH = 32;
    parameter DEPTH = 64;
    
    reg clk;
    reg rst;
    reg wr_en;
    reg rd_en;
    reg [DATA_WIDTH - 1:0] din;
    
    wire [DATA_WIDTH - 1:0] dout;
    wire full;
    wire empty;
    
    sync_fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .DEPTH(DEPTH)
    ) dut (
         .clk(clk),
         .rst(rst),
         .wr_en(wr_en),
         .rd_en(rd_en),
         .din(din),
         .dout(dout),
         .full(full),
         .empty(empty)
    );
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        rst = 1;
        wr_en = 0;
        rd_en = 0;
        din =  0;
        
        #20;
        rst = 0;
        
         #10;
         wr_en = 1;
         din = 32'h11111111;
     
         #10;
         din = 32'h22222222;
     
         #10;
         din = 32'h33333333;
     
         #10;
         wr_en = 0;
     
         #50;
         $finish;
    end

endmodule
