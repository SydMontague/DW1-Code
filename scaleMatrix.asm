/**
 * Scales a matrix by a given vector (x, y, z) which representing a scale matrix.
 * A pointer to the scaled matrix is returned.
 * All values in the matrix are fixed point numbers, where 4096 is 1.0.
 *
 * [ a b c ]   [ x 0 0 ]   [ a*x b*y c*z ]
 * [ d e f ] * [ 0 y 0 ] = [ d*x e*y f*z ]
 * [ g h i ]   [ 0 0 z ]   [ g*x h*y i*z ]
 *
 */
scaleMatrix(destPtr, scaleVector) {
  scaleX = load(scaleVector)
  scaleY = load(scaleVector + 0x04)
  scaleZ = load(scaleVector + 0x08)
  
  store(destPtr, load(destPtr + 0x00) * scaleX / 4096)
  store(destPtr, load(destPtr + 0x02) * scaleY / 4096)
  store(destPtr, load(destPtr + 0x04) * scaleZ / 4096)
  
  store(destPtr, load(destPtr + 0x06) * scaleX / 4096)
  store(destPtr, load(destPtr + 0x08) * scaleY / 4096)
  store(destPtr, load(destPtr + 0x0A) * scaleZ / 4096)
  
  store(destPtr, load(destPtr + 0x0C) * scaleX / 4096)
  store(destPtr, load(destPtr + 0x0E) * scaleY / 4096)
  store(destPtr, load(destPtr + 0x10) * scaleZ / 4096)
  
  return destPtr
}

0x0009b0c0 lw r11,0x0000(r5)
0x0009b0c4 lw r12,0x0004(r5)
0x0009b0c8 lw r13,0x0008(r5)
0x0009b0cc lw r8,0x0000(r4)
0x0009b0d0 nop
0x0009b0d4 andi r9,r8,0xffff
0x0009b0d8 sll r9,r9,0x10
0x0009b0dc sra r9,r9,0x10
0x0009b0e0 multu r9,r11
0x0009b0e4 mflo r9
0x0009b0e8 sra r9,r9,0x0c
0x0009b0ec andi r9,r9,0xffff
0x0009b0f0 sra r10,r8,0x10
0x0009b0f4 multu r10,r12
0x0009b0f8 mflo r10
0x0009b0fc sra r10,r10,0x0c
0x0009b100 sll r10,r10,0x10
0x0009b104 or r9,r9,r10
0x0009b108 sw r9,0x0000(r4)
0x0009b10c lw r8,0x0004(r4)
0x0009b110 nop
0x0009b114 andi r9,r8,0xffff
0x0009b118 sll r9,r9,0x10
0x0009b11c sra r9,r9,0x10
0x0009b120 multu r9,r13
0x0009b124 mflo r9
0x0009b128 sra r9,r9,0x0c
0x0009b12c andi r9,r9,0xffff
0x0009b130 sra r10,r8,0x10
0x0009b134 multu r10,r11
0x0009b138 mflo r10
0x0009b13c sra r10,r10,0x0c
0x0009b140 sll r10,r10,0x10
0x0009b144 or r9,r9,r10
0x0009b148 sw r9,0x0004(r4)
0x0009b14c lw r8,0x0008(r4)
0x0009b150 nop
0x0009b154 andi r9,r8,0xffff
0x0009b158 sll r9,r9,0x10
0x0009b15c sra r9,r9,0x10
0x0009b160 multu r9,r12
0x0009b164 mflo r9
0x0009b168 sra r9,r9,0x0c
0x0009b16c andi r9,r9,0xffff
0x0009b170 sra r10,r8,0x10
0x0009b174 multu r10,r13
0x0009b178 mflo r10
0x0009b17c sra r10,r10,0x0c
0x0009b180 sll r10,r10,0x10
0x0009b184 or r9,r9,r10
0x0009b188 sw r9,0x0008(r4)
0x0009b18c lw r8,0x000c(r4)
0x0009b190 nop
0x0009b194 andi r9,r8,0xffff
0x0009b198 sll r9,r9,0x10
0x0009b19c sra r9,r9,0x10
0x0009b1a0 multu r9,r11
0x0009b1a4 mflo r9
0x0009b1a8 sra r9,r9,0x0c
0x0009b1ac andi r9,r9,0xffff
0x0009b1b0 sra r10,r8,0x10
0x0009b1b4 multu r10,r12
0x0009b1b8 mflo r10
0x0009b1bc sra r10,r10,0x0c
0x0009b1c0 sll r10,r10,0x10
0x0009b1c4 or r9,r9,r10
0x0009b1c8 sw r9,0x000c(r4)
0x0009b1cc lw r8,0x0010(r4)
0x0009b1d0 nop
0x0009b1d4 andi r9,r8,0xffff
0x0009b1d8 sll r9,r9,0x10
0x0009b1dc sra r9,r9,0x10
0x0009b1e0 multu r9,r13
0x0009b1e4 mflo r9
0x0009b1e8 sra r9,r9,0x0c
0x0009b1ec sw r9,0x0010(r4)
0x0009b1f0 jr r31
0x0009b1f4 addu r2,r4,r0