"""Parse and validate a control-unit CSV sheet into a :class:`ControlUnitData`."""

import csv
import re
import sys

from .model import ControlUnitData, ExternalEnum, is_dont_care

# Matches a valid snake_case identifier: lowercase letters, digits, underscores only.
_SNAKE_CASE_RE = re.compile(r'^[a-z][a-z0-9_]*$')

# Matches a bare UPPER_CASE enum identifier (letters, digits, underscores; must start with a letter).
_ENUM_VALUE_RE = re.compile(r'^[A-Z][A-Z0-9_]*$')

# Columns that hold metadata rather than a control signal.
_NON_SIGNAL_COLUMNS = {'instruction', 'match_string', 'sim__disasm_format'}
_REQUIRED_COLUMNS = {'instruction', 'match_string', 'imm_type'}


def field_base_name(field):
    """Return the bare signal name of a CSV header field.

    Strips an optional bit range ("sig[2:0]") and/or external-enum
    annotation ("sig{pkg::type}") suffix.
    """
    m = re.match(r'^([A-Za-z0-9_]+)', field.strip())
    return m.group(1) if m else field.strip()


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
    """Parse a control-unit CSV and return a validated :class:`ControlUnitData`."""
    fields, rows = _read_csv(csv_file)
    _require_columns(fields)
    default_values, valid_rows = _split_rows(rows, fields)
    instructions = _build_instructions(valid_rows)
    _reject_ambiguous_patterns(instructions)
    # Sort most-specific patterns first (more fixed bits -> higher priority).
    instructions.sort(key=lambda x: x['SpecificBits'], reverse=True)
    control_signals, external_enums = _parse_control_signals(fields)
    enums = _detect_enums(control_signals, external_enums, default_values, instructions)
    _warn_on_bad_external_enum_values(
        control_signals, external_enums, default_values, instructions)

    return ControlUnitData(
        control_signals=control_signals,
        default_values=default_values,
        instructions=instructions,
        enums=enums,
        external_enums=external_enums,
    )


def _read_csv(csv_file):
    """Read the CSV and return its (stripped) header fields and row dicts."""
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
    return fields, rows


def _require_columns(fields):
    """Abort if any mandatory column is missing."""
    if not _REQUIRED_COLUMNS <= {field_base_name(fl) for fl in fields}:
        print("Error: CSV must contain 'instruction', 'match_string' and 'imm_type' columns.")
        sys.exit(1)


def _split_rows(rows, fields):
    """Separate the INVALID (default) row from real instructions; skip comments.

    Returns (default_values, valid_rows).
    """
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
        print("Warning: No INVALID row found. Default values will be set to 'x'.")
        default_values = {k: 'x' for k in fields}

    return default_values, valid_rows


def _build_instructions(valid_rows):
    """Clean match strings, compute their specificity and drop blank rows."""
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
    return instructions


def _reject_ambiguous_patterns(instructions):
    """Abort on duplicate or ambiguously overlapping match patterns."""
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


def _parse_control_signals(fields):
    """Parse control-signal columns into (col_name, sv_name, sv_range) tuples.

    Returns (control_signals, external_enums).  A header may carry an optional
    bit-width (e.g. "alu_op[2:0]") and/or an external-enum annotation
    (e.g. "fpu_op{fpnew_pkg::operation_e}").
    """
    control_signals = []
    external_enums = {}  # sig_name -> ExternalEnum
    for field in fields:
        if field in _NON_SIGNAL_COLUMNS:
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
    return control_signals, external_enums


def _detect_enums(control_signals, external_enums, default_values, instructions):
    """Auto-detect enum columns.

    For each control-signal column, collect every non-empty value that appears
    in any instruction row or in the default row.  If *all* such values match
    the UPPER_CASE identifier pattern, the column is an enum.

    Returns a dict mapping col_name -> ordered list of unique member names.
    """
    enums = {}
    for col, name, rng in control_signals:
        if name in external_enums:
            continue  # type is defined elsewhere; never auto-declare it

        seen = []          # preserves first-appearance order
        seen_set = set()
        all_enum = True    # optimistic: assume enum until proven otherwise

        # Check the default (INVALID) row value.
        def_val = default_values.get(col, "").strip()
        if def_val and not is_dont_care(def_val):
            if _ENUM_VALUE_RE.match(def_val):
                if def_val not in seen_set:
                    seen.append(def_val)
                    seen_set.add(def_val)
            else:
                all_enum = False

        # Check every instruction row value.
        for row in instructions:
            val = row.get(col, "").strip() if row.get(col) else ""
            if is_dont_care(val):
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
    return enums


def _warn_on_bad_external_enum_values(control_signals, external_enums, default_values, instructions):
    """Warn if a value used with an external enum is not a bare member name."""
    for col, name, rng in control_signals:
        ext = external_enums.get(name)
        if ext is None:
            continue
        values = [default_values.get(col, "")]
        values += [(row.get(col) or "") for row in instructions]
        for val in values:
            val = val.strip()
            if is_dont_care(val):
                continue
            if not _ENUM_VALUE_RE.match(val):
                print(f"Warning: column '{name}' uses external enum "
                      f"'{ext.type_ref}' but value '{val}' is not a valid enum "
                      f"member name. Consider the '{{type|prefix}}' annotation form.")
