"""Generate the input and expected-output lists used by asm-kernels/fpu_test.s.

The test runs one element per hart (indexed by mhartid) and checks the single-precision
operations listed below.  Every expected list is computed with numpy float32 arithmetic,
which matches IEEE-754 binary32 (what the RISC-V Zfinx FPU must produce).

Error-mask bit assignment (bit index => instruction under test):

    0  fadd.s     1  fsub.s     2  fmul.s     3  fdiv.s
    4  fsqrt.s    5  fmin.s     6  fmax.s     7  fsgnj.s
    8  fsgnjn.s   9  fsgnjx.s  10  flt.s     11  fle.s
   12  feq.s     13  fclass.s  14  fcvt.w.s  15  fcvt.wu.s
   16  fcvt.s.w  17  fcvt.s.wu

The values are deterministic (fixed seed), so re-running this script reproduces exactly
the lists embedded in fpu_test.s.
"""

import random

import numpy as np

COUNT = 64
SEED = 0x5EED
# RISC-V canonical quiet NaN for binary32.
CANON_NAN = 0x7FC00000


def bits_of(arr: np.ndarray) -> np.ndarray:
    """Return the raw 32-bit patterns of a float32 array, canonicalizing NaNs."""
    arr = np.ascontiguousarray(arr, dtype=np.float32)
    raw = arr.view(np.uint32)
    return np.where(np.isnan(arr), np.uint32(CANON_NAN), raw).astype(np.uint32)


def classify(word: int) -> int:
    """RISC-V fclass.s result: one-hot mask describing the operand."""
    word &= 0xFFFFFFFF
    sign = word >> 31
    exp = (word >> 23) & 0xFF
    man = word & 0x7FFFFF
    if exp == 0xFF:
        if man == 0:
            return 1 << (0 if sign else 7)          # -inf / +inf
        return 1 << (9 if (man >> 22) & 1 else 8)   # quiet / signaling NaN
    if exp == 0:
        if man == 0:
            return 1 << (3 if sign else 4)          # -zero / +zero
        return 1 << (2 if sign else 5)              # -subnormal / +subnormal
    return 1 << (1 if sign else 6)                  # -normal / +normal


def main() -> None:
    rng = random.Random(SEED)

    # Float operands in [-100, 100), stored as binary32.
    list_a = [np.float32(rng.uniform(-100.0, 100.0)) for _ in range(COUNT)]
    list_b = [np.float32(rng.uniform(-100.0, 100.0)) for _ in range(COUNT)]
    list_c = [np.float32(rng.uniform(-100.0, 100.0)) for _ in range(COUNT)]
    # Integer operands for the fcvt.s.w / fcvt.s.wu tests.
    list_ia = [rng.randint(-(2**31), 2**31 - 1) for _ in range(COUNT)]
    list_iu = [rng.randint(0, 2**32 - 1) for _ in range(COUNT)]

    fa = np.array(list_a, dtype=np.float32)
    fb = np.array(list_b, dtype=np.float32)
    fc = np.array(list_c, dtype=np.float32)
    ia = np.array(list_ia, dtype=np.int32)
    iu = np.array(list_iu, dtype=np.uint32)

    ba = bits_of(fa)
    bb = bits_of(fb)

    # Arithmetic (bit-exact comparison against the raw result pattern).
    list_add = bits_of(fa + fb)
    list_sub = bits_of(fa - fb)
    list_mul = bits_of(fa * fb)
    list_div = bits_of(fa / fb)
    list_sqrt = bits_of(np.sqrt(fa))
    list_min = bits_of(np.minimum(fa, fb))
    list_max = bits_of(np.maximum(fa, fb))

    # Sign-injection: magnitude of a, sign taken from b.
    list_sgnj = (ba & 0x7FFFFFFF) | (bb & 0x80000000)
    list_sgnjn = (ba & 0x7FFFFFFF) | ((~bb) & 0x80000000)
    list_sgnjx = (ba & 0x7FFFFFFF) | ((ba ^ bb) & 0x80000000)

    # Comparisons produce integer 0/1 results.
    list_lt = (fa < fb).astype(np.uint32)
    list_le = (fa <= fb).astype(np.uint32)
    list_eq = (fa == fb).astype(np.uint32)

    list_fclass = np.array([classify(int(w)) for w in ba], dtype=np.uint32)

    # Float -> integer conversions (round to nearest even, saturating).
    rounded_a = np.rint(fa).astype(np.float64)
    cvt_ws = np.clip(rounded_a, -(2**31), 2**31 - 1).astype(np.int64) & 0xFFFFFFFF
    cvt_wus = np.clip(rounded_a, 0, 2**32 - 1).astype(np.uint64) & 0xFFFFFFFF

    # Integer -> float conversions.
    list_cvt_sw = bits_of(ia.astype(np.float32))
    list_cvt_swu = bits_of(iu.astype(np.float32))

    # Float FMA operations.
    list_fmadd = bits_of((fa * fb) + fc)
    list_fmsub = bits_of((fa * fb) - fc)
    list_fnmsub = bits_of(-(fa * fb) + fc)
    list_fnmadd = bits_of(-(fa + fb) - fc)

    lists = [
        ("list_a", "List A (float operand a)", list_a, "f"),
        ("list_b", "List B (float operand b)", list_b, "f"),
        ("list_c", "List C (float operand c)", list_c, "f"),
        ("list_ia", "List IA (int32 operand for fcvt.s.w)", list_ia, "i"),
        ("list_iu", "List IU (uint32 operand for fcvt.s.wu)", list_iu, "u"),
        ("list_add", "List ADD (a + b)", list_add, "u"),
        ("list_sub", "List SUB (a - b)", list_sub, "u"),
        ("list_mul", "List MUL (a * b)", list_mul, "u"),
        ("list_div", "List DIV (a / b)", list_div, "u"),
        ("list_sqrt", "List SQRT (sqrt(a))", list_sqrt, "u"),
        ("list_min", "List MIN (min(a, b))", list_min, "u"),
        ("list_max", "List MAX (max(a, b))", list_max, "u"),
        ("list_sgnj", "List SGNJ (fsgnj.s)", list_sgnj, "u"),
        ("list_sgnjn", "List SGNJN (fsgnjn.s)", list_sgnjn, "u"),
        ("list_sgnjx", "List SGNJX (fsgnjx.s)", list_sgnjx, "u"),
        ("list_lt", "List LT (a < b)", list_lt, "u"),
        ("list_le", "List LE (a <= b)", list_le, "u"),
        ("list_eq", "List EQ (a == b)", list_eq, "u"),
        ("list_fclass", "List FCLASS (fclass.s a)", list_fclass, "u"),
        ("list_cvt_ws", "List CVT_WS (fcvt.w.s a)", cvt_ws, "i"),
        ("list_cvt_wus", "List CVT_WUS (fcvt.wu.s a)", cvt_wus, "u"),
        ("list_cvt_sw", "List CVT_SW (fcvt.s.w ia)", list_cvt_sw, "u"),
        ("list_cvt_swu", "List CVT_SWU (fcvt.s.wu iu)", list_cvt_swu, "u"),
        ("list_fmadd", "List FMADD (fa * fb + fc)", list_fmadd, "u"),
        ("list_fmsub", "List FMSUB (fa * fb - fc)", list_fmsub, "u"),
        ("list_fnmsub", "List FNMSUB (-fa * fb + fc)", list_fnmsub, "u"),
        ("list_fnmadd", "List FNMADD (-fa * fb - fc)", list_fnmadd, "u"),
    ]

    for name, comment, values, kind in lists:
        print(f"\n{name}: # {comment}")
        for v in values:
            if kind == "f":
                print(f".word 0x{int(np.float32(v).view(np.uint32)):08X}")
            else:
                print(f".word 0x{int(v) & 0xFFFFFFFF:08X}")


if __name__ == "__main__":
    main()
