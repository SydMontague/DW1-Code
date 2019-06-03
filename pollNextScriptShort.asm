int pollNextScriptShort() {
  scriptPtr = load(0x134FDC)
  
  value = load(scriptPtr)
  store(0x134FDC, scriptPtr + 2)
  
  return value
}


0x00106a30 lw r2,-0x6b50(r28)
0x00106a34 nop
0x00106a38 lh r2,0x0000(r2)
0x00106a3c nop
0x00106a40 sh r2,0x0000(r4)
0x00106a44 lw r2,-0x6b50(r28)
0x00106a48 nop
0x00106a4c addi r2,r2,0x0002
0x00106a50 jr r31
0x00106a54 sw r2,-0x6b50(r28)