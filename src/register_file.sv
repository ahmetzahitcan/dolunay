`default_nettype none

// =============================================================================
// register_file.sv — SIMD register file with two symmetric read/write ports
// (N_THREADS × N_PHYS_REGS × RLEN)
// =============================================================================
//
// This register file knows nothing about warps, integer/float register files or
// register-number fields: every per-thread memory is addressed by a single flat
// physical-register index (phys_reg_id_t), and the pool size is
// params_pkg::N_PHYS_REGS. It instantiates N_THREADS independent true dual-port
// RAMs, one per SIMD lane.
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
// shadowing (one block per per-thread memory).
//
module register_file
    import params_pkg::*;
(
    input wire logic clk,

    // Port A (read/write)
    input wire  phys_reg_id_t porta_idx_i,
    input wire  simd_mask_t   porta_write_en_mask_i,
    input wire  simd_data_t   porta_write_data_i,
    output simd_data_t        porta_data_o,

    // Port B (read/write)
    input wire  phys_reg_id_t portb_idx_i,
    input wire  simd_mask_t   portb_write_en_mask_i,
    input wire  simd_data_t   portb_write_data_i,
    output simd_data_t        portb_data_o
);
    simd_data_t porta_data_r;
    simd_data_t portb_data_r;

    `ifndef SYNTHESIS
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
            logic [RLEN-1:0] regs_r [0:N_PHYS_REGS-1];

            // Port A: read + write share one address
            always_ff @(posedge clk) begin
                if (porta_write_en_mask_i[T]) begin
                    regs_r[porta_idx_i] <= porta_write_data_i[T];
                end
                porta_data_r[T] <= regs_r[porta_idx_i];
            end

            // Port B: read + write share one address
            always_ff @(posedge clk) begin
                if (portb_write_en_mask_i[T]) begin
                    regs_r[portb_idx_i] <= portb_write_data_i[T];
                end
                portb_data_r[T] <= regs_r[portb_idx_i];
            end

            `ifndef SYNTHESIS
            // Simulation-only initialization for easy debugging until xwarpid/xthrid support is back.
            always_ff @(posedge clk) begin
                if (sim__init) begin
                    for (int R = 0; R < N_PHYS_REGS; R++) begin
                        regs_r[R] <= unsigned'(R << 16) | T;
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
                    porta_idx_i != portb_idx_i)
                else $error("Cannot write to the same register from both ports!");
            end
            `endif
        end
    endgenerate

    assign porta_data_o = porta_data_r;
    assign portb_data_o = portb_data_r;

endmodule

`default_nettype wire
