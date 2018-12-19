/**
 * Unsets an object in the object table, handling what is getting rendered.
 *
 * 2 byte objectId
 * 2 byte instanceId
 * 4 byte unknown function pointer
 * 4 byte unknown function pointer
 *
 * returns 1 on success, 0 on failure
 */
int unsetObject(objectId, instanceId) {
  store(0x137A18, objectId)   // for loop end condition
  store(0x137A1A, instanceId) // for loop end condition
  
  i = 0
  
  // will always break at i = 0x80 or sooner
  while(true) {
    lObjectId = load(0x137418 + i * 0x0C)
    lInstanceId = load(0x13741A + i * 0x0C)
    
    if(objectId == lObjectId && instanceId == lInstanceId)
        break
    
    i++
  }
  
  if(i == 0x80)
    return 0
  
  store(0x137418 + i * 0x0C, -1)
  store(0x13741A + i * 0x0C, -1)
  store(0x13741C + i * 0x0C, 0)
  store(0x137420 + i * 0x0C, 0)
  
  return 1
}

0x000a3008 lui r1,0x8013
0x000a300c sh r4,0x7a18(r1)
0x000a3010 lui r1,0x8013
0x000a3014 sh r5,0x7a1a(r1)
0x000a3018 addu r8,r0,r0
0x000a301c addu r3,r0,r0
0x000a3020 lui r7,0x8013
0x000a3024 addiu r7,r7,0x7418
0x000a3028 addu r2,r7,r3
0x000a302c lh r2,0x0000(r2)
0x000a3030 nop
0x000a3034 bne r4,r2,0x000a3058
0x000a3038 nop
0x000a303c lui r6,0x8013
0x000a3040 addiu r6,r6,0x741a
0x000a3044 addu r2,r6,r3
0x000a3048 lh r2,0x0000(r2)
0x000a304c nop
0x000a3050 beq r5,r2,0x000a3064
0x000a3054 nop
0x000a3058 addi r8,r8,0x0001
0x000a305c beq r0,r0,0x000a3020
0x000a3060 addi r3,r3,0x000c
0x000a3064 addiu r1,r0,0x0080
0x000a3068 bne r8,r1,0x000a3078
0x000a306c nop
0x000a3070 beq r0,r0,0x000a30c0
0x000a3074 addu r2,r0,r0
0x000a3078 sll r2,r8,0x01
0x000a307c add r2,r2,r8
0x000a3080 sll r2,r2,0x02
0x000a3084 addu r4,r2,r0
0x000a3088 addiu r3,r0,0xffff
0x000a308c addu r2,r7,r2
0x000a3090 sh r3,0x0000(r2)
0x000a3094 addu r2,r6,r4
0x000a3098 sh r3,0x0000(r2)
0x000a309c lui r2,0x8013
0x000a30a0 addiu r2,r2,0x741c
0x000a30a4 addu r2,r2,r4
0x000a30a8 sw r0,0x0000(r2)
0x000a30ac lui r2,0x8013
0x000a30b0 addiu r2,r2,0x7420
0x000a30b4 addu r2,r2,r4
0x000a30b8 sw r0,0x0000(r2)
0x000a30bc addiu r2,r0,0x0001
0x000a30c0 jr r31
0x000a30c4 nop