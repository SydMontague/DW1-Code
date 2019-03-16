/**
 * Checks map collision after movement, with with diffX and diffY.
 * Return 1 if there is collision, 0 if not.
 *
 * see checkMapCollisionX and checkMapCollisionY for the checking algorithm.
 */
int checkMapCollision(entityPtr, diffX, diffY) {
  if(diffY > 0 && checkMapCollisionX(entityPtr, 0) != 0)
    return 1
  
  if(diffY < 0 && checkMapCollisionX(entityPtr, 1) != 0)
    return 1
    
  if(diffX < 0 && checkMapCollisionY(entityPtr, 0) != 0)
    return 1
    
  if(diffX > 0 && checkMapCollisionY(entityPtr, 1) != 0)
    return 1
    
  return 0
}

0x000d5018 addiu r29,r29,0xffe0
0x000d501c sw r31,0x001c(r29)
0x000d5020 sw r18,0x0018(r29)
0x000d5024 sw r17,0x0014(r29)
0x000d5028 sw r16,0x0010(r29)
0x000d502c addu r16,r4,r0
0x000d5030 addu r17,r6,r0
0x000d5034 blez r17,0x000d5054
0x000d5038 addu r18,r5,r0
0x000d503c jal 0x000c0bbc
0x000d5040 addu r5,r0,r0
0x000d5044 beq r2,r0,0x000d5054
0x000d5048 nop
0x000d504c beq r0,r0,0x000d50c4
0x000d5050 addiu r2,r0,0x0001
0x000d5054 bgez r17,0x000d5078
0x000d5058 nop
0x000d505c addu r4,r16,r0
0x000d5060 jal 0x000c0bbc
0x000d5064 addiu r5,r0,0x0001
0x000d5068 beq r2,r0,0x000d5078
0x000d506c nop
0x000d5070 beq r0,r0,0x000d50c4
0x000d5074 addiu r2,r0,0x0001
0x000d5078 bgez r18,0x000d509c
0x000d507c nop
0x000d5080 addu r4,r16,r0
0x000d5084 jal 0x000c0d74
0x000d5088 addu r5,r0,r0
0x000d508c beq r2,r0,0x000d509c
0x000d5090 nop
0x000d5094 beq r0,r0,0x000d50c4
0x000d5098 addiu r2,r0,0x0001
0x000d509c blez r18,0x000d50c0
0x000d50a0 nop
0x000d50a4 addu r4,r16,r0
0x000d50a8 jal 0x000c0d74
0x000d50ac addiu r5,r0,0x0001
0x000d50b0 beq r2,r0,0x000d50c0
0x000d50b4 nop
0x000d50b8 beq r0,r0,0x000d50c4
0x000d50bc addiu r2,r0,0x0001
0x000d50c0 addu r2,r0,r0
0x000d50c4 lw r31,0x001c(r29)
0x000d50c8 lw r18,0x0018(r29)
0x000d50cc lw r17,0x0014(r29)
0x000d50d0 lw r16,0x0010(r29)
0x000d50d4 jr r31
0x000d50d8 addiu r29,r29,0x0020