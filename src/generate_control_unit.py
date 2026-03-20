import csv
import sys
import argparse
import re

# Matches a valid snake_case identifier: lowercase letters, digits, underscores only.
_SNAKE_CASE_RE = re.compile(r'^[a-z][a-z0-9_]*$')

def generate_sv(csv_file, sv_file):
    try:
        with open(csv_file, 'r', encoding='utf-8') as f:
            reader = csv.DictReader(f)
            fields = reader.fieldnames
            if not fields:
                print("Error: Empty CSV file.")
                sys.exit(1)
            rows = list(reader)
    except FileNotFoundError:
        print(f"Error: Could not find file {csv_file}")
        sys.exit(1)
        
    if 'instruction' not in fields or 'match_string' not in fields:
        print("Error: CSV must contain 'instruction' and 'match_string' columns.")
        sys.exit(1)

    # Extract the 'INVALID' row for default values, if it exists
    # Get rid of commented out lines (use ' for commenting)
    default_values = {}
    valid_rows = []
    for row in rows:
        if row['instruction'].strip().upper() == 'INVALID':
            default_values = {k: v.strip() for k, v in row.items()}
        elif row['instruction'].strip().startswith("'"):
            continue
        else:
            valid_rows.append(row)
            
    if not default_values:
        print("Error: CSV must contain an 'INVALID' row to define default signal values.")
        sys.exit(1)
        
    valid_rows_clean = []
    for row in valid_rows:
        inst = row['instruction'].strip()
        match_str = row['match_string'].replace(' ', '').replace('_', '').replace('x', '?').replace('X', '?')
        if not inst and not match_str:
            continue
        row['CleanMatchString'] = match_str
        row['SpecificBits'] = sum(1 for b in match_str if b in '01')
        valid_rows_clean.append(row)
        
    for i in range(len(valid_rows_clean)):
        for j in range(i + 1, len(valid_rows_clean)):
            row_a = valid_rows_clean[i]
            row_b = valid_rows_clean[j]
            ma = row_a['CleanMatchString']
            mb = row_b['CleanMatchString']
            
            if len(ma) != len(mb): continue
            
            overlap = True
            for b1, b2 in zip(ma, mb):
                if b1 in '01' and b2 in '01' and b1 != b2:
                    overlap = False
                    break
            
            if overlap:
                a_sub_b = True
                b_sub_a = True
                for b1, b2 in zip(ma, mb):
                    if b2 in '01' and b1 != b2:
                        a_sub_b = False
                    if b1 in '01' and b2 != b1:
                        b_sub_a = False
                
                if a_sub_b and b_sub_a:
                    print(f"Error: Instructions '{row_a['Instruction']}' and '{row_b['Instruction']}' have identical patterns ({ma}).")
                    print("Duplicate patterns are not allowed.")
                    sys.exit(1)
                
                if not (a_sub_b or b_sub_a):
                    print(f"Error: Ambiguous overlap between instruction '{row_a['Instruction']}' ({ma}) and '{row_b['Instruction']}' ({mb}).")
                    print("Neither pattern is a strict subset of the other.")
                    sys.exit(1)
                    
    valid_rows_clean.sort(key=lambda x: x['SpecificBits'], reverse=True)
    rows = valid_rows_clean

    # Parse control signals: handle optional bit widths in the header (e.g., "alu_op[2:0]")
    # Store as tuples: (original_column_name, sv_signal_name, sv_range)
    # The script appends "_o" to each signal name in the emitted SV — do not include it in the CSV.
    control_signals = []
    for f in fields:
        if f in ('instruction', 'match_string'):
            continue
        if f.startswith("'"): # Commented out rows
            continue
        m = re.match(r'^([A-Za-z0-9_]+)\s*(?:\[([^\]]+)\])?$', f)
        if m:
            name = m.group(1)
            rng = m.group(2) if m.group(2) else ""
        else:
            name = f.strip()
            rng = ""
        if not _SNAKE_CASE_RE.match(name):
            print(f"Warning: column '{name}' does not look like snake_case. "
                  f"Consider renaming it in the CSV.")
        control_signals.append((f, name, rng))

    with open(sv_file, 'w', encoding='utf-8') as f:
        f.write("`default_nettype none\n\n")
        f.write("module control_unit (\n")
        f.write("    input  wire  [31:2] instr_i,\n")
        
        # Ports
        for i, (col, sig, rng) in enumerate(control_signals):
            sep = "," if i < len(control_signals)-1 else ""
            range_str = f"[{rng}] " if rng else ""
            f.write(f"    output logic {range_str:>8}{sig}_o{sep}\n")
            
        f.write(");\n\n")
        f.write("    always_comb begin\n")
        
        f.write("\n        case (instr_i) inside\n")
        
        for row in rows:
            inst = row['instruction'].strip()
            match_str = row['CleanMatchString']
            
            if len(match_str) != 30:
                print(f"Warning: Instruction '{inst}' MatchString length is {len(match_str)}, expected 30. Skipping.")
                continue
                
            f.write(f"            30'b{match_str}: begin // {inst}\n")
            for col, sig, rng in control_signals:
                val = row[col].strip() if row[col] else ""
                if val == "":
                    # Leave default
                    pass
                elif val.lower() in ('x', '-', 'd', '?'):
                    f.write(f"                {sig}_o = 'x;\n")
                else:
                    # User provided a specific value (e.g. 1, 0, or 2'b10)
                    # If it's a simple 0 or 1 and there's no width specified, we can prefix 1'b just in case
                    if val in ('0', '1') and not rng:
                        f.write(f"                {sig}_o = 1'b{val};\n")
                    else:
                        f.write(f"                {sig}_o = {val};\n")
            f.write("            end\n")
            
        f.write("            default: begin // INVALID\n")
        for col, sig, rng in control_signals:
            def_val = default_values.get(col, "")
            if def_val:
                # Add 1'b prefix for simple bits if no width is given, otherwise use verbatim
                if def_val in ('0', '1') and not rng:
                    f.write(f"                {sig}_o = 1'b{def_val};\n")
                else:
                    f.write(f"                {sig}_o = {def_val};\n")
            else:
                f.write(f"                {sig}_o = 'x;\n")
        f.write("            end\n")
        f.write("        endcase\n")
        f.write("    end\n")
        f.write("endmodule\n\n")
        f.write("`default_nettype wire\n")

    print(f"Successfully generated {sv_file} from {csv_file}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Generate SystemVerilog control unit from a CSV sheet.')
    parser.add_argument('input_csv', help='Input CSV file containing instructions and control signals')
    parser.add_argument('output_sv', help='Output SystemVerilog file')
    args = parser.parse_args()
    generate_sv(args.input_csv, args.output_sv)
