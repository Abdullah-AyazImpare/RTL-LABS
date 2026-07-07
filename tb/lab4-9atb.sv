`timescale 1ns/1ps

module uart_rx_tb;

    // Testbench signals
    reg clk;
    reg reset;
    reg serial_in;

    wire [7:0] data_out;
    wire data_valid;

    // Instantiate DUT
    uart_rx uut (
        .clk(clk),
        .reset(reset),
        .serial_in(serial_in),
        .data_out(data_out),
        .data_valid(data_valid)
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
        serial_in = 0;
        #10;
        reset = 0;

        // Send byte: 8'b10110010 (MSB first)
        serial_in = 1; #10;
        serial_in = 0; #10;
        serial_in = 1; #10;
        serial_in = 1; #10;
        serial_in = 0; #10;
        serial_in = 0; #10;
        serial_in = 1; #10;
        serial_in = 0; #10;

        // Send byte: 8'b01011100
        serial_in = 0; #10;
        serial_in = 1; #10;
        serial_in = 0; #10;
        serial_in = 1; #10;
        serial_in = 1; #10;
        serial_in = 1; #10;
        serial_in = 0; #10;
        serial_in = 0; #10;

        $finish;
    end

    // Display results
    initial begin
        $monitor("Time=%0t serial_in=%b data_out=%b data_valid=%b",
                 $time, serial_in, data_out, data_valid);
    end

endmodule