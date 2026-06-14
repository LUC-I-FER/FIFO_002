`timescale 1ns / 1ps

module tb_sync_fifo;

    parameter DATA_WIDTH = 32;
    parameter DEPTH      = 64;

    reg clk;
    reg rst;
    reg wr_en;
    reg rd_en;
    reg [DATA_WIDTH-1:0] din;

    wire [DATA_WIDTH-1:0] dout;
    wire full;
    wire empty;

    // DUT
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

    // 100 MHz clock
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // Initialize
        rst   = 1;
        wr_en = 0;
        rd_en = 0;
        din   = 0;

        // Reset
        #20;
        rst = 0;

        // ------------------------
        // Write 3 values
        // ------------------------
        @(posedge clk);
        wr_en = 1;
        din   = 32'h11111111;

        @(posedge clk);
        din = 32'h22222222;

        @(posedge clk);
        din = 32'h33333333;

        @(posedge clk);
        wr_en = 0;

        // Wait one cycle
        @(posedge clk);

        // ------------------------
        // Read 3 values
        // ------------------------
        rd_en = 1;

        @(posedge clk);   // Expect 0x11111111
        @(posedge clk);   // Expect 0x22222222
        @(posedge clk);   // Expect 0x33333333

        rd_en = 0;

        // Wait a few cycles
        repeat (3) @(posedge clk);

        $finish;
    end

endmodule