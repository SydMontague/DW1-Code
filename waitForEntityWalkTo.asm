int waitForEntityWalkTo(scriptId1, scriptId2, targetPosX, targetPosZ, val5) {
  entitiyPtr1, entityId1 = loadEntityDataFromScriptId(scriptId1)
  locationPtr1 = load(entitiyPtr1 + 0x04)
  
  if(entityId1 >= 2)
    store(0x13D170 + (entityId1 - 2) * 4, 1)
  
  startPosition = int[4]
  targetPosition = int[4]
  
  startPosition[0] = load(locationPtr1 + 0x78)
  startPosition[1] = load(locationPtr1 + 0x7C)
  startPosition[2] = load(locationPtr1 + 0x80)
  startPosition[3] = load(locationPtr1 + 0x84)
  
  if(scriptId2 == -1) {
    targetPosition[0] = targetPosX
    targetPosition[1] = load(locationPtr1 + 0x7C)
    targetPosition[2] = targetPosZ
  }
  else {
    entityPtr, entityId2 = loadEntityDataFromScriptId(scriptId2)
    locationPtr2 = load(entityPtr + 0x04)
    
    targetPosition[0] = load(locationPtr2 + 0x78)
    targetPosition[1] = load(locationPtr2 + 0x7C)
    targetPosition[2] = load(locationPtr2 + 0x80)
    targetPosition[3] = load(locationPtr2 + 0x84)
  }
  
  if(load(0x134C80) == 0 && val5 == 1) {
    store(0x1387A8, startPosition[0])
    store(0x1387AC, startPosition[1])
    store(0x1387B0, startPosition[2])
    store(0x1387B4, startPosition[3])
    store(0x134C80, 1)
  }
  
  tileX1, tileY1 = getModelTile(startPosition)
  tileX2, tileY2 = getModelTile(targetPosition)
  
  entityLookAtLocation(entitiyPtr1, targetPosition)
  
  if(val5 == 1) {
    0x000D892C(0x1387A8, startPosition)
    
    store(0x1387A8, startPosition[0])
    store(0x1387AC, startPosition[1])
    store(0x1387B0, startPosition[2])
    store(0x1387B4, startPosition[3])
  }
  
  collisionResponse = -1
  
  if(entitiyId2 != -1)
    collisionResponse = entityCheckCollision(0, entitiyPtr1, 0, 0)
  
  // Bug: you can walk towards a position and never reach the proper tile
  if(tileX1 != tileX2 || tileY1 != tileY2) {
    // Bug: collision with entity #9 is ignored
    if(collisionResponse == -1 || collisionResponse >= 9) // no collision with entity 0-8
      return 0
  }
  
  store(0x134C80, 0)
  
  if(entityId1 >= 2)
    store(0x13D170 + (entityId1 - 2) * 4, 0)
  
  return 1
}

0x000ac06c addiu r29,r29,0xffb0
0x000ac070 sw r31,0x0024(r29)
0x000ac074 sw r20,0x0020(r29)
0x000ac078 sw r19,0x001c(r29)
0x000ac07c sw r18,0x0018(r29)
0x000ac080 sw r17,0x0014(r29)
0x000ac084 sw r4,0x0050(r29)
0x000ac088 sw r16,0x0010(r29)
0x000ac08c addiu r2,r0,0xffff
0x000ac090 sll r16,r2,0x10
0x000ac094 lb r18,0x0060(r29)
0x000ac098 sw r5,0x0054(r29)
0x000ac09c addu r19,r6,r0
0x000ac0a0 addu r20,r7,r0
0x000ac0a4 sra r16,r16,0x10
0x000ac0a8 jal 0x000ac2f8
0x000ac0ac addiu r4,r29,0x0050
0x000ac0b0 lbu r3,0x0050(r29)
0x000ac0b4 nop
0x000ac0b8 sltiu r1,r3,0x0002
0x000ac0bc bne r1,r0,0x000ac0e0
0x000ac0c0 addu r17,r2,r0
0x000ac0c4 addi r2,r3,-0x0002
0x000ac0c8 sll r3,r2,0x02
0x000ac0cc lui r2,0x8014
0x000ac0d0 addiu r2,r2,0xd170
0x000ac0d4 addiu r4,r0,0x0001
0x000ac0d8 addu r2,r2,r3
0x000ac0dc sw r4,0x0000(r2)
0x000ac0e0 lw r2,0x0004(r17)
0x000ac0e4 addiu r1,r0,0x00ff
0x000ac0e8 lw r5,0x0078(r2)
0x000ac0ec lw r4,0x007c(r2)
0x000ac0f0 lw r3,0x0080(r2)
0x000ac0f4 lw r2,0x0084(r2)
0x000ac0f8 sw r5,0x0028(r29)
0x000ac0fc sw r4,0x002c(r29)
0x000ac100 sw r3,0x0030(r29)
0x000ac104 sw r2,0x0034(r29)
0x000ac108 lbu r2,0x0054(r29)
0x000ac10c nop
0x000ac110 bne r2,r1,0x000ac138
0x000ac114 nop
0x000ac118 sw r19,0x0038(r29)
0x000ac11c lw r2,0x0004(r17)
0x000ac120 nop
0x000ac124 lw r2,0x007c(r2)
0x000ac128 nop
0x000ac12c sw r2,0x003c(r29)
0x000ac130 beq r0,r0,0x000ac168
0x000ac134 sw r20,0x0040(r29)
0x000ac138 jal 0x000ac2f8
0x000ac13c addiu r4,r29,0x0054
0x000ac140 lw r2,0x0004(r2)
0x000ac144 nop
0x000ac148 lw r5,0x0078(r2)
0x000ac14c lw r4,0x007c(r2)
0x000ac150 lw r3,0x0080(r2)
0x000ac154 lw r2,0x0084(r2)
0x000ac158 sw r5,0x0038(r29)
0x000ac15c sw r4,0x003c(r29)
0x000ac160 sw r3,0x0040(r29)
0x000ac164 sw r2,0x0044(r29)
0x000ac168 lb r2,-0x6eac(r28)
0x000ac16c nop
0x000ac170 bne r2,r0,0x000ac1bc
0x000ac174 nop
0x000ac178 addiu r1,r0,0x0001
0x000ac17c bne r18,r1,0x000ac1bc
0x000ac180 nop
0x000ac184 lw r5,0x0028(r29)
0x000ac188 lui r1,0x8014
0x000ac18c sw r5,-0x7858(r1)
0x000ac190 lw r4,0x002c(r29)
0x000ac194 lui r1,0x8014
0x000ac198 sw r4,-0x7854(r1)
0x000ac19c lw r3,0x0030(r29)
0x000ac1a0 lui r1,0x8014
0x000ac1a4 sw r3,-0x7850(r1)
0x000ac1a8 lw r2,0x0034(r29)
0x000ac1ac lui r1,0x8014
0x000ac1b0 sw r2,-0x784c(r1)
0x000ac1b4 addiu r2,r0,0x0001
0x000ac1b8 sb r2,-0x6eac(r28)
0x000ac1bc addiu r4,r29,0x0028
0x000ac1c0 addiu r5,r29,0x0048
0x000ac1c4 jal 0x000c0f28
0x000ac1c8 addiu r6,r29,0x004a
0x000ac1cc addiu r4,r29,0x0038
0x000ac1d0 addiu r5,r29,0x004c
0x000ac1d4 jal 0x000c0f28
0x000ac1d8 addiu r6,r29,0x004e
0x000ac1dc addu r4,r17,r0
0x000ac1e0 jal 0x000d459c
0x000ac1e4 addiu r5,r29,0x0038
0x000ac1e8 addiu r1,r0,0x0001
0x000ac1ec bne r18,r1,0x000ac234
0x000ac1f0 nop
0x000ac1f4 lui r4,0x8014
0x000ac1f8 addiu r4,r4,0x87a8
0x000ac1fc jal 0x000d892c
0x000ac200 addiu r5,r29,0x0028
0x000ac204 lw r5,0x0028(r29)
0x000ac208 lui r1,0x8014
0x000ac20c sw r5,-0x7858(r1)
0x000ac210 lw r4,0x002c(r29)
0x000ac214 lui r1,0x8014
0x000ac218 sw r4,-0x7854(r1)
0x000ac21c lw r3,0x0030(r29)
0x000ac220 lui r1,0x8014
0x000ac224 sw r3,-0x7850(r1)
0x000ac228 lw r2,0x0034(r29)
0x000ac22c lui r1,0x8014
0x000ac230 sw r2,-0x784c(r1)
0x000ac234 lbu r2,0x0054(r29)
0x000ac238 addiu r1,r0,0x00ff
0x000ac23c beq r2,r1,0x000ac260
0x000ac240 nop
0x000ac244 addu r4,r0,r0
0x000ac248 addu r5,r17,r0
0x000ac24c addu r6,r0,r0
0x000ac250 jal 0x000d45ec
0x000ac254 addu r7,r0,r0
0x000ac258 sll r16,r2,0x10
0x000ac25c sra r16,r16,0x10
0x000ac260 lh r3,0x0048(r29)
0x000ac264 lh r2,0x004c(r29)
0x000ac268 nop
0x000ac26c bne r3,r2,0x000ac288
0x000ac270 nop
0x000ac274 lh r3,0x004a(r29)
0x000ac278 lh r2,0x004e(r29)
0x000ac27c nop
0x000ac280 beq r3,r2,0x000ac2a0
0x000ac284 nop
0x000ac288 addiu r1,r0,0xffff
0x000ac28c beq r16,r1,0x000ac2d4
0x000ac290 nop
0x000ac294 slti r1,r16,0x0009
0x000ac298 beq r1,r0,0x000ac2d4
0x000ac29c nop
0x000ac2a0 lbu r2,0x0050(r29)
0x000ac2a4 nop
0x000ac2a8 sltiu r1,r2,0x0002
0x000ac2ac bne r1,r0,0x000ac2cc
0x000ac2b0 sb r0,-0x6eac(r28)
0x000ac2b4 addi r2,r2,-0x0002
0x000ac2b8 sll r3,r2,0x02
0x000ac2bc lui r2,0x8014
0x000ac2c0 addiu r2,r2,0xd170
0x000ac2c4 addu r2,r2,r3
0x000ac2c8 sw r0,0x0000(r2)
0x000ac2cc beq r0,r0,0x000ac2d8
0x000ac2d0 addiu r2,r0,0x0001
0x000ac2d4 addu r2,r0,r0
0x000ac2d8 lw r31,0x0024(r29)
0x000ac2dc lw r20,0x0020(r29)
0x000ac2e0 lw r19,0x001c(r29)
0x000ac2e4 lw r18,0x0018(r29)
0x000ac2e8 lw r17,0x0014(r29)
0x000ac2ec lw r16,0x0010(r29)
0x000ac2f0 jr r31
0x000ac2f4 addiu r29,r29,0x0050