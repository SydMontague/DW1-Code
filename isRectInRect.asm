int isRectInRect(array, xMin, yMin, xMax, yMax) {
  posYmin = array[1] - array[3]
  posXmax = array[0] + array[2]
  
  if(posXmax < xMin)
    return 0
    
  if(xMax < array[0])
    return 0
  
  if(yMin < posYmin)
    return 0
  
  if(array[1] < yMax)
    return 0
    
  return 1
}

0x000d3858 lh r3,0x0002(r4)
0x000d385c lh r2,0x0006(r4)
0x000d3860 addu r9,r3,r0
0x000d3864 sub r8,r3,r2
0x000d3868 lh r3,0x0004(r4)
0x000d386c lh r2,0x0000(r4)
0x000d3870 lw r10,0x0010(r29)
0x000d3874 addu r4,r2,r0
0x000d3878 add r2,r2,r3
0x000d387c slt r1,r2,r5
0x000d3880 beq r1,r0,0x000d3890
0x000d3884 nop
0x000d3888 beq r0,r0,0x000d38cc
0x000d388c addu r2,r0,r0
0x000d3890 slt r1,r7,r4
0x000d3894 beq r1,r0,0x000d38a4
0x000d3898 nop
0x000d389c beq r0,r0,0x000d38cc
0x000d38a0 addu r2,r0,r0
0x000d38a4 slt r1,r6,r8
0x000d38a8 beq r1,r0,0x000d38b8
0x000d38ac nop
0x000d38b0 beq r0,r0,0x000d38cc
0x000d38b4 addu r2,r0,r0
0x000d38b8 slt r1,r9,r10
0x000d38bc beq r1,r0,0x000d38cc
0x000d38c0 addiu r2,r0,0x0001
0x000d38c4 beq r0,r0,0x000d38cc
0x000d38c8 addu r2,r0,r0
0x000d38cc jr r31
0x000d38d0 nop