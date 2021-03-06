void handleRestore(int itemId) {
  if(load(0x134F0A) == 1) { // check combat state?  
    0x00062874() // probably healing "dead" state
  
  if(load(0x1557F4) == 0) { // check current HP
    0x000C1A04(load(0x12F348), 0x2C) // play standup animation?
  }
  
  if(itemId == 0xB) {
    maxHP = load(0x1557F0)
  
    if(maxHP >= 0) 
      maxHP += 1
      
    healAmount = maxHP / 2
  } 
  else if(itemId == 0xC) {
    if(load(0x134F0A) == 1) { // check combat state?  
      0x0005ED08(0) // heal status effects
      
    healAmount = 9999
  }
  
  healValue(0x1557F4, healAmount, load(0x1557F0))
  
  if(load(0x134F0A) == 1) { // is in combat
    store(stack + 0x10, 1)
    entityPtr = load(0x12F348)
    unknown = 0
    color = 0xB
    0x000DF868(entityPtr, unknown, color, healAmount) // heal amount display
  }
  
  0x000C1560(load(0x12F348), 1) // particle effects
}

0x000c4834 addiu r29,r29,0xffd8
0x000c4838 sw r31,0x0020(r29)
0x000c483c sw r17,0x001c(r29)
0x000c4840 lb r2,-0x6c22(r28)
0x000c4844 sw r16,0x0018(r29)
0x000c4848 addiu r1,r0,0x0001
0x000c484c bne r2,r1,0x000c485c
0x000c4850 addu r17,r4,r0
0x000c4854 jal 0x00062874
0x000c4858 nop
0x000c485c lui r1,0x8015
0x000c4860 lh r2,0x57f4(r1)
0x000c4864 nop
0x000c4868 bne r2,r0,0x000c4880
0x000c486c nop
0x000c4870 lui r1,0x8013
0x000c4874 lw r4,-0x0cb8(r1)
0x000c4878 jal 0x000c1a04
0x000c487c addiu r5,r0,0x002c
0x000c4880 addiu r1,r0,0x000c
0x000c4884 beq r17,r1,0x000c48c0
0x000c4888 nop
0x000c488c addiu r1,r0,0x000b
0x000c4890 bne r17,r1,0x000c48e4
0x000c4894 nop
0x000c4898 lui r1,0x8015
0x000c489c lh r2,0x57f0(r1)
0x000c48a0 nop
0x000c48a4 bgez r2,0x000c48b4
0x000c48a8 sra r25,r2,0x01
0x000c48ac addiu r2,r2,0x0001
0x000c48b0 sra r25,r2,0x01
0x000c48b4 sll r16,r25,0x10
0x000c48b8 beq r0,r0,0x000c48e4
0x000c48bc sra r16,r16,0x10
0x000c48c0 lb r2,-0x6c22(r28)
0x000c48c4 addiu r1,r0,0x0001
0x000c48c8 bne r2,r1,0x000c48d8
0x000c48cc nop
0x000c48d0 jal 0x0005ed08
0x000c48d4 addu r4,r0,r0
0x000c48d8 addiu r2,r0,0x270f
0x000c48dc sll r16,r2,0x10
0x000c48e0 sra r16,r16,0x10
0x000c48e4 lui r1,0x8015
0x000c48e8 lui r4,0x8015
0x000c48ec lh r6,0x57f0(r1)
0x000c48f0 addiu r4,r4,0x57f4
0x000c48f4 jal 0x000c563c
0x000c48f8 addu r5,r16,r0
0x000c48fc lb r2,-0x6c22(r28)
0x000c4900 addiu r1,r0,0x0001
0x000c4904 bne r2,r1,0x000c492c
0x000c4908 nop
0x000c490c addiu r2,r0,0x0001
0x000c4910 sw r2,0x0010(r29)
0x000c4914 lui r1,0x8013
0x000c4918 lw r4,-0x0cb8(r1)
0x000c491c addu r5,r0,r0
0x000c4920 addiu r6,r0,0x000b
0x000c4924 jal 0x000df868
0x000c4928 addu r7,r16,r0
0x000c492c lui r1,0x8013
0x000c4930 lw r4,-0x0cb8(r1)
0x000c4934 jal 0x000c1560
0x000c4938 addiu r5,r0,0x0001
0x000c493c lw r31,0x0020(r29)
0x000c4940 lw r17,0x001c(r29)
0x000c4944 lw r16,0x0018(r29)
0x000c4948 jr r31
0x000c494c addiu r29,r29,0x0028