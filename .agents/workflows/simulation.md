---
description: How to simulate SystemVerilog using Vivado simulation tools (xvlog, xelab, xsim)
---

When instructed to run or create a simulation for SystemVerilog files, follow these steps to use Vivado's simulation tools in TCL mode:

1. **Launch the TCL shell** using the `run_command` tool in the background:
   ```bash
C:\AMDDesignTools\2025.2\Vivado\bin\vivado.bat -mode tcl
   ```

2. **Wait** a moment for the `Vivado%` prompt to initialize.

3. **Compile** the SystemVerilog files (`.sv`) by sending input to the TCL shell with `send_command_input`. Use `exec xvlog` from within the Vivado TCL prompt:
   ```tcl
   exec xvlog -sv src/my_design.sv tb/tb_my_design.sv
   ```

4. **Elaborate** the design using `exec xelab`:
   ```tcl
   exec xelab -debug typical -top tb_my_design -snapshot sim_snapshot
   ```

5. **Simulate** the snapshot using `exec xsim`:
   ```tcl
   exec xsim sim_snapshot -R
   ```

// turbo-all
Note: Ensure you send all simulation commands using `send_command_input` to the background command ID of the TCL shell.