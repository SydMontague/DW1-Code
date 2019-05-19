// Bug: While the code checks if an entity pointer is set, it doesn't care for it's value
//      and just assumes an entity pointer based on the entityId.
int scriptIdToEntityId(targetId) {
  if(targetId == 253) // player
    return 0
  
  if(targetId == 252) // partner
    return 1
  
  for(i = 0; i < 8; i++) {
    entityPtr = load(0x12F344 + (i + 2) * 4)
    scriptId = load(0x15588D + i * 0x68)
    
    if(entityPtr != 0 && targetId == scriptId)
      return i + 2
  }
  
  return -1
}

0x00102144 addiu r1,r0,0x00fd
0x00102148 bne r4,r1,0x00102158
0x0010214c nop
0x00102150 beq r0,r0,0x001021e0
0x00102154 addu r2,r0,r0
0x00102158 addiu r1,r0,0x00fc
0x0010215c bne r4,r1,0x0010216c
0x00102160 addu r5,r0,r0
0x00102164 beq r0,r0,0x001021e0
0x00102168 addiu r2,r0,0x0001
0x0010216c addiu r6,r0,0x0002
0x00102170 beq r0,r0,0x001021d0
0x00102174 addu r7,r0,r0
0x00102178 lui r2,0x8013
0x0010217c sll r3,r6,0x02
0x00102180 addiu r2,r2,0xf344
0x00102184 addu r2,r2,r3
0x00102188 lw r2,0x0000(r2)
0x0010218c nop
0x00102190 beq r2,r0,0x001021c0
0x00102194 nop
0x00102198 lui r2,0x8015
0x0010219c addiu r2,r2,0x588d
0x001021a0 addu r2,r2,r7
0x001021a4 lbu r2,0x0000(r2)
0x001021a8 nop
0x001021ac bne r4,r2,0x001021c0
0x001021b0 nop
0x001021b4 addi r2,r5,0x0002
0x001021b8 beq r0,r0,0x001021e0
0x001021bc andi r2,r2,0x00ff
0x001021c0 addiu r2,r5,0x0001
0x001021c4 andi r5,r2,0x00ff
0x001021c8 addi r7,r7,0x0068
0x001021cc addi r6,r6,0x0001
0x001021d0 sltiu r1,r5,0x0008
0x001021d4 bne r1,r0,0x00102178
0x001021d8 nop
0x001021dc addiu r2,r0,0x00ff
0x001021e0 jr r31
0x001021e4 nop