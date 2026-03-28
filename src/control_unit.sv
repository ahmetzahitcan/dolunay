`default_nettype none

module control_unit
    import control_unit_pkg::*;
(
    input  wire  [31:2] instr_i,
    output control_signals_s control_signals_o
);

    always_comb begin
        case (instr_i) inside
            30'b000000000000000001000000000010: begin // YIELD
                control_signals_o.alu_funct = UNDEFINED;
                control_signals_o.writeback = 1'b0;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b1;
            end
            30'b111100010100?????????????11100: begin // CSR_MHARTID
                control_signals_o.alu_funct = ALU_HARTID;
                control_signals_o.writeback = 1'b1;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b0000000??????????000?????01100: begin // ADD
                control_signals_o.alu_funct = ALU_ADD;
                control_signals_o.writeback = 1'b1;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b0000000??????????001?????00010: begin // BINIT
                control_signals_o.alu_funct = UNDEFINED;
                control_signals_o.writeback = 1'b0;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b1;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b0000000??????????010?????00010: begin // BWAIT
                control_signals_o.alu_funct = UNDEFINED;
                control_signals_o.writeback = 1'b0;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b1;
                control_signals_o.yield = 1'b0;
            end
            30'b?????????????????000?????11000: begin // BEQ
                control_signals_o.alu_funct = ALU_BEQ;
                control_signals_o.writeback = 1'b0;
                control_signals_o.branch = 1'b1;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b?????????????????????????11100: begin // CSR_OTHER
                control_signals_o.alu_funct = ALU_ZERO;
                control_signals_o.writeback = 1'b1;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            default: begin // INVALID
                control_signals_o.alu_funct = UNDEFINED;
                control_signals_o.writeback = 'x;
                control_signals_o.branch = 'x;
                control_signals_o.binit = 'x;
                control_signals_o.bwait = 'x;
                control_signals_o.yield = 'x;
            end
        endcase
    end

endmodule

`default_nettype wire
