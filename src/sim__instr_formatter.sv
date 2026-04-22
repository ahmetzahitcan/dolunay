`default_nettype none

module sim__instr_formatter
    import params_pkg::*;
    import control_unit_pkg::*;
(
    input string format_i,
    input wire logic [W_REGISTERS-1:0] rd_i,
    input wire logic [W_REGISTERS-1:0] rs1_i,
    input wire logic [W_REGISTERS-1:0] rs2_i,
    input wire logic [XLEN-1:0] imm_i,
    input wire logic [XLEN-1:Z_PC] pc_i,
    output sim__disasm_t disasm_o
);

    `ifdef SYNTHESIS
        static assert(0) else $error("sim__instr_formatter cannot be synthesized");
    `endif

    string s;
    int disasm_idx;
    bit special;

    always_comb begin
        for (int i = 0; i < DISASM_LEN; i++) begin
            disasm_o[i*8 +: 8] = " ";
        end

        disasm_idx = DISASM_LEN - 1;
        s = $sformatf("%0d:", pc_i);
        foreach (s[i]) begin
            disasm_o[disasm_idx*8 +: 8] = s[i];
            disasm_idx--;
        end

        disasm_idx = DISASM_LEN - 6;
        special = 0;
        foreach (format_i[i]) begin
            if (special) begin
                case (format_i[i])
                    "d", "D": s = $sformatf("x%0d", rd_i);
                    "1": s = $sformatf("x%0d", rs1_i);
                    "2": s = $sformatf("x%0d", rs2_i);
                    "i", "I": s = $sformatf("0x%0x", imm_i);
                    "p", "P": s = $sformatf("%0d", pc_i + imm_i[XLEN-1:Z_PC]);
                    "$": s = "$";
                    default: $error("Invalid format specifier: $%c", format_i[i]);
                endcase

                foreach (s[j]) begin
                    disasm_o[disasm_idx*8 +: 8] = s[j];
                    disasm_idx--;
                end

                special = 0;
            end else begin
                if (format_i[i] == "$") begin
                    special = 1;
                end else begin
                    disasm_o[disasm_idx*8 +: 8] = format_i[i];
                    disasm_idx--;
                end 
            end
        end
    end

endmodule

`default_nettype wire