void tickDeathCondition() {
  transLockActive = load(0x134CA8)
  transLockHour = load(0x134CA4)
  currentHour = load(0x134EBC)
  
  if(transLockActive == 1 && transLockHour == currentHour)
    return
  
  if(load(0x1384A8) > 0) // remaining Lifetime
    return
  
  if(load(0x134C5B) == 8) // is in dying state
    return
  
  if(loadMenuState() != 0)
    return
  
  if(load(0x134FF4) != 1) // is script running
    return
  
  store(0x134C4C, 1)
  writePStat(255, 0)
  store(0x1384A8, 0)
  
  callScriptSection(0, 0x4DE, 0)
}

0x000a8a3c addiu r29,r29,0xffe8
0x000a8a40 lw r2,-0x6e84(r28)
0x000a8a44 addiu r1,r0,0x0001
0x000a8a48 bne r2,r1,0x000a8a64
0x000a8a4c sw r31,0x0010(r29)
0x000a8a50 lb r3,-0x6e88(r28)
0x000a8a54 lh r2,-0x6c70(r28)
0x000a8a58 nop
0x000a8a5c beq r3,r2,0x000a8ad4
0x000a8a60 nop
0x000a8a64 lui r1,0x8014
0x000a8a68 lh r2,-0x7b58(r1)
0x000a8a6c nop
0x000a8a70 bgtz r2,0x000a8ad4
0x000a8a74 nop
0x000a8a78 lb r2,-0x6ed1(r28)
0x000a8a7c addiu r1,r0,0x0008
0x000a8a80 beq r2,r1,0x000a8ad4
0x000a8a84 nop
0x000a8a88 jal 0x000ac050
0x000a8a8c nop
0x000a8a90 bne r2,r0,0x000a8ad4
0x000a8a94 nop
0x000a8a98 lw r2,-0x6b38(r28)
0x000a8a9c addiu r1,r0,0x0001
0x000a8aa0 bne r2,r1,0x000a8ad4
0x000a8aa4 nop
0x000a8aa8 addiu r2,r0,0x0001
0x000a8aac sw r2,-0x6ee0(r28)
0x000a8ab0 addiu r4,r0,0x00ff
0x000a8ab4 jal 0x00106474
0x000a8ab8 addu r5,r0,r0
0x000a8abc lui r1,0x8014
0x000a8ac0 sh r0,-0x7b58(r1)
0x000a8ac4 addu r4,r0,r0
0x000a8ac8 addiu r5,r0,0x04de
0x000a8acc jal 0x00105b14
0x000a8ad0 addu r6,r0,r0
0x000a8ad4 lw r31,0x0010(r29)
0x000a8ad8 nop
0x000a8adc jr r31
0x000a8ae0 addiu r29,r29,0x0018