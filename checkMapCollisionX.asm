/**
 * Checks if an entity is in an unpassable map tile by iterating over a line
 * of tiles it occupies on the X axis. The variable useYMin determines whether 
 * it will take the upper or lower end of the Y coordinate to check.
 *
 * This function return 1 when the entity occupies at least one unpassable tile,
 * 0 otherwise.
 */
int checkMapCollisionX(entityPtr, useYMin) {
  positionPtr = load(entityPtr + 0x04) + 0x78
  diameter = load(0x12CECC + load(entityPtr) * 52)
  radius = diameter / 2
  
  posX = load(positionPtr)
  posY = load(positionPtr + 0x08)
  
  if(useYMin == 0)
    posY = posY + diameter
  else
    posY = posY - diameter
  
  xMin = posX - radius
  xMax = posX + radius
  xMinTile = xMin / 100 + 50
  xMaxTile = xMax / 100 + 50
  
  if(xMin < 0)
    xMinTile--
  if(xMax < 0)
    xMaxTile--
  
  yTile = 49 - posY / 100
  
  if(posY < 0)
    yTile = yTile + 1
  
  tileOffset = xMinTile + yTile * 100
  
  while(xMaxTile >= xMinTile) {
    if(load(0x1AF398 + tileOffset) & 0x80 != 0) // is non-passable
      return 1
    
    xMinTile++
    tileOffset++
  }
  
  return 0
}

0x000c0bbc lw r2,0x0004(r4)
0x000c0bc0 lw r4,0x0000(r4)
0x000c0bc4 addiu r2,r2,0x0078
0x000c0bc8 sll r3,r4,0x01
0x000c0bcc add r3,r3,r4
0x000c0bd0 sll r3,r3,0x02
0x000c0bd4 add r3,r3,r4
0x000c0bd8 sll r4,r3,0x02
0x000c0bdc lui r3,0x8013
0x000c0be0 addiu r3,r3,0xcecc
0x000c0be4 addu r3,r3,r4
0x000c0be8 lh r3,0x0000(r3)
0x000c0bec nop
0x000c0bf0 addu r6,r3,r0
0x000c0bf4 bgez r3,0x000c0c04
0x000c0bf8 sra r25,r3,0x01
0x000c0bfc addiu r3,r3,0x0001
0x000c0c00 sra r25,r3,0x01
0x000c0c04 lw r3,0x0000(r2)
0x000c0c08 addu r7,r25,r0
0x000c0c0c addu r9,r3,r0
0x000c0c10 sub r3,r3,r25
0x000c0c14 sll r8,r3,0x10
0x000c0c18 lui r3,0x51eb
0x000c0c1c sra r8,r8,0x10
0x000c0c20 ori r3,r3,0x851f
0x000c0c24 mult r3,r8
0x000c0c28 srl r4,r8,0x1f
0x000c0c2c mfhi r3
0x000c0c30 sra r3,r3,0x05
0x000c0c34 addu r3,r3,r4
0x000c0c38 addi r3,r3,0x0032
0x000c0c3c sll r3,r3,0x10
0x000c0c40 bgez r8,0x000c0c54
0x000c0c44 sra r3,r3,0x10
0x000c0c48 addi r3,r3,-0x0001
0x000c0c4c sll r3,r3,0x10
0x000c0c50 sra r3,r3,0x10
0x000c0c54 add r4,r9,r7
0x000c0c58 sll r8,r4,0x10
0x000c0c5c lui r4,0x51eb
0x000c0c60 sra r8,r8,0x10
0x000c0c64 ori r4,r4,0x851f
0x000c0c68 mult r4,r8
0x000c0c6c srl r7,r8,0x1f
0x000c0c70 mfhi r4
0x000c0c74 sra r4,r4,0x05
0x000c0c78 addu r4,r4,r7
0x000c0c7c addi r4,r4,0x0032
0x000c0c80 sll r4,r4,0x10
0x000c0c84 bgez r8,0x000c0c98
0x000c0c88 sra r4,r4,0x10
0x000c0c8c addi r4,r4,-0x0001
0x000c0c90 sll r4,r4,0x10
0x000c0c94 sra r4,r4,0x10
0x000c0c98 bne r5,r0,0x000c0cb8
0x000c0c9c nop
0x000c0ca0 lw r2,0x0008(r2)
0x000c0ca4 nop
0x000c0ca8 add r2,r2,r6
0x000c0cac sll r6,r2,0x10
0x000c0cb0 beq r0,r0,0x000c0ccc
0x000c0cb4 sra r6,r6,0x10
0x000c0cb8 lw r2,0x0008(r2)
0x000c0cbc nop
0x000c0cc0 sub r2,r2,r6
0x000c0cc4 sll r6,r2,0x10
0x000c0cc8 sra r6,r6,0x10
0x000c0ccc lui r2,0x51eb
0x000c0cd0 ori r2,r2,0x851f
0x000c0cd4 mult r2,r6
0x000c0cd8 srl r5,r6,0x1f
0x000c0cdc mfhi r2
0x000c0ce0 sra r2,r2,0x05
0x000c0ce4 addu r5,r2,r5
0x000c0ce8 addiu r2,r0,0x0031
0x000c0cec sub r2,r2,r5
0x000c0cf0 sll r5,r2,0x10
0x000c0cf4 bgez r6,0x000c0d08
0x000c0cf8 sra r5,r5,0x10
0x000c0cfc addi r2,r5,0x0001
0x000c0d00 sll r5,r2,0x10
0x000c0d04 sra r5,r5,0x10
0x000c0d08 sll r2,r5,0x02
0x000c0d0c add r5,r2,r5
0x000c0d10 sll r2,r5,0x02
0x000c0d14 add r2,r5,r2
0x000c0d18 sll r2,r2,0x02
0x000c0d1c beq r0,r0,0x000c0d5c
0x000c0d20 add r5,r3,r2
0x000c0d24 lui r2,0x801b
0x000c0d28 addiu r2,r2,0xf398
0x000c0d2c addu r2,r2,r5
0x000c0d30 lbu r2,0x0000(r2)
0x000c0d34 nop
0x000c0d38 andi r2,r2,0x0080
0x000c0d3c beq r2,r0,0x000c0d4c
0x000c0d40 nop
0x000c0d44 beq r0,r0,0x000c0d6c
0x000c0d48 addiu r2,r0,0x0001
0x000c0d4c addi r2,r3,0x0001
0x000c0d50 sll r3,r2,0x10
0x000c0d54 sra r3,r3,0x10
0x000c0d58 addi r5,r5,0x0001
0x000c0d5c slt r1,r4,r3
0x000c0d60 beq r1,r0,0x000c0d24
0x000c0d64 nop
0x000c0d68 addu r2,r0,r0
0x000c0d6c jr r31
0x000c0d70 nop