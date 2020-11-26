void renderTrainingResult() {
    clearTextArea()

    for(r16 = 0; r16 < 6; r16++) 
        if(load(0x13D468 + r16 * 2) == 0)
            store(0x135398 + r16, 0)
        else
            store(0x135398 + r16, 1)
    
    for(i = 0; i < 4; i++) {
        if(i < 3) {
            offset = i * 2
            renderString(0x124C0C + (offset + 0) * 12, 0, (offset + 0) * 12)
            renderString(0x124C0C + (offset + 1) * 12, 0, (offset + 1) * 12) 
        }
        if(i == 3) {
            renderString(0x134BC0, 0, 84)
            renderString(0x124C54, 0, 240)
        }
        drawSync(0)
    }

    store(0x13539E, 100)
    store(sp + 0x38, 0xFFA2)
    store(sp + 0x3A, 0xFFB2)
    store(sp + 0x3C, 0x00BC)
    store(sp + 0x3E, 0x60)

    posX, posY = getModelObjectScreenPos(load(0x12F348), 1)

    store(sp + 0x40, posX - 5)
    store(sp + 0x42, posY - 5)
    store(sp + 0x44, 10)
    store(sp + 0x46, 10)

    0x000C3014(1, 0, 2, sp + 0x38, sp + 0x40, 0x8D770, 0x8D8E4) // probably render the box
}

0x0008d594 addiu r29,r29,0xffb8
0x0008d598 sw r31,0x002c(r29)
0x0008d59c sw r18,0x0028(r29)
0x0008d5a0 sw r17,0x0024(r29)
0x0008d5a4 sw r16,0x0020(r29)
0x0008d5a8 sw r0,-0x6798(r28)
0x0008d5ac jal 0x0010cb90
0x0008d5b0 nop
0x0008d5b4 addu r16,r0,r0
0x0008d5b8 beq r0,r0,0x0008d604
0x0008d5bc addu r4,r0,r0
0x0008d5c0 lui r2,0x8014
0x0008d5c4 addiu r2,r2,0xd468
0x0008d5c8 addu r2,r2,r4
0x0008d5cc lh r2,0x0000(r2)
0x0008d5d0 nop
0x0008d5d4 bne r2,r0,0x0008d5ec
0x0008d5d8 nop
0x0008d5dc addiu r2,r28,0x986c
0x0008d5e0 addu r2,r2,r16
0x0008d5e4 beq r0,r0,0x0008d5fc
0x0008d5e8 sb r0,0x0000(r2)
0x0008d5ec addiu r2,r28,0x986c
0x0008d5f0 addiu r3,r0,0x0001
0x0008d5f4 addu r2,r2,r16
0x0008d5f8 sb r3,0x0000(r2)
0x0008d5fc addi r16,r16,0x0001
0x0008d600 addi r4,r4,0x0002
0x0008d604 slti r1,r16,0x0006
0x0008d608 bne r1,r0,0x0008d5c0
0x0008d60c nop
0x0008d610 addu r16,r0,r0
0x0008d614 addu r18,r0,r0
0x0008d618 beq r0,r0,0x0008d6b8
0x0008d61c addu r17,r0,r0
0x0008d620 slti r1,r16,0x0003
0x0008d624 beq r1,r0,0x0008d674
0x0008d628 nop
0x0008d62c sll r2,r17,0x01
0x0008d630 add r2,r2,r17
0x0008d634 sll r3,r2,0x02
0x0008d638 lui r2,0x8012
0x0008d63c addiu r2,r2,0x4c0c
0x0008d640 addu r4,r2,r3
0x0008d644 sll r6,r18,0x01
0x0008d648 jal 0x0010cf24
0x0008d64c addu r5,r0,r0
0x0008d650 addi r3,r17,0x0001
0x0008d654 sll r2,r3,0x01
0x0008d658 add r2,r2,r3
0x0008d65c sll r6,r2,0x02
0x0008d660 lui r2,0x8012
0x0008d664 addiu r2,r2,0x4c0c
0x0008d668 addu r4,r2,r6
0x0008d66c jal 0x0010cf24
0x0008d670 addu r5,r0,r0
0x0008d674 addiu r1,r0,0x0003
0x0008d678 bne r16,r1,0x0008d6a4
0x0008d67c nop
0x0008d680 addiu r4,r28,0x9094
0x0008d684 addu r5,r0,r0
0x0008d688 jal 0x0010cf24
0x0008d68c addiu r6,r0,0x0054
0x0008d690 lui r4,0x8012
0x0008d694 addiu r4,r4,0x4c54
0x0008d698 addu r5,r0,r0
0x0008d69c jal 0x0010cf24
0x0008d6a0 addiu r6,r0,0x00f0
0x0008d6a4 jal 0x000947b0
0x0008d6a8 addu r4,r0,r0
0x0008d6ac addi r16,r16,0x0001
0x0008d6b0 addi r17,r17,0x0002
0x0008d6b4 addi r18,r18,0x000c
0x0008d6b8 slti r1,r16,0x0004
0x0008d6bc bne r1,r0,0x0008d620
0x0008d6c0 nop
0x0008d6c4 addiu r2,r0,0x0064
0x0008d6c8 sh r2,-0x678e(r28)
0x0008d6cc addiu r2,r0,0xffa2
0x0008d6d0 sh r2,0x0038(r29)
0x0008d6d4 addiu r2,r0,0xffb2
0x0008d6d8 sh r2,0x003a(r29)
0x0008d6dc addiu r2,r0,0x00bc
0x0008d6e0 sh r2,0x003c(r29)
0x0008d6e4 lui r1,0x8013
0x0008d6e8 addiu r2,r0,0x0060
0x0008d6ec lw r4,-0x0cb8(r1)
0x0008d6f0 sh r2,0x003e(r29)
0x0008d6f4 addiu r5,r0,0x0001
0x0008d6f8 jal 0x000e52d8
0x0008d6fc addiu r6,r29,0x0034
0x0008d700 lh r2,0x0034(r29)
0x0008d704 addiu r4,r0,0x0001
0x0008d708 addi r2,r2,-0x0005
0x0008d70c sh r2,0x0040(r29)
0x0008d710 lh r2,0x0036(r29)
0x0008d714 addu r5,r0,r0
0x0008d718 addi r2,r2,-0x0005
0x0008d71c sh r2,0x0042(r29)
0x0008d720 addiu r2,r0,0x000a
0x0008d724 sh r2,0x0044(r29)
0x0008d728 sh r2,0x0046(r29)
0x0008d72c addiu r2,r29,0x0040
0x0008d730 sw r2,0x0010(r29)
0x0008d734 lui r2,0x8009
0x0008d738 addiu r2,r2,0xd770
0x0008d73c sw r2,0x0014(r29)
0x0008d740 lui r2,0x8009
0x0008d744 addiu r2,r2,0xd8e4
0x0008d748 sw r2,0x0018(r29)
0x0008d74c addiu r6,r0,0x0002
0x0008d750 jal 0x000c3014
0x0008d754 addiu r7,r29,0x0038
0x0008d758 lw r31,0x002c(r29)
0x0008d75c lw r18,0x0028(r29)
0x0008d760 lw r17,0x0024(r29)
0x0008d764 lw r16,0x0020(r29)
0x0008d768 jr r31
0x0008d76c addiu r29,r29,0x0048
