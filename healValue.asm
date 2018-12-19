void healValue(int valueAddress, int amount, int upperLimit) {

  newValue = load(valueAddress) + amount
  store(valueAddress, newValue)

  if(upperLimit < newValue)
    store(valueAddress, upperLimit)
}

0x000c563c lh r2,0x0000(r4)
0x000c5640 nop
0x000c5644 add r2,r2,r5
0x000c5648 sh r2,0x0000(r4)
0x000c564c lh r2,0x0000(r4)
0x000c5650 nop
0x000c5654 slt r1,r6,r2
0x000c5658 beq r1,r0,0x000c5664
0x000c565c nop
0x000c5660 sh r6,0x0000(r4)
0x000c5664 jr r31
0x000c5668 nop