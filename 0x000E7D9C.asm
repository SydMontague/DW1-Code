0x000E7D9C(int entityId, int symbolId) {
  
  offset = (entityId - 2) * 0x0C
  
  store(0x154FCC + offset, 0)
  store(0x154FCE + offset, symbolId)
  
  setObject(0x196, entityId, 0, 0x800E7DEC)
}

0x000e7d9c addi r3,r4,-0x0002
0x000e7da0 sll r2,r3,0x01
0x000e7da4 add r2,r2,r3
0x000e7da8 sll r3,r2,0x02
0x000e7dac lui r2,0x8015
0x000e7db0 addiu r2,r2,0x4fcc
0x000e7db4 addu r2,r2,r3
0x000e7db8 sh r0,0x0000(r2)
0x000e7dbc addu r6,r4,r0
0x000e7dc0 lui r2,0x8015
0x000e7dc4 lui r7,0x800e
0x000e7dc8 addu r4,r3,r0
0x000e7dcc addiu r2,r2,0x4fce
0x000e7dd0 addu r2,r2,r4
0x000e7dd4 sh r5,0x0000(r2)
0x000e7dd8 addu r5,r6,r0
0x000e7ddc addiu r4,r0,0x0196
0x000e7de0 addu r6,r0,r0
0x000e7de4 j 0x000a2f64
0x000e7de8 addiu r7,r7,0x7dec