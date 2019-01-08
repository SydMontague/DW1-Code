/**
 * Clears a sub-area of the frame buffer based on a given array.
 *
 * posX, posY = array[0] + 704, array[1] + 256
 * sizeX, sizeY = array[2] / 4, array[3]
 */
void clearTextSubArea(array) {
  array[0] = array[0] / 4 + 0x2C0
  array[1] = array[1] + 0x100
  array[2] = array[2] / 4
  
  clearImage(array, 0, 0, 0)
}

0x0010cbc4 lh r2,0x0000(r4)
0x0010cbc8 nop
0x0010cbcc bgez r2,0x0010cbdc
0x0010cbd0 sra r25,r2,0x02
0x0010cbd4 addiu r2,r2,0x0003
0x0010cbd8 sra r25,r2,0x02
0x0010cbdc addi r2,r25,0x02c0
0x0010cbe0 sh r2,0x0000(r4)
0x0010cbe4 lh r2,0x0002(r4)
0x0010cbe8 addu r5,r0,r0
0x0010cbec addi r2,r2,0x0100
0x0010cbf0 sh r2,0x0002(r4)
0x0010cbf4 lh r2,0x0004(r4)
0x0010cbf8 addu r6,r0,r0
0x0010cbfc sra r2,r2,0x02
0x0010cc00 sh r2,0x0004(r4)
0x0010cc04 j 0x00094818
0x0010cc08 addu r7,r0,r0