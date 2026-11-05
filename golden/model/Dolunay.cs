// Dolunay golden model — Renode plugin skeleton.
//
// Built as a net8.0 assembly and loaded from Renode's plugins directory
// (golden/DECISIONS.md D8). Deliberately empty of machine semantics: warp/lane
// geometry, the memory map, the barrier context, memory ordering and the DMA
// interface are open questions (golden/CONTRACT.md §2), and inventing them here
// is the failure mode golden/AGENTS.md §2 calls "inventing the machine".

using System;

using Antmicro.Renode.Logging;
using Antmicro.Renode.Peripherals.CPU;
using Antmicro.Renode.Plugins;
using Antmicro.Renode.UserInterface;

namespace Antmicro.Renode.Plugins.Dolunay
{
    /// <summary>
    /// The type Renode discovers when this assembly sits in its plugins
    /// directory. Its constructor proves the plugin was loaded; it does nothing
    /// else yet.
    /// </summary>
    [Plugin(
        Name = "Dolunay Golden Model",
        Version = "0.0.0",
        Description = "Reference-model skeleton. Defines no machine behaviour yet.",
        Vendor = "Dolunay")]
    public sealed class GoldenPlugin : IDisposable
    {
        public GoldenPlugin(Monitor monitor)
        {
            Logger.Log(LogLevel.Info, "Dolunay.Golden plugin loaded (skeleton)");
        }

        /// <summary>
        /// Proof that the model can name the ISA layer's CPU type. This is the
        /// substrate probe, not machine behaviour: no lane state, no memory, no
        /// scheduling.
        /// </summary>
        public static string CpuTypeName(BaseRiscV cpu)
        {
            return cpu.GetType().Name;
        }

        public void Dispose()
        {
        }
    }
}
