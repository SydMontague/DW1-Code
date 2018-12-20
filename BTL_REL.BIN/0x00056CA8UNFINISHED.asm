0x00056CA8() {
  0x000623A0() // done, name missing
  resetFlattenGlobal()
  
  store(0x13507C, -1)
  
  getEntityTileFromModel(0x12F348, 0x134D58, 0x134D57) // deferred via 0x0005B1AC()
  0x0005B1C0() // done, name missing
  
  combatHead = load(0x134D4C)
  
  store(0x134D60, 0)
  store(0x134D64, 0)
  store(0x134D66, 1)
  store(0x134D68, 0)
  store(0x134D6A, 0)
  store(0x134D70, 0)
  store(0x134D74, 0)
  store(0x134D80, 0)
  store(0x135078, load(0x1557FE)) // aiMode
  store(0x135080, 0)
  
  store(combatHead + 0x066A, -1) // finisher chargeup
  // change command data
  store(combatHead + 0x0673, 0)
  store(combatHead + 0x0674, 0)
  
  r2 = 0x0010643C(2)
  store(0x134D78, r2)
  
  for(i = 0; i < 2; i++)
    store(combatHead + 0x0671 + i, -1)
    
  0x000A3B20()
  
  for(i = 0; i < 12; i++)
    store(combatHead + 0x0675 + i, -1)
  
  0x0005B23C()
  0x00064550()
  0x000DAC48()
  
  store(combatHead + 0x0640, 0)
  store(combatHead + 0x0642, 0)
  store(combatHead + 0x0644, 0)
  store(combatHead + 0x0646, 0)
  
  for(i = 0; i < load(0134D6C); i++) {
    combatPtr = combatHead + i * 0x168
    
    entityId = load(combatHead + 0x066C + i) * 4
    entityStatsPtr = load(0x12F344 + entityId) + 0x38
    
    store(entityStatsPtr + 0x1B, 0)
    store(combatHead + 0x05C4 + i * 0x28, -1)
    
    store(combatPtr, -1)
    store(combatPtr + 0x14, -1)
    store(combatPtr + 0x1A, 0)
    store(combatPtr + 0x22, 0)
    store(combatPtr + 0x26, 0)
    store(combatPtr + 0x28, 0)
    store(combatPtr + 0x2C, 0)
    store(combatPtr + 0x2E, 0)
    store(combatPtr + 0x30, 0)
    store(combatPtr + 0x32, 100)
    store(combatPtr + 0x34, 0)
    store(combatPtr + 0x36, 0)
    store(combatPtr + 0x37, -1)
    store(combatPtr + 0x3B, 0)
    
    brains = load(entityStatsPtr + 0x06)
    
    // num of self buffs allowed
    if(brains < 400)
      store(combatPtr + 0x39, brains * 0.01)
    else if(brains < 600)
      store(combatPtr + 0x39, 4)
    else
      store(combatPtr + 0x39, 5)
    
    store(combatPtr + 0x3A, brains * 0.1 + 5) // self buff timer
    store(combatPtr + 0x18, 3000 - load(entityStatsPtr + 0x04)) // finisher timer
    
    for(j = 0; j < 150; j++) {
      store(combatHead + 0x3C + j, -1)
      store(combatHead + 0xD2 + j, -1)
    }
  }
  
  brains = load(0x1557E6)
  
  if(brains < 500) {
    numCommands = load(0x1346E0 + brains * 0.01)
    store(combatHead + 0x0666, numCommands) // numCommands
  }
  else
    store(combatHead + 0x0666, 9)
  
  store(combatHead + 0x654, 11) // finisher
  store(combatHead + 0x655, 1) // run away
  
  switch(load(combatHead + 0x0666) - 3) {
    case 0:
      store(combatHead + 0x0656, 3)
      break
    case 1:
      store(combatHead + 0x0656, 2)
      store(combatHead + 0x0657, 3)
      break
    case 2:
      store(combatHead + 0x0656, 4)
      store(combatHead + 0x0657, 2)
      store(combatHead + 0x0658, 3)
      break
    case 4:
      store(combatHead + 0x0656, 7)
      store(combatHead + 0x0657, 5)
      store(combatHead + 0x0658, 4)
      store(combatHead + 0x0659, 2)
      store(combatHead + 0x065A, 3)
      break
    case 5:
      store(combatHead + 0x0656, 7)
      store(combatHead + 0x0657, 6)
      store(combatHead + 0x0658, 5)
      store(combatHead + 0x0659, 4)
      store(combatHead + 0x065A, 2)
      store(combatHead + 0x065B, 3)
      break
    case 6:
      store(combatHead + 0x0656, 7)
      store(combatHead + 0x0657, 6)
      store(combatHead + 0x0658, 5)
      
      offset = 5
      if(load(0x1557EE) != -1)
        store(combatHead + 0x0654 + offset++, 10)
      if(load(0x1557ED) != -1)
        store(combatHead + 0x0654 + offset++, 9)
      if(load(0x1557EC) != -1)
        store(combatHead + 0x0654 + offset++, 8)
      
      store(combatHead + 0x0654 + offset++, 3)
      store(combatHead + 0x0666, offset)
      break
  }
  
  hoveredCommand = load(combatHead + 0x0666) - 1
  store(combatHead + 0x0652, offset)
  store(combatHead + 0x0650, 3)
  store(combatHead + 0x064E, 3)
  
  for(i = 0; load(0x134D6C) < i; i++) {
    entityId = load(combatHead + 0x66C + i)
    entityStatsPtr = load(0x12F344 + entityId * 4) + 0x38
    
    store(0x13D610 + 0x00 + i * 0x0C, load(entityStatsPtr + 0x10)) // HP
    store(0x13D610 + 0x02 + i * 0x0C, load(entityStatsPtr + 0x12)) // MP
    store(0x13D610 + 0x04 + i * 0x0C, load(entityStatsPtr))        // Off
    store(0x13D610 + 0x06 + i * 0x0C, load(entityStatsPtr + 0x02)) // Def
    store(0x13D610 + 0x08 + i * 0x0C, load(entityStatsPtr + 0x04)) // Speed
    store(0x13D610 + 0x0A + i * 0x0C, load(entityStatsPtr + 0x06)) // Brains
  }
  
  if(load(0x138460) & 0x0060 != 0) { // is sick or injured
    offense = load(0x1557E0) * 0.8
    store(0x1557E0, offense)
    defense = load(0x1557E2) * 0.8
    store(0x1557E2, defense)
    speed = load(0x1557E4) * 0.8
    store(0x1557E4, speed)
    brains = load(0x1557E6) * 0.8
    store(0x1557E6, brains)
  }
  
  store(combatHead + 0x0648, load(0x1557F4)) // store current HP
  0x0006142C()
}