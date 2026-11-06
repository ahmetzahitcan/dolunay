# Handoff — 2026-11-06

Transient session note (`AGENTS.md` §0): read it after `CONTRACT.md` and
`DECISIONS.md`, act on it, then delete it. It points into the owning files
rather than restating them; if it disagrees with them, they win.

## Where the work stands

- **Decided this session** (see `DECISIONS.md`):
  - **D9** the ISA is RISC-V + `spec/`; the CSV is only RTL input.
  - **D10** the decision log is edited in place; git holds history.
  - **D3 (reversed)** paths are the scheduling unit; lanes of a path are in
    lockstep until they diverge; divergence is detected at every branch.
  - **D11** one Renode machine per lane; branches, jumps, shared-memory accesses
    and custom instructions are overridden opcode handlers; lanes wait by
    halting; start slow.
- **Probed, not implemented.** Everything D11 relies on was verified with
  throwaway code (facts in `SUBSTRATE.md` → "Execution control"). The model code
  is still the skeleton: `CPU.Dolunay` with one placeholder instruction.
- **Known cost, accepted for now:** ≈0.85 ms per rendezvous. Problem and the
  deferred fixes, in order: `PERFORMANCE.md`.
- **Uncommitted** at the time of writing: edits to `AGENTS.md`, `CONTRACT.md`,
  `DECISIONS.md`, `DESIGN.md`, `ITS-SEMANTICS.md`, `README.md`, `SUBSTRATE.md`;
  new `PERFORMANCE.md` and this file. Ask before committing.

## Discussed but not recorded — ask before acting

**Code structure ("B3").** Two assemblies:

- `Dolunay.Model`: pure C#, no Renode reference. Geometry, lanes, warps, paths,
  the path scheduler and policy, sync and scratchpad semantics behind
  interfaces, the observation writer. Event-driven: it receives "the whole path
  stopped at instruction X" and returns a decision.
- `Dolunay.Renode`: the glue. `CPU.Dolunay`, the opcode-override table (each
  entry citing `spec/`), the coordinator that maps lanes to machines and halts or
  releases them, the scratchpad bus device, monitor commands.
- A unit-test project on `Dolunay.Model` only, so tests need no Renode.

The rule: if a signature mentions a Renode type, it belongs in the adapter; if a
branch encodes an architectural rule, it belongs in the model.

- The maintainer agreed to **NUnit**. The two-assembly split was explained and
  not objected to, but it was never explicitly approved. Confirm it, then revise
  D8 (two assemblies, NUnit).
- Also proposed: delete the `[Plugin]` class (`model/Dolunay.cs`) and
  `renode.config`. Types register without them; only the `[Plugin]` class needs
  enabling. That simplifies the launcher and `SUBSTRATE.md`.

## Suggested next steps

1. Confirm B3, then record it by revising D8.
2. Scaffold: `Dolunay.Model`, `Dolunay.Renode`, `Dolunay.Model.Tests` (NUnit).
   Update `run-renode.sh` (gitignored, machine-local) to copy both DLLs.
3. **The path coordinator in `Dolunay.Model`, test-first.** Split on divergent
   targets, park and release, yield, done, deadlock detection, and a policy
   interface that a seeded, an exploring and a replaying policy can implement
   (`CONTRACT.md` §1, D12–D15). Reconvergence is open: put it behind an
   interface with a declared default.
4. **The adapter.**
   - One machine per lane, each with one `CPU.Dolunay` and a scratchpad device
     forwarding to the model's shared scratchpad.
   - Geometry is one parameter. Generate the `.resc` that creates the machines;
     a `.repl` is per machine and identical.
   - Override branches and jumps (`jal` is uniform, but `jalr` can diverge), and
     shared-memory loads and stores.
5. The ISA documents (`spec/`) are still unwritten, so the custom instructions
   stay labelled placeholders until the maintainer writes or approves them.

## How the probes did it (code is in `golden/build/probe/`, gitignored)

- **Override a standard opcode:** `InstallCustomInstruction(pattern, handler, name)`
  with a pattern matching it, e.g. all branches:
  `new string('?', 25) + "1100011"`. A branch handler must write `PC` itself;
  otherwise `PC += 4`.
- **Stop before an instruction:** inside its handler, set `IsHalted = true` and
  `PC` = the instruction's own address, then return. On release it runs again,
  so the handler needs a per-lane "let it pass this time" flag.
- **Perform a load in the handler:** `sysbus.ReadDoubleWord(addr, cpu, null)`,
  then `SetRegister(rd, RegisterValue.Create(v, 32))`.
- **Never block a CPU thread in a handler** — it stops every CPU in the
  emulation.
- **Releasing from another lane's handler** (`other.IsHalted = false`) works.

## Working notes

- **Cap every Renode run** (`timeout -k 5 60 renode …`) and print progress. A
  blocked handler hangs Renode silently; the maintainer had to stop a run that
  hung for 10 minutes.
- **Clean up after probe runs.** A probe DLL copied into the Renode installation
  directory is loaded on every later start; remove it afterwards. Leave
  `Dolunay.Golden.dll` in place.
- **`irom.mem` / `irom.coe`** are in `.gitignore` but still tracked; the
  maintainer knows, and untracking them (`git rm --cached`) is their call.
  `FINDINGS.md` F1 and the `irom.mem` note in `CONTRACT.md` §3 become stale once
  that happens.
- **The maintainer's corrections this session**, so they are not repeated:
  - Schedule paths, not lanes.
  - Do not detect divergence lazily at sync points.
  - Correctness before speed.
