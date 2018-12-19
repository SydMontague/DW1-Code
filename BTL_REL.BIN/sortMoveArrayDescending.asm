/**
 * Sorts an array of values and an associated second array descending.
 * A third array will be filled with a ranking of the values, allowing
 * repetition.
 */
void sortMoveArrayDescending(powerArray, moveSlotArray, rankingArray, numMoves) {
  for(i = 0; i < numMoves; i++) {
    biggestValue = powerArray[i] // load(r17 + i * 4)
    swapIndex = i
    
    for(j = i; j < numMoves; j++) {
      localValue = powerArray[j] // load(r17 + j * 4)
      
      if(biggestValue < localValue) {
        swapIndex = j
        biggestValue = localValue
      }
    }
    
    swapValues(powerArray[i], powerArray[swapIndex])
    swapValues(moveSlotArray[i], moveSlotArray[swapIndex])
  }
  
  fillRankingArray(powerArray, rankingArray, numMoves)
}

0x0005f8e0 addiu r29,r29,0xffd0
0x0005f8e4 sw r31,0x002c(r29)
0x0005f8e8 sw r22,0x0028(r29)
0x0005f8ec sw r21,0x0024(r29)
0x0005f8f0 sw r20,0x0020(r29)
0x0005f8f4 sw r19,0x001c(r29)
0x0005f8f8 sw r18,0x0018(r29)
0x0005f8fc sw r17,0x0014(r29)
0x0005f900 sw r16,0x0010(r29)
0x0005f904 addu r17,r4,r0
0x0005f908 addu r18,r5,r0
0x0005f90c addu r22,r6,r0
0x0005f910 addu r21,r7,r0
0x0005f914 addu r20,r0,r0
0x0005f918 beq r0,r0,0x0005f994
0x0005f91c addu r16,r0,r0
0x0005f920 addu r2,r17,r16
0x0005f924 lw r4,0x0000(r2)
0x0005f928 addu r5,r20,r0
0x0005f92c addu r3,r20,r0
0x0005f930 beq r0,r0,0x0005f960
0x0005f934 sll r6,r20,0x02
0x0005f938 addu r2,r17,r6
0x0005f93c lw r2,0x0000(r2)
0x0005f940 nop
0x0005f944 slt r1,r4,r2
0x0005f948 beq r1,r0,0x0005f958
0x0005f94c addu r7,r2,r0
0x0005f950 addu r5,r3,r0
0x0005f954 addu r4,r7,r0
0x0005f958 addi r3,r3,0x0001
0x0005f95c addi r6,r6,0x0004
0x0005f960 slt r1,r3,r21
0x0005f964 bne r1,r0,0x0005f938
0x0005f968 nop
0x0005f96c sll r2,r5,0x02
0x0005f970 addu r4,r17,r16
0x0005f974 addu r19,r2,r0
0x0005f978 jal 0x000e52c0
0x0005f97c addu r5,r17,r2
0x0005f980 addu r4,r18,r16
0x0005f984 jal 0x000e52c0
0x0005f988 addu r5,r18,r19
0x0005f98c addi r20,r20,0x0001
0x0005f990 addi r16,r16,0x0004
0x0005f994 slt r1,r20,r21
0x0005f998 bne r1,r0,0x0005f920
0x0005f99c nop
0x0005f9a0 addu r4,r17,r0
0x0005f9a4 addu r5,r22,r0
0x0005f9a8 jal 0x0005fbb4
0x0005f9ac addu r6,r21,r0
0x0005f9b0 lw r31,0x002c(r29)
0x0005f9b4 lw r22,0x0028(r29)
0x0005f9b8 lw r21,0x0024(r29)
0x0005f9bc lw r20,0x0020(r29)
0x0005f9c0 lw r19,0x001c(r29)
0x0005f9c4 lw r18,0x0018(r29)
0x0005f9c8 lw r17,0x0014(r29)
0x0005f9cc lw r16,0x0010(r29)
0x0005f9d0 jr r31
0x0005f9d4 addiu r29,r29,0x0030