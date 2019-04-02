0x000D4884(playerPtr, partnerPtr, val1, val2) {
  flags = load(partnerPtr + 0x30) & 0x05
  store(partnerPtr + 0x30, flags)
  someFlagValue = 0
  
  if(entityCheckCollision(playerPtr, partnerPtr, val1, val2) == -1)
    return
  
  rotationPtr = load(partnerPtr + 0x04) + 0x72
  initRotation = load(rotationPtr)
  someOffset = initRotation / 512
  
  for(r19 = 0; r19 < 4; r19++) {
    tmpRotation = load(0x1289F4 + someOffset * 8 + r19 * 2)
    store(rotationPtr, tmpRotation)
    
    if(entityCheckCollision(playerPtr, partnerPtr, val1, val2) == -1) {
      rotation = load(rotationPtr)
      
      rotationDiff = initRotation - rotation
      if(rotationDiff < 0)
        rotationDiff = (rotationDiff + 0x1000) & 0x0FFF
      
      rotationSum = rotation + initRotation
      if(rotationSum < 0)
        rotationSum = (rotationSum + 0x1000) & 0x0FFF
      
      if(rotationDiff - rotationSum < 0) {
        if(rotationDiff < 80)
          newRotation = (initRotation + 0x0FB0) & 0x0FFF
        else
          newRotation = (initRotation + 0x1000 - rotationDiff) & 0x0FFF
      }
      else {
        if(rotationSum < 80)
          newRotation = (initRotation + 80) & 0x0FFF
        else
          newRotation = (initRotation + rotationSum) & 0x0FFF
      }
      
      store(rotationPtr, newRotation)
      
      flags = load(partnerPtr + 0x30) | someFlagValue
      store(partnerPtr + 0x30, flags)
      return
    }
    else {
      shiftVal = load(rotationPtr) / 1024
      someFlagValue = someFlagValue & (0x08 << shiftVal) & 0xFF
    }
  }
  
  store(rotationPtr, (initRotation + 0x20) & 0x0FFF)
  flags = load(partnerPtr + 0x30) | 2
  store(partnerPtr + 0x30, flags)
}

0x000d4884 addiu r29,r29,0xffc8
0x000d4888 sw r31,0x0034(r29)
0x000d488c sw r30,0x0030(r29)
0x000d4890 sw r23,0x002c(r29)
0x000d4894 sw r22,0x0028(r29)
0x000d4898 sw r21,0x0024(r29)
0x000d489c sw r20,0x0020(r29)
0x000d48a0 sw r19,0x001c(r29)
0x000d48a4 sw r18,0x0018(r29)
0x000d48a8 sw r17,0x0014(r29)
0x000d48ac sw r16,0x0010(r29)
0x000d48b0 addu r17,r5,r0
0x000d48b4 lbu r2,0x0030(r17)
0x000d48b8 addu r22,r4,r0
0x000d48bc andi r2,r2,0x0005
0x000d48c0 addu r23,r6,r0
0x000d48c4 addu r30,r7,r0
0x000d48c8 sb r2,0x0030(r17)
0x000d48cc jal 0x000d45ec
0x000d48d0 addu r21,r0,r0
0x000d48d4 addiu r1,r0,0xffff
0x000d48d8 beq r2,r1,0x000d4aac
0x000d48dc nop
0x000d48e0 lw r2,0x0004(r17)
0x000d48e4 nop
0x000d48e8 addiu r16,r2,0x0072
0x000d48ec lh r18,0x0000(r16)
0x000d48f0 nop
0x000d48f4 addu r2,r18,r0
0x000d48f8 bgez r2,0x000d4908
0x000d48fc sra r25,r2,0x09
0x000d4900 addiu r2,r2,0x01ff
0x000d4904 sra r25,r2,0x09
0x000d4908 sll r20,r25,0x10
0x000d490c sra r20,r20,0x10
0x000d4910 beq r0,r0,0x000d4a84
0x000d4914 addu r19,r0,r0
0x000d4918 lui r2,0x8013
0x000d491c sll r3,r20,0x03
0x000d4920 addiu r2,r2,0x89f4
0x000d4924 addu r3,r2,r3
0x000d4928 sll r2,r19,0x01
0x000d492c addu r2,r2,r3
0x000d4930 lh r2,0x0000(r2)
0x000d4934 addu r4,r22,r0
0x000d4938 sh r2,0x0000(r16)
0x000d493c addu r5,r17,r0
0x000d4940 addu r6,r23,r0
0x000d4944 jal 0x000d45ec
0x000d4948 addu r7,r30,r0
0x000d494c addiu r1,r0,0xffff
0x000d4950 bne r2,r1,0x000d4a54
0x000d4954 nop
0x000d4958 lh r2,0x0000(r16)
0x000d495c nop
0x000d4960 addu r5,r2,r0
0x000d4964 sub r2,r18,r2
0x000d4968 sll r3,r2,0x10
0x000d496c sra r3,r3,0x10
0x000d4970 bgez r3,0x000d4988
0x000d4974 addu r4,r18,r0
0x000d4978 addi r2,r3,0x1000
0x000d497c andi r2,r2,0x0fff
0x000d4980 sll r3,r2,0x10
0x000d4984 sra r3,r3,0x10
0x000d4988 sub r2,r5,r4
0x000d498c sll r4,r2,0x10
0x000d4990 sra r4,r4,0x10
0x000d4994 bgez r4,0x000d49ac
0x000d4998 nop
0x000d499c addi r2,r4,0x1000
0x000d49a0 andi r2,r2,0x0fff
0x000d49a4 sll r4,r2,0x10
0x000d49a8 sra r4,r4,0x10
0x000d49ac sub r2,r3,r4
0x000d49b0 sll r2,r2,0x10
0x000d49b4 sh r18,0x0000(r16)
0x000d49b8 addu r5,r3,r0
0x000d49bc sra r2,r2,0x10
0x000d49c0 bgez r2,0x000d4a08
0x000d49c4 addu r6,r4,r0
0x000d49c8 slti r1,r3,0x0051
0x000d49cc bne r1,r0,0x000d49ec
0x000d49d0 nop
0x000d49d4 lh r2,0x0000(r16)
0x000d49d8 nop
0x000d49dc addi r2,r2,0x0fb0
0x000d49e0 andi r2,r2,0x0fff
0x000d49e4 beq r0,r0,0x000d4a40
0x000d49e8 sh r2,0x0000(r16)
0x000d49ec lh r2,0x0000(r16)
0x000d49f0 nop
0x000d49f4 addi r2,r2,0x1000
0x000d49f8 sub r2,r2,r5
0x000d49fc andi r2,r2,0x0fff
0x000d4a00 beq r0,r0,0x000d4a40
0x000d4a04 sh r2,0x0000(r16)
0x000d4a08 slti r1,r4,0x0051
0x000d4a0c bne r1,r0,0x000d4a2c
0x000d4a10 nop
0x000d4a14 lh r2,0x0000(r16)
0x000d4a18 nop
0x000d4a1c addi r2,r2,0x0050
0x000d4a20 andi r2,r2,0x0fff
0x000d4a24 beq r0,r0,0x000d4a40
0x000d4a28 sh r2,0x0000(r16)
0x000d4a2c lh r2,0x0000(r16)
0x000d4a30 nop
0x000d4a34 add r2,r2,r6
0x000d4a38 andi r2,r2,0x0fff
0x000d4a3c sh r2,0x0000(r16)
0x000d4a40 lbu r2,0x0030(r17)
0x000d4a44 nop
0x000d4a48 or r2,r2,r21
0x000d4a4c beq r0,r0,0x000d4aac
0x000d4a50 sb r2,0x0030(r17)
0x000d4a54 lh r2,0x0000(r16)
0x000d4a58 nop
0x000d4a5c bgez r2,0x000d4a6c
0x000d4a60 sra r25,r2,0x0a
0x000d4a64 addiu r2,r2,0x03ff
0x000d4a68 sra r25,r2,0x0a
0x000d4a6c addiu r2,r0,0x0008
0x000d4a70 sllv r2,r2,r25
0x000d4a74 andi r2,r2,0x00ff
0x000d4a78 or r2,r21,r2
0x000d4a7c andi r21,r2,0x00ff
0x000d4a80 addi r19,r19,0x0001
0x000d4a84 slti r1,r19,0x0004
0x000d4a88 bne r1,r0,0x000d4918
0x000d4a8c nop
0x000d4a90 addi r2,r18,0x0020
0x000d4a94 andi r2,r2,0x0fff
0x000d4a98 sh r2,0x0000(r16)
0x000d4a9c lbu r2,0x0030(r17)
0x000d4aa0 nop
0x000d4aa4 ori r2,r2,0x0002
0x000d4aa8 sb r2,0x0030(r17)
0x000d4aac lw r31,0x0034(r29)
0x000d4ab0 lw r30,0x0030(r29)
0x000d4ab4 lw r23,0x002c(r29)
0x000d4ab8 lw r22,0x0028(r29)
0x000d4abc lw r21,0x0024(r29)
0x000d4ac0 lw r20,0x0020(r29)
0x000d4ac4 lw r19,0x001c(r29)
0x000d4ac8 lw r18,0x0018(r29)
0x000d4acc lw r17,0x0014(r29)
0x000d4ad0 lw r16,0x0010(r29)
0x000d4ad4 jr r31
0x000d4ad8 addiu r29,r29,0x0038