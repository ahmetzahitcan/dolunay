// =============================================================================
// execute.sv — SIMD execute stage (ADD / BEQ)
// =============================================================================
// `default_nettype none

module execute
    import proto_pkg::*;
    import control_unit_pkg::*;
(
    input  wire logic clk,
    input  wire logic rst_n,

    // Pipeline handshake
    input  wire logic           valid_i,
    output logic           done_o,

    // Decoded instruction + operands from decode
    input  decoded_instr_s              decoded_i,
    input  wire logic [NUM_LANES-1:0][XLEN-1:0] rs1_data_i,
    input  wire logic [NUM_LANES-1:0][XLEN-1:0] rs2_data_i,
    input  wire logic [PC_WIDTH-1:0] pc_i,
    input  wire logic [NUM_THREADS-1:0]      active_mask_i,

    // ALU result
    output logic [NUM_LANES-1:0][XLEN-1:0] result_o,
    output decoded_instr_s                  decoded_pass_o,

    // Branch resolution
    output logic                branch_taken_o,
    output logic [NUM_THREADS-1:0] branch_mask_o,
    output logic [PC_WIDTH-1:0] branch_target_o,
    output logic                yield_o,
    output logic                binit_o,
    output logic                bwait_o
);

    // -------------------------------------------------------------------------
    // ALU lanes (combinational)
    // -------------------------------------------------------------------------
    logic [NUM_LANES-1:0][XLEN-1:0] alu_result_w;
    logic [NUM_LANES-1:0]           lane_eq_w;

    genvar g;
    generate
        for (g = 0; g < NUM_LANES; g++) begin : alu_lane
            always_comb begin
                alu_result_w[g] = '0;
                lane_eq_w[g]    = 1'b0;

                case (decoded_i.control_signals.alu_funct)
                    ALU_ADD: alu_result_w[g] = rs1_data_i[g] + rs2_data_i[g];
                    ALU_BEQ: lane_eq_w[g]    = (rs1_data_i[g] == rs2_data_i[g]);
                    default: ;
                endcase
            end
        end
    endgenerate

    // -------------------------------------------------------------------------
    // Branch logic
    // -------------------------------------------------------------------------
    logic branch_taken_w;
    logic [NUM_THREADS-1:0] branch_mask_w;
    // Condition matches for each lane
    assign branch_mask_w = decoded_i.control_signals.branch ? (lane_eq_w & active_mask_i) : '0;
    // Take branch if ANY active lane satisfied the condition
    assign branch_taken_w = |branch_mask_w;

    logic [PC_WIDTH-1:0] branch_target_w;
    assign branch_target_w = pc_i + decoded_i.imm; 

    // -------------------------------------------------------------------------
    // Registered outputs
    // -------------------------------------------------------------------------
    logic [NUM_LANES-1:0][XLEN-1:0] result_r;
    decoded_instr_s decoded_pass_r;
    logic branch_taken_r;
    logic [NUM_THREADS-1:0] branch_mask_r;
    logic [PC_WIDTH-1:0] branch_target_r;
    logic yield_r;
    logic binit_r;
    logic bwait_r;
    logic done_r;

    assign result_o        = result_r;
    assign decoded_pass_o  = decoded_pass_r;
    assign branch_taken_o  = branch_taken_r;
    assign branch_mask_o   = branch_mask_r;
    assign branch_target_o = branch_target_r;
    assign yield_o         = yield_r;
    assign binit_o         = binit_r;
    assign bwait_o         = bwait_r;
    assign done_o          = done_r;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            result_r        <= '0;
            decoded_pass_r  <= '0;
            branch_taken_r  <= 1'b0;
            branch_mask_r   <= '0;
            branch_target_r <= '0;
            yield_r         <= 1'b0;
            binit_r         <= 1'b0;
            bwait_r         <= 1'b0;
            done_r          <= 1'b0;
        end else begin
            done_r <= 1'b0;

            if (valid_i) begin
                result_r        <= alu_result_w;
                decoded_pass_r  <= decoded_i;
                branch_taken_r  <= branch_taken_w;
                branch_mask_r   <= branch_mask_w;
                branch_target_r <= branch_target_w;
                yield_r         <= decoded_i.control_signals.yield;
                binit_r         <= decoded_i.control_signals.binit;
                bwait_r         <= decoded_i.control_signals.bwait;
                done_r          <= 1'b1;
            end
        end
    end

endmodule

// `default_nettype wire
