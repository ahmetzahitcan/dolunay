// A warp's path state (golden/spec/EXECUTION-MODEL.md §1): its lanes are
// partitioned into paths, exactly one of them active, the others paused or
// blocked in bsync. The state is architectural; the model carries it through
// the warp program order.

using System;
using System.Collections.Generic;
using System.Linq;

namespace Dolunay.Model
{
    public enum PathState
    {
        Active,
        Paused,
        Blocked,
    }

    /// <summary>A set of lanes of one warp in lockstep, with one PC (D3).</summary>
    public sealed class WarpPath
    {
        internal WarpPath(LaneSet lanes, uint pc, PathState state)
        {
            Lanes = lanes;
            Pc = pc;
            State = state;
            Owed = LaneSet.Empty(lanes.Width);
        }

        public LaneSet Lanes { get; }

        public uint Pc { get; internal set; }

        public PathState State { get; internal set; }

        /// <summary>The barrier a blocked path waits at; null unless blocked.</summary>
        public BarrierId? Barrier { get; internal set; }

        /// <summary>
        /// The lanes that must still execute an instruction before this path may
        /// run again, after it yielded (D13). A paused path is eligible to receive
        /// control only when this is empty.
        /// </summary>
        public LaneSet Owed { get; internal set; }

        public override string ToString() =>
            $"lanes={Lanes} pc=0x{Pc:x} {State.ToString().ToLowerInvariant()}" + (Barrier is { } b ? $" barrier={b}" : "");
    }

    public sealed class WarpState
    {
        private readonly List<WarpPath> _paths = new();

        internal WarpState(int index, int lanesPerWarp, uint entryPc)
        {
            Index = index;
            AllLanes = LaneSet.All(lanesPerWarp);
            _paths.Add(new WarpPath(AllLanes, entryPc, PathState.Active));
        }

        public int Index { get; }

        public LaneSet AllLanes { get; }

        /// <summary>Set by <c>wdone</c>; finishing is per warp (golden/spec/EXECUTION-MODEL.md §5.1).</summary>
        public bool Done { get; internal set; }

        /// <summary>The paths, ordered by their lowest lane.</summary>
        public IReadOnlyList<WarpPath> Paths => _paths;

        /// <summary>The active path, or null when the warp is done or every path is blocked.</summary>
        public WarpPath? Active => _paths.FirstOrDefault(p => p.State == PathState.Active);

        internal void Add(WarpPath path)
        {
            _paths.Add(path);
            _paths.Sort((a, b) => a.Lanes.Lowest.CompareTo(b.Lanes.Lowest));
        }

        internal void Remove(WarpPath path)
        {
            if (!_paths.Remove(path))
                throw new InvalidOperationException("path not in this warp");
        }

        internal void Clear() => _paths.Clear();

        /// <summary>Throws if the path state breaks golden/spec/EXECUTION-MODEL.md §1.</summary>
        public void CheckInvariants()
        {
            if (Done)
            {
                if (_paths.Count != 0)
                    throw new InvalidOperationException($"warp {Index} is done but has paths");
                return;
            }

            var covered = LaneSet.Empty(AllLanes.Width);
            foreach (var path in _paths)
            {
                if (path.Lanes.IsEmpty)
                    throw new InvalidOperationException($"warp {Index} has an empty path");
                if (path.Lanes.Overlaps(covered))
                    throw new InvalidOperationException($"warp {Index}: a lane is in two paths");
                covered = covered.Union(path.Lanes);
                if ((path.State == PathState.Blocked) != (path.Barrier is not null))
                    throw new InvalidOperationException($"warp {Index}: a path's barrier disagrees with its state");
                if (path.State != PathState.Paused && !path.Owed.IsEmpty)
                    throw new InvalidOperationException($"warp {Index}: a path that is not paused owes lanes");
            }
            if (!covered.Equals(AllLanes))
                throw new InvalidOperationException($"warp {Index}: lanes {AllLanes.Except(covered)} are in no path");

            var active = _paths.Count(p => p.State == PathState.Active);
            if (active > 1)
                throw new InvalidOperationException($"warp {Index} has {active} active paths");
            if (active == 0 && _paths.Any(p => p.State == PathState.Paused))
                throw new InvalidOperationException($"warp {Index} has paused paths but no active one");
        }
    }
}
