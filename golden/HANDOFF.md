# Handoff

**Status: where the work stood on 2026-11-14, on branch `renode`, on top of the
commit "more redesign". The changes below are not committed.** It is not
authoritative. Read it after [`CONTRACT.md`](CONTRACT.md) and
[`DECISIONS.md`](DECISIONS.md), and delete it once its content has been acted on or
moved to its owning file ([`AGENTS.md`](AGENTS.md) §0). It replaces the handoff of
2026-11-13 (in git history); what that one said and is still true is carried
forward below.

## Where the work stands

- **Design and probing, not code.** `Dolunay.Model`, its 39 tests (all passed on
  2026-11-13; not re-run since) and the placeholder `Dolunay.Renode` are unchanged.
  Nothing outside `golden/` was touched.
- **Three documents are new or changed, none authoritative, none committed:**
  - [`REDESIGN.md`](REDESIGN.md), **revised.** §5 is rewritten around a new option
    C′ and carries the results of a probe; §9 (floats under replay) is new; the old
    §9 is now §10. **Read this first.**
  - [`REPRODUCIBILITY.md`](REPRODUCIBILITY.md), **new.** What guarantee 1 is for,
    what it does and does not give, and what the probe says about controlling
    Renode's scheduler.
  - [`DECISION-AUDIT.md`](DECISION-AUDIT.md), **new.** An assistant's verdict on
    each of D1 to D16.
- **[`AGENTS.md`](AGENTS.md) was amended at the maintainer's request:** §0 lists
  the three files as proposals and says not to cite them as decisions, tells agents
  to keep *lane* until `CONTRACT.md` §6 changes, marks `ss/` and `asm-kernels/` as
  the previous variant's, fixes "spec not written yet", and adds a Renode trap for
  probing a CPU of our own to §7. Nothing else in it changed; §6 still describes the
  code, which has not changed.
- **Spec:** [`spec/EXECUTION-MODEL.md`](spec/EXECUTION-MODEL.md) is still the draft
  of 2026-11-08; the PC rule is not in it. No custom instruction or CSR has an
  encoding.

## What the maintainer has said, and what is still open

Stated by the maintainer, so safe to build on once they confirm the wording:

- **Terminology.** *Thread* is Dolunay's unit of state; *lane* is retired from the
  golden model. `CONTRACT.md` §6 still prefers *lane*, so the documents and code
  still say *lane*.
- **The PC rule.** For every instruction in a thread's program order, the next PC
  does not depend on the immediate state of any other thread
  ([`REDESIGN.md`](REDESIGN.md) §3).
- **Async versus sync is a question of how an instruction is executed**, not of
  three instruction sets.
- **New on 2026-11-14.** Dolunay could be a Renode CPU of its own, not a `RiscV32`
  variant, and **one CPU holds one warp**, as a `RiscV32` is one hart. The kernels
  in `ss/` and `asm-kernels/` belong to the previous variant and **will be
  rewritten**, so nothing in them is a requirement (UART, printf, MMIO, the
  instruction set). **Floats under replay should be compared within a tolerance**,
  not bitwise; to be settled later. Reproducibility is something the maintainer
  wants to think about; they doubt that it alone delivers the guarantees, and are
  unsure it is necessary.

Proposed by an assistant, not decided:

- **Run the spec literally first** ([`REDESIGN.md`](REDESIGN.md) §4): one host
  thread, only the active path runs, one step is one path step.
- **The instruction layer** ([`REDESIGN.md`](REDESIGN.md) §5), option **C′**: a
  `BaseCPU` subclass per warp, with the interpreter in a pure project, a thin Renode
  shell, and a headless runner that carries exploration and replay. The other
  options (A: stepped `RiscV32`; B: a plain interpreter; C: B plus Renode as an
  oracle) are still on the table.
- **The decision audit** ([`DECISION-AUDIT.md`](DECISION-AUDIT.md)): in short, D1,
  D2, D8, D9, D12 and D15 are the foundations; D11 is superseded, but it is the
  only place that says the model owns shared memory, so that rule needs its own
  decision first; D14 is questionable and is the one the audit asks the maintainer
  to reopen (a defined order of conflicting accesses within one instruction, against
  making them illegal).

## What the probe of 2026-11-14 showed

Full detail is in [`REDESIGN.md`](REDESIGN.md) §5 and
[`REPRODUCIBILITY.md`](REPRODUCIBILITY.md) §4. Renode 1.17.0, a throwaway CPU that
was built outside the repository and removed from the Renode tree afterwards; the
source was not kept.

- A `BaseCPU` subclass with only its four abstract members loads from a `.repl`;
  `LoadELF`, `Step`, `PC` and registers by number work. Registers by name need a
  mapping.
- Parallel mode: the order of calls differs on every run. Serial mode
  (`emulation SetGlobalSerialExecution True`): identical on every run.
- Steering which warp runs works in serial mode only if a warp that is not on turn
  **reports its quantum as done without executing**. Returning zero instructions
  stalls serial mode.
- Not tested: real shared state, more than 32 CPUs, anything Renode schedules itself
  (timers, peripherals, the time source), and what the false instruction count does
  to Renode.
- A stock `RiscV32` shares a machine with such a CPU. It accepts `zicond` and `zba`
  and rejects `zalrsc`, `zicntr` and `zihpm` as names.

## What comes next

1. **The maintainer reads [`DECISION-AUDIT.md`](DECISION-AUDIT.md),
   [`REPRODUCIBILITY.md`](REPRODUCIBILITY.md) and [`REDESIGN.md`](REDESIGN.md)** and
   decides: D14; the wording of guarantee 1 ([`REPRODUCIBILITY.md`](REPRODUCIBILITY.md)
   §5); [`REDESIGN.md`](REDESIGN.md) §4 and §5; floats under replay (§9). **Do not
   start code before the last two.**
2. **A second, short probe** if C′ stays the lean: real shared state under serial
   execution, more than 32 CPUs, register names, and whether the burned quantum
   survives a real model.
3. **Write the decision "the model owns shared memory"**, so D11 can become a stub.
4. **Amend the authoritative documents** through the decisions protocol
   ([`AGENTS.md`](AGENTS.md) §5), each as its own commit: D3, D5, D8, D11, D13, the
   float clause of D15, `CONTRACT.md` §6 and guarantees 1 and 2, and the PC rule and
   illegal `bsync` in `spec/`.
5. **Rename *lane* to *thread*** in code and tests, as its own change.
6. **First code on the new seam**, on the stub ISA: a per-warp step over a shared
   world, and the PC rule in `WholeWarpBarrier`.

Still open from earlier handoffs: write the first real `spec/` document with the
maintainer (`yield`, `wdone`, the warp-id and thread-id CSRs); the observation
writer (`CONTRACT.md` §4, whose `barrier[<addr>] total parked` line comes from the
previous variant); and exploration (PCT, then partial-order reduction), which can be
built on the stub ISA.

**Do not design `bsync`'s release rule on your own.** The maintainer is rethinking
it along with the memory redesign. `WholeWarpBarrier` is a placeholder.

## Known gaps

- **The ISA seam is wrong and will change.** `IInstructionSet.Execute` returns a
  per-thread outcome and `Machine` checks that the kinds agree, but the kind is a
  property of the instruction and the decision is the path's
  ([`REDESIGN.md`](REDESIGN.md) §2). Under C′ `Machine` also has to be split into a
  per-warp step and a shared world.
- **`WholeWarpBarrier` breaks the PC rule.** It combines at the active path's PC and
  never looks at the blocked paths' PCs.
- **The conflict check depends on an undecided order.** It treats the threads of one
  instruction as ordered (D14), so it never reports a conflict between them, and
  which order is open. A kernel whose result depends on it passes the check
  ([`DECISION-AUDIT.md`](DECISION-AUDIT.md), D14).
- **Mutex-based kernels can't run yet.** `nearn` and `spmc` use a mutex, and whether
  LR/SC survives is open (`CONTRACT.md` §2). The model has no atomics.
- **The conflict check has no synchronisation between warps**, and doesn't flag
  kernels that read the timing CSRs. So "no conflicts" isn't yet a full determinacy
  verdict for real kernels.
- **Memory is sequentially consistent only.** D16's argument for why this is enough
  depends on RVWMO with "warp" read as "hart", which is unconfirmed
  (`spec/EXECUTION-MODEL.md` §5.3).
- **`README.md`'s editor setup covers only Zed.** For VS Code's C# extension the
  Renode tree must reach the language server through its
  `dotnet.server.environmentVariables` user setting (`RENODE_BIN`); without it the
  Renode project reports `RENODE_BIN is not set`. Keep the value out of the
  repository (`CONTRACT.md` §5).

## Stale wording to fix

Found earlier and not changed. The first three are wording in authoritative files,
so check with the maintainer:

- **`CONTRACT.md` §1 and D13** list "a path finishing" as a switch point. Under the
  agreed direction only the whole warp finishes.
- **`CONTRACT.md` §2 and §6:** the "Termination condition" row looks answered by
  guarantee 2 and `wdone`, though the draft's §5 still treats finishing as a
  direction. The *path* entry still says "merged by the reconvergence rule (open)",
  but D3 says only `bsync` combines paths.
- **`CONTRACT.md` §2** says `spec/` is "not written yet", and so does
  **`README.md`**. A draft exists now, though nothing in it is authoritative.
  (`AGENTS.md` §0 has been fixed.)
- **`spec/EXECUTION-MODEL.md` §5.1** still calls whole-warp finishing a "direction";
  it needs a decision entry before the draft can be approved.

## Things that are easy to get wrong

- **`REDESIGN.md`, `REPRODUCIBILITY.md` and `DECISION-AUDIT.md` are proposals and
  assessments.** Don't cite them as decisions, and don't edit the authoritative
  documents to match them without the maintainer.
- **Design before code, in small steps.** The maintainer wants the structure
  discussed in prose and agreed first, then changed in small reviewable pieces.
- **Don't fix `nearn` or `spmc`.** The races are kept on purpose to test the check
  (F4, F5). And don't treat the old kernels as requirements for the next variant.
- **Don't change anything outside `golden/`.** Record problems in
  [`FINDINGS.md`](FINDINGS.md), including the GCC version note in `ENVIRONMENT.md`
  (F6).
- **Ask before committing, and before any architectural choice.** The maintainer
  gives approval per commit (`AGENTS.md` §5).
- **Toolchain:** the kernels need GCC 15 (F6). `CONTRACT.md` §5 says what the work
  needs. Each machine sets up its own, and those details stay out of the repository.
- **Renode runs:** read `AGENTS.md` §7 first, cap every run, and remove any probe
  DLL from the Renode tree when done. A Windows host may block loading Renode's
  assemblies into a helper process; reading their metadata instead works without
  loading them.
