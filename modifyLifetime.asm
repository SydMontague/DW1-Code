void modifyLifetime(int amount) {
  newTime = load(0x1484A8) + amount
  
  if(newTime < 0)
    newTime = 0
    
  store(0x1484A8, newTime)
}

0x000c57d0 lui r3,0x8014
0x000c57d4 addiu r3,r3,0x84a8
0x000c57d8 lh r2,0x0000(r3)
0x000c57dc nop
0x000c57e0 add r2,r2,r4
0x000c57e4 sh r2,0x0000(r3)
0x000c57e8 lh r2,0x0000(r3)
0x000c57ec nop
0x000c57f0 bgez r2,0x000c57fc
0x000c57f4 nop
0x000c57f8 sh r0,0x0000(r3)
0x000c57fc jr r31
0x000c5800 nop