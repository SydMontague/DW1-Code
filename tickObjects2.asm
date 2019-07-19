void tickObjects2() { // tick objects
  for(i = 0; i < 0x80; i++) {
    tickFunctionPtr = 0x137418 + i * 0x0C
    
    if(load(tickFunctionPtr) == -1)
      continue
    
    if(load(tickFunctionPtr + 0x08) == 0)
      continue
    
    tickParam = load(tickFunctionPtr + 0x02)
    tickFunction = load(tickFunctionPtr + 0x08)
    
    tickFunction(tickParam)
  }
}

0x000a315c addiu r29,r29,0xffe0
0x000a3160 sw r31,0x0018(r29)
0x000a3164 sw r17,0x0014(r29)
0x000a3168 sw r16,0x0010(r29)
0x000a316c addu r17,r0,r0
0x000a3170 beq r0,r0,0x000a31d0
0x000a3174 addu r16,r0,r0
0x000a3178 lui r4,0x8013
0x000a317c addiu r4,r4,0x7418
0x000a3180 addu r3,r4,r16
0x000a3184 lh r2,0x0000(r3)
0x000a3188 addiu r1,r0,0xffff
0x000a318c beq r2,r1,0x000a31c8
0x000a3190 nop
0x000a3194 lui r2,0x8013
0x000a3198 addiu r2,r2,0x7420
0x000a319c addu r2,r2,r16
0x000a31a0 lw r2,0x0000(r2)
0x000a31a4 nop
0x000a31a8 beq r2,r0,0x000a31c8
0x000a31ac nop
0x000a31b0 addu r2,r3,r0
0x000a31b4 lh r4,0x0002(r2)
0x000a31b8 lw r2,0x0008(r3)
0x000a31bc nop
0x000a31c0 jalr r2,r31
0x000a31c4 nop
0x000a31c8 addi r17,r17,0x0001
0x000a31cc addi r16,r16,0x000c
0x000a31d0 slti r1,r17,0x0080
0x000a31d4 bne r1,r0,0x000a3178
0x000a31d8 nop
0x000a31dc lw r31,0x0018(r29)
0x000a31e0 lw r17,0x0014(r29)
0x000a31e4 lw r16,0x0010(r29)
0x000a31e8 jr r31
0x000a31ec addiu r29,r29,0x0020