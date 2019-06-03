int, int skipOnePollTwoScriptBytes() {
  store(0x134FDC, load(0x134FDC) + 1)
  val1 = pollNextScriptByte()
  val2 = pollNextScriptByte()
  
  return val1, val2
}

0x00106638 lw r2,-0x6b50(r28)
0x0010663c addiu r29,r29,0xffe8
0x00106640 addiu r2,r2,0x0001
0x00106644 sw r31,0x0010(r29)
0x00106648 sw r2,-0x6b50(r28)
0x0010664c jal 0x00106598
0x00106650 addu r3,r5,r0
0x00106654 jal 0x00106598
0x00106658 addu r4,r3,r0
0x0010665c lw r31,0x0010(r29)
0x00106660 nop
0x00106664 jr r31
0x00106668 addiu r29,r29,0x0018