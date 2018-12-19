/**
 * Takes a rotation vector and transforms it into a rotation matrix to
 * which a pointer is returned.
 * All values in the matrix are fixed point numbers, where 4096 is 1.0.
 * The equivalent result would be the following matrix multiplication:
 * 
 * [ 1      0       0  ]   [  cos(y)  0  sin(y) ]   [ cos(z) -sin(z)  0 ]
 * [ 0  cos(x) -sin(x) ] * [      0   1      0  ] * [ sin(z)  cos(z)  0 ]
 * [ 0  sin(x)  cos(x) ]   [ -sin(y)  0  cos(y) ]   [     0       0   1 ]
 *
 * All abs() calls are not actual syscalls in the game but equivalent local code.
 */
int rotVecToRotMatrix(rotVectorPtr, destPtr) {
  // get cos and sin for each axis
  rotX = load(rotVectorPtr)
  lookupResult = load(0x117960 + abs(rotX) * 4) // sin/cos lookup table
  sinX = rotX < 0 ? -lookupResult : lookupResult // cast to short
  cosX = lookupResult >> 0x10
  
  rotY = load(rotVectorPtr + 0x02)
  lookupResult = load(0x117960 + abs(rotY) * 4)  // sin/cos lookup table
  sinY = rotY < 0 ? -lookupResult : lookupResult // cast to short
  cosY = lookupResult >> 0x10
  
  rotZ = load(rotVectorPtr + 0x04)
  lookupResult = load(0x117960 + abs(rotZ) * 4)  // sin/cos lookup table
  sinZ = rotZ < 0 ? -lookupResult : lookupResult // cast to short
  cosZ = lookupResult >> 0x10
  
  // matrix calculations
  store(destPtr, cosZ * cosY / 4096)
  store(destPtr + 0x02, -(sinZ * cosY) / 4096)
  store(destPtr + 0x04, sinY)
  
  val1 = (cosZ * sinY * sinX) / 4096 / 4096
  val2 = (sinZ * cosX) / 4096
  store(destPtr + 0x06, val2 + val1)
  
  val1 = (sinZ * -sinY * sinX) / 4096 / 4096
  val2 = (cosZ * cosX) / 4096
  store(destPtr + 0x08, val2 + val1)
  store(destPtr + 0x0A, -(cosY * -sinX) / 4096)
  
  val1 = (cosZ * -sinY * cosX) / 4096 / 4096
  val2 = (sinZ * sinX) / 4096
  store(destPtr + 0x0C, val2 + val1)
  
  val1 = (sinZ * sinY * cosX) / 4096 / 4096
  val2 = (cosZ * sinX) / 4096
  store(destPtr + 0x0E, val2 + val1)
  store(destPtr + 0x10, cosY * cosX >> 0xC)
  
  return destPtr
}

0x0009b804 lh r15,0x0000(r4)
0x0009b808 addu r2,r5,r0
0x0009b80c bgez r15,0x0009b848
0x0009b810 andi r25,r15,0x0fff
0x0009b814 subu r15,r0,r15
0x0009b818 bgez r15,0x0009b820
0x0009b81c andi r15,r15,0x0fff
0x0009b820 sll r24,r15,0x02
0x0009b824 lui r25,0x8011
0x0009b828 addu r25,r25,r24
0x0009b82c lw r25,0x7960(r25)
0x0009b830 nop
0x0009b834 sll r24,r25,0x10
0x0009b838 sra r24,r24,0x10
0x0009b83c subu r11,r0,r24
0x0009b840 j 0x0009b868
0x0009b844 sra r8,r25,0x10
0x0009b848 sll r24,r25,0x02
0x0009b84c lui r25,0x8011
0x0009b850 addu r25,r25,r24
0x0009b854 lw r25,0x7960(r25)
0x0009b858 nop
0x0009b85c sll r24,r25,0x10
0x0009b860 sra r11,r24,0x10
0x0009b864 sra r8,r25,0x10
0x0009b868 lh r15,0x0002(r4)
0x0009b86c nop
0x0009b870 bgez r15,0x0009b8ac
0x0009b874 andi r25,r15,0x0fff
0x0009b878 subu r15,r0,r15
0x0009b87c bgez r15,0x0009b884
0x0009b880 andi r15,r15,0x0fff
0x0009b884 sll r24,r15,0x02
0x0009b888 lui r25,0x8011
0x0009b88c addu r25,r25,r24
0x0009b890 lw r25,0x7960(r25)
0x0009b894 nop
0x0009b898 sll r12,r25,0x10
0x0009b89c sra r12,r12,0x10
0x0009b8a0 subu r14,r0,r12
0x0009b8a4 j 0x0009b8d0
0x0009b8a8 sra r9,r25,0x10
0x0009b8ac sll r24,r25,0x02
0x0009b8b0 lui r25,0x8011
0x0009b8b4 addu r25,r25,r24
0x0009b8b8 lw r25,0x7960(r25)
0x0009b8bc nop
0x0009b8c0 sll r14,r25,0x10
0x0009b8c4 sra r14,r14,0x10
0x0009b8c8 subu r12,r0,r14
0x0009b8cc sra r9,r25,0x10
0x0009b8d0 multu r9,r11
0x0009b8d4 lh r15,0x0004(r4)
0x0009b8d8 sh r14,0x0004(r5)
0x0009b8dc mflo r24
0x0009b8e0 subu r25,r0,r24
0x0009b8e4 sra r14,r25,0x0c
0x0009b8e8 multu r9,r8
0x0009b8ec sh r14,0x000a(r5)
0x0009b8f0 bgez r15,0x0009b938
0x0009b8f4 andi r25,r15,0x0fff
0x0009b8f8 mflo r24
0x0009b8fc sra r14,r24,0x0c
0x0009b900 sh r14,0x0010(r5)
0x0009b904 subu r15,r0,r15
0x0009b908 bgez r15,0x0009b910
0x0009b90c andi r15,r15,0x0fff
0x0009b910 sll r24,r15,0x02
0x0009b914 lui r25,0x8011
0x0009b918 addu r25,r25,r24
0x0009b91c lw r25,0x7960(r25)
0x0009b920 nop
0x0009b924 sll r24,r25,0x10
0x0009b928 sra r24,r24,0x10
0x0009b92c subu r13,r0,r24
0x0009b930 j 0x0009b964
0x0009b934 sra r10,r25,0x10
0x0009b938 mflo r15
0x0009b93c sra r14,r15,0x0c
0x0009b940 sh r14,0x0010(r5)
0x0009b944 sll r24,r25,0x02
0x0009b948 lui r25,0x8011
0x0009b94c addu r25,r25,r24
0x0009b950 lw r25,0x7960(r25)
0x0009b954 nop
0x0009b958 sll r24,r25,0x10
0x0009b95c sra r13,r24,0x10
0x0009b960 sra r10,r25,0x10
0x0009b964 multu r10,r9
0x0009b968 nop
0x0009b96c nop
0x0009b970 mflo r15
0x0009b974 sra r14,r15,0x0c
0x0009b978 sh r14,0x0000(r5)
0x0009b97c multu r13,r9
0x0009b980 nop
0x0009b984 nop
0x0009b988 mflo r15
0x0009b98c subu r14,r0,r15
0x0009b990 sra r15,r14,0x0c
0x0009b994 multu r10,r12
0x0009b998 sh r15,0x0002(r5)
0x0009b99c nop
0x0009b9a0 mflo r15
0x0009b9a4 sra r24,r15,0x0c
0x0009b9a8 nop
0x0009b9ac multu r24,r11
0x0009b9b0 nop
0x0009b9b4 nop
0x0009b9b8 mflo r15
0x0009b9bc sra r14,r15,0x0c
0x0009b9c0 nop
0x0009b9c4 multu r13,r8
0x0009b9c8 nop
0x0009b9cc nop
0x0009b9d0 mflo r15
0x0009b9d4 sra r25,r15,0x0c
0x0009b9d8 subu r15,r25,r14
0x0009b9dc multu r24,r8
0x0009b9e0 sh r15,0x0006(r5)
0x0009b9e4 nop
0x0009b9e8 mflo r14
0x0009b9ec sra r15,r14,0x0c
0x0009b9f0 nop
0x0009b9f4 multu r13,r11
0x0009b9f8 nop
0x0009b9fc nop
0x0009ba00 mflo r14
0x0009ba04 sra r25,r14,0x0c
0x0009ba08 addu r14,r25,r15
0x0009ba0c multu r13,r12
0x0009ba10 sh r14,0x000c(r5)
0x0009ba14 nop
0x0009ba18 mflo r15
0x0009ba1c sra r24,r15,0x0c
0x0009ba20 nop
0x0009ba24 multu r24,r11
0x0009ba28 nop
0x0009ba2c nop
0x0009ba30 mflo r15
0x0009ba34 sra r14,r15,0x0c
0x0009ba38 nop
0x0009ba3c multu r10,r8
0x0009ba40 nop
0x0009ba44 nop
0x0009ba48 mflo r15
0x0009ba4c sra r25,r15,0x0c
0x0009ba50 addu r15,r25,r14
0x0009ba54 multu r24,r8
0x0009ba58 sh r15,0x0008(r5)
0x0009ba5c nop
0x0009ba60 mflo r14
0x0009ba64 sra r15,r14,0x0c
0x0009ba68 nop
0x0009ba6c multu r10,r11
0x0009ba70 nop
0x0009ba74 nop
0x0009ba78 mflo r14
0x0009ba7c sra r25,r14,0x0c
0x0009ba80 subu r14,r25,r15
0x0009ba84 sh r14,0x000e(r5)
0x0009ba88 jr r31
0x0009ba8c nop
