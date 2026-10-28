# Agent conventions — Dolunay

Dolunay is a RISC-V SIMT accelerator with Independent Thread Scheduling. The
RTL is SystemVerilog; the software around it is Python (cocotb testbenches,
runnable scripts, and the generators that produce RTL).

These are conventions, not a style guide. They describe what the codebase
already does, so that new code reads like the code around it. Where the
codebase is inconsistent, the rule given here is the one to follow.

**Read the neighbouring code first.** These notes are a summary of it, not a
replacement for it.

---

## Repository layout

| path | what is in it |
|---|---|
| `src/` | the RTL: modules, packages, and the generated control unit |
| `src/host/` | the host-side files (printf, memdump) used with the simulation |
| `pytb/` | the cocotb testbenches — one folder per testbench |
| `control_unit/` | the control-unit generator (`cugen` package) and its tests |
| `asm-kernels/`, `ss/` | RISC-V assembly kernels and the bare-metal runtime |
| `Bender.yml` | the manifest; `bender script flist` lists the sources |

`src/control_unit.sv` and `src/control_unit_pkg.sv` are **generated** from
`control_unit/control_unit.csv` by `control_unit/generate.py`. Do not edit
them by hand — change the CSV or the generator and regenerate.

---

## SystemVerilog

### File skeleton

Every RTL file opens with `` `default_nettype none `` and closes with
`` `default_nettype wire ``. This is in all 30 files in `src/`; keep it.

```systemverilog
`default_nettype none

// A short comment about what the module does.

module foo
    import params_pkg::*;
(
    input wire logic clk,
    ...
);

endmodule

`default_nettype wire
```

Packages use the same skeleton with `package foo_pkg;` / `endpackage`.

### Names

Modules and packages are `lower_snake_case`. Packages end in `_pkg`
(`params_pkg`, `core_pkg`, `control_unit_pkg`). Outside of `src/host/`, the
file name is the module name.

Signal suffixes are the project's own convention, and they are not negotiable —
the whole codebase depends on them:

| suffix | meaning |
|---|---|
| `_i` | input |
| `_o` | output — driven combinationally, or assigned straight from an `_r` of the same value |
| `_w` | combinational path (a "wire") |
| `_r` | flop / register |

So the state of a unit is `busy_r`, `pending_r`, `bank_r`, and its
combinational counterparts are `winner_w`, `success_w`, `addr_w`.

Types carry their own suffix: `logic [N_THREADS-1:0] simd_mask_t` for a type,
`typedef enum ... mem_opsize_e` for an enum, `typedef struct packed ...
fu_operation_s` for a struct. Enum *members* are `UPPER_SNAKE_CASE` and are
usually prefixed with the type's domain (`MEM_OPSIZE_BYTE`, `HAZARDS_IGN`,
`ALU_FUNCT_SLL`).

Parameters are `N_*` for counts (`N_THREADS`, `N_SPAD_BANKS`), `W_*` for
their widths (`W_THREADS = $clog2(N_THREADS)`), and `Z_*` for a shift amount
(`Z_ADDR = $clog2(ADDR_ALIGN)`).

Instance names are `u_<name>` (`u_lsu`, `u_fpnew`, `u_core_backend`).
Simulation-only signals and modules are prefixed `sim__` (`sim__disasm`,
`sim__runasserts_i`, `sim__instr_formatter.sv`).

### Style

- Declare signals as `logic`. Inputs are `input wire logic`, outputs are
  `output logic`.
- `always_comb` for combinational logic, `always_ff @(posedge clk)` for
  sequential logic. Never `always @*` or `always @(posedge clk or negedge rst)`.
- Sequential logic resets synchronously and active-low: `if (!rst_n)`.
- Use non-blocking assignment `<=` in `always_ff` and blocking `=` in
  `always_comb`.
- Loop variables are declared inline: `for (int i = 0; i < N; i++)`.
- `unique case` for case statements over an enum type.
- Cast with a sized type, not a bit width: `W_THREADS'(i)`, not `5'(i)`. A
  hardcoded width breaks the next time a parameter changes.
- Prefer `'0` / `'1` over a sized literal when the width is implied.

### Comments

Comments explain **why**, not what. The code already says what.

- `// TODO:` — something that has to be done.
- `// FIXME:` — something that is known to be wrong.
- `// INFO:` — a non-obvious fact a reader would otherwise have to derive.
- `// NOTE:` — a caveat about the code right there.

Use the section-banner style for the larger blocks, as in `src/fu_lsu.sv`:

```systemverilog
    // ---------------------------------------------------------------------------
    // Arbitration
    //
    // Every bank picks the lowest-numbered pending thread that targets it, so
    // all banks are served at the same time and the critical path does not
    // grow with the number of threads that conflict.
    // ---------------------------------------------------------------------------
```

### Assertions and synthesis

Simulation-only code goes inside `` `ifndef SYNTHESIS ``. This is required,
not optional: Vivado rejects an `assert` whose argument is not a constant
(`Synth 8-280`), and `control_unit.sv` needs a simulation-only
`sim__instr_formatter` that the synthesiser must not see.

```systemverilog
    `ifndef SYNTHESIS
    always_comb begin
        assert (!$isunknown(success_w))
            else $error("LSU success mask contains an unknown value");
    end
    `endif
```

`assert` for a property that must hold, `$error`/`$fatal` to report it.

`'x` is fine for a signal that is genuinely don't-care — a store's write-back
result, for instance. It is *not* fine where an unknown value reaches a
comparison that feeds a mask: Verilator is two-state, so `'x` collapses to `0`
and the comparison silently succeeds where it should not. Default such a
signal to `'0` and gate it on the condition that makes it valid.

### The synthesiser and the simulator must agree

Anything that changes timing — a registered read, a replay loop, a handshake —
has to be modelled in the reference model too, or the testbench is checking
something the hardware does not do. The scratchpad's registered read is the
canonical example; see `pytb/fu_lsu/lsu_model.py`.

---

## Python

### Typing

Every function is annotated, and the annotations are meant to be checked.
`pyrightconfig.json` sets `typeCheckingMode: "standard"`.

- Annotate parameters and return values. `-> None` on a function that returns
  nothing.
- Use `from __future__ import annotations` at the top of every module. It is
  in all six files under `pytb/`.
- Prefer precise types over `Any`. `list[int]` is not `list`.
- Model structured data with a `@dataclass`, not a tuple or a dict.
- Use `int | str | bool | None` style unions (PEP 604), not `Optional[X]` or
  `Union[X, Y]`.

### Enums over strings

A value that has a fixed set of possibilities is an `Enum`, never a bare
string compared with `==`.

```python
class Mode(Enum):
    """What the randomised test generates.

    It is a value a person types, so it is a string enum. The values are
    listed in testbench.toml as well, and the runner refuses anything else.
    """

    MIXED = "mixed"
    LOADS = "loads"
    STORES = "stores"
```

Use `IntEnum` when the value is a number the RTL also uses — `MemOpsize`,
`MemLoadstore` and `MemExtendmode` in `pytb/fu_lsu/lsu_model.py` mirror the
`control_unit_pkg` enums exactly, which is what lets the harness hand the
values over unchanged.

The values of an enum a person types are lowercase; the members are
`UPPER_SNAKE_CASE`. When a testbench declares an option, the enum and the
`testbench.toml` list the same values, and the runner rejects anything else.

### Modules and structure

- Keep each module to one job. The reference model, the testbench and the
  harness are three separate files, not one.
- A testbench is a folder: the test module, its model, its harness and a
  `testbench.toml` that says what it is. See `pytb/README.md`.
- A runnable script has a `main()` and the
  `if __name__ == "__main__":` guard.
- Name things for what they are: `spad_bank_of`, not `get_bank`.

### Docstrings and comments

Every module opens with a docstring that says what it is, what it is for, and
anything a caller needs to know before using it. Every function has a
one-line docstring unless its name and signature say it all.

```python
def spad_bank_of(addr: int) -> int:
    """The bank a byte address belongs to."""
```

Comments explain **why**. The code already says what.

### Style

- 4-space indent, `snake_case` for functions and variables, `UPPER_CASE` for
  module-level constants.
- `pathlib.Path`, not `os.path`.
- f-strings for formatting.
- `ruff check` and `ruff format` are the tools; keep the tree clean.
  `ruff check pytb/` currently passes.

### Testbenches

The conventions below are what the testbenches follow:

- **Drive on the falling edge, sample on the falling edge.** Nothing then
  races with the clock edge.
- A request is driven on a falling edge and released on the falling edge
  after the edge that accepted it, so it is presented for exactly one cycle
  and can never be accepted twice.
- **Every test gets a timeout**, so a stuck DUT fails instead of hanging the
  run: `@cocotb.test(timeout_time=100, timeout_unit="us")`.
- In cocotb 2.x the clock starts itself — `Clock(...).start()`, never
  `start_soon(clock.start())`.
- A randomised test takes its seed from the command line and prints it, so a
  failure can be reproduced.
- The model is written out independently of the RTL it models. A model that
  reuses the RTL's own code cannot catch a mistake in that code.
- The test checks that the parameters of the design are the ones the model
  assumes, and stops there if they are not. Everything after that check would
  otherwise be meaningless.

---

## Making changes

- Keep a change focused. If a fix touches a file it does not need to touch,
  that is a separate change.
- Do not reformat code you are not otherwise changing. The tree has mixed
  indentation in places; leave it alone unless the file is yours.
- Do not commit or push unless asked.
- Say what you ran. If a test could not be run, say so — a claim of "passes"
  that was not verified is worse than no claim.
- When something is unclear or a convention does not cover the case, prefer
  the convention that the surrounding code follows, and say so in the summary.
