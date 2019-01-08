int isAsciiEncoded(charPtr) {
  return load(charPtr) >> 7 == 0 ? 1 : 0
}

0x000f18a4 lb r2,0x0000(r4)
0x000f18a8 nop
0x000f18ac sra r2,r2,0x07
0x000f18b0 bne r2,r0,0x000f18c0
0x000f18b4 addu r2,r0,r0
0x000f18b8 beq r0,r0,0x000f18c0
0x000f18bc addiu r2,r0,0x0001
0x000f18c0 jr r31
0x000f18c4 nop