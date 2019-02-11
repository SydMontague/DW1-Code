void swapByte(valPtr1, valPtr2) {
  val1 = load(valPtr1)
  val2 = load(valPtr2)
  store(valPtr1, val2)
  store(valPtr2, val1)
}

0x000e5290 lbu r3,0x0000(r4)
0x000e5294 lbu r2,0x0000(r5)
0x000e5298 nop
0x000e529c sb r2,0x0000(r4)
0x000e52a0 jr r31
0x000e52a4 sb r3,0x0000(r5)