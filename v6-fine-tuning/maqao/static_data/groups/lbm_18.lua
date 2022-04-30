_group = {
  {
    group_size = 9,
    pattern = "LLLLLLLLL",
    opcodes = "VMOVSD,VMOVSD,VMOVSD,VMOVSD,VMOVSD,VADDSD,VMOVSD,VMOVSD,VMOVSD,",
    offsets = "40,8,16,24,32,0,56,48,64,",
    addresses = "0x3f8c,0x3f92,0x3f98,0x3f9e,0x3fa4,0x3faa,0x3fb8,0x3fbe,0x3fd6,",
    stride_status = "Not mono block loop",
    stride = 0,
    memory_status = "Success",
    accessed_memory = 72,
    accessed_memory_nooverlap = 72,
    accessed_memory_overlap = 0,
    span = 72,
    head = 0,
    unroll_factor = 1,
  },
  {
    group_size = 2,
    pattern = "LL",
    opcodes = "MOV,MOV,",
    offsets = "12,0,",
    addresses = "0x405f,0x3f76,",
    stride_status = "Not mono block loop",
    stride = 0,
    memory_status = "Success",
    accessed_memory = 12,
    accessed_memory_nooverlap = 12,
    accessed_memory_overlap = 0,
    span = 16,
    head = 0,
    unroll_factor = 2,
  },
  {
    group_size = 1,
    pattern = "S",
    opcodes = "VMOVLPS,",
    offsets = "0,",
    addresses = "0x402e,",
    stride_status = "Not mono block loop",
    stride = 0,
    memory_status = "Success",
    accessed_memory = 8,
    accessed_memory_nooverlap = 8,
    accessed_memory_overlap = 0,
    span = 8,
    head = 0,
    unroll_factor = 1,
  },
}