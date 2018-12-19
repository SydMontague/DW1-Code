void partnerYourCallSelectMove(entityPtr, combatPtr, combatId) {
  moveArray = short[4] // sp + 0x60
  powerArray = int[4] // sp + 0x3C
  rankingArray = int[4] // sp + 0x54
  
  moveSlotArray = { 0, 1, 2 } // sp + 0x48
  prioArray = { 0, 0, 0 } // sp + 0x68
  
  if(hasAffordableMoves(moveArray, combatId) == 0) {
    setCooldown(entityPtr, combatPtr)
    return
  }
  
  aiMode = load(entityPtr + 0x56) // attack type
  
  if(aiMode == 0) {
    for(r16 = 0; r16 < 3; r16++) {
      if(moveArray[r16] == 0)
        powerArray[r16] = -1
      else {
        moveId = load(entityPtr + 0x44 + r16)
        techId = getTechFromMove(entityPtr, moveId)
        powerArray[r16] = load(0x126240 + techId * 0x10)
      }
    }
    
    sortMoveArrayDescending(powerArray, moveSlotArray, rankingArray, 3)
    
    for(r16 = 0; r16 < 3; r16++) {
      moveSlot = moveSlotArray[r16]
      
      if(load(entityPtr + 0x44 + moveSlot) == -1) // has no move equipped
        prioArray[moveSlot] = prioArray[moveSlot] + 5
      else if(moveArray[moveSlot] != 0) { // is move usable
        prioValue = load(0x1346EC + rankingArray[moveSlot])
        prioArray[moveSlot] = prioValue
      }
    }
  }
  else if(aiMode == 1) {
    for(r16 = 0; r16 < 3; r16++) {
      if(load(entityPtr + 0x44 + r16) == -1)
        prioArray[r16] = prioArray[r16] + 5
      else if(moveArray[r16] != 0) // is move usable
        prioArray[r16] = prioArray[r16] + 20
    }
  }
  else if(aiMode == 2) {
    for(r16 = 0; r16 < 3; r16++) {
      if(moveArray[r16] == 0)
        powerArray[r16] = 10000
      else {
        moveId = load(entityPtr + 0x44 + r16)
        techId = getTechFromMove(entityPtr, moveId)
        powerArray[r16] = load(0x126242 + techId * 0x10) * 3
      }
    }
    
    sortMoveArrayAscending(powerArray, moveSlotArray, rankingArray, 3)
    
    for(r16 = 0; r16 < 3; r16++) {
      moveSlot = moveSlotArray[r16]
      
      if(load(entityPtr + 0x44 + moveSlot) == -1) // has no move equipped
        prioArray[moveSlot] = prioArray[moveSlot] + 5
      else if(moveArray[moveSlot] != 0) { // is move usable
        prioValue = load(0x1346F0 + rankingArray[moveSlot])
        prioArray[moveSlot] = prioValue
      }
    }
  }
  
  for(r16 = 0; r16 < 3; r16++) {
    moveId = load(entityPtr + 0x44 + r16)
    
    if(moveId == -1)
      continue
    
    if(moveArray[r16] == 0) {
      store(sp + 0x68 + r16 * 2, 0)
      continue
    }
    
    techId = getTechFromMove(entityPtr, moveId)
    range = load(0x126244 + techId * 0x10)
    
    if(range == 4) {
      moveSpec = load(0x126245 + techId * 0x10)
      digimonType = load(entityPtr)
      digimonSpec = load(0x12CEB4 + digimonType * 0x34 + 0x1E)
      
      typePriority = getTypeFactorPriority(moveSpec, digimonSpec)
      buffPrio = load(combatPtr + 0x3A) // self buff prio timer
      
      prioArray[r16] = prioArray[r16] + buffPrio + typePriority
      continue
    }
    
    moveSpec = load(0x126245 + techId * 0x10)
    currentTarget = load(combatPtr + 0x37)
    
    combatHead = load(0x134D4C) // combat head
    
    combatId = load(combatHead + 0x066C + currentTarget)
    entityPtr = load(0x12F344 + combatId * 4) // entityPtr
    enemyType = load(entityPtr)
    
    enemySpec = load(0x12CEB4 + enemyType * 0x34 + 0x1E)
    typePriority = getTypeFactorPriority(moveSpec, enemySpec)
    prioArray[r16] = prioArray[r16] + typePriority
    
    r2 = load(0x126244 + techId * 0x10)
    
    if(r2 != 3)
      continue
    
    aliveEnemies = getNumAliveNPCs()
    
    if(aiMode == 0) {
      brains = load(entityPtr + 0x3E)
      
      if(brains < 200 || aliveEnemies < 2)
        continue
      
      prioArray[r16] = prioArray[r16] + aliveEnemies * 10
      continue
    }
    else if(aiMode == 1){
      brains = load(entityPtr + 0x3E)
      
      if(brains < 200 || aliveEnemies < 2)
        continue
      
      prioArray[r16] = prioArray[r16] + aliveEnemies * 15
      continue
    }
    else if(aiMode == 2) {
      brains = load(entityPtr + 0x3E)
      
      if(brains >= 200 && aliveEnemies >= 2) {
        prioArray[r16] = prioArray[r16] + aliveEnemies * 15
        continue
      }
      else {
        currentHP = load(entityPtr + 0x4C) * 100
        maxHP = load(entityPtr + 0x48)
        
        r2 = currentHP / maxHP
        
        if(r2 > 30)
          continue
        
        for(r17 = 0; r17 < 3; r17++) {
          if(moveArray[r16] == 0)
            powerArray[r16] = -1
          else {
            moveId = load(entityPtr + 0x44 + r16)
            techId = getTechFromMove(entityPtr, moveId)
            powerArray[r16] = load(0x12623C + techId * 0x10)
          }
        }
        
        sortMoveArrayDescending(powerArray, moveSlotArray, rankingArray, 3)
        
        for(r16 = 0; r16 < 3; r16++) {
          if(load(entityPtr + 0x44 + r16) == -1)
            continue
          
          if(moveArray[r16] == 0)
            continue
          
          prioValue = load(0x1346F4 + rankingArray[r16])
          prioArray[moveSlotArray[r16]] = prioValue
        }
      }
    }
  }
  
  totalPrio = 0
  for(i = 0; i < 3; i++)
    totalPrio += prioArray[i]
  
  randomPrio = random(totalPrio)
  
  prioCounter = 0
  moveSlot = 0
  for(; moveSlot < 3; moveSlot++) {
    movePrio = prioArray[moveSlot]
    
    if(movePrio == 0)
      continue
    
    prioCounter += movePrio
    
    if(randomPrio < prioCounter)
      break
  }
  
  moveId = load(entityPtr + 0x44 + moveSlot)
  
  if(moveId != -1)
    setMoveAnim(entityPtr, combatPtr, value, moveSlot)
  else {
    store(combatPtr + 0x28, 0x50)
    r2 = load(combatPtr + 0x34) | 0x0800
    store(combatPtr + 0x34, r2)
  }
}

0x00060618 addiu r29,r29,0xff90
0x0006061c sw r31,0x0030(r29)
0x00060620 sw r23,0x002c(r29)
0x00060624 sw r22,0x0028(r29)
0x00060628 sw r21,0x0024(r29)
0x0006062c sw r20,0x0020(r29)
0x00060630 sw r19,0x001c(r29)
0x00060634 sw r18,0x0018(r29)
0x00060638 sw r17,0x0014(r29)
0x0006063c addu r20,r4,r0
0x00060640 addu r22,r5,r0
0x00060644 addu r23,r6,r0
0x00060648 sw r16,0x0010(r29)
0x0006064c addiu r4,r29,0x0060
0x00060650 jal 0x0005ee58
0x00060654 addu r5,r23,r0
0x00060658 bne r2,r0,0x00060674
0x0006065c addu r16,r0,r0
0x00060660 addu r4,r20,r0
0x00060664 jal 0x0005ef3c
0x00060668 addu r5,r22,r0
0x0006066c beq r0,r0,0x00060e28
0x00060670 lw r31,0x0030(r29)
0x00060674 addu r3,r0,r0
0x00060678 beq r0,r0,0x0006069c
0x0006067c addu r4,r0,r0
0x00060680 addu r2,r29,r3
0x00060684 sh r0,0x0068(r2)
0x00060688 addu r2,r29,r4
0x0006068c sw r16,0x0048(r2)
0x00060690 addi r16,r16,0x0001
0x00060694 addi r4,r4,0x0004
0x00060698 addi r3,r3,0x0002
0x0006069c slti r1,r16,0x0003
0x000606a0 bne r1,r0,0x00060680
0x000606a4 nop
0x000606a8 addiu r19,r20,0x0038
0x000606ac lbu r2,0x001e(r19)
0x000606b0 addiu r1,r0,0x0002
0x000606b4 beq r2,r1,0x0006086c
0x000606b8 addu r16,r0,r0
0x000606bc addiu r1,r0,0x0001
0x000606c0 beq r2,r1,0x000607fc
0x000606c4 addu r16,r0,r0
0x000606c8 bne r2,r0,0x00060998
0x000606cc nop
0x000606d0 addu r16,r0,r0
0x000606d4 addu r18,r0,r0
0x000606d8 beq r0,r0,0x00060744
0x000606dc addu r17,r0,r0
0x000606e0 addu r2,r29,r18
0x000606e4 lh r2,0x0060(r2)
0x000606e8 nop
0x000606ec bne r2,r0,0x00060704
0x000606f0 nop
0x000606f4 addiu r3,r0,0xffff
0x000606f8 addu r2,r29,r17
0x000606fc beq r0,r0,0x00060738
0x00060700 sw r3,0x003c(r2)
0x00060704 addu r2,r19,r16
0x00060708 lbu r5,0x000c(r2)
0x0006070c jal 0x000e6000
0x00060710 addu r4,r20,r0
0x00060714 sll r2,r2,0x10
0x00060718 sra r2,r2,0x10
0x0006071c sll r3,r2,0x04
0x00060720 lui r2,0x8012
0x00060724 addiu r2,r2,0x6240
0x00060728 addu r2,r2,r3
0x0006072c lh r3,0x0000(r2)
0x00060730 addu r2,r29,r17
0x00060734 sw r3,0x003c(r2)
0x00060738 addi r16,r16,0x0001
0x0006073c addi r17,r17,0x0004
0x00060740 addi r18,r18,0x0002
0x00060744 slti r1,r16,0x0003
0x00060748 bne r1,r0,0x000606e0
0x0006074c nop
0x00060750 addiu r4,r29,0x003c
0x00060754 addiu r5,r29,0x0048
0x00060758 addiu r6,r29,0x0054
0x0006075c jal 0x0005f8e0
0x00060760 addiu r7,r0,0x0003
0x00060764 addu r16,r0,r0
0x00060768 beq r0,r0,0x000607e8
0x0006076c addu r2,r0,r0
0x00060770 addu r4,r29,r2
0x00060774 lw r3,0x0048(r4)
0x00060778 addiu r1,r0,0x00ff
0x0006077c addu r5,r3,r0
0x00060780 addu r3,r3,r19
0x00060784 lbu r3,0x000c(r3)
0x00060788 nop
0x0006078c bne r3,r1,0x000607b0
0x00060790 nop
0x00060794 sll r3,r5,0x01
0x00060798 addu r4,r29,r3
0x0006079c lh r3,0x0068(r4)
0x000607a0 nop
0x000607a4 addi r3,r3,0x0005
0x000607a8 beq r0,r0,0x000607e0
0x000607ac sh r3,0x0068(r4)
0x000607b0 sll r3,r5,0x01
0x000607b4 addu r5,r29,r3
0x000607b8 lh r3,0x0060(r5)
0x000607bc nop
0x000607c0 beq r3,r0,0x000607e0
0x000607c4 nop
0x000607c8 lw r4,0x0054(r4)
0x000607cc addiu r3,r28,0x8bc0
0x000607d0 addu r3,r3,r4
0x000607d4 lbu r3,0x0000(r3)
0x000607d8 nop
0x000607dc sh r3,0x0068(r5)
0x000607e0 addi r16,r16,0x0001
0x000607e4 addi r2,r2,0x0004
0x000607e8 slti r1,r16,0x0003
0x000607ec bne r1,r0,0x00060770
0x000607f0 nop
0x000607f4 beq r0,r0,0x00060998
0x000607f8 nop
0x000607fc beq r0,r0,0x00060858
0x00060800 addu r4,r0,r0
0x00060804 addu r2,r16,r19
0x00060808 lbu r2,0x000c(r2)
0x0006080c addiu r1,r0,0x00ff
0x00060810 bne r2,r1,0x0006082c
0x00060814 nop
0x00060818 addu r3,r29,r4
0x0006081c lh r2,0x0068(r3)
0x00060820 nop
0x00060824 addi r2,r2,0x0005
0x00060828 sh r2,0x0068(r3)
0x0006082c addu r3,r29,r4
0x00060830 lh r2,0x0060(r3)
0x00060834 nop
0x00060838 beq r2,r0,0x00060850
0x0006083c nop
0x00060840 lh r2,0x0068(r3)
0x00060844 nop
0x00060848 addi r2,r2,0x0014
0x0006084c sh r2,0x0068(r3)
0x00060850 addi r16,r16,0x0001
0x00060854 addi r4,r4,0x0002
0x00060858 slti r1,r16,0x0003
0x0006085c bne r1,r0,0x00060804
0x00060860 nop
0x00060864 beq r0,r0,0x00060998
0x00060868 nop
0x0006086c addu r18,r0,r0
0x00060870 beq r0,r0,0x000608e8
0x00060874 addu r17,r0,r0
0x00060878 addu r2,r29,r18
0x0006087c lh r2,0x0060(r2)
0x00060880 nop
0x00060884 bne r2,r0,0x0006089c
0x00060888 nop
0x0006088c addiu r3,r0,0x2710
0x00060890 addu r2,r29,r17
0x00060894 beq r0,r0,0x000608dc
0x00060898 sw r3,0x003c(r2)
0x0006089c addu r2,r19,r16
0x000608a0 lbu r5,0x000c(r2)
0x000608a4 jal 0x000e6000
0x000608a8 addu r4,r20,r0
0x000608ac sll r2,r2,0x10
0x000608b0 sra r2,r2,0x10
0x000608b4 sll r3,r2,0x04
0x000608b8 lui r2,0x8012
0x000608bc addiu r2,r2,0x6242
0x000608c0 addu r2,r2,r3
0x000608c4 lbu r3,0x0000(r2)
0x000608c8 nop
0x000608cc sll r2,r3,0x01
0x000608d0 add r3,r2,r3
0x000608d4 addu r2,r29,r17
0x000608d8 sw r3,0x003c(r2)
0x000608dc addi r16,r16,0x0001
0x000608e0 addi r17,r17,0x0004
0x000608e4 addi r18,r18,0x0002
0x000608e8 slti r1,r16,0x0003
0x000608ec bne r1,r0,0x00060878
0x000608f0 nop
0x000608f4 addiu r4,r29,0x003c
0x000608f8 addiu r5,r29,0x0048
0x000608fc addiu r6,r29,0x0054
0x00060900 jal 0x0005f9d8
0x00060904 addiu r7,r0,0x0003
0x00060908 addu r16,r0,r0
0x0006090c beq r0,r0,0x0006098c
0x00060910 addu r2,r0,r0
0x00060914 addu r4,r29,r2
0x00060918 lw r3,0x0048(r4)
0x0006091c addiu r1,r0,0x00ff
0x00060920 addu r5,r3,r0
0x00060924 addu r3,r3,r19
0x00060928 lbu r3,0x000c(r3)
0x0006092c nop
0x00060930 bne r3,r1,0x00060954
0x00060934 nop
0x00060938 sll r3,r5,0x01
0x0006093c addu r4,r29,r3
0x00060940 lh r3,0x0068(r4)
0x00060944 nop
0x00060948 addi r3,r3,0x0005
0x0006094c beq r0,r0,0x00060984
0x00060950 sh r3,0x0068(r4)
0x00060954 sll r3,r5,0x01
0x00060958 addu r5,r29,r3
0x0006095c lh r3,0x0060(r5)
0x00060960 nop
0x00060964 beq r3,r0,0x00060984
0x00060968 nop
0x0006096c lw r4,0x0054(r4)
0x00060970 addiu r3,r28,0x8bc4
0x00060974 addu r3,r3,r4
0x00060978 lbu r3,0x0000(r3)
0x0006097c nop
0x00060980 sh r3,0x0068(r5)
0x00060984 addi r16,r16,0x0001
0x00060988 addi r2,r2,0x0004
0x0006098c slti r1,r16,0x0003
0x00060990 bne r1,r0,0x00060914
0x00060994 nop
0x00060998 beq r0,r0,0x00060d50
0x0006099c addu r16,r0,r0
0x000609a0 addu r4,r16,r19
0x000609a4 lbu r5,0x000c(r4)
0x000609a8 addiu r1,r0,0x00ff
0x000609ac beq r5,r1,0x00060d4c
0x000609b0 nop
0x000609b4 sll r2,r16,0x01
0x000609b8 addu r17,r2,r0
0x000609bc addu r3,r29,r2
0x000609c0 lh r2,0x0060(r3)
0x000609c4 nop
0x000609c8 bne r2,r0,0x000609d8
0x000609cc nop
0x000609d0 beq r0,r0,0x00060d4c
0x000609d4 sh r0,0x0068(r3)
0x000609d8 jal 0x000e6000
0x000609dc addu r4,r20,r0
0x000609e0 sll r2,r2,0x10
0x000609e4 sra r2,r2,0x10
0x000609e8 sll r3,r2,0x04
0x000609ec lui r2,0x8012
0x000609f0 addiu r2,r2,0x6244
0x000609f4 addu r2,r2,r3
0x000609f8 lbu r2,0x0000(r2)
0x000609fc addiu r1,r0,0x0004
0x00060a00 bne r2,r1,0x00060a74
0x00060a04 addu r18,r3,r0
0x00060a08 lui r2,0x8012
0x00060a0c addiu r2,r2,0x623c
0x00060a10 addu r2,r2,r18
0x00060a14 lbu r4,0x0009(r2)
0x00060a18 lw r3,0x0000(r20)
0x00060a1c nop
0x00060a20 sll r2,r3,0x01
0x00060a24 add r2,r2,r3
0x00060a28 sll r2,r2,0x02
0x00060a2c add r2,r2,r3
0x00060a30 sll r3,r2,0x02
0x00060a34 lui r2,0x8013
0x00060a38 addiu r2,r2,0xceb4
0x00060a3c addu r2,r2,r3
0x00060a40 lbu r5,0x001e(r2)
0x00060a44 jal 0x0005fad0
0x00060a48 nop
0x00060a4c lbu r3,0x003a(r22)
0x00060a50 nop
0x00060a54 add r2,r3,r2
0x00060a58 sll r4,r2,0x10
0x00060a5c addu r3,r29,r17
0x00060a60 lh r2,0x0068(r3)
0x00060a64 sra r4,r4,0x10
0x00060a68 add r2,r2,r4
0x00060a6c beq r0,r0,0x00060d4c
0x00060a70 sh r2,0x0068(r3)
0x00060a74 lui r2,0x8012
0x00060a78 addiu r2,r2,0x623c
0x00060a7c addu r2,r2,r18
0x00060a80 lbu r4,0x0009(r2)
0x00060a84 lbu r3,0x0037(r22)
0x00060a88 lw r2,-0x6de0(r28)
0x00060a8c nop
0x00060a90 addu r2,r2,r3
0x00060a94 lbu r2,0x066c(r2)
0x00060a98 nop
0x00060a9c sll r3,r2,0x02
0x00060aa0 lui r2,0x8013
0x00060aa4 addiu r2,r2,0xf344
0x00060aa8 addu r2,r2,r3
0x00060aac lw r2,0x0000(r2)
0x00060ab0 nop
0x00060ab4 lw r3,0x0000(r2)
0x00060ab8 nop
0x00060abc sll r2,r3,0x01
0x00060ac0 add r2,r2,r3
0x00060ac4 sll r2,r2,0x02
0x00060ac8 add r2,r2,r3
0x00060acc sll r3,r2,0x02
0x00060ad0 lui r2,0x8013
0x00060ad4 addiu r2,r2,0xceb4
0x00060ad8 addu r2,r2,r3
0x00060adc lbu r5,0x001e(r2)
0x00060ae0 jal 0x0005fad0
0x00060ae4 nop
0x00060ae8 addu r4,r29,r17
0x00060aec lh r3,0x0068(r4)
0x00060af0 addiu r1,r0,0x0003
0x00060af4 add r2,r3,r2
0x00060af8 sh r2,0x0068(r4)
0x00060afc lui r2,0x8012
0x00060b00 addiu r2,r2,0x6244
0x00060b04 addu r2,r2,r18
0x00060b08 lbu r2,0x0000(r2)
0x00060b0c nop
0x00060b10 bne r2,r1,0x00060d4c
0x00060b14 nop
0x00060b18 jal 0x0005fb54
0x00060b1c nop
0x00060b20 lbu r3,0x0056(r20)
0x00060b24 addiu r1,r0,0x0002
0x00060b28 beq r3,r1,0x00060bd0
0x00060b2c nop
0x00060b30 addiu r1,r0,0x0001
0x00060b34 beq r3,r1,0x00060b8c
0x00060b38 nop
0x00060b3c bne r3,r0,0x00060d4c
0x00060b40 nop
0x00060b44 lh r3,0x0006(r19)
0x00060b48 nop
0x00060b4c slti r1,r3,0x00c8
0x00060b50 bne r1,r0,0x00060d4c
0x00060b54 nop
0x00060b58 slti r1,r2,0x0002
0x00060b5c bne r1,r0,0x00060d4c
0x00060b60 nop
0x00060b64 sll r3,r2,0x02
0x00060b68 add r2,r3,r2
0x00060b6c sll r2,r2,0x01
0x00060b70 sll r4,r2,0x10
0x00060b74 addu r3,r29,r17
0x00060b78 lh r2,0x0068(r3)
0x00060b7c sra r4,r4,0x10
0x00060b80 add r2,r2,r4
0x00060b84 beq r0,r0,0x00060d4c
0x00060b88 sh r2,0x0068(r3)
0x00060b8c lh r3,0x0006(r19)
0x00060b90 nop
0x00060b94 slti r1,r3,0x00c8
0x00060b98 bne r1,r0,0x00060d4c
0x00060b9c nop
0x00060ba0 slti r1,r2,0x0002
0x00060ba4 bne r1,r0,0x00060d4c
0x00060ba8 nop
0x00060bac sll r3,r2,0x04
0x00060bb0 sub r2,r3,r2
0x00060bb4 sll r4,r2,0x10
0x00060bb8 addu r3,r29,r17
0x00060bbc lh r2,0x0068(r3)
0x00060bc0 sra r4,r4,0x10
0x00060bc4 add r2,r2,r4
0x00060bc8 beq r0,r0,0x00060d4c
0x00060bcc sh r2,0x0068(r3)
0x00060bd0 lh r3,0x0006(r19)
0x00060bd4 nop
0x00060bd8 slti r1,r3,0x00c8
0x00060bdc bne r1,r0,0x00060c14
0x00060be0 nop
0x00060be4 slti r1,r2,0x0002
0x00060be8 bne r1,r0,0x00060c14
0x00060bec nop
0x00060bf0 sll r3,r2,0x04
0x00060bf4 sub r2,r3,r2
0x00060bf8 sll r4,r2,0x10
0x00060bfc addu r3,r29,r17
0x00060c00 lh r2,0x0068(r3)
0x00060c04 sra r4,r4,0x10
0x00060c08 add r2,r2,r4
0x00060c0c beq r0,r0,0x00060d4c
0x00060c10 sh r2,0x0068(r3)
0x00060c14 lh r3,0x0014(r19)
0x00060c18 nop
0x00060c1c sll r2,r3,0x02
0x00060c20 add r3,r2,r3
0x00060c24 sll r2,r3,0x02
0x00060c28 add r3,r3,r2
0x00060c2c lh r2,0x0010(r19)
0x00060c30 sll r3,r3,0x02
0x00060c34 div r3,r2
0x00060c38 mflo r2
0x00060c3c slti r1,r2,0x001f
0x00060c40 beq r1,r0,0x00060d4c
0x00060c44 nop
0x00060c48 addu r17,r0,r0
0x00060c4c sll r21,r16,0x01
0x00060c50 beq r0,r0,0x00060cb4
0x00060c54 sll r18,r16,0x02
0x00060c58 addu r2,r29,r21
0x00060c5c lh r2,0x0060(r2)
0x00060c60 nop
0x00060c64 bne r2,r0,0x00060c7c
0x00060c68 nop
0x00060c6c addiu r3,r0,0xffff
0x00060c70 addu r2,r29,r18
0x00060c74 beq r0,r0,0x00060cb0
0x00060c78 sw r3,0x003c(r2)
0x00060c7c addu r2,r19,r16
0x00060c80 lbu r5,0x000c(r2)
0x00060c84 jal 0x000e6000
0x00060c88 addu r4,r20,r0
0x00060c8c sll r2,r2,0x10
0x00060c90 sra r2,r2,0x10
0x00060c94 sll r3,r2,0x04
0x00060c98 lui r2,0x8012
0x00060c9c addiu r2,r2,0x623c
0x00060ca0 addu r2,r2,r3
0x00060ca4 lw r3,0x0000(r2)
0x00060ca8 addu r2,r29,r18
0x00060cac sw r3,0x003c(r2)
0x00060cb0 addi r17,r17,0x0001
0x00060cb4 slti r1,r17,0x0003
0x00060cb8 bne r1,r0,0x00060c58
0x00060cbc nop
0x00060cc0 addiu r4,r29,0x003c
0x00060cc4 addiu r5,r29,0x0048
0x00060cc8 addiu r6,r29,0x0054
0x00060ccc jal 0x0005f8e0
0x00060cd0 addiu r7,r0,0x0003
0x00060cd4 addu r16,r0,r0
0x00060cd8 addu r5,r0,r0
0x00060cdc beq r0,r0,0x00060d40
0x00060ce0 addu r6,r0,r0
0x00060ce4 addu r2,r16,r19
0x00060ce8 lbu r2,0x000c(r2)
0x00060cec addiu r1,r0,0x00ff
0x00060cf0 beq r2,r1,0x00060d34
0x00060cf4 nop
0x00060cf8 addu r2,r29,r5
0x00060cfc lh r2,0x0060(r2)
0x00060d00 nop
0x00060d04 beq r2,r0,0x00060d34
0x00060d08 nop
0x00060d0c addu r4,r29,r6
0x00060d10 lw r3,0x0054(r4)
0x00060d14 addiu r2,r28,0x8bc8
0x00060d18 addu r2,r2,r3
0x00060d1c lbu r3,0x0000(r2)
0x00060d20 lw r2,0x0048(r4)
0x00060d24 nop
0x00060d28 sll r2,r2,0x01
0x00060d2c addu r2,r29,r2
0x00060d30 sh r3,0x0068(r2)
0x00060d34 addi r16,r16,0x0001
0x00060d38 addi r6,r6,0x0004
0x00060d3c addi r5,r5,0x0002
0x00060d40 slti r1,r16,0x0003
0x00060d44 bne r1,r0,0x00060ce4
0x00060d48 nop
0x00060d4c addi r16,r16,0x0001
0x00060d50 slti r1,r16,0x0003
0x00060d54 bne r1,r0,0x000609a0
0x00060d58 nop
0x00060d5c addu r4,r0,r0
0x00060d60 addu r16,r0,r0
0x00060d64 beq r0,r0,0x00060d80
0x00060d68 addu r3,r0,r0
0x00060d6c addu r2,r29,r3
0x00060d70 lh r2,0x0068(r2)
0x00060d74 addi r16,r16,0x0001
0x00060d78 add r4,r4,r2
0x00060d7c addi r3,r3,0x0002
0x00060d80 slti r1,r16,0x0003
0x00060d84 bne r1,r0,0x00060d6c
0x00060d88 nop
0x00060d8c jal 0x000a36d4
0x00060d90 nop
0x00060d94 addu r4,r0,r0
0x00060d98 addu r16,r0,r0
0x00060d9c beq r0,r0,0x00060dd0
0x00060da0 addu r5,r0,r0
0x00060da4 addu r3,r29,r5
0x00060da8 lh r3,0x0068(r3)
0x00060dac nop
0x00060db0 beq r3,r0,0x00060dc8
0x00060db4 addu r6,r3,r0
0x00060db8 add r4,r4,r6
0x00060dbc slt r1,r2,r4
0x00060dc0 bne r1,r0,0x00060ddc
0x00060dc4 nop
0x00060dc8 addi r16,r16,0x0001
0x00060dcc addi r5,r5,0x0002
0x00060dd0 slti r1,r16,0x0003
0x00060dd4 bne r1,r0,0x00060da4
0x00060dd8 nop
0x00060ddc addu r2,r16,r20
0x00060de0 lbu r2,0x0044(r2)
0x00060de4 addiu r1,r0,0x00ff
0x00060de8 beq r2,r1,0x00060e0c
0x00060dec nop
0x00060df0 andi r7,r16,0x00ff
0x00060df4 addu r4,r20,r0
0x00060df8 addu r5,r22,r0
0x00060dfc jal 0x0005d658
0x00060e00 addu r6,r23,r0
0x00060e04 beq r0,r0,0x00060e28
0x00060e08 lw r31,0x0030(r29)
0x00060e0c addiu r2,r0,0x0050
0x00060e10 sh r2,0x0028(r22)
0x00060e14 lhu r2,0x0034(r22)
0x00060e18 nop
0x00060e1c ori r2,r2,0x0800
0x00060e20 sh r2,0x0034(r22)
0x00060e24 lw r31,0x0030(r29)
0x00060e28 lw r23,0x002c(r29)
0x00060e2c lw r22,0x0028(r29)
0x00060e30 lw r21,0x0024(r29)
0x00060e34 lw r20,0x0020(r29)
0x00060e38 lw r19,0x001c(r29)
0x00060e3c lw r18,0x0018(r29)
0x00060e40 lw r17,0x0014(r29)
0x00060e44 lw r16,0x0010(r29)
0x00060e48 jr r31
0x00060e4c addiu r29,r29,0x0070