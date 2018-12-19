/**
 * Gets the id of the cheapest move from a given array of moves and
 * modifies a given array of moves to only mark the cheapest as eligible.
 *
 * If there are two moves with the same cost this function will return -1
 * but still modify the moves array.
 */
int getCheapestMove(combatId, moveArray) {
  combatHead = load(0x134D4C)
  entityId = load(combatHead + 0x066C + combatId)
  entityPtr = load(0x12F344 + entityId * 4)
  mpArray = short[3]
  
  for(moveId = 0; moveId < 3; moveId++) {
    isUseable = moveArray[moveId]
    if(isUseable == 1) {
      move = load(entityPtr + 0x44 + moveId)
      techId = getTechFromMove(entityPtr, move)
      mpArray[moveId] = load(0x126242 + techId * 0x10) * 3
    }
    else
      mpArray[moveId] = 1000
  }
  
  getCheapestMoveArray(mpArray, moveArray, sp + 0x36, 3)
  return load(sp + 0x36)
}

0x0005f244 addiu r29,r29,0xffc8
0x0005f248 sw r31,0x0024(r29)
0x0005f24c sw r20,0x0020(r29)
0x0005f250 sw r19,0x001c(r29)
0x0005f254 sw r18,0x0018(r29)
0x0005f258 sw r17,0x0014(r29)
0x0005f25c lw r2,-0x6de0(r28)
0x0005f260 sw r16,0x0010(r29)
0x0005f264 addu r2,r4,r2
0x0005f268 lbu r2,0x066c(r2)
0x0005f26c addu r20,r5,r0
0x0005f270 sll r3,r2,0x02
0x0005f274 lui r2,0x8013
0x0005f278 addiu r2,r2,0xf344
0x0005f27c addu r2,r2,r3
0x0005f280 lw r18,0x0000(r2)
0x0005f284 addu r17,r0,r0
0x0005f288 addiu r19,r18,0x0044
0x0005f28c beq r0,r0,0x0005f300
0x0005f290 addu r16,r0,r0
0x0005f294 addu r2,r20,r16
0x0005f298 lh r2,0x0000(r2)
0x0005f29c addiu r1,r0,0x0001
0x0005f2a0 bne r2,r1,0x0005f2ec
0x0005f2a4 nop
0x0005f2a8 addu r2,r19,r17
0x0005f2ac lbu r5,0x0000(r2)
0x0005f2b0 jal 0x000e6000
0x0005f2b4 addu r4,r18,r0
0x0005f2b8 sll r2,r2,0x10
0x0005f2bc sra r2,r2,0x10
0x0005f2c0 sll r3,r2,0x04
0x0005f2c4 lui r2,0x8012
0x0005f2c8 addiu r2,r2,0x6242
0x0005f2cc addu r2,r2,r3
0x0005f2d0 lbu r3,0x0000(r2)
0x0005f2d4 nop
0x0005f2d8 sll r2,r3,0x01
0x0005f2dc add r3,r2,r3
0x0005f2e0 addu r2,r29,r16
0x0005f2e4 beq r0,r0,0x0005f2f8
0x0005f2e8 sh r3,0x002c(r2)
0x0005f2ec addiu r3,r0,0x03e8
0x0005f2f0 addu r2,r29,r16
0x0005f2f4 sh r3,0x002c(r2)
0x0005f2f8 addi r17,r17,0x0001
0x0005f2fc addi r16,r16,0x0002
0x0005f300 slti r1,r17,0x0003
0x0005f304 bne r1,r0,0x0005f294
0x0005f308 nop
0x0005f30c addiu r4,r29,0x002c
0x0005f310 addu r5,r20,r0
0x0005f314 addiu r6,r29,0x0036
0x0005f318 jal 0x0005f404
0x0005f31c addiu r7,r0,0x0003
0x0005f320 lh r2,0x0036(r29)
0x0005f324 lw r31,0x0024(r29)
0x0005f328 lw r20,0x0020(r29)
0x0005f32c lw r19,0x001c(r29)
0x0005f330 lw r18,0x0018(r29)
0x0005f334 lw r17,0x0014(r29)
0x0005f338 lw r16,0x0010(r29)
0x0005f33c jr r31
0x0005f340 addiu r29,r29,0x0038