"""Control-unit generator: CSV parsing, validation and SystemVerilog emission.

``generate.py`` (the entry point next to this package) ties the pieces together:

    csv_parser  -> parse a CSV sheet into a :class:`~cugen.model.ControlUnitData`
    sv_emitter  -> render that data object as a SystemVerilog module + package
    model       -> the shared data model and don't-care helpers
    util        -> small naming helpers
"""

from .csv_parser import parse_csv
from .model import ControlUnitData, ExternalEnum, is_dont_care
from .sv_emitter import emit_sv_module, emit_sv_package

__all__ = [
    'ControlUnitData',
    'ExternalEnum',
    'emit_sv_module',
    'emit_sv_package',
    'is_dont_care',
    'parse_csv',
]
