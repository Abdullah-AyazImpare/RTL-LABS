
`timescale 1ns/1ps

module counter8_set_clear_tb;

    reg clk, clear, set, en;
    wire [7:0] count;

    // Instantiate DUT
    counter8_set_clear uut (
        .clk(clk),
        .clear(clear),
        .set(set),
        .en(en),
        .count(count)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        clear = 0;
        set   = 0;
        en    = 0;

        // Clear counter
        clear = 1;
        #10 clear = 0;

        // Load 16
        set = 1;
        #10 set = 0;

        // Count down
        en = 1;
        #50;

        // Clear again
        en = 0;
        clear = 1;
        #10 clear = 0;

        // Load 16 again
        set = 1;
        #10 set = 0;

        // Count down again
        en = 1;
        #30;

        $finish;
    end

    // Display values
    initial begin
        $monitor("Time=%0t clk=%b clear=%b set=%b en=%b count=%d",
                  $time, clk, clear, set, en, count);
    end

endmodule