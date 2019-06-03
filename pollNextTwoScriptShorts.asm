int, int pollNextTwoScriptShorts() {
  val1 = pollNextScriptShort()
  val2 = pollNextScriptShort()
  
  return val1, val2
}

0x00106a58 addiu r29,r29,0xffe8
0x00106a5c sw r31,0x0010(r29)
0x00106a60 jal 0x00106a30
0x00106a64 addu r3,r5,r0
0x00106a68 jal 0x00106a30
0x00106a6c addu r4,r3,r0
0x00106a70 lw r31,0x0010(r29)
0x00106a74 nop
0x00106a78 jr r31
0x00106a7c addiu r29,r29,0x0018