`default_nettype none

module wram_bank
    import params_pkg::*;
(
    input wire logic clk,
    input wire logic [W_WRAM_BANK_ADDR:Z_ADDR] addr_i,
    input wire logic [XLEN-1:0] w_data_i,
    input wire logic [ADDR_ALIGN-1:0] wen_i,
    output logic [XLEN-1:0] r_data_o
);

    (* ram_style = "block" *)
    logic [XLEN-1:0] mem [WRAM_BANK_DEPTH-1:0];

    logic [XLEN-1:0] r_data_r;

    always_ff @( posedge clk ) begin
        r_data_r <= mem[addr_i];
        for (int i = 0; i < ADDR_ALIGN; i++) begin
            if (wen_i[i]) begin
                mem[addr_i][i*8 +: 8] <= w_data_i[i*8 +: 8];
            end
        end
    end

    assign r_data_o = r_data_r;

endmodule

`default_nettype wire