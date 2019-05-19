int getNumMasteredMoves() {
  masteredMoves = 0
  
  for(i = 0; i < 2; i++) {
    moveData = load(0x155800 + i * 4)
    
    for(j = 0; j < 32; j++)
      if(moveData & 1 << j != 0)
        masteredMoves++
  }
  
  return masteredMoves
}

0x000e3510 addu r2,r0,r0
0x000e3514 addu r4,r0,r0
0x000e3518 beq r0,r0,0x000e3570
0x000e351c addu r7,r0,r0
0x000e3520 lui r3,0x8015
0x000e3524 addiu r3,r3,0x5800
0x000e3528 addu r3,r3,r7
0x000e352c lw r6,0x0000(r3)
0x000e3530 beq r0,r0,0x000e355c
0x000e3534 addu r5,r0,r0
0x000e3538 addiu r3,r0,0x0001
0x000e353c sllv r3,r3,r5
0x000e3540 and r3,r6,r3
0x000e3544 beq r3,r0,0x000e3558
0x000e3548 nop
0x000e354c addi r2,r2,0x0001
0x000e3550 sll r2,r2,0x18
0x000e3554 sra r2,r2,0x18
0x000e3558 addi r5,r5,0x0001
0x000e355c slti r1,r5,0x0020
0x000e3560 bne r1,r0,0x000e3538
0x000e3564 nop
0x000e3568 addi r4,r4,0x0001
0x000e356c addi r7,r7,0x0004
0x000e3570 slti r1,r4,0x0002
0x000e3574 bne r1,r0,0x000e3520
0x000e3578 nop
0x000e357c jr r31
0x000e3580 nop