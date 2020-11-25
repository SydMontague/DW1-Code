0x00059508(entityPtr, enemyPtr, combatId) {
  if(load(entityPtr + 0x30) & 1 == 0) {
    animTarget = load(entityPtr + 0x1E) // anim frame target
    animCurrent = load(entityPtr + 0x1C) // anim frame current
    
    // is attacking someone who is countering them?
    if(animTarget != animCurrent) {
      combatHead = load(0x134D4C)
      numEnemies = load(0x134D6C)
      
      for(i = 0; i < numEnemies; i++) {
        if(i == combatId)
          continue
        
        entitiyId = load(combatHead + 0x66C + i)
        entityPtr = load(0x12F344 + entitiyId * 4)
        entityType = load(entityPtr)
        activeMove = load(entityPtr + 0x2E) - 0x2E
        attackId = load(0x12CED7 + entityType * 0x34 + activeMove)
        
        if(attackId != 0x2D) // counter
          continue
        
        targetId = load(combatHead + i * 0x168 + 0x37)
        
        if(combatId == targetId)
          return
      }
      
      store(entityPtr + 0x30, load(entityPtr + 0x30) | 1)
    }
  }
  
  0x0005A9F8(combatId)
}

0x00059508 addiu r29,r29,0xffe8
0x0005950c sw r31,0x0010(r29)
0x00059510 lbu r2,0x0030(r4)
0x00059514 nop
0x00059518 andi r2,r2,0x0001
0x0005951c bne r2,r0,0x000595f0
0x00059520 nop
0x00059524 lh r3,0x001e(r4)
0x00059528 lh r2,0x001c(r4)
0x0005952c nop
0x00059530 beq r3,r2,0x000595f0
0x00059534 nop
0x00059538 lw r5,-0x6de0(r28)
0x0005953c lh r7,-0x6dc0(r28)
0x00059540 addu r2,r0,r0
0x00059544 beq r0,r0,0x000595d4
0x00059548 addu r3,r0,r0
0x0005954c beq r2,r6,0x000595cc
0x00059550 nop
0x00059554 addu r8,r2,r5
0x00059558 lbu r8,0x066c(r8)
0x0005955c addiu r1,r0,0x002d
0x00059560 sll r9,r8,0x02
0x00059564 lui r8,0x8013
0x00059568 addiu r8,r8,0xf344
0x0005956c addu r8,r8,r9
0x00059570 lw r9,0x0000(r8)
0x00059574 nop
0x00059578 lbu r8,0x002e(r9)
0x0005957c lw r9,0x0000(r9)
0x00059580 addi r10,r8,-0x002e
0x00059584 sll r8,r9,0x01
0x00059588 add r8,r8,r9
0x0005958c sll r8,r8,0x02
0x00059590 add r8,r8,r9
0x00059594 sll r9,r8,0x02
0x00059598 lui r8,0x8013
0x0005959c addiu r8,r8,0xced7
0x000595a0 addu r8,r8,r9
0x000595a4 addu r8,r10,r8
0x000595a8 lbu r8,0x0000(r8)
0x000595ac nop
0x000595b0 bne r8,r1,0x000595cc
0x000595b4 nop
0x000595b8 addu r8,r3,r5
0x000595bc lbu r8,0x0037(r8)
0x000595c0 nop
0x000595c4 beq r6,r8,0x000595f8
0x000595c8 nop
0x000595cc addi r2,r2,0x0001
0x000595d0 addi r3,r3,0x0168
0x000595d4 slt r1,r7,r2
0x000595d8 beq r1,r0,0x0005954c
0x000595dc nop
0x000595e0 lbu r2,0x0030(r4)
0x000595e4 nop
0x000595e8 ori r2,r2,0x0001
0x000595ec sb r2,0x0030(r4)
0x000595f0 jal 0x0005a9f8
0x000595f4 addu r4,r6,r0
0x000595f8 lw r31,0x0010(r29)
0x000595fc nop
0x00059600 jr r31
0x00059604 addiu r29,r29,0x0018
