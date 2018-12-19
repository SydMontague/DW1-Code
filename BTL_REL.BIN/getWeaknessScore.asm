/**
 * Calculates a score for an enemy of the given Digimon, used to determine
 * the weakest enemy to target.
 * 
 * This function is most likely bugged, since it is using the first Digimon's
 * stats, which are always the same, causing the type factor being the only
 * variable when iterating over the list of enemies.
 */
int getWeaknessScore(entityPtr, enemyEntityPtr) {
  entitySpec = load(0x12CED2 + load(entityPtr) * 0x34)
  enemySpec = load(0x12CED2 + load(enemyEntityPtr) * 0x34)
  
  typeFactor = load(0x125F70 + entitySpec * 7 + enemySpec)
  
  if(typeFactor == 2)
    typeFactor = 20
  else if(typeFactor == 5)
    typeFactor = 15
  else if(typeFactor == 15)
    typeFactor = 5
  else if(typeFactor == 20)
    typeFactor = 2
  
  defense = load(entityPtr + 0x3A) // defense
  currentHP = load(entityPtr + 0x4C) * 100 // currentHP
  maxHP = load(entityPtr + 0x48) // maxHP
  
  return (currentHP * 100 / maxHP) + (typeFactor * defense / 100)
}

0x0005f764 addiu r3,r4,0x0038
0x0005f768 lw r4,0x0000(r4)
0x0005f76c lui r7,0x8013
0x0005f770 sll r2,r4,0x01
0x0005f774 add r2,r2,r4
0x0005f778 sll r2,r2,0x02
0x0005f77c add r2,r2,r4
0x0005f780 sll r2,r2,0x02
0x0005f784 addiu r7,r7,0xced2
0x0005f788 addu r2,r7,r2
0x0005f78c lbu r4,0x0000(r2)
0x0005f790 addiu r1,r0,0x0002
0x0005f794 sll r2,r4,0x03
0x0005f798 sub r6,r2,r4
0x0005f79c lui r2,0x8012
0x0005f7a0 lw r4,0x0000(r5)
0x0005f7a4 addiu r2,r2,0x5f70
0x0005f7a8 addu r5,r2,r6
0x0005f7ac sll r2,r4,0x01
0x0005f7b0 add r2,r2,r4
0x0005f7b4 sll r2,r2,0x02
0x0005f7b8 add r2,r2,r4
0x0005f7bc sll r2,r2,0x02
0x0005f7c0 addu r2,r7,r2
0x0005f7c4 lbu r2,0x0000(r2)
0x0005f7c8 nop
0x0005f7cc addu r2,r2,r5
0x0005f7d0 lbu r2,0x0000(r2)
0x0005f7d4 nop
0x0005f7d8 sll r2,r2,0x10
0x0005f7dc sra r2,r2,0x10
0x0005f7e0 beq r2,r1,0x0005f83c
0x0005f7e4 nop
0x0005f7e8 addiu r1,r0,0x0005
0x0005f7ec beq r2,r1,0x0005f82c
0x0005f7f0 nop
0x0005f7f4 addiu r1,r0,0x000f
0x0005f7f8 beq r2,r1,0x0005f81c
0x0005f7fc nop
0x0005f800 addiu r1,r0,0x0014
0x0005f804 bne r2,r1,0x0005f848
0x0005f808 nop
0x0005f80c addiu r2,r0,0x0002
0x0005f810 sll r2,r2,0x10
0x0005f814 beq r0,r0,0x0005f848
0x0005f818 sra r2,r2,0x10
0x0005f81c addiu r2,r0,0x0005
0x0005f820 sll r2,r2,0x10
0x0005f824 beq r0,r0,0x0005f848
0x0005f828 sra r2,r2,0x10
0x0005f82c addiu r2,r0,0x000f
0x0005f830 sll r2,r2,0x10
0x0005f834 beq r0,r0,0x0005f848
0x0005f838 sra r2,r2,0x10
0x0005f83c addiu r2,r0,0x0014
0x0005f840 sll r2,r2,0x10
0x0005f844 sra r2,r2,0x10
0x0005f848 lh r5,0x0002(r3)
0x0005f84c nop
0x0005f850 sll r4,r5,0x02
0x0005f854 add r5,r4,r5
0x0005f858 sll r4,r5,0x02
0x0005f85c add r4,r5,r4
0x0005f860 sll r6,r4,0x02
0x0005f864 lui r4,0x8334
0x0005f868 ori r4,r4,0x0521
0x0005f86c mult r4,r6
0x0005f870 srl r5,r6,0x1f
0x0005f874 mfhi r4
0x0005f878 addu r4,r4,r6
0x0005f87c sra r4,r4,0x09
0x0005f880 addu r4,r4,r5
0x0005f884 mult r2,r4
0x0005f888 lui r2,0x6666
0x0005f88c mflo r4
0x0005f890 ori r2,r2,0x6667
0x0005f894 nop
0x0005f898 mult r2,r4
0x0005f89c srl r5,r4,0x1f
0x0005f8a0 mfhi r2
0x0005f8a4 sra r2,r2,0x02
0x0005f8a8 lh r4,0x0014(r3)
0x0005f8ac addu r5,r2,r5
0x0005f8b0 sll r2,r4,0x02
0x0005f8b4 add r4,r2,r4
0x0005f8b8 sll r2,r4,0x02
0x0005f8bc add r4,r4,r2
0x0005f8c0 lh r2,0x0010(r3)
0x0005f8c4 sll r3,r4,0x02
0x0005f8c8 div r3,r2
0x0005f8cc mflo r2
0x0005f8d0 add r2,r2,r5
0x0005f8d4 sll r2,r2,0x10
0x0005f8d8 jr r31
0x0005f8dc sra r2,r2,0x10