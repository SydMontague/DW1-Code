void entityLookAtLocation(entityPtr, posPointer2) {
  if(posPointer2 == 0)
    return
  
  posPointer1 = load(entityPtr + 4) + 0x78
  
  locX1 = load(posPointer1)
  locY1 = load(posPointer1 + 0x08)
  
  locX2 = load(posPointer2)
  locY2 = load(posPointer2 + 0x08)
  
  angle = atan(locY2 - locY1, locX2 - locX1)
  store(somePtr + 0x72, angle)
}

0x000d459c addiu r29,r29,0xffe8
0x000d45a0 sw r31,0x0014(r29)
0x000d45a4 beq r5,r0,0x000d45dc
0x000d45a8 sw r16,0x0010(r29)
0x000d45ac lw r16,0x0004(r4)
0x000d45b0 lw r3,0x0000(r5)
0x000d45b4 addiu r4,r16,0x0078
0x000d45b8 lw r2,0x0000(r4)
0x000d45bc nop
0x000d45c0 sub r6,r3,r2
0x000d45c4 lw r3,0x0008(r5)
0x000d45c8 lw r2,0x0008(r4)
0x000d45cc addu r5,r6,r0
0x000d45d0 jal 0x000a37fc
0x000d45d4 sub r4,r3,r2
0x000d45d8 sh r2,0x0072(r16)
0x000d45dc lw r31,0x0014(r29)
0x000d45e0 lw r16,0x0010(r29)
0x000d45e4 jr r31
0x000d45e8 addiu r29,r29,0x0018