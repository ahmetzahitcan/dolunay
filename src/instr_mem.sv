`default_nettype none

module instr_mem 
    import params_pkg::*;
#(
    parameter int DEPTH      = 256
) (
    input wire  logic clk,
    input wire  logic [XLEN-1:Z_PC]   addr_i,
    output logic [31:2]   undec_instr32_o
);

    // -------------------------------------------------------------------------
    // Memory
    // -------------------------------------------------------------------------
    logic [31:0] mem_r [0:DEPTH-1];

    initial begin
        $readmemh("irom.mem", mem_r);
    end

    // -------------------------------------------------------------------------
    // Synchronous read
    // -------------------------------------------------------------------------
    logic [31:2] data_r;
    assign undec_instr32_o = data_r;

    always_ff @(posedge clk) begin
        data_r <= mem_r[addr_i][31:2];
    end

endmodule

`default_nettype wire