# Dolunay: Architectural Support for Independent Thread Scheduling in a RISC-V SIMT Accelerator

This repository contains the source code and software toolchain for **Dolunay**, a RISC-V-based SIMT accelerator featuring Independent Thread Scheduling (ITS).

## Single Instruction Multiple Threads

SIMT (Single Instruction Multiple Threads) is a term first used by Nvidia to describe their Tesla architecture; and it was used to unify vertex, texture and compute kernels in their GPU architectures. Today, SIMT architectures form the backbone of modern GPUs. Informally, they are architectures that are SPMD-like in their ISAs, but SIMD-like in their implementation. This allows SIMD efficiency in highly parallelizable kernels, while maintaining ease-of-development for software engineers.

More formally, SIMT architectures group threads into coexecution units called warps. Threads of a single warp always execute the same instruction, such that the instruction cache, fetch and decode mechanisms are all shared at a microarchitectural level. Threads have their own registers however, and so, a vectoral register file and multiple ALUs are needed to calculate the results correctly.

This structure is very similar to SIMD, in which single instructions operate on vectoral registers. The difference is that threads of a warp can also diverge during branches, requiring extra care during execution of conditional code. Legacy SIMT and ITS SIMT are two contrasting solutions to the problem of divergence.

## Legacy SIMT

Legacy SIMT architectures use a hardware-level IPDOM stack to track divergence and reconvergence. The conditional code is executed twice, once for branching and non-branching threads. The non-executing threads are masked in each execution. After the conditional code is over, the threads reconverge, and SIMD execution continues.

Nvidia's Tesla architecture was the first architecture of this kind, and it has also been implemented in RISC-V SIMT architectures as seen in Vortex and e-GPU. A simple animation is given below to show how legacy SIMT architectures execute conditional code.

![hippo](https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExb2ZidTdob2dnbnZoc2lvaXA0OTYyY3B4bjVzdWI4OG1jc2xhN3JseiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/VBk7nGa2iowYjuxjRt/giphy.gif)

## Independent Thread Scheduling

A limitation of legacy SIMT models is that they cannot execute certain intra-warp synchronization primitives, such as mutexes (Note: Such primitives are still supported at an inter-warp level). This limits the set of possible of kernels that can be implemented on legacy SIMT architectures. To further strengthen ease-of-development and enlarge the set of possible kernels, Nvidia switched to a new model of SIMT referred to as ITS (Independent Thread Scheduling) beginning with their Volta architecture in the year 2017.

Dolunay is the first open-source RISC-V SIMT architecture to support ITS. It uses cooperative multitasking and synchronization barriers to support many intra-warp synchronization primitives that wouldn't be possible for legacy SIMT architectures.

Dolunay is still only a proof-of-concept, but is being actively developed. The following animation shows how Dolunay executes conditional code, as well as its ability to multitask cooperatively via the YIELD custom instruction.


![hippo](https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExa3lqNzJmd2l6OHg2MXhjeHgyNThoY202bTBndmE5aGcycDZ4bmZ2byZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/Vmi7f02fj10shXwOhl/giphy.gif)
