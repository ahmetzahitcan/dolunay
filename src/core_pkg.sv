`default_nettype none

package core_pkg;
    import params_pkg::*;
    import control_unit_pkg::*;

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
        logic use_uwb;
        simd_data_t wb_result;
        uniform_data_t uwb_result;
        simd_data_t csrw_result;
        fpnew_pkg::status_t [N_THREADS-1:0] fpu_status;
    } fu_result_s;

    typedef logic [N_HAZARDS-1:0] hazard_mask_t;

    // Classification of a branch with respect to the active thread mask.
    //   BR_UNIFORM_ALL : every active thread takes the branch
    //   BR_UNIFORM_NONE: no active thread takes the branch
    //   BR_DIVERGENT   : some active threads take the branch, others do not
    typedef enum logic [1:0] {
        BR_UNIFORM_ALL,
        BR_UNIFORM_NONE,
        BR_DIVERGENT
    } branch_type_e;

endpackage

`default_nettype wire
