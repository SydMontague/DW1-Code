int entityCheckEntityCollision(entityPtr, entityPtr2, diffX, diffY) {
  
  entityType1 = load(entityPtr + 0x00)
  entityType2 = load(entityPtr2 + 0x00)
  
  locPtr1 = load(entityPtr + 0x04) + 0x78
  locPtr2 = load(entityPtr2 + 0x04) + 0x78
  
  radius1 = load(0x12CECC + entityType1 * 52) // radius
  radius2 = load(0x12CECC + entityType2 * 52) // radius
  
  array = short[4]
  array[0] = load(locPtr2 + 0x00) - radius2
  array[1] = load(locPtr2 + 0x08) + radius2
  array[2] = radius2 * 2
  array[3] = radius2 * 2
  
  posX1 = load(locPtr1 + 0x00)
  posY1 = load(locPtr1 + 0x08)
  
  xMin = posX1 - radius1
  xMax = posX1 + radius1
  yMax = posY1 + radius1
  yMin = posY1 - radius1
  
  if(load(0x134F0A) == 0 && load(0x12F344) == entityPtr) {
    isXDown = (load(0x134EE4) & ~load(0x134EE8)) & 0x40 // polled input and last polled input
    
    // check if there is a Digimon you try to talk to
    if(isXDown != 0 && load(entityPtr + 0x2E) == 0) {
      rotationPtr = load(entityPtr + 0x04) + 0x72
      rotation = load(rotationPtr)
      
      if(rotation > 0 && rotation < 0x0800)
        xMin = xMin - 50
      
      if(rotation >= 0x0801 && rotation < 0x1000)
        xMax = xMax + 50
        
      if(rotation < 0x0400 && rotation >= 0x0C01)
        yMin = yMin - 50
        
      if(rotation >= 0x0401 && rotation < 0x0C00)
        yMax = yMax + 50
    }
    
    if(isRectInRect(array, xMin, yMax, xMin, yMin) != 0)
      return 1
    
    if(isRectInRect(array, xMax, yMax, xMax, yMin) != 0)
      return 1
    
    if(isRectInRect(array, xMin, yMin, xMax, yMin) != 0)
      return 1
    
    if(isRectInRect(array, xMin, yMax, xMax, yMax) != 0)
      return 1
    
    return entityIsInEntity(entityPtr, entityPtr2)
  }
  else {
    if(diffX < 0 && isRectInRect(array, xMin, yMax, xMin, yMin) != 0)
      return 1
    
    if(diffX > 0 && isRectInRect(array, xMax, yMax, xMax, yMin) != 0)
      return 1
    
    if(diffY < 0 && isRectInRect(array, xMin, yMin, xMax, yMin) != 0)
      return 1
    
    if(diffY > 0 && isRectInRect(array, xMin, yMax, xMax, yMax) != 0)
      return 1
  }
  
  return 0
}

0x000d50dc addiu r29,r29,0xffb8
0x000d50e0 sw r31,0x0038(r29)
0x000d50e4 sw r23,0x0034(r29)
0x000d50e8 sw r22,0x0030(r29)
0x000d50ec sw r21,0x002c(r29)
0x000d50f0 sw r20,0x0028(r29)
0x000d50f4 sw r19,0x0024(r29)
0x000d50f8 sw r18,0x0020(r29)
0x000d50fc sw r17,0x001c(r29)
0x000d5100 sw r16,0x0018(r29)
0x000d5104 addu r20,r4,r0
0x000d5108 lw r2,0x0004(r20)
0x000d510c lw r4,0x0000(r20)
0x000d5110 addiu r3,r2,0x0078
0x000d5114 sll r2,r4,0x01
0x000d5118 add r2,r2,r4
0x000d511c sll r2,r2,0x02
0x000d5120 addu r21,r5,r0
0x000d5124 add r2,r2,r4
0x000d5128 lw r4,0x0004(r21)
0x000d512c addu r23,r7,r0
0x000d5130 lw r5,0x0000(r21)
0x000d5134 addiu r7,r4,0x0078
0x000d5138 sll r4,r5,0x01
0x000d513c add r4,r4,r5
0x000d5140 addu r22,r6,r0
0x000d5144 sll r4,r4,0x02
0x000d5148 lui r6,0x8013
0x000d514c add r4,r4,r5
0x000d5150 addiu r6,r6,0xcecc
0x000d5154 sll r4,r4,0x02
0x000d5158 addu r4,r6,r4
0x000d515c lh r5,0x0000(r4)
0x000d5160 sll r2,r2,0x02
0x000d5164 addu r2,r6,r2
0x000d5168 lw r4,0x0000(r7)
0x000d516c lh r2,0x0000(r2)
0x000d5170 sub r4,r4,r5
0x000d5174 sh r4,0x0040(r29)
0x000d5178 lw r4,0x0008(r7)
0x000d517c nop
0x000d5180 add r4,r4,r5
0x000d5184 sh r4,0x0042(r29)
0x000d5188 sll r4,r5,0x01
0x000d518c addu r5,r4,r0
0x000d5190 sh r4,0x0044(r29)
0x000d5194 sh r5,0x0046(r29)
0x000d5198 lw r4,0x0000(r3)
0x000d519c lw r3,0x0008(r3)
0x000d51a0 addu r5,r4,r0
0x000d51a4 sub r19,r4,r2
0x000d51a8 addu r4,r3,r0
0x000d51ac add r18,r5,r2
0x000d51b0 add r17,r3,r2
0x000d51b4 sub r16,r4,r2
0x000d51b8 lb r2,-0x6c22(r28)
0x000d51bc nop
0x000d51c0 bne r2,r0,0x000d5340
0x000d51c4 nop
0x000d51c8 lui r1,0x8013
0x000d51cc lw r2,-0x0cbc(r1)
0x000d51d0 nop
0x000d51d4 bne r20,r2,0x000d5340
0x000d51d8 nop
0x000d51dc lw r3,-0x6c44(r28)
0x000d51e0 lw r2,-0x6c48(r28)
0x000d51e4 nor r3,r3,r0
0x000d51e8 and r2,r2,r3
0x000d51ec andi r2,r2,0x0040
0x000d51f0 beq r2,r0,0x000d5288
0x000d51f4 nop
0x000d51f8 lbu r2,0x002e(r20)
0x000d51fc nop
0x000d5200 bne r2,r0,0x000d5288
0x000d5204 nop
0x000d5208 lw r2,0x0004(r20)
0x000d520c nop
0x000d5210 lh r2,0x0072(r2)
0x000d5214 nop
0x000d5218 slt r1,r0,r2
0x000d521c beq r1,r0,0x000d5234
0x000d5220 nop
0x000d5224 slti r1,r2,0x0800
0x000d5228 beq r1,r0,0x000d5234
0x000d522c nop
0x000d5230 addi r19,r19,-0x0032
0x000d5234 slti r1,r2,0x0801
0x000d5238 bne r1,r0,0x000d5250
0x000d523c nop
0x000d5240 slti r1,r2,0x1000
0x000d5244 beq r1,r0,0x000d5250
0x000d5248 nop
0x000d524c addi r18,r18,0x0032
0x000d5250 slti r1,r2,0x0400
0x000d5254 bne r1,r0,0x000d5268
0x000d5258 nop
0x000d525c slti r1,r2,0x0c01
0x000d5260 bne r1,r0,0x000d526c
0x000d5264 nop
0x000d5268 addi r16,r16,-0x0032
0x000d526c slti r1,r2,0x0401
0x000d5270 bne r1,r0,0x000d5288
0x000d5274 nop
0x000d5278 slti r1,r2,0x0c00
0x000d527c beq r1,r0,0x000d5288
0x000d5280 nop
0x000d5284 addi r17,r17,0x0032
0x000d5288 sw r16,0x0010(r29)
0x000d528c addiu r4,r29,0x0040
0x000d5290 addu r5,r19,r0
0x000d5294 addu r6,r17,r0
0x000d5298 jal 0x000d3858
0x000d529c addu r7,r19,r0
0x000d52a0 beq r2,r0,0x000d52b0
0x000d52a4 nop
0x000d52a8 beq r0,r0,0x000d5404
0x000d52ac addiu r2,r0,0x0001
0x000d52b0 sw r16,0x0010(r29)
0x000d52b4 addiu r4,r29,0x0040
0x000d52b8 addu r5,r18,r0
0x000d52bc addu r6,r17,r0
0x000d52c0 jal 0x000d3858
0x000d52c4 addu r7,r18,r0
0x000d52c8 beq r2,r0,0x000d52d8
0x000d52cc nop
0x000d52d0 beq r0,r0,0x000d5404
0x000d52d4 addiu r2,r0,0x0001
0x000d52d8 sw r16,0x0010(r29)
0x000d52dc addiu r4,r29,0x0040
0x000d52e0 addu r5,r19,r0
0x000d52e4 addu r6,r16,r0
0x000d52e8 jal 0x000d3858
0x000d52ec addu r7,r18,r0
0x000d52f0 beq r2,r0,0x000d5300
0x000d52f4 nop
0x000d52f8 beq r0,r0,0x000d5404
0x000d52fc addiu r2,r0,0x0001
0x000d5300 sw r17,0x0010(r29)
0x000d5304 addiu r4,r29,0x0040
0x000d5308 addu r5,r19,r0
0x000d530c addu r6,r17,r0
0x000d5310 jal 0x000d3858
0x000d5314 addu r7,r18,r0
0x000d5318 beq r2,r0,0x000d5328
0x000d531c addu r4,r20,r0
0x000d5320 beq r0,r0,0x000d5404
0x000d5324 addiu r2,r0,0x0001
0x000d5328 jal 0x000d31ac
0x000d532c addu r5,r21,r0
0x000d5330 beq r2,r0,0x000d5400
0x000d5334 nop
0x000d5338 beq r0,r0,0x000d5404
0x000d533c addiu r2,r0,0x0001
0x000d5340 bgez r22,0x000d5370
0x000d5344 nop
0x000d5348 sw r16,0x0010(r29)
0x000d534c addiu r4,r29,0x0040
0x000d5350 addu r5,r19,r0
0x000d5354 addu r6,r17,r0
0x000d5358 jal 0x000d3858
0x000d535c addu r7,r19,r0
0x000d5360 beq r2,r0,0x000d5370
0x000d5364 nop
0x000d5368 beq r0,r0,0x000d5404
0x000d536c addiu r2,r0,0x0001
0x000d5370 blez r22,0x000d53a0
0x000d5374 nop
0x000d5378 sw r16,0x0010(r29)
0x000d537c addiu r4,r29,0x0040
0x000d5380 addu r5,r18,r0
0x000d5384 addu r6,r17,r0
0x000d5388 jal 0x000d3858
0x000d538c addu r7,r18,r0
0x000d5390 beq r2,r0,0x000d53a0
0x000d5394 nop
0x000d5398 beq r0,r0,0x000d5404
0x000d539c addiu r2,r0,0x0001
0x000d53a0 bgez r23,0x000d53d0
0x000d53a4 nop
0x000d53a8 sw r16,0x0010(r29)
0x000d53ac addiu r4,r29,0x0040
0x000d53b0 addu r5,r19,r0
0x000d53b4 addu r6,r16,r0
0x000d53b8 jal 0x000d3858
0x000d53bc addu r7,r18,r0
0x000d53c0 beq r2,r0,0x000d53d0
0x000d53c4 nop
0x000d53c8 beq r0,r0,0x000d5404
0x000d53cc addiu r2,r0,0x0001
0x000d53d0 blez r23,0x000d5400
0x000d53d4 nop
0x000d53d8 sw r17,0x0010(r29)
0x000d53dc addiu r4,r29,0x0040
0x000d53e0 addu r5,r19,r0
0x000d53e4 addu r6,r17,r0
0x000d53e8 jal 0x000d3858
0x000d53ec addu r7,r18,r0
0x000d53f0 beq r2,r0,0x000d5400
0x000d53f4 nop
0x000d53f8 beq r0,r0,0x000d5404
0x000d53fc addiu r2,r0,0x0001
0x000d5400 addu r2,r0,r0
0x000d5404 lw r31,0x0038(r29)
0x000d5408 lw r23,0x0034(r29)
0x000d540c lw r22,0x0030(r29)
0x000d5410 lw r21,0x002c(r29)
0x000d5414 lw r20,0x0028(r29)
0x000d5418 lw r19,0x0024(r29)
0x000d541c lw r18,0x0020(r29)
0x000d5420 lw r17,0x001c(r29)
0x000d5424 lw r16,0x0018(r29)
0x000d5428 jr r31
0x000d542c addiu r29,r29,0x0048