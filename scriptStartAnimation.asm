void scriptStartAnimation(scriptId, animationId) {
  if(scriptId == 253) {
    startAnimation(0x15576C, animationId) // deferred via 0x000AC05C
    setMenuState(10)
  }
  else if(scriptId == 252) {
    startAnimation(0x1557A8, animationid) // deferred via 0x000DF5E4
    setDigimonState(12)
  }
  else {
    scriptNPCStartAnimation(scriptId, animationId)
    0x000B7848(12, r5) // passing r5, which is undefined!
  }
}

0x001054e4 addiu r29,r29,0xffe8
0x001054e8 sw r31,0x0010(r29)
0x001054ec addu r3,r4,r0
0x001054f0 addiu r1,r0,0x00fd
0x001054f4 bne r3,r1,0x00105514
0x001054f8 addu r2,r5,r0
0x001054fc jal 0x000ac05c
0x00105500 addu r4,r2,r0
0x00105504 jal 0x000aa188
0x00105508 addiu r4,r0,0x000a
0x0010550c beq r0,r0,0x0010554c
0x00105510 lw r31,0x0010(r29)
0x00105514 addiu r1,r0,0x00fc
0x00105518 bne r3,r1,0x00105538
0x0010551c nop
0x00105520 jal 0x000df5e4
0x00105524 addu r4,r2,r0
0x00105528 jal 0x000df4d0
0x0010552c addiu r4,r0,0x000c
0x00105530 beq r0,r0,0x0010554c
0x00105534 lw r31,0x0010(r29)
0x00105538 jal 0x000b78c4
0x0010553c nop
0x00105540 jal 0x000b7848
0x00105544 addiu r4,r0,0x000c
0x00105548 lw r31,0x0010(r29)
0x0010554c nop
0x00105550 jr r31
0x00105554 addiu r29,r29,0x0018