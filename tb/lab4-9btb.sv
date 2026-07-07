`timescale 1ns/1ps

module uart_tx_tb;

    // Testbench signals
    reg clk;
    reg reset;
    reg load_valid;
    reg [7:0] data_in;

    wire serial_out;
    wire busy;

    // Instantiate DUT
    uart_tx uut (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .load_valid(load_valid),
        .serial_out(serial_out),
        .busy(busy)
    );

    // Clock generation (10 ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Reset
        reset = 1;
        load_valid = 0;
        data_in = 8'h00;
        #10;

        reset = 0;

        // -------------------------
        // Transmit first byte
        // -------------------------
        data_in = 8'b10110010;
        load_valid = 1;
        #10;
        load_valid = 0;

        // Wait until transmission completes
        #80;

        // -------------------------
        // Transmit second byte
        // -------------------------
        data_in = 8'b01011100;
        load_valid = 1;
        #10;
        load_valid = 0;

        // Wait until transmission completes
        #80;

        $finish;
    end

    // Display signals
    initial begin
        $monitor("Time=%0t load_valid=%b busy=%b serial_out=%b data_in=%b",
                 $time, load_valid, busy, serial_out, data_in);
    end

endmodule