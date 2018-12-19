void handleDoubleFloppy() {
  if(load(0x1557F4) == 0) // check current HP
    return
  
  maxHP = load(0x1557F0) 
  maxMP = load(0x1557F2) 
  healValue(0x1557F4, 1500, maxHP)
  healValue(0x1557F6, 1500, maxMP)
  
  if(load(0x134F0A) == 1) { // check combat state?  
    store(stack + 0x10, 1)

    amount = 1500
    entityPtr = load(0x12F348) // Digimon entity data
    unknownValue = 0
    textColor = 11
    
    0x000DF868(entityPtr, unknownValue, textColor, amount) // display heal amount text
    
    store(stack + 0x10, 2)
    
    0x000DF868(entityPtr, unknownValue, textColor, amount) // display heal amount text
  }
  
  entityPtr = load(0x12F348)

  // entityDataPtr, particleType
  0x000C1560(entityPtr, 0) // play particle effects
}


0x000c4950 lui r1,0x8015
0x000c4954 addiu r29,r29,0xffe0
0x000c4958 lh r2,0x57f4(r1)
0x000c495c nop
0x000c4960 beq r2,r0,0x000c49f8
0x000c4964 sw r31,0x0018(r29)
0x000c4968 lui r1,0x8015
0x000c496c lui r4,0x8015
0x000c4970 lh r6,0x57f0(r1)
0x000c4974 addiu r4,r4,0x57f4
0x000c4978 jal 0x000c563c
0x000c497c addiu r5,r0,0x05dc
0x000c4980 lui r1,0x8015
0x000c4984 lui r4,0x8015
0x000c4988 lh r6,0x57f2(r1)
0x000c498c addiu r4,r4,0x57f6
0x000c4990 jal 0x000c563c
0x000c4994 addiu r5,r0,0x05dc
0x000c4998 lb r2,-0x6c22(r28)
0x000c499c addiu r1,r0,0x0001
0x000c49a0 bne r2,r1,0x000c49e8
0x000c49a4 nop
0x000c49a8 addiu r2,r0,0x0001
0x000c49ac sw r2,0x0010(r29)
0x000c49b0 lui r1,0x8013
0x000c49b4 lw r4,-0x0cb8(r1)
0x000c49b8 addu r5,r0,r0
0x000c49bc addiu r6,r0,0x000b
0x000c49c0 jal 0x000df868
0x000c49c4 addiu r7,r0,0x05dc
0x000c49c8 addiu r2,r0,0x0002
0x000c49cc sw r2,0x0010(r29)
0x000c49d0 lui r1,0x8013
0x000c49d4 lw r4,-0x0cb8(r1)
0x000c49d8 addu r5,r0,r0
0x000c49dc addiu r6,r0,0x000b
0x000c49e0 jal 0x000df868
0x000c49e4 addiu r7,r0,0x05dc
0x000c49e8 lui r1,0x8013
0x000c49ec lw r4,-0x0cb8(r1)
0x000c49f0 jal 0x000c1560
0x000c49f4 addu r5,r0,r0
0x000c49f8 lw r31,0x0018(r29)
0x000c49fc nop
0x000c4a00 jr r31
0x000c4a04 addiu r29,r29,0x0020