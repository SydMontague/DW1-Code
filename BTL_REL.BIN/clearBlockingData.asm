void clearBlockingData(combatPtr) {
  for(i = 0; i < 150; i++) {
    blockingDataPtr = combatPtr + i
    
    if(load(blockingDataPtr + 0x3C) == -1)
      return
    
    store(blockingDataPtr + 0x3C, -1)
    store(blockingDataPtr + 0xD2, -1)
  }
}

0x0005b254 beq r0,r0,0x0005b284
0x0005b258 addu r6,r0,r0
0x0005b25c addu r5,r6,r4
0x0005b260 lb r2,0x003c(r5)
0x0005b264 addiu r1,r0,0xffff
0x0005b268 beq r2,r1,0x0005b290
0x0005b26c nop
0x0005b270 addiu r3,r0,0xffff
0x0005b274 addu r2,r5,r0
0x0005b278 sb r3,0x003c(r2)
0x0005b27c sb r3,0x00d2(r5)
0x0005b280 addi r6,r6,0x0001
0x0005b284 slti r1,r6,0x0096
0x0005b288 bne r1,r0,0x0005b25c
0x0005b28c nop
0x0005b290 jr r31
0x0005b294 nop