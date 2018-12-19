//(hopefully) equivalent pseudocode
void setFoodTimer(r4 = digimonId) {
  if(digimonLevel == 1) { // Fresh, next even hour
    r2 = ((currentHour / 2) + 1) * 2 
    
    if(r2 > 24)
      r2 -= 24
    
    store(r2, 0x13849A)
  }
  else if(digimonLevel == 2) { // In-Training, next by 3 dividable hour
    r2 = ((currentHour / 3) + 1) * 3
    
    if(r2 > 24)
      r2 -= 24
  
    store(r2, 0x13849A)
  }
  else { // Everything else
    for(i = 0; i < 8; i++) { // Loop over hunger times
      hungerTime = hungerTimes[i];
    
      if(nextHungerHour >= currentHour) { // stored nextHungerHour is after the currentHour (-> new day)
        if(nextHungerHour < hungerTime) { // hungerTime must be after nextHungerTime
          store(hungerTime, 0x13849A)
          break
        }
      }
      else { // stored nextHungerHour is before currentHour (-> same day)
        if(currentHour < hungerTime) { // hungerTime must be after currentHour
          store(hungerTime, 0x13849A)
          break
        }
      }
      
      hungerTime = hungerTimes[i + 1]
      if(hungerTime == -1 || i == 7) { // no time matched, so either nextHungerHour or currentHour is 23
        for(j = 0; j < 8; j++) {
          hungerTime = hungerTimes[j]
          if(currentHour < hungerTime) {
            store(hungerTime, 0x13849A)
            break
          } 
          else {
            hungerTime = hungerTimes[j + 1]
            
            if(hungerTime == -1 || j == 7) { // still no match, use first time
              hungerTime = hungerTimes[0]
              store(hungerTime, 0x13849A)
              break
            }
          }
        }
        
        break
      }
    }
  }

  if(calculatedNextFeed >= currentHour)
    tmp = (calculatedNextFeed - currentHour) * 60
  else
    tmp = (24 - currentHour + calculatedNextFeed) * 60
    
  store(tmp, 0x13849E)
  
  if(currentMinute == 0)
    return
  
  store(tmp - currentMinute, 0x13849E)
}

//original ASM code
0x000a4a08 sll r3,r4,0x01
0x000a4a0c add r3,r3,r4
0x000a4a10 sll r3,r3,0x02
0x000a4a14 addu r2,r4,r0
0x000a4a18 add r3,r3,r4
0x000a4a1c sll r4,r3,0x02
0x000a4a20 lui r3,0x8013
0x000a4a24 addiu r3,r3,0xced1
0x000a4a28 addu r3,r3,r4
0x000a4a2c lbu r3,0x0000(r3)
0x000a4a30 addiu r1,r0,0x0001
0x000a4a34 bne r3,r1,0x000a4a8c
0x000a4a38 nop
0x000a4a3c lh r2,-0x6c70(r28)
0x000a4a40 nop
0x000a4a44 bgez r2,0x000a4a54
0x000a4a48 sra r25,r2,0x01
0x000a4a4c addiu r2,r2,0x0001
0x000a4a50 sra r25,r2,0x01
0x000a4a54 sll r2,r25,0x01
0x000a4a58 addi r2,r2,0x0002
0x000a4a5c lui r1,0x8014
0x000a4a60 sh r2,-0x7b66(r1)
0x000a4a64 lui r1,0x8014
0x000a4a68 lh r2,-0x7b66(r1)
0x000a4a6c nop
0x000a4a70 slti r1,r2,0x0018
0x000a4a74 bne r1,r0,0x000a4cc0
0x000a4a78 nop
0x000a4a7c addi r2,r2,-0x0018
0x000a4a80 lui r1,0x8014
0x000a4a84 beq r0,r0,0x000a4cc0
0x000a4a88 sh r2,-0x7b66(r1)
0x000a4a8c addiu r1,r0,0x0002
0x000a4a90 bne r3,r1,0x000a4af0
0x000a4a94 nop
0x000a4a98 lui r2,0x5555
0x000a4a9c lh r3,-0x6c70(r28)
0x000a4aa0 ori r2,r2,0x5556
0x000a4aa4 mult r2,r3
0x000a4aa8 lui r1,0x8014
0x000a4aac srl r3,r3,0x1f
0x000a4ab0 mfhi r2
0x000a4ab4 addu r3,r2,r3
0x000a4ab8 sll r2,r3,0x01
0x000a4abc add r2,r2,r3
0x000a4ac0 addi r2,r2,0x0003
0x000a4ac4 sh r2,-0x7b66(r1)
0x000a4ac8 lui r1,0x8014
0x000a4acc lh r2,-0x7b66(r1)
0x000a4ad0 nop
0x000a4ad4 slti r1,r2,0x0018
0x000a4ad8 bne r1,r0,0x000a4cc0
0x000a4adc nop
0x000a4ae0 addi r2,r2,-0x0018
0x000a4ae4 lui r1,0x8014
0x000a4ae8 beq r0,r0,0x000a4cc0
0x000a4aec sh r2,-0x7b66(r1)
0x000a4af0 lh r9,-0x6c70(r28)
0x000a4af4 lui r1,0x8014
0x000a4af8 lh r8,-0x7b66(r1)
0x000a4afc sll r7,r2,0x03
0x000a4b00 sub r7,r7,r2
0x000a4b04 addu r3,r0,r0
0x000a4b08 addiu r4,r0,0x0001
0x000a4b0c addu r5,r8,r0
0x000a4b10 addu r6,r9,r0
0x000a4b14 sll r7,r7,0x02
0x000a4b18 beq r0,r0,0x000a4cb4
0x000a4b1c addu r10,r9,r0
0x000a4b20 slt r1,r5,r6
0x000a4b24 bne r1,r0,0x000a4b74
0x000a4b28 nop
0x000a4b2c lui r12,0x8012
0x000a4b30 addiu r12,r12,0x25bc
0x000a4b34 addu r11,r12,r7
0x000a4b38 addu r11,r3,r11
0x000a4b3c lb r11,0x0000(r11)
0x000a4b40 nop
0x000a4b44 slt r1,r8,r11
0x000a4b48 beq r1,r0,0x000a4bbc
0x000a4b4c nop
0x000a4b50 sll r4,r2,0x03
0x000a4b54 sub r2,r4,r2
0x000a4b58 sll r2,r2,0x02
0x000a4b5c addu r2,r12,r2
0x000a4b60 addu r2,r3,r2
0x000a4b64 lb r2,0x0000(r2)
0x000a4b68 lui r1,0x8014
0x000a4b6c beq r0,r0,0x000a4cc0
0x000a4b70 sh r2,-0x7b66(r1)
0x000a4b74 lui r12,0x8012
0x000a4b78 addiu r12,r12,0x25bc
0x000a4b7c addu r11,r12,r7
0x000a4b80 addu r11,r3,r11
0x000a4b84 lb r11,0x0000(r11)
0x000a4b88 nop
0x000a4b8c slt r1,r9,r11
0x000a4b90 beq r1,r0,0x000a4bbc
0x000a4b94 nop
0x000a4b98 sll r4,r2,0x03
0x000a4b9c sub r2,r4,r2
0x000a4ba0 sll r2,r2,0x02
0x000a4ba4 addu r2,r12,r2
0x000a4ba8 addu r2,r3,r2
0x000a4bac lb r2,0x0000(r2)
0x000a4bb0 lui r1,0x8014
0x000a4bb4 beq r0,r0,0x000a4cc0
0x000a4bb8 sh r2,-0x7b66(r1)
0x000a4bbc lui r11,0x8012
0x000a4bc0 addiu r11,r11,0x25bc
0x000a4bc4 addu r11,r11,r7
0x000a4bc8 addu r11,r4,r11
0x000a4bcc lb r11,0x0000(r11)
0x000a4bd0 addiu r1,r0,0xffff
0x000a4bd4 beq r11,r1,0x000a4be8
0x000a4bd8 nop
0x000a4bdc addiu r1,r0,0x0007
0x000a4be0 bne r3,r1,0x000a4cac
0x000a4be4 nop
0x000a4be8 sll r3,r2,0x03
0x000a4bec sub r3,r3,r2
0x000a4bf0 addu r6,r0,r0
0x000a4bf4 addiu r7,r0,0x0001
0x000a4bf8 beq r0,r0,0x000a4c98
0x000a4bfc sll r8,r3,0x02
0x000a4c00 lui r5,0x8012
0x000a4c04 addiu r5,r5,0x25bc
0x000a4c08 addu r4,r5,r8
0x000a4c0c addu r3,r6,r4
0x000a4c10 lb r3,0x0000(r3)
0x000a4c14 nop
0x000a4c18 slt r1,r10,r3
0x000a4c1c beq r1,r0,0x000a4c48
0x000a4c20 nop
0x000a4c24 sll r3,r2,0x03
0x000a4c28 sub r2,r3,r2
0x000a4c2c sll r2,r2,0x02
0x000a4c30 addu r2,r5,r2
0x000a4c34 addu r2,r6,r2
0x000a4c38 lb r2,0x0000(r2)
0x000a4c3c lui r1,0x8014
0x000a4c40 beq r0,r0,0x000a4cc0
0x000a4c44 sh r2,-0x7b66(r1)
0x000a4c48 addu r3,r7,r4
0x000a4c4c lb r3,0x0000(r3)
0x000a4c50 addiu r1,r0,0xffff
0x000a4c54 beq r3,r1,0x000a4c68
0x000a4c58 nop
0x000a4c5c addiu r1,r0,0x0007
0x000a4c60 bne r6,r1,0x000a4c90
0x000a4c64 nop
0x000a4c68 sll r3,r2,0x03
0x000a4c6c sub r2,r3,r2
0x000a4c70 sll r3,r2,0x02
0x000a4c74 lui r2,0x8012
0x000a4c78 addiu r2,r2,0x25bc
0x000a4c7c addu r2,r2,r3
0x000a4c80 lb r2,0x0000(r2)
0x000a4c84 lui r1,0x8014
0x000a4c88 beq r0,r0,0x000a4cc0
0x000a4c8c sh r2,-0x7b66(r1)
0x000a4c90 addi r6,r6,0x0001
0x000a4c94 addi r7,r7,0x0001
0x000a4c98 slti r1,r6,0x0008
0x000a4c9c bne r1,r0,0x000a4c00
0x000a4ca0 nop
0x000a4ca4 beq r0,r0,0x000a4cc0
0x000a4ca8 nop
0x000a4cac addi r3,r3,0x0001
0x000a4cb0 addi r4,r4,0x0001
0x000a4cb4 slti r1,r3,0x0008
0x000a4cb8 bne r1,r0,0x000a4b20
0x000a4cbc nop
0x000a4cc0 lui r1,0x8014
0x000a4cc4 lh r3,-0x6c70(r28)
0x000a4cc8 lh r2,-0x7b66(r1)
0x000a4ccc addu r4,r3,r0
0x000a4cd0 slt r1,r2,r3
0x000a4cd4 bne r1,r0,0x000a4d20
0x000a4cd8 addu r5,r2,r0
0x000a4cdc sub r3,r5,r4
0x000a4ce0 sll r2,r3,0x04
0x000a4ce4 sub r2,r2,r3
0x000a4ce8 sll r2,r2,0x02
0x000a4cec lui r1,0x8014
0x000a4cf0 sh r2,-0x7b62(r1)
0x000a4cf4 lh r2,-0x6c6e(r28)
0x000a4cf8 nop
0x000a4cfc beq r2,r0,0x000a4d98
0x000a4d00 addu r3,r2,r0
0x000a4d04 lui r1,0x8014
0x000a4d08 lh r2,-0x7b62(r1)
0x000a4d0c nop
0x000a4d10 sub r2,r2,r3
0x000a4d14 lui r1,0x8014
0x000a4d18 beq r0,r0,0x000a4d98
0x000a4d1c sh r2,-0x7b62(r1)
0x000a4d20 addiu r2,r0,0x0018
0x000a4d24 sub r3,r2,r4
0x000a4d28 sll r2,r3,0x04
0x000a4d2c sub r2,r2,r3
0x000a4d30 sll r2,r2,0x02
0x000a4d34 lui r1,0x8014
0x000a4d38 sh r2,-0x7b62(r1)
0x000a4d3c lui r1,0x8014
0x000a4d40 lh r3,-0x7b66(r1)
0x000a4d44 nop
0x000a4d48 sll r2,r3,0x04
0x000a4d4c sub r2,r2,r3
0x000a4d50 sll r3,r2,0x02
0x000a4d54 lui r1,0x8014
0x000a4d58 lh r2,-0x7b62(r1)
0x000a4d5c sll r3,r3,0x10
0x000a4d60 sra r3,r3,0x10
0x000a4d64 add r2,r2,r3
0x000a4d68 lui r1,0x8014
0x000a4d6c sh r2,-0x7b62(r1)
0x000a4d70 lh r2,-0x6c6e(r28)
0x000a4d74 nop
0x000a4d78 beq r2,r0,0x000a4d98
0x000a4d7c addu r3,r2,r0
0x000a4d80 lui r1,0x8014
0x000a4d84 lh r2,-0x7b62(r1)
0x000a4d88 nop
0x000a4d8c sub r2,r2,r3
0x000a4d90 lui r1,0x8014
0x000a4d94 sh r2,-0x7b62(r1)
0x000a4d98 jr r31
0x000a4d9c nop