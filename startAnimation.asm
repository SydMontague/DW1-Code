/**
 * Starts playing an animation with a given ID for the given entity. (probably)
 */
void startAnimation(int entityPtr, int animId) {
  animTablePtr = load(entityPtr + 0x08)
  animPtr = load(animTablePtr + animId * 4)
  
  if(animPtr == 0)
    return
  
  animHead = animTablePtr + animPtr
  digimonType = load(entityPtr)
  nodePtr = load(entityPtr + 0x04)
  nodeCount = load(0x12CEC8 + digimonType * 52) & 0xFF
  
  entityType = getEntityType(entityPtr)
  modelComponent = getDigimonModelComponent(digimonType, entityType)
  
  unknownValue1 = (load(modelComponent + 0x10) - 0x10) * 64
  unknownValue2 = load(modelComponent + 0x15) + 0x100
  frameCount = load(animHead)
  
  store(entityPtr + 0x1C, 1) // anim frame
  store(entityPtr + 0x1E, frameCount)
  store(entityPtr + 0x28, 1) // another anim frame
  store(entityPtr + 0x2A, unknownValue1)
  store(entityPtr + 0x2C, unknownValue2)
  store(entityPtr + 0x2E, animId)
  store(entityPtr + 0x2F, 0)
  store(entityPtr + 0x30, 1)
  
  momentumPtr = load(entityPtr + 0x0C)
  animInstrPtr = animHead + 2
    
  locX = load(nodePtr + 0x78) << 0x0F
  locY = load(nodePtr + 0x7C) << 0x0F
  locZ = load(nodePtr + 0x80) << 0x0F
  
  store(entityPtr + 0x10, locX)
  store(entityPtr + 0x14, locY)
  store(entityPtr + 0x18, locZ)
  
  setZero36Offset18(momentumPtr)
  setupModelMatrix(nodePtr)
  
  // initial positions for each node
  for(int i = 1; i < nodeCount; i++  nodePtr + 0x88) {
    localNodePtr = nodePtr + i * 0x88
    
    if(frameCount & 0x8000 == 0) {
      store(localNodePtr + 0x60, 0x1000)
      store(localNodePtr + 0x64, 0x1000)
      store(localNodePtr + 0x68, 0x1000)
    }
    else {
      store(localNodePtr + 0x60, load(animInstrPtr))
      animInstrPtr = animInstrPtr + 0x02
      store(localNodePtr + 0x64, load(animInstrPtr))
      animInstrPtr = animInstrPtr + 0x02
      store(localNodePtr + 0x68, load(animInstrPtr))
      animInstrPtr = animInstrPtr + 0x02
    }
    
    store(localNodePtr + 0x70, load(animInstrPtr))
    animInstrPtr = animInstrPtr + 0x02
    store(localNodePtr + 0x72, load(animInstrPtr))
    animInstrPtr = animInstrPtr + 0x02
    store(localNodePtr + 0x74, load(animInstrPtr))
    animInstrPtr = animInstrPtr + 0x02
    store(localNodePtr + 0x78, load(animInstrPtr))
    animInstrPtr = animInstrPtr + 0x02
    store(localNodePtr + 0x7C, load(animInstrPtr))
    animInstrPtr = animInstrPtr + 0x02
    store(localNodePtr + 0x80, load(animInstrPtr))
    animInstrPtr = animInstrPtr + 0x02
    
    setZero36Offset18(momentumPtr + 0x52 * i)
    setupModelMatrix(localNodePtr)
  }
  
  store(entitiyPtr + 0x20, animInstrPtr)
}

0x000c1a04 addiu r29,r29,0xffd0
0x000c1a08 sw r31,0x002c(r29)
0x000c1a0c sw r22,0x0028(r29)
0x000c1a10 sw r21,0x0024(r29)
0x000c1a14 sw r20,0x0020(r29)
0x000c1a18 sw r19,0x001c(r29)
0x000c1a1c sw r18,0x0018(r29)
0x000c1a20 sw r17,0x0014(r29)
0x000c1a24 addu r19,r5,r0
0x000c1a28 sw r16,0x0010(r29)
0x000c1a2c addu r18,r4,r0
0x000c1a30 lw r3,0x0008(r18)
0x000c1a34 sll r2,r19,0x02
0x000c1a38 addu r2,r3,r2
0x000c1a3c lw r2,0x0000(r2)
0x000c1a40 nop
0x000c1a44 beq r2,r0,0x000c1c3c
0x000c1a48 addu r5,r2,r0
0x000c1a4c addu r16,r3,r5
0x000c1a50 lw r3,0x0000(r18)
0x000c1a54 lw r17,0x0004(r18)
0x000c1a58 sll r2,r3,0x01
0x000c1a5c add r2,r2,r3
0x000c1a60 sll r2,r2,0x02
0x000c1a64 add r2,r2,r3
0x000c1a68 sll r3,r2,0x02
0x000c1a6c lui r2,0x8013
0x000c1a70 addiu r2,r2,0xcec8
0x000c1a74 addu r2,r2,r3
0x000c1a78 lw r2,0x0000(r2)
0x000c1a7c addiu r20,r18,0x000c
0x000c1a80 jal 0x000a2660
0x000c1a84 andi r21,r2,0x00ff
0x000c1a88 lw r4,0x0000(r18)
0x000c1a8c jal 0x000a254c
0x000c1a90 addu r5,r2,r0
0x000c1a94 lhu r3,0x0010(r2)
0x000c1a98 addiu r22,r0,0x0001
0x000c1a9c addi r3,r3,-0x0010
0x000c1aa0 sll r3,r3,0x06
0x000c1aa4 sh r3,0x001e(r20)
0x000c1aa8 lbu r2,0x0015(r2)
0x000c1aac addiu r3,r16,0x0002
0x000c1ab0 addi r2,r2,0x0100
0x000c1ab4 sh r2,0x0020(r20)
0x000c1ab8 sh r22,0x001c(r20)
0x000c1abc sb r19,0x0022(r20)
0x000c1ac0 addu r2,r22,r0
0x000c1ac4 sh r2,0x0010(r20)
0x000c1ac8 addu r2,r22,r0
0x000c1acc sb r2,0x0024(r20)
0x000c1ad0 sb r0,0x0023(r20)
0x000c1ad4 lh r2,0x0000(r16)
0x000c1ad8 lw r19,0x0000(r20)
0x000c1adc sh r2,0x0012(r20)
0x000c1ae0 lh r2,0x0012(r20)
0x000c1ae4 nop
0x000c1ae8 andi r2,r2,0x8000
0x000c1aec beq r2,r0,0x000c1afc
0x000c1af0 addu r16,r3,r0
0x000c1af4 beq r0,r0,0x000c1b04
0x000c1af8 lh r2,0x0012(r20)
0x000c1afc addu r22,r0,r0
0x000c1b00 lh r2,0x0012(r20)
0x000c1b04 addiu r3,r17,0x0078
0x000c1b08 andi r2,r2,0x7fff
0x000c1b0c sh r2,0x0012(r20)
0x000c1b10 lw r2,0x0000(r3)
0x000c1b14 nop
0x000c1b18 sll r2,r2,0x0f
0x000c1b1c sw r2,0x0004(r20)
0x000c1b20 lw r2,0x0004(r3)
0x000c1b24 nop
0x000c1b28 sll r2,r2,0x0f
0x000c1b2c sw r2,0x0008(r20)
0x000c1b30 lw r2,0x0008(r3)
0x000c1b34 nop
0x000c1b38 sll r2,r2,0x0f
0x000c1b3c sw r2,0x000c(r20)
0x000c1b40 jal 0x000c1798
0x000c1b44 addu r4,r19,r0
0x000c1b48 addiu r19,r19,0x0052
0x000c1b4c jal 0x000c19a4
0x000c1b50 addu r4,r17,r0
0x000c1b54 addiu r17,r17,0x0088
0x000c1b58 beq r0,r0,0x000c1c2c
0x000c1b5c addiu r18,r0,0x0001
0x000c1b60 bne r22,r0,0x000c1b80
0x000c1b64 nop
0x000c1b68 addiu r3,r0,0x1000
0x000c1b6c sw r3,0x0060(r17)
0x000c1b70 addu r2,r3,r0
0x000c1b74 sw r2,0x0064(r17)
0x000c1b78 beq r0,r0,0x000c1bb0
0x000c1b7c sw r3,0x0068(r17)
0x000c1b80 lh r2,0x0000(r16)
0x000c1b84 addiu r3,r16,0x0002
0x000c1b88 addu r16,r3,r0
0x000c1b8c sw r2,0x0060(r17)
0x000c1b90 lh r2,0x0000(r16)
0x000c1b94 addiu r3,r16,0x0002
0x000c1b98 addu r16,r3,r0
0x000c1b9c sw r2,0x0064(r17)
0x000c1ba0 lh r2,0x0000(r16)
0x000c1ba4 addiu r3,r16,0x0002
0x000c1ba8 addu r16,r3,r0
0x000c1bac sw r2,0x0068(r17)
0x000c1bb0 lh r2,0x0000(r16)
0x000c1bb4 addiu r3,r16,0x0002
0x000c1bb8 addu r16,r3,r0
0x000c1bbc sh r2,0x0070(r17)
0x000c1bc0 lh r2,0x0000(r16)
0x000c1bc4 addiu r3,r16,0x0002
0x000c1bc8 addu r16,r3,r0
0x000c1bcc sh r2,0x0072(r17)
0x000c1bd0 lh r2,0x0000(r16)
0x000c1bd4 addiu r3,r16,0x0002
0x000c1bd8 addu r16,r3,r0
0x000c1bdc sh r2,0x0074(r17)
0x000c1be0 lh r2,0x0000(r16)
0x000c1be4 addiu r3,r16,0x0002
0x000c1be8 addu r16,r3,r0
0x000c1bec sw r2,0x0078(r17)
0x000c1bf0 lh r2,0x0000(r16)
0x000c1bf4 addiu r3,r16,0x0002
0x000c1bf8 addu r16,r3,r0
0x000c1bfc sw r2,0x007c(r17)
0x000c1c00 lh r2,0x0000(r16)
0x000c1c04 addiu r3,r16,0x0002
0x000c1c08 addu r16,r3,r0
0x000c1c0c sw r2,0x0080(r17)
0x000c1c10 jal 0x000c1798
0x000c1c14 addu r4,r19,r0
0x000c1c18 jal 0x000c19a4
0x000c1c1c addu r4,r17,r0
0x000c1c20 addi r18,r18,0x0001
0x000c1c24 addiu r19,r19,0x0052
0x000c1c28 addiu r17,r17,0x0088
0x000c1c2c slt r1,r18,r21
0x000c1c30 bne r1,r0,0x000c1b60
0x000c1c34 nop
0x000c1c38 sw r16,0x0014(r20)
0x000c1c3c lw r31,0x002c(r29)
0x000c1c40 lw r22,0x0028(r29)
0x000c1c44 lw r21,0x0024(r29)
0x000c1c48 lw r20,0x0020(r29)
0x000c1c4c lw r19,0x001c(r29)
0x000c1c50 lw r18,0x0018(r29)
0x000c1c54 lw r17,0x0014(r29)
0x000c1c58 lw r16,0x0010(r29)
0x000c1c5c jr r31
0x000c1c60 addiu r29,r29,0x0030
