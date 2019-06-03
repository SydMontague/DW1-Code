/**
 * Sets the visible status of objects.
 * objId -> object to start setting the visibility of
 * numObjs -> number of objects to set the visibility of
 * visible -> the visible status to set
 */
setObjectsVisible(objId, numObjs, visible) {
  for(i = 0; i < numObjs; i++)
    store(0x14F361 + (objId + i) * 34, visible)
}

0x000b5984 beq r0,r0,0x000b59b0
0x000b5988 addu r7,r0,r0
0x000b598c add r3,r4,r7
0x000b5990 sll r2,r3,0x04
0x000b5994 add r2,r2,r3
0x000b5998 sll r3,r2,0x01
0x000b599c lui r2,0x8015
0x000b59a0 addiu r2,r2,0xf361
0x000b59a4 addu r2,r2,r3
0x000b59a8 sb r6,0x0000(r2)
0x000b59ac addi r7,r7,0x0001
0x000b59b0 slt r1,r7,r5
0x000b59b4 bne r1,r0,0x000b598c
0x000b59b8 nop
0x000b59bc jr r31
0x000b59c0 nop