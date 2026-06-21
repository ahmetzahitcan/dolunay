# Split MEM Stage into 3 Pipeline Stages

## Current MEM Stage (Lines 336–589)

The current single MEM stage performs all of the following in one cycle between `exmem_*` input registers and `memwb_*` output registers. The goal is to split this into **MEM1 → MEM2 → MEM3**, each separated by new pipeline registers.

---

## Proposed Stage Mapping

| New Stage | Function | Key Logic Blocks (current lines) |
|-----------|----------|----------------------------------|
| **MEM1** | Leader Selection + Write Formatting | L338–508 (reservation, msel, leader PE, write-enable, store data mux, `mem_write_formatter`) |
| **MEM2** | Divergence Detection + Memory Access | L510–576 (coalescing, branching/BCU, replay logic, SC output, WRAM/TLOCAL/IROM-B access) |
| **MEM3** | Thread Scheduler Update + HPM Update + Read Formatting | L188–233 (thread_scheduler drives), L50–59 (HPM drives), L591–632 (read formatter — currently in WB) |

---

## Change List

### 1. New Stage Valid Registers

**File:** [pipeline.sv](file:///home/azc/Belgeler/dolunay/src/pipeline.sv)

- Replace single `mem_stage_valid_r` (L71) with three registers: `mem1_stage_valid_r`, `mem2_stage_valid_r`, `mem3_stage_valid_r`.
- Update the valid-propagation chain (L94–96):
  ```
  mem1_stage_valid_r <= ex_stage_valid_r;
  mem2_stage_valid_r <= mem1_stage_valid_r;
  mem3_stage_valid_r <= mem2_stage_valid_r;
  wb_stage_valid_r   <= mem3_stage_valid_r;
  ```

### 2. New Inter-Stage Pipeline Registers

Two new register sets are needed:

#### EX→MEM1 registers (existing `exmem_*`, no change)
Already exist: `exmem_instr_r`, `exmem_alu_result_r`, `exmem_rs2_data_r`, `exmem_mask_r`, `exmem_pc_r`, `exmem_warp_id_r`.

#### MEM1→MEM2 registers (NEW: `m1m2_*`)
Must capture every MEM1 output that MEM2 needs:

| Signal | Width | Purpose |
|--------|-------|---------|
| `m1m2_instr_r` | `instr_s` | Forwarded instruction |
| `m1m2_alu_result_r` | `[N_THREADS-1:0][XLEN-1:0]` | ALU results (needed for coalescing, branching, IROM-B addr) |
| `m1m2_mask_r` | `[N_THREADS-1:0]` | Thread mask |
| `m1m2_pc_r` | `[XLEN-1:Z_PC]` | PC (for branch target calc) |
| `m1m2_warp_id_r` | `[W_WARPS-1:0]` | Warp ID |
| `m1m2_leader_id_r` | `[W_THREADS-1:0]` | Leader index from priority encoder |
| `m1m2_leader_one_hot_r` | `[N_THREADS-1:0]` | Leader one-hot (for SC output) |
| `m1m2_leader_valid_r` | `logic` | Leader validity |
| `m1m2_leader_alignment_r` | `[Z_ADDR-1:0]` | Leader byte alignment |
| `m1m2_msel_r` | `msel_e [N_THREADS-1:0]` | Memory select per thread |
| `m1m2_store_data_fmt_r` | `[N_THREADS-1:0][XLEN-1:0]` | Formatted store data |
| `m1m2_store_wen_r` | `[N_THREADS-1:0][ADDR_ALIGN-1:0]` | Byte write enables |
| `m1m2_write_en_r` | `[N_THREADS-1:0]` | Per-thread write enable |
| `m1m2_rs2_data_r` | `[N_THREADS-1:0][XLEN-1:0]` | RS2 data (if needed downstream — verify) |

#### MEM2→MEM3 registers (NEW: `m2m3_*`)
Must capture every MEM2 output that MEM3 needs:

| Signal | Width | Purpose |
|--------|-------|---------|
| `m2m3_instr_r` | `instr_s` | Forwarded instruction |
| `m2m3_alu_result_r` | `[N_THREADS-1:0][XLEN-1:0]` | ALU results (for read formatter alignment) |
| `m2m3_mask_r` | `[N_THREADS-1:0]` | Thread mask |
| `m2m3_pc_r` | `[XLEN-1:Z_PC]` | PC |
| `m2m3_warp_id_r` | `[W_WARPS-1:0]` | Warp ID |
| `m2m3_msel_r` | `msel_e [N_THREADS-1:0]` | Memory select |
| `m2m3_leader_alignment_r` | `[Z_ADDR-1:0]` | Leader alignment |
| `m2m3_sc_output_r` | `[N_THREADS-1:0]` | SC success/fail |
| `m2m3_instr_replay_mask_r` | `[N_THREADS-1:0]` | Replay mask |
| `m2m3_instr_retired_mask_r` | `[N_THREADS-1:0]` | Retired mask |
| `m2m3_branching_r` | `logic` | Branch taken flag |
| `m2m3_branch_target_r` | `[XLEN-1:Z_PC]` | Branch target PC |
| `m2m3_branch_mask_r` | `[N_THREADS-1:0]` | Branch taken mask |

### 3. MEM1 Logic Reassignment

All of these stay in MEM1 but must read from `exmem_*` and write to `m1m2_*`:

- **Reservation logic** (L338–356) — uses `exmem_*`, gate with `mem1_stage_valid_r`
- **Memory select (msel)** (L358–369)
- **Leader candidate selection** (L376–396)
- **Priority encoder** (L402–409)
- **Write enable** (L413–423) — gate with `mem1_stage_valid_r`
- **Store data mux** (L477–490) — `barr_sync_total_w`/`barr_sync_parked_next_w` dependency: these come from `thread_scheduler` which will now be driven in MEM3. See **Open Question 1**.
- **Write formatter** (L500–508)
- **WRAM address/wdata/wen outputs** (L427–429) — driven by leader; stay in MEM1.

> [!WARNING]
> The WRAM address and write data are driven combinationally from MEM1 signals. If MEM1 issues the address and the RAM has 1-cycle read latency, the read data arrives in MEM2, which is correct for the new split. **However**, the write enable must also be asserted in MEM1, meaning the write happens one cycle earlier than reads are consumed. Verify this is acceptable for your RAM timing.

### 4. MEM2 Logic Reassignment

These blocks move to read from `m1m2_*`:

- **Coalescing logic** (L510–521) — uses `m1m2_alu_result_r`, `m1m2_leader_id_r`
- **Branch condition units** (L530–540) — uses `m1m2_alu_result_r`, `m1m2_instr_r`
- **Branch mask/target** (L542–551) — uses `m1m2_mask_r`, `m1m2_pc_r`, `m1m2_instr_r`
- **Replay logic** (L555–569) — uses `m1m2_mask_r`, `m1m2_msel_r`, `m1m2_instr_r`, coalesced output
- **SC output** (L575–576) — uses `m1m2_leader_one_hot_r`
- **IROM port B address** (L242) — currently `exmem_alu_result_r[mem_leader_id_w]`; must change to `m1m2_alu_result_r[m1m2_leader_id_r]` so IROM read data is available in MEM3.
- **Thread-local RAM access** (L449–473):
  - Address driven by `m1m2_alu_result_r`, `m1m2_warp_id_r`
  - Write enable driven by `m1m2_write_en_r`, `m1m2_msel_r`, `m1m2_instr_r`
  - Write data driven by `m1m2_store_data_fmt_r`
  - Read data (`memwb_tlocal_rdata_w`) becomes available at end of MEM2, consumed in MEM3.

> [!IMPORTANT]
> Moving TLOCAL RAM access to MEM2 means its write-enable and address signals now come from `m1m2_*` registers (registered versions), which is a timing change from the current combinational path off `exmem_*`.

### 5. MEM3 Logic Reassignment

These blocks move to read from `m2m3_*`:

- **Thread scheduler updates** (L188–232): All inputs (`branch_i`, `pc_branch_i`, `mask_branch_i`, `instr_completed_i`, `instr_replay_mask_i`, `yield_i`, `barr_sync_i`) now come from `m2m3_*` registers, gated with `mem3_stage_valid_r`.
- **HPM updates** (L50–59): `winst_retired_i` and `inst_retired_i` now come from `m2m3_*` registered signals.
- **Read formatting** (L591–632): Currently in WB; move to MEM3. The `mem_read_formatter` reads WRAM/TLOCAL/IROM data that arrived at end of MEM2, formats it, and writes formatted results into `memwb_*` registers.
- **`memwb_*` pipeline register assignment** (L580–588): Becomes the MEM3→WB register stage, reading from `m2m3_*`.

### 6. Thread Scheduler Timing Changes

Currently (L188–232), thread schedulers are driven by `exmem_*` signals gated with `mem_stage_valid_r` (i.e., in MEM). After the split:

| Signal | Current Source | New Source (MEM3) |
|--------|---------------|-------------------|
| `instr_completed_i` | `~exmem_instr_r.barr_load & mem_en_w` | `~m2m3_instr_r.barr_load & mem3_en_w` |
| `instr_replay_mask_i` | `mem_instr_replay_mask_w` | `m2m3_instr_replay_mask_r` |
| `yield_i` | `exmem_instr_r.yield & mem_en_w` | `m2m3_instr_r.yield & mem3_en_w` |
| `barr_sync_i` | `exmem_instr_r.barr_sync & mem_en_w` | `m2m3_instr_r.barr_sync & mem3_en_w` |
| `barr_load_i` | `memwb_instr_r.barr_load & wb_en_w` | **Unchanged** (already from WB) |
| `branch_i` | `mem_branching_w & mem_en_w` | `m2m3_branching_r & mem3_en_w` |
| `pc_branch_i` | `mem_branch_target_w` | `m2m3_branch_target_r` |
| `mask_branch_i` | `mem_branch_mask_w` | `m2m3_branch_mask_r` |

The `bsync_1_w` hack (L197) also shifts to use MEM3 signals.

### 7. `wdone_r` Update

Line 87–89: `wdone_r` is set when `memwb_instr_r.is_wdone & wb_stage_valid_r`. This remains unchanged since it reads from WB-stage signals.

### 8. `ready_o` Signal

Line 65: Currently `~running_w & ~wb_stage_valid_r`. Must also check `~mem2_stage_valid_r & ~mem3_stage_valid_r` to ensure the pipeline is fully drained:
```
assign ready_o = ~running_w & ~mem2_stage_valid_r & ~mem3_stage_valid_r & ~wb_stage_valid_r & rst_n;
```

### 9. Store Data Source Dependency (barr_sync)

The `MEM_STORE_SOURCE_BSYNC` case (L485–487) reads `barr_sync_total_w` and `barr_sync_parked_next_w`, which are outputs from `thread_scheduler`. If thread_scheduler updates move to MEM3, these signals reflect **previous** state, not the state being updated in the same cycle. Currently they are read in MEM (same stage that drives `barr_sync_i`). After the split, MEM1 reads them **before** MEM3 updates them, which adds 2 extra cycles of latency.

> [!IMPORTANT]
> This is likely **functionally correct** because `barr_sync_total_w` and `barr_sync_parked_next_w` are combinational outputs of `thread_scheduler` internal state. Since the thread_scheduler update (`barr_sync_i`) now happens in MEM3 (2 cycles after MEM1 reads these outputs), the values MEM1 reads will reflect the state **before** the current instruction's effect — which is the same as the current design (thread_scheduler state is read before the posedge that updates it). **Verify this by tracing the barrier protocol.**

### 10. IROM Port B Timing

Line 242: `irom_addr_b_o` is currently driven by `exmem_alu_result_r[mem_leader_id_w]`. After the split:
- Address must be driven in MEM2 using `m1m2_alu_result_r[m1m2_leader_id_r]`.
- Read data (`irom_data_b_i`) arrives at end of MEM2, available in MEM3 for read formatting.
- `wb_irom_data_w` assignment (L243) must be updated: the IROM read data is consumed in MEM3 (read formatter), not WB.

### 11. Assertions

- Assertions gated on `mem_stage_valid_r` (L432–441) must be split: WRAM assertions stay in MEM1 (or MEM2 depending on what they check); replay/branch assertions move to MEM2.

### 12. Pipeline Depth Impact

- Pipeline goes from **6 stages** (WS→IF→ID→EX→MEM→WB) to **8 stages** (WS→IF→ID→EX→MEM1→MEM2→MEM3→WB).
- This increases branch penalty by 2 cycles. Verify warp interleaving still hides this latency (requires `N_WARPS >= 8` for full hiding; currently `N_WARPS = 4`).

---

## Open Questions

> [!IMPORTANT]
> **Q1: Barrier sync store data.** The `MEM_STORE_SOURCE_BSYNC` path reads `barr_sync_total_w` / `barr_sync_parked_next_w` from thread_scheduler in what is currently MEM. After the split, these are read in MEM1 but thread_scheduler updates in MEM3. Is the 2-cycle-stale read acceptable for your barrier protocol, or does this need a forwarding path?

> [!IMPORTANT]
> **Q2: WRAM write-to-read hazard.** WRAM write happens in MEM1, WRAM read data is consumed in MEM3. If two instructions from the same warp access the same WRAM address (write then read), the 2-cycle gap between MEM1 write and MEM3 read may create a RAW hazard depending on WRAM latency. Does the warp-interleaved scheduling guarantee this cannot happen, or is forwarding needed?

> [!IMPORTANT]
> **Q3: Read formatter placement.** The read formatter is currently in WB (L591–632). Moving it to MEM3 means WB becomes simpler (just mux + register file write). Confirm this is the intended design, or should read formatting stay in WB with MEM3 only doing thread_scheduler + HPM updates?

## Summary of All Files Requiring Changes

| File | Change |
|------|--------|
| [pipeline.sv](file:///home/azc/Belgeler/dolunay/src/pipeline.sv) | All changes listed above (stages, registers, rewiring) |

No changes needed to submodules (`thread_scheduler.sv`, `hpms.sv`, `warp_scheduler.sv`, `control_unit_pkg.sv`, `mem_write_formatter.sv`, `mem_read_formatter.sv`, `branch_cond_unit.sv`, `ram.sv`) — only port connections in `pipeline.sv` change.
