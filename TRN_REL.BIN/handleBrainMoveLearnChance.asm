int handleBrainMoveLearnChance(digimonType) {
  specArray = byte[3]
  
  for(specId = 0; specId < 3; specId++) {
    specArray[specId] = load(0x12CED2 + digimonType * 52 + specId)
  }
  
  moveArray = { -1, -1, -1 }
  chanceArray = { -1, -1, -1 }
  
  for(i = 0; i < 3; i++) {
    spec = specArray[i]
    if(spec == -1)
      continue
    
    for(j = 0; j < 8; j++) {
      moveId = load(0x8F14C + spec * 8 + j)
      if(hasMove(moveId) == 1)
        continue
      
      partnerType = load(0x1557A8) // loaded in this function, ignores digimonType parameter
      moveChance = load(0x8F184 + j * 3 + i)
      
      for(k = 0; k < 0x10; k++) {
        if(moveId != load(0x12CED7 + partnerType * 52 + k)) // can learn move
          continue
        
        moveArray[i] = moveId
        chanceArray[i] = moveChance
      }
      
      if(moveArray[i] != -1 || chanceArray[i] != -1)
        break
    }
  }
  
  bestMove = moveArray[0]
  bestChance = chanceArray[0]
  
  if(bestChance < chanceArray[1]) {
    bestChance = chanceArray[1]
    bestMove = moveArray[1]
  }
  
  if(bestChance < chanceArray[2]) {
    bestChance = chanceArray[2]
    bestMove = moveArray[2]
  }
  
  if(random(100) >= bestChance)
    return 0
    
  learnMove(bestMove)
  
  moveName = load(0x126054 + bestMove * 4)
  renderString(moveName, 0, 0x78)
  
  moveNameLength = strlen(moveName)
  store(0x135392, moveNameLength)
  
  renderString(0x8F19C, 0, 0x84) // render "was mastered!"
  
  // parameters 4-7 passed via sp+0x10 to sp+0x1C
  0x000B8E50(2, -88, 18, 176, 0x23, 0x02, 0, 0x8A9F8)
  store(0x135388, 1)
  
  return 1
}

0x0008a744 addiu r29,r29,0xffb8
0x0008a748 sw r31,0x0030(r29)
0x0008a74c sll r2,r4,0x01
0x0008a750 sw r19,0x002c(r29)
0x0008a754 add r2,r2,r4
0x0008a758 sw r18,0x0028(r29)
0x0008a75c sll r2,r2,0x02
0x0008a760 sw r17,0x0024(r29)
0x0008a764 add r2,r2,r4
0x0008a768 sw r16,0x0020(r29)
0x0008a76c addu r5,r0,r0
0x0008a770 beq r0,r0,0x0008a798
0x0008a774 sll r4,r2,0x02
0x0008a778 lui r2,0x8013
0x0008a77c addiu r2,r2,0xced2
0x0008a780 addu r2,r2,r4
0x0008a784 addu r2,r5,r2
0x0008a788 lbu r3,0x0000(r2)
0x0008a78c addu r2,r29,r5
0x0008a790 sb r3,0x003c(r2)
0x0008a794 addi r5,r5,0x0001
0x0008a798 slti r1,r5,0x0003
0x0008a79c bne r1,r0,0x0008a778
0x0008a7a0 nop
0x0008a7a4 addiu r2,r0,0xffff
0x0008a7a8 sb r2,0x0042(r29)
0x0008a7ac sb r2,0x0046(r29)
0x0008a7b0 sb r2,0x0041(r29)
0x0008a7b4 sb r2,0x0045(r29)
0x0008a7b8 sb r2,0x0040(r29)
0x0008a7bc sb r2,0x0044(r29)
0x0008a7c0 beq r0,r0,0x0008a8dc
0x0008a7c4 addu r16,r0,r0
0x0008a7c8 addu r3,r29,r16
0x0008a7cc lbu r2,0x003c(r3)
0x0008a7d0 addiu r1,r0,0x00ff
0x0008a7d4 beq r2,r1,0x0008a8d8
0x0008a7d8 nop
0x0008a7dc sll r2,r2,0x03
0x0008a7e0 addu r19,r0,r0
0x0008a7e4 add r17,r0,r2
0x0008a7e8 beq r0,r0,0x0008a8cc
0x0008a7ec addu r18,r0,r0
0x0008a7f0 lui r2,0x8009
0x0008a7f4 addiu r2,r2,0xf14c
0x0008a7f8 addu r2,r2,r17
0x0008a7fc lbu r4,0x0000(r2)
0x0008a800 jal 0x000e5eb4
0x0008a804 nop
0x0008a808 addiu r1,r0,0x0001
0x0008a80c beq r2,r1,0x0008a8c0
0x0008a810 nop
0x0008a814 lui r1,0x8015
0x0008a818 lw r4,0x57a8(r1)
0x0008a81c nop
0x0008a820 sll r3,r4,0x01
0x0008a824 add r3,r3,r4
0x0008a828 sll r3,r3,0x02
0x0008a82c add r3,r3,r4
0x0008a830 sll r4,r3,0x02
0x0008a834 lui r3,0x8009
0x0008a838 addiu r3,r3,0xf14c
0x0008a83c addu r3,r3,r17
0x0008a840 lbu r5,0x0000(r3)
0x0008a844 lui r3,0x8009
0x0008a848 addiu r3,r3,0xf184
0x0008a84c addu r3,r3,r18
0x0008a850 addu r3,r16,r3
0x0008a854 lb r6,0x0000(r3)
0x0008a858 beq r0,r0,0x0008a890
0x0008a85c addu r2,r0,r0
0x0008a860 lui r3,0x8013
0x0008a864 addiu r3,r3,0xced7
0x0008a868 addu r3,r3,r4
0x0008a86c addu r3,r2,r3
0x0008a870 lbu r3,0x0000(r3)
0x0008a874 nop
0x0008a878 bne r5,r3,0x0008a88c
0x0008a87c nop
0x0008a880 addu r3,r29,r16
0x0008a884 sb r5,0x0040(r3)
0x0008a888 sb r6,0x0044(r3)
0x0008a88c addi r2,r2,0x0001
0x0008a890 slti r1,r2,0x0010
0x0008a894 bne r1,r0,0x0008a860
0x0008a898 nop
0x0008a89c addu r3,r29,r16
0x0008a8a0 lb r2,0x0040(r3)
0x0008a8a4 addiu r1,r0,0xffff
0x0008a8a8 beq r2,r1,0x0008a8c0
0x0008a8ac nop
0x0008a8b0 lb r2,0x0044(r3)
0x0008a8b4 addiu r1,r0,0xffff
0x0008a8b8 bne r2,r1,0x0008a8d8
0x0008a8bc nop
0x0008a8c0 addi r19,r19,0x0001
0x0008a8c4 addi r18,r18,0x0003
0x0008a8c8 addi r17,r17,0x0001
0x0008a8cc slti r1,r19,0x0008
0x0008a8d0 bne r1,r0,0x0008a7f0
0x0008a8d4 nop
0x0008a8d8 addi r16,r16,0x0001
0x0008a8dc slti r1,r16,0x0003
0x0008a8e0 bne r1,r0,0x0008a7c8
0x0008a8e4 nop
0x0008a8e8 lb r3,0x0044(r29)
0x0008a8ec lb r2,0x0045(r29)
0x0008a8f0 lb r17,0x0040(r29)
0x0008a8f4 addu r16,r3,r0
0x0008a8f8 slt r1,r3,r2
0x0008a8fc beq r1,r0,0x0008a910
0x0008a900 addu r4,r2,r0
0x0008a904 sll r16,r4,0x18
0x0008a908 lb r17,0x0041(r29)
0x0008a90c sra r16,r16,0x18
0x0008a910 lb r2,0x0046(r29)
0x0008a914 nop
0x0008a918 slt r1,r16,r2
0x0008a91c beq r1,r0,0x0008a930
0x0008a920 addu r3,r2,r0
0x0008a924 sll r16,r3,0x18
0x0008a928 lb r17,0x0042(r29)
0x0008a92c sra r16,r16,0x18
0x0008a930 jal 0x000a36d4
0x0008a934 addiu r4,r0,0x0064
0x0008a938 slt r1,r2,r16
0x0008a93c beq r1,r0,0x0008a9dc
0x0008a940 addu r2,r0,r0
0x0008a944 jal 0x000e5f14
0x0008a948 addu r4,r17,r0
0x0008a94c lui r2,0x8012
0x0008a950 sll r3,r17,0x02
0x0008a954 addiu r2,r2,0x6054
0x0008a958 addu r2,r2,r3
0x0008a95c lw r4,0x0000(r2)
0x0008a960 addu r16,r3,r0
0x0008a964 addu r5,r0,r0
0x0008a968 jal 0x0010cf24
0x0008a96c addiu r6,r0,0x0078
0x0008a970 lui r2,0x8012
0x0008a974 addiu r2,r2,0x6054
0x0008a978 addu r2,r2,r16
0x0008a97c lw r4,0x0000(r2)
0x0008a980 jal 0x0009121c
0x0008a984 nop
0x0008a988 lui r4,0x8009
0x0008a98c sb r2,-0x679a(r28)
0x0008a990 addiu r4,r4,0xf19c
0x0008a994 addu r5,r0,r0
0x0008a998 jal 0x0010cf24
0x0008a99c addiu r6,r0,0x0084
0x0008a9a0 addiu r2,r0,0x0023
0x0008a9a4 sw r2,0x0010(r29)
0x0008a9a8 addiu r4,r0,0x0002
0x0008a9ac sw r4,0x0014(r29)
0x0008a9b0 lui r2,0x8009
0x0008a9b4 sw r0,0x0018(r29)
0x0008a9b8 addiu r2,r2,0xa9f8
0x0008a9bc sw r2,0x001c(r29)
0x0008a9c0 addiu r5,r0,0xffa8
0x0008a9c4 addiu r6,r0,0x0012
0x0008a9c8 jal 0x000b8e50
0x0008a9cc addiu r7,r0,0x00b0
0x0008a9d0 addiu r2,r0,0x0001
0x0008a9d4 beq r0,r0,0x0008a9dc
0x0008a9d8 sw r2,-0x67a4(r28)
0x0008a9dc lw r31,0x0030(r29)
0x0008a9e0 lw r19,0x002c(r29)
0x0008a9e4 lw r18,0x0028(r29)
0x0008a9e8 lw r17,0x0024(r29)
0x0008a9ec lw r16,0x0020(r29)
0x0008a9f0 jr r31
0x0008a9f4 addiu r29,r29,0x0048