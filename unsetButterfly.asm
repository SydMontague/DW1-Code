void unsetButterfly(instanceId) {
  if(instanceId < 0)
    return
  
  store(0x155430 + r5 * 8, -1)
  unsetObject(0x080E, instanceId)
}

0x000e9fb4 addiu r29,r29,0xffe8
0x000e9fb8 addu r5,r4,r0
0x000e9fbc bltz r5,0x000e9fe4
0x000e9fc0 sw r31,0x0010(r29)
0x000e9fc4 lui r2,0x8015
0x000e9fc8 sll r3,r5,0x03
0x000e9fcc addiu r2,r2,0x5430
0x000e9fd0 addiu r4,r0,0xffff
0x000e9fd4 addu r2,r2,r3
0x000e9fd8 sh r4,0x0000(r2)
0x000e9fdc jal 0x000a3008
0x000e9fe0 addiu r4,r0,0x080e
0x000e9fe4 lw r31,0x0010(r29)
0x000e9fe8 nop
0x000e9fec jr r31
0x000e9ff0 addiu r29,r29,0x0018