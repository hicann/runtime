.global TaishanIntMduP01

.text
.p2align 4

TaishanIntMduP01:

TaishanIntMduP01_TestBegin:
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
    MRS  X1, NZCV
    STP  X1, X2, [SP, #-16]!
    MOVZ  X1, #0x0, LSL #0
    MOVK  X2, #0x4952, LSL #48
    MOVK  X2, #0xfbfb, LSL #32
    MOVK  X2, #0xdfe6, LSL #16
    MOVK  X2, #0x76f7, LSL #0
    MOVK  X3, #0x4999, LSL #48
    MOVK  X3, #0x4636, LSL #32
    MOVK  X3, #0x3c83, LSL #16
    MOVK  X3, #0x2394, LSL #0
    MOVK  X5, #0x25d8, LSL #48
    MOVK  X5, #0x32dc, LSL #32
    MOVK  X5, #0x5ac8, LSL #16
    MOVK  X5, #0xb6d9, LSL #0
    MOVK  X6, #0xd67e, LSL #48
    MOVK  X6, #0x9418, LSL #32
    MOVK  X6, #0xee5a, LSL #16
    MOVK  X6, #0x1796, LSL #0
    MOVK  X7, #0x37c5, LSL #48
    MOVK  X7, #0x5801, LSL #32
    MOVK  X7, #0xcb08, LSL #16
    MOVK  X7, #0xa633, LSL #0
    MOVK  X8, #0x1956, LSL #48
    MOVK  X8, #0xd90c, LSL #32
    MOVK  X8, #0x1984, LSL #16
    MOVK  X8, #0xbeed, LSL #0
    MOVK  X9, #0xc2f3, LSL #48
    MOVK  X9, #0xfc71, LSL #32
    MOVK  X9, #0x8f7d, LSL #16
    MOVK  X9, #0xd557, LSL #0
    MOVK  X10, #0x8c51, LSL #48
    MOVK  X10, #0x6b42, LSL #32
    MOVK  X10, #0xfefb, LSL #16
    MOVK  X10, #0x2879, LSL #0
    MOVK  X11, #0x6281, LSL #48
    MOVK  X11, #0x6333, LSL #32
    MOVK  X11, #0xdcad, LSL #16
    MOVK  X11, #0x28e7, LSL #0
    MOVK  X12, #0x4c9c, LSL #48
    MOVK  X12, #0x93d8, LSL #32
    MOVK  X12, #0xaf6, LSL #16
    MOVK  X12, #0x222, LSL #0
    MOVK  X13, #0xceb, LSL #48
    MOVK  X13, #0x7ced, LSL #32
    MOVK  X13, #0xcefd, LSL #16
    MOVK  X13, #0xaa46, LSL #0
    MOVK  X14, #0x6f46, LSL #48
    MOVK  X14, #0xb2ec, LSL #32
    MOVK  X14, #0x2a55, LSL #16
    MOVK  X14, #0xf29b, LSL #0
    MOVK  X15, #0xaef5, LSL #48
    MOVK  X15, #0x2b60, LSL #32
    MOVK  X15, #0x589d, LSL #16
    MOVK  X15, #0xfa74, LSL #0
    MOVK  X16, #0xe6cb, LSL #48
    MOVK  X16, #0xb8bb, LSL #32
    MOVK  X16, #0x5062, LSL #16
    MOVK  X16, #0x97f7, LSL #0
    MOVK  X17, #0x1bf6, LSL #48
    MOVK  X17, #0xba83, LSL #32
    MOVK  X17, #0x3063, LSL #16
    MOVK  X17, #0x90b8, LSL #0
    MOVK  X18, #0x6cbb, LSL #48
    MOVK  X18, #0xc15d, LSL #32
    MOVK  X18, #0x2df0, LSL #16
    MOVK  X18, #0xe8f0, LSL #0
    MOVK  X19, #0x7223, LSL #48
    MOVK  X19, #0xe14e, LSL #32
    MOVK  X19, #0xcf89, LSL #16
    MOVK  X19, #0xb5b, LSL #0
    MOVK  X20, #0xfa8a, LSL #48
    MOVK  X20, #0x9342, LSL #32
    MOVK  X20, #0x3b9, LSL #16
    MOVK  X20, #0xc6cb, LSL #0
    MOVK  X21, #0x93e3, LSL #48
    MOVK  X21, #0x6922, LSL #32
    MOVK  X21, #0x1cd0, LSL #16
    MOVK  X21, #0xfbf9, LSL #0
    MOVK  X22, #0x3d8f, LSL #48
    MOVK  X22, #0x2ba9, LSL #32
    MOVK  X22, #0x538b, LSL #16
    MOVK  X22, #0x83cb, LSL #0
    MOVK  X23, #0xe9b5, LSL #48
    MOVK  X23, #0x597b, LSL #32
    MOVK  X23, #0xade3, LSL #16
    MOVK  X23, #0xa995, LSL #0
    MOVK  X24, #0xdad3, LSL #48
    MOVK  X24, #0x4142, LSL #32
    MOVK  X24, #0x42c7, LSL #16
    MOVK  X24, #0x6686, LSL #0
    MOVK  X25, #0x8534, LSL #48
    MOVK  X25, #0xdd8e, LSL #32
    MOVK  X25, #0xfd11, LSL #16
    MOVK  X25, #0x5cdf, LSL #0
    MOVK  X26, #0x5f59, LSL #48
    MOVK  X26, #0x36c0, LSL #32
    MOVK  X26, #0xb8b4, LSL #16
    MOVK  X26, #0xad36, LSL #0
    MOVK  X27, #0xbbf3, LSL #48
    MOVK  X27, #0x51e7, LSL #32
    MOVK  X27, #0xffe1, LSL #16
    MOVK  X27, #0xeafa, LSL #0
    MOVK  X28, #0x9019, LSL #48
    MOVK  X28, #0xbdd7, LSL #32
    MOVK  X28, #0x533f, LSL #16
    MOVK  X28, #0xfd90, LSL #0
    MOVK  X29, #0xd694, LSL #48
    MOVK  X29, #0x4dcf, LSL #32
    MOVK  X29, #0x5b87, LSL #16
    MOVK  X29, #0xa6e0, LSL #0
    ADDS  W28, W21, W11, LSL #10
    MOVZ  X2, #0x192b, LSL #0
    MOVK  X2, #0x7e66, LSL #16
    MOVK  X2, #0x3a82, LSL #32
    MOVK  X2, #0xf184, LSL #48
    MOVZ  X3, #0xe46, LSL #0
    MOVK  X3, #0x4a46, LSL #16
    MOVK  X3, #0x7c7d, LSL #32
    MOVK  X3, #0x8727, LSL #48
    MOVZ  X5, #0xd8a8, LSL #0
    MOVK  X5, #0xa24e, LSL #16
    MOVK  X5, #0x3367, LSL #32
    MOVK  X5, #0x9c67, LSL #48
    MOVZ  X6, #0xee07, LSL #0
    MOVK  X6, #0xf1ff, LSL #16
    MOVK  X6, #0xa289, LSL #32
    MOVK  X6, #0xe18, LSL #48
    MOVZ  X7, #0xc540, LSL #0
    MOVK  X7, #0x3e6a, LSL #16
    MOVK  X7, #0x788d, LSL #32
    MOVK  X7, #0x747d, LSL #48
    MOVZ  X8, #0xf1ec, LSL #0
    MOVK  X8, #0x22, LSL #16
    MOVK  X8, #0xa944, LSL #32
    MOVK  X8, #0xcc74, LSL #48
    MOVZ  X9, #0x14b3, LSL #0
    MOVK  X9, #0x6b4, LSL #16
    MOVK  X9, #0x39b3, LSL #32
    MOVK  X9, #0x3f94, LSL #48
    MOVZ  X10, #0x5b95, LSL #0
    MOVK  X10, #0x925f, LSL #16
    MOVK  X10, #0x270, LSL #32
    MOVK  X10, #0x8a52, LSL #48
    MOVZ  X11, #0x2322, LSL #0
    MOVK  X11, #0x8724, LSL #16
    MOVK  X11, #0x6054, LSL #32
    MOVK  X11, #0xe117, LSL #48
    MOVZ  X12, #0x374b, LSL #0
    MOVK  X12, #0xddc, LSL #16
    MOVK  X12, #0x34c8, LSL #32
    MOVK  X12, #0xa062, LSL #48
    MOVZ  X13, #0x999b, LSL #0
    MOVK  X13, #0xc242, LSL #16
    MOVK  X13, #0xfbc8, LSL #32
    MOVK  X13, #0xcebb, LSL #48
    MOVZ  X14, #0x4dea, LSL #0
    MOVK  X14, #0xe6ce, LSL #16
    MOVK  X14, #0x90db, LSL #32
    MOVK  X14, #0x5ed9, LSL #48
    MOVZ  X15, #0x50b4, LSL #0
    MOVK  X15, #0xda6a, LSL #16
    MOVK  X15, #0x87e9, LSL #32
    MOVK  X15, #0xf203, LSL #48
    MOVZ  X16, #0x580c, LSL #0
    MOVK  X16, #0x525d, LSL #16
    MOVK  X16, #0xaf2f, LSL #32
    MOVK  X16, #0xa9ac, LSL #48
    MOVZ  X17, #0xeb24, LSL #0
    MOVK  X17, #0xc3d1, LSL #16
    MOVK  X17, #0x4274, LSL #32
    MOVK  X17, #0xbc50, LSL #48
    MOVZ  X18, #0x35c8, LSL #0
    MOVK  X18, #0xa8d, LSL #16
    MOVK  X18, #0x229b, LSL #32
    MOVK  X18, #0xe1dd, LSL #48
    MOVZ  X19, #0x5c14, LSL #0
    MOVK  X19, #0x57b4, LSL #16
    MOVK  X19, #0xeed2, LSL #32
    MOVK  X19, #0xc5d, LSL #48
    MOVZ  X20, #0x8e18, LSL #0
    MOVK  X20, #0x4d22, LSL #16
    MOVK  X20, #0x5e37, LSL #32
    MOVK  X20, #0xee24, LSL #48
    MOVZ  X21, #0x2ba7, LSL #0
    MOVK  X21, #0x6baa, LSL #16
    MOVK  X21, #0xf6f4, LSL #32
    MOVK  X21, #0x7471, LSL #48
    MOVZ  X22, #0x8e89, LSL #0
    MOVK  X22, #0x844c, LSL #16
    MOVK  X22, #0x4d7d, LSL #32
    MOVK  X22, #0xb843, LSL #48
    MOVZ  X23, #0xcb36, LSL #0
    MOVK  X23, #0xc719, LSL #16
    MOVK  X23, #0xed34, LSL #32
    MOVK  X23, #0x8cfb, LSL #48
    MOVZ  X24, #0xfd70, LSL #0
    MOVK  X24, #0x70a1, LSL #16
    MOVK  X24, #0xa02b, LSL #32
    MOVK  X24, #0xaa94, LSL #48
    MOVZ  X25, #0x2a17, LSL #0
    MOVK  X25, #0x2ce, LSL #16
    MOVK  X25, #0x8bba, LSL #32
    MOVK  X25, #0x5783, LSL #48
    MOVZ  X26, #0x69a7, LSL #0
    MOVK  X26, #0x7ed8, LSL #16
    MOVK  X26, #0x89c4, LSL #32
    MOVK  X26, #0x9923, LSL #48
    MOVZ  X27, #0x19e7, LSL #0
    MOVK  X27, #0xd153, LSL #16
    MOVK  X27, #0xefa6, LSL #32
    MOVK  X27, #0x654d, LSL #48
    MOVZ  X28, #0xc070, LSL #0
    MOVK  X28, #0x97c6, LSL #16
    MOVK  X28, #0xc29c, LSL #32
    MOVK  X28, #0xfb1a, LSL #48
    MOVZ  X29, #0x8b67, LSL #0
    MOVK  X29, #0x4bc4, LSL #16
    MOVK  X29, #0xa4e6, LSL #32
    MOVK  X29, #0x1cd9, LSL #48
    MOVZ  X29, #0x14, LSL #0
TaishanIntMduP01_label_0:
    ORR  X19, X26, X12, ASR #42
    LSRV  W7, W16, W27
    AND  X2, X15, #0xffff801fffff801f
    EOR  W28, W8, #0x600060
    ADC  W23, W29, W23
    ADCS  W10, W6, W28
    UBFM  X19, X5, #0xe, #0xf
    MADD  X25, X24, X28, X23
    MOVN  X15, #0x1989, LSL #32
    CSINC  W7, W21, W7, EQ
    CRC32W  W23, W9, W20
    CRC32X  W10, W12, X3
    ANDS  W28, W24, #0x300000
    SUB  X12, X20, W25, UXTB #3
    CRC32H  W3, W29, W29
    ADD  W21, W19, #0x6fd, LSL #12
    EXTR  W21, W12, W12, #0xa
    CLS  W15, W24
    ADD  X22, X10, X2, ASR #10
    ORR  V23.8B, V27.8B, V28.8B
    CLZ  X24, X7
    SUB  W10, W20, #0x9f5
    BICS  X13, X28, X10, LSL #30
    ORN  W17, W23, W21, ASR #0
    BICS  W5, W8, W8, LSR #0
    CRC32CB  W22, W5, W21
    SUBS  W2, W17, W6, LSR #18
    ADC  X16, X28, X13
    EOR  W3, W2, #0x38383838
    AND  X22, X19, X24, LSR #16
    SUBS  W23, W22, W27, LSR #30
    EOR  X16, X15, X20, LSR #59
    SUB  X28, X16, #0x93d, LSL #12
    ADC  W13, W18, W23
    MOVK  X26, #0xf47b, LSL #48
    ADC  X10, X15, X5
    CRC32W  W10, W12, W28
    ADDS  X12, X9, #0xa4
    UMADDL  X5, W25, W19, X28
    ORR  V23.4H, #0x78, LSL #8
    LSRV  W2, W13, W10
    ORR  W21, W17, W16, ROR #15
    CSINC  W2, W28, W29, HI
    AND  W11, W27, #0xaaaaaaaa
    ADDS  X3, X29, #0x710
    CSINC  W22, W20, W7, AL
    UBFM  W20, W28, #0x10, #0x12
    EOR  W9, W9, #0x2020202
    ADC  W9, W29, W8
    ORR  W9, W12, W16, LSR #0
    CRC32W  W28, W5, W25
    CRC32H  W21, W13, W11
    ADDS  W7, W23, #0x383, LSL #12
    MOVN  X12, #0x1865, LSL #48
    ADDS  X25, X28, #0x936, LSL #12
    SMULH  X9, X7, X28
    EOR  W25, W20, #0x3e003e
    SUBS  W6, W20, W22, SXTB #1
    LSLV  W3, W27, W5
    EXTR  W8, W18, W3, #0x9
    ORR  V19.4H, #0xa8
    SUB  X3, X11, #0x47, LSL #12
    CRC32CB  W3, W7, W28
    AND  W3, W10, W26, LSR #14
    ADD  W15, W23, W9, SXTW #3
    ADD  X16, X18, X19, LSR #25
    CRC32CX  W13, W20, X6
    EOR  W7, W21, #0xfff003ff
    MADD  W21, W7, W11, W22
    MOVZ  W18, #0x9d4a, LSL #16
    ADDS  W8, W24, W13, SXTW #3
    SMSUBL  X28, W19, W9, X21
    SUB  X13, X29, W8, SXTH #3
    ORR  W22, W9, W12, ROR #21
    CLZ  V15.8H, V1.8H
    ADCS  X8, X10, X11
    BIC  V2.8B, V17.8B, V11.8B
    SUBS  X27, X20, #0x5ef
    SUBS  W22, W11, W27, SXTW #4
    MADD  X8, X15, X12, X22
    ORR  W19, W24, #0xfff007ff
    ORR  W19, W24, W7, ROR #0
    CLZ  X13, X21
    ASRV  W18, W18, W6
    SBFM  W28, W26, #0x7, #0x15
    ORR  W24, W7, #0xfff8001f
    MOVN  X23, #0xde64, LSL #16
    UBFM  W27, W29, #0x1b, #0x5
    EON  W22, W13, W28, ASR #16
    UBFM  W13, W13, #0x1, #0x3
    SMULH  X24, X28, X22
    EON  X3, X24, X16, ROR #29
    ADD  X8, X26, X15, LSL #31
    CRC32H  W24, W15, W19
    CRC32X  W11, W10, X20
    EOR  W26, W12, #0xf3ffffff
    UBFM  W19, W22, #0x13, #0x1d
    ADCS  X15, X5, X2
    ADDS  X26, X24, X15, LSL #51
    EOR  X18, X19, #0xfcfcfcfcfcfcfcfc
    LSLV  X5, X3, X24
    SUB  X16, X2, X18, UXTX #3
    EON  W13, W3, W13, LSR #21
    CRC32CB  W24, W28, W11
    AND  W11, W15, W24, LSL #5
    ADDS  W28, W3, W25, LSR #23
    CSINC  X16, X16, X24, MI
    ORR  X24, X10, X26, LSL #7
    MOVN  W17, #0x4212, LSL #0
    SUB  X26, X17, #0x95, LSL #12
    UBFM  W28, W6, #0x8, #0x11
    CRC32CX  W11, W14, X12
    ORR  W19, W17, #0xe3e3e3e3
    CRC32CB  W3, W6, W19
    ORR  X18, X26, X28, LSR #2
    ADCS  X14, X17, X3
    ASRV  W13, W11, W6
    UBFM  W12, W10, #0x1, #0x9
    BIC  W21, W18, W17, LSL #3
    MOVN  W10, #0xdc6f, LSL #0
    ANDS  X16, X7, X14, LSL #3
    ORR  V14.16B, V25.16B, V0.16B
    AND  W15, W14, W14, ASR #21
    ORR  V6.4S, #0x9b, LSL #16
    BIC  X9, X10, X19, ASR #7
    CSEL  X15, X24, X15, CC
    ADDS  W19, W9, #0x22e, LSL #12
    ADDS  X25, X16, W27, UXTB #1
    ADDS  W27, W13, W5, SXTW #4
    MOVK  X15, #0x937e, LSL #16
    ADCS  W18, W6, W21
    ORR  X18, X22, X9, ROR #0
    ORR  V15.4S, #0x90
    SMSUBL  X13, W18, W23, X8
    CRC32CB  W24, W9, W23
    SBFM  W7, W24, #0x1b, #0x3
    MADD  W7, W22, W10, W18
    SUBS  X27, X22, #0x15e
    SMSUBL  X15, W25, W19, X3
    AND  W20, W2, #0xffffffef
    EXTR  X24, X16, X28, #0x1c
    ADCS  W5, W21, W2
    MADD  X21, X17, X5, X28
    ADD  W26, W20, W9, UXTX #4
    SMADDL  X17, W24, W25, X26
    EOR  W12, W6, W6, ASR #28
    MADD  X22, X11, X24, X17
    ORR  V29.2S, #0x47, LSL #8
    ORR  V28.4H, #0xcc
    ADD  X16, X11, #0x300, LSL #12
    CRC32H  W24, W3, W2
    MADD  W16, W6, W26, W16
    SUBS  X5, X28, X29, LSL #23
    SUBS  X24, X25, X10, UXTX #0
    ADD  W8, W7, W7, SXTX #0
    AND  X5, X22, X3, LSR #0
    UMSUBL  X21, W18, W7, X6
    MOVN  W10, #0x5c51, LSL #16
    BICS  W28, W16, W2, LSR #16
    CSINC  X12, X15, X19, NE
    EOR  X11, X12, #0xc000c000c000c
    BIC  W9, W2, W7, ASR #15
    MOVN  X21, #0xc414, LSL #48
    SUB  X5, X28, X7, LSR #31
    EON  W28, W19, W14, LSR #12
    AND  X24, X8, X9, ASR #0
    ADD  W2, W10, W19, SXTX #0
    CLS  X14, X9
    EOR  X24, X3, #0x7ffffff000
    MADD  W19, W6, W9, W6
    UBFM  X26, X21, #0x17, #0x28
    ORN  X19, X21, X20, ROR #57
    ORR  W21, W14, #0x7ffffe0
    ASRV  W12, W14, W10
    ANDS  X13, X27, #0x9fffffff9fffffff
    MOVK  W24, #0x1d51, LSL #16
    ADC  W14, W13, W7
    UMULH  X6, X20, X22
    MOVZ  W27, #0x879, LSL #0
    BIC  W25, W20, W22, ASR #3
    CSINC  W9, W3, W20, CS
    ADDS  W26, W12, W3, UXTH #3
    CRC32X  W19, W28, X28
    ORR  V22.8H, #0x1a, LSL #8
    CLZ  V23.8B, V17.8B
    ANDS  W12, W23, #0x3f
    ORR  X8, X16, X8, LSL #30
    EON  X27, X15, X29, ASR #41
    ADDS  X21, X28, #0x2a3, LSL #12
    CRC32CW  W7, W21, W28
    SUBS  W19, W22, #0x729
    CRC32CB  W17, W10, W16
    MADD  W18, W6, W20, W17
    CRC32CX  W8, W6, X18
    CSINC  W13, W11, W22, LE
    MOVN  X11, #0x2a7, LSL #48
    ORR  X7, X16, #0x2000000000000
    CSEL  X12, X11, X13, EQ
    MOVZ  W19, #0xe7e8, LSL #0
    BIC  V28.16B, V19.16B, V6.16B
    SUBS  X29, X29, #0x1
    B.NE  TaishanIntMduP01_label_0
    MOVZ  X13, #0xdfff, LSL #0
    MOVK  X13, #0xa1d1, LSL #16
    SUB  X27, X13, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X5, #0xbb93, LSL #0
    MOVK  X5, #0xe2ca, LSL #16
    SUB  X17, X5, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X13, #0xbb93, LSL #0
    MOVK  X13, #0xe2ca, LSL #16
    SUB  X17, X13, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP01_TestFail
    MOVZ  X27, #0xe867, LSL #0
    MOVK  X27, #0x876f, LSL #16
    MOVK  X27, #0x2, LSL #48
    SUB  X20, X27, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X28, #0xd2dc, LSL #0
    MOVK  X28, #0x2abb, LSL #16
    SUB  X17, X28, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X15, #0x3, LSL #0
    SUB  X25, X15, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xa3ae, LSL #16
    SUB  X8, X24, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xfd58, LSL #48
    SUB  X17, X28, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X16, #0xbb9f, LSL #0
    MOVK  X16, #0x831e, LSL #16
    SUB  X24, X16, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP01_TestFail
    MOVZ  X23, #0xbb93, LSL #0
    MOVK  X23, #0xe2ca, LSL #16
    SUB  X16, X23, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x453e, LSL #0
    MOVK  X26, #0xa01d, LSL #16
    SUB  X12, X26, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP01_TestFail
    MOVZ  X6, #0x3, LSL #0
    SUB  X9, X6, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X24, #0xa27, LSL #0
    MOVK  X24, #0x18d2, LSL #16
    SUB  X15, X24, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP01_TestFail
    MOVZ  X9, #0xe7e8, LSL #0
    SUB  X25, X9, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP01_TestFail
    MOVZ  X27, #0x6358, LSL #0
    MOVK  X27, #0x1fd, LSL #16
    SUB  X13, X27, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X22
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X10, #0xbb93, LSL #0
    MOVK  X10, #0xe2ca, LSL #16
    SUB  X11, X10, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X23, #0xa27, LSL #0
    MOVK  X23, #0x18d2, LSL #16
    SUB  X19, X23, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X25
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X7, #0x453e, LSL #0
    MOVK  X7, #0xa01d, LSL #16
    SUB  X8, X7, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X8, #0x6358, LSL #0
    MOVK  X8, #0x1fd, LSL #16
    SUB  X6, X8, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X22, X23, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X12, X9, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X21, #0x14, LSL #0
TaishanIntMduP01_label_28:
    BIC  X28, X14, X24, LSL #28
    SBFM  X12, X28, #0x8, #0x5
    SMADDL  X14, W15, W12, X19
    SUBS  X20, X20, #0x2ed, LSL #12
    ADD  W8, W12, W15, LSR #16
    SUB  W17, W21, W12, SXTH #3
    UMULH  X9, X13, X23
    CLS  X7, X29
    ANDS  X2, X22, #0x3ffc00000000
    ADC  W22, W11, W11
    ADC  X19, X29, X14
    CRC32CH  W12, W27, W14
    BIC  X6, X22, X26, LSL #17
    SUBS  W13, W24, #0x9c3, LSL #12
    SUBS  X24, X16, #0xb8f
    EOR  X12, X5, X20, ASR #3
    ADD  W7, W11, #0xdd3
    ADDS  W18, W28, W9, ASR #27
    CSINC  W7, W15, W28, CS
    CRC32B  W15, W20, W19
    CRC32CH  W10, W20, W12
    LSLV  X25, X3, X21
    UBFM  X8, X26, #0xb, #0x19
    CRC32CH  W5, W13, W27
    ORR  W26, W26, W5, ASR #2
    ORR  X22, X13, X9, LSL #32
    CLZ  X22, X13
    MOVN  X22, #0x18, LSL #16
    CLS  V9.4H, V17.4H
    LSLV  X28, X12, X15
    ORN  X14, X24, X23, ROR #48
    LSRV  W25, W29, W18
    CSNEG  X7, X29, X12, MI
    AND  W28, W25, W17, LSR #7
    CRC32W  W6, W10, W17
    SUB  W22, W23, W27, SXTH #3
    SUB  W10, W8, W22, SXTX #2
    AND  W24, W9, #0x8fffffff
    SMULH  X15, X8, X24
    CLZ  V7.2S, V5.2S
    UBFM  X15, X13, #0x22, #0x27
    CRC32CW  W13, W13, W15
    CRC32CW  W11, W15, W10
    EOR  W15, W5, W12, ROR #31
    BIC  X28, X6, X15, LSL #31
    MOVN  W20, #0x1483, LSL #0
    SUB  X11, X7, X11, ASR #54
    CLS  W22, W14
    ORR  V18.4H, #0x80, LSL #8
    CLS  V9.4S, V12.4S
    EON  X13, X27, X9, ASR #19
    BICS  X28, X29, X13, ROR #56
    ORR  V26.4H, #0xcc
    CSNEG  X29, X18, X19, LS
    BICS  X13, X19, X23, ASR #25
    EOR  X5, X9, #0x7ffff8000000
    ORN  W2, W22, W22, ASR #12
    EON  X26, X11, X23, LSR #61
    AND  W22, W18, W6, ASR #26
    AND  X13, X13, X13, LSL #28
    ASRV  W22, W7, W21
    SMULH  X9, X16, X19
    MOVN  X9, #0x8c20, LSL #32
    AND  W23, W6, W13, LSR #30
    CRC32B  W25, W26, W26
    ADDS  W9, W28, W6, UXTH #4
    CSEL  W26, W13, W17, EQ
    AND  X29, X28, #0x9999999999999999
    ORR  V24.8H, #0x57
    ORR  W7, W23, #0x7ffe
    EXTR  X25, X27, X9, #0x3
    ADDS  X23, X28, #0x90
    CRC32CX  W20, W15, X15
    CLS  W13, W19
    SBFM  X24, X21, #0x39, #0x10
    ORR  X26, X6, X27, LSL #42
    ADD  W19, W17, W29, ASR #11
    SUBS  W24, W21, #0x4a7, LSL #12
    MADD  X16, X13, X16, X24
    UBFM  W23, W27, #0xe, #0x1e
    SMADDL  X24, W16, W22, X9
    ADCS  X28, X24, X2
    MOVZ  W24, #0xbf58, LSL #0
    MOVZ  W20, #0x359b, LSL #0
    AND  W23, W22, #0xfffff00f
    CLS  V0.16B, V24.16B
    UMSUBL  X26, W29, W14, X12
    CRC32CW  W29, W8, W25
    ORN  X18, X18, X6, LSR #9
    ORR  V25.4S, #0x4, LSL #8
    EOR  X3, X16, X18, LSL #16
    CLZ  W23, W15
    CSINV  X5, X12, X18, HI
    ADDS  W16, W23, W7, ASR #3
    ADDS  X10, X5, W5, SXTB #1
    BIC  W10, W13, W8, ASR #29
    ORN  W25, W26, W24, LSR #19
    EOR  W7, W13, #0x3f003f00
    ANDS  W7, W10, W3, ROR #21
    UMADDL  X26, W14, W9, X29
    ORR  W27, W27, W16, ROR #28
    CLZ  W26, W13
    ADCS  W28, W22, W24
    CSINC  W13, W26, W9, CS
    SUB  X2, X13, W11, UXTB #3
    ADDS  X18, X28, X22, LSL #56
    CSNEG  X25, X2, X27, LT
    UBFM  X12, X18, #0x6, #0x7
    BIC  W12, W11, W26, ASR #7
    SUB  X24, X16, W7, UXTH #0
    SUBS  W17, W8, #0x50a, LSL #12
    CRC32X  W22, W17, X7
    ADC  W12, W9, W13
    CRC32CB  W26, W29, W10
    ADCS  W8, W23, W26
    ADD  W12, W14, W27, SXTW #3
    SUB  W11, W2, W19, LSL #27
    LSLV  W22, W27, W6
    CLZ  X7, X6
    UMADDL  X17, W12, W22, X27
    CRC32H  W18, W16, W22
    ORN  X8, X6, X16, LSR #3
    CLZ  X24, X26
    ADD  W25, W19, W26, ASR #16
    ADCS  X12, X20, X18
    CSEL  X14, X10, X8, NE
    CSEL  X12, X28, X22, EQ
    SUB  X3, X20, W11, UXTW #3
    CRC32CB  W15, W2, W11
    CSINC  X23, X19, X26, LS
    CLZ  W13, W14
    SUB  W10, W17, W23, SXTX #4
    CSINC  X3, X22, X5, VC
    EOR  X25, X26, #0xdfffdfffdfffdfff
    SUB  X29, X16, W29, UXTH #1
    CSEL  X2, X17, X23, GE
    EOR  X14, X11, #0xfc00ffffffffffff
    ADDS  X17, X3, #0x1a0
    MOVN  X17, #0x1b0, LSL #0
    BIC  X28, X10, X22, LSR #11
    AND  X3, X9, X11, ASR #48
    CRC32CH  W18, W26, W20
    EON  X2, X22, X3, LSL #8
    BICS  X13, X22, X6, LSL #60
    SUB  W24, W14, W15, SXTB #0
    CLZ  X7, X5
    ANDS  X5, X17, X20, LSR #62
    SUBS  W28, W26, W25, UXTB #2
    ORR  X12, X15, X29, ROR #22
    UMSUBL  X15, W5, W26, X12
    SUBS  X15, X24, #0x435, LSL #12
    CSNEG  W18, W28, W2, NE
    CRC32CB  W23, W13, W13
    ADC  X22, X24, X23
    SUBS  W13, W9, W10, LSL #22
    AND  W5, W18, #0xeeeeeeee
    CSNEG  W29, W28, W15, NV
    ADD  X6, X20, X12, LSR #24
    ADD  X5, X5, X20, LSR #48
    ADC  X22, X27, X24
    ADD  W14, W7, W12, LSR #27
    ANDS  W9, W29, #0x7fc07fc
    SUBS  W12, W8, W6, SXTH #1
    ADDS  W10, W13, W13, SXTX #0
    CSEL  W24, W27, W9, VC
    CSINV  W2, W14, W7, NV
    LSRV  X26, X11, X15
    CSNEG  W28, W6, W20, VC
    ORR  V17.8H, #0xe4
    ADDS  X14, X15, #0xd2b, LSL #12
    SUBS  X27, X27, X8, UXTX #1
    SUBS  X8, X18, #0x860
    CRC32W  W29, W29, W6
    ORR  W10, W22, #0xc0
    ADD  X16, X19, #0x3a4
    CSNEG  X17, X13, X7, AL
    SMADDL  X14, W29, W25, X2
    LSRV  W7, W11, W6
    ORN  X9, X13, X23, ROR #4
    SUB  X2, X20, #0xde6, LSL #12
    SBFM  X10, X23, #0x1c, #0x3e
    LSLV  X13, X21, X6
    LSRV  X11, X7, X21
    MOVK  X17, #0xed75, LSL #48
    ADDS  X15, X20, #0xf96
    CLS  W24, W26
    SUB  W23, W8, W23, SXTH #1
    ORR  X25, X26, X26, LSR #48
    SUB  X11, X14, #0xbd7
    SUBS  X22, X16, #0xaeb
    CLS  X6, X12
    BIC  V3.16B, V16.16B, V14.16B
    SUBS  W16, W6, W18, SXTX #4
    ADD  X16, X19, X23, LSL #14
    UMULH  X6, X13, X25
    ADDS  X14, X23, #0x822, LSL #12
    ORR  V31.16B, V2.16B, V12.16B
    CRC32CX  W23, W8, X16
    CRC32CW  W6, W25, W16
    ADDS  X2, X14, X3, LSR #9
    SUBS  X21, X21, #0x1
    B.NE  TaishanIntMduP01_label_28
    MOVZ  X13, #0xc9a, LSL #0
    MOVK  X13, #0xd818, LSL #16
    SUB  X26, X13, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X27, X17, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X8, #0xc8ea, LSL #0
    MOVK  X8, #0xc684, LSL #16
    SUB  X28, X8, X5
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x6be9, LSL #0
    MOVK  X21, #0x4973, LSL #16
    SUB  X17, X21, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x3f, LSL #0
    SUB  X7, X9, X7
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X2, #0xc8ea, LSL #0
    MOVK  X2, #0xc684, LSL #16
    SUB  X11, X2, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X18, #0x3f, LSL #0
    SUB  X21, X18, X9
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X3, #0xc9a, LSL #0
    MOVK  X3, #0xd818, LSL #16
    SUB  X8, X3, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X15, #0xc9a, LSL #0
    MOVK  X15, #0xd818, LSL #16
    SUB  X12, X15, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP01_TestFail
    MOVZ  X12, #0xc9a, LSL #0
    MOVK  X12, #0xd818, LSL #16
    SUB  X28, X12, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X17, #0xa001, LSL #0
    MOVK  X17, #0x7b26, LSL #16
    MOVK  X17, #0x35e5, LSL #32
    SUB  X16, X17, X16
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP01_TestFail
    MOVZ  X15, #0xa001, LSL #0
    MOVK  X15, #0x7b26, LSL #16
    MOVK  X15, #0x35e5, LSL #32
    SUB  X16, X15, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x3f, LSL #0
    SUB  X25, X2, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X29, #0x2001, LSL #0
    SUB  X5, X29, X19
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X20, #0x359b, LSL #0
    SUB  X16, X20, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X14, X28, X21
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X8, #0x18ba, LSL #0
    SUB  X5, X8, X22
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X11, #0x4475, LSL #0
    MOVK  X11, #0xede6, LSL #16
    SUB  X29, X11, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x1f, LSL #0
    SUB  X6, X26, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X23, #0x1f, LSL #0
    SUB  X16, X23, X26
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X21, X9, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X29
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    MOVZ  X26, #0xa, LSL #0
TaishanIntMduP01_label_55:
    EOR  X5, X20, #0xfe0ffe0ffe0ffe0f
    EOR  X5, X18, #0x3ffffff03ffffff
    UMULH  X13, X28, X10
    SMADDL  X7, W2, W15, X6
    ANDS  X10, X20, #0x80001fffffffffff
    MADD  X15, X6, X28, X10
    EOR  X23, X29, #0x1ffc00000000
    MOVK  X16, #0xb7d7, LSL #0
    EOR  X11, X16, X22, ROR #51
    CLS  V24.16B, V2.16B
    CSINV  W20, W26, W7, MI
    CSINV  W10, W2, W5, CC
    ADD  W18, W14, #0x240
    SBFM  W18, W17, #0xa, #0x6
    ANDS  X16, X23, X14, ROR #28
    CLZ  V15.8B, V31.8B
    ADDS  W2, W6, #0x779
    ANDS  W25, W5, W2, ROR #7
    CLS  X24, X10
    AND  W17, W21, #0x99999999
    CSEL  X28, X25, X10, GT
    BIC  W28, W13, W7, LSR #23
    ADCS  W19, W6, W23
    SUB  W16, W17, W8, LSL #7
    ANDS  X20, X19, X21, ROR #39
    MOVZ  X2, #0xa504, LSL #16
    ADD  X20, X29, #0x5f0
    LSLV  W28, W2, W24
    SUBS  X10, X23, X19, SXTX #1
    ADC  W16, W3, W6
    SUBS  W8, W10, #0x763, LSL #12
    AND  W29, W10, #0x7ff07ff
    CLS  X5, X16
    LSRV  W14, W8, W8
    ANDS  W14, W24, #0xf8f8f8f8
    SUBS  X11, X24, X26, LSL #40
    ADD  X28, X14, #0xa38, LSL #12
    SMULH  X14, X12, X29
    SUB  W16, W27, W7, UXTX #4
    ANDS  X28, X2, #0x1ffffffffff8
    ANDS  X5, X18, X11, ASR #29
    AND  W6, W7, W7, ASR #1
    ADCS  W28, W9, W3
    ANDS  W9, W8, #0xf800f8
    ADD  X29, X2, X22, LSR #25
    CSINC  W5, W14, W14, CS
    ADDS  W19, W17, #0xe6e, LSL #12
    SMADDL  X6, W28, W5, X28
    ADDS  W20, W10, W11, LSL #22
    MOVN  W27, #0xc47d, LSL #16
    ORR  X17, X29, X3, ASR #63
    MOVZ  X27, #0x5bfe, LSL #16
    ANDS  W17, W21, W19, ASR #17
    MOVZ  X25, #0x3a3b, LSL #0
    MOVZ  W23, #0xd87e, LSL #16
    CSEL  W24, W14, W10, MI
    AND  X11, X8, #0xff07ff07ff07ff07
    CSNEG  X16, X16, X20, LT
    CLS  X19, X20
    CRC32CW  W11, W3, W25
    ADDS  W6, W10, W22, UXTB #4
    CRC32H  W8, W16, W5
    SUBS  X27, X14, W27, UXTB #0
    ANDS  X9, X9, #0x3ffffffffffffff8
    ORR  X17, X17, #0x7fffffc000000000
    SBFM  X28, X29, #0x5, #0x34
    ADD  X27, X27, X28, LSL #2
    ADDS  W12, W9, W20, UXTW #0
    AND  W8, W21, W17, LSL #29
    EON  X21, X10, X24, ROR #36
    CSNEG  X25, X12, X10, MI
    ORR  W19, W8, #0xc0
    EXTR  W7, W21, W11, #0x18
    ADDS  X2, X25, X23, ASR #28
    BIC  X22, X16, X24, ASR #12
    SUB  W10, W17, W8, LSR #4
    CRC32CB  W8, W19, W21
    EXTR  W13, W20, W6, #0x15
    SUBS  W24, W27, W2, SXTB #3
    SBFM  W12, W3, #0xe, #0x1
    CRC32B  W29, W6, W13
    EOR  W3, W17, W8, ASR #17
    SUBS  W2, W10, #0x868, LSL #12
    ADC  W8, W2, W21
    AND  X19, X14, X24, LSR #15
    SUBS  W15, W14, W3, SXTW #1
    ASRV  W17, W6, W19
    SUBS  W14, W7, #0x779
    SUBS  W27, W14, #0x0, LSL #12
    SBFM  W6, W12, #0x1c, #0x1d
    ORR  X16, X13, #0xfffc7fffffffffff
    EOR  X3, X8, #0xf00ff00ff00ff00f
    EXTR  X19, X18, X12, #0xe
    ADD  X6, X13, X21, LSL #40
    ASRV  W9, W10, W3
    SUBS  W5, W21, W8, SXTH #3
    CRC32H  W28, W8, W23
    ADCS  X12, X7, X26
    LSRV  W8, W24, W8
    ORR  V1.4H, #0xd
    ORN  W21, W9, W17, LSL #28
    UMULH  X8, X19, X16
    CSINV  X7, X9, X18, LT
    ADDS  X23, X11, W27, SXTW #2
    CRC32CH  W28, W6, W13
    ORR  X18, X10, X20, ROR #0
    CLS  X3, X8
    ADC  X12, X22, X28
    SUBS  W24, W9, W12, UXTH #3
    ADDS  W8, W9, W17, UXTX #1
    CRC32W  W20, W16, W15
    EOR  W21, W3, #0xfc01fc01
    UBFM  W24, W14, #0x7, #0xf
    MOVK  W10, #0x311b, LSL #16
    UMADDL  X14, W23, W20, X8
    SBFM  X27, X18, #0x3, #0x0
    AND  W20, W24, #0xe00000ff
    CLZ  X7, X14
    CSEL  W24, W8, W13, LT
    ADDS  X16, X21, #0xf98
    ADD  W3, W3, W10, LSR #11
    CLZ  W21, W5
    CRC32B  W11, W17, W12
    MADD  X10, X2, X28, X8
    EON  W28, W10, W5, LSR #29
    SBFM  W25, W22, #0x15, #0x0
    EOR  W18, W13, #0x7c007c0
    ORR  X2, X5, X21, ROR #30
    ADDS  W29, W12, W19, LSR #5
    ADC  X10, X25, X16
    CSNEG  W5, W28, W9, LS
    ADC  W20, W18, W15
    CLZ  W15, W16
    MADD  X24, X14, X14, X16
    ADC  X13, X19, X6
    CSINC  X12, X26, X7, VC
    EON  W22, W27, W15, LSL #4
    SMADDL  X29, W5, W29, X23
    SMSUBL  X22, W17, W15, X14
    ADDS  X17, X11, X20, LSR #25
    SBFM  X11, X17, #0x25, #0x1a
    SUBS  X6, X6, X8, LSR #21
    ADDS  X2, X17, #0x6ff, LSL #12
    SUBS  X5, X13, #0xd2c
    ORR  V6.8B, V12.8B, V7.8B
    MADD  W17, W12, W6, W15
    SUB  X7, X2, #0x97f, LSL #12
    EOR  W28, W20, W6, LSL #15
    ORR  X18, X11, X17, LSR #48
    MOVN  X21, #0x588d, LSL #48
    CSEL  X9, X2, X18, LT
    BIC  V9.8B, V17.8B, V18.8B
    SMADDL  X29, W18, W6, X13
    CRC32W  W21, W25, W25
    LSRV  X25, X15, X23
    MADD  W17, W10, W8, W7
    ADC  W20, W20, W6
    ADDS  X24, X15, X7, LSL #4
    ADDS  W20, W10, W3, UXTB #2
    AND  W29, W22, W7, LSR #14
    SUB  W17, W12, W16, LSR #9
    SUBS  W9, W28, #0xd72, LSL #12
    CRC32CB  W29, W13, W13
    EXTR  W13, W29, W7, #0x9
    CRC32CH  W18, W2, W13
    ADDS  X23, X14, W5, SXTB #4
    MOVZ  X18, #0xae43, LSL #48
    ANDS  W15, W29, #0xfe0ffe0f
    SUB  W25, W5, W13, UXTX #3
    ORN  W3, W6, W20, ASR #12
    BIC  V6.16B, V7.16B, V6.16B
    ADD  W27, W5, W21, UXTB #3
    SUBS  X10, X3, W22, SXTW #2
    MOVN  X5, #0xe59, LSL #32
    LSLV  X10, X12, X28
    CLZ  V5.8B, V1.8B
    SUBS  W29, W13, W18, SXTB #1
    LSRV  W17, W20, W18
    BIC  V12.8B, V18.8B, V9.8B
    ADD  W20, W14, W9, LSR #22
    ADD  X9, X8, X2, ASR #2
    EOR  W16, W19, W19, ASR #22
    ADD  W16, W27, W6, SXTW #3
    SUB  W11, W11, #0x350
    ADDS  X21, X13, #0xcdf
    ANDS  W13, W20, #0x55555555
    MOVN  W29, #0xc53d, LSL #16
    AND  X16, X27, X27, ROR #28
    CRC32X  W22, W9, X3
    ORR  W7, W29, #0x4000
    SMULH  X24, X7, X24
    ANDS  W9, W17, W7, LSL #23
    CLZ  V30.4S, V23.4S
    UBFM  X7, X28, #0x33, #0x3a
    SUB  W24, W9, W8, LSL #8
    CSNEG  W23, W27, W29, VC
    BICS  W11, W24, W14, ROR #28
    CSNEG  W3, W20, W25, EQ
    CRC32CW  W18, W3, W7
    SUB  X25, X7, W26, SXTH #1
    SUBS  X26, X26, #0x1
    B.NE  TaishanIntMduP01_label_55
    MOVZ  X25, #0x202e, LSL #0
    MOVK  X25, #0x53d1, LSL #16
    SUB  X17, X25, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X7, #0xf377, LSL #0
    MOVK  X7, #0xdffb, LSL #16
    SUB  X10, X7, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xf1a6, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X9, X6, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xf1a6, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X2, X26, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X13, #0xf377, LSL #0
    MOVK  X13, #0xdffb, LSL #16
    SUB  X12, X13, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP01_TestFail
    MOVZ  X10, #0x1efe, LSL #0
    MOVK  X10, #0xa546, LSL #16
    SUB  X11, X10, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X12, X10, X12
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP01_TestFail
    MOVZ  X25, #0xf377, LSL #0
    MOVK  X25, #0xdffb, LSL #16
    SUB  X19, X25, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP01_TestFail
    MOVZ  X23, #0xf3e6, LSL #0
    MOVK  X23, #0x9e0a, LSL #16
    MOVK  X23, #0x5fef, LSL #32
    MOVK  X23, #0x623d, LSL #48
    SUB  X13, X23, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X20, #0x500e, LSL #0
    MOVK  X20, #0x9, LSL #16
    SUB  X3, X20, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X19, #0x1, LSL #0
    SUB  X6, X19, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X8, X21, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X25, #0x500e, LSL #0
    MOVK  X25, #0x9, LSL #16
    SUB  X7, X25, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X23, X21, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X23
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X6, #0x200, LSL #0
    MOVK  X6, #0xb5e1, LSL #16
    SUB  X18, X6, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X27, #0x500e, LSL #0
    MOVK  X27, #0x9, LSL #16
    SUB  X19, X27, X25
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X26
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP01_TestFail
    MOVZ  X28, #0x500e, LSL #0
    MOVK  X28, #0x9, LSL #16
    SUB  X18, X28, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X18, #0x500e, LSL #0
    MOVK  X18, #0x9, LSL #16
    SUB  X10, X18, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0x3ac2, LSL #16
    SUB  X7, X21, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x7a07, LSL #0
    MOVK  X2, #0x8cce, LSL #16
    MOVK  X2, #0xd7cc, LSL #32
    MOVK  X2, #0x2a03, LSL #48
    MOVZ  X3, #0xedf9, LSL #0
    MOVK  X3, #0xf7a6, LSL #16
    MOVK  X3, #0xf389, LSL #32
    MOVK  X3, #0x3ed6, LSL #48
    MOVZ  X5, #0x60ac, LSL #0
    MOVK  X5, #0x6969, LSL #16
    MOVK  X5, #0x5785, LSL #32
    MOVK  X5, #0x305f, LSL #48
    MOVZ  X6, #0xd781, LSL #0
    MOVK  X6, #0x99bb, LSL #16
    MOVK  X6, #0x8ed, LSL #32
    MOVK  X6, #0x89d1, LSL #48
    MOVZ  X7, #0x786c, LSL #0
    MOVK  X7, #0x742a, LSL #16
    MOVK  X7, #0x91ac, LSL #32
    MOVK  X7, #0x2262, LSL #48
    MOVZ  X8, #0xb664, LSL #0
    MOVK  X8, #0xfc40, LSL #16
    MOVK  X8, #0xbd3f, LSL #32
    MOVK  X8, #0x1fd4, LSL #48
    MOVZ  X9, #0x907, LSL #0
    MOVK  X9, #0x98a6, LSL #16
    MOVK  X9, #0xb56e, LSL #32
    MOVK  X9, #0x61e7, LSL #48
    MOVZ  X10, #0x2071, LSL #0
    MOVK  X10, #0x6fb2, LSL #16
    MOVK  X10, #0x3c50, LSL #32
    MOVK  X10, #0xb095, LSL #48
    MOVZ  X11, #0xadf3, LSL #0
    MOVK  X11, #0x61b7, LSL #16
    MOVK  X11, #0xea21, LSL #32
    MOVK  X11, #0x4834, LSL #48
    MOVZ  X12, #0x8df8, LSL #0
    MOVK  X12, #0xf7b7, LSL #16
    MOVK  X12, #0x57b7, LSL #32
    MOVK  X12, #0xf678, LSL #48
    MOVZ  X13, #0x9e82, LSL #0
    MOVK  X13, #0xb894, LSL #16
    MOVK  X13, #0x93cb, LSL #32
    MOVK  X13, #0xbe51, LSL #48
    MOVZ  X14, #0x8f10, LSL #0
    MOVK  X14, #0x851a, LSL #16
    MOVK  X14, #0xb062, LSL #32
    MOVK  X14, #0xe958, LSL #48
    MOVZ  X15, #0x1a80, LSL #0
    MOVK  X15, #0xd5e1, LSL #16
    MOVK  X15, #0xe066, LSL #32
    MOVK  X15, #0x1f97, LSL #48
    MOVZ  X16, #0xf85b, LSL #0
    MOVK  X16, #0xe33e, LSL #16
    MOVK  X16, #0xafc4, LSL #32
    MOVK  X16, #0xc853, LSL #48
    MOVZ  X17, #0x6d57, LSL #0
    MOVK  X17, #0xc8b3, LSL #16
    MOVK  X17, #0x47ca, LSL #32
    MOVK  X17, #0x66f7, LSL #48
    MOVZ  X18, #0x4373, LSL #0
    MOVK  X18, #0x48c4, LSL #16
    MOVK  X18, #0xb48d, LSL #32
    MOVK  X18, #0x37fe, LSL #48
    MOVZ  X19, #0x7dc, LSL #0
    MOVK  X19, #0x701c, LSL #16
    MOVK  X19, #0x8de, LSL #32
    MOVK  X19, #0x881e, LSL #48
    MOVZ  X20, #0x1d68, LSL #0
    MOVK  X20, #0xc38c, LSL #16
    MOVK  X20, #0x8d26, LSL #32
    MOVK  X20, #0x872, LSL #48
    MOVZ  X21, #0x6f81, LSL #0
    MOVK  X21, #0x2389, LSL #16
    MOVK  X21, #0xcb16, LSL #32
    MOVK  X21, #0xde86, LSL #48
    MOVZ  X22, #0xee0b, LSL #0
    MOVK  X22, #0xb72a, LSL #16
    MOVK  X22, #0x6336, LSL #32
    MOVK  X22, #0x33fa, LSL #48
    MOVZ  X23, #0xf739, LSL #0
    MOVK  X23, #0x735c, LSL #16
    MOVK  X23, #0x5b52, LSL #32
    MOVK  X23, #0x65c0, LSL #48
    MOVZ  X24, #0xf20f, LSL #0
    MOVK  X24, #0xb1f4, LSL #16
    MOVK  X24, #0x6a5e, LSL #32
    MOVK  X24, #0x850a, LSL #48
    MOVZ  X25, #0x1a03, LSL #0
    MOVK  X25, #0x2146, LSL #16
    MOVK  X25, #0xf73b, LSL #32
    MOVK  X25, #0x5cd1, LSL #48
    MOVZ  X26, #0x8e99, LSL #0
    MOVK  X26, #0x9a58, LSL #16
    MOVK  X26, #0x68f6, LSL #32
    MOVK  X26, #0x172, LSL #48
    MOVZ  X27, #0x61d9, LSL #0
    MOVK  X27, #0xdf79, LSL #16
    MOVK  X27, #0xdaca, LSL #32
    MOVK  X27, #0xf59f, LSL #48
    MOVZ  X28, #0xbfb9, LSL #0
    MOVK  X28, #0xdc9b, LSL #16
    MOVK  X28, #0x430a, LSL #32
    MOVK  X28, #0x5ce1, LSL #48
    MOVZ  X29, #0x17ad, LSL #0
    MOVK  X29, #0xa288, LSL #16
    MOVK  X29, #0x5e2e, LSL #32
    MOVK  X29, #0xd35d, LSL #48
    MOVZ  X8, #0x14, LSL #0
TaishanIntMduP01_label_83:
    ORR  W16, W16, #0xefffefff
    ORR  X25, X8, X23, LSL #41
    SMULH  X23, X25, X5
    ANDS  X26, X26, #0x7fffffe07fffffe0
    CRC32CB  W26, W13, W16
    ORN  X24, X22, X15, ROR #53
    LSLV  X3, X29, X29
    CSEL  X29, X5, X9, LE
    SUBS  X23, X3, X9, ASR #55
    CSINV  W10, W27, W21, NV
    UMULH  X26, X6, X19
    UMSUBL  X12, W28, W6, X24
    SMULH  X27, X6, X26
    SMULH  X6, X19, X12
    BIC  W9, W29, W27, ASR #27
    ORR  V8.16B, V5.16B, V9.16B
    CRC32B  W3, W22, W5
    MOVK  X25, #0x19bd, LSL #16
    ADDS  W24, W2, W22, SXTW #3
    UMSUBL  X5, W28, W24, X13
    ORR  W19, W11, W23, ROR #16
    UMSUBL  X26, W20, W13, X9
    CRC32CW  W19, W13, W26
    EXTR  W22, W17, W6, #0x2
    MOVK  W24, #0x881c, LSL #16
    CRC32B  W28, W21, W26
    ADDS  X16, X7, W12, SXTH #1
    LSLV  X15, X26, X17
    ORR  W19, W11, W5, ASR #21
    ORN  X5, X6, X28, ASR #22
    CLS  V31.8B, V14.8B
    UBFM  X2, X14, #0x2f, #0x39
    EOR  W11, W20, #0xc3ffc3ff
    ADCS  X20, X5, X2
    ORR  W13, W27, #0x1fffff
    CRC32CH  W10, W2, W27
    ANDS  W29, W7, #0x3fff0000
    CRC32H  W22, W21, W2
    LSRV  X11, X19, X25
    BIC  X6, X2, X10, LSL #56
    ADDS  X5, X24, X12, ASR #33
    ASRV  W5, W13, W28
    MOVK  W13, #0xb30a, LSL #0
    ADCS  X13, X14, X24
    SUBS  X28, X26, X17, UXTX #0
    CLS  W17, W19
    ASRV  W3, W26, W26
    ADDS  W12, W7, #0x1d7, LSL #12
    LSLV  W5, W11, W13
    UMULH  X16, X16, X23
    AND  X20, X20, #0x7fffc0000
    ASRV  X13, X22, X22
    ORR  W2, W29, #0xc3c3c3c3
    AND  W20, W2, W26, LSR #28
    LSLV  X29, X3, X27
    SUB  X21, X29, X8, LSR #55
    AND  X24, X6, #0x3fffe0003fffe0
    ADDS  W26, W10, W17, LSL #26
    MOVK  W3, #0x8097, LSL #0
    ADDS  W21, W15, W14, LSL #11
    MOVK  X17, #0xeb69, LSL #0
    UBFM  W9, W23, #0x8, #0xd
    ADDS  X2, X2, #0xc3f
    ORR  V15.4H, #0xbc
    ADCS  W19, W12, W20
    CSNEG  X13, X11, X11, CC
    SUB  X11, X23, W23, UXTB #4
    ADD  W9, W22, #0x3c3, LSL #12
    ORR  V0.16B, V30.16B, V27.16B
    EON  W27, W14, W17, ASR #6
    CSINC  W5, W27, W2, LS
    MADD  W12, W14, W19, W20
    EXTR  X10, X13, X16, #0x19
    ORR  V7.4S, #0x60
    ANDS  X3, X20, X11, ROR #45
    SUB  X5, X22, X16, UXTX #3
    LSLV  X23, X5, X29
    ADDS  X3, X13, W3, SXTW #1
    ORR  V20.4H, #0xe0, LSL #8
    CSNEG  W28, W9, W15, EQ
    SBFM  W7, W28, #0x6, #0x1f
    CLS  X6, X26
    MOVN  W26, #0x8972, LSL #0
    BICS  X26, X7, X21, LSL #50
    CSINV  X2, X8, X8, LE
    AND  W5, W28, W28, LSL #12
    ORR  W12, W3, #0xfffff800
    EON  W23, W19, W14, LSR #27
    BIC  V13.16B, V5.16B, V6.16B
    MOVN  W3, #0x829c, LSL #0
    ADDS  X6, X9, W18, UXTW #4
    CSEL  X10, X11, X10, LE
    CSINV  X2, X21, X17, PL
    ADD  X3, X19, #0x5d0
    ADCS  W5, W8, W11
    UMSUBL  X7, W5, W23, X21
    SUB  W3, W22, #0xc1b
    ORR  V6.4H, #0xd3, LSL #8
    LSLV  W21, W29, W15
    ASRV  W9, W21, W29
    MOVN  X18, #0xd853, LSL #16
    SBFM  W19, W14, #0x19, #0x17
    EXTR  W10, W15, W12, #0x8
    EXTR  W23, W28, W12, #0x0
    ANDS  W24, W9, #0x780078
    CSEL  X26, X22, X18, PL
    ADCS  X3, X28, X9
    ADDS  W23, W12, W13, SXTH #1
    ASRV  X28, X22, X28
    SUBS  W5, W11, W10, UXTH #2
    ANDS  W10, W8, W26, LSL #19
    CRC32H  W7, W28, W29
    ORN  X22, X15, X11, ASR #59
    ADCS  X14, X15, X20
    BICS  X21, X7, X9, ROR #3
    LSRV  X26, X17, X24
    SBFM  X24, X20, #0x1, #0x22
    ANDS  X17, X11, #0x87ff87ff87ff87ff
    ORR  W2, W23, W17, LSR #26
    UBFM  X5, X5, #0x1b, #0x1a
    SUB  W10, W13, W6, SXTH #2
    SUB  X29, X5, #0xf4f, LSL #12
    MOVN  X21, #0x65dc, LSL #48
    MOVZ  W18, #0x1fb6, LSL #16
    LSLV  W16, W14, W22
    ADD  W18, W2, W28, UXTW #3
    ADD  W16, W8, #0x92a
    SUBS  W28, W29, W8, UXTX #0
    ORR  V19.4S, #0x63
    ORR  V29.8H, #0xaf, LSL #8
    AND  W10, W25, W28, ROR #20
    CLZ  X6, X12
    CSEL  W7, W9, W26, GT
    EOR  W6, W8, W27, ROR #16
    EON  W14, W21, W22, LSR #0
    ADDS  W21, W11, #0x209, LSL #12
    ADDS  X12, X16, #0xa7d
    UMULH  X16, X2, X12
    UBFM  W17, W15, #0x7, #0x6
    ANDS  X14, X25, #0xffffffffffffe000
    MADD  X22, X7, X8, X13
    SUBS  W23, W10, W6, LSL #31
    EOR  W23, W27, #0x7fe07fe
    BIC  X28, X21, X9, ROR #54
    ORR  W23, W16, #0xfe01fe01
    ADDS  X17, X13, #0x819, LSL #12
    CSINV  X6, X13, X17, AL
    ADDS  X14, X28, X5, LSR #53
    CRC32H  W15, W6, W5
    ADC  X13, X28, X15
    LSRV  X13, X10, X22
    ASRV  W9, W7, W26
    SUB  W28, W25, W3, SXTX #0
    SMADDL  X21, W10, W20, X10
    ANDS  W22, W10, W29, LSR #17
    MOVZ  X3, #0x814f, LSL #16
    ADDS  X24, X29, W27, UXTB #3
    CSNEG  W23, W24, W23, VC
    LSRV  X22, X16, X16
    CLZ  X3, X15
    UMSUBL  X9, W28, W23, X25
    ADCS  W17, W15, W14
    MOVK  X23, #0xbb87, LSL #48
    SUB  W19, W23, #0xe30
    ANDS  W6, W8, W12, ROR #14
    ADC  W25, W24, W15
    EON  W23, W14, W10, LSL #15
    ANDS  X27, X5, X13, LSL #34
    CSNEG  W12, W15, W2, NV
    BICS  X19, X9, X26, ASR #44
    BIC  X19, X21, X26, LSR #31
    LSLV  W12, W7, W16
    SUBS  X16, X16, X10, ASR #20
    LSRV  X17, X3, X10
    CRC32B  W26, W14, W21
    MOVN  X5, #0x6b7b, LSL #48
    EOR  W21, W26, W19, ROR #24
    SUB  W23, W26, #0x9b4
    ADD  X11, X6, W20, SXTH #2
    EOR  W25, W8, W12, ROR #23
    LSRV  W24, W27, W17
    MOVN  X27, #0xbae4, LSL #16
    CLS  X5, X27
    CSINC  X10, X18, X7, NV
    BICS  X25, X14, X6, LSR #4
    ADD  X5, X8, #0xda7, LSL #12
    EON  X3, X25, X17, LSR #16
    CLS  V31.8B, V18.8B
    CSINV  X5, X16, X2, EQ
    BIC  W29, W2, W15, ROR #26
    CLS  W2, W19
    MOVK  W18, #0xa033, LSL #16
    SUB  X28, X7, X2, ASR #8
    ORR  V7.16B, V0.16B, V9.16B
    SUB  X12, X19, X9, LSR #36
    ORR  W15, W17, #0xff000fff
    CLS  V26.4H, V8.4H
    CRC32CB  W20, W28, W18
    CRC32B  W17, W23, W12
    ORR  V27.16B, V16.16B, V14.16B
    SUBS  X8, X8, #0x1
    B.NE  TaishanIntMduP01_label_83
    MOVZ  X6, #0x1, LSL #0
    SUB  X3, X6, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x7ec, LSL #0
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X18, X21, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X17, #0x1, LSL #0
    SUB  X12, X17, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X8
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X7, #0x641, LSL #0
    MOVK  X7, #0x398f, LSL #16
    MOVK  X7, #0x2fcd, LSL #32
    MOVK  X7, #0x1ee, LSL #48
    SUB  X29, X7, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X13, #0x962b, LSL #0
    MOVK  X13, #0x94d8, LSL #16
    SUB  X20, X13, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x8, LSL #0
    SUB  X16, X26, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP01_TestFail
    MOVZ  X23, #0x962b, LSL #0
    MOVK  X23, #0x94d8, LSL #16
    SUB  X9, X23, X13
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X7, #0x2114, LSL #0
    MOVK  X7, #0x7695, LSL #16
    SUB  X9, X7, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X22, #0xfff, LSL #0
    MOVK  X22, #0xff00, LSL #16
    SUB  X19, X22, X15
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X24, #0x1, LSL #0
    SUB  X15, X24, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X19, X7, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X14, #0x962b, LSL #0
    MOVK  X14, #0x94d8, LSL #16
    SUB  X18, X14, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X19, #0x1, LSL #0
    SUB  X21, X19, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP01_TestFail
    MOVZ  X17, #0x2114, LSL #0
    MOVK  X17, #0x7695, LSL #16
    SUB  X8, X17, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X20, #0x8, LSL #0
    SUB  X24, X20, X26
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0x451b, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X26, X18, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X25, #0x14, LSL #0
TaishanIntMduP01_label_110:
    MOVK  X24, #0x808a, LSL #16
    MOVN  X20, #0x1cd8, LSL #32
    BIC  X2, X15, X10, ASR #4
    MADD  W15, W25, W21, W7
    LSRV  W20, W27, W26
    SMULH  X6, X25, X5
    CRC32B  W24, W12, W2
    BIC  V1.16B, V19.16B, V23.16B
    UBFM  X10, X12, #0xb, #0x4
    SUB  X22, X3, X20, LSR #59
    LSLV  W8, W12, W23
    UBFM  W7, W23, #0x1c, #0x1f
    EOR  X8, X11, #0x800000000000000f
    SUB  W26, W28, #0x8ca
    CLS  W9, W20
    ORN  W14, W25, W13, ROR #14
    EXTR  X3, X16, X14, #0x3a
    ADDS  X27, X7, #0xfc2, LSL #12
    AND  W22, W7, W29, ROR #6
    MOVK  X8, #0xa325, LSL #32
    EON  X22, X22, X15, LSR #52
    SUBS  W8, W21, W6, LSL #3
    SUB  W9, W25, W28, UXTH #4
    AND  X5, X21, X26, ASR #40
    MOVZ  X21, #0xf90b, LSL #48
    BICS  X2, X3, X27, LSR #29
    SUB  W11, W5, #0x441, LSL #12
    EOR  W5, W20, W18, LSR #27
    ORR  W21, W15, W5, ASR #16
    ASRV  X26, X25, X9
    SUBS  X23, X5, #0xc08, LSL #12
    CRC32CW  W26, W15, W28
    CRC32B  W29, W17, W21
    SUB  X20, X11, #0xa86, LSL #12
    EXTR  W8, W22, W16, #0xc
    EOR  X2, X5, X3, ROR #52
    SMSUBL  X20, W3, W8, X5
    CSEL  X7, X27, X19, VC
    SUB  W6, W8, W6, SXTH #4
    ADD  X27, X7, X3, LSR #55
    UBFM  X7, X7, #0x10, #0x2
    ORR  V0.4S, #0xb9, LSL #24
    ADDS  X5, X5, X20, SXTX #0
    CRC32CW  W3, W19, W23
    ANDS  X3, X25, X5, ASR #43
    ADDS  X24, X6, X26, ASR #11
    MADD  W3, W10, W22, W28
    CRC32W  W23, W27, W2
    ADCS  X23, X29, X26
    AND  X15, X24, #0xe1e1e1e1e1e1e1e1
    ADDS  W6, W27, #0x65d, LSL #12
    MOVK  X16, #0xaaf1, LSL #0
    ADD  W3, W5, #0xea9
    ORR  W20, W15, W3
    SUB  X27, X27, #0xf1b, LSL #12
    SUBS  X13, X26, X9, LSL #6
    ADDS  X15, X28, #0x4b7
    ADCS  W10, W28, W17
    ADDS  X10, X14, W17, SXTB #0
    CSINV  W15, W19, W21, VS
    CRC32W  W27, W7, W26
    EOR  W26, W26, W24, LSL #23
    ADD  W21, W11, #0xadb
    EON  X22, X10, X3, ASR #22
    ADD  X15, X13, #0x460
    MOVN  W9, #0xc89b, LSL #16
    ADDS  X12, X18, W17, SXTH #0
    ADD  X5, X8, #0x935, LSL #12
    SMSUBL  X19, W10, W25, X27
    SMULH  X28, X11, X18
    CSEL  W28, W7, W16, EQ
    LSRV  X20, X21, X16
    MOVK  W12, #0x18b6, LSL #16
    AND  X26, X28, #0x5555555555555555
    CSINV  W3, W5, W13, VC
    CRC32CB  W22, W14, W26
    CRC32CB  W2, W20, W11
    ORR  W10, W10, W16, ASR #5
    EON  W28, W9, W26, ROR #29
    CRC32CB  W13, W8, W8
    SUBS  X17, X15, X3, ASR #8
    MOVN  W27, #0x4085, LSL #0
    UBFM  W12, W22, #0x15, #0xc
    ADDS  W21, W17, W7, LSR #9
    CSINC  X28, X16, X20, MI
    ORR  X27, X18, #0xffffffc00000001f
    CRC32H  W19, W25, W11
    ASRV  W29, W27, W8
    BICS  X17, X5, X2, LSL #19
    ADD  W18, W13, #0xff6, LSL #12
    EOR  W13, W17, #0x77777777
    UMSUBL  X9, W25, W26, X27
    SUBS  X5, X23, X22, ASR #54
    ADDS  W8, W27, #0x8f0
    CRC32B  W14, W22, W15
    CRC32CH  W22, W19, W28
    ADDS  W26, W25, W13, SXTH #4
    CLS  V4.8B, V19.8B
    ORR  V15.8H, #0xe8
    ADDS  X18, X6, X10, ASR #20
    EON  X19, X6, X23, ASR #62
    BIC  W5, W11, W8, ROR #26
    EON  X17, X12, X8, ROR #48
    ASRV  W26, W19, W2
    EOR  X29, X15, #0x1f00000
    AND  X24, X28, #0x2222222222222222
    ADDS  W10, W6, #0xbf
    ORR  V14.16B, V10.16B, V3.16B
    SUBS  W16, W13, #0x8cf, LSL #12
    EXTR  W12, W16, W17, #0x17
    MADD  X5, X27, X6, X19
    SUB  W16, W21, W17, UXTX #4
    ASRV  X17, X6, X6
    CRC32CB  W24, W9, W13
    ORR  W28, W5, #0xffe3ffe3
    CSINV  W12, W18, W23, GE
    ORR  X28, X12, X20, ASR #51
    BIC  V11.16B, V28.16B, V2.16B
    SUBS  X28, X11, X17, ASR #30
    CSNEG  W28, W14, W16, GE
    MOVZ  W21, #0xb002, LSL #16
    ANDS  W24, W2, #0x1ff8
    UBFM  X24, X12, #0x31, #0x3e
    CLZ  V18.16B, V16.16B
    SUBS  W8, W15, W9, UXTH #3
    ANDS  X6, X2, X17, LSL #26
    ORR  W13, W28, #0x11111111
    ORR  X14, X27, #0xe000000000000
    ORR  W22, W17, #0xcccccccc
    ADD  X19, X7, #0x970
    BICS  W5, W20, W28, LSR #24
    LSLV  W21, W7, W26
    CLS  X17, X28
    CRC32CB  W29, W24, W8
    CLZ  V1.2S, V9.2S
    CSINC  X24, X16, X3, CC
    EOR  W10, W10, #0x380038
    LSLV  X18, X10, X13
    CRC32X  W3, W11, X18
    ADD  X9, X25, #0x5f6, LSL #12
    CRC32B  W13, W29, W18
    ORR  V17.16B, V15.16B, V16.16B
    MOVK  X10, #0xe477, LSL #32
    ANDS  W2, W23, #0xffffe000
    MOVN  X6, #0xf3f9, LSL #32
    UMULH  X5, X6, X24
    UMSUBL  X24, W8, W12, X26
    SMSUBL  X18, W17, W9, X15
    SUB  W26, W7, W11, LSR #0
    ADD  X17, X17, X24, ASR #6
    ADCS  X24, X24, X2
    SUBS  W21, W24, W17, SXTX #0
    ADD  X23, X26, #0xae5
    SBFM  W13, W7, #0x3, #0x4
    ADC  X3, X25, X23
    EOR  X15, X27, X17, ROR #55
    EOR  X7, X25, X28, ROR #19
    ANDS  W24, W29, W27, LSL #20
    ADD  W10, W24, W16, SXTX #2
    CRC32CW  W20, W6, W17
    CRC32CX  W9, W29, X3
    CRC32X  W14, W14, X6
    ANDS  W27, W16, W25, LSR #31
    AND  W20, W10, #0x7fffff00
    CRC32CB  W19, W29, W23
    MOVZ  W21, #0x9e72, LSL #16
    CRC32X  W18, W10, X5
    SMSUBL  X9, W17, W21, X27
    CRC32W  W2, W29, W5
    EXTR  W9, W17, W13, #0x5
    SUBS  W28, W20, W22, ASR #4
    ADC  W6, W21, W16
    ANDS  X15, X16, X18, LSR #59
    CLS  W17, W14
    CSINC  W2, W19, W28, VC
    SBFM  W13, W7, #0x9, #0x1c
    SMSUBL  X3, W28, W11, X2
    SUB  X12, X23, X24, LSL #9
    ADD  W13, W10, #0x92
    UMSUBL  X9, W8, W28, X13
    CLS  V30.8H, V22.8H
    SUBS  X10, X20, #0x9ea, LSL #12
    LSRV  W14, W25, W28
    EOR  X27, X15, #0xffe1ffe1ffe1ffe1
    ASRV  X12, X26, X10
    CSNEG  W7, W22, W7, GT
    SBFM  X2, X18, #0xb, #0x1c
    CSINV  X7, X12, X25, VC
    SMULH  X7, X15, X17
    BIC  W13, W24, W26, LSR #26
    ADCS  W13, W19, W9
    CSNEG  W23, W23, W26, GT
    BIC  V12.16B, V20.16B, V14.16B
    ANDS  X11, X13, #0xffff000000000fff
    EOR  X14, X21, X9, ROR #43
    ANDS  W10, W25, #0x3f800000
    CSEL  W19, W9, W18, HI
    BICS  W6, W23, W18, ASR #16
    ORR  W21, W29, W24, ROR #15
    SBFM  W28, W23, #0x13, #0x1b
    SUBS  X25, X25, #0x1
    B.NE  TaishanIntMduP01_label_110
    MOVZ  X26, #0x55fa, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X12, X26, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP01_TestFail
    MOVZ  X28, #0x15f0, LSL #0
    MOVK  X28, #0x335a, LSL #16
    MOVK  X28, #0xf13d, LSL #32
    MOVK  X28, #0x12, LSL #48
    SUB  X16, X28, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP01_TestFail
    MOVZ  X26, #0xbcd4, LSL #0
    MOVK  X26, #0xd07a, LSL #16
    SUB  X16, X26, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP01_TestFail
    MOVZ  X14, #0x8000, LSL #0
    MOVK  X14, #0xffbb, LSL #16
    SUB  X17, X14, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X5, #0x8a11, LSL #0
    MOVK  X5, #0x2c95, LSL #16
    SUB  X26, X5, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP01_TestFail
    MOVZ  X16, #0xf532, LSL #0
    MOVK  X16, #0xa5bf, LSL #16
    MOVK  X16, #0x85dc, LSL #32
    MOVK  X16, #0xf397, LSL #48
    SUB  X20, X16, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X11, X24, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X27, X25, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X14, #0xcb23, LSL #0
    MOVK  X14, #0xa066, LSL #16
    SUB  X18, X14, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X18, #0xcb23, LSL #0
    MOVK  X18, #0xa066, LSL #16
    SUB  X8, X18, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X12, #0xcb23, LSL #0
    MOVK  X12, #0xa066, LSL #16
    SUB  X14, X12, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X9, X12, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X22, X27, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP01_TestFail
    MOVZ  X23, #0x446c, LSL #0
    MOVK  X23, #0xe235, LSL #16
    SUB  X21, X23, X21
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X3, X25, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X6, #0x446c, LSL #0
    MOVK  X6, #0xe235, LSL #16
    SUB  X10, X6, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X21, X9, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP01_TestFail
    MOVZ  X8, #0x15f0, LSL #0
    MOVK  X8, #0x335a, LSL #16
    MOVK  X8, #0xf13d, LSL #32
    MOVK  X8, #0x12, LSL #48
    SUB  X6, X8, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    MOVZ  X5, #0xa, LSL #0
TaishanIntMduP01_label_138:
    BIC  V23.16B, V10.16B, V4.16B
    MOVZ  X23, #0xa8e3, LSL #32
    SBFM  X25, X27, #0x25, #0x28
    ADD  W10, W19, W14, SXTX #4
    ADDS  X11, X26, #0x36a, LSL #12
    ADCS  X7, X28, X20
    LSRV  W10, W24, W24
    CLS  W13, W22
    CSINC  X23, X21, X20, NV
    MOVN  W7, #0x61e5, LSL #0
    CSNEG  W20, W24, W29, LS
    ORR  X21, X11, X10, ROR #43
    CSEL  X7, X16, X21, CS
    CSINV  X29, X2, X18, AL
    EOR  X7, X5, #0xfffffff007ffffff
    CLS  W7, W5
    ADCS  W25, W9, W18
    MOVN  W7, #0xc979, LSL #16
    SUB  X6, X3, X21, ASR #52
    SMULH  X14, X24, X10
    ADDS  W10, W25, #0xcfa, LSL #12
    AND  X3, X23, X16, ASR #47
    SBFM  X2, X21, #0x20, #0x3a
    SBFM  W28, W27, #0x1e, #0x1b
    LSLV  X26, X3, X5
    ADDS  W8, W26, #0xcda, LSL #12
    SUB  W24, W12, W2, UXTX #1
    CRC32H  W11, W11, W13
    ADC  W10, W19, W29
    MOVZ  X15, #0x9c97, LSL #0
    ASRV  X10, X25, X22
    ADD  X26, X10, #0x42
    CRC32X  W2, W16, X7
    CLZ  X25, X22
    EOR  W22, W18, W9, LSR #3
    CSINV  X10, X21, X19, EQ
    AND  X24, X12, #0x3fff80003fff80
    ADC  X14, X9, X13
    ADDS  W26, W29, W12, UXTW #1
    SUBS  X15, X12, W26, UXTW #3
    ADC  W25, W8, W28
    ADDS  W28, W15, #0x95c, LSL #12
    SBFM  W14, W23, #0x17, #0x14
    UMADDL  X28, W9, W27, X5
    ADCS  X13, X11, X20
    BICS  W2, W14, W22, LSL #29
    UBFM  W12, W16, #0x4, #0x19
    BIC  X3, X21, X25, ROR #24
    CRC32B  W28, W22, W16
    LSRV  X21, X5, X10
    CLZ  X24, X7
    LSLV  X17, X28, X26
    SUB  X19, X23, W8, UXTH #3
    ORR  W18, W14, W18, LSL #12
    CSINC  W2, W22, W29, CC
    MADD  X13, X28, X8, X16
    CSNEG  W3, W5, W11, LE
    ADD  X7, X22, X13, LSR #43
    MADD  W16, W22, W25, W8
    EXTR  W10, W19, W13, #0x6
    CRC32H  W10, W18, W28
    CLZ  V24.2S, V13.2S
    ORR  X26, X5, #0x800000000fffffff
    CRC32CH  W8, W21, W29
    CRC32CW  W21, W18, W29
    UMSUBL  X21, W22, W5, X3
    UMULH  X3, X19, X6
    ADCS  W12, W22, W18
    SUB  W29, W25, W28, LSL #28
    SUBS  W22, W5, W24, UXTB #4
    SUB  W25, W22, W11, ASR #30
    BICS  W29, W13, W7, LSL #23
    CRC32CB  W10, W10, W13
    CSINV  W16, W6, W14, GE
    EXTR  X27, X22, X11, #0x11
    SUBS  X21, X22, X25, LSL #37
    UBFM  X21, X16, #0x2a, #0xb
    SMADDL  X7, W26, W8, X12
    CLS  W8, W13
    LSRV  X25, X2, X9
    ADCS  X18, X9, X15
    UMSUBL  X26, W3, W3, X14
    ANDS  X17, X23, X9, ASR #47
    UMULH  X13, X6, X20
    CSINC  W2, W13, W7, CC
    UMSUBL  X19, W23, W23, X9
    CLZ  W12, W17
    SUB  W21, W18, W19, LSL #9
    LSRV  X12, X15, X13
    CSINC  W29, W13, W11, LS
    BIC  V6.16B, V23.16B, V3.16B
    ORR  V14.8B, V29.8B, V17.8B
    ASRV  X11, X22, X18
    SUB  X14, X14, X12, SXTX #3
    CSEL  X16, X8, X23, HI
    ANDS  W21, W9, #0xfff9fff9
    ORR  W25, W28, W7, ASR #17
    SUBS  X12, X19, #0xda0
    AND  X26, X12, #0xdddddddddddddddd
    ORR  W24, W13, #0x1ff81ff8
    SUBS  W7, W28, #0x6e8
    BIC  W12, W23, W13, ROR #0
    EOR  W8, W28, W11, ROR #19
    SUB  W22, W10, W14, SXTB #2
    SUBS  W9, W27, W29, SXTH #2
    MOVK  X6, #0xdbe5, LSL #32
    ADDS  W21, W20, #0x390
    ADC  X18, X24, X14
    ASRV  W19, W13, W15
    SMULH  X14, X20, X29
    SUB  W3, W24, W21, UXTW #3
    CLZ  W22, W19
    CSEL  W6, W29, W11, PL
    ORR  V15.8B, V9.8B, V19.8B
    SMULH  X13, X25, X11
    SUB  W28, W22, W13, UXTX #4
    CRC32X  W27, W18, X20
    CLZ  W26, W14
    ADDS  X26, X6, #0x3b7
    ADC  W20, W16, W27
    CSINV  X23, X6, X19, CS
    SBFM  X9, X26, #0x32, #0x2e
    ADDS  X25, X29, W24, UXTH #3
    CRC32H  W25, W26, W20
    ADDS  X18, X26, W19, SXTH #0
    ORR  V28.8H, #0x9f
    ASRV  X19, X8, X16
    CLS  W29, W28
    ADC  X6, X16, X21
    ORN  X9, X26, X24, ROR #7
    MADD  X29, X18, X16, X7
    BIC  V10.8B, V7.8B, V23.8B
    UBFM  X24, X11, #0xa, #0x3a
    CLZ  W17, W15
    UMADDL  X26, W21, W17, X3
    CSNEG  W13, W16, W23, EQ
    LSRV  X20, X26, X19
    CLZ  W25, W22
    ADD  W24, W26, W25, UXTX #2
    MOVN  X16, #0x1083, LSL #0
    ORN  W14, W14, W2, ASR #1
    SUBS  W14, W16, #0x11f, LSL #12
    ADCS  X20, X22, X28
    ORR  V8.4S, #0x3f, LSL #8
    ADCS  X10, X22, X6
    ADCS  X17, X17, X5
    ADC  W2, W3, W18
    EOR  X16, X7, X19, ASR #59
    EOR  W3, W2, W18, ASR #4
    EOR  W6, W14, #0xffffff
    CRC32CB  W14, W2, W28
    ORR  W14, W10, #0xc1c1c1c1
    ADCS  W11, W14, W22
    CRC32CH  W20, W29, W15
    UBFM  W2, W5, #0xf, #0x14
    CSNEG  W3, W19, W20, LE
    ORR  W29, W20, W22, ASR #27
    AND  W18, W29, W11, LSL #2
    ADDS  W28, W18, W19, SXTH #1
    MADD  X3, X7, X16, X15
    CSEL  W7, W6, W3, LE
    ASRV  X17, X7, X29
    MOVK  W2, #0xb6b0, LSL #0
    UMADDL  X14, W20, W11, X26
    EOR  W17, W2, W26, LSL #17
    CRC32B  W21, W25, W17
    SUB  X6, X28, X25, LSL #44
    ADDS  W12, W25, W9, ASR #3
    ADD  X17, X12, #0x710
    ADDS  X21, X23, W25, SXTB #0
    ORR  V13.4H, #0xb2
    ADD  W18, W16, W25, LSR #27
    ADD  W7, W18, W16, UXTX #0
    CLZ  V13.8B, V18.8B
    MOVZ  W24, #0xc4cd, LSL #16
    LSLV  W9, W23, W3
    SUBS  W14, W9, W23, ASR #31
    ADDS  W15, W2, W14, UXTW #3
    ORN  X23, X26, X15, LSR #38
    LSRV  W14, W29, W29
    EOR  W18, W17, W14, LSR #26
    MOVK  W24, #0x164b, LSL #0
    ORR  X7, X29, #0x7fffffff7fffffff
    ANDS  W19, W11, #0xffe007ff
    MOVK  X17, #0x9d14, LSL #0
    MOVN  W7, #0x2f17, LSL #0
    CRC32B  W28, W25, W21
    MOVK  X23, #0x43c3, LSL #0
    CRC32H  W12, W24, W7
    ADDS  X15, X22, #0x172, LSL #12
    MOVN  W14, #0x411e, LSL #16
    CRC32CB  W21, W9, W12
    AND  X9, X24, #0x3c3c3c3c3c3c3c3c
    CRC32CX  W9, W26, X26
    CLS  W6, W29
    ADC  W25, W24, W25
    ADD  W3, W13, W3, SXTW #1
    ORR  V14.2S, #0x58, LSL #24
    BIC  X25, X14, X25, ASR #28
    AND  W15, W6, #0x88888888
    SUBS  X5, X5, #0x1
    B.NE  TaishanIntMduP01_label_138
    MOVZ  X20, #0xb6b0, LSL #0
    SUB  X15, X20, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP01_TestFail
    MOVZ  X19, #0xb1e7, LSL #0
    MOVK  X19, #0xd1da, LSL #16
    SUB  X17, X19, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x3, LSL #0
    SUB  X19, X12, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP01_TestFail
    MOVZ  X27, #0xd0e8, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X14, X27, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X12, #0xa510, LSL #0
    MOVK  X12, #0x7718, LSL #16
    SUB  X11, X12, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X9
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP01_TestFail
    MOVZ  X11, #0x45cb, LSL #0
    MOVK  X11, #0xbe82, LSL #16
    MOVK  X11, #0x1, LSL #32
    SUB  X25, X11, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X20, #0x45cb, LSL #0
    MOVK  X20, #0xbe82, LSL #16
    MOVK  X20, #0x1, LSL #32
    SUB  X17, X20, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X2, #0xa510, LSL #0
    MOVK  X2, #0x7718, LSL #16
    SUB  X3, X2, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x1, LSL #0
    SUB  X13, X9, X13
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X14
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X10, #0x9c07, LSL #0
    MOVK  X10, #0x88f7, LSL #16
    SUB  X23, X10, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X29, #0x45cb, LSL #0
    MOVK  X29, #0xbe82, LSL #16
    MOVK  X29, #0x1, LSL #32
    SUB  X25, X29, X20
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X21
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP01_TestFail
    MOVZ  X14, #0x20, LSL #0
    SUB  X8, X14, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X25
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP01_TestFail
    MOVZ  X7, #0xd0e8, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X14, X7, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X29, X12, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X17, X20, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x527a, LSL #0
    MOVK  X2, #0x4b4d, LSL #16
    MOVK  X2, #0x40c0, LSL #32
    MOVK  X2, #0xf3c4, LSL #48
    MOVZ  X3, #0xcb73, LSL #0
    MOVK  X3, #0xc8d2, LSL #16
    MOVK  X3, #0xf168, LSL #32
    MOVK  X3, #0x1db3, LSL #48
    MOVZ  X5, #0x6fd8, LSL #0
    MOVK  X5, #0x41fe, LSL #16
    MOVK  X5, #0xad56, LSL #32
    MOVK  X5, #0xafd, LSL #48
    MOVZ  X6, #0x8365, LSL #0
    MOVK  X6, #0x7c10, LSL #16
    MOVK  X6, #0x4216, LSL #32
    MOVK  X6, #0x7055, LSL #48
    MOVZ  X7, #0x58b0, LSL #0
    MOVK  X7, #0xdf3c, LSL #16
    MOVK  X7, #0xc797, LSL #32
    MOVK  X7, #0x7fbe, LSL #48
    MOVZ  X8, #0x10d8, LSL #0
    MOVK  X8, #0x64cd, LSL #16
    MOVK  X8, #0x9406, LSL #32
    MOVK  X8, #0xe465, LSL #48
    MOVZ  X9, #0x4b5f, LSL #0
    MOVK  X9, #0xf00f, LSL #16
    MOVK  X9, #0xd907, LSL #32
    MOVK  X9, #0xf73a, LSL #48
    MOVZ  X10, #0xe717, LSL #0
    MOVK  X10, #0xc3bd, LSL #16
    MOVK  X10, #0xb82, LSL #32
    MOVK  X10, #0x146, LSL #48
    MOVZ  X11, #0x88f9, LSL #0
    MOVK  X11, #0x8358, LSL #16
    MOVK  X11, #0xfe44, LSL #32
    MOVK  X11, #0xd438, LSL #48
    MOVZ  X12, #0x1f70, LSL #0
    MOVK  X12, #0x5db4, LSL #16
    MOVK  X12, #0x93b0, LSL #32
    MOVK  X12, #0x9d42, LSL #48
    MOVZ  X13, #0x8cde, LSL #0
    MOVK  X13, #0x89de, LSL #16
    MOVK  X13, #0xe668, LSL #32
    MOVK  X13, #0x92a, LSL #48
    MOVZ  X14, #0xa0be, LSL #0
    MOVK  X14, #0x8946, LSL #16
    MOVK  X14, #0xcb09, LSL #32
    MOVK  X14, #0x797b, LSL #48
    MOVZ  X15, #0xe21d, LSL #0
    MOVK  X15, #0x5a8b, LSL #16
    MOVK  X15, #0x2fe6, LSL #32
    MOVK  X15, #0xe894, LSL #48
    MOVZ  X16, #0xa934, LSL #0
    MOVK  X16, #0xaf5e, LSL #16
    MOVK  X16, #0xe67, LSL #32
    MOVK  X16, #0xb51f, LSL #48
    MOVZ  X17, #0xad55, LSL #0
    MOVK  X17, #0xb838, LSL #16
    MOVK  X17, #0x8940, LSL #32
    MOVK  X17, #0x63c0, LSL #48
    MOVZ  X18, #0x2224, LSL #0
    MOVK  X18, #0xe0f6, LSL #16
    MOVK  X18, #0xa367, LSL #32
    MOVK  X18, #0x1da9, LSL #48
    MOVZ  X19, #0x27d, LSL #0
    MOVK  X19, #0x7045, LSL #16
    MOVK  X19, #0xc979, LSL #32
    MOVK  X19, #0xaee3, LSL #48
    MOVZ  X20, #0xdc66, LSL #0
    MOVK  X20, #0x498d, LSL #16
    MOVK  X20, #0x1380, LSL #32
    MOVK  X20, #0x27fe, LSL #48
    MOVZ  X21, #0x79c5, LSL #0
    MOVK  X21, #0x6d21, LSL #16
    MOVK  X21, #0x488c, LSL #32
    MOVK  X21, #0x3d4f, LSL #48
    MOVZ  X22, #0xc3b3, LSL #0
    MOVK  X22, #0x68a8, LSL #16
    MOVK  X22, #0xed06, LSL #32
    MOVK  X22, #0x2a9c, LSL #48
    MOVZ  X23, #0xcb94, LSL #0
    MOVK  X23, #0x578f, LSL #16
    MOVK  X23, #0x4088, LSL #32
    MOVK  X23, #0xdd19, LSL #48
    MOVZ  X24, #0x27a7, LSL #0
    MOVK  X24, #0x8cb0, LSL #16
    MOVK  X24, #0xae17, LSL #32
    MOVK  X24, #0xf1ff, LSL #48
    MOVZ  X25, #0x791, LSL #0
    MOVK  X25, #0x731e, LSL #16
    MOVK  X25, #0x1bc4, LSL #32
    MOVK  X25, #0x694b, LSL #48
    MOVZ  X26, #0xc931, LSL #0
    MOVK  X26, #0x52d5, LSL #16
    MOVK  X26, #0x9c4a, LSL #32
    MOVK  X26, #0xba2c, LSL #48
    MOVZ  X27, #0x8bbf, LSL #0
    MOVK  X27, #0xb754, LSL #16
    MOVK  X27, #0x2aec, LSL #32
    MOVK  X27, #0x1e77, LSL #48
    MOVZ  X28, #0xc9ff, LSL #0
    MOVK  X28, #0xe5cc, LSL #16
    MOVK  X28, #0x9481, LSL #32
    MOVK  X28, #0xbfad, LSL #48
    MOVZ  X29, #0x6428, LSL #0
    MOVK  X29, #0x46d8, LSL #16
    MOVK  X29, #0xac3e, LSL #32
    MOVK  X29, #0xb1b2, LSL #48
    MOVZ  X12, #0x14, LSL #0
TaishanIntMduP01_label_166:
    UMADDL  X16, W12, W27, X11
    CRC32CB  W18, W12, W25
    ORR  V21.4H, #0x19
    ORR  V29.8H, #0x1e, LSL #8
    ORR  W3, W14, #0xf3f3f3f3
    SUBS  W8, W16, W23, UXTH #4
    ADDS  W26, W8, W16, LSR #19
    AND  W29, W24, #0xfe001fff
    ADCS  X28, X12, X11
    CRC32H  W16, W9, W18
    CSINC  X5, X16, X21, CS
    MOVZ  W5, #0xab8e, LSL #0
    CRC32H  W23, W17, W26
    CRC32CW  W10, W28, W3
    SUB  W8, W17, #0x740
    ADD  X2, X21, X22, LSL #27
    MOVN  X29, #0xb611, LSL #0
    UMADDL  X5, W9, W11, X5
    ADC  X3, X23, X5
    BIC  V26.8B, V0.8B, V0.8B
    AND  X3, X8, X12, LSR #6
    ORN  X6, X3, X10, ASR #30
    ORR  W10, W8, #0xf0000fff
    BIC  X28, X9, X8, ASR #26
    ADD  X18, X21, W2, SXTB #1
    ORR  V1.2S, #0x35, LSL #24
    CRC32X  W15, W21, X6
    ADC  W2, W11, W24
    AND  W10, W16, W11, LSL #3
    BIC  V31.8B, V19.8B, V4.8B
    CRC32X  W16, W13, X20
    BICS  X20, X26, X17, LSL #10
    EXTR  X29, X9, X12, #0x27
    SUBS  W13, W26, W5, SXTX #2
    ADDS  W16, W14, W26, UXTX #4
    SUB  X5, X14, X10, ASR #29
    AND  W20, W6, W17, ROR #1
    ASRV  X13, X20, X28
    SUBS  X24, X16, #0xcb8
    MADD  W15, W12, W13, W27
    CRC32CB  W24, W24, W27
    BICS  W14, W26, W23, ROR #7
    EXTR  W28, W21, W8, #0x1a
    CSNEG  W28, W26, W9, NV
    ADD  X3, X24, W24, SXTW #2
    ORR  X27, X6, #0x3ffc00003ffc
    BIC  V15.16B, V10.16B, V7.16B
    ASRV  W6, W15, W17
    SUB  X19, X7, X22, LSL #45
    EXTR  W19, W10, W27, #0x15
    ORR  V5.8B, V14.8B, V31.8B
    CRC32X  W25, W29, X13
    SUBS  W26, W26, #0xafe
    AND  X3, X13, #0x7fffc0007fffc
    BIC  X16, X19, X5, LSR #32
    UMSUBL  X11, W7, W16, X23
    SUBS  X2, X11, X15, LSR #28
    BIC  X22, X16, X25, ASR #40
    CRC32H  W6, W17, W6
    ADDS  X24, X26, #0xc9b
    ADC  X2, X2, X22
    LSRV  W11, W18, W28
    CRC32H  W17, W11, W13
    ANDS  W25, W3, #0xfffff9ff
    ADD  X16, X12, X27, ASR #34
    SUB  X19, X24, X27, LSR #14
    MOVK  W3, #0x14fc, LSL #16
    ADDS  W13, W2, W25, ASR #15
    EXTR  W7, W6, W28, #0x17
    CRC32W  W25, W10, W26
    CLZ  V16.2S, V24.2S
    AND  X19, X14, #0xc7ffffffffffffff
    LSRV  X16, X9, X5
    ADD  X19, X15, X19, SXTX #0
    ADD  W21, W9, #0x690
    SUB  X28, X16, #0x0
    ADDS  W18, W9, #0xecd, LSL #12
    ADD  W9, W19, W11, LSR #4
    SUBS  X2, X2, X7, LSR #28
    EON  X28, X19, X28, ROR #26
    EON  X7, X21, X14, LSL #61
    SUB  X2, X7, X26, LSR #58
    CLZ  X13, X29
    CRC32B  W3, W2, W23
    ADDS  W26, W28, W15, SXTH #2
    CLS  V23.4S, V4.4S
    MOVK  X27, #0x7e3d, LSL #48
    BIC  V12.8B, V28.8B, V3.8B
    SMSUBL  X6, W18, W25, X3
    ORR  W24, W6, #0xf07fffff
    SUBS  W23, W3, W9, UXTW #1
    CRC32W  W23, W3, W12
    SUB  W11, W23, #0x8e0
    SUBS  W25, W13, W22, LSL #17
    CLZ  X25, X26
    ORR  V20.4S, #0x9, LSL #16
    MOVN  X15, #0xd0e7, LSL #16
TaishanIntMduP01_label_89:
    ADDS  W22, W24, W3, LSL #28
    SUB  W26, W27, W3, UXTH #2
    ADC  W18, W12, W26
    LSLV  W27, W3, W11
    BICS  W10, W23, W24, LSL #2
    ADDS  X10, X27, X28, ASR #63
    ADDS  W27, W26, W25, ASR #1
    ADDS  X6, X23, #0x5d7, LSL #12
    CRC32CB  W21, W9, W2
    CSNEG  W15, W20, W20, NV
    CSNEG  W15, W8, W16, NE
    EOR  W21, W3, W23, LSL #15
    CLS  W28, W15
    MADD  W6, W5, W5, W16
    SUB  W27, W13, #0x0
    MOVK  W13, #0x2091, LSL #16
    ORR  W18, W21, W6, ASR #12
    ADDS  X18, X22, X15, ASR #35
    UBFM  W14, W16, #0x15, #0xd
    SUBS  X16, X9, #0x187
    CLZ  V31.4H, V2.4H
    EON  X5, X27, X8, ASR #32
    LSLV  W7, W25, W23
    CRC32B  W9, W9, W14
    MOVK  X16, #0x4d12, LSL #48
    CSINV  X23, X10, X21, EQ
    CSINV  W27, W29, W26, CC
    MOVN  X16, #0xcffd, LSL #16
    ADD  W17, W6, W3, LSL #17
    CSNEG  X2, X5, X22, LS
    CLS  V15.2S, V23.2S
    UMULH  X23, X8, X21
    MADD  X5, X9, X26, X13
    EXTR  X22, X7, X16, #0x2c
    SUBS  X9, X18, X22, SXTX #4
    ADC  W24, W21, W9
    SUBS  W21, W10, W8, LSL #3
    CRC32CB  W21, W15, W28
    LSLV  X5, X5, X23
    MOVK  X26, #0x2368, LSL #48
    MOVK  X26, #0xb02f, LSL #16
    SBFM  X3, X27, #0x23, #0x3a
    ADDS  X29, X16, #0x74b, LSL #12
    MOVK  X5, #0x3940, LSL #0
    MADD  W19, W24, W28, W3
    ANDS  X21, X13, #0x7fe000007fe0
    ADD  W6, W26, #0x911
    CRC32W  W6, W5, W6
    ADDS  W13, W15, W24, ASR #3
    UBFM  X29, X29, #0xd, #0x27
    CRC32CW  W13, W18, W19
    ADD  W22, W29, W27, SXTH #0
    ORR  X20, X6, X8, LSL #1
    SUB  W21, W23, W21, LSL #4
    ADC  W7, W29, W5
    CRC32CX  W21, W20, X8
    CLS  V17.4S, V14.4S
    AND  W22, W20, W27, ASR #19
    SMADDL  X23, W22, W8, X17
    SMULH  X7, X18, X27
    ADD  X7, X25, #0x360
    UBFM  W15, W24, #0xb, #0x1c
    CLS  V12.16B, V20.16B
    UMSUBL  X19, W13, W14, X12
    MOVK  W5, #0x85a8, LSL #16
    BIC  W8, W19, W15, LSL #13
    ANDS  W22, W16, #0xe00fe00f
    CSINV  W7, W6, W5, VS
    CRC32CW  W7, W17, W29
    CRC32X  W21, W23, X19
    ADDS  W18, W25, W8, UXTX #1
    ORR  X19, X8, X12, LSR #10
    ADDS  X19, X12, #0x5b, LSL #12
    ANDS  X3, X8, X18, ASR #63
    ORR  X19, X26, #0xfc3ffc3ffc3ffc3f
    SUBS  W27, W25, W28, LSR #28
    SUBS  X27, X24, X24, LSR #60
    CSNEG  X15, X26, X22, VC
    MOVZ  W21, #0xc9c7, LSL #16
    ADD  W8, W6, W2, UXTW #2
    MOVZ  W28, #0xf45d, LSL #0
    CLS  V29.16B, V30.16B
    UMULH  X23, X8, X29
    CRC32CW  W20, W28, W22
    EOR  W7, W26, #0xfc000fff
    BICS  X21, X21, X26, ROR #25
    UBFM  W5, W28, #0x12, #0x18
    SMULH  X7, X19, X23
    BIC  V11.8B, V1.8B, V2.8B
    MOVZ  W26, #0x2d05, LSL #16
    ORR  W17, W12, #0x1ffe0000
    SBFM  X13, X28, #0x3a, #0x36
    ORR  V1.4H, #0x7b, LSL #8
    ORR  X18, X6, #0xffffc000007fffff
    ANDS  W22, W27, #0x60606060
    EOR  W15, W14, #0xffe00000
    CLS  X22, X2
    EOR  W24, W13, W27, ROR #24
    LSLV  X10, X19, X9
    EXTR  W6, W6, W8, #0x6
    BIC  X2, X6, X2, LSR #31
    CLS  X15, X6
    ANDS  W6, W25, W5, ASR #1
    SUBS  X12, X12, #0x1
    B.NE  TaishanIntMduP01_label_166
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X23, #0x1d48, LSL #0
    MOVK  X23, #0x9f1d, LSL #16
    SUB  X27, X23, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X6, #0xf, LSL #0
    MOVK  X6, #0x3080, LSL #16
    MOVK  X6, #0xe000, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X20, X6, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP01_TestFail
    MOVZ  X28, #0x9590, LSL #0
    MOVK  X28, #0x10f7, LSL #16
    SUB  X24, X28, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X12
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X29, X28, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x1800, LSL #0
    SUB  X17, X12, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X3, #0x22, LSL #0
    SUB  X23, X3, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0x3002, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X8, X6, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X5, X16, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X18, #0x20, LSL #0
    SUB  X6, X18, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X26, X19, X26
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X27
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X13, #0x14, LSL #0
TaishanIntMduP01_label_194:
    ORR  X8, X23, #0xc000000000000
    LSLV  W20, W10, W23
    SMSUBL  X9, W2, W22, X6
    BICS  W10, W9, W9, ROR #10
    SUB  X2, X27, X25, LSR #56
    CSNEG  X15, X3, X17, LT
    LSLV  W29, W11, W24
    CSINC  X17, X11, X10, EQ
    CRC32CB  W25, W15, W11
    ANDS  X2, X24, #0x3fffffe00
    CLZ  W27, W5
    CLZ  V18.4H, V23.4H
    ADDS  X7, X14, X27, LSL #35
    EON  W28, W29, W26, ROR #17
    CLS  V3.8B, V0.8B
    ANDS  W6, W3, W2, LSL #12
    CSEL  W5, W25, W20, GT
    ADDS  W27, W13, W13, UXTH #0
    ORR  V6.4S, #0xac, LSL #16
    BIC  W24, W23, W13, ROR #16
    ADD  W10, W10, #0x640
    ADCS  X17, X7, X18
    ORR  V10.8B, V26.8B, V25.8B
    ORN  W23, W7, W12, ASR #9
    LSRV  W7, W23, W10
    CRC32B  W16, W19, W15
    CSINV  W21, W28, W20, AL
    CSINC  X8, X17, X29, PL
    ORN  X20, X8, X22, LSL #17
    UBFM  W10, W2, #0x1c, #0x16
    ADD  X18, X24, X28, ASR #36
    SUBS  W18, W11, W7, SXTW #3
    ADDS  W24, W5, W13, UXTH #2
    ADC  W8, W16, W16
    ADCS  X2, X27, X18
    AND  W19, W13, #0xffc003ff
    MOVN  X22, #0xf375, LSL #48
    MOVN  W15, #0xe0d1, LSL #16
    ORR  V14.4S, #0xf2, LSL #8
    ANDS  W20, W10, W19, LSL #27
    CLZ  V24.4H, V15.4H
    ADC  W22, W15, W7
    ADDS  W18, W24, W13, ASR #26
    ANDS  W8, W25, #0x1e000000
    UBFM  W8, W22, #0x7, #0x13
    ADD  W28, W18, W21, SXTB #3
    CRC32CX  W20, W18, X5
    ADDS  W20, W14, W7, ASR #2
    EOR  W8, W7, W5, LSR #5
    ADDS  X2, X6, #0x6d8, LSL #12
    CRC32CH  W21, W27, W5
    CRC32W  W26, W10, W7
    ORN  W25, W19, W20, LSR #9
    UBFM  X16, X8, #0x11, #0x23
    ANDS  X28, X6, #0x7fffffffff80000
    ADC  W2, W21, W2
    CSINC  W7, W8, W17, MI
    ORR  V20.4S, #0x75
    ADDS  W6, W3, W20, LSR #25
    BICS  X26, X10, X8, ROR #3
    EOR  X7, X10, X6, ASR #52
    ORR  X5, X18, #0xfffc00000000001f
    CSINC  X15, X7, X24, NE
    ADD  W9, W6, #0x2cc
    BICS  X12, X9, X14, ROR #52
    ADD  X5, X29, #0xcf4
    CRC32X  W14, W7, X25
    SMSUBL  X29, W7, W20, X21
    ORR  X14, X24, #0xfff83ffffff83fff
    BIC  W3, W27, W26, ROR #28
    ADDS  X18, X24, #0x4db
    MOVZ  X20, #0xff8, LSL #32
    ASRV  W29, W19, W16
    ADDS  X16, X29, X29, UXTX #4
    ANDS  W29, W2, #0x44444444
    EXTR  X16, X25, X14, #0x3b
    ORR  X20, X16, X25, ROR #59
    CRC32CX  W18, W21, X3
    ANDS  X6, X16, #0xfcfffcfffcfffcff
    SUBS  W16, W14, #0x4d1, LSL #12
    BIC  V18.8B, V15.8B, V30.8B
    LSRV  W6, W20, W5
    BIC  W6, W12, W21, ROR #19
    ADCS  W20, W9, W27
    CLS  V19.2S, V5.2S
    CLS  W14, W14
    EOR  X15, X6, #0x7fff00007fff
    ADD  W21, W12, W29, UXTB #2
    ASRV  X27, X9, X3
    BIC  W6, W11, W25, ROR #20
    AND  W25, W5, #0xfffc0fff
    ADDS  X11, X11, #0x845, LSL #12
    ORR  X12, X28, X14, LSL #2
    ADDS  W8, W9, W3, SXTB #1
    BICS  W10, W20, W3, LSR #8
    AND  X17, X16, #0xfc00ffffffffffff
    MOVK  X23, #0x487c, LSL #0
    ADD  W11, W9, W19, LSL #13
    ORR  X9, X3, X3, ASR #39
    ORR  W8, W14, #0x1ffe0000
    BIC  W24, W20, W21, ASR #3
    ORR  X12, X10, X12, LSR #6
    CLZ  V20.8B, V14.8B
    CLZ  V12.8H, V4.8H
    EOR  X28, X24, X8, ASR #49
    UMADDL  X8, W13, W28, X5
    CSEL  W10, W15, W9, MI
    EXTR  W14, W29, W8, #0x1a
    ORR  V4.2S, #0xc7
    ASRV  X3, X21, X5
    UMULH  X16, X25, X13
    EON  W14, W5, W17, ASR #25
    ORR  V29.4S, #0xbc, LSL #24
    BICS  X15, X13, X10, ROR #25
    SUBS  W11, W28, #0xb8d
    MOVN  W20, #0x123e, LSL #16
    LSLV  X15, X17, X10
    SUBS  W10, W16, W14, UXTX #0
    CSEL  W10, W16, W16, VC
    EON  X5, X12, X28, ASR #12
    CSINC  X9, X5, X11, NE
    ORN  X24, X24, X24, LSR #61
    CSNEG  W10, W29, W25, NV
    ORR  V12.16B, V17.16B, V13.16B
    ADD  X25, X25, #0x900
    SUB  X18, X14, W23, SXTH #3
    ADD  X25, X13, W9, UXTH #2
    MOVN  X16, #0xe626, LSL #16
    ORR  V13.4H, #0x1f
    SUBS  X15, X21, X28, LSL #26
    AND  X5, X13, X11, LSR #55
    LSLV  X22, X20, X22
    MOVN  W5, #0x2a38, LSL #0
    SUBS  X20, X11, #0x85a, LSL #12
    CLS  V31.4H, V5.4H
    ORR  W6, W8, W27, LSL #27
    ADDS  W29, W22, #0x740
    EXTR  X21, X26, X13, #0x35
    LSRV  W21, W23, W16
    CSEL  X2, X26, X28, VC
    SUB  W17, W15, W5, LSL #20
    CSINC  W21, W6, W21, NE
    SUB  X8, X9, X27, LSL #5
    CRC32CW  W7, W17, W27
    BICS  W15, W6, W11, LSR #1
    ADC  X8, X28, X23
    MOVK  X22, #0xcc30, LSL #32
    CSEL  W10, W2, W15, LT
    ORR  X16, X24, #0xfffffff000007fff
    ORR  V31.4S, #0x45, LSL #16
    ORR  V12.2S, #0x27
    CSINC  X16, X28, X24, MI
    MOVZ  W11, #0x9f9e, LSL #0
    ADCS  W9, W13, W9
    ADD  W11, W17, #0xa5e, LSL #12
    SUB  W19, W20, W16, ASR #23
    LSLV  X2, X6, X11
    UMULH  X6, X27, X8
    SUB  W7, W3, W12, LSL #13
    CRC32CW  W11, W5, W11
    ADD  X15, X10, X21, UXTX #4
    SBFM  W21, W9, #0xb, #0x5
    CRC32CX  W12, W15, X21
    SUBS  W16, W9, W24, LSL #14
    ADD  W6, W9, W20, SXTH #4
    CSEL  W7, W13, W13, GE
    ORR  V24.4S, #0xd3, LSL #8
    ANDS  W19, W25, #0x18000
    UBFM  X14, X7, #0x2a, #0x3e
    BIC  V29.16B, V21.16B, V13.16B
    CSINV  W26, W6, W19, VS
    SUBS  W14, W13, W11, LSL #28
    ORR  W24, W5, #0xff8
    ORR  X27, X24, X6, ASR #59
    SMSUBL  X8, W14, W13, X21
    SMSUBL  X26, W9, W2, X12
    SUBS  W24, W5, #0x4b8, LSL #12
    ASRV  X21, X18, X18
    ADD  W12, W9, W27, SXTW #3
    UMSUBL  X6, W10, W21, X18
    ORR  W5, W8, W15, ROR #2
    EON  W22, W16, W11, ROR #14
    ADCS  W12, W13, W26
    CRC32X  W21, W14, X17
    CRC32CW  W25, W2, W16
    ANDS  W25, W19, W2, LSL #26
    AND  W15, W24, #0xffe1ffff
    ADD  W24, W6, #0x2e2, LSL #12
    CLZ  W22, W9
    SUBS  X23, X7, #0x256, LSL #12
    ADDS  X10, X11, W12, SXTW #2
    UMULH  X5, X8, X11
    MOVZ  X11, #0x7028, LSL #48
    SUB  W18, W7, W6, SXTX #4
    SMULH  X15, X21, X7
    ADC  X15, X11, X26
    ADDS  X26, X8, X11, LSR #1
    AND  W18, W2, #0xfffe00ff
    ANDS  W22, W18, W5, LSL #22
    ADD  X15, X18, X9, LSL #46
    SUBS  X13, X13, #0x1
    B.NE  TaishanIntMduP01_label_194
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #16
    MOVK  X12, #0x200, LSL #32
    MOVK  X12, #0x300, LSL #48
    SUB  X11, X12, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X8, X28, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x1, LSL #0
    SUB  X22, X2, X7
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X8
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP01_TestFail
    MOVZ  X29, #0xfcf0, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X20, X29, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X19, #0x67e8, LSL #0
    MOVK  X19, #0x388e, LSL #16
    MOVK  X19, #0x1, LSL #32
    SUB  X28, X19, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x200, LSL #32
    MOVK  X15, #0x300, LSL #48
    SUB  X5, X15, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X26, X15, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x67e8, LSL #0
    MOVK  X2, #0x388e, LSL #16
    MOVK  X2, #0x1, LSL #32
    SUB  X3, X2, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X20
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X18, X9, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X10, #0xa001, LSL #0
    MOVK  X10, #0xffda, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X8, X10, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X20, #0xe918, LSL #0
    MOVK  X20, #0x2b, LSL #16
    SUB  X6, X20, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP01_TestFail
    MOVZ  X27, #0xdfff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X26, X27, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X29
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    MOVZ  X27, #0xa, LSL #0
TaishanIntMduP01_label_221:
    ANDS  W10, W25, W22, LSL #3
    EXTR  X26, X15, X26, #0x23
    BIC  X14, X5, X20, ASR #33
    SUBS  W28, W12, W20, UXTX #1
    LSLV  X11, X20, X29
    CSEL  X10, X26, X14, LE
    CRC32X  W21, W6, X15
    SUB  W15, W24, W23, LSL #7
    MOVN  X22, #0x8461, LSL #32
    UBFM  X2, X9, #0x24, #0xb
    EON  X22, X23, X15, ROR #53
    AND  X7, X8, X23, LSR #52
    AND  X28, X20, X10, LSL #60
    ASRV  X7, X15, X16
    ORN  X5, X9, X14, ASR #63
    ASRV  W3, W21, W22
    BIC  V6.16B, V20.16B, V12.16B
    SUBS  X18, X24, #0xe4c
    SMADDL  X25, W11, W22, X29
    ADCS  X8, X21, X21
    ADC  W16, W21, W12
    AND  W2, W25, #0xfffbffff
    BICS  X2, X21, X2, ROR #43
    CRC32CW  W28, W24, W5
    EOR  W18, W8, W25, LSL #5
    CLS  X5, X14
    CLS  W3, W7
    LSRV  W14, W26, W15
    AND  X26, X26, X10, ASR #25
    CSEL  W6, W2, W28, NE
    SUB  X7, X20, W23, SXTW #3
    ASRV  W11, W2, W29
    AND  W25, W18, W28
    BICS  X24, X24, X21, LSL #61
    EOR  W9, W24, W14, ROR #26
    ADDS  X11, X19, X24, LSL #58
    ORR  X16, X25, #0x7ffffffc00000
    ADDS  W24, W19, W7, UXTB #2
    ADD  X24, X22, X26, LSR #47
    SUB  W15, W2, #0x4b9
    BIC  W25, W12, W2, ROR #5
    ORR  V12.4H, #0x91
    CSINC  W5, W29, W16, CS
    AND  W23, W6, #0xff83ff83
    ORR  W12, W5, W14, LSR #28
    AND  X23, X5, X11, LSL #30
    EON  W18, W15, W6, LSL #10
    CLZ  X17, X10
    CLS  X24, X27
    ADD  W12, W29, W13, UXTX #2
    UBFM  X19, X28, #0x37, #0x17
    EON  W10, W15, W22, LSR #17
    EOR  W25, W12, W20, ASR #18
    SMADDL  X13, W3, W7, X9
    MOVN  X26, #0x50e8, LSL #48
    BICS  W29, W19, W23, ROR #13
    CLZ  X26, X29
    MOVZ  X22, #0x65ef, LSL #16
    CSEL  X3, X29, X26, LS
    MOVK  W12, #0x9259, LSL #16
    SBFM  X22, X3, #0x10, #0x3c
    BIC  W8, W24, W7, ROR #17
    UMADDL  X7, W13, W14, X17
    ADDS  X23, X17, W23, SXTH #3
    CLZ  V26.16B, V2.16B
    ADD  W19, W15, W15, LSL #4
    MOVK  W3, #0x683f, LSL #0
    ANDS  W12, W20, W12, LSR #29
    CRC32W  W17, W3, W23
    LSRV  W15, W22, W7
    UBFM  W13, W8, #0x0, #0xd
    MOVK  W3, #0xfddc, LSL #16
    LSLV  X16, X25, X19
    MOVN  W2, #0x2d64, LSL #0
    CSINV  W17, W2, W19, MI
    ORR  W17, W16, W13, LSR #28
    ADD  X8, X19, #0xd20
    CLZ  V1.16B, V4.16B
    MOVK  W18, #0xa7df, LSL #16
    EOR  W24, W8, #0x3ffc00
    BICS  W12, W10, W14, ASR #27
    EXTR  X2, X7, X12, #0x1b
    MOVZ  X17, #0x41ad, LSL #0
    ADD  X15, X22, W17, UXTW #2
    SMULH  X5, X16, X19
    CSNEG  W14, W17, W3, LS
    MOVK  X19, #0xb7cc, LSL #32
    ADCS  W18, W16, W23
    ASRV  X7, X19, X23
    ADDS  X22, X8, #0x6cf, LSL #12
    SMULH  X18, X25, X15
    ADCS  W18, W24, W12
    CRC32X  W28, W24, X26
    ASRV  X8, X27, X29
    SUB  X3, X25, #0x596, LSL #12
    UMADDL  X23, W2, W28, X19
    BIC  W5, W25, W15, ROR #21
    AND  W28, W15, #0xe000e
    UMSUBL  X18, W2, W27, X28
    CLZ  X13, X10
    CSINV  X7, X20, X13, NE
    CRC32B  W26, W8, W20
    ORN  X9, X26, X13, LSR #49
    UMADDL  X17, W25, W12, X10
    SUBS  W19, W6, #0x3c0
    EXTR  W24, W25, W21, #0xe
    ADD  W24, W19, W3, SXTX #1
    SUB  W18, W14, #0x660
    SUB  X29, X10, X8, ASR #51
    ANDS  W18, W15, W25, ROR #4
    UMADDL  X24, W25, W16, X27
    BICS  W25, W14, W17, LSL #15
    ADDS  W16, W17, W29, UXTX #0
    CLS  W29, W24
    UBFM  X28, X26, #0x1b, #0x39
    SUBS  X10, X12, X26, LSL #23
    LSRV  X25, X12, X12
    ORR  X12, X23, X16, ASR #42
    MOVK  X18, #0xaf14, LSL #0
    LSLV  X17, X25, X9
    ADCS  W7, W21, W9
    ORN  W14, W21, W20, ROR #3
    ORR  V17.4S, #0xa3, LSL #16
    CLZ  W26, W15
    MOVN  X29, #0xa04c, LSL #0
    ANDS  W14, W24, W17, ROR #28
    ADDS  X7, X14, X20, SXTX #1
    CLS  V22.16B, V10.16B
    LSLV  W23, W17, W22
    SBFM  W14, W9, #0xf, #0x8
    ANDS  X15, X29, #0xffe001ffffe001ff
    EXTR  X26, X13, X16, #0xc
    ORR  V6.4S, #0x1
    CRC32H  W16, W16, W9
    EON  W15, W3, W22, LSR #31
    SUB  X24, X14, X20, LSR #34
    ASRV  X7, X22, X6
    CLZ  X18, X20
    MOVZ  W23, #0xd1c0, LSL #16
    SUB  W22, W29, #0xdf0
    SUBS  W12, W15, W29, LSL #7
    CSNEG  W21, W15, W13, VC
    CSINV  X12, X24, X21, GT
    AND  W17, W23, #0x40404040
    ORR  W28, W18, W18, ASR #23
    MOVK  X15, #0x6c08, LSL #32
    SUB  X13, X24, X24, LSL #44
    BICS  W20, W7, W27, LSL #10
    EON  X20, X27, X7, ASR #41
    SBFM  W8, W15, #0x17, #0x12
    CLS  V14.8H, V20.8H
    BICS  W13, W12, W22, LSR #22
    BICS  W22, W26, W11, ASR #20
    SUB  X16, X6, X21, ASR #60
    CRC32B  W5, W27, W3
    CRC32CX  W26, W15, X10
    ADCS  W26, W10, W9
    MADD  X10, X22, X3, X8
    ASRV  W13, W26, W15
    CRC32CW  W5, W28, W23
    ADCS  X23, X11, X7
    SUB  X23, X22, W21, SXTH #2
    SBFM  W22, W14, #0x2, #0x1d
    ADDS  X13, X14, W13, SXTH #2
    CLZ  X9, X21
    CLS  V28.8B, V10.8B
    ADDS  X26, X13, #0x8e2, LSL #12
    CSINC  W3, W8, W6, NV
    ANDS  W11, W10, #0x1ffc0
    ANDS  W6, W23, W7, ASR #22
    EOR  W7, W10, #0x1ff8
    CSINV  W13, W13, W22, GT
    SUBS  X2, X20, W16, SXTH #0
    SUB  X11, X5, X9, ASR #62
    ADDS  X6, X24, #0x910
    ANDS  X14, X28, X29, LSR #16
    ADCS  W10, W21, W15
    SUBS  W21, W26, W10, UXTB #1
    ORR  V19.4S, #0x46, LSL #16
    CRC32CW  W24, W16, W24
    MOVK  W23, #0x9dec, LSL #0
    ORR  V24.2S, #0x69, LSL #24
    CSINC  X5, X6, X8, AL
    SBFM  W5, W9, #0xd, #0x1
    ASRV  W23, W14, W7
    SBFM  X21, X18, #0x1f, #0x1c
    ADDS  W21, W22, W10, LSL #15
    SUB  W3, W22, W23, SXTB #0
    BIC  V21.16B, V3.16B, V14.16B
    CSINV  W18, W16, W3, CC
    ADD  X11, X24, #0x5d5, LSL #12
    AND  W5, W16, #0xfffc01ff
    EOR  W24, W13, W7, ASR #31
    MOVZ  W24, #0xacf, LSL #0
    CLS  V7.8H, V24.8H
    ORR  X6, X18, X14, ASR #27
    ADD  X21, X9, X21, LSR #31
    BIC  X16, X10, X22, ROR #19
    BIC  X13, X21, X3, ASR #28
    ADD  X10, X3, X8, ASR #58
    SUBS  X27, X27, #0x1
    B.NE  TaishanIntMduP01_label_221
    MOVZ  X24, #0x260, LSL #0
    SUB  X5, X24, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x8000, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X17, X26, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X16, #0x7fff, LSL #0
    SUB  X24, X16, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP01_TestFail
    MOVZ  X13, #0x55e0, LSL #0
    MOVK  X13, #0xcdf6, LSL #16
    SUB  X27, X13, X7
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X11, #0x6600, LSL #0
    MOVK  X11, #0x180, LSL #16
    SUB  X13, X11, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X20, #0x29, LSL #0
    SUB  X2, X20, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X3, #0x8000, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X6, X3, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X27, #0x6600, LSL #0
    MOVK  X27, #0x180, LSL #16
    SUB  X13, X27, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X23, #0x1, LSL #0
    MOVK  X23, #0xbffe, LSL #16
    SUB  X13, X23, X12
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X26, #0xc033, LSL #0
    MOVK  X26, #0x58, LSL #16
    MOVK  X26, #0x6c08, LSL #32
    SUB  X9, X26, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X3, #0x7fff, LSL #0
    SUB  X10, X3, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X18, X9, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X9, #0xf9de, LSL #0
    MOVK  X9, #0x11a, LSL #16
    SUB  X27, X9, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x29, LSL #0
    SUB  X2, X21, X20
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X22, #0x29, LSL #0
    SUB  X3, X22, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X22, #0x29, LSL #0
    SUB  X20, X22, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X25, #0x1, LSL #0
    MOVK  X25, #0xbffe, LSL #16
    SUB  X12, X25, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X15, #0x1, LSL #0
    MOVK  X15, #0xbffe, LSL #16
    SUB  X25, X15, X25
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X10, #0xc033, LSL #0
    MOVK  X10, #0x58, LSL #16
    MOVK  X10, #0x6c08, LSL #32
    SUB  X13, X10, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X2, #0xcb52, LSL #0
    MOVK  X2, #0x799c, LSL #16
    MOVK  X2, #0x6ad, LSL #32
    MOVK  X2, #0x30f3, LSL #48
    MOVZ  X3, #0x89c7, LSL #0
    MOVK  X3, #0x26c9, LSL #16
    MOVK  X3, #0x9d2, LSL #32
    MOVK  X3, #0xa637, LSL #48
    MOVZ  X5, #0xbfc2, LSL #0
    MOVK  X5, #0xa6b9, LSL #16
    MOVK  X5, #0xd933, LSL #32
    MOVK  X5, #0xb88e, LSL #48
    MOVZ  X6, #0xe9b, LSL #0
    MOVK  X6, #0xd41d, LSL #16
    MOVK  X6, #0x2561, LSL #32
    MOVK  X6, #0x2b9c, LSL #48
    MOVZ  X7, #0xc4d, LSL #0
    MOVK  X7, #0x6f8c, LSL #16
    MOVK  X7, #0x8540, LSL #32
    MOVK  X7, #0x8e84, LSL #48
    MOVZ  X8, #0x53a6, LSL #0
    MOVK  X8, #0xffb9, LSL #16
    MOVK  X8, #0x9ca5, LSL #32
    MOVK  X8, #0xfa56, LSL #48
    MOVZ  X9, #0xc04a, LSL #0
    MOVK  X9, #0x63b6, LSL #16
    MOVK  X9, #0xc4e9, LSL #32
    MOVK  X9, #0x11a7, LSL #48
    MOVZ  X10, #0x1d11, LSL #0
    MOVK  X10, #0xc359, LSL #16
    MOVK  X10, #0xc3d6, LSL #32
    MOVK  X10, #0x11a3, LSL #48
    MOVZ  X11, #0x6174, LSL #0
    MOVK  X11, #0x6313, LSL #16
    MOVK  X11, #0xd01e, LSL #32
    MOVK  X11, #0x2a4f, LSL #48
    MOVZ  X12, #0xbfc9, LSL #0
    MOVK  X12, #0x8ffd, LSL #16
    MOVK  X12, #0x9c5, LSL #32
    MOVK  X12, #0x1774, LSL #48
    MOVZ  X13, #0xb3ed, LSL #0
    MOVK  X13, #0x5cb2, LSL #16
    MOVK  X13, #0x7fa9, LSL #32
    MOVK  X13, #0xdaab, LSL #48
    MOVZ  X14, #0x9004, LSL #0
    MOVK  X14, #0xc96c, LSL #16
    MOVK  X14, #0xfd7b, LSL #32
    MOVK  X14, #0x3c8f, LSL #48
    MOVZ  X15, #0x17af, LSL #0
    MOVK  X15, #0x37a0, LSL #16
    MOVK  X15, #0x1a2f, LSL #32
    MOVK  X15, #0xec79, LSL #48
    MOVZ  X16, #0x95bc, LSL #0
    MOVK  X16, #0x4909, LSL #16
    MOVK  X16, #0x6a6c, LSL #32
    MOVK  X16, #0xf0bb, LSL #48
    MOVZ  X17, #0xca7f, LSL #0
    MOVK  X17, #0x2115, LSL #16
    MOVK  X17, #0xe2d5, LSL #32
    MOVK  X17, #0xfa81, LSL #48
    MOVZ  X18, #0x5a49, LSL #0
    MOVK  X18, #0x8ebe, LSL #16
    MOVK  X18, #0xbadc, LSL #32
    MOVK  X18, #0xb79a, LSL #48
    MOVZ  X19, #0xed5e, LSL #0
    MOVK  X19, #0x28c8, LSL #16
    MOVK  X19, #0x2b45, LSL #32
    MOVK  X19, #0xd491, LSL #48
    MOVZ  X20, #0xf53c, LSL #0
    MOVK  X20, #0x4e49, LSL #16
    MOVK  X20, #0x3200, LSL #32
    MOVK  X20, #0xd085, LSL #48
    MOVZ  X21, #0x485d, LSL #0
    MOVK  X21, #0xa386, LSL #16
    MOVK  X21, #0x6b13, LSL #32
    MOVK  X21, #0xfab9, LSL #48
    MOVZ  X22, #0xa4c1, LSL #0
    MOVK  X22, #0xf8ef, LSL #16
    MOVK  X22, #0x8995, LSL #32
    MOVK  X22, #0xfa27, LSL #48
    MOVZ  X23, #0xdd63, LSL #0
    MOVK  X23, #0xcd20, LSL #16
    MOVK  X23, #0x8682, LSL #32
    MOVK  X23, #0x60ab, LSL #48
    MOVZ  X24, #0xebdd, LSL #0
    MOVK  X24, #0x57be, LSL #16
    MOVK  X24, #0x8d94, LSL #32
    MOVK  X24, #0x1752, LSL #48
    MOVZ  X25, #0x12ed, LSL #0
    MOVK  X25, #0x82ac, LSL #16
    MOVK  X25, #0x63a, LSL #32
    MOVK  X25, #0x7995, LSL #48
    MOVZ  X26, #0xa068, LSL #0
    MOVK  X26, #0xfbea, LSL #16
    MOVK  X26, #0xf6bb, LSL #32
    MOVK  X26, #0xbdc1, LSL #48
    MOVZ  X27, #0x41bf, LSL #0
    MOVK  X27, #0x2f50, LSL #16
    MOVK  X27, #0x4075, LSL #32
    MOVK  X27, #0xebe1, LSL #48
    MOVZ  X28, #0x2b95, LSL #0
    MOVK  X28, #0x9642, LSL #16
    MOVK  X28, #0x871c, LSL #32
    MOVK  X28, #0xb9c5, LSL #48
    MOVZ  X29, #0xaeb7, LSL #0
    MOVK  X29, #0xb6f7, LSL #16
    MOVK  X29, #0x6744, LSL #32
    MOVK  X29, #0x7a2e, LSL #48
    MOVZ  X23, #0x14, LSL #0
TaishanIntMduP01_label_248:
    SUBS  X19, X14, #0x1c9
    SMULH  X6, X5, X18
    CRC32X  W5, W24, X22
    ORN  W22, W10, W11, ROR #31
    MOVZ  X27, #0xc8c1, LSL #32
    SUB  W25, W28, #0xce1
    ANDS  X10, X6, #0x6666666666666666
    SUBS  W24, W10, W10, SXTW #1
    ADDS  X14, X13, #0x8d3, LSL #12
    UMULH  X17, X13, X11
    BIC  X10, X6, X28, ROR #61
    ORR  V6.4H, #0xf8
    CRC32H  W24, W22, W22
    CRC32W  W5, W18, W2
    ORR  V1.8B, V7.8B, V12.8B
    SUBS  X16, X18, #0xcb5, LSL #12
    ADDS  X24, X12, W6, SXTH #2
    ORR  V24.4H, #0x4f
    AND  X6, X29, X16, LSR #16
    ORR  X27, X2, #0xaaaaaaaaaaaaaaaa
    LSLV  X6, X17, X6
    SUB  W14, W24, W25, LSL #9
    LSRV  W10, W23, W7
    EOR  W9, W24, W10, LSR #2
    SUB  X26, X3, #0xf5, LSL #12
    ADDS  X21, X10, X19, SXTX #2
    CRC32W  W29, W24, W3
    EOR  X7, X21, X8, LSL #38
    ADCS  X27, X29, X19
    ADCS  X15, X27, X3
    AND  W17, W20, #0xff87ff87
    CLS  X21, X27
    ADD  W9, W3, #0x60a, LSL #12
    MOVZ  W19, #0x5cc6, LSL #0
    ADD  W22, W25, W2, SXTW #2
    ASRV  W10, W28, W3
    CSINC  W8, W12, W28, NV
    SUB  W14, W18, W14, ASR #0
    MOVN  W5, #0x2e27, LSL #16
    CSNEG  W11, W15, W14, VS
    MOVZ  X2, #0xe023, LSL #16
    SMSUBL  X27, W25, W26, X10
    ADDS  W3, W8, W10, ASR #14
    LSLV  X28, X5, X26
    ORR  W20, W8, W26, LSL #27
    EON  W12, W7, W17, LSL #28
    ANDS  W12, W19, #0xc7c7c7c7
    CSINC  W5, W27, W9, EQ
    ADDS  W7, W17, #0xb1a
    CRC32CW  W18, W27, W13
    CSINC  W10, W11, W16, LT
    CSINV  X16, X13, X22, GT
    BIC  W15, W29, W19, LSR #24
    CRC32CX  W9, W14, X8
    SUB  X15, X12, #0x1c0
    MADD  W29, W26, W20, W10
    CLZ  W17, W17
    ANDS  X9, X10, #0xf1fffffff1ffffff
    MOVN  X2, #0xec6e, LSL #32
    AND  W19, W2, W18, LSR #23
    SUBS  X28, X12, #0x399
    MOVN  W26, #0x88a2, LSL #0
    AND  X18, X22, X22, ASR #57
    AND  X24, X13, #0x1ffe
    UMULH  X11, X24, X19
    ADD  W3, W22, W2, UXTB #0
    SUB  X14, X9, #0x7aa, LSL #12
    ADCS  X29, X27, X6
    CRC32CB  W15, W15, W22
    SUB  X14, X7, X16, LSL #53
    EOR  X20, X19, #0xe7ffffffe7ffffff
    CLZ  X24, X25
    ADD  W19, W3, W3, SXTB #3
    ADD  W21, W10, W18, SXTX #0
    ADD  W10, W24, #0xf00
    CRC32H  W12, W2, W24
    MADD  X9, X18, X23, X20
    CLS  X15, X25
    ADCS  W19, W21, W2
    MOVZ  W18, #0xcdad, LSL #16
    ORN  W17, W19, W20, LSR #28
    CRC32X  W17, W19, X10
    ORR  X6, X5, #0x1fff80000000
    SUB  W3, W16, #0x191
    EXTR  X16, X6, X14, #0x39
    LSRV  W19, W22, W28
    SUBS  X26, X11, #0x0
    AND  W18, W5, #0xff7fff7f
    SUB  X28, X15, X11, LSR #11
    ORR  V20.4S, #0x2, LSL #16
    CSEL  W9, W11, W15, AL
    ADDS  X26, X6, X12, LSR #62
    SUBS  X5, X14, #0x6ae
    CRC32X  W19, W12, X21
    CRC32CH  W26, W9, W28
    ADCS  X5, X28, X21
    CSINV  X28, X9, X12, AL
    CSINC  X29, X22, X28, PL
    ANDS  X20, X9, X12, ASR #59
    CSINV  W19, W23, W18, CC
    EON  W20, W29, W10, ROR #11
    SUBS  W20, W5, #0xad2, LSL #12
    ADC  X12, X15, X20
    CSNEG  X5, X7, X10, CC
    CRC32X  W2, W24, X23
    CRC32B  W8, W20, W2
    EON  W7, W19, W28, ASR #7
    CLS  W22, W26
    ADD  W22, W25, W29, SXTH #0
    SUB  X11, X28, X11, LSL #58
    ANDS  X21, X20, #0xfffe0000000000ff
    ADC  X16, X20, X13
    ADD  W15, W28, #0x943, LSL #12
    UMULH  X14, X11, X3
    MOVN  X8, #0x5db1, LSL #32
    SUBS  X21, X26, #0xda0
    UMULH  X13, X18, X14
    ORR  V11.4S, #0xf6, LSL #16
    SUB  X25, X5, X20, LSL #57
    ADDS  X17, X24, #0x20c
    UMULH  X12, X25, X28
    CSNEG  W15, W10, W9, VC
    UMADDL  X11, W23, W8, X23
    ADC  X13, X13, X8
    SMSUBL  X5, W24, W16, X11
    ADD  W5, W15, #0xbba, LSL #12
    CLZ  W21, W6
    SUBS  W10, W22, #0x8b0
    ADDS  X26, X3, #0xece
    MOVK  W24, #0x2e50, LSL #16
    SMSUBL  X25, W3, W18, X26
    SUBS  W18, W6, #0xb05, LSL #12
    CSNEG  X17, X8, X24, VC
    ADC  X5, X14, X8
    SUBS  W21, W11, W22, SXTB #3
    AND  W6, W9, #0x3e
    CLS  V14.8H, V27.8H
    ADD  W6, W9, W6, ASR #8
    CRC32H  W15, W8, W29
    CSINV  W29, W6, W16, LE
    BICS  W8, W8, W14, LSL #22
    SMADDL  X15, W25, W25, X27
    ORR  W29, W22, W20, ROR #23
    UMSUBL  X8, W24, W20, X10
    CSINV  W13, W21, W3, NE
    ADDS  W22, W11, W16, LSR #29
    SBFM  W19, W12, #0x16, #0xa
    CRC32B  W19, W5, W16
    ADD  X9, X17, #0x893, LSL #12
    MOVK  W6, #0x63f0, LSL #16
    SMSUBL  X14, W8, W20, X6
    ORR  W15, W10, W8, ROR #4
    ADC  X5, X6, X13
    UMULH  X2, X10, X7
    SMSUBL  X27, W8, W29, X11
    SUB  W26, W24, W9, UXTX #0
    ASRV  X18, X24, X14
    ANDS  X29, X13, X9, ASR #0
    CSEL  X22, X28, X2, VC
    MOVZ  W25, #0x10d9, LSL #16
    ADC  W7, W11, W23
    CSINC  W21, W27, W21, GT
    ADDS  X8, X7, #0xa04
    EXTR  X18, X9, X23, #0x7
    CLZ  W24, W16
    SUBS  W14, W15, W27, SXTB #3
    ADDS  X20, X12, X21, ASR #46
    ADDS  W26, W20, W22, LSL #29
    CLS  X20, X18
    CSINC  W28, W11, W8, GT
    CSNEG  W28, W14, W29, EQ
    ADD  X5, X27, X12, LSR #5
    SUBS  W9, W23, #0x10
    ANDS  X25, X22, #0xfe01fe01fe01fe01
    ORN  X21, X9, X24, LSL #48
    ADD  X21, X7, X5, ASR #3
    SUB  W29, W16, W21, UXTB #4
    CRC32X  W2, W28, X29
    UMADDL  X18, W21, W8, X22
    CSINC  X27, X18, X23, LE
    ORR  V5.16B, V12.16B, V1.16B
    MOVN  W20, #0xc42b, LSL #16
    MOVZ  X15, #0x36ed, LSL #0
    EXTR  W3, W26, W20, #0x5
    BICS  W20, W2, W7, ASR #4
    ORR  W3, W13, W27, ROR #4
    ANDS  W12, W25, W6, LSL #28
    CLZ  W20, W18
    BICS  X14, X20, X7, LSR #1
    SBFM  X8, X26, #0x27, #0x3f
    CRC32X  W12, W20, X24
    ORR  V29.8B, V10.8B, V20.8B
    ADDS  X8, X9, X21, LSL #58
    CSINC  X25, X21, X14, AL
    SUB  W26, W28, W13, SXTW #3
    UMADDL  X28, W25, W26, X14
    ADD  W29, W10, #0x4e0, LSL #12
    CRC32CB  W7, W17, W17
    ADCS  X15, X2, X15
    CLS  W26, W2
    SUBS  X23, X23, #0x1
    B.NE  TaishanIntMduP01_label_248
    MOVZ  X10, #0x9541, LSL #0
    MOVK  X10, #0xe38, LSL #16
    SUB  X24, X10, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP01_TestFail
    MOVZ  X29, #0xeffb, LSL #0
    MOVK  X29, #0x2053, LSL #16
    SUB  X16, X29, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP01_TestFail
    MOVZ  X21, #0xf448, LSL #0
    MOVK  X21, #0x4348, LSL #16
    MOVK  X21, #0xc116, LSL #32
    MOVK  X21, #0xf685, LSL #48
    SUB  X29, X21, X5
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x63f0, LSL #16
    SUB  X25, X5, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xff, LSL #16
    SUB  X15, X5, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP01_TestFail
    MOVZ  X18, #0xfff1, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0x2800, LSL #48
    SUB  X2, X18, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X15, #0xfff1, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X25, X15, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x9541, LSL #0
    MOVK  X2, #0xe38, LSL #16
    SUB  X11, X2, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X22, #0xefa, LSL #0
    MOVK  X22, #0x844a, LSL #16
    SUB  X16, X22, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP01_TestFail
    MOVZ  X7, #0x330, LSL #0
    SUB  X19, X7, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x5, LSL #0
    SUB  X7, X2, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X27, #0xfff1, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X5, X27, X15
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xa24e, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X17, X29, X17
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X17, #0xfff1, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0x2800, LSL #48
    SUB  X7, X17, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X28, X17, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X20
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X7, #0xf448, LSL #0
    MOVK  X7, #0x4348, LSL #16
    MOVK  X7, #0xc116, LSL #32
    MOVK  X7, #0xf685, LSL #48
    SUB  X29, X7, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X13, #0xefa, LSL #0
    MOVK  X13, #0x844a, LSL #16
    SUB  X16, X13, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X10, X28, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X2, X15, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X26, X13, X26
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP01_TestFail
    MOVZ  X8, #0xfff1, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X28, X8, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X13, X19, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X14, #0x14, LSL #0
TaishanIntMduP01_label_274:
    CRC32B  W3, W6, W7
    CRC32CX  W12, W13, X13
    CSEL  X7, X25, X10, NE
    CSINV  X29, X24, X28, MI
    SUB  W24, W26, #0xcb3
    ASRV  X15, X12, X19
    CRC32W  W5, W5, W10
    ANDS  X12, X3, #0xe00000000000003f
    EXTR  X8, X7, X16, #0x34
    UBFM  X24, X16, #0x2d, #0x38
    CRC32B  W22, W18, W17
    ORR  W29, W6, W11, ASR #28
    ADD  W15, W14, W8, LSL #27
    ADDS  W22, W19, W3, SXTX #2
    SBFM  X19, X2, #0x27, #0x24
    CRC32CX  W25, W27, X16
    SUB  X27, X17, #0x8cd, LSL #12
    ASRV  W27, W26, W3
    ASRV  W24, W12, W26
    SUB  X19, X28, #0x0
    EOR  W24, W27, #0x8f8f8f8f
    CSINV  W23, W11, W12, VC
    SMULH  X5, X15, X7
    UMSUBL  X19, W14, W5, X2
    CRC32X  W10, W16, X25
    ADDS  W29, W17, #0xcce
    SUB  W3, W15, W6, UXTB #2
    SMSUBL  X9, W3, W23, X18
    MOVK  W13, #0x17e8, LSL #0
    CRC32CB  W25, W8, W25
    ORR  W3, W8, W15, ASR #9
    EXTR  X3, X19, X8, #0x2d
    ADD  W8, W10, W10, LSL #29
    ANDS  W22, W9, W21, ROR #4
    LSRV  W26, W2, W29
    SUBS  W16, W12, W21, UXTW #3
    ASRV  X10, X22, X22
    LSRV  X19, X12, X9
    AND  W29, W16, W27, ASR #14
    CRC32CW  W21, W17, W5
    ADDS  X5, X18, X26, UXTX #4
    AND  W21, W10, W16, ROR #6
    SUBS  X24, X22, X14, LSR #30
    SBFM  X19, X5, #0x1e, #0x23
    ASRV  X18, X14, X18
    ADD  W23, W12, W8, UXTX #2
    CLS  W8, W10
    CSEL  X7, X26, X21, VS
    ORR  W12, W29, W11, ROR #7
    EXTR  W6, W7, W9, #0x6
    MOVK  W29, #0x4ebb, LSL #0
    EXTR  W18, W27, W18, #0x0
    ORR  V30.2S, #0x3
    SMULH  X24, X23, X16
    BIC  V18.8B, V6.8B, V31.8B
    CLZ  W18, W8
    CLS  W23, W21
    SUBS  W23, W16, #0xa04, LSL #12
    EOR  W2, W15, #0xc7ffc7ff
    AND  X17, X21, X3, ROR #7
    MOVN  X2, #0x9067, LSL #16
    CSINV  X3, X24, X10, HI
    CRC32X  W16, W18, X20
    LSLV  X19, X25, X10
    EON  X17, X8, X21, LSR #12
    SUBS  X8, X6, #0x9a1
    SUB  X7, X14, X29, UXTX #0
    EOR  W6, W21, #0xe07fe07f
    CSEL  X12, X23, X27, VC
    ANDS  X9, X9, #0xe3e3e3e3e3e3e3e3
    CLZ  W29, W16
    CSNEG  X19, X26, X25, NE
    MOVN  W7, #0x9e53, LSL #16
    LSLV  X5, X2, X16
    CSEL  W11, W26, W21, LT
    AND  X21, X3, #0x1e1e1e1e1e1e1e1e
    CLS  V4.8B, V9.8B
    CRC32B  W15, W27, W24
    ADD  W10, W9, W3, UXTW #1
    MOVK  W17, #0xc145, LSL #0
    ADDS  W9, W3, W8, LSR #23
    CLZ  X23, X24
    ORR  X29, X5, X15, LSR #35
    SBFM  W7, W6, #0x1e, #0x7
    CLS  W7, W6
    MOVK  W22, #0xc5be, LSL #16
    CSEL  X25, X7, X5, NE
    SUBS  W20, W17, W22, SXTH #1
    SUBS  X10, X22, #0xdc8
    ADD  W2, W9, #0xfb0
    CLS  V31.4H, V8.4H
    CRC32X  W19, W15, X2
    ADCS  X17, X19, X24
    LSLV  W2, W10, W12
    CRC32H  W5, W26, W20
    SUBS  W8, W23, W6, LSL #6
    ADDS  W23, W7, W24, UXTH #3
    MADD  X26, X3, X29, X27
    ORR  V21.4H, #0xa8, LSL #8
    SUBS  X9, X22, #0x7c2
    ADDS  W22, W25, #0x78d
    UMADDL  X17, W26, W25, X20
    ANDS  X3, X25, X25, LSL #20
    UMSUBL  X2, W27, W13, X6
    CRC32CB  W26, W21, W21
    ORR  X27, X20, X8, LSR #11
    CLS  W8, W17
    ADD  W19, W29, W21, LSL #28
    CLZ  V12.4H, V14.4H
    SUBS  X22, X27, #0x7fc, LSL #12
    SUBS  W26, W6, W21, ASR #9
    CRC32B  W24, W12, W8
    UBFM  X2, X8, #0x27, #0x16
    ADD  X18, X5, X11, LSL #52
    EON  X20, X29, X9, LSL #4
    CLS  W10, W2
    CRC32CH  W17, W24, W16
    AND  X27, X3, #0x3f0000000000000
    ADDS  W21, W6, W11, UXTW #2
    SUB  W29, W26, W8, UXTB #2
    CSINC  X6, X22, X26, CC
    EOR  X9, X11, X3, LSL #5
    CRC32CW  W26, W17, W2
    ADD  X5, X27, X15, ASR #28
    ADDS  X26, X20, X11, LSR #40
    CSEL  X11, X17, X17, GE
    EOR  W2, W25, #0xfdffffff
    CRC32CB  W5, W18, W7
    ORR  W9, W12, W14, ASR #22
    SUBS  X10, X7, W20, SXTW #3
    ORR  X26, X17, #0x606060606060606
    MOVN  W11, #0x8ca3, LSL #0
    CSINC  W13, W17, W20, CS
    CSINC  W12, W11, W2, VS
    EOR  W9, W14, #0x3fffff0
    AND  X3, X26, #0x3e000
    MADD  X27, X23, X5, X13
    EON  W7, W6, W21, LSR #6
    CSEL  W21, W20, W22, NE
    ADCS  X28, X24, X18
    ORN  W7, W17, W13, ASR #27
    EOR  X11, X26, #0xffffffffe0000fff
    SUB  X7, X5, X6, UXTX #0
    EON  W24, W26, W25, LSR #25
    CRC32CW  W2, W16, W11
    BICS  X24, X25, X8, LSR #20
    EOR  W3, W24, W3, ASR #23
    ADD  W21, W20, W14, LSL #25
    SUB  W18, W23, W29, SXTX #3
    LSRV  W10, W5, W28
    CRC32B  W5, W19, W6
    CSINC  X18, X7, X9, LS
    CLS  X27, X7
    CSINC  X23, X12, X18, MI
    BICS  X17, X5, X18, LSL #13
    SUB  W13, W7, W16, ASR #8
    ADD  W24, W19, #0x58e, LSL #12
    ADD  W26, W22, W9, SXTX #0
    ADDS  X24, X28, X12, ASR #35
    CRC32CH  W26, W8, W3
    CSINC  W8, W2, W22, NV
    ADCS  W20, W7, W23
    UBFM  X27, X11, #0x9, #0x6
    EXTR  X3, X9, X8, #0x30
    ADDS  W8, W18, W20, LSL #5
    MOVK  X8, #0x4cc8, LSL #48
    ANDS  W17, W24, #0xfffff00f
    LSRV  X19, X25, X27
    ADC  X10, X5, X18
    SUB  X6, X27, X18, LSL #23
    BIC  W25, W21, W16, ASR #5
    CRC32X  W20, W19, X29
    ANDS  W24, W11, W17, ROR #6
    ORR  V2.8H, #0x80, LSL #8
    CSINC  W26, W28, W5, GT
    MOVK  W3, #0x9601, LSL #0
    CSINV  W20, W28, W18, VC
    AND  W6, W22, W25, LSL #17
    ORN  X26, X22, X2, ROR #26
    BICS  W16, W9, W10, ASR #20
    SUBS  X3, X20, X6, ASR #25
    ADC  W25, W21, W23
    CLS  W20, W20
    LSRV  W23, W28, W16
    ADCS  W24, W6, W29
    CSINV  W19, W29, W17, MI
    EOR  W7, W13, #0xf000f000
    CSINC  W21, W10, W28, LE
    ORN  X6, X20, X7, ROR #21
    MOVZ  X7, #0x43ee, LSL #48
    SUBS  W18, W15, W24, LSR #27
    EON  W8, W25, W10, LSL #5
    MOVN  W22, #0xc305, LSL #16
    ADDS  X5, X23, #0xf75, LSL #12
    ORR  W5, W8, #0xfffff800
    SBFM  X25, X27, #0x17, #0x1e
    ORR  W26, W14, #0x1ff800
    BIC  W27, W20, W23
    AND  X20, X8, #0xff800000000003ff
    CSEL  W19, W15, W29, LS
    SUBS  X14, X14, #0x1
    B.NE  TaishanIntMduP01_label_274
    MOVZ  X10, #0x7229, LSL #0
    MOVK  X10, #0xf14f, LSL #16
    SUB  X18, X10, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x3f7, LSL #0
    MOVK  X26, #0x6ff4, LSL #16
    SUB  X20, X26, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X19, #0xfae0, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X17, X19, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X2, #0xf92e, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0x9fff, LSL #32
    MOVK  X2, #0x2a5d, LSL #48
    SUB  X20, X2, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x43ee, LSL #48
    SUB  X5, X2, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X8, #0xe2e0, LSL #0
    MOVK  X8, #0x6b84, LSL #16
    SUB  X3, X8, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X7, #0xfff1, LSL #0
    MOVK  X7, #0x3ff, LSL #16
    SUB  X9, X7, X9
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X28, #0x7229, LSL #0
    MOVK  X28, #0xf14f, LSL #16
    SUB  X6, X28, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X3, #0x6921, LSL #0
    MOVK  X3, #0xb636, LSL #16
    MOVK  X3, #0xf9f9, LSL #32
    MOVK  X3, #0xf9f9, LSL #48
    SUB  X29, X3, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X21, #0xfffe, LSL #0
    MOVK  X21, #0xfdff, LSL #16
    SUB  X14, X21, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X24, #0x444c, LSL #0
    MOVK  X24, #0x2a3a, LSL #16
    SUB  X26, X24, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X10, X24, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X14, X12, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X23, #0x111, LSL #0
    SUB  X9, X23, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X16, #0xfae0, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X6, X16, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X3, #0xfffe, LSL #0
    MOVK  X3, #0xfdff, LSL #16
    SUB  X11, X3, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0x3cfa, LSL #16
    SUB  X13, X15, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x111, LSL #0
    SUB  X8, X2, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X15, X29, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X29
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    MOVZ  X17, #0xa, LSL #0
TaishanIntMduP01_label_298:
    ADCS  W23, W20, W25
    ASRV  X9, X9, X8
    MOVZ  W16, #0x6277, LSL #0
    EON  W3, W19, W6, ASR #29
    ORR  X24, X5, X7, ROR #0
    ADCS  X18, X27, X14
    EXTR  W5, W13, W13, #0x14
    MOVK  X11, #0xd111, LSL #32
    AND  W16, W2, #0xf000f0
    ADD  W3, W28, W29, SXTH #0
    SUB  X20, X3, #0x1d8
    ANDS  X11, X20, X20, LSL #7
    ADDS  X11, X13, X17
    EOR  W9, W22, W28, LSR #11
    AND  X27, X21, #0x78007800780078
    SUB  W16, W5, W5, UXTW #3
    SUB  W2, W11, W28, SXTB #4
    BIC  W8, W16, W10, LSR #25
    EOR  X22, X19, X24, LSR #34
    MADD  X10, X6, X26, X10
    SUBS  X28, X15, X11, LSR #40
    SUBS  W20, W21, W5, LSR #22
    SUBS  X3, X18, X20, ASR #52
    MOVK  W14, #0xd06b, LSL #0
    AND  W9, W6, W13, ROR #27
    EOR  X29, X22, X6, LSL #62
    SMULH  X5, X16, X14
    SUBS  X8, X22, W8, SXTB #2
    UMSUBL  X7, W19, W13, X17
    CRC32B  W10, W19, W29
    CLZ  V6.4S, V21.4S
    SMULH  X6, X5, X3
    ADC  X18, X7, X21
    ORR  X10, X6, #0x3f0000003f00000
    BIC  X27, X27, X10, ASR #18
    ORR  V27.16B, V5.16B, V19.16B
    EXTR  X12, X7, X28, #0x34
    ADDS  X7, X27, X9, ASR #53
    CRC32CW  W3, W15, W10
    MOVK  X21, #0x38, LSL #48
    SMADDL  X21, W22, W7, X16
    SUBS  W14, W6, W13, SXTW #3
    CSEL  X6, X13, X3, NE
    CSNEG  W18, W14, W21, CC
    ADC  W14, W23, W6
    EOR  W11, W29, W22, ASR #4
    CRC32CB  W22, W25, W9
    SUBS  W8, W9, W2, LSR #25
    ADDS  W24, W8, #0x983
    ORR  X26, X24, #0xfffffff0007fffff
    CRC32CB  W23, W7, W13
    CLS  W9, W22
    EON  W24, W12, W17, LSL #28
    SMSUBL  X19, W25, W15, X26
    MOVK  X13, #0xeec1, LSL #48
    SMADDL  X19, W13, W20, X11
    SUBS  X3, X23, #0xb38
    CRC32CW  W11, W9, W24
    ADDS  W12, W26, #0x319, LSL #12
    SMULH  X20, X12, X20
    UMULH  X14, X20, X11
    AND  W26, W19, W19, LSL #20
    BIC  V31.8B, V21.8B, V22.8B
    ADDS  X15, X11, W25, SXTH #4
    ADDS  W9, W17, #0x2cf, LSL #12
    EOR  W25, W16, W11, ASR #11
    ANDS  X9, X11, #0x8f8f8f8f8f8f8f8f
    UBFM  X22, X21, #0x9, #0x3
    BIC  X16, X12, X3, LSR #61
    SUB  X7, X14, X24, LSR #2
    CSEL  W8, W15, W17, NV
    CRC32X  W25, W28, X29
    MADD  W12, W2, W7, W3
    CLZ  W16, W26
    ADDS  W16, W6, #0xf01, LSL #12
    SUB  W22, W5, #0x4cd
    ORR  V16.16B, V21.16B, V18.16B
    ORN  X7, X9, X2, LSL #48
    CLS  V21.4S, V17.4S
    CRC32X  W15, W10, X29
    BICS  W22, W2, W6, LSL #19
    ASRV  W19, W8, W23
    BICS  W3, W2, W27, LSL #22
    LSLV  X20, X26, X7
    MOVN  W9, #0xf06, LSL #16
    LSLV  X2, X28, X21
    CSINC  W11, W10, W18, NE
    CLZ  X25, X9
    SUB  X2, X29, X6, SXTX #1
    LSLV  X11, X9, X2
    ADDS  W24, W25, W9, SXTW #3
    CSINV  X9, X11, X9, GT
    ADCS  W16, W16, W9
    ADCS  W25, W2, W6
    SMSUBL  X11, W20, W18, X29
    SUB  X24, X27, X28, ASR #24
    CRC32CB  W11, W13, W28
    SMADDL  X3, W11, W22, X13
    BIC  X2, X13, X3, ROR #31
    SMULH  X14, X28, X3
    SUB  W29, W24, #0x100
    UBFM  X27, X11, #0x13, #0x10
    MOVN  X13, #0xfd01, LSL #0
    ORR  X23, X11, #0xffff3fffffff3fff
    BIC  X6, X20, X23, LSL #19
    SBFM  X7, X10, #0xd, #0x1c
    ADCS  W19, W29, W2
    ADC  W9, W18, W15
    SUBS  X7, X28, #0x546, LSL #12
    ORR  V12.16B, V5.16B, V21.16B
    ADDS  X19, X28, #0xa0
    CLS  W7, W14
    CRC32X  W24, W18, X25
    SUBS  W20, W16, #0xf64
    SBFM  W6, W10, #0x18, #0x17
    ORR  W12, W5, W26, LSL #15
    SBFM  W25, W15, #0x1, #0xb
    SUB  W5, W7, #0xe30
    ADD  X19, X19, X29, ASR #38
    EXTR  X29, X23, X9, #0x30
    ORR  W23, W11, #0xfff3fff3
    EOR  X25, X17, #0x81ffffff81ffffff
    CRC32X  W19, W13, X23
    ADD  W27, W16, W21, ASR #16
    SUB  X16, X24, X2, LSR #7
    UBFM  X20, X6, #0x37, #0x26
    ADDS  W13, W10, W29, LSL #21
    CLS  W13, W24
    BIC  V21.16B, V27.16B, V2.16B
    SUB  X21, X25, X5, LSR #57
    ADC  W28, W2, W16
    LSLV  X11, X19, X9
    CSEL  X27, X5, X9, GT
    SMADDL  X6, W16, W13, X18
    ADD  W20, W25, W17, LSL #17
    SUBS  W27, W23, W21, LSR #27
    LSLV  W28, W5, W28
    BIC  V11.8B, V14.8B, V28.8B
    CRC32B  W2, W14, W28
    ORR  V15.4H, #0x20
    CLS  V11.8H, V16.8H
    CRC32H  W29, W9, W29
    UMULH  X29, X19, X23
    EXTR  W8, W13, W11, #0x2
    CRC32W  W19, W25, W18
    SUBS  W12, W26, W13, LSL #17
    CLZ  W20, W19
    SUB  W20, W16, #0x82a
    ADD  X15, X5, X2, ASR #15
    UBFM  X9, X17, #0x3c, #0x15
    SUB  X24, X6, W29, UXTH #2
    MOVZ  X29, #0x80b4, LSL #16
    ORR  W11, W9, #0xc000c00
    ORR  V15.16B, V9.16B, V16.16B
    ADDS  X27, X7, X8, ASR #29
    ADDS  X15, X9, X5, LSL #6
    BICS  X25, X28, X27, LSL #36
    CLZ  V22.4H, V23.4H
    MOVK  W12, #0xd435, LSL #0
    CSEL  X2, X23, X23, NE
    CLZ  V3.2S, V12.2S
    CLZ  V29.8H, V24.8H
    CRC32CH  W2, W29, W22
    EOR  X24, X7, #0xfffc0000
    ADDS  X22, X11, #0x980
    ADD  W7, W19, W25, ASR #6
    ORN  X6, X9, X27, ROR #40
    SUB  X6, X27, W18, UXTB #2
    ANDS  W24, W14, W9, LSR #16
    CSNEG  W15, W7, W29, AL
    ADC  X12, X8, X12
    BICS  X25, X3, X16, ASR #50
    UMSUBL  X27, W23, W24, X8
    EOR  W16, W16, #0x3ffff8
    ORR  X18, X5, #0xffffc1ffffffc1ff
    ADD  W16, W6, W13, ASR #3
    ASRV  X12, X20, X21
    MOVZ  W16, #0x9f4d, LSL #0
    MADD  X2, X28, X21, X5
    CSNEG  W6, W20, W24, NE
    SUB  X12, X18, W15, SXTH #0
    ANDS  X24, X24, #0xefefefefefefefef
    ASRV  W3, W28, W22
    LSLV  X27, X2, X2
    ANDS  X20, X11, #0x801fffffffffffff
    CSEL  X14, X6, X27, NE
    SUBS  X3, X23, X22, LSR #18
    CRC32X  W3, W20, X5
    ORR  W10, W14, #0xe003ffff
    ANDS  X14, X16, X25, LSL #7
    CSNEG  X24, X28, X11, GT
    ORR  X21, X28, X14, LSL #28
    ANDS  X11, X14, X6, LSL #33
    ADDS  X24, X10, #0xea4
    EXTR  W21, W16, W3, #0x2
    EON  W20, W15, W2, ROR #5
    ADCS  W27, W16, W11
    BIC  X23, X19, X22, LSR #0
    MOVZ  X12, #0x604b, LSL #0
    ADDS  W27, W3, W17, UXTH #0
    SUBS  X17, X17, #0x1
    B.NE  TaishanIntMduP01_label_298
    MOVZ  X25, #0xf1d3, LSL #0
    MOVK  X25, #0x7167, LSL #16
    MOVK  X25, #0x97ff, LSL #32
    MOVK  X25, #0x9de8, LSL #48
    SUB  X29, X25, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X25, #0x9a8c, LSL #0
    MOVK  X25, #0x1ad0, LSL #16
    SUB  X26, X25, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP01_TestFail
    MOVZ  X15, #0xf1d3, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X9, X15, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X13, #0x9668, LSL #0
    MOVK  X13, #0x5750, LSL #16
    SUB  X8, X13, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X7, #0x862, LSL #0
    MOVK  X7, #0x46f6, LSL #16
    SUB  X3, X7, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x604b, LSL #0
    SUB  X29, X2, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x200, LSL #0
    SUB  X21, X9, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP01_TestFail
    MOVZ  X2, #0xf1d3, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X22, X2, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X24, #0xf1ff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xc1ff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X2, X24, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X18, #0xd862, LSL #0
    MOVK  X18, #0x47d8, LSL #16
    SUB  X22, X18, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP01_TestFail
    MOVZ  X10, #0xc813, LSL #0
    MOVK  X10, #0x2282, LSL #16
    SUB  X11, X10, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X23
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X17, #0xf1ff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xc1ff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X22, X17, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP01_TestFail
    MOVZ  X2, #0xfeaa, LSL #0
    MOVK  X2, #0xd8d3, LSL #16
    MOVK  X2, #0x6d9f, LSL #32
    MOVK  X2, #0xdb37, LSL #48
    MOVZ  X3, #0xa685, LSL #0
    MOVK  X3, #0x9e64, LSL #16
    MOVK  X3, #0xae5a, LSL #32
    MOVK  X3, #0x7ac5, LSL #48
    MOVZ  X5, #0x6cd7, LSL #0
    MOVK  X5, #0x3a30, LSL #16
    MOVK  X5, #0x4b0d, LSL #32
    MOVK  X5, #0xcd75, LSL #48
    MOVZ  X6, #0x3059, LSL #0
    MOVK  X6, #0x1bb1, LSL #16
    MOVK  X6, #0x7672, LSL #32
    MOVK  X6, #0x358d, LSL #48
    MOVZ  X7, #0xb233, LSL #0
    MOVK  X7, #0xab0c, LSL #16
    MOVK  X7, #0xdbbb, LSL #32
    MOVK  X7, #0xeb90, LSL #48
    MOVZ  X8, #0x579b, LSL #0
    MOVK  X8, #0x8bb2, LSL #16
    MOVK  X8, #0x6889, LSL #32
    MOVK  X8, #0x1aa1, LSL #48
    MOVZ  X9, #0xb6c, LSL #0
    MOVK  X9, #0xce8, LSL #16
    MOVK  X9, #0xf3ec, LSL #32
    MOVK  X9, #0xcf3c, LSL #48
    MOVZ  X10, #0xec61, LSL #0
    MOVK  X10, #0xe55b, LSL #16
    MOVK  X10, #0x76f9, LSL #32
    MOVK  X10, #0xb48a, LSL #48
    MOVZ  X11, #0xc6d7, LSL #0
    MOVK  X11, #0xd44, LSL #16
    MOVK  X11, #0x1acf, LSL #32
    MOVK  X11, #0xef46, LSL #48
    MOVZ  X12, #0x5686, LSL #0
    MOVK  X12, #0x9983, LSL #16
    MOVK  X12, #0x84c2, LSL #32
    MOVK  X12, #0x64ad, LSL #48
    MOVZ  X13, #0x6cef, LSL #0
    MOVK  X13, #0x5334, LSL #16
    MOVK  X13, #0xf21e, LSL #32
    MOVK  X13, #0x262d, LSL #48
    MOVZ  X14, #0xd573, LSL #0
    MOVK  X14, #0x93fa, LSL #16
    MOVK  X14, #0xdef3, LSL #32
    MOVK  X14, #0x1670, LSL #48
    MOVZ  X15, #0xd58f, LSL #0
    MOVK  X15, #0xf16a, LSL #16
    MOVK  X15, #0x5b9e, LSL #32
    MOVK  X15, #0x6428, LSL #48
    MOVZ  X16, #0xb322, LSL #0
    MOVK  X16, #0xb31a, LSL #16
    MOVK  X16, #0x1229, LSL #32
    MOVK  X16, #0x70ca, LSL #48
    MOVZ  X17, #0x65b9, LSL #0
    MOVK  X17, #0xdfff, LSL #16
    MOVK  X17, #0xa369, LSL #32
    MOVK  X17, #0xd342, LSL #48
    MOVZ  X18, #0xf4d2, LSL #0
    MOVK  X18, #0x7fbc, LSL #16
    MOVK  X18, #0xf974, LSL #32
    MOVK  X18, #0x358d, LSL #48
    MOVZ  X19, #0x2065, LSL #0
    MOVK  X19, #0xd525, LSL #16
    MOVK  X19, #0xeec, LSL #32
    MOVK  X19, #0x2651, LSL #48
    MOVZ  X20, #0x226b, LSL #0
    MOVK  X20, #0xffc3, LSL #16
    MOVK  X20, #0xee1, LSL #32
    MOVK  X20, #0x503a, LSL #48
    MOVZ  X21, #0xfad1, LSL #0
    MOVK  X21, #0x3fc8, LSL #16
    MOVK  X21, #0xe3c7, LSL #32
    MOVK  X21, #0xf2bb, LSL #48
    MOVZ  X22, #0x5691, LSL #0
    MOVK  X22, #0xa57c, LSL #16
    MOVK  X22, #0xc9c1, LSL #32
    MOVK  X22, #0x7408, LSL #48
    MOVZ  X23, #0x2ba, LSL #0
    MOVK  X23, #0x5964, LSL #16
    MOVK  X23, #0x12d7, LSL #32
    MOVK  X23, #0xd1f2, LSL #48
    MOVZ  X24, #0x3818, LSL #0
    MOVK  X24, #0xb9ab, LSL #16
    MOVK  X24, #0x7be, LSL #32
    MOVK  X24, #0x2f6c, LSL #48
    MOVZ  X25, #0x230, LSL #0
    MOVK  X25, #0x4d38, LSL #16
    MOVK  X25, #0x32e8, LSL #32
    MOVK  X25, #0x31d8, LSL #48
    MOVZ  X26, #0xd5f8, LSL #0
    MOVK  X26, #0x9f9, LSL #16
    MOVK  X26, #0xf6cc, LSL #32
    MOVK  X26, #0xc844, LSL #48
    MOVZ  X27, #0x665, LSL #0
    MOVK  X27, #0xe3e2, LSL #16
    MOVK  X27, #0xf50c, LSL #32
    MOVK  X27, #0x7da8, LSL #48
    MOVZ  X28, #0x7726, LSL #0
    MOVK  X28, #0x1800, LSL #16
    MOVK  X28, #0x3cb2, LSL #32
    MOVK  X28, #0x61b4, LSL #48
    MOVZ  X29, #0x2c89, LSL #0
    MOVK  X29, #0xd7e0, LSL #16
    MOVK  X29, #0xec13, LSL #32
    MOVK  X29, #0xe4dd, LSL #48
    MOVZ  X3, #0x14, LSL #0
TaishanIntMduP01_label_323:
    AND  X14, X26, X25, LSL #6
    EON  X25, X15, X20, LSL #9
    MADD  X8, X6, X27, X29
    AND  X14, X10, #0x7f
    ADC  X21, X8, X9
    UMADDL  X15, W25, W5, X2
    CSINV  X16, X24, X6, HI
    CSINV  W28, W28, W11, NE
    ADD  W25, W11, #0x36f, LSL #12
    EOR  W20, W26, #0x1e000000
    ADDS  X18, X28, #0x8e0
    SUBS  X24, X14, X25, LSR #13
    ADDS  W2, W23, #0x47c
    CSINC  X24, X12, X6, VC
    SUBS  W18, W3, W8, LSL #10
    ASRV  X9, X3, X8
    BIC  V30.16B, V3.16B, V5.16B
    EOR  X18, X25, X21, ROR #28
    ADDS  W13, W27, W13, LSL #8
    LSLV  W10, W22, W9
    MOVN  W9, #0xf4c9, LSL #0
    ADDS  X9, X22, X12, ASR #50
    SMULH  X9, X6, X9
    ORR  W7, W21, #0x1ffffffe
    BIC  W29, W3, W23, ASR #19
    BICS  W10, W2, W2, LSR #16
    ADD  W29, W13, W22, LSL #4
    ORR  W13, W24, #0xff00ff
    CSNEG  W18, W12, W19, VC
    UMULH  X7, X22, X25
    ADC  X10, X25, X27
    UMSUBL  X10, W27, W13, X22
    CLZ  W2, W11
    CSEL  W24, W12, W11, HI
    CSINV  X2, X6, X13, NE
    MOVK  W11, #0xdeb8, LSL #0
    CSINV  X16, X15, X13, LE
    CSEL  X25, X16, X7, NV
    CLZ  V4.2S, V0.2S
    CLZ  X25, X22
    ADDS  X10, X10, X27, LSL #50
    CRC32CX  W12, W17, X8
    ORR  W8, W21, W21, LSL #6
    ADDS  W18, W6, W29, ASR #3
    CRC32H  W14, W13, W13
    AND  W14, W26, #0xfe7ffe7f
    EOR  X28, X17, X21, LSL #50
    EON  W18, W26, W26, LSR #14
    ASRV  W12, W15, W18
    AND  W18, W21, W13, ROR #16
    SUB  X17, X24, #0x111, LSL #12
    UMADDL  X23, W23, W25, X29
    ADC  W2, W26, W11
    AND  X26, X15, #0xe000e000e000e00
    CSEL  W18, W12, W11, LE
    ANDS  X10, X23, #0xffffe0000000007f
    CLZ  V23.8H, V15.8H
    LSLV  W22, W29, W8
    ORN  X7, X14, X12, LSL #27
    EOR  X9, X6, #0xffffe003ffffe003
    LSLV  X6, X19, X2
    CSEL  W22, W14, W11, NE
    BICS  W19, W22, W2, LSL #2
    EOR  W26, W14, W8, ROR #23
    SUB  X18, X15, X6, LSL #18
    CSNEG  W21, W28, W12, VC
    MOVK  W2, #0xf43, LSL #16
    ORR  V23.4H, #0xf8
    UMSUBL  X22, W24, W18, X23
    MOVN  X25, #0x3d89, LSL #32
    ADC  X27, X29, X10
    MOVZ  W20, #0xbf43, LSL #16
    ADD  X7, X20, X19, SXTX #3
    LSRV  X27, X14, X12
    BIC  W22, W20, W8, ROR #22
    AND  W14, W15, #0x3c003c
    ADD  W9, W25, #0x7ef
    SUB  X26, X26, W23, SXTW #0
    CRC32W  W24, W5, W18
    CSINV  X8, X27, X23, LS
    ORR  X9, X3, X7, ASR #48
    ORR  V13.8B, V13.8B, V12.8B
    MADD  X26, X3, X6, X25
    ADCS  X2, X17, X5
    ADDS  X13, X27, X27, LSL #15
    CSNEG  X24, X5, X5, LE
    ADDS  W14, W26, W17, UXTH #3
    SUBS  W10, W9, #0x754, LSL #12
    ORR  V6.4S, #0x94, LSL #8
    ADC  W29, W19, W24
    EOR  X13, X28, #0xfbfffffffbffffff
    ADD  X6, X14, W25, SXTB #4
    CLS  W8, W3
    ADD  W2, W24, #0x64d, LSL #12
    SUBS  W15, W29, W20, LSL #13
    ADDS  X20, X8, X6, SXTX #0
    CLZ  V0.2S, V26.2S
    SMSUBL  X20, W23, W5, X27
    CLZ  V18.8B, V24.8B
    SMSUBL  X28, W12, W3, X20
    CLS  V0.8H, V21.8H
    ASRV  X7, X7, X22
    CRC32H  W22, W8, W11
    EON  X25, X11, X6, LSL #33
    ADDS  X6, X29, #0xbf3, LSL #12
    EOR  X26, X15, #0x8fffffffffffffff
    CLS  X27, X10
    SUBS  X9, X8, #0x0
    ORR  W26, W8, W11, ASR #17
    LSRV  X11, X9, X21
    LSRV  X17, X29, X17
    BIC  W24, W5, W7, LSL #17
    SUBS  W12, W10, W23, ASR #9
    UBFM  X28, X16, #0x2d, #0x15
    ADD  X26, X21, W7, SXTB #4
    AND  W23, W9, #0xf80003ff
    SMSUBL  X10, W11, W25, X20
    ANDS  X25, X18, #0x3333333333333333
    SUBS  W27, W7, #0xb80
    CSEL  W26, W15, W28, VC
    ADD  W28, W15, #0xa4e
    LSLV  W14, W2, W18
    ADDS  X21, X5, W3, UXTB #3
    ADD  X29, X25, X24, LSR #60
    ORR  X25, X3, #0xffffff80003fffff
    ADDS  X28, X20, X12, ASR #36
    ORR  W21, W28, #0x3e003e00
    ADCS  W16, W23, W5
    LSLV  W17, W18, W10
    BICS  W11, W18, W16, ASR #23
    SUBS  X25, X17, X28, LSR #63
    CRC32CW  W27, W6, W21
    CSEL  X23, X23, X27, AL
    ADC  W11, W6, W26
    CLS  W21, W21
    CRC32B  W27, W18, W23
    CLS  W13, W21
    EOR  W14, W20, W12, ROR #24
    ORN  X25, X3, X13, ROR #7
    LSLV  W10, W26, W29
    ADCS  X2, X10, X24
    ADD  X16, X11, X22, LSL #26
    SUBS  X23, X24, #0xae6, LSL #12
    CSNEG  W14, W27, W10, GE
    CRC32X  W18, W8, X12
    ORR  V10.8H, #0x5d, LSL #8
    CRC32B  W28, W2, W7
    BICS  X18, X22, X28, ASR #52
    SUBS  X15, X8, X12, ASR #16
    BIC  V23.16B, V3.16B, V19.16B
    MOVZ  W18, #0x9bb9, LSL #16
    ADC  X6, X28, X24
    SUB  X20, X26, #0xfd3
    SUB  W20, W19, W20, LSR #16
    SUBS  X18, X5, X24, LSR #55
    SUBS  X25, X26, X14, ASR #28
    SUBS  X21, X16, W5, SXTB #2
    BIC  W24, W14, W20, ASR #25
    CSINV  W5, W17, W25, CC
    ORN  X6, X6, X3, ROR #60
    UBFM  X17, X3, #0x27, #0x2a
    ADDS  X7, X26, W15, SXTB #4
    CRC32H  W23, W23, W25
    SUB  W9, W11, W19, UXTW #1
    SUBS  W17, W2, W9, UXTH #4
    CRC32X  W12, W11, X15
    CRC32X  W6, W16, X9
    SUB  X26, X2, X19, LSR #30
    ANDS  X2, X15, #0xfffff00000000001
    EOR  X28, X26, X20, ASR #57
    ORR  W23, W28, #0xffe0
    BICS  X29, X19, X6, LSL #10
    SBFM  X25, X15, #0x31, #0x3c
    CSINC  X18, X18, X3, HI
    ADDS  X29, X26, W19, SXTW #0
    ADDS  X20, X21, X23, SXTX #4
    EXTR  X19, X20, X8, #0x25
    AND  X23, X8, #0x1ffffe0000000
    ADCS  W29, W26, W12
    EOR  W25, W28, W22, LSR #12
    UBFM  X10, X26, #0x16, #0xf
    UBFM  W21, W7, #0x4, #0x0
    EXTR  W12, W11, W22, #0x2
    ADCS  W11, W9, W5
    EOR  X24, X16, #0xf80000000000ffff
    ANDS  W29, W14, W3, ASR #22
    SUB  X28, X7, X26, LSR #25
    ADDS  W15, W15, #0xc7e, LSL #12
    SUB  X20, X2, X16, LSR #38
    SBFM  X6, X16, #0x6, #0x1d
    ADD  X28, X28, #0xa4f, LSL #12
    ADDS  W25, W3, W24, UXTH #3
    ADC  W20, W20, W10
    EOR  X25, X18, X23, ROR #47
    ORR  W12, W25, #0x77777777
    MADD  X23, X10, X17, X2
    MADD  W27, W14, W10, W21
    ORR  X25, X7, #0x3ff8000000
    SBFM  X12, X22, #0x1f, #0x1d
    ADDS  W2, W16, W25, SXTX #4
    SUBS  X3, X3, #0x1
    B.NE  TaishanIntMduP01_label_323
    MOVZ  X21, #0x77af, LSL #0
    MOVK  X21, #0x9238, LSL #16
    SUB  X20, X21, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X8, X21, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xc000, LSL #16
    SUB  X6, X23, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X17, #0xf52f, LSL #0
    MOVK  X17, #0xe014, LSL #16
    SUB  X22, X17, X7
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X6, #0x60bb, LSL #0
    MOVK  X6, #0x909c, LSL #16
    SUB  X12, X6, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8c00, LSL #32
    MOVK  X15, #0x19e, LSL #48
    SUB  X23, X15, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP01_TestFail
    MOVZ  X19, #0x60bb, LSL #0
    MOVK  X19, #0x509c, LSL #16
    SUB  X2, X19, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X12
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP01_TestFail
    MOVZ  X28, #0x1f, LSL #0
    SUB  X24, X28, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP01_TestFail
    MOVZ  X14, #0x6ae8, LSL #0
    MOVK  X14, #0xd584, LSL #16
    SUB  X7, X14, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x8c00, LSL #32
    MOVK  X20, #0x19e, LSL #48
    SUB  X2, X20, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x24bf, LSL #0
    MOVK  X2, #0x10e9, LSL #16
    MOVK  X2, #0xdb93, LSL #32
    MOVK  X2, #0x264, LSL #48
    SUB  X20, X2, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X25, #0xf52f, LSL #0
    MOVK  X25, #0xe014, LSL #16
    SUB  X6, X25, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X27, #0x2, LSL #0
    SUB  X26, X27, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP01_TestFail
    MOVZ  X20, #0x60bb, LSL #0
    MOVK  X20, #0x509c, LSL #16
    SUB  X22, X20, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP01_TestFail
    MOVZ  X15, #0x60bb, LSL #0
    MOVK  X15, #0x509c, LSL #16
    SUB  X29, X15, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X22
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X25
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X26
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP01_TestFail
    MOVZ  X3, #0x2, LSL #0
    SUB  X13, X3, X27
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x1f, LSL #0
    SUB  X21, X26, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X29
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X20, #0x14, LSL #0
TaishanIntMduP01_label_348:
    CLS  X8, X9
    CSINC  W15, W11, W11, GT
    ORN  W8, W19, W25, ASR #27
    ORR  V18.4S, #0x3, LSL #8
    ADDS  X13, X27, W5, SXTH #0
    ADD  X22, X12, X11, UXTX #3
    SUBS  X21, X9, X22, ASR #9
    ADC  W12, W25, W8
    ADDS  W24, W17, W24, ASR #23
    ASRV  X29, X14, X9
    LSLV  X29, X21, X13
    SMADDL  X2, W24, W6, X6
    EON  W18, W16, W12, LSR #31
    ORR  V21.16B, V14.16B, V14.16B
    AND  W3, W17, #0x3c0
    ORR  W28, W23, #0xaaaaaaaa
    MOVN  W11, #0xeb1f, LSL #16
    BIC  W15, W5, W16, LSL #25
    CLZ  V22.4S, V27.4S
    ANDS  W23, W21, #0xe0
    SUBS  W22, W29, #0x0
    CRC32CX  W27, W12, X28
    AND  W27, W11, #0xfffffc0
    SUB  W25, W15, W17, UXTB #3
    ADD  X18, X25, X20, LSR #57
    ADC  W28, W27, W9
    ORN  W27, W17, W22, LSL #27
    SUBS  W3, W22, #0x16a, LSL #12
    ANDS  X2, X13, X17, LSR #39
    SUB  X9, X10, X23, LSL #30
    SUBS  X22, X15, #0x460
    ADDS  X27, X18, X9, UXTX #4
    CSEL  W27, W9, W14, NV
    CSEL  W10, W10, W18, AL
    CLS  X28, X29
    SBFM  W21, W21, #0x9, #0x1a
    BIC  V2.16B, V29.16B, V8.16B
    ORR  W16, W17, W15, LSL #9
    CLZ  V17.8H, V14.8H
    ANDS  W10, W5, #0x33333333
    ADDS  X10, X27, #0xa50
    ADDS  X25, X15, X17, LSL #25
    EXTR  W18, W17, W19, #0x16
    SUBS  X12, X11, #0x7a7
    ANDS  X13, X28, #0xffffc000000003ff
    EXTR  W29, W23, W13, #0x12
    SUBS  X26, X25, #0xc6f
    ORN  W3, W18, W11, ASR #7
    ADDS  X18, X17, W10, UXTB #2
    ADDS  W10, W21, W22, UXTW #1
    SMSUBL  X28, W17, W28, X25
    CSINV  W22, W28, W5, MI
    ADC  W24, W25, W16
    ADD  W5, W19, W15, LSL #31
    ORR  W24, W26, #0x70707070
    ADC  W25, W13, W18
    SUBS  W27, W25, #0xdb2, LSL #12
    ANDS  X26, X7, X25, LSL #13
    ADD  X14, X12, X2, LSR #58
    LSLV  W8, W27, W2
    AND  W23, W29, W23, LSR #8
    CSINV  W26, W20, W26, HI
    SUB  W29, W6, #0xb31, LSL #12
    CSINV  X7, X13, X18, GE
    BICS  X22, X24, X23, LSR #15
    EXTR  X25, X12, X13, #0x3e
    ORR  W10, W26, #0xff87ff87
    EOR  W7, W22, #0xfffffe00
    CRC32CB  W6, W8, W8
    CRC32CH  W27, W24, W2
    ADDS  X7, X25, X11, UXTX #0
    UBFM  W6, W2, #0x15, #0x4
    CRC32H  W5, W13, W22
    MADD  X28, X14, X11, X25
    ORN  X2, X18, X23, LSR #2
    ADD  X12, X7, X22, LSL #59
    UMULH  X21, X18, X26
    ADC  W18, W24, W12
    CLZ  X16, X24
    ADDS  X19, X6, W24, UXTH #3
    MADD  W18, W17, W28, W17
    ANDS  W18, W22, #0x60606060
    ADC  W17, W5, W22
    ANDS  X21, X10, X10, LSR #33
    MOVZ  X29, #0xf1bf, LSL #48
    LSLV  X16, X6, X8
    CSINC  X8, X2, X11, VC
    CRC32CB  W25, W7, W6
    ANDS  X8, X3, X3, LSL #43
    ORR  W12, W11, W24, ASR #31
    CSEL  W21, W27, W17, LS
    ADDS  X29, X23, X2, SXTX #3
    CRC32CW  W14, W26, W13
    ANDS  X7, X2, #0x1fe01fe01fe01fe0
    AND  W18, W29, #0xe00fe00f
    SUBS  X29, X29, X6, ASR #0
    MOVN  X6, #0xaf26, LSL #16
    BIC  W14, W15, W11, ROR #11
    AND  W15, W22, W19, LSL #14
    EXTR  W2, W10, W24, #0xd
    ORN  W8, W11, W3, LSR #22
    ADD  X21, X5, W2, UXTH #3
    SUB  X7, X22, W8, SXTH #4
    ADD  W29, W27, W16, LSR #5
    LSLV  W9, W29, W3
    CRC32X  W9, W22, X27
    EON  X5, X24, X18, ASR #62
    CLZ  W26, W15
    ANDS  W2, W3, W13, ASR #3
    ANDS  W11, W23, #0x7fff0
    EOR  W18, W17, #0x33333333
    CRC32CH  W10, W21, W2
    AND  W16, W5, W26, LSR #13
    ASRV  X23, X8, X9
    CRC32H  W19, W16, W24
    CLS  V11.8H, V12.8H
    CSNEG  W22, W20, W18, AL
    CSEL  X24, X13, X11, VS
    SUB  X7, X24, X20, LSR #19
    SUB  W13, W29, W11, ASR #19
    BIC  V18.8B, V18.8B, V29.8B
    CRC32X  W26, W13, X29
    UMADDL  X3, W13, W13, X5
    MOVN  X21, #0xbad2, LSL #16
    SUB  W18, W10, W15, LSL #24
    BIC  V10.16B, V15.16B, V17.16B
    EON  X13, X20, X22, ASR #23
    ANDS  W7, W25, W16, LSR #6
    ORR  V28.16B, V24.16B, V23.16B
    MOVK  W3, #0xf60b, LSL #0
    ORR  V19.8H, #0xc2
    MOVK  X2, #0xae0d, LSL #16
    ORR  X26, X24, X29, ROR #63
    MADD  X8, X17, X16, X15
    ADDS  X12, X19, W20, SXTH #4
    ANDS  X29, X19, #0x1fffff00000000
    ADDS  W21, W14, W6, ASR #6
    AND  W29, W2, #0xff03ff03
    MOVN  W26, #0x1abf, LSL #0
    SBFM  X18, X6, #0x2b, #0xd
    SUBS  W11, W23, W11, UXTX #3
    ASRV  X19, X23, X17
    ADDS  W5, W25, #0x85a, LSL #12
    ADD  W22, W17, W13, ASR #13
    CRC32CW  W21, W13, W6
    BIC  W27, W25, W12, LSR #31
    ANDS  W17, W18, #0xff800fff
    MOVN  W18, #0x33b5, LSL #0
    SUB  W25, W10, W28, LSL #6
    LSLV  W7, W27, W28
    SUB  W14, W5, W28, UXTX #3
    ADDS  X2, X6, X10, SXTX #3
    SBFM  X29, X23, #0x13, #0x32
    ADCS  W7, W26, W8
    SUB  W16, W10, W20, LSL #24
    CSEL  X8, X25, X3, LS
    ANDS  W5, W6, W17, ROR #5
    ADC  X3, X27, X26
    ADD  W6, W27, #0xcba
    ADC  W9, W22, W12
    EON  X26, X13, X2, LSR #30
    CRC32CX  W28, W6, X21
    CLS  W21, W28
    MOVZ  X7, #0xfdab, LSL #32
    ADDS  W14, W11, W26, LSL #10
    MADD  W16, W26, W5, W7
    CSINC  X18, X28, X27, CC
    EXTR  X24, X13, X24, #0x6
    ANDS  W7, W19, W7, ROR #14
    SUB  W11, W11, W21, LSL #29
    CLS  X5, X29
    SUBS  X8, X20, W14, UXTW #4
    ADD  X18, X26, #0x31b, LSL #12
    MADD  W19, W17, W8, W14
    CRC32W  W5, W20, W18
    ORN  X23, X14, X11, ASR #62
    MADD  X8, X2, X21, X29
    CLS  V14.8B, V29.8B
    MADD  W10, W5, W7, W16
    MOVK  W19, #0x7b7f, LSL #0
    MOVK  W23, #0x56b4, LSL #16
    SUBS  W10, W17, #0x836
    CRC32B  W24, W25, W10
    ADCS  W17, W26, W22
    EON  W9, W23, W28, ASR #25
    MADD  W7, W29, W9, W8
    ORN  X3, X24, X17, ROR #33
    SUBS  X26, X9, #0x366
    ANDS  X7, X19, X21, LSR #50
    CSEL  X3, X28, X12, CC
    UBFM  X7, X19, #0x2, #0x26
    AND  X24, X21, #0x202020202020202
    EOR  W22, W18, #0x1000000
    ORR  W9, W25, W21, ROR #28
    ASRV  W3, W13, W21
    ADD  W28, W20, #0xa60
    SUBS  X27, X9, W16, SXTW #1
    EON  W21, W24, W29, ROR #26
    ORR  X16, X14, #0x38000000
    EOR  X19, X7, #0x3ff800003ff8
    SUBS  X20, X20, #0x1
    B.NE  TaishanIntMduP01_label_348
    MOVZ  X8, #0x5be7, LSL #0
    MOVK  X8, #0xac10, LSL #16
    MOVK  X8, #0x6, LSL #32
    SUB  X21, X8, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP01_TestFail
    MOVZ  X29, #0xfffe, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X3, X29, X3
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X29, #0x4e59, LSL #0
    MOVK  X29, #0x3ca7, LSL #16
    SUB  X25, X29, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x8ed0, LSL #0
    MOVK  X21, #0xf5e, LSL #16
    SUB  X8, X21, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X14, #0x1edf, LSL #0
    MOVK  X14, #0x3de1, LSL #16
    SUB  X12, X14, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X28, X13, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X28, #0x897d, LSL #0
    MOVK  X28, #0xecac, LSL #16
    SUB  X19, X28, X9
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP01_TestFail
    MOVZ  X9, #0xf7ca, LSL #0
    MOVK  X9, #0xff7f, LSL #16
    SUB  X21, X9, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0x3, LSL #16
    SUB  X9, X13, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0x3, LSL #16
    SUB  X3, X15, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X19, #0x1edf, LSL #0
    MOVK  X19, #0x3de1, LSL #16
    SUB  X22, X19, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0x3, LSL #16
    SUB  X22, X26, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X23, #0xb138, LSL #0
    MOVK  X23, #0xb65b, LSL #16
    SUB  X10, X23, X17
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x1edf, LSL #0
    MOVK  X2, #0x3de1, LSL #16
    SUB  X6, X2, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X20
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X7, #0xb138, LSL #0
    MOVK  X7, #0xb65b, LSL #16
    SUB  X14, X7, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0x3, LSL #16
    SUB  X2, X7, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X19, X7, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP01_TestFail
    MOVZ  X15, #0x897d, LSL #0
    MOVK  X15, #0xecac, LSL #16
    SUB  X24, X15, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP01_TestFail
    MOVZ  X29, #0x4e59, LSL #0
    MOVK  X29, #0x3ca7, LSL #16
    SUB  X18, X29, X29
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    MOVZ  X3, #0xa, LSL #0
TaishanIntMduP01_label_375:
    CSEL  W9, W29, W3, PL
    CLS  X15, X5
    EOR  X13, X28, X27, ASR #50
    CSNEG  X26, X21, X22, VC
    ADD  X15, X16, W14, UXTH #3
    CSINV  W8, W15, W22, LS
    CLS  W8, W9
    ANDS  X5, X10, X14, LSR #59
    UBFM  W18, W13, #0x1e, #0x1d
    CSINC  X22, X8, X12, VC
    CRC32CB  W8, W12, W26
    SUBS  W24, W24, W22, LSR #0
    MOVN  X18, #0x30a2, LSL #32
    SUB  X20, X22, W5, UXTB #0
    ADDS  W6, W19, W2, SXTB #1
    SBFM  X6, X26, #0x14, #0x34
    ADDS  X14, X18, X3, LSR #23
    CSINV  X20, X2, X12, NV
    SUBS  W19, W24, W7, LSR #23
    MOVN  X17, #0x5204, LSL #0
    ADD  X14, X16, X14, LSL #44
    SUB  X9, X5, X14, LSL #58
    CRC32W  W21, W13, W14
    EON  W27, W28, W8, ROR #26
    AND  X28, X2, #0x10001000100010
    SUBS  X29, X25, X27, ASR #62
    CSEL  X19, X27, X28, CC
    ORN  X17, X7, X7, ROR #1
    AND  X7, X14, X5, ROR #25
    UBFM  W2, W2, #0x2, #0xc
    LSRV  W24, W3, W10
    SUB  X24, X18, X20, ASR #56
    CLS  W10, W14
    CSINV  W28, W21, W28, MI
    CSEL  X10, X26, X21, EQ
    CRC32CB  W20, W15, W9
    ADD  X27, X23, W8, SXTB #1
    CLZ  V27.2S, V12.2S
    ADCS  W20, W25, W3
    ORR  V20.8B, V21.8B, V19.8B
    MOVZ  X6, #0xc45, LSL #48
    SUBS  X5, X14, W20, UXTH #1
    CSEL  X23, X6, X12, VS
    SBFM  W6, W16, #0x6, #0x12
    EON  W26, W13, W10, LSR #17
    UBFM  X15, X13, #0xa, #0x13
    ADD  X20, X29, X12, LSL #10
    ADD  X24, X27, W23, SXTB #1
    ORR  V6.8B, V3.8B, V0.8B
    SUB  X28, X2, W3, SXTH #3
    BICS  W11, W10, W18, LSR #25
    ADDS  X29, X2, X24, LSR #36
    ANDS  W5, W14, #0x30
    EXTR  X19, X7, X18, #0x4
    SMADDL  X17, W20, W26, X16
    EOR  X28, X10, #0x1000000000000
    MADD  W13, W21, W25, W18
    UMSUBL  X17, W11, W9, X21
    ADCS  X9, X5, X15
    CLZ  W6, W28
    ORR  X21, X8, X26, LSL #63
    ORN  W18, W29, W9, LSR #31
    UMSUBL  X6, W3, W26, X24
    BIC  V14.16B, V12.16B, V0.16B
    AND  X6, X19, #0xf0f0f0f0f0f0f0f0
    CSINC  X27, X21, X22, HI
    SBFM  X2, X7, #0xf, #0x2b
    CSEL  X14, X18, X21, PL
    CSINC  W26, W12, W9, LE
    CRC32CH  W15, W15, W17
    CSINV  W18, W26, W10, VS
    ORR  V6.4S, #0xcd, LSL #8
    AND  X26, X11, X29, LSR #32
    UMULH  X14, X6, X28
    ADC  W9, W14, W15
    AND  X13, X3, #0x1f0000001f0000
    MOVN  X25, #0xdd9a, LSL #16
    CLZ  X2, X9
    SUB  X19, X14, X10, SXTX #2
    CLS  V8.4H, V18.4H
    BIC  X25, X9, X27, ROR #52
    AND  W13, W29, #0x18001800
    EON  X2, X8, X16, LSR #16
    UMSUBL  X2, W10, W22, X22
    LSRV  X9, X10, X10
    EXTR  W23, W11, W29, #0x10
    AND  W14, W16, W10, ROR #21
    CLS  X5, X16
    ADC  X29, X5, X22
    ADD  W8, W29, W9, LSR #20
    CRC32CW  W23, W15, W13
    CSNEG  X12, X17, X19, GE
    CRC32B  W24, W7, W22
    MADD  W22, W27, W11, W13
    UBFM  X14, X23, #0x6, #0x10
    SUBS  X13, X13, X2, LSL #36
    SBFM  W10, W20, #0x5, #0x1f
    SMADDL  X28, W11, W16, X23
    AND  X18, X28, #0x7ffffffffff0000
    ORR  W21, W20, #0x22222222
    SBFM  X12, X22, #0x36, #0x29
    CLS  W18, W12
    CSNEG  W24, W21, W2, CC
    CSINC  X29, X23, X19, CC
    SUB  X14, X28, #0xf60
    EOR  X11, X25, #0x7ffffc
    EXTR  W13, W27, W21, #0x4
    BIC  V29.16B, V20.16B, V15.16B
    EOR  W27, W5, #0xf003f003
    ADDS  X23, X29, X6, SXTX #3
    ANDS  X5, X20, #0xfcfffcfffcfffcff
    CLZ  X10, X13
    BICS  W12, W18, W28, ROR #21
    ADD  W17, W20, W11, UXTX #0
    ADDS  W27, W17, W17, SXTX #1
    ADCS  X19, X25, X16
    ORN  W10, W7, W2, LSL #30
    ADD  X24, X5, W3, UXTB #4
    ADDS  W21, W7, #0x1d8
    LSLV  W26, W25, W24
    ADDS  W15, W8, W17, SXTX #1
    CSINC  W24, W14, W27, NE
    SUB  X10, X8, X3, ASR #5
    CLS  V8.8H, V9.8H
    BIC  V8.8B, V0.8B, V5.8B
    AND  X24, X14, #0xfff00000003fffff
    CLS  V30.16B, V5.16B
    ORR  W5, W17, #0xe00000
    CSINV  X28, X5, X19, MI
    SBFM  X17, X5, #0xd, #0x29
    ADD  X2, X24, W3, UXTH #1
    AND  X5, X8, X8, LSL #59
    MOVK  W17, #0xc95, LSL #0
    ORR  W12, W24, W2, ROR #11
    UMULH  X8, X18, X27
    CRC32CB  W20, W27, W15
    MADD  X20, X14, X14, X13
    AND  X2, X25, #0xe0000
    AND  W18, W5, W28, ASR #27
    EXTR  X23, X3, X10, #0xa
    LSRV  W17, W20, W16
    SUBS  W17, W17, #0xc15, LSL #12
    ORN  X13, X17, X21, LSL #59
    ADCS  X13, X11, X12
    CRC32H  W23, W8, W21
    ADDS  X27, X29, #0x260
    ANDS  W18, W2, #0xffffc007
    ANDS  W23, W7, W23, LSR #27
    ORR  W2, W18, W10, LSL #24
    ANDS  X15, X23, #0x7f7f7f7f7f7f7f7f
    ANDS  W5, W21, #0xf001f001
    ORR  X21, X20, #0x1fffff
    CSEL  W29, W24, W8, VC
    MOVN  W21, #0x76cc, LSL #16
    UMADDL  X17, W26, W22, X27
    CRC32CH  W26, W17, W16
    CRC32W  W24, W11, W9
    ORR  X29, X12, X15, ROR #36
    MADD  X11, X25, X14, X18
    CLS  W10, W12
    ADC  X17, X9, X2
    CSNEG  W9, W15, W26, GE
    CSINC  X29, X17, X24, LE
    ADD  X13, X3, X5, LSR #45
    LSLV  W26, W16, W8
    CSINV  X23, X11, X9, CS
    AND  W15, W21, #0xc3c3c3c3
    AND  X26, X21, #0x200020002000200
    BIC  V13.16B, V0.16B, V30.16B
    ORR  X29, X13, X23, ROR #2
    CLZ  X7, X19
    CLZ  W16, W15
    CRC32H  W11, W12, W7
    CSINV  X26, X29, X22, LT
    EON  W10, W26, W21, ASR #1
    ORN  X20, X13, X25, ASR #10
    SUBS  W5, W2, #0xda2, LSL #12
    BIC  V16.8B, V3.8B, V0.8B
    ORR  V31.2S, #0x8b, LSL #16
    CSEL  X29, X11, X20, EQ
    ASRV  X18, X22, X26
    BICS  X11, X9, X7, ASR #3
    UBFM  W22, W27, #0x1b, #0x7
    CRC32CH  W18, W7, W6
    AND  W24, W6, #0xffffe3ff
    CRC32CW  W7, W16, W12
    MOVK  W25, #0xc989, LSL #0
    AND  X19, X19, #0xffc00003ffc00003
    CSINV  X2, X26, X20, PL
    ADD  W15, W18, #0xa40, LSL #12
    BIC  V30.8B, V27.8B, V14.8B
    CRC32CX  W29, W22, X13
    ORR  V11.8B, V31.8B, V23.8B
    MOVK  X16, #0xe02b, LSL #32
    SUBS  X29, X21, #0xa6a, LSL #12
    SUB  W23, W18, #0xe5e, LSL #12
    CRC32W  W13, W20, W16
    SUBS  X12, X26, X28, LSL #47
    CRC32CB  W26, W6, W7
    CRC32CW  W23, W22, W13
    SUBS  X3, X3, #0x1
    B.NE  TaishanIntMduP01_label_375
    MOVZ  X25, #0xc3ff, LSL #0
    MOVK  X25, #0x3944, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X29, X25, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X2, #0xe000, LSL #0
    MOVK  X2, #0xe2b, LSL #16
    SUB  X27, X2, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X13, #0xf0f0, LSL #0
    MOVK  X13, #0xd0f0, LSL #16
    MOVK  X13, #0xf0f0, LSL #32
    MOVK  X13, #0xf0, LSL #48
    SUB  X3, X13, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X6, #0xdd14, LSL #0
    MOVK  X6, #0x6876, LSL #16
    SUB  X9, X6, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X8, #0xc3ff, LSL #0
    MOVK  X8, #0x222, LSL #16
    SUB  X26, X8, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP01_TestFail
    MOVZ  X3, #0xc3ff, LSL #0
    MOVK  X3, #0x3944, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xe01f, LSL #48
    SUB  X10, X3, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP01_TestFail
    MOVZ  X29, #0xf0f0, LSL #0
    MOVK  X29, #0xd0f0, LSL #16
    MOVK  X29, #0xf0f0, LSL #32
    MOVK  X29, #0xf0, LSL #48
    SUB  X10, X29, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x3db, LSL #0
    MOVK  X21, #0x7cee, LSL #16
    SUB  X27, X21, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X14, #0xb08a, LSL #0
    MOVK  X14, #0x88d5, LSL #16
    SUB  X20, X14, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X2, X15, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x3, LSL #0
    MOVK  X26, #0x41c0, LSL #16
    MOVK  X26, #0x3, LSL #32
    SUB  X27, X26, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP01_TestFail
    MOVZ  X17, #0x3db, LSL #0
    MOVK  X17, #0x7cee, LSL #16
    SUB  X3, X17, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x4d31, LSL #0
    MOVK  X12, #0x6db6, LSL #16
    SUB  X25, X12, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X6, #0xe0f0, LSL #0
    MOVK  X6, #0xd0f0, LSL #16
    SUB  X11, X6, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X14, X15, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X8, #0x3, LSL #0
    MOVK  X8, #0x41c0, LSL #16
    MOVK  X8, #0x3, LSL #32
    SUB  X7, X8, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP01_TestFail
    MOVZ  X16, #0x3fc0, LSL #0
    MOVK  X16, #0xbe38, LSL #16
    MOVK  X16, #0x1fd4, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X6, X16, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x38be, LSL #0
    MOVK  X2, #0x6b65, LSL #16
    MOVK  X2, #0xa62f, LSL #32
    MOVK  X2, #0x2a1a, LSL #48
    MOVZ  X3, #0x2237, LSL #0
    MOVK  X3, #0x15cf, LSL #16
    MOVK  X3, #0xd608, LSL #32
    MOVK  X3, #0x27ac, LSL #48
    MOVZ  X5, #0x66f, LSL #0
    MOVK  X5, #0x451c, LSL #16
    MOVK  X5, #0x4f13, LSL #32
    MOVK  X5, #0x929, LSL #48
    MOVZ  X6, #0xf552, LSL #0
    MOVK  X6, #0x2c1b, LSL #16
    MOVK  X6, #0xbc68, LSL #32
    MOVK  X6, #0x9279, LSL #48
    MOVZ  X7, #0x62ab, LSL #0
    MOVK  X7, #0x4bdf, LSL #16
    MOVK  X7, #0x5094, LSL #32
    MOVK  X7, #0x1edf, LSL #48
    MOVZ  X8, #0x28c0, LSL #0
    MOVK  X8, #0xa71c, LSL #16
    MOVK  X8, #0xb56b, LSL #32
    MOVK  X8, #0xf75d, LSL #48
    MOVZ  X9, #0x733a, LSL #0
    MOVK  X9, #0x8ba0, LSL #16
    MOVK  X9, #0x5298, LSL #32
    MOVK  X9, #0x6148, LSL #48
    MOVZ  X10, #0xf8e2, LSL #0
    MOVK  X10, #0xc4c8, LSL #16
    MOVK  X10, #0x5467, LSL #32
    MOVK  X10, #0xc0e5, LSL #48
    MOVZ  X11, #0x3cef, LSL #0
    MOVK  X11, #0x57a8, LSL #16
    MOVK  X11, #0x83fa, LSL #32
    MOVK  X11, #0x6b97, LSL #48
    MOVZ  X12, #0xd506, LSL #0
    MOVK  X12, #0x67f0, LSL #16
    MOVK  X12, #0x9550, LSL #32
    MOVK  X12, #0xfd91, LSL #48
    MOVZ  X13, #0x84f8, LSL #0
    MOVK  X13, #0x3257, LSL #16
    MOVK  X13, #0x1275, LSL #32
    MOVK  X13, #0xfb19, LSL #48
    MOVZ  X14, #0xe7e7, LSL #0
    MOVK  X14, #0x561, LSL #16
    MOVK  X14, #0x542f, LSL #32
    MOVK  X14, #0xee80, LSL #48
    MOVZ  X15, #0x7a7, LSL #0
    MOVK  X15, #0x24db, LSL #16
    MOVK  X15, #0x9a, LSL #32
    MOVK  X15, #0x919a, LSL #48
    MOVZ  X16, #0xcce2, LSL #0
    MOVK  X16, #0xd095, LSL #16
    MOVK  X16, #0x95a0, LSL #32
    MOVK  X16, #0x3b67, LSL #48
    MOVZ  X17, #0xdbb2, LSL #0
    MOVK  X17, #0x8c15, LSL #16
    MOVK  X17, #0xa502, LSL #32
    MOVK  X17, #0xc97b, LSL #48
    MOVZ  X18, #0x7a48, LSL #0
    MOVK  X18, #0x2379, LSL #16
    MOVK  X18, #0x8c20, LSL #32
    MOVK  X18, #0x54e1, LSL #48
    MOVZ  X19, #0x79f4, LSL #0
    MOVK  X19, #0x5858, LSL #16
    MOVK  X19, #0xbd67, LSL #32
    MOVK  X19, #0x4fda, LSL #48
    MOVZ  X20, #0xe8c9, LSL #0
    MOVK  X20, #0x5bc4, LSL #16
    MOVK  X20, #0x56d3, LSL #32
    MOVK  X20, #0xa1d7, LSL #48
    MOVZ  X21, #0xac55, LSL #0
    MOVK  X21, #0x1034, LSL #16
    MOVK  X21, #0x5512, LSL #32
    MOVK  X21, #0x12a2, LSL #48
    MOVZ  X22, #0xf5ae, LSL #0
    MOVK  X22, #0x34d7, LSL #16
    MOVK  X22, #0xe713, LSL #32
    MOVK  X22, #0x4877, LSL #48
    MOVZ  X23, #0x77a6, LSL #0
    MOVK  X23, #0x567b, LSL #16
    MOVK  X23, #0xc15b, LSL #32
    MOVK  X23, #0x60dd, LSL #48
    MOVZ  X24, #0x1f07, LSL #0
    MOVK  X24, #0x6048, LSL #16
    MOVK  X24, #0xd095, LSL #32
    MOVK  X24, #0x2d3c, LSL #48
    MOVZ  X25, #0xc030, LSL #0
    MOVK  X25, #0x8f24, LSL #16
    MOVK  X25, #0x7798, LSL #32
    MOVK  X25, #0x521e, LSL #48
    MOVZ  X26, #0xcea7, LSL #0
    MOVK  X26, #0x4f90, LSL #16
    MOVK  X26, #0x60b0, LSL #32
    MOVK  X26, #0x4b5a, LSL #48
    MOVZ  X27, #0x8766, LSL #0
    MOVK  X27, #0x4d4c, LSL #16
    MOVK  X27, #0x2217, LSL #32
    MOVK  X27, #0x4bd0, LSL #48
    MOVZ  X28, #0x46bd, LSL #0
    MOVK  X28, #0xb2d, LSL #16
    MOVK  X28, #0x8cd8, LSL #32
    MOVK  X28, #0xeb8e, LSL #48
    MOVZ  X29, #0xb0b5, LSL #0
    MOVK  X29, #0x8d35, LSL #16
    MOVK  X29, #0xedd6, LSL #32
    MOVK  X29, #0x3d3e, LSL #48
    MOVZ  X6, #0x14, LSL #0
TaishanIntMduP01_label_401:
    ORR  W11, W16, W29, ASR #0
    AND  W26, W28, W21, LSL #3
    BICS  W27, W8, W22, ASR #8
    ORR  V7.2S, #0xe9
    SUBS  X11, X28, #0xa09
    CSEL  W23, W28, W6, LE
    SUBS  X22, X27, W27, UXTH #1
    SUBS  X15, X19, #0x4c9, LSL #12
    ADD  X26, X14, X25, LSL #42
    SUBS  X7, X11, W24, SXTW #1
    CLS  X2, X22
    SUB  W17, W2, W16, UXTX #4
    CSEL  X5, X28, X11, NE
    ADD  W10, W6, #0x3e6
    EOR  W24, W3, #0xffc3ffc3
    ADDS  W13, W2, W21, UXTX #2
    ANDS  W26, W7, W17, LSL #30
    CLS  W28, W26
    LSLV  W13, W8, W10
    CRC32CH  W27, W27, W14
    CLS  W13, W28
    EOR  W8, W11, #0xc0000001
    CRC32W  W10, W26, W19
    ORR  W2, W29, W29, LSR #21
    CRC32W  W7, W25, W7
    ORR  V25.8B, V31.8B, V0.8B
    MOVZ  X5, #0x5381, LSL #16
    SMADDL  X28, W7, W10, X23
    SMSUBL  X25, W16, W7, X26
    MOVZ  X2, #0xc834, LSL #0
    CLZ  X8, X15
    LSRV  W11, W24, W5
    SUB  W27, W12, W12, LSR #12
    BIC  V1.16B, V23.16B, V10.16B
    LSRV  X10, X13, X23
    CSNEG  W9, W25, W19, VS
    EOR  X20, X25, #0xffffe007ffffffff
    CSINV  W16, W5, W26, HI
    MOVN  X28, #0xef07, LSL #48
    BICS  W3, W28, W28, ASR #31
    CLS  V6.4S, V24.4S
    SMSUBL  X3, W5, W24, X17
    SUBS  X10, X23, W7, UXTH #0
    SUB  W29, W10, #0x9b
    CRC32CX  W23, W25, X17
    ANDS  W8, W18, #0x1fc01fc0
    UMULH  X20, X28, X17
    MOVZ  W18, #0xb0ad, LSL #0
    SUBS  X8, X24, W10, UXTH #2
    CSNEG  W3, W15, W3, NE
    EON  W3, W10, W16, LSL #14
    SUBS  W24, W7, #0xe46
    EOR  X11, X26, X18, LSL #55
    ADCS  X24, X29, X20
    BIC  V5.8B, V26.8B, V24.8B
    CRC32X  W27, W24, X7
    MOVN  W14, #0x6e72, LSL #0
    LSRV  W20, W21, W26
    SUB  W26, W25, W13, SXTH #3
    ADC  X23, X26, X24
    CLS  X7, X23
    AND  W21, W17, W19, LSR #25
    LSRV  X7, X19, X2
    MOVN  W28, #0xc2e5, LSL #0
    MOVN  W22, #0xb970, LSL #0
    CSEL  X27, X28, X16, MI
    UMADDL  X24, W24, W18, X16
    ANDS  W29, W6, #0xfc1ffc1f
    ANDS  W10, W23, W14, ROR #29
    EOR  W7, W26, #0xff0001ff
    ADD  W24, W9, W23, UXTX #3
    ADD  X5, X27, W14, UXTH #1
    ORR  X5, X3, #0x3fe000003fe00000
    EXTR  X28, X25, X27, #0x2b
    SUB  X20, X7, X28, LSR #25
    ADDS  X17, X3, W15, UXTW #3
    CRC32W  W13, W2, W11
    CLZ  W20, W27
    CLZ  W21, W14
    CSINV  W24, W16, W29, GT
    ANDS  X13, X14, X27, LSL #35
    BIC  W7, W26, W28, LSL #9
    SMULH  X16, X11, X27
    CSEL  W25, W11, W10, EQ
    ORR  W26, W18, #0x7c7c7c7c
    CSEL  W9, W12, W20, NE
    AND  W7, W22, W10, LSR #29
    ANDS  W16, W10, W19, LSL #31
    CRC32CH  W29, W13, W7
    EOR  W22, W21, W2, ASR #16
    SUB  W26, W16, W24, LSR #1
    ADDS  X20, X22, X11, ASR #58
    ADC  X13, X16, X9
    MOVZ  W19, #0xf4d2, LSL #16
    CRC32CB  W14, W13, W16
    SUB  W17, W19, W22, SXTB #4
    CSNEG  X13, X7, X21, LS
    ADDS  W22, W24, W26, UXTB #2
    SUB  X7, X29, #0x2f9, LSL #12
    EXTR  W11, W11, W29, #0x18
    SUBS  W20, W13, W25, UXTB #4
    EXTR  W9, W19, W20, #0x1a
    CLZ  X22, X19
    CRC32W  W17, W5, W16
    SUB  W5, W22, W17, LSR #11
    EON  X18, X20, X20, ASR #9
    EOR  X18, X24, #0xffffff81ffffff81
    SMSUBL  X16, W29, W5, X21
    MADD  W26, W14, W28, W17
    EOR  X7, X25, X15, ROR #35
    CLZ  X13, X19
    ORR  W29, W10, W2, LSR #10
    SUB  X29, X5, X15, SXTX #2
    ADDS  X3, X10, X5, LSR #19
    CLS  V13.8B, V13.8B
    BICS  W2, W8, W23, ASR #0
    EOR  W28, W9, #0xff3fff3f
    UBFM  X9, X24, #0x11, #0x18
    AND  W15, W13, #0xf000f00
    ANDS  W7, W9, #0xff3fff3f
    SUB  W16, W11, W5, SXTX #3
    SUBS  W13, W13, W15, ASR #26
    LSLV  W27, W8, W17
    BICS  X20, X18, X14, ROR #43
    UBFM  X29, X12, #0x1f, #0x4
    MADD  W3, W10, W3, W25
    EOR  X3, X11, X25, ROR #6
    SUBS  W29, W27, W11, SXTX #2
    CRC32H  W18, W8, W14
    ORR  V20.8H, #0xd0
    ANDS  X20, X16, X12, LSL #52
    AND  X10, X28, #0xffffe000000000ff
    AND  X2, X2, #0x780000007800
    EOR  W13, W21, #0x3ffe00
    ORR  W25, W13, #0xffe7ffff
    CSINV  W17, W19, W22, VC
    MOVZ  X13, #0xe403, LSL #0
    SMADDL  X19, W19, W24, X24
    ORR  V23.4S, #0x5e, LSL #16
    ASRV  X17, X18, X27
    LSLV  X20, X3, X19
    UMULH  X7, X11, X10
    CRC32X  W20, W15, X14
    SMULH  X25, X18, X10
    ORR  V9.8B, V2.8B, V10.8B
    ORR  V23.4S, #0xe7, LSL #24
    MOVN  X3, #0xc94a, LSL #48
    SBFM  W29, W22, #0xc, #0xc
    ADDS  X7, X13, #0x63
    EOR  X12, X2, X16, LSL #22
    ORR  X11, X10, #0x1ffffc0000000000
    BICS  W19, W5, W16, ASR #13
    ADDS  X27, X2, X27, UXTX #1
    SUB  X23, X6, W21, UXTB #3
    EXTR  W29, W6, W6, #0x18
    CRC32H  W18, W15, W29
    CRC32CH  W27, W25, W24
    ADDS  X11, X17, #0x447, LSL #12
    MADD  X25, X3, X3, X16
    BICS  X18, X14, X5, LSL #8
    BICS  X5, X13, X2, LSL #32
    ADDS  X21, X21, X5, LSR #6
    ANDS  X23, X24, #0xfffc07fffffc07ff
    SUBS  W29, W13, W27, SXTW #3
    CSEL  W24, W2, W20, LE
    ADC  W25, W13, W5
    UMADDL  X3, W10, W18, X18
    MOVK  W7, #0x9108, LSL #16
    SMULH  X16, X13, X12
    CRC32CX  W23, W29, X24
    ADC  X17, X27, X14
    ORR  X15, X29, #0xffff000fffff000f
    SBFM  X9, X16, #0x10, #0x3e
    SUB  X18, X16, X20, LSL #14
    LSLV  X5, X14, X24
    SUB  X2, X25, X9, LSR #32
    CSNEG  W21, W25, W29, GT
    SUB  X21, X25, #0x6f6
    LSRV  W25, W6, W3
    SUB  W29, W8, W22, UXTH #4
    SUBS  X29, X21, #0xfe, LSL #12
    ORR  V4.4S, #0x1, LSL #24
    ADD  W17, W22, W2, LSL #14
    ANDS  X11, X17, #0x3f0000003f
    SUBS  W23, W23, #0x857
    MOVZ  X13, #0x1bfb, LSL #0
    EON  W18, W6, W29, ASR #29
    SBFM  W21, W15, #0x12, #0xc
    SUB  X15, X24, #0x8bb, LSL #12
    ADD  X13, X24, X24, LSL #51
    CRC32CB  W9, W6, W12
    SUB  W22, W8, #0xd8e, LSL #12
    UMSUBL  X9, W28, W9, X27
    CSEL  X22, X25, X3, VS
    CRC32CW  W13, W2, W2
    CLZ  W13, W7
    EOR  X28, X2, #0x3ff8000000000
    CSEL  W14, W28, W27, EQ
    UMADDL  X7, W3, W23, X22
    UBFM  X9, X29, #0x38, #0x34
    SUBS  X6, X6, #0x1
    B.NE  TaishanIntMduP01_label_401
    MOVZ  X24, #0xc806, LSL #0
    MOVK  X24, #0x1, LSL #16
    SUB  X15, X24, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X9, X12, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X27, X3, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X15, #0xbecb, LSL #0
    MOVK  X15, #0xffc1, LSL #16
    SUB  X19, X15, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X26, X23, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP01_TestFail
    MOVZ  X18, #0x3f, LSL #0
    SUB  X6, X18, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x20, LSL #0
    SUB  X19, X21, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X12
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X20, X15, X13
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X19, #0x77d2, LSL #0
    MOVK  X19, #0xe9e, LSL #16
    SUB  X29, X19, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X20, X6, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X15, #0x8020, LSL #0
    MOVK  X15, #0x7201, LSL #16
    SUB  X27, X15, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X11, #0x3f, LSL #0
    SUB  X19, X11, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X6, #0x20, LSL #0
    SUB  X19, X6, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X8, #0xc806, LSL #0
    MOVK  X8, #0x1, LSL #16
    SUB  X17, X8, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X24, X23, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X3, #0x14, LSL #0
TaishanIntMduP01_label_425:
    ADDS  W9, W19, W18, LSL #4
    ADD  W6, W24, #0x210
    SUBS  W19, W29, W21, UXTX #1
    ADD  W9, W6, W6, LSL #2
    ADD  X13, X5, X22, ASR #23
    ADDS  X8, X2, #0xfac
    ANDS  W24, W28, W6, LSR #6
    ANDS  W21, W8, #0x3e
    CRC32CH  W13, W5, W15
    CRC32X  W2, W13, X27
    ADD  W17, W19, W23, SXTB #4
    ADC  W13, W28, W9
    MOVK  X10, #0x1d73, LSL #0
    AND  X6, X16, X18, LSL #36
    CSNEG  X14, X23, X28, GT
    ADD  X21, X2, W25, SXTH #2
    ORN  W15, W20, W29, ASR #13
    EOR  W13, W12, W15, ASR #9
    ADCS  W7, W26, W21
    CSINV  W5, W6, W6, MI
    SUBS  W10, W22, W5, LSR #24
    CSNEG  W13, W29, W7, PL
    UBFM  X19, X18, #0x3b, #0x13
    UBFM  W24, W16, #0x19, #0x8
    ORR  X10, X15, X23, LSR #62
    EON  X18, X19, X10, ROR #17
    SUB  W20, W21, W23, UXTH #0
    ORR  W29, W10, W2, LSL #21
    ORR  X21, X14, #0xe000000007ffffff
    EOR  W9, W19, W7, LSR #16
    CSINC  X8, X13, X21, HI
    ANDS  W18, W5, #0x1800180
    BIC  V8.8B, V18.8B, V0.8B
    ADD  X28, X16, X9, LSL #48
    SUBS  W28, W6, W5, LSL #17
    ADDS  X29, X23, W29, SXTB #2
    CLZ  V11.16B, V4.16B
    ASRV  X17, X17, X8
    SUBS  W29, W17, #0x0
    ADD  W24, W12, W25, ASR #14
    ADC  X29, X18, X6
    ADDS  W20, W10, #0xa3a, LSL #12
    EXTR  W11, W3, W25, #0xc
    CSEL  X16, X24, X29, LS
    UMULH  X23, X14, X9
    SBFM  X23, X11, #0x1b, #0x20
    SUB  X14, X17, W12, SXTH #0
    BICS  W10, W9, W29, ASR #24
    CRC32CX  W28, W29, X14
    MOVN  X29, #0x1884, LSL #32
    ANDS  W22, W6, #0xff83ff83
    ADDS  X6, X12, #0x370
    SUBS  W20, W8, #0xf06, LSL #12
    ADC  W19, W29, W22
    ORR  V1.8B, V8.8B, V11.8B
    ADDS  W12, W16, W26, SXTH #0
    ADD  W12, W29, #0x28
    ADD  W15, W5, #0xde2
    ADCS  X15, X18, X25
    ORR  X19, X17, #0xfe7ffe7ffe7ffe7f
    EOR  X24, X24, #0xffffe00007ffffff
    ADD  W18, W18, W10, SXTX #4
    ADD  W18, W2, #0x570
    ANDS  W8, W2, #0x800080
    UBFM  X18, X9, #0x1e, #0x13
    ADD  X20, X19, W6, SXTB #2
    ANDS  W24, W8, #0xfff1ffff
    CRC32X  W12, W9, X28
    SUBS  X24, X15, #0x7e3
    ORR  V7.4S, #0x7e, LSL #8
    ORN  W26, W5, W17, LSL #3
    SUB  W8, W15, W24, LSR #6
    CRC32X  W18, W5, X16
    ADC  W21, W12, W10
    ANDS  W15, W28, #0xc0000000
    ANDS  X15, X3, X23, LSR #38
    ORR  V28.2S, #0xb9, LSL #8
    ADD  W23, W14, W26, SXTB #0
    CRC32W  W16, W5, W22
    EOR  W16, W2, W20, ASR #4
    CSINC  W15, W26, W23, PL
    ADDS  W13, W19, W19, LSR #17
    SUB  X15, X8, #0x1cf
    EON  X25, X18, X12, ROR #1
    EOR  W9, W16, #0x801f801f
    ADC  W22, W15, W21
    UBFM  X24, X24, #0xa, #0x2b
    CSEL  X9, X22, X24, GE
    ANDS  W22, W12, W27, LSL #14
    ADD  X17, X8, X6
    LSRV  X16, X28, X9
    SUB  X20, X2, #0x334
    SMADDL  X6, W9, W25, X5
    EON  W10, W9, W18, LSL #12
    MOVK  X20, #0x4126, LSL #32
    ADD  W2, W26, W29, SXTH #4
    ORN  X10, X3, X12, ASR #23
    ADD  X28, X9, W17, SXTB #4
    CLS  V21.4H, V7.4H
    SUB  W22, W20, W10, UXTX #2
    UMULH  X24, X3, X7
    CRC32B  W24, W22, W12
    CRC32CH  W16, W6, W11
    UBFM  X11, X9, #0x22, #0x6
    CSEL  X13, X24, X6, NV
    ORR  V6.16B, V2.16B, V6.16B
    CLZ  X22, X12
    CLS  V25.8H, V26.8H
    BICS  X27, X12, X8, LSL #54
    AND  W6, W11, #0xe0e0e0e0
    CRC32X  W2, W23, X13
    CLZ  V22.8B, V22.8B
    CLS  V28.2S, V5.2S
    CLZ  W7, W25
    CSNEG  W12, W2, W25, GT
    EOR  X19, X6, X29, ROR #7
    SMSUBL  X29, W22, W3, X19
    EXTR  W8, W2, W9, #0x1
    SUBS  X27, X20, X22, UXTX #2
    SMADDL  X29, W7, W12, X5
    EOR  X18, X11, X9, LSL #23
    CRC32W  W27, W25, W29
    SMADDL  X14, W20, W13, X11
    ORR  V31.4S, #0xf, LSL #24
    ADDS  W20, W19, #0x98d
    ANDS  W27, W6, #0xfffff3ff
    ANDS  W14, W8, #0xfffc003f
    ADDS  X13, X18, X16, SXTX #0
    EOR  W17, W14, #0xfffe0007
    BIC  W27, W9, W5, ROR #5
    ADDS  X10, X13, #0xf6
    LSLV  W20, W18, W20
    CRC32B  W5, W13, W13
    BIC  V1.8B, V7.8B, V9.8B
    SMULH  X22, X29, X3
    LSRV  W15, W10, W29
    SBFM  X27, X16, #0x3e, #0x2
    CSNEG  W24, W8, W15, CS
    CLZ  X5, X24
    ADCS  W20, W6, W5
    SBFM  X10, X7, #0x22, #0x9
    CLZ  X11, X15
    CSEL  X9, X2, X14, NV
    CLZ  W26, W5
    ANDS  W11, W17, #0x8000
    SUBS  X13, X17, W7, UXTB #1
    ADDS  W14, W9, W26, LSR #12
    SBFM  W2, W8, #0x17, #0x1b
    SUBS  X29, X19, X18, LSR #62
    UMSUBL  X7, W8, W13, X10
    ORR  W5, W29, #0x33333333
    AND  W8, W13, #0x11111111
    ORR  X24, X20, #0xfffff007fffff007
    EXTR  W22, W18, W8, #0x17
    ADD  W6, W15, W20, LSR #17
    UMULH  X24, X19, X7
    AND  X13, X23, #0xffe00000ffe0000
    ADDS  W22, W3, W18, UXTX #2
    CRC32W  W2, W16, W6
    EOR  X19, X9, #0xfe0000fffe0000ff
    ORR  X29, X22, #0xf7fff7fff7fff7ff
    SUB  X23, X7, X10, LSR #11
    CLZ  W5, W12
    ADDS  W23, W11, W19, ASR #9
    ADD  W8, W22, #0x956, LSL #12
    ORR  V27.8H, #0x2d
    BIC  W25, W26, W29
    SUB  X2, X14, X23, SXTX #2
    EXTR  W20, W13, W23, #0x1d
    SMADDL  X29, W21, W9, X29
    ADD  X11, X20, X21, LSR #28
    CRC32B  W25, W24, W10
    LSRV  W17, W5, W20
    ADDS  X18, X10, X11, ASR #36
    AND  X6, X12, #0xc0007fffffffffff
    CRC32H  W10, W2, W15
    UMULH  X8, X6, X15
    SUBS  X24, X6, #0xec0
    EOR  W28, W3, W2, ROR #2
    LSRV  X25, X11, X11
    MOVZ  X23, #0x575, LSL #48
    ANDS  W19, W23, #0x1f80000
    ORR  X19, X16, #0xfffffffffffff0
    ADC  W10, W14, W24
    EOR  W10, W13, W22, ASR #17
    ADD  X9, X8, #0x276
    MOVK  W7, #0x57e6, LSL #16
    ORR  X28, X29, X2, ASR #11
    ORR  V7.4H, #0xfe
    ADCS  W18, W14, W28
    CSINV  W26, W16, W13, VC
    CRC32B  W10, W25, W29
    ADC  X27, X25, X8
    MOVN  W12, #0x827f, LSL #16
    MADD  X26, X17, X26, X27
    CSNEG  X14, X8, X9, GT
    CSINC  W24, W19, W22, MI
    MADD  X19, X15, X24, X6
    CLS  V16.4H, V25.4H
    MOVN  W17, #0xe58a, LSL #0
    SUBS  X3, X3, #0x1
    B.NE  TaishanIntMduP01_label_425
    MOVZ  X27, #0x1162, LSL #0
    MOVK  X27, #0xc432, LSL #16
    SUB  X17, X27, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X14, #0x6022, LSL #0
    MOVK  X14, #0xc4a7, LSL #16
    SUB  X10, X14, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP01_TestFail
    MOVZ  X9, #0xa66a, LSL #0
    MOVK  X9, #0x57e6, LSL #16
    SUB  X29, X9, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X15, #0xa66a, LSL #0
    MOVK  X15, #0x57e6, LSL #16
    SUB  X9, X15, X9
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP01_TestFail
    MOVZ  X23, #0x1, LSL #0
    SUB  X2, X23, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0x7d80, LSL #16
    SUB  X22, X26, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x6022, LSL #0
    MOVK  X26, #0xc4a7, LSL #16
    SUB  X5, X26, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X5, #0xa66a, LSL #0
    MOVK  X5, #0x57e6, LSL #16
    SUB  X10, X5, X15
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP01_TestFail
    MOVZ  X15, #0x6026, LSL #0
    MOVK  X15, #0xaa2d, LSL #16
    SUB  X2, X15, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X17
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X18
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X29, #0xb868, LSL #0
    MOVK  X29, #0xcd2, LSL #16
    MOVK  X29, #0x2a1b, LSL #32
    MOVK  X29, #0xcc7, LSL #48
    SUB  X20, X29, X19
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X20, X11, X20
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X13, #0xf7ef, LSL #0
    MOVK  X13, #0x1594, LSL #16
    SUB  X12, X13, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X14, X19, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X11, #0x1, LSL #0
    SUB  X8, X11, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X8, X9, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X21, X11, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x1162, LSL #0
    MOVK  X12, #0xc432, LSL #16
    SUB  X24, X12, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x87ff, LSL #0
    MOVK  X12, #0x73bb, LSL #16
    MOVK  X12, #0x2a2c, LSL #32
    MOVK  X12, #0xf2ff, LSL #48
    SUB  X15, X12, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP01_TestFail
    MOVZ  X11, #0xb868, LSL #0
    MOVK  X11, #0xcd2, LSL #16
    MOVK  X11, #0x2a1b, LSL #32
    MOVK  X11, #0xcc7, LSL #48
    SUB  X12, X11, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    MOVZ  X28, #0xa, LSL #0
TaishanIntMduP01_label_449:
    CSINV  X16, X5, X3, NE
    CRC32CH  W25, W21, W11
    SUBS  X17, X28, #0x841
    ORR  X16, X20, X26, LSL #61
    CSINV  X6, X20, X9, VC
    UBFM  W2, W10, #0xe, #0xc
    EXTR  W13, W5, W6, #0x1b
    SUB  X8, X8, #0x18d
    SUBS  W14, W12, W10, UXTB #1
    CSINV  W19, W19, W29, CS
    CLZ  W10, W9
    LSLV  X6, X18, X7
    ADD  X25, X15, #0xf14, LSL #12
    EOR  X25, X26, #0x1c0000001c0000
    ORR  X16, X22, #0xfffffffffffc0001
    EXTR  W12, W14, W19, #0x12
    UMULH  X22, X7, X12
    MOVN  W13, #0xa3c5, LSL #16
    ADDS  W5, W20, W2, UXTH #1
    ADDS  X2, X5, X7, LSL #53
    AND  W20, W3, W20, ROR #18
    ORR  X2, X13, #0x7fffffff000000
    MOVK  X12, #0xaf69, LSL #16
    ADD  X6, X22, X28, LSL #1
    BIC  W9, W29, W14, LSL #20
    EXTR  X7, X23, X19, #0x2b
    MOVZ  X16, #0x2017, LSL #0
    ORR  V7.16B, V10.16B, V19.16B
    ADDS  W14, W2, #0xb77
    MADD  X14, X20, X12, X12
    UMULH  X21, X22, X17
    SMSUBL  X25, W10, W26, X26
    BICS  W18, W10, W14, ROR #27
    UMSUBL  X23, W19, W15, X11
    CRC32W  W3, W10, W20
    ORR  W22, W21, W22, ROR #18
    ANDS  W13, W23, #0xffff7fff
    CSEL  X10, X16, X24, MI
    CLS  X2, X2
    EON  W7, W18, W22, LSR #25
    CSEL  X2, X29, X3, GE
    LSLV  X29, X15, X25
    ORR  V23.4H, #0x67, LSL #8
    BIC  W24, W25, W7, ROR #11
    UBFM  X13, X19, #0x14, #0x7
    CSNEG  X11, X22, X22, MI
    CRC32CW  W13, W20, W9
    SUBS  X14, X6, #0xac1, LSL #12
    ORR  V29.16B, V10.16B, V5.16B
    ADD  W13, W21, #0x6d7, LSL #12
    SUBS  W7, W7, W28, UXTB #2
    SUBS  X10, X20, X7, UXTX #2
    ORN  X24, X11, X11, ASR #19
    UBFM  X26, X6, #0xe, #0x33
    ADDS  X10, X10, W19, UXTW #3
    ADD  X5, X21, #0x85d
    EOR  W6, W22, W23, LSL #9
    ORN  X25, X13, X21, LSL #6
    ANDS  X23, X14, #0xffe00000000000
    CSNEG  X21, X6, X7, NE
    LSRV  X11, X2, X3
    CSINC  X16, X24, X2, LE
    CSINV  X21, X6, X11, AL
    CSINC  W20, W18, W24, MI
    ADDS  X18, X12, X2, SXTX #0
    MOVZ  X26, #0xb16e, LSL #0
    EXTR  W20, W13, W16, #0x3
    CSEL  W18, W29, W22, EQ
    ORR  V16.2S, #0xf8, LSL #8
    UMULH  X8, X19, X6
    ANDS  W26, W5, #0x3f3f3f3f
    EOR  X24, X27, X21, LSL #18
    ORN  X24, X9, X22, LSL #4
    BIC  X9, X27, X18, ROR #29
    UBFM  X17, X13, #0x1e, #0x26
    CRC32W  W25, W6, W13
    UBFM  W19, W29, #0x1b, #0x1f
    ADDS  X3, X19, #0x2ca
    CRC32W  W27, W12, W12
    CRC32CB  W24, W12, W17
    BICS  X23, X11, X26, LSL #16
    ADD  X6, X27, #0x2c0
    ADDS  X22, X25, X12, LSL #16
    EXTR  W3, W12, W22, #0x10
    ADD  X27, X23, #0x8e0
    MOVK  X15, #0xcd87, LSL #16
    BIC  V25.16B, V1.16B, V19.16B
    AND  W27, W29, W16, LSR #11
    MADD  X26, X21, X24, X5
    MOVN  X16, #0x78fd, LSL #48
    SMSUBL  X6, W26, W13, X2
    CLS  V12.2S, V15.2S
    BICS  W25, W6, W27, LSL #24
    CLZ  W12, W6
    MADD  X5, X6, X19, X15
    SUBS  W6, W19, W19, SXTW #4
    CSEL  W6, W3, W29, EQ
    CSINV  X15, X16, X8, PL
    SMADDL  X16, W5, W18, X20
    SBFM  W19, W25, #0x2, #0x5
    SUBS  W27, W13, W8, ASR #20
    MOVN  X18, #0x68e0, LSL #32
    EOR  X12, X23, #0x1ffe00001ffe
    MADD  W10, W13, W17, W6
    ORR  V5.8H, #0x5f
    EOR  W15, W26, #0x7fff00
    UBFM  W22, W12, #0x1a, #0xe
    ADDS  W10, W10, W28, ASR #18
    CLZ  W19, W27
    SUBS  X22, X12, W19, SXTW #4
    EOR  X26, X6, X11, ASR #54
    BIC  W18, W21, W15, LSL #5
    ORR  W14, W18, W26, LSL #14
    EXTR  W17, W16, W8, #0x7
    CRC32CB  W7, W10, W7
    UBFM  W12, W12, #0xb, #0x1c
    SUB  W12, W18, W14, SXTH #1
    CRC32CB  W22, W21, W22
    LSLV  W22, W8, W21
    EOR  X29, X17, X16, ASR #15
    EOR  X29, X8, X6, LSL #43
    AND  W24, W12, W29, LSR #4
    ADDS  W7, W3, W21, ASR #28
    LSLV  X7, X19, X19
    AND  X7, X18, X3, LSR #23
    AND  W22, W14, #0x8000000
    EXTR  W7, W11, W18, #0x13
    ADDS  W22, W17, #0x72c, LSL #12
    CRC32B  W23, W22, W14
    BIC  W29, W10, W12, ASR #8
    ADD  W12, W17, W8, LSR #26
    ADCS  W17, W17, W11
    CRC32CB  W24, W10, W6
    CLZ  W27, W8
    LSRV  W29, W27, W16
    UMULH  X3, X19, X10
    LSLV  X23, X27, X15
    BIC  W19, W21, W8, ROR #2
    ADDS  X27, X10, X27, UXTX #0
    SUBS  X3, X25, X21, UXTX #3
    SBFM  W10, W18, #0xe, #0x1d
    SUB  W26, W18, #0x974, LSL #12
    EON  X15, X29, X8, LSL #11
    ANDS  X12, X15, X19, LSR #58
    MOVN  X15, #0x3bd5, LSL #16
    ANDS  W22, W22, #0xfffff07f
    LSRV  W13, W13, W15
    AND  X24, X10, #0x3f3f3f3f3f3f3f3f
    CSINV  X7, X12, X20, MI
    UBFM  X29, X21, #0x9, #0x37
    EOR  W22, W29, #0xfffc03ff
    CRC32CW  W24, W28, W7
    SMADDL  X19, W23, W16, X13
    ORR  V30.16B, V15.16B, V16.16B
    ADDS  X27, X7, #0xfac
    ADDS  W17, W9, W17, UXTB #2
    ANDS  W15, W28, W12, ASR #17
    ORN  X26, X23, X13, LSR #32
    SUBS  W10, W12, W13, LSR #11
    CSNEG  X3, X18, X19, GT
    CLS  V17.8B, V24.8B
    UMSUBL  X27, W23, W27, X24
    CSEL  X7, X14, X29, GT
    ORR  V18.4S, #0x88, LSL #24
    LSRV  W16, W27, W19
    ORR  V13.8H, #0xc0
    CLZ  W22, W8
    ANDS  W22, W8, W16, ROR #13
    CSINC  X7, X19, X19, EQ
    SMULH  X23, X29, X6
    ADC  W13, W14, W16
    ANDS  X19, X26, #0xfffffc00000000
    BICS  W19, W11, W28, ASR #3
    CSEL  W11, W24, W15, LT
    ANDS  X8, X8, X29, ASR #51
    MOVZ  W14, #0xfb9d, LSL #16
    ADD  X17, X5, #0xf78
    CRC32CH  W20, W6, W9
    CRC32CW  W9, W7, W13
    CRC32CX  W18, W5, X15
    LSRV  W22, W13, W9
    UBFM  X22, X18, #0x36, #0x2c
    SBFM  X11, X11, #0x3, #0x3d
    SMSUBL  X17, W20, W29, X18
    ADD  W17, W19, W22, SXTB #2
    ASRV  W24, W29, W23
    EXTR  W5, W22, W7, #0x14
    EOR  W11, W2, #0xffc0000f
    MOVN  X19, #0xe2fc, LSL #16
    SUB  W2, W8, #0x0
    UMSUBL  X15, W25, W2, X26
    ADDS  X14, X27, X24, LSL #22
    MOVZ  X13, #0x20f8, LSL #48
    MOVZ  W22, #0x8948, LSL #16
    LSLV  W9, W22, W25
    ADDS  X12, X20, X10, SXTX #2
    ADC  W2, W20, W23
    AND  X23, X27, #0xc7ffc7ffc7ffc7ff
    ADDS  W6, W26, W5, ASR #7
    SUB  X22, X6, W19, SXTB #3
    SUBS  X28, X28, #0x1
    B.NE  TaishanIntMduP01_label_449
    MOVZ  X27, #0xef1a, LSL #0
    MOVK  X27, #0x5ef6, LSL #16
    SUB  X8, X27, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x13c0, LSL #16
    SUB  X19, X28, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP01_TestFail
    MOVZ  X27, #0x7fff, LSL #0
    MOVK  X27, #0x27, LSL #16
    SUB  X15, X27, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X28, X3, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X15, #0xecfc, LSL #0
    MOVK  X15, #0xfff5, LSL #16
    SUB  X6, X15, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X17, #0xef1a, LSL #0
    MOVK  X17, #0x5ef6, LSL #16
    SUB  X14, X17, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x20f8, LSL #48
    SUB  X7, X14, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x20f8, LSL #48
    SUB  X26, X9, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP01_TestFail
    MOVZ  X2, #0xecfc, LSL #0
    MOVK  X2, #0xfff5, LSL #16
    SUB  X29, X2, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP01_TestFail
    MOVZ  X29, #0xef1a, LSL #0
    MOVK  X29, #0x5ef6, LSL #16
    SUB  X2, X29, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X5, #0xa04f, LSL #0
    MOVK  X5, #0x1aa3, LSL #16
    SUB  X13, X5, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X26, #0xef1a, LSL #0
    MOVK  X26, #0x5ef6, LSL #16
    SUB  X27, X26, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X6, #0x5a00, LSL #0
    MOVK  X6, #0xfd59, LSL #16
    SUB  X8, X6, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X24, #0x8007, LSL #0
    MOVK  X24, #0x27, LSL #16
    SUB  X29, X24, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X17, #0x8007, LSL #0
    MOVK  X17, #0x27, LSL #16
    SUB  X18, X17, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X15, #0x3cf3, LSL #0
    MOVK  X15, #0x3d4, LSL #16
    SUB  X5, X15, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X3, #0xef1a, LSL #0
    MOVK  X3, #0x5ef6, LSL #16
    SUB  X26, X3, X26
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X17, X14, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X21, X20, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x18f, LSL #0
    MOVK  X2, #0xd37a, LSL #16
    MOVK  X2, #0x8001, LSL #32
    MOVK  X2, #0xa228, LSL #48
    MOVZ  X3, #0xa04d, LSL #0
    MOVK  X3, #0x5943, LSL #16
    MOVK  X3, #0x65f, LSL #32
    MOVK  X3, #0x7f31, LSL #48
    MOVZ  X5, #0x8aed, LSL #0
    MOVK  X5, #0x9eb5, LSL #16
    MOVK  X5, #0x3832, LSL #32
    MOVK  X5, #0x9f52, LSL #48
    MOVZ  X6, #0xe28a, LSL #0
    MOVK  X6, #0x3605, LSL #16
    MOVK  X6, #0xa09a, LSL #32
    MOVK  X6, #0x37d7, LSL #48
    MOVZ  X7, #0xf3e0, LSL #0
    MOVK  X7, #0xeaf9, LSL #16
    MOVK  X7, #0x4d9d, LSL #32
    MOVK  X7, #0x97fe, LSL #48
    MOVZ  X8, #0xf797, LSL #0
    MOVK  X8, #0xc8c, LSL #16
    MOVK  X8, #0x1021, LSL #32
    MOVK  X8, #0x18f, LSL #48
    MOVZ  X9, #0x521b, LSL #0
    MOVK  X9, #0x9efb, LSL #16
    MOVK  X9, #0x8423, LSL #32
    MOVK  X9, #0xcc8e, LSL #48
    MOVZ  X10, #0xada2, LSL #0
    MOVK  X10, #0x2b25, LSL #16
    MOVK  X10, #0x1c77, LSL #32
    MOVK  X10, #0x7293, LSL #48
    MOVZ  X11, #0x895f, LSL #0
    MOVK  X11, #0xbe21, LSL #16
    MOVK  X11, #0xd091, LSL #32
    MOVK  X11, #0xdc56, LSL #48
    MOVZ  X12, #0x569a, LSL #0
    MOVK  X12, #0x9ffa, LSL #16
    MOVK  X12, #0x51e8, LSL #32
    MOVK  X12, #0xfbc8, LSL #48
    MOVZ  X13, #0x1950, LSL #0
    MOVK  X13, #0xf4e0, LSL #16
    MOVK  X13, #0x6484, LSL #32
    MOVK  X13, #0x2716, LSL #48
    MOVZ  X14, #0xfb29, LSL #0
    MOVK  X14, #0x4a9, LSL #16
    MOVK  X14, #0x5ccf, LSL #32
    MOVK  X14, #0xdf5a, LSL #48
    MOVZ  X15, #0xaaa9, LSL #0
    MOVK  X15, #0x5b1f, LSL #16
    MOVK  X15, #0x2308, LSL #32
    MOVK  X15, #0xd48a, LSL #48
    MOVZ  X16, #0x361e, LSL #0
    MOVK  X16, #0x3aeb, LSL #16
    MOVK  X16, #0x4bfe, LSL #32
    MOVK  X16, #0xaf8f, LSL #48
    MOVZ  X17, #0x1cd0, LSL #0
    MOVK  X17, #0xcab2, LSL #16
    MOVK  X17, #0x2723, LSL #32
    MOVK  X17, #0x2b89, LSL #48
    MOVZ  X18, #0x3c5c, LSL #0
    MOVK  X18, #0xb22d, LSL #16
    MOVK  X18, #0x3f56, LSL #32
    MOVK  X18, #0x5b11, LSL #48
    MOVZ  X19, #0x3d40, LSL #0
    MOVK  X19, #0x9302, LSL #16
    MOVK  X19, #0x2dbf, LSL #32
    MOVK  X19, #0x6689, LSL #48
    MOVZ  X20, #0x165c, LSL #0
    MOVK  X20, #0x3e4b, LSL #16
    MOVK  X20, #0xc61e, LSL #32
    MOVK  X20, #0x533c, LSL #48
    MOVZ  X21, #0x558, LSL #0
    MOVK  X21, #0x4c63, LSL #16
    MOVK  X21, #0x974a, LSL #32
    MOVK  X21, #0x7b68, LSL #48
    MOVZ  X22, #0xebfa, LSL #0
    MOVK  X22, #0xe12e, LSL #16
    MOVK  X22, #0xb78d, LSL #32
    MOVK  X22, #0x4408, LSL #48
    MOVZ  X23, #0x66ce, LSL #0
    MOVK  X23, #0x9bd2, LSL #16
    MOVK  X23, #0x5a8f, LSL #32
    MOVK  X23, #0xa8e3, LSL #48
    MOVZ  X24, #0x659e, LSL #0
    MOVK  X24, #0x113e, LSL #16
    MOVK  X24, #0x5395, LSL #32
    MOVK  X24, #0x6b69, LSL #48
    MOVZ  X25, #0x9714, LSL #0
    MOVK  X25, #0x3608, LSL #16
    MOVK  X25, #0xc5d, LSL #32
    MOVK  X25, #0xe42e, LSL #48
    MOVZ  X26, #0xea2c, LSL #0
    MOVK  X26, #0xc2f7, LSL #16
    MOVK  X26, #0x4c3c, LSL #32
    MOVK  X26, #0x3f63, LSL #48
    MOVZ  X27, #0x6e2d, LSL #0
    MOVK  X27, #0xe01c, LSL #16
    MOVK  X27, #0x1427, LSL #32
    MOVK  X27, #0xbe0d, LSL #48
    MOVZ  X28, #0xcebf, LSL #0
    MOVK  X28, #0x1d06, LSL #16
    MOVK  X28, #0xddf2, LSL #32
    MOVK  X28, #0xc072, LSL #48
    MOVZ  X29, #0xdd37, LSL #0
    MOVK  X29, #0x9153, LSL #16
    MOVK  X29, #0x2b7f, LSL #32
    MOVK  X29, #0x2371, LSL #48
    MOVZ  X25, #0x14, LSL #0
TaishanIntMduP01_label_475:
    ADDS  X17, X28, X20, ASR #36
    CRC32X  W18, W27, X24
    CSEL  X12, X27, X8, GT
    SUB  X11, X18, #0x7b0
    CSEL  X13, X19, X3, MI
    BIC  X10, X8, X8, ASR #18
    CRC32CH  W26, W7, W25
    MOVK  W17, #0xeb1e, LSL #16
    ORN  X27, X11, X9, ASR #50
    ADC  X28, X25, X13
    SUB  W28, W24, #0xbd6, LSL #12
    SUBS  X22, X29, W25, SXTB #2
    SUB  X14, X10, W17, SXTH #0
    SUBS  W10, W6, W20, UXTX #2
    ADDS  X10, X2, X17, LSL #52
    ADD  W20, W23, W2, LSL #12
    ANDS  X7, X13, #0xfffffffe0000007f
    SUBS  X20, X23, #0x906, LSL #12
    CLS  W11, W16
    SUBS  W13, W6, W23, ASR #12
    ADC  X3, X24, X24
    BIC  X11, X13, X18, LSR #48
    ORR  X9, X15, #0xfffffffffffff803
    MADD  W23, W19, W13, W2
    UMULH  X29, X3, X26
    SUB  W8, W24, W13, ASR #13
    MADD  X7, X11, X5, X15
    ADD  W3, W17, #0x37, LSL #12
    CSEL  X26, X20, X2, VS
    SUB  W22, W18, W27, LSR #25
    AND  X19, X9, #0xfe00fe00fe00fe0
    BIC  W28, W23, W27, LSL #14
    SUB  W6, W17, W15, SXTW #1
    BIC  X15, X5, X29, LSR #9
    EON  W29, W16, W19, LSR #22
    BICS  X21, X12, X10, LSL #19
    CRC32CH  W16, W2, W28
    BIC  V28.8B, V26.8B, V16.8B
    EXTR  X20, X25, X19, #0x30
    EOR  W2, W25, #0x1010101
    ADD  W13, W11, W19, UXTH #3
    CSINC  X9, X10, X22, AL
    ADDS  W9, W7, W14, UXTX #3
    ASRV  X15, X15, X2
    UMSUBL  X2, W11, W17, X25
    MADD  X16, X11, X25, X3
    SUB  X23, X8, X12, UXTX #2
    ANDS  W15, W25, #0xf8fff8ff
    CLS  W28, W16
    BIC  X13, X26, X25, LSL #40
    SUBS  W19, W27, #0x850
    CRC32CH  W6, W12, W2
    MOVN  W5, #0x8138, LSL #0
    CLZ  V20.8B, V6.8B
    EOR  X24, X10, X7, LSL #15
    SBFM  X20, X6, #0x26, #0x24
    ADCS  W10, W20, W17
    SUBS  W27, W10, W20, LSR #19
    CSNEG  W5, W25, W16, MI
    EOR  X20, X2, #0x807f807f807f807f
    CLS  V11.8H, V10.8H
    EOR  W17, W19, #0x600060
    ANDS  W5, W16, #0xfffff1ff
    AND  X6, X13, X20, ASR #60
    CLS  W18, W3
    CSINC  X6, X28, X8, VS
    CLS  V3.2S, V31.2S
    ADD  X26, X22, W24, UXTW #0
    CSNEG  X3, X11, X9, NV
    SMULH  X7, X26, X28
    SMADDL  X5, W27, W9, X26
    EOR  W14, W25, #0xe01fe01f
    SBFM  X14, X19, #0x22, #0x10
    EOR  X12, X22, X11, LSR #5
    CRC32CW  W8, W8, W13
    ADDS  X20, X23, X9, UXTX #0
    ADD  X11, X26, #0x9c0
    BIC  W8, W10, W18, ASR #31
    LSLV  W16, W27, W25
    SMSUBL  X6, W24, W14, X12
    UBFM  W23, W8, #0x3, #0x16
    SUB  X11, X27, X15, LSL #60
    CSINC  X6, X9, X9, VS
    CRC32CX  W26, W20, X3
    CRC32CX  W19, W20, X22
    ORR  W10, W8, #0xf7ffffff
    CSINC  W22, W5, W13, AL
    EXTR  X29, X15, X28, #0x28
    ADD  X16, X2, W6, SXTW #4
    ORR  V7.16B, V19.16B, V8.16B
    SUB  X18, X26, X3, ASR #37
    EXTR  W7, W7, W18, #0xc
    ANDS  W11, W24, W10, LSL #28
    AND  X24, X23, #0x3fffff80000
    UMULH  X7, X20, X11
    CSNEG  W12, W27, W7, EQ
    ORN  X22, X19, X2, ROR #61
    CRC32CX  W27, W16, X7
    EXTR  X13, X11, X12, #0xb
    SUB  W28, W28, W24, UXTB #4
    ANDS  X14, X9, #0xffffe000ffffe
    ADD  W17, W16, W14, UXTX #2
    ADDS  X26, X2, W19, UXTW #0
    MOVZ  X3, #0x832e, LSL #32
    ANDS  W6, W3, #0xfffe001f
    CRC32CB  W12, W19, W19
    ADD  X15, X29, #0xb57
    SBFM  X24, X10, #0x1d, #0x3
    SMSUBL  X13, W9, W17, X19
    ADDS  X6, X17, X28, SXTX #4
    UBFM  W13, W24, #0x13, #0x1f
    SUBS  W18, W17, W28, SXTX #3
    ADD  W12, W11, #0x54c
    EXTR  X19, X20, X14, #0x12
    ADD  X5, X3, X21, ASR #12
    SUBS  X14, X18, W8, UXTW #3
    MOVN  W15, #0x3974, LSL #0
    EXTR  W16, W28, W24, #0x12
    ORN  X5, X6, X19, LSR #9
    ADC  W16, W5, W26
    CSNEG  X28, X16, X23, CS
    EXTR  W6, W28, W29, #0x18
    ADD  W9, W21, W3, LSR #0
    EON  W10, W14, W22, ROR #11
    MOVK  W24, #0xd6c5, LSL #16
    ADD  W26, W16, W21, ASR #17
    CSEL  W14, W10, W24, GT
    UMSUBL  X22, W21, W17, X10
    ASRV  W3, W27, W7
    ANDS  W15, W5, #0xbfbfbfbf
    SMULH  X14, X15, X23
    CSEL  W27, W23, W9, MI
    SUBS  W13, W6, W9, UXTH #1
    ADDS  X26, X18, W10, SXTW #4
    EOR  X10, X24, X14, ROR #60
    MADD  W15, W12, W17, W8
    SUB  W12, W29, W8, LSL #17
    MOVN  W11, #0x5531, LSL #0
    EXTR  X26, X7, X15, #0x0
    ADD  X8, X7, X26, LSR #9
    MOVN  W8, #0x293f, LSL #0
    MOVK  X14, #0x5ac3, LSL #0
    MOVZ  X19, #0x9333, LSL #16
    UMADDL  X26, W24, W12, X12
    ASRV  X8, X18, X9
    SUB  W29, W26, W18, LSL #27
    MOVN  X18, #0xd3c1, LSL #48
    CRC32CX  W8, W12, X28
    SUB  X21, X14, #0x25
    SBFM  W9, W16, #0x0, #0x16
    BICS  W3, W9, W11, ASR #17
    EON  W24, W16, W23, LSL #24
    EOR  X24, X2, #0x3fffffe0000
    CLZ  W22, W27
    AND  W9, W22, W5, LSR #15
    MADD  W24, W20, W6, W19
    SMULH  X18, X8, X9
    CLS  V18.2S, V23.2S
    MOVK  X29, #0x511f, LSL #48
    UMADDL  X21, W11, W23, X10
    AND  W3, W9, W22, LSR #26
    BICS  W15, W24, W23, ROR #7
    CSINV  W19, W7, W23, LE
    ADDS  W3, W17, W6, LSL #29
    MADD  W21, W21, W18, W3
    SUB  X23, X28, X9, ASR #8
    EXTR  W9, W29, W25, #0x1
    UBFM  W16, W18, #0x19, #0x0
    ADD  X8, X10, X14, LSR #36
    LSRV  X16, X8, X12
    SUBS  W15, W3, #0x121, LSL #12
    ADD  X2, X15, X5, LSL #58
    SUBS  X17, X20, #0xa1, LSL #12
    AND  W7, W22, #0xe003e003
    AND  W27, W20, W22, LSR #22
    ADC  X8, X14, X27
    LSRV  W10, W22, W16
    UMULH  X21, X26, X2
    LSRV  X21, X14, X27
    SMADDL  X5, W5, W25, X19
    MADD  X9, X25, X3, X19
    EOR  X17, X26, #0x3ffffffc000
    MOVK  X21, #0x56c5, LSL #32
    ADD  W12, W2, W11, SXTX #4
    LSLV  X21, X29, X3
    EOR  X29, X28, X19, ASR #43
    ORN  X5, X13, X11, ROR #7
    LSRV  X3, X5, X3
    CRC32CX  W17, W26, X10
    ANDS  W22, W23, W9, ROR #20
    EXTR  X28, X12, X23, #0x31
    EOR  W10, W3, #0xff807fff
    BIC  W7, W28, W23, LSL #12
    ADD  X20, X27, X25, ASR #23
    CSNEG  W18, W22, W16, EQ
    AND  X5, X12, #0xf0f0f0f0f0f0f0f0
    CLS  V28.16B, V5.16B
    SUBS  X20, X11, X9, LSL #49
    EOR  X22, X2, X2, LSL #45
    SUBS  W14, W6, W25, UXTX #0
    SUBS  X25, X25, #0x1
    B.NE  TaishanIntMduP01_label_475
    MOVZ  X12, #0xfc49, LSL #0
    MOVK  X12, #0x5ccc, LSL #16
    MOVK  X12, #0xfc00, LSL #48
    SUB  X14, X12, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X25, #0x1200, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0x31, LSL #48
    SUB  X24, X25, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP01_TestFail
    MOVZ  X3, #0xa020, LSL #0
    MOVK  X3, #0x50c0, LSL #16
    SUB  X9, X3, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X17, #0x1, LSL #0
    MOVK  X17, #0xfc24, LSL #16
    SUB  X29, X17, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0x1494, LSL #16
    SUB  X17, X12, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X28, #0x5ac4, LSL #0
    SUB  X12, X28, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X25, #0x6dff, LSL #0
    MOVK  X25, #0x7f, LSL #16
    SUB  X23, X25, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X22, X27, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X21, X23, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x1, LSL #0
    MOVK  X21, #0xfc24, LSL #16
    SUB  X7, X21, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP01_TestFail
    MOVZ  X21, #0xfc49, LSL #0
    MOVK  X21, #0x5ccc, LSL #16
    SUB  X23, X21, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xd6c5, LSL #16
    SUB  X2, X18, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xd6c5, LSL #16
    SUB  X15, X27, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X19
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP01_TestFail
    MOVZ  X27, #0xaace, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0x9f70, LSL #48
    SUB  X28, X27, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X6, #0xfc49, LSL #0
    MOVK  X6, #0x5ccc, LSL #16
    SUB  X28, X6, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x6dff, LSL #0
    MOVK  X26, #0x7f, LSL #16
    SUB  X23, X26, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x6dff, LSL #0
    MOVK  X9, #0x7f, LSL #16
    SUB  X8, X9, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X19, #0xaace, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0x9f70, LSL #48
    SUB  X20, X19, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X3, X14, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X14, #0x14, LSL #0
TaishanIntMduP01_label_501:
    UMADDL  X13, W12, W18, X8
    ADDS  W5, W25, W6, LSL #19
    UMSUBL  X21, W26, W24, X15
    ASRV  X18, X3, X23
    ADC  X11, X6, X21
    UBFM  W21, W6, #0x12, #0x7
    ORR  V11.4S, #0xa8, LSL #16
    BIC  W15, W16, W29, ROR #19
    ADCS  W18, W2, W9
    SUB  X24, X11, #0x2e5
    ADD  W20, W9, #0x750
    CRC32CB  W3, W29, W5
    UMULH  X2, X5, X11
    CLS  W27, W24
    MADD  X19, X16, X28, X26
    MADD  W13, W20, W7, W21
    CSINC  X15, X29, X8, AL
    BIC  W15, W5, W21, LSL #14
    ORR  W29, W22, #0xf9f9f9f9
    BICS  W9, W5, W24, LSL #31
    SUBS  W2, W2, W7, SXTB #0
    ANDS  W15, W12, #0xf01ff01f
    SUB  W18, W8, W15, LSR #14
    EON  W23, W18, W20, ROR #28
    CSNEG  W16, W13, W5, AL
    LSRV  W24, W25, W7
    ADC  W12, W29, W17
    SBFM  W20, W27, #0x2, #0x1e
    MOVN  X28, #0x382, LSL #0
    ANDS  X8, X6, X11, ASR #33
    ASRV  X7, X15, X22
    ANDS  W25, W27, #0xffffff8f
    SUB  X9, X18, X12, LSL #27
    CRC32CB  W16, W16, W12
    SUB  W16, W3, W16, UXTH #2
    LSLV  X29, X2, X28
    BIC  V11.8B, V18.8B, V13.8B
    SUB  X2, X19, X24, SXTX #2
    ORN  X23, X14, X28, ASR #45
    MADD  X23, X15, X14, X21
    MADD  W3, W17, W27, W11
    BIC  W17, W19, W5, LSR #26
    ORR  W22, W14, #0xe7e7e7e7
    ADD  X7, X15, X22, SXTX #2
    SUBS  X10, X2, W27, SXTH #1
    CSINV  X5, X25, X21, CC
    UMADDL  X24, W24, W29, X22
    CSINC  X18, X29, X19, LE
    ADDS  W19, W21, W25, ASR #6
    SUB  X22, X2, X20, LSL #19
    EXTR  X8, X19, X10, #0xc
    LSLV  W13, W23, W2
    MOVK  X16, #0xa24b, LSL #32
    CLZ  V31.8H, V26.8H
    ORR  W6, W7, #0xfe0000
    ORR  W19, W6, W15, LSR #24
    ADDS  W27, W3, W3, LSL #19
    CSINV  X10, X24, X5, AL
    EOR  W26, W7, #0x8000800
    MADD  X12, X5, X26, X28
    AND  W19, W9, W5, ASR #21
    CLZ  X21, X9
    UBFM  W12, W15, #0xa, #0x3
    BICS  W25, W26, W16, ASR #3
    SMULH  X2, X28, X21
    MOVZ  W25, #0xf959, LSL #0
    LSLV  X13, X22, X23
    SUB  X27, X16, #0xcaf
    ORN  W22, W20, W15, ROR #1
    EOR  W20, W20, #0xfff0001f
    CLZ  W12, W15
    BIC  V16.8B, V29.8B, V15.8B
    ANDS  W26, W12, #0x99999999
    ANDS  W27, W9, W20, LSL #20
    SUB  W13, W25, W15, SXTB #4
    CRC32CX  W10, W27, X16
    SBFM  X25, X5, #0x5, #0x21
    ORR  X8, X29, X17, ASR #42
    ADD  W3, W8, W16, ASR #20
    ASRV  X10, X18, X5
    SUBS  X16, X18, X7, SXTX #2
    SBFM  X29, X17, #0xe, #0x1f
    CRC32X  W13, W24, X26
    CLZ  W6, W3
    BICS  W2, W6, W6, ASR #18
    ADDS  X10, X25, #0x470
    SMSUBL  X22, W23, W10, X9
    CRC32W  W7, W28, W22
    CSINV  X29, X25, X22, MI
    ADCS  W23, W25, W23
    ORR  W28, W18, #0x78000000
    BIC  W27, W27, W17, LSL #16
    CLZ  W2, W27
    ADDS  X17, X12, #0xff0, LSL #12
    CRC32B  W22, W16, W28
    ORN  X9, X22, X27, ROR #18
    BIC  X11, X26, X26, ASR #53
    ADDS  W18, W6, W11, LSL #26
    ORR  X17, X8, X11, LSL #39
    ADDS  X13, X24, #0xbaf
    BICS  X21, X7, X16, LSL #61
    MOVZ  X9, #0xd8b9, LSL #16
    AND  X27, X21, X15, LSR #35
    MOVZ  X16, #0xfa1b, LSL #32
    ANDS  X6, X26, X12, ASR #7
    CLS  X26, X12
    SUB  X9, X7, X13, LSL #63
    EON  W28, W11, W26, ROR #18
    ADD  X28, X28, X3, ASR #3
    SUBS  X9, X6, #0x28c
    MOVN  W13, #0x9435, LSL #16
    BIC  V15.8B, V5.8B, V8.8B
    CSEL  X12, X7, X17, LT
    CSEL  W16, W12, W18, EQ
    UBFM  W22, W18, #0x1b, #0x15
    SUB  W28, W5, #0xe8f, LSL #12
    ADCS  W13, W17, W26
    AND  W10, W8, W6, LSR #5
    ADC  W9, W18, W11
    ADDS  X24, X9, X26, LSR #34
    ORN  X23, X7, X19, ASR #39
    CRC32X  W16, W22, X6
    ADD  W25, W15, W27, UXTB #0
    SUBS  W13, W14, W7, LSR #27
    ORN  X2, X13, X9, LSR #29
    BICS  W25, W13, W21, ASR #21
    CRC32X  W16, W25, X20
    ADDS  W29, W26, W10, UXTW #4
    ADCS  X15, X7, X29
    BICS  W27, W18, W19, ROR #14
    ADC  W12, W13, W29
    CLS  X15, X25
    SUBS  X3, X28, X3, LSL #38
    BIC  W19, W28, W2, LSR #1
    SUB  W28, W14, #0x7db
    ANDS  X16, X18, X28, LSR #42
    AND  X20, X28, X14, LSL #55
    ASRV  W13, W5, W14
    BIC  X7, X17, X14, LSR #36
    ORR  X23, X25, #0x7fffffffe0
    ORR  V24.16B, V16.16B, V21.16B
    BICS  W12, W14, W3, ASR #20
    CRC32W  W6, W22, W29
    UBFM  X19, X2, #0x13, #0x15
    MOVZ  X29, #0xbc13, LSL #16
    CLS  W6, W19
    SUBS  W26, W21, W25, UXTB #2
    SUBS  W3, W29, W24, LSR #5
    SUB  W21, W18, W12, UXTH #2
    SUB  X22, X18, #0x69f, LSL #12
    SMULH  X28, X21, X8
    ADDS  X8, X10, X16, LSL #23
    ADDS  W7, W29, W20, UXTX #2
    CRC32X  W27, W3, X26
    ASRV  W18, W7, W26
    ADD  W9, W27, #0xfc0
    AND  W18, W25, W2, ROR #28
    SUBS  W5, W11, #0x9a5
    SUBS  W11, W5, W15, UXTB #4
    SUB  W8, W10, W21, LSR #4
    MOVK  W6, #0x1603, LSL #0
    ADCS  X3, X23, X6
    ADCS  W25, W24, W21
    MOVZ  W29, #0xd15, LSL #0
    LSRV  W26, W26, W19
    CRC32B  W28, W5, W3
    EXTR  X17, X16, X24, #0x3
    CSINC  W13, W2, W8, NE
    BIC  V28.16B, V14.16B, V13.16B
    CSEL  W22, W17, W22, GT
    CLZ  V1.16B, V23.16B
    BICS  X7, X15, X13, LSR #46
    SUBS  X16, X20, X12, UXTX #4
    MOVN  W10, #0x4ef4, LSL #0
    ADD  W5, W11, W2, SXTH #3
    SUBS  W29, W3, W28, LSL #19
    SUB  W12, W25, W14, LSL #13
    SUB  W6, W21, #0x23c, LSL #12
    ADDS  X9, X21, X12, LSL #31
    CLS  X26, X17
    SUBS  W12, W11, W8, UXTH #0
    ADCS  W26, W3, W7
    BICS  X29, X16, X16, ROR #63
    CSINC  W5, W18, W19, GE
    ORN  W21, W21, W5, LSR #12
    MADD  W13, W8, W18, W3
    CLZ  V9.8H, V19.8H
    ADC  W13, W20, W26
    AND  X26, X22, #0x7e0000007e000000
    ORR  X28, X5, #0x3fe03fe03fe03fe0
    CRC32H  W26, W3, W2
    EXTR  W19, W6, W2, #0x1c
    SUBS  W16, W16, #0x58a
    SBFM  X10, X29, #0x9, #0x14
    ADD  X8, X11, #0x5bf, LSL #12
    CRC32X  W15, W24, X28
    CLZ  V21.4S, V16.4S
    CLZ  X29, X10
    MADD  W16, W12, W18, W17
    CRC32W  W22, W12, W26
    SUBS  X14, X14, #0x1
    B.NE  TaishanIntMduP01_label_501
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X10, X29, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP01_TestFail
    MOVZ  X19, #0x15e5, LSL #0
    MOVK  X19, #0x80, LSL #32
    SUB  X20, X19, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X25, #0x1, LSL #0
    SUB  X14, X25, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X19, #0x4000, LSL #0
    MOVK  X19, #0xffdc, LSL #16
    SUB  X13, X19, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x3e, LSL #0
    SUB  X14, X2, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X25, #0xe27b, LSL #0
    MOVK  X25, #0x5b, LSL #16
    MOVK  X25, #0x1, LSL #32
    SUB  X11, X25, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xf000, LSL #32
    MOVK  X8, #0x7fff, LSL #48
    SUB  X11, X8, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X10
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP01_TestFail
    MOVZ  X27, #0xf27b, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X24, X27, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X15, #0xf9d5, LSL #0
    MOVK  X15, #0x3534, LSL #16
    SUB  X2, X15, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X15, #0xf27b, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X8, X15, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x1, LSL #0
    SUB  X19, X2, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X9, X12, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X25, #0x6c5f, LSL #0
    MOVK  X25, #0x7471, LSL #16
    SUB  X15, X25, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X28, #0x6c5f, LSL #0
    MOVK  X28, #0x7471, LSL #16
    SUB  X25, X28, X25
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X20, #0xf27b, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X3, X20, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X15, #0x6c5f, LSL #0
    MOVK  X15, #0x7471, LSL #16
    SUB  X6, X15, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X26, X9, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    MOVZ  X16, #0xa, LSL #0
TaishanIntMduP01_label_526:
    BICS  X28, X9, X15, ASR #2
    SUB  X20, X16, #0xd94
    EOR  X19, X26, X19, ROR #43
    ADCS  W10, W2, W3
    LSLV  W18, W20, W10
    ADD  W6, W12, #0x97e, LSL #12
    ASRV  W14, W24, W3
    ORR  X25, X19, #0x1ffe00000000000
    EOR  W23, W17, #0xc00fc00f
    CSINV  X18, X25, X27, MI
    ORR  V26.4H, #0x97, LSL #8
    ANDS  X29, X14, X11, LSL #42
    SUB  W26, W19, W29, SXTB #4
    ADD  X17, X29, W7, SXTW #4
    MOVZ  X13, #0xe6a5, LSL #48
    ADD  W11, W5, #0x859
    CRC32CB  W23, W7, W14
    EXTR  W12, W21, W19, #0x10
    ORR  X27, X6, #0x3ffff8003ffff800
    CSNEG  X12, X7, X9, LT
    CLZ  V11.2S, V30.2S
    ANDS  X15, X20, #0xfc0000001fffffff
    AND  X11, X13, X21, LSR #28
    CSINV  X24, X9, X16, VS
    CRC32CB  W14, W23, W19
    ADD  W25, W20, W15, LSR #28
    UMULH  X13, X29, X10
    CRC32CB  W19, W6, W27
    CSNEG  X19, X23, X16, VS
    LSRV  W12, W10, W29
    CLZ  W28, W6
    ORR  V17.4S, #0x9a
    CLZ  V16.8H, V25.8H
    UBFM  X7, X23, #0x7, #0x22
    ADCS  W22, W18, W24
    CLS  V2.2S, V21.2S
    UMULH  X12, X17, X28
    ORR  W17, W26, W22, LSR #7
    CLZ  V5.4S, V0.4S
    UBFM  W15, W23, #0x16, #0x1
    ANDS  W21, W24, W9, ASR #7
    SUBS  X5, X2, X5, ASR #56
    AND  X27, X2, X28, LSR #13
    ADDS  X22, X21, W27, UXTH #0
    AND  X7, X11, #0x1ff000001ff00000
    CSINC  W14, W14, W6, CC
    SBFM  W26, W16, #0x7, #0xf
    MOVN  X2, #0x5d01, LSL #16
    SMSUBL  X5, W21, W22, X24
    ORR  X6, X22, X7, LSR #39
    EOR  X9, X17, #0xf800ffffffffffff
    SUBS  X24, X23, W15, UXTH #4
    SMSUBL  X12, W24, W14, X12
    ANDS  X20, X3, X2, LSR #1
    SUBS  W18, W5, W15, LSR #6
    ADDS  X22, X21, #0xe00
    SMULH  X8, X23, X6
    ADDS  X19, X3, #0xa7c, LSL #12
    MADD  W13, W27, W26, W18
    EOR  W26, W21, W23, ASR #11
    ORN  X14, X9, X14, ROR #22
    ANDS  W18, W5, W22, ROR #26
    ADDS  X15, X24, #0xbe0
    CLZ  W8, W15
    CLS  V23.2S, V1.2S
    MOVK  W18, #0x2791, LSL #0
    BIC  V12.16B, V14.16B, V13.16B
    ANDS  X28, X20, #0x7e0000007e00
    CSINC  X26, X28, X9, CC
    ADDS  X12, X17, #0x765
    CLS  V31.4S, V22.4S
    BIC  X11, X14, X7, ASR #11
    UMSUBL  X15, W24, W3, X18
    EON  X28, X8, X22, ROR #36
    ADD  X20, X5, W13, UXTB #4
    SMULH  X22, X15, X27
    EON  W9, W27, W8, ASR #12
    CSEL  W17, W20, W20, LT
    MADD  X20, X17, X18, X23
    ORR  X10, X16, #0x7f7f7f7f7f7f7f7f
    CLS  W28, W11
    ORN  W21, W10, W13, LSL #1
    EOR  X7, X28, #0x7fffffffffc000
    ADDS  W10, W9, W19, LSR #15
    SUBS  W5, W13, #0x60b, LSL #12
    ADD  X28, X28, W19, UXTH #3
    SUBS  W24, W7, W23, UXTH #4
    ASRV  W23, W28, W26
    ORN  W29, W21, W16, LSR #22
    UMADDL  X26, W3, W10, X25
    ORR  W9, W17, W16, LSR #26
    ADDS  X5, X14, X20, ASR #52
    SMULH  X22, X17, X24
    CRC32B  W5, W22, W26
    AND  X23, X29, X3, ROR #52
    EON  W6, W18, W29, ASR #10
    ADD  W9, W6, #0x185, LSL #12
    CLZ  V27.8H, V12.8H
    CLS  V20.4S, V5.4S
    ADD  X18, X18, #0x619
    MADD  W18, W10, W7, W16
    UMULH  X19, X9, X8
    CRC32CH  W9, W19, W16
    CRC32H  W9, W27, W18
    ORR  V27.8B, V11.8B, V10.8B
    MOVN  W29, #0xdcae, LSL #16
    ANDS  X7, X23, #0x1fffffe000
    BIC  X10, X7, X14, LSR #39
    ORR  V4.8H, #0xd3, LSL #8
    ORR  V27.2S, #0xd9, LSL #16
    UMSUBL  X19, W8, W18, X9
    ADDS  W2, W8, W18, UXTX #0
    ANDS  X6, X23, #0xfff3fffffff3ffff
    SUBS  X29, X21, #0x561
    SMADDL  X22, W29, W19, X2
    ANDS  X29, X10, #0xf0000007f0000007
    CLZ  X11, X8
    LSRV  W23, W6, W11
    ORN  X18, X17, X5, LSL #15
    LSRV  X18, X18, X21
    SMSUBL  X27, W29, W29, X22
    CLZ  V26.4S, V11.4S
    CSNEG  W17, W23, W9, GE
    ORR  X8, X8, #0x7ffffffff8
    ADD  W21, W26, #0x71f
    CLS  X27, X2
    CRC32X  W20, W27, X6
    CRC32X  W20, W13, X6
    CLS  X22, X8
    SUB  X14, X7, #0xd27
    ADD  X25, X15, #0x9a7
    ANDS  W2, W23, W15, ROR #31
    MADD  X9, X13, X24, X27
    BIC  X24, X16, X27, ASR #14
    BICS  W15, W11, W26, LSR #1
    LSRV  W25, W23, W28
    SMULH  X25, X16, X8
    UBFM  X14, X16, #0x1c, #0xb
    CSINV  X9, X13, X18, GE
    CRC32B  W14, W29, W12
    CRC32H  W7, W15, W20
    CRC32CW  W26, W24, W15
    ADDS  W27, W25, #0x334
    LSRV  X13, X13, X16
    SUB  X26, X26, X22, LSL #49
    AND  W2, W25, W27, ASR #20
    EON  W10, W11, W22, ROR #25
    ADD  W22, W8, #0xdaf
    EOR  W27, W7, #0x1f8000
    EOR  X26, X22, X2, ROR #51
    CSINV  W9, W26, W24, EQ
    BIC  W19, W24, W11, ROR #16
    SUB  W25, W6, W10, SXTW #4
    ADDS  W9, W29, W12, UXTB #0
    EON  W14, W9, W9, ROR #22
    CLS  V22.2S, V30.2S
    SUBS  W7, W2, #0xac4, LSL #12
    CLS  X15, X22
    MOVK  X27, #0xa2e7, LSL #0
    LSRV  W6, W21, W8
    MOVZ  X29, #0x513f, LSL #48
    CRC32CX  W29, W18, X22
    MADD  X11, X12, X26, X17
    EON  X26, X29, X19, ASR #48
    EOR  X7, X11, X21, ASR #7
    CRC32CH  W23, W8, W21
    CLZ  W26, W25
    EXTR  X25, X28, X18, #0x1a
    ADD  X15, X10, W17, SXTW #1
    CSINV  W7, W13, W29, LS
    ORR  X5, X7, #0xfffffffffc00
    ADDS  X18, X20, #0xd0f
    CLZ  W23, W26
    ADCS  X11, X3, X15
    SMSUBL  X21, W12, W9, X9
    AND  W5, W11, #0xffff0fff
    ADDS  W27, W2, W17, UXTB #4
    ANDS  X5, X24, #0xfe00003ffe00003f
    ORR  V12.4S, #0xf8, LSL #24
    MADD  W29, W7, W25, W16
    BIC  V15.8B, V30.8B, V18.8B
    MOVN  W9, #0x4b5f, LSL #0
    UMULH  X12, X6, X2
    UMSUBL  X2, W9, W23, X18
    ADD  W6, W21, #0x5d4, LSL #12
    EXTR  X2, X6, X25, #0x4
    SUBS  X23, X11, X25, UXTX #1
    CRC32CB  W29, W24, W23
    ADD  X28, X12, W23, UXTW #4
    ANDS  W23, W17, #0x3c0
    SUBS  X17, X21, X5, LSR #21
    EON  W18, W29, W2, LSL #15
    SUBS  X9, X29, #0xeb0
    CSINC  W12, W2, W7, GE
    SUBS  W21, W5, #0x0
    MADD  W17, W12, W23, W18
    SUBS  W5, W10, #0xcda
    CLS  V3.8H, V7.8H
    CSEL  X14, X3, X29, CS
    SUB  X25, X9, #0xc33
    SUBS  X16, X16, #0x1
    B.NE  TaishanIntMduP01_label_526
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x34, LSL #32
    MOVK  X17, #0x4018, LSL #48
    SUB  X2, X17, X2
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X18, X12, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X24, #0xe6e5, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X7, X24, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X19, #0x5d54, LSL #0
    MOVK  X19, #0x1728, LSL #16
    SUB  X7, X19, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP01_TestFail
    MOVZ  X7, #0xfff8, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0x7f, LSL #32
    SUB  X29, X7, X8
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X20, #0x2f6a, LSL #0
    MOVK  X20, #0xd3d, LSL #16
    SUB  X18, X20, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X18, #0xf3bf, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X3, X18, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X22, #0xf3bc, LSL #0
TaishanIntMduP01_label_492:
    MOVK  X22, #0xffe7, LSL #16
    SUB  X29, X22, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x9c5d, LSL #0
    MOVK  X9, #0x172, LSL #16
    SUB  X14, X9, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X7, X3, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X9, #0xf3bd, LSL #0
    MOVK  X9, #0xffe7, LSL #16
    SUB  X17, X9, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X16
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X3, X22, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X28, #0x5d54, LSL #0
    MOVK  X28, #0x1728, LSL #16
    SUB  X8, X28, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X7, #0x2f6a, LSL #0
    MOVK  X7, #0xd3d, LSL #16
    SUB  X28, X7, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X16, #0x1, LSL #0
    SUB  X18, X16, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X10, #0x3c0, LSL #0
    SUB  X29, X10, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X20, #0x2337, LSL #0
    MOVK  X20, #0xd3d, LSL #16
    SUB  X25, X20, X25
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X29, X26, X29
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x754e, LSL #0
    MOVK  X2, #0x6d1, LSL #16
    MOVK  X2, #0x5910, LSL #32
    MOVK  X2, #0x3e9a, LSL #48
    MOVZ  X3, #0x50dd, LSL #0
    MOVK  X3, #0xd95c, LSL #16
    MOVK  X3, #0xd826, LSL #32
    MOVK  X3, #0x3b63, LSL #48
    MOVZ  X5, #0xd6bb, LSL #0
    MOVK  X5, #0xb879, LSL #16
    MOVK  X5, #0xa722, LSL #32
    MOVK  X5, #0xc1d6, LSL #48
    MOVZ  X6, #0x6d93, LSL #0
    MOVK  X6, #0x9e68, LSL #16
    MOVK  X6, #0xc849, LSL #32
    MOVK  X6, #0x5c82, LSL #48
    MOVZ  X7, #0x14bc, LSL #0
    MOVK  X7, #0x1dac, LSL #16
    MOVK  X7, #0x142, LSL #32
    MOVK  X7, #0x27f9, LSL #48
    MOVZ  X8, #0x330f, LSL #0
    MOVK  X8, #0x45e5, LSL #16
    MOVK  X8, #0x96d2, LSL #32
    MOVK  X8, #0x380, LSL #48
    MOVZ  X9, #0x5739, LSL #0
    MOVK  X9, #0x239f, LSL #16
    MOVK  X9, #0x5683, LSL #32
    MOVK  X9, #0x1b38, LSL #48
    MOVZ  X10, #0x6086, LSL #0
    MOVK  X10, #0x7d94, LSL #16
    MOVK  X10, #0x2b48, LSL #32
    MOVK  X10, #0xe668, LSL #48
    MOVZ  X11, #0xbfc8, LSL #0
    MOVK  X11, #0x278f, LSL #16
    MOVK  X11, #0x944, LSL #32
    MOVK  X11, #0x1ef1, LSL #48
    MOVZ  X12, #0x9a9f, LSL #0
    MOVK  X12, #0xc869, LSL #16
    MOVK  X12, #0x2d13, LSL #32
    MOVK  X12, #0xa57d, LSL #48
    MOVZ  X13, #0xd426, LSL #0
    MOVK  X13, #0x7d39, LSL #16
    MOVK  X13, #0x804d, LSL #32
    MOVK  X13, #0x396d, LSL #48
    MOVZ  X14, #0x2d65, LSL #0
    MOVK  X14, #0xf679, LSL #16
    MOVK  X14, #0x5373, LSL #32
    MOVK  X14, #0x9349, LSL #48
    MOVZ  X15, #0x2855, LSL #0
    MOVK  X15, #0x3c4c, LSL #16
    MOVK  X15, #0x2298, LSL #32
    MOVK  X15, #0x2492, LSL #48
    MOVZ  X16, #0x828, LSL #0
    MOVK  X16, #0x4824, LSL #16
    MOVK  X16, #0x402c, LSL #32
    MOVK  X16, #0x9cdb, LSL #48
    MOVZ  X17, #0xeb13, LSL #0
    MOVK  X17, #0x8806, LSL #16
    MOVK  X17, #0x1c7e, LSL #32
    MOVK  X17, #0xaf08, LSL #48
    MOVZ  X18, #0x5a9c, LSL #0
    MOVK  X18, #0x44aa, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xa4ce, LSL #48
    MOVZ  X19, #0x2ee, LSL #0
    MOVK  X19, #0xcf74, LSL #16
    MOVK  X19, #0x12f4, LSL #32
    MOVK  X19, #0xc291, LSL #48
    MOVZ  X20, #0x2823, LSL #0
    MOVK  X20, #0xa618, LSL #16
    MOVK  X20, #0x613f, LSL #32
    MOVK  X20, #0x575, LSL #48
    MOVZ  X21, #0x903e, LSL #0
    MOVK  X21, #0x1795, LSL #16
    MOVK  X21, #0x1900, LSL #32
    MOVK  X21, #0xe4c7, LSL #48
    MOVZ  X22, #0xc778, LSL #0
    MOVK  X22, #0x4993, LSL #16
    MOVK  X22, #0x4246, LSL #32
    MOVK  X22, #0x55ab, LSL #48
    MOVZ  X23, #0x8776, LSL #0
    MOVK  X23, #0xfaf4, LSL #16
    MOVK  X23, #0xddba, LSL #32
    MOVK  X23, #0x4bc3, LSL #48
    MOVZ  X24, #0x98c6, LSL #0
    MOVK  X24, #0x366d, LSL #16
    MOVK  X24, #0x93b6, LSL #32
    MOVK  X24, #0x4eaf, LSL #48
    MOVZ  X25, #0xa624, LSL #0
    MOVK  X25, #0x83ac, LSL #16
    MOVK  X25, #0x6753, LSL #32
    MOVK  X25, #0x99e9, LSL #48
    MOVZ  X26, #0x1f27, LSL #0
    MOVK  X26, #0x6b77, LSL #16
    MOVK  X26, #0x99fc, LSL #32
    MOVK  X26, #0x325a, LSL #48
    MOVZ  X27, #0xa2c6, LSL #0
    MOVK  X27, #0x83cd, LSL #16
    MOVK  X27, #0x46e7, LSL #32
    MOVK  X27, #0xcdb8, LSL #48
    MOVZ  X28, #0xaff3, LSL #0
    MOVK  X28, #0x7063, LSL #16
    MOVK  X28, #0x857, LSL #32
    MOVK  X28, #0xc80d, LSL #48
    MOVZ  X29, #0x58a, LSL #0
    MOVK  X29, #0xfe94, LSL #16
    MOVK  X29, #0xf7f7, LSL #32
    MOVK  X29, #0x8906, LSL #48
    MOVZ  X22, #0x14, LSL #0
TaishanIntMduP01_label_553:
    EON  W15, W28, W21, LSR #26
    ADD  W23, W5, #0xf21, LSL #12
    BICS  X7, X23, X25, ASR #63
    SMULH  X28, X9, X18
    SUBS  X28, X24, W14, SXTW #3
    EOR  W19, W7, W7, LSL #15
    CLZ  V30.8B, V4.8B
    ADD  X21, X23, X29, LSR #37
    SUB  X25, X18, #0x79b, LSL #12
    ADD  X28, X11, X11, LSR #20
    BIC  V4.8B, V1.8B, V22.8B
    CLS  V5.8H, V15.8H
    SBFM  X6, X22, #0x3, #0x21
    AND  W25, W5, #0x1fffffe0
    ORN  W16, W27, W7, LSR #2
    ANDS  X3, X29, X24, LSL #5
    MOVZ  W26, #0xdc46, LSL #16
    UMADDL  X15, W9, W11, X9
    LSRV  W29, W19, W16
    SUBS  W10, W21, #0xc67
    CLS  W21, W23
    ORR  X7, X19, #0xfffffe000003ffff
    MOVK  X3, #0x6979, LSL #16
    BICS  W14, W7, W23, ASR #27
    LSLV  W26, W26, W15
    CRC32CX  W26, W7, X21
    MOVK  X23, #0x5c7d, LSL #32
    LSLV  W7, W3, W6
    CLS  X2, X9
    SUBS  W14, W18, W14, LSL #19
    BIC  X10, X2, X11, ASR #36
    CLZ  V12.16B, V15.16B
    ANDS  W6, W20, #0x38000000
    AND  W14, W3, #0x7f807f80
    CRC32CH  W26, W29, W24
    ORR  X15, X19, #0x3fffff00000
    LSRV  X3, X2, X25
    SUB  X23, X21, W14, UXTB #2
    ADD  X27, X13, W9, SXTH #2
    CLZ  W6, W28
    CSEL  X8, X13, X12, LT
    BICS  X21, X22, X7, ROR #41
    ADCS  X10, X19, X25
    CLS  X13, X10
    CSINV  X8, X19, X8, PL
    AND  X29, X5, #0x78000000780000
    ADD  X2, X20, X16, ASR #3
    AND  W25, W16, W25, LSR #14
    ADD  X25, X28, #0x7e8
    CRC32CB  W14, W29, W25
    CLS  V18.8B, V10.8B
    BICS  W27, W24, W24, LSR #18
    BICS  W2, W20, W27, LSL #12
    ADCS  W10, W19, W24
    AND  W16, W21, #0xc1c1c1c1
    ADDS  X8, X20, X15, LSL #20
    LSRV  X2, X15, X23
    CSINC  X14, X2, X6, LE
    SBFM  X5, X22, #0x26, #0x2a
    EOR  W7, W5, #0xf9fff9ff
    ANDS  X16, X12, #0x3ffc00003ffc00
    ORR  X10, X17, #0x1ffffe00000000
    ADC  W10, W16, W28
    BICS  W16, W26, W16, LSL #5
    SBFM  X14, X9, #0x39, #0x3f
    ADDS  X27, X12, W27, SXTW #0
TaishanIntMduP01_label_405:
    ADDS  X5, X15, X22, ASR #22
    CRC32H  W7, W2, W19
    CSINC  X7, X9, X26, GE
    AND  X20, X19, X5, ASR #2
    UBFM  W15, W28, #0x1a, #0xa
    ADDS  X25, X18, X8, LSL #6
    MOVK  W14, #0x4c19, LSL #0
    EOR  W17, W29, W10, ROR #5
    BIC  X6, X9, X27, LSR #25
    CLS  X19, X13
    AND  W7, W10, #0x1fc0
    ORN  W17, W16, W14, ROR #4
    MOVK  X21, #0x6421, LSL #48
    ORN  X18, X7, X6, LSR #6
    SMULH  X21, X7, X17
    ORN  X16, X26, X28, ROR #23
    ORR  V0.4S, #0x94, LSL #16
    LSLV  X25, X13, X19
    ADDS  W13, W5, W18, LSR #5
    EOR  W18, W19, W19, ASR #28
    CSNEG  X16, X15, X7, VS
    ADDS  X12, X21, W8, SXTW #0
    SUBS  W12, W8, W21, SXTW #1
    ADD  X26, X25, X22, LSL #6
    ADDS  W13, W2, #0x496, LSL #12
    CLZ  X20, X18
    ADDS  W5, W22, #0xfea, LSL #12
    MOVN  X18, #0xeba6, LSL #16
    SUB  W27, W27, W24, ASR #1
    LSLV  W10, W13, W5
    BIC  W16, W20, W6, ROR #9
    ASRV  X20, X9, X7
    CRC32W  W9, W8, W8
    ORN  X20, X17, X25, ASR #38
    SMSUBL  X29, W12, W16, X22
    SUBS  X10, X24, #0xe7a, LSL #12
    CSNEG  W28, W23, W3, NV
    ADD  W16, W2, #0xb9b, LSL #12
    SUBS  W28, W24, #0xa40
    AND  X15, X6, X7, ASR #5
    BICS  W16, W2, W23, ROR #19
    ADD  X2, X7, X24, UXTX #2
    ADD  W3, W10, W5, UXTB #3
    UMADDL  X25, W14, W13, X16
    CSINV  W21, W11, W23, CC
    SUBS  W15, W25, W23, LSL #25
    CSEL  W8, W15, W10, LS
    ORR  W12, W3, #0x66666666
    CRC32W  W16, W27, W22
    EON  W5, W25, W24, LSL #8
    ORR  V31.8B, V5.8B, V22.8B
    CRC32W  W9, W16, W17
    MADD  W14, W17, W27, W28
    CLS  V3.4H, V17.4H
    LSRV  X23, X21, X27
    BIC  W17, W17, W28, ROR #27
    EXTR  X19, X27, X18, #0xd
    ADD  X24, X25, X8, ASR #12
    ANDS  W23, W20, #0x1ffffff
    SUB  W26, W6, #0xed0
    MADD  W12, W7, W21, W22
    ADD  W26, W27, #0x1a0
    ADC  W16, W5, W28
    UBFM  X6, X2, #0x20, #0x1f
    ADCS  W29, W23, W24
    MADD  X28, X19, X26, X29
    ANDS  X27, X7, X6, ROR #44
    ANDS  X11, X3, X12, LSR #23
    MOVN  W11, #0xacc8, LSL #0
    ADDS  W15, W6, #0x4fd
    ADC  W6, W27, W9
    UBFM  X20, X2, #0x34, #0x3a
    ORR  W5, W17, #0xffffe01f
    SUBS  X14, X2, W12, SXTW #0
    ADD  X15, X16, X9, SXTX #2
    CRC32CX  W13, W23, X17
    ADD  X28, X11, #0xe10
    BICS  W24, W5, W11, ASR #28
    ADC  X6, X25, X19
    CSINC  W24, W19, W8, HI
    UMADDL  X20, W12, W3, X24
    BIC  W28, W12, W2, LSR #30
    CRC32CX  W14, W8, X15
    ORR  X29, X6, X2, LSR #36
    ADD  X9, X6, X20, ASR #21
    SUBS  W25, W9, W20, LSL #15
    AND  X13, X3, X7, LSR #63
    ADD  W12, W29, W22, SXTB #4
    BICS  W23, W21, W27, ROR #14
    ADD  W23, W29, #0x3f0
    SMULH  X23, X22, X29
    CRC32CB  W28, W21, W19
    SUBS  X5, X21, #0x53f, LSL #12
    ADDS  X13, X18, X2, LSL #63
    ADC  X27, X16, X23
    CSNEG  X2, X27, X11, MI
    CLZ  X27, X6
    SMSUBL  X13, W10, W18, X5
    EON  X17, X14, X23, LSR #16
    ANDS  X12, X9, X29, LSR #43
    SUB  X8, X2, #0x661, LSL #12
    CRC32H  W6, W27, W8
    ANDS  X16, X14, X24, ROR #62
    UMULH  X25, X6, X21
    SUBS  W25, W14, #0x9fe, LSL #12
    SUB  X25, X17, #0xf7, LSL #12
    AND  W17, W12, W25, ASR #18
    MOVZ  X20, #0x782b, LSL #0
    ADDS  W18, W12, W2, UXTH #4
    CSINC  X10, X6, X16, LE
    CSINV  W9, W20, W13, LE
    ADCS  X18, X26, X17
    ORR  V7.8B, V16.8B, V2.8B
    CRC32CB  W19, W28, W7
    UMADDL  X18, W14, W12, X7
    MADD  X3, X12, X8, X16
    EOR  W13, W13, #0x22222222
    ADCS  W18, W10, W14
    EXTR  X28, X15, X29, #0x34
    ADDS  X9, X16, #0xd52, LSL #12
    ADC  W15, W19, W25
    LSLV  W9, W19, W7
    MOVN  X25, #0xcc02, LSL #32
    UMSUBL  X18, W7, W17, X6
    ADDS  X26, X13, X6, ASR #44
    UMSUBL  X26, W26, W6, X28
    UBFM  W8, W3, #0x14, #0x1a
    MOVZ  W18, #0xbd14, LSL #16
    LSLV  X20, X6, X20
    SUB  W14, W23, W20, LSR #24
    ASRV  X19, X18, X14
    LSLV  W3, W11, W21
    MOVZ  W15, #0xf5ce, LSL #16
    SMSUBL  X8, W16, W6, X21
    SUBS  X22, X22, #0x1
    B.NE  TaishanIntMduP01_label_553
    MOVZ  X13, #0x1597, LSL #0
    MOVK  X13, #0x2a9e, LSL #16
    SUB  X28, X13, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x9b80, LSL #16
    SUB  X13, X7, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x6337, LSL #0
    MOVK  X26, #0xffab, LSL #16
    SUB  X17, X26, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X22, #0xe852, LSL #0
    MOVK  X22, #0x4e6a, LSL #16
    SUB  X3, X22, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x9b80, LSL #16
    SUB  X21, X23, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP01_TestFail
    MOVZ  X8, #0xd067, LSL #0
    MOVK  X8, #0xe69f, LSL #16
    MOVK  X8, #0xae50, LSL #32
    MOVK  X8, #0x271b, LSL #48
    SUB  X23, X8, X8
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x3b1e, LSL #0
    MOVK  X12, #0x9bfb, LSL #16
    SUB  X3, X12, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x2329, LSL #0
    MOVK  X21, #0x8054, LSL #16
    SUB  X9, X21, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X8, #0x5337, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X27, X8, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x3b1e, LSL #0
    MOVK  X12, #0x9bfb, LSL #16
    SUB  X11, X12, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X20, X13, X13
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X28, X3, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xf5ce, LSL #16
    SUB  X27, X15, X15
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X27, #0x2328, LSL #0
    MOVK  X27, #0x8054, LSL #16
    SUB  X3, X27, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0xbd14, LSL #16
    SUB  X5, X22, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X19
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X16, #0x2329, LSL #0
    MOVK  X16, #0x8054, LSL #16
    SUB  X5, X16, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xbd14, LSL #16
    SUB  X13, X25, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X11, X23, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X27, #0x18da, LSL #0
    MOVK  X27, #0x2455, LSL #16
    SUB  X8, X27, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xbd14, LSL #16
    SUB  X21, X24, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X26
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x18da, LSL #0
    MOVK  X12, #0x2455, LSL #16
    SUB  X5, X12, X27
TaishanIntMduP01_label_151:
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X24, X9, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X10, #0x14, LSL #0
TaishanIntMduP01_label_578:
    SUBS  X6, X29, X28, UXTX #0
    SUBS  W14, W25, W10, UXTW #2
    LSLV  X23, X3, X21
    MOVN  W24, #0xe8ff, LSL #16
    MOVK  X21, #0x841, LSL #16
    SMULH  X11, X7, X14
    ANDS  X12, X27, #0x7ffffffffe0000
    ORR  V15.16B, V24.16B, V26.16B
    LSRV  W27, W23, W24
    EXTR  X12, X22, X7, #0xa
    EXTR  X27, X10, X26, #0x1f
    CRC32CX  W14, W7, X22
    CRC32CW  W22, W24, W16
    ADCS  W26, W14, W5
    ADDS  X21, X12, #0x104, LSL #12
    BIC  V0.16B, V15.16B, V14.16B
    ASRV  X20, X26, X24
    CSINC  X3, X5, X15, CS
    BIC  W15, W6, W6, ASR #11
    ADCS  X25, X7, X20
    CLS  X20, X19
    SUB  X3, X15, X25, ASR #3
    SMULH  X8, X7, X6
    SUB  X19, X15, #0x80e
    AND  W25, W18, W24, ROR #19
    CSINC  W15, W27, W13, GE
    CSEL  X6, X21, X22, LT
    ANDS  X13, X18, #0xf8001ffff8001fff
    ADD  X12, X28, #0xac7, LSL #12
    SUB  W26, W24, W8, SXTX #4
    CLZ  V12.8H, V24.8H
    SMSUBL  X19, W12, W26, X27
    ORR  V26.8H, #0xb
    ADD  W27, W20, W18, SXTX #3
    ADD  W3, W16, W15, SXTB #2
    CRC32CW  W7, W18, W5
    CRC32CW  W19, W22, W20
    LSRV  W8, W5, W29
    LSLV  X11, X28, X24
    SUBS  X16, X27, W11, SXTB #3
    ASRV  W16, W7, W20
    BIC  X28, X3, X29, LSL #60
    ADC  X12, X8, X2
    UBFM  W19, W25, #0x17, #0x15
    ADD  X18, X15, X20, LSR #45
    ADDS  W15, W2, W12, LSL #4
    SUB  W13, W7, #0xbba, LSL #12
    SUB  X6, X20, X8, UXTX #1
    SBFM  X18, X24, #0x3a, #0xa
    MADD  X3, X9, X18, X25
    LSRV  W20, W6, W12
    SUBS  W15, W14, W29, SXTH #3
    SMADDL  X5, W27, W7, X27
    ADCS  X29, X2, X11
    ASRV  W16, W7, W7
    BICS  X3, X22, X5, ASR #3
    CLZ  V30.4S, V24.4S
    CLZ  V27.8H, V9.8H
    CSINC  X26, X28, X2, CS
    EXTR  X19, X11, X24, #0x1e
    ADDS  W29, W20, W13, SXTB #1
    EON  X16, X17, X2, ASR #7
    ADDS  W6, W3, #0x498, LSL #12
    ORR  V24.8B, V17.8B, V16.8B
    BIC  V31.8B, V23.8B, V0.8B
    ORR  W6, W21, W24, ROR #8
    CSNEG  W21, W26, W8, LE
    SMSUBL  X18, W23, W19, X29
    ADC  X13, X28, X19
    CRC32CX  W6, W22, X23
    ADC  X27, X26, X26
    UMSUBL  X3, W11, W14, X26
    CRC32CW  W14, W5, W21
    EXTR  W9, W19, W17, #0x1c
    CRC32CW  W22, W25, W24
    CSNEG  W2, W18, W18, EQ
    ADD  X20, X23, #0xa20
    CSINC  W14, W22, W27, CC
    SMULH  X27, X28, X12
    CSINV  X27, X13, X5, NE
    CLS  W22, W16
    EXTR  W28, W16, W25, #0x17
    ORR  V22.8B, V0.8B, V15.8B
    SUBS  X5, X20, X20, LSR #53
    MOVZ  X2, #0x8787, LSL #16
    ORR  V28.2S, #0xaa, LSL #8
    CSINV  X22, X6, X19, LT
    CRC32W  W25, W23, W27
    ADDS  X14, X17, X11, LSR #32
    EOR  X26, X3, X13, LSR #41
    CSINC  W25, W18, W8, CC
    EOR  W29, W10, #0x7c
    MOVN  X5, #0xb549, LSL #16
    ANDS  W9, W28, W20, ASR #25
    ADCS  W24, W19, W29
    UMULH  X24, X19, X18
    ORN  W17, W20, W22, ROR #19
    BIC  X27, X14, X5, LSL #4
    EOR  W9, W18, #0x80ff80ff
    ADD  W3, W20, #0xeed, LSL #12
    CRC32CH  W27, W11, W28
    ADDS  X5, X6, #0xaec
    SUBS  W22, W13, W13, UXTW #2
    ADD  W25, W7, W6, LSR #10
    ADD  X8, X11, X13, SXTX #1
    BICS  X19, X12, X9, LSL #16
    ORR  V15.16B, V10.16B, V4.16B
    ANDS  X9, X13, X14, ASR #31
    UBFM  W20, W27, #0xe, #0x6
    UMADDL  X27, W20, W16, X12
    ANDS  W11, W23, #0xf807ffff
    ADCS  X18, X22, X20
    EXTR  W23, W29, W5, #0x18
    SMULH  X19, X3, X26
    ADCS  X2, X18, X24
    ANDS  X28, X13, X18, LSL #5
    SUBS  W19, W17, W6, UXTW #4
    CRC32B  W26, W25, W20
    ORR  X22, X26, #0xfffffffffff8001f
    MADD  W7, W24, W5, W25
    CSINC  W9, W22, W29, AL
    CRC32W  W5, W29, W25
    SUB  X12, X2, W13, SXTW #1
    ORR  V22.4S, #0xc1, LSL #16
    MOVZ  X28, #0xa1ed, LSL #32
    ADD  W20, W9, #0xd10
    CRC32CX  W27, W28, X9
    MOVN  X14, #0x7bc4, LSL #48
    ADC  W9, W7, W9
    ORR  V26.4S, #0x85, LSL #16
    MOVK  X2, #0xd4fa, LSL #0
    MOVZ  X25, #0xcff, LSL #32
    MOVN  X12, #0xdb8, LSL #16
    SUBS  W9, W27, W3, ASR #23
    CSNEG  W7, W23, W3, NV
    CLZ  V17.4S, V31.4S
    CRC32CW  W27, W15, W9
    SUBS  X27, X19, X19, LSL #9
    ORR  V7.2S, #0x65, LSL #16
    BIC  X21, X26, X13, ROR #33
    ADD  W29, W28, W28, SXTX #0
    ADDS  W6, W15, #0x8b0
    SBFM  X12, X3, #0xd, #0x5
    CSINC  W15, W13, W13, NE
    CSNEG  X28, X11, X20, GE
    ADD  W14, W23, W14, UXTB #3
    ADCS  X12, X21, X25
    MOVZ  X26, #0x59bb, LSL #16
    SMULH  X12, X18, X9
    CRC32CW  W26, W13, W8
    MOVK  W3, #0x5b1b, LSL #0
    ADD  W25, W15, #0xbeb
    SUB  W20, W29, #0x828, LSL #12
    ASRV  W19, W12, W17
    MOVN  X13, #0x274, LSL #48
    ADD  W15, W12, #0xf90, LSL #12
    CLZ  X19, X27
    ASRV  W9, W17, W13
    SUB  X23, X10, W5, SXTH #0
    ORN  X9, X17, X12, LSL #60
    AND  W21, W15, #0x1000100
    LSRV  W27, W12, W2
    ANDS  W11, W8, #0xfffcfffc
    EOR  W3, W13, W20, ROR #22
    UMADDL  X22, W5, W9, X15
    CRC32B  W14, W15, W5
    LSLV  X23, X2, X19
    ADD  X28, X21, #0x310
    MOVN  X2, #0xa2c1, LSL #48
    LSRV  X23, X27, X25
    CLZ  X14, X11
    CRC32X  W14, W26, X8
    ANDS  X5, X5, #0xf01ffffff01fffff
    ASRV  X22, X26, X15
    UBFM  W5, W12, #0x1f, #0x1d
    ORR  W22, W14, W17, LSR #4
    BICS  X3, X3, X12, ROR #2
    ANDS  W23, W9, W11, ROR #20
    CLZ  W25, W26
    SUB  X28, X25, #0x5fe, LSL #12
    ORR  W17, W11, #0x22222222
    MOVK  W14, #0x6ac0, LSL #16
    SUB  W29, W12, #0x1ee, LSL #12
    MOVZ  X9, #0xf8e1, LSL #0
    ORR  V29.8B, V16.8B, V5.8B
    UMSUBL  X5, W9, W13, X8
    CSEL  X2, X23, X26, LS
    CRC32CX  W9, W3, X19
    SUBS  X21, X6, #0x34b
    CRC32H  W21, W18, W21
    ADD  X20, X11, X7, UXTX #1
    EOR  W22, W19, #0x18001800
    SMSUBL  X25, W10, W14, X15
    CRC32CX  W8, W3, X7
    SMSUBL  X25, W23, W17, X5
    ORR  W28, W20, #0xff8000
    SUB  W26, W12, W26, UXTB #4
    ADDS  X18, X22, X8, LSL #54
    UMSUBL  X13, W11, W5, X18
    ADDS  W12, W28, W22, LSL #1
    SUBS  X10, X10, #0x1
    B.NE  TaishanIntMduP01_label_578
    MOVZ  X25, #0x8a88, LSL #0
    MOVK  X25, #0x8888, LSL #16
    SUB  X3, X25, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X11, X3, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X18, #0x8169, LSL #0
    MOVK  X18, #0xa889, LSL #16
    MOVK  X18, #0x71f, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X14, X18, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X8, #0xfe5d, LSL #0
    MOVK  X8, #0xa30a, LSL #16
    SUB  X22, X8, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP01_TestFail
    MOVZ  X14, #0x7dbb, LSL #0
    SUB  X8, X14, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X19, #0xf858, LSL #0
    MOVK  X19, #0x1ba1, LSL #16
    SUB  X22, X19, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X23, X15, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP01_TestFail
    MOVZ  X8, #0xb3fe, LSL #0
    MOVK  X8, #0xd8ff, LSL #16
    SUB  X17, X8, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X13, #0x9038, LSL #0
    MOVK  X13, #0xda6b, LSL #16
    MOVK  X13, #0xe023, LSL #32
    MOVK  X13, #0x734b, LSL #48
    SUB  X6, X13, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X24, X8, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x4440, LSL #0
    MOVK  X2, #0x5444, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X7, X2, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x8169, LSL #0
    MOVK  X12, #0xa889, LSL #16
    MOVK  X12, #0x71f, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X21, X12, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP01_TestFail
    MOVZ  X25, #0xf858, LSL #0
    MOVK  X25, #0x1ba1, LSL #16
    SUB  X29, X25, X19
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x83fe, LSL #0
    MOVK  X21, #0xa889, LSL #16
    SUB  X6, X21, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X25, #0x83fe, LSL #0
    MOVK  X25, #0xa889, LSL #16
    SUB  X18, X25, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X24
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP01_TestFail
    MOVZ  X6, #0x83fe, LSL #0
    MOVK  X6, #0xa889, LSL #16
    SUB  X15, X6, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP01_TestFail
    MOVZ  X23, #0xf4c0, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X7, X23, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
TaishanIntMduP01_label_500:
    MOVZ  X16, #0x83fe, LSL #0
    MOVK  X16, #0xa8ff, LSL #16
    SUB  X25, X16, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    MOVZ  X6, #0xa, LSL #0
TaishanIntMduP01_label_604:
    CLS  W8, W19
    CLZ  V18.16B, V7.16B
    CLS  W23, W20
    ORN  W26, W13, W24, ASR #22
    CLS  V0.16B, V11.16B
    ANDS  W21, W24, W6, LSL #12
    CSEL  X22, X16, X28, CS
    CLS  W27, W24
    CSINV  X9, X22, X19, MI
    MOVK  X9, #0x72cb, LSL #16
    SUB  X3, X19, X26, UXTX #4
    CLS  X18, X23
    ADD  X21, X8, #0xcb
    ADDS  W27, W9, #0xe1b
    ORR  X24, X11, #0x3333333333333333
    SUB  X7, X6, #0x0
    SUB  X2, X3, W29, SXTB #2
    ORN  W26, W27, W9, LSR #18
    ADDS  X21, X26, #0xe7a, LSL #12
    UMSUBL  X19, W2, W7, X8
    EON  W22, W29, W20, ROR #5
    CSNEG  X24, X24, X28, PL
    SMULH  X15, X15, X11
    CLS  X27, X15
    EXTR  W20, W2, W16, #0x7
    SUBS  W21, W24, W13, ASR #2
    UMSUBL  X19, W24, W26, X16
    ADCS  X19, X21, X9
    SUBS  W24, W18, W27, SXTX #0
    ORR  W26, W24, #0x3fe03fe0
    BICS  X22, X29, X9, ROR #20
    CSEL  X2, X6, X20, VS
    BICS  W12, W16, W7, ASR #17
    CLZ  X8, X12
    ADDS  W25, W12, W2, UXTX #2
    SUB  X25, X10, W7, UXTH #1
    SUB  X17, X23, #0x8af
    MOVN  W21, #0x46ca, LSL #16
    AND  X29, X21, X13, ROR #55
    CRC32CW  W24, W26, W27
    CLS  V28.2S, V15.2S
    CSINC  X17, X20, X22, LT
    EXTR  X18, X29, X17, #0x25
    UMADDL  X29, W10, W2, X18
    ADCS  X27, X19, X10
    SUBS  X25, X12, X28, LSL #7
    BIC  X2, X8, X15, ROR #14
    MOVZ  X7, #0x2f9a, LSL #32
    SUBS  W7, W3, W12, LSR #7
    ADDS  X17, X20, W11, UXTH #1
    CSINV  W25, W16, W28, NE
    SUBS  W24, W11, W12, LSR #10
    AND  W28, W17, #0x7ffffff0
    MOVN  X19, #0x2a13, LSL #32
    LSRV  W19, W18, W5
    SUB  W15, W13, W16, LSR #27
    CLZ  V4.16B, V10.16B
    CSEL  X7, X26, X23, GT
    BIC  X12, X25, X23, ROR #13
    ASRV  W8, W28, W23
    SUB  X26, X7, X15, ASR #5
    MOVN  X22, #0x57b8, LSL #48
    ADD  W20, W26, W2, SXTH #4
    LSLV  X27, X3, X22
    CLS  V1.16B, V14.16B
    ANDS  X28, X3, X15, LSL #54
    ORR  X11, X5, X16, LSR #12
    CSINV  W19, W29, W16, LE
    ORR  W26, W22, W23, ASR #30
    SUBS  W3, W28, #0x872
    LSRV  X5, X8, X24
    ADDS  X27, X2, W16, SXTW #2
    ADC  W20, W9, W20
    ADDS  X5, X15, W18, UXTW #3
    ANDS  X12, X11, #0xfffffffffffffff8
    CSINV  W12, W6, W17, MI
    MOVN  W3, #0x62fb, LSL #0
    ANDS  X3, X5, #0xff8000000000001f
    SMSUBL  X22, W28, W2, X25
    ADDS  W13, W3, W29, LSR #29
    ANDS  W16, W11, W15, LSR #12
    SMADDL  X8, W29, W14, X17
    MOVK  W23, #0x65b3, LSL #0
    SUBS  X10, X6, X5, LSR #14
    EON  X9, X9, X23, LSL #55
    ADC  X15, X9, X15
    CRC32X  W27, W26, X27
    MOVN  X26, #0x57d9, LSL #0
    SMADDL  X25, W13, W21, X19
    SUB  W13, W14, W15, SXTB #2
    ADDS  W22, W20, W11, SXTB #2
    SUBS  X11, X9, X19, LSL #19
    CRC32X  W28, W11, X18
    UMADDL  X22, W26, W12, X5
    ADDS  X22, X13, X5, LSL #37
    SBFM  X7, X5, #0x28, #0x1b
    CLZ  W8, W23
    UBFM  X29, X27, #0xb, #0x26
    UMULH  X17, X11, X24
    ADDS  X17, X18, W11, SXTB #1
    EON  X17, X7, X6, ASR #54
    CLZ  X8, X10
    CLS  W16, W19
    EOR  X13, X17, X25, LSL #26
    CLZ  W13, W6
    CRC32CX  W29, W5, X29
    UMULH  X29, X27, X16
    CRC32H  W9, W13, W3
    BIC  V6.16B, V30.16B, V15.16B
    SUB  W7, W8, W13, LSL #6
    EOR  W10, W27, W23, ASR #7
    CRC32CH  W24, W10, W9
    CLS  W11, W21
    ADD  X28, X16, #0xa92, LSL #12
    CRC32H  W13, W28, W28
    CSINC  X16, X23, X13, GT
    ADCS  W10, W8, W29
    SBFM  W12, W11, #0x16, #0x17
    MADD  X17, X23, X9, X18
    ORR  X5, X17, #0x7ffffffffffffff0
    AND  W14, W21, W29, ASR #0
    SUBS  X22, X22, X3, UXTX #2
    AND  W14, W7, #0x66666666
    LSRV  W15, W20, W22
    SUB  W12, W23, W18, ASR #16
    ADD  W9, W19, W15, ASR #14
    LSRV  X21, X20, X9
    ADDS  W17, W26, #0x55, LSL #12
    ADC  W2, W21, W3
    ADCS  W17, W17, W6
    SUB  X14, X11, X11, LSL #35
    ADDS  X24, X11, #0xd5b
    AND  W14, W25, W26, LSL #16
    CSNEG  W3, W25, W2, VC
    SUBS  W2, W18, W19, UXTH #4
    MOVK  W17, #0xbe29, LSL #0
    AND  W11, W12, #0xfc003fff
    MADD  W3, W19, W13, W3
    CSINV  X24, X24, X2, VC
    SUB  X17, X18, #0x573
    CRC32CW  W19, W20, W11
    ADD  W29, W22, W29, SXTB #0
    ADDS  X5, X29, X19, LSL #26
    SUBS  X20, X7, #0x47b
    CSINC  W19, W26, W20, GT
    CLS  W3, W5
    SUB  W23, W22, #0x50
    SMULH  X17, X18, X9
    CLS  X18, X15
    ADDS  X11, X20, W24, SXTH #2
    CSINV  W14, W26, W23, VC
    SUBS  W5, W2, #0x8a6, LSL #12
    BICS  X25, X20, X15, LSR #60
    UMULH  X16, X29, X3
    CSINC  W5, W11, W25, VC
    SUBS  X26, X3, #0xf20
    AND  W9, W13, W18, ROR #13
    EOR  W7, W26, W24, ASR #30
    CRC32W  W25, W12, W6
    ADDS  X5, X17, X14, LSR #4
    MOVZ  W18, #0xdf9a, LSL #16
    CRC32CW  W9, W3, W9
    ANDS  X16, X17, X3, LSL #34
    ANDS  X17, X17, #0x1800000018000000
    EON  W18, W13, W22, LSL #1
    CLZ  X17, X20
    ADC  X13, X23, X25
    AND  X5, X28, X8, LSL #5
    CLS  W22, W14
    ORN  X29, X12, X16, ASR #32
    ORN  X14, X18, X17, LSL #12
    MOVK  X24, #0x6705, LSL #32
    EOR  X2, X3, #0x7fffffe0000
    CLS  X28, X6
    CSINV  W29, W3, W15, LE
    LSRV  X23, X15, X11
    ADDS  W13, W16, W7, SXTH #3
    CSNEG  W20, W13, W11, LS
    ORR  W19, W13, #0xe000e0
    MADD  X9, X14, X26, X7
    EXTR  W13, W12, W14, #0x1
    UBFM  X7, X6, #0x14, #0x26
    CRC32H  W27, W6, W21
    MOVN  X22, #0xf0e2, LSL #32
    ADD  W5, W13, #0x161, LSL #12
    MOVZ  W27, #0xe22b, LSL #0
    ORR  X3, X5, X22, ASR #27
    CLS  W29, W27
    ADCS  W25, W9, W23
    BICS  X12, X19, X3, LSL #9
    CRC32CH  W3, W2, W18
    EOR  X19, X7, X21, LSR #56
    MOVK  W23, #0x6ad0, LSL #16
    SUB  X15, X22, X19, LSL #10
    ADD  W24, W2, W26, UXTX #3
    SUB  W18, W13, W2, LSL #31
    ADD  W16, W7, W15, UXTB #0
    CSNEG  X29, X7, X7, CS
    SBFM  W9, W7, #0x3, #0x1b
    SUB  X16, X18, X21, LSR #63
    SUBS  X6, X6, #0x1
    B.NE  TaishanIntMduP01_label_604
    MOVZ  X8, #0x4, LSL #0
    MOVK  X8, #0xfffe, LSL #16
    MOVK  X8, #0x7ff, LSL #32
    SUB  X13, X8, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x1730, LSL #0
    MOVK  X2, #0xfaab, LSL #16
    SUB  X22, X2, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP01_TestFail
    MOVZ  X10, #0xfff, LSL #0
    MOVK  X10, #0x16, LSL #16
    SUB  X6, X10, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP01_TestFail
    MOVZ  X17, #0x4, LSL #0
    MOVK  X17, #0xfffe, LSL #16
    MOVK  X17, #0x7ff, LSL #32
    SUB  X2, X17, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X23, #0xfff, LSL #0
    MOVK  X23, #0x16, LSL #16
    SUB  X5, X23, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X7, #0x2931, LSL #0
    MOVK  X7, #0x1, LSL #32
    SUB  X3, X7, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X28, X8, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X13, X17, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xf1d, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X10, X23, X15
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X7, X22, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X15, X17, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X3, X24, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X6, X23, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X19, #0x8720, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X27, X19, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x10, LSL #0
    MOVK  X21, #0x6acc, LSL #16
    SUB  X25, X21, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X16, X3, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X6, X10, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X24, X8, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP01_TestFail
    MOVZ  X27, #0xf0e4, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X6, X27, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X16, #0xf0e4, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X8, X16, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X2, #0xe73b, LSL #0
    MOVK  X2, #0x6f7c, LSL #16
    MOVK  X2, #0x3ba0, LSL #32
    MOVK  X2, #0xd5e6, LSL #48
    MOVZ  X3, #0x105, LSL #0
    MOVK  X3, #0xc02c, LSL #16
    MOVK  X3, #0x68b4, LSL #32
    MOVK  X3, #0x3070, LSL #48
    MOVZ  X5, #0xdc86, LSL #0
    MOVK  X5, #0x262f, LSL #16
    MOVK  X5, #0xc68b, LSL #32
    MOVK  X5, #0xe551, LSL #48
    MOVZ  X6, #0xc7b8, LSL #0
    MOVK  X6, #0x3aaf, LSL #16
    MOVK  X6, #0x2340, LSL #32
    MOVK  X6, #0x7638, LSL #48
    MOVZ  X7, #0x1280, LSL #0
    MOVK  X7, #0x715, LSL #16
    MOVK  X7, #0x2023, LSL #32
    MOVK  X7, #0xd21b, LSL #48
    MOVZ  X8, #0xa7f3, LSL #0
    MOVK  X8, #0x30d4, LSL #16
    MOVK  X8, #0xb0da, LSL #32
    MOVK  X8, #0x775a, LSL #48
    MOVZ  X9, #0x6238, LSL #0
    MOVK  X9, #0xbed6, LSL #16
    MOVK  X9, #0x756f, LSL #32
    MOVK  X9, #0x4693, LSL #48
    MOVZ  X10, #0xfaf2, LSL #0
    MOVK  X10, #0x59b6, LSL #16
    MOVK  X10, #0x82d3, LSL #32
    MOVK  X10, #0xadc4, LSL #48
    MOVZ  X11, #0xe74c, LSL #0
    MOVK  X11, #0xcf0f, LSL #16
    MOVK  X11, #0xdaef, LSL #32
    MOVK  X11, #0xdaab, LSL #48
    MOVZ  X12, #0x2d37, LSL #0
    MOVK  X12, #0x9df8, LSL #16
    MOVK  X12, #0x5a85, LSL #32
    MOVK  X12, #0x4a39, LSL #48
    MOVZ  X13, #0x26d1, LSL #0
    MOVK  X13, #0x8b9c, LSL #16
    MOVK  X13, #0x89a, LSL #32
    MOVK  X13, #0x24ee, LSL #48
    MOVZ  X14, #0x95e3, LSL #0
    MOVK  X14, #0x5f09, LSL #16
    MOVK  X14, #0xc250, LSL #32
    MOVK  X14, #0x4f03, LSL #48
    MOVZ  X15, #0x33b8, LSL #0
    MOVK  X15, #0x9244, LSL #16
    MOVK  X15, #0xe5f, LSL #32
    MOVK  X15, #0xd46a, LSL #48
    MOVZ  X16, #0xf346, LSL #0
    MOVK  X16, #0xeba9, LSL #16
    MOVK  X16, #0x77d2, LSL #32
    MOVK  X16, #0x42ac, LSL #48
    MOVZ  X17, #0x8c2a, LSL #0
    MOVK  X17, #0x1e72, LSL #16
    MOVK  X17, #0x702, LSL #32
    MOVK  X17, #0x6001, LSL #48
    MOVZ  X18, #0xd47f, LSL #0
    MOVK  X18, #0xd89a, LSL #16
    MOVK  X18, #0x8191, LSL #32
    MOVK  X18, #0xa3c3, LSL #48
    MOVZ  X19, #0xf38a, LSL #0
    MOVK  X19, #0xaff4, LSL #16
    MOVK  X19, #0x4012, LSL #32
    MOVK  X19, #0xd16d, LSL #48
    MOVZ  X20, #0x63ce, LSL #0
    MOVK  X20, #0xba6a, LSL #16
    MOVK  X20, #0xc92b, LSL #32
    MOVK  X20, #0xd1c3, LSL #48
    MOVZ  X21, #0xe9b4, LSL #0
    MOVK  X21, #0x8e3c, LSL #16
    MOVK  X21, #0xbf9d, LSL #32
    MOVK  X21, #0xc016, LSL #48
    MOVZ  X22, #0xd13e, LSL #0
    MOVK  X22, #0xca6a, LSL #16
    MOVK  X22, #0x5214, LSL #32
    MOVK  X22, #0x75e0, LSL #48
    MOVZ  X23, #0x99ae, LSL #0
    MOVK  X23, #0x1e80, LSL #16
    MOVK  X23, #0xeba0, LSL #32
    MOVK  X23, #0xb19e, LSL #48
    MOVZ  X24, #0xc5bb, LSL #0
    MOVK  X24, #0x68d1, LSL #16
    MOVK  X24, #0xa46f, LSL #32
    MOVK  X24, #0x2806, LSL #48
    MOVZ  X25, #0xa1ed, LSL #0
    MOVK  X25, #0x2f71, LSL #16
    MOVK  X25, #0x9ca5, LSL #32
    MOVK  X25, #0xf9b3, LSL #48
    MOVZ  X26, #0x663d, LSL #0
    MOVK  X26, #0x158f, LSL #16
    MOVK  X26, #0x5b16, LSL #32
    MOVK  X26, #0xb978, LSL #48
    MOVZ  X27, #0x7327, LSL #0
    MOVK  X27, #0x14a3, LSL #16
    MOVK  X27, #0x6cd8, LSL #32
    MOVK  X27, #0x9820, LSL #48
    MOVZ  X28, #0xc4b9, LSL #0
    MOVK  X28, #0x9dd9, LSL #16
    MOVK  X28, #0x3378, LSL #32
    MOVK  X28, #0xc691, LSL #48
    MOVZ  X29, #0xd62a, LSL #0
    MOVK  X29, #0x4954, LSL #16
    MOVK  X29, #0xfba3, LSL #32
    MOVK  X29, #0x911b, LSL #48
    MOVZ  X2, #0x14, LSL #0
TaishanIntMduP01_label_631:
    CLS  V31.8B, V8.8B
    CLZ  V6.4H, V30.4H
    SUB  X21, X29, W23, UXTH #2
    ADDS  W25, W8, W6, LSR #11
    CSNEG  W13, W17, W21, AL
    ADCS  X10, X5, X13
    ANDS  W26, W11, #0x6060606
    SUBS  W29, W11, W26, ASR #28
    ADDS  W29, W8, #0xe5d, LSL #12
    ASRV  W14, W5, W28
    ORR  W13, W29, #0xfffeffff
    ADD  X28, X10, X27, SXTX #1
    MOVZ  X22, #0x4f1f, LSL #48
    SUBS  X17, X23, W26, UXTB #2
    MOVN  X19, #0x47e9, LSL #32
    UBFM  W16, W17, #0x6, #0xe
    MADD  X8, X21, X2, X15
    ANDS  W20, W5, #0xfe7fffff
    EON  X23, X3, X23, ASR #9
    UMULH  X12, X26, X7
    SUBS  X15, X3, X14, LSL #59
    ADDS  X23, X16, X9, LSR #38
    SUBS  W16, W6, #0xe0c, LSL #12
    SUB  X15, X6, #0x150
    SUB  X21, X28, #0x931, LSL #12
    ANDS  X12, X14, #0xff0000000000ffff
    ADD  X21, X27, W16, UXTW #1
    EOR  W26, W9, W16, ROR #16
    CSEL  X5, X15, X8, GT
    SUB  W9, W14, #0xd4c, LSL #12
    BIC  X7, X3, X2, ASR #21
    CSINV  W12, W26, W12, PL
    ADDS  X23, X29, X10, LSL #40
    EOR  X9, X12, X9, LSL #3
    SMULH  X8, X6, X18
    ADD  W15, W20, W25, LSL #28
    ADD  W9, W20, #0x469, LSL #12
    ADD  X27, X19, W9, SXTW #4
    CLZ  W8, W2
    CSEL  X21, X15, X24, NV
    ADDS  X18, X5, X6, ASR #23
    AND  X18, X22, #0xfff0000ffff0000f
    LSRV  X21, X12, X13
    CLS  W25, W12
    SUBS  W16, W25, #0x84, LSL #12
    CSEL  W12, W16, W28, GE
    MOVZ  W14, #0x6b8d, LSL #16
    ADD  W27, W13, W24, ASR #0
    CRC32CH  W25, W12, W29
    MOVK  X6, #0xf948, LSL #0
    MADD  W17, W24, W27, W9
    ADDS  W13, W15, #0x670
    ORR  V15.4S, #0x8b, LSL #24
    CSINV  X3, X6, X16, GE
    ASRV  X18, X11, X28
    SUBS  X16, X13, #0x1f0
    MOVN  X18, #0x2e62, LSL #32
    SUBS  X7, X26, X13, UXTX #3
    AND  X17, X21, X25, ASR #42
    ORR  W16, W14, #0x66666666
    CLZ  X16, X20
    ASRV  W23, W8, W23
    ANDS  W23, W16, #0x1000100
    ORR  V23.8B, V20.8B, V22.8B
    SUB  W14, W19, #0xe50
    ANDS  W29, W12, W5, ROR #30
    UMSUBL  X21, W23, W7, X8
    CRC32H  W20, W23, W19
    ADDS  X14, X22, #0x612, LSL #12
    ADD  W23, W12, W22, UXTX #0
    ANDS  X20, X13, #0xffffff0000000001
    ADDS  X25, X27, #0x1c0
    ORR  V7.8H, #0x3e
    CSINV  X25, X11, X6, CC
    CRC32CH  W20, W9, W18
    SUB  X22, X12, X17, ASR #1
    CSINC  W15, W29, W25, MI
    EOR  W14, W24, W23, ASR #7
    ANDS  W23, W2, W25, ROR #15
    ADD  X5, X2, W2, UXTW #4
    MOVN  W21, #0x9767, LSL #0
    BICS  X25, X14, X25, LSL #45
    EOR  X20, X9, #0xfffc00003fffffff
    CSEL  X22, X5, X23, LS
    EON  X26, X20, X17, ASR #13
    SUBS  W19, W7, W12, SXTX #2
    ORR  X20, X15, #0xfe001ffffe001fff
    MOVZ  X25, #0x4eae, LSL #0
    EOR  X10, X13, X21, ASR #58
    LSRV  X26, X10, X16
    LSRV  W28, W13, W16
    CSNEG  X25, X28, X8, HI
    EOR  W14, W20, W6, LSR #29
    AND  W25, W5, W22, LSR #12
    ORR  X23, X18, #0xe0000000e0000000
    CSNEG  X26, X18, X21, PL
    CRC32H  W16, W21, W19
    SBFM  X28, X6, #0x3a, #0x3e
    ANDS  X19, X26, #0xfc07fc07fc07fc07
    ADDS  W5, W19, W12, ASR #27
    SUBS  X5, X18, #0x8d6
    ADCS  W14, W20, W29
    EXTR  X18, X26, X2, #0x1
    ORN  X28, X6, X8, LSR #3
    CLS  X17, X26
    EOR  X24, X20, #0x7ffff80000000000
    AND  X11, X29, X14, LSL #23
    ADD  W17, W10, W3, UXTH #4
    BIC  W16, W28, W16, ROR #18
    ADDS  X7, X9, #0x1e0
    SUBS  X10, X13, X9, UXTX #2
    UMSUBL  X15, W14, W24, X18
    ADCS  X5, X25, X29
    CSNEG  W20, W25, W17, MI
    ANDS  X3, X25, X16, LSR #33
    ORR  X24, X21, X27, LSL #50
    CSEL  X9, X15, X22, NE
    MOVZ  W19, #0x4253, LSL #0
    ANDS  X29, X19, #0xf83ff83ff83ff83f
    LSRV  W20, W5, W27
    SUB  W19, W2, W3, ASR #2
    CLZ  X11, X16
    CRC32X  W14, W7, X15
    ORR  W9, W9, W18, LSL #7
    MOVK  X11, #0x57af, LSL #0
    ASRV  W15, W23, W24
    SMULH  X11, X6, X20
    CRC32X  W11, W14, X29
    CSINC  W15, W23, W23, LS
    SUBS  W28, W21, W26, SXTB #2
    BICS  W3, W29, W6, ASR #18
    CLZ  X10, X28
    CRC32CB  W17, W14, W17
    CRC32X  W27, W10, X18
    ASRV  W16, W19, W27
    UMULH  X12, X10, X6
    ADD  W11, W24, W15, UXTW #4
    CRC32W  W23, W2, W7
    LSRV  X22, X10, X9
    MOVK  W25, #0xc45, LSL #16
    SBFM  W19, W16, #0x15, #0x0
    SUBS  X12, X28, X14, LSL #58
    CRC32CX  W9, W13, X5
    ADD  X6, X22, X3, LSR #12
    LSRV  X19, X11, X19
    CRC32CW  W20, W5, W23
    SUBS  X15, X15, #0xe49
    AND  X22, X22, #0x3fe03fe03fe03fe
    ORR  V25.16B, V7.16B, V15.16B
    MOVN  X7, #0xa73c, LSL #48
    EOR  W29, W15, #0xfdffffff
    UMSUBL  X21, W11, W20, X29
    ADDS  X9, X12, X7, UXTX #2
    EOR  W26, W17, #0xf800f8
    SBFM  W11, W12, #0x1f, #0xa
    ASRV  X28, X20, X21
    CRC32CW  W3, W7, W2
    SUBS  W19, W26, W11, LSR #26
    CRC32CW  W20, W18, W6
    ORR  V20.4S, #0x67, LSL #16
    ORR  V30.4H, #0x86
    ADDS  X17, X21, X5, LSR #31
    ANDS  W8, W20, #0xc007ffff
    CLS  V11.2S, V28.2S
    CRC32X  W9, W16, X23
    ORR  V31.4H, #0x56
    MOVZ  X29, #0xe948, LSL #32
    ADD  W15, W26, W3, UXTX #0
    LSLV  W18, W6, W9
    ADD  X28, X9, #0xa15, LSL #12
    MADD  W24, W2, W5, W11
    CSNEG  W13, W2, W23, MI
    LSLV  X5, X2, X21
    ASRV  W5, W6, W8
    EOR  W7, W17, W10, LSR #15
    CSINV  W16, W5, W19, EQ
    ADCS  X8, X26, X9
    ADDS  X19, X6, X14, LSL #51
    ADC  W29, W26, W29
    AND  W14, W3, W22, LSR #9
    LSRV  X20, X20, X11
    ADD  X27, X6, X18, LSR #21
    ORN  X12, X23, X23, LSL #29
    CRC32H  W27, W6, W10
    ORN  X20, X18, X10, ROR #41
    EON  X18, X17, X18, ASR #20
    CRC32W  W28, W18, W5
    ADDS  W25, W17, W7, ASR #15
    CRC32CH  W5, W21, W28
    ADD  X22, X9, #0x497
    BIC  X12, X17, X6, ROR #30
    CLS  X21, X29
    BIC  W11, W28, W27, ROR #11
    CSINV  W10, W10, W20, CC
    SUBS  X27, X21, X20, LSL #45
    MOVN  W9, #0x8af, LSL #0
    ANDS  W18, W3, #0xc0
    CSINC  W22, W9, W8, CC
    SMULH  X6, X15, X28
    EOR  W26, W3, W10, ASR #5
    SUBS  X2, X2, #0x1
    B.NE  TaishanIntMduP01_label_631
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X19, #0x1e80, LSL #0
    MOVK  X19, #0x6add, LSL #16
    SUB  X14, X19, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X3, #0xe8be, LSL #0
    MOVK  X3, #0x9227, LSL #16
    SUB  X11, X3, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X26, #0xa3ba, LSL #0
    MOVK  X26, #0xdfac, LSL #16
    SUB  X13, X26, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x1000, LSL #16
    SUB  X19, X26, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X25, X5, X11
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X8, #0xa3ba, LSL #0
    MOVK  X8, #0xdfac, LSL #16
    MOVK  X8, #0x4586, LSL #32
    MOVK  X8, #0x5414, LSL #48
    SUB  X25, X8, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X5, X17, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X15
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X27, #0x6991, LSL #0
    MOVK  X27, #0x76ba, LSL #16
    SUB  X3, X27, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X17
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP01_TestFail
    MOVZ  X14, #0x80, LSL #0
    SUB  X7, X14, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP01_TestFail
    MOVZ  X11, #0x1f, LSL #0
    SUB  X6, X11, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X27, X8, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x25f0, LSL #0
    MOVK  X12, #0xdb93, LSL #16
    SUB  X6, X12, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X26
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X23, #0x14, LSL #0
TaishanIntMduP01_label_659:
    MOVK  X29, #0xbfed, LSL #32
    LSRV  W17, W17, W21
    SUBS  W17, W5, W11, LSL #6
    ADDS  W7, W16, W28, UXTH #3
    CSINC  W20, W23, W15, AL
    LSRV  X22, X5, X11
    ASRV  X29, X15, X12
    SUB  X9, X24, #0x911
    LSLV  X26, X14, X13
    ADD  X14, X12, W21, SXTH #0
    SUBS  X14, X5, W9, UXTB #4
    EOR  W20, W25, #0xffffe1ff
    CSINC  X5, X11, X6, GT
    CSINC  X20, X17, X17, AL
    LSLV  W6, W14, W7
    CSEL  X26, X23, X8, NE
    EON  W28, W27, W25, LSL #7
    MOVZ  X12, #0xc75a, LSL #16
    CSEL  X25, X13, X8, CS
    ADC  X14, X7, X21
    ANDS  X11, X26, X28, ROR #63
    MOVK  W14, #0x20aa, LSL #16
    SUB  X17, X25, X7, LSL #54
    SUB  W18, W20, W28, UXTW #0
    ORN  W26, W18, W5, ROR #21
    ADD  W29, W16, W15, SXTX #1
    ORN  X24, X29, X11, LSR #19
    SBFM  X7, X9, #0x11, #0x19
    SUBS  X14, X7, #0x4dc
    EXTR  W19, W2, W5, #0x1d
    ORR  V26.2S, #0xde, LSL #16
    CRC32CX  W3, W25, X25
    CRC32X  W15, W23, X29
    SBFM  W19, W24, #0x8, #0x17
    SUB  X9, X25, X6, ASR #19
    BICS  X29, X11, X21, LSL #47
    LSLV  X12, X15, X2
    ADD  X9, X11, #0xff0
    EON  W14, W19, W28, LSL #7
    UBFM  X6, X14, #0x5, #0x6
    BIC  W10, W28, W27, ROR #20
    ORR  V10.8B, V11.8B, V27.8B
    UMULH  X17, X15, X13
    ANDS  W8, W7, W3, ROR #29
    SUB  X28, X23, X28, LSL #46
    ADDS  X21, X27, #0x3fb
    UMADDL  X16, W26, W15, X12
    BIC  V1.8B, V26.8B, V22.8B
    ADDS  X29, X23, #0x90b
    SBFM  X5, X27, #0xd, #0x1f
    MOVK  W29, #0x3fb7, LSL #0
    CSINV  W15, W29, W28, PL
    UBFM  W10, W15, #0xc, #0x4
    SUBS  W11, W20, W18, LSR #25
    MOVK  X3, #0xe0b5, LSL #32
    AND  W7, W11, #0xffc3ffff
    SUBS  X20, X7, #0xaf6, LSL #12
    EXTR  X27, X15, X3, #0x31
    SUB  W16, W27, W10, ASR #21
    UBFM  W3, W9, #0x12, #0x17
    SUB  X14, X7, X25, SXTX #0
    CRC32CX  W29, W27, X13
    ADC  W26, W12, W3
    UBFM  W9, W11, #0x8, #0x1
    LSRV  W5, W18, W16
    MOVK  W15, #0x52d4, LSL #16
    EON  X2, X9, X17, LSL #63
    SMADDL  X25, W13, W20, X11
    EOR  X7, X11, X2, ASR #4
    CRC32CX  W12, W12, X11
    ANDS  X26, X23, #0xffff000000000fff
    CRC32CH  W14, W18, W12
    ORN  X28, X23, X16, ROR #57
    CRC32CB  W13, W5, W25
    ANDS  X12, X21, #0xfff000fffff000ff
    UMSUBL  X10, W22, W13, X11
    EOR  W10, W16, #0x1fffe000
    ADC  X22, X12, X7
    LSLV  X14, X2, X5
    CSNEG  X16, X22, X15, CC
    ADDS  W26, W12, W2, SXTH #1
    ORR  V11.4H, #0x95
    ORN  W6, W11, W25, ASR #4
    ORR  V29.4H, #0x90
    CRC32CB  W26, W22, W8
    UMULH  X14, X2, X20
    ORR  V29.2S, #0xf9, LSL #24
    MOVK  X14, #0x2b0f, LSL #16
    ORN  X12, X23, X6, ROR #50
    CSEL  X9, X12, X28, CS
    ADD  W10, W18, W12, UXTW #4
    CLZ  X11, X24
    SUB  X19, X10, X25, UXTX #3
    MOVZ  W25, #0x1b7, LSL #0
    CRC32CH  W27, W5, W20
    ADDS  W13, W11, #0xa21, LSL #12
    CLZ  X10, X16
    CRC32H  W22, W14, W20
    ADD  W22, W25, W29, LSR #26
    CSNEG  W8, W19, W28, AL
    MOVZ  W22, #0x2078, LSL #0
    ORR  V31.8H, #0xb9
    MADD  W25, W28, W20, W20
    EXTR  X10, X25, X19, #0x17
    SMADDL  X2, W17, W7, X28
    UMSUBL  X2, W2, W23, X16
    CRC32X  W26, W27, X29
    CLS  V3.4H, V16.4H
    CLS  V10.4S, V0.4S
    SUB  W2, W22, W29, LSR #31
    AND  X13, X23, X14, LSR #26
    ADC  W27, W9, W21
    SUB  W11, W13, W19, SXTW #2
    SUBS  X7, X5, X19, LSR #24
    ADDS  W22, W26, #0xc53, LSL #12
    LSLV  W11, W2, W8
    CSEL  W27, W21, W3, LE
    CRC32CB  W11, W21, W7
    EXTR  X14, X16, X15, #0x22
    CSEL  W19, W20, W7, VC
    MOVN  W10, #0xe5c, LSL #0
    LSRV  W29, W22, W9
    MOVN  X14, #0x2a48, LSL #16
    LSLV  W19, W5, W10
    AND  W21, W14, W23, ROR #6
    EON  X21, X11, X23, ROR #13
    CSEL  W21, W26, W10, PL
    CRC32CX  W10, W24, X2
    CRC32CH  W20, W5, W10
    EOR  X18, X27, #0x1ffffff01ffffff0
    SUBS  W26, W9, #0x737, LSL #12
    UMSUBL  X21, W22, W22, X27
    CSINV  W18, W3, W15, MI
    CSINV  W11, W29, W10, PL
    ORR  X10, X5, X5, LSL #17
    SUB  X20, X25, X2, UXTX #2
    ADDS  X20, X22, W25, UXTW #4
    CRC32CW  W9, W19, W17
    CSINC  W10, W5, W26, HI
    ADD  X22, X24, X6, SXTX #0
    LSLV  W29, W22, W8
    ADD  W8, W27, #0xe52
    EON  W15, W5, W20, ROR #3
    ADDS  X15, X22, X11, LSR #51
    LSRV  X25, X22, X3
    MOVK  W19, #0x4af0, LSL #0
    ORR  W19, W21, #0x80000007
    ADC  X15, X9, X13
    CRC32B  W6, W19, W24
    CLS  V1.4S, V18.4S
    BICS  X6, X11, X29, ASR #36
    ORR  V24.8H, #0x25, LSL #8
    BIC  V28.8B, V1.8B, V28.8B
    ADDS  W3, W23, W22, LSL #24
    ADC  W11, W24, W27
    CSNEG  X20, X19, X19, CC
    ANDS  X11, X3, #0x1ffffe00000
    LSLV  X13, X15, X27
    CLZ  W18, W28
    ADCS  W21, W19, W13
    EXTR  X6, X22, X21, #0x30
    SUBS  W17, W11, W18, LSR #25
    ADD  X25, X19, X10, ASR #42
    CSEL  X9, X29, X20, GE
    MOVK  W11, #0xaa8b, LSL #16
    ADDS  X20, X6, #0xfe4, LSL #12
    CLS  V27.16B, V16.16B
    ORN  W14, W27, W25, ASR #16
    CRC32CW  W9, W14, W20
    MOVK  X20, #0xeb67, LSL #32
    ADDS  X14, X5, X26, UXTX #3
    AND  X24, X16, X14, ASR #10
    ANDS  W9, W11, W19, LSL #27
    ADCS  W26, W5, W7
    ORR  X29, X7, X24, LSL #11
    SUBS  W22, W13, W24, SXTB #1
    CSINC  W28, W27, W20, LT
    ORN  X9, X10, X28, ASR #59
    CSNEG  W25, W2, W18, CS
    SUB  X6, X16, #0xdde
    MOVK  X25, #0x5c48, LSL #32
    MOVN  X26, #0x79a4, LSL #0
    ADC  W26, W27, W2
    EOR  X9, X20, #0xffffffe1ffffffe1
    SUBS  W25, W2, #0x330
    CRC32X  W28, W12, X26
    ADC  X28, X11, X24
    ANDS  X28, X2, X19, ROR #44
    BIC  V9.8B, V18.8B, V11.8B
    BICS  W19, W14, W22, LSR #6
    BIC  V12.16B, V19.16B, V23.16B
    ORR  V14.16B, V8.16B, V8.16B
    EXTR  W22, W22, W16, #0x1a
    SUBS  X13, X26, X28, LSR #2
    EOR  X9, X11, X19, LSR #48
    BIC  W29, W22, W20, ASR #31
    CRC32X  W22, W27, X10
    LSRV  X11, X25, X5
    CLS  W25, W6
    CSNEG  X20, X2, X13, PL
    SUBS  X23, X23, #0x1
    B.NE  TaishanIntMduP01_label_659
    MOVZ  X19, #0x2078, LSL #0
    SUB  X17, X19, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X13, #0x1, LSL #0
    MOVK  X13, #0xc800, LSL #16
    SUB  X3, X13, X3
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X24, #0x7ff, LSL #0
    SUB  X28, X24, X5
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X5, #0x458c, LSL #0
    MOVK  X5, #0x17, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X7, X5, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X20, X11, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X20, #0x1e3e, LSL #0
    SUB  X26, X20, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xaa8b, LSL #16
    SUB  X7, X16, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X23, #0x5000, LSL #0
    MOVK  X23, #0x841a, LSL #16
    SUB  X12, X23, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X20, X22, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP01_TestFail
    MOVZ  X11, #0x1, LSL #0
    MOVK  X11, #0xc800, LSL #16
    SUB  X21, X11, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP01_TestFail
    MOVZ  X17, #0x87f7, LSL #0
    MOVK  X17, #0x20d2, LSL #16
    MOVK  X17, #0x4, LSL #32
    SUB  X25, X17, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X16, #0x8cba, LSL #0
    MOVK  X16, #0xec44, LSL #16
    SUB  X28, X16, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X10, #0x8cba, LSL #0
    MOVK  X10, #0xec44, LSL #16
    SUB  X14, X10, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X29, #0x87f7, LSL #0
    MOVK  X29, #0x20d2, LSL #16
    MOVK  X29, #0x4, LSL #32
    SUB  X12, X29, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x2078, LSL #0
    SUB  X24, X2, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X26, X13, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X14, #0x5000, LSL #0
    MOVK  X14, #0x841a, LSL #16
    SUB  X21, X14, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP01_TestFail
    MOVZ  X14, #0xfec, LSL #0
    SUB  X26, X14, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X28, #0x87f7, LSL #0
    MOVK  X28, #0x20d2, LSL #16
    MOVK  X28, #0x4, LSL #32
    SUB  X6, X28, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    MOVZ  X19, #0xa, LSL #0
TaishanIntMduP01_label_683:
    AND  X2, X22, #0x3838383838383838
    BIC  V29.8B, V17.8B, V23.8B
    ORN  W27, W8, W13, ROR #28
    ADD  X14, X27, X23, ASR #51
    UMADDL  X6, W15, W28, X6
    ADD  W28, W15, #0x446, LSL #12
    EOR  W2, W2, #0x3000
    ADCS  W23, W2, W26
    MOVN  X3, #0x24b3, LSL #16
    CLS  V29.4H, V26.4H
    BICS  W28, W17, W25, LSR #7
    CLS  X29, X29
    SUBS  W11, W20, W7, SXTB #3
    ANDS  X10, X26, X29, LSR #57
    ANDS  X10, X15, X22, LSR #49
    SMULH  X23, X29, X23
    LSLV  X14, X19, X17
    MOVN  W6, #0xa93e, LSL #16
    EOR  X23, X23, X25
    AND  X22, X12, X29, LSL #62
    ADD  W9, W14, W16, SXTW #2
    LSRV  W29, W27, W12
    EXTR  X25, X3, X16, #0x17
    SUB  X26, X11, #0x4d1
    MOVZ  W14, #0x667a, LSL #0
    ORR  W3, W29, #0xe1e1e1e1
    ADD  W3, W5, #0x3c0, LSL #12
    ADD  X26, X12, X23, LSR #13
    UMULH  X11, X11, X10
    UMSUBL  X3, W12, W22, X25
    ORN  W26, W16, W20, LSR #28
    ORR  X20, X29, X6, LSL #42
    MOVK  W28, #0x3d, LSL #0
    ADDS  W21, W11, W20, SXTW #0
    ADCS  X15, X26, X25
    SMSUBL  X14, W28, W19, X9
    ADC  X17, X14, X22
    SUB  W6, W18, W8, SXTW #1
    ADDS  W10, W3, #0xbe0, LSL #12
    BIC  V5.8B, V12.8B, V29.8B
    EXTR  W9, W5, W8, #0x1f
    ORR  V25.2S, #0x86, LSL #16
    EXTR  X26, X18, X25, #0x33
    CSEL  X10, X5, X14, LE
    CSEL  X14, X8, X11, NE
    SUBS  X26, X21, X9, ASR #46
    CSNEG  X16, X10, X17, LE
    ORR  V29.2S, #0xf9
    MOVN  X6, #0xc040, LSL #48
    EOR  W13, W13, #0x800000
    CSINC  W2, W23, W14, GE
    MOVK  W14, #0x8ca7, LSL #0
    SBFM  X27, X26, #0xb, #0x2b
    LSRV  W25, W23, W16
    LSLV  X23, X5, X15
    SBFM  X28, X3, #0x3e, #0x3b
    UMSUBL  X12, W12, W20, X27
    BICS  W21, W12, W26, ASR #14
    ADD  W21, W16, W5, UXTW #0
    EOR  W8, W23, #0xaaaaaaaa
    CRC32CX  W22, W24, X28
    ASRV  X16, X26, X18
    SBFM  X21, X8, #0x30, #0x24
    CRC32CH  W10, W15, W25
    ADD  X11, X20, W12, SXTH #3
    MOVK  W13, #0xc5be, LSL #16
    EXTR  X8, X22, X8, #0x36
    SUB  X12, X21, W12, SXTW #1
    ASRV  X27, X22, X23
    ADDS  X2, X10, X17, LSL #24
    ADD  W6, W16, W6, LSR #22
    BICS  W2, W26, W2, LSR #22
    ADDS  X7, X9, #0x8bd
    CSEL  W28, W8, W23, NE
    SUB  X11, X28, #0x963, LSL #12
    ANDS  X24, X12, #0xfffffc0000000007
    ADD  W10, W7, W10, UXTW #2
    CRC32CW  W7, W11, W8
    ADDS  X5, X26, W16, SXTH #1
    ADCS  W13, W9, W26
    CLS  X2, X17
    SUBS  X26, X11, W15, UXTH #0
    ADDS  W28, W23, #0x1fa
    ORR  V12.2S, #0x8e, LSL #16
    ORN  W6, W8, W15, LSR #21
    ANDS  X16, X23, X22, ROR #46
    ADC  W16, W15, W7
    EXTR  W22, W5, W11, #0xc
    CRC32B  W26, W12, W13
    ADDS  W10, W24, W12, LSR #8
    EON  X22, X2, X19, LSL #60
    MOVK  X9, #0xed59, LSL #48
    SUB  W7, W5, #0x3c7
    ORR  W26, W22, W12, ASR #22
    SUBS  X17, X22, X27, LSR #58
    MOVN  W22, #0x70e2, LSL #0
    CLZ  W14, W21
    CSINV  W28, W8, W3, NV
    CSINC  X21, X23, X22, CS
    ANDS  X15, X19, X24, LSL #8
    SUBS  X2, X26, X15, LSL #43
    CLZ  W10, W29
    UBFM  W13, W22, #0x1a, #0xc
    EXTR  W8, W26, W21, #0x18
    BICS  W3, W27, W22, LSR #21
    BIC  W27, W9, W20, ASR #12
    LSRV  X20, X6, X15
    SUB  W7, W23, W5, LSL #24
    BICS  X10, X23, X22, ROR #2
    ADC  X25, X11, X20
    MOVN  X28, #0xac39, LSL #48
    ADC  W6, W6, W16
    BIC  W27, W13, W11, ROR #28
    SUBS  X11, X28, X12, ASR #2
    SUBS  W5, W2, #0xe92
    SUB  X28, X13, X15, LSL #32
    ASRV  X11, X11, X22
    CSEL  X28, X12, X28, GE
    BICS  W26, W19, W22, ROR #17
    CRC32CW  W13, W13, W14
    CLZ  V23.4H, V2.4H
    MOVK  X7, #0xb10c, LSL #48
    UMSUBL  X10, W27, W11, X8
    ANDS  W3, W2, #0x38383838
    SUB  W8, W16, W6, UXTB #3
    ORR  V12.4H, #0x82
    SBFM  X17, X17, #0x38, #0x1c
    SBFM  X11, X23, #0x1a, #0x8
    LSRV  W25, W28, W28
    EON  X21, X27, X9, LSR #38
    BIC  W20, W26, W13, LSL #30
    SUB  X29, X28, X23, ASR #49
    ORR  X27, X10, X18, LSL #45
    ASRV  W29, W7, W16
    MOVN  W3, #0x40df, LSL #16
    EOR  X15, X25, #0xffffe0000003ffff
    AND  W7, W12, #0xf801ffff
    LSRV  W17, W7, W19
    UMSUBL  X6, W15, W17, X6
    CRC32H  W17, W27, W27
    ADC  W22, W16, W7
    SBFM  X6, X6, #0x23, #0x1e
    SUB  W29, W8, W23, LSR #25
    ORR  W2, W10, W9, ROR #13
    ADD  X16, X18, W20, SXTB #0
    MOVN  W13, #0x726c, LSL #16
    ADD  X28, X25, #0x8, LSL #12
    SUB  W27, W12, W25, SXTH #0
    SMSUBL  X2, W17, W25, X14
    ORR  W18, W5, #0x7c000000
    SUB  X18, X22, X20, LSL #1
    SUBS  W29, W9, #0x5cb
    ADDS  W2, W15, W25, UXTW #2
    CSNEG  W14, W27, W22, HI
    ORR  W22, W8, W14, LSL #2
    EON  W9, W6, W22, ASR #22
    ADD  X21, X9, W16, UXTH #2
    CSINV  W8, W5, W21, AL
    EOR  W8, W11, #0xf007f007
    CSINC  W10, W6, W7, GT
    AND  W10, W27, W2, LSL #23
    CLZ  W17, W2
    CLS  V5.2S, V30.2S
    ADD  W3, W11, W11, ASR #11
    AND  W29, W26, W13, LSL #4
    SUBS  X3, X12, X18, LSL #58
    SUBS  W18, W6, W20, UXTW #1
    ADDS  X6, X20, W9, UXTW #3
    ORN  X6, X12, X11, ASR #49
    AND  W9, W22, #0xfffff0ff
    ADDS  X7, X7, X23, ASR #39
    MOVZ  W28, #0x2d4e, LSL #0
    AND  W17, W20, W5, ROR #1
    UBFM  X13, X29, #0x10, #0xe
    LSRV  W13, W16, W26
    SUBS  X5, X20, W28, UXTW #3
    ADDS  X22, X14, X23, ASR #59
    EON  X3, X15, X19, LSR #15
    ADD  W12, W5, #0xe83
    EXTR  X20, X18, X12, #0x34
    ADCS  W26, W18, W25
    CRC32CB  W7, W19, W6
    BIC  X3, X13, X28, LSL #18
    ANDS  W26, W13, #0x1ffffff0
    ADD  X29, X26, #0x2b8
    EOR  X26, X19, #0x1fffffc000000
    CRC32B  W11, W24, W23
    SMSUBL  X6, W9, W10, X12
    BICS  W18, W20, W28, LSL #15
    ADDS  X13, X22, X28, UXTX #1
    CSNEG  X21, X19, X3, VC
    ADCS  X18, X2, X7
    LSLV  X9, X29, X14
    SUBS  W8, W21, W25, SXTB #3
    ORR  X12, X5, #0x1ffffc001ffffc00
    SUBS  X9, X8, X29, ASR #41
    AND  W8, W23, W25, LSL #18
    MADD  W12, W29, W16, W3
    ORR  W17, W27, #0xfe3ffe3f
    CLZ  V16.8H, V26.8H
    SUBS  X19, X19, #0x1
    B.NE  TaishanIntMduP01_label_683
    MOVZ  X18, #0x55bf, LSL #0
    MOVK  X18, #0xf, LSL #16
    SUB  X8, X18, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X20, #0x7965, LSL #0
    MOVK  X20, #0x4845, LSL #16
    SUB  X12, X20, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP01_TestFail
    MOVZ  X3, #0x9590, LSL #0
    MOVK  X3, #0xfffe, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X21, X3, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP01_TestFail
    MOVZ  X26, #0xa413, LSL #0
    MOVK  X26, #0x967e, LSL #16
    MOVK  X26, #0x59c, LSL #32
    MOVK  X26, #0x5e8, LSL #48
    SUB  X28, X26, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X6, #0xd052, LSL #0
    MOVK  X6, #0x5f16, LSL #16
    SUB  X18, X6, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP01_TestFail
    MOVZ  X13, #0xfe01, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X7, X13, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x5e80, LSL #16
    SUB  X5, X21, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X2, #0xc419, LSL #0
    MOVK  X2, #0x76d, LSL #16
    SUB  X9, X2, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X21, #0xfe01, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X27, X21, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X14, #0xfc01, LSL #0
    MOVK  X14, #0x787e, LSL #16
    SUB  X2, X14, X14
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x38bf, LSL #0
    MOVK  X9, #0xe000, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X11, X9, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X28, #0x7965, LSL #0
    MOVK  X28, #0x4c55, LSL #16
    SUB  X14, X28, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X23, #0xfe3f, LSL #0
    MOVK  X23, #0xfebf, LSL #16
    SUB  X6, X23, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X16, #0xfe01, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X23, X16, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP01_TestFail
    MOVZ  X6, #0xfbf1, LSL #0
    MOVK  X6, #0x787e, LSL #16
    SUB  X19, X6, X22
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X24, X8, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X19, #0xc740, LSL #0
    MOVK  X19, #0x3, LSL #16
    SUB  X13, X19, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X29, #0x7965, LSL #0
    MOVK  X29, #0x4c55, LSL #16
    SUB  X8, X29, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x7965, LSL #0
    MOVK  X9, #0x4c55, LSL #16
    SUB  X17, X9, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x8f3a, LSL #0
    MOVK  X2, #0x23b1, LSL #16
    MOVK  X2, #0xaff0, LSL #32
    MOVK  X2, #0xc87c, LSL #48
    MOVZ  X3, #0xd00c, LSL #0
    MOVK  X3, #0x8b55, LSL #16
    MOVK  X3, #0x1656, LSL #32
    MOVK  X3, #0xe5, LSL #48
    MOVZ  X5, #0xe0c9, LSL #0
    MOVK  X5, #0xe59f, LSL #16
    MOVK  X5, #0x3675, LSL #32
    MOVK  X5, #0x5ff, LSL #48
    MOVZ  X6, #0xfc58, LSL #0
    MOVK  X6, #0x9889, LSL #16
    MOVK  X6, #0x4f10, LSL #32
    MOVK  X6, #0xf722, LSL #48
    MOVZ  X7, #0x1ac3, LSL #0
    MOVK  X7, #0xa180, LSL #16
    MOVK  X7, #0x625c, LSL #32
    MOVK  X7, #0x199c, LSL #48
    MOVZ  X8, #0x7d8f, LSL #0
    MOVK  X8, #0x34f6, LSL #16
    MOVK  X8, #0xabcd, LSL #32
    MOVK  X8, #0x1a4b, LSL #48
    MOVZ  X9, #0x8c58, LSL #0
    MOVK  X9, #0x4e60, LSL #16
    MOVK  X9, #0xa699, LSL #32
    MOVK  X9, #0x809f, LSL #48
    MOVZ  X10, #0xe54f, LSL #0
    MOVK  X10, #0x9327, LSL #16
    MOVK  X10, #0x72d, LSL #32
    MOVK  X10, #0xada9, LSL #48
    MOVZ  X11, #0xa19b, LSL #0
    MOVK  X11, #0x2b8f, LSL #16
    MOVK  X11, #0x99d8, LSL #32
    MOVK  X11, #0xb3b1, LSL #48
    MOVZ  X12, #0x6996, LSL #0
    MOVK  X12, #0xc96c, LSL #16
    MOVK  X12, #0x8882, LSL #32
    MOVK  X12, #0xf069, LSL #48
    MOVZ  X13, #0xc7fb, LSL #0
    MOVK  X13, #0xb5b6, LSL #16
    MOVK  X13, #0xb064, LSL #32
    MOVK  X13, #0x409f, LSL #48
    MOVZ  X14, #0x80de, LSL #0
    MOVK  X14, #0xc76d, LSL #16
    MOVK  X14, #0xe74d, LSL #32
    MOVK  X14, #0x17dc, LSL #48
    MOVZ  X15, #0x3273, LSL #0
    MOVK  X15, #0x259b, LSL #16
    MOVK  X15, #0x48e2, LSL #32
    MOVK  X15, #0x45f5, LSL #48
    MOVZ  X16, #0xfd59, LSL #0
    MOVK  X16, #0x4d97, LSL #16
    MOVK  X16, #0x3614, LSL #32
    MOVK  X16, #0x67f1, LSL #48
    MOVZ  X17, #0x9e20, LSL #0
    MOVK  X17, #0x6f9c, LSL #16
    MOVK  X17, #0x6ed7, LSL #32
    MOVK  X17, #0x2ea8, LSL #48
    MOVZ  X18, #0x98a7, LSL #0
    MOVK  X18, #0xc457, LSL #16
    MOVK  X18, #0xffcc, LSL #32
    MOVK  X18, #0x9237, LSL #48
    MOVZ  X19, #0xc8b4, LSL #0
    MOVK  X19, #0x9bd4, LSL #16
    MOVK  X19, #0x417, LSL #32
    MOVK  X19, #0x9048, LSL #48
    MOVZ  X20, #0x5c35, LSL #0
    MOVK  X20, #0x546a, LSL #16
    MOVK  X20, #0x5d4, LSL #32
    MOVK  X20, #0x3048, LSL #48
    MOVZ  X21, #0x7b44, LSL #0
    MOVK  X21, #0x9443, LSL #16
    MOVK  X21, #0x229a, LSL #32
    MOVK  X21, #0x1b23, LSL #48
    MOVZ  X22, #0x5e1d, LSL #0
    MOVK  X22, #0x8af5, LSL #16
    MOVK  X22, #0xe06a, LSL #32
    MOVK  X22, #0x4159, LSL #48
    MOVZ  X23, #0xb498, LSL #0
    MOVK  X23, #0x2aa7, LSL #16
    MOVK  X23, #0xf1, LSL #32
    MOVK  X23, #0xbfae, LSL #48
    MOVZ  X24, #0x6f8, LSL #0
    MOVK  X24, #0xcbbb, LSL #16
    MOVK  X24, #0x6d58, LSL #32
    MOVK  X24, #0xdf84, LSL #48
    MOVZ  X25, #0x9816, LSL #0
    MOVK  X25, #0xf2dd, LSL #16
    MOVK  X25, #0xc1f4, LSL #32
    MOVK  X25, #0x4c98, LSL #48
    MOVZ  X26, #0xf7ec, LSL #0
    MOVK  X26, #0x918d, LSL #16
    MOVK  X26, #0x17a1, LSL #32
    MOVK  X26, #0x2cc3, LSL #48
    MOVZ  X27, #0x8c14, LSL #0
    MOVK  X27, #0xceca, LSL #16
    MOVK  X27, #0x81e, LSL #32
    MOVK  X27, #0x6be1, LSL #48
    MOVZ  X28, #0xbcaf, LSL #0
    MOVK  X28, #0xd5fe, LSL #16
    MOVK  X28, #0x16b1, LSL #32
    MOVK  X28, #0xdc4f, LSL #48
    MOVZ  X29, #0xc84f, LSL #0
    MOVK  X29, #0xf39, LSL #16
    MOVK  X29, #0x6992, LSL #32
    MOVK  X29, #0xf18a, LSL #48
    MOVZ  X26, #0x14, LSL #0
TaishanIntMduP01_label_709:
    ADD  X27, X28, X27, LSL #14
    ORN  W28, W24, W21, ASR #17
    SUBS  W21, W20, W7, LSL #24
    SUBS  W16, W25, #0x2d2, LSL #12
    CLZ  X21, X15
    ADDS  W17, W2, W29, UXTB #3
    CSEL  W21, W17, W25, LT
    ADD  W15, W13, W7, ASR #27
    AND  W28, W20, W24, ROR #10
    SUB  X24, X16, W14, SXTB #4
    CRC32B  W7, W21, W24
    CLS  X7, X27
    ASRV  W15, W26, W24
    MOVN  X28, #0x8f1a, LSL #48
    ADC  W9, W17, W11
    SUB  W28, W21, W10, LSL #29
    CSINV  X12, X20, X16, VC
    UMSUBL  X20, W21, W20, X23
    MOVK  W14, #0xa95d, LSL #16
    ORR  V18.4H, #0x41
    ADCS  X28, X19, X8
    ANDS  X22, X27, X10, ASR #29
    SUBS  W18, W26, W24, UXTH #1
    ADCS  X24, X26, X6
    AND  W9, W7, #0x300030
    EXTR  W6, W22, W10, #0x2
    ORR  X28, X24, #0xff80000fff80000f
    BIC  W15, W12, W23, LSL #17
    AND  X23, X23, #0xfffffffffc0007ff
    CRC32W  W16, W26, W9
    LSLV  W24, W26, W16
    ADDS  X25, X16, #0x4b0
    CLS  X25, X11
    BICS  X22, X17, X2, LSR #11
    CSINV  X28, X6, X13, HI
    SUB  W12, W3, W17, SXTB #3
    LSLV  X13, X27, X25
    CSEL  W5, W18, W6, PL
    MADD  X22, X14, X26, X16
    SUBS  W5, W17, W20, UXTW #3
    CSINV  W10, W18, W21, CC
    LSLV  X13, X28, X20
    CRC32CX  W27, W19, X14
    ADDS  X3, X14, W20, UXTH #0
    BICS  W5, W15, W27, LSL #29
    CRC32H  W27, W20, W17
    MADD  X15, X16, X5, X11
    EOR  W13, W5, W17, LSL #1
    SUBS  X24, X12, W11, SXTB #4
    SUB  X11, X16, W27, SXTW #0
    ADD  X16, X16, W26, UXTB #4
    SUBS  X28, X9, #0x157
    EON  W28, W15, W24, ROR #17
    EON  X25, X14, X9, LSR #60
    CRC32H  W14, W19, W5
    CLS  V1.8H, V9.8H
    UMADDL  X2, W24, W3, X17
    CRC32X  W10, W11, X22
    CRC32CW  W19, W29, W13
    CRC32CB  W6, W22, W8
    ANDS  X18, X14, #0x3ffc000000000000
    CSINC  W2, W13, W28, VS
    CSNEG  W22, W26, W17, VC
    ADD  W28, W5, W16, SXTB #0
    BIC  V27.8B, V14.8B, V5.8B
    SMULH  X18, X15, X29
    ADDS  W24, W26, #0xb3
    SUB  W6, W7, #0xd9d, LSL #12
    ANDS  X5, X27, X22, LSL #31
    ORR  W25, W26, W17, LSR #17
    SUB  X23, X19, W27, UXTW #0
    EXTR  X20, X21, X28, #0x3e
    CLZ  V1.2S, V27.2S
    CRC32X  W13, W13, X26
    LSLV  W24, W7, W23
    SMSUBL  X11, W10, W29, X7
    LSLV  W24, W23, W7
    AND  W2, W19, #0xfffe01ff
    UMADDL  X3, W22, W20, X28
    ORN  W29, W2, W25, LSR #13
    ADDS  W10, W8, #0xe98
    EOR  X22, X10, #0xc000003fc000003f
    CRC32X  W23, W24, X12
    ORN  W27, W16, W26, LSR #29
    EOR  W22, W26, #0x180018
    EOR  W29, W2, W18, LSR #8
    SUB  W28, W15, W21, LSL #7
    SUB  X17, X8, #0x2e7, LSL #12
    ASRV  W3, W6, W3
    SUBS  W27, W18, #0x329, LSL #12
    LSRV  W3, W20, W27
    ORR  X23, X29, #0xffff0000000003ff
    LSRV  X25, X3, X17
    ADCS  X28, X21, X12
    CRC32CB  W23, W25, W27
    EOR  W11, W14, #0xfff007ff
    EOR  X13, X12, X8, LSL #15
    MOVN  W7, #0x3678, LSL #0
    AND  X6, X17, #0xff00000007ffffff
    SUBS  X19, X8, #0x926, LSL #12
    EOR  X24, X20, X7, ASR #29
    UBFM  W13, W17, #0x1d, #0xf
    ORR  X28, X28, #0x180000
    SUBS  W11, W15, #0x64c, LSL #12
    CRC32CX  W6, W13, X7
    BIC  V1.16B, V14.16B, V11.16B
    LSLV  X11, X28, X5
    ADD  X11, X11, #0xb28
    UMADDL  X19, W21, W17, X23
    ORN  X23, X22, X20, ASR #20
    ANDS  W24, W23, W27, ROR #29
    CRC32CW  W16, W11, W7
    EOR  X18, X5, #0xf0f0f0f0f0f0f0f
    BIC  W22, W18, W17, ASR #30
    MOVN  W2, #0x2404, LSL #16
    SUB  W13, W15, #0x5c9, LSL #12
    AND  W8, W10, #0x1fffe000
    LSRV  X7, X3, X23
    ADDS  X24, X2, X22, LSR #62
    SUB  W18, W27, W2, ASR #23
    ANDS  X15, X18, #0xfffffff000000007
    ADDS  W3, W5, W2, LSR #4
    CSINC  W21, W13, W2, CC
    SUBS  X16, X9, X18, UXTX #4
    CSEL  X3, X23, X27, LT
    EON  W28, W21, W9, ASR #12
    ANDS  W13, W29, #0xc00fc00f
    SUB  W21, W25, W22, UXTH #4
    MOVN  W20, #0x3a14, LSL #0
    MOVZ  X13, #0x5452, LSL #16
    MADD  W5, W28, W17, W23
    SUBS  X5, X5, X9, LSL #10
    ADC  X28, X18, X14
    SBFM  W13, W2, #0x1c, #0x14
    ADD  W5, W2, W16, ASR #11
    ORR  W18, W13, W21, ASR #14
    CRC32CW  W9, W10, W2
    CLZ  V15.8B, V18.8B
    CLZ  W25, W5
    ORR  V28.4S, #0x61, LSL #8
    ASRV  X17, X9, X28
    CLZ  X3, X3
    LSLV  W15, W24, W13
    SUBS  X2, X26, #0xddf
    MOVZ  W25, #0x22e4, LSL #16
    CRC32X  W29, W10, X28
    ANDS  X24, X2, X18, LSL #31
    ADD  X17, X17, X3, LSR #55
    LSRV  X7, X23, X5
    ADD  W14, W17, W15, UXTB #2
    ORR  X15, X8, #0xc1ffffffc1ffffff
    ORR  V20.2S, #0xd8, LSL #24
    CRC32W  W24, W24, W28
    CRC32H  W24, W19, W8
    ADD  W3, W25, W19, UXTH #3
    MADD  X15, X7, X6, X9
    LSRV  X13, X6, X5
    CSNEG  W14, W25, W16, CS
    ADD  W14, W22, W16, UXTW #3
    MOVN  W25, #0x3973, LSL #16
    CRC32CH  W3, W7, W21
    ADCS  W2, W29, W7
    ADDS  W3, W20, W2, UXTW #4
    SMULH  X16, X8, X24
    ORR  V27.8B, V2.8B, V11.8B
    SBFM  X16, X16, #0x2b, #0x20
    CLS  W5, W7
    SBFM  W16, W27, #0x9, #0xa
    SMULH  X8, X25, X11
    ANDS  W13, W26, W15, ASR #24
    MADD  W2, W3, W19, W10
    BIC  W2, W27, W16, ROR #25
    ANDS  W5, W21, #0xfffe07ff
    ORR  V15.8B, V8.8B, V20.8B
    ADC  X13, X14, X10
    MOVK  W12, #0xbd7b, LSL #0
    CLS  V4.4S, V3.4S
    ANDS  W8, W11, #0xfffe01ff
    ADDS  X19, X24, #0x6f8
    ADCS  X18, X26, X18
    ADDS  X5, X12, X11, LSL #25
    UMADDL  X23, W21, W8, X25
    SUBS  W5, W26, W27, LSL #12
    ADCS  X2, X16, X7
    SUB  X6, X10, X7, LSR #6
    CSINV  X14, X13, X6, NV
    ADDS  W11, W10, W13, LSR #28
    ANDS  W19, W14, #0xe0000003
    SMULH  X27, X5, X19
    LSRV  X21, X25, X23
    SBFM  X18, X8, #0x31, #0x3b
    SUB  W2, W10, W24, ASR #20
    CSINV  W11, W13, W25, NV
    CLZ  W14, W28
    MOVZ  W18, #0xac3f, LSL #0
    CRC32H  W28, W13, W11
    EON  W3, W21, W28, LSR #31
    UBFM  X22, X29, #0x0, #0x7
    ORN  X6, X14, X5, ASR #20
    SUBS  W24, W29, #0x454, LSL #12
    SUBS  X26, X26, #0x1
    B.NE  TaishanIntMduP01_label_709
    MOVZ  X15, #0x138b, LSL #0
    MOVK  X15, #0xc69c, LSL #16
    SUB  X2, X15, X2
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X13, X27, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X21, #0xc001, LSL #0
    MOVK  X21, #0x265f, LSL #16
    SUB  X20, X21, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X24, #0xfd9b, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X20, X24, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X10, #0xfff3, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0x3f, LSL #48
    SUB  X12, X10, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x181, LSL #0
    MOVK  X9, #0xc07e, LSL #16
    SUB  X11, X9, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X25, #0x181, LSL #0
    MOVK  X25, #0xc07e, LSL #16
    SUB  X18, X25, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X22, #0xfff3, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0x3f, LSL #48
    SUB  X24, X22, X10
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X10, #0x1, LSL #0
    SUB  X23, X10, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP01_TestFail
    MOVZ  X24, #0x138b, LSL #0
    MOVK  X24, #0xc69c, LSL #16
    SUB  X21, X24, X15
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x1, LSL #0
    SUB  X12, X9, X16
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X13, X24, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X17, X28, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xc000, LSL #16
    SUB  X22, X5, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X8, X21, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X23, X19, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X5, X20, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x181, LSL #0
    MOVK  X9, #0xc07e, LSL #16
    SUB  X12, X9, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X13, X20, X27
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP01_TestFail
    MOVZ  X5, #0xec32, LSL #0
    MOVK  X5, #0xd34, LSL #16
    SUB  X26, X5, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
TaishanIntMduP01_label_182:
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X26, #0x14, LSL #0
TaishanIntMduP01_label_735:
    EXTR  W8, W25, W8, #0x16
    ADD  W2, W29, W20, UXTW #2
    BIC  X7, X17, X26, LSR #12
    ADDS  W22, W7, W22, SXTH #2
    LSRV  X11, X20, X6
    ADCS  X11, X14, X29
    CLS  V4.8B, V27.8B
    CLZ  W12, W9
    ADDS  X24, X28, W10, SXTH #3
    ANDS  W29, W25, #0x10001000
    ORR  V21.16B, V20.16B, V21.16B
    ORR  X19, X24, X29, ROR #50
    ANDS  W9, W22, #0xc00fc00f
    ADDS  W3, W17, #0xf70
    MOVZ  X27, #0x30ac, LSL #0
    ORR  V20.4S, #0xfb, LSL #24
    CRC32X  W19, W29, X15
    ORR  V1.4H, #0xe
    ANDS  W27, W9, W12, LSR #6
    SUBS  W22, W15, #0x0
    AND  W3, W12, #0x7ffff0
    BIC  W10, W16, W24
    SUBS  W16, W19, W23, ASR #23
    ADC  W21, W20, W11
    CRC32CX  W16, W29, X7
    CRC32W  W22, W27, W17
    BICS  W16, W5, W14, ASR #16
    SUB  W29, W14, W21, ASR #4
    SMULH  X27, X6, X17
    CSINC  X13, X27, X15, HI
    MOVN  W16, #0x47f, LSL #0
    UMULH  X10, X6, X18
    CRC32H  W2, W12, W29
    SUB  W16, W8, W13, UXTH #1
    EOR  X22, X11, X9, LSR #51
    BIC  V25.8B, V18.8B, V10.8B
    CSNEG  W29, W18, W17, VS
    MADD  W15, W10, W7, W23
    UMADDL  X14, W24, W2, X14
    SUB  X17, X29, X23, UXTX #4
    ORR  V19.4H, #0xcc
    EOR  X28, X5, X3, ROR #1
    ADDS  W20, W2, W23, SXTH #1
    MADD  W13, W8, W29, W13
    EOR  X15, X19, X11, ASR #45
    SMADDL  X3, W15, W24, X28
    ADDS  W27, W3, #0x1ad, LSL #12
    CSEL  W3, W18, W9, AL
    ADDS  X5, X22, X9, LSL #44
    ADDS  W5, W15, W6, UXTX #0
    MADD  W8, W8, W16, W11
    ADDS  W2, W24, #0xe5c, LSL #12
    ADC  W6, W18, W2
    UMSUBL  X25, W3, W12, X22
    CLS  V19.4S, V22.4S
    UMULH  X24, X18, X25
    ADDS  X11, X7, #0x5c9
    EON  X11, X8, X12, LSL #57
    BIC  X27, X18, X11, ROR #53
    SUB  W20, W23, #0x160, LSL #12
    MOVZ  W24, #0x7f3e, LSL #16
    ADDS  X18, X18, #0xcdc, LSL #12
    EOR  X13, X12, X20, LSL #19
    ADD  W20, W27, #0xc70
    SUB  X24, X14, W6, UXTW #2
    SUB  W23, W20, W3, UXTX #2
    MOVN  W3, #0xf70, LSL #0
    CSEL  W25, W29, W24, VS
    CLZ  W18, W15
    ANDS  W3, W20, W24, LSL #29
    ORN  X28, X23, X15, ROR #48
    EXTR  X11, X18, X19, #0x9
    ADDS  X10, X21, #0xd1a, LSL #12
    SUBS  X20, X21, W5, SXTB #0
    ADD  X13, X5, W20, SXTW #3
    ADD  W29, W25, W28, SXTW #2
    SBFM  X24, X18, #0x3c, #0x25
    ORR  X17, X9, X29, LSL #37
    LSRV  W24, W2, W27
    EXTR  W11, W23, W9, #0x1c
    ADCS  W6, W11, W12
    CRC32CH  W6, W14, W24
    CLZ  V28.2S, V29.2S
    CSNEG  X2, X27, X11, CC
    MOVZ  X12, #0xf13c, LSL #32
    SUB  X2, X12, W17, UXTH #1
    UMADDL  X13, W19, W12, X12
    UBFM  W15, W18, #0x10, #0xc
    ADD  W2, W19, #0x171, LSL #12
    CSEL  X18, X14, X18, VS
    CRC32H  W6, W3, W6
    CRC32CX  W12, W21, X11
    EXTR  W7, W11, W27, #0xc
    AND  W13, W7, W19, ASR #25
    ORR  X11, X5, #0x7ff000007ff
    SMSUBL  X10, W20, W20, X9
    SBFM  W11, W26, #0x5, #0x9
    CSINV  X9, X27, X19, EQ
    BICS  W19, W9, W7, LSL #14
    ANDS  W11, W27, W15, ASR #30
    CRC32CX  W25, W21, X10
    UMULH  X24, X2, X29
    CSINV  X8, X15, X14, LE
    CRC32CB  W15, W27, W26
    CRC32CX  W19, W13, X14
    CRC32CB  W25, W18, W7
    MADD  W18, W24, W14, W17
    BICS  X16, X24, X3, LSL #46
    SBFM  X24, X12, #0x29, #0x3e
    EXTR  X11, X17, X28, #0x1f
    CSINC  W6, W11, W8, NV
    MOVN  W3, #0x2fec, LSL #16
    SUBS  X19, X12, W26, UXTH #3
    BICS  W8, W19, W10, ROR #31
    ADC  X25, X28, X11
    MOVK  W7, #0x1580, LSL #0
    UBFM  X13, X18, #0x3d, #0x16
    EOR  X13, X8, X23, LSL #13
    ADC  X27, X10, X9
    CRC32X  W13, W27, X14
    CLS  X17, X15
    ADDS  X17, X25, #0xbef, LSL #12
    SUBS  X14, X20, #0x831
    AND  W18, W6, #0x7e007e00
    CSEL  W20, W22, W9, VS
    SBFM  X14, X14, #0x19, #0x17
    CRC32CB  W10, W6, W7
    UMSUBL  X18, W19, W6, X6
    SBFM  X3, X26, #0x34, #0x3b
    SUBS  W13, W13, W12, LSR #26
    LSLV  W3, W16, W27
    CLS  V13.2S, V2.2S
    ANDS  X12, X3, X6, ROR #35
    CRC32B  W17, W6, W29
    MOVK  X25, #0x33a5, LSL #0
    CLZ  V21.4H, V22.4H
    SUB  W7, W17, #0xc7, LSL #12
    ADCS  W23, W14, W3
    ADCS  X20, X22, X24
    ORR  W6, W17, W12, LSL #27
    LSLV  X29, X13, X18
    CRC32CX  W25, W29, X19
    CRC32X  W16, W10, X2
    CLS  V1.16B, V24.16B
    CSEL  W28, W21, W18, NE
    MOVZ  X10, #0xa520, LSL #48
    CSINC  X23, X2, X26, AL
    CLS  X3, X20
    ANDS  W23, W22, #0xdddddddd
    SMULH  X23, X15, X3
    CRC32W  W2, W20, W20
    CRC32B  W15, W25, W25
    LSLV  W24, W10, W20
    ORR  V15.2S, #0x11
    ORN  X17, X13, X20, LSL #19
    ADC  W7, W6, W19
    LSLV  X22, X8, X2
    EXTR  W22, W10, W24, #0x5
    ANDS  W16, W10, W20, ASR #6
    EON  X3, X6, X26, ASR #6
    CSEL  W21, W8, W28, PL
    EOR  X27, X21, #0xffffff8000007fff
    ANDS  X23, X10, #0xffffc0000000007f
    SUBS  W16, W8, W13, UXTB #1
    ORR  V3.4S, #0x8e, LSL #24
    CSINV  X7, X20, X15, LE
    CSINC  X17, X21, X7, LS
    AND  W18, W26, W23, LSR #23
    ADCS  X8, X22, X8
    LSLV  W18, W13, W16
    CLS  W19, W24
    SBFM  W9, W22, #0x1a, #0x8
    SUB  X21, X14, #0x41b
    CLZ  V23.8H, V0.8H
    UMULH  X24, X17, X9
    ADCS  W24, W12, W10
    SUB  W9, W14, W26, LSR #24
    EON  X3, X17, X14, LSR #0
    ADDS  X19, X8, #0x840
    ORR  V11.4H, #0x56, LSL #8
    LSRV  W11, W3, W3
    MOVN  X24, #0xc99c, LSL #48
    ADD  W10, W25, W18, ASR #2
    AND  X21, X29, #0x1f00000000
    ADD  X8, X25, W28, UXTW #2
    CLZ  X19, X14
    ADD  W29, W22, W19, LSR #28
    CLZ  V21.8H, V25.8H
    ADC  X24, X16, X13
    ADC  W22, W24, W24
    BICS  X3, X2, X22, ASR #36
    UBFM  W17, W26, #0xf, #0x12
    SMULH  X28, X12, X23
    SMULH  X3, X15, X15
    UBFM  W22, W8, #0x4, #0x1c
    EON  X9, X18, X5, LSR #48
    ORR  V10.8B, V25.8B, V22.8B
    EOR  X6, X17, #0x3ffc3ffc3ffc3ffc
    SUB  X17, X21, W12, UXTW #4
    CRC32CH  W19, W21, W15
    SUBS  X26, X26, #0x1
    B.NE  TaishanIntMduP01_label_735
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X14, X11, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X6, #0xed1d, LSL #0
    MOVK  X6, #0xea3d, LSL #16
    SUB  X7, X6, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X27, #0xed1d, LSL #0
    MOVK  X27, #0xea3d, LSL #16
    SUB  X18, X27, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP01_TestFail
    MOVZ  X11, #0xfc9a, LSL #0
    MOVK  X11, #0xb7f5, LSL #16
    SUB  X8, X11, X8
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x4fef, LSL #0
    MOVK  X26, #0x4fb3, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X14, X26, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X28, #0xfc9a, LSL #0
    MOVK  X28, #0xb7f5, LSL #16
    SUB  X27, X28, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X9, X17, X13
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X26, #0xf5fc, LSL #0
    MOVK  X26, #0xb7, LSL #16
    SUB  X21, X26, X15
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X15, #0xf773, LSL #0
    MOVK  X15, #0x519b, LSL #16
    SUB  X28, X15, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x580, LSL #32
    MOVK  X26, #0xfffc, LSL #48
    SUB  X9, X26, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X16, X14, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP01_TestFail
    MOVZ  X19, #0x5fc9, LSL #0
    MOVK  X19, #0x17f, LSL #16
    SUB  X9, X19, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xa520, LSL #48
    SUB  X20, X5, X23
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP01_TestFail
    MOVZ  X8, #0x1605, LSL #0
    MOVK  X8, #0xd56, LSL #16
    MOVK  X8, #0x1, LSL #32
    SUB  X29, X8, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X25, #0xfc96, LSL #0
    MOVK  X25, #0xb7f5, LSL #16
    SUB  X17, X25, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x580, LSL #32
    MOVK  X28, #0xfffc, LSL #48
    SUB  X17, X28, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X21, X27, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    MOVZ  X8, #0xa, LSL #0
TaishanIntMduP01_label_762:
    ANDS  X28, X12, X27, ROR #44
    BICS  W26, W24, W8, ROR #25
    AND  W19, W20, #0xfe0ffe0f
    CSEL  X29, X19, X27, LS
    MOVZ  X26, #0xff2c, LSL #16
    ORR  W17, W12, #0x40004
    ADD  W9, W14, W28, UXTH #2
    MOVN  W21, #0x54cb, LSL #0
    ANDS  W22, W3, #0xe01fe01f
    AND  W19, W25, #0x1c1c1c1c
    ADD  X21, X15, #0x942
    ANDS  X27, X9, X19, LSR #36
    CSINV  W18, W24, W24, VS
    AND  W2, W7, W15, ROR #29
    ADD  X9, X9, W7, SXTB #4
    UMADDL  X5, W5, W28, X27
    CLS  W12, W2
    ANDS  W13, W12, W15, ASR #7
    CSEL  X26, X27, X28, NE
    EXTR  W23, W8, W13, #0xd
    EOR  W20, W8, W23, LSR #7
    ASRV  W26, W11, W24
    EOR  W25, W22, W13, LSL #21
    EXTR  W5, W28, W12, #0x19
    EOR  X21, X22, #0xffffffffffc7ffff
    ANDS  X6, X24, #0x6666666666666666
    ADC  W19, W3, W28
    BICS  W16, W12, W9, LSL #3
    LSRV  X29, X22, X15
    EOR  W29, W23, W29, ROR #15
    CRC32CX  W20, W18, X21
    BIC  W25, W16, W6, ROR #26
    MOVZ  W21, #0x56d8, LSL #0
    ANDS  W13, W19, #0xffe007ff
    CRC32X  W13, W21, X13
    SUBS  W22, W3, W11, LSL #1
    SUBS  X21, X12, W2, UXTH #0
    CSEL  X19, X24, X17, PL
    CSINV  X15, X29, X27, CC
    MOVK  X7, #0xf098, LSL #48
    ANDS  X20, X13, X5, ASR #18
    ADCS  W2, W18, W27
    ADCS  W25, W10, W16
    CSINV  W28, W8, W29, HI
    ADC  W11, W21, W27
    ORR  X12, X6, #0x7e007e007e007e00
    ANDS  X18, X12, X17, ROR #30
    SUB  X6, X3, W15, UXTB #4
    CRC32CX  W25, W27, X2
    EON  X7, X11, X9, LSR #6
    MOVZ  W20, #0xca6, LSL #16
    MOVK  X27, #0x29b8, LSL #48
    LSLV  X19, X23, X18
    ADDS  X26, X23, W20, SXTW #3
    ADD  W21, W5, W13, UXTH #2
    SMULH  X6, X13, X16
    AND  X13, X12, #0x700000007000
    ORN  W12, W25, W18, ROR #25
    EOR  W13, W16, #0x44444444
    SBFM  W26, W24, #0x8, #0x1c
    ORR  W29, W28, #0x60006000
    ORR  W23, W11, W21, ROR #20
    BICS  W22, W28, W24, ASR #5
    ADDS  X18, X12, X24, LSR #61
    CRC32B  W7, W7, W16
    EOR  W24, W23, #0xffffc003
    SUBS  W27, W22, #0x455
    CSNEG  X10, X19, X23, HI
    UMULH  X3, X2, X6
    ORR  W6, W7, W7, LSL #13
    UMSUBL  X3, W21, W25, X29
    CLS  V2.4S, V28.4S
    CRC32CB  W3, W22, W22
    BICS  X11, X3, X22, LSR #44
    BICS  W29, W16, W23, LSR #3
    ADD  W7, W24, W10, SXTW #1
    SUB  W17, W26, #0x83, LSL #12
    ORN  X3, X19, X24, ROR #17
    SUBS  W26, W24, W24, UXTW #1
    ORR  X15, X13, #0x800007ff800007ff
    ADD  X24, X29, X15, ASR #58
    ADD  W19, W18, W6, UXTB #0
    SMADDL  X3, W20, W12, X5
    EOR  W3, W17, W21, ASR #21
    LSLV  W11, W25, W2
    ORR  W6, W18, W25, ASR #7
    CSINV  X18, X29, X22, GE
    EOR  W18, W5, W20, ROR #20
    ANDS  W19, W23, W25, LSL #28
    BIC  V27.8B, V1.8B, V19.8B
    ADD  W7, W8, #0xd7a
    ORR  X20, X14, X29, LSR #16
    ADDS  X5, X7, #0xd60
    CSINC  X5, X8, X15, PL
    ADD  X28, X18, #0xf3b
    EXTR  W28, W10, W26, #0x6
    UMADDL  X18, W16, W20, X2
    SUB  X16, X21, X10, ASR #39
    EXTR  W29, W23, W29, #0x0
    ORR  X13, X10, X14, ASR #16
    ADD  X3, X3, X18, LSR #41
    CRC32CH  W24, W5, W5
    EOR  W26, W19, W10, LSL #31
    MOVZ  X26, #0x7d5d, LSL #16
    CSINC  X7, X19, X15, PL
    ADDS  X20, X7, #0x876, LSL #12
    SUBS  W20, W23, #0xe8b, LSL #12
    ORR  X19, X21, #0x7fffffe07fffffe
    EOR  X20, X17, #0xffbfffbfffbfffbf
    ADDS  X28, X2, #0xcb2, LSL #12
    ADDS  X14, X28, X23, LSL #33
    CSEL  X10, X17, X28, NV
    ADDS  X25, X20, X8, LSL #31
    EOR  X22, X17, X3, ASR #43
    UMADDL  X5, W7, W29, X7
    ORN  X19, X18, X3, LSR #57
    ORR  W27, W23, W15, ASR #29
    ADD  X29, X17, X19, LSL #63
    SUB  W14, W29, W13, LSR #27
    SUB  X18, X3, #0x313
    SUBS  W12, W15, #0xb18
    ANDS  X17, X23, X6, ROR #45
    ADC  W19, W28, W18
    EON  X20, X10, X8, LSL #48
    SUBS  X26, X6, #0x7cc
    BIC  V8.8B, V29.8B, V28.8B
    ORN  W22, W6, W5, LSL #19
    MOVK  X22, #0x1d8c, LSL #16
    ADDS  X7, X17, X22, LSL #57
    SUB  W25, W23, W19, UXTX #4
    MOVZ  X15, #0x4efb, LSL #16
    CRC32H  W10, W17, W27
    ADD  W27, W15, W22, ASR #0
    LSRV  W20, W9, W27
    CRC32CB  W13, W22, W2
    CSINV  X25, X2, X24, VC
    AND  W23, W25, W3, LSR #11
    SMSUBL  X20, W20, W2, X7
    MADD  X13, X10, X7, X15
    EON  X17, X2, X23, LSR #28
    ADD  X6, X24, #0x4c5
    UMULH  X6, X7, X29
    ADCS  W6, W21, W6
    SUB  W26, W9, W21, LSR #17
    ADC  W5, W25, W11
    ORR  V28.4H, #0xf2, LSL #8
    ORR  X22, X23, X22, LSL #24
    ADDS  W27, W8, W21, UXTX #2
    UBFM  X12, X5, #0x14, #0x23
    ADC  X15, X5, X27
    SBFM  W15, W29, #0x11, #0x7
    ORR  W19, W13, W8, LSR #4
    SUB  X5, X6, X24, LSL #3
    CRC32CH  W17, W3, W13
    ADD  X29, X11, W23, UXTW #2
    BIC  W25, W24, W9, LSR #18
    ANDS  W15, W15, #0xe3e3e3e3
    UMADDL  X10, W24, W8, X25
    ADDS  X10, X22, X14, LSR #6
    CLZ  W3, W21
    BIC  V15.8B, V24.8B, V21.8B
    ASRV  W6, W17, W7
    CLZ  W20, W27
    ADDS  W3, W29, W5, LSL #8
    ADCS  X16, X15, X28
    ADC  X11, X11, X17
    MOVZ  X13, #0x1d8, LSL #16
    SBFM  X7, X2, #0x37, #0x8
    MADD  X22, X5, X8, X27
    BIC  W23, W29, W13, ASR #7
    ORR  W9, W15, W3, ASR #7
    CSNEG  X12, X27, X14, MI
    ORR  W10, W20, #0x1f80000
    CLZ  X6, X28
    ADDS  X5, X24, X27, SXTX #0
    SUBS  X26, X29, X5, LSR #0
    LSRV  X5, X26, X5
    CRC32X  W5, W21, X13
    SUB  X11, X15, W16, SXTH #2
    ORR  X11, X7, X7, ASR #30
    UMSUBL  X3, W23, W17, X23
    CLS  W14, W20
    ADD  W28, W13, #0x75, LSL #12
    BIC  V7.16B, V1.16B, V19.16B
    EOR  X27, X15, #0xfffffffffe003fff
    SUB  W28, W3, #0x0
TaishanIntMduP01_label_549:
    MOVN  X2, #0x23fb, LSL #32
    CSEL  W3, W27, W11, EQ
    SUB  X11, X20, W28, SXTW #0
    CRC32CW  W9, W9, W5
    ORR  X9, X17, X26, ROR #52
    UBFM  W14, W19, #0x2, #0x1f
    SUB  W11, W21, #0x8b5, LSL #12
    BIC  X6, X26, X8, ROR #46
    ADCS  X23, X29, X9
    SUB  W28, W2, #0x820
    LSRV  W22, W11, W15
    AND  W17, W16, #0xff07ff07
    ADDS  X26, X20, W25, UXTW #2
    AND  X18, X14, #0xfffff801ffffffff
    SUBS  X8, X8, #0x1
    B.NE  TaishanIntMduP01_label_762
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xdc04, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X15, X18, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X14, X22, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP01_TestFail
    MOVZ  X13, #0x7589, LSL #0
    MOVK  X13, #0x8c88, LSL #16
    SUB  X28, X13, X5
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP01_TestFail
    MOVZ  X15, #0x6727, LSL #0
    MOVK  X15, #0x7013, LSL #16
    SUB  X23, X15, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP01_TestFail
    MOVZ  X24, #0xfe00, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X5, X24, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X20, #0xfd5e, LSL #0
    MOVK  X20, #0xfe7a, LSL #16
    MOVK  X20, #0x701, LSL #32
    SUB  X29, X20, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X20, #0x3, LSL #0
    MOVK  X20, #0x1f8, LSL #16
    SUB  X3, X20, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X10, #0xd530, LSL #0
    MOVK  X10, #0x38e, LSL #16
    SUB  X7, X10, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP01_TestFail
    MOVZ  X12, #0x3000, LSL #0
    MOVK  X12, #0x8, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X18, X12, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP01_TestFail
    MOVZ  X22, #0x7589, LSL #0
TaishanIntMduP01_label_146:
    MOVK  X22, #0x8c88, LSL #16
    SUB  X16, X22, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP01_TestFail
    MOVZ  X22, #0x6727, LSL #0
    MOVK  X22, #0x7013, LSL #16
    SUB  X26, X22, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X26, X23, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x43ab, LSL #16
    SUB  X11, X14, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X9, #0x3, LSL #0
    MOVK  X9, #0x1f8, LSL #16
    SUB  X3, X9, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP01_TestFail
    MOVZ  X10, #0x2530, LSL #0
    MOVK  X10, #0x41a, LSL #16
    SUB  X15, X10, X21
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP01_TestFail
    MOVZ  X15, #0x6727, LSL #0
    MOVK  X15, #0x7013, LSL #16
    SUB  X17, X15, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail
    MOVZ  X15, #0xfe00, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X9, X15, X24
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X5, X19, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP01_TestFail
    MOVZ  X23, #0x3fff, LSL #0
    MOVK  X23, #0xfe00, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X29, X23, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP01_TestFail

TaishanIntMduP01_TestEnd:
    MOVZ  X1, #0x0, LSL #0
    STP  X1, X2,   [X0], #0x10
    STP  X3, X4,   [X0], #0x10
    STP  X5, X6,   [X0], #0x10
    STP  X7, X8,   [X0], #0x10
    STP  X9, X10,  [X0], #0x10
    STP  X11, X12, [X0], #0x10
    STP  X13, X14, [X0], #0x10
    STP  X15, X16, [X0], #0x10
    STP  X17, X18, [X0], #0x10
    STP  X19, X20, [X0], #0x10
    STP  X21, X22, [X0], #0x10
    STP  X23, X24, [X0], #0x10
    STP  X25, X26, [X0], #0x10
    STP  X27, X28, [X0], #0x10
    STP  X29, X30, [X0], #0x10
    LDP  X1, X2, [SP], #16
    MSR  NZCV, X1
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
TaishanIntMduP01_TestFail:
    STP  X1, X2,   [X0], #0x10
    STP  X3, X4,   [X0], #0x10
    STP  X5, X6,   [X0], #0x10
    STP  X7, X8,   [X0], #0x10
    STP  X9, X10,  [X0], #0x10
    STP  X11, X12, [X0], #0x10
    STP  X13, X14, [X0], #0x10
    STP  X15, X16, [X0], #0x10
    STP  X17, X18, [X0], #0x10
    STP  X19, X20, [X0], #0x10
    STP  X21, X22, [X0], #0x10
    STP  X23, X24, [X0], #0x10
    STP  X25, X26, [X0], #0x10
    STP  X27, X28, [X0], #0x10
    STP  X29, X30, [X0], #0x10
    LDP  X1, X2, [SP], #16
    MSR  NZCV, X1
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
