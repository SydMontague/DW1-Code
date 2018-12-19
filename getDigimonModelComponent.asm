/*
 * struct modelComponent {
 *   int unknown
 *   int modelPtr
 *   int animTablePtr
 *   int mmdPtr
 *   int unkn1
 *   int unkn2
 *   short digiType
 *   short unkn3
 * }
 */
/**
 * Gets the model component for a Digimon, based on the entity type and digimon type.
 * Entity type 2 and 3 are for Player and Partner respectively, 0 is for random NPCs.
 * Type 1 is current unknown.
 */
modelComponent* getDigimonModelComponent(digimonType, entityType) {
  if(entityType == 2)
    return 0x1371E0
  
  if(entityType == 3)
    return 0x1371FC
    
  if(entityType == 0) {
    if(digimonType < 0 || digimonType >= 0xB4)
      return 0
    
    for(i = 0; i < 5; i++) {
      ptr = 0x137140 + i * 0x1C
      
      if(load(ptr + 0x18) == digimonType)
        break
    }
    
    if(i == 5)
      return 0
      
    if(load(ptr) != 0)
      return ptr
      
    return 0
  }
  
  if(entityType == 1) {
    if(digimonType < 0 || digimonType >= 150)
      return 0
      
    ptr = 0x137218 + digimonType * 0x1C
    
    if(load(ptr) != 0)
      return ptr
      
    return 0
  }
}

0x000a254c addiu r1,r0,0x0002
0x000a2550 bne r5,r1,0x000a2564
0x000a2554 nop
0x000a2558 lui r2,0x8013
0x000a255c beq r0,r0,0x000a2658
0x000a2560 addiu r2,r2,0x71e0
0x000a2564 addiu r1,r0,0x0003
0x000a2568 bne r5,r1,0x000a257c
0x000a256c nop
0x000a2570 lui r2,0x8013
0x000a2574 beq r0,r0,0x000a2658
0x000a2578 addiu r2,r2,0x71fc
0x000a257c bne r5,r0,0x000a2600
0x000a2580 nop
0x000a2584 bltz r4,0x000a2598
0x000a2588 nop
0x000a258c slti r1,r4,0x00b4
0x000a2590 bne r1,r0,0x000a25a0
0x000a2594 nop
0x000a2598 beq r0,r0,0x000a2658
0x000a259c addu r2,r0,r0
0x000a25a0 lui r2,0x8013
0x000a25a4 addiu r2,r2,0x7140
0x000a25a8 beq r0,r0,0x000a25c8
0x000a25ac addu r5,r0,r0
0x000a25b0 lh r3,0x0018(r2)
0x000a25b4 nop
0x000a25b8 beq r3,r4,0x000a25d4
0x000a25bc nop
0x000a25c0 addiu r2,r2,0x001c
0x000a25c4 addi r5,r5,0x0001
0x000a25c8 slti r1,r5,0x0005
0x000a25cc bne r1,r0,0x000a25b0
0x000a25d0 nop
0x000a25d4 addiu r1,r0,0x0005
0x000a25d8 bne r5,r1,0x000a25e8
0x000a25dc nop
0x000a25e0 beq r0,r0,0x000a2658
0x000a25e4 addu r2,r0,r0
0x000a25e8 lw r3,0x0000(r2)
0x000a25ec nop
0x000a25f0 bne r3,r0,0x000a2658
0x000a25f4 nop
0x000a25f8 beq r0,r0,0x000a2658
0x000a25fc addu r2,r0,r0
0x000a2600 addiu r1,r0,0x0001
0x000a2604 bne r5,r1,0x000a2658
0x000a2608 nop
0x000a260c bltz r4,0x000a2620
0x000a2610 nop
0x000a2614 slti r1,r4,0x0096
0x000a2618 bne r1,r0,0x000a2628
0x000a261c nop
0x000a2620 beq r0,r0,0x000a2658
0x000a2624 addu r2,r0,r0
0x000a2628 sll r2,r4,0x03
0x000a262c sub r2,r2,r4
0x000a2630 sll r3,r2,0x02
0x000a2634 lui r2,0x8013
0x000a2638 addiu r2,r2,0x7218
0x000a263c addu r2,r2,r3
0x000a2640 lw r3,0x0000(r2)
0x000a2644 nop
0x000a2648 bne r3,r0,0x000a2658
0x000a264c nop
0x000a2650 beq r0,r0,0x000a2658
0x000a2654 addu r2,r0,r0
0x000a2658 jr r31
0x000a265c nop