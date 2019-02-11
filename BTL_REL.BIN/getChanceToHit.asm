int getChanceToHit(attackerPtr, victimPtr, victimCombatPtr, usedMove) {
  victimType = load(victimPtr)
  
  if(load(0x12CED1 + victimType * 52) < 3) // level below Rookie
    return 100
  
  combatFlags = load(victimCombatPtr + 0x34) // status flags
  
  if(combatFlags & 0x200C != 0) // stunned, flattened, stupid
    return 100
  
  if(load(0x138460) & 0x0040 != 0) // partner is sick
    return 100
    
  if(load(victimCombatPtr + 0x32) <= 0) // victim speed buffer is <= 0
    return 100
  
  activeAnim = load(victimPtr + 0x2E)
  
  if(activeAnim >= 0x2E)
    return 100
  
  if(usedMove >= 0x3A && usedMove < 0x71) { // is finisher
    if(combatFlags & 0x0080 != 0) { // is blocking
      r2 = combatFlags & 0xFF7F // unset blocking
      store(victimCombatPtr + 0x34, r2)
      store(victimCombatPtr + 0x26, 0) // blocking timer?
    }
    return 100
  }
  
  if(combatFlags & 0x0080 != 0) // is blocking
    return 0
  
  attackerSpeed = load(attackerPtr + 0x3C) * 0.1
  victimSpeed = load(victimPtr + 0x3C)
  
  speedFactor = (victimSpeed - attackerSpeed) / 1000
  
  accuracy = load(0x126247 + usedMove * 0x10) // move accuracy
  
  blockFactor = (accuracy / 2) * speedFactor
  
  if(activeAnim == 0x21 || activeAnim == 0x22) // is in idle anim 
    blockFactor = blockFactor * 1.2
  
  chanceToHit = accuracy - blockFactor
  
  if(chanceToHit < 0)
    chanceToHit = 0
  if(chanceToHit > 100)
    chanceToHit = 100
  
  return chanceToHit
}

0x0005bbe4 lw r3,0x0000(r5)
0x0005bbe8 nop
0x0005bbec sll r2,r3,0x01
0x0005bbf0 add r2,r2,r3
0x0005bbf4 sll r2,r2,0x02
0x0005bbf8 add r2,r2,r3
0x0005bbfc sll r3,r2,0x02
0x0005bc00 lui r2,0x8013
0x0005bc04 addiu r2,r2,0xced1
0x0005bc08 addu r2,r2,r3
0x0005bc0c lbu r2,0x0000(r2)
0x0005bc10 nop
0x0005bc14 sltiu r1,r2,0x0003
0x0005bc18 beq r1,r0,0x0005bc28
0x0005bc1c nop
0x0005bc20 beq r0,r0,0x0005bdd0
0x0005bc24 addiu r2,r0,0x0064
0x0005bc28 lhu r8,0x0034(r6)
0x0005bc2c nop
0x0005bc30 andi r2,r8,0x200c
0x0005bc34 beq r2,r0,0x0005bc44
0x0005bc38 addu r9,r8,r0
0x0005bc3c beq r0,r0,0x0005bdd0
0x0005bc40 addiu r2,r0,0x0064
0x0005bc44 lui r1,0x8014
0x0005bc48 lw r2,-0x7ba0(r1)
0x0005bc4c nop
0x0005bc50 andi r2,r2,0x0040
0x0005bc54 beq r2,r0,0x0005bc64
0x0005bc58 nop
0x0005bc5c beq r0,r0,0x0005bdd0
0x0005bc60 addiu r2,r0,0x0064
0x0005bc64 lh r2,0x0032(r6)
0x0005bc68 nop
0x0005bc6c bgtz r2,0x0005bc7c
0x0005bc70 nop
0x0005bc74 beq r0,r0,0x0005bdd0
0x0005bc78 addiu r2,r0,0x0064
0x0005bc7c lbu r3,0x002e(r5)
0x0005bc80 nop
0x0005bc84 sltiu r1,r3,0x002e
0x0005bc88 bne r1,r0,0x0005bc98
0x0005bc8c addu r2,r3,r0
0x0005bc90 beq r0,r0,0x0005bdd0
0x0005bc94 addiu r2,r0,0x0064
0x0005bc98 slti r1,r7,0x003a
0x0005bc9c bne r1,r0,0x0005bcd0
0x0005bca0 nop
0x0005bca4 slti r1,r7,0x0071
0x0005bca8 beq r1,r0,0x0005bcd0
0x0005bcac nop
0x0005bcb0 andi r2,r9,0x0080
0x0005bcb4 beq r2,r0,0x0005bcc8
0x0005bcb8 nop
0x0005bcbc andi r2,r8,0xff7f
0x0005bcc0 sh r2,0x0034(r6)
0x0005bcc4 sh r0,0x0026(r6)
0x0005bcc8 beq r0,r0,0x0005bdd0
0x0005bccc addiu r2,r0,0x0064
0x0005bcd0 andi r3,r9,0x0080
0x0005bcd4 beq r3,r0,0x0005bce4
0x0005bcd8 nop
0x0005bcdc beq r0,r0,0x0005bdd0
0x0005bce0 addu r2,r0,r0
0x0005bce4 lh r4,0x003c(r4)
0x0005bce8 lui r3,0x6666
0x0005bcec ori r3,r3,0x6667
0x0005bcf0 mult r3,r4
0x0005bcf4 srl r6,r4,0x1f
0x0005bcf8 mfhi r3
0x0005bcfc sra r4,r3,0x02
0x0005bd00 lh r3,0x003c(r5)
0x0005bd04 addu r4,r4,r6
0x0005bd08 sub r5,r3,r4
0x0005bd0c lui r3,0x8012
0x0005bd10 sll r4,r7,0x04
0x0005bd14 addiu r3,r3,0x6247
0x0005bd18 addu r3,r3,r4
0x0005bd1c lbu r4,0x0000(r3)
0x0005bd20 nop
0x0005bd24 addu r3,r4,r0
0x0005bd28 bgez r4,0x0005bd38
0x0005bd2c sra r25,r4,0x01
0x0005bd30 addiu r4,r4,0x0001
0x0005bd34 sra r25,r4,0x01
0x0005bd38 mult r25,r5
0x0005bd3c lui r4,0x8334
0x0005bd40 mflo r6
0x0005bd44 ori r4,r4,0x0521
0x0005bd48 nop
0x0005bd4c mult r4,r6
0x0005bd50 srl r5,r6,0x1f
0x0005bd54 mfhi r4
0x0005bd58 addu r4,r4,r6
0x0005bd5c sra r4,r4,0x09
0x0005bd60 addiu r1,r0,0x0021
0x0005bd64 beq r2,r1,0x0005bd78
0x0005bd68 addu r4,r4,r5
0x0005bd6c addiu r1,r0,0x0022
0x0005bd70 bne r2,r1,0x0005bda0
0x0005bd74 nop
0x0005bd78 sll r2,r4,0x01
0x0005bd7c add r2,r2,r4
0x0005bd80 sll r4,r2,0x01
0x0005bd84 lui r2,0x6666
0x0005bd88 ori r2,r2,0x6667
0x0005bd8c mult r2,r4
0x0005bd90 mfhi r2
0x0005bd94 srl r4,r4,0x1f
0x0005bd98 sra r2,r2,0x01
0x0005bd9c addu r4,r2,r4
0x0005bda0 sub r2,r3,r4
0x0005bda4 sll r2,r2,0x10
0x0005bda8 sra r2,r2,0x10
0x0005bdac bgez r2,0x0005bdb8
0x0005bdb0 nop
0x0005bdb4 addu r2,r0,r0
0x0005bdb8 slti r1,r2,0x0065
0x0005bdbc bne r1,r0,0x0005bdd0
0x0005bdc0 nop
0x0005bdc4 addiu r2,r0,0x0064
0x0005bdc8 sll r2,r2,0x10
0x0005bdcc sra r2,r2,0x10
0x0005bdd0 jr r31
0x0005bdd4 nop