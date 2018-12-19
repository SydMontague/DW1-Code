int getTechFromMove(int mapDataOffset, int move) {

  if(move == 0xFF)
    return 0xFF
    
  digimonType = load(mapDataOffset)
  
  if(digimonType == 0x3C && move == 0x3C) // if H-Kabuterimon 
    return 0x70 // H-Kabuterimon's finisher
      
  digimonDataOffset = 0x12ced7 + digimonType * 52
  moveId = move - 0x2E
  
  return load(digimonDataOffset + moveId)
}

// original code
0x000e6000 addiu r1,r0,0x00ff
0x000e6004 bne r5,r1,0x000e6014
0x000e6008 nop
0x000e600c beq r0,r0,0x000e6070
0x000e6010 addiu r2,r0,0x00ff
0x000e6014 lw r2,0x0000(r4)
0x000e6018 addiu r1,r0,0x003c
0x000e601c bne r2,r1,0x000e6038
0x000e6020 nop
0x000e6024 addiu r1,r0,0x003c
0x000e6028 bne r5,r1,0x000e6038
0x000e602c nop
0x000e6030 beq r0,r0,0x000e6070
0x000e6034 addiu r2,r0,0x0070
0x000e6038 lw r3,0x0000(r4)
0x000e603c nop
0x000e6040 sll r2,r3,0x01
0x000e6044 add r2,r2,r3
0x000e6048 sll r2,r2,0x02
0x000e604c add r2,r2,r3
0x000e6050 sll r3,r2,0x02
0x000e6054 lui r2,0x8013
0x000e6058 addiu r2,r2,0xced7
0x000e605c addu r3,r2,r3
0x000e6060 addi r2,r5,-0x002e
0x000e6064 addu r2,r2,r3
0x000e6068 lbu r2,0x0000(r2)
0x000e606c nop
0x000e6070 jr r31


0x588D8 // tick
goalCharge + 1

0x5ABEC // successful attack
goalCharge * 0.04

0x5CDC8 // blocked, defender
goalCharge * 0.06

0x5CE58 // blocked, attacker
goalCharge * 0.08