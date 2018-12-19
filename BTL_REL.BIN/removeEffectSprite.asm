void removeEffectSprites(entityPtr, combatPtr, effectType) {
  instanceId = load(combatPtr)
  
  if(instanceId == -1) // has status sprite
    return
    
  if(effectType == 3)
    removeStunSprite(instanceId, entityPtr)
  else if(effectType == 2)
    removeConfusionSprite(instanceId, entityPtr)
  else if(effectType == 1)
    removePoisonSprite(instanceId, entityPtr)
  
  store(combatPtr, -1)
}

0x0005e520 addiu r29,r29,0xffe8
0x0005e524 sw r31,0x0014(r29)
0x0005e528 sw r16,0x0010(r29)
0x0005e52c addu r2,r4,r0
0x0005e530 addu r16,r5,r0
0x0005e534 lw r4,0x0000(r16)
0x0005e538 addiu r1,r0,0xffff
0x0005e53c beq r4,r1,0x0005e598
0x0005e540 nop
0x0005e544 addiu r1,r0,0x0003
0x0005e548 beq r6,r1,0x0005e588
0x0005e54c nop
0x0005e550 addiu r1,r0,0x0002
0x0005e554 beq r6,r1,0x0005e578
0x0005e558 nop
0x0005e55c addiu r1,r0,0x0001
0x0005e560 bne r6,r1,0x0005e590
0x0005e564 nop
0x0005e568 jal 0x0006f168
0x0005e56c addu r5,r2,r0
0x0005e570 beq r0,r0,0x0005e594
0x0005e574 addiu r2,r0,0xffff
0x0005e578 jal 0x0006f4dc
0x0005e57c addu r5,r2,r0
0x0005e580 beq r0,r0,0x0005e594
0x0005e584 addiu r2,r0,0xffff
0x0005e588 jal 0x0006fee0
0x0005e58c addu r5,r2,r0
0x0005e590 addiu r2,r0,0xffff
0x0005e594 sw r2,0x0000(r16)
0x0005e598 lw r31,0x0014(r29)
0x0005e59c lw r16,0x0010(r29)
0x0005e5a0 jr r31
0x0005e5a4 addiu r29,r29,0x0018