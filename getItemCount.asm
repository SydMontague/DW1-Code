/**
 * Gets the amount of an item in the player's inventory
 */
int getItemCount(int itemId) {
  inventorySize = load(0x13D4CE)

  for(int i = 0; i < r5; i++) {
    foundItem = load(0x13D474 + i) // item ID in slot i
    
    if(foundItem == itemId)
      return load(0x13D492 + i) // item amount in slot i
  }

  return 0
}

0x000c51e0 lui r1,0x8014
0x000c51e4 lbu r5,-0x2b32(r1)
0x000c51e8 beq r0,r0,0x000c5228
0x000c51ec addu r3,r0,r0
0x000c51f0 lui r2,0x8014
0x000c51f4 addiu r2,r2,0xd474
0x000c51f8 addu r2,r2,r3
0x000c51fc lbu r2,0x0000(r2)
0x000c5200 nop
0x000c5204 bne r2,r4,0x000c5224
0x000c5208 nop
0x000c520c lui r2,0x8014
0x000c5210 addiu r2,r2,0xd492
0x000c5214 addu r2,r2,r3
0x000c5218 lbu r2,0x0000(r2)
0x000c521c beq r0,r0,0x000c5238
0x000c5220 nop
0x000c5224 addi r3,r3,0x0001
0x000c5228 slt r1,r3,r5
0x000c522c bne r1,r0,0x000c51f0
0x000c5230 nop
0x000c5234 addu r2,r0,r0
0x000c5238 jr r31
0x000c523c nop