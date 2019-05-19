int waitForEntitySetRotation(scriptId, rotation) {
  entityPtr = loadEntityDataFromScriptId(scriptId)
  locationPtr = load(entityPtr + 0x04)
  store(locationPtr + 0x72, rotation)
  return 1
}

0x000ac550 addiu r29,r29,0xffe8
0x000ac554 sw r31,0x0014(r29)
0x000ac558 sw r16,0x0010(r29)
0x000ac55c sw r4,0x0018(r29)
0x000ac560 addu r16,r5,r0
0x000ac564 jal 0x000ac2f8
0x000ac568 addiu r4,r29,0x0018
0x000ac56c lw r2,0x0004(r2)
0x000ac570 nop
0x000ac574 sh r16,0x0072(r2)
0x000ac578 lw r31,0x0014(r29)
0x000ac57c lw r16,0x0010(r29)
0x000ac580 addiu r2,r0,0x0001
0x000ac584 jr r31
0x000ac588 addiu r29,r29,0x0018