# cocotb testbenches

The new testbenches. The SystemVerilog testbenches in `tb/` are still there
and still work; this directory is where the cocotb versions go.

At the moment there is only a **mock** testbench: a toy DUT and the testbench
that drives it. Its job is to prove out the flow — the tools, the paths, the
timing conventions — before the real RTL is converted.

| file | what it is |
|---|---|
| `setup.sh` | prepares the environment (virtualenv + Verilator) |
| `requirements.txt` | the packages that go into the virtualenv |
| `common.sh` | shared helpers: the environment, the makefile copy |
| `Makefile` | the cocotb build |
| `run_mock.sh` | runs the mock testbench |
| `rtl/mock_lsu.sv` | the toy DUT |
| `tests/test_mock_lsu.py` | the testbench for the toy DUT |

## Running it

Everything runs in WSL:

```sh
cd "/mnt/c/Users/azc/OneDrive - Yildiz Technical University/Belgeler/dolunay"
sh cocotb/setup.sh      # once
sh cocotb/run_mock.sh
```

```
** test_mock_lsu.test_reset_state                     PASS          35.00  **
** test_mock_lsu.test_store_then_load                 PASS          75.00  **
** test_mock_lsu.test_read_of_untouched_word          PASS          55.00  **
** test_mock_lsu.test_back_to_back_transactions       PASS         195.00  **
** test_mock_lsu.test_backpressure_holds_the_result   PASS         115.00  **
** TESTS=5 PASS=5 FAIL=0 SKIP=0
```

`sh cocotb/run_mock.sh --wave` also writes `cocotb/dump.vcd`.
Any other argument is passed on to `make`, e.g.
`sh cocotb/run_mock.sh COCOTB_LOG_LEVEL=DEBUG`.

## The environment

Two things are needed that the distribution does not provide.

**cocotb** is installed in a virtualenv, `~/venvs/dolunay-cocotb`. The
distribution Python is externally managed (PEP 668), so `pip install` into it
is refused. `setup.sh` creates the virtualenv and installs cocotb into it.
The runner scripts put the virtualenv on the `PATH`, because cocotb's
makefiles call `cocotb-config` and `python3` to find the bindings.

**Verilator** has to be 5.036 or later for cocotb 2.x. Ubuntu 24.04 ships
5.020, which is too old — cocotb's `verilator.cpp` uses VPI entry points that
only exist in the newer one. `setup.sh` unpacks Debian's Verilator 5.048 into
`~/tools/verilator-5.048`; the runner scripts put it in front of the `PATH`.
The distribution Verilator is left alone, because the SystemVerilog
testbenches in `tb/` are verified against it.

Both can be pointed elsewhere:

```sh
DOLUNAY_COCOTB_VENV=/some/venv DOLUNAY_VERILATOR=/some/verilator sh cocotb/run_mock.sh
```

### Why the virtualenv is not in the repository

The virtualenv is per-machine state and is never version controlled, so it
does not belong in the repository. The repository is also on a Windows
filesystem, which is a bad place for it: a cocotb virtualenv is 2082 files
and 44 MB, and copying it onto the OneDrive drive takes 79 s against 1.1 s
for the Linux filesystem — every install and every import is slow there.

What *is* in the repository is the list of packages that goes into the
virtualenv, `requirements.txt`, so a fresh clone plus `sh cocotb/setup.sh`
gives the same environment. `cocotb` is pinned exactly, because the
testbenches are written against its API and a new major version can change
it.

The toolchain this was last verified with:

| | version |
|---|---|
| Python | 3.12.3 (WSL) |
| cocotb | 2.1.0 |
| Verilator | 5.048 (unpacked) |

## The two problems with the path, and what is done about them

The project lives under `OneDrive - Yildiz Technical University`, so the path
contains spaces. Two things break because of that, and they need different
answers.

**Verilator is invoked with the source list on the command line**, where a
space would split a path in two. The sources are therefore given as paths
relative to `cocotb/`, which contain no spaces. This is the same trick
`tb/common.sh` uses with its `-F` file lists.

**GNU Make misbehaves in a directory whose path contains spaces** (this is
what `verilated.mk` trips over). The build tree therefore lives outside the
project, in `~/dolunay-sim`, next to the one `tb/common.sh` uses. The
`cocotb/Makefile` itself is run through a copy with LF line endings, because
the project is on a Windows filesystem where the line endings are CRLF, and
GNU Make does not strip the CR either: a recipe line would end up being
`make sim\r`. The copy is made outside the project, so the tracked file is
never touched. See `common.sh`.

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

## What is next

The real testbench: converting `tb/tb_fu_lsu.sv` to cocotb. The model, the
timing contract, the struct bit layouts and the test groups are all written
down in `HANDOFF_COCOTB.md`; that document is the specification for the
conversion, and it should be followed closely — in particular the two model
bugs it describes in §6, which both looked like RTL bugs.

The flow has already been checked against the real RTL: the `fu_lsu` and the
files it needs compile and link through it, with the file list that
`tb/common.sh` generates from Bender. Two things are worth knowing about
that:

- the file list is given to Verilator with `-F`, and the entries in it are
  relative to the file list's own directory, so they contain no spaces. The
  same list works from `cocotb/`, it just needs the path `../sim/xxx.f`;
- Verilator treats warnings as fatal, so `-Wno-fatal` is in `COMPILE_ARGS`,
  like in the SystemVerilog flow.
