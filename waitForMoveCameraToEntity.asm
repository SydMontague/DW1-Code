int waitForMoveCameraToEntity(scriptId, instanceId) {
  storeEntityLocation(scriptId, 0x150C7C)
  return spawnCameraMovement(instanceId)
}

0x000d88fc addu r8,r5,r0
0x000d8900 addiu r29,r29,0xffe8
0x000d8904 lui r5,0x8015
0x000d8908 sw r31,0x0010(r29)
0x000d890c jal 0x000d8780
0x000d8910 addiu r5,r5,0x0c7c
0x000d8914 jal 0x000d8860
0x000d8918 addu r4,r8,r0
0x000d891c lw r31,0x0010(r29)
0x000d8920 nop
0x000d8924 jr r31
0x000d8928 addiu r29,r29,0x0018