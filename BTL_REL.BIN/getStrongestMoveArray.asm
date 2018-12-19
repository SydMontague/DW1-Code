/**
 * Gets the strongest move from a given array of powers, stores it into retPtr
 * and modifies a given array of moves to only mark the strongest as eligible.
 *
 * If there are two moves with the same power this function will set retPtr to
 * -1 but still modify the moves array.
 */
void getStrongestMoveArray(powerArray, moveArray, retPtr, numMoves) {
  maxPower = powerArray[0]
  
  for(i = 1; i < numMoves; i++) {
    power = powerArray[i]
    
    if(maxPower < power)
      maxPower = power
  }
  
  matchedMoves = 0
  
  for(moveId = 0; moveId < numMoves; moveId++) {
    if(maxPower == powerArray[moveId]) {
      store(retPtr, moveId)
      matchedMoves++
      moveArray[moveId] = 1
    }
    else
      moveArray[moveId] = -1
  }
  
  if(matchedMoves >= 2)
    store(retPtr, -1)
}

0x0005f344 lh r3,0x0000(r4)
0x0005f348 addiu r2,r0,0x0001
0x0005f34c addiu r9,r0,0x0002
0x0005f350 beq r0,r0,0x0005f380
0x0005f354 addu r10,r7,r0
0x0005f358 addu r8,r4,r9
0x0005f35c lh r8,0x0000(r8)
0x0005f360 nop
0x0005f364 slt r1,r3,r8
0x0005f368 beq r1,r0,0x0005f378
0x0005f36c addu r11,r8,r0
0x0005f370 sll r3,r11,0x10
0x0005f374 sra r3,r3,0x10
0x0005f378 addi r2,r2,0x0001
0x0005f37c addi r9,r9,0x0002
0x0005f380 slt r1,r2,r10
0x0005f384 bne r1,r0,0x0005f358
0x0005f388 nop
0x0005f38c addu r10,r0,r0
0x0005f390 addu r2,r0,r0
0x0005f394 beq r0,r0,0x0005f3dc
0x0005f398 addu r11,r0,r0
0x0005f39c addu r8,r4,r11
0x0005f3a0 lh r8,0x0000(r8)
0x0005f3a4 nop
0x0005f3a8 bne r3,r8,0x0005f3c8
0x0005f3ac nop
0x0005f3b0 sh r2,0x0000(r6)
0x0005f3b4 addiu r9,r0,0x0001
0x0005f3b8 addu r8,r5,r11
0x0005f3bc addi r10,r10,0x0001
0x0005f3c0 beq r0,r0,0x0005f3d4
0x0005f3c4 sh r9,0x0000(r8)
0x0005f3c8 addiu r9,r0,0xffff
0x0005f3cc addu r8,r5,r11
0x0005f3d0 sh r9,0x0000(r8)
0x0005f3d4 addi r2,r2,0x0001
0x0005f3d8 addi r11,r11,0x0002
0x0005f3dc slt r1,r2,r7
0x0005f3e0 bne r1,r0,0x0005f39c
0x0005f3e4 nop
0x0005f3e8 slti r1,r10,0x0002
0x0005f3ec bne r1,r0,0x0005f3fc
0x0005f3f0 nop
0x0005f3f4 addiu r2,r0,0xffff
0x0005f3f8 sh r2,0x0000(r6)
0x0005f3fc jr r31
0x0005f400 nop