`timescale 1ns/1ps

module dual_port_mem_tb;

    parameter AW = 8;
    parameter DW = 8;

    // Testbench signals
    reg clk;
    reg wr_en;
    reg rd_en;
    reg [AW-1:0] wr_addr;
    reg [AW-1:0] rd_addr;
    reg [DW-1:0] wr_data;
    wire [DW-1:0] rd_data;

    // Instantiate DUT
    dual_port_mem #(AW, DW) uut (
        .clk(clk),
        .wr_en(wr_en),
        .wr_addr(wr_addr),
        .wr_data(wr_data),
        .rd_en(rd_en),
        .rd_addr(rd_addr),
        .rd_data(rd_data)
    );

    // Clock generation (10 ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        wr_en   = 0;
        rd_en   = 0;
        wr_addr = 0;
        rd_addr = 0;
        wr_data = 0;

        // -------------------------
        // Write data
        // -------------------------
        wr_en   = 1;

        wr_addr = 8'h00;
        wr_data = 8'hAA;
        #10;

        wr_addr = 8'h01;
        wr_data = 8'h55;
        #10;

        wr_addr = 8'h10;
        wr_data = 8'hF0;
        #10;

        wr_addr = 8'h20;
        wr_data = 8'h3C;
        #10;

        wr_en = 0;

        // -------------------------
        // Read data
        // -------------------------
        rd_en = 1;

        rd_addr = 8'h00;
        #10;

        rd_addr = 8'h01;
        #10;

        rd_addr = 8'h10;
        #10;

        rd_addr = 8'h20;
        #10;

        rd_en = 0;

        $finish;
    end

    // Display signals
    initial begin
        $monitor("Time=%0t wr_en=%b rd_en=%b wr_addr=%h wr_data=%h rd_addr=%h rd_data=%h",
                 $time, wr_en, rd_en, wr_addr, wr_data, rd_addr, rd_data);
    end

endmodule
