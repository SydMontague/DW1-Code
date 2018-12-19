void handleDeath(int entityPtr, int combatPtr, int combatId) {
  store(entityPtr + 0x53, 1)
  flags = load(combatPtr + 0x34) | 0x8000 // set isDead flag
  store(combatPtr + 0x34, flags)
  
  startAnimation(entityPtr, 0x2B)
  resetFlatten(combatId)
  removeEffectSprites(entityPtr, combatPtr)
  
  // clear status flags, set "transforming" flag
  flags = (load(combatPtr + 0x34) & 0xFF40) | 0x0040
  store(combatPtr + 0x34, flags)
  store(combatPtr + 0x36, -1)
  
  resetDumbCooldownTimers(combatPtr)
}

0x0005afd8 addiu r29,r29,0xffe0
0x0005afdc sw r31,0x001c(r29)
0x0005afe0 sw r18,0x0018(r29)
0x0005afe4 sw r17,0x0014(r29)
0x0005afe8 sw r16,0x0010(r29)
0x0005afec addu r16,r5,r0
0x0005aff0 addu r17,r4,r0
0x0005aff4 addiu r2,r0,0x0001
0x0005aff8 sb r2,0x0053(r17)
0x0005affc lhu r2,0x0034(r16)
0x0005b000 addu r18,r6,r0
0x0005b004 ori r2,r2,0x8000
0x0005b008 sh r2,0x0034(r16)
0x0005b00c jal 0x000c1a04
0x0005b010 addiu r5,r0,0x002b
0x0005b014 jal 0x00059078
0x0005b018 addu r4,r18,r0
0x0005b01c addu r4,r17,r0
0x0005b020 jal 0x0005ec7c
0x0005b024 addu r5,r16,r0
0x0005b028 lhu r2,0x0034(r16)
0x0005b02c nop
0x0005b030 andi r2,r2,0xff40
0x0005b034 sh r2,0x0034(r16)
0x0005b038 lhu r2,0x0034(r16)
0x0005b03c nop
0x0005b040 ori r2,r2,0x0040
0x0005b044 sh r2,0x0034(r16)
0x0005b048 addiu r2,r0,0xffff
0x0005b04c sb r2,0x0036(r16)
0x0005b050 jal 0x0005eb0c
0x0005b054 addu r4,r16,r0
0x0005b058 lw r31,0x001c(r29)
0x0005b05c lw r18,0x0018(r29)
0x0005b060 lw r17,0x0014(r29)
0x0005b064 lw r16,0x0010(r29)
0x0005b068 jr r31
0x0005b06c addiu r29,r29,0x0020