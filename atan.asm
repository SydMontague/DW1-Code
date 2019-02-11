int atan(diffY, diffX) {
  if(diffY < 0)
    orientation = diffX < 0 ? 2 : 1
  else
    orientation = diffX < 0 ? 3 : 0
  
  if(diffY < 0)
    diffY = -diffY
  if(diffX < 0)
    diffX = -diffX
  
  if(diffY >= diffX) {
    lookupId = diffX * 512 / diffY
    
    if(lookupId >= 0x200)
      lookupId = 511
    
    // approx f(x)=((-x-256)/37.5)^2+46.5
    angle = load(0x11FA1C + lookupId * 2) 
  }
  else {
    lookupId = diffY * 512 / diffX
    
    if(lookupId >= 0x200)
      lookupId = 511
      
    // approx f(x)=((-x-256)/37.5)^2+46.5
    angle = 1023 - load(0x11FA1C + lookupId * 2) 
  }
  
  if(orientation == 1 || orientation == 2)
    angle = 2048 - angle
  
  if(orientation >= 2)
    angle = -angle
  
  return (angle + 2048) & 0x0FFF
}

0x000a37fc bgez r4,0x000a381c
0x000a3800 nop
0x000a3804 bgez r5,0x000a3814
0x000a3808 nop
0x000a380c beq r0,r0,0x000a382c
0x000a3810 addiu r2,r0,0x0002
0x000a3814 beq r0,r0,0x000a382c
0x000a3818 addiu r2,r0,0x0001
0x000a381c bgez r5,0x000a382c
0x000a3820 addu r2,r0,r0
0x000a3824 beq r0,r0,0x000a382c
0x000a3828 addiu r2,r0,0x0003
0x000a382c bgez r4,0x000a383c
0x000a3830 nop
0x000a3834 beq r0,r0,0x000a383c
0x000a3838 sub r4,r0,r4
0x000a383c bgez r5,0x000a384c
0x000a3840 nop
0x000a3844 beq r0,r0,0x000a384c
0x000a3848 sub r5,r0,r5
0x000a384c slt r1,r4,r5
0x000a3850 bne r1,r0,0x000a38a0
0x000a3854 nop
0x000a3858 blez r4,0x000a3870
0x000a385c sll r5,r5,0x09
0x000a3860 div r5,r4
0x000a3864 mflo r3
0x000a3868 beq r0,r0,0x000a3874
0x000a386c nop
0x000a3870 addu r3,r0,r0
0x000a3874 slti r1,r3,0x0200
0x000a3878 bne r1,r0,0x000a3884
0x000a387c nop
0x000a3880 addiu r3,r0,0x01ff
0x000a3884 sll r4,r3,0x01
0x000a3888 lui r3,0x8012
0x000a388c addiu r3,r3,0xfa1c
0x000a3890 addu r3,r3,r4
0x000a3894 lh r4,0x0000(r3)
0x000a3898 beq r0,r0,0x000a38ec
0x000a389c addiu r1,r0,0x0001
0x000a38a0 blez r5,0x000a38b8
0x000a38a4 sll r4,r4,0x09
0x000a38a8 div r4,r5
0x000a38ac mflo r3
0x000a38b0 beq r0,r0,0x000a38bc
0x000a38b4 nop
0x000a38b8 addu r3,r0,r0
0x000a38bc slti r1,r3,0x0200
0x000a38c0 bne r1,r0,0x000a38cc
0x000a38c4 nop
0x000a38c8 addiu r3,r0,0x01ff
0x000a38cc sll r4,r3,0x01
0x000a38d0 lui r3,0x8012
0x000a38d4 addiu r3,r3,0xfa1c
0x000a38d8 addu r3,r3,r4
0x000a38dc lh r4,0x0000(r3)
0x000a38e0 addiu r3,r0,0x03ff
0x000a38e4 sub r4,r3,r4
0x000a38e8 addiu r1,r0,0x0001
0x000a38ec beq r2,r1,0x000a3900
0x000a38f0 nop
0x000a38f4 addiu r1,r0,0x0002
0x000a38f8 bne r2,r1,0x000a3908
0x000a38fc nop
0x000a3900 addiu r3,r0,0x0800
0x000a3904 sub r4,r3,r4
0x000a3908 slti r1,r2,0x0002
0x000a390c bne r1,r0,0x000a3918
0x000a3910 nop
0x000a3914 sub r4,r0,r4
0x000a3918 addi r2,r4,0x0800
0x000a391c jr r31
0x000a3920 andi r2,r2,0x0fff