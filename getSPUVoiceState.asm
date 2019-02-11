/**
 * Gets state of an SPU Voice.
 * -1 -> no voice found
 *  0 -> channel is inactive and has no ADSR volume
 *  1 -> channel is active and has ADSR volume
 *  2 -> channel is inactive and has ADSR volume
 *  3 -> channel is active and has no ADSR volume
 */
int getSPUVoiceState(voiceMask) {
  voiceId = -1
  
  for(i = 0; i < 24; i++) {
    if(voiceMask & (1 << i) != 0) {
      voiceId = i
      break
    }
  }
  
  if(voiceId == -1) // no voice selected
    return -1
    
  spuRegister = load(0x128080) + voiceId * 16 // SPU Voice (voiceId) Register
  adsrVolume = load(spuRegister + 0x0C) // Voice (voiceId) ADSR Current Volume
  isChannelActive = load(0x1280B0) & (1 << voiceId) // channel active?
  
  if(isChannelActive == 0) // channel is inactive
    return adsrVolume > 0 ? 2 : 0 // has ADSR volume
  
  if(adsrVolume != 0)
    return 1 // channel is active and has ADSR volume
    
  return 3 // channel is active and doesn't have ADSR volume
}

0x000c8da8 addiu r5,r0,0xffff
0x000c8dac addu r3,r0,r0
0x000c8db0 addiu r6,r0,0x0001
0x000c8db4 sllv r2,r6,r3
0x000c8db8 and r2,r4,r2
0x000c8dbc bne r2,r0,0x000c8de8
0x000c8dc0 nop
0x000c8dc4 addiu r3,r3,0x0001
0x000c8dc8 slti r2,r3,0x0018
0x000c8dcc bne r2,r0,0x000c8db8
0x000c8dd0 sllv r2,r6,r3
0x000c8dd4 addiu r2,r0,0xffff
0x000c8dd8 bne r5,r2,0x000c8df0
0x000c8ddc sll r4,r5,0x04
0x000c8de0 j 0x000c8e30
0x000c8de4 nop
0x000c8de8 j 0x000c8dd4
0x000c8dec addu r5,r3,r0
0x000c8df0 lui r2,0x8013
0x000c8df4 lw r2,-0x7f80(r2)
0x000c8df8 lui r3,0x8013
0x000c8dfc lw r3,-0x7f50(r3)
0x000c8e00 addu r4,r4,r2
0x000c8e04 addiu r2,r0,0x0001
0x000c8e08 sllv r2,r2,r5
0x000c8e0c and r3,r3,r2
0x000c8e10 lhu r4,0x000c(r4)
0x000c8e14 bne r3,r0,0x000c8e24
0x000c8e18 sltu r2,r0,r4
0x000c8e1c j 0x000c8e30
0x000c8e20 sll r2,r2,0x01
0x000c8e24 bne r4,r0,0x000c8e30
0x000c8e28 addiu r2,r0,0x0001
0x000c8e2c addiu r2,r0,0x0003
0x000c8e30 jr r31
0x000c8e34 nop