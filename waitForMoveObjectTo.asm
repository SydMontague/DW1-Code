int waitForMoveObjectTo(id, otherId, duration, targetPosX, targetPosY) {
  if(load(0x13C038 + otherId * 4) == 0) {
    store(0x13CB38 + otherId, (targetPosX - load(0x14F342 + id * 34)) / duration)
    store(0x13CB44 + otherId, (targetPosY - load(0x14F344 + id * 34)) / duration)
    
    store(0x13C038 + otherId * 4, 1)
  }
  
  xVel = load(0x13CB38 + otherId)
  yVel = load(0x13CB44 + otherId)
  
  xPosPtr = 0x14F342 + id * 34
  yPosPtr = 0x14F344 + id * 34
  
  store(xPosPtr, load(xPosPtr) + xVel)
  store(yPosPtr, load(yPosPtr) + yVel)
  
  if(xVel > 0) {
    if(load(xPosPtr) >= targetPosX)
      store(xPosPtr, targetPosX)
  }
  else if(xVel < 0) {
    if(targetPosX >= load(xPosPtr))
      store(xPosPtr, targetPosX)
  }
  else
    store(xPosPtr, targetPosX)
  
  if(yVel > 0) {
    if(load(yPosPtr) >= targetPosY)
      store(yPosPtr, targetPosY)
  }
  else if(yVel < 0) {
    if(targetPosY >= load(yPosPtr))
      store(yPosPtr, targetPosY)
  }
  else
    store(yPosPtr, targetPosY)
  
  if(load(xPosPtr) != targetPosX || load(yPosPtr) != targetPosY)
    return 0
  
  store(0x13C038 + otherId * 4, 0)
  return 1
}

0x000b56f4 lui r10,0x8014
0x000b56f8 addu r8,r5,r0
0x000b56fc sll r3,r5,0x02
0x000b5700 addu r5,r3,r0
0x000b5704 addiu r10,r10,0xc038
0x000b5708 addu r3,r10,r3
0x000b570c lh r2,0x0010(r29)
0x000b5710 lw r9,0x0000(r3)
0x000b5714 nop
0x000b5718 bne r9,r0,0x000b5798
0x000b571c nop
0x000b5720 sll r9,r4,0x04
0x000b5724 add r9,r9,r4
0x000b5728 sll r10,r9,0x01
0x000b572c lui r9,0x8015
0x000b5730 addiu r9,r9,0xf342
0x000b5734 addu r9,r9,r10
0x000b5738 lh r9,0x0000(r9)
0x000b573c addu r11,r10,r0
0x000b5740 sub r9,r7,r9
0x000b5744 div r9,r6
0x000b5748 addu r10,r6,r0
0x000b574c lui r6,0x8014
0x000b5750 addiu r6,r6,0xcb38
0x000b5754 mflo r9
0x000b5758 addu r6,r6,r8
0x000b575c sb r9,0x0000(r6)
0x000b5760 lui r6,0x8015
0x000b5764 addiu r6,r6,0xf344
0x000b5768 addu r6,r6,r11
0x000b576c lh r6,0x0000(r6)
0x000b5770 nop
0x000b5774 sub r6,r2,r6
0x000b5778 div r6,r10
0x000b577c lui r6,0x8014
0x000b5780 addiu r6,r6,0xcb44
0x000b5784 mflo r9
0x000b5788 addu r6,r6,r8
0x000b578c sb r9,0x0000(r6)
0x000b5790 addiu r6,r0,0x0001
0x000b5794 sw r6,0x0000(r3)
0x000b5798 lui r3,0x8014
0x000b579c addiu r3,r3,0xcb38
0x000b57a0 addu r3,r3,r8
0x000b57a4 lb r11,0x0000(r3)
0x000b57a8 sll r3,r4,0x04
0x000b57ac add r3,r3,r4
0x000b57b0 sll r3,r3,0x01
0x000b57b4 lui r4,0x8015
0x000b57b8 addu r6,r3,r0
0x000b57bc addiu r4,r4,0xf342
0x000b57c0 addu r3,r4,r3
0x000b57c4 lh r10,0x0000(r3)
0x000b57c8 addu r9,r11,r0
0x000b57cc add r10,r10,r11
0x000b57d0 sh r10,0x0000(r3)
0x000b57d4 lui r10,0x8014
0x000b57d8 addiu r10,r10,0xcb44
0x000b57dc addu r8,r10,r8
0x000b57e0 lb r11,0x0000(r8)
0x000b57e4 lui r8,0x8015
0x000b57e8 addiu r8,r8,0xf344
0x000b57ec addu r10,r8,r6
0x000b57f0 lh r8,0x0000(r10)
0x000b57f4 addu r12,r11,r0
0x000b57f8 add r8,r8,r11
0x000b57fc blez r9,0x000b5824
0x000b5800 sh r8,0x0000(r10)
0x000b5804 addu r8,r3,r0
0x000b5808 lh r8,0x0000(r8)
0x000b580c nop
0x000b5810 slt r1,r8,r7
0x000b5814 bne r1,r0,0x000b5850
0x000b5818 nop
0x000b581c beq r0,r0,0x000b5850
0x000b5820 sh r7,0x0000(r3)
0x000b5824 bgez r9,0x000b584c
0x000b5828 nop
0x000b582c addu r8,r3,r0
0x000b5830 lh r8,0x0000(r8)
0x000b5834 nop
0x000b5838 slt r1,r7,r8
0x000b583c bne r1,r0,0x000b5850
0x000b5840 nop
0x000b5844 beq r0,r0,0x000b5850
0x000b5848 sh r7,0x0000(r3)
0x000b584c sh r7,0x0000(r3)
0x000b5850 blez r12,0x000b5880
0x000b5854 nop
0x000b5858 lui r8,0x8015
0x000b585c addiu r8,r8,0xf344
0x000b5860 addu r4,r8,r6
0x000b5864 lh r3,0x0000(r4)
0x000b5868 nop
0x000b586c slt r1,r3,r2
0x000b5870 bne r1,r0,0x000b58c0
0x000b5874 nop
0x000b5878 beq r0,r0,0x000b58c0
0x000b587c sh r2,0x0000(r4)
0x000b5880 bgez r12,0x000b58b0
0x000b5884 nop
0x000b5888 lui r8,0x8015
0x000b588c addiu r8,r8,0xf344
0x000b5890 addu r4,r8,r6
0x000b5894 lh r3,0x0000(r4)
0x000b5898 nop
0x000b589c slt r1,r2,r3
0x000b58a0 bne r1,r0,0x000b58c0
0x000b58a4 nop
0x000b58a8 beq r0,r0,0x000b58c0
0x000b58ac sh r2,0x0000(r4)
0x000b58b0 lui r3,0x8015
0x000b58b4 addiu r3,r3,0xf344
0x000b58b8 addu r3,r3,r6
0x000b58bc sh r2,0x0000(r3)
0x000b58c0 lui r3,0x8015
0x000b58c4 addiu r3,r3,0xf342
0x000b58c8 addu r3,r3,r6
0x000b58cc lh r3,0x0000(r3)
0x000b58d0 nop
0x000b58d4 bne r3,r7,0x000b5910
0x000b58d8 nop
0x000b58dc lui r3,0x8015
0x000b58e0 addiu r3,r3,0xf344
0x000b58e4 addu r3,r3,r6
0x000b58e8 lh r3,0x0000(r3)
0x000b58ec nop
0x000b58f0 bne r3,r2,0x000b5910
0x000b58f4 nop
0x000b58f8 lui r2,0x8014
0x000b58fc addiu r2,r2,0xc038
0x000b5900 addu r2,r2,r5
0x000b5904 sw r0,0x0000(r2)
0x000b5908 beq r0,r0,0x000b5914
0x000b590c addiu r2,r0,0x0001
0x000b5910 addu r2,r0,r0
0x000b5914 jr r31
0x000b5918 nop