_cqa_text_report = {
  paths = {
    {
      hint = {
        {
          details = "These instructions generate more than one micro-operation and only one of them can be decoded during a cycle and the extra micro-operations increase pressure on execution units.\n - VCVTSI2SD: 1 occurrences\n - VPERMPD: 2 occurrences\n - VSHUFPD: 1 occurrences\n",
          title = "Complex instructions",
          txt = "Detected COMPLEX INSTRUCTIONS.\n",
        },
        {
          workaround = "Avoid mixing data with different types. In particular, check if the type of constants is the same as array elements.",
          details = " - VCVTSI2SD (INT32/64 to FP64, scalar): 1 occurrences\n",
          title = "Conversion instructions",
          txt = "Detected expensive conversion instructions.",
        },
        {
          title = "Type of elements and instruction set",
          txt = "18 SSE or AVX instructions are processing arithmetic or math operations on double precision FP elements in scalar mode (one at a time).\n2 SSE or AVX instructions are processing arithmetic or math operations on double precision FP elements in vector mode (two at a time).\n",
        },
        {
          title = "Matching between your loop (in the source code) and the binary loop",
          txt = "The binary loop is composed of 27 FP arithmetical operations:\n - 17: addition or subtraction (5 inside FMA instructions)\n - 9: multiply (5 inside FMA instructions)\n - 1: divide\nThe binary loop is loading 216 bytes (27 double precision FP elements).\nThe binary loop is storing 112 bytes (14 double precision FP elements).",
        },
        {
          title = "Arithmetic intensity",
          txt = "Arithmetic intensity is 0.08 FP operations per loaded or stored byte.",
        },
      },
      expert = {
        {
          title = "General properties",
          txt = "nb instructions    : 79\nnb uops            : 83\nloop length        : 385\nused x86 registers : 14\nused mmx registers : 0\nused xmm registers : 16\nused ymm registers : 2\nused zmm registers : 0\nnb stack references: 2\nADD-SUB / MUL ratio: 2.50\n",
        },
        {
          title = "Front-end",
          txt = "MACRO FUSION NOT POSSIBLE\nFIT IN UOP CACHE\nmicro-operation queue: 16.60 cycles\nfront end            : 16.60 cycles\n",
        },
        {
          title = "Back-end",
          txt = "       | P0    | P1    | P2    | P3    | P4   | P5    | P6    | P7   | P8   | P9\n----------------------------------------------------------------------------------\nuops   | 14.00 | 13.50 | 10.00 | 10.00 | 3.50 | 12.75 | 12.75 | 3.50 | 3.50 | 3.50\ncycles | 14.00 | 13.50 | 10.00 | 10.00 | 3.50 | 12.75 | 12.75 | 3.50 | 3.50 | 3.50\n\nCycles executing div or sqrt instructions: 4.00\n",
        },
        {
          title = "Cycles summary",
          txt = "Front-end : 16.60\nDispatch  : 14.00\nDIV/SQRT  : 4.00\nOverall L1: 16.60\n",
        },
        {
          title = "Vectorization ratios",
          txt = "INT\nall    : 0%\nload   : NA (no load vectorizable/vectorized instructions)\nstore  : NA (no store vectorizable/vectorized instructions)\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nfma    : NA (no fma vectorizable/vectorized instructions)\nother  : 0%\nFP\nall     : 23%\nload    : 26%\nstore   : 42%\nmul     : 0%\nadd-sub : 20%\nfma     : 0%\ndiv/sqrt: 0%\nother   : 66%\nINT+FP\nall     : 21%\nload    : 26%\nstore   : 42%\nmul     : 0%\nadd-sub : 20%\nfma     : 0%\ndiv/sqrt: 0%\nother   : 36%\n",
        },
        {
          title = "Vector efficiency ratios",
          txt = "INT\nall    : 8%\nload   : NA (no load vectorizable/vectorized instructions)\nstore  : NA (no store vectorizable/vectorized instructions)\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nfma    : NA (no fma vectorizable/vectorized instructions)\nother  : 8%\nFP\nall     : 17%\nload    : 19%\nstore   : 25%\nmul     : 12%\nadd-sub : 15%\nfma     : 12%\ndiv/sqrt: 12%\nother   : 29%\nINT+FP\nall     : 16%\nload    : 19%\nstore   : 25%\nmul     : 12%\nadd-sub : 15%\nfma     : 12%\ndiv/sqrt: 12%\nother   : 19%\n",
        },
        {
          title = "Cycles and memory resources usage",
          txt = "Assuming all data fit into the L1 cache, each iteration of the binary loop takes 16.60 cycles. At this rate:\n - 10% of peak load performance is reached (13.01 out of 128.00 bytes loaded per cycle (GB/s @ 1GHz))\n - 10% of peak store performance is reached (6.75 out of 64.00 bytes stored per cycle (GB/s @ 1GHz))\n",
        },
        {
          title = "Front-end bottlenecks",
          txt = "Performance is limited by instruction throughput (loading/decoding program instructions to execution core) (front-end is a bottleneck).\n\nBy removing all these bottlenecks, you can lower the cost of an iteration from 16.60 to 14.00 cycles (1.19x speedup).\n",
        },
        {
          title = "ASM code",
          txt = "In the binary file, the address of the loop is: 1980\n\nInstruction                           | Nb FU | P0   | P1   | P2   | P3   | P4   | P5   | P6   | P7   | P8   | P9   | Latency | Recip. throughput\n-------------------------------------------------------------------------------------------------------------------------------------------------\nMOV %R12D,%R8D                        | 1     | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.25\nIMUL %R9D,%R8D                        | 1     | 0    | 1    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 3       | 1\nMOV %R10D,%EDX                        | 1     | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.25\nMOV $0x1,%EAX                         | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nTEST $0x1,%DIL                        | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nJNE 1a15 <main+0x835>                 | 1     | 0.50 | 0    | 0    | 0    | 0    | 0    | 0.50 | 0    | 0    | 0    | 0       | 0.50-1\nLEA 0x1(%R8),%EDX                     | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nMOV (%RSI,%RDX,4),%ECX                | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 2       | 0.50\nCMP $0x2,%ECX                         | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nJE 228f <main+0x10af>                 | 1     | 0.50 | 0    | 0    | 0    | 0    | 0    | 0.50 | 0    | 0    | 0    | 0       | 0.50-1\nCMP $0x3,%ECX                         | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nJE 2239 <main+0x1059>                 | 1     | 0.50 | 0    | 0    | 0    | 0    | 0    | 0.50 | 0    | 0    | 0    | 0       | 0.50-1\nCMP $0x1,%ECX                         | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nJE 220d <main+0x102d>                 | 1     | 0.50 | 0    | 0    | 0    | 0    | 0    | 0.50 | 0    | 0    | 0    | 0       | 0.50-1\nMOV $0x2,%EAX                         | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nLEA 0x9(%R10),%EDX                    | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nCMP %RDI,%RAX                         | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nJNE 1a15 <main+0x835>                 | 1     | 0.50 | 0    | 0    | 0    | 0    | 0    | 0.50 | 0    | 0    | 0    | 0       | 0.50-1\nJMP 1b67 <main+0x987>                 | 1     | 0    | 0    | 0    | 0    | 0    | 0    | 1    | 0    | 0    | 0    | 0       | 1-2\nINC %R9                               | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nADD %EBX,%R10D                        | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nCMP %R11,%R9                          | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nJNE 1980 <main+0x7a0>                 | 1     | 0.50 | 0    | 0    | 0    | 0    | 0    | 0.50 | 0    | 0    | 0    | 0       | 0.50-1\nMOV -0x870(%RBP),%RCX                 | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 2       | 0.50\nMOV %R10D,%EAX                        | 1     | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.25\nLEA (%RCX,%RAX,8),%RDX                | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nVPERMPD $0x4e,0x8(%RCX,%RAX,8),%YMM1  | 2     | 0    | 0    | 0.50 | 0.50 | 0    | 1    | 0    | 0    | 0    | 0    | 3       | 1\nVPERMPD $0x4e,0x28(%RDX),%YMM15       | 2     | 0    | 0    | 0.50 | 0.50 | 0    | 1    | 0    | 0    | 0    | 0    | 3       | 1\nVMOVUPD %YMM1,0x8(%RDX)               | 1     | 0    | 0    | 0    | 0    | 0.50 | 0    | 0    | 0.50 | 0.50 | 0.50 | 3       | 0.50\nVMOVUPD %YMM15,0x28(%RDX)             | 1     | 0    | 0    | 0    | 0    | 0.50 | 0    | 0    | 0.50 | 0.50 | 0.50 | 3       | 0.50\nJMP 19bb <main+0x7db>                 | 1     | 0    | 0    | 0    | 0    | 0    | 0    | 1    | 0    | 0    | 0    | 0       | 1-2\nMOV -0x870(%RBP),%R14                 | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 2       | 0.50\nMOV %R10D,%ECX                        | 1     | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.25\nLEA (%R14,%RCX,8),%R15                | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nVMOVSD 0x20(%R15),%XMM6               | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.50\nVMOVUPD 0x38(%R15),%XMM9              | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 3       | 0.50\nVSUBSD 0x10(%R15),%XMM6,%XMM2         | 1     | 0.50 | 0.50 | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVSHUFPD $0x1,0x28(%R15),%XMM9,%XMM8   | 2     | 0    | 0.50 | 0.50 | 0.50 | 0    | 0.50 | 0    | 0    | 0    | 0    | 1       | 0.50\nVMOVSD 0x8(%R15),%XMM0                | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.50\nVMULSD %XMM7,%XMM2,%XMM10             | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVMOVSD %XMM0,0x18(%R15)               | 1     | 0    | 0    | 0    | 0    | 0.50 | 0    | 0    | 0.50 | 0.50 | 0.50 | 3       | 0.50\nVMOVDDUP %XMM10,%XMM12                | 1     | 0    | 0    | 0    | 0    | 0    | 1    | 0    | 0    | 0    | 0    | 1       | 1\nVADDPD %XMM8,%XMM12,%XMM11            | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVSUBPD %XMM12,%XMM8,%XMM13            | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVMOVSD %XMM11,%XMM13,%XMM14           | 1     | 0.33 | 0.33 | 0    | 0    | 0    | 0.33 | 0    | 0    | 0    | 0    | 1       | 0.33\nVMOVUPD %XMM14,0x30(%R15)             | 1     | 0    | 0    | 0    | 0    | 0.50 | 0    | 0    | 0.50 | 0.50 | 0.50 | 3       | 0.50\nJMP 19bb <main+0x7db>                 | 1     | 0    | 0    | 0    | 0    | 0    | 0    | 1    | 0    | 0    | 0    | 0       | 1-2\nMOV -0x43c(%RBP),%EDX                 | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 2       | 0.50\nMOV -0x870(%RBP),%R15                 | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 2       | 0.50\nVXORPD %XMM10,%XMM10,%XMM10           | 1     | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.25\nMOV %R10D,%R14D                       | 1     | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.25\nLEA (%R15,%R14,8),%RAX                | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nVCVTSI2SD %RDX,%XMM10,%XMM11          | 2     | 0.50 | 0.50 | 0    | 0    | 0    | 1    | 0    | 0    | 0    | 0    | 6       | 1\nVMOVSD 0x18(%RAX),%XMM9               | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.50\nVMOVSD 0x30(%RAX),%XMM8               | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.50\nVMOVSD 0x38(%RAX),%XMM6               | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.50\nVADDSD %XMM8,%XMM9,%XMM2              | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVMULSD %XMM4,%XMM11,%XMM13            | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVSUBSD %XMM11,%XMM3,%XMM12            | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVADDSD %XMM6,%XMM2,%XMM10             | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVMOVSD 0x20(%RAX),%XMM1               | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.50\nVMOVSD 0x10(%RAX),%XMM0               | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.50\nVMULSD %XMM13,%XMM12,%XMM15           | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVFMADD132SD 0x33d2(%RIP),%XMM1,%XMM10 | 1     | 0.50 | 0.50 | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVADDSD (%RAX),%XMM0,%XMM14            | 1     | 0.50 | 0.50 | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVMOVSD 0x3426(%RIP),%XMM11            | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.50\nVSUBSD %XMM0,%XMM1,%XMM1              | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVSUBSD %XMM15,%XMM11,%XMM13           | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVADDSD %XMM14,%XMM10,%XMM12           | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVFMADD231SD %XMM7,%XMM1,%XMM6         | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVMULSD %XMM5,%XMM15,%XMM15            | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVDIVSD %XMM13,%XMM12,%XMM14           | 1     | 1    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 13-14   | 4\nVFNMADD132SD %XMM7,%XMM8,%XMM1        | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVMOVSD %XMM9,0x8(%RAX)                | 1     | 0    | 0    | 0    | 0    | 0.50 | 0    | 0    | 0.50 | 0.50 | 0.50 | 3       | 0.50\nVFMADD231SD %XMM15,%XMM14,%XMM6       | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVFMADD132SD %XMM15,%XMM1,%XMM14       | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVMOVSD %XMM6,0x28(%RAX)               | 1     | 0    | 0    | 0    | 0    | 0.50 | 0    | 0    | 0.50 | 0.50 | 0.50 | 3       | 0.50\nVMOVSD %XMM14,0x40(%RAX)              | 1     | 0    | 0    | 0    | 0    | 0.50 | 0    | 0    | 0.50 | 0.50 | 0.50 | 3       | 0.50\nJMP 19bb <main+0x7db>                 | 1     | 0    | 0    | 0    | 0    | 0    | 0    | 1    | 0    | 0    | 0    | 0       | 1-2\n",
        },
      },
      header = {
        "5% of peak computational performance is used (1.63 out of 32.00 FLOP per cycle (GFLOPS @ 1GHz))",
      },
      brief = {
      },
      gain = {
        {
          workaround = " - Try to reorganize arrays of structures to structures of arrays\n - Consider to permute loops (see vectorization gain report)\n",
          title = "Code clean check",
          txt = "Detected a slowdown caused by scalar integer instructions (typically used for address computation).\nBy removing them, you can lower the cost of an iteration from 16.60 to 12.50 cycles (1.33x speedup).",
        },
        {
          workaround = " - Try another compiler or update/tune your current one\n - Remove inter-iterations dependences from your loop and make it unit-stride:\n  * If your arrays have 2 or more dimensions, check whether elements are accessed contiguously and, otherwise, try to permute loops accordingly\n  * If your loop streams arrays of structures (AoS), try to use structures of arrays instead (SoA)\n",
          details = "21% of SSE/AVX instructions are used in vector version (process two or more data elements in vector registers):\n - 26% of SSE/AVX loads are used in vector version.\n - 42% of SSE/AVX stores are used in vector version.\n - 20% of SSE/AVX addition or subtraction instructions are used in vector version.\n - 0% of SSE/AVX multiply instructions are used in vector version.\n - 0% of SSE/AVX fused multiply-add instructions are used in vector version.\n - 0% of SSE/AVX nil are used in vector version.\n - 36% of SSE/AVX instructions that are not load, store, addition, subtraction nor multiply instructions are used in vector version.\nSince your execution units are vector units, only a fully vectorized loop can use their full power.\n",
          title = "Vectorization",
          txt = "Your loop is poorly vectorized.\nOnly 16% of vector register length is used (average across all SSE/AVX instructions).\nBy fully vectorizing your loop, you can lower the cost of an iteration from 16.60 to 2.02 cycles (8.21x speedup).",
        },
        {
          title = "Execution units bottlenecks",
          txt = "Found no such bottlenecks but see expert reports for more complex bottlenecks.",
        },
      },
      potential = {
        {
          workaround = "Try to change order in which elements are evaluated (using parentheses) in arithmetic expressions containing both ADD/SUB and MUL operations to enable your compiler to generate FMA instructions wherever possible.\nFor instance a + b*c is a valid FMA (MUL then ADD).\nHowever (a+b)* c cannot be translated into an FMA (ADD then MUL).",
          title = "FMA",
          txt = "Detected 5 FMA (fused multiply-add) operations.\nPresence of both ADD/SUB and MUL operations.",
        },
      },
    },
  },
  AVG = {
      hint = {
        {
          details = "These instructions generate more than one micro-operation and only one of them can be decoded during a cycle and the extra micro-operations increase pressure on execution units.\n - VCVTSI2SD: 1 occurrences\n - VPERMPD: 2 occurrences\n - VSHUFPD: 1 occurrences\n",
          title = "Complex instructions",
          txt = "Detected COMPLEX INSTRUCTIONS.\n",
        },
        {
          workaround = "Avoid mixing data with different types. In particular, check if the type of constants is the same as array elements.",
          details = " - VCVTSI2SD (INT32/64 to FP64, scalar): 1 occurrences\n",
          title = "Conversion instructions",
          txt = "Detected expensive conversion instructions.",
        },
        {
          title = "Type of elements and instruction set",
          txt = "18 SSE or AVX instructions are processing arithmetic or math operations on double precision FP elements in scalar mode (one at a time).\n2 SSE or AVX instructions are processing arithmetic or math operations on double precision FP elements in vector mode (two at a time).\n",
        },
        {
          title = "Matching between your loop (in the source code) and the binary loop",
          txt = "The binary loop is composed of 27 FP arithmetical operations:\n - 17: addition or subtraction (5 inside FMA instructions)\n - 9: multiply (5 inside FMA instructions)\n - 1: divide\nThe binary loop is loading 216 bytes (27 double precision FP elements).\nThe binary loop is storing 112 bytes (14 double precision FP elements).",
        },
        {
          title = "Arithmetic intensity",
          txt = "Arithmetic intensity is 0.08 FP operations per loaded or stored byte.",
        },
      },
      expert = {
        {
          title = "General properties",
          txt = "nb instructions    : 79\nnb uops            : 83\nloop length        : 385\nused x86 registers : 14\nused mmx registers : 0\nused xmm registers : 16\nused ymm registers : 2\nused zmm registers : 0\nnb stack references: 2\nADD-SUB / MUL ratio: 2.50\n",
        },
        {
          title = "Front-end",
          txt = "MACRO FUSION NOT POSSIBLE\nFIT IN UOP CACHE\nmicro-operation queue: 16.60 cycles\nfront end            : 16.60 cycles\n",
        },
        {
          title = "Back-end",
          txt = "       | P0    | P1    | P2    | P3    | P4   | P5    | P6    | P7   | P8   | P9\n----------------------------------------------------------------------------------\nuops   | 14.00 | 13.50 | 10.00 | 10.00 | 3.50 | 12.75 | 12.75 | 3.50 | 3.50 | 3.50\ncycles | 14.00 | 13.50 | 10.00 | 10.00 | 3.50 | 12.75 | 12.75 | 3.50 | 3.50 | 3.50\n\nCycles executing div or sqrt instructions: 4.00\n",
        },
        {
          title = "Cycles summary",
          txt = "Front-end : 16.60\nDispatch  : 14.00\nDIV/SQRT  : 4.00\nOverall L1: 16.60\n",
        },
        {
          title = "Vectorization ratios",
          txt = "INT\nall    : 0%\nload   : NA (no load vectorizable/vectorized instructions)\nstore  : NA (no store vectorizable/vectorized instructions)\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nfma    : NA (no fma vectorizable/vectorized instructions)\nother  : 0%\nFP\nall     : 23%\nload    : 26%\nstore   : 42%\nmul     : 0%\nadd-sub : 20%\nfma     : 0%\ndiv/sqrt: 0%\nother   : 66%\nINT+FP\nall     : 21%\nload    : 26%\nstore   : 42%\nmul     : 0%\nadd-sub : 20%\nfma     : 0%\ndiv/sqrt: 0%\nother   : 36%\n",
        },
        {
          title = "Vector efficiency ratios",
          txt = "INT\nall    : 8%\nload   : NA (no load vectorizable/vectorized instructions)\nstore  : NA (no store vectorizable/vectorized instructions)\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nfma    : NA (no fma vectorizable/vectorized instructions)\nother  : 8%\nFP\nall     : 17%\nload    : 19%\nstore   : 25%\nmul     : 12%\nadd-sub : 15%\nfma     : 12%\ndiv/sqrt: 12%\nother   : 29%\nINT+FP\nall     : 16%\nload    : 19%\nstore   : 25%\nmul     : 12%\nadd-sub : 15%\nfma     : 12%\ndiv/sqrt: 12%\nother   : 19%\n",
        },
        {
          title = "Cycles and memory resources usage",
          txt = "Assuming all data fit into the L1 cache, each iteration of the binary loop takes 16.60 cycles. At this rate:\n - 10% of peak load performance is reached (13.01 out of 128.00 bytes loaded per cycle (GB/s @ 1GHz))\n - 10% of peak store performance is reached (6.75 out of 64.00 bytes stored per cycle (GB/s @ 1GHz))\n",
        },
        {
          title = "Front-end bottlenecks",
          txt = "Performance is limited by instruction throughput (loading/decoding program instructions to execution core) (front-end is a bottleneck).\n\nBy removing all these bottlenecks, you can lower the cost of an iteration from 16.60 to 14.00 cycles (1.19x speedup).\n",
        },
        {
          title = "ASM code",
          txt = "In the binary file, the address of the loop is: 1980\n\nInstruction                           | Nb FU | P0   | P1   | P2   | P3   | P4   | P5   | P6   | P7   | P8   | P9   | Latency | Recip. throughput\n-------------------------------------------------------------------------------------------------------------------------------------------------\nMOV %R12D,%R8D                        | 1     | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.25\nIMUL %R9D,%R8D                        | 1     | 0    | 1    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 3       | 1\nMOV %R10D,%EDX                        | 1     | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.25\nMOV $0x1,%EAX                         | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nTEST $0x1,%DIL                        | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nJNE 1a15 <main+0x835>                 | 1     | 0.50 | 0    | 0    | 0    | 0    | 0    | 0.50 | 0    | 0    | 0    | 0       | 0.50-1\nLEA 0x1(%R8),%EDX                     | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nMOV (%RSI,%RDX,4),%ECX                | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 2       | 0.50\nCMP $0x2,%ECX                         | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nJE 228f <main+0x10af>                 | 1     | 0.50 | 0    | 0    | 0    | 0    | 0    | 0.50 | 0    | 0    | 0    | 0       | 0.50-1\nCMP $0x3,%ECX                         | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nJE 2239 <main+0x1059>                 | 1     | 0.50 | 0    | 0    | 0    | 0    | 0    | 0.50 | 0    | 0    | 0    | 0       | 0.50-1\nCMP $0x1,%ECX                         | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nJE 220d <main+0x102d>                 | 1     | 0.50 | 0    | 0    | 0    | 0    | 0    | 0.50 | 0    | 0    | 0    | 0       | 0.50-1\nMOV $0x2,%EAX                         | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nLEA 0x9(%R10),%EDX                    | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nCMP %RDI,%RAX                         | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nJNE 1a15 <main+0x835>                 | 1     | 0.50 | 0    | 0    | 0    | 0    | 0    | 0.50 | 0    | 0    | 0    | 0       | 0.50-1\nJMP 1b67 <main+0x987>                 | 1     | 0    | 0    | 0    | 0    | 0    | 0    | 1    | 0    | 0    | 0    | 0       | 1-2\nINC %R9                               | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nADD %EBX,%R10D                        | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nCMP %R11,%R9                          | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nJNE 1980 <main+0x7a0>                 | 1     | 0.50 | 0    | 0    | 0    | 0    | 0    | 0.50 | 0    | 0    | 0    | 0       | 0.50-1\nMOV -0x870(%RBP),%RCX                 | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 2       | 0.50\nMOV %R10D,%EAX                        | 1     | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.25\nLEA (%RCX,%RAX,8),%RDX                | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nVPERMPD $0x4e,0x8(%RCX,%RAX,8),%YMM1  | 2     | 0    | 0    | 0.50 | 0.50 | 0    | 1    | 0    | 0    | 0    | 0    | 3       | 1\nVPERMPD $0x4e,0x28(%RDX),%YMM15       | 2     | 0    | 0    | 0.50 | 0.50 | 0    | 1    | 0    | 0    | 0    | 0    | 3       | 1\nVMOVUPD %YMM1,0x8(%RDX)               | 1     | 0    | 0    | 0    | 0    | 0.50 | 0    | 0    | 0.50 | 0.50 | 0.50 | 3       | 0.50\nVMOVUPD %YMM15,0x28(%RDX)             | 1     | 0    | 0    | 0    | 0    | 0.50 | 0    | 0    | 0.50 | 0.50 | 0.50 | 3       | 0.50\nJMP 19bb <main+0x7db>                 | 1     | 0    | 0    | 0    | 0    | 0    | 0    | 1    | 0    | 0    | 0    | 0       | 1-2\nMOV -0x870(%RBP),%R14                 | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 2       | 0.50\nMOV %R10D,%ECX                        | 1     | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.25\nLEA (%R14,%RCX,8),%R15                | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nVMOVSD 0x20(%R15),%XMM6               | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.50\nVMOVUPD 0x38(%R15),%XMM9              | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 3       | 0.50\nVSUBSD 0x10(%R15),%XMM6,%XMM2         | 1     | 0.50 | 0.50 | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVSHUFPD $0x1,0x28(%R15),%XMM9,%XMM8   | 2     | 0    | 0.50 | 0.50 | 0.50 | 0    | 0.50 | 0    | 0    | 0    | 0    | 1       | 0.50\nVMOVSD 0x8(%R15),%XMM0                | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.50\nVMULSD %XMM7,%XMM2,%XMM10             | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVMOVSD %XMM0,0x18(%R15)               | 1     | 0    | 0    | 0    | 0    | 0.50 | 0    | 0    | 0.50 | 0.50 | 0.50 | 3       | 0.50\nVMOVDDUP %XMM10,%XMM12                | 1     | 0    | 0    | 0    | 0    | 0    | 1    | 0    | 0    | 0    | 0    | 1       | 1\nVADDPD %XMM8,%XMM12,%XMM11            | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVSUBPD %XMM12,%XMM8,%XMM13            | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVMOVSD %XMM11,%XMM13,%XMM14           | 1     | 0.33 | 0.33 | 0    | 0    | 0    | 0.33 | 0    | 0    | 0    | 0    | 1       | 0.33\nVMOVUPD %XMM14,0x30(%R15)             | 1     | 0    | 0    | 0    | 0    | 0.50 | 0    | 0    | 0.50 | 0.50 | 0.50 | 3       | 0.50\nJMP 19bb <main+0x7db>                 | 1     | 0    | 0    | 0    | 0    | 0    | 0    | 1    | 0    | 0    | 0    | 0       | 1-2\nMOV -0x43c(%RBP),%EDX                 | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 2       | 0.50\nMOV -0x870(%RBP),%R15                 | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 2       | 0.50\nVXORPD %XMM10,%XMM10,%XMM10           | 1     | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.25\nMOV %R10D,%R14D                       | 1     | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.25\nLEA (%R15,%R14,8),%RAX                | 1     | 0.25 | 0.25 | 0    | 0    | 0    | 0.25 | 0.25 | 0    | 0    | 0    | 1       | 0.25\nVCVTSI2SD %RDX,%XMM10,%XMM11          | 2     | 0.50 | 0.50 | 0    | 0    | 0    | 1    | 0    | 0    | 0    | 0    | 6       | 1\nVMOVSD 0x18(%RAX),%XMM9               | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.50\nVMOVSD 0x30(%RAX),%XMM8               | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.50\nVMOVSD 0x38(%RAX),%XMM6               | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.50\nVADDSD %XMM8,%XMM9,%XMM2              | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVMULSD %XMM4,%XMM11,%XMM13            | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVSUBSD %XMM11,%XMM3,%XMM12            | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVADDSD %XMM6,%XMM2,%XMM10             | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVMOVSD 0x20(%RAX),%XMM1               | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.50\nVMOVSD 0x10(%RAX),%XMM0               | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.50\nVMULSD %XMM13,%XMM12,%XMM15           | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVFMADD132SD 0x33d2(%RIP),%XMM1,%XMM10 | 1     | 0.50 | 0.50 | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVADDSD (%RAX),%XMM0,%XMM14            | 1     | 0.50 | 0.50 | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVMOVSD 0x3426(%RIP),%XMM11            | 1     | 0    | 0    | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0       | 0.50\nVSUBSD %XMM0,%XMM1,%XMM1              | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVSUBSD %XMM15,%XMM11,%XMM13           | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVADDSD %XMM14,%XMM10,%XMM12           | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVFMADD231SD %XMM7,%XMM1,%XMM6         | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVMULSD %XMM5,%XMM15,%XMM15            | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVDIVSD %XMM13,%XMM12,%XMM14           | 1     | 1    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 13-14   | 4\nVFNMADD132SD %XMM7,%XMM8,%XMM1        | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVMOVSD %XMM9,0x8(%RAX)                | 1     | 0    | 0    | 0    | 0    | 0.50 | 0    | 0    | 0.50 | 0.50 | 0.50 | 3       | 0.50\nVFMADD231SD %XMM15,%XMM14,%XMM6       | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVFMADD132SD %XMM15,%XMM1,%XMM14       | 1     | 0.50 | 0.50 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4       | 0.50\nVMOVSD %XMM6,0x28(%RAX)               | 1     | 0    | 0    | 0    | 0    | 0.50 | 0    | 0    | 0.50 | 0.50 | 0.50 | 3       | 0.50\nVMOVSD %XMM14,0x40(%RAX)              | 1     | 0    | 0    | 0    | 0    | 0.50 | 0    | 0    | 0.50 | 0.50 | 0.50 | 3       | 0.50\nJMP 19bb <main+0x7db>                 | 1     | 0    | 0    | 0    | 0    | 0    | 0    | 1    | 0    | 0    | 0    | 0       | 1-2\n",
        },
      },
      header = {
        "5% of peak computational performance is used (1.63 out of 32.00 FLOP per cycle (GFLOPS @ 1GHz))",
      },
      brief = {
      },
      gain = {
        {
          workaround = " - Try to reorganize arrays of structures to structures of arrays\n - Consider to permute loops (see vectorization gain report)\n",
          title = "Code clean check",
          txt = "Detected a slowdown caused by scalar integer instructions (typically used for address computation).\nBy removing them, you can lower the cost of an iteration from 16.60 to 12.50 cycles (1.33x speedup).",
        },
        {
          workaround = " - Try another compiler or update/tune your current one\n - Remove inter-iterations dependences from your loop and make it unit-stride:\n  * If your arrays have 2 or more dimensions, check whether elements are accessed contiguously and, otherwise, try to permute loops accordingly\n  * If your loop streams arrays of structures (AoS), try to use structures of arrays instead (SoA)\n",
          details = "21% of SSE/AVX instructions are used in vector version (process two or more data elements in vector registers):\n - 26% of SSE/AVX loads are used in vector version.\n - 42% of SSE/AVX stores are used in vector version.\n - 20% of SSE/AVX addition or subtraction instructions are used in vector version.\n - 0% of SSE/AVX multiply instructions are used in vector version.\n - 0% of SSE/AVX fused multiply-add instructions are used in vector version.\n - 0% of SSE/AVX nil are used in vector version.\n - 36% of SSE/AVX instructions that are not load, store, addition, subtraction nor multiply instructions are used in vector version.\nSince your execution units are vector units, only a fully vectorized loop can use their full power.\n",
          title = "Vectorization",
          txt = "Your loop is poorly vectorized.\nOnly 16% of vector register length is used (average across all SSE/AVX instructions).\nBy fully vectorizing your loop, you can lower the cost of an iteration from 16.60 to 2.02 cycles (8.21x speedup).",
        },
        {
          title = "Execution units bottlenecks",
          txt = "Found no such bottlenecks but see expert reports for more complex bottlenecks.",
        },
      },
      potential = {
        {
          workaround = "Try to change order in which elements are evaluated (using parentheses) in arithmetic expressions containing both ADD/SUB and MUL operations to enable your compiler to generate FMA instructions wherever possible.\nFor instance a + b*c is a valid FMA (MUL then ADD).\nHowever (a+b)* c cannot be translated into an FMA (ADD then MUL).",
          title = "FMA",
          txt = "Detected 5 FMA (fused multiply-add) operations.\nPresence of both ADD/SUB and MUL operations.",
        },
      },
    },
  common = {
    header = {
      "",
      "Warnings:\n - Non-innermost loop: analyzing only self part (ignoring child loops).\n - Ignoring paths for analysis\n - Too many paths. If you really need to analyze all of the 84 paths individually, rerun with max-paths=84\n - RecMII not computed since number of paths is unknown or > max_paths\n - Streams not analyzed since number of paths is unknown or > max_paths\n",
      "Try to simplify control and/or increase the maximum number of paths per function/loop through the 'max-paths-nb' option.\n",
      "This loop has 84 execution paths.\n",
      "The presence of multiple execution paths is typically the main/first bottleneck.\nTry to simplify control inside loop: ideally, try to remove all conditional expressions, for example by (if applicable):\n - hoisting them (moving them outside the loop)\n - turning them into conditional moves, MIN or MAX\n\n",
    },
    nb_paths = 84,
  },
}
