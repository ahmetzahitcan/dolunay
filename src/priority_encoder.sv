module priority_encoder #(
    parameter int WIDTH = 32,
    parameter int FROM_MSB = 0,
    localparam int LOG_WIDTH = $clog2(WIDTH)
) (
    input logic [WIDTH-1:0] input_i,
    output logic [WIDTH-1:0] one_hot_o,
    output logic [LOG_WIDTH-1:0] index_o,
    output logic valid_o
);

always_comb begin
    valid_o = 1'b0;
    one_hot_o = '0;
    index_o = '0;
    if (FROM_MSB) begin
        for (int i = WIDTH-1; i >= 0; i--) begin
            if (input_i[i]) begin
                valid_o = 1'b1;
                one_hot_o[i] = 1'b1;
                index_o = i;
                break;
            end
        end
    end else begin
        for (int i = 0; i < WIDTH; i++) begin
            if (input_i[i]) begin
                valid_o = 1'b1;
                one_hot_o[i] = 1'b1;
                index_o = i;
                break;
            end
        end
    end
end

endmodule