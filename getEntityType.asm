/**
 * Gets the type of an entity by a given entity pointer.
 * Return 0 for NPCs, 2 for the Player, 3 for the Partner and -1 if it finds nothing.
 */
int getEntityType(int entityPtr) {
  for(i = 0; i < 10; i++) {
    if(load(0x12F344 + i * 4) == entityPtr) // find entity ID in entity table
      break
  }
  
  if(i == 10)
    return -1
    
  if(i == 1)
    return 3
    
  if(i != 0)
    return 0
    
  return 2
}

0x000a2660 addu r3,r0,r0
0x000a2664 beq r0,r0,0x000a2690
0x000a2668 addu r5,r0,r0
0x000a266c lui r2,0x8013
0x000a2670 addiu r2,r2,0xf344
0x000a2674 addu r2,r2,r5
0x000a2678 lw r2,0x0000(r2)
0x000a267c nop
0x000a2680 beq r2,r4,0x000a269c
0x000a2684 nop
0x000a2688 addi r3,r3,0x0001
0x000a268c addi r5,r5,0x0004
0x000a2690 slti r1,r3,0x000a
0x000a2694 bne r1,r0,0x000a266c
0x000a2698 nop
0x000a269c addiu r1,r0,0x000a
0x000a26a0 beq r3,r1,0x000a26cc
0x000a26a4 nop
0x000a26a8 addiu r1,r0,0x0001
0x000a26ac beq r3,r1,0x000a26c4
0x000a26b0 nop
0x000a26b4 bne r3,r0,0x000a26d4
0x000a26b8 addu r2,r0,r0
0x000a26bc beq r0,r0,0x000a26d4
0x000a26c0 addiu r2,r0,0x0002
0x000a26c4 beq r0,r0,0x000a26d4
0x000a26c8 addiu r2,r0,0x0003
0x000a26cc beq r0,r0,0x000a26d4
0x000a26d0 addiu r2,r0,0xffff
0x000a26d4 jr r31
0x000a26d8 nop