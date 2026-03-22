// =============================================================================
// execute.sv — SIMD execute stage (ADD / BEQ)
// =============================================================================
`default_nettype none

module execute
    import proto_pkg::*;
(
    input  logic clk,
    input  logic rst_n,

    // Pipeline handshake
    input  logic           valid_i,
    output logic           done_o,

    // Decoded instruction + operands from decode
    input  decoded_instr_t              decoded_i,
    input  logic [NUM_LANES-1:0][XLEN-1:0] rs1_data_i,
    input  logic [NUM_LANES-1:0][XLEN-1:0] rs2_data_i,

    // ALU result
    output logic [NUM_LANES-1:0][XLEN-1:0] result_o,
    output decoded_instr_t                  decoded_pass_o,

    // Branch resolution
    output logic                branch_taken_o,
    output logic [PC_WIDTH-1:0] branch_target_o
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

                case (decoded_i.opcode)
                    OP_ADD: alu_result_w[g] = rs1_data_i[g] + rs2_data_i[g];
                    OP_BEQ: lane_eq_w[g]    = (rs1_data_i[g] == rs2_data_i[g]);
                    default: ;
                endcase
            end
        end
    endgenerate

    // -------------------------------------------------------------------------
    // Branch logic — branch if ALL lanes agree (simplified)
    // -------------------------------------------------------------------------
    logic branch_taken_w;
    assign branch_taken_w = (decoded_i.opcode == OP_BEQ) && (&lane_eq_w);

    logic [PC_WIDTH-1:0] branch_target_w;
    assign branch_target_w = decoded_i.imm;  // TODO: add PC offset properly

    // -------------------------------------------------------------------------
    // Registered outputs
    // -------------------------------------------------------------------------
    logic [NUM_LANES-1:0][XLEN-1:0] result_r;
    decoded_instr_t decoded_pass_r;
    logic branch_taken_r;
    logic [PC_WIDTH-1:0] branch_target_r;
    logic done_r;

    assign result_o        = result_r;
    assign decoded_pass_o  = decoded_pass_r;
    assign branch_taken_o  = branch_taken_r;
    assign branch_target_o = branch_target_r;
    assign done_o          = done_r;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            result_r        <= '0;
            decoded_pass_r  <= '0;
            branch_taken_r  <= 1'b0;
            branch_target_r <= '0;
            done_r          <= 1'b0;
        end else begin
            done_r <= 1'b0;

            if (valid_i) begin
                result_r        <= alu_result_w;
                decoded_pass_r  <= decoded_i;
                branch_taken_r  <= branch_taken_w;
                branch_target_r <= branch_target_w;
                done_r          <= 1'b1;
            end
        end
    end

endmodule

`default_nettype wire
