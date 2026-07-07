// Lab 4-9: UART controller interface to a memory
// Sub-block: model for a 2-port memory (one read port, one write port).

module dual_port_mem #(parameter AW = 8, DW = 8) (
    clk,
    wr_en, wr_addr, wr_data,
    rd_en, rd_addr, rd_data
);
    input clk;
    input wr_en;
    input  [AW-1:0] wr_addr;
    input  [DW-1:0] wr_data;
    input rd_en;
    input  [AW-1:0] rd_addr;
    output reg [DW-1:0] rd_data;

    reg [DW-1:0] mem [0:(1<<AW)-1];

    always @ (posedge clk) begin
        if (wr_en)
            mem[wr_addr] <= wr_data;
        if (rd_en)
            rd_data <= mem[rd_addr];
    end

endmodule
