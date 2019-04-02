int isTileWithinScreenArea(tileX, tileY) {
  xPos = (tileX - 50) * 100 + 50
  yPos = 0
  zPos = (50 - tileY) * 100 - 50
  
  // perspective transformation, done on GTE, using gte_registers
  ir1 = (gte_trx * 0x1000 + gte_rt11 * xPos + gte_rt12 * yPos + gte_rt13 * zPos) >> 12
  ir2 = (gte_try * 0x1000 + gte_rt21 * xPos + gte_rt22 * yPos + gte_rt23 * zPos) >> 12
  ir3 = (gte_trz * 0x1000 + gte_rt31 * xPos + gte_rt32 * yPos + gte_rt33 * zPos) >> 12
  
  sx2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir1 + gte_cr24) / 0x10000
  sy2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir2 + gte_cr25) / 0x10000
  
  sx2 = sx2 - 160 + load(0x134EC0) // x center
  sy2 = sy2 - 120 + load(0x134EC4) // y center
  
  if(sx2 < -200 || sx2 > 200 || sy2 < -160 || sy2 > 160)
    return 1
  
  return 0
}

0x000d3078 addi r3,r4,-0x0032
0x000d307c sll r2,r3,0x02
0x000d3080 add r3,r2,r3
0x000d3084 sll r2,r3,0x02
0x000d3088 add r2,r3,r2
0x000d308c sll r2,r2,0x02
0x000d3090 addiu r29,r29,0xfff0
0x000d3094 addi r2,r2,0x0032
0x000d3098 sh r2,0x0008(r29)
0x000d309c addiu r2,r0,0x0032
0x000d30a0 sub r3,r2,r5
0x000d30a4 sll r2,r3,0x02
0x000d30a8 add r3,r2,r3
0x000d30ac sll r2,r3,0x02
0x000d30b0 add r2,r3,r2
0x000d30b4 sll r2,r2,0x02
0x000d30b8 sh r0,0x000a(r29)
0x000d30bc addi r2,r2,-0x0032
0x000d30c0 sh r2,0x000c(r29)
0x000d30c4 addiu r4,r29,0x0008
0x000d30c8 lwc2 gtedr00_vxy0,0x0000(r4)
0x000d30cc lwc2 gtedr01_vz0,0x0004(r4)
0x000d30d0 nop
0x000d30d4 nop
0x000d30d8 rtps
0x000d30dc addiu r4,r29,0x0004
0x000d30e0 swc2 gtedr14_sxy2,0x0000(r4)
0x000d30e4 lw r2,-0x6c6c(r28)
0x000d30e8 addiu r3,r0,0x00a0
0x000d30ec sub r3,r3,r2
0x000d30f0 sll r3,r3,0x10
0x000d30f4 lh r2,0x0004(r29)
0x000d30f8 sra r3,r3,0x10
0x000d30fc sub r2,r2,r3
0x000d3100 sh r2,0x0004(r29)
0x000d3104 lw r2,-0x6c68(r28)
0x000d3108 addiu r3,r0,0x0078
0x000d310c sub r3,r3,r2
0x000d3110 sll r3,r3,0x10
0x000d3114 lh r2,0x0006(r29)
0x000d3118 sra r3,r3,0x10
0x000d311c sub r2,r2,r3
0x000d3120 sh r2,0x0006(r29)
0x000d3124 lh r2,0x0004(r29)
0x000d3128 nop
0x000d312c slti r1,r2,-0x00c8
0x000d3130 bne r1,r0,0x000d3164
0x000d3134 nop
0x000d3138 slti r1,r2,0x00c9
0x000d313c beq r1,r0,0x000d3164
0x000d3140 nop
0x000d3144 lh r2,0x0006(r29)
0x000d3148 nop
0x000d314c slti r1,r2,-0x00a0
0x000d3150 bne r1,r0,0x000d3164
0x000d3154 addu r3,r2,r0
0x000d3158 slti r1,r3,0x00a1
0x000d315c bne r1,r0,0x000d316c
0x000d3160 addu r2,r0,r0
0x000d3164 beq r0,r0,0x000d316c
0x000d3168 addiu r2,r0,0x0001
0x000d316c jr r31
0x000d3170 addiu r29,r29,0x0010