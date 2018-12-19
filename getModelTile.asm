/**
 * Returns two values representing a tile position of the given model.
 * The values get stored in the given addresess in r5 and r6, 
 * typically the stack but not necessarily.
 */
int, int getModelTile(int modelPtr) {
  posX = load(modelPtr)
  tileX = posX * 0.01 + 50

  if(posX < 0)
    tileX--

  posY = load(modelPtr + 8)
  tileY = posY * 0.01 + 50

  if(posY < 0)
    tileY--

  return tileX, tileY
}

0x000c0f28 lui r2,0x51eb
0x000c0f2c lw r3,0x0000(r4)
0x000c0f30 ori r7,r2,0x851f
0x000c0f34 mult r7,r3
0x000c0f38 mfhi r2
0x000c0f3c srl r3,r3,0x1f
0x000c0f40 sra r2,r2,0x05
0x000c0f44 addu r2,r2,r3
0x000c0f48 addi r2,r2,0x0032
0x000c0f4c sh r2,0x0000(r5)
0x000c0f50 lw r2,0x0008(r4)
0x000c0f54 nop
0x000c0f58 mult r7,r2
0x000c0f5c srl r3,r2,0x1f
0x000c0f60 mfhi r2
0x000c0f64 sra r2,r2,0x05
0x000c0f68 addu r3,r2,r3
0x000c0f6c addiu r2,r0,0x0032
0x000c0f70 sub r2,r2,r3
0x000c0f74 sh r2,0x0000(r6)
0x000c0f78 lw r2,0x0000(r4)
0x000c0f7c nop
0x000c0f80 bgez r2,0x000c0f98
0x000c0f84 nop
0x000c0f88 lh r2,0x0000(r5)
0x000c0f8c nop
0x000c0f90 addi r2,r2,-0x0001
0x000c0f94 sh r2,0x0000(r5)
0x000c0f98 lw r2,0x0008(r4)
0x000c0f9c nop
0x000c0fa0 blez r2,0x000c0fb8
0x000c0fa4 nop
0x000c0fa8 lh r2,0x0000(r6)
0x000c0fac nop
0x000c0fb0 addi r2,r2,-0x0001
0x000c0fb4 sh r2,0x0000(r6)
0x000c0fb8 jr r31
0x000c0fbc nop
