int entityIsInEntity(entityPtr, entityPtr2) {
  type1 = load(entityPtr + 0x00)
  locPtr1 = load(entityPtr + 0x04) + 0x78
  radius1 = load(0x12CECC + type1 * 52)
  
  type2 = load(entityPtr2 + 0x00)
  locPtr2 = load(entityPtr2 + 0x04) + 0x78
  radius2 = load(0x12CECC + type2 * 52)
  
  posX1 = load(locPtr1)
  posY1 = load(locPtr1 + 0x08)
  posX2 = load(locPtr2)
  posY2 = load(locPtr2 + 0x08)
  
  x1Min = posX1 - radius1
  x1Max = posX1 + radius1
  
  y1Min = posY1 - radius1
  y1Max = posY1 + radius1
  
  x2Min = posX2 - radius2
  x2Max = posX2 + radius2
  
  y2Min = posY2 - radius2
  y2Max = posY2 + radius2
  
  if(x2Max < x1Min)
    return 0
  
  if(x1Max < x2Min)
    return 0
  
  if(y2Max < y1Min)
    return 0
  
  if(y1Max < y2Min)
    return 0
  
  return 1
}

0x000d31ac lw r2,0x0004(r4)
0x000d31b0 lui r6,0x8013
0x000d31b4 lw r4,0x0000(r4)
0x000d31b8 addiu r6,r6,0xcecc
0x000d31bc sll r3,r4,0x01
0x000d31c0 add r3,r3,r4
0x000d31c4 sll r3,r3,0x02
0x000d31c8 add r3,r3,r4
0x000d31cc sll r3,r3,0x02
0x000d31d0 addu r3,r6,r3
0x000d31d4 lh r8,0x0000(r3)
0x000d31d8 lw r4,0x0000(r5)
0x000d31dc lw r3,0x0004(r5)
0x000d31e0 addiu r2,r2,0x0078
0x000d31e4 addiu r7,r3,0x0078
0x000d31e8 sll r3,r4,0x01
0x000d31ec add r3,r3,r4
0x000d31f0 sll r3,r3,0x02
0x000d31f4 add r3,r3,r4
0x000d31f8 sll r3,r3,0x02
0x000d31fc addu r3,r6,r3
0x000d3200 lh r5,0x0000(r3)
0x000d3204 addu r9,r8,r0
0x000d3208 lw r3,0x0000(r2)
0x000d320c nop
0x000d3210 addu r10,r3,r0
0x000d3214 sub r4,r3,r8
0x000d3218 lw r3,0x0000(r7)
0x000d321c nop
0x000d3220 addu r8,r3,r0
0x000d3224 add r3,r3,r5
0x000d3228 slt r1,r3,r4
0x000d322c beq r1,r0,0x000d323c
0x000d3230 addu r6,r5,r0
0x000d3234 beq r0,r0,0x000d32a0
0x000d3238 addu r2,r0,r0
0x000d323c add r4,r10,r9
0x000d3240 sub r3,r8,r6
0x000d3244 slt r1,r4,r3
0x000d3248 beq r1,r0,0x000d3258
0x000d324c nop
0x000d3250 beq r0,r0,0x000d32a0
0x000d3254 addu r2,r0,r0
0x000d3258 lw r3,0x0008(r2)
0x000d325c lw r2,0x0008(r7)
0x000d3260 addu r5,r3,r0
0x000d3264 addu r4,r2,r0
0x000d3268 sub r3,r3,r9
0x000d326c add r2,r2,r6
0x000d3270 slt r1,r2,r3
0x000d3274 beq r1,r0,0x000d3284
0x000d3278 nop
0x000d327c beq r0,r0,0x000d32a0
0x000d3280 addu r2,r0,r0
0x000d3284 add r3,r5,r9
0x000d3288 sub r2,r4,r6
0x000d328c slt r1,r3,r2
0x000d3290 beq r1,r0,0x000d32a0
0x000d3294 addiu r2,r0,0x0001
0x000d3298 beq r0,r0,0x000d32a0
0x000d329c addu r2,r0,r0
0x000d32a0 jr r31
0x000d32a4 nop
