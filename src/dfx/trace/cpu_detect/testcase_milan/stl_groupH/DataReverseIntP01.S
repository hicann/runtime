.global DataReverseIntP01

.text
.p2align 4

DataReverseIntP01:

DataReverseIntP01_TestBegin:
    STP  X1, X2, [SP, #-16]!
    STP  X3, X4, [SP, #-16]!
    STP  X5, X6, [SP, #-16]!
    STP  X7, X8, [SP, #-16]!
    STP  X9, X10, [SP, #-16]!
    STP  X11, X12, [SP, #-16]!
    STP  X13, X14, [SP, #-16]!
    STP  X15, X16, [SP, #-16]!
    STP  X17, X18, [SP, #-16]!
    STP  X19, X20, [SP, #-16]!
    STP  X21, X22, [SP, #-16]!
    STP  X23, X24, [SP, #-16]!
    STP  X25, X26, [SP, #-16]!
    STP  X27, X28, [SP, #-16]!
    STP  X29, X30, [SP, #-16]!
    MRS  X2, NZCV
    STP  X2, X3, [SP, #-16]!
    MOVZ  X3, #0xf17b, LSL #0
    MOVK  X3, #0x3f3e, LSL #16
    MOVK  X3, #0xbbc5, LSL #32
    MOVK  X3, #0xf031, LSL #48
    MOVZ  X4, #0xc91b, LSL #0
    MOVK  X4, #0x54b4, LSL #16
    MOVK  X4, #0xa602, LSL #32
    MOVK  X4, #0x3b47, LSL #48
    MOVZ  X5, #0xcc90, LSL #0
    MOVK  X5, #0x264d, LSL #16
    MOVK  X5, #0xd33f, LSL #32
    MOVK  X5, #0x261e, LSL #48
    MOVZ  X6, #0x81e3, LSL #0
    MOVK  X6, #0xd8ff, LSL #16
    MOVK  X6, #0xee5, LSL #32
    MOVK  X6, #0xc186, LSL #48
    MOVZ  X7, #0x94bc, LSL #0
    MOVK  X7, #0x53e7, LSL #16
    MOVK  X7, #0x122a, LSL #32
    MOVK  X7, #0x6e03, LSL #48
    MOVZ  X8, #0xee55, LSL #0
    MOVK  X8, #0x40f0, LSL #16
    MOVK  X8, #0x27d7, LSL #32
    MOVK  X8, #0xf43b, LSL #48
    MOVZ  X9, #0x89b5, LSL #0
    MOVK  X9, #0xfaad, LSL #16
    MOVK  X9, #0x8428, LSL #32
    MOVK  X9, #0x761f, LSL #48
    MOVZ  X10, #0x360f, LSL #0
    MOVK  X10, #0x67a9, LSL #16
    MOVK  X10, #0x67bb, LSL #32
    MOVK  X10, #0x463c, LSL #48
    MOVZ  X11, #0x3d27, LSL #0
    MOVK  X11, #0x3f6b, LSL #16
    MOVK  X11, #0xa997, LSL #32
    MOVK  X11, #0x27ba, LSL #48
    MOVZ  X13, #0xf874, LSL #0
    MOVK  X13, #0xaa08, LSL #16
    MOVK  X13, #0x9803, LSL #32
    MOVK  X13, #0xc998, LSL #48
    MOVZ  X14, #0x6266, LSL #0
    MOVK  X14, #0x218a, LSL #16
    MOVK  X14, #0xc4ed, LSL #32
    MOVK  X14, #0xcbf5, LSL #48
    MOVZ  X15, #0x8750, LSL #0
    MOVK  X15, #0x57c6, LSL #16
    MOVK  X15, #0x8299, LSL #32
    MOVK  X15, #0x18e7, LSL #48
    MOVZ  X16, #0xf4d8, LSL #0
    MOVK  X16, #0x24bd, LSL #16
    MOVK  X16, #0x230a, LSL #32
    MOVK  X16, #0x4db8, LSL #48
    MOVZ  X17, #0xb35c, LSL #0
    MOVK  X17, #0xca50, LSL #16
    MOVK  X17, #0x1a29, LSL #32
    MOVK  X17, #0x6ad5, LSL #48
    MOVZ  X18, #0xf66c, LSL #0
    MOVK  X18, #0xd2e, LSL #16
    MOVK  X18, #0x5c80, LSL #32
    MOVK  X18, #0xe9fe, LSL #48
    MOVZ  X19, #0x6ba3, LSL #0
    MOVK  X19, #0xf692, LSL #16
    MOVK  X19, #0x8406, LSL #32
    MOVK  X19, #0x87b1, LSL #48
    MOVZ  X20, #0x43e3, LSL #0
    MOVK  X20, #0x950b, LSL #16
    MOVK  X20, #0x427d, LSL #32
    MOVK  X20, #0x56d1, LSL #48
    MOVZ  X21, #0xdffd, LSL #0
    MOVK  X21, #0xda12, LSL #16
    MOVK  X21, #0xe0ff, LSL #32
    MOVK  X21, #0x2188, LSL #48
    MOVZ  X23, #0xaaba, LSL #0
    MOVK  X23, #0x3874, LSL #16
    MOVK  X23, #0x56b4, LSL #32
    MOVK  X23, #0xa30d, LSL #48
    MOVZ  X24, #0x75bf, LSL #0
    MOVK  X24, #0x5803, LSL #16
    MOVK  X24, #0x121c, LSL #32
    MOVK  X24, #0x433e, LSL #48
    MOVZ  X25, #0xe48, LSL #0
    MOVK  X25, #0x3f61, LSL #16
    MOVK  X25, #0x522c, LSL #32
    MOVK  X25, #0xe5b5, LSL #48
    MOVZ  X26, #0x9b5c, LSL #0
    MOVK  X26, #0x6a03, LSL #16
    MOVK  X26, #0xca2f, LSL #32
    MOVK  X26, #0xf0f2, LSL #48
    MOVZ  X27, #0xb0fd, LSL #0
    MOVK  X27, #0x4828, LSL #16
    MOVK  X27, #0xc6e2, LSL #32
    MOVK  X27, #0xed7c, LSL #48
    MOVZ  X29, #0xf800, LSL #0
    MOVK  X29, #0xad06, LSL #16
    MOVK  X29, #0x5c3f, LSL #32
    MOVK  X29, #0x26d4, LSL #48
    ADDS  X24, X27, X27, ASR #55
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    ADC  W24, W3, W25
    ADC  X11, X20, X26
    ADCS  W6, W29, W23
    ADCS  X13, X18, X13
    ADD  W17, W26, W26, SXTX #1
    ADD  X3, X18, W21, SXTB #4
    ADD  W8, W16, #0x514
    ADD  X14, X20, #0x77c
    ADD  W4, W10, W19, LSR #0
    ADD  X15, X5, X16, LSL #19
    ADDS  W19, W19, W16, SXTH #2
    ADDS  X20, X26, W26, UXTB #1
    ADDS  W9, W10, #0x604, LSL #12
    ADDS  X29, X16, #0x964
    ADDS  W18, W23, W25, ASR #17
    ADDS  X21, X16, X5, ASR #4
    AND  W23, W16, #0x3fffffc0
    AND  X5, X25, #0x780000000000
    AND  W26, W26, W26, ASR #3
    AND  X16, X16, X16, ROR #58
    MOVZ  X27, #0x5ffa, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xb4b4, LSL #0
    MOVK  X27, #0xb4b4, LSL #16
    SUB  X7, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x5800, LSL #32
    SUB  X7, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xb4b5, LSL #0
    MOVK  X27, #0xb4b4, LSL #16
    SUB  X7, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5f6e, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    SUB  X7, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x9a5a, LSL #0
    MOVK  X27, #0x5aba, LSL #16
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xb4b5, LSL #0
    MOVK  X27, #0xb4b4, LSL #16
    MOVK  X27, #0xb4b4, LSL #32
    MOVK  X27, #0xb4b4, LSL #48
    SUB  X7, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xb4b4, LSL #0
    MOVK  X27, #0xb4b4, LSL #16
    MOVK  X27, #0xb4b4, LSL #32
    MOVK  X27, #0xb4b4, LSL #48
    SUB  X7, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x61d6, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x2d2a, LSL #16
    MOVK  X27, #0x2d2d, LSL #32
    MOVK  X27, #0x2d2d, LSL #48
    SUB  X7, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x1212, LSL #0
    MOVK  X27, #0x1212, LSL #16
    MOVK  X27, #0x1212, LSL #32
    MOVK  X27, #0x1212, LSL #48
    SUB  X7, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xf0e, LSL #0
    MOVK  X27, #0xf0f, LSL #16
    SUB  X7, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x8787, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    SUB  X7, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xc3c2, LSL #0
    MOVK  X27, #0x5a5b, LSL #16
    SUB  X7, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5b0e, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0x5fff, LSL #48
    SUB  X7, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a40, LSL #0
    MOVK  X27, #0x1a5a, LSL #16
    SUB  X7, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xb4b5, LSL #0
    MOVK  X27, #0xb4b4, LSL #16
    SUB  X7, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x4a4a, LSL #0
    MOVK  X27, #0xa4a, LSL #16
    SUB  X7, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x63be, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    ANDS  X18, X25, #0xffff803fffffffff
    ANDS  W24, W24, W24, LSR #17
    ANDS  X14, X21, X26, LSL #8
    ASR  W16, W10, #0x13
    ASR  X20, X29, #0x20
    ASR  W23, W19, W17
    ASR  X5, X26, X21
    ASRV  W9, W9, W6
    ASRV  X21, X19, X6
    BFI  W19, W17, #30, #1
    BFI  X6, X4, #45, #19
    BFM  W4, W3, #0x1, #0xa
    BFM  X11, X8, #0x18, #0x8
    BFXIL  W26, W29, #0xc, #4
    BFXIL  X17, X3, #0x1b, #33
    BIC  W15, W10, W8, ROR #25
    BIC  X13, X29, X3, LSR #2
    BICS  W3, W8, W3, ASR #16
    BICS  X10, X8, X8, LSL #56
    CLS  W8, W8
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    SUB  X7, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x592d, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    SUB  X7, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x9696, LSL #0
    MOVK  X27, #0x9696, LSL #16
    MOVK  X27, #0x16, LSL #32
    SUB  X7, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x4b4b, LSL #48
    SUB  X7, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x16, LSL #0
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a, LSL #48
    SUB  X7, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x4848, LSL #0
    MOVK  X27, #0x4848, LSL #16
    MOVK  X27, #0x4848, LSL #32
    MOVK  X27, #0x4848, LSL #48
    SUB  X7, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a00, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5252, LSL #0
    MOVK  X27, #0x5252, LSL #16
    SUB  X7, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xb4b, LSL #0
    SUB  X7, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x4b4b, LSL #0
    MOVK  X27, #0x4b4b, LSL #16
    MOVK  X27, #0x5a5b, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x1a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x1a5a, LSL #16
    SUB  X7, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    SUB  X7, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x9696, LSL #0
    MOVK  X27, #0x9696, LSL #16
    MOVK  X27, #0x16, LSL #32
    SUB  X7, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x16, LSL #0
    SUB  X7, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x808, LSL #0
    SUB  X7, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a55, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    SUB  X7, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    CLZ  W29, W25
    CLZ  X11, X26
    CSEL  W25, W24, W14, GE
    CSEL  X6, X23, X23, AL
    CSINC  W8, W13, W17, EQ
    CSINC  X13, X10, X26, GE
    CSINV  W15, W21, W21, LS
    CSINV  X26, X9, X16, LT
    CSNEG  W23, W17, W21, NE
    CSNEG  X21, X4, X10, LE
    EON  W24, W16, W17, LSR #9
    EON  X4, X14, X14, ROR #54
    EOR  W9, W14, #0xc0ffc0ff
    EOR  X5, X17, #0x7ff07ff07ff07ff
    EOR  W14, W18, W14, LSL #11
    EOR  X16, X19, X16, LSR #42
    EXTR  W18, W19, W19, #0x2
    EXTR  X17, X10, X20, #0xf
    MADD  W20, W3, W20, W3
    MADD  X19, X19, X3, X10
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xcccc, LSL #0
    MOVK  X27, #0xcccc, LSL #16
    MOVK  X27, #0xcccc, LSL #32
    MOVK  X27, #0xcccc, LSL #48
    SUB  X7, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5da5, LSL #0
    MOVK  X27, #0x5da5, LSL #16
    MOVK  X27, #0x5da5, LSL #32
    MOVK  X27, #0x5da5, LSL #48
    SUB  X7, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5b, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    SUB  X7, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x9aa5, LSL #0
    MOVK  X27, #0x9aa5, LSL #16
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x1, LSL #0
    SUB  X7, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x8a5a, LSL #0
    MOVK  X27, #0x8888, LSL #16
    SUB  X7, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    SUB  X7, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xcccc, LSL #0
    MOVK  X27, #0x5a4c, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xb4b4, LSL #0
    MOVK  X27, #0xb4b4, LSL #16
    MOVK  X27, #0xb4b4, LSL #32
    MOVK  X27, #0xb4b4, LSL #48
    SUB  X7, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x9696, LSL #0
    MOVK  X27, #0x9696, LSL #16
    SUB  X7, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xc1fe, LSL #0
    MOVK  X27, #0x4985, LSL #16
    MOVK  X27, #0xd10d, LSL #32
    MOVK  X27, #0x5894, LSL #48
    SUB  X7, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xc1fe, LSL #0
    MOVK  X27, #0x4985, LSL #16
    SUB  X7, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xa5a6, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X7, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    SUB  X7, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x8888, LSL #0
    MOVK  X27, #0xa588, LSL #16
    SUB  X7, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    SUB  X7, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X7, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x1, LSL #0
    SUB  X7, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    MNEG  X21, X23, X26
    MSUB  W13, W25, W29, W29
    MSUB  X10, X24, X24, X24
    MUL  W26, W8, W19
    MUL  X9, X24, X8
    MVN  W4, W29, ASR #30
    MVN  X24, X17, ASR #56
    NEG  W15, W3, ASR #25
    NEG  X5, X25, LSL #20
    NEGS  W17, W8, ASR #18
    NEGS  X18, X19, LSR #28
    NGC  W16, W25
    NGC  X25, X8
    NGCS  W14, W6
    NGCS  X6, X23
    ORN  W20, W23, W8, ROR #25
    ORN  X29, X23, X19, ROR #30
    ORR  W3, W23, #0xff0007ff
    ORR  X23, X19, #0x3ffffffffff0000
    ORR  W8, W11, W8, LSL #21
    MOVZ  X27, #0x5fff, LSL #0
    MOVK  X27, #0xff5a, LSL #16
    SUB  X7, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xfffe, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X7, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x5a60, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X7, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5b5a, LSL #16
    SUB  X7, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x67a4, LSL #0
    MOVK  X27, #0xef2b, LSL #16
    MOVK  X27, #0x76b2, LSL #32
    MOVK  X27, #0xfe3a, LSL #48
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xf2b6, LSL #0
    MOVK  X27, #0x6b2e, LSL #16
    MOVK  X27, #0xe3a7, LSL #32
    MOVK  X27, #0x5c1f, LSL #48
    SUB  X7, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xf2b6, LSL #0
    MOVK  X27, #0x6b2e, LSL #16
    SUB  X7, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    SUB  X7, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xffd3, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X7, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    SUB  X7, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xe96a, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X7, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5b, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0xfffa, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X7, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xdada, LSL #0
    MOVK  X27, #0xdada, LSL #16
    SUB  X7, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x985c, LSL #0
    MOVK  X27, #0x10d4, LSL #16
    MOVK  X27, #0x894d, LSL #32
    MOVK  X27, #0x1c5, LSL #48
    SUB  X7, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0x5bff, LSL #48
    SUB  X7, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xffa5, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X7, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X7, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x67a4, LSL #0
    MOVK  X27, #0xef2b, LSL #16
    SUB  X7, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xdede, LSL #0
    MOVK  X27, #0xdede, LSL #16
    MOVK  X27, #0xdede, LSL #32
    MOVK  X27, #0xdede, LSL #48
    SUB  X7, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    RBIT  W3, W25
    RBIT  X26, X29
    REV  W16, W24
    REV  X19, X23
    REV16  W13, W25
    REV16  X10, X21
    REV32  X18, X9
    ROR  W11, W25, #0x1d
    ROR  X4, X14, #0x25
    ROR  W21, W24, W8
    ROR  X9, X25, X25
    RORV  W25, W14, W5
    RORV  X20, X8, X8
    SBC  W29, W8, W8
    SBC  X15, X6, X15
    SBCS  W8, W17, W5
    SBCS  X24, X14, X6
    SBFIZ  W5, W23, #8, #3
    SBFIZ  X23, X14, #28, #13
    SBFM  W14, W14, #0x0, #0x1b
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    SUB  X7, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xd2d2, LSL #0
    MOVK  X27, #0xd2d2, LSL #16
    MOVK  X27, #0xd2d2, LSL #32
    MOVK  X27, #0xd2d2, LSL #48
    SUB  X7, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x200, LSL #0
    SUB  X7, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X7, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x9696, LSL #0
    MOVK  X27, #0x9696, LSL #16
    MOVK  X27, #0x9696, LSL #32
    MOVK  X27, #0x9696, LSL #48
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xd2d2, LSL #0
    MOVK  X27, #0xd2d2, LSL #16
    SUB  X7, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    SUB  X7, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0xfa5a, LSL #16
    SUB  X7, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X7, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    SUB  X7, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x9696, LSL #0
    MOVK  X27, #0x9696, LSL #16
    MOVK  X27, #0x9696, LSL #32
    MOVK  X27, #0x9696, LSL #48
    SUB  X7, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x9696, LSL #0
    MOVK  X27, #0x9696, LSL #16
    SUB  X7, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xa000, LSL #16
    MOVK  X27, #0xffa5, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X7, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X7, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x9696, LSL #0
    MOVK  X27, #0x9696, LSL #16
    SUB  X7, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X7, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SBFX  W10, W24, #0x6, #23
    SBFX  X9, X23, #0x22, #10
    SDIV  W19, W20, W25
    SDIV  X20, X26, X26
    SMADDL  X11, W5, W4, X29
    SMNEGL  X25, W4, W6
    SMSUBL  X26, W21, W24, X21
    SMULH  X4, X4, X6
    SMULL  X29, W14, W18
    SUB  W13, W15, W3, UXTB #3
    SUB  X16, X14, W3, UXTB #2
    SUB  W23, W5, #0xe
    SUB  X15, X18, #0xcd
    SUB  W24, W3, W5, LSL #4
    SUB  X17, X17, X14, LSR #11
    SUBS  W6, W8, W21, UXTW #4
    SUBS  X8, X3, X5, UXTX #2
    SUBS  W21, W3, #0xf45
    SUBS  X14, X3, #0x3ae
    SUBS  W5, W3, W5, ASR #8
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xb679, LSL #0
    MOVK  X27, #0x2ef2, LSL #16
    MOVK  X27, #0xa76b, LSL #32
    MOVK  X27, #0x1fe3, LSL #48
    SUB  X7, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x5a00, LSL #16
    SUB  X7, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xb4ba, LSL #0
    MOVK  X27, #0xb4b4, LSL #16
    SUB  X7, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xf0f2, LSL #0
    MOVK  X27, #0xf0f0, LSL #16
    MOVK  X27, #0xf0f0, LSL #32
    MOVK  X27, #0xf0f0, LSL #48
    SUB  X7, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xfe96, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x6969, LSL #0
    MOVK  X27, #0xffe9, LSL #16
    SUB  X7, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xc1fe, LSL #0
    MOVK  X27, #0x4985, LSL #16
    MOVK  X27, #0x1c5, LSL #32
    MOVK  X27, #0x7a3e, LSL #48
    SUB  X7, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x578a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    SUB  X7, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x56ac, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x598d, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x58f2, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xf0f, LSL #0
    MOVK  X27, #0xf0f, LSL #16
    MOVK  X27, #0xf0f, LSL #32
    MOVK  X27, #0x5a4f, LSL #48
    SUB  X7, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x1, LSL #0
    SUB  X7, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x1, LSL #0
    SUB  X7, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x4b15, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    SUB  X7, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a4c, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    SUB  X7, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xb4ba, LSL #0
    MOVK  X27, #0xb4b4, LSL #16
    SUB  X7, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x985c, LSL #0
    MOVK  X27, #0x10d4, LSL #16
    MOVK  X27, #0x5895, LSL #32
    MOVK  X27, #0xe01c, LSL #48
    SUB  X7, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xf2b6, LSL #0
    MOVK  X27, #0x6b2e, LSL #16
    MOVK  X27, #0xb2ef, LSL #32
    MOVK  X27, #0x3a76, LSL #48
    SUB  X7, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x67a4, LSL #0
    MOVK  X27, #0xef2b, LSL #16
    MOVK  X27, #0xa76a, LSL #32
    MOVK  X27, #0x1fe3, LSL #48
    SUB  X7, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SXTB  W24, W25
    SXTB  X26, W23
    SXTH  W25, W29
    SXTH  X10, W3
    SXTW  X20, W8
    TST  W15, #0x7800
    TST  X13, #0x808080808080808
    TST  W5, W8, LSR #17
    TST  X21, X17, ASR #54
    UBFIZ  W15, W8, #21, #10
    UBFIZ  X21, X23, #50, #6
    UBFM  W16, W5, #0x13, #0xa
    UBFM  X14, X3, #0xe, #0x16
    UBFX  W18, W23, #0x0, #24
    UBFX  X3, X9, #0x26, #23
    UDIV  W9, W19, W8
    UDIV  X23, X23, X5
    UMADDL  X4, W11, W4, X4
    UMNEGL  X13, W11, W11
    UMSUBL  X19, W19, W5, X5
    UMULH  X11, X29, X17
    UMULL  X17, W29, W29
    UXTB  W29, W6
    UXTH  W8, W5
    MOVZ  X27, #0x6969, LSL #0
    MOVK  X27, #0x69, LSL #16
    SUB  X7, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xc1fe, LSL #0
    MOVK  X27, #0x4985, LSL #16
    MOVK  X27, #0x1c5, LSL #32
    MOVK  X27, #0x7a3e, LSL #48
    SUB  X7, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X7, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    SUB  X7, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x1, LSL #0
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    SUB  X7, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xb679, LSL #0
    MOVK  X27, #0x2ef2, LSL #16
    MOVK  X27, #0xa76b, LSL #32
    MOVK  X27, #0x1fe3, LSL #48
    SUB  X7, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x985c, LSL #0
    MOVK  X27, #0x10d4, LSL #16
    MOVK  X27, #0x5895, LSL #32
    MOVK  X27, #0xe01c, LSL #48
    SUB  X7, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x169, LSL #0
    SUB  X7, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x4b40, LSL #16
    SUB  X7, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x4000, LSL #0
    MOVK  X27, #0x4b, LSL #16
    SUB  X7, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x67a4, LSL #0
    MOVK  X27, #0xef2b, LSL #16
    MOVK  X27, #0xa76a, LSL #32
    MOVK  X27, #0x1fe3, LSL #48
    SUB  X7, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a, LSL #16
    SUB  X7, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0xf2b6, LSL #0
    MOVK  X27, #0x6b2e, LSL #16
    MOVK  X27, #0xb2ef, LSL #32
    MOVK  X27, #0x3a76, LSL #48
    SUB  X7, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    SUB  X7, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x68, LSL #48
    SUB  X7, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x1, LSL #0
    SUB  X7, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a, LSL #0
    SUB  X7, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    SUB  X7, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a, LSL #0
    SUB  X7, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X27, #0x5a, LSL #0
    SUB  X7, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, DataReverseIntP01_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    ADC  W8, W20, W21
    ADC  X21, X29, X27
    ADCS  W20, W5, W15
    ADCS  X6, X24, X9
    ADD  W3, W25, W25, UXTB #4
    ADD  X14, X27, W18, UXTW #3
    ADD  W13, W29, #0xc22, LSL #12
    ADD  X19, X16, #0x51c
    ADD  W24, W15, W27, LSL #1
    ADD  X18, X7, X29, ASR #16
    ADDS  W10, W5, W17, SXTX #3
    ADDS  X4, X27, W4, UXTB #1
    ADDS  W17, W29, #0xb27, LSL #12
    ADDS  X27, X9, #0x3a5
    ADDS  W15, W16, W16, ASR #31
    ADDS  X9, X9, X11, ASR #51
    AND  W25, W5, #0x55555555
    AND  X5, X5, #0xfffffff0000007ff
    AND  W7, W7, W16, LSR #27
    AND  X16, X11, X29, LSR #1
    MOVZ  X26, #0xaff5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    SUB  X23, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa6ef, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x5a5, LSL #0
    MOVK  X26, #0xa5a0, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x4b4b, LSL #0
    MOVK  X26, #0x4b4b, LSL #16
    MOVK  X26, #0x4b4b, LSL #32
    MOVK  X26, #0x4b4b, LSL #48
    SUB  X23, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x4, LSL #0
    SUB  X23, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x4b4a, LSL #0
    MOVK  X26, #0x4b4b, LSL #16
    SUB  X23, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x9a59, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xd2cd, LSL #0
    MOVK  X26, #0xd2d2, LSL #16
    SUB  X23, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xc5a5, LSL #0
    MOVK  X26, #0xa667, LSL #16
    SUB  X23, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xd2cd, LSL #0
    MOVK  X26, #0xd2d2, LSL #16
    MOVK  X26, #0xa5aa, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a4, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    SUB  X23, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x8080, LSL #0
    MOVK  X26, #0x8080, LSL #16
    MOVK  X26, #0x8080, LSL #32
    MOVK  X26, #0x80, LSL #48
    SUB  X23, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x15a5, LSL #0
    MOVK  X26, #0xa658, LSL #16
    SUB  X23, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x4b4a, LSL #0
    MOVK  X26, #0x4b4b, LSL #16
    MOVK  X26, #0x4b4b, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xaac1, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x4b4a, LSL #0
    MOVK  X26, #0x4b4b, LSL #16
    SUB  X23, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x4b4a, LSL #0
    MOVK  X26, #0x4b4b, LSL #16
    MOVK  X26, #0x4b4b, LSL #32
    MOVK  X26, #0x4b4b, LSL #48
    SUB  X23, X26, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xf0ef, LSL #0
    MOVK  X26, #0xf0f0, LSL #16
    SUB  X23, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x505, LSL #0
    MOVK  X26, #0x505, LSL #16
    SUB  X23, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa94a, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    ANDS  X16, X20, #0xfffffc0000
    ANDS  W25, W25, W25, ASR #12
    ANDS  X11, X7, X27, LSR #62
    ASR  W3, W19, #0xb
    ASR  X6, X24, #0x0
    ASR  W10, W29, W29
    ASR  X19, X18, X5
    ASRV  W18, W29, W4
    ASRV  X24, X24, X24
    BFI  W8, W9, #19, #5
    BFI  X17, X5, #30, #20
    BFM  W4, W13, #0x1d, #0x1
    BFM  X5, X29, #0x3a, #0x2b
    BFXIL  W13, W15, #0xa, #16
    BFXIL  X21, X20, #0x38, #3
    BIC  W15, W27, W27, ROR #21
    BIC  X14, X9, X29, ROR #48
    BICS  W27, W20, W7, ROR #10
    BICS  X9, X29, X9, ASR #63
    CLS  W7, W29
    MOVZ  X26, #0xb4b4, LSL #0
    MOVK  X26, #0xfff4, LSL #16
    SUB  X23, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5ad, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    SUB  X23, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x6965, LSL #0
    MOVK  X26, #0x6969, LSL #16
    MOVK  X26, #0x6969, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa52d, LSL #16
    SUB  X23, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x2d2d, LSL #0
    MOVK  X26, #0xfd2d, LSL #16
    SUB  X23, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x6969, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    SUB  X23, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x8080, LSL #0
    MOVK  X26, #0x8080, LSL #16
    SUB  X23, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0xa5a4, LSL #16
    MOVK  X26, #0xa5, LSL #32
    SUB  X23, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0x65a5, LSL #16
    MOVK  X26, #0x6969, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x2d2d, LSL #0
    MOVK  X26, #0xfd2d, LSL #16
    SUB  X23, X26, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x2d2d, LSL #0
    MOVK  X26, #0xfd2d, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X23, X26, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x2d2d, LSL #0
    MOVK  X26, #0xfd2d, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X23, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0xa5a0, LSL #16
    SUB  X23, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x8484, LSL #0
    MOVK  X26, #0x8484, LSL #16
    SUB  X23, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    CLZ  W27, W29
    CLZ  X15, X25
    CSEL  W16, W24, W24, GT
    CSEL  X5, X19, X21, HI
    CSINC  W20, W8, W18, VC
    CSINC  X24, X29, X8, CS
    CSINV  W11, W19, W19, HI
    CSINV  X6, X4, X9, GE
    CSNEG  W18, W7, W9, CS
    CSNEG  X14, X4, X29, CS
    EON  W10, W8, W19, ROR #22
    EON  X9, X8, X4, ASR #42
    EOR  W17, W8, #0xfffffff9
    EOR  X8, X4, #0xfffffffc1fffffff
    EOR  W19, W25, W25, LSL #14
    EOR  X29, X25, X21, ASR #53
    EXTR  W3, W13, W7, #0x3
    EXTR  X25, X13, X13, #0x14
    MADD  W13, W4, W7, W21
    MADD  X7, X7, X21, X21
    MOVZ  X26, #0xb4b4, LSL #0
    MOVK  X26, #0xb4b4, LSL #16
    SUB  X23, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xc1fe, LSL #0
    MOVK  X26, #0x4985, LSL #16
    MOVK  X26, #0xd10d, LSL #32
    MOVK  X26, #0x5894, LSL #48
    SUB  X23, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0xba5a, LSL #16
    MOVK  X26, #0x5a59, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X23, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x3333, LSL #0
    MOVK  X26, #0xa5b3, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xcccc, LSL #0
    MOVK  X26, #0xcccc, LSL #16
    SUB  X23, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    SUB  X23, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xc1fe, LSL #0
    MOVK  X26, #0x4985, LSL #16
    SUB  X23, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x5a5b, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X23, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    SUB  X23, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x5a5c, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    SUB  X23, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x5a5b, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    SUB  X23, X26, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xe5a5, LSL #0
    MOVK  X26, #0xcccc, LSL #16
    SUB  X23, X26, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    SUB  X23, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a6, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X23, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x5888, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X23, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    MNEG  X9, X29, X24
    MSUB  W11, W27, W27, W21
    MSUB  X10, X25, X20, X25
    MUL  W4, W4, W29
    MUL  X16, X16, X19
    MVN  W24, W19, LSL #5
    MVN  X17, X7, ASR #56
    NEG  W3, W14, LSL #27
    NEG  X5, X27, ASR #49
    NEGS  W19, W21, ASR #21
    NEGS  X7, X27, ASR #31
    NGC  W29, W15
    NGC  X18, X25
    NGCS  W6, W15
    NGCS  X8, X14
    ORN  W21, W13, W15, LSL #25
    ORN  X27, X15, X25, ROR #63
    ORR  W13, W25, #0x3ffe0000
    ORR  X14, X14, #0x3f8000003f8000
    ORR  W25, W25, W25, ROR #23
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0xd800, LSL #16
    SUB  X23, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x1c59, LSL #0
    MOVK  X26, #0xa3e0, LSL #16
    SUB  X23, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x2d2e, LSL #0
    SUB  X23, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    SUB  X23, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xb4b5, LSL #0
    MOVK  X26, #0xb4b4, LSL #16
    SUB  X23, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X23, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xe3a7, LSL #0
    MOVK  X26, #0x5c1f, LSL #16
    MOVK  X26, #0xd498, LSL #32
    MOVK  X26, #0x4d10, LSL #48
    SUB  X23, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x894c, LSL #0
    MOVK  X26, #0x1c5, LSL #16
    MOVK  X26, #0x7a3e, LSL #32
    MOVK  X26, #0xf2b6, LSL #48
    SUB  X23, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x894c, LSL #0
    MOVK  X26, #0x1c5, LSL #16
    SUB  X23, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xbfff, LSL #16
    SUB  X23, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5bf, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5bf, LSL #48
    SUB  X23, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x1c59, LSL #0
    MOVK  X26, #0xa3e0, LSL #16
    MOVK  X26, #0x2b67, LSL #32
    MOVK  X26, #0xb2ef, LSL #48
    SUB  X23, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x5a, LSL #0
    SUB  X23, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X23, X26, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x2d3, LSL #0
    SUB  X23, X26, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xb5ff, LSL #16
    SUB  X23, X26, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x4b5f, LSL #0
    MOVK  X26, #0x4b4b, LSL #16
    SUB  X23, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xefef, LSL #0
    MOVK  X26, #0xefef, LSL #16
    SUB  X23, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xb5b5, LSL #0
    MOVK  X26, #0xb5b5, LSL #16
    MOVK  X26, #0xb5b5, LSL #32
    MOVK  X26, #0xb5b5, LSL #48
    SUB  X23, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    SUB  X23, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    RBIT  W19, W24
    RBIT  X25, X21
    REV  W8, W20
    REV  X10, X29
    REV16  W16, W11
    REV16  X5, X27
    REV32  X7, X11
    ROR  W14, W9, #0x9
    ROR  X18, X15, #0x2d
    ROR  W4, W24, W20
    ROR  X3, X15, X15
    RORV  W15, W21, W11
    RORV  X24, X21, X20
    SBC  W11, W29, W17
    SBC  X27, X13, X27
    SBCS  W9, W9, W20
    SBCS  X13, X17, X6
    SBFIZ  W17, W21, #8, #18
    SBFIZ  X29, X29, #12, #27
    SBFM  W6, W20, #0x12, #0x14
    MOVZ  X26, #0x2d2d, LSL #0
    MOVK  X26, #0x2d2d, LSL #16
    MOVK  X26, #0x2d2d, LSL #32
    MOVK  X26, #0x2d2d, LSL #48
    SUB  X23, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x2d2d, LSL #0
    MOVK  X26, #0x2d2d, LSL #16
    SUB  X23, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x1, LSL #0
    SUB  X23, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    SUB  X23, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X23, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X23, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X23, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xd2d2, LSL #0
    MOVK  X26, #0xd2d2, LSL #16
    SUB  X23, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x2d2d, LSL #0
    MOVK  X26, #0x2d2d, LSL #16
    SUB  X23, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    SUB  X23, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa500, LSL #0
    MOVK  X26, #0x1a5, LSL #16
    SUB  X23, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x2d2d, LSL #0
    MOVK  X26, #0x2d2d, LSL #16
    MOVK  X26, #0x2d2d, LSL #32
    MOVK  X26, #0x2d2d, LSL #48
    SUB  X23, X26, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    SUB  X23, X26, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x2d2d, LSL #0
    MOVK  X26, #0x2d2d, LSL #16
    MOVK  X26, #0x2d2d, LSL #32
    MOVK  X26, #0x2d2d, LSL #48
    SUB  X23, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X23, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x5000, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0xffda, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X23, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SBFX  W10, W27, #0x15, #4
    SBFX  X6, X24, #0x3c, #2
    SDIV  W14, W21, W25
    SDIV  X5, X27, X29
    SMADDL  X11, W17, W20, X15
    SMNEGL  X18, W27, W3
    SMSUBL  X17, W9, W27, X9
    SMULH  X29, X21, X8
    SMULL  X19, W7, W27
    SUB  W21, W7, W9, SXTB #1
    SUB  X4, X24, W13, UXTW #1
    SUB  W20, W9, #0x179
    SUB  X25, X16, #0x7ae
    SUB  W3, W27, W7, ASR #20
    SUB  X9, X16, X9, ASR #28
    SUBS  W16, W7, W24, UXTW #3
    SUBS  X24, X15, X8, UXTX #0
    SUBS  W13, W8, #0xf94
    SUBS  X27, X7, #0xc7c
    SUBS  W8, W15, W15, LSR #16
    MOVZ  X26, #0xab4b, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    SUB  X23, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x5a5b, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0xa5a4, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x1, LSL #0
    SUB  X23, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xfffe, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X23, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    SUB  X23, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x4b4b, LSL #0
    MOVK  X26, #0x4b4b, LSL #16
    MOVK  X26, #0xa5ab, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xfffd, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X23, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xc1fe, LSL #0
    MOVK  X26, #0x4985, LSL #16
    MOVK  X26, #0x4d11, LSL #32
    MOVK  X26, #0xc589, LSL #48
    SUB  X23, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x9611, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    SUB  X23, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x1, LSL #0
    SUB  X23, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x787d, LSL #0
    MOVK  X26, #0x7878, LSL #16
    SUB  X23, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x894c, LSL #0
    MOVK  X26, #0x1c5, LSL #16
    MOVK  X26, #0xfe3a, LSL #32
    MOVK  X26, #0x85c1, LSL #48
    SUB  X23, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xe3a7, LSL #0
    MOVK  X26, #0x5c1f, LSL #16
    MOVK  X26, #0x5894, LSL #32
    MOVK  X26, #0xe01c, LSL #48
    SUB  X23, X26, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x1c59, LSL #0
    MOVK  X26, #0xa3e0, LSL #16
    MOVK  X26, #0xa76b, LSL #32
    MOVK  X26, #0x1fe3, LSL #48
    SUB  X23, X26, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa42c, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    SUB  X23, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa65b, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    SUB  X23, X26, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x9df7, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x9929, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xb67a, LSL #0
    MOVK  X26, #0x2ef2, LSL #16
    MOVK  X26, #0xa76b, LSL #32
    MOVK  X26, #0x1fe3, LSL #48
    SUB  X23, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SXTB  W17, W25
    SXTB  X25, W27
    SXTH  W15, W19
    SXTH  X21, W20
    SXTW  X11, W29
    TST  W27, #0x66666666
    TST  X24, #0xffff001fffffffff
    TST  W6, W13, LSR #5
    TST  X13, X3, ASR #22
    UBFIZ  W9, W9, #20, #8
    UBFIZ  X4, X16, #35, #25
    UBFM  W29, W6, #0x4, #0xb
    UBFM  X19, X16, #0x13, #0x1d
    UBFX  W6, W20, #0x1a, #5
    UBFX  X20, X7, #0x3c, #2
    UDIV  W7, W24, W27
    UDIV  X5, X18, X27
    UMADDL  X27, W14, W18, X3
    UMNEGL  X16, W8, W8
    UMSUBL  X13, W10, W13, X24
    UMULH  X10, X10, X3
    UMULL  X8, W24, W14
    UXTB  W3, W24
    UXTH  W24, W14
    MOVZ  X26, #0xa5, LSL #0
    SUB  X23, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x2d28, LSL #32
    MOVK  X26, #0xd2d, LSL #48
    SUB  X23, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x1, LSL #0
    SUB  X23, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x9, LSL #0
    SUB  X23, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x1, LSL #0
    SUB  X23, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x1c59, LSL #0
    MOVK  X26, #0xa3e0, LSL #16
    MOVK  X26, #0xf2b5, LSL #32
    MOVK  X26, #0x6b2e, LSL #48
    SUB  X23, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0xa50, LSL #16
    SUB  X23, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x1c4, LSL #0
    MOVK  X26, #0x7a3e, LSL #16
    MOVK  X26, #0xf2b6, LSL #32
    MOVK  X26, #0x6b2e, LSL #48
    SUB  X23, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X23, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x894c, LSL #0
    MOVK  X26, #0x1c5, LSL #16
    MOVK  X26, #0xb2f0, LSL #32
    MOVK  X26, #0x3a76, LSL #48
    SUB  X23, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X23, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xe3a7, LSL #0
    MOVK  X26, #0x5c1f, LSL #16
    MOVK  X26, #0xd4a, LSL #32
    MOVK  X26, #0x94d1, LSL #48
    SUB  X23, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xffa5, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X23, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X23, X26, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x4b4, LSL #0
    SUB  X23, X26, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x2, LSL #0
    SUB  X23, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X23, X26, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    SUB  X23, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xffa5, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X23, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0xc1fe, LSL #0
    MOVK  X26, #0x4985, LSL #16
    MOVK  X26, #0x985b, LSL #32
    MOVK  X26, #0x10d4, LSL #48
    SUB  X23, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X26, #0x5a, LSL #0
    SUB  X23, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, DataReverseIntP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    ADC  W13, W27, W25
    ADC  X19, X26, X26
    ADCS  W16, W24, W24
    ADCS  X7, X5, X25
    ADD  W4, W11, W17, UXTW #0
    ADD  X27, X27, W24, SXTW #2
    ADD  W26, W3, #0xd3f
    ADD  X24, X11, #0xcf5
    ADD  W3, W10, W21, LSL #29
    ADD  X8, X23, X23, ASR #11
    ADDS  W5, W15, W23, UXTB #0
    ADDS  X15, X25, W17, UXTB #1
    ADDS  W18, W11, #0x8ae
    ADDS  X17, X11, #0x24, LSL #12
    ADDS  W23, W21, W20, LSL #3
    ADDS  X25, X14, X9, LSL #36
    AND  W20, W20, #0xffff8000
    AND  X14, X14, #0xe0001fffe0001fff
    AND  W11, W11, W9, LSR #20
    AND  X10, X9, X9, ASR #11
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x9a5a, LSL #16
    SUB  X29, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xb4b4, LSL #0
    MOVK  X6, #0xb4b4, LSL #16
    SUB  X29, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5ab4, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X29, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xb4b4, LSL #0
    MOVK  X6, #0xb4b4, LSL #16
    MOVK  X6, #0xb4b4, LSL #32
    MOVK  X6, #0xb4b4, LSL #48
    SUB  X29, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0x5a65, LSL #48
    SUB  X29, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x4a4a, LSL #0
    MOVK  X6, #0x4a4a, LSL #16
    MOVK  X6, #0x4a4a, LSL #32
    MOVK  X6, #0xa, LSL #48
    SUB  X29, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xb4b4, LSL #0
    MOVK  X6, #0xb4b4, LSL #16
    SUB  X29, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x1a5a, LSL #0
    MOVK  X6, #0x4000, LSL #16
    MOVK  X6, #0x1a5a, LSL #32
    MOVK  X6, #0x4000, LSL #48
    SUB  X29, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5b0e, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xb4b4, LSL #0
    MOVK  X6, #0xb4b4, LSL #16
    SUB  X29, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x9a5a, LSL #0
    MOVK  X6, #0x5a5c, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x6308, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X29, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xb4b4, LSL #0
    MOVK  X6, #0xb4b4, LSL #16
    MOVK  X6, #0xb4b4, LSL #32
    MOVK  X6, #0xb4b4, LSL #48
    SUB  X29, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X29, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x2d2a, LSL #0
    MOVK  X6, #0x2d2d, LSL #16
    SUB  X29, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x674f, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0xfffa, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X29, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x6799, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X29, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xc3c2, LSL #0
    MOVK  X6, #0xc3c3, LSL #16
    MOVK  X6, #0x5a5b, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    ANDS  X11, X23, #0xff0000000000ffff
    ANDS  W13, W27, W24, ROR #4
    ANDS  X27, X21, X25, LSR #39
    ASR  W23, W26, #0x1b
    ASR  X21, X21, #0xa
    ASR  W24, W17, W4
    ASR  X8, X4, X15
    ASRV  W15, W20, W18
    ASRV  X16, X7, X17
    BFI  W7, W17, #11, #12
    BFI  X18, X9, #33, #30
    BFM  W20, W19, #0x16, #0x19
    BFM  X19, X10, #0x1b, #0x3e
    BFXIL  W26, W14, #0xe, #3
    BFXIL  X3, X17, #0x1b, #5
    BIC  W9, W14, W17, ROR #28
    BIC  X25, X25, X10, ROR #61
    BICS  W4, W10, W14, ASR #3
    BICS  X17, X10, X10, ROR #9
    CLS  W10, W10
    MOVZ  X6, #0x5a4b, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x1010, LSL #0
    MOVK  X6, #0x5010, LSL #16
    SUB  X29, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xd25a, LSL #0
    MOVK  X6, #0x5a52, LSL #16
    SUB  X29, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x9696, LSL #0
    MOVK  X6, #0x9696, LSL #16
    MOVK  X6, #0x16, LSL #32
    SUB  X29, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X29, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a00, LSL #48
    SUB  X29, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x16, LSL #0
    SUB  X29, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x9696, LSL #0
    MOVK  X6, #0x9696, LSL #16
    MOVK  X6, #0x16, LSL #32
    SUB  X29, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5252, LSL #0
    MOVK  X6, #0x5252, LSL #16
    MOVK  X6, #0x5252, LSL #32
    MOVK  X6, #0x5252, LSL #48
    SUB  X29, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0xb4b4, LSL #32
    MOVK  X6, #0x34b4, LSL #48
    SUB  X29, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x4b4b, LSL #0
    MOVK  X6, #0x4b4b, LSL #16
    MOVK  X6, #0x5a5b, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a59, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X29, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x9696, LSL #0
    MOVK  X6, #0x9696, LSL #16
    MOVK  X6, #0x9696, LSL #32
    MOVK  X6, #0x16, LSL #48
    SUB  X29, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xb, LSL #0
    SUB  X29, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x16, LSL #0
    SUB  X29, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x808, LSL #0
    MOVK  X6, #0x808, LSL #16
    MOVK  X6, #0x808, LSL #32
    MOVK  X6, #0x808, LSL #48
    SUB  X29, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a59, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X29, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x1010, LSL #0
    MOVK  X6, #0x10, LSL #16
    SUB  X29, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    CLZ  W26, W27
    CLZ  X3, X23
    CSEL  W14, W25, W24, HI
    CSEL  X7, X20, X16, NV
    CSINC  W23, W16, W15, LE
    CSINC  X16, X21, X25, NE
    CSINV  W5, W9, W5, HI
    CSINV  X24, X13, X9, MI
    CSNEG  W15, W9, W4, VS
    CSNEG  X25, X20, X20, VC
    EON  W8, W13, W19, LSR #10
    EON  X20, X10, X4, ASR #20
    EOR  W13, W11, #0x1ffff0
    EOR  X27, X27, #0x7f7f7f7f7f7f7f7f
    EOR  W9, W4, W17, LSL #31
    EOR  X21, X17, X11, ROR #38
    EXTR  W19, W19, W19, #0x4
    EXTR  X4, X11, X17, #0x21
    MADD  W10, W17, W17, W11
    MADD  X18, X18, X17, X17
    MOVZ  X6, #0x1, LSL #0
    SUB  X29, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x2d2d, LSL #0
    MOVK  X6, #0x2d2d, LSL #16
    MOVK  X6, #0x2d2d, LSL #32
    MOVK  X6, #0x2d2d, LSL #48
    SUB  X29, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    SUB  X29, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x3333, LSL #0
    MOVK  X6, #0xa5b3, LSL #16
    SUB  X29, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X29, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xc1fe, LSL #0
    MOVK  X6, #0x4985, LSL #16
    SUB  X29, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5aa, LSL #0
    MOVK  X6, #0x5a45, LSL #16
    SUB  X29, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X29, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a6, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    SUB  X29, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xc1fe, LSL #0
    MOVK  X6, #0x4985, LSL #16
    MOVK  X6, #0xd10d, LSL #32
    MOVK  X6, #0x5894, LSL #48
    SUB  X29, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    SUB  X29, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0xa000, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X29, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x3333, LSL #0
    MOVK  X6, #0x3333, LSL #16
    MOVK  X6, #0x3333, LSL #32
    MOVK  X6, #0x3333, LSL #48
    SUB  X29, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5b, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X29, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X29, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x1, LSL #0
    SUB  X29, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x2525, LSL #0
    MOVK  X6, #0x2525, LSL #16
    MOVK  X6, #0x2525, LSL #32
    MOVK  X6, #0x2525, LSL #48
    SUB  X29, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    MNEG  X19, X23, X23
    MSUB  W26, W14, W26, W27
    MSUB  X9, X25, X20, X24
    MUL  W5, W16, W3
    MUL  X11, X24, X11
    MVN  W24, W20, ROR #4
    MVN  X21, X23, LSR #32
    NEG  W3, W14, LSR #3
    NEG  X4, X27, LSR #54
    NEGS  W23, W14, ASR #1
    NEGS  X10, X14, LSR #4
    NGC  W25, W7
    NGC  X13, X20
    NGCS  W16, W14
    NGCS  X17, X14
    ORN  W27, W14, W18, ASR #26
    ORN  X18, X7, X8, LSR #14
    ORR  W20, W7, #0xfffc0fff
    ORR  X7, X14, #0xf80ffffff80fffff
    ORR  W14, W14, W14, ASR #30
    MOVZ  X6, #0xb4b5, LSL #0
    MOVK  X6, #0xf4b4, LSL #16
    SUB  X29, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xfe97, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X29, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x67a4, LSL #0
    MOVK  X6, #0xef2b, LSL #16
    SUB  X29, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xfa5f, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xfa5f, LSL #48
    SUB  X29, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xf2b6, LSL #0
    MOVK  X6, #0x6b2e, LSL #16
    MOVK  X6, #0xe3a7, LSL #32
    MOVK  X6, #0x5c1f, LSL #48
    SUB  X29, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5b, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0xfa5a, LSL #48
    SUB  X29, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x67a4, LSL #0
    MOVK  X6, #0xef2b, LSL #16
    MOVK  X6, #0x76b2, LSL #32
    MOVK  X6, #0xfe3a, LSL #48
    SUB  X29, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X29, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5b, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X29, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    SUB  X29, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X29, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xdede, LSL #0
    MOVK  X6, #0xdede, LSL #16
    MOVK  X6, #0xdede, LSL #32
    MOVK  X6, #0xfffe, LSL #48
    SUB  X29, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x985c, LSL #0
    MOVK  X6, #0x10d4, LSL #16
    MOVK  X6, #0x894d, LSL #32
    MOVK  X6, #0x1c5, LSL #48
    SUB  X29, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5fff, LSL #0
    MOVK  X6, #0xfffe, LSL #16
    SUB  X29, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X29, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xd2d3, LSL #0
    MOVK  X6, #0xd2d2, LSL #16
    SUB  X29, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X29, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    SUB  X29, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xf2b6, LSL #0
    MOVK  X6, #0x6b2e, LSL #16
    SUB  X29, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xfffb, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X29, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    RBIT  W18, W26
    RBIT  X9, X27
    REV  W8, W24
    REV  X4, X15
    REV16  W10, W25
    REV16  X19, X20
    REV32  X26, X23
    ROR  W11, W24, #0x17
    ROR  X21, X16, #0x2c
    ROR  W27, W5, W25
    ROR  X3, X7, X25
    RORV  W23, W5, W23
    RORV  X16, X24, X14
    SBC  W15, W24, W25
    SBC  X20, X24, X25
    SBCS  W7, W24, W14
    SBCS  X24, X14, X25
    SBFIZ  W17, W13, #25, #3
    SBFIZ  X13, X13, #14, #27
    SBFM  W5, W25, #0x1f, #0x5
    MOVZ  X6, #0x9696, LSL #0
    MOVK  X6, #0x9696, LSL #16
    MOVK  X6, #0x9696, LSL #32
    MOVK  X6, #0x9696, LSL #48
    SUB  X29, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x34, LSL #0
    SUB  X29, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X29, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X29, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X29, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xb4b4, LSL #0
    MOVK  X6, #0xb4b4, LSL #16
    SUB  X29, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x8000, LSL #0
    MOVK  X6, #0x9696, LSL #16
    MOVK  X6, #0x96, LSL #32
    SUB  X29, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X29, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x9696, LSL #0
    MOVK  X6, #0x9696, LSL #16
    MOVK  X6, #0x9696, LSL #32
    MOVK  X6, #0x9696, LSL #48
    SUB  X29, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x400, LSL #16
    SUB  X29, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X29, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X29, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X29, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x9696, LSL #0
    MOVK  X6, #0x9696, LSL #16
    SUB  X29, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X29, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x9696, LSL #0
    MOVK  X6, #0x9696, LSL #16
    SUB  X29, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SBFX  W14, W24, #0xe, #16
    SBFX  X8, X17, #0x37, #1
    SDIV  W18, W23, W25
    SDIV  X27, X20, X27
    SMADDL  X21, W19, W26, X26
    SMNEGL  X4, W7, W7
    SMSUBL  X19, W11, W16, X23
    SMULH  X11, X13, X5
    SMULL  X25, W17, W16
    SUB  W23, W5, W23, UXTH #1
    SUB  X20, X3, W7, SXTH #1
    SUB  W24, W10, #0xd40, LSL #12
    SUB  X13, X9, #0x9ab, LSL #12
    SUB  W17, W9, W9, LSR #5
    SUB  X15, X3, X26, LSR #50
    SUBS  W9, W5, W26, SXTB #2
    SUBS  X16, X7, W5, UXTB #1
    SUBS  W7, W5, #0xadd, LSL #12
    SUBS  X10, X10, #0x924, LSL #12
    SUBS  W5, W26, W3, LSR #12
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x985c, LSL #0
    MOVK  X6, #0x10d4, LSL #16
    MOVK  X6, #0x5895, LSL #32
    MOVK  X6, #0xe01c, LSL #48
    SUB  X29, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xb4b5, LSL #0
    MOVK  X6, #0x5a54, LSL #16
    SUB  X29, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x8a5a, LSL #0
    MOVK  X6, #0x59ac, LSL #16
    SUB  X29, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x58f2, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X29, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x1a5a, LSL #0
    MOVK  X6, #0x59c8, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xb679, LSL #0
    MOVK  X6, #0x2ef2, LSL #16
    MOVK  X6, #0xa76b, LSL #32
    MOVK  X6, #0x1fe3, LSL #48
    SUB  X29, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xaa5a, LSL #0
    MOVK  X6, #0x59bf, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x6969, LSL #0
    SUB  X29, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x43c4, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x59a6, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x8788, LSL #0
    MOVK  X6, #0x5787, LSL #16
    SUB  X29, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x1, LSL #0
    SUB  X29, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xf2b6, LSL #0
    MOVK  X6, #0x6b2e, LSL #16
    MOVK  X6, #0xb2ef, LSL #32
    MOVK  X6, #0x3a76, LSL #48
    SUB  X29, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a6, LSL #0
    MOVK  X6, #0x5a59, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xc1fe, LSL #0
    MOVK  X6, #0x4985, LSL #16
    MOVK  X6, #0x1c5, LSL #32
    MOVK  X6, #0x7a3e, LSL #48
    SUB  X29, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a6, LSL #0
    MOVK  X6, #0x5a59, LSL #16
    SUB  X29, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5986, LSL #16
    SUB  X29, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x67a4, LSL #0
    MOVK  X6, #0xef2b, LSL #16
    MOVK  X6, #0xa76a, LSL #32
    MOVK  X6, #0x1fe3, LSL #48
    SUB  X29, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x1, LSL #0
    SUB  X29, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SXTB  W16, W26
    SXTB  X17, W27
    SXTH  W25, W24
    SXTH  X20, W21
    SXTW  X19, W5
    TST  W4, #0x1ffe000
    TST  X21, #0x6666666666666666
    TST  W3, W27, ASR #1
    TST  X27, X21, ASR #7
    UBFIZ  W26, W10, #3, #25
    UBFIZ  X4, X10, #8, #54
    UBFM  W14, W9, #0x11, #0xf
    UBFM  X24, X23, #0x29, #0x11
    UBFX  W9, W27, #0xb, #11
    UBFX  X21, X8, #0x1d, #5
    UDIV  W10, W7, W10
    UDIV  X8, X11, X7
    UMADDL  X18, W3, W13, X7
    UMNEGL  X13, W27, W11
    UMSUBL  X5, W7, W11, X5
    UMULH  X7, X27, X11
    UMULL  X15, W23, W11
    UXTB  W11, W23
    UXTH  W3, W27
    MOVZ  X6, #0x5a5a, LSL #0
    SUB  X29, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a00, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x1a5a, LSL #48
    SUB  X29, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xf2b6, LSL #0
    MOVK  X6, #0x6b2e, LSL #16
    MOVK  X6, #0xb2ef, LSL #32
    MOVK  X6, #0x3a76, LSL #48
    SUB  X29, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xb679, LSL #0
    MOVK  X6, #0x2ef2, LSL #16
    MOVK  X6, #0xa76b, LSL #32
    MOVK  X6, #0x1fe3, LSL #48
    SUB  X29, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x1, LSL #0
    SUB  X29, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x34b, LSL #0
    SUB  X29, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x1, LSL #0
    SUB  X29, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a, LSL #0
    SUB  X29, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x985c, LSL #0
    MOVK  X6, #0x10d4, LSL #16
    MOVK  X6, #0x5895, LSL #32
    MOVK  X6, #0xe01c, LSL #48
    SUB  X29, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x2d2d, LSL #16
    SUB  X29, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x67a4, LSL #0
    MOVK  X6, #0xef2b, LSL #16
    MOVK  X6, #0xa76a, LSL #32
    MOVK  X6, #0x1fe3, LSL #48
    SUB  X29, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a, LSL #0
    SUB  X29, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a, LSL #0
    SUB  X29, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xc1fe, LSL #0
    MOVK  X6, #0x4985, LSL #16
    MOVK  X6, #0x1c5, LSL #32
    MOVK  X6, #0x7a3e, LSL #48
    SUB  X29, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X29, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    SUB  X29, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x12, LSL #0
    SUB  X29, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x2d00, LSL #16
    MOVK  X6, #0x12d, LSL #32
    SUB  X29, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    SUB  X29, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0xd2d0, LSL #0
    MOVK  X6, #0x2d2, LSL #16
    SUB  X29, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X29, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseIntP01_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    ADC  W25, W20, W29
    ADC  X3, X23, X27
    ADCS  W26, W26, W26
    ADCS  X15, X24, X7
    ADD  W20, W16, W17, UXTB #1
    ADD  X17, X17, W24, UXTH #2
    ADD  W4, W27, #0x469
    ADD  X29, X13, #0x641
    ADD  W8, W18, W23, LSL #9
    ADD  X10, X11, X19, ASR #58
    ADDS  W23, W21, W13, UXTX #1
    ADDS  X14, X7, W24, SXTB #4
    ADDS  W7, W24, #0xcc7, LSL #12
    ADDS  X21, X16, #0x622, LSL #12
    ADDS  W27, W11, W9, ASR #31
    ADDS  X19, X13, X11, ASR #26
    AND  W11, W13, #0x7f
    AND  X18, X16, #0x7ffffff87ffffff8
    AND  W16, W16, W24, ROR #11
    AND  X13, X24, X13, ASR #61
    MOVZ  X6, #0x4b4a, LSL #0
    MOVK  X6, #0x4b4b, LSL #16
    MOVK  X6, #0x4b4b, LSL #32
    MOVK  X6, #0x4b4b, LSL #48
    SUB  X5, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xaa0e, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    SUB  X5, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x15a5, LSL #0
    MOVK  X6, #0xa672, LSL #16
    SUB  X5, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xefa5, LSL #0
    MOVK  X6, #0xf0f0, LSL #16
    SUB  X5, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa58e, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x25, LSL #0
    SUB  X5, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x9ff5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x4b4b, LSL #0
    MOVK  X6, #0x4b4b, LSL #16
    MOVK  X6, #0x4b4b, LSL #32
    MOVK  X6, #0x4b4b, LSL #48
    SUB  X5, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa4a4, LSL #0
    MOVK  X6, #0xa4a4, LSL #16
    SUB  X5, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x3c39, LSL #0
    MOVK  X6, #0xa5a8, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a0, LSL #0
    MOVK  X6, #0x25a5, LSL #16
    MOVK  X6, #0xa5a0, LSL #32
    MOVK  X6, #0x25a5, LSL #48
    SUB  X5, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xf0e, LSL #0
    MOVK  X6, #0xf0f, LSL #16
    MOVK  X6, #0xa58f, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa6ef, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    SUB  X5, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xc5a5, LSL #0
    MOVK  X6, #0xa607, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xf0ef, LSL #0
    MOVK  X6, #0xf0f0, LSL #16
    SUB  X5, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x4b4a, LSL #0
    MOVK  X6, #0x4b4b, LSL #16
    SUB  X5, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x4b4a, LSL #0
    MOVK  X6, #0x4b4b, LSL #16
    SUB  X5, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a4, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    SUB  X5, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xabe6, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    ANDS  X18, X23, #0xffc0000000000001
    ANDS  W23, W25, W27, ASR #15
    ANDS  X25, X26, X29, LSR #43
    ASR  W26, W16, #0x1
    ASR  X29, X21, #0xb
    ASR  W21, W10, W15
    ASR  X7, X13, X8
    ASRV  W8, W13, W15
    ASRV  X3, X15, X9
    BFI  W16, W11, #11, #11
    BFI  X4, X27, #30, #32
    BFM  W20, W27, #0x18, #0x14
    BFM  X17, X19, #0x15, #0x0
    BFXIL  W19, W19, #0x17, #2
    BFXIL  X24, X24, #0x2, #47
    BIC  W9, W10, W27, LSR #29
    BIC  X13, X27, X14, ASR #56
    BICS  W11, W10, W15, ASR #10
    BICS  X14, X27, X10, LSL #11
    CLS  W15, W15
    MOVZ  X6, #0x2d2d, LSL #0
    MOVK  X6, #0xfd2d, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X5, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0x65a5, LSL #16
    MOVK  X6, #0x6969, LSL #32
    MOVK  X6, #0xa969, LSL #48
    SUB  X5, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x2d2d, LSL #0
    MOVK  X6, #0xfd2d, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X5, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x2d2d, LSL #0
    MOVK  X6, #0xfd2d, LSL #16
    SUB  X5, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a0, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    SUB  X5, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x8484, LSL #0
    MOVK  X6, #0x4, LSL #16
    SUB  X5, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x85a5, LSL #0
    MOVK  X6, #0x8080, LSL #16
    MOVK  X6, #0x8080, LSL #32
    MOVK  X6, #0x8080, LSL #48
    SUB  X5, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x2da5, LSL #0
    MOVK  X6, #0xa5ad, LSL #16
    SUB  X5, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xada5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x1, LSL #0
    MOVK  X6, #0xa580, LSL #48
    SUB  X5, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a7, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    SUB  X5, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    SUB  X5, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x2d2d, LSL #0
    MOVK  X6, #0xfd2d, LSL #16
    SUB  X5, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x101, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    SUB  X5, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x6969, LSL #0
    MOVK  X6, #0x6969, LSL #16
    MOVK  X6, #0xe969, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa4a4, LSL #0
    MOVK  X6, #0x4, LSL #16
    SUB  X5, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xd2d2, LSL #0
    MOVK  X6, #0xd2d2, LSL #16
    SUB  X5, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xb4b4, LSL #0
    MOVK  X6, #0xb4b4, LSL #16
    MOVK  X6, #0xb4b4, LSL #32
    MOVK  X6, #0xfff4, LSL #48
    SUB  X5, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    CLZ  W25, W24
    CLZ  X19, X13
    CSEL  W7, W27, W26, NE
    CSEL  X8, X29, X29, AL
    CSINC  W11, W9, W13, NV
    CSINC  X16, X20, X3, CS
    CSINV  W17, W21, W20, NV
    CSINV  X3, X23, X27, HI
    CSNEG  W15, W10, W14, CC
    CSNEG  X13, X20, X4, EQ
    EON  W9, W4, W29, ASR #17
    EON  X23, X4, X20, ROR #43
    EOR  W4, W21, #0x7c7c7c7c
    EOR  X27, X26, #0xfc0003fffc0003ff
    EOR  W24, W20, W20, LSR #13
    EOR  X20, X18, X14, ROR #0
    EXTR  W14, W10, W21, #0xc
    EXTR  X18, X18, X10, #0x14
    MADD  W26, W26, W21, W10
    MADD  X29, X10, X10, X21
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X5, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xd9d9, LSL #0
    MOVK  X6, #0xd9d9, LSL #16
    SUB  X5, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    SUB  X5, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x8888, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    SUB  X5, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    SUB  X5, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5b, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X5, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X5, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    SUB  X5, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a6, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    SUB  X5, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X5, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xeeee, LSL #0
    MOVK  X6, #0xeeee, LSL #16
    MOVK  X6, #0xeeee, LSL #32
    MOVK  X6, #0xeeee, LSL #48
    SUB  X5, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x8888, LSL #0
    MOVK  X6, #0xa5a0, LSL #16
    SUB  X5, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xc1fe, LSL #0
    MOVK  X6, #0x4985, LSL #16
    SUB  X5, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa65a, LSL #0
    MOVK  X6, #0x59a5, LSL #16
    MOVK  X6, #0xa65a, LSL #32
    MOVK  X6, #0x59a5, LSL #48
    SUB  X5, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xc1fe, LSL #0
    MOVK  X6, #0x4985, LSL #16
    MOVK  X6, #0xd10d, LSL #32
    MOVK  X6, #0x5894, LSL #48
    SUB  X5, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    MNEG  X15, X27, X25
    MSUB  W4, W24, W26, W29
    MSUB  X23, X20, X11, X29
    MUL  W10, W14, W18
    MUL  X14, X19, X14
    MVN  W3, W16, LSL #10
    MVN  X7, X9, LSL #24
    NEG  W17, W19, ASR #10
    NEG  X21, X20, LSL #51
    NEGS  W27, W18, ASR #3
    NEGS  X20, X11, ASR #43
    NGC  W24, W9
    NGC  X18, X8
    NGCS  W25, W26
    NGCS  X19, X19
    ORN  W26, W11, W8, LSL #8
    ORN  X8, X16, X8, ROR #7
    ORR  W16, W13, #0x3ffe00
    ORR  X13, X9, #0x1f8000000000000
    ORR  W9, W29, W11, LSR #6
    MOVZ  X6, #0x6bff, LSL #0
    MOVK  X6, #0x6969, LSL #16
    SUB  X5, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x894c, LSL #0
    MOVK  X6, #0x1c5, LSL #16
    SUB  X5, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0x5aff, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X5, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xb5b5, LSL #0
    MOVK  X6, #0xb5b5, LSL #16
    MOVK  X6, #0xb5b5, LSL #32
    MOVK  X6, #0xb5b5, LSL #48
    SUB  X5, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xb7b7, LSL #0
    MOVK  X6, #0xa7b7, LSL #16
    SUB  X5, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x1c59, LSL #0
    MOVK  X6, #0xa3e0, LSL #16
    SUB  X5, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5fd, LSL #48
    SUB  X5, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x1c59, LSL #0
    MOVK  X6, #0xa3e0, LSL #16
    MOVK  X6, #0x2b67, LSL #32
    MOVK  X6, #0xb2ef, LSL #48
    SUB  X5, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xe3a7, LSL #0
    MOVK  X6, #0x5c1f, LSL #16
    MOVK  X6, #0xd498, LSL #32
    MOVK  X6, #0x4d10, LSL #48
    SUB  X5, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xffa5, LSL #0
    MOVK  X6, #0xa5bf, LSL #16
    SUB  X5, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x9697, LSL #0
    MOVK  X6, #0x16, LSL #16
    SUB  X5, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X5, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X5, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x4b4c, LSL #0
    MOVK  X6, #0xb, LSL #16
    SUB  X5, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0xd2d8, LSL #48
    SUB  X5, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x894c, LSL #0
    MOVK  X6, #0x1c5, LSL #16
    MOVK  X6, #0x7a3e, LSL #32
    MOVK  X6, #0xf2b6, LSL #48
    SUB  X5, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X5, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X5, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X5, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x4b4c, LSL #0
    MOVK  X6, #0xb4b, LSL #16
    SUB  X5, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    RBIT  W16, W26
    RBIT  X17, X24
    REV  W7, W29
    REV  X24, X25
    REV16  W13, W27
    REV16  X20, X15
    REV32  X3, X19
    ROR  W9, W15, #0x1b
    ROR  X21, X11, #0x21
    ROR  W4, W19, W23
    ROR  X8, X29, X27
    RORV  W29, W10, W25
    RORV  X15, X26, X27
    SBC  W19, W11, W19
    SBC  X10, X25, X11
    SBCS  W11, W23, W26
    SBCS  X25, X18, X25
    SBFIZ  W14, W27, #19, #11
    SBFIZ  X26, X23, #29, #5
    SBFM  W18, W27, #0x0, #0x19
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x2d2d, LSL #0
    MOVK  X6, #0x2d2d, LSL #16
    SUB  X5, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    SUB  X5, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x2d2d, LSL #0
    MOVK  X6, #0x2d2d, LSL #16
    MOVK  X6, #0x2d2d, LSL #32
    MOVK  X6, #0x2d2d, LSL #48
    SUB  X5, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xb4b4, LSL #0
    MOVK  X6, #0xb4b4, LSL #16
    SUB  X5, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X5, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X5, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    SUB  X5, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0xed28, LSL #16
    SUB  X5, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x2d2d, LSL #0
    MOVK  X6, #0x2d2d, LSL #16
    MOVK  X6, #0x2d2d, LSL #32
    MOVK  X6, #0x2d2d, LSL #48
    SUB  X5, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    SUB  X5, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0x1a5, LSL #16
    SUB  X5, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X5, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xd2d2, LSL #0
    MOVK  X6, #0xd2d2, LSL #16
    MOVK  X6, #0xd2d2, LSL #32
    MOVK  X6, #0xd2d2, LSL #48
    SUB  X5, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X5, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0xa000, LSL #16
    SUB  X5, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x2d2d, LSL #0
    MOVK  X6, #0x2d2d, LSL #16
    SUB  X5, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SBFX  W4, W26, #0x1c, #2
    SBFX  X24, X25, #0x33, #10
    SDIV  W8, W27, W25
    SDIV  X19, X13, X15
    SMADDL  X17, W29, W10, X29
    SMNEGL  X7, W26, W10
    SMSUBL  X18, W3, W14, X3
    SMULH  X3, X11, X13
    SMULL  X20, W27, W23
    SUB  W27, W16, W27, SXTB #0
    SUB  X16, X23, W15, SXTW #2
    SUB  W25, W14, #0xdb5
    SUB  X14, X10, #0xe60, LSL #12
    SUB  W23, W29, W21, ASR #12
    SUB  X13, X10, X26, ASR #42
    SUBS  W15, W26, W21, SXTX #3
    SUBS  X10, X11, W21, UXTB #2
    SUBS  W29, W11, #0x85f
    SUBS  X21, X11, #0x352, LSL #12
    SUBS  W9, W9, W26, LSR #28
    MOVZ  X6, #0xb67a, LSL #0
    MOVK  X6, #0x2ef2, LSL #16
    MOVK  X6, #0xa76b, LSL #32
    MOVK  X6, #0x1fe3, LSL #48
    SUB  X5, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xfffe, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X5, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xe3a7, LSL #0
    MOVK  X6, #0x5c1f, LSL #16
    MOVK  X6, #0x5894, LSL #32
    MOVK  X6, #0xe01c, LSL #48
    SUB  X5, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x1, LSL #0
    SUB  X5, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa59b, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    SUB  X5, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa311, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x3c3c, LSL #0
    MOVK  X6, #0xa5bc, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa4bf, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x787d, LSL #0
    MOVK  X6, #0x7878, LSL #16
    SUB  X5, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xf11, LSL #0
    MOVK  X6, #0xf0f, LSL #16
    MOVK  X6, #0xa5a7, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xc1fe, LSL #0
    MOVK  X6, #0x4985, LSL #16
    MOVK  X6, #0x4d11, LSL #32
    MOVK  X6, #0xc589, LSL #48
    SUB  X5, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x894c, LSL #0
    MOVK  X6, #0x1c5, LSL #16
    MOVK  X6, #0xfe3a, LSL #32
    MOVK  X6, #0x85c1, LSL #48
    SUB  X5, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x1, LSL #0
    SUB  X5, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x1c59, LSL #0
    MOVK  X6, #0xa3e0, LSL #16
    MOVK  X6, #0xa76b, LSL #32
    MOVK  X6, #0x1fe3, LSL #48
    SUB  X5, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x85a5, LSL #0
    MOVK  X6, #0xa570, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x4b4b, LSL #0
    MOVK  X6, #0xa5ab, LSL #16
    SUB  X5, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xb4, LSL #0
    SUB  X5, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x97f0, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    SUB  X5, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa600, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    SUB  X5, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x9d46, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    SUB  X5, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SXTB  W29, W27
    SXTB  X13, W25
    SXTH  W16, W24
    SXTH  X11, W26
    SXTW  X10, W10
    TST  W18, #0x78787878
    TST  X9, #0x7ffffe00000
    TST  W15, W21, ASR #10
    TST  X23, X23, LSR #49
    UBFIZ  W25, W17, #26, #4
    UBFIZ  X21, X4, #19, #9
    UBFM  W23, W23, #0xd, #0x1b
    UBFM  X24, X4, #0x36, #0x31
    UBFX  W27, W19, #0xf, #15
    UBFX  X19, X26, #0x22, #3
    UDIV  W15, W4, W8
    UDIV  X18, X26, X14
    UMADDL  X26, W26, W3, X26
    UMNEGL  X9, W17, W7
    UMSUBL  X17, W17, W4, X7
    UMULH  X8, X4, X3
    UMULL  X14, W14, W20
    UXTB  W4, W20
    UXTH  W20, W7
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    SUB  X5, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x1c4, LSL #0
    MOVK  X6, #0x7a3e, LSL #16
    MOVK  X6, #0xf2b6, LSL #32
    MOVK  X6, #0x6b2e, LSL #48
    SUB  X5, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xe3a7, LSL #0
    MOVK  X6, #0x5c1f, LSL #16
    MOVK  X6, #0xd4a, LSL #32
    MOVK  X6, #0x94d1, LSL #48
    SUB  X5, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X5, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X5, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xffa5, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X5, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x1c59, LSL #0
    MOVK  X6, #0xa3e0, LSL #16
    MOVK  X6, #0xf2b5, LSL #32
    MOVK  X6, #0x6b2e, LSL #48
    SUB  X5, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x1, LSL #0
    SUB  X5, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X5, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x894c, LSL #0
    MOVK  X6, #0x1c5, LSL #16
    MOVK  X6, #0xb2f0, LSL #32
    MOVK  X6, #0x3a76, LSL #48
    SUB  X5, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x1, LSL #0
    SUB  X5, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x1, LSL #0
    SUB  X5, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    SUB  X5, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0xd28, LSL #16
    SUB  X5, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x2d2d, LSL #0
    SUB  X5, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x9400, LSL #0
    MOVK  X6, #0x9696, LSL #16
    MOVK  X6, #0x9696, LSL #32
    MOVK  X6, #0x696, LSL #48
    SUB  X5, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x1400, LSL #16
    SUB  X5, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xc1fe, LSL #0
    MOVK  X6, #0x4985, LSL #16
    MOVK  X6, #0x985b, LSL #32
    MOVK  X6, #0x10d4, LSL #48
    SUB  X5, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0x4b4b, LSL #0
    SUB  X5, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail
    MOVZ  X6, #0xffa5, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X5, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseIntP01_TestFail

DataReverseIntP01_TestEnd:
    MOVZ  X1, #0x0, LSL #0
    STP  X1, X2, [X0], #16
    STP  X3, X4, [X0], #16
    STP  X5, X6, [X0], #16
    STP  X7, X8, [X0], #16
    STP  X9, X10, [X0], #16
    STP  X11, X12, [X0], #16
    STP  X13, X14, [X0], #16
    STP  X15, X16, [X0], #16
    STP  X17, X18, [X0], #16
    STP  X19, X20, [X0], #16
    STP  X21, X22, [X0], #16
    STP  X23, X24, [X0], #16
    STP  X25, X26, [X0], #16
    STP  X27, X28, [X0], #16
    STP  X29, X30, [X0], #16
    LDP  X2, X3, [SP], #16
    MSR  NZCV, X2
    ISB  SY
    LDP  X29, X30, [SP], #16
    LDP  X27, X28, [SP], #16
    LDP  X25, X26, [SP], #16
    LDP  X23, X24, [SP], #16
    LDP  X21, X22, [SP], #16
    LDP  X19, X20, [SP], #16
    LDP  X17, X18, [SP], #16
    LDP  X15, X16, [SP], #16
    LDP  X13, X14, [SP], #16
    LDP  X11, X12, [SP], #16
    LDP  X9, X10, [SP], #16
    LDP  X7, X8, [SP], #16
    LDP  X5, X6, [SP], #16
    LDP  X3, X4, [SP], #16
    LDP  X1, X2, [SP], #16
    RET
DataReverseIntP01_TestFail:
    STP  X1, X2, [X0], #16
    STP  X3, X4, [X0], #16
    STP  X5, X6, [X0], #16
    STP  X7, X8, [X0], #16
    STP  X9, X10, [X0], #16
    STP  X11, X12, [X0], #16
    STP  X13, X14, [X0], #16
    STP  X15, X16, [X0], #16
    STP  X17, X18, [X0], #16
    STP  X19, X20, [X0], #16
    STP  X21, X22, [X0], #16
    STP  X23, X24, [X0], #16
    STP  X25, X26, [X0], #16
    STP  X27, X28, [X0], #16
    STP  X29, X30, [X0], #16
    LDP  X2, X3, [SP], #16
    MSR  NZCV, X2
    ISB  SY
    LDP  X29, X30, [SP], #16
    LDP  X27, X28, [SP], #16
    LDP  X25, X26, [SP], #16
    LDP  X23, X24, [SP], #16
    LDP  X21, X22, [SP], #16
    LDP  X19, X20, [SP], #16
    LDP  X17, X18, [SP], #16
    LDP  X15, X16, [SP], #16
    LDP  X13, X14, [SP], #16
    LDP  X11, X12, [SP], #16
    LDP  X9, X10, [SP], #16
    LDP  X7, X8, [SP], #16
    LDP  X5, X6, [SP], #16
    LDP  X3, X4, [SP], #16
    LDP  X1, X2, [SP], #16
    RET
