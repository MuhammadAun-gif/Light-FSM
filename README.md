# 1965 Ford Thunderbird Tail Light Control System

This project implements a tail light control system for the 1965 Ford Thunderbird using a Moore Finite State Machine (FSM) in SystemVerilog. The design sequentially activates tail lights for left and right turn signals based on the input controls.

## Project Overview

The tail light system consists of:
- **Left turn signal lights (`la`, `lb`, `lc`)**: Illuminate sequentially for a left turn.
- **Right turn signal lights (`ra`, `rb`, `rc`)**: Illuminate sequentially for a right turn.
- **Reset functionality**: Resets the system to an idle state where no lights are illuminated.

The system is modeled as a Moore FSM with the following states:
- `S0`: Idle state (no lights on)
- `S1`, `S2`, `S3`: Left turn signal sequence
- `S4`, `S5`, `S6`: Right turn signal sequence

## Features

- Sequential light activation for both left and right turn signals.
- Reset functionality to return to the idle state.
- Modular and reusable FSM design.
- Outputs are fully determined by the current state.

## Diagrams

### RTL Diagram

Below is the RTL (Register Transfer Level) diagram representing the design structure.

![image](https://github.com/user-attachments/assets/c6612b4b-9ebb-4c34-b2ce-7430c3a84a08)

### FSM State Diagram

The FSM uses the following states to track the pattern sequence:

![image](https://github.com/user-attachments/assets/8850690e-1c12-44dc-9187-7ddc8f111e0c)

## Design Details

### State Diagram

The FSM includes the following transitions:
- **Idle State (`S0`)**:
  - Transition to `S1` if the left turn signal (`left`) is active.
  - Transition to `S4` if the right turn signal (`right`) is active.
- **Left Turn States (`S1` → `S2` → `S3`)**:
  - Each state corresponds to turning on an additional left tail light.
  - Loops back to `S0` after `S3`.
- **Right Turn States (`S4` → `S5` → `S6`)**:
  - Each state corresponds to turning on an additional right tail light.
  - Loops back to `S0` after `S6`.

### State Register

The state register is implemented using an `always_ff` block to update the current state based on the clock signal and reset.

### Output Logic

The lights (`la`, `lb`, `lc`, `ra`, `rb`, `rc`) are controlled based on the current state:
- Left sequence:
  - `S1`: `la` on
  - `S2`: `la` and `lb` on
  - `S3`: `la`, `lb`, and `lc` on
- Right sequence:
  - `S4`: `ra` on
  - `S5`: `ra` and `rb` on
  - `S6`: `ra`, `rb`, and `rc` on

## Files

- `lightfsm.sv`: Contains the SystemVerilog implementation of the FSM.
- `tb_lightfsm.sv`: Testbench for simulating and verifying the FSM behavior.
- `README.md`: Project documentation.
- `lightfsm.tv`: Contains test vectors to be used in the Testbench.

## Tools Used

- **Quartus Prime Lite**: For design and simulation.
- **ModelSim/Questa**: For testbench simulation and verification.
- **SystemVerilog**: Hardware description language for FSM implementation.

## Getting Started

### Prerequisites

You need a Verilog simulator (such as ModelSim, Xilinx Vivado, or Synopsys VCS) to compile and simulate this project.

### Clone the repository:
   ```bash
   git clone "https://github.com/MuhammadAun-gif/Light-FSM"

