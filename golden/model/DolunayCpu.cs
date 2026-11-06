// Dolunay's RISC-V core: the stock RiscV32 plus the model's ISA additions.
//
// This is the extension point the Renode documentation describes for custom
// RISC-V instructions ("Configuring a RISC-V CPU" → "Adding a custom RISC-V
// instruction"): derive from RiscV32 and install handlers in the constructor,
// so a .repl referencing CPU.Dolunay gets them with no extra setup.
//
// The encoding below is a provisional test instruction, not an ISA decision.

using Antmicro.Renode.Core;
using Antmicro.Renode.Logging;
using Antmicro.Renode.Peripherals.Timers;
using ELFSharp.ELF;

namespace Antmicro.Renode.Peripherals.CPU
{
    /// <summary>
    /// Dolunay's core. Currently identical to <see cref="RiscV32"/> except for
    /// one mock instruction that prints "Hello World" to the monitor.
    /// </summary>
    public class Dolunay : RiscV32
    {
        // Test instruction: custom-1 opcode (0x0B), funct3 = 7, all register and
        // immediate fields zero => 0x0000700B. Renode treats '0' and '1' as
        // significant and every other character as a wildcard, so this pattern
        // is an exact match on all 32 bits.
        private const string HelloWorldPattern = "00000000000000000111000000001011";

        public Dolunay(
            IMachine machine,
            IRiscVTimeProvider? timeProvider = null,
            uint hartId = 0,
            PrivilegedArchitecture privilegedArchitecture = PrivilegedArchitecture.Priv1_11,
            Endianess endianness = Endianess.LittleEndian,
            string cpuType = "rv32i")
            : base(machine, cpuType, timeProvider, hartId, privilegedArchitecture, endianness)
        {
            InstallCustomInstruction(
                pattern: HelloWorldPattern,
                handler: _ => this.Log(LogLevel.Info, "Hello World"),
                name: "dolunay_hello");
        }
    }
}
