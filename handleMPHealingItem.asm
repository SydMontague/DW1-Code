void handleMPHealingItem(int itemId) {
  if(load(0x1557F4) == 0) // check current HP
    return

  itemOffset = itemId - 4
  healingAmount = load(0x13435C + itemOffset * 2)
  maxMP = load(0x1557F2) 

  healValue(0x1557F6, healingAmount, maxMP)

  if(load(0x134F0A) == 1) { // check combat state?  
    store(stack + 0x10, 2)
    amount = load(0x13435C + itemOffset * 2)
    entityPtr = load(0x12F348) // Digimon entity data
    unknownValue = 0
    textColor = 11
    
    // entityDataPtr, 0?, color, text
    0x000DF868(entityPtr, unknownValue, textColor, amount) // display heal amount text
  }

  particleType = load(0x134364 + itemOffset)
  entityPtr = load(0x12F348)

  // entityDataPtr, particleType
  0x000C1560(entityPtr, particleType) // play particle effects
}

0x000c4a08 addiu r29,r29,0xffd8
0x000c4a0c sw r31,0x0020(r29)
0x000c4a10 lui r1,0x8015
0x000c4a14 sw r17,0x001c(r29)
0x000c4a18 lh r2,0x57f4(r1)
0x000c4a1c nop
0x000c4a20 beq r2,r0,0x000c4aac
0x000c4a24 sw r16,0x0018(r29)
0x000c4a28 addi r2,r4,-0x0004
0x000c4a2c sll r3,r2,0x01
0x000c4a30 addu r17,r2,r0
0x000c4a34 addiu r2,r28,0x8830
0x000c4a38 addu r2,r2,r3
0x000c4a3c lui r1,0x8015
0x000c4a40 lui r4,0x8015
0x000c4a44 lh r5,0x0000(r2)
0x000c4a48 lh r6,0x57f2(r1)
0x000c4a4c addu r16,r3,r0
0x000c4a50 jal 0x000c563c
0x000c4a54 addiu r4,r4,0x57f6
0x000c4a58 lb r2,-0x6c22(r28)
0x000c4a5c addiu r1,r0,0x0001
0x000c4a60 bne r2,r1,0x000c4a90
0x000c4a64 nop
0x000c4a68 addiu r2,r0,0x0002
0x000c4a6c sw r2,0x0010(r29)
0x000c4a70 addiu r2,r28,0x8830
0x000c4a74 addu r2,r2,r16
0x000c4a78 lui r1,0x8013
0x000c4a7c lh r7,0x0000(r2)
0x000c4a80 lw r4,-0x0cb8(r1)
0x000c4a84 addu r5,r0,r0
0x000c4a88 jal 0x000df868
0x000c4a8c addiu r6,r0,0x000b
0x000c4a90 addiu r2,r28,0x8838
0x000c4a94 addu r2,r2,r17
0x000c4a98 lui r1,0x8013
0x000c4a9c lbu r5,0x0000(r2)
0x000c4aa0 lw r4,-0x0cb8(r1)
0x000c4aa4 jal 0x000c1560
0x000c4aa8 nop
0x000c4aac lw r31,0x0020(r29)
0x000c4ab0 lw r17,0x001c(r29)
0x000c4ab4 lw r16,0x0018(r29)
0x000c4ab8 jr r31
0x000c4abc addiu r29,r29,0x0028