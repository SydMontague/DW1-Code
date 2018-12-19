/**
 * Starts the battle idle animation, using the normal/tired variation 
 * depending on poison/health status.
 */
void startBattleIdleAnimation(entityPtr, statsPtr, flags) {
  useTiredAnim = 1
  
  if(flags & 0x01 == 0) { // check if not poisoned
    maxHP = load(statsPtr + 0x10)
    currentHP = load(statsPtr + 0x14)
    
    if(maxHP * 0.3 < currentHP)
      useTiredAnim = 0
  }
  
  animId = useTiredAnim == 0 ? 0x21 : 0x22
    
  startAnimation(entityPtr, animId)
}

0x000e8970 andi r2,r6,0x0001
0x000e8974 bne r2,r0,0x000e89b0
0x000e8978 addiu r7,r0,0x0001
0x000e897c lui r2,0x6666
0x000e8980 lh r3,0x0010(r5)
0x000e8984 ori r2,r2,0x6667
0x000e8988 mult r2,r3
0x000e898c lh r6,0x0014(r5)
0x000e8990 mfhi r2
0x000e8994 srl r3,r3,0x1f
0x000e8998 sra r2,r2,0x01
0x000e899c addu r2,r2,r3
0x000e89a0 slt r1,r2,r6
0x000e89a4 beq r1,r0,0x000e89b0
0x000e89a8 nop
0x000e89ac addu r7,r0,r0
0x000e89b0 beq r7,r0,0x000e89c0
0x000e89b4 addiu r2,r0,0x0021
0x000e89b8 beq r0,r0,0x000e89c0
0x000e89bc addiu r2,r0,0x0022
0x000e89c0 j 0x000c1a04
0x000e89c4 andi r5,r2,0x00ff