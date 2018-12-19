/**
 * Deallocates the array from the given address from the memory offset defined
 * at 0x134F64, by reading the head denominating the size of the array.
 */
void freeArray(int arrayPtr) {
  arraySize = load(arrayPtr - 4)
  offset = load(0x134F64)
  
  store(0x134F64, offset - (arraySize + 4)) 
}

0x000fc310 lw r3,-0x0004(r4)
0x000fc314 lw r2,-0x6bc8(r28)
0x000fc318 addiu r3,r3,0x0004
0x000fc31c subu r2,r2,r3
0x000fc320 jr r31
0x000fc324 sw r2,-0x6bc8(r28)