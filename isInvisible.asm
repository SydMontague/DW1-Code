boolean isInvisible(int entityPtr) {
  if(entityPtr == 0)
    return 1
    
  if(load(entityPtr + 0x35) == 0) // is not on screen
    return 1
    
  if(load(entityPtr + 0x34) == 0) // is not on map
    return 1
  
  return 0
}

0x000e61ac beq r4,r0,0x000e61d4
0x000e61b0 nop
0x000e61b4 lb r2,0x0035(r4)
0x000e61b8 nop
0x000e61bc beq r2,r0,0x000e61d4
0x000e61c0 nop
0x000e61c4 lb r2,0x0034(r4)
0x000e61c8 nop
0x000e61cc bne r2,r0,0x000e61dc
0x000e61d0 addu r2,r0,r0
0x000e61d4 beq r0,r0,0x000e61dc
0x000e61d8 addiu r2,r0,0x0001
0x000e61dc jr r31
0x000e61e0 nop