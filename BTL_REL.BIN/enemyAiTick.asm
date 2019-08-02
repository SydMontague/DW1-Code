void enemyAiTick() {
  frameCount = load(0x134D66)
  
  combatHead = load(0x134D4C) // combat head
  partnerPtr = load(0x12F348) // partner ptr
  
  // self buff prio timer
  if(frameCount % 20 == 0) {
    for(combatId = 0; combatId < load(0x134D6C); combatId++) {
      combatPtr = combatId * 0x168 + combatHead
      selfBuffPrioTimer = load(combatPtr + 0x3A)
      
      if(selfBuffPrioTimer != 0)
        store(combatPtr + 0x3A, selfBuffPrioTimer - 1)
    }
  }
  
  for(combatId = 1; combatId < load(0x134D6C); combatId++) {
    combatPtr = combatHead + combatId * 0x168
    combatHead = load(0x134D4C)
    statusFlagPtr = combatPtr + 0x34
    entityId = load(combatHead + 0x66C + combatId) // entityId
    entityPtr = load(0x12F344 + entityId * 4)
    statsPtr = entityPtr + 0x38
    noAiFlag = load(0x134D74)
    
    // dumbness effect code
    if(noAiFlag == 0) {
      currentHP = load(statsPtr + 0x14)
      remainingDamage = load(combatPtr + 0x2E)
      brains = load(statsPtr + 0x06)
      
      if(remainingDamage < currentHP
        && brains < 301
        && frameCount % (brains / 2 + 1) * 20 == 0
        && random(100) < (300 - brains) / 4) {
        
        store(statusFlagPtr, load(statusFlagPtr) | 0x2000) // set stupid
        store(combatPtr + 0x2A, 100)
      }
      
      if(load(statusFlagPtr) & 0x2000 == 0)
        increaseSpeedBuffer(combatPtr, statsPtr)
      
      cooldown = load(combatPtr + 0x28)
      
      if(cooldown >= 2)
        store(combatPtr + 0x28, cooldown - 1)
    }
    
    statusFlag = load(statusFlagPtr)
    
    if(statusFlag & 0x80B0 != 0) // dead, knocked down, attacking, blocking
      continue
      
    currentHP = load(statsPtr + 0x14)
    remainingDamage = load(combatPtr + 0x2E)
    
    if(currentHP == 0) {
      handleDeath(entityPtr, combatPtr, combatId)
      continue
    }
    
    // is dead
    if(remainingDamage >= currentHP) {
      handleBattleIdle(entityPtr, statsPtr)
      
      store(combatPtr + 0x36, -1)
      resetFlatten(combatId)
      removeEffectSprites(entityPtr, combatPtr)
      
      store(combatPtr + 0x34, load(combatPtr + 0x34) & 0xFFF0) // unset poisoned, confused, stunned, flat
      continue
    }
    
    partnerCurrentHP = load(partnerPtr + 0x4C)
    
    // partner is ded
    if(partnerCurrentHP == 0) {
      handleBattleIdle(entityPtr, statsPtr)
      
      resetFlatten(combatId)
      
      store(statusFlagPtr, load(statusFlagPtr) & 0xFF4F) // unset knocked back, attacking, blocking
      store(statusFlagPtr, load(statusFlagPtr) | 0x0040) // set transforming
      store(combatPtr + 0x36, -1)
      
      continue
    }
    
    if(noAiFlag != 0)
      return
    
    if(statusFlag & 0x0040 != 0) // transforming
      continue
    
    if(statusFlag & 0x0008 != 0) { // is flattened
      store(combatPtr + 0x36, 2) // moves range
      store(combatPtr + 0x37, 0) // target ID
      store(combatPtr + 0x38, 0) // animID?
      
      startAnimation(entityPtr, 0x23)
      
      store(entityPtr + 0x36, 0) // unknown
      store(combatPtr + 0x34, load(combatPtr + 0x34) | 0x0040) // set transforming/fleeing?
      
      continue
    }
    
    if(statusFlag & 0x0004 != 0) // stunned
      continue
    
    if(statusFlag & 0x0002 != 0) { // confused
      handleConfusion(entityPtr, combatPtr, combatId)
      continue
    }
    
    if(statusFlag & 0x2000 != 0) // stupid
      continue
    if(statusFlag & 0x8000 != 0) // dead
      continue
    if(statusFlag & 0x1000 != 0) // on cooldown
      continue
    
    moveId = load(entityPtr + 0x47)
    techId = getTechFromMove(entityPtr, moveId)
    
    // use finisher if possible
    if(statusFlag & 0x980E == 0 // not confused, stunned, flattened, on chargeup, on cooldown or dead
       && load(combatPtr + 0x22) == 0 // flattened timer
       && moveId != -1
       && techId >= 0x3A && techId < 0x71 // is finisher
       && load(combatPtr + 0x1A) == load(combatPtr + 0x18)) { // finisher progress is done
       
      store(combatPtr + 0x37)
      setMoveAnim(entityPtr, combatPtr, combatId, 3)
      store(combatPtr + 0x1A, 0)
      continue
    }
    
    if(load(statusFlagPtr) & 0x0400 == 0) // unknown value
      store(combatPtr + 0x37, 0) // targetId
    
    setTransformationMatrix(0x136F84)
    
    positionPtr = load(entityPtr + 0x04) + 0xBC
    
    xPos = load(positionPtr + 0x14)
    yPos = load(positionPtr + 0x18)
    zPos = load(positionPtr + 0x1C)
    
    // perspective transformation, done on GTE, using gte_registers
    ir1 = (gte_trx * 0x1000 + gte_rt11 * xPos + gte_rt12 * yPos + gte_rt13 * zPos) >> 12
    ir2 = (gte_try * 0x1000 + gte_rt21 * xPos + gte_rt22 * yPos + gte_rt23 * zPos) >> 12
    ir3 = (gte_trz * 0x1000 + gte_rt31 * xPos + gte_rt32 * yPos + gte_rt33 * zPos) >> 12
    
    sx2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir1 + gte_cr24) / 0x10000
    sy2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir2 + gte_cr25) / 0x10000
    
    screenCoords = { sy2, sx2 }
    
    // ai mode?
    if(isOffScreen(screenCoords, 200, 160) == 1)
      store(statsPtr + 0x1E, 2)
    else
      store(statsPtr + 0x1E, random(2))
    
    enemySelectMove(entityPtr, combatPtr, combatId)
  }
}

0x00058394 addiu r29,r29,0xffc0
0x00058398 sw r31,0x002c(r29)
0x0005839c sw r22,0x0028(r29)
0x000583a0 sw r21,0x0024(r29)
0x000583a4 sw r20,0x0020(r29)
0x000583a8 sw r19,0x001c(r29)
0x000583ac sw r18,0x0018(r29)
0x000583b0 lui r1,0x8013
0x000583b4 sw r17,0x0014(r29)
0x000583b8 lh r3,-0x6dc6(r28)
0x000583bc addiu r2,r0,0x0014
0x000583c0 div r3,r2
0x000583c4 lw r4,-0x6de0(r28)
0x000583c8 lw r22,-0x0cb8(r1)
0x000583cc mfhi r2
0x000583d0 bne r2,r0,0x0005841c
0x000583d4 sw r16,0x0010(r29)
0x000583d8 addu r19,r0,r0
0x000583dc beq r0,r0,0x00058408
0x000583e0 addu r5,r0,r0
0x000583e4 addu r3,r5,r4
0x000583e8 lbu r2,0x003a(r3)
0x000583ec nop
0x000583f0 beq r2,r0,0x00058400
0x000583f4 nop
0x000583f8 addiu r2,r2,0xffff
0x000583fc sb r2,0x003a(r3)
0x00058400 addi r19,r19,0x0001
0x00058404 addi r5,r5,0x0168
0x00058408 lh r2,-0x6dc0(r28)
0x0005840c nop
0x00058410 slt r1,r2,r19
0x00058414 beq r1,r0,0x000583e4
0x00058418 nop
0x0005841c addiu r19,r0,0x0001
0x00058420 beq r0,r0,0x00058838
0x00058424 addiu r16,r4,0x0168
0x00058428 lw r2,-0x6de0(r28)
0x0005842c addiu r18,r16,0x0034
0x00058430 addu r2,r19,r2
0x00058434 lbu r2,0x066c(r2)
0x00058438 nop
0x0005843c sll r3,r2,0x02
0x00058440 lui r2,0x8013
0x00058444 addiu r2,r2,0xf344
0x00058448 addu r2,r2,r3
0x0005844c lw r17,0x0000(r2)
0x00058450 lw r2,-0x6db8(r28)
0x00058454 nop
0x00058458 bne r2,r0,0x00058548
0x0005845c addiu r20,r17,0x0038
0x00058460 lh r3,0x0014(r20)
0x00058464 lh r2,0x002e(r16)
0x00058468 nop
0x0005846c slt r1,r2,r3
0x00058470 beq r1,r0,0x0005850c
0x00058474 nop
0x00058478 lh r2,0x0006(r20)
0x0005847c nop
0x00058480 slti r1,r2,0x012d
0x00058484 beq r1,r0,0x0005850c
0x00058488 addu r3,r2,r0
0x0005848c bgez r3,0x0005849c
0x00058490 sra r25,r3,0x01
0x00058494 addiu r2,r3,0x0001
0x00058498 sra r25,r2,0x01
0x0005849c addi r3,r25,0x0001
0x000584a0 sll r2,r3,0x02
0x000584a4 add r3,r2,r3
0x000584a8 lh r2,-0x6dc6(r28)
0x000584ac sll r3,r3,0x02
0x000584b0 div r2,r3
0x000584b4 mfhi r2
0x000584b8 bne r2,r0,0x0005850c
0x000584bc nop
0x000584c0 lh r3,0x0006(r20)
0x000584c4 addiu r2,r0,0x012c
0x000584c8 sub r2,r2,r3
0x000584cc bgez r2,0x000584dc
0x000584d0 sra r25,r2,0x02
0x000584d4 addiu r2,r2,0x0003
0x000584d8 sra r25,r2,0x02
0x000584dc addu r21,r25,r0
0x000584e0 jal 0x000a36d4
0x000584e4 addiu r4,r0,0x0064
0x000584e8 slt r1,r2,r21
0x000584ec beq r1,r0,0x0005850c
0x000584f0 nop
0x000584f4 lhu r2,0x0000(r18)
0x000584f8 nop
0x000584fc ori r2,r2,0x2000
0x00058500 sh r2,0x0000(r18)
0x00058504 addiu r2,r0,0x0064
0x00058508 sh r2,0x002a(r16)
0x0005850c lhu r2,0x0000(r18)
0x00058510 nop
0x00058514 andi r2,r2,0x2000
0x00058518 bne r2,r0,0x0005852c
0x0005851c nop
0x00058520 addu r4,r16,r0
0x00058524 jal 0x0005af44
0x00058528 addu r5,r20,r0
0x0005852c lh r2,0x0028(r16)
0x00058530 nop
0x00058534 slti r1,r2,0x0002
0x00058538 bne r1,r0,0x00058548
0x0005853c nop
0x00058540 addi r2,r2,-0x0001
0x00058544 sh r2,0x0028(r16)
0x00058548 lhu r2,0x0000(r18)
0x0005854c nop
0x00058550 addu r6,r2,r0
0x00058554 andi r2,r2,0x80b0
0x00058558 bne r2,r0,0x00058830
0x0005855c nop
0x00058560 lh r2,0x0014(r20)
0x00058564 nop
0x00058568 bne r2,r0,0x0005858c
0x0005856c addu r3,r2,r0
0x00058570 sll r6,r19,0x10
0x00058574 sra r6,r6,0x10
0x00058578 addu r4,r17,r0
0x0005857c jal 0x0005afd8
0x00058580 addu r5,r16,r0
0x00058584 beq r0,r0,0x00058834
0x00058588 addi r19,r19,0x0001
0x0005858c lh r2,0x002e(r16)
0x00058590 nop
0x00058594 slt r1,r2,r3
0x00058598 bne r1,r0,0x000585e0
0x0005859c nop
0x000585a0 addu r4,r17,r0
0x000585a4 jal 0x000e7d40
0x000585a8 addu r5,r20,r0
0x000585ac addiu r2,r0,0xffff
0x000585b0 sll r4,r19,0x10
0x000585b4 sb r2,0x0036(r16)
0x000585b8 jal 0x00059078
0x000585bc sra r4,r4,0x10
0x000585c0 addu r4,r17,r0
0x000585c4 jal 0x0005ec7c
0x000585c8 addu r5,r16,r0
0x000585cc lhu r2,0x0034(r16)
0x000585d0 nop
0x000585d4 andi r2,r2,0xfff0
0x000585d8 beq r0,r0,0x00058830
0x000585dc sh r2,0x0034(r16)
0x000585e0 lh r2,0x004c(r22)
0x000585e4 nop
0x000585e8 bne r2,r0,0x00058634
0x000585ec nop
0x000585f0 addu r4,r17,r0
0x000585f4 jal 0x000e7d40
0x000585f8 addu r5,r20,r0
0x000585fc sll r4,r19,0x10
0x00058600 jal 0x00059078
0x00058604 sra r4,r4,0x10
0x00058608 lhu r2,0x0000(r18)
0x0005860c nop
0x00058610 andi r2,r2,0xff4f
0x00058614 sh r2,0x0000(r18)
0x00058618 lhu r2,0x0000(r18)
0x0005861c nop
0x00058620 ori r2,r2,0x0040
0x00058624 sh r2,0x0000(r18)
0x00058628 addiu r2,r0,0xffff
0x0005862c beq r0,r0,0x00058830
0x00058630 sb r2,0x0036(r16)
0x00058634 lw r2,-0x6db8(r28)
0x00058638 nop
0x0005863c bne r2,r0,0x0005884c
0x00058640 nop
0x00058644 andi r2,r6,0x0040
0x00058648 bne r2,r0,0x00058830
0x0005864c nop
0x00058650 andi r2,r6,0x0008
0x00058654 beq r2,r0,0x00058690
0x00058658 nop
0x0005865c sb r0,0x0038(r16)
0x00058660 sb r0,0x0037(r16)
0x00058664 addiu r2,r0,0x0002
0x00058668 sb r2,0x0036(r16)
0x0005866c addu r4,r17,r0
0x00058670 jal 0x000c1a04
0x00058674 addiu r5,r0,0x0023
0x00058678 sb r0,0x0036(r17)
0x0005867c lhu r2,0x0034(r16)
0x00058680 nop
0x00058684 ori r2,r2,0x0040
0x00058688 beq r0,r0,0x00058830
0x0005868c sh r2,0x0034(r16)
0x00058690 andi r2,r6,0x0004
0x00058694 bne r2,r0,0x00058830
0x00058698 nop
0x0005869c andi r2,r6,0x0002
0x000586a0 beq r2,r0,0x000586c0
0x000586a4 nop
0x000586a8 addu r4,r17,r0
0x000586ac addu r5,r16,r0
0x000586b0 jal 0x0005fc18
0x000586b4 addu r6,r19,r0
0x000586b8 beq r0,r0,0x00058834
0x000586bc addi r19,r19,0x0001
0x000586c0 andi r2,r6,0x2000
0x000586c4 bne r2,r0,0x00058830
0x000586c8 nop
0x000586cc andi r2,r6,0x0800
0x000586d0 bne r2,r0,0x00058830
0x000586d4 nop
0x000586d8 andi r2,r6,0x1000
0x000586dc bne r2,r0,0x00058830
0x000586e0 nop
0x000586e4 andi r2,r6,0x980e
0x000586e8 bne r2,r0,0x00058778
0x000586ec nop
0x000586f0 lh r2,0x0022(r16)
0x000586f4 nop
0x000586f8 bne r2,r0,0x00058778
0x000586fc nop
0x00058700 lbu r2,0x0047(r17)
0x00058704 addiu r1,r0,0x00ff
0x00058708 sll r5,r2,0x10
0x0005870c sra r5,r5,0x10
0x00058710 beq r5,r1,0x00058778
0x00058714 nop
0x00058718 jal 0x000e6000
0x0005871c addu r4,r17,r0
0x00058720 sll r5,r2,0x10
0x00058724 sra r5,r5,0x10
0x00058728 slti r1,r5,0x003a
0x0005872c bne r1,r0,0x00058778
0x00058730 nop
0x00058734 slti r1,r5,0x0071
0x00058738 beq r1,r0,0x00058778
0x0005873c nop
0x00058740 lh r3,0x001a(r16)
0x00058744 lh r2,0x0018(r16)
0x00058748 nop
0x0005874c bne r3,r2,0x00058778
0x00058750 nop
0x00058754 sll r6,r19,0x10
0x00058758 sb r0,0x0037(r16)
0x0005875c sra r6,r6,0x10
0x00058760 addu r4,r17,r0
0x00058764 addu r5,r16,r0
0x00058768 jal 0x0005d658
0x0005876c addiu r7,r0,0x0003
0x00058770 beq r0,r0,0x00058830
0x00058774 sh r0,0x001a(r16)
0x00058778 lhu r2,0x0000(r18)
0x0005877c nop
0x00058780 andi r2,r2,0x0400
0x00058784 bne r2,r0,0x00058790
0x00058788 nop
0x0005878c sb r0,0x0037(r16)
0x00058790 lui r4,0x8013
0x00058794 jal 0x00097dd8
0x00058798 addiu r4,r4,0x6f84
0x0005879c lw r2,0x0004(r17)
0x000587a0 addiu r4,r29,0x0038
0x000587a4 addiu r3,r2,0x00bc
0x000587a8 lw r2,0x0014(r3)
0x000587ac nop
0x000587b0 sh r2,0x0038(r29)
0x000587b4 lw r2,0x0018(r3)
0x000587b8 nop
0x000587bc sh r2,0x003a(r29)
0x000587c0 lw r2,0x001c(r3)
0x000587c4 nop
0x000587c8 sh r2,0x003c(r29)
0x000587cc lwc2 gtedr00_vxy0,0x0000(r4)
0x000587d0 lwc2 gtedr01_vz0,0x0004(r4)
0x000587d4 nop
0x000587d8 nop
0x000587dc rtps
0x000587e0 addiu r2,r29,0x0034
0x000587e4 addu r4,r2,r0
0x000587e8 swc2 gtedr14_sxy2,0x0000(r4)
0x000587ec addiu r5,r0,0x00c8
0x000587f0 jal 0x000d5608
0x000587f4 addiu r6,r0,0x00a0
0x000587f8 addiu r1,r0,0x0001
0x000587fc bne r2,r1,0x00058810
0x00058800 nop
0x00058804 addiu r2,r0,0x0002
0x00058808 beq r0,r0,0x0005881c
0x0005880c sb r2,0x001e(r20)
0x00058810 jal 0x000a36d4
0x00058814 addiu r4,r0,0x0002
0x00058818 sb r2,0x001e(r20)
0x0005881c sll r6,r19,0x10
0x00058820 sra r6,r6,0x10
0x00058824 addu r4,r17,r0
0x00058828 jal 0x00060324
0x0005882c addu r5,r16,r0
0x00058830 addi r19,r19,0x0001
0x00058834 addi r16,r16,0x0168
0x00058838 lh r2,-0x6dc0(r28)
0x0005883c nop
0x00058840 slt r1,r2,r19
0x00058844 beq r1,r0,0x00058428
0x00058848 nop
0x0005884c lw r31,0x002c(r29)
0x00058850 lw r22,0x0028(r29)
0x00058854 lw r21,0x0024(r29)
0x00058858 lw r20,0x0020(r29)
0x0005885c lw r19,0x001c(r29)
0x00058860 lw r18,0x0018(r29)
0x00058864 lw r17,0x0014(r29)
0x00058868 lw r16,0x0010(r29)
0x0005886c jr r31
0x00058870 addiu r29,r29,0x0040