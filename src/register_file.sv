`default_nettype none

// =============================================================================
// register_file.sv — SIMD register file with two symmetric read/write
// ports (N_WARPS × N_REGISTERS × N_THREADS × RLEN)
// =============================================================================
//
// Both ports are identical read/write ports, i.e. the memory is described the
// way a true dual-port block RAM is meant to be used:
//
//   * Each port presents one address, one per-thread write-enable mask and one
//     write-data vector, and returns the register addressed by that same
//     address. So a port reads and/or writes one address per cycle.
//
//   * Reads are registered: the addressed register is captured on the clock
//     edge and appears on the output one cycle later.
//
//   * When a port writes the address it reads in the same cycle, its read data
//     is the value stored before the clock edge (read-before-write), matching
//     the read-first behaviour of the inferred block RAM.
//
//   * Writing the same address from both ports in the same cycle is an error;
//     keep the two write addresses distinct.
//
// The array is written so it can map to true dual-port block RAM without any
// shadowing (one block per per-thread memory). It is intentionally NOT
// instantiated anywhere yet.
//
// Register 0 of the integer register file reads as zero, so writes to it have
// no architectural effect.
//
module register_file
    import params_pkg::*;
(
    input wire logic clk,

    // Port A (read/write)
    input wire  warp_id_t     porta_warp_id_i,
    input wire  reg_id_t      porta_idx_i,
    input wire  regfile_sel_e porta_regfile_i,
    input wire  simd_mask_t   porta_write_en_mask_i,
    input wire  simd_data_t   porta_write_data_i,
    output simd_data_t        porta_data_o,

    // Port B (read/write)
    input wire  warp_id_t     portb_warp_id_i,
    input wire  reg_id_t      portb_idx_i,
    input wire  regfile_sel_e portb_regfile_i,
    input wire  simd_mask_t   portb_write_en_mask_i,
    input wire  simd_data_t   portb_write_data_i,
    output simd_data_t        portb_data_o
);
    simd_data_t porta_data_r;
    simd_data_t portb_data_r;

    `ifndef SYNTHESIS
    // slang lint_off unused-but-set-variable
        logic [RLEN-1:0] sim__regs_shadow_w [0:N_WARPS-1][0:N_THREADS-1][0:N_REGFILES-1][0:N_REGISTERS-1];
    // slang lint_on unused-but-set-variable

        logic sim__init;
        initial begin
            sim__init = 1;
            @(posedge clk);
            @(posedge clk) sim__init = 0;
        end
    `endif

    generate
        for (genvar T = 0; T < N_THREADS; T++) begin : gen_threads
            // NOTE: Vivado only infers true dual-port block RAM when each write
            // port lives in its own process, so regs_r is deliberately driven
            // from more than one always_ff below. That looks like multiple
            // drivers to slang, hence the lint waiver.
            // slang lint_off multiple-always-assigns
            (* ram_style = "block" *)
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

            // Port A: read + write share one address
            always_ff @(posedge clk) begin
                if (porta_write_en_mask_i[T]) begin
                    regs_r[int'(porta_warp_id_i) * N_REGFILES * N_REGISTERS + int'(porta_regfile_i) * N_REGISTERS + int'(porta_idx_i)] <= porta_write_data_i[T];
                end
                porta_data_r[T] <= regs_r[int'(porta_warp_id_i) * N_REGFILES * N_REGISTERS + int'(porta_regfile_i) * N_REGISTERS + int'(porta_idx_i)];
            end

            // Port B: read + write share one address
            always_ff @(posedge clk) begin
                if (portb_write_en_mask_i[T]) begin
                    regs_r[int'(portb_warp_id_i) * N_REGFILES * N_REGISTERS + int'(portb_regfile_i) * N_REGISTERS + int'(portb_idx_i)] <= portb_write_data_i[T];
                end
                portb_data_r[T] <= regs_r[int'(portb_warp_id_i) * N_REGFILES * N_REGISTERS + int'(portb_regfile_i) * N_REGISTERS + int'(portb_idx_i)];
            end

            `ifndef SYNTHESIS
            // Simulation-only initialization for easy debugging until xwarpid/xthrid support is back.
            always_ff @(posedge clk) begin
                if (sim__init) begin
                    for (int W = 0; W < N_WARPS; W++) begin
                        for (int R = 0; R < N_REGISTERS; R++) begin
                            regs_r[W * N_REGFILES * N_REGISTERS + int'(REGFILE_SEL_I) * N_REGISTERS + R] <= unsigned'(W << 16) | T;
                        end
                    end
                end
            end
            `endif
            // slang lint_on multiple-always-assigns

            `ifndef SYNTHESIS
            // The two ports must not write the same register in the same cycle.
            always_comb begin
                assert (
                    !porta_write_en_mask_i[T] || !portb_write_en_mask_i[T] ||
                    porta_warp_id_i != portb_warp_id_i ||
                    porta_regfile_i != portb_regfile_i ||
                    porta_idx_i != portb_idx_i)
                else $error("Cannot write to the same register from both ports!");
            end
            `endif
        end
    endgenerate

    logic porta_zero_r, portb_zero_r;
    always_ff @(posedge clk) begin
        porta_zero_r <= (porta_idx_i == 0) && (porta_regfile_i == REGFILE_SEL_I);
        portb_zero_r <= (portb_idx_i == 0) && (portb_regfile_i == REGFILE_SEL_I);
    end

    assign porta_data_o = porta_zero_r ? '{default: '0} : porta_data_r;
    assign portb_data_o = portb_zero_r ? '{default: '0} : portb_data_r;

endmodule

`default_nettype wire
