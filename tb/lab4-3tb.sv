`timescale 1ns/1ps

module majority_counter_tb;

    // Testbench signals
    reg in, clk;
    wire out;

    // Instantiate the DUT
    majority_counter uut (
        .in(in),
        .clk(clk),
        .out(out)
    );

    // Clock generation (10 ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Apply serial input sequence
    initial begin
        in = 0; #10;   // Sample 0
        in = 1; #10;   // Sample 1
        in = 1; #10;   // Sample 1
        in = 0; #10;   // Sample 0
        in = 1; #10;   // Sample 1
        in = 0; #10;   // Sample 0
        in = 0; #10;   // Sample 0
        in = 1; #10;   // Sample 1

        $finish;
    end

    // Display results
    initial begin
        $monitor("Time=%0t  in=%b  out=%b",
                 $time, in, out);
    end

endmodule