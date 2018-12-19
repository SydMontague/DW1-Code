void handleConfusion(entityPtr, combatPtr, combatId) {
  if(random(10) < 7)
    store(combatPtr + 0x37, -1)
  else {
    enemyList, enemyCount = getRemainingEnemies(entityPtr)
    store(combatPtr + 0x37, enemyList[random(enemyCount)])
  }
  
  moveArray = short[4]
  numAffordableMoves = hasAffordableMoves(moveArray, combatId)
  
  if(numAffordableMoves == 0) 
    setCooldown(entityPtr, combatPtr)
  else {
    moveId = selectRandomMove(moveArray)
    setMoveAnim(entityPtr, combatPtr, combatId, moveId)
  }
}

0x0005fc18 addiu r29,r29,0xffc8
0x0005fc1c sw r31,0x001c(r29)
0x0005fc20 sw r18,0x0018(r29)
0x0005fc24 sw r17,0x0014(r29)
0x0005fc28 sw r16,0x0010(r29)
0x0005fc2c addu r17,r4,r0
0x0005fc30 addu r16,r5,r0
0x0005fc34 addu r18,r6,r0
0x0005fc38 jal 0x000a36d4
0x0005fc3c addiu r4,r0,0x000a
0x0005fc40 slti r1,r2,0x0007
0x0005fc44 beq r1,r0,0x0005fc58
0x0005fc48 addu r4,r17,r0
0x0005fc4c addiu r2,r0,0x00ff
0x0005fc50 beq r0,r0,0x0005fc84
0x0005fc54 sb r2,0x0037(r16)
0x0005fc58 addiu r5,r29,0x002c
0x0005fc5c jal 0x0005fce8
0x0005fc60 addiu r6,r29,0x0036
0x0005fc64 lh r4,0x0036(r29)
0x0005fc68 jal 0x000a36d4
0x0005fc6c nop
0x0005fc70 sll r2,r2,0x01
0x0005fc74 addu r2,r29,r2
0x0005fc78 lh r2,0x002c(r2)
0x0005fc7c nop
0x0005fc80 sb r2,0x0037(r16)
0x0005fc84 sll r5,r18,0x10
0x0005fc88 sra r5,r5,0x10
0x0005fc8c jal 0x0005ee58
0x0005fc90 addiu r4,r29,0x0024
0x0005fc94 bne r2,r0,0x0005fcb0
0x0005fc98 nop
0x0005fc9c addu r4,r17,r0
0x0005fca0 jal 0x0005ef3c
0x0005fca4 addu r5,r16,r0
0x0005fca8 beq r0,r0,0x0005fcd4
0x0005fcac lw r31,0x001c(r29)
0x0005fcb0 jal 0x0005ef58
0x0005fcb4 addiu r4,r29,0x0024
0x0005fcb8 sll r6,r18,0x10
0x0005fcbc andi r7,r2,0x00ff
0x0005fcc0 sra r6,r6,0x10
0x0005fcc4 addu r4,r17,r0
0x0005fcc8 jal 0x0005d658
0x0005fccc addu r5,r16,r0
0x0005fcd0 lw r31,0x001c(r29)
0x0005fcd4 lw r18,0x0018(r29)
0x0005fcd8 lw r17,0x0014(r29)
0x0005fcdc lw r16,0x0010(r29)
0x0005fce0 jr r31
0x0005fce4 addiu r29,r29,0x0038