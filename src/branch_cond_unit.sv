`default_nettype none

module branch_cond_unit
    import params_pkg::*;
    import control_unit_pkg::*;
(
    input wire logic [XLEN-1:0] alu_result_i,
    input wire logic jalr_coalesced_i,
    input wire logic memory_access_failed_i,
    input wire branch_cond_e branch_cond_i,
    output logic branch_flag_o
);

    logic branch_flag_w;
    always_comb begin
        case (branch_cond_i)
            BRANCH_COND_ZERO: branch_flag_w = (alu_result_i == '0);
            BRANCH_COND_NONZERO: branch_flag_w = (alu_result_i != '0);
            BRANCH_COND_NEVER: branch_flag_w = 1'b0;
            BRANCH_COND_ALWAYS: branch_flag_w = 1'b1;
            BRANCH_COND_COALESCE: branch_flag_w = jalr_coalesced_i;
            BRANCH_COND_MEMORY: branch_flag_w = memory_access_failed_i;
            default: branch_flag_w = 'x;
        endcase
    end

    assign branch_flag_o = branch_flag_w;
    
endmodule

`default_nettype wire