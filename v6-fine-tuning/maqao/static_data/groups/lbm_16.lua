_group = {
  {
    group_size = 9,
    pattern = "SSSSSSSSS",
    opcodes = "VMOVSD,VMOVSD,VMOVSD,VMOVSD,VMOVSD,VMOVSD,VMOVSD,VMOVSD,VMOVSD,",
    offsets = "0,8,16,24,32,40,48,56,64,",
    addresses = "0x3cd9,0x3cf8,0x3d21,0x3d43,0x3d7f,0x3db1,0x3de5,0x3e06,0x3e1c,",
    stride_status = "Not mono block loop",
    stride = 0,
    memory_status = "Success",
    accessed_memory = 72,
    accessed_memory_nooverlap = 72,
    accessed_memory_overlap = 0,
    span = 72,
    head = 0,
    unroll_factor = 9,
  },
  {
    group_size = 17,
    pattern = "LLLLLLLLLLLLLLLLL",
    opcodes = "VMOVSD,VMOVSD,VMOVSD,VMOVSD,VMOVSD,VMOVSD,VMOVSD,VMOVSD,VMOVSD,VMOVSD,VMOVSD,VMOVSD,VMOVSD,VMOVSD,VMOVSD,VMOVSD,VMOVSD,",
    offsets = "0,40,56,16,8,24,32,48,64,8,16,24,32,40,48,56,64,",
    addresses = "0x3ba6,0x3bac,0x3bb1,0x3bb6,0x3bbd,0x3bc2,0x3bc7,0x3be3,0x3bf3,0x3cdf,0x3d08,0x3d27,0x3d50,0x3d86,0x3dc2,0x3deb,0x3e0d,",
    stride_status = "Not mono block loop",
    stride = 0,
    memory_status = "Success",
    accessed_memory = 136,
    accessed_memory_nooverlap = 72,
    accessed_memory_overlap = 64,
    span = 72,
    head = 0,
    unroll_factor = 1,
  },
}
