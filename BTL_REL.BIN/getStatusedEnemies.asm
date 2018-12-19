/**
 * Gets an array and count of statused and alive enemies for a given Digimon.
 * The values get stored in addresses given by r5 (array) and r6 (count), 
 * typically on the stack.
 */
int[], int getStatusedEnemies(entityPtr) {
  count = 0
  array = new int[4]
  combatHead = load(0x134D4C) // combat head
  
  // for each enemy
  for(i = 0; i <= load(0x134D6C); i++) {
    entityId = load(combatHead + 0x066C + i)
    localEntityPtr = load(0x12F344 + entityId * 4)
    
    if(entityPtr == localEntityPtr)
      continue
      
    if(hasZeroHP(i))
      continue
    
    // is poisoned, confused, stunned or flattened
    flags = load(combatHead + i * 0x168 + 0x34) & 0x000F
    
    if(flags == 0)
      continue
      
    array[count] = i
    count++;
  }
  
  return count
}

0x0005f51c addiu r29,r29,0xffd0
0x0005f520 sw r31,0x0028(r29)
0x0005f524 sw r21,0x0024(r29)
0x0005f528 sw r20,0x0020(r29)
0x0005f52c sw r19,0x001c(r29)
0x0005f530 sw r18,0x0018(r29)
0x0005f534 sw r17,0x0014(r29)
0x0005f538 sw r16,0x0010(r29)
0x0005f53c addu r17,r6,r0
0x0005f540 sh r0,0x0000(r17)
0x0005f544 lw r19,-0x6de0(r28)
0x0005f548 addu r21,r4,r0
0x0005f54c addu r20,r5,r0
0x0005f550 addu r16,r0,r0
0x0005f554 beq r0,r0,0x0005f5e4
0x0005f558 addu r18,r0,r0
0x0005f55c lw r2,-0x6de0(r28)
0x0005f560 nop
0x0005f564 addu r2,r16,r2
0x0005f568 lbu r2,0x066c(r2)
0x0005f56c nop
0x0005f570 sll r3,r2,0x02
0x0005f574 lui r2,0x8013
0x0005f578 addiu r2,r2,0xf344
0x0005f57c addu r2,r2,r3
0x0005f580 lw r2,0x0000(r2)
0x0005f584 nop
0x0005f588 beq r21,r2,0x0005f5dc
0x0005f58c nop
0x0005f590 jal 0x000601ac
0x0005f594 andi r4,r16,0x00ff
0x0005f598 bne r2,r0,0x0005f5dc
0x0005f59c nop
0x0005f5a0 addu r2,r18,r19
0x0005f5a4 lhu r2,0x0034(r2)
0x0005f5a8 nop
0x0005f5ac andi r2,r2,0x000f
0x0005f5b0 beq r2,r0,0x0005f5dc
0x0005f5b4 nop
0x0005f5b8 lh r2,0x0000(r17)
0x0005f5bc nop
0x0005f5c0 sll r2,r2,0x01
0x0005f5c4 addu r2,r20,r2
0x0005f5c8 sh r16,0x0000(r2)
0x0005f5cc lh r2,0x0000(r17)
0x0005f5d0 nop
0x0005f5d4 addi r2,r2,0x0001
0x0005f5d8 sh r2,0x0000(r17)
0x0005f5dc addi r16,r16,0x0001
0x0005f5e0 addi r18,r18,0x0168
0x0005f5e4 lh r2,-0x6dc0(r28)
0x0005f5e8 nop
0x0005f5ec slt r1,r2,r16
0x0005f5f0 beq r1,r0,0x0005f55c
0x0005f5f4 nop
0x0005f5f8 lw r31,0x0028(r29)
0x0005f5fc lw r21,0x0024(r29)
0x0005f600 lw r20,0x0020(r29)
0x0005f604 lw r19,0x001c(r29)
0x0005f608 lw r18,0x0018(r29)
0x0005f60c lw r17,0x0014(r29)
0x0005f610 lw r16,0x0010(r29)
0x0005f614 jr r31
0x0005f618 addiu r29,r29,0x0030