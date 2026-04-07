module spad_bank
    import params_pkg::*;
(
    input wire logic clk,
    input wire logic [W_SPAD_BANK_ADDR-1:Z_ADDR] addr_i,
    input wire logic [XLEN-1:0] wdata_i,
    input wire logic [ADDR_ALIGN-1:0] wen_i,
    output logic [XLEN-1:0] rdata_o
);

    (* ram_style = "block" *)
    logic [XLEN-1:0] mem_r [SPAD_BANK_DEPTH-1:0];

    logic [XLEN-1:0] rdata_r;

    always_ff @(posedge clk) begin
        for (int i = 0; i < ADDR_ALIGN; i++) begin
            if (wen_i[i]) begin
                mem_r[addr_i][i*8 +: 8] <= wdata_i[i*8 +: 8];
            end
        end
        rdata_r <= mem_r[addr_i];
    end

    assign rdata_o = rdata_r;

endmodule