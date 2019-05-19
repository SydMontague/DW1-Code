void setCooldown(entityPtr, combatPtr) {
  store(combatPtr + 0x28, 80)
  
  flags = load(combatPtr + 0x34) | 0x0800
  store(r5 + 0x34, flags)
}

0x0005ef3c addiu r2,r0,0x0050
0x0005ef40 sh r2,0x0028(r5)
0x0005ef44 lhu r2,0x0034(r5)
0x0005ef48 nop
0x0005ef4c ori r2,r2,0x0800
0x0005ef50 jr r31
0x0005ef54 sh r2,0x0034(r5)