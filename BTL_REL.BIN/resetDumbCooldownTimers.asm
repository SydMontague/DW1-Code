void resetDumbCooldownTimers(combatPtr) {
  store(r4 + 0x0028, 0)
  store(r4 + 0x002A, 0)
  
  r2 = load(r4 + 0x0034) & 0xC7FF
  store(r4 + 0x0034, r2)
}

0x0005eb0c sh r0,0x0028(r4)
0x0005eb10 sh r0,0x002a(r4)
0x0005eb14 lhu r2,0x0034(r4)
0x0005eb18 nop
0x0005eb1c andi r2,r2,0xc7ff
0x0005eb20 jr r31
0x0005eb24 sh r2,0x0034(r4)