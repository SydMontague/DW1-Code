void printRectDebugInfo(funcNamePtr, headerPtr) {
  state = load(0x116C56)
  
  xPos = headerPtr[0]
  yPos = headerPtr[1]
  xSize = headerPtr[2]
  ySize = headerPtr[3]
  
  if(state == 1) { // log error
    width = load(0x116C56 + 2)
    height = load(0x116C56 + 4)
    
    if(width >= xSize && width >= xSize + xPos 
        && height >= yPos && height >= yPos + y2
        && xSize > 0 && xPos >= 0 && yPos > 0 && ySize >= 0)
      return
  
    stringPtr = 0x113E58 // "%s:BAD RECT"
  }
  else if(state == 2) // log anything
    stringPtr = 0x113E78 // "%s:"
  else // log nothing 
    return
  
  // call function pointer loaded from 0x116C50 -> printf()
  printf(stringPtr, funcNamePtr)
  printf(0x113E64, xPos, yPos, xSize, ySize) // "(%d,%d)-(%d,%d)"
}

0x00092cbc addiu r29,r29,0xffe0
0x00092cc0 addu r8,r4,r0
0x00092cc4 sw r16,0x0018(r29)
0x00092cc8 lui r4,0x8011
0x00092ccc addiu r4,r4,0x6c56
0x00092cd0 sw r31,0x001c(r29)
0x00092cd4 lbu r3,0x0000(r4)
0x00092cd8 addiu r2,r0,0x0001
0x00092cdc beq r3,r2,0x00092cf8
0x00092ce0 addu r16,r5,r0
0x00092ce4 addiu r2,r0,0x0002
0x00092ce8 beq r3,r2,0x00092d84
0x00092cec nop
0x00092cf0 j 0x00092dc8
0x00092cf4 nop
0x00092cf8 lh r5,0x0004(r16)
0x00092cfc lh r3,0x0002(r4)
0x00092d00 nop
0x00092d04 slt r2,r3,r5
0x00092d08 bne r2,r0,0x00092d78
0x00092d0c nop
0x00092d10 lh r7,0x0000(r16)
0x00092d14 nop
0x00092d18 addu r2,r5,r7
0x00092d1c slt r2,r3,r2
0x00092d20 bne r2,r0,0x00092d78
0x00092d24 nop
0x00092d28 lh r3,0x0002(r16)
0x00092d2c lh r4,0x0004(r4)
0x00092d30 nop
0x00092d34 slt r2,r4,r3
0x00092d38 bne r2,r0,0x00092d78
0x00092d3c nop
0x00092d40 lh r6,0x0006(r16)
0x00092d44 nop
0x00092d48 addu r2,r3,r6
0x00092d4c slt r2,r4,r2
0x00092d50 bne r2,r0,0x00092d78
0x00092d54 nop
0x00092d58 blez r5,0x00092d78
0x00092d5c nop
0x00092d60 bltz r7,0x00092d78
0x00092d64 nop
0x00092d68 bltz r3,0x00092d78
0x00092d6c nop
0x00092d70 bgtz r6,0x00092dc8
0x00092d74 nop
0x00092d78 lui r4,0x8011
0x00092d7c j 0x00092d8c
0x00092d80 addiu r4,r4,0x3e58
0x00092d84 lui r4,0x8011
0x00092d88 addiu r4,r4,0x3e78
0x00092d8c lui r2,0x8011
0x00092d90 lw r2,0x6c50(r2)
0x00092d94 nop
0x00092d98 jalr r2,r31
0x00092d9c addu r5,r8,r0
0x00092da0 lh r5,0x0000(r16)
0x00092da4 lh r6,0x0002(r16)
0x00092da8 lh r7,0x0004(r16)
0x00092dac lh r3,0x0006(r16)
0x00092db0 lui r2,0x8011
0x00092db4 lw r2,0x6c50(r2)
0x00092db8 lui r4,0x8011
0x00092dbc addiu r4,r4,0x3e64
0x00092dc0 jalr r2,r31
0x00092dc4 sw r3,0x0010(r29)
0x00092dc8 lw r31,0x001c(r29)
0x00092dcc lw r16,0x0018(r29)
0x00092dd0 jr r31
0x00092dd4 addiu r29,r29,0x0020