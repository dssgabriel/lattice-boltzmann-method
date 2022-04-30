_cqa_uarch_const = {
  ["nb simple decoders"] = 4,
  ["UQ throughput"] = 5,
  ["vector-unaligned optimal pattern"] = "1x512",
  ["unlamination threshold"] = 4,
  ["NOP 0f 1f decode"] = "fast",
  ["ports"] = {
    ["FP ADD"] = {
      [1] = 0,
      [2] = 1,
    },
    ["load"] = {
      [1] = 2,
      [2] = 3,
    },
    ["store address"] = {
      [1] = 7,
      [2] = 8,
    },
    ["misc"] = {
      [1] = 0,
      [2] = 1,
      [3] = 5,
      [4] = 6,
    },
    ["store data"] = {
      [1] = 4,
      [2] = 9,
    },
    ["DIV/SQRT"] = {
      [1] = 0,
    },
    ["FP MUL"] = {
      [1] = 0,
      [2] = 1,
    },
  },
  ["uop cache capacity"] = 1500,
  ["IQ throughput"] = 5,
  ["vector size in bytes"] = 64,
  ["FP DIV/SQRT unit native width"] = 32,
  ["store unit native width"] = 32,
  ["load unit native width"] = 64,
  ["Max Loop Buffer bytes"] = 1024,
  ["nb FP MUL units"] = 2,
  ["predec insns per cycle"] = 6,
  ["nb complex decoders"] = 1,
  ["INT vector size in bytes"] = 64,
  ["bytes fetched per cycle"] = 16,
  ["retire throughput"] = 5,
  ["nb execution ports"] = 10,
  ["Max Loop Buffer uops"] = 70,
}
