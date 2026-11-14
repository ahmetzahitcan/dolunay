# Decision audit: D1 to D16

**Status: informative, an assistant's assessment, not authoritative.** Written
2026-11-14 at the maintainer's request, who said they could not tell which entries
of [`DECISIONS.md`](DECISIONS.md) are good and which are not. The maintainer has
not reviewed it, and it changes no entry. Per the rules at the top of
`DECISIONS.md`, a change of substance needs the maintainer.

**What was read:** [`DECISIONS.md`](DECISIONS.md), [`CONTRACT.md`](CONTRACT.md),
[`REDESIGN.md`](REDESIGN.md), [`SUBSTRATE.md`](SUBSTRATE.md),
[`PERFORMANCE.md`](PERFORMANCE.md), the terminology of `spec/` and the grep of it
for D14. **Not read in full:** `DESIGN.md`, `ITS-SEMANTICS.md`, most of `spec/`,
`FINDINGS.md`. A verdict that depends on those is marked.

## How each entry was judged

1. Does its *reason* still hold, whatever the code looks like?
2. Does it constrain the model, or the hardware, more than it needs to?
3. Does the redesign ([`REDESIGN.md`](REDESIGN.md)) touch it?

Verdicts: **holds**, **holds, amend** (right in substance, wording or mechanism
needs changing), **superseded**, **questionable**.

## Summary

| ID | Title | Verdict |
|---|---|---|
| D1 | Golden is the reference | holds |
| D2 | Model the next variant | holds |
| D3 | Paths are the scheduling unit | holds, amend |
| D4 | Model lives in this repository | holds |
| D5 | C# on Renode's RISC-V core | holds, amend (half of it is overturned by option C or C′) |
| D6 | Agent working rules | holds, low value as a decision |
| D7 | GCC, bare-metal names, shims | holds, low stakes |
| D8 | Pure model plus Renode adapter | holds, amend (the best entry) |
| D9 | RISC-V plus `spec/` defines the machine | holds |
| D10 | The log records current decisions | holds, not followed |
| D11 | One machine per lane on Renode | superseded, with one thing to rescue first |
| D12 | Choice points, determinate kernels | holds (the keystone), one limit |
| D13 | Paths switch cooperatively | holds, amend |
| D14 | Order within a lockstep instruction is specified | **questionable** |
| D15 | RTL checked by replay | holds, amend (floats) |
| D16 | The model's defaults | holds as defaults, not a decision |

## The entries

### D1, D2: the reference is the model, and it models the next variant

Sound, and everything else rests on them. D1 is partly a statement of process, but
the reason (a reference that follows the implementation cannot find the
implementation's defects) does not go out of date. D2's risk is that the next
variant is in flux; the knob rule of D16 and `AGENTS.md` §4 is the mitigation, and
it is the right one.

### D3: paths and lockstep

Right in substance, and the maintainer reversed it once for good reason. Amend:

- "Divergence is detected at every branch and jump" becomes *wherever the threads'
  next PCs differ* under the PC rule ([`REDESIGN.md`](REDESIGN.md) §3).
- "Every branch and jump of the active path is an event the model sees (D11)" ties
  the decision to D11's mechanism. Under the literal engine the model sees every
  instruction, so the sentence should go.
- "Lane" becomes "thread", if the terminology is agreed.

The rejected alternative (finding divergence lazily by comparing PCs at sync
events) is argued against with the RTL's implementation. The argument that holds
without the RTL is the one about a lane that never reaches a sync event.

### D4: the model lives in this repository

Fine. The reason (the ISA is shared, so the repositories would drift) holds. The
OneDrive path trouble is a separate matter and is not part of this entry.

### D5: C# on Renode's RISC-V core

Two decisions in one sentence. "C#, with no IronPython" holds, and the reason is
good. "On Renode's RISC-V core" is what options C and C′ of
[`REDESIGN.md`](REDESIGN.md) §5 would overturn, and the entry's own first reason
("RV32 + F + A semantics are commodity") is weakened by Dolunay's own
instructions and by what the 2026-11-14 probe found: Renode accepts `zicond` and
`zba` but not `zalrsc`, `zicntr` or `zihpm` as names. The entry is also padded
with measurements that belong in [`SUBSTRATE.md`](SUBSTRATE.md). It is already
provisional. Split it: keep the language choice, and replace the rest when §5 is
decided.

### D6, D7: agent rules, and the toolchain

Neither is garbage. D6's reasoning (hiding directories invites an invented
machine) is worth keeping, but the entry duplicates `AGENTS.md` and would not pass
the log's own test, "worth writing if a reader would otherwise re-litigate it". D7
is an environment fact with a good reason (a name should describe the target) and
belongs equally in `ENVIRONMENT.md`. Its claim that `-mbranch-cost` matters for a
SIMT machine is not tested here.

### D8: a pure model, and a thin Renode adapter

The best entry in the file, and the one most strengthened by the redesign. The
rule it gives, *a signature that mentions a Renode type belongs in the adapter, a
branch that encodes an architectural rule belongs in the model*, is exactly the
layering rule of [`REDESIGN.md`](REDESIGN.md) §5. Amend only the adapter's job:
the lane coordinator and the opcode overrides go, a `BaseCPU` shell and a headless
runner appear, and the pure project may split into a model and an instruction set.

### D9: RISC-V plus `spec/`, not the CSV

Right: a reference whose ISA is an implementation's decoder input cannot judge the
implementation. The weakness is not the decision but that `spec/` is barely
written, so the decision has little payload yet. Writing it is the work.

### D10: this log records current decisions

The rule is sound. The log does not follow it: D3, D5, D11 and D16 mix a decision
with a mechanism, measurements and a consequences essay, and they are the ones
with the most stale text. See "The log itself" below.

### D11: one machine per lane, overridden opcodes, rendezvous

Superseded in substance. It exists to make asynchronous execution work inside
Renode, and the literal engine plus C′ needs none of it: no machine per thread, no
opcode overrides, no halting and releasing, no 0.85 ms rendezvous.

**One thing must be rescued first.** D11 is the only place that says *the model
owns every shared resource*; `CONTRACT.md` §2 and D14's consequences rely on that
rule. It should become a decision of its own before D11 shrinks to a stub. The
principle "correctness first, slow first" also survives, and belongs in D12's
neighbourhood or in `AGENTS.md`.

### D12: choice points, refinement, determinate kernels

The keystone, and it holds. Two things to keep in view:

- **The limit.** A valid kernel is defined as determinate in its output. Kernels
  that are correct but may legitimately produce several different outputs (a
  parent array from a breadth-first search, an allocator's addresses) can only be
  expressed through the output descriptor's conditional fields, which cover some of
  them. "The output satisfies a postcondition" would be a more general descriptor,
  at the price of a checker per kernel.
- **Its neighbour.** The timing CSRs are left unconstrained, so a kernel that
  reads them is invalid. For the model they are choice points, which makes
  [`REPRODUCIBILITY.md`](REPRODUCIBILITY.md) §3 matter: they must come from a
  policy.

### D13: paths switch cooperatively

Sound as a way to keep the schedule space small enough to check. It also forbids
hardware from switching on a stall, and says so; that cost is real and the
maintainer has accepted it. Amend: "a path finishing" is listed as a switch point
but only the whole warp finishes (see the handoff); "lane" becomes "thread".

### D14: the order within a lockstep instruction is specified

**The entry I would reopen.** It says the spec defines the order in which the
accesses of one lockstep instruction take effect, "because there is no hardware
reason for the order to vary". Three problems:

1. **The reason is weak.** A banked scratchpad resolving conflicts is a hardware
   reason, and the entry itself lets the scratchpad "reorder internally" provided
   the result is as if in the defined order.
2. **It goes against D12.** D12's idea is to leave open what software should not
   depend on, and require kernels not to depend on it. D14 does the opposite for
   exactly one case.
3. **It leaves a hole.** The conflict check treats the threads of one instruction
   as ordered (D16), so it never reports a conflict between them. A kernel whose
   result depends on the order passes the check. And *which* order is still open
   (`CONTRACT.md` §2), so the decision is half made.

Two ways to go, and the spec's own terminology (`spec/README.md`) already has the
words:

| | Defined order (today) | Conflicting accesses within one instruction are *illegal* (or *unspecified*) |
|---|---|---|
| Software | may rely on a deterministic last writer | must not depend on the order |
| Hardware | must reproduce the order | free to reorder |
| Conflict check | blind to these | reports them, so a kernel passes only if it does not depend on them |
| `illegal` termination | not involved | can be reported when detected |

I lean toward the right column, but it is the maintainer's decision, and a defined
order would be a reasonable choice if some kernel needs a deterministic last
writer. Open question for the maintainer: does one?

### D15: the RTL is checked by replaying its choices

A strong idea: a mismatch is a definite defect, and the model stays independent of
the RTL. Two caveats. It is the least proven decision, because the RTL cannot emit
the log yet (G2 is untested, as `CONTRACT.md` §4 says), and the per-address order
of conflicting accesses reaches into the memory system's design. And its float
clause (replay compares floats bitwise) is one the maintainer does not agree with;
see [`REDESIGN.md`](REDESIGN.md) §9. Amend the clause when that is decided.

### D16: the model's defaults

A registry of knobs and defaults, which is useful, but it is not one decision. Its
items have different fates: `WholeWarpBarrier` breaks the PC rule and is a
placeholder; the ascending lane order depends on D14; sequential consistency as a
default is reasonable, and its claim that it suffices for kernels the conflict
check passes is the data-race-free argument, which holds only if the checker's
"ordered" relation matches the architecture's; the SplitMix64 choice and the
`illegal` termination class are fine. The paragraph defining the conflict check is
specification, and it sits in the decision log. Move the registry to the model's
own documentation and leave the decisions in `DECISIONS.md`.

## The log itself

- **Entries are overloaded.** D3, D5, D11 and D16 break the log's own format
  (decision, reason, alternatives, consequences, one or two sentences each).
- **Rationale and measurement are in the wrong place.** The 0.85 ms and 2.4 k
  figures in D5 and D11 belong in `SUBSTRATE.md` and `PERFORMANCE.md`.
- **Decisions that should exist and do not:** that the model owns shared memory
  (D11 holds it by accident); the terminology *thread*; the PC rule; whole-warp
  finishing (`spec/EXECUTION-MODEL.md` §5.1 calls it a direction); the literal
  engine; the choice of instruction layer; the float comparison.

## Suggested order

1. The maintainer decides D14, because it changes the checker and the spec.
2. Write the decision "the model owns shared memory", so that D11 can shrink to a
   stub.
3. When [`REDESIGN.md`](REDESIGN.md) §4 and §5 are decided: amend D3, D5, D8, D11,
   D13 and the float clause of D15, through the decisions protocol
   ([`AGENTS.md`](AGENTS.md) §5), each as its own commit.
4. Move D16's registry out of the log, and trim the overloaded entries.
