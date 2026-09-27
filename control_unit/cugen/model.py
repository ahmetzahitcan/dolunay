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
        sig{fpnew_pkg::operation_e|OP_|NONE}              default -> fpnew_pkg::OP_NONE

    The type is emitted verbatim, so it should be fully qualified.  The optional
    second field is a prefix prepended to every member name, and the optional
    third field names the member used for don't-care/default values; it is
    qualified by the same scope and prefix as the other members, so it should be
    given as a bare suffix (e.g. ``NONE``, not ``fpnew_pkg::NONE``).  When no
    default member is given, don't-care values are rendered as a cast to the type
    (``fpnew_pkg::operation_e'('x)``)
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
class Signal:
    """A single control-signal column.

    A scalar signal has ``index is None``.  An element of a packed array has
    ``index`` set to the text between the parentheses (e.g. ``"0"`` or
    ``"FOO"``); its ``name`` is the array's base name.
    """

    col: str
    name: str
    rng: str = ""
    index: str | None = None


@dataclass
class ArrayInfo:
    """A packed array built from a run of adjacent element columns.

    Attributes:
        name:             the array's base name (e.g. "array" for "array(0)").
        signals:          the element :class:`Signal` objects, in column order.
        integer_indexed:  True when indices are 0,1,2,...; False when they are
                          UPPER_CASE identifiers.
        external_enum:    the ExternalEnum shared by every element, or None when
                          the element type is not an explicit external type.
    """

    name: str
    signals: list
    integer_indexed: bool
    external_enum: 'ExternalEnum | None'


@dataclass
class ControlUnitData:
    """Validated control-unit description produced by :func:`parse_csv`.

    Attributes:
        control_signals: list of (col_name, sv_name, sv_range) tuples.
        default_values:  dict mapping col_name -> raw string value (INVALID row).
        instructions:    list of dicts, each with at minimum
                         'instruction', 'CleanMatchString' and 'SpecificBits',
                         plus one key per control-signal column.
        enums:           dict mapping a signal name -> list[str] of ordered
                         unique enum member names, for every column (or array)
                         whose values are all bare UPPER_CASE identifiers (e.g.
                         ALU_ADD, ALU_BEQ).  Names not detected as enums are
                         absent.
        external_enums:  dict mapping a signal name -> ExternalEnum for columns
                         (or arrays) whose enum type is defined outside this
                         package.
        arrays:          dict mapping an array base name -> :class:`ArrayInfo`
                         for every packed array in the sheet.
    """

    control_signals: list
    default_values: dict
    instructions: list
    enums: dict
    external_enums: dict
    arrays: dict
