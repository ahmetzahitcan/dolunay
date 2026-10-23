# HANDOFF — Dolunay LSU bank arbitration: resource analysis & redesign

**Date:** 2026-10-21
**Branch:** `ooo-lite` (HEAD `a615861`)
**Scope:** `src/fu_lsu.sv` bank-assignment block; core-wide resource budget.
**Target device:** Nexys A7-100T (`xc7a100tcsg324-1`). NOTE: `CmodA7_Master.xdc` is
stale (it is a CmodA7 / `xc7a35t` constraints file). All synthesis numbers below
were measured on `xc7a35tcpg236-1` because that is the part in the checked-in
Vivado project (`dolunay-anon/dolunay-vivado/dolunay-vivado.xpr`); LUT counts are
essentially part-independent, but re-measure on `xc7a100t` if you want exact
device percentages.

---

## 1. TL;DR

1. The bank-assignment block in `fu_lsu.sv` is **not** the resource problem
   (3,324 LUTs). The problem is the **read/write data routing** it implies.
2. The read path **does not need `bank_thrid_w` at all**. Each thread can mux on
   its *own* bank select. This alone removes ~8.4K LUTs.
3. The write path must gather the winner's data, but should do it **by 5-bit
   index**, not via a 32x32 one-hot matrix. Removes ~9K LUTs.
4. The read-data mux select **must be registered** (the SPAD RAM has a
   registered read). Getting this wrong returns the wrong thread's data.
5. The arbitration loop should be restructured **parallel** (one-hot decode +
   per-bank priority encoder). Cuts critical path from 87.5 ns to 12.0 ns.
6. **The real elephant is `u_fpnew` at 125,704 LUTs** — 2x the entire 100T
   device. The LSU is a rounding error by comparison. See §6.

**Recommended LSU datapath: 12,712 LUTs, 2.97 ns critical path**
(vs. 17,232 LUTs / 15.2 ns for the crossbar-style equivalent).

---

## 2. Background: why the arbitration exists

`N_SPAD_BANKS = N_THREADS = 32`. The scratchpad has 32 banks, each a
single-ported RAM (`src/ram.sv`, `src/scratchpad.sv`). A bank can serve only
one thread per cycle, but many threads in a warp can target the same bank, so
the LSU must pick one winner per bank and replay the losers next cycle.

Address decode (`src/fu_lsu.sv:30-41`), with `N_SPAD_BANKS=32`,
`W_SPAD_BANKS=5`, `Z_SPAD_BANK_SEL=13`, `W_SPAD_BANK_SEL=18`:

| Field | Bits | Width |
|---|---|---|
| bank select | `addr[17:13]` | 5 |
| offset in bank | `addr[11:2]` | 10 |
| byte align | `addr[1:0]` | 2 |

Note `addr[12]` is unused by the current decode — worth a sanity check against
the intended memory map (the `TODO` at `fu_lsu.sv:40`).

---

## 3. Measured component costs

Vivado 2025.2, `xc7a35tcpg236-1`, `-flatten_hierarchy none`.
Raw reports: `tmp/lsu_exp/util_*.rpt`.

| Block | LUTs | What it is |
|---|---:|---|
| `c_addrgen` | 576 | 32x 32-bit adders + field extraction |
| `c_arb` | 3,888 | arbitration only (parallel, masked) |
| `c_readmux` | **9,216** | read routing: per-thread mux on own bank select |
| `c_readxbar` | **17,585** | read routing: crossbar via `bank_thrid_w` |
| `c_wrgather` | **12,672** | write routing: per-bank gather via winner index |
| `c_wr1hot` | **21,648** | write routing: per-bank gather via 32x32 one-hot matrix |

### Arbitration-only variants

| Variant | LUTs | Critical path | Logic levels |
|---|---:|---:|---:|
| `bank_assign_seq` (current code, unmasked) | 3,324 | — | — |
| `bank_assign_seq_masked` (current + mask) | 4,736 | 87.5 ns | 99 |
| `bank_assign_para_fixed` (parallel + mask, corrected) | 3,846 | **12.0 ns** | **10** |

### Full LSU memory datapath

| Variant | LUTs | FFs | Critical path | Levels |
|---|---:|---:|---:|---:|
| `lsu_dp2_cross` (crossbar routing) | 17,232 | 0 | 15.2 ns | 16 |
| `lsu_dp2` / `w4_32` (**recommended**) | **12,712** | 128 | **2.97 ns** | **7** |
| `lsu_rw_cross` (one-hot owner matrix, R+W) | 35,026 | 0 | 96.7 ns | 111 |
| `lsu_rw_exp` | 36,209 | 0 | 146.7 ns | 197 |
| `lsu_rw_direct` (write-during-arbitration) | 41,574 | 0 | 139.8 ns | 188 |
| `lsu_rw_direct_q` | 42,640 | 0 | 143.4 ns | 194 |

### Scaling with bank count (`lsu_dp4`)

| `N_SPAD_BANKS` | LUTs | FFs |
|---:|---:|---:|
| 32 | 12,712 | 128 |
| 16 | 4,740 | 96 |
| 8 | 2,195 | 64 |

Routing cost is a 32x32 network, so it scales with bank count. Fewer banks =
much cheaper but ~4x more bank conflicts at 8 banks. **This is an
architecture tradeoff, not a free win — needs a decision.**

---

## 4. Bugs found

### 4.1 In the original code (`src/fu_lsu.sv:43-58`)

**(a) The arbitration ignores the active-thread mask.**
`in_operation_i.mask` is the active-thread mask (see `fu_bju.sv:92`, which
correctly does `branch_mask_w & operation_w.mask`). The LSU lets all 32 threads
compete for banks, so a diverged-out thread can win a bank and force a live
thread to be replayed. Fix: gate on the active mask. Cost: +1,412 LUTs
(3,324 -> 4,736) if done on the sequential version; the parallel version absorbs
it almost for free (3,846).

**(b) `5'(unsigned'(i))` hardcodes 5 bits.** `W_THREADS` happens to be 5 today;
use `W_THREADS'(i)` so it survives an `N_THREADS` change.

**(c) `bank_thrid_w = 'x` leaves unclaimed banks as `'x`.** Harmless today
(nothing indexes it), but dangerous the moment something does: an `'x` index
into an array propagates. In my crossbar experiment, `if (bank_thrid_w[b] == j)`
silently produced garbage rather than a clean miss.

### 4.2 In my own first parallel attempt (worth reading — it is subtle)

`bank_assign_para` in `tmp/lsu_exp/lsu_full2_exp.sv` was **wrong**: 2,419 of
20,000 randomized trials mismatched. Cause:

```systemverilog
winner_w[b] = 'x;                                    // unclaimed banks
thread_successful_w[i] = (winner_w[addr_sel_w[i]] == W_THREADS'(i));
```

If no *active* thread targets bank `b`, `winner_w[b]` stays `'x`. Then for an
**inactive** thread `i` pointing at `b`, `'x == i` evaluates to `X` — and under
a 2-state simulator (Verilator default) `'x` collapses to `0`, so `0 == 0` is
**true** and the inactive thread falsely reports success.

Fix: default `winner_w` to `0` (not `'x`) **and** gate on `thread_active_w[i]`.
Corrected version: `tmp/lsu_exp/lsu_fixed.sv` (`bank_assign_para_fixed`),
verified over 50,000 trials, no X in the success mask.

**Takeaway for the next agent: never let `'x` reach a comparison that feeds a
mask.** Verilator's default 2-state X-collapse turns a latent `'x` bug into a
silent wrong-value bug that only shows up in simulation, not synthesis.

---

## 5. Recommended design

### 5.1 Arbitration — parallel, masked

```systemverilog
logic [N_SPAD_BANKS-1:0][W_THREADS-1:0] winner_w;   // owner thread per bank
logic [N_SPAD_BANKS-1:0] hit_any_w;

always_comb begin
    for (int b = 0; b < N_SPAD_BANKS; b++) begin
        winner_w[b]  = '0;            // 0, NOT 'x  (see §4.2)
        hit_any_w[b] = 1'b0;
        for (int i = N_THREADS-1; i >= 0; i--) begin
            if (thread_active_w[i] && (addr_sel_w[i] == b[W_THREADS-1:0])) begin
                winner_w[b]  = W_THREADS'(i);
                hit_any_w[b] = 1'b1;
            end
        end
    end
    for (int i = 0; i < N_THREADS; i++) begin
        thread_successful_w[i] = thread_active_w[i] &&
                                 hit_any_w[addr_sel_w[i]] &&
                                 (winner_w[addr_sel_w[i]] == W_THREADS'(i));
    end
end
```

Reversed inner loop so the *lowest* thread index wins (matching the original
greedy semantics). All 32 banks are solved in parallel -> log depth.

### 5.2 Write path — gather by index

```systemverilog
always_comb begin
    for (int b = 0; b < N_SPAD_BANKS; b++) begin
        spad_addr_o[b]  = addr_off_w[winner_w[b]];
        spad_wdata_o[b] = rs2_data_w[winner_w[b]];
        spad_wen_o[b]   = addr_align_w[winner_w[b]];
    end
end
```

`winner_w[b]` is a 5-bit index -> plain 32:1 mux with a shared select.
(Compare: building a 32x32 one-hot owner matrix costs 21,648 vs 12,672.)

### 5.3 Read path — per-thread mux on own bank select, REGISTERED

```systemverilog
// Bank b is addressed with the WINNER's offset, so the word it returns
// belongs to that winner. Therefore thread j's data is simply the word in
// the bank j asked for. A losing thread reads the winner's word; that is
// harmless because thread_successful_w masks it off.
//
// The select must be REGISTERED: ram.sv has a registered read, so the data
// returned in cycle N+1 belongs to the address driven in cycle N.
logic [N_THREADS-1:0][W_THREADS-1:0] sel_q_w;
always_ff @(posedge clk)
    for (int i = 0; i < N_THREADS; i++) sel_q_w[i] <= addr_sel_w[i];

always_comb begin
    for (int j = 0; j < N_THREADS; j++)
        thread_rdata_o[j] = spad_rdata_i[sel_q_w[j]];
end
```

`bank_thrid_w` is still needed to know **which threads to replay** (control),
but must NOT be used for data routing.

### 5.4 Reference implementation

`tmp/lsu_exp/lsu_dp4.sv` — full datapath, parameterized on `NB`.
`tmp/lsu_exp/tb_dp4.sv` — cycle-accurate test vs. a behavioural model of the
whole LSU memory path including the SPAD's registered read.
**Status: PASS over 5,000 randomized cycles, no X in the success mask.**

---

## 6. Device budget — the real problem

Fresh synthesis of the **current** `core_top` with current sources
(`tmp/lsu_exp/util_core_top_current.rpt`, `util_core_hier.rpt`):

| | Value | 100T available | % |
|---|---:|---:|---:|
| Slice LUTs | 163,268 | 63,400 | **258%** |
| Slice Registers | 56,780 | 126,800 | 45% |
| RAMB36 | 32 | 135 | 24% |
| DSP | 64 | 240 | 27% |

Hierarchical LUT breakdown:

| Module | LUTs |
|---|---:|
| `u_fpnew` | **125,704** |
| `u_multialu` | 18,210 |
| `u_core_backend` | 8,266 |
| `u_bju` | 2,334 |
| `u_reg_scoreboard` | 1,096 |
| `u_core_frontend` | 720 |
| `u_csru` | 322 |
| `u_haz_scoreboard` | 119 |

**`u_fpnew` alone is 198% of the whole 100T device.** That is the elephant.
The LSU at ~12.7K is ~3% of the problem. Reducing the LSU from 17K to 12.7K
does not get the design to fit.

### Stale-report warning

`build/util_core_top.rpt` and `build/util_core_top2.rpt` are both dated
**2026-10-04**, i.e. *before* the Oct 12 register-file refactor
(`8e96f58`, `41fb565`). They are **not** representative of current sources.
Measured today in isolation:

- `register_file`: **32 RAMB36** (the "96" in the stale report was the old
  3-read-port + 1-write-port version). The refactor to 2 symmetric R/W ports
  worked as intended.
- `scratchpad`: **32 RAMB36** (32 banks x 1024 x 32 bit).

BRAM total is comfortable on the 100T (64/135 once the SPAD is integrated).

---

## 7. Known issues found along the way (not from the LSU work)

These blocked a clean `core_top` synthesis and are **already fixed in the
working tree**:

- `src/scoreboard.sv:71` and `src/scoreboard_mask.sv:66` — simulation-only
  `assert (!$isunknown(...))` with a non-constant argument. Vivado rejects it
  (`Synth 8-280: expression must be constant`). Fixed by wrapping both asserts
  in `` `ifndef SYNTHESIS ``, matching the pattern used elsewhere in the project.
  **These two edits are mine**; the other staged changes are the user's.
- `src/fu_lsu.sv:67` — `.m_data_i(m_data_i)` references an **undeclared**
  signal. `fu_lsu.sv` therefore **does not compile** and could not be
  synthesized as part of `core_top`. Still unfixed (the `// TODO: From spad`
  comment acknowledges it). This blocks integrating the LSU.
- `src/sim__instr_formatter.sv` needs `DISASM_LEN`, which `params_pkg.sv` only
  defines under `` `ifndef SYNTHESIS ``. It is simulation-only (used only
  inside a `` `ifndef SYNTHESIS `` block in `control_unit.sv`) but still sits
  in the Bender file list, so it must be excluded when synthesizing.
- `core_top` needs `WRAM_SIZE` / `IROM_SIZE` generics; `tb/tb_core_top.sv`
  uses `65536` for both.

---

## 8. Open questions for the next agent

1. **Bank count.** Keep 32 banks (12.7K LUTs, fewest conflicts) or drop to
   16 (4.7K) / 8 (2.2K) and eat more replays? Needs a conflict-rate model
   based on real kernel access patterns.
2. **Does `fu_lsu.sv` need to exist as a separate FU at all?** The LSU is not
   yet instantiated in `core_top` (`core_middleend.sv` dispatches to BJU, CSRU,
   FPU, MULTIALU; `FUNCTION_UNIT_LSU` is in the enum but unused). The
   `m_data_i` TODO suggests the SPAD read path is not wired up yet.
3. **`addr[12]` is unused** by the current bank/offset decode. Verify against
   the intended SPAD memory map.
4. **`fpnew` is the actual blocker** (125,704 LUTs). Is a 32-thread-wide FPU
   necessary? Reducing `FPU_WIDTH` / vector width, or making the FPU
   narrower-and-multicyled, would dwarf any LSU win.
5. **The `bender.tcl` file list is stale** — it references
   `src/control_unit_ext.sv` (deleted) and omits `fu_lsu.sv` / `scratchpad.sv`.
   Regenerate with `bender script flist -t rtl` before synthesizing.

---

## 9. How to reproduce the measurements

Vivado lives inside a distrobox; the agent sandbox blocks Podman, so Vivado
commands need `unsandboxed: true` (or run them yourself).

```bash
# helper already written for this: tmp/lsu_exp/dbx.sh (retries the flaky
# distrobox container lookup)
tmp/lsu_exp/dbx.sh vivado -mode batch -source <script>.tcl -nolog -nojournal \
    -tclargs <top> <outfile>
```

Verilator (for simulation) is available on the host and needs no special setup:

```bash
verilator --binary -sv --timing -Wno-fatal --Mdir <objdir> -o <bin> \
    --top-module <tb> src/params_pkg.sv <dut>.sv <tb>.sv
./<objdir>/<bin>
```

Note: `/tmp` is cleared between shell invocations in this environment — always
write build outputs inside the project tree.

### Files in `tmp/lsu_exp/` (gitignored)

| File | Purpose |
|---|---|
| `lsu_dp4.sv` | **recommended** LSU memory datapath (parameterized on `NB`) |
| `tb_dp4.sv` | cycle-accurate test of `lsu_dp4` — **PASS** |
| `lsu_fixed.sv` | corrected parallel arbitration (`bank_assign_para_fixed`) |
| `tb_fixed.sv` | 50k-trial equivalence test of `lsu_fixed.sv` — **PASS** |
| `tb_route.sv` | proves read-by-own-sel routes winner data correctly — **PASS** |
| `comp.sv` | component breakdown modules (`c_addrgen`, `c_arb`, `c_readmux`, ...) |
| `bank_assign_exp.sv`, `tb_bank_assign.sv` | sequential-vs-parallel equivalence (unmasked) — **PASS** |
| `lsu_route2.sv` | read routing variants |
| `dbx.sh` | distrobox retry wrapper |
| `util_*.rpt` | all raw synthesis reports |

---

## 10. Suggested next steps, in order

1. **Fix `fu_lsu.sv:67`** (`m_data_i` undeclared) so the LSU compiles and can be
   integrated — otherwise none of the LSU work can be validated in context.
2. **Land the recommended datapath** from §5 into `fu_lsu.sv` (arbitration +
   write gather + registered read mux), plus the `W_THREADS'(i)` fix and the
   active-mask gating.
3. **Decide the bank count** (§8.1) — it is a 6x LUT swing.
4. **Attack `fpnew`** — it is 2x the device on its own. Everything else is
   noise by comparison.
5. **Regenerate `bender.tcl`** and re-run a full `core_top` synthesis to get a
   trustworthy budget number; delete the stale `build/util_core_top*.rpt`.
6. Update the XDC: the project targets Nexys A7-100T, but
   `CmodA7_Master.xdc` is CmodA7 (`xc7a35t`) constraints.
