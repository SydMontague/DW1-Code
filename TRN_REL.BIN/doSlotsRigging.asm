// still ugly and dirty...
void doSlotsRigging(reelNr, dataOffset) {
  canDoSlots = load(dataOffset + 0x22) // canDoSlots
  
  reel1 = load(dataOffset + 0x0B) // first reel symbol
  reel2 = load(dataOffset + 0x0C) // second reel symbol
  
  if(canDoSlots == 2) {
    
    if((reelNr == 2 && reel1 == 7 && reel2 == 7) || (reelNr == 1 && reel1 == 7) || reelNr == 0) {
      for(i = 1; i < 3; i++) {
        symbolOffset = (load(dataOffset + reelNr + 0x08) + 0x0D - i) % 0x0D
        
        if(load(0x8F1AC + reelNr * 13 + symbolOffset) == 7)
          break
      }
      
      if(i == 3) {
        store(dataOffset + reelNr + 0x0E, 0)
        store(dataOffset + reelNr + 0x0B, -1)
      }
      else {
        store(dataOffset + reelNr + 0x0E, i - 1)
        store(dataOffset + reelNr + 0x0B, 7)
      }
    }
    else
      store(reelNr + dataOffset + 0x0B, -reelNr - 1)
  }
  else if(canDoSlots == 1) {
    if(reelNr == 2 && reel1 != reel2)
      return
    
    if(reelNr == 0 || reelNr == 1 && reel1 == 7) {
      subOffset = load(reelNr * 2 + dataOffset + 0x12) == 0 ? 0 : 1
      symbolOffset = (load(reelNr + dataOffset + 0x08) + 0x0D - subOffset) % 0x0D
      
      symbolId = load(0x8F1AC + reelNr * 0x0D + symbolOffset)
      store(dataOffset + reelNr + 0x0B, symbolId)
    }
    else if(reelNr == 1 || reelNr == 2 && reel1 != 7) {
      for(i = 1; i < 3; i++) {
        symbolOffset = (load(reelNr + dataOffset + 0x08) + 0x0D - i) % 0x0D
        
        if(load(0x08F1AC + reelNr * 0x0D + symbolOffset) == reel1)
          break
      }
      
      if(i == 3 || i == 0) {
        store(reelNr + dataOffset + 0x0E, 0)
        store(reelNr + dataOffset + 0x0B, -2)
      }
      else {
        store(reelNr + dataOffset + 0x0E, i - 1)
        store(reelNr + dataOffset + 0x0B, reel1)
      }
    }
    else if(reelNr == 2) { // reel1 == 7 implied
      symbolOffset = (load(reelNr + dataOffset + 0x08) + 0x0C) % 0x0D
      symbolId = load(0x8F1AC + reelNr * 13 + symbolOffset)
      
      if(symbolId != 7)
        return
      
      overroll = 1 + rand() % 2 // effective code
      // this was probably supposed to be a 25% chance for the game not fucking you over
      
      store(reelNr + dataOffset + 0x0E, overroll)
    }
  }
  else if(canDoSlots == 0) {
    if(reelNr == 2 && reel1 != reel2)
      return
    
    if(reelNr == 0 || reelNr == 1) {
      symbolOffset = (load(reelNr + dataOffset + 0x08) + 0x0C) % 0x0D
      symbolId = load(0x8F1AC + reelNr * 0x0D + symbolOffset)
      
      store(dataOffset + reelNr + 0x0B, symbolId)
    }
    else if(reelNr == 2) {
      symbolOffset = (load(reelNr + dataOffset + 0x08) + 0x0C) % 0x0D
      symbolId = load(0x8F1AC + reelNr * 13 + symbolOffset)
      
      if(symbolId != reel2)
        return
      
      overroll = 1 + rand() % 2 // effective code
      // this was probably supposed to be a 25% chance for the game not fucking you over
        
      store(dataOffset + reelNr + 0x0E, overroll)
    }
  }
}

0x0008e824 addiu r29,r29,0xffe0
0x0008e828 sw r31,0x0018(r29)
0x0008e82c sw r17,0x0014(r29)
0x0008e830 sw r16,0x0010(r29)
0x0008e834 addiu r1,r0,0x0002
0x0008e838 beq r4,r1,0x0008eb24
0x0008e83c addu r16,r5,r0
0x0008e840 addiu r1,r0,0x0001
0x0008e844 beq r4,r1,0x0008e9d8
0x0008e848 nop
0x0008e84c bne r4,r0,0x0008ed50
0x0008e850 nop
0x0008e854 lb r2,0x0022(r16)
0x0008e858 addiu r1,r0,0x0002
0x0008e85c beq r2,r1,0x0008e930
0x0008e860 nop
0x0008e864 addiu r1,r0,0x0001
0x0008e868 beq r2,r1,0x0008e8c0
0x0008e86c nop
0x0008e870 bne r2,r0,0x0008ed50
0x0008e874 nop
0x0008e878 addu r6,r4,r16
0x0008e87c lb r2,0x0008(r6)
0x0008e880 nop
0x0008e884 addi r3,r2,0x000c
0x0008e888 addiu r2,r0,0x000d
0x0008e88c div r3,r2
0x0008e890 sll r2,r4,0x01
0x0008e894 add r2,r2,r4
0x0008e898 sll r2,r2,0x02
0x0008e89c add r3,r2,r4
0x0008e8a0 lui r2,0x8009
0x0008e8a4 addiu r2,r2,0xf1ac
0x0008e8a8 mfhi r5
0x0008e8ac addu r2,r2,r3
0x0008e8b0 addu r2,r5,r2
0x0008e8b4 lb r2,0x0000(r2)
0x0008e8b8 beq r0,r0,0x0008ed50
0x0008e8bc sb r2,0x000b(r6)
0x0008e8c0 sll r2,r4,0x01
0x0008e8c4 addu r2,r2,r16
0x0008e8c8 lh r2,0x0012(r2)
0x0008e8cc nop
0x0008e8d0 bne r2,r0,0x0008e8e0
0x0008e8d4 addu r6,r4,r0
0x0008e8d8 beq r0,r0,0x0008e8e4
0x0008e8dc addu r2,r0,r0
0x0008e8e0 addiu r2,r0,0x0001
0x0008e8e4 addu r5,r6,r16
0x0008e8e8 lb r3,0x0008(r5)
0x0008e8ec nop
0x0008e8f0 addi r3,r3,0x000d
0x0008e8f4 sub r3,r3,r2
0x0008e8f8 addiu r2,r0,0x000d
0x0008e8fc div r3,r2
0x0008e900 sll r2,r6,0x01
0x0008e904 add r2,r2,r6
0x0008e908 sll r2,r2,0x02
0x0008e90c add r3,r2,r6
0x0008e910 lui r2,0x8009
0x0008e914 addiu r2,r2,0xf1ac
0x0008e918 mfhi r4
0x0008e91c addu r2,r2,r3
0x0008e920 addu r2,r4,r2
0x0008e924 lb r2,0x0000(r2)
0x0008e928 beq r0,r0,0x0008ed50
0x0008e92c sb r2,0x000b(r5)
0x0008e930 sll r3,r4,0x01
0x0008e934 add r3,r3,r4
0x0008e938 sll r3,r3,0x02
0x0008e93c addiu r2,r0,0x0001
0x0008e940 addu r5,r4,r0
0x0008e944 addu r7,r4,r0
0x0008e948 beq r0,r0,0x0008e994
0x0008e94c add r6,r3,r4
0x0008e950 addu r3,r5,r16
0x0008e954 lb r3,0x0008(r3)
0x0008e958 addiu r1,r0,0x0007
0x0008e95c addi r3,r3,0x000d
0x0008e960 sub r4,r3,r2
0x0008e964 addiu r3,r0,0x000d
0x0008e968 div r4,r3
0x0008e96c lui r3,0x8009
0x0008e970 addiu r3,r3,0xf1ac
0x0008e974 mfhi r4
0x0008e978 addu r3,r3,r6
0x0008e97c addu r3,r4,r3
0x0008e980 lb r3,0x0000(r3)
0x0008e984 nop
0x0008e988 beq r3,r1,0x0008e9a0
0x0008e98c nop
0x0008e990 addi r2,r2,0x0001
0x0008e994 slti r1,r2,0x0003
0x0008e998 bne r1,r0,0x0008e950
0x0008e99c nop
0x0008e9a0 addiu r1,r0,0x0003
0x0008e9a4 bne r2,r1,0x0008e9c0
0x0008e9a8 nop
0x0008e9ac addu r3,r7,r16
0x0008e9b0 sb r0,0x000e(r3)
0x0008e9b4 addiu r2,r0,0xffff
0x0008e9b8 beq r0,r0,0x0008ed50
0x0008e9bc sb r2,0x000b(r3)
0x0008e9c0 addi r2,r2,-0x0001
0x0008e9c4 addu r3,r7,r16
0x0008e9c8 sb r2,0x000e(r3)
0x0008e9cc addiu r2,r0,0x0007
0x0008e9d0 beq r0,r0,0x0008ed50
0x0008e9d4 sb r2,0x000b(r3)
0x0008e9d8 lb r2,0x0022(r16)
0x0008e9dc addiu r1,r0,0x0002
0x0008e9e0 beq r2,r1,0x0008eb04
0x0008e9e4 nop
0x0008e9e8 addiu r1,r0,0x0001
0x0008e9ec beq r2,r1,0x0008ea44
0x0008e9f0 nop
0x0008e9f4 bne r2,r0,0x0008ed50
0x0008e9f8 nop
0x0008e9fc addu r6,r4,r16
0x0008ea00 lb r2,0x0008(r6)
0x0008ea04 nop
0x0008ea08 addi r3,r2,0x000c
0x0008ea0c addiu r2,r0,0x000d
0x0008ea10 div r3,r2
0x0008ea14 sll r2,r4,0x01
0x0008ea18 add r2,r2,r4
0x0008ea1c sll r2,r2,0x02
0x0008ea20 add r3,r2,r4
0x0008ea24 lui r2,0x8009
0x0008ea28 addiu r2,r2,0xf1ac
0x0008ea2c mfhi r5
0x0008ea30 addu r2,r2,r3
0x0008ea34 addu r2,r5,r2
0x0008ea38 lb r2,0x0000(r2)
0x0008ea3c beq r0,r0,0x0008ed50
0x0008ea40 sb r2,0x000b(r6)
0x0008ea44 lb r2,0x000b(r16)
0x0008ea48 addiu r1,r0,0x0007
0x0008ea4c beq r2,r1,0x0008e8c0
0x0008ea50 addu r3,r2,r0
0x0008ea54 sll r5,r4,0x01
0x0008ea58 add r5,r5,r4
0x0008ea5c sll r5,r5,0x02
0x0008ea60 addiu r2,r0,0x0001
0x0008ea64 addu r6,r4,r0
0x0008ea68 addu r8,r4,r0
0x0008ea6c beq r0,r0,0x0008eab8
0x0008ea70 add r7,r5,r4
0x0008ea74 addu r4,r6,r16
0x0008ea78 lb r4,0x0008(r4)
0x0008ea7c nop
0x0008ea80 addi r4,r4,0x000d
0x0008ea84 sub r5,r4,r2
0x0008ea88 addiu r4,r0,0x000d
0x0008ea8c div r5,r4
0x0008ea90 lui r4,0x8009
0x0008ea94 addiu r4,r4,0xf1ac
0x0008ea98 mfhi r5
0x0008ea9c addu r4,r4,r7
0x0008eaa0 addu r4,r5,r4
0x0008eaa4 lb r4,0x0000(r4)
0x0008eaa8 nop
0x0008eaac beq r3,r4,0x0008eac4
0x0008eab0 nop
0x0008eab4 addi r2,r2,0x0001
0x0008eab8 slti r1,r2,0x0003
0x0008eabc bne r1,r0,0x0008ea74
0x0008eac0 nop
0x0008eac4 addiu r1,r0,0x0003
0x0008eac8 beq r2,r1,0x0008ead8
0x0008eacc nop
0x0008ead0 bne r2,r0,0x0008eaec
0x0008ead4 nop
0x0008ead8 addu r3,r8,r16
0x0008eadc sb r0,0x000e(r3)
0x0008eae0 addiu r2,r0,0xfffe
0x0008eae4 beq r0,r0,0x0008ed50
0x0008eae8 sb r2,0x000b(r3)
0x0008eaec addi r2,r2,-0x0001
0x0008eaf0 addu r3,r8,r16
0x0008eaf4 sb r2,0x000e(r3)
0x0008eaf8 lb r2,0x000b(r16)
0x0008eafc beq r0,r0,0x0008ed50
0x0008eb00 sb r2,0x000b(r3)
0x0008eb04 lb r2,0x000b(r16)
0x0008eb08 addiu r1,r0,0x0007
0x0008eb0c beq r2,r1,0x0008e930
0x0008eb10 nop
0x0008eb14 addiu r3,r0,0xfffe
0x0008eb18 addu r2,r4,r16
0x0008eb1c beq r0,r0,0x0008ed50
0x0008eb20 sb r3,0x000b(r2)
0x0008eb24 lb r2,0x0022(r16)
0x0008eb28 addiu r1,r0,0x0002
0x0008eb2c beq r2,r1,0x0008ed24
0x0008eb30 nop
0x0008eb34 addiu r1,r0,0x0001
0x0008eb38 beq r2,r1,0x0008ebd8
0x0008eb3c nop
0x0008eb40 bne r2,r0,0x0008ed50
0x0008eb44 nop
0x0008eb48 lb r3,0x000b(r16)
0x0008eb4c lb r2,0x000c(r16)
0x0008eb50 nop
0x0008eb54 bne r3,r2,0x0008ed50
0x0008eb58 addu r5,r3,r0
0x0008eb5c addu r17,r4,r0
0x0008eb60 addu r2,r17,r16
0x0008eb64 lb r2,0x0008(r2)
0x0008eb68 nop
0x0008eb6c addi r3,r2,0x000c
0x0008eb70 addiu r2,r0,0x000d
0x0008eb74 div r3,r2
0x0008eb78 sll r2,r17,0x01
0x0008eb7c add r2,r2,r17
0x0008eb80 sll r2,r2,0x02
0x0008eb84 add r3,r2,r17
0x0008eb88 lui r2,0x8009
0x0008eb8c addiu r2,r2,0xf1ac
0x0008eb90 mfhi r4
0x0008eb94 addu r2,r2,r3
0x0008eb98 addu r2,r4,r2
0x0008eb9c lb r2,0x0000(r2)
0x0008eba0 nop
0x0008eba4 bne r5,r2,0x0008ed50
0x0008eba8 nop
0x0008ebac jal 0x0009127c
0x0008ebb0 nop
0x0008ebb4 bgez r2,0x0008ebc8
0x0008ebb8 andi r3,r2,0x0001
0x0008ebbc beq r3,r0,0x0008ebc8
0x0008ebc0 nop
0x0008ebc4 addiu r3,r3,0xfffe
0x0008ebc8 addi r3,r3,0x0001
0x0008ebcc addu r2,r17,r16
0x0008ebd0 beq r0,r0,0x0008ed50
0x0008ebd4 sb r3,0x000e(r2)
0x0008ebd8 lb r5,0x000b(r16)
0x0008ebdc lb r2,0x000c(r16)
0x0008ebe0 nop
0x0008ebe4 bne r5,r2,0x0008ed50
0x0008ebe8 addu r3,r5,r0
0x0008ebec addiu r1,r0,0x0007
0x0008ebf0 beq r3,r1,0x0008eca8
0x0008ebf4 nop
0x0008ebf8 sll r5,r4,0x01
0x0008ebfc add r5,r5,r4
0x0008ec00 sll r5,r5,0x02
0x0008ec04 addiu r2,r0,0x0001
0x0008ec08 addu r6,r4,r0
0x0008ec0c addu r8,r4,r0
0x0008ec10 beq r0,r0,0x0008ec5c
0x0008ec14 add r7,r5,r4
0x0008ec18 addu r4,r6,r16
0x0008ec1c lb r4,0x0008(r4)
0x0008ec20 nop
0x0008ec24 addi r4,r4,0x000d
0x0008ec28 sub r5,r4,r2
0x0008ec2c addiu r4,r0,0x000d
0x0008ec30 div r5,r4
0x0008ec34 lui r4,0x8009
0x0008ec38 addiu r4,r4,0xf1ac
0x0008ec3c mfhi r5
0x0008ec40 addu r4,r4,r7
0x0008ec44 addu r4,r5,r4
0x0008ec48 lb r4,0x0000(r4)
0x0008ec4c nop
0x0008ec50 beq r3,r4,0x0008ec68
0x0008ec54 nop
0x0008ec58 addi r2,r2,0x0001
0x0008ec5c slti r1,r2,0x0003
0x0008ec60 bne r1,r0,0x0008ec18
0x0008ec64 nop
0x0008ec68 addiu r1,r0,0x0003
0x0008ec6c beq r2,r1,0x0008ec7c
0x0008ec70 nop
0x0008ec74 bne r2,r0,0x0008ec90
0x0008ec78 nop
0x0008ec7c addu r3,r8,r16
0x0008ec80 sb r0,0x000e(r3)
0x0008ec84 addiu r2,r0,0xfffe
0x0008ec88 beq r0,r0,0x0008ed50
0x0008ec8c sb r2,0x000b(r3)
0x0008ec90 addi r2,r2,-0x0001
0x0008ec94 addu r3,r8,r16
0x0008ec98 sb r2,0x000e(r3)
0x0008ec9c lb r2,0x000b(r16)
0x0008eca0 beq r0,r0,0x0008ed50
0x0008eca4 sb r2,0x000b(r3)
0x0008eca8 addu r17,r4,r0
0x0008ecac addu r2,r17,r16
0x0008ecb0 lb r2,0x0008(r2)
0x0008ecb4 addiu r1,r0,0x0007
0x0008ecb8 addi r3,r2,0x000c
0x0008ecbc addiu r2,r0,0x000d
0x0008ecc0 div r3,r2
0x0008ecc4 sll r2,r17,0x01
0x0008ecc8 add r2,r2,r17
0x0008eccc sll r2,r2,0x02
0x0008ecd0 add r3,r2,r17
0x0008ecd4 lui r2,0x8009
0x0008ecd8 addiu r2,r2,0xf1ac
0x0008ecdc mfhi r4
0x0008ece0 addu r2,r2,r3
0x0008ece4 addu r2,r4,r2
0x0008ece8 lb r2,0x0000(r2)
0x0008ecec nop
0x0008ecf0 bne r2,r1,0x0008ed50
0x0008ecf4 nop
0x0008ecf8 jal 0x0009127c
0x0008ecfc nop
0x0008ed00 bgez r2,0x0008ed14
0x0008ed04 andi r3,r2,0x0001
0x0008ed08 beq r3,r0,0x0008ed14
0x0008ed0c nop
0x0008ed10 addiu r3,r3,0xfffe
0x0008ed14 addi r3,r3,0x0001
0x0008ed18 addu r2,r17,r16
0x0008ed1c beq r0,r0,0x0008ed50
0x0008ed20 sb r3,0x000e(r2)
0x0008ed24 lb r2,0x000b(r16)
0x0008ed28 addiu r1,r0,0x0007
0x0008ed2c bne r2,r1,0x0008ed44
0x0008ed30 nop
0x0008ed34 lb r2,0x000c(r16)
0x0008ed38 addiu r1,r0,0x0007
0x0008ed3c beq r2,r1,0x0008e930
0x0008ed40 nop
0x0008ed44 addiu r3,r0,0xfffd
0x0008ed48 addu r2,r4,r16
0x0008ed4c sb r3,0x000b(r2)
0x0008ed50 lw r31,0x0018(r29)
0x0008ed54 lw r17,0x0014(r29)
0x0008ed58 lw r16,0x0010(r29)
0x0008ed5c jr r31
0x0008ed60 addiu r29,r29,0x0020