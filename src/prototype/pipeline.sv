// =============================================================================
// pipeline.sv — Pipeline: controller + all stages + regfile
// =============================================================================
// `default_nettype none

module pipeline
    import proto_pkg::*;
(
    input  wire logic                    clk,
    input  wire logic                    rst_n,

    // ROM interface (instr_rom lives in proto_top)
    output logic                         rom_read_en_o,
    output logic [PC_WIDTH-1:0]          rom_addr_o,
    output logic [NUM_THREADS-1:0]       active_mask_o,      // for proto_top delay logic
    input  wire  logic [31:0]            rom_instr_i,
    input  wire  logic                   rom_done_i,
    input  wire  logic [NUM_THREADS-1:0] rom_active_mask_i
);

    // =========================================================================
    //  Internal wires
    // =========================================================================

    // Pipeline controller ↔ stages
    logic fetch_valid_w,     fetch_done_w;
    logic decode_valid_w,    decode_done_w;
    logic execute_valid_w,   execute_done_w;
    logic memory_valid_w,    memory_done_w;
    logic writeback_valid_w, writeback_done_w;

    // Fetch outputs
    logic [PC_WIDTH-1:0]    fetch_pc_w;
    logic [NUM_THREADS-1:0] active_mask_w;

    // Decode → Execute
    decoded_instr_s                  dec_decoded_w;
    logic [PC_WIDTH-1:0]             dec_pc_w;
    logic [NUM_LANES-1:0][XLEN-1:0] dec_rs1_data_w;
    logic [NUM_LANES-1:0][XLEN-1:0] dec_rs2_data_w;
    logic [NUM_THREADS-1:0]         dec_active_mask_w;

    // Execute → Memory
    logic [NUM_LANES-1:0][XLEN-1:0] exe_result_w;
    decoded_instr_s                  exe_decoded_w;

    // Memory → Writeback
    logic [NUM_LANES-1:0][XLEN-1:0] mem_result_w;
    decoded_instr_s                  mem_decoded_w;

    // Execute → Fetch (branch)
    logic                   branch_taken_w;
    logic [NUM_THREADS-1:0] branch_mask_w;
    logic [PC_WIDTH-1:0]    branch_target_w;
    logic                   exe_yield_w;
    logic                   exe_binit_w;
    logic                   exe_bwait_w;

    // Regfile ↔ Decode / Writeback
    logic [REG_ADDR_WIDTH-1:0]       rf_rs1_addr_w;
    logic [REG_ADDR_WIDTH-1:0]       rf_rs2_addr_w;
    logic [NUM_LANES-1:0][XLEN-1:0]  rf_rs1_data_w;
    logic [NUM_LANES-1:0][XLEN-1:0]  rf_rs2_data_w;
    logic                             rf_write_en_w;
    logic [REG_ADDR_WIDTH-1:0]        rf_write_addr_w;
    logic [NUM_LANES-1:0][XLEN-1:0]   rf_write_data_w;

    // ROM address and active mask come from fetch stage
    assign rom_addr_o    = fetch_pc_w;
    assign active_mask_o = active_mask_w;

    // =========================================================================
    //  Module instances
    // =========================================================================

    pipeline_controller u_ctrl (
        .clk               (clk),
        .rst_n             (rst_n),
        .fetch_done_i      (fetch_done_w),
        .rom_done_i        (rom_done_i),
        .decode_done_i     (decode_done_w),
        .execute_done_i    (execute_done_w),
        .memory_done_i     (memory_done_w),
        .writeback_done_i  (writeback_done_w),
        .fetch_valid_o     (fetch_valid_w),
        .rom_read_en_o     (rom_read_en_o),
        .decode_valid_o    (decode_valid_w),
        .execute_valid_o   (execute_valid_w),
        .memory_valid_o    (memory_valid_w),
        .writeback_valid_o (writeback_valid_w)
    );

    fetch u_fetch (
        .clk             (clk),
        .rst_n           (rst_n),
        .valid_i         (fetch_valid_w),
        .done_o          (fetch_done_w),
        .branch_taken_i  (branch_taken_w),
        .branch_mask_i   (branch_mask_w),
        .branch_target_i (branch_target_w),
        .yield_i         (exe_yield_w),
        .binit_i         (exe_binit_w),
        .bwait_i         (exe_bwait_w),
        .pc_o            (fetch_pc_w),
        .active_mask_o   (active_mask_w)
    );

    decode u_decode (
        .clk           (clk),
        .rst_n         (rst_n),
        .valid_i       (decode_valid_w),
        .done_o        (decode_done_w),
        .instr_i       (rom_instr_i),
        .pc_i          (fetch_pc_w),
        .active_mask_i (rom_active_mask_i),
        .rs1_addr_o    (rf_rs1_addr_w),
        .rs2_addr_o    (rf_rs2_addr_w),
        .rs1_data_i    (rf_rs1_data_w),
        .rs2_data_i    (rf_rs2_data_w),
        .decoded_o     (dec_decoded_w),
        .rs1_data_o    (dec_rs1_data_w),
        .rs2_data_o    (dec_rs2_data_w),
        .pc_o          (dec_pc_w),
        .active_mask_o (dec_active_mask_w)
    );

    execute u_execute (
        .clk             (clk),
        .rst_n           (rst_n),
        .valid_i         (execute_valid_w),
        .done_o          (execute_done_w),
        .decoded_i       (dec_decoded_w),
        .rs1_data_i      (dec_rs1_data_w),
        .rs2_data_i      (dec_rs2_data_w),
        .pc_i            (dec_pc_w),
        .active_mask_i   (dec_active_mask_w),
        .result_o        (exe_result_w),
        .decoded_pass_o  (exe_decoded_w),
        .branch_taken_o  (branch_taken_w),
        .branch_mask_o   (branch_mask_w),
        .branch_target_o (branch_target_w),
        .yield_o         (exe_yield_w),
        .binit_o         (exe_binit_w),
        .bwait_o         (exe_bwait_w)
    );

    memory u_memory (
        .clk       (clk),
        .rst_n     (rst_n),
        .valid_i   (memory_valid_w),
        .done_o    (memory_done_w),
        .decoded_i (exe_decoded_w),
        .result_i  (exe_result_w),
        .decoded_o (mem_decoded_w),
        .result_o  (mem_result_w)
    );

    writeback u_writeback (
        .clk              (clk),
        .rst_n            (rst_n),
        .valid_i          (writeback_valid_w),
        .done_o           (writeback_done_w),
        .decoded_i        (mem_decoded_w),
        .result_i         (mem_result_w),
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

// `default_nettype wire
