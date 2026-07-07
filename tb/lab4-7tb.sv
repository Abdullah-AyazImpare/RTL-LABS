`timescale 1ns/1ps

module regfile_tb;

    // Testbench signals
    reg  [7:0] d_in;
    reg  [3:0] addr_in;
    reg        r_w;
    reg        clk;
    wire [7:0] d_out;

    // Instantiate the DUT
    regfile uut (
        .d_out(d_out),
        .d_in(d_in),
        .addr_in(addr_in),
        .r_w(r_w),
        .clk(clk)
    );

    // Clock generation (10 ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // -------------------------
        // Write operations
        // -------------------------
        r_w = 1;                  // Write mode

        addr_in = 4'd0;
        d_in    = 8'hAA;
        #10;

        addr_in = 4'd1;
        d_in    = 8'h55;
        #10;

        addr_in = 4'd5;
        d_in    = 8'hF0;
        #10;

        addr_in = 4'd10;
        d_in    = 8'h3C;
        #10;

        // -------------------------
        // Read operations
        // -------------------------
        r_w = 0;                  // Read mode

        addr_in = 4'd0;
        #10;

        addr_in = 4'd1;
        #10;

        addr_in = 4'd5;
        #10;

        addr_in = 4'd10;
        #10;

        $finish;
    end

    // Display signals
    initial begin
        $monitor("Time=%0t r_w=%b addr=%d d_in=%h d_out=%h",
                 $time, r_w, addr_in, d_in, d_out);
    end

endmodule