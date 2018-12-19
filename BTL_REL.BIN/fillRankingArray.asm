/**
 * Takes an array of values and fills another given array with a ranking of
 * those values, starting at 0 and repeating if two powers are equal.
 */
void fillRankingArray(powerArray, rankingArray, numMoves) {
  rankingIndex = 0
  rankingArray[0] = 0
  
  for(i = 1; i < numMoves; i++) {
    if(powerArray[i] != powerArray[i - 1])
      rankingIndex++
    
    rankingArray[i] = rankingIndex
  }
}

0x0005fbb4 addu r8,r0,r0
0x0005fbb8 sw r0,0x0000(r5)
0x0005fbbc addiu r7,r0,0x0001
0x0005fbc0 beq r0,r0,0x0005fc04
0x0005fbc4 addiu r9,r0,0x0004
0x0005fbc8 addu r2,r4,r9
0x0005fbcc lw r3,0x0000(r2)
0x0005fbd0 lw r2,-0x0004(r2)
0x0005fbd4 nop
0x0005fbd8 bne r3,r2,0x0005fbec
0x0005fbdc nop
0x0005fbe0 addu r2,r5,r9
0x0005fbe4 beq r0,r0,0x0005fbfc
0x0005fbe8 sw r8,0x0000(r2)
0x0005fbec addi r3,r8,0x0001
0x0005fbf0 addu r2,r5,r9
0x0005fbf4 addu r8,r3,r0
0x0005fbf8 sw r3,0x0000(r2)
0x0005fbfc addi r7,r7,0x0001
0x0005fc00 addi r9,r9,0x0004
0x0005fc04 slt r1,r7,r6
0x0005fc08 bne r1,r0,0x0005fbc8
0x0005fc0c nop
0x0005fc10 jr r31
0x0005fc14 nop