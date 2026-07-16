`timescale 1ns/1ps

module counter_8bit_tb;

    reg        clk;
    reg  [1:0] c;
    reg  [7:0] din;
    wire [7:0] dout;

    // Instantiate DUT
    counter_8bit dut (
        .clk  (clk),
        .c    (c),
        .din  (din),
        .dout (dout)
    );

    // Clock generation: 10 ns period
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Initialize inputs
        c   = 2'b11;   // Clear counter
        din = 8'd0;

        @(posedge clk);

        // Load operation
        c   = 2'b00;
        din = 8'd25;
        @(posedge clk);

        if (dout !== 8'd25)
            $display("ERROR: Load failed. Expected=25, Got=%0d", dout);
        else
            $display("PASS: Load successful");

        // Increment operation
        c = 2'b01;
        repeat (3) @(posedge clk);

        if (dout !== 8'd28)
            $display("ERROR: Increment failed. Expected=28, Got=%0d", dout);
        else
            $display("PASS: Increment successful");

        // Decrement operation
        c = 2'b10;
        repeat (2) @(posedge clk);

        if (dout !== 8'd26)
            $display("ERROR: Decrement failed. Expected=26, Got=%0d", dout);
        else
            $display("PASS: Decrement successful");

        // Clear operation
        c = 2'b11;
        @(posedge clk);

        if (dout !== 8'd0)
            $display("ERROR: Clear failed. Expected=0, Got=%0d", dout);
        else
            $display("PASS: Clear successful");

        #10;
        $display("Simulation completed.");
        $finish;
    end

    initial begin
        $monitor("Time=%0t clk=%b c=%b din=%0d dout=%0d",
                 $time, clk, c, din, dout);
    end

endmodule
