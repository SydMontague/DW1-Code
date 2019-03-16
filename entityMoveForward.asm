void entityMoveForward(entityPtr) {
  somePtr1 = load(entityPtr + 0x0C)
  someArray = short[41]
  
  for(i = 0; i < 41; i++)
    someArray[i] = load(somePtr1 + i * 2)
  
  someValue1 = someArray[17] // load(sp + 0x66)
  someValue2 = someArray[35] // load(sp + 0x8A)
  
  if(someValue1 != 0 && someValue2 <= someValue1)
    velocity = (someArray[26] + someArray[40]) << 0x0F
  else
    velocity = someArray[26] << 0x0F
  
  locationPtr = load(entityPtr + 0x04)
  
  vector = { 0, 0, velocity }
  rotMatrix = int[3][3]
  rotatedVector = int[3]
  
  rotVecToRotMatrix(locationPtr + 0x70, rotMatrix)
  rotateVectorByMatrix(rotMatrix, vector, rotatedVector)
  
  posX = (load(entityPtr + 0x10) + rotatedVector[0]) >> 0x0F
  posZ = (load(entityPtr + 0x18) + rotatedVector[2]) >> 0x0F
  
  store(locationPtr + 0x78, posX)
  store(locationPtr + 0x7C, 0)
  store(locationPtr + 0x80, posZ)
}

0x000d4f10 addiu r29,r29,0xff48
0x000d4f14 sw r31,0x0018(r29)
0x000d4f18 sw r17,0x0014(r29)
0x000d4f1c sw r16,0x0010(r29)
0x000d4f20 addu r17,r4,r0
0x000d4f24 lw r24,0x000c(r17)
0x000d4f28 addiu r15,r29,0x0044
0x000d4f2c addiu r25,r0,0x0029
0x000d4f30 lh r14,0x0000(r24)
0x000d4f34 addiu r25,r25,0xffff
0x000d4f38 sh r14,0x0000(r15)
0x000d4f3c addiu r24,r24,0x0002
0x000d4f40 bgtz r25,0x000d4f30
0x000d4f44 addiu r15,r15,0x0002
0x000d4f48 addiu r2,r29,0x0066
0x000d4f4c lh r2,0x0000(r2)
0x000d4f50 addiu r4,r29,0x0078
0x000d4f54 beq r2,r0,0x000d4f94
0x000d4f58 addu r3,r2,r0
0x000d4f5c lh r2,0x008a(r29)
0x000d4f60 nop
0x000d4f64 sub r2,r2,r3
0x000d4f68 bgtz r2,0x000d4f88
0x000d4f6c nop
0x000d4f70 lb r3,0x0094(r29)
0x000d4f74 lh r2,0x0000(r4)
0x000d4f78 nop
0x000d4f7c add r2,r2,r3
0x000d4f80 beq r0,r0,0x000d4fa0
0x000d4f84 sll r2,r2,0x0f
0x000d4f88 lh r2,0x0000(r4)
0x000d4f8c beq r0,r0,0x000d4fa0
0x000d4f90 sll r2,r2,0x0f
0x000d4f94 lh r2,0x0000(r4)
0x000d4f98 nop
0x000d4f9c sll r2,r2,0x0f
0x000d4fa0 lw r16,0x0004(r17)
0x000d4fa4 addiu r5,r29,0x0098
0x000d4fa8 sw r0,0x0024(r29)
0x000d4fac sw r0,0x0028(r29)
0x000d4fb0 sw r2,0x002c(r29)
0x000d4fb4 jal 0x0009b804
0x000d4fb8 addiu r4,r16,0x0070
0x000d4fbc addiu r4,r29,0x0098
0x000d4fc0 addiu r5,r29,0x0024
0x000d4fc4 jal 0x0009ab10
0x000d4fc8 addiu r6,r29,0x0034
0x000d4fcc addiu r4,r17,0x000c
0x000d4fd0 lw r3,0x0004(r4)
0x000d4fd4 lw r2,0x0034(r29)
0x000d4fd8 nop
0x000d4fdc add r2,r3,r2
0x000d4fe0 sra r2,r2,0x0f
0x000d4fe4 sw r2,0x0078(r16)
0x000d4fe8 sw r0,0x007c(r16)
0x000d4fec lw r3,0x000c(r4)
0x000d4ff0 lw r2,0x003c(r29)
0x000d4ff4 nop
0x000d4ff8 add r2,r3,r2
0x000d4ffc sra r2,r2,0x0f
0x000d5000 sw r2,0x0080(r16)
0x000d5004 lw r31,0x0018(r29)
0x000d5008 lw r17,0x0014(r29)
0x000d500c lw r16,0x0010(r29)
0x000d5010 jr r31
0x000d5014 addiu r29,r29,0x00b8