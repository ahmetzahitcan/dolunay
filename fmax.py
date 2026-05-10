#!/usr/bin/env python3
import sys

wns = float(sys.argv[1])
treq = 20
fmax = 1000/(treq - wns)
print(f"Fmax: {fmax} MHz")
