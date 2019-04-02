void unsetTrigger(triggerId) {
  triggerAddress, triggerFlag = getTriggerOffsets(triggerId)
  
  newTriggerValue = load(triggerAddress) & ~triggerFlag
  store(triggerAddress, newTriggerValue)
}

0x001065fc addiu r29,r29,0xffe0
0x00106600 sw r31,0x0010(r29)
0x00106604 addiu r5,r29,0x0018
0x00106608 jal 0x00106ca8
0x0010660c addiu r6,r29,0x001f
0x00106610 lw r4,0x0018(r29)
0x00106614 lbu r2,0x001f(r29)
0x00106618 lbu r3,0x0000(r4)
0x0010661c nor r2,r2,r0
0x00106620 and r2,r3,r2
0x00106624 sb r2,0x0000(r4)
0x00106628 lw r31,0x0010(r29)
0x0010662c nop
0x00106630 jr r31
0x00106634 addiu r29,r29,0x0020