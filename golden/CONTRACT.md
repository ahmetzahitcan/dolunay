# Golden Model Contract

**Status: authoritative for everything under `golden/`.** Written 2026-11-04;
amended 2026-11-06 (spec authority, D9; paths and lockstep, D3; execution and
memory ownership, D11; choice points, refinement and kernel determinacy, D12;
cooperative paths, D13; order within an instruction, D14; replay, D15);
amended 2026-11-07 (the `illegal` termination class, D16).

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
| G1 | Verify the kernels | A kernel is valid: it is determinate (below) and produces its intended output. |
| G2 | Verify the machine | Every RTL execution is a valid execution of the spec. Checked by replaying the RTL's choices in the model and comparing architectural state (D15, §4). |
| G3 | Profile the kernels | A dynamic instruction histogram and a memory-access trace good enough to answer "is extension X worth implementing?". |

### Executions, choice points and correctness (D12)

The spec is **not deterministic**. Where software does not care, it leaves a
**choice point** open to the implementation:

- **within a warp**, which path executes next — after a divergent branch or
  jump (one of the paths it created), a `yield`, a path starting to wait at a
  barrier, or a path finishing. Paths switch at no other point (D13);
- **between warps**, how their instructions interleave; warps execute
  concurrently, so every access to shared memory is a choice point;
- the values of the readable timing CSRs (`cycle`, `time`, `instret`, the HPM
  counters), which the spec leaves unconstrained;
- later, as they are specified: DMA progress and reconvergence.

The order of conflicting accesses within one lockstep instruction is **not** a
choice point; the spec defines it (D14).

A **valid execution** is one that makes some choice at every choice point and
otherwise follows the spec. An implementation is **correct** when each of its
executions is a valid execution.

A **valid kernel is determinate**: for each of its test inputs, every valid
execution produces the same **output**. The output is defined by the kernel's
**output descriptor**: the memory regions that hold its result, with integers
compared bitwise, floats within a stated tolerance, and fields that count only
when a condition on other fields holds. How the run ends (§4 `termination`) is
always part of the output. Determinacy is a property of a kernel *and an input*.

Checking determinacy (G1) needs more than one execution. The methods, cheapest
first, all expressed as policies:

1. **One execution and a conflict check.** If no two conflicting accesses
   (same address, at least one a write, different paths or warps) have an order
   that a choice point decides, every valid execution performs the same accesses
   with the same values, and the kernel is determinate on that input. Orders
   fixed by program order and barriers count; orders chosen by the scheduler do
   not. This covers kernels that write disjoint outputs and barrier-phased
   kernels.
2. **Systematic exploration** of only the reported conflicts' orders (partial-order
   reduction, with a bound on context switches), for kernels whose order is free
   but whose result is meant not to depend on it: locks and atomics around
   commutative updates, flag handoffs, allocators. Exhaustive at a small
   geometry.
3. **Random sampling** (PCT-style priority schedules, not uniform choice) at full
   geometry, where exploration is too large.

Once a kernel is validated on an input, the model may run any one execution of
it (**fast mode**).

### Guarantees the model must satisfy

1. **Reproducibility.** Same program, same initial state, same policy and seed —
   or the same replayed schedule — ⇒ byte-identical observation. Nothing
   observable may depend on wall-clock time, OS thread scheduling, hash-set
   ordering, or file enumeration order.
2. **Termination is classified, never rescued.** A run ends as `all-wdone`;
   `deadlock`, when no lane can execute, which is exact; `timeout`, when an
   instruction budget runs out; or `illegal`, when the model detects an act the
   spec makes *illegal* (`spec/README.md`), such as `wdone` from a path that
   does not hold the whole warp. Non-termination in general is undecidable, so
   `timeout` is a report, not a verdict. The model may report a stronger class
   (such as a proven livelock) only with a proof from the run. It names the
   stuck lanes, and never rescues a kernel that does not terminate.
   `ping_pong` and `spmc` must complete: they hand off through `yield` and
   deadlock only under a model that does not honour it, such as one that runs
   lanes one at a time (`DESIGN.md` §1.2), so they test the model's
   scheduling.
3. **Determinacy is *checked*, not assumed.** The model reports a kernel that is
   not determinate on an input, with the conflict or the two executions that
   show it. It does not hide it.
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
  requirement for SIMD execution.
- **Scheduling.** Paths of a warp switch **cooperatively**, only at points
  explicit in the code (D13). `yield` guarantees that before the yielding path
  executes its next instruction, every other lane of its warp that can
  execute — not finished, not waiting at a barrier — executes at least one
  instruction. Warps execute concurrently. Which path or warp goes first is a
  choice point (§1, D12).
- **Order within an instruction.** Conflicting accesses by the lanes of one
  lockstep instruction take effect in an order the spec defines (D14).
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
- **Specification.** The ratified RISC-V specifications plus Dolunay's
  specification documents in [`spec/`](spec/) — custom instructions, custom
  CSRs, exemptions from the standard, and the execution model (D9). Those documents are **not written yet**; until they are, no
  custom instruction or CSR is specified, and any in the code is a labelled
  placeholder.
- **Repository.** The model lives here; the ISA specification is shared with the
  RTL, so the two cannot drift silently.

### Open — do not assume, do not paper over

| Question | Why it matters | Where it lands |
|---|---|---|
| Geometry (warps × lanes) | How many lanes exist; every kernel's indices | a parameter, never a constant |
| What "lockstep" means precisely (D3) — drafted as the warp program order | Which orders between lanes of a path are observable | `spec/EXECUTION-MODEL.md` |
| Reconvergence: paths combine only through `bsync`, never implicitly (D3) — but `bsync`'s identity, expected set, release condition and resulting PC are open | Path bookkeeping; barrier semantics | `spec/EXECUTION-MODEL.md` |
| *Which* order conflicting accesses within one lockstep instruction take effect in (that there is one is decided, D14) | What such kernels compute | `spec/`; scratchpad (may reorder internally if the result is as if in that order) |
| Progress between warps: must every warp that can execute eventually execute? | Whether a kernel that waits on another warp without a barrier terminates; whether `timeout` can mean a spec violation | `spec/`; policy (default: yes) |
| Output descriptor: format, tolerance metric for floats (ULP, absolute, relative), NaN and signed zero | What "same output" means (D12) | the kernel corpus; determinacy check |
| Do LR/SC and AMOs survive, or become warp-level custom instructions with separate lane-level synchronisation? | They linearised memory in the previous variant and are problematic for the new RTL | `spec/` |
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
| 2 | RISC-V ratified specifications + [`spec/`](spec/) | the ISA: encodings and per-instruction behaviour (D9) | **authoritative** |
| 3 | `../ss/`, `../asm-kernels/` | the software contract and the workloads | **corpus, not truth** |
| 4 | anything generated from rank 2 (none yet) | the model's decode data | **derived — regenerate, never edit** |
| 5 | `../control_unit/control_unit.csv` | the RTL's decoder input; a cheatsheet | **evidence, read-only** |
| 6 | `../src/`, `../tb/`, `../sim/` | how the previous variant was built and driven | **read-only; confers no requirements** |

Notes that save time:

- Every encoding in the model cites the RISC-V specification or the
  [`spec/`](spec/) section it comes from. Never hand-write an opcode, funct3, or
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

## 4. The model/RTL interface: observation and replay log

These are the only contracts between the two implementations, so they are worth
freezing early and versioning. **v0 drafts; expected to be revised.** What must
not change are their invariants:

- deterministic ordering (sort every collection; never emit hash order),
- no timestamps, no absolute paths, no host-dependent values,
- canonical hex, little-endian byte order for memory dumps,
- every field named, so a diff is meaningful without a decoder.

### Observation

```
# dolunay-observation v0
program       <sha256 of the loaded image>
geometry      <warps>x<lanes>
schedule      replay <sha256 of the log> | policy <name> seed=0x<hex>
termination   all-wdone | timeout | deadlock | illegal
illegal       warp <w> lanes=0x<mask> pc=0x<hex>: <rule broken>
lane <w>.<l>  pc=0x<hex> exit=<reason>
warp <w>      barrier[<addr>] total=0x<hex> parked=0x<hex>
warp <w>      wreg[<name>]=0x<hex>
spad          0x<addr> : <hex bytes ...>
```

The `illegal` line appears only with `termination illegal`.

How an observation is compared depends on how the run was scheduled:

- **Replay (D15):** the model ran the RTL's own choices, so the whole
  architectural state must match **bitwise** — every line above except
  `schedule`, floats included.
- **Fast mode, or one execution against another while checking determinacy
  (D12):** only the kernel's **output** is compared — `termination`, and the
  regions its output descriptor names, under the descriptor's rules. Lines the
  descriptor does not cover are diagnostics.

Memory dumps are ranges, not whole spaces. Per-lane regions (the previous
variant's TLS, or whatever replaces it), if the new variant keeps any, are
dumped per lane in lane order.

### Replay log (D15)

The RTL simulation writes one line to standard output per choice point it
resolves, from code guarded by `` `ifndef SYNTHESIS ``, with a fixed prefix
so the lines can be separated from other output. The format is not drafted yet.
It must identify each choice in the spec's terms, never the RTL's:

- **within a warp:** the path that executes next, as warp, lane mask and PC, so
  the model stops at the first choice whose path is not ready in its own state;
- **between warps:** for each address, the order in which conflicting accesses
  took effect — a per-address order, not a global one; accesses to different
  addresses need no order;
- the value read from a timing CSR, and later DMA progress, once specified.

The RTL side must be able to emit both files. Until it can, G2 is untested —
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

The `-march` strings use `zicond` and `zalrsc`, so an old GCC rejects them —
GCC 14.2 already rejects `zalrsc` (`FINDINGS.md` F6); check the compiler before
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
| **lane** | One thread (the two words are synonyms; prefer *lane*): its own PC and architectural register state. The unit of state. |
| **warp** | A set of lanes. The unit of rendezvous and of scheduling contention. |
| **path** | The lanes of one warp that are in lockstep (D3). Split by divergence; merged by the reconvergence rule (open). |
| **agent** | Anything the scheduler can advance: a path, and — if DMA is asynchronous — a transfer. The scheduler never schedules an individual lane. |
| **choice point** | A point where the spec leaves the next step open to the implementation (§1, D12). |
| **TBD**, **unspecified**, **illegal** | The spec's three words for a gap, a free choice among listed outcomes, and something software must not do ([`spec/README.md`](spec/README.md#terminology)). |
| **valid execution** | An execution that makes some choice at every choice point and otherwise follows the spec. |
| **policy** | A pluggable rule for resolving choice points: seeded random, PCT, systematic exploration, or replay of a log. Not machine state. |
| **determinate** | Of a kernel and an input: every valid execution produces the same output (D12). |
| **output descriptor** | What a kernel declares as its output, and how each part is compared (D12). |
| **replay log** | The RTL's record of its choices, which the model replays (§4, D15). |
| **rendezvous** | The point where every lane of the active path has stopped before the same instruction, so the model can resolve it for the whole path (D11). |
| **scratchpad** | The new memory hierarchy's on-core storage; banked, DMA-fed. |
| **barrier** | A rendezvous object. Its *implementation* (memory, registers, model-internal) is a knob; its *identity* is an address or name the software passes. |
| **observation** | The dump in §4. With the replay log, the only thing exchanged between implementations. |
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
