/**
 * Returns the squared distance between two entities on the X and Z axis.
 */
int distanceSquared(entityPtr, enemyEntityPtr) {
  posPointer1 = load(entityPtr + 0x04) + 0x78
  posPointer2 = load(enemyEntityPtr + 0x04) + 0x78
  
  locX1 = load(posPointer1)
  locZ1 = load(posPointer1 + 0x08)
  
  locX2 = load(posPointer2)
  locZ2 = load(posPointer2 + 0x08)
  
  diffX = locX1 - locX2
  diffZ = locZ1 - locZ2
  
  return diffX * diffX + diffZ * diffZ
}

0x0005d608 lw r2,0x0004(r4)
0x0005d60c nop
0x0005d610 addiu r4,r2,0x0078
0x0005d614 lw r2,0x0004(r5)
0x0005d618 lw r3,0x0000(r4)
0x0005d61c addiu r5,r2,0x0078
0x0005d620 lw r2,0x0000(r5)
0x0005d624 nop
0x0005d628 sub r6,r3,r2
0x0005d62c lw r3,0x0008(r4)
0x0005d630 lw r2,0x0008(r5)
0x0005d634 mult r6,r6
0x0005d638 sub r2,r3,r2
0x0005d63c mflo r3
0x0005d640 nop
0x0005d644 nop
0x0005d648 mult r2,r2
0x0005d64c mflo r2
0x0005d650 jr r31
0x0005d654 add r2,r3,r2