"""Generate hardcoded golden vectors for tb/tb_fpnew_wrapper.sv.

Adapted from asm-kernels/random_floats.py.  Emits a SystemVerilog include file
with, for every FPU operation, FPU_VEC_N transactions of per-lane operands and the
expected per-lane result.  The expected results are computed with IEEE-754
binary32 semantics (numpy float32, which is correctly rounded), except for the
FMA family which is computed exactly (fused, single rounding) with rational
arithmetic, and FCLASS which uses fpnew's vectorial 8-bit-per-lane class packing.

Usage:  python3 asm-kernels/gen_fpnew_vectors.py > tb/fpnew_vectors.svh
"""

import random
import struct
from decimal import Decimal, getcontext
from fractions import Fraction

import numpy as np

getcontext().prec = 80  # enough digits that float32 rounding is unambiguous

N_THREADS = 8
VEC_N = 6
SEED = 0x5EED
CANON_NAN = 0x7FC00000

# Must match the op table in tb/tb_fpnew_wrapper.sv.
OPS = [
    "FADD", "FSUB", "FMUL", "FDIV", "FSQRT", "FMIN", "FMAX",
    "FSGNJ", "FSGNJN", "FSGNJX", "FLT", "FLE", "FEQ", "FCLASS",
    "FCVT_W_S", "FCVT_WU_S", "FCVT_S_W", "FCVT_S_WU",
    "FMADD", "FMSUB", "FNMSUB", "FNMADD",
]


# ----------------------------------------------------------------------------
# bit <-> float helpers
# ----------------------------------------------------------------------------
def b2f(b):
    return struct.unpack("<f", struct.pack("<I", int(b) & 0xFFFFFFFF))[0]


def f2b(x):
    return struct.unpack("<I", struct.pack("<f", x))[0]


def bits_of(arr):
    """Raw 32-bit patterns of a float32 array, canonicalizing NaNs."""
    arr = np.ascontiguousarray(arr, dtype=np.float32)
    raw = arr.view(np.uint32)
    return np.where(np.isnan(arr), np.uint32(CANON_NAN), raw).astype(np.uint32)


def bits1(x):
    """Raw 32-bit pattern of a single float32 (NaNs canonicalized)."""
    x = float(np.float32(x))
    if np.isnan(x):
        return CANON_NAN
    return f2b(x)


# ----------------------------------------------------------------------------
# exact float32 rounding (used for fused FMA)
# ----------------------------------------------------------------------------
def frac_of_bits(b):
    """Exact value of a finite binary32 as a Fraction, or None if not finite."""
    b = int(b) & 0xFFFFFFFF
    sign = b >> 31
    exp = (b >> 23) & 0xFF
    man = b & 0x7FFFFF
    if exp == 0xFF:
        return None
    if exp == 0:
        val = Fraction(man, 1 << 149)
    else:
        significand = man | (1 << 23)
        if exp - 127 >= 0:
            val = Fraction(significand * (1 << (exp - 127)), 1 << 23)
        else:
            val = Fraction(significand, (1 << 23) * (1 << (127 - exp)))
    return -val if sign else val


def _round_half_even(fr: Fraction) -> int:
    q, r = divmod(fr.numerator, fr.denominator)  # floor division for positive fr
    twice = 2 * r
    if twice > fr.denominator:
        return q + 1
    if twice < fr.denominator:
        return q
    return q + 1 if (q % 2) else q


def round_f32(fr: Fraction):
    """Round a Fraction to nearest binary32 (ties to even); returns 32-bit pattern."""
    if fr == 0:
        return 0
    sign = 1 if fr < 0 else 0
    a = -fr if fr < 0 else fr
    e = a.numerator.bit_length() - a.denominator.bit_length()
    while Fraction(2) ** e > a:
        e -= 1
    while Fraction(2) ** (e + 1) <= a:
        e += 1
    if e > 127:
        return (sign << 31) | (0xFF << 23)  # overflow -> inf
    if e >= -126:
        scaled = a / (Fraction(2) ** (e - 23))
        m = _round_half_even(scaled)
        if m >= (1 << 24):
            e += 1
            m = 1 << 23
        if e > 127:
            return (sign << 31) | (0xFF << 23)
        return (sign << 31) | ((e + 127) << 23) | (m - (1 << 23))
    # subnormal
    m = _round_half_even(a / (Fraction(2) ** -149))
    if m >= (1 << 23):
        return (sign << 31) | (1 << 23)
    return (sign << 31) | m


def fused_bits(a_bits, b_bits, c_bits, neg_p=False, neg_c=False):
    """Exact fused a*b + c (optionally negating product and/or addend), rounded RNE."""
    fa = frac_of_bits(a_bits)
    fb = frac_of_bits(b_bits)
    fc = frac_of_bits(c_bits)
    if fa is None or fb is None or fc is None:
        return None  # caller falls back to numpy for non-finite operands
    p = fa * fb
    if neg_p:
        p = -p
    if neg_c:
        p = p - fc
    else:
        p = p + fc
    return round_f32(p)


# ----------------------------------------------------------------------------
# per-operation results
# ----------------------------------------------------------------------------
def class8(bits):
    """fpnew vectorial fclass encoding (8 bit): 7=sign 6=~sign 5=qNaN 4=sNaN 3=zero 2=sub 1=norm 0=inf."""
    b = int(bits) & 0xFFFFFFFF
    sign = b >> 31
    exp = (b >> 23) & 0xFF
    man = b & 0x7FFFFF
    if exp == 0xFF:
        base = (1 << 0) if man == 0 else ((1 << 5) if ((man >> 22) & 1) else (1 << 4))
    elif exp == 0:
        base = (1 << 3) if man == 0 else (1 << 2)
    else:
        base = 1 << 1
    neg_like = bool(sign) and base in ((1 << 0), (1 << 1), (1 << 2), (1 << 3))
    return base | ((1 << 7) if neg_like else (1 << 6))


def cvt_ws(a_bits):
    x = b2f(a_bits)
    if np.isnan(x):
        return 0x7FFFFFFF
    if np.isinf(x):
        return 0x7FFFFFFF if x > 0 else 0x80000000
    r = float(np.rint(np.float64(x)))
    if r >= 2**31:
        return 0x7FFFFFFF
    if r < -(2**31):
        return 0x80000000
    return int(r) & 0xFFFFFFFF


def cvt_wus(a_bits):
    x = b2f(a_bits)
    if np.isnan(x):
        return 0xFFFFFFFF
    if np.isinf(x):
        return 0xFFFFFFFF if x > 0 else 0
    if x < 0:
        return 0
    r = float(np.rint(np.float64(x)))
    if r >= 2**32:
        return 0xFFFFFFFF
    return int(r) & 0xFFFFFFFF


def cvt_sw(a_bits):
    i = int(a_bits) & 0xFFFFFFFF
    if i >= 2**31:
        i -= 2**32
    return f2b(np.float32(i))


def cvt_swu(a_bits):
    return f2b(np.float32(int(a_bits) & 0xFFFFFFFF))


# ----------------------------------------------------------------------------
# operand pools
# ----------------------------------------------------------------------------
def make_operands(op, rng):
    """Return (a_bits, b_bits, c_bits) lists of length N_THREADS for one transaction."""
    A = [0] * N_THREADS
    B = [0] * N_THREADS
    C = [0] * N_THREADS

    def rf():  # non-zero finite float in [-100, 100)
        while True:
            v = float(np.float32(rng.uniform(-100.0, 100.0)))
            if v != 0.0:
                return f2b(v)

    if op in ("FCLASS",):
        specials = [0x00000000, 0x80000000, 0x3F800000, 0xBF800000,
                    0x7F800000, 0xFF800000, 0x00000001, 0x7FC00000,
                    0x7F800001]
        for l in range(N_THREADS):
            A[l] = specials[(l + rng.randrange(len(specials))) % len(specials)]
    elif op in ("FCVT_S_W", "FCVT_S_WU"):
        for l in range(N_THREADS):
            A[l] = rng.choice([rng.randint(-(2**31), 2**31 - 1), rng.randint(0, 2**32 - 1),
                               rng.choice([-(2**31), 2**31 - 1, 0xFFFFFFFF, 0x80000000, 0])])
    elif op in ("FCVT_W_S", "FCVT_WU_S"):
        for l in range(N_THREADS):
            A[l] = f2b(float(np.float32(rng.choice(
                [rng.uniform(-100, 100), rng.uniform(-3e9, 3e9),
                 rng.choice([-0.5, 0.5, 1.5, -1.5, 2.5, -2.5, 0.0, -0.0,
                             3.0, -3.0, 1e9, -1e9])]))))
    elif op == "FSQRT":
        for l in range(N_THREADS):
            A[l] = f2b(abs(np.float32(rng.uniform(-100.0, 100.0))))
    elif op == "FDIV":
        for l in range(N_THREADS):
            A[l] = rf()
            b = 0.0
            while abs(b) < 0.5:
                b = float(np.float32(rng.uniform(-100.0, 100.0)))
            B[l] = f2b(b)
    elif op in ("FMIN", "FMAX", "FLT", "FLE", "FEQ", "FSGNJ", "FSGNJN", "FSGNJX"):
        for l in range(N_THREADS):
            A[l] = rf()
            B[l] = rf()
    elif op in ("FADD", "FSUB", "FMUL"):
        for l in range(N_THREADS):
            A[l] = rf()
            B[l] = rf()
    else:  # FMA family
        for l in range(N_THREADS):
            A[l] = rf()
            B[l] = rf()
            C[l] = rf()
    return A, B, C


def expected(op, A, B, C):
    """Expected 32-bit pattern for lane l -> list of length N_THREADS."""
    out = [0] * N_THREADS
    if op in ("FADD", "FSUB", "FMUL", "FDIV"):
        for l in range(N_THREADS):
            fa = frac_of_bits(A[l])
            fb = frac_of_bits(B[l])
            if fa is None or fb is None or (op == "FDIV" and fb == 0):
                # non-finite/zero-divisor fallback (not produced by the generator)
                y = b2f(A[l])
                z = b2f(B[l])
                out[l] = bits1(y + z if op == "FADD" else y - z if op == "FSUB" else y * z if op == "FMUL" else y / z)
            else:
                r = (fa + fb) if op == "FADD" else (fa - fb) if op == "FSUB" else (fa * fb) if op == "FMUL" else (fa / fb)
                out[l] = round_f32(r)
    elif op == "FSQRT":
        for l in range(N_THREADS):
            x = b2f(A[l])
            if x < 0.0:
                out[l] = CANON_NAN
            elif x == 0.0:
                out[l] = A[l] & 0x80000000
            else:
                out[l] = round_f32(Fraction(Decimal(x).sqrt()))
    elif op == "FMIN":
        for l in range(N_THREADS):
            out[l] = bits1(np.minimum(b2f(A[l]), b2f(B[l])))
    elif op == "FMAX":
        for l in range(N_THREADS):
            out[l] = bits1(np.maximum(b2f(A[l]), b2f(B[l])))
    elif op == "FSGNJ":
        for l in range(N_THREADS):
            out[l] = (A[l] & 0x7FFFFFFF) | (B[l] & 0x80000000)
    elif op == "FSGNJN":
        for l in range(N_THREADS):
            out[l] = (A[l] & 0x7FFFFFFF) | ((~B[l]) & 0x80000000)
    elif op == "FSGNJX":
        for l in range(N_THREADS):
            out[l] = (A[l] & 0x7FFFFFFF) | ((A[l] ^ B[l]) & 0x80000000)
    elif op == "FLT":
        for l in range(N_THREADS):
            out[l] = 1 if b2f(A[l]) < b2f(B[l]) else 0
    elif op == "FLE":
        for l in range(N_THREADS):
            out[l] = 1 if b2f(A[l]) <= b2f(B[l]) else 0
    elif op == "FEQ":
        for l in range(N_THREADS):
            out[l] = 1 if b2f(A[l]) == b2f(B[l]) else 0
    elif op == "FCLASS":
        # fpnew's vectorial classify packs one 8-bit code per lane into bytes 0..7;
        # the upper bits of the result are zero.
        codes = [class8(A[l]) for l in range(N_THREADS)]
        out = [0] * N_THREADS
        out[0] = codes[0] | (codes[1] << 8) | (codes[2] << 16) | (codes[3] << 24)
        out[1] = codes[4] | (codes[5] << 8) | (codes[6] << 16) | (codes[7] << 24)
    elif op == "FCVT_W_S":
        for l in range(N_THREADS):
            out[l] = cvt_ws(A[l])
    elif op == "FCVT_WU_S":
        for l in range(N_THREADS):
            out[l] = cvt_wus(A[l])
    elif op == "FCVT_S_W":
        for l in range(N_THREADS):
            out[l] = cvt_sw(A[l])
    elif op == "FCVT_S_WU":
        for l in range(N_THREADS):
            out[l] = cvt_swu(A[l])
    else:
        neg_p = op in ("FNMSUB", "FNMADD")
        neg_c = op in ("FMSUB", "FNMADD")
        for l in range(N_THREADS):
            r = fused_bits(A[l], B[l], C[l], neg_p=neg_p, neg_c=neg_c)
            if r is None:
                # non-finite fallback (not used by the generated vectors)
                base = np.float32(b2f(A[l]) * b2f(B[l]))
                if neg_p:
                    base = np.float32(-base)
                if neg_c:
                    base = np.float32(base - np.float32(b2f(C[l])))
                else:
                    base = np.float32(base + np.float32(b2f(C[l])))
                r = bits1(base)
            out[l] = r
    return out


# ----------------------------------------------------------------------------
# emit
# ----------------------------------------------------------------------------
def pack(words):
    """8 lanes -> a 256-bit literal (lane 0 in the low 32 bits)."""
    return "256'h" + "".join(f"{w & 0xFFFFFFFF:08X}" for w in reversed(words))


def main():
    rng = random.Random(SEED)
    A_all, B_all, C_all, R_all = [], [], [], []
    for op in OPS:
        A, B, C, R = [], [], [], []
        for _ in range(VEC_N):
            a, b, c = make_operands(op, rng)
            A.append(a)
            B.append(b)
            C.append(c)
            R.append(expected(op, a, b, c))
        A_all.append(A)
        B_all.append(B)
        C_all.append(C)
        R_all.append(R)

    print("// AUTO-GENERATED by asm-kernels/gen_fpnew_vectors.py -- do not edit.")
    print("// Golden operands and expected results for tb/tb_fpnew_wrapper.sv.")
    print("// Op index order must match the op table in the testbench.")
    print(f"localparam int unsigned FPU_VEC_N   = {VEC_N};")
    print(f"localparam int unsigned FPU_NUM_OPS = {len(OPS)};")

    def emit(name, data):
        print(f"\nlocalparam logic [0:FPU_NUM_OPS-1][0:FPU_VEC_N-1][N_THREADS*RLEN-1:0] {name} = '{{")
        for o, op in enumerate(OPS):
            txs = ", ".join(pack(tx) for tx in data[o])
            tail = "," if o != len(OPS) - 1 else ""
            print(f"  '{{ {txs} }}{tail} // {o:2d} {op}")
        print("};")

    emit("FPU_VEC_A", A_all)  # rs1
    emit("FPU_VEC_B", B_all)  # rs2
    emit("FPU_VEC_C", C_all)  # rs3
    emit("FPU_VEC_R", R_all)  # expected result


if __name__ == "__main__":
    main()
