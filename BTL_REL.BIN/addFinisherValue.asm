void addFinisherValue(int entityCombatOffset, int amount) {

  int combatStartOffset = load(0x134D4C)

  // check if entity has finisher
  for(int i = 0, i < load(0x134D6C), i++) { // for number of entities in combat
    localCombatOffset = combatStartOffset + 0x168 * i
    
    if(localCombatOffset == entityCombatOffset) { // it's the entity we're looking for
      entityMapOffset = load(combatStartOffset + 0x066C + i) * 4 // involved entitiy list
      entityMapDataOffset = load(0x12f344 + entityMapOffset) // entity data table
      finisherId = load(entityMapDataOffset + 0x47) // move in slot #3
      
      techId = getTechFromMove(entityMapDataOffset, finisherId)

      if(techId < 0x3A || techId > 0x71)
        return
    }
  }

  tmpAmount = load(entityCombatOffset + 0x1A) // finisher progress
  tmpAmount += amount
  store(tmpAmount, entityCombatOffset + 0x1A)

  goalAmount = load(entityCombatOffset + 0x18) // finisher goal

  if(goalAmount < tmpAmount) 
    store(goalAmount, entityCombatOffset + 0x1A)
}

// original code
0x0005dfc8 addiu r29,r29,0xffd8
0x0005dfcc sw r31,0x0020(r29)
0x0005dfd0 sw r19,0x001c(r29)
0x0005dfd4 sw r18,0x0018(r29)
0x0005dfd8 sw r17,0x0014(r29)
0x0005dfdc sw r16,0x0010(r29)
0x0005dfe0 addu r16,r4,r0
0x0005dfe4 addu r19,r5,r0
0x0005dfe8 addu r17,r0,r0
0x0005dfec beq r0,r0,0x0005e064
0x0005dff0 addu r18,r0,r0
0x0005dff4 lw r2,-0x6de0(r28)
0x0005dff8 nop
0x0005dffc addu r3,r2,r0
0x0005e000 addu r2,r2,r18
0x0005e004 bne r2,r16,0x0005e05c
0x0005e008 nop
0x0005e00c addu r2,r3,r17
0x0005e010 lbu r2,0x066c(r2)
0x0005e014 nop
0x0005e018 sll r3,r2,0x02
0x0005e01c lui r2,0x8013
0x0005e020 addiu r2,r2,0xf344
0x0005e024 addu r2,r2,r3
0x0005e028 lw r4,0x0000(r2)
0x0005e02c nop
0x0005e030 lbu r5,0x0047(r4)
0x0005e034 jal 0x000e6000
0x0005e038 nop
0x0005e03c sll r2,r2,0x10
0x0005e040 sra r2,r2,0x10
0x0005e044 slti r1,r2,0x003a
0x0005e048 bne r1,r0,0x0005e0a4
0x0005e04c nop
0x0005e050 slti r1,r2,0x0071
0x0005e054 beq r1,r0,0x0005e0a4
0x0005e058 nop
0x0005e05c addi r17,r17,0x0001
0x0005e060 addi r18,r18,0x0168
0x0005e064 lh r2,-0x6dc0(r28)
0x0005e068 nop
0x0005e06c slt r1,r2,r17
0x0005e070 beq r1,r0,0x0005dff4
0x0005e074 nop
0x0005e078 lh r2,0x001a(r16)
0x0005e07c nop
0x0005e080 add r2,r2,r19
0x0005e084 sh r2,0x001a(r16)
0x0005e088 lh r2,0x0018(r16)
0x0005e08c lh r3,0x001a(r16)
0x0005e090 nop
0x0005e094 slt r1,r2,r3
0x0005e098 beq r1,r0,0x0005e0a4
0x0005e09c addu r4,r2,r0
0x0005e0a0 sh r4,0x001a(r16)
0x0005e0a4 lw r31,0x0020(r29)
0x0005e0a8 lw r19,0x001c(r29)
0x0005e0ac lw r18,0x0018(r29)
0x0005e0b0 lw r17,0x0014(r29)
0x0005e0b4 lw r16,0x0010(r29)
0x0005e0b8 jr r31
0x0005e0bc addiu r29,r29,0x0028