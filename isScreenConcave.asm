boolean isScreenConcave() {
  r4 = load(0x134DA8) // current screen

  for(int r3 = 0; r3 < 18; r3++) {
    r2 = load(0x12BB20 + r3)
    
    if(r4 == r2)
      return 1
  }

  return 0
}

0x000e7484 lbu r4,-0x6d84(r28)
0x000e7488 beq r0,r0,0x000e74b8
0x000e748c addu r3,r0,r0
0x000e7490 lui r2,0x8013
0x000e7494 addiu r2,r2,0xbb20
0x000e7498 addu r2,r2,r3
0x000e749c lbu r2,0x0000(r2)
0x000e74a0 nop
0x000e74a4 bne r4,r2,0x000e74b4
0x000e74a8 nop
0x000e74ac beq r0,r0,0x000e74c8
0x000e74b0 addiu r2,r0,0x0001
0x000e74b4 addi r3,r3,0x0001
0x000e74b8 slti r1,r3,0x0012
0x000e74bc bne r1,r0,0x000e7490
0x000e74c0 nop
0x000e74c4 addu r2,r0,r0
0x000e74c8 jr r31
0x000e74cc nop
