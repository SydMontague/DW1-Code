int handleCombatStart(int interactedEntity) {
  enemyCount = 0
  
  combatHead = load(0x134D4C) // head combat data
  combatMode = readPStat(250) // 0 = normal fight, 1 = enemies defined per pstat
  
  store(combatHead + 0x66C, 1)
  store(combatHead + 0x670, 0)
  store(0x134D7C, isTriggerSet(1)) // non-runnable fight
  store(0x134E84, combatMode)
  
  if(combatMode == 1) {
    for(i = 0; i < 3; i++) {
      definedEnemy = readPStat(251 + i)
      store(stack + 0x30 + i, definedEnemy)
      
      if(definedEnemy != -1) {
        0x000E7D9C(definedEnemy, 0)
        enemyCount++
        store(combatHead + 0x66C + enemyCount, definedEnemy)
      }
    }
    
    for(i = 2; i < 10; i++) {
      for(count = 0; count < 3; count++) 
        if(load(stack + 0x30 + count) == i)
          break
      
      if(count != 3)
        continue
        
      entityPtr = load(0x12F344 + 4 * i)
      isOnScreen = load(entityPtr + 0x35) 
      
      if(isOnScreen == 0)
        store(entityPtr + 0x34, 0) // set isOnMap to false
        
      if(isInvisible(entityPtr) != 0)
        continue
        
      0x000E7D9C(entityPtr, 1)
    }
    
    return enemyCount
  }
  else {
    enemyCount++
    store(combatHead + 0x66C + enemyCount, interactedEntity)
    r22 = isScreenConcave()
    
    for(i = 2; i < 10; i++) {
      entityPtr = load(0x12F344 + 4 * i)
      
      if(entityPtr == 0)
        continue
        
      isOnMap = load(entityPtr + 0x34)
      
      if(isOnMap == 0)
        continue
      
      if(i == interactedEntity) {
        0x000E7D9C(i, 0)
        continue
      }
      else {
        isOnScreen = load(0x15578D + 0x68 * i)
        
        if(isOnScreen == 0) {
          store(0x15578C, 0) // set isOnMap to false
          continue
        }
        else if(enemyCount == 3) {
          0x000E7D9C(i, 1)
          continue
        }
        else if(r22 != 0) {
          r4, r5 = getEntityTileFromModel(load(0x12F344))
          r6, r7 = getEntityTileFromModel(entityPtr)
          
          if(isPathBetween(r4, r5, r6, r7) != 0) {
            0x000E7D9C(i, 1)
            continue
          }
          
          r4, r5 = getEntityTileFromModel(load(0x12F348))
          
          if(isPathBetween(r4, r5, r6, r7) != 0) {
            0x000E7D9C(i, 1)
            continue
          }
        }
        
        rolledValue = random(100)
        inventorySize = load(0x13D4CE) // inventory size
        hasRepel = 0
        hasBell = 0
        
        for(r4 = 0; r4 < inventorySize; r4++) {
          itemId = load(0x13D474 + r4)
          if(itemId == 35)
            hasBell = 1
          if(itemId == 36)
            hasRepel = 1
        }
        
        if(hasRepel == 1)
          rolledValue += 20
        else if(hasBell == 1)
          rolledValue -= 50
                
        if(load(0x134D7C) != 0) // is non-runnable fight
          rolledValue = 0
        
        ownDigimon = load(0x1557A8)
        runsAway = 1 // run away
        ownDigimonType = load(0x12CED0 + ownDigimonType * 52) - 1
        
        if(ownDigimonType != -1) {
          enemyDigimon = load(0x155758 + 0x68 * i)
          enemyDigimonType = load(0x12CED0 + enemyDigimon * 52) - 1
          
          chance = load(0x12BB14 + ownDigimonType * 3 + enemyDigimonType)
          
          if(rolledValue >= chance) {
            enemyCount++
            store(combatHead + 0x66C + enemyCount, i)
            runsAway = 0 // fight
          }
        }
        else {
          if(random(100) >= 80) {
            enemyCount++
            store(combatHead + 0x66C + enemyCount, i)
            runsAway = 0 // fight
          }
        }
        0x000E7D9C(i, runsAway)
      }
    }
  }
  
  return enemyCount
}


0x000e847c addiu r29,r29,0xffc8
0x000e8480 sw r31,0x002c(r29)
0x000e8484 sw r22,0x0028(r29)
0x000e8488 sw r21,0x0024(r29)
0x000e848c sw r20,0x0020(r29)
0x000e8490 sw r19,0x001c(r29)
0x000e8494 sw r18,0x0018(r29)
0x000e8498 sw r17,0x0014(r29)
0x000e849c addu r21,r4,r0
0x000e84a0 lw r2,-0x6de0(r28)
0x000e84a4 sw r16,0x0010(r29)
0x000e84a8 addiu r4,r0,0x0001
0x000e84ac sb r4,0x066c(r2)
0x000e84b0 lw r2,-0x6de0(r28)
0x000e84b4 nop
0x000e84b8 sb r0,0x0670(r2)
0x000e84bc jal 0x0010643c
0x000e84c0 addu r18,r0,r0
0x000e84c4 sw r2,-0x6db0(r28)
0x000e84c8 jal 0x001062e0
0x000e84cc addiu r4,r0,0x00fa
0x000e84d0 sb r2,-0x6ca8(r28)
0x000e84d4 lbu r2,-0x6ca8(r28)
0x000e84d8 addiu r1,r0,0x0001
0x000e84dc bne r2,r1,0x000e85fc
0x000e84e0 nop
0x000e84e4 addu r16,r0,r0
0x000e84e8 beq r0,r0,0x000e8538
0x000e84ec addiu r19,r0,0x00fb
0x000e84f0 jal 0x001062e0
0x000e84f4 andi r4,r19,0x00ff
0x000e84f8 addu r3,r29,r16
0x000e84fc sb r2,0x0030(r3)
0x000e8500 lbu r2,0x0030(r3)
0x000e8504 addiu r1,r0,0x00ff
0x000e8508 beq r2,r1,0x000e8530
0x000e850c addu r17,r2,r0
0x000e8510 addu r4,r17,r0
0x000e8514 jal 0x000e7d9c
0x000e8518 addu r5,r0,r0
0x000e851c addi r2,r18,0x0001
0x000e8520 lw r3,-0x6de0(r28)
0x000e8524 addu r18,r2,r0
0x000e8528 addu r2,r2,r3
0x000e852c sb r17,0x066c(r2)
0x000e8530 addi r16,r16,0x0001
0x000e8534 addi r19,r19,0x0001
0x000e8538 slti r1,r16,0x0003
0x000e853c bne r1,r0,0x000e84f0
0x000e8540 nop
0x000e8544 addiu r16,r0,0x0002
0x000e8548 beq r0,r0,0x000e85e8
0x000e854c addiu r17,r0,0x0008
0x000e8550 beq r0,r0,0x000e8570
0x000e8554 addu r4,r0,r0
0x000e8558 addu r2,r29,r4
0x000e855c lbu r2,0x0030(r2)
0x000e8560 nop
0x000e8564 beq r2,r16,0x000e857c
0x000e8568 nop
0x000e856c addi r4,r4,0x0001
0x000e8570 slti r1,r4,0x0003
0x000e8574 bne r1,r0,0x000e8558
0x000e8578 nop
0x000e857c addiu r1,r0,0x0003
0x000e8580 bne r4,r1,0x000e85e0
0x000e8584 nop
0x000e8588 lui r2,0x8013
0x000e858c addiu r2,r2,0xf344
0x000e8590 addu r2,r2,r17
0x000e8594 lw r3,0x0000(r2)
0x000e8598 nop
0x000e859c lb r2,0x0035(r3)
0x000e85a0 nop
0x000e85a4 bne r2,r0,0x000e85b0
0x000e85a8 nop
0x000e85ac sb r0,0x0034(r3)
0x000e85b0 lui r2,0x8013
0x000e85b4 addiu r2,r2,0xf344
0x000e85b8 addu r2,r2,r17
0x000e85bc lw r4,0x0000(r2)
0x000e85c0 jal 0x000e61ac
0x000e85c4 nop
0x000e85c8 bne r2,r0,0x000e85e0
0x000e85cc nop
0x000e85d0 sll r4,r16,0x10
0x000e85d4 sra r4,r4,0x10
0x000e85d8 jal 0x000e7d9c
0x000e85dc addiu r5,r0,0x0001
0x000e85e0 addi r16,r16,0x0001
0x000e85e4 addi r17,r17,0x0004
0x000e85e8 slti r1,r16,0x000a
0x000e85ec bne r1,r0,0x000e8550
0x000e85f0 nop
0x000e85f4 beq r0,r0,0x000e8948
0x000e85f8 addu r2,r18,r0
0x000e85fc addi r2,r18,0x0001
0x000e8600 lw r3,-0x6de0(r28)
0x000e8604 addu r18,r2,r0
0x000e8608 addu r2,r2,r3
0x000e860c sb r21,0x066c(r2)
0x000e8610 jal 0x000e7484
0x000e8614 nop
0x000e8618 addu r22,r2,r0
0x000e861c addiu r16,r0,0x0002
0x000e8620 addiu r20,r0,0x0008
0x000e8624 beq r0,r0,0x000e8938
0x000e8628 addiu r19,r0,0x00d0
0x000e862c lui r2,0x8013
0x000e8630 addiu r2,r2,0xf344
0x000e8634 addu r2,r2,r20
0x000e8638 lw r2,0x0000(r2)
0x000e863c nop
0x000e8640 beq r2,r0,0x000e892c
0x000e8644 addu r3,r2,r0
0x000e8648 lb r2,0x0034(r3)
0x000e864c nop
0x000e8650 beq r2,r0,0x000e892c
0x000e8654 nop
0x000e8658 bne r16,r21,0x000e8678
0x000e865c nop
0x000e8660 sll r4,r16,0x10
0x000e8664 sra r4,r4,0x10
0x000e8668 jal 0x000e7d9c
0x000e866c addu r5,r0,r0
0x000e8670 beq r0,r0,0x000e8930
0x000e8674 addi r16,r16,0x0001
0x000e8678 lui r2,0x8015
0x000e867c addiu r2,r2,0x578d
0x000e8680 addu r2,r2,r19
0x000e8684 lb r2,0x0000(r2)
0x000e8688 nop
0x000e868c bne r2,r0,0x000e86a8
0x000e8690 nop
0x000e8694 lui r2,0x8015
0x000e8698 addiu r2,r2,0x578c
0x000e869c addu r2,r2,r19
0x000e86a0 beq r0,r0,0x000e892c
0x000e86a4 sb r0,0x0000(r2)
0x000e86a8 addiu r1,r0,0x0003
0x000e86ac bne r18,r1,0x000e86cc
0x000e86b0 nop
0x000e86b4 sll r4,r16,0x10
0x000e86b8 sra r4,r4,0x10
0x000e86bc jal 0x000e7d9c
0x000e86c0 addiu r5,r0,0x0001
0x000e86c4 beq r0,r0,0x000e8930
0x000e86c8 addi r16,r16,0x0001
0x000e86cc beq r22,r0,0x000e8788
0x000e86d0 nop
0x000e86d4 lui r1,0x8013
0x000e86d8 lw r4,-0x0cbc(r1)
0x000e86dc addiu r5,r29,0x0034
0x000e86e0 jal 0x000d3aec
0x000e86e4 addiu r6,r29,0x0035
0x000e86e8 lui r2,0x8013
0x000e86ec addiu r2,r2,0xf344
0x000e86f0 addu r2,r2,r20
0x000e86f4 lw r4,0x0000(r2)
0x000e86f8 addiu r5,r29,0x0036
0x000e86fc jal 0x000d3aec
0x000e8700 addiu r6,r29,0x0037
0x000e8704 lb r4,0x0034(r29)
0x000e8708 lb r5,0x0035(r29)
0x000e870c lb r6,0x0036(r29)
0x000e8710 lb r7,0x0037(r29)
0x000e8714 jal 0x000d3c70
0x000e8718 nop
0x000e871c beq r2,r0,0x000e873c
0x000e8720 nop
0x000e8724 sll r4,r16,0x10
0x000e8728 sra r4,r4,0x10
0x000e872c jal 0x000e7d9c
0x000e8730 addiu r5,r0,0x0001
0x000e8734 beq r0,r0,0x000e8930
0x000e8738 addi r16,r16,0x0001
0x000e873c lui r1,0x8013
0x000e8740 lw r4,-0x0cb8(r1)
0x000e8744 addiu r5,r29,0x0034
0x000e8748 jal 0x000d3aec
0x000e874c addiu r6,r29,0x0035
0x000e8750 lb r4,0x0034(r29)
0x000e8754 lb r5,0x0035(r29)
0x000e8758 lb r6,0x0036(r29)
0x000e875c lb r7,0x0037(r29)
0x000e8760 jal 0x000d3c70
0x000e8764 nop
0x000e8768 beq r2,r0,0x000e8788
0x000e876c nop
0x000e8770 sll r4,r16,0x10
0x000e8774 sra r4,r4,0x10
0x000e8778 jal 0x000e7d9c
0x000e877c addiu r5,r0,0x0001
0x000e8780 beq r0,r0,0x000e8930
0x000e8784 addi r16,r16,0x0001
0x000e8788 jal 0x000a36d4
0x000e878c addiu r4,r0,0x0064
0x000e8790 lui r1,0x8014
0x000e8794 lbu r7,-0x2b32(r1)
0x000e8798 addu r6,r0,r0
0x000e879c addu r5,r0,r0
0x000e87a0 beq r0,r0,0x000e87dc
0x000e87a4 addu r4,r0,r0
0x000e87a8 lui r3,0x8014
0x000e87ac addiu r3,r3,0xd474
0x000e87b0 addu r3,r3,r4
0x000e87b4 lbu r3,0x0000(r3)
0x000e87b8 addiu r1,r0,0x0023
0x000e87bc bne r3,r1,0x000e87c8
0x000e87c0 addu r8,r3,r0
0x000e87c4 addiu r5,r0,0x0001
0x000e87c8 addiu r1,r0,0x0024
0x000e87cc bne r8,r1,0x000e87d8
0x000e87d0 nop
0x000e87d4 addiu r6,r0,0x0001
0x000e87d8 addi r4,r4,0x0001
0x000e87dc slt r1,r4,r7
0x000e87e0 bne r1,r0,0x000e87a8
0x000e87e4 nop
0x000e87e8 addiu r1,r0,0x0001
0x000e87ec beq r5,r1,0x000e8800
0x000e87f0 nop
0x000e87f4 addiu r1,r0,0x0001
0x000e87f8 bne r6,r1,0x000e8818
0x000e87fc nop
0x000e8800 addiu r1,r0,0x0001
0x000e8804 bne r6,r1,0x000e8814
0x000e8808 nop
0x000e880c beq r0,r0,0x000e8818
0x000e8810 addi r2,r2,-0x0032
0x000e8814 addi r2,r2,0x0014
0x000e8818 lw r3,-0x6db0(r28)
0x000e881c nop
0x000e8820 beq r3,r0,0x000e882c
0x000e8824 nop
0x000e8828 addu r2,r0,r0
0x000e882c lui r1,0x8015
0x000e8830 addiu r3,r0,0x0001
0x000e8834 lw r4,0x57a8(r1)
0x000e8838 sll r17,r3,0x10
0x000e883c sll r3,r4,0x01
0x000e8840 add r3,r3,r4
0x000e8844 sll r3,r3,0x02
0x000e8848 add r3,r3,r4
0x000e884c sll r4,r3,0x02
0x000e8850 lui r3,0x8013
0x000e8854 addiu r3,r3,0xced0
0x000e8858 addu r4,r3,r4
0x000e885c lbu r5,0x0000(r4)
0x000e8860 sra r17,r17,0x10
0x000e8864 addiu r1,r0,0x00ff
0x000e8868 beq r5,r1,0x000e88f0
0x000e886c addu r4,r5,r0
0x000e8870 lui r5,0x8015
0x000e8874 addiu r5,r5,0x5758
0x000e8878 addu r5,r5,r19
0x000e887c lw r6,0x0000(r5)
0x000e8880 addi r4,r4,-0x0001
0x000e8884 sll r5,r6,0x01
0x000e8888 add r5,r5,r6
0x000e888c sll r5,r5,0x02
0x000e8890 add r5,r5,r6
0x000e8894 sll r5,r5,0x02
0x000e8898 addu r3,r3,r5
0x000e889c lbu r3,0x0000(r3)
0x000e88a0 nop
0x000e88a4 addi r5,r3,-0x0001
0x000e88a8 sll r3,r4,0x01
0x000e88ac add r4,r3,r4
0x000e88b0 lui r3,0x8013
0x000e88b4 addiu r3,r3,0xbb14
0x000e88b8 addu r3,r3,r4
0x000e88bc addu r3,r5,r3
0x000e88c0 lbu r3,0x0000(r3)
0x000e88c4 nop
0x000e88c8 slt r1,r2,r3
0x000e88cc beq r1,r0,0x000e891c
0x000e88d0 nop
0x000e88d4 addi r2,r18,0x0001
0x000e88d8 lw r3,-0x6de0(r28)
0x000e88dc addu r18,r2,r0
0x000e88e0 addu r2,r2,r3
0x000e88e4 sb r16,0x066c(r2)
0x000e88e8 beq r0,r0,0x000e891c
0x000e88ec addu r17,r0,r0
0x000e88f0 jal 0x000a36d4
0x000e88f4 addiu r4,r0,0x0064
0x000e88f8 slti r1,r2,0x0046
0x000e88fc beq r1,r0,0x000e891c
0x000e8900 nop
0x000e8904 addi r2,r18,0x0001
0x000e8908 lw r3,-0x6de0(r28)
0x000e890c addu r18,r2,r0
0x000e8910 addu r2,r2,r3
0x000e8914 sb r16,0x066c(r2)
0x000e8918 addu r17,r0,r0
0x000e891c sll r4,r16,0x10
0x000e8920 sra r4,r4,0x10
0x000e8924 jal 0x000e7d9c
0x000e8928 addu r5,r17,r0
0x000e892c addi r16,r16,0x0001
0x000e8930 addi r19,r19,0x0068
0x000e8934 addi r20,r20,0x0004
0x000e8938 slti r1,r16,0x000a
0x000e893c bne r1,r0,0x000e862c
0x000e8940 nop
0x000e8944 addu r2,r18,r0
0x000e8948 lw r31,0x002c(r29)
0x000e894c lw r22,0x0028(r29)
0x000e8950 lw r21,0x0024(r29)
0x000e8954 lw r20,0x0020(r29)
0x000e8958 lw r19,0x001c(r29)
0x000e895c lw r18,0x0018(r29)
0x000e8960 lw r17,0x0014(r29)
0x000e8964 lw r16,0x0010(r29)
0x000e8968 jr r31
0x000e896c addiu r29,r29,0x0038
