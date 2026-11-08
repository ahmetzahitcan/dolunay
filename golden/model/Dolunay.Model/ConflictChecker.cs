// The one-execution determinacy check (golden/CONTRACT.md §1, method 1): find
// conflicting accesses — same byte, at least one a store, different lanes —
// whose order a choice point decides. If there are none, every valid execution
// performs the same accesses with the same values, and the kernel is
// determinate on this input.
//
// Orders that count (happens-before), as vector clocks per lane:
// - each lane's program order;
// - the warp program order within one path: its instructions are not chosen
//   (golden/spec/EXECUTION-MODEL.md §1), so executing an instruction joins the
//   clocks of the path's lanes;
// - the order within one lockstep instruction, fixed by the spec (D14): lanes of
//   one instruction share a clock, so they never conflict with each other;
// - a split: the new paths inherit the clocks of the path they came from;
// - a bsync that combines paths: the clocks of all combined lanes are joined.
// Orders that do not count: which path or warp runs next, yield, and anything
// between warps — no synchronisation between warps is specified yet.

using System;
using System.Collections.Generic;
using System.Linq;

namespace Dolunay.Model
{
    /// <summary>One side of a conflict.</summary>
    public sealed record AccessSite(LaneRef Lane, uint Pc, AccessKind Kind)
    {
        public override string ToString() => $"{Kind.ToString().ToLowerInvariant()} by lane {Lane} at pc=0x{Pc:x}";
    }

    /// <summary>
    /// Two accesses to the same byte, at least one a store, whose order a choice
    /// point decides. <see cref="Address"/> is the address of the later access.
    /// </summary>
    public sealed record Conflict(uint Address, AccessSite Earlier, AccessSite Later)
    {
        public override string ToString() => $"0x{Address:x}: {Earlier}, then {Later}";
    }

    public sealed class ConflictChecker : IExecutionObserver
    {
        private readonly Geometry _geometry;
        private readonly int[][] _clocks;
        private readonly Dictionary<uint, ByteHistory> _history = new();
        private readonly Dictionary<(uint, uint, AccessKind, uint, AccessKind), Conflict> _conflicts = new();

        public ConflictChecker(Geometry geometry)
        {
            _geometry = geometry ?? throw new ArgumentNullException(nameof(geometry));
            _clocks = Enumerable.Range(0, geometry.Lanes).Select(_ => new int[geometry.Lanes]).ToArray();
        }

        /// <summary>
        /// The conflicts found, one per pair of access sites (address of the later
        /// access, and PC and kind of each side), in a deterministic order.
        /// </summary>
        public IReadOnlyList<Conflict> Conflicts =>
            _conflicts.Values
                .OrderBy(c => c.Address)
                .ThenBy(c => c.Earlier.Pc).ThenBy(c => c.Earlier.Kind)
                .ThenBy(c => c.Later.Pc).ThenBy(c => c.Later.Kind)
                .ThenBy(c => c.Earlier.Lane.Warp).ThenBy(c => c.Earlier.Lane.Lane)
                .ThenBy(c => c.Later.Lane.Warp).ThenBy(c => c.Later.Lane.Lane)
                .ToList();

        public void OnInstruction(int warp, LaneSet lanes)
        {
            var joined = Join(warp, lanes);
            foreach (var lane in lanes.Lanes)
                joined[Global(warp, lane)]++;
            foreach (var lane in lanes.Lanes)
                joined.CopyTo(_clocks[Global(warp, lane)], 0);
        }

        public void OnCombine(int warp, LaneSet lanes)
        {
            var joined = Join(warp, lanes);
            foreach (var lane in lanes.Lanes)
                joined.CopyTo(_clocks[Global(warp, lane)], 0);
        }

        public void OnAccess(in MemoryAccess access)
        {
            var lane = Global(access.Lane.Warp, access.Lane.Lane);
            var site = new AccessSite(access.Lane, access.Pc, access.Kind);
            var epoch = new Epoch(lane, _clocks[lane][lane]);

            for (var i = 0; i < access.Size; i++)
            {
                var address = unchecked(access.Address + (uint)i);
                if (!_history.TryGetValue(address, out var history))
                    _history[address] = history = new ByteHistory();

                if (history.Store is { } store && !Ordered(store.Epoch, lane))
                    Report(access.Address, store.Site, site);

                if (access.Kind == AccessKind.Store)
                {
                    foreach (var load in history.Loads.Values)
                        if (!Ordered(load.Epoch, lane))
                            Report(access.Address, load.Site, site);
                    history.Store = (epoch, site);
                    history.Loads.Clear();
                }
                else
                {
                    // A lane's later load supersedes its earlier ones: whatever is
                    // ordered after the later one is ordered after the earlier.
                    history.Loads[lane] = (epoch, site);
                }
            }
        }

        private bool Ordered(Epoch earlier, int lane) =>
            earlier.Lane == lane || earlier.Clock <= _clocks[lane][earlier.Lane];

        private void Report(uint address, AccessSite earlier, AccessSite later)
        {
            _conflicts.TryAdd((address, earlier.Pc, earlier.Kind, later.Pc, later.Kind), new Conflict(address, earlier, later));
        }

        private int[] Join(int warp, LaneSet lanes)
        {
            var joined = new int[_geometry.Lanes];
            foreach (var lane in lanes.Lanes)
            {
                var clock = _clocks[Global(warp, lane)];
                for (var k = 0; k < joined.Length; k++)
                    joined[k] = Math.Max(joined[k], clock[k]);
            }
            return joined;
        }

        private int Global(int warp, int lane) => warp * _geometry.LanesPerWarp + lane;

        private readonly record struct Epoch(int Lane, int Clock);

        private sealed class ByteHistory
        {
            public (Epoch Epoch, AccessSite Site)? Store;

            // Sorted, so the conflict reported first does not depend on hash order.
            public readonly SortedDictionary<int, (Epoch Epoch, AccessSite Site)> Loads = new();
        }
    }
}
