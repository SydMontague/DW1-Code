int, int pollNextTwoScriptBytes() {
  val1 = pollNextScriptByte()
  val2 = pollNextScriptByte()
  
  return val1, val2
}

0x00106694 addiu r29,r29,0xffe8
0x00106698 sw r31,0x0010(r29)
0x0010669c jal 0x00106598
0x001066a0 addu r3,r5,r0
0x001066a4 jal 0x00106598
0x001066a8 addu r4,r3,r0
0x001066ac lw r31,0x0010(r29)
0x001066b0 nop
0x001066b4 jr r31
0x001066b8 addiu r29,r29,0x0018