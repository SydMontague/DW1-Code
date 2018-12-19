/**
 * Gets the id of the strongest move from a given array of moves and
 * modifies a given array of moves to only mark the strongest as eligible.
 *
 * If there are two moves with the same power this function will return -1
 * but still modify the moves array.
 */
int getStrongestMove(combatId, moveArray) {
  combatHead = load(0x134D4C)
  entityId = load(combatHead + 0x066C + combatId)
  entityPtr = load(0x12F344 + entityId * 4)
  
  powerArray = short[3]
  
  for(moveId = 0; moveId < 3; moveId++) {
    if(moveArray[moveId] == 1) { // is affordable
      moveId = load(entityPtr + 0x44 + moveId)
      techId = getTechFromMove(entityPtr, moveId)
      movePower = load(0x126240 + techId * 0x10)
      powerArray[moveId] = movePower
    }
    else 
      powerArray[moveId] = -1
  }
  
  getStrongestMoveArray(powerArray, moveArray, sp + 0x36, 3)
  
  return load(sp + 0x36)
}

0x0005efcc addiu r29,r29,0xffc8
0x0005efd0 sw r31,0x0024(r29)
0x0005efd4 sw r20,0x0020(r29)
0x0005efd8 sw r19,0x001c(r29)
0x0005efdc sw r18,0x0018(r29)
0x0005efe0 sw r17,0x0014(r29)
0x0005efe4 lw r2,-0x6de0(r28)
0x0005efe8 sw r16,0x0010(r29)
0x0005efec addu r2,r4,r2
0x0005eff0 lbu r2,0x066c(r2)
0x0005eff4 addu r20,r5,r0
0x0005eff8 sll r3,r2,0x02
0x0005effc lui r2,0x8013
0x0005f000 addiu r2,r2,0xf344
0x0005f004 addu r2,r2,r3
0x0005f008 lw r18,0x0000(r2)
0x0005f00c addu r17,r0,r0
0x0005f010 addiu r19,r18,0x0044
0x0005f014 beq r0,r0,0x0005f07c
0x0005f018 addu r16,r0,r0
0x0005f01c addu r2,r20,r16
0x0005f020 lh r2,0x0000(r2)
0x0005f024 addiu r1,r0,0x0001
0x0005f028 bne r2,r1,0x0005f068
0x0005f02c nop
0x0005f030 addu r2,r19,r17
0x0005f034 lbu r5,0x0000(r2)
0x0005f038 jal 0x000e6000
0x0005f03c addu r4,r18,r0
0x0005f040 sll r2,r2,0x10
0x0005f044 sra r2,r2,0x10
0x0005f048 sll r3,r2,0x04
0x0005f04c lui r2,0x8012
0x0005f050 addiu r2,r2,0x6240
0x0005f054 addu r2,r2,r3
0x0005f058 lh r3,0x0000(r2)
0x0005f05c addu r2,r29,r16
0x0005f060 beq r0,r0,0x0005f074
0x0005f064 sh r3,0x002c(r2)
0x0005f068 addiu r3,r0,0xffff
0x0005f06c addu r2,r29,r16
0x0005f070 sh r3,0x002c(r2)
0x0005f074 addi r17,r17,0x0001
0x0005f078 addi r16,r16,0x0002
0x0005f07c slti r1,r17,0x0003
0x0005f080 bne r1,r0,0x0005f01c
0x0005f084 nop
0x0005f088 addiu r4,r29,0x002c
0x0005f08c addu r5,r20,r0
0x0005f090 addiu r6,r29,0x0036
0x0005f094 jal 0x0005f344
0x0005f098 addiu r7,r0,0x0003
0x0005f09c lh r2,0x0036(r29)
0x0005f0a0 lw r31,0x0024(r29)
0x0005f0a4 lw r20,0x0020(r29)
0x0005f0a8 lw r19,0x001c(r29)
0x0005f0ac lw r18,0x0018(r29)
0x0005f0b0 lw r17,0x0014(r29)
0x0005f0b4 lw r16,0x0010(r29)
0x0005f0b8 jr r31
0x0005f0bc addiu r29,r29,0x0038