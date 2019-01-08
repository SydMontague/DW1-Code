void checkGPUTimeout() { // check GPU timeout
  frameCount = vsync(-1)
  targetFrame = load(0x116C3C)
  
  if(targetFrame < frameCount) {
    r4 = load(0x116C40)
    store(0x116C40, r4 + 1)
    
    if(0xF0000 >= r4)
      return 0
  }
  
  gpuStatusPtr = load(0x116C10) // 0x1F801814, GPU Status Register
  gpuStatus = load(gpuStatusPtr)
  
  dmaBaseAdrPtr = load(0x116C14) // 0x1F8010A0, DMA2 channel 2 GPU, DMA base address
  dmaBaseAdr = load(dmaBaseAdrPtr)
  
  queValue = load(0x116CD4) - load(0x116CD8)
  
  dmaChanControlPtr = load(0x116C1C) // 0x1F8010A8, DMA 2 channel 2 GPU, DMA Channel Control
  dmaChanControl = load(dmaChanControlPtr)
  
  printf(0x113F48, queValue & 0x3F, gpuStatus, dmaChanControl, dmaBaseAdr) // "GPU timeout:que=%d,stat=%08x,chcr=%08x,madr=%08x,"
  oldIRQMask = setIRQMask(0)
  
  store(0x116C38, oldIRQMask)
  
  store(0x116CD8, 0)
  store(0x116CD4, load(0x116CD8)) // set to 0 as well?
  
  store(dmaChanControlPtr, 0x0401) // DMA Control, read Linked List from Main RAM
  
  dmaControlRegPtr = load(0x116C2C) // 0x1F8010F0, DMA Control Register
  store(dmaControlRegPtr, load(dmaControlRegPtr) | 0x0800) // set GPU Master Enable
  
  gp1DisplayControlPtr = load(0x116C10)
  store(gp1DisplayControlPtr, 0x02000000) // ack GPU IRQ
  store(gp1DisplayControlPtr, 0x01000000) // reset GPU command buffer
  
  setIRQMask(load(0x116C38))
  
  return -1
}

0x000942fc addiu r29,r29,0xffe0
0x00094300 sw r31,0x0018(r29)
0x00094304 jal 0x00091ca8
0x00094308 addiu r4,r0,0xffff
0x0009430c lui r3,0x8011
0x00094310 lw r3,0x6c3c(r3)
0x00094314 nop
0x00094318 slt r3,r3,r2
0x0009431c bne r3,r0,0x00094350
0x00094320 nop
0x00094324 lui r3,0x8011
0x00094328 addiu r3,r3,0x6c40
0x0009432c lw r2,0x0000(r3)
0x00094330 nop
0x00094334 addu r4,r2,r0
0x00094338 addiu r2,r2,0x0001
0x0009433c sw r2,0x0000(r3)
0x00094340 lui r2,0x000f
0x00094344 slt r2,r2,r4
0x00094348 beq r2,r0,0x0009442c
0x0009434c nop
0x00094350 lui r6,0x8011
0x00094354 lw r6,0x6c10(r6)
0x00094358 lui r4,0x8011
0x0009435c addiu r4,r4,0x3f48
0x00094360 lw r2,0x0000(r6)
0x00094364 lui r5,0x8011
0x00094368 lw r5,0x6cd4(r5)
0x0009436c lui r2,0x8011
0x00094370 lw r2,0x6c14(r2)
0x00094374 lui r3,0x8011
0x00094378 lw r3,0x6cd8(r3)
0x0009437c lw r2,0x0000(r2)
0x00094380 subu r5,r5,r3
0x00094384 sw r2,0x0010(r29)
0x00094388 lui r2,0x8011
0x0009438c lw r2,0x6c1c(r2)
0x00094390 lw r6,0x0000(r6)
0x00094394 lw r7,0x0000(r2)
0x00094398 jal 0x0009128c
0x0009439c andi r5,r5,0x003f
0x000943a0 jal 0x00092450
0x000943a4 addu r4,r0,r0
0x000943a8 lui r1,0x8011
0x000943ac sw r0,0x6cd8(r1)
0x000943b0 lui r3,0x8011
0x000943b4 lw r3,0x6cd8(r3)
0x000943b8 lui r1,0x8011
0x000943bc sw r2,0x6c38(r1)
0x000943c0 lui r1,0x8011
0x000943c4 sw r3,0x6cd4(r1)
0x000943c8 lui r3,0x8011
0x000943cc lw r3,0x6c1c(r3)
0x000943d0 addiu r2,r0,0x0401
0x000943d4 sw r2,0x0000(r3)
0x000943d8 lui r3,0x8011
0x000943dc lw r3,0x6c2c(r3)
0x000943e0 nop
0x000943e4 lw r2,0x0000(r3)
0x000943e8 nop
0x000943ec ori r2,r2,0x0800
0x000943f0 sw r2,0x0000(r3)
0x000943f4 lui r3,0x8011
0x000943f8 lw r3,0x6c10(r3)
0x000943fc lui r2,0x0200
0x00094400 sw r2,0x0000(r3)
0x00094404 lui r3,0x8011
0x00094408 lw r3,0x6c10(r3)
0x0009440c lui r2,0x0100
0x00094410 sw r2,0x0000(r3)
0x00094414 lui r4,0x8011
0x00094418 lw r4,0x6c38(r4)
0x0009441c jal 0x00092450
0x00094420 nop
0x00094424 j 0x00094430
0x00094428 addiu r2,r0,0xffff
0x0009442c addu r2,r0,r0
0x00094430 lw r31,0x0018(r29)
0x00094434 addiu r29,r29,0x0020
0x00094438 jr r31
0x0009443c nop