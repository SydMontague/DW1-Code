void 0x00059CF0(entityPtr = r4, enemyPtr = r5, combatPtr = r6, combatId = r7) {
  if(load(0x134F54) != 0 && load(0x134D60) != entityPtr) {
    handleBattleIdle(entityPtr, entityPtr + 0x38, load(combatPtr + 0x34))
    return
  }
  
  if(0x00059E54(entityPtr, enemyPtr, combatPtr) != 0)
    return
  
  moveRange = load(combatPtr + 0x36)
  
  if(moveRange == 1) {
    if(0x0005A06C(entityPtr, enemyPtr, combatPtr, combatId) == 0)
      return
    
    0x000D4884(enemyPtr, entityPtr, 280, 200)
    return
  }
  else if(moveRange == 2 || moveRange == 3) {
    moveId = load(combatPtr + 0x38) - 0x2E
    entityType = load(entityPtr)
    techId = load(0x12CEB4 + entityType * 52 + moveId)
    
    0x0005A37C(entityPtr, enemyPtr, combatPtr, techId)
  }
  else if(moveRange == 4) {
    handleBattleIdle(entityPtr, entityPtr + 0x38, load(combatPtr + 0x34))
    0x0005D79C(entityPtr, enemyPtr, combatPtr)
  }
}

0x00059cf0 addiu r29,r29,0xffd8
0x00059cf4 sw r31,0x0020(r29)
0x00059cf8 sw r19,0x001c(r29)
0x00059cfc sw r18,0x0018(r29)
0x00059d00 sw r17,0x0014(r29)
0x00059d04 sw r16,0x0010(r29)
0x00059d08 lw r2,-0x6db8(r28)
0x00059d0c addu r16,r4,r0
0x00059d10 addu r18,r5,r0
0x00059d14 addu r17,r6,r0
0x00059d18 beq r2,r0,0x00059d44
0x00059d1c addu r19,r7,r0
0x00059d20 lw r2,-0x6dcc(r28)
0x00059d24 nop
0x00059d28 beq r2,r16,0x00059d44
0x00059d2c nop
0x00059d30 lhu r6,0x0034(r17)
0x00059d34 jal 0x000e7d40
0x00059d38 addiu r5,r16,0x0038
0x00059d3c beq r0,r0,0x00059e3c
0x00059d40 lw r31,0x0020(r29)
0x00059d44 addu r4,r16,r0
0x00059d48 addu r5,r18,r0
0x00059d4c jal 0x00059e54
0x00059d50 addu r6,r17,r0
0x00059d54 bne r2,r0,0x00059e38
0x00059d58 nop
0x00059d5c lb r2,0x0036(r17)
0x00059d60 addiu r1,r0,0x0004
0x00059d64 beq r2,r1,0x00059e18
0x00059d68 nop
0x00059d6c addiu r1,r0,0x0003
0x00059d70 beq r2,r1,0x00059dcc
0x00059d74 nop
0x00059d78 addiu r1,r0,0x0002
0x00059d7c beq r2,r1,0x00059dcc
0x00059d80 nop
0x00059d84 addiu r1,r0,0x0001
0x00059d88 bne r2,r1,0x00059e38
0x00059d8c nop
0x00059d90 sll r7,r19,0x10
0x00059d94 sra r7,r7,0x10
0x00059d98 addu r4,r16,r0
0x00059d9c addu r5,r18,r0
0x00059da0 jal 0x0005a06c
0x00059da4 addu r6,r17,r0
0x00059da8 beq r2,r0,0x00059e38
0x00059dac nop
0x00059db0 addu r4,r18,r0
0x00059db4 addu r5,r16,r0
0x00059db8 addiu r6,r0,0x0118
0x00059dbc jal 0x000d4884
0x00059dc0 addiu r7,r0,0x00c8
0x00059dc4 beq r0,r0,0x00059e3c
0x00059dc8 lw r31,0x0020(r29)
0x00059dcc lbu r2,0x0038(r17)
0x00059dd0 lw r3,0x0000(r16)
0x00059dd4 addi r4,r2,-0x002e
0x00059dd8 sll r2,r3,0x01
0x00059ddc add r2,r2,r3
0x00059de0 sll r2,r2,0x02
0x00059de4 add r2,r2,r3
0x00059de8 sll r3,r2,0x02
0x00059dec lui r2,0x8013
0x00059df0 addiu r2,r2,0xceb4
0x00059df4 addu r2,r2,r3
0x00059df8 addu r2,r4,r2
0x00059dfc lbu r7,0x0023(r2)
0x00059e00 addu r4,r16,r0
0x00059e04 addu r5,r18,r0
0x00059e08 jal 0x0005a37c
0x00059e0c addu r6,r17,r0
0x00059e10 beq r0,r0,0x00059e3c
0x00059e14 lw r31,0x0020(r29)
0x00059e18 lhu r6,0x0034(r17)
0x00059e1c addu r4,r16,r0
0x00059e20 jal 0x000e7d40
0x00059e24 addiu r5,r16,0x0038
0x00059e28 addu r4,r16,r0
0x00059e2c addu r5,r18,r0
0x00059e30 jal 0x0005d79c
0x00059e34 addu r6,r17,r0
0x00059e38 lw r31,0x0020(r29)
0x00059e3c lw r19,0x001c(r29)
0x00059e40 lw r18,0x0018(r29)
0x00059e44 lw r17,0x0014(r29)
0x00059e48 lw r16,0x0010(r29)
0x00059e4c jr r31
0x00059e50 addiu r29,r29,0x0028