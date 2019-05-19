int pollNextScriptByte(ptr) {
  scriptPtr = load(0x134FDC)
  store(ptr, load(scriptPtr))
  store(0x134FDC, scriptPtr + 1)
}

0x00106598 lw r2,-0x6b50(r28)
0x0010659c nop
0x001065a0 lbu r2,0x0000(r2)
0x001065a4 nop
0x001065a8 sb r2,0x0000(r4)
0x001065ac lw r2,-0x6b50(r28)
0x001065b0 nop
0x001065b4 addiu r2,r2,0x0001
0x001065b8 jr r31
0x001065bc sw r2,-0x6b50(r28)