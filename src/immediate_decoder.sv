module immediate_decoder 
    import control_unit_pkg::*;
(
    input wire [31:2] instr_i,
    input imm_type_e imm_type_i,
    output logic [31:0] imm_o
);

logic sign;
assign sign = instr_i[31];

always_comb begin
    case (imm_type_i) inside
        IMM_TYPE_I: imm_o = {{20{sign}}, instr_i[31:20]};
        IMM_TYPE_U: imm_o = {instr_i[31:12], 12'b0};
        IMM_TYPE_B: imm_o = {{20{sign}}, instr_i[31], instr_i[7], instr_i[30:25], instr_i[11:8], 1'b0};
        default: imm_o = 'x;
    endcase
end

endmodule