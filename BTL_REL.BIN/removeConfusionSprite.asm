void removeConfusionSprite(instanceId, entityPtr) {
  confusionTablePtr = 0x000750F0 + instanceId * 0x10
  
  if(instanceId < 0 || instanceId >= 4)
    return
  
  if(load(confusionTablePtr + 0x0C) != entityPtr)
    return
  
  store(confusionTablePtr, -1)
  unsetObject(0x0806, instanceId)
}

0x0006f4dc addu r6,r4,r0
0x0006f4e0 lui r2,0x8007
0x0006f4e4 addiu r29,r29,0xffe8
0x0006f4e8 sll r3,r6,0x04
0x0006f4ec addiu r2,r2,0x50f0
0x0006f4f0 sw r31,0x0010(r29)
0x0006f4f4 bltz r6,0x0006f52c
0x0006f4f8 addu r3,r2,r3
0x0006f4fc slti r1,r6,0x0004
0x0006f500 beq r1,r0,0x0006f52c
0x0006f504 nop
0x0006f508 lw r2,0x000c(r3)
0x0006f50c nop
0x0006f510 bne r2,r5,0x0006f52c
0x0006f514 nop
0x0006f518 addiu r2,r0,0xffff
0x0006f51c sh r2,0x0000(r3)
0x0006f520 addiu r4,r0,0x0806
0x0006f524 jal 0x000a3008
0x0006f528 addu r5,r6,r0
0x0006f52c lw r31,0x0010(r29)
0x0006f530 nop
0x0006f534 jr r31
0x0006f538 addiu r29,r29,0x0018