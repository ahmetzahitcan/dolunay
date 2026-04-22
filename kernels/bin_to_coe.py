import sys

def bin_to_coe(bin_file, coe_file):
    with open(bin_file, 'rb') as f:
        data = f.read()
    
    with open(coe_file, 'w') as f:
        f.write("memory_initialization_radix=16;\n")
        f.write("memory_initialization_vector=")
        
        words = [data[i:i+4] for i in range(0, len(data), 4)]
        
        for i, word in enumerate(words):
            word_swab = word[::-1]
            hex_val = word_swab.hex()
            suffix = ";" if i == len(words) - 1 else ","
            f.write(f"{hex_val}{suffix}")

if __name__ == "__main__":
    bin_to_coe(sys.argv[1], sys.argv[2])