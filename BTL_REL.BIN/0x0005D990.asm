boolean 0x0005D990(int entityData, int combatData) {
  moveId = load(combatData + 0x38) // currently used move
  
  techId = getTechFromMove(entityData, moveId)
  unknown1 = load(0x126249 + techId * 16) // load unknown1
    
  if(unknown1 % 2 && load(0x134D80) > 0)
    return 1
    
  return 0
}

0x0005d990 addiu r29,r29,0xffe8
0x0005d994 sw r31,0x0010(r29)
0x0005d998 lbu r5,0x0038(r5)
0x0005d99c jal 0x000e6000
0x0005d9a0 nop
0x0005d9a4 sll r2,r2,0x10
0x0005d9a8 sra r2,r2,0x10
0x0005d9ac sll r3,r2,0x04
0x0005d9b0 lui r2,0x8012
0x0005d9b4 addiu r2,r2,0x6249
0x0005d9b8 addu r2,r2,r3
0x0005d9bc lbu r2,0x0000(r2)
0x0005d9c0 nop
0x0005d9c4 andi r2,r2,0x0002
0x0005d9c8 beq r2,r0,0x0005d9e8
0x0005d9cc nop
0x0005d9d0 lw r2,-0x6dac(r28)
0x0005d9d4 nop
0x0005d9d8 blez r2,0x0005d9e8
0x0005d9dc nop
0x0005d9e0 beq r0,r0,0x0005d9ec
0x0005d9e4 addiu r2,r0,0x0001
0x0005d9e8 addu r2,r0,r0
0x0005d9ec lw r31,0x0010(r29)
0x0005d9f0 nop
0x0005d9f4 jr r31
0x0005d9f8 addiu r29,r29,0x0018