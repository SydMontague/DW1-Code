0x000D892C(posPtr1, posPtr2) {
  setGTERotationMatrix(0x136F84)
  setGTETranslationVector(0x136F84)
  
  store(sp + 0x20, load(posPtr1 + 0x00)) // xPos1
  store(sp + 0x22, load(posPtr1 + 0x04)) // yPos1
  store(sp + 0x24, load(posPtr1 + 0x08)) // zPos1
  store(sp + 0x28, load(posPtr2 + 0x00)) // xPos2
  store(sp + 0x2A, load(posPtr2 + 0x04)) // yPos2
  store(sp + 0x2C, load(posPtr2 + 0x08)) // zPos2
  
  // perspective transformation, done on GTE, using gte_registers
  ir1 = (gte_trx * 0x1000 + gte_rt11 * xPos1 + gte_rt12 * yPos1 + gte_rt13 * zPos1) >> 12
  ir2 = (gte_try * 0x1000 + gte_rt21 * xPos1 + gte_rt22 * yPos1 + gte_rt23 * zPos1) >> 12
  ir3 = (gte_trz * 0x1000 + gte_rt31 * xPos1 + gte_rt32 * yPos1 + gte_rt33 * zPos1) >> 12
  
  sx2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir1 + gte_cr24) / 0x10000
  sy2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir2 + gte_cr25) / 0x10000
  
  screenPosNew1 = { sy2, sx2 }
  
  // perspective transformation, done on GTE, using gte_registers
  ir1 = (gte_trx * 0x1000 + gte_rt11 * xPos2 + gte_rt12 * yPos2 + gte_rt13 * zPos2) >> 12
  ir2 = (gte_try * 0x1000 + gte_rt21 * xPos2 + gte_rt22 * yPos2 + gte_rt23 * zPos2) >> 12
  ir3 = (gte_trz * 0x1000 + gte_rt31 * xPos2 + gte_rt32 * yPos2 + gte_rt33 * zPos2) >> 12
  
  sx2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir1 + gte_cr24) / 0x10000
  sy2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir2 + gte_cr25) / 0x10000
  
  screenPosNew2 = { sy2, sx2 }
  
  store(0x150C38, load(0x150C38) + screenPosNew2[0] - screenPosNew1[0])
  store(0x150C3A, load(0x150C3A) + screenPosNew2[1] - screenPosNew1[1])
  
  someFlag = 0
  
  posX1 = load(posPtr1)
  posX2 = load(posPtr2)
  posZ1 = load(posPtr1 + 0x08)
  posZ2 = load(posPtr2 + 0x08)
  
  if(posX1 < posX2)
    someFlag = someFlag | 0x2000
  else if(posX2 < posX1)
    someFlag = someFlag | 0x8000
  
  if(posZ1 < posZ2)
    someFlag = someFlag | 0x1000
  else if(posZ2 < posZ1)
    someFlag = someFlag | 0x4000
  
  0x000D763C(screenPosNew1, screenPosNew2)
  0x000D78BC(someFlag, 0)
}

0x000d892c addiu r29,r29,0xffc0
0x000d8930 sw r31,0x001c(r29)
0x000d8934 sw r18,0x0018(r29)
0x000d8938 sw r17,0x0014(r29)
0x000d893c addu r17,r4,r0
0x000d8940 lui r4,0x8013
0x000d8944 sw r16,0x0010(r29)
0x000d8948 addu r18,r5,r0
0x000d894c jal 0x0009b200
0x000d8950 addiu r4,r4,0x6f84
0x000d8954 lui r4,0x8013
0x000d8958 jal 0x0009b290
0x000d895c addiu r4,r4,0x6f84
0x000d8960 lw r2,0x0000(r17)
0x000d8964 addiu r4,r29,0x0020
0x000d8968 sh r2,0x0020(r29)
0x000d896c lw r2,0x0004(r17)
0x000d8970 nop
0x000d8974 sh r2,0x0022(r29)
0x000d8978 lw r2,0x0008(r17)
0x000d897c nop
0x000d8980 sh r2,0x0024(r29)
0x000d8984 lw r2,0x0000(r18)
0x000d8988 nop
0x000d898c sh r2,0x0028(r29)
0x000d8990 lw r2,0x0004(r18)
0x000d8994 nop
0x000d8998 sh r2,0x002a(r29)
0x000d899c lw r2,0x0008(r18)
0x000d89a0 nop
0x000d89a4 sh r2,0x002c(r29)
0x000d89a8 lwc2 gtedr00_vxy0,0x0000(r4)
0x000d89ac lwc2 gtedr01_vz0,0x0004(r4)
0x000d89b0 nop
0x000d89b4 nop
0x000d89b8 rtps
0x000d89bc addiu r4,r29,0x0030
0x000d89c0 swc2 gtedr14_sxy2,0x0000(r4)
0x000d89c4 addiu r4,r29,0x0028
0x000d89c8 lwc2 gtedr00_vxy0,0x0000(r4)
0x000d89cc lwc2 gtedr01_vz0,0x0004(r4)
0x000d89d0 nop
0x000d89d4 nop
0x000d89d8 rtps
0x000d89dc addiu r4,r29,0x0038
0x000d89e0 swc2 gtedr14_sxy2,0x0000(r4)
0x000d89e4 lh r3,0x0038(r29)
0x000d89e8 lh r2,0x0030(r29)
0x000d89ec lui r1,0x8015
0x000d89f0 sub r3,r3,r2
0x000d89f4 lh r2,0x0c38(r1)
0x000d89f8 sll r3,r3,0x10
0x000d89fc sra r3,r3,0x10
0x000d8a00 add r2,r2,r3
0x000d8a04 lui r1,0x8015
0x000d8a08 sh r2,0x0c38(r1)
0x000d8a0c lh r3,0x003a(r29)
0x000d8a10 lh r2,0x0032(r29)
0x000d8a14 lui r1,0x8015
0x000d8a18 sub r3,r3,r2
0x000d8a1c lh r2,0x0c3a(r1)
0x000d8a20 sll r3,r3,0x10
0x000d8a24 sra r3,r3,0x10
0x000d8a28 add r2,r2,r3
0x000d8a2c lui r1,0x8015
0x000d8a30 sh r2,0x0c3a(r1)
0x000d8a34 lw r3,0x0000(r17)
0x000d8a38 lw r2,0x0000(r18)
0x000d8a3c addu r16,r0,r0
0x000d8a40 addu r5,r3,r0
0x000d8a44 slt r1,r3,r2
0x000d8a48 beq r1,r0,0x000d8a58
0x000d8a4c addu r4,r2,r0
0x000d8a50 beq r0,r0,0x000d8a68
0x000d8a54 ori r16,r16,0x2000
0x000d8a58 slt r1,r4,r5
0x000d8a5c beq r1,r0,0x000d8a68
0x000d8a60 nop
0x000d8a64 ori r16,r16,0x8000
0x000d8a68 lw r3,0x0008(r17)
0x000d8a6c lw r2,0x0008(r18)
0x000d8a70 addu r5,r3,r0
0x000d8a74 slt r1,r3,r2
0x000d8a78 beq r1,r0,0x000d8a88
0x000d8a7c addu r4,r2,r0
0x000d8a80 beq r0,r0,0x000d8a98
0x000d8a84 ori r16,r16,0x1000
0x000d8a88 slt r1,r4,r5
0x000d8a8c beq r1,r0,0x000d8a98
0x000d8a90 nop
0x000d8a94 ori r16,r16,0x4000
0x000d8a98 addiu r4,r29,0x0030
0x000d8a9c jal 0x000d763c
0x000d8aa0 addiu r5,r29,0x0038
0x000d8aa4 addu r4,r16,r0
0x000d8aa8 jal 0x000d78bc
0x000d8aac addu r5,r0,r0
0x000d8ab0 lw r31,0x001c(r29)
0x000d8ab4 lw r18,0x0018(r29)
0x000d8ab8 lw r17,0x0014(r29)
0x000d8abc lw r16,0x0010(r29)
0x000d8ac0 jr r31
0x000d8ac4 addiu r29,r29,0x0040