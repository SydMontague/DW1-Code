short, short getModelObjectScreenPos(entitiyPtr, val) {
  setTransformationMatrix(0x136F84)
  
  posPtr = load(entityPtr + 0x04) + val * 0x88 + 0x34
  
  xPos = load(posPtr + 0x14)
  yPos = load(posPtr + 0x18)
  zPos = load(posPtr + 0x1C)
  
  // perspective transformation, done on GTE, using gte_registers
  ir1 = (gte_trx * 0x1000 + gte_rt11 * xPos + gte_rt12 * yPos + gte_rt13 * zPos) >> 12
  ir2 = (gte_try * 0x1000 + gte_rt21 * xPos + gte_rt22 * yPos + gte_rt23 * zPos) >> 12
  ir3 = (gte_trz * 0x1000 + gte_rt31 * xPos + gte_rt32 * yPos + gte_rt33 * zPos) >> 12
  
  sx2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir1 + gte_cr24) / 0x10000
  sy2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir2 + gte_cr25) / 0x10000
  
  sx2 = sx2 - (160 - load(0x134EC0))
  sy2 = sy2 - (120 - load(0x134EC4))
  
  return sx2, sy2
}

0x000e52d8 addiu r29,r29,0xffd8
0x000e52dc sw r31,0x001c(r29)
0x000e52e0 sw r18,0x0018(r29)
0x000e52e4 sw r17,0x0014(r29)
0x000e52e8 addu r18,r4,r0
0x000e52ec sw r16,0x0010(r29)
0x000e52f0 lui r4,0x8013
0x000e52f4 addu r17,r5,r0
0x000e52f8 addu r16,r6,r0
0x000e52fc jal 0x00097dd8
0x000e5300 addiu r4,r4,0x6f84
0x000e5304 sll r2,r17,0x04
0x000e5308 add r3,r2,r17
0x000e530c lw r2,0x0004(r18)
0x000e5310 sll r3,r3,0x03
0x000e5314 addu r2,r2,r3
0x000e5318 addiu r3,r2,0x0034
0x000e531c lw r2,0x0014(r3)
0x000e5320 addiu r4,r29,0x0020
0x000e5324 sh r2,0x0020(r29)
0x000e5328 lw r2,0x0018(r3)
0x000e532c nop
0x000e5330 sh r2,0x0022(r29)
0x000e5334 lw r2,0x001c(r3)
0x000e5338 nop
0x000e533c sh r2,0x0024(r29)
0x000e5340 lwc2 gtedr00_vxy0,0x0000(r4)
0x000e5344 lwc2 gtedr01_vz0,0x0004(r4)
0x000e5348 nop
0x000e534c nop
0x000e5350 rtps
0x000e5354 addu r4,r16,r0
0x000e5358 swc2 gtedr14_sxy2,0x0000(r4)
0x000e535c lw r2,-0x6c6c(r28)
0x000e5360 addiu r3,r0,0x00a0
0x000e5364 sub r3,r3,r2
0x000e5368 sll r3,r3,0x10
0x000e536c lh r2,0x0000(r16)
0x000e5370 sra r3,r3,0x10
0x000e5374 sub r2,r2,r3
0x000e5378 sh r2,0x0000(r16)
0x000e537c lw r2,-0x6c68(r28)
0x000e5380 addiu r3,r0,0x0078
0x000e5384 sub r3,r3,r2
0x000e5388 sll r3,r3,0x10
0x000e538c lh r2,0x0002(r16)
0x000e5390 sra r3,r3,0x10
0x000e5394 sub r2,r2,r3
0x000e5398 sh r2,0x0002(r16)
0x000e539c lw r31,0x001c(r29)
0x000e53a0 lw r18,0x0018(r29)
0x000e53a4 lw r17,0x0014(r29)
0x000e53a8 lw r16,0x0010(r29)
0x000e53ac jr r31
0x000e53b0 addiu r29,r29,0x0028