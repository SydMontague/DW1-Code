0x00058874() {
  unknownTimer = load(0x134D80)
  
  if(unknownTimer > 0)
    store(0x134D80, unknownTimer - 1)
  
  combatHead = load(0x134D4C) // combat head
  
  for(combatId = 0; combatId < load(0x134D6C); combatId++) {
    combatPtr = combatHead + combatId * 0x168
    entityPtr = load(0x12F344 + load(combatHead + 0x66C + combatId) * 4)
    
    addFinisherValue(combatPtr, 1)
    
    targetId = load(combatPtr + 0x37)
    enemyPtr = 0
    
    if(targetId != -1) {
      enemyPtr = load(0x12F344 + load(combatHead + 0x66C + targetId) * 4)
    
    statusFlag = load(combatPtr + 0x34)
    
    if(statusFlag & 0x0020 != 0) // is attacking
      0x00059508(entityPtr, enemyPtr, combatId)
    else if(statusFlag & 0x0010 != 0 || statusFlag & 0x0080 != 0) // is knocked back or blocking
      0x00059608(entityPtr, combatPtr, combatId)
    else if(load(combatPtr + 0x36) == -1) // move range
      continue
    else if(statusFlag & 0x0008 != 0) // is flattened
      0x00059680(entityPtr, combatPtr, combatId)
    else if(statusFlag & 0x0004 != 0) // is stunned
      0x00059714(entityPtr)
    else if(statusFlag & 0x0002 != 0) // is confused
      0x0005975C(entityPtr, enemyPtr, combatPtr, combatId)
    else if(statusFlag & 0x2000 != 0) // is stupid
      0x00059978(entityPtr, combatPtr)
    else if(statusFlag & 0x0800 != 0) // is on chargeup
      0x000599DC(entityPtr, enemyPtr, combatPtr)
    else if(statusFlag & 0x1000 != 0) // is on cooldown
      0x00059C1C(entityPtr, enemyPtr, combatPtr)
    else
      0x00059CF0(entityPtr, enemyPtr, combatPtr, combatId)
  }
  
  0x0005C798()
  0x0005E674()
}

0x00058874 addiu r29,r29,0xffd8
0x00058878 sw r31,0x0020(r29)
0x0005887c sw r19,0x001c(r29)
0x00058880 sw r18,0x0018(r29)
0x00058884 sw r17,0x0014(r29)
0x00058888 lw r2,-0x6dac(r28)
0x0005888c nop
0x00058890 blez r2,0x000588a0
0x00058894 sw r16,0x0010(r29)
0x00058898 addi r2,r2,-0x0001
0x0005889c sw r2,-0x6dac(r28)
0x000588a0 lw r2,-0x6de0(r28)
0x000588a4 addu r18,r0,r0
0x000588a8 beq r0,r0,0x00058a64
0x000588ac addu r16,r2,r0
0x000588b0 lw r2,-0x6de0(r28)
0x000588b4 addiu r19,r16,0x0034
0x000588b8 addu r2,r18,r2
0x000588bc lbu r2,0x066c(r2)
0x000588c0 addu r4,r16,r0
0x000588c4 sll r3,r2,0x02
0x000588c8 lui r2,0x8013
0x000588cc addiu r2,r2,0xf344
0x000588d0 addu r2,r2,r3
0x000588d4 lw r17,0x0000(r2)
0x000588d8 jal 0x0005dfc8
0x000588dc addiu r5,r0,0x0001
0x000588e0 lbu r3,0x0037(r16)
0x000588e4 addiu r1,r0,0x00ff
0x000588e8 beq r3,r1,0x00058920
0x000588ec addu r5,r0,r0
0x000588f0 lw r2,-0x6de0(r28)
0x000588f4 nop
0x000588f8 addu r2,r3,r2
0x000588fc lbu r2,0x066c(r2)
0x00058900 nop
0x00058904 sll r3,r2,0x02
0x00058908 lui r2,0x8013
0x0005890c addiu r2,r2,0xf344
0x00058910 addu r2,r2,r3
0x00058914 lw r5,0x0000(r2)
0x00058918 beq r0,r0,0x00058924
0x0005891c lhu r2,0x0000(r19)
0x00058920 lhu r2,0x0000(r19)
0x00058924 nop
0x00058928 addu r3,r2,r0
0x0005892c andi r2,r2,0x0020
0x00058930 beq r2,r0,0x0005894c
0x00058934 nop
0x00058938 addu r4,r17,r0
0x0005893c jal 0x00059508
0x00058940 addu r6,r18,r0
0x00058944 beq r0,r0,0x00058a60
0x00058948 addi r18,r18,0x0001
0x0005894c andi r2,r3,0x0010
0x00058950 bne r2,r0,0x00058964
0x00058954 nop
0x00058958 andi r2,r3,0x0080
0x0005895c beq r2,r0,0x0005897c
0x00058960 nop
0x00058964 addu r4,r17,r0
0x00058968 addu r5,r16,r0
0x0005896c jal 0x00059608
0x00058970 addu r6,r18,r0
0x00058974 beq r0,r0,0x00058a60
0x00058978 addi r18,r18,0x0001
0x0005897c lb r2,0x0036(r16)
0x00058980 addiu r1,r0,0xffff
0x00058984 beq r2,r1,0x00058a5c
0x00058988 nop
0x0005898c andi r2,r3,0x0008
0x00058990 beq r2,r0,0x000589b0
0x00058994 nop
0x00058998 addu r4,r17,r0
0x0005899c addu r6,r16,r0
0x000589a0 jal 0x00059680
0x000589a4 addu r7,r18,r0
0x000589a8 beq r0,r0,0x00058a60
0x000589ac addi r18,r18,0x0001
0x000589b0 andi r2,r3,0x0004
0x000589b4 beq r2,r0,0x000589cc
0x000589b8 nop
0x000589bc jal 0x00059714
0x000589c0 addu r4,r17,r0
0x000589c4 beq r0,r0,0x00058a60
0x000589c8 addi r18,r18,0x0001
0x000589cc andi r2,r3,0x0002
0x000589d0 beq r2,r0,0x000589f0
0x000589d4 nop
0x000589d8 addu r4,r17,r0
0x000589dc addu r6,r16,r0
0x000589e0 jal 0x0005975c
0x000589e4 addu r7,r18,r0
0x000589e8 beq r0,r0,0x00058a60
0x000589ec addi r18,r18,0x0001
0x000589f0 andi r2,r3,0x2000
0x000589f4 beq r2,r0,0x00058a10
0x000589f8 nop
0x000589fc addu r4,r17,r0
0x00058a00 jal 0x00059978
0x00058a04 addu r5,r16,r0
0x00058a08 beq r0,r0,0x00058a60
0x00058a0c addi r18,r18,0x0001
0x00058a10 andi r2,r3,0x0800
0x00058a14 beq r2,r0,0x00058a30
0x00058a18 nop
0x00058a1c addu r4,r17,r0
0x00058a20 jal 0x000599dc
0x00058a24 addu r6,r16,r0
0x00058a28 beq r0,r0,0x00058a60
0x00058a2c addi r18,r18,0x0001
0x00058a30 andi r2,r3,0x1000
0x00058a34 beq r2,r0,0x00058a50
0x00058a38 addu r4,r17,r0
0x00058a3c addu r4,r17,r0
0x00058a40 jal 0x00059c1c
0x00058a44 addu r6,r16,r0
0x00058a48 beq r0,r0,0x00058a60
0x00058a4c addi r18,r18,0x0001
0x00058a50 addu r6,r16,r0
0x00058a54 jal 0x00059cf0
0x00058a58 addu r7,r18,r0
0x00058a5c addi r18,r18,0x0001
0x00058a60 addi r16,r16,0x0168
0x00058a64 lh r2,-0x6dc0(r28)
0x00058a68 nop
0x00058a6c slt r1,r2,r18
0x00058a70 beq r1,r0,0x000588b0
0x00058a74 nop
0x00058a78 jal 0x0005c798
0x00058a7c nop
0x00058a80 jal 0x0005e674
0x00058a84 nop
0x00058a88 lw r31,0x0020(r29)
0x00058a8c lw r19,0x001c(r29)
0x00058a90 lw r18,0x0018(r29)
0x00058a94 lw r17,0x0014(r29)
0x00058a98 lw r16,0x0010(r29)
0x00058a9c jr r31
0x00058aa0 addiu r29,r29,0x0028