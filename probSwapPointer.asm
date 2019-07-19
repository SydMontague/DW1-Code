probSwapPointer(ptr1, ptr2) {
  val1Pt1 = load(ptr2) & 0xFF000000
  val1Pt2 = load(ptr1) & 0x00FFFFFF
  
  val2Pt1 = ptr2       & 0x00FFFFFF
  val2Pt2 = load(ptr1) & 0xFF000000
  
  store(ptr2, val1Pt1 | val1Pt2)
  store(ptr1, val2Pt2 | val2Pt1)
}

0x00092ad4 lui r6,0x00ff
0x00092ad8 ori r6,r6,0xffff
0x00092adc lui r7,0xff00
0x00092ae0 lw r3,0x0000(r5)
0x00092ae4 lw r2,0x0000(r4)
0x00092ae8 and r3,r3,r7
0x00092aec and r2,r2,r6
0x00092af0 or r3,r3,r2
0x00092af4 sw r3,0x0000(r5)
0x00092af8 lw r2,0x0000(r4)
0x00092afc and r5,r5,r6
0x00092b00 and r2,r2,r7
0x00092b04 or r2,r2,r5
0x00092b08 jr r31
0x00092b0c sw r2,0x0000(r4)