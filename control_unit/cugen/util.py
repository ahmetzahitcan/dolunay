"""Small naming helpers for the control-unit generator."""

import os


def extract_base_name(filename, remove_path=True):
    """Extracts the base name of a file, removing the extension and optionally the path (default: True)."""
    name = os.path.splitext(filename)[0]
    if remove_path:
        name = os.path.basename(name)
    return name
