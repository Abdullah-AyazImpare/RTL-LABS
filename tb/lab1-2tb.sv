// Code your testbench here
// or browse Examples
`timescale 1ns/1ps

module lab12_tb;

    // Testbench signals
    reg         CLK;
    reg         RESET;
    reg         LOAD;
    reg         ADD;
    reg  [7:0]  DIN;

    wire [7:0]  CLKCNT;
    wire [7:0]  SUM;

    // Instantiate DUT
    lab12 dut (
        .CLK    (CLK),
        .RESET  (RESET),
        .LOAD   (LOAD),
        .ADD    (ADD),
        .DIN    (DIN),
        .CLKCNT (CLKCNT),
        .SUM    (SUM)
    );

    // Clock generation: 10 ns period
    initial begin
        CLK = 1'b0;
        forever #5 CLK = ~CLK;
    end

    // Stimulus
    initial begin

        // Initialize inputs
        RESET = 1'b0;
        LOAD  = 1'b0;
        ADD   = 1'b0;
        DIN   = 8'd0;

        // Apply reset
        #2;
        RESET = 1'b1;
        #10;
        RESET = 1'b0;

        // Verify reset values
        @(posedge CLK);
        if (CLKCNT !== 8'd0 || SUM !== 8'd0)
            $display("ERROR: Reset failed. CLKCNT=%0d SUM=%0d", CLKCNT, SUM);
        else
            $display("PASS: Reset successful");

        // Allow counter to increment for 3 clocks
        repeat (3) @(posedge CLK);

        if (CLKCNT !== 8'd3)
            $display("ERROR: Counter increment failed. Expected=3, Got=%0d", CLKCNT);
        else
            $display("PASS: Counter increment successful");

        // Test LOAD operation
        DIN  = 8'd20;
        LOAD = 1'b1;

        @(posedge CLK);

        LOAD = 1'b0;

        if (CLKCNT !== 8'd20)
            $display("ERROR: LOAD failed. Expected=20, Got=%0d", CLKCNT);
        else
            $display("PASS: LOAD successful");

        // Test ADD operation
        DIN = 8'd15;
        ADD = 1'b1;

        @(posedge CLK);

        ADD = 1'b0;

        if (SUM !== 8'd35)
            $display("ERROR: ADD failed. Expected=35, Got=%0d", SUM);
        else
            $display("PASS: ADD successful");

        // Verify counter resumes incrementing
        @(posedge CLK);

        if (CLKCNT !== 8'd21)
            $display("ERROR: Counter resume failed. Expected=21, Got=%0d", CLKCNT);
        else
            $display("PASS: Counter resumed successfully");

        #20;
        $display("Simulation completed.");
        $finish;

    end

    // Monitor signals
    initial begin
        $monitor("Time=%0t RESET=%b LOAD=%b ADD=%b DIN=%0d CLKCNT=%0d SUM=%0d",
                  $time, RESET, LOAD, ADD, DIN, CLKCNT, SUM);
    end

endmodule
