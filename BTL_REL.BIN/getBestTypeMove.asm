/**
 * Gets the id of the move with the best type factor from a given array of
 * moves and modifies a given array of moves to only mark the best as eligible.
 *
 * If there are two moves with the same factor this function will return -1
 * but still modify the moves array.
 */
int getBestTypeMove(combatId, moveArray) {
  combatHead = load(0x134D4C)
  entityId = load(combatHead + 0x066C + combatId)
  entityPtr = load(0x12F344 + entityId * 4)
  
  currentTarget = load(combatHead + 0x37 + combatId * 0x168)
  enemyId = load(combatHead + 0x066C + currentTarget)
  enemyPtr = load(0x12F344 + enemyId * 4)
  
  typeFactorArray = short[3]
  
  for(r17 = 0; r17 < 3; r17++) {
    isUseable = moveArray[r17]
    
    if(isUseable == 1) {
      moveId = load(entityPtr + 0x44 + r17)
      techId = getTechFromMove(entityPtr, moveId)
      attackSpec = load(0x126245 + techId * 0x10)
      enemyType = load(enemyPtr)
      enemySpec = load(0x12CED2 + enemyType * 0x34)
      
      typeFactor = load(0x125F70 + attackSpec * 7 + enemySpec)
      typeFactorArray[r17] = typeFactor
    }
    else
      typeFactorArray[r17] = -1
  }
  
  getStrongestMoveArray(typeFactorArray, moveArray, sp + 0x3E, 3)
  
  return load(sp + 0x3E)
}

0x0005f0c0 addiu r29,r29,0xffc0
0x0005f0c4 sw r31,0x0028(r29)
0x0005f0c8 sw r21,0x0024(r29)
0x0005f0cc sw r20,0x0020(r29)
0x0005f0d0 sw r19,0x001c(r29)
0x0005f0d4 sw r18,0x0018(r29)
0x0005f0d8 sw r17,0x0014(r29)
0x0005f0dc sw r16,0x0010(r29)
0x0005f0e0 lw r2,-0x6de0(r28)
0x0005f0e4 addu r20,r5,r0
0x0005f0e8 addu r5,r2,r0
0x0005f0ec addu r2,r4,r2
0x0005f0f0 addu r3,r4,r0
0x0005f0f4 lbu r2,0x066c(r2)
0x0005f0f8 lui r4,0x8013
0x0005f0fc sll r2,r2,0x02
0x0005f100 addiu r4,r4,0xf344
0x0005f104 addu r2,r4,r2
0x0005f108 lw r18,0x0000(r2)
0x0005f10c addu r17,r0,r0
0x0005f110 sll r2,r3,0x04
0x0005f114 sub r3,r2,r3
0x0005f118 sll r2,r3,0x02
0x0005f11c sub r2,r2,r3
0x0005f120 sll r2,r2,0x03
0x0005f124 addu r2,r2,r5
0x0005f128 lbu r2,0x0037(r2)
0x0005f12c addiu r21,r18,0x0044
0x0005f130 addu r2,r2,r5
0x0005f134 lbu r2,0x066c(r2)
0x0005f138 nop
0x0005f13c sll r2,r2,0x02
0x0005f140 addu r2,r4,r2
0x0005f144 lw r19,0x0000(r2)
0x0005f148 beq r0,r0,0x0005f1fc
0x0005f14c addu r16,r0,r0
0x0005f150 addu r2,r20,r16
0x0005f154 lh r2,0x0000(r2)
0x0005f158 addiu r1,r0,0x0001
0x0005f15c bne r2,r1,0x0005f1e8
0x0005f160 nop
0x0005f164 addu r2,r21,r17
0x0005f168 lbu r5,0x0000(r2)
0x0005f16c jal 0x000e6000
0x0005f170 addu r4,r18,r0
0x0005f174 sll r2,r2,0x10
0x0005f178 sra r2,r2,0x10
0x0005f17c sll r3,r2,0x04
0x0005f180 lui r2,0x8012
0x0005f184 addiu r2,r2,0x6245
0x0005f188 addu r2,r2,r3
0x0005f18c lbu r3,0x0000(r2)
0x0005f190 nop
0x0005f194 sll r2,r3,0x03
0x0005f198 sub r4,r2,r3
0x0005f19c lui r2,0x8012
0x0005f1a0 addiu r2,r2,0x5f70
0x0005f1a4 lw r3,0x0000(r19)
0x0005f1a8 addu r4,r2,r4
0x0005f1ac sll r2,r3,0x01
0x0005f1b0 add r2,r2,r3
0x0005f1b4 sll r2,r2,0x02
0x0005f1b8 add r2,r2,r3
0x0005f1bc sll r3,r2,0x02
0x0005f1c0 lui r2,0x8013
0x0005f1c4 addiu r2,r2,0xced2
0x0005f1c8 addu r2,r2,r3
0x0005f1cc lbu r2,0x0000(r2)
0x0005f1d0 nop
0x0005f1d4 addu r2,r2,r4
0x0005f1d8 lbu r3,0x0000(r2)
0x0005f1dc addu r2,r29,r16
0x0005f1e0 beq r0,r0,0x0005f1f4
0x0005f1e4 sh r3,0x0034(r2)
0x0005f1e8 addiu r3,r0,0xffff
0x0005f1ec addu r2,r29,r16
0x0005f1f0 sh r3,0x0034(r2)
0x0005f1f4 addi r17,r17,0x0001
0x0005f1f8 addi r16,r16,0x0002
0x0005f1fc slti r1,r17,0x0003
0x0005f200 bne r1,r0,0x0005f150
0x0005f204 nop
0x0005f208 addiu r4,r29,0x0034
0x0005f20c addu r5,r20,r0
0x0005f210 addiu r6,r29,0x003e
0x0005f214 jal 0x0005f344
0x0005f218 addiu r7,r0,0x0003
0x0005f21c lh r2,0x003e(r29)
0x0005f220 lw r31,0x0028(r29)
0x0005f224 lw r21,0x0024(r29)
0x0005f228 lw r20,0x0020(r29)
0x0005f22c lw r19,0x001c(r29)
0x0005f230 lw r18,0x0018(r29)
0x0005f234 lw r17,0x0014(r29)
0x0005f238 lw r16,0x0010(r29)
0x0005f23c jr r31
0x0005f240 addiu r29,r29,0x0040