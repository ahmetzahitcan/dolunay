import random
import struct

def float_to_hex32(val: float) -> str:
    """Packs a float as IEEE 754 single-precision (32-bit) and formats as hex."""
    (packed_int,) = struct.unpack('>I', struct.pack('>f', val))
    return f"0x{packed_int:08X}"

def main():
    count = 64

    # Generate 64 random single-precision floats for list A and list B
    list_a = [
        struct.unpack('>f', struct.pack('>f', random.uniform(-100.0, 100.0)))[0]
        for _ in range(count)
    ]
    list_b = [
        struct.unpack('>f', struct.pack('>f', random.uniform(-100.0, 100.0)))[0]
        for _ in range(count)
    ]

    # Add and truncate to IEEE 754 single-precision
    list_c = [
        struct.unpack('>f', struct.pack('>f', a + b))[0]
        for a, b in zip(list_a, list_b)
    ]

    # Multiply and truncate to IEEE 754 single-precision
    list_d = [
        struct.unpack('>f', struct.pack('>f', a * b))[0]
        for a, b in zip(list_a, list_b)
    ]


    print("list_a: # List A")
    for val in list_a:
        print(f".word {float_to_hex32(val)}")

    print("\nlist_b: # List B")
    for val in list_b:
        print(f".word {float_to_hex32(val)}")

    print("\nlist_c: # List C (A + B)")
    for val in list_c:
        print(f".word {float_to_hex32(val)}")

    print("\nlist_d: # List D (A * B)")
    for val in list_d:
        print(f".word {float_to_hex32(val)}")


if __name__ == '__main__':
    main()
