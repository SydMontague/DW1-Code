/**
 * Copies 12 bytes from src to (dest + 20)
 * Returns the dest address.
 */
copy12toOffset20(dest, src) {
  r8 = load(r5)
  r9 = load(r5 + 0x04)
  r10 = load(r5 + 0x08)
  
  store(r4 + 0x14, r8)
  store(r4 + 0x18, r9)
  store(r4 + 0x1C, r10)

  return r4
}

0x0009b090 lw r8,0x0000(r5)
0x0009b094 lw r9,0x0004(r5)
0x0009b098 lw r10,0x0008(r5)
0x0009b09c sw r8,0x0014(r4)
0x0009b0a0 sw r9,0x0018(r4)
0x0009b0a4 sw r10,0x001c(r4)
0x0009b0a8 addu r2,r4,r0
0x0009b0ac jr r31
0x0009b0b0 nop