int getFreshEvolutionTarget(digimonType) {
  if(digimonType == 1)
    target = 2
  
  if(digimonType == 15)
    target = 16
  
  if(digimonType == 30)
    target = 31
  
  if(digimonType == 43)
    target = 44
  
  store(0x1384B6, 0) // reset evo timer
  return target
}

0x000e2544 addiu r1,r0,0x0001
0x000e2548 bne r4,r1,0x000e2554
0x000e254c nop
0x000e2550 addiu r2,r0,0x0002
0x000e2554 addiu r1,r0,0x000f
0x000e2558 bne r4,r1,0x000e2564
0x000e255c nop
0x000e2560 addiu r2,r0,0x0010
0x000e2564 addiu r1,r0,0x001d
0x000e2568 bne r4,r1,0x000e2574
0x000e256c nop
0x000e2570 addiu r2,r0,0x001e
0x000e2574 addiu r1,r0,0x002b
0x000e2578 bne r4,r1,0x000e2584
0x000e257c nop
0x000e2580 addiu r2,r0,0x002c
0x000e2584 lui r1,0x8014
0x000e2588 sll r2,r2,0x10
0x000e258c sh r0,-0x7b4a(r1)
0x000e2590 jr r31
0x000e2594 sra r2,r2,0x10