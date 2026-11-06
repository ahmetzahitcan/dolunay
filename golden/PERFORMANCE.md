# Performance: known problem and deferred fixes

**Status: informative.** Records a known performance problem in the execution
design and the fixes we intend to try later. Correctness comes first: the model
starts with the slow, simple design below, and none of these fixes is
implemented until the slow design works and a workload shows the cost matters.
Measured facts are in [`SUBSTRATE.md`](SUBSTRATE.md#execution-control-probed-2026-11-06).

## The design this applies to

Recorded as D3 and D11 in [`DECISIONS.md`](DECISIONS.md), which win over this
summary.

- **One Renode machine per lane**, one CPU each. Renode caps a machine at 32
  cores, and per-lane machines cost no more than packed ones. Every shared
  resource (scratchpad, and later global memory and DMA) belongs to the model
  and is reached from each machine through a small bus device.
- **The path is the scheduling unit.** Lanes of a path behave as if they execute
  in lockstep; only the active path's lanes run.
- **Hooking by overriding standard opcodes.** Branches, jumps, loads, stores
  and the custom instructions are installed as custom-instruction handlers, so
  the model sees every one of them without scanning the program.
- **Lanes wait by halting** (`IsHalted = true`, `PC` left on the instruction),
  never by blocking a thread: blocking one CPU stops all of them.
- **Divergence is detected at every branch.** Each lane of the active path stops
  before the branch; when the last one arrives, the model computes every lane's
  target from its registers, groups lanes by target into paths, and releases the
  path the policy chooses.

## The problem

Every stop is a *rendezvous*: each lane of the path halts, and the last one to
arrive releases the rest. A rendezvous of 8 lanes costs **≈0.85 ms** of wall
time, and no Renode timing setting changes that (SUBSTRATE.md). The cost is in
halting and resuming CPU threads.

With a rendezvous at every branch, a path advances at roughly **1 200 branches
per second**: for typical code, a few thousand instructions per second per path.
That is the same order as single-stepping through the monitor (≈2.4 k
instructions/s), and far below what the CPUs can do between stops (≈60 MIPS each
without hooks, ≈9 MIPS with every branch overridden).

The cost per handler call is not the problem (≈150–250 ns). The halt/release
round-trip is.

## Deferred fixes, in the order to try them

### 1. The coordinator drives execution itself

Keep the machines paused and have the coordinator run each lane directly with
`TranslationCPU.ExecuteInstructions(n, out executed)`, one lane at a time, until
a handler ends the lane's run. No thread is halted or woken, everything runs on
one thread, and determinism needs no further argument.

- **Expected gain:** the halt/release round-trip disappears. The measured 2.4 k/s
  of `Step` went through the monitor, which adds a large fixed cost per command;
  a direct call should be far cheaper.
- **To verify:** throughput of direct `ExecuteInstructions` calls; how a handler
  ends a run early (halt, or a request to exit the execution loop); that this
  works with the machines' time sources paused.
- **Risk:** it relies on a public but lightly documented API; if Renode's
  execution loop assumes it owns the CPU threads, this may not be supported.

### 2. Do not stop at uniform branches

Lanes record their branch outcomes and keep running; only divergence stops them.
The handler appends the lane's k-th branch target to the lane's log and lets it
continue. The coordinator compares the k-th entries as they arrive and splits
the path as soon as two disagree. Lanes still stop at every shared or custom
event.

- **Expected gain:** halts only on divergence and at shared events, instead of
  at every branch.
- **Why it is still lockstep:** divergence is still detected at the branch,
  explicitly, and a lane that loops forever still reports every branch. A lane
  that runs ahead of its path-mates has only changed its own registers, because
  anything shared stops it.
- **To decide first:** whether this matches what the specification documents will mean by
  "lockstep". It is equivalent in what can be observed, not in how execution is
  stepped.

### 3. A multi-version scratchpad

The scratchpad keeps a log of stores tagged with their lockstep position, and
answers a load from the stores that precede it. A load then stops only when a
path-mate has not yet reached it.

- **Expected gain:** far fewer stops in memory-heavy kernels; combines with 1 or
  2.
- **Cost:** a heavier scratchpad class. This is the same class that must apply
  the architectural order of conflicting accesses anyway, so most of the
  bookkeeping is needed regardless.

## When to revisit

- When a kernel in `../ss/` or `../asm-kernels/` takes long enough under the
  model to slow down the work: checking determinacy over many schedules
  (`CONTRACT.md` §1) multiplies every run's cost.
- Before any profiling run (job G3 in `CONTRACT.md`) on realistic inputs.

Measure first. The ≈0.85 ms figure comes from a synthetic loop on one machine;
re-measure with a real kernel before choosing a fix.
