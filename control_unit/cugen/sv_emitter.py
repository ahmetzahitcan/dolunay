"""Render a :class:`ControlUnitData` as SystemVerilog module and package files."""

import math

from .model import is_dont_care

# Width of the instruction match patterns (and thus of the case selector).
MATCH_STRING_BITS = 30


def format_value(value, sig, rng, enums, external_enums):
    """Return a properly prefixed SV literal for a signal assignment."""
    if sig in external_enums:
        ext = external_enums[sig]
        if is_dont_care(value):
            return ext.undefined()
        return ext.member(value)
    if sig in enums:
        if is_dont_care(value):
            return f"{sig}_e'('x)"
        return f"{sig.upper()}_{value}"
    if is_dont_care(value):
        return "'x"
    if value in ('0', '1') and not rng:
        return f"1'b{value}"
    return value


# ---------------------------------------------------------------------------
# Module templates
# ---------------------------------------------------------------------------

# Static module preamble, up to and including the case selector.
_MODULE_HEADER = """`default_nettype none

module {module_name}
    import params_pkg::*;
    import {package_name}::*;
(
`ifndef SYNTHESIS
    input  wire logic sim__runasserts_i,
`endif
    input  wire logic [31:2] undec_instr32_i,
    input  wire logic [RLEN-1:Z_PC] pc_i,
    output instr_s instr_o
);

    {imm_type_t} imm_type_w;

    immediate_decoder u_imm(
`ifndef SYNTHESIS
        .sim__pc_i(pc_i),
        .sim__runasserts_i(sim__runasserts_i),
`endif
        .undec_instr32_i(undec_instr32_i),
        .imm_type_i(imm_type_w),
        .imm_o(instr_o.imm)
    );

    `ifndef SYNTHESIS
    string sim__disasm_format_w;
    sim__instr_formatter sim__u_instr_formatter(
        .format_i(sim__disasm_format_w),
        .rd_i(instr_o.rd_idx),
        .rs1_i(instr_o.rs1_idx),
        .rs2_i(instr_o.rs2_idx),
        .rs3_i(instr_o.rs3_idx),
        .roundmode_i(instr_o.fpu_roundmode),
        .imm_i(instr_o.imm),
        .pc_i(pc_i),
        .disasm_o(instr_o.sim__disasm)
    );
    `endif

    always_comb begin
        instr_o.rd_idx = undec_instr32_i[W_REGISTERS+6:7];
        instr_o.rs1_idx = undec_instr32_i[W_REGISTERS+14:15];
        instr_o.rs2_idx = undec_instr32_i[W_REGISTERS+19:20];
        instr_o.rs3_idx = undec_instr32_i[W_REGISTERS+26:27];
        instr_o.fpu_roundmode = undec_instr32_i[14:12];
        case (undec_instr32_i) inside
"""

# Body of the default (INVALID) case, before the signal assignments.
_MODULE_DEFAULT_CASE = '''            default: begin // INVALID
                `ifndef SYNTHESIS
                sim__disasm_format_w = "INVALID";
                if (sim__runasserts_i) begin
                    $warning("Invalid instruction (%h) encountered at %d", undec_instr32_i, pc_i);
                end
                `endif
'''

_MODULE_FOOTER = """            end
        endcase
    end

endmodule

`default_nettype wire
"""


def emit_sv_module(data, output_file, module_name, package_name, source_csv):
    """Write a SystemVerilog control-unit module from the parsed data object."""
    control_signals = data.control_signals
    default_values = data.default_values
    instructions = data.instructions
    enums = data.enums
    external_enums = data.external_enums

    # imm_type has no field in instr_s, so its type is declared here.
    imm_type_t = ('imm_type_e' if 'imm_type' not in external_enums
                  else external_enums['imm_type'].type_ref)

    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(_MODULE_HEADER.format(
            module_name=module_name,
            package_name=package_name,
            imm_type_t=imm_type_t,
        ))

        for row in instructions:
            inst = row['instruction'].strip()

            # indicates an "impossible" instruction
            # should still generate the needed enum values
            # but should not generate the case statement
            # FIXME: this is a hack
            if inst.startswith("~"):
                continue

            match_str = row['CleanMatchString']

            if len(match_str) != MATCH_STRING_BITS:
                print(f"Warning: Instruction '{inst}' match_string length is "
                      f"{len(match_str)}, expected {MATCH_STRING_BITS}. Skipping.")
                continue

            f.write(f"            {MATCH_STRING_BITS}'b{match_str}: begin // {inst}\n")
            f.write("                `ifndef SYNTHESIS\n")
            disasm = row['sim__disasm_format'].strip()
            if not disasm.startswith('"'):
                disasm = f'"{disasm}"'
            f.write(f"                sim__disasm_format_w = {disasm};\n")
            f.write("                `endif\n")
            _write_assignments(f, control_signals, row, enums, external_enums)
            f.write("            end\n")

        f.write(_MODULE_DEFAULT_CASE)
        _write_assignments(f, control_signals, default_values, enums, external_enums)
        f.write(_MODULE_FOOTER)

    print(f"Successfully generated {output_file} from {source_csv}")


def _write_assignments(f, control_signals, values, enums, external_enums):
    """Write the per-signal assignment lines for one instruction (or the default)."""
    for s in control_signals:
        raw = values.get(s.col) or ""
        if s.index is None:
            target = "imm_type_w" if s.name == "imm_type" else f"instr_o.{s.name}"
        elif s.index.isdigit():
            target = f"instr_o.{s.name}[{int(s.index)}]"
        else:
            # Identifier indices address the element through its localparam.
            target = f"instr_o.{s.name}[{s.name.upper()}_{s.index}]"
        f.write(f"                {target} = "
                f"{format_value(raw.strip(), s.name, s.rng, enums, external_enums)};\n")


# ---------------------------------------------------------------------------
# Package templates
# ---------------------------------------------------------------------------

_PACKAGE_HEADER = "`default_nettype none\n\npackage {package_name};\n\timport params_pkg::*;\n\n"

_PACKAGE_STRUCT_HEADER = (
    "\ttypedef struct packed {\n"
    "\t\t`ifndef SYNTHESIS\n"
    "\t\tsim__disasm_t sim__disasm;\n"
    "\t\t`endif\n"
    "\t\tlogic [RLEN-1:0] imm;\n"
    "\t\tlogic [W_REGISTERS-1:0] rd_idx;\n"
    "\t\tlogic [W_REGISTERS-1:0] rs1_idx;\n"
    "\t\tlogic [W_REGISTERS-1:0] rs2_idx;\n"
    "\t\tlogic [W_REGISTERS-1:0] rs3_idx;\n"
    "\t\tlogic [2:0] fpu_roundmode;\n"
)

_PACKAGE_FOOTER = "\t} instr_s;\n\nendpackage\n\n`default_nettype wire\n"


def emit_sv_package(data, output_file, package_name, source_csv):
    """Write the SystemVerilog package defining enums and the instr_s struct."""
    control_signals = data.control_signals
    enums = data.enums
    external_enums = data.external_enums
    arrays = data.arrays

    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(_PACKAGE_HEADER.format(package_name=package_name))

        for sig, values in enums.items():
            prefix = sig.upper()
            bitcount = math.ceil(math.log2(len(values)))

            if bitcount > 1:
                f.write(f"\ttypedef enum logic [{bitcount-1}:0] {{\n")
            else:
                f.write("\ttypedef enum logic {\n")

            f.write(",\n".join(f"\t\t{prefix}_{value}" for value in values) + "\n")
            f.write(f"\t}} {sig}_e;\n\n")

        if arrays:
            for name, info in arrays.items():
                upper = name.upper()
                f.write(f"\tlocalparam int LEN_{upper} = {len(info.signals)};\n")
                if not info.integer_indexed:
                    f.writelines(
                        f"\tlocalparam int {upper}_{elem.index} = {pos};\n"
                        for pos, elem in enumerate(info.signals))
            f.write("\n")

        f.write(_PACKAGE_STRUCT_HEADER)
        emitted_arrays = set()
        for s in control_signals:
            if s.name == 'imm_type':
                continue

            if s.index is not None:
                if s.name in emitted_arrays:
                    continue
                emitted_arrays.add(s.name)
                dim = f"[LEN_{s.name.upper()}-1:0]"
                if s.name in external_enums:
                    # Type is provided by another (third-party) package.
                    f.write(f"\t\t{external_enums[s.name].type_ref} {dim} {s.name};\n")
                elif s.name in enums:
                    f.write(f"\t\t{s.name}_e {dim} {s.name};\n")
                elif s.rng == "":
                    f.write(f"\t\tlogic {dim} {s.name};\n")
                else:
                    f.write(f"\t\tlogic {dim}[{s.rng}] {s.name};\n")
                continue

            if s.name in external_enums:
                # Type is provided by another (third-party) package; reference it
                # by its qualified name instead of declaring a local enum.
                f.write(f"\t\t{external_enums[s.name].type_ref} {s.name};\n")
            elif s.name in enums:
                f.write(f"\t\t{s.name}_e {s.name};\n")
            else:
                if s.rng == "":
                    f.write(f"\t\tlogic {s.name};\n")
                else:
                    f.write(f"\t\tlogic [{s.rng}] {s.name};\n")
        f.write(_PACKAGE_FOOTER)

    print(f"Successfully generated {output_file} from {source_csv}")
