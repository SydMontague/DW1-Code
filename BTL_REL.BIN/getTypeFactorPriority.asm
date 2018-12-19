int getTypeFactorPriority(attackerSpec, victimSpec) {
  typeFactor = load(0x125F70 + attackerSpec * 7 + victimSpec)
  
  if(typeFactor == 2)
    return 1
  if(typeFactor == 5)
    return 3
  if(typeFactor == 10)
    return 5
  if(typeFactor == 15)
    return 7
  if(typeFactor == 20)
    return 10
    
  return r2 //  previous state of r2, undefined
}

0x0005fad0 sll r3,r4,0x03
0x0005fad4 sub r4,r3,r4
0x0005fad8 lui r3,0x8012
0x0005fadc addiu r3,r3,0x5f70
0x0005fae0 addu r3,r3,r4
0x0005fae4 addu r3,r5,r3
0x0005fae8 lbu r3,0x0000(r3)
0x0005faec addiu r1,r0,0x0002
0x0005faf0 beq r3,r1,0x0005fb48
0x0005faf4 nop
0x0005faf8 addiu r1,r0,0x0005
0x0005fafc beq r3,r1,0x0005fb40
0x0005fb00 nop
0x0005fb04 addiu r1,r0,0x000a
0x0005fb08 beq r3,r1,0x0005fb38
0x0005fb0c nop
0x0005fb10 addiu r1,r0,0x000f
0x0005fb14 beq r3,r1,0x0005fb30
0x0005fb18 nop
0x0005fb1c addiu r1,r0,0x0014
0x0005fb20 bne r3,r1,0x0005fb4c
0x0005fb24 nop
0x0005fb28 beq r0,r0,0x0005fb4c
0x0005fb2c addiu r2,r0,0x000a
0x0005fb30 beq r0,r0,0x0005fb4c
0x0005fb34 addiu r2,r0,0x0007
0x0005fb38 beq r0,r0,0x0005fb4c
0x0005fb3c addiu r2,r0,0x0005
0x0005fb40 beq r0,r0,0x0005fb4c
0x0005fb44 addiu r2,r0,0x0003
0x0005fb48 addiu r2,r0,0x0001
0x0005fb4c jr r31
0x0005fb50 nop