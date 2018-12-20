void combatMain() {
  // defines the area of combat?
  xOffset = 160 - load(0x134EC0) // screen offset X?
  yOffset = 120 - load(0x134EC4) // screen offset Y?
  store(0x134D8C, xOffset)
  store(0x134D88, yOffset)
  
  0x00056CA8()
  0x0005736C()
  
  while(0x00057920() == 0) {
    partnerAiTick()
    0x00058394()
    0x00058874()
    0x00058AA4()
    0x0005DEC4()
    0x000E62D0()
    
    frameCount = load(0x134D66)
    store(0x134D66, frameCount + 1)
  }
  
  0x000E642C()
  0x00058C68()
  
  combatHead = load(0x134D4C)
  
  if(load(0x1557F4) == 0) { // HP is 0
    store(combatHead + 0x064E, 0)
    return -1
  }
  
  if(load(combatHead + 0x064E) == 1) { // command is run away
    store(combatHead + 0x064E, 0)
    return 0
  }
  
  return 1
}