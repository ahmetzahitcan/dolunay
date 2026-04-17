`default_nettype none

module hpms
    import params_pkg::*;
    import control_unit_pkg::*;
(
    input wire logic clk,
    input wire logic rst_n,
    input wire logic [N_WARPS-1:0] winst_retired_i,
    input wire logic [N_WARPS-1:0][N_THREADS-1:0] inst_retired_i,
    output logic [63:0] cycletime_o,
    output logic [N_WARPS-1:0][N_THREADS-1:0][63:0] instret_o,
    output logic [N_WARPS-1:0][63:0] wtinstret_o,
    output logic [N_WARPS-1:0][63:0] wuinstret_o
);
    // cycletime
    logic [63:0] cycletime_r;
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            cycletime_r <= '0;
        end else begin
            cycletime_r <= cycletime_r + 1'b1;
        end
    end

    // instret
    logic [N_WARPS-1:0][N_THREADS-1:0][63:0] instret_r;
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            instret_r <= '0;
        end else begin
            for (int I = 0; I < N_WARPS; I++) begin
                for (int J = 0; J < N_THREADS; J++) begin
                    instret_r[I][J] <= instret_r[I][J] + inst_retired_i[I][J];
                end
            end
        end
    end

    // wtinstret
    logic [N_WARPS-1:0][63:0] wtinstret_r;
    logic [N_WARPS-1:0][W_THREADS:0] wtinstret_increment_w;
    always_comb begin
        for (int I = 0; I < N_WARPS; I++) begin
            wtinstret_increment_w[I] = $countones(inst_retired_i[I]);
        end
    end

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            wtinstret_r <= '0;
        end else begin
            for (int I = 0; I < N_WARPS; I++) begin
                `ifndef SYNTHESIS
                    if (winst_retired_i[I]) begin
                        assert (wtinstret_increment_w[I] != 0) else $error("winst_retired_i[%d]==1 but inst_retired_i[%d]==0", I, I);
                    end else begin
                        assert (wtinstret_increment_w[I] == 0) else $error("winst_retired_i[%d]==0 but inst_retired_i[%d]==%d", I, I, $countones(inst_retired_i[I]));
                    end
                `endif
                wtinstret_r[I] <= wtinstret_r[I] + wtinstret_increment_w[I];
            end
        end
    end

    // wuinstret
    logic [N_WARPS-1:0][63:0] wuinstret_r;
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            wuinstret_r <= '0;
        end else begin
            for (int I = 0; I < N_WARPS; I++) begin
                wuinstret_r[I] <= wuinstret_r[I] + winst_retired_i[I];
            end
        end
    end

    assign cycletime_o = cycletime_r;
    assign instret_o = instret_r;
    assign wtinstret_o = wtinstret_r;
    assign wuinstret_o = wuinstret_r;

endmodule

`default_nettype wire