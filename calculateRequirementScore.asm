int calculateRequirementScore(digimonType, targetType, isMaxCM, isMaxBattles, bestDigimonType) {
  requirementPtr = 0x12ABEC + targetType * 28
  statsPtr = 0x1557E0
  conditionPtr = 0x138460
  
  reqPoints = 0
  
  // care mistake requirement
  numCM = load(conditionPtr + 0x52)
  reqCM = load(requirementPtr + 0x0E)
    
  if(isMaxCM == 0)
    if(numCM >= reqCM)
      reqPoints++
  else if(reqCM >= numCM)
    reqPoints++
  
  // weight requirement
  reqWeight = load(requirementPtr + 0x10)
  weight = load(conditionPtr + 0x42)
  
  if(weight >= reqWeight - 5 && weight <= reqWeight + 5)
    reqPoints++
  
  // stat requirement
  if(load(0x12CED1 + targetType * 52) == 3) { // Target is Rookie Digimon
    statArray1 = int[6]
    statArray2 = int[6]
    reqArray = int[6]
    
    statArray1[0] = statArray2[0] = load(statsPtr + 0x10) / 10 // hp
    statArray1[1] = statArray2[1] = load(statsPtr + 0x12) / 10 // mp
    statArray1[2] = statArray2[2] = load(statsPtr + 0x00)      // off
    statArray1[3] = statArray2[3] = load(statsPtr + 0x02)      // def
    statArray1[4] = statArray2[4] = load(statsPtr + 0x04)      // speed
    statArray1[5] = statArray2[5] = load(statsPtr + 0x06)      // brains
    
    reqArray[0] = load(requirementPtr + 0x02) // hp
    reqArray[1] = load(requirementPtr + 0x04) // mp
    reqArray[2] = load(requirementPtr + 0x06) // off
    reqArray[3] = load(requirementPtr + 0x08) // def
    reqArray[4] = load(requirementPtr + 0x0A) // speed
    reqArray[5] = load(requirementPtr + 0x0C) // brains
    
    for(i = 0; i < 6; i++) {
      isHighest = 1
      
      for(j = 0; j < 6; j++)
        if(statArray1[i] < statArray1[j])
          isHighest = 0
    
      if(isHighest == 1)
        highestStat = i
    }
    
    if(reqArray[highestStat] == 1)
      reqPoints++
  }
  else { // Target is non-Rookie Digimon
    hp = load(statsPtr + 0x10) / 10
    mp = load(statsPtr + 0x12) / 10
    off = load(statsPtr + 0x00)
    def = load(statsPtr + 0x02)
    speed = load(statsPtr + 0x04)
    brains = load(statsPtr + 0x06)
    
    hpReq = load(requirementPtr + 0x02)
    mpReq = load(requirementPtr + 0x04)
    offReq = load(requirementPtr + 0x06)
    defReq = load(requirementPtr + 0x08)
    speedReq = load(requirementPtr + 0x0A)
    brainsReq = load(requirementPtr + 0x0C)
    
    if(hp >= hpReq && mp >= mpReq
    && off >= offReq && def >= defReq
    && speed >= speedReq && brains >= brainsReq)
      reqPoints++
  }
  
  // bonus requirements
  bonusPoints = 0
  bonusDigimon = load(requirementPtr + 0x00)
  bonusHappiness = load(requirementPtr + 0x12)
  bonusDiscipline = load(requirementPtr + 0x14)
  bonusBattles = load(requirementPtr + 0x16)
  bonusTechs = load(requirementPtr + 0x18)
  
  // bonus digimon
  if(bonusDigimon != -1 && bonusDigimon == digimonType)
    bonusPoints = 1
  
  // bonus discipline
  if(bonusDiscipline != -1 && load(conditionPtr + 0x28) >= bonusDiscipline)
    bonusPoints = 1
    
  // bonus happiness
  if(bonusHappiness != -1 && load(conditionPtr + 0x2A) >= bonusHappiness)
    bonusPoints = 1
  
  // bonus battles
  if(bonusBattles != -1) {
    if(isMaxBattles == 0) {
      if(load(conditionPtr + 0x54) >= bonusBattles)
        bonusPoints = 1
    }
    else {
      if(load(conditionPtr + 0x54) <= bonusBattles)
        bonusPoints = 1
    }
  }
   // bonus techs
  if(bonusTechs != -1 && getNumMasteredMoves() >= bonusTechs)
    bonusPoints = 1
  
  reqPoints = reqPoints + bonusPoints
  
  if(reqPoints < 3 || bestDigimonType == -1)
    return reqPoints
  
  // disable Digimon is you had it before, but not the current best Digimon
  raisedTarget = hasDigimonRaised(load(0x12B2DC + targetType * 14))
  raisedBest = hasDigimonRaised(load(0x12B2DC + bestDigimonType * 14))
  
  if(raisedTarget == 1 && raisedBest == 0)
    reqPoints = 0
  
  if(raisedTarget == 0 && raisedBest == 1)
    reqPoints++
  
  return reqPoints
}

0x000e26b8 addiu r29,r29,0xffb0
0x000e26bc sw r31,0x0024(r29)
0x000e26c0 sw r20,0x0020(r29)
0x000e26c4 sw r19,0x001c(r29)
0x000e26c8 sll r3,r5,0x03
0x000e26cc sw r18,0x0018(r29)
0x000e26d0 sw r17,0x0014(r29)
0x000e26d4 sw r16,0x0010(r29)
0x000e26d8 addu r19,r5,r0
0x000e26dc sub r3,r3,r5
0x000e26e0 sll r5,r3,0x02
0x000e26e4 lui r3,0x8013
0x000e26e8 addiu r3,r3,0xabec
0x000e26ec addu r17,r3,r5
0x000e26f0 lui r5,0x8015
0x000e26f4 lui r3,0x8014
0x000e26f8 lb r20,0x0060(r29)
0x000e26fc addiu r5,r5,0x57e0
0x000e2700 addiu r3,r3,0x8460
0x000e2704 bne r6,r0,0x000e2734
0x000e2708 addu r16,r0,r0
0x000e270c lh r8,0x0052(r3)
0x000e2710 lh r6,0x000e(r17)
0x000e2714 nop
0x000e2718 slt r1,r8,r6
0x000e271c bne r1,r0,0x000e2758
0x000e2720 nop
0x000e2724 addi r6,r16,0x0001
0x000e2728 sll r16,r6,0x18
0x000e272c beq r0,r0,0x000e2758
0x000e2730 sra r16,r16,0x18
0x000e2734 lh r8,0x0052(r3)
0x000e2738 lh r6,0x000e(r17)
0x000e273c nop
0x000e2740 slt r1,r6,r8
0x000e2744 bne r1,r0,0x000e2758
0x000e2748 nop
0x000e274c addi r6,r16,0x0001
0x000e2750 sll r16,r6,0x18
0x000e2754 sra r16,r16,0x18
0x000e2758 lh r8,0x0010(r17)
0x000e275c lh r6,0x0042(r3)
0x000e2760 addu r9,r8,r0
0x000e2764 addi r8,r8,-0x0005
0x000e2768 slt r1,r6,r8
0x000e276c bne r1,r0,0x000e2790
0x000e2770 addu r10,r6,r0
0x000e2774 addi r6,r9,0x0005
0x000e2778 slt r1,r6,r10
0x000e277c bne r1,r0,0x000e2790
0x000e2780 nop
0x000e2784 addi r6,r16,0x0001
0x000e2788 sll r16,r6,0x18
0x000e278c sra r16,r16,0x18
0x000e2790 sll r6,r19,0x01
0x000e2794 add r6,r6,r19
0x000e2798 sll r6,r6,0x02
0x000e279c add r6,r6,r19
0x000e27a0 sll r8,r6,0x02
0x000e27a4 lui r6,0x8013
0x000e27a8 addiu r6,r6,0xced1
0x000e27ac addu r6,r6,r8
0x000e27b0 lbu r6,0x0000(r6)
0x000e27b4 addiu r1,r0,0x0003
0x000e27b8 bne r6,r1,0x000e2930
0x000e27bc nop
0x000e27c0 lui r6,0x6666
0x000e27c4 lh r8,0x0010(r5)
0x000e27c8 ori r9,r6,0x6667
0x000e27cc mult r9,r8
0x000e27d0 mfhi r6
0x000e27d4 srl r8,r8,0x1f
0x000e27d8 sra r6,r6,0x02
0x000e27dc addu r6,r6,r8
0x000e27e0 sh r6,0x0038(r29)
0x000e27e4 sh r6,0x002c(r29)
0x000e27e8 lh r6,0x0012(r5)
0x000e27ec nop
0x000e27f0 mult r9,r6
0x000e27f4 srl r8,r6,0x1f
0x000e27f8 mfhi r6
0x000e27fc sra r6,r6,0x02
0x000e2800 addu r6,r6,r8
0x000e2804 sh r6,0x003a(r29)
0x000e2808 sh r6,0x002e(r29)
0x000e280c lh r6,0x0000(r5)
0x000e2810 addu r8,r0,r0
0x000e2814 sh r6,0x003c(r29)
0x000e2818 sh r6,0x0030(r29)
0x000e281c lh r6,0x0002(r5)
0x000e2820 nop
0x000e2824 sh r6,0x003e(r29)
0x000e2828 sh r6,0x0032(r29)
0x000e282c lh r6,0x0004(r5)
0x000e2830 nop
0x000e2834 sh r6,0x0040(r29)
0x000e2838 sh r6,0x0034(r29)
0x000e283c lh r5,0x0006(r5)
0x000e2840 nop
0x000e2844 sh r5,0x0042(r29)
0x000e2848 sh r5,0x0036(r29)
0x000e284c lh r5,0x0002(r17)
0x000e2850 nop
0x000e2854 sh r5,0x0044(r29)
0x000e2858 lh r5,0x0004(r17)
0x000e285c nop
0x000e2860 sh r5,0x0046(r29)
0x000e2864 lh r5,0x0006(r17)
0x000e2868 nop
0x000e286c sh r5,0x0048(r29)
0x000e2870 lh r5,0x0008(r17)
0x000e2874 nop
0x000e2878 sh r5,0x004a(r29)
0x000e287c lh r5,0x000a(r17)
0x000e2880 nop
0x000e2884 sh r5,0x004c(r29)
0x000e2888 lh r5,0x000c(r17)
0x000e288c nop
0x000e2890 sh r5,0x004e(r29)
0x000e2894 beq r0,r0,0x000e28fc
0x000e2898 addu r5,r0,r0
0x000e289c addu r6,r29,r5
0x000e28a0 lh r12,0x002c(r6)
0x000e28a4 addiu r10,r0,0x0001
0x000e28a8 addu r9,r0,r0
0x000e28ac beq r0,r0,0x000e28d8
0x000e28b0 addu r11,r0,r0
0x000e28b4 addu r6,r29,r11
0x000e28b8 lh r6,0x002c(r6)
0x000e28bc nop
0x000e28c0 slt r1,r12,r6
0x000e28c4 beq r1,r0,0x000e28d0
0x000e28c8 nop
0x000e28cc addu r10,r0,r0
0x000e28d0 addi r9,r9,0x0001
0x000e28d4 addi r11,r11,0x0002
0x000e28d8 slti r1,r9,0x0006
0x000e28dc bne r1,r0,0x000e28b4
0x000e28e0 nop
0x000e28e4 addiu r1,r0,0x0001
0x000e28e8 bne r10,r1,0x000e28f4
0x000e28ec nop
0x000e28f0 addu r2,r8,r0
0x000e28f4 addi r8,r8,0x0001
0x000e28f8 addi r5,r5,0x0002
0x000e28fc slti r1,r8,0x0006
0x000e2900 bne r1,r0,0x000e289c
0x000e2904 nop
0x000e2908 sll r2,r2,0x01
0x000e290c addu r2,r29,r2
0x000e2910 lh r2,0x0044(r2)
0x000e2914 addiu r1,r0,0x0001
0x000e2918 bne r2,r1,0x000e29f8
0x000e291c nop
0x000e2920 addi r2,r16,0x0001
0x000e2924 sll r16,r2,0x18
0x000e2928 beq r0,r0,0x000e29f8
0x000e292c sra r16,r16,0x18
0x000e2930 lh r2,0x0010(r5)
0x000e2934 lui r10,0x6666
0x000e2938 ori r9,r10,0x6667
0x000e293c mult r9,r2
0x000e2940 srl r8,r2,0x1f
0x000e2944 mfhi r2
0x000e2948 sra r6,r2,0x02
0x000e294c lh r2,0x0002(r17)
0x000e2950 addu r6,r6,r8
0x000e2954 slt r1,r6,r2
0x000e2958 bne r1,r0,0x000e29f8
0x000e295c nop
0x000e2960 lh r2,0x0012(r5)
0x000e2964 nop
0x000e2968 mult r9,r2
0x000e296c srl r8,r2,0x1f
0x000e2970 mfhi r2
0x000e2974 sra r6,r2,0x02
0x000e2978 lh r2,0x0004(r17)
0x000e297c addu r6,r6,r8
0x000e2980 slt r1,r6,r2
0x000e2984 bne r1,r0,0x000e29f8
0x000e2988 nop
0x000e298c lh r6,0x0000(r5)
0x000e2990 lh r2,0x0006(r17)
0x000e2994 nop
0x000e2998 slt r1,r6,r2
0x000e299c bne r1,r0,0x000e29f8
0x000e29a0 nop
0x000e29a4 lh r6,0x0002(r5)
0x000e29a8 lh r2,0x0008(r17)
0x000e29ac nop
0x000e29b0 slt r1,r6,r2
0x000e29b4 bne r1,r0,0x000e29f8
0x000e29b8 nop
0x000e29bc lh r6,0x0004(r5)
0x000e29c0 lh r2,0x000a(r17)
0x000e29c4 nop
0x000e29c8 slt r1,r6,r2
0x000e29cc bne r1,r0,0x000e29f8
0x000e29d0 nop
0x000e29d4 lh r5,0x0006(r5)
0x000e29d8 lh r2,0x000c(r17)
0x000e29dc nop
0x000e29e0 slt r1,r5,r2
0x000e29e4 bne r1,r0,0x000e29f8
0x000e29e8 nop
0x000e29ec addi r2,r16,0x0001
0x000e29f0 sll r16,r2,0x18
0x000e29f4 sra r16,r16,0x18
0x000e29f8 lh r2,0x0000(r17)
0x000e29fc addu r18,r0,r0
0x000e2a00 addiu r1,r0,0xffff
0x000e2a04 beq r2,r1,0x000e2a18
0x000e2a08 addu r5,r2,r0
0x000e2a0c bne r4,r5,0x000e2a18
0x000e2a10 nop
0x000e2a14 addiu r18,r0,0x0001
0x000e2a18 lh r2,0x0012(r17)
0x000e2a1c addiu r1,r0,0xffff
0x000e2a20 beq r2,r1,0x000e2a40
0x000e2a24 addu r4,r2,r0
0x000e2a28 lh r2,0x0028(r3)
0x000e2a2c nop
0x000e2a30 slt r1,r2,r4
0x000e2a34 bne r1,r0,0x000e2a40
0x000e2a38 nop
0x000e2a3c addiu r18,r0,0x0001
0x000e2a40 lh r2,0x0014(r17)
0x000e2a44 addiu r1,r0,0xffff
0x000e2a48 beq r2,r1,0x000e2a68
0x000e2a4c addu r4,r2,r0
0x000e2a50 lh r2,0x002a(r3)
0x000e2a54 nop
0x000e2a58 slt r1,r2,r4
0x000e2a5c bne r1,r0,0x000e2a68
0x000e2a60 nop
0x000e2a64 addiu r18,r0,0x0001
0x000e2a68 lh r2,0x0016(r17)
0x000e2a6c addiu r1,r0,0xffff
0x000e2a70 beq r2,r1,0x000e2ab4
0x000e2a74 addu r4,r2,r0
0x000e2a78 bne r7,r0,0x000e2a9c
0x000e2a7c nop
0x000e2a80 lh r2,0x0054(r3)
0x000e2a84 nop
0x000e2a88 slt r1,r2,r4
0x000e2a8c bne r1,r0,0x000e2ab4
0x000e2a90 nop
0x000e2a94 beq r0,r0,0x000e2ab4
0x000e2a98 addiu r18,r0,0x0001
0x000e2a9c lh r2,0x0054(r3)
0x000e2aa0 nop
0x000e2aa4 slt r1,r4,r2
0x000e2aa8 bne r1,r0,0x000e2ab4
0x000e2aac nop
0x000e2ab0 addiu r18,r0,0x0001
0x000e2ab4 lh r2,0x0018(r17)
0x000e2ab8 addiu r1,r0,0xffff
0x000e2abc beq r2,r1,0x000e2ae8
0x000e2ac0 nop
0x000e2ac4 jal 0x000e3510
0x000e2ac8 nop
0x000e2acc sll r3,r2,0x18
0x000e2ad0 lh r2,0x0018(r17)
0x000e2ad4 sra r3,r3,0x18
0x000e2ad8 slt r1,r3,r2
0x000e2adc bne r1,r0,0x000e2ae8
0x000e2ae0 nop
0x000e2ae4 addiu r18,r0,0x0001
0x000e2ae8 add r2,r16,r18
0x000e2aec sll r16,r2,0x18
0x000e2af0 sra r16,r16,0x18
0x000e2af4 slti r1,r16,0x0003
0x000e2af8 bne r1,r0,0x000e2b90
0x000e2afc nop
0x000e2b00 addiu r1,r0,0xffff
0x000e2b04 beq r20,r1,0x000e2b90
0x000e2b08 nop
0x000e2b0c sll r2,r19,0x03
0x000e2b10 sub r2,r2,r19
0x000e2b14 sll r3,r2,0x01
0x000e2b18 lui r2,0x8013
0x000e2b1c addiu r2,r2,0xb2d0
0x000e2b20 addu r2,r2,r3
0x000e2b24 lh r4,0x000c(r2)
0x000e2b28 jal 0x000ff824
0x000e2b2c nop
0x000e2b30 addu r17,r2,r0
0x000e2b34 sll r2,r20,0x03
0x000e2b38 sub r2,r2,r20
0x000e2b3c sll r3,r2,0x01
0x000e2b40 lui r2,0x8013
0x000e2b44 addiu r2,r2,0xb2d0
0x000e2b48 addu r2,r2,r3
0x000e2b4c lh r4,0x000c(r2)
0x000e2b50 jal 0x000ff824
0x000e2b54 nop
0x000e2b58 addiu r1,r0,0x0001
0x000e2b5c bne r17,r1,0x000e2b70
0x000e2b60 nop
0x000e2b64 bne r2,r0,0x000e2b70
0x000e2b68 nop
0x000e2b6c addu r16,r0,r0
0x000e2b70 bne r17,r0,0x000e2b90
0x000e2b74 nop
0x000e2b78 addiu r1,r0,0x0001
0x000e2b7c bne r2,r1,0x000e2b90
0x000e2b80 nop
0x000e2b84 addi r2,r16,0x0001
0x000e2b88 sll r16,r2,0x18
0x000e2b8c sra r16,r16,0x18
0x000e2b90 addu r2,r16,r0
0x000e2b94 lw r31,0x0024(r29)
0x000e2b98 lw r20,0x0020(r29)
0x000e2b9c lw r19,0x001c(r29)
0x000e2ba0 lw r18,0x0018(r29)
0x000e2ba4 lw r17,0x0014(r29)
0x000e2ba8 lw r16,0x0010(r29)
0x000e2bac jr r31
0x000e2bb0 addiu r29,r29,0x0050