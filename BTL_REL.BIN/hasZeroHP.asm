/**
 * Checks whether a Digimon has 0 HP or has enough unattributed damage to have 0 HP.
 * Returns 1 if the HP are or will be <= 0, 0 otherwise.
 */
int hasZeroHP(combatId) {
  combatHead = load(0x134D4C)
  
  entityId = load(combatHead + 0x066C + combatId)
  entityPtr = load(0x12F344 + entityId * 4)
  currentHP = load(entityPtr + 0x4C)
  remainingDamage = load(combatHead + combatId * 0x168 + 0x2E)
  
  return currentHP - remainingDamage <= 0 ? 1 : 0
}

0x000601ac lw r6,-0x6de0(r28)
0x000601b0 nop
0x000601b4 addu r2,r4,r6
0x000601b8 lbu r2,0x066c(r2)
0x000601bc nop
0x000601c0 sll r3,r2,0x02
0x000601c4 lui r2,0x8013
0x000601c8 addiu r2,r2,0xf344
0x000601cc addu r2,r2,r3
0x000601d0 lw r2,0x0000(r2)
0x000601d4 nop
0x000601d8 lh r5,0x004c(r2)
0x000601dc sll r2,r4,0x04
0x000601e0 sub r3,r2,r4
0x000601e4 sll r2,r3,0x02
0x000601e8 sub r2,r2,r3
0x000601ec sll r2,r2,0x03
0x000601f0 addu r2,r2,r6
0x000601f4 lh r2,0x002e(r2)
0x000601f8 nop
0x000601fc sub r2,r5,r2
0x00060200 bgtz r2,0x00060210
0x00060204 addu r2,r0,r0
0x00060208 beq r0,r0,0x00060210
0x0006020c addiu r2,r0,0x0001
0x00060210 jr r31
0x00060214 nop