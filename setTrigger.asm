void setTrigger(triggerId) {
  triggerAddress, triggerMask = getTriggerOffsets(triggerId)
  
  newTriggerValue = load(triggerOffset) | triggerMask
  store(triggerOffset, newTriggerValue)
}

0x001065c0 addiu r29,r29,0xffe0
0x001065c4 sw r31,0x0010(r29)
0x001065c8 addiu r5,r29,0x0018
0x001065cc jal 0x00106ca8
0x001065d0 addiu r6,r29,0x001f
0x001065d4 lw r4,0x0018(r29)
0x001065d8 lbu r2,0x001f(r29)
0x001065dc lbu r3,0x0000(r4)
0x001065e0 nop
0x001065e4 or r2,r3,r2
0x001065e8 sb r2,0x0000(r4)
0x001065ec lw r31,0x0010(r29)
0x001065f0 nop
0x001065f4 jr r31
0x001065f8 addiu r29,r29,0x0020