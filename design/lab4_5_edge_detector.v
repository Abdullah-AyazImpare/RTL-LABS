// Lab 4-5: Edge Detector
// Counts positive edges of insig when p_edge is asserted, negative edges
// when n_edge is asserted, and both when both are asserted.
`timescale 1ns/1ps
module edge_detect (insig, p_edge, n_edge, clk, reset, count);
    input  insig, p_edge, n_edge, clk, reset;
    output reg [7:0] count;

    reg insig_d;

    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            count   <= 8'b0;
            insig_d <= 1'b0;
        end else begin
            insig_d <= insig;

            if (p_edge && !insig_d && insig)
                count <= count + 8'd1;      // positive edge
            if (n_edge && insig_d && !insig)
                count <= count + 8'd1;      // negative edge
        end
    end

endmodule
