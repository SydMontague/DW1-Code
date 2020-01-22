0x00101160(param) {
  instructionId = load(0x134FE8)  // active instruction
  
  if(instructionId == 0x10) {
    if(0x000FFC1C() == -1)
      return
    
    r3 = load(0x1BE952)
    r2 = load(0x1BE948)
    
    store(0x134FDC, r2 + r3 * 2)
    
    r2 = load(0x134FDC)
    r3 = load(r2)
    r2 = load(0x134FD8)
    store(0x134FDC, r2 + r3)
  }
  else if(instructionId == 0x1A) {
    0x000FFDF4()
  }
  else if(instructionId == 0x64)  {
    r2 = load(0x135008)
    if(r2 != 1) {
      if(0x000FFDF4() != 1)
        return
      
      r2 = load(0x135014)
      store(0x135008, 0)
      store(0x134FFA, r2)
      store(0x134FE8, 100)
    }
    else if(r2 != 2) {
      if(0x000FFC1C() == -1)
        return
      
      r3 = load(0x1BE952)
      r2 = load(0x135014)
      store(0x135008, 0)
      store(0x134FFA, r2 + r3)
      store(0x134FE8, 100)
    }
    else if(r2 != 3) {
      if(0x0000FFF24() != 1)
        return
      
      store(0x134FE8, 100)
      store(0x135008, 0)
    }
  }
}

0x00101160 lbu r2,-0x6b44(r28)
0x00101164 addiu r29,r29,0xffe8
0x00101168 sw r31,0x0010(r29)
0x0010116c addiu r1,r0,0x0010
0x00101170 bne r2,r1,0x001011c8
0x00101174 addu r3,r2,r0
0x00101178 jal 0x000ffc1c
0x0010117c nop
0x00101180 ori r1,r0,0xffff
0x00101184 beq r2,r1,0x001012ac
0x00101188 nop
0x0010118c lui r1,0x801c
0x00101190 lhu r3,-0x16ae(r1)
0x00101194 lui r1,0x801c
0x00101198 lw r2,-0x16b8(r1)
0x0010119c sll r3,r3,0x01
0x001011a0 addu r2,r2,r3
0x001011a4 sw r2,-0x6b50(r28)
0x001011a8 lw r2,-0x6b50(r28)
0x001011ac nop
0x001011b0 lhu r3,0x0000(r2)
0x001011b4 lw r2,-0x6b54(r28)
0x001011b8 nop
0x001011bc addu r2,r2,r3
0x001011c0 beq r0,r0,0x001012ac
0x001011c4 sw r2,-0x6b50(r28)
0x001011c8 addiu r1,r0,0x001a
0x001011cc bne r3,r1,0x001011e4
0x001011d0 nop
0x001011d4 jal 0x000ffdf4
0x001011d8 nop
0x001011dc beq r0,r0,0x001012b0
0x001011e0 lw r31,0x0010(r29)
0x001011e4 addiu r1,r0,0x0064
0x001011e8 bne r3,r1,0x001012ac
0x001011ec nop
0x001011f0 lbu r2,-0x6b24(r28)
0x001011f4 addiu r1,r0,0x0003
0x001011f8 beq r2,r1,0x0010128c
0x001011fc nop
0x00101200 addiu r1,r0,0x0002
0x00101204 beq r2,r1,0x00101254
0x00101208 nop
0x0010120c addiu r1,r0,0x0001
0x00101210 beq r2,r1,0x00101228
0x00101214 nop
0x00101218 beq r2,r0,0x001012ac
0x0010121c nop
0x00101220 beq r0,r0,0x001012b0
0x00101224 lw r31,0x0010(r29)
0x00101228 jal 0x000ffdf4
0x0010122c nop
0x00101230 addiu r1,r0,0x0001
0x00101234 bne r2,r1,0x001012ac
0x00101238 nop
0x0010123c lhu r2,-0x6b18(r28)
0x00101240 sb r0,-0x6b24(r28)
0x00101244 sh r2,-0x6b32(r28)
0x00101248 addiu r2,r0,0x0064
0x0010124c beq r0,r0,0x001012ac
0x00101250 sb r2,-0x6b44(r28)
0x00101254 jal 0x000ffc1c
0x00101258 nop
0x0010125c ori r1,r0,0xffff
0x00101260 beq r2,r1,0x001012ac
0x00101264 nop
0x00101268 lui r1,0x801c
0x0010126c lhu r3,-0x16ae(r1)
0x00101270 lhu r2,-0x6b18(r28)
0x00101274 sb r0,-0x6b24(r28)
0x00101278 add r2,r2,r3
0x0010127c sh r2,-0x6b32(r28)
0x00101280 addiu r2,r0,0x0064
0x00101284 beq r0,r0,0x001012ac
0x00101288 sb r2,-0x6b44(r28)
0x0010128c jal 0x000fff24
0x00101290 nop
0x00101294 addiu r1,r0,0x0001
0x00101298 bne r2,r1,0x001012ac
0x0010129c nop
0x001012a0 addiu r2,r0,0x0064
0x001012a4 sb r2,-0x6b44(r28)
0x001012a8 sb r0,-0x6b24(r28)
0x001012ac lw r31,0x0010(r29)
0x001012b0 nop
0x001012b4 jr r31
0x001012b8 addiu r29,r29,0x0018