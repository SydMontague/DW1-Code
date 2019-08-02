combatInitEntityPositions() {
  combatHead = load(0x134D4C)
  flags = load(combatHead + 0x34)
  
  startBattleIdleAnimation(0x1557A8, 0x1557E0, flags) // partner Digimon
  
  enemyId1 = load(combatHead + 0x066D) // enemy ID #1
  enemyPtr = load(0x12F344 + enemyId1 * 4)
  somePtr = load(enemyPtr + 0x04)
  
  entityLookAtLocation(0x1557A8, somePtr + 0x78) // partner Digimon to enemy Digimon #1
  initializeBattleText()
  
  playerPtr = load(0x12F344)
  partnerPtr = load(0x12F348)
  
  fleeingEnemyCount = 0
  fleeingEnemyArray = short[4]
  
  for(entityId = 2; entityId < 10; entityId++) {
    entitiyPtr = load(0x12F344 + entityId * 4)
    
    if(isInvisible(enemyPtr) != 0)
      continue
    
    enemyCount = load(0x134D6C)
    
    for(combatId = 1; combatId <= enemyCount; combatId++)
      if(load(combatHead + 0x066C + combatId) == entityId)
        break
    
    if(combatId != enemyCount + 1)
      continue
    
    // -> is fleeing
    startAnimation(entitiyPtr, 0x24) // fast walk animation
    
    store(entitiyPtr + 0x30, load(entitiyPtr + 0x30) | 0x0004)
    
    tempArray = short[4]
    tempArray[0] = load(entitiyPtr + 0x58)
    tempArray[1] = load(entitiyPtr + 0x5A)
    tempArray[2] = load(entitiyPtr + 0x5C)
    tempArray[3] = load(entitiyPtr + 0x5E)
    
    positionArray = int[3]
    positionArray[0] = tempArray[0]
    positionArray[1] = tempArray[1]
    positionArray[2] = tempArray[2]
    
    entityLookAtLocation(entitiyPtr, positionArray)
    
    fleeingEnemyArray[fleeingEnemyCount++] = entityId
    store(sp + 0x34 + fleeingEnemyCount++ * 2, entityId)
  }
  
  hasNoFleeingEnemies = fleeingEnemyCount == 0 ? 1 : 0 // has fleeing enemies
  
  waypointCount = load(0x134D53) - 1
  store(0x134D50, 0)
  
  startAnimation(0x15576C, 3) // set Hiro running
  playSound(0, 0x10)
  
  someValue = 0
  
  for(frameCount = 0; frameCount < 0xC8 || hasNoFleeingEnemies == 0 || someValue == 0; frameCount++) {
    
    // walk Hiro to combat position
    if(load(playerPtr + 0x2E) != 1) { // is not in battle idle animation
      locationPtr = load(playerPtr + 0x04) + 0x78
      
      tileX, tileY = getModelTile(locationPtr)
      
      if(waypointCount >= 0) { // has waypoints left
        lTileX = load(0x13D5B0 + waypointCount)
        lTileY = load(0x13D590 + waypointCount)
        
        entityLookAtTile(playerPtr, lTileX, lTileY)
        
        if(tileX == lTileX && tileX == lTileY) {
          waypointCount--
          store(0x134D53, load(0x134D53) - 1)
        }
        
        collisionResponse = entityCheckCollision(partnerPtr, playerPtr, 310, 230)
      }
      else {
        lTileX = load(0x134D52)
        lTileY = load(0x134D51)
        entityLookAtTile(playerPtr, lTileX, lTileY)
        
        if(tileX == lTileX && tileY == lTileY)
          collisionResponse = 11
        else
          collisionResponse = entityCheckCollision(partnerPtr, playerPtr, 300, 220)
      }
    }
    
    // pointless?
    if(waypointCount == -1) {
      enemyCount = load(0x134D6C) // enemy count
      
      for(i = 1; enemyCount < i; i++);
    }
    
    // Hiro is at his spot
    if(collisionResponse == 11 && load(playerPtr + 0x2E) != 1) {
      startAnimation(playerPtr, 1) // set him idle
      
      // make him look at the partner Digimon
      entityLookAtLocation(playerPtr, load(partnerPtr + 0x04) + 0x78)
      
      // tell the loop to come to an end
      frameCount = 0xC6
    }
    
    for(entityCounter = 0; entityCounter < fleeingEnemyCount; entityCounter++) {
      entityPtr = load(0x12F344 + fleeingEnemyArray[entityCounter] * 4)
      
      if(entityIsOffScreen(entityPtr, 320, 240) == 0)
        break
    }
    
    if(entityCounter == fleeingEnemyCount)
      hasNoFleeingEnemies = 1
      
    someValue = load(0x1350C0) // deferred via 0x00063EF0()
    0x000D4034() // TODO name, some waypoint stuff
    
    // let partner look at enemy #1
    enemyId = load(combatHead + 0x066D)
    enemyPtr = load(0x12F344 + enemyId * 4)
    locationPtr = load(enemyPtr + 0x04)
    entityLookAtLocation(0x1557A8, locationPtr + 0x78)
    battleTickFrame()
  }
  
  if(waypointCount != -1) {
    store(0x134D53, waypointCount + 1)
    store(0x134D50, load(0x134D53) - 1)
  }
  else
    clearWaypointCounter()
  
  if(load(playerPtr + 0x2E) != 1) { // active Animation
    startAnimation(playerPtr, 1)
    partnerLocPtr = load(partnerPtr + 0x04)
    entityLookAtLocation(playerPtr, partnerLocPtr + 0x78)
  }
  
  for(entityCounter = 0; entityCounter < fleeingEnemyCount; entityCounter++) {
    entityPtr = load(0x12F344 + fleeingEnemyArray[entityCounter] * 4)
    
    store(entityPtr + 0x34, 0)
    store(entityPtr + 0x30, load(r3 + 0x30) & 0xFB)
  }
  
  unsetObject(0x1A6, 0) // deferred via 0x00063A20()
  
  // deferred via 0x00063A2C()
  store(0x1350C0, 0)
  setObject(0x1A6, 0, 0, 0x63A48)
  //
  
  playSound(0, 0x11)
  
  while(load(0x1350C0) == 0) // deferred via 0x00063EF0()
    battleTickFrame()
  
  unsetObject(0x1A6, 0) // deferred via 0x00063EE4()
  store(0x134F0A, 1)
  
  return 1
}

0x0005736c addiu r29,r29,0xffa0
0x00057370 sw r31,0x002c(r29)
0x00057374 sw r22,0x0028(r29)
0x00057378 sw r21,0x0024(r29)
0x0005737c sw r20,0x0020(r29)
0x00057380 sw r19,0x001c(r29)
0x00057384 sw r18,0x0018(r29)
0x00057388 sw r17,0x0014(r29)
0x0005738c lui r4,0x8015
0x00057390 lui r5,0x8015
0x00057394 lw r2,-0x6de0(r28)
0x00057398 sw r16,0x0010(r29)
0x0005739c lhu r6,0x0034(r2)
0x000573a0 addiu r4,r4,0x57a8
0x000573a4 jal 0x000e8970
0x000573a8 addiu r5,r5,0x57e0
0x000573ac lw r2,-0x6de0(r28)
0x000573b0 lui r4,0x8015
0x000573b4 lbu r2,0x066d(r2)
0x000573b8 addiu r4,r4,0x57a8
0x000573bc sll r3,r2,0x02
0x000573c0 lui r2,0x8013
0x000573c4 addiu r2,r2,0xf344
0x000573c8 addu r2,r2,r3
0x000573cc lw r2,0x0000(r2)
0x000573d0 nop
0x000573d4 lw r2,0x0004(r2)
0x000573d8 jal 0x000d459c
0x000573dc addiu r5,r2,0x0078
0x000573e0 jal 0x00063170
0x000573e4 nop
0x000573e8 addu r18,r0,r0
0x000573ec addiu r16,r0,0x0002
0x000573f0 beq r0,r0,0x000574e0
0x000573f4 addiu r20,r0,0x0008
0x000573f8 lui r2,0x8013
0x000573fc addiu r2,r2,0xf344
0x00057400 addu r2,r2,r20
0x00057404 lw r17,0x0000(r2)
0x00057408 jal 0x000e61ac
0x0005740c addu r4,r17,r0
0x00057410 bne r2,r0,0x000574d8
0x00057414 nop
0x00057418 lh r5,-0x6dc0(r28)
0x0005741c lw r4,-0x6de0(r28)
0x00057420 addiu r3,r0,0x0001
0x00057424 beq r0,r0,0x00057444
0x00057428 addu r6,r5,r0
0x0005742c addu r2,r3,r4
0x00057430 lbu r2,0x066c(r2)
0x00057434 nop
0x00057438 beq r2,r16,0x00057450
0x0005743c nop
0x00057440 addi r3,r3,0x0001
0x00057444 slt r1,r5,r3
0x00057448 beq r1,r0,0x0005742c
0x0005744c nop
0x00057450 addi r2,r6,0x0001
0x00057454 bne r3,r2,0x000574d8
0x00057458 nop
0x0005745c addu r4,r17,r0
0x00057460 jal 0x000c1a04
0x00057464 addiu r5,r0,0x0024
0x00057468 lbu r2,0x0030(r17)
0x0005746c nop
0x00057470 ori r2,r2,0x0004
0x00057474 sb r2,0x0030(r17)
0x00057478 lh r5,0x0058(r17)
0x0005747c lh r4,0x005a(r17)
0x00057480 lh r3,0x005c(r17)
0x00057484 lh r2,0x005e(r17)
0x00057488 sh r5,0x0054(r29)
0x0005748c sh r4,0x0056(r29)
0x00057490 sh r3,0x0058(r29)
0x00057494 sh r2,0x005a(r29)
0x00057498 lh r2,0x0054(r29)
0x0005749c addu r4,r17,r0
0x000574a0 sw r2,0x0044(r29)
0x000574a4 lh r2,0x0056(r29)
0x000574a8 nop
0x000574ac sw r2,0x0048(r29)
0x000574b0 lh r2,0x0058(r29)
0x000574b4 nop
0x000574b8 sw r2,0x004c(r29)
0x000574bc jal 0x000d459c
0x000574c0 addiu r5,r29,0x0044
0x000574c4 addu r2,r18,r0
0x000574c8 addi r18,r2,0x0001
0x000574cc sll r2,r2,0x01
0x000574d0 addu r2,r29,r2
0x000574d4 sh r16,0x0034(r2)
0x000574d8 addi r16,r16,0x0001
0x000574dc addi r20,r20,0x0004
0x000574e0 slti r1,r16,0x000a
0x000574e4 bne r1,r0,0x000573f8
0x000574e8 nop
0x000574ec addu r21,r0,r0
0x000574f0 bne r18,r0,0x00057500
0x000574f4 addu r16,r0,r0
0x000574f8 beq r0,r0,0x00057504
0x000574fc addiu r22,r0,0x0001
0x00057500 addu r22,r0,r0
0x00057504 lb r2,-0x6dd9(r28)
0x00057508 lui r4,0x8015
0x0005750c addi r2,r2,-0x0001
0x00057510 sll r20,r2,0x10
0x00057514 sra r20,r20,0x10
0x00057518 sb r0,-0x6ddc(r28)
0x0005751c addiu r4,r4,0x576c
0x00057520 jal 0x000c1a04
0x00057524 addiu r5,r0,0x0003
0x00057528 addu r4,r0,r0
0x0005752c jal 0x000c6374
0x00057530 addiu r5,r0,0x0010
0x00057534 beq r0,r0,0x000577c8
0x00057538 slti r1,r21,0x00c8
0x0005753c lui r1,0x8013
0x00057540 lw r3,-0x0cbc(r1)
0x00057544 nop
0x00057548 lbu r2,0x002e(r3)
0x0005754c addiu r1,r0,0x0001
0x00057550 beq r2,r1,0x0005769c
0x00057554 nop
0x00057558 lw r2,0x0004(r3)
0x0005755c addiu r5,r29,0x005c
0x00057560 addiu r4,r2,0x0078
0x00057564 jal 0x000c0f28
0x00057568 addiu r6,r29,0x005e
0x0005756c bltz r20,0x00057628
0x00057570 nop
0x00057574 lui r2,0x8014
0x00057578 lui r1,0x8013
0x0005757c addu r16,r20,r0
0x00057580 addiu r2,r2,0xd5b0
0x00057584 addu r2,r2,r16
0x00057588 lb r5,0x0000(r2)
0x0005758c lw r4,-0x0cbc(r1)
0x00057590 lui r2,0x8014
0x00057594 addiu r2,r2,0xd590
0x00057598 addu r2,r2,r16
0x0005759c lb r6,0x0000(r2)
0x000575a0 jal 0x000e6078
0x000575a4 nop
0x000575a8 lui r2,0x8014
0x000575ac addiu r2,r2,0xd5b0
0x000575b0 addu r2,r2,r16
0x000575b4 lh r3,0x005c(r29)
0x000575b8 lb r2,0x0000(r2)
0x000575bc nop
0x000575c0 bne r3,r2,0x00057600
0x000575c4 nop
0x000575c8 lui r2,0x8014
0x000575cc addiu r2,r2,0xd590
0x000575d0 addu r2,r2,r16
0x000575d4 lh r3,0x005e(r29)
0x000575d8 lb r2,0x0000(r2)
0x000575dc nop
0x000575e0 bne r3,r2,0x00057600
0x000575e4 nop
0x000575e8 addi r2,r20,-0x0001
0x000575ec sll r20,r2,0x10
0x000575f0 lb r2,-0x6dd9(r28)
0x000575f4 sra r20,r20,0x10
0x000575f8 addi r2,r2,-0x0001
0x000575fc sb r2,-0x6dd9(r28)
0x00057600 lui r1,0x8013
0x00057604 lw r4,-0x0cb8(r1)
0x00057608 addiu r6,r0,0x0136
0x0005760c lui r1,0x8013
0x00057610 lw r5,-0x0cbc(r1)
0x00057614 jal 0x000d45ec
0x00057618 addiu r7,r0,0x00e6
0x0005761c sll r19,r2,0x10
0x00057620 beq r0,r0,0x0005769c
0x00057624 sra r19,r19,0x10
0x00057628 lui r1,0x8013
0x0005762c lb r5,-0x6dda(r28)
0x00057630 lb r6,-0x6ddb(r28)
0x00057634 lw r4,-0x0cbc(r1)
0x00057638 jal 0x000e6078
0x0005763c nop
0x00057640 lh r3,0x005c(r29)
0x00057644 lb r2,-0x6dda(r28)
0x00057648 nop
0x0005764c bne r3,r2,0x00057678
0x00057650 nop
0x00057654 lh r3,0x005e(r29)
0x00057658 lb r2,-0x6ddb(r28)
0x0005765c nop
0x00057660 bne r3,r2,0x00057678
0x00057664 nop
0x00057668 addiu r2,r0,0x000b
0x0005766c sll r19,r2,0x10
0x00057670 beq r0,r0,0x0005769c
0x00057674 sra r19,r19,0x10
0x00057678 lui r1,0x8013
0x0005767c lw r4,-0x0cb8(r1)
0x00057680 addiu r6,r0,0x012c
0x00057684 lui r1,0x8013
0x00057688 lw r5,-0x0cbc(r1)
0x0005768c jal 0x000d45ec
0x00057690 addiu r7,r0,0x00dc
0x00057694 sll r19,r2,0x10
0x00057698 sra r19,r19,0x10
0x0005769c addiu r1,r0,0xffff
0x000576a0 bne r20,r1,0x000576c4
0x000576a4 nop
0x000576a8 lh r2,-0x6dc0(r28)
0x000576ac beq r0,r0,0x000576b8
0x000576b0 addiu r16,r0,0x0001
0x000576b4 addi r16,r16,0x0001
0x000576b8 slt r1,r2,r16
0x000576bc beq r1,r0,0x000576b4
0x000576c0 nop
0x000576c4 addiu r1,r0,0x000b
0x000576c8 bne r19,r1,0x00057718
0x000576cc nop
0x000576d0 lui r1,0x8013
0x000576d4 lw r4,-0x0cbc(r1)
0x000576d8 nop
0x000576dc lbu r2,0x002e(r4)
0x000576e0 addiu r1,r0,0x0001
0x000576e4 beq r2,r1,0x00057718
0x000576e8 nop
0x000576ec jal 0x000c1a04
0x000576f0 addiu r5,r0,0x0001
0x000576f4 lui r1,0x8013
0x000576f8 lw r2,-0x0cb8(r1)
0x000576fc nop
0x00057700 lw r2,0x0004(r2)
0x00057704 lui r1,0x8013
0x00057708 lw r4,-0x0cbc(r1)
0x0005770c jal 0x000d459c
0x00057710 addiu r5,r2,0x0078
0x00057714 addiu r21,r0,0x00c6
0x00057718 addi r21,r21,0x0001
0x0005771c addu r16,r0,r0
0x00057720 beq r0,r0,0x00057760
0x00057724 addu r17,r0,r0
0x00057728 addu r2,r29,r17
0x0005772c lh r2,0x0034(r2)
0x00057730 addiu r5,r0,0x0140
0x00057734 sll r3,r2,0x02
0x00057738 lui r2,0x8013
0x0005773c addiu r2,r2,0xf344
0x00057740 addu r2,r2,r3
0x00057744 lw r4,0x0000(r2)
0x00057748 jal 0x000d5430
0x0005774c addiu r6,r0,0x00f0
0x00057750 beq r2,r0,0x0005776c
0x00057754 nop
0x00057758 addi r16,r16,0x0001
0x0005775c addi r17,r17,0x0002
0x00057760 slt r1,r16,r18
0x00057764 bne r1,r0,0x00057728
0x00057768 nop
0x0005776c bne r16,r18,0x00057778
0x00057770 nop
0x00057774 addiu r22,r0,0x0001
0x00057778 jal 0x00063ef0
0x0005777c nop
0x00057780 jal 0x000d4034
0x00057784 addu r16,r2,r0
0x00057788 lw r2,-0x6de0(r28)
0x0005778c lui r4,0x8015
0x00057790 lbu r2,0x066d(r2)
0x00057794 addiu r4,r4,0x57a8
0x00057798 sll r3,r2,0x02
0x0005779c lui r2,0x8013
0x000577a0 addiu r2,r2,0xf344
0x000577a4 addu r2,r2,r3
0x000577a8 lw r2,0x0000(r2)
0x000577ac nop
0x000577b0 lw r2,0x0004(r2)
0x000577b4 jal 0x000d459c
0x000577b8 addiu r5,r2,0x0078
0x000577bc jal 0x0005dec4
0x000577c0 nop
0x000577c4 slti r1,r21,0x00c8
0x000577c8 bne r1,r0,0x0005753c
0x000577cc nop
0x000577d0 beq r22,r0,0x0005753c
0x000577d4 nop
0x000577d8 beq r16,r0,0x0005753c
0x000577dc nop
0x000577e0 addiu r1,r0,0xffff
0x000577e4 beq r20,r1,0x00057808
0x000577e8 nop
0x000577ec addi r2,r20,0x0001
0x000577f0 sb r2,-0x6dd9(r28)
0x000577f4 lb r2,-0x6dd9(r28)
0x000577f8 nop
0x000577fc addi r2,r2,-0x0001
0x00057800 beq r0,r0,0x00057810
0x00057804 sb r2,-0x6ddc(r28)
0x00057808 jal 0x000d3adc
0x0005780c nop
0x00057810 lui r1,0x8013
0x00057814 lw r4,-0x0cbc(r1)
0x00057818 nop
0x0005781c lbu r2,0x002e(r4)
0x00057820 addiu r1,r0,0x0001
0x00057824 beq r2,r1,0x00057854
0x00057828 nop
0x0005782c jal 0x000c1a04
0x00057830 addiu r5,r0,0x0001
0x00057834 lui r1,0x8013
0x00057838 lw r2,-0x0cb8(r1)
0x0005783c nop
0x00057840 lw r2,0x0004(r2)
0x00057844 lui r1,0x8013
0x00057848 lw r4,-0x0cbc(r1)
0x0005784c jal 0x000d459c
0x00057850 addiu r5,r2,0x0078
0x00057854 addu r16,r0,r0
0x00057858 beq r0,r0,0x000578a0
0x0005785c addu r4,r0,r0
0x00057860 addu r2,r29,r4
0x00057864 lh r2,0x0034(r2)
0x00057868 addi r16,r16,0x0001
0x0005786c sll r3,r2,0x02
0x00057870 lui r2,0x8013
0x00057874 addiu r2,r2,0xf344
0x00057878 addu r3,r2,r3
0x0005787c lw r2,0x0000(r3)
0x00057880 addi r4,r4,0x0002
0x00057884 sb r0,0x0034(r2)
0x00057888 lw r3,0x0000(r3)
0x0005788c nop
0x00057890 lbu r2,0x0030(r3)
0x00057894 nop
0x00057898 andi r2,r2,0x00fb
0x0005789c sb r2,0x0030(r3)
0x000578a0 slt r1,r16,r18
0x000578a4 bne r1,r0,0x00057860
0x000578a8 nop
0x000578ac jal 0x00063a20
0x000578b0 nop
0x000578b4 jal 0x00063a2c
0x000578b8 nop
0x000578bc addu r4,r0,r0
0x000578c0 jal 0x000c6374
0x000578c4 addiu r5,r0,0x0011
0x000578c8 beq r0,r0,0x000578d8
0x000578cc nop
0x000578d0 jal 0x0005dec4
0x000578d4 nop
0x000578d8 jal 0x00063ef0
0x000578dc nop
0x000578e0 beq r2,r0,0x000578d0
0x000578e4 nop
0x000578e8 jal 0x00063ee4
0x000578ec nop
0x000578f0 addiu r2,r0,0x0001
0x000578f4 sb r2,-0x6c22(r28)
0x000578f8 lw r31,0x002c(r29)
0x000578fc lw r22,0x0028(r29)
0x00057900 lw r21,0x0024(r29)
0x00057904 lw r20,0x0020(r29)
0x00057908 lw r19,0x001c(r29)
0x0005790c lw r18,0x0018(r29)
0x00057910 lw r17,0x0014(r29)
0x00057914 lw r16,0x0010(r29)
0x00057918 jr r31
0x0005791c addiu r29,r29,0x0060