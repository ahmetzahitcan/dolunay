// How a run ends (golden/CONTRACT.md §1 guarantee 2, §4 `termination`).

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Dolunay.Model
{
    public enum Termination
    {
        /// <summary>Every warp executed <c>wdone</c>.</summary>
        AllWdone,

        /// <summary>No warp has an active path, and not every warp is done. Exact.</summary>
        Deadlock,

        /// <summary>The instruction budget ran out. A report, not a verdict.</summary>
        Timeout,

        /// <summary>The kernel did something the spec makes illegal, and the model detected it.</summary>
        Illegal,
    }

    public static class TerminationSpelling
    {
        /// <summary>The observation's spelling (golden/CONTRACT.md §4).</summary>
        public static string Spelling(this Termination termination) => termination switch
        {
            Termination.AllWdone => "all-wdone",
            Termination.Deadlock => "deadlock",
            Termination.Timeout => "timeout",
            Termination.Illegal => "illegal",
            _ => throw new ArgumentOutOfRangeException(nameof(termination), termination, null),
        };
    }

    /// <summary>A path of a warp that had not finished when the run ended.</summary>
    public sealed record PathReport(int Warp, LaneSet Lanes, uint Pc, PathState State, BarrierId? Barrier)
    {
        public override string ToString() =>
            $"warp {Warp} lanes={Lanes} pc=0x{Pc:x} {State.ToString().ToLowerInvariant()}" + (Barrier is { } b ? $" barrier={b}" : "");
    }

    /// <summary>The illegal act that ended a run: who, where, and which rule.</summary>
    public sealed record IllegalReport(int Warp, LaneSet Lanes, uint Pc, string Reason)
    {
        public override string ToString() => $"warp {Warp} lanes={Lanes} pc=0x{Pc:x}: {Reason}";
    }

    public sealed class RunResult
    {
        internal RunResult(Termination termination, long instructions, IReadOnlyList<PathReport> unfinished, IllegalReport? illegal)
        {
            Termination = termination;
            Instructions = instructions;
            Unfinished = unfinished;
            Illegal = illegal;
        }

        public Termination Termination { get; }

        /// <summary>Lockstep instructions executed: elements of the warps' program orders, not lane-instructions.</summary>
        public long Instructions { get; }

        /// <summary>Every path of every warp not done, by warp and lowest lane — the stuck lanes for a deadlock.</summary>
        public IReadOnlyList<PathReport> Unfinished { get; }

        public IllegalReport? Illegal { get; }

        /// <summary>A canonical text, for comparing runs.</summary>
        public override string ToString()
        {
            var text = new StringBuilder();
            text.Append("termination ").Append(Termination.Spelling()).Append('\n');
            text.Append("instructions ").Append(Instructions).Append('\n');
            if (Illegal is not null)
                text.Append("illegal ").Append(Illegal).Append('\n');
            foreach (var path in Unfinished)
                text.Append("unfinished ").Append(path).Append('\n');
            return text.ToString();
        }
    }
}
