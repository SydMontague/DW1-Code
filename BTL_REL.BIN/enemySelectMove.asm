void enemySelectMove(entityPtr, combatPtr, combatId) {
  moveArray = int[4]
  priorityArray = int[4]
  
  numMoves = hasAffordableMoves(moveArray, combatId)
  
  if(numMoves == 0) {
    store(entityPtr + 0x56, 2)
    setCooldown(entityPtr, combatPtr)
  }
  
  for(i = 0; i < 4; i++)
    priorityArray[i] = load(entityPtr + 0x40 + i)
  
  for(i = 0; i < 4; i++) {
    moveId = load(entityPtr + 0x44 + i)
    
    if(moveId != -1) {
      if(moveArray[i] != 0) {
        techId = getTechFromMove(entityPtr, moveId)
        numEnemies = load(0x134D6C)
        combatHead = load(0x134D4C)
        
        for(enemyCounter = 1; enemyCounter < numEnemies; enemyCounter++) {
          if(enemyCounter == combatId)
            continue
          
          entityId = load(combatHead + 0x66C + enemyCounter)
          entityPtr = load(0x12F344 + entityId * 4)
          currentHP = load(entityPtr + 0x4C)
          remainingDamage = load(combatHead + enemyCounter * 0x168 + 0x2E)
          
          if(currentHP - remainingDamage > 0)
            break
        }
        
        if(enemyCounter != numEnemies + 1) { // an NPC died already
          entityId = getNPCId(entityPtr)
          someValue = load(0x15588A + entityId * 0x68)
          
          if(someValue == 0 && load(0x126244 + techId * 16) == 3) // attack type, all range
            priorityArray[i] = priorityArray[i] + 20
        }
        
        if(load(0x126244 + techId * 16) == 4) // attack type, buff
          priorityArray[i] = priorityArray[i] + load(combatPtr + 0x3A) // buff prio
      }
      else
        priorityArray[i] = 0
    }
  }
  
  totalPrio = 0
  
  for(i = 0; i < 4; i++) 
    totalPrio = totalPrio + priorityArray[i]
  
  rolledValue = random(totalPrio)
  prioSum = 0
  
  for(moveId = 0; moveId < 4; moveId++) {
    prio = priorityArray[moveId]
    
    if(prio == 0)
      continue
    
    prioSum += prio
    
    if(rolledValue < prioSum)
      break
  }
  
  if(load(entityPtr + 0x44 + moveId) != -1) // found move
    setMoveAnim(entityPtr, combatPtr, combatId, moveId)
  else {
    store(combatPtr + 0x28, 80)
    store(combatPtr + 0x34, load(combatPtr + 0x34) | 0x0800) // chargeup flag
  }
}

0x00060324 addiu r29,r29,0xffc8
0x00060328 sw r31,0x0024(r29)
0x0006032c sw r20,0x0020(r29)
0x00060330 sw r19,0x001c(r29)
0x00060334 sw r18,0x0018(r29)
0x00060338 sw r17,0x0014(r29)
0x0006033c addu r18,r4,r0
0x00060340 addu r19,r5,r0
0x00060344 addu r20,r6,r0
0x00060348 sw r16,0x0010(r29)
0x0006034c addiu r4,r29,0x0028
0x00060350 jal 0x0005ee58
0x00060354 addu r5,r20,r0
0x00060358 bne r2,r0,0x0006037c
0x0006035c addu r16,r0,r0
0x00060360 addiu r2,r0,0x0002
0x00060364 sb r2,0x0056(r18)
0x00060368 addu r4,r18,r0
0x0006036c jal 0x0005ef3c
0x00060370 addu r5,r19,r0
0x00060374 beq r0,r0,0x000605fc
0x00060378 lw r31,0x0024(r29)
0x0006037c beq r0,r0,0x0006039c
0x00060380 addu r4,r0,r0
0x00060384 addu r2,r16,r18
0x00060388 lbu r3,0x0040(r2)
0x0006038c addi r16,r16,0x0001
0x00060390 addu r2,r29,r4
0x00060394 sh r3,0x0030(r2)
0x00060398 addi r4,r4,0x0002
0x0006039c slti r1,r16,0x0004
0x000603a0 bne r1,r0,0x00060384
0x000603a4 nop
0x000603a8 addu r16,r0,r0
0x000603ac beq r0,r0,0x00060524
0x000603b0 addu r17,r0,r0
0x000603b4 addu r4,r16,r18
0x000603b8 lbu r5,0x0044(r4)
0x000603bc addiu r1,r0,0x00ff
0x000603c0 beq r5,r1,0x0006051c
0x000603c4 nop
0x000603c8 addu r3,r29,r17
0x000603cc lh r2,0x0028(r3)
0x000603d0 nop
0x000603d4 bne r2,r0,0x000603e4
0x000603d8 nop
0x000603dc beq r0,r0,0x0006051c
0x000603e0 sh r0,0x0030(r3)
0x000603e4 jal 0x000e6000
0x000603e8 addu r4,r18,r0
0x000603ec sll r8,r2,0x10
0x000603f0 lh r6,-0x6dc0(r28)
0x000603f4 lw r5,-0x6de0(r28)
0x000603f8 sra r8,r8,0x10
0x000603fc addiu r2,r0,0x0001
0x00060400 addiu r3,r0,0x0168
0x00060404 addu r4,r20,r0
0x00060408 beq r0,r0,0x00060460
0x0006040c addu r7,r6,r0
0x00060410 beq r2,r4,0x00060458
0x00060414 nop
0x00060418 addu r9,r2,r5
0x0006041c lbu r9,0x066c(r9)
0x00060420 nop
0x00060424 sll r10,r9,0x02
0x00060428 lui r9,0x8013
0x0006042c addiu r9,r9,0xf344
0x00060430 addu r9,r9,r10
0x00060434 lw r9,0x0000(r9)
0x00060438 nop
0x0006043c lh r10,0x004c(r9)
0x00060440 addu r9,r3,r5
0x00060444 lh r9,0x002e(r9)
0x00060448 nop
0x0006044c sub r9,r10,r9
0x00060450 bgtz r9,0x0006046c
0x00060454 nop
0x00060458 addi r2,r2,0x0001
0x0006045c addi r3,r3,0x0168
0x00060460 slt r1,r6,r2
0x00060464 beq r1,r0,0x00060410
0x00060468 nop
0x0006046c addi r3,r7,0x0001
0x00060470 beq r2,r3,0x000604e4
0x00060474 nop
0x00060478 jal 0x0005f4c4
0x0006047c addu r4,r18,r0
0x00060480 sll r3,r2,0x01
0x00060484 add r3,r3,r2
0x00060488 sll r3,r3,0x02
0x0006048c add r2,r3,r2
0x00060490 sll r3,r2,0x03
0x00060494 lui r2,0x8015
0x00060498 addiu r2,r2,0x588a
0x0006049c addu r2,r2,r3
0x000604a0 lbu r2,0x0000(r2)
0x000604a4 nop
0x000604a8 bne r2,r0,0x000604e4
0x000604ac nop
0x000604b0 lui r2,0x8012
0x000604b4 sll r3,r8,0x04
0x000604b8 addiu r2,r2,0x6244
0x000604bc addu r2,r2,r3
0x000604c0 lbu r2,0x0000(r2)
0x000604c4 addiu r1,r0,0x0003
0x000604c8 bne r2,r1,0x000604e4
0x000604cc nop
0x000604d0 addu r3,r29,r17
0x000604d4 lh r2,0x0030(r3)
0x000604d8 nop
0x000604dc addi r2,r2,0x0014
0x000604e0 sh r2,0x0030(r3)
0x000604e4 lui r2,0x8012
0x000604e8 sll r3,r8,0x04
0x000604ec addiu r2,r2,0x6244
0x000604f0 addu r2,r2,r3
0x000604f4 lbu r2,0x0000(r2)
0x000604f8 addiu r1,r0,0x0004
0x000604fc bne r2,r1,0x0006051c
0x00060500 nop
0x00060504 addu r3,r29,r17
0x00060508 lbu r4,0x003a(r19)
0x0006050c lh r2,0x0030(r3)
0x00060510 nop
0x00060514 add r2,r2,r4
0x00060518 sh r2,0x0030(r3)
0x0006051c addi r16,r16,0x0001
0x00060520 addi r17,r17,0x0002
0x00060524 slti r1,r16,0x0004
0x00060528 bne r1,r0,0x000603b4
0x0006052c nop
0x00060530 addu r4,r0,r0
0x00060534 addu r16,r0,r0
0x00060538 beq r0,r0,0x00060554
0x0006053c addu r3,r0,r0
0x00060540 addu r2,r29,r3
0x00060544 lh r2,0x0030(r2)
0x00060548 addi r16,r16,0x0001
0x0006054c add r4,r4,r2
0x00060550 addi r3,r3,0x0002
0x00060554 slti r1,r16,0x0004
0x00060558 bne r1,r0,0x00060540
0x0006055c nop
0x00060560 jal 0x000a36d4
0x00060564 nop
0x00060568 addu r4,r0,r0
0x0006056c addu r16,r0,r0
0x00060570 beq r0,r0,0x000605a4
0x00060574 addu r5,r0,r0
0x00060578 addu r3,r29,r5
0x0006057c lh r3,0x0030(r3)
0x00060580 nop
0x00060584 beq r3,r0,0x0006059c
0x00060588 addu r6,r3,r0
0x0006058c add r4,r4,r6
0x00060590 slt r1,r2,r4
0x00060594 bne r1,r0,0x000605b0
0x00060598 nop
0x0006059c addi r16,r16,0x0001
0x000605a0 addi r5,r5,0x0002
0x000605a4 slti r1,r16,0x0004
0x000605a8 bne r1,r0,0x00060578
0x000605ac nop
0x000605b0 addu r2,r16,r18
0x000605b4 lbu r2,0x0044(r2)
0x000605b8 addiu r1,r0,0x00ff
0x000605bc beq r2,r1,0x000605e0
0x000605c0 nop
0x000605c4 andi r7,r16,0x00ff
0x000605c8 addu r4,r18,r0
0x000605cc addu r5,r19,r0
0x000605d0 jal 0x0005d658
0x000605d4 addu r6,r20,r0
0x000605d8 beq r0,r0,0x000605fc
0x000605dc lw r31,0x0024(r29)
0x000605e0 addiu r2,r0,0x0050
0x000605e4 sh r2,0x0028(r19)
0x000605e8 lhu r2,0x0034(r19)
0x000605ec nop
0x000605f0 ori r2,r2,0x0800
0x000605f4 sh r2,0x0034(r19)
0x000605f8 lw r31,0x0024(r29)
0x000605fc lw r20,0x0020(r29)
0x00060600 lw r19,0x001c(r29)
0x00060604 lw r18,0x0018(r29)
0x00060608 lw r17,0x0014(r29)
0x0006060c lw r16,0x0010(r29)
0x00060610 jr r31
0x00060614 addiu r29,r29,0x0038