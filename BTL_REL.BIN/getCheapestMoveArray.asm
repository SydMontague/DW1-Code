/**
 * Gets the cheapest move from a given array of costs, stores it into retPtr
 * and modifies a given array of moves to only mark the strongest as eligible.
 *
 * If there are two moves with the same cost this function will set retPtr to
 * -1 but still modify the moves array.
 */
void getCheapestMoveArray(mpArray, moveArray, retPtr, numMoves) {
  bestMP = mpArray[0]
  
  for(moveId = 1; moveId < numMoves; moveId++) {
    mpCost = mpArray[moveId]
    
    if(mpCost < bestMP)
      bestMP = mpCost
  }
  
  matchedMoves = 0
  
  for(moveId = 0; moveId < numMoves; moveId++) {
    if(mpArray[moveId] == bestMP) {
      store(retPtr, moveId)
      moveArray[moveId] = 1
      matchedMoves++
    }
    else
      moveArray[moveId] = -1
  }
  
  if(matchedMoves >= 2)
    store(retPtr, -1)
}

0x0005f404 lh r3,0x0000(r4)
0x0005f408 addiu r2,r0,0x0001
0x0005f40c addiu r9,r0,0x0002
0x0005f410 beq r0,r0,0x0005f440
0x0005f414 addu r10,r7,r0
0x0005f418 addu r8,r4,r9
0x0005f41c lh r8,0x0000(r8)
0x0005f420 nop
0x0005f424 slt r1,r8,r3
0x0005f428 beq r1,r0,0x0005f438
0x0005f42c addu r11,r8,r0
0x0005f430 sll r3,r11,0x10
0x0005f434 sra r3,r3,0x10
0x0005f438 addi r2,r2,0x0001
0x0005f43c addi r9,r9,0x0002
0x0005f440 slt r1,r2,r10
0x0005f444 bne r1,r0,0x0005f418
0x0005f448 nop
0x0005f44c addu r10,r0,r0
0x0005f450 addu r2,r0,r0
0x0005f454 beq r0,r0,0x0005f49c
0x0005f458 addu r11,r0,r0
0x0005f45c addu r8,r4,r11
0x0005f460 lh r8,0x0000(r8)
0x0005f464 nop
0x0005f468 bne r3,r8,0x0005f488
0x0005f46c nop
0x0005f470 sh r2,0x0000(r6)
0x0005f474 addiu r9,r0,0x0001
0x0005f478 addu r8,r5,r11
0x0005f47c addi r10,r10,0x0001
0x0005f480 beq r0,r0,0x0005f494
0x0005f484 sh r9,0x0000(r8)
0x0005f488 addiu r9,r0,0xffff
0x0005f48c addu r8,r5,r11
0x0005f490 sh r9,0x0000(r8)
0x0005f494 addi r2,r2,0x0001
0x0005f498 addi r11,r11,0x0002
0x0005f49c slt r1,r2,r7
0x0005f4a0 bne r1,r0,0x0005f45c
0x0005f4a4 nop
0x0005f4a8 slti r1,r10,0x0002
0x0005f4ac bne r1,r0,0x0005f4bc
0x0005f4b0 nop
0x0005f4b4 addiu r2,r0,0xffff
0x0005f4b8 sh r2,0x0000(r6)
0x0005f4bc jr r31
0x0005f4c0 nop