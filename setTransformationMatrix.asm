void setTransformationMatrix(matrixPtr) {
  setGTERotationMatrix(matrixPtr)
  setGTETranslationVector(matrixPtr)
}

0x00097dd8 addiu r29,r29,0xffe8
0x00097ddc sw r16,0x0010(r29)
0x00097de0 sw r31,0x0014(r29)
0x00097de4 jal 0x0009b200
0x00097de8 addu r16,r4,r0
0x00097dec jal 0x0009b290
0x00097df0 addu r4,r16,r0
0x00097df4 lw r31,0x0014(r29)
0x00097df8 lw r16,0x0010(r29)
0x00097dfc jr r31
0x00097e00 addiu r29,r29,0x0018