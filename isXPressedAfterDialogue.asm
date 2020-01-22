int isXPressedAfterDialogue() { // is X still held after entering the dialogue
  if(load(0x135028) == 0) // X has been released
    return 1
  
  if(load(0x134EE4) & 0x40 != 0) // X is still pressed
    return 0
  
  store(0x135028, 0) // set X released
  return 1
}

0x000fc098 lw r2,-0x6b04(r28)
0x000fc09c nop
0x000fc0a0 beq r2,r0,0x000fc0c8
0x000fc0a4 nop
0x000fc0a8 lw r2,-0x6c48(r28)
0x000fc0ac nop
0x000fc0b0 andi r2,r2,0x0040
0x000fc0b4 beq r2,r0,0x000fc0c4
0x000fc0b8 nop
0x000fc0bc beq r0,r0,0x000fc0cc
0x000fc0c0 addu r2,r0,r0
0x000fc0c4 sw r0,-0x6b04(r28)
0x000fc0c8 addiu r2,r0,0x0001
0x000fc0cc jr r31
0x000fc0d0 nop