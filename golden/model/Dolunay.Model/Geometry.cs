// The machine's shape. Undecided (golden/CONTRACT.md §2), so it is a parameter
// with one place it is read from, never a constant (golden/AGENTS.md §4).

using System;

namespace Dolunay.Model
{
    /// <summary>How many warps the machine has, and how many lanes each warp has.</summary>
    public sealed record Geometry
    {
        public int Warps { get; }
        public int LanesPerWarp { get; }

        public Geometry(int warps, int lanesPerWarp)
        {
            if (warps < 1)
                throw new ArgumentOutOfRangeException(nameof(warps), warps, "a machine has at least one warp");
            if (lanesPerWarp < 1)
                throw new ArgumentOutOfRangeException(nameof(lanesPerWarp), lanesPerWarp, "a warp has at least one lane");
            Warps = warps;
            LanesPerWarp = lanesPerWarp;
        }

        public int Lanes => Warps * LanesPerWarp;

        /// <summary>The observation's spelling (golden/CONTRACT.md §4).</summary>
        public override string ToString() => $"{Warps}x{LanesPerWarp}";
    }
}
