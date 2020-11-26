int getTrainingFactor(digimonType, stationType, mode) {
    // training type effect
    trainingType = load(0x1225D0 + digimonType * 28) // training type
    factor = 8 // filth

    switch(stationType) {
        case 0: // HP
        case 3: // Def
            if(trainingType == 0 || trainingType == 1)
                factor = 10
            else if(trainingType == 2)
                factor = 9
            else if(trainingType == 3)
                factor = 11
            break
        case 1: // MP
        case 5: // Brains
            if(trainingType == 0 || trainingType == 3)
                factor = 10
            else if(trainingType == 1)
                factor = 9
            else if(trainingType == 2)
                factor = 11
            break
        case 2: // Off
        case 4: // Speed
            if(trainingType == 0 || trainingType == 2)
                factor = 10
            else if(trainingType == 3)
                factor = 9
            else if(trainingType == 1)
                factor = 11
            break
        default:
            factor = 0 // invalid station
    }

    divisor = 100

    // level
    switch(load(0x12CED1 + digimonType * 52)) { // level
        case 1:
        case 2:
            factor = factor * 9
        case 3:
            factor = factor * 10
        case 4:
            factor = factor * 11
        case 5:
            factor = factor * 12
    }

    if(mode == 0) {
        // Kabuterimon/Kuwagamon boost
        if((stationType == 0 || stationType == 3 || stationType == 4) && isTriggerSet(219)) { // Kabuterimon
            factor = factor * 6
            divisor = divisor * 5
        }
        if((stationType == 1 || stationType == 2 || stationType == 5) && isTrigger(251)) { // Kuwagamon
            factor = factor * 6
            divisor = divisor * 5
        }

        // baby boost
        if(stationType == 0 || stationType == 1 || stationType == 2) {
            if(load(0x1384C6 + stationType * 2) >= 10) {
                factor = factor * 6
                divisor = divisor * 5
            }
        }
        if(stationType == 3 || stationType == 4 || stationType == 5) {
            if(load(0x1384CE + (stationType - 3) * 2) >= 10) {
                factor = factor * 6
                divisor = divisor * 5
            }
        }
    }

    if(getItemCount(21) > 0) { // Training Manual
        factor = factor * 11
        divisor = divisor * 10
    }

    return factor * 10 / divisor
}

0x00089e08 addiu r29,r29,0xffd8
0x00089e0c sll r2,r4,0x03
0x00089e10 sw r31,0x0020(r29)
0x00089e14 sub r2,r2,r4
0x00089e18 sw r19,0x001c(r29)
0x00089e1c sw r18,0x0018(r29)
0x00089e20 addu r18,r5,r0
0x00089e24 sll r3,r2,0x02
0x00089e28 lui r2,0x8012
0x00089e2c sw r17,0x0014(r29)
0x00089e30 addiu r2,r2,0x25d0
0x00089e34 sw r16,0x0010(r29)
0x00089e38 addu r2,r2,r3
0x00089e3c lbu r5,0x0000(r2)
0x00089e40 addu r16,r0,r0
0x00089e44 sltiu r1,r18,0x0006
0x00089e48 beq r1,r0,0x0008a030
0x00089e4c addu r19,r18,r0
0x00089e50 lui r3,0x8009
0x00089e54 addiu r3,r3,0xf01c
0x00089e58 sll r2,r18,0x02
0x00089e5c addu r2,r2,r3
0x00089e60 lw r2,0x0000(r2)
0x00089e64 nop
0x00089e68 jr r2
0x00089e6c nop
0x00089e70 beq r5,r0,0x00089e84
0x00089e74 nop
0x00089e78 addiu r1,r0,0x0001
0x00089e7c bne r5,r1,0x00089e8c
0x00089e80 nop
0x00089e84 beq r0,r0,0x0008a030
0x00089e88 addiu r16,r0,0x000a
0x00089e8c addiu r1,r0,0x0002
0x00089e90 bne r5,r1,0x00089ea0
0x00089e94 nop
0x00089e98 beq r0,r0,0x0008a030
0x00089e9c addiu r16,r0,0x0009
0x00089ea0 addiu r1,r0,0x0003
0x00089ea4 bne r5,r1,0x00089eb4
0x00089ea8 nop
0x00089eac beq r0,r0,0x0008a030
0x00089eb0 addiu r16,r0,0x000b
0x00089eb4 beq r0,r0,0x0008a030
0x00089eb8 addiu r16,r0,0x0008
0x00089ebc beq r5,r0,0x00089ed0
0x00089ec0 nop
0x00089ec4 addiu r1,r0,0x0003
0x00089ec8 bne r5,r1,0x00089ed8
0x00089ecc nop
0x00089ed0 beq r0,r0,0x0008a030
0x00089ed4 addiu r16,r0,0x000a
0x00089ed8 addiu r1,r0,0x0001
0x00089edc bne r5,r1,0x00089eec
0x00089ee0 nop
0x00089ee4 beq r0,r0,0x0008a030
0x00089ee8 addiu r16,r0,0x0009
0x00089eec addiu r1,r0,0x0002
0x00089ef0 bne r5,r1,0x00089f00
0x00089ef4 nop
0x00089ef8 beq r0,r0,0x0008a030
0x00089efc addiu r16,r0,0x000b
0x00089f00 beq r0,r0,0x0008a030
0x00089f04 addiu r16,r0,0x0008
0x00089f08 beq r5,r0,0x00089f1c
0x00089f0c nop
0x00089f10 addiu r1,r0,0x0002
0x00089f14 bne r5,r1,0x00089f24
0x00089f18 nop
0x00089f1c beq r0,r0,0x0008a030
0x00089f20 addiu r16,r0,0x000a
0x00089f24 addiu r1,r0,0x0001
0x00089f28 bne r5,r1,0x00089f38
0x00089f2c nop
0x00089f30 beq r0,r0,0x0008a030
0x00089f34 addiu r16,r0,0x000b
0x00089f38 addiu r1,r0,0x0003
0x00089f3c bne r5,r1,0x00089f4c
0x00089f40 nop
0x00089f44 beq r0,r0,0x0008a030
0x00089f48 addiu r16,r0,0x0009
0x00089f4c beq r0,r0,0x0008a030
0x00089f50 addiu r16,r0,0x0008
0x00089f54 beq r5,r0,0x00089f68
0x00089f58 nop
0x00089f5c addiu r1,r0,0x0001
0x00089f60 bne r5,r1,0x00089f70
0x00089f64 nop
0x00089f68 beq r0,r0,0x0008a030
0x00089f6c addiu r16,r0,0x000a
0x00089f70 addiu r1,r0,0x0002
0x00089f74 bne r5,r1,0x00089f84
0x00089f78 nop
0x00089f7c beq r0,r0,0x0008a030
0x00089f80 addiu r16,r0,0x0009
0x00089f84 addiu r1,r0,0x0003
0x00089f88 bne r5,r1,0x00089f98
0x00089f8c nop
0x00089f90 beq r0,r0,0x0008a030
0x00089f94 addiu r16,r0,0x000b
0x00089f98 beq r0,r0,0x0008a030
0x00089f9c addiu r16,r0,0x0008
0x00089fa0 beq r5,r0,0x00089fb4
0x00089fa4 nop
0x00089fa8 addiu r1,r0,0x0002
0x00089fac bne r5,r1,0x00089fbc
0x00089fb0 nop
0x00089fb4 beq r0,r0,0x0008a030
0x00089fb8 addiu r16,r0,0x000a
0x00089fbc addiu r1,r0,0x0001
0x00089fc0 bne r5,r1,0x00089fd0
0x00089fc4 nop
0x00089fc8 beq r0,r0,0x0008a030
0x00089fcc addiu r16,r0,0x000b
0x00089fd0 addiu r1,r0,0x0003
0x00089fd4 bne r5,r1,0x00089fe4
0x00089fd8 nop
0x00089fdc beq r0,r0,0x0008a030
0x00089fe0 addiu r16,r0,0x0009
0x00089fe4 beq r0,r0,0x0008a030
0x00089fe8 addiu r16,r0,0x0008
0x00089fec beq r5,r0,0x0008a000
0x00089ff0 nop
0x00089ff4 addiu r1,r0,0x0003
0x00089ff8 bne r5,r1,0x0008a008
0x00089ffc nop
0x0008a000 beq r0,r0,0x0008a030
0x0008a004 addiu r16,r0,0x000a
0x0008a008 addiu r1,r0,0x0001
0x0008a00c bne r5,r1,0x0008a01c
0x0008a010 nop
0x0008a014 beq r0,r0,0x0008a030
0x0008a018 addiu r16,r0,0x0009
0x0008a01c addiu r1,r0,0x0002
0x0008a020 bne r5,r1,0x0008a030
0x0008a024 addiu r16,r0,0x0008
0x0008a028 beq r0,r0,0x0008a030
0x0008a02c addiu r16,r0,0x000b
0x0008a030 sll r2,r4,0x01
0x0008a034 add r2,r2,r4
0x0008a038 sll r2,r2,0x02
0x0008a03c add r2,r2,r4
0x0008a040 sll r3,r2,0x02
0x0008a044 lui r2,0x8013
0x0008a048 addiu r2,r2,0xced1
0x0008a04c addu r2,r2,r3
0x0008a050 lbu r2,0x0000(r2)
0x0008a054 addiu r17,r0,0x000a
0x0008a058 addiu r1,r0,0x0001
0x0008a05c beq r2,r1,0x0008a070
0x0008a060 addu r3,r2,r0
0x0008a064 addiu r1,r0,0x0002
0x0008a068 bne r3,r1,0x0008a07c
0x0008a06c nop
0x0008a070 sll r2,r16,0x03
0x0008a074 beq r0,r0,0x0008a0c4
0x0008a078 add r16,r2,r16
0x0008a07c addiu r1,r0,0x0003
0x0008a080 bne r3,r1,0x0008a098
0x0008a084 nop
0x0008a088 sll r2,r16,0x02
0x0008a08c add r2,r2,r16
0x0008a090 beq r0,r0,0x0008a0c4
0x0008a094 sll r16,r2,0x01
0x0008a098 addiu r1,r0,0x0004
0x0008a09c bne r3,r1,0x0008a0b8
0x0008a0a0 nop
0x0008a0a4 sll r2,r16,0x02
0x0008a0a8 add r2,r2,r16
0x0008a0ac sll r2,r2,0x01
0x0008a0b0 beq r0,r0,0x0008a0c4
0x0008a0b4 add r16,r2,r16
0x0008a0b8 sll r2,r16,0x01
0x0008a0bc add r2,r2,r16
0x0008a0c0 sll r16,r2,0x02
0x0008a0c4 sll r2,r17,0x02
0x0008a0c8 add r2,r2,r17
0x0008a0cc bne r6,r0,0x0008a220
0x0008a0d0 sll r17,r2,0x01
0x0008a0d4 beq r18,r0,0x0008a0f4
0x0008a0d8 nop
0x0008a0dc addiu r1,r0,0x0003
0x0008a0e0 beq r18,r1,0x0008a0f4
0x0008a0e4 nop
0x0008a0e8 addiu r1,r0,0x0004
0x0008a0ec bne r18,r1,0x0008a11c
0x0008a0f0 nop
0x0008a0f4 jal 0x0010643c
0x0008a0f8 addiu r4,r0,0x00db
0x0008a0fc addiu r1,r0,0x0001
0x0008a100 bne r2,r1,0x0008a11c
0x0008a104 nop
0x0008a108 sll r2,r16,0x01
0x0008a10c add r2,r2,r16
0x0008a110 sll r16,r2,0x01
0x0008a114 sll r2,r17,0x02
0x0008a118 add r17,r2,r17
0x0008a11c addiu r1,r0,0x0002
0x0008a120 beq r18,r1,0x0008a140
0x0008a124 nop
0x0008a128 addiu r1,r0,0x0001
0x0008a12c beq r18,r1,0x0008a140
0x0008a130 nop
0x0008a134 addiu r1,r0,0x0005
0x0008a138 bne r18,r1,0x0008a168
0x0008a13c nop
0x0008a140 jal 0x0010643c
0x0008a144 addiu r4,r0,0x00fb
0x0008a148 addiu r1,r0,0x0001
0x0008a14c bne r2,r1,0x0008a168
0x0008a150 nop
0x0008a154 sll r2,r16,0x01
0x0008a158 add r2,r2,r16
0x0008a15c sll r16,r2,0x01
0x0008a160 sll r2,r17,0x02
0x0008a164 add r17,r2,r17
0x0008a168 beq r18,r0,0x0008a188
0x0008a16c nop
0x0008a170 addiu r1,r0,0x0001
0x0008a174 beq r18,r1,0x0008a188
0x0008a178 nop
0x0008a17c addiu r1,r0,0x0002
0x0008a180 bne r18,r1,0x0008a1c0
0x0008a184 nop
0x0008a188 lui r2,0x8014
0x0008a18c sll r3,r18,0x01
0x0008a190 addiu r2,r2,0x84c6
0x0008a194 addu r2,r2,r3
0x0008a198 lh r2,0x0000(r2)
0x0008a19c nop
0x0008a1a0 slti r1,r2,0x000a
0x0008a1a4 bne r1,r0,0x0008a1c0
0x0008a1a8 nop
0x0008a1ac sll r2,r16,0x01
0x0008a1b0 add r2,r2,r16
0x0008a1b4 sll r16,r2,0x01
0x0008a1b8 sll r2,r17,0x02
0x0008a1bc add r17,r2,r17
0x0008a1c0 addiu r1,r0,0x0003
0x0008a1c4 beq r18,r1,0x0008a1e4
0x0008a1c8 nop
0x0008a1cc addiu r1,r0,0x0004
0x0008a1d0 beq r18,r1,0x0008a1e4
0x0008a1d4 nop
0x0008a1d8 addiu r1,r0,0x0005
0x0008a1dc bne r18,r1,0x0008a220
0x0008a1e0 nop
0x0008a1e4 addi r2,r19,-0x0003
0x0008a1e8 sll r3,r2,0x01
0x0008a1ec lui r2,0x8014
0x0008a1f0 addiu r2,r2,0x84ce
0x0008a1f4 addu r2,r2,r3
0x0008a1f8 lh r2,0x0000(r2)
0x0008a1fc nop
0x0008a200 slti r1,r2,0x000a
0x0008a204 bne r1,r0,0x0008a220
0x0008a208 nop
0x0008a20c sll r2,r16,0x01
0x0008a210 add r2,r2,r16
0x0008a214 sll r16,r2,0x01
0x0008a218 sll r2,r17,0x02
0x0008a21c add r17,r2,r17
0x0008a220 jal 0x000c51e0
0x0008a224 addiu r4,r0,0x0021
0x0008a228 blez r2,0x0008a24c
0x0008a22c nop
0x0008a230 sll r2,r16,0x02
0x0008a234 add r2,r2,r16
0x0008a238 sll r2,r2,0x01
0x0008a23c add r16,r2,r16
0x0008a240 sll r2,r17,0x02
0x0008a244 add r2,r2,r17
0x0008a248 sll r17,r2,0x01
0x0008a24c sll r2,r16,0x02
0x0008a250 add r2,r2,r16
0x0008a254 sll r2,r2,0x01
0x0008a258 divu r2,r17
0x0008a25c lw r31,0x0020(r29)
0x0008a260 mflo r2
0x0008a264 sll r2,r2,0x10
0x0008a268 lw r19,0x001c(r29)
0x0008a26c lw r18,0x0018(r29)
0x0008a270 lw r17,0x0014(r29)
0x0008a274 lw r16,0x0010(r29)
0x0008a278 sra r2,r2,0x10
0x0008a27c jr r31
0x0008a280 addiu r29,r29,0x0028