/**
 * Select random move from a given array.
 */
int selectRandomMove(arrayPtr) {
  numMoves = 0
  
  for(i = 0; i < 4; i++)
    if(arrayPtr[i] == 1)
      newArray[numMoves++] = i
  
  return newArray[random(numMoves)]
}

0x0005ef58 addiu r29,r29,0xffe0
0x0005ef5c sw r31,0x0010(r29)
0x0005ef60 addu r5,r0,r0
0x0005ef64 addu r3,r0,r0
0x0005ef68 beq r0,r0,0x0005efa0
0x0005ef6c addu r6,r0,r0
0x0005ef70 addu r2,r4,r6
0x0005ef74 lh r2,0x0000(r2)
0x0005ef78 addiu r1,r0,0x0001
0x0005ef7c bne r2,r1,0x0005ef98
0x0005ef80 nop
0x0005ef84 addu r2,r5,r0
0x0005ef88 addi r5,r2,0x0001
0x0005ef8c sll r2,r2,0x01
0x0005ef90 addu r2,r29,r2
0x0005ef94 sh r3,0x0018(r2)
0x0005ef98 addi r3,r3,0x0001
0x0005ef9c addi r6,r6,0x0002
0x0005efa0 slti r1,r3,0x0004
0x0005efa4 bne r1,r0,0x0005ef70
0x0005efa8 nop
0x0005efac jal 0x000a36d4
0x0005efb0 addu r4,r5,r0
0x0005efb4 sll r2,r2,0x01
0x0005efb8 addu r2,r29,r2
0x0005efbc lw r31,0x0010(r29)
0x0005efc0 lh r2,0x0018(r2)
0x0005efc4 jr r31
0x0005efc8 addiu r29,r29,0x0020