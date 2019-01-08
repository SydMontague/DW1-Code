int proxySetDMAIRQHandler(stringPtr, arrayPtr) {
  r2 = load(0x116AE4) // 0x116AC4
  r2 = load(r2 + 0x04) // 0x00092708
  
  return setDMAIRQHandler(stringPtr, arrayPtr) // called from r2
}

0x000923ac lui r2,0x8011
0x000923b0 lw r2,0x6ae4(r2)
0x000923b4 addiu r29,r29,0xffe8
0x000923b8 sw r31,0x0010(r29)
0x000923bc lw r2,0x0004(r2)
0x000923c0 nop
0x000923c4 jalr r2,r31
0x000923c8 nop
0x000923cc lw r31,0x0010(r29)
0x000923d0 addiu r29,r29,0x0018
0x000923d4 jr r31
0x000923d8 nop