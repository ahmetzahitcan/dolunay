# The testbenches that do not work any more

They are here rather than in `tb/`, because they do not build or run against
the current RTL. Nothing in the project uses them; they are kept for the
history, and they are the ones to look at when the RTL is brought back into
shape.

Each one says what has changed, so that whoever picks it up does not have to
work it out from the error message.

| testbench | what has changed |
|---|---|
| `tb_branch.sv` | it reads the branch unit out of the core with `dut.u_bju` and `dut.operation_w`, and the function units now live in `core_middleend.sv`, not in the top level |
| `tb_core_frontend.sv` | it reads `dut.ra_pc_r` out of the front end, and that signal is gone |
| `tb_scoreboard.sv` | the scoreboard does not have a `backend_warp_id_i` port any more |
| `tb_scoreboard_mask.sv` | the model of the masked scoreboard, used by `tb_core_frontend.sv` above |

The run scripts come with them. `run_branch.sh` also needs the riscv
toolchain, and it builds with `bender.verilator` — a generated file, which
has to be in the order `tb/common.sh` writes it in, because the packages
have to come before the files that use them.

## The ones that do work

| testbench | what it checks |
|---|---|
| `tb_fu_lsu.sv` | the load/store unit, against a reference model |
| `tb_register_file.sv` | the SIMD register file, ten spec sections |
| `tb_core_middleend.sv` | the middle end, 70 checks |
| `tb_core_top.sv` | a smoke test of the whole core: that the program runs and the number of committed instructions is the expected one |

`tb_fu_lsu.sv` has a cocotb version in `pytb/fu_lsu/`.
