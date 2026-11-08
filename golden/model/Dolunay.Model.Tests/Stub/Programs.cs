// Small programs for the stub ISA. Each mimics the shape of a kernel in ../ss
// without its instructions.

using Dolunay.Model;

namespace Dolunay.Model.Tests.Stub
{
    internal static class Programs
    {
        public const uint Counter = 0x100;

        /// <summary>
        /// Like ss/kernels/ping_pong: two lanes of a warp take turns incrementing a
        /// counter, spinning with yield until it is their turn, for
        /// <paramref name="rounds"/> rounds each. Then the warp reconverges and
        /// finishes. Each warp uses its own counter.
        /// </summary>
        public static ScriptedIsa PingPong(int rounds) => new ScriptedIsa()
            .At(0x00, l => l.Goto(0x10))
            .At(0x10, l =>
            {
                var c = l.R[1] = l.Load(CounterOf(l.Id.Warp));
                if (c >= 2 * rounds)
                    return l.Goto(0x30);
                return c % 2 == (uint)(l.Id.Lane % 2) ? l.Goto(0x18) : l.Next();
            })
            .At(0x14, l => l.Yield(0x10))
            .At(0x18, l =>
            {
                l.Store(CounterOf(l.Id.Warp), l.R[1] + 1);
                return l.Goto(0x10);
            })
            .At(0x30, l => l.Bsync(1))
            .At(0x34, l => l.Wdone());

        public static uint CounterOf(int warp) => Counter + 4 * (uint)warp;

        /// <summary>
        /// Every lane goes to its own PC, then spins with yield <paramref name="spins"/>
        /// times, then reconverges and finishes.
        /// </summary>
        public static ScriptedIsa YieldSpin(int lanes, int spins)
        {
            var isa = new ScriptedIsa()
                .At(0x00, l => l.Goto(0x100 * (uint)(l.Id.Lane + 1)))
                .At(0x40, l => l.Bsync(1))
                .At(0x44, l => l.Wdone());
            for (var lane = 0; lane < lanes; lane++)
            {
                var start = 0x100 * (uint)(lane + 1);
                isa.At(start, l => ++l.R[0] > spins ? l.Goto(0x40) : l.Next());
                isa.At(start + 4, l => l.Yield(start));
            }
            return isa;
        }

        public static Machine Run(Geometry geometry, IInstructionSet isa, MachineOptions? options, out RunResult result)
        {
            var machine = new Machine(geometry, isa, options);
            result = machine.Run();
            return machine;
        }
    }
}
