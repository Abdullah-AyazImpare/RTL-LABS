// Lab 4-6: Sequence Detector


module seq_detect (in_wire, out, clk, reset);
    input  in_wire, clk, reset;
    output reg out;

    localparam S0   = 3'd0, // idle / waiting for first 0
               S_0  = 3'd1, // seen "0"
               S_01 = 3'd2, // seen "01"
               S_011= 3'd3, // seen "011" (candidate for 0110)
               S_010= 3'd4; // seen "010" (candidate for 0101)

    reg [2:0] state;

    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            state <= S0;
            out   <= 1'b0;
        end else begin
            out <= 1'b0; // default, one-cycle pulse only on match
            case (state)
                S0:    state <= in_wire ? S0   : S_0;
                S_0:   state <= in_wire ? S_01 : S_0;
                S_01:  state <= in_wire ? S_011: S_010;
                S_011: begin
                    if (!in_wire) begin
                        out   <= 1'b1;   // matched 0110
                        state <= S0;
                    end else begin
                        state <= S0;     // "0111" - no match, restart
                    end
                end
                S_010: begin
                    if (in_wire) begin
                        out   <= 1'b1;   // matched 0101
                        state <= S0;
                    end else begin
                        state <= S_0;    // "0100" - last bit '0', restart from seen-0
                    end
                end
                default: state <= S0;
            endcase
        end
    end

endmodule
