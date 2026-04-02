module mem_write_formatter
    import params_pkg::*;
    import control_unit_pkg::*;
(
    input logic p_data_i;
    input mem_opsize_e opsize_i;
    input logic [Z_ADDR-1:0] alignment_i;
    output logic [XLEN-1:0] m_data_o;
    output logic [ADDR_ALIGN-1:0] m_wen_o;
);

    `ifndef SYNTHESIS
        initial assert (ADDR_ALIGN == 4) else $error("Only ADDR_ALIGN = 4 is supported");
    `endif

    logic [XLEN-1:0] m_data_w;

    always_comb begin
        case (opsize_i) begin
            MEM_OPSIZE_BYTE: m_data_w = {4{p_data_i[7:0]}};
            MEM_OPSIZE_HALF: m_data_w = {2{p_data_i[15:0]}};
            MEM_OPSIZE_WORD: m_data_w = p_data_i;
            default: m_data_w = 'x;
        endcase
    end

    logic [ADDR_ALIGN-1:0] m_wen_w;

    always_comb begin
        case (opsize_i) begin
            MEM_OPSIZE_BYTE: case (alignment_i) begin
                2'b00: m_wen_w = 4'b0001;
                2'b01: m_wen_w = 4'b0010;
                2'b10: m_wen_w = 4'b0100;
                2'b11: m_wen_w = 4'b1000;
                default: m_wen_w = 'x;
            endcase
            MEM_OPSIZE_HALF: case (alignment_i) begin
                2'b00: m_wen_w = 4'b0011;
                2'b10: m_wen_w = 4'b1100;
                default: m_wen_w = 'x;
            endcase
            MEM_OPSIZE_WORD: case (alignment_i) begin
                2'b00: m_wen_w = 4'b1111;
                default: m_wen_w = 'x;
            endcase
            default: m_wen_w = 'x;
        endcase
    end

    assign m_data_o = m_data_w;
    assign m_wen_o = m_wen_w;

endmodule