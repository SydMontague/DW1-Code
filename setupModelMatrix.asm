/**
 * Sets up the model matrix for a node.
 */
setupModelMatrix(nodePtr) {
  copy12toOffset20(nodePtr + 0x14, nodePtr + 0x78) // copy translation vector?
  rotVecToRotMatrix(nodePtr + 0x70, nodePtr + 0x14) // calculate rotation matrix
  scaleMatrix(nodePtr + 0x14, nodePtr + 0x60) // multiply rot matrix with scale
  
  store(nodePtr + 0x10, 0) // reset counter
}

0x000c19a4 addiu r29,r29,0xffe0
0x000c19a8 sw r31,0x001c(r29)
0x000c19ac sw r18,0x0018(r29)
0x000c19b0 sw r17,0x0014(r29)
0x000c19b4 sw r16,0x0010(r29)
0x000c19b8 addu r16,r4,r0
0x000c19bc addiu r18,r16,0x0010
0x000c19c0 addiu r4,r18,0x0004
0x000c19c4 addu r17,r4,r0
0x000c19c8 jal 0x0009b090
0x000c19cc addiu r5,r16,0x0078
0x000c19d0 addiu r4,r16,0x0070
0x000c19d4 jal 0x0009b804
0x000c19d8 addu r5,r17,r0
0x000c19dc addu r4,r17,r0
0x000c19e0 jal 0x0009b0c0
0x000c19e4 addiu r5,r16,0x0060
0x000c19e8 sw r0,0x0000(r18)
0x000c19ec lw r31,0x001c(r29)
0x000c19f0 lw r18,0x0018(r29)
0x000c19f4 lw r17,0x0014(r29)
0x000c19f8 lw r16,0x0010(r29)
0x000c19fc jr r31
0x000c1a00 addiu r29,r29,0x0020