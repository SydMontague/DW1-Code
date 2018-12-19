/**
 * Sets a move's animation and range in the combat data, as well as some flags.
 */
void setMoveAnim(entityPtr, combatPtr, unused, attackId) {
  store(combatPtr + 0x2C, 0)
  
  animId = load(entityPtr + 0x44 + attackId)
  techId = getTechFromMove(entityPtr, animId)
  range = load(0x126244 + techId * 0x10)
  
  store(combatPtr + 0x36, range)
  store(combatPtr + 0x38, animId)
  
  setChargeupFlag(entityPtr, combatPtr, techId)
  
  flags = load(combatPtr + 0x34) | 0x0040 // some flag
  store(combatPtr + 0x34, flags)
}

0x0005d658 addiu r29,r29,0xffe0
0x0005d65c sw r31,0x0018(r29)
0x0005d660 sw r17,0x0014(r29)
0x0005d664 sw r16,0x0010(r29)
0x0005d668 addu r17,r4,r0
0x0005d66c addu r16,r5,r0
0x0005d670 sh r0,0x002c(r16)
0x0005d674 addu r2,r7,r17
0x0005d678 lbu r2,0x0044(r2)
0x0005d67c nop
0x0005d680 sb r2,0x0038(r16)
0x0005d684 lbu r5,0x0038(r16)
0x0005d688 jal 0x000e6000
0x0005d68c nop
0x0005d690 sll r6,r2,0x10
0x0005d694 sra r6,r6,0x10
0x0005d698 lui r2,0x8012
0x0005d69c sll r3,r6,0x04
0x0005d6a0 addiu r2,r2,0x6244
0x0005d6a4 addu r2,r2,r3
0x0005d6a8 lbu r2,0x0000(r2)
0x0005d6ac addu r4,r17,r0
0x0005d6b0 sb r2,0x0036(r16)
0x0005d6b4 jal 0x0005d6e0
0x0005d6b8 addu r5,r16,r0
0x0005d6bc lhu r2,0x0034(r16)
0x0005d6c0 nop
0x0005d6c4 ori r2,r2,0x0040
0x0005d6c8 sh r2,0x0034(r16)
0x0005d6cc lw r31,0x0018(r29)
0x0005d6d0 lw r17,0x0014(r29)
0x0005d6d4 lw r16,0x0010(r29)
0x0005d6d8 jr r31
0x0005d6dc addiu r29,r29,0x0020