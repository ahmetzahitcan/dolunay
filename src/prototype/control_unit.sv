`default_nettype none

module control_unit (
    input  wire  [31:2] instr_i,
    output logic   [1:0] opcode_o
);

    always_comb begin

        case (instr_i) inside
            30'b0000000??????????000?????01100: begin // ADD
                opcode_o = 2'b00;
            end
            30'b?????????????????000?????11000: begin // BEQ
                opcode_o = 2'b01;
            end
            default: begin // INVALID
                opcode_o = 2'b00;
            end
        endcase
    end
endmodule

`default_nettype wire
