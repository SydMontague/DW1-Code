int getScript(scriptId) {
  if(scriptId == 0)
    return load(0x134FAC) // MapHead Script
  
  if(load(0x134FC2) == scriptId) // current map script is the requested one
    return load(0x134FB4) // current map script
  
  scriptHead = load(0x134FB0) // Global Script
  store(0x134FC2, scriptId)
  
  scriptStart = load(scriptHead + scriptId * 4)
  scriptTarget = load(0x134FB4)
  scriptSize = load(scriptHead + scriptId * 4 + 4) - scriptStart
  
  loadFileSection(0x130388, scriptTarget, scriptStart, scriptSize) // 0x130388 points to "\SCN\DG.SCN"
  
  return scriptTarget
}

0x00106218 addiu r29,r29,0xffe8
0x0010621c bne r4,r0,0x00106230
0x00106220 sw r31,0x0010(r29)
0x00106224 lw r2,-0x6b80(r28)
0x00106228 beq r0,r0,0x00106290
0x0010622c lw r31,0x0010(r29)
0x00106230 lhu r2,-0x6b6a(r28)
0x00106234 nop
0x00106238 bne r2,r4,0x0010624c
0x0010623c nop
0x00106240 lw r2,-0x6b78(r28)
0x00106244 beq r0,r0,0x00106290
0x00106248 lw r31,0x0010(r29)
0x0010624c lw r3,-0x6b7c(r28)
0x00106250 sll r2,r4,0x02
0x00106254 sh r4,-0x6b6a(r28)
0x00106258 addu r2,r3,r2
0x0010625c lw r6,0x0000(r2)
0x00106260 lw r5,-0x6b78(r28)
0x00106264 addi r2,r4,0x0001
0x00106268 sll r2,r2,0x02
0x0010626c addu r2,r3,r2
0x00106270 lw r2,0x0000(r2)
0x00106274 lui r4,0x8013
0x00106278 subu r7,r2,r6
0x0010627c jal 0x001026e8
0x00106280 addiu r4,r4,0x0388
0x00106284 lw r2,-0x6b78(r28)
0x00106288 nop
0x0010628c lw r31,0x0010(r29)
0x00106290 nop
0x00106294 jr r31
0x00106298 addiu r29,r29,0x0018