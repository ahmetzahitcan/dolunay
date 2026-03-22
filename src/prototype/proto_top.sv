// =============================================================================
// proto_top.sv — Top-level: wires all prototype modules together
// =============================================================================
`default_nettype none

module proto_top
    import proto_pkg::*;
#(
    parameter ROM_INIT_FILE = "program.hex",
    parameter int ROM_DEPTH = 256
) (
    input logic clk,
    input logic rst_n
);

    // =========================================================================
    //  Internal wires
    // =========================================================================

    // Pipeline controller ↔ stages
    logic fetch_valid_w,     fetch_done_w;
    logic rom_read_en_w,     rom_done_w;
    logic decode_valid_w,    decode_done_w;
    logic execute_valid_w,   execute_done_w;
    logic writeback_valid_w, writeback_done_w;

    // Fetch → ROM
    logic [PC_WIDTH-1:0]    fetch_pc_w;
    logic [NUM_THREADS-1:0] active_mask_w;

    // ROM → Decode
    logic [31:0] rom_instr_w;

    // Decode → Execute
    decoded_instr_t              dec_decoded_w;
    logic [NUM_LANES-1:0][XLEN-1:0] dec_rs1_data_w;
    logic [NUM_LANES-1:0][XLEN-1:0] dec_rs2_data_w;

    // Execute → Writeback
    logic [NUM_LANES-1:0][XLEN-1:0] exe_result_w;
    decoded_instr_t                  exe_decoded_w;

    // Execute → Fetch (branch)
    logic              branch_taken_w;
    logic [PC_WIDTH-1:0] branch_target_w;

    // Regfile ↔ Decode / Writeback
    logic [REG_ADDR_WIDTH-1:0]        rf_rs1_addr_w;
    logic [REG_ADDR_WIDTH-1:0]        rf_rs2_addr_w;
    logic [NUM_LANES-1:0][XLEN-1:0]   rf_rs1_data_w;
    logic [NUM_LANES-1:0][XLEN-1:0]   rf_rs2_data_w;
    logic                              rf_write_en_w;
    logic [REG_ADDR_WIDTH-1:0]         rf_write_addr_w;
    logic [NUM_LANES-1:0][XLEN-1:0]    rf_write_data_w;

    // ROM done: 1-cycle latency → just delay rom_read_en by one clock
    logic rom_read_en_d1_r;
    always_ff @(posedge clk) begin
        if (!rst_n) rom_read_en_d1_r <= 1'b0;
        else        rom_read_en_d1_r <= rom_read_en_w;
    end
    assign rom_done_w = rom_read_en_d1_r;

    // =========================================================================
    //  Module instances
    // =========================================================================

    pipeline_controller u_ctrl (
        .clk               (clk),
        .rst_n             (rst_n),
        .fetch_done_i      (fetch_done_w),
        .rom_done_i        (rom_done_w),
        .decode_done_i     (decode_done_w),
        .execute_done_i    (execute_done_w),
        .writeback_done_i  (writeback_done_w),
        .fetch_valid_o     (fetch_valid_w),
        .rom_read_en_o     (rom_read_en_w),
        .decode_valid_o    (decode_valid_w),
        .execute_valid_o   (execute_valid_w),
        .writeback_valid_o (writeback_valid_w)
    );

    fetch u_fetch (
        .clk               (clk),
        .rst_n             (rst_n),
        .valid_i           (fetch_valid_w),
        .done_o            (fetch_done_w),
        .branch_taken_i    (branch_taken_w),
        .branch_target_i   (branch_target_w),
        .pc_o              (fetch_pc_w),
        .active_mask_o     (active_mask_w)
    );

    instr_rom #(
        .DEPTH     (ROM_DEPTH),
        .INIT_FILE (ROM_INIT_FILE)
    ) u_rom (
        .clk        (clk),
        .read_en_i  (rom_read_en_w),
        .addr_i     (fetch_pc_w),
        .instr_o    (rom_instr_w)
    );

    decode u_decode (
        .clk        (clk),
        .rst_n      (rst_n),
        .valid_i    (decode_valid_w),
        .done_o     (decode_done_w),
        .instr_i    (rom_instr_w),
        .rs1_addr_o (rf_rs1_addr_w),
        .rs2_addr_o (rf_rs2_addr_w),
        .rs1_data_i (rf_rs1_data_w),
        .rs2_data_i (rf_rs2_data_w),
        .decoded_o  (dec_decoded_w),
        .rs1_data_o (dec_rs1_data_w),
        .rs2_data_o (dec_rs2_data_w)
    );

    execute u_execute (
        .clk             (clk),
        .rst_n           (rst_n),
        .valid_i         (execute_valid_w),
        .done_o          (execute_done_w),
        .decoded_i       (dec_decoded_w),
        .rs1_data_i      (dec_rs1_data_w),
        .rs2_data_i      (dec_rs2_data_w),
        .result_o        (exe_result_w),
        .decoded_pass_o  (exe_decoded_w),
        .branch_taken_o  (branch_taken_w),
        .branch_target_o (branch_target_w)
    );

    writeback u_writeback (
        .clk              (clk),
        .rst_n            (rst_n),
        .valid_i          (writeback_valid_w),
        .done_o           (writeback_done_w),
        .decoded_i        (exe_decoded_w),
        .result_i         (exe_result_w),
        .reg_write_en_o   (rf_write_en_w),
        .reg_write_addr_o (rf_write_addr_w),
        .reg_write_data_o (rf_write_data_w)
    );

    regfile u_regfile (
        .clk          (clk),
        .rs1_addr_i   (rf_rs1_addr_w),
        .rs1_data_o   (rf_rs1_data_w),
        .rs2_addr_i   (rf_rs2_addr_w),
        .rs2_data_o   (rf_rs2_data_w),
        .write_en_i   (rf_write_en_w),
        .write_addr_i (rf_write_addr_w),
        .write_data_i (rf_write_data_w)
    );

endmodule

`default_nettype wire
