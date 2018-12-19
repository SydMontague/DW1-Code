/**
 * Gets whether there are moves that a Digimon has enough MP to use.
 * Also fills an array given by arrayPtr with whether a move slot is affordable
 * and the move's order among the afforable ones.
 */
int hasAffordableMoves(arrayPtr, combatId) {
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

0x0005ee58 addiu r29,r29,0xffd0
0x0005ee5c sw r31,0x0028(r29)
0x0005ee60 sw r21,0x0024(r29)
0x0005ee64 sw r20,0x0020(r29)
0x0005ee68 sw r19,0x001c(r29)
0x0005ee6c sw r18,0x0018(r29)
0x0005ee70 sw r17,0x0014(r29)
0x0005ee74 lw r2,-0x6de0(r28)
0x0005ee78 sw r16,0x0010(r29)
0x0005ee7c addu r6,r2,r0
0x0005ee80 addu r2,r5,r2
0x0005ee84 lbu r2,0x066c(r2)
0x0005ee88 addu r19,r4,r0
0x0005ee8c sll r3,r2,0x02
0x0005ee90 lui r2,0x8013
0x0005ee94 addiu r2,r2,0xf344
0x0005ee98 addu r2,r2,r3
0x0005ee9c lw r21,0x0000(r2)
0x0005eea0 addu r4,r5,r0
0x0005eea4 sll r2,r4,0x04
0x0005eea8 sub r3,r2,r4
0x0005eeac sll r2,r3,0x02
0x0005eeb0 sub r2,r2,r3
0x0005eeb4 sll r2,r2,0x03
0x0005eeb8 addu r20,r6,r2
0x0005eebc addu r18,r0,r0
0x0005eec0 addu r17,r0,r0
0x0005eec4 beq r0,r0,0x0005ef08
0x0005eec8 addu r16,r0,r0
0x0005eecc sll r6,r17,0x10
0x0005eed0 sra r6,r6,0x10
0x0005eed4 addu r4,r21,r0
0x0005eed8 jal 0x0005d374
0x0005eedc addu r5,r20,r0
0x0005eee0 beq r2,r0,0x0005eef8
0x0005eee4 nop
0x0005eee8 addiu r18,r0,0x0001
0x0005eeec addu r2,r19,r16
0x0005eef0 beq r0,r0,0x0005ef00
0x0005eef4 sh r18,0x0000(r2)
0x0005eef8 addu r2,r19,r16
0x0005eefc sh r0,0x0000(r2)
0x0005ef00 addi r17,r17,0x0001
0x0005ef04 addi r16,r16,0x0002
0x0005ef08 slti r1,r17,0x0004
0x0005ef0c bne r1,r0,0x0005eecc
0x0005ef10 nop
0x0005ef14 addu r2,r18,r0
0x0005ef18 lw r31,0x0028(r29)
0x0005ef1c lw r21,0x0024(r29)
0x0005ef20 lw r20,0x0020(r29)
0x0005ef24 lw r19,0x001c(r29)
0x0005ef28 lw r18,0x0018(r29)
0x0005ef2c lw r17,0x0014(r29)
0x0005ef30 lw r16,0x0010(r29)
0x0005ef34 jr r31
0x0005ef38 addiu r29,r29,0x0030