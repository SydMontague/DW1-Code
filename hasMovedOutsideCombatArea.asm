/**
 * Checks whether position B has moved outside of a rectangle with given
 * width and height centered in the middle of the screen, i.e. the combat area.
 *
 * Return 1 when the new position has moved outside, 0 otherwise.
 */
int hasMovedOutsideCombatArea(screenPosOld, screenPosNew, width, height) {
  posX = screenPosNew[0] - load(0x134D8C) // transform coordinate
  posY = screenPosNew[1] - load(0x134D88) // transform coordinate
  
  if(screenPosOld[0] > screenPosNew[0] && posX < -width / 2)
    return 1
  
  if(screenPosOld[0] < screenPosNew[0] && posX >  width / 2)
    return 1
  
  if(screenPosOld[1] > screenPosNew[1] && posY < -height / 2)
    return 1
  
  if(screenPosOld[1] < screenPosNew[1] && posY >  height / 2)
    return 1
  
  return 0
}

0x000d38d4 lh r8,0x0000(r5)
0x000d38d8 lw r3,-0x6da0(r28)
0x000d38dc addu r2,r8,r0
0x000d38e0 sub r8,r8,r3
0x000d38e4 sub r3,r0,r6
0x000d38e8 addu r9,r8,r0
0x000d38ec addu r10,r6,r0
0x000d38f0 bgez r3,0x000d3900
0x000d38f4 sra r25,r3,0x01
0x000d38f8 addiu r3,r3,0x0001
0x000d38fc sra r25,r3,0x01
0x000d3900 slt r1,r8,r25
0x000d3904 beq r1,r0,0x000d3928
0x000d3908 nop
0x000d390c lh r3,0x0000(r4)
0x000d3910 nop
0x000d3914 slt r1,r2,r3
0x000d3918 beq r1,r0,0x000d3928
0x000d391c nop
0x000d3920 beq r0,r0,0x000d39f0
0x000d3924 addiu r2,r0,0x0001
0x000d3928 bgez r10,0x000d3938
0x000d392c sra r25,r10,0x01
0x000d3930 addiu r3,r10,0x0001
0x000d3934 sra r25,r3,0x01
0x000d3938 slt r1,r25,r9
0x000d393c beq r1,r0,0x000d3960
0x000d3940 nop
0x000d3944 lh r3,0x0000(r4)
0x000d3948 nop
0x000d394c slt r1,r3,r2
0x000d3950 beq r1,r0,0x000d3960
0x000d3954 nop
0x000d3958 beq r0,r0,0x000d39f0
0x000d395c addiu r2,r0,0x0001
0x000d3960 lh r3,0x0002(r5)
0x000d3964 lw r2,-0x6da4(r28)
0x000d3968 addu r5,r3,r0
0x000d396c sub r3,r3,r2
0x000d3970 sub r2,r0,r7
0x000d3974 addu r6,r3,r0
0x000d3978 addu r8,r7,r0
0x000d397c bgez r2,0x000d398c
0x000d3980 sra r25,r2,0x01
0x000d3984 addiu r2,r2,0x0001
0x000d3988 sra r25,r2,0x01
0x000d398c slt r1,r3,r25
0x000d3990 beq r1,r0,0x000d39b4
0x000d3994 nop
0x000d3998 lh r2,0x0002(r4)
0x000d399c nop
0x000d39a0 slt r1,r5,r2
0x000d39a4 beq r1,r0,0x000d39b4
0x000d39a8 nop
0x000d39ac beq r0,r0,0x000d39f0
0x000d39b0 addiu r2,r0,0x0001
0x000d39b4 bgez r8,0x000d39c4
0x000d39b8 sra r25,r8,0x01
0x000d39bc addiu r2,r8,0x0001
0x000d39c0 sra r25,r2,0x01
0x000d39c4 slt r1,r25,r6
0x000d39c8 beq r1,r0,0x000d39ec
0x000d39cc nop
0x000d39d0 lh r2,0x0002(r4)
0x000d39d4 nop
0x000d39d8 slt r1,r2,r5
0x000d39dc beq r1,r0,0x000d39ec
0x000d39e0 nop
0x000d39e4 beq r0,r0,0x000d39f0
0x000d39e8 addiu r2,r0,0x0001
0x000d39ec addu r2,r0,r0
0x000d39f0 jr r31
0x000d39f4 nop