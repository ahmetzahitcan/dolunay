# Golden Model Contract

**Status: authoritative for everything under `golden/`.** Written 2026-11-04;
amended 2026-11-06 (ISA authority, D9; paths and lockstep, D3; execution and
memory ownership, D11).

This file says what the golden model *is*, what it must guarantee, and what it is
allowed to assume. It supersedes the **semantics** in [`DESIGN.md`](DESIGN.md)
and [`ITS-SEMANTICS.md`](ITS-SEMANTICS.md); those remain useful as design
rationale and as a description of the **previous** variant, and are marked as
such.

**This file is closed.** It states everything the model may assume. Anything not
written here is *unspecified* — not "implied by the RTL". An absent rule is a
question to raise, not a gap to fill in from `../src`.

If this file and the **model's own code** disagree, one of them is wrong — decide
which, fix it, and record the correction in [`DECISIONS.md`](DECISIONS.md). The
RTL is not part of that loop. While working under `golden/` the RTL is
**read-only**, and a difference between the model and the RTL is a *finding to
report*, never something to reconcile by editing either side from here.

---

## 1. What the model is

An executable, **functional** reference model of the Dolunay SIMT/ITS machine.
Not cycle-accurate; it does not model microarchitecture. Three jobs, in priority
order:

| # | Job | What "correct" means |
|---|-----|----------------------|
| G1 | Verify the kernels | A kernel that is correct under the ISA produces its intended result: the expected memory image and exit state. |
| G2 | Verify the machine | Same program, same initial state ⇒ the model and the RTL agree on *architectural* state (see §4). |
| G3 | Profile the kernels | A dynamic instruction histogram and a memory-access trace good enough to answer "is extension X worth implementing?". |

### Guarantees the model must satisfy

1. **Determinism.** Same program, same initial state, same scheduler seed ⇒
   byte-identical observation. Nothing observable may depend on wall-clock time,
   OS thread scheduling, hash-set ordering, or file enumeration order.
2. **Forward progress.** A kernel that obeys its own synchronisation contract
   terminates under *every* policy and seed. If it does not, the model reports
   non-termination and names the stuck agents. The model never rescues a kernel
   that deadlocks by construction — `ping_pong` and `spmc` exist to be caught.
3. **Interleaving independence is *tested*, not assumed.** The same program under
   N seeds must produce identical final memory, or the kernel has a latent race.
   The model reports which; it does not hide it.
4. **The observation is the interface.** Model and RTL are compared only through
   the format in §4.

---

## 2. The machine being modelled

**We are modelling the next variant, not the one in `../src`.** The RTL in this
repository implements the *previous* variant. **Nothing in it is part of this
contract unless this file says so** — not its modules, parameters, memory map,
instruction behaviour, start-up sequence, or termination mechanism.

Reading it is allowed, and sometimes unavoidable: it is how you learn how a
kernel binary is built and what the software expects of the machine. But reading
it does not make anything in it a requirement. If you want to rely on an RTL
detail, stop and ask for that detail to be written into this file *first*.

### Decided (stated direction)

- **Execution.** Each lane has its own PC and architectural state. The lanes of
  a warp execute in **lockstep until they diverge**; a set of lanes in lockstep
  is a **path**, and the scheduler chooses paths, not lanes (D3). Divergence is
  detected at every branch and jump. Lockstep is a semantic rule, not a
  requirement for SIMD execution. `yield` is a cooperative handoff, and forward
  progress is a design goal.
- **Memory.** A redesigned memory hierarchy around a **scratchpad + DMA**. The
  previous variant's region decode, per-thread TLS port, leader selection and
  replay are **not** assumed to survive. **The model owns all shared memory**
  (D11): every lane reaches it through the model.
- **Scratchpad accesses are synchronisation.** How lanes are matched to banks is
  an implementation detail the model does not reproduce, but accesses to the
  scratchpad are expected to be visible synchronisation in their own right.
- **Barriers.** The barrier algorithm is expected to change. The barrier context
  may move out of memory, possibly into **warp-level registers** — so per-warp
  named state is part of the machine's state space.
- **ISA.** The ratified RISC-V specifications plus Dolunay's ISA documents in
  [`isa/`](isa/) — custom instructions, custom CSRs, and exemptions from the
  standard (D9). Those documents are **not written yet**; until they are, no
  custom instruction or CSR is specified, and any in the code is a labelled
  placeholder.
- **Repository.** The model lives here; the ISA specification is shared with the
  RTL, so the two cannot drift silently.

### Open — do not assume, do not paper over

| Question | Why it matters | Where it lands |
|---|---|---|
| Geometry (warps × lanes) | How many lanes exist; every kernel's indices | a parameter, never a constant |
| What "lockstep" means precisely (D3) | Which orders between lanes of a path are observable | `isa/`; path model |
| Reconvergence: when do split paths merge? | Path bookkeeping; what scheduling can observe | path model |
| Order of conflicting scratchpad accesses within one lockstep instruction — possibly architecturally specified | Whether kernels with such conflicts are deterministic or racy | scratchpad policy (the scratchpad class may reorder internally) |
| Do LR/SC and AMOs survive, or become warp-level custom instructions with separate lane-level synchronisation? | They linearised memory in the previous variant and are problematic for the new RTL | `isa/` |
| Barrier context: memory, warp registers, or model-internal? | What is observable | sync interface |
| Barrier release rule | Semantics | sync interface |
| Memory ordering of `yield` and of the barrier | Whether the interesting kernels can be judged at all | memory model |
| DMA interface: MMIO device, or instructions? | Hook surface; whether DMA is a scheduled agent | agent interface |
| Termination condition | When a run ends | observation |

**Rule:** every open item becomes a *named knob with a declared default*, plus a
test proving the rest of the model does not depend on it. Resolve, don't
interleave.

---

## 3. Inputs and authority order

The model may read anything in the repository. Only these are authoritative:

| Rank | Source | Gives | Status |
|---|---|---|---|
| 1 | `CONTRACT.md`, `DECISIONS.md` | what we are building, and the choices made | **authoritative** |
| 2 | RISC-V ratified specifications + [`isa/`](isa/) | the ISA: encodings and per-instruction behaviour (D9) | **authoritative** |
| 3 | `../ss/`, `../asm-kernels/` | the software contract and the workloads | **corpus, not truth** |
| 4 | anything generated from rank 2 (none yet) | the model's decode data | **derived — regenerate, never edit** |
| 5 | `../control_unit/control_unit.csv` | the RTL's decoder input; a cheatsheet | **evidence, read-only** |
| 6 | `../src/`, `../tb/`, `../sim/` | how the previous variant was built and driven | **read-only; confers no requirements** |

Notes that save time:

- Every encoding in the model cites the RISC-V specification or the
  [`isa/`](isa/) section it comes from. Never hand-write an opcode, funct3, or
  CSR number without that citation.
- The CSV is useful for finding out what the previous RTL decoded, and nothing
  more. Its generator is `../control_unit/generate.py` (single file);
  `../control_unit/cugen/` is empty and the `csv_parser.py` / `model.py` /
  `sv_emitter.py` names quoted in `DESIGN.md` do not exist. A row whose name
  starts with `'` is commented out; a row starting with `~` declares enum values
  but emits no decode case.
- `../ss/` is **stale against the previous RTL** (it says 4 warps × 8 lanes;
  `../src/params_pkg.sv` says 8 × 8). Use it as a workload corpus and as a
  description of the software contract, not as a source of parameters.
- `irom.mem` at the repository root is a checked-in assembly-test image
  (7804 bytes), not a kernel build, and it is larger than `core_top`'s default
  IROM (`W_IROM_ADDR = 12`, 4 KiB) even though `../tb/tb_pipeline.sv` overrides
  it to 64 KiB. Do not treat it as a reference image.
- When rank 1–4 and rank 5–6 disagree, the higher rank wins, and the
  disagreement is a **finding to report** (record it in
  [`FINDINGS.md`](FINDINGS.md)): the RTL has a delta to absorb, and absorbing it
  is not `golden/` work. Never resolve a disagreement by editing `../src`,
  `../tb/`, `../ss/`, `../asm-kernels/` or the CSV.

---

## 4. The observation format — the model/RTL interface

This is the only contract between the two implementations, so it is worth
freezing early and versioning. **v0 draft; expected to be revised.** What must
not change are its invariants:

- deterministic ordering (sort every collection; never emit hash order),
- no timestamps, no absolute paths, no host-dependent values,
- canonical hex, little-endian byte order for memory dumps,
- every field named, so a diff is meaningful without a decoder.

```
# dolunay-observation v0
program       <sha256 of the loaded image>
geometry      <warps>x<lanes>
seed          0x<hex>
termination   all-wdone | timeout | deadlock
lane <w>.<l>  pc=0x<hex> exit=<reason>
warp <w>      barrier[<addr>] total=0x<hex> parked=0x<hex>
warp <w>      wreg[<name>]=0x<hex>
spad          0x<addr> : <hex bytes ...>
```

Memory dumps are ranges, not whole spaces, and the compared set is chosen per
test. Per-lane regions (the previous variant's TLS, or whatever replaces it), if
the new variant keeps any, are dumped per lane in lane order.

The RTL side must be able to emit the same file. Until it can, G2 is untested —
say so rather than implying agreement. Making that happen is not `golden/` work;
it is a request to the RTL owner.

---

## 5. Environment

What the work needs, independent of any machine. **Nothing here is a claim about the
machine you are on.** Paths, versions and "it works here" notes are machine-local,
change without notice, and must not be recorded in this repository — keep them
outside the checkout, like build outputs. Report the actual output of the checks
below when it matters. How to set a machine up is in `../ENVIRONMENT.md`; this
table only states what the model's work depends on.

| Need | For | Check |
|---|---|---|
| Python 3 | generators, small helpers | `python3 --version` |
| .NET SDK 8 | a pre-built Renode plugin, unit tests | `dotnet --version` |
| Renode | the ISA layer and the model's host | `renode --version` |
| RISC-V bare-metal GCC | building kernels | `riscv32-unknown-elf-gcc --version` |
| Icarus Verilog **or** Verilator | the RTL side of G2, once an RTL exists to test | `iverilog -V` / `verilator --version` |

`../tb/tb_pipeline.sv` instantiates the full core and reads `irom.mem`, so it is a
starting point for the RTL side; whether it elaborates under Icarus is unverified.

### The toolchain name is fixed; the toolchain is not

The build scripts call `riscv32-unknown-elf-gcc` and `riscv32-unknown-elf-objcopy`,
because that name describes the target: 32-bit, bare metal. Installations rarely use
it — Fedora ships `riscv64-linux-gnu-*`, Debian/Ubuntu `riscv64-unknown-elf-*`,
xPack `riscv-none-elf-*` — so **each machine provides the two names as shims**. The
`generate.sh` headers say what else a shim must do. A host without `hexdump` (Git
Bash on Windows has none) needs a stand-in for the scripts' last step as well.

The `-march` string uses `zicond`, so an old GCC rejects it; check before
concluding that a shim is wrong.

Rules that follow:

- **Do not invent commands.** If a tool is absent, say it is absent and stop.
  A fabricated `dotnet build` transcript is worse than no build.
- **§5 lists what the work needs, not what is installed.** Run the check and
  quote its output before claiming a tool is present.
- Keep build outputs **off** any OneDrive or space-containing path (spaces and
  sync daemons break GNU Make and Renode's relative-path resolution), and never
  commit them. Today the plugin build writes to the gitignored `build/` here,
  which is only safe while the checkout itself is not on such a path.
- Building the model needs the .NET SDK (D8); the ad-hoc `i @file.cs` route is
  not used.
- **One kernel builder.** The program image's sha256 is part of the observation,
  so two RISC-V toolchains would produce two "same" programs. Do not add a
  second one (for example in WSL) without recording why in `DECISIONS.md`.

---

## 6. Vocabulary

Use these words with these meanings, and do not resurrect retired ones:

| Term | Meaning |
|---|---|
| **lane** | One thread: its own PC and architectural register state. The unit of state. |
| **warp** | A set of lanes. The unit of rendezvous and of scheduling contention. |
| **path** | The lanes of one warp that are in lockstep (D3). Split by divergence; merged by the reconvergence rule (open). |
| **agent** | Anything the scheduler can advance: a path, and — if DMA is asynchronous — a transfer. The scheduler never schedules an individual lane. |
| **policy** | A pluggable, seedable rule for choosing the next agent where the ISA leaves the choice free. Not machine state. |
| **rendezvous** | The point where every lane of the active path has stopped before the same instruction, so the model can resolve it for the whole path (D11). |
| **scratchpad** | The new memory hierarchy's on-core storage; banked, DMA-fed. |
| **barrier** | A rendezvous object. Its *implementation* (memory, registers, model-internal) is a knob; its *identity* is an address or name the software passes. |
| **observation** | The dump in §4. The only thing compared between implementations. |
| ~~leader selection~~ | Previous variant's per-path memory coalescing. Do not implement speculatively. |
| ~~TLS~~ | Previous variant's per-thread memory region. Do not implement speculatively. |

---

## 7. Changing this contract

The contract changes only on an explicit instruction from the maintainer — not by
inference, not because the RTL does it that way, and not because an
implementation would be easier if the contract said something else.

Propose a change by writing it out — what changes, what it costs, what it
forecloses — and wait for an answer. Do not pre-empt it in code. When a change is
approved, make it in the same commit as the code that relies on it, and log the
reason in `DECISIONS.md`.
