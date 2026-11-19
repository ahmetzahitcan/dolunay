#!/usr/bin/python3

import argparse
import csv
import math
import os
import re
import sys

# Matches a valid snake_case identifier: lowercase letters, digits, underscores only.
_SNAKE_CASE_RE = re.compile(r'^[a-z][a-z0-9_]*$')


# Matches a bare UPPER_CASE enum identifier (letters, digits, underscores; must start with a letter).
_ENUM_VALUE_RE = re.compile(r'^[A-Z][A-Z0-9_]*$')
# Values that mean "don't-care" rather than a real signal value.
_DONT_CARE = {'x', '-', 'd', '?'}

def extract_base_name(filename, remove_path=True):
    """Extracts the base name of a file, removing the extension and optionally the path (default: True)."""
    name = os.path.splitext(filename)[0]
    if remove_path:
        name = os.path.basename(name)
    return name


def field_base_name(field):
    """Return the bare signal name of a CSV header field.

    Strips an optional bit range ("sig[2:0]") and/or external-enum
    annotation ("sig{pkg::type}") suffix.
    """
    m = re.match(r'^([A-Za-z0-9_]+)', field.strip())
    return m.group(1) if m else field.strip()


class ExternalEnum:
    """An enum type whose definition lives in another (third-party) package.

    Such a column is declared in the CSV header by appending a brace-delimited
    annotation to the column name (the name itself must stay snake_case):

        sig{fpnew_pkg::operation_e}                       member -> fpnew_pkg::<VALUE>
        sig{fpnew_pkg::operation_e|OP_}                   member -> fpnew_pkg::OP_<VALUE>
        sig{fpnew_pkg::operation_e|OP_|fpnew_pkg::NONE}   explicit default member

    The type is emitted verbatim, so it should be fully qualified.  When no
    default/undefined member is given, don't-care values are rendered as a cast
    to the type (``fpnew_pkg::operation_e'('x)``), which works for enums that do
    not declare an ``_UNDEFINED`` member.
    """

    def __init__(self, col, type_ref, prefix="", undef_member=None):
        self.col = col
        self.type_ref = type_ref
        self.prefix = prefix
        # Package scope (e.g. "fpnew_pkg::") used to qualify enum members.
        self.scope = type_ref[:type_ref.rfind('::') + 2] if '::' in type_ref else ''
        self.undef_member = f"{self.scope}{self.prefix}{undef_member}" if undef_member else None

    def member(self, value):
        """Return the (optionally qualified) enum member for a CSV value."""
        return f"{self.scope}{self.prefix}{value}"

    def undefined(self):
        """Return the expression used for don't-care / default values."""
        if self.undef_member is not None:
            return self.undef_member
        return f"{self.type_ref}'('x)"


def parse_external_enum(col, spec):
    """Build an ExternalEnum from the brace annotation found in a CSV header."""
    parts = [p.strip() for p in spec.split('|')]
    if len(parts) > 3:
        print(f"Error: column '{col}' external enum annotation has too many "
              f"'|' separated fields: '{spec}'.")
        sys.exit(1)
    type_ref = parts[0]
    if not type_ref:
        print(f"Error: column '{col}' external enum annotation is missing a type.")
        sys.exit(1)
    prefix = parts[1] if len(parts) > 1 else ""
    undef_member = parts[2] if len(parts) > 2 and parts[2] else None
    if '::' not in type_ref:
        print(f"Warning: external enum type '{type_ref}' (column '{col}') is not "
              f"package-qualified; it must be visible where the generated files "
              f"are compiled.")
    return ExternalEnum(col, type_ref, prefix, undef_member)


def parse_csv(csv_file):
    """Parse a control-unit CSV and return a validated data object.

    Returns a dict with:
        control_signals  – list of (col_name, sv_name, sv_range) tuples
        default_values   – dict mapping col_name → raw string value (from INVALID row)
        instructions     – list of dicts, each with at minimum:
                               'instruction', 'CleanMatchString', 'SpecificBits'
                           plus one key per control-signal column
        enums            – dict mapping col_name → list[str] of ordered unique enum
                           member names, for every column whose values are all
                           bare UPPER_CASE identifiers (e.g. ALU_ADD, ALU_BEQ).
                           Columns not detected as enums are absent from this dict.
        external_enums   – dict mapping sig_name → ExternalEnum for columns whose
                           enum type is defined outside this package.  Such a
                           column is annotated in the CSV header, e.g.
                           "fpu_op{fpnew_pkg::operation_e}"; it is not declared
                           in the generated package but referenced by its
                           qualified name instead.
    """

    try:
        with open(csv_file, 'r', encoding='utf-8') as f:
            reader = csv.DictReader(f, skipinitialspace=True)
            fields = reader.fieldnames
            if not fields:
                print("Error: Empty CSV file.")
                sys.exit(1)
            fields = [f.strip() for f in fields]
            reader.fieldnames = fields
            rows = list(reader)
    except FileNotFoundError:
        print(f"Error: Could not find file {csv_file}")
        sys.exit(1)

    required = {'instruction', 'match_string', 'imm_type'}
    if not required <= {field_base_name(fl) for fl in fields}:
        print("Error: CSV must contain 'instruction', 'match_string' and 'imm_type' columns.")
        sys.exit(1)

    # Separate the INVALID (default) row from real instructions; skip comments.
    default_values = {}
    valid_rows = []
    sequence = []  # (comment text or None, row or None), in CSV order
    for row in rows:
        inst = row['instruction'].strip()
        if inst.upper() == 'INVALID':
            default_values = {k: v.strip() for k, v in row.items()}
        elif inst.startswith("'"):
            # A commented-out row; a comment with commas in it spans cells.
            cells = [(row[k] or '').strip() for k in fields] + [c.strip() for c in row.get(None) or []]
            text = ', '.join(c for c in cells if c)[1:].strip()
            sequence.append((text, None))
        else:
            valid_rows.append(row)
            sequence.append((None, row))

    if not default_values:
        print("Warning: No INVALID row found. Default values will be set to 'x'.")
        default_values = {k: 'x' for k in fields}

    # Clean match strings and drop blank rows. `layout` keeps the CSV's
    # comments, blank rows and instructions in order, for emitters that echo it:
    # ('comment', text), ('blank', None) or ('row', CsvIndex).
    instructions = []
    layout = []
    for comment, row in sequence:
        if row is None:
            layout.append(('comment', comment))
            continue
        inst = row['instruction'].strip()
        match_str = (
            row['match_string']
            .replace(' ', '')
            .replace('_', '')
            .replace('x', '?')
            .replace('X', '?')
        )
        if not inst and not match_str:
            layout.append(('blank', None))
            continue
        row['CleanMatchString'] = match_str
        row['SpecificBits'] = sum(1 for b in match_str if b in '01')
        row['CsvIndex'] = len(instructions)  # CSV order survives the sort below
        layout.append(('row', row['CsvIndex']))
        instructions.append(row)

    # Validate: no duplicate or ambiguously overlapping patterns.
    for i in range(len(instructions)):
        for j in range(i + 1, len(instructions)):
            row_a = instructions[i]
            row_b = instructions[j]
            ma = row_a['CleanMatchString']
            mb = row_b['CleanMatchString']

            if len(ma) != len(mb):
                continue

            overlap = all(
                not (b1 in '01' and b2 in '01' and b1 != b2)
                for b1, b2 in zip(ma, mb)
            )

            if overlap:
                a_sub_b = all(not (b2 in '01' and b1 != b2) for b1, b2 in zip(ma, mb))
                b_sub_a = all(not (b1 in '01' and b2 != b1) for b1, b2 in zip(ma, mb))

                if a_sub_b and b_sub_a:
                    print(f"Error: Instructions '{row_a['instruction']}' and "
                          f"'{row_b['instruction']}' have identical patterns ({ma}).")
                    print("Duplicate patterns are not allowed.")
                    sys.exit(1)

                if not (a_sub_b or b_sub_a):
                    print(f"Error: Ambiguous overlap between instruction "
                          f"'{row_a['instruction']}' ({ma}) and "
                          f"'{row_b['instruction']}' ({mb}).")
                    print("Neither pattern is a strict subset of the other.")
                    sys.exit(1)

    # Sort most-specific patterns first (more fixed bits → higher priority).
    instructions.sort(key=lambda x: x['SpecificBits'], reverse=True)

    # Parse control-signal columns: handle optional bit-width in header (e.g. "alu_op[2:0]").
    # A header may also carry an external-enum annotation (e.g. "fpu_op{fpnew_pkg::operation_e}").
    control_signals = []
    external_enums = {}  # sig_name → ExternalEnum
    for field in fields:
        if field in ('instruction', 'match_string', 'sim__disasm_format'):
            continue
        if field.startswith("'"):  # commented-out column
            continue
        m = re.match(r'^([A-Za-z0-9_]+)\s*(?:\[([^\]]+)\])?\s*(?:\{([^}]*)\})?$', field)
        if m:
            name = m.group(1)
            rng = m.group(2) if m.group(2) else ""
            ext_spec = m.group(3)
        else:
            if '{' in field or '}' in field:
                print(f"Error: malformed external enum annotation in column '{field}' "
                      f"(expected 'signal{{package::type}}').")
                sys.exit(1)
            name = field.strip()
            rng = ""
            ext_spec = None
        if not _SNAKE_CASE_RE.match(name):
            print(f"Warning: column '{name}' does not look like snake_case. "
                  f"Consider renaming it in the CSV.")
        control_signals.append((field, name, rng))
        if ext_spec is not None:
            if rng:
                print(f"Warning: column '{field}' declares both a bit range and an "
                      f"external enum; the bit range is ignored.")
            external_enums[name] = parse_external_enum(field, ext_spec)

    # -----------------------------------------------------------------------
    # Enum auto-detection
    # For each control-signal column, collect every non-empty value that
    # appears in any instruction row or in the default row.  If *all* such
    # values match the UPPER_CASE identifier pattern, the column is an enum.
    # -----------------------------------------------------------------------
    enums = {}  # col_name → ordered list of unique enum member names
    for col, name, rng in control_signals:
        if name in external_enums:
            continue  # type is defined elsewhere; never auto-declare it

        seen = []          # preserves first-appearance order
        seen_set = set()
        all_enum = True    # optimistic: assume enum until proven otherwise

        # Check the default (INVALID) row value.
        def_val = default_values.get(col, "").strip()
        if def_val and def_val.lower() not in _DONT_CARE:
            if _ENUM_VALUE_RE.match(def_val):
                if def_val not in seen_set:
                    seen.append(def_val)
                    seen_set.add(def_val)
            else:
                all_enum = False

        # Check every instruction row value.
        for row in instructions:
            val = row.get(col, "").strip() if row.get(col) else ""
            if not val or val.lower() in _DONT_CARE:
                continue
            if _ENUM_VALUE_RE.match(val):
                if val not in seen_set:
                    seen.append(val)
                    seen_set.add(val)
            else:
                all_enum = False
                break

        if all_enum and seen:
            enums[col] = seen

    # Sanity-check values used with external enums: they must be bare enum
    # member names (the generated code qualifies them with the enum's package).
    for col, name, rng in control_signals:
        ext = external_enums.get(name)
        if ext is None:
            continue
        values = [default_values.get(col, "")]
        values += [(row.get(col) or "") for row in instructions]
        for val in values:
            val = val.strip()
            if not val or val.lower() in _DONT_CARE:
                continue
            if not _ENUM_VALUE_RE.match(val):
                print(f"Warning: column '{name}' uses external enum "
                      f"'{ext.type_ref}' but value '{val}' is not a valid enum "
                      f"member name. Consider the '{{type|prefix}}' annotation form.")

    return {
        'control_signals': control_signals,
        'default_values': default_values,
        'instructions': instructions,
        'enums': enums,
        'external_enums': external_enums,
        'layout': layout,
    }


def emit_sv_module(data, output_file, module_name, package_name):
    """Write a SystemVerilog control-unit module from the parsed data object."""
    control_signals = data['control_signals']
    default_values  = data['default_values']
    instructions    = data['instructions']
    enums           = data['enums']
    external_enums  = data['external_enums']

    def _format_value(val, sig, rng):
        """Return a properly prefixed SV literal for a signal assignment."""
        if sig in external_enums:
            ext = external_enums[sig]
            if val.lower() in ('x', '-', 'd', '?') or val == "":
                return ext.undefined()
            return ext.member(val)
        if sig in enums:
            prefix = sig.upper()
            if val.lower() in ('x', '-', 'd', '?') or val == "":
                return f"{prefix}_UNDEFINED"
            else:
                return f"{prefix}_{val}"
        else:
            if val.lower() in ('x', '-', 'd', '?') or val == "":
                return "'x"
            if val in ('0', '1') and not rng:
                return f"1'b{val}"
            return val

    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("`default_nettype none\n\n")
        f.write(f"module {module_name}\n")
        f.write("    import params_pkg::*;\n")
        f.write(f"    import {package_name}::*;\n")
        f.write("(\n")
        f.write("`ifndef SYNTHESIS\n")
        f.write("    input  wire logic sim__runasserts_i,\n")
        f.write("`endif\n")
        f.write("    input  wire logic [31:2] undec_instr32_i,\n")
        f.write("    input  wire logic [RLEN-1:Z_PC] pc_i,\n")
        f.write("    output instr_s instr_o\n")
        f.write(");\n\n")
        # imm_type has no field in instr_s, so its type is declared here.
        imm_type_t = ('imm_type_e' if 'imm_type' not in external_enums
                      else external_enums['imm_type'].type_ref)
        f.write(f"    {imm_type_t} imm_type_w;\n\n")
        f.write("    immediate_decoder u_imm(\n")
        f.write("`ifndef SYNTHESIS\n")
        f.write("        .sim__pc_i(pc_i),\n")
        f.write("        .sim__runasserts_i(sim__runasserts_i),\n")
        f.write("`endif\n")
        f.write("        .undec_instr32_i(undec_instr32_i),\n")
        f.write("        .imm_type_i(imm_type_w),\n")
        f.write("        .imm_o(instr_o.imm)\n")
        f.write("    );\n\n")
        f.write("    `ifndef SYNTHESIS\n")
        f.write("    string sim__disasm_format_w;\n")
        f.write("    sim__instr_formatter sim__u_instr_formatter(\n")
        f.write("        .format_i(sim__disasm_format_w),\n")
        f.write("        .rd_i(instr_o.rd_idx),\n")
        f.write("        .rs1_i(instr_o.rs1_idx),\n")
        f.write("        .rs2_i(instr_o.rs2_idx),\n")
        f.write("        .rs3_i(instr_o.rs3_idx),\n")
        f.write("        .roundmode_i(instr_o.fpu_roundmode),\n")
        f.write("        .imm_i(instr_o.imm),\n")
        f.write("        .pc_i(pc_i),\n")
        f.write("        .disasm_o(instr_o.sim__disasm)\n")
        f.write("    );\n")
        f.write("    `endif\n\n")
        f.write("    always_comb begin\n")
        f.write("        instr_o.rd_idx = undec_instr32_i[W_REGISTERS+6:7];\n")
        f.write("        instr_o.rs1_idx = undec_instr32_i[W_REGISTERS+14:15];\n")
        f.write("        instr_o.rs2_idx = undec_instr32_i[W_REGISTERS+19:20];\n")
        f.write("        instr_o.rs3_idx = undec_instr32_i[W_REGISTERS+26:27];\n")
        f.write("        instr_o.fpu_roundmode = undec_instr32_i[14:12];\n")
        f.write("        case (undec_instr32_i) inside\n")

        for row in instructions:
            inst      = row['instruction'].strip()

            # indicates an "impossible" instruction
            # should still generate the needed enum values
            # but should not generate the case statement
            # FIXME: this is a hack
            if inst.startswith("~"):
                continue

            match_str = row['CleanMatchString']

            if len(match_str) != 30:
                print(f"Warning: Instruction '{inst}' match_string length is "
                      f"{len(match_str)}, expected 30. Skipping.")
                continue

            f.write(f"            30'b{match_str}: begin // {inst}\n")
            f.write("                `ifndef SYNTHESIS\n")
            _disasm = row['sim__disasm_format'].strip()
            if not _disasm.startswith('"'):
                _disasm = f'"{_disasm}"'
            f.write(f"                sim__disasm_format_w = {_disasm};\n")
            f.write("                `endif\n")
            for col, sig, rng in control_signals:
                val = row[col].strip() if row.get(col) else ""
                if sig == "imm_type":
                    f.write(f"                imm_type_w = {_format_value(val, sig, rng)};\n")
                else:
                    f.write(f"                instr_o.{sig} = {_format_value(val, sig, rng)};\n")
            f.write("            end\n")

        # Default (INVALID) case
        f.write("            default: begin // INVALID\n")
        f.write("                `ifndef SYNTHESIS\n")
        f.write("                sim__disasm_format_w = \"INVALID\";\n")
        f.write("                if (sim__runasserts_i) begin\n")
        f.write("                    $warning(\"Invalid instruction (%h) encountered at %d\", undec_instr32_i, pc_i);\n")
        f.write("                end\n")
        f.write("                `endif\n")
        for col, sig, rng in control_signals:
            def_val = default_values.get(col, "")
            if sig == "imm_type":
                f.write(f"                imm_type_w = {_format_value(def_val, sig, rng)};\n")
            else:
                f.write(f"                instr_o.{sig} = {_format_value(def_val, sig, rng)};\n")
        f.write("            end\n")
        f.write("        endcase\n")
        f.write("    end\n\n")
        f.write("endmodule\n\n")
        f.write("`default_nettype wire\n")

    print(f"Successfully generated {output_file} from {args.input_csv}")

def emit_sv_package(data, output_file, package_name):
    control_signals = data['control_signals']
    enums = data['enums']
    external_enums = data['external_enums']

    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("`default_nettype none\n\n")
        f.write(f"package {package_name};\n")
        f.write("\timport params_pkg::*;\n\n")

        for sig, values in enums.items():
            prefix = sig.upper()
            bitcount = math.ceil(math.log2(len(values)))

            if bitcount > 1:
                f.write(f"\ttypedef enum logic [{bitcount-1}:0] {{\n")
            else:
                f.write("\ttypedef enum logic {\n")

            f.writelines(f"\t\t{prefix}_{value},\n" for value in values)
            f.write(f"\t\t{prefix}_UNDEFINED='x\n")

            f.write(f"\t}} {sig}_e;\n\n")

        f.write("\ttypedef struct packed {\n")
        f.write("\t\t`ifndef SYNTHESIS\n")
        f.write("\t\tsim__disasm_t sim__disasm;\n")
        f.write("\t\t`endif\n")
        f.write("\t\tlogic [RLEN-1:0] imm;\n")
        f.write("\t\tlogic [W_REGISTERS-1:0] rd_idx;\n")
        f.write("\t\tlogic [W_REGISTERS-1:0] rs1_idx;\n")
        f.write("\t\tlogic [W_REGISTERS-1:0] rs2_idx;\n")
        f.write("\t\tlogic [W_REGISTERS-1:0] rs3_idx;\n")
        f.write("\t\tlogic [2:0] fpu_roundmode;\n")
        for _, sig, rng in control_signals:
            if sig == 'imm_type':
                continue

            if sig in external_enums:
                # Type is provided by another (third-party) package; reference it
                # by its qualified name instead of declaring a local enum.
                f.write(f"\t\t{external_enums[sig].type_ref} {sig};\n")
            elif sig in enums:
                f.write(f"\t\t{sig}_e {sig};\n")
            else:
                if rng == "":
                    f.write(f"\t\tlogic {sig};\n")
                else:
                    f.write(f"\t\tlogic [{rng}] {sig};\n")
        f.write("\t} instr_s;\n\n")


        f.write("endpackage\n\n")
        f.write("`default_nettype wire\n")

    print(f"Successfully generated {output_file} from {args.input_csv}")


# Register-file columns emitted as operands, and the instruction bit their
# index field starts at (RISC-V unprivileged ISA, "Base Instruction Formats";
# rs3 from the R4-type format of the "F" extension). Each index is 5 bits.
_ZIG_REG_FIELDS = [('rd', 7), ('rs1', 15), ('rs2', 20), ('rs3', 27)]
# Register-file values that name an operand. Which file it is stays in the CSV;
# the Zig operand is the bare 5-bit index.
_ZIG_REGFILES = ('I', 'F')
_ZIG_IMM_TYPES = ('I', 'S', 'B', 'U', 'J')

_ZIG_PRELUDE = '''\
//! Generated by control_unit/generate.py from control_unit/control_unit.csv.
//! Do not edit: edit the CSV and rerun the generator.
//!
//! One variant per decode row, in the CSV's order, carrying the operands the
//! row names: `rd`, `rs1`, `rs2` and `rs3` by register file, and `imm` by
//! `imm_type`. Control signals are not emitted. Rows for custom instructions
//! are the previous variant's encodings: placeholders until `golden/spec/`
//! specifies them (golden/CONTRACT.md §3).

fn reg(word: u32, comptime lsb: u5) u5 {
    return @truncate(word >> lsb);
}

fn sext(value: u32, comptime bits: u6) u32 {
    const shift: u5 = @intCast(32 - bits);
    return @bitCast(@as(i32, @bitCast(value << shift)) >> shift);
}

// Immediates as the RISC-V unprivileged ISA's "Immediate Encoding Variants"
// define them, sign-extended to 32 bits and held as the raw u32 pattern.
fn immI(w: u32) u32 {
    return sext(w >> 20, 12);
}
fn immS(w: u32) u32 {
    return sext(((w >> 25) << 5) | ((w >> 7) & 0x1f), 12);
}
fn immB(w: u32) u32 {
    return sext(((w >> 31) << 12) | (((w >> 7) & 0x1) << 11) |
        (((w >> 25) & 0x3f) << 5) | (((w >> 8) & 0xf) << 1), 13);
}
fn immU(w: u32) u32 {
    return w & 0xfffff000;
}
fn immJ(w: u32) u32 {
    return sext(((w >> 31) << 20) | (((w >> 12) & 0xff) << 12) |
        (((w >> 20) & 0x1) << 11) | (((w >> 21) & 0x3ff) << 1), 21);
}

'''


def _zig_operands(row, fields):
    """Return the (name, zig_type, zig_expr) operands of one CSV row."""
    inst = row['instruction'].strip()
    operands = []
    for name, lsb in _ZIG_REG_FIELDS:
        col = fields.get(f'{name}_regfile')
        val = (row.get(col) or '').strip() if col else ''
        if not val or val.lower() in _DONT_CARE:
            continue
        if val not in _ZIG_REGFILES:
            print(f"Error: instruction '{inst}': unknown {name}_regfile value "
                  f"'{val}' (expected one of {list(_ZIG_REGFILES)}).")
            sys.exit(1)
        operands.append((name, 'u5', f"reg(w, {lsb})"))
    val = (row.get(fields['imm_type']) or '').strip()
    if val and val.lower() not in _DONT_CARE:
        if val not in _ZIG_IMM_TYPES:
            print(f"Error: instruction '{inst}': imm_type '{val}' has no Zig "
                  f"decoding (expected one of {list(_ZIG_IMM_TYPES)}).")
            sys.exit(1)
        operands.append(('imm', 'u32', f"imm{val}(w)"))
    return operands


def emit_zig(data, output_file):
    """Write a Zig tagged union of the instructions and their decoder.

    Only the instruction name, the match pattern, the register-file columns
    (as operand presence and type) and imm_type are used; no control signal is.
    """
    fields = {field_base_name(col): col for col, _, _ in data['control_signals']}
    rows = []
    for row in data['instructions']:  # most specific first
        inst = row['instruction'].strip()
        if inst.startswith('~'):
            continue  # declares enum values only; no decode case
        match_str = row['CleanMatchString']
        if len(match_str) != 30:
            print(f"Warning: Instruction '{inst}' match_string length is "
                  f"{len(match_str)}, expected 30. Skipping.")
            continue
        # Bits 1..0 of every 32-bit instruction are 11 (RISC-V unprivileged
        # ISA, "Base Instruction-Length Encoding").
        bits = match_str + '11'
        mask = int(''.join('0' if b == '?' else '1' for b in bits), 2)
        match = int(bits.replace('?', '0'), 2)
        rows.append((row['CsvIndex'], inst, mask, match, _zig_operands(row, fields)))
    by_index = {r[0]: r for r in rows}

    def payload_type(operands):
        if not operands:
            return 'void'
        return 'struct { ' + ', '.join(f'{n}: {t}' for n, t, _ in operands) + ' }'

    def payload_value(operands):
        if not operands:
            return '{}'
        return '.{ ' + ', '.join(f'.{n} = {e}' for n, _, e in operands) + ' }'

    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(_ZIG_PRELUDE)
        # The union follows the CSV's layout: its comment rows become comments
        # and its blank rows blank lines (at most one in a row, none at either
        # end, as zig fmt requires).
        lines = []
        for kind, value in data['layout']:
            if kind == 'comment':
                lines.append(f"    // {value}" if value else "    //")
            elif kind == 'blank':
                if lines and lines[-1] != '':
                    lines.append('')
            elif value in by_index:  # '~' and malformed rows have no variant
                _, inst, _, _, operands = by_index[value]
                lines.append(f"    {inst}: {payload_type(operands)},")
        while lines and lines[-1] == '':
            lines.pop()
        f.write("pub const Instruction = union(enum) {\n")
        f.writelines(line + "\n" for line in lines)
        f.write("};\n\n")
        f.write("/// Decodes `w`, or returns null when no row matches. Rows are tried most\n")
        f.write("/// fixed bits first, so the most specific match wins (golden/CONTRACT.md §3).\n")
        f.write("pub fn decode(w: u32) ?Instruction {\n")
        for _, inst, mask, match, operands in rows:
            f.write(f"    if (w & 0x{mask:08x} == 0x{match:08x}) "
                    f"return .{{ .{inst} = {payload_value(operands)} }};\n")
        f.write("    return null;\n")
        f.write("}\n")

    print(f"Successfully generated {output_file} from {args.input_csv}")



# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description='Generate SystemVerilog control unit from a CSV sheet.'
    )
    parser.add_argument('input_csv', nargs='?', default=f"{sys.path[0]}/control_unit.csv", help='Input CSV file containing instructions and control signals')
    parser.add_argument('output_module',   nargs='?', default=f"{sys.path[0]}/../src/control_unit.sv", help='Output SystemVerilog module filename')
    parser.add_argument('output_package', nargs='?', default=None,
                        help='Output SystemVerilog package filename '
                             '(default: <output_module_no_ext>_pkg.sv)')
    parser.add_argument('--output-zig',
                        default=f"{sys.path[0]}/../golden/model/src/control_unit.zig",
                        help='Output Zig file: the instructions as a tagged union, '
                             'with their decoder (default: %(default)s)')
    args = parser.parse_args()

    if args.output_package is None:
        extless = extract_base_name(args.output_module, remove_path=False)
        args.output_package = f"{extless}_pkg.sv"

    package_name = extract_base_name(args.output_package)
    module_name = extract_base_name(args.output_module)

    data = parse_csv(args.input_csv)
    emit_sv_module(data, args.output_module, module_name, package_name)
    emit_sv_package(data, args.output_package, package_name)
    emit_zig(data, args.output_zig)
