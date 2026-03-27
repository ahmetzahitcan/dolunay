import csv
import sys
import argparse
import re
import math

# Matches a valid snake_case identifier: lowercase letters, digits, underscores only.
_SNAKE_CASE_RE = re.compile(r'^[a-z][a-z0-9_]*$')


# Matches a bare UPPER_CASE enum identifier (letters, digits, underscores; must start with a letter).
_ENUM_VALUE_RE = re.compile(r'^[A-Z][A-Z0-9_]*$')
# Values that mean "don't-care" rather than a real signal value.
_DONT_CARE = {'x', '-', 'd', '?'}


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
    """
    try:
        with open(csv_file, 'r', encoding='utf-8') as f:
            reader = csv.DictReader(f)
            fields = reader.fieldnames
            if not fields:
                print("Error: Empty CSV file.")
                sys.exit(1)
            rows = list(reader)
    except FileNotFoundError:
        print(f"Error: Could not find file {csv_file}")
        sys.exit(1)

    if 'instruction' not in fields or 'match_string' not in fields:
        print("Error: CSV must contain 'instruction' and 'match_string' columns.")
        sys.exit(1)

    # Separate the INVALID (default) row from real instructions; skip comments.
    default_values = {}
    valid_rows = []
    for row in rows:
        inst = row['instruction'].strip()
        if inst.upper() == 'INVALID':
            default_values = {k: v.strip() for k, v in row.items()}
        elif inst.startswith("'"):
            continue  # commented-out row
        else:
            valid_rows.append(row)

    if not default_values:
        print("Error: CSV must contain an 'INVALID' row to define default signal values.")
        sys.exit(1)

    # Clean match strings and drop blank rows.
    instructions = []
    for row in valid_rows:
        inst = row['instruction'].strip()
        match_str = (
            row['match_string']
            .replace(' ', '')
            .replace('_', '')
            .replace('x', '?')
            .replace('X', '?')
        )
        if not inst and not match_str:
            continue
        row['CleanMatchString'] = match_str
        row['SpecificBits'] = sum(1 for b in match_str if b in '01')
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
    # The script appends "_o" to each name in the emitted SV — do not include it in the CSV.
    control_signals = []
    for field in fields:
        if field in ('instruction', 'match_string'):
            continue
        if field.startswith("'"):  # commented-out column
            continue
        m = re.match(r'^([A-Za-z0-9_]+)\s*(?:\[([^\]]+)\])?$', field)
        if m:
            name = m.group(1)
            rng = m.group(2) if m.group(2) else ""
        else:
            name = field.strip()
            rng = ""
        if not _SNAKE_CASE_RE.match(name):
            print(f"Warning: column '{name}' does not look like snake_case. "
                  f"Consider renaming it in the CSV.")
        control_signals.append((field, name, rng))

    # -----------------------------------------------------------------------
    # Enum auto-detection
    # For each control-signal column, collect every non-empty value that
    # appears in any instruction row or in the default row.  If *all* such
    # values match the UPPER_CASE identifier pattern, the column is an enum.
    # -----------------------------------------------------------------------
    enums = {}  # col_name → ordered list of unique enum member names
    for col, name, rng in control_signals:
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

    return {
        'control_signals': control_signals,
        'default_values': default_values,
        'instructions': instructions,
        'enums': enums,
    }


def emit_sv_module(data, output_file, package_name):
    """Write a SystemVerilog control-unit module from the parsed data object."""
    control_signals = data['control_signals']
    default_values  = data['default_values']
    instructions    = data['instructions']
    enums           = data['enums']

    module_name = output_file.split('/')[-1].split('.')[0]

    def _format_value(val, sig, rng):
        """Return a properly prefixed SV literal for a signal assignment."""
        if val.lower() in ('x', '-', 'd', '?') or val == "":
            if sig in enums:
                return "UNDEFINED"
            else:
                return "'x"
        if val in ('0', '1') and not rng:
            return f"1'b{val}"
        return val

    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("`default_nettype none\n\n")
        f.write(f"module {module_name}\n")
        f.write(f"    import {package_name}::*;\n")
        f.write("(\n")
        f.write("    input  wire  [31:2] instr_i,\n")
        f.write("    output control_signals_s control_signals_o\n")
        f.write(");\n\n")
        f.write("    always_comb begin\n")
        f.write("        case (instr_i) inside\n")

        for row in instructions:
            inst      = row['instruction'].strip()
            match_str = row['CleanMatchString']

            if len(match_str) != 30:
                print(f"Warning: Instruction '{inst}' match_string length is "
                      f"{len(match_str)}, expected 30. Skipping.")
                continue

            f.write(f"            30'b{match_str}: begin // {inst}\n")
            for col, sig, rng in control_signals:
                val = row[col].strip() if row.get(col) else ""
                f.write(f"                control_signals_o.{sig} = {_format_value(val, sig, rng)};\n")
            f.write("            end\n")

        # Default (INVALID) case
        f.write("            default: begin // INVALID\n")
        for col, sig, rng in control_signals:
            def_val = default_values.get(col, "")
            f.write(f"                control_signals_o.{sig} = {_format_value(def_val, sig, rng)};\n")
        f.write("            end\n")
        f.write("        endcase\n")
        f.write("    end\n\n")
        f.write("endmodule\n\n")
        f.write("`default_nettype wire\n")

    print(f"Successfully generated {output_file} from {args.input_csv}")

def emit_sv_package(data, output_file, package_name):
    control_signals = data['control_signals']
    enums = data['enums']

    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("`default_nettype none\n\n")
        f.write(f"package {package_name};\n\n")

        for sig, values in enums.items():
            bitcount = math.ceil(math.log2(len(values)))

            if bitcount > 1:
                f.write(f"\ttypedef enum logic [{bitcount-1}:0] {{\n")
            else:
                f.write(f"\ttypedef enum logic {{\n")

            for value in values:
                f.write(f"\t\t{value},\n")
            f.write("\t\tUNDEFINED='x\n")

            f.write(f"\t}} {sig}_e;\n\n")

        f.write("\ttypedef struct packed {\n")
        for _, sig, rng in control_signals:
            if sig in enums:
                f.write(f"\t\t{sig}_e {sig};\n")
            else:
                if rng == "":
                    f.write(f"\t\tlogic {sig};\n")
                else:
                    f.write(f"\t\tlogic {rng} {sig};\n")
        f.write(f"\t}} control_signals_s;\n\n")


        f.write("endpackage\n\n")
        f.write("`default_nettype wire\n")

    print(f"Successfully generated {output_file} from {args.input_csv}")

        

# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description='Generate SystemVerilog control unit from a CSV sheet.'
    )
    parser.add_argument('input_csv', help='Input CSV file containing instructions and control signals')
    parser.add_argument('output_module',  help='Output SystemVerilog module filename')
    parser.add_argument('output_package', nargs='?', default=None,
                        help='Output SystemVerilog package filename '
                             '(default: <output_module_no_ext>_pkg.sv)')
    args = parser.parse_args()

    if args.output_package is None:
        base = args.output_module.rsplit('.', 1)[0]
        args.output_package = f"{base}_pkg.sv"

    package_name = args.output_package.rsplit('/', 1)[-1].rsplit('.', 1)[0]

    data = parse_csv(args.input_csv)
    emit_sv_module(data, args.output_module, package_name)
    emit_sv_package(data, args.output_package, package_name)
