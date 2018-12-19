/**
 * Returns two values to an address each defined by input parameter r5 and r6, 
 * typically (stack + 0x18) and (stack + 0x1F).
 */
int, int getTriggerOffsets(int triggerId) {
  
  targetBit = triggerId & 7
  
  if(triggerId < 0 && targetBit != 0)
    targetBit -= 8
  
  targetBit &= 0xFF
  
  if(triggerId < 0)
    triggerId += 7
  
  targetByte = triggerId / 8
  
  triggerAddress = load(0x134FB8) + 0xF5 + targetByte // trigger byte
  triggerFlag = 1 << targetBit
  
  return triggerAddress, triggerFlag
}

0x00106ca8 addu r7,r4,r0
0x00106cac bgez r4,0x00106cc0
0x00106cb0 andi r2,r4,0x0007
0x00106cb4 beq r2,r0,0x00106cc0
0x00106cb8 nop
0x00106cbc addiu r2,r2,0xfff8
0x00106cc0 andi r3,r2,0x00ff
0x00106cc4 bgez r7,0x00106cd4
0x00106cc8 sra r25,r7,0x03
0x00106ccc addiu r2,r7,0x0007
0x00106cd0 sra r25,r2,0x03
0x00106cd4 lw r2,-0x6b74(r28)
0x00106cd8 nop
0x00106cdc addu r2,r2,r25
0x00106ce0 addiu r2,r2,0x00f5
0x00106ce4 sw r2,0x0000(r5)
0x00106ce8 addiu r2,r0,0x0001
0x00106cec beq r0,r0,0x00106d0c
0x00106cf0 sb r2,0x0000(r6)
0x00106cf4 lbu r2,0x0000(r6)
0x00106cf8 nop
0x00106cfc sll r2,r2,0x01
0x00106d00 sb r2,0x0000(r6)
0x00106d04 addiu r2,r3,0xffff
0x00106d08 andi r3,r2,0x00ff
0x00106d0c bne r3,r0,0x00106cf4
0x00106d10 nop
0x00106d14 jr r31
0x00106d18 nop