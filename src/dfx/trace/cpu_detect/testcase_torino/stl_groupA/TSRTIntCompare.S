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
    MOVZ  X2, #0x15ea, LSL #0
    MOVK  X2, #0xf632, LSL #16
    MOVK  X2, #0x86a9, LSL #32
    MOVK  X2, #0x3211, LSL #48
    MOVZ  X3, #0x39c0, LSL #0
    MOVK  X3, #0x83c4, LSL #16
    MOVK  X3, #0x3c7f, LSL #32
    MOVK  X3, #0x4e12, LSL #48
    MOVZ  X4, #0x1a7, LSL #0
    MOVK  X4, #0xa86, LSL #16
    MOVK  X4, #0x37c7, LSL #32
    MOVK  X4, #0x41e5, LSL #48
    MOVZ  X5, #0x4c62, LSL #0
    MOVK  X5, #0x9b86, LSL #16
    MOVK  X5, #0x9f5f, LSL #32
    MOVK  X5, #0x8e58, LSL #48
    MOVZ  X6, #0x77ee, LSL #0
    MOVK  X6, #0x9b23, LSL #16
    MOVK  X6, #0x46ca, LSL #32
    MOVK  X6, #0x2d90, LSL #48
    MOVZ  X7, #0xe80d, LSL #0
    MOVK  X7, #0x8c1e, LSL #16
    MOVK  X7, #0x5ea7, LSL #32
    MOVK  X7, #0x228e, LSL #48
    MOVZ  X10, #0xab9a, LSL #0
    MOVK  X10, #0xe55d, LSL #16
    MOVK  X10, #0xb1ba, LSL #32
    MOVK  X10, #0xa155, LSL #48
    MOVZ  X13, #0x7fa0, LSL #0
    MOVK  X13, #0x7ebe, LSL #16
    MOVK  X13, #0xf6a1, LSL #32
    MOVK  X13, #0xed45, LSL #48
    MOVZ  X15, #0x23ac, LSL #0
    MOVK  X15, #0x1fcd, LSL #16
    MOVK  X15, #0x9e3a, LSL #32
    MOVK  X15, #0x40d9, LSL #48
    MOVZ  X16, #0x14b6, LSL #0
    MOVK  X16, #0x356e, LSL #16
    MOVK  X16, #0xe2b5, LSL #32
    MOVK  X16, #0x9067, LSL #48
    MOVZ  X17, #0x59d9, LSL #0
    MOVK  X17, #0x5a55, LSL #16
    MOVK  X17, #0x3460, LSL #32
    MOVK  X17, #0x50bb, LSL #48
    MOVZ  X18, #0x6e2e, LSL #0
    MOVK  X18, #0xcc8e, LSL #16
    MOVK  X18, #0x2eb4, LSL #32
    MOVK  X18, #0x8ad8, LSL #48
    MOVZ  X19, #0xf37c, LSL #0
    MOVK  X19, #0xfdf2, LSL #16
    MOVK  X19, #0x9a9d, LSL #32
    MOVK  X19, #0xc22d, LSL #48
    MOVZ  X20, #0x4e78, LSL #0
    MOVK  X20, #0xc906, LSL #16
    MOVK  X20, #0x6975, LSL #32
    MOVK  X20, #0x2206, LSL #48
    MOVZ  X21, #0xd0f5, LSL #0
    MOVK  X21, #0x2fb, LSL #16
    MOVK  X21, #0x9dd1, LSL #32
    MOVK  X21, #0x6606, LSL #48
    MOVZ  X22, #0x35c2, LSL #0
    MOVK  X22, #0x7740, LSL #16
    MOVK  X22, #0x7060, LSL #32
    MOVK  X22, #0x962b, LSL #48
    MOVZ  X23, #0x2813, LSL #0
    MOVK  X23, #0x5ef6, LSL #16
    MOVK  X23, #0xa372, LSL #32
    MOVK  X23, #0x5dd0, LSL #48
    MOVZ  X24, #0xea8c, LSL #0
    MOVK  X24, #0x9aba, LSL #16
    MOVK  X24, #0x3b05, LSL #32
    MOVK  X24, #0x2eed, LSL #48
    MOVZ  X25, #0x25f3, LSL #0
    MOVK  X25, #0x2e13, LSL #16
    MOVK  X25, #0x7de4, LSL #32
    MOVK  X25, #0xa96a, LSL #48
    MOVZ  X26, #0xcbf7, LSL #0
    MOVK  X26, #0xe707, LSL #16
    MOVK  X26, #0x518f, LSL #32
    MOVK  X26, #0x2338, LSL #48
    MOVZ  X27, #0x97ee, LSL #0
    MOVK  X27, #0xca0c, LSL #16
    MOVK  X27, #0x5be6, LSL #32
    MOVK  X27, #0xd7b2, LSL #48
    MOVZ  X28, #0x2988, LSL #0
    MOVK  X28, #0x8870, LSL #16
    MOVK  X28, #0x3f18, LSL #32
    MOVK  X28, #0xaa7b, LSL #48
    MOVZ  X29, #0x9df0, LSL #0
    MOVK  X29, #0xc1c9, LSL #16
    MOVK  X29, #0x6979, LSL #32
    MOVK  X29, #0xb200, LSL #48
    ADDS  W23, W28, W26, SXTW #1
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0xbbbe, LSL #0
    MOVK  X2, #0xc72c, LSL #16
    MOVK  X2, #0x1198, LSL #32
    MOVK  X2, #0xae92, LSL #48
    MOVZ  X3, #0x9612, LSL #0
    MOVK  X3, #0xcbd2, LSL #16
    MOVK  X3, #0x8231, LSL #32
    MOVK  X3, #0x6b23, LSL #48
    MOVZ  X4, #0x6d61, LSL #0
    MOVK  X4, #0xe0eb, LSL #16
    MOVK  X4, #0x3a58, LSL #32
    MOVK  X4, #0x47a1, LSL #48
    MOVZ  X5, #0xdbf7, LSL #0
    MOVK  X5, #0x6078, LSL #16
    MOVK  X5, #0x79f8, LSL #32
    MOVK  X5, #0x149c, LSL #48
    MOVZ  X6, #0x58ea, LSL #0
    MOVK  X6, #0x2de4, LSL #16
    MOVK  X6, #0xc8fc, LSL #32
    MOVK  X6, #0xbef6, LSL #48
    MOVZ  X7, #0xa021, LSL #0
    MOVK  X7, #0x83ea, LSL #16
    MOVK  X7, #0x368a, LSL #32
    MOVK  X7, #0x3953, LSL #48
    MOVZ  X10, #0x135d, LSL #0
    MOVK  X10, #0x4a3c, LSL #16
    MOVK  X10, #0x2394, LSL #32
    MOVK  X10, #0x750, LSL #48
    MOVZ  X13, #0x541a, LSL #0
    MOVK  X13, #0x7c52, LSL #16
    MOVK  X13, #0x7622, LSL #32
    MOVK  X13, #0xc0ed, LSL #48
    MOVZ  X15, #0xcac2, LSL #0
    MOVK  X15, #0x8161, LSL #16
    MOVK  X15, #0x1b76, LSL #32
    MOVK  X15, #0x6ec1, LSL #48
    MOVZ  X16, #0xcf0, LSL #0
    MOVK  X16, #0x1aa, LSL #16
    MOVK  X16, #0xde22, LSL #32
    MOVK  X16, #0xe6ff, LSL #48
    MOVZ  X17, #0x4351, LSL #0
    MOVK  X17, #0xff26, LSL #16
    MOVK  X17, #0x1322, LSL #32
    MOVK  X17, #0xf0b9, LSL #48
    MOVZ  X18, #0xe666, LSL #0
    MOVK  X18, #0xe110, LSL #16
    MOVK  X18, #0xbac0, LSL #32
    MOVK  X18, #0xd7e, LSL #48
    MOVZ  X19, #0x7e9d, LSL #0
    MOVK  X19, #0x9cc3, LSL #16
    MOVK  X19, #0xe95, LSL #32
    MOVK  X19, #0x2472, LSL #48
    MOVZ  X20, #0x4f3f, LSL #0
    MOVK  X20, #0x13c8, LSL #16
    MOVK  X20, #0x7954, LSL #32
    MOVK  X20, #0x7097, LSL #48
    MOVZ  X21, #0x33e7, LSL #0
    MOVK  X21, #0x2153, LSL #16
    MOVK  X21, #0x67ad, LSL #32
    MOVK  X21, #0xb0ab, LSL #48
    MOVZ  X22, #0xcc4b, LSL #0
    MOVK  X22, #0xa688, LSL #16
    MOVK  X22, #0x20d7, LSL #32
    MOVK  X22, #0x9e4c, LSL #48
    MOVZ  X23, #0x73c, LSL #0
    MOVK  X23, #0x6d8b, LSL #16
    MOVK  X23, #0x183e, LSL #32
    MOVK  X23, #0x2a14, LSL #48
    MOVZ  X24, #0x7f4a, LSL #0
    MOVK  X24, #0x911, LSL #16
    MOVK  X24, #0xbc7e, LSL #32
    MOVK  X24, #0xe4a0, LSL #48
    MOVZ  X25, #0x16a6, LSL #0
    MOVK  X25, #0x890b, LSL #16
    MOVK  X25, #0x7839, LSL #32
    MOVK  X25, #0xbcbd, LSL #48
    MOVZ  X26, #0x1fed, LSL #0
    MOVK  X26, #0xfabe, LSL #16
    MOVK  X26, #0xedf6, LSL #32
    MOVK  X26, #0x5271, LSL #48
    MOVZ  X27, #0x743d, LSL #0
    MOVK  X27, #0xb969, LSL #16
    MOVK  X27, #0x9e37, LSL #32
    MOVK  X27, #0x9419, LSL #48
    MOVZ  X28, #0x5593, LSL #0
    MOVK  X28, #0x42fd, LSL #16
    MOVK  X28, #0xc64, LSL #32
    MOVK  X28, #0x786f, LSL #48
    MOVZ  X29, #0x2019, LSL #0
    MOVK  X29, #0x6424, LSL #16
    MOVK  X29, #0x1c37, LSL #32
    MOVK  X29, #0x96b8, LSL #48
    CCMN  W10, #0x1c, #0xd, MI
    CCMN  W10, #0x7, #0x6, NV
    CCMN  W19, #0xc, #0x4, AL
    CCMN  W26, #0x9, #0xf, NV
    CCMN  W3, #0x12, #0x0, VS
    CCMN  W25, #0x19, #0xd, HI
    CCMN  W27, #0x19, #0x1, LS
    CCMN  W6, #0x1, #0x2, PL
    CCMN  W6, #0x6, #0xd, GT
    CCMN  W28, #0xb, #0xa, CC
    CCMN  X25, #0x10, #0xe, LT
    CCMN  X22, #0x0, #0x9, LE
    CCMN  X5, #0x14, #0x5, GE
    CCMN  X27, #0x12, #0xf, NV
    CCMN  X22, #0x1, #0xd, AL
    CCMN  X17, #0x6, #0xe, PL
    CCMN  X28, #0x16, #0x5, CS
    CCMN  X7, #0x11, #0x5, CS
    CCMN  X17, #0x0, #0xa, CC
    CCMN  X26, #0x0, #0xb, LE
    CCMN  W10, W25, #0x0, VC
    CCMN  W27, W3, #0x1, GT
    CCMN  W7, W13, #0xa, MI
    CCMN  W15, W22, #0x7, GE
    CCMN  W17, W7, #0x8, HI
    CCMN  W26, W25, #0xf, GT
    CCMN  W27, W18, #0x1, NV
    CCMN  W28, W25, #0x0, LE
    CCMN  W7, W17, #0xa, GT
    CCMN  W10, W25, #0x5, CC
    CCMN  X13, X15, #0x5, VS
    CCMN  X22, X24, #0xe, CS
    CCMN  X10, X27, #0xb, VS
    CCMN  X17, X6, #0x1, PL
    CCMN  X20, X26, #0x3, VC
    CCMN  X24, X10, #0x5, NE
    CCMN  X17, X5, #0xf, VS
    CCMN  X19, X18, #0xf, NE
    CCMN  X7, X4, #0x2, GT
    CCMN  X27, X20, #0xe, PL
    CCMP  W10, #0x1c, #0xa, LE
    CCMP  W22, #0x1a, #0xd, MI
    CCMP  W13, #0x16, #0x9, VC
    CCMP  W3, #0x2, #0xb, HI
    CCMP  W28, #0x1, #0x6, VS
    CCMP  W21, #0x8, #0xc, EQ
    CCMP  W25, #0x3, #0xd, EQ
    CCMP  W28, #0x15, #0xd, GT
    CCMP  W2, #0x12, #0xa, PL
    CCMP  W19, #0x14, #0xa, GT
    CCMP  X7, #0x19, #0x2, GE
    CCMP  X26, #0x1c, #0x9, PL
    CCMP  X20, #0x1f, #0x8, GT
    CCMP  X18, #0x12, #0x5, LT
    CCMP  X22, #0x12, #0xf, GE
    CCMP  X16, #0xe, #0x7, LE
    CCMP  X26, #0x1b, #0xc, VC
    CCMP  X27, #0x18, #0x6, PL
    CCMP  X22, #0x17, #0xf, LS
    CCMP  X5, #0x1c, #0x4, LT
    CCMP  W10, W22, #0xd, LT
    CCMP  W27, W4, #0x2, LT
    CCMP  W15, W7, #0x9, NV
    CCMP  W4, W21, #0x8, NV
    CCMP  W17, W7, #0xf, HI
    CCMP  W21, W18, #0x3, CS
    CCMP  W26, W19, #0xd, NV
    CCMP  W5, W26, #0xb, EQ
    CCMP  W3, W7, #0x8, AL
    CCMP  W20, W13, #0xf, LS
    CCMP  X21, X7, #0x5, GE
    CCMP  X17, X10, #0x5, GT
    CCMP  X26, X27, #0xc, MI
    CCMP  X7, X15, #0xe, EQ
    CCMP  X27, X25, #0xf, GE
    CCMP  X26, X18, #0x5, VC
    CCMP  X15, X5, #0xa, EQ
    CCMP  X21, X16, #0x4, CC
    CCMP  X24, X13, #0xb, NV
    CCMP  X5, X22, #0x1, CC
    CMN  W16, W20, SXTB #2
    CMN  W10, W17, SXTB #2
    CMN  W27, W7, SXTB #4
    CMN  W10, W21, UXTH #1
    CMN  W10, W26, SXTW #4
    CMN  W21, W3, UXTW #2
    CMN  W4, W19, UXTB #0
    CMN  W16, W15, UXTW #3
    CMN  W20, W21, SXTH #4
    CMN  W21, W20, UXTB #3
    CMN  X26, X5, UXTX #4
    CMN  X20, W17, SXTB #2
    CMN  X26, W15, UXTH #3
    CMN  X22, X24, SXTX #4
    CMN  X16, W21, SXTB #1
    CMN  X27, W20, UXTW #1
    CMN  X4, W10, SXTW #1
    CMN  X22, W19, SXTH #4
    CMN  X21, W22, UXTW #4
    CMN  X24, W2, SXTW #1
    CMN  W21, #0xc13, LSL #12
    CMN  W6, #0x50b, LSL #12
    CMN  W2, #0x42c, LSL #12
    CMN  W24, #0x537, LSL #12
    CMN  W15, #0x661
    CMN  W27, #0x5fb
    CMN  W5, #0x287, LSL #12
    CMN  W5, #0xa97
    CMN  W18, #0xc99
    CMN  W3, #0x39a
    CMN  X19, #0x300, LSL #12
    CMN  X28, #0xad5, LSL #12
    CMN  X22, #0x2bb, LSL #12
    CMN  X15, #0xd0b, LSL #12
    CMN  X28, #0x21d
    CMN  X20, #0xb29, LSL #12
    CMN  X16, #0x647
    CMN  X10, #0xddb
    CMN  X2, #0x645, LSL #12
    CMN  X25, #0x5ac, LSL #12
    CMN  W3, W2, LSL #6
    CMN  W28, W6, LSL #20
    CMN  W19, W3, ASR #8
    CMN  W3, W21, LSL #9
    CMN  W7, W26, ASR #3
    CMN  W26, W19, ASR #13
    CMN  W17, W6, LSR #25
    CMN  W25, W24, LSL #7
    CMN  W18, W19, LSL #25
    CMN  W15, W17, LSR #17
    CMN  X16, X21, ASR #40
    CMN  X20, X4, LSL #11
    CMN  X4, X24, LSR #57
    CMN  X18, X2, ASR #43
    CMN  X17, X26, LSR #41
    CMN  X7, X10, LSL #16
    CMN  X20, X22, LSL #36
    CMN  X7, X16, LSL #58
    CMN  X16, X10, ASR #16
    CMN  X18, X5, ASR #13
    CMP  W3, W22, SXTH #4
    CMP  W2, W16, SXTX #4
    CMP  W20, W25, SXTX #3
    CMP  W18, W2, UXTH #4
    CMP  W10, W2, SXTW #0
    CMP  W27, W18, UXTW #3
    CMP  W10, W4, SXTW #2
    CMP  W18, W7, UXTW #1
    CMP  W21, W7, UXTX #1
    CMP  W4, W25, UXTB #4
    CMP  X17, W24, UXTB #3
    CMP  X17, W17, UXTW #2
    CMP  X5, W24, UXTB #1
    CMP  X16, W13, SXTW #4
    CMP  X20, W4, SXTH #2
    CMP  X22, W24, SXTH #4
    CMP  X27, W28, UXTH #1
    CMP  X22, W24, SXTH #0
    CMP  X26, W19, UXTW #4
    CMP  X13, W7, UXTB #0
    CMP  W20, #0xcae, LSL #12
    CMP  W24, #0x35b, LSL #12
    CMP  W10, #0xd63
    CMP  W17, #0x4a9
    CMP  W4, #0xb2a, LSL #12
    CMP  W20, #0x932
    CMP  W10, #0xb92
    CMP  W26, #0xaaa, LSL #12
    CMP  W6, #0x835
    CMP  W10, #0xa20
    CMP  X4, #0x2c6, LSL #12
    CMP  X22, #0xc47
    CMP  X21, #0xf86, LSL #12
    CMP  X28, #0x918
    CMP  X6, #0xf76
    CMP  X19, #0xc1d
    CMP  X5, #0xb24
    CMP  X10, #0xaaa
    CMP  X21, #0x536, LSL #12
    CMP  X15, #0x4d9
    CMP  W24, W6, LSL #15
    CMP  W20, W5, LSL #5
    CMP  W4, W10, LSR #5
    CMP  W24, W7, ASR #21
    CMP  W15, W18, ASR #30
    CMP  W6, W22, ASR #9
    CMP  W6, W26, LSR #8
    CMP  W24, W6, LSL #20
    CMP  W10, W26, ASR #24
    CMP  W22, W5, LSR #11
    CMP  X2, X21, ASR #25
    CMP  X21, X24, LSL #34
    CMP  X2, X17, ASR #49
    CMP  X25, X17, LSL #11
    CMP  X28, X18, ASR #37
    CMP  X6, X19, LSR #5
    CMP  X28, X21, LSL #43
    CMP  X2, X6, LSL #42
    CMP  X18, X28, LSL #54
    CMP  X20, X27, LSR #16
    MOVZ  X23, #0xbbbe, LSL #0
    MOVK  X23, #0xc72c, LSL #16
    MOVK  X23, #0x1198, LSL #32
    MOVK  X23, #0xae92, LSL #48
    SUB  X29, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCompare_TestFail
    MOVZ  X23, #0x9612, LSL #0
    MOVK  X23, #0xcbd2, LSL #16
    MOVK  X23, #0x8231, LSL #32
    MOVK  X23, #0x6b23, LSL #48
    SUB  X29, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCompare_TestFail
    MOVZ  X23, #0x6d61, LSL #0
    MOVK  X23, #0xe0eb, LSL #16
    MOVK  X23, #0x3a58, LSL #32
    MOVK  X23, #0x47a1, LSL #48
    SUB  X29, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCompare_TestFail
    MOVZ  X23, #0xdbf7, LSL #0
    MOVK  X23, #0x6078, LSL #16
    MOVK  X23, #0x79f8, LSL #32
    MOVK  X23, #0x149c, LSL #48
    SUB  X29, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCompare_TestFail
    MOVZ  X23, #0x58ea, LSL #0
    MOVK  X23, #0x2de4, LSL #16
    MOVK  X23, #0xc8fc, LSL #32
    MOVK  X23, #0xbef6, LSL #48
    SUB  X29, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCompare_TestFail
    MOVZ  X23, #0xa021, LSL #0
    MOVK  X23, #0x83ea, LSL #16
    MOVK  X23, #0x368a, LSL #32
    MOVK  X23, #0x3953, LSL #48
    SUB  X29, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCompare_TestFail
    MOVZ  X23, #0x135d, LSL #0
    MOVK  X23, #0x4a3c, LSL #16
    MOVK  X23, #0x2394, LSL #32
    MOVK  X23, #0x750, LSL #48
    SUB  X29, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCompare_TestFail
    MOVZ  X23, #0x541a, LSL #0
    MOVK  X23, #0x7c52, LSL #16
    MOVK  X23, #0x7622, LSL #32
    MOVK  X23, #0xc0ed, LSL #48
    SUB  X29, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCompare_TestFail
    MOVZ  X23, #0xcac2, LSL #0
    MOVK  X23, #0x8161, LSL #16
    MOVK  X23, #0x1b76, LSL #32
    MOVK  X23, #0x6ec1, LSL #48
    SUB  X29, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCompare_TestFail
    MOVZ  X23, #0xcf0, LSL #0
    MOVK  X23, #0x1aa, LSL #16
    MOVK  X23, #0xde22, LSL #32
    MOVK  X23, #0xe6ff, LSL #48
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCompare_TestFail
    MOVZ  X23, #0x4351, LSL #0
    MOVK  X23, #0xff26, LSL #16
    MOVK  X23, #0x1322, LSL #32
    MOVK  X23, #0xf0b9, LSL #48
    SUB  X29, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCompare_TestFail
    MOVZ  X23, #0xe666, LSL #0
    MOVK  X23, #0xe110, LSL #16
    MOVK  X23, #0xbac0, LSL #32
    MOVK  X23, #0xd7e, LSL #48
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCompare_TestFail
    MOVZ  X23, #0x7e9d, LSL #0
    MOVK  X23, #0x9cc3, LSL #16
    MOVK  X23, #0xe95, LSL #32
    MOVK  X23, #0x2472, LSL #48
    SUB  X29, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCompare_TestFail
    MOVZ  X23, #0x4f3f, LSL #0
    MOVK  X23, #0x13c8, LSL #16
    MOVK  X23, #0x7954, LSL #32
    MOVK  X23, #0x7097, LSL #48
    SUB  X29, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCompare_TestFail
    MOVZ  X23, #0x33e7, LSL #0
    MOVK  X23, #0x2153, LSL #16
    MOVK  X23, #0x67ad, LSL #32
    MOVK  X23, #0xb0ab, LSL #48
    SUB  X29, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCompare_TestFail
    MOVZ  X23, #0xcc4b, LSL #0
    MOVK  X23, #0xa688, LSL #16
    MOVK  X23, #0x20d7, LSL #32
    MOVK  X23, #0x9e4c, LSL #48
    SUB  X29, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCompare_TestFail
    MOVZ  X23, #0x7f4a, LSL #0
    MOVK  X23, #0x911, LSL #16
    MOVK  X23, #0xbc7e, LSL #32
    MOVK  X23, #0xe4a0, LSL #48
    SUB  X29, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCompare_TestFail
    MOVZ  X23, #0x16a6, LSL #0
    MOVK  X23, #0x890b, LSL #16
    MOVK  X23, #0x7839, LSL #32
    MOVK  X23, #0xbcbd, LSL #48
    SUB  X29, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCompare_TestFail
    MOVZ  X23, #0x1fed, LSL #0
    MOVK  X23, #0xfabe, LSL #16
    MOVK  X23, #0xedf6, LSL #32
    MOVK  X23, #0x5271, LSL #48
    SUB  X29, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCompare_TestFail
    MOVZ  X23, #0x743d, LSL #0
    MOVK  X23, #0xb969, LSL #16
    MOVK  X23, #0x9e37, LSL #32
    MOVK  X23, #0x9419, LSL #48
    SUB  X29, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCompare_TestFail
    MOVZ  X23, #0x5593, LSL #0
    MOVK  X23, #0x42fd, LSL #16
    MOVK  X23, #0xc64, LSL #32
    MOVK  X23, #0x786f, LSL #48
    SUB  X29, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCompare_TestFail
    MOVZ  X2, #0x5e6c, LSL #0
    MOVK  X2, #0x5185, LSL #16
    MOVK  X2, #0x2c1e, LSL #32
    MOVK  X2, #0x5619, LSL #48
    MOVZ  X3, #0x553d, LSL #0
    MOVK  X3, #0x4277, LSL #16
    MOVK  X3, #0x2e5b, LSL #32
    MOVK  X3, #0x1731, LSL #48
    MOVZ  X4, #0x27e2, LSL #0
    MOVK  X4, #0xdaff, LSL #16
    MOVK  X4, #0xbdba, LSL #32
    MOVK  X4, #0x585b, LSL #48
    MOVZ  X5, #0x5355, LSL #0
    MOVK  X5, #0x728d, LSL #16
    MOVK  X5, #0x24e4, LSL #32
    MOVK  X5, #0xe5e0, LSL #48
    MOVZ  X6, #0x94b2, LSL #0
    MOVK  X6, #0x9a60, LSL #16
    MOVK  X6, #0xf311, LSL #32
    MOVK  X6, #0x1d45, LSL #48
    MOVZ  X7, #0xede6, LSL #0
    MOVK  X7, #0xcd3d, LSL #16
    MOVK  X7, #0xf341, LSL #32
    MOVK  X7, #0xe3b1, LSL #48
    MOVZ  X10, #0xa5f5, LSL #0
    MOVK  X10, #0x20a2, LSL #16
    MOVK  X10, #0xdc4a, LSL #32
    MOVK  X10, #0xd322, LSL #48
    MOVZ  X13, #0xc9c0, LSL #0
    MOVK  X13, #0x8aec, LSL #16
    MOVK  X13, #0x4f39, LSL #32
    MOVK  X13, #0xd1a9, LSL #48
    MOVZ  X15, #0xb5ca, LSL #0
    MOVK  X15, #0xd1b6, LSL #16
    MOVK  X15, #0x210f, LSL #32
    MOVK  X15, #0x6118, LSL #48
    MOVZ  X16, #0xd85d, LSL #0
    MOVK  X16, #0xfc3d, LSL #16
    MOVK  X16, #0x2b, LSL #32
    MOVK  X16, #0xcd5c, LSL #48
    MOVZ  X17, #0xcc16, LSL #0
    MOVK  X17, #0xb041, LSL #16
    MOVK  X17, #0x4984, LSL #32
    MOVK  X17, #0x9f94, LSL #48
    MOVZ  X18, #0x3ab6, LSL #0
    MOVK  X18, #0x2872, LSL #16
    MOVK  X18, #0x2449, LSL #32
    MOVK  X18, #0xbb7f, LSL #48
    MOVZ  X19, #0x7fe6, LSL #0
    MOVK  X19, #0x9028, LSL #16
    MOVK  X19, #0x4d09, LSL #32
    MOVK  X19, #0xa55, LSL #48
    MOVZ  X20, #0xeb3e, LSL #0
    MOVK  X20, #0xf861, LSL #16
    MOVK  X20, #0x9a73, LSL #32
    MOVK  X20, #0xf582, LSL #48
    MOVZ  X21, #0xe1a1, LSL #0
    MOVK  X21, #0xf416, LSL #16
    MOVK  X21, #0x5484, LSL #32
    MOVK  X21, #0xf34c, LSL #48
    MOVZ  X22, #0x7818, LSL #0
    MOVK  X22, #0xa8ac, LSL #16
    MOVK  X22, #0x9fd3, LSL #32
    MOVK  X22, #0x4af7, LSL #48
    MOVZ  X23, #0xd142, LSL #0
    MOVK  X23, #0x56f2, LSL #16
    MOVK  X23, #0x6a3c, LSL #32
    MOVK  X23, #0x7eac, LSL #48
    MOVZ  X24, #0x6012, LSL #0
    MOVK  X24, #0x98f2, LSL #16
    MOVK  X24, #0x969e, LSL #32
    MOVK  X24, #0x8412, LSL #48
    MOVZ  X25, #0xe044, LSL #0
    MOVK  X25, #0xd712, LSL #16
    MOVK  X25, #0x68e, LSL #32
    MOVK  X25, #0x8129, LSL #48
    MOVZ  X26, #0xef4b, LSL #0
    MOVK  X26, #0xa7bd, LSL #16
    MOVK  X26, #0xe2f8, LSL #32
    MOVK  X26, #0xdaba, LSL #48
    MOVZ  X27, #0x5f91, LSL #0
    MOVK  X27, #0xb755, LSL #16
    MOVK  X27, #0xc4ac, LSL #32
    MOVK  X27, #0xa5dc, LSL #48
    MOVZ  X28, #0xdf2f, LSL #0
    MOVK  X28, #0x9ac5, LSL #16
    MOVK  X28, #0x1079, LSL #32
    MOVK  X28, #0x2843, LSL #48
    MOVZ  X29, #0x56bb, LSL #0
    MOVK  X29, #0x2333, LSL #16
    MOVK  X29, #0xaec, LSL #32
    MOVK  X29, #0x78f1, LSL #48
    MOVZ  X22, #0xa, LSL #0
TSRTIntCompare_label_0:
    CCMP  X10, #0x16, #0x1, HI
    CMP  X17, X24, LSR #50
    CCMP  W20, W25, #0xe, NE
    CMP  W27, W26, LSL #31
    CCMP  W13, #0x16, #0x9, CS
    CCMN  X22, #0x12, #0x6, CS
    CMP  W28, #0x8f1
    CCMP  X6, #0x13, #0xf, EQ
    CMP  W26, W13, UXTB #0
    CCMN  W15, #0x13, #0xe, GE
    CCMP  W3, #0x0, #0x1, GT
    CCMN  W20, #0x12, #0x5, VC
    CCMP  X3, #0x3, #0xd, MI
    CMP  X10, X27, UXTX #4
    CMN  X6, W5, SXTW #3
    CCMP  W13, W16, #0x2, LE
    CCMN  X24, X24, #0xa, EQ
    CMP  X10, X7, LSR #36
    CMN  W20, W7, LSR #0
    CMP  W4, W15, LSL #21
    CMP  W27, W20, SXTX #3
    CMN  W20, #0x917, LSL #12
    CMN  X18, X6, LSL #47
    CMN  X19, #0x93c, LSL #12
    CMN  W6, #0x49f
    CMP  X25, X18, ASR #58
    CMN  X2, #0x89a, LSL #12
    CCMN  W13, W18, #0x6, LS
    CMP  W2, W15, SXTW #3
    CMN  X10, #0x695, LSL #12
    CMN  W22, W26, SXTW #0
    CCMN  X3, X17, #0x4, GE
    CCMN  X24, X19, #0xd, MI
    CMN  W13, W3, LSR #7
    CCMN  X24, #0x14, #0x5, AL
    CMN  W24, W20, ASR #7
    CMN  X2, #0xd90
    CMP  X13, W18, UXTH #3
    CMN  X21, #0x283, LSL #12
    CMN  W3, W24, SXTH #0
    CMN  X19, #0x2c2
    CCMP  W27, #0x8, #0x2, NE
    CCMP  W27, W2, #0xe, CC
    CMN  W20, W2, LSL #30
    CCMP  X3, X21, #0x2, CC
    CMP  X20, W17, SXTB #2
    CCMP  W2, #0x7, #0xe, MI
    CMN  W25, #0xeb7, LSL #12
    CMN  W7, W25, LSR #4
    CMN  X7, W19, SXTB #1
    CMN  X27, X3, UXTX #2
    CMP  W28, #0xcf5
    CMN  W26, #0xa39
    CCMP  X22, X3, #0x7, AL
    CMN  W5, W16, SXTX #1
    CMP  X19, W20, UXTW #4
    CCMN  W20, W15, #0xd, GT
    CCMP  W15, #0x13, #0x4, MI
    CCMP  X19, #0x8, #0x3, GT
    CMN  W27, W21, SXTW #3
    CMN  W26, W26, SXTH #4
    CCMP  X13, #0x1b, #0x7, GE
    CMP  W17, #0x2fd, LSL #12
    CCMN  X19, #0x1a, #0x1, AL
    CCMN  X15, #0x16, #0xc, VC
    CCMN  X24, X20, #0xd, LT
    CMP  X17, W27, UXTB #4
    CMP  X24, X26, LSL #19
    CMP  X26, W22, UXTB #2
    CCMP  W7, #0x8, #0xe, LT
    CCMN  W2, W4, #0x8, VC
    CMP  X25, W7, UXTW #3
    CMN  X22, #0x6a3, LSL #12
    CCMP  W17, W6, #0xe, LS
    CMP  W13, W19, LSR #26
    CMP  X15, #0xac4, LSL #12
    CCMN  W17, #0x14, #0x0, EQ
    CCMP  X24, #0x0, #0xa, HI
    CCMN  W24, W24, #0xc, AL
    CCMN  X17, X6, #0x8, LT
    CMP  W19, W15, LSL #29
    CCMP  W4, #0x13, #0xc, GE
    CCMP  W5, #0x9, #0x1, CS
    CMP  W10, W27, LSL #20
    CMN  X2, W16, UXTH #4
    CCMN  W20, #0x4, #0xb, NE
    CCMP  X5, X19, #0xe, VC
    CMN  X21, #0x6ad
    CMP  W3, W22, SXTB #4
    CCMP  W20, W5, #0xa, HI
    CMP  X17, #0x719, LSL #12
    CMN  X21, X28, LSR #40
    CMP  W16, W20, UXTX #1
    CCMP  X16, #0x1c, #0x9, EQ
    CCMP  W27, #0x1d, #0x0, CC
    CMN  X4, X27, LSR #10
    CMP  W27, #0x222, LSL #12
    CCMP  X20, X27, #0x8, LT
    CCMN  W27, #0x15, #0x7, NV
    CCMN  W26, W5, #0x8, GE
    CCMN  X18, X25, #0xd, HI
    CMN  X27, W5, UXTH #2
    CMN  X15, W18, SXTH #0
    CMN  X13, W25, SXTW #3
    CMN  W10, W28, LSL #30
    CCMP  X27, #0xa, #0x9, CS
    CMN  X19, #0xeb0, LSL #12
    CCMN  W13, W13, #0xd, CS
    CMN  W25, W20, LSL #23
    CCMN  X16, #0x1, #0x6, HI
    CMN  W24, W5, LSL #9
    CMN  W24, W18, LSR #9
    CCMN  X16, #0x14, #0x9, LT
    CMP  X24, X16, LSR #3
    CCMP  X20, X25, #0xb, NV
    CCMP  W13, #0x10, #0xb, GT
    CMP  W24, #0xf2e
    CMP  X4, W2, UXTB #1
    CMP  X16, #0xbe2
    CMN  X5, W15, SXTB #4
    CCMN  X27, X10, #0x6, GE
    CCMP  W20, W24, #0x3, LS
    CCMN  W24, #0x11, #0xa, GT
    CCMN  W2, #0x6, #0x9, NE
    CCMP  X22, #0x4, #0xd, VC
    CCMP  W16, #0x9, #0xb, EQ
    CCMN  X16, #0x1a, #0xb, CC
    CCMN  X17, #0xd, #0x3, HI
    CCMP  X19, #0x1b, #0xc, HI
    CCMN  X19, X19, #0xc, NE
    CMP  X26, X25, LSL #29
    CCMP  W4, #0x12, #0x2, CS
    CCMP  X10, #0x19, #0x1, HI
    CMP  W26, #0xa0f, LSL #12
    CCMN  W20, #0x5, #0x1, NV
    CCMN  W15, W15, #0xb, EQ
    CMP  X16, X22, LSR #58
    CMP  X15, W4, UXTW #0
    CCMP  X10, X18, #0x8, HI
    CMN  X25, #0xb51, LSL #12
    CMP  W26, W18, UXTX #1
    CMP  W25, #0x7
    CMN  W15, W16, LSL #13
    CCMP  X17, #0x10, #0xa, VS
    CMP  X18, W18, SXTH #3
    CMP  X19, W22, SXTH #1
    CCMN  X27, #0x10, #0x0, LT
    CCMP  W3, #0x10, #0x0, MI
    CMP  W6, #0x71a, LSL #12
    CCMN  W13, #0xe, #0xb, MI
    CMP  X24, #0x1f7, LSL #12
    CMN  W16, #0x20c
    CMN  W3, #0x161
    CMP  W27, W17, SXTX #4
    CMN  W25, W18, ASR #28
    CCMP  X6, X22, #0x2, LE
    CMN  X2, #0x782
    CCMP  X16, #0x1f, #0xf, PL
    CCMN  W26, #0x12, #0x8, VC
    CCMP  X10, X22, #0x5, CC
    CMP  X4, X26, LSL #46
    CCMN  X20, X28, #0x5, CS
    CMP  X19, X24, UXTX #0
    CMN  W28, W17, LSL #5
    CCMP  X22, #0x0, #0xb, CS
    CMN  X13, X21, LSR #0
    CMN  X7, X20, LSR #51
    CMN  W2, W17, SXTX #3
    CMP  X5, X10, LSL #57
    CMP  W6, W16, UXTW #4
    CCMN  W19, #0xb, #0x5, GE
    CCMN  W17, #0x9, #0xf, NE
    CCMP  X2, X18, #0x7, VS
    CCMN  W16, #0x15, #0xf, LS
    CMN  W15, W10, ASR #0
    CMP  X22, #0xbfa, LSL #12
    CMN  W19, W13, LSL #20
    CMN  X17, X6, ASR #45
    CCMN  X15, X6, #0x3, GT
    CCMN  X15, #0x11, #0x5, VS
    CMN  X28, #0xa22, LSL #12
    CMP  W5, W5, ASR #12
    CCMN  X16, X19, #0xd, GE
    CMN  W15, W13, LSR #18
    CMN  X5, W6, SXTB #4
    CMP  X4, #0xcd, LSL #12
    CMP  W13, W6, SXTW #0
    CMP  X17, #0x26
    CCMP  W6, W24, #0x4, PL
    CCMP  X6, #0xb, #0xd, CC
    CMN  X10, W17, SXTB #3
    CCMP  W5, #0x1e, #0xa, NV
    CCMN  W16, W5, #0xb, LT
    CMP  W10, W13, UXTX #3
    CCMN  W2, W4, #0x7, LT
    CMP  X18, X24, UXTX #3
    CCMN  W26, #0x7, #0xe, VS
    CMN  X28, X13, UXTX #1
    CCMN  W13, W19, #0x5, AL
    CMN  W2, #0x354
    SUBS  X22, X22, #0x1
    B.NE  TSRTIntCompare_label_0
    MOVZ  X29, #0x5e6c, LSL #0
    MOVK  X29, #0x5185, LSL #16
    MOVK  X29, #0x2c1e, LSL #32
    MOVK  X29, #0x5619, LSL #48
    SUB  X23, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X29, #0x553d, LSL #0
    MOVK  X29, #0x4277, LSL #16
    MOVK  X29, #0x2e5b, LSL #32
    MOVK  X29, #0x1731, LSL #48
    SUB  X23, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X29, #0x27e2, LSL #0
    MOVK  X29, #0xdaff, LSL #16
    MOVK  X29, #0xbdba, LSL #32
    MOVK  X29, #0x585b, LSL #48
    SUB  X23, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X29, #0x5355, LSL #0
    MOVK  X29, #0x728d, LSL #16
    MOVK  X29, #0x24e4, LSL #32
    MOVK  X29, #0xe5e0, LSL #48
    SUB  X23, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X29, #0x94b2, LSL #0
    MOVK  X29, #0x9a60, LSL #16
    MOVK  X29, #0xf311, LSL #32
    MOVK  X29, #0x1d45, LSL #48
    SUB  X23, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X29, #0xede6, LSL #0
    MOVK  X29, #0xcd3d, LSL #16
    MOVK  X29, #0xf341, LSL #32
    MOVK  X29, #0xe3b1, LSL #48
    SUB  X23, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X29, #0xa5f5, LSL #0
    MOVK  X29, #0x20a2, LSL #16
    MOVK  X29, #0xdc4a, LSL #32
    MOVK  X29, #0xd322, LSL #48
    SUB  X23, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X29, #0xc9c0, LSL #0
    MOVK  X29, #0x8aec, LSL #16
    MOVK  X29, #0x4f39, LSL #32
    MOVK  X29, #0xd1a9, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X29, #0xb5ca, LSL #0
    MOVK  X29, #0xd1b6, LSL #16
    MOVK  X29, #0x210f, LSL #32
    MOVK  X29, #0x6118, LSL #48
    SUB  X23, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X29, #0xd85d, LSL #0
    MOVK  X29, #0xfc3d, LSL #16
    MOVK  X29, #0x2b, LSL #32
    MOVK  X29, #0xcd5c, LSL #48
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X29, #0xcc16, LSL #0
    MOVK  X29, #0xb041, LSL #16
    MOVK  X29, #0x4984, LSL #32
    MOVK  X29, #0x9f94, LSL #48
    SUB  X23, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X29, #0x3ab6, LSL #0
    MOVK  X29, #0x2872, LSL #16
    MOVK  X29, #0x2449, LSL #32
    MOVK  X29, #0xbb7f, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X29, #0x7fe6, LSL #0
    MOVK  X29, #0x9028, LSL #16
    MOVK  X29, #0x4d09, LSL #32
    MOVK  X29, #0xa55, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X29, #0xeb3e, LSL #0
    MOVK  X29, #0xf861, LSL #16
    MOVK  X29, #0x9a73, LSL #32
    MOVK  X29, #0xf582, LSL #48
    SUB  X23, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X29, #0xe1a1, LSL #0
    MOVK  X29, #0xf416, LSL #16
    MOVK  X29, #0x5484, LSL #32
    MOVK  X29, #0xf34c, LSL #48
    SUB  X23, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X29, #0x6012, LSL #0
    MOVK  X29, #0x98f2, LSL #16
    MOVK  X29, #0x969e, LSL #32
    MOVK  X29, #0x8412, LSL #48
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X29, #0xe044, LSL #0
    MOVK  X29, #0xd712, LSL #16
    MOVK  X29, #0x68e, LSL #32
    MOVK  X29, #0x8129, LSL #48
    SUB  X23, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X29, #0xef4b, LSL #0
    MOVK  X29, #0xa7bd, LSL #16
    MOVK  X29, #0xe2f8, LSL #32
    MOVK  X29, #0xdaba, LSL #48
    SUB  X23, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X29, #0x5f91, LSL #0
    MOVK  X29, #0xb755, LSL #16
    MOVK  X29, #0xc4ac, LSL #32
    MOVK  X29, #0xa5dc, LSL #48
    SUB  X23, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X29, #0xdf2f, LSL #0
    MOVK  X29, #0x9ac5, LSL #16
    MOVK  X29, #0x1079, LSL #32
    MOVK  X29, #0x2843, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
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
    MOVZ  X4, #0xa, LSL #0
TSRTIntCompare_label_1:
    CMN  W16, W28, UXTB #4
    CMN  W17, W20, UXTX #1
    CMP  W19, W27, UXTH #3
    CMN  W26, #0xfe2
    CMP  W29, W18, LSR #19
    CMN  W24, W7, UXTB #4
    CCMP  X22, X25, #0xc, CC
    CCMP  X19, X4, #0x7, EQ
    CCMN  X23, X21, #0xc, NE
    CCMP  X29, X29, #0x2, PL
    CMN  X20, #0x15f
    CCMP  W16, #0x8, #0xb, GT
    CCMP  W29, #0x17, #0x9, NE
    CCMN  W24, W24, #0x0, VS
    CCMN  W28, #0x1c, #0x7, GT
    CMP  W5, W18, UXTH #4
    CCMP  W10, #0x1c, #0xc, GT
    CMP  X18, #0xc72
    CMN  X5, W28, UXTH #0
    CMN  W15, W16, SXTW #3
    CMN  W16, W15, ASR #9
    CMP  X17, W10, UXTW #3
    CCMP  W24, W13, #0xa, HI
    CMN  W19, W4, SXTX #1
    CMN  W22, W7, SXTH #1
    CMN  W26, #0xba8
    CCMN  X13, X5, #0x3, GE
    CMN  X2, W21, SXTW #4
    CMN  W23, W2, UXTW #0
    CMN  X27, #0xd4, LSL #12
    CMP  W27, #0xb2f, LSL #12
    CMN  X5, X28, LSL #6
    CCMP  X13, X28, #0x1, LS
    CMN  X16, W16, UXTB #0
    CCMN  X15, X21, #0xe, NV
    CMP  W7, W7, ASR #1
    CMP  X25, #0x2c5, LSL #12
    CMP  X21, #0xca6, LSL #12
    CCMN  W20, W16, #0x3, LS
    CCMP  X15, #0x1b, #0x7, GT
    CCMN  X23, #0x1f, #0x4, PL
    CMN  W17, #0xb6f, LSL #12
    CMN  W18, W20, LSL #11
    CMN  X7, X21, LSL #38
    CCMP  W28, #0x3, #0x4, HI
    CCMP  W29, W10, #0x0, MI
    CCMN  X29, X10, #0x7, LT
    CMN  W26, W5, LSL #22
    CCMP  W22, #0xc, #0x0, NE
    CMN  X26, #0x4ac, LSL #12
    CMP  W21, W29, UXTB #2
    CCMP  W2, #0xa, #0xc, CS
    CMN  X19, W29, SXTW #0
    CMP  X18, X18, LSL #41
    CMN  W20, W7, UXTX #1
    CCMP  X18, #0x12, #0xb, EQ
    CMP  X18, X17, LSR #48
    CCMP  X28, #0x1e, #0x8, EQ
    CMP  X28, W22, SXTH #3
    CCMP  W13, W2, #0x8, PL
    CCMN  X26, X22, #0x0, EQ
    CMP  W15, #0x606, LSL #12
    CMP  X5, W7, SXTH #1
    CCMN  X23, #0x12, #0x7, LS
    CCMP  W24, W18, #0x1, LE
    CMN  X17, X4, UXTX #2
    CCMP  W28, #0x19, #0xd, LT
    CMP  X2, #0x77c, LSL #12
    CCMP  X24, X4, #0x7, LE
    CCMN  X22, #0x4, #0xa, LS
    CCMP  X21, #0xc, #0x5, LT
    CMN  X21, #0xe79, LSL #12
    CCMP  W27, W18, #0x3, HI
    CCMN  X18, #0x1b, #0x7, CS
    CCMN  X2, X22, #0x6, NV
    CMP  X23, X13, UXTX #4
    CMP  W23, W28, ASR #13
    CMN  W29, W28, ASR #4
    CMP  X17, #0x71d
    CMN  X13, X22, LSR #29
    CCMP  X20, X25, #0xc, VC
    CCMP  X10, X20, #0x8, PL
    CMP  W20, W24, ASR #6
    CCMN  X19, X28, #0x5, CC
    CCMP  X27, #0x12, #0xf, PL
    CMN  W2, #0xe65
    CCMP  W26, #0xa, #0x0, AL
    CMN  X29, #0x5cc, LSL #12
    CCMP  W16, #0x16, #0xb, VC
    CCMP  X20, #0x8, #0xb, NE
    CMP  W24, W2, SXTX #3
    CMN  W22, W22, UXTX #0
    CMN  W5, W23, ASR #5
    CMN  W24, W27, LSL #18
    CMP  W25, W10, UXTB #1
    CCMN  W21, W19, #0x1, MI
    CCMP  X17, X21, #0xc, CS
    CCMP  W24, W23, #0x2, PL
    CMP  X19, X7, LSL #9
    CMP  X15, #0x164, LSL #12
    CCMN  X19, #0xe, #0x1, LT
    CCMP  X4, X16, #0x2, AL
    CCMN  X7, X5, #0x2, GT
    CMP  W15, W26, SXTB #2
    CMP  X15, X19, LSR #39
    CCMP  X24, #0x6, #0x2, HI
    CMP  W20, W19, SXTW #2
    CMN  W2, W17, LSL #13
    CMP  W15, W18, LSL #6
    CCMP  W4, W7, #0x1, AL
    CCMN  X25, X4, #0x1, EQ
    CCMN  W13, W26, #0xb, NE
    CCMN  X25, #0x7, #0xc, CS
    CMN  X29, W22, SXTW #1
    CMN  X28, W22, UXTB #4
    CMN  X10, #0xad
    CMN  X15, X10, LSR #13
    CCMN  X15, X25, #0x8, GT
    CMN  X13, W21, UXTB #2
    CCMP  W2, W26, #0xd, CS
    CMN  W21, W4, ASR #12
    CMN  X20, W24, UXTH #0
    CCMP  W20, W28, #0x3, NE
    CCMN  X25, X18, #0x0, CS
    CCMN  X22, #0x10, #0x1, HI
    CCMN  W28, #0x17, #0x7, AL
    CMN  X21, X20, UXTX #0
    CMP  W18, #0x399
    CMN  X13, X21, SXTX #1
    CMN  W7, W5, LSR #8
    CMN  W23, #0x1ed, LSL #12
    CCMP  W16, #0xa, #0x2, GE
    CCMN  X17, X5, #0x0, LT
    CCMP  W21, #0x1d, #0x8, GE
    CCMP  X20, X24, #0x9, LS
    CCMP  W19, W18, #0x0, EQ
    CCMN  X5, #0x15, #0xa, LT
    CMP  X18, X27, SXTX #3
    CMN  W28, W4, UXTW #0
    CCMN  X26, X21, #0xd, MI
    CMN  X28, #0xc8e, LSL #12
    CMN  W2, W27, LSL #13
    CCMP  X15, #0x10, #0x2, LT
    CMN  X18, W15, UXTW #2
    CMP  X13, W2, SXTB #1
    CMN  W22, W22, LSL #24
    CMN  W18, #0x819, LSL #12
    CMP  W29, #0x308
    CMN  X13, X27, LSL #4
    CMP  X22, #0x2fa, LSL #12
    CMP  W15, W21, SXTW #3
    CCMN  W24, #0x10, #0x2, NE
    CMN  X21, W5, SXTB #3
    CMP  X13, #0xbdc, LSL #12
    CMP  X24, #0x84b
    CCMN  W4, #0x9, #0x5, GE
    CMN  W27, #0x855, LSL #12
    CCMP  W29, W7, #0xf, PL
    CCMN  W4, #0x12, #0x5, LT
    CMN  W25, W5, ASR #28
    CMN  W24, #0xa0a
    CCMP  X4, X25, #0x2, NE
    CMN  X25, W5, UXTH #1
    CCMP  W5, W13, #0x0, CS
    CMP  X20, X2, LSR #7
    CMN  X25, X7, ASR #33
    CMP  X20, X18, ASR #22
    CMP  X15, W21, SXTB #0
    CCMP  X4, X7, #0xd, MI
    CMN  W17, W23, LSR #0
    CMP  W13, W29, UXTX #3
    CCMN  X26, #0x4, #0xe, MI
    CMN  X24, #0xed1
    CMP  W29, W10, UXTX #0
    CMP  X19, W7, SXTW #3
    CMN  X24, #0x401
    CMP  W5, #0x98e, LSL #12
    CMN  X16, X24, LSL #53
    CMN  W21, #0xf2
    CMN  W26, #0x5b3, LSL #12
    CMN  X27, X13, ASR #26
    CCMP  X4, #0x16, #0x8, MI
    CMP  W23, W15, LSR #28
    CMP  W24, W18, LSR #28
    CMP  X7, X16, LSR #12
    CMP  X18, #0xab1
    CCMP  X7, #0x13, #0xe, GE
    CMN  X26, X29, LSR #11
    CMN  W15, W15, UXTX #0
    CMN  X20, #0xc2b, LSL #12
    CCMN  W28, W23, #0x8, NV
    CMP  X28, X24, LSR #63
    CCMP  X28, X23, #0xe, GE
    CMP  X28, #0xe4e, LSL #12
    CMP  X26, #0x47
    CMP  X21, X27
    CMP  X20, X18, ASR #57
    CMN  W2, #0x6bb, LSL #12
    CMP  W4, #0xdef
    CMN  X28, X10, LSR #41
    SUBS  X4, X4, #0x1
    B.NE  TSRTIntCompare_label_1
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
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
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
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
    MOVZ  X13, #0xa, LSL #0
TSRTIntCompare_label_2:
    CMP  W13, W27, SXTW #4
    CMP  X3, #0x82c
    CCMP  W19, W3, #0xd, VC
    CCMP  X29, #0x1b, #0xe, MI
    CCMP  W28, #0x1e, #0xe, LT
    CMP  W23, W26, UXTB #1
    CMP  W7, #0x8ca
    CMP  W5, #0x81b, LSL #12
    CMN  W21, W6, SXTB #2
    CCMN  W16, W15, #0x3, LS
    CCMN  X15, X23, #0x8, MI
    CMN  X13, #0x781, LSL #12
    CMN  W4, W18, LSR #31
    CMP  W21, W4, SXTH #3
    CCMN  X23, X5, #0x1, PL
    CCMP  W28, W6, #0x6, LT
    CMP  X29, X4, LSL #8
    CMN  W6, W3, LSL #31
    CCMN  X2, X5, #0xc, PL
    CMN  X13, X18, ASR #27
    CMP  W26, W5, LSR #5
    CMN  X27, W20, UXTW #0
    CCMP  X29, #0xe, #0x0, GT
    CCMP  W24, W23, #0xc, LE
    CCMN  W22, W29, #0xe, LE
    CMN  X20, #0xac9, LSL #12
    CCMN  W4, #0x2, #0x8, CC
    CMN  X24, W28, SXTB #1
    CCMN  W22, W29, #0xb, NE
    CMP  W16, W23, UXTW #1
    CMN  W28, #0x7b7
    CMN  X13, #0x72e, LSL #12
    CCMN  X26, #0xa, #0x6, HI
    CMP  W2, W4, LSL #3
    CMN  W5, W29, LSL #31
    CMP  W17, W24, SXTW #0
    CCMP  W21, #0x14, #0xf, VS
    CMN  X27, #0xd0d
    CCMP  X20, #0x1c, #0xc, VS
    CMP  X2, W18, UXTB #3
    CCMP  W3, W16, #0x6, GT
    CMN  W18, W13, SXTH #1
    CCMN  W19, #0x8, #0xf, NV
    CMP  W16, W15, ASR #6
    CCMP  X17, X19, #0xb, GE
    CCMP  X17, X16, #0x7, VC
    CMN  W22, W5, UXTH #0
    CMN  X18, W17, SXTW #4
    CCMN  W29, W20, #0xb, CC
    CMP  W23, W4, ASR #19
    CCMP  X3, X18, #0x1, GT
    CMN  X3, X28, UXTX #3
    CMN  W29, W3, ASR #31
    CCMN  X13, #0xb, #0xe, NE
    CCMN  X20, #0x9, #0xf, LT
    CMP  X16, #0x2a5, LSL #12
    CMN  W24, W7, SXTW #3
    CMP  X16, X7, LSR #0
    CMP  X5, X18, LSR #15
    CMN  W23, W23, LSR #10
    CMN  W6, W28, UXTX #2
    CCMN  X21, X6, #0xd, LE
    CMP  W13, W13, LSR #17
    CMP  W21, W29, LSR #5
    CMP  W20, W16, LSL #29
    CMP  W3, #0x349, LSL #12
    CCMP  W28, W4, #0x4, LE
    CMN  X3, #0xbc3, LSL #12
    CMN  W16, #0x818
    CMP  X6, W4, SXTH #1
    CCMP  W2, W4, #0x8, EQ
    CMN  X16, #0x572, LSL #12
    CMN  X2, X15, LSR #8
    CCMP  X13, X2, #0xc, LT
    CCMN  W19, #0xb, #0xe, VC
    CMP  X23, X6, LSL #20
    CCMP  X17, X13, #0xd, LE
    CCMP  W29, #0x15, #0xc, EQ
    CCMP  X3, #0x8, #0x8, CC
    CMN  X13, X6, ASR #38
    CMP  X28, X20, LSL #22
    CMP  X3, W26, SXTH #4
    CCMN  W4, #0xe, #0xf, NE
    CMP  X29, X18, LSL #48
    CMP  W29, W18, UXTH #0
    CCMP  X13, X28, #0xf, CS
    CMP  W4, W24, UXTW #3
    CCMN  X13, #0x5, #0x7, LE
    CCMN  X23, #0x1a, #0x8, NE
    CMP  X21, X16, UXTX #0
    CMP  X28, X28, ASR #3
    CMP  W27, #0x4eb
    CMN  X18, #0xf64, LSL #12
    CCMP  W16, W17, #0x6, HI
    CMP  X5, #0x47d
    CMN  X15, #0x875
    CCMP  W7, #0xa, #0x7, PL
    CMP  X27, #0x373, LSL #12
    CCMN  W6, #0x17, #0x6, LE
    CMP  W15, W29, LSR #3
    CMN  W21, W26, UXTX #4
    CMP  X23, W21, UXTW #3
    CCMN  W15, W6, #0x2, CS
    CMN  X7, W21, UXTB #4
    CMN  W16, #0x745, LSL #12
    CMN  W4, #0xc35, LSL #12
    CCMP  X26, #0xc, #0xe, CS
    CMN  X29, X18, UXTX #0
    CMN  W4, #0x444, LSL #12
    CMP  X3, X27, LSR #54
    CCMP  X6, X5, #0x9, NE
    CCMP  X17, #0x15, #0xa, MI
    CCMP  X13, X6, #0x2, AL
    CMN  X17, #0x262
    CMN  W27, W20, SXTB #2
    CMN  X28, X27, LSL #34
    CMP  X22, X21, ASR #2
    CMP  W24, W5, ASR #12
    CMP  X6, X4, LSL #48
    CMN  W16, #0x6b3
    CMN  X18, X20, LSL #4
    CMP  X22, #0x3fb, LSL #12
    CMP  X7, X7, ASR #61
    CMP  W21, W17, SXTH #1
    CMN  X21, X3, ASR #56
    CMN  W23, W27, SXTH #1
    CMP  W21, #0x89, LSL #12
    CCMN  W3, #0x1e, #0x2, AL
    CMP  X28, X27, ASR #25
    CMN  W15, #0xa87
    CMN  W3, #0xb3e
    CCMN  W3, W3, #0x1, MI
    CMP  W15, #0xa58, LSL #12
    CMN  W24, W23, UXTX #1
    CMP  W7, #0xc62, LSL #12
    CMN  W20, W26, LSL #31
    CMN  W29, W15, ASR #3
    CMN  X7, X24, LSR #14
    CCMP  W13, #0xb, #0xe, LS
    CMN  X15, W3, UXTW #3
    CMN  W6, #0x43a, LSL #12
    CMP  W29, W29, ASR #24
    CCMN  W15, W28, #0xf, NE
    CCMP  W16, #0xd, #0xa, CC
    CMP  X7, X18, LSR #63
    CCMP  W3, W22, #0x9, VS
    CCMP  W20, #0x1d, #0xf, LS
    CMP  X21, #0x935, LSL #12
    CMP  X7, W15, UXTW #4
    CMP  W6, W21, SXTH #2
    CMP  W2, W27, UXTX #3
    CCMP  X6, #0xe, #0x6, NE
    CMN  X5, W28, UXTH #2
    CMP  X16, #0xff7, LSL #12
    CCMN  W21, #0xa, #0xa, NV
    CCMN  W24, #0x19, #0x3, HI
    CMN  X29, W22, SXTH #4
    CMP  X5, X17, ASR #7
    CCMN  X19, X23, #0x4, PL
    CMN  W2, W18, UXTX #2
    CMN  W5, W20, SXTB #1
    CCMN  W13, W7, #0x6, GE
    CMP  W21, W13, LSL #23
    CCMN  X24, X24, #0x0, GT
    CMP  W16, #0x4ce
    CMP  X16, X16, UXTX #1
    CCMP  X28, X15, #0xe, GT
    CMP  X19, X20, ASR #59
    CCMN  X17, #0x1c, #0x4, NV
    CMN  W29, W5, ASR #21
    CMP  X19, W20, UXTH #0
    CMN  X2, #0x634
    CCMP  X3, X23, #0x3, MI
    CMP  W15, #0x7af, LSL #12
    CMP  X23, X5, LSR #63
    CMN  W6, #0x7c5, LSL #12
    CCMP  W29, #0x16, #0x7, LS
    CCMP  W18, #0x1b, #0x4, CC
    CCMP  W24, W18, #0x4, LS
    CMP  X29, W26, SXTW #1
    CMP  W20, W29, LSR #17
    CCMN  X21, #0x13, #0x2, LS
    CMP  X27, #0x81
    CMN  W4, W28, UXTW #2
    CMP  X27, X27, ASR #26
    CMP  W2, #0x3bc
    CCMN  X22, #0xb, #0x7, LT
    CMN  W2, W20, LSR #15
    CMN  W27, W26, LSL #24
    CMN  X15, X29, LSL #29
    CCMP  X27, X20, #0xc, VC
    CMN  X17, X18, UXTX #0
    CMN  W18, W19, UXTB #4
    CCMN  W27, #0x4, #0x9, CS
    CMN  W20, #0x509, LSL #12
    CCMN  W16, #0x9, #0xa, NE
    CMP  X17, W22, SXTW #4
    CCMN  X29, X13, #0x5, MI
    CMP  W3, W3, UXTB #3
    CMP  W13, #0x271
    SUBS  X13, X13, #0x1
    B.NE  TSRTIntCompare_label_2
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X25, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X25, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X25, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X25, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X25, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X25, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTIntCompare_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X25, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X25, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X25, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X25, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X25, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X25, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X25, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X25, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X25, X10, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X25, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X25, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTIntCompare_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X25, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTIntCompare_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
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
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
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
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    MOVZ  X18, #0xa, LSL #0
TSRTIntCompare_label_3:
    CCMN  X29, X28, #0xf, MI
    CCMN  W27, W25, #0x5, PL
    CMN  X19, X26, LSR #9
    CCMP  W24, #0x19, #0xe, VC
    CMP  W10, W18, UXTB #4
    CMN  X25, X25, LSL #55
    CMN  W24, W4, SXTX #4
    CCMN  W28, #0x8, #0xb, AL
    CMN  W6, W7, UXTX #3
    CMP  W16, #0xcb1, LSL #12
    CCMP  W17, #0x9, #0xd, GE
    CCMP  X13, X5, #0x2, LS
    CCMN  W6, #0xa, #0x9, VC
    CCMN  X5, #0x15, #0x9, AL
    CMP  W4, #0x1f
    CMP  X6, #0x5ae, LSL #12
    CMN  W26, W21, ASR #18
    CMN  W5, W23, LSR #31
    CMP  X5, #0xb63
    CMN  X19, X18, LSL #50
    CMN  W26, W16
    CMN  W24, W18, ASR #2
    CMP  X2, #0xdf4, LSL #12
    CCMP  X29, X24, #0xa, GE
    CMP  X3, W17, UXTB #2
    CMP  X18, X23, LSL #46
    CMP  W16, W10, LSL #25
    CCMP  X7, X19, #0x9, NV
    CMN  X21, #0x7c2, LSL #12
    CMN  X21, X6, LSR #20
    CMN  X28, #0xfa, LSL #12
    CCMN  W18, W29, #0xd, CS
    CMN  X18, X18, LSR #32
    CMP  X17, X17, ASR #12
    CMN  X3, X27, LSL #10
    CMN  X19, #0xb9e, LSL #12
    CMP  X6, #0xd38, LSL #12
    CMN  W23, #0x947
    CMP  X25, W5, SXTH #4
    CMN  X23, W3, SXTW #4
    CCMN  W19, #0x12, #0xd, GE
    CCMP  X4, X18, #0xf, PL
    CCMP  X10, X3, #0x1, LS
    CMN  W5, W26, SXTW #3
    CCMP  W10, #0x1c, #0x5, CC
    CMP  X4, X19, ASR #7
    CMN  W25, W21, ASR #31
    CMN  X19, #0xbbb, LSL #12
    CCMP  X18, X23, #0x6, GT
    CCMN  W21, #0xb, #0xa, CC
    CMN  X19, #0xcaa, LSL #12
    CMN  X4, #0x9d7
    CCMN  W6, W17, #0x6, CS
    CCMN  X25, X21, #0x5, LT
    CMP  X28, #0xe64, LSL #12
    CMN  W15, #0x6a, LSL #12
    CMP  X23, X21, ASR #23
    CCMP  X15, X24, #0x5, VC
    CMN  X10, X17, LSL #25
    CMP  W5, W7, SXTX #4
    CMP  W10, W10, ASR #14
    CMP  W18, #0x701
    CCMN  W13, #0x4, #0xc, VC
    CCMN  W2, #0x7, #0x6, PL
    CCMP  X2, #0x1a, #0xd, MI
    CMP  W18, W21, SXTB #4
    CMP  X18, W17, UXTB #2
    CMN  X23, W27, SXTB #2
    CMP  W4, #0x7c8
    CCMP  X15, X4, #0x6, LT
    CCMN  X6, #0x13, #0xc, EQ
    CMN  W17, W16, SXTW #3
    CCMP  X13, X13, #0x9, LS
    CCMN  X7, X5, #0x2, LS
    CMN  W26, W7, UXTH #2
    CMN  W26, W27, ASR #31
    CCMP  X7, X21, #0xc, LT
    CCMN  X7, X28, #0xc, AL
    CMP  X2, X27, LSL #20
    CCMP  W29, #0x14, #0x6, NE
    CMP  W21, #0x2c3
    CCMN  W5, W27, #0x9, GE
    CCMN  W6, W21, #0xb, VS
    CCMP  X10, X5, #0xe, PL
    CCMN  W21, #0x10, #0xe, NV
    CMN  X21, W23, UXTW #1
    CCMP  W6, #0x3, #0x4, MI
    CMP  X10, #0x5e0
    CMP  W6, #0xd05
    CCMN  X17, X10, #0x7, VC
    CMN  X26, X28, ASR #29
    CMN  W2, #0xfb0
    CMP  W5, W10, UXTH #0
    CCMN  X16, X27, #0x3, EQ
    CCMP  X10, #0x3, #0x8, LE
    CMP  W10, W13, LSR #27
    CMP  X23, X15, ASR #39
    CMN  X13, X24, LSR #35
    CMP  W29, W7, ASR #15
    CMN  W13, #0x3f7, LSL #12
    CMP  W29, W16, UXTW #4
    CMP  X13, W4, UXTB #3
    CCMN  W18, #0x7, #0xd, GE
    CMP  X27, W23, UXTW #0
    CMN  W26, W5, LSL #18
    CMP  W2, W5, LSR #11
    CMN  W29, W26, ASR #22
    CMN  W10, #0xa27
    CMP  X15, W16, SXTB #0
    CMP  W5, #0xfd0
    CMN  X10, W24, UXTH #4
    CMN  W23, W6, SXTW #3
    CCMP  W15, W6, #0x5, VC
    CMP  X2, #0xcd8
    CMP  W26, W19, UXTH #2
    CCMP  W19, #0x15, #0xf, NE
    CMP  X4, X5, ASR #45
    CMN  W24, #0x125, LSL #12
    CMN  X26, #0xcd1, LSL #12
    CCMP  X4, #0xf, #0x5, GE
    CMN  W3, W24, SXTH #4
    CMP  X18, X29, LSR #53
    CMN  X27, X28, LSL #62
    CMP  W25, W18, SXTH #3
    CMN  W6, W28, LSL #26
    CCMN  W19, W15, #0x3, GE
    CCMN  W3, W19, #0xc, LE
    CMN  W27, W29, UXTX #3
    CMN  W16, W6, UXTH #0
    CMN  W10, #0x281, LSL #12
    CCMP  W17, W17, #0xc, LE
    CMP  W25, #0xb62
    CMN  W7, #0xeba
    CMP  X13, X2, ASR #27
    CMP  X26, #0x196, LSL #12
    CCMN  X13, #0xf, #0x1, VS
    CMN  X26, X28, ASR #26
    CMN  X18, #0x47d, LSL #12
    CMP  X7, X15, ASR #24
    CCMP  W4, W25, #0xb, VS
    CMP  X18, X13, LSL #59
    CMP  X23, X27, LSR #7
    CMP  W5, W25, LSL #1
    CCMP  W16, W13, #0x0, AL
    CMN  W23, W7, LSR #19
    CCMN  W23, W4, #0x1, LE
    CCMP  X18, X18, #0x7, VS
    CMP  X3, W4, UXTW #4
    CCMP  X29, #0x19, #0x8, GE
    CMN  W13, W13, ASR #19
    CCMP  W7, W10, #0xc, EQ
    CCMN  X27, #0xd, #0x3, NV
    CCMN  X25, X2, #0xb, CC
    CCMP  X21, X2, #0x4, LE
    CCMP  X7, X27, #0x5, MI
    CMP  X19, X24, LSR #20
    CCMP  W29, W13, #0xb, GT
    CMN  X27, X17, ASR #61
    CCMP  W19, W27, #0x7, HI
    CCMP  W25, W21, #0x7, GT
    CMN  X18, X16, LSR #62
    CMP  W19, W28
    CCMN  X3, #0x8, #0x9, HI
    CMN  X13, X28, LSL #51
    CMN  W2, W17, LSR #24
    CMN  W23, W16, ASR #22
    CMN  X4, #0xea0
    CMN  W27, W24, UXTH #2
    CMP  W19, W21, SXTW #3
    CCMP  X7, X5, #0x6, LE
    CMP  W28, W28, LSL #30
    CMN  W2, #0x86f
    CMP  W27, W3, UXTX #0
    CMN  X17, X3, ASR #32
    CMN  W29, #0x1f9, LSL #12
    CCMP  W15, #0x1, #0xc, CS
    CCMN  X26, #0x6, #0xa, LT
    CMP  W18, W13, LSL #19
    CMN  W5, #0x937, LSL #12
    CCMP  X21, #0x10, #0xe, CC
    CMN  W10, W10, UXTX #0
    CMN  W27, W10, SXTB #0
    CMN  X16, #0x319, LSL #12
    CMN  W17, W26, UXTX #2
    CCMN  X3, X4, #0x8, CC
    CMN  X27, #0x4e6
    CMN  W2, #0x40a, LSL #12
    CCMP  X28, X16, #0xc, VS
    CMP  X29, X23, ASR #20
    CCMN  W25, W27, #0xd, NV
    CCMP  X3, #0x19, #0x2, AL
    CMN  X28, #0xe7e
    CCMP  X26, X3, #0xb, HI
    CCMP  W26, W18, #0xb, LE
    CMP  X7, #0x7c, LSL #12
    CMN  W3, W19, ASR #30
    CMN  X21, X19, LSR #5
    CMP  X23, X2, LSR #45
    CMP  X21, X4, LSL #16
    CCMP  W16, W6, #0x7, MI
    SUBS  X18, X18, #0x1
    B.NE  TSRTIntCompare_label_3
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X20, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X20, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X20, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X20, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X20, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X20, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X20, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X20, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X20, X22, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X20, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X20, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X20, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X20, X22, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X20, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X20, X22, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X20, X22, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X20, X22, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X20, X22, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X20, X22, X27
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X20, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X20, X22, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
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
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
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
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    MOVZ  X3, #0xa, LSL #0
TSRTIntCompare_label_4:
    CCMP  X3, X29, #0x2, NV
    CMN  X23, X18, LSR #44
    CMN  X28, W28, UXTB #2
    CCMN  X17, X27, #0x7, CC
    CCMP  X26, X26, #0xa, LE
    CMN  X4, #0x633, LSL #12
    CCMN  W19, W2, #0xf, VC
    CMN  W10, W2, LSR #8
    CMP  W21, W2, UXTX #3
    CMP  X20, X23, LSL #14
    CMN  X27, X17, LSR #51
    CMN  W7, W27, UXTB #1
    CCMN  W23, #0x3, #0xa, HI
    CMN  X3, W21, SXTH #3
    CMN  W20, #0x3e8
    CMN  W4, W6, LSR #30
    CCMP  W22, #0xd, #0x9, LE
    CMP  X27, W29, UXTH #3
    CMP  X22, X22, LSL #5
    CMN  X26, X7, LSL #63
    CCMP  W29, W19, #0xf, MI
    CCMN  W7, #0x8, #0xc, EQ
    CMN  W5, W13, SXTX #4
    CMP  X10, X22, LSR #37
    CCMP  X23, #0x1d, #0xa, MI
    CMN  W7, W22, LSR #3
    CMP  X17, X20, SXTX #1
    CMP  W27, W21, LSL #19
    CMN  W29, W3, LSR #31
    CCMP  W21, W10, #0xc, EQ
    CCMN  X13, #0xa, #0x8, GT
    CCMP  X17, X29, #0x6, AL
    CMP  X19, #0x71
    CMP  X5, W24, SXTB #4
    CMN  X6, X13, LSL #46
    CCMN  X19, #0x2, #0x3, PL
    CMN  X19, X13, UXTX #0
    CMN  X19, X6, LSL #48
    CMP  W21, W3, SXTH #4
    CCMP  X6, X27, #0x5, LT
    CMP  W27, #0xeee
    CMP  X26, X24, LSL #34
    CCMN  W21, #0x14, #0x2, LE
    CCMN  W2, #0x1e, #0x7, LS
    CMP  X3, W5, UXTW #1
    CMN  W4, #0x3ec, LSL #12
    CMP  X2, W2, UXTB #1
    CMP  W18, #0x14e, LSL #12
    CCMN  X25, X3, #0xe, GE
    CMP  W25, W5, LSR #3
    CMN  X24, W23, SXTB #2
    CCMP  X3, #0xf, #0xb, AL
    CMP  X26, X21, LSR #19
    CCMN  X19, X22, #0x5, CC
    CMN  X18, X3, SXTX #2
    CMP  W21, W19, LSL #25
    CMN  X3, #0xea6
    CMN  X7, #0xa5a
    CMP  W21, W26, UXTB #0
    CMN  X22, X10, ASR #38
    CMN  X4, X4, LSR #9
    CMP  X26, #0x2bf, LSL #12
    CCMP  W27, #0x1f, #0x5, CS
    CCMP  W28, #0x1e, #0x1, VC
    CCMP  W13, W10, #0x9, CC
    CMP  W28, W26, UXTH #2
    CMN  W2, W3, UXTH #0
    CMP  W23, W27, LSL #24
    CCMN  W19, W10, #0x0, NV
    CMN  X19, #0xf97
    CMN  X5, X5, LSR #5
    CMN  X21, X2, LSR #19
    CMP  X27, W10, UXTW #1
    CMN  W19, W4, UXTH #0
    CCMP  X24, #0x1b, #0xa, PL
    CCMN  X29, #0x1, #0xb, AL
    CCMN  X13, X23, #0x1, NE
    CCMN  X7, X21, #0x2, LT
    CMP  X26, #0x8f1
    CMP  W17, W18, ASR #0
    CMP  W26, W5, LSR #3
    CMP  X26, X26, LSL #27
    CMN  X29, X2, LSR #28
    CCMP  W18, #0x18, #0x8, VS
    CCMP  W24, #0x1a, #0xf, LS
    CMP  W24, W13, UXTB #4
    CMP  W25, W2, ASR #16
    CCMN  W24, W24, #0xa, LE
    CMN  X25, W4, UXTH #2
    CMP  X22, #0x12, LSL #12
    CCMP  W17, #0x2, #0x7, NE
    CMP  X10, X5, LSL #38
    CCMN  W7, #0x1f, #0x9, GE
    CCMP  X24, X3, #0x6, VS
    CMN  X21, X23, ASR #38
    CMP  W27, #0x447
    CCMN  X18, #0x1c, #0x2, VC
    CCMN  X3, #0x4, #0xa, CC
    CCMP  X13, #0x1c, #0x4, EQ
    CMN  W7, W2, SXTH #2
    CMP  W6, W18, ASR #0
    CCMP  W4, W27, #0xb, CS
    CCMN  W6, W20, #0xc, NE
    CMP  X7, #0xe0c, LSL #12
    CCMP  W26, #0xa, #0xd, PL
    CCMP  X6, X17, #0xb, MI
    CMN  W7, W28, LSR #7
    CCMP  X27, X23, #0x8, LS
    CCMP  X2, #0x1b, #0x2, VC
    CCMN  W28, #0xb, #0xa, PL
    CCMN  W27, #0xa, #0x3, CS
    CMN  W25, W28, LSR #0
    CMN  W28, #0x354
    CMP  W19, #0x8e6, LSL #12
    CMP  W19, W6, LSR #6
    CMP  X25, X5, SXTX #0
    CCMP  X6, X19, #0x6, LE
    CCMP  X24, X24, #0x7, EQ
    CMP  W4, W7, LSL #27
    CMN  W18, #0xb7d, LSL #12
    CMN  X20, #0xa6, LSL #12
    CMN  X6, #0xaba, LSL #12
    CMP  W20, #0xe4d, LSL #12
    CCMP  W24, #0xa, #0x3, LE
    CMP  X10, #0x475, LSL #12
    CMN  X5, W23, UXTW #3
    CMN  W26, W5, LSR #23
    CCMP  X17, X24, #0x8, AL
    CMN  W3, #0xf29, LSL #12
    CMP  X26, #0xbef, LSL #12
    CMN  W6, #0x60b, LSL #12
    CMN  W10, #0xa49, LSL #12
    CCMP  W22, #0x9, #0x7, LS
    CMP  X24, #0xfe7, LSL #12
    CCMP  W27, #0x5, #0x5, GE
    CMN  X19, W26, SXTB #2
    CMN  X20, X10, ASR #52
    CMP  X27, #0x180, LSL #12
    CMP  W19, W23, UXTH #1
    CMP  X2, X7, ASR #7
    CCMN  X21, X13, #0x5, PL
    CMP  W17, W24, SXTX #0
    CCMP  W2, W7, #0xb, CS
    CCMN  W18, #0x10, #0x8, HI
    CCMP  W13, W3, #0x4, PL
    CMP  W5, W6, LSR #8
    CMP  W6, W7, UXTH #2
    CMP  W23, W6, LSR #29
    CMP  X29, #0xd4b, LSL #12
    CMP  W19, #0xfa7, LSL #12
    CCMP  W22, W18, #0x6, VS
    CMN  W13, W27, UXTH #1
    CCMN  X24, X10, #0x1, GT
    CMP  X25, #0x490
    CCMN  W2, W4, #0x8, GT
    CCMN  X23, #0x3, #0xb, AL
    CMP  W6, W28, SXTX #2
    CMP  X5, X20, LSR #18
    CCMP  X24, X7, #0xc, HI
    CMN  X18, W7, SXTB #4
    CMP  X26, X27, UXTX #1
    CCMN  W17, W28, #0x6, NE
    CCMP  W21, #0xb, #0xc, LS
    CCMN  W20, W7, #0xa, CS
    CMP  W29, W18, LSL #6
    CMN  W10, #0x32b
    CMN  X17, X19, LSR #40
    CMN  W24, #0xe36
    CMN  X29, X6, LSL #14
    CMP  W24, W26, LSL #30
    CCMN  W5, #0x13, #0x2, NE
    CCMP  W7, W17, #0xe, LT
    CCMN  X27, X21, #0x6, EQ
    CMN  W17, W28, SXTB #0
    CCMN  X26, #0x6, #0x8, MI
    CMP  W18, #0xa0a
    CMN  X17, #0xd07
    CCMN  X26, X7, #0xc, VC
    CMN  X19, X23, LSL #9
    CCMN  X22, X13, #0x9, VC
    CCMN  W2, W2, #0x2, LT
    CMN  W5, #0x3a5
    CCMN  X10, #0x16, #0xe, AL
    CMN  X6, X13, LSR #62
    CMP  X29, W29, UXTW #3
    CMP  W25, #0xd6b, LSL #12
    CMN  W25, #0xd78
    CCMN  W4, W6, #0xc, LT
    CMN  W28, W4, SXTB #1
    CMN  X23, X10, LSL #58
    CCMP  W20, #0x8, #0x1, LT
    CMP  W26, #0x1d6
    CCMN  X24, X17, #0x1, LE
    CMN  W20, W27, ASR #21
    CMN  W27, W21, ASR #21
    CCMN  W3, W13, #0x6, GT
    CMP  W7, W21, LSR #4
    CCMN  X21, X26, #0xe, NV
    CMP  W17, W20, SXTH #1
    CMP  X17, X28, ASR #33
    SUBS  X3, X3, #0x1
    B.NE  TSRTIntCompare_label_4
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCompare_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCompare_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCompare_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCompare_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCompare_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCompare_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCompare_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCompare_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCompare_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCompare_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCompare_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCompare_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCompare_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCompare_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCompare_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCompare_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCompare_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCompare_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCompare_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCompare_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCompare_TestFail
    MOVZ  X2, #0xd3fe, LSL #0
    MOVK  X2, #0x480f, LSL #16
    MOVK  X2, #0x3002, LSL #32
    MOVK  X2, #0xf276, LSL #48
    MOVZ  X3, #0x60fb, LSL #0
    MOVK  X3, #0x2f81, LSL #16
    MOVK  X3, #0x4ade, LSL #32
    MOVK  X3, #0xe7b0, LSL #48
    MOVZ  X4, #0xbf8e, LSL #0
    MOVK  X4, #0xcf14, LSL #16
    MOVK  X4, #0x44a3, LSL #32
    MOVK  X4, #0xdf3c, LSL #48
    MOVZ  X5, #0xfc29, LSL #0
    MOVK  X5, #0xae15, LSL #16
    MOVK  X5, #0x5630, LSL #32
    MOVK  X5, #0x8bf1, LSL #48
    MOVZ  X6, #0x3ac1, LSL #0
    MOVK  X6, #0x28e8, LSL #16
    MOVK  X6, #0x84fb, LSL #32
    MOVK  X6, #0xf43a, LSL #48
    MOVZ  X7, #0x8664, LSL #0
    MOVK  X7, #0xf509, LSL #16
    MOVK  X7, #0xe1bf, LSL #32
    MOVK  X7, #0x1f0d, LSL #48
    MOVZ  X10, #0x7239, LSL #0
    MOVK  X10, #0x67d, LSL #16
    MOVK  X10, #0x8d59, LSL #32
    MOVK  X10, #0xa6fd, LSL #48
    MOVZ  X13, #0x9b72, LSL #0
    MOVK  X13, #0x96f4, LSL #16
    MOVK  X13, #0xae9d, LSL #32
    MOVK  X13, #0xca1, LSL #48
    MOVZ  X15, #0x8f2b, LSL #0
    MOVK  X15, #0x502f, LSL #16
    MOVK  X15, #0x183, LSL #32
    MOVK  X15, #0xdbad, LSL #48
    MOVZ  X16, #0xb2e0, LSL #0
    MOVK  X16, #0xcfa6, LSL #16
    MOVK  X16, #0x9613, LSL #32
    MOVK  X16, #0xd32e, LSL #48
    MOVZ  X17, #0x9ae7, LSL #0
    MOVK  X17, #0x3c84, LSL #16
    MOVK  X17, #0xf72a, LSL #32
    MOVK  X17, #0xe0f0, LSL #48
    MOVZ  X18, #0xf312, LSL #0
    MOVK  X18, #0xff80, LSL #16
    MOVK  X18, #0x4449, LSL #32
    MOVK  X18, #0x90fb, LSL #48
    MOVZ  X19, #0x59fb, LSL #0
    MOVK  X19, #0xb685, LSL #16
    MOVK  X19, #0xc78f, LSL #32
    MOVK  X19, #0xf0e2, LSL #48
    MOVZ  X20, #0xe11a, LSL #0
    MOVK  X20, #0x733a, LSL #16
    MOVK  X20, #0x6613, LSL #32
    MOVK  X20, #0x1ba2, LSL #48
    MOVZ  X21, #0x1090, LSL #0
    MOVK  X21, #0x9719, LSL #16
    MOVK  X21, #0x841c, LSL #32
    MOVK  X21, #0xa5b1, LSL #48
    MOVZ  X22, #0x8995, LSL #0
    MOVK  X22, #0xd98e, LSL #16
    MOVK  X22, #0x5c88, LSL #32
    MOVK  X22, #0x1a3b, LSL #48
    MOVZ  X23, #0xa047, LSL #0
    MOVK  X23, #0x4dbd, LSL #16
    MOVK  X23, #0xacc3, LSL #32
    MOVK  X23, #0x8421, LSL #48
    MOVZ  X24, #0xd62f, LSL #0
    MOVK  X24, #0x8dae, LSL #16
    MOVK  X24, #0xe609, LSL #32
    MOVK  X24, #0x9a35, LSL #48
    MOVZ  X25, #0xc3e8, LSL #0
    MOVK  X25, #0xe9f, LSL #16
    MOVK  X25, #0x6fb8, LSL #32
    MOVK  X25, #0x1b5b, LSL #48
    MOVZ  X26, #0xde5b, LSL #0
    MOVK  X26, #0xb11e, LSL #16
    MOVK  X26, #0x24b6, LSL #32
    MOVK  X26, #0x3ff6, LSL #48
    MOVZ  X27, #0x89c3, LSL #0
    MOVK  X27, #0xecca, LSL #16
    MOVK  X27, #0x9da2, LSL #32
    MOVK  X27, #0x882d, LSL #48
    MOVZ  X28, #0x5b64, LSL #0
    MOVK  X28, #0x1663, LSL #16
    MOVK  X28, #0xd100, LSL #32
    MOVK  X28, #0x4521, LSL #48
    MOVZ  X29, #0xb710, LSL #0
    MOVK  X29, #0x413e, LSL #16
    MOVK  X29, #0xdf3b, LSL #32
    MOVK  X29, #0x2e02, LSL #48
    MOVZ  X15, #0xa, LSL #0
TSRTIntCompare_label_5:
    CMN  W26, W2, UXTH #1
    CMN  W21, #0x1ab
    CCMN  W7, #0x18, #0x8, GE
    CMN  X25, X24, ASR #28
    CMN  W24, W23, UXTB #3
    CMP  W27, #0xd8b
    CCMN  X7, X15, #0x9, CS
    CCMP  W28, W23, #0x9, GE
    CCMN  X4, X18, #0xc, LE
    CMP  X15, X18, SXTX #4
    CMP  W20, W16, UXTH #4
    CMP  X16, #0x69b
    CMN  X16, X21, UXTX #1
    CCMN  X22, #0x1b, #0xe, NE
    CCMN  X7, #0x18, #0xe, EQ
    CMN  X28, W24, SXTW #0
    CCMP  W16, #0x16, #0x9, AL
    CMN  X6, #0xd4a
    CCMP  W2, W27, #0x1, NV
    CMP  X4, X15, ASR #61
    CMN  W15, W19, LSL #20
    CMP  W24, W6, SXTX #0
    CMP  W4, #0xb6c
    CMP  W20, W24, ASR #6
    CMN  X6, #0x8cc
    CMN  X2, #0x40f, LSL #12
    CMN  X29, #0xe90, LSL #12
    CMP  W22, W4, LSR #26
    CMN  W26, W19, LSL #16
    CCMN  X19, X20, #0xa, VC
    CMN  W26, W24, LSR #25
    CCMP  W21, W3, #0x8, GT
    CMN  W10, W13, UXTW #3
    CCMP  W7, #0x19, #0x2, EQ
    CCMN  W16, W26, #0x2, VC
    CCMN  W22, #0x16, #0xe, EQ
    CCMP  W15, W4, #0xf, MI
    CMP  W7, W23, SXTX #0
    CMN  W6, W21, UXTB #3
    CMP  X28, #0x90e, LSL #12
    CCMP  W25, #0x12, #0xc, LE
    CMP  X26, X28, LSR #23
    CMP  X16, #0x79b
    CCMN  X15, X13, #0x5, VC
    CMP  X4, X10, LSL #4
    CMP  W7, W27, UXTX #1
    CMP  W13, #0x948, LSL #12
    CMP  X25, X2, LSR #43
    CCMN  W2, W15, #0x1, GT
    CMP  W26, #0x70d, LSL #12
    CMN  W3, #0xc6a, LSL #12
    CMN  X18, X26, LSR #54
    CMP  X4, #0xd02, LSL #12
    CMP  W23, W13, SXTX #1
    CMP  X6, W21, UXTB #0
    CMN  X6, X18, LSR #35
    CCMN  W20, W6, #0xf, VC
    CCMP  W13, W24, #0x7, MI
    CCMN  W2, W13, #0x7, MI
    CMN  X22, #0x50
    CCMP  X4, #0x10, #0x1, VC
    CMN  W18, W18, LSR #12
    CCMP  W13, #0x3, #0x3, PL
    CMN  W29, W19, SXTB #2
    CCMN  W22, W15, #0x7, LS
    CCMP  X23, #0xd, #0x1, EQ
    CCMP  W6, W3, #0x6, GT
    CMP  W23, #0x47d
    CMN  W2, W18, ASR #27
    CCMN  W4, W10, #0x5, CS
    CCMP  X27, #0x2, #0x2, LE
    CMN  X28, W26, UXTH #3
    CCMN  W7, W22, #0x3, PL
    CMN  W25, W27, LSL #22
    CMN  X3, W15, SXTB #2
    CMN  X23, X23, LSR #6
    CMN  X23, #0xe56
    CMN  W10, W2, SXTW #0
    CMN  W2, #0x6a3, LSL #12
    CMN  X18, #0xda8, LSL #12
    CMN  X26, X16, LSR #1
    CMN  X23, X21, SXTX #3
    CMP  X29, #0xbb8
    CMP  X25, X3, SXTX #3
    CMP  W6, W29, UXTX #1
    CMN  X2, #0x63a
    CMN  X25, W24, SXTB #2
    CMP  W3, W21, LSL #13
    CMP  W15, W20, UXTW #1
    CCMN  W21, W6, #0xe, CS
    CCMN  W22, W15, #0x8, NV
    CCMN  X18, #0xe, #0x0, AL
    CMN  W13, #0xa4f, LSL #12
    CMP  W24, W25, UXTH #2
    CMP  W15, #0xe23, LSL #12
    CMP  X23, #0x173, LSL #12
    CMP  W3, #0xf22
    CCMP  W15, W4, #0x9, CC
    CMN  W7, #0xf51, LSL #12
    CCMP  W13, #0x17, #0xf, GT
    CMN  W29, W20, SXTB #1
    CMP  W3, W26, UXTW #0
    CMN  W25, W25, UXTX #4
    CMP  X19, X15, LSR #7
    CMN  W6, W29, UXTB #2
    CMN  X20, X20, LSL #50
    CMN  X20, #0x7b0
    CMP  X2, X3, UXTX #2
    CMN  X13, X7, UXTX #3
    CMN  W27, W25, SXTH #3
    CCMN  W24, #0x6, #0x1, VC
    CMN  W6, W24, SXTX #4
    CCMN  W18, #0xb, #0x1, LT
    CCMP  W28, #0x15, #0x3, LT
    CMP  X26, #0x61d
    CMN  W23, W4, LSL #23
    CMP  X15, W21, SXTW #4
    CCMP  W28, W27, #0x6, NE
    CCMP  W13, W13, #0xd, NE
    CCMN  W29, W15, #0x6, GT
    CMN  W28, W25, SXTX #4
    CMP  X29, #0xa82
    CMN  W25, #0x222
    CMP  X22, W13, UXTH #4
    CMN  X7, W20, SXTB #4
    CMN  W20, #0x595, LSL #12
    CMP  W20, W20, UXTB #0
    CCMP  X28, X10, #0xc, CS
    CMP  W23, #0xa46
    CMP  W13, W3, UXTX #4
    CMN  W28, W23, LSR #16
    CMN  W21, W28, SXTH #3
    CCMP  W23, #0x1, #0xe, EQ
    CMP  X28, #0x7bb, LSL #12
    CMP  X4, X4, ASR #42
    CCMN  W27, #0x0, #0xd, EQ
    CMP  W28, W13, LSL #18
    CCMP  X21, #0x1a, #0x3, LS
    CMP  W19, #0x132, LSL #12
    CCMP  X21, X24, #0xa, GE
    CMP  W21, W2, SXTX #1
    CCMN  W3, #0x1a, #0x2, NV
    CCMP  X7, #0x6, #0x7, GT
    CMP  X29, X22, ASR #47
    CMN  W23, W25, UXTB #4
    CMN  X25, X7, ASR #13
    CMN  X19, X7, ASR #14
    CMP  W16, #0x71a
    CMP  W29, #0x6c, LSL #12
    CMN  X27, X16, LSR #14
    CMN  W27, W3, LSR #22
    CCMN  X4, X23, #0xc, GT
    CCMN  W29, W15, #0x7, CC
    CMN  W4, W27, UXTW #1
    CMP  X10, #0xb6
    CMP  W6, #0x88b
    CMN  W13, W25, SXTX #2
    CCMN  X7, X28, #0x7, LT
    CMN  W23, W3, LSL #24
    CCMN  X2, #0x1, #0x5, VC
    CMN  W26, W7, SXTH #2
    CMP  X18, #0x80b
    CMN  W29, W27, ASR #18
    CCMN  W24, W20, #0xe, CS
    CMP  X21, W20, UXTB #2
    CMP  W24, #0xfda
    CCMP  W3, #0x9, #0x4, HI
    CCMP  W22, #0x12, #0x8, MI
    CMP  X23, X15, ASR #62
    CMN  W20, W25, UXTX #1
    CMN  X3, X19, UXTX #3
    CCMN  X18, X29, #0xe, GT
    CMP  X7, #0xde2, LSL #12
    CCMN  X26, X26, #0xe, LT
    CMP  X25, #0x749, LSL #12
    CMN  W28, #0xc34
    CMN  W4, W6, LSL #31
    CMN  W13, #0xe6c
    CMP  X22, #0xbad
    CCMP  X28, X19, #0x4, GE
    CMP  W3, W26, SXTH #3
    CCMP  X24, X7, #0x1, VS
    CMN  X10, X7, LSL #14
    CMN  W26, #0xc49
    CMN  W26, W4, LSR #8
    CCMN  X26, #0x1f, #0xd, GE
    CMN  X21, X21, LSR #50
    CCMN  X28, X23, #0xa, PL
    CMP  X24, W19, SXTH #2
    CMN  X3, X2, LSL #30
    CMN  W28, W28, UXTX #1
    CMP  W23, W28, LSL #20
    CMP  W7, W4, LSL #9
    CMP  X29, W10, UXTB #4
    CMP  W13, #0x759
    CMP  W7, W10, ASR #16
    CMP  W3, W18, ASR #14
    CCMN  W26, #0x1f, #0xc, GT
    CCMP  X29, X24, #0xe, PL
    CCMN  W6, W15, #0xa, VC
    SUBS  X15, X15, #0x1
    B.NE  TSRTIntCompare_label_5
    MOVZ  X5, #0xd3fe, LSL #0
    MOVK  X5, #0x480f, LSL #16
    MOVK  X5, #0x3002, LSL #32
    MOVK  X5, #0xf276, LSL #48
    SUB  X17, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X5, #0x60fb, LSL #0
    MOVK  X5, #0x2f81, LSL #16
    MOVK  X5, #0x4ade, LSL #32
    MOVK  X5, #0xe7b0, LSL #48
    SUB  X17, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X5, #0xbf8e, LSL #0
    MOVK  X5, #0xcf14, LSL #16
    MOVK  X5, #0x44a3, LSL #32
    MOVK  X5, #0xdf3c, LSL #48
    SUB  X17, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X5, #0x3ac1, LSL #0
    MOVK  X5, #0x28e8, LSL #16
    MOVK  X5, #0x84fb, LSL #32
    MOVK  X5, #0xf43a, LSL #48
    SUB  X17, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X5, #0x8664, LSL #0
    MOVK  X5, #0xf509, LSL #16
    MOVK  X5, #0xe1bf, LSL #32
    MOVK  X5, #0x1f0d, LSL #48
    SUB  X17, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X5, #0x7239, LSL #0
    MOVK  X5, #0x67d, LSL #16
    MOVK  X5, #0x8d59, LSL #32
    MOVK  X5, #0xa6fd, LSL #48
    SUB  X17, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X5, #0x9b72, LSL #0
    MOVK  X5, #0x96f4, LSL #16
    MOVK  X5, #0xae9d, LSL #32
    MOVK  X5, #0xca1, LSL #48
    SUB  X17, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X5, #0xb2e0, LSL #0
    MOVK  X5, #0xcfa6, LSL #16
    MOVK  X5, #0x9613, LSL #32
    MOVK  X5, #0xd32e, LSL #48
    SUB  X17, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X5, #0xf312, LSL #0
    MOVK  X5, #0xff80, LSL #16
    MOVK  X5, #0x4449, LSL #32
    MOVK  X5, #0x90fb, LSL #48
    SUB  X17, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X5, #0x59fb, LSL #0
    MOVK  X5, #0xb685, LSL #16
    MOVK  X5, #0xc78f, LSL #32
    MOVK  X5, #0xf0e2, LSL #48
    SUB  X17, X5, X19
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X5, #0xe11a, LSL #0
    MOVK  X5, #0x733a, LSL #16
    MOVK  X5, #0x6613, LSL #32
    MOVK  X5, #0x1ba2, LSL #48
    SUB  X17, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X5, #0x1090, LSL #0
    MOVK  X5, #0x9719, LSL #16
    MOVK  X5, #0x841c, LSL #32
    MOVK  X5, #0xa5b1, LSL #48
    SUB  X17, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X5, #0x8995, LSL #0
    MOVK  X5, #0xd98e, LSL #16
    MOVK  X5, #0x5c88, LSL #32
    MOVK  X5, #0x1a3b, LSL #48
    SUB  X17, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X5, #0xa047, LSL #0
    MOVK  X5, #0x4dbd, LSL #16
    MOVK  X5, #0xacc3, LSL #32
    MOVK  X5, #0x8421, LSL #48
    SUB  X17, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X5, #0xd62f, LSL #0
    MOVK  X5, #0x8dae, LSL #16
    MOVK  X5, #0xe609, LSL #32
    MOVK  X5, #0x9a35, LSL #48
    SUB  X17, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X5, #0xc3e8, LSL #0
    MOVK  X5, #0xe9f, LSL #16
    MOVK  X5, #0x6fb8, LSL #32
    MOVK  X5, #0x1b5b, LSL #48
    SUB  X17, X5, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X5, #0xde5b, LSL #0
    MOVK  X5, #0xb11e, LSL #16
    MOVK  X5, #0x24b6, LSL #32
    MOVK  X5, #0x3ff6, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X5, #0x89c3, LSL #0
    MOVK  X5, #0xecca, LSL #16
    MOVK  X5, #0x9da2, LSL #32
    MOVK  X5, #0x882d, LSL #48
    SUB  X17, X5, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X5, #0x5b64, LSL #0
    MOVK  X5, #0x1663, LSL #16
    MOVK  X5, #0xd100, LSL #32
    MOVK  X5, #0x4521, LSL #48
    SUB  X17, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X5, #0xb710, LSL #0
    MOVK  X5, #0x413e, LSL #16
    MOVK  X5, #0xdf3b, LSL #32
    MOVK  X5, #0x2e02, LSL #48
    SUB  X17, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
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
    MOVZ  X19, #0xa, LSL #0
TSRTIntCompare_label_6:
    CCMN  X15, #0xc, #0xf, NV
    CCMN  X22, #0x1, #0x7, PL
    CCMP  W24, W25, #0x6, MI
    CCMN  X16, #0xd, #0xe, VC
    CMN  W17, W18, UXTX #2
    CMN  X28, X21, ASR #31
    CMP  W19, W23, SXTX #4
    CCMN  W19, W27, #0x2, PL
    CCMP  W2, W29, #0xc, LS
    CCMN  W26, W29, #0xd, GE
    CCMP  W23, W4, #0x8, GT
    CMN  W3, W21, SXTW #4
    CMN  X25, X2, ASR #14
    CMN  X18, X10, ASR #62
    CCMN  X19, X24, #0xd, CC
    CCMP  X4, #0x7, #0x3, MI
    CCMN  W27, W24, #0xb, NV
    CCMN  W15, #0x1c, #0x4, EQ
    CCMP  W21, #0xb, #0x7, MI
    CMN  W26, W25, SXTH #4
    CMN  X2, X17, UXTX #2
    CMP  X2, #0xdd2
    CMN  W5, W18, SXTB #1
    CMN  X19, X3, LSL #37
    CCMP  X7, X29, #0xa, NE
    CCMN  X27, X19, #0x6, GE
    CMN  X7, X7, ASR #14
    CMN  W17, #0x993, LSL #12
    CMP  W23, W18, SXTH #3
    CCMP  X23, X7, #0x7, AL
    CMP  X26, X27, ASR #30
    CCMP  X5, #0x1d, #0xe, NE
    CCMP  X17, X24, #0x4, NV
    CMP  W4, W10, LSL #29
    CCMP  X24, #0x5, #0xb, CC
    CCMN  X2, #0x16, #0x1, HI
    CCMP  X26, X6, #0x0, AL
    CMP  W17, #0xb25
    CMP  X17, X27, LSL #58
    CMN  W7, #0x17c
    CCMP  X21, #0x8, #0x5, GE
    CMP  X7, X26, LSR #0
    CMP  W10, #0x63d, LSL #12
    CMP  X16, X24, SXTX #3
    CCMP  W24, #0x3, #0x8, EQ
    CCMP  W29, W10, #0xe, LT
    CMP  X25, X26, ASR #40
    CCMP  W3, #0x14, #0x3, NE
    CCMP  W29, #0x1d, #0xf, VC
    CMP  W23, #0x32d
    CMP  X19, X29, LSL #49
    CMN  W10, #0xfff
    CMN  X5, X18, ASR #16
    CMN  X19, #0xd0c, LSL #12
    CCMN  W21, W24, #0xa, MI
    CCMN  W19, #0x10, #0x5, EQ
    CMP  W15, W3, UXTX #3
    CMN  X16, #0xdb
    CCMP  W17, #0xf, #0x8, PL
    CCMP  W6, #0x4, #0x0, VC
    CCMP  X25, #0x1c, #0x6, GT
    CCMP  X18, X26, #0x1, HI
    CMN  W10, W2, SXTH #1
    CMP  X22, #0x17d, LSL #12
    CCMN  X25, X19, #0x7, HI
    CCMP  W21, W2, #0x8, CS
    CCMN  W28, W19, #0x8, EQ
    CMP  X19, #0x6ca
    CCMN  X4, X21, #0x4, MI
    CMP  X27, #0x51f
    CMN  W26, #0x4bc
    CMP  W27, #0xe4a, LSL #12
    CMN  X25, X22, ASR #13
    CMP  X15, X25, LSR #61
    CMP  X6, X4, UXTX #2
    CCMP  X22, X21, #0xf, GE
    CMN  X3, W15, SXTW #0
    CMN  W15, W24, LSR #7
    CCMP  W27, W26, #0x8, GE
    CCMP  W18, W17, #0x8, LE
    CMN  W29, W29, LSR #6
    CMN  W21, W25, SXTX #2
    CCMN  X17, #0x6, #0xe, CS
    CMN  W28, W15, LSR #17
    CMP  W17, W19, ASR #18
    CCMP  W28, #0xb, #0xf, CS
    CMN  W24, W22, LSL #28
    CCMP  W19, W6, #0x6, HI
    CCMN  X4, #0x3, #0xc, CC
    CMN  X15, X22, LSL #53
    CCMP  X28, X10, #0x4, VS
    CMP  W16, W25, UXTX #2
    CCMN  W27, #0x13, #0x3, MI
    CMN  X29, #0x8a4
    CMP  X6, #0x456
    CMN  W10, #0xfd7, LSL #12
    CMN  X24, X2, LSL #49
    CMP  X28, W22, UXTH #0
    CMN  X26, W16, SXTB #3
    CCMP  X15, #0x13, #0x3, NE
    CMP  X27, X18, LSR #2
    CCMP  X23, X28, #0x0, VC
    CCMN  W26, #0x1a, #0x0, EQ
    CMN  W10, W5, UXTW #4
    CMN  X19, #0xcd6
    CMP  W7, #0xef7, LSL #12
    CMN  W2, #0x851
    CMN  W6, W24, SXTH #0
    CMP  W7, W27, LSL #28
    CMN  X22, X17, LSR #54
    CMP  X19, #0x541, LSL #12
    CMN  W19, W21, LSL #5
    CCMN  W2, #0x1c, #0xc, LE
    CMN  W7, W24, UXTW #1
    CMP  W16, W17, ASR #20
    CMN  X28, X16, LSL #61
    CCMN  X2, #0x1d, #0xa, GT
    CCMN  W29, #0xb, #0xf, LT
    CCMN  W24, #0x1e, #0x2, GT
    CMP  X17, #0xc2f
    CMN  W10, #0x459, LSL #12
    CMP  W25, W28, SXTH #0
    CMN  W2, #0x269
    CCMN  W4, W18, #0x1, VS
    CCMP  X22, X10, #0x7, AL
    CCMN  W28, #0x1, #0x7, PL
    CCMP  W6, #0x1f, #0x9, HI
    CCMP  W17, #0x12, #0x9, PL
    CMN  X2, #0x344, LSL #12
    CMP  X23, W27, SXTW #3
    CCMN  W6, #0x14, #0x7, AL
    CMP  X15, X10, LSR #56
    CMP  W4, W17, UXTH #4
    CMN  W24, W21, UXTH #1
    CMN  X15, W7, UXTB #2
    CCMN  X25, X2, #0xc, CS
    CMN  W16, W3, UXTB #1
    CCMP  X18, #0x1f, #0x3, PL
    CCMP  X24, X23, #0xb, CS
    CCMN  W25, #0x1b, #0xb, VC
    CCMP  W18, W4, #0x9, EQ
    CMP  W25, W23, LSR #18
    CMP  W4, #0xe06, LSL #12
    CMP  X22, X26, UXTX #2
    CCMP  W24, W10, #0xc, EQ
    CMP  X15, X18, LSR #60
    CMP  X5, #0xb59
    CCMP  W28, #0xe, #0x9, HI
    CMN  W24, #0x146, LSL #12
    CCMP  W23, #0xf, #0xb, VS
    CCMP  W21, #0x12, #0x6, VC
    CCMP  X16, #0x17, #0xb, GT
    CCMN  X26, X27, #0x0, GT
    CMN  X5, #0x731, LSL #12
    CMP  W15, W4, LSL #6
    CMP  X21, X28, LSL #60
    CCMN  X3, #0x1a, #0x5, MI
    CMP  W19, W22, UXTW #4
    CCMN  X3, #0x2, #0xf, CC
    CMP  X7, X5, LSR #47
    CCMN  X25, X7, #0xd, LE
    CCMN  X26, #0x10, #0x5, CC
    CCMN  W22, #0x13, #0x4, VC
    CMP  X4, X26, LSL #18
    CMN  W25, W29, SXTH #4
    CMP  X2, W22, UXTB #0
    CMP  X10, X26, UXTX #4
    CMN  W7, W15, UXTX #1
    CMP  X26, X18, LSR #14
    CMP  W26, #0x211
    CMN  W5, #0xdfc
    CMP  W7, #0x31c
    CMN  X10, #0x188, LSL #12
    CMN  X7, #0x521, LSL #12
    CMN  X4, W19, UXTH #0
    CCMN  W4, #0x6, #0x4, MI
    CMN  X21, X27, LSR #40
    CMN  X5, X29, ASR #19
    CMP  W26, W6, SXTB #4
    CCMP  W23, W10, #0xa, NE
    CMN  W26, W3, ASR #16
    CMP  W28, W28, SXTH #3
    CMP  W19, W6, ASR #19
    CMN  X4, #0xa4c
    CCMN  W19, #0x12, #0xa, PL
    CMN  W4, W23, LSR #10
    CMN  W4, W6, ASR #23
    CCMN  W22, #0x0, #0xd, AL
    CCMP  W3, W3, #0x4, VC
    CCMP  X22, X7, #0xc, LE
    CMP  W22, #0x2d1, LSL #12
    CMP  X25, #0x46a, LSL #12
    CCMP  X10, #0x1f, #0xb, LE
    CMN  W7, #0x8a4, LSL #12
    CCMN  X25, X16, #0xe, GE
    CCMN  X23, X7, #0x5, VC
    CMN  X17, X16, ASR #59
    CCMP  X26, #0x9, #0x4, CC
    CMP  W18, W3, LSL #16
    CMP  X27, X10, LSL #43
    SUBS  X19, X19, #0x1
    B.NE  TSRTIntCompare_label_6
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCompare_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCompare_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCompare_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCompare_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCompare_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCompare_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCompare_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCompare_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCompare_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCompare_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCompare_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCompare_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCompare_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCompare_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCompare_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCompare_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCompare_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCompare_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCompare_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCompare_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCompare_TestFail
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
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
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
    MOVZ  X4, #0xa, LSL #0
TSRTIntCompare_label_7:
    CCMN  X25, #0xd, #0x1, MI
    CMP  W7, W15, SXTX #1
    CCMP  X13, X26, #0xe, GT
    CMN  X20, X28, LSR #2
    CMP  W4, #0x67f
    CCMP  X28, X16, #0x9, PL
    CMP  X24, X29, LSR #1
    CCMN  W21, W20, #0x4, GE
    CMN  W28, W4, LSL #21
    CCMP  W18, W26, #0x2, GT
    CCMN  W22, #0x4, #0x9, GT
    CCMP  X19, #0x19, #0xc, VS
    CCMP  X2, #0x12, #0xe, GT
    CCMN  X10, X3, #0xb, EQ
    CCMN  X13, #0x1b, #0xa, VS
    CCMN  X13, #0x17, #0xc, EQ
    CCMP  X7, #0x1, #0xb, LS
    CMN  W25, W23, UXTH #2
    CCMN  W21, #0x6, #0x6, MI
    CMN  W15, #0xd61, LSL #12
    CMP  W13, W20, ASR #16
    CCMN  W24, #0xb, #0x8, LT
    CMN  W16, #0xdfe, LSL #12
    CCMN  W22, #0xc, #0xe, LE
    CCMN  X10, #0x14, #0xd, LS
    CMN  X22, #0x84d
    CCMN  X10, #0x2, #0x6, LT
    CMN  W7, W21, LSR #15
    CCMP  W10, W23, #0x9, GE
    CMP  W24, W19, SXTW #3
    CCMP  W25, W18, #0x5, PL
    CMP  W2, W24, UXTB #0
    CMN  W21, #0x331, LSL #12
    CMN  W18, W26, SXTX #4
    CMP  W6, W7, SXTH #0
    CCMP  X16, #0x18, #0xd, VS
    CMP  W10, #0x830
    CMN  X18, X28, SXTX #2
    CMN  X6, X25, LSL #33
    CMP  X22, #0x59d, LSL #12
    CCMN  W25, #0x15, #0xc, CC
    CCMP  X18, #0x1, #0xf, VC
    CMP  X16, W28, UXTW #4
    CMN  X7, X15, UXTX #0
    CCMN  X29, #0x1b, #0x9, LE
    CMN  W25, #0x7d8, LSL #12
    CCMN  W26, W22, #0xd, LE
    CCMN  W2, #0x3, #0x1, GT
    CMP  X25, #0x15d, LSL #12
    CMP  W2, W5, UXTW #4
    CCMP  X20, X2, #0xf, AL
    CCMN  W26, #0xa, #0x4, CC
    CCMP  X3, #0x1b, #0xa, MI
    CMP  W3, W4, UXTW #1
    CMP  W23, W20, LSR #21
    CMN  X19, X2, LSL #19
    CMP  X23, X29, LSL #30
    CMN  X25, #0x360, LSL #12
    CMP  X13, #0xa89
    CMP  X26, W22, UXTB #1
    CMP  W7, #0xbed, LSL #12
    CCMN  W22, #0xd, #0x0, AL
    CMP  X3, X29, LSL #59
    CMP  W29, W20, UXTH #4
    CMN  W25, #0x14d, LSL #12
    CMP  W6, W25, ASR #1
    CMN  W10, #0x9d0
    CMN  W26, W26, SXTH #0
    CCMN  W7, W26, #0x7, EQ
    CMN  W19, #0x75f
    CCMN  X26, X20, #0x9, EQ
    CMN  X23, #0xccc
    CMP  W29, #0x720, LSL #12
    CCMP  W19, #0xb, #0x4, NV
    CMP  X15, W10, SXTB #0
    CCMP  X29, #0x1a, #0x5, LS
    CMP  X26, X18, LSR #57
    CCMN  X19, X16, #0x5, GE
    CCMP  X10, #0x10, #0x8, NE
    CMN  W20, W26, ASR #27
    CMN  W7, #0x637
    CMP  W21, W19, ASR #25
    CMN  X26, X22, LSL #56
    CCMN  W23, #0xf, #0x7, AL
    CMN  X26, #0xb17
    CMP  X7, X24, LSL #36
    CMN  X6, #0xab7
    CMN  X18, #0xea0
    CMP  W24, W4, ASR #14
    CCMP  X15, X2, #0x2, NE
    CMP  W20, #0x209, LSL #12
    CCMP  W24, #0x1c, #0x9, GE
    CCMP  X24, #0x15, #0xe, CS
    CCMP  W19, W10, #0xd, VC
    CMN  W18, W19, LSR #20
    CCMP  X19, X19, #0x1, CC
    CMP  W22, W6, SXTH #3
    CCMP  X28, X6, #0x7, AL
    CCMP  W23, #0x10, #0xa, HI
    CCMN  W10, #0x1b, #0xd, NV
    CMP  W26, W29, UXTW #3
    CMP  X4, X19, LSR #54
    CCMP  X25, X29, #0x8, LE
    CMN  X21, #0x81c, LSL #12
    CCMP  W4, #0x9, #0x5, NE
    CMP  W26, W24, UXTW #3
    CCMP  X20, #0x9, #0xf, GT
    CMP  W26, W24, LSR #16
    CCMN  X29, #0xb, #0xd, CC
    CMN  X19, W10, UXTB #0
    CMP  X10, X20, LSR #13
    CCMN  X4, #0x16, #0x5, LS
    CMP  X18, X28, LSR #53
    CMN  W21, #0xf47
    CMN  X21, #0x882
    CCMP  X28, X15, #0x8, PL
    CMP  W2, W26, ASR #8
    CCMP  W20, W21, #0xe, AL
    CMP  W3, #0x184
    CMN  X3, #0xaf8, LSL #12
    CCMN  X21, #0x10, #0x4, PL
    CMN  X23, X21, UXTX #1
    CCMN  X13, X28, #0xf, CC
    CCMN  W29, W24, #0x6, CC
    CMP  X23, W26, SXTB #1
    CMN  W3, #0x93, LSL #12
    CMP  X15, #0x3f2
    CCMN  X22, X26, #0x9, EQ
    CMN  X21, X20, SXTX #1
    CCMN  X20, X18, #0x7, NE
    CMP  X19, #0x922
    CCMP  W25, #0x5, #0xd, LS
    CCMN  X6, X2, #0xb, MI
    CMP  W24, W19, SXTW #4
    CCMN  W6, #0x1f, #0x9, MI
    CMN  W23, W4, SXTB #3
    CMP  X13, #0x771, LSL #12
    CMP  X5, #0x116, LSL #12
    CMP  X18, X28, ASR #25
    CMP  W6, #0x934, LSL #12
    CMP  W15, W16, SXTX #3
    CCMN  W10, #0x8, #0x7, LE
    CCMP  W20, #0x19, #0x9, NE
    CMP  X7, X23, SXTX #1
    CCMP  X13, #0xb, #0x7, CC
    CMP  X20, #0x509, LSL #12
    CCMN  W4, W21, #0x4, LE
    CCMN  W19, W21, #0x3, GE
    CCMP  W2, W4, #0x3, VC
    CCMN  X19, #0x12, #0x2, CC
    CCMN  W5, W20, #0x3, VS
    CMN  X25, W25, SXTW #3
    CMN  W15, #0xc43
    CMP  W5, W16, LSR #1
    CMP  X3, W5, SXTW #0
    CMP  X4, W28, UXTB #1
    CMP  W22, W10, UXTW #3
    CMP  X26, X20, ASR #46
    CMN  X26, X4, LSR #7
    CMN  W6, W2, ASR #15
    CMP  W5, W29, LSL #12
    CMP  X20, X26, SXTX #0
    CMP  X24, W2, SXTB #0
    CCMN  X28, #0x0, #0x9, HI
    CMN  W5, W28, UXTX #0
    CCMN  X20, X23, #0xe, MI
    CCMP  W13, W21, #0x3, LE
    CCMN  X18, X10, #0x2, GT
    CCMN  W29, #0x19, #0x8, LE
    CMP  X15, #0x612, LSL #12
    CMP  X21, #0x380
    CMN  X15, W15, UXTB #3
    CCMP  W15, W24, #0x1, LS
    CMN  X28, W26, SXTH #1
    CMP  W21, #0xe1e
    CMN  X25, W22, SXTH #4
    CMP  X18, #0xb26, LSL #12
    CCMP  X6, #0x4, #0xe, PL
    CMP  W29, W20, UXTX #2
    CMN  W29, #0x650, LSL #12
    CMN  W26, W26, SXTH #2
    CMP  W29, #0xadf
    CMP  W15, W4, LSL #18
    CMN  W26, W28, LSR #27
    CCMN  X29, #0xd, #0xa, GE
    CMP  X26, X22, ASR #7
    CMP  W28, W23, LSR #6
    CMN  W26, #0xaab, LSL #12
    CCMN  W19, W19, #0x1, LT
    CCMP  W10, #0x1e, #0x4, CC
    CMN  W24, #0xdd9
    CCMP  X7, X15, #0x6, CC
    CCMN  W25, #0xc, #0xc, MI
    CMN  W23, W13, SXTB #2
    CCMN  X3, X24, #0x0, PL
    CMN  X7, #0x4c8, LSL #12
    CMN  X3, W13, SXTW #0
    CMN  W16, W29, ASR #8
    CCMP  W13, #0x7, #0x5, CS
    CMN  X21, W21, SXTB #1
    SUBS  X4, X4, #0x1
    B.NE  TSRTIntCompare_label_7
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X27, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntCompare_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
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
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
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
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    MOVZ  X7, #0xa, LSL #0
TSRTIntCompare_label_8:
    CCMN  X25, X13, #0xb, NE
    CCMN  X28, #0x7, #0x8, EQ
    CMP  X29, #0x3b9
    CMN  W26, #0xb99
    CMP  W18, #0x8, LSL #12
    CMP  X17, #0xe44, LSL #12
    CMP  X20, X7, SXTX #1
    CCMN  X23, #0xc, #0x6, CC
    CMN  X27, X24, ASR #8
    CMP  X20, X28, LSR #52
    CCMP  X5, #0xe, #0x3, PL
    CMN  W22, W26, LSR #14
    CCMN  W16, W24, #0xf, HI
    CMP  X19, X20, ASR #4
    CCMP  W22, W7, #0x8, EQ
    CCMP  W29, #0xa, #0xc, GE
    CCMP  W13, W17, #0x2, CS
    CMP  X20, #0xbe3, LSL #12
    CCMN  X10, #0x1a, #0xd, CS
    CCMN  W28, #0x6, #0x7, AL
    CMP  X18, X23, LSR #21
    CMP  X3, #0x11c, LSL #12
    CMP  W23, #0x578
    CMP  X21, X23, SXTX #0
    CMN  W18, W23, LSR #0
    CCMP  X22, X10, #0xa, EQ
    CCMP  X6, #0x6, #0x0, VS
    CMN  X21, X22, LSR #51
    CCMN  X25, X6, #0xf, PL
    CMN  X16, #0x2d, LSL #12
    CMN  X20, #0x230
    CMN  X28, X26, LSL #55
    CCMN  W24, #0x1e, #0x2, MI
    CCMP  W13, #0x1b, #0xc, HI
    CCMP  X10, #0x12, #0x2, PL
    CMN  W5, W7, ASR #17
    CMP  W16, W22, LSL #6
    CMN  W26, #0x805
    CMN  W20, #0x321
    CCMN  W15, #0x1a, #0x4, MI
    CCMP  W29, W6, #0x1, LS
    CCMN  W26, W24, #0xe, LE
    CMP  X17, W3, SXTB #2
    CMN  W22, W19, ASR #25
    CCMN  W6, #0x5, #0x5, LS
    CMP  W13, W16, SXTH #4
    CMN  W5, W19, UXTB #4
    CMP  W20, #0x801
    CMP  W19, W10, ASR #23
    CCMN  W28, #0x3, #0x7, LS
    CMN  X18, #0x5c9
    CMN  W16, W21, UXTW #3
    CMN  W27, W17, LSR #19
    CMN  X15, W21, UXTW #2
    CMP  X5, X29, LSR #40
    CCMN  W6, W17, #0x5, CS
    CMN  W29, W17, UXTX #4
    CCMN  X22, #0x11, #0x7, LS
    CCMP  W10, W22, #0x9, NE
    CMN  W21, W28, SXTX #1
    CMP  W17, #0xc46, LSL #12
    CCMN  X26, X15, #0xf, NV
    CCMN  X27, X26, #0xd, GE
    CMN  X24, X27, UXTX #4
    CMN  X6, X22, ASR #47
    CMN  W19, #0x543, LSL #12
    CMP  X23, X23, SXTX #1
    CMP  X16, W10, UXTW #3
    CCMN  X16, #0xd, #0x7, CS
    CMP  X20, W17, SXTW #2
    CCMP  X5, X6, #0xa, AL
    CMP  X7, X10, ASR #4
    CMN  W6, #0xcab, LSL #12
    CCMP  X17, #0x1c, #0x1, EQ
    CMP  X10, W23, UXTW #4
    CMP  W20, W6, UXTH #0
    CMP  X19, W10, UXTW #1
    CCMP  X23, X24, #0x0, LE
    CMN  W20, W10, SXTB #3
    CCMN  W17, #0x7, #0xb, EQ
    CMP  W28, W5, LSR #24
    CMP  X19, #0xfee, LSL #12
    CMP  X25, X26, LSR #17
    CMP  W17, W25, LSL #21
    CMN  X20, W7, SXTH #1
    CMN  W13, W29, SXTB #1
    CMP  W5, #0xb44
    CMP  X5, W23, SXTW #3
    CMP  W13, W25, SXTB #1
    CMN  X22, X22, ASR #55
    CMN  W20, W5, ASR #15
    CCMP  W26, W17, #0xa, VC
    CMN  W26, W18, ASR #28
    CMP  X27, W22, UXTW #4
    CMN  X20, X5, LSR #2
    CMP  X6, #0x6f6, LSL #12
    CMP  X28, X21, ASR #58
    CCMN  X7, #0x8, #0xc, VS
    CCMN  X3, X6, #0x9, LT
    CCMP  W29, W21, #0x2, NV
    CCMP  X28, X13, #0xa, LS
    CCMP  X25, X28, #0x8, VS
    CMP  W22, W27, ASR #15
    CMP  W21, W5, SXTW #1
    CMN  X24, X10, LSR #13
    CMN  W28, #0x25b
    CMN  W13, W26, UXTH #1
    CMP  W21, #0xe1
    CCMN  X13, #0x12, #0x6, GE
    CMN  W20, W10, LSL #22
    CMP  W5, #0x68b, LSL #12
    CCMN  W22, #0x7, #0x9, LE
    CMP  X29, #0x2c0, LSL #12
    CCMP  W16, #0x1f, #0xc, LS
    CMN  X28, #0x651, LSL #12
    CCMP  W25, #0x13, #0x1, HI
    CMP  W5, W17, LSR #20
    CMP  X3, W5, SXTB #2
    CMP  X18, #0xbe8
    CCMN  W17, #0x10, #0x2, GE
    CMN  W21, #0x148, LSL #12
    CMN  X26, W19, SXTW #0
    CMP  X13, X18, ASR #54
    CMN  W7, #0x905, LSL #12
    CMN  W28, W16, SXTH #1
    CMP  W15, W6, UXTH #1
    CMN  X20, #0x30b
    CMN  X16, #0x4eb
    CMP  X13, W21, UXTH #2
    CMN  X16, X17, LSL #57
    CMP  W18, W29, ASR #7
    CMP  W26, W25, LSL #27
    CMN  X22, W10, UXTW #3
    CMP  X16, W29, SXTB #1
    CCMN  W6, W16, #0xf, CS
    CMP  W27, #0x4f9
    CCMN  W19, #0x4, #0x8, LS
    CMN  W26, #0xd9a, LSL #12
    CMP  X26, #0x1df, LSL #12
    CMN  W23, W22, LSL #26
    CMN  X22, W15, SXTW #1
    CCMP  W18, W17, #0x7, NV
    CMP  X16, #0x787, LSL #12
    CMP  W13, #0xaaf
    CMN  W5, W29, SXTB #1
    CCMN  X27, #0x15, #0xe, LS
    CCMN  X16, X21, #0xe, LT
    CMP  X22, #0x333, LSL #12
    CMN  X15, W6, UXTH #2
    CMP  X7, W24, SXTB #1
    CCMN  X29, X10, #0xf, GE
    CMP  W22, #0xe24
    CMN  W15, #0x925
    CMP  W23, #0x650, LSL #12
    CCMP  X16, X20, #0xe, LS
    CCMP  X20, #0x6, #0x6, LS
    CMP  X22, X23, LSL #53
    CCMN  X10, X18, #0xd, MI
    CCMP  W21, #0x3, #0x4, PL
    CMP  X22, X16, SXTX #0
    CCMN  W10, #0x1, #0xd, LS
    CMN  W5, W27, SXTB #1
    CCMP  X23, #0x17, #0xb, EQ
    CMN  W21, #0x4cf, LSL #12
    CCMN  X28, X27, #0x2, EQ
    CCMN  X26, X27, #0xf, CS
    CCMN  W24, #0x1e, #0x0, LT
    CCMP  X10, X20, #0x0, VS
    CCMP  X24, #0x7, #0x0, LS
    CMN  X15, W6, UXTW #0
    CCMN  W18, #0x12, #0xb, GE
    CCMP  X15, #0x12, #0x5, GE
    CCMN  W26, #0x9, #0x7, LS
    CMN  W25, #0x85d, LSL #12
    CCMN  X6, X28, #0x7, VS
    CMP  W24, W19, SXTX #3
    CMN  W13, W20, SXTB #3
    CCMN  X16, #0xa, #0x4, AL
    CMP  X22, X6, ASR #55
    CMP  X29, #0xa03, LSL #12
    CMN  X7, #0x806, LSL #12
    CMN  W28, W15, UXTX #1
    CCMP  X26, X21, #0x5, NE
    CCMN  W25, W23, #0xc, LS
    CCMN  W6, #0x7, #0x7, VC
    CCMN  W28, #0x6, #0xe, LE
    CCMN  W20, W25, #0x9, MI
    CMP  W20, W24, SXTH #2
    CMN  X5, #0x7b3
    CCMN  X6, X28, #0x9, LS
    CMP  X18, W22, UXTH #2
    CMN  W17, W17, LSR #26
    CMN  W5, W26, LSR #5
    CMP  W3, W18, LSL #11
    CMP  X24, #0x2b8
    CMN  X15, W3, UXTW #1
    CCMN  X15, #0x10, #0x1, CC
    CCMN  W24, #0xa, #0xa, VS
    CCMP  X26, #0x1, #0xa, MI
    CMN  X6, X27, LSL #41
    SUBS  X7, X7, #0x1
    B.NE  TSRTIntCompare_label_8
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X4, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCompare_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X4, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCompare_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X4, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCompare_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X4, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCompare_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X4, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCompare_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCompare_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X4, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCompare_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X4, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCompare_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X4, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCompare_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X4, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCompare_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCompare_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X4, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCompare_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X4, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCompare_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X4, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCompare_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X4, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCompare_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X4, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCompare_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X4, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCompare_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X4, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCompare_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X4, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCompare_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X4, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCompare_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
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
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
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
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    MOVZ  X28, #0xa, LSL #0
TSRTIntCompare_label_9:
    CMP  W28, W28, SXTB #1
    CMN  W26, W26, LSR #29
    CMP  X27, #0x2a3
    CMP  X29, W3, SXTW #1
    CCMN  W4, W4, #0x1, HI
    CMN  W2, W27, ASR #14
    CMN  W27, #0xd35, LSL #12
    CCMN  W22, W19, #0xe, VS
    CMN  X15, W6, UXTH #4
    CCMN  W25, #0x1d, #0xa, EQ
    CMP  X17, #0xb7b
    CCMN  W7, #0xa, #0x4, NE
    CMP  W27, W28, UXTW #1
    CCMN  W10, #0x10, #0x2, HI
    CMP  X3, #0x1f
    CCMP  X28, #0x1d, #0x9, AL
    CMP  X16, X18, SXTX #3
    CMP  W6, W4, LSR #23
    CMN  W6, #0x896
    CMN  W7, W26, UXTW #1
    CMN  W23, W16, UXTH #4
    CMN  W6, W19, LSR #13
    CCMN  X26, #0x4, #0xc, HI
    CMN  X28, X5, ASR #13
    CMN  X25, X19, LSL #6
    CMN  W22, W4, LSR #4
    CMN  X24, X4, SXTX #0
    CMN  X26, #0xbad
    CMP  W26, W7, SXTB #0
    CCMN  W24, W2, #0xc, LS
    CCMN  W28, #0xe, #0x6, GE
    CMN  X18, X22, SXTX #0
    CMP  W29, W7, LSR #24
    CMP  W18, W7, UXTB #1
    CCMP  W15, #0x13, #0x2, CC
    CMN  W26, W2, LSL #16
    CMN  X18, X13, ASR #62
    CMP  X6, X6, ASR #4
    CMP  W17, #0x457
    CMN  W10, W13, SXTW #1
    CCMP  W6, #0x9, #0x5, CS
    CCMP  W29, W10, #0x9, NE
    CMP  X13, X4, UXTX #0
    CMN  X27, #0x996, LSL #12
    CCMN  W5, #0xa, #0x4, GE
    CMN  X5, W15, UXTH #0
    CCMP  W15, #0x1b, #0x9, NV
    CCMP  X18, #0x11, #0x4, MI
    CMP  X26, W22, UXTH #4
    CCMP  W7, #0x1c, #0xe, MI
    CMN  W4, W3, LSR #1
    CMN  X25, X28, ASR #54
    CCMP  W6, #0xd, #0xa, LE
    CMP  X27, W7, UXTW #0
    CMN  W2, W18, SXTH #0
    CMN  W22, W2, LSR #2
    CMP  X27, #0xc3a
    CMN  X18, X13, LSL #52
    CCMP  X5, X6, #0x6, LE
    CCMN  W23, W19, #0x1, NE
    CCMN  W24, W2, #0x2, GT
    CMN  X4, W2, UXTH #4
    CMP  W19, W24, SXTB #0
    CMN  W10, W28, UXTB #0
    CCMN  W26, #0x17, #0x6, LE
    CMP  W10, W4, UXTW #3
    CMP  W26, W27, UXTX #3
    CMN  X23, #0x926, LSL #12
    CCMN  X19, X29, #0xe, NV
    CMN  W23, #0xe30, LSL #12
    CCMP  W4, #0x17, #0xa, VC
    CMN  W19, W16, UXTX #1
    CMN  X3, W26, UXTB #2
    CCMN  X24, #0xa, #0xa, NV
    CMN  X17, #0x61d
    CMN  W13, #0x823
    CMN  W5, W18, UXTH #4
    CCMN  W3, W29, #0xb, CS
    CMN  X7, X13, SXTX #3
    CMP  W26, W24, ASR #10
    CMP  W25, #0xb0f
    CCMP  X29, #0x3, #0x5, GT
    CMN  X7, X18, SXTX #2
    CMP  W22, W24, UXTB #2
    CMP  X25, W3, SXTH #1
    CCMN  W2, #0x7, #0x9, PL
    CMN  W18, W18, LSL #31
    CMN  X2, #0xa03
    CMP  X24, W17, SXTW #1
    CMN  W27, W25, LSL #5
    CMP  X13, W25, SXTB #0
    CMN  W13, W24, UXTB #3
    CMP  X3, X7, SXTX #2
    CCMN  X4, X25, #0xa, AL
    CMN  W18, W25, SXTW #3
    CCMP  W16, W18, #0xb, NV
    CCMN  X7, #0x12, #0xd, PL
    CCMP  W7, #0x13, #0x8, CC
    CMP  W10, W2, UXTW #0
    CMN  X27, W29, SXTB #4
    CCMP  X13, X15, #0x8, VC
    CMP  W27, W7, SXTH #0
    CMP  W18, W19, LSL #11
    CMN  X29, W10, SXTB #2
    CCMN  W5, #0x13, #0x2, LT
    CCMP  W22, #0x8, #0xe, AL
    CMN  W5, #0x910, LSL #12
    CMP  X4, #0x894
    CMN  X27, #0xafc
    CCMP  X23, X28, #0x4, NE
    CCMP  W26, #0x9, #0xf, LS
    CCMP  W13, #0x1e, #0x9, CC
    CMP  W5, W5, UXTH #3
    CCMP  X19, #0x3, #0x9, CS
    CCMP  W3, #0x4, #0xb, MI
    CMN  W28, W15, SXTB #3
    CCMN  X5, #0x1, #0x3, NE
    CCMP  X23, #0x3, #0x5, HI
    CCMN  X3, #0x14, #0x7, PL
    CMN  W27, W5, LSR #19
    CCMP  X22, X29, #0x6, LT
    CMP  X25, W29, SXTH #4
    CMP  X18, X6, LSR #57
    CMP  W5, #0xca4, LSL #12
    CMN  W22, W3, LSL #16
    CCMP  W18, #0x13, #0xb, NE
    CMP  X17, #0x803, LSL #12
    CCMN  W13, W16, #0x9, AL
    CMN  X4, W29, SXTB #4
    CMN  W27, W15, SXTW #2
    CCMN  W29, W5, #0xc, CC
    CMN  X23, W29, UXTB #0
    CMP  W15, W18, UXTB #3
    CMN  W6, W24, UXTX #1
    CMN  W25, W7, LSL #24
    CMN  X25, X15, LSL #35
    CCMN  X3, X19, #0x8, MI
    CMP  X5, #0xb48, LSL #12
    CMN  W29, W27, SXTW #0
    CMP  W3, W17, LSL #11
    CMN  W10, #0xfac
    CMP  X6, W10, UXTW #0
    CCMN  X22, #0x0, #0xe, LT
    CMP  W5, W3, LSL #13
    CMP  W2, #0xb35
    CMN  W16, W17, LSR #23
    CCMP  W24, #0xb, #0xe, NV
    CMP  W23, W4, LSL #8
    CCMN  X25, X7, #0x7, LS
    CMN  W5, W25, LSR #6
    CCMN  W3, #0xb, #0x2, NE
    CMP  W27, #0x59, LSL #12
    CMN  X18, X5, LSL #34
    CCMP  W24, #0x17, #0xd, NE
    CMN  X3, W15, UXTW #1
    CMP  W6, W28, UXTB #4
    CMP  W29, #0xf3b, LSL #12
    CMP  W17, W6, LSR #11
    CMN  W28, #0xe7f, LSL #12
    CCMN  W5, W25, #0x7, MI
    CMN  X6, X15, LSL #18
    CMP  X27, #0x96, LSL #12
    CMN  W6, W4, SXTW #2
    CCMP  X5, X17, #0x4, VS
    CCMP  W23, W26, #0xc, GT
    CMN  W29, W6, LSR #1
    CMN  X26, #0xee1
    CCMP  W7, W15, #0x1, LT
    CMN  W24, W27, LSR #2
    CMN  W6, W24, SXTW #4
    CMP  W6, W15, LSL #9
    CCMP  W16, #0x4, #0x4, LS
    CMN  W23, W7, UXTX #1
    CMN  X26, #0xcfb, LSL #12
    CMP  X4, W7, UXTB #2
    CCMP  X29, X6, #0xe, EQ
    CMP  W28, W17, LSR #27
    CCMN  W7, #0x5, #0x7, VC
    CCMP  W7, #0x5, #0xc, VS
    CMN  W29, W13, SXTX #4
    CMN  X25, #0xee
    CCMP  X13, #0x15, #0xb, GE
    CMN  X22, X22, LSL #27
    CMN  W23, #0x31f, LSL #12
    CMP  W16, W2, LSL #26
    CCMN  X23, #0x1c, #0xa, VS
    CMP  W4, #0x9a0, LSL #12
    CCMN  W15, W27, #0x2, VS
    CMN  W2, #0x5d2
    CCMP  X7, #0x1d, #0x2, AL
    CMN  X29, X22, LSR #52
    CMP  X22, #0xf93
    CCMP  W22, W4, #0x2, LT
    CCMP  X7, X5, #0x1, CC
    CMP  X4, X26, LSR #32
    CMP  W16, W29, ASR #25
    CCMN  X15, X2, #0x8, MI
    CMP  X26, W19, UXTH #3
    CMN  W28, W10, ASR #24
    CMP  X5, #0x45e
    SUBS  X28, X28, #0x1
    B.NE  TSRTIntCompare_label_9
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X20, X21, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X20, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X20, X21, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X20, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X20, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X20, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X20, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X20, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X20, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X20, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X20, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X20, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X20, X21, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X20, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X20, X21, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X20, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X20, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X20, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X20, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X20, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntCompare_TestFail
    MOVZ  X2, #0x5ffc, LSL #0
    MOVK  X2, #0xfb8, LSL #16
    MOVK  X2, #0x9408, LSL #32
    MOVK  X2, #0x126, LSL #48
    MOVZ  X3, #0x7adb, LSL #0
    MOVK  X3, #0xf2a2, LSL #16
    MOVK  X3, #0xd0ef, LSL #32
    MOVK  X3, #0x8d9d, LSL #48
    MOVZ  X4, #0x7a0f, LSL #0
    MOVK  X4, #0xf85c, LSL #16
    MOVK  X4, #0xbd7c, LSL #32
    MOVK  X4, #0xce21, LSL #48
    MOVZ  X5, #0xca0b, LSL #0
    MOVK  X5, #0xeaa6, LSL #16
    MOVK  X5, #0xc5cd, LSL #32
    MOVK  X5, #0x7bf9, LSL #48
    MOVZ  X6, #0x61e8, LSL #0
    MOVK  X6, #0xd53, LSL #16
    MOVK  X6, #0xf1f4, LSL #32
    MOVK  X6, #0x3413, LSL #48
    MOVZ  X7, #0x5512, LSL #0
    MOVK  X7, #0xdb21, LSL #16
    MOVK  X7, #0x1476, LSL #32
    MOVK  X7, #0xb5dc, LSL #48
    MOVZ  X10, #0x223, LSL #0
    MOVK  X10, #0x53fa, LSL #16
    MOVK  X10, #0x7c2b, LSL #32
    MOVK  X10, #0x5bfd, LSL #48
    MOVZ  X13, #0x514d, LSL #0
    MOVK  X13, #0xafe2, LSL #16
    MOVK  X13, #0xe08d, LSL #32
    MOVK  X13, #0xa094, LSL #48
    MOVZ  X15, #0x2c5f, LSL #0
    MOVK  X15, #0x33fd, LSL #16
    MOVK  X15, #0x4ae0, LSL #32
    MOVK  X15, #0x33ce, LSL #48
    MOVZ  X16, #0x7981, LSL #0
    MOVK  X16, #0x6678, LSL #16
    MOVK  X16, #0x63ef, LSL #32
    MOVK  X16, #0xa829, LSL #48
    MOVZ  X17, #0x4c82, LSL #0
    MOVK  X17, #0xef73, LSL #16
    MOVK  X17, #0x45a0, LSL #32
    MOVK  X17, #0x4102, LSL #48
    MOVZ  X18, #0xe25c, LSL #0
    MOVK  X18, #0xa6e1, LSL #16
    MOVK  X18, #0x99dd, LSL #32
    MOVK  X18, #0x4566, LSL #48
    MOVZ  X19, #0x335f, LSL #0
    MOVK  X19, #0x2e7, LSL #16
    MOVK  X19, #0x2d03, LSL #32
    MOVK  X19, #0xbb95, LSL #48
    MOVZ  X20, #0x238c, LSL #0
    MOVK  X20, #0x5388, LSL #16
    MOVK  X20, #0x3e94, LSL #32
    MOVK  X20, #0xa7b5, LSL #48
    MOVZ  X21, #0x940f, LSL #0
    MOVK  X21, #0x1a39, LSL #16
    MOVK  X21, #0x7509, LSL #32
    MOVK  X21, #0x3925, LSL #48
    MOVZ  X22, #0xb7e7, LSL #0
    MOVK  X22, #0xfbb0, LSL #16
    MOVK  X22, #0x8bc4, LSL #32
    MOVK  X22, #0x2a56, LSL #48
    MOVZ  X23, #0xef53, LSL #0
    MOVK  X23, #0xaa57, LSL #16
    MOVK  X23, #0x281a, LSL #32
    MOVK  X23, #0x3f19, LSL #48
    MOVZ  X24, #0x3c90, LSL #0
    MOVK  X24, #0xa10a, LSL #16
    MOVK  X24, #0xdc9e, LSL #32
    MOVK  X24, #0x6c3d, LSL #48
    MOVZ  X25, #0x54ee, LSL #0
    MOVK  X25, #0x5d4e, LSL #16
    MOVK  X25, #0x1d08, LSL #32
    MOVK  X25, #0x12e3, LSL #48
    MOVZ  X26, #0x4bb3, LSL #0
    MOVK  X26, #0x7cdb, LSL #16
    MOVK  X26, #0xbe06, LSL #32
    MOVK  X26, #0x226f, LSL #48
    MOVZ  X27, #0x2c67, LSL #0
    MOVK  X27, #0x253f, LSL #16
    MOVK  X27, #0x7198, LSL #32
    MOVK  X27, #0x5615, LSL #48
    MOVZ  X28, #0x3fcc, LSL #0
    MOVK  X28, #0x72df, LSL #16
    MOVK  X28, #0xd758, LSL #32
    MOVK  X28, #0x2cf4, LSL #48
    MOVZ  X29, #0x304c, LSL #0
    MOVK  X29, #0xf438, LSL #16
    MOVK  X29, #0x641e, LSL #32
    MOVK  X29, #0x6477, LSL #48
    MOVZ  X3, #0xa, LSL #0
TSRTIntCompare_label_10:
    CMN  W27, W7, UXTH #4
    CMN  X29, W3, UXTH #2
    CMP  W29, W25, ASR #0
    CMP  W28, W27, UXTW #2
    CCMP  X6, #0x1e, #0xf, GE
    CCMN  W3, W15, #0x3, PL
    CMP  X16, W21, UXTH #1
    CMN  W24, W2, LSR #1
    CCMN  X18, #0x13, #0xe, MI
    CMN  X13, #0x4e3, LSL #12
    CMN  X7, X23, SXTX #4
    CMN  W23, #0xb87
    CMP  W15, W23, SXTX #3
    CMN  W16, #0xf3f, LSL #12
    CMN  W16, W10, SXTX #1
    CMP  X22, W24, SXTB #4
    CMN  X4, W28, SXTH #2
    CCMP  X24, X29, #0xe, LS
    CCMP  X29, X29, #0x1, LT
    CCMN  W27, W23, #0xe, LS
    CMN  W7, W16, UXTX #0
    CMP  X21, X28, LSR #25
    CMP  X29, #0xc59
    CMP  X7, X15, LSR #41
    CCMN  X4, X27, #0xb, LT
    CMN  W6, W19, ASR #2
    CMP  W2, W21, UXTH #2
    CCMP  W3, W7, #0x0, NV
    CMN  X21, X24, ASR #2
    CCMN  W2, #0xa, #0x8, VC
    CMN  X18, #0xf00, LSL #12
    CMP  X22, #0xefb
    CMN  W25, #0x19d, LSL #12
    CMP  X25, X2, ASR #3
    CMP  W15, W25, ASR #20
    CMP  X22, #0xdc2, LSL #12
    CMN  W25, W4, LSR #9
    CCMP  W23, W25, #0x2, LE
    CCMP  W3, #0xa, #0x4, LE
    CMN  W23, W5, LSL #19
    CCMN  X22, X10, #0xf, VC
    CCMN  X5, X7, #0x3, CS
    CMP  W13, #0x909
    CMN  W27, #0xe13
    CMN  W28, W7, UXTB #3
    CMP  X16, X25, ASR #37
    CMP  X29, W24, UXTW #3
    CCMN  W5, W6, #0x6, HI
    CCMP  X2, X18, #0x5, LE
    CMP  X5, #0xc91, LSL #12
    CMP  X25, X27, LSL #56
    CMP  X5, #0xcac, LSL #12
    CMN  W22, W3, UXTB #2
    CMN  W7, W24, LSL #4
    CMP  X16, W15, UXTW #2
    CMN  X6, W10, SXTW #4
    CCMN  X25, #0x18, #0xc, LT
    CMP  X21, W4, SXTH #1
    CMN  W28, W16, ASR #18
    CMN  X16, X5, UXTX #1
    CCMP  W18, #0x4, #0x6, CC
    CMN  W10, #0x21d
    CMP  X25, #0x42, LSL #12
    CMN  W4, #0xdd8
    CCMN  X19, X29, #0x2, HI
    CCMN  W7, W10, #0x3, MI
    CMP  W25, #0x707, LSL #12
    CCMN  X24, #0xb, #0xd, LE
    CMN  W28, #0xfca, LSL #12
    CMN  X10, W13, UXTB #3
    CCMN  W15, #0xe, #0xe, GT
    CMN  X15, #0xbe3
    CCMN  W20, W25, #0x5, AL
    CMP  X28, X29, SXTX #2
    CMP  X24, #0x88
    CCMP  X2, #0x4, #0x8, AL
    CCMP  W29, #0x1f, #0xa, CC
    CMN  W25, W5, SXTB #4
    CMN  X24, #0xf65, LSL #12
    CMN  X27, X16, SXTX #4
    CCMN  W15, #0x6, #0xb, HI
    CCMN  W20, W28, #0xe, EQ
    CMP  W27, W18, SXTH #0
    CMP  X7, X27, LSR #57
    CMP  X24, #0xfef
    CMN  W13, #0x32c, LSL #12
    CCMP  W24, #0x3, #0xe, NV
    CMN  X10, X6, LSL #10
    CCMP  X18, #0x8, #0x5, EQ
    CMN  X23, X6, LSR #0
    CCMP  W2, W4, #0x9, VC
    CMN  X24, W19, SXTW #0
    CMP  X7, X25, LSR #37
    CCMP  X15, X4, #0xf, EQ
    CMN  W2, #0xc1f
    CMP  X3, X28, UXTX #0
    CCMN  X10, X10, #0x7, VS
    CMP  X7, #0xaf2, LSL #12
    CMN  X28, X22, ASR #62
    CMP  W7, W19, ASR #4
    CMP  X6, X16, LSL #49
    CMN  X16, W10, SXTW #3
    CCMN  X22, X2, #0xc, LE
    CMP  W23, #0x4f8
    CMP  W23, W28, UXTB #0
    CMP  X16, W6, UXTH #1
    CMN  X23, #0xeae, LSL #12
    CMN  X13, X19, ASR #53
    CMP  W10, #0x561, LSL #12
    CMN  X6, X16, LSR #14
    CMP  W5, W6, LSR #25
    CMN  X24, W7, UXTB #1
    CMN  W29, W27, LSR #31
    CCMP  X24, X20, #0xe, CC
    CMP  X22, W22, SXTW #4
    CMP  W6, #0xf6, LSL #12
    CMP  W6, #0x220, LSL #12
    CMN  X21, X18, LSL #20
    CMP  W21, W20, SXTW #2
    CMN  W5, W2, LSR #21
    CMP  W20, #0xa9e, LSL #12
    CMP  W3, W13, ASR #25
    CCMP  X7, #0x18, #0x6, GT
    CMP  X16, #0xbdc
    CMN  W27, #0x7bb
    CMN  W20, W2, SXTB #0
    CMP  X19, #0x380, LSL #12
    CMP  W3, W7, SXTW #3
    CCMN  X7, X5, #0x9, NE
    CMP  X16, W2, UXTW #2
    CMP  X25, X16, ASR #51
    CMP  W7, W24, LSL #23
    CMN  W20, #0x61e, LSL #12
    CMP  W10, W2, ASR #0
    CMP  X24, X16, SXTX #4
    CMP  W23, #0x507
    CMP  W24, #0xa22
    CMP  X2, W28, UXTB #3
    CMN  W19, W5, SXTH #3
    CCMN  X20, #0x1a, #0x3, EQ
    CMP  X2, #0x229, LSL #12
    CMN  W28, W20, UXTX #2
    CMP  W10, #0xd64
    CCMP  W28, #0x7, #0xe, GE
    CMN  X20, X21, UXTX #3
    CCMP  X5, #0x8, #0x2, CC
    CMP  W21, W21, LSR #18
    CMN  X20, W2, SXTB #0
    CCMP  W19, W22, #0x6, EQ
    CMP  W6, W6, SXTB #0
    CCMN  X19, #0x14, #0xb, MI
    CMN  X23, W19, UXTB #3
    CMP  W2, #0x434, LSL #12
    CMP  X10, X20, LSL #38
    CMN  X5, X16, LSR #0
    CMP  W5, W3, UXTB #2
    CMP  X2, X4, LSL #17
    CCMP  W19, W20, #0x5, GE
    CMN  W24, W10, UXTX #1
    CMP  W19, W19, SXTH #1
    CCMN  X4, #0x12, #0x3, EQ
    CCMP  W3, #0x18, #0x6, VC
    CCMN  X21, X5, #0xf, MI
    CCMN  W27, #0x11, #0x1, AL
    CMP  X25, X22, LSL #14
    CMP  W13, W5, SXTW #1
    CMP  X2, #0xb10
    CMP  W2, W28, UXTX #1
    CMP  X29, X6, ASR #57
    CMP  W16, W19, LSL #4
    CCMN  X29, X28, #0x4, HI
    CMN  X19, X15, LSR #55
    CMP  X20, #0x67a, LSL #12
    CMP  W15, #0xc29
    CMP  W13, W20, LSR #25
    CMN  X25, X3, LSR #9
    CMP  X6, X5, LSR #21
    CCMP  X6, #0x3, #0x2, CS
    CMP  W2, W22, LSL #9
    CMP  W5, W15, UXTW #4
    CCMP  W10, #0x1d, #0x8, NE
    CMP  X13, X27, LSL #60
    CMP  W23, W10, LSR #20
    CMN  X4, X5, LSL #44
    CMN  X29, X16, ASR #62
    CMP  X20, X29, LSL #45
    CCMN  X7, X15, #0x1, CS
    CMP  W29, W28, UXTH #1
    CMN  W15, #0x6d4, LSL #12
    CCMN  X4, #0x4, #0xb, CS
    CCMN  X23, #0x10, #0x1, AL
    CCMN  W4, W27, #0x8, LS
    CCMP  X7, #0x1c, #0x4, MI
    CMN  X2, W5, UXTB #0
    CMP  X2, W27, UXTW #3
    CMP  W10, W7, LSL #16
    CMN  W4, W3, SXTX #2
    CCMP  W25, W4, #0x2, NV
    CMP  W25, W23, UXTX #3
    CCMP  X16, #0x17, #0xf, VS
    SUBS  X3, X3, #0x1
    B.NE  TSRTIntCompare_label_10
    MOVZ  X17, #0x5ffc, LSL #0
    MOVK  X17, #0xfb8, LSL #16
    MOVK  X17, #0x9408, LSL #32
    MOVK  X17, #0x126, LSL #48
    SUB  X26, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X17, #0x7a0f, LSL #0
    MOVK  X17, #0xf85c, LSL #16
    MOVK  X17, #0xbd7c, LSL #32
    MOVK  X17, #0xce21, LSL #48
    SUB  X26, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X17, #0xca0b, LSL #0
    MOVK  X17, #0xeaa6, LSL #16
    MOVK  X17, #0xc5cd, LSL #32
    MOVK  X17, #0x7bf9, LSL #48
    SUB  X26, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X17, #0x61e8, LSL #0
    MOVK  X17, #0xd53, LSL #16
    MOVK  X17, #0xf1f4, LSL #32
    MOVK  X17, #0x3413, LSL #48
    SUB  X26, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X17, #0x5512, LSL #0
    MOVK  X17, #0xdb21, LSL #16
    MOVK  X17, #0x1476, LSL #32
    MOVK  X17, #0xb5dc, LSL #48
    SUB  X26, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X17, #0x223, LSL #0
    MOVK  X17, #0x53fa, LSL #16
    MOVK  X17, #0x7c2b, LSL #32
    MOVK  X17, #0x5bfd, LSL #48
    SUB  X26, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X17, #0x514d, LSL #0
    MOVK  X17, #0xafe2, LSL #16
    MOVK  X17, #0xe08d, LSL #32
    MOVK  X17, #0xa094, LSL #48
    SUB  X26, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X17, #0x2c5f, LSL #0
    MOVK  X17, #0x33fd, LSL #16
    MOVK  X17, #0x4ae0, LSL #32
    MOVK  X17, #0x33ce, LSL #48
    SUB  X26, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X17, #0x7981, LSL #0
    MOVK  X17, #0x6678, LSL #16
    MOVK  X17, #0x63ef, LSL #32
    MOVK  X17, #0xa829, LSL #48
    SUB  X26, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X17, #0xe25c, LSL #0
    MOVK  X17, #0xa6e1, LSL #16
    MOVK  X17, #0x99dd, LSL #32
    MOVK  X17, #0x4566, LSL #48
    SUB  X26, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X17, #0x335f, LSL #0
    MOVK  X17, #0x2e7, LSL #16
    MOVK  X17, #0x2d03, LSL #32
    MOVK  X17, #0xbb95, LSL #48
    SUB  X26, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X17, #0x238c, LSL #0
    MOVK  X17, #0x5388, LSL #16
    MOVK  X17, #0x3e94, LSL #32
    MOVK  X17, #0xa7b5, LSL #48
    SUB  X26, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X17, #0x940f, LSL #0
    MOVK  X17, #0x1a39, LSL #16
    MOVK  X17, #0x7509, LSL #32
    MOVK  X17, #0x3925, LSL #48
    SUB  X26, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X17, #0xb7e7, LSL #0
    MOVK  X17, #0xfbb0, LSL #16
    MOVK  X17, #0x8bc4, LSL #32
    MOVK  X17, #0x2a56, LSL #48
    SUB  X26, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X17, #0xef53, LSL #0
    MOVK  X17, #0xaa57, LSL #16
    MOVK  X17, #0x281a, LSL #32
    MOVK  X17, #0x3f19, LSL #48
    SUB  X26, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X17, #0x3c90, LSL #0
    MOVK  X17, #0xa10a, LSL #16
    MOVK  X17, #0xdc9e, LSL #32
    MOVK  X17, #0x6c3d, LSL #48
    SUB  X26, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X17, #0x54ee, LSL #0
    MOVK  X17, #0x5d4e, LSL #16
    MOVK  X17, #0x1d08, LSL #32
    MOVK  X17, #0x12e3, LSL #48
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X17, #0x2c67, LSL #0
    MOVK  X17, #0x253f, LSL #16
    MOVK  X17, #0x7198, LSL #32
    MOVK  X17, #0x5615, LSL #48
    SUB  X26, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X17, #0x3fcc, LSL #0
    MOVK  X17, #0x72df, LSL #16
    MOVK  X17, #0xd758, LSL #32
    MOVK  X17, #0x2cf4, LSL #48
    SUB  X26, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X17, #0x304c, LSL #0
    MOVK  X17, #0xf438, LSL #16
    MOVK  X17, #0x641e, LSL #32
    MOVK  X17, #0x6477, LSL #48
    SUB  X26, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
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
    MOVZ  X10, #0xa, LSL #0
TSRTIntCompare_label_11:
    CCMN  W19, #0x4, #0x4, VS
    CMN  W10, W15, UXTH #1
    CMN  X16, #0xa4d, LSL #12
    CMN  X28, #0x50b, LSL #12
    CMN  X17, X20, LSR #11
    CCMP  X25, X25, #0xa, NV
    CCMN  W22, W22, #0xe, VS
    CCMN  X18, #0x1b, #0x0, NV
    CCMP  X5, #0xc, #0x0, NV
    CMN  W10, #0x22a, LSL #12
    CMN  X29, W6, SXTB #1
    CCMN  X24, #0x1f, #0xe, AL
    CCMP  X23, X29, #0x0, MI
    CCMN  W19, #0x6, #0x2, VS
    CCMP  W27, W29, #0x3, CC
    CCMN  W7, #0x5, #0xe, LE
    CCMP  W19, #0x10, #0x6, LE
    CMP  W5, W22, ASR #15
    CCMN  X10, #0x12, #0x8, PL
    CCMN  W24, #0x15, #0xa, CS
    CMN  W29, W17, SXTH #1
    CMN  W21, W17, UXTB #3
    CMN  X21, X6, ASR #40
    CCMN  X15, X17, #0x2, EQ
    CCMP  W2, #0x6, #0x1, NV
    CMP  W4, #0x66d, LSL #12
    CMP  X21, X5, UXTX #3
    CCMN  X10, X28, #0x8, MI
    CCMP  W16, W17, #0x3, LS
    CMP  W4, W5, SXTW #1
    CMP  W22, W10, UXTH #3
    CMP  W15, #0x6d7
    CMN  W24, #0x598, LSL #12
    CCMP  W24, W24, #0x3, EQ
    CCMN  W17, #0x1b, #0xe, LE
    CMN  X2, X4, LSL #11
    CMN  W22, W6, LSL #13
    CCMP  W29, W18, #0x9, NV
    CMP  W25, W19, LSL #25
    CCMN  X16, #0xf, #0x6, HI
    CMP  W23, W28, SXTW #4
    CCMP  W28, W16, #0x9, CC
    CCMN  W20, W28, #0x2, AL
    CCMP  W19, W25, #0x2, GE
    CMN  X7, X19, ASR #19
    CMP  W10, #0x41, LSL #12
    CMN  W23, W28, LSR #11
    CMP  W22, W21, LSR #29
    CMN  W2, W27, LSR #20
    CCMN  W7, #0xe, #0xc, VC
    CCMN  X5, X5, #0xe, HI
    CMN  W29, W18, LSR #24
    CMP  X18, X27, ASR #22
    CMN  W24, W25, LSL #2
    CMN  X4, #0x90, LSL #12
    CCMN  X28, X22, #0xb, PL
    CCMN  X29, #0xd, #0x7, CC
    CMP  X15, X17, ASR #8
    CMN  X19, X13, UXTX #4
    CMP  X28, X29, ASR #4
    CCMN  W21, #0xa, #0x8, LT
    CMN  W21, #0x9b3, LSL #12
    CCMP  X5, #0x1e, #0x9, CS
    CCMN  W17, W5, #0xd, MI
    CMN  W25, #0xf6d, LSL #12
    CMP  X23, W7, UXTH #1
    CMP  W23, W5, SXTX #4
    CMP  X20, X4, ASR #18
    CCMP  W17, #0x1c, #0x6, NE
    CMN  X18, X22, ASR #49
    CCMN  X29, X22, #0xe, LS
    CMP  W2, W27, ASR #5
    CMN  X27, #0x90d, LSL #12
    CCMN  W25, W5, #0xd, LS
    CCMN  W28, W2, #0x4, PL
    CMN  W19, W20, SXTX #2
    CMN  W28, W27, UXTX #0
    CCMP  W17, W21, #0xe, HI
    CCMP  W13, #0x15, #0x0, CS
    CCMP  W25, W29, #0x1, VC
    CCMP  X18, #0x1c, #0x5, LE
    CMP  X19, W5, SXTH #3
    CMP  W23, W20, UXTB #2
    CMP  W13, W29, UXTH #1
    CMP  W16, W21, UXTB #0
    CMN  X15, X23, ASR #50
    CCMP  W27, W25, #0xb, PL
    CMN  W16, W13, UXTH #4
    CMP  W13, W20, UXTH #1
    CMP  W19, W16, SXTH #4
    CCMP  W28, W23, #0xd, NV
    CMN  W13, W27, LSL #26
    CMP  X15, X2, LSR #24
    CCMP  W24, W20, #0x2, VS
    CMN  W6, W24, LSL #18
    CCMN  W20, #0x6, #0x5, LT
    CCMP  X22, X29, #0xd, LE
    CMP  X25, #0x85b
    CMN  W2, #0x8ea, LSL #12
    CCMN  W20, W4, #0xa, NE
    CMP  W21, #0xd23, LSL #12
    CCMN  W13, #0xd, #0x3, HI
    CMP  W7, #0xd19
    CCMN  W7, W19, #0xc, GE
    CCMP  W6, #0x17, #0xe, GE
    CMN  W29, #0xf7
    CMP  W5, #0x284
    CMP  X16, X23, ASR #50
    CMP  W28, W10, LSL #26
    CMP  X24, X27, ASR #46
    CMN  X17, W21, SXTH #0
    CMN  W22, #0x2d5, LSL #12
    CMN  W18, W24, LSR #28
    CMP  W4, #0xb7e
    CMN  W28, #0xbeb, LSL #12
    CMP  W15, W6, SXTB #0
    CMP  W16, W10, ASR #3
    CMN  X16, #0x8b1, LSL #12
    CCMN  X4, X18, #0x4, GT
    CCMP  W28, W27, #0xb, GE
    CCMP  X7, X18, #0xc, CC
    CCMP  W21, W6, #0xf, CS
    CCMN  W17, #0x1a, #0xe, LE
    CCMP  X15, X25, #0x4, EQ
    CMP  X15, #0x8e8
    CCMP  X27, X7, #0x0, LS
    CCMN  W16, #0x3, #0xf, CC
    CMN  W5, W15, SXTW #0
    CMP  X23, W17, SXTH #3
    CCMP  W10, #0x17, #0x1, HI
    CCMP  W6, #0x15, #0xb, AL
    CMP  W2, #0x78a
    CCMP  W7, #0xe, #0xf, CC
    CMP  X20, #0xdde
    CMP  W19, #0x24e, LSL #12
    CCMP  W15, #0x1c, #0x0, LT
    CMP  X7, X15, UXTX #2
    CMP  W4, W4, ASR #26
    CMP  W15, #0x2d6
    CMN  X27, #0xde0, LSL #12
    CCMP  X23, X20, #0x0, CS
    CCMN  X25, X23, #0xf, HI
    CMN  W13, W15, UXTB #2
    CMN  X24, W10, SXTH #0
    CMP  W10, #0x9cc, LSL #12
    CCMP  X16, X7, #0x7, NE
    CMN  W24, W15, LSL #1
    CMN  W4, #0x2a9
    CCMN  X29, #0x1a, #0x6, CC
    CMP  X24, #0xed0
    CCMP  W27, W25, #0x1, NE
    CMP  W27, W25, UXTH #2
    CMP  W28, #0xf0a
    CCMN  W18, #0x1a, #0xc, GT
    CCMP  X13, #0x8, #0xd, EQ
    CCMN  W6, W16, #0x3, PL
    CCMN  X2, X21, #0x0, PL
    CMN  X10, #0xc43, LSL #12
    CMP  W20, W22, SXTH #1
    CCMP  W5, #0x1d, #0x7, MI
    CCMN  X22, #0x15, #0xc, EQ
    CMN  X21, X28, ASR #57
    CMN  X15, W29, SXTH #0
    CMP  W2, #0x8a9, LSL #12
    CCMN  X15, #0xb, #0x2, LS
    CCMN  X5, X5, #0x2, LT
    CMP  W25, W27, UXTX #3
    CCMP  W7, #0x1, #0x5, CS
    CCMP  X19, X16, #0x3, LT
    CCMP  W20, #0x2, #0x5, GT
    CMP  W24, #0xbad, LSL #12
    CMP  X24, X15, LSL #63
    CMN  W29, W7, ASR #0
    CMN  W22, #0xb21, LSL #12
    CMN  W19, #0xfb8
    CMN  X23, #0xdc6
    CMP  X15, W21, UXTB #1
    CCMP  W23, #0x1e, #0x7, AL
    CCMN  W22, W17, #0x9, LT
    CMN  W29, W17, SXTB #4
    CCMP  W2, #0x15, #0xf, VC
    CCMP  X27, #0x13, #0x9, VC
    CCMN  W6, W15, #0x9, LS
    CMP  W2, #0xbb2
    CMP  X13, W15, SXTW #0
    CMP  X4, W4, UXTH #1
    CMP  W5, W13, ASR #3
    CMP  W7, W20, UXTB #3
    CMP  W20, #0x505, LSL #12
    CMP  X5, #0x1b7, LSL #12
    CMN  X28, X16, ASR #10
    CCMP  W13, W10, #0x1, PL
    CMP  X17, X17, LSL #29
    CCMP  X22, #0x3, #0xf, VC
    CCMP  W10, #0xa, #0xc, GT
    CMN  W20, W4, LSR #23
    CMP  X7, X5, LSL #45
    CMP  W10, #0x16a
    CMN  X13, X13, LSL #23
    CMP  W7, W23, ASR #1
    SUBS  X10, X10, #0x1
    B.NE  TSRTIntCompare_label_11
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X22
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCompare_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X29
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
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
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
TSRTIntCompare_label_12:
    CMP  X28, X29, LSR #29
    CMP  X25, #0x482
    CCMP  X24, X26, #0xa, VS
    CCMP  W6, W3, #0x5, NE
    CMN  X4, #0xe74, LSL #12
    CMP  X22, W19, SXTH #4
    CCMP  W10, W21, #0x6, GT
    CMN  X20, #0x786, LSL #12
    CMN  X26, #0x5d7
    CCMN  X2, #0xb, #0xe, NV
    CMP  X22, W24, UXTH #0
    CMP  W26, W3, SXTX #0
    CMN  X21, X13, ASR #49
    CCMN  W5, #0xe, #0x1, CS
    CMP  X4, X25, LSR #56
    CMP  W25, #0x3c4, LSL #12
    CMN  X16, X15, LSL #59
    CCMP  W10, W10, #0x9, EQ
    CCMP  X22, X6, #0x2, CC
    CMP  W28, #0x3a6
    CCMN  X5, X10, #0x6, LS
    CCMP  X24, X15, #0x0, VC
    CMP  W19, W5, SXTW #0
    CCMN  W17, W18, #0x6, VS
    CCMP  W17, W25, #0x1, AL
    CMP  W19, W22, UXTX #3
    CCMP  X18, #0xc, #0xb, VC
    CMP  X20, X20, LSL #43
    CCMN  X28, X19, #0x8, NV
    CMN  W22, W10, SXTB #3
    CMP  W22, W5, LSR #13
    CMN  W24, #0x510
    CCMP  X29, X21, #0xc, CC
    CCMP  X19, X13, #0x7, LS
    CMP  W10, W21, UXTH #4
    CMN  W29, #0xb85
    CMP  W26, #0x34e, LSL #12
    CCMP  W15, #0x14, #0xe, GT
    CMN  W22, W26, ASR #24
    CMP  X25, #0x9cc, LSL #12
    CMP  W5, W26
    CMN  X15, #0xebc
    CMP  W2, W2, SXTB #4
    CCMP  W13, #0x1f, #0x2, LE
    CMP  W20, W25, LSL #1
    CCMN  W16, W19, #0xd, EQ
    CCMP  W18, W15, #0x9, VS
    CMN  W10, W29, UXTB #1
    CMP  W22, W19, UXTX #1
    CMN  X5, X13, LSL #8
    CMN  W15, W3, UXTH #4
    CMP  W4, #0x6c1, LSL #12
    CMP  X17, W29, UXTW #2
    CCMP  W20, W21, #0xa, CC
    CMN  W15, #0xac4
    CMN  X13, W21, UXTW #3
    CCMP  W21, W21, #0xc, HI
    CCMN  W29, #0xd, #0x4, MI
    CCMN  W19, #0x1c, #0x4, EQ
    CCMP  W20, W6, #0xe, EQ
    CCMP  W13, W29, #0xb, PL
    CMN  X24, #0x81d
    CMP  W20, #0x217
    CCMP  W16, W5, #0x9, LE
    CMN  W3, #0x6ec
    CCMN  W6, W6, #0x3, MI
    CMP  X22, X17, SXTX #4
    CMP  X26, X18, ASR #51
    CCMP  W25, W4, #0x9, NE
    CMN  X13, W26, UXTH #3
    CCMP  W4, #0x1d, #0xb, MI
    CMN  X16, #0x7ec, LSL #12
    CMN  X24, #0x177
    CMP  W4, #0xfb6, LSL #12
    CCMP  W2, W25, #0xf, CC
    CMP  X18, X25, LSR #49
    CCMN  X5, X19, #0x7, GE
    CMN  W22, #0x853
    CMP  W7, W29, UXTW #4
    CMN  W3, #0x5ac
    CMP  X17, W3, SXTW #4
    CMN  X6, X19, ASR #46
    CMN  X18, W18, SXTH #2
    CCMN  X3, X26, #0x1, GE
    CCMP  W25, #0x5, #0x2, NV
    CCMN  X21, #0x1e, #0x6, VS
    CCMP  X21, #0x12, #0x8, LS
    CMN  X13, #0x70c
    CMP  W16, #0x4c0
    CMP  X4, X18, SXTX #4
    CMP  X29, X29, SXTX #2
    CMP  X6, #0xa0b
    CCMN  X16, #0x1d, #0x4, VC
    CMN  W4, #0x8e2, LSL #12
    CCMN  W26, #0x13, #0xb, LS
    CCMP  X6, X22, #0xa, VS
    CMN  W10, #0xe52
    CCMN  W19, W16, #0x7, HI
    CMP  X21, W26, UXTW #3
    CMN  W25, W17, LSL #18
    CMP  X15, #0xe2
    CMP  W5, W10, ASR #13
    CMN  X25, X13, ASR #35
    CMN  X28, #0xd7a
    CMN  W24, W24, UXTH #0
    CMN  W26, #0xe22
    CMP  W17, W6, ASR #4
    CMP  W10, #0xbc3, LSL #12
    CCMN  W17, W18, #0xf, MI
    CMP  X19, #0xf16
    CCMP  X10, X28, #0x4, GE
    CCMP  X26, X4, #0x1, LT
    CMP  W21, #0xf26
    CCMP  W25, W24, #0x7, NE
    CMN  W29, #0x9a3, LSL #12
    CCMN  W24, W7, #0x4, GT
    CMP  X28, #0x65, LSL #12
    CMP  X19, #0x157
    CCMP  W10, #0x7, #0x0, AL
    CMN  X18, W22, SXTH #2
    CCMN  W26, W2, #0xf, NV
    CMP  W16, #0x364
    CCMN  X29, X7, #0x9, VS
    CCMP  W28, W6, #0x7, EQ
    CCMP  W10, W16, #0x4, NE
    CMN  W6, W28, SXTH #1
    CMP  X20, W18, SXTB #3
    CCMP  W26, W19, #0x3, PL
    CMP  W29, #0x24b
    CMP  W16, W19, ASR #19
    CCMN  W4, #0x3, #0x6, GT
    CCMN  X6, #0xa, #0x4, LS
    CMP  W24, #0xa2f, LSL #12
    CCMN  W17, W10, #0xb, CC
    CCMN  X5, #0xe, #0xf, LS
    CMN  W6, #0x2a0
    CMN  W10, #0x46a, LSL #12
    CCMN  X4, #0x10, #0x1, CC
    CCMP  W17, #0xe, #0xd, LT
    CMN  W25, W6, UXTB #4
    CMN  W24, #0xdcd, LSL #12
    CMP  W21, W21, UXTH #2
    CCMP  W3, #0x16, #0xb, NE
    CCMN  X26, #0x1c, #0x4, LE
    CMP  X2, X5, ASR #16
    CCMN  W6, W29, #0xd, LS
    CCMN  W7, #0x10, #0x9, GE
    CMP  X20, X5, SXTX #4
    CMN  X2, #0xc0a, LSL #12
    CCMN  W18, W19, #0x8, LE
    CMP  W3, W10, UXTB #3
    CCMN  X24, X26, #0xf, AL
    CMN  W24, W22, UXTW #1
    CMP  X15, #0x121
    CCMP  X29, #0x15, #0x3, GE
    CMP  X26, X2, UXTX #3
    CMP  X26, #0xbd7, LSL #12
    CCMN  W2, W3, #0x8, GT
    CMP  W13, W26, LSL #5
    CCMN  W21, W17, #0xb, PL
    CCMN  W25, W3, #0xf, GT
    CCMN  X15, #0x15, #0x0, LT
    CMN  W2, W4, LSL #12
    CCMP  W6, W19, #0x8, NE
    CCMP  X18, #0x5, #0x6, PL
    CCMP  X3, #0x1, #0x4, VS
    CMN  W25, W29, LSR #11
    CCMP  X24, #0x7, #0xc, MI
    CMN  W24, W24, UXTW #3
    CMP  W2, W13, UXTX #1
    CMP  W22, #0x4fc
    CMN  W28, #0x877, LSL #12
    CMN  X5, X20, LSL #39
    CCMN  W26, #0x0, #0xb, MI
    CCMN  W3, W10, #0xe, HI
    CCMP  X24, #0x14, #0x1, GT
    CCMP  W28, #0x16, #0x9, LE
    CMP  X15, #0xb4c
    CCMP  W24, W17, #0xe, CC
    CMN  W18, W18, SXTH #2
    CMN  W20, #0x489, LSL #12
    CMP  X25, #0xef1
    CCMP  X24, #0x1d, #0xb, HI
    CMP  X24, #0x430, LSL #12
    CMP  X2, X7, ASR #40
    CMN  W10, W19, SXTX #4
    CCMN  W4, #0x13, #0xe, VS
    CMP  X26, X7, LSL #27
    CMN  X25, X18, LSR #20
    CCMN  X10, X2, #0x7, HI
    CMP  W6, W26, ASR #13
    CCMP  W5, W5, #0xe, LT
    CCMP  W25, #0x17, #0x3, MI
    CCMN  X2, X4, #0xb, AL
    CMN  W26, W19, LSR #14
    CCMP  W3, #0x3, #0x9, NV
    CCMP  W7, W4, #0x1, NE
    CMN  W21, #0x7f1, LSL #12
    CCMN  W16, W29, #0x2, GE
    CMP  X29, W3, UXTW #0
    SUBS  X3, X3, #0x1
    B.NE  TSRTIntCompare_label_12
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCompare_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
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
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
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
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    MOVZ  X3, #0xa, LSL #0
TSRTIntCompare_label_13:
    CMP  W20, W28, SXTX #1
    CMP  W18, W29, SXTB #3
    CCMN  X27, X25, #0xc, CS
    CCMP  X26, X16, #0xf, LS
    CMN  W3, W23, LSL #19
    CMN  X10, X16, LSL #50
    CCMP  W27, W26, #0x3, HI
    CMP  X16, X27, LSR #3
    CCMN  W6, W15, #0x8, HI
    CMP  W6, W25, UXTH #4
    CCMN  X21, #0x17, #0x7, CC
    CCMP  W21, #0x1, #0xa, LT
    CMN  X3, #0xf25
    CMN  X6, X6, ASR #32
    CCMN  W3, #0x6, #0xd, CC
    CMP  X15, #0xce3
    CCMP  X17, #0x1f, #0x7, CC
    CMN  X25, X18, ASR #25
    CCMN  W10, W22, #0x3, CC
    CMN  X15, W20, UXTW #3
    CMP  W6, W28, SXTW #0
    CMP  W21, W6, LSL #20
    CCMP  W21, #0x5, #0x6, LS
    CCMP  X2, #0x10, #0xe, NV
    CMN  X20, W24, SXTW #4
    CMN  W3, #0xe33
    CMP  W13, W29, SXTW #1
    CMN  W3, W21, UXTH #0
    CMN  W16, W18, SXTB #3
    CCMN  X27, X19, #0xb, GE
    CMN  W7, W22, UXTH #2
    CCMP  X10, X7, #0xe, PL
    CMP  X16, X21, LSL #38
    CMP  X26, X17, LSR #14
    CCMP  W15, W3, #0x3, GT
    CMP  X19, W24, UXTH #3
    CMP  X19, X13, ASR #30
    CMP  X28, #0x647
    CCMP  W21, W22, #0x5, EQ
    CMP  W20, W28, ASR #29
    CCMN  W19, #0x17, #0x6, LS
    CMN  X28, W13, UXTW #2
    CCMN  X27, X18, #0x1, EQ
    CCMN  X13, X7, #0xc, PL
    CMP  X18, #0xdc8
    CCMP  X6, #0x1, #0x1, PL
    CCMP  X7, X18, #0x3, PL
    CMN  W6, W24, SXTW #2
    CMP  W23, W28, LSR #14
    CMN  X13, #0x62a, LSL #12
    CCMP  X13, X18, #0x9, LS
    CMN  X7, W10, UXTW #3
    CCMN  W21, #0x1d, #0xe, VS
    CMP  W29, W26, LSL #15
    CMN  W18, #0x44c
    CCMN  W18, W2, #0xd, PL
    CMP  W13, W6, UXTB #2
    CCMP  X2, X6, #0x2, HI
    CCMP  X16, #0x17, #0x6, PL
    CMN  W15, #0x1b4
    CMN  W20, W28, UXTX #4
    CCMP  X24, X24, #0x2, NV
    CCMN  W26, W16, #0x6, AL
    CCMP  W6, W16, #0xe, NV
    CCMN  X25, X24, #0x5, EQ
    CMN  W15, W10, LSL #13
    CCMP  W13, #0x1e, #0x9, LT
    CCMN  X2, X29, #0x2, NV
    CCMP  W10, W17, #0x9, NE
    CMP  W26, #0xff1, LSL #12
    CMN  X24, W26, UXTH #2
    CCMP  W23, W18, #0x9, GT
    CMP  X25, #0x93e, LSL #12
    CMP  X21, X22, ASR #36
    CMN  W10, #0x14a, LSL #12
    CMP  X23, X7, LSL #8
    CMP  W19, W6, UXTB #3
    CCMN  X21, X6, #0x5, CS
    CCMN  X17, X13, #0xe, MI
    CCMN  X20, #0x1e, #0x4, AL
    CMP  X10, #0x722, LSL #12
    CMN  X7, W6, SXTW #4
    CMP  W18, #0x8c7
    CMN  X25, #0x27c
    CMN  X21, #0xe49, LSL #12
    CMN  W27, W2, SXTW #4
    CMP  W19, W27, LSR #25
    CMP  W13, W28, SXTB #3
    CCMN  X20, X20, #0x4, GT
    CMN  X23, #0x11d
    CCMN  X29, X3, #0x4, NV
    CCMN  W21, W7, #0xe, NV
    CCMP  W23, #0x18, #0x5, LS
    CCMN  W16, #0xa, #0xf, GE
    CMP  W16, W3, UXTW #1
    CMP  X27, X2, LSR #9
    CCMN  W26, #0x1f, #0x2, GT
    CMP  W17, W13, LSL #28
    CMP  X28, #0x91c, LSL #12
    CCMP  W28, #0xf, #0x6, EQ
    CCMP  X28, X26, #0xb, LE
    CMN  X29, X17, LSR #21
    CMP  X20, W2, SXTB #1
    CCMN  X16, X20, #0xc, AL
    CMN  W22, W15, UXTW #1
    CMN  X7, #0x597, LSL #12
    CMP  W3, W15, LSR #11
    CMN  W28, #0xa1a
    CCMP  W20, W20, #0x2, VS
    CMN  W2, W22, SXTB #3
    CCMP  X10, X15, #0x5, GE
    CMN  X22, X13, LSR #38
    CMP  W23, W13, LSL #23
    CMN  W7, W19, ASR #3
    CCMN  W28, W24, #0xe, NV
    CMP  X3, #0xea4
    CCMN  X29, #0xd, #0xb, CS
    CCMN  X2, X23, #0x6, CC
    CMN  W15, W25, SXTH #1
    CMN  W25, W15, UXTH #4
    CCMN  W18, W15, #0x3, VC
    CCMP  W26, #0x1c, #0xe, LE
    CCMN  X22, #0x6, #0x7, MI
    CMP  X2, #0x656
    CMP  X22, X19, ASR #32
    CCMN  W29, #0x7, #0x6, LS
    CMN  W29, W7, UXTH #4
    CMN  X16, W19, SXTW #3
    CCMN  X22, X23, #0xf, MI
    CCMP  W15, W15, #0x8, AL
    CCMN  W23, #0x1c, #0x2, VS
    CCMP  X26, X21, #0x0, PL
    CMN  W7, #0xeb2, LSL #12
    CMP  W20, W15, LSL #9
    CCMP  W7, #0x13, #0x7, LS
    CMP  W13, W13, UXTX #1
    CMN  W6, W28, LSL #11
    CCMN  X21, #0xc, #0x3, HI
    CCMN  W25, W3, #0x9, EQ
    CCMN  W27, W24, #0x5, MI
    CMP  W20, #0x89d, LSL #12
    CMP  W18, W3, SXTH #2
    CCMP  X18, #0x4, #0x4, LE
    CMN  X18, #0xb1
    CCMP  W24, W3, #0x5, VS
    CMP  X22, X26, LSR #60
    CCMP  X7, #0x11, #0x0, CS
    CCMP  X7, #0x18, #0xf, LT
    CCMN  X17, #0x1a, #0xd, NE
    CCMN  W24, #0x17, #0xe, LS
    CMP  W24, #0x57f
    CMN  W10, W3, SXTH #0
    CMP  W20, W26, SXTH #0
    CMN  X6, #0xc5d, LSL #12
    CMN  X26, W16, UXTH #2
    CCMP  X24, #0x1e, #0x4, LS
    CMP  X29, X3, ASR #31
    CCMP  X18, X27, #0x0, NE
    CMP  W7, #0xcb0
    CCMP  W20, #0x1a, #0x8, NE
    CMN  X26, X24, LSL #20
    CCMN  X27, X2, #0x1, HI
    CMP  X13, X25, LSL #60
    CMP  X10, X16, LSR #22
    CCMP  X25, X18, #0x2, VC
    CMN  X28, #0x160
    CCMP  X28, #0x15, #0xa, NV
    CMP  W6, #0x5df
    CCMP  X27, X18, #0x2, GE
    CCMP  X26, X29, #0x5, LS
    CCMP  W26, W3, #0x8, AL
    CMP  W27, W17, ASR #15
    CMP  X29, W28, UXTB #2
    CMN  X20, #0xaf9
    CMP  W19, #0x215, LSL #12
    CCMN  X7, X25, #0xe, CS
    CMP  X6, X3, ASR #2
    CMP  X3, X10, LSR #51
    CCMP  W16, W28, #0x1, PL
    CCMP  X16, #0x2, #0xb, VC
    CCMP  W29, W23, #0x3, CC
    CMN  X16, X13, ASR #38
    CCMP  X26, #0x14, #0xe, LE
    CMP  W20, #0x674, LSL #12
    CMP  X26, #0x6ad
    CMN  X23, X22, UXTX #2
    CCMP  X15, X13, #0xd, GE
    CMN  X6, W16, UXTW #2
    CCMP  X28, X27, #0x0, LE
    CMN  X26, X7, LSR #34
    CMP  X26, W13, UXTH #3
    CCMP  X17, X29, #0x4, EQ
    CMP  W19, W10, LSL #8
    CMP  X13, W23, SXTB #1
    CMN  X20, #0xd17
    CCMP  W21, W29, #0x3, GE
    CCMN  W24, #0x3, #0xd, VC
    CCMN  W20, W22, #0xe, NV
    CMP  X10, X19, ASR #20
    CMP  W27, #0xfcf, LSL #12
    SUBS  X3, X3, #0x1
    B.NE  TSRTIntCompare_label_13
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X5, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X5, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X5, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X5, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X5, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X5, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X5, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X5, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X5, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X5, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X5, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X5, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X5, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X5, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X5, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X5, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X5, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X5, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCompare_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
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
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
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
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    MOVZ  X29, #0xa, LSL #0
TSRTIntCompare_label_14:
    CCMN  X28, X26, #0x3, MI
    CCMP  X23, X13, #0xf, AL
    CCMN  W25, W27, #0xb, PL
    CMN  W29, W28, ASR #4
    CMP  W23, W24, LSL #22
    CMP  W25, W7, SXTX #0
    CMP  X4, X15, UXTX #3
    CMP  X19, X20, ASR #22
    CMP  X10, X2, ASR #61
    CMP  W19, #0xf4f, LSL #12
    CCMP  W4, #0x12, #0x9, HI
    CCMP  W16, #0xe, #0xd, MI
    CMN  W28, W23, LSR #25
    CMN  W22, W25, UXTX #0
    CCMN  X23, X29, #0x7, PL
    CCMP  W24, W18, #0x2, GE
    CMN  X26, W2, UXTW #0
    CMN  W16, #0x135, LSL #12
    CCMN  W18, W16, #0xc, NE
    CCMN  W10, #0x17, #0x6, CC
    CCMP  W23, W19, #0x5, EQ
    CMN  W4, #0xde
    CMN  X29, #0x260, LSL #12
    CMP  W13, #0x88a
    CMN  W16, W15, LSR #19
    CCMN  X16, X23, #0x6, CC
    CCMN  X5, X7, #0x8, CC
    CMP  X19, #0xcdb, LSL #12
    CCMN  X2, X26, #0x8, VS
    CMP  W6, W27, LSR #27
    CMN  X29, X15, ASR #27
    CMP  W7, W29, SXTH #0
    CMP  W5, W5, UXTB #3
    CCMN  X2, #0x13, #0x4, LT
    CMN  W27, W16, SXTX #0
    CMN  W27, W4, LSL #6
    CMP  X13, W2, UXTH #3
    CCMP  W13, #0x12, #0xc, GE
    CCMP  X28, #0x13, #0x6, GT
    CMP  X23, #0xd93
    CMN  X2, X16, UXTX #0
    CMP  W4, W22, UXTH #4
    CMN  W20, #0xb2b, LSL #12
    CCMN  W5, W26, #0xc, NV
    CCMN  X22, #0xd, #0x9, AL
    CMP  X4, X23, ASR #20
    CCMN  W26, W27, #0xe, LS
    CMN  X15, W4, UXTW #3
    CCMN  W29, W7, #0x9, NE
    CMN  W28, #0xed3
    CMN  X10, #0x23d
    CMN  W6, W15, LSL #15
    CCMN  W19, W18, #0xd, PL
    CMN  W5, W25, LSL #24
    CMN  X2, X19, ASR #9
    CMP  X13, W23, SXTW #2
    CCMN  X7, X7, #0x1, CS
    CCMP  X23, X15, #0xf, LS
    CCMN  W22, W22, #0x4, PL
    CMN  W18, W16, ASR #15
    CMN  X20, #0x289, LSL #12
    CMN  X25, X18, UXTX #1
    CMP  W5, #0x208
    CMP  X22, W5, SXTB #2
    CCMN  X6, #0xf, #0x1, NV
    CMN  X6, X2, ASR #53
    CMP  W15, #0x2a7
    CMP  X29, W10, SXTB #3
    CMP  W27, #0xf1f, LSL #12
    CCMP  W24, W4, #0x8, CC
    CCMN  W20, #0x15, #0x0, LS
    CMP  W13, #0xfca, LSL #12
    CMN  X7, W20, SXTB #2
    CMP  W2, W19, UXTX #4
    CMP  X28, X13, ASR #35
    CMP  X28, X24, LSR #39
    CMP  W4, W19, UXTH #2
    CMN  W15, W17, LSR #4
    CMP  W26, W18, SXTB #2
    CMN  W25, W5, LSL #16
    CCMP  W16, W22, #0xa, NE
    CMP  W7, #0x839
    CCMP  W6, W7, #0x6, VS
    CCMN  W22, W26, #0xb, MI
    CMP  X28, #0x4a9, LSL #12
    CCMP  X18, X4, #0x2, HI
    CCMN  X6, #0x4, #0x7, EQ
    CCMN  W4, W2, #0x0, PL
    CMN  X2, X16, ASR #9
    CMP  X5, W13, SXTW #1
    CCMN  X28, X29, #0x8, GE
    CMP  W2, W13, LSL #24
    CMN  X10, W13, UXTH #2
    CMP  X26, #0x7f4, LSL #12
    CCMN  W15, #0x0, #0x7, CS
    CMN  X15, W17, SXTB #2
    CCMP  W6, #0x9, #0xe, HI
    CMN  W5, #0xcd, LSL #12
    CMP  W17, W23, SXTB #4
    CCMP  W17, W6, #0xa, GT
    CMP  W16, #0x42f, LSL #12
    CCMP  X23, X4, #0xc, LT
    CCMN  W26, W25, #0x7, GE
    CMP  X7, #0xe0d
    CMP  X4, X25, ASR #60
    CCMN  W23, #0x10, #0xe, NV
    CMP  W26, W13, SXTH #4
    CCMN  W6, W28, #0x5, VC
    CMN  W22, #0xf5e, LSL #12
    CMP  W13, W15, SXTW #1
    CMN  X10, #0xdc7, LSL #12
    CMN  X18, #0xa07
    CMN  X5, X17, ASR #28
    CMN  W5, #0x2ad, LSL #12
    CCMP  W17, #0x18, #0x4, HI
    CMN  X17, #0x64
    CMP  X19, W23, UXTW #0
    CCMP  X27, X15, #0x8, LS
    CMP  X27, W27, SXTB #3
    CCMN  X4, #0x1e, #0x3, GE
    CMN  X22, #0xf5a
    CMN  X18, X28, LSL #3
    CMN  X6, #0xe8b
    CCMP  W18, W26, #0xa, CS
    CCMP  X24, #0xc, #0xb, NE
    CCMN  X7, #0x1d, #0xc, VS
    CCMP  X13, X25, #0xf, PL
    CCMN  W29, W28, #0x6, GT
    CMP  X4, W19, SXTB #4
    CCMP  W13, #0xf, #0xa, GT
    CMP  X18, X20, ASR #3
    CCMP  W25, W16, #0xe, GT
    CCMP  X16, X24, #0x8, PL
    CMN  X22, X22, ASR #28
    CCMP  W7, #0x15, #0x1, GE
    CMN  W27, #0x8ce, LSL #12
    CMN  X6, X10, ASR #52
    CMP  X13, #0x6a7
    CMP  X29, X28, LSL #40
    CMP  W17, W19, LSR #24
    CCMN  W22, #0x15, #0x6, GE
    CCMP  X6, #0x6, #0xa, PL
    CMP  W23, W27, LSR #6
    CMP  X18, W27, UXTB #3
    CMP  W18, W16, UXTH #0
    CMP  W27, W29, ASR #22
    CMP  W19, W29, ASR #21
    CCMP  W4, W29, #0xc, EQ
    CMN  X28, #0x909
    CMN  W29, W15, SXTB #0
    CCMN  X17, #0xb, #0xe, MI
    CMP  X26, #0x9c4
    CMP  W13, W5, UXTX #4
    CCMP  X5, #0x15, #0x5, GE
    CCMN  X26, #0xa, #0x4, VS
    CCMP  X27, X29, #0xb, GT
    CCMP  W16, #0xb, #0xd, GE
    CCMP  X4, X4, #0xf, VC
    CMP  X13, #0xbae
    CCMN  X4, #0x11, #0xd, CC
    CCMN  X17, #0x11, #0x3, LT
    CCMN  W5, #0x1d, #0x6, CC
    CMP  W10, W27, LSL #31
    CMN  X13, X25, LSL #36
    CCMN  X25, #0xc, #0x3, LS
    CMP  X4, X6, UXTX #0
    CCMP  X26, X18, #0xb, HI
    CCMP  W29, #0x14, #0x2, GT
    CMP  X28, W16, UXTH #4
    CCMP  X2, X13, #0xe, HI
    CMN  X25, #0xd34, LSL #12
    CMN  X13, #0x25a
    CCMN  W27, W24, #0x4, GT
    CCMN  X13, #0xd, #0xd, NE
    CCMN  X28, #0x0, #0xc, CC
    CMN  X27, W17, UXTH #1
    CMN  W4, #0x7f5
    CCMP  W24, W20, #0xa, PL
    CMP  W10, W24, LSL #11
    CMP  W7, #0xf69
    CMN  X22, X16, ASR #22
    CMN  W25, W24, LSL #4
    CMN  X5, W20, SXTB #3
    CCMN  X28, #0x7, #0x7, CC
    CMP  X6, #0xb47, LSL #12
    CCMN  X22, #0x9, #0x6, HI
    CCMN  W23, W24, #0xf, CS
    CCMN  W24, W19, #0x6, NE
    CCMN  W6, #0xc, #0x1, LE
    CCMN  W25, #0xf, #0x9, NV
    CCMP  X10, X26, #0xd, GE
    CMN  W19, W19, ASR #5
    CMP  X5, X15, LSL #4
    CCMN  W28, W6, #0xc, LE
    CMN  X18, W25, UXTW #3
    CMN  X23, #0xe38, LSL #12
    CCMN  X27, #0x8, #0x5, GT
    CMP  W10, W7, LSL #10
    CMN  X23, X26, SXTX #4
    CMP  X15, W20, UXTW #0
    SUBS  X29, X29, #0x1
    B.NE  TSRTIntCompare_label_14
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X3, X21, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X3, X21, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X3, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X3, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X3, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X3, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X3, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X3, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X3, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X3, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X3, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X3, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X3, X21, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X3, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X3, X21, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X3, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X3, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X3, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCompare_TestFail

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
