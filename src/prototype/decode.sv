// =============================================================================
// decode.sv — Instruction decode + register file read
// =============================================================================
// // `default_nettype none

module decode
    import proto_pkg::*;
(
    input  wire logic clk,
    input  wire logic rst_n,

    // Pipeline handshake
    input  wire logic           valid_i,
    output logic           done_o,

    // Raw instruction from ROM
    input  wire logic [31:0]    instr_i,
    input  wire logic [NUM_THREADS-1:0] active_mask_i,

    // Register file read interface
    output logic [REG_ADDR_WIDTH-1:0] rs1_addr_o,
    output logic [REG_ADDR_WIDTH-1:0] rs2_addr_o,
    input  wire logic [NUM_LANES-1:0][XLEN-1:0] rs1_data_i,
    input  wire logic [NUM_LANES-1:0][XLEN-1:0] rs2_data_i,

    // Decoded outputs
    output decoded_instr_t              decoded_o,
    output logic [NUM_LANES-1:0][XLEN-1:0] rs1_data_o,
    output logic [NUM_LANES-1:0][XLEN-1:0] rs2_data_o,
    output logic [NUM_THREADS-1:0]      active_mask_o
);

    // -------------------------------------------------------------------------
    // Decode logic (combinational)
    // -------------------------------------------------------------------------
    decoded_instr_t decoded_w;

    control_unit ctrl_i (
        .instr_i (instr_i[31:2]),
        .control_signals_o(decoded_w.control_signals)
    );

    always_comb begin
        decoded_w.rd     = instr_i[11:7];
        decoded_w.rs1    = instr_i[19:15];
        decoded_w.rs2    = instr_i[24:20];
        decoded_w.imm    = {{20{instr_i[31]}}, instr_i[7],
                            instr_i[30:25], instr_i[11:8], 1'b0};
    end

    // -------------------------------------------------------------------------
    // Register addresses driven combinationally for regfile read
    // -------------------------------------------------------------------------
    assign rs1_addr_o = decoded_w.rs1;
    assign rs2_addr_o = decoded_w.rs2;

    // -------------------------------------------------------------------------
    // Registered outputs
    // -------------------------------------------------------------------------
    decoded_instr_t decoded_r;
    logic [NUM_LANES-1:0][XLEN-1:0] rs1_data_r;
    logic [NUM_LANES-1:0][XLEN-1:0] rs2_data_r;
    logic [NUM_THREADS-1:0] active_mask_r;
    logic done_r;

    assign decoded_o     = decoded_r;
    assign rs1_data_o    = rs1_data_r;
    assign rs2_data_o    = rs2_data_r;
    assign active_mask_o = active_mask_r;
    assign done_o        = done_r;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            decoded_r     <= '0;
            rs1_data_r    <= '0;
            rs2_data_r    <= '0;
            active_mask_r <= '0;
            done_r        <= 1'b0;
        end else begin
            done_r <= 1'b0;

            if (valid_i) begin
                decoded_r     <= decoded_w;
                rs1_data_r    <= rs1_data_i;
                rs2_data_r    <= rs2_data_i;
                active_mask_r <= active_mask_i;
                done_r        <= 1'b1;
            end
        end
    end

endmodule

// // `default_nettype wire
