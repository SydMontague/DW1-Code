/**
 * Gets the weakest enemy and returns it alongside the weakness score 
 * of the last checked Digimon.
 *
 * This function is probably bugged. It's probably supposed to return
 * the best Digimon's score, as opposed to the last one's.
 * Also see getWeaknessScore(), which is probably bugged as well.
 */
int, int getWeakestEnemy(entityPtr, combatPtr) {
  bestScore = 1000
  lastScore = 0
  bestEntity = -1
  
  combatHead = load(0x134D4C)
  
  for(combatId = 0; combatId <= load(0x134D6C); combatId++) {
    entityId = load(combatHead + 0x66C + combatId)
    localEntityPtr = load(0x12F344 + entityId * 4)
    
    if(localEntityPtr == entityPtr)
      continue
    
    if(hasZeroHP(combatId))
      continue
    
    currentTarget = load(combatPtr + 0x37)
    
    // is current target
    if(currentTarget != -1) {
      entityId = load(combatHead + 0x66C + currentTarget)
      targetEntityPtr = load(0x12F344 + entityId * 4)
      
      if(localEntityPtr == targetEntityPtr)
        continue
    }
    
    lastScore = getWeaknessScore(entityPtr, localEntityPtr)
    
    if(lastScore >= bestScore)
      continue
    
    bestScore = lastScore
    bestEntity = combatId
  }
  
  return lastScore, bestEntity
}

0x0005f61c addiu r29,r29,0xffd0
0x0005f620 sw r31,0x002c(r29)
0x0005f624 sw r22,0x0028(r29)
0x0005f628 sw r21,0x0024(r29)
0x0005f62c sw r20,0x0020(r29)
0x0005f630 sw r19,0x001c(r29)
0x0005f634 sw r18,0x0018(r29)
0x0005f638 sw r17,0x0014(r29)
0x0005f63c addiu r2,r0,0x03e8
0x0005f640 sll r17,r2,0x10
0x0005f644 sw r16,0x0010(r29)
0x0005f648 addu r21,r7,r0
0x0005f64c addiu r2,r0,0x00ff
0x0005f650 addu r20,r4,r0
0x0005f654 addu r22,r5,r0
0x0005f658 addu r19,r6,r0
0x0005f65c sra r17,r17,0x10
0x0005f660 sh r2,0x0000(r21)
0x0005f664 beq r0,r0,0x0005f728
0x0005f668 addu r16,r0,r0
0x0005f66c lw r2,-0x6de0(r28)
0x0005f670 nop
0x0005f674 addu r2,r16,r2
0x0005f678 lbu r2,0x066c(r2)
0x0005f67c nop
0x0005f680 sll r3,r2,0x02
0x0005f684 lui r2,0x8013
0x0005f688 addiu r2,r2,0xf344
0x0005f68c addu r2,r2,r3
0x0005f690 lw r18,0x0000(r2)
0x0005f694 nop
0x0005f698 beq r18,r20,0x0005f724
0x0005f69c nop
0x0005f6a0 jal 0x000601ac
0x0005f6a4 andi r4,r16,0x00ff
0x0005f6a8 bne r2,r0,0x0005f724
0x0005f6ac nop
0x0005f6b0 lbu r2,0x0037(r22)
0x0005f6b4 addiu r1,r0,0x00ff
0x0005f6b8 beq r2,r1,0x0005f6f4
0x0005f6bc addu r3,r2,r0
0x0005f6c0 lw r2,-0x6de0(r28)
0x0005f6c4 nop
0x0005f6c8 addu r2,r3,r2
0x0005f6cc lbu r2,0x066c(r2)
0x0005f6d0 nop
0x0005f6d4 sll r3,r2,0x02
0x0005f6d8 lui r2,0x8013
0x0005f6dc addiu r2,r2,0xf344
0x0005f6e0 addu r2,r2,r3
0x0005f6e4 lw r2,0x0000(r2)
0x0005f6e8 nop
0x0005f6ec beq r18,r2,0x0005f724
0x0005f6f0 nop
0x0005f6f4 addu r4,r20,r0
0x0005f6f8 jal 0x0005f764
0x0005f6fc addu r5,r18,r0
0x0005f700 sh r2,0x0000(r19)
0x0005f704 lh r2,0x0000(r19)
0x0005f708 nop
0x0005f70c slt r1,r2,r17
0x0005f710 beq r1,r0,0x0005f724
0x0005f714 addu r3,r2,r0
0x0005f718 sll r17,r3,0x10
0x0005f71c sra r17,r17,0x10
0x0005f720 sh r16,0x0000(r21)
0x0005f724 addi r16,r16,0x0001
0x0005f728 lh r2,-0x6dc0(r28)
0x0005f72c nop
0x0005f730 slt r1,r2,r16
0x0005f734 beq r1,r0,0x0005f66c
0x0005f738 nop
0x0005f73c lw r31,0x002c(r29)
0x0005f740 lw r22,0x0028(r29)
0x0005f744 lw r21,0x0024(r29)
0x0005f748 lw r20,0x0020(r29)
0x0005f74c lw r19,0x001c(r29)
0x0005f750 lw r18,0x0018(r29)
0x0005f754 lw r17,0x0014(r29)
0x0005f758 lw r16,0x0010(r29)
0x0005f75c jr r31
0x0005f760 addiu r29,r29,0x0030