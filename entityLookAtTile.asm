void entityLookAtTile(playerPtr, tileX, tileY) {
  posArray = int[3]

  posArray[0] = (tileX - 50) * 100 + 50
  posArray[1] = 0
  posArray[2] = (tileY + 50) * 100 - 50
  
  entityLookAtLocation(playerPtr, posArray)
}

0x000e6078 addi r3,r5,-0x0032
0x000e607c addiu r29,r29,0xffd8
0x000e6080 sll r2,r3,0x02
0x000e6084 add r3,r2,r3
0x000e6088 sll r2,r3,0x02
0x000e608c add r2,r3,r2
0x000e6090 sll r2,r2,0x02
0x000e6094 addi r2,r2,0x0032
0x000e6098 sw r2,0x0018(r29)
0x000e609c addiu r2,r0,0x0032
0x000e60a0 sub r3,r2,r6
0x000e60a4 sll r2,r3,0x02
0x000e60a8 add r3,r2,r3
0x000e60ac sll r2,r3,0x02
0x000e60b0 add r2,r3,r2
0x000e60b4 sll r2,r2,0x02
0x000e60b8 sw r0,0x001c(r29)
0x000e60bc addi r2,r2,-0x0032
0x000e60c0 sw r31,0x0010(r29)
0x000e60c4 sw r2,0x0020(r29)
0x000e60c8 jal 0x000d459c
0x000e60cc addiu r5,r29,0x0018
0x000e60d0 lw r31,0x0010(r29)
0x000e60d4 nop
0x000e60d8 jr r31
0x000e60dc addiu r29,r29,0x0028