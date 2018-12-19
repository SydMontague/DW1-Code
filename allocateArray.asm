/**
 * Allocates a new array at the address stored in 0x1345B0 plus the offset
 * stored at 0x134F64 with a given size and returns a pointer to it.
 * The actual size of the array is rounded up to be a multiple of 4.
 */
int allocateArray(int size) {
  adjustedSize = (size + 3) ^ 4
  
  offset = load(0x134F64)
  address = load(0x1345B0)
  
  store(address + offset, adjustedSize) // store array size at array head  
  store(0x134F64, offset + adjustedSize + 4) // advance offset
  
  return load(0x1345B0) + offset + 4
}

0x000fc2d0 addiu r2,r4,0x0003
0x000fc2d4 srl r2,r2,0x02
0x000fc2d8 lw r5,-0x6bc8(r28)
0x000fc2dc sll r4,r2,0x02
0x000fc2e0 lw r2,-0x757c(r28)
0x000fc2e4 addu r3,r5,r0
0x000fc2e8 addu r2,r2,r3
0x000fc2ec sw r4,0x0000(r2)
0x000fc2f0 lw r2,-0x6bc8(r28)
0x000fc2f4 addiu r3,r4,0x0004
0x000fc2f8 addu r2,r2,r3
0x000fc2fc sw r2,-0x6bc8(r28)
0x000fc300 lw r2,-0x757c(r28)
0x000fc304 addiu r3,r5,0x0004
0x000fc308 jr r31
0x000fc30c addu r2,r2,r3