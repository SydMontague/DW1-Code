/**
 * Sets the IRQ mask that enabled/disables IRQs and returns the old value.
 */
setIRQMask(newIRQMask) {
  IRQMaskPtr = load(0x116AEC) // 0x1F801074, interrupt mask register
  
  oldIRQMask = load(IRQMaskPtr)
  store(IRQMaskPtr, newIRQMask)
  
  return oldIRQMask
}

0x00092450 lui r3,0x8011
0x00092454 lw r3,0x6aec(r3)
0x00092458 nop
0x0009245c lhu r2,0x0000(r3)
0x00092460 jr r31
0x00092464 sh r4,0x0000(r3)