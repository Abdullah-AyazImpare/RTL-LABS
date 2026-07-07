// Lab 3-4: Count ones in an 8-bit vector
module count_ones (VAL, RESET, CLK, Num, pos);
    input  [7:0] VAL;
    input  RESET, CLK;
    output reg [3:0] Num;
    output reg [2:0] pos;

    always @ (posedge CLK or posedge RESET) begin
        if (RESET) begin
            Num <= 4'b0;
            pos <= 3'b0;
        end else begin
            // Population count
            Num <= VAL[0] + VAL[1] + VAL[2] + VAL[3] +
                   VAL[4] + VAL[5] + VAL[6] + VAL[7];
                              
            casez (VAL)
                8'b???????1: pos <= 3'd0;
                8'b??????10: pos <= 3'd1;
                8'b?????100: pos <= 3'd2;
                8'b????1000: pos <= 3'd3;
                8'b???10000: pos <= 3'd4;
                8'b??100000: pos <= 3'd5;
                8'b?1000000: pos <= 3'd6;
                8'b10000000: pos <= 3'd7;
                default:     pos <= 3'd0;
            endcase
        end
    end

endmodule
