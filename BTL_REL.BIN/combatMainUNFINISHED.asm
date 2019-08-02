void combatMain() {
  // defines the center of the area of combat in background image coordinates
  xCenter = 160 - load(0x134EC0) // screen offset X, top left corner of background image
  yCenter = 120 - load(0x134EC4) // screen offset Y, top left corner of background image
  store(0x134D8C, xCenter)
  store(0x134D88, yCenter)
  
  combatInit()
  combatInitEntityPositions()
  
  while(checkCombatEndCondition() == 0) {
    partnerAiTick()
    enemyAiTick()
    0x00058874()
    0x00058AA4()
    0x0005DEC4()
    0x000E62D0()
    
    store(0x134D66, load(0x134D66) + 1) // frame count
  }
  
  0x000E642C()
  0x00058C68()
  
  combatHead = load(0x134D4C)
  
  if(load(0x1557F4) == 0) { // HP is 0
    store(combatHead + 0x064E, 0)
    return -1
  }
  
  if(load(combatHead + 0x064E) == 1) { // command is run away
    store(combatHead + 0x064E, 0)
    return 0
  }
  
  return 1
}

0x0005b5f4 addiu r29,r29,0xffe8
0x0005b5f8 lw r2,-0x6c6c(r28)
0x0005b5fc addiu r3,r0,0x00a0
0x0005b600 sub r2,r3,r2
0x0005b604 sw r2,-0x6da0(r28)
0x0005b608 lw r2,-0x6c68(r28)
0x0005b60c addiu r3,r0,0x0078
0x0005b610 sub r2,r3,r2
0x0005b614 sw r31,0x0010(r29)
0x0005b618 sw r2,-0x6da4(r28)
0x0005b61c jal 0x00056ca8
0x0005b620 nop
0x0005b624 jal 0x0005736c
0x0005b628 nop
0x0005b62c jal 0x00057920
0x0005b630 nop
0x0005b634 bne r2,r0,0x0005b680
0x0005b638 nop
0x0005b63c jal 0x00057bd0
0x0005b640 nop
0x0005b644 jal 0x00058394
0x0005b648 nop
0x0005b64c jal 0x00058874
0x0005b650 nop
0x0005b654 jal 0x00058aa4
0x0005b658 nop
0x0005b65c jal 0x0005dec4
0x0005b660 nop
0x0005b664 jal 0x000e62d0
0x0005b668 nop
0x0005b66c lh r2,-0x6dc6(r28)
0x0005b670 nop
0x0005b674 addi r2,r2,0x0001
0x0005b678 beq r0,r0,0x0005b62c
0x0005b67c sh r2,-0x6dc6(r28)
0x0005b680 jal 0x000e642c
0x0005b684 nop
0x0005b688 jal 0x00058c68
0x0005b68c nop
0x0005b690 lui r1,0x8015
0x0005b694 lh r2,0x57f4(r1)
0x0005b698 nop
0x0005b69c bne r2,r0,0x0005b6b8
0x0005b6a0 nop
0x0005b6a4 lw r2,-0x6de0(r28)
0x0005b6a8 nop
0x0005b6ac sb r0,0x064e(r2)
0x0005b6b0 beq r0,r0,0x0005b6dc
0x0005b6b4 addiu r2,r0,0xffff
0x0005b6b8 lw r3,-0x6de0(r28)
0x0005b6bc addiu r1,r0,0x0001
0x0005b6c0 lbu r2,0x064e(r3)
0x0005b6c4 nop
0x0005b6c8 bne r2,r1,0x0005b6dc
0x0005b6cc addiu r2,r0,0x0001
0x0005b6d0 sb r0,0x064e(r3)
0x0005b6d4 beq r0,r0,0x0005b6dc
0x0005b6d8 addu r2,r0,r0
0x0005b6dc lw r31,0x0010(r29)
0x0005b6e0 nop
0x0005b6e4 jr r31
0x0005b6e8 addiu r29,r29,0x0018