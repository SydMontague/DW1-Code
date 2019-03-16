/**
 * gte_tr -> translation vector
 * gte_rt -> rotation matrix
 * gte_cr24 -> screen offset X
 * gte_cr25 -> screen offset Y
 * gte_cr26 -> projection plane distance (in map data)
 */
int entityCheckCombatArea(entityPtr, locationPtr, width, height) {
  if(load(0x134F0A) == 4)
    return 0
  
  setTransformationMatrix(0x136F84)
  
  entityPosition = load(entityPtr + 0x04)
  digimonType = load(entityPtr)
  radius = load(0x12CECC + digimonType * 52)
  
  for(r19 = 0; r19 < 2; r19++)
    for(r17 = 0; r17 < 4; r17++) {
      // calculate current screen position
      xPos = load(entityPosition + 0x78) + load(0x134398 + r19 * 2) * radius
      yPos = load(entityPosition + 0x7C) + r19 * -200
      zPos = load(entityPosition + 0x80) + load(0x134399 + r19 * 2) * radius
      
      // perspective transformation, done on GTE, using gte_registers
      ir1 = (gte_trx * 0x1000 + gte_rt11 * xPos + gte_rt12 * yPos + gte_rt13 * zPos) >> 12
      ir2 = (gte_try * 0x1000 + gte_rt21 * xPos + gte_rt22 * yPos + gte_rt23 * zPos) >> 12
      ir3 = (gte_trz * 0x1000 + gte_rt31 * xPos + gte_rt32 * yPos + gte_rt33 * zPos) >> 12
      
      sx2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir1 + gte_cr24) / 0x10000
      sy2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir2 + gte_cr25) / 0x10000
      
      screenPosNew = { sy2, sx2 }
      
      // calculate previous screen position
      xPos = load(locationPtr + 0x00) + load(0x134398 + r19 * 2) * radius
      yPos = load(locationPtr + 0x04) + r19 * -200
      zPos = load(locationPtr + 0x08) + load(0x134399 + r19 * 2) * radius
      
      // perspective transformation, done on GTE, using gte_registers
      ir1 = (gte_trx * 0x1000 + gte_rt11 * xPos + gte_rt12 * yPos + gte_rt13 * zPos) >> 12
      ir2 = (gte_try * 0x1000 + gte_rt21 * xPos + gte_rt22 * yPos + gte_rt23 * zPos) >> 12
      ir3 = (gte_trz * 0x1000 + gte_rt31 * xPos + gte_rt32 * yPos + gte_rt33 * zPos) >> 12
      
      sx2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir1 + gte_cr24) / 0x10000
      sy2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir2 + gte_cr25) / 0x10000
      
      screenPosOld = { sy2, sx2 }
      
      if(hasMovedOutsideCombatArea(screenPosOld, screenPosNew, width, height) != 0)
        return 1
    }
  
  return 0
}

0x000d3648 addiu r29,r29,0xffb0
0x000d364c sw r31,0x0034(r29)
0x000d3650 sw r30,0x0030(r29)
0x000d3654 sw r23,0x002c(r29)
0x000d3658 sw r22,0x0028(r29)
0x000d365c sw r21,0x0024(r29)
0x000d3660 sw r20,0x0020(r29)
0x000d3664 sw r19,0x001c(r29)
0x000d3668 sw r18,0x0018(r29)
0x000d366c sw r17,0x0014(r29)
0x000d3670 sw r16,0x0010(r29)
0x000d3674 lb r2,-0x6c22(r28)
0x000d3678 addu r17,r4,r0
0x000d367c addu r16,r5,r0
0x000d3680 addu r21,r6,r0
0x000d3684 addiu r1,r0,0x0004
0x000d3688 bne r2,r1,0x000d3698
0x000d368c addu r22,r7,r0
0x000d3690 beq r0,r0,0x000d3828
0x000d3694 addu r2,r0,r0
0x000d3698 lui r4,0x8013
0x000d369c jal 0x00097dd8
0x000d36a0 addiu r4,r4,0x6f84
0x000d36a4 lw r2,0x0004(r17)
0x000d36a8 lw r3,0x0000(r17)
0x000d36ac addiu r23,r2,0x0078
0x000d36b0 sll r2,r3,0x01
0x000d36b4 add r2,r2,r3
0x000d36b8 sll r2,r2,0x02
0x000d36bc add r2,r2,r3
0x000d36c0 sll r3,r2,0x02
0x000d36c4 lui r2,0x8013
0x000d36c8 addiu r2,r2,0xcecc
0x000d36cc addu r2,r2,r3
0x000d36d0 lh r2,0x0000(r2)
0x000d36d4 addu r19,r0,r0
0x000d36d8 beq r0,r0,0x000d3818
0x000d36dc sw r2,0x003c(r29)
0x000d36e0 sll r2,r19,0x02
0x000d36e4 sub r2,r19,r2
0x000d36e8 sll r2,r2,0x03
0x000d36ec sub r2,r2,r19
0x000d36f0 lw r18,0x003c(r29)
0x000d36f4 addu r17,r0,r0
0x000d36f8 sll r30,r19,0x01
0x000d36fc beq r0,r0,0x000d3808
0x000d3700 sll r20,r2,0x03
0x000d3704 addiu r2,r28,0x886c
0x000d3708 addu r6,r2,r30
0x000d370c lb r3,0x0000(r6)
0x000d3710 lw r2,0x0000(r23)
0x000d3714 mult r18,r3
0x000d3718 mflo r3
0x000d371c add r2,r2,r3
0x000d3720 sh r2,0x0048(r29)
0x000d3724 lw r2,0x0004(r23)
0x000d3728 nop
0x000d372c add r2,r2,r20
0x000d3730 sh r2,0x004a(r29)
0x000d3734 addiu r2,r28,0x886d
0x000d3738 addu r3,r2,r30
0x000d373c lb r4,0x0000(r3)
0x000d3740 lw r2,0x0008(r23)
0x000d3744 mult r18,r4
0x000d3748 mflo r4
0x000d374c add r2,r2,r4
0x000d3750 sh r2,0x004c(r29)
0x000d3754 addiu r2,r29,0x0048
0x000d3758 addu r4,r2,r0
0x000d375c lwc2 gtedr00_vxy0,0x0000(r4)
0x000d3760 lwc2 gtedr01_vz0,0x0004(r4)
0x000d3764 nop
0x000d3768 nop
0x000d376c rtps
0x000d3770 addiu r5,r29,0x0044
0x000d3774 addu r4,r5,r0
0x000d3778 swc2 gtedr14_sxy2,0x0000(r4)
0x000d377c lb r6,0x0000(r6)
0x000d3780 lw r4,0x0000(r16)
0x000d3784 mult r18,r6
0x000d3788 mflo r6
0x000d378c add r4,r4,r6
0x000d3790 sh r4,0x0048(r29)
0x000d3794 lw r4,0x0004(r16)
0x000d3798 nop
0x000d379c add r4,r4,r20
0x000d37a0 sh r4,0x004a(r29)
0x000d37a4 lb r4,0x0000(r3)
0x000d37a8 nop
0x000d37ac mult r18,r4
0x000d37b0 lw r3,0x0008(r16)
0x000d37b4 mflo r4
0x000d37b8 add r3,r3,r4
0x000d37bc sh r3,0x004c(r29)
0x000d37c0 addu r4,r2,r0
0x000d37c4 lwc2 gtedr00_vxy0,0x0000(r4)
0x000d37c8 lwc2 gtedr01_vz0,0x0004(r4)
0x000d37cc nop
0x000d37d0 nop
0x000d37d4 rtps
0x000d37d8 addiu r4,r29,0x0040
0x000d37dc swc2 gtedr14_sxy2,0x0000(r4)
0x000d37e0 sll r6,r21,0x10
0x000d37e4 sll r7,r22,0x10
0x000d37e8 sra r6,r6,0x10
0x000d37ec jal 0x000d38d4
0x000d37f0 sra r7,r7,0x10
0x000d37f4 beq r2,r0,0x000d3804
0x000d37f8 nop
0x000d37fc beq r0,r0,0x000d3828
0x000d3800 addiu r2,r0,0x0001
0x000d3804 addi r17,r17,0x0001
0x000d3808 slti r1,r17,0x0004
0x000d380c bne r1,r0,0x000d3704
0x000d3810 nop
0x000d3814 addi r19,r19,0x0001
0x000d3818 slti r1,r19,0x0002
0x000d381c bne r1,r0,0x000d36e0
0x000d3820 nop
0x000d3824 addu r2,r0,r0
0x000d3828 lw r31,0x0034(r29)
0x000d382c lw r30,0x0030(r29)
0x000d3830 lw r23,0x002c(r29)
0x000d3834 lw r22,0x0028(r29)
0x000d3838 lw r21,0x0024(r29)
0x000d383c lw r20,0x0020(r29)
0x000d3840 lw r19,0x001c(r29)
0x000d3844 lw r18,0x0018(r29)
0x000d3848 lw r17,0x0014(r29)
0x000d384c lw r16,0x0010(r29)
0x000d3850 jr r31
0x000d3854 addiu r29,r29,0x0050