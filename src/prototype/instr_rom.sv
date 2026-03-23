// =============================================================================
// instr_rom.sv — Synchronous instruction ROM
// =============================================================================
// `default_nettype none

module instr_rom #(
    parameter int ADDR_WIDTH = 32,
    parameter int DATA_WIDTH = 32,
    parameter int DEPTH      = 256,
    parameter     INIT_FILE  = "program.hex"
) (
    input  logic clk,

    input  logic                    read_en_i,
    input  logic [ADDR_WIDTH-1:0]   addr_i,
    output logic [DATA_WIDTH-1:0]   instr_o
);

    // -------------------------------------------------------------------------
    // Memory
    // -------------------------------------------------------------------------
    logic [DATA_WIDTH-1:0] mem_r [0:DEPTH-1];

    initial begin
        $readmemh(INIT_FILE, mem_r);
    end

    // -------------------------------------------------------------------------
    // Synchronous read
    // -------------------------------------------------------------------------
    logic [DATA_WIDTH-1:0] data_r;
    assign instr_o = data_r;

    always_ff @(posedge clk) begin
        if (read_en_i) begin
            data_r <= mem_r[addr_i[$clog2(DEPTH)+1:2]]; // word-aligned
        end
    end

endmodule

// `default_nettype wire
