// LAB 4-8: FIFO
`timescale 1ns/1ps

module fifo (d_in, in_valid, d_out, d_out_req, clk, full, empty, reset);
    input  [7:0] d_in;
    output reg [7:0] d_out;
    input  d_out_req, clk;
    output full, empty;
    input  in_valid;
    input  reset;

    reg [7:0] mem [0:127];
    reg [6:0] wptr, rptr;
    reg [7:0] cnt;

    assign full  = (cnt == 8'd128);
    assign empty = (cnt == 8'd0);

    wire do_write = in_valid   && !full;
    wire do_read  = d_out_req  && !empty;

    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            wptr <= 7'b0;
            rptr <= 7'b0;
            cnt  <= 8'b0;
        end else begin
            if (do_write) begin
                mem[wptr] <= d_in;
                wptr <= wptr + 7'd1;
            end
            if (do_read) begin
                d_out <= mem[rptr];
                rptr <= rptr + 7'd1;
            end

            case ({do_write, do_read})
                2'b10:   cnt <= cnt + 8'd1;
                2'b01:   cnt <= cnt - 8'd1;
                default: cnt <= cnt; 
            endcase
        end
    end

endmodule
