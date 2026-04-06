module mem_read_formatter 
    import params_pkg::*;
    import control_unit_pkg::*;
(
    input wire  mem_opsize_e opsize_i,
    input wire  mem_extendmode_e extendmode_i,
    input wire  logic [XLEN-1:0] m_data_i,
    input wire  logic [Z_ADDR-1:0] alignment_i,
    output logic [XLEN-1:0] p_data_o
)

    `ifndef SYNTHESIS
        initial assert (ADDR_ALIGN == 4) else $error("Only ADDR_ALIGN = 4 is supported");
    `endif

    logic [7:0] byte_w;
    always_comb begin
        case (alignment_i) begin
            2'b00: byte_w = m_data_i[7:0];
            2'b01: byte_w = m_data_i[15:8];
            2'b10: byte_w = m_data_i[23:16];
            2'b11: byte_w = m_data_i[31:24];
            default: byte_w = 'x;
        endcase
    end

    logic [15:0] half_w;
    always_comb begin
        case (alignment_i) begin
            2'b00: half_w = m_data_i[15:0];
            2'b10: half_w = m_data_i[31:16];
            default: half_w = 'x;
        endcase
    end

    logic [31:0] word_w;
    always_comb begin
        case (alignment_i) begin
            2'b00: word_w = m_data_i[31:0];
            default: word_w = 'x;
        endcase
    end

    logic sign_w;
    always_comb begin
        case (opsize_i) begin
            MEM_OPSIZE_BYTE: sign_w = byte_w[7];
            MEM_OPSIZE_HALF: sign_w = half_w[15];
            MEM_OPSIZE_WORD: sign_w = word_w[31];
            default: sign_w = 'x;
        end
    end

    logic extend_w;
    assign extend_w = extendmode_i == MEM_EXTENDMODE_SIGN ? sign_w : 1'b0;

    logic [XLEN-1:0] reg_data_w;

    always_comb begin
        case (opsize_i) inside
            MEM_OPSIZE_BYTE: reg_data_w = {{XLEN-8{extend_w}}, byte_w};
            MEM_OPSIZE_HALF: reg_data_w = {{XLEN-16{extend_w}}, half_w};
            MEM_OPSIZE_WORD: reg_data_w = {{XLEN-32{extend_w}}, word_w};
            default: reg_data_w = 'x;
        endcase
    end

    assign p_data_o = reg_data_w;

endmodule