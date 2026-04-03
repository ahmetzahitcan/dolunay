// =============================================================================
// proto_top.sv — Top-level: instruction ROM + pipeline
// =============================================================================
// `default_nettype none

module proto_top
    import proto_pkg::*;
#(
    parameter int ROM_DEPTH = 256
) (
    input wire wire logic clk,
    input wire wire logic rst_n
);

    // =========================================================================
    //  ROM ↔ Pipeline wires
    // =========================================================================

    logic                    rom_read_en_w;
    logic [PC_WIDTH-1:0]     rom_addr_w;
    logic [31:0]             rom_instr_w;

    // ROM has a 1-cycle latency: delay rom_read_en and active_mask by one clock
    // to generate rom_done and the mask that aligns with the instruction output.
    logic                    rom_done_w;
    logic                    rom_read_en_d1_r;
    logic [N_THREADS-1:0]  active_mask_w;
    logic [N_THREADS-1:0]  active_mask_d1_r;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            rom_read_en_d1_r <= 1'b0;
            active_mask_d1_r <= '0;
        end else begin
            rom_read_en_d1_r <= rom_read_en_w;
            if (rom_read_en_w) active_mask_d1_r <= active_mask_w;
        end
    end
    assign rom_done_w = rom_read_en_d1_r;

    // =========================================================================
    //  Module instances
    // =========================================================================

    instr_rom #(
        .DEPTH (ROM_DEPTH)
    ) u_rom (
        .clk       (clk),
        .read_en_i (rom_read_en_w),
        .addr_i    (rom_addr_w),
        .instr_o   (rom_instr_w)
    );

    pipeline u_pipeline (
        .clk              (clk),
        .rst_n            (rst_n),
        .rom_read_en_o    (rom_read_en_w),
        .rom_addr_o       (rom_addr_w),
        .active_mask_o    (active_mask_w),
        .rom_instr_i      (rom_instr_w),
        .rom_done_i       (rom_done_w),
        .rom_active_mask_i(active_mask_d1_r)
    );

endmodule

// `default_nettype wire
