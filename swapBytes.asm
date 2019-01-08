/**
 * Swaps the two least significant bytes of a given value with each other.
 */
int swapBytes(val) {
  r3 = r4 >> 8
  r2 = r4 << 8
  return r2 | r3
}

0x000f1ab0 sra r3,r4,0x08
0x000f1ab4 sll r2,r4,0x08
0x000f1ab8 or r2,r3,r2
0x000f1abc jr r31
0x000f1ac0 andi r2,r2,0xffff