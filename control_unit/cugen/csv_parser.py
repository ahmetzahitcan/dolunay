"""Parse and validate a control-unit CSV sheet into a :class:`ControlUnitData`."""

import csv
import re
import sys

from .model import ArrayInfo, ControlUnitData, ExternalEnum, Signal, is_dont_care

# Matches a valid snake_case identifier: lowercase letters, digits, underscores only.
_SNAKE_CASE_RE = re.compile(r'^[a-z][a-z0-9_]*$')

# Matches a bare UPPER_CASE identifier (letters, digits, underscores; must start with a letter).
_ENUM_VALUE_RE = re.compile(r'^[A-Z][A-Z0-9_]*$')

# Matches a control-signal column header: name (index) [range] {annotation}, with
# the index, range and annotation all optional and in that order.
_COLUMN_RE = re.compile(
    r'^([A-Za-z0-9_]+)\s*(?:\(([^)]*)\))?\s*(?:\[([^\]]+)\])?\s*(?:\{([^}]*)\})?$'
)

# Matches an all-digit (non-negative integer) array index.
_INT_INDEX_RE = re.compile(r'^\d+$')

# Columns that hold metadata rather than a control signal.
_NON_SIGNAL_COLUMNS = {'instruction', 'match_string', 'sim__disasm_format'}
_REQUIRED_COLUMNS = {'instruction', 'match_string', 'imm_type'}


def _error(message):
    print(f"Error: {message}")
    sys.exit(1)


def field_base_name(field):
    """Return the bare signal name of a CSV header field.

    Strips an optional array index ("sig(0)"), bit range ("sig[2:0]") and/or
    external-enum annotation ("sig{pkg::type}") suffix.
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
    control_signals, external_enums, arrays = _parse_control_signals(fields)
    enums = _detect_enums(control_signals, external_enums, arrays, default_values, instructions)
    _warn_on_bad_external_enum_values(
        control_signals, external_enums, default_values, instructions)

    return ControlUnitData(
        control_signals=control_signals,
        default_values=default_values,
        instructions=instructions,
        enums=enums,
        external_enums=external_enums,
        arrays=arrays,
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
    """Parse control-signal columns into Signal objects and packed arrays.

    Returns (control_signals, external_enums, arrays).  A header may carry an
    optional array index ("sig(0)"), bit range ("sig[2:0]") and/or external-enum
    annotation ("sig{fpnew_pkg::operation_e}").
    """
    columns = []
    for field in fields:
        if field in _NON_SIGNAL_COLUMNS:
            continue
        if field.startswith("'"):  # commented-out column
            continue
        m = _COLUMN_RE.match(field)
        if m:
            name = m.group(1)
            index = m.group(2)
            rng = m.group(3) if m.group(3) else ""
            ext_spec = m.group(4)
        else:
            if '{' in field or '}' in field:
                _error(f"malformed external enum annotation in column '{field}' "
                       f"(expected 'signal{{package::type}}').")
            if '(' in field or ')' in field:
                _error(f"malformed array index in column '{field}' "
                       f"(expected 'signal(index)').")
            name = field.strip()
            index = None
            rng = ""
            ext_spec = None
        if not _SNAKE_CASE_RE.match(name):
            print(f"Warning: column '{name}' does not look like snake_case. "
                  f"Consider renaming it in the CSV.")
        if index is None and ext_spec is not None and rng:
            print(f"Warning: column '{field}' declares both a bit range and an "
                  f"external enum; the bit range is ignored.")
        columns.append({'field': field, 'name': name, 'index': index,
                        'rng': rng, 'ext_spec': ext_spec})

    control_signals = [Signal(c['field'], c['name'], c['rng'], c['index'])
                       for c in columns]
    arrays = _build_arrays(columns, control_signals)

    external_enums = {}  # sig_name -> ExternalEnum
    for c in columns:
        if c['index'] is not None or c['ext_spec'] is None:
            continue  # array element types are resolved by _build_arrays
        external_enums[c['name']] = parse_external_enum(c['field'], c['ext_spec'])
    for name, info in arrays.items():
        if info.external_enum is not None:
            external_enums[name] = info.external_enum

    return control_signals, external_enums, arrays


def _build_arrays(columns, control_signals):
    """Group indexed columns into packed arrays, validating their layout."""
    positions = {}  # array name -> column positions
    for i, c in enumerate(columns):
        if c['index'] is not None:
            positions.setdefault(c['name'], []).append(i)

    arrays = {}
    for name, idxs in positions.items():
        if idxs[-1] - idxs[0] + 1 != len(idxs):
            _error(f"the elements of array '{name}' must occupy adjacent columns.")
        if any(c['index'] is None and c['name'] == name for c in columns):
            _error(f"'{name}' is used both as a scalar signal and as an array.")
        if name == 'imm_type':
            _error("'imm_type' cannot be an array.")
        arrays[name] = _make_array(
            name, [columns[i] for i in idxs], [control_signals[i] for i in idxs])
    return arrays


def _make_array(name, elements, signals):
    """Validate one array and return its :class:`ArrayInfo`."""
    indices = [e['index'] for e in elements]
    int_index = [_INT_INDEX_RE.match(ix) is not None for ix in indices]

    if all(int_index):
        integer_indexed = True
        for pos, ix in enumerate(indices):
            if int(ix) != pos:
                _error(f"integer indices of array '{name}' must start at 0 and "
                       f"increase by 1 (got '{ix}' where '{pos}' was expected).")
    else:
        if any(int_index):
            _error(f"array '{name}' mixes integer and identifier indices.")
        integer_indexed = False
        seen = set()
        for ix in indices:
            if not _ENUM_VALUE_RE.match(ix):
                _error(f"index '{ix}' of array '{name}' must be UPPER_CASE.")
            if ix in seen:
                _error(f"array '{name}' has a duplicate index '{ix}'.")
            seen.add(ix)

    # All elements share the first element's type.
    first = elements[0]
    for e in elements[1:]:
        if e['ext_spec'] is not None and e['ext_spec'] != first['ext_spec']:
            _error(f"array '{name}' has conflicting external enum annotations "
                   f"('{first['ext_spec']}' vs '{e['ext_spec']}').")
        if e['rng'] and e['rng'] != first['rng']:
            _error(f"array '{name}' has conflicting bit ranges "
                   f"('{first['rng']}' vs '{e['rng']}').")

    external_enum = None
    if first['ext_spec'] is not None:
        if first['rng']:
            print(f"Warning: column '{first['field']}' declares both a bit range "
                  f"and an external enum; the bit range is ignored.")
        external_enum = parse_external_enum(first['field'], first['ext_spec'])

    # Every element is the same type, so give them all the first element's range
    # to keep value formatting uniform.
    for s in signals:
        s.rng = first['rng']

    return ArrayInfo(name, signals, integer_indexed, external_enum)


def _detect_enums(control_signals, external_enums, arrays, default_values, instructions):
    """Auto-detect enum columns and arrays, keyed by signal name.

    A scalar column is an enum when all of its values are bare UPPER_CASE
    identifiers.  An array is an enum when the values of *all* its element
    columns are, and the values are combined into one member list.

    Returns a dict mapping signal name -> ordered list of unique member names.
    """
    enums = {}
    emitted_arrays = set()
    for s in control_signals:
        if s.index is None:
            if s.name in external_enums:
                continue  # type is defined elsewhere; never auto-declare it
            values = _detect_enum_values([s.col], default_values, instructions)
        else:
            if s.name in emitted_arrays:
                continue
            emitted_arrays.add(s.name)
            if s.name in external_enums:
                continue
            values = _detect_enum_values(
                [e.col for e in arrays[s.name].signals], default_values, instructions)
        if values:
            enums[s.name] = values
    return enums


def _detect_enum_values(columns, default_values, instructions):
    """Return the combined member list for `columns`, or None if not all enum.

    The INVALID (default) row is considered before the instruction rows, matching
    the order used for a single column.
    """
    seen = []
    seen_set = set()

    def consider(value):
        if is_dont_care(value):
            return True
        if not _ENUM_VALUE_RE.match(value):
            return False
        if value not in seen_set:
            seen.append(value)
            seen_set.add(value)
        return True

    for col in columns:
        if not consider(default_values.get(col, "").strip()):
            return None
    for row in instructions:
        for col in columns:
            value = row.get(col, "").strip() if row.get(col) else ""
            if not consider(value):
                return None
    return seen if seen else None


def _warn_on_bad_external_enum_values(control_signals, external_enums, default_values, instructions):
    """Warn if a value used with an external enum is not a bare member name."""
    columns_by_name = {}
    for s in control_signals:
        columns_by_name.setdefault(s.name, []).append(s.col)

    for name, columns in columns_by_name.items():
        ext = external_enums.get(name)
        if ext is None:
            continue
        for col in columns:
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
