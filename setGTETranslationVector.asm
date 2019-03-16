setGTETranslationVector(matrixPtr) {
  gte_cr05 = load(matrixPtr + 0x14)
  gte_cr06 = load(matrixPtr + 0x18)
  gte_cr07 = load(matrixPtr + 0x1C)
}

0x0009b290 lw r8,0x0014(r4)
0x0009b294 lw r9,0x0018(r4)
0x0009b298 lw r10,0x001c(r4)
0x0009b29c ctc2 r8,gtecr05_trx
0x0009b2a0 ctc2 r9,gtecr06_try
0x0009b2a4 ctc2 r10,gtecr07_trz
0x0009b2a8 jr r31
0x0009b2ac nop