`timescale 1ns/1ps

module seq_detect_tb;

    // Testbench signals
    reg in_wire, clk, reset;
    wire out;

    // Instantiate the DUT
    seq_detect uut (
        .in_wire(in_wire),
        .out(out),
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
        in_wire = 0;
        #10;
        reset = 0;

        // Sequence: 0110 (should detect)
        in_wire = 0; #10;
        in_wire = 1; #10;
        in_wire = 1; #10;
        in_wire = 0; #10;

        // Sequence: 0101 (should detect)
        in_wire = 0; #10;
        in_wire = 1; #10;
        in_wire = 0; #10;
        in_wire = 1; #10;

        // Sequence: 0111 (no detection)
        in_wire = 0; #10;
        in_wire = 1; #10;
        in_wire = 1; #10;
        in_wire = 1; #10;

        // Sequence: 0100 (no detection)
        in_wire = 0; #10;
        in_wire = 1; #10;
        in_wire = 0; #10;
        in_wire = 0; #10;

        // Sequence: 0110 (detect again)
        in_wire = 0; #10;
        in_wire = 1; #10;
        in_wire = 1; #10;
        in_wire = 0; #10;

        $finish;
    end

    // Display signals
    initial begin
        $monitor("Time=%0t  in_wire=%b  out=%b",
                 $time, in_wire, out);
    end

endmodule