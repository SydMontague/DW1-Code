int entityIsOffScreen(entityPtr, width, height) {
  entityType = load(entityPtr)
  positionPtr = load(entityPtr + 0x04) + 0x78
  radius = load(0x12CECC + load(entityPtr) * 52)
  
  if(entityType == 152 && load(entityPtr + 0x2E) == 24) // is NPC Kunemon in anim 24
    return 0
  
  setTransformationMatrix(0x136F84)
  
  for(r18 = 0; r18 < 2; r18++) {
    for(r16 = 0; r16 < 4; r16++) {
      xPos = load(positionPtr + 0x00) + load(0x134398 + r16 * 2) * radius
      yPos = load(positionPtr + 0x04) + r18 * -radius
      zPos = load(positionPtr + 0x08) + load(0x134399 + r16 * 2) * radius
      
      // perspective transformation, done on GTE, using gte_registers
      ir1 = (gte_trx * 0x1000 + gte_rt11 * xPos + gte_rt12 * yPos + gte_rt13 * zPos) >> 12
      ir2 = (gte_try * 0x1000 + gte_rt21 * xPos + gte_rt22 * yPos + gte_rt23 * zPos) >> 12
      ir3 = (gte_trz * 0x1000 + gte_rt31 * xPos + gte_rt32 * yPos + gte_rt33 * zPos) >> 12
      
      sx2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir1 + gte_cr24) / 0x10000
      sy2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir2 + gte_cr25) / 0x10000
      
      screenPos = { sy2, sx2 }
      
      if(isOffScreen(screenPos, width, height) == 0)
        return 0
    }
  }
  
  return 1
}

0x000d5430 addiu r29,r29,0xffb8
0x000d5434 sw r31,0x0034(r29)
0x000d5438 sw r30,0x0030(r29)
0x000d543c sw r23,0x002c(r29)
0x000d5440 sw r22,0x0028(r29)
0x000d5444 sw r21,0x0024(r29)
0x000d5448 sw r20,0x0020(r29)
0x000d544c sw r19,0x001c(r29)
0x000d5450 sw r18,0x0018(r29)
0x000d5454 sw r17,0x0014(r29)
0x000d5458 sw r16,0x0010(r29)
0x000d545c addu r23,r4,r0
0x000d5460 lw r2,0x0000(r23)
0x000d5464 addu r19,r5,r0
0x000d5468 addiu r1,r0,0x0098
0x000d546c bne r2,r1,0x000d548c
0x000d5470 addu r20,r6,r0
0x000d5474 lbu r2,0x002e(r23)
0x000d5478 addiu r1,r0,0x001c
0x000d547c bne r2,r1,0x000d548c
0x000d5480 nop
0x000d5484 beq r0,r0,0x000d55d8
0x000d5488 addu r2,r0,r0
0x000d548c lui r4,0x8013
0x000d5490 jal 0x00097dd8
0x000d5494 addiu r4,r4,0x6f84
0x000d5498 lw r2,0x0004(r23)
0x000d549c lw r3,0x0000(r23)
0x000d54a0 addiu r21,r2,0x0078
0x000d54a4 sll r2,r3,0x01
0x000d54a8 add r2,r2,r3
0x000d54ac sll r2,r2,0x02
0x000d54b0 add r2,r2,r3
0x000d54b4 sll r3,r2,0x02
0x000d54b8 lui r2,0x8013
0x000d54bc addiu r2,r2,0xcecc
0x000d54c0 addu r2,r2,r3
0x000d54c4 lh r30,0x0000(r2)
0x000d54c8 beq r0,r0,0x000d55c8
0x000d54cc addu r18,r0,r0
0x000d54d0 addu r17,r0,r0
0x000d54d4 beq r0,r0,0x000d55b8
0x000d54d8 addu r22,r30,r0
0x000d54dc addiu r2,r28,0x886c
0x000d54e0 addu r2,r2,r17
0x000d54e4 lb r3,0x0000(r2)
0x000d54e8 addiu r4,r29,0x0040
0x000d54ec mult r22,r3
0x000d54f0 lw r2,0x0000(r21)
0x000d54f4 mflo r3
0x000d54f8 add r2,r2,r3
0x000d54fc sh r2,0x0040(r29)
0x000d5500 lw r3,0x0000(r23)
0x000d5504 nop
0x000d5508 sll r2,r3,0x01
0x000d550c add r2,r2,r3
0x000d5510 sll r2,r2,0x02
0x000d5514 add r2,r2,r3
0x000d5518 sll r3,r2,0x02
0x000d551c lui r2,0x8013
0x000d5520 addiu r2,r2,0xcece
0x000d5524 addu r2,r2,r3
0x000d5528 lh r2,0x0000(r2)
0x000d552c nop
0x000d5530 sub r3,r0,r2
0x000d5534 mult r18,r3
0x000d5538 lw r2,0x0004(r21)
0x000d553c mflo r3
0x000d5540 add r2,r2,r3
0x000d5544 sh r2,0x0042(r29)
0x000d5548 addiu r2,r28,0x886d
0x000d554c addu r2,r2,r17
0x000d5550 lb r3,0x0000(r2)
0x000d5554 nop
0x000d5558 mult r22,r3
0x000d555c lw r2,0x0008(r21)
0x000d5560 mflo r3
0x000d5564 add r2,r2,r3
0x000d5568 sh r2,0x0044(r29)
0x000d556c lwc2 gtedr00_vxy0,0x0000(r4)
0x000d5570 lwc2 gtedr01_vz0,0x0004(r4)
0x000d5574 nop
0x000d5578 nop
0x000d557c rtps
0x000d5580 addiu r2,r29,0x003c
0x000d5584 addu r4,r2,r0
0x000d5588 swc2 gtedr14_sxy2,0x0000(r4)
0x000d558c sll r5,r19,0x10
0x000d5590 sll r6,r20,0x10
0x000d5594 sra r5,r5,0x10
0x000d5598 jal 0x000d5608
0x000d559c sra r6,r6,0x10
0x000d55a0 bne r2,r0,0x000d55b0
0x000d55a4 nop
0x000d55a8 beq r0,r0,0x000d55d8
0x000d55ac addu r2,r0,r0
0x000d55b0 addi r16,r16,0x0001
0x000d55b4 addi r17,r17,0x0002
0x000d55b8 slti r1,r16,0x0004
0x000d55bc bne r1,r0,0x000d54dc
0x000d55c0 nop
0x000d55c4 addi r18,r18,0x0001
0x000d55c8 slti r1,r18,0x0002
0x000d55cc bne r1,r0,0x000d54d0
0x000d55d0 addu r16,r0,r0
0x000d55d4 addiu r2,r0,0x0001
0x000d55d8 lw r31,0x0034(r29)
0x000d55dc lw r30,0x0030(r29)
0x000d55e0 lw r23,0x002c(r29)
0x000d55e4 lw r22,0x0028(r29)
0x000d55e8 lw r21,0x0024(r29)
0x000d55ec lw r20,0x0020(r29)
0x000d55f0 lw r19,0x001c(r29)
0x000d55f4 lw r18,0x0018(r29)
0x000d55f8 lw r17,0x0014(r29)
0x000d55fc lw r16,0x0010(r29)
0x000d5600 jr r31
0x000d5604 addiu r29,r29,0x0048