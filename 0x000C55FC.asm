0x000C55FC() {
  if(load(0x13D4D8) != -1) [
    unsetObject(0x194, 0)
    store(0x13D4D8, -1)
  }
}

0x000c55fc lui r1,0x8014
0x000c5600 lw r2,-0x2b28(r1)
0x000c5604 addiu r29,r29,0xffe8
0x000c5608 addiu r1,r0,0x00ff
0x000c560c beq r2,r1,0x000c562c
0x000c5610 sw r31,0x0010(r29)
0x000c5614 addiu r4,r0,0x0194
0x000c5618 jal 0x000a3008
0x000c561c addu r5,r0,r0
0x000c5620 addiu r2,r0,0x00ff
0x000c5624 lui r1,0x8014
0x000c5628 sw r2,-0x2b28(r1)
0x000c562c lw r31,0x0010(r29)
0x000c5630 nop
0x000c5634 jr r31
0x000c5638 addiu r29,r29,0x0018