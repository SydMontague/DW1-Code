void handleHPHealingItem(int itemId) {
  if(load(0x1557F4) == 0) // check current HP
    return

  healingAmount = load(0x13435C + itemId * 2)
  maxHP = load(0x1557F0) 

  healValue(0x1557F4, healingAmount, maxHP)

  if(load(0x134F0A) == 1) { // check combat state?  
    store(stack + 0x10, 1)
    amount = load(0x13435C + itemId * 2)
    entityPtr = load(0x12F348) // Digimon entity data
    unknownValue = 0
    textColor = 11
    
    // entityDataPtr, 0?, color, text
    0x000DF868(entityPtr, unknownValue, textColor, amount) // display heal amount text
  }

  particleType = load(0x134364 + itemId)
  entityPtr = load(0x12F348)

  // entityDataPtr, particleType
  0x000C1560(entityPtr, particleType) // play particle effects
}

0x000c4ac0 addiu r29,r29,0xffd8
0x000c4ac4 sw r31,0x0020(r29)
0x000c4ac8 lui r1,0x8015
0x000c4acc sw r17,0x001c(r29)
0x000c4ad0 lh r2,0x57f4(r1)
0x000c4ad4 nop
0x000c4ad8 beq r2,r0,0x000c4b60
0x000c4adc sw r16,0x0018(r29)
0x000c4ae0 sll r3,r4,0x01
0x000c4ae4 addiu r2,r28,0x8830
0x000c4ae8 addu r17,r4,r0
0x000c4aec addu r2,r2,r3
0x000c4af0 lui r1,0x8015
0x000c4af4 lui r4,0x8015
0x000c4af8 lh r5,0x0000(r2)
0x000c4afc lh r6,0x57f0(r1)
0x000c4b00 addu r16,r3,r0
0x000c4b04 jal 0x000c563c
0x000c4b08 addiu r4,r4,0x57f4
0x000c4b0c lb r2,-0x6c22(r28)
0x000c4b10 addiu r1,r0,0x0001
0x000c4b14 bne r2,r1,0x000c4b44
0x000c4b18 nop
0x000c4b1c addiu r2,r0,0x0001
0x000c4b20 sw r2,0x0010(r29)
0x000c4b24 addiu r2,r28,0x8830
0x000c4b28 addu r2,r2,r16
0x000c4b2c lui r1,0x8013
0x000c4b30 lh r7,0x0000(r2)
0x000c4b34 lw r4,-0x0cb8(r1)
0x000c4b38 addu r5,r0,r0
0x000c4b3c jal 0x000df868
0x000c4b40 addiu r6,r0,0x000b
0x000c4b44 addiu r2,r28,0x8838
0x000c4b48 addu r2,r2,r17
0x000c4b4c lui r1,0x8013
0x000c4b50 lbu r5,0x0000(r2)
0x000c4b54 lw r4,-0x0cb8(r1)
0x000c4b58 jal 0x000c1560
0x000c4b5c nop
0x000c4b60 lw r31,0x0020(r29)
0x000c4b64 lw r17,0x001c(r29)
0x000c4b68 lw r16,0x0018(r29)
0x000c4b6c jr r31
0x000c4b70 addiu r29,r29,0x0028