void setGTERotationMatrix(matrixPtr) {
  gte_cr00 = load(matrixPtr + 0x00)
  gte_cr01 = load(matrixPtr + 0x04)
  gte_cr02 = load(matrixPtr + 0x08)
  gte_cr03 = load(matrixPtr + 0x0C)
  gte_cr04 = load(matrixPtr + 0x10)
}

0x0009b200 lw r8,0x0000(r4)
0x0009b204 lw r9,0x0004(r4)
0x0009b208 lw r10,0x0008(r4)
0x0009b20c lw r11,0x000c(r4)
0x0009b210 lw r12,0x0010(r4)
0x0009b214 ctc2 r8,gtecr00_r11r12
0x0009b218 ctc2 r9,gtecr01_r13r21
0x0009b21c ctc2 r10,gtecr02_r22r23
0x0009b220 ctc2 r11,gtecr03_r31r32
0x0009b224 ctc2 r12,gtecr04_r33
0x0009b228 jr r31
0x0009b22c nop