# Lua Performance Benchmarks

This is a fork of the [Lua-Benchmarks](https://github.com/gligneul/Lua-Benchmarks) suite.

While the original suite specifically targets mathematical algorithms and strict CPU throughput (Ackermann, Sieve, etc.), this fork aims to measure performance patterns common in **Game Development**, **Embedded Scripting**, and **Web Services**.

It emphasizes Memory Access patterns, Garbage Collection (short-lived objects), Coroutine context switching, and C-API overhead.

## 📊 Sample Results

```
Distro: Void Linux (GLIBC)
Kernel: 6.12.62
CPU:    Intel(R) N100 (4) @ 3.40 GHz
```
![](https://raw.githubusercontent.com/Jipok/Lua-Benchmarks/master/results.png)

## 🧪 Test Suite

### New "Real-World" Benchmarks
These tests were added to simulate realistic workload scenarios:

| Test Name | Description | What it measures |
| :--- | :--- | :--- |
| **`brainfuck`** | Simulates a VM inside Lua. | Bytecode interpretation loop, complex state management, logic branches. |
| **`coro`** | Coroutine Scheduler (50k+ coroutines). | Context switching overhead (essential for Async I/O and Game AI). |
| **`c-call`** | Repeated calls to standard C functions. | The overhead of the Lua C-API boundary (critical for Game Engines). |
| **`json`** | JSON Serializer with nested tables. | String formatting, recursion, and hash-table traversals. |
| **`mem-access`** | Random access in large arrays. | Cache thrashing and RAM latency (LCG algorithm). |
| **`oop-dots`** | Particle simulation using OOP. | Metatable method dispatch (`:method`), field access (`self.x`), and number crunching. |
| **`ray`** | Simple Raytracer. | Massive creation of short-lived tables (Vectors), heavily stressing the GC. |

### Classic Benchmarks (Retained)
Standard benchmarks tailored for raw computation and algorithmic efficiency:

*   **`binary-trees`**: Stress tests GC memory allocation.
*   **`n-body`**: Floating-point arithmetic.
*   **`fannkuch-redux`**: Indexed-access and permutations.
*   **`fasta` / `k-nucleotide` / `regex-dna`**: String processing and DNA sequencing algorithms.
*   **`mandelbrot` / `juliaset`**: Math and loop performance.
*   **`heapsort`**: Array sorting performance.

> **Note:** Tests like `ack` (Ackermann) and `fixpoint-fact` were removed as they are considered too synthetic or represent non-idiomatic Lua code usage (e.g., excessive deep recursion).

## 🚀 Usage

### Requirements
*   **Bash** (The runner uses `TIMEFORMAT` for precision).
*   **Gnuplot** (Optional, for generating graphs).
*   Correctly named Lua binaries in your `$PATH` (e.g., `lua5.1`, `luajit`, etc.), or edit `runbenchmarks.lua` to match your system.

### Running tests

Basic run (3 iterations per test):
```bash
lua runbenchmarks.lua
```

Generate speedup comparison relative to Lua 5.1:
```bash
lua runbenchmarks.lua --speedup --output comparison --nruns 5
```

### Options
```text
  --nruns <n>      Number of times each test is executed (default = 3)
  --no-supress     Show full error messages from tests
  --output <name>  Filename prefix for the output results (txt/png)
  --normalize      Normalize the result based on the first binary
  --speedup        Compute speedup factor based on the first binary
  --no-plot        Skip Gnuplot generation
```

## Credits

*   Original suite by [gligneul](https://github.com/gligneul).
*   Scientific benchmarks derived from the [Computer Language Benchmarks Game](https://benchmarksgame-team.pages.debian.net/benchmarksgame/).
*   New benchmarks inspired by various real-world usage scenarios and written by Gemini 3.0 pro
