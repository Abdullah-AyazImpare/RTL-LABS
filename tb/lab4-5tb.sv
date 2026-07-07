`timescale 1ns/1ps

module edge_detect_tb;

    // Testbench signals
    reg insig, p_edge, n_edge, clk, reset;
    wire [7:0] count;

    // Instantiate the DUT
    edge_detect uut (
        .insig(insig),
        .p_edge(p_edge),
        .n_edge(n_edge),
        .clk(clk),
        .reset(reset),
        .count(count)
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
        insig = 0;
        p_edge = 0;
        n_edge = 0;
        #10;
        reset = 0;

        // Detect positive edges only
        p_edge = 1;
        n_edge = 0;

        #10 insig = 1;   // + edge
        #10 insig = 0;   // ignored
        #10 insig = 1;   // + edge
        #10 insig = 0;   // ignored

        // Detect negative edges only
        p_edge = 0;
        n_edge = 1;

        #10 insig = 1;   // ignored
        #10 insig = 0;   // - edge
        #10 insig = 1;   // ignored
        #10 insig = 0;   // - edge

        // Detect both edges
        p_edge = 1;
        n_edge = 1;

        #10 insig = 1;   // + edge
        #10 insig = 0;   // - edge
        #10 insig = 1;   // + edge
        #10 insig = 0;   // - edge

        $finish;
    end

    // Display results
    initial begin
        $monitor("Time=%0t insig=%b p_edge=%b n_edge=%b count=%d",
                 $time, insig, p_edge, n_edge, count);
    end

endmodule