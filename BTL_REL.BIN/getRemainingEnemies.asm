/**
 * Gets an array and count of remaining (alive) enemies for a given Digimon.
 * The values get stored in addresses given by r5 (array) and r6 (count), 
 * typically on the stack.
 */
int[], int getRemainingEnemies(entityPtr) {
  aliveCount = 0
  aliveList = new int[4]
  combatHead = load(0x134D4C) // combatPtr
  
  for(combatId = 0; combatId <= load(0x134D6C); combatId++) {
    entityId = load(combatHead + combatId + 0x066C)
    lEntityPtr = load(0x12F344 + entityId * 4)
    
    if(entityPtr == lEntityPtr)
      continue
    
    if(hasZeroHP(combatId))
      continue
    
    aliveList[aliveCount] = combatId
    aliveCount++
  }
  
  return aliveList, aliveCount
}

0x0005fce8 addiu r29,r29,0xffd8
0x0005fcec sw r31,0x0020(r29)
0x0005fcf0 sw r19,0x001c(r29)
0x0005fcf4 sw r18,0x0018(r29)
0x0005fcf8 sw r17,0x0014(r29)
0x0005fcfc sw r16,0x0010(r29)
0x0005fd00 addu r17,r6,r0
0x0005fd04 addu r19,r4,r0
0x0005fd08 addu r18,r5,r0
0x0005fd0c sh r0,0x0000(r17)
0x0005fd10 beq r0,r0,0x0005fd84
0x0005fd14 addu r16,r0,r0
0x0005fd18 lw r2,-0x6de0(r28)
0x0005fd1c nop
0x0005fd20 addu r2,r16,r2
0x0005fd24 lbu r2,0x066c(r2)
0x0005fd28 nop
0x0005fd2c sll r3,r2,0x02
0x0005fd30 lui r2,0x8013
0x0005fd34 addiu r2,r2,0xf344
0x0005fd38 addu r2,r2,r3
0x0005fd3c lw r2,0x0000(r2)
0x0005fd40 nop
0x0005fd44 beq r19,r2,0x0005fd80
0x0005fd48 nop
0x0005fd4c jal 0x000601ac
0x0005fd50 andi r4,r16,0x00ff
0x0005fd54 bne r2,r0,0x0005fd80
0x0005fd58 nop
0x0005fd5c lh r2,0x0000(r17)
0x0005fd60 nop
0x0005fd64 sll r2,r2,0x01
0x0005fd68 addu r2,r18,r2
0x0005fd6c sh r16,0x0000(r2)
0x0005fd70 lh r2,0x0000(r17)
0x0005fd74 nop
0x0005fd78 addi r2,r2,0x0001
0x0005fd7c sh r2,0x0000(r17)
0x0005fd80 addi r16,r16,0x0001
0x0005fd84 lh r2,-0x6dc0(r28)
0x0005fd88 nop
0x0005fd8c slt r1,r2,r16
0x0005fd90 beq r1,r0,0x0005fd18
0x0005fd94 nop
0x0005fd98 lw r31,0x0020(r29)
0x0005fd9c lw r19,0x001c(r29)
0x0005fda0 lw r18,0x0018(r29)
0x0005fda4 lw r17,0x0014(r29)
0x0005fda8 lw r16,0x0010(r29)
0x0005fdac jr r31
0x0005fdb0 addiu r29,r29,0x0028