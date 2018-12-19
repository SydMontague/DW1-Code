int getMoveCommandModerate(combatId, moveArray) {
  r2 = getCheapestMove(combatId, moveArray)
  
  if(r2 != -1)
    return r2
    
  r2 = getBestTypeMove(combatId, moveArray)
  
  if(r2 != -1)
    return r2
    
  return selectRandomMove(moveArray)
}

0x0005fe2c addiu r29,r29,0xffe0
0x0005fe30 sw r31,0x0018(r29)
0x0005fe34 sw r17,0x0014(r29)
0x0005fe38 sw r16,0x0010(r29)
0x0005fe3c addu r17,r4,r0
0x0005fe40 jal 0x0005f244
0x0005fe44 addu r16,r5,r0
0x0005fe48 sll r2,r2,0x10
0x0005fe4c sra r2,r2,0x10
0x0005fe50 addiu r1,r0,0xffff
0x0005fe54 beq r2,r1,0x0005fe64
0x0005fe58 addu r4,r17,r0
0x0005fe5c beq r0,r0,0x0005fe94
0x0005fe60 lw r31,0x0018(r29)
0x0005fe64 jal 0x0005f0c0
0x0005fe68 addu r5,r16,r0
0x0005fe6c sll r2,r2,0x10
0x0005fe70 sra r2,r2,0x10
0x0005fe74 addiu r1,r0,0xffff
0x0005fe78 beq r2,r1,0x0005fe88
0x0005fe7c nop
0x0005fe80 beq r0,r0,0x0005fe94
0x0005fe84 lw r31,0x0018(r29)
0x0005fe88 jal 0x0005ef58
0x0005fe8c addu r4,r16,r0
0x0005fe90 lw r31,0x0018(r29)
0x0005fe94 lw r17,0x0014(r29)
0x0005fe98 lw r16,0x0010(r29)
0x0005fe9c jr r31
0x0005fea0 addiu r29,r29,0x0020