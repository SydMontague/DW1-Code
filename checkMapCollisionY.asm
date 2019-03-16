/**
 * Checks if an entity is in an unpassable map tile by iterating over a line
 * of tiles it occupies on the Y axis. The variable useXMin determines whether 
 * it will take the upper or lower end of the X coordinate to check.
 *
 * This function return 1 when the entity occupies at least one unpassable tile,
 * 0 otherwise.
 */
int checkMapCollisionY(entityPtr, val) {
  positionPtr = load(entityPtr + 0x04) + 0x78
  diameter = load(0x12CECC + load(entityPtr + 0x00) * 52)
  radius = diameter / 2
  
  posX = load(positionPtr)
  posY = load(positionPtr + 0x08)
  
  if(val == 0)
    posX = posX - diameter
  else
    posX = posX + diameter
  
  yMax = posY + radius
  yMin = posY - radius
  yMaxTile = 49 - yMax / 100
  yMinTile = 49 - yMin / 100
  
  if(yMax < 0)
    yMaxTile++
  if(yMin < 0)
    yMinTile++
  
  tileX = posX / 100 + 50
  
  if(posX < 0)
    tileX--
  
  tileOffset = yMaxTile * 100
  
  while(yMinTile >= yMaxTile) {
    if(load(0x1AF398 + tileOffset + tileX) & 0x80 != 0)
      return 1
    
    yMaxTile++
    tileOffset += 100
  }
  
  return 0
}

0x000c0d74 lw r2,0x0004(r4)
0x000c0d78 lw r4,0x0000(r4)
0x000c0d7c nop
0x000c0d80 sll r3,r4,0x01
0x000c0d84 add r3,r3,r4
0x000c0d88 sll r3,r3,0x02
0x000c0d8c add r3,r3,r4
0x000c0d90 sll r4,r3,0x02
0x000c0d94 lui r3,0x8013
0x000c0d98 addiu r3,r3,0xcecc
0x000c0d9c addu r3,r3,r4
0x000c0da0 lh r3,0x0000(r3)
0x000c0da4 bne r5,r0,0x000c0dc4
0x000c0da8 addiu r2,r2,0x0078
0x000c0dac lw r4,0x0000(r2)
0x000c0db0 nop
0x000c0db4 sub r4,r4,r3
0x000c0db8 sll r6,r4,0x10
0x000c0dbc beq r0,r0,0x000c0dd8
0x000c0dc0 sra r6,r6,0x10
0x000c0dc4 lw r4,0x0000(r2)
0x000c0dc8 nop
0x000c0dcc add r4,r4,r3
0x000c0dd0 sll r6,r4,0x10
0x000c0dd4 sra r6,r6,0x10
0x000c0dd8 lui r4,0x51eb
0x000c0ddc ori r4,r4,0x851f
0x000c0de0 mult r4,r6
0x000c0de4 srl r5,r6,0x1f
0x000c0de8 mfhi r4
0x000c0dec sra r4,r4,0x05
0x000c0df0 addu r4,r4,r5
0x000c0df4 addi r4,r4,0x0032
0x000c0df8 sll r4,r4,0x10
0x000c0dfc bgez r6,0x000c0e10
0x000c0e00 sra r4,r4,0x10
0x000c0e04 addi r4,r4,-0x0001
0x000c0e08 sll r4,r4,0x10
0x000c0e0c sra r4,r4,0x10
0x000c0e10 bgez r3,0x000c0e20
0x000c0e14 sra r25,r3,0x01
0x000c0e18 addiu r3,r3,0x0001
0x000c0e1c sra r25,r3,0x01
0x000c0e20 lw r2,0x0008(r2)
0x000c0e24 addu r5,r25,r0
0x000c0e28 addu r6,r2,r0
0x000c0e2c add r2,r2,r25
0x000c0e30 sll r7,r2,0x10
0x000c0e34 lui r2,0x51eb
0x000c0e38 sra r7,r7,0x10
0x000c0e3c ori r2,r2,0x851f
0x000c0e40 mult r2,r7
0x000c0e44 srl r3,r7,0x1f
0x000c0e48 mfhi r2
0x000c0e4c sra r2,r2,0x05
0x000c0e50 addu r3,r2,r3
0x000c0e54 addiu r2,r0,0x0031
0x000c0e58 sub r2,r2,r3
0x000c0e5c sll r2,r2,0x10
0x000c0e60 bgez r7,0x000c0e74
0x000c0e64 sra r2,r2,0x10
0x000c0e68 addi r2,r2,0x0001
0x000c0e6c sll r2,r2,0x10
0x000c0e70 sra r2,r2,0x10
0x000c0e74 sub r3,r6,r5
0x000c0e78 sll r7,r3,0x10
0x000c0e7c lui r3,0x51eb
0x000c0e80 sra r7,r7,0x10
0x000c0e84 ori r3,r3,0x851f
0x000c0e88 mult r3,r7
0x000c0e8c srl r5,r7,0x1f
0x000c0e90 mfhi r3
0x000c0e94 sra r3,r3,0x05
0x000c0e98 addu r5,r3,r5
0x000c0e9c addiu r3,r0,0x0031
0x000c0ea0 sub r3,r3,r5
0x000c0ea4 sll r6,r3,0x10
0x000c0ea8 bgez r7,0x000c0ebc
0x000c0eac sra r6,r6,0x10
0x000c0eb0 addi r3,r6,0x0001
0x000c0eb4 sll r6,r3,0x10
0x000c0eb8 sra r6,r6,0x10
0x000c0ebc sll r3,r2,0x02
0x000c0ec0 add r5,r3,r2
0x000c0ec4 sll r3,r5,0x02
0x000c0ec8 add r3,r5,r3
0x000c0ecc beq r0,r0,0x000c0f10
0x000c0ed0 sll r7,r3,0x02
0x000c0ed4 lui r3,0x801b
0x000c0ed8 add r5,r4,r7
0x000c0edc addiu r3,r3,0xf398
0x000c0ee0 addu r3,r3,r5
0x000c0ee4 lbu r3,0x0000(r3)
0x000c0ee8 nop
0x000c0eec andi r3,r3,0x0080
0x000c0ef0 beq r3,r0,0x000c0f00
0x000c0ef4 nop
0x000c0ef8 beq r0,r0,0x000c0f20
0x000c0efc addiu r2,r0,0x0001
0x000c0f00 addi r2,r2,0x0001
0x000c0f04 sll r2,r2,0x10
0x000c0f08 sra r2,r2,0x10
0x000c0f0c addi r7,r7,0x0064
0x000c0f10 slt r1,r6,r2
0x000c0f14 beq r1,r0,0x000c0ed4
0x000c0f18 nop
0x000c0f1c addu r2,r0,r0
0x000c0f20 jr r31
0x000c0f24 nop