void removeStunSprite(instanceId, entityPtr) {
  stunTablePtr = 0x00075130 + instanceId * 0x0C
  
  if(instanceId < 0 || instanceId >= 4)
    return
    
  if(load(stunTablePtr + 0x0008) != entityPtr)
    return
    
  store(stunTablePtr, -1)
  unsetObject(0x080F, instanceId)
}

0x0006fee0 addu r6,r4,r0
0x0006fee4 sll r2,r6,0x01
0x0006fee8 add r2,r2,r6
0x0006feec sll r3,r2,0x02
0x0006fef0 lui r2,0x8007
0x0006fef4 addiu r29,r29,0xffe8
0x0006fef8 addiu r2,r2,0x5130
0x0006fefc sw r31,0x0010(r29)
0x0006ff00 bltz r6,0x0006ff38
0x0006ff04 addu r3,r2,r3
0x0006ff08 slti r1,r6,0x0005
0x0006ff0c beq r1,r0,0x0006ff38
0x0006ff10 nop
0x0006ff14 lw r2,0x0008(r3)
0x0006ff18 nop
0x0006ff1c bne r2,r5,0x0006ff38
0x0006ff20 nop
0x0006ff24 addiu r2,r0,0xffff
0x0006ff28 sh r2,0x0000(r3)
0x0006ff2c addiu r4,r0,0x080f
0x0006ff30 jal 0x000a3008
0x0006ff34 addu r5,r6,r0
0x0006ff38 lw r31,0x0010(r29)
0x0006ff3c nop
0x0006ff40 jr r31
0x0006ff44 addiu r29,r29,0x0018