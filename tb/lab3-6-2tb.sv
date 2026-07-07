`timescale 1ns/1ps

module parity_gen_tb;

    // Testbench signals
    reg         clk;
    reg  [31:0] din;
    wire [35:0] dout;

    // Instantiate the DUT
    parity_gen uut (
        .clk(clk),
        .din(din),
        .dout(dout)
    );

    // Clock generation (10 ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Apply test vectors
    initial begin
        din = 32'h00000000; #10;   // All bytes have even parity
        din = 32'hFFFFFFFF; #10;   // All bytes have even parity
        din = 32'h01020304; #10;
        din = 32'h12345678; #10;
        din = 32'hA5A5A5A5; #10;

        $finish;
    end

    // Display results
    initial begin
        $monitor("Time=%0t  din=%h  parity=%b%b%b%b  dout=%h",
                 $time, din,
                 dout[35], dout[34], dout[33], dout[32],
                 dout);
    end

endmodule