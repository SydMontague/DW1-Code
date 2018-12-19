/**
 * Sorts an array of values and an associated second array descending.
 * A third array will be filled with a ranking of the values, allowing
 * repetition.
 */
void sortMoveArrayAscending(powerArray, moveSlotArray, rankingArray, numMoves) {
  for(i = 0; i < numMoves; i++) {
    smallestValue = powerArray[i] // load(r17 + i * 4)
    swapIndex = i
    
    for(j = i; j < numMoves; j++) {
      localValue = powerArray[j] // load(r17 + j * 4)
      
      if(smallestValue > localValue) {
        swapIndex = j
        smallestValue = localValue
      }
    }
    
    swapValues(powerArray[i], powerArray[swapIndex])
    swapValues(moveSlotArray[i], moveSlotArray[swapIndex])
  }
  
  fillRankingArray(powerArray, rankingArray, numMoves)
}

0x0005f9d8 addiu r29,r29,0xffd0
0x0005f9dc sw r31,0x002c(r29)
0x0005f9e0 sw r22,0x0028(r29)
0x0005f9e4 sw r21,0x0024(r29)
0x0005f9e8 sw r20,0x0020(r29)
0x0005f9ec sw r19,0x001c(r29)
0x0005f9f0 sw r18,0x0018(r29)
0x0005f9f4 sw r17,0x0014(r29)
0x0005f9f8 sw r16,0x0010(r29)
0x0005f9fc addu r17,r4,r0
0x0005fa00 addu r18,r5,r0
0x0005fa04 addu r22,r6,r0
0x0005fa08 addu r21,r7,r0
0x0005fa0c addu r20,r0,r0
0x0005fa10 beq r0,r0,0x0005fa8c
0x0005fa14 addu r16,r0,r0
0x0005fa18 addu r2,r17,r16
0x0005fa1c lw r4,0x0000(r2)
0x0005fa20 addu r5,r20,r0
0x0005fa24 addu r3,r20,r0
0x0005fa28 beq r0,r0,0x0005fa58
0x0005fa2c sll r6,r20,0x02
0x0005fa30 addu r2,r17,r6
0x0005fa34 lw r2,0x0000(r2)
0x0005fa38 nop
0x0005fa3c slt r1,r2,r4
0x0005fa40 beq r1,r0,0x0005fa50
0x0005fa44 addu r7,r2,r0
0x0005fa48 addu r5,r3,r0
0x0005fa4c addu r4,r7,r0
0x0005fa50 addi r3,r3,0x0001
0x0005fa54 addi r6,r6,0x0004
0x0005fa58 slt r1,r3,r21
0x0005fa5c bne r1,r0,0x0005fa30
0x0005fa60 nop
0x0005fa64 sll r2,r5,0x02
0x0005fa68 addu r4,r17,r16
0x0005fa6c addu r19,r2,r0
0x0005fa70 jal 0x000e52c0
0x0005fa74 addu r5,r17,r2
0x0005fa78 addu r4,r18,r16
0x0005fa7c jal 0x000e52c0
0x0005fa80 addu r5,r18,r19
0x0005fa84 addi r20,r20,0x0001
0x0005fa88 addi r16,r16,0x0004
0x0005fa8c slt r1,r20,r21
0x0005fa90 bne r1,r0,0x0005fa18
0x0005fa94 nop
0x0005fa98 addu r4,r17,r0
0x0005fa9c addu r5,r22,r0
0x0005faa0 jal 0x0005fbb4
0x0005faa4 addu r6,r21,r0
0x0005faa8 lw r31,0x002c(r29)
0x0005faac lw r22,0x0028(r29)
0x0005fab0 lw r21,0x0024(r29)
0x0005fab4 lw r20,0x0020(r29)
0x0005fab8 lw r19,0x001c(r29)
0x0005fabc lw r18,0x0018(r29)
0x0005fac0 lw r17,0x0014(r29)
0x0005fac4 lw r16,0x0010(r29)
0x0005fac8 jr r31
0x0005facc addiu r29,r29,0x0030