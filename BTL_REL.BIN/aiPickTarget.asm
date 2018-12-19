void aiPickTarget(entityPtr, combatPtr, currentTarget, value) {
  partnerEntityPtr = load(0x12F348)
  combatHead = load(0x134D4C)
  
  if(value != 0 || entityPtr != partnerEntityPtr) {
    if(currentTarget == -1) {
      store(combatPtr + 0x37, 0)
      return
    }
    
    if(partnerEntityPtr != entityPtr) {
      npcId = getNPCId(entityPtr)
      unknownValue = load(0x15588A + npcId * 0x68) // unknown value
      
      if(unknownValue == 1 || random(100) < 70) {
        store(combatPtr + 0x37, 0)
        return
      }
    }
    
    if(hasZeroHP(currentTarget) == 0)
      return
      
    flags = load(combatPtr + 0x34) | 0x0400 // set unknown flag
    
    store(combatPtr + 0x34, flags)
    store(combatPtr + 0x37, currentTarget)
    return
  }
  
  command = load(combatPtr + 0x064E) // command
  
  // change command, alive target
  if(command == 7 && currentTarget != -1 && !hasZeroHP(currentTarget))
    return
  
  brains = load(entityPtr + 0x3E)
  
  if(brains >= 300) {
    enemyArray, enemyCount = getStatusedEnemies(entityPtr)
    
    if(enemyCount > 0) {
      enemyId = enemyArray[random(enemyCount)]
      store(combatPtr + 0x37, enemyId)
      return
    }
    
    lastScore, bestEntity = getWeakestEnemy(entityPtr, combatPtr)
    
    if(currentTarget == -1 || hasZeroHP(currentTarget) == 1) {
      store(combatPtr + 0x37, bestEntity)
      return
    }
    
    if(bestEntity == -1)
      return
    
    entityId = load(combatHead + 0x066C + currentTarget)
    enemyScore = getWeaknessScore(entityPtr, load(0x12F344 + entityId * 4))
    
    if(enemyScore - lastScore < 40)
      store(combatPtr + 0x37, bestEntity)
  }
  else if(brains >= 150) {
    if(currentTarget != -1 && hasZeroHP(currentTarget) == 0)
      return
    
    lastScore, bestEntity = getWeakestEnemy(entityPtr, combatPtr)
    store(combatPtr + 0x37, bestEntity)
  }
  else {
    hostileMap = new int[4]
    for(i = 0; i < load(0x134D6C); i++)
      hostileMap[i] = 1
    
    closestEnemy = getClosestEnemy(entityPtr, hostileMap)
    store(combatPtr + 0x37, closestEnemy)
  }
}

0x0005fea4 addiu r29,r29,0xffc8
0x0005fea8 sw r31,0x001c(r29)
0x0005feac sw r18,0x0018(r29)
0x0005feb0 sw r17,0x0014(r29)
0x0005feb4 sw r16,0x0010(r29)
0x0005feb8 addu r16,r4,r0
0x0005febc addu r17,r5,r0
0x0005fec0 beq r7,r0,0x0005fedc
0x0005fec4 addu r18,r6,r0
0x0005fec8 lui r1,0x8013
0x0005fecc lw r2,-0x0cb8(r1)
0x0005fed0 nop
0x0005fed4 beq r16,r2,0x0005fef0
0x0005fed8 nop
0x0005fedc lui r1,0x8013
0x0005fee0 lw r2,-0x0cb8(r1)
0x0005fee4 nop
0x0005fee8 beq r16,r2,0x0005ff94
0x0005feec nop
0x0005fef0 addiu r1,r0,0x00ff
0x0005fef4 beq r18,r1,0x0005ff8c
0x0005fef8 nop
0x0005fefc lui r1,0x8013
0x0005ff00 lw r2,-0x0cb8(r1)
0x0005ff04 nop
0x0005ff08 beq r16,r2,0x0005ff64
0x0005ff0c nop
0x0005ff10 jal 0x0005f4c4
0x0005ff14 addu r4,r16,r0
0x0005ff18 sll r3,r2,0x01
0x0005ff1c add r3,r3,r2
0x0005ff20 sll r3,r3,0x02
0x0005ff24 add r2,r3,r2
0x0005ff28 sll r3,r2,0x03
0x0005ff2c lui r2,0x8015
0x0005ff30 addiu r2,r2,0x588a
0x0005ff34 addu r2,r2,r3
0x0005ff38 lbu r2,0x0000(r2)
0x0005ff3c addiu r1,r0,0x0001
0x0005ff40 beq r2,r1,0x0005ff5c
0x0005ff44 nop
0x0005ff48 jal 0x000a36d4
0x0005ff4c addiu r4,r0,0x0064
0x0005ff50 slti r1,r2,0x0047
0x0005ff54 bne r1,r0,0x0005ff64
0x0005ff58 nop
0x0005ff5c beq r0,r0,0x00060194
0x0005ff60 sb r0,0x0037(r17)
0x0005ff64 jal 0x000601ac
0x0005ff68 addu r4,r18,r0
0x0005ff6c bne r2,r0,0x00060194
0x0005ff70 nop
0x0005ff74 lhu r2,0x0034(r17)
0x0005ff78 nop
0x0005ff7c ori r2,r2,0x0400
0x0005ff80 sh r2,0x0034(r17)
0x0005ff84 beq r0,r0,0x00060194
0x0005ff88 sb r18,0x0037(r17)
0x0005ff8c beq r0,r0,0x00060194
0x0005ff90 sb r0,0x0037(r17)
0x0005ff94 lw r2,-0x6de0(r28)
0x0005ff98 addiu r1,r0,0x0007
0x0005ff9c lbu r2,0x064e(r2)
0x0005ffa0 nop
0x0005ffa4 bne r2,r1,0x0005ffcc
0x0005ffa8 nop
0x0005ffac lbu r2,0x0037(r17)
0x0005ffb0 addiu r1,r0,0x00ff
0x0005ffb4 beq r2,r1,0x0005ffcc
0x0005ffb8 addu r4,r2,r0
0x0005ffbc jal 0x000601ac
0x0005ffc0 nop
0x0005ffc4 beq r2,r0,0x00060194
0x0005ffc8 nop
0x0005ffcc lh r6,-0x6dc0(r28)
0x0005ffd0 addu r4,r0,r0
0x0005ffd4 addu r5,r0,r0
0x0005ffd8 beq r0,r0,0x0005fff4
0x0005ffdc addu r7,r6,r0
0x0005ffe0 addu r2,r29,r5
0x0005ffe4 addiu r3,r0,0xffff
0x0005ffe8 sh r3,0x0020(r2)
0x0005ffec addi r4,r4,0x0001
0x0005fff0 addi r5,r5,0x0002
0x0005fff4 slt r1,r6,r4
0x0005fff8 beq r1,r0,0x0005ffe0
0x0005fffc nop
0x00060000 lh r2,0x003e(r16)
0x00060004 nop
0x00060008 slti r1,r2,0x012c
0x0006000c bne r1,r0,0x00060110
0x00060010 nop
0x00060014 addu r4,r16,r0
0x00060018 addiu r5,r29,0x0020
0x0006001c jal 0x0005f51c
0x00060020 addiu r6,r29,0x0036
0x00060024 lh r4,0x0036(r29)
0x00060028 nop
0x0006002c slti r1,r4,0x0002
0x00060030 bne r1,r0,0x00060054
0x00060034 nop
0x00060038 jal 0x000a36d4
0x0006003c nop
0x00060040 sll r2,r2,0x01
0x00060044 addu r2,r29,r2
0x00060048 lh r2,0x0020(r2)
0x0006004c beq r0,r0,0x00060194
0x00060050 sb r2,0x0037(r17)
0x00060054 addiu r1,r0,0x0001
0x00060058 bne r4,r1,0x0006006c
0x0006005c addu r4,r16,r0
0x00060060 lh r2,0x0020(r29)
0x00060064 beq r0,r0,0x00060194
0x00060068 sb r2,0x0037(r17)
0x0006006c addu r5,r17,r0
0x00060070 addiu r6,r29,0x0032
0x00060074 jal 0x0005f61c
0x00060078 addiu r7,r29,0x0034
0x0006007c lbu r2,0x0037(r17)
0x00060080 addiu r1,r0,0x00ff
0x00060084 beq r2,r1,0x0006009c
0x00060088 addu r4,r2,r0
0x0006008c jal 0x000601ac
0x00060090 nop
0x00060094 beq r2,r0,0x000600a8
0x00060098 nop
0x0006009c lh r2,0x0034(r29)
0x000600a0 beq r0,r0,0x00060194
0x000600a4 sb r2,0x0037(r17)
0x000600a8 lbu r3,0x0037(r17)
0x000600ac lw r2,-0x6de0(r28)
0x000600b0 nop
0x000600b4 addu r2,r2,r3
0x000600b8 lbu r2,0x066c(r2)
0x000600bc nop
0x000600c0 sll r3,r2,0x02
0x000600c4 lui r2,0x8013
0x000600c8 addiu r2,r2,0xf344
0x000600cc addu r2,r2,r3
0x000600d0 lw r5,0x0000(r2)
0x000600d4 jal 0x0005f764
0x000600d8 addu r4,r16,r0
0x000600dc sll r4,r2,0x10
0x000600e0 lh r3,0x0034(r29)
0x000600e4 addiu r1,r0,0x00ff
0x000600e8 beq r3,r1,0x00060194
0x000600ec sra r4,r4,0x10
0x000600f0 lh r2,0x0032(r29)
0x000600f4 nop
0x000600f8 sub r2,r4,r2
0x000600fc slti r1,r2,0x0028
0x00060100 bne r1,r0,0x00060194
0x00060104 nop
0x00060108 beq r0,r0,0x00060194
0x0006010c sb r3,0x0037(r17)
0x00060110 slti r1,r2,0x0096
0x00060114 bne r1,r0,0x0006015c
0x00060118 addu r4,r0,r0
0x0006011c lbu r2,0x0037(r17)
0x00060120 addiu r1,r0,0x00ff
0x00060124 beq r2,r1,0x0006013c
0x00060128 addu r4,r2,r0
0x0006012c jal 0x000601ac
0x00060130 nop
0x00060134 beq r2,r0,0x00060194
0x00060138 nop
0x0006013c addu r4,r16,r0
0x00060140 addu r5,r17,r0
0x00060144 addiu r6,r29,0x0032
0x00060148 jal 0x0005f61c
0x0006014c addiu r7,r29,0x0034
0x00060150 lh r2,0x0034(r29)
0x00060154 beq r0,r0,0x00060194
0x00060158 sb r2,0x0037(r17)
0x0006015c beq r0,r0,0x00060178
0x00060160 addu r5,r0,r0
0x00060164 addu r2,r29,r5
0x00060168 addiu r3,r0,0x0001
0x0006016c sh r3,0x0028(r2)
0x00060170 addi r4,r4,0x0001
0x00060174 addi r5,r5,0x0002
0x00060178 slt r1,r7,r4
0x0006017c beq r1,r0,0x00060164
0x00060180 nop
0x00060184 addu r4,r16,r0
0x00060188 jal 0x00060218
0x0006018c addiu r5,r29,0x0028
0x00060190 sb r2,0x0037(r17)
0x00060194 lw r31,0x001c(r29)
0x00060198 lw r18,0x0018(r29)
0x0006019c lw r17,0x0014(r29)
0x000601a0 lw r16,0x0010(r29)
0x000601a4 jr r31
0x000601a8 addiu r29,r29,0x0038