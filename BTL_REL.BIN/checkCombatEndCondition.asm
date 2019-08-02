int checkCombatEndCondition() {
  partnerPtr = load(0x12F348)
  
  combatHead = load(0x134D4C)
  remainingDamage = load(combatHead + 0x2E)
  currentHP = load(0x1557F4)
  
  // flee timer
  if(load(0x134D68) > 40 && currentHP - remainingDamage > 0)
    return 1
  
  currentAnim = load(partnerPtr + 0x2E) // current anim
  
  // reset stuff if partner gets back up
  if(currentAnim == 0x2C) {
    store(0x134D6A, 0) // unset death countdown
    
    if(load(partnerPtr + 0x30) & 1 == 1) {
      store(combatHead + 0x34, load(combatHead + 0x34) & 0x7FFF) // unset isDead flag
      store(0x1557FB, 0)
      
      if(load(0x134D74) != 0) { // no AI flag
        val = load(0x13507C)
        
        if(val != -1)
          0x00070BFC(val) // TODO name
        
        store(0x134D60, 0)
        store(0x134D74, 0) // no AI flag
      }
    }
    
    for(enemyId = 0; enemyId < load(0x134D6C); enemyId++) {
      combatPtr = combatHead + enemyId * 0x168
      
      store(combatPtr + 0x28, 0) // reset cooldown
      store(combatPtr + 0x34, load(combatPtr + 0x34) & 0xC3BF) // unset falgs
      
      entityId = load(combatHead + 0x66C + enemyId)
      entityPtr = load(0x12F344 + entityId * 4)
      
      isDead = load(combatPtr + 0x34) & 0x8000 // isDead
      
      remainingDamage = load(combatPtr + 0x2E) // remaining HP damage
      currentHP = load(entityPtr + 0x4C) // current HP
      
      if(isDead == 0 || currentHP - remainingDamage > 0)
        store(combatPtr + 0x36, 0)
    }
  }
  
  // end combat when partner is down
  if(currentAnim == 0x2B && load(partnerPtr + 0x30) & 1 == 0) {
    if(load(0x13D4D8) == -1) // no item is being thrown
      store(0x134D6A, load(0x134D6A) + 1) // death countdown
    
    if(load(0x134D6A) == 20)
      spawnDeathCountdown(partnerPtr)
    
    return deathCountdown >= 0xAB ? 1 : 0
  }
  
  // end combat when all enemies are knocked down
  for(enemyId = 1; enemyId < load(0x134D6C); enemyId++) {
    entityId = load(combatHead + 0x66C + enemyId)
    entityPtr = load(0x12F344 + entityId * 4)
    
    // enemy knockdown animation
    if(load(entityPtr + 0x2E) != 0x2B || load(entityPtr + 0x30) & 1 != 0)
      return 0
  }
  
  remainingDamage = load(combatHead + 0x2E)
  currentHP = load(0x1557F4)
  
  return currentHP - remainingDamage > 0 ? 1 : 0
}

0x00057920 addiu r29,r29,0xffe8
0x00057924 sw r31,0x0014(r29)
0x00057928 sw r16,0x0010(r29)
0x0005792c lui r1,0x8013
0x00057930 lw r16,-0x0cb8(r1)
0x00057934 lh r2,-0x6dc4(r28)
0x00057938 nop
0x0005793c slti r1,r2,0x0029
0x00057940 bne r1,r0,0x00057970
0x00057944 nop
0x00057948 lw r2,-0x6de0(r28)
0x0005794c lui r1,0x8015
0x00057950 lh r3,0x002e(r2)
0x00057954 lh r2,0x57f4(r1)
0x00057958 nop
0x0005795c sub r2,r2,r3
0x00057960 blez r2,0x00057970
0x00057964 nop
0x00057968 beq r0,r0,0x00057bc0
0x0005796c addiu r2,r0,0x0001
0x00057970 lbu r2,0x002e(r16)
0x00057974 addiu r1,r0,0x002c
0x00057978 bne r2,r1,0x00057a9c
0x0005797c nop
0x00057980 sh r0,-0x6dc2(r28)
0x00057984 lbu r2,0x0030(r16)
0x00057988 nop
0x0005798c andi r2,r2,0x0001
0x00057990 bne r2,r0,0x00057a9c
0x00057994 nop
0x00057998 lw r3,-0x6de0(r28)
0x0005799c lui r1,0x8015
0x000579a0 lhu r2,0x0034(r3)
0x000579a4 nop
0x000579a8 andi r2,r2,0x7fff
0x000579ac sh r2,0x0034(r3)
0x000579b0 lw r2,-0x6db8(r28)
0x000579b4 nop
0x000579b8 beq r2,r0,0x000579e0
0x000579bc sb r0,0x57fb(r1)
0x000579c0 lw r4,-0x6ab0(r28)
0x000579c4 addiu r1,r0,0xffff
0x000579c8 beq r4,r1,0x000579d8
0x000579cc nop
0x000579d0 jal 0x00070bfc
0x000579d4 nop
0x000579d8 sw r0,-0x6db8(r28)
0x000579dc sw r0,-0x6dcc(r28)
0x000579e0 addu r2,r0,r0
0x000579e4 beq r0,r0,0x00057a88
0x000579e8 addu r3,r0,r0
0x000579ec lw r4,-0x6de0(r28)
0x000579f0 nop
0x000579f4 addu r4,r3,r4
0x000579f8 sh r0,0x0028(r4)
0x000579fc lw r4,-0x6de0(r28)
0x00057a00 nop
0x00057a04 addu r5,r3,r4
0x00057a08 lhu r4,0x0034(r5)
0x00057a0c nop
0x00057a10 andi r4,r4,0xc3bf
0x00057a14 sh r4,0x0034(r5)
0x00057a18 lw r4,-0x6de0(r28)
0x00057a1c nop
0x00057a20 addu r7,r4,r0
0x00057a24 addu r4,r2,r4
0x00057a28 lbu r4,0x066c(r4)
0x00057a2c nop
0x00057a30 sll r5,r4,0x02
0x00057a34 lui r4,0x8013
0x00057a38 addiu r4,r4,0xf344
0x00057a3c addu r4,r4,r5
0x00057a40 lw r4,0x0000(r4)
0x00057a44 addu r5,r3,r7
0x00057a48 addiu r6,r4,0x0038
0x00057a4c lhu r4,0x0034(r5)
0x00057a50 nop
0x00057a54 andi r4,r4,0x8000
0x00057a58 beq r4,r0,0x00057a78
0x00057a5c nop
0x00057a60 lh r5,0x002e(r5)
0x00057a64 lh r4,0x0014(r6)
0x00057a68 nop
0x00057a6c sub r4,r4,r5
0x00057a70 blez r4,0x00057a80
0x00057a74 nop
0x00057a78 addu r4,r3,r7
0x00057a7c sb r0,0x0036(r4)
0x00057a80 addi r2,r2,0x0001
0x00057a84 addi r3,r3,0x0168
0x00057a88 lh r4,-0x6dc0(r28)
0x00057a8c nop
0x00057a90 slt r1,r4,r2
0x00057a94 beq r1,r0,0x000579ec
0x00057a98 nop
0x00057a9c lbu r2,0x002e(r16)
0x00057aa0 addiu r1,r0,0x002b
0x00057aa4 bne r2,r1,0x00057b28
0x00057aa8 nop
0x00057aac lbu r2,0x0030(r16)
0x00057ab0 nop
0x00057ab4 andi r2,r2,0x0001
0x00057ab8 bne r2,r0,0x00057b28
0x00057abc nop
0x00057ac0 lui r1,0x8014
0x00057ac4 lw r2,-0x2b28(r1)
0x00057ac8 addiu r1,r0,0x00ff
0x00057acc bne r2,r1,0x00057ae4
0x00057ad0 nop
0x00057ad4 lh r2,-0x6dc2(r28)
0x00057ad8 nop
0x00057adc addi r2,r2,0x0001
0x00057ae0 sh r2,-0x6dc2(r28)
0x00057ae4 lh r2,-0x6dc2(r28)
0x00057ae8 addiu r1,r0,0x0014
0x00057aec bne r2,r1,0x00057b04
0x00057af0 nop
0x00057af4 lui r1,0x8013
0x00057af8 lw r4,-0x0cb8(r1)
0x00057afc jal 0x00062468
0x00057b00 nop
0x00057b04 lh r2,-0x6dc2(r28)
0x00057b08 nop
0x00057b0c slti r1,r2,0x00ab
0x00057b10 bne r1,r0,0x00057b20
0x00057b14 nop
0x00057b18 beq r0,r0,0x00057bc0
0x00057b1c addiu r2,r0,0x0001
0x00057b20 beq r0,r0,0x00057bc0
0x00057b24 addu r2,r0,r0
0x00057b28 lw r5,-0x6de0(r28)
0x00057b2c lh r6,-0x6dc0(r28)
0x00057b30 beq r0,r0,0x00057b8c
0x00057b34 addiu r2,r0,0x0001
0x00057b38 addu r3,r2,r5
0x00057b3c lbu r3,0x066c(r3)
0x00057b40 addiu r1,r0,0x002b
0x00057b44 sll r4,r3,0x02
0x00057b48 lui r3,0x8013
0x00057b4c addiu r3,r3,0xf344
0x00057b50 addu r3,r3,r4
0x00057b54 lw r16,0x0000(r3)
0x00057b58 nop
0x00057b5c lbu r3,0x002e(r16)
0x00057b60 nop
0x00057b64 bne r3,r1,0x00057b80
0x00057b68 nop
0x00057b6c lbu r3,0x0030(r16)
0x00057b70 nop
0x00057b74 andi r3,r3,0x0001
0x00057b78 beq r3,r0,0x00057b88
0x00057b7c nop
0x00057b80 beq r0,r0,0x00057bc0
0x00057b84 addu r2,r0,r0
0x00057b88 addi r2,r2,0x0001
0x00057b8c slt r1,r6,r2
0x00057b90 beq r1,r0,0x00057b38
0x00057b94 nop
0x00057b98 lw r2,-0x6de0(r28)
0x00057b9c lui r1,0x8015
0x00057ba0 lh r3,0x002e(r2)
0x00057ba4 lh r2,0x57f4(r1)
0x00057ba8 nop
0x00057bac sub r2,r2,r3
0x00057bb0 bgtz r2,0x00057bc0
0x00057bb4 addiu r2,r0,0x0001
0x00057bb8 beq r0,r0,0x00057bc0
0x00057bbc addu r2,r0,r0
0x00057bc0 lw r31,0x0014(r29)
0x00057bc4 lw r16,0x0010(r29)
0x00057bc8 jr r31
0x00057bcc addiu r29,r29,0x0018