0x001053EC() {
  value = readPStat(6)
  
  if(value == 2)
    store(0x134FA0, 0)
  else if(value == 1)
    store(0x134FA0, 1)
  else if(value == 0)
    store(0x134FA0, load(0x134FE0) == 0 ? 1 : 0)
    
  writePStat(6, 0)
}

0x001053ec addiu r29,r29,0xffe8
0x001053f0 sw r31,0x0010(r29)
0x001053f4 jal 0x001062e0
0x001053f8 addiu r4,r0,0x0006
0x001053fc andi r2,r2,0x00ff
0x00105400 addiu r1,r0,0x0002
0x00105404 beq r2,r1,0x00105444
0x00105408 nop
0x0010540c addiu r1,r0,0x0001
0x00105410 beq r2,r1,0x00105438
0x00105414 nop
0x00105418 bne r2,r0,0x00105448
0x0010541c nop
0x00105420 lw r2,-0x6b4c(r28)
0x00105424 nop
0x00105428 sltu r2,r0,r2
0x0010542c xori r2,r2,0x0001
0x00105430 beq r0,r0,0x00105448
0x00105434 sw r2,-0x6b8c(r28)
0x00105438 addiu r2,r0,0x0001
0x0010543c beq r0,r0,0x00105448
0x00105440 sw r2,-0x6b8c(r28)
0x00105444 sw r0,-0x6b8c(r28)
0x00105448 addiu r4,r0,0x0006
0x0010544c jal 0x00106474
0x00105450 addu r5,r0,r0
0x00105454 lw r31,0x0010(r29)
0x00105458 nop
0x0010545c jr r31
0x00105460 addiu r29,r29,0x0018