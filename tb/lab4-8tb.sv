`timescale 1ns/1ps

module fifo_tb;

    // Testbench signals
    reg  [7:0] d_in;
    reg        in_valid;
    reg        d_out_req;
    reg        clk;
    reg        reset;

    wire [7:0] d_out;
    wire       full;
    wire       empty;

    // Instantiate DUT
    fifo uut (
        .d_in(d_in),
        .in_valid(in_valid),
        .d_out(d_out),
        .d_out_req(d_out_req),
        .clk(clk),
        .full(full),
        .empty(empty),
        .reset(reset)
    );

    // Clock generation (10 ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Reset FIFO
        reset = 1;
        in_valid = 0;
        d_out_req = 0;
        d_in = 8'h00;
        #10;

        reset = 0;

        // -------------------------
        // Write three bytes
        // -------------------------
        in_valid = 1;

        d_in = 8'h11; #10;
        d_in = 8'h22; #10;
        d_in = 8'h33; #10;

        in_valid = 0;

        // -------------------------
        // Read three bytes
        // -------------------------
        d_out_req = 1;
        #30;
        d_out_req = 0;

        // -------------------------
        // Simultaneous read/write
        // -------------------------
        in_valid  = 1;
        d_out_req = 1;
        d_in = 8'h44;
        #10;

        in_valid  = 0;
        d_out_req = 0;

        // Read the newly written value
        d_out_req = 1;
        #10;
        d_out_req = 0;

        $finish;
    end

    // Display signals
    initial begin
        $monitor("Time=%0t in_valid=%b d_out_req=%b d_in=%h d_out=%h full=%b empty=%b",
                 $time, in_valid, d_out_req, d_in, d_out, full, empty);
    end

endmodule