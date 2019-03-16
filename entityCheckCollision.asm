/**
 * Checks whether checkedEntityPtr is colliding with anything and returns a response code.
 *
 * noCollideEntityPtr - ignored entity, no collision with it possible
 * checkedEntityPtr - entity checked for collision
 * width - used for screen space collision
 * height - used for screen space collision
 *
 * Response Codes:
 *  11  - screen space collision (see checkMapCollision function)
 *  10  - map collision
 * 0-9  - entity collision (entity ID)
 *  -1  - no collision
 */
int entityCheckCollision(noCollideEntityPtr, checkedEntityPtr, width, height) {
  
  locPtr = load(checkedEntityPtr + 0x04) + 0x78
  
  locationArray = int[4]
  locationArray[0] = load(locPtr + 0x00)
  locationArray[1] = load(locPtr + 0x04)
  locationArray[2] = load(locPtr + 0x08)
  locationArray[3] = load(locPtr + 0x0C)
  
  someFlag = load(checkedEntityPtr + 0x30) & 0x0005
  store(checkedEntityPtr + 0x30, someFlag)
  
  entityMoveForward(checkedEntityPtr)
  
  diffX = load(locPtr + 0x00) - locationArray[0]
  diffY = load(locPtr + 0x08) - locationArray[2]
  
  rotationPtr = load(checkedEntityPtr + 0x04) + 0x72
  rotation = load(rotationPtr) // rotation
  
  if(rotation == 0x0400 || rotation == 0x0C00)
    diffY = 0
    
  if(rotation == 0x0000 || rotation == 0x0800)
    diffX = 0
  
  store(locPtr + 0x00, locationArray[0])
  store(locPtr + 0x04, locationArray[1])
  store(locPtr + 0x08, locationArray[2])
  store(locPtr + 0x0C, locationArray[3])
  
  if(width != 0 && height != 0 && entityCheckCombatArea(checkedEntityPtr, locationArray, width, height) != 0)
    return 0x0B
  
  if(checkMapCollision(checkedEntityPtr, diffX, diffY) != 0)
    return 0x0A
  
  for(i = 0; i < 10; i++) {
    lEntityPtr = load(0x12F344 + i * 4)
    
    if(isInvisible(lEntityPtr) != 0)
      continue
      
    if(lEntityPtr == checkedEntityPtr)
      continue
    
    if(lEntityPtr == noCollideEntityPtr)
      continue
      
    if(i != 0) {
      if(load(lEntityPtr + 0x4C) == 0)
        continue
    }
    else if(load(0x134F0A) == 1) {
      animId = load(checkedEntityPtr + 0x2E)
      if(animId == 0x23 || animId == 0x24)
        continue
    }
    
    if(entityCheckEntityCollision(checkedEntityPtr, lEntityPtr, diffX, diffY) != 0)
      return i
  }
  
  return -1
}

0x000d45ec addiu r29,r29,0xffb8
0x000d45f0 sw r31,0x0030(r29)
0x000d45f4 sw r23,0x002c(r29)
0x000d45f8 sw r22,0x0028(r29)
0x000d45fc sw r21,0x0024(r29)
0x000d4600 sw r20,0x0020(r29)
0x000d4604 sw r19,0x001c(r29)
0x000d4608 sw r18,0x0018(r29)
0x000d460c sw r17,0x0014(r29)
0x000d4610 sw r16,0x0010(r29)
0x000d4614 addu r19,r5,r0
0x000d4618 lw r2,0x0004(r19)
0x000d461c addu r23,r4,r0
0x000d4620 addiu r16,r2,0x0078
0x000d4624 lw r5,0x0000(r16)
0x000d4628 lw r4,0x0004(r16)
0x000d462c lw r3,0x0008(r16)
0x000d4630 lw r2,0x000c(r16)
0x000d4634 addu r17,r6,r0
0x000d4638 sw r5,0x0038(r29)
0x000d463c sw r4,0x003c(r29)
0x000d4640 sw r3,0x0040(r29)
0x000d4644 sw r2,0x0044(r29)
0x000d4648 lbu r2,0x0030(r19)
0x000d464c addu r18,r7,r0
0x000d4650 andi r2,r2,0x0005
0x000d4654 sb r2,0x0030(r19)
0x000d4658 jal 0x000d4f10
0x000d465c addu r4,r19,r0
0x000d4660 lw r3,0x0000(r16)
0x000d4664 lw r2,0x0038(r29)
0x000d4668 addiu r1,r0,0x0400
0x000d466c sub r22,r3,r2
0x000d4670 lw r3,0x0008(r16)
0x000d4674 lw r2,0x0040(r29)
0x000d4678 nop
0x000d467c sub r21,r3,r2
0x000d4680 lw r2,0x0004(r19)
0x000d4684 nop
0x000d4688 lh r2,0x0072(r2)
0x000d468c nop
0x000d4690 beq r2,r1,0x000d46a4
0x000d4694 nop
0x000d4698 addiu r1,r0,0x0c00
0x000d469c bne r2,r1,0x000d46a8
0x000d46a0 nop
0x000d46a4 addu r21,r0,r0
0x000d46a8 beq r2,r0,0x000d46bc
0x000d46ac nop
0x000d46b0 addiu r1,r0,0x0800
0x000d46b4 bne r2,r1,0x000d46c0
0x000d46b8 nop
0x000d46bc addu r22,r0,r0
0x000d46c0 beq r17,r0,0x000d4714
0x000d46c4 nop
0x000d46c8 beq r18,r0,0x000d4714
0x000d46cc nop
0x000d46d0 addu r4,r19,r0
0x000d46d4 addiu r5,r29,0x0038
0x000d46d8 addu r6,r17,r0
0x000d46dc jal 0x000d3648
0x000d46e0 addu r7,r18,r0
0x000d46e4 beq r2,r0,0x000d4714
0x000d46e8 nop
0x000d46ec lw r5,0x0038(r29)
0x000d46f0 lw r4,0x003c(r29)
0x000d46f4 lw r3,0x0040(r29)
0x000d46f8 lw r2,0x0044(r29)
0x000d46fc sw r5,0x0000(r16)
0x000d4700 sw r4,0x0004(r16)
0x000d4704 sw r3,0x0008(r16)
0x000d4708 sw r2,0x000c(r16)
0x000d470c beq r0,r0,0x000d4858
0x000d4710 addiu r2,r0,0x000b
0x000d4714 addu r4,r19,r0
0x000d4718 addu r5,r22,r0
0x000d471c jal 0x000d5018
0x000d4720 addu r6,r21,r0
0x000d4724 beq r2,r0,0x000d4754
0x000d4728 addu r18,r0,r0
0x000d472c lw r5,0x0038(r29)
0x000d4730 lw r4,0x003c(r29)
0x000d4734 lw r3,0x0040(r29)
0x000d4738 lw r2,0x0044(r29)
0x000d473c sw r5,0x0000(r16)
0x000d4740 sw r4,0x0004(r16)
0x000d4744 sw r3,0x0008(r16)
0x000d4748 sw r2,0x000c(r16)
0x000d474c beq r0,r0,0x000d4858
0x000d4750 addiu r2,r0,0x000a
0x000d4754 beq r0,r0,0x000d4828
0x000d4758 addu r20,r0,r0
0x000d475c lui r2,0x8013
0x000d4760 addiu r2,r2,0xf344
0x000d4764 addu r2,r2,r20
0x000d4768 lw r17,0x0000(r2)
0x000d476c jal 0x000e61ac
0x000d4770 addu r4,r17,r0
0x000d4774 bne r2,r0,0x000d4820
0x000d4778 nop
0x000d477c beq r17,r19,0x000d4820
0x000d4780 nop
0x000d4784 beq r17,r23,0x000d4820
0x000d4788 nop
0x000d478c beq r18,r0,0x000d47ac
0x000d4790 nop
0x000d4794 lh r2,0x004c(r17)
0x000d4798 nop
0x000d479c bne r2,r0,0x000d47d8
0x000d47a0 nop
0x000d47a4 beq r0,r0,0x000d4824
0x000d47a8 addi r18,r18,0x0001
0x000d47ac lb r2,-0x6c22(r28)
0x000d47b0 addiu r1,r0,0x0001
0x000d47b4 bne r2,r1,0x000d47d8
0x000d47b8 nop
0x000d47bc lbu r2,0x002e(r19)
0x000d47c0 addiu r1,r0,0x0024
0x000d47c4 beq r2,r1,0x000d4820
0x000d47c8 addu r3,r2,r0
0x000d47cc addiu r1,r0,0x0023
0x000d47d0 beq r3,r1,0x000d4820
0x000d47d4 nop
0x000d47d8 addu r4,r19,r0
0x000d47dc addu r5,r17,r0
0x000d47e0 addu r6,r22,r0
0x000d47e4 jal 0x000d50dc
0x000d47e8 addu r7,r21,r0
0x000d47ec beq r2,r0,0x000d4820
0x000d47f0 nop
0x000d47f4 lw r5,0x0038(r29)
0x000d47f8 lw r4,0x003c(r29)
0x000d47fc lw r3,0x0040(r29)
0x000d4800 lw r2,0x0044(r29)
0x000d4804 sw r5,0x0000(r16)
0x000d4808 sw r4,0x0004(r16)
0x000d480c sw r3,0x0008(r16)
0x000d4810 sw r2,0x000c(r16)
0x000d4814 sll r2,r18,0x10
0x000d4818 beq r0,r0,0x000d4858
0x000d481c sra r2,r2,0x10
0x000d4820 addi r18,r18,0x0001
0x000d4824 addi r20,r20,0x0004
0x000d4828 slti r1,r18,0x000a
0x000d482c bne r1,r0,0x000d475c
0x000d4830 nop
0x000d4834 lw r5,0x0038(r29)
0x000d4838 lw r4,0x003c(r29)
0x000d483c lw r3,0x0040(r29)
0x000d4840 lw r2,0x0044(r29)
0x000d4844 sw r5,0x0000(r16)
0x000d4848 sw r4,0x0004(r16)
0x000d484c sw r3,0x0008(r16)
0x000d4850 sw r2,0x000c(r16)
0x000d4854 addiu r2,r0,0xffff
0x000d4858 lw r31,0x0030(r29)
0x000d485c lw r23,0x002c(r29)
0x000d4860 lw r22,0x0028(r29)
0x000d4864 lw r21,0x0024(r29)
0x000d4868 lw r20,0x0020(r29)
0x000d486c lw r19,0x001c(r29)
0x000d4870 lw r18,0x0018(r29)
0x000d4874 lw r17,0x0014(r29)
0x000d4878 lw r16,0x0010(r29)
0x000d487c jr r31
0x000d4880 addiu r29,r29,0x0048