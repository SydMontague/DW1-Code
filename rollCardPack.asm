/**
 * Rolls a random card. First it determines the rarity of the card and then
 * selects one from all cards with that rarity, with equal chance each.
 * Chances are 1%, 4%, 15%, 30% and 50% for each rarity respectively.
 */
int rollCardPack() {
  rarityRoll = random(100)

  if (rarityRoll == 0) 
    rarity = 0
  else if (rarityRoll < 5) 
    rarity = 1
  else if (rarityRoll < 20) 
    rarity = 2
  else if (rarityRoll < 50)
    rarity = 3
  else
    rarity = 4

  arrayPtr = allocateArray(66)
  cardsFound = 0

  for(r16 = 0; r16 < 66; r16++) {
    if(load(0x12FFD9 + r16 * 4) == rarity) {
      store(arrayPtr + cardsFound, r16)
      cardsFound++
    }
  }

  cardId = load(arrayPtr + random(cardsFound))
  freeArray(arrayPtr)

  return cardId
}

0x00106e0c addiu r29,r29,0xffe0
0x00106e10 sw r31,0x001c(r29)
0x00106e14 sw r18,0x0018(r29)
0x00106e18 sw r17,0x0014(r29)
0x00106e1c sw r16,0x0010(r29)
0x00106e20 jal 0x000a36d4
0x00106e24 addiu r4,r0,0x0064
0x00106e28 andi r17,r2,0x00ff
0x00106e2c bne r17,r0,0x00106e3c
0x00106e30 nop
0x00106e34 beq r0,r0,0x00106e78
0x00106e38 addu r17,r0,r0
0x00106e3c sltiu r1,r17,0x0005
0x00106e40 beq r1,r0,0x00106e50
0x00106e44 nop
0x00106e48 beq r0,r0,0x00106e78
0x00106e4c addiu r17,r0,0x0001
0x00106e50 sltiu r1,r17,0x0014
0x00106e54 beq r1,r0,0x00106e64
0x00106e58 nop
0x00106e5c beq r0,r0,0x00106e78
0x00106e60 addiu r17,r0,0x0002
0x00106e64 sltiu r1,r17,0x0032
0x00106e68 beq r1,r0,0x00106e78
0x00106e6c addiu r17,r0,0x0004
0x00106e70 beq r0,r0,0x00106e78
0x00106e74 addiu r17,r0,0x0003
0x00106e78 jal 0x000fc2d0
0x00106e7c addiu r4,r0,0x0042
0x00106e80 addu r18,r2,r0
0x00106e84 addu r3,r18,r0
0x00106e88 addu r4,r0,r0
0x00106e8c addu r16,r0,r0
0x00106e90 beq r0,r0,0x00106ed4
0x00106e94 addu r5,r0,r0
0x00106e98 lui r2,0x8013
0x00106e9c addiu r2,r2,0xffd9
0x00106ea0 addu r2,r2,r5
0x00106ea4 lbu r2,0x0000(r2)
0x00106ea8 nop
0x00106eac bne r17,r2,0x00106ec8
0x00106eb0 nop
0x00106eb4 addu r2,r3,r0
0x00106eb8 addiu r3,r2,0x0001
0x00106ebc sb r16,0x0000(r2)
0x00106ec0 addiu r2,r4,0x0001
0x00106ec4 andi r4,r2,0x00ff
0x00106ec8 addiu r2,r16,0x0001
0x00106ecc andi r16,r2,0x00ff
0x00106ed0 addi r5,r5,0x0004
0x00106ed4 sltiu r1,r16,0x0042
0x00106ed8 bne r1,r0,0x00106e98
0x00106edc nop
0x00106ee0 jal 0x000a36d4
0x00106ee4 nop
0x00106ee8 andi r17,r2,0x00ff
0x00106eec addu r2,r18,r17
0x00106ef0 lbu r16,0x0000(r2)
0x00106ef4 jal 0x000fc310
0x00106ef8 addu r4,r18,r0
0x00106efc addu r2,r16,r0
0x00106f00 lw r31,0x001c(r29)
0x00106f04 lw r18,0x0018(r29)
0x00106f08 lw r17,0x0014(r29)
0x00106f0c lw r16,0x0010(r29)
0x00106f10 jr r31