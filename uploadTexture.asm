int uploadTexture(headerPtr, dataStartPtr) {
  setGPUTimeout()
  
  xSize = load(headerPtr + 4)
  ySize = load(headerPtr + 6)
  
  fbWidth = load(0x116C58)
  fbHeight = load(0x116C5A)
  
  if(xSize >= 0)
    imageWidth = fbWidth < xSize ? fbWidth : xSize
  else
    imageWidth = 0
  
  if(ySize >= 0)
    imageHeight = fbHeight < ySize ? fbHeight : ySize
  else
    imageHeight = 0
  
  store(headerPtr + 4, imageWidth)
  store(headerPtr + 6, imageHeight)
  
  totalPx = imageWidth * imageHeight + 1
  numWords = totalPx / 2
  numBlocks = totalPx / 32
  nonDMAWords = numWords - (numBlocks * 16)
  
  if(numWords <= 0)
    return -1
  
  // IO Mappings
  gp0CmdPtr = load(0x116C0C) // 0x1F801810
  gp1CmdPtr = load(0x116C10) // 0x1F801814
  
  dmaBaseAdr = load(0x116C14) // 0x1F8010A0
  dmaBlockCtrl = load(0x116C18) // 0x1F8010A4
  dmaChanCtrl = load(0x116C1C) // 0x1F8010A8
  
  // load(gp1CmdPtr) -> read GPU status register
  while(load(gp1CmdPtr) & 0x04000000 == 0) // wait till CMD can be received
    if(checkGPUTimeout() != 0)
      return -1
  
  // GPU/DMA Commands
  store(gp1CmdPtr, 0x04000000) // DMA direction: off
  store(gp0CmdPtr, 0x01000000) // reset command buffer
  
  store(gp0CmdPtr, 0xA0000000) // command GP0(0x04): copy rectangle CPU to VRAM
  store(gp0CmdPtr, load(headerPtr)) // destination coords
  store(gp0CmdPtr, load(headerPtr + 4)) // dimensions (2-byte X, 2-byte Y)
  
  while(--nonDMAWords != -1) {
    store(gp0CmdPtr, load(dataStartPtr))
    dataStartPtr = dataStartPtr + 4
  }
  
  if(numBlocks == 0)
    return 0
  
  // setup DMA, transfer data?
  store(gp1CmdPtr, 0x04000002) // DMA direction: CPU to GPU
  store(dmaBaseAdr, dataStartPtr) // DMA start address
  store(dmaBlockCtrl, (numBlocks << 0x10) | 0x0010) // DMA blocksize 0x10, numBlocks is number of blocks
  store(dmaChanCtrl, 0x01000201) // DMA start, sync mode 1, from RAM
  
  return 0
}

0x0009355c addiu r29,r29,0xffd0
0x00093560 sw r17,0x0014(r29)
0x00093564 addu r17,r4,r0
0x00093568 sw r18,0x0018(r29)
0x0009356c addu r18,r5,r0
0x00093570 sw r31,0x0028(r29)
0x00093574 sw r21,0x0024(r29)
0x00093578 sw r20,0x0020(r29)
0x0009357c sw r19,0x001c(r29)
0x00093580 jal 0x000942c8
0x00093584 sw r16,0x0010(r29)
0x00093588 lh r5,0x0004(r17)
0x0009358c lhu r3,0x0004(r17)
0x00093590 bltz r5,0x000935c0
0x00093594 addu r21,r0,r0
0x00093598 addu r4,r3,r0
0x0009359c lui r2,0x8011
0x000935a0 lh r2,0x6c58(r2)
0x000935a4 lui r3,0x8011
0x000935a8 lhu r3,0x6c58(r3)
0x000935ac slt r2,r2,r5
0x000935b0 beq r2,r0,0x000935c4
0x000935b4 nop
0x000935b8 j 0x000935c4
0x000935bc addu r4,r3,r0
0x000935c0 addu r4,r0,r0
0x000935c4 lh r5,0x0006(r17)
0x000935c8 lhu r3,0x0006(r17)
0x000935cc bltz r5,0x000935fc
0x000935d0 sh r4,0x0004(r17)
0x000935d4 addu r4,r3,r0
0x000935d8 lui r2,0x8011
0x000935dc lh r2,0x6c5a(r2)
0x000935e0 lui r3,0x8011
0x000935e4 lhu r3,0x6c5a(r3)
0x000935e8 slt r2,r2,r5
0x000935ec beq r2,r0,0x00093604
0x000935f0 sll r2,r4,0x10
0x000935f4 j 0x00093600
0x000935f8 addu r4,r3,r0
0x000935fc addu r4,r0,r0
0x00093600 sll r2,r4,0x10
0x00093604 lh r3,0x0004(r17)
0x00093608 sra r2,r2,0x10
0x0009360c mult r3,r2
0x00093610 sh r4,0x0006(r17)
0x00093614 mflo r6
0x00093618 addiu r3,r6,0x0001
0x0009361c srl r2,r3,0x1f
0x00093620 addu r3,r3,r2
0x00093624 sra r4,r3,0x01
0x00093628 bgtz r4,0x00093638
0x0009362c sra r16,r3,0x05
0x00093630 j 0x00093774
0x00093634 addiu r2,r0,0xffff
0x00093638 addu r3,r16,r0
0x0009363c sll r2,r3,0x04
0x00093640 subu r16,r4,r2
0x00093644 lui r2,0x8011
0x00093648 lw r2,0x6c10(r2)
0x0009364c addu r20,r3,r0
0x00093650 lw r2,0x0000(r2)
0x00093654 lui r3,0x0400
0x00093658 and r2,r2,r3
0x0009365c bne r2,r0,0x00093698
0x00093660 lui r4,0xa000
0x00093664 lui r19,0x0400
0x00093668 jal 0x000942fc
0x0009366c nop
0x00093670 bne r2,r0,0x00093774
0x00093674 addiu r2,r0,0xffff
0x00093678 lui r2,0x8011
0x0009367c lw r2,0x6c10(r2)
0x00093680 nop
0x00093684 lw r2,0x0000(r2)
0x00093688 nop
0x0009368c and r2,r2,r19
0x00093690 beq r2,r0,0x00093668
0x00093694 lui r4,0xa000
0x00093698 lui r3,0x8011
0x0009369c lw r3,0x6c10(r3)
0x000936a0 lui r2,0x0400
0x000936a4 sw r2,0x0000(r3)
0x000936a8 lui r3,0x8011
0x000936ac lw r3,0x6c0c(r3)
0x000936b0 lui r2,0x0100
0x000936b4 sw r2,0x0000(r3)
0x000936b8 lui r2,0x8011
0x000936bc lw r2,0x6c0c(r2)
0x000936c0 beq r21,r0,0x000936cc
0x000936c4 nop
0x000936c8 lui r4,0xb000
0x000936cc sw r4,0x0000(r2)
0x000936d0 lui r3,0x8011
0x000936d4 lw r3,0x6c0c(r3)
0x000936d8 lw r2,0x0000(r17)
0x000936dc nop
0x000936e0 sw r2,0x0000(r3)
0x000936e4 lui r3,0x8011
0x000936e8 lw r3,0x6c0c(r3)
0x000936ec lw r2,0x0004(r17)
0x000936f0 addiu r16,r16,0xffff
0x000936f4 sw r2,0x0000(r3)
0x000936f8 addiu r2,r0,0xffff
0x000936fc beq r16,r2,0x00093724
0x00093700 nop
0x00093704 addiu r4,r0,0xffff
0x00093708 lw r3,0x0000(r18)
0x0009370c addiu r18,r18,0x0004
0x00093710 lui r2,0x8011
0x00093714 lw r2,0x6c0c(r2)
0x00093718 addiu r16,r16,0xffff
0x0009371c bne r16,r4,0x00093708
0x00093720 sw r3,0x0000(r2)
0x00093724 beq r20,r0,0x00093770
0x00093728 lui r3,0x0400
0x0009372c lui r2,0x8011
0x00093730 lw r2,0x6c10(r2)
0x00093734 ori r3,r3,0x0002
0x00093738 sw r3,0x0000(r2)
0x0009373c lui r2,0x8011
0x00093740 lw r2,0x6c14(r2)
0x00093744 lui r4,0x0100
0x00093748 sw r18,0x0000(r2)
0x0009374c sll r2,r20,0x10
0x00093750 lui r3,0x8011
0x00093754 lw r3,0x6c18(r3)
0x00093758 ori r2,r2,0x0010
0x0009375c sw r2,0x0000(r3)
0x00093760 lui r2,0x8011
0x00093764 lw r2,0x6c1c(r2)
0x00093768 ori r4,r4,0x0201
0x0009376c sw r4,0x0000(r2)
0x00093770 addu r2,r0,r0
0x00093774 lw r31,0x0028(r29)
0x00093778 lw r21,0x0024(r29)
0x0009377c lw r20,0x0020(r29)
0x00093780 lw r19,0x001c(r29)
0x00093784 lw r18,0x0018(r29)
0x00093788 lw r17,0x0014(r29)
0x0009378c lw r16,0x0010(r29)
0x00093790 jr r31
0x00093794 addiu r29,r29,0x0030