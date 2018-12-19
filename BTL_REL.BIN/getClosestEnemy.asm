/**
 * Gets the closest, living, enemy.
 */
int getClosestEnemy(entityPtr, hostileMap) {
  minDistance = 0xFFFF
  closestEntity = -1
  
  for(i = 0; load(0x134D6C) < i; i++) { // enemy count
  
    if(load(hostileMap + i * 2) != 1)
      continue
      
    combatPtr = load(0x134D4C) // combatPtr
    
    entityId = load(combatPtr + 0x66C + i)
    enemyEntityPtr = load(0x12F344 + entityId * 4) // entityList?
    
    if(entityPtr == enemyEntityPtr)
      continue
    
    if(hasZeroHP(i) != 0)
      continue
    
    distance = distanceSquared(entityPtr, enemyEntityPtr)
    
    if(distance >= minDistance)
      continue
    
    minDistance = distance
    closestEntity = i
  }
  
  return closestEntity
}

0x00060218 addiu r29,r29,0xffd0
0x0006021c sw r31,0x002c(r29)
0x00060220 sw r22,0x0028(r29)
0x00060224 sw r21,0x0024(r29)
0x00060228 sw r20,0x0020(r29)
0x0006022c sw r19,0x001c(r29)
0x00060230 sw r18,0x0018(r29)
0x00060234 sw r17,0x0014(r29)
0x00060238 addiu r2,r0,0x00ff
0x0006023c sw r16,0x0010(r29)
0x00060240 sll r17,r2,0x10
0x00060244 addu r19,r4,r0
0x00060248 addu r22,r5,r0
0x0006024c sra r17,r17,0x10
0x00060250 addiu r21,r0,0xffff
0x00060254 addu r16,r0,r0
0x00060258 beq r0,r0,0x000602e4
0x0006025c addu r20,r0,r0
0x00060260 addu r2,r22,r20
0x00060264 lh r2,0x0000(r2)
0x00060268 addiu r1,r0,0x0001
0x0006026c bne r2,r1,0x000602dc
0x00060270 nop
0x00060274 lw r2,-0x6de0(r28)
0x00060278 nop
0x0006027c addu r2,r16,r2
0x00060280 lbu r2,0x066c(r2)
0x00060284 nop
0x00060288 sll r3,r2,0x02
0x0006028c lui r2,0x8013
0x00060290 addiu r2,r2,0xf344
0x00060294 addu r2,r2,r3
0x00060298 lw r18,0x0000(r2)
0x0006029c nop
0x000602a0 beq r19,r18,0x000602dc
0x000602a4 nop
0x000602a8 jal 0x000601ac
0x000602ac andi r4,r16,0x00ff
0x000602b0 bne r2,r0,0x000602dc
0x000602b4 nop
0x000602b8 addu r4,r19,r0
0x000602bc jal 0x0005d608
0x000602c0 addu r5,r18,r0
0x000602c4 sltu r1,r2,r21
0x000602c8 beq r1,r0,0x000602dc
0x000602cc nop
0x000602d0 sll r17,r16,0x10
0x000602d4 addu r21,r2,r0
0x000602d8 sra r17,r17,0x10
0x000602dc addi r16,r16,0x0001
0x000602e0 addi r20,r20,0x0002
0x000602e4 lh r2,-0x6dc0(r28)
0x000602e8 nop
0x000602ec slt r1,r2,r16
0x000602f0 beq r1,r0,0x00060260
0x000602f4 nop
0x000602f8 addu r2,r17,r0
0x000602fc lw r31,0x002c(r29)
0x00060300 lw r22,0x0028(r29)
0x00060304 lw r21,0x0024(r29)
0x00060308 lw r20,0x0020(r29)
0x0006030c lw r19,0x001c(r29)
0x00060310 lw r18,0x0018(r29)
0x00060314 lw r17,0x0014(r29)
0x00060318 lw r16,0x0010(r29)
0x0006031c jr r31
0x00060320 addiu r29,r29,0x0030