void removePoisonSprite(instanceId, entityPtr) {
  poisonTablePtr = 0x000750D0 + instanceId * 8
  
  if(instanceId < 0 || instanceId >= 4)
    return
    
  if(load(poisonTablePtr + 0x0004) != entityPtr)
    return
    
  store(poisonTablePtr, -1)
  unsetObject(0x0808, instanceId)
}

0x0006f168 addu r6,r4,r0
0x0006f16c lui r2,0x8007
0x0006f170 addiu r29,r29,0xffe8
0x0006f174 sll r3,r6,0x03
0x0006f178 addiu r2,r2,0x50d0
0x0006f17c sw r31,0x0010(r29)
0x0006f180 bltz r6,0x0006f1b8
0x0006f184 addu r3,r2,r3
0x0006f188 slti r1,r6,0x0004
0x0006f18c beq r1,r0,0x0006f1b8
0x0006f190 nop
0x0006f194 lw r2,0x0004(r3)
0x0006f198 nop
0x0006f19c bne r2,r5,0x0006f1b8
0x0006f1a0 nop
0x0006f1a4 addiu r2,r0,0xffff
0x0006f1a8 sh r2,0x0000(r3)
0x0006f1ac addiu r4,r0,0x0808
0x0006f1b0 jal 0x000a3008
0x0006f1b4 addu r5,r6,r0
0x0006f1b8 lw r31,0x0010(r29)
0x0006f1bc nop
0x0006f1c0 jr r31
0x0006f1c4 addiu r29,r29,0x0018