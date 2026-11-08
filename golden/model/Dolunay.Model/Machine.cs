// The execution engine: warps, their path state, and the choice points
// (golden/spec/EXECUTION-MODEL.md §1–§2, D3, D12, D13). Each step executes one
// lockstep instruction of one warp's active path — one element of that warp's
// program order.

using System;
using System.Collections.Generic;
using System.Linq;

namespace Dolunay.Model
{
    /// <summary>The knobs of a run. Every open question has a declared default here (D16).</summary>
    public sealed record MachineOptions
    {
        /// <summary>Where every lane starts. A property of the program image, not of the machine.</summary>
        public uint EntryPc { get; init; }

        /// <summary>Lockstep instructions before the run ends as <c>timeout</c>.</summary>
        public long InstructionBudget { get; init; } = 1_000_000;

        public ISchedulePolicy Policy { get; init; } = new FirstPolicy();

        public IBarrierRule Barrier { get; init; } = new WholeWarpBarrier();

        public ILockstepOrder LockstepOrder { get; init; } = AscendingLaneOrder.Instance;

        public IExecutionObserver? Observer { get; init; }

        /// <summary>Initial shared memory; a fresh empty one when null.</summary>
        public SharedMemory? Memory { get; init; }
    }

    public sealed class Machine
    {
        private readonly IInstructionSet _isa;
        private readonly MachineOptions _options;
        private readonly WarpState[] _warps;
        private RunResult? _result;

        public Machine(Geometry geometry, IInstructionSet isa, MachineOptions? options = null)
        {
            Geometry = geometry ?? throw new ArgumentNullException(nameof(geometry));
            _isa = isa ?? throw new ArgumentNullException(nameof(isa));
            _options = options ?? new MachineOptions();
            if (_options.InstructionBudget < 0)
                throw new ArgumentOutOfRangeException(nameof(options), _options.InstructionBudget, "a negative budget");
            Memory = _options.Memory ?? new SharedMemory();
            _warps = Enumerable.Range(0, geometry.Warps)
                .Select(w => new WarpState(w, geometry.LanesPerWarp, _options.EntryPc))
                .ToArray();
        }

        public Geometry Geometry { get; }

        public SharedMemory Memory { get; }

        public IReadOnlyList<WarpState> Warps => _warps;

        public long Instructions { get; private set; }

        public RunResult Run()
        {
            RunResult? result;
            while ((result = Step()) is null)
            {
            }
            return result;
        }

        /// <summary>Execute one lockstep instruction; null while the run continues, its result once it has ended.</summary>
        public RunResult? Step()
        {
            if (_result is not null)
                return _result;
            if (_warps.All(w => w.Done))
                return Finish(Termination.AllWdone, null);

            var ready = _warps.Where(w => w.Active is not null).Select(w => w.Index).ToList();
            if (ready.Count == 0)
                return Finish(Termination.Deadlock, null);
            if (Instructions >= _options.InstructionBudget)
                return Finish(Termination.Timeout, null);

            var warp = _warps[ready[ready.Count == 1 ? 0 : Checked(_options.Policy.ChooseWarp(ready), ready.Count)]];
            var illegal = Execute(warp);
            if (illegal is not null)
                return Finish(Termination.Illegal, illegal);
            Instructions++;
            warp.CheckInvariants();
            return null;
        }

        private IllegalReport? Execute(WarpState warp)
        {
            var path = warp.Active!;
            var order = _options.LockstepOrder.Order(path.Lanes);
            if (order.Count != path.Lanes.Count || !LaneSet.Of(path.Lanes.Width, order).Equals(path.Lanes))
                throw new ModelInterfaceException("the lockstep order is not a permutation of the path's lanes");

            _options.Observer?.OnInstruction(warp.Index, path.Lanes);
            var outcomes = new List<(int Lane, LaneOutcome Outcome)>(order.Count);
            foreach (var lane in order)
            {
                var laneRef = new LaneRef(warp.Index, lane);
                var port = new LanePort(Memory, _options.Observer, laneRef, path.Pc);
                outcomes.Add((lane, _isa.Execute(laneRef, path.Pc, port)));
            }

            var kind = outcomes[0].Outcome.Kind;
            if (outcomes.Any(o => o.Outcome.Kind != kind))
                throw new ModelInterfaceException($"warp {warp.Index}: the lanes of one path executed different kinds of instruction at 0x{path.Pc:x}");

            // The path's lanes have executed an instruction, so nothing owes them any longer (D13).
            foreach (var other in warp.Paths)
                other.Owed = other.Owed.Except(path.Lanes);

            return kind switch
            {
                OutcomeKind.Next => Next(warp, path, outcomes),
                OutcomeKind.Yield => Yield(warp, path, UniformNextPc(warp, path, outcomes)),
                OutcomeKind.Bsync => Bsync(warp, path, outcomes),
                OutcomeKind.Wdone => Wdone(warp, path),
                _ => throw new ModelInterfaceException($"unknown outcome {kind}"),
            };
        }

        // Every instruction generates a set of next PCs; more than one splits the
        // path, and the next active path is one of the new ones
        // (golden/spec/EXECUTION-MODEL.md §2, D13).
        private IllegalReport? Next(WarpState warp, WarpPath path, List<(int Lane, LaneOutcome Outcome)> outcomes)
        {
            var groups = outcomes
                .GroupBy(o => o.Outcome.NextPc)
                .Select(g => (Pc: g.Key, Lanes: LaneSet.Of(path.Lanes.Width, g.Select(o => o.Lane))))
                .OrderBy(g => g.Lanes.Lowest)
                .ToList();
            if (groups.Count == 1)
            {
                path.Pc = groups[0].Pc;
                return null;
            }

            warp.Remove(path);
            var created = groups.Select(g => new WarpPath(g.Lanes, g.Pc, PathState.Paused)).ToList();
            foreach (var child in created)
                warp.Add(child);
            ChoosePath(warp, ChoiceKind.AfterSplit, created).State = PathState.Active;
            return null;
        }

        // yield: the active path pauses and a paused path that owes nothing takes
        // over; with no paused path it does nothing (golden/spec/EXECUTION-MODEL.md
        // §2). The yielding path owes every lane that can execute, so it cannot run
        // again before each of them has executed an instruction (D13).
        private IllegalReport? Yield(WarpState warp, WarpPath path, uint nextPc)
        {
            path.Pc = nextPc;
            var paused = warp.Paths.Where(p => p.State == PathState.Paused).ToList();
            if (paused.Count == 0)
                return null;
            path.Owed = paused.Aggregate(LaneSet.Empty(path.Lanes.Width), (lanes, p) => lanes.Union(p.Lanes));
            path.State = PathState.Paused;
            HandOn(warp, ChoiceKind.AfterYield);
            return null;
        }

        private IllegalReport? Bsync(WarpState warp, WarpPath path, List<(int Lane, LaneOutcome Outcome)> outcomes)
        {
            var nextPc = UniformNextPc(warp, path, outcomes);
            var barriers = outcomes.Select(o => o.Outcome.Barrier).Distinct().ToList();
            if (barriers.Count != 1)
                return new IllegalReport(warp.Index, path.Lanes, path.Pc, "the lanes of one path name different barriers in bsync");
            var barrier = barriers[0];

            path.Pc = nextPc;
            var decision = _options.Barrier.Decide(warp, path, barrier);
            if (!decision.Combines)
            {
                path.State = PathState.Blocked;
                path.Barrier = barrier;
                // A lane waiting at a barrier cannot execute, so a yielder does not wait for it (D13).
                foreach (var other in warp.Paths)
                    other.Owed = other.Owed.Except(path.Lanes);
                // With no paused path the warp is left without an active path: the
                // illegal bsync of §2, which the run reports as deadlock (§4.3).
                HandOn(warp, ChoiceKind.AfterBlock);
                return null;
            }

            if (decision.Blocked.Count == 0)
            {
                path.Pc = decision.Pc;
                return null;
            }
            foreach (var blocked in decision.Blocked)
                if (blocked.State != PathState.Blocked || !warp.Paths.Contains(blocked))
                    throw new ModelInterfaceException("a barrier rule combined a path that is not blocked in this warp");

            var lanes = decision.Blocked.Aggregate(path.Lanes, (all, p) => all.Union(p.Lanes));
            warp.Remove(path);
            foreach (var blocked in decision.Blocked)
                warp.Remove(blocked);
            warp.Add(new WarpPath(lanes, decision.Pc, PathState.Active));
            _options.Observer?.OnCombine(warp.Index, lanes);
            return null;
        }

        // Only the whole warp finishes; wdone from a path that does not hold every
        // lane is illegal (golden/spec/EXECUTION-MODEL.md §5.1).
        private static IllegalReport? Wdone(WarpState warp, WarpPath path)
        {
            if (!path.Lanes.Equals(warp.AllLanes))
                return new IllegalReport(warp.Index, path.Lanes, path.Pc, "wdone from a path that does not hold every lane of the warp");
            warp.Clear();
            warp.Done = true;
            return null;
        }

        // Pass control to a paused path that owes nothing. One always exists when
        // any path is paused: the paused path that executed least recently owes
        // nothing, because every lane it could owe has executed since.
        private void HandOn(WarpState warp, ChoiceKind kind)
        {
            var paused = warp.Paths.Where(p => p.State == PathState.Paused).ToList();
            if (paused.Count == 0)
                return;
            var eligible = paused.Where(p => p.Owed.IsEmpty).ToList();
            if (eligible.Count == 0)
                throw new InvalidOperationException($"warp {warp.Index}: paused paths, but every one owes lanes (D13 bookkeeping is wrong)");
            ChoosePath(warp, kind, eligible).State = PathState.Active;
        }

        private WarpPath ChoosePath(WarpState warp, ChoiceKind kind, IReadOnlyList<WarpPath> candidates) =>
            candidates.Count == 1
                ? candidates[0]
                : candidates[Checked(_options.Policy.ChoosePath(warp.Index, kind, candidates), candidates.Count)];

        private static int Checked(int index, int count) =>
            index >= 0 && index < count
                ? index
                : throw new ModelInterfaceException($"a policy chose candidate {index} of {count}");

        private static uint UniformNextPc(WarpState warp, WarpPath path, List<(int Lane, LaneOutcome Outcome)> outcomes)
        {
            var next = outcomes[0].Outcome.NextPc;
            if (outcomes.Any(o => o.Outcome.NextPc != next))
                throw new ModelInterfaceException($"warp {warp.Index}: lanes disagree on the next PC of a yield or bsync at 0x{path.Pc:x}");
            return next;
        }

        private RunResult Finish(Termination termination, IllegalReport? illegal)
        {
            var unfinished = _warps
                .Where(w => !w.Done)
                .SelectMany(w => w.Paths.Select(p => new PathReport(w.Index, p.Lanes, p.Pc, p.State, p.Barrier)))
                .ToList();
            _result = new RunResult(termination, Instructions, unfinished, illegal);
            return _result;
        }
    }
}
