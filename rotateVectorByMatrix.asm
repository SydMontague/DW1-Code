/*
 * Rotate a given vector with a given rotation matrix and store the result into
 * a given pointer. This is using the Geometry Transform Engine (GTE).
 */
int rotateVectorByMatrix(rotMatrix, vector, resultPtr) {
  // upload rotation vector to GTE
  
  // upper 16 bit
  xTop = vector[0] / 0x8000
  yTop = vector[1] / 0x8000
  zTop = vector[2] / 0x8000
  
  // lower 16 bit
  xLow = vector[0] % 0x8000
  yLow = vector[1] % 0x8000
  zLow = vector[2] % 0x8000
  
  // rotate upper 16 bits, done on GTE
  xTop = (rotMatrix[0][0] * xTop + rotMatrix[0][1] * yTop + rotMatrix[0][2] * zTop)
  yTop = (rotMatrix[1][0] * xTop + rotMatrix[1][1] * yTop + rotMatrix[1][2] * zTop)
  zTop = (rotMatrix[2][0] * xTop + rotMatrix[2][1] * yTop + rotMatrix[2][2] * zTop)
  
  // rotate lower 16 bits, done on GTE
  xLow = (rotMatrix[0][0] * xLow + rotMatrix[0][1] * yLow + rotMatrix[0][2] * zLow) >> 12
  yLow = (rotMatrix[1][0] * xLow + rotMatrix[1][1] * yLow + rotMatrix[1][2] * zLow) >> 12
  zLow = (rotMatrix[2][0] * xLow + rotMatrix[2][1] * yLow + rotMatrix[2][2] * zLow) >> 12
  
  // assemble the result
  resultPtr[0] = xTop * 8 + xLow
  resultPtr[1] = yTop * 8 + yLow
  resultPtr[2] = zTop * 8 + zLow
  
  return resultPtr
}

0x0009ab10 lw r8,0x0000(r4)
0x0009ab14 lw r9,0x0004(r4)
0x0009ab18 lw r10,0x0008(r4)
0x0009ab1c lw r11,0x000c(r4)
0x0009ab20 lw r12,0x0010(r4)
0x0009ab24 ctc2 r8,gtecr00_r11r12
0x0009ab28 ctc2 r9,gtecr01_r13r21
0x0009ab2c ctc2 r10,gtecr02_r22r23
0x0009ab30 ctc2 r11,gtecr03_r31r32
0x0009ab34 ctc2 r12,gtecr04_r33
0x0009ab38 lw r8,0x0000(r5)
0x0009ab3c lw r9,0x0004(r5)
0x0009ab40 lw r10,0x0008(r5)
0x0009ab44 bgez r8,0x0009ab64
0x0009ab48 nop
0x0009ab4c subu r8,r0,r8
0x0009ab50 sra r11,r8,0x0f
0x0009ab54 subu r11,r0,r11
0x0009ab58 andi r8,r8,0x7fff
0x0009ab5c beq r0,r0,0x0009ab6c
0x0009ab60 subu r8,r0,r8
0x0009ab64 sra r11,r8,0x0f
0x0009ab68 andi r8,r8,0x7fff
0x0009ab6c bgez r9,0x0009ab8c
0x0009ab70 nop
0x0009ab74 subu r9,r0,r9
0x0009ab78 sra r12,r9,0x0f
0x0009ab7c subu r12,r0,r12
0x0009ab80 andi r9,r9,0x7fff
0x0009ab84 beq r0,r0,0x0009ab94
0x0009ab88 subu r9,r0,r9
0x0009ab8c sra r12,r9,0x0f
0x0009ab90 andi r9,r9,0x7fff
0x0009ab94 bgez r10,0x0009abb4
0x0009ab98 nop
0x0009ab9c subu r10,r0,r10
0x0009aba0 sra r13,r10,0x0f
0x0009aba4 subu r13,r0,r13
0x0009aba8 andi r10,r10,0x7fff
0x0009abac beq r0,r0,0x0009abbc
0x0009abb0 subu r10,r0,r10
0x0009abb4 sra r13,r10,0x0f
0x0009abb8 andi r10,r10,0x7fff
0x0009abbc mtc2 r11,gtedr09_ir1
0x0009abc0 mtc2 r12,gtedr10_ir2
0x0009abc4 mtc2 r13,gtedr11_ir3
0x0009abc8 nop
0x0009abcc mvmva
0x0009abd0 mfc2 r11,gtedr25_mac1
0x0009abd4 mfc2 r12,gtedr26_mac2
0x0009abd8 mfc2 r13,gtedr27_mac3
0x0009abdc mtc2 r8,gtedr09_ir1
0x0009abe0 mtc2 r9,gtedr10_ir2
0x0009abe4 mtc2 r10,gtedr11_ir3
0x0009abe8 nop
0x0009abec mvmva
0x0009abf0 bgez r11,0x0009ac08
0x0009abf4 nop
0x0009abf8 subu r11,r0,r11
0x0009abfc sll r11,r11,0x03
0x0009ac00 beq r0,r0,0x0009ac0c
0x0009ac04 subu r11,r0,r11
0x0009ac08 sll r11,r11,0x03
0x0009ac0c bgez r12,0x0009ac24
0x0009ac10 nop
0x0009ac14 subu r12,r0,r12
0x0009ac18 sll r12,r12,0x03
0x0009ac1c beq r0,r0,0x0009ac28
0x0009ac20 subu r12,r0,r12
0x0009ac24 sll r12,r12,0x03
0x0009ac28 bgez r13,0x0009ac40
0x0009ac2c nop
0x0009ac30 subu r13,r0,r13
0x0009ac34 sll r13,r13,0x03
0x0009ac38 beq r0,r0,0x0009ac44
0x0009ac3c subu r13,r0,r13
0x0009ac40 sll r13,r13,0x03
0x0009ac44 mfc2 r8,gtedr25_mac1
0x0009ac48 mfc2 r9,gtedr26_mac2
0x0009ac4c mfc2 r10,gtedr27_mac3
0x0009ac50 addu r8,r8,r11
0x0009ac54 addu r9,r9,r12
0x0009ac58 addu r10,r10,r13
0x0009ac5c sw r8,0x0000(r6)
0x0009ac60 sw r9,0x0004(r6)
0x0009ac64 sw r10,0x0008(r6)
0x0009ac68 jr r31
0x0009ac6c addu r2,r6,r0