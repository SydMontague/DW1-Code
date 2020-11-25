int getOriginalType(digimonType) {
  if(digimonType < 0 || digimonType >= 0xB1)
    return -1
  
  originalType = load(0x12A84C + r4 * 2)
  
  return originalType >= 0 ? originalType : digimonType
}

0x000d9a3c bltz r4,0x000d9a50
0x000d9a40 nop
0x000d9a44 slti r1,r4,0x00b1
0x000d9a48 bne r1,r0,0x000d9a58
0x000d9a4c nop
0x000d9a50 beq r0,r0,0x000d9a80
0x000d9a54 addiu r2,r0,0xffff
0x000d9a58 lui r2,0x8013
0x000d9a5c sll r3,r4,0x01
0x000d9a60 addiu r2,r2,0xa84c
0x000d9a64 addu r2,r2,r3
0x000d9a68 lh r2,0x0000(r2)
0x000d9a6c nop
0x000d9a70 bgez r2,0x000d9a80
0x000d9a74 nop
0x000d9a78 beq r0,r0,0x000d9a80
0x000d9a7c addu r2,r4,r0
0x000d9a80 jr r31
0x000d9a84 nop