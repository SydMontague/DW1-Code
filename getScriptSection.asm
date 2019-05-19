int getScriptSection(scriptPtr, val2) {
  sectionPtr = scriptPtr + 2
  
  do {
    sectionId = load(sectionPtr)
  
    if(sectionId == val2)
      return scriptPtr + load(sectionPtr + 0x02)
    
    sectionPtr += 4
  } while(sectionId != -1)
  
  return 0
}

0x0010629c addiu r3,r4,0x0002
0x001062a0 lhu r2,0x0000(r3)
0x001062a4 nop
0x001062a8 bne r2,r5,0x001062bc
0x001062ac addu r6,r2,r0
0x001062b0 lhu r2,0x0002(r3)
0x001062b4 beq r0,r0,0x001062d8
0x001062b8 addu r2,r4,r2
0x001062bc ori r1,r0,0xffff
0x001062c0 bne r6,r1,0x001062d0
0x001062c4 nop
0x001062c8 beq r0,r0,0x001062d8
0x001062cc addu r2,r0,r0
0x001062d0 beq r0,r0,0x001062a0
0x001062d4 addi r3,r3,0x0004
0x001062d8 jr r31
0x001062dc nop