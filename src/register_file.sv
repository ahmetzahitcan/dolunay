`default_nettype none

// =============================================================================
// register_file.sv — SIMD register file (N_WARPS × N_REGISTERS × N_THREADS × RLEN)
// =============================================================================
module register_file
    import params_pkg::*;
(
    input wire logic clk,

    input wire warp_id_t read_warp_id_i,
    input wire warp_id_t write_warp_id_i,

    // Read port 1
    input wire  reg_id_t       rs1_idx_i,
    input wire  regfile_sel_e rs1_regfile_i,
    output simd_data_t  rs1_data_o,

    // Read port 2
    input wire  reg_id_t       rs2_idx_i,
    input wire  regfile_sel_e rs2_regfile_i,
    output simd_data_t  rs2_data_o,

    // Read port 3
    input wire  reg_id_t       rs3_idx_i,
    input wire  regfile_sel_e rs3_regfile_i,
    output simd_data_t  rs3_data_o,

    // Write port
    input wire  simd_mask_t         write_en_mask_i,
    input wire  reg_id_t        rd_idx_i,
    input wire  regfile_sel_e rd_regfile_i,
    input wire  simd_data_t  write_data_i
);

    `ifndef SYNTHESIS
        assert property
            (@(posedge clk) (read_warp_id_i != write_warp_id_i) || (write_en_mask_i == '0))
            else $error("Register file read and write from same warp");
    `endif

    simd_data_t rs1_data_r;
    simd_data_t rs2_data_r;
    simd_data_t rs3_data_r;

    `ifndef SYNTHESIS
    // slang lint_off unused-but-set-variable
        logic [RLEN-1:0] sim__regs_shadow_w [0:N_WARPS-1][0:N_THREADS-1][0:N_REGFILES-1][0:N_REGISTERS-1];
    // slang lint_on unused-but-set-variable
    `endif

    generate
        for (genvar T = 0; T < N_THREADS; T++) begin : gen_threads
            logic [RLEN-1:0] regs_r [0:(N_WARPS * N_REGFILES * N_REGISTERS) - 1];

            `ifndef SYNTHESIS
                for (genvar W = 0; W < N_WARPS; W++) begin : gen_warps
                    for (genvar I = 0; I < N_REGFILES; I++) begin : gen_regfiles
                        for (genvar R = 0; R < N_REGISTERS; R++) begin : gen_regs
                            if (R == 0 && I == 0) begin : gen_regs_x0
                                assign sim__regs_shadow_w[W][T][I][R] = 0;
                            end else begin : gen_regs_other
                                assign sim__regs_shadow_w[W][T][I][R] = regs_r[W * N_REGFILES * N_REGISTERS + I * N_REGISTERS + R];
                            end
                        end
                    end
                end
            `endif

            always_ff @(posedge clk) begin
                if (write_en_mask_i[T]) begin
                    regs_r[int'(write_warp_id_i) * N_REGFILES * N_REGISTERS + int'(rd_regfile_i) * N_REGISTERS + int'(rd_idx_i)] <= write_data_i[T];
                end
            end

            always_ff @( posedge clk ) begin
                rs1_data_r[T] <= regs_r[int'(read_warp_id_i) * N_REGFILES * N_REGISTERS + int'(rs1_regfile_i) * N_REGISTERS + int'(rs1_idx_i)];
                rs2_data_r[T] <= regs_r[int'(read_warp_id_i) * N_REGFILES * N_REGISTERS + int'(rs2_regfile_i) * N_REGISTERS + int'(rs2_idx_i)];
                rs3_data_r[T] <= regs_r[int'(read_warp_id_i) * N_REGFILES * N_REGISTERS + int'(rs3_regfile_i) * N_REGISTERS + int'(rs3_idx_i)];
            end
        end
    endgenerate

    logic rs1_zero_r, rs2_zero_r, rs3_zero_r;
    always_ff @( posedge clk ) begin
        rs1_zero_r <= (rs1_idx_i == 0) && (rs1_regfile_i == REGFILE_SEL_I);
        rs2_zero_r <= (rs2_idx_i == 0) && (rs2_regfile_i == REGFILE_SEL_I);
        rs3_zero_r <= (rs3_idx_i == 0) && (rs3_regfile_i == REGFILE_SEL_I);
    end

    assign rs1_data_o = rs1_zero_r ? '{default: '0} : rs1_data_r;
    assign rs2_data_o = rs2_zero_r ? '{default: '0} : rs2_data_r;
    assign rs3_data_o = rs3_zero_r ? '{default: '0} : rs3_data_r;

endmodule

`default_nettype wire
