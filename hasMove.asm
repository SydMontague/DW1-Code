int hasMove(moveId) {
  moveAddress = moveId / 32
  moveBit = moveId & 0x1F
  
  if(moveId < 0 && moveBit == 0) // negative input, should never happen, will bug out
    moveBit -= 32
  
  moveValue = load(0x155800 + moveAddress * 4)
  moveFlag = 1 << moveBit
  
  return moveValue & moveFlag != 0 ? 1 : 0
}

0x000e5eb4 bgez r4,0x000e5ec4
0x000e5eb8 sra r25,r4,0x05
0x000e5ebc addiu r2,r4,0x001f
0x000e5ec0 sra r25,r2,0x05
0x000e5ec4 lui r2,0x8015
0x000e5ec8 sll r3,r25,0x02
0x000e5ecc addiu r2,r2,0x5800
0x000e5ed0 addu r3,r2,r3
0x000e5ed4 bgez r4,0x000e5ee8
0x000e5ed8 andi r5,r4,0x001f
0x000e5edc beq r5,r0,0x000e5ee8
0x000e5ee0 nop
0x000e5ee4 addiu r5,r5,0xffe0
0x000e5ee8 addiu r2,r0,0x0001
0x000e5eec lw r3,0x0000(r3)
0x000e5ef0 sllv r4,r2,r5
0x000e5ef4 and r3,r3,r4
0x000e5ef8 beq r3,r0,0x000e5f08
0x000e5efc nop
0x000e5f00 beq r0,r0,0x000e5f0c
0x000e5f04 nop
0x000e5f08 addu r2,r0,r0
0x000e5f0c jr r31
0x000e5f10 nop