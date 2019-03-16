int isLinearPathBlocked(tileX1, tileY1, tileX2, tileY2) {
  if(tileX1 < 0)
    tileX1 = 0
  if(tileX2 < 0)
    tileX2 = 0
  if(tileY1 < 0)
    tileY1 = 0
  if(tileY2 < 0)
    tileY2 = 0
  if(tileX1 >= 100)
    tileX1 = 99
  if(tileX2 >= 100)
    tileX2 = 99
  if(tileY1 >= 100)
    tileY1 = 99
  if(tileY2 >= 100)
    tileY2 = 99
    
  if(tileX1 == tileX2 && tileY1 == tileY2)
    return 0
  
  diffY = tileY2 - tileY1
  diffX = tileX2 - tielX1
  
  lTileX = tileX1
  lTileY = tileY1
  
  if(absDiffX >= absDiffY) {
    absDiffX = abs(diffX)
    subStepCounter = absDiffX
    
    yStep = diffY / absDiffX
    ySubStep = diffY % absDiffX
    
    subStepDirection = ySubStep < 0 ? -1 : 1
    
    ySubStep = abs(ySubStep)
    
    for(x = 0; x < absDiffX; x++) {
      if(ySubStep != 0) {
        subStepCounter = subStepCounter - ySubStep
        
        if(subStepCounter <= 0) {
          lTileY = lTileY + subStepDirection
          subStepCounter = subStepCounter + absDiffX
        }
      }
      else
        lTileY = lTileY + yStep
      
      if(diffX > 0)
        lTileX++
      else
        lTileX--
      
      if(load(0x1AF398 + lTileX + lTileY * 100) & 0x0080 != 0)
        return 1
    }
  }
  else {
    absDiffY = abs(diffY)
    subStepCounter = absDiffY
    
    xStep = diffX / absDiffY
    xSubStep = diffX % absDiffY
    
    subStepDirection = xSubStep < 0 ? -1 : 1
    
    xSubStep = abs(xSubStep)
    
    for(y = 0; y < absDiffY; y++) {
      if(xSubStep != 0) {
        subStepCounter = subStepCounter - xSubStep
        
        if(subStepCounter <= 0) {
          lTileX = lTileX + subStepDirection
          subStepCounter = subStepCounter + absDiffY
        }
      }
      else
        lTileX = lTileX + xStep
    }
    
    if(diffY > 0)
      lTileY++
    else
      lTileY--
    
    if(load(0x1AF398 + lTileX + lTileY * 100) & 0x0080 != 0)
      return 1
  }
  
  return 0
}

0x000d3c70 addiu r29,r29,0xffc8
0x000d3c74 sw r31,0x0034(r29)
0x000d3c78 sw r30,0x0030(r29)
0x000d3c7c sw r23,0x002c(r29)
0x000d3c80 sw r22,0x0028(r29)
0x000d3c84 sw r21,0x0024(r29)
0x000d3c88 sw r20,0x0020(r29)
0x000d3c8c sw r19,0x001c(r29)
0x000d3c90 sw r18,0x0018(r29)
0x000d3c94 sw r17,0x0014(r29)
0x000d3c98 bgez r4,0x000d3ca4
0x000d3c9c sw r16,0x0010(r29)
0x000d3ca0 addu r4,r0,r0
0x000d3ca4 bgez r6,0x000d3cb0
0x000d3ca8 nop
0x000d3cac addu r6,r0,r0
0x000d3cb0 bgez r5,0x000d3cbc
0x000d3cb4 nop
0x000d3cb8 addu r5,r0,r0
0x000d3cbc bgez r7,0x000d3cc8
0x000d3cc0 nop
0x000d3cc4 addu r7,r0,r0
0x000d3cc8 slti r1,r4,0x0064
0x000d3ccc bne r1,r0,0x000d3cd8
0x000d3cd0 nop
0x000d3cd4 addiu r4,r0,0x0063
0x000d3cd8 slti r1,r6,0x0064
0x000d3cdc bne r1,r0,0x000d3ce8
0x000d3ce0 nop
0x000d3ce4 addiu r6,r0,0x0063
0x000d3ce8 slti r1,r5,0x0064
0x000d3cec bne r1,r0,0x000d3cf8
0x000d3cf0 nop
0x000d3cf4 addiu r5,r0,0x0063
0x000d3cf8 slti r1,r7,0x0064
0x000d3cfc bne r1,r0,0x000d3d08
0x000d3d00 nop
0x000d3d04 addiu r7,r0,0x0063
0x000d3d08 bne r4,r6,0x000d3d20
0x000d3d0c nop
0x000d3d10 bne r5,r7,0x000d3d20
0x000d3d14 nop
0x000d3d18 beq r0,r0,0x000d4004
0x000d3d1c addu r2,r0,r0
0x000d3d20 sub r2,r7,r5
0x000d3d24 sll r23,r2,0x10
0x000d3d28 sub r2,r6,r4
0x000d3d2c sll r22,r2,0x10
0x000d3d30 sra r22,r22,0x10
0x000d3d34 sll r18,r4,0x18
0x000d3d38 sll r17,r5,0x18
0x000d3d3c sra r23,r23,0x10
0x000d3d40 sra r18,r18,0x18
0x000d3d44 sra r17,r17,0x18
0x000d3d48 addu r30,r22,r0
0x000d3d4c jal 0x0009119c
0x000d3d50 addu r4,r22,r0
0x000d3d54 addu r16,r2,r0
0x000d3d58 addu r19,r23,r0
0x000d3d5c jal 0x0009119c
0x000d3d60 addu r4,r23,r0
0x000d3d64 slt r1,r16,r2
0x000d3d68 bne r1,r0,0x000d3ebc
0x000d3d6c nop
0x000d3d70 jal 0x0009119c
0x000d3d74 addu r4,r30,r0
0x000d3d78 sll r20,r2,0x10
0x000d3d7c sra r20,r20,0x10
0x000d3d80 sll r16,r2,0x10
0x000d3d84 div r19,r20
0x000d3d88 addu r3,r20,r0
0x000d3d8c mflo r2
0x000d3d90 sll r21,r2,0x10
0x000d3d94 nop
0x000d3d98 div r19,r3
0x000d3d9c sra r16,r16,0x10
0x000d3da0 mfhi r2
0x000d3da4 sll r4,r2,0x10
0x000d3da8 sra r4,r4,0x10
0x000d3dac bgez r4,0x000d3dc4
0x000d3db0 sra r21,r21,0x10
0x000d3db4 addiu r2,r0,0xffff
0x000d3db8 sll r19,r2,0x10
0x000d3dbc beq r0,r0,0x000d3dd0
0x000d3dc0 sra r19,r19,0x10
0x000d3dc4 addiu r2,r0,0x0001
0x000d3dc8 sll r19,r2,0x10
0x000d3dcc sra r19,r19,0x10
0x000d3dd0 jal 0x0009119c
0x000d3dd4 nop
0x000d3dd8 sll r4,r2,0x10
0x000d3ddc sra r4,r4,0x10
0x000d3de0 addu r2,r0,r0
0x000d3de4 beq r0,r0,0x000d3ea8
0x000d3de8 addu r3,r20,r0
0x000d3dec beq r4,r0,0x000d3e2c
0x000d3df0 nop
0x000d3df4 sub r5,r16,r4
0x000d3df8 sll r16,r5,0x10
0x000d3dfc sra r16,r16,0x10
0x000d3e00 bgtz r16,0x000d3e40
0x000d3e04 nop
0x000d3e08 sll r5,r19,0x18
0x000d3e0c sra r5,r5,0x18
0x000d3e10 add r5,r17,r5
0x000d3e14 sll r17,r5,0x18
0x000d3e18 add r5,r16,r20
0x000d3e1c sll r16,r5,0x10
0x000d3e20 sra r17,r17,0x18
0x000d3e24 beq r0,r0,0x000d3e40
0x000d3e28 sra r16,r16,0x10
0x000d3e2c sll r5,r21,0x18
0x000d3e30 sra r5,r5,0x18
0x000d3e34 add r5,r17,r5
0x000d3e38 sll r17,r5,0x18
0x000d3e3c sra r17,r17,0x18
0x000d3e40 blez r22,0x000d3e58
0x000d3e44 nop
0x000d3e48 addi r5,r18,0x0001
0x000d3e4c sll r18,r5,0x18
0x000d3e50 beq r0,r0,0x000d3e64
0x000d3e54 sra r18,r18,0x18
0x000d3e58 addi r5,r18,-0x0001
0x000d3e5c sll r18,r5,0x18
0x000d3e60 sra r18,r18,0x18
0x000d3e64 sll r5,r17,0x02
0x000d3e68 add r6,r5,r17
0x000d3e6c sll r5,r6,0x02
0x000d3e70 add r5,r6,r5
0x000d3e74 sll r5,r5,0x02
0x000d3e78 add r6,r18,r5
0x000d3e7c lui r5,0x801b
0x000d3e80 addiu r5,r5,0xf398
0x000d3e84 addu r5,r5,r6
0x000d3e88 lbu r5,0x0000(r5)
0x000d3e8c nop
0x000d3e90 andi r5,r5,0x0080
0x000d3e94 beq r5,r0,0x000d3ea4
0x000d3e98 nop
0x000d3e9c beq r0,r0,0x000d4004
0x000d3ea0 addiu r2,r0,0x0001
0x000d3ea4 addi r2,r2,0x0001
0x000d3ea8 slt r1,r2,r3
0x000d3eac bne r1,r0,0x000d3dec
0x000d3eb0 nop
0x000d3eb4 beq r0,r0,0x000d4004
0x000d3eb8 addu r2,r0,r0
0x000d3ebc jal 0x0009119c
0x000d3ec0 addu r4,r19,r0
0x000d3ec4 sll r20,r2,0x10
0x000d3ec8 sra r20,r20,0x10
0x000d3ecc sll r16,r2,0x10
0x000d3ed0 div r30,r20
0x000d3ed4 addu r3,r20,r0
0x000d3ed8 mflo r2
0x000d3edc sll r21,r2,0x10
0x000d3ee0 nop
0x000d3ee4 div r30,r3
0x000d3ee8 sra r16,r16,0x10
0x000d3eec mfhi r2
0x000d3ef0 sll r4,r2,0x10
0x000d3ef4 sra r4,r4,0x10
0x000d3ef8 bgez r4,0x000d3f10
0x000d3efc sra r21,r21,0x10
0x000d3f00 addiu r2,r0,0xffff
0x000d3f04 sll r19,r2,0x10
0x000d3f08 beq r0,r0,0x000d3f1c
0x000d3f0c sra r19,r19,0x10
0x000d3f10 addiu r2,r0,0x0001
0x000d3f14 sll r19,r2,0x10
0x000d3f18 sra r19,r19,0x10
0x000d3f1c jal 0x0009119c
0x000d3f20 nop
0x000d3f24 sll r4,r2,0x10
0x000d3f28 sra r4,r4,0x10
0x000d3f2c addu r2,r0,r0
0x000d3f30 beq r0,r0,0x000d3ff4
0x000d3f34 addu r3,r20,r0
0x000d3f38 beq r4,r0,0x000d3f78
0x000d3f3c nop
0x000d3f40 sub r5,r16,r4
0x000d3f44 sll r16,r5,0x10
0x000d3f48 sra r16,r16,0x10
0x000d3f4c bgtz r16,0x000d3f8c
0x000d3f50 nop
0x000d3f54 sll r5,r19,0x18
0x000d3f58 sra r5,r5,0x18
0x000d3f5c add r5,r18,r5
0x000d3f60 sll r18,r5,0x18
0x000d3f64 add r5,r16,r20
0x000d3f68 sll r16,r5,0x10
0x000d3f6c sra r18,r18,0x18
0x000d3f70 beq r0,r0,0x000d3f8c
0x000d3f74 sra r16,r16,0x10
0x000d3f78 sll r5,r21,0x18
0x000d3f7c sra r5,r5,0x18
0x000d3f80 add r5,r18,r5
0x000d3f84 sll r18,r5,0x18
0x000d3f88 sra r18,r18,0x18
0x000d3f8c blez r23,0x000d3fa4
0x000d3f90 nop
0x000d3f94 addi r5,r17,0x0001
0x000d3f98 sll r17,r5,0x18
0x000d3f9c beq r0,r0,0x000d3fb0
0x000d3fa0 sra r17,r17,0x18
0x000d3fa4 addi r5,r17,-0x0001
0x000d3fa8 sll r17,r5,0x18
0x000d3fac sra r17,r17,0x18
0x000d3fb0 sll r5,r17,0x02
0x000d3fb4 add r6,r5,r17
0x000d3fb8 sll r5,r6,0x02
0x000d3fbc add r5,r6,r5
0x000d3fc0 sll r5,r5,0x02
0x000d3fc4 add r6,r18,r5
0x000d3fc8 lui r5,0x801b
0x000d3fcc addiu r5,r5,0xf398
0x000d3fd0 addu r5,r5,r6
0x000d3fd4 lbu r5,0x0000(r5)
0x000d3fd8 nop
0x000d3fdc andi r5,r5,0x0080
0x000d3fe0 beq r5,r0,0x000d3ff0
0x000d3fe4 nop
0x000d3fe8 beq r0,r0,0x000d4004
0x000d3fec addiu r2,r0,0x0001
0x000d3ff0 addi r2,r2,0x0001
0x000d3ff4 slt r1,r2,r3
0x000d3ff8 bne r1,r0,0x000d3f38
0x000d3ffc nop
0x000d4000 addu r2,r0,r0
0x000d4004 lw r31,0x0034(r29)
0x000d4008 lw r30,0x0030(r29)
0x000d400c lw r23,0x002c(r29)
0x000d4010 lw r22,0x0028(r29)
0x000d4014 lw r21,0x0024(r29)
0x000d4018 lw r20,0x0020(r29)
0x000d401c lw r19,0x001c(r29)
0x000d4020 lw r18,0x0018(r29)
0x000d4024 lw r17,0x0014(r29)
0x000d4028 lw r16,0x0010(r29)
0x000d402c jr r31
0x000d4030 addiu r29,r29,0x0038