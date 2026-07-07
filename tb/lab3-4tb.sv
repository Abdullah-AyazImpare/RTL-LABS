`timescale 1ns/1ps

module count_ones_tb;

    // Testbench signals
    reg  [7:0] VAL;
    reg  RESET, CLK;
    wire [3:0] Num;
    wire [2:0] pos;

    // Instantiate the DUT
    count_ones uut (
        .VAL(VAL),
        .RESET(RESET),
        .CLK(CLK),
        .Num(Num),
        .pos(pos)
    );

    // Clock generation (10 ns period)
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;
    end

    // Apply test vectors
    initial begin
        // Apply reset
        RESET = 1;
        VAL = 8'b00000000;
        #10;

        RESET = 0;

        // Test cases
        VAL = 8'b00000000; #10;   // Num=0, pos=0
        VAL = 8'b00000001; #10;   // Num=1, pos=0
        VAL = 8'b00000100; #10;   // Num=1, pos=2
        VAL = 8'b00101010; #10;   // Num=3, pos=1
        VAL = 8'b11111111; #10;   // Num=8, pos=0
        VAL = 8'b10000000; #10;   // Num=1, pos=7
        VAL = 8'b01010000; #10;   // Num=2, pos=4

        $finish;
    end

    // Display results
    initial begin
        $monitor("Time=%0t  VAL=%b  Num=%d  pos=%d",
                 $time, VAL, Num, pos);
    end

endmodule