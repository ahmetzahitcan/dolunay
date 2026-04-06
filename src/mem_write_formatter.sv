module mem_write_formatter
    import params_pkg::*;
    import control_unit_pkg::*;
#(
    parameter int DATA_LEN = N_THREADS
)(
    input wire logic [DATA_LEN-1:0][XLEN-1:0] p_data_i,
    input wire mem_opsize_e opsize_i,
    input wire logic [DATA_LEN-1:0][Z_ADDR-1:0] alignment_i,
    output logic [DATA_LEN-1:0][XLEN-1:0] m_data_o,
    output logic [DATA_LEN-1:0][ADDR_ALIGN-1:0] m_wen_o
);

    `ifndef SYNTHESIS
        initial begin
            assert (ADDR_ALIGN == 4) else $error("Only ADDR_ALIGN = 4 is supported");
        end
    `endif

    logic [DATA_LEN-1:0][XLEN-1:0] m_data_w;

    always_comb begin
        for (int i = 0; i < DATA_LEN; i++) begin
            case (opsize_i)
                MEM_OPSIZE_BYTE: m_data_w[i] = {4{p_data_i[i][7:0]}};
                MEM_OPSIZE_HALF: m_data_w[i] = {2{p_data_i[i][15:0]}};
                MEM_OPSIZE_WORD: m_data_w[i] = p_data_i[i];
                default: m_data_w[i] = 'x;
            endcase
        end
    end

    logic [DATA_LEN-1:0][ADDR_ALIGN-1:0] m_wen_w;

    always_comb begin
        for (int i = 0; i < DATA_LEN; i++) begin
            case (opsize_i)
                MEM_OPSIZE_BYTE: case (alignment_i[i])
                    2'b00: m_wen_w[i] = 4'b0001;
                    2'b01: m_wen_w[i] = 4'b0010;
                    2'b10: m_wen_w[i] = 4'b0100;
                    2'b11: m_wen_w[i] = 4'b1000;
                    default: m_wen_w[i] = 'x;
                endcase
                MEM_OPSIZE_HALF: case (alignment_i[i])
                    2'b00: m_wen_w[i] = 4'b0011;
                    2'b10: m_wen_w[i] = 4'b1100;
                    default: m_wen_w[i] = 'x;
                endcase
                MEM_OPSIZE_WORD: case (alignment_i[i])
                    2'b00: m_wen_w[i] = 4'b1111;
                    default: m_wen_w[i] = 'x;
                endcase
                default: m_wen_w[i] = 'x;
            endcase
        end
    end

    assign m_data_o = m_data_w;
    assign m_wen_o = m_wen_w;

endmodule