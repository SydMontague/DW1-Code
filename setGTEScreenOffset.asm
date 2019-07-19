void setGTEScreenOffset(offsetX, offsetY) {
  gte_cr24 = offsetX
  gte_cr25 = offsetY
}

0x0009b340 sll r4,r4,0x10
0x0009b344 sll r5,r5,0x10
0x0009b348 ctc2 r4,gtecr24_ofx
0x0009b34c ctc2 r5,gtecr25_ofy
0x0009b350 jr r31
0x0009b354 nop