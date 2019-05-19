/**
 * Returns the entityPtr to a given scriptIdPointer
 * and stores it's entityId in the given pointer.
 */
int loadEntityDataFromScriptId(scriptIdPtr) {
  scriptId = load(scriptIdPtr)
  
  if(scriptId == 0xFD) {
    store(scriptIdPtr, 0)
    entityPtr = load(0x12F344)
  }
  else if(scriptId == 0xFC) {
    store(scriptIdPtr, 1)
    entityPtr = load(0x12F348)
  }
  else {
    for(i = 0; i < 8; i++) {
      entityPtr = load(0x12F344 + (i + 2) * 4)
      lScriptId = load(0x15588D + i * 0x68)
      
      if(entityPtr != 0 && scriptId == lScriptId) {
        store(scriptIdPtr, i + 2)
        break
      }
    }
  }
  
  return entityPtr
}

0x000ac2f8 lbu r3,0x0000(r4)
0x000ac2fc addiu r1,r0,0x00fd
0x000ac300 bne r3,r1,0x000ac31c
0x000ac304 addu r9,r3,r0
0x000ac308 sb r0,0x0000(r4)
0x000ac30c lui r1,0x8013
0x000ac310 lw r2,-0x0cbc(r1)
0x000ac314 beq r0,r0,0x000ac3c0
0x000ac318 nop
0x000ac31c addiu r1,r0,0x00fc
0x000ac320 bne r9,r1,0x000ac340
0x000ac324 addu r6,r0,r0
0x000ac328 addiu r2,r0,0x0001
0x000ac32c sb r2,0x0000(r4)
0x000ac330 lui r1,0x8013
0x000ac334 lw r2,-0x0cb8(r1)
0x000ac338 beq r0,r0,0x000ac3c0
0x000ac33c nop
0x000ac340 addiu r7,r0,0x0002
0x000ac344 beq r0,r0,0x000ac3b4
0x000ac348 addu r8,r0,r0
0x000ac34c lui r5,0x8013
0x000ac350 sll r3,r7,0x02
0x000ac354 addiu r5,r5,0xf344
0x000ac358 addu r3,r5,r3
0x000ac35c lw r3,0x0000(r3)
0x000ac360 nop
0x000ac364 beq r3,r0,0x000ac3a8
0x000ac368 nop
0x000ac36c lui r3,0x8015
0x000ac370 addiu r3,r3,0x588d
0x000ac374 addu r3,r3,r8
0x000ac378 lbu r3,0x0000(r3)
0x000ac37c nop
0x000ac380 bne r9,r3,0x000ac3a8
0x000ac384 nop
0x000ac388 addi r2,r6,0x0002
0x000ac38c addu r3,r2,r0
0x000ac390 sb r2,0x0000(r4)
0x000ac394 sll r2,r3,0x02
0x000ac398 addu r2,r5,r2
0x000ac39c lw r2,0x0000(r2)
0x000ac3a0 beq r0,r0,0x000ac3c0
0x000ac3a4 nop
0x000ac3a8 addi r6,r6,0x0001
0x000ac3ac addi r8,r8,0x0068
0x000ac3b0 addi r7,r7,0x0001
0x000ac3b4 slti r1,r6,0x0008
0x000ac3b8 bne r1,r0,0x000ac34c
0x000ac3bc nop
0x000ac3c0 jr r31
0x000ac3c4 nop