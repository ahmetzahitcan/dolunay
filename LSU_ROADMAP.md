# LSU roadmap — completing `fu_lsu`

**Status:** proposal, for review before implementation.
**Baseline:** branch `ooo-lite`, HEAD `d1b1d7f` (after the sim-flow fixes).
**Inputs:** `HANDOFF.md` (LSU resource analysis), `src/fu_lsu.sv`, `src/scratchpad.sv`,
`src/ram.sv`, `src/mem_read_formatter.sv`, `src/mem_write_formatter.sv`.

---

## 0. Where we are

`fu_lsu` today is a skeleton. In `src/fu_lsu.sv`:

| Signal | State |
|---|---|
| `spad_addr_o`, `spad_wdata_o`, `spad_wen_o` | declared, **never driven** |
| `spad_rdata_i` | **never read** |
| `in_ready_o`, `out_valid_o`, `out_result_o` | **never driven** |
| `thread_successful_w` | computed, **never used** (no replay) |
| `bank_thrid_w` | computed, used only to pick winners |
| `m_data_i` (line 68) | **undeclared** → the module does not compile |

So the LSU has an arbitration sketch but no datapath, no handshake and no replay
mechanism. The handoff's §5 describes the *datapath*; it says nothing about the
handshake or the replay, which is where most of the remaining work is.

Two things from the handoff are already done (commit `4403cde`): the active-mask
gating in the arbitration and the `W_THREADS'(i)` cast.

---

## 1. The one decision that drives everything: where does the replay live?

A bank can serve one thread per cycle, so conflicting threads must be serviced
over several cycles. Someone has to hold the operation and re-drive the losers.

### Option A — replay inside the LSU (recommended)

The LSU accepts one operation, holds it, re-arbitrates every cycle, and returns
the result when every thread has been serviced. The core needs no change
beyond instantiation; the FU contract is identical to the other FUs.

- **Pro:** self-contained, independently testable, no core scheduling changes.
- **Pro:** the handoff's §5 datapath is the core of it; its LUT numbers still hold.
- **Con:** the LSU holds state — roughly **3.1k FFs** (estimate in §5).
- **Con:** latency is 3 cycles for a conflict-free load, up to 34 in the worst case.

### Option B — replay in the core

The LSU stays a 1-cycle FU: it arbitrates, drives the SPAD, and returns the set
of threads it serviced in `fu_result_s.mask`. The middle-end re-dispatches the
instruction for the threads that lost.

- **Pro:** LSU stays tiny (~128 FFs), matching the handoff's headline numbers.
- **Con:** the middle-end must re-dispatch a partially-completed operation, and
  the scoreboard/ROB must cope with an instruction completing in pieces. The
  `fu_result_s.mask` semantics change (it is currently the *writeback* mask:
  `rf_write_en_mask_o = wb_fu_result_r.mask` in `core_backend.sv:83`).
- **Con:** a re-dispatch re-reads the register file and redoes the address
  arithmetic; a partially-serviced store must not be re-executed for threads
  that already succeeded — the mask has to carry that correctly.
- **Con:** this is a core-scheduling project, not an LSU project.

**Recommendation: Option A.** It is what "complete and test the LSU" means, it
keeps the change inside one file, and it is the only option that can be verified
without first changing the core. Option B can be revisited later — the LSU's
internal arbitration can be reused verbatim, and `thread_successful_w` is already
computed.

**This is decision D1 and I need your call on it before writing RTL.**

---

## 2. Micro-architecture (Option A)

### 2.1 Address decode — unchanged from today

`addr = rs1_data[i] + imm` (32-bit adder per thread), then:

| field | bits | width |
|---|---|---|
| bank | `addr[17:13]` | 5 |
| offset | `addr[11:2]` | 10 |
| byte align | `addr[1:0]` | 2 |

`addr[12]` is unused — carried over from the handoff's open question 3.

### 2.2 State

```systemverilog
logic                    busy_r;      // operation in flight
logic                    done_r;      // result ready
simd_mask_t              pending_r;   // threads not yet serviced
simd_mask_t              capture_r;   // threads whose read data lands this cycle
simd_mask_t              last_win_r;  // "all threads won" of the previous cycle
simd_data_t              rdata_r;     // read data collected so far

logic [N_THREADS-1:0][W_SPAD_BANKS-1:0]      bank_q;
logic [N_THREADS-1:0][W_SPAD_BANK_ADDR-1:Z_ADDR] off_q;
logic [N_THREADS-1:0][Z_ADDR-1:0]            align_q;
logic [N_THREADS-1:0][RLEN-1:0]              wdata_q;  // formatted store data
logic [N_THREADS-1:0][ADDR_ALIGN-1:0]        wen_q;    // formatted byte enables
```

Plus the operation context for the result: `seq`, `warp_id`, `pc`, `mask`,
`instr` (`instr_s` is ~200 bits in synthesis; the 512-bit `sim__disasm` field
only exists under `ifndef SYNTHESIS`).

### 2.3 Arbitration — parallel, masked, `'0`-defaulted

Exactly the handoff's §5.1, with the §4.2 fix applied:

```systemverilog
always_comb begin
    for (int b = 0; b < N_SPAD_BANKS; b++) begin
        winner_w[b]  = '0;            // 0, NOT 'x
        hit_any_w[b] = 1'b0;
        for (int i = N_THREADS-1; i >= 0; i--) begin   // reversed: lowest index wins
            if (pending_r[i] && (bank_q[i] == b[W_SPAD_BANKS-1:0])) begin
                winner_w[b]  = W_THREADS'(i);
                hit_any_w[b] = 1'b1;
            end
        end
    end
    for (int i = 0; i < N_THREADS; i++) begin
        success_w[i] = pending_r[i] &&
                       hit_any_w[bank_q[i]] &&
                       (winner_w[bank_q[i]] == W_THREADS'(i));
    end
end
```

`pending_r` is initialised to the operation's active mask, so it *is* the
active-thread mask — no separate `thread_active_w` needed.

### 2.4 SPAD drive — write gather by winner index

```systemverilog
always_comb begin
    for (int b = 0; b < N_SPAD_BANKS; b++) begin
        if (hit_any_w[b]) begin
            spad_addr_o[b]  = off_q[winner_w[b]];
            spad_wdata_o[b] = wdata_q[winner_w[b]];
            spad_wen_o[b]   = is_store ? wen_q[winner_w[b]] : '0;
        end else begin
            spad_addr_o[b]  = '0;
            spad_wdata_o[b] = '0;
            spad_wen_o[b]   = '0;      // no request -> must not write
        end
    end
end
```

### 2.5 Read path — registered select, per-thread mux on own bank

```systemverilog
always_ff @(posedge clk)
    for (int i = 0; i < N_THREADS; i++) sel_q[i] <= bank_q[i];

always_ff @(posedge clk)
    for (int i = 0; i < N_THREADS; i++)
        if (capture_r[i]) rdata_r[i] <= spad_rdata_i[sel_q[i]];
```

Bank *b* is addressed with the **winner's** offset, so the word it returns
belongs to that winner — thread *j*'s data is just "the word in the bank *j*
asked for". A loser reads the winner's word; harmless, because `success_w`
masks it off. The select must be **registered** because `src/ram.sv:27` has a
registered read.

### 2.6 Result

`mem_read_formatter` is applied at the end, on `rdata_r` with `align_q` as the
alignment, so each thread's byte/half/word is extracted at *its own* alignment
and sign/zero-extended per `mem_extendmode`.

```systemverilog
out_result_o = '{
    seq: op_seq_q, warp_id: op_warp_id_q, instr: op_instr_q, pc: op_pc_q,
    mask: op_mask_q,                 // the original active mask: all threads succeed
    wb_result: rfmt_pdata_w,
    use_uwb: '0, uwb_result: 'x, csrw_result: 'x, fpu_status: 'x
};
```

For a store, `wb_result` is `'0` (`instr.rd_used` is false, so it is never
written back).

---

## 3. Two corrections to the handoff's §5 sketches

Both would be real bugs, and neither is caught by looking at the sketch alone.

**(a) §5.2 write enable is the wrong width.** The handoff writes
`spad_wen_o[b] = addr_align_w[winner_w[b]]`, but `addr_align_w` is 2 bits
(`[Z_ADDR-1:0]`) while `spad_wen_o` is 4 bits (`[ADDR_ALIGN-1:0]`). Zero
extension silently mis-encodes every byte lane. `mem_write_formatter` already
produces the correct 4-bit byte enables (`src/mem_write_formatter.sv:36-58`), so
the LSU uses `wdata_q`/`wen_q` from it.

**(b) §5.2 does not gate unclaimed banks.** With `winner_w[b] = '0` for a bank
nobody requested, `wen_q[0]` would be written into that bank — a store to a
random thread's address. The `hit_any_w[b]` guard in §2.4 fixes it.

**(c) §5.3's `sel_q_w` should be `W_SPAD_BANKS` bits, not `W_THREADS` bits**,
so the design survives a change in bank count.

---

## 4. Latency and handshake contract

| event | cycle |
|---|---|
| `in_valid_i` accepted | N (edge N) |
| first arbitration, SPAD addresses driven | N+1 |
| read data available (`ram.sv` is a registered read) | N+2 |
| `out_valid_o` asserted, `out_result_o` valid | N+3 |

For a store there is no read data, but the same timing is used so there is one
completion path.

Worst case: all 32 threads on one bank → 32 arbitration cycles → result at
N+34.

Handshake, following the `fu_fpnew` style (bottom-up `in_ready_o`):

```
in_ready_o  = !busy_r
out_valid_o = done_r
busy_r      <= 0 when (done_r && out_ready_i)
```

`core_middleend` already handles this: `of_dispatch_w = of_dispatch_ready_w &&
fu_in_ready_w[of_fu_sel_r]` holds the operation until the LSU is ready, and
`fu_out_ready_w = result_ready_i ? result_sel_w : '0'` acks only the selected
FU. The FPU is already multi-cycle, so nothing in the contract needs to change.

---

## 5. Resource budget (estimate)

| item | FFs | note |
|---|---:|---|
| `bank_q` + `off_q` + `align_q` | 544 | 17 bits x 32 threads |
| `wdata_q` + `wen_q` | 1152 | stores only; holds the *formatted* data so the gather is a single mux level |
| `rdata_r` | 1024 | loads only |
| operation context (`instr`, `seq`, `pc`, `mask`) | ~275 | `instr_s` without `sim__disasm` |
| masks and flags | ~100 | |
| **total** | **~3100** | ≈ 2.4% of the 100T's 126,800 FFs |

LUTs should land near the handoff's `lsu_dp2` figure (**12,712 LUTs, 2.97 ns**),
since the datapath is the same; the additions are the arbitration's
`pending_r` gating, the bank-hit gating, and the result formatting.

Two ways to trim, if the FF count matters:
- hold `rs2_data` (1024) and re-run `mem_write_formatter` each cycle instead of
  holding the formatted data — saves 128 FFs, adds a mux level to the write path;
- share one 1024-bit array between the store data and the read data (they are
  mutually exclusive) — saves 1024 FFs, at the cost of one array with two
  meanings.

I would keep them separate for clarity unless you want the FFs back.

---

## 6. Verification plan

New file `tb/tb_fu_lsu.sv` (+ `tb/run_fu_lsu.sh`), instantiating the real
`fu_lsu` **and** the real `scratchpad`, so the SPAD's registered read is part
of the model rather than an assumption.

1. **Reference model.** A behavioural model of the whole LSU memory path:
   given mask / addresses / data / opsize / extendmode, compute the expected
   `wb_result` and the expected SPAD contents.
2. **Randomised ops.** Random masks, random addresses (including deliberate
   bank conflicts), byte/half/word, sign/zero extension, load and store.
   Compare `out_result_o` against the model and the SPAD contents afterwards.
3. **Conflict stress.** All 32 threads onto one bank; two threads onto one
   bank; one thread per bank.
4. **X checks.** Every cycle, assert the success mask and the result mask
   contain no X. The handoff's §4.2 bug was exactly this: an `'x` reaching a
   comparison that feeds a mask, invisible in synthesis and silent under
   Verilator's 2-state X-collapse. The same assertion goes into the RTL under
   `` `ifndef SYNTHESIS ``, matching the pattern already used in
   `src/scoreboard.sv`.
5. **Handshake.** Random back-pressure on `out_ready_i`; check the result is
   held stable while stalled and that `in_ready_o` is low while busy.
6. **Latency.** Check the cycle count matches the model (3 + conflict depth).
7. **Regression.** `tb/run_core_top.sh` and `tb/run_core_middleend.sh` must
   still pass (they do now — I ran them).

Build time matters here: the full `core_top` build takes ~5.5 min because of
fpnew. The LSU testbench will use only `fpnew_pkg` from the Bender checkout
(`BENDER_FILTER=fpnew_pkg` in `tb/common.sh`), so it should build in seconds.

---

## 7. Checkpoints and commits

| # | Content | Commit |
|---|---|---|
| CP1 | sim flow: space-safe file lists, LF scripts, `register_file` Verilator fix | **done** — `590a67e`, `d1b1d7f` |
| CP2 | `fu_lsu` RTL: decode, parallel arbitration, write gather, registered read mux, handshake, replay state | `Implement LSU datapath and bank replay` |
| CP3 | `tb/tb_fu_lsu.sv` + `tb/run_fu_lsu.sh`: reference model, random + stress tests, X checks | `Add LSU testbench` |
| CP4 | integrate: instantiate `fu_lsu` in `core_middleend`, `scratchpad` in `core_top`, wire the SPAD bus; `core_top` smoke test still passes | `Integrate LSU and scratchpad into the core` |
| CP5 | synthesis measurement (Vivado via the distrobox) and a note in `HANDOFF.md` | `Measure LSU resources` |

CP5 is optional and needs Vivado access; everything up to CP4 is Verilator-only.

---

## 8. Open questions for you

- **D1 (§1).** Replay inside the LSU, or in the core? I recommend inside the LSU.
- **D2 (§3a).** Confirmed: use `mem_write_formatter`'s byte enables rather than
  the raw 2-bit alignment?
- **D3 (§5).** Keep the store data and the read data in separate arrays
  (~3.1k FFs), or share one array (~2.1k FFs)?
- **D4.** `addr[12]` is unused by the decode. Keep it as a hole, or is it
  meant to select a half of the bank? I will keep the current behaviour.
- **D5.** Bank count: keep 32? `fu_lsu` currently asserts
  `N_SPAD_BANKS == N_THREADS`, and dropping to 16 shifts the whole address map.
  I recommend keeping 32 for now — the LSU is ~3% of the resource problem.
- **D6.** Where should `scratchpad` live: in `core_top` (memory next to the
  WRAM/IROM, SPAD bus on the middle-end's ports) or inside `core_middleend`
  next to the LSU? I recommend `core_top`.
- **D7.** For a store, should `wb_result` be `'0` or `'x`? I plan `'0`.
