module mem_read_formatter 
    import params_pkg::*;
    import control_unit_pkg::*;
#(
    parameter int DATA_LEN = N_THREADS
)(
    input wire  mem_opsize_e opsize_i,
    input wire  mem_extendmode_e extendmode_i,
    input wire  logic [DATA_LEN-1:0][XLEN-1:0] m_data_i,
    input wire  logic [DATA_LEN-1:0][Z_ADDR-1:0] alignment_i,
    output logic [DATA_LEN-1:0][XLEN-1:0] p_data_o
) ;

    `ifndef SYNTHESIS
        initial begin
            assert (ADDR_ALIGN == 4) else $error("Only ADDR_ALIGN = 4 is supported");
        end
    `endif

    logic [DATA_LEN-1:0][7:0] byte_w;
    always_comb begin
        for (int i = 0; i < DATA_LEN; i++) begin
            case (alignment_i[i])
                2'b00: byte_w[i] = m_data_i[i][7:0];
                2'b01: byte_w[i] = m_data_i[i][15:8];
                2'b10: byte_w[i] = m_data_i[i][23:16];
                2'b11: byte_w[i] = m_data_i[i][31:24];
                default: byte_w[i] = 'x;
            endcase
        end
    end

    logic [DATA_LEN-1:0][15:0] half_w;
    always_comb begin
        for (int i = 0; i < DATA_LEN; i++) begin
            case (alignment_i[i])
                2'b00: half_w[i] = m_data_i[i][15:0];
                2'b10: half_w[i] = m_data_i[i][31:16];
                default: half_w[i] = 'x;
            endcase
        end
    end

    logic [DATA_LEN-1:0][31:0] word_w;
    always_comb begin
        for (int i = 0; i < DATA_LEN; i++) begin
            case (alignment_i[i])
                2'b00: word_w[i] = m_data_i[i][31:0];
                default: word_w[i] = 'x;
            endcase
        end
    end

    logic [DATA_LEN-1:0] sign_w;
    always_comb begin
        for (int i = 0; i < DATA_LEN; i++) begin
            case (opsize_i)
                MEM_OPSIZE_BYTE: sign_w[i] = byte_w[i][7];
                MEM_OPSIZE_HALF: sign_w[i] = half_w[i][15];
                MEM_OPSIZE_WORD: sign_w[i] = word_w[i][31];
                default: sign_w[i] = 'x;
            endcase
        end
    end

    logic [DATA_LEN-1:0] extend_w;
    always_comb begin
        for (int i = 0; i < DATA_LEN; i++) begin
            extend_w[i] = extendmode_i == MEM_EXTENDMODE_SIGN ? sign_w[i] : 1'b0;
        end
    end

    logic [DATA_LEN-1:0][XLEN-1:0] reg_data_w;

    always_comb begin
        for (int i = 0; i < DATA_LEN; i++) begin
            case (opsize_i)
                MEM_OPSIZE_BYTE: reg_data_w[i] = {{XLEN-8{extend_w[i]}}, byte_w[i]};
                MEM_OPSIZE_HALF: reg_data_w[i] = {{XLEN-16{extend_w[i]}}, half_w[i]};
                MEM_OPSIZE_WORD: reg_data_w[i] = {{XLEN-32{extend_w[i]}}, word_w[i]};
                default: reg_data_w[i] = 'x;
            endcase
        end
    end

    assign p_data_o = reg_data_w;

endmodule