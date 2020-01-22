isKeyDown(keyFlag) {
  if(load(0x135024) & keyFlag == 0)
    return 0
  
  store(0x135020, load(0x135020) & ~keyFlag)
  
  return 1
}

0x000fc054 lw r2,-0x6b08(r28)
0x000fc058 nop
0x000fc05c and r2,r2,r4
0x000fc060 bne r2,r0,0x000fc070
0x000fc064 nop
0x000fc068 beq r0,r0,0x000fc084
0x000fc06c addu r2,r0,r0
0x000fc070 lw r2,-0x6b0c(r28)
0x000fc074 nor r3,r4,r0
0x000fc078 and r2,r2,r3
0x000fc07c sw r2,-0x6b0c(r28)
0x000fc080 addiu r2,r0,0x0001
0x000fc084 jr r31
0x000fc088 nop