// Dolunay golden model — Renode plugin marker.
//
// Built as a net8.0 assembly and loaded from Renode's plugins directory
// (golden/DECISIONS.md D8). The machine-facing code lives in DolunayCpu.cs:
// the model's ISA additions are installed by the CPU subclass itself, the way
// Renode's own cores do it.
//
// Deliberately empty of machine semantics: warp/lane geometry, the memory map,
// the barrier context, memory ordering and the DMA interface are open
// questions (golden/CONTRACT.md §2).

using System;

using Antmicro.Renode.Logging;
using Antmicro.Renode.Plugins;
using Antmicro.Renode.UserInterface;

namespace Antmicro.Renode.Plugins.Dolunay
{
    /// <summary>
    /// The type Renode discovers when this assembly sits in its plugins
    /// directory. Its constructor proves the assembly was loaded; it does
    /// nothing else.
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

        public void Dispose()
        {
        }
    }
}
