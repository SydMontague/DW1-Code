// recalc PP
void recalculatePPandArena() {
  // prosperity part
  prosperity = 0
  
  for(r16 = 3; r16 < 59; r16++) {
    level = load(0x12CED1 + r16 * 0x34)
    
    if(level < 3) // Fresh / In Training
      continue
      
    if(isTriggerSet(200 + r16) == 0)
      continue
    
    if(r16 == 11 || r16 == 39 || r16 == 53) {
      prosperity += 1
      continue
    }
    
    ppValue = level - 2
    prosperity += ppValue
  }
  
  setPStat(1, prosperity)
  
  // arena part
  if(readPStat(3) < 23)
    return
    
  if(isTriggerSet(37) != 0)
    unsetTrigger(37)
    
  if(isTriggerSet(38) != 0)
    unsetTrigger(38)
    
  if(isTriggerSet(39) != 0)
    unsetTrigger(39)
}