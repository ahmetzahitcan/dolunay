"""Data model shared by the control-unit parser and SystemVerilog emitter."""

from dataclasses import dataclass

# Values that mean "don't-care" rather than a real signal value.
_DONT_CARE = {'x', '-', 'd', '?'}


def is_dont_care(value):
    """Return True for empty values and the recognised don't-care markers."""
    return value == "" or value.lower() in _DONT_CARE


class ExternalEnum:
    """An enum type whose definition lives in another (third-party) package.

    Such a column is declared in the CSV header by appending a brace-delimited
    annotation to the column name (the name itself must stay snake_case):

        sig{fpnew_pkg::operation_e}                       member -> fpnew_pkg::<VALUE>
        sig{fpnew_pkg::operation_e|OP_}                   member -> fpnew_pkg::OP_<VALUE>
        sig{fpnew_pkg::operation_e|OP_|fpnew_pkg::NONE}   explicit default member

    The type is emitted verbatim, so it should be fully qualified.  When no
    default/undefined member is given, don't-care values are rendered as a cast
    to the type (``fpnew_pkg::operation_e'('x)``)
    """

    def __init__(self, col, type_ref, prefix="", def_member=None):
        self.col = col
        self.type_ref = type_ref
        self.prefix = prefix
        # Package scope (e.g. "fpnew_pkg::") used to qualify enum members.
        self.scope = type_ref[:type_ref.rfind('::') + 2] if '::' in type_ref else ''
        self.def_member = f"{self.scope}{self.prefix}{def_member}" if def_member else None

    def member(self, value):
        """Return the (optionally qualified) enum member for a CSV value."""
        return f"{self.scope}{self.prefix}{value}"

    def undefined(self):
        """Return the expression used for don't-care / default values."""
        if self.def_member is not None:
            return self.def_member
        return f"{self.type_ref}'('x)"


@dataclass
class ControlUnitData:
    """Validated control-unit description produced by :func:`parse_csv`.

    Attributes:
        control_signals: list of (col_name, sv_name, sv_range) tuples.
        default_values:  dict mapping col_name -> raw string value (INVALID row).
        instructions:    list of dicts, each with at minimum
                         'instruction', 'CleanMatchString' and 'SpecificBits',
                         plus one key per control-signal column.
        enums:           dict mapping col_name -> list[str] of ordered unique
                         enum member names, for every column whose values are
                         all bare UPPER_CASE identifiers (e.g. ALU_ADD, ALU_BEQ).
                         Columns not detected as enums are absent.
        external_enums:  dict mapping sig_name -> ExternalEnum for columns whose
                         enum type is defined outside this package.
    """

    control_signals: list
    default_values: dict
    instructions: list
    enums: dict
    external_enums: dict
