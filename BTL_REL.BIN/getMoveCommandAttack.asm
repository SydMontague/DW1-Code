int getMoveCommandAttack(combatId, moveArray) {
  moveId = getStrongestMove(combatId, moveArray)
  
  if(moveId != -1)
    return moveId
  
  moveId = getBestTypeMove(combatId, moveArray)
  
  if(moveId != -1)
    return moveId
    
  return selectRandomMove(moveArray)
}

0x0005fdb4 addiu r29,r29,0xffe0
0x0005fdb8 sw r31,0x0018(r29)
0x0005fdbc sw r17,0x0014(r29)
0x0005fdc0 sw r16,0x0010(r29)
0x0005fdc4 addu r17,r4,r0
0x0005fdc8 jal 0x0005efcc
0x0005fdcc addu r16,r5,r0
0x0005fdd0 sll r2,r2,0x10
0x0005fdd4 sra r2,r2,0x10
0x0005fdd8 addiu r1,r0,0xffff
0x0005fddc beq r2,r1,0x0005fdec
0x0005fde0 addu r4,r17,r0
0x0005fde4 beq r0,r0,0x0005fe1c
0x0005fde8 lw r31,0x0018(r29)
0x0005fdec jal 0x0005f0c0
0x0005fdf0 addu r5,r16,r0
0x0005fdf4 sll r2,r2,0x10
0x0005fdf8 sra r2,r2,0x10
0x0005fdfc addiu r1,r0,0xffff
0x0005fe00 beq r2,r1,0x0005fe10
0x0005fe04 nop
0x0005fe08 beq r0,r0,0x0005fe1c
0x0005fe0c lw r31,0x0018(r29)
0x0005fe10 jal 0x0005ef58
0x0005fe14 addu r4,r16,r0
0x0005fe18 lw r31,0x0018(r29)
0x0005fe1c lw r17,0x0014(r29)
0x0005fe20 lw r16,0x0010(r29)
0x0005fe24 jr r31
0x0005fe28 addiu r29,r29,0x0020