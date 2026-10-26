# Handoff — converting the LSU testbench to cocotb

**Date:** 2026-10-25
**Branch:** `ooo-lite`, HEAD `0f0d6dd` ("Integrate LSU and scratchpad into the core")
**Task for the next agent:** replace `tb/tb_fu_lsu.sv` (SystemVerilog) with a
cocotb testbench, without losing coverage.

> **Update (2026-10-26): the conversion is done.** The cocotb testbench is
> in `pytb/`, the SystemVerilog one is still there and still passes, and
> §11 below says what was built, what was found on the way, and what is
> still open. The rest of this document is the specification the conversion
> was made against, and it still describes the design.

---

## 0. Where things stand

The LSU is **complete and verified**. `fu_lsu` used to be a skeleton — it drove
none of its outputs, never read the scratchpad data, and never completed an
operation. It now has:

- parallel bank arbitration (one thread per bank per cycle, losers replayed),
- a write path that gathers the winner's data by index,
- a read path that muxes on each thread's own bank select, with a **registered**
  select because the scratchpad's read is registered,
- a valid/ready handshake and an internal replay loop.

It is instantiated in `core_middleend` (the `FUNCTION_UNIT_LSU` slot that was
already reserved for it) and the scratchpad is instantiated in `core_top`.

Commits on `ooo-lite`, in order:

| commit | what |
|---|---|
| `590a67e` | Fix sim flow for paths containing spaces |
| `d1b1d7f` | Use blocking assignment in register file sim init |
| `c26b67c` | Record LSU design decisions in the roadmap |
| `d6e9373` | Use the project naming convention in the LSU roadmap |
| `053fca6` | Implement LSU datapath and bank replay |
| `0e5e825` | Add LSU testbench |
| `0f0d6dd` | Integrate LSU and scratchpad into the core |

`LSU_ROADMAP.md` has the design decisions and the bank-mapping derivation.

**Current results** (all must keep passing):

| testbench | result |
|---|---|
| `tb/run_fu_lsu.sh` | 44,732 checks, 0 failures |
| `tb/run_core_middleend.sh` | 70 checks, 0 failures |
| `tb/run_core_top.sh` | PASS — `dispatched=19807 collected=19806 committed=19803` |

---

## 1. The files that matter

| file | role |
|---|---|
| `src/fu_lsu.sv` | the DUT |
| `src/scratchpad.sv` | 32 banks × 1024 words × 32 bit, one `ram` per bank |
| `src/ram.sv` | one bank: a **registered** read (`rdata_r <= mem_r[addr_i]`) |
| `src/mem_read_formatter.sv` | byte/half/word extraction and sign/zero extension |
| `src/mem_write_formatter.sv` | byte/half/word formatting and byte enables |
| `src/params_pkg.sv` | the bank mapping: `spad_bank_of`, `spad_offset_of` and the field functions |
| `tb/tb_fu_lsu.sv` | the testbench to be converted |
| `tb/run_fu_lsu.sh` | builds and runs it |
| `tb/tb_layout.sv` | prints the bit layout of the packed structs (see §3) |
| `tb/common.sh` | shared file-list and build helpers |

---

## 2. The DUT interface

```systemverilog
module fu_lsu (
    input  logic clk, rst_n,
    input  logic        in_valid_i,
    output logic        in_ready_o,
    input  fu_operation_s in_operation_i,
    output logic        out_valid_o,
    input  logic        out_ready_i,
    output fu_result_s  out_result_o,
    output logic [31:0][11:2] spad_addr_o,     // 32 banks, 10-bit word offset
    output logic [31:0][31:0] spad_wdata_o,
    output logic [31:0][3:0]  spad_wen_o,      // byte enables
    input  logic [31:0][31:0] spad_rdata_i
);
```

`fu_operation_s` and `fu_result_s` are **packed structs**, so cocotb sees them
as one wide vector. The bit layouts are in §3.

The scratchpad (`src/scratchpad.sv`) is instantiated next to the LSU in the
current testbench, with the LSU's outputs muxed against a testbench-driven
initializer so the memory can be filled with a known pattern before the test
starts. In cocotb you cannot drive a wire that the RTL also drives, so **keep
that mux** (it is about ten lines of SV) and let Python flip `init_mode` to
fill the memory and then hand the ports to the LSU. The alternative — filling
the memory with stores — is far too slow.

---

## 3. The struct bit layouts

Regenerate with:

```sh
cd sim && verilator --binary --timing -Wno-fatal --top-module tb_layout \
    --Mdir "$HOME/dolunay-sim/layout" -o layout -f lsu.f ../tb/tb_layout.sv
"$HOME/dolunay-sim/layout/layout"
```

**If any struct changes, regenerate this.** The cocotb testbench hardcodes
these offsets.

### `fu_operation_s` — 3751 bits

| field | bits |
|---|---|
| `seq` | [3750:3748] |
| `warp_id` | [3747:3745] |
| `instr` | [3744:3134] |
| `pc` | [3133:3104] |
| `mask` | [3103:3072] |
| `rs1_data` | [3071:2048] |
| `rs2_data` | [2047:1024] |
| `rs3_data` | [1023:0] |

`rs1_data`/`rs2_data`/`rs3_data` are `simd_data_t` = 32 threads × 32 bits,
thread *i* in bits `[i*32 +: 32]`.

### `fu_result_s` — 2920 bits

| field | bits |
|---|---|
| `seq` | [2919:2917] |
| `warp_id` | [2916:2914] |
| `instr` | [2913:2303] |
| `pc` | [2302:2273] |
| `mask` | [2272:2241] |
| `use_uwb` | [2240:2239] |
| `wb_result` | [2238:1215] |
| `uwb_result` | [1214:1183] |
| `csrw_result` | [1182:159] |
| `fpu_status` | [158:0] |

### `instr_s` — 611 bits

| field | bits | | field | bits |
|---|---|---|---|---|
| `sim__disasm` | [610:99] | | `fu_sel` | [31:29] |
| `imm` | [98:67] | | `csrr_src` | [28:28] |
| `rd_idx` | [66:62] | | `csrw_method` | [27:27] |
| `rs1_idx` | [61:57] | | `fflags_update` | [26:26] |
| `rs2_idx` | [56:52] | | `alu_funct` | [25:22] |
| `rs3_idx` | [51:47] | | `alu_addy_funct` | [21:19] |
| `fpu_roundmode` | [46:44] | | `alu_op1_sel` | [18:18] |
| `rd_used` | [43:43] | | `alu_op2_sel` | [17:17] |
| `rd_regfile` | [42:42] | | `fpu_opcode` | [16:13] |
| `rs1_used` | [41:41] | | `fpu_op_modifier` | [12:12] |
| `rs1_regfile` | [40:40] | | `fpu_op0_sel` | [11:11] |
| `rs2_used` | [39:39] | | `fpu_op1_sel` | [10:10] |
| `rs2_regfile` | [38:38] | | `fpu_op2_sel` | [9:9] |
| `rs3_used` | [37:37] | | `bj_type` | [8:6] |
| `rs3_regfile` | [36:36] | | `mem_active` | [5:5] |
| `hazards` | [35:32] | | `mem_loadstore` | [4:4] |
| | | | `mem_opsize` | [3:2] |
| | | | `mem_extendmode` | [1:1] |

**`sim__disasm` only exists under `` `ifndef SYNTHESIS ``.** It is present in
simulation (and therefore in cocotb) and absent in synthesis, so the layout
above is the simulation one. If the cocotb testbench is ever run against a
synthesis build, every `instr_s` offset shifts by 512.

Enum values the testbench needs:

| enum | values |
|---|---|
| `mem_opsize_e` | `MEM_OPSIZE_BYTE`=0, `MEM_OPSIZE_HALF`=1, `MEM_OPSIZE_WORD`=2 |
| `mem_loadstore_e` | `MEM_LOADSTORE_LOAD`=0, `MEM_LOADSTORE_STORE`=1 |
| `mem_extendmode_e` | `MEM_EXTENDMODE_SIGN`=0, `MEM_EXTENDMODE_ZERO`=1 |
| `function_unit_e` | `FUNCTION_UNIT_LSU`=4 |

---

## 4. The timing contract

This is the part that is easy to get wrong, because the scratchpad's read is
registered.

- The operation is **accepted** at the clock edge where
  `in_valid_i && in_ready_o`. `in_ready_o` is low while the LSU is busy, i.e.
  from the accept until the result has been taken.
- The **first arbitration cycle** is the cycle *after* the accept edge. In
  that cycle the LSU drives the scratchpad addresses.
- The scratchpad returns the word addressed in cycle *N* in cycle *N+1* (the
  RAM's read is registered).
- The last thread's data is therefore collected at the edge ending the cycle
  after the last arbitration cycle, and `out_valid_o` rises one cycle after
  that.

In one line: **if the operation needs `n_arb` arbitration cycles, the result
is valid `n_arb + 2` cycles after the accept edge.**

`n_arb` is the number of cycles the arbitration needs, which is the maximum
number of pending threads that land on any one bank (see §5.3). The current
testbench measures the latency as the number of negedges from the first
negedge after the accept, so it compares against `n_arb + 2`.

The result is held stable while `out_ready_i` is low, and `out_valid_o` stays
high.

---

## 5. The model — exactly what to reimplement

The reference model must not reuse the DUT's RTL, including the formatters,
otherwise a mistake in them is not caught.

### 5.1 The address decode

```
addr   = (rs1_data[i] + imm) & 0xFFFFFFFF      # 32-bit wrap
bank   = A ^ B ^ L                              # see below
offset = (addr >> 2) & 0x3FF                    # 10 bits
align  = addr & 0x3                              # 2 bits
```

The word address `w = addr >> 2` is 15 bits, split into three 5-bit fields:

```
A = (addr >> 12) & 31      # addr[16:12]   region
B = (addr >> 7)  & 31      # addr[11:7]
L = (addr >> 2)  & 31      # addr[6:2]
bank = A ^ B ^ L
```

This is the mapping in `params_pkg.sv` (`spad_bank_of`, `spad_offset_of`); the
derivation and the measurements are in `LSU_ROADMAP.md` §9.

### 5.2 The store formatting

`mem_write_formatter` turns the thread's data into the 32-bit word the RAM
sees, and the byte enables say which lanes are written.

| size | word contents | byte enables |
|---|---|---|
| byte | `data[7:0]` in **every** lane | one lane, at the align |
| half | `data[15:0]` in lanes 0,1 **and** in lanes 2,3 (the half is replicated into both halves of the word) | lanes 0,1 (align 0) or 2,3 (align 2) |
| word | the data as it is | all four lanes |

So the byte that lands in lane *j* is:

| size | lane *j* |
|---|---|
| byte | `data[7:0]` for every *j* |
| half | `data[(j % 2) * 8 +: 8]` |
| word | `data[j*8 +: 8]` |

**This is where the current testbench's model was wrong twice, and both bugs
looked like RTL bugs.** See §6.

### 5.3 The arbitration

```
pending = mask
cycles = 0
while pending:
    cycles += 1
    for each bank b:
        winner = the lowest-numbered pending thread whose address maps to b
        serve winner            # a store writes here, a load reads here
        pending -= {winner}
```

One thread per bank per cycle; the lowest thread index wins. The threads that
lost are retried in the following cycles.

### 5.4 The load formatting

The scratchpad returns the whole 32-bit word; the thread takes the part its
alignment selects, and extends it.

| size | align | value |
|---|---|---|
| byte | 0/1/2/3 | `word[7:0]` / `word[15:8]` / `word[23:16]` / `word[31:24]` |
| half | 0 | `word[15:0]` |
| half | 2 | `word[31:16]` |
| word | 0 | `word[31:0]` |

Then sign-extend if `mem_extendmode` is `SIGN`, otherwise zero-extend.

**The valid (size, alignment) combinations are only**: byte with any alignment,
half with alignment 0 or 2, word with alignment 0. Anything else is `'x` in the
formatters — do not generate them.

### 5.5 What the DUT returns

- `out_result_o.mask` is the operation's mask (every thread eventually
  succeeds).
- `out_result_o.wb_result` is the loaded value per thread, `'x` for a store.
- `out_result_o.instr` is the instruction the LSU latched, which must be the
  one the operation was issued with.

---

## 6. Two bugs the model got wrong — do not repeat them

Both of these produced failures that looked exactly like RTL bugs, and both
were in the *model*.

1. **The half store.** The formatted half is `{2{data[15:0]}}`, so lane 1 gets
   `data[15:8]`, not `data[7:0]`. A model that returns `data[7:0]` for both
   lanes looks right and is wrong.
2. **The half store at alignment 2.** The half is replicated into *both*
   halves of the word, so lane 2 gets `data[7:0]` and lane 3 gets `data[15:8]`
   — not `data[23:16]` and `data[31:24]`.

The general lesson: the model has to mirror the *formatters*, not the
architecture's intuition about what a half store means. Both of these were
found by running the randomised test as loads-only, stores-only,
single-threaded and word-sized, and seeing which combination failed. **Keep
that ability to bisect in the cocotb testbench** — it is what made these
findable in minutes rather than hours.

---

## 7. The test groups to reproduce

The current testbench has eight groups. All of them should survive the
conversion.

| # | what it covers |
|---|---|
| 1 | load, one thread per bank — the easy case |
| 2 | load of bytes and of halves, with sign and zero extension |
| 3 | all 32 threads on one bank — 32 arbitration cycles, the worst case |
| 4 | a store, then read it back |
| 5 | a byte store |
| 6 | 2000 randomised operations: random mask, random addresses, random size, load and store mixed |
| 7 | byte and half stores across 8 offsets and all 4 alignments, with a read-back of every word |
| 8 | back-pressure: the result must be held stable while `out_ready_i` is low |

The randomised test takes a `+mode=` argument that selects loads only (1),
stores only (2), single-threaded (3) or word-sized (4); and `+seed=` to make a
failure reproducible. **Keep both** — they are the bisection tool.

The reference model also keeps a shadow copy of the whole scratchpad
(32 banks × 1024 words), initialised with a pattern in which every byte
depends on both the bank and the offset, so that a routing mistake shows up:

```
pattern(bank, offset) = (bank << 24) | (offset << 8) | ((bank + offset) & 0xFF)
```

---

## 8. Cocotb-specific notes

**The simulator has to be Verilator.** Icarus Verilog 12 cannot parse
`fpnew_pkg.sv` — it fails with a syntax error at `fpnew_pkg.sv:211` — and
`core_pkg.sv` needs `fpnew_pkg::status_t`, so the whole project is out of
reach for Icarus. (`iverilog` is installed in WSL, but it cannot be used.)

**The project path contains spaces** (`OneDrive - Yildiz Technical
University`), which breaks two things:
- Verilator's `-F` file list splits entries on whitespace, so a Bender path
  with a space is torn into bogus options. `tb/common.sh` rewrites the paths
  to be relative to the file list's own directory.
- GNU Make refuses to build in a directory whose path contains spaces, so the
  build tree is kept outside the project (`$HOME/dolunay-sim`, see
  `DOLUNAY_BUILD_DIR` in `tb/common.sh`).

**Only `fpnew_pkg` is needed** for the LSU testbench — the testbench never
instantiates the FPU. `BENDER_FILTER=fpnew_pkg` in `tb/common.sh` restricts
the Bender file list to the package, which is what makes the build take
seconds instead of five minutes.

**X handling is weak under Verilator.** Verilator is effectively 2-state, so
`$isunknown` on a mask almost never fires. The handoff's most valuable lesson
is that an `'x` reaching a comparison that feeds a mask is *silent* under a
2-state simulator, so the testbench's X checks are much weaker than they look.
Do not rely on them; rely on the reference model. (Under a 4-state simulator
the checks would be worth having, but the project cannot use one.)

**Driving and sampling.** The current testbench drives on the negedge and
samples on the negedge, so nothing races with the clock edge. Cocotb's
read-only / write phases give the same guarantee: drive in the write phase,
sample in the read-only phase.

**Internal signals can be read.** The current testbench reads
`u_dut.op_instr_r.mem_opsize` hierarchically to check that the LSU latched
the right instruction. Cocotb can do the same with a VPI handle. Note that
Verilator only keeps such a signal if it is not optimised away, so prefer
checking the *outputs* where you can.

---

## 9. The environment

Everything runs in WSL:

```sh
cd "/mnt/c/Users/azc/OneDrive - Yildiz Technical University/Belgeler/dolunay"
sh tb/run_fu_lsu.sh          # the LSU testbench
sh tb/run_core_middleend.sh  # the middle-end
sh tb/run_core_top.sh        # the whole core
```

`bender` (0.32.1) and `verilator` (5.020) are installed in WSL. The Bender
checkout lives in `.bender/` inside the project (gitignored); `bender update`
refreshes it.

**The cocotb environment is now set up** — see `pytb/README.md`. Two things
were needed that the distribution does not provide:

- **cocotb 2.1** is in a virtualenv. It is `.venv` in the project, because
  that is where the editor's language server and the other Python tools
  look for it by default; `pyrightconfig.json` says so explicitly as well.
  `python3 -m venv .venv` and
  `.venv/bin/pip install -r pytb/requirements.txt` create it.
- **Verilator 5.048** is unpacked into `~/tools/verilator-5.048` and put in
  front of the `PATH` by the cocotb runner. cocotb 2.x needs
  Verilator 5.036 or later: its `verilator.cpp` uses VPI entry points
  (`VerilatedVpi::evalNeeded` and friends) that do not exist in 5.020, and
  the compile fails with "is not a member of 'VerilatedVpi'". The
  distribution Verilator is left alone, because the SystemVerilog
  testbenches are verified against it.

The example testbench (`python3 pytb/run.py demo`) proves out the flow, and
the real `fu_lsu` has already been compiled and linked through it with the
file list that `tb/common.sh` generates from Bender. See `pytb/README.md`
for the setup and for the two path problems (spaces in the path, CRLF line
endings) and how they are handled.

---

## 10. What is *not* done

- **Broadcasting** is deliberately not implemented. When it is, the group key
  matters: for a **load** the group is the whole word (bank, offset), for a
  **store** it must be the exact byte address (bank, offset, align), because
  dropping a store that covered different bytes would write a value that was
  never stored. The cost is 1024 comparisons, roughly 8k LUTs; the cheap
  "all threads on one address" version is about 350 LUTs.
- **No synthesis numbers.** The LSU has not been measured on Vivado. The
  handoff's figures (12,712 LUTs / 128 FFs) are for the old design; the new
  one adds roughly 3.1k FFs of replay state. That needs the Vivado in the
  distrobox.
- **The scratchpad's place in the address map** is still open: the LSU only
  looks at `addr[16:0]` and ignores the bits above, so every 128 KB region of
  the address space aliases onto the same scratchpad. The `TODO` in
  `src/fu_lsu.sv` is about that, not about the `addr[12]` hole (which is
  closed).
- **The `fu_operation_s` / `fu_result_s` structs** carry FU-specific fields
  that are set to `'x` (`uwb_result`, `csrw_result`, `fpu_status`). They were
  written before there was a `core_middleend`, and they are now a wart. That
  cleanup may change the bit layouts in §3, which is another reason to
  regenerate them rather than hardcode them.
- **The core's smoke test does not exercise a load or store** — the test
  kernels never touch the scratchpad, so the integration is verified
  structurally but not end to end.

---

## 11. The cocotb testbench — status

**Done on 2026-10-26**, on the branch `ooo-lite-cocotb`. `tb/tb_fu_lsu.sv` is
untouched and still passes (43,684 checks, 0 failures); the cocotb version
is next to it.

The testbenches live in `pytb/`, one folder per testbench, with everything
a testbench needs in its own folder:

| file | what it is |
|---|---|
| `pytb/run.py` | the only entry point: it finds and runs the testbenches |
| `pytb/README.md` | the setup and the usage |
| `pytb/demo/` | an example: the smallest testbench that shows the conventions |
| `pytb/fu_lsu/tb_fu_lsu_cocotb.sv` | the harness: the LSU, the scratchpad and the init mux |
| `pytb/fu_lsu/lsu_model.py` | the reference model and the struct bit layouts |
| `pytb/fu_lsu/test_fu_lsu.py` | the testbench, one cocotb test per test group |

A testbench is a folder with a `testbench.toml` in it, which says what it
is and what it is built from. `run.py` finds them by looking for the file,
so a new testbench is a new folder and nothing else.

```sh
python3 pytb/run.py                # every testbench
python3 pytb/run.py fu_lsu         # one of them
python3 pytb/run.py --list         # what is there
```

The eight test groups of §7 are all there, one cocotb test each, and the
mode and the seed of the randomised test survived as `--mode` and `--seed`
on the runner (see `pytb/README.md`).

Everything in §2 to §8 was followed: the harness keeps the init mux of §2,
the timing contract of §4 is the same `n_arb + 2` cycles, the model of §5 is
the one of §5, and the two bugs of §6 are not repeated.

**The bit layouts of §3 are not repeated in Python.** The first version of
the cocotb testbench computed them in `lsu_model.py`, the same way
`tb/tb_layout.sv` prints them, which is a copy of the struct definitions
that has to be kept in step with them. Instead the *harness*
(`pytb/fu_lsu/tb_fu_lsu_cocotb.sv`) packs and unpacks the structs, naming
the fields, and the testbench talks in the fields it cares about: the mask,
the addresses, the size of the access. A change of a struct is then a
change of the harness, and the compiler says so, and a field that is added,
moved or widened needs no change in the testbench or the model at all.

What is left of the layout is how a thread's data is laid out in a
`simd_data_t`, which is a packed array: thread *i* is in the bits
`[i*RLEN +: RLEN]`. The testbench checks the widths of the signals against
the parameters of the model, so that a change of those is caught too.

### What was found on the way

**The SystemVerilog testbench generates an invalid access.** Test 7 of
`tb/tb_fu_lsu.sv` stores a *half* at alignment 1, but a half may only be
stored at alignment 0 or 2 — everything else is `'x` in the formatters
(§5.4). It passes, because Verilator resolves the `'x` byte enables to
zero, so the store writes nothing, which is what the model expects. That is
a property of the simulator, not of the design, so the cocotb testbench
does not generate it: the size follows the alignment, so alignment 0 and 2
are half stores and alignment 1 and 3 are byte stores. All four alignments
and both valid half alignments are still covered.

**Verilator resolves `'x` to zero.** This is worth knowing, because it
means the `'x` checks of the SystemVerilog testbench (`$isunknown` on the
result mask) are as weak as §8 says, and it means a testbench cannot
distinguish "the RTL wrote `'x`" from "the RTL wrote nothing".

**A linter renames the `cocotb` package imports.** The directory of the
testbenches is called `pytb/`, because the name `cocotb/` confused a
linter into rewriting `import cocotb` into `import pytb` — the package
comes from PyPI and its name has nothing to do with the directory. The
imports in `pytb/*/test_*.py` have to stay `cocotb`.

**The language server has to be told about the virtualenv.** cocotb is in
`.venv` in the project, which is where the tools look for it by default,
and `pyrightconfig.json` says so explicitly as well. The rule about the
implicit relative imports is off there, because a testbench's files import
each other as top level modules: the folder of a testbench goes on the
import path of the simulator.

### The environment

§9 describes the machine the handoff was written on. The conversion was
made on a different one, so the environment section does not apply to it
as it is written; what does apply:

- cocotb 2.1.0 in a virtualenv, and Verilator 5.046 from the distribution
  — 5.046 is new enough for cocotb 2.x, so there is nothing to unpack and
  `DOLUNAY_VERILATOR` is left unset;
- the virtualenv is `.venv` in the project, so that the editor's language
  server finds cocotb without being told. `pyrightconfig.json` says so
  explicitly as well, and turns off the rule about the implicit relative
  imports of the testbenches, which is how a testbench's files import each
  other;
- the setup is prose in `pytb/README.md` rather than a script, because
  there is nothing to unpack on a machine whose Verilator is new enough;
- the file list of §9 is not needed any more: `pytb/run.py` asks Bender
  for the fpnew package and gives the sources to Verilator on the command
  line, so a path with a space in it is not a problem;
- only `fpnew_pkg` is needed, as §9 says.

### What is still open

The same as §10, plus the broadcasting, which is still not implemented.
