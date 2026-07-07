`timescale 1ns/1ps

module shifter8_tb;

reg clk;
reg load;
reg shl;
reg shr;
reg [7:0] data_in;

wire [7:0] data_out;

// DUT
shifter8 uut (
    .clk(clk),
    .load(load),
    .shl(shl),
    .shr(shr),
    .data_in(data_in),
    .data_out(data_out)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin

    load = 0;
    shl  = 0;
    shr  = 0;
    data_in = 8'h00;

    // Load 10110011
    #10;
    load = 1;
    data_in = 8'b10110011;

    #10;
    load = 0;

    // Shift left twice
    shl = 1;
    #10;
    #10;
    shl = 0;

    // Shift right three times
    shr = 1;
    #10;
    #10;
    #10;
    shr = 0;

    // Load another value
    load = 1;
    data_in = 8'b01010101;

    #10;
    load = 0;

    // Shift left once
    shl = 1;
    #10;
    shl = 0;

    #20;
    $finish;

end

initial begin
    $monitor("Time=%0t Load=%b SHL=%b SHR=%b DataIn=%b DataOut=%b",
              $time, load, shl, shr, data_in, data_out);
end

endmodule