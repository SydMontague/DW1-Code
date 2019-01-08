/**
 * Causes to wait for vsync for a given amount of frames.
 * If the input parameter is negative the current frame count is returned.
 * If the input parameter is 1 the number of horizontal blanks by the current frame is returned.
 * If the input parameter is 0 the function waits until the frame is over.
 * For any other input the function wait for that number of frames.
 *
 * E.g. vsync(3) at frame 100 waits until frame 103
 */
int vsync(frameCount) {
  counterModePtr = load(0x115A44) // counter mode ptr
  counterValuePtr = load(0x115A48) // counter value
  
  // counter instability workaround http://problemkaputt.de/psx-spx.htm#timers
  do {
    counterValue = load(counterValuePtr)
    testCounterValue = load(counterValuePtr)
  } while(testCounterValue != counterValue)
  
  lastHBlankCount = load(0x115A58)
  hblankSinceLastSync = (counterValue - lastHBlankCount) & 0xFFFF
  
  if(frameCount < 0)
    return load(0x116B30) // frame counter
  
  if(frameCount == 1)
    return hblankSinceLastSync
  
  timeout = frameCount > 0 ? frameCount - 1 : 0
  waitTargetFrame = load(0x115A4C) + timeout
    
  vsyncWait(waitTargetFrame, timeout)
  vsyncWait(load(0x116B30) + 1, 1)
  
  counterMode = load(counterModePtr)
  
  // wait for something, no fucking clue
  if(counterMode & 0x00400000 != 0 && counterMode ^ load(counterModePtr) >= 0)
    while((counterMode ^ load(counterModePtr)) & 0x80000000 == 0);
  
  newFrameCount = load(0x116B30)
  store(0x115A4C, newFrameCount)
  
  // counter instability workaround http://problemkaputt.de/psx-spx.htm#timers
  do {
    counterValue = load(counterValuePtr)
    store(0x115A58, counterValue)
    testCounterValue = load(0x115A58)
    counterValue = load(counterValuePtr)
  } while(testCounterValue != counterValue)
  
  return hblankSinceLastSync
}

0x00091ca8 lui r2,0x8011
0x00091cac lw r2,0x5a44(r2)
0x00091cb0 lui r5,0x8011
0x00091cb4 lw r5,0x5a48(r5)
0x00091cb8 addiu r29,r29,0xffd8
0x00091cbc sw r31,0x0020(r29)
0x00091cc0 sw r17,0x001c(r29)
0x00091cc4 sw r16,0x0018(r29)
0x00091cc8 lw r16,0x0000(r2)
0x00091ccc lw r2,0x0000(r5)
0x00091cd0 nop
0x00091cd4 sw r2,0x0010(r29)
0x00091cd8 lw r3,0x0010(r29)
0x00091cdc lw r2,0x0000(r5)
0x00091ce0 nop
0x00091ce4 bne r3,r2,0x00091ccc
0x00091ce8 nop
0x00091cec lw r2,0x0010(r29)
0x00091cf0 lui r3,0x8011
0x00091cf4 lw r3,0x5a58(r3)
0x00091cf8 nop
0x00091cfc subu r2,r2,r3
0x00091d00 bgez r4,0x00091d18
0x00091d04 andi r17,r2,0xffff
0x00091d08 lui r2,0x8011
0x00091d0c lw r2,0x6b30(r2)
0x00091d10 j 0x00091e0c
0x00091d14 nop
0x00091d18 addiu r2,r0,0x0001
0x00091d1c beq r4,r2,0x00091e08
0x00091d20 nop
0x00091d24 blez r4,0x00091d44
0x00091d28 nop
0x00091d2c lui r2,0x8011
0x00091d30 lw r2,0x5a4c(r2)
0x00091d34 nop
0x00091d38 addiu r2,r2,0xffff
0x00091d3c j 0x00091d4c
0x00091d40 addu r2,r2,r4
0x00091d44 lui r2,0x8011
0x00091d48 lw r2,0x5a4c(r2)
0x00091d4c blez r4,0x00091d58
0x00091d50 addu r5,r0,r0
0x00091d54 addiu r5,r4,0xffff
0x00091d58 jal 0x00091c10
0x00091d5c addu r4,r2,r0
0x00091d60 lui r2,0x8011
0x00091d64 lw r2,0x5a44(r2)
0x00091d68 nop
0x00091d6c lw r16,0x0000(r2)
0x00091d70 lui r4,0x8011
0x00091d74 lw r4,0x6b30(r4)
0x00091d78 addiu r5,r0,0x0001
0x00091d7c jal 0x00091c10
0x00091d80 addiu r4,r4,0x0001
0x00091d84 lui r2,0x0040
0x00091d88 and r2,r16,r2
0x00091d8c beq r2,r0,0x00091dcc
0x00091d90 nop
0x00091d94 lui r3,0x8011
0x00091d98 lw r3,0x5a44(r3)
0x00091d9c nop
0x00091da0 lw r2,0x0000(r3)
0x00091da4 nop
0x00091da8 xor r2,r16,r2
0x00091dac bltz r2,0x00091dcc
0x00091db0 lui r4,0x8000
0x00091db4 lw r2,0x0000(r3)
0x00091db8 nop
0x00091dbc xor r2,r16,r2
0x00091dc0 and r2,r2,r4
0x00091dc4 beq r2,r0,0x00091db4
0x00091dc8 nop
0x00091dcc lui r2,0x8011
0x00091dd0 lw r2,0x6b30(r2)
0x00091dd4 lui r4,0x8011
0x00091dd8 lw r4,0x5a48(r4)
0x00091ddc lui r1,0x8011
0x00091de0 sw r2,0x5a4c(r1)
0x00091de4 lw r2,0x0000(r4)
0x00091de8 lui r1,0x8011
0x00091dec sw r2,0x5a58(r1)
0x00091df0 lui r3,0x8011
0x00091df4 lw r3,0x5a58(r3)
0x00091df8 lw r2,0x0000(r4)
0x00091dfc nop
0x00091e00 bne r3,r2,0x00091de4
0x00091e04 nop
0x00091e08 addu r2,r17,r0
0x00091e0c lw r31,0x0020(r29)
0x00091e10 lw r17,0x001c(r29)
0x00091e14 lw r16,0x0018(r29)
0x00091e18 jr r31
0x00091e1c addiu r29,r29,0x0028