boolean isTriggerSet(int triggerId) {

  // stack + 0x18 and stack + 0x1F
  triggerAddress, triggerFlag = getTriggerOffsets(triggerId)
  
  return (load(triggerAddress) & triggerFlag) > 0
}

0x0010643c addiu r29,r29,0xffe0
0x00106440 sw r31,0x0010(r29)
0x00106444 addiu r5,r29,0x0018
0x00106448 jal 0x00106ca8
0x0010644c addiu r6,r29,0x001f
0x00106450 lw r2,0x0018(r29)
0x00106454 lw r31,0x0010(r29)
0x00106458 lbu r3,0x0000(r2)
0x0010645c lbu r2,0x001f(r29)
0x00106460 nop
0x00106464 and r2,r3,r2
0x00106468 sltu r2,r0,r2
0x0010646c jr r31
0x00106470 addiu r29,r29,0x0020