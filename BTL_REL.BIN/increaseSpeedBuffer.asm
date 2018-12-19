int increaseSpeedBuffer(int combatData, int statsData) {
  int currentBuffer = load(combatData + 0x32);

  if(currentBuffer >= 100) // current speed buffer state
    return 100;
    
  if(load(0x134D66) % 2 == 0) {
    speed = load(r5 + 4)
    
    currentBuffer += speed / 100 + 1
    store(combatData + 0x32, currentBuffer)
  }
  
  if(currentBuffer > 100) 
    store(combatData + 0x32, 100)

  return load(combatData + 0x32)
}

0x0005af44 lh r2,0x0032(r4)
0x0005af48 nop
0x0005af4c slti r1,r2,0x0064
0x0005af50 beq r1,r0,0x0005afd0
0x0005af54 nop
0x0005af58 lh r3,-0x6dc6(r28)
0x0005af5c nop
0x0005af60 bgez r3,0x0005af74
0x0005af64 andi r2,r3,0x0001
0x0005af68 beq r2,r0,0x0005af74
0x0005af6c nop
0x0005af70 addiu r2,r2,0xfffe
0x0005af74 bne r2,r0,0x0005afb4
0x0005af78 nop
0x0005af7c lui r2,0x51eb
0x0005af80 lh r3,0x0004(r5)
0x0005af84 ori r2,r2,0x851f
0x0005af88 mult r2,r3
0x0005af8c mfhi r2
0x0005af90 srl r3,r3,0x1f
0x0005af94 sra r2,r2,0x05
0x0005af98 addu r2,r2,r3
0x0005af9c addi r3,r2,0x0001
0x0005afa0 sll r3,r3,0x10
0x0005afa4 lh r2,0x0032(r4)
0x0005afa8 sra r3,r3,0x10
0x0005afac add r2,r2,r3
0x0005afb0 sh r2,0x0032(r4)
0x0005afb4 lh r2,0x0032(r4)
0x0005afb8 nop
0x0005afbc slti r1,r2,0x0065
0x0005afc0 bne r1,r0,0x0005afd0
0x0005afc4 nop
0x0005afc8 addiu r2,r0,0x0064
0x0005afcc sh r2,0x0032(r4)
0x0005afd0 jr r31
0x0005afd4 nop
