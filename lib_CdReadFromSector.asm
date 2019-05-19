int lib_CdReadFromSector(sectorCount, loc, targetBuf) {
  CdIntToPos(loc, sp + 0x10)
  CdControl(2, sp + 0x10, 0) // CdlSetloc
  CdRead(sectorCount, targetBuf, 0x80)
  
  return CdReadSync(0, 0) < 1
}

0x000b234c addiu r29,r29,0xffd8
0x000b2350 sw r17,0x001c(r29)
0x000b2354 addu r17,r4,r0
0x000b2358 addu r4,r5,r0
0x000b235c addiu r5,r29,0x0010
0x000b2360 sw r16,0x0018(r29)
0x000b2364 sw r31,0x0020(r29)
0x000b2368 jal 0x000b0450
0x000b236c addu r16,r6,r0
0x000b2370 addiu r4,r0,0x0002
0x000b2374 addiu r5,r29,0x0010
0x000b2378 jal 0x000b0010
0x000b237c addu r6,r0,r0
0x000b2380 addu r4,r17,r0
0x000b2384 addu r5,r16,r0
0x000b2388 jal 0x000b2bb4
0x000b238c addiu r6,r0,0x0080
0x000b2390 addu r4,r0,r0
0x000b2394 jal 0x000b2cb4
0x000b2398 addu r5,r0,r0
0x000b239c sltiu r2,r2,0x0001
0x000b23a0 lw r31,0x0020(r29)
0x000b23a4 lw r17,0x001c(r29)
0x000b23a8 lw r16,0x0018(r29)
0x000b23ac jr r31
0x000b23b0 addiu r29,r29,0x0028
