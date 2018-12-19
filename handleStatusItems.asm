void handleStatusItems(int itemId) {
  if(load(0x1557F4) == 0) // check current HP
    return
   
  /*
   * 0x800C4778
   * 0x800C4788
   * 0x800C47B0
   * 0x800C4824
   * 0x800C4824
   * 0x800C47CC
   * 0x800C47FC
   */
  switch(itemId - 8) {
    case 0: // Various
      0x0005ED08(1) // heal status effects
      break
    case 1: // Omnipotent
      if(load(0x134F0A) == 1) { // check combat state?  
        0x0005ED08(0) // heal status effects
      handleDoubleFloppy(itemId)
      break
    case 2: // Protection
      combatData = load(0x134D4C)
      newState = load(combatData + 0x34) | 0x0100
      store(combatData + 0x34, newState)
      break
    case 5: // Bandage
      r2 = 0x000C566C(3, 2) // injury/sickness healing, injuryHealChance, soclmessHealChance
      if(r2 == 1) {// heal worked?
        // entityDataPtr, particleType
        0x000C1560(load(0x12F348), 0) // play particle effects
      }
      break
    case 6: // Medicine
      r2 = 0x000C566C(3, 10)  // injury/sickness healing, injuryHealChance, soclmessHealChance
      if(r2 == 1) { // heal worked?
        // entityDataPtr, particleType
        0x000C1560(load(0x12F348), 0) // play particle effects
      }
      break
    case 3:
    case 4:
    default:
      return
  }
}


0x000c4728 addiu r29,r29,0xffe8
0x000c472c sw r31,0x0014(r29)
0x000c4730 lui r1,0x8015
0x000c4734 sw r16,0x0010(r29)
0x000c4738 lh r2,0x57f4(r1)
0x000c473c nop
0x000c4740 beq r2,r0,0x000c4824
0x000c4744 addu r16,r4,r0
0x000c4748 addi r2,r16,-0x0008
0x000c474c sltiu r1,r2,0x0007
0x000c4750 beq r1,r0,0x000c4824
0x000c4754 nop
0x000c4758 lui r3,0x8011
0x000c475c addiu r3,r3,0x4a20
0x000c4760 sll r2,r2,0x02
0x000c4764 addu r2,r2,r3
0x000c4768 lw r2,0x0000(r2)
0x000c476c nop
0x000c4770 jr r2
0x000c4774 nop
0x000c4778 jal 0x0005ed08
0x000c477c addiu r4,r0,0x0001
0x000c4780 beq r0,r0,0x000c4828
0x000c4784 lw r31,0x0014(r29)
0x000c4788 lb r2,-0x6c22(r28)
0x000c478c addiu r1,r0,0x0001
0x000c4790 bne r2,r1,0x000c47a0
0x000c4794 nop
0x000c4798 jal 0x0005ed08
0x000c479c addu r4,r0,r0
0x000c47a0 jal 0x000c4950
0x000c47a4 addu r4,r16,r0
0x000c47a8 beq r0,r0,0x000c4828
0x000c47ac lw r31,0x0014(r29)
0x000c47b0 lw r3,-0x6de0(r28)
0x000c47b4 nop
0x000c47b8 lhu r2,0x0034(r3)
0x000c47bc nop
0x000c47c0 ori r2,r2,0x0100
0x000c47c4 beq r0,r0,0x000c4824
0x000c47c8 sh r2,0x0034(r3)
0x000c47cc addiu r4,r0,0x0003
0x000c47d0 jal 0x000c566c
0x000c47d4 addiu r5,r0,0x0002
0x000c47d8 addiu r1,r0,0x0001
0x000c47dc bne r2,r1,0x000c4824
0x000c47e0 nop
0x000c47e4 lui r1,0x8013
0x000c47e8 lw r4,-0x0cb8(r1)
0x000c47ec jal 0x000c1560
0x000c47f0 addu r5,r0,r0
0x000c47f4 beq r0,r0,0x000c4828
0x000c47f8 lw r31,0x0014(r29)
0x000c47fc addiu r4,r0,0x0003
0x000c4800 jal 0x000c566c
0x000c4804 addiu r5,r0,0x000a
0x000c4808 addiu r1,r0,0x0001
0x000c480c bne r2,r1,0x000c4824
0x000c4810 nop
0x000c4814 lui r1,0x8013
0x000c4818 lw r4,-0x0cb8(r1)
0x000c481c jal 0x000c1560
0x000c4820 addu r5,r0,r0
0x000c4824 lw r31,0x0014(r29)
0x000c4828 lw r16,0x0010(r29)
0x000c482c jr r31
0x000c4830 addiu r29,r29,0x0018