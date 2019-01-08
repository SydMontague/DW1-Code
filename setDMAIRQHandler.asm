int setDMAIRQHandler(dmaIrqId, newHandler) {
  oldHandler = load(0x116B38 + dmaIrqId * 4)
  
  if(newHandler == oldHandler)
    return oldHandler
  
  dmaIRQregPtr = load(0x116B34) // DMA IRQ Register
  
  store(0x116B38 + dmaIrqId * 4, newHandler)
  dmaIRQreg = load(dmaIRQregPtr) & 0x00FFFFFF
  irqBitMask = 1 << (dmaIrqId + 0x10)
  
  if(newHandler != 0)
    newDmaIrqRegVal = dmaIRQreg | irqBitMask | 0x00800000 // DMA IRQ master enable and DMA<dmaIrqId> IRQ enable
  else
    newDmaIrqRegVal = dmaIRQreg & ~irqBitMask // unset DMA IRQ DMA<dmaIrqId>
  
  store(dmaIRQregPtr, newDmaIrqRegVal)
  return oldHandler
}

0x00092708 addu r6,r4,r0
0x0009270c lui r3,0x8011
0x00092710 addiu r3,r3,0x6b38
0x00092714 sll r2,r6,0x02
0x00092718 addu r3,r2,r3
0x0009271c lw r7,0x0000(r3)
0x00092720 addu r4,r5,r0
0x00092724 beq r4,r7,0x000927ac
0x00092728 addu r2,r7,r0
0x0009272c beq r4,r0,0x00092770
0x00092730 lui r2,0x00ff
0x00092734 lui r5,0x8011
0x00092738 lw r5,0x6b34(r5)
0x0009273c ori r2,r2,0xffff
0x00092740 sw r4,0x0000(r3)
0x00092744 lw r4,0x0000(r5)
0x00092748 addiu r3,r6,0x0010
0x0009274c and r4,r4,r2
0x00092750 addiu r2,r0,0x0001
0x00092754 sllv r2,r2,r3
0x00092758 lui r3,0x0080
0x0009275c or r2,r2,r3
0x00092760 or r4,r4,r2
0x00092764 sw r4,0x0000(r5)
0x00092768 j 0x000927ac
0x0009276c addu r2,r7,r0
0x00092770 lui r5,0x8011
0x00092774 lw r5,0x6b34(r5)
0x00092778 ori r2,r2,0xffff
0x0009277c sw r0,0x0000(r3)
0x00092780 lw r3,0x0000(r5)
0x00092784 addiu r4,r6,0x0010
0x00092788 and r3,r3,r2
0x0009278c lui r2,0x0080
0x00092790 or r3,r3,r2
0x00092794 addiu r2,r0,0x0001
0x00092798 sllv r2,r2,r4
0x0009279c nor r2,r0,r2
0x000927a0 and r3,r3,r2
0x000927a4 sw r3,0x0000(r5)
0x000927a8 addu r2,r7,r0
0x000927ac jr r31
0x000927b0 nop