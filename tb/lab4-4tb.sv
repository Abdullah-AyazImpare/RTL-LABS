`timescale 1ns/1ps

module serial_tb;

    // Testbench signals
    reg  [7:0] byte_in;
    reg        clk, reset;
    wire       bit_out;

    // Instantiate the DUT
    serial uut (
        .bit_out(bit_out),
        .byte_in(byte_in),
        .clk(clk),
        .reset(reset)
    );

    // Clock generation (10 ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Apply test vectors
    initial begin
        // Reset
        reset = 1;
        byte_in = 8'h00;
        #10;
        reset = 0;

        // First byte: 10110010
        byte_in = 8'b10110010;
        #80;               // Wait 8 clock cycles

        // Second byte: 01011100
        byte_in = 8'b01011100;
        #80;               // Wait another 8 clock cycles

        $finish;
    end

    // Display output
    initial begin
        $monitor("Time=%0t  byte_in=%b  bit_out=%b",
                  $time, byte_in, bit_out);
    end

endmodule