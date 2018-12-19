/**
 * Handle whether battle idle animation should be started or not.
 */
void handleBattleIdle(entityPtr, statsPtr, flags) {
  
  // check noAI flag and unknown ptr
  if(load(0x134D74) != 0 && load(0x134D60) == entityPtr)
    return
  
  currentAnimId = load(entityPtr + 0x002E)
  
  if(currentAnimId == 0x21 || currentAnimId == 0x22)
    return
    
  startBattleIdleAnimation(entityPtr, statsPtr, flags)
}

0x000e7d40 addiu r29,r29,0xffe8
0x000e7d44 lw r2,-0x6db8(r28)
0x000e7d48 sw r31,0x0010(r29)
0x000e7d4c beq r2,r0,0x000e7d64
0x000e7d50 addu r5,r4,r0
0x000e7d54 lw r2,-0x6dcc(r28)
0x000e7d58 nop
0x000e7d5c beq r5,r2,0x000e7d8c
0x000e7d60 nop
0x000e7d64 lbu r2,0x002e(r5)
0x000e7d68 addiu r1,r0,0x0021
0x000e7d6c beq r2,r1,0x000e7d8c
0x000e7d70 addu r3,r2,r0
0x000e7d74 addiu r1,r0,0x0022
0x000e7d78 beq r3,r1,0x000e7d8c
0x000e7d7c nop
0x000e7d80 addu r4,r5,r0
0x000e7d84 jal 0x000e8970
0x000e7d88 addiu r5,r5,0x0038
0x000e7d8c lw r31,0x0010(r29)
0x000e7d90 nop
0x000e7d94 jr r31
0x000e7d98 addiu r29,r29,0x0018