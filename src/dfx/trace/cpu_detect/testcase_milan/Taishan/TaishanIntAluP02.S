.global TaishanIntAluP02

.text
.p2align 4

TaishanIntAluP02:

TaishanIntAluP02_TestBegin:
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
    MOVK  X2, #0xf546, LSL #48
    MOVK  X2, #0x3075, LSL #32
    MOVK  X2, #0xa37c, LSL #16
    MOVK  X2, #0xec83, LSL #0
    MOVK  X3, #0xecf1, LSL #48
    MOVK  X3, #0x917d, LSL #32
    MOVK  X3, #0xf570, LSL #16
    MOVK  X3, #0x747b, LSL #0
    MOVK  X4, #0x70bc, LSL #48
    MOVK  X4, #0x4a9, LSL #32
    MOVK  X4, #0xbc36, LSL #16
    MOVK  X4, #0xd8b2, LSL #0
    MOVK  X5, #0xfd0d, LSL #48
    MOVK  X5, #0xc907, LSL #32
    MOVK  X5, #0x54b1, LSL #16
    MOVK  X5, #0x93ae, LSL #0
    MOVK  X6, #0x44d3, LSL #48
    MOVK  X6, #0x4375, LSL #32
    MOVK  X6, #0x8b5f, LSL #16
    MOVK  X6, #0xb7c7, LSL #0
    MOVK  X7, #0x3ea5, LSL #48
    MOVK  X7, #0xf79c, LSL #32
    MOVK  X7, #0x7bb9, LSL #16
    MOVK  X7, #0x743c, LSL #0
    MOVK  X8, #0x5c5b, LSL #48
    MOVK  X8, #0xb77c, LSL #32
    MOVK  X8, #0xf689, LSL #16
    MOVK  X8, #0xc6cd, LSL #0
    MOVK  X9, #0x88c0, LSL #48
    MOVK  X9, #0xc8ed, LSL #32
    MOVK  X9, #0x5bec, LSL #16
    MOVK  X9, #0x3539, LSL #0
    MOVK  X10, #0x2e39, LSL #48
    MOVK  X10, #0xb551, LSL #32
    MOVK  X10, #0xc387, LSL #16
    MOVK  X10, #0xe886, LSL #0
    MOVK  X11, #0xb5f3, LSL #48
    MOVK  X11, #0xecbf, LSL #32
    MOVK  X11, #0x2758, LSL #16
    MOVK  X11, #0x40f9, LSL #0
    MOVK  X12, #0xd538, LSL #48
    MOVK  X12, #0x5a16, LSL #32
    MOVK  X12, #0x884f, LSL #16
    MOVK  X12, #0xda6e, LSL #0
    MOVK  X13, #0x7ce8, LSL #48
    MOVK  X13, #0x8098, LSL #32
    MOVK  X13, #0xcbaa, LSL #16
    MOVK  X13, #0x6215, LSL #0
    MOVK  X14, #0x73c1, LSL #48
    MOVK  X14, #0xbf32, LSL #32
    MOVK  X14, #0x6c6d, LSL #16
    MOVK  X14, #0x9b69, LSL #0
    MOVK  X15, #0x36c0, LSL #48
    MOVK  X15, #0xd21f, LSL #32
    MOVK  X15, #0x2c1, LSL #16
    MOVK  X15, #0xad0e, LSL #0
    MOVK  X16, #0xad17, LSL #48
    MOVK  X16, #0x662, LSL #32
    MOVK  X16, #0x4ffd, LSL #16
    MOVK  X16, #0x443e, LSL #0
    MOVK  X17, #0xea88, LSL #48
    MOVK  X17, #0xe3e7, LSL #32
    MOVK  X17, #0x93ff, LSL #16
    MOVK  X17, #0xf39c, LSL #0
    MOVK  X18, #0x595d, LSL #48
    MOVK  X18, #0xa35e, LSL #32
    MOVK  X18, #0x3016, LSL #16
    MOVK  X18, #0xeadf, LSL #0
    MOVK  X19, #0x3866, LSL #48
    MOVK  X19, #0xe426, LSL #32
    MOVK  X19, #0x1af, LSL #16
    MOVK  X19, #0xc7c6, LSL #0
    MOVK  X20, #0xeec0, LSL #48
    MOVK  X20, #0x4faa, LSL #32
    MOVK  X20, #0xb763, LSL #16
    MOVK  X20, #0xe9a0, LSL #0
    MOVK  X21, #0x5576, LSL #48
    MOVK  X21, #0x9bb1, LSL #32
    MOVK  X21, #0x9cab, LSL #16
    MOVK  X21, #0xcc20, LSL #0
    MOVK  X22, #0xf3ab, LSL #48
    MOVK  X22, #0xc3cf, LSL #32
    MOVK  X22, #0x4c33, LSL #16
    MOVK  X22, #0xf8d1, LSL #0
    MOVK  X23, #0x74fd, LSL #48
    MOVK  X23, #0x786a, LSL #32
    MOVK  X23, #0xbd0a, LSL #16
    MOVK  X23, #0x7771, LSL #0
    MOVK  X25, #0x1d61, LSL #48
    MOVK  X25, #0x56f0, LSL #32
    MOVK  X25, #0x6ff7, LSL #16
    MOVK  X25, #0xf1af, LSL #0
    MOVK  X26, #0xd70f, LSL #48
    MOVK  X26, #0x1d38, LSL #32
    MOVK  X26, #0xe886, LSL #16
    MOVK  X26, #0xef84, LSL #0
    MOVK  X27, #0xa12d, LSL #48
    MOVK  X27, #0xfa51, LSL #32
    MOVK  X27, #0x3b32, LSL #16
    MOVK  X27, #0x6e9d, LSL #0
    MOVK  X28, #0x581c, LSL #48
    MOVK  X28, #0x476, LSL #32
    MOVK  X28, #0x4b0, LSL #16
    MOVK  X28, #0xeddd, LSL #0
    MOVK  X29, #0xc74, LSL #48
    MOVK  X29, #0xf739, LSL #32
    MOVK  X29, #0xa484, LSL #16
    MOVK  X29, #0x494e, LSL #0
    ADDS  W23, W27, #0xdcc, LSL #12
    MOVZ  X2, #0x499c, LSL #0
    MOVK  X2, #0xf466, LSL #16
    MOVK  X2, #0xf200, LSL #32
    MOVK  X2, #0x8a02, LSL #48
    MOVZ  X3, #0x9120, LSL #0
    MOVK  X3, #0xd038, LSL #16
    MOVK  X3, #0x7145, LSL #32
    MOVK  X3, #0xf56c, LSL #48
    MOVZ  X4, #0xff47, LSL #0
    MOVK  X4, #0x3fc6, LSL #16
    MOVK  X4, #0x61be, LSL #32
    MOVK  X4, #0x67d2, LSL #48
    MOVZ  X5, #0x1709, LSL #0
    MOVK  X5, #0xa002, LSL #16
    MOVK  X5, #0x755f, LSL #32
    MOVK  X5, #0x756b, LSL #48
    MOVZ  X6, #0x115d, LSL #0
    MOVK  X6, #0x1f4b, LSL #16
    MOVK  X6, #0xf0e7, LSL #32
    MOVK  X6, #0x75d5, LSL #48
    MOVZ  X7, #0x4d08, LSL #0
    MOVK  X7, #0xda52, LSL #16
    MOVK  X7, #0xcb84, LSL #32
    MOVK  X7, #0x5227, LSL #48
    MOVZ  X8, #0xe0a2, LSL #0
    MOVK  X8, #0x2bc2, LSL #16
    MOVK  X8, #0x203b, LSL #32
    MOVK  X8, #0x1ce1, LSL #48
    MOVZ  X9, #0xd904, LSL #0
    MOVK  X9, #0xe171, LSL #16
    MOVK  X9, #0x5e39, LSL #32
    MOVK  X9, #0x657c, LSL #48
    MOVZ  X10, #0xb77c, LSL #0
    MOVK  X10, #0x2517, LSL #16
    MOVK  X10, #0xfb3b, LSL #32
    MOVK  X10, #0xaa10, LSL #48
    MOVZ  X11, #0xa268, LSL #0
    MOVK  X11, #0x8b60, LSL #16
    MOVK  X11, #0xc9b, LSL #32
    MOVK  X11, #0x7598, LSL #48
    MOVZ  X12, #0x4420, LSL #0
    MOVK  X12, #0xb4a8, LSL #16
    MOVK  X12, #0x1f03, LSL #32
    MOVK  X12, #0xedb3, LSL #48
    MOVZ  X13, #0x3cc, LSL #0
    MOVK  X13, #0x4e34, LSL #16
    MOVK  X13, #0xf08d, LSL #32
    MOVK  X13, #0xfc83, LSL #48
    MOVZ  X14, #0x475, LSL #0
    MOVK  X14, #0x69a4, LSL #16
    MOVK  X14, #0xe7d0, LSL #32
    MOVK  X14, #0x88ce, LSL #48
    MOVZ  X15, #0x607a, LSL #0
    MOVK  X15, #0x6975, LSL #16
    MOVK  X15, #0x9c2e, LSL #32
    MOVK  X15, #0x8c33, LSL #48
    MOVZ  X16, #0xc4d, LSL #0
    MOVK  X16, #0x31ea, LSL #16
    MOVK  X16, #0xc7a8, LSL #32
    MOVK  X16, #0x89ff, LSL #48
    MOVZ  X17, #0x3cf6, LSL #0
    MOVK  X17, #0x4766, LSL #16
    MOVK  X17, #0xd9c7, LSL #32
    MOVK  X17, #0x39d2, LSL #48
    MOVZ  X18, #0x8298, LSL #0
    MOVK  X18, #0x3c8, LSL #16
    MOVK  X18, #0x45e1, LSL #32
    MOVK  X18, #0xf55, LSL #48
    MOVZ  X19, #0x1efa, LSL #0
    MOVK  X19, #0x5bca, LSL #16
    MOVK  X19, #0x4390, LSL #32
    MOVK  X19, #0xfc2c, LSL #48
    MOVZ  X20, #0x1091, LSL #0
    MOVK  X20, #0x5e6d, LSL #16
    MOVK  X20, #0x7dc1, LSL #32
    MOVK  X20, #0x81d5, LSL #48
    MOVZ  X21, #0xceb4, LSL #0
    MOVK  X21, #0xcdd8, LSL #16
    MOVK  X21, #0xf30e, LSL #32
    MOVK  X21, #0x4e62, LSL #48
    MOVZ  X22, #0xa9de, LSL #0
    MOVK  X22, #0x4d80, LSL #16
    MOVK  X22, #0x632d, LSL #32
    MOVK  X22, #0x290e, LSL #48
    MOVZ  X23, #0x6fe7, LSL #0
    MOVK  X23, #0x311f, LSL #16
    MOVK  X23, #0xdf24, LSL #32
    MOVK  X23, #0xee6b, LSL #48
    MOVZ  X25, #0xac32, LSL #0
    MOVK  X25, #0x9ff4, LSL #16
    MOVK  X25, #0x42b5, LSL #32
    MOVK  X25, #0x24a8, LSL #48
    MOVZ  X26, #0x7fc2, LSL #0
    MOVK  X26, #0xf5fe, LSL #16
    MOVK  X26, #0xdfe0, LSL #32
    MOVK  X26, #0x6649, LSL #48
    MOVZ  X27, #0x4304, LSL #0
    MOVK  X27, #0xb5e0, LSL #16
    MOVK  X27, #0x96ee, LSL #32
    MOVK  X27, #0x768, LSL #48
    MOVZ  X28, #0xd618, LSL #0
    MOVK  X28, #0x117c, LSL #16
    MOVK  X28, #0xf935, LSL #32
    MOVK  X28, #0xe093, LSL #48
    MOVZ  X29, #0xd3e4, LSL #0
    MOVK  X29, #0xc49f, LSL #16
    MOVK  X29, #0xa665, LSL #32
    MOVK  X29, #0x4288, LSL #48
    MOVZ  X12, #0xa, LSL #0
TaishanIntAluP02_label_0:
    ADD  W25, W13, W3, LSL #9
    CSNEG  W8, W9, W5, AL
    CSEL  W27, W13, W25, NV
    CLS  X8, X20
    ADDS  W18, W23, W28, UXTB #0
    ASRV  W27, W26, W3
    CSINC  X26, X8, X8, CS
    MADD  W13, W26, W25, W6
    CRC32B  W13, W28, W28
    BIC  X20, X23, X28, ROR #35
    SUB  X20, X10, X28, ASR #26
    ADDS  W13, W10, W5, SXTW #2
    SUB  W11, W29, W6, SXTH #2
    CLZ  W13, W12
    CSINV  X19, X13, X23, EQ
    AND  W9, W12, #0x8000001f
    CRC32X  W17, W27, X27
    MOVZ  X10, #0x72fa, LSL #0
    ANDS  W27, W17, #0xfc000001
    SUBS  X20, X22, #0xa42
    CSINV  W2, W8, W17, NV
    CRC32CW  W4, W25, W12
    ADC  X16, X23, X8
    ADCS  X16, X14, X16
    MADD  X23, X19, X18, X11
    ORR  V12.8B, V9.8B, V0.8B
    EXTR  X26, X10, X16, #0x23
    SUBS  W28, W4, W25, ASR #7
    CSEL  X2, X16, X22, LT
    SUB  W4, W17, W8, UXTH #4
    ORN  W16, W5, W12, ROR #18
    MOVN  X13, #0x2682, LSL #48
    UMSUBL  X2, W16, W19, X28
    ORR  V22.8H, #0x13, LSL #8
    CLZ  W15, W8
    CSINC  X28, X20, X8, VC
    ADD  X14, X17, X27, SXTX #2
    ADC  X22, X27, X8
    UBFM  W17, W8, #0xa, #0x16
    CSNEG  X17, X18, X4, AL
    ORR  X2, X13, X4, ROR #2
    MOVK  X5, #0x8d37, LSL #48
    ADD  W2, W19, #0x3dd, LSL #12
    EON  X4, X19, X15, LSL #13
    CSNEG  W6, W15, W9, NE
    ORR  V4.4H, #0xa2
    BIC  V13.16B, V31.16B, V10.16B
    SUB  X17, X29, #0x417, LSL #12
    EOR  X9, X11, X14, ASR #38
    ANDS  X10, X4, X9, LSL #25
    SUBS  W4, W13, #0x148, LSL #12
    ANDS  W10, W7, W6, LSR #23
    BICS  X16, X11, X21, LSL #33
    CRC32CH  W14, W17, W18
    MADD  W15, W14, W22, W25
    ADDS  X29, X9, X27, UXTX #4
    MOVK  X11, #0x3a81, LSL #32
    LSRV  X2, X27, X14
    ASRV  X5, X19, X5
    ADDS  W16, W25, W9, UXTW #4
    AND  X21, X28, X11, LSL #18
    SUBS  W2, W9, #0x761
    CRC32CH  W2, W13, W17
    CRC32B  W25, W6, W7
    ADD  X16, X22, X15, ASR #26
    MADD  W8, W27, W21, W4
    EOR  X18, X11, X27, ASR #23
    ORR  V28.16B, V19.16B, V14.16B
    ASRV  X17, X6, X29
    ORR  X9, X28, #0x1f801f801f801f80
    ADD  W7, W9, W9, LSR #18
    ADDS  X23, X8, #0xcc6
    ANDS  W20, W18, W22, LSR #24
    SUB  X13, X14, #0x97a, LSL #12
    ORR  V20.8H, #0x21
    CSEL  X4, X11, X18, NE
    UBFM  W19, W3, #0x12, #0xb
    SMULH  X21, X28, X28
    AND  X16, X5, X8, ROR #59
    CRC32CX  W5, W8, X27
    ORN  W3, W20, W7, ASR #16
    LSLV  W25, W9, W9
    ORR  W22, W15, W3, ASR #4
    CRC32W  W2, W26, W15
    SUB  X7, X25, X9, LSR #24
    MOVK  W6, #0xe405, LSL #0
    AND  W11, W20, #0x20202020
    CLS  V0.8B, V27.8B
    BICS  W3, W3, W19, ASR #24
    SMULH  X14, X23, X19
    ASRV  X3, X20, X20
    ORN  X8, X28, X22, ASR #40
    BIC  X13, X9, X2, ROR #35
    EON  W20, W2, W23, LSL #20
    ORN  W26, W17, W28, ASR #12
    CSINV  X22, X13, X23, VS
    SUB  W11, W12, #0xf6b
    SMULH  X26, X9, X27
    SUB  W29, W25, W12, LSL #10
    SBFM  W11, W22, #0xc, #0xf
    SMULH  X8, X6, X14
    EOR  W20, W7, W19, ROR #8
    ADDS  X16, X16, #0xcc8
    CLZ  W27, W8
    ANDS  X15, X15, X12, ROR #20
    UBFM  X7, X23, #0x34, #0x38
    CSINC  X28, X12, X29, AL
    CLS  V10.2S, V14.2S
    AND  X18, X20, X14, LSL #40
    ANDS  X28, X27, #0x3ffffffffe00000
    ADDS  W22, W13, W25, ASR #12
    SUB  W15, W5, #0x319, LSL #12
    BIC  X13, X5, X7, LSR #8
    CRC32CB  W21, W21, W25
    ASRV  X13, X18, X19
    CRC32CX  W16, W27, X20
    EOR  X15, X11, X17, LSR #9
    CLZ  X3, X20
    MOVK  W5, #0xf724, LSL #16
    ADD  X21, X15, #0x640
    UBFM  X20, X10, #0x2b, #0x3b
    ORN  X28, X12, X16, LSR #27
    CSEL  W23, W3, W29, PL
    SBFM  X22, X17, #0x22, #0x38
    CLS  X19, X8
    ADCS  W18, W28, W23
    CRC32CH  W27, W13, W10
    CLZ  X11, X11
    EON  X16, X29, X8, ASR #57
    EXTR  X14, X7, X12, #0x36
    ADCS  W26, W9, W10
    SUBS  X25, X18, X28, UXTX #4
    ORN  X13, X27, X7, ASR #22
    SUB  X7, X21, #0x1a0
    CSEL  W21, W26, W16, LE
    ADDS  X8, X12, X26, ASR #51
    CLZ  W13, W25
    ORN  W4, W17, W22, LSL #18
    EON  W5, W7, W8, ROR #16
    SUB  W21, W6, W20, LSR #8
    AND  W13, W15, #0xfffffc
    CSINC  X21, X2, X29, MI
    MOVK  W25, #0x7ff1, LSL #16
    SMSUBL  X9, W11, W14, X13
    ADD  W26, W12, #0x285, LSL #12
    SUBS  X17, X5, X4, ASR #50
    SUB  X10, X13, #0x79b, LSL #12
    SUBS  W10, W13, W22, LSR #4
    UBFM  W26, W17, #0x15, #0x19
    CRC32CW  W28, W10, W16
    ANDS  W21, W13, W28, LSL #14
    ORR  V26.8H, #0x3f, LSL #8
    SUB  X26, X16, W7, SXTB #0
    ANDS  X25, X18, #0xfc01fc01fc01fc01
    ANDS  W17, W15, W6, LSL #31
    SUBS  X15, X3, #0x3bf, LSL #12
    SMADDL  X18, W26, W14, X4
    AND  W23, W21, W2, LSL #5
    SUB  X27, X8, X21, ASR #55
    ORR  V15.4H, #0x3b
    ORR  W20, W8, #0xf000ffff
    BIC  V21.16B, V20.16B, V18.16B
    SUBS  W2, W6, W28, LSR #15
    EOR  X21, X2, X5, ASR #40
    BIC  X29, X6, X4, LSL #19
    UBFM  W3, W22, #0x1b, #0x4
    SMSUBL  X17, W20, W2, X25
    CRC32CX  W8, W22, X16
    LSLV  X8, X16, X12
    BIC  X21, X28, X2, ASR #30
    BIC  X8, X3, X18, LSR #59
    SMSUBL  X27, W8, W17, X21
    LSRV  X5, X3, X10
    MOVZ  W17, #0xb614, LSL #0
    MADD  W11, W29, W20, W26
    SUBS  W17, W17, #0x991
    UMULH  X22, X12, X19
    CRC32CH  W2, W11, W27
    CSINV  X5, X13, X13, EQ
    AND  W2, W11, W5, ASR #29
    ADD  X8, X15, X12, LSL #50
    CSINC  W16, W29, W16, NV
    LSLV  W2, W13, W25
    CRC32W  W17, W25, W29
    ORR  X20, X18, X22, LSL #14
    UMULH  X28, X16, X27
    EOR  W18, W3, #0xffc1ffc1
    MOVN  X13, #0x171, LSL #32
    CSINV  X3, X19, X18, GE
    EOR  X18, X26, X9, ASR #57
    ADCS  W9, W4, W19
    CSNEG  X19, X2, X15, VC
    CSNEG  X22, X7, X8, VS
    MADD  X2, X4, X7, X27
    SBFM  X27, X18, #0x32, #0x2f
    ADDS  W21, W12, W9, LSL #19
    MADD  W27, W11, W21, W19
    EON  W14, W8, W27, ASR #5
    ADC  X4, X4, X17
    EON  W26, W2, W27, ROR #6
    SUBS  X12, X12, #0x1
    B.NE  TaishanIntAluP02_label_0
    MOVZ  X11, #0x1e13, LSL #0
    MOVK  X11, #0x3bf9, LSL #16
    MOVK  X11, #0x4a7, LSL #32
    SUB  X19, X11, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X3, #0x3f, LSL #0
    SUB  X12, X3, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x884d, LSL #0
    MOVK  X5, #0x9935, LSL #16
    MOVK  X5, #0x1, LSL #32
    SUB  X26, X5, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X14, #0x884d, LSL #0
    MOVK  X14, #0x9935, LSL #16
    MOVK  X14, #0x1, LSL #32
    SUB  X25, X14, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X6, #0xe405, LSL #0
    SUB  X9, X6, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X8, #0x4a7, LSL #0
    SUB  X11, X8, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X10, #0x4a7, LSL #0
    SUB  X2, X10, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X4, #0x4a7, LSL #0
    SUB  X10, X4, X10
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X11, X3, X11
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xfe8e, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X8, X7, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP02_TestFail
    MOVZ  X8, #0x884d, LSL #0
    MOVK  X8, #0x9935, LSL #16
    MOVK  X8, #0x1, LSL #32
    SUB  X5, X8, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X3, #0x1020, LSL #0
    MOVK  X3, #0xffc4, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X29, X3, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP02_TestFail
    MOVZ  X8, #0xe405, LSL #0
    SUB  X18, X8, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP02_TestFail
    MOVZ  X4, #0x884e, LSL #0
    MOVK  X4, #0x9935, LSL #16
    SUB  X23, X4, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X18
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP02_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X12, X26, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP02_TestFail
    MOVZ  X20, #0x1, LSL #0
    MOVK  X20, #0x1f8, LSL #16
    SUB  X16, X20, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP02_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X4, X9, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X14, #0x2057, LSL #0
    MOVK  X14, #0xb76c, LSL #16
    SUB  X19, X14, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X26, X19, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X22, #0xa, LSL #0
TaishanIntAluP02_label_28:
    SBFM  W21, W16, #0x0, #0x18
    LSRV  X18, X20, X29
    ORR  W18, W26, W22, ROR #17
    AND  W16, W10, #0x1fffe000
    CRC32CW  W5, W9, W3
    ADDS  W5, W19, #0xe52, LSL #12
    ADD  X11, X21, X13, LSR #50
    SUB  X4, X12, #0x972, LSL #12
    AND  X20, X12, X14, ASR #41
    ORR  V10.2S, #0x21
    ORR  X28, X23, X5, LSR #25
    EOR  X17, X16, X27, LSR #35
    SUBS  W14, W4, #0x2c8, LSL #12
    LSLV  W4, W15, W23
    SUB  X23, X25, X10, SXTX #2
    SBFM  X25, X29, #0x38, #0x27
    UMULH  X21, X27, X14
    CSINV  X21, X23, X28, NV
    SBFM  W19, W2, #0xb, #0x1c
    LSRV  X26, X29, X10
    EON  X26, X27, X28, ROR #45
    UMULH  X14, X23, X16
    ADD  X19, X2, W4, SXTW #1
    BICS  W12, W2, W26, ROR #30
    SUB  W18, W21, W29, LSL #9
    SUBS  W9, W8, W20, ASR #11
    EOR  W12, W9, #0xfffbfffb
    EOR  W12, W27, #0x400
    ANDS  X17, X15, #0x1f8000001f8
    CRC32CX  W11, W10, X16
    MOVN  X9, #0x81dc, LSL #48
    CRC32CW  W20, W28, W29
    UMULH  X5, X22, X17
    ADC  X17, X18, X3
    LSRV  W19, W15, W5
    UMADDL  X20, W6, W11, X11
    CRC32CW  W12, W14, W21
    ORN  X14, X9, X14, LSL #4
    ASRV  X17, X21, X14
    ORN  X2, X20, X19, LSR #53
    ANDS  X20, X18, X10, LSL #52
    ASRV  X23, X21, X5
    ADDS  W8, W8, W12, LSL #18
    MOVZ  X17, #0x9def, LSL #32
    MOVZ  X23, #0x138, LSL #48
    SUBS  W23, W26, W17, LSL #4
    ADDS  W26, W23, #0xb00
    ORR  V1.4S, #0x8a, LSL #16
    ADCS  X5, X28, X26
    EOR  X5, X5, X2, ASR #29
    CSINV  W9, W6, W14, VC
    ORR  W23, W22, W22, LSR #12
    ORR  X29, X17, X23, LSR #0
    LSLV  W21, W16, W2
    LSLV  W6, W9, W11
    MADD  W4, W20, W8, W9
    CLZ  W10, W12
    LSLV  W16, W11, W3
    ORR  W23, W21, W21, ROR #11
    CLS  V11.4H, V27.4H
    EXTR  X29, X14, X11, #0x1f
    ORR  V15.4H, #0x8a, LSL #8
    SBFM  W14, W18, #0x6, #0x1e
    CRC32CW  W29, W19, W12
    ANDS  X8, X19, X29, ROR #32
    CRC32W  W28, W20, W2
    ANDS  X28, X21, #0x1ffc00001ffc0
    EXTR  X16, X6, X17, #0x16
    CRC32CH  W2, W29, W2
    ADCS  X23, X19, X18
    MOVN  W11, #0x6d72, LSL #0
    EON  W5, W29, W28, ASR #2
    CRC32B  W12, W22, W25
    EON  W20, W10, W9, ROR #4
    ORR  V21.4H, #0xde, LSL #8
    SUBS  W4, W21, #0x92f, LSL #12
    SUB  X21, X17, X6, LSR #28
    ORR  W4, W21, W19, LSL #29
    ANDS  X2, X16, X15, ROR #59
    CRC32CB  W4, W26, W5
    ORR  X17, X22, #0xc0000000001fffff
    LSRV  X14, X20, X28
    ADC  X17, X17, X17
    ADD  W5, W4, W6, ASR #19
    AND  X2, X21, #0xffffffff800000
    EXTR  X10, X19, X28, #0x16
    ADDS  W6, W6, W27, ASR #10
    ORN  W27, W13, W11, LSR #14
    ADDS  W10, W11, W17, LSL #22
    ADDS  W26, W28, #0x860
    CSINV  X4, X28, X22, GE
    CLZ  X2, X25
    CLZ  X26, X14
    ORR  X28, X16, X27, LSL #13
    ANDS  X10, X20, #0xff800000003fffff
    MADD  W19, W17, W10, W20
    CSINV  W13, W15, W10, NE
    ANDS  X8, X11, X29, ROR #42
    SUB  X19, X29, X19, UXTX #3
    CRC32B  W11, W13, W10
    UMADDL  X5, W21, W5, X13
    CRC32CX  W19, W22, X16
    LSLV  W8, W20, W16
    LSRV  W19, W28, W12
    AND  X6, X22, X8, ASR #34
    ADC  X4, X18, X28
    MOVN  X23, #0x85e7, LSL #32
    BIC  X21, X9, X15, LSL #8
    SUBS  W8, W27, W11, SXTW #0
    ORN  X2, X6, X4, LSR #26
    UMULH  X23, X2, X21
    SUB  X7, X5, W8, SXTB #0
    SUBS  W2, W13, #0xf1c, LSL #12
    ORR  W6, W26, #0x780078
    SUB  X7, X11, X20, LSL #22
    CRC32CX  W23, W19, X4
    SMULH  X12, X6, X23
    ORR  X7, X28, #0xffff800000000fff
    EON  W16, W2, W18, LSR #27
    CRC32CW  W8, W12, W7
    MOVN  W29, #0x4ec7, LSL #16
    EOR  W17, W22, #0x80007fff
    SUBS  X18, X29, X7, LSR #19
    AND  X14, X18, X5, ROR #49
    CRC32CX  W16, W7, X13
    LSLV  X9, X11, X14
    ADD  X15, X26, X26, ASR #62
    AND  W7, W27, W13, LSR #8
    ORR  V27.2S, #0x7b, LSL #24
    CLZ  X13, X16
    EON  X12, X16, X20, LSL #57
    MADD  X28, X3, X7, X16
    BICS  W13, W21, W28, ASR #25
    LSLV  X20, X20, X16
    ORR  X8, X7, X11, ASR #31
    ADD  X5, X4, X20, LSR #21
    CSEL  W28, W5, W11, LE
    SBFM  X8, X11, #0x18, #0xa
    ADDS  X12, X11, #0x3d0
    ASRV  W20, W21, W25
    MOVK  X15, #0x735, LSL #16
    CSINC  X15, X9, X26, VC
    BIC  X13, X6, X20, ROR #7
    AND  W26, W12, #0x44444444
    ASRV  W14, W9, W8
    SUBS  X10, X18, W7, SXTW #1
    CLZ  X5, X15
    ADD  W28, W16, W10, SXTW #1
    ORR  X28, X5, X16, LSL #54
    EOR  X26, X19, #0xffffffff001fffff
    ADDS  W4, W22, #0x3a0
    BIC  X20, X20, X11, LSR #1
    CSNEG  X21, X5, X7, MI
    ANDS  X19, X22, X2, ASR #28
    ADD  W17, W3, W11, UXTW #0
    LSLV  W12, W10, W6
    ADD  X23, X14, W11, UXTH #3
    BIC  X25, X11, X21, LSR #35
    SUB  W19, W19, #0xe7a, LSL #12
    CRC32CH  W13, W16, W8
    CRC32B  W17, W6, W16
    MOVN  X16, #0xa175, LSL #0
    ORR  V12.4S, #0x95, LSL #16
    MOVZ  X4, #0x70df, LSL #32
    ORR  X7, X20, #0x1ffffc001ffffc00
    SUBS  X7, X18, #0x54e
    MADD  X18, X27, X11, X11
    SMULH  X26, X4, X25
    CRC32CX  W15, W18, X13
    CRC32B  W18, W5, W20
    ORR  W17, W14, #0xf0001fff
    ORN  W25, W17, W22, LSL #4
    MOVN  W9, #0x6171, LSL #0
    ORR  V0.4H, #0x2f
    SMADDL  X23, W16, W28, X6
    EOR  W8, W4, #0x3c003c00
    MADD  W4, W7, W19, W3
    ADD  X4, X10, X11, LSR #57
    EOR  X21, X14, X26, LSR #5
    SUBS  X17, X2, X6, LSL #33
    CSINC  X9, X27, X17, LS
    SUB  W13, W8, W21, UXTH #4
    MADD  X7, X13, X8, X9
    MOVZ  W15, #0xe28b, LSL #16
    ANDS  X17, X18, #0x1f001f001f001f
    SUBS  W13, W3, #0xf2
    BIC  X7, X2, X22, ASR #14
    SBFM  X20, X5, #0xc, #0x3d
    CLS  V2.8H, V24.8H
    MADD  W20, W16, W14, W4
    CRC32H  W4, W27, W21
    UBFM  W8, W20, #0x1d, #0x17
    ADCS  X13, X18, X22
    UMADDL  X28, W6, W11, X12
    ADD  W16, W18, W11, LSL #5
    SUB  W9, W9, #0x701
    ADD  X19, X8, X16, LSL #40
    SUBS  W4, W15, #0x35f, LSL #12
    ADD  W5, W12, #0x4de
    SUB  W27, W21, #0xcdf
    SUBS  X22, X22, #0x1
    B.NE  TaishanIntAluP02_label_28
    MOVZ  X10, #0x4000, LSL #0
    MOVK  X10, #0xe199, LSL #16
    SUB  X2, X10, X2
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X5, X25, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X25, #0x1000, LSL #0
    MOVK  X25, #0xe255, LSL #16
    SUB  X19, X25, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X13, #0x79, LSL #0
    MOVK  X13, #0x78, LSL #16
    SUB  X4, X13, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X7, #0x4000, LSL #0
    MOVK  X7, #0xe199, LSL #16
    SUB  X26, X7, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X5, #0xaae8, LSL #0
    MOVK  X5, #0x3f6, LSL #16
    SUB  X18, X5, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP02_TestFail
    MOVZ  X21, #0xc2a4, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X6, X21, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X9, #0x4000, LSL #0
    MOVK  X9, #0xe199, LSL #16
    SUB  X8, X9, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP02_TestFail
    MOVZ  X19, #0xf12e, LSL #0
    MOVK  X19, #0xb384, LSL #16
    SUB  X6, X19, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x2200, LSL #16
    SUB  X12, X7, X12
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP02_TestFail
    MOVZ  X27, #0x79, LSL #0
    MOVK  X27, #0x78, LSL #16
    SUB  X3, X27, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X5, #0xf12e, LSL #0
    MOVK  X5, #0xb384, LSL #16
    SUB  X21, X5, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP02_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xe28b, LSL #16
    SUB  X17, X7, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X16
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP02_TestFail
    MOVZ  X16, #0xf12e, LSL #0
    MOVK  X16, #0xb384, LSL #16
    SUB  X23, X16, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X17, #0xd55d, LSL #0
    MOVK  X17, #0x607e, LSL #16
    SUB  X3, X17, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X28, #0x1000, LSL #0
    MOVK  X28, #0xe255, LSL #16
    SUB  X11, X28, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X21, X12, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x1000, LSL #0
    MOVK  X5, #0xe255, LSL #16
    SUB  X12, X5, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP02_TestFail
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
TaishanIntAluP02_label_56:
    CRC32X  W20, W21, X28
    ADDS  W18, W26, #0x9b0
    ORR  X4, X18, #0xfe00001ffe00001f
    CLS  V12.16B, V12.16B
    ASRV  X22, X8, X16
    MADD  X27, X18, X18, X8
    SUB  X18, X23, X28, SXTX #2
    CSINC  W2, W23, W19, LS
    SMADDL  X10, W20, W20, X10
    ADDS  X4, X2, #0x9f0
    CRC32CW  W20, W20, W7
    ASRV  W18, W3, W8
    ANDS  W27, W13, W2, LSR #26
    MOVZ  W22, #0xf8ef, LSL #0
    ORR  W22, W9, W25, ASR #10
    ADD  X4, X3, W10, SXTH #1
    SBFM  X11, X5, #0x2a, #0x1b
    UBFM  X8, X21, #0x9, #0x39
    CSINV  W21, W21, W13, CS
    SUB  X11, X17, X6, UXTX #3
    EON  W15, W6, W15, LSR #16
    CLS  V21.4S, V16.4S
    UBFM  W17, W19, #0x10, #0x3
    SUBS  W15, W27, W20, ASR #28
    ORR  V17.4H, #0x83, LSL #8
    AND  W25, W20, #0x44444444
    SMSUBL  X12, W29, W20, X9
    ADD  X29, X17, W18, UXTW #3
    SUB  X11, X29, W23, UXTW #0
    ASRV  W29, W8, W18
    ADDS  X22, X5, W3, SXTH #3
    ORN  W16, W21, W9, ASR #1
    SUB  W23, W9, W27, ASR #26
    ANDS  X11, X9, #0xfffffc00fffffc00
    AND  X5, X22, #0xc000c000c000c0
    CRC32CB  W20, W12, W4
    SUBS  W25, W7, W21, UXTB #2
    CSEL  W22, W29, W27, LT
    ADDS  W25, W7, #0x837, LSL #12
    CRC32X  W20, W6, X11
    SUBS  X3, X23, W15, UXTB #3
    ADD  X12, X15, W26, SXTB #2
    ADD  X13, X29, W17, SXTH #0
    SUB  X28, X17, X10, LSR #39
    AND  W27, W18, #0xffff03ff
    ADD  W28, W26, W13, UXTH #4
    MADD  W26, W8, W16, W22
    CLZ  W21, W7
    CLS  X10, X5
    CSEL  X27, X11, X10, EQ
    ORR  X28, X20, #0xf0000000
    SUB  W4, W8, W19, UXTB #2
    CRC32B  W10, W19, W10
    EON  W11, W12, W23, ROR #24
    ORR  X25, X18, #0x3ff000003ff00
    CSNEG  W13, W4, W9, CS
    CLS  V19.8B, V3.8B
    ASRV  W4, W14, W26
    CSINC  W8, W21, W15, GE
    ORR  V30.16B, V19.16B, V16.16B
    ORR  V4.8B, V6.8B, V1.8B
    CSNEG  W27, W10, W11, NV
    CSINC  X22, X21, X27, VS
    MADD  W22, W11, W13, W6
    ADCS  X15, X27, X20
    ORR  W17, W4, W21, LSR #2
    SUBS  X12, X16, W28, SXTW #3
    CSEL  W13, W4, W6, HI
    UMULH  X13, X17, X3
    SUBS  W12, W4, W14, UXTB #2
    ANDS  X19, X26, X26, ASR #12
    EOR  W25, W15, #0xe0e0e0e0
    MOVZ  X19, #0xb558, LSL #16
    ORR  X3, X5, #0x7e00
    MOVZ  X25, #0x80d3, LSL #16
    ADDS  W8, W4, W14, SXTH #0
    SUBS  X14, X27, #0x6b1, LSL #12
    CRC32W  W10, W6, W23
    LSRV  W26, W10, W10
    SUBS  X9, X27, #0x843
    ADDS  X5, X3, #0x65e, LSL #12
    ANDS  W19, W13, W20, LSL #25
    MOVN  W25, #0x979a, LSL #0
    MOVZ  X15, #0x261d, LSL #0
    ASRV  W2, W12, W7
    AND  W22, W29, W7, ROR #21
    UMADDL  X23, W16, W8, X3
    AND  W26, W3, W10, LSL #25
    CLS  V25.16B, V3.16B
    ANDS  X2, X25, X16, LSR #11
    ORR  V6.4H, #0xa4, LSL #8
    ORR  V6.8H, #0xcd
    EXTR  X11, X16, X20, #0x1
    SUB  X9, X8, X28, LSL #54
    ADD  W2, W29, W3, ASR #20
    ORN  X8, X15, X11, LSL #54
    CRC32CB  W15, W5, W15
    EOR  W17, W20, #0x7ffffff
    CRC32CX  W18, W19, X25
    CSNEG  W15, W21, W3, VC
    MOVK  X3, #0xd2b3, LSL #32
    BICS  W3, W25, W7, ASR #11
    ORR  V30.4S, #0x28, LSL #16
    CSEL  W25, W25, W6, CC
    EOR  W9, W12, #0x3fc03fc0
    LSRV  X13, X20, X16
    CSNEG  X23, X6, X14, LT
    ADD  X26, X25, W18, UXTH #0
    ADD  W10, W20, W21, ASR #8
    SUBS  W21, W18, W16, UXTH #0
    EON  W26, W21, W21, ASR #21
    ADD  X19, X25, #0x6e2
    SMSUBL  X9, W16, W17, X18
    MOVN  W17, #0xca0f, LSL #0
    ORR  X26, X12, #0x9f9f9f9f9f9f9f9f
    ADD  X18, X14, X20, SXTX #4
    SUB  W3, W9, W23, SXTH #4
    ASRV  X20, X5, X5
    SBFM  W16, W28, #0x13, #0x5
    SUBS  X5, X12, W18, SXTW #3
    CRC32H  W4, W10, W18
    LSRV  W16, W12, W4
    MOVN  X3, #0x7284, LSL #0
    CLZ  W12, W19
    CSNEG  W8, W18, W21, HI
    BIC  W25, W10, W6, ASR #22
    CSINV  W15, W14, W17, PL
    SMADDL  X16, W28, W6, X26
    CLZ  X14, X11
    ADC  X13, X19, X6
    SUB  X13, X16, X7, UXTX #2
    EXTR  X3, X10, X15, #0x27
    EOR  X17, X13, X12, ASR #24
    SUB  W11, W4, W18, UXTH #2
    LSRV  X28, X28, X10
    CRC32CX  W14, W8, X17
    CSINV  X9, X4, X7, CC
    ASRV  W18, W17, W28
    CRC32B  W21, W29, W26
    CRC32CW  W25, W28, W10
    ADC  X21, X20, X4
    EON  X29, X21, X11, ASR #31
    CSEL  W9, W23, W6, GT
    SUBS  W3, W19, #0x810
    MOVK  W16, #0x6cb8, LSL #16
    MOVK  X7, #0x87a7, LSL #0
    MOVN  W26, #0x43f9, LSL #16
    CLS  V7.8B, V27.8B
    ADD  W19, W17, W8, UXTX #3
    AND  W21, W16, #0xe0007fff
    BICS  X9, X26, X23, LSR #40
    UMADDL  X25, W13, W4, X8
    ADDS  W19, W15, W15, LSR #18
    CSEL  W11, W15, W12, AL
    ORR  V28.16B, V6.16B, V21.16B
    SMADDL  X5, W26, W9, X9
    SBFM  X21, X19, #0x30, #0x1b
    SUBS  W8, W7, #0x80
    SUBS  X10, X3, #0xb0
    ANDS  W25, W4, W29, LSR #14
    ORR  V26.16B, V24.16B, V2.16B
    ADDS  X20, X7, #0x3dc, LSL #12
    BIC  X20, X13, X27, LSL #51
    ADDS  X23, X23, W5, SXTH #2
    SUBS  W20, W23, W10, ASR #19
    ANDS  X17, X28, #0xffffc0000000000
    CSINC  X11, X22, X17, NV
    BICS  X11, X21, X16, ROR #40
    SUBS  X9, X19, #0x1fd, LSL #12
    CSEL  W12, W16, W18, MI
    ASRV  X7, X11, X4
    ADDS  X22, X8, #0x22a, LSL #12
    ADD  W13, W11, #0x420
    ADDS  X9, X16, X15, SXTX #0
    MOVZ  W14, #0xe74f, LSL #0
    SUB  X18, X18, X22, ASR #19
    BIC  X28, X17, X11, ROR #8
    ADD  X21, X6, W18, UXTW #0
    CRC32H  W18, W18, W25
    UMADDL  X14, W15, W20, X18
    ADDS  X15, X22, X17, LSR #25
    EOR  X25, X23, X26, LSR #3
    CRC32CH  W15, W25, W19
    SUB  W4, W28, W20, SXTH #2
    UBFM  X20, X23, #0x20, #0x20
    MOVK  W8, #0x85a9, LSL #16
    UBFM  W7, W10, #0xb, #0x1e
    EOR  W3, W3, W10, ROR #16
    EON  W8, W14, W28, ASR #14
    ADD  X3, X18, X13, ASR #21
    ADD  X28, X12, X26, ASR #10
    SUBS  X8, X6, #0x541, LSL #12
    ADCS  W13, W25, W29
    MOVK  X17, #0x773e, LSL #48
    ORR  W9, W11, #0x6060606
    ORR  W21, W4, #0x2020202
    ANDS  X19, X15, X26, LSL #42
    ORN  W10, W28, W28, LSR #31
    EON  X13, X20, X26, ASR #63
    ASRV  X12, X14, X7
    SUBS  X6, X6, #0x1
    B.NE  TaishanIntAluP02_label_56
    MOVZ  X16, #0xc, LSL #0
    SUB  X26, X16, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X6, #0xec5a, LSL #0
    MOVK  X6, #0xe959, LSL #16
    SUB  X15, X6, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP02_TestFail
    MOVZ  X16, #0xfff8, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X12, X16, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x43f9, LSL #16
    MOVK  X5, #0x4832, LSL #32
    MOVK  X5, #0x120c, LSL #48
    SUB  X9, X5, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X14, #0xec5a, LSL #0
    MOVK  X14, #0xe959, LSL #16
    SUB  X2, X14, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X21, #0xffec, LSL #0
    MOVK  X21, #0xf, LSL #16
    SUB  X3, X21, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X2, #0xf001, LSL #0
    MOVK  X2, #0xffab, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X4, X2, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X6, X17, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xc692, LSL #16
    MOVK  X13, #0x417, LSL #32
    SUB  X21, X13, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X7, X11, X12
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xc692, LSL #16
    MOVK  X27, #0x417, LSL #32
    SUB  X28, X27, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP02_TestFail
    MOVZ  X20, #0xec5a, LSL #0
    MOVK  X20, #0xe959, LSL #16
    SUB  X23, X20, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP02_TestFail
    MOVZ  X14, #0xfff8, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X11, X14, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X3, X27, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X6, #0xe626, LSL #0
    MOVK  X6, #0xe959, LSL #16
    SUB  X14, X6, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X29, #0xec5a, LSL #0
    MOVK  X29, #0xe959, LSL #16
    SUB  X16, X29, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X8, #0x2727, LSL #0
    MOVK  X8, #0x32, LSL #16
    SUB  X28, X8, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X14, X15, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    SUB  X4, X5, X27
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X15, #0xec5a, LSL #0
    MOVK  X15, #0xe959, LSL #16
    SUB  X16, X15, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x9e24, LSL #0
    MOVK  X2, #0x274, LSL #16
    MOVK  X2, #0x892b, LSL #32
    MOVK  X2, #0x194c, LSL #48
    MOVZ  X3, #0x5129, LSL #0
    MOVK  X3, #0x73b2, LSL #16
    MOVK  X3, #0x8ef, LSL #32
    MOVK  X3, #0x71d0, LSL #48
    MOVZ  X4, #0x458c, LSL #0
    MOVK  X4, #0xfc4d, LSL #16
    MOVK  X4, #0x8504, LSL #32
    MOVK  X4, #0x47ba, LSL #48
    MOVZ  X5, #0x89e8, LSL #0
    MOVK  X5, #0xb165, LSL #16
    MOVK  X5, #0xdfe4, LSL #32
    MOVK  X5, #0xff11, LSL #48
    MOVZ  X6, #0x4967, LSL #0
    MOVK  X6, #0x655f, LSL #16
    MOVK  X6, #0xafbc, LSL #32
    MOVK  X6, #0x9034, LSL #48
    MOVZ  X7, #0x7c75, LSL #0
    MOVK  X7, #0xba98, LSL #16
    MOVK  X7, #0x82d8, LSL #32
    MOVK  X7, #0x9c7a, LSL #48
    MOVZ  X8, #0x8dce, LSL #0
    MOVK  X8, #0x6bf1, LSL #16
    MOVK  X8, #0x889a, LSL #32
    MOVK  X8, #0xc1be, LSL #48
    MOVZ  X9, #0x16d9, LSL #0
    MOVK  X9, #0xf03a, LSL #16
    MOVK  X9, #0x792b, LSL #32
    MOVK  X9, #0xd25c, LSL #48
    MOVZ  X10, #0xe7cd, LSL #0
    MOVK  X10, #0xa3bd, LSL #16
    MOVK  X10, #0x2526, LSL #32
    MOVK  X10, #0x8c2b, LSL #48
    MOVZ  X11, #0x71b3, LSL #0
    MOVK  X11, #0xd771, LSL #16
    MOVK  X11, #0x162e, LSL #32
    MOVK  X11, #0xbebb, LSL #48
    MOVZ  X12, #0x84bc, LSL #0
    MOVK  X12, #0xa20a, LSL #16
    MOVK  X12, #0x7bda, LSL #32
    MOVK  X12, #0x1f34, LSL #48
    MOVZ  X13, #0x6652, LSL #0
    MOVK  X13, #0x8a69, LSL #16
    MOVK  X13, #0xad1f, LSL #32
    MOVK  X13, #0x9325, LSL #48
    MOVZ  X14, #0x11c1, LSL #0
    MOVK  X14, #0x2485, LSL #16
    MOVK  X14, #0xb76a, LSL #32
    MOVK  X14, #0xb9fb, LSL #48
    MOVZ  X15, #0xff94, LSL #0
    MOVK  X15, #0xc45, LSL #16
    MOVK  X15, #0xc144, LSL #32
    MOVK  X15, #0x6e42, LSL #48
    MOVZ  X16, #0xab1d, LSL #0
    MOVK  X16, #0xb5db, LSL #16
    MOVK  X16, #0xfdf6, LSL #32
    MOVK  X16, #0x6dd4, LSL #48
    MOVZ  X17, #0x38a4, LSL #0
    MOVK  X17, #0xe1df, LSL #16
    MOVK  X17, #0x120b, LSL #32
    MOVK  X17, #0xcc06, LSL #48
    MOVZ  X18, #0xc8a4, LSL #0
    MOVK  X18, #0x6ff5, LSL #16
    MOVK  X18, #0xc7ec, LSL #32
    MOVK  X18, #0xad7d, LSL #48
    MOVZ  X19, #0x5935, LSL #0
    MOVK  X19, #0x65e0, LSL #16
    MOVK  X19, #0xc8ef, LSL #32
    MOVK  X19, #0xa92f, LSL #48
    MOVZ  X20, #0xc86, LSL #0
    MOVK  X20, #0x7553, LSL #16
    MOVK  X20, #0xd830, LSL #32
    MOVK  X20, #0x7eae, LSL #48
    MOVZ  X21, #0xa245, LSL #0
    MOVK  X21, #0x7f8f, LSL #16
    MOVK  X21, #0xbd44, LSL #32
    MOVK  X21, #0x240d, LSL #48
    MOVZ  X22, #0xb431, LSL #0
    MOVK  X22, #0x9491, LSL #16
    MOVK  X22, #0x9148, LSL #32
    MOVK  X22, #0xbf19, LSL #48
    MOVZ  X23, #0x36ba, LSL #0
    MOVK  X23, #0x9459, LSL #16
    MOVK  X23, #0x2380, LSL #32
    MOVK  X23, #0xd9d8, LSL #48
    MOVZ  X25, #0x3cb0, LSL #0
    MOVK  X25, #0x15e9, LSL #16
    MOVK  X25, #0x7fe9, LSL #32
    MOVK  X25, #0xc541, LSL #48
    MOVZ  X26, #0xaa30, LSL #0
    MOVK  X26, #0xcbf, LSL #16
    MOVK  X26, #0x2dd2, LSL #32
    MOVK  X26, #0x74e9, LSL #48
    MOVZ  X27, #0xfabd, LSL #0
    MOVK  X27, #0xbf6e, LSL #16
    MOVK  X27, #0x6613, LSL #32
    MOVK  X27, #0x9e88, LSL #48
    MOVZ  X28, #0xc772, LSL #0
    MOVK  X28, #0x7f8a, LSL #16
    MOVK  X28, #0xaf8c, LSL #32
    MOVK  X28, #0xcdf8, LSL #48
    MOVZ  X29, #0x44ed, LSL #0
    MOVK  X29, #0x4fde, LSL #16
    MOVK  X29, #0x1e1b, LSL #32
    MOVK  X29, #0xdbeb, LSL #48
    MOVZ  X27, #0xa, LSL #0
TaishanIntAluP02_label_84:
    CRC32X  W9, W5, X12
    ADD  W15, W27, W17, LSR #14
    EON  W9, W19, W17, LSL #14
    BIC  V7.16B, V0.16B, V6.16B
    CRC32W  W2, W9, W28
    CRC32H  W26, W17, W19
    CSINC  W14, W26, W29, NE
    MOVK  W19, #0x166d, LSL #16
    SMULH  X17, X7, X23
    CLS  V8.16B, V2.16B
    ORR  V20.8H, #0xa2
    ADD  X17, X19, W17, UXTH #0
    ADD  X8, X2, X2, LSR #62
    BICS  X26, X6, X10, ROR #34
    ADDS  W18, W22, W22, UXTB #4
    UBFM  W25, W25, #0x3, #0xe
    EON  X3, X19, X25, ROR #58
    EOR  W11, W9, #0x1fe0000
    SUB  X9, X23, W3, UXTW #0
    ADDS  X6, X28, W18, SXTW #2
    ORR  X15, X28, X20, ROR #48
    UMULH  X14, X15, X27
    ANDS  W3, W7, W10, LSR #11
    ADDS  W17, W18, W15, LSR #23
    UMULH  X19, X13, X22
    ADC  W16, W14, W16
    AND  X21, X17, #0x3ffffffffffffff0
    EON  W21, W10, W11, ASR #23
    ADCS  W2, W8, W23
    SUB  X14, X23, X10, ASR #13
    ADDS  X3, X9, #0xe49, LSL #12
    MOVN  X12, #0x9c3f, LSL #32
    CRC32H  W10, W22, W21
    BICS  W2, W23, W7, LSL #21
    BICS  W22, W25, W29, ASR #9
    ADDS  X11, X7, X19, ASR #17
    MOVZ  X3, #0xc848, LSL #0
    SMADDL  X20, W11, W3, X16
    ADCS  W20, W21, W25
    EOR  W2, W9, W6, ASR #25
    MOVN  W18, #0x140f, LSL #0
    CRC32W  W5, W3, W13
    MOVK  W5, #0x8ffe, LSL #16
    UMADDL  X15, W2, W19, X12
    BICS  W5, W22, W25, LSR #28
    CSINC  X3, X23, X10, LT
    ADD  W16, W21, W13, LSR #25
    UMULH  X3, X3, X19
    SUB  X14, X10, #0x940
    CSINV  W18, W14, W29, CS
    SUBS  X2, X16, X9, SXTX #1
    CLS  X17, X3
    SBFM  W22, W7, #0x0, #0x4
    MADD  X3, X15, X23, X2
    ADCS  X3, X19, X20
    BIC  V24.8B, V18.8B, V26.8B
    CSEL  X4, X10, X23, NE
    SMULH  X6, X29, X5
    AND  W23, W5, #0x3ffe00
    SUBS  X29, X3, X7, ASR #21
    SUBS  X29, X21, X7, SXTX #1
    SUB  X28, X16, X28, LSL #56
    CLS  X25, X13
    ADCS  X19, X6, X12
    ANDS  W9, W5, #0x801fffff
    CRC32CW  W17, W15, W14
    CSEL  W8, W12, W17, LS
    SUB  W26, W15, W26, UXTX #0
    MOVZ  X28, #0xaf1f, LSL #0
    CRC32X  W14, W13, X22
    SUBS  W18, W26, #0x8d, LSL #12
    LSLV  W22, W5, W18
    ANDS  X13, X5, #0xfffff000fffff000
    SBFM  W28, W19, #0x1b, #0x10
    SUBS  W13, W8, W10, LSR #9
    BIC  W23, W12, W23, LSR #17
    SUBS  W13, W21, W13, LSL #3
    ADD  W14, W28, #0xa9f
    LSRV  X14, X9, X14
    MADD  W26, W4, W6, W25
    SUBS  W17, W13, W4, LSL #18
    SUB  W2, W3, W28, SXTW #2
    CRC32CX  W14, W28, X8
    CRC32H  W26, W29, W25
    SUBS  W23, W26, W10, LSR #17
    EOR  X8, X16, X17, LSR #0
    SUB  X8, X18, #0x48c, LSL #12
    CLZ  X16, X25
    ORN  W12, W18, W29, LSL #6
    EXTR  W29, W18, W19, #0x16
    EON  X25, X20, X5, LSR #7
    BIC  X9, X5, X22, LSL #29
    CSINV  X8, X6, X17, CS
    ANDS  X29, X5, #0x180000
    MOVN  W21, #0x7076, LSL #16
    ADD  W12, W25, #0xb13, LSL #12
    ORR  W8, W11, W29, LSR #27
    ADD  W2, W22, W28, SXTW #3
    CSINV  W13, W17, W13, CC
    ORR  V13.2S, #0x8, LSL #8
    SUB  X21, X5, W16, SXTW #0
    SMADDL  X20, W5, W17, X23
    EOR  X21, X28, #0x7ffffffe7ffffffe
    UBFM  X7, X19, #0xe, #0x33
    SUB  X17, X20, X2, ASR #11
    SUB  X8, X6, W29, SXTB #3
    ANDS  W9, W9, W3, ROR #9
    SUB  X12, X5, W21, UXTH #4
    LSRV  W7, W7, W6
    SUB  X3, X17, X10, LSR #12
    ADC  X10, X14, X15
    ADD  W7, W29, W4, SXTW #2
    UMADDL  X6, W8, W28, X25
    ADC  X16, X26, X22
    ADD  X25, X10, W27, UXTH #2
    SUBS  W9, W17, #0x59, LSL #12
    ADC  X5, X22, X28
    ORR  V19.2S, #0xc6, LSL #24
    CSNEG  X5, X26, X5, LE
    SUBS  X9, X18, X23, ASR #51
    ADD  X22, X18, #0xce6
    MOVK  W15, #0x2ab9, LSL #0
    EOR  W7, W5, W3
    ADDS  W11, W22, W12, UXTW #0
    SUBS  W5, W19, W11, SXTB #2
    ORR  V20.2S, #0xda
    MOVZ  X10, #0x2f9c, LSL #32
    BIC  X17, X23, X14, LSL #57
    ADDS  X14, X4, X21, SXTX #1
    ASRV  W11, W2, W16
    UMULH  X26, X15, X6
    CRC32H  W26, W27, W25
    CSEL  W28, W5, W4, PL
    SUBS  X2, X29, #0x0
    ASRV  X13, X12, X4
    SUBS  W25, W26, #0x190
    ADDS  W18, W10, W25, SXTB #3
    ADDS  W10, W27, #0xf4c
    SMSUBL  X17, W2, W13, X29
    ADDS  W2, W18, #0xeef, LSL #12
    EOR  W19, W19, W22, LSL #4
    ADDS  X3, X7, X23, UXTX #3
    ADD  W9, W15, #0xe80
    ADD  X26, X29, W18, SXTW #2
    CRC32H  W22, W8, W7
    ADD  X22, X13, W15, SXTW #4
    CSINV  X18, X26, X23, HI
    EOR  W28, W26, #0xffefffef
    BIC  V16.16B, V12.16B, V11.16B
    ORR  X25, X4, X20, LSL #58
    ADC  X25, X13, X5
    CRC32W  W2, W3, W22
    AND  X21, X22, X10, ROR #10
    CSINC  X10, X25, X29, HI
    SUBS  W23, W10, W15, SXTB #0
    CRC32W  W20, W29, W14
    ADD  X21, X28, #0x188, LSL #12
    CRC32CX  W23, W2, X11
    CRC32CB  W18, W20, W21
    EOR  X7, X4, #0x7ffffffffff0
    EOR  X11, X5, X2, LSL #13
    ADDS  W8, W23, #0xa0e
    CRC32W  W23, W6, W18
    EOR  X6, X15, #0xffffffffffff80
    AND  W13, W23, W18, LSR #30
    ORR  V1.8H, #0x7c, LSL #8
    ADD  X16, X27, X2, UXTX #4
    CLZ  X16, X17
    ORR  V20.2S, #0x3a
    ANDS  W7, W20, #0xfc00
    MOVN  X28, #0xb640, LSL #48
    UBFM  X28, X3, #0x18, #0xf
    ORN  X10, X7, X10, LSL #46
    ADDS  W11, W29, W26, SXTW #3
    SUBS  W2, W21, W20, LSL #20
    ADD  W3, W22, W5, UXTH #1
    AND  X21, X17, #0x3fffffe00000
    CRC32W  W14, W14, W9
    MADD  X15, X26, X13, X5
    SBFM  W25, W2, #0x1b, #0xc
    MOVZ  X16, #0xc635, LSL #0
    MOVN  W22, #0xd6c5, LSL #0
    LSLV  X5, X20, X11
    ANDS  X7, X17, #0xc000000003ffffff
    SMULH  X17, X12, X17
    SMADDL  X11, W5, W11, X25
    ADCS  W23, W27, W18
    EON  W17, W16, W12, ROR #10
    ADD  X12, X15, #0x700
    CLZ  V30.2S, V24.2S
    UMSUBL  X25, W21, W17, X27
    ORR  X15, X10, #0x2000000020000
    ADDS  X29, X7, X19, UXTX #3
    SBFM  W6, W23, #0x10, #0xc
    ADD  W6, W11, #0x470
    ASRV  W23, W20, W14
    LSLV  W20, W11, W13
    ORN  X18, X29, X29, LSR #24
    CSNEG  W10, W19, W26, AL
    ADDS  X17, X27, W13, UXTH #3
    SUBS  X27, X27, #0x1
    B.NE  TaishanIntAluP02_label_84
    MOVZ  X20, #0x7faf, LSL #0
    MOVK  X20, #0xcac8, LSL #16
    SUB  X2, X20, X2
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X14, #0xade7, LSL #0
    MOVK  X14, #0xfff2, LSL #16
    SUB  X4, X14, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X28, #0x5354, LSL #0
    MOVK  X28, #0x134e, LSL #16
    SUB  X16, X28, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X6, #0xa250, LSL #0
    MOVK  X6, #0x9ca6, LSL #16
    SUB  X21, X6, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X28, #0x676, LSL #0
    MOVK  X28, #0x17b7, LSL #16
    SUB  X8, X28, X8
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP02_TestFail
    MOVZ  X25, #0x3939, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X19, X25, X9
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X10, #0xf950, LSL #0
    MOVK  X10, #0xf4bf, LSL #16
    SUB  X25, X10, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x9de0, LSL #0
    MOVK  X29, #0x9ca6, LSL #16
    MOVK  X29, #0x27, LSL #32
    SUB  X17, X29, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x82c, LSL #0
    SUB  X16, X6, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X9, #0xade7, LSL #0
    MOVK  X9, #0xfff2, LSL #16
    SUB  X17, X9, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xbfff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X13, X6, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X10, #0xfada, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X3, X10, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X19, X26, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X8, #0x293a, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X16, X8, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X19, X8, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X11, #0x676, LSL #0
    MOVK  X11, #0x17b7, LSL #16
    SUB  X20, X11, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP02_TestFail
    MOVZ  X14, #0x9de0, LSL #0
    MOVK  X14, #0x9ca6, LSL #16
    MOVK  X14, #0x27, LSL #32
    SUB  X3, X14, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X22, #0xa, LSL #0
TaishanIntAluP02_label_111:
    ADD  X18, X23, X18, LSR #44
    CSINC  X10, X13, X28, GT
    ASRV  W21, W19, W16
    CSNEG  X8, X16, X19, AL
    SBFM  X15, X19, #0x19, #0x9
    BICS  X21, X27, X3, LSR #49
    CLZ  V15.4S, V0.4S
    LSRV  X8, X11, X17
    CSEL  X27, X26, X8, VC
    CRC32CB  W2, W18, W26
    MOVN  X21, #0x7990, LSL #48
    LSRV  W29, W8, W17
    MOVK  W28, #0x9eaf, LSL #16
    UMADDL  X15, W26, W17, X15
    ADDS  X15, X10, W21, SXTB #3
    EOR  X25, X12, X14, LSL #2
    CLZ  W28, W20
    CRC32CB  W11, W10, W27
    CRC32B  W19, W28, W2
    ORR  X14, X4, X10, ROR #6
    SUBS  W20, W13, W15, LSL #30
    ORR  X23, X5, X9, ROR #54
    ADD  X27, X9, #0x989, LSL #12
    UMULH  X20, X8, X2
    ADCS  W23, W4, W25
    ADD  W29, W22, W8, LSR #20
    CSINC  W28, W14, W18, VC
    EOR  W3, W27, W19, ROR #3
    ADD  W12, W8, W27, LSR #20
    ADD  W19, W25, W18, LSL #19
    CSINV  X21, X18, X8, VS
    ADDS  W9, W9, W7, LSL #8
    CSEL  W11, W12, W10, VS
    SUBS  W6, W27, #0x8ea
    CLS  X7, X6
    MOVN  W12, #0xfac0, LSL #16
    LSRV  X11, X29, X23
    MOVN  X20, #0xdb4f, LSL #0
    MOVZ  X17, #0xc57a, LSL #0
    ADD  X17, X17, #0x3de
    MOVZ  X2, #0xc371, LSL #0
    ORR  W8, W21, W12, ROR #4
    ADDS  W8, W3, W4, SXTB #4
    SUBS  W25, W22, W8, SXTH #4
    ANDS  X2, X17, X10, ROR #23
    ORR  V1.4H, #0x6b, LSL #8
    BICS  W7, W12, W23, ROR #2
    SUB  X7, X5, #0xbe7, LSL #12
    CLS  W8, W29
    CLS  X20, X15
    SUBS  X9, X12, #0xaf9, LSL #12
    CSINC  X9, X20, X2, GT
    LSLV  W25, W25, W27
    CSINV  X26, X13, X26, NV
    CLZ  V9.2S, V18.2S
    CLS  V19.4H, V13.4H
    ADD  W10, W25, W18, UXTB #1
    ADD  X7, X29, X4, LSL #2
    ADD  X4, X22, #0x230
    CRC32CX  W21, W7, X5
    CLZ  V17.4H, V12.4H
    EOR  X29, X14, #0x1fffc0001fffc0
    CLS  X8, X29
    CLZ  V8.2S, V23.2S
    EOR  X12, X7, #0xfffffffffff80fff
    CSNEG  W2, W22, W14, VC
    MOVK  X20, #0xad1b, LSL #16
    EOR  W25, W25, #0xf3ffffff
    ADDS  W20, W13, #0xda0
    SUB  X5, X14, X12, ASR #50
    CLS  X4, X18
    CRC32H  W26, W4, W10
    AND  W17, W20, #0xfe0000
    CRC32B  W17, W4, W4
    CLZ  W26, W27
    ADDS  W8, W7, W12, LSR #29
    SUBS  W10, W29, W9, ASR #13
    ADCS  X27, X21, X5
    ORN  W26, W13, W3, LSL #12
    ADD  X27, X10, X25, UXTX #1
    UBFM  W4, W18, #0xe, #0x1a
    LSLV  X18, X23, X21
    BIC  V1.8B, V17.8B, V16.8B
    AND  X23, X20, #0xf9fffffff9ffffff
    CRC32W  W21, W28, W25
    EXTR  X4, X10, X16, #0xa
    CSINC  W7, W9, W28, CS
    CSEL  W26, W10, W29, GE
    ADCS  X28, X17, X23
    ANDS  W13, W18, W22, LSR #16
    CRC32W  W16, W7, W13
    SUBS  X8, X17, X19, ASR #32
    ANDS  W19, W26, W3, LSL #4
    LSRV  X28, X27, X12
    CLS  X15, X8
    SUBS  W25, W6, W21, ASR #15
    SUB  X2, X28, X14, LSL #47
    CSINV  W8, W29, W14, GE
    CRC32CX  W16, W27, X11
    SUBS  W11, W19, W6, LSL #8
    ORR  W25, W21, #0xf87fffff
    ADD  X5, X9, X2, LSR #8
    ADC  W20, W21, W7
    CSINV  W23, W6, W21, EQ
    SUBS  W28, W22, #0x19c
    SUBS  X27, X11, #0xbb5, LSL #12
    CSEL  W4, W14, W4, CS
    ANDS  X23, X11, X25, ROR #60
    SUBS  W5, W15, W25, UXTX #1
    CSINV  X3, X11, X19, LE
    EON  W28, W8, W26, ASR #14
    SUBS  X28, X19, #0x163, LSL #12
    EOR  W23, W28, #0xfe000fff
    SUB  W6, W5, W16, LSL #25
    MOVZ  W23, #0xd6e1, LSL #0
    ORN  X4, X18, X16, ROR #30
    CRC32W  W29, W7, W27
    LSRV  W7, W9, W26
    ORR  V6.8H, #0x33, LSL #8
    AND  X4, X10, #0x7ffffe000000
    UMULH  X27, X4, X19
    ANDS  W3, W22, #0xc000c
    SUBS  X4, X5, #0xad0
    AND  W5, W19, W22, ASR #4
    ADD  X25, X3, X6, LSL #16
    ADDS  X11, X3, W18, SXTW #2
    ANDS  W3, W17, #0x3fff0000
    ADDS  X28, X21, #0x873
    LSLV  X23, X28, X18
    EXTR  X15, X2, X8, #0x31
    ORR  X13, X25, #0x1fffffffffc0
    EON  X7, X23, X17, ASR #11
    BIC  V28.8B, V15.8B, V10.8B
    MOVZ  X9, #0xeca0, LSL #0
    BIC  V1.16B, V13.16B, V15.16B
    ANDS  X16, X2, #0x303030303030303
    ADDS  X9, X2, #0x3a0
    ASRV  W10, W10, W21
    BICS  W26, W19, W2, ROR #29
    EOR  W23, W16, #0xf000001f
    SUBS  W23, W28, #0x28d, LSL #12
    CSINC  X26, X3, X3, EQ
    UBFM  X6, X13, #0x18, #0x20
    BIC  W6, W22, W11, ASR #8
    SUB  X5, X10, W14, SXTH #1
    MOVN  X25, #0x8129, LSL #48
    ADD  W17, W15, W17, SXTB #1
    AND  X3, X5, #0xffffe001ffffe001
    CRC32X  W3, W10, X9
    ADCS  X3, X3, X21
    ORR  W10, W3, #0x18001800
    AND  X10, X7, X6, ROR #39
    LSLV  W8, W10, W7
    CLS  X6, X17
    ADCS  X6, X6, X23
    ADC  W8, W28, W6
    SUBS  X8, X15, X8, UXTX #4
    SUB  W14, W15, #0x87, LSL #12
    ORR  X3, X10, #0x8fff8fff8fff8fff
    EOR  X23, X25, #0xe0e0e0e0e0e0e0e
    AND  W21, W23, W26, ROR #0
    SMULH  X8, X23, X3
    LSRV  X14, X11, X25
    BIC  V11.8B, V0.8B, V4.8B
    SUB  X21, X14, W14, UXTH #3
    UMADDL  X2, W26, W26, X4
    MOVK  W9, #0x939e, LSL #16
    ADD  W12, W2, #0x5dd
    LSLV  W9, W26, W3
    EOR  W18, W23, W28, LSL #18
    UMSUBL  X28, W9, W22, X9
    MOVK  W3, #0x1d97, LSL #0
    CSNEG  X5, X20, X10, VC
    AND  W23, W27, #0x80078007
    CSINV  X9, X16, X6, EQ
    ADDS  X9, X14, #0xe20
    LSRV  W29, W26, W25
    MADD  X9, X18, X14, X29
    AND  X6, X12, X14, LSL #17
    MADD  X12, X10, X5, X15
    BICS  X5, X3, X14, LSR #8
    SUBS  W27, W8, W5, LSL #8
    LSLV  X15, X9, X22
    SUB  W12, W6, W22, UXTB #3
    SUBS  X13, X13, #0xf07, LSL #12
    CRC32H  W9, W13, W29
    CSNEG  X29, X4, X21, LS
    ADD  W13, W9, W11, ASR #15
    CLZ  V20.4S, V7.4S
    ASRV  X14, X8, X9
    EXTR  W28, W10, W14, #0xa
    CRC32B  W8, W9, W18
    AND  W3, W13, W14, ROR #5
    EON  W7, W9, W18, LSL #19
    CLS  X6, X23
    BICS  X3, X3, X21, LSL #57
    SUBS  X5, X7, X27, LSR #55
    EXTR  X27, X8, X8, #0x23
    SUBS  W6, W7, #0x160
    ADD  W26, W15, W27, LSR #3
    SUBS  X22, X22, #0x1
    B.NE  TaishanIntAluP02_label_111
    MOVZ  X11, #0xf572, LSL #0
    MOVK  X11, #0x1ff, LSL #16
    SUB  X14, X11, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X18, #0xb670, LSL #0
    MOVK  X18, #0x6fd, LSL #16
    SUB  X11, X18, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X26, #0xf571, LSL #0
    MOVK  X26, #0x1ff, LSL #16
    SUB  X13, X26, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x490f, LSL #0
    MOVK  X6, #0xc68a, LSL #16
    SUB  X3, X6, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X4, #0x490f, LSL #0
    MOVK  X4, #0xc68a, LSL #16
    SUB  X19, X4, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X18, #0x490f, LSL #0
    MOVK  X18, #0xc68a, LSL #16
    SUB  X27, X18, X7
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X4, #0xcd20, LSL #0
    MOVK  X4, #0x77b1, LSL #16
    SUB  X8, X4, X8
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP02_TestFail
    MOVZ  X7, #0xb6f0, LSL #0
    MOVK  X7, #0xb6fd, LSL #16
    SUB  X18, X7, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP02_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X19, X7, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X5, #0xfff8, LSL #0
    MOVK  X5, #0xffff, LSL #16
    SUB  X25, X5, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X15
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP02_TestFail
    MOVZ  X29, #0xa1ec, LSL #0
    MOVK  X29, #0x42e3, LSL #16
    SUB  X7, X29, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X21
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP02_TestFail
    MOVZ  X13, #0xf571, LSL #0
    MOVK  X13, #0x1ff, LSL #16
    SUB  X5, X13, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X10, X13, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X8, #0xa1ec, LSL #0
    MOVK  X8, #0x42e3, LSL #16
    SUB  X12, X8, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP02_TestFail
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
TaishanIntAluP02_label_139:
    ANDS  W11, W16, W20, ROR #5
    ADD  W13, W3, W27, ASR #22
    AND  X19, X19, X12, ASR #10
    SUBS  X18, X21, X14, ASR #19
    MOVZ  W12, #0x6e9c, LSL #0
    CSNEG  X20, X21, X29, GE
    ORR  X5, X22, X16, ROR #25
    ADD  X12, X21, #0x81
    UMADDL  X4, W26, W10, X3
    SUBS  W27, W8, W12, UXTX #3
    BICS  W23, W8, W20, LSL #14
    ORR  V9.4S, #0x6b, LSL #8
    ANDS  X15, X25, #0x3fff80003fff8
    ORN  W5, W23, W27, ROR #26
    LSLV  W28, W17, W16
    CRC32CX  W22, W3, X13
    ADC  W23, W4, W12
    CRC32H  W18, W10, W28
    SUB  X22, X29, W29, SXTH #0
    EOR  X11, X8, X22, LSL #14
    SMULH  X9, X19, X9
    EXTR  W22, W29, W16, #0x11
    CRC32CH  W21, W19, W16
    SUBS  W29, W19, W9, UXTX #0
    CSEL  X13, X11, X4, LE
    EON  W25, W8, W25, ROR #5
    CSINC  W14, W15, W16, LS
    ADDS  X3, X12, W2, UXTH #3
    ADD  X28, X29, #0x405
    SBFM  W22, W17, #0x8, #0xf
    CLZ  W28, W17
    EOR  X23, X3, X27, LSL #50
    CSINV  X29, X7, X15, EQ
    ADDS  X15, X13, W8, SXTW #0
    CSINV  W3, W2, W25, LT
    UBFM  W16, W29, #0x19, #0x11
    ASRV  X13, X4, X26
    ADC  X12, X26, X20
    EOR  W27, W12, W10, ROR #8
    ORR  V25.2S, #0xf6, LSL #24
    EOR  X22, X11, #0xfffffffc0
    ORN  W28, W25, W3, ASR #3
    UMADDL  X18, W15, W9, X14
    BIC  X5, X6, X16, ROR #50
    LSLV  X21, X12, X2
    LSLV  W17, W3, W21
    UBFM  X12, X17, #0x39, #0x32
    SBFM  W10, W29, #0xa, #0x1b
    SUBS  W27, W27, W9, LSL #9
    SUB  X15, X7, X16, UXTX #1
    ADCS  W14, W13, W11
    ADDS  W9, W22, W8, UXTX #1
    SUBS  X22, X11, #0x64a, LSL #12
    CSEL  X5, X11, X29, LE
    SUB  W14, W14, #0xbd0
    BIC  X27, X15, X18, ROR #58
    AND  W12, W7, #0x1e000000
    CSEL  W8, W25, W10, PL
    SMULH  X28, X16, X10
    CRC32CW  W25, W27, W8
    UMSUBL  X9, W28, W17, X20
    AND  W22, W25, #0xff07ff07
    SMULH  X21, X12, X12
    ASRV  X29, X15, X7
    AND  W27, W22, #0xf87fffff
    LSLV  X10, X4, X13
    EOR  X23, X26, X22, LSR #60
    ORR  V4.16B, V2.16B, V19.16B
    ADD  W29, W18, W10, SXTB #1
    ADD  W7, W11, W11, ASR #7
    SUBS  X15, X11, X15, ASR #50
    SUB  W9, W3, W13, UXTH #1
    AND  W27, W12, #0xfc00fc00
    BIC  X14, X5, X20, ROR #1
    CLS  W17, W15
    CSEL  W3, W18, W19, LS
    ADDS  W26, W5, W25, UXTB #3
    EON  X7, X4, X26, LSR #50
    CRC32CX  W9, W26, X15
    MOVK  X9, #0x4d3a, LSL #16
    LSRV  X17, X11, X29
    ORN  W28, W3, W22, ASR #30
    SMSUBL  X13, W21, W12, X23
    CLZ  W7, W21
    ADC  X29, X27, X8
    ADCS  X18, X29, X20
    ADCS  W19, W11, W12
    SUB  W27, W2, #0x742, LSL #12
    ADDS  W10, W18, W14, LSL #8
    CLZ  V16.4H, V11.4H
    CRC32H  W10, W3, W5
    ORR  V22.2S, #0xbc, LSL #24
    ASRV  X3, X28, X20
    ADDS  X8, X28, #0xb12
    LSLV  X10, X3, X13
    EXTR  W27, W6, W9, #0xb
    SUBS  W19, W6, #0x1d7, LSL #12
    UMSUBL  X20, W6, W26, X20
    CSEL  X7, X14, X20, NV
    CSINC  X19, X18, X20, LE
    UMULH  X29, X26, X3
    SUB  W14, W11, W18, UXTB #3
    ADDS  X7, X4, #0x500
    EON  X2, X25, X2, LSR #50
    EOR  X26, X20, X28, LSL #44
    AND  X17, X21, X2, LSR #4
    SUB  X17, X16, X25, LSR #58
    SUB  W13, W23, W9, UXTH #2
    CLZ  V15.4H, V20.4H
    LSRV  W10, W26, W13
    MOVK  W5, #0xb4cc, LSL #0
    LSRV  X23, X28, X26
    SUB  X8, X7, W15, UXTB #4
    ADD  W20, W15, W28, SXTB #1
    CRC32CH  W20, W20, W3
    SUB  W21, W20, W16, LSR #29
    SUB  W3, W2, W16, SXTB #1
    CSEL  W9, W7, W23, AL
    CRC32X  W19, W16, X29
    SBFM  X4, X28, #0x13, #0x1
    ANDS  W10, W27, #0xffffff81
    ADD  X3, X26, W20, UXTH #4
    SUBS  W21, W28, W13, UXTX #3
    ADDS  W15, W5, W12, UXTX #0
    EON  X10, X21, X18, LSR #42
    SBFM  W29, W12, #0x1f, #0x6
    LSLV  X16, X20, X28
    MOVZ  X10, #0x10fe, LSL #48
    ANDS  W2, W9, #0xfffff000
    CRC32CX  W8, W18, X18
    SUB  X22, X25, #0x75b
    ANDS  W25, W21, W17, LSL #29
    ORR  W19, W4, W19, ROR #2
    EON  W12, W17, W22, LSR #23
    SBFM  W13, W3, #0x1e, #0x7
    ORN  W23, W4, W7, ASR #16
    ADDS  X23, X3, W18, SXTB #0
    EOR  X3, X9, #0x7800000000
    UMULH  X25, X16, X23
    LSRV  X2, X29, X17
    AND  W23, W29, W9, ASR #29
    MOVZ  W19, #0xae06, LSL #16
    MOVK  X8, #0xed8d, LSL #32
    CSINV  W26, W29, W8, VC
    SMSUBL  X13, W12, W29, X7
    EXTR  X29, X21, X20, #0x6
    ANDS  W11, W4, #0x1800180
    SUBS  W9, W5, W22, LSR #9
    ADD  X13, X14, W28, UXTB #4
    MOVK  X9, #0xd664, LSL #48
    MOVK  W26, #0xcdf6, LSL #0
    CRC32B  W23, W15, W21
    ORN  W13, W19, W29, ROR #28
    ANDS  X2, X23, X29, LSR #44
    SUBS  X19, X26, #0x51d, LSL #12
    SUB  W11, W18, W21, SXTX #2
    ORR  V26.8B, V18.8B, V15.8B
    CSINV  X9, X19, X29, EQ
    ANDS  W8, W3, W19, ASR #10
    UBFM  W13, W7, #0xc, #0x1e
    CLZ  W15, W2
    ORR  V5.4H, #0x12
    CLZ  V4.4H, V5.4H
    SMULH  X2, X12, X21
    SBFM  X2, X18, #0x2d, #0x1
    SUB  W8, W20, W9, SXTB #3
    SUB  W25, W23, W6, SXTB #0
    ORR  V15.8H, #0x92
    LSRV  W17, W11, W15
    EOR  X11, X23, #0x7ffc00007ffc00
    ASRV  X12, X15, X20
    EOR  X2, X12, #0xeeeeeeeeeeeeeeee
    BIC  V14.8B, V4.8B, V24.8B
    ADD  X26, X12, W17, SXTW #3
    EON  X20, X11, X21, ASR #53
    CSINV  X8, X6, X20, CS
    AND  X22, X8, #0x3fffc000000
    ORR  V0.8B, V21.8B, V31.8B
    MOVK  W4, #0x5afb, LSL #0
    LSLV  W28, W10, W7
    ADDS  W9, W13, #0xfd1, LSL #12
    SUB  W19, W23, W8, UXTH #4
    EOR  W25, W18, W10, ASR #26
    UBFM  X27, X3, #0x17, #0x12
    SUB  W23, W28, #0x505, LSL #12
    ORN  X9, X23, X10, LSL #44
    ADDS  W9, W13, #0x72
    SMADDL  X14, W10, W18, X16
    ADD  W17, W17, #0x1d3, LSL #12
    CSNEG  W5, W12, W5, NV
    ANDS  X18, X26, X27, LSL #54
    SMADDL  X9, W3, W2, X3
    ADCS  X18, X15, X18
    LSRV  X15, X27, X7
    AND  X12, X12, #0xfc1fffffffffffff
    ORN  W17, W17, W2, ROR #1
    EOR  X28, X14, X4, ROR #47
    ORR  X23, X28, X20, LSR #34
    ORR  X8, X12, #0x6000000060000
    CLS  V8.2S, V2.2S
    SUBS  X6, X6, #0x1
    B.NE  TaishanIntAluP02_label_139
    MOVZ  X8, #0xeeee, LSL #0
    MOVK  X8, #0xeeee, LSL #16
    MOVK  X8, #0xeeee, LSL #32
    MOVK  X8, #0xeeee, LSL #48
    SUB  X22, X8, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X20, #0x3200, LSL #0
    MOVK  X20, #0x78, LSL #32
    SUB  X23, X20, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X7, #0x5afb, LSL #0
    SUB  X10, X7, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X26, X16, X5
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X10, #0x5afb, LSL #0
    SUB  X15, X10, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP02_TestFail
    MOVZ  X20, #0xeeee, LSL #0
    MOVK  X20, #0xeeee, LSL #16
    MOVK  X20, #0xeeee, LSL #32
    MOVK  X20, #0xeeee, LSL #48
    SUB  X16, X20, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X4, #0xae00, LSL #0
    MOVK  X4, #0xaaaa, LSL #16
    MOVK  X4, #0xfd22, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X29, X4, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP02_TestFail
    MOVZ  X26, #0x5afb, LSL #0
    SUB  X28, X26, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x61a2, LSL #0
    MOVK  X29, #0xbf50, LSL #16
    MOVK  X29, #0xfc00, LSL #32
    MOVK  X29, #0x7f, LSL #48
    SUB  X15, X29, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X3, X20, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X21, #0x3, LSL #0
    SUB  X29, X21, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X28, #0xefec, LSL #0
    MOVK  X28, #0x88af, LSL #16
    SUB  X4, X28, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X14, #0xc, LSL #0
    SUB  X19, X14, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X19
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X4, #0x3, LSL #0
    SUB  X19, X4, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP02_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP02_TestFail
    MOVZ  X19, #0x2c4e, LSL #0
    MOVK  X19, #0xac09, LSL #16
    SUB  X6, X19, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x64, LSL #48
    SUB  X9, X29, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X21, X11, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x64, LSL #48
    SUB  X18, X6, X29
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x68d0, LSL #0
    MOVK  X2, #0xccea, LSL #16
    MOVK  X2, #0xb963, LSL #32
    MOVK  X2, #0xd21d, LSL #48
    MOVZ  X3, #0xdfb7, LSL #0
    MOVK  X3, #0x142b, LSL #16
    MOVK  X3, #0x6bd, LSL #32
    MOVK  X3, #0x75ed, LSL #48
    MOVZ  X4, #0x9a3d, LSL #0
    MOVK  X4, #0x6d38, LSL #16
    MOVK  X4, #0xee42, LSL #32
    MOVK  X4, #0x16c2, LSL #48
    MOVZ  X5, #0xb0a7, LSL #0
    MOVK  X5, #0xafa1, LSL #16
    MOVK  X5, #0x8fe9, LSL #32
    MOVK  X5, #0xbedd, LSL #48
    MOVZ  X6, #0xcfc7, LSL #0
    MOVK  X6, #0xf8b2, LSL #16
    MOVK  X6, #0x88bb, LSL #32
    MOVK  X6, #0xc26a, LSL #48
    MOVZ  X7, #0x58a5, LSL #0
    MOVK  X7, #0x9c63, LSL #16
    MOVK  X7, #0xc989, LSL #32
    MOVK  X7, #0xb8f, LSL #48
    MOVZ  X8, #0x349a, LSL #0
    MOVK  X8, #0xe8f2, LSL #16
    MOVK  X8, #0x3316, LSL #32
    MOVK  X8, #0x2204, LSL #48
    MOVZ  X9, #0x4b84, LSL #0
    MOVK  X9, #0xcf90, LSL #16
    MOVK  X9, #0xde15, LSL #32
    MOVK  X9, #0x188e, LSL #48
    MOVZ  X10, #0x86f9, LSL #0
    MOVK  X10, #0xbc7f, LSL #16
    MOVK  X10, #0x3ec0, LSL #32
    MOVK  X10, #0xdacf, LSL #48
    MOVZ  X11, #0xbb9c, LSL #0
    MOVK  X11, #0x1658, LSL #16
    MOVK  X11, #0x437, LSL #32
    MOVK  X11, #0xda35, LSL #48
    MOVZ  X12, #0x7eb7, LSL #0
    MOVK  X12, #0x9f89, LSL #16
    MOVK  X12, #0x7c2f, LSL #32
    MOVK  X12, #0x50e0, LSL #48
    MOVZ  X13, #0x7f19, LSL #0
    MOVK  X13, #0x55, LSL #16
    MOVK  X13, #0xff, LSL #32
    MOVK  X13, #0x9d2, LSL #48
    MOVZ  X14, #0xd22c, LSL #0
    MOVK  X14, #0xac79, LSL #16
    MOVK  X14, #0xb86a, LSL #32
    MOVK  X14, #0xf95e, LSL #48
    MOVZ  X15, #0xf85f, LSL #0
    MOVK  X15, #0x697f, LSL #16
    MOVK  X15, #0xdd45, LSL #32
    MOVK  X15, #0x20dd, LSL #48
    MOVZ  X16, #0x2933, LSL #0
    MOVK  X16, #0x29e9, LSL #16
    MOVK  X16, #0xc8c1, LSL #32
    MOVK  X16, #0x6aa7, LSL #48
    MOVZ  X17, #0xebf9, LSL #0
    MOVK  X17, #0xb5d, LSL #16
    MOVK  X17, #0x1f2d, LSL #32
    MOVK  X17, #0xb094, LSL #48
    MOVZ  X18, #0x1930, LSL #0
    MOVK  X18, #0x9a60, LSL #16
    MOVK  X18, #0x93cc, LSL #32
    MOVK  X18, #0xc730, LSL #48
    MOVZ  X19, #0xc24e, LSL #0
    MOVK  X19, #0x77de, LSL #16
    MOVK  X19, #0x9235, LSL #32
    MOVK  X19, #0x9e3c, LSL #48
    MOVZ  X20, #0xf27a, LSL #0
    MOVK  X20, #0x9d0a, LSL #16
    MOVK  X20, #0x280a, LSL #32
    MOVK  X20, #0x9e8a, LSL #48
    MOVZ  X21, #0xa188, LSL #0
    MOVK  X21, #0x3f15, LSL #16
    MOVK  X21, #0x84b, LSL #32
    MOVK  X21, #0xd52c, LSL #48
    MOVZ  X22, #0x4cdb, LSL #0
    MOVK  X22, #0x174a, LSL #16
    MOVK  X22, #0xc39f, LSL #32
    MOVK  X22, #0x994c, LSL #48
    MOVZ  X23, #0x1fd0, LSL #0
    MOVK  X23, #0xe2b6, LSL #16
    MOVK  X23, #0x219, LSL #32
    MOVK  X23, #0xc64c, LSL #48
    MOVZ  X25, #0x135a, LSL #0
    MOVK  X25, #0x454d, LSL #16
    MOVK  X25, #0x1545, LSL #32
    MOVK  X25, #0xe09b, LSL #48
    MOVZ  X26, #0x73bf, LSL #0
    MOVK  X26, #0x818, LSL #16
    MOVK  X26, #0x15e7, LSL #32
    MOVK  X26, #0x7661, LSL #48
    MOVZ  X27, #0xbe4e, LSL #0
    MOVK  X27, #0x400d, LSL #16
    MOVK  X27, #0xa570, LSL #32
    MOVK  X27, #0xf456, LSL #48
    MOVZ  X28, #0x8b58, LSL #0
    MOVK  X28, #0xd7a0, LSL #16
    MOVK  X28, #0x7c53, LSL #32
    MOVK  X28, #0xd5e4, LSL #48
    MOVZ  X29, #0xa2b, LSL #0
    MOVK  X29, #0x7264, LSL #16
    MOVK  X29, #0xcef4, LSL #32
    MOVK  X29, #0x96bb, LSL #48
    MOVZ  X4, #0xa, LSL #0
TaishanIntAluP02_label_167:
    ASRV  X28, X27, X22
    UMULH  X11, X3, X5
    SUB  W26, W25, W9, SXTX #3
    BICS  W21, W13, W17, ASR #18
    EOR  W22, W18, W23, ASR #11
    SUBS  X5, X3, #0xb66, LSL #12
    ORR  W12, W10, #0x30000000
    UMULH  X7, X13, X25
    MADD  W10, W13, W22, W11
    SUB  W5, W27, W28, ASR #7
    CSINV  W14, W22, W23, LE
    SMADDL  X10, W25, W27, X14
    CSNEG  W26, W11, W11, HI
    SUB  X6, X23, #0x475
    SUB  W20, W7, W13, ASR #25
    CRC32B  W23, W11, W7
    CLZ  V31.16B, V28.16B
    SMSUBL  X22, W10, W21, X16
    CLZ  X9, X19
    SUB  W28, W26, W18, UXTW #3
    MADD  X23, X16, X21, X10
    CRC32B  W5, W7, W4
    SBFM  W27, W15, #0x17, #0xe
    ADD  X20, X26, X26, LSL #62
    ADC  W21, W14, W20
    ORR  X28, X6, #0x1ff800000000000
    CLZ  W2, W3
    CRC32B  W15, W2, W7
    CRC32W  W9, W22, W27
    BIC  V25.8B, V6.8B, V7.8B
    ORR  V15.4H, #0x4e, LSL #8
    ORR  W9, W21, #0x7f807f8
    SUB  W20, W14, W7, SXTH #4
    CLZ  W20, W12
    ADC  X20, X9, X15
    CRC32CW  W21, W17, W4
    ADD  X2, X16, X19, LSL #52
    SUBS  W6, W3, #0x680
    CRC32X  W26, W25, X5
    ORR  X13, X2, #0xc000c000c000c000
    LSLV  X16, X9, X6
    SUBS  W25, W19, W8, SXTX #0
    CSNEG  X28, X23, X15, VS
    ADD  W14, W5, W19, LSL #13
    LSRV  W10, W21, W2
    ORR  V25.4S, #0x7b
    ADDS  W26, W13, W26, ASR #15
    EON  W26, W2, W13, ROR #4
    ADD  X16, X7, X8, LSR #18
    LSRV  W14, W13, W19
    MOVN  W9, #0xaad8, LSL #16
    CSNEG  X6, X9, X10, VC
    BICS  X25, X14, X13, LSR #22
    ADD  X15, X13, X12, LSL #13
    CRC32W  W15, W3, W22
    EOR  W15, W21, W10, LSR #1
    MADD  X8, X10, X2, X17
    ADC  W26, W5, W27
    CSNEG  X27, X3, X16, VC
    MOVN  X14, #0x976, LSL #32
    ORR  V2.8B, V13.8B, V19.8B
    ORR  W8, W6, W28, ROR #31
    SUBS  X8, X7, X12, ASR #0
    ADDS  W22, W26, W25, LSL #28
    UMULH  X6, X8, X8
    MOVN  X12, #0xc85e, LSL #0
    ADDS  X13, X7, X12, LSL #35
    AND  X29, X15, #0x7fc0000000000
    ORR  W3, W27, W23, LSR #23
    CRC32CB  W15, W11, W28
    EXTR  W2, W28, W14, #0x10
    ADDS  W21, W11, W19, SXTH #2
    SMSUBL  X26, W5, W17, X20
    SBFM  W28, W11, #0x14, #0x1b
    SBFM  W9, W21, #0x14, #0x4
    ADDS  W22, W5, #0xda0
    ORN  X18, X28, X21, LSL #8
    CSINV  W28, W25, W16, PL
    ANDS  X19, X9, #0x7f0000000000000
    ADD  W21, W5, #0x2a4, LSL #12
    MOVK  W2, #0x69e1, LSL #16
    LSRV  W23, W16, W19
    CSINV  W23, W7, W25, CS
    ADDS  X27, X26, #0x4b, LSL #12
    ADD  W2, W22, W2, ASR #12
    SUBS  X22, X20, X15, UXTX #1
    BIC  W17, W18, W27, LSL #12
    CSEL  W2, W6, W26, VS
    EXTR  W23, W26, W19, #0xb
    SUB  W8, W11, W11, UXTB #0
    CSINV  X15, X6, X3, NV
    ADCS  X16, X28, X21
    SUBS  W29, W17, #0xdb0
    CSINC  X20, X27, X12, CS
    EOR  X23, X5, #0x1f0000001f0
    ANDS  X19, X25, X26, ROR #59
    ASRV  X20, X7, X14
    EOR  W12, W2, #0x55555555
    ADD  W26, W22, W19, SXTH #1
    SUBS  X10, X4, W11, UXTW #3
    SBFM  X19, X10, #0x9, #0xd
    ASRV  W27, W13, W13
    ANDS  W22, W18, W7, LSL #15
    CLZ  X7, X5
    SBFM  X3, X7, #0x25, #0xa
    SUBS  W21, W26, W13, SXTH #1
    CRC32CB  W3, W7, W28
    AND  W14, W8, W25, LSL #27
    CRC32CW  W16, W19, W17
    ADD  X7, X22, W8, UXTW #1
    ADC  W8, W7, W12
    ANDS  X5, X10, X18, ASR #36
    EON  X16, X8, X15, ROR #49
    MOVN  X3, #0x3085, LSL #16
    UBFM  W22, W21, #0xc, #0x1b
    ORR  W6, W18, #0x87ff87ff
    ANDS  W15, W29, #0x38383838
    ADD  W22, W21, W14, UXTX #4
    EON  W3, W27, W18, LSR #1
    SUBS  X18, X3, W8, SXTW #4
    ORN  W20, W26, W27, ASR #17
    SUB  W26, W19, W19, UXTB #4
    ASRV  W16, W19, W23
    ORN  X21, X14, X21, ASR #63
    CRC32CX  W2, W13, X23
    CLZ  X7, X12
    ASRV  X18, X28, X8
    SBFM  X7, X4, #0x19, #0x0
    LSRV  W8, W9, W11
    ASRV  W8, W26, W17
    ADDS  W6, W5, W4, UXTX #2
    ORN  X2, X9, X26, ASR #50
    ANDS  X17, X19, X3, LSR #2
    LSRV  X25, X19, X26
    AND  X13, X6, X8, LSR #61
    ORR  V12.2S, #0xbb, LSL #24
    ADD  X14, X7, #0x219
    EOR  X17, X12, #0x1fffffffc0000
    CLZ  V20.4H, V17.4H
    ANDS  W27, W12, W21, LSR #30
    SUBS  W5, W28, W12, SXTW #1
    CRC32B  W13, W16, W26
    UBFM  W13, W27, #0x14, #0x19
    BICS  X7, X3, X9, ROR #39
    ADD  W22, W25, W16, UXTH #1
    BICS  W2, W19, W20, LSL #25
    CRC32W  W21, W11, W13
    CSINV  W10, W23, W11, VC
    MADD  W8, W2, W7, W22
    ADCS  X5, X16, X21
    SMULH  X6, X27, X19
    ADDS  X5, X13, X23, LSR #41
    ANDS  W14, W3, W10, LSR #31
    SUB  X3, X18, W23, UXTW #1
    CLZ  V4.8H, V9.8H
    SUB  W5, W9, #0x15, LSL #12
    EOR  X6, X3, X18, LSR #63
    CSEL  X26, X2, X7, GE
    SMADDL  X14, W23, W11, X4
    CSINV  X25, X6, X25, AL
    SUBS  W17, W16, #0x0
    ADDS  X6, X8, W14, SXTB #0
    ANDS  X22, X7, #0xff8000007fffffff
    SUBS  W14, W11, W2, LSR #13
    CLZ  W16, W14
    ADC  W25, W27, W3
    CRC32H  W28, W23, W3
    AND  W28, W25, W25, LSL #3
    CRC32CH  W17, W4, W19
    BICS  W22, W27, W22, LSL #9
    CSNEG  X15, X13, X19, CS
    ASRV  W12, W23, W5
    SUB  W7, W4, W18, SXTW #2
    UMULH  X18, X4, X26
    CRC32CW  W3, W6, W23
    LSLV  X25, X14, X2
    ADD  X12, X9, W7, SXTH #4
    CRC32B  W22, W19, W20
    ORR  V18.4S, #0xf7, LSL #24
    SUB  W23, W22, W20, LSL #13
    MOVN  X11, #0x44d9, LSL #48
    SUBS  W26, W16, #0xb31
    CLS  V12.4H, V25.4H
    ORR  V13.4S, #0xad, LSL #16
    ADD  W23, W7, #0xb21, LSL #12
    SUBS  X13, X9, W16, SXTH #0
    ADDS  X8, X6, #0xb, LSL #12
    CSINV  X18, X23, X25, HI
    UMULH  X29, X25, X2
    SMSUBL  X12, W19, W14, X10
    BIC  V7.16B, V18.16B, V25.16B
    ADD  W19, W13, W3, UXTW #2
    CRC32CH  W18, W26, W29
    CRC32B  W8, W29, W4
    EXTR  W10, W2, W29, #0xa
    SBFM  W5, W12, #0x1c, #0x16
    BIC  V15.8B, V4.8B, V15.8B
    SUB  X22, X5, W16, SXTB #2
    ADDS  X10, X2, W26, SXTW #3
    CSINC  X17, X2, X11, GT
    SUBS  X4, X4, #0x1
    B.NE  TaishanIntAluP02_label_167
    MOVZ  X19, #0x0, LSL #0
    SUB  X5, X19, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X14, #0x1ee5, LSL #0
    MOVK  X14, #0x8e1b, LSL #16
    SUB  X25, X14, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X14, X29, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x1, LSL #0
    SUB  X17, X16, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x1, LSL #0
    SUB  X12, X2, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP02_TestFail
    MOVZ  X23, #0x3096, LSL #0
    MOVK  X23, #0x7707, LSL #16
    SUB  X4, X23, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X16, X18, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X5, #0xa778, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X7, X5, X10
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP02_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xbb26, LSL #48
    SUB  X7, X16, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP02_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X25, #0xffe0, LSL #0
    MOVK  X25, #0xfffe, LSL #16
    SUB  X5, X25, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X15
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xbb26, LSL #48
    SUB  X9, X21, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X22, X17, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X25, X27, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X18, X21, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP02_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X18, X26, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x3096, LSL #0
    MOVK  X2, #0x7707, LSL #16
    SUB  X23, X2, X23
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X11, X4, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X22, X18, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x8930, LSL #0
    MOVK  X29, #0x180, LSL #16
    SUB  X22, X29, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X17, #0x8930, LSL #0
    MOVK  X17, #0x180, LSL #16
    SUB  X16, X17, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X22, #0xa, LSL #0
TaishanIntAluP02_label_195:
    ORR  V1.8H, #0x51
    EOR  W18, W25, #0x1ffff0
    ADD  X17, X10, W18, UXTW #4
    CLS  X26, X20
    ADD  X3, X7, X2, LSL #40
    BIC  W29, W29, W14, ASR #16
    ADCS  W12, W19, W18
    ADD  X8, X6, W9, UXTB #3
    CRC32CB  W23, W4, W19
    CLS  W9, W25
    LSRV  W23, W27, W16
    SUBS  W3, W9, #0x10
    SUB  X18, X20, #0x63e
    ASRV  W8, W11, W8
    ADDS  W6, W22, W28, UXTW #3
    AND  X6, X20, #0xfc000000000003ff
    BICS  W4, W5, W6, ASR #28
    BICS  X25, X10, X27, LSR #45
    MADD  W23, W11, W19, W8
    CLZ  W3, W2
    UMADDL  X7, W5, W13, X6
    LSLV  W12, W18, W4
    MOVK  X12, #0x431c, LSL #0
    EOR  W10, W15, W25, LSL #21
    EON  W26, W9, W27, LSL #31
    SUBS  W13, W25, #0xd3e, LSL #12
    ADD  X11, X7, X20, UXTX #1
    ADDS  W18, W17, W22, LSR #29
    SBFM  W15, W11, #0x10, #0x0
    SUBS  X16, X11, #0x195, LSL #12
    CLS  X12, X14
    ADD  X13, X22, X5, LSR #6
    EOR  W14, W15, W20, LSR #20
    CSINC  X26, X28, X10, AL
    ANDS  X19, X18, X3, LSR #54
    AND  W16, W25, #0xff3fffff
    MOVZ  W12, #0x3c00, LSL #0
    CRC32CX  W6, W10, X16
    AND  W12, W26, #0x20002
    ORR  X13, X17, X22, LSR #59
    SMADDL  X2, W6, W12, X13
    ADD  X23, X13, #0x2c3, LSL #12
    EOR  X23, X5, X7, ASR #19
    CRC32CB  W27, W8, W3
    MADD  X13, X23, X15, X10
    EOR  W27, W14, W23, LSL #6
    SBFM  X12, X28, #0x15, #0x16
    AND  W18, W10, #0xfffe003f
    EXTR  W2, W20, W9, #0x1e
    MOVZ  W18, #0x2ccd, LSL #0
    SUB  X3, X11, W20, UXTH #1
    EOR  W4, W16, W11, ROR #17
    EOR  X6, X5, #0xfe03fffffe03ffff
    CSEL  W25, W22, W6, PL
    ANDS  X20, X19, X13, LSR #28
    CRC32CH  W3, W14, W26
    LSRV  X26, X25, X11
    CSINC  W27, W20, W19, NE
    ORR  V13.4H, #0xbb, LSL #8
    ADD  X6, X22, X15, LSL #13
    ADCS  X13, X7, X3
    ANDS  W19, W4, #0x80038003
    ANDS  W2, W8, W4, LSL #3
    MOVN  X14, #0xff8f, LSL #16
    CLZ  W11, W26
    SMULH  X28, X14, X3
    SUBS  W7, W11, #0x42d, LSL #12
    LSLV  W4, W13, W10
    MOVN  W2, #0x5c6f, LSL #16
    AND  X21, X8, X9, LSR #14
    SUB  X18, X9, W21, UXTW #4
    MOVN  X7, #0x7b90, LSL #32
    BICS  X20, X4, X16, LSL #60
    CSINV  X23, X18, X26, NV
    ORR  V30.16B, V19.16B, V23.16B
    CSINV  W6, W5, W20, NE
    CSINV  X27, X14, X25, GE
    CLZ  V8.8H, V12.8H
    ADC  W19, W19, W27
    AND  X6, X13, #0xf800f800f800f800
    MOVZ  W18, #0x82ae, LSL #16
    ANDS  W5, W22, #0x60000
    EOR  W23, W23, W22, LSL #21
    EOR  X15, X12, X3, LSL #53
    SUB  W6, W5, W20, UXTX #0
    ADC  X19, X21, X12
    UMSUBL  X18, W2, W20, X23
    ADC  W13, W5, W9
    ADDS  X6, X9, X12, LSL #54
    MOVZ  X27, #0xb701, LSL #32
    ADDS  W17, W29, W14, ASR #26
    UMSUBL  X8, W12, W7, X17
    LSLV  X19, X22, X10
    ADCS  W20, W5, W5
    CRC32W  W28, W7, W2
    MOVK  X8, #0x2243, LSL #0
    MOVN  W3, #0xf35b, LSL #0
    MOVK  X27, #0x56b0, LSL #16
    ADD  X21, X7, W18, SXTW #3
    EXTR  W11, W7, W17, #0xa
    UMULH  X15, X11, X15
    ASRV  X3, X11, X3
    CSNEG  X3, X20, X14, GT
    SUBS  W15, W27, W28, SXTX #0
    SUBS  W5, W10, W5, UXTB #1
    ORR  W12, W2, W13, LSR #28
    CSEL  X12, X29, X4, VS
    ADDS  X19, X26, W21, SXTB #2
    ORN  W17, W19, W5, ROR #30
    UMULH  X15, X18, X29
    CSEL  W8, W2, W20, NE
    SMSUBL  X27, W5, W7, X27
    LSRV  W18, W3, W23
    ANDS  W11, W14, #0xffff800
    LSLV  X2, X21, X3
    CRC32CH  W13, W11, W21
    ADDS  X6, X13, W5, UXTW #0
    ADCS  X10, X20, X9
    MOVN  W14, #0xe4fa, LSL #0
    ADDS  X28, X16, X6, ASR #56
    CRC32W  W21, W2, W13
    ORR  X11, X11, X22, LSL #16
    AND  W4, W2, #0xfffe01ff
    LSRV  X5, X28, X3
    EON  X3, X11, X21, ASR #13
    EOR  W18, W4, W7, LSL #5
    ADD  W2, W28, W8, ASR #10
    ADD  X16, X8, W21, UXTH #3
    AND  W10, W17, #0x1ffffff0
    CSINC  X8, X23, X8, AL
    SUB  W6, W13, W6, SXTH #1
    SUBS  X2, X28, X16, ASR #32
    LSRV  W17, W18, W16
    LSRV  W5, W9, W19
    CSNEG  W25, W9, W3, VS
    CRC32B  W2, W3, W4
    AND  X15, X12, #0x3f
    CSINC  W10, W6, W5, AL
    CSINC  X5, X11, X9, PL
    MADD  W20, W7, W23, W27
    SMADDL  X3, W29, W6, X17
    ADD  X13, X21, W18, SXTH #3
    CRC32CX  W18, W10, X29
    ADCS  X13, X28, X11
    ORN  X19, X19, X29, LSR #42
    ADC  X4, X19, X4
    SMSUBL  X16, W19, W12, X19
    SUBS  X27, X7, #0xd0
    SUB  X6, X2, W21, UXTW #3
    MADD  X4, X10, X5, X26
    CSINV  X15, X26, X4, NE
    AND  X10, X7, X6, LSL #1
    ASRV  W29, W14, W4
    UBFM  W2, W16, #0x8, #0xf
    SUB  W14, W20, W12, LSR #20
    CSINC  W17, W19, W27, LS
    ORN  W19, W23, W23, LSL #19
    ORR  W17, W19, #0x3c
    LSLV  W29, W28, W3
    ADD  W15, W20, W21, LSL #9
    AND  W16, W8, W28, ROR #4
    CSINC  X12, X13, X8, LT
    ANDS  X14, X3, #0xe0ffe0ffe0ffe0ff
    MOVK  X23, #0xec21, LSL #0
    CSEL  X10, X28, X11, GT
    ORR  X20, X11, X18, LSL #13
    CLZ  V15.8B, V27.8B
    ADDS  W26, W10, W19, UXTB #2
    MOVN  W29, #0xadb8, LSL #16
    BIC  V18.8B, V2.8B, V9.8B
    ADC  X4, X13, X9
    CRC32H  W16, W14, W27
    AND  W4, W23, W10, ROR #11
    BIC  W16, W21, W7, LSR #0
    ADD  W2, W4, #0xf6a, LSL #12
    ADC  X18, X13, X23
    BICS  W3, W12, W12, LSR #22
    SUB  X3, X2, X7, LSL #8
    CRC32CX  W5, W13, X14
    SUB  W14, W19, W20, LSL #17
    ADD  X21, X22, #0xef7, LSL #12
    LSRV  W6, W20, W29
    SUBS  X26, X12, W13, SXTH #0
    ADDS  W9, W9, #0x830
    ADD  W11, W21, W18, LSL #12
    CLS  V31.4H, V22.4H
    CRC32W  W13, W10, W6
    CSEL  X4, X10, X16, NV
    ORN  W7, W8, W15, LSR #31
    SBFM  X21, X22, #0x1f, #0x23
    EXTR  X27, X4, X9, #0x2d
    ASRV  W20, W6, W11
    SUBS  X16, X11, #0xb9d, LSL #12
    CLS  X23, X15
    MOVZ  X21, #0x757e, LSL #32
    SMULH  X28, X4, X11
    ORR  V5.8B, V20.8B, V31.8B
    CSNEG  X17, X5, X2, LT
    ADD  W15, W3, #0x480
    CSNEG  X10, X9, X4, NE
    SUBS  X22, X22, #0x1
    B.NE  TaishanIntAluP02_label_195
    MOVZ  X8, #0xac21, LSL #0
    MOVK  X8, #0xf6, LSL #16
    SUB  X23, X8, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X6, #0xad21, LSL #0
    MOVK  X6, #0xf6, LSL #16
    MOVK  X6, #0x9000, LSL #32
    MOVK  X6, #0x7b, LSL #48
    SUB  X9, X6, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X6, #0xf800, LSL #0
    MOVK  X6, #0x71, LSL #16
    SUB  X27, X6, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X13, #0x7c0f, LSL #0
    MOVK  X13, #0xecb1, LSL #16
    SUB  X23, X13, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X4, #0xf800, LSL #0
    MOVK  X4, #0x71, LSL #16
    SUB  X16, X4, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X25, #0xfffe, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X15, X25, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP02_TestFail
    MOVZ  X22, #0xac21, LSL #0
    MOVK  X22, #0xf6, LSL #16
    SUB  X15, X22, X8
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X9, #0x1001, LSL #0
    MOVK  X9, #0x2fb5, LSL #16
    SUB  X2, X9, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x39, LSL #0
    MOVK  X6, #0x72, LSL #16
    SUB  X12, X6, X12
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP02_TestFail
    MOVZ  X4, #0x7c0f, LSL #0
    MOVK  X4, #0xecb1, LSL #16
    SUB  X19, X4, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xfbf, LSL #16
    SUB  X5, X6, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X27, X25, X15
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP02_TestFail
    MOVZ  X3, #0xec5a, LSL #0
    MOVK  X3, #0x92, LSL #16
    SUB  X5, X3, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X28, X4, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X27, X22, X26
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X29, X15, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
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
TaishanIntAluP02_label_222:
    MOVN  X8, #0x446f, LSL #16
    ANDS  W11, W2, #0x87878787
    ANDS  X28, X8, #0xfe07fe07fe07fe07
    ORN  W18, W19, W25, LSL #19
    CLS  W9, W29
    CRC32CW  W5, W21, W9
    ANDS  W11, W14, W15, ASR #5
    ASRV  X21, X18, X14
    SBFM  W23, W18, #0x6, #0x0
    CRC32H  W14, W23, W16
    EON  X17, X23, X29, ASR #59
    SUB  W3, W11, W22, SXTH #2
    ADC  W2, W13, W7
    CRC32CW  W25, W28, W27
    ADC  W18, W28, W5
    ANDS  X18, X14, X23, ASR #48
    EXTR  X26, X9, X8, #0x18
    ASRV  X23, X29, X14
    CLS  W7, W22
    SBFM  W11, W6, #0x12, #0xd
    SUB  W6, W17, W9, SXTX #4
    MADD  X8, X7, X3, X26
    ORR  W8, W11, #0xc0ffc0ff
    EOR  W18, W5, W18, ROR #25
    AND  W20, W17, W16, LSR #31
    ORR  W23, W15, #0xfff00fff
    UMADDL  X10, W28, W5, X8
    SUBS  X18, X20, X22, UXTX #2
    BICS  W17, W5, W26, LSR #4
    CLS  V13.4H, V30.4H
    CSINC  X22, X10, X9, NV
    ANDS  W29, W29, #0x1f1f1f1f
    CSINV  X23, X28, X8, LS
    ADDS  W6, W16, #0x22c
    MOVK  W4, #0x1fe, LSL #16
    ADDS  X14, X11, X6, LSR #25
    SMULH  X5, X29, X26
    MOVN  W16, #0x6bf, LSL #0
    CLS  W3, W26
    SUBS  W3, W28, W8, UXTW #3
    SUBS  W15, W10, #0x78c, LSL #12
    ADC  X22, X6, X18
    ORR  W15, W4, #0x7fe07fe
    ADDS  X22, X26, X7, SXTX #0
    SUBS  W14, W27, W4, UXTX #4
    EON  W23, W19, W12, LSR #24
    SUBS  W22, W17, W22, UXTB #3
    ORR  W9, W27, W14, ROR #11
    CSNEG  W16, W6, W11, GT
    SUBS  W12, W29, W25, LSL #27
    CRC32B  W15, W21, W15
    ASRV  X29, X8, X7
    ADD  X5, X28, W3, SXTW #4
    CSINC  W8, W17, W19, GT
    ADCS  W5, W23, W23
    SBFM  X7, X22, #0x1f, #0x3f
    CRC32CW  W4, W13, W10
    EOR  W22, W2, #0xe0ffe0ff
    ORR  W2, W13, #0x1c1c1c1c
    ASRV  X2, X16, X27
    CRC32CH  W9, W5, W9
    UMADDL  X10, W12, W13, X23
    MOVZ  X14, #0xbf27, LSL #32
    AND  W25, W17, #0xfefefefe
    SBFM  X19, X15, #0x2d, #0x30
    SMADDL  X22, W17, W20, X6
    CRC32CX  W15, W16, X2
    MOVK  X4, #0x8648, LSL #32
    SUB  X3, X13, W9, SXTW #2
    CRC32H  W22, W18, W16
    CSINV  X18, X17, X25, HI
    CRC32H  W14, W11, W3
    EXTR  X25, X7, X4, #0x4
    SUB  W15, W7, W20, UXTH #0
    ADD  W19, W29, W5, UXTW #0
    AND  W14, W14, #0x10101010
    EXTR  X4, X8, X8, #0x39
    EOR  X5, X11, #0xffffff07ffffffff
    MADD  X18, X20, X11, X29
    CLS  V27.4H, V28.4H
    LSLV  X29, X4, X15
    SUB  X21, X17, W10, SXTW #1
    EXTR  W12, W21, W10, #0xc
    SBFM  W22, W4, #0x1b, #0x7
    BICS  X18, X26, X20, ASR #21
    EON  X6, X11, X10, ASR #48
    EOR  W27, W9, W21, LSR #23
    ADDS  W5, W19, W10, ASR #31
    CRC32CX  W9, W8, X6
    ORR  W19, W6, W4, LSR #31
    CRC32CH  W28, W19, W27
    SMULH  X19, X12, X5
    SUBS  W21, W15, W5, ASR #11
    ORR  W5, W18, #0x81ff81ff
    ADD  X5, X11, #0xce4, LSL #12
    SUB  W25, W29, #0x0
    LSLV  W18, W9, W22
    AND  W5, W15, #0x99999999
    ADC  W10, W15, W23
    ADDS  X6, X20, X12, LSR #31
    CRC32B  W17, W29, W3
    UBFM  W11, W23, #0x16, #0xc
    MOVK  W26, #0xd43c, LSL #16
    SUBS  W12, W10, W6, LSL #11
    ADC  W9, W7, W27
    EOR  W7, W12, W19, ROR #5
    ORN  W12, W6, W8, ASR #18
    CSINC  W21, W28, W22, VS
    SUB  X21, X25, W29, UXTB #0
    EON  W5, W29, W3, ASR #10
    CRC32X  W9, W5, X6
    EOR  X5, X16, #0xffffe000ffffe00
    UBFM  W6, W5, #0x7, #0xe
    ADDS  W21, W11, #0xa2a
    CLS  V2.4S, V23.4S
    EON  X5, X4, X5, LSL #18
    EON  X11, X5, X17, LSL #45
    CLZ  W12, W7
    ADD  X9, X26, #0x71e
    MADD  W23, W27, W9, W9
    CSNEG  W9, W16, W21, GE
    CRC32CX  W6, W7, X14
    CSINV  X3, X2, X29, CS
    SUB  W14, W19, W6, ASR #17
    ORN  W18, W22, W10, LSR #20
    SBFM  X17, X2, #0x3b, #0x37
    ORR  V2.4S, #0xa
    SUB  W16, W4, W11, LSL #27
    CRC32CX  W15, W29, X11
    AND  W10, W23, #0xffc0003f
    MOVK  X20, #0x58b8, LSL #48
    ORR  X20, X23, X23, ASR #21
    MADD  W3, W19, W26, W19
    MOVK  W21, #0x25f7, LSL #16
    ADDS  X22, X11, X16, ASR #18
    ADD  W14, W25, #0x52c
    SUBS  X4, X26, W10, SXTW #0
    EOR  W15, W6, W29, ASR #5
    AND  X23, X8, #0x7ff000007ff
    SUB  X20, X6, W16, UXTB #0
    LSLV  X27, X7, X17
    CLS  V4.4S, V17.4S
    EOR  W21, W23, #0x1fffe0
    MOVK  X14, #0x5ef6, LSL #32
    UMADDL  X20, W2, W9, X18
    ADD  X23, X29, X8, ASR #8
    EON  X8, X14, X20, LSR #59
    LSRV  X23, X3, X12
    ORN  W20, W2, W2, ASR #6
    ADD  W19, W4, W27, UXTX #4
    SUB  X10, X25, #0x11b, LSL #12
    EXTR  W20, W6, W18, #0x17
    ORR  V9.2S, #0xf5, LSL #8
    ADD  X22, X11, #0x8a3
    ADD  W20, W3, W15, LSL #23
    ADDS  X6, X25, W21, SXTW #2
    ASRV  X19, X17, X10
    CLZ  V21.8B, V21.8B
    AND  X16, X28, X28, LSR #19
    ADD  X9, X16, #0x2f9, LSL #12
    BICS  X9, X10, X11, LSR #37
    SUB  X6, X29, #0xbae, LSL #12
    ADCS  W29, W19, W5
    BIC  V5.8B, V5.8B, V15.8B
    ORR  V25.16B, V31.16B, V21.16B
    SUB  X5, X8, #0x73f, LSL #12
    CLZ  X18, X5
    ORN  W25, W18, W12, LSR #31
    LSLV  W16, W11, W19
    MADD  W28, W16, W5, W11
    SMADDL  X9, W15, W28, X28
    CRC32B  W12, W29, W22
    UMADDL  X19, W19, W4, X29
    ORR  X29, X5, #0x3c003c003c003c
    EON  W15, W10, W12, LSR #29
    EON  X6, X29, X18, LSR #57
    SUB  X4, X28, X16, LSR #25
    CRC32CW  W21, W2, W27
    LSLV  W9, W11, W29
    EOR  X8, X7, #0xfffffffe0007ffff
    EON  W22, W10, W22, LSR #31
    BICS  W21, W9, W29, LSR #0
    ORR  X9, X28, X6, LSL #44
    ORR  W10, W8, W6, ASR #8
    ADCS  W7, W5, W9
    SUBS  X4, X19, W19, UXTW #2
    ADDS  X7, X15, #0x970
    AND  X9, X7, #0xffff03ffffffffff
    SUB  W12, W12, W7, LSR #0
    AND  W29, W21, W2, ASR #25
    ANDS  W15, W21, #0x7070707
    SUB  W23, W6, #0xce1
    SBFM  W9, W14, #0x3, #0x2
    SUB  W22, W15, W9, LSR #18
    ORN  X28, X26, X28, LSR #25
    MOVK  X27, #0xcfe7, LSL #16
    SUBS  X10, X4, X23, LSR #50
    CSNEG  X28, X10, X16, GE
    ADDS  X18, X15, X12, LSR #19
    ORR  X6, X27, #0x1ffc
    SUBS  X13, X13, #0x1
    B.NE  TaishanIntAluP02_label_222
    MOVZ  X3, #0x0, LSL #0
    SUB  X19, X3, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X2, X29, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X7, #0x3, LSL #0
    MOVK  X7, #0xe800, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X20, X7, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP02_TestFail
    MOVZ  X6, #0xad3, LSL #0
    MOVK  X6, #0xff8c, LSL #16
    MOVK  X6, #0xa109, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X22, X6, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X29, #0xad3, LSL #0
    MOVK  X29, #0xff8c, LSL #16
    MOVK  X29, #0xa109, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X15, X29, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP02_TestFail
    MOVZ  X3, #0x3, LSL #0
    MOVK  X3, #0xe800, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X7, X3, X7
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP02_TestFail
    MOVZ  X28, #0xf9d, LSL #0
    MOVK  X28, #0xf7f8, LSL #16
    MOVK  X28, #0xfffe, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X25, X28, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #16
    SUB  X17, X15, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X17, #0x3, LSL #0
    MOVK  X17, #0xe800, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X25, X17, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xf800, LSL #16
    MOVK  X14, #0xfffd, LSL #32
    MOVK  X14, #0xe76, LSL #48
    SUB  X2, X14, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X10, #0x28b4, LSL #0
    MOVK  X10, #0x62c9, LSL #16
    SUB  X5, X10, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X28, X22, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xf800, LSL #16
    MOVK  X15, #0xfffd, LSL #32
    MOVK  X15, #0xe76, LSL #48
    SUB  X14, X15, X14
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xf800, LSL #16
    MOVK  X9, #0xfffd, LSL #32
    MOVK  X9, #0xe76, LSL #48
    SUB  X27, X9, X15
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xf800, LSL #16
    SUB  X22, X25, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x3, LSL #0
    MOVK  X5, #0xe800, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X2, X5, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X2, #0xc59, LSL #0
    SUB  X4, X2, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X26, X13, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X19, X14, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X9, X20, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xf800, LSL #16
    SUB  X13, X5, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X29, #0xad3, LSL #0
    MOVK  X29, #0xff8c, LSL #16
    MOVK  X29, #0xa109, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X23, X29, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x88b1, LSL #0
    MOVK  X2, #0xb929, LSL #16
    MOVK  X2, #0x4135, LSL #32
    MOVK  X2, #0xece9, LSL #48
    MOVZ  X3, #0xddbd, LSL #0
    MOVK  X3, #0xc96f, LSL #16
    MOVK  X3, #0xc9a1, LSL #32
    MOVK  X3, #0xd057, LSL #48
    MOVZ  X4, #0x46b0, LSL #0
    MOVK  X4, #0x1bfc, LSL #16
    MOVK  X4, #0xf418, LSL #32
    MOVK  X4, #0x2e41, LSL #48
    MOVZ  X5, #0x8fe4, LSL #0
    MOVK  X5, #0x3e62, LSL #16
    MOVK  X5, #0x6f04, LSL #32
    MOVK  X5, #0x406f, LSL #48
    MOVZ  X6, #0x1b74, LSL #0
    MOVK  X6, #0xdd35, LSL #16
    MOVK  X6, #0x27ca, LSL #32
    MOVK  X6, #0x306e, LSL #48
    MOVZ  X7, #0x420a, LSL #0
    MOVK  X7, #0x688d, LSL #16
    MOVK  X7, #0x3ef1, LSL #32
    MOVK  X7, #0x7b18, LSL #48
    MOVZ  X8, #0x99fc, LSL #0
    MOVK  X8, #0x22c2, LSL #16
    MOVK  X8, #0xfd28, LSL #32
    MOVK  X8, #0xab23, LSL #48
    MOVZ  X9, #0xa8a6, LSL #0
    MOVK  X9, #0x6675, LSL #16
    MOVK  X9, #0xefbe, LSL #32
    MOVK  X9, #0xad4, LSL #48
    MOVZ  X10, #0x5e2c, LSL #0
    MOVK  X10, #0xf9ea, LSL #16
    MOVK  X10, #0x6b6d, LSL #32
    MOVK  X10, #0x9a76, LSL #48
    MOVZ  X11, #0x69c0, LSL #0
    MOVK  X11, #0xe1ee, LSL #16
    MOVK  X11, #0x964, LSL #32
    MOVK  X11, #0x8eb1, LSL #48
    MOVZ  X12, #0xde27, LSL #0
    MOVK  X12, #0x247c, LSL #16
    MOVK  X12, #0x6e3f, LSL #32
    MOVK  X12, #0x9beb, LSL #48
    MOVZ  X13, #0x474e, LSL #0
    MOVK  X13, #0x877b, LSL #16
    MOVK  X13, #0x4626, LSL #32
    MOVK  X13, #0xb190, LSL #48
    MOVZ  X14, #0x1c8a, LSL #0
    MOVK  X14, #0x99de, LSL #16
    MOVK  X14, #0x9d14, LSL #32
    MOVK  X14, #0x1baf, LSL #48
    MOVZ  X15, #0xab8f, LSL #0
    MOVK  X15, #0xbdc5, LSL #16
    MOVK  X15, #0x7857, LSL #32
    MOVK  X15, #0x2de4, LSL #48
    MOVZ  X16, #0x4f01, LSL #0
    MOVK  X16, #0x29aa, LSL #16
    MOVK  X16, #0x9649, LSL #32
    MOVK  X16, #0x3626, LSL #48
    MOVZ  X17, #0xa953, LSL #0
    MOVK  X17, #0xbf75, LSL #16
    MOVK  X17, #0x35e6, LSL #32
    MOVK  X17, #0x6884, LSL #48
    MOVZ  X18, #0xd9c6, LSL #0
    MOVK  X18, #0xe990, LSL #16
    MOVK  X18, #0x115a, LSL #32
    MOVK  X18, #0x9b27, LSL #48
    MOVZ  X19, #0x47b7, LSL #0
    MOVK  X19, #0x49f0, LSL #16
    MOVK  X19, #0x789, LSL #32
    MOVK  X19, #0x3974, LSL #48
    MOVZ  X20, #0x53a2, LSL #0
    MOVK  X20, #0x7874, LSL #16
    MOVK  X20, #0x709c, LSL #32
    MOVK  X20, #0x8c85, LSL #48
    MOVZ  X21, #0xa7bf, LSL #0
    MOVK  X21, #0x6223, LSL #16
    MOVK  X21, #0x3e35, LSL #32
    MOVK  X21, #0xa671, LSL #48
    MOVZ  X22, #0x478d, LSL #0
    MOVK  X22, #0x3242, LSL #16
    MOVK  X22, #0x475a, LSL #32
    MOVK  X22, #0x6b23, LSL #48
    MOVZ  X23, #0x2aa6, LSL #0
    MOVK  X23, #0x8973, LSL #16
    MOVK  X23, #0xb35e, LSL #32
    MOVK  X23, #0xd760, LSL #48
    MOVZ  X25, #0xb9b8, LSL #0
    MOVK  X25, #0x397c, LSL #16
    MOVK  X25, #0x8537, LSL #32
    MOVK  X25, #0x8df4, LSL #48
    MOVZ  X26, #0x5319, LSL #0
    MOVK  X26, #0x38e8, LSL #16
    MOVK  X26, #0x4bd9, LSL #32
    MOVK  X26, #0xd473, LSL #48
    MOVZ  X27, #0xad6d, LSL #0
    MOVK  X27, #0x6ee1, LSL #16
    MOVK  X27, #0x55d2, LSL #32
    MOVK  X27, #0x54ff, LSL #48
    MOVZ  X28, #0x6cd1, LSL #0
    MOVK  X28, #0x5ea7, LSL #16
    MOVK  X28, #0x2e4b, LSL #32
    MOVK  X28, #0xd2d8, LSL #48
    MOVZ  X29, #0x149c, LSL #0
    MOVK  X29, #0xbcb0, LSL #16
    MOVK  X29, #0x1bcb, LSL #32
    MOVK  X29, #0xa114, LSL #48
    MOVZ  X21, #0xa, LSL #0
TaishanIntAluP02_label_250:
    SUB  W29, W23, #0xaea
    SUB  W7, W18, W28, UXTB #0
    ORR  W6, W15, #0xf803f803
    SUB  W7, W14, W9, ASR #2
    UMADDL  X2, W10, W29, X26
    SUB  X6, X29, #0x9d0
    EON  W7, W22, W27, LSL #23
    AND  W27, W29, W10, LSR #3
    CSINV  X4, X21, X19, MI
    EON  W23, W14, W4, LSR #13
    CLZ  V3.4H, V10.4H
    SMULH  X29, X9, X3
    CSINV  X15, X19, X23, PL
    CRC32CX  W6, W15, X15
    ADDS  X26, X13, W27, SXTB #1
    ORR  V12.4H, #0xf3, LSL #8
    MOVZ  X28, #0x4341, LSL #48
    CLZ  X2, X29
    ADDS  X3, X6, X20, LSL #16
    ADC  X4, X28, X10
    CLZ  X10, X5
    ANDS  X12, X20, #0xffffffff00000001
    EXTR  W26, W25, W16, #0x17
    CRC32H  W6, W17, W6
    ADDS  W23, W26, W29, SXTW #0
    UMULH  X4, X22, X19
    ANDS  W5, W20, #0x7fe0
    UBFM  X6, X15, #0xb, #0x2b
    CSINC  W12, W9, W29, EQ
    SUB  X3, X20, W14, UXTH #0
    ANDS  X8, X7, X2, ROR #19
    CRC32CX  W13, W29, X27
    EOR  X5, X20, X7, LSL #24
    CRC32B  W10, W19, W29
    UBFM  W7, W27, #0x14, #0x5
    ANDS  W18, W9, W12, ROR #1
    ANDS  X19, X27, X10, ROR #56
    SUBS  W8, W13, W13, SXTH #2
    ADD  W11, W16, W7, LSL #31
    UMADDL  X3, W15, W16, X10
    SUBS  X12, X2, W2, UXTW #3
    CSNEG  X20, X13, X26, HI
    CLS  W18, W12
    CRC32CX  W5, W9, X16
    ADD  X26, X3, X25, LSL #16
    MOVN  W2, #0x9f96, LSL #16
    AND  W6, W2, W3, ASR #8
    SMULH  X19, X8, X26
    ORN  W5, W4, W10, ROR #0
    CRC32B  W4, W11, W4
    UMADDL  X25, W18, W25, X6
    SUBS  X3, X20, #0x8e4, LSL #12
    ANDS  X28, X4, X16, LSR #16
    EOR  W25, W19, W6, LSL #3
    UBFM  W29, W20, #0x13, #0x8
    MADD  X19, X9, X28, X9
    CRC32CB  W29, W21, W26
    ADD  X14, X9, #0x8b9
    AND  X6, X16, X16, ASR #27
    CRC32W  W15, W9, W18
    CSINV  X3, X15, X9, LE
    ADD  W12, W28, W16, LSL #5
    ADD  X25, X20, X18, LSR #21
    UBFM  W16, W25, #0x16, #0x2
    MOVK  W5, #0xa2b1, LSL #16
    UMULH  X3, X6, X12
    ANDS  W8, W27, #0x3ffe3ffe
    CSEL  X11, X17, X8, GT
    SUBS  W12, W16, W29, SXTB #2
    EXTR  X17, X13, X6, #0x3d
    SUB  W18, W26, #0x886, LSL #12
    ADDS  W15, W26, #0x881, LSL #12
    EOR  X20, X29, #0x2020202020202020
    ADDS  X19, X22, X5, ASR #60
    CRC32CW  W11, W5, W10
    UBFM  W13, W26, #0xd, #0x3
    SMSUBL  X5, W28, W13, X10
    CSEL  W5, W11, W27, NE
    UMULH  X13, X22, X22
    CRC32CH  W16, W15, W9
    ADC  X26, X20, X2
    ANDS  W28, W28, W20, ROR #6
    ADDS  X5, X8, #0xace
    ANDS  W8, W2, W26, ASR #30
    SMADDL  X28, W6, W3, X2
    SUB  W22, W9, W20, SXTB #3
    CRC32W  W10, W5, W28
    ADD  X20, X9, X12, LSR #40
    CSINC  W17, W6, W9, GE
    CRC32B  W16, W12, W28
    ADD  X7, X19, #0x918
    BICS  X5, X13, X16, LSL #62
    ADD  W8, W13, W28, SXTB #4
    ASRV  W8, W7, W7
    MOVN  W12, #0x4b34, LSL #0
    ASRV  X20, X19, X17
    UBFM  W16, W20, #0x0, #0x10
    CRC32B  W8, W29, W11
    EOR  W5, W18, #0x44444444
    ADCS  X6, X19, X9
    BIC  V10.16B, V23.16B, V28.16B
    ADDS  W3, W16, W5, UXTB #3
    SUBS  X2, X6, W5, SXTW #4
    EON  X5, X27, X20, LSR #61
    EXTR  W29, W5, W11, #0xe
    ANDS  W18, W5, W28, LSL #16
    ADDS  X15, X14, #0x913
    CSINV  X15, X16, X7, PL
    EOR  W15, W2, W3
    LSRV  W14, W29, W9
    CLS  X9, X10
    ADDS  X4, X23, X25, LSR #44
    ORR  V11.4H, #0xc3, LSL #8
    BIC  W22, W4, W28, LSR #29
    ADC  W19, W11, W20
    SUBS  X17, X22, X23, UXTX #1
    CSINC  W11, W29, W26, NE
    CSEL  W11, W6, W29, LS
    EXTR  W23, W12, W12, #0x12
    AND  W12, W27, W25, ROR #24
    EOR  W2, W15, W3, LSR #8
    ADDS  W19, W16, W17, LSR #8
    CRC32B  W6, W20, W25
    CLZ  V9.8H, V30.8H
    CSNEG  W25, W22, W28, VC
    SMSUBL  X25, W6, W11, X26
    ANDS  W16, W3, #0xcccccccc
    CSNEG  X26, X6, X5, GE
    MADD  X23, X4, X28, X20
    ORR  V9.4S, #0xaf, LSL #16
    EOR  W17, W23, #0xffe0ffe
    ADCS  W14, W29, W29
    CLS  X14, X27
    CRC32CX  W9, W27, X25
    SUB  W4, W17, W29, SXTB #2
    ANDS  X23, X29, X17, LSL #22
    EXTR  W6, W29, W2, #0x14
    SUBS  X13, X15, W22, UXTB #1
    MOVN  W25, #0x8a4e, LSL #16
    SUBS  W27, W28, W28, SXTX #4
    LSRV  X19, X14, X12
    EOR  X14, X14, #0xffff000003ffffff
    SBFM  W7, W12, #0x1c, #0x1a
    CRC32B  W4, W22, W12
    EON  X29, X16, X3, LSL #54
    SUB  W27, W4, W2, LSL #20
    EXTR  X4, X7, X4, #0x6
    SUBS  X3, X26, W22, UXTH #3
    CSINV  W15, W15, W6, VC
    ORR  W6, W10, #0x80000000
    CSNEG  X6, X28, X27, NV
    ANDS  W27, W16, W9, ROR #20
    CSNEG  X12, X2, X26, NE
    ORN  W28, W16, W7, ASR #7
    BIC  X13, X4, X11, ASR #3
    SUBS  X14, X27, W4, SXTW #1
    SUBS  W17, W25, #0x9a0
    ANDS  W20, W23, #0xe00fe00f
    SBFM  W23, W19, #0x10, #0x1e
    CSNEG  W10, W17, W22, MI
    CLZ  W25, W16
    SMADDL  X13, W6, W3, X4
    MOVK  X28, #0xb265, LSL #48
    ADDS  W20, W22, W16, ASR #16
    ADD  W27, W26, #0x3b, LSL #12
    MOVK  X7, #0x98d8, LSL #48
    ASRV  X22, X28, X10
    CLZ  W25, W9
    CLZ  X19, X13
    MOVZ  X7, #0xd07b, LSL #16
    MOVN  X11, #0x9f6, LSL #16
    CLZ  V0.8B, V16.8B
    CSINC  W29, W13, W14, NV
    ORR  X25, X29, X11, ROR #34
    AND  W28, W11, #0xff000007
    MOVZ  X17, #0xd156, LSL #48
    CSEL  W3, W10, W12, MI
    EON  X7, X25, X23, LSL #12
    ORR  W15, W27, W25, ROR #16
    EXTR  W19, W10, W3, #0xb
    EON  W23, W29, W20, ASR #24
    ADDS  X29, X12, W23, SXTB #2
    EOR  X6, X28, X25, ASR #55
    CSNEG  X7, X8, X17, LS
    SUB  W9, W21, #0xce3, LSL #12
    LSRV  X19, X28, X10
    ADC  W27, W27, W20
    ADD  X10, X15, X20, SXTX #4
    CSNEG  X22, X14, X9, AL
    SUB  W22, W3, #0xd50, LSL #12
    ADDS  X8, X2, X18, SXTX #1
    ADCS  X7, X22, X26
    CRC32CB  W20, W15, W27
    ASRV  X3, X26, X28
    BICS  X16, X18, X29, LSR #53
    ORN  X17, X20, X23, LSL #26
    EXTR  X11, X27, X26, #0x14
    SUB  W22, W2, W6, LSL #24
    ADDS  X8, X18, W16, SXTB #0
    UBFM  W16, W26, #0x15, #0x18
    SUBS  X21, X21, #0x1
    B.NE  TaishanIntAluP02_label_250
    MOVZ  X11, #0xba3b, LSL #0
    MOVK  X11, #0x30ce, LSL #16
    SUB  X3, X11, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X20, #0x2ec7, LSL #0
    MOVK  X20, #0x2d0, LSL #16
    SUB  X16, X20, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP02_TestFail
    MOVZ  X13, #0xfffc, LSL #0
    MOVK  X13, #0x9ff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X4, X13, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X18, #0x5c0a, LSL #0
    MOVK  X18, #0x7d95, LSL #16
    SUB  X16, X18, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xffe9, LSL #16
    SUB  X3, X10, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X16, #0xd001, LSL #0
    MOVK  X16, #0xff31, LSL #16
    SUB  X23, X16, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xffe9, LSL #16
    SUB  X20, X21, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP02_TestFail
    MOVZ  X16, #0xba3b, LSL #0
    MOVK  X16, #0x30ce, LSL #16
    SUB  X9, X16, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X28, #0xba3b, LSL #0
    MOVK  X28, #0x30ce, LSL #16
    SUB  X18, X28, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP02_TestFail
    MOVZ  X3, #0xfffc, LSL #0
    MOVK  X3, #0x9ff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X10, X3, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X18, #0xaaf2, LSL #0
    MOVK  X18, #0xfa5f, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X14, X18, X14
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X26, X16, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X13, X10, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP02_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xf7ff, LSL #16
    MOVK  X2, #0xc9f3, LSL #32
    MOVK  X2, #0xfc08, LSL #48
    SUB  X14, X2, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X26, #0xaaf2, LSL #0
    MOVK  X26, #0xfa5f, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X11, X26, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xf60, LSL #16
    SUB  X6, X12, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xffe9, LSL #16
    SUB  X7, X12, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP02_TestFail
    MOVZ  X20, #0xba3b, LSL #0
    MOVK  X20, #0x34ce, LSL #16
    SUB  X2, X20, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X3, X28, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0x7fff, LSL #32
    MOVK  X21, #0xfd82, LSL #48
    SUB  X28, X21, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP02_TestFail
    MOVZ  X16, #0xaaf2, LSL #0
    MOVK  X16, #0xfa5f, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X26, X16, X26
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X26, #0x4fcb, LSL #0
    MOVK  X26, #0x4daf, LSL #16
    SUB  X5, X26, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X3, #0xa, LSL #0
TaishanIntAluP02_label_276:
    ADDS  W22, W10, #0x89, LSL #12
    EOR  X6, X15, X16, ROR #26
    ORR  V17.8B, V2.8B, V15.8B
    SUB  X26, X28, W6, SXTW #2
    MOVK  X13, #0xb1a6, LSL #48
    ANDS  X6, X7, X23, LSR #32
    SMSUBL  X23, W25, W17, X29
    ADD  W5, W15, W6, SXTH #0
    CRC32CW  W2, W8, W12
    ADDS  X13, X28, X8, ASR #10
    BICS  X17, X21, X18, ROR #33
    ADC  X11, X5, X29
    ADD  X18, X23, #0x96c, LSL #12
    LSLV  X20, X2, X28
    SUBS  X28, X18, X7, ASR #40
    EOR  W7, W5, #0x807f807f
    SUB  W11, W16, W10, ASR #12
    LSLV  W6, W28, W25
    BIC  W7, W19, W2, ASR #17
    ADDS  X27, X21, #0x6d1
    AND  W13, W8, W6, ROR #29
    ORN  W13, W5, W16, LSL #2
    ADD  W9, W16, W3, ASR #22
    ANDS  X14, X8, X15, LSL #54
    AND  X9, X28, #0xc001c001c001c001
    ORR  X8, X25, X16, ASR #23
    ANDS  X11, X17, #0x9f9f9f9f9f9f9f9f
    ASRV  X9, X5, X10
    UBFM  W2, W15, #0x7, #0xb
    SMSUBL  X18, W20, W3, X23
    MOVZ  X8, #0x137e, LSL #48
    CSINV  X14, X14, X20, GT
    UBFM  W19, W28, #0x5, #0x11
    SUBS  W28, W28, #0x364
    CSINC  W19, W10, W8, VS
    EXTR  W13, W5, W9, #0x10
    SMULH  X20, X19, X25
    ADDS  W22, W10, W11, UXTB #3
    ORN  X6, X12, X2, ROR #12
    EOR  X4, X10, X27, LSL #3
    CSINV  W28, W20, W6, MI
    CRC32CX  W15, W25, X8
    CRC32CB  W6, W4, W14
    SUBS  W28, W13, #0xda5, LSL #12
    SBFM  X23, X10, #0x1b, #0x31
    ADCS  X17, X10, X20
    SUBS  W11, W25, W15, SXTW #1
    EON  X10, X27, X21, ASR #27
    SMSUBL  X25, W25, W3, X6
    ADDS  X8, X5, W17, SXTH #4
    CSEL  X13, X5, X16, PL
    CLZ  W28, W5
    UBFM  X2, X5, #0x16, #0x2a
    MADD  X19, X3, X21, X29
    ADDS  W13, W22, W28, LSR #15
    CLZ  W10, W2
    CLZ  V27.4S, V31.4S
    ADD  X4, X28, X26, LSL #26
    ADD  W27, W20, W29, SXTX #2
    UMULH  X20, X5, X28
    SUB  X2, X28, #0x669
    BIC  V22.16B, V22.16B, V12.16B
    SUB  W15, W8, W28, ASR #21
    AND  W27, W10, W11, LSL #21
    ADD  X12, X13, #0x6f0
    CSEL  W12, W20, W5, HI
    SUBS  X19, X25, #0xe3d, LSL #12
    CRC32CB  W25, W26, W26
    UBFM  W27, W16, #0x19, #0x1b
    EXTR  X23, X12, X27, #0x3e
    ADD  X27, X20, #0x687
    ADCS  X15, X12, X15
    AND  X13, X6, #0xc000000fc000000f
    MOVZ  W9, #0x7911, LSL #16
    CSNEG  X29, X29, X6, NV
    LSRV  W14, W5, W22
    SUBS  W14, W6, #0xdff
    CRC32CW  W21, W21, W10
    ADD  X28, X9, X23, ASR #16
    CSEL  X13, X17, X22, PL
    ADDS  W8, W13, W27, LSL #3
    MOVK  X4, #0xd119, LSL #32
    ORN  W11, W2, W28, ROR #3
    AND  W4, W22, #0x55555555
    ASRV  X8, X19, X9
    ADDS  X23, X22, #0x660
    SMULH  X12, X25, X21
    BIC  X12, X20, X14, LSR #59
    CRC32H  W17, W13, W17
    BICS  W23, W12, W21, LSL #20
    ORR  X6, X17, X23, LSL #37
    LSLV  W11, W14, W6
    ORR  V5.16B, V6.16B, V10.16B
    ADCS  X19, X22, X23
    MOVN  W4, #0x953a, LSL #0
    ANDS  X14, X10, #0xaaaaaaaaaaaaaaaa
    BICS  W26, W10, W21, LSL #3
    CRC32H  W21, W28, W16
    MADD  X22, X21, X19, X16
    CLZ  X5, X25
    SUBS  X8, X3, X3, LSL #63
    MOVZ  X10, #0xa9ab, LSL #48
    BICS  W28, W12, W14, LSR #13
    CRC32CH  W10, W16, W27
    ADDS  W11, W26, #0x18b
    EON  X2, X14, X21, ASR #11
    CLS  W12, W5
    SUBS  X9, X27, #0x430
    ASRV  X25, X13, X15
    LSRV  X20, X23, X3
    BIC  W13, W6, W3, LSR #4
    SUBS  X16, X23, W11, SXTH #2
    ADD  X27, X4, #0x625, LSL #12
    ANDS  W7, W27, W22, LSR #19
    EON  W16, W6, W19, ROR #18
    ADD  X22, X5, #0x7a9, LSL #12
    CRC32CX  W27, W20, X5
    BICS  W11, W11, W15, LSL #25
    EOR  W26, W21, #0xff00003f
    UMADDL  X25, W27, W20, X28
    ADCS  X17, X16, X26
    SUB  W16, W10, W26, ASR #2
    SMSUBL  X7, W15, W15, X11
    ADDS  X7, X6, X21, ASR #6
    ADD  W5, W5, W4, ASR #10
    CLS  W25, W7
    MOVN  W22, #0x5a61, LSL #16
    BIC  X28, X11, X27, ASR #9
    EXTR  X21, X16, X20, #0x2a
    AND  X19, X13, #0x3fffffe0000
    ADD  W4, W13, W15, UXTH #2
    EOR  X11, X23, #0xfffffff8ffffffff
    ANDS  W11, W17, #0xffff000f
    CLZ  V23.16B, V29.16B
    BIC  X5, X20, X26, LSL #41
    SMADDL  X11, W22, W16, X2
    EOR  X29, X29, #0x8080808080808080
    UMULH  X13, X5, X22
    ASRV  X27, X26, X23
    CSINC  W10, W16, W6, GT
    UBFM  X2, X23, #0x2a, #0x37
    ADC  X28, X20, X2
    BIC  W11, W8, W12, ROR #13
    SUB  X27, X4, X23, ASR #45
    MOVN  W26, #0x7a24, LSL #16
    UMADDL  X16, W20, W15, X25
    ADDS  W2, W19, W15, LSL #4
    CLS  W22, W15
    CRC32CH  W15, W15, W21
    EOR  X19, X25, X11, ASR #46
    ORR  V13.4H, #0xb6
    CRC32CX  W4, W9, X5
    AND  X28, X7, X27, LSL #36
    BIC  V20.8B, V6.8B, V24.8B
    SUB  W11, W5, #0x238, LSL #12
    SBFM  X12, X21, #0x3, #0x17
    EXTR  W16, W5, W6, #0xa
    SUBS  X28, X25, W23, UXTB #2
    EXTR  W20, W25, W29, #0x17
    ADD  W17, W29, #0x710
    ADDS  X10, X7, W21, UXTB #3
    AND  X28, X19, X22, LSL #41
    CSEL  X14, X2, X6, VC
    CSINC  W8, W25, W25, VS
    ADDS  W27, W7, W26, UXTW #2
    LSRV  W23, W5, W15
    SUB  W6, W23, #0xc75
    SUB  X21, X28, W26, UXTW #1
    SUB  W8, W10, #0x5c4, LSL #12
    SUB  X10, X4, X29, LSL #13
    UBFM  W28, W17, #0x5, #0x14
    ADDS  X5, X23, W8, UXTB #3
    ANDS  W29, W15, W15, LSL #31
    ORR  W20, W4, #0x7e7e7e7e
    UBFM  X14, X27, #0x27, #0x2a
    CLZ  V17.8B, V2.8B
    ASRV  W6, W13, W9
    CRC32CB  W22, W6, W3
    CLS  V4.8H, V1.8H
    LSLV  W29, W21, W21
    ADDS  W14, W20, W21, LSL #9
    ASRV  W7, W8, W5
    ORR  X15, X7, #0xffffffffe00001ff
    AND  W14, W18, #0x83ff83ff
    ADDS  X15, X5, #0xe80
    ORR  W6, W28, #0xfffff80
    CRC32CX  W29, W19, X9
    ORR  X23, X6, X26, ROR #50
    ORR  X27, X3, X17, LSR #9
    ORN  X10, X14, X23, ROR #58
    ANDS  W23, W18, W18, ASR #6
    ORN  W22, W4, W8, LSR #19
    ANDS  W21, W4, W26, ASR #30
    CRC32B  W26, W2, W15
    EXTR  X10, X19, X4, #0x30
    MOVK  X29, #0x6fa7, LSL #16
    BIC  V15.16B, V15.16B, V1.16B
    ADCS  W13, W29, W29
    UBFM  X18, X27, #0x19, #0x4
    CSINV  W29, W19, W23, HI
    SUBS  X3, X3, #0x1
    B.NE  TaishanIntAluP02_label_276
    MOVZ  X7, #0xa010, LSL #0
    MOVK  X7, #0x685c, LSL #16
    SUB  X18, X7, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X26, X16, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x9e12, LSL #0
    MOVK  X2, #0xb429, LSL #16
    SUB  X9, X2, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X20, #0x678, LSL #0
    SUB  X27, X20, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X18, #0xffce, LSL #0
    MOVK  X18, #0xfff, LSL #16
    SUB  X19, X18, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X4, #0xa010, LSL #0
    MOVK  X4, #0x685c, LSL #16
    SUB  X17, X4, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X29, #0xbccf, LSL #0
    MOVK  X29, #0x6b0f, LSL #16
    SUB  X4, X29, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X23, X13, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X12, #0x8000, LSL #0
    MOVK  X12, #0xffdc, LSL #16
    SUB  X13, X12, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP02_TestFail
    MOVZ  X22, #0x8000, LSL #0
    MOVK  X22, #0xffdc, LSL #16
    SUB  X10, X22, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X9, #0x823f, LSL #0
    MOVK  X9, #0x165, LSL #16
    SUB  X23, X9, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x14f8, LSL #0
    SUB  X18, X5, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x284e, LSL #0
    SUB  X11, X6, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X9, #0xbccf, LSL #0
    MOVK  X9, #0x6b0f, LSL #16
    SUB  X5, X9, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
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
    MOVZ  X9, #0xa, LSL #0
TaishanIntAluP02_label_302:
    CSINV  W22, W16, W20, PL
    SUB  W26, W26, W17, UXTB #4
    CSEL  X21, X5, X23, AL
    ASRV  X11, X28, X7
    LSRV  W22, W17, W14
    ORR  X10, X4, #0x83ff83ff83ff83ff
    ADD  X27, X11, W21, UXTW #2
    CRC32B  W2, W7, W22
    EON  X14, X10, X17, ROR #35
    EON  X6, X2, X25, LSR #2
    SUB  W5, W28, W10, LSR #24
    SUBS  W17, W20, #0x84f, LSL #12
    AND  X10, X19, #0xfe000007fe000007
    MOVZ  W10, #0xe523, LSL #16
    CLZ  X5, X2
    SUBS  W13, W3, #0xe68
    BIC  X5, X29, X29, LSR #61
    ANDS  X26, X17, X26, ROR #51
    ADCS  W7, W21, W13
    ADCS  W22, W23, W10
    ORR  X6, X20, #0x9999999999999999
    SMADDL  X27, W4, W6, X7
    ADD  X22, X17, W3, UXTB #4
    SMULH  X14, X10, X8
    CRC32H  W6, W18, W26
    ADDS  X8, X29, X26, ASR #44
    ORR  X21, X11, #0x1ffffffffffff8
    ORR  W10, W11, #0x3fff800
    CLZ  X29, X8
    SUBS  X18, X12, X20, LSR #43
    ADCS  X11, X12, X20
    LSLV  X21, X6, X23
    CRC32B  W2, W7, W28
    ORR  V2.8B, V18.8B, V30.8B
    CSEL  W5, W8, W3, EQ
    ORR  X15, X4, X28, LSR #28
    ADD  W29, W21, W27, ASR #3
    SUB  X23, X28, #0x537
    SMULH  X29, X15, X19
    UMADDL  X4, W25, W15, X8
    ADD  W6, W8, #0x277, LSL #12
    SUB  W28, W17, W3, LSL #29
    ANDS  W8, W28, #0x60000000
    CRC32CH  W12, W4, W19
    SUBS  X7, X19, X26, LSL #23
    AND  X28, X6, #0xff00ffffff00ffff
    ASRV  X3, X15, X27
    ADD  W12, W28, W16, SXTW #4
    ASRV  X3, X7, X20
    SUBS  W17, W7, #0x58c, LSL #12
    UBFM  W7, W28, #0x0, #0x1b
    UMADDL  X4, W29, W8, X8
    BICS  X17, X23, X8, LSL #63
    LSLV  X16, X14, X15
    CSINV  W21, W25, W2, LE
    SUBS  X12, X2, #0x6c0
    SMULH  X28, X14, X10
    MADD  X4, X5, X14, X27
    SBFM  W5, W6, #0x1f, #0x1f
    ADD  W14, W25, #0x580
    ADDS  W28, W15, #0xda4
    CSINV  X8, X10, X14, GT
    ADC  X3, X3, X7
    ASRV  X13, X20, X19
    BICS  W17, W28, W12, LSR #30
    ANDS  X11, X7, X26, ASR #48
    ASRV  X15, X9, X12
    ADD  X29, X3, X22, LSR #34
    AND  X3, X29, #0x600060006000600
    EOR  X23, X3, X20, LSR #10
    MOVK  W11, #0xcafe, LSL #0
    AND  X4, X7, #0xfffe0001fffe0001
    CSINV  X27, X18, X8, CS
    LSLV  W16, W3, W17
    UMULH  X2, X5, X10
    CRC32CB  W2, W13, W21
    CLS  V21.2S, V26.2S
    SUBS  W22, W16, #0xe32
    CRC32W  W19, W3, W20
    AND  X23, X15, #0x83ff83ff83ff83ff
    ORR  W19, W15, W5, ASR #17
    ORR  X17, X25, X13, ROR #25
    SMSUBL  X17, W29, W4, X5
    CSEL  W25, W26, W26, VS
    CSINC  X2, X25, X21, AL
    ADDS  W18, W5, W15, SXTH #4
    ADDS  X19, X11, W16, SXTB #0
    ADDS  X3, X14, W19, UXTH #2
    ADD  W13, W15, W3, SXTH #0
    SUBS  W28, W26, #0xd64, LSL #12
    ADDS  W22, W5, W27, SXTX #3
    CSNEG  X2, X26, X9, NV
    SMADDL  X8, W13, W12, X23
    EOR  X18, X17, #0xfffffe
    AND  W16, W26, W10, ASR #14
    ADCS  X20, X12, X19
    CRC32CW  W25, W22, W22
    SUBS  X25, X17, #0x527
    UMSUBL  X12, W11, W29, X17
    ADD  X17, X26, W12, UXTW #1
    CSINV  X14, X20, X11, CC
    ADD  X18, X9, X22, ASR #33
    ORR  V31.16B, V16.16B, V12.16B
    SUBS  X2, X25, X16, LSL #10
    ASRV  W3, W12, W14
    MOVZ  X14, #0x3706, LSL #32
    ANDS  X22, X3, X28, LSR #37
    AND  W22, W16, W29, ROR #11
    SUBS  X29, X26, #0x35b
    EON  X18, X17, X25, LSL #35
    CSEL  W13, W27, W6, CS
    CSINC  X8, X28, X25, LT
    CSINV  X26, X16, X28, NE
    ANDS  W12, W4, #0x8f8f8f8f
    ANDS  X28, X22, X2, ROR #51
    MOVN  W14, #0xae2, LSL #16
    ADC  X20, X8, X13
    CRC32CB  W20, W20, W8
    SMADDL  X28, W22, W27, X4
    MOVK  W22, #0xc600, LSL #0
    ADD  X25, X10, X19
    ASRV  X19, X3, X18
    CSINC  X23, X28, X2, LT
    SBFM  X7, X2, #0xf, #0x2e
    ORR  V21.16B, V1.16B, V7.16B
    ORN  W28, W16, W17, ASR #28
    MOVZ  W25, #0x256a, LSL #0
    SUBS  W18, W22, #0x703
    AND  W11, W21, W3, ASR #8
    EOR  W27, W6, #0xfe07fe07
    CLZ  W12, W29
    CSEL  X14, X4, X9, LT
    EXTR  W29, W10, W2, #0x13
    EOR  X22, X14, X3, LSR #17
    SUBS  X16, X23, W6, SXTB #0
    EON  X8, X29, X9, LSR #63
    ADD  W15, W26, #0xbd3, LSL #12
    ORR  V30.4H, #0xa4
    CSEL  X26, X14, X10, LS
    ADC  W14, W21, W26
    CSINC  W26, W19, W4, LT
    CRC32W  W27, W28, W22
    BIC  V18.16B, V21.16B, V13.16B
    ORN  W26, W17, W16, ASR #24
    ADDS  W21, W8, W7, LSR #12
    ADDS  X12, X6, X7, SXTX #0
    SUB  W27, W5, #0xe03, LSL #12
    ADD  W10, W11, #0x513
    SUBS  W18, W21, W4, LSL #15
    UMULH  X2, X8, X29
    SUB  X23, X7, #0x4bf
    LSRV  X26, X6, X9
    ADDS  X26, X9, #0x98d, LSL #12
    ADD  W19, W6, W9, ASR #14
    CSINC  W3, W14, W12, CS
    ORR  X26, X15, #0xfffffffc0
    ADDS  W23, W25, #0xfd9
    SUB  W23, W4, #0x0
    EXTR  X16, X3, X23, #0x0
    CLZ  V30.8B, V23.8B
    MADD  W22, W3, W22, W11
    CSEL  X22, X5, X21, EQ
    SUB  X18, X12, X29, LSR #60
    ADD  W3, W26, #0x895, LSL #12
    MADD  W21, W27, W29, W9
    SUBS  X16, X4, X14, LSL #40
    ANDS  W28, W23, W15, LSL #12
    UMULH  X10, X12, X18
    ADDS  W12, W6, W14, LSL #3
    CSNEG  W14, W3, W6, NV
    EOR  W8, W22, #0x3ffe000
    UMSUBL  X28, W26, W19, X22
    LSLV  W26, W7, W12
    SBFM  W2, W11, #0x17, #0x1a
    SMULH  X5, X3, X23
    AND  X2, X8, #0xffe0007fffffffff
    EOR  X15, X25, #0xfffffffffff800ff
    EXTR  W16, W22, W2, #0x11
    SBFM  X17, X20, #0x34, #0x3d
    MADD  W28, W8, W25, W10
    SUBS  X15, X14, #0x57d, LSL #12
    SMADDL  X25, W3, W5, X14
    SUBS  X4, X18, X19, LSL #39
    MADD  X15, X20, X12, X13
    CSNEG  X26, X7, X15, AL
    ANDS  X27, X22, #0x7ffffe007ffffe
    ASRV  X13, X4, X2
    SUB  X20, X26, W25, UXTB #1
    CLS  X17, X10
    CSINC  W17, W18, W7, HI
    BICS  W5, W13, W27, LSR #13
    CSINC  X15, X20, X21, LT
    CSINV  X5, X17, X17, NV
    CRC32H  W26, W15, W10
    ORR  X25, X8, X14, ROR #27
    MOVK  W28, #0x3074, LSL #16
    CSNEG  X11, X2, X10, GE
    LSRV  W2, W13, W16
    CSNEG  X28, X19, X2, CC
    SUB  X11, X27, X16, LSL #2
    SUBS  X9, X9, #0x1
    B.NE  TaishanIntAluP02_label_302
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP02_TestFail
    MOVZ  X15, #0x4fc0, LSL #0
    MOVK  X15, #0x89, LSL #16
    SUB  X2, X15, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x6bdd, LSL #0
    MOVK  X6, #0xee89, LSL #16
    MOVK  X6, #0x1080, LSL #32
    MOVK  X6, #0x6c39, LSL #48
    SUB  X8, X6, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP02_TestFail
    MOVZ  X11, #0xddff, LSL #0
    MOVK  X11, #0xef61, LSL #16
    SUB  X23, X11, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X25, #0x6bdd, LSL #0
    MOVK  X25, #0xee89, LSL #16
    MOVK  X25, #0x1080, LSL #32
    MOVK  X25, #0x6c39, LSL #48
    SUB  X18, X25, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP02_TestFail
    MOVZ  X25, #0xddfe, LSL #0
    MOVK  X25, #0xef61, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X14, X25, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X15, #0xddff, LSL #0
    MOVK  X15, #0xef61, LSL #16
    SUB  X10, X15, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X25, X20, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X27, #0x3, LSL #0
    SUB  X25, X27, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP02_TestFail
    MOVZ  X25, #0xddff, LSL #0
    MOVK  X25, #0xef61, LSL #16
    SUB  X4, X25, X15
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X3, X16, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X19, #0x8ddf, LSL #0
    MOVK  X19, #0xff27, LSL #16
    SUB  X3, X19, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X18, X3, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP02_TestFail
    MOVZ  X14, #0x1222, LSL #0
    MOVK  X14, #0xd846, LSL #16
    SUB  X27, X14, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X28, #0xd83d, LSL #0
    MOVK  X28, #0x10e, LSL #16
    SUB  X19, X28, X22
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP02_TestFail
    MOVZ  X5, #0xde6f, LSL #0
    MOVK  X5, #0x4d10, LSL #16
    SUB  X25, X5, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP02_TestFail
    MOVZ  X10, #0xd83d, LSL #0
    MOVK  X10, #0x10e, LSL #16
    SUB  X18, X10, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x1ddf, LSL #0
    MOVK  X29, #0xff00, LSL #16
    SUB  X5, X29, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X2, #0xebc1, LSL #0
    MOVK  X2, #0x96c, LSL #16
    MOVK  X2, #0xa678, LSL #32
    MOVK  X2, #0x7751, LSL #48
    MOVZ  X3, #0xbddc, LSL #0
    MOVK  X3, #0x4b5c, LSL #16
    MOVK  X3, #0x7906, LSL #32
    MOVK  X3, #0x9ec9, LSL #48
    MOVZ  X4, #0x535e, LSL #0
    MOVK  X4, #0x5539, LSL #16
    MOVK  X4, #0x8dcf, LSL #32
    MOVK  X4, #0xc498, LSL #48
    MOVZ  X5, #0x9fd3, LSL #0
    MOVK  X5, #0x5348, LSL #16
    MOVK  X5, #0xad29, LSL #32
    MOVK  X5, #0x74e6, LSL #48
    MOVZ  X6, #0x1d1e, LSL #0
    MOVK  X6, #0x3666, LSL #16
    MOVK  X6, #0xb391, LSL #32
    MOVK  X6, #0x10f1, LSL #48
    MOVZ  X7, #0x595c, LSL #0
    MOVK  X7, #0xd19a, LSL #16
    MOVK  X7, #0xa688, LSL #32
    MOVK  X7, #0x5725, LSL #48
    MOVZ  X8, #0xfc66, LSL #0
    MOVK  X8, #0x8695, LSL #16
    MOVK  X8, #0xa8dc, LSL #32
    MOVK  X8, #0x3355, LSL #48
    MOVZ  X9, #0x39f1, LSL #0
    MOVK  X9, #0x2655, LSL #16
    MOVK  X9, #0x1feb, LSL #32
    MOVK  X9, #0xa6a8, LSL #48
    MOVZ  X10, #0xfc6b, LSL #0
    MOVK  X10, #0x482, LSL #16
    MOVK  X10, #0x9b34, LSL #32
    MOVK  X10, #0x81b8, LSL #48
    MOVZ  X11, #0xf4a, LSL #0
    MOVK  X11, #0x9c0d, LSL #16
    MOVK  X11, #0xf87a, LSL #32
    MOVK  X11, #0x40c1, LSL #48
    MOVZ  X12, #0x8f23, LSL #0
    MOVK  X12, #0xfbd7, LSL #16
    MOVK  X12, #0xd274, LSL #32
    MOVK  X12, #0x61d4, LSL #48
    MOVZ  X13, #0xac07, LSL #0
    MOVK  X13, #0x3807, LSL #16
    MOVK  X13, #0x279a, LSL #32
    MOVK  X13, #0xd6cc, LSL #48
    MOVZ  X14, #0x55b7, LSL #0
    MOVK  X14, #0x95cb, LSL #16
    MOVK  X14, #0xdcd4, LSL #32
    MOVK  X14, #0x9645, LSL #48
    MOVZ  X15, #0x43ec, LSL #0
    MOVK  X15, #0xd83, LSL #16
    MOVK  X15, #0xfdd3, LSL #32
    MOVK  X15, #0x5222, LSL #48
    MOVZ  X16, #0x4a5e, LSL #0
    MOVK  X16, #0xa72a, LSL #16
    MOVK  X16, #0xb0ec, LSL #32
    MOVK  X16, #0x551d, LSL #48
    MOVZ  X17, #0x1dd4, LSL #0
    MOVK  X17, #0xbb3b, LSL #16
    MOVK  X17, #0x856a, LSL #32
    MOVK  X17, #0xf91b, LSL #48
    MOVZ  X18, #0x8db0, LSL #0
    MOVK  X18, #0x6e03, LSL #16
    MOVK  X18, #0xc5d2, LSL #32
    MOVK  X18, #0xdcfa, LSL #48
    MOVZ  X19, #0x4dc2, LSL #0
    MOVK  X19, #0x4050, LSL #16
    MOVK  X19, #0x3f9c, LSL #32
    MOVK  X19, #0x3914, LSL #48
    MOVZ  X20, #0x9177, LSL #0
    MOVK  X20, #0x7c57, LSL #16
    MOVK  X20, #0x251c, LSL #32
    MOVK  X20, #0xaf26, LSL #48
    MOVZ  X21, #0xe4a1, LSL #0
    MOVK  X21, #0x4fed, LSL #16
    MOVK  X21, #0xa5ec, LSL #32
    MOVK  X21, #0x18e, LSL #48
    MOVZ  X22, #0xb341, LSL #0
    MOVK  X22, #0xdef2, LSL #16
    MOVK  X22, #0x7a81, LSL #32
    MOVK  X22, #0x291, LSL #48
    MOVZ  X23, #0x54ee, LSL #0
    MOVK  X23, #0xb171, LSL #16
    MOVK  X23, #0xba2, LSL #32
    MOVK  X23, #0xe314, LSL #48
    MOVZ  X25, #0xb55c, LSL #0
    MOVK  X25, #0x3217, LSL #16
    MOVK  X25, #0x59f8, LSL #32
    MOVK  X25, #0x2fca, LSL #48
    MOVZ  X26, #0xc711, LSL #0
    MOVK  X26, #0x9882, LSL #16
    MOVK  X26, #0xfe29, LSL #32
    MOVK  X26, #0xfffa, LSL #48
    MOVZ  X27, #0x816c, LSL #0
    MOVK  X27, #0x6bae, LSL #16
    MOVK  X27, #0xc868, LSL #32
    MOVK  X27, #0xf55, LSL #48
    MOVZ  X28, #0x2dfd, LSL #0
    MOVK  X28, #0xd3fa, LSL #16
    MOVK  X28, #0x1af, LSL #32
    MOVK  X28, #0xc5ce, LSL #48
    MOVZ  X29, #0x37b3, LSL #0
    MOVK  X29, #0x5322, LSL #16
    MOVK  X29, #0x315d, LSL #32
    MOVK  X29, #0xaca8, LSL #48
    MOVZ  X11, #0xa, LSL #0
TaishanIntAluP02_label_330:
    CRC32W  W8, W21, W4
    ORR  W19, W8, W3, LSL #19
    ORR  V6.4S, #0x14, LSL #24
    ADDS  X29, X15, #0x920
    SBFM  X22, X9, #0x2b, #0x31
    EOR  X15, X18, X23, LSL #21
    ADD  X10, X8, #0x8d0
    CRC32B  W13, W7, W27
    SUBS  W17, W26, W7, UXTX #4
    LSRV  X26, X12, X5
    ANDS  W3, W12, W29, ROR #11
    BIC  W19, W25, W20, ASR #9
    CSINC  W20, W12, W7, CC
    ADD  X27, X17, #0x909
    ADCS  X14, X18, X18
    SBFM  X9, X3, #0xb, #0x12
    UMULH  X15, X15, X10
    CRC32X  W4, W15, X18
    SMSUBL  X22, W25, W28, X10
    BICS  X16, X4, X16, ROR #43
    ADDS  W17, W7, W22, UXTH #0
    LSRV  X7, X9, X19
    ANDS  W19, W26, #0x40
    ADD  W18, W13, #0x43d
    ADDS  X28, X9, #0xdfc
    ADDS  X20, X23, X16, LSR #47
    CRC32H  W27, W14, W14
    AND  X17, X2, X14, ASR #61
    EXTR  W28, W25, W25, #0x1
    SUBS  W19, W21, W7, SXTW #4
    EOR  W3, W12, W3, ROR #5
    SUB  W8, W27, #0x575, LSL #12
    AND  X13, X4, #0x3800380038003800
    CSINV  X10, X9, X11, EQ
    MOVN  W20, #0x29af, LSL #16
    ORR  X29, X20, #0xffff00
    BIC  X8, X12, X17, ROR #41
    MOVZ  W17, #0x7301, LSL #16
    ANDS  X6, X21, X6, ASR #24
    CSEL  X20, X10, X18, EQ
    ORN  X22, X18, X25, ROR #57
    ADDS  W19, W5, W20, UXTX #1
    LSRV  W12, W21, W9
    ORR  W19, W18, W26, LSR #2
    ORR  W28, W3, #0x1ff800
    CLS  X28, X29
    ADCS  W8, W8, W2
    SUBS  X5, X20, #0x844, LSL #12
    AND  X7, X5, #0xff001fffff001fff
    ORR  V17.4H, #0x7a, LSL #8
    ADCS  W10, W6, W14
    MOVZ  W12, #0xe241, LSL #16
    LSRV  X2, X26, X15
    CLZ  V31.2S, V1.2S
    EOR  W17, W16, W16, LSL #29
    BIC  W28, W2, W17, ROR #29
    ADC  W25, W3, W25
    ASRV  W8, W17, W19
    EON  X4, X7, X29, LSL #26
    SMSUBL  X17, W15, W6, X15
    SUBS  X28, X29, #0x5b0
    SUB  W8, W4, W23, SXTW #3
    BICS  X23, X26, X23, LSL #13
    ADD  W27, W17, W23, LSL #18
    SUB  X14, X12, X26, LSR #43
    EOR  W14, W21, #0xfe3ffe3f
    ORR  X17, X29, #0xfffe00000007ffff
    UMULH  X27, X2, X9
    CSEL  X12, X15, X5, HI
    ORR  V15.8B, V6.8B, V9.8B
    ADC  X22, X20, X6
    LSRV  W27, W15, W22
    ORR  X10, X21, #0xfffffffff80000
    ADD  W12, W15, W3, UXTB #3
    SUBS  X21, X13, W26, SXTH #1
    ADCS  W19, W25, W10
    ADDS  X14, X26, X27, LSR #41
    CLS  W23, W12
    SUBS  X27, X4, W6, SXTB #3
    EOR  X10, X23, #0xfe0000fffe0000ff
    EXTR  X26, X22, X17, #0x34
    BIC  V8.8B, V14.8B, V26.8B
    MADD  X20, X6, X16, X9
    ORR  W27, W20, W15, ASR #19
    SUBS  X16, X14, W13, UXTH #0
    CLS  V5.4S, V12.4S
    CLZ  W3, W21
    LSLV  X28, X27, X13
    ADD  W20, W5, W28, LSR #13
    UMADDL  X8, W21, W22, X18
    SBFM  X9, X6, #0x22, #0x2b
    MADD  X14, X2, X29, X8
    CRC32W  W27, W3, W9
    ASRV  W4, W23, W25
    UMADDL  X27, W17, W17, X4
    LSLV  W23, W13, W9
    CSINC  W4, W17, W4, LE
    CSINV  W3, W19, W27, PL
    MADD  X15, X21, X23, X20
    MOVN  W14, #0x1a4, LSL #0
    CSEL  W28, W16, W16, PL
    SUB  W13, W4, W8, LSL #25
    MOVZ  W12, #0x2c11, LSL #16
    SUB  X3, X20, W7, SXTW #2
    SUBS  W15, W16, W29, UXTW #2
    CLS  W2, W17
    EOR  W28, W29, #0xcccccccc
    SUBS  X2, X3, W27, SXTH #1
    CSINV  W28, W12, W23, CS
    EOR  X4, X28, X15, ROR #42
    EXTR  W19, W5, W14, #0x1a
    AND  X8, X17, X8, LSR #4
    ANDS  W25, W8, #0xe07fffff
    CRC32B  W25, W4, W16
    UBFM  W12, W25, #0xe, #0x0
    SUBS  W15, W16, #0x4a8, LSL #12
    SUBS  W19, W26, W22, LSR #25
    ADD  W16, W25, W25, UXTX #2
    UMSUBL  X4, W21, W21, X25
    LSLV  X23, X25, X26
    EOR  W19, W22, #0xfff0003f
    ADDS  W14, W23, #0x630
    LSRV  W8, W15, W16
    ORR  X19, X7, X8, LSR #44
    CRC32CH  W14, W7, W9
    UBFM  W28, W7, #0x6, #0x16
    MOVN  X29, #0x5b07, LSL #48
    CSEL  W27, W28, W19, HI
    MOVN  X8, #0xac9, LSL #16
    CSEL  X21, X4, X13, LE
    ORR  V11.8B, V5.8B, V27.8B
    MOVZ  W2, #0xf5ed, LSL #16
    EOR  W12, W22, W25, ROR #21
    SUBS  X22, X4, X28, LSR #14
    CSINV  X23, X4, X2, EQ
    MOVN  X28, #0x4e76, LSL #48
    EXTR  X6, X9, X15, #0x20
    MOVK  X16, #0xcb39, LSL #0
    CRC32CB  W18, W4, W20
    SMSUBL  X25, W4, W28, X6
    CLZ  X3, X13
    CSEL  W15, W15, W19, PL
    BIC  W20, W9, W2, ASR #21
    LSRV  X8, X8, X22
    SUBS  W14, W18, W18, ASR #6
    ORR  V5.4H, #0xc5, LSL #8
    CRC32X  W29, W21, X23
    ORR  V21.4H, #0x9
    EOR  X20, X12, #0xffffffffffe3ffff
    MOVZ  W12, #0xf534, LSL #0
    CRC32B  W16, W6, W9
    ASRV  X18, X4, X18
    CLZ  X27, X10
    SUB  X10, X5, X9, LSR #33
    BIC  X6, X20, X28, ROR #56
    ANDS  X21, X11, #0x7070707070707070
    BIC  V8.8B, V26.8B, V25.8B
    CSINC  W16, W18, W9, AL
    ADD  X9, X4, W15, SXTB #0
    ADCS  W18, W13, W23
    EOR  W15, W13, #0xffffdfff
    UMADDL  X13, W28, W29, X11
    CRC32CH  W28, W28, W13
    CLS  X3, X6
    ADDS  X16, X5, #0xfcf
    CRC32B  W25, W23, W26
    LSLV  W29, W25, W21
    CLS  W4, W16
    BIC  W15, W3, W16, ASR #16
    ORR  X21, X25, #0xffffff00003fffff
    SUB  W7, W20, W3, ASR #13
    CLZ  W28, W25
    ADD  W18, W29, W21, LSL #7
    ORN  X18, X9, X10, LSR #48
    CSNEG  X10, X9, X23, VC
    EOR  X21, X9, #0xaaaaaaaaaaaaaaaa
    ADD  W17, W23, #0x4e7, LSL #12
    UBFM  X5, X17, #0x3b, #0x30
    MADD  X28, X26, X18, X3
    ORR  X20, X14, #0xfffffffc000fffff
    SMADDL  X26, W7, W4, X12
    EXTR  W13, W11, W27, #0x14
    BIC  X28, X2, X3, ROR #55
    MOVN  W10, #0x2a64, LSL #0
    UMSUBL  X29, W20, W15, X16
    ADDS  X23, X19, #0xd0
    ORR  X6, X7, #0x3fff800000
    AND  W7, W27, #0x6060606
    ADC  X28, X3, X5
    CRC32CH  W2, W17, W8
    ADD  X9, X18, X11, LSR #61
    EOR  X25, X25, X11, ROR #13
    CRC32B  W14, W8, W11
    MADD  W18, W4, W16, W9
    LSLV  X6, X26, X16
    CLS  W18, W12
    UMSUBL  X25, W27, W20, X12
    CSINV  W2, W19, W23, LE
    SUB  X6, X19, W20, UXTB #1
    CSINC  W18, W2, W29, CC
    SUBS  X11, X11, #0x1
    B.NE  TaishanIntAluP02_label_330
    MOVZ  X8, #0x43d, LSL #0
    MOVK  X8, #0xff00, LSL #16
    SUB  X16, X8, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X4, #0x7, LSL #0
    SUB  X5, X4, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X9, #0x23f, LSL #0
    MOVK  X9, #0xff00, LSL #16
    MOVK  X9, #0x1fff, LSL #32
    MOVK  X9, #0xff00, LSL #48
    SUB  X22, X9, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X20, X21, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP02_TestFail
    MOVZ  X15, #0x43d, LSL #0
    MOVK  X15, #0xff00, LSL #16
    SUB  X9, X15, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X13, #0xd59b, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X7, X13, X10
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP02_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP02_TestFail
    MOVZ  X11, #0xf534, LSL #0
    SUB  X26, X11, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X26, #0xd59b, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X17, X26, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X23, #0xe9e4, LSL #0
    MOVK  X23, #0x5af0, LSL #16
    SUB  X27, X23, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP02_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x43d, LSL #0
    MOVK  X29, #0xff00, LSL #16
    SUB  X5, X29, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X21, #0x43d, LSL #0
    MOVK  X21, #0xff00, LSL #16
    MOVK  X21, #0x1fff, LSL #32
    MOVK  X21, #0xff00, LSL #48
    SUB  X7, X21, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X20
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x43d, LSL #0
    MOVK  X16, #0xff00, LSL #16
    MOVK  X16, #0x1fff, LSL #32
    MOVK  X16, #0xff00, LSL #48
    SUB  X18, X16, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP02_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X7, #0xd59b, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X17, X7, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X26, #0xffe0, LSL #0
    MOVK  X26, #0x4c2d, LSL #16
    MOVK  X26, #0x1, LSL #32
    SUB  X28, X26, X28
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x43d, LSL #0
    MOVK  X6, #0xff00, LSL #16
    SUB  X11, X6, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X20, #0xa, LSL #0
TaishanIntAluP02_label_357:
    CLS  V29.4S, V25.4S
    ADDS  X8, X17, X9
    CRC32B  W22, W11, W23
    ORR  W11, W8, W5, LSR #4
    MOVK  W27, #0x36e3, LSL #16
    SMADDL  X26, W16, W20, X19
    CSNEG  W21, W14, W21, CS
    ORR  V16.2S, #0xa
    ADDS  X10, X15, #0xc58
    CLS  X25, X10
    CRC32CW  W25, W10, W28
    MOVK  X27, #0xcb98, LSL #16
    LSLV  X26, X25, X13
    ADDS  W3, W20, #0x44b
    ORR  X12, X19, X19, ASR #38
    LSLV  W22, W18, W22
    SUBS  X15, X28, W18, SXTB #3
    ANDS  X11, X10, X11, LSL #40
    SUB  X7, X15, #0x0
    ORR  X7, X3, #0xfffe00000fffffff
    CLZ  W14, W29
    CRC32CH  W9, W25, W9
    MOVN  W8, #0x4658, LSL #16
    ADDS  X21, X28, W29, UXTB #3
    SUB  X18, X11, X19, ASR #27
    CSINC  X28, X2, X23, CC
    SUBS  X23, X15, X13, LSL #29
    ORR  W18, W27, W25, LSL #9
    CRC32CH  W16, W23, W25
    ADD  W28, W11, W21, LSR #12
    MOVN  W28, #0x2663, LSL #16
    SUBS  X4, X11, W16, UXTW #3
    CRC32CW  W21, W28, W20
    EXTR  X9, X21, X27, #0x18
    SBFM  W4, W4, #0x7, #0x2
    CSINV  X29, X7, X4, VS
    ANDS  W18, W12, W11, LSR #20
    CLZ  W8, W2
    LSRV  X21, X13, X14
    SMULH  X8, X8, X3
    ADDS  X8, X27, X2, UXTX #0
    ADC  W8, W17, W4
    ORR  V11.4H, #0xf4, LSL #8
    UBFM  W9, W22, #0x11, #0x1
    CRC32X  W8, W17, X23
    SMADDL  X23, W9, W14, X14
    ANDS  W3, W19, #0xffc1ffc1
    EOR  W27, W7, #0xffe07fff
    ANDS  X26, X27, #0x3ffffffc3ffffffc
    ORR  X11, X26, X10, ROR #27
    ANDS  X23, X5, X4, ASR #9
    ADD  W8, W5, W7, LSR #10
    SMULH  X13, X28, X2
    ADD  W28, W15, W21, LSR #8
    SUBS  X26, X7, X29, ASR #41
    ORR  W16, W26, W9, LSL #12
    EON  W4, W19, W26, LSR #18
    ADC  W26, W21, W2
    ADC  X26, X9, X16
    EON  W8, W3, W11, LSL #6
    CRC32X  W17, W26, X26
    SMSUBL  X26, W11, W23, X23
    ORN  W14, W25, W10, ROR #30
    ADCS  W11, W15, W26
    SBFM  W23, W5, #0x1d, #0x17
    CLZ  V2.8H, V3.8H
    MOVN  X9, #0xbf71, LSL #32
    MOVZ  X28, #0xf3b5, LSL #32
    SUB  X2, X9, W9, SXTH #1
    ADD  X2, X17, #0x77e
    MOVK  X23, #0x4a94, LSL #0
    SUB  X3, X23, X25, LSL #13
    CRC32CW  W14, W23, W11
    MOVZ  X23, #0x4ab7, LSL #16
    LSLV  W9, W16, W11
    MOVZ  W5, #0x3435, LSL #16
    CRC32X  W27, W19, X17
    CRC32CX  W11, W23, X20
    CRC32CH  W14, W20, W12
    ADCS  X26, X9, X17
    LSLV  X23, X23, X14
    CRC32X  W25, W7, X25
    CLZ  V31.8B, V14.8B
    LSLV  X8, X5, X28
    CSINC  X22, X16, X23, VS
    AND  W11, W29, #0x80008
    SUB  X3, X22, #0xf8a
    ANDS  X4, X27, #0xcfffcfffcfffcfff
    MOVK  X25, #0xedcd, LSL #16
    ORR  W19, W19, W6, LSR #17
    CLZ  X16, X11
    LSRV  W8, W25, W12
    AND  W29, W2, W12, ASR #30
    SUBS  X21, X18, X20, ASR #42
    CSINC  X3, X19, X28, AL
    AND  X21, X21, X27, ASR #9
    MOVN  W22, #0x48e5, LSL #16
    SUBS  W22, W6, W27, LSL #16
    CSNEG  W19, W21, W4, GE
    SUBS  W9, W9, #0xed0
    MOVZ  X11, #0x467e, LSL #16
    ORR  X3, X12, X20, ROR #19
    CSINC  X28, X11, X16, LS
    CLS  W6, W8
    ORN  X22, X12, X27, ASR #39
    BIC  W11, W23, W11, ASR #2
    ADC  W8, W9, W6
    EOR  X8, X26, #0xf1fff1fff1fff1ff
    CRC32X  W23, W21, X25
    SUBS  W29, W16, #0x21f
    ASRV  W29, W28, W8
    SBFM  W12, W2, #0xe, #0x1a
    CRC32CX  W9, W4, X18
    SUB  X25, X21, #0xfa5, LSL #12
    CSINV  X11, X23, X20, VS
    CRC32CB  W22, W11, W5
    SMSUBL  X29, W5, W21, X12
    CLZ  V27.8H, V1.8H
    CSINC  W8, W19, W27, NV
    ADDS  X6, X3, X15, UXTX #3
    MOVK  W3, #0x6b90, LSL #16
    ADD  X11, X8, X21, ASR #56
    UMULH  X18, X3, X21
    BIC  W4, W16, W7, LSR #29
    BIC  X18, X4, X20, ROR #10
    SUBS  X12, X8, #0x375
    SUBS  X26, X8, X7, LSL #23
    MADD  X18, X29, X11, X7
    SBFM  W21, W13, #0x11, #0x19
    LSLV  X3, X9, X4
    ADDS  W22, W22, W5, SXTW #4
    SUBS  W29, W16, #0x0
    SUB  X23, X20, X13, LSR #61
    CLZ  V21.4S, V24.4S
    ASRV  X8, X14, X4
    CSINC  W22, W7, W27, LT
    ADD  W2, W10, W17, LSL #6
    SUB  X14, X12, #0xdd6
    EXTR  W25, W12, W2, #0xc
    EOR  W7, W8, W29, ASR #18
    ADD  X14, X3, X26, LSL #9
    CLS  X25, X6
    ADCS  X2, X5, X20
    ADDS  W29, W18, #0x531, LSL #12
    ADDS  X14, X22, #0x229, LSL #12
    MADD  X2, X2, X11, X13
    SUB  W18, W6, #0xb76, LSL #12
    CRC32CW  W22, W29, W7
    ADDS  W12, W20, W23, SXTH #3
    MOVK  W21, #0x96fe, LSL #16
    CRC32B  W22, W28, W27
    ASRV  W8, W20, W17
    CSINV  X28, X25, X14, EQ
    CRC32H  W13, W17, W11
    SBFM  X15, X5, #0x31, #0x3c
    MOVN  W26, #0xd7a, LSL #16
    SUB  X17, X9, X17, LSL #30
    ORR  V4.2S, #0xd4, LSL #8
    ADCS  X10, X6, X5
    UMULH  X15, X13, X8
    UMULH  X3, X8, X16
    ORR  X3, X7, #0x300000003
    CSEL  X19, X26, X15, AL
    ORR  W6, W8, #0x3ff
    SUB  W2, W3, W7, ASR #6
    SMADDL  X19, W18, W23, X13
    ADD  W22, W29, W12, LSR #4
    ADD  X4, X29, X17, LSR #56
    ADC  X7, X21, X9
    UMULH  X25, X11, X10
    ASRV  X29, X13, X9
    ADC  X11, X25, X13
    AND  X14, X8, X29, LSR #61
    LSLV  W26, W15, W25
    CSEL  W5, W17, W11, MI
    CSINC  X15, X7, X19, NE
    CRC32CB  W13, W10, W2
    ADD  W29, W19, W8, LSR #30
    AND  X27, X8, #0xe000e000e000e0
    SUBS  X26, X16, W14, UXTH #3
    LSLV  X26, X21, X9
    CSINC  X2, X18, X23, NE
    ADD  X19, X3, #0x754
    ADCS  X12, X26, X7
    CSINC  X11, X2, X14, VS
    ORR  X23, X18, #0x1fff0000000
    ADCS  X11, X8, X23
    ADDS  X5, X9, X22, LSR #27
    SUBS  X9, X18, X2, ASR #37
    ADD  X28, X26, #0x870
    EON  X15, X7, X8, LSL #63
    SUB  W27, W25, W21, UXTB #4
    CLZ  V7.16B, V28.16B
    ASRV  W27, W13, W2
    EOR  X12, X5, X23, LSL #33
    ADD  W27, W6, W11, UXTX #0
    CRC32X  W3, W21, X13
    ADDS  X25, X14, X29, LSL #46
    ADD  W14, W27, W25, ASR #4
    EXTR  W29, W3, W14, #0x19
    SUBS  X20, X20, #0x1
    B.NE  TaishanIntAluP02_label_357
    MOVZ  X21, #0xe517, LSL #0
    MOVK  X21, #0xff48, LSL #16
    SUB  X23, X21, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X7, #0x2ed2, LSL #0
    MOVK  X7, #0x4b3a, LSL #16
    SUB  X20, X7, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP02_TestFail
    MOVZ  X12, #0xfff, LSL #0
    MOVK  X12, #0x1053, LSL #16
    SUB  X4, X12, X4
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X7, #0x1ef9, LSL #0
    MOVK  X7, #0x9a65, LSL #16
    SUB  X14, X7, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X28, #0x3ff, LSL #0
    SUB  X14, X28, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X20, #0x1ef9, LSL #0
    MOVK  X20, #0x9a65, LSL #16
    SUB  X7, X20, X7
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP02_TestFail
    MOVZ  X7, #0x1, LSL #0
    SUB  X2, X7, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X14, #0xe517, LSL #0
    MOVK  X14, #0xff48, LSL #16
    SUB  X6, X14, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X19, #0x4517, LSL #0
    MOVK  X19, #0x3435, LSL #16
    MOVK  X19, #0x2003, LSL #32
    SUB  X20, X19, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP02_TestFail
    MOVZ  X2, #0xe518, LSL #0
    MOVK  X2, #0xff48, LSL #16
    MOVK  X2, #0x1ff, LSL #32
    SUB  X6, X2, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X18, #0xfff, LSL #0
    MOVK  X18, #0x1053, LSL #16
    SUB  X27, X18, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X13, #0x6535, LSL #0
    MOVK  X13, #0xd7f0, LSL #16
    SUB  X23, X13, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X12, #0xe517, LSL #0
    MOVK  X12, #0xff48, LSL #16
    SUB  X10, X12, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X13, #0xe108, LSL #0
    MOVK  X13, #0xce9c, LSL #16
    MOVK  X13, #0xfffe, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X26, X13, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X18, #0x2c, LSL #0
    SUB  X5, X18, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x1ef7, LSL #0
    MOVK  X2, #0x9a65, LSL #16
    SUB  X7, X2, X17
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x2c, LSL #0
    SUB  X25, X29, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X22, #0x4517, LSL #0
    MOVK  X22, #0x3435, LSL #16
    MOVK  X22, #0x2003, LSL #32
    SUB  X20, X22, X19
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X17, #0xe517, LSL #0
    MOVK  X17, #0xff48, LSL #16
    SUB  X8, X17, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP02_TestFail
    MOVZ  X12, #0x4517, LSL #0
    MOVK  X12, #0x3435, LSL #16
    MOVK  X12, #0x2003, LSL #32
    SUB  X22, X12, X22
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X18, #0x3ff, LSL #0
    SUB  X3, X18, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X3, #0x2c, LSL #0
    SUB  X14, X3, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
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
    MOVZ  X7, #0xa, LSL #0
TaishanIntAluP02_label_383:
    ADDS  W25, W13, W5, UXTB #4
    ADCS  X28, X14, X26
    ORR  V2.8H, #0x30
    ADC  W4, W28, W15
    EOR  X16, X10, #0xfffe00fffffe00ff
    ASRV  W13, W22, W10
    SMSUBL  X6, W3, W27, X29
    ADC  X6, X14, X7
    CRC32B  W11, W23, W13
    SUBS  X5, X28, X13, LSR #14
    UMULH  X27, X25, X17
    ADD  X11, X19, #0x3db, LSL #12
    ADDS  X21, X21, #0x2d1, LSL #12
    ORR  V3.4H, #0x19
    UBFM  X27, X5, #0x23, #0x32
    EOR  X5, X7, #0x3fffc0000000
    AND  W26, W29, #0x1ffffffe
    ADDS  X25, X20, W27, UXTW #3
    ADDS  X6, X25, W25, UXTH #4
    ADD  X15, X11, #0x8b0
    SMADDL  X6, W20, W19, X5
    ORN  X16, X7, X19, ROR #58
    CRC32CW  W4, W15, W27
    MOVN  W29, #0x9f39, LSL #16
    BIC  W23, W22, W21, LSR #0
    ADDS  X23, X17, #0x927
    SUB  W4, W5, W4, LSR #24
    ORR  V11.8B, V26.8B, V24.8B
    ADD  W20, W29, #0x5f0
    UMSUBL  X10, W11, W26, X25
    CSINV  X6, X23, X18, GE
    BIC  V16.8B, V1.8B, V22.8B
    UMSUBL  X16, W6, W29, X5
    ADD  X29, X10, #0x39a
    SUBS  X19, X18, W8, SXTB #0
    SUBS  X9, X7, #0xd72
    UMULH  X29, X20, X25
    SUB  X22, X4, X7, SXTX #2
    ORR  V1.8B, V11.8B, V22.8B
    SUBS  X8, X26, W20, UXTW #0
    ORR  V18.16B, V26.16B, V25.16B
    CSINV  X9, X22, X28, VC
    ADDS  W29, W19, W4, UXTH #0
    ORR  X18, X23, #0xf81ff81ff81ff81f
    CSNEG  X8, X16, X29, LS
    ADD  W23, W7, W18, SXTH #2
    LSRV  W29, W15, W9
    ADD  X23, X28, #0x94a
    MOVK  X8, #0x61a6, LSL #0
    ADD  X29, X7, X8, LSR #62
    ADDS  W16, W15, W10, ASR #28
    ANDS  W29, W10, #0xffc00fff
    ORN  X15, X5, X16, LSR #30
    CSNEG  W27, W22, W5, NV
    ADD  W4, W28, W13, LSR #16
    SUBS  W10, W2, W11, UXTW #1
    SUB  W8, W8, W29, SXTB #2
    BICS  W17, W8, W10, LSR #14
    EOR  X2, X27, #0x7ff800000
    SMADDL  X17, W11, W6, X16
    LSLV  W2, W20, W23
    CRC32CW  W16, W8, W21
    CRC32W  W4, W19, W17
    MOVK  X2, #0xea64, LSL #48
    MOVZ  W4, #0x7bb2, LSL #16
    CLS  W27, W17
    MOVN  W20, #0xcf0d, LSL #0
    CRC32CB  W22, W7, W9
    ADD  W20, W17, W19, SXTB #4
    ADDS  W17, W23, W19, UXTH #4
    ORR  W9, W16, W15, LSL #9
    ADD  W20, W22, W20, LSL #20
    EOR  X21, X16, #0x7ffe00000000
    MOVK  X17, #0xac0d, LSL #48
    MADD  W22, W29, W17, W16
    CRC32CX  W23, W16, X13
    UMADDL  X6, W14, W26, X28
    ADD  W13, W23, W6, LSR #4
    CRC32CB  W2, W19, W18
    ADCS  W4, W14, W23
    CRC32H  W4, W16, W9
    MOVK  X14, #0x875, LSL #32
    ORR  W16, W15, #0x1fc00
    CSNEG  W17, W28, W27, CC
    SUB  W25, W19, #0xf7a
    SBFM  W20, W8, #0x1f, #0x1a
    MOVN  W26, #0x910, LSL #16
    ORR  X13, X7, #0xc007c007c007c007
    LSRV  X13, X8, X19
    SUB  W16, W13, W22, LSL #11
    SUBS  X17, X25, X21, LSR #38
    AND  W4, W11, #0xf0000007
    ORR  V16.16B, V26.16B, V12.16B
    SUBS  W13, W2, #0x55f
    CRC32CH  W27, W8, W2
    SBFM  X3, X26, #0x3d, #0x35
    UMSUBL  X20, W3, W10, X15
    BIC  V19.8B, V13.8B, V6.8B
    CSEL  X27, X5, X29, VS
    ORR  X25, X2, #0xff800001ff800001
    ASRV  X19, X27, X4
    ORN  X22, X27, X3, ROR #22
    ADDS  X12, X9, #0x850
    MADD  X11, X20, X14, X2
    ORR  V17.16B, V13.16B, V27.16B
    ORR  X21, X5, #0x7ffffffffe00000
    LSRV  X5, X21, X16
    ADDS  X20, X25, #0xaa4
    ADD  W3, W18, W25, UXTH #4
    SUB  W23, W6, W25, LSL #1
    MOVZ  W8, #0x7945, LSL #0
    ADCS  W23, W16, W11
    ADD  X3, X13, #0x6a0
    SUBS  X13, X23, X14, ASR #25
    ANDS  X6, X22, X29, ASR #28
    ORR  X12, X19, #0x3e003e003e003e00
    BIC  X26, X14, X28, LSL #2
    ADCS  X27, X20, X10
    ASRV  W9, W10, W5
    ASRV  W11, W21, W17
    CLZ  W19, W28
    ADD  X19, X2, X21, ASR #63
    BICS  W11, W21, W15, ASR #15
    CRC32B  W8, W23, W13
    CLS  W15, W25
    ASRV  W3, W14, W9
    BIC  V21.16B, V22.16B, V24.16B
    SBFM  W15, W28, #0x1, #0x15
    CSINC  X15, X4, X25, AL
    AND  X15, X18, X19, LSL #23
    CLS  W12, W19
    SMSUBL  X11, W28, W15, X20
    ADCS  W22, W13, W18
    ANDS  X2, X13, #0xfffc0000
    CRC32CX  W12, W26, X12
    CRC32CW  W18, W21, W16
    CSEL  W10, W20, W15, LS
    AND  X26, X13, X18, ASR #2
    AND  W27, W22, W2, LSR #7
    CSINC  W28, W4, W4, AL
    ADCS  X28, X18, X13
    SUB  X17, X18, #0x6e0
    CLS  W11, W3
    LSLV  X14, X11, X21
    MADD  X12, X5, X23, X3
    CSEL  W25, W16, W18, CS
    CRC32CB  W14, W8, W27
    SUB  W28, W18, W14, LSL #31
    ORR  V10.16B, V2.16B, V31.16B
    MADD  X20, X13, X16, X10
    CLZ  X11, X3
    EOR  X22, X14, #0x1c001c001c001c
    ORR  V16.16B, V17.16B, V16.16B
    ADD  W28, W7, W27, ASR #27
    EXTR  X17, X13, X27, #0x1e
    ADCS  W28, W6, W15
    ORR  V9.4H, #0x1e, LSL #8
    MOVK  W4, #0xc50e, LSL #16
    EXTR  X12, X6, X12, #0x0
    ORR  X26, X4, X25, ASR #42
    ADDS  X15, X13, X22, LSR #44
    UBFM  W19, W6, #0x2, #0x1a
    SMADDL  X26, W2, W7, X19
    ADCS  X17, X8, X5
    SMULH  X11, X12, X20
    SBFM  W10, W21, #0x16, #0x0
    SUBS  W28, W22, W9, SXTW #4
    SUB  W15, W25, W18, UXTW #1
    SUBS  W26, W10, W26, LSL #20
    MOVK  X6, #0xcf2c, LSL #32
    SUBS  W4, W25, #0x4d0
    CSINV  X2, X17, X10, VC
    BIC  X18, X26, X7, ROR #1
    ADDS  W3, W18, W28, ASR #9
    EXTR  W8, W20, W3, #0x8
    ADDS  W29, W20, W20, ASR #11
    CLZ  V7.4H, V4.4H
    ADDS  X25, X25, W5, UXTH #3
    CRC32CX  W3, W15, X25
    ADC  X15, X8, X29
    ADDS  W13, W19, W27, UXTH #2
    CSINV  X16, X12, X16, GT
    ANDS  X4, X15, #0x9999999999999999
    CLZ  X28, X5
    CRC32X  W23, W7, X28
    SUBS  W14, W23, W4, ASR #24
    SUB  X14, X19, #0xc1b
    CRC32CW  W19, W15, W15
    LSLV  W3, W6, W19
    AND  X5, X21, #0xff800000000007ff
    EON  W16, W28, W9, ASR #8
    AND  X13, X2, X23, LSR #15
    MOVZ  W18, #0x3296, LSL #0
    ORR  V27.4H, #0x26
    CSEL  X9, X10, X21, VS
    MADD  X21, X28, X20, X16
    CRC32CB  W16, W3, W19
    ADD  W29, W7, #0x91
    EXTR  X2, X23, X3, #0xc
    CLZ  X4, X12
    SUBS  X7, X7, #0x1
    B.NE  TaishanIntAluP02_label_383
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xcac0, LSL #48
    SUB  X7, X5, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP02_TestFail
    MOVZ  X10, #0x6, LSL #0
    SUB  X5, X10, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x8, LSL #0
    SUB  X28, X6, X4
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X9, #0x8, LSL #0
    SUB  X21, X9, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X15, #0x136c, LSL #0
    MOVK  X15, #0xc700, LSL #16
    SUB  X23, X15, X8
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X18, #0x8, LSL #0
    SUB  X9, X18, X9
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X17, #0x6, LSL #0
    SUB  X7, X17, X10
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP02_TestFail
    MOVZ  X27, #0xf3d7, LSL #0
    MOVK  X27, #0x9bb8, LSL #16
    MOVK  X27, #0x28b6, LSL #32
    MOVK  X27, #0x1, LSL #48
    SUB  X6, X27, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X21, #0xcb24, LSL #0
    MOVK  X21, #0xc779, LSL #16
    MOVK  X21, #0x31a7, LSL #32
    MOVK  X21, #0x84, LSL #48
    SUB  X28, X21, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x1210, LSL #0
    SUB  X6, X5, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X21, #0xf3e6, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X16, X21, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X8, #0x136c, LSL #0
    MOVK  X8, #0xc700, LSL #16
    SUB  X4, X8, X15
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X12, #0x6, LSL #0
    SUB  X5, X12, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X14, #0x8, LSL #0
    SUB  X16, X14, X18
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP02_TestFail
    MOVZ  X14, #0x58c7, LSL #0
    MOVK  X14, #0x66a6, LSL #16
    MOVK  X14, #0x9983, LSL #32
    MOVK  X14, #0x23e, LSL #48
    SUB  X19, X14, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X25, #0xf3e6, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X3, X25, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X8, #0xecf3, LSL #0
    MOVK  X8, #0x46e0, LSL #16
    MOVK  X8, #0x1c, LSL #32
    MOVK  X8, #0x1c, LSL #48
    SUB  X19, X8, X22
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X21, X10, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP02_TestFail
    MOVZ  X4, #0xf3e6, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X6, X4, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X8, #0xfc00, LSL #0
    MOVK  X8, #0xffef, LSL #16
    SUB  X28, X8, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP02_TestFail
    MOVZ  X18, #0x92, LSL #0
    SUB  X11, X18, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X2, #0xcfb0, LSL #0
    MOVK  X2, #0xd89f, LSL #16
    MOVK  X2, #0x3de0, LSL #32
    MOVK  X2, #0x2a51, LSL #48
    MOVZ  X3, #0x953a, LSL #0
    MOVK  X3, #0x1cdd, LSL #16
    MOVK  X3, #0x1ee3, LSL #32
    MOVK  X3, #0xa0e1, LSL #48
    MOVZ  X4, #0x939a, LSL #0
    MOVK  X4, #0xc8f0, LSL #16
    MOVK  X4, #0x4f55, LSL #32
    MOVK  X4, #0xdbdb, LSL #48
    MOVZ  X5, #0xc84e, LSL #0
    MOVK  X5, #0xe491, LSL #16
    MOVK  X5, #0x3c26, LSL #32
    MOVK  X5, #0x7b2f, LSL #48
    MOVZ  X6, #0xe3b8, LSL #0
    MOVK  X6, #0x9fd0, LSL #16
    MOVK  X6, #0x40ed, LSL #32
    MOVK  X6, #0xcc0, LSL #48
    MOVZ  X7, #0x8a3e, LSL #0
    MOVK  X7, #0xec10, LSL #16
    MOVK  X7, #0xc81d, LSL #32
    MOVK  X7, #0xfa72, LSL #48
    MOVZ  X8, #0x2091, LSL #0
    MOVK  X8, #0x4d48, LSL #16
    MOVK  X8, #0xef83, LSL #32
    MOVK  X8, #0xe515, LSL #48
    MOVZ  X9, #0xa164, LSL #0
    MOVK  X9, #0xcf7c, LSL #16
    MOVK  X9, #0xd269, LSL #32
    MOVK  X9, #0xfca6, LSL #48
    MOVZ  X10, #0xc9ef, LSL #0
    MOVK  X10, #0xc4c7, LSL #16
    MOVK  X10, #0xdc96, LSL #32
    MOVK  X10, #0x546c, LSL #48
    MOVZ  X11, #0xda1e, LSL #0
    MOVK  X11, #0x9624, LSL #16
    MOVK  X11, #0x83d5, LSL #32
    MOVK  X11, #0x908, LSL #48
    MOVZ  X12, #0xb353, LSL #0
    MOVK  X12, #0x5f4f, LSL #16
    MOVK  X12, #0x540e, LSL #32
    MOVK  X12, #0x7c3, LSL #48
    MOVZ  X13, #0xe63b, LSL #0
    MOVK  X13, #0x37f7, LSL #16
    MOVK  X13, #0x5c98, LSL #32
    MOVK  X13, #0xa728, LSL #48
    MOVZ  X14, #0x2a82, LSL #0
    MOVK  X14, #0x26b, LSL #16
    MOVK  X14, #0xe079, LSL #32
    MOVK  X14, #0xadf2, LSL #48
    MOVZ  X15, #0xd2f6, LSL #0
    MOVK  X15, #0x7749, LSL #16
    MOVK  X15, #0xc87a, LSL #32
    MOVK  X15, #0x6ec, LSL #48
    MOVZ  X16, #0xacc4, LSL #0
    MOVK  X16, #0x33fd, LSL #16
    MOVK  X16, #0x73, LSL #32
    MOVK  X16, #0x1830, LSL #48
    MOVZ  X17, #0x92ed, LSL #0
    MOVK  X17, #0x756e, LSL #16
    MOVK  X17, #0xa187, LSL #32
    MOVK  X17, #0x5db7, LSL #48
    MOVZ  X18, #0x69c9, LSL #0
    MOVK  X18, #0x7b90, LSL #16
    MOVK  X18, #0x19a1, LSL #32
    MOVK  X18, #0x2a72, LSL #48
    MOVZ  X19, #0x105d, LSL #0
    MOVK  X19, #0xfe8f, LSL #16
    MOVK  X19, #0x12da, LSL #32
    MOVK  X19, #0x88d0, LSL #48
    MOVZ  X20, #0xac5, LSL #0
    MOVK  X20, #0x9311, LSL #16
    MOVK  X20, #0xf0a7, LSL #32
    MOVK  X20, #0x4c31, LSL #48
    MOVZ  X21, #0xffbb, LSL #0
    MOVK  X21, #0xced0, LSL #16
    MOVK  X21, #0xfda2, LSL #32
    MOVK  X21, #0xa0e7, LSL #48
    MOVZ  X22, #0x6ada, LSL #0
    MOVK  X22, #0x1ab9, LSL #16
    MOVK  X22, #0xbe49, LSL #32
    MOVK  X22, #0xedc9, LSL #48
    MOVZ  X23, #0x8173, LSL #0
    MOVK  X23, #0xc878, LSL #16
    MOVK  X23, #0x17e7, LSL #32
    MOVK  X23, #0xa7b0, LSL #48
    MOVZ  X25, #0x5b90, LSL #0
    MOVK  X25, #0xde7e, LSL #16
    MOVK  X25, #0x8072, LSL #32
    MOVK  X25, #0xdeb3, LSL #48
    MOVZ  X26, #0x3a62, LSL #0
    MOVK  X26, #0x1ac1, LSL #16
    MOVK  X26, #0x8d91, LSL #32
    MOVK  X26, #0xdcb2, LSL #48
    MOVZ  X27, #0x127d, LSL #0
    MOVK  X27, #0xb891, LSL #16
    MOVK  X27, #0x94e4, LSL #32
    MOVK  X27, #0xf36c, LSL #48
    MOVZ  X28, #0x60f7, LSL #0
    MOVK  X28, #0x725f, LSL #16
    MOVK  X28, #0xe4bb, LSL #32
    MOVK  X28, #0x946e, LSL #48
    MOVZ  X29, #0xc83f, LSL #0
    MOVK  X29, #0xc3ba, LSL #16
    MOVK  X29, #0x7cfd, LSL #32
    MOVK  X29, #0x9295, LSL #48
    MOVZ  X9, #0xa, LSL #0
TaishanIntAluP02_label_409:
    LSLV  X21, X29, X28
    CRC32CH  W17, W5, W8
    ADDS  X17, X9, X5, LSL #39
    BIC  V20.16B, V11.16B, V15.16B
    EOR  W26, W26, #0xfc00000
    ANDS  W18, W14, W17, LSL #6
    CSNEG  W5, W29, W2, CC
    SMULH  X27, X16, X21
    MOVK  X19, #0xa384, LSL #0
    ADDS  X26, X14, #0x3ab
    ADDS  W17, W3, W27, SXTX #4
    CRC32CH  W26, W19, W18
    ORR  V31.8B, V3.8B, V14.8B
    EOR  X17, X6, X13, LSL #62
    EOR  X21, X14, X23, LSR #25
    BIC  X5, X26, X23, ROR #5
    ADC  W21, W7, W7
    CSNEG  W15, W26, W5, GE
    ORR  V12.2S, #0x4c, LSL #24
    ADD  W23, W13, W19, LSR #17
    CRC32B  W19, W14, W2
    LSRV  X25, X14, X8
    SBFM  X20, X22, #0x3b, #0xd
    SUBS  X20, X19, #0xdd3, LSL #12
    BICS  W20, W3, W19, ASR #0
    ADC  W8, W21, W12
    AND  W4, W11, #0x3ff8
    ADD  X4, X21, W22, UXTH #2
    CLS  X17, X15
    ANDS  W6, W19, #0x1e001e
    ORR  W20, W25, W12, ROR #27
    ORN  X21, X6, X6, LSR #31
    ADD  W18, W3, #0x347
    ANDS  W3, W8, W22, LSR #23
    SUBS  X21, X22, W15, UXTW #3
    ASRV  X19, X23, X2
    ADD  W4, W19, W12, LSR #18
    SUBS  W25, W26, W9, UXTB #4
    CLZ  V25.16B, V8.16B
    BICS  W7, W17, W19, ASR #0
    CSINV  X14, X20, X10, EQ
    ADD  X8, X5, #0xc3c
    CLZ  X28, X22
    SMADDL  X19, W13, W7, X22
    EOR  X22, X2, X5, ROR #19
    BIC  W8, W4, W7, LSR #22
    MADD  W26, W18, W19, W14
    ORR  X5, X25, X3, ROR #38
    UBFM  W12, W11, #0x1, #0x19
    EXTR  W5, W13, W3, #0x3
    ADD  W28, W21, W9, SXTB #0
    ADCS  X3, X11, X11
    ADD  X28, X21, X4, ASR #40
    EOR  W2, W22, W10, ROR #30
    ADDS  W15, W11, W22, UXTX #3
    CLS  W29, W20
    CLZ  X29, X3
    ADC  W8, W18, W28
    ANDS  W27, W29, #0x7ffc00
    BICS  W29, W11, W29, LSR #21
    ADCS  X6, X22, X27
    MOVZ  X2, #0xfd03, LSL #48
    CSINC  X27, X12, X12, VC
    CRC32B  W16, W13, W17
    SUB  W25, W21, W16, ASR #18
    SUBS  W20, W5, #0x378
    ADCS  X5, X3, X20
    CSINV  W21, W25, W29, LS
    SUB  W13, W2, W6, UXTW #0
    EOR  W23, W27, W23, ASR #8
    SUBS  X11, X21, X15, ASR #24
    SUB  W7, W23, W2, ASR #9
    UMSUBL  X28, W11, W7, X11
    MADD  W8, W12, W20, W8
    CRC32H  W17, W23, W16
    SUB  W27, W18, W16, UXTW #0
    SBFM  X3, X26, #0x10, #0x3a
    BICS  X23, X5, X7, ASR #33
    SMULH  X16, X28, X8
    CSINV  W25, W29, W18, NE
    ORN  X13, X29, X29, ROR #32
    CRC32CB  W17, W29, W6
    CLS  W22, W19
    EXTR  W27, W15, W22, #0x8
    MADD  X13, X8, X17, X6
    ADD  X11, X13, W13, UXTB #3
    CRC32W  W21, W3, W20
    AND  W28, W26, W15, ROR #13
    SBFM  X11, X26, #0x3c, #0x18
    ADDS  W13, W19, W22, LSL #21
    CRC32H  W11, W10, W6
    BICS  W23, W23, W13, ROR #13
    MOVZ  X27, #0xc537, LSL #32
    UMULH  X15, X5, X21
    SUBS  X11, X25, X16, LSL #34
    MOVK  W28, #0x65bf, LSL #16
    ASRV  W15, W7, W5
    BIC  W2, W2, W21, ASR #14
    ANDS  X3, X2, X19, ROR #53
    CRC32B  W26, W3, W28
    CRC32CX  W18, W26, X3
    CRC32W  W25, W14, W18
    CRC32CB  W4, W28, W12
    SMULH  X16, X22, X9
    SUBS  X19, X12, X26, SXTX #2
    ORN  X4, X12, X11, ROR #18
    MOVN  X4, #0xe8c, LSL #16
    EOR  W21, W25, #0xfffe7fff
    UMSUBL  X25, W16, W20, X4
    SUB  X15, X7, X23, LSR #4
    CSNEG  W18, W27, W21, NV
    CRC32CH  W8, W28, W12
    CLS  V23.16B, V13.16B
    LSLV  X12, X15, X26
    CSNEG  W25, W18, W8, CC
    SUB  W25, W19, W28, LSL #18
    CSINV  X14, X25, X13, LS
    ADD  X26, X23, #0x680
    LSRV  X25, X13, X6
    LSLV  W25, W26, W19
    ADDS  W2, W9, W2, LSL #1
    ORN  W16, W22, W25, LSR #7
    SUBS  X7, X4, W9, SXTW #3
    AND  W14, W11, W28, ROR #26
    LSRV  X10, X12, X15
    ADDS  X17, X10, #0x423
    CSINC  X3, X17, X2, GT
    ADDS  W15, W14, #0x710, LSL #12
    ANDS  X13, X13, X13, ASR #17
    ADCS  W15, W25, W27
    CRC32X  W29, W13, X17
    SUBS  X19, X10, W10, SXTB #2
    MOVK  W15, #0xca48, LSL #0
    ADCS  X19, X26, X17
    SBFM  W17, W23, #0x1, #0x18
    CLZ  W15, W23
    MOVN  W27, #0x56de, LSL #0
    ORR  V16.4H, #0x84
    ORR  W17, W15, W13, ROR #20
    BIC  V10.8B, V27.8B, V5.8B
    MOVZ  X29, #0xdf2c, LSL #32
    CRC32CH  W6, W3, W3
    CLS  W4, W25
    ADD  X23, X9, W3, SXTB #0
    AND  X8, X28, X14, LSR #12
    BIC  W16, W27, W2, ROR #0
    UBFM  W10, W25, #0x5, #0x8
    UBFM  X25, X20, #0x3c, #0x19
    CRC32CH  W23, W16, W22
    SMSUBL  X18, W7, W2, X21
    SUB  X26, X3, W13, UXTW #3
    SUBS  W28, W4, W12, ASR #24
    ADCS  X11, X7, X8
    ADDS  X21, X7, W15, UXTB #4
    ASRV  X25, X7, X17
    ORN  W27, W29, W11, LSR #31
    CRC32CB  W5, W9, W20
    SUB  W6, W23, #0xab0
    ORR  W16, W27, #0x1f8
    EXTR  X26, X27, X6, #0x10
    LSRV  W3, W28, W18
    LSLV  X18, X25, X11
    EOR  X16, X21, X6, LSL #60
    SUBS  W16, W4, #0x319
    ADD  W10, W6, W16, LSR #6
    CRC32B  W16, W4, W4
    SUB  W14, W18, W10, UXTB #4
    ADD  X29, X22, #0xb3b, LSL #12
    AND  W6, W20, #0xffff001f
    CLS  X26, X6
    ANDS  X22, X15, #0xf07ffffff07fffff
    ANDS  X12, X6, X22, LSL #41
    CRC32H  W14, W15, W26
    AND  W25, W3, W20, LSL #11
    CLS  X19, X25
    SMSUBL  X8, W13, W28, X14
    SUB  W12, W16, #0x222
    SBFM  W25, W10, #0x1a, #0x8
    AND  X11, X11, #0x1c0000000
    MADD  W22, W15, W12, W3
    CSINC  W23, W13, W12, VS
    MOVZ  W20, #0xee35, LSL #16
    EXTR  W29, W27, W27, #0x17
    CSNEG  W6, W29, W21, HI
    UMSUBL  X11, W16, W7, X23
    SUBS  W22, W10, W13, LSL #4
    UBFM  W11, W22, #0x15, #0x12
    ADCS  X26, X28, X28
    CLS  X21, X10
    UMADDL  X17, W13, W22, X22
    ASRV  W7, W12, W23
    CRC32B  W21, W21, W27
    EON  W5, W2, W14, ASR #31
    LSRV  X20, X23, X3
    ANDS  W21, W15, #0xff80000
    EXTR  X7, X4, X13, #0x8
    UMULH  X14, X20, X9
    SUB  W28, W15, W29, SXTX #0
    CRC32CB  W16, W26, W28
    MOVZ  W14, #0x1078, LSL #0
    SUBS  X9, X9, #0x1
    B.NE  TaishanIntAluP02_label_409
    MOVZ  X17, #0x1, LSL #0
    SUB  X28, X17, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X5, X19, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X18, #0xfff9, LSL #0
    MOVK  X18, #0xe8b, LSL #16
    SUB  X6, X18, X6
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X20, #0x54, LSL #0
    SUB  X27, X20, X7
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X27, #0x86f2, LSL #0
    MOVK  X27, #0x957f, LSL #16
    SUB  X28, X27, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X18, #0x67da, LSL #0
    MOVK  X18, #0xa972, LSL #16
    SUB  X13, X18, X10
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X22, X21, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x1078, LSL #0
    SUB  X2, X16, X14
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X21, #0x1, LSL #0
    SUB  X22, X21, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x1078, LSL #0
    SUB  X11, X2, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X7, #0x1, LSL #0
    SUB  X25, X7, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X23, #0x67da, LSL #0
    MOVK  X23, #0xa972, LSL #16
    SUB  X10, X23, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X10, X4, X19
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x1, LSL #0
    SUB  X19, X5, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X11, X3, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X26, #0x67da, LSL #0
    MOVK  X26, #0xa972, LSL #16
    SUB  X8, X26, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP02_TestFail
    MOVZ  X14, #0x67da, LSL #0
    MOVK  X14, #0xa972, LSL #16
    SUB  X17, X14, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X15, #0xa, LSL #0
TaishanIntAluP02_label_434:
    ORR  V27.8B, V17.8B, V12.8B
    ADD  W13, W16, #0xe30
    EOR  W25, W13, W2
    ASRV  X12, X23, X22
    UMADDL  X23, W27, W14, X14
    ORR  V1.4H, #0xe5, LSL #8
    CLZ  W17, W8
    EOR  X29, X20, #0xfffffffffe00
    ADD  X8, X21, W3, SXTH #4
    ADD  X10, X7, X8, LSR #37
    EOR  W6, W3, W19, LSR #26
    CRC32B  W25, W29, W14
    MADD  W29, W21, W17, W8
    ADD  W26, W29, W12, UXTB #1
    SUB  X17, X13, #0xd30, LSL #12
    SUB  W12, W11, W21, LSL #2
    SUB  W26, W18, W2, LSL #17
    EOR  W14, W16, W22, LSL #10
    AND  W8, W15, #0x1ff01ff
    CRC32X  W4, W22, X26
    MADD  W9, W2, W17, W25
    ORN  X10, X20, X11, ASR #25
    SMULH  X13, X23, X13
    SUBS  X11, X16, #0x5ce, LSL #12
    SBFM  W22, W6, #0x18, #0x18
    CSEL  X14, X9, X23, MI
    CRC32H  W14, W27, W14
    AND  W17, W15, W4, LSR #1
    SUBS  X22, X15, W10, UXTB #2
    ADDS  W14, W26, #0x721
    MOVN  W18, #0xafe0, LSL #0
    CSNEG  X29, X11, X23, LE
    UBFM  W7, W19, #0x13, #0xa
    CLZ  W12, W19
    EON  W19, W8, W2, ROR #28
    CLZ  V12.16B, V24.16B
    SUBS  W22, W9, W5, SXTX #3
    CSNEG  X3, X3, X13, MI
    CLZ  W23, W17
    UMADDL  X6, W8, W15, X8
    LSLV  X28, X11, X7
    ORR  W18, W16, #0xcfffffff
    ANDS  X27, X22, #0x7fffffffffc00
    CRC32W  W17, W5, W14
    ADCS  X18, X19, X14
    EXTR  X4, X4, X20, #0x28
    EXTR  W9, W28, W25, #0x7
    ANDS  X7, X28, #0xf0000000003fffff
    ORN  X18, X21, X25, ASR #9
    EOR  W22, W3, W11, ROR #21
    CSINC  W20, W9, W23, GE
    ADDS  W13, W19, W25, ASR #18
    ANDS  X18, X7, X27, LSR #63
    CLZ  X12, X4
    ORR  W20, W28, W25, LSR #14
    ORR  V22.4H, #0x7f, LSL #8
    ASRV  X8, X23, X14
    CRC32CW  W9, W17, W15
    CSNEG  W16, W3, W16, AL
    CLZ  V15.2S, V27.2S
    CRC32CW  W19, W29, W21
    SBFM  X11, X29, #0x9, #0x1
    EON  W20, W25, W10, LSR #19
    ADD  X11, X7, X22, SXTX #4
    AND  X7, X20, X3, ROR #56
    ANDS  W3, W26, W23, LSR #13
    EXTR  X5, X28, X7, #0x35
    CSEL  W13, W3, W18, CS
    ANDS  W12, W11, W13, LSR #7
    ANDS  X22, X9, #0xc1c1c1c1c1c1c1c1
    LSLV  X5, X5, X3
    CRC32CB  W29, W21, W26
    EON  W14, W8, W8, LSR #31
    SBFM  W27, W6, #0x5, #0x1d
    BIC  V4.16B, V30.16B, V21.16B
    CSEL  W29, W5, W4, GE
    CLS  W26, W21
    UMULH  X12, X27, X4
    SMSUBL  X12, W28, W6, X3
    BIC  V7.8B, V3.8B, V24.8B
    ORR  V25.2S, #0xc6
    LSRV  X18, X14, X18
    CRC32CB  W11, W15, W4
    ORN  W10, W9, W26, ROR #4
    CSNEG  W2, W15, W16, LS
    ADDS  W25, W12, W8, LSL #25
    ADD  W17, W12, W7, LSR #20
    MADD  X2, X23, X29, X3
    BIC  V1.8B, V26.8B, V19.8B
    ADCS  X11, X13, X16
    ORR  V22.4S, #0x6e
    SMADDL  X18, W17, W23, X19
    ADDS  W10, W20, W19, ASR #17
    ORR  X18, X14, #0xfe00001fffffffff
    ADD  W10, W25, #0xa80
    ADDS  X2, X26, X4, ASR #15
    CSEL  W2, W5, W29, NE
    SUBS  X13, X6, #0x60
    ADD  X11, X20, #0x383, LSL #12
    CRC32CH  W11, W20, W8
    SBFM  X10, X23, #0x9, #0x28
    SUBS  W2, W16, #0x8d8, LSL #12
    MOVZ  X3, #0x3a11, LSL #16
    CSINC  W14, W17, W7, LT
    CRC32B  W5, W11, W18
    SMADDL  X8, W10, W11, X13
    CSEL  X7, X8, X6, AL
    ORN  X22, X3, X22, LSL #29
    CLS  W3, W22
    CSINC  X9, X22, X11, HI
    ADDS  X22, X9, W18, UXTB #3
    CSEL  X17, X14, X25, GE
    MOVK  W22, #0xfbaf, LSL #16
    MOVN  W5, #0x72d4, LSL #16
    ANDS  X27, X10, #0xfe00000ffe00000f
    CSNEG  X25, X2, X27, VC
    LSLV  W27, W22, W14
    EOR  W3, W5, W27, LSR #13
    SUB  X18, X25, W23, UXTB #0
    MOVZ  W13, #0x4ec1, LSL #0
    UMADDL  X26, W17, W17, X8
    SUB  W9, W26, #0xaff, LSL #12
    CRC32CB  W9, W26, W14
    UMADDL  X2, W11, W26, X6
    CSEL  W3, W28, W7, AL
    SBFM  X11, X11, #0x3e, #0x27
    ORR  W18, W13, #0xfc0000
    CSINV  W8, W7, W11, GE
    MOVK  W5, #0x2c4b, LSL #16
    CRC32CW  W2, W20, W19
    SUB  W26, W6, W27, SXTB #3
    MADD  X3, X8, X26, X11
    EOR  W12, W6, W21, ROR #7
    ORR  V15.16B, V2.16B, V8.16B
    ADD  W10, W4, #0x760
    CRC32X  W29, W22, X28
    ADD  X2, X18, X7, LSR #52
    ORR  X2, X5, #0xffffff000000001f
    ADD  W6, W10, #0x257
    EOR  W2, W4, #0xf8001fff
    BIC  X18, X16, X22, ASR #19
    AND  W12, W27, W25, ASR #16
    MOVK  X21, #0xaa4f, LSL #0
    SUBS  W29, W4, #0x861, LSL #12
    EXTR  W27, W5, W23, #0x15
    LSRV  X10, X26, X4
    LSLV  X13, X14, X2
    MOVZ  X29, #0x4847, LSL #32
    CLZ  W4, W18
    SUB  W28, W25, W10, UXTB #1
    SUBS  X21, X15, #0x0
    MADD  X5, X23, X4, X5
    CRC32H  W17, W6, W9
    MADD  W23, W15, W28, W20
    AND  W5, W3, #0xffffffe3
    EXTR  X20, X4, X12, #0xa
    SUB  X7, X28, W9, SXTH #3
    SUB  X26, X7, X13, ASR #35
    ORR  V18.4S, #0x4e, LSL #8
    CLZ  V2.8B, V3.8B
    CLZ  V10.8H, V22.8H
    ADD  X29, X12, X14, LSR #29
    AND  X12, X6, X22, ASR #9
    ADDS  X3, X17, X27, UXTX #3
    CSINC  W6, W4, W26, VS
    ASRV  X10, X3, X21
    AND  W10, W6, #0xfc0007ff
    SUBS  W26, W29, W16, SXTW #2
    SMSUBL  X16, W20, W15, X18
    CLZ  W5, W12
    CLZ  V18.16B, V20.16B
    SUB  W9, W12, W12, UXTH #2
    MADD  W7, W13, W14, W16
    BIC  W13, W9, W26, LSL #5
    EXTR  W27, W29, W7, #0x1
    MOVK  X29, #0x48e2, LSL #32
    ADD  W4, W6, W6, LSR #29
    ORN  W6, W6, W29, LSL #9
    ASRV  X8, X4, X8
    ADD  W8, W10, W27, LSL #18
    UBFM  X3, X6, #0x1a, #0x3d
    ORR  X29, X5, X14, ROR #43
    ORR  V12.16B, V28.16B, V20.16B
    EON  X7, X4, X20, LSR #14
    CSINV  X13, X17, X26, LE
    ORR  V18.2S, #0x45, LSL #24
    CRC32B  W3, W8, W10
    CLS  X10, X29
    SUB  W4, W20, W20, ASR #18
    MOVN  X7, #0xdd59, LSL #48
    CRC32B  W13, W3, W3
    SUB  W10, W10, W25, LSR #24
    BIC  X10, X4, X4, ROR #2
    UMULH  X9, X8, X25
    CRC32CW  W5, W12, W15
    MOVN  W23, #0x7afd, LSL #16
    ADCS  X20, X27, X16
    ADDS  X23, X4, W17, UXTH #3
    SUBS  W28, W7, W28, UXTX #1
    ADD  X13, X3, #0x25f
    SUBS  X15, X15, #0x1
    B.NE  TaishanIntAluP02_label_434
    MOVZ  X8, #0x1fff, LSL #0
    MOVK  X8, #0x3f00, LSL #16
    SUB  X9, X8, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X10, #0x7c01, LSL #0
    MOVK  X10, #0xe5, LSL #16
    SUB  X29, X10, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP02_TestFail
    MOVZ  X3, #0xebb2, LSL #0
    MOVK  X3, #0x3e, LSL #16
    SUB  X2, X3, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X10, #0x78c0, LSL #0
    MOVK  X10, #0x4886, LSL #16
    SUB  X23, X10, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X25, #0x5dff, LSL #0
    MOVK  X25, #0xfff3, LSL #16
    SUB  X17, X25, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0x22a6, LSL #48
    SUB  X26, X18, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X4, #0x1fff, LSL #0
    MOVK  X4, #0x3f00, LSL #16
    SUB  X21, X4, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X4, X6, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X3, #0x78c0, LSL #0
    MOVK  X3, #0x4886, LSL #16
    SUB  X6, X3, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X4, #0x2ef8, LSL #0
    MOVK  X4, #0x7451, LSL #16
    MOVK  X4, #0x2, LSL #32
    SUB  X2, X4, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X11, #0x183, LSL #0
    SUB  X19, X11, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X28, #0x7e60, LSL #0
    MOVK  X28, #0xe5, LSL #16
    SUB  X23, X28, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x4880, LSL #0
    MOVK  X16, #0xff25, LSL #16
    SUB  X14, X16, X14
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X15
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X23, #0x4880, LSL #0
    MOVK  X23, #0xff25, LSL #16
    SUB  X22, X23, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0x22a6, LSL #48
    SUB  X15, X22, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X2, X29, X19
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X3, X25, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0x22a6, LSL #48
    SUB  X27, X18, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X15, #0x4880, LSL #0
    MOVK  X15, #0xff25, LSL #16
    SUB  X6, X15, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X26
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X18, #0x7e60, LSL #0
    MOVK  X18, #0xe5, LSL #16
    SUB  X25, X18, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP02_TestFail
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
    MOVZ  X10, #0xa, LSL #0
TaishanIntAluP02_label_456:
    EON  X26, X12, X9, ASR #33
    ADDS  W5, W20, W17, ASR #24
    ADD  X12, X16, #0x78b
    CRC32B  W23, W18, W21
    EOR  X19, X17, #0x7ffe00
    SBFM  W19, W9, #0x0, #0x1e
    LSLV  W4, W27, W26
    MADD  W21, W23, W6, W20
    EON  W28, W15, W5, LSR #17
    ADDS  X7, X2, #0xc83, LSL #12
    UBFM  W25, W23, #0x1f, #0x1e
    CSINV  X4, X28, X10, NV
    ADC  X8, X19, X14
    SMSUBL  X7, W16, W21, X21
    ORR  V3.8B, V22.8B, V29.8B
    UBFM  X27, X23, #0x16, #0x2d
    ANDS  X23, X7, #0xfff03fffffffffff
    CLS  W23, W5
    CSEL  X2, X8, X12, CS
    ANDS  W25, W26, #0x80008000
    BIC  X23, X27, X8, ROR #60
    SUBS  W18, W17, W23, LSR #20
    SUBS  W28, W10, #0x9b7, LSL #12
    SMADDL  X14, W25, W8, X13
    SMULH  X17, X15, X28
    CSINC  X23, X7, X19, NE
    SBFM  X18, X4, #0x24, #0x0
    EOR  W23, W11, #0x8001ffff
    EOR  X6, X21, X28, LSR #46
    EON  W6, W29, W11, LSL #8
    CSNEG  W12, W11, W7, PL
    ANDS  X3, X10, X15, ROR #45
    CRC32X  W21, W12, X4
    CRC32H  W13, W2, W27
    ORR  X4, X18, #0x70000000700
    EOR  X28, X13, X9, LSL #23
    LSLV  X18, X21, X26
    CSINV  X25, X23, X19, CC
    UBFM  X29, X4, #0x36, #0x33
    SUBS  X22, X10, W4, UXTH #1
    ASRV  W18, W11, W29
    ADDS  X17, X3, W15, SXTW #4
    ADC  W27, W14, W3
    EOR  W28, W28, #0xe00007ff
    MOVN  W18, #0xf991, LSL #0
    MOVK  W19, #0xbf, LSL #0
    UMSUBL  X29, W29, W16, X11
    UMSUBL  X23, W14, W4, X2
    SUBS  X2, X11, X27, LSL #47
    ORR  W21, W25, #0xfff87fff
    ADDS  X22, X22, W6, SXTB #2
    UMULH  X11, X28, X18
    EXTR  W25, W19, W28, #0x1c
    CLZ  X29, X14
    UBFM  W18, W6, #0xb, #0x1e
    MOVZ  X2, #0x53a1, LSL #32
    EOR  X11, X9, #0xfffffffffffff001
    SMULH  X6, X9, X27
    MOVZ  W28, #0x981e, LSL #16
    SBFM  W18, W5, #0x1f, #0xf
    CRC32H  W2, W3, W7
    LSLV  W11, W25, W16
    UMULH  X16, X27, X25
    CRC32CB  W5, W23, W18
    MOVZ  X11, #0xcb25, LSL #48
    EON  X21, X27, X8, LSL #41
    ORR  X29, X21, #0x800000008
    CSINC  X15, X29, X6, HI
    ASRV  W27, W5, W5
    CSINC  X19, X22, X19, VS
    CRC32CB  W19, W15, W5
    CRC32X  W22, W28, X23
    CRC32CX  W13, W16, X25
    ASRV  W27, W16, W18
    SUBS  X8, X21, X14, ASR #38
    CSINC  W8, W18, W2, EQ
    BIC  W18, W8, W5, LSR #15
    AND  W29, W18, #0x7c0000
    CRC32CB  W15, W25, W3
    LSRV  W9, W25, W7
    EOR  X21, X22, X25, ASR #54
    UBFM  X8, X27, #0x31, #0x12
    BICS  W3, W17, W14, LSR #15
    CSINC  W12, W15, W8, NE
    BIC  W14, W9, W11, LSL #14
    SUB  X20, X29, X25, LSR #62
    ANDS  W6, W20, #0xc7c7c7c7
    CRC32H  W21, W13, W21
    CSNEG  X21, X4, X23, VC
    ORR  W4, W12, W17, LSR #11
    ADDS  X15, X22, #0x661, LSL #12
    CRC32B  W6, W7, W2
    ADD  X20, X29, #0xed0, LSL #12
    ORN  X19, X3, X13, ASR #18
    SMULH  X20, X6, X21
    ADD  X17, X19, W28, UXTH #1
    EON  X23, X14, X4, ROR #37
    MADD  X7, X3, X15, X23
    CLZ  X7, X7
    EOR  W21, W29, W18, LSR #29
    CSINC  X19, X17, X21, NV
    SBFM  W20, W20, #0x3, #0xa
    ADDS  W17, W2, W19, LSR #7
    SMULH  X20, X9, X7
    ADDS  X22, X27, X20
    BIC  V20.16B, V6.16B, V3.16B
    ORR  V25.8H, #0x9f, LSL #8
    ADD  W20, W11, W3, UXTW #0
    MADD  W28, W17, W4, W3
    SUBS  W27, W19, #0x5cf
    MOVN  X8, #0x5258, LSL #16
    ORR  X11, X26, #0xffffffff8007ffff
    SUBS  W11, W12, #0x7fd
    ORR  V26.16B, V0.16B, V19.16B
    ANDS  W7, W9, #0x1fffc0
    SUB  W22, W23, W22, SXTW #4
    SUBS  X21, X13, X21, LSR #54
    ADDS  W8, W6, #0x48e, LSL #12
    EON  W17, W4, W20, LSL #18
    EOR  X17, X16, #0xffffffffe0000003
    BICS  X23, X9, X11, ROR #58
    EOR  W12, W3, #0x100000
    ADDS  X12, X6, #0xc80
    MOVN  W29, #0xaeec, LSL #16
    SUB  X29, X3, #0xa3c
    BIC  W25, W6, W9, LSL #18
    ADCS  W27, W18, W3
    UBFM  W16, W23, #0x1c, #0x2
    CLZ  W29, W7
    SUB  W20, W28, W5, SXTB #4
    BICS  W8, W2, W25, LSL #10
    ORR  X7, X7, #0xfffffffff0
    UBFM  X2, X16, #0x3c, #0x15
    LSLV  W29, W8, W16
    ORR  V5.4S, #0x46
    BIC  V30.8B, V6.8B, V26.8B
    ADDS  W28, W10, W11, LSR #27
    CSINC  X27, X12, X12, NV
    CLS  W9, W18
    EON  X23, X25, X4
    CSINC  W26, W29, W2, MI
    ADDS  X12, X28, X26, SXTX #2
    UBFM  W23, W15, #0x1c, #0x15
    ADCS  X12, X29, X10
    ORR  V24.8B, V2.8B, V12.8B
    ORN  X4, X21, X29, ASR #19
    UBFM  W9, W13, #0xe, #0x8
    AND  X5, X18, X10, ROR #12
    AND  W18, W18, #0xfe00fe00
    BICS  X3, X8, X2, ASR #29
    ADCS  W8, W26, W8
    MADD  X12, X10, X6, X7
    ADDS  X9, X3, W18, SXTW #1
    SUB  W6, W5, W15, SXTB #2
    ADD  W13, W7, #0x19b
    UBFM  W17, W6, #0x7, #0x4
    ADD  W4, W3, #0xecb
    LSLV  W15, W15, W15
    BICS  W4, W16, W27, ROR #15
    LSLV  W12, W8, W4
    CLZ  V7.16B, V15.16B
    BICS  W13, W27, W29, LSR #7
    BICS  W16, W4, W26, ASR #26
    CLZ  V8.8B, V7.8B
    BICS  X4, X17, X15, ASR #50
    CRC32W  W9, W12, W17
    SUB  X25, X5, #0x570, LSL #12
    CRC32CH  W9, W19, W20
    CSINV  X7, X13, X17, AL
    SUBS  W27, W6, W27, UXTW #0
    CRC32CB  W22, W23, W27
    CSINC  X23, X29, X28, LS
    SBFM  W2, W9, #0x1, #0x7
    UMULH  X9, X14, X5
    CSINC  W21, W12, W20, EQ
    CSINC  W6, W9, W28, GT
    MOVK  W18, #0xcbbc, LSL #0
    ANDS  W12, W6, #0xfffe0000
    CSNEG  X13, X18, X3, HI
    MOVZ  W12, #0x2f3f, LSL #16
    MOVK  X29, #0xa0cb, LSL #48
    SMADDL  X27, W25, W6, X15
    CRC32CX  W3, W27, X15
    SUB  W18, W21, W22, ASR #21
    CRC32W  W20, W5, W19
    CRC32CX  W29, W26, X29
    EON  X5, X6, X7, LSL #31
    ORN  X26, X8, X11, ASR #39
    SUB  X16, X18, #0x1e8, LSL #12
    BIC  X22, X5, X12, LSL #41
    ANDS  X16, X4, #0x1fffffc000
    LSLV  W20, W19, W14
    SMULH  X26, X5, X21
    MOVZ  W19, #0x43ae, LSL #16
    BIC  X7, X23, X20, ROR #27
    ORN  W20, W9, W27, LSR #0
    UBFM  X2, X27, #0x14, #0x30
    CRC32CX  W25, W22, X6
    AND  X13, X10, X6, LSR #19
    ADD  W14, W28, W3, UXTH #2
    SUBS  X10, X10, #0x1
    B.NE  TaishanIntAluP02_label_456
    MOVZ  X11, #0xdd0, LSL #0
    SUB  X10, X11, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X11, #0x3da, LSL #0
    MOVK  X11, #0xa2d5, LSL #16
    SUB  X25, X11, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x1000, LSL #16
    SUB  X21, X29, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP02_TestFail
    MOVZ  X19, #0xffe6, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xf9c2, LSL #32
    MOVK  X19, #0xffd7, LSL #48
    SUB  X8, X19, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP02_TestFail
    MOVZ  X15, #0x19, LSL #0
    SUB  X21, X15, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP02_TestFail
    MOVZ  X27, #0x2e0, LSL #0
    MOVK  X27, #0x8000, LSL #16
    SUB  X9, X27, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP02_TestFail
    MOVZ  X28, #0x3da, LSL #0
    MOVK  X28, #0xa2d5, LSL #16
    SUB  X5, X28, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x2f3f, LSL #16
    SUB  X26, X3, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X29, #0xf80, LSL #0
    SUB  X22, X29, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X7, #0x19, LSL #0
    SUB  X5, X7, X15
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x1000, LSL #16
    SUB  X5, X16, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X17
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP02_TestFail
    MOVZ  X29, #0xf7e9, LSL #0
    MOVK  X29, #0x5c40, LSL #16
    SUB  X25, X29, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X22, #0xffe6, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xf9c2, LSL #32
    MOVK  X22, #0xffd7, LSL #48
    SUB  X3, X22, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0x22fe, LSL #16
    SUB  X18, X3, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X13, #0xffe6, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xf9c2, LSL #32
    MOVK  X13, #0xffd7, LSL #48
    SUB  X22, X13, X22
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X15, #0x2ff, LSL #0
    MOVK  X15, #0x8000, LSL #16
    SUB  X9, X15, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X26
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP02_TestFail
    MOVZ  X11, #0x2e0, LSL #0
    MOVK  X11, #0x8000, LSL #16
    SUB  X14, X11, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X25, #0x3da, LSL #0
    MOVK  X25, #0xa2d5, LSL #16
    SUB  X14, X25, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x6987, LSL #0
    MOVK  X2, #0x8bd0, LSL #16
    MOVK  X2, #0xfc6b, LSL #32
    MOVK  X2, #0x99aa, LSL #48
    MOVZ  X3, #0x94d1, LSL #0
    MOVK  X3, #0x12f4, LSL #16
    MOVK  X3, #0xa44a, LSL #32
    MOVK  X3, #0xf980, LSL #48
    MOVZ  X4, #0x80c2, LSL #0
    MOVK  X4, #0x5021, LSL #16
    MOVK  X4, #0x832b, LSL #32
    MOVK  X4, #0xa20f, LSL #48
    MOVZ  X5, #0xeeef, LSL #0
    MOVK  X5, #0x11e1, LSL #16
    MOVK  X5, #0xfdeb, LSL #32
    MOVK  X5, #0x2843, LSL #48
    MOVZ  X6, #0xc13e, LSL #0
    MOVK  X6, #0x5220, LSL #16
    MOVK  X6, #0xf2c2, LSL #32
    MOVK  X6, #0xdf3, LSL #48
    MOVZ  X7, #0xe495, LSL #0
    MOVK  X7, #0x5792, LSL #16
    MOVK  X7, #0x89e4, LSL #32
    MOVK  X7, #0x2862, LSL #48
    MOVZ  X8, #0x469e, LSL #0
    MOVK  X8, #0x998a, LSL #16
    MOVK  X8, #0x4240, LSL #32
    MOVK  X8, #0x91d6, LSL #48
    MOVZ  X9, #0x73e3, LSL #0
    MOVK  X9, #0xac2a, LSL #16
    MOVK  X9, #0x9c15, LSL #32
    MOVK  X9, #0x14c7, LSL #48
    MOVZ  X10, #0x3842, LSL #0
    MOVK  X10, #0x6087, LSL #16
    MOVK  X10, #0xfded, LSL #32
    MOVK  X10, #0xb4e5, LSL #48
    MOVZ  X11, #0x27e8, LSL #0
    MOVK  X11, #0x7b5a, LSL #16
    MOVK  X11, #0x5fe9, LSL #32
    MOVK  X11, #0x94c6, LSL #48
    MOVZ  X12, #0x4a9c, LSL #0
    MOVK  X12, #0x5bb6, LSL #16
    MOVK  X12, #0xc0f, LSL #32
    MOVK  X12, #0xace6, LSL #48
    MOVZ  X13, #0x817d, LSL #0
    MOVK  X13, #0x9d17, LSL #16
    MOVK  X13, #0x80fe, LSL #32
    MOVK  X13, #0xcb0, LSL #48
    MOVZ  X14, #0x7bcc, LSL #0
    MOVK  X14, #0x505b, LSL #16
    MOVK  X14, #0x7e8d, LSL #32
    MOVK  X14, #0x6a30, LSL #48
    MOVZ  X15, #0xb5ed, LSL #0
    MOVK  X15, #0xf70f, LSL #16
    MOVK  X15, #0x86ea, LSL #32
    MOVK  X15, #0x1c30, LSL #48
    MOVZ  X16, #0x3630, LSL #0
    MOVK  X16, #0xfe4d, LSL #16
    MOVK  X16, #0x234, LSL #32
    MOVK  X16, #0x27e4, LSL #48
    MOVZ  X17, #0x2d26, LSL #0
    MOVK  X17, #0x2278, LSL #16
    MOVK  X17, #0xf886, LSL #32
    MOVK  X17, #0x812f, LSL #48
    MOVZ  X18, #0x2f16, LSL #0
    MOVK  X18, #0x1ec4, LSL #16
    MOVK  X18, #0x2d0c, LSL #32
    MOVK  X18, #0xdd01, LSL #48
    MOVZ  X19, #0x37a3, LSL #0
    MOVK  X19, #0x2b77, LSL #16
    MOVK  X19, #0x2590, LSL #32
    MOVK  X19, #0xf51f, LSL #48
    MOVZ  X20, #0x1216, LSL #0
    MOVK  X20, #0x8d57, LSL #16
    MOVK  X20, #0x6839, LSL #32
    MOVK  X20, #0x4cb7, LSL #48
    MOVZ  X21, #0xcc3f, LSL #0
    MOVK  X21, #0x18ca, LSL #16
    MOVK  X21, #0x809, LSL #32
    MOVK  X21, #0xa1ba, LSL #48
    MOVZ  X22, #0xd318, LSL #0
    MOVK  X22, #0x4489, LSL #16
    MOVK  X22, #0x91e, LSL #32
    MOVK  X22, #0xf93a, LSL #48
    MOVZ  X23, #0x927d, LSL #0
    MOVK  X23, #0x2f3a, LSL #16
    MOVK  X23, #0x31c, LSL #32
    MOVK  X23, #0x1683, LSL #48
    MOVZ  X25, #0xddd7, LSL #0
    MOVK  X25, #0x4541, LSL #16
    MOVK  X25, #0x5ecd, LSL #32
    MOVK  X25, #0x3f80, LSL #48
    MOVZ  X26, #0xc1d3, LSL #0
    MOVK  X26, #0x171b, LSL #16
    MOVK  X26, #0xd3b0, LSL #32
    MOVK  X26, #0x811, LSL #48
    MOVZ  X27, #0x2a68, LSL #0
    MOVK  X27, #0x9ace, LSL #16
    MOVK  X27, #0x6931, LSL #32
    MOVK  X27, #0x61d2, LSL #48
    MOVZ  X28, #0x31fd, LSL #0
    MOVK  X28, #0x1bf6, LSL #16
    MOVK  X28, #0x7ea1, LSL #32
    MOVK  X28, #0xf5fc, LSL #48
    MOVZ  X29, #0x5930, LSL #0
    MOVK  X29, #0x363b, LSL #16
    MOVK  X29, #0x42b2, LSL #32
    MOVK  X29, #0x1c3c, LSL #48
    MOVZ  X28, #0xa, LSL #0
TaishanIntAluP02_label_480:
    MADD  X25, X2, X27, X3
    ANDS  W25, W3, W26, LSL #3
    EON  X11, X15, X18, ROR #0
    EOR  X26, X25, #0xffffdfffffffdfff
    ASRV  W29, W13, W15
    CSINV  X5, X29, X26, VS
    MOVK  W19, #0xfadf, LSL #16
    SUB  W22, W8, #0x5d0, LSL #12
    CSINC  W20, W4, W2, VC
    CLZ  W17, W20
    ANDS  X4, X17, X23, ROR #47
    ANDS  W6, W25, #0x380
    SUBS  X6, X14, W28, UXTH #3
    BIC  W15, W25, W22, ASR #12
    CRC32CH  W29, W22, W22
    EXTR  X26, X19, X14, #0x2d
    SUB  W20, W10, W15, SXTW #3
    UMULH  X5, X7, X11
    LSRV  X5, X5, X14
    ADD  W21, W9, W4, LSR #8
    UBFM  X19, X17, #0x1c, #0x14
    BICS  X7, X11, X10, ROR #38
    MOVK  X9, #0xe24e, LSL #48
    UMSUBL  X26, W16, W19, X25
    LSRV  W4, W13, W9
    ADDS  X4, X20, #0x32c
    ORR  W6, W26, #0x3f003f
    ORN  W26, W15, W14, LSR #14
    AND  W11, W29, W26, LSR #0
    CSEL  X4, X18, X28, PL
    SMSUBL  X4, W18, W17, X22
    ADDS  X9, X22, W19, UXTH #1
    SBFM  X23, X29, #0x2a, #0x34
    SUB  X23, X15, W4, UXTW #0
    BIC  W12, W29, W21, LSL #16
    CRC32B  W23, W12, W14
    ADDS  W15, W29, #0x230, LSL #12
    EON  X26, X6, X21, ASR #15
    ADD  W18, W14, W13, LSL #6
    SUBS  X14, X20, W20, SXTB #3
    ADCS  W14, W18, W2
    ADD  X2, X11, X15, LSL #34
    ADDS  X13, X22, X10, SXTX #1
    CLZ  V31.8H, V25.8H
    EOR  X27, X22, #0x3ffc00000
    SBFM  X22, X16, #0x3b, #0x4
    ADD  X23, X22, W25, UXTH #4
    ASRV  X27, X28, X27
    ADDS  W29, W29, #0xd20
    ORR  W18, W9, #0x78000
    UMSUBL  X13, W4, W16, X8
    SUBS  X11, X12, X13, LSR #59
    ORR  X12, X29, X11, ASR #53
    CRC32X  W2, W23, X27
    CSEL  W22, W18, W4, EQ
    ADDS  W23, W27, #0x9b3, LSL #12
    SUB  X17, X22, #0x2b6
    CSNEG  W26, W22, W7, CS
    AND  W21, W11, #0x3f803f8
    SUB  X7, X22, #0xe09
    ORR  W12, W9, W12, LSR #20
    CSNEG  W20, W8, W4, MI
    EON  W10, W8, W18, ASR #16
    EXTR  X2, X13, X15, #0x35
    MOVZ  W16, #0xca24, LSL #0
    UBFM  X3, X23, #0x13, #0x3e
    CLZ  W27, W9
    ADDS  X17, X26, #0x4d0
    AND  X12, X7, X18, ASR #31
    EON  W26, W29, W15, ASR #3
    EON  W29, W29, W27, ASR #25
    EOR  X3, X29, #0x8000007f8000007f
    ASRV  W4, W19, W18
    BIC  X4, X14, X12, LSR #43
    EOR  W4, W21, W23
    ORR  V25.8H, #0x1d
    SUBS  X21, X11, X12, LSR #38
    CRC32CX  W16, W20, X8
    CLS  V6.2S, V28.2S
    ORR  V29.8H, #0x81
    EOR  X4, X6, X14, ASR #22
    SMSUBL  X2, W5, W6, X23
    ORR  X2, X29, #0x7fe000007fe00000
    ASRV  W22, W22, W29
    ADD  W26, W4, W10, ASR #26
    ADD  W3, W10, #0xe56
    CRC32CH  W16, W7, W6
    BIC  W26, W11, W22, ASR #3
    CRC32CB  W12, W21, W17
    CLS  X7, X9
    LSLV  W8, W9, W7
    ORN  W9, W11, W14, ASR #16
    SMADDL  X10, W6, W14, X12
    CLZ  V3.16B, V4.16B
    CSINC  W11, W8, W9, NV
    ORN  X22, X15, X4, ASR #53
    ANDS  W18, W18, #0x1ffe00
    CSINV  W7, W28, W19, GE
    ADD  W20, W28, W13, SXTX #4
    LSLV  W17, W28, W20
    SUB  W26, W2, #0x7b3, LSL #12
    ADD  X19, X27, X19, ASR #60
    CLS  X10, X28
    ORN  X5, X17, X21, LSL #8
    CLS  X16, X10
    ADD  W15, W16, #0xf18, LSL #12
    CLZ  W29, W21
    ORR  V17.8B, V30.8B, V19.8B
    CRC32CX  W11, W15, X7
    MOVZ  W18, #0xac3d, LSL #16
    MOVN  W16, #0xc666, LSL #0
    ADCS  X25, X8, X5
    EOR  X25, X9, #0xf01ffffff01fffff
    ORR  X15, X13, #0xf9f9f9f9f9f9f9f9
    BIC  V27.8B, V13.8B, V22.8B
    EON  W29, W14, W27, ROR #16
    CSINV  W19, W18, W6, EQ
    BIC  X12, X16, X5, ASR #42
    UMSUBL  X17, W25, W18, X8
    MOVN  W25, #0xc42, LSL #0
    CRC32CH  W6, W14, W18
    AND  W21, W25, #0xfe00fe
    UBFM  X15, X25, #0x1e, #0x38
    SBFM  X18, X3, #0x2a, #0x34
    CLZ  V22.8H, V20.8H
    MOVN  X17, #0x57ef, LSL #16
    CRC32CW  W3, W15, W15
    AND  W27, W28, #0xf1ffffff
    SUBS  W7, W29, W12, ASR #13
    CLZ  X21, X10
    EON  X8, X5, X19, ASR #48
    ASRV  X2, X27, X18
    SUBS  W2, W11, #0x120
    MOVN  X16, #0x334b, LSL #16
    BIC  W10, W17, W14, LSR #18
    EOR  W16, W23, #0x3ffe
    CSINC  X13, X5, X20, VC
    EXTR  X3, X6, X15, #0x3d
    ADDS  X12, X8, X25, SXTX #3
    BIC  X8, X10, X4, LSR #26
    ADC  W19, W19, W5
    SBFM  W22, W29, #0xa, #0x1c
    SUB  X17, X5, X7, ASR #35
    SUB  X23, X8, X26, UXTX #2
    UMULH  X9, X4, X26
    EON  W29, W20, W14, ROR #7
    BICS  X3, X16, X29, LSL #1
    ORR  V12.4S, #0x4c
    CRC32CH  W11, W25, W7
    SBFM  W20, W17, #0x1c, #0x16
    LSLV  X26, X6, X15
    ORR  X22, X15, #0x80003fffffffffff
    CSNEG  X9, X28, X23, MI
    LSLV  X5, X2, X8
    ORR  X5, X4, #0xf8
    SUB  X19, X26, X20, LSL #22
    ORR  V19.16B, V16.16B, V10.16B
    SUBS  W14, W9, W4, ASR #22
    AND  W15, W28, #0xe03fffff
    ADD  W12, W14, #0xffd
    CRC32CW  W22, W3, W4
    CSINV  W10, W6, W14, PL
    MOVZ  W12, #0x2e2f, LSL #16
    ORN  X13, X13, X22, ASR #35
    ADD  X13, X4, X25, LSR #2
    CLS  X13, X18
    CRC32H  W8, W11, W18
    ADDS  X29, X22, W12, SXTB #1
    LSRV  W6, W7, W2
    MOVZ  W23, #0x9c6e, LSL #0
    EOR  X27, X23, X3, LSL #44
    CLS  W26, W18
    ADD  X13, X6, W25, UXTW #2
    ANDS  W4, W9, W5, ROR #26
    MADD  X19, X10, X22, X16
    SUBS  X25, X3, X11, UXTX #0
    SMULH  X27, X25, X27
    CSINV  X29, X12, X26, LT
    EOR  W13, W8, W18, ASR #11
    SBFM  W4, W19, #0xe, #0x13
    MOVZ  W27, #0x37cf, LSL #0
    SUBS  W29, W6, W27, LSL #29
    AND  W8, W14, #0xffff8003
    ADD  X20, X28, #0xae0
    CLZ  W27, W23
    EXTR  W20, W22, W9, #0xb
    SUB  X15, X18, X18, UXTX #4
    CLZ  W7, W8
    MOVZ  X6, #0x66df, LSL #0
    MOVZ  X22, #0x936c, LSL #16
    ADDS  X21, X10, #0x353, LSL #12
    CSNEG  X4, X17, X21, LT
    ADDS  W3, W28, W14, ASR #24
    SMADDL  X25, W18, W23, X25
    MOVN  X3, #0x5f4a, LSL #0
    EON  W29, W19, W22, ASR #25
    AND  W26, W11, W17, ROR #29
    EXTR  W18, W9, W25, #0x10
    ANDS  X4, X26, #0xfffffc007fffffff
    SMSUBL  X14, W23, W26, X18
    SUBS  X28, X28, #0x1
    B.NE  TaishanIntAluP02_label_480
    MOVZ  X9, #0xc674, LSL #0
    MOVK  X9, #0x86e7, LSL #16
    SUB  X7, X9, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP02_TestFail
    MOVZ  X22, #0xa0b5, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X26, X22, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x8709, LSL #0
    MOVK  X29, #0x1012, LSL #16
    SUB  X12, X29, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP02_TestFail
    MOVZ  X9, #0xa2fe, LSL #0
    MOVK  X9, #0xa23f, LSL #16
    SUB  X13, X9, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x66df, LSL #0
    SUB  X19, X5, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x8003, LSL #0
    MOVK  X5, #0x5600, LSL #16
    SUB  X25, X5, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X11, #0xa2fe, LSL #0
    MOVK  X11, #0xa23f, LSL #16
    SUB  X27, X11, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X3, #0xd5a5, LSL #0
    MOVK  X3, #0x8703, LSL #16
    SUB  X2, X3, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X22, #0xa2fe, LSL #0
    MOVK  X22, #0xa23f, LSL #16
    SUB  X23, X22, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X13, #0x6c28, LSL #0
    MOVK  X13, #0xa7ec, LSL #16
    MOVK  X13, #0xf62e, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X10, X13, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X15
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP02_TestFail
    MOVZ  X9, #0x7bff, LSL #0
    MOVK  X9, #0xffaa, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X17, X9, X17
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X18, #0xee06, LSL #0
    MOVK  X18, #0xda2b, LSL #16
    SUB  X17, X18, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP02_TestFail
    MOVZ  X15, #0xc01b, LSL #0
    MOVK  X15, #0x1b0a, LSL #16
    SUB  X11, X15, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X28, X19, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP02_TestFail
    MOVZ  X10, #0xa2fe, LSL #0
    MOVK  X10, #0xa23f, LSL #16
    SUB  X6, X10, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X27, X14, X23
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X2, X27, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X2, #0xa, LSL #0
TaishanIntAluP02_label_508:
    SUBS  W23, W14, #0xa7d, LSL #12
    AND  X5, X17, #0xffc01fffffc01fff
    MOVK  W12, #0x8674, LSL #0
    ORN  W11, W8, W15, LSL #30
    SUBS  W3, W19, #0xd5f, LSL #12
    CLZ  V18.16B, V30.16B
    CRC32H  W4, W10, W4
    CSNEG  W22, W13, W2, CC
    CRC32W  W20, W18, W5
    CRC32CH  W18, W22, W11
    CRC32CX  W21, W3, X12
    CSNEG  X21, X16, X2, EQ
    ANDS  W21, W12, #0xe0000001
    UMADDL  X20, W12, W20, X25
    AND  W23, W11, #0xfffffc
    ORR  X29, X2, #0xfffcfffcfffcfffc
    CRC32CH  W14, W17, W8
    CRC32H  W11, W10, W21
    SUBS  X5, X29, X13, LSR #3
    SMSUBL  X3, W22, W11, X7
    ANDS  W26, W26, #0x3f003f
    UMADDL  X25, W11, W4, X10
    SUB  X12, X6, W15, UXTB #0
    BIC  V5.16B, V22.16B, V16.16B
    CLZ  W20, W13
    ORN  X20, X17, X12, ASR #46
    EOR  X13, X14, #0xc0c0c0c0c0c0c0c
    ADCS  W7, W15, W19
    BICS  W9, W7, W16, ROR #14
    ADCS  W20, W28, W9
    ADD  W12, W12, #0x8ef, LSL #12
    BICS  X9, X28, X27, ASR #7
    CRC32H  W27, W17, W10
    SMADDL  X10, W28, W11, X9
    CRC32CX  W7, W21, X25
    CRC32CB  W25, W22, W23
    BICS  W11, W8, W5, LSR #1
    ADDS  X27, X6, X12, LSR #62
    ADDS  X17, X13, #0x1c1
    SUB  W15, W3, W21, ASR #29
    MOVZ  W5, #0x83d9, LSL #0
    LSLV  W8, W18, W6
    MOVK  X23, #0xc12b, LSL #48
    CSINV  W3, W26, W28, GE
    ADD  W12, W15, W16, UXTX #4
    CLS  V16.2S, V4.2S
    AND  W21, W21, W25, LSL #3
    CSINC  W3, W25, W18, NE
    EON  W18, W16, W16, ASR #28
    SUBS  X7, X22, #0xecd, LSL #12
    ADD  X8, X16, #0xf5a, LSL #12
    ANDS  X7, X26, #0xf8000000f80
    ANDS  W21, W21, W23, ROR #5
    UMSUBL  X28, W3, W6, X29
    ORR  V20.16B, V30.16B, V7.16B
    UBFM  X9, X15, #0x20, #0x1
    MADD  W10, W14, W22, W29
    CLZ  W13, W17
    SUBS  W6, W13, #0xafa
    ADDS  X21, X28, X19, ASR #1
    EXTR  W19, W7, W20, #0x4
    CSNEG  W21, W21, W19, AL
    ORN  X5, X19, X26, LSL #8
    CRC32X  W18, W16, X8
    ORR  V22.4S, #0x39, LSL #16
    UMSUBL  X10, W16, W5, X23
    ANDS  X3, X5, X17, LSR #44
    CSINC  X13, X7, X10, NE
    UMSUBL  X19, W13, W26, X22
    SUBS  W28, W5, W8, UXTH #0
    LSRV  W7, W27, W29
    CSEL  X6, X7, X7, NE
    MOVN  X14, #0x4264, LSL #16
    EOR  X19, X18, X19, LSR #20
    ADDS  W5, W21, W20, LSR #26
    CSINV  X9, X14, X20, PL
    UMADDL  X17, W9, W7, X27
    SMADDL  X3, W17, W20, X15
    ORR  V26.4S, #0xa0, LSL #16
    CRC32CB  W11, W8, W20
    AND  X17, X12, X6, LSR #57
    UBFM  W22, W23, #0x1f, #0xa
    SUB  X18, X7, X22, ASR #18
    ANDS  X15, X22, X11, ASR #38
    MOVK  W9, #0x624f, LSL #0
    EON  W23, W16, W21, ASR #4
    CLZ  W5, W21
    ADDS  W5, W6, #0x631
    CSEL  W19, W14, W6, GT
    MOVZ  W23, #0x2242, LSL #16
    ORR  V10.8H, #0x85
    CRC32X  W17, W28, X12
    ADD  X12, X18, W27, UXTB #1
    SUBS  W8, W6, W22, ASR #9
    SUB  X12, X10, X14, ASR #59
    CRC32H  W28, W26, W12
    CSINV  W8, W20, W13, LT
    ADC  X23, X8, X27
    MOVK  W10, #0xa59, LSL #16
    CLZ  X17, X23
    ORR  V15.2S, #0xcd, LSL #16
    CRC32X  W6, W20, X10
    SMADDL  X12, W8, W14, X19
    MADD  W28, W17, W7, W20
    SUB  W20, W8, W18, LSR #17
    EXTR  X14, X13, X11, #0x3d
    MOVN  W28, #0xd179, LSL #16
    EOR  X14, X20, #0xfffff80000000fff
    CRC32B  W16, W6, W8
    CLS  X16, X7
    BIC  V25.16B, V27.16B, V9.16B
    LSLV  W27, W16, W14
    CLS  V28.2S, V14.2S
    CRC32CH  W27, W3, W28
    ANDS  W4, W3, #0x1fffe
    UMADDL  X11, W15, W12, X9
    CLS  W23, W9
    CSINV  W12, W5, W10, PL
    ADC  X12, X23, X14
    CRC32B  W22, W12, W26
    ORR  W26, W25, #0x3fc0000
    EON  W25, W13, W19, ROR #16
    SUB  W18, W23, W23, LSR #16
    AND  W23, W14, W3, ASR #1
    ADCS  W10, W10, W22
    CSINV  X15, X25, X19, GT
    CLS  W25, W6
    LSRV  X3, X8, X22
    EON  X13, X13, X10, ASR #22
    ORN  X28, X15, X11, LSR #15
    CLS  W14, W22
    SUBS  X4, X27, W8, UXTH #4
    ADD  W25, W28, #0xdde
    ADD  X22, X18, X26, LSL #29
    UMSUBL  X28, W23, W22, X19
    CRC32CX  W25, W25, X28
    EXTR  W7, W4, W4, #0x12
    SUBS  X6, X6, W3, UXTH #0
    ADD  X26, X10, X27, ASR #49
    SBFM  W27, W7, #0x0, #0x18
    SUB  W5, W14, W13, ASR #28
    BICS  X12, X14, X10, ROR #21
    SBFM  W27, W29, #0x7, #0xa
    CRC32CW  W19, W27, W3
    EON  W19, W19, W11, LSL #10
    CSNEG  W15, W26, W5, VC
    MOVN  X29, #0x3bc6, LSL #48
    SBFM  W27, W25, #0xb, #0x18
    SBFM  X14, X6, #0x33, #0x39
    UMSUBL  X10, W15, W4, X6
    LSLV  W11, W22, W10
    UMSUBL  X26, W17, W6, X5
    CSINV  X12, X5, X29, VS
    MOVN  X4, #0x5fd9, LSL #32
    CLS  X18, X28
    ADC  X7, X8, X6
    ORR  W16, W9, #0xfffffc03
    BICS  X28, X26, X27, LSL #27
    EOR  W3, W15, W16, LSR #0
    SUB  X21, X11, X27, LSR #61
    ORR  V21.8B, V12.8B, V22.8B
    ORR  V26.2S, #0xf0
    BIC  X23, X16, X17, LSR #59
    EOR  X23, X19, #0xf8f8f8f8f8f8f8f8
    AND  W28, W3, #0x7c007c00
    ADD  W13, W18, W22, SXTW #0
    EOR  W21, W16, #0x600060
    LSRV  X26, X3, X28
    CLS  X4, X9
    LSLV  X26, X19, X9
    UBFM  W9, W6, #0x6, #0x9
    CSINV  W20, W25, W17, GT
    BICS  W15, W13, W21, LSL #26
    EOR  X11, X27, #0xffffffffc0
    BIC  W29, W22, W8, LSL #11
    SUBS  W4, W11, #0xb31, LSL #12
    BICS  W28, W18, W14, ROR #7
    SUBS  X22, X28, X16, LSL #9
    SMADDL  X15, W25, W23, X2
    MADD  X9, X4, X25, X15
    ADDS  W25, W27, W10, LSL #16
    UBFM  X6, X5, #0x10, #0x12
    SMADDL  X26, W22, W19, X7
    ADCS  W15, W23, W4
    LSLV  X11, X15, X18
    BIC  W5, W4, W18, LSL #18
    ADC  X3, X14, X8
    ANDS  W18, W23, W22, ROR #18
    SUBS  X9, X11, X20, ASR #28
    ORR  W15, W4, W5, ROR #29
    CLS  W9, W5
    BICS  W28, W28, W28, LSR #30
    ANDS  W12, W21, W7, ASR #29
    EXTR  X13, X5, X29, #0x6
    MOVZ  W29, #0xd4ab, LSL #16
    CRC32CW  W29, W14, W25
    ADCS  W22, W29, W6
    SMADDL  X12, W11, W14, X11
    EOR  W23, W18, #0xfff800
    CSNEG  W27, W12, W6, AL
    SUBS  X2, X2, #0x1
    B.NE  TaishanIntAluP02_label_508
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x20, LSL #0
    MOVK  X29, #0x200, LSL #16
    SUB  X14, X29, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X26, #0xfe77, LSL #0
    MOVK  X26, #0xff4c, LSL #16
    SUB  X15, X26, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X20, X11, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP02_TestFail
    MOVZ  X26, #0x1d07, LSL #0
    MOVK  X26, #0xdaa0, LSL #16
    SUB  X21, X26, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP02_TestFail
    MOVZ  X26, #0x1f, LSL #0
    MOVK  X26, #0x200, LSL #16
    SUB  X10, X26, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X27, X3, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X15, X6, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xb6e0, LSL #16
    MOVK  X23, #0x8c71, LSL #32
    MOVK  X23, #0x1b, LSL #48
    SUB  X29, X23, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x180, LSL #16
    MOVK  X4, #0xdc00, LSL #48
    SUB  X23, X4, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X8, X28, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X16
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xd804, LSL #16
    SUB  X5, X21, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X16, X14, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xd804, LSL #16
    SUB  X7, X29, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X23
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP02_TestFail
    MOVZ  X7, #0xf1b7, LSL #0
    MOVK  X7, #0x74a3, LSL #16
    SUB  X12, X7, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X26
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X9, X29, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
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
    MOVZ  X14, #0xa, LSL #0
TaishanIntAluP02_label_532:
    BICS  W5, W19, W25, ASR #19
    CLS  X26, X25
    UMSUBL  X8, W10, W16, X20
    SMSUBL  X2, W25, W29, X25
    MOVZ  W26, #0x2ad8, LSL #16
    CSNEG  W8, W29, W18, PL
    UBFM  X5, X27, #0x14, #0x20
    CRC32W  W3, W15, W14
    ADDS  W23, W13, W22, ASR #27
    CSNEG  W20, W10, W9, MI
    ADD  W29, W23, #0xa80
    CRC32CB  W29, W29, W15
    CSNEG  W5, W11, W8, LE
    ORR  W26, W14, #0xaaaaaaaa
    EOR  W17, W27, W2, ASR #30
    SUB  X6, X26, #0xa84
    BIC  X4, X2, X27, ROR #25
    ADD  X17, X29, X6, LSR #32
    CLS  X27, X8
    AND  W15, W14, W10, ASR #18
    ASRV  X7, X28, X11
    MOVK  W10, #0x8784, LSL #0
    UMADDL  X20, W29, W23, X10
    ASRV  X26, X20, X9
    LSRV  W26, W7, W22
    CSEL  X2, X5, X6, PL
    ADDS  W13, W13, #0x7a7, LSL #12
    ADCS  W13, W5, W29
    SMSUBL  X5, W14, W11, X20
    CLS  V15.4H, V0.4H
    ANDS  W15, W4, #0x1f000000
    CLS  X9, X27
    ADC  W16, W17, W4
    CLS  V13.16B, V21.16B
    EON  W26, W29, W7, LSL #18
    ADC  W26, W5, W28
    SUB  W5, W7, W2, LSR #11
    MOVZ  X8, #0xa9bd, LSL #0
    MOVN  X22, #0x976e, LSL #48
    CLS  W10, W6
    CRC32CB  W10, W17, W21
    CLS  V28.8H, V29.8H
    SUBS  W4, W10, W15, LSL #11
    CSNEG  W4, W2, W11, AL
    BIC  V22.16B, V25.16B, V20.16B
    ANDS  W22, W4, W11, ASR #30
    AND  W15, W22, #0xfc0ffc0f
    ADD  W13, W11, W12, UXTB #1
    CLS  W22, W25
    CRC32W  W28, W6, W18
    ANDS  X26, X13, X29, LSR #22
    SUB  W28, W2, W19, UXTH #0
    ORN  X29, X26, X7, LSR #32
    ORR  W5, W22, #0x7f7f7f7f
    ANDS  X8, X27, X2, ROR #27
    MOVK  W27, #0xcc65, LSL #0
    ADD  W2, W11, W20, LSR #30
    SMULH  X17, X5, X6
    LSRV  W21, W10, W29
    CSINC  W15, W7, W18, LE
    SMSUBL  X22, W7, W22, X10
    BIC  X29, X15, X7, LSR #59
    MOVZ  X28, #0x52cf, LSL #48
    ORR  X10, X5, X27, LSL #11
    AND  X29, X26, X6, ASR #29
    ADCS  X22, X11, X21
    BIC  W5, W27, W13, LSR #16
    ADDS  X26, X25, X27, LSR #54
    SUB  X18, X21, W12, UXTH #1
    CSINV  W11, W13, W5, NV
    ORR  V24.4H, #0xac
    UMADDL  X15, W19, W2, X27
    UMSUBL  X19, W25, W13, X23
    CSINC  W4, W9, W17, HI
    LSRV  W7, W29, W26
    MOVN  X8, #0x7985, LSL #0
    ORR  X22, X7, X2, ASR #46
    SUBS  W11, W7, W23, UXTB #3
    AND  W7, W28, W19, ROR #28
    MOVN  W18, #0xf195, LSL #16
    AND  X8, X27, #0x3030303030303030
    ADD  X7, X12, X21, ASR #21
    EOR  W29, W6, #0xfffffffc
    CRC32CX  W23, W18, X20
    SUBS  X23, X4, X15, LSL #53
    SBFM  X28, X25, #0x1d, #0x34
    ADD  X7, X7, #0x6e1, LSL #12
    ADD  X21, X8, #0xc53, LSL #12
    CSEL  W25, W29, W27, EQ
    SMULH  X27, X18, X29
    UMADDL  X19, W7, W12, X21
    UMULH  X17, X13, X22
    EOR  X15, X3, #0x7fffff80000
    ORN  W16, W23, W26, LSR #19
    AND  X27, X25, #0xffff8000000fffff
    LSRV  X9, X17, X4
    EXTR  W27, W2, W15, #0x5
    ADC  W8, W13, W13
    EOR  X10, X10, #0xfff80
    CSINV  W23, W26, W2, GE
    AND  W16, W20, W17, LSL #7
    ANDS  W2, W16, W19, ROR #18
    SBFM  X21, X2, #0x1c, #0x12
    ADD  X9, X12, W10, UXTH #1
    SUBS  W13, W17, W21, UXTB #1
    CLS  W28, W14
    ADD  X6, X29, W28, UXTH #1
    ADD  W6, W18, W22, LSR #13
    SUBS  X6, X27, #0x2f4, LSL #12
    CRC32H  W5, W25, W29
    MOVN  X7, #0x8ba1, LSL #48
    MOVN  W25, #0x626a, LSL #0
    CLZ  V10.8B, V18.8B
    SUB  W7, W6, W9, LSR #1
    EOR  X23, X6, X5, ASR #11
    MOVK  W3, #0x912d, LSL #16
    UBFM  W15, W3, #0x0, #0x1
    SUBS  X13, X26, X19, UXTX #2
    CLS  W7, W21
    SMADDL  X12, W16, W7, X12
    LSLV  W18, W27, W17
    ADC  W15, W3, W26
    ORR  W20, W13, W25, LSL #17
    AND  W23, W8, W29, LSR #5
    ADD  W19, W21, #0x800
    MADD  W8, W26, W28, W10
    UBFM  W16, W8, #0x3, #0xe
    UMSUBL  X17, W17, W29, X15
    ADC  W22, W29, W19
    CSEL  X13, X12, X11, LT
    CRC32CH  W11, W29, W16
    SUB  W26, W29, #0x5e9
    AND  W13, W8, W9, ROR #15
    ADD  W6, W27, W7, ASR #14
    ADC  W5, W26, W12
    BIC  W16, W14, W12, ROR #29
    SUBS  W21, W9, W26, SXTX #2
    MADD  X28, X20, X4, X19
    BICS  W18, W20, W6, LSL #14
    BICS  W29, W19, W3, ASR #3
    UMADDL  X22, W11, W11, X15
    BIC  V12.16B, V18.16B, V3.16B
    ADCS  X26, X12, X9
    MOVK  X18, #0xe1eb, LSL #0
    SUB  W28, W26, W23, SXTX #2
    ORR  X17, X9, X19, ASR #15
    SUBS  W3, W15, W17, ASR #0
    CRC32W  W11, W23, W4
    SMSUBL  X11, W20, W6, X21
    ADCS  X9, X6, X11
    ORR  X4, X28, #0x7fe000007fe00000
    ADD  W17, W22, W27, SXTH #0
    BICS  X3, X16, X22, ROR #3
    ADD  X28, X27, W12, SXTB #0
    UBFM  X8, X13, #0x2e, #0x39
    SMSUBL  X5, W22, W27, X4
    ADD  X21, X4, W15, SXTB #0
    CRC32CW  W29, W16, W20
    CRC32W  W7, W27, W28
    ADDS  X29, X17, W18, UXTH #2
    UMADDL  X27, W26, W2, X2
    BIC  W19, W18, W9, ASR #24
    ASRV  W11, W25, W28
    UMSUBL  X3, W14, W26, X28
    CLS  V1.4S, V27.4S
    SMSUBL  X17, W11, W19, X17
    SUBS  X13, X27, W2, SXTB #2
    CRC32H  W5, W22, W8
    MOVK  W15, #0xf60e, LSL #16
    EOR  X20, X14, #0xff8fff8fff8fff8f
    ADDS  W6, W11, W12, SXTX #4
    MOVZ  W15, #0xb72, LSL #0
    EOR  X13, X26, #0xffc0000003ffffff
    SUB  X2, X18, #0x6b0, LSL #12
    CSINV  X4, X3, X28, PL
    CSINV  X11, X14, X8, PL
    ASRV  W20, W2, W15
    UMADDL  X13, W19, W21, X16
    SUBS  X17, X2, W3, SXTH #3
    ASRV  W11, W15, W29
    EON  W18, W4, W7, ROR #22
    CRC32W  W28, W26, W12
    ADD  W28, W14, #0x5b0
    SMSUBL  X8, W28, W22, X28
    ORR  V19.2S, #0x1d, LSL #16
    SUB  W22, W2, #0x617
    ANDS  X19, X3, #0x1111111111111111
    BICS  W19, W13, W27, ASR #1
    ADDS  X15, X20, #0x690
    ADCS  W10, W11, W12
    MADD  W4, W10, W2, W27
    ANDS  W8, W28, #0x7e7e7e7e
    MOVZ  X26, #0x3047, LSL #48
    AND  X6, X16, X22, ASR #42
    CSNEG  X18, X8, X12, NV
    ORR  V22.2S, #0x63, LSL #16
    ANDS  W10, W10, #0xfffc03ff
    BIC  W12, W7, W9, LSL #5
    CSNEG  X3, X10, X19, AL
    EXTR  W16, W27, W4, #0x16
    SUBS  X14, X14, #0x1
    B.NE  TaishanIntAluP02_label_532
    MOVZ  X11, #0xe1eb, LSL #0
    MOVK  X11, #0x795, LSL #16
    SUB  X20, X11, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP02_TestFail
    MOVZ  X4, #0x128, LSL #0
    MOVK  X4, #0x4084, LSL #16
    SUB  X25, X4, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X4, #0x128, LSL #0
    MOVK  X4, #0x4084, LSL #16
    SUB  X9, X4, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X18, #0x4690, LSL #0
    MOVK  X18, #0x47ef, LSL #16
    SUB  X26, X18, X5
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X9, X17, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X7, #0xecf6, LSL #0
    MOVK  X7, #0x43e, LSL #16
    SUB  X4, X7, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X3, #0x430, LSL #0
    SUB  X26, X3, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X22, #0x128, LSL #0
    MOVK  X22, #0x4084, LSL #16
    SUB  X4, X22, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X5, #0xe1eb, LSL #0
    MOVK  X5, #0x795, LSL #16
    SUB  X3, X5, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X14, #0x44f6, LSL #0
    MOVK  X14, #0x412, LSL #16
    SUB  X9, X14, X12
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X15, #0x43b, LSL #0
    MOVK  X15, #0x2c2e, LSL #16
    MOVK  X15, #0x2b17, LSL #32
    MOVK  X15, #0x800, LSL #48
    SUB  X3, X15, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X25, #0x44f6, LSL #0
    MOVK  X25, #0x412, LSL #16
    SUB  X15, X25, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X19, X14, X15
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X22, X21, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X23, X19, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X21
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X20, X22, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP02_TestFail
    MOVZ  X17, #0x44f6, LSL #0
    MOVK  X17, #0x412, LSL #16
    SUB  X26, X17, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X25, X22, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X26, #0x53a4, LSL #0
    MOVK  X26, #0xe1f8, LSL #16
    SUB  X29, X26, X29
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP02_TestFail
    MOVZ  X2, #0xa468, LSL #0
    MOVK  X2, #0xaa5, LSL #16
    MOVK  X2, #0x7b36, LSL #32
    MOVK  X2, #0x3039, LSL #48
    MOVZ  X3, #0x11ca, LSL #0
    MOVK  X3, #0xdb00, LSL #16
    MOVK  X3, #0xaacc, LSL #32
    MOVK  X3, #0xa75c, LSL #48
    MOVZ  X4, #0x70d4, LSL #0
    MOVK  X4, #0xb648, LSL #16
    MOVK  X4, #0x95c6, LSL #32
    MOVK  X4, #0x7eb5, LSL #48
    MOVZ  X5, #0xf9b2, LSL #0
    MOVK  X5, #0x9029, LSL #16
    MOVK  X5, #0xf627, LSL #32
    MOVK  X5, #0xd557, LSL #48
    MOVZ  X6, #0x6967, LSL #0
    MOVK  X6, #0x29d9, LSL #16
    MOVK  X6, #0x57e4, LSL #32
    MOVK  X6, #0x2e7c, LSL #48
    MOVZ  X7, #0xd9bd, LSL #0
    MOVK  X7, #0x29cf, LSL #16
    MOVK  X7, #0xf9c8, LSL #32
    MOVK  X7, #0x6802, LSL #48
    MOVZ  X8, #0xb481, LSL #0
    MOVK  X8, #0x9b39, LSL #16
    MOVK  X8, #0x2e9d, LSL #32
    MOVK  X8, #0xab80, LSL #48
    MOVZ  X9, #0x1cb1, LSL #0
    MOVK  X9, #0xc9a2, LSL #16
    MOVK  X9, #0x9dca, LSL #32
    MOVK  X9, #0x3268, LSL #48
    MOVZ  X10, #0xbb0c, LSL #0
    MOVK  X10, #0x4226, LSL #16
    MOVK  X10, #0x8984, LSL #32
    MOVK  X10, #0x6e06, LSL #48
    MOVZ  X11, #0x6085, LSL #0
    MOVK  X11, #0x28e1, LSL #16
    MOVK  X11, #0x8ad9, LSL #32
    MOVK  X11, #0xcda9, LSL #48
    MOVZ  X12, #0x8c03, LSL #0
    MOVK  X12, #0xa12c, LSL #16
    MOVK  X12, #0xcf6, LSL #32
    MOVK  X12, #0xf4e8, LSL #48
    MOVZ  X13, #0xf146, LSL #0
    MOVK  X13, #0xccb5, LSL #16
    MOVK  X13, #0x54ac, LSL #32
    MOVK  X13, #0xecf0, LSL #48
    MOVZ  X14, #0x75a3, LSL #0
    MOVK  X14, #0xdf48, LSL #16
    MOVK  X14, #0x92c6, LSL #32
    MOVK  X14, #0xe616, LSL #48
    MOVZ  X15, #0xea79, LSL #0
    MOVK  X15, #0x9bdb, LSL #16
    MOVK  X15, #0xed7b, LSL #32
    MOVK  X15, #0xd34e, LSL #48
    MOVZ  X16, #0x7ffb, LSL #0
    MOVK  X16, #0x7e56, LSL #16
    MOVK  X16, #0xfc23, LSL #32
    MOVK  X16, #0x2870, LSL #48
    MOVZ  X17, #0x786c, LSL #0
    MOVK  X17, #0x7197, LSL #16
    MOVK  X17, #0xf854, LSL #32
    MOVK  X17, #0x8530, LSL #48
    MOVZ  X18, #0xdac6, LSL #0
    MOVK  X18, #0x81b5, LSL #16
    MOVK  X18, #0x1184, LSL #32
    MOVK  X18, #0x7a94, LSL #48
    MOVZ  X19, #0xa458, LSL #0
    MOVK  X19, #0x1920, LSL #16
    MOVK  X19, #0xf398, LSL #32
    MOVK  X19, #0x6ed, LSL #48
    MOVZ  X20, #0x16cc, LSL #0
    MOVK  X20, #0xa387, LSL #16
    MOVK  X20, #0x7250, LSL #32
    MOVK  X20, #0x8ca, LSL #48
    MOVZ  X21, #0xe420, LSL #0
    MOVK  X21, #0xb9f6, LSL #16
    MOVK  X21, #0x7632, LSL #32
    MOVK  X21, #0x5c3a, LSL #48
    MOVZ  X22, #0x1d03, LSL #0
    MOVK  X22, #0x48cb, LSL #16
    MOVK  X22, #0x856e, LSL #32
    MOVK  X22, #0x284d, LSL #48
    MOVZ  X23, #0x6b00, LSL #0
    MOVK  X23, #0xe05b, LSL #16
    MOVK  X23, #0x50b4, LSL #32
    MOVK  X23, #0xec75, LSL #48
    MOVZ  X25, #0x9ea, LSL #0
    MOVK  X25, #0x6edf, LSL #16
    MOVK  X25, #0x3439, LSL #32
    MOVK  X25, #0x7a1e, LSL #48
    MOVZ  X26, #0x74e8, LSL #0
    MOVK  X26, #0x9a56, LSL #16
    MOVK  X26, #0xf6b6, LSL #32
    MOVK  X26, #0x332d, LSL #48
    MOVZ  X27, #0xa0be, LSL #0
    MOVK  X27, #0x1ce, LSL #16
    MOVK  X27, #0x560b, LSL #32
    MOVK  X27, #0x34b3, LSL #48
    MOVZ  X28, #0xb292, LSL #0
    MOVK  X28, #0xbbd1, LSL #16
    MOVK  X28, #0x1eb6, LSL #32
    MOVK  X28, #0x7947, LSL #48
    MOVZ  X29, #0x54a9, LSL #0
    MOVK  X29, #0xa7e6, LSL #16
    MOVK  X29, #0x3a3c, LSL #32
    MOVK  X29, #0x90ea, LSL #48
    MOVZ  X19, #0xa, LSL #0
TaishanIntAluP02_label_557:
    ADCS  W20, W12, W27
    ORR  V31.16B, V1.16B, V10.16B
    ADDS  W4, W7, W29, LSR #26
    ADD  X28, X3, X29, UXTX #1
    CLZ  X28, X18
    AND  X26, X28, #0x7fffffff000
    ADDS  X4, X17, X27, LSL #14
    MOVN  X6, #0xab9a, LSL #32
    ADDS  W16, W25, #0xd83
    UMULH  X12, X12, X3
    ADDS  X28, X3, #0x44a, LSL #12
    ADDS  W3, W14, #0x8e0
    CLS  V9.8H, V13.8H
    CRC32CH  W10, W25, W7
    ORR  V3.2S, #0x88
    EXTR  W28, W6, W25, #0x1e
    ASRV  X26, X10, X16
    ORN  W10, W23, W25, LSR #6
    ORR  V16.4S, #0x98, LSL #8
    UBFM  X27, X19, #0xd, #0x0
    SMADDL  X17, W7, W27, X10
    MOVN  W26, #0xa655, LSL #0
    CRC32H  W3, W16, W28
    BIC  X5, X28, X11, LSR #21
    EOR  W28, W26, #0xfff8fff8
    LSLV  W11, W17, W15
    ADCS  X22, X17, X18
    EON  X7, X11, X27, ROR #41
    EON  X20, X3, X7, LSL #15
    SUB  W20, W12, #0x5d3
    CSEL  X20, X12, X20, GE
    AND  W15, W7, #0x3000
    SUBS  W22, W6, W28, LSL #8
    MADD  W21, W25, W9, W10
    ADD  X22, X4, X20, ASR #53
    CLZ  W25, W21
    ADDS  X16, X22, #0xd16
    MOVK  W11, #0xe341, LSL #0
    ADD  W17, W11, W28, UXTH #1
TaishanIntAluP02_label_347:
    BIC  X17, X21, X6, ASR #8
    EOR  W23, W16, #0x1e001e0
    CRC32CH  W13, W10, W19
    AND  W10, W26, #0xf0007fff
    AND  X5, X20, X25, ROR #43
    ANDS  X18, X11, X9, ROR #10
    SUBS  W26, W5, W12, UXTH #3
    ORN  X20, X16, X2, ROR #13
    ANDS  W22, W15, #0xffffe03f
    EON  X11, X22, X18, LSR #20
    ADC  W3, W17, W22
    SUBS  X8, X10, X23, ASR #10
    ADDS  W26, W12, W7, LSL #22
    AND  X7, X11, X3, LSL #20
    EON  W18, W13, W21, LSL #22
    BIC  V2.16B, V3.16B, V10.16B
    MOVZ  W13, #0xc4e6, LSL #16
    EOR  W21, W3, W3, ROR #28
    CRC32CH  W4, W8, W13
    MOVN  W9, #0x5d8a, LSL #16
    CSINC  X18, X22, X20, LS
    ADDS  W8, W4, W28, UXTB #3
    SMADDL  X28, W6, W19, X18
    CSEL  W2, W15, W18, GE
    ADCS  W27, W22, W17
    ANDS  X16, X12, #0x3ff0000
    CSINV  W29, W12, W5, NE
    CRC32CB  W13, W10, W11
    SUB  W9, W4, W20, SXTW #1
    EOR  W16, W7, W6, ASR #13
    MOVZ  W12, #0x8d62, LSL #16
    CLS  W29, W11
    SUBS  W13, W3, #0x89
    ADDS  W14, W25, #0x2f2, LSL #12
    UBFM  X6, X2, #0x36, #0x34
    SUB  X26, X7, #0x169, LSL #12
    SMULH  X14, X14, X13
    ORR  X3, X4, X23, LSR #35
    CRC32CX  W28, W13, X19
    CRC32CB  W12, W3, W23
    SUBS  X4, X8, X4, ASR #24
    ADDS  X28, X12, #0x562
    ADD  X15, X28, #0xacc, LSL #12
    SUB  W6, W15, W15, SXTH #2
    CRC32CH  W25, W20, W20
    MADD  X10, X7, X8, X13
    SUBS  X13, X25, X12, LSR #58
    ADD  W6, W11, W16, LSR #3
    CLS  W22, W22
    ADD  W10, W29, W12, UXTB #3
    BIC  X20, X9, X13, ROR #57
    LSLV  X5, X12, X20
    ADD  W26, W17, W10, LSR #5
    MADD  W7, W27, W19, W2
    ORR  V6.4H, #0x26
    SUBS  W25, W4, W22, UXTX #0
    SMULH  X17, X27, X10
    BICS  W6, W21, W25, ASR #17
    CRC32W  W9, W11, W4
    ANDS  W28, W17, W3, LSR #12
    SBFM  W4, W21, #0xc, #0x1e
    ADCS  W15, W27, W5
    EXTR  W21, W8, W26, #0x5
    CSNEG  W17, W18, W3, GE
    CRC32X  W11, W17, X9
    SMULH  X2, X19, X7
    SUBS  X4, X6, #0x996, LSL #12
    ADDS  W16, W11, W4, SXTW #2
    EON  X22, X3, X19, ASR #57
    ANDS  W10, W14, W12, ASR #8
    UMULH  X8, X8, X25
    CSNEG  X18, X7, X13, CS
    MOVN  X12, #0xfcf0, LSL #48
    ADC  X27, X23, X11
    CRC32W  W13, W3, W3
    UMULH  X25, X15, X8
    ORR  V12.8H, #0x3d, LSL #8
    UMULH  X21, X28, X22
    SUB  W17, W6, W15, SXTX #2
    ASRV  W26, W8, W10
    ADCS  W7, W22, W8
    SUB  W26, W19, W14, LSR #18
    ORN  X3, X4, X26, ROR #7
    ADC  W4, W23, W21
    SUB  W23, W7, W28, ASR #5
    ADD  X13, X6, X7, LSL #14
    ADD  X17, X27, W28, SXTB #0
    CLS  W14, W6
    CLS  W3, W12
    SUB  W2, W5, W23, UXTH #1
    BIC  W26, W19, W21, ASR #12
    ASRV  X26, X3, X13
    SUB  W20, W5, W14, SXTB #1
    AND  X25, X9, #0x1c0
    ANDS  W5, W10, #0xfe1ffe1f
    ADD  X13, X20, #0xb2c
    ASRV  W20, W20, W13
    MOVZ  W23, #0xd52b, LSL #16
    CLS  X23, X7
    ORR  W13, W4, #0x7fff
    EXTR  W15, W11, W4, #0xc
    ORR  W29, W19, W27, LSL #23
    AND  X7, X21, X21, LSR #30
    UMADDL  X13, W18, W11, X13
    SBFM  W16, W25, #0x13, #0x1
    ADDS  X27, X6, X4, SXTX #4
    SUB  W27, W15, W27, ASR #5
    EXTR  W16, W6, W25, #0x10
    MOVK  X27, #0x14cf, LSL #0
    CSINC  X21, X18, X3, NE
    CRC32CB  W26, W4, W29
    AND  W11, W5, W17, LSL #3
    SBFM  W16, W28, #0x4, #0x19
    BIC  V1.8B, V5.8B, V4.8B
    ADD  W12, W4, #0xa53, LSL #12
    ANDS  W11, W13, W6, LSL #19
    SUBS  X7, X9, #0xd3a, LSL #12
    ORR  V13.8H, #0xe9
    CSEL  X15, X15, X17, CC
    UMADDL  X28, W17, W19, X29
    ADCS  W4, W28, W12
    ADDS  X22, X26, X7, ASR #44
    ADDS  W16, W27, W27, SXTX #2
    ADD  W12, W16, W10, LSR #19
    SUB  W28, W16, W15, UXTW #4
    ANDS  X20, X10, #0x1fffffff800
    MOVZ  W4, #0x8d8f, LSL #16
    ADD  W4, W18, #0x3c3, LSL #12
    ADD  X6, X10, X17, UXTX #1
    AND  W11, W3, W15, ROR #29
    SUBS  X4, X13, X11, LSR #12
    ANDS  W4, W15, W23, ASR #15
    CSINC  W13, W23, W20, AL
    ORR  X5, X22, #0x20002000200020
    CRC32CX  W21, W16, X9
    ADD  W2, W8, W26, SXTB #1
    ORR  X25, X9, #0x3f000
    MOVN  X28, #0x14c0, LSL #32
    CSINC  X15, X3, X6, AL
    CRC32W  W2, W7, W5
    SUB  X21, X18, W26, SXTH #4
    LSLV  X28, X28, X13
    ASRV  W12, W27, W15
    BIC  W2, W8, W26, LSL #1
    EON  X20, X12, X25, ROR #49
    CSNEG  W6, W11, W15, EQ
    ANDS  X4, X20, X27, LSL #26
    AND  X27, X4, X4, LSR #46
    BICS  W29, W18, W13, ASR #13
    CSNEG  X14, X26, X12, VS
    AND  W21, W21, W10, LSR #21
    ADDS  X14, X28, X8, ASR #48
    MADD  X2, X27, X14, X10
    ORN  X26, X20, X22, ASR #0
    SUB  X14, X5, X22, LSR #15
    BICS  W27, W28, W13, ASR #2
    CSINV  X22, X21, X3, NV
    SBFM  X9, X6, #0x3a, #0x6
    ORR  X3, X6, X17, ROR #11
    ORR  V12.4H, #0xbf, LSL #8
    SUB  X5, X10, #0xe93, LSL #12
    SUBS  X19, X19, #0x1
    B.NE  TaishanIntAluP02_label_557
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X2, #0xbbf, LSL #0
    MOVK  X2, #0xc, LSL #16
    MOVK  X2, #0xacc0, LSL #48
    SUB  X27, X2, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x3800, LSL #16
    MOVK  X2, #0xa012, LSL #32
    MOVK  X2, #0x3a8, LSL #48
    SUB  X21, X2, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP02_TestFail
    MOVZ  X18, #0xd000, LSL #0
    MOVK  X18, #0xff16, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X8, X18, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP02_TestFail
    MOVZ  X26, #0x13, LSL #0
    SUB  X10, X26, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X3, #0xb782, LSL #0
    MOVK  X3, #0xbeb6, LSL #16
    SUB  X5, X3, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x4c0, LSL #0
    SUB  X25, X16, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X6, X8, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X9, #0x13, LSL #0
    SUB  X29, X9, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP02_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X16, X8, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X4, #0x1f, LSL #0
    SUB  X18, X4, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X14
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X11, #0x1f, LSL #0
    SUB  X23, X11, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X20, #0xf566, LSL #0
    MOVK  X20, #0x605d, LSL #16
    SUB  X14, X20, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X18
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X8, #0xf566, LSL #0
    MOVK  X8, #0x605d, LSL #16
    SUB  X22, X8, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X23
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X11, #0x13, LSL #0
    SUB  X14, X11, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X12, X9, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP02_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x8000, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X10, X23, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
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
TaishanIntAluP02_label_83:
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X25, #0xa, LSL #0
TaishanIntAluP02_label_581:
    MOVZ  X26, #0x6de1, LSL #48
    UMSUBL  X14, W9, W15, X29
    ORR  V31.4S, #0x24, LSL #24
    CSINV  X26, X25, X14, LT
    UMSUBL  X19, W3, W2, X19
    MOVN  W20, #0x6d5e, LSL #0
    EOR  X8, X17, #0xfc0ffc0ffc0ffc0f
    ADDS  X26, X11, X25, ASR #54
    MOVN  W22, #0x52f8, LSL #0
    ADDS  W6, W2, #0xe98
    SUB  X3, X13, X2, ASR #3
    SUB  W10, W6, #0x140
    SUB  W6, W20, W10, UXTB #2
    ORR  W3, W3, W20, LSL #7
    EOR  X19, X3, #0xffff8000ffff80
    CSINV  W15, W13, W27, CC
    ASRV  X8, X9, X23
    ADD  W19, W19, #0xae0
    LSLV  W8, W19, W15
    SUBS  X8, X15, #0xdfb, LSL #12
    ADDS  W5, W2, W27, LSR #26
    ADDS  W17, W29, #0x236
    ADD  W13, W18, #0xf85, LSL #12
    CRC32H  W22, W28, W22
    UBFM  X21, X8, #0x19, #0x38
    SUBS  W9, W12, W27, LSR #31
    AND  X16, X25, #0xfc000000007fffff
    EOR  X15, X20, X29, ASR #2
    CRC32W  W13, W25, W3
    EON  X16, X26, X6, ROR #61
    CRC32CW  W26, W17, W2
    SBFM  X19, X2, #0x24, #0x31
    ADDS  W20, W10, W14, LSL #21
    ADDS  W3, W21, W4, LSR #26
    ADDS  W28, W4, #0xe5c, LSL #12
    EOR  W15, W13, #0x3ffffffe
    BICS  W13, W19, W17, LSR #5
    ADD  W19, W5, W15, LSL #26
    CSINV  W7, W27, W23, MI
    CLS  W9, W12
    ORR  V17.4S, #0xf7, LSL #24
    ORR  V4.16B, V28.16B, V11.16B
    CLZ  V23.4S, V19.4S
    ADC  W17, W27, W9
    SUBS  X5, X26, X15, ASR #11
    BIC  W20, W25, W5, LSL #3
    MOVK  W28, #0x2593, LSL #16
    ORR  W22, W5, #0x1ff0
    SUBS  W29, W14, W26, ASR #5
    SUB  W7, W6, W18, ASR #27
    CLS  W4, W29
    UBFM  W16, W9, #0x8, #0x15
    ADD  W5, W20, W2, ASR #4
    EOR  W22, W10, #0xffe00000
    CSEL  W21, W13, W22, GT
    ADDS  X3, X5, X6, LSL #32
    CSINV  W5, W4, W18, PL
    ORR  X27, X28, #0x7fffe0007fffe0
    EOR  X22, X23, X17, LSR #28
    ASRV  W23, W19, W7
    LSLV  X23, X15, X9
    UMADDL  X19, W27, W29, X9
    EON  X14, X23, X17, LSL #35
    SUBS  W14, W23, #0xe50
    ADDS  W7, W19, W17, SXTX #4
    SUB  W26, W15, W4, SXTW #4
    ORR  W4, W2, #0xf00fffff
    BIC  X20, X14, X10, ROR #7
    EOR  W29, W27, #0xff00003f
    MOVK  W7, #0x8d26, LSL #16
    ORR  V31.4H, #0x5f
    ASRV  W14, W15, W22
    ADDS  X18, X17, X13, LSL #54
    ASRV  X16, X28, X9
    BIC  W11, W4, W3, ROR #6
    LSLV  X18, X3, X7
    ORR  W7, W16, W6, LSL #30
    CRC32H  W18, W25, W26
    BIC  W22, W26, W13, ROR #23
    CLZ  X11, X8
    SUB  X18, X4, X14, ASR #11
    ADC  W13, W18, W28
    CLZ  V26.2S, V25.2S
    CLZ  W10, W10
    CSINC  X4, X5, X10, VC
    EOR  W4, W20, W21, ROR #23
    EOR  W10, W29, W7, LSR #23
    ADC  X5, X20, X12
    ADDS  X21, X10, X29, SXTX #3
    ASRV  X5, X7, X15
    UBFM  W29, W6, #0xb, #0x17
    ANDS  W27, W18, W5, ASR #10
    AND  X28, X10, #0xffffffffffffe00
    EOR  W4, W17, W4, ROR #22
    SUBS  X13, X9, X18, LSL #63
    CRC32B  W11, W2, W13
    SUB  X15, X14, X25, LSR #44
    ASRV  W2, W2, W17
    SUB  X29, X16, X21, LSL #50
    ADDS  W10, W18, W22, LSR #18
    MOVZ  X9, #0xc872, LSL #16
    ADDS  X27, X9, #0x69e, LSL #12
    EOR  X4, X12, #0x1ffffff000
    CSNEG  X18, X9, X20, PL
    AND  W9, W19, W17, ASR #15
    CSINC  W3, W17, W10, MI
    CSEL  W9, W7, W9, LE
    ADDS  X17, X2, X20, UXTX #2
    AND  W21, W17, W20, ASR #28
    BICS  W23, W17, W6, LSL #12
    ADDS  W5, W27, W9, UXTW #4
    MOVN  X7, #0x6ba0, LSL #16
    CSEL  W5, W22, W26, CS
    ADD  W26, W20, W7, UXTX #4
    AND  W8, W12, W14, ASR #28
    EXTR  X17, X4, X9, #0x1a
    EXTR  W26, W15, W2, #0x19
    SUBS  X10, X25, W28, SXTB #4
    BICS  W12, W5, W27, LSL #3
    ANDS  W14, W21, W21, LSL #26
    CLS  W15, W6
    CRC32X  W14, W6, X6
    SUBS  X17, X26, #0xb7a, LSL #12
    SMULH  X18, X19, X23
    ADD  W8, W15, #0x71a, LSL #12
    EOR  W20, W15, #0x20202020
    UMADDL  X23, W28, W20, X27
    EON  X26, X15, X8, LSR #24
    ADDS  X27, X16, #0x2e0
    ORR  X4, X27, #0x7f007f007f007f
    BICS  W4, W22, W29, LSL #24
    ORR  W26, W29, #0xff00ff0
    BICS  W8, W3, W26, LSL #25
    AND  W19, W10, W18, ROR #3
    ORN  X6, X28, X23, LSL #42
    LSLV  X5, X6, X14
    EXTR  X27, X2, X8, #0x15
    CRC32X  W11, W22, X14
    ORR  W23, W9, #0xfffdfffd
    ORR  W13, W19, #0x1f001f
    CSINV  W26, W5, W26, NE
    CSEL  W2, W21, W21, LE
    CRC32B  W20, W29, W9
    SUB  W26, W12, #0xe64
    UMULH  X27, X25, X26
    LSLV  W15, W22, W14
    EOR  X5, X4, X5, ASR #38
    BICS  W16, W22, W2, LSR #1
    SUB  W7, W21, W28, LSL #10
    UBFM  X26, X25, #0x24, #0x31
    CRC32CX  W29, W17, X26
    CLZ  V25.16B, V9.16B
    ADDS  X5, X17, X17, SXTX #3
    CSINV  X5, X8, X15, NV
    CSEL  W17, W3, W22, LS
    UMSUBL  X26, W2, W2, X29
    AND  W5, W2, W14, ROR #30
    CSNEG  X11, X29, X25, NE
    MOVN  W29, #0xc488, LSL #0
    CSNEG  X2, X7, X29, GT
    MOVZ  W16, #0xb3e0, LSL #16
    ANDS  X28, X26, #0xffffffffffe0007f
    SUB  X21, X8, W21, SXTW #4
    LSRV  W22, W2, W17
    ANDS  W23, W26, W28, ROR #17
    SBFM  X14, X20, #0xd, #0x3b
    ORN  W10, W17, W20, LSR #0
    CSEL  X29, X26, X5, GE
    EXTR  W17, W6, W9, #0x12
    ORR  W28, W13, W5, LSL #2
    AND  W20, W16, W20, ASR #29
    CLZ  V5.8B, V10.8B
    EOR  W19, W9, #0xf0000001
    CSINC  X16, X3, X2, LE
    BIC  V29.16B, V3.16B, V22.16B
    AND  X8, X25, X15, LSL #42
    ORR  V22.2S, #0x5f
    UBFM  W22, W3, #0xb, #0x6
    ADCS  W4, W9, W7
    ORR  W17, W13, #0xfff807ff
    ADD  W21, W18, W15, UXTH #2
    CSNEG  W16, W23, W10, EQ
    ADD  X8, X11, X5, ASR #34
    EOR  W12, W11, W19, ASR #18
    MOVK  W12, #0x84ea, LSL #16
    BIC  W19, W15, W15, LSL #1
    CRC32W  W28, W6, W16
    SUB  W26, W14, #0x286
    CSINC  W8, W20, W6, LS
    ADDS  W5, W23, #0x138
    UMSUBL  X4, W25, W13, X19
    CLS  V29.4H, V21.4H
    SUBS  W17, W21, #0xabb
    CSNEG  X27, X18, X23, GE
    BICS  X15, X7, X3, LSR #9
    CRC32W  W29, W12, W20
    CRC32CH  W12, W3, W26
    MADD  X15, X20, X4, X4
    SUB  X5, X11, W15, SXTB #2
    SMADDL  X8, W19, W10, X5
    SUBS  X25, X25, #0x1
    B.NE  TaishanIntAluP02_label_581
    MOVZ  X19, #0xc489, LSL #0
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X14, X19, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X17, #0x467, LSL #0
    MOVK  X17, #0xf010, LSL #16
    SUB  X3, X17, X3
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X14, #0x1ea, LSL #0
    MOVK  X14, #0x1085, LSL #16
    SUB  X26, X14, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X9, #0x104a, LSL #0
    MOVK  X9, #0x125a, LSL #16
    SUB  X25, X9, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0x91ff, LSL #48
    SUB  X26, X25, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X21, #0x4, LSL #0
    MOVK  X21, #0x8, LSL #16
    SUB  X12, X21, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP02_TestFail
    MOVZ  X3, #0x31b1, LSL #0
    MOVK  X3, #0x5725, LSL #16
    MOVK  X3, #0xcb5b, LSL #32
    MOVK  X3, #0x37d, LSL #48
    SUB  X4, X3, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X25, #0x104a, LSL #0
    MOVK  X25, #0x125a, LSL #16
    SUB  X28, X25, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP02_TestFail
    MOVZ  X27, #0x23ef, LSL #0
    MOVK  X27, #0x35b6, LSL #16
    SUB  X5, X27, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X2, #0xff2, LSL #0
    MOVK  X2, #0x125a, LSL #16
    SUB  X22, X2, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X12
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP02_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x1ea, LSL #0
    MOVK  X5, #0x1085, LSL #16
    SUB  X2, X5, X14
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X23, #0x1ea, LSL #0
    MOVK  X23, #0x5b45, LSL #16
    MOVK  X23, #0x74b8, LSL #32
    MOVK  X23, #0xb9b, LSL #48
    SUB  X12, X23, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP02_TestFail
    MOVZ  X28, #0xdc11, LSL #0
    MOVK  X28, #0xca49, LSL #16
    SUB  X22, X28, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X28, #0x467, LSL #0
    MOVK  X28, #0xf010, LSL #16
    SUB  X14, X28, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x1a87, LSL #0
    MOVK  X2, #0x40, LSL #16
    SUB  X23, X2, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X8, #0xc489, LSL #0
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X25, X8, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xb3e0, LSL #16
    SUB  X21, X8, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x23ef, LSL #0
    MOVK  X6, #0x35b6, LSL #16
    SUB  X5, X6, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X26, #0x467, LSL #0
    MOVK  X26, #0xf010, LSL #16
    SUB  X15, X26, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP02_TestFail
    MOVZ  X19, #0x5e20, LSL #0
    MOVK  X19, #0xd9bf, LSL #16
    SUB  X4, X19, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
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
TaishanIntAluP02_label_608:
    MOVZ  X26, #0x569f, LSL #0
    ORR  V16.8B, V26.8B, V29.8B
    ORR  W28, W14, W28, LSR #26
    CRC32H  W28, W25, W7
    ORR  V7.8H, #0x18
    ORN  X23, X12, X17, LSL #41
    ORR  W19, W7, W12, ROR #31
    CRC32CB  W7, W8, W9
    BIC  X29, X23, X5, ROR #61
    ADDS  W8, W16, #0xa80, LSL #12
    ADD  X20, X22, W21, UXTB #2
    CSINC  X17, X2, X20, MI
    ADD  X26, X20, #0x467
    CRC32CX  W20, W11, X25
    CRC32CW  W13, W20, W2
    SUBS  W15, W28, W13, LSL #11
    AND  W14, W20, W27, LSR #15
    MOVN  X7, #0x6727, LSL #0
    CLS  W28, W15
    SBFM  X7, X11, #0x2f, #0x23
    AND  X19, X19, X14, ASR #13
    CSNEG  X3, X2, X6, VC
    UBFM  X10, X23, #0xa, #0x7
    ADDS  W7, W25, W18, ASR #6
    ANDS  X12, X13, #0xfff80000fff800
    ORR  V18.8H, #0xc4
    SUBS  W29, W7, W13, UXTX #3
    SMULH  X20, X22, X21
    CRC32CB  W2, W6, W23
    SUB  W13, W22, W3, ASR #30
    EOR  W26, W2, #0xffe0000f
    MOVK  X28, #0xe598, LSL #16
    ADC  X15, X20, X28
    ADDS  X3, X27, X5, ASR #26
    SUB  X12, X14, X11, ASR #5
    BIC  V12.16B, V19.16B, V19.16B
    SMADDL  X15, W26, W13, X9
    ADDS  X20, X16, W7, SXTH #4
    ORR  X23, X21, #0x3ffffffc3ffffffc
    CRC32B  W16, W19, W29
    CLZ  W19, W15
    MOVZ  W14, #0x4de2, LSL #16
    CRC32CH  W11, W10, W12
    EOR  X16, X18, #0x3fffffffffff0
    UMADDL  X14, W3, W19, X20
    ANDS  W10, W14, #0xe0ffffff
    BICS  X26, X26, X2, LSR #51
    CSINV  W20, W29, W18, AL
    EOR  W23, W6, #0xfdfffdff
    BICS  X3, X29, X7, ROR #17
    MOVZ  W18, #0x9d63, LSL #16
    ORN  X26, X21, X25, LSR #49
    CSINV  W8, W25, W6, NV
    ASRV  W29, W12, W8
    SUBS  X20, X29, W18, SXTW #3
    CSINC  X6, X10, X28, GE
    ADD  W27, W11, W7, SXTW #4
    SUBS  W23, W7, W16, LSR #13
    SUBS  W14, W2, W10, UXTW #3
    BICS  W18, W28, W10, LSL #6
    CRC32B  W18, W27, W25
    CLZ  X14, X23
    ADD  X23, X19, #0x4d, LSL #12
    ADDS  W22, W10, W16, UXTH #3
    CSNEG  X11, X28, X20, AL
    EXTR  X28, X15, X13, #0x23
    MOVZ  W13, #0xfa7e, LSL #16
    MOVK  W2, #0x91b9, LSL #16
    CRC32X  W26, W3, X9
    MADD  W26, W17, W13, W13
    EXTR  W20, W5, W17, #0x16
    AND  X9, X20, #0xfffffffffffffc01
    CSINV  X2, X12, X9, GT
    CRC32CW  W27, W14, W23
    SUB  X12, X14, X2, UXTX #3
    ORR  X20, X11, #0xfffffe000fffffff
    ADDS  W15, W5, #0xc4f, LSL #12
    CLZ  V19.8B, V10.8B
    ADDS  X28, X26, W23, SXTH #4
    ORR  X9, X15, #0x7fffffc00000
    BIC  V0.8B, V27.8B, V4.8B
    ASRV  X25, X12, X8
    CRC32CW  W13, W22, W25
    SUBS  X2, X20, X9, LSR #27
    EON  W20, W18, W7, ASR #24
    BICS  X27, X13, X14, LSL #18
    EOR  X17, X18, #0x7fe07fe07fe07fe
    LSLV  X28, X12, X5
    CSINV  X17, X26, X28, NE
    EOR  X17, X18, #0xff000000000007ff
    EOR  X17, X22, #0xffe00fffffe00fff
    AND  X11, X15, #0x7fc00
    CLS  W8, W15
    CSINV  W25, W29, W15, EQ
    ADDS  W14, W25, #0x36c
    BIC  X22, X17, X23, ROR #21
    EON  W17, W2, W21, LSR #22
    SBFM  W9, W2, #0x1b, #0x12
    BIC  V22.16B, V21.16B, V2.16B
    CRC32H  W20, W5, W28
    SUBS  W23, W21, #0x980
    ANDS  W17, W12, #0xf807f807
    CRC32X  W27, W13, X20
    ADCS  X26, X26, X11
    EOR  X26, X11, X5, LSR #16
    MOVN  W4, #0x4e50, LSL #16
    ORR  W15, W21, #0x7e0
    MOVK  W22, #0xe91e, LSL #0
    ADC  W7, W23, W25
    EON  X20, X10, X18, ASR #45
    CSEL  W10, W20, W4, NV
    UMSUBL  X6, W7, W16, X17
    ORR  W14, W6, W29, LSL #13
    AND  W22, W27, #0x1800
    MADD  X18, X26, X14, X9
    MOVN  W18, #0x854e, LSL #0
    ADCS  X14, X18, X14
    EOR  W26, W7, W18, LSR #29
    ORR  X12, X26, X6, LSL #35
    EOR  X17, X4, X4, ROR #2
    ORR  V13.8H, #0xb3
    UMULH  X13, X4, X7
    ADC  X22, X8, X15
    SUB  W13, W22, W28, SXTH #2
    ADDS  X10, X26, #0x5b0
    SUB  W23, W4, #0x71, LSL #12
    SMULH  X15, X9, X29
    MADD  X23, X27, X14, X29
    MOVZ  X14, #0xe240, LSL #0
    BICS  W18, W13, W8, ASR #21
    CRC32CX  W22, W9, X13
    CLS  V26.16B, V2.16B
    ADDS  W17, W26, #0x8f0
    MOVN  W10, #0x277c, LSL #16
    SUB  W10, W17, W8, ASR #28
    CRC32CW  W21, W23, W14
    SMSUBL  X7, W9, W5, X28
    SUBS  W23, W18, #0x6c4
    UMADDL  X10, W6, W11, X16
    CSEL  X8, X26, X8, MI
    ADD  W20, W9, W19, UXTH #2
    SMSUBL  X8, W5, W26, X26
    CLZ  X21, X8
    EOR  W27, W22, #0x1f80
    ANDS  W15, W28, W11, ROR #17
    UMULH  X17, X10, X13
    SUB  X20, X18, X12, UXTX #3
    EOR  X10, X16, X5, ROR #47
    CRC32H  W21, W8, W14
    LSLV  W22, W12, W6
    CRC32B  W2, W25, W15
    ORR  X15, X27, #0xfffffffffc0000
    UBFM  X28, X16, #0x8, #0x1b
    UMSUBL  X9, W28, W17, X12
    ADDS  W4, W28, #0x9f0, LSL #12
    ADDS  X11, X18, W17, SXTH #2
    SUBS  X28, X18, W10, UXTW #0
    SUB  X29, X3, X19, UXTX #0
    BICS  X9, X4, X15, ASR #29
    CRC32CH  W14, W13, W22
    ORR  W10, W20, #0x3fe
    CSINC  W29, W2, W8, GT
    BICS  W6, W20, W28, ASR #26
    ANDS  W29, W26, W25, ASR #18
    ADDS  W26, W20, W25, LSR #5
    AND  X17, X14, #0xff81ffffffffffff
    ADDS  W25, W19, #0x589, LSL #12
    SMULH  X20, X2, X26
    ADD  X10, X21, W28, UXTH #0
    ADCS  X8, X9, X20
    EOR  X23, X22, #0xc0000000ffffffff
    LSLV  W20, W11, W3
    SUBS  X14, X25, X20, LSL #51
    CSNEG  X11, X10, X9, CS
    BICS  X2, X25, X23, LSL #40
    MOVK  X8, #0x617c, LSL #16
    MOVK  W25, #0x58bc, LSL #0
    ANDS  W20, W14, W21, ASR #22
    SUB  W9, W11, #0xd34
    ORR  V10.4H, #0x2e
    EXTR  W22, W4, W26, #0x8
    ORR  X26, X29, #0x40004000400040
    CLZ  V14.16B, V31.16B
    MOVK  W21, #0x62a6, LSL #0
    LSLV  X25, X27, X8
    EXTR  X2, X8, X18, #0x1b
    CSINC  W29, W29, W6, GT
    ORN  X15, X2, X22, ASR #37
    ORR  X15, X7, #0x3ffffff00000000
    UMULH  X4, X2, X29
    EOR  X23, X29, X6, LSL #26
    ADDS  X10, X9, W28, SXTW #3
    SUBS  X23, X11, X9, ASR #41
    SUBS  W4, W23, W28, SXTH #3
    ADC  X4, X20, X3
    CRC32CW  W14, W16, W15
    ORN  X4, X3, X15, LSR #22
    AND  W7, W20, #0xcccccccc
    CRC32CH  W26, W22, W28
    SUBS  W22, W18, #0xe20
    SUBS  X5, X5, #0x1
    B.NE  TaishanIntAluP02_label_608
    MOVZ  X21, #0x11, LSL #0
    MOVK  X21, #0x2f80, LSL #48
    SUB  X18, X21, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP02_TestFail
    MOVZ  X11, #0x14cd, LSL #0
    MOVK  X11, #0xab66, LSL #16
    SUB  X27, X11, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X14, #0x14cd, LSL #0
    MOVK  X14, #0xab66, LSL #16
    MOVK  X14, #0xfc00, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X29, X14, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP02_TestFail
    MOVZ  X26, #0x1, LSL #0
    SUB  X3, X26, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X28, #0x8000, LSL #0
    MOVK  X28, #0x48, LSL #16
    SUB  X14, X28, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X9, #0xf5cd, LSL #0
    MOVK  X9, #0xbe7d, LSL #16
    SUB  X17, X9, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X15, #0xab4d, LSL #0
    MOVK  X15, #0x5d4f, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X12, X15, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x14cd, LSL #0
    MOVK  X2, #0xab66, LSL #16
    SUB  X18, X2, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X15, #0xf4ed, LSL #0
    MOVK  X15, #0x8a9c, LSL #16
    SUB  X27, X15, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP02_TestFail
    MOVZ  X8, #0xf4ed, LSL #0
    MOVK  X8, #0x8a9c, LSL #16
    SUB  X25, X8, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X21, #0xbe3d, LSL #0
    MOVK  X21, #0xb6c0, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0x3, LSL #48
    SUB  X27, X21, X16
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X17, #0x2, LSL #0
    SUB  X2, X17, X19
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X13, #0x9000, LSL #0
    MOVK  X13, #0x58, LSL #16
    SUB  X26, X13, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP02_TestFail
    MOVZ  X10, #0xe6cd, LSL #0
    MOVK  X10, #0x8a9c, LSL #16
    SUB  X13, X10, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP02_TestFail
    MOVZ  X25, #0x301, LSL #0
    MOVK  X25, #0xbe7e, LSL #16
    SUB  X14, X25, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x301, LSL #0
    MOVK  X2, #0xbe7e, LSL #16
    SUB  X14, X2, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X26, X16, X26
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X14, X22, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X2, X22, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X8, X9, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x8ad4, LSL #0
    MOVK  X2, #0xbef, LSL #16
    MOVK  X2, #0x30, LSL #32
    MOVK  X2, #0xd549, LSL #48
    MOVZ  X3, #0x5d5b, LSL #0
    MOVK  X3, #0x688b, LSL #16
    MOVK  X3, #0x7068, LSL #32
    MOVK  X3, #0xc70c, LSL #48
    MOVZ  X4, #0x938d, LSL #0
    MOVK  X4, #0xa6b9, LSL #16
    MOVK  X4, #0x7e53, LSL #32
    MOVK  X4, #0x548f, LSL #48
    MOVZ  X5, #0x7cc6, LSL #0
    MOVK  X5, #0xc32, LSL #16
    MOVK  X5, #0x2cd6, LSL #32
    MOVK  X5, #0xf1de, LSL #48
    MOVZ  X6, #0xe49, LSL #0
    MOVK  X6, #0x9713, LSL #16
    MOVK  X6, #0xb299, LSL #32
    MOVK  X6, #0xc7db, LSL #48
    MOVZ  X7, #0xcc, LSL #0
    MOVK  X7, #0x5d2a, LSL #16
    MOVK  X7, #0xfa8f, LSL #32
    MOVK  X7, #0xe0b2, LSL #48
    MOVZ  X8, #0x64df, LSL #0
    MOVK  X8, #0x2aa7, LSL #16
    MOVK  X8, #0xfe37, LSL #32
    MOVK  X8, #0xbaec, LSL #48
    MOVZ  X9, #0x2211, LSL #0
    MOVK  X9, #0x8e8b, LSL #16
    MOVK  X9, #0x68b4, LSL #32
    MOVK  X9, #0x689, LSL #48
    MOVZ  X10, #0xd10a, LSL #0
    MOVK  X10, #0xb653, LSL #16
    MOVK  X10, #0x7679, LSL #32
    MOVK  X10, #0x54f3, LSL #48
    MOVZ  X11, #0xa4a6, LSL #0
    MOVK  X11, #0x92d3, LSL #16
    MOVK  X11, #0x29a3, LSL #32
    MOVK  X11, #0x5161, LSL #48
    MOVZ  X12, #0x7e51, LSL #0
    MOVK  X12, #0xa5ba, LSL #16
    MOVK  X12, #0xd130, LSL #32
    MOVK  X12, #0xc1b1, LSL #48
    MOVZ  X13, #0xc94a, LSL #0
    MOVK  X13, #0x88c2, LSL #16
    MOVK  X13, #0x3468, LSL #32
    MOVK  X13, #0x15c1, LSL #48
    MOVZ  X14, #0xb5ef, LSL #0
    MOVK  X14, #0x43e9, LSL #16
    MOVK  X14, #0x4edc, LSL #32
    MOVK  X14, #0x36d9, LSL #48
    MOVZ  X15, #0x21a1, LSL #0
    MOVK  X15, #0xbd4e, LSL #16
    MOVK  X15, #0xd667, LSL #32
    MOVK  X15, #0xd42c, LSL #48
    MOVZ  X16, #0x8419, LSL #0
    MOVK  X16, #0x1ae2, LSL #16
    MOVK  X16, #0x21c4, LSL #32
    MOVK  X16, #0x5719, LSL #48
    MOVZ  X17, #0x702b, LSL #0
    MOVK  X17, #0x26ea, LSL #16
    MOVK  X17, #0x5c2c, LSL #32
    MOVK  X17, #0x891b, LSL #48
    MOVZ  X18, #0x4085, LSL #0
    MOVK  X18, #0xdcea, LSL #16
    MOVK  X18, #0xea43, LSL #32
    MOVK  X18, #0x18a, LSL #48
    MOVZ  X19, #0xdee3, LSL #0
    MOVK  X19, #0xabba, LSL #16
    MOVK  X19, #0x2570, LSL #32
    MOVK  X19, #0x942c, LSL #48
    MOVZ  X20, #0x3fde, LSL #0
    MOVK  X20, #0xf2a4, LSL #16
    MOVK  X20, #0xf251, LSL #32
    MOVK  X20, #0x269c, LSL #48
    MOVZ  X21, #0xcff7, LSL #0
    MOVK  X21, #0x13ac, LSL #16
    MOVK  X21, #0x5d34, LSL #32
    MOVK  X21, #0x239d, LSL #48
    MOVZ  X22, #0x4913, LSL #0
    MOVK  X22, #0xbe2f, LSL #16
    MOVK  X22, #0x5cfc, LSL #32
    MOVK  X22, #0xdeb2, LSL #48
    MOVZ  X23, #0x9b70, LSL #0
    MOVK  X23, #0x36f3, LSL #16
    MOVK  X23, #0x9610, LSL #32
    MOVK  X23, #0x48db, LSL #48
    MOVZ  X25, #0xa47b, LSL #0
    MOVK  X25, #0x918c, LSL #16
    MOVK  X25, #0xd9cd, LSL #32
    MOVK  X25, #0x989b, LSL #48
    MOVZ  X26, #0xce5e, LSL #0
    MOVK  X26, #0xea74, LSL #16
    MOVK  X26, #0xc437, LSL #32
    MOVK  X26, #0x527b, LSL #48
    MOVZ  X27, #0xd37f, LSL #0
    MOVK  X27, #0xe9ee, LSL #16
    MOVK  X27, #0xe6b1, LSL #32
    MOVK  X27, #0xd33, LSL #48
    MOVZ  X28, #0x2cb9, LSL #0
    MOVK  X28, #0x81dc, LSL #16
    MOVK  X28, #0x6a8e, LSL #32
    MOVK  X28, #0x6625, LSL #48
    MOVZ  X29, #0xfa6c, LSL #0
    MOVK  X29, #0xded1, LSL #16
    MOVK  X29, #0x4d48, LSL #32
    MOVK  X29, #0x9e62, LSL #48
    MOVZ  X22, #0xa, LSL #0
TaishanIntAluP02_label_632:
    CLZ  X10, X27
    CRC32CB  W29, W3, W12
    CLS  V11.8B, V2.8B
    ORR  W25, W2, #0xfff9fff9
    SBFM  W20, W25, #0x6, #0x4
    AND  W23, W6, #0x3fff3fff
    ANDS  W23, W12, #0xfe07fe07
    ADD  W29, W29, #0x459, LSL #12
    EOR  W18, W29, #0xff83ffff
    ORR  V30.2S, #0x5e, LSL #16
    MOVZ  X14, #0x3158, LSL #0
    ADC  X14, X17, X11
    ADDS  X10, X18, X7, SXTX #3
    SUBS  W16, W7, #0x35c
    CRC32CX  W4, W22, X22
    LSRV  W9, W20, W16
    MOVZ  X15, #0xb984, LSL #16
    CRC32H  W4, W21, W22
    CLS  X18, X28
    BIC  W21, W27, W10, ASR #6
    SUB  W27, W3, W15, SXTB #1
    LSLV  X27, X3, X23
    ADD  W20, W14, W22, SXTB #1
    EXTR  X18, X7, X17, #0x21
    ADDS  W27, W25, #0x675
    SBFM  W11, W18, #0x1d, #0x1d
    CRC32X  W18, W20, X20
    SUBS  W14, W28, W5, SXTH #3
    EON  W14, W27, W28, ROR #12
    ANDS  W12, W8, #0xfffff8ff
    ADDS  W7, W20, W5, UXTB #4
    ANDS  W16, W21, #0x7fffffe
    ADD  W7, W16, W10, LSR #13
    ADDS  X16, X12, W5, UXTH #2
    ADD  X9, X15, X9, UXTX #4
    SUB  X13, X19, W28, SXTB #3
    CSINC  W8, W28, W23, NV
    SMSUBL  X20, W27, W27, X16
    UMULH  X9, X16, X13
    EOR  X19, X17, X9, LSR #13
    CSNEG  X19, X18, X22, HI
    BIC  W27, W4, W23, ROR #21
    SUBS  W27, W6, #0xac1, LSL #12
    ORR  X2, X20, #0x3c003c003c003c0
    CLZ  X25, X3
    CRC32CB  W14, W25, W2
    ORN  X17, X14, X14, ASR #17
    SUB  W27, W14, #0x841
    SBFM  W13, W19, #0x3, #0x7
    SUBS  W11, W19, #0xd9a
    ADCS  W28, W25, W28
    ADD  X25, X4, #0x1b4
    SUBS  X5, X7, #0xa55, LSL #12
    UBFM  W12, W9, #0x6, #0x17
    ORR  X2, X16, #0x7f0
    ORR  W5, W15, #0xcfcfcfcf
    ADCS  W6, W23, W11
    ANDS  W18, W9, #0x77777777
    UMULH  X18, X2, X15
    ORR  V30.8B, V15.8B, V23.8B
    BICS  X14, X23, X17, ASR #2
    CSNEG  W11, W29, W21, LT
    ORN  X11, X17, X25, LSL #10
    SBFM  X27, X26, #0x26, #0x2c
    SUBS  W20, W14, #0xc10
    SUBS  X23, X15, X26, ASR #30
    LSLV  W23, W16, W27
    BICS  X15, X11, X19, ASR #17
    ADDS  W6, W7, W18, LSR #14
    CSINC  W26, W5, W5, NV
    EOR  X26, X20, X9, LSR #31
    SUB  W29, W3, W26, LSR #30
    CLS  V23.8B, V22.8B
    CSINC  X21, X29, X5, LE
    MOVN  W25, #0x4f72, LSL #16
    EON  W26, W29, W27, LSR #28
    ORR  V21.4H, #0x13, LSL #8
    MOVK  X16, #0xe3cf, LSL #48
    MOVZ  W2, #0xcd5d, LSL #16
    SUBS  X13, X10, X14, ASR #29
    ADD  W17, W18, W11, SXTB #3
    ORR  V1.4S, #0x21
    CRC32CH  W11, W19, W12
    SUBS  W21, W16, W23, SXTW #2
    ORR  V16.8B, V17.8B, V11.8B
    CSNEG  X15, X16, X16, VS
    ADD  X29, X15, X26, SXTX #2
    MOVZ  W11, #0xc519, LSL #0
    SMSUBL  X12, W20, W15, X15
    SUB  W2, W29, W17, SXTH #2
    SMULH  X16, X13, X25
    CLZ  V10.8B, V13.8B
    ORR  V17.4H, #0xba, LSL #8
    ADD  X14, X29, W21, SXTW #1
    CSEL  X14, X27, X10, CS
    ADDS  W14, W25, W4, SXTX #2
    EXTR  X23, X21, X25, #0x24
    UMULH  X6, X15, X7
    AND  X16, X2, #0xffe
    SBFM  X2, X19, #0x8, #0x2e
    UMULH  X12, X21, X10
    UMSUBL  X20, W16, W15, X14
    UMSUBL  X7, W26, W11, X23
    CSINC  W10, W2, W12, CS
    ADC  W19, W27, W13
    MOVN  W14, #0xd0d5, LSL #0
    ORR  X18, X8, X7, ROR #46
    LSLV  X5, X7, X16
    SUB  X25, X19, X12, ASR #19
    MOVK  W26, #0xc0e1, LSL #16
    AND  X11, X20, #0x1f00000000000000
    ANDS  W4, W25, #0x40000000
    ASRV  W14, W16, W9
    SUB  X10, X10, #0x3b
    CRC32W  W2, W14, W10
    ORR  V26.8H, #0x72
    SUB  W15, W11, W2, UXTH #3
    ORR  V20.4H, #0x50, LSL #8
    SMULH  X2, X5, X5
    AND  W25, W15, #0x7fff0000
    SMSUBL  X20, W2, W19, X9
    MOVK  W29, #0x2da, LSL #0
    CRC32CX  W25, W5, X5
    SBFM  W12, W25, #0xb, #0x7
    CLZ  V20.16B, V15.16B
    UBFM  X3, X26, #0x16, #0x1b
    AND  W23, W13, #0x700000
    SUB  W25, W6, W16, UXTX #0
    EOR  W2, W3, #0xffffff8f
    CLZ  W9, W11
    ORR  X14, X26, X22, ASR #42
    UBFM  W27, W26, #0x3, #0x1c
    UMSUBL  X5, W21, W10, X14
    ADD  X29, X5, X2, UXTX #3
    ORR  W28, W2, #0xfffe3fff
    CSINV  W29, W6, W18, NE
    ORR  V16.8B, V15.8B, V24.8B
    BIC  X15, X14, X28, LSL #59
    CRC32CH  W25, W25, W12
    CSNEG  X25, X19, X4, EQ
    ADC  W18, W29, W26
    CRC32CH  W6, W13, W8
    SUBS  X6, X19, W4, SXTH #2
    CSINC  X6, X22, X7, CS
    CRC32CX  W12, W12, X13
    LSLV  X10, X11, X20
    SUBS  W9, W11, W16, LSL #28
    ASRV  W8, W6, W29
    CSINC  W21, W3, W12, LE
    ANDS  W5, W23, W15, LSR #21
    SUBS  W18, W20, W21, LSR #22
    AND  W21, W15, W28, ROR #19
    ADDS  X13, X16, #0x32c, LSL #12
    SMADDL  X5, W14, W16, X3
    ADD  X12, X8, X2, LSR #38
    CLZ  X3, X14
    ADCS  W21, W4, W14
    SUBS  W21, W8, #0x37
    MOVK  X14, #0xc846, LSL #48
    ANDS  W12, W26, #0x88888888
    CLS  X5, X25
    LSRV  X18, X16, X3
    CSINV  X3, X4, X13, AL
    CSEL  X5, X9, X16, HI
    SUBS  W12, W11, W22, UXTX #2
    CLZ  V14.4S, V6.4S
    ASRV  X15, X21, X27
    LSRV  W14, W21, W27
    CSINV  W13, W14, W2, GE
    ORR  W19, W15, #0xf0f0f0f
    BICS  X20, X12, X28, LSR #17
    EOR  X5, X4, #0xfffe0000fffe0000
    ORR  X8, X6, #0xffff07ffffff07ff
    ADC  X12, X27, X11
    UBFM  X9, X11, #0x25, #0x27
    ADDS  W12, W2, W6, UXTW #1
    MOVZ  X8, #0x55e, LSL #16
    UBFM  W9, W6, #0xe, #0x2
    BICS  X16, X20, X25, ROR #30
    CRC32CH  W16, W12, W2
    MOVK  X11, #0x3f8, LSL #0
    ADCS  X4, X27, X4
    CSNEG  X29, X14, X16, LE
    ADDS  W13, W21, W5, UXTB #1
    ADDS  X21, X8, #0x1e1
    CSEL  W26, W3, W4, LE
    ANDS  X12, X23, X28, ROR #26
    SUBS  X5, X29, W23, SXTB #3
    CLZ  V26.4H, V7.4H
    CSINC  X23, X6, X18, AL
    SUB  X4, X8, W3, UXTW #4
    ADD  X14, X23, #0x680
    EOR  W2, W20, #0x7f000
    ADDS  W26, W23, #0xd98
    SUB  W17, W23, W25, ASR #0
    ORR  W7, W22, W29, ASR #31
    SUB  X18, X28, X10, LSR #22
    ADDS  X29, X28, X7, LSL #31
    SUB  W16, W26, #0xb48, LSL #12
    ADDS  W5, W14, W3, LSL #3
    SUBS  X22, X22, #0x1
    B.NE  TaishanIntAluP02_label_632
    MOVZ  X11, #0x7000, LSL #0
    MOVK  X11, #0xfff8, LSL #16
    SUB  X17, X11, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x4000, LSL #16
    SUB  X14, X21, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x55e, LSL #16
    MOVK  X5, #0xfffc, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X7, X5, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x55e, LSL #16
    MOVK  X5, #0xfffc, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X11, X5, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X26, #0x1, LSL #0
    SUB  X17, X26, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x55e, LSL #16
    SUB  X26, X4, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x4, LSL #16
    SUB  X17, X21, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x1f00, LSL #48
    SUB  X21, X29, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X11
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP02_TestFail
    MOVZ  X28, #0xffc9, LSL #0
    MOVK  X28, #0xffff, LSL #16
    SUB  X11, X28, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X12, X28, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP02_TestFail
    MOVZ  X28, #0xffc9, LSL #0
    MOVK  X28, #0xffff, LSL #16
    SUB  X15, X28, X15
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP02_TestFail
    MOVZ  X20, #0x8d99, LSL #0
    MOVK  X20, #0xff4b, LSL #16
    SUB  X29, X20, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X14, X19, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xff84, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X22, X3, X18
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X23, X19, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x8d99, LSL #0
    MOVK  X2, #0xff4b, LSL #16
    SUB  X14, X2, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X22
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X25
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X9, #0xffc9, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X21, X9, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X21, #0xa, LSL #0
TaishanIntAluP02_label_658:
    ORR  V18.8H, #0xd
    ADC  X15, X10, X12
    ADD  X28, X2, #0x6e0
    CLS  W28, W8
    SUBS  W13, W29, W3, LSR #21
    CSINV  W6, W16, W22, VC
    ORR  X18, X11, #0xf000f000f000f0
    ADC  X18, X12, X20
    ADDS  X23, X4, X25, ASR #16
    CSINV  X18, X12, X19, NE
    ADD  X15, X11, #0xc31, LSL #12
    BICS  X2, X6, X23, ASR #58
    LSLV  W25, W2, W5
    ADDS  W19, W4, #0x750
    CRC32X  W19, W21, X17
    ADC  W7, W5, W19
    MOVZ  W20, #0xb01a, LSL #0
    CLS  X6, X4
    ADDS  W4, W16, W26, SXTH #4
    UMULH  X18, X22, X26
    SUBS  X16, X4, X26, LSR #49
    SUBS  W18, W23, W9, LSR #25
    SUB  X10, X21, X5, ASR #38
    ASRV  X19, X21, X23
    LSLV  W26, W13, W16
    ADDS  X5, X20, X25, LSL #13
    EOR  X29, X4, #0xffffffffe03fffff
    ORR  V10.8B, V13.8B, V21.8B
    UBFM  X13, X15, #0x8, #0x19
    SUB  X9, X26, W13, SXTW #1
    CRC32H  W22, W7, W12
    SMADDL  X19, W25, W14, X13
    CRC32W  W25, W19, W13
    SUBS  W13, W19, W14, LSR #12
    BICS  X12, X11, X5, ASR #51
    ORR  V16.4H, #0xbd
    SUB  X25, X13, X22, ASR #2
    ADDS  X5, X12, #0x201, LSL #12
    ADDS  W25, W6, W19, ASR #17
    CRC32CX  W20, W18, X22
    ANDS  W23, W27, #0xbbbbbbbb
    CSINV  X11, X9, X13, LT
    ORR  W29, W18, #0xf80fffff
    ADCS  X8, X10, X10
    SUBS  W22, W5, W3, ASR #25
    UBFM  X3, X16, #0x37, #0x12
    UBFM  W11, W29, #0xe, #0x8
    SUB  X25, X20, X21, ASR #28
    EOR  X19, X5, #0xff807fffff807fff
    CSINC  W8, W23, W19, VC
    CRC32W  W9, W21, W2
    EOR  W17, W23, W25, ASR #31
    SUB  W29, W2, W18, SXTX #2
    MADD  X29, X6, X17, X7
    UBFM  X9, X2, #0x35, #0x3c
    SUB  W22, W13, W17, UXTH #1
    CLS  X5, X3
    SMADDL  X14, W8, W7, X13
    ADD  X6, X25, X5, LSL #53
    MOVK  W10, #0xf61f, LSL #0
    ANDS  X13, X11, #0x1f801f801f801f8
    AND  W29, W20, #0xffff0000
    ASRV  W2, W23, W18
    BICS  X25, X3, X2, ASR #0
    ADDS  X25, X14, X16, LSL #32
    EON  W8, W13, W6, ROR #19
    CSINV  X10, X11, X13, CC
    CRC32H  W5, W5, W23
    BIC  X26, X19, X25, LSL #58
    ADD  X5, X6, X19, ASR #45
    CRC32CB  W8, W7, W23
    CSINC  W26, W29, W17, GE
    SUBS  X12, X2, X6, LSL #35
    MADD  W25, W19, W17, W18
    EOR  X26, X21, X23, LSR #21
    ORR  V0.4H, #0x36, LSL #8
    ADD  X14, X26, W10, SXTW #3
    UMULH  X13, X14, X17
    SMULH  X19, X11, X15
    ADDS  X6, X4, X26, ASR #26
    ADCS  W25, W9, W22
    ORR  W19, W13, #0x1c001c0
    AND  W8, W13, #0x22222222
    ORN  W2, W11, W21, ASR #19
    CRC32CB  W29, W20, W21
    ANDS  X2, X28, X23, LSL #62
    SUBS  X4, X5, #0x930, LSL #12
    EON  X7, X22, X5, LSL #10
    ASRV  W5, W17, W4
    SUB  X11, X19, W7, SXTW #3
TaishanIntAluP02_label_401:
    MADD  W16, W12, W23, W22
    ADCS  W11, W8, W8
    CLZ  W27, W12
    CRC32CH  W17, W8, W2
    AND  W20, W17, W26, LSL #9
    ADCS  X12, X10, X4
    CRC32CX  W25, W18, X8
    BICS  W28, W21, W10, LSR #12
    ORR  X17, X8, X9, LSR #11
    ADD  X13, X13, W5, UXTH #0
    EXTR  W9, W9, W10, #0x15
    ADCS  X25, X13, X15
    LSLV  X13, X28, X28
    BIC  V6.16B, V2.16B, V15.16B
    ASRV  X14, X7, X21
    CRC32X  W19, W19, X6
    UBFM  X3, X2, #0x0, #0x25
    UBFM  W26, W11, #0x17, #0x7
    AND  W10, W23, #0xff07ff07
    EON  X18, X20, X28, LSR #61
    SUBS  X4, X25, X14, LSR #60
    ADCS  X25, X22, X20
    CRC32W  W7, W22, W28
    SUB  W2, W6, #0x0
    CSEL  W29, W28, W17, VC
    ADC  W20, W12, W2
    BICS  X28, X2, X18, ASR #21
    SUB  W7, W17, W19, LSL #13
    BIC  V16.16B, V1.16B, V3.16B
    BICS  W23, W22, W15, ROR #27
    CLZ  X10, X22
    ORR  X8, X22, #0xffe0ffe0ffe0ffe
    ORN  W28, W3, W25, ASR #29
    ADD  X7, X8, X11, UXTX #1
    CRC32CH  W4, W5, W13
    MOVN  X10, #0xb982, LSL #48
    CRC32CH  W22, W4, W23
    CSNEG  W27, W2, W14, GE
    MOVK  X2, #0x4d4a, LSL #0
    MOVK  W10, #0xbb28, LSL #0
    ADD  W19, W23, W6, LSR #28
    SMSUBL  X17, W23, W19, X15
    MOVN  X2, #0x28cf, LSL #16
    EON  X5, X7, X26, LSL #23
    BIC  X6, X17, X12, ROR #24
    ADDS  X22, X11, #0x580
    CLZ  W29, W3
    CRC32W  W3, W27, W22
    CSNEG  X28, X5, X9, PL
    CSEL  X2, X13, X5, LE
    BIC  X8, X28, X10, ASR #13
    ORR  W8, W11, W21, LSR #11
    CRC32CB  W7, W6, W22
    CLS  X9, X13
    SBFM  X26, X11, #0x2e, #0x2c
    ADD  W8, W12, W16, SXTB #0
    ORR  W8, W9, #0xffe0ffe
    CLZ  W12, W7
    MADD  X3, X6, X11, X3
    EON  X17, X6, X2, LSL #28
    CSEL  X23, X27, X14, LT
    CSNEG  W2, W20, W28, NV
    ADCS  X23, X4, X22
    LSRV  X14, X15, X3
    ADDS  X15, X19, #0x44a, LSL #12
    EOR  W2, W6, #0xff
    LSRV  W4, W4, W9
    ADD  X12, X27, #0x1cf
    CLS  V11.8B, V20.8B
    ADDS  X4, X15, X26, ASR #32
    SUB  W17, W13, #0xea1
    SUB  W17, W9, W16, SXTW #3
    ADD  X17, X10, X28, ASR #40
    ADDS  X12, X12, W10, SXTH #4
    ORN  W15, W29, W4, ASR #14
    SUB  X23, X2, X6, LSR #57
    CRC32B  W17, W2, W6
    SBFM  W12, W11, #0x4, #0x6
    LSLV  X22, X28, X6
    EXTR  W6, W25, W20, #0x7
    SMSUBL  X3, W22, W15, X3
    CSINC  X14, X23, X27, HI
    BICS  W29, W5, W15, ASR #5
    EXTR  W2, W18, W20, #0xd
    CSEL  W26, W8, W2, HI
    SUBS  X15, X21, X16, LSL #21
    SUB  W6, W6, W4, LSL #14
    ADDS  X19, X4, #0xac4, LSL #12
    ADCS  X28, X29, X19
    UBFM  X3, X11, #0x38, #0x2a
    ORN  X10, X12, X26, ROR #47
    ADD  X25, X17, X17, ASR #39
    UBFM  X20, X14, #0x6, #0x5
    CRC32X  W8, W20, X27
    EOR  W16, W26, #0xffc0001f
    SUB  W17, W19, W28, SXTB #0
    SUBS  W9, W20, W7, SXTW #1
    CSNEG  W2, W19, W23, EQ
    MOVN  W3, #0xdd0b, LSL #16
    SUB  X20, X18, X5, UXTX #0
    ADD  W2, W9, W4, SXTH #2
    EON  X26, X15, X7, ASR #0
    UMULH  X16, X25, X18
    SUBS  W29, W4, W29, ASR #11
    LSLV  W7, W26, W13
    EXTR  X19, X7, X27, #0x14
    ADD  W16, W20, W15, ASR #22
    ADCS  W17, W5, W14
    SUB  X18, X2, #0x770, LSL #12
    AND  X17, X3, X8, LSR #12
    SUBS  X21, X21, #0x1
    B.NE  TaishanIntAluP02_label_658
    MOVZ  X12, #0x6c14, LSL #0
    MOVK  X12, #0x70cf, LSL #16
    SUB  X21, X12, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP02_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0x22f4, LSL #16
    SUB  X5, X25, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X9, #0x7c13, LSL #0
    MOVK  X9, #0xe7e2, LSL #16
    SUB  X8, X9, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X28, X13, X5
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP02_TestFail
    MOVZ  X25, #0x70d, LSL #0
    MOVK  X25, #0x6919, LSL #16
    SUB  X10, X25, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X8, #0xbde2, LSL #0
    MOVK  X8, #0x89c6, LSL #16
    SUB  X25, X8, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X12, #0xbde2, LSL #0
    MOVK  X12, #0x89c6, LSL #16
    SUB  X20, X12, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x7c13, LSL #0
    MOVK  X2, #0xe7e2, LSL #16
    SUB  X5, X2, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X10
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X17, #0x4445, LSL #0
    MOVK  X17, #0x4000, LSL #16
    SUB  X18, X17, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP02_TestFail
    MOVZ  X4, #0xbde2, LSL #0
    MOVK  X4, #0x89c6, LSL #16
    SUB  X19, X4, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X27, X5, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X14
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x1, LSL #0
    MOVK  X16, #0xb1a0, LSL #16
    MOVK  X16, #0xbc1b, LSL #32
    MOVK  X16, #0xfff5, LSL #48
    SUB  X29, X16, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP02_TestFail
    MOVZ  X18, #0x1, LSL #0
    MOVK  X18, #0xb1a0, LSL #16
    MOVK  X18, #0xbc1b, LSL #32
    MOVK  X18, #0xfff5, LSL #48
    SUB  X26, X18, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X17, #0x4445, LSL #0
    MOVK  X17, #0x4000, LSL #16
    SUB  X8, X17, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP02_TestFail
    MOVZ  X18, #0x1, LSL #0
    MOVK  X18, #0xb1a0, LSL #16
    MOVK  X18, #0xbc1b, LSL #32
    MOVK  X18, #0xfff5, LSL #48
    SUB  X6, X18, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X10, #0x332, LSL #0
    MOVK  X10, #0x3d5, LSL #16
    SUB  X13, X10, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X26
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X27
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
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
    MOVZ  X25, #0xa, LSL #0
TaishanIntAluP02_label_682:
    ANDS  W17, W22, W28, ASR #14
    EON  W10, W21, W14, LSL #27
    BIC  V24.16B, V28.16B, V6.16B
    CSINC  W17, W18, W5, HI
    MOVZ  W27, #0x35c9, LSL #16
    UBFM  W12, W4, #0x13, #0x5
    ANDS  W10, W19, W9, LSR #19
    UMADDL  X27, W19, W25, X21
    CRC32W  W3, W10, W19
    MOVZ  X13, #0xb547, LSL #32
    MOVK  W15, #0x1e94, LSL #16
    MOVN  W17, #0x7c3a, LSL #16
    ORR  X17, X19, #0xffff81ffffff81ff
    UMULH  X9, X12, X23
    SUB  W6, W9, #0x2f0
    CRC32B  W17, W8, W5
    MOVN  W13, #0x7bef, LSL #16
    ANDS  X11, X16, X4, LSL #16
    EXTR  X22, X4, X6, #0x20
    EON  X5, X19, X19, ROR #63
    SUB  X6, X10, X22, SXTX #4
    SBFM  W3, W17, #0x7, #0x9
    EOR  W6, W13, W15, ASR #15
    CSINV  W4, W21, W2, LS
    UMADDL  X3, W5, W3, X8
    EOR  X22, X22, #0xfffcfffffffcffff
    BICS  X9, X19, X11, LSL #2
    MOVZ  X16, #0xdf2e, LSL #0
    AND  W5, W20, #0xe000007f
    SMSUBL  X19, W4, W13, X26
    CLZ  X17, X25
    SUB  W14, W6, W12, LSR #13
    CRC32H  W17, W5, W18
    CSINV  X11, X17, X22, NE
    ORR  W28, W4, #0x38000
    AND  W21, W14, W25, LSL #14
    ADD  X22, X5, W20, SXTW #3
    CRC32W  W17, W3, W2
    BIC  X8, X8, X26, ASR #53
    MOVK  X23, #0x535c, LSL #0
    ADCS  X6, X15, X19
    UMSUBL  X9, W10, W6, X20
    ADD  W8, W19, W8, ASR #0
    ADD  W28, W9, W12, UXTH #2
    SMULH  X8, X9, X7
    MADD  W12, W10, W27, W26
    CLZ  V10.4H, V1.4H
    CRC32H  W4, W13, W16
    LSLV  X4, X8, X8
    EXTR  W26, W23, W20, #0x7
    MOVN  W20, #0xadba, LSL #16
    BICS  W19, W16, W5, LSL #11
    SUB  X26, X23, #0x788
    EOR  W17, W8, #0x81ffffff
    EON  W16, W15, W14, ROR #29
    CSNEG  X6, X2, X5, EQ
    MOVK  W21, #0x528, LSL #0
    MADD  W3, W11, W15, W28
    BICS  W12, W21, W8, LSR #8
    ADD  W4, W16, W4, UXTX #0
    SUB  W9, W10, #0xc10
    ADC  X14, X25, X16
    ANDS  W7, W14, #0x9fff9fff
    MADD  X5, X25, X3, X26
    BIC  W2, W19, W6, LSR #20
    EXTR  X11, X21, X25, #0x32
    MADD  W28, W25, W21, W8
    SUB  X17, X21, W12, UXTB #0
    LSLV  X21, X23, X23
    MOVN  X7, #0x5c6b, LSL #16
    ADC  X13, X21, X7
    ANDS  W17, W6, #0xfffffff0
    EOR  X12, X26, #0x1fff00001fff0
    CRC32H  W7, W25, W3
    ORR  V12.8B, V28.8B, V16.8B
    AND  W3, W8, #0x3ff0
    BICS  X28, X12, X21, ASR #36
    ASRV  X9, X17, X3
    MOVZ  W14, #0x6940, LSL #16
    ADC  W8, W11, W21
    ADC  X14, X21, X6
    ADC  W18, W22, W6
    ORR  X8, X16, X26, LSR #29
    ANDS  W6, W15, W26, LSL #10
    LSRV  W21, W17, W28
    CLZ  X15, X14
    SUB  X8, X27, X20, LSR #62
    ADDS  W14, W10, W25, ASR #18
    ASRV  X13, X20, X7
    AND  X9, X27, #0xffffe007ffffffff
    MADD  W15, W12, W15, W16
    SBFM  W9, W7, #0x5, #0x2
    BIC  W7, W26, W27, ROR #20
    CLS  W21, W18
    ORR  V6.4S, #0x5e, LSL #24
    ADD  X16, X5, #0x1f, LSL #12
    ORR  V21.2S, #0xbd, LSL #24
    ORN  W12, W20, W5, ROR #4
    EOR  W12, W22, #0x70707070
    ORR  W6, W6, W8, LSL #8
    MOVK  X5, #0xcf34, LSL #48
    SUB  X8, X14, X18, LSR #60
    MOVK  X22, #0x7705, LSL #0
    ANDS  X7, X12, #0xfffffffc00007fff
    SUBS  X3, X8, W10, UXTH #4
    ADC  W10, W4, W11
    CSNEG  W17, W6, W7, VC
    LSLV  X18, X23, X17
    BICS  W17, W17, W21, ASR #3
    SUBS  W20, W29, W3, SXTH #4
    BIC  X6, X23, X28, LSL #6
    ORN  W6, W28, W22, LSL #1
    ORR  X9, X27, #0xfff7fff7fff7fff7
    ADC  X7, X9, X15
    CRC32W  W13, W26, W6
    CSNEG  W10, W17, W14, LE
    SUBS  W12, W26, W10, LSL #5
    SMULH  X4, X17, X10
    ORR  V27.8B, V8.8B, V27.8B
    CSINC  X26, X7, X22, CC
    CSNEG  W3, W5, W18, LE
    ANDS  X3, X4, #0x3c00000
    SMADDL  X3, W21, W18, X28
    SUB  X19, X4, W14, SXTB #4
    ASRV  X12, X5, X11
    CSNEG  W20, W27, W28, CS
    CSEL  X14, X5, X7, EQ
    ORR  V1.16B, V8.16B, V9.16B
    CRC32CW  W15, W23, W4
    SMULH  X19, X3, X18
    BIC  X14, X20, X20, LSL #52
    SUB  X27, X8, W25, SXTB #3
    ORR  V18.4H, #0x19
    ANDS  W26, W15, #0x7e00000
    SUB  W29, W12, #0x52, LSL #12
    CLS  X14, X21
    ORR  V20.4S, #0xf1, LSL #8
    BIC  V9.8B, V17.8B, V2.8B
    BIC  V4.8B, V22.8B, V31.8B
    ADDS  X22, X19, W9, UXTB #0
    MOVK  W26, #0xa4a2, LSL #0
    ANDS  W26, W6, W27, LSR #28
    ORR  V20.8B, V23.8B, V16.8B
    EOR  W19, W14, W3, LSR #16
    ORN  W29, W19, W14, LSL #18
    ADCS  X27, X12, X29
    SUBS  W22, W26, W12, UXTW #3
    CRC32W  W13, W8, W5
    CLZ  W18, W13
    CSINC  W12, W18, W29, LT
    SUB  X21, X21, X18, LSL #21
    UMSUBL  X14, W10, W9, X2
    BICS  W10, W4, W12, ASR #13
    LSLV  W2, W4, W14
    ORR  X10, X2, #0x6000600060006000
    MOVN  X11, #0x2e61, LSL #48
    AND  W15, W8, W27, LSL #27
    CRC32CH  W14, W18, W22
    SUBS  X20, X18, X14, LSR #9
    CSINC  W16, W16, W17, LS
    CRC32CH  W27, W3, W14
    CRC32CX  W10, W22, X16
    LSLV  X10, X20, X20
    MOVK  X20, #0x9342, LSL #32
    SUB  X4, X17, X4, ASR #43
    MOVN  X26, #0x6e0b, LSL #16
    SMSUBL  X16, W22, W6, X19
    EXTR  X9, X26, X18, #0x24
    EOR  W13, W8, #0x3fffff00
    EON  W17, W5, W21, ASR #10
    CRC32CB  W3, W2, W16
    ORR  W10, W17, W29, LSR #18
    CLS  V21.16B, V19.16B
    MOVZ  X27, #0xfab5, LSL #16
    ADCS  X7, X11, X15
    EON  W27, W20, W27, LSL #19
    UMADDL  X4, W20, W10, X10
    SBFM  W15, W9, #0x8, #0x1d
    CRC32CB  W12, W12, W16
    CLS  X19, X27
    BIC  W17, W20, W15, ASR #23
    MADD  W29, W7, W28, W3
    SUBS  W20, W28, W19, UXTH #0
    SUBS  W7, W3, #0x6a7
    ASRV  W14, W6, W19
    CSINC  W5, W28, W29, LS
    SUB  X14, X12, W13, SXTB #4
    CRC32CW  W19, W22, W22
    UBFM  W11, W7, #0x5, #0x7
    SUBS  X12, X3, #0x180
    ADD  X20, X6, #0x944, LSL #12
    ADD  X11, X25, W11, UXTH #0
    ADDS  X29, X10, #0xaf0
    EOR  X17, X26, #0x7ffffffff800
    AND  X6, X7, #0xf81ffffff81fffff
    ORR  X7, X3, X25, LSL #12
    ASRV  X7, X2, X8
    ANDS  X7, X28, X29, LSL #5
    CSINV  W20, W16, W14, VS
    CLZ  X6, X26
    SUBS  X25, X25, #0x1
    B.NE  TaishanIntAluP02_label_682
    MOVZ  X22, #0x0, LSL #0
    SUB  X25, X22, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X9, #0xf0d5, LSL #0
    MOVK  X9, #0x69e9, LSL #16
    SUB  X13, X9, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP02_TestFail
    MOVZ  X28, #0xe697, LSL #0
    MOVK  X28, #0x628c, LSL #16
    MOVK  X28, #0x5dbe, LSL #32
    MOVK  X28, #0x6769, LSL #48
    SUB  X9, X28, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X5, #0xf0b2, LSL #0
    MOVK  X5, #0x69e9, LSL #16
    SUB  X18, X5, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x20, LSL #0
    SUB  X20, X6, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP02_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X26, X23, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP02_TestFail
    MOVZ  X3, #0x3ff9, LSL #0
    MOVK  X3, #0x6776, LSL #16
    SUB  X5, X3, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x2, LSL #0
    SUB  X25, X16, X11
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X2, #0xef55, LSL #0
    MOVK  X2, #0x69e9, LSL #16
    SUB  X27, X2, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X10, #0x73d6, LSL #0
    MOVK  X10, #0x9b82, LSL #16
    SUB  X21, X10, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xfff0, LSL #16
    SUB  X4, X21, X15
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X26, #0x2, LSL #0
    SUB  X6, X26, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X11, #0x7ff, LSL #0
    MOVK  X11, #0x6e0b, LSL #16
    MOVK  X11, #0x8000, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X7, X11, X17
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X28, X22, X18
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X19
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xfff0, LSL #16
    SUB  X26, X19, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X23
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x4ae9, LSL #0
    MOVK  X29, #0x6776, LSL #16
    SUB  X20, X29, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP02_TestFail
    MOVZ  X2, #0xec7c, LSL #0
    MOVK  X2, #0xf06d, LSL #16
    MOVK  X2, #0x41ab, LSL #32
    MOVK  X2, #0x716b, LSL #48
    MOVZ  X3, #0xaf69, LSL #0
    MOVK  X3, #0xfecb, LSL #16
    MOVK  X3, #0xe9e2, LSL #32
    MOVK  X3, #0x4d26, LSL #48
    MOVZ  X4, #0xa973, LSL #0
    MOVK  X4, #0x4b72, LSL #16
    MOVK  X4, #0x591d, LSL #32
    MOVK  X4, #0xd546, LSL #48
    MOVZ  X5, #0xce17, LSL #0
    MOVK  X5, #0x5c6f, LSL #16
    MOVK  X5, #0x4b0a, LSL #32
    MOVK  X5, #0xcd92, LSL #48
    MOVZ  X6, #0x44ac, LSL #0
    MOVK  X6, #0x84b7, LSL #16
    MOVK  X6, #0x35a1, LSL #32
    MOVK  X6, #0x3af, LSL #48
    MOVZ  X7, #0xcb33, LSL #0
    MOVK  X7, #0xe35c, LSL #16
    MOVK  X7, #0x36a5, LSL #32
    MOVK  X7, #0x7e7b, LSL #48
    MOVZ  X8, #0x2006, LSL #0
    MOVK  X8, #0x1f55, LSL #16
    MOVK  X8, #0x3f40, LSL #32
    MOVK  X8, #0xa6e9, LSL #48
    MOVZ  X9, #0xbf10, LSL #0
    MOVK  X9, #0x421c, LSL #16
    MOVK  X9, #0x6efa, LSL #32
    MOVK  X9, #0x36d9, LSL #48
    MOVZ  X10, #0x5f24, LSL #0
    MOVK  X10, #0x104e, LSL #16
    MOVK  X10, #0xea9, LSL #32
    MOVK  X10, #0xe1f5, LSL #48
    MOVZ  X11, #0x2719, LSL #0
    MOVK  X11, #0xb230, LSL #16
    MOVK  X11, #0x86b, LSL #32
    MOVK  X11, #0xe611, LSL #48
    MOVZ  X12, #0x4e9e, LSL #0
    MOVK  X12, #0x635c, LSL #16
    MOVK  X12, #0xe14c, LSL #32
    MOVK  X12, #0xad38, LSL #48
    MOVZ  X13, #0x3087, LSL #0
    MOVK  X13, #0xf087, LSL #16
    MOVK  X13, #0xae77, LSL #32
    MOVK  X13, #0x999b, LSL #48
    MOVZ  X14, #0x8184, LSL #0
    MOVK  X14, #0xc92a, LSL #16
    MOVK  X14, #0x1335, LSL #32
    MOVK  X14, #0x2570, LSL #48
    MOVZ  X15, #0xae37, LSL #0
    MOVK  X15, #0xedbe, LSL #16
    MOVK  X15, #0x1ef5, LSL #32
    MOVK  X15, #0x5fb3, LSL #48
    MOVZ  X16, #0xc175, LSL #0
    MOVK  X16, #0xf8ae, LSL #16
    MOVK  X16, #0x3118, LSL #32
    MOVK  X16, #0x9f35, LSL #48
    MOVZ  X17, #0x7fa9, LSL #0
    MOVK  X17, #0x6b40, LSL #16
    MOVK  X17, #0x27b, LSL #32
    MOVK  X17, #0x5425, LSL #48
    MOVZ  X18, #0xdee, LSL #0
    MOVK  X18, #0xe7ca, LSL #16
    MOVK  X18, #0x38c2, LSL #32
    MOVK  X18, #0x842b, LSL #48
    MOVZ  X19, #0x2cfe, LSL #0
    MOVK  X19, #0x23e9, LSL #16
    MOVK  X19, #0xb776, LSL #32
    MOVK  X19, #0xfe5e, LSL #48
    MOVZ  X20, #0x8f2a, LSL #0
    MOVK  X20, #0xa97c, LSL #16
    MOVK  X20, #0xb19, LSL #32
    MOVK  X20, #0x89c4, LSL #48
    MOVZ  X21, #0x97ee, LSL #0
    MOVK  X21, #0xf0f1, LSL #16
    MOVK  X21, #0xed07, LSL #32
    MOVK  X21, #0xbaf1, LSL #48
    MOVZ  X22, #0x6008, LSL #0
    MOVK  X22, #0x5f10, LSL #16
    MOVK  X22, #0x3463, LSL #32
    MOVK  X22, #0x5dec, LSL #48
    MOVZ  X23, #0x71c2, LSL #0
    MOVK  X23, #0x5663, LSL #16
    MOVK  X23, #0xea7b, LSL #32
    MOVK  X23, #0x1c48, LSL #48
    MOVZ  X25, #0xbf17, LSL #0
    MOVK  X25, #0x61f8, LSL #16
    MOVK  X25, #0xb247, LSL #32
    MOVK  X25, #0x6792, LSL #48
    MOVZ  X26, #0xe355, LSL #0
    MOVK  X26, #0x109a, LSL #16
    MOVK  X26, #0x975b, LSL #32
    MOVK  X26, #0xbd44, LSL #48
    MOVZ  X27, #0x93b7, LSL #0
    MOVK  X27, #0xe667, LSL #16
    MOVK  X27, #0x9441, LSL #32
    MOVK  X27, #0x97b8, LSL #48
    MOVZ  X28, #0x83ea, LSL #0
    MOVK  X28, #0xafc1, LSL #16
    MOVK  X28, #0xaeb, LSL #32
    MOVK  X28, #0x1d3b, LSL #48
    MOVZ  X29, #0xc20e, LSL #0
    MOVK  X29, #0x9ff8, LSL #16
    MOVK  X29, #0x1552, LSL #32
    MOVK  X29, #0xf57a, LSL #48
    MOVZ  X14, #0xa, LSL #0
TaishanIntAluP02_label_708:
    CRC32W  W17, W29, W25
    CSINV  W12, W2, W5, MI
    SUBS  W19, W16, #0x658, LSL #12
    LSRV  W29, W5, W8
    CLZ  W27, W14
    SUBS  W11, W26, W27, UXTW #2
    EXTR  X19, X15, X29, #0x33
    ANDS  W15, W9, #0x3ff03ff
    ADD  W20, W9, W7, UXTX #0
    EON  X3, X17, X12, LSL #38
    LSLV  W23, W9, W28
    ORN  X25, X6, X15, ASR #55
    CSINV  X11, X3, X29, HI
    CLS  X11, X7
    SUBS  W22, W5, #0xabe
    BIC  X20, X9, X22, LSL #3
    ADD  X9, X19, #0xc44, LSL #12
    ADD  X16, X27, W12, SXTW #2
    LSLV  W10, W28, W3
    ADDS  X15, X12, #0xd60
    EOR  X2, X12, X16, ASR #27
    ANDS  W28, W23, #0x8080808
    EOR  W9, W6, W27, ASR #31
    EON  X10, X29, X11, LSR #6
    LSLV  W13, W14, W23
    CSNEG  X27, X17, X27, VS
    SUBS  W7, W15, #0x139, LSL #12
    CRC32CH  W22, W2, W2
    MOVK  X25, #0x53a5, LSL #16
    CLZ  X2, X5
    CRC32H  W22, W27, W27
    ANDS  X28, X5, #0x7fc07fc07fc07fc
    ADD  X27, X19, X5, LSR #1
    CSINC  W8, W16, W20, EQ
    SMADDL  X22, W18, W6, X21
    CRC32CH  W9, W9, W2
    ADD  X28, X4, W13, UXTW #3
    ADD  W8, W11, W18, UXTH #2
    ADC  W8, W3, W27
    LSRV  W10, W9, W28
    UBFM  X28, X10, #0x10, #0x29
    UBFM  X19, X25, #0x1c, #0x1e
    LSRV  X12, X15, X22
    CSINC  X27, X3, X28, MI
    ORN  W19, W6, W28, LSR #6
    ANDS  W15, W21, #0x1ffffffc
    SUBS  W23, W25, W15, UXTW #4
    MOVZ  X25, #0xd9a0, LSL #0
    CRC32B  W8, W23, W23
    SUB  X5, X8, X26, ASR #22
    ADCS  X5, X16, X19
    ANDS  W29, W29, W20, ASR #27
    LSLV  X6, X13, X22
    CSINV  W3, W20, W13, AL
    MOVK  X27, #0x5a9b, LSL #0
    ADD  X3, X27, #0x6a0
    BIC  W5, W4, W20, LSR #3
    SBFM  X17, X14, #0x3d, #0x4
    MOVZ  W13, #0xe68, LSL #0
    ORN  W16, W23, W3, ASR #6
    UMULH  X25, X10, X4
    MOVK  X13, #0xff40, LSL #32
    EOR  X12, X21, X28, LSR #27
    ANDS  W8, W17, W23, ROR #23
    CLS  V2.4S, V4.4S
    LSRV  X2, X16, X6
    SBFM  X20, X7, #0x15, #0x26
    CRC32B  W5, W13, W21
    CLZ  X20, X20
    EOR  X21, X28, #0xeeeeeeeeeeeeeeee
    MOVZ  X29, #0x5075, LSL #16
    ORR  V30.4H, #0xd4
    CSINV  W18, W5, W4, GE
    CLZ  W7, W9
    EXTR  X16, X18, X14, #0x33
    BIC  W20, W23, W4, LSL #25
    LSRV  W11, W16, W23
    CSINV  X6, X15, X15, AL
    ORR  V9.4H, #0x59, LSL #8
    SBFM  X12, X4, #0x2f, #0x1a
    ORR  X10, X25, #0x3fff00000000000
    CLZ  W6, W26
    MOVZ  X17, #0x5f9c, LSL #32
    SUBS  W5, W7, #0xeec, LSL #12
    BICS  X10, X12, X5, ASR #11
    UMADDL  X10, W27, W8, X7
    CSNEG  W18, W9, W8, LE
    EON  W23, W10, W5, LSR #13
    CLS  X26, X22
    CSINV  X26, X8, X11, VS
    MOVK  W25, #0x68fb, LSL #0
    SUBS  W19, W8, W26, UXTW #0
    SMULH  X13, X2, X9
    ANDS  X9, X23, #0xfffc00000fffffff
    AND  X3, X3, #0xfffff000000001ff
    MOVZ  W15, #0x42e1, LSL #16
    SUBS  W4, W12, W15, UXTW #3
    CRC32B  W3, W12, W4
    ADDS  W11, W13, W27, ASR #3
    ADDS  W5, W5, W15, UXTB #3
    BICS  X16, X17, X12, ROR #8
    SMADDL  X18, W13, W5, X18
    SBFM  X12, X14, #0x2f, #0x31
    SUB  X17, X17, #0xc76, LSL #12
    CRC32H  W4, W9, W17
    LSLV  X25, X21, X11
    ADD  X6, X3, X16, UXTX #1
    EON  W18, W15, W23, LSR #25
    BIC  W13, W25, W5, LSR #11
    EXTR  W18, W4, W19, #0xe
    SUBS  W25, W26, W23, SXTH #1
    UMULH  X21, X18, X13
    ADC  W2, W22, W15
    LSRV  X18, X4, X20
    LSLV  X19, X25, X15
    SUBS  X16, X25, X29, LSL #12
    SUB  X25, X9, #0xc8c
    ADD  W17, W6, #0x777
    ORR  X6, X21, #0xffffff000000000f
    CSNEG  W4, W22, W12, VC
    MOVN  W23, #0xb676, LSL #0
    CLZ  X25, X12
    ADCS  X3, X3, X20
    UMSUBL  X28, W26, W15, X15
    ADDS  X10, X7, W14, SXTH #2
    CRC32B  W6, W19, W10
    ASRV  W29, W3, W5
    ADDS  X18, X2, #0x834
    ORR  W4, W23, W11, LSL #28
    EOR  X19, X23, #0x7fffffff00000000
TaishanIntAluP02_label_611:
    MOVZ  X19, #0xe5da, LSL #16
    LSLV  X9, X19, X17
    EOR  X12, X14, X7, LSR #1
    SUB  X10, X22, #0x241, LSL #12
    ANDS  X12, X6, X3, ROR #31
    BICS  W15, W27, W7, ASR #13
    ORR  V25.4S, #0xd6, LSL #16
    SBFM  X23, X4, #0x3f, #0x6
    SMULH  X17, X12, X12
    ADD  X15, X23, X5, SXTX #4
    SUBS  W19, W15, #0xcd7
    CSEL  X23, X2, X14, MI
    SMADDL  X4, W27, W22, X21
    UBFM  W21, W26, #0x1d, #0x3
    ASRV  X8, X12, X17
    SMSUBL  X16, W14, W4, X28
    LSLV  W10, W6, W18
    AND  X16, X27, X27, ASR #63
    ADDS  W18, W25, W20, UXTH #0
    CSNEG  X9, X25, X2, LT
    ASRV  X20, X15, X2
    ORR  X3, X15, #0x3000300030003
    SMSUBL  X17, W8, W12, X11
    CLZ  V3.4H, V16.4H
    ADDS  W23, W12, W13, ASR #23
    SMSUBL  X8, W22, W14, X6
    CSINV  X11, X23, X27, GE
    ORN  W25, W10, W12, LSL #1
    ADC  X12, X16, X10
    CRC32CB  W3, W23, W19
    ADCS  W25, W21, W27
    ADDS  W10, W20, W25, LSL #16
    BIC  X18, X11, X20, ROR #28
    SUBS  X13, X14, X16, SXTX #2
    CLZ  W3, W8
    MOVK  W23, #0x7a8e, LSL #16
    SMULH  X4, X29, X27
    ADDS  X28, X23, #0x45d
    CRC32CW  W6, W3, W25
    LSRV  W13, W13, W28
    MADD  W11, W2, W12, W28
    ADCS  W13, W13, W6
    ORR  X26, X17, X17, ROR #29
    LSRV  X11, X18, X22
    CRC32B  W2, W25, W28
    ANDS  X10, X4, X10, ASR #58
    LSRV  W12, W5, W5
    ADDS  W21, W12, W22, LSR #6
    CLZ  V26.4H, V10.4H
    BIC  X12, X4, X3, ROR #27
    EON  X6, X18, X5, LSL #47
    SUBS  X17, X21, X8, LSR #46
    CLZ  W16, W20
    BIC  X26, X8, X9, LSL #8
    ADC  W3, W12, W28
    UBFM  W22, W3, #0xf, #0x12
    ADD  W8, W16, #0xb10
    CLZ  X23, X23
    LSRV  W25, W7, W8
    SUB  X4, X25, X21, LSR #59
    SBFM  W20, W13, #0x1e, #0x3
    ADD  X10, X4, X16, UXTX #0
    ANDS  X22, X5, #0x202020202020202
    UMADDL  X7, W25, W3, X21
    CLZ  V14.8B, V19.8B
    EOR  X20, X6, #0xfffffffffffff8
    BIC  X18, X22, X23, LSL #13
    BICS  W16, W7, W7, LSR #13
    ADDS  X17, X5, X14, LSL #14
    AND  W10, W9, W7, LSL #1
    SUBS  X14, X14, #0x1
    B.NE  TaishanIntAluP02_label_708
    MOVZ  X26, #0xc478, LSL #0
    MOVK  X26, #0x56b3, LSL #16
    SUB  X17, X26, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X9, #0x53f, LSL #0
    MOVK  X9, #0x7a8e, LSL #16
    SUB  X18, X9, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP02_TestFail
    MOVZ  X21, #0x0, LSL #0
TaishanIntAluP02_label_303:
    SUB  X9, X21, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X28, #0x4000, LSL #0
    MOVK  X28, #0xff11, LSL #16
    SUB  X22, X28, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X11, #0xff1e, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0x5fff, LSL #48
    SUB  X20, X11, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP02_TestFail
    MOVZ  X28, #0xb6f9, LSL #0
    MOVK  X28, #0xff9b, LSL #16
    SUB  X2, X28, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X18, #0xb1a, LSL #0
    SUB  X14, X18, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X17, #0x41b2, LSL #0
    MOVK  X17, #0x9a01, LSL #16
    SUB  X4, X17, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X28, #0xff1e, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0x5fff, LSL #48
    SUB  X19, X28, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X3, X14, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X13, #0xe93a, LSL #0
    MOVK  X13, #0xf1de, LSL #16
    SUB  X11, X13, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X21, #0x12, LSL #0
    MOVK  X21, #0xf114, LSL #16
    MOVK  X21, #0xf, LSL #32
    SUB  X16, X21, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X29, X12, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP02_TestFail
    MOVZ  X7, #0x41b2, LSL #0
    MOVK  X7, #0x9a01, LSL #16
    SUB  X29, X7, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP02_TestFail
    MOVZ  X29, #0xb1a, LSL #0
    SUB  X13, X29, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP02_TestFail
    MOVZ  X20, #0x12, LSL #0
    MOVK  X20, #0xf114, LSL #16
    MOVK  X20, #0xf, LSL #32
    SUB  X27, X20, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP02_TestFail
    MOVZ  X13, #0x21, LSL #0
    SUB  X18, X13, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X4, #0xc478, LSL #0
    MOVK  X4, #0x56b3, LSL #16
    SUB  X21, X4, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X2, #0xa, LSL #0
TaishanIntAluP02_label_732:
    MOVZ  W22, #0xa749, LSL #0
    EOR  W5, W6, #0xffff8fff
    UMULH  X17, X14, X27
    MOVK  W6, #0x7241, LSL #0
    CLS  X28, X29
    BICS  X14, X26, X4, ASR #37
    MOVN  X22, #0x285f, LSL #0
    UBFM  X27, X29, #0x1, #0x39
    CSINC  W7, W10, W17, GT
    SMSUBL  X23, W7, W21, X28
    EOR  W25, W4, #0xfe00fe00
    AND  X23, X12, #0xffe3ffe3ffe3ffe3
    CRC32B  W20, W10, W12
    EON  X13, X12, X27, ASR #12
    CLS  V4.2S, V29.2S
    ASRV  X13, X11, X25
    SMADDL  X16, W22, W14, X17
    ANDS  W21, W20, W4, LSR #9
    ADDS  W3, W20, W20, UXTX #3
    EOR  W25, W12, #0x55555555
    ASRV  W9, W13, W7
    AND  X7, X12, #0xffff801fffffffff
    CRC32CX  W5, W17, X28
    CRC32W  W29, W14, W21
    SUB  X26, X15, #0xeef
    LSRV  X29, X10, X3
    LSLV  W16, W21, W22
    ORR  W6, W18, W14, ASR #25
    ADC  X7, X13, X9
    EXTR  W11, W29, W12, #0x12
    CLZ  W25, W5
    ORR  V14.2S, #0x2d, LSL #8
    ANDS  W3, W26, #0xe3e3e3e3
    CRC32B  W11, W3, W14
    ORR  V10.16B, V3.16B, V11.16B
    ADDS  X15, X20, #0x596, LSL #12
    SBFM  X16, X9, #0x36, #0x2a
    AND  W6, W3, W17, LSR #27
    SUBS  X7, X28, #0x90d, LSL #12
    EXTR  X16, X27, X26, #0x27
    MADD  X3, X18, X9, X15
    CRC32B  W3, W15, W7
    CSEL  W29, W25, W16, EQ
    CLS  V1.8H, V14.8H
    CLS  X11, X14
    EXTR  W9, W14, W20, #0x1f
    MADD  X19, X25, X6, X2
    SBFM  X3, X5, #0x24, #0x26
    CSEL  W13, W17, W17, NE
    UBFM  W6, W21, #0x1f, #0xa
    BICS  W25, W29, W18, LSR #17
    BICS  W18, W26, W10, LSL #27
    UMSUBL  X25, W12, W11, X12
    ADDS  W16, W10, W15, SXTB #0
    CLS  W15, W18
    SMADDL  X8, W26, W25, X9
    BICS  W8, W14, W23, LSR #7
    MOVK  X21, #0x2eaf, LSL #48
    ORN  W8, W7, W7, ASR #19
    ADDS  W17, W15, W27, LSR #31
    CLZ  X20, X12
    ADCS  X23, X27, X3
    EOR  W15, W20, #0xfc00000
    ASRV  W28, W11, W3
    ASRV  W29, W9, W2
    SUB  X8, X25, X11, ASR #60
    ORR  V26.2S, #0xbf, LSL #8
    ADDS  W16, W26, W10, SXTH #0
    ADD  W8, W8, W19, UXTB #3
    ADDS  W7, W13, #0xbca
    CSINV  X26, X19, X11, LS
    ADDS  X27, X22, W13, SXTW #3
    ASRV  W12, W22, W16
    UMSUBL  X27, W21, W10, X21
    ADD  X22, X3, W20, UXTW #2
    MOVZ  W3, #0xec86, LSL #16
    ADCS  X17, X14, X21
    CLZ  X18, X28
    AND  X16, X25, #0x3f8000000000
    CRC32X  W26, W18, X11
    CRC32CW  W7, W14, W20
    MOVK  X13, #0xa1bd, LSL #32
    ADDS  W23, W2, #0x26d, LSL #12
    ADD  W19, W10, W5, UXTX #0
    EOR  X20, X6, X14, LSR #54
    ASRV  X14, X19, X14
    LSLV  X17, X14, X21
    UMULH  X6, X11, X23
    AND  W27, W3, #0xf0ffffff
    ORR  V1.8B, V26.8B, V26.8B
    ORR  X25, X3, #0x1fffff001fffff0
    UMULH  X3, X19, X12
    CSEL  W8, W7, W22, EQ
    ORR  W23, W21, W11, LSR #14
    BIC  V9.16B, V16.16B, V9.16B
    AND  X18, X12, X4, LSR #58
    LSRV  W13, W7, W21
    ADCS  W13, W12, W17
    UBFM  X12, X2, #0x18, #0x38
    CRC32B  W21, W17, W15
    EXTR  X29, X25, X11, #0x3e
    ASRV  X23, X11, X6
    CRC32CH  W16, W7, W6
    CLS  V25.4S, V31.4S
    EON  X23, X29, X18, LSL #58
    ORR  V2.2S, #0x82
    SUB  W8, W19, W2, UXTX #0
    CRC32W  W8, W7, W8
    EON  X20, X12, X29, LSL #32
    ADCS  X23, X16, X27
    CRC32CX  W15, W17, X7
    ADD  W19, W9, W14, ASR #11
    ORR  V13.4H, #0x77
    CSNEG  X14, X7, X16, LT
    SUBS  W14, W15, W2, LSR #17
    SUBS  W22, W4, W2, LSR #21
    ADD  W14, W2, #0x6d, LSL #12
    SUBS  X14, X20, X10, LSR #22
    ORR  V1.8B, V7.8B, V26.8B
    CSNEG  X18, X23, X20, AL
    ANDS  X10, X6, X2, ROR #42
    BICS  W21, W3, W17, LSL #25
    CSINV  W22, W23, W20, NV
    ADDS  X10, X20, W3, UXTW #1
    ANDS  X14, X26, #0x200000002000000
    ADCS  X7, X3, X21
    ADD  W3, W17, #0x1c8, LSL #12
    ORR  V3.16B, V29.16B, V11.16B
    ADDS  X22, X19, #0xd17, LSL #12
    CSINC  X20, X27, X27, LS
    ORN  W19, W13, W12, LSL #25
    CLZ  V0.4S, V20.4S
    CRC32CB  W16, W16, W6
    SUB  W6, W19, #0x5dc, LSL #12
    ADD  X15, X29, X27, LSL #56
    SMULH  X5, X20, X21
    CLZ  X29, X23
    SBFM  X6, X12, #0x30, #0x13
    SUB  X16, X8, X7, SXTX #3
    ORN  X7, X27, X8, ROR #35
    UMADDL  X20, W25, W10, X12
    CLS  V9.4S, V18.4S
    MADD  W29, W2, W21, W15
    ORR  X16, X23, X2, ROR #16
    ADDS  X5, X29, X12, LSL #24
    MOVK  X23, #0x2111, LSL #16
    ORN  X21, X7, X19, ASR #53
    CSINC  X5, X13, X28, AL
    MADD  W3, W28, W5, W3
    ORR  V13.2S, #0x74, LSL #24
    UBFM  W8, W10, #0x11, #0x5
    SUBS  X17, X19, #0xfa4
    CRC32CH  W15, W29, W16
    SUBS  X16, X20, X22, LSR #53
    ADD  X9, X26, X15, UXTX #4
    ADDS  W7, W5, W23, LSL #4
    CSINC  W12, W22, W2, MI
    UMSUBL  X7, W12, W2, X6
    ANDS  W26, W3, #0xfc00ffff
    ORR  V10.8B, V11.8B, V18.8B
    ADDS  X13, X9, X27, LSL #30
    ANDS  X3, X26, #0x3ff8000000000
    SUBS  W3, W5, W18, SXTW #0
    EOR  W17, W7, #0xf800f80
    ADDS  W23, W12, #0x335, LSL #12
    MOVZ  W3, #0x52a4, LSL #16
    ANDS  X19, X12, #0x1e001e001e001e0
    ADDS  W22, W3, W7, ASR #31
    LSRV  W9, W3, W2
    SUB  W4, W17, W23, ASR #24
    CSNEG  W16, W25, W17, LE
    ORN  W13, W6, W7, ROR #26
    ADD  W25, W23, W9, UXTX #2
    ADC  W6, W19, W26
    ADDS  W5, W6, W13, SXTW #1
    SUB  X22, X12, X10, ASR #12
    SUB  X25, X5, X3, SXTX #3
    ADDS  X27, X12, W8, SXTB #0
    LSLV  X7, X17, X26
    CRC32B  W4, W26, W25
    CRC32X  W4, W15, X2
    BIC  V1.16B, V26.16B, V6.16B
    SUBS  W9, W21, W19, LSR #31
    ANDS  X26, X13, #0x8383838383838383
    ORR  V5.4H, #0xe9
    CRC32X  W19, W19, X16
    CRC32B  W14, W27, W3
    ANDS  X19, X7, X14, ROR #25
    ADCS  W7, W8, W13
    MOVZ  X4, #0x6530, LSL #0
    ADDS  W12, W4, W12, SXTH #1
    ORR  X26, X21, #0xffffff0000003fff
    CRC32B  W16, W4, W6
    SUB  X7, X7, X29, LSR #0
    SUB  W9, W29, #0xfc8, LSL #12
    CSEL  X8, X2, X2, CC
    EOR  W22, W2, W2, ROR #21
    ADDS  X15, X20, #0xb85, LSL #12
    MOVK  X14, #0x843b, LSL #32
    LSRV  W27, W11, W8
    SUBS  X2, X2, #0x1
    B.NE  TaishanIntAluP02_label_732
    MOVZ  X17, #0x0, LSL #0
    SUB  X21, X17, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x52a4, LSL #16
    SUB  X25, X5, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP02_TestFail
    MOVZ  X17, #0x6530, LSL #0
    SUB  X9, X17, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x52a4, LSL #16
    SUB  X13, X9, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP02_TestFail
    MOVZ  X27, #0x9061, LSL #0
    SUB  X6, X27, X6
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X25, #0x8080, LSL #0
    MOVK  X25, #0x481f, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X17, X25, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X12, #0x1, LSL #0
    SUB  X22, X12, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x52a4, LSL #16
    SUB  X15, X6, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP02_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0x3f, LSL #32
    MOVK  X13, #0x4800, LSL #48
    SUB  X29, X13, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP02_TestFail
    MOVZ  X17, #0x3f, LSL #0
    SUB  X3, X17, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X25, #0x1, LSL #0
    SUB  X2, X25, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0x3f, LSL #32
    MOVK  X2, #0x4800, LSL #48
    SUB  X9, X2, X13
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X17, #0x612c, LSL #0
    MOVK  X17, #0xee0e, LSL #16
    MOVK  X17, #0x843b, LSL #32
    SUB  X14, X17, X14
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X25, #0x6107, LSL #0
    MOVK  X25, #0x1c6c, LSL #16
    SUB  X14, X25, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP02_TestFail
    MOVZ  X10, #0x612c, LSL #0
    MOVK  X10, #0xee0e, LSL #16
    MOVK  X10, #0x843b, LSL #32
    SUB  X13, X10, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP02_TestFail
    MOVZ  X18, #0xcedf, LSL #0
    MOVK  X18, #0xe2a3, LSL #16
    SUB  X4, X18, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x9000, LSL #32
    MOVK  X23, #0x30, LSL #48
    SUB  X19, X23, X19
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X29, #0x10, LSL #0
    MOVK  X29, #0x1200, LSL #16
    MOVK  X29, #0xffef, LSL #32
    MOVK  X29, #0xedff, LSL #48
    SUB  X11, X29, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X28, X17, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x9000, LSL #32
    MOVK  X9, #0x30, LSL #48
    SUB  X11, X9, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X18, #0x6107, LSL #0
    MOVK  X18, #0x1c6c, LSL #16
    SUB  X28, X18, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP02_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X20, X27, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP02_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X17, X2, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP02_TestFail
    MOVZ  X11, #0x10, LSL #0
    MOVK  X11, #0x1200, LSL #16
    MOVK  X11, #0xffef, LSL #32
    MOVK  X11, #0xedff, LSL #48
    SUB  X4, X11, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
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
    MOVZ  X15, #0xa, LSL #0
TaishanIntAluP02_label_754:
    CRC32CB  W26, W15, W6
    CLS  X29, X27
    AND  X28, X28, X28, ASR #51
    ADD  X29, X6, X29, ASR #51
    ORN  W7, W29, W23, LSR #18
    SMSUBL  X7, W26, W23, X5
    ORR  W23, W28, #0xc1c1c1c1
    BICS  X16, X17, X25, LSL #28
    ANDS  W17, W2, W13, LSR #7
    CLZ  W18, W18
    SMADDL  X11, W26, W14, X18
    ADDS  X23, X28, W13, UXTB #1
    SUB  W23, W5, #0x48
    EON  W29, W11, W13, ROR #27
    CLS  V27.2S, V28.2S
    ANDS  X16, X4, #0x3ff000003ff000
    SBFM  W17, W25, #0x13, #0xc
    ORR  W26, W15, W29, LSL #13
    EXTR  X14, X25, X9, #0x16
    ADDS  W8, W27, W7, ASR #3
    ANDS  W10, W27, W17, LSL #15
    SUBS  W9, W2, W26, ASR #8
    EOR  X28, X16, #0x8fff8fff8fff8fff
    CRC32B  W23, W8, W28
    ORR  V15.4H, #0xc7
    SUB  W18, W5, W9, LSL #2
    UMULH  X4, X23, X28
    ORR  W5, W27, W14, LSL #10
    CRC32W  W25, W13, W13
    SUBS  X4, X10, X18, LSL #44
    UMULH  X29, X18, X28
    AND  W6, W6, #0xc3ffffff
    BICS  X14, X22, X20, ASR #12
    CRC32B  W2, W13, W18
    SUB  W28, W21, W17, SXTW #0
    UBFM  W27, W25, #0x13, #0x13
    CLZ  W4, W27
TaishanIntAluP02_label_523:
    ORR  W20, W4, W3, ROR #25
    SUB  X26, X2, #0x310
    CSNEG  X19, X11, X18, LE
    ADCS  X5, X18, X8
    LSRV  W21, W20, W16
    SBFM  W29, W4, #0x6, #0x1f
    AND  W11, W17, #0xbfffffff
    CSINV  X27, X7, X17, PL
    CLS  V21.2S, V19.2S
    ADD  W21, W5, W6, LSR #12
    ADDS  X18, X20, #0xbb6, LSL #12
    ADCS  X18, X14, X25
    ADCS  X22, X28, X8
    CSINC  X2, X23, X29, PL
    CRC32CW  W18, W12, W17
    ORR  V20.8H, #0x80
    LSLV  W19, W18, W19
    ADC  X12, X10, X19
    ADDS  W22, W11, W29, LSR #7
TaishanIntAluP02_label_385:
    ADDS  W23, W11, #0xbf9
    ADD  X8, X7, #0x873
    CRC32CX  W19, W7, X12
    MOVN  X27, #0xe1a, LSL #48
    CLS  X4, X5
    EON  X23, X29, X12, LSL #38
    ASRV  X21, X11, X23
    CRC32H  W5, W6, W4
    ORR  V19.2S, #0xce, LSL #16
    LSRV  X16, X26, X15
    SBFM  X7, X16, #0x33, #0x3f
    SUB  X8, X22, X5, ASR #47
    UMADDL  X18, W10, W22, X15
    ORR  W17, W2, W11, ROR #29
    SUB  W8, W19, #0xa3, LSL #12
    ADD  X27, X17, X19, LSR #58
    MADD  X25, X14, X17, X7
    ADDS  X18, X15, X13, LSL #24
    MOVN  X16, #0x3c68, LSL #48
    CSNEG  X28, X29, X3, NV
    SMULH  X28, X28, X23
    SUB  W9, W4, W27, LSR #13
    CLZ  X7, X16
    CRC32CB  W11, W6, W29
    ADD  W12, W16, W18, LSR #24
    EON  W16, W11, W7, ROR #21
    ANDS  W3, W17, #0xf007f007
    SUB  W12, W4, W16, LSR #13
    SBFM  W8, W11, #0x2, #0xb
    SMULH  X23, X2, X9
    CSINV  W23, W12, W13, EQ
    BICS  X9, X19, X25, LSL #41
    ORN  X23, X22, X10, LSR #1
    LSLV  W16, W19, W13
    SMULH  X8, X20, X20
    ADDS  W11, W25, #0x5a4, LSL #12
    ANDS  W27, W9, W22, ASR #25
    CRC32H  W6, W20, W12
    ADCS  X2, X23, X18
    ANDS  X7, X27, #0xffffc00003ffffff
    EOR  W19, W7, W12, LSR #2
    AND  W14, W20, #0x1f000000
    EOR  X18, X9, X14, ROR #45
    CRC32X  W18, W4, X25
    MADD  X5, X20, X18, X9
    ADD  W25, W14, W8, LSL #31
    CLS  X17, X7
    MOVN  X3, #0x17e8, LSL #16
    BICS  X6, X9, X18, LSL #32
    ANDS  W22, W19, W17, LSR #24
    BIC  W25, W25, W27, LSR #3
    CSINC  X19, X18, X11, MI
    CLZ  W14, W11
    ANDS  W5, W4, W20, ROR #22
    BIC  X22, X20, X8, ASR #54
    SBFM  W8, W12, #0x1, #0x14
    CSEL  W6, W23, W29, VS
    UMADDL  X7, W8, W22, X5
    CSNEG  X5, X2, X17, VS
    ADC  W3, W27, W26
    CRC32W  W11, W14, W19
    SUB  W16, W14, W3, LSR #13
    CSNEG  W18, W10, W17, CS
    EXTR  W11, W12, W12, #0x8
    ORR  X11, X19, #0x1fe000001fe00000
    BIC  X19, X21, X16, LSR #47
    CSINC  W11, W9, W16, GE
    ASRV  X20, X28, X26
    EOR  X16, X18, #0xfffff3fffffff3ff
    SUBS  X19, X11, #0x7f0
    ANDS  X4, X17, #0xf3f3f3f3f3f3f3f3
    SUBS  X25, X4, #0xcc1, LSL #12
    ANDS  X9, X3, X6, LSR #17
    CRC32H  W9, W4, W5
    SUB  X7, X2, #0x8, LSL #12
    UMULH  X8, X28, X4
    CSINV  X20, X12, X14, CS
    LSRV  W19, W25, W15
    ADDS  W29, W15, W15, SXTX #0
    ORR  W19, W17, W18, ROR #10
    MOVK  X17, #0xe110, LSL #48
    MOVN  W17, #0x49c0, LSL #16
    BIC  V13.16B, V1.16B, V22.16B
    SUBS  W13, W2, W8, UXTH #0
    SUB  W5, W23, W28, UXTB #3
    CSINC  W3, W25, W12, LT
    ANDS  W8, W6, W16, ASR #25
    CSINV  W27, W27, W20, AL
    ADDS  X3, X17, #0x320
    LSRV  W14, W29, W5
    BIC  W14, W4, W6, LSR #31
    BIC  V0.16B, V28.16B, V6.16B
    ADC  X13, X22, X29
    EOR  X12, X21, X29, LSR #55
    CSNEG  W19, W26, W8, PL
    ADDS  X13, X21, #0x853, LSL #12
    CSINV  W17, W17, W14, MI
    ORN  W8, W12, W13, LSL #11
    LSRV  W5, W12, W2
    MOVZ  X28, #0xbdde, LSL #0
    MOVN  X19, #0xf216, LSL #48
    LSLV  X22, X23, X10
    EOR  W19, W16, #0xfffbfffb
    CRC32X  W4, W20, X4
    ADD  W6, W3, W3, ASR #3
    ANDS  W16, W15, W10, LSL #5
    ADD  X3, X22, #0xee
    SUB  X20, X26, #0xc78, LSL #12
    SUBS  W21, W28, W4, SXTB #3
    LSLV  W14, W3, W9
    ANDS  X9, X26, X6, LSR #52
    CSEL  X14, X27, X22, LS
    LSRV  W12, W17, W14
    ASRV  W29, W6, W5
    EOR  W25, W13, W25, LSR #12
    ANDS  X6, X2, #0xfffc0007fffc0007
    ADCS  W18, W21, W13
    ADDS  X13, X20, X22, UXTX #3
    ORR  V18.4S, #0xb3
    CLZ  X26, X21
    CSEL  X25, X11, X14, HI
    SUBS  X21, X22, #0x261, LSL #12
    CSNEG  W20, W28, W29, GT
    ADDS  W12, W14, #0xd80
    CSINC  W18, W8, W3, GE
    UMULH  X4, X8, X11
    SUB  W23, W19, #0xf23
    BIC  X7, X29, X21, ROR #34
    MADD  X7, X7, X5, X10
    MOVK  W18, #0x1742, LSL #16
    AND  X25, X26, #0xfc1ffc1ffc1ffc1f
    CSEL  W2, W8, W25, LE
    CSINC  W25, W28, W27, GE
    SMSUBL  X10, W8, W17, X7
    ORN  W17, W25, W22, LSL #25
    EOR  W4, W6, #0x44444444
    ORR  V16.8B, V5.8B, V24.8B
    SUBS  W6, W20, W21, ASR #20
    ADD  X19, X26, X17, ASR #58
    EOR  X4, X11, X18, LSL #18
    ORR  V29.8B, V11.8B, V25.8B
    ADD  X7, X27, X14, LSL #27
    ADD  X23, X3, X23, UXTX #2
    UMADDL  X10, W18, W23, X26
    SUBS  X15, X15, #0x1
    B.NE  TaishanIntAluP02_label_754
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xd67f, LSL #16
    SUB  X9, X15, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X12, #0xed, LSL #0
    SUB  X11, X12, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X18, #0x5b8f, LSL #0
    MOVK  X18, #0xf5bd, LSL #16
    MOVK  X18, #0x5d08, LSL #32
    SUB  X6, X18, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X5
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X21, X12, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP02_TestFail
    MOVZ  X14, #0x5b8f, LSL #0
    MOVK  X14, #0x6e05, LSL #16
    MOVK  X14, #0x2add, LSL #32
    MOVK  X14, #0x7b0, LSL #48
    SUB  X11, X14, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntAluP02_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xd67f, LSL #16
    SUB  X2, X16, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X2, #0x77a6, LSL #0
    MOVK  X2, #0xeab5, LSL #16
    MOVK  X2, #0x82fa, LSL #32
    MOVK  X2, #0x1740, LSL #48
    SUB  X17, X2, X10
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP02_TestFail
    MOVZ  X16, #0x3d59, LSL #0
    MOVK  X16, #0x3e35, LSL #16
    SUB  X13, X16, X13
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP02_TestFail
    MOVZ  X9, #0x3d59, LSL #0
    MOVK  X9, #0x3e35, LSL #16
    SUB  X4, X9, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X19, X12, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP02_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X17, X20, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X3, X22, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP02_TestFail
    MOVZ  X19, #0x5b90, LSL #0
    MOVK  X19, #0xf605, LSL #16
    SUB  X5, X19, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP02_TestFail
    MOVZ  X8, #0x30, LSL #0
    SUB  X21, X8, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X27
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP02_TestFail
    MOVZ  X4, #0xbdde, LSL #0
    SUB  X2, X4, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail
    MOVZ  X21, #0x382, LSL #0
    MOVK  X21, #0xad08, LSL #16
    SUB  X2, X21, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP02_TestFail

TaishanIntAluP02_TestEnd:
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
TaishanIntAluP02_TestFail:
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
