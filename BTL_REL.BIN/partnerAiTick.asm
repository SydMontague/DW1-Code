void partnerAiTick() {
  combatPtr = load(0x134D4C) // 0x13D640
  entityPtr = load(0x12F348)
  statsPtr = entityPtr + 0x38
  statusFlagPtr = combatPtr + 0x34
  
  // Update Command Procedure
  unkTimer = load(combatPtr + 0x64A) // timer that prevents command updates, set points unknown
  
  if(unkTimer == 0) {
    newCommand = load(combatPtr + 0x650)
    store(combatPtr + 0x64E, newCommand)
  } 
  else {
    flags = load(statusFlagPtr) & 0x800E // confused, stunned, flattened, dead
    flattenedTimer = load(combatPtr + 0x22)
    
    if(flags == 0 && flattenedTimer == 0)
      store(combatPtr + 0x64A, unkTimer - 1)
  }
  
  // "Dumb" status code
  noAiFlag = load(0x134D74) // no AI flag?
  if(noAiFlag != 0) {
    currentHP = load(statsPtr + 0x14)
    remainingDamage = load(combatPtr + 0x2E)
    brains = load(statsPtr + 0x06)
    checkInterval = (brains / 2 + 1) * 20
    frameCount = load(0x134D66)
    discipline = load(0x138488) // discipline
    
    if(remainingDamage < currentHP 
      && brains < 301 
      && frameCount % checkInterval == 0
      && random(100) < 70 - discipline) {
        
      flags = load(statusFlagPtr) | 0x2000 // set dumb flag
      store(statusFlagPtr, flags)
      store(combatPtr + 0x2A, 100) // set dumb timer
    }
    //0x00057cf0
    cooldown = load(combatPtr + 0x28)
    if(cooldown >= 2)
      store(combatPtr + 0x28, cooldown - 1)
    
    flags = load(statusFlagPtr) & 0x2000
    
    if(flags == 0) // if not stupid
      increaseSpeedBuffer(combatPtr, statsPtr)
  }
  
  flags = load(statusFlagPtr) & 0x80B0
  if(flags != 0) // is knocked back, attacking, blocking, or dead
    return
  
  if(load(statsPtr + 0x14) == 0) { // current HP
    handleDeath(entityPtr, combatPtr, 0)
    return
  }
  
  enemyList, enemyCount = getRemainingEnemies(entityPtr)
  
  if(enemyCount == 0) {
    flags = load(statusFlagPtr)
    handleBattleIdle(entityPtr, statsPtr, flags)
    
    store(combatPtr + 0x36, -1)
    resetFlatten(0)
    removeEffectSprites(entityPtr, combatPtr)
    
    store(statusFlagPtr, 0x0040)
    return
  }
  
  if(noAiFlag != 0)
    return
  
  flags = load(statusFlagPtr) & 0x800E // confused, stunned, flattened, dead
  flattenTimer = load(combatPtr + 0x22)
  
  if(flags == 0 && flattenTimer == 0) {
    r3 = load(combatPtr + 0x64E) - 7 // command
    
    switch(r3) {
      default: break; // when r3 > 4
      case 0: // 0x57E40, change command
      
        currentTarget = load(combatPtr + 0x37)
        if(currentTarget == 0x00FF)
          break;
        
        if(load(combatPtr + 0x674) != 1) // should change target
          break;
        
        if(enemyCount == 2) {
          if(currentTarget == enemyList[0]) 
            store(combatPtr + 0x37, enemyList[1]) //load(sp + 0x2C)
          else
            store(combatPtr + 0x37, enemyList[0])
        }
        else if(enemyCount == 3) {
          if(load(combatPtr + 0x671) == 0x00FF && load(combatPtr + 0x672) == 0x00FF) {
            hostileMap = { 1, 1, 1 ,1 }
            
            closestEnemy = getClosestEnemy(entityPtr, hostileMap)
            store(combatPtr + 0x37, closestEnemy)
            
            r2 = load(combatPtr + 0x673)
            store(combatPtr + 0x671 + r2, closestEnemy)
            store(combatPtr + 0x673, r2 ^ 1)
          }
          else {
            selectedTarget = 1
            for(; selectedTarget < 4; i++) {
              
              if(selectedTarget == currentTarget)
                continue
              
              previousTarget = load(combatPtr + 0x671 + load(combatPtr + 0x673) ^ 1)
                
              if(selectedTarget != previousTarget)
                break
            }
              
            store(combatPtr + 0x671 + load(combatPtr + 0x673), currentTarget)
            store(combatPtr + 0x673, load(combatPtr + 0x673) ^ 1)
            store(combatPtr + 0x37, selectedTarget)
          }
        }
        
        store(combatPtr + 0x674, 0)
        return;
      case 1:
      case 2:
      case 3: // 0x57FB4, attack 1-3 command
        if(getMPCost(entityPtr, combatPtr, r3 - 1) == 0)
          break
        
        currentTarget = load(combatPtr + 0x37)
        if(currentTarget != -1 && hasZeroHP(currentTarget))
          aiPickTarget(entityPtr, combatPtr, currentTarget, 0)
        
        attackId = load(combatPtr + 0x64E) - 8 // command
        animId = load(entityPtr + 0x44 + attackId)
        activeAnimId = load(combatPtr + 0x38)
        
        if(animId != activeAnimId || load(combatPtr + 0x36) <= 0)
          setMoveAnim(entityPtr, combatPtr, 0, attackId)
        
        activeMoveId = load(combatPtr + 0x38) - 0x2E // gets changed by previous call
        digimonType = load(entityPtr)
        
        techId = load(0x12CED7 + digimonType * 0x34 + activeMoveId)
        
        setChargeupFlag(entityPtr, combatPtr, techId)
        return
      case 4: // 0x580A4, finisher command
        currentTarget = load(combatPtr + 0x37)
        
        if(currentTarget != 0 && hasZeroHP(currentTarget))
          aiPickTarget(entityPtr, combatPtr, currentTarget, 0)
        
        finisherMove = load(entityPtr + 0x47)
        activeAnimId = load(combatPtr + 0x38)
        activeRange = load(combatPtr + 0x36)
        
        if(finisherMove != activeAnimId || activeRange <= 0)
          setMoveAnim(entityPtr, combatPtr, 0, 3)
        
        return
    }
    
    command = load(combatPtr + 0x64E)
    if(command != 2 && command != 4) {
      aiMode = load(0x135078)
      store(entityPtr + 0x56, aiMode)
    }
  }
  
  //0x58148, randomly change target every 5 seconds when flattened
  if(load(statusFlagPtr) & 0x0008 != 0 && load(0x134D66) % 100 == 0) 
    store(combatPtr + 0x37, enemyList[random(enemyCount)])
  
  //0x58194, stop if this flag is set
  if(load(statusFlagPtr) & 0x0040 != 0)
    return
  
  command = load(combatPtr + 0x64E)
  
  if(command == 1) { // running away
    store(combatPtr + 0x36, 1)
    flags = load(statusFlagPtr) | 0x0040
    store(statusFlagPtr, flags)
  }
  
  flags = load(statusFlagPtr)
  
  if(flags & 0x0008 != 0) { // flattened
    aiPickTarget(entityPtr, combatPtr, load(combatPtr + 0x37), 0)
    flags = load(statusFlagPtr) // flags get changed by aiPickTarget
    
    store(entityPtr + 0x36, 0) // flatten sprite
    
    store(combatPtr + 0x38, 0)
    store(combatPtr + 0x36, 2) // range
    store(combatPtr + 0x34, flags | 0x0040)
    return
  }
  
  if(flags & 0x0004 != 0) // stunned
    return
  
  if(flags & 0x0002 != 0) { // confused
    handleConfusion(entityPtr, combatPtr, 0)
    return
  }
  
  if(flags & 0x0800 != 0) // is on chargeup
    return
  
  if(flags & 0x1000 != 0) // is on cooldown
    return
  
  if(flags & 0x2000 != 0) // is in dumb state
    return
  
  if(flags & 0x0400 == 0) { // is in unknown state
    currentTarget = load(combatPtr + 0x37)
    aiPickTarget(entityPtr, combatPtr, currentTarget, 0)
  }
  
  command = load(combatPtr + 0x64E)
  selectedMove = -1
  
  if(command == 2) { // attack command
    moveArray = short[4]
    hasMove = hasAffordableMoves(moveArray, 0)
    
    if(hasMove == 0) { // set cooldown
      store(combatPtr + 0x28, 0x50)
      flags = load(combatPtr + 0x34) | 0x0800
      store(combatPtr + 0x34, flags)
      return
    }
    
    selectedMove = getMoveCommandAttack(0, moveArray)
    store(entityPtr + 0x56, 0)
  }
  else if(command == 4) { // moderate command
    moveArray = short[4]
    hasMove = hasAffordableMoves(moveArray, 0)
    
    if(hasMove == 0) { // set cooldown
      store(combatPtr + 0x28, 0x50)
      flags = load(combatPtr + 0x34) | 0x0800
      store(combatPtr + 0x34, flags)
      return
    }
    
    selectedMove = getMoveCommandModerate(0, moveArray)
    store(entityPtr + 0x56, 2)
  }
  
  if(selectedMove == -1)
    partnerYourCallSelectMove(entityPtr, combatPtr, 0)
  else
    setMoveAnim(entityPtr, combatPtr, 0, selectedMove)
}

0x00057bd0 addiu r29,r29,0xffb8
0x00057bd4 sw r31,0x0024(r29)
0x00057bd8 sw r20,0x0020(r29)
0x00057bdc sw r19,0x001c(r29)
0x00057be0 sw r18,0x0018(r29)
0x00057be4 sw r17,0x0014(r29)
0x00057be8 sw r16,0x0010(r29)
0x00057bec lw r16,-0x6de0(r28)
0x00057bf0 lui r1,0x8013
0x00057bf4 addu r4,r16,r0
0x00057bf8 lw r17,-0x0cb8(r1)
0x00057bfc lh r3,0x064a(r4)
0x00057c00 addiu r19,r17,0x0038
0x00057c04 bne r3,r0,0x00057c18
0x00057c08 addiu r18,r4,0x0034
0x00057c0c lbu r2,0x0650(r4)
0x00057c10 beq r0,r0,0x00057c44
0x00057c14 sb r2,0x064e(r4)
0x00057c18 lhu r2,0x0000(r18)
0x00057c1c nop
0x00057c20 andi r2,r2,0x800e
0x00057c24 bne r2,r0,0x00057c44
0x00057c28 nop
0x00057c2c lh r2,0x0022(r16)
0x00057c30 nop
0x00057c34 bne r2,r0,0x00057c44
0x00057c38 nop
0x00057c3c addi r2,r3,-0x0001
0x00057c40 sh r2,0x064a(r4)
0x00057c44 lw r2,-0x6db8(r28)
0x00057c48 nop
0x00057c4c bne r2,r0,0x00057d2c
0x00057c50 nop
0x00057c54 lh r3,0x0014(r19)
0x00057c58 lh r2,0x002e(r16)
0x00057c5c nop
0x00057c60 slt r1,r2,r3
0x00057c64 beq r1,r0,0x00057cf0
0x00057c68 nop
0x00057c6c lh r2,0x0006(r19)
0x00057c70 nop
0x00057c74 slti r1,r2,0x012d
0x00057c78 beq r1,r0,0x00057cf0
0x00057c7c addu r3,r2,r0
0x00057c80 bgez r3,0x00057c90
0x00057c84 sra r25,r3,0x01
0x00057c88 addiu r2,r3,0x0001
0x00057c8c sra r25,r2,0x01
0x00057c90 addi r3,r25,0x0001
0x00057c94 sll r2,r3,0x02
0x00057c98 add r3,r2,r3
0x00057c9c lh r2,-0x6dc6(r28)
0x00057ca0 sll r3,r3,0x02
0x00057ca4 div r2,r3
0x00057ca8 mfhi r2
0x00057cac bne r2,r0,0x00057cf0
0x00057cb0 nop
0x00057cb4 lui r1,0x8014
0x00057cb8 lh r3,-0x7b78(r1)
0x00057cbc addiu r2,r0,0x0046
0x00057cc0 sub r20,r2,r3
0x00057cc4 jal 0x000a36d4
0x00057cc8 addiu r4,r0,0x0064
0x00057ccc slt r1,r2,r20
0x00057cd0 beq r1,r0,0x00057cf0
0x00057cd4 nop
0x00057cd8 lhu r2,0x0000(r18)
0x00057cdc nop
0x00057ce0 ori r2,r2,0x2000
0x00057ce4 sh r2,0x0000(r18)
0x00057ce8 addiu r2,r0,0x0064
0x00057cec sh r2,0x002a(r16)
0x00057cf0 lh r2,0x0028(r16)
0x00057cf4 nop
0x00057cf8 slti r1,r2,0x0002
0x00057cfc bne r1,r0,0x00057d0c
0x00057d00 nop
0x00057d04 addi r2,r2,-0x0001
0x00057d08 sh r2,0x0028(r16)
0x00057d0c lhu r2,0x0000(r18)
0x00057d10 nop
0x00057d14 andi r2,r2,0x2000
0x00057d18 bne r2,r0,0x00057d2c
0x00057d1c nop
0x00057d20 addu r4,r16,r0
0x00057d24 jal 0x0005af44
0x00057d28 addu r5,r19,r0
0x00057d2c lhu r2,0x0000(r18)
0x00057d30 nop
0x00057d34 andi r2,r2,0x80b0
0x00057d38 bne r2,r0,0x00058374
0x00057d3c nop
0x00057d40 lh r2,0x0014(r19)
0x00057d44 nop
0x00057d48 bne r2,r0,0x00057d68
0x00057d4c addu r4,r17,r0
0x00057d50 addu r4,r17,r0
0x00057d54 addu r5,r16,r0
0x00057d58 jal 0x0005afd8
0x00057d5c addu r6,r0,r0
0x00057d60 beq r0,r0,0x00058378
0x00057d64 lw r31,0x0024(r29)
0x00057d68 addiu r5,r29,0x002c
0x00057d6c jal 0x0005fce8
0x00057d70 addiu r6,r29,0x0046
0x00057d74 lh r5,0x0046(r29)
0x00057d78 nop
0x00057d7c bne r5,r0,0x00057dc8
0x00057d80 nop
0x00057d84 lhu r6,0x0000(r18)
0x00057d88 addu r4,r17,r0
0x00057d8c jal 0x000e7d40
0x00057d90 addu r5,r19,r0
0x00057d94 addiu r2,r0,0xffff
0x00057d98 sb r2,0x0036(r16)
0x00057d9c jal 0x00059078
0x00057da0 addu r4,r0,r0
0x00057da4 addu r4,r17,r0
0x00057da8 jal 0x0005ec7c
0x00057dac addu r5,r16,r0
0x00057db0 sh r0,0x0000(r18)
0x00057db4 lhu r2,0x0000(r18)
0x00057db8 nop
0x00057dbc ori r2,r2,0x0040
0x00057dc0 beq r0,r0,0x00058374
0x00057dc4 sh r2,0x0000(r18)
0x00057dc8 lw r2,-0x6db8(r28)
0x00057dcc nop
0x00057dd0 bne r2,r0,0x00058374
0x00057dd4 nop
0x00057dd8 lhu r2,0x0000(r18)
0x00057ddc nop
0x00057de0 andi r2,r2,0x800e
0x00057de4 bne r2,r0,0x00058148
0x00057de8 nop
0x00057dec lh r2,0x0022(r16)
0x00057df0 nop
0x00057df4 bne r2,r0,0x00058148
0x00057df8 nop
0x00057dfc lw r2,-0x6de0(r28)
0x00057e00 nop
0x00057e04 lbu r3,0x064e(r2)
0x00057e08 nop
0x00057e0c addu r6,r3,r0
0x00057e10 addi r3,r3,-0x0007
0x00057e14 sltiu r1,r3,0x0005
0x00057e18 beq r1,r0,0x00058118
0x00057e1c nop
0x00057e20 lui r4,0x8007
0x00057e24 addiu r4,r4,0x2d60
0x00057e28 sll r3,r3,0x02
0x00057e2c addu r3,r3,r4
0x00057e30 lw r3,0x0000(r3)
0x00057e34 nop
0x00057e38 jr r3
0x00057e3c nop
0x00057e40 lbu r4,0x0037(r16)
0x00057e44 addiu r1,r0,0x00ff
0x00057e48 beq r4,r1,0x00058118
0x00057e4c addu r3,r4,r0
0x00057e50 lbu r4,0x0674(r2)
0x00057e54 addiu r1,r0,0x0001
0x00057e58 bne r4,r1,0x00058118
0x00057e5c nop
0x00057e60 addiu r1,r0,0x0003
0x00057e64 beq r5,r1,0x00057e9c
0x00057e68 nop
0x00057e6c addiu r1,r0,0x0002
0x00057e70 bne r5,r1,0x00057fa8
0x00057e74 nop
0x00057e78 lh r2,0x002c(r29)
0x00057e7c nop
0x00057e80 bne r3,r2,0x00057e94
0x00057e84 nop
0x00057e88 lh r2,0x002e(r29)
0x00057e8c beq r0,r0,0x00057fa8
0x00057e90 sb r2,0x0037(r16)
0x00057e94 beq r0,r0,0x00057fa8
0x00057e98 sb r2,0x0037(r16)
0x00057e9c lbu r4,0x0671(r2)
0x00057ea0 addiu r1,r0,0x00ff
0x00057ea4 bne r4,r1,0x00057f30
0x00057ea8 nop
0x00057eac lbu r4,0x0672(r2)
0x00057eb0 addiu r1,r0,0x00ff
0x00057eb4 bne r4,r1,0x00057f30
0x00057eb8 nop
0x00057ebc addiu r5,r0,0x0001
0x00057ec0 beq r0,r0,0x00057edc
0x00057ec4 addiu r4,r0,0x0002
0x00057ec8 addu r2,r29,r4
0x00057ecc addiu r3,r0,0x0001
0x00057ed0 sh r3,0x003c(r2)
0x00057ed4 addi r5,r5,0x0001
0x00057ed8 addi r4,r4,0x0002
0x00057edc slti r1,r5,0x0004
0x00057ee0 bne r1,r0,0x00057ec8
0x00057ee4 nop
0x00057ee8 addu r4,r17,r0
0x00057eec jal 0x00060218
0x00057ef0 addiu r5,r29,0x003c
0x00057ef4 sb r2,0x0037(r16)
0x00057ef8 lw r4,-0x6de0(r28)
0x00057efc lbu r3,0x0037(r16)
0x00057f00 lbu r2,0x0673(r4)
0x00057f04 nop
0x00057f08 addu r2,r2,r4
0x00057f0c sb r3,0x0671(r2)
0x00057f10 lw r3,-0x6de0(r28)
0x00057f14 nop
0x00057f18 lbu r2,0x0673(r3)
0x00057f1c nop
0x00057f20 addi r2,r2,0x0001
0x00057f24 andi r2,r2,0x0001
0x00057f28 beq r0,r0,0x00057fa8
0x00057f2c sb r2,0x0673(r3)
0x00057f30 lw r6,-0x6de0(r28)
0x00057f34 beq r0,r0,0x00057f6c
0x00057f38 addiu r5,r0,0x0001
0x00057f3c beq r3,r5,0x00057f68
0x00057f40 nop
0x00057f44 lbu r4,0x0673(r6)
0x00057f48 nop
0x00057f4c addi r4,r4,0x0001
0x00057f50 andi r4,r4,0x0001
0x00057f54 addu r4,r4,r6
0x00057f58 lbu r4,0x0671(r4)
0x00057f5c nop
0x00057f60 bne r4,r5,0x00057f78
0x00057f64 nop
0x00057f68 addi r5,r5,0x0001
0x00057f6c slti r1,r5,0x0004
0x00057f70 bne r1,r0,0x00057f3c
0x00057f74 nop
0x00057f78 lbu r4,0x0673(r2)
0x00057f7c nop
0x00057f80 addu r2,r4,r2
0x00057f84 sb r3,0x0671(r2)
0x00057f88 lw r3,-0x6de0(r28)
0x00057f8c nop
0x00057f90 lbu r2,0x0673(r3)
0x00057f94 nop
0x00057f98 addi r2,r2,0x0001
0x00057f9c andi r2,r2,0x0001
0x00057fa0 sb r2,0x0673(r3)
0x00057fa4 sb r5,0x0037(r16)
0x00057fa8 lw r2,-0x6de0(r28)
0x00057fac beq r0,r0,0x00058374
0x00057fb0 sb r0,0x0674(r2)
0x00057fb4 addi r2,r6,-0x0008
0x00057fb8 sll r6,r2,0x10
0x00057fbc sra r6,r6,0x10
0x00057fc0 addu r4,r17,r0
0x00057fc4 jal 0x0005d374
0x00057fc8 addu r5,r16,r0
0x00057fcc beq r2,r0,0x00058118
0x00057fd0 nop
0x00057fd4 lbu r2,0x0037(r16)
0x00057fd8 addiu r1,r0,0x00ff
0x00057fdc beq r2,r1,0x00058008
0x00057fe0 addu r4,r2,r0
0x00057fe4 jal 0x000601ac
0x00057fe8 nop
0x00057fec beq r2,r0,0x00058008
0x00057ff0 nop
0x00057ff4 lbu r6,0x0037(r16)
0x00057ff8 addu r4,r17,r0
0x00057ffc addu r5,r16,r0
0x00058000 jal 0x0005fea4
0x00058004 addu r7,r0,r0
0x00058008 lw r2,-0x6de0(r28)
0x0005800c nop
0x00058010 lbu r2,0x064e(r2)
0x00058014 nop
0x00058018 addi r2,r2,-0x0008
0x0005801c addu r4,r2,r0
0x00058020 addu r2,r2,r17
0x00058024 lbu r3,0x0044(r2)
0x00058028 lbu r2,0x0038(r16)
0x0005802c nop
0x00058030 bne r3,r2,0x00058048
0x00058034 nop
0x00058038 lb r2,0x0036(r16)
0x0005803c nop
0x00058040 bgtz r2,0x0005805c
0x00058044 nop
0x00058048 andi r7,r4,0x00ff
0x0005804c addu r4,r17,r0
0x00058050 addu r5,r16,r0
0x00058054 jal 0x0005d658
0x00058058 addu r6,r0,r0
0x0005805c lbu r2,0x0038(r16)
0x00058060 lw r3,0x0000(r17)
0x00058064 addi r4,r2,-0x002e
0x00058068 sll r2,r3,0x01
0x0005806c add r2,r2,r3
0x00058070 sll r2,r2,0x02
0x00058074 add r2,r2,r3
0x00058078 sll r3,r2,0x02
0x0005807c lui r2,0x8013
0x00058080 addiu r2,r2,0xceb4
0x00058084 addu r2,r2,r3
0x00058088 addu r2,r4,r2
0x0005808c lbu r6,0x0023(r2)
0x00058090 addu r4,r17,r0
0x00058094 jal 0x0005d6e0
0x00058098 addu r5,r16,r0
0x0005809c beq r0,r0,0x00058378
0x000580a0 lw r31,0x0024(r29)
0x000580a4 lbu r2,0x0037(r16)
0x000580a8 nop
0x000580ac beq r2,r0,0x000580d8
0x000580b0 addu r4,r2,r0
0x000580b4 jal 0x000601ac
0x000580b8 nop
0x000580bc beq r2,r0,0x000580d8
0x000580c0 nop
0x000580c4 lbu r6,0x0037(r16)
0x000580c8 addu r4,r17,r0
0x000580cc addu r5,r16,r0
0x000580d0 jal 0x0005fea4
0x000580d4 addu r7,r0,r0
0x000580d8 lbu r3,0x0047(r17)
0x000580dc lbu r2,0x0038(r16)
0x000580e0 nop
0x000580e4 bne r3,r2,0x000580fc
0x000580e8 nop
0x000580ec lb r2,0x0036(r16)
0x000580f0 nop
0x000580f4 bgtz r2,0x00058374
0x000580f8 nop
0x000580fc addu r4,r17,r0
0x00058100 addu r5,r16,r0
0x00058104 addu r6,r0,r0
0x00058108 jal 0x0005d658
0x0005810c addiu r7,r0,0x0003
0x00058110 beq r0,r0,0x00058378
0x00058114 lw r31,0x0024(r29)
0x00058118 lw r2,-0x6de0(r28)
0x0005811c addiu r1,r0,0x0002
0x00058120 lbu r2,0x064e(r2)
0x00058124 nop
0x00058128 beq r2,r1,0x00058148
0x0005812c addu r3,r2,r0
0x00058130 addiu r1,r0,0x0004
0x00058134 beq r3,r1,0x00058148
0x00058138 nop
0x0005813c lbu r2,-0x6ab4(r28)
0x00058140 nop
0x00058144 sb r2,0x0056(r17)
0x00058148 lhu r2,0x0000(r18)
0x0005814c nop
0x00058150 andi r2,r2,0x0008
0x00058154 beq r2,r0,0x00058194
0x00058158 nop
0x0005815c lh r3,-0x6dc6(r28)
0x00058160 addiu r2,r0,0x0064
0x00058164 div r3,r2
0x00058168 mfhi r2
0x0005816c bne r2,r0,0x00058194
0x00058170 nop
0x00058174 lh r4,0x0046(r29)
0x00058178 jal 0x000a36d4
0x0005817c nop
0x00058180 sll r2,r2,0x01
0x00058184 addu r2,r29,r2
0x00058188 lh r2,0x002c(r2)
0x0005818c nop
0x00058190 sb r2,0x0037(r16)
0x00058194 lhu r2,0x0000(r18)
0x00058198 nop
0x0005819c andi r2,r2,0x0040
0x000581a0 bne r2,r0,0x00058374
0x000581a4 nop
0x000581a8 lw r2,-0x6de0(r28)
0x000581ac addiu r1,r0,0x0001
0x000581b0 lbu r2,0x064e(r2)
0x000581b4 nop
0x000581b8 bne r2,r1,0x000581d8
0x000581bc nop
0x000581c0 addiu r2,r0,0x0001
0x000581c4 sb r2,0x0036(r16)
0x000581c8 lhu r2,0x0000(r18)
0x000581cc nop
0x000581d0 ori r2,r2,0x0040
0x000581d4 sh r2,0x0000(r18)
0x000581d8 lhu r2,0x0000(r18)
0x000581dc nop
0x000581e0 addu r3,r2,r0
0x000581e4 andi r2,r2,0x0008
0x000581e8 beq r2,r0,0x00058228
0x000581ec nop
0x000581f0 sb r0,0x0038(r16)
0x000581f4 lbu r6,0x0037(r16)
0x000581f8 addu r4,r17,r0
0x000581fc addu r5,r16,r0
0x00058200 jal 0x0005fea4
0x00058204 addu r7,r0,r0
0x00058208 addiu r2,r0,0x0002
0x0005820c sb r2,0x0036(r16)
0x00058210 sb r0,0x0036(r17)
0x00058214 lhu r2,0x0034(r16)
0x00058218 nop
0x0005821c ori r2,r2,0x0040
0x00058220 beq r0,r0,0x00058374
0x00058224 sh r2,0x0034(r16)
0x00058228 andi r2,r3,0x0004
0x0005822c bne r2,r0,0x00058374
0x00058230 nop
0x00058234 andi r2,r3,0x0002
0x00058238 beq r2,r0,0x00058258
0x0005823c nop
0x00058240 addu r4,r17,r0
0x00058244 addu r5,r16,r0
0x00058248 jal 0x0005fc18
0x0005824c addu r6,r0,r0
0x00058250 beq r0,r0,0x00058378
0x00058254 lw r31,0x0024(r29)
0x00058258 andi r2,r3,0x0800
0x0005825c bne r2,r0,0x00058374
0x00058260 nop
0x00058264 andi r2,r3,0x1000
0x00058268 bne r2,r0,0x00058374
0x0005826c nop
0x00058270 andi r2,r3,0x2000
0x00058274 bne r2,r0,0x00058374
0x00058278 nop
0x0005827c andi r2,r3,0x0400
0x00058280 bne r2,r0,0x0005829c
0x00058284 nop
0x00058288 lbu r6,0x0037(r16)
0x0005828c addu r4,r17,r0
0x00058290 addu r5,r16,r0
0x00058294 jal 0x0005fea4
0x00058298 addu r7,r0,r0
0x0005829c lw r3,-0x6de0(r28)
0x000582a0 nop
0x000582a4 lbu r3,0x064e(r3)
0x000582a8 addiu r1,r0,0x0004
0x000582ac beq r3,r1,0x00058300
0x000582b0 addiu r2,r0,0xffff
0x000582b4 addiu r1,r0,0x0002
0x000582b8 bne r3,r1,0x00058340
0x000582bc nop
0x000582c0 addiu r4,r29,0x0034
0x000582c4 jal 0x0005b070
0x000582c8 addu r5,r0,r0
0x000582cc bne r2,r0,0x000582f0
0x000582d0 addu r4,r0,r0
0x000582d4 addiu r2,r0,0x0050
0x000582d8 sh r2,0x0028(r16)
0x000582dc lhu r2,0x0034(r16)
0x000582e0 nop
0x000582e4 ori r2,r2,0x0800
0x000582e8 beq r0,r0,0x00058374
0x000582ec sh r2,0x0034(r16)
0x000582f0 jal 0x0005fdb4
0x000582f4 addiu r5,r29,0x0034
0x000582f8 beq r0,r0,0x00058340
0x000582fc sb r0,0x0056(r17)
0x00058300 addiu r4,r29,0x0034
0x00058304 jal 0x0005b070
0x00058308 addu r5,r0,r0
0x0005830c bne r2,r0,0x00058330
0x00058310 addu r4,r0,r0
0x00058314 addiu r2,r0,0x0050
0x00058318 sh r2,0x0028(r16)
0x0005831c lhu r2,0x0034(r16)
0x00058320 nop
0x00058324 ori r2,r2,0x0800
0x00058328 beq r0,r0,0x00058374
0x0005832c sh r2,0x0034(r16)
0x00058330 jal 0x0005fe2c
0x00058334 addiu r5,r29,0x0034
0x00058338 addiu r3,r0,0x0002
0x0005833c sb r3,0x0056(r17)
0x00058340 addiu r1,r0,0xffff
0x00058344 bne r2,r1,0x00058364
0x00058348 andi r7,r2,0x00ff
0x0005834c addu r4,r17,r0
0x00058350 addu r5,r16,r0
0x00058354 jal 0x00060618
0x00058358 addu r6,r0,r0
0x0005835c beq r0,r0,0x00058378
0x00058360 lw r31,0x0024(r29)
0x00058364 addu r4,r17,r0
0x00058368 addu r5,r16,r0
0x0005836c jal 0x0005d658
0x00058370 addu r6,r0,r0
0x00058374 lw r31,0x0024(r29)
0x00058378 lw r20,0x0020(r29)
0x0005837c lw r19,0x001c(r29)
0x00058380 lw r18,0x0018(r29)
0x00058384 lw r17,0x0014(r29)
0x00058388 lw r16,0x0010(r29)
0x0005838c jr r31
0x00058390 addiu r29,r29,0x0048