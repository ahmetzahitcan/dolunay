// bsync is the only way paths combine (golden/spec/EXECUTION-MODEL.md §2). Its
// identity, expected set and release condition are open (§5.2) and are being
// rethought with the memory redesign, so the rule is a knob.

using System;
using System.Collections.Generic;
using System.Linq;

namespace Dolunay.Model
{
    /// <summary>What a <c>bsync</c> does: block the active path, or combine it with blocked paths.</summary>
    public sealed class BarrierDecision
    {
        private BarrierDecision(bool combines, IReadOnlyList<WarpPath> blocked, uint pc)
        {
            Combines = combines;
            Blocked = blocked;
            Pc = pc;
        }

        public static BarrierDecision Block { get; } = new(false, Array.Empty<WarpPath>(), 0);

        /// <summary>Combine the active path with <paramref name="blocked"/> into one active path at <paramref name="pc"/>.</summary>
        public static BarrierDecision Combine(IReadOnlyList<WarpPath> blocked, uint pc) => new(true, blocked, pc);

        public bool Combines { get; }

        public IReadOnlyList<WarpPath> Blocked { get; }

        public uint Pc { get; }
    }

    public interface IBarrierRule
    {
        /// <summary>
        /// Decide a <c>bsync</c> on <paramref name="barrier"/> by <paramref name="active"/>,
        /// whose PC is already the instruction after the <c>bsync</c>. Must not
        /// change any state.
        /// </summary>
        BarrierDecision Decide(WarpState warp, WarpPath active, BarrierId barrier);
    }

    /// <summary>
    /// Declared default, a placeholder (D16): combine once every lane of the warp
    /// is in the active path or blocked on the same barrier; the combined path
    /// continues after the active path's <c>bsync</c>. Otherwise block. Matches the
    /// whole-warp <c>bsync</c> before <c>wdone</c> in the previous variant's
    /// <c>crt0.s</c>.
    /// </summary>
    public sealed class WholeWarpBarrier : IBarrierRule
    {
        public BarrierDecision Decide(WarpState warp, WarpPath active, BarrierId barrier)
        {
            var waiting = warp.Paths
                .Where(p => p.State == PathState.Blocked && p.Barrier == barrier)
                .ToList();
            var arrived = waiting.Aggregate(active.Lanes, (lanes, p) => lanes.Union(p.Lanes));
            return arrived.Equals(warp.AllLanes)
                ? BarrierDecision.Combine(waiting, active.Pc)
                : BarrierDecision.Block;
        }
    }
}
