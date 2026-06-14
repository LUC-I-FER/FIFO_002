# Synchronous FIFO Buffer in Verilog

## Overview

This project implements a **parameterizable synchronous First-In-First-Out (FIFO) buffer** in SystemVerilog/Verilog for FPGA and ASIC-oriented digital design. The FIFO supports configurable data width and storage depth while providing reliable data buffering between producer and consumer logic operating on the same clock domain.

The design is intended for implementation and simulation using **Xilinx Vivado** and targets the **Spartan-7 XC7S50CSGA324-2 FPGA**, although it can be adapted for other devices.

---

## Features

* Parameterizable data width (`DATA_WIDTH`)
* Parameterizable FIFO depth (`DEPTH`)
* Automatic address width calculation using `$clog2`
* Single-clock synchronous operation
* Circular buffer implementation using read and write pointers
* Full and empty status flag generation
* Overflow protection (blocks writes when full)
* Underflow protection (blocks reads when empty)
* Pointer wrap-around behavior
* Support for simultaneous read/write operations (planned/improved implementation)
* Self-checking simulation environment with randomized stimulus (planned)

---

## Module Interface

| Signal  | Direction | Description                   |
| ------- | --------- | ----------------------------- |
| `clk`   | Input     | System clock                  |
| `rst`   | Input     | Active-high synchronous reset |
| `wr_en` | Input     | Write enable                  |
| `rd_en` | Input     | Read enable                   |
| `din`   | Input     | Input data bus                |
| `dout`  | Output    | Output data bus               |
| `full`  | Output    | FIFO full indicator           |
| `empty` | Output    | FIFO empty indicator          |

---

## Parameters

| Parameter    | Description                     | Default                |
| ------------ | ------------------------------- | ---------------------- |
| `DATA_WIDTH` | Width of each FIFO word         | 32                     |
| `DEPTH`      | Number of entries in FIFO       | 64                     |
| `ADDR_WIDTH` | Address width (`$clog2(DEPTH)`) | Computed automatically |

---

## Internal Architecture

The FIFO consists of:

* Memory array for data storage
* Write pointer (`wr_ptr`)
* Read pointer (`rd_ptr`)
* Occupancy counter (`count`)
* Full and empty flag generation logic

The occupancy counter is used to distinguish between full and empty conditions while supporting pointer wrap-around.

---

## Current Functionality

* Synchronous write operation
* Synchronous read operation
* Reset initialization
* Pointer management
* Occupancy tracking
* Full and empty detection

---

## Verification

The project includes a simulation testbench that verifies:

* FIFO reset behavior
* Sequential write operations
* Sequential read operations
* FIFO ordering (First-In-First-Out)

Future verification enhancements include:

* Randomized read/write stimulus
* Golden software reference queue
* Automatic scoreboard comparison
* Overflow and underflow testing
* Simultaneous read/write edge-case validation
* Long-duration stress testing

---

## Simulation Flow

1. Instantiate the FIFO in a testbench.
2. Generate a clock and reset sequence.
3. Write multiple data values into the FIFO.
4. Read the values back.
5. Verify that the output order matches the input order.

---

## Project Structure

```
sync_fifo_project/
│
├── rtl/
│   └── sync_fifo.sv
│
├── tb/
│   └── tb_sync_fifo.sv
│
├── constraints/
│   └── top.xdc
│
└── README.md
```

---

## Tools Used

* Xilinx Vivado 2025.1
* SystemVerilog
* Spartan-7 FPGA (XC7S50CSGA324-2)

---

## Future Improvements

* Robust simultaneous read/write handling
* Self-checking testbench with scoreboard
* Randomized verification
* Functional coverage collection
* Assertion-based verification
* BRAM inference optimization for larger FIFO depths

---

## Learning Objectives

This project demonstrates:

* RTL design using SystemVerilog
* Parameterized hardware modules
* FIFO architecture and circular buffer management
* Sequential logic design
* FPGA-oriented design practices
* Digital verification using simulation and testbenches

---

## License

This project is provided for educational and research purposes and may be modified or extended for personal or academic use.
