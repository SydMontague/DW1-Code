void battleStatsGainsAndDrops(itemDropArray) {
  // clear stats gain table
  for(i = 0; i < 6; i++)
    store(0x13D468 + i * 2, 0)
  
  // calculate stats gain per stat
  for(statId = 0; statId < 6; statId++) {
    enemyStat = load(0x13D61C + statId * 2) // enemy stat
    enemyCount = load(0x134D6C)
    
    partnerStat = load(0x13D610 + statId * 2) // partner stat
    
    for(enemyId = 1; enemyId < enemyCount; enemyId++) {
      localStat = load(0x13D610 + enemyId * 0x0C + statId * 2)
      if(enemyStat < localStat)
        enemyStat = localStat
    }
    
    partnerStatFactor = partnerStat * 10
    
    if(partnerStatFactor == 0)
      partnerStatFactor = 10
    
    enemyCountFactor = load(0x1344D0 + enemyCount - 1)
    
    if(enemyStat >= partnerStat) {
      statGain = 1 + (enemyStat * enemyCountFactor - 1) / partnerStatFactor
      store(0x13D468 + statId * 2, statGain)
    }
    else {
      chance = enemyStat * enemyCountFactor * 100 / partnerStatFactor
      
      if(random(100) < chance)
        store(0x13D468 + statId * 2, 1)
    }
  }
  
  // calculate extra stats gain conditions that may set it to 1
  for(statId = 0; statId < 6; statId++) {
    combatPtr = load(0x134D4C)
    
    if(load(0x13D468 + statId * 2) == 0)
      continue
      
    switch(statId) {
      case 0: // 0x000ED0E4
        startHP = load(combatPtr + 0x0648)
        currentHP = load(0x1557F4)
        
        lostHP = (startHP - currentHP) * 100
        maxHP = load(0x1557F0)
        
        chance = lostHP / maxHP
        break
      case 1: // 0x000ED128
      case 2: // 0x000ED128
        chance = load(combatPtr + 0x0640) * 10 // attacks done with low HP (<20%)
        break
      case 3: // 0x000ED148
        chance = load(combatPtr + 0x0646) * 10
        break
      case 4: // 0x000ED168
        currentHP = load(0x1557F4)
        startHP = load(combatPtr + 0x0648)
        lostHP = startHP - currentHP
        maxHP = load(0x1557F0)
        
        chance = (lostHP * 50 / maxHP) + (load(combatPtr + 0x0642) * 10)
        break
      case 5: // 0x000ED1B8
        chance = load(combatPtr + 0x0640) * 5 + load(combatPtr + 0x0646) * 5
    }
    
    if(random(100) < chance)
      continue
    
    store(0x13D468 + statId * 2, 1)
  }
  
  // calculate item drops
  for(enemyId = 0; enemyId < 3; enemyId++) {
    enemyCount = load(0x134D6C)
    
    if(enemyCount <= enemyId || load(0x134DA8) == 0x008F)
      itemDropArray[enemyId] = -1
    else {
      entityId = load(combatPtr + 0x066D + enemyId)
      entityPtr = load(0x12F344 + entityId * 4)
      entityType = load(entityPtr)
      
      dropChance = load(0x12CED6 + entityType * 52)
      dropItem = random(100) < dropChance ? load(0x12CED5 + entityType * 52) : -1
      itemDropArray[enemyId] = dropItem
    }
  }
}

0x000ecee8 addiu r29,r29,0xffd8
0x000eceec sw r31,0x0024(r29)
0x000ecef0 sw r20,0x0020(r29)
0x000ecef4 sw r19,0x001c(r29)
0x000ecef8 sw r18,0x0018(r29)
0x000ecefc sw r17,0x0014(r29)
0x000ecf00 sw r16,0x0010(r29)
0x000ecf04 addu r20,r4,r0
0x000ecf08 addu r16,r0,r0
0x000ecf0c beq r0,r0,0x000ecf2c
0x000ecf10 addu r3,r0,r0
0x000ecf14 lui r2,0x8014
0x000ecf18 addiu r2,r2,0xd468
0x000ecf1c addu r2,r2,r3
0x000ecf20 sh r0,0x0000(r2)
0x000ecf24 addi r16,r16,0x0001
0x000ecf28 addi r3,r3,0x0002
0x000ecf2c slti r1,r16,0x0006
0x000ecf30 bne r1,r0,0x000ecf14
0x000ecf34 nop
0x000ecf38 addu r19,r0,r0
0x000ecf3c beq r0,r0,0x000ed084
0x000ecf40 addu r17,r0,r0
0x000ecf44 lui r2,0x8014
0x000ecf48 addiu r2,r2,0xd61c
0x000ecf4c addu r2,r2,r17
0x000ecf50 lh r4,0x0000(r2)
0x000ecf54 lh r8,-0x6dc0(r28)
0x000ecf58 lui r2,0x8014
0x000ecf5c addiu r2,r2,0xd610
0x000ecf60 addu r2,r2,r17
0x000ecf64 lh r3,0x0000(r2)
0x000ecf68 addiu r16,r0,0x0001
0x000ecf6c addiu r6,r0,0x000c
0x000ecf70 sll r7,r19,0x01
0x000ecf74 beq r0,r0,0x000ecfac
0x000ecf78 addu r5,r8,r0
0x000ecf7c lui r2,0x8014
0x000ecf80 addiu r2,r2,0xd610
0x000ecf84 addu r2,r2,r6
0x000ecf88 addu r2,r7,r2
0x000ecf8c lh r2,0x0000(r2)
0x000ecf90 nop
0x000ecf94 slt r1,r4,r2
0x000ecf98 beq r1,r0,0x000ecfa4
0x000ecf9c addu r9,r2,r0
0x000ecfa0 addu r4,r9,r0
0x000ecfa4 addi r16,r16,0x0001
0x000ecfa8 addi r6,r6,0x000c
0x000ecfac slt r1,r8,r16
0x000ecfb0 beq r1,r0,0x000ecf7c
0x000ecfb4 nop
0x000ecfb8 sll r2,r3,0x02
0x000ecfbc add r2,r2,r3
0x000ecfc0 sll r2,r2,0x01
0x000ecfc4 bne r2,r0,0x000ecfd0
0x000ecfc8 nop
0x000ecfcc addiu r2,r0,0x000a
0x000ecfd0 slt r1,r4,r3
0x000ecfd4 bne r1,r0,0x000ed01c
0x000ecfd8 nop
0x000ecfdc addi r5,r5,-0x0001
0x000ecfe0 addiu r3,r28,0x89a4
0x000ecfe4 addu r3,r3,r5
0x000ecfe8 lb r3,0x0000(r3)
0x000ecfec nop
0x000ecff0 mult r4,r3
0x000ecff4 mflo r3
0x000ecff8 add r3,r2,r3
0x000ecffc addi r3,r3,-0x0001
0x000ed000 div r3,r2
0x000ed004 lui r2,0x8014
0x000ed008 addiu r2,r2,0xd468
0x000ed00c mflo r3
0x000ed010 addu r2,r2,r17
0x000ed014 beq r0,r0,0x000ed07c
0x000ed018 sh r3,0x0000(r2)
0x000ed01c addi r5,r5,-0x0001
0x000ed020 addiu r3,r28,0x89a4
0x000ed024 addu r3,r3,r5
0x000ed028 lb r3,0x0000(r3)
0x000ed02c nop
0x000ed030 mult r4,r3
0x000ed034 mflo r4
0x000ed038 sll r3,r4,0x02
0x000ed03c add r4,r3,r4
0x000ed040 sll r3,r4,0x02
0x000ed044 add r3,r4,r3
0x000ed048 sll r3,r3,0x02
0x000ed04c div r3,r2
0x000ed050 mflo r18
0x000ed054 jal 0x000a36d4
0x000ed058 addiu r4,r0,0x0064
0x000ed05c slt r1,r2,r18
0x000ed060 beq r1,r0,0x000ed07c
0x000ed064 nop
0x000ed068 lui r2,0x8014
0x000ed06c addiu r2,r2,0xd468
0x000ed070 addiu r3,r0,0x0001
0x000ed074 addu r2,r2,r17
0x000ed078 sh r3,0x0000(r2)
0x000ed07c addi r19,r19,0x0001
0x000ed080 addi r17,r17,0x0002
0x000ed084 slti r1,r19,0x0006
0x000ed088 bne r1,r0,0x000ecf44
0x000ed08c nop
0x000ed090 addu r16,r0,r0
0x000ed094 beq r0,r0,0x000ed210
0x000ed098 addu r17,r0,r0
0x000ed09c lui r2,0x8014
0x000ed0a0 addiu r2,r2,0xd468
0x000ed0a4 addu r2,r2,r17
0x000ed0a8 lh r2,0x0000(r2)
0x000ed0ac nop
0x000ed0b0 bne r2,r0,0x000ed208
0x000ed0b4 nop
0x000ed0b8 sltiu r1,r16,0x0006
0x000ed0bc beq r1,r0,0x000ed1e0
0x000ed0c0 nop
0x000ed0c4 lui r3,0x8011
0x000ed0c8 addiu r3,r3,0x51e8
0x000ed0cc sll r2,r16,0x02
0x000ed0d0 addu r2,r2,r3
0x000ed0d4 lw r2,0x0000(r2)
0x000ed0d8 nop
0x000ed0dc jr r2
0x000ed0e0 nop
0x000ed0e4 lw r2,-0x6de0(r28)
0x000ed0e8 lui r1,0x8015
0x000ed0ec lh r3,0x0648(r2)
0x000ed0f0 lh r2,0x57f4(r1)
0x000ed0f4 nop
0x000ed0f8 sub r3,r3,r2
0x000ed0fc sll r2,r3,0x02
0x000ed100 add r3,r2,r3
0x000ed104 sll r2,r3,0x02
0x000ed108 add r3,r3,r2
0x000ed10c lui r1,0x8015
0x000ed110 lh r2,0x57f0(r1)
0x000ed114 sll r3,r3,0x02
0x000ed118 div r3,r2
0x000ed11c mflo r18
0x000ed120 beq r0,r0,0x000ed1e0
0x000ed124 nop
0x000ed128 lw r2,-0x6de0(r28)
0x000ed12c nop
0x000ed130 lhu r3,0x0640(r2)
0x000ed134 nop
0x000ed138 sll r2,r3,0x02
0x000ed13c add r2,r2,r3
0x000ed140 beq r0,r0,0x000ed1e0
0x000ed144 sll r18,r2,0x01
0x000ed148 lw r2,-0x6de0(r28)
0x000ed14c nop
0x000ed150 lhu r3,0x0646(r2)
0x000ed154 nop
0x000ed158 sll r2,r3,0x02
0x000ed15c add r2,r2,r3
0x000ed160 beq r0,r0,0x000ed1e0
0x000ed164 sll r18,r2,0x01
0x000ed168 lw r5,-0x6de0(r28)
0x000ed16c lui r1,0x8015
0x000ed170 lh r2,0x57f4(r1)
0x000ed174 lh r3,0x0648(r5)
0x000ed178 lui r1,0x8015
0x000ed17c sub r3,r3,r2
0x000ed180 sll r2,r3,0x02
0x000ed184 add r3,r2,r3
0x000ed188 sll r2,r3,0x02
0x000ed18c add r3,r3,r2
0x000ed190 sll r4,r3,0x01
0x000ed194 lh r2,0x57f0(r1)
0x000ed198 lhu r3,0x0642(r5)
0x000ed19c div r4,r2
0x000ed1a0 sll r2,r3,0x02
0x000ed1a4 add r2,r2,r3
0x000ed1a8 mflo r4
0x000ed1ac sll r2,r2,0x01
0x000ed1b0 beq r0,r0,0x000ed1e0
0x000ed1b4 add r18,r2,r4
0x000ed1b8 lw r3,-0x6de0(r28)
0x000ed1bc nop
0x000ed1c0 lhu r4,0x0640(r3)
0x000ed1c4 nop
0x000ed1c8 sll r2,r4,0x02
0x000ed1cc lhu r3,0x0646(r3)
0x000ed1d0 add r4,r2,r4
0x000ed1d4 sll r2,r3,0x02
0x000ed1d8 add r2,r2,r3
0x000ed1dc add r18,r4,r2
0x000ed1e0 jal 0x000a36d4
0x000ed1e4 addiu r4,r0,0x0064
0x000ed1e8 slt r1,r2,r18
0x000ed1ec beq r1,r0,0x000ed208
0x000ed1f0 nop
0x000ed1f4 lui r2,0x8014
0x000ed1f8 addiu r2,r2,0xd468
0x000ed1fc addiu r3,r0,0x0001
0x000ed200 addu r2,r2,r17
0x000ed204 sh r3,0x0000(r2)
0x000ed208 addi r16,r16,0x0001
0x000ed20c addi r17,r17,0x0002
0x000ed210 slti r1,r16,0x0006
0x000ed214 bne r1,r0,0x000ed09c
0x000ed218 nop
0x000ed21c beq r0,r0,0x000ed2f0
0x000ed220 addu r16,r0,r0
0x000ed224 lh r2,-0x6dc0(r28)
0x000ed228 nop
0x000ed22c slt r1,r16,r2
0x000ed230 beq r1,r0,0x000ed2e0
0x000ed234 nop
0x000ed238 lbu r2,-0x6d84(r28)
0x000ed23c addiu r1,r0,0x008f
0x000ed240 bne r2,r1,0x000ed258
0x000ed244 nop
0x000ed248 addiu r3,r0,0x00ff
0x000ed24c addu r2,r20,r16
0x000ed250 beq r0,r0,0x000ed2ec
0x000ed254 sb r3,0x0000(r2)
0x000ed258 lw r2,-0x6de0(r28)
0x000ed25c addiu r4,r0,0x0064
0x000ed260 addu r2,r16,r2
0x000ed264 lbu r2,0x066d(r2)
0x000ed268 nop
0x000ed26c sll r3,r2,0x02
0x000ed270 lui r2,0x8013
0x000ed274 addiu r2,r2,0xf344
0x000ed278 addu r2,r2,r3
0x000ed27c lw r2,0x0000(r2)
0x000ed280 nop
0x000ed284 lw r3,0x0000(r2)
0x000ed288 nop
0x000ed28c sll r2,r3,0x01
0x000ed290 add r2,r2,r3
0x000ed294 sll r2,r2,0x02
0x000ed298 add r2,r2,r3
0x000ed29c sll r3,r2,0x02
0x000ed2a0 lui r2,0x8013
0x000ed2a4 addiu r2,r2,0xced6
0x000ed2a8 addu r2,r2,r3
0x000ed2ac lbu r18,0x0000(r2)
0x000ed2b0 jal 0x000a36d4
0x000ed2b4 addu r17,r3,r0
0x000ed2b8 slt r1,r2,r18
0x000ed2bc beq r1,r0,0x000ed2e0
0x000ed2c0 nop
0x000ed2c4 lui r2,0x8013
0x000ed2c8 addiu r2,r2,0xced5
0x000ed2cc addu r2,r2,r17
0x000ed2d0 lbu r3,0x0000(r2)
0x000ed2d4 addu r2,r20,r16
0x000ed2d8 beq r0,r0,0x000ed2ec
0x000ed2dc sb r3,0x0000(r2)
0x000ed2e0 addiu r3,r0,0x00ff
0x000ed2e4 addu r2,r20,r16
0x000ed2e8 sb r3,0x0000(r2)
0x000ed2ec addi r16,r16,0x0001
0x000ed2f0 slti r1,r16,0x0003
0x000ed2f4 bne r1,r0,0x000ed224
0x000ed2f8 nop
0x000ed2fc lw r31,0x0024(r29)
0x000ed300 lw r20,0x0020(r29)
0x000ed304 lw r19,0x001c(r29)
0x000ed308 lw r18,0x0018(r29)
0x000ed30c lw r17,0x0014(r29)
0x000ed310 lw r16,0x0010(r29)
0x000ed314 jr r31
0x000ed318 addiu r29,r29,0x0028