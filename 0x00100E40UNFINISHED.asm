0x00100E40(r4) {
  r4 = 0x1BE80C + 0x04 + r4 * 52
  
  if(load(r4 + 0x17) == 0)
    return 0
    
  if(load(r4 + 0x14) == 0)
    return 1
  
  r2 = load(r4 + 0x12)
  
  if(load(r4 + 0x11) != r2)
    return 1
  
  if(load(r4 + 0x16) == 0)
    return 0
  
  if(r2 == 0)
    return 1
    
  store(r4 + 0x13, load(r4 + 0x13) + 1)
  store(r4 + 0x16, 0)
  store(r4 + 0x18, load(r4 + 0x18) ^ 1)
  
  if(load(r4 + 0x15) == 0)
    store(0x134FE8, 0)
  
  store(0x135012, 0)
  return 1
}

0x00100e40 sll r2,r4,0x01
0x00100e44 add r2,r2,r4
0x00100e48 sll r2,r2,0x02
0x00100e4c add r2,r2,r4
0x00100e50 sll r3,r2,0x02
0x00100e54 lui r2,0x801c
0x00100e58 addiu r2,r2,0xe80c
0x00100e5c addu r2,r2,r3
0x00100e60 addiu r4,r2,0x0004
0x00100e64 lbu r2,0x0017(r4)
0x00100e68 nop
0x00100e6c bne r2,r0,0x00100e7c
0x00100e70 nop
0x00100e74 beq r0,r0,0x00100f18
0x00100e78 addu r2,r0,r0
0x00100e7c lbu r2,0x0014(r4)
0x00100e80 nop
0x00100e84 bne r2,r0,0x00100e94
0x00100e88 nop
0x00100e8c beq r0,r0,0x00100f18
0x00100e90 addiu r2,r0,0x0001
0x00100e94 lbu r2,0x0012(r4)
0x00100e98 lbu r3,0x0011(r4)
0x00100e9c nop
0x00100ea0 beq r3,r2,0x00100eb0
0x00100ea4 addu r5,r2,r0
0x00100ea8 beq r0,r0,0x00100f18
0x00100eac addiu r2,r0,0x0001
0x00100eb0 lbu r2,0x0016(r4)
0x00100eb4 nop
0x00100eb8 bne r2,r0,0x00100ec8
0x00100ebc nop
0x00100ec0 beq r0,r0,0x00100f18
0x00100ec4 addu r2,r0,r0
0x00100ec8 bne r5,r0,0x00100ed8
0x00100ecc nop
0x00100ed0 beq r0,r0,0x00100f18
0x00100ed4 addiu r2,r0,0x0001
0x00100ed8 sb r0,0x0016(r4)
0x00100edc lw r2,0x0018(r4)
0x00100ee0 nop
0x00100ee4 xori r2,r2,0x0001
0x00100ee8 sw r2,0x0018(r4)
0x00100eec lbu r2,0x0013(r4)
0x00100ef0 nop
0x00100ef4 addiu r2,r2,0x0001
0x00100ef8 sb r2,0x0013(r4)
0x00100efc lbu r2,0x0015(r4)
0x00100f00 nop
0x00100f04 bne r2,r0,0x00100f10
0x00100f08 nop
0x00100f0c sb r0,-0x6b44(r28)
0x00100f10 sb r0,-0x6b1a(r28)
0x00100f14 addiu r2,r0,0x0001
0x00100f18 jr r31
0x00100f1c nop