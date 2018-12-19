/**
 * Sets an object in the object table, handling what is getting rendered.
 *
 * 2 byte objectId
 * 2 byte instanceId
 * 4 byte unknown function pointer
 * 4 byte unknown function pointer
 *
 * returns 1 on success, 0 on failure
 */
int setObject(int objectId, int instanceId, int funcPtr1, int funcPtr2) {
  store(0x137A18, -1)
  
  i = 0
  
  while(load(0x137418 + i * 12) != -1)
    i++
    
  if(i == 0x80)
    return 0
      
  store(0x137418 + i * 12, objectId)
  store(0x13741A + i * 12, instanceId)
  store(0x13741C + i * 12, funcPtr1)
  store(0x137420 + i * 12, funcPtr2)
  
  return 1
}

0x000a2f64 addiu r2,r0,0xffff
0x000a2f68 lui r1,0x8013
0x000a2f6c sh r2,0x7a18(r1)
0x000a2f70 addu r8,r0,r0
0x000a2f74 addu r9,r0,r0
0x000a2f78 lui r3,0x8013
0x000a2f7c addiu r3,r3,0x7418
0x000a2f80 addu r2,r3,r9
0x000a2f84 lh r2,0x0000(r2)
0x000a2f88 addiu r1,r0,0xffff
0x000a2f8c beq r2,r1,0x000a2fa0
0x000a2f90 nop
0x000a2f94 addi r8,r8,0x0001
0x000a2f98 beq r0,r0,0x000a2f78
0x000a2f9c addi r9,r9,0x000c
0x000a2fa0 addiu r1,r0,0x0080
0x000a2fa4 bne r8,r1,0x000a2fb4
0x000a2fa8 nop
0x000a2fac beq r0,r0,0x000a3000
0x000a2fb0 addu r2,r0,r0
0x000a2fb4 sll r2,r8,0x01
0x000a2fb8 add r2,r2,r8
0x000a2fbc sll r2,r2,0x02
0x000a2fc0 addu r8,r2,r0
0x000a2fc4 addu r2,r3,r2
0x000a2fc8 sh r4,0x0000(r2)
0x000a2fcc lui r2,0x8013
0x000a2fd0 addiu r2,r2,0x741a
0x000a2fd4 addu r2,r2,r8
0x000a2fd8 sh r5,0x0000(r2)
0x000a2fdc lui r2,0x8013
0x000a2fe0 addiu r2,r2,0x741c
0x000a2fe4 addu r2,r2,r8
0x000a2fe8 sw r6,0x0000(r2)
0x000a2fec lui r2,0x8013
0x000a2ff0 addiu r2,r2,0x7420
0x000a2ff4 addu r2,r2,r8
0x000a2ff8 sw r7,0x0000(r2)
0x000a2ffc addiu r2,r0,0x0001
0x000a3000 jr r31
0x000a3004 nop