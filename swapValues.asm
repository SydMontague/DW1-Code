void swapValues(valPtr1, valPtr2) {
  tmp = load(valPtr1)
  store(valPtr1, load(valPtr2))
  store(valPtr2, tmp)
}

0x000e52c0 lw r3,0x0000(r4)
0x000e52c4 lw r2,0x0000(r5)
0x000e52c8 nop
0x000e52cc sw r2,0x0000(r4)
0x000e52d0 jr r31
0x000e52d4 sw r3,0x0000(r5)