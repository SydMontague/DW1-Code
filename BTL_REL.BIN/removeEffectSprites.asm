void removeEffectSprites(int entityPtr, int combatPtr) {
  flags = load(combatPtr + 0x34)
  
  if(flags & 0x0004 != 0) // stun
    removeEffectSprite(entityPtr, combatPtr, 3)
  
  if(flags & 0x0002 != 0) // confusion
    removeEffectSprite(entityPtr, combatPtr, 2)
  
  if(flags & 0x0001 != 0) // poison
    removeEffectSprite(entityPtr, combatPtr, 1)
}

0x0005ec7c addiu r29,r29,0xffe0
0x0005ec80 sw r31,0x0018(r29)
0x0005ec84 sw r17,0x0014(r29)
0x0005ec88 sw r16,0x0010(r29)
0x0005ec8c addu r16,r5,r0
0x0005ec90 lhu r2,0x0034(r16)
0x0005ec94 nop
0x0005ec98 andi r2,r2,0x0004
0x0005ec9c beq r2,r0,0x0005ecac
0x0005eca0 addu r17,r4,r0
0x0005eca4 jal 0x0005e520
0x0005eca8 addiu r6,r0,0x0003
0x0005ecac lhu r2,0x0034(r16)
0x0005ecb0 nop
0x0005ecb4 andi r2,r2,0x0002
0x0005ecb8 beq r2,r0,0x0005ecd0
0x0005ecbc nop
0x0005ecc0 addu r4,r17,r0
0x0005ecc4 addu r5,r16,r0
0x0005ecc8 jal 0x0005e520
0x0005eccc addiu r6,r0,0x0002
0x0005ecd0 lhu r2,0x0034(r16)
0x0005ecd4 nop
0x0005ecd8 andi r2,r2,0x0001
0x0005ecdc beq r2,r0,0x0005ecf4
0x0005ece0 nop
0x0005ece4 addu r4,r17,r0
0x0005ece8 addu r5,r16,r0
0x0005ecec jal 0x0005e520
0x0005ecf0 addiu r6,r0,0x0001
0x0005ecf4 lw r31,0x0018(r29)
0x0005ecf8 lw r17,0x0014(r29)
0x0005ecfc lw r16,0x0010(r29)
0x0005ed00 jr r31
0x0005ed04 addiu r29,r29,0x0020