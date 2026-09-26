`default_nettype none

package fu_pkg;
    import params_pkg::*;

    typedef struct packed {
        seq_t seq;
        warp_id_t warp_id;
        control_unit_pkg::instr_s instr;
        pc_t pc;
        simd_mask_t mask;
        simd_data_t rs1_data;
        simd_data_t rs2_data;
        simd_data_t rs3_data;
    } fu_operation_s;

    typedef struct packed {
        seq_t seq;
        warp_id_t warp_id;
        control_unit_pkg::instr_s instr;
        pc_t pc;
        simd_mask_t mask;
        simd_data_t result;
        fpnew_pkg::status_t [N_THREADS-1:0] fpu_status ;
    } fu_result_s;

    localparam int N_FUNCTION_UNITS = 2;
    localparam int W_FUNCTION_UNITS = $clog2(N_FUNCTION_UNITS);
    typedef enum logic [W_FUNCTION_UNITS-1:0] {
        FUNCTION_UNIT_ALU,
        FUNCTION_UNIT_FPU
    } function_unit_e;

endpackage

`default_nettype wire
