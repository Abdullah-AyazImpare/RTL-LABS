`timescale 1ns/1ps

module counter_tb;

    // Testbench signals
    reg reset, clock, up_down;
    wire [7:0] count;

    // Instantiate the DUT
    counter uut (
        .reset(reset),
        .clock(clock),
        .up_down(up_down),
        .count(count)
    );

    // Clock generation (10 ns period)
    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    // Apply test vectors
    initial begin
        // Initialize
        reset = 1;
        up_down = 1;
        #10;

        // Release reset
        reset = 0;

        // Count Up
        up_down = 1;
        #50;

        // Count Down
        up_down = 0;
        #50;

        // Reset again
        reset = 1;
        #10;
        reset = 0;

        // Count Up again
        up_down = 1;
        #30;

        $finish;
    end

    // Display results
    initial begin
        $monitor("Time=%0t  reset=%b  up_down=%b  count=%d",
                  $time, reset, up_down, count);
    end

endmodule