void loadImage(headerPtr, dataPtr) {
  printRectDebugInfo(0x113E94, headerPtr) // "LoadImage"
  
  somePtr = load(0x116BB4)
  gpuFunctionPtr = load(somePtr + 0x20) // 0x0009355C -> uploadTexture
  
  gpuLoadImage(gpuFunctionPtr, headerPtr, 8, dataPtr) // call load(somePtr + 0x08)
}

0x000948a8 addiu r29,r29,0xffe0
0x000948ac sw r16,0x0010(r29)
0x000948b0 addu r16,r4,r0
0x000948b4 sw r17,0x0014(r29)
0x000948b8 addu r17,r5,r0
0x000948bc lui r4,0x8011
0x000948c0 addiu r4,r4,0x3e94
0x000948c4 sw r31,0x0018(r29)
0x000948c8 jal 0x00092cbc
0x000948cc addu r5,r16,r0
0x000948d0 addu r5,r16,r0
0x000948d4 lui r2,0x8011
0x000948d8 lw r2,0x6bb4(r2)
0x000948dc addiu r6,r0,0x0008
0x000948e0 lw r4,0x0020(r2)
0x000948e4 lw r2,0x0008(r2)
0x000948e8 nop
0x000948ec jalr r2,r31
0x000948f0 addu r7,r17,r0
0x000948f4 lw r31,0x0018(r29)
0x000948f8 lw r17,0x0014(r29)
0x000948fc lw r16,0x0010(r29)
0x00094900 jr r31
0x00094904 addiu r29,r29,0x0020