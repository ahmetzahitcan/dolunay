`default_nettype none

module control_unit (
    input  wire  [31:2] instr_i,
);

    always_comb begin

        case (instr_i) inside
            30'b0000000??????????000?????01100: begin // ADD
            end
            30'b?????????????????000?????11000: begin // BEQ
            end
            default: begin // INVALID
            end
        endcase
    end
endmodule

`default_nettype wire
