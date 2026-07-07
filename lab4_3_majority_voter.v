// Lab 4-3: Serial Input Majority Voter


module majority_counter (in, clk, out);
    input  in, clk;
    output reg out;

    reg s0, s1, s2;
    always @ (posedge clk) begin
        s2 <= s1;
        s1 <= s0;
        s0 <= in;

        out <= (s0 + s1 + s2) >= 2'd2;
    end

endmodule
