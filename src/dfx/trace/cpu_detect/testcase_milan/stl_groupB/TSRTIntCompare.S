.global TSRTIntCompare

.text
.p2align 4

TSRTIntCompare:

TSRTIntCompare_TestBegin:
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
    MOVZ  X2, #0x4c03, LSL #0
    MOVK  X2, #0x4aac, LSL #16
    MOVK  X2, #0x4fc9, LSL #32
    MOVK  X2, #0x9feb, LSL #48
    MOVZ  X3, #0xf076, LSL #0
    MOVK  X3, #0xef31, LSL #16
    MOVK  X3, #0x496d, LSL #32
    MOVK  X3, #0x9db0, LSL #48
    MOVZ  X4, #0x303b, LSL #0
    MOVK  X4, #0x6882, LSL #16
    MOVK  X4, #0xe306, LSL #32
    MOVK  X4, #0x2589, LSL #48
    MOVZ  X5, #0x1622, LSL #0
    MOVK  X5, #0xb199, LSL #16
    MOVK  X5, #0x1014, LSL #32
    MOVK  X5, #0xe31, LSL #48
    MOVZ  X7, #0x5a72, LSL #0
    MOVK  X7, #0x3f7f, LSL #16
    MOVK  X7, #0x7cd9, LSL #32
    MOVK  X7, #0xa626, LSL #48
    MOVZ  X9, #0x6c9f, LSL #0
    MOVK  X9, #0x7f65, LSL #16
    MOVK  X9, #0x3149, LSL #32
    MOVK  X9, #0xef12, LSL #48
    MOVZ  X10, #0xecca, LSL #0
    MOVK  X10, #0xee9c, LSL #16
    MOVK  X10, #0x441b, LSL #32
    MOVK  X10, #0x9433, LSL #48
    MOVZ  X11, #0x1b66, LSL #0
    MOVK  X11, #0x5e98, LSL #16
    MOVK  X11, #0x7208, LSL #32
    MOVK  X11, #0x34cb, LSL #48
    MOVZ  X12, #0x247b, LSL #0
    MOVK  X12, #0x6304, LSL #16
    MOVK  X12, #0x6c95, LSL #32
    MOVK  X12, #0x319a, LSL #48
    MOVZ  X13, #0xe7a1, LSL #0
    MOVK  X13, #0xe34f, LSL #16
    MOVK  X13, #0x3de8, LSL #32
    MOVK  X13, #0x8be0, LSL #48
    MOVZ  X14, #0x3db8, LSL #0
    MOVK  X14, #0xe06b, LSL #16
    MOVK  X14, #0x4f1c, LSL #32
    MOVK  X14, #0xe803, LSL #48
    MOVZ  X15, #0x5181, LSL #0
    MOVK  X15, #0x6fdb, LSL #16
    MOVK  X15, #0xe38f, LSL #32
    MOVK  X15, #0x1220, LSL #48
    MOVZ  X16, #0x2571, LSL #0
    MOVK  X16, #0xa3b5, LSL #16
    MOVK  X16, #0xb523, LSL #32
    MOVK  X16, #0x5c89, LSL #48
    MOVZ  X17, #0xbde6, LSL #0
    MOVK  X17, #0xe985, LSL #16
    MOVK  X17, #0x47e8, LSL #32
    MOVK  X17, #0x3ba3, LSL #48
    MOVZ  X18, #0x6260, LSL #0
    MOVK  X18, #0xdf29, LSL #16
    MOVK  X18, #0x65ad, LSL #32
    MOVK  X18, #0x7df6, LSL #48
    MOVZ  X19, #0x1b14, LSL #0
    MOVK  X19, #0x58a, LSL #16
    MOVK  X19, #0x8bfa, LSL #32
    MOVK  X19, #0x83e7, LSL #48
    MOVZ  X20, #0xecbf, LSL #0
    MOVK  X20, #0xa5d0, LSL #16
    MOVK  X20, #0xb5cf, LSL #32
    MOVK  X20, #0xb7c0, LSL #48
    MOVZ  X21, #0x63f5, LSL #0
    MOVK  X21, #0x7f24, LSL #16
    MOVK  X21, #0xf323, LSL #32
    MOVK  X21, #0x9a01, LSL #48
    MOVZ  X22, #0x94e5, LSL #0
    MOVK  X22, #0x337c, LSL #16
    MOVK  X22, #0x9147, LSL #32
    MOVK  X22, #0xc2c4, LSL #48
    MOVZ  X24, #0x5200, LSL #0
    MOVK  X24, #0xad86, LSL #16
    MOVK  X24, #0x9efa, LSL #32
    MOVK  X24, #0x4e43, LSL #48
    MOVZ  X26, #0xdcda, LSL #0
    MOVK  X26, #0x2291, LSL #16
    MOVK  X26, #0x6712, LSL #32
    MOVK  X26, #0x2628, LSL #48
    MOVZ  X27, #0xef68, LSL #0
    MOVK  X27, #0x5c66, LSL #16
    MOVK  X27, #0x7a1d, LSL #32
    MOVK  X27, #0xba4d, LSL #48
    MOVZ  X28, #0x4d18, LSL #0
    MOVK  X28, #0x1dfc, LSL #16
    MOVK  X28, #0x2465, LSL #32
    MOVK  X28, #0xadea, LSL #48
    MOVZ  X29, #0x7385, LSL #0
    MOVK  X29, #0x92b3, LSL #16
    MOVK  X29, #0x1f60, LSL #32
    MOVK  X29, #0x2508, LSL #48
    ADDS  X2, X28, X24, LSR #56
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x9d2e, LSL #0
    MOVK  X2, #0xe78f, LSL #16
    MOVK  X2, #0x87e6, LSL #32
    MOVK  X2, #0x91ba, LSL #48
    MOVZ  X3, #0x5943, LSL #0
    MOVK  X3, #0x3df6, LSL #16
    MOVK  X3, #0xa745, LSL #32
    MOVK  X3, #0x9a0e, LSL #48
    MOVZ  X4, #0x6d07, LSL #0
    MOVK  X4, #0x776c, LSL #16
    MOVK  X4, #0xec22, LSL #32
    MOVK  X4, #0xeb6f, LSL #48
    MOVZ  X5, #0x5a42, LSL #0
    MOVK  X5, #0x9355, LSL #16
    MOVK  X5, #0x9f8e, LSL #32
    MOVK  X5, #0x8ef, LSL #48
    MOVZ  X7, #0x8386, LSL #0
    MOVK  X7, #0xcb75, LSL #16
    MOVK  X7, #0x7359, LSL #32
    MOVK  X7, #0xcdd, LSL #48
    MOVZ  X9, #0x3f26, LSL #0
    MOVK  X9, #0x9fe1, LSL #16
    MOVK  X9, #0xa0b3, LSL #32
    MOVK  X9, #0xc4cb, LSL #48
    MOVZ  X10, #0xa48, LSL #0
    MOVK  X10, #0x1aad, LSL #16
    MOVK  X10, #0x16f, LSL #32
    MOVK  X10, #0x6ffb, LSL #48
    MOVZ  X11, #0xd24b, LSL #0
    MOVK  X11, #0x71b5, LSL #16
    MOVK  X11, #0x665b, LSL #32
    MOVK  X11, #0xb4b7, LSL #48
    MOVZ  X12, #0xd060, LSL #0
    MOVK  X12, #0x57a5, LSL #16
    MOVK  X12, #0x48f5, LSL #32
    MOVK  X12, #0x552, LSL #48
    MOVZ  X13, #0x2989, LSL #0
    MOVK  X13, #0x6deb, LSL #16
    MOVK  X13, #0xbd0b, LSL #32
    MOVK  X13, #0xfe10, LSL #48
    MOVZ  X14, #0x32ca, LSL #0
    MOVK  X14, #0x701e, LSL #16
    MOVK  X14, #0x72ab, LSL #32
    MOVK  X14, #0x9887, LSL #48
    MOVZ  X15, #0xf3ae, LSL #0
    MOVK  X15, #0xea3d, LSL #16
    MOVK  X15, #0x3487, LSL #32
    MOVK  X15, #0xc3a, LSL #48
    MOVZ  X16, #0x8f9, LSL #0
    MOVK  X16, #0x9601, LSL #16
    MOVK  X16, #0xe43, LSL #32
    MOVK  X16, #0xc8ce, LSL #48
    MOVZ  X17, #0xe779, LSL #0
    MOVK  X17, #0xc93c, LSL #16
    MOVK  X17, #0x73cc, LSL #32
    MOVK  X17, #0xc8c3, LSL #48
    MOVZ  X18, #0x90e8, LSL #0
    MOVK  X18, #0x3aed, LSL #16
    MOVK  X18, #0x1afd, LSL #32
    MOVK  X18, #0x6936, LSL #48
    MOVZ  X19, #0xba65, LSL #0
    MOVK  X19, #0x9e4b, LSL #16
    MOVK  X19, #0xc70f, LSL #32
    MOVK  X19, #0x2698, LSL #48
    MOVZ  X20, #0x4e1c, LSL #0
    MOVK  X20, #0xe8c1, LSL #16
    MOVK  X20, #0x6852, LSL #32
    MOVK  X20, #0x43a3, LSL #48
    MOVZ  X21, #0xcbc1, LSL #0
    MOVK  X21, #0x6ce4, LSL #16
    MOVK  X21, #0x6711, LSL #32
    MOVK  X21, #0x44f8, LSL #48
    MOVZ  X22, #0x59c5, LSL #0
    MOVK  X22, #0x9b12, LSL #16
    MOVK  X22, #0x8c08, LSL #32
    MOVK  X22, #0x764a, LSL #48
    MOVZ  X24, #0x7965, LSL #0
    MOVK  X24, #0x8c81, LSL #16
    MOVK  X24, #0xdedf, LSL #32
    MOVK  X24, #0x11a7, LSL #48
    MOVZ  X26, #0x88d4, LSL #0
    MOVK  X26, #0xe197, LSL #16
    MOVK  X26, #0xf23c, LSL #32
    MOVK  X26, #0xef2d, LSL #48
    MOVZ  X27, #0x787e, LSL #0
    MOVK  X27, #0x36ef, LSL #16
    MOVK  X27, #0xa764, LSL #32
    MOVK  X27, #0xc1a6, LSL #48
    MOVZ  X28, #0x6886, LSL #0
    MOVK  X28, #0xc67c, LSL #16
    MOVK  X28, #0xfd7f, LSL #32
    MOVK  X28, #0x85d, LSL #48
    MOVZ  X29, #0x929b, LSL #0
    MOVK  X29, #0x729c, LSL #16
    MOVK  X29, #0xa661, LSL #32
    MOVK  X29, #0x6fe6, LSL #48
    MOVZ  X14, #0xf, LSL #0
TSRTIntCompare_label_0:
    CMP  X27, #0xdb2
    CMP  X28, X26, ASR #25
    CMP  X24, X24, LSR #2
    CCMP  W14, #0x5, #0x2, PL
    CMN  X29, X29, LSR #63
    CMN  W22, #0x7eb, LSL #12
    CCMN  X29, #0x0, #0x2, VS
    CMN  X11, X24, UXTX #4
    CCMP  W22, W15, #0xd, AL
    CMP  W11, W10, LSR #5
    CMP  X3, X12, LSR #4
    CCMN  X14, X21, #0xa, PL
    CCMN  W4, W13, #0xd, CC
    CMN  W21, W28, LSL #10
    CCMN  X29, #0x10, #0xd, EQ
    CMP  W20, #0x22e, LSL #12
    CCMN  X5, #0x1f, #0x3, LE
    CMP  X22, X3, ASR #59
    CMN  X20, X2, ASR #38
    CMP  W12, #0x426, LSL #12
    CCMN  W24, W13, #0xd, NV
    CMN  X24, #0xa02, LSL #12
    CCMN  X22, X7, #0x4, VS
    CMP  W20, #0x137, LSL #12
    CMN  X17, X7, LSR #61
    CMP  W4, W7, LSR #22
    CMN  X22, #0xc8, LSL #12
    CMN  W28, #0x9ac, LSL #12
    CMP  X3, X15, LSL #11
    CCMP  X15, X28, #0x4, HI
    CMP  W13, #0x56b
    CMP  W9, W24, LSR #17
    CMN  X14, X15, SXTX #4
    CMP  X28, #0xe6
    CMN  X17, X2, LSR #51
    CMN  X17, X2, UXTX #4
    CMN  X11, W27, UXTB #3
    CCMP  W7, W20, #0x5, MI
    CMP  X28, #0x109
    CCMN  W3, W5, #0xe, LT
    CCMN  W7, W13, #0xb, CC
    CMN  X7, W5, SXTH #0
    CCMP  X3, X24, #0xe, VS
    CCMN  W24, W2, #0x6, LE
    CMP  X3, W17, UXTH #0
    CCMP  X26, #0x2, #0x1, EQ
    CCMN  X21, X27, #0x5, MI
    CCMP  X3, X28, #0xf, EQ
    CMP  W18, W13, LSR #26
    CCMN  W24, #0x1a, #0x6, LT
    CMP  X10, W9, UXTH #4
    CMN  W2, W22, SXTW #1
    CMP  W24, #0xe1b, LSL #12
    CMN  X21, X26, ASR #2
    CMN  W11, W4, LSL #26
    CMN  X5, W14, SXTH #0
    CCMN  W7, W12, #0x4, NV
    CMN  W7, W14, LSR #24
    CCMP  W7, #0xd, #0x9, LS
    CMN  W2, W24, ASR #1
    CMN  W18, W3, SXTW #4
    CMN  W17, #0x767, LSL #12
    CCMP  W29, W28, #0x6, NE
    CCMN  W2, #0x1f, #0x7, LS
    CMP  X24, W13, SXTB #0
    CMP  W17, #0x19a, LSL #12
    CMP  X26, W13, SXTW #3
    CMP  X11, #0xb0f
    CCMN  W21, #0x1e, #0x6, PL
    CMP  X7, X13, SXTX #2
    CMP  W4, W29, SXTW #1
    CMN  W20, W21, LSL #31
    CMN  W3, W26, LSR #6
    CCMP  X20, X4, #0xf, NE
    CCMP  W2, W9, #0xc, HI
    CCMP  X17, #0x14, #0xc, CS
    CMN  W15, W2, LSR #18
    CMP  W2, W10, LSL #14
    CMP  X28, #0xd17
    CCMN  X21, X13, #0x1, GT
    CCMN  X10, X28, #0x5, VC
    CMN  W29, W12, LSR #24
    CMN  W13, #0xbd5
    CCMP  X9, #0x1d, #0x0, VS
    CMN  X13, #0xc50
    CMP  X13, #0x6f9, LSL #12
    CMP  X12, X29, LSR #51
    CCMP  W17, #0x1e, #0x4, NE
    CMN  W22, W10, LSL #14
    CMN  X14, W13, SXTH #2
    CCMN  X18, #0x7, #0x2, NV
    CCMN  W27, W22, #0x7, PL
    CCMP  W22, #0xa, #0x9, LS
    CCMN  W18, #0x8, #0xf, VS
    CMN  X27, X9, ASR #24
    CMN  W7, W22, UXTH #0
    CMP  W5, W21, ASR #18
    CMN  W4, W10, LSL #8
    CMN  W3, #0xeb8
    CMN  X11, #0x3e7, LSL #12
    CCMN  X22, X15, #0xa, GT
    CMN  W10, W27, SXTB #2
    CMP  X27, #0xa38, LSL #12
    CCMP  W20, #0x4, #0x5, PL
    CCMN  W27, W10, #0x9, GT
    CMP  W5, #0xb94
    CCMN  X10, X20, #0x7, GE
    CCMN  X24, X21, #0x1, CS
    CMP  X17, X14, LSL #51
    CMP  W2, W4, LSR #26
    CMN  W3, W29, SXTW #1
    CCMP  W13, #0x0, #0xd, CC
    CMN  W22, W14, LSL #15
    CCMN  X2, X26, #0x5, PL
    CMN  W12, W26, LSR #16
    CCMP  X27, #0xd, #0xc, GT
    CCMN  X17, #0x1d, #0x4, GT
    CCMP  W13, #0x19, #0x3, CC
    CMP  W12, W9, SXTX #4
    CCMN  W9, W14, #0x9, CC
    CCMN  W29, W17, #0x4, MI
    CMP  X13, #0xaf8
    CCMP  W27, #0x12, #0x6, NV
    CMN  X26, W15, SXTB #3
    CCMP  W18, #0x7, #0x9, LE
    CMN  W12, W9, UXTW #1
    CMN  W24, W24, LSR #13
    CMN  W21, W22, UXTB #2
    CCMP  W20, #0x14, #0x1, LS
    CMP  X15, X5, LSR #1
    CMN  X29, X11, LSR #44
    CMN  W2, W27, ASR #15
    CMN  X3, #0x206, LSL #12
    CMP  W11, #0x92b
    CMP  X17, X29, LSL #30
    CCMN  X20, #0x2, #0xe, NE
    CMN  X15, #0x9bb
    CCMP  W13, W22, #0xc, HI
    CMP  X5, #0xbd5, LSL #12
    CMN  W15, #0xe1c, LSL #12
    CMP  X17, W14, UXTH #3
    CCMN  X27, #0xb, #0x3, CC
    CMP  W12, #0x6a6
    CMN  X20, X28, LSL #26
    CCMN  W2, #0xf, #0x5, NV
    CMP  X18, X28, UXTX #2
    CMN  X20, W7, SXTB #2
    CCMN  X4, X11, #0xc, LE
    CMN  X11, X3, LSR #18
    CMN  X13, X10, LSL #2
    CCMP  X2, X18, #0xc, CS
    CMN  X4, X3, ASR #4
    CMP  X5, #0xe95
    CCMP  W4, #0x2, #0x5, AL
    CMP  X10, W29, UXTW #2
    CCMN  W3, #0x2, #0x3, CS
    CMN  X7, W12, SXTB #0
    CCMP  W29, W12, #0x0, AL
    CMP  X7, X14, ASR #45
    CMP  X20, X18, ASR #63
    CCMP  W21, W11, #0x7, MI
    CCMN  X26, X22, #0x7, NE
    CMP  X29, #0xe60
    CMP  W7, W11, SXTB #1
    CMP  W11, W4, LSL #8
    CMN  W28, W10, UXTW #4
    CMP  W2, W13, LSL #21
    CMP  X11, #0x34a
    CMP  W15, W21, UXTH #4
    CCMP  X9, X18, #0xf, AL
    CCMP  X9, #0x12, #0xa, VC
    CMN  X5, X28, SXTX #2
    CMN  X21, #0x21d, LSL #12
    CCMN  W24, #0x6, #0x5, NV
    CMP  W12, #0x38d
    CMN  W17, #0xdf0, LSL #12
    CMP  X14, #0x921
    CMN  X4, #0x9e2, LSL #12
    CMP  X10, #0xbe9
    CCMP  X22, #0x5, #0x5, CC
    CMP  W11, #0x455
    CCMP  X4, #0x1f, #0xf, VC
    CMP  W18, W27, SXTH #4
    CCMP  X12, #0x17, #0x5, VC
    CCMN  W29, W14, #0xb, LE
    CMP  X15, X11, ASR #60
    CMN  W11, W17, ASR #1
    CMP  W22, #0x7cc, LSL #12
    CMP  W28, W17, LSL #4
    CMN  W22, W22, LSR #1
    CCMN  W2, #0x13, #0xc, NV
    CMN  W26, W7, LSR #25
    CMP  W12, W29, LSR #14
    CMN  X11, #0x82a
    CMN  X5, X18, SXTX #3
    CMP  X3, W20, SXTW #2
    CCMN  W9, #0x4, #0xd, GE
    CMN  X22, W28, SXTH #4
    CMP  X15, X27, LSR #0
    CCMP  X10, #0x3, #0x4, MI
    SUBS  X14, X14, #0x1
    B.NE  TSRTIntCompare_label_0
    MOVZ  X16, #0x9d2e, LSL #0
    MOVK  X16, #0xe78f, LSL #16
    MOVK  X16, #0x87e6, LSL #32
    MOVK  X16, #0x91ba, LSL #48
    SUB  X19, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X16, #0x5943, LSL #0
    MOVK  X16, #0x3df6, LSL #16
    MOVK  X16, #0xa745, LSL #32
    MOVK  X16, #0x9a0e, LSL #48
    SUB  X19, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X16, #0x6d07, LSL #0
    MOVK  X16, #0x776c, LSL #16
    MOVK  X16, #0xec22, LSL #32
    MOVK  X16, #0xeb6f, LSL #48
    SUB  X19, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X16, #0x5a42, LSL #0
    MOVK  X16, #0x9355, LSL #16
    MOVK  X16, #0x9f8e, LSL #32
    MOVK  X16, #0x8ef, LSL #48
    SUB  X19, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X16, #0x8386, LSL #0
    MOVK  X16, #0xcb75, LSL #16
    MOVK  X16, #0x7359, LSL #32
    MOVK  X16, #0xcdd, LSL #48
    SUB  X19, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X16, #0x3f26, LSL #0
    MOVK  X16, #0x9fe1, LSL #16
    MOVK  X16, #0xa0b3, LSL #32
    MOVK  X16, #0xc4cb, LSL #48
    SUB  X19, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X16, #0xa48, LSL #0
    MOVK  X16, #0x1aad, LSL #16
    MOVK  X16, #0x16f, LSL #32
    MOVK  X16, #0x6ffb, LSL #48
    SUB  X19, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X16, #0xd24b, LSL #0
    MOVK  X16, #0x71b5, LSL #16
    MOVK  X16, #0x665b, LSL #32
    MOVK  X16, #0xb4b7, LSL #48
    SUB  X19, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X16, #0xd060, LSL #0
    MOVK  X16, #0x57a5, LSL #16
    MOVK  X16, #0x48f5, LSL #32
    MOVK  X16, #0x552, LSL #48
    SUB  X19, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X16, #0x2989, LSL #0
    MOVK  X16, #0x6deb, LSL #16
    MOVK  X16, #0xbd0b, LSL #32
    MOVK  X16, #0xfe10, LSL #48
    SUB  X19, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X16, #0xf3ae, LSL #0
    MOVK  X16, #0xea3d, LSL #16
    MOVK  X16, #0x3487, LSL #32
    MOVK  X16, #0xc3a, LSL #48
    SUB  X19, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X16, #0xe779, LSL #0
    MOVK  X16, #0xc93c, LSL #16
    MOVK  X16, #0x73cc, LSL #32
    MOVK  X16, #0xc8c3, LSL #48
    SUB  X19, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X16, #0x90e8, LSL #0
    MOVK  X16, #0x3aed, LSL #16
    MOVK  X16, #0x1afd, LSL #32
    MOVK  X16, #0x6936, LSL #48
    SUB  X19, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X16, #0x4e1c, LSL #0
    MOVK  X16, #0xe8c1, LSL #16
    MOVK  X16, #0x6852, LSL #32
    MOVK  X16, #0x43a3, LSL #48
    SUB  X19, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X16, #0xcbc1, LSL #0
    MOVK  X16, #0x6ce4, LSL #16
    MOVK  X16, #0x6711, LSL #32
    MOVK  X16, #0x44f8, LSL #48
    SUB  X19, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X16, #0x59c5, LSL #0
    MOVK  X16, #0x9b12, LSL #16
    MOVK  X16, #0x8c08, LSL #32
    MOVK  X16, #0x764a, LSL #48
    SUB  X19, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X16, #0x7965, LSL #0
    MOVK  X16, #0x8c81, LSL #16
    MOVK  X16, #0xdedf, LSL #32
    MOVK  X16, #0x11a7, LSL #48
    SUB  X19, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X16, #0x88d4, LSL #0
    MOVK  X16, #0xe197, LSL #16
    MOVK  X16, #0xf23c, LSL #32
    MOVK  X16, #0xef2d, LSL #48
    SUB  X19, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X16, #0x787e, LSL #0
    MOVK  X16, #0x36ef, LSL #16
    MOVK  X16, #0xa764, LSL #32
    MOVK  X16, #0xc1a6, LSL #48
    SUB  X19, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X16, #0x6886, LSL #0
    MOVK  X16, #0xc67c, LSL #16
    MOVK  X16, #0xfd7f, LSL #32
    MOVK  X16, #0x85d, LSL #48
    SUB  X19, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X16, #0x929b, LSL #0
    MOVK  X16, #0x729c, LSL #16
    MOVK  X16, #0xa661, LSL #32
    MOVK  X16, #0x6fe6, LSL #48
    SUB  X19, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X11, #0xf, LSL #0
TSRTIntCompare_label_1:
    CCMN  X18, X28, #0xe, PL
    CCMN  W11, W20, #0x5, NV
    CMN  X24, W13, SXTW #3
    CMN  X15, X9, LSL #3
    CMN  X17, W17, SXTW #1
    CMN  W3, #0x9b6
    CMP  W27, W19, LSL #25
    CCMN  X21, X16, #0x4, MI
    CCMP  X29, #0x18, #0xe, GE
    CMP  W22, W22, LSL #16
    CMN  W11, W9, LSR #13
    CCMN  X11, X28, #0x7, LT
    CMP  W14, W15, SXTH #4
    CMN  W17, #0xf66
    CMN  W3, W7, ASR #2
    CCMN  X16, #0x3, #0xa, LS
    CMP  W28, #0x619
    CMN  X21, W19, SXTB #3
    CCMN  W14, #0x1, #0x3, GE
    CCMN  X3, X27, #0xb, NV
    CCMP  X12, #0x19, #0x7, AL
    CMP  W20, W15, UXTW #3
    CCMP  X24, #0x1a, #0x4, LT
    CCMN  X19, X24, #0xf, NV
    CMN  X9, X17, LSL #10
    CMN  W16, W24, LSR #19
    CCMP  X27, X11, #0x6, CS
    CCMN  W5, W2, #0xa, NV
    CCMP  X24, X18, #0x7, NE
    CCMN  X24, X19, #0x5, PL
    CCMP  X21, #0x14, #0xb, PL
    CCMP  W2, #0xd, #0xf, NV
    CMN  X14, #0x5fd
    CCMP  X11, X24, #0xa, LT
    CCMN  X19, #0x14, #0xb, MI
    CCMN  X17, #0x7, #0x7, GE
    CMP  W14, W11, UXTX #0
    CMP  X19, #0x81a, LSL #12
    CMN  W22, #0x578
    CCMN  W18, #0x13, #0xa, AL
    CMP  X2, X3, LSL #5
    CMN  X11, X27, LSR #31
    CMN  X5, X5, UXTX #1
    CMN  W29, #0x5bc
    CCMP  X5, #0x1b, #0x4, CS
    CCMN  X9, #0x19, #0x8, VS
    CCMP  X13, X5, #0x5, VS
    CCMN  W5, W18, #0x4, LS
    CMP  X17, W15, SXTB #4
    CMN  X11, #0x6ab, LSL #12
    CMN  W12, W19, LSL #2
    CMP  W29, W14, LSL #18
    CMP  X21, X17, SXTX #1
    CMP  W22, W2, ASR #10
    CCMP  X18, X12, #0x8, CS
    CMP  X5, W5, UXTH #3
    CCMN  W14, #0x15, #0x6, AL
    CCMN  X12, #0x10, #0x1, AL
    CCMN  X4, X3, #0xb, PL
    CCMP  X13, #0x4, #0xa, LS
    CCMN  X11, #0x5, #0xc, GT
    CCMN  W17, #0x16, #0x2, NE
    CMN  W14, #0xcc4
    CMN  X16, X27, ASR #24
    CCMP  X28, X12, #0x9, CC
    CMN  X14, #0xd5c, LSL #12
    CCMN  W28, W22, #0x4, HI
    CMP  X18, X17, LSR #12
    CCMP  W15, #0xf, #0x6, EQ
    CMP  X2, #0x5e4, LSL #12
    CCMN  W28, W9, #0xa, GE
    CMN  W28, W20, UXTX #1
    CMP  W21, W24, SXTX #2
    CMP  W2, W3, UXTH #4
    CMP  X27, X3, LSR #46
    CMN  W14, W14, ASR #9
    CMP  X20, X13, LSR #42
    CMP  X11, X4, LSL #36
    CCMN  X5, X17, #0x4, LS
    CCMP  X13, #0xd, #0xc, NE
    CMN  W11, W7, ASR #5
    CMN  W15, W14, LSL #21
    CMP  X15, #0x4a7
    CCMP  W24, W29, #0x8, LS
    CMP  W9, W17, LSL #4
    CMP  W22, W29, SXTX #0
    CMP  W9, W14, UXTH #2
    CMP  W24, #0x3e0, LSL #12
    CCMP  X18, #0x17, #0xa, LS
    CCMP  W2, W13, #0x5, GT
    CMP  X21, #0xc79
    CCMN  X20, X13, #0xc, CC
    CMN  W7, #0xe96
    CMP  X13, W20, SXTH #2
    CMN  W19, #0x745
    CCMP  X20, X9, #0xe, NV
    CMN  W4, #0xf05, LSL #12
    CMP  X3, #0xca3, LSL #12
    CMP  W5, W4, ASR #29
    CMN  X9, X24, LSR #51
    CMP  W2, W20, LSL #25
    CMN  W9, W13, SXTB #2
    CMN  X5, #0xf3b, LSL #12
    CMN  W29, W13, LSL #7
    CCMN  W7, #0xc, #0x8, HI
    CMN  W12, W17, SXTW #2
    CMP  X29, W24, SXTW #0
    CCMP  X7, X3, #0x4, NE
    CCMN  X18, X4, #0x7, NV
    CMP  W13, #0x7fd
    CMP  X7, X14, LSL #16
    CMN  W12, W2, SXTX #2
    CMP  W7, W22, UXTH #3
    CMN  X18, X7, ASR #22
    CCMP  X29, X18, #0xc, GE
    CMP  W4, #0x4fa
    CMP  W16, W24, LSR #18
    CCMP  X2, X12, #0x2, CC
    CMN  W3, W5, LSL #8
    CCMP  X24, X22, #0x4, HI
    CMP  W24, W20, UXTB #0
    CCMP  W9, W20, #0x7, HI
    CMP  W20, #0x13f
    CCMN  W22, W22, #0x2, LS
    CCMN  W19, #0xd, #0xd, GT
    CMN  X15, #0x34f, LSL #12
    CCMN  X12, X21, #0xf, NV
    CMP  X18, X27, UXTX #0
    CCMP  X22, X18, #0xd, GE
    CMN  X11, #0x835
    CCMN  X24, #0x12, #0x1, CS
    CMP  W28, W3, ASR #25
    CMN  W16, #0xe45, LSL #12
    CCMN  W28, #0x2, #0x8, GT
    CMP  X21, #0xa25, LSL #12
    CMP  X27, #0x6ce, LSL #12
    CMP  X15, #0x584, LSL #12
    CMN  X18, #0xd4a, LSL #12
    CCMN  X24, X19, #0x5, PL
    CMN  W28, #0x6e1
    CMN  X17, X13, LSR #30
    CMN  W22, W2, ASR #24
    CMN  X15, X15, LSR #44
    CCMP  W18, W4, #0x2, VS
    CCMP  W13, #0x1a, #0x4, GT
    CCMP  X19, X12, #0xc, EQ
    CCMP  W12, W4, #0xd, MI
    CMN  W29, W27, LSL #15
    CMP  W3, W28, LSR #25
    CMN  X4, X7, ASR #27
    CMN  X20, #0xdc7
    CMN  X4, #0xbc, LSL #12
    CCMP  X4, X9, #0x0, GT
    CCMP  W28, #0x5, #0x7, PL
    CMN  W18, #0x2e9, LSL #12
    CCMP  X24, #0x1, #0x5, VC
    CCMP  W15, W16, #0xa, NV
    CMP  X28, W16, UXTW #1
    CMP  X5, X20, LSR #53
    CCMN  X22, X12, #0x0, MI
    CMP  W15, #0x18d, LSL #12
    CMP  W21, #0x9fb, LSL #12
    CCMN  W11, #0x12, #0xd, VS
    CCMN  X9, X15, #0x1, GE
    CCMP  X19, X13, #0xd, NE
    CMN  W19, W15, ASR #30
    CCMN  X28, #0x7, #0xe, GT
    CMN  W19, W11, UXTX #2
    CMP  X7, #0xe61
    CCMP  X14, X21, #0x4, LT
    CCMN  W20, W17, #0xb, GT
    CMP  W14, W9, LSR #24
    CMP  X14, W9, UXTB #1
    CCMP  X15, #0x2, #0x0, LT
    CMN  W20, W21, LSL #25
    CMP  X5, #0x33a
    CMN  W16, W7, UXTB #4
    CCMN  W13, #0x15, #0x7, EQ
    CMP  W14, W18, SXTB #3
    CMN  W16, #0xa23
    CMP  W13, W13, SXTX #0
    CCMN  X16, #0xd, #0xd, LT
    CCMN  X3, #0xd, #0x7, CC
    CMP  X14, X11, LSR #2
    CMP  W9, W19, SXTX #4
    CMP  X27, X27, UXTX #2
    CCMN  X11, #0x15, #0x8, PL
    CMN  X2, X21, ASR #20
    CMP  X28, X20, UXTX #4
    CCMP  X4, #0x1b, #0x3, EQ
    CCMN  W27, #0xb, #0xa, MI
    CMP  W29, #0x79d, LSL #12
    CMN  X9, #0x5c0
    CMP  W24, W2, LSL #20
    CCMP  X29, X14, #0xd, LS
    CCMN  X14, #0x17, #0x4, NE
    CMN  X21, W15, SXTH #0
    CMN  X9, W9, SXTB #1
    CMP  W2, W18, ASR #15
    CCMN  W14, W12, #0xb, GT
    SUBS  X11, X11, #0x1
    B.NE  TSRTIntCompare_label_1
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
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
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
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
    MOVZ  X7, #0xf, LSL #0
TSRTIntCompare_label_2:
    CMN  X27, X27, SXTX #2
    CMP  X28, X21, LSR #16
    CMN  X29, W26, UXTH #3
    CCMN  X7, X7, #0x0, LE
    CMN  W5, W27, SXTW #3
    CMP  W18, W10, LSR #19
    CMN  X26, W22, UXTB #2
    CCMP  W13, W11, #0x3, GT
    CCMN  W10, W21, #0x6, AL
    CMP  W21, W11, LSL #29
    CCMP  W28, #0xe, #0x9, HI
    CMN  W10, W29, ASR #12
    CMN  W28, W9, UXTX #0
    CCMN  X16, X7, #0x4, LE
    CCMN  X12, X4, #0x9, PL
    CMN  W26, #0x191
    CCMP  X26, #0x1, #0x6, VS
    CMN  W22, #0x95e
    CCMP  X28, X9, #0x1, NV
    CMP  W24, W16, UXTH #4
    CMP  X18, #0x871
    CMN  W4, #0x2b0, LSL #12
    CCMN  X11, X7, #0xb, AL
    CMP  W11, W27, SXTW #0
    CCMP  W3, W15, #0xf, CS
    CMP  W24, #0x128, LSL #12
    CCMP  X17, X11, #0x7, CC
    CCMP  W21, W9, #0xf, CC
    CMP  W27, W7, LSL #4
    CCMN  X27, X24, #0x7, CC
    CCMP  X17, #0xe, #0xe, VC
    CCMN  W9, #0x4, #0xc, GT
    CCMN  X24, #0xc, #0xf, VS
    CMN  X11, X5, LSR #23
    CCMP  W14, #0x14, #0x0, VC
    CCMN  X21, X4, #0x9, GE
    CCMN  X21, #0x2, #0x6, GE
    CMN  X21, W29, UXTB #0
    CCMN  W22, W16, #0xb, MI
    CMP  W27, W16, UXTW #4
    CCMN  X3, X14, #0x0, LS
    CCMN  X19, #0xa, #0xb, MI
    CCMP  X15, #0x1a, #0xe, PL
    CMN  X22, X28, LSL #10
    CMP  W13, W14, UXTH #0
    CMP  X19, W28, SXTH #1
    CMP  W14, #0xb61
    CCMP  X5, X21, #0x6, GT
    CMP  X29, W16, UXTW #1
    CMN  W17, W19, UXTW #3
    CMP  X22, X19, LSR #50
    CMN  W17, #0xb64, LSL #12
    CMP  W7, W4, LSR #21
    CMP  W7, #0x177
    CMN  X7, W3, SXTB #1
    CCMP  W3, #0xe, #0xb, VS
    CMP  W14, W21, ASR #4
    CCMP  W21, #0xd, #0x5, MI
    CMP  X14, X12, UXTX #3
    CCMP  W3, W28, #0xe, CS
    CCMP  X27, #0x14, #0xe, LE
    CCMN  W14, W17, #0x1, LS
    CMN  X16, #0x657
    CMP  X11, X4, LSL #27
    CMN  W29, W16, LSL #29
    CCMP  X15, #0x7, #0x8, CC
    CMP  X13, X18, SXTX #0
    CMP  X13, X7, SXTX #1
    CMP  X16, W21, UXTH #4
    CCMN  X28, #0x1, #0xc, LE
    CCMP  X26, X16, #0xa, GE
    CMP  W19, #0x6b4, LSL #12
    CMP  W17, W4, SXTB #3
    CMP  X22, X27, ASR #1
    CCMN  X18, X7, #0x7, GE
    CCMP  X28, #0x14, #0x7, NE
    CCMP  W16, W19, #0x0, MI
    CMN  X27, X9, UXTX #4
    CCMP  X26, #0x2, #0xd, HI
    CMP  W26, #0x542
    CMP  X7, X10, ASR #54
    CCMP  X24, #0x14, #0x3, VS
    CCMP  X9, #0x1b, #0x1, CC
    CCMP  W5, W24, #0x1, NE
    CCMN  W29, #0xb, #0xa, NV
    CCMN  X18, #0x5, #0xc, VC
    CCMN  X26, #0x9, #0xb, LS
    CMN  W10, W9, LSR #26
    CMN  W11, W11, SXTB #0
    CMP  X22, #0x5a5
    CCMN  W21, #0x1b, #0x6, PL
    CMN  W4, W22, UXTB #2
    CMP  X13, X10, LSR #23
    CMP  W12, #0x9cd
    CMN  X15, #0x445
    CCMP  X26, #0x19, #0x2, PL
    CMN  W24, W29, LSL #22
    CMN  W26, W3, UXTB #2
    CMP  W5, #0x818
    CCMN  W14, W19, #0x4, GT
    CCMN  W11, #0xb, #0xd, GT
    CCMN  X12, #0x16, #0xb, NV
    CMN  X11, X16, LSR #39
    CMN  X5, W26, SXTW #3
    CCMP  X4, X5, #0x4, EQ
    CCMP  W17, W21, #0x6, GT
    CMP  W19, W18, UXTW #1
    CMP  X22, #0x1b9
    CCMN  X27, #0x4, #0x9, NV
    CCMP  W22, #0x8, #0x2, EQ
    CMN  W5, W12, SXTH #1
    CMN  W4, #0x937, LSL #12
    CCMP  X21, #0xd, #0x3, PL
    CCMP  X15, X28, #0xa, LS
    CCMP  X24, X11, #0xf, VC
    CCMP  X4, X22, #0x9, NV
    CCMN  W5, #0x1e, #0x0, CC
    CCMN  X15, X19, #0x9, LS
    CCMN  X28, X5, #0xd, HI
    CCMN  W28, W19, #0x5, LT
    CCMN  W9, W12, #0x6, VS
    CCMP  W26, W15, #0x6, LS
    CCMN  W26, W12, #0x4, LE
    CMP  W5, W7, SXTB #1
    CCMP  W21, W12, #0xe, MI
    CMP  W18, W5, LSR #1
    CCMN  X13, #0xa, #0x8, VS
    CMN  X22, W7, UXTW #1
    CCMP  X7, #0x1f, #0x7, AL
    CCMP  X10, #0x1f, #0x3, PL
    CMN  W16, #0x2ee, LSL #12
    CMP  W10, #0xc26, LSL #12
    CMP  X17, #0xc53
    CCMP  X7, X13, #0xf, NV
    CMP  W18, W3, SXTX #4
    CMN  W13, #0x6c7
    CMP  W26, W29, LSR #4
    CMP  W7, W19, UXTW #4
    CCMN  W7, W15, #0xe, GE
    CCMN  X26, #0xf, #0x5, MI
    CMP  W27, W13, LSL #1
    CCMP  X4, X12, #0x8, LS
    CMP  W19, W22, LSR #7
    CMP  W12, #0x90d
    CCMN  W17, W17, #0x8, CC
    CCMN  X15, #0xb, #0xc, LT
    CCMP  X24, X29, #0xd, EQ
    CCMP  W4, W29, #0xf, VC
    CMN  X11, #0x224
    CMP  W9, #0x6fb
    CMN  X21, W27, UXTW #2
    CMN  W22, W19, ASR #16
    CCMP  W21, W3, #0x3, CS
    CCMP  X5, X26, #0x5, CS
    CMP  W28, #0x449, LSL #12
    CCMP  X7, X18, #0x9, CC
    CMP  W15, W16, UXTX #1
    CMN  W27, W24, ASR #14
    CMN  X15, X13, LSR #52
    CMN  X4, W7, SXTB #1
    CMP  X17, #0xace, LSL #12
    CMP  X18, #0x5c1, LSL #12
    CMN  X5, X17, SXTX #2
    CCMN  X16, #0x1, #0x4, CS
    CMP  X10, #0xbdb
    CCMP  W12, #0x1c, #0xf, LS
    CCMP  X27, #0x17, #0x4, AL
    CCMP  W24, #0xa, #0x0, AL
    CCMP  X5, X3, #0x5, GT
    CCMN  W22, W15, #0xf, GE
    CMN  X17, X19, SXTX #0
    CCMP  X3, #0x10, #0x7, CS
    CMP  X3, X27, LSR #44
    CMN  W28, W22, ASR #27
    CCMP  W15, #0x15, #0x4, GE
    CMP  X14, X9, UXTX #0
    CMN  W29, #0xc96
    CCMN  W21, #0x1e, #0xf, LS
    CCMP  X18, #0x0, #0xc, AL
    CMP  X18, W13, UXTB #0
    CCMN  W17, W14, #0x7, CS
    CMP  X14, #0xc56, LSL #12
    CCMN  X24, #0x16, #0x6, NV
    CMP  X18, X16, ASR #48
    CMN  W3, W4, UXTH #2
    CMP  W24, #0x72, LSL #12
    CCMP  X21, #0x0, #0xc, GT
    CMP  W24, #0xb0c, LSL #12
    CCMN  X19, #0xe, #0xd, AL
    CCMP  X11, #0xe, #0xa, VC
    CMN  X16, X17, LSL #33
    CMN  W10, W5, UXTX #1
    CCMP  X3, X15, #0xf, AL
    CCMN  X17, #0x15, #0x4, GE
    CMN  W17, #0xff9, LSL #12
    CMP  X9, X27, SXTX #4
    CMN  W29, W21, LSR #31
    CCMP  X12, X7, #0x6, VC
    CMN  W5, W7, LSL #6
    CMP  W4, W24, UXTX #1
    SUBS  X7, X7, #0x1
    B.NE  TSRTIntCompare_label_2
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X20, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X20, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X20, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X20, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X20, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X20, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X20, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X20, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X20, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X20, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X20, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X20, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X20, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X20, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X20, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X20, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X20, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X20, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X20, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X20, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0x9a8f, LSL #0
    MOVK  X2, #0x474f, LSL #16
    MOVK  X2, #0xda04, LSL #32
    MOVK  X2, #0x8fbf, LSL #48
    MOVZ  X3, #0x5769, LSL #0
    MOVK  X3, #0xffd2, LSL #16
    MOVK  X3, #0x2900, LSL #32
    MOVK  X3, #0xa7c6, LSL #48
    MOVZ  X4, #0xb76f, LSL #0
    MOVK  X4, #0x873f, LSL #16
    MOVK  X4, #0x4d74, LSL #32
    MOVK  X4, #0x99f6, LSL #48
    MOVZ  X5, #0xd47c, LSL #0
    MOVK  X5, #0x9780, LSL #16
    MOVK  X5, #0x581c, LSL #32
    MOVK  X5, #0xcba2, LSL #48
    MOVZ  X7, #0xc1d, LSL #0
    MOVK  X7, #0x8e04, LSL #16
    MOVK  X7, #0x8bfc, LSL #32
    MOVK  X7, #0xf136, LSL #48
    MOVZ  X9, #0xfef1, LSL #0
    MOVK  X9, #0x2600, LSL #16
    MOVK  X9, #0xf511, LSL #32
    MOVK  X9, #0xfff8, LSL #48
    MOVZ  X10, #0x3e72, LSL #0
    MOVK  X10, #0x3c9a, LSL #16
    MOVK  X10, #0x13de, LSL #32
    MOVK  X10, #0xb751, LSL #48
    MOVZ  X11, #0x3653, LSL #0
    MOVK  X11, #0xe967, LSL #16
    MOVK  X11, #0xafcd, LSL #32
    MOVK  X11, #0x3bf, LSL #48
    MOVZ  X12, #0x58fd, LSL #0
    MOVK  X12, #0x6faf, LSL #16
    MOVK  X12, #0xc6a8, LSL #32
    MOVK  X12, #0xf4bc, LSL #48
    MOVZ  X13, #0x23f4, LSL #0
    MOVK  X13, #0x6344, LSL #16
    MOVK  X13, #0x6577, LSL #32
    MOVK  X13, #0x5dd6, LSL #48
    MOVZ  X14, #0xa0d0, LSL #0
    MOVK  X14, #0x224e, LSL #16
    MOVK  X14, #0x79e1, LSL #32
    MOVK  X14, #0x9ca4, LSL #48
    MOVZ  X15, #0xd4bc, LSL #0
    MOVK  X15, #0x2347, LSL #16
    MOVK  X15, #0x6185, LSL #32
    MOVK  X15, #0xc571, LSL #48
    MOVZ  X16, #0x4a06, LSL #0
    MOVK  X16, #0x10e8, LSL #16
    MOVK  X16, #0x52b2, LSL #32
    MOVK  X16, #0x4cf4, LSL #48
    MOVZ  X17, #0x5f, LSL #0
    MOVK  X17, #0x8f9c, LSL #16
    MOVK  X17, #0x6834, LSL #32
    MOVK  X17, #0x530, LSL #48
    MOVZ  X18, #0x95fa, LSL #0
    MOVK  X18, #0xb2b7, LSL #16
    MOVK  X18, #0xe999, LSL #32
    MOVK  X18, #0xdcc7, LSL #48
    MOVZ  X19, #0x1c77, LSL #0
    MOVK  X19, #0x27f5, LSL #16
    MOVK  X19, #0x73f3, LSL #32
    MOVK  X19, #0xca1e, LSL #48
    MOVZ  X20, #0x2f39, LSL #0
    MOVK  X20, #0xd7f8, LSL #16
    MOVK  X20, #0xda7f, LSL #32
    MOVK  X20, #0x2de0, LSL #48
    MOVZ  X21, #0xee34, LSL #0
    MOVK  X21, #0xab5d, LSL #16
    MOVK  X21, #0xeaca, LSL #32
    MOVK  X21, #0xcc0e, LSL #48
    MOVZ  X22, #0xf252, LSL #0
    MOVK  X22, #0xe513, LSL #16
    MOVK  X22, #0x82ee, LSL #32
    MOVK  X22, #0xff2c, LSL #48
    MOVZ  X24, #0xbc1f, LSL #0
    MOVK  X24, #0x9297, LSL #16
    MOVK  X24, #0x5c2d, LSL #32
    MOVK  X24, #0x5d94, LSL #48
    MOVZ  X26, #0x226, LSL #0
    MOVK  X26, #0xe9a2, LSL #16
    MOVK  X26, #0x946c, LSL #32
    MOVK  X26, #0xa718, LSL #48
    MOVZ  X27, #0x9c07, LSL #0
    MOVK  X27, #0x8f36, LSL #16
    MOVK  X27, #0x8da3, LSL #32
    MOVK  X27, #0xb598, LSL #48
    MOVZ  X28, #0x43c, LSL #0
    MOVK  X28, #0x416c, LSL #16
    MOVK  X28, #0x8458, LSL #32
    MOVK  X28, #0x998d, LSL #48
    MOVZ  X29, #0x243c, LSL #0
    MOVK  X29, #0xc886, LSL #16
    MOVK  X29, #0xc7ee, LSL #32
    MOVK  X29, #0x8b2e, LSL #48
    MOVZ  X2, #0xf, LSL #0
TSRTIntCompare_label_3:
    CMP  W2, W27, LSR #10
    CMP  W29, #0x18
    CCMN  X26, #0x1f, #0xd, LS
    CCMN  X28, X28, #0x8, AL
    CMN  X5, #0x986, LSL #12
    CCMN  X7, #0x7, #0xa, HI
    CCMN  W26, #0x18, #0x9, LS
    CCMP  X18, #0x15, #0xe, LE
    CMP  W17, W29, UXTH #4
    CMN  W21, #0xbb0, LSL #12
    CMN  W7, W13, LSR #2
    CMP  X10, X24, LSL #53
    CMP  X27, #0x883, LSL #12
    CMP  X29, #0xde8
    CMP  X19, X5, ASR #56
    CMN  W26, W18, LSR #10
    CMN  X26, X27, UXTX #0
    CMN  W26, W12, LSR #14
    CMN  X15, W24, SXTW #0
    CMP  X29, X26, LSL #56
    CCMN  W26, W15, #0x2, LE
    CCMN  W13, W12, #0x6, AL
    CMP  X12, #0xad0, LSL #12
    CMN  W21, #0xd6d, LSL #12
    CMN  W26, W7, UXTH #2
    CMN  X7, X4, SXTX #3
    CCMP  W14, W3, #0x6, NV
    CMN  X28, #0x10a
    CCMP  X26, #0x15, #0x9, VC
    CMP  X3, X26, ASR #39
    CMP  X4, #0xec0, LSL #12
    CCMN  X13, X2, #0xd, AL
    CMN  X14, X19, UXTX #1
    CCMP  W28, W28, #0xc, LS
    CCMP  W17, #0x9, #0x1, GE
    CMN  X20, W11, UXTH #2
    CMP  X22, X29, SXTX #2
    CMP  X24, X27, ASR #0
    CCMP  W28, W10, #0x4, GE
    CCMN  W14, #0x1f, #0x7, VS
    CCMN  X27, X15, #0xc, MI
    CMP  W13, W12, LSL #12
    CMN  W5, W3, SXTX #2
    CMN  X20, W10, SXTW #2
    CMN  W27, W21, ASR #10
    CCMP  X18, X18, #0x6, CC
    CCMP  X14, #0x18, #0x3, LS
    CMP  W4, W12, UXTW #4
    CMN  X17, X11, ASR #60
    CMN  X20, #0x9ec
    CCMN  X2, X28, #0xc, VS
    CMN  X2, #0xb5d, LSL #12
    CMP  W24, W19, LSR #20
    CMN  W3, W19, LSL #2
    CMN  X7, #0x771
    CMN  W15, W21, UXTB #0
    CMP  W15, W2, ASR #21
    CCMN  W13, #0x19, #0x9, HI
    CCMP  W17, #0x16, #0x1, GT
    CMN  X5, W14, UXTH #3
    CMP  W14, W4, LSR #1
    CMP  W11, W15, ASR #25
    CMP  X12, W17, SXTW #2
    CCMN  X21, #0x9, #0x1, EQ
    CCMN  X24, #0x13, #0xb, MI
    CMP  W24, W18, LSL #11
    CCMP  W12, W17, #0xb, VS
    CCMP  W2, #0xc, #0xf, VS
    CCMP  W24, W12, #0x1, PL
    CCMP  X17, #0x10, #0x7, PL
    CMP  X11, W19, UXTH #0
    CCMP  W26, #0x15, #0x2, CC
    CCMN  W28, W26, #0xb, PL
    CMN  W27, W28, SXTB #1
    CCMP  W22, W27, #0x9, NV
    CCMN  W27, #0xe, #0xc, NE
    CMP  W15, W26, LSL #28
    CMP  X11, W10, SXTB #3
    CMP  X7, #0xaa6
    CCMP  W17, W18, #0x4, HI
    CCMP  W5, W28, #0x4, MI
    CMN  X22, W4, SXTW #4
    CMN  X15, #0x43
    CMP  W7, #0xb56
    CMP  W12, W18, ASR #18
    CCMN  W5, W2, #0x2, GE
    CCMP  W2, W3, #0x8, VC
    CMN  W5, W13, LSR #7
    CCMN  X12, X7, #0x1, EQ
    CCMN  X2, X20, #0x6, NV
    CCMP  X17, X17, #0xa, LS
    CCMP  X28, #0x10, #0xe, VS
    CMN  X4, #0x21
    CCMP  W28, #0x6, #0xa, MI
    CMP  X24, #0xa98
    CMN  W27, #0x96
    CCMN  W14, W29, #0x3, LS
    CMN  W19, W22, SXTH #1
    CMN  X11, W3, SXTW #4
    CMN  W22, W26, LSL #28
    CCMP  X19, #0x19, #0x5, GE
    CCMP  X22, X18, #0x6, NV
    CMP  W14, #0x2cb, LSL #12
    CCMN  X13, #0x1d, #0xf, VC
    CMN  X11, #0x928, LSL #12
    CMP  W17, W13, LSL #10
    CMP  X26, X3, LSR #48
    CCMN  X2, X11, #0x5, LT
    CCMP  X11, X4, #0xa, LT
    CMN  W29, W22, UXTH #4
    CCMN  X14, #0x1b, #0xc, CC
    CMP  X26, #0x327
    CMN  X24, X11, ASR #20
    CMN  W28, W4, LSR #24
    CMN  X20, X14, SXTX #4
    CCMN  X19, #0x9, #0x9, LE
    CMN  W12, W13, LSR #3
    CCMP  W5, #0xd, #0x0, LE
    CMN  W17, W27, UXTX #4
    CMN  X13, #0x267, LSL #12
    CMN  W22, #0x80
    CMP  X20, #0x261, LSL #12
    CMN  X27, X13, ASR #50
    CMP  W24, #0x784, LSL #12
    CMP  X13, #0xd4c, LSL #12
    CCMP  X15, X14, #0x8, NV
    CMP  W24, W2, LSR #23
    CMP  W17, W18, LSR #17
    CMP  X19, #0x3bf, LSL #12
    CMP  W22, W28, UXTH #3
    CMP  X21, W13, SXTW #4
    CCMP  X28, #0x17, #0x9, NE
    CCMN  X3, X12, #0x1, LT
    CMN  X19, W12, SXTB #4
    CMN  W12, W10, LSR #24
    CMN  W29, #0x5e6
    CCMN  X4, X5, #0xc, GT
    CCMP  X7, X12, #0xc, AL
    CMN  W10, #0x916
    CMN  X13, W17, SXTW #0
    CMP  X21, X7, LSR #32
    CMP  W26, #0x2ec
    CMP  W10, W12, UXTX #2
    CMN  W29, W5, UXTB #3
    CCMP  X3, #0x3, #0x1, NV
    CCMP  W17, W21, #0x6, CS
    CCMN  W24, W15, #0x6, NE
    CMN  W24, W10, UXTB #1
    CCMN  X3, #0xf, #0x7, EQ
    CCMP  X14, #0xa, #0x1, GE
    CMN  W19, W10, SXTH #0
    CMN  X21, #0xc7e
    CMN  W7, W27, LSL #1
    CMP  W27, W12, UXTX #4
    CCMN  W10, #0x1b, #0x8, HI
    CMN  W2, W22, LSR #18
    CMP  X21, W17, SXTH #1
    CMN  X4, X22, LSL #28
    CMP  W5, W4, LSL #11
    CMP  X7, W5, SXTB #1
    CMP  W28, #0xbd9, LSL #12
    CMP  W12, W2, LSR #5
    CCMN  W18, W21, #0xf, EQ
    CMP  W24, W4, LSL #27
    CMN  X13, W26, UXTB #1
    CCMP  X2, X26, #0xc, HI
    CCMP  X4, X5, #0xc, VC
    CMN  W17, W12, LSR #8
    CMP  W13, #0x200
    CMP  W10, W10, SXTW #0
    CMN  X20, #0x178
    CMN  X14, X24, ASR #28
    CMN  X4, W3, UXTB #0
    CCMN  W2, #0xa, #0x9, HI
    CMP  X4, X2, ASR #3
    CCMN  X29, X7, #0x7, VC
    CCMN  W27, W2, #0x0, VS
    CMP  W7, W13, LSL #31
    CMP  X22, W14, SXTH #1
    CMP  W15, W26, UXTW #2
    CMP  W10, W27, LSL #16
    CMN  W12, W10, LSR #4
    CCMN  W2, #0xb, #0xf, VS
    CMN  X29, #0xb4a, LSL #12
    CCMN  W3, #0x5, #0xf, LS
    CMP  W7, #0x62c
    CMN  X27, #0x79a, LSL #12
    CMP  X5, #0xb96
    CMP  X20, X21, ASR #18
    CMN  X20, X10, LSR #23
    CMP  W24, W29, LSL #12
    CMN  W27, #0x579, LSL #12
    CMP  X4, X22, LSL #60
    CMN  W11, W11, SXTW #3
    CMP  X7, X4, ASR #57
    CMP  W12, #0xbf, LSL #12
    CMN  X29, #0x2ed, LSL #12
    CCMN  W14, W28, #0x4, PL
    CMN  X27, #0xe46, LSL #12
    CCMP  W18, #0x1, #0xf, EQ
    SUBS  X2, X2, #0x1
    B.NE  TSRTIntCompare_label_3
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCompare_TestFail
    MOVZ  X9, #0x5769, LSL #0
    MOVK  X9, #0xffd2, LSL #16
    MOVK  X9, #0x2900, LSL #32
    MOVK  X9, #0xa7c6, LSL #48
    SUB  X16, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCompare_TestFail
    MOVZ  X9, #0xb76f, LSL #0
    MOVK  X9, #0x873f, LSL #16
    MOVK  X9, #0x4d74, LSL #32
    MOVK  X9, #0x99f6, LSL #48
    SUB  X16, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCompare_TestFail
    MOVZ  X9, #0xd47c, LSL #0
    MOVK  X9, #0x9780, LSL #16
    MOVK  X9, #0x581c, LSL #32
    MOVK  X9, #0xcba2, LSL #48
    SUB  X16, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCompare_TestFail
    MOVZ  X9, #0xc1d, LSL #0
    MOVK  X9, #0x8e04, LSL #16
    MOVK  X9, #0x8bfc, LSL #32
    MOVK  X9, #0xf136, LSL #48
    SUB  X16, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCompare_TestFail
    MOVZ  X9, #0x3e72, LSL #0
    MOVK  X9, #0x3c9a, LSL #16
    MOVK  X9, #0x13de, LSL #32
    MOVK  X9, #0xb751, LSL #48
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCompare_TestFail
    MOVZ  X9, #0x3653, LSL #0
    MOVK  X9, #0xe967, LSL #16
    MOVK  X9, #0xafcd, LSL #32
    MOVK  X9, #0x3bf, LSL #48
    SUB  X16, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCompare_TestFail
    MOVZ  X9, #0x58fd, LSL #0
    MOVK  X9, #0x6faf, LSL #16
    MOVK  X9, #0xc6a8, LSL #32
    MOVK  X9, #0xf4bc, LSL #48
    SUB  X16, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCompare_TestFail
    MOVZ  X9, #0x23f4, LSL #0
    MOVK  X9, #0x6344, LSL #16
    MOVK  X9, #0x6577, LSL #32
    MOVK  X9, #0x5dd6, LSL #48
    SUB  X16, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCompare_TestFail
    MOVZ  X9, #0xa0d0, LSL #0
    MOVK  X9, #0x224e, LSL #16
    MOVK  X9, #0x79e1, LSL #32
    MOVK  X9, #0x9ca4, LSL #48
    SUB  X16, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCompare_TestFail
    MOVZ  X9, #0xd4bc, LSL #0
    MOVK  X9, #0x2347, LSL #16
    MOVK  X9, #0x6185, LSL #32
    MOVK  X9, #0xc571, LSL #48
    SUB  X16, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCompare_TestFail
    MOVZ  X9, #0x5f, LSL #0
    MOVK  X9, #0x8f9c, LSL #16
    MOVK  X9, #0x6834, LSL #32
    MOVK  X9, #0x530, LSL #48
    SUB  X16, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCompare_TestFail
    MOVZ  X9, #0x95fa, LSL #0
    MOVK  X9, #0xb2b7, LSL #16
    MOVK  X9, #0xe999, LSL #32
    MOVK  X9, #0xdcc7, LSL #48
    SUB  X16, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCompare_TestFail
    MOVZ  X9, #0x1c77, LSL #0
    MOVK  X9, #0x27f5, LSL #16
    MOVK  X9, #0x73f3, LSL #32
    MOVK  X9, #0xca1e, LSL #48
    SUB  X16, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCompare_TestFail
    MOVZ  X9, #0x2f39, LSL #0
    MOVK  X9, #0xd7f8, LSL #16
    MOVK  X9, #0xda7f, LSL #32
    MOVK  X9, #0x2de0, LSL #48
    SUB  X16, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCompare_TestFail
    MOVZ  X9, #0xee34, LSL #0
    MOVK  X9, #0xab5d, LSL #16
    MOVK  X9, #0xeaca, LSL #32
    MOVK  X9, #0xcc0e, LSL #48
    SUB  X16, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCompare_TestFail
    MOVZ  X9, #0xf252, LSL #0
    MOVK  X9, #0xe513, LSL #16
    MOVK  X9, #0x82ee, LSL #32
    MOVK  X9, #0xff2c, LSL #48
    SUB  X16, X9, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCompare_TestFail
    MOVZ  X9, #0xbc1f, LSL #0
    MOVK  X9, #0x9297, LSL #16
    MOVK  X9, #0x5c2d, LSL #32
    MOVK  X9, #0x5d94, LSL #48
    SUB  X16, X9, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCompare_TestFail
    MOVZ  X9, #0x226, LSL #0
    MOVK  X9, #0xe9a2, LSL #16
    MOVK  X9, #0x946c, LSL #32
    MOVK  X9, #0xa718, LSL #48
    SUB  X16, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCompare_TestFail
    MOVZ  X9, #0x9c07, LSL #0
    MOVK  X9, #0x8f36, LSL #16
    MOVK  X9, #0x8da3, LSL #32
    MOVK  X9, #0xb598, LSL #48
    SUB  X16, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCompare_TestFail
    MOVZ  X9, #0x43c, LSL #0
    MOVK  X9, #0x416c, LSL #16
    MOVK  X9, #0x8458, LSL #32
    MOVK  X9, #0x998d, LSL #48
    SUB  X16, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCompare_TestFail
    MOVZ  X9, #0x243c, LSL #0
    MOVK  X9, #0xc886, LSL #16
    MOVK  X9, #0xc7ee, LSL #32
    MOVK  X9, #0x8b2e, LSL #48
    SUB  X16, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X28, #0xf, LSL #0
TSRTIntCompare_label_4:
    CMP  W27, W26, SXTX #3
    CCMN  X20, #0x19, #0x7, NV
    CCMP  W22, #0x18, #0xd, LT
    CMN  W15, W12, ASR #22
    CMP  W28, W16, UXTW #2
    CCMN  X29, #0xe, #0x7, GT
    CMP  W17, #0xfa, LSL #12
    CMN  X11, X21, UXTX #1
    CCMP  X24, X18, #0xf, HI
    CCMP  W19, W19, #0xf, LS
    CMN  X18, #0x6f7, LSL #12
    CMP  X10, X14, LSR #30
    CCMN  X27, #0x1c, #0xb, LE
    CCMP  X20, #0xb, #0x0, VS
    CMN  X4, X12, ASR #4
    CCMP  W20, #0x10, #0xd, CC
    CMN  X26, #0xbb0
    CCMN  X26, #0xc, #0x8, MI
    CMN  W5, #0x2ff
    CMP  W29, W28, LSL #31
    CMP  X12, X4, ASR #46
    CMP  W29, #0x447
    CMN  X26, #0x851, LSL #12
    CMP  W21, #0xde1, LSL #12
    CMP  X21, W24, SXTB #1
    CMP  X29, W16, UXTW #2
    CMN  W7, W15, LSR #8
    CMN  X3, #0xb21
    CCMN  W18, #0x13, #0xd, CC
    CMN  W7, W19, SXTX #3
    CMN  W10, W18, ASR #22
    CCMP  X10, X14, #0x3, NV
    CMN  X20, X5, SXTX #3
    CMP  W20, W20, UXTH #3
    CCMN  W24, #0x10, #0xa, AL
    CMP  W17, #0xd8b
    CMN  X28, W7, UXTB #1
    CMN  W27, W10, SXTB #2
    CCMP  X24, #0xc, #0xb, CC
    CCMP  W5, #0x1b, #0x4, PL
    CMP  W20, #0x54d
    CCMN  X10, #0x1e, #0x6, HI
    CCMN  W18, #0x1a, #0xb, PL
    CMN  X3, #0x5be, LSL #12
    CMP  W18, W10, UXTH #1
    CMN  X29, W3, SXTH #1
    CMN  W12, W4, ASR #23
    CMP  W16, W4, SXTB #3
    CMN  X17, #0x2d0
    CCMP  W2, W12, #0xa, LS
    CMN  X5, W28, UXTB #2
    CMN  X29, W7, SXTH #2
    CMP  W7, W22, LSL #15
    CMP  X17, X3, ASR #10
    CMP  W27, W18, ASR #28
    CCMN  X17, #0x1a, #0x3, HI
    CMP  X28, #0x5b4, LSL #12
    CCMN  W21, #0x12, #0x3, NE
    CMN  W17, W19, ASR #1
    CCMN  W17, #0x1c, #0x7, NV
    CCMP  W17, W5, #0xd, MI
    CMP  X17, X21, LSR #20
    CMN  X21, W4, SXTB #4
    CCMN  X12, #0x6, #0x7, CC
    CMN  X5, W18, SXTW #4
    CCMN  W16, W21, #0x4, CS
    CMP  X14, W11, SXTH #3
    CMP  X29, #0xd22, LSL #12
    CMN  W21, #0xd25
    CMP  X27, W15, SXTB #1
    CCMN  W5, #0xf, #0xa, CS
    CMN  W21, W16, LSR #27
    CMN  X12, X11, LSL #13
    CCMN  W29, #0x15, #0x0, GE
    CMN  X7, X26, UXTX #2
    CMN  X22, X21, SXTX #4
    CMP  X4, W18, SXTH #1
    CCMN  W12, W24, #0x7, CS
    CMP  X4, X17, LSL #45
    CCMP  W18, #0x1b, #0x7, NE
    CMP  W10, W20, LSR #4
    CCMP  X4, #0x5, #0xe, AL
    CMN  X27, W12, SXTH #4
    CCMN  X27, #0x3, #0x7, AL
    CMN  W20, W12, UXTH #3
    CCMN  X4, X10, #0x8, VC
    CCMP  X10, X4, #0x1, VC
    CCMP  W24, W21, #0x3, LT
    CMN  W17, #0x34d, LSL #12
    CCMP  W21, #0x19, #0xc, NV
    CCMN  X29, #0xa, #0xf, VS
    CMN  W7, W20, UXTB #0
    CCMP  W10, W28, #0x5, MI
    CCMN  X7, #0x13, #0xf, LT
    CMN  X18, X19, LSR #33
    CMP  X28, #0x604
    CMP  X17, #0xc6a, LSL #12
    CCMN  W7, W16, #0x1, HI
    CMP  W24, W21, ASR #22
    CMP  W22, W18, LSL #16
    CMP  W18, #0xc29
    CMN  W24, W26, ASR #3
    CCMN  X22, X26, #0xb, MI
    CMP  X29, X20, ASR #35
    CMP  X17, X11, ASR #47
    CMP  W14, W7, LSL #9
    CMN  W12, W12, SXTX #2
    CMP  X20, #0x6bb, LSL #12
    CMP  X19, W22, SXTB #2
    CMP  X17, X15, LSR #38
    CMN  W19, W20, SXTH #4
    CMN  W11, W18, LSL #10
    CCMN  X29, #0x5, #0xa, LE
    CMP  X4, W14, SXTW #0
    CMP  X10, #0x4d0
    CMN  W4, W22, LSL #2
    CMN  X24, X2, LSR #31
    CMN  W20, W16, ASR #9
    CMN  W21, W19, LSL #12
    CMP  X7, X27, UXTX #0
    CMP  X22, X28, ASR #44
    CMN  W10, #0x6f8
    CCMP  W18, #0x16, #0xa, LT
    CCMP  X16, #0x18, #0xc, CC
    CCMN  W28, #0x8, #0x2, LT
    CMN  X22, X2, ASR #29
    CMN  W12, W20, SXTX #4
    CMP  X5, X29, UXTX #1
    CCMP  W17, #0x1d, #0x5, EQ
    CMP  W16, W17, UXTW #1
    CCMP  W21, W24, #0xa, LS
    CMP  X10, X16, UXTX #1
    CMP  W24, W28, UXTH #1
    CCMP  X5, X14, #0x5, AL
    CMN  W11, W11, SXTB #4
    CCMN  X22, #0x10, #0x9, PL
    CCMP  X16, #0x7, #0x5, EQ
    CCMN  X3, X16, #0x5, LS
    CCMP  W7, W7, #0xa, EQ
    CCMP  X20, X5, #0x7, MI
    CMP  X4, W18, SXTW #3
    CMP  X19, #0x554
    CCMN  W4, W11, #0xa, EQ
    CMN  X16, W20, UXTW #2
    CMN  W21, W4, ASR #20
    CMN  W7, W16, SXTX #4
    CCMN  W3, W10, #0xe, PL
    CCMN  W7, #0x14, #0x9, PL
    CMN  W22, #0x77f
    CCMN  X15, #0xa, #0x9, VC
    CMP  W15, #0xe47, LSL #12
    CMP  W12, W27, UXTX #3
    CCMP  X12, #0x1, #0x4, AL
    CMN  X24, X3, LSR #15
    CMP  X7, X5, UXTX #0
    CCMP  X19, X10, #0xe, GE
    CCMP  W26, #0x8, #0x5, LS
    CCMP  W3, #0x16, #0x0, LS
    CMN  W10, W17, SXTB #4
    CMN  W24, #0x4b, LSL #12
    CMN  W20, W12, SXTB #4
    CCMN  W5, W22, #0x6, VS
    CMP  W17, W12, SXTH #2
    CMP  X2, X17, LSL #63
    CMP  W4, #0x746
    CCMP  W28, W19, #0x2, GE
    CMN  X12, X2, ASR #22
    CMP  W22, #0xfd9
    CCMN  W4, #0x3, #0xa, CS
    CCMP  W27, W10, #0x8, LS
    CMN  W5, W22, SXTX #0
    CCMP  W17, #0x17, #0xb, AL
    CCMN  W26, #0x1e, #0xc, GT
    CMN  W4, W26, LSR #7
    CMP  X18, #0xe4c
    CMP  W20, #0xb24, LSL #12
    CMN  W29, W27, UXTH #2
    CMP  X12, W15, SXTH #3
    CMP  X7, W15, UXTW #3
    CCMP  W22, W11, #0x3, MI
    CCMP  W28, #0xe, #0xd, MI
    CMN  X7, #0xa9a, LSL #12
    CMN  X16, X14, LSR #47
    CCMN  W29, #0xf, #0xc, NV
    CMN  X26, X27, SXTX #0
    CCMN  W14, W27, #0xd, LT
    CCMP  W14, W29, #0x4, CC
    CMN  X29, X7, ASR #23
    CMP  X5, W24, SXTW #0
    CMP  W3, W29, UXTH #4
    CMP  X16, #0xb9d
    CMN  X18, #0x756, LSL #12
    CMN  W12, W10, UXTW #3
    CMN  X4, #0x64d
    CMN  X2, X26, LSL #48
    CCMN  X17, #0xa, #0xa, NE
    CMP  X17, X18, LSR #62
    CMP  W12, #0xbaa
    CCMP  W16, W7, #0x0, VC
    CMP  X14, X20, LSL #20
    SUBS  X28, X28, #0x1
    B.NE  TSRTIntCompare_label_4
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
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
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
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
    MOVZ  X13, #0xf, LSL #0
TSRTIntCompare_label_5:
    CMP  X26, W13, SXTW #1
    CMN  X27, X24
    CMN  X29, W29, SXTH #0
    CMP  W28, #0x320, LSL #12
    CCMP  W2, #0x1c, #0xb, HI
    CMN  X22, W3, UXTW #1
    CMN  W2, W2, UXTW #2
    CCMP  W7, W20, #0x4, GE
    CMN  W18, #0x767
    CMP  X22, W11, UXTH #0
    CMP  W24, #0x736, LSL #12
    CMP  X22, X21, ASR #49
    CMP  X15, W9, SXTB #3
    CCMN  X12, X29, #0xa, NV
    CMN  X11, W26, SXTB #0
    CCMN  W27, #0x17, #0x3, PL
    CCMP  W3, W11, #0xd, AL
    CMP  W28, W26, ASR #2
    CCMP  X28, X13, #0x8, VC
    CCMN  W26, W20, #0x1, CS
    CCMP  X21, #0x1c, #0xf, LE
    CMP  X28, #0x6c9
    CCMP  X24, #0x1a, #0x2, CC
    CMN  X18, #0x442
    CMP  X29, #0x9aa, LSL #12
    CMN  X14, W17, UXTW #3
    CMP  W9, W7, SXTB #0
    CMN  W13, W21, UXTW #3
    CCMP  W7, W29, #0xc, VC
    CMP  W18, #0xee0
    CCMN  W16, W18, #0x5, GE
    CMN  X17, X17, UXTX #0
    CMP  X20, X20, ASR #58
    CCMN  X12, #0x16, #0xc, MI
    CMN  X19, #0xef, LSL #12
    CMN  X7, X11, LSR #45
    CCMP  W17, W11, #0x9, NE
    CCMP  X13, #0x3, #0x0, LE
    CMN  X17, X22, LSR #3
    CMN  W24, W29, LSL #14
    CCMP  X9, X9, #0xd, GT
    CCMN  X12, X2, #0xc, GE
    CMP  W21, W13, ASR #12
    CMP  W19, W12, UXTH #4
    CMN  X21, X28, ASR #24
    CCMN  W29, #0x18, #0x1, GT
    CCMP  X3, X28, #0x9, GT
    CMN  W28, W3, LSL #9
    CMN  X27, #0x974, LSL #12
    CMN  X13, #0xf, LSL #12
    CMN  X19, #0xd9c, LSL #12
    CMP  X14, W14, UXTH #0
    CMP  W27, W24, UXTW #2
    CCMN  W20, #0x0, #0x9, MI
    CMP  X15, W4, SXTW #2
    CMP  X13, X17, LSL #16
    CMN  W13, #0x95d
    CCMN  W29, #0x1b, #0xb, MI
    CMN  W16, W15, LSL #31
    CMN  W22, #0x615
    CMP  W4, W16, LSL #14
    CMN  X14, X14, LSL #29
    CMP  W24, W15, SXTH #4
    CMN  W13, W24, LSR #11
    CMN  W3, W20, SXTH #0
    CMN  W20, W21, SXTH #4
    CMP  W2, W16, SXTB #4
    CMN  X21, X4, LSR #34
    CMN  W16, W13, UXTW #3
    CMN  W17, W17, UXTX #0
    CMN  X12, X13, LSL #16
    CCMN  X20, #0x17, #0x2, LT
    CCMN  W4, W28, #0xa, CC
    CMN  W29, W17, UXTX #2
    CMN  W29, #0x67, LSL #12
    CCMN  W28, #0xb, #0xa, HI
    CCMN  W7, W24, #0xe, MI
    CMN  X22, X9, LSR #17
    CMP  W3, W20, UXTB #4
    CMN  W15, W29, SXTB #3
    CCMN  W19, W14, #0x7, MI
    CMP  W15, W11, ASR #25
    CCMP  X28, #0xf, #0xc, MI
    CCMP  X15, #0x5, #0x6, NE
    CCMP  W7, W16, #0x0, LE
    CCMP  X3, X17, #0x4, HI
    CMN  W15, W21, SXTW #4
    CMP  W29, W7, LSR #24
    CMN  X11, #0x645, LSL #12
    CMN  X27, X22, ASR #11
    CCMP  W27, W21, #0x5, VC
    CCMP  X15, X13, #0xc, AL
    CCMP  X13, X3, #0x0, HI
    CCMN  W13, #0x12, #0x7, GE
    CMP  W17, W15, UXTH #0
    CCMP  W13, #0x11, #0x7, CS
    CCMN  X3, #0x9, #0xe, CS
    CCMP  W3, W12, #0x8, CS
    CCMP  W3, #0x17, #0x2, HI
    CMP  X27, W24, SXTW #1
    CMP  X22, X17, LSR #11
    CMN  W22, W21, SXTB #0
    CCMN  W27, W28, #0x4, MI
    CMP  X29, X26, ASR #42
    CMN  W13, W11, UXTX #0
    CMP  X21, #0xd22
    CCMP  X24, X2, #0xc, MI
    CMP  W26, W19, SXTX #1
    CMN  W7, W13, LSL #12
    CCMN  W24, #0x1f, #0x1, MI
    CMP  W17, W2, UXTW #4
    CCMN  X18, #0x1b, #0xd, GE
    CCMP  X26, X29, #0x8, GE
    CMN  X16, #0xe10, LSL #12
    CCMP  W19, #0x8, #0xe, PL
    CMP  X12, W3, UXTB #0
    CMN  W21, #0x4, LSL #12
    CMP  X3, #0x236
    CMN  W4, W13, LSL #17
    CCMP  X4, X19, #0xe, LT
    CMN  W26, W21, LSL #17
    CCMN  W7, #0x12, #0x2, VC
    CMP  W18, W3, ASR #23
    CMN  W11, W18, UXTH #1
    CCMN  W14, #0x7, #0x4, NV
    CMP  W3, W29, UXTB #2
    CMP  W17, W24, ASR #27
    CMN  X21, #0xc45, LSL #12
    CCMN  X11, X2, #0xe, GE
    CMN  W24, W28, LSL #10
    CCMN  W16, #0x10, #0x8, GT
    CMP  W20, W12, LSL #7
    CCMP  X20, #0x14, #0x2, GE
    CMN  W17, W20, LSL #11
    CCMN  W28, W22, #0xf, VS
    CMP  W22, W28, ASR #13
    CMN  X22, X22, UXTX #0
    CCMP  X29, X19, #0xc, LT
    CMN  X3, #0x241, LSL #12
    CMP  X29, #0x707, LSL #12
    CCMN  W13, #0x9, #0xa, AL
    CMP  W9, W4, UXTX #2
    CMP  X12, W18, SXTW #3
    CMP  X27, W11, SXTB #0
    CMP  W2, W3, SXTW #1
    CMP  W7, #0xfbc
    CCMP  W13, W22, #0xd, LT
    CCMN  X17, #0x18, #0xe, VC
    CMN  W14, W18, SXTH #4
    CMP  W12, W16, SXTX #1
    CMP  W19, #0xcb4
    CMP  X17, #0xc4f, LSL #12
    CCMP  W15, W27, #0x6, LE
    CCMP  X3, X2, #0x6, HI
    CMN  X11, #0x669
    CMP  X2, X29, ASR #47
    CMP  X20, X13, LSL #38
    CCMP  W18, #0x12, #0xe, LE
    CMN  W13, W7, LSR #24
    CMP  X13, X20, LSL #34
    CCMP  W27, W11, #0x4, VC
    CCMN  X17, X21, #0x8, LE
    CMP  X13, W13, UXTH #1
    CCMP  X28, #0x1c, #0xe, GE
    CMN  W21, W27, SXTH #1
    CCMP  X24, X27, #0x0, NE
    CMP  X28, W13, SXTW #4
    CMN  X13, X9, UXTX #4
    CMP  W14, W20, ASR #8
    CCMN  X9, #0x9, #0xc, LS
    CMP  X16, W18, UXTB #3
    CMP  W27, W11, UXTH #1
    CMN  W15, #0x96b
    CMP  W29, W9, UXTB #0
    CMN  X22, #0x51f
    CMP  W16, W18, UXTW #0
    CMP  W19, #0xb4, LSL #12
    CMP  X11, #0xb29, LSL #12
    CMN  X2, X19, LSL #17
    CCMN  W17, #0xa, #0x5, AL
    CMN  X12, #0x46c
    CCMN  X11, #0x12, #0x0, CS
    CCMP  W27, W28, #0xe, HI
    CMP  W16, W13, UXTX #0
    CMP  X13, X20, ASR #21
    CCMP  W13, #0x2, #0xc, EQ
    CMN  W17, #0x1bd
    CMP  W2, W29, ASR #3
    CMP  X18, X11, LSR #44
    CMN  W13, W17, LSR #6
    CMP  W27, W20, SXTW #3
    CMN  W28, #0x8d, LSL #12
    CMN  X12, X9, ASR #50
    CMN  W28, W28, ASR #3
    CCMN  W18, W18, #0xf, PL
    CCMP  X14, #0x10, #0xc, NE
    CMN  W15, W16, LSR #15
    CMP  W26, #0x47c
    CMN  X27, X2, LSL #48
    CMP  X4, W29, UXTB #2
    SUBS  X13, X13, #0x1
    B.NE  TSRTIntCompare_label_5
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X2, #0xfbd9, LSL #0
    MOVK  X2, #0x56f7, LSL #16
    MOVK  X2, #0x4cf7, LSL #32
    MOVK  X2, #0x265e, LSL #48
    MOVZ  X3, #0x3af8, LSL #0
    MOVK  X3, #0x9f7f, LSL #16
    MOVK  X3, #0x496b, LSL #32
    MOVK  X3, #0x9343, LSL #48
    MOVZ  X4, #0x945c, LSL #0
    MOVK  X4, #0xd8e6, LSL #16
    MOVK  X4, #0x3085, LSL #32
    MOVK  X4, #0xf68b, LSL #48
    MOVZ  X5, #0x8da4, LSL #0
    MOVK  X5, #0xc5dc, LSL #16
    MOVK  X5, #0x21ff, LSL #32
    MOVK  X5, #0xdb33, LSL #48
    MOVZ  X7, #0x5ad9, LSL #0
    MOVK  X7, #0xc150, LSL #16
    MOVK  X7, #0xaa40, LSL #32
    MOVK  X7, #0xb7e, LSL #48
    MOVZ  X9, #0x1910, LSL #0
    MOVK  X9, #0xce9f, LSL #16
    MOVK  X9, #0xca39, LSL #32
    MOVK  X9, #0x8778, LSL #48
    MOVZ  X10, #0xe7ff, LSL #0
    MOVK  X10, #0x2102, LSL #16
    MOVK  X10, #0x172, LSL #32
    MOVK  X10, #0x5e0, LSL #48
    MOVZ  X11, #0x9213, LSL #0
    MOVK  X11, #0xec39, LSL #16
    MOVK  X11, #0x7e4, LSL #32
    MOVK  X11, #0xc205, LSL #48
    MOVZ  X12, #0x1b45, LSL #0
    MOVK  X12, #0x1ffd, LSL #16
    MOVK  X12, #0xd6d, LSL #32
    MOVK  X12, #0x6484, LSL #48
    MOVZ  X13, #0x6d97, LSL #0
    MOVK  X13, #0x1cf8, LSL #16
    MOVK  X13, #0xe37f, LSL #32
    MOVK  X13, #0xd9e7, LSL #48
    MOVZ  X14, #0x943d, LSL #0
    MOVK  X14, #0x653b, LSL #16
    MOVK  X14, #0xf6b1, LSL #32
    MOVK  X14, #0x7c12, LSL #48
    MOVZ  X15, #0x38b2, LSL #0
    MOVK  X15, #0x603, LSL #16
    MOVK  X15, #0xf282, LSL #32
    MOVK  X15, #0x3e6d, LSL #48
    MOVZ  X16, #0x45db, LSL #0
    MOVK  X16, #0xe79f, LSL #16
    MOVK  X16, #0x8a4c, LSL #32
    MOVK  X16, #0xaaf1, LSL #48
    MOVZ  X17, #0xb520, LSL #0
    MOVK  X17, #0xdb02, LSL #16
    MOVK  X17, #0x9817, LSL #32
    MOVK  X17, #0x828e, LSL #48
    MOVZ  X18, #0x1b19, LSL #0
    MOVK  X18, #0x4f75, LSL #16
    MOVK  X18, #0x9d36, LSL #32
    MOVK  X18, #0x30ac, LSL #48
    MOVZ  X19, #0x4d93, LSL #0
    MOVK  X19, #0xc262, LSL #16
    MOVK  X19, #0xf3f2, LSL #32
    MOVK  X19, #0xbb61, LSL #48
    MOVZ  X20, #0x2f87, LSL #0
    MOVK  X20, #0x9a05, LSL #16
    MOVK  X20, #0x45e5, LSL #32
    MOVK  X20, #0x97b6, LSL #48
    MOVZ  X21, #0x6699, LSL #0
    MOVK  X21, #0x6c1a, LSL #16
    MOVK  X21, #0x5ba8, LSL #32
    MOVK  X21, #0xc2bc, LSL #48
    MOVZ  X22, #0x7f5c, LSL #0
    MOVK  X22, #0xd7e, LSL #16
    MOVK  X22, #0x87bb, LSL #32
    MOVK  X22, #0xc676, LSL #48
    MOVZ  X24, #0xd325, LSL #0
    MOVK  X24, #0xeee8, LSL #16
    MOVK  X24, #0x65db, LSL #32
    MOVK  X24, #0x3135, LSL #48
    MOVZ  X26, #0xd245, LSL #0
    MOVK  X26, #0xe5dc, LSL #16
    MOVK  X26, #0xda8c, LSL #32
    MOVK  X26, #0x2a54, LSL #48
    MOVZ  X27, #0x479, LSL #0
    MOVK  X27, #0xdb45, LSL #16
    MOVK  X27, #0x6c6b, LSL #32
    MOVK  X27, #0x5dac, LSL #48
    MOVZ  X28, #0x476d, LSL #0
    MOVK  X28, #0xeb69, LSL #16
    MOVK  X28, #0xc5b8, LSL #32
    MOVK  X28, #0x6e42, LSL #48
    MOVZ  X29, #0xb9d5, LSL #0
    MOVK  X29, #0xba27, LSL #16
    MOVK  X29, #0xd1ff, LSL #32
    MOVK  X29, #0x3bad, LSL #48
    MOVZ  X20, #0xf, LSL #0
TSRTIntCompare_label_6:
    CMN  X28, X24, ASR #25
    CCMP  W27, W26, #0xb, NE
    CMP  W29, W29, SXTB #1
    CCMP  W20, W20, #0x8, GE
    CMN  X22, X16, LSL #25
    CMP  X16, #0xf95
    CCMP  W7, #0xa, #0x6, CS
    CCMP  W28, #0x5, #0xd, EQ
    CCMN  X2, #0x15, #0xf, CS
    CCMP  W2, W7, #0xc, PL
    CMN  W3, W15, ASR #5
    CMP  X11, #0x791, LSL #12
    CCMN  W7, W22, #0xf, VS
    CMP  X2, X12, UXTX #1
    CMP  X2, X3, LSL #37
    CCMN  X7, #0x1f, #0x2, LT
    CCMP  X14, #0x7, #0xf, NV
    CCMN  X27, X11, #0x6, GE
    CMP  X26, X20, LSR #30
    CMN  X24, X18, LSL #23
    CCMN  X17, X19, #0x8, PL
    CMP  X2, X27, LSR #51
    CCMP  X15, X15, #0xc, LT
    CMP  W28, W19, ASR #2
    CMN  W28, W27, LSL #15
    CMN  W4, W14, ASR #22
    CMP  X27, X13, LSL #2
    CMN  X3, X13, LSR #36
    CMN  X24, #0x45b
    CMN  X28, W10, SXTW #4
    CCMN  W22, W14, #0x7, VC
    CMP  X16, W26, UXTW #0
    CMN  W3, W22, UXTH #2
    CMP  X27, W15, UXTH #2
    CMN  X20, W17, UXTH #3
    CMN  X2, X7, LSL #2
    CMN  W29, #0xc6a, LSL #12
    CMP  W11, #0x6a, LSL #12
    CCMP  X11, #0x13, #0x8, LS
    CMP  X17, X26, ASR #33
    CMN  X11, #0x3c9, LSL #12
    CMN  X17, X3, ASR #2
    CMP  W20, W27, LSR #18
    CCMN  W20, W4, #0xc, AL
    CMP  X15, #0x722
    CMP  W28, W12, LSL #8
    CMP  X4, X15, ASR #8
    CMP  W16, #0x3b3, LSL #12
    CMP  X18, W17, SXTH #2
    CMP  W15, #0xc2f
    CMP  W24, W12, LSR #19
    CCMN  X14, X2, #0xf, GE
    CMN  W3, W3, UXTB #4
    CCMP  X15, X28, #0xa, HI
    CMN  X19, X27, SXTX #1
    CMN  W24, #0x782
    CMP  W18, W24, SXTB #1
    CCMP  W9, #0x6, #0xe, GT
    CCMP  W27, W14, #0xa, NE
    CMP  W19, #0x105, LSL #12
    CCMN  X7, #0x13, #0x8, LE
    CMN  W7, #0x6e7
    CMN  W26, W26, LSR #6
    CCMP  X14, #0xc, #0x2, MI
    CMN  W24, W20, UXTX #2
    CMP  X12, W16, UXTW #3
    CMP  W28, W9, UXTB #4
    CMP  W14, W19, SXTB #0
    CMN  W17, W10, SXTB #4
    CMN  W22, #0x95b, LSL #12
    CCMN  X16, X27, #0xb, NV
    CCMN  X13, X28, #0xd, NV
    CMN  W7, W16, LSL #3
    CMN  X12, #0xdfc, LSL #12
    CMN  X22, X12, ASR #26
    CCMP  W28, #0x15, #0x3, CC
    CCMP  W20, W29, #0x2, VS
    CMN  X16, X15, LSR #36
    CCMP  W11, W26, #0x6, PL
    CMN  W7, W28, LSL #22
    CCMP  W19, #0x12, #0x5, GE
    CMN  W3, W2, UXTB #1
    CCMN  X3, #0x1a, #0x6, LS
    CMN  W17, #0xb11
    CMN  W2, W18, UXTH #3
    CMN  X19, #0xf15
    CMP  W10, #0xae
    CCMP  X13, X4, #0x1, HI
    CMN  X12, #0x623
    CMP  X11, W9, SXTB #3
    CCMP  W7, W4, #0xf, EQ
    CCMN  W7, W17, #0xd, AL
    CMN  W27, W22, SXTB #1
    CMP  W24, #0x6a6
    CCMP  W16, #0xc, #0x8, LS
    CMP  W24, W7, LSR #0
    CMN  X29, #0x32d, LSL #12
    CCMN  W15, #0x10, #0x0, CC
    CMN  W24, W2, LSR #1
    CMP  X9, #0x17f, LSL #12
    CMP  W4, W17, LSL #24
    CCMN  W12, W17, #0x0, VC
    CMP  X26, #0xa86, LSL #12
    CMN  W14, W4, SXTX #2
    CCMP  X9, #0xd, #0x0, NV
    CCMN  X3, #0x15, #0xc, NE
    CCMP  X10, #0x13, #0x1, LS
    CCMN  W20, W16, #0xe, HI
    CMN  X22, W11, UXTW #1
    CMP  X17, W2, UXTW #4
    CMP  W4, W9, LSL #12
    CMN  W11, W12, SXTW #4
    CCMN  W4, W9, #0x2, GT
    CMP  X12, W2, UXTB #0
    CMP  X14, #0x76f, LSL #12
    CMN  W18, #0xee
    CMN  W13, W24, LSR #2
    CCMP  W4, W20, #0x1, HI
    CMP  X7, X12, LSL #48
    CCMN  X9, #0x14, #0x4, VC
    CCMN  X16, X27, #0xd, GE
    CCMP  X18, #0x16, #0x0, VC
    CMN  W10, W14, LSL #1
    CMP  X12, #0x1f6
    CMN  X19, W20, UXTW #4
    CCMN  X2, #0x15, #0xd, VC
    CMN  X14, X22, UXTX #1
    CCMN  X24, #0x16, #0xf, LE
    CCMP  X3, #0xf, #0x5, PL
    CCMP  X13, X29, #0x5, MI
    CCMP  X19, #0x2, #0x6, LT
    CCMP  W16, #0x0, #0xf, MI
    CMN  X9, W16, SXTH #4
    CMN  W20, #0xe48, LSL #12
    CMP  W17, W3, LSL #1
    CMP  X29, X10, LSL #57
    CMP  X26, #0x68c, LSL #12
    CCMN  W29, W14, #0xe, GT
    CMN  X28, #0xd69, LSL #12
    CMP  W12, #0x19c, LSL #12
    CMN  X15, W27, UXTW #4
    CCMP  X9, #0x1c, #0x2, PL
    CCMN  X11, X11, #0x6, VS
    CCMN  X26, X2, #0xf, MI
    CMN  W29, #0x554
    CMN  W19, W16, LSR #22
    CCMN  W17, #0xf, #0x1, MI
    CCMN  X11, #0xc, #0xf, MI
    CCMN  X17, X2, #0xf, LT
    CMP  X29, W24, SXTW #2
    CCMP  W28, #0x18, #0xc, HI
    CMN  W15, #0xdc3
    CCMP  X2, X7, #0x7, CC
    CCMN  X7, #0x2, #0x4, LT
    CCMP  X26, X2, #0x3, HI
    CMN  W15, W11, LSL #25
    CCMN  W14, #0x1f, #0x9, VC
    CMP  W27, #0x49c, LSL #12
    CCMN  W27, W3, #0x9, CS
    CMN  W12, W14, ASR #1
    CMN  W13, W19, LSL #27
    CMP  X3, W10, SXTW #4
    CCMN  X12, #0x10, #0xf, LS
    CMP  X2, #0xb0d
    CMN  X14, X29, SXTX #2
    CMP  W15, W7, LSL #9
    CMN  W10, #0x459, LSL #12
    CMP  W2, W2, UXTX #0
    CMN  X13, #0x45c, LSL #12
    CMP  W13, W15, ASR #22
    CMN  W29, #0xd8d, LSL #12
    CMP  W10, W9, LSL #22
    CMP  W26, #0x8bf, LSL #12
    CMN  W28, W28, LSL #4
    CCMN  X10, #0x4, #0xa, CC
    CCMN  W17, W16, #0xc, GE
    CCMP  X9, #0x6, #0x5, LT
    CMP  W24, W7, ASR #16
    CMP  W18, W27, LSR #10
    CCMP  W2, W9, #0xf, VC
    CMN  X27, W4, SXTH #0
    CMN  W12, W10, SXTX #2
    CCMP  X9, X18, #0xc, CS
    CMP  W12, W16, SXTX #2
    CMP  W4, #0xf7b, LSL #12
    CCMN  X17, #0x1d, #0x3, CC
    CMN  X27, X13, LSL #4
    CCMP  W13, #0x6, #0x9, AL
    CMP  W20, W4, SXTW #0
    CMP  X17, W12, UXTW #4
    CCMP  X19, #0x1c, #0x2, LE
    CMP  W15, #0x469
    CMP  W26, W13, UXTX #1
    CCMP  W27, W27, #0xe, EQ
    CCMN  X10, #0x9, #0x3, AL
    CMN  W9, W18, ASR #3
    CMN  W13, W20, LSL #28
    CCMN  W13, #0x8, #0x8, PL
    CMN  W16, W7, ASR #28
    CCMP  X14, X18, #0xb, EQ
    SUBS  X20, X20, #0x1
    B.NE  TSRTIntCompare_label_6
    MOVZ  X5, #0xfbd9, LSL #0
    MOVK  X5, #0x56f7, LSL #16
    MOVK  X5, #0x4cf7, LSL #32
    MOVK  X5, #0x265e, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X5, #0x3af8, LSL #0
    MOVK  X5, #0x9f7f, LSL #16
    MOVK  X5, #0x496b, LSL #32
    MOVK  X5, #0x9343, LSL #48
    SUB  X21, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X5, #0x945c, LSL #0
    MOVK  X5, #0xd8e6, LSL #16
    MOVK  X5, #0x3085, LSL #32
    MOVK  X5, #0xf68b, LSL #48
    SUB  X21, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X5, #0x5ad9, LSL #0
    MOVK  X5, #0xc150, LSL #16
    MOVK  X5, #0xaa40, LSL #32
    MOVK  X5, #0xb7e, LSL #48
    SUB  X21, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X5, #0x1910, LSL #0
    MOVK  X5, #0xce9f, LSL #16
    MOVK  X5, #0xca39, LSL #32
    MOVK  X5, #0x8778, LSL #48
    SUB  X21, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X5, #0xe7ff, LSL #0
    MOVK  X5, #0x2102, LSL #16
    MOVK  X5, #0x172, LSL #32
    MOVK  X5, #0x5e0, LSL #48
    SUB  X21, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X5, #0x9213, LSL #0
    MOVK  X5, #0xec39, LSL #16
    MOVK  X5, #0x7e4, LSL #32
    MOVK  X5, #0xc205, LSL #48
    SUB  X21, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X5, #0x1b45, LSL #0
    MOVK  X5, #0x1ffd, LSL #16
    MOVK  X5, #0xd6d, LSL #32
    MOVK  X5, #0x6484, LSL #48
    SUB  X21, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X5, #0x6d97, LSL #0
    MOVK  X5, #0x1cf8, LSL #16
    MOVK  X5, #0xe37f, LSL #32
    MOVK  X5, #0xd9e7, LSL #48
    SUB  X21, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X5, #0x943d, LSL #0
    MOVK  X5, #0x653b, LSL #16
    MOVK  X5, #0xf6b1, LSL #32
    MOVK  X5, #0x7c12, LSL #48
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X5, #0x38b2, LSL #0
    MOVK  X5, #0x603, LSL #16
    MOVK  X5, #0xf282, LSL #32
    MOVK  X5, #0x3e6d, LSL #48
    SUB  X21, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X5, #0x45db, LSL #0
    MOVK  X5, #0xe79f, LSL #16
    MOVK  X5, #0x8a4c, LSL #32
    MOVK  X5, #0xaaf1, LSL #48
    SUB  X21, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X5, #0xb520, LSL #0
    MOVK  X5, #0xdb02, LSL #16
    MOVK  X5, #0x9817, LSL #32
    MOVK  X5, #0x828e, LSL #48
    SUB  X21, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X5, #0x1b19, LSL #0
    MOVK  X5, #0x4f75, LSL #16
    MOVK  X5, #0x9d36, LSL #32
    MOVK  X5, #0x30ac, LSL #48
    SUB  X21, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X5, #0x4d93, LSL #0
    MOVK  X5, #0xc262, LSL #16
    MOVK  X5, #0xf3f2, LSL #32
    MOVK  X5, #0xbb61, LSL #48
    SUB  X21, X5, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X5, #0x7f5c, LSL #0
    MOVK  X5, #0xd7e, LSL #16
    MOVK  X5, #0x87bb, LSL #32
    MOVK  X5, #0xc676, LSL #48
    SUB  X21, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X5, #0xd325, LSL #0
    MOVK  X5, #0xeee8, LSL #16
    MOVK  X5, #0x65db, LSL #32
    MOVK  X5, #0x3135, LSL #48
    SUB  X21, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X5, #0xd245, LSL #0
    MOVK  X5, #0xe5dc, LSL #16
    MOVK  X5, #0xda8c, LSL #32
    MOVK  X5, #0x2a54, LSL #48
    SUB  X21, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X5, #0x479, LSL #0
    MOVK  X5, #0xdb45, LSL #16
    MOVK  X5, #0x6c6b, LSL #32
    MOVK  X5, #0x5dac, LSL #48
    SUB  X21, X5, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X5, #0x476d, LSL #0
    MOVK  X5, #0xeb69, LSL #16
    MOVK  X5, #0xc5b8, LSL #32
    MOVK  X5, #0x6e42, LSL #48
    SUB  X21, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X5, #0xb9d5, LSL #0
    MOVK  X5, #0xba27, LSL #16
    MOVK  X5, #0xd1ff, LSL #32
    MOVK  X5, #0x3bad, LSL #48
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X24, #0xf, LSL #0
TSRTIntCompare_label_7:
    CMP  W11, W10, UXTH #3
    CMP  W13, #0x800
    CMN  W26, #0x61f
    CMP  W24, W18, LSR #5
    CCMN  W17, #0x6, #0x5, NV
    CCMN  W16, W16, #0x6, MI
    CMP  X29, X20, UXTX #0
    CCMN  X28, X28, #0xd, GE
    CMP  W27, #0xdbc
    CMN  X19, #0xbe5, LSL #12
    CCMP  X5, #0x13, #0x1, CS
    CCMN  W29, W16, #0x2, LE
    CMN  W5, #0x275, LSL #12
    CMN  W5, W14, SXTB #0
    CMP  X15, #0xbe5
    CCMP  W13, #0x8, #0x0, VC
    CMN  X2, X5, ASR #10
    CMP  W24, W15, UXTX #2
    CMP  W2, W16, LSL #20
    CMP  X28, #0x7a0, LSL #12
    CMN  W14, W28, ASR #23
    CMP  W5, W29, UXTW #2
    CCMP  X26, X9, #0xe, NV
    CMP  X10, X5, LSR #55
    CCMN  X7, #0x4, #0x8, NV
    CMN  W5, #0x6ff
    CMP  W18, #0xa80, LSL #12
    CCMN  X28, #0x0, #0x1, GT
    CMP  W9, W2, SXTB #3
    CMP  W16, W18, LSR #30
    CCMP  W24, #0x14, #0x8, EQ
    CMN  X3, X12, SXTX #1
    CMN  X16, #0x710, LSL #12
    CMP  W9, #0x2dd
    CCMN  X7, #0x1c, #0x8, VC
    CMP  W20, W18, ASR #31
    CCMN  X27, X18, #0xd, PL
    CCMP  X20, #0x4, #0x5, EQ
    CCMP  X29, #0x7, #0x7, CS
    CCMN  W10, #0x15, #0xa, PL
    CCMP  W3, #0x1e, #0x5, NE
    CMN  W15, W13, UXTH #3
    CCMN  W19, W9, #0x2, NV
    CCMP  W5, #0x7, #0xb, VS
    CMP  X27, X20, ASR #27
    CMP  W19, W5, LSL #21
    CMP  W13, #0xc56, LSL #12
    CMN  W15, W14, LSL #19
    CMP  W20, W4, SXTW #0
    CMN  W16, W7, SXTB #4
    CCMN  X15, X9, #0x6, CS
    CMP  W5, W5, SXTW #0
    CCMN  W9, W11, #0x3, LE
    CCMN  W20, #0x1d, #0xa, CC
    CMP  X14, #0xe21
    CCMP  W12, W18, #0x0, NV
    CMN  W29, #0xc78, LSL #12
    CMP  X12, W13, UXTW #2
    CMN  W9, W11, ASR #16
    CMN  X28, X14, LSR #33
    CCMN  W28, W26, #0xa, GE
    CCMN  W11, #0x1b, #0xc, MI
    CMP  X3, #0xc57, LSL #12
    CCMN  X26, #0x3, #0x8, VS
    CCMN  W3, W4, #0xe, NV
    CMP  X18, #0x91d, LSL #12
    CMN  X29, X4, UXTX #3
    CMN  W4, W14, SXTH #3
    CCMP  W5, W14, #0x4, VS
    CCMN  W2, W2, #0x4, HI
    CMP  X26, W10, UXTW #3
    CCMP  W26, #0xf, #0x6, CC
    CMP  W16, W28, LSR #19
    CMP  W10, #0xba3, LSL #12
    CMP  X14, #0xa25, LSL #12
    CMP  X12, X20, UXTX #0
    CMP  W9, #0x3e
    CMP  W15, #0xd01
    CMN  W3, #0x898, LSL #12
    CMP  W18, #0xd8
    CMN  X10, X9, SXTX #4
    CCMP  X11, #0x16, #0x7, GT
    CMN  W7, W4, SXTH #2
    CMN  W19, W19, UXTH #2
    CMP  W27, #0x625, LSL #12
    CMN  X18, X24, LSL #29
    CMN  X15, X17, UXTX #3
    CMN  W12, W28, ASR #22
    CMP  X3, #0x122
    CCMP  W14, #0x13, #0x3, NV
    CMP  W17, W29, UXTB #3
    CMP  X20, #0xe84
    CMP  W3, W24, LSR #9
    CCMP  X19, #0x0, #0x8, HI
    CMP  W20, W7, SXTX #0
    CMP  X11, X14, LSL #37
    CMN  X29, X3, ASR #55
    CCMN  X13, X9, #0x8, GE
    CCMN  W17, #0x10, #0x4, LE
    CMP  X3, X11, LSL #8
    CCMN  X5, X9, #0xa, VS
    CCMP  X4, X10, #0x0, HI
    CMP  W15, W7, LSR #17
    CMP  X5, #0xde0, LSL #12
    CCMP  X15, #0x1f, #0xf, EQ
    CCMN  X26, #0x1c, #0xf, AL
    CCMP  X10, X7, #0x6, HI
    CMN  X20, #0xe6d
    CMN  X17, #0x7ca
    CMP  W5, W2, UXTB #2
    CCMN  X7, #0x17, #0x5, GE
    CCMP  W9, #0x7, #0xa, LE
    CCMP  W10, W5, #0x6, VS
    CCMN  W13, W5, #0x6, EQ
    CMP  W24, W17, ASR #6
    CMN  X2, X12, UXTX #1
    CCMN  W18, #0x16, #0x5, GT
    CCMP  W9, W14, #0x8, NE
    CCMP  W3, #0x15, #0xc, NE
    CMP  X14, W19, SXTH #2
    CCMN  X4, #0x1e, #0x0, LE
    CMP  W12, #0xd95, LSL #12
    CMN  X27, W3, SXTW #4
    CMN  X13, W2, SXTW #4
    CMP  W18, W4, LSR #11
    CMN  X5, #0x2f8
    CMP  X2, X10, SXTX #0
    CCMP  X24, #0x1a, #0x1, PL
    CMN  W14, W28, UXTW #3
    CMN  X9, #0xb24
    CMN  W15, #0xaa5, LSL #12
    CMN  X3, #0x7f5, LSL #12
    CCMP  W10, W17, #0x5, EQ
    CCMP  X26, #0x1f, #0x4, LE
    CMP  X27, W20, SXTW #2
    CMP  X15, X14, LSL #2
    CMN  X20, W16, SXTH #0
    CMP  X18, #0xe3, LSL #12
    CMP  X27, X29, LSL #51
    CCMN  X7, X26, #0x7, HI
    CMP  X11, X17, LSL #12
    CMN  W24, #0xfa6, LSL #12
    CCMP  X7, X19, #0x4, EQ
    CCMP  X18, #0x13, #0xd, GT
    CCMP  X20, X29, #0x4, MI
    CMP  X12, W5, UXTH #0
    CMN  W5, #0x15a
    CMN  W5, #0xc21
    CCMN  W10, W2, #0x8, EQ
    CCMP  X17, #0x6, #0x5, VC
    CMN  X2, X15, ASR #58
    CMP  W5, W3, UXTW #4
    CMN  X27, #0x5e2, LSL #12
    CCMN  W29, #0x0, #0xb, NE
    CMN  X14, #0x5c7
    CMN  W28, #0x97e
    CMP  X14, X5, LSL #49
    CMN  X18, W28, UXTB #2
    CMN  W27, W10, ASR #29
    CMN  X2, X7, ASR #26
    CCMN  W27, W14, #0xb, VC
    CMP  W24, W11, ASR #26
    CMN  X18, W2, SXTB #0
    CMP  X2, X27, SXTX #1
    CMP  W17, W16, LSR #11
    CMP  X2, X18, LSL #26
    CMN  X20, W28, SXTW #3
    CMP  X4, #0x782, LSL #12
    CMP  X12, X10, LSR #19
    CMN  W19, #0x8c8, LSL #12
    CMN  X3, X2, SXTX #4
    CMP  X17, #0xf60, LSL #12
    CMN  W27, #0x2, LSL #12
    CCMP  W28, #0x18, #0x1, VC
    CCMP  X2, #0xa, #0xd, CS
    CCMP  W17, #0xc, #0x4, LS
    CCMN  W19, W19, #0x8, CC
    CMP  W13, #0x58e
    CMN  X10, W19, UXTW #3
    CCMN  W18, W20, #0xe, PL
    CCMN  W18, W5, #0x0, EQ
    CMP  W7, W3, LSR #13
    CMN  X4, #0xfa2, LSL #12
    CCMP  W5, W3, #0x5, CS
    CMN  X4, X2, SXTX #1
    CMP  X27, W15, SXTB #2
    CMN  W17, W18, LSL #6
    CMP  W27, W14, LSL #8
    CMP  W16, W18, ASR #10
    CMP  W19, W12, SXTX #4
    CMN  X14, W9, SXTB #2
    CCMN  W26, W14, #0xd, NE
    CCMN  X16, #0x7, #0x7, LT
    CMN  W5, #0xd15
    CMP  W24, #0x149, LSL #12
    CCMP  X9, X20, #0xd, NE
    CMN  W2, W11, UXTW #4
    CCMN  X29, #0xe, #0x0, MI
    CMP  X29, #0x9aa, LSL #12
    CMN  X28, #0xeb7, LSL #12
    SUBS  X24, X24, #0x1
    B.NE  TSRTIntCompare_label_7
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
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
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
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
    MOVZ  X2, #0xf, LSL #0
TSRTIntCompare_label_8:
    CCMN  X24, X27, #0x9, AL
    CMP  W26, W22, ASR #14
    CCMP  X2, #0x13, #0xc, CS
    CMN  W21, W29, ASR #1
    CCMN  W13, W12, #0x9, GT
    CMN  W13, #0xa06, LSL #12
    CMP  X2, #0xa84, LSL #12
    CCMP  X12, #0x3, #0x3, GE
    CMP  X22, #0x2e5
    CCMN  X11, X12, #0x2, VS
    CCMN  W21, W28, #0x7, LS
    CMP  W26, W9, LSL #24
    CMN  W22, W26, UXTW #3
    CMP  X9, W7, SXTB #3
    CCMN  W5, #0x16, #0xf, GT
    CMN  X15, #0xeda
    CCMN  X21, X19, #0x8, CC
    CMP  X27, W17, SXTW #1
    CCMN  X19, X29, #0x1, GT
    CCMN  X21, #0x3, #0x1, MI
    CCMP  W7, W10, #0xa, AL
    CCMP  W5, #0xe, #0x8, EQ
    CMN  X19, #0x960, LSL #12
    CCMP  X3, #0x1a, #0x2, EQ
    CMN  X29, X19, LSR #60
    CCMP  W10, #0x16, #0xc, LT
    CMP  X12, X16, UXTX #4
    CMP  X21, W29, UXTH #2
    CCMN  X5, X28, #0x8, PL
    CMN  X2, X28, ASR #45
    CMN  X16, W10, SXTW #0
    CMP  X5, X17, LSL #2
    CMP  X2, X4, ASR #50
    CMP  W17, W29
    CCMP  X16, X14, #0xc, NV
    CMP  W22, W16, ASR #7
    CMN  W9, W2, LSR #28
    CCMP  X24, X21, #0x2, AL
    CCMN  W17, W4, #0x6, GT
    CMN  W22, W5, SXTH #4
    CCMN  W5, W22, #0xd, CS
    CMN  W21, #0x728
    CCMN  W16, #0x17, #0xf, PL
    CCMN  W13, #0xa, #0xb, LT
    CMN  X19, W4, UXTW #0
    CMN  X13, W7, SXTW #4
    CCMN  X24, #0xc, #0x4, PL
    CCMN  X26, #0x10, #0x9, LT
    CMN  X29, W9, SXTH #2
    CMN  X10, W28, UXTH #3
    CMN  X21, X21, LSL #40
    CMP  W11, W26, ASR #21
    CMN  W26, W16, SXTX #0
    CMN  W15, #0x45b
    CCMN  X4, X15, #0x9, LT
    CMN  X4, W4, UXTW #4
    CCMP  X24, X12, #0xa, NV
    CCMN  X11, X22, #0x3, GE
    CMN  W27, #0x7e0, LSL #12
    CCMP  X11, X19, #0x8, NV
    CMN  W3, W7, SXTH #4
    CMN  X5, W17, SXTW #0
    CMP  W19, W19, UXTX #3
    CCMP  W13, #0x9, #0xc, NV
    CCMP  X19, #0xe, #0x2, EQ
    CCMN  X26, #0x7, #0x9, MI
    CCMP  X14, #0x14, #0xa, AL
    CMN  W3, #0xc2b, LSL #12
    CMN  W28, W4, LSL #15
    CCMP  W27, #0xf, #0x8, LE
    CMP  W11, W22, LSL #16
    CMP  W27, #0xc6b, LSL #12
    CMP  W9, W5, UXTB #4
    CMN  X28, #0xc11, LSL #12
    CCMP  X9, #0x0, #0x7, EQ
    CCMN  X9, #0x1a, #0xc, EQ
    CMN  W12, W29, SXTH #4
    CMP  X10, W28, SXTB #4
    CMN  W13, W5, SXTW #3
    CMN  W21, W16, SXTH #3
    CMP  X11, #0x627, LSL #12
    CMP  X3, #0x5d8, LSL #12
    CMP  X28, X21, SXTX #1
    CMP  W28, W29, UXTB #1
    CMN  W13, W27, ASR #0
    CMN  W11, W27, LSR #27
    CMP  W9, W9, UXTX #1
    CMN  W24, #0x8d6
    CMN  W27, W28, LSR #19
    CMP  W19, W9, LSL #16
    CMN  W26, W13, UXTH #2
    CCMN  X21, X21, #0xe, AL
    CCMN  W22, #0x1d, #0x3, LS
    CMP  W22, W5, ASR #19
    CMP  W28, W3, UXTX #2
    CMP  W12, #0xdb, LSL #12
    CMN  W19, W2, LSL #2
    CCMN  W29, W15, #0xf, CC
    CMP  W12, W22, UXTX #4
    CCMN  X29, X9, #0x8, EQ
    CCMP  X12, X14, #0xd, VS
    CMP  X3, #0x58b, LSL #12
    CCMN  X24, X4, #0x8, NE
    CMN  X5, X19, LSL #10
    CCMP  X16, X16, #0xb, HI
    CMN  X14, W11, UXTW #2
    CCMN  X24, #0x5, #0x6, GE
    CCMP  W4, #0x18, #0xa, AL
    CMP  W16, W5, LSR #22
    CMP  W3, #0x6f0, LSL #12
    CCMN  X19, #0x2, #0x8, PL
    CCMP  W29, W19, #0xe, LT
    CCMN  X2, X19, #0x2, NE
    CCMN  W19, #0x3, #0x8, VS
    CCMP  W3, #0x1e, #0xb, HI
    CCMP  W12, W26, #0x1, CC
    CCMN  X13, #0x8, #0xe, VC
    CMP  X29, X10, LSR #42
    CMN  X4, #0x654
    CMP  X5, X24, LSL #5
    CMN  W22, #0x3ca, LSL #12
    CMN  W12, W10, SXTH #4
    CMN  X28, X24, LSL #7
    CCMN  W14, W17, #0x0, NE
    CCMN  W14, W17, #0xd, MI
    CMP  W15, W15, LSR #16
    CMN  W17, W7, UXTH #4
    CCMN  X12, #0x3, #0x9, GE
    CCMN  W16, #0x1, #0xa, VC
    CMP  W5, W14, UXTX #2
    CMN  W21, W14, UXTW #4
    CMN  W7, W14, SXTW #3
    CCMP  W28, #0x1a, #0x5, LS
    CCMN  W7, #0x8, #0x0, CC
    CMP  W21, W21, SXTH #3
    CCMP  X29, #0x9, #0x4, AL
    CCMN  X2, #0xe, #0x0, PL
    CMP  X21, W28, SXTW #1
    CMN  X28, X14, LSR #44
    CCMP  X19, #0xc, #0x3, CS
    CMP  X19, #0x74, LSL #12
    CCMN  W21, #0xd, #0x6, CC
    CCMN  W5, #0x6, #0xe, NV
    CCMN  X15, #0x1d, #0x1, NV
    CMN  X7, X27, SXTX #1
    CCMP  X3, #0x15, #0xd, CC
    CMP  W12, #0x262, LSL #12
    CMN  X15, X28, ASR #9
    CMP  X15, X10, LSR #35
    CMN  W2, #0xa96
    CMN  X28, X11, LSL #6
    CMP  X14, #0x7ae
    CCMP  W2, W28, #0x9, VS
    CCMN  X24, #0x1d, #0x7, CC
    CMN  X22, X7, UXTX #3
    CMP  X26, #0xdf3, LSL #12
    CCMP  X28, #0x15, #0x5, EQ
    CCMP  W2, W5, #0x4, GT
    CMP  W7, #0xa18, LSL #12
    CCMN  X17, #0x9, #0x5, LE
    CMP  X10, X22, LSL #38
    CMN  X17, #0x6f3, LSL #12
    CCMN  W14, #0x6, #0xf, PL
    CCMP  X2, X5, #0xc, AL
    CMP  W27, W14, UXTX #1
    CMN  W27, W7, LSR #18
    CMP  X10, X29, ASR #43
    CCMN  X24, #0x8, #0x5, VC
    CMP  W12, W9, LSR #26
    CMP  W5, W22, ASR #25
    CCMN  X7, #0x4, #0x0, LT
    CCMN  X12, #0x19, #0xc, LT
    CCMP  W17, W22, #0x5, HI
    CCMP  X19, #0x18, #0x3, NE
    CCMP  X3, X7, #0x4, GE
    CMP  W21, #0xa7e
    CCMN  X13, #0xb, #0x9, GT
    CMP  X15, #0xf15
    CCMP  W26, W19, #0xb, GE
    CCMP  X17, #0x14, #0xe, NE
    CMN  W5, #0x632
    CMP  X5, X29, ASR #15
    CCMN  W7, W13, #0x0, VC
    CCMP  W5, #0x19, #0xe, PL
    CCMP  X26, X12, #0xd, LS
    CCMN  W2, W17, #0xe, EQ
    CCMP  X14, #0xb, #0x6, PL
    CCMP  X4, X26, #0x1, VC
    CMN  W29, #0xf46, LSL #12
    CCMN  X27, X7, #0xe, LT
    CMN  X3, X26, ASR #3
    CMP  X22, X27, ASR #17
    CCMP  W28, #0x12, #0xd, LE
    CCMN  W26, W27, #0x0, CS
    CCMP  X5, X13, #0xc, NV
    CCMP  X11, #0x19, #0x7, LS
    CMP  X21, #0x5e3, LSL #12
    CMN  X17, W29, UXTB #0
    CMN  X7, #0xe1d, LSL #12
    CCMN  X19, X19, #0x2, CS
    SUBS  X2, X2, #0x1
    B.NE  TSRTIntCompare_label_8
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X20, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X20, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X20, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X20, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X20, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X20, X18, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X20, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X20, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X20, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X20, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X20, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X20, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X20, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X20, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X20, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X20, X18, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X20, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X20, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X20, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0x97bf, LSL #0
    MOVK  X2, #0x6a94, LSL #16
    MOVK  X2, #0xa513, LSL #32
    MOVK  X2, #0x4ce2, LSL #48
    MOVZ  X3, #0x148, LSL #0
    MOVK  X3, #0x7676, LSL #16
    MOVK  X3, #0xd93f, LSL #32
    MOVK  X3, #0x35ef, LSL #48
    MOVZ  X4, #0x109e, LSL #0
    MOVK  X4, #0xc296, LSL #16
    MOVK  X4, #0x1e7e, LSL #32
    MOVK  X4, #0xfbe, LSL #48
    MOVZ  X5, #0x7366, LSL #0
    MOVK  X5, #0x35ab, LSL #16
    MOVK  X5, #0x5d56, LSL #32
    MOVK  X5, #0x301b, LSL #48
    MOVZ  X7, #0xe4d6, LSL #0
    MOVK  X7, #0x1c82, LSL #16
    MOVK  X7, #0xfddd, LSL #32
    MOVK  X7, #0xa070, LSL #48
    MOVZ  X9, #0xe59f, LSL #0
    MOVK  X9, #0x4330, LSL #16
    MOVK  X9, #0xce25, LSL #32
    MOVK  X9, #0x861, LSL #48
    MOVZ  X10, #0x42bf, LSL #0
    MOVK  X10, #0x844f, LSL #16
    MOVK  X10, #0x9343, LSL #32
    MOVK  X10, #0xc44b, LSL #48
    MOVZ  X11, #0x8abe, LSL #0
    MOVK  X11, #0xfb5d, LSL #16
    MOVK  X11, #0x4f19, LSL #32
    MOVK  X11, #0x8573, LSL #48
    MOVZ  X12, #0x3866, LSL #0
    MOVK  X12, #0xb359, LSL #16
    MOVK  X12, #0x8d5f, LSL #32
    MOVK  X12, #0xbac8, LSL #48
    MOVZ  X13, #0x1412, LSL #0
    MOVK  X13, #0xbda7, LSL #16
    MOVK  X13, #0x95e2, LSL #32
    MOVK  X13, #0xb161, LSL #48
    MOVZ  X14, #0x2de1, LSL #0
    MOVK  X14, #0x79dc, LSL #16
    MOVK  X14, #0x693, LSL #32
    MOVK  X14, #0x52e6, LSL #48
    MOVZ  X15, #0xc420, LSL #0
    MOVK  X15, #0x1be7, LSL #16
    MOVK  X15, #0x9f20, LSL #32
    MOVK  X15, #0xd0dc, LSL #48
    MOVZ  X16, #0xa38c, LSL #0
    MOVK  X16, #0x775d, LSL #16
    MOVK  X16, #0xc390, LSL #32
    MOVK  X16, #0x4c35, LSL #48
    MOVZ  X17, #0xff00, LSL #0
    MOVK  X17, #0x2302, LSL #16
    MOVK  X17, #0x9d2e, LSL #32
    MOVK  X17, #0x78fa, LSL #48
    MOVZ  X18, #0x998, LSL #0
    MOVK  X18, #0xd93b, LSL #16
    MOVK  X18, #0x4d3a, LSL #32
    MOVK  X18, #0x2dfb, LSL #48
    MOVZ  X19, #0x316c, LSL #0
    MOVK  X19, #0x74f6, LSL #16
    MOVK  X19, #0xf870, LSL #32
    MOVK  X19, #0x96fd, LSL #48
    MOVZ  X20, #0x8d74, LSL #0
    MOVK  X20, #0xaa96, LSL #16
    MOVK  X20, #0x50b0, LSL #32
    MOVK  X20, #0x3128, LSL #48
    MOVZ  X21, #0xd369, LSL #0
    MOVK  X21, #0x9aca, LSL #16
    MOVK  X21, #0x6c64, LSL #32
    MOVK  X21, #0xfdd6, LSL #48
    MOVZ  X22, #0x910c, LSL #0
    MOVK  X22, #0x3784, LSL #16
    MOVK  X22, #0x1ec5, LSL #32
    MOVK  X22, #0x8533, LSL #48
    MOVZ  X24, #0xa7f3, LSL #0
    MOVK  X24, #0xf942, LSL #16
    MOVK  X24, #0xe6eb, LSL #32
    MOVK  X24, #0x5bd8, LSL #48
    MOVZ  X26, #0xd718, LSL #0
    MOVK  X26, #0xd7f9, LSL #16
    MOVK  X26, #0x334c, LSL #32
    MOVK  X26, #0xf4ae, LSL #48
    MOVZ  X27, #0xd180, LSL #0
    MOVK  X27, #0x5e23, LSL #16
    MOVK  X27, #0xbf46, LSL #32
    MOVK  X27, #0x5cc7, LSL #48
    MOVZ  X28, #0x41e, LSL #0
    MOVK  X28, #0x65ad, LSL #16
    MOVK  X28, #0x9e1c, LSL #32
    MOVK  X28, #0xec65, LSL #48
    MOVZ  X29, #0x7647, LSL #0
    MOVK  X29, #0x63f7, LSL #16
    MOVK  X29, #0xae19, LSL #32
    MOVK  X29, #0x730a, LSL #48
    MOVZ  X15, #0xf, LSL #0
TSRTIntCompare_label_9:
    CMN  W26, #0xd3a, LSL #12
    CMN  W24, #0xafd
    CMN  X15, X15, ASR #11
    CMN  W14, W29, UXTB #0
    CCMN  W28, W28, #0x2, VC
    CMP  X12, X4, ASR #61
    CMN  W26, W21, UXTW #3
    CCMP  W7, W16, #0x0, HI
    CMP  X15, X12, LSR #54
    CMP  W14, #0x320, LSL #12
    CCMN  W21, W24, #0x2, LT
    CCMN  W15, #0x12, #0x7, LT
    CCMP  X4, X9, #0xd, AL
    CMP  X7, X21, LSL #16
    CMN  W16, #0x998, LSL #12
    CMP  X10, W2, UXTH #0
    CMP  W7, #0x739, LSL #12
    CMP  W11, W14
    CCMN  W9, #0x7, #0x5, GE
    CMN  W7, W26, ASR #4
    CCMP  W10, W12, #0xa, EQ
    CMN  X13, X17, LSL #12
    CMN  W14, #0x300
    CMP  W12, W29, LSR #21
    CMP  W22, W4, SXTW #3
    CCMN  X14, X14, #0x0, MI
    CMN  X9, #0xaf8
    CCMP  X17, X17, #0x4, GE
    CCMN  W12, W26, #0xd, VC
    CCMP  W10, W22, #0xe, HI
    CMP  X20, W10, UXTW #0
    CMN  X13, X18, ASR #43
    CMN  W20, W10, UXTX #4
    CMN  W24, #0x41c, LSL #12
    CMN  W15, #0xe16, LSL #12
    CMP  X9, X28, ASR #45
    CCMN  X26, X2, #0xf, LE
    CMN  X18, #0x700, LSL #12
    CMN  W22, #0xc70, LSL #12
    CMN  X26, W4, UXTW #1
    CMP  X21, X16, LSL #23
    CMP  W28, W12, UXTB #4
    CCMP  X3, X4, #0x5, MI
    CMN  X12, X24, SXTX #3
    CCMN  W16, #0x8, #0xb, PL
    CMN  X20, W14, SXTH #3
    CMN  X17, #0xe39, LSL #12
    CMN  W20, W22, LSR #9
    CMN  X13, #0x6e1, LSL #12
    CMN  X10, #0x17b, LSL #12
    CCMN  X3, X22, #0xf, PL
    CMP  W29, #0x18a, LSL #12
    CCMP  X10, #0xe, #0x6, LE
    CMP  X4, #0x542, LSL #12
    CCMP  X14, X18, #0x9, NE
    CCMN  X2, X17, #0x7, CC
    CMN  W21, W28, UXTH #1
    CCMP  X24, X9, #0xf, MI
    CMN  X2, #0x967
    CMN  X15, W29, UXTB #3
    CMN  X5, W15, UXTB #1
    CCMN  X10, #0x8, #0xc, AL
    CMN  X22, W5, SXTW #1
    CMN  W29, W18, SXTH #0
    CMN  X17, X10, ASR #18
    CMN  X4, #0x500, LSL #12
    CMN  X2, W14, UXTH #4
    CCMN  X18, X22, #0xa, GT
    CMP  W15, W7, SXTX #3
    CCMP  W29, #0x1f, #0x0, CS
    CMP  W24, W4, UXTH #1
    CMN  X16, X17, LSL #37
    CCMN  W26, #0x18, #0xc, EQ
    CMP  X7, X14, ASR #30
    CMP  W11, #0xe24
    CMN  X11, X11, ASR #23
    CMP  X16, W17, UXTH #2
    CMN  W26, W10, ASR #17
    CCMP  X12, X5, #0xf, NE
    CMP  W14, W17, SXTW #1
    CMP  W15, W2, UXTW #1
    CCMP  W3, W3, #0xe, NE
    CMN  W20, #0x6b0
    CMN  W13, W11, UXTW #4
    CMN  W11, W15, SXTX #3
    CMN  W2, #0x895, LSL #12
    CMP  X12, X3, ASR #11
    CMP  X2, #0x296
    CMP  X16, W17, SXTH #2
    CCMP  W20, W24, #0xa, NV
    CCMN  X11, #0x1e, #0x2, LE
    CMP  X5, X13, ASR #2
    CMN  X13, X28, LSR #19
    CCMP  X28, #0x3, #0xb, MI
    CMP  X26, W11, UXTW #3
    CMN  W28, W28, LSL #26
    CCMN  W10, #0x7, #0x2, AL
    CMN  W20, #0x248
    CMN  X12, #0x50f, LSL #12
    CCMP  X3, X13, #0x1, MI
    CMP  W15, W11, SXTX #4
    CMP  W10, #0xca8
    CCMN  X7, #0x16, #0xe, AL
    CCMN  X21, X10, #0xd, PL
    CMP  W26, W9, SXTX #4
    CMP  W29, W7, UXTW #4
    CCMN  X18, X20, #0x8, NV
    CCMP  X18, X16, #0x2, NV
    CMP  X16, W24, SXTB #4
    CMN  X28, W11, SXTB #0
    CCMP  W5, W7, #0xf, HI
    CMN  X9, W22, UXTH #2
    CMN  X14, W17, SXTW #1
    CMP  X18, X26, ASR #29
    CMN  X11, W24, UXTW #0
    CMN  W7, W17, UXTB #2
    CMP  X2, #0xebf, LSL #12
    CMP  X28, W28, UXTH #0
    CCMP  W18, W20, #0xe, NV
    CMN  X11, X11, UXTX #3
    CCMN  W29, #0x14, #0x0, NV
    CCMP  W4, W14, #0x5, NV
    CMP  W7, #0x924, LSL #12
    CMP  X2, W3, SXTW #0
    CMN  X28, X24, LSR #14
    CMP  X26, X28, LSR #59
    CMN  X9, X24, LSR #14
    CCMN  X16, #0x12, #0x7, AL
    CMP  X12, #0x51a
    CMN  W3, #0x339
    CMN  W29, #0x84d
    CMP  X9, X18, LSL #10
    CMP  W17, W17, LSL #19
    CMN  W26, W16, UXTH #2
    CCMP  X11, X16, #0xd, AL
    CMN  X22, X3, ASR #2
    CMP  W21, #0x104, LSL #12
    CMP  X2, W29, UXTB #4
    CMN  X17, X28, LSL #49
    CCMN  W17, #0x1a, #0xc, LS
    CMP  X16, X3, SXTX #3
    CCMN  W7, #0x1, #0xe, GT
    CCMN  W10, W24, #0xc, CC
    CCMN  W17, #0xe, #0x5, LS
    CMP  X26, #0xa3b
    CMP  X16, W13, UXTW #2
    CMP  X10, W20, UXTH #1
    CMN  W28, W15, SXTX #1
    CMN  W18, W15, ASR #27
    CMN  W20, W7, ASR #20
    CMP  W12, W18, SXTH #2
    CCMP  X16, X26, #0xf, MI
    CMP  X12, X9, LSR #60
    CCMP  X22, X13, #0x8, AL
    CMP  X22, X20, LSL #21
    CCMN  X12, X21, #0x7, GE
    CMN  X17, X29, LSL #52
    CMN  W2, W20, LSL #7
    CMP  X12, #0xb9b, LSL #12
    CCMN  X22, X2, #0x4, NV
    CMP  X18, X3, ASR #60
    CMN  X10, W22, SXTB #1
    CCMP  W29, #0x18, #0x0, PL
    CCMP  X24, #0x15, #0x8, HI
    CMN  X28, #0x654
    CMP  W20, W21, LSL #8
    CCMP  X22, X20, #0x5, VS
    CMP  W2, W7, ASR #8
    CCMP  W16, #0x6, #0x1, CC
    CMP  W17, W22, SXTW #2
    CMN  X28, #0x83d, LSL #12
    CMN  X18, X20, LSR #30
    CMP  W13, W13, UXTW #2
    CCMN  W14, W14, #0xd, VS
    CMP  W21, #0x243, LSL #12
    CCMN  W22, W21, #0xc, AL
    CMN  W4, #0xa0b
    CCMP  W28, W17, #0x6, VS
    CMN  X3, #0xd0f, LSL #12
    CMN  W7, #0xb37, LSL #12
    CMP  X13, #0x76a
    CMP  W13, W16, UXTW #2
    CCMN  X24, X14, #0x4, EQ
    CCMN  X14, X5, #0xe, CS
    CMP  W12, W10, UXTH #1
    CCMP  W5, W20, #0x5, GT
    CMN  W10, W28, SXTW #1
    CCMP  W15, W16, #0xf, HI
    CCMN  W12, #0x1c, #0x6, AL
    CMP  W28, #0x548, LSL #12
    CMP  X15, #0xf33, LSL #12
    CCMN  W28, W5, #0xc, VS
    CCMP  X28, X10, #0xc, AL
    CMP  X15, #0xd50, LSL #12
    CCMN  W29, W4, #0xa, CC
    CMP  W20, W26, LSL #14
    CCMP  W10, #0x15, #0x8, GT
    CMP  X7, #0x11a
    CMP  W29, W22, LSL #29
    CMP  X12, #0x1fa, LSL #12
    SUBS  X15, X15, #0x1
    B.NE  TSRTIntCompare_label_9
    MOVZ  X19, #0x97bf, LSL #0
    MOVK  X19, #0x6a94, LSL #16
    MOVK  X19, #0xa513, LSL #32
    MOVK  X19, #0x4ce2, LSL #48
    SUB  X27, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X19, #0x148, LSL #0
    MOVK  X19, #0x7676, LSL #16
    MOVK  X19, #0xd93f, LSL #32
    MOVK  X19, #0x35ef, LSL #48
    SUB  X27, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X19, #0x109e, LSL #0
    MOVK  X19, #0xc296, LSL #16
    MOVK  X19, #0x1e7e, LSL #32
    MOVK  X19, #0xfbe, LSL #48
    SUB  X27, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X19, #0x7366, LSL #0
    MOVK  X19, #0x35ab, LSL #16
    MOVK  X19, #0x5d56, LSL #32
    MOVK  X19, #0x301b, LSL #48
    SUB  X27, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X19, #0xe4d6, LSL #0
    MOVK  X19, #0x1c82, LSL #16
    MOVK  X19, #0xfddd, LSL #32
    MOVK  X19, #0xa070, LSL #48
    SUB  X27, X19, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X19, #0xe59f, LSL #0
    MOVK  X19, #0x4330, LSL #16
    MOVK  X19, #0xce25, LSL #32
    MOVK  X19, #0x861, LSL #48
    SUB  X27, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X19, #0x42bf, LSL #0
    MOVK  X19, #0x844f, LSL #16
    MOVK  X19, #0x9343, LSL #32
    MOVK  X19, #0xc44b, LSL #48
    SUB  X27, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X19, #0x8abe, LSL #0
    MOVK  X19, #0xfb5d, LSL #16
    MOVK  X19, #0x4f19, LSL #32
    MOVK  X19, #0x8573, LSL #48
    SUB  X27, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X19, #0x3866, LSL #0
    MOVK  X19, #0xb359, LSL #16
    MOVK  X19, #0x8d5f, LSL #32
    MOVK  X19, #0xbac8, LSL #48
    SUB  X27, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X19, #0x1412, LSL #0
    MOVK  X19, #0xbda7, LSL #16
    MOVK  X19, #0x95e2, LSL #32
    MOVK  X19, #0xb161, LSL #48
    SUB  X27, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X19, #0x2de1, LSL #0
    MOVK  X19, #0x79dc, LSL #16
    MOVK  X19, #0x693, LSL #32
    MOVK  X19, #0x52e6, LSL #48
    SUB  X27, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X27, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X19, #0xa38c, LSL #0
    MOVK  X19, #0x775d, LSL #16
    MOVK  X19, #0xc390, LSL #32
    MOVK  X19, #0x4c35, LSL #48
    SUB  X27, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X19, #0xff00, LSL #0
    MOVK  X19, #0x2302, LSL #16
    MOVK  X19, #0x9d2e, LSL #32
    MOVK  X19, #0x78fa, LSL #48
    SUB  X27, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X19, #0x998, LSL #0
    MOVK  X19, #0xd93b, LSL #16
    MOVK  X19, #0x4d3a, LSL #32
    MOVK  X19, #0x2dfb, LSL #48
    SUB  X27, X19, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X19, #0x8d74, LSL #0
    MOVK  X19, #0xaa96, LSL #16
    MOVK  X19, #0x50b0, LSL #32
    MOVK  X19, #0x3128, LSL #48
    SUB  X27, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X19, #0xd369, LSL #0
    MOVK  X19, #0x9aca, LSL #16
    MOVK  X19, #0x6c64, LSL #32
    MOVK  X19, #0xfdd6, LSL #48
    SUB  X27, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X19, #0x910c, LSL #0
    MOVK  X19, #0x3784, LSL #16
    MOVK  X19, #0x1ec5, LSL #32
    MOVK  X19, #0x8533, LSL #48
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X19, #0xa7f3, LSL #0
    MOVK  X19, #0xf942, LSL #16
    MOVK  X19, #0xe6eb, LSL #32
    MOVK  X19, #0x5bd8, LSL #48
    SUB  X27, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X19, #0xd718, LSL #0
    MOVK  X19, #0xd7f9, LSL #16
    MOVK  X19, #0x334c, LSL #32
    MOVK  X19, #0xf4ae, LSL #48
    SUB  X27, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X19, #0x41e, LSL #0
    MOVK  X19, #0x65ad, LSL #16
    MOVK  X19, #0x9e1c, LSL #32
    MOVK  X19, #0xec65, LSL #48
    SUB  X27, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X19, #0x7647, LSL #0
    MOVK  X19, #0x63f7, LSL #16
    MOVK  X19, #0xae19, LSL #32
    MOVK  X19, #0x730a, LSL #48
    SUB  X27, X19, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X22, #0xf, LSL #0
TSRTIntCompare_label_10:
    CCMN  X22, #0x1, #0x6, PL
    CMN  X17, X29, ASR #58
    CMN  X13, X12, LSR #34
    CCMN  W26, #0x3, #0xe, VS
    CMN  W14, #0x142, LSL #12
    CMP  W18, W15, LSR #13
    CMP  X27, #0xab7
    CCMN  W19, #0xb, #0x7, NE
    CMN  W28, W28, LSR #16
    CCMN  W24, W21, #0x2, CS
    CCMP  W11, #0x1, #0x8, GE
    CCMP  X26, X19, #0x0, VS
    CMP  X29, #0x4df
    CMN  X15, X16, UXTX #4
    CCMP  W28, #0x4, #0x0, LS
    CCMP  W28, W17, #0x5, EQ
    CMN  W14, #0x62b
    CCMN  W28, W24, #0x7, PL
    CMN  W18, W29, ASR #23
    CCMN  W5, #0x1c, #0xa, HI
    CMN  X18, W13, SXTW #4
    CMN  X13, X5, LSL #28
    CMN  X22, X15, UXTX #1
    CMN  X5, W7, UXTB #1
    CMN  W24, W10, SXTB #0
    CCMP  W19, W10, #0x4, GE
    CCMN  W16, #0xb, #0xc, NE
    CMN  X5, W14, SXTW #3
    CMN  X28, X19, ASR #0
    CMP  X15, #0xc74, LSL #12
    CMP  X21, X29, LSL #35
    CMN  X10, W9, UXTB #0
    CMN  X29, #0xf73
    CMN  W12, #0x6db, LSL #12
    CMP  X18, #0xad2, LSL #12
    CCMN  W11, W12, #0xc, VS
    CCMN  X11, #0x1d, #0xc, LE
    CCMN  W7, #0x5, #0xe, GE
    CCMP  W11, W3, #0x6, GT
    CCMP  X13, X24, #0x6, NV
    CMP  X5, #0xdf4, LSL #12
    CCMP  W18, #0xc, #0x4, GT
    CCMP  X22, #0x1, #0x1, CC
    CMN  X4, #0x319, LSL #12
    CCMP  W14, #0x5, #0xc, VS
    CCMN  W5, W19, #0x3, GE
    CMP  W19, #0x8d0
    CCMP  X5, #0x11, #0x9, NV
    CCMP  X22, X28, #0x9, PL
    CCMN  W19, #0x19, #0x8, CC
    CMP  W3, W7, LSL #6
    CMP  W17, #0x3bf
    CMN  W24, W10, UXTB #0
    CMN  W14, W21, SXTX #1
    CMP  W12, W15, ASR #21
    CMN  W14, W10, LSL #7
    CMN  X11, X16, UXTX #3
    CCMN  W22, #0x5, #0x5, LE
    CMP  X3, W5, UXTH #0
    CMP  W17, W11, SXTB #0
    CMN  W13, #0x2f8
    CCMP  X29, #0x1, #0xb, LS
    CCMN  W10, W12, #0x7, LS
    CCMP  X19, X4, #0x5, VC
    CMP  X11, #0xc14
    CMN  W12, W12, SXTW #1
    CMP  W24, W3, UXTH #0
    CMP  X14, X21, SXTX #2
    CCMP  X28, #0xb, #0xe, HI
    CMP  W15, #0xf7c, LSL #12
    CMN  W26, #0x49e, LSL #12
    CCMP  X29, X4, #0x2, LT
    CCMN  X18, X26, #0xa, EQ
    CMN  X11, X18, LSL #33
    CCMN  X11, X24, #0x5, HI
    CMN  X18, W16, SXTW #1
    CCMP  X18, #0x0, #0x2, EQ
    CMN  W9, W29, UXTB #1
    CCMN  W5, #0x9, #0x6, GT
    CMN  W16, W24, ASR #8
    CMP  X22, X27, ASR #26
    CMP  W28, W22, ASR #7
    CMN  W13, W17, ASR #20
    CCMP  X29, X19, #0x3, CC
    CMP  X5, #0x311
    CMP  W15, #0x54f
    CMN  X12, W7, UXTW #4
    CCMP  X10, X3, #0x5, LE
    CCMN  X19, X28, #0x0, GT
    CMP  W15, W9, LSL #2
    CMP  W19, W11, LSL #30
    CMN  W29, W11, UXTW #2
    CMP  X4, X24, ASR #2
    CMN  W16, W15, UXTX #1
    CCMN  X26, X28, #0x5, LT
    CMN  W15, W22, SXTW #3
    CCMN  X14, #0xe, #0xd, VS
    CCMN  W19, W18, #0xa, HI
    CMN  W16, #0x3b, LSL #12
    CMN  W9, W27, ASR #20
    CMP  W15, W28, LSR #20
    CMN  W12, #0x4e8, LSL #12
    CCMN  W13, #0xc, #0x3, CS
    CMN  X7, X15, LSL #42
    CMP  W29, W17, LSR #25
    CMP  X22, #0x164, LSL #12
    CCMP  W27, W15, #0xb, HI
    CCMP  X24, #0x4, #0xf, MI
    CMP  X3, W21, UXTH #2
    CMP  X7, W16, SXTW #4
    CMP  W7, #0xca8
    CCMP  W5, W22, #0x1, NV
    CCMP  X15, #0x4, #0x8, HI
    CMP  W9, W15, SXTB #4
    CCMN  X11, X26, #0xe, EQ
    CMP  W28, W28, SXTH #2
    CCMP  W19, W17, #0x9, EQ
    CMN  W16, W17, UXTH #3
    CMN  W28, W4, ASR #3
    CMP  W4, #0xd9
    CCMN  X24, #0x2, #0x6, LT
    CMN  X14, X28, UXTX #4
    CMN  W14, #0x37d, LSL #12
    CCMP  X12, #0xc, #0x9, LE
    CCMP  W28, W21, #0x6, MI
    CCMP  W21, #0x8, #0x7, CS
    CMN  W12, W27, ASR #21
    CMP  X9, X4, LSL #12
    CMN  X11, W21, UXTB #2
    CMP  X10, #0xcad
    CMP  W27, #0x48, LSL #12
    CCMN  X9, X10, #0x3, LT
    CMP  W26, #0xeb1
    CMP  W29, W15, LSL #2
    CMN  X14, #0x75, LSL #12
    CMP  X11, #0x30a
    CCMP  X17, #0x13, #0xd, VC
    CCMP  X27, #0xe, #0x2, GT
    CMP  X15, X4, LSL #62
    CCMN  W24, #0x1d, #0x7, LS
    CMP  X12, #0xc55, LSL #12
    CMN  W19, #0x29b
    CMN  X15, X14, LSR #49
    CMN  X27, W26, SXTH #4
    CCMP  W11, #0x3, #0x0, NE
    CMP  X13, #0xb94, LSL #12
    CMP  X13, #0x792, LSL #12
    CCMP  W24, #0x6, #0xc, LS
    CMP  X10, W13, SXTW #4
    CMN  X12, X17, LSL #4
    CMP  X27, #0x742
    CMP  X9, #0x360
    CCMP  W22, #0x12, #0x1, NE
    CCMN  W24, W12, #0x2, PL
    CCMN  X13, X4, #0xb, GT
    CCMP  X3, X15, #0xe, CS
    CCMP  W5, #0x13, #0xf, EQ
    CMN  W5, #0x1a3
    CCMN  W19, W22, #0x5, LT
    CCMP  X24, X15, #0x2, LS
    CMP  W7, W24, LSR #20
    CMP  W26, W22
    CMN  W17, W26, LSL #3
    CMP  X26, #0xc13, LSL #12
    CCMN  X26, #0x11, #0xf, CC
    CMP  W9, #0x7d3
    CMP  X7, X28, ASR #19
    CMP  X16, #0x4d
    CCMN  X16, #0x2, #0x7, NE
    CCMN  X4, #0x18, #0x9, VS
    CMN  W13, #0x48c
    CCMN  W4, #0x14, #0x4, MI
    CMP  X28, W17, UXTB #4
    CCMP  X22, #0x5, #0x0, AL
    CCMN  X28, #0x0, #0x4, VC
    CCMP  X10, #0x5, #0x3, VS
    CCMN  W28, W29, #0x3, HI
    CCMN  W17, #0x5, #0xe, VC
    CMN  W7, W14, LSL #4
    CCMP  W15, #0x11, #0x1, LE
    CMP  W12, W12, LSL #25
    CCMN  W24, W26, #0xa, AL
    CMN  W5, W21, ASR #29
    CMP  X14, X19, LSL #25
    CMN  X18, X10, UXTX #2
    CMP  W13, W13, SXTH #0
    CCMP  X26, X9, #0x8, VC
    CMP  X11, W10, SXTB #3
    CMN  W13, #0x6d3
    CMP  X29, W22, UXTW #0
    CMP  W26, W5, LSL #4
    CCMP  X7, X3, #0xa, GT
    CMN  W21, #0xd3d, LSL #12
    CCMP  X9, X19, #0xb, CS
    CMN  W9, W9, SXTX #1
    CMN  W3, W24, LSL #12
    CMN  X5, W22, SXTW #0
    CMP  X16, X11, SXTX #3
    CMN  W28, #0xefd
    CMP  W26, W15, ASR #3
    SUBS  X22, X22, #0x1
    B.NE  TSRTIntCompare_label_10
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
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
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
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
    MOVZ  X21, #0xf, LSL #0
TSRTIntCompare_label_11:
    CMN  X24, #0x96d, LSL #12
    CCMN  X26, #0x14, #0xe, VC
    CCMN  W21, W21, #0xa, LE
    CMN  W13, W2, SXTX #3
    CCMP  X29, #0x1e, #0xd, GT
    CCMP  X28, #0x7, #0xe, MI
    CMP  W21, W21, LSR #21
    CMN  X15, #0xd67
    CCMN  W21, W22, #0x9, CC
    CCMN  X5, X4, #0xf, AL
    CCMN  X24, X17, #0xc, LE
    CMN  W7, W17, ASR #7
    CCMN  W29, #0x3, #0x7, EQ
    CMP  X22, #0x758
    CCMP  X18, #0x1d, #0x2, VS
    CMN  X28, #0xee7, LSL #12
    CCMP  X3, X14, #0x9, CC
    CMP  W15, W9, LSR #4
    CMP  X18, X21, LSR #53
    CMP  X21, X7, LSR #22
    CCMN  X24, X22, #0xd, AL
    CCMN  W24, #0x15, #0x3, VC
    CMP  W26, W5, LSL #16
    CCMN  W7, #0x1d, #0x4, GT
    CMN  W10, W11, LSR #16
    CMP  X4, X18, UXTX #4
    CMN  X13, X22, LSR #63
    CMN  W21, W2, UXTH #2
    CMP  W13, W16, UXTB #3
    CCMN  X16, #0x5, #0x5, NV
    CMP  X24, X21, LSR #59
    CMN  X14, #0x53c
    CMN  W29, W26, ASR #7
    CMN  W26, W13, UXTX #3
    CCMN  X14, #0x12, #0xf, PL
    CMN  X13, W12, UXTH #4
    CMN  X15, W29, UXTB #2
    CMN  X17, W14, UXTW #2
    CCMP  X3, X9, #0x7, PL
    CMN  X9, #0x902
    CCMP  W11, W5, #0xa, CS
    CCMN  X21, #0x1, #0x9, AL
    CMP  X13, W24, UXTB #4
    CMP  X9, W10, SXTB #2
    CMN  X15, X12, LSL #41
    CMP  W22, W26, UXTW #1
    CCMN  X28, #0x12, #0xe, NV
    CCMN  W22, #0x16, #0x9, CS
    CCMN  X7, X11, #0x3, CC
    CCMN  W12, #0x1c, #0x9, LE
    CMN  W20, W14, ASR #29
    CMN  X15, X24, LSR #14
    CMN  W7, W9, SXTX #4
    CMN  X10, #0xa5a
    CMN  X12, W28, SXTW #4
    CCMN  X4, #0x2, #0x4, GE
    CMN  W12, #0xac0
    CMN  W22, W4, ASR #31
    CMP  X24, X10, UXTX #0
    CMN  X5, #0x291, LSL #12
    CCMP  X2, X14, #0xa, CC
    CCMP  X2, X3, #0xc, NV
    CMP  W21, W7, UXTX #1
    CCMP  X16, X22, #0xd, NE
    CMN  X22, W13, UXTB #0
    CMP  W24, #0x6e0, LSL #12
    CMN  W10, #0x11, LSL #12
    CMN  X26, X13, LSL #38
    CMN  W17, W29, SXTX #3
    CCMN  W26, W29, #0x5, PL
    CCMP  W17, #0x10, #0x9, EQ
    CCMP  W11, #0x0, #0x3, CC
    CCMP  W4, W29, #0xc, LE
    CMN  W9, W22, ASR #17
    CMP  X18, W24, SXTW #3
    CCMN  W13, W3, #0xd, GE
    CCMN  X21, #0x7, #0x7, CC
    CCMP  W22, W2, #0x7, LE
    CCMN  X3, #0x1e, #0x7, CS
    CMP  W5, W15, UXTX #2
    CMP  W22, W29, UXTW #4
    CMP  W26, W18, UXTX #2
    CCMP  X26, #0x15, #0x9, HI
    CMP  X7, W15, SXTB #3
    CCMN  W17, W13, #0xf, VC
    CCMP  X13, X9, #0xb, MI
    CCMN  W7, W7, #0x0, VS
    CCMP  X26, X16, #0x7, VC
    CMP  X16, X10, ASR #18
    CMP  X4, W4, SXTB #0
    CMP  W3, W12, ASR #8
    CMP  W21, W13, SXTB #3
    CMN  X18, #0xe6f, LSL #12
    CMN  W24, #0x6c0
    CMP  X13, #0x346
    CCMP  W22, #0x9, #0x5, LS
    CCMP  X15, X4, #0xd, HI
    CMP  W10, #0xd68, LSL #12
    CMP  W28, W26, LSL #25
    CMP  X29, #0x57b
    CMN  W7, W5, SXTH #4
    CMN  X13, #0x20d
    CCMN  W15, #0xa, #0x1, GE
    CCMN  W2, #0x1, #0x2, LE
    CCMP  W4, #0x6, #0x1, LS
    CMN  W3, W20, UXTW #1
    CMP  W11, #0xf2b, LSL #12
    CMN  W2, W22, UXTW #4
    CMP  X4, X17, LSR #63
    CMP  W9, W24, SXTX #0
    CMP  X18, X2, ASR #7
    CMP  W22, W11, LSL #29
    CMN  W16, W14, LSR #29
    CCMN  W17, W29, #0x4, EQ
    CMP  X22, X17, ASR #38
    CCMP  X3, #0xe, #0x9, CC
    CMN  W21, #0xdc6
    CCMN  X14, X22, #0x2, AL
    CMP  W22, W3, ASR #9
    CCMP  X24, X24, #0x0, NV
    CMP  W13, #0x780, LSL #12
    CMN  W10, W10, UXTW #2
    CCMN  W18, #0xd, #0xe, MI
    CCMP  X3, X26, #0xb, LT
    CMP  W9, #0x653
    CCMP  X3, X22, #0x1, LT
    CMN  X26, X7, LSL #40
    CMP  W12, W21, SXTX #1
    CCMN  X22, X15, #0xf, EQ
    CMN  X20, X21, ASR #57
    CMP  W29, W13, LSR #30
    CMN  X26, W20, SXTB #1
    CCMP  X22, #0x17, #0x3, GE
    CCMN  W4, W10, #0xb, LE
    CMP  W16, #0x208, LSL #12
    CCMP  W26, #0x1e, #0x1, GE
    CCMN  W2, W7, #0x6, VS
    CCMN  X13, #0xb, #0xf, MI
    CMN  X10, X10, SXTX #2
    CMN  W11, W2, LSR #14
    CMP  X14, W20, UXTH #3
    CMN  W2, #0x65b
    CCMP  W3, W20, #0xd, NV
    CMP  X11, #0xb4b, LSL #12
    CMP  X22, X14, UXTX #0
    CMN  X22, #0xd02, LSL #12
    CMP  W7, W4, UXTX #4
    CCMP  W12, #0x1c, #0x4, LE
    CCMN  X14, #0xd, #0x2, EQ
    CMP  W16, W26, ASR #15
    CMN  W28, W18, UXTW #2
    CCMN  W13, W3, #0x8, NV
    CCMP  X29, X20, #0xd, CC
    CCMN  W3, W17, #0x9, LT
    CMN  W4, #0x1ba, LSL #12
    CCMN  X5, X4, #0xa, VS
    CCMP  X18, X2, #0xc, VC
    CMP  X21, #0x145, LSL #12
    CMP  W26, W22, UXTH #0
    CCMP  W4, #0x1e, #0x6, CC
    CMP  X20, #0x314
    CCMP  W16, W26, #0x5, EQ
    CCMN  W22, #0x1c, #0x5, LE
    CCMN  X12, X10, #0xa, NV
    CMN  W5, W15, UXTB #4
    CCMP  X11, X12, #0x6, EQ
    CCMP  W26, W28, #0x3, LS
    CMP  X24, W21, SXTB #0
    CCMP  W20, #0x2, #0xc, PL
    CCMN  W17, #0x7, #0x7, LE
    CCMN  W18, #0x1c, #0x8, VC
    CMP  X4, X26, ASR #54
    CMP  W21, W29, SXTB #2
    CCMP  X22, X4, #0xf, CC
    CMN  X22, X2, LSR #61
    CMP  X12, X28, LSL #60
    CMN  W3, W5, UXTB #0
    CMP  W21, W24, ASR #28
    CCMP  X16, X28, #0xf, GE
    CMN  X29, X14, LSR #43
    CCMN  W28, W24, #0x0, EQ
    CMN  W28, W12, UXTW #4
    CMP  W15, #0x682
    CCMP  X2, #0x1e, #0x4, LT
    CMP  W5, W21, SXTX #1
    CCMN  W17, #0x2, #0xf, PL
    CCMP  X4, #0x1f, #0x2, PL
    CMP  X11, X5, ASR #8
    CMP  X3, #0xba3
    CMP  W20, #0xa11
    CMP  X12, #0x9b7, LSL #12
    CMN  W5, #0x162, LSL #12
    CCMN  W4, W9, #0xf, MI
    CCMP  X26, X3, #0xf, CC
    CMN  W14, #0x417
    CCMN  X3, X11, #0xb, PL
    CCMN  X17, #0x1b, #0x1, CC
    CMP  W29, W16, LSL #13
    CMN  X10, #0xb7, LSL #12
    CMP  W10, W12, SXTH #2
    SUBS  X21, X21, #0x1
    B.NE  TSRTIntCompare_label_11
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X19, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X19, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X19, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X19, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X19, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X19, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X19, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X19, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X19, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X19, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X19, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X19, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X19, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X19, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X19, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X19, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X19, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X19, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X19, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X19, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCompare_TestFail
    MOVZ  X2, #0x47ff, LSL #0
    MOVK  X2, #0x3196, LSL #16
    MOVK  X2, #0xda43, LSL #32
    MOVK  X2, #0x9cd0, LSL #48
    MOVZ  X3, #0x3bf4, LSL #0
    MOVK  X3, #0x80ab, LSL #16
    MOVK  X3, #0x25de, LSL #32
    MOVK  X3, #0xb72b, LSL #48
    MOVZ  X4, #0xdedd, LSL #0
    MOVK  X4, #0xd627, LSL #16
    MOVK  X4, #0x3ece, LSL #32
    MOVK  X4, #0xc828, LSL #48
    MOVZ  X5, #0x8278, LSL #0
    MOVK  X5, #0x89dd, LSL #16
    MOVK  X5, #0x7972, LSL #32
    MOVK  X5, #0xe0c7, LSL #48
    MOVZ  X7, #0x11e9, LSL #0
    MOVK  X7, #0x74c0, LSL #16
    MOVK  X7, #0x7a5b, LSL #32
    MOVK  X7, #0x7156, LSL #48
    MOVZ  X9, #0x8873, LSL #0
    MOVK  X9, #0xc217, LSL #16
    MOVK  X9, #0x3bbe, LSL #32
    MOVK  X9, #0xaee7, LSL #48
    MOVZ  X10, #0x2809, LSL #0
    MOVK  X10, #0x98b2, LSL #16
    MOVK  X10, #0x69ef, LSL #32
    MOVK  X10, #0xcb80, LSL #48
    MOVZ  X11, #0x712, LSL #0
    MOVK  X11, #0x27e0, LSL #16
    MOVK  X11, #0xc059, LSL #32
    MOVK  X11, #0xa7d5, LSL #48
    MOVZ  X12, #0xe4cc, LSL #0
    MOVK  X12, #0x1957, LSL #16
    MOVK  X12, #0xbbea, LSL #32
    MOVK  X12, #0x4175, LSL #48
    MOVZ  X13, #0x4b58, LSL #0
    MOVK  X13, #0xd00b, LSL #16
    MOVK  X13, #0x7b8c, LSL #32
    MOVK  X13, #0x2990, LSL #48
    MOVZ  X14, #0x411c, LSL #0
    MOVK  X14, #0xfbc1, LSL #16
    MOVK  X14, #0xd384, LSL #32
    MOVK  X14, #0xac98, LSL #48
    MOVZ  X15, #0x5f01, LSL #0
    MOVK  X15, #0x9028, LSL #16
    MOVK  X15, #0xacdd, LSL #32
    MOVK  X15, #0x8648, LSL #48
    MOVZ  X16, #0x5803, LSL #0
    MOVK  X16, #0xa40e, LSL #16
    MOVK  X16, #0x2204, LSL #32
    MOVK  X16, #0x69c9, LSL #48
    MOVZ  X17, #0x6010, LSL #0
    MOVK  X17, #0x7f7d, LSL #16
    MOVK  X17, #0xfc8d, LSL #32
    MOVK  X17, #0xaac4, LSL #48
    MOVZ  X18, #0xf316, LSL #0
    MOVK  X18, #0xd61d, LSL #16
    MOVK  X18, #0xe580, LSL #32
    MOVK  X18, #0xd4a1, LSL #48
    MOVZ  X19, #0xef31, LSL #0
    MOVK  X19, #0xf45e, LSL #16
    MOVK  X19, #0x31ce, LSL #32
    MOVK  X19, #0xd4be, LSL #48
    MOVZ  X20, #0x83cc, LSL #0
    MOVK  X20, #0xd236, LSL #16
    MOVK  X20, #0xbce5, LSL #32
    MOVK  X20, #0xad06, LSL #48
    MOVZ  X21, #0xeb7e, LSL #0
    MOVK  X21, #0x5f1a, LSL #16
    MOVK  X21, #0x9703, LSL #32
    MOVK  X21, #0x1001, LSL #48
    MOVZ  X22, #0xa075, LSL #0
    MOVK  X22, #0x8441, LSL #16
    MOVK  X22, #0xdcf9, LSL #32
    MOVK  X22, #0xdf55, LSL #48
    MOVZ  X24, #0xef16, LSL #0
    MOVK  X24, #0xfbb6, LSL #16
    MOVK  X24, #0xe2d9, LSL #32
    MOVK  X24, #0xf123, LSL #48
    MOVZ  X26, #0x6709, LSL #0
    MOVK  X26, #0x1b88, LSL #16
    MOVK  X26, #0xba42, LSL #32
    MOVK  X26, #0xcf5e, LSL #48
    MOVZ  X27, #0x5945, LSL #0
    MOVK  X27, #0xa189, LSL #16
    MOVK  X27, #0xcf83, LSL #32
    MOVK  X27, #0x5436, LSL #48
    MOVZ  X28, #0x4158, LSL #0
    MOVK  X28, #0xd2f1, LSL #16
    MOVK  X28, #0xe818, LSL #32
    MOVK  X28, #0xcca5, LSL #48
    MOVZ  X29, #0x9635, LSL #0
    MOVK  X29, #0x33a2, LSL #16
    MOVK  X29, #0x69fe, LSL #32
    MOVK  X29, #0x714b, LSL #48
    MOVZ  X20, #0xf, LSL #0
TSRTIntCompare_label_12:
    CCMP  W24, #0xf, #0xb, CS
    CMP  X22, X14, LSR #53
    CMP  X19, #0xd05
    CMP  W13, W20, LSL #6
    CMN  W29, W26, LSL #21
    CCMP  W28, W28, #0x5, MI
    CMN  X16, X18, LSL #20
    CMN  X12, W16, UXTH #3
    CMP  W14, W20, UXTW #3
    CMN  W10, W28, LSR #2
    CCMP  X20, #0x9, #0x2, AL
    CCMN  X24, #0x15, #0xf, VS
    CMN  X11, X2, ASR #15
    CCMP  X15, #0x18, #0x1, GT
    CMP  X22, X17, UXTX #2
    CMP  X17, X4, LSL #28
    CMN  X22, #0xf9
    CMP  W20, W5, SXTW #2
    CMP  W3, W7, ASR #31
    CCMN  X15, #0x6, #0xa, GE
    CCMP  W3, #0x15, #0xb, CS
    CMP  W26, W4, ASR #3
    CMP  W15, #0x59e, LSL #12
    CCMP  X29, X11, #0x1, VC
    CMP  X26, #0x6fa, LSL #12
    CCMP  W18, #0xa, #0xe, MI
    CMN  X28, W9, SXTH #4
    CMN  W13, W19, LSR #7
    CMN  W22, W12, ASR #24
    CMP  W17, W4, UXTX #3
    CCMP  W2, W15, #0x6, EQ
    CMN  W24, W4, ASR #3
    CMN  X4, #0xa09, LSL #12
    CCMP  X24, #0x8, #0x2, VC
    CMP  X28, W7, UXTB #3
    CMP  W11, W18, LSR #17
    CMP  X16, #0x8a6, LSL #12
    CCMN  X13, X4, #0x0, VS
    CCMP  X12, #0x11, #0xa, NE
    CCMP  X5, #0x6, #0xc, NV
    CMN  X7, W9, SXTB #0
    CMP  W18, W26, SXTH #1
    CMN  W20, #0x9c0
    CCMN  W29, W4, #0x7, VS
    CCMN  X9, X11, #0xf, LS
    CMP  W26, #0xe1f, LSL #12
    CMP  W24, W2, SXTW #0
    CMN  X16, #0x629, LSL #12
    CMP  X9, X29, UXTX #0
    CMP  X29, #0xbb2
    CMN  W4, W29, SXTB #4
    CMP  W7, W10, SXTW #4
    CMP  W3, #0x733, LSL #12
    CMN  W10, W11, UXTB #3
    CMN  X4, #0x15f, LSL #12
    CMP  X18, X9, LSL #23
    CCMP  X24, X29, #0x5, GE
    CMN  W26, W5, LSR #28
    CCMN  W12, W28, #0x9, NV
    CMP  W22, #0xbe0
    CMN  X4, #0x290, LSL #12
    CMP  W13, W5, UXTH #3
    CMP  X3, #0x7f, LSL #12
    CCMN  W15, #0x14, #0x3, GT
    CMN  W19, W19, LSL #31
    CMP  W22, #0x9e9, LSL #12
    CMP  X20, #0xc6c
    CMN  W7, #0xf60
    CCMP  X2, #0x6, #0x4, PL
    CMP  X15, W17, UXTH #3
    CCMP  W4, #0x12, #0xe, PL
    CCMN  W10, W16, #0x6, AL
    CMN  W15, #0x5d9, LSL #12
    CCMP  X20, X10, #0x1, GT
    CCMP  X13, X17, #0x8, VS
    CCMP  X28, #0x1d, #0x5, NV
    CCMP  X5, #0x18, #0x9, LS
    CMN  W12, W20, SXTW #3
    CCMP  W7, #0x15, #0xd, VS
    CMN  W10, W26, UXTW #4
    CMN  W16, W11, LSL #8
    CCMP  W4, #0x1b, #0xe, LE
    CMN  W22, W7, UXTX #4
    CMP  W26, #0x77a
    CMP  W28, #0xa1c
    CMN  X12, #0xff9
    CCMP  X16, #0x12, #0xa, MI
    CCMN  X10, X2, #0xa, PL
    CMN  W11, W28, LSL #3
    CMN  W29, W20, UXTX #4
    CMN  X28, X14, SXTX #2
    CMN  W3, W26, LSL #10
    CCMN  X11, #0xf, #0x8, NV
    CMN  W13, W28, LSR #22
    CCMN  W12, #0x16, #0x5, EQ
    CMN  W24, W11, ASR #29
    CMN  X5, X16, SXTX #2
    CMP  X10, W3, UXTW #0
    CCMP  X16, #0x4, #0xf, MI
    CMN  W13, W14, UXTH #3
    CCMN  X20, #0xa, #0x9, NV
    CCMN  W10, #0x6, #0xe, GE
    CCMN  W24, W13, #0xd, LT
    CMN  W24, #0x535
    CCMP  X16, #0x1d, #0x8, AL
    CCMN  W20, W9, #0xe, GT
    CMN  X5, W11, UXTW #4
    CMP  X28, X15, ASR #25
    CMN  X9, X3, LSR #30
    CCMN  X29, #0x5, #0x0, GT
    CCMP  X15, #0x1, #0x2, VC
    CMP  W4, W15, UXTH #2
    CMN  X28, #0x363, LSL #12
    CMN  W16, W14, UXTW #1
    CCMN  X10, X14, #0x5, LT
    CMN  X24, W15, SXTH #1
    CCMN  W11, #0xc, #0xa, NV
    CCMP  X24, X14, #0x3, AL
    CMP  W28, W14, SXTX #3
    CMN  X12, X7, LSL #8
    CMN  X4, X15, ASR #4
    CMN  W14, #0x478, LSL #12
    CMN  X15, W9, UXTH #1
    CMP  X24, #0x1d9
    CMP  W16, W15, UXTX #3
    CMP  W24, W29, ASR #30
    CMP  W3, #0xe7e, LSL #12
    CMN  W20, #0x860, LSL #12
    CCMN  X26, X24, #0x4, CC
    CMN  W4, W16, UXTH #0
    CCMN  W24, W4, #0x7, AL
    CMN  X5, W14, UXTH #3
    CCMN  X24, #0x19, #0x4, PL
    CMN  X15, #0x87c, LSL #12
    CMP  X28, #0x4e8
    CMP  X26, X3, SXTX #1
    CMP  X11, X5, ASR #59
    CMN  X13, #0x5b1
    CMP  X20, X16, ASR #31
    CCMP  X13, #0x4, #0xe, CC
    CCMP  X3, #0x7, #0x1, NE
    CCMP  W26, #0x1d, #0xa, CS
    CMN  X4, W4, SXTB #4
    CCMN  X17, X11, #0xb, LT
    CCMN  W24, #0x1, #0x1, LS
    CMP  W19, #0x326
    CMN  X14, #0xbe7
    CMN  X11, X19, LSR #57
    CMP  W22, W17, UXTW #2
    CMN  W29, #0x91c, LSL #12
    CMN  W7, W16, LSR #1
    CCMP  X5, X20, #0x1, NV
    CCMN  X18, #0x15, #0xf, CS
    CCMN  W22, #0x5, #0xe, AL
    CMN  W11, W20, SXTH #4
    CMN  X19, X5, LSL #28
    CMN  W12, #0xc05, LSL #12
    CMN  X18, X14, LSL #26
    CMN  X18, W19, UXTH #0
    CMP  X14, X12, ASR #57
    CCMN  W4, W22, #0x7, HI
    CCMN  X19, #0x6, #0x9, VC
    CMN  W3, W18, SXTW #0
    CMN  X20, #0x3df, LSL #12
    CMN  W26, W26, LSL #24
    CCMN  W10, W7, #0x9, EQ
    CMP  X3, #0xcb7
    CCMP  W19, #0xb, #0xe, MI
    CMN  W26, W16, LSL #1
    CMN  X5, #0xfed, LSL #12
    CCMN  W22, #0x2, #0x0, NV
    CCMP  W16, #0x7, #0xc, VC
    CCMN  X3, #0x5, #0xd, NV
    CMN  X18, #0xe0e, LSL #12
    CMN  W3, W18, SXTW #2
    CMP  W22, W13, LSL #28
    CCMN  X15, X12, #0xa, EQ
    CMN  W22, W19, SXTH #1
    CCMN  X4, #0x16, #0x8, NV
    CCMN  W14, #0x16, #0x6, EQ
    CMN  X7, X15, LSR #59
    CMP  W2, W17, SXTB #3
    CCMN  X11, X20, #0x2, GE
    CCMP  X20, X10, #0x6, NV
    CMN  W2, #0x62d, LSL #12
    CCMN  X10, #0x14, #0xf, NV
    CCMP  W9, #0xd, #0x2, GT
    CCMP  X20, X26, #0xf, HI
    CMP  X18, X3, LSR #31
    CCMN  W18, #0x19, #0x8, VC
    CMN  W10, #0x757
    CCMN  W24, #0x10, #0x3, GT
    CMP  W22, #0x28a, LSL #12
    CMP  W20, #0x20f, LSL #12
    CMP  X9, X15, ASR #4
    CMN  W3, #0x11d, LSL #12
    CCMP  W4, #0xd, #0xc, HI
    CMP  W16, W17, LSR #31
    CCMP  W7, #0x11, #0x9, HI
    CCMP  W9, #0x0, #0x1, VC
    SUBS  X20, X20, #0x1
    B.NE  TSRTIntCompare_label_12
    MOVZ  X27, #0x47ff, LSL #0
    MOVK  X27, #0x3196, LSL #16
    MOVK  X27, #0xda43, LSL #32
    MOVK  X27, #0x9cd0, LSL #48
    SUB  X21, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X27, #0x3bf4, LSL #0
    MOVK  X27, #0x80ab, LSL #16
    MOVK  X27, #0x25de, LSL #32
    MOVK  X27, #0xb72b, LSL #48
    SUB  X21, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X27, #0xdedd, LSL #0
    MOVK  X27, #0xd627, LSL #16
    MOVK  X27, #0x3ece, LSL #32
    MOVK  X27, #0xc828, LSL #48
    SUB  X21, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X27, #0x8278, LSL #0
    MOVK  X27, #0x89dd, LSL #16
    MOVK  X27, #0x7972, LSL #32
    MOVK  X27, #0xe0c7, LSL #48
    SUB  X21, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X27, #0x11e9, LSL #0
    MOVK  X27, #0x74c0, LSL #16
    MOVK  X27, #0x7a5b, LSL #32
    MOVK  X27, #0x7156, LSL #48
    SUB  X21, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X27, #0x8873, LSL #0
    MOVK  X27, #0xc217, LSL #16
    MOVK  X27, #0x3bbe, LSL #32
    MOVK  X27, #0xaee7, LSL #48
    SUB  X21, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X27, #0x2809, LSL #0
    MOVK  X27, #0x98b2, LSL #16
    MOVK  X27, #0x69ef, LSL #32
    MOVK  X27, #0xcb80, LSL #48
    SUB  X21, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X27, #0x712, LSL #0
    MOVK  X27, #0x27e0, LSL #16
    MOVK  X27, #0xc059, LSL #32
    MOVK  X27, #0xa7d5, LSL #48
    SUB  X21, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X27, #0xe4cc, LSL #0
    MOVK  X27, #0x1957, LSL #16
    MOVK  X27, #0xbbea, LSL #32
    MOVK  X27, #0x4175, LSL #48
    SUB  X21, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X27, #0x4b58, LSL #0
    MOVK  X27, #0xd00b, LSL #16
    MOVK  X27, #0x7b8c, LSL #32
    MOVK  X27, #0x2990, LSL #48
    SUB  X21, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X27, #0x411c, LSL #0
    MOVK  X27, #0xfbc1, LSL #16
    MOVK  X27, #0xd384, LSL #32
    MOVK  X27, #0xac98, LSL #48
    SUB  X21, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X27, #0x5f01, LSL #0
    MOVK  X27, #0x9028, LSL #16
    MOVK  X27, #0xacdd, LSL #32
    MOVK  X27, #0x8648, LSL #48
    SUB  X21, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X27, #0x5803, LSL #0
    MOVK  X27, #0xa40e, LSL #16
    MOVK  X27, #0x2204, LSL #32
    MOVK  X27, #0x69c9, LSL #48
    SUB  X21, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X27, #0x6010, LSL #0
    MOVK  X27, #0x7f7d, LSL #16
    MOVK  X27, #0xfc8d, LSL #32
    MOVK  X27, #0xaac4, LSL #48
    SUB  X21, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X27, #0xf316, LSL #0
    MOVK  X27, #0xd61d, LSL #16
    MOVK  X27, #0xe580, LSL #32
    MOVK  X27, #0xd4a1, LSL #48
    SUB  X21, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X27, #0xef31, LSL #0
    MOVK  X27, #0xf45e, LSL #16
    MOVK  X27, #0x31ce, LSL #32
    MOVK  X27, #0xd4be, LSL #48
    SUB  X21, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X21, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X27, #0xa075, LSL #0
    MOVK  X27, #0x8441, LSL #16
    MOVK  X27, #0xdcf9, LSL #32
    MOVK  X27, #0xdf55, LSL #48
    SUB  X21, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X27, #0xef16, LSL #0
    MOVK  X27, #0xfbb6, LSL #16
    MOVK  X27, #0xe2d9, LSL #32
    MOVK  X27, #0xf123, LSL #48
    SUB  X21, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X27, #0x6709, LSL #0
    MOVK  X27, #0x1b88, LSL #16
    MOVK  X27, #0xba42, LSL #32
    MOVK  X27, #0xcf5e, LSL #48
    SUB  X21, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X27, #0x4158, LSL #0
    MOVK  X27, #0xd2f1, LSL #16
    MOVK  X27, #0xe818, LSL #32
    MOVK  X27, #0xcca5, LSL #48
    SUB  X21, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X27, #0x9635, LSL #0
    MOVK  X27, #0x33a2, LSL #16
    MOVK  X27, #0x69fe, LSL #32
    MOVK  X27, #0x714b, LSL #48
    SUB  X21, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X18, #0xf, LSL #0
TSRTIntCompare_label_13:
    CMP  W11, #0x187
    CCMN  X13, #0x14, #0xc, HI
    CMN  X14, #0x6
    CMP  W24, W27, LSL #4
    CMN  W20, #0x16
    CMN  W17, W16, UXTX #0
    CMP  X29, X12, ASR #22
    CCMN  W10, #0xa, #0xb, GE
    CCMP  W18, #0x0, #0x4, NV
    CCMN  W22, #0x11, #0xd, MI
    CMN  W19, W19, LSR #29
    CCMP  X21, #0x3, #0x7, EQ
    CMP  X26, #0xaa3, LSL #12
    CMP  W15, W3, UXTH #2
    CMP  W7, W17, ASR #15
    CMP  W24, #0x362
    CCMP  W12, #0x10, #0x9, AL
    CMN  W26, #0x588, LSL #12
    CMN  W19, W16, LSR #19
    CMP  X29, X12, SXTX #3
    CCMP  W13, #0xc, #0xa, MI
    CCMN  W16, W29, #0xa, LS
    CCMN  X18, #0xd, #0xf, EQ
    CMN  X7, #0xecc, LSL #12
    CMP  X19, X2, ASR #44
    CMP  W29, W3, UXTB #3
    CMN  X4, X12, ASR #27
    CCMP  W3, #0xc, #0x3, LS
    CMP  W11, #0x5cb
    CMP  W5, W20, ASR #29
    CMP  X29, #0xd70
    CMP  W27, #0x1ca
    CMN  W19, #0xf9c
    CCMP  W13, W14, #0x2, VS
    CMN  W27, #0xbcd, LSL #12
    CMN  X10, #0x689
    CMP  X14, #0xf99, LSL #12
    CCMP  X7, X15, #0x5, AL
    CMN  W10, W7, LSR #18
    CMN  X22, X29, LSL #30
    CCMP  W11, W7, #0x7, VS
    CMP  W14, W4, UXTX #2
    CCMN  W29, #0x9, #0xb, LE
    CMN  X21, #0xe6, LSL #12
    CCMN  X13, X18, #0x7, VS
    CMN  W18, W7, SXTW #3
    CMN  X17, W5, UXTW #4
    CMP  X18, X4, LSL #13
    CCMN  X7, X4, #0x0, GT
    CMP  W18, W16, LSL #7
    CCMP  X10, X11, #0x0, VC
    CMP  W18, W24, LSL #12
    CCMN  X20, #0x13, #0x4, GE
    CMP  W5, #0xb00
    CCMP  W3, W7, #0x1, AL
    CMN  W19, W10, SXTH #0
    CCMP  W7, #0xb, #0x9, MI
    CMP  X2, W12, SXTW #0
    CCMP  X5, X20, #0x1, AL
    CMP  W16, W26, UXTX #2
    CMP  W24, #0xffd
    CCMN  X4, X12, #0x4, PL
    CMP  W15, W17, SXTB #1
    CCMP  W14, W24, #0x4, NE
    CMN  W5, #0xe9, LSL #12
    CMN  W7, W26, SXTW #3
    CMN  W2, #0x628, LSL #12
    CCMP  X4, X7, #0x7, GE
    CMN  X10, W17, UXTB #2
    CCMN  W16, W26, #0xe, GE
    CMP  X19, W29, UXTB #2
    CCMN  W29, #0x16, #0xe, VS
    CCMN  X26, X11, #0xf, VC
    CMP  W12, W2, UXTW #4
    CMN  X14, #0xc57, LSL #12
    CMN  X10, #0x65f, LSL #12
    CCMN  X22, #0x9, #0xa, LS
    CMP  W26, W16, LSR #24
    CCMN  W26, W21, #0xc, AL
    CMN  X11, #0xc9d, LSL #12
    CMP  W19, W10, SXTB #0
    CCMP  X20, #0xe, #0x4, NE
    CCMN  X10, X3, #0xc, EQ
    CMP  X19, X21, ASR #10
    CMP  W18, W16, SXTW #1
    CCMN  W16, W27, #0xb, NE
    CCMP  X11, #0x1, #0x1, CC
    CCMP  X18, X20, #0xa, VS
    CMP  X2, W17, SXTB #4
    CMN  X16, W12, UXTB #3
    CCMN  X7, #0x1b, #0xa, LE
    CMP  X21, X26, LSR #28
    CMP  X10, X3, ASR #26
    CMP  W7, W17, UXTX #3
    CCMP  W17, #0x2, #0xe, CS
    CMN  X29, X16, LSL #49
    CMP  W21, W27, UXTW #4
    CMP  W21, #0x936, LSL #12
    CMP  X14, #0x8ea, LSL #12
    CMN  W17, W10, UXTH #1
    CMN  W15, W15, LSR #12
    CMP  W11, W10, LSL #28
    CMP  X13, X4, UXTX #2
    CMN  X15, X10, LSL #19
    CMN  X22, #0xeee, LSL #12
    CCMN  X27, X15, #0xe, NV
    CCMN  W27, #0x1a, #0x9, NE
    CCMN  X7, #0xb, #0xf, LE
    CMP  W24, W11, LSL #4
    CMN  W2, W3, LSR #6
    CMP  W26, #0x89d, LSL #12
    CMP  X24, #0x69
    CCMN  W17, W4, #0x7, LS
    CMN  X7, #0xc9b, LSL #12
    CMP  W12, W7, LSL #25
    CCMP  W27, W24, #0x8, MI
    CMN  W10, W4, UXTW #0
    CCMN  W19, #0x6, #0x5, MI
    CCMN  W22, W4, #0x4, AL
    CMP  W7, W17, SXTB #3
    CMN  W11, W26, LSR #29
    CCMP  X21, X16, #0xb, HI
    CMN  X3, X26, SXTX #4
    CCMN  W3, #0x7, #0x4, GE
    CCMN  W2, W21, #0x6, MI
    CMN  X7, W15, SXTW #1
    CCMN  W14, W15, #0x9, AL
    CCMP  X3, X12, #0x2, CC
    CCMN  X15, X27, #0x4, MI
    CMN  W10, W5, ASR #7
    CCMP  W12, W18, #0xb, VC
    CMN  W19, #0x233
    CCMN  W27, #0x17, #0x9, NV
    CMP  X17, #0x238
    CMN  W4, #0x9f7, LSL #12
    CMP  X24, #0x212
    CMP  X18, W15, UXTB #2
    CMP  X17, X24, LSR #11
    CCMP  X17, #0x1d, #0x8, VC
    CCMP  W3, W4, #0x7, AL
    CMN  W16, W20, SXTX #1
    CCMP  W18, #0x8, #0x1, CC
    CMN  W12, #0x5d8, LSL #12
    CCMN  W22, #0x14, #0xb, NE
    CCMP  W19, #0x4, #0x3, LT
    CMP  W24, #0xbdc, LSL #12
    CMP  W24, #0xb83, LSL #12
    CCMN  X5, X17, #0x0, LS
    CMP  W20, W3, SXTW #1
    CCMN  X7, X12, #0x5, GT
    CCMP  W19, #0x3, #0xa, LE
    CMP  X19, X5, UXTX #4
    CCMP  W21, W10, #0x9, AL
    CMN  X5, X16, UXTX #0
    CMN  W10, W15, SXTX #3
    CMN  X16, X7, ASR #17
    CMP  X5, X3, ASR #22
    CMN  W5, W15, LSL #10
    CMN  W17, W13, LSR #27
    CMP  X4, X11, SXTX #2
    CMP  W17, W3, UXTX #2
    CCMN  X2, #0x3, #0xc, GT
    CMP  W11, W13, SXTB #2
    CMN  X10, #0xd55, LSL #12
    CCMP  W17, #0x1d, #0xe, CC
    CMP  X17, X18, ASR #23
    CMN  X10, X24, LSL #18
    CMN  X15, X22, ASR #16
    CCMP  W18, W3, #0x9, CC
    CCMP  W22, W3, #0x1, LE
    CCMP  W20, W19, #0x9, VC
    CMN  X26, X22, SXTX #3
    CCMP  X18, #0x1c, #0x6, LS
    CCMN  X11, #0x11, #0xe, CC
    CCMP  X21, #0xb, #0x5, HI
    CMN  W13, #0xfe6, LSL #12
    CMP  X2, X11, LSL #61
    CMN  W22, #0xb82
    CMN  X13, X16, SXTX #4
    CCMP  W14, #0x4, #0xd, LE
    CMN  W4, #0x19d, LSL #12
    CCMN  W21, W26, #0xa, MI
    CMN  X10, X11, LSL #46
    CMP  W15, W4, UXTX #2
    CMP  W27, W14, LSR #20
    CMP  X20, #0x4e4
    CMP  W13, #0x931
    CCMN  W15, W22, #0xa, AL
    CCMN  X17, #0x1f, #0x4, CS
    CMP  W10, #0xd97
    CMP  X16, #0x814
    CCMN  W14, W3, #0xe, LT
    CMP  W4, #0x564, LSL #12
    CCMN  X12, #0x14, #0xf, HI
    CMP  X22, X10, LSR #28
    CMP  X22, #0x7ef
    CCMP  W29, #0x1a, #0x0, GE
    CCMN  W19, #0xe, #0x0, GE
    CMP  X12, X12, ASR #13
    CMN  X21, X26, LSL #19
    SUBS  X18, X18, #0x1
    B.NE  TSRTIntCompare_label_13
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCompare_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
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
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
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
    MOVZ  X20, #0xf, LSL #0
TSRTIntCompare_label_14:
    CMP  X24, X28, LSR #50
    CMN  W26, #0x391
    CMP  X27, X27, ASR #32
    CCMP  X29, #0x2, #0x3, GE
    CMN  X20, W20, SXTH #2
    CCMN  X14, X22, #0xd, NV
    CMP  W21, #0x283, LSL #12
    CMP  X4, W10, UXTW #2
    CMN  X7, W11, SXTW #2
    CCMN  W20, #0x16, #0xd, LT
    CMN  X10, X12, LSL #47
    CCMP  X5, #0x8, #0x9, PL
    CCMP  W20, W27, #0x4, CC
    CMN  X10, #0x1e6, LSL #12
    CCMP  X20, #0x0, #0x6, CC
    CMP  X10, X16, SXTX #0
    CMP  W15, #0xa7c
    CMN  X13, X11, LSL #47
    CCMP  X3, #0x18, #0x8, HI
    CCMP  X19, X21, #0x2, GE
    CCMP  W24, W16, #0x4, CS
    CMP  X5, X27, ASR #61
    CMN  X27, #0x894, LSL #12
    CCMP  W16, W27, #0x5, MI
    CCMN  W3, #0x2, #0x2, MI
    CMN  X3, #0xe11, LSL #12
    CMP  W5, #0x9ec
    CCMP  X11, #0xe, #0x5, GE
    CMP  X14, X21, LSL #32
    CMP  W12, #0x64b, LSL #12
    CMN  X13, W11, UXTW #4
    CCMP  W13, W28, #0xb, VC
    CCMN  W7, W11, #0xc, AL
    CMP  W12, #0x1be
    CCMP  X22, #0x1f, #0x5, LE
    CCMN  W4, #0x1a, #0x1, NE
    CMP  W3, #0x7eb
    CCMN  W11, #0xe, #0x9, NV
    CMP  W2, #0xb9, LSL #12
    CCMP  X20, #0xb, #0x9, NE
    CCMN  X14, #0x0, #0x3, NV
    CMN  W20, #0x14c
    CMN  W21, W15, UXTX #1
    CMN  X5, W20, UXTW #1
    CCMN  W22, #0x1, #0x0, PL
    CCMP  X7, X4, #0x8, LE
    CCMP  W21, W28, #0x8, VS
    CMP  X29, #0x492
    CCMP  W2, #0x19, #0xc, LS
    CMN  W21, W10, SXTX #2
    CMP  W13, W20, SXTB #4
    CMP  X12, #0x227
    CCMN  W28, W28, #0x9, EQ
    CMN  W2, #0x9a2
    CMN  X15, X27, ASR #59
    CMN  W21, W16, LSR #1
    CCMP  W29, W13, #0xc, CS
    CCMP  W2, W28, #0x9, NE
    CCMP  X20, X4, #0x1, CS
    CCMN  W16, W22, #0xc, NV
    CCMP  W12, W13, #0xa, EQ
    CMP  W2, #0xb74, LSL #12
    CCMP  X16, X28, #0x0, CC
    CCMP  W11, #0x1, #0xf, VS
    CCMN  W13, W12, #0x6, LS
    CMN  W7, #0x879
    CCMP  W21, W14, #0xb, LT
    CMN  X3, X27, ASR #28
    CCMN  X29, #0x17, #0x1, PL
    CMN  X2, X27, LSL #10
    CMP  X28, #0x37d, LSL #12
    CMP  W14, W12, ASR #20
    CCMP  X11, #0x10, #0xc, GE
    CCMP  W29, #0x5, #0x9, AL
    CMN  X27, W2, SXTB #4
    CMP  X12, X10, LSL #47
    CMP  W4, W14, ASR #26
    CCMP  X2, #0x18, #0xf, GT
    CMP  X28, X13, ASR #3
    CMP  W27, W14, ASR #9
    CMP  X21, W4, SXTB #4
    CMP  W28, W11, ASR #12
    CMP  W16, #0x5cb
    CCMP  X28, #0x9, #0x9, NV
    CMN  X20, X20, LSR #36
    CMN  X20, #0xa59, LSL #12
    CMN  X12, W9, UXTW #1
    CCMN  W29, W22, #0xf, VS
    CMP  X2, W27, SXTB #2
    CMP  X22, W3, SXTW #1
    CMP  X12, #0x8d8
    CMP  W21, W26, LSR #3
    CMP  X13, #0x825
    CMP  X3, #0x58, LSL #12
    CCMP  X26, X4, #0x8, VS
    CCMN  W27, W22, #0xc, LE
    CMP  W12, W5, LSR #11
    CCMN  W22, W10, #0x4, LT
    CCMN  W16, W14, #0x4, GE
    CMP  X29, W29, UXTW #4
    CMP  X27, #0x7bc
    CCMN  X14, #0x6, #0xb, EQ
    CMP  W20, W13, LSR #4
    CMN  W19, W14, SXTX #1
    CMN  W28, #0xb28, LSL #12
    CCMN  W26, #0x17, #0x2, VC
    CMP  W16, W28, LSL #11
    CCMN  X2, #0x1b, #0xa, MI
    CMP  X13, #0xaa6
    CMN  X28, W13, SXTW #1
    CMN  W26, W2, ASR #10
    CCMN  W2, W26, #0x1, EQ
    CCMP  W3, #0x17, #0xa, GE
    CCMN  X2, #0x14, #0xd, VC
    CMN  X24, #0x938
    CCMP  W19, W15, #0xc, HI
    CMP  X4, X16, LSR #0
    CCMN  W21, #0x15, #0x7, HI
    CMN  W16, W10, SXTX #2
    CMN  X27, X11, LSL #20
    CCMN  W28, W2, #0x6, VS
    CMP  X10, #0xa7a
    CCMP  W24, #0x4, #0xd, NV
    CMN  X14, X28, SXTX #4
    CMN  X26, X9, ASR #57
    CMN  X10, #0xb29, LSL #12
    CMN  W2, W20, LSR #29
    CMP  X12, #0x5c1
    CCMN  W7, #0x1f, #0x7, VC
    CCMP  W12, W3, #0x7, GE
    CCMP  W26, W27, #0x9, LE
    CCMP  X28, X16, #0x1, NV
    CMN  X26, W12, UXTH #2
    CCMP  W20, W24, #0xe, VS
    CMP  W9, W14, LSR #28
    CCMN  W29, #0x19, #0x9, CS
    CCMN  X15, #0x1d, #0x9, PL
    CCMN  X29, X14, #0x8, NV
    CMP  W22, W5, LSR #15
    CMP  W14, W5, SXTH #1
    CMN  X11, X3, LSL #27
    CCMP  X14, X7, #0xa, VC
    CCMN  X16, #0x1b, #0xf, MI
    CMN  W2, W15, LSR #10
    CCMN  W24, #0x1f, #0x2, GE
    CCMP  W19, #0x3, #0x2, MI
    CMN  X21, W16, UXTW #1
    CMN  X26, X27, LSR #1
    CCMP  W13, W28, #0x1, VC
    CCMP  X12, #0x5, #0xc, LS
    CCMP  W22, #0x1f, #0x7, GT
    CMN  X10, X9, LSL #50
    CMN  W11, W11, UXTX #3
    CMN  W4, W12, UXTX #2
    CMN  X14, W28, UXTB #4
    CCMP  W15, W29, #0x2, MI
    CMN  W15, #0x33, LSL #12
    CMP  W26, #0x96, LSL #12
    CCMN  X2, X7, #0x1, GT
    CMN  W13, #0xbe0
    CCMN  X21, X9, #0x0, CC
    CMP  W4, #0x339
    CMN  W12, W21, ASR #0
    CMP  W4, W10, ASR #14
    CMP  X26, W13, SXTH #0
    CCMN  X3, X15, #0x9, CC
    CCMP  W16, #0x1a, #0xc, LE
    CMN  W20, W28, ASR #8
    CMP  X10, W27, SXTH #3
    CCMN  W27, #0x6, #0xc, NE
    CCMP  X3, X2, #0x1, NV
    CMN  W27, W26, UXTW #0
    CMN  W20, W7, LSR #7
    CMP  X4, #0xd46, LSL #12
    CMN  W28, #0x578, LSL #12
    CCMP  X22, #0x11, #0xf, HI
    CMN  W28, #0x6f7
    CCMP  X28, #0x6, #0x2, VC
    CMP  X26, X7, UXTX #0
    CMN  X12, #0xdef
    CCMP  W21, #0x12, #0x3, VS
    CMP  X27, W27, UXTW #1
    CMP  X10, #0x6b6
    CCMP  X10, X2, #0x7, HI
    CCMP  W4, W29, #0xa, PL
    CCMP  X27, X11, #0xe, NV
    CCMP  X27, X19, #0x3, LE
    CMN  W7, W22, LSL #29
    CMN  X10, X4, LSL #27
    CMN  X15, X22, LSR #19
    CMP  X13, W29, SXTW #0
    CCMN  X24, X26, #0x4, LT
    CMP  X4, W27, UXTW #4
    CCMN  W24, #0x1f, #0x2, LT
    CMP  X28, X11, ASR #12
    CMP  W13, W10, LSL #23
    CCMN  W4, #0x15, #0x6, NE
    CCMN  X4, X29, #0x3, NE
    CMP  X13, X2, LSL #33
    CCMN  X12, X9, #0xd, CC
    SUBS  X20, X20, #0x1
    B.NE  TSRTIntCompare_label_14
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X17, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X17, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X17, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X17, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X17, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X17, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X17, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X17, X18, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X17, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X17, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X17, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X17, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X17, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X17, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X17, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X17, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X17, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X17, X18, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X17, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X17, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X2, #0xf6dd, LSL #0
    MOVK  X2, #0xd60f, LSL #16
    MOVK  X2, #0x8daf, LSL #32
    MOVK  X2, #0xda79, LSL #48
    MOVZ  X3, #0xc26c, LSL #0
    MOVK  X3, #0xba70, LSL #16
    MOVK  X3, #0x6f73, LSL #32
    MOVK  X3, #0xc413, LSL #48
    MOVZ  X4, #0xe958, LSL #0
    MOVK  X4, #0x5b8c, LSL #16
    MOVK  X4, #0xae27, LSL #32
    MOVK  X4, #0x6357, LSL #48
    MOVZ  X5, #0xff11, LSL #0
    MOVK  X5, #0x6948, LSL #16
    MOVK  X5, #0x8e66, LSL #32
    MOVK  X5, #0x8470, LSL #48
    MOVZ  X7, #0x9336, LSL #0
    MOVK  X7, #0x2c, LSL #16
    MOVK  X7, #0xfc6, LSL #32
    MOVK  X7, #0x3a97, LSL #48
    MOVZ  X9, #0x58cd, LSL #0
    MOVK  X9, #0x24f4, LSL #16
    MOVK  X9, #0x444, LSL #32
    MOVK  X9, #0xef29, LSL #48
    MOVZ  X10, #0x9681, LSL #0
    MOVK  X10, #0x8d51, LSL #16
    MOVK  X10, #0x391, LSL #32
    MOVK  X10, #0xe3a1, LSL #48
    MOVZ  X11, #0x3289, LSL #0
    MOVK  X11, #0x4b3b, LSL #16
    MOVK  X11, #0xcda5, LSL #32
    MOVK  X11, #0x3176, LSL #48
    MOVZ  X12, #0x8b73, LSL #0
    MOVK  X12, #0x816a, LSL #16
    MOVK  X12, #0x63bd, LSL #32
    MOVK  X12, #0xc745, LSL #48
    MOVZ  X13, #0x5435, LSL #0
    MOVK  X13, #0x3261, LSL #16
    MOVK  X13, #0x5d64, LSL #32
    MOVK  X13, #0x5ff7, LSL #48
    MOVZ  X14, #0xf1f6, LSL #0
    MOVK  X14, #0xa56b, LSL #16
    MOVK  X14, #0x2ac6, LSL #32
    MOVK  X14, #0x257d, LSL #48
    MOVZ  X15, #0xe8b1, LSL #0
    MOVK  X15, #0xaa57, LSL #16
    MOVK  X15, #0x9af0, LSL #32
    MOVK  X15, #0xba66, LSL #48
    MOVZ  X16, #0xc3b1, LSL #0
    MOVK  X16, #0x6bdf, LSL #16
    MOVK  X16, #0x4e27, LSL #32
    MOVK  X16, #0x2367, LSL #48
    MOVZ  X17, #0x17e4, LSL #0
    MOVK  X17, #0x8036, LSL #16
    MOVK  X17, #0xe3bc, LSL #32
    MOVK  X17, #0xffd1, LSL #48
    MOVZ  X18, #0x7fdc, LSL #0
    MOVK  X18, #0x7069, LSL #16
    MOVK  X18, #0x856a, LSL #32
    MOVK  X18, #0x29b2, LSL #48
    MOVZ  X19, #0x5a65, LSL #0
    MOVK  X19, #0x1014, LSL #16
    MOVK  X19, #0x9fe8, LSL #32
    MOVK  X19, #0x3e77, LSL #48
    MOVZ  X20, #0x7b9f, LSL #0
    MOVK  X20, #0x818c, LSL #16
    MOVK  X20, #0x559c, LSL #32
    MOVK  X20, #0xc37, LSL #48
    MOVZ  X21, #0x5f6b, LSL #0
    MOVK  X21, #0x9101, LSL #16
    MOVK  X21, #0x33bb, LSL #32
    MOVK  X21, #0x1e88, LSL #48
    MOVZ  X22, #0x2788, LSL #0
    MOVK  X22, #0x3366, LSL #16
    MOVK  X22, #0xeee7, LSL #32
    MOVK  X22, #0x74f5, LSL #48
    MOVZ  X24, #0xdef5, LSL #0
    MOVK  X24, #0x3b4e, LSL #16
    MOVK  X24, #0xb2b5, LSL #32
    MOVK  X24, #0x663f, LSL #48
    MOVZ  X26, #0xda9c, LSL #0
    MOVK  X26, #0x261, LSL #16
    MOVK  X26, #0x3937, LSL #32
    MOVK  X26, #0x350b, LSL #48
    MOVZ  X27, #0x938e, LSL #0
    MOVK  X27, #0xe3d8, LSL #16
    MOVK  X27, #0xb88d, LSL #32
    MOVK  X27, #0xeb85, LSL #48
    MOVZ  X28, #0xe4b2, LSL #0
    MOVK  X28, #0xfdaf, LSL #16
    MOVK  X28, #0x826f, LSL #32
    MOVK  X28, #0xec8b, LSL #48
    MOVZ  X29, #0xa399, LSL #0
    MOVK  X29, #0xd11, LSL #16
    MOVK  X29, #0xda43, LSL #32
    MOVK  X29, #0xd1ef, LSL #48
    MOVZ  X28, #0xf, LSL #0
TSRTIntCompare_label_15:
    CMN  W9, W29, UXTB #1
    CMN  W24, #0xf5
    CMP  W28, #0xc1b, LSL #12
    CMN  W21, W26, UXTW #3
    CMP  W5, #0xbe3
    CMN  W22, W22, SXTH #0
    CCMP  W26, #0x19, #0x7, AL
    CMP  X11, X29, ASR #24
    CMP  W18, W18, SXTX #4
    CMN  W17, W13, UXTH #1
    CMP  X21, #0xba8, LSL #12
    CMP  W19, W16, SXTW #4
    CCMP  X9, X7, #0x5, PL
    CMP  X21, W9, SXTH #3
    CCMP  W28, #0x16, #0x3, GE
    CMN  X29, X28, SXTX #3
    CMN  X13, #0xe84, LSL #12
    CMP  X13, X16, LSL #2
    CCMN  W10, #0x1a, #0x7, VS
    CMP  X13, #0xefa
    CMN  W24, #0x719
    CMN  W26, #0x3bb, LSL #12
    CMN  W3, W28, ASR #13
    CMP  W19, W7, SXTX #0
    CCMP  X4, X29, #0x6, CC
    CMN  W11, W11, UXTX #4
    CMP  W24, W18, LSL #27
    CCMP  X18, #0x1a, #0xe, VC
    CCMP  W4, #0xe, #0xd, NE
    CCMN  W13, #0x19, #0x2, NV
    CCMN  W3, W3, #0xd, CC
    CCMN  W11, #0x19, #0xb, GT
    CMP  W10, W14, ASR #3
    CMP  X13, X3, LSL #45
    CMN  X13, X5, LSL #61
    CMN  X2, X21, ASR #55
    CCMP  W13, #0x18, #0xc, MI
    CMP  X28, W9, SXTH #1
    CCMN  X17, #0xc, #0xe, VC
    CMP  X15, #0xbd8, LSL #12
    CMP  X21, X20, ASR #41
    CMN  W10, W24, LSL #4
    CCMP  X10, X20, #0x0, CS
    CCMN  X29, #0xe, #0x8, VS
    CMN  X22, X14, ASR #61
    CCMN  W11, #0x1a, #0xb, CC
    CMN  X9, #0xa0e
    CMP  W11, W24, UXTH #4
    CMP  X26, W20, UXTH #0
    CMN  W19, W10, UXTX #3
    CMP  W24, W16, LSR #3
    CMN  W28, W3, LSR #6
    CMN  X10, #0x61c, LSL #12
    CMN  X5, W10, UXTB #1
    CMN  W20, W18, LSL #2
    CMN  X17, X2, ASR #8
    CMN  W15, W29, SXTW #4
    CCMP  X28, X20, #0xf, CC
    CMN  W17, W24, ASR #10
    CMP  W19, W14, SXTW #2
    CMN  W29, W24, UXTH #2
    CMP  X9, X14, LSL #56
    CMN  W24, W9, LSR #16
    CCMN  W9, #0x9, #0xc, LE
    CMN  W10, W16, UXTX #2
    CMN  W29, W17, LSL #6
    CCMP  X22, X9, #0x6, LS
    CCMP  W10, W3, #0x0, MI
    CMP  W2, W21, LSL #2
    CMN  W4, #0xdbe, LSL #12
    CMP  X10, #0xe8f
    CMN  W16, #0x47a, LSL #12
    CCMP  W17, #0xa, #0x9, NV
    CMN  X13, X5, ASR #58
    CCMP  W16, #0x19, #0xd, LT
    CMN  X29, W29, UXTW #0
    CMP  W11, W16, ASR #15
    CMN  W7, W16, SXTX #1
    CMP  W16, W13, ASR #25
    CCMP  W11, #0xd, #0x2, VC
    CMN  W13, #0xc0f, LSL #12
    CCMN  X5, #0x1b, #0x8, GE
    CCMN  X16, X24, #0xf, LT
    CMN  X7, X16, LSL #43
    CMN  X13, W10, UXTB #1
    CCMP  X10, X3, #0x2, PL
    CMP  W28, #0x18f
    CCMP  W5, W16, #0xa, CS
    CMP  W10, W26, LSR #0
    CCMP  X16, X24, #0x0, CC
    CCMN  X20, #0x17, #0xf, MI
    CMN  X22, W4, UXTW #1
    CCMN  W15, #0x12, #0x2, NV
    CCMP  W4, #0x0, #0xd, CC
    CCMN  W15, W28, #0xe, EQ
    CCMN  W9, #0x19, #0x6, LE
    CMP  W18, W29, LSL #21
    CMP  X24, W7, UXTH #3
    CMP  X3, X7, LSL #48
    CMN  W5, W18, SXTB #3
    CCMP  X24, X15, #0x1, VS
    CCMP  X10, #0x13, #0xa, LT
    CMP  X26, X18, LSR #55
    CCMN  X28, #0x9, #0x7, PL
    CCMN  W17, W16, #0x8, NE
    CCMP  W29, W24, #0xf, LE
    CMP  W22, W11, LSL #15
    CCMN  W3, W20, #0x8, VC
    CCMP  W16, W20, #0x1, LE
    CCMN  X14, X28, #0x2, LS
    CCMN  X20, X28, #0xd, HI
    CMN  X16, X18, UXTX #2
    CCMN  X24, X28, #0xc, GT
    CCMP  W16, #0x12, #0xe, EQ
    CCMN  X11, X21, #0x5, HI
    CMN  X3, X2, ASR #47
    CMP  X7, #0x8c8
    CCMP  X29, X9, #0x7, VC
    CMN  W28, W9, ASR #13
    CCMN  X3, #0x0, #0x2, HI
    CCMN  X2, X10, #0x6, CC
    CCMN  W14, W19, #0xa, AL
    CMP  W4, W5, LSL #5
    CCMN  W17, #0x17, #0xf, LE
    CCMP  X11, X29, #0xe, NV
    CCMN  X18, #0xb, #0xe, PL
    CMN  W21, W9, LSR #4
    CCMN  W17, W18, #0xa, AL
    CCMN  W26, #0x1b, #0xc, VC
    CMN  X4, X21, SXTX #3
    CCMP  X9, #0x1b, #0xb, GT
    CCMN  X11, #0x17, #0x4, EQ
    CMN  W28, #0xa78
    CCMN  W5, #0xa, #0xc, AL
    CMP  X24, W28, UXTH #1
    CMN  W26, #0xa75
    CMP  X4, X18, LSR #53
    CMN  X18, W18, UXTW #0
    CCMN  W29, #0x11, #0xf, LE
    CCMN  W21, #0xa, #0xa, VC
    CCMN  X13, X19, #0x6, MI
    CMN  X24, X19, LSL #41
    CCMN  W5, #0x1c, #0x9, GT
    CMN  W29, W15, UXTW #1
    CMP  W14, W11, LSR #19
    CMP  X21, X4, LSL #11
    CMP  W9, W4, SXTW #0
    CMP  W13, #0x334
    CCMN  X16, X7, #0xa, VS
    CMN  W5, W2, SXTW #3
    CMN  X20, X2, SXTX #4
    CMN  X10, X11, SXTX #1
    CMP  W24, #0x63
    CMN  W14, W16, LSR #0
    CMP  X26, X18, LSR #30
    CCMN  X7, X17, #0xc, AL
    CCMP  W3, #0x7, #0xe, HI
    CMN  X4, #0x4a, LSL #12
    CMN  W21, #0x7ad, LSL #12
    CMP  W10, W3, SXTW #1
    CMN  X22, #0xd6c, LSL #12
    CMN  X4, W18, SXTB #2
    CMP  X13, W17, UXTH #3
    CCMN  X7, X4, #0xd, AL
    CMN  X20, #0xb2f
    CMP  W10, W2, LSL #13
    CCMP  X21, #0x17, #0x0, EQ
    CMP  W21, W28
    CCMP  W5, #0x3, #0xe, VS
    CCMP  X7, #0xe, #0x4, VS
    CCMP  X10, #0x9, #0x4, GT
    CCMN  W20, W5, #0x4, MI
    CCMN  W16, W5, #0xb, PL
    CCMN  X19, #0x1, #0x3, LS
    CCMP  X17, X3, #0x7, LT
    CCMP  W7, #0x15, #0xc, NE
    CMP  W3, #0x1e0, LSL #12
    CMN  X22, X7, LSL #56
    CMP  X18, X18, ASR #36
    CMP  W19, W26, LSR #20
    CMN  X3, X7, LSR #26
    CMN  X9, X5, LSR #20
    CCMN  X20, #0x15, #0xa, VS
    CMP  X24, X18, UXTX #1
    CMN  W15, W18, SXTX #0
    CMP  W20, W19, LSR #15
    CCMN  W21, W3, #0x6, NV
    CMN  W21, W15, SXTH #0
    CCMP  W2, #0xa, #0xb, CC
    CCMN  X26, #0xe, #0x6, GE
    CCMP  W17, W9, #0xa, CC
    CMN  W11, W7, SXTH #3
    CMP  W4, #0x209
    CMN  X15, #0x20e, LSL #12
    CCMN  X18, X28, #0x5, CC
    CCMP  X20, #0x0, #0xb, CS
    CMP  X7, X5, ASR #1
    CCMN  X24, X14, #0xe, CS
    CMN  X19, #0x859, LSL #12
    CMN  W9, #0x88d, LSL #12
    SUBS  X28, X28, #0x1
    B.NE  TSRTIntCompare_label_15
    MOVZ  X27, #0xf6dd, LSL #0
    MOVK  X27, #0xd60f, LSL #16
    MOVK  X27, #0x8daf, LSL #32
    MOVK  X27, #0xda79, LSL #48
    SUB  X12, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X27, #0xc26c, LSL #0
    MOVK  X27, #0xba70, LSL #16
    MOVK  X27, #0x6f73, LSL #32
    MOVK  X27, #0xc413, LSL #48
    SUB  X12, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X27, #0xe958, LSL #0
    MOVK  X27, #0x5b8c, LSL #16
    MOVK  X27, #0xae27, LSL #32
    MOVK  X27, #0x6357, LSL #48
    SUB  X12, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X27, #0xff11, LSL #0
    MOVK  X27, #0x6948, LSL #16
    MOVK  X27, #0x8e66, LSL #32
    MOVK  X27, #0x8470, LSL #48
    SUB  X12, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X27, #0x9336, LSL #0
    MOVK  X27, #0x2c, LSL #16
    MOVK  X27, #0xfc6, LSL #32
    MOVK  X27, #0x3a97, LSL #48
    SUB  X12, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X27, #0x58cd, LSL #0
    MOVK  X27, #0x24f4, LSL #16
    MOVK  X27, #0x444, LSL #32
    MOVK  X27, #0xef29, LSL #48
    SUB  X12, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X27, #0x9681, LSL #0
    MOVK  X27, #0x8d51, LSL #16
    MOVK  X27, #0x391, LSL #32
    MOVK  X27, #0xe3a1, LSL #48
    SUB  X12, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X27, #0x3289, LSL #0
    MOVK  X27, #0x4b3b, LSL #16
    MOVK  X27, #0xcda5, LSL #32
    MOVK  X27, #0x3176, LSL #48
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X27, #0x5435, LSL #0
    MOVK  X27, #0x3261, LSL #16
    MOVK  X27, #0x5d64, LSL #32
    MOVK  X27, #0x5ff7, LSL #48
    SUB  X12, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X27, #0xf1f6, LSL #0
    MOVK  X27, #0xa56b, LSL #16
    MOVK  X27, #0x2ac6, LSL #32
    MOVK  X27, #0x257d, LSL #48
    SUB  X12, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X27, #0xe8b1, LSL #0
    MOVK  X27, #0xaa57, LSL #16
    MOVK  X27, #0x9af0, LSL #32
    MOVK  X27, #0xba66, LSL #48
    SUB  X12, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X27, #0xc3b1, LSL #0
    MOVK  X27, #0x6bdf, LSL #16
    MOVK  X27, #0x4e27, LSL #32
    MOVK  X27, #0x2367, LSL #48
    SUB  X12, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X27, #0x17e4, LSL #0
    MOVK  X27, #0x8036, LSL #16
    MOVK  X27, #0xe3bc, LSL #32
    MOVK  X27, #0xffd1, LSL #48
    SUB  X12, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X27, #0x7fdc, LSL #0
    MOVK  X27, #0x7069, LSL #16
    MOVK  X27, #0x856a, LSL #32
    MOVK  X27, #0x29b2, LSL #48
    SUB  X12, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X27, #0x5a65, LSL #0
    MOVK  X27, #0x1014, LSL #16
    MOVK  X27, #0x9fe8, LSL #32
    MOVK  X27, #0x3e77, LSL #48
    SUB  X12, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X27, #0x7b9f, LSL #0
    MOVK  X27, #0x818c, LSL #16
    MOVK  X27, #0x559c, LSL #32
    MOVK  X27, #0xc37, LSL #48
    SUB  X12, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X27, #0x5f6b, LSL #0
    MOVK  X27, #0x9101, LSL #16
    MOVK  X27, #0x33bb, LSL #32
    MOVK  X27, #0x1e88, LSL #48
    SUB  X12, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X27, #0x2788, LSL #0
    MOVK  X27, #0x3366, LSL #16
    MOVK  X27, #0xeee7, LSL #32
    MOVK  X27, #0x74f5, LSL #48
    SUB  X12, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X27, #0xdef5, LSL #0
    MOVK  X27, #0x3b4e, LSL #16
    MOVK  X27, #0xb2b5, LSL #32
    MOVK  X27, #0x663f, LSL #48
    SUB  X12, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X27, #0xda9c, LSL #0
    MOVK  X27, #0x261, LSL #16
    MOVK  X27, #0x3937, LSL #32
    MOVK  X27, #0x350b, LSL #48
    SUB  X12, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X27, #0xa399, LSL #0
    MOVK  X27, #0xd11, LSL #16
    MOVK  X27, #0xda43, LSL #32
    MOVK  X27, #0xd1ef, LSL #48
    SUB  X12, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X15, #0xf, LSL #0
TSRTIntCompare_label_16:
    CMP  X27, #0x784
    CCMP  W29, W24, #0x8, MI
    CCMN  X22, X9, #0x6, HI
    CCMP  W7, W12, #0xd, HI
    CMP  X14, #0x5e7
    CCMP  X15, #0xb, #0x6, MI
    CMP  X16, X5, ASR #14
    CMP  W26, W17, SXTB #1
    CCMP  W28, W28, #0x6, NE
    CCMP  W21, #0x4, #0xf, GE
    CMN  X20, #0xdb8
    CMN  W3, #0xcb8, LSL #12
    CCMN  X18, X3, #0xe, VS
    CCMN  X28, X21, #0xe, LS
    CMN  X18, #0xc5b, LSL #12
    CCMN  W13, W18, #0xf, GT
    CMN  X21, #0xa6a, LSL #12
    CCMP  W15, W21, #0x7, AL
    CCMP  X18, #0x1, #0x7, LT
    CCMN  X21, #0x1e, #0x2, GT
    CMN  W11, W21, UXTW #0
    CCMP  W11, W22, #0xf, AL
    CMP  X22, #0xdd2
    CCMP  X13, X19, #0xc, CS
    CCMN  W29, #0x1a, #0xd, NE
    CMP  W24, W13, LSR #25
    CCMP  X29, #0x6, #0xb, MI
    CCMP  W21, #0xf, #0xc, AL
    CMP  X18, X13, UXTX #1
    CMP  W16, W20, SXTH #1
    CMP  X21, X28, LSL #61
    CCMN  W16, W11, #0x7, AL
    CMP  X19, X3, LSL #32
    CMN  W24, W15, SXTX #2
    CCMP  W13, #0x0, #0x6, AL
    CCMN  X20, X29, #0x0, NV
    CMP  X10, #0x88d, LSL #12
    CCMN  X27, X22, #0x0, GE
    CMP  W13, W24, SXTX #2
    CCMP  X21, #0x17, #0xf, AL
    CMP  X22, #0x54d, LSL #12
    CMP  W12, W7, LSR #22
    CMN  X20, W26, SXTW #3
    CMN  W3, W13, ASR #29
    CMN  X27, X22, SXTX #0
    CCMP  W26, W3, #0x2, CS
    CMN  X19, #0x8b5
    CMP  X24, W14, UXTH #3
    CCMN  X16, X21, #0xe, EQ
    CMN  W19, W7, LSR #14
    CMP  X19, X22, ASR #52
    CCMP  W28, #0x16, #0x2, VC
    CCMN  X27, X13, #0xc, GT
    CCMN  W13, #0x6, #0x8, MI
    CMP  W26, W3, SXTH #4
    CMP  X28, X26, ASR #20
    CMP  W26, W3, UXTB #0
    CMP  X11, X14, ASR #42
    CCMP  W10, W22, #0xc, CS
    CMN  W7, #0x96e, LSL #12
    CMP  X16, #0x498
    CMP  W24, #0x1b3
    CCMN  X12, #0x1b, #0x6, VC
    CCMN  W22, #0x9, #0x7, VC
    CCMN  W26, W9, #0x8, NE
    CCMP  W9, #0x1e, #0x6, CS
    CCMP  W26, #0x7, #0xa, MI
    CMN  X18, X26, ASR #47
    CCMP  X20, #0x19, #0x1, EQ
    CCMN  X26, X21, #0x0, PL
    CMN  X11, W28, UXTB #4
    CMN  X27, #0xf52, LSL #12
    CMN  X14, #0x4c5
    CCMP  X15, X18, #0x1, CS
    CMN  X21, W20, UXTH #1
    CCMN  W26, W22, #0x8, LE
    CMP  X24, X7, LSL #33
    CMP  X15, X26, LSR #2
    CCMN  W5, W12, #0xf, CS
    CMN  W19, W14, SXTX #2
    CCMP  W22, W28, #0x5, VS
    CMN  X11, #0xe4a, LSL #12
    CCMN  X9, #0x2, #0xe, PL
    CCMP  X10, #0x18, #0xb, NV
    CMP  W28, W11, ASR #10
    CMN  X11, X19, LSL #19
    CMN  W19, #0x73e, LSL #12
    CMP  W17, #0x2fd
    CMN  W15, #0x7bd
    CMN  X27, X18, SXTX #3
    CCMP  W17, #0xc, #0xd, LS
    CMN  X18, #0x9ea
    CMN  W27, W19, LSL #25
    CCMN  W24, #0x4, #0x2, HI
    CMN  W29, W11, UXTW #1
    CMP  W5, W17, SXTB #1
    CCMP  W3, W13, #0x0, EQ
    CMP  X27, X20, ASR #14
    CMN  X11, X7, LSL #32
    CCMN  W19, #0x18, #0x2, LE
    CMP  X21, #0xd3f
    CMN  W11, #0x34, LSL #12
    CCMP  X24, #0x12, #0x2, LE
    CMP  W20, W9, LSR #22
    CMN  W24, W13, LSL #10
    CCMP  X15, #0x1c, #0xd, LT
    CCMP  W28, #0x1e, #0xe, LE
    CMP  X27, W17, UXTH #1
    CMN  W24, W19, SXTH #0
    CCMP  X19, X13, #0xe, PL
    CCMN  W19, W16, #0x9, HI
    CMN  W9, W20, SXTX #0
    CCMN  X29, X5, #0x1, PL
    CMP  X15, W26, UXTB #3
    CCMP  W26, W27, #0x9, NV
    CMP  X18, #0x634, LSL #12
    CMN  W27, #0xe9b
    CMP  W9, #0x342, LSL #12
    CMN  W28, W21, LSL #16
    CMN  W20, W16, UXTB #4
    CCMP  W18, #0xd, #0xe, EQ
    CMP  W26, W22, UXTW #3
    CCMP  W18, W17, #0x9, GT
    CMN  W24, W16, LSR #0
    CCMN  X7, #0x14, #0xd, GT
    CCMP  X16, #0xd, #0x9, CC
    CMP  W27, W24, SXTX #2
    CCMP  X14, X29, #0xa, AL
    CCMP  W3, #0x10, #0xf, EQ
    CMN  W9, W5, LSR #21
    CMN  X21, W18, UXTH #4
    CCMP  W7, W17, #0x5, EQ
    CMP  X20, #0xed0, LSL #12
    CCMP  W11, #0x12, #0x7, EQ
    CMP  W3, W22, LSL #19
    CCMN  W19, #0x14, #0x2, LE
    CCMP  W13, #0xd, #0xc, LE
    CMP  W28, #0x4fc
    CCMN  X28, #0x9, #0x1, AL
    CMP  X28, X22, ASR #19
    CCMP  W27, #0x3, #0x8, CS
    CMP  X22, #0x881
    CMP  W27, W7, SXTH #1
    CMN  X11, W10, UXTW #4
    CMN  W7, #0x833
    CMP  X28, X14, ASR #48
    CMN  X14, #0x7b2, LSL #12
    CMP  X26, X16, SXTX #0
    CCMP  W19, W22, #0xb, MI
    CMN  W15, #0x62d
    CCMP  X10, #0xc, #0x2, AL
    CMN  W10, #0xfc6, LSL #12
    CMN  W21, W29, UXTW #2
    CMN  X29, X15, LSR #4
    CMP  W17, #0x729, LSL #12
    CMP  W5, #0x587, LSL #12
    CMP  X5, W3, UXTB #4
    CMP  W3, W24, LSL #24
    CMP  X7, #0x4e8, LSL #12
    CMN  X26, #0xb18, LSL #12
    CMN  W11, W10, UXTW #2
    CMN  X15, X16, LSL #43
    CMN  W10, #0x535
    CMN  X22, #0x4a6, LSL #12
    CCMP  X22, X5, #0x0, LS
    CMN  X24, X26, UXTX #2
    CCMP  W24, #0x12, #0xd, GE
    CCMP  X13, X12, #0x9, NE
    CCMN  W26, W20, #0x7, NV
    CMP  W20, W21, ASR #14
    CMP  W21, #0x565, LSL #12
    CCMN  X15, #0x1, #0xe, VC
    CMP  X22, #0xf64, LSL #12
    CCMN  X11, #0x1a, #0x5, NV
    CMP  W29, #0x3f4
    CMN  X18, #0xb4b, LSL #12
    CMP  W18, W9, ASR #26
    CCMN  W9, W28, #0x1, PL
    CCMN  W13, W28, #0xb, NV
    CMP  W20, #0x509, LSL #12
    CMN  W28, W15, UXTW #0
    CCMN  X13, X19, #0xe, LE
    CCMP  X17, X12, #0x4, CS
    CCMP  W7, #0x1b, #0x3, CS
    CMP  W12, W16, UXTX #1
    CMN  W22, #0x641, LSL #12
    CMN  X20, X18, ASR #29
    CMN  X12, #0x5eb, LSL #12
    CMP  X24, X5, LSL #35
    CMN  X15, X13, ASR #33
    CCMP  X24, X13, #0x4, LE
    CMP  W9, #0x632, LSL #12
    CCMN  X12, X10, #0x6, HI
    CMN  W12, W14, SXTX #2
    CMP  W19, #0x388, LSL #12
    CCMP  X27, X20, #0x0, GE
    CCMN  X28, #0x17, #0xf, CS
    CCMP  W26, W14, #0x9, CC
    CCMN  X29, #0x5, #0x5, LT
    CCMP  W29, W3, #0xe, GE
    SUBS  X15, X15, #0x1
    B.NE  TSRTIntCompare_label_16
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntCompare_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
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
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
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
    MOVZ  X27, #0xf, LSL #0
TSRTIntCompare_label_17:
    CMN  X27, X26, ASR #25
    CMP  W24, W24, SXTX #3
    CMP  X28, X29, LSL #20
    CMP  W22, W4, LSL #20
    CMP  W18, #0x1ff
    CMN  X28, #0x8e1
    CMP  X18, #0x50e
    CCMN  W11, W17, #0x1, CC
    CMP  X17, #0xad7
    CCMN  X9, #0x1f, #0xb, HI
    CMN  X13, W21, UXTB #2
    CMP  W16, #0xff1, LSL #12
    CCMN  W19, #0x10, #0x2, AL
    CCMN  X19, #0xc, #0x6, HI
    CMP  X28, X10, SXTX #1
    CCMP  W20, W15, #0xb, GE
    CCMN  W9, W21, #0xd, GT
    CMP  X4, W26, SXTB #3
    CCMN  X21, X16, #0x0, HI
    CMP  X28, X16, UXTX #4
    CMN  W11, W15, LSR #2
    CCMN  W3, W20, #0x9, VC
    CMP  X11, X11
    CCMN  W10, W24, #0x8, LE
    CMN  W16, W10, SXTH #2
    CMN  X17, X24, LSR #34
    CMP  X16, X9, LSR #32
    CMN  W28, #0x9c4
    CMN  X7, X29, LSL #12
    CMN  W22, W13, SXTW #3
    CMP  W26, W18, LSL #21
    CCMP  X27, X16, #0x3, CC
    CMN  W7, W28, UXTW #0
    CMN  W21, #0x198
    CMN  W27, W28, UXTB #4
    CMP  X2, X14, LSR #10
    CCMP  X26, #0x14, #0x4, LS
    CCMN  W2, W16, #0xa, AL
    CCMP  W15, #0x10, #0x7, AL
    CMP  X2, X4, LSR #6
    CMN  W19, #0x1aa, LSL #12
    CMP  W14, W13, LSR #15
    CCMP  W10, #0x17, #0xf, CC
    CMN  X10, W16, UXTW #0
    CMN  W13, W21, SXTB #3
    CCMP  W24, W28, #0xa, NV
    CMN  W18, W3, SXTX #0
    CCMP  W13, W21, #0xc, LE
    CMP  W4, W2, SXTB #3
    CCMN  W17, W29, #0xd, NV
    CCMP  W15, #0x13, #0xe, NE
    CCMN  W21, #0x13, #0x3, VC
    CMP  X10, #0xe52, LSL #12
    CCMN  X26, #0xd, #0x9, MI
    CCMP  W17, #0x19, #0x7, LT
    CMP  W9, #0xbba, LSL #12
    CCMP  X28, #0xc, #0x1, HI
    CCMP  W10, W20, #0x4, NV
    CMP  X2, #0xbfd, LSL #12
    CCMN  X14, #0x1f, #0x1, HI
    CCMP  X26, X17, #0xa, AL
    CCMP  X15, X28, #0x5, VS
    CCMN  X24, X19, #0x2, AL
    CMN  X19, W4, UXTW #2
    CMP  W28, W20, LSR #1
    CCMP  X10, X27, #0x3, LE
    CMN  X7, #0x829, LSL #12
    CCMP  X26, X21, #0x2, NV
    CMP  W11, W11, ASR #13
    CMP  X17, X28, SXTX #1
    CCMP  X11, #0x1f, #0xa, LE
    CCMP  X3, X18, #0x8, VS
    CMP  W19, W2, ASR #1
    CMP  X11, W22, UXTW #3
    CCMN  X13, #0x2, #0xd, MI
    CCMN  W29, #0x19, #0x1, PL
    CMP  X11, #0x4af, LSL #12
    CMN  X13, #0x3f
    CCMP  X26, X7, #0xd, VS
    CMN  W20, W13, UXTH #1
    CCMN  W15, #0x1c, #0x9, LT
    CCMN  X24, X20, #0x5, PL
    CMN  W9, W26, ASR #31
    CCMP  X29, #0x6, #0xf, LS
    CMN  W19, #0x56d
    CMP  X20, #0x4f2, LSL #12
    CCMN  W19, #0x9, #0x4, CS
    CMN  W19, W29, LSL #14
    CCMN  W10, #0x3, #0xb, HI
    CCMN  W17, #0x1e, #0x2, CC
    CMP  X16, #0x2e6, LSL #12
    CMN  X16, X27, SXTX #4
    CMP  X4, #0x4f5, LSL #12
    CMP  W4, W14, LSL #5
    CCMN  W13, #0x1b, #0x6, VC
    CMP  W13, W14, LSL #12
    CMP  W9, W17, LSL #29
    CMN  W21, #0x47
    CCMN  X16, #0x5, #0xd, EQ
    CMP  W9, W3, SXTX #3
    CMP  W28, #0x429
    CMP  W15, W2, UXTB #2
    CMN  W26, W17, LSR #16
    CMP  X18, W17, SXTH #3
    CMN  X22, X26, SXTX #4
    CMN  W11, #0xa33, LSL #12
    CMN  W17, W4, UXTH #1
    CMP  X4, W21, UXTH #3
    CCMN  X2, X24, #0x8, GE
    CMN  X14, #0x56c
    CMN  X14, W21, SXTW #2
    CMN  X10, X7, ASR #51
    CMP  W13, W26, LSR #26
    CMP  W27, W18, LSR #10
    CMP  X20, #0x429, LSL #12
    CMN  X27, X20, LSL #10
    CMP  X4, #0x4aa
    CMP  X24, X15, LSL #34
    CCMP  W10, #0x1f, #0x9, GT
    CMN  W15, W10, SXTH #2
    CMN  X2, #0x704, LSL #12
    CMP  W21, W3, UXTX #3
    CMP  W17, W9, SXTX #0
    CMN  X10, #0x4e7, LSL #12
    CCMP  X7, #0xd, #0xd, GE
    CMP  W9, W14, LSL #21
    CMP  W7, W22, UXTX #0
    CMN  W19, W26, UXTX #1
    CCMP  W20, #0x14, #0x9, CS
    CCMN  X10, X13, #0xb, CC
    CMN  W22, #0x69b, LSL #12
    CMP  X13, #0x5d7, LSL #12
    CMN  W19, W11, UXTX #1
    CMN  W21, W19, UXTH #0
    CCMP  X18, #0x13, #0x7, LT
    CCMP  W22, W26, #0x3, AL
    CCMP  W21, W19, #0x1, CC
    CMP  X20, #0x419, LSL #12
    CCMN  W20, #0x1e, #0x2, CS
    CCMP  X13, X29, #0x5, MI
    CMP  X4, X21, ASR #6
    CCMP  X21, #0xd, #0x9, LS
    CMN  W17, W28, LSR #28
    CCMN  W19, W28, #0xf, VS
    CMN  X26, #0x127, LSL #12
    CCMN  X22, #0x9, #0x9, LT
    CMN  W3, W26, UXTW #1
    CMP  W15, #0x55c, LSL #12
    CCMP  X27, #0x1c, #0x8, EQ
    CCMP  W3, W2, #0x1, EQ
    CCMP  X3, #0xe, #0xf, CC
    CMP  X2, X11, LSR #18
    CCMP  X15, X14, #0x2, HI
    CMN  X19, W21, SXTB #1
    CCMP  X29, X11, #0x2, LS
    CMP  W21, W29, LSR #13
    CMN  X13, W18, SXTH #1
    CMN  X16, W11, SXTH #0
    CMN  X21, #0x52b
    CMP  X26, X9, LSR #31
    CCMN  X7, #0x8, #0x7, LT
    CCMP  X18, #0x5, #0x9, CS
    CMN  W22, W29, LSL #16
    CMP  W22, W17, LSR #21
    CMN  W21, W19, SXTX #0
    CMP  W18, #0xdf5
    CMN  X20, W20, SXTW #4
    CMN  W27, W29, LSL #13
    CMN  W7, W17, SXTX #4
    CMN  W26, W28, ASR #25
    CCMN  X3, X10, #0x6, VS
    CMN  X27, X15, UXTX #0
    CCMP  X2, #0x1e, #0xa, LS
    CMP  W9, #0x593
    CCMN  W26, #0x11, #0xe, AL
    CCMN  W9, #0x14, #0xf, GT
    CMN  W7, W17, UXTW #2
    CMN  X19, X7, LSR #22
    CCMP  W10, #0xf, #0xf, EQ
    CCMN  X15, #0x19, #0xe, GT
    CCMN  W27, W20, #0x3, VS
    CMN  X29, W21, UXTB #2
    CCMN  X15, X7, #0x1, HI
    CMN  X14, X3, ASR #1
    CMP  W28, W14, LSR #2
    CMP  W4, W26, LSL #1
    CCMP  X9, X27, #0x1, EQ
    CCMP  X20, #0x7, #0xa, GE
    CMN  X11, X3, LSR #54
    CCMN  X26, #0x6, #0x1, GE
    CMP  X7, X11, UXTX #4
    CCMN  W9, #0xf, #0x7, LS
    CCMN  W19, W11, #0x9, PL
    CCMN  W22, W11, #0x4, LE
    CCMN  W2, #0x0, #0x3, CC
    CMN  W2, W13, LSL #7
    CCMP  X17, X13, #0x5, LE
    CCMP  W3, #0x3, #0xb, MI
    CMN  X17, X17, LSR #17
    CMP  X27, W24, UXTB #3
    SUBS  X27, X27, #0x1
    B.NE  TSRTIntCompare_label_17
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X12, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X12, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X12, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X12, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X12, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X12, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X12, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X12, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X12, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X12, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X12, X5, X19
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X12, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X12, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X12, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X12, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X12, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X12, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCompare_TestFail
    MOVZ  X2, #0xbb90, LSL #0
    MOVK  X2, #0x6441, LSL #16
    MOVK  X2, #0x10a1, LSL #32
    MOVK  X2, #0x66d4, LSL #48
    MOVZ  X3, #0x2c56, LSL #0
    MOVK  X3, #0xdd13, LSL #16
    MOVK  X3, #0x2ecc, LSL #32
    MOVK  X3, #0x1182, LSL #48
    MOVZ  X4, #0xa346, LSL #0
    MOVK  X4, #0x30b3, LSL #16
    MOVK  X4, #0xa3ed, LSL #32
    MOVK  X4, #0x254, LSL #48
    MOVZ  X5, #0xaa77, LSL #0
    MOVK  X5, #0xa477, LSL #16
    MOVK  X5, #0xb036, LSL #32
    MOVK  X5, #0xa0c8, LSL #48
    MOVZ  X7, #0x4539, LSL #0
    MOVK  X7, #0x7f29, LSL #16
    MOVK  X7, #0x83a8, LSL #32
    MOVK  X7, #0x120f, LSL #48
    MOVZ  X9, #0x54a, LSL #0
    MOVK  X9, #0x4c70, LSL #16
    MOVK  X9, #0x5837, LSL #32
    MOVK  X9, #0x432e, LSL #48
    MOVZ  X10, #0x68f, LSL #0
    MOVK  X10, #0xb5f2, LSL #16
    MOVK  X10, #0xa945, LSL #32
    MOVK  X10, #0x3674, LSL #48
    MOVZ  X11, #0xe720, LSL #0
    MOVK  X11, #0xbb75, LSL #16
    MOVK  X11, #0xd585, LSL #32
    MOVK  X11, #0x9ad, LSL #48
    MOVZ  X12, #0xbabe, LSL #0
    MOVK  X12, #0x63d4, LSL #16
    MOVK  X12, #0x212f, LSL #32
    MOVK  X12, #0xf24, LSL #48
    MOVZ  X13, #0x54d7, LSL #0
    MOVK  X13, #0x45d3, LSL #16
    MOVK  X13, #0xc05a, LSL #32
    MOVK  X13, #0x2e97, LSL #48
    MOVZ  X14, #0xc6b, LSL #0
    MOVK  X14, #0xbf6a, LSL #16
    MOVK  X14, #0x57bd, LSL #32
    MOVK  X14, #0xb601, LSL #48
    MOVZ  X15, #0x8ce2, LSL #0
    MOVK  X15, #0xc468, LSL #16
    MOVK  X15, #0x900, LSL #32
    MOVK  X15, #0xed67, LSL #48
    MOVZ  X16, #0xe7db, LSL #0
    MOVK  X16, #0xde03, LSL #16
    MOVK  X16, #0x3e12, LSL #32
    MOVK  X16, #0xd3f5, LSL #48
    MOVZ  X17, #0x5e9, LSL #0
    MOVK  X17, #0x8f9e, LSL #16
    MOVK  X17, #0xa14c, LSL #32
    MOVK  X17, #0x64fd, LSL #48
    MOVZ  X18, #0x1261, LSL #0
    MOVK  X18, #0xa5c2, LSL #16
    MOVK  X18, #0x90bb, LSL #32
    MOVK  X18, #0x5a65, LSL #48
    MOVZ  X19, #0x8f3b, LSL #0
    MOVK  X19, #0x6745, LSL #16
    MOVK  X19, #0xcf57, LSL #32
    MOVK  X19, #0xcd9, LSL #48
    MOVZ  X20, #0x6445, LSL #0
    MOVK  X20, #0xed88, LSL #16
    MOVK  X20, #0xdf3f, LSL #32
    MOVK  X20, #0x8f4e, LSL #48
    MOVZ  X21, #0x5a9f, LSL #0
    MOVK  X21, #0x4abe, LSL #16
    MOVK  X21, #0xcec7, LSL #32
    MOVK  X21, #0xf4ed, LSL #48
    MOVZ  X22, #0x9f48, LSL #0
    MOVK  X22, #0x1423, LSL #16
    MOVK  X22, #0xa7bf, LSL #32
    MOVK  X22, #0x67de, LSL #48
    MOVZ  X24, #0x49ef, LSL #0
    MOVK  X24, #0xebc0, LSL #16
    MOVK  X24, #0x4198, LSL #32
    MOVK  X24, #0xf688, LSL #48
    MOVZ  X26, #0x26ba, LSL #0
    MOVK  X26, #0xfd08, LSL #16
    MOVK  X26, #0x3b7a, LSL #32
    MOVK  X26, #0xc6e1, LSL #48
    MOVZ  X27, #0x2594, LSL #0
    MOVK  X27, #0x7e9, LSL #16
    MOVK  X27, #0x73a1, LSL #32
    MOVK  X27, #0xb43a, LSL #48
    MOVZ  X28, #0x4f02, LSL #0
    MOVK  X28, #0xb551, LSL #16
    MOVK  X28, #0xc603, LSL #32
    MOVK  X28, #0x6295, LSL #48
    MOVZ  X29, #0xb1a7, LSL #0
    MOVK  X29, #0xbedc, LSL #16
    MOVK  X29, #0x6338, LSL #32
    MOVK  X29, #0x6f03, LSL #48
    MOVZ  X11, #0xf, LSL #0
TSRTIntCompare_label_18:
    CMN  X24, #0xba
    CMP  X28, W28, SXTW #1
    CMN  W26, W29, SXTX #0
    CCMP  X11, #0x12, #0x4, CC
    CMN  X27, X27, LSL #36
    CMP  W22, W7, UXTW #0
    CMP  W18, #0x12a, LSL #12
    CCMN  W11, #0xd, #0x1, PL
    CCMN  X11, X28, #0x3, LT
    CMN  X10, W26, SXTH #1
    CMN  W15, #0xc16, LSL #12
    CMN  X7, W9, SXTW #4
    CMN  W10, W28, LSR #6
    CCMN  W19, W9, #0x5, PL
    CMN  X11, X17, ASR #60
    CCMP  W9, #0x8, #0x0, VC
    CMN  X3, X12, SXTX #4
    CMP  W26, W4, LSR #17
    CMN  X3, W24, UXTW #3
    CMN  X4, W19, UXTH #2
    CCMN  W3, W10, #0xc, GT
    CCMP  W15, #0x6, #0xd, EQ
    CMN  X4, #0xc17
    CMP  W15, W12, LSR #11
    CCMP  X26, X26, #0x6, MI
    CCMP  W28, W5, #0x1, AL
    CMP  W18, W28, LSR #10
    CCMP  W12, W5, #0xd, LT
    CMN  W16, #0x69c, LSL #12
    CCMN  W24, W2, #0x9, HI
    CMP  W11, #0xc22, LSL #12
    CCMP  W19, W7, #0xd, AL
    CMP  X10, X12, LSR #21
    CMN  W20, W9, LSR #13
    CMN  W22, W29, LSL #26
    CCMP  W24, W5, #0x8, VC
    CCMN  X15, #0x3, #0x2, PL
    CMN  X10, X20, LSR #50
    CCMP  X27, X12, #0x3, AL
    CMP  X16, W24, SXTB #2
    CMP  X16, W20, UXTB #0
    CMN  W20, W4, ASR #27
    CMN  X27, W16, UXTB #2
    CCMN  W17, W2, #0x8, NV
    CCMN  X20, X17, #0x8, EQ
    CCMN  W2, W26, #0xd, MI
    CCMN  X22, X10, #0x3, CS
    CMN  W14, #0xc5e
    CMN  X2, W11, UXTW #4
    CMN  W28, W4, SXTX #0
    CCMN  X4, X28, #0x9, GE
    CMP  W16, W7, UXTX #2
    CCMN  X14, X12, #0xd, VC
    CMP  W20, W2, LSR #9
    CCMN  X17, X9, #0x3, EQ
    CMP  X5, W15, SXTW #2
    CMN  W29, #0x74c, LSL #12
    CMN  W2, W19, SXTB #0
    CMP  W7, W20, SXTH #1
    CMP  X11, #0xd83, LSL #12
    CMP  W15, #0xc4e, LSL #12
    CMP  W10, W14, UXTX #3
    CMP  W24, W19, LSR #11
    CMP  X12, X17, ASR #57
    CMP  X12, X3, LSR #44
    CMN  W22, #0xc97, LSL #12
    CMN  X11, X24, UXTX #3
    CMP  X14, W14, UXTB #0
    CMN  X5, W11, UXTH #4
    CMN  X2, X5, UXTX #4
    CMN  W5, W26, ASR #8
    CCMN  X17, X9, #0x2, PL
    CMP  W5, W15, LSL #5
    CMP  X9, W22, SXTB #3
    CCMP  W2, W22, #0x9, GT
    CCMP  W7, #0x11, #0x3, GT
    CMP  W27, W27, UXTW #3
    CMN  X16, X11, LSR #32
    CCMN  X14, X15, #0x8, PL
    CMN  W15, W29, SXTW #4
    CMP  X12, #0x5c, LSL #12
    CMP  W9, W15, ASR #0
    CCMP  W19, #0xb, #0x1, AL
    CCMP  W19, #0x4, #0x6, CS
    CMN  W12, #0xa9c, LSL #12
    CCMP  W2, #0x1d, #0x3, EQ
    CCMN  X7, #0x16, #0x1, LT
    CCMN  W28, #0x7, #0x0, NV
    CMN  X14, X2, LSR #17
    CCMN  W9, #0x4, #0x7, LE
    CMN  W10, W26, SXTB #4
    CMP  X24, #0x9b1
    CMP  X27, #0xcc6, LSL #12
    CMN  W22, #0x913
    CCMN  X4, X20, #0x1, VS
    CMN  W24, W19, SXTX #4
    CMP  X7, X19, UXTX #2
    CCMP  X20, X16, #0xb, MI
    CMN  W14, W26, LSR #11
    CMN  X10, X3, UXTX #3
    CMP  X22, W14, SXTH #4
    CCMP  W7, W27, #0xd, LS
    CMN  W26, W12, ASR #10
    CMN  X17, X20, LSL #36
    CMN  W9, W15, UXTX #1
    CMN  W19, #0x2b3
    CMN  W22, W9, LSL #31
    CMP  W7, #0x7d8
    CMN  X19, X3, LSL #60
    CMN  X24, X26, LSR #20
    CMP  W2, W14, LSR #26
    CMP  W2, W19, LSL #30
    CCMN  W29, W20, #0x2, AL
    CCMN  X29, #0x0, #0x4, NE
    CMN  X24, #0x1c9, LSL #12
    CMN  W16, W10, UXTH #3
    CMN  X22, X14, SXTX #3
    CCMN  X18, #0x1d, #0x4, NV
    CMN  X5, W26, SXTW #4
    CMN  X28, #0x440, LSL #12
    CMP  W18, W28, UXTW #4
    CCMN  X11, #0x1f, #0xf, EQ
    CMN  W5, W14, ASR #0
    CMN  X17, W29, UXTW #4
    CMP  W11, W19, ASR #31
    CCMP  X10, #0x3, #0xe, LS
    CMN  W15, W28, LSL #21
    CMP  W12, #0x8a5
    CCMN  X24, X22, #0xa, AL
    CCMN  X18, X16, #0xc, MI
    CMN  X15, W29, SXTW #1
    CMN  X2, X20, LSL #44
    CMN  W14, W16, LSR #11
    CCMN  X9, #0x0, #0xd, AL
    CCMP  W19, #0x18, #0x7, GE
    CMN  W5, #0xb9b
    CCMP  X26, #0x1c, #0xd, PL
    CCMP  W5, #0x11, #0x2, LT
    CCMP  W5, W27, #0x9, GT
    CMN  X20, X7, LSL #47
    CMP  X26, #0x978
    CMP  W17, W29, ASR #20
    CMP  X16, X2, SXTX #3
    CCMN  X27, #0x8, #0x3, PL
    CCMN  W19, #0xc, #0x4, EQ
    CMP  W20, W5, LSL #19
    CMN  X2, #0x38e, LSL #12
    CMP  W14, #0x72c, LSL #12
    CMP  W28, W17, SXTB #1
    CCMN  W12, W4, #0x8, EQ
    CMP  W4, W16, ASR #4
    CMP  W28, W3, UXTB #4
    CCMP  W29, W3, #0x4, HI
    CCMP  W24, #0x15, #0x7, LT
    CCMP  X26, X20, #0x5, LT
    CMP  X11, X11, ASR #27
    CCMN  X10, #0x4, #0x9, NE
    CMP  X5, #0x1e4, LSL #12
    CMP  X10, X12, ASR #63
    CMP  W9, W20, SXTX #1
    CCMN  W16, #0x9, #0xf, LS
    CCMN  X29, #0x4, #0x4, CC
    CMP  X19, W19, SXTW #2
    CCMN  W3, #0xb, #0xf, NE
    CCMP  X10, X17, #0x4, LT
    CMP  X15, W26, UXTH #3
    CMN  W15, #0xa73, LSL #12
    CMN  W10, W16, LSL #26
    CCMP  X14, #0x5, #0x5, VC
    CCMP  X16, X18, #0x8, MI
    CCMP  W4, W27, #0xc, GE
    CMN  X2, #0xdf3
    CCMN  X24, X2, #0x3, HI
    CMP  W26, #0x5eb, LSL #12
    CMN  X10, X12, ASR #9
    CMP  W4, #0x959
    CMN  W7, W20, LSL #6
    CCMN  W11, #0x15, #0x2, HI
    CMN  X29, #0x49b
    CCMN  X20, #0xa, #0x3, CC
    CMN  W22, W28, SXTX #4
    CMN  W17, W19, ASR #8
    CCMN  W28, #0x15, #0x4, VC
    CCMN  X2, X18, #0xe, CS
    CMN  X27, X12, LSR #25
    CMN  W27, W20, LSL #19
    CCMP  X26, #0x1e, #0xb, AL
    CCMP  X5, X18, #0x1, VC
    CMP  X19, #0x7a9
    CCMP  W29, W14, #0x3, AL
    CCMP  W9, W18, #0x0, NV
    CCMN  X29, #0xf, #0xa, LE
    CMN  X11, #0x8e9
    CCMP  X5, #0x7, #0xb, MI
    CCMP  X24, #0x1b, #0x5, NV
    CMP  X27, W14, SXTH #1
    CMN  X7, X18, ASR #19
    CMN  X11, X24, ASR #3
    CCMN  W9, #0x18, #0x3, AL
    CCMP  X27, #0x12, #0x8, VS
    SUBS  X11, X11, #0x1
    B.NE  TSRTIntCompare_label_18
    MOVZ  X13, #0xbb90, LSL #0
    MOVK  X13, #0x6441, LSL #16
    MOVK  X13, #0x10a1, LSL #32
    MOVK  X13, #0x66d4, LSL #48
    SUB  X21, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X13, #0x2c56, LSL #0
    MOVK  X13, #0xdd13, LSL #16
    MOVK  X13, #0x2ecc, LSL #32
    MOVK  X13, #0x1182, LSL #48
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X13, #0xa346, LSL #0
    MOVK  X13, #0x30b3, LSL #16
    MOVK  X13, #0xa3ed, LSL #32
    MOVK  X13, #0x254, LSL #48
    SUB  X21, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X13, #0xaa77, LSL #0
    MOVK  X13, #0xa477, LSL #16
    MOVK  X13, #0xb036, LSL #32
    MOVK  X13, #0xa0c8, LSL #48
    SUB  X21, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X13, #0x4539, LSL #0
    MOVK  X13, #0x7f29, LSL #16
    MOVK  X13, #0x83a8, LSL #32
    MOVK  X13, #0x120f, LSL #48
    SUB  X21, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X13, #0x54a, LSL #0
    MOVK  X13, #0x4c70, LSL #16
    MOVK  X13, #0x5837, LSL #32
    MOVK  X13, #0x432e, LSL #48
    SUB  X21, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X13, #0x68f, LSL #0
    MOVK  X13, #0xb5f2, LSL #16
    MOVK  X13, #0xa945, LSL #32
    MOVK  X13, #0x3674, LSL #48
    SUB  X21, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X13, #0xbabe, LSL #0
    MOVK  X13, #0x63d4, LSL #16
    MOVK  X13, #0x212f, LSL #32
    MOVK  X13, #0xf24, LSL #48
    SUB  X21, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X13, #0xc6b, LSL #0
    MOVK  X13, #0xbf6a, LSL #16
    MOVK  X13, #0x57bd, LSL #32
    MOVK  X13, #0xb601, LSL #48
    SUB  X21, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X13, #0x8ce2, LSL #0
    MOVK  X13, #0xc468, LSL #16
    MOVK  X13, #0x900, LSL #32
    MOVK  X13, #0xed67, LSL #48
    SUB  X21, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X13, #0xe7db, LSL #0
    MOVK  X13, #0xde03, LSL #16
    MOVK  X13, #0x3e12, LSL #32
    MOVK  X13, #0xd3f5, LSL #48
    SUB  X21, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X13, #0x5e9, LSL #0
    MOVK  X13, #0x8f9e, LSL #16
    MOVK  X13, #0xa14c, LSL #32
    MOVK  X13, #0x64fd, LSL #48
    SUB  X21, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X13, #0x1261, LSL #0
    MOVK  X13, #0xa5c2, LSL #16
    MOVK  X13, #0x90bb, LSL #32
    MOVK  X13, #0x5a65, LSL #48
    SUB  X21, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X13, #0x8f3b, LSL #0
    MOVK  X13, #0x6745, LSL #16
    MOVK  X13, #0xcf57, LSL #32
    MOVK  X13, #0xcd9, LSL #48
    SUB  X21, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X13, #0x6445, LSL #0
    MOVK  X13, #0xed88, LSL #16
    MOVK  X13, #0xdf3f, LSL #32
    MOVK  X13, #0x8f4e, LSL #48
    SUB  X21, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X13, #0x9f48, LSL #0
    MOVK  X13, #0x1423, LSL #16
    MOVK  X13, #0xa7bf, LSL #32
    MOVK  X13, #0x67de, LSL #48
    SUB  X21, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X13, #0x49ef, LSL #0
    MOVK  X13, #0xebc0, LSL #16
    MOVK  X13, #0x4198, LSL #32
    MOVK  X13, #0xf688, LSL #48
    SUB  X21, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X13, #0x26ba, LSL #0
    MOVK  X13, #0xfd08, LSL #16
    MOVK  X13, #0x3b7a, LSL #32
    MOVK  X13, #0xc6e1, LSL #48
    SUB  X21, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X13, #0x2594, LSL #0
    MOVK  X13, #0x7e9, LSL #16
    MOVK  X13, #0x73a1, LSL #32
    MOVK  X13, #0xb43a, LSL #48
    SUB  X21, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X13, #0x4f02, LSL #0
    MOVK  X13, #0xb551, LSL #16
    MOVK  X13, #0xc603, LSL #32
    MOVK  X13, #0x6295, LSL #48
    SUB  X21, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X13, #0xb1a7, LSL #0
    MOVK  X13, #0xbedc, LSL #16
    MOVK  X13, #0x6338, LSL #32
    MOVK  X13, #0x6f03, LSL #48
    SUB  X21, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X20, #0xf, LSL #0
TSRTIntCompare_label_19:
    CCMN  W26, #0x1a, #0x3, VS
    CMP  W22, W15, UXTW #3
    CMN  X11, X27, LSR #49
    CMN  W5, #0xcb7
    CCMN  W17, #0x17, #0x0, CS
    CMN  W24, W20, UXTB #1
    CMN  X16, W16, UXTW #2
    CCMP  W19, W18, #0x7, GE
    CCMN  W10, #0xf, #0x2, NV
    CCMN  W29, W21, #0xc, LT
    CMP  W28, W28, LSL #11
    CMN  W26, W17, LSR #23
    CMP  W11, W22, LSL #19
    CCMP  W24, W19, #0x0, VS
    CCMP  W2, #0x7, #0x7, HI
    CMP  W18, W17, SXTX #2
    CMN  W27, W20, SXTH #3
    CMN  W15, W9, SXTB #1
    CCMN  X21, #0x16, #0x7, NE
    CCMN  X15, #0x18, #0x4, LS
    CMN  X29, W19, SXTH #1
    CMP  X19, W17, SXTH #3
    CMN  W11, W28, ASR #29
    CMN  W2, #0xdc6
    CMP  W5, W9, UXTX #0
    CMN  W14, W9, SXTW #3
    CCMN  W14, #0x1d, #0x9, PL
    CMN  W12, W9, SXTB #0
    CMP  W11, W2, SXTW #2
    CCMP  X18, #0x1b, #0x7, PL
    CMN  X27, W22, SXTH #1
    CMN  X26, X18, LSL #32
    CMP  W15, #0x1c9
    CMP  X9, #0x246
    CMN  X11, X11, SXTX #2
    CCMN  X21, #0x2, #0xf, NV
    CMP  X22, X15, LSL #52
    CMP  W27, #0x76d, LSL #12
    CCMN  X11, X18, #0xe, PL
    CCMN  W21, W2, #0xf, VS
    CCMN  W12, W21, #0x1, VC
    CMN  W10, W10, UXTB #2
    CCMN  X21, #0x11, #0x2, CC
    CMP  X16, #0xce5, LSL #12
    CCMP  X3, #0x1, #0x2, NE
    CMN  W16, W19, LSR #30
    CMN  X5, X17, UXTX #4
    CMP  W20, #0x885
    CCMP  W5, #0x7, #0x6, CC
    CCMN  X4, #0x12, #0xd, LT
    CCMP  W28, #0x1b, #0xb, EQ
    CMN  X19, X2, ASR #37
    CMP  W15, W4, UXTW #4
    CCMP  W24, #0xa, #0x8, CC
    CMP  W26, #0xcf9, LSL #12
    CMN  W3, W12, UXTB #0
    CMP  X4, #0x92c, LSL #12
    CCMP  X19, #0x16, #0x7, NV
    CMP  X22, #0x730, LSL #12
    CCMN  W29, W11, #0x3, GT
    CMP  W11, W24, ASR #24
    CMP  X14, X3, ASR #53
    CMN  X29, W27, SXTB #4
    CCMP  X26, X27, #0xb, VS
    CMP  W22, #0x23e, LSL #12
    CCMN  W20, W28, #0x7, GT
    CMP  W21, W16, UXTX #3
    CMN  W19, #0xd5e
    CMP  W19, W2, SXTW #3
    CMN  W24, #0xf83
    CMP  W2, W28, UXTH #1
    CCMN  W12, W20, #0xb, LE
    CMP  X3, #0x71
    CCMP  X27, #0x9, #0x1, LS
    CCMN  W28, #0x1c, #0xa, PL
    CCMN  X3, X20, #0x1, LT
    CMN  X21, W5, UXTH #4
    CMP  W24, W20, UXTW #0
    CCMP  W4, W26, #0x4, LT
    CCMP  X28, X3, #0x5, MI
    CCMN  X2, #0x1f, #0xb, VS
    CMP  X29, X4, LSR #23
    CCMN  W17, #0x18, #0x6, HI
    CCMN  X21, X17, #0x5, AL
    CCMN  X5, #0x8, #0x1, GE
    CMP  W19, #0xf5b
    CMP  X14, X26, UXTX #0
    CMP  X12, #0xa11, LSL #12
    CMN  X4, X26, SXTX #0
    CCMP  X16, #0xb, #0x5, VC
    CMP  X19, X11, ASR #30
    CCMP  W15, W22, #0xe, MI
    CCMN  W9, #0x1, #0x7, GE
    CCMP  X21, #0x6, #0xe, AL
    CMN  W3, W27, SXTH #2
    CCMN  X5, #0x17, #0x4, VC
    CMP  W21, W16, ASR #19
    CCMP  X14, X21, #0xa, AL
    CMP  X14, X9, SXTX #2
    CMP  X9, X14, ASR #35
    CMN  X18, X10, LSL #59
    CCMP  W17, #0x1b, #0xf, NE
    CCMN  W19, W4, #0xa, LE
    CMN  X17, #0xf61
    CMN  W19, W26, UXTH #4
    CMN  X19, X10, ASR #5
    CCMN  W2, W19, #0x1, NE
    CCMP  X27, #0x4, #0x4, AL
    CCMP  X16, #0x16, #0x8, CC
    CMP  X27, #0x55c
    CCMP  X18, #0x10, #0x8, HI
    CCMN  W29, W9, #0x8, GE
    CCMP  X5, #0x10, #0x0, LT
    CMN  X17, X16, LSL #2
    CCMN  X19, X2, #0x3, CS
    CCMN  X17, X9, #0x0, MI
    CMN  X28, W14, UXTB #0
    CMP  X5, W21, SXTB #0
    CMP  X29, #0xf24
    CMN  W2, W12, SXTB #4
    CCMP  X5, X14, #0x1, LT
    CCMP  W15, #0x14, #0xc, NE
    CMP  X5, X2, LSR #34
    CCMP  W5, #0x6, #0x5, LS
    CMP  X4, W28, SXTW #2
    CMP  W22, W12, LSR #1
    CCMP  X19, #0x9, #0x6, VC
    CCMN  W21, #0x7, #0x0, NV
    CMN  W28, W20, LSR #11
    CMP  W14, W24, ASR #2
    CMP  W27, #0x512
    CMP  W2, #0xd36
    CMN  W16, W14, SXTB #0
    CMP  X28, #0xfdc
    CMN  W17, W19, ASR #23
    CMN  X15, #0xb45, LSL #12
    CMP  X12, X20, SXTX #1
    CMN  W27, W24, LSL #27
    CMP  X20, X2, LSR #40
    CCMN  X20, X4, #0x9, PL
    CMP  W12, W2, SXTW #0
    CCMP  W28, W3, #0x8, CC
    CMN  X19, #0xd03, LSL #12
    CCMP  W2, #0x1b, #0xb, LE
    CCMP  X18, #0x7, #0x1, CS
    CMP  W17, W27, LSR #27
    CMN  W11, W14, SXTW #1
    CCMN  W11, W5, #0xa, LS
    CCMN  X5, #0x1a, #0x0, LS
    CMN  W28, #0xae1
    CMP  W29, W29, UXTH #2
    CCMP  W28, W9, #0x5, PL
    CCMP  W28, W2, #0x5, LT
    CCMP  W26, W22, #0x7, AL
    CMN  W18, #0x972
    CCMP  X28, X4, #0xb, VC
    CMP  W15, W11, UXTW #3
    CMP  W9, W10, SXTB #1
    CMN  X17, X2, LSL #27
    CMN  W21, W29, LSR #6
    CMN  X20, #0x8fa, LSL #12
    CMN  X2, #0x9c7, LSL #12
    CMN  W14, #0x50
    CMN  X12, X3
    CMP  X29, W12, UXTH #4
    CMN  W18, #0x156
    CCMP  X22, #0x17, #0x0, CC
    CCMN  W11, #0xa, #0xb, EQ
    CCMP  X5, X5, #0xf, LT
    CMP  W21, #0x3ea, LSL #12
    CMP  X24, W17, UXTW #2
    CMP  W16, W9, LSL #30
    CCMN  X18, #0x7, #0x4, CS
    CMN  X10, #0x261, LSL #12
    CMP  W26, #0xbae
    CMN  W29, W26, SXTH #3
    CCMP  X22, X11, #0x3, CC
    CMN  W29, #0x42d
    CMN  X17, #0x92c, LSL #12
    CMN  W9, W3, SXTB #0
    CCMN  W16, #0x4, #0x8, MI
    CMN  X26, W18, SXTW #4
    CMN  W2, W9, LSR #29
    CMN  X9, X27, LSL #56
    CMP  W15, W3, SXTB #0
    CMN  X4, X15, ASR #36
    CMN  X21, #0xf65, LSL #12
    CCMN  X4, X27, #0x6, NE
    CMN  W29, W4, SXTW #1
    CMP  X14, X9, SXTX #3
    CCMN  X17, X15, #0x6, CS
    CCMP  W19, W16, #0x3, CC
    CCMN  W3, W17, #0x2, LT
    CMP  W15, #0x839
    CCMN  X19, X15, #0x6, MI
    CCMP  W29, W16, #0xb, LS
    CMN  W12, W17, SXTB #4
    CMN  W5, #0x55b
    CCMP  W26, W29, #0xb, VC
    CMN  X29, X22, LSR #35
    SUBS  X20, X20, #0x1
    B.NE  TSRTIntCompare_label_19
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCompare_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCompare_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
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
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
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
    MOVZ  X20, #0xf, LSL #0
TSRTIntCompare_label_20:
    CMP  W21, #0x326, LSL #12
    CMP  W28, #0x7
    CMN  W27, W27, LSL #3
    CCMP  X20, #0x1c, #0xf, LE
    CMP  X29, W22, UXTH #2
    CCMN  W26, W26, #0x8, CS
    CCMN  W22, W4, #0xf, GT
    CMP  W14, #0x2f5, LSL #12
    CMP  X7, W19, SXTH #4
    CMP  X10, X9, LSR #45
    CMP  W11, W16, SXTW #1
    CCMN  X7, #0x9, #0xc, NV
    CMN  W24, W20, UXTH #2
    CCMP  W28, #0x19, #0x0, MI
    CCMN  W3, #0x1f, #0xe, NV
    CCMP  X7, #0x1, #0x2, LE
    CMP  X3, W17, SXTB #4
    CMP  W14, W24, LSR #26
    CCMN  W22, #0x1c, #0xa, CS
    CMN  X28, #0xc51, LSL #12
    CMN  W16, W13, SXTW #2
    CCMP  X29, #0x16, #0x2, AL
    CCMP  X2, X17, #0xe, PL
    CMN  W18, W19, LSR #9
    CCMP  X20, X10, #0x1, LE
    CMN  W2, #0xe37
    CCMN  X21, #0x11, #0xb, VC
    CMP  X2, X9, LSR #6
    CMN  W9, W13, LSR #25
    CMN  X4, #0x261
    CMP  X14, #0xc8
    CMN  W16, W14, UXTX #1
    CMN  W28, #0x3be
    CCMP  W26, W26, #0x3, NE
    CMP  W4, W2, ASR #0
    CCMN  W29, #0x6, #0xe, NV
    CMP  X22, #0xdde
    CMN  X14, W21, SXTW #1
    CCMN  W20, W4, #0xb, MI
    CCMP  W12, W24, #0xb, GT
    CMN  X7, W2, UXTB #1
    CMN  W16, #0xac2, LSL #12
    CMN  X16, X29, ASR #29
    CMP  W9, W13, LSR #2
    CMP  X11, #0xd20, LSL #12
    CMN  W10, W10, UXTW #0
    CMP  X16, X7, UXTX #1
    CMP  X24, W13, UXTW #3
    CCMN  X2, #0x19, #0x1, AL
    CCMP  X4, X14, #0xa, LS
    CCMN  W18, W4, #0x4, MI
    CMP  W4, #0x48a
    CMN  X26, W28, UXTB #1
    CCMP  W18, W27, #0x9, GT
    CMP  X3, #0xcc4
    CMP  W19, W12, SXTX #3
    CMN  X7, W28, SXTH #3
    CCMN  X9, #0x18, #0x3, LE
    CMN  W27, W22, LSR #10
    CMN  X26, #0xbde, LSL #12
    CMN  X9, W27, SXTH #1
    CCMN  W21, #0x17, #0x7, NV
    CMN  X11, X28, LSR #61
    CCMN  W11, #0x14, #0xc, EQ
    CMP  W14, #0x14a, LSL #12
    CCMP  X7, X10, #0x2, LE
    CMN  X14, W12, SXTW #0
    CMN  W16, W29, LSL #7
    CMP  W3, W24, UXTX #3
    CCMN  W11, W14, #0xa, CC
    CCMP  W10, #0x15, #0x0, PL
    CCMP  X19, X3, #0x4, NE
    CCMN  X26, #0x10, #0x5, CS
    CCMP  X17, X26, #0x8, GT
    CCMP  X21, X10, #0xd, AL
    CCMN  W2, W21, #0x7, GT
    CCMP  X24, X17, #0x5, MI
    CCMP  X2, #0x1e, #0xb, EQ
    CCMP  X22, X2, #0xf, NE
    CMP  X12, X10, LSR #63
    CMN  W29, W14, SXTH #0
    CMN  W22, W17, SXTB #3
    CMN  X22, X13, LSL #45
    CMP  X26, X9, LSL #12
    CMN  W24, #0x124
    CMP  X9, W17, UXTW #2
    CMN  X20, #0x1f7, LSL #12
    CCMN  X20, X2, #0x4, CC
    CCMP  W11, W3, #0x9, PL
    CMP  W14, W11, SXTH #2
    CCMN  W18, #0x1f, #0x3, GT
    CMN  X29, X19, ASR #51
    CCMN  W13, W18, #0x8, HI
    CMN  W3, W24, SXTW #1
    CMP  W17, W27, UXTB #1
    CMN  W20, W14, LSL #22
    CMN  W9, W11, LSR #5
    CMN  W16, W2, LSR #9
    CMN  X2, X29, ASR #53
    CMP  X28, W16, SXTB #4
    CCMP  X11, X28, #0x9, LE
    CMN  X11, #0x135, LSL #12
    CCMP  W26, #0x6, #0x8, GE
    CMP  W12, #0xf45
    CMP  W7, W13, UXTH #1
    CMP  X7, X24, UXTX #4
    CCMN  X12, #0x13, #0x1, HI
    CCMP  W13, W24, #0x0, NV
    CCMP  W19, W17, #0x1, LE
    CCMP  X22, #0x0, #0xd, NE
    CMP  W3, W12, SXTW #3
    CCMN  W16, W2, #0x7, VC
    CCMN  W4, #0x3, #0x9, LT
    CCMP  W11, #0x17, #0x8, NE
    CMN  X2, W14, SXTW #2
    CCMP  W7, #0x3, #0x6, LE
    CMN  W3, W18, SXTX #2
    CCMP  W13, #0xd, #0xd, NV
    CCMN  X17, X13, #0xc, NE
    CCMP  X13, X17, #0x5, LT
    CMN  W19, W12, UXTX #0
    CMN  X22, W14, UXTW #4
    CMN  X21, X14, LSL #5
    CMN  X28, #0xecd, LSL #12
    CMN  W18, W7, SXTH #4
    CCMP  W16, #0x12, #0xb, HI
    CMN  W27, #0xc43
    CMN  W21, W11, LSR #31
    CCMN  X3, #0x14, #0x1, GT
    CMN  X17, X28, UXTX #4
    CMP  W29, W24, UXTW #0
    CCMP  X14, #0x0, #0x4, HI
    CCMP  W4, W9, #0x9, CS
    CMN  X14, W20, UXTB #2
    CCMN  X19, X11, #0xc, NE
    CMP  X2, W27, SXTW #2
    CMP  W19, W28, LSL #14
    CCMP  X21, #0x18, #0xa, LE
    CCMP  W2, W19, #0xa, VC
    CMN  X9, #0xcfd, LSL #12
    CCMP  X18, X17, #0x3, VS
    CMP  W22, W26, LSL #2
    CCMN  W19, W3, #0xb, LT
    CCMN  W26, W28, #0x1, EQ
    CMN  X18, #0x8d6
    CMP  X17, W9, UXTH #0
    CCMP  W24, #0x1b, #0xc, VS
    CMP  X26, #0x7e0, LSL #12
    CMN  X13, X16, LSR #14
    CCMP  W9, #0x14, #0x6, CC
    CMP  W16, #0x8e1, LSL #12
    CMP  W18, #0x8a1
    CMN  W4, #0x306
    CMP  W19, #0xf64
    CMN  W27, W18, SXTW #1
    CMP  W11, W27, LSR #29
    CMP  W17, W13, UXTH #2
    CMN  W10, #0x98d
    CMN  W11, #0xf8f, LSL #12
    CMP  X7, #0x809, LSL #12
    CCMN  W14, W29, #0x3, NV
    CCMP  X20, #0x1, #0xc, AL
    CCMN  W17, W27, #0x4, AL
    CMN  X7, X19, LSL #38
    CCMN  W13, #0x7, #0x9, VC
    CMP  W29, W28, ASR #22
    CMN  X28, #0x702
    CCMN  X3, X11, #0xf, CC
    CCMP  X24, X26, #0x3, PL
    CMP  X26, X22, ASR #22
    CMN  X9, X19, LSR #57
    CCMP  X26, X22, #0x2, EQ
    CCMP  W22, #0x1a, #0xa, EQ
    CMP  W22, #0x434, LSL #12
    CMP  X4, #0xe7b, LSL #12
    CCMN  W12, #0xd, #0x2, NV
    CMP  W18, W4, LSL #1
    CMN  W4, #0xa4f, LSL #12
    CMN  W4, W17, UXTB #0
    CCMP  X4, #0x1c, #0xe, AL
    CMN  X9, X13, LSR #38
    CCMP  X18, #0x19, #0xf, EQ
    CMP  X9, X11, LSR #38
    CCMP  X24, #0x10, #0xd, NV
    CMP  X26, X4, ASR #57
    CMP  W21, W20, UXTH #3
    CCMN  W16, W28, #0x7, AL
    CCMN  X3, X4, #0x6, LS
    CMP  X19, W13, SXTB #0
    CMN  X10, #0x783
    CMP  X24, #0x5d3
    CMP  W17, W19, LSL #28
    CMP  W4, #0x865, LSL #12
    CMN  X21, W24, UXTB #0
    CCMP  W14, W9, #0x6, CS
    CCMP  W9, #0x18, #0x7, NE
    CCMP  X19, X10, #0x1, CS
    CMP  X14, X19, ASR #53
    CMN  W7, #0xafa, LSL #12
    CMP  X29, #0x72f, LSL #12
    SUBS  X20, X20, #0x1
    B.NE  TSRTIntCompare_label_20
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X5, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X5, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X5, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X5, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X5, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X5, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X5, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X5, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X5, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X5, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X5, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X5, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X5, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X5, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X5, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X5, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X5, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X5, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X5, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X5, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail

TSRTIntCompare_TestEnd:
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
TSRTIntCompare_TestFail:
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
