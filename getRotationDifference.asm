int,int,int getRotationDifference(locationPtr, targetPtr) {
  locationPtr = locationPtr
  
  posY1 = load(targetPtr + 0x08)
  posY2 = load(locationPtr + 0x80)
  diffY = posY1 - posY2
  
  posX1 = load(locationPtr + 0x78)
  posX2 = load(targetPtr)
  diffX = posX2 - posX1
  
  targetAngle = atan(diffY, diffX)
  currentRotation = load(locationPtr + 0x72)
  
  if(currentRotation < targetAngle) {
    clockwiseDiff = targetAngle - currentRotation
    counterClockwiseDiff = currentRotation - targetAngle + 0x1000
  }
  else {
    clockwiseDiff = targetAngle - currentRotation + 0x1000
    counterClockwiseDiff = currentRotation - targetAngle
  }
  
  return targetAngle, counterClockwiseDiff, clockwiseDiff
}

0x000b6edc addiu r29,r29,0xffd8
0x000b6ee0 sw r31,0x0020(r29)
0x000b6ee4 sw r19,0x001c(r29)
0x000b6ee8 sw r18,0x0018(r29)
0x000b6eec sw r17,0x0014(r29)
0x000b6ef0 sw r16,0x0010(r29)
0x000b6ef4 addu r16,r4,r0
0x000b6ef8 lw r3,0x0008(r5)
0x000b6efc lw r2,0x0080(r16)
0x000b6f00 lw r19,0x0038(r29)
0x000b6f04 sub r2,r3,r2
0x000b6f08 sll r4,r2,0x10
0x000b6f0c lw r3,0x0078(r16)
0x000b6f10 lw r2,0x0000(r5)
0x000b6f14 addu r17,r6,r0
0x000b6f18 sub r2,r2,r3
0x000b6f1c sll r5,r2,0x10
0x000b6f20 addu r18,r7,r0
0x000b6f24 sra r4,r4,0x10
0x000b6f28 jal 0x000a37fc
0x000b6f2c sra r5,r5,0x10
0x000b6f30 sh r2,0x0000(r17)
0x000b6f34 lh r3,0x0000(r17)
0x000b6f38 lh r2,0x0072(r16)
0x000b6f3c addu r5,r3,r0
0x000b6f40 slt r1,r2,r3
0x000b6f44 beq r1,r0,0x000b6f70
0x000b6f48 addu r4,r2,r0
0x000b6f4c sub r2,r5,r4
0x000b6f50 sh r2,0x0000(r19)
0x000b6f54 lh r3,0x0000(r17)
0x000b6f58 addiu r2,r0,0x1000
0x000b6f5c lh r4,0x0072(r16)
0x000b6f60 sub r2,r2,r3
0x000b6f64 add r2,r4,r2
0x000b6f68 beq r0,r0,0x000b6f94
0x000b6f6c sh r2,0x0000(r18)
0x000b6f70 addiu r2,r0,0x1000
0x000b6f74 sub r2,r2,r4
0x000b6f78 add r2,r5,r2
0x000b6f7c sh r2,0x0000(r19)
0x000b6f80 lh r3,0x0072(r16)
0x000b6f84 lh r2,0x0000(r17)
0x000b6f88 nop
0x000b6f8c sub r2,r3,r2
0x000b6f90 sh r2,0x0000(r18)
0x000b6f94 lw r31,0x0020(r29)
0x000b6f98 lw r19,0x001c(r29)
0x000b6f9c lw r18,0x0018(r29)
0x000b6fa0 lw r17,0x0014(r29)
0x000b6fa4 lw r16,0x0010(r29)
0x000b6fa8 jr r31
0x000b6fac addiu r29,r29,0x0028