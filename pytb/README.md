# pytb — the cocotb testbenches

The Python testbenches. The SystemVerilog testbenches in `tb/` are still
there and still work; this directory is where the cocotb versions go.

Each testbench has a folder of its own, with everything it needs in it:

```
pytb/
  run.py                  the only entry point: it finds and runs the testbenches
  requirements.txt        the packages that go into the virtualenv
  demo/
    testbench.toml        what the testbench is and what it is built from
    demo.sv               a small DUT
    test_demo.py          the testbench for it
  fu_lsu/
    testbench.toml
    tb_fu_lsu_cocotb.sv   the harness of the load/store unit testbench
    lsu_model.py          the reference model of the load/store unit
    test_fu_lsu.py        the load/store unit testbench
```

`demo` is an example: the smallest testbench that shows the conventions of
this project. `fu_lsu` is the cocotb version of `tb/tb_fu_lsu.sv`, the
load/store unit testbench.

A folder with a `testbench.toml` in it *is* a testbench: `run.py` finds them
by looking for the file, so a new testbench is a new folder and nothing
else.

The metadata says what the testbench is, what it is built from, and what
options it takes:

```toml
name = "fu_lsu"                    # defaults to the name of the folder
description = "the load/store unit"
toplevel = "tb_fu_lsu_cocotb"      # the HDL top module
module = "test_fu_lsu"             # the Python module the tests are in
sources = ["tb_fu_lsu_cocotb.sv"]  # its own files
autorun = true                     # run it when running all of them

[options]
mode = { type = "str", default = "mixed", values = ["mixed", "loads"], help = "what it generates" }
```

The type is `int`, `str` or `flag`, and the values, when there are any,
are the ones the option accepts.

The keys of the testbench come **before** the tables, because that is how
TOML works: a key after a table header belongs to that table.

## Setting it up

It is done once per machine.

**cocotb** goes into a virtualenv, `.venv` in the project:

```sh
python3 -m venv .venv
.venv/bin/pip install -r pytb/requirements.txt
```

A virtualenv is the way around PEP 668, which makes the Python of some
distributions refuse a `pip install` into it. Putting it in the project is
what makes the editor's language server and the other Python tools find
cocotb without being told: `.venv` is where they look for it by default.
`pyrightconfig.json` says so explicitly as well.

The virtualenv is per-machine state, so it is not version controlled; it is
in `.gitignore`. If the project lives on a slow filesystem — a Windows one,
say — put the virtualenv somewhere else and point the tools at it:

```sh
python3 -m venv ~/venvs/dolunay-cocotb
~/venvs/dolunay-cocotb/bin/pip install -r pytb/requirements.txt
DOLUNAY_COCOTB_VENV=~/venvs/dolunay-cocotb python3 pytb/run.py
```

and tell the language server about it in `pyrightconfig.json`:

```json
{ "venvPath": "/home/you/venvs", "venv": "dolunay-cocotb" }
```

`requirements.txt` pins cocotb exactly, because the testbenches are written
against its API and a new major version can change it.

**Verilator** has to be 5.036 or later for cocotb 2.x: its `verilator.cpp`
uses VPI entry points that do not exist in the older ones, and the compile
fails with "is not a member of 'VerilatedVpi'". If the Verilator of the
distribution is new enough there is nothing to do; if it is not, unpack a
newer one and point `DOLUNAY_VERILATOR` at it (see below). The
SystemVerilog testbenches in `tb/` are verified against the Verilator of
the distribution, so it is left alone.

**Bender** manages the checkouts under `.bender/`, and the load/store unit
testbench needs the fpnew package from there. `bender update` refreshes it.

### The environment variables

| variable | what it does | default |
|---|---|---|
| `DOLUNAY_COCOTB_VENV` | the virtualenv cocotb is in | `.venv` in the project |
| `DOLUNAY_VERILATOR` | a Verilator to use instead of the one on the `PATH` | the one on the `PATH` |
| `DOLUNAY_BUILD_DIR` | where the build trees go | `~/dolunay-sim` |

`DOLUNAY_VERILATOR` may point at a directory that holds the binary, either
as `<dir>/bin/verilator` or as `<dir>/usr/bin/verilator`, which is how an
unpacked Debian package is laid out.

The build trees are kept outside the project because GNU Make misbehaves
when the directory it builds in has a space in its path — and the project
may well live under such a path.

A build tree belongs to the toolchain it was made with: the makefile
Verilator generates points at the cocotb sources of the virtualenv. So the
runner writes down which toolchain it was, and throws the tree away and
builds it again when that changes — after a new virtualenv, or a new
Verilator. `python3 pytb/run.py --clean` removes the trees.

## Running

```sh
python3 pytb/run.py                # every testbench
python3 pytb/run.py fu_lsu         # one of them
python3 pytb/run.py demo fu_lsu    # some of them
python3 pytb/run.py --list         # what is there
```

```
** test_fu_lsu.test_load_one_thread_per_bank   PASS       10365.00  **
** test_fu_lsu.test_load_bytes_and_halves      PASS       10425.00  **
** test_fu_lsu.test_all_threads_on_one_bank    PASS       10675.00  **
** test_fu_lsu.test_store_then_read_back       PASS       10425.00  **
** test_fu_lsu.test_byte_store                 PASS       10425.00  **
** test_fu_lsu.test_random_operations          PASS      366135.00  **
** test_fu_lsu.test_byte_and_half_stores       PASS       73665.00  **
** test_fu_lsu.test_back_pressure              PASS       10415.00  **
** TESTS=8 PASS=8 FAIL=0 SKIP=0
```

The script re-runs itself with the virtualenv's interpreter when it is
started with another one, so the virtualenv does not have to be activated
first. It exits with a non-zero status when a test fails.

| option | what it does |
|---|---|
| `--list` | list the testbenches and exit |
| `--waves` | dump a waveform trace into the build tree |
| `--clean` | remove the build trees and exit |
| `--runall` | run all the testbenches, even those with `autorun = false` |
| `-v` | say what the tools are doing |

The options of a testbench are worked out from its metadata, and they are
named after it, so that the options of two testbenches do not collide:

```sh
python3 pytb/run.py fu_lsu --fu_lsu+mode loads     # loads only
python3 pytb/run.py fu_lsu --fu_lsu+seed 1234      # a reproducible run
python3 pytb/run.py fu_lsu --fu_lsu+readback       # read every touched word back
```

`python3 pytb/run.py --help` lists the options of every testbench.

The randomised test of the load/store unit testbench is the bisection
tool, and it is what makes a failure findable:

| `--fu_lsu+mode` | what it generates |
|---|---|
| `mixed` | loads and stores mixed (the default) |
| `loads` | loads only |
| `stores` | stores only |
| `single` | single threaded |
| `word` | word sized |

The mode is a set of names, not numbers, because it is something a person
types. The values are declared in the metadata of the testbench, and the
testbench has an enum for them:

```python
class Mode(Enum):
    MIXED = "mixed"
    LOADS = "loads"
    ...
```

The seed is printed at the start of the run, so a failure can be
reproduced.

### How an option reaches the testbench

The runner hands the options over in the environment, one variable each,
named after the testbench and the option: `DOLUNAY_FU_LSU_MODE` for
`--fu_lsu+mode`. The testbench reads them with the same rule, in
`fu_lsu/test_fu_lsu.py`:

```python
TESTBENCH = os.environ.get("DOLUNAY_TESTBENCH", "fu_lsu")

def option(name: str, default: str = "") -> str:
    return os.environ.get(f"DOLUNAY_{TESTBENCH.upper()}_{name.upper()}", default)
```

## How the load/store unit testbench is put together

- `fu_lsu/tb_fu_lsu_cocotb.sv` is the harness. It holds the LSU and the real
  scratchpad together, so the scratchpad's registered read is part of what
  is being tested. The scratchpad is written by the LSU, except while the
  testbench fills it with the initial pattern: cocotb cannot drive a wire
  that the RTL also drives, so the mux in front of the LSU's outputs stays
  in the harness.
- `fu_lsu/lsu_model.py` is the reference model: the address decode, the
  store and the load formatting, and the arbitration. It does not use any
  of the LSU's RTL, including the formatters, so a mistake in those is
  caught as well.
- `fu_lsu/test_fu_lsu.py` is the testbench: the eight test groups of the
  SystemVerilog testbench, one cocotb test each.

### The packed structs

The operation and the result are packed structs, and only SystemVerilog
knows where their fields are. So the **harness** packs and unpacks them,
and the testbench talks in the fields it cares about — the mask, the
addresses, the size of the access:

```systemverilog
    input  wire seq_t               op_seq,
    input  wire simd_mask_t         op_mask,
    input  wire simd_data_t         op_rs1,
    input  wire logic [RLEN-1:0]    op_imm,
    input  wire mem_opsize_e        op_mem_opsize,
```

The harness names the fields of the struct, so a change of the struct is a
change of the harness, and the compiler says so. The testbench and the
model know nothing about the layout, and a field that is added, moved or
widened needs no change in them at all.

What is left of the layout is how a thread's data is laid out in a
`simd_data_t`, which is a packed array: thread *i* is in the bits
`[i*RLEN +: RLEN]`.

### The parameters of the design

The model is a model of a particular design, so the parameters of that
design — `RLEN`, `N_THREADS`, `N_SPAD_BANKS`, `SPAD_BANK_DEPTH` and
`ADDR_ALIGN` — have to be the ones the model has. The harness gives them
to the testbench, which checks them before anything else:

```
AssertionError: RLEN is 64, the model thinks it is 32
```

It is a precondition and not a check: if the parameters are not the ones
the model has, the model is not a model of this design, and every check
that follows would be meaningless. So the test stops there.

## Writing a testbench

**Drive on the falling edge, sample on the falling edge.** Nothing then races
with the clock edge. This is the convention the SystemVerilog testbenches in
`tb/` use, so the two kinds of testbench can be read side by side.

A request is driven on a falling edge and released on the falling edge after
the clock edge that accepted it, so it is presented for exactly one cycle and
can never be accepted twice:

```python
await FallingEdge(dut.clk)
dut.in_valid_i.value = 1
while not int(dut.in_ready_o.value):   # in_ready_o only changes at a rising edge
    await FallingEdge(dut.clk)
await RisingEdge(dut.clk)               # the request is accepted at this edge
await FallingEdge(dut.clk)              # the result is presented in this cycle
dut.in_valid_i.value = 0
```

**Give every test a timeout**, so that a stuck DUT fails instead of hanging
the run:

```python
@cocotb.test(timeout_time=100, timeout_unit="us")
```

and use `with_timeout` around the waits in the helpers.

**In cocotb 2.x the clock starts itself.** `Clock.start()` schedules the
driver task and returns it, so it must not be handed to `start_soon()` as
well:

```python
clock = Clock(dut.clk, 10, unit="ns")
clock.start()
```

**A testbench is a folder.** The test module, the harness and the model go
into a folder of their own, and the folder has a `testbench.toml` in it that
says what the testbench is:

| key | what it is |
|---|---|
| `name` | the name it is selected by; the name of the folder by default |
| `description` | what it is, shown in the list of the testbenches |
| `toplevel` | the HDL top module |
| `module` | the Python module the tests are in |
| `sources` | the files of the testbench itself, relative to its folder |
| `project_sources` | the project's files, relative to the project root |
| `bender_sources` | the files of the Bender checkouts, matched by the end of their path |

The folder is put on the import path of the simulator, so the test module
and the model it imports are found next to each other, and they import each
other as top level modules.
