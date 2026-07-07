`timescale 1ns/1ps

module mux8to1_ternary_tb;

reg d0, d1, d2, d3, d4, d5, d6, d7;
reg [2:0] sel;
wire out;

// Instantiate DUT
mux8to1_ternary uut (
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .d3(d3),
    .d4(d4),
    .d5(d5),
    .d6(d6),
    .d7(d7),
    .sel(sel),
    .out(out)
);

initial begin

    // Assign different values to inputs
    d0 = 0;
    d1 = 1;
    d2 = 0;
    d3 = 1;
    d4 = 1;
    d5 = 0;
    d6 = 1;
    d7 = 0;

    sel = 3'b000; #10;
    sel = 3'b001; #10;
    sel = 3'b010; #10;
    sel = 3'b011; #10;
    sel = 3'b100; #10;
    sel = 3'b101; #10;
    sel = 3'b110; #10;
    sel = 3'b111; #10;

    $finish;

end

initial begin
    $monitor("Time=%0t sel=%b out=%b",
             $time, sel, out);
end

endmodule