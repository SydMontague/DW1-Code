/**
 * Gets whether there are moves that a Digimon has enough MP to use.
 * Also fills an array given by arrayPtr with whether a move slot is affordable
 * and the move's order among the afforable ones.
 */
int hasAffordableMoves0x0005B070(arrayPtr, combatId) {
  battleHead = load(0x134D4C)
  entityId = load(battleHead + 0x066C + combatId) // enemyId
  entityPtr = load(0x12F344 + entityId * 4)
  
  affordableMoves = 0
  
  for(moveId = 0; moveId < 4; moveId++) {
    mpCost = getMPCost(entityPtr, battleHead + combatId * 0x168, moveId)
    arrayPtr[moveId] = mpCost != 0 ? 1 : 0
  }
  
  return affordableMoves
}

0x0005b070 addiu r29,r29,0xffd0
0x0005b074 sw r31,0x0028(r29)
0x0005b078 sw r21,0x0024(r29)
0x0005b07c sw r20,0x0020(r29)
0x0005b080 sw r19,0x001c(r29)
0x0005b084 sw r18,0x0018(r29)
0x0005b088 sw r17,0x0014(r29)
0x0005b08c lw r2,-0x6de0(r28)
0x0005b090 sw r16,0x0010(r29)
0x0005b094 addu r6,r2,r0
0x0005b098 addu r2,r5,r2
0x0005b09c lbu r2,0x066c(r2)
0x0005b0a0 addu r19,r4,r0
0x0005b0a4 sll r3,r2,0x02
0x0005b0a8 lui r2,0x8013
0x0005b0ac addiu r2,r2,0xf344
0x0005b0b0 addu r2,r2,r3
0x0005b0b4 lw r21,0x0000(r2)
0x0005b0b8 addu r4,r5,r0
0x0005b0bc sll r2,r4,0x04
0x0005b0c0 sub r3,r2,r4
0x0005b0c4 sll r2,r3,0x02
0x0005b0c8 sub r2,r2,r3
0x0005b0cc sll r2,r2,0x03
0x0005b0d0 addu r20,r6,r2
0x0005b0d4 addu r18,r0,r0
0x0005b0d8 addu r17,r0,r0
0x0005b0dc beq r0,r0,0x0005b120
0x0005b0e0 addu r16,r0,r0
0x0005b0e4 sll r6,r17,0x10
0x0005b0e8 sra r6,r6,0x10
0x0005b0ec addu r4,r21,r0
0x0005b0f0 jal 0x0005d374
0x0005b0f4 addu r5,r20,r0
0x0005b0f8 beq r2,r0,0x0005b110
0x0005b0fc nop
0x0005b100 addiu r18,r0,0x0001
0x0005b104 addu r2,r19,r16
0x0005b108 beq r0,r0,0x0005b118
0x0005b10c sh r18,0x0000(r2)
0x0005b110 addu r2,r19,r16
0x0005b114 sh r0,0x0000(r2)
0x0005b118 addi r17,r17,0x0001
0x0005b11c addi r16,r16,0x0002
0x0005b120 slti r1,r17,0x0004
0x0005b124 bne r1,r0,0x0005b0e4
0x0005b128 nop
0x0005b12c addu r2,r18,r0
0x0005b130 lw r31,0x0028(r29)
0x0005b134 lw r21,0x0024(r29)
0x0005b138 lw r20,0x0020(r29)
0x0005b13c lw r19,0x001c(r29)
0x0005b140 lw r18,0x0018(r29)
0x0005b144 lw r17,0x0014(r29)
0x0005b148 lw r16,0x0010(r29)
0x0005b14c jr r31
0x0005b150 addiu r29,r29,0x0030