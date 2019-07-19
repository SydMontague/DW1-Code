void tickObjects() { // tick objects
  for(i = 0; i < 0x80; i++) {
    tickFunctionPtr = 0x137418 + i * 0x0C
    
    if(load(tickFunctionPtr) == -1)
      continue
    
    if(load(tickFunctionPtr + 0x04) == 0)
      continue
    
    tickParam = load(tickFunctionPtr + 0x02)
    tickFunction = load(tickFunctionPtr + 0x04)
    
    tickFunction(tickParam)
  }
}

0x000a30c8 addiu r29,r29,0xffe0
0x000a30cc sw r31,0x0018(r29)
0x000a30d0 sw r17,0x0014(r29)
0x000a30d4 sw r16,0x0010(r29)
0x000a30d8 addu r17,r0,r0
0x000a30dc beq r0,r0,0x000a313c
0x000a30e0 addu r16,r0,r0
0x000a30e4 lui r4,0x8013
0x000a30e8 addiu r4,r4,0x7418
0x000a30ec addu r3,r4,r16
0x000a30f0 lh r2,0x0000(r3)
0x000a30f4 addiu r1,r0,0xffff
0x000a30f8 beq r2,r1,0x000a3134
0x000a30fc nop
0x000a3100 lui r2,0x8013
0x000a3104 addiu r2,r2,0x741c
0x000a3108 addu r2,r2,r16
0x000a310c lw r2,0x0000(r2)
0x000a3110 nop
0x000a3114 beq r2,r0,0x000a3134
0x000a3118 nop
0x000a311c addu r2,r3,r0
0x000a3120 lh r4,0x0002(r2)
0x000a3124 lw r2,0x0004(r3)
0x000a3128 nop
0x000a312c jalr r2,r31
0x000a3130 nop
0x000a3134 addi r17,r17,0x0001
0x000a3138 addi r16,r16,0x000c
0x000a313c slti r1,r17,0x0080
0x000a3140 bne r1,r0,0x000a30e4
0x000a3144 nop
0x000a3148 lw r31,0x0018(r29)
0x000a314c lw r17,0x0014(r29)
0x000a3150 lw r16,0x0010(r29)
0x000a3154 jr r31
0x000a3158 addiu r29,r29,0x0020