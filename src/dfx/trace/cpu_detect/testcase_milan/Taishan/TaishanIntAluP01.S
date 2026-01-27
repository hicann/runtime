.global TaishanIntAluP01

.text
.p2align 4

TaishanIntAluP01:

TaishanIntAluP01_TestBegin:
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
    MOVK  X2, #0x16d1, LSL #48
    MOVK  X2, #0xa3ca, LSL #32
    MOVK  X2, #0xd840, LSL #16
    MOVK  X2, #0x8578, LSL #0
    MOVK  X3, #0x135a, LSL #48
    MOVK  X3, #0x4676, LSL #32
    MOVK  X3, #0xf7c1, LSL #16
    MOVK  X3, #0x4df1, LSL #0
    MOVK  X4, #0x175, LSL #48
    MOVK  X4, #0xc83c, LSL #32
    MOVK  X4, #0xe710, LSL #16
    MOVK  X4, #0x1e1e, LSL #0
    MOVK  X5, #0x5b90, LSL #48
    MOVK  X5, #0x33af, LSL #32
    MOVK  X5, #0xbc35, LSL #16
    MOVK  X5, #0xf34, LSL #0
    MOVK  X6, #0xc51b, LSL #48
    MOVK  X6, #0x10a1, LSL #32
    MOVK  X6, #0x2870, LSL #16
    MOVK  X6, #0xb371, LSL #0
    MOVK  X7, #0xe172, LSL #48
    MOVK  X7, #0x2dc7, LSL #32
    MOVK  X7, #0x18ab, LSL #16
    MOVK  X7, #0x5639, LSL #0
    MOVK  X8, #0x9c9a, LSL #48
    MOVK  X8, #0xc258, LSL #32
    MOVK  X8, #0xfa82, LSL #16
    MOVK  X8, #0x4205, LSL #0
    MOVK  X9, #0xad76, LSL #48
    MOVK  X9, #0x5918, LSL #32
    MOVK  X9, #0x820e, LSL #16
    MOVK  X9, #0x215f, LSL #0
    MOVK  X10, #0xc1c0, LSL #48
    MOVK  X10, #0x332e, LSL #32
    MOVK  X10, #0xd0a9, LSL #16
    MOVK  X10, #0x7e5a, LSL #0
    MOVK  X12, #0x78d, LSL #48
    MOVK  X12, #0x899f, LSL #32
    MOVK  X12, #0x887c, LSL #16
    MOVK  X12, #0x8fe5, LSL #0
    MOVK  X13, #0x7d34, LSL #48
    MOVK  X13, #0x73de, LSL #32
    MOVK  X13, #0xd22b, LSL #16
    MOVK  X13, #0xd50d, LSL #0
    MOVK  X14, #0x913a, LSL #48
    MOVK  X14, #0x54f3, LSL #32
    MOVK  X14, #0x88ac, LSL #16
    MOVK  X14, #0xf48a, LSL #0
    MOVK  X15, #0x5ac5, LSL #48
    MOVK  X15, #0x286a, LSL #32
    MOVK  X15, #0xe4a1, LSL #16
    MOVK  X15, #0x3bae, LSL #0
    MOVK  X16, #0xe71a, LSL #48
    MOVK  X16, #0xe6d1, LSL #32
    MOVK  X16, #0x1869, LSL #16
    MOVK  X16, #0xae6f, LSL #0
    MOVK  X17, #0xef8, LSL #48
    MOVK  X17, #0x4552, LSL #32
    MOVK  X17, #0x125d, LSL #16
    MOVK  X17, #0x69fd, LSL #0
    MOVK  X18, #0x8bb9, LSL #48
    MOVK  X18, #0x26f3, LSL #32
    MOVK  X18, #0xfad4, LSL #16
    MOVK  X18, #0x8cd0, LSL #0
    MOVK  X19, #0xf018, LSL #48
    MOVK  X19, #0xcc18, LSL #32
    MOVK  X19, #0xa3f1, LSL #16
    MOVK  X19, #0x3393, LSL #0
    MOVK  X20, #0xc0b1, LSL #48
    MOVK  X20, #0xb1fa, LSL #32
    MOVK  X20, #0x97fa, LSL #16
    MOVK  X20, #0xcf3, LSL #0
    MOVK  X21, #0xa29f, LSL #48
    MOVK  X21, #0x576e, LSL #32
    MOVK  X21, #0x5488, LSL #16
    MOVK  X21, #0x5a6d, LSL #0
    MOVK  X22, #0x9ad7, LSL #48
    MOVK  X22, #0x94cc, LSL #32
    MOVK  X22, #0x39b3, LSL #16
    MOVK  X22, #0xf12e, LSL #0
    MOVK  X23, #0x34ae, LSL #48
    MOVK  X23, #0xe58f, LSL #32
    MOVK  X23, #0xec0a, LSL #16
    MOVK  X23, #0x345a, LSL #0
    MOVK  X24, #0x95f4, LSL #48
    MOVK  X24, #0x8815, LSL #32
    MOVK  X24, #0x18cf, LSL #16
    MOVK  X24, #0x1ba4, LSL #0
    MOVK  X25, #0x8c69, LSL #48
    MOVK  X25, #0xee14, LSL #32
    MOVK  X25, #0x2a01, LSL #16
    MOVK  X25, #0x8c64, LSL #0
    MOVK  X26, #0xc7d3, LSL #48
    MOVK  X26, #0x31ea, LSL #32
    MOVK  X26, #0x4e3d, LSL #16
    MOVK  X26, #0x764c, LSL #0
    MOVK  X27, #0x7f2f, LSL #48
    MOVK  X27, #0x9397, LSL #32
    MOVK  X27, #0xd482, LSL #16
    MOVK  X27, #0x29f1, LSL #0
    MOVK  X28, #0xee49, LSL #48
    MOVK  X28, #0x7373, LSL #32
    MOVK  X28, #0x205b, LSL #16
    MOVK  X28, #0x277a, LSL #0
    MOVK  X29, #0x55a1, LSL #48
    MOVK  X29, #0x7b0f, LSL #32
    MOVK  X29, #0x3090, LSL #16
    MOVK  X29, #0x1b3f, LSL #0
    ANDS  X8, X15, X4, LSR #10
    MOVZ  X2, #0x8dbe, LSL #0
    MOVK  X2, #0x9018, LSL #16
    MOVK  X2, #0x67e0, LSL #32
    MOVK  X2, #0x2314, LSL #48
    MOVZ  X3, #0x8f22, LSL #0
    MOVK  X3, #0x9094, LSL #16
    MOVK  X3, #0xde2, LSL #32
    MOVK  X3, #0xc43e, LSL #48
    MOVZ  X4, #0x19a9, LSL #0
    MOVK  X4, #0xb742, LSL #16
    MOVK  X4, #0x6c32, LSL #32
    MOVK  X4, #0x6bd4, LSL #48
    MOVZ  X5, #0x461e, LSL #0
    MOVK  X5, #0x5627, LSL #16
    MOVK  X5, #0xa296, LSL #32
    MOVK  X5, #0xd83b, LSL #48
    MOVZ  X6, #0x243c, LSL #0
    MOVK  X6, #0x1cbe, LSL #16
    MOVK  X6, #0x3ed1, LSL #32
    MOVK  X6, #0x15a7, LSL #48
    MOVZ  X7, #0x6bd3, LSL #0
    MOVK  X7, #0xaaa, LSL #16
    MOVK  X7, #0xb9, LSL #32
    MOVK  X7, #0xcb06, LSL #48
    MOVZ  X8, #0xfdf0, LSL #0
    MOVK  X8, #0xffd9, LSL #16
    MOVK  X8, #0x5b43, LSL #32
    MOVK  X8, #0x5443, LSL #48
    MOVZ  X9, #0x5600, LSL #0
    MOVK  X9, #0x6e1f, LSL #16
    MOVK  X9, #0xd101, LSL #32
    MOVK  X9, #0x8ea7, LSL #48
    MOVZ  X10, #0x7678, LSL #0
    MOVK  X10, #0xaeab, LSL #16
    MOVK  X10, #0x7a8b, LSL #32
    MOVK  X10, #0x3822, LSL #48
    MOVZ  X12, #0x47b7, LSL #0
    MOVK  X12, #0x978d, LSL #16
    MOVK  X12, #0x2091, LSL #32
    MOVK  X12, #0x742b, LSL #48
    MOVZ  X13, #0x54e4, LSL #0
    MOVK  X13, #0xdb38, LSL #16
    MOVK  X13, #0x3b20, LSL #32
    MOVK  X13, #0xb6a2, LSL #48
    MOVZ  X14, #0xac5c, LSL #0
    MOVK  X14, #0x93b4, LSL #16
    MOVK  X14, #0x8699, LSL #32
    MOVK  X14, #0xa46a, LSL #48
    MOVZ  X15, #0xbf73, LSL #0
    MOVK  X15, #0xfd19, LSL #16
    MOVK  X15, #0x268, LSL #32
    MOVK  X15, #0x3587, LSL #48
    MOVZ  X16, #0xf6e, LSL #0
    MOVK  X16, #0x4816, LSL #16
    MOVK  X16, #0x2ddd, LSL #32
    MOVK  X16, #0x3589, LSL #48
    MOVZ  X17, #0xf97f, LSL #0
    MOVK  X17, #0xc9f2, LSL #16
    MOVK  X17, #0x21ea, LSL #32
    MOVK  X17, #0xd195, LSL #48
    MOVZ  X18, #0xdc86, LSL #0
    MOVK  X18, #0x803f, LSL #16
    MOVK  X18, #0x59ab, LSL #32
    MOVK  X18, #0x87f8, LSL #48
    MOVZ  X19, #0x2e30, LSL #0
    MOVK  X19, #0xa98b, LSL #16
    MOVK  X19, #0xac6, LSL #32
    MOVK  X19, #0x5e71, LSL #48
    MOVZ  X20, #0xad5c, LSL #0
    MOVK  X20, #0x2fb7, LSL #16
    MOVK  X20, #0x8c72, LSL #32
    MOVK  X20, #0xc12e, LSL #48
    MOVZ  X21, #0x12a7, LSL #0
    MOVK  X21, #0xc854, LSL #16
    MOVK  X21, #0x4b8f, LSL #32
    MOVK  X21, #0x5408, LSL #48
    MOVZ  X22, #0xb6d3, LSL #0
    MOVK  X22, #0x620a, LSL #16
    MOVK  X22, #0x83d8, LSL #32
    MOVK  X22, #0x7841, LSL #48
    MOVZ  X23, #0x8e96, LSL #0
    MOVK  X23, #0x4b7d, LSL #16
    MOVK  X23, #0x8d78, LSL #32
    MOVK  X23, #0xe7e5, LSL #48
    MOVZ  X24, #0x9bc3, LSL #0
    MOVK  X24, #0xd38d, LSL #16
    MOVK  X24, #0xea7e, LSL #32
    MOVK  X24, #0x27ce, LSL #48
    MOVZ  X25, #0x2f51, LSL #0
    MOVK  X25, #0x7644, LSL #16
    MOVK  X25, #0x861f, LSL #32
    MOVK  X25, #0x29, LSL #48
    MOVZ  X26, #0x7ed0, LSL #0
    MOVK  X26, #0xe01d, LSL #16
    MOVK  X26, #0x8070, LSL #32
    MOVK  X26, #0x768a, LSL #48
    MOVZ  X27, #0x168d, LSL #0
    MOVK  X27, #0xb099, LSL #16
    MOVK  X27, #0xd20d, LSL #32
    MOVK  X27, #0xc396, LSL #48
    MOVZ  X28, #0x2074, LSL #0
    MOVK  X28, #0xfdbe, LSL #16
    MOVK  X28, #0x57c6, LSL #32
    MOVK  X28, #0x65a7, LSL #48
    MOVZ  X29, #0xb788, LSL #0
    MOVK  X29, #0x1864, LSL #16
    MOVK  X29, #0xf44f, LSL #32
    MOVK  X29, #0x172a, LSL #48
    MOVZ  X9, #0xa, LSL #0
TaishanIntAluP01_label_0:
    CLS  W26, W10
    BIC  X24, X28, X25, LSR #26
    CRC32X  W23, W19, X8
    ADC  W21, W9, W9
    ANDS  X25, X22, X26, ROR #45
    UBFM  X7, X6, #0x7, #0x35
    EOR  X20, X29, X24, LSL #20
    AND  W17, W28, W7, LSR #6
    LSLV  W10, W12, W12
    MOVK  W20, #0x7c8a, LSL #16
    EON  W17, W17, W3, LSR #11
    EOR  X24, X13, #0xffffffbfffffffbf
    BICS  X26, X12, X9, ASR #46
    BICS  W17, W5, W29, LSR #7
    SMSUBL  X24, W8, W16, X16
    CSINV  W4, W12, W14, GE
    CSEL  W4, W17, W19, CS
    UBFM  X26, X7, #0x19, #0x33
    ADDS  X20, X20, X29, ASR #16
    ORN  X29, X8, X29, LSL #24
    ORR  V2.8H, #0x52
    ORR  V13.8H, #0xa0
    SUBS  X14, X4, W27, SXTW #1
    UMADDL  X6, W25, W20, X21
    MADD  W24, W23, W9, W15
    CRC32CH  W16, W4, W13
    SUBS  X8, X29, #0x2
    ADDS  W24, W22, W26, LSR #6
    MOVZ  X3, #0x3b52, LSL #48
    MOVK  X7, #0xb411, LSL #32
    ADCS  W2, W14, W13
    SUB  W29, W7, W6, LSR #7
    ADDS  X20, X20, X9, LSL #6
    CRC32X  W15, W28, X28
    ASRV  X23, X2, X28
    EON  W23, W25, W3, ASR #13
    CRC32CH  W23, W27, W22
    AND  X23, X20, #0xcccccccccccccccc
    UBFM  X8, X24, #0x3, #0x15
    ANDS  X15, X25, #0x1fffffffff000000
    ORR  W28, W18, W18, ASR #31
    ORN  W27, W27, W24, ASR #12
    ASRV  W18, W6, W21
    ORN  X3, X9, X18, ROR #54
    ADD  X8, X10, #0xeac
    ADDS  W3, W12, #0x230
    CRC32H  W16, W10, W7
    ADDS  W25, W4, W5, UXTX #2
    MOVK  X6, #0x8aaf, LSL #0
    CRC32B  W17, W2, W14
    SUB  W6, W6, W28, SXTX #0
    SUB  X14, X25, X15, LSL #23
    MOVN  W3, #0x6dd, LSL #16
    SUB  W16, W27, #0x870, LSL #12
    CLZ  W29, W8
    MADD  W7, W23, W21, W27
    SUB  W6, W14, W7, SXTB #3
    CRC32X  W8, W3, X2
    CSEL  W8, W29, W27, NV
    BIC  X6, X8, X21, ASR #43
    SUBS  W24, W13, W24, LSL #12
    MOVZ  W24, #0xd524, LSL #16
    MOVZ  W14, #0xbd3f, LSL #0
    ORR  V31.8B, V30.8B, V6.8B
    SUB  X2, X27, W5, UXTH #1
    LSLV  W12, W15, W14
    CSEL  X3, X15, X2, HI
    ADCS  W26, W14, W12
    CRC32B  W13, W17, W23
    ORR  X20, X7, X4, LSR #52
    CSINC  W26, W10, W6, GT
    UBFM  X16, X22, #0x3, #0x1c
    UMSUBL  X13, W8, W18, X28
    SUB  W3, W29, #0x0
    EOR  X7, X20, #0xfe0ffe0ffe0ffe0f
    ADD  W6, W28, #0x365, LSL #12
    EOR  W19, W6, W10, LSL #5
    ORR  V23.8H, #0x44
    ADC  W29, W4, W8
    SUB  X24, X23, X24, UXTX #2
    SUB  W4, W25, W6, LSR #10
    CSINC  X2, X2, X8, MI
    CLS  X26, X7
    ORR  V29.8B, V17.8B, V28.8B
    ORR  X25, X29, X8, LSR #35
    ADD  W10, W18, #0x5dd
    MOVN  W5, #0x3a3a, LSL #16
    CSINV  X27, X13, X8, LE
    SUB  W22, W22, W4, UXTH #0
    ORR  W6, W24, #0x400040
    ADC  W27, W26, W6
    SUB  X20, X14, W21, UXTB #1
    ADDS  W22, W28, W28, UXTX #4
    SUB  X7, X27, X6, LSL #44
    SUB  W10, W25, W12, SXTB #4
    MADD  X22, X3, X20, X14
    SUBS  W18, W12, W26, ASR #1
    ADC  W12, W4, W22
    LSRV  X4, X12, X14
    CSINC  X4, X2, X21, VC
    CRC32CX  W8, W2, X28
    ORR  X22, X18, X12, ASR #22
    SUB  W7, W2, W14, LSR #5
    CRC32CX  W25, W23, X22
    ORN  X4, X29, X10, LSR #56
    CSINV  W21, W7, W6, AL
    BIC  W15, W21, W28, ASR #14
    ORR  V8.4H, #0x63
    ORR  V30.4S, #0xb1
    ADD  X14, X12, X22, LSL #63
    ORR  W22, W12, W21, ROR #10
    CLS  V26.8B, V7.8B
    BIC  X28, X28, X16, ROR #5
    ORR  X28, X12, X9, ASR #9
    ADC  X25, X25, X24
    CRC32H  W22, W18, W20
    BICS  W5, W9, W14, LSR #3
    SMULH  X24, X24, X15
    CRC32CX  W2, W12, X7
    CRC32W  W4, W28, W8
    BIC  X6, X24, X4, ROR #7
    EOR  W20, W10, W15, LSR #23
    CSINC  X18, X20, X10, CC
    SBFM  W15, W20, #0xf, #0xd
    ANDS  X5, X26, X28, ROR #49
    ANDS  W14, W15, #0xaaaaaaaa
    UMADDL  X13, W13, W6, X10
    BIC  V31.16B, V4.16B, V18.16B
    SUB  X18, X21, W2, SXTH #2
    ORR  X22, X26, X18, ROR #26
    UMADDL  X8, W5, W7, X16
    ADD  W8, W20, W13, UXTB #3
    CSNEG  W2, W13, W5, HI
    CLS  X14, X14
    CRC32CB  W25, W16, W13
    LSLV  W14, W25, W22
    AND  X25, X10, #0x7ffffc
    CSEL  X17, X9, X20, LS
    SUB  W25, W26, W17, SXTX #3
    CLZ  X12, X6
    CRC32CX  W14, W18, X8
    ADDS  W8, W14, W25, ASR #21
    ORR  X22, X19, #0x3fffff003fffff00
    CRC32CX  W13, W4, X19
    EOR  X16, X19, #0x9f9f9f9f9f9f9f9f
    BIC  X26, X4, X15, LSR #61
    LSLV  W10, W24, W21
    CRC32W  W8, W8, W16
    ADCS  X14, X28, X12
    MOVN  X3, #0xa50e, LSL #48
    SUBS  X2, X2, #0xd28, LSL #12
    LSRV  W10, W7, W2
    SUB  X4, X9, X26, LSR #4
    UBFM  X16, X16, #0x15, #0x3a
    MOVZ  X14, #0xafe3, LSL #48
    ANDS  X16, X5, X25, ASR #22
    MOVK  W8, #0x2756, LSL #16
    SUB  X17, X19, X20, LSR #49
    ASRV  W26, W19, W21
    CRC32CW  W10, W4, W27
    CRC32B  W27, W7, W7
    MOVN  W20, #0x9ef0, LSL #16
    ADCS  X5, X12, X29
    ORR  W24, W22, W3
    UMADDL  X4, W14, W25, X19
    CSINV  X2, X7, X4, CS
    ORN  W28, W26, W2, ASR #8
    ADDS  W2, W19, W28, SXTB #2
    SUBS  W5, W17, W25, LSL #29
    BIC  V18.16B, V19.16B, V28.16B
    EXTR  X26, X5, X2, #0xf
    CLS  W10, W21
    SUBS  X13, X17, W9, SXTW #3
    AND  W20, W9, W24, LSR #30
    EOR  W18, W2, W14, LSL #18
    CRC32CH  W3, W6, W7
    CRC32X  W23, W7, X27
    ORR  W29, W26, W10, LSL #6
    ORR  X21, X14, X19, ROR #31
    LSLV  X10, X25, X20
    ADCS  W13, W22, W2
    ORR  W8, W24, #0x1f0
    EOR  X10, X19, X19, LSR #62
    UBFM  X17, X26, #0x10, #0x10
    CSINC  X6, X10, X6, CC
    LSRV  X19, X8, X21
    CSINV  W15, W3, W6, PL
    ORR  X24, X29, #0xffc0007fffc0007f
    CLS  W12, W9
    MADD  W3, W19, W20, W14
    CSINC  W5, W5, W27, GE
    SUBS  W24, W23, W19, UXTW #3
    ANDS  W22, W9, W13, LSR #30
    ANDS  X7, X24, X5, ASR #12
    ANDS  W4, W16, W6, LSL #25
    ADDS  X24, X9, X23, LSR #40
    AND  W26, W6, W13, ROR #10
    SMSUBL  X21, W28, W2, X9
    ORR  W14, W2, #0xe
    SUBS  X28, X2, X28, LSL #60
    SUBS  X9, X9, #0x1
    B.NE  TaishanIntAluP01_label_0
    MOVZ  X23, #0x262b, LSL #0
    MOVK  X23, #0x721f, LSL #16
    SUB  X8, X23, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X13, X20, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X17, X28, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X8
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP01_TestFail
    MOVZ  X28, #0x2453, LSL #0
    MOVK  X28, #0x721f, LSL #16
    SUB  X14, X28, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP01_TestFail
    MOVZ  X3, #0x1e, LSL #0
    SUB  X28, X3, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X15, X2, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP01_TestFail
    MOVZ  X22, #0x1, LSL #0
    SUB  X23, X22, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X5, X19, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X23, #0x441, LSL #0
    MOVK  X23, #0x521c, LSL #16
    SUB  X20, X23, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X27
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X14, #0xe53e, LSL #0
    SUB  X8, X14, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
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
    MOVZ  X8, #0xa, LSL #0
TaishanIntAluP01_label_28:
    ADDS  X4, X26, W14, SXTW #3
    ADD  W20, W7, #0xa5d
    SUB  W29, W16, W8, SXTB #2
    LSRV  X12, X10, X28
    MOVZ  X20, #0x5ddd, LSL #16
    ADD  W3, W25, W28, LSR #13
    BICS  W21, W19, W25, LSR #16
    ADCS  X18, X3, X24
    CRC32B  W23, W3, W8
    SUBS  W15, W29, W20, UXTW #0
    CRC32CH  W21, W26, W12
    CLS  X22, X27
    CRC32CH  W14, W22, W28
    EOR  W4, W22, #0x1ffff0
    ADD  X5, X5, W27, UXTH #3
    SMULH  X7, X13, X24
    MOVZ  W18, #0x2d47, LSL #0
    ADC  W21, W17, W3
    ORR  V0.8H, #0xbd, LSL #8
    ASRV  X22, X4, X28
    LSRV  X15, X13, X5
    ORN  W27, W19, W19, ASR #31
    SBFM  W29, W22, #0x1b, #0x1c
    ADD  W12, W19, #0xb82, LSL #12
    LSLV  X21, X22, X15
    ADD  X27, X21, W17, UXTB #4
    LSLV  W22, W16, W29
    CLS  V4.8H, V21.8H
    SMULH  X27, X26, X18
    CSINC  X15, X20, X14, MI
    LSRV  X25, X7, X22
    CRC32X  W13, W10, X13
    ORN  X15, X9, X26, ASR #1
    EOR  X17, X12, X24, LSR #12
    EOR  W5, W13, W8, LSL #29
    CLS  X17, X26
    LSRV  W18, W25, W25
    ADDS  X16, X4, X18, LSR #34
    EOR  X29, X6, X27, ASR #6
    UMSUBL  X6, W25, W13, X12
    CSNEG  W25, W3, W26, HI
    BICS  X19, X20, X6, ROR #25
    ORR  V0.4H, #0xef, LSL #8
    SMADDL  X26, W26, W28, X16
    SUBS  X29, X22, #0xeda, LSL #12
    ADD  X29, X7, #0x120
    ASRV  X26, X20, X17
    ADDS  X27, X18, W26, UXTB #4
    SUBS  X5, X14, X8, LSR #59
    UMSUBL  X19, W17, W29, X13
    BICS  W23, W5, W26, LSR #20
    SMADDL  X21, W26, W4, X19
    MOVZ  X25, #0x8a7f, LSL #32
    MOVK  X20, #0x38c5, LSL #16
    CRC32W  W16, W6, W12
    SBFM  W26, W16, #0xc, #0x6
    EOR  W22, W8, W22, LSR #16
    EON  W18, W22, W20, LSL #20
    AND  X10, X21, X22, ROR #46
    MOVK  X10, #0x24d9, LSL #48
    CLZ  X5, X26
    MOVK  X27, #0xa120, LSL #32
    AND  X2, X17, X16, LSR #63
    ADDS  X12, X12, W9, SXTW #2
    CSINC  X28, X17, X12, LT
    ORR  V13.4S, #0x71, LSL #24
    ADC  X29, X19, X16
    ORR  X14, X13, #0xc7c7c7c7c7c7c7c7
    MADD  W25, W29, W19, W4
    ANDS  W25, W22, W28, LSL #2
    SMSUBL  X23, W27, W28, X6
    UMSUBL  X26, W18, W15, X21
    ADCS  X3, X19, X17
    ASRV  W2, W10, W22
    CLS  X12, X25
    MOVZ  W6, #0xf034, LSL #0
    ORN  W25, W13, W9, LSR #4
    CSINC  W28, W6, W27, MI
    CLS  V18.2S, V28.2S
    ADD  X13, X21, W6, UXTW #3
    SMSUBL  X5, W15, W14, X16
    SUB  X12, X5, W15, SXTH #2
    UBFM  X6, X21, #0x1e, #0xc
    CLS  W9, W22
    EOR  W15, W9, #0x1800000
    ADD  W13, W15, W15, SXTH #3
    CSNEG  X12, X15, X13, NE
    ANDS  X25, X25, #0x7ffffffffffe0
    MADD  X5, X9, X27, X27
    ANDS  X14, X14, #0x7ffffff87ffffff8
    CRC32W  W6, W18, W19
    ORR  V22.4H, #0xe6, LSL #8
    ANDS  W25, W28, W27, ROR #13
    AND  W21, W27, #0xfdfdfdfd
    SUB  W3, W28, #0x513, LSL #12
    SUB  W28, W13, W19, UXTB #1
    AND  W19, W14, W18, ASR #4
    SBFM  W4, W7, #0x9, #0x0
    MOVZ  W16, #0xdbf5, LSL #0
    ORR  V10.2S, #0x13, LSL #8
    AND  W28, W8, W7, ROR #25
    SBFM  X9, X6, #0x1b, #0x6
    MADD  W2, W20, W7, W2
    ORN  W3, W10, W16, ROR #22
    ORN  X18, X4, X10, ASR #54
    CRC32CX  W16, W18, X3
    SUB  X5, X28, #0x0
    ADDS  X24, X6, W17, SXTW #3
    BIC  W20, W22, W28, ASR #0
    AND  X19, X14, #0x3fffe0003fffe000
    BICS  W16, W20, W24, LSR #1
    ANDS  W12, W5, #0x7e0000
    ANDS  X12, X20, #0xe0ffffffe0ffffff
    CSINC  X5, X13, X19, CS
    CLS  V5.8H, V14.8H
    SUBS  X27, X20, #0x350
    ORN  X27, X19, X14, ROR #42
    ORR  W25, W22, #0x1ffffff
    BIC  W10, W27, W14, ASR #4
    CSINV  X25, X2, X21, GT
    SUBS  X21, X22, X13, LSR #29
    CLS  X13, X2
    SUB  W9, W13, #0xd53, LSL #12
    UMSUBL  X24, W19, W22, X7
    ADDS  W5, W23, W14, ASR #14
    CSEL  W6, W28, W17, HI
    CLS  X20, X13
    LSRV  W22, W5, W26
    SUB  W27, W8, #0xbff
    MOVZ  X29, #0x3bd1, LSL #0
    ORN  W12, W14, W23, ASR #31
    MOVZ  W15, #0x4a7c, LSL #0
    UMSUBL  X21, W22, W15, X27
    ADDS  X19, X6, W20, SXTW #4
    AND  X21, X28, X8, ASR #63
    ADD  W24, W27, W14, UXTX #0
    EON  X25, X18, X24, LSL #34
    CSINV  X14, X29, X14, LE
    ORR  W24, W27, W14, LSR #12
    MOVN  X15, #0xf08b, LSL #16
    CLS  X15, X18
    LSRV  X9, X22, X26
    EOR  W18, W21, #0x81818181
    ORR  W19, W24, W13, ROR #25
    ADD  X17, X22, X29, LSL #50
    BICS  W16, W18, W25, LSR #6
    SMSUBL  X23, W17, W6, X24
    SMSUBL  X26, W29, W13, X19
    SMSUBL  X5, W16, W10, X15
    ADC  W4, W8, W26
    ORR  X14, X2, #0xf80000000
    BIC  W17, W27, W5, ROR #29
    CSNEG  X22, X29, X28, NE
    CSNEG  W18, W8, W14, LS
    SUB  X3, X4, X18, LSR #42
    ANDS  W14, W8, W21, LSR #8
    CRC32X  W26, W2, X23
    LSLV  X16, X2, X9
    ADDS  X7, X2, #0xfa9
    CSNEG  X29, X17, X24, PL
    SUBS  X29, X14, W29, SXTB #0
    ADD  W10, W21, #0xb2b
    ANDS  W23, W9, W10, LSL #7
    CSINV  X26, X14, X2, MI
    CRC32W  W13, W8, W24
    ADDS  X12, X14, #0x9c3
    UBFM  X12, X22, #0x17, #0x1f
    CSINC  X5, X28, X6, LT
    ORN  W10, W23, W10, ASR #25
    ORR  W2, W16, #0xe1ffe1ff
    MADD  X19, X21, X10, X7
    EOR  X23, X17, X5, LSL #56
    CLZ  X12, X3
    UBFM  W2, W22, #0x5, #0xd
    MOVK  X10, #0x5bc0, LSL #16
    SUB  X19, X9, W21, UXTH #1
    ADCS  W16, W29, W23
    ADD  W12, W23, W25, SXTB #2
    ANDS  W21, W21, #0xfff83fff
    AND  X2, X9, #0x400000000000
    SMADDL  X29, W7, W26, X27
    SUB  X17, X3, #0xe74
    CRC32X  W26, W2, X4
    CLS  V25.8H, V16.8H
    ORN  W4, W9, W29, ASR #25
    SUBS  X17, X23, X29, UXTX #2
    BIC  V4.16B, V16.16B, V26.16B
    ORN  X23, X27, X19, ASR #4
    CRC32CX  W25, W16, X14
    ORR  V6.16B, V5.16B, V7.16B
    LSLV  X20, X23, X26
    BICS  X19, X10, X12, LSL #46
    ADDS  W26, W24, #0x6f2, LSL #12
    CSNEG  X5, X27, X17, NE
    SUB  W4, W16, W9, ASR #31
    ANDS  W25, W9, W25, ASR #31
    ADDS  X25, X7, X6, UXTX #1
    CSINV  W5, W3, W25, CS
    SUBS  W5, W24, #0x930
    ORR  W16, W29, W19, ROR #26
    SUBS  X8, X8, #0x1
    B.NE  TaishanIntAluP01_label_28
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP01_TestFail
    MOVZ  X12, #0x4715, LSL #0
    MOVK  X12, #0xfff1, LSL #16
    SUB  X17, X12, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP01_TestFail
    MOVZ  X4, #0x1400, LSL #0
    MOVK  X4, #0x1234, LSL #16
    SUB  X19, X4, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X9, #0xee53, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X23, X9, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X5, #0x28, LSL #0
    SUB  X23, X5, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X19, #0xfa9, LSL #0
    SUB  X14, X19, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X9, X29, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0x5bc0, LSL #16
    SUB  X21, X4, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X21, #0x4715, LSL #0
    MOVK  X21, #0xfff1, LSL #16
    SUB  X12, X21, X12
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X5, #0x91a, LSL #0
    MOVK  X5, #0x49fd, LSL #16
    SUB  X29, X5, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP01_TestFail
    MOVZ  X29, #0x37, LSL #0
    SUB  X10, X29, X15
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X21, #0xffdf, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X23, X21, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP01_TestFail
    MOVZ  X12, #0xfa9, LSL #0
    SUB  X19, X12, X19
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X12, #0xffdf, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X4, X12, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X17, X6, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X7, #0xf783, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X6, X7, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
    MOVZ  X13, #0xff9, LSL #0
    SUB  X27, X13, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X29
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP01_TestFail
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
    MOVZ  X28, #0x14, LSL #0
TaishanIntAluP01_label_56:
    CLZ  V19.8H, V10.8H
    CRC32W  W25, W16, W28
    CLS  X27, X26
    ANDS  X26, X27, #0x3fffffe0000
    CSINV  W13, W23, W14, LE
    ASRV  X18, X12, X25
    ORN  X15, X19, X18, ROR #59
    UBFM  X29, X2, #0x2d, #0x3e
    ADDS  X5, X26, W19, UXTW #0
    ADDS  X7, X16, #0xa93
    MADD  X3, X20, X29, X2
    SUBS  X17, X23, X5, LSL #46
    SUBS  W9, W8, W3, SXTH #0
    CRC32CB  W16, W28, W27
    EOR  X15, X6, #0x87ff87ff87ff87ff
    AND  W15, W15, W18, LSL #2
    CRC32CW  W14, W12, W25
    ADDS  W17, W16, W4, LSL #28
    CRC32B  W4, W29, W4
    SUB  X8, X26, W27, SXTB #0
    LSLV  X3, X15, X27
    SUBS  X21, X2, X23, LSL #60
    CRC32B  W12, W3, W23
    EOR  W12, W19, #0x60606060
    ADC  W26, W7, W19
    ASRV  W26, W7, W26
    ADD  W4, W18, W26, LSR #30
    ADDS  X22, X13, X19, ASR #61
    SUB  W13, W21, #0xf94, LSL #12
    BICS  X8, X12, X5, ASR #62
    MOVN  W29, #0xe19, LSL #0
    SUBS  X17, X9, W19, SXTB #4
    ORN  W29, W15, W3, ROR #14
    ORN  W19, W28, W23, LSR #22
    EXTR  W7, W9, W20, #0xe
    ADD  X8, X4, #0xb60
    ADDS  W8, W14, W25, ASR #17
    ADD  W22, W21, W28, ASR #6
    ORR  V8.2S, #0x8a, LSL #16
    SUBS  W2, W19, W19, ASR #3
    ADDS  X29, X3, X7, LSR #53
    CRC32H  W10, W8, W15
    CRC32X  W7, W15, X26
    EON  X9, X4, X4, LSL #35
    LSLV  W27, W8, W10
    SUB  W23, W15, W23, LSR #12
    SBFM  X21, X28, #0x3b, #0x21
    SMULH  X21, X16, X23
    SBFM  X3, X29, #0x8, #0x2e
    SUBS  W2, W2, W22, ASR #10
    MOVK  X7, #0xf95, LSL #16
    CSEL  X13, X19, X5, HI
    BICS  X7, X10, X8, LSL #52
    MOVZ  W25, #0xf1ba, LSL #16
    BICS  W23, W5, W27, ASR #31
    SUBS  X7, X4, X2, LSR #46
    SUBS  W29, W21, W9, LSR #19
    CSINC  X9, X7, X19, LE
    EXTR  X5, X23, X3, #0x3
    SUBS  X13, X29, #0x179
    LSRV  X29, X4, X18
    MOVK  W27, #0x98a1, LSL #0
    CLS  W26, W4
    SUBS  W21, W8, W19, SXTH #3
    MOVZ  X5, #0xf4ea, LSL #48
    ORN  X9, X9, X29, ASR #20
    EOR  X13, X8, X8, ASR #54
    BIC  V12.8B, V26.8B, V4.8B
    ANDS  X12, X25, #0xffff007fffff007f
    UBFM  X22, X12, #0x6, #0x2b
    BIC  W2, W28, W14, ROR #4
    ORR  X16, X7, #0xfffe00000
    CLZ  W10, W24
    CRC32H  W18, W28, W18
    CSINV  X29, X27, X25, MI
    ADC  X9, X24, X16
    EXTR  X6, X24, X8, #0x2d
    EON  W4, W19, W25, ROR #22
    MOVK  X3, #0x4a7c, LSL #48
    CSEL  W13, W25, W9, LS
    EON  W27, W13, W7, LSR #4
    SUB  W19, W3, W29, LSL #20
    ANDS  W6, W29, W24, LSL #31
    LSLV  X10, X27, X21
    ADD  X22, X5, #0x52f, LSL #12
    ADD  W18, W16, #0x355
    BIC  X18, X7, X28, LSL #20
    CLS  V9.4H, V22.4H
    CRC32H  W6, W18, W4
    ADDS  W5, W15, W22, ASR #27
    ADD  W19, W20, W17, UXTX #4
    ORR  V9.4S, #0x3c, LSL #16
    MADD  W20, W28, W8, W3
    CSEL  X18, X14, X7, NV
    ADD  X19, X16, X6, ASR #39
    UBFM  W9, W26, #0x6, #0x16
    MADD  W22, W26, W7, W16
    MADD  X17, X22, X16, X4
    SBFM  X20, X24, #0x33, #0x31
    MOVZ  W17, #0xdb77, LSL #16
    CSEL  X17, X9, X25, LT
    ADDS  W19, W12, W20, ASR #18
    SUB  X10, X17, X29, SXTX #1
    ADDS  X8, X13, X24, ASR #3
    ADDS  W23, W4, W14, SXTB #2
    ORR  V22.16B, V10.16B, V22.16B
    CSNEG  X24, X5, X26, CS
    ADCS  W4, W18, W14
    UMSUBL  X12, W2, W6, X3
    SUB  W15, W17, #0xef0, LSL #12
    SUB  W20, W26, W22, SXTB #0
    MOVN  W16, #0xa8c6, LSL #0
    CRC32CB  W29, W29, W16
    CLZ  V5.4S, V22.4S
    LSRV  W19, W20, W12
    BIC  X5, X12, X22, LSL #20
    ANDS  X10, X17, #0x7ffffffffffc00
    AND  X18, X16, X19, LSR #0
    SUBS  X29, X23, X23, LSR #28
    ADDS  W13, W2, W15, UXTX #2
    MOVN  W17, #0xf20e, LSL #16
    CRC32CW  W15, W5, W6
    CLZ  W12, W23
    MOVK  W4, #0xe5f7, LSL #0
    SUBS  W22, W26, W10, LSR #22
    ORR  X4, X23, #0x18000000
    CSINV  X20, X18, X29, GT
    CLS  W15, W20
    ORN  X3, X23, X28, LSL #27
    CSEL  X4, X21, X8, LT
    ADCS  W25, W29, W14
    CRC32H  W20, W6, W3
    MOVN  W13, #0x79e8, LSL #0
    ADD  X27, X14, X5, LSR #0
    UMULH  X22, X23, X22
    UBFM  X20, X6, #0x30, #0x2b
    SUB  W9, W18, W12, ASR #24
    CRC32CH  W15, W16, W17
    UBFM  X7, X15, #0xf, #0x3d
    ADD  W5, W29, W9, ASR #11
    CSINC  W7, W18, W25, LE
    ADDS  W7, W17, W27, LSR #18
    CSINC  X22, X14, X13, VC
    SUB  X12, X23, X14, LSR #38
    ANDS  W6, W19, W23, LSL #26
    CLZ  V10.16B, V13.16B
    CSINC  W27, W20, W8, EQ
    SBFM  W23, W3, #0x13, #0xe
    CSNEG  W23, W15, W24, VC
    ADDS  X9, X27, X26, LSL #24
    ADDS  W5, W9, #0x558, LSL #12
    CLZ  W16, W13
    ADDS  X17, X28, X7, ASR #45
    AND  W6, W5, #0xfc0ffc0f
    CLS  W6, W6
    SUB  X13, X22, W28, UXTH #2
    CSINC  X22, X9, X25, AL
    CSINV  W4, W7, W16, GE
    AND  W22, W21, W8, ROR #8
    SUBS  W8, W20, #0xbcc
    SUBS  X3, X12, #0x4d1, LSL #12
    ADD  W23, W22, #0x796
    ORR  W7, W19, #0xfc0fffff
    SMADDL  X26, W14, W15, X24
    SUB  W20, W23, W10, ASR #7
    SUBS  W20, W18, W5, SXTB #3
    MOVK  X2, #0x419f, LSL #48
    ADDS  W22, W4, W23, ASR #20
    LSLV  W9, W4, W6
    BICS  W9, W19, W17, ROR #25
    CRC32X  W22, W19, X13
    ADC  W23, W4, W20
    MOVZ  X2, #0x6, LSL #0
    CLZ  W22, W8
    SUBS  X25, X22, #0xf48
    AND  X12, X21, X22, ROR #15
    EOR  W21, W2, W2, ASR #18
    UMULH  X22, X8, X16
    BIC  W9, W6, W29, ROR #2
    CLZ  X12, X27
    SUB  W18, W16, W8, LSR #15
    ASRV  X23, X29, X17
    ADD  W17, W27, W10, ASR #5
    MADD  X12, X17, X4, X4
    LSLV  X22, X16, X18
    ORN  W27, W12, W29, ASR #20
    SMADDL  X21, W19, W29, X20
    ORR  W7, W23, W7, ROR #1
    CRC32B  W19, W27, W28
    ANDS  W2, W12, W6, LSL #26
    CRC32CX  W7, W14, X2
    SUB  X2, X19, W5, UXTB #2
    EOR  W14, W16, W18, LSR #20
    BICS  X26, X27, X28, LSR #53
    ADCS  W4, W12, W4
    SUB  W26, W25, W12, SXTW #3
    ORR  V23.16B, V11.16B, V14.16B
    ANDS  W9, W19, W6, LSL #3
    BICS  X9, X3, X23, ASR #30
    ORN  W14, W20, W14, LSR #14
    SUBS  X28, X28, #0x1
    B.NE  TaishanIntAluP01_label_56
    MOVZ  X17, #0xd0ca, LSL #0
    MOVK  X17, #0x5a2f, LSL #16
    SUB  X5, X17, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X27, #0xf516, LSL #0
    MOVK  X27, #0xe7b2, LSL #16
    SUB  X15, X27, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X9, #0xe398, LSL #0
    MOVK  X9, #0x3801, LSL #16
    SUB  X22, X9, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X23, X21, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X8, X21, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X3, #0xde6, LSL #0
    MOVK  X3, #0x46fc, LSL #16
    SUB  X25, X3, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X8
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X18, #0xe398, LSL #0
    MOVK  X18, #0x3801, LSL #16
    SUB  X20, X18, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xf1ba, LSL #16
    SUB  X15, X14, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X4, #0xd1cc, LSL #0
    MOVK  X4, #0x2a0f, LSL #16
    MOVK  X4, #0xbea9, LSL #32
    MOVK  X4, #0x752, LSL #48
    SUB  X22, X4, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X29, #0x4176, LSL #0
    MOVK  X29, #0x4135, LSL #16
    SUB  X7, X29, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xf1ba, LSL #16
    SUB  X2, X5, X14
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X14, X19, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X4, X24, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
    MOVZ  X20, #0xd0ca, LSL #0
    MOVK  X20, #0x5a2f, LSL #16
    SUB  X12, X20, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X16, #0xe398, LSL #0
    MOVK  X16, #0x3801, LSL #16
    SUB  X8, X16, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X23, #0xd0ca, LSL #0
    MOVK  X23, #0x5a2f, LSL #16
    SUB  X18, X23, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X14, #0xd0ca, LSL #0
    MOVK  X14, #0x5a2f, LSL #16
    SUB  X19, X14, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X28, X8, X24
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP01_TestFail
    MOVZ  X13, #0x6258, LSL #0
    MOVK  X13, #0xaf81, LSL #16
    SUB  X25, X13, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X5, #0xf516, LSL #0
    MOVK  X5, #0xe7b2, LSL #16
    SUB  X17, X5, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X23, #0x4176, LSL #0
    MOVK  X23, #0x4135, LSL #16
    SUB  X9, X23, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x3337, LSL #0
    MOVK  X2, #0x8db1, LSL #16
    MOVK  X2, #0xad6d, LSL #32
    MOVK  X2, #0x9ab8, LSL #48
    MOVZ  X3, #0x1f95, LSL #0
    MOVK  X3, #0xaf14, LSL #16
    MOVK  X3, #0xbe7b, LSL #32
    MOVK  X3, #0x3ef5, LSL #48
    MOVZ  X4, #0x1a62, LSL #0
    MOVK  X4, #0x9fe, LSL #16
    MOVK  X4, #0xc9f1, LSL #32
    MOVK  X4, #0x8355, LSL #48
    MOVZ  X5, #0xbafc, LSL #0
    MOVK  X5, #0x90a9, LSL #16
    MOVK  X5, #0x54f4, LSL #32
    MOVK  X5, #0xa00a, LSL #48
    MOVZ  X6, #0xe8d, LSL #0
    MOVK  X6, #0x444, LSL #16
    MOVK  X6, #0x1497, LSL #32
    MOVK  X6, #0xfb36, LSL #48
    MOVZ  X7, #0xf267, LSL #0
    MOVK  X7, #0x38d9, LSL #16
    MOVK  X7, #0x3494, LSL #32
    MOVK  X7, #0xbf97, LSL #48
    MOVZ  X8, #0xe521, LSL #0
    MOVK  X8, #0xa99f, LSL #16
    MOVK  X8, #0x64ef, LSL #32
    MOVK  X8, #0x7a29, LSL #48
    MOVZ  X9, #0x2f7b, LSL #0
    MOVK  X9, #0x1508, LSL #16
    MOVK  X9, #0xf646, LSL #32
    MOVK  X9, #0xb336, LSL #48
    MOVZ  X10, #0x7b65, LSL #0
    MOVK  X10, #0x4356, LSL #16
    MOVK  X10, #0x88cb, LSL #32
    MOVK  X10, #0x436b, LSL #48
    MOVZ  X12, #0x9ac5, LSL #0
    MOVK  X12, #0x590d, LSL #16
    MOVK  X12, #0xbef9, LSL #32
    MOVK  X12, #0xf5e6, LSL #48
    MOVZ  X13, #0xb118, LSL #0
    MOVK  X13, #0xca77, LSL #16
    MOVK  X13, #0xa5ad, LSL #32
    MOVK  X13, #0x20d7, LSL #48
    MOVZ  X14, #0xbf70, LSL #0
    MOVK  X14, #0x8358, LSL #16
    MOVK  X14, #0xd299, LSL #32
    MOVK  X14, #0x5c7c, LSL #48
    MOVZ  X15, #0x2f11, LSL #0
    MOVK  X15, #0x7bcc, LSL #16
    MOVK  X15, #0x460b, LSL #32
    MOVK  X15, #0xc4c0, LSL #48
    MOVZ  X16, #0x22ea, LSL #0
    MOVK  X16, #0x2094, LSL #16
    MOVK  X16, #0x2e36, LSL #32
    MOVK  X16, #0xe2df, LSL #48
    MOVZ  X17, #0x2c9a, LSL #0
    MOVK  X17, #0x998e, LSL #16
    MOVK  X17, #0xc7f2, LSL #32
    MOVK  X17, #0x1581, LSL #48
    MOVZ  X18, #0x7271, LSL #0
    MOVK  X18, #0xfe05, LSL #16
    MOVK  X18, #0xfe80, LSL #32
    MOVK  X18, #0xa0ac, LSL #48
    MOVZ  X19, #0x33cb, LSL #0
    MOVK  X19, #0x7705, LSL #16
    MOVK  X19, #0x85cc, LSL #32
    MOVK  X19, #0x8a2, LSL #48
    MOVZ  X20, #0x8d88, LSL #0
    MOVK  X20, #0x259e, LSL #16
    MOVK  X20, #0x2d0b, LSL #32
    MOVK  X20, #0xfa58, LSL #48
    MOVZ  X21, #0xe036, LSL #0
    MOVK  X21, #0x65e6, LSL #16
    MOVK  X21, #0x7dd8, LSL #32
    MOVK  X21, #0xb903, LSL #48
    MOVZ  X22, #0x484e, LSL #0
    MOVK  X22, #0x3cda, LSL #16
    MOVK  X22, #0xb5ac, LSL #32
    MOVK  X22, #0x7b75, LSL #48
    MOVZ  X23, #0x54e2, LSL #0
    MOVK  X23, #0xd317, LSL #16
    MOVK  X23, #0x19eb, LSL #32
    MOVK  X23, #0x137, LSL #48
    MOVZ  X24, #0xc548, LSL #0
    MOVK  X24, #0xd03f, LSL #16
    MOVK  X24, #0xe3b8, LSL #32
    MOVK  X24, #0x5d9e, LSL #48
    MOVZ  X25, #0x86b2, LSL #0
    MOVK  X25, #0x6e85, LSL #16
    MOVK  X25, #0x10aa, LSL #32
    MOVK  X25, #0x9911, LSL #48
    MOVZ  X26, #0x944f, LSL #0
    MOVK  X26, #0x38f6, LSL #16
    MOVK  X26, #0x1543, LSL #32
    MOVK  X26, #0x1e9, LSL #48
    MOVZ  X27, #0xa9a5, LSL #0
    MOVK  X27, #0xff9b, LSL #16
    MOVK  X27, #0xd981, LSL #32
    MOVK  X27, #0xa14a, LSL #48
    MOVZ  X28, #0x2571, LSL #0
    MOVK  X28, #0x76bc, LSL #16
    MOVK  X28, #0x7a8b, LSL #32
    MOVK  X28, #0x22d4, LSL #48
    MOVZ  X29, #0xf343, LSL #0
    MOVK  X29, #0xd014, LSL #16
    MOVK  X29, #0x87dd, LSL #32
    MOVK  X29, #0x246c, LSL #48
    MOVZ  X28, #0xa, LSL #0
TaishanIntAluP01_label_84:
    AND  X16, X26, X29, ROR #5
    ADD  W4, W13, W14, SXTW #1
    CRC32H  W17, W27, W20
    MOVZ  X3, #0x698b, LSL #0
    CLZ  V8.8H, V25.8H
    LSLV  X27, X28, X3
    EOR  W20, W15, #0x2020202
    EXTR  W12, W16, W24, #0x17
    ANDS  W12, W28, #0x3fc00000
    ADD  X18, X28, #0x2d1
    CSINC  X20, X12, X26, LT
    CSNEG  X16, X4, X3, LE
    EXTR  X12, X23, X27, #0x38
    ADC  X16, X17, X7
    ANDS  X10, X18, X28, LSR #55
    CRC32X  W27, W2, X20
    ORR  W20, W12, W4, LSL #11
    EXTR  X29, X22, X16, #0x30
    SUB  W29, W16, #0xfcd, LSL #12
    ADD  W10, W12, #0xec1, LSL #12
    CRC32CH  W27, W10, W14
    MADD  X24, X19, X13, X22
    MADD  X16, X6, X29, X10
    EON  W21, W28, W26, ASR #29
    LSRV  X5, X10, X3
    ADDS  X12, X15, W15, SXTW #0
    SUBS  X20, X4, #0x110
    ADCS  W25, W27, W4
    MADD  W8, W3, W24, W24
    ADCS  W29, W16, W25
    SUBS  X19, X23, W8, SXTB #1
    SUBS  W2, W17, W14, UXTH #1
    ORR  W27, W8, #0xffffffcf
    SUBS  W6, W18, #0x120
    CRC32CX  W7, W18, X22
    ASRV  W3, W6, W24
    ANDS  X19, X6, X16, ROR #6
    CLZ  V9.16B, V8.16B
    LSLV  W14, W25, W21
    SUB  X13, X4, X21, LSR #17
    ORR  X24, X9, #0xfffffff000000007
    ADDS  X21, X17, #0x27a
    UBFM  W4, W26, #0x3, #0x10
    CSINV  X29, X16, X12, GT
    ASRV  X18, X16, X29
    ADD  X6, X28, X17, LSL #63
    EXTR  X16, X7, X21, #0x33
    SUBS  X3, X8, #0x9da
    MADD  X29, X28, X22, X28
    AND  X14, X19, #0x3f8000000
    MOVZ  W17, #0xdf5, LSL #0
    SUBS  X19, X6, X8, ASR #48
    ORN  W6, W27, W27, ASR #4
    SUB  X10, X29, X6, LSR #42
    CLZ  V18.8B, V23.8B
    CLS  V16.2S, V25.2S
    ADDS  W2, W10, #0xee0
    SUBS  W23, W6, #0x54b
    EOR  W4, W26, W27, LSL #3
    CSINC  W4, W22, W14, NE
    LSRV  X12, X2, X12
    LSLV  W7, W2, W26
    BICS  X24, X21, X23, ROR #25
    SBFM  X20, X2, #0x6, #0x1e
    BICS  X7, X20, X15, ASR #41
    MOVN  W3, #0x256f, LSL #0
    MOVN  X24, #0xc129, LSL #0
    ADD  X9, X19, #0xc67, LSL #12
    ORN  W16, W16, W4, LSL #23
    LSLV  W29, W27, W24
    AND  X16, X25, X2, ROR #52
    ORR  W25, W12, W28, LSL #22
    EXTR  W12, W23, W12, #0x0
    ORN  X24, X7, X21, LSL #21
    UMADDL  X3, W29, W19, X6
    CRC32CH  W8, W5, W2
    ADD  X20, X21, X25, ASR #60
    BICS  X9, X3, X8, LSL #58
    LSRV  X14, X12, X17
    SUB  W10, W14, W4, UXTH #0
    AND  W9, W8, W3, ROR #13
    MOVK  X5, #0x49af, LSL #48
    CSINV  X19, X27, X21, CS
    CSEL  X19, X24, X27, HI
    CLS  X18, X27
    SMADDL  X9, W23, W18, X10
    ADDS  W27, W10, W16, UXTX #2
    ADDS  W21, W12, #0xdba
    ORR  V14.4S, #0x64, LSL #24
    SUBS  X5, X12, #0x606
    UMULH  X19, X19, X10
    CRC32H  W14, W18, W9
    ADC  W20, W28, W19
    CLS  W2, W9
    SBFM  W10, W23, #0x18, #0xb
    SMULH  X13, X21, X2
    MOVK  W8, #0x55a4, LSL #16
    ADDS  X18, X6, #0xa30
    ANDS  X4, X29, #0xffffffff00001fff
    ORR  V19.8H, #0xd5, LSL #8
    MOVK  X19, #0xf145, LSL #0
    ORN  W12, W10, W12, ASR #19
    MOVZ  X4, #0xd9cd, LSL #48
    UMADDL  X14, W14, W27, X19
    UBFM  W20, W17, #0x13, #0x6
    CSEL  W10, W15, W15, VS
    ORR  V17.4S, #0x8f, LSL #8
    SUB  W27, W28, W12, LSR #21
    CSNEG  W14, W16, W10, AL
    BIC  X21, X5, X23, ASR #37
    SUB  W19, W29, W16, UXTH #1
    CSNEG  W27, W22, W8, LE
    ADDS  W13, W9, W26, ASR #2
    SUBS  X15, X10, #0xf77, LSL #12
    ADD  X20, X23, #0x926, LSL #12
    CRC32B  W2, W2, W9
    CRC32CH  W2, W29, W7
    ORR  V8.4H, #0x37
    CLS  X4, X13
    SUB  W6, W9, W12, ASR #24
    ASRV  W19, W6, W28
    ADD  W8, W14, W17, SXTB #0
    ASRV  X7, X25, X14
    LSLV  W7, W9, W25
    AND  W22, W16, #0xfe7ffe7f
    ANDS  X4, X7, X9, LSL #23
    SMSUBL  X25, W27, W14, X5
    BICS  X4, X12, X29, ASR #22
    EOR  X10, X25, #0xf8000001f8000001
    ORR  W9, W20, W23, ASR #25
    ADDS  W4, W10, #0x943, LSL #12
    SUB  X2, X21, X10, LSL #12
    SUB  X10, X8, X7, ASR #14
    UBFM  X7, X3, #0x29, #0x3d
    LSLV  X29, X6, X12
    CRC32CB  W27, W8, W17
    LSRV  X17, X2, X27
    SUB  X26, X24, #0xab5, LSL #12
    ADDS  W7, W27, W6, SXTX #4
    ANDS  W22, W21, W23, ROR #19
    CSNEG  W20, W21, W9, AL
    ANDS  W4, W7, W25, ROR #26
    CLZ  V1.2S, V27.2S
    LSLV  X22, X6, X13
    ADDS  W17, W14, W2, SXTW #0
    ADDS  X25, X10, X19, LSR #34
    ADD  X25, X18, X2, LSL #10
    ADDS  W21, W4, W26, SXTH #0
    ADC  W8, W15, W16
    SUB  W7, W20, #0x87
    SUBS  X15, X7, X26, LSR #54
    CRC32B  W19, W10, W13
    MADD  W9, W19, W4, W8
    ADD  W4, W8, W24, LSL #20
    UMULH  X8, X21, X7
    CRC32CW  W27, W21, W26
    CRC32X  W10, W18, X24
    AND  W27, W4, #0xffe0003f
    CRC32B  W17, W4, W3
    SUB  X2, X28, #0x294
    CLZ  X5, X14
    ADDS  X5, X9, X16, LSL #8
    SMULH  X27, X8, X25
    MOVN  X9, #0x4f6, LSL #48
    EOR  W7, W20, W25, LSR #18
    SMULH  X7, X19, X19
    ADC  X15, X8, X16
    BICS  W22, W13, W10, ROR #18
    ANDS  X20, X14, X3, ASR #28
    CSNEG  W17, W2, W9, LS
    CSEL  W20, W24, W7, LE
    BIC  X22, X3, X23, ASR #37
    AND  W25, W17, W12, ASR #2
    CSEL  X29, X16, X18, VC
    UMADDL  X14, W29, W9, X19
    ADD  X7, X12, X7, ASR #9
    ADC  X29, X8, X18
    SUBS  X25, X26, #0x664, LSL #12
    SMSUBL  X17, W21, W21, X7
    ORN  X20, X8, X14, LSR #52
    ADD  W22, W2, W25, UXTB #3
    UMADDL  X3, W27, W28, X28
    LSRV  X7, X4, X22
    CSNEG  X29, X8, X20, CS
    SUB  X9, X13, #0x38b, LSL #12
    MADD  W14, W24, W8, W20
    CRC32H  W5, W29, W8
    SUB  W18, W17, W5, SXTW #3
    AND  W4, W16, #0xff80ff80
    CSNEG  W3, W24, W15, MI
    ANDS  W12, W2, W19, ASR #22
    SUB  X12, X19, W12, SXTW #1
    ADD  W29, W25, #0x2f7, LSL #12
    ORR  V12.4H, #0xf5, LSL #8
    ASRV  W9, W5, W25
    BIC  V7.16B, V31.16B, V4.16B
    ASRV  W24, W13, W14
    SUBS  X8, X12, W25, SXTW #1
    ADDS  W6, W25, W17, UXTW #0
    MOVK  X22, #0x6db9, LSL #16
    SUBS  X28, X28, #0x1
    B.NE  TaishanIntAluP01_label_84
    MOVZ  X23, #0xfd6d, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X28, X23, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X16, X2, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP01_TestFail
    MOVZ  X21, #0x1000, LSL #0
    MOVK  X21, #0x8100, LSL #16
    SUB  X6, X21, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X7
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP01_TestFail
    MOVZ  X23, #0xd851, LSL #0
    MOVK  X23, #0x2aa6, LSL #16
    SUB  X4, X23, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X6, X29, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
    MOVZ  X16, #0x7cbc, LSL #0
    MOVK  X16, #0x458d, LSL #16
    SUB  X29, X16, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X9, #0xb84f, LSL #0
    MOVK  X9, #0x2883, LSL #16
    SUB  X15, X9, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X8, #0xf7ef, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X28, X8, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X4, #0x7cbc, LSL #0
    MOVK  X4, #0x458d, LSL #16
    SUB  X27, X4, X16
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x38b7, LSL #0
    MOVK  X8, #0x101a, LSL #16
    MOVK  X8, #0xfb92, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X26, X8, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X16, #0x38b7, LSL #0
    MOVK  X16, #0x101a, LSL #16
    SUB  X24, X16, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X14, #0xb88f, LSL #0
    MOVK  X14, #0x2883, LSL #16
    SUB  X20, X14, X19
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP01_TestFail
    MOVZ  X18, #0x1000, LSL #0
    MOVK  X18, #0x8100, LSL #16
    SUB  X16, X18, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X29, #0xd851, LSL #0
    MOVK  X29, #0x2aa6, LSL #16
    SUB  X19, X29, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X3, X14, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP01_TestFail
    MOVZ  X27, #0x6fff, LSL #0
    MOVK  X27, #0xfeee, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X2, X27, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X15, #0x6fff, LSL #0
    MOVK  X15, #0xfeee, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X23, X15, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP01_TestFail
    MOVZ  X9, #0xd851, LSL #0
    MOVK  X9, #0x2aa6, LSL #16
    SUB  X6, X9, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
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
    MOVZ  X23, #0xa, LSL #0
TaishanIntAluP01_label_112:
    ADC  X29, X2, X27
    EOR  X4, X17, #0x1ffffff0000
    SUB  W6, W25, W29, SXTX #2
    ADD  W16, W6, W22, UXTX #4
    ANDS  X21, X23, X2, ASR #45
    ORR  V6.16B, V25.16B, V4.16B
    ADDS  X27, X7, W15, UXTB #1
    MOVK  X28, #0x29d2, LSL #0
    ADD  W4, W26, W19, UXTX #2
    SMADDL  X21, W5, W29, X28
    BICS  W22, W4, W24, LSR #10
    ADCS  W4, W13, W8
    ANDS  W14, W21, W17, ASR #24
    AND  W12, W7, W25, ROR #14
    CRC32CB  W3, W5, W20
    ADC  X14, X20, X4
    ADC  W29, W22, W16
    CRC32X  W5, W4, X6
    ADD  X26, X28, X27, ASR #37
    ORR  W15, W12, W27, LSR #9
    AND  W19, W13, W26, LSR #11
    ORR  V15.16B, V23.16B, V7.16B
    ADCS  W10, W24, W25
    ADDS  X29, X29, X27, LSR #33
    MOVN  X2, #0x8d14, LSL #32
    ADDS  W10, W7, W16, LSL #21
    BIC  V14.16B, V9.16B, V17.16B
    SUB  W21, W9, #0xefd
    UMADDL  X14, W27, W15, X27
    UBFM  W14, W3, #0x1f, #0x9
    ADDS  W13, W4, W25, SXTB #0
    LSLV  W13, W20, W12
    EON  X9, X12, X2, LSL #35
    CSNEG  X14, X6, X21, MI
    ADDS  W14, W2, W10, LSL #9
    ORR  W28, W19, #0x33333333
    SUBS  W6, W29, W13, LSR #18
    CRC32CX  W24, W6, X8
    LSRV  W8, W5, W20
    ANDS  W12, W5, W15, ASR #3
    EON  X10, X28, X16, LSL #52
    CRC32CB  W27, W17, W16
    SMSUBL  X9, W16, W21, X13
    SUBS  X3, X28, #0xdbb, LSL #12
    CRC32CW  W15, W29, W24
    CSEL  X19, X12, X18, CC
    CLZ  X21, X27
    CLS  W27, W29
    LSLV  W19, W29, W4
    SUB  W25, W2, W20, LSL #5
    SUB  X29, X21, X9, LSR #48
    CRC32B  W27, W8, W6
    SUB  W22, W25, W28, LSR #8
    ADD  W8, W20, #0x400
    SUBS  X27, X27, X25, UXTX #3
    ADD  W28, W4, W18, ASR #26
    CRC32CW  W2, W15, W3
    ADD  X4, X21, X21, ASR #19
    ADDS  W12, W8, #0x591, LSL #12
    ANDS  W2, W10, #0xe0007fff
    ADDS  X10, X16, X24, LSL #27
    MADD  X6, X7, X18, X29
    EOR  X3, X4, #0xffe0000fffe0000f
    CSINC  W16, W9, W25, LS
    CRC32H  W13, W4, W15
    ADD  W3, W21, W22, UXTB #4
    ANDS  X26, X29, #0xff807fffff807fff
    SUB  X17, X26, #0x6ed
    CRC32CB  W25, W3, W8
    AND  W26, W20, W27, LSR #20
    SUBS  X10, X22, X13, SXTX #4
    MOVN  X8, #0x86f8, LSL #32
    ORR  X19, X22, #0xffffffff8007ffff
    ORR  W16, W18, W24, LSR #20
    EXTR  X9, X24, X16, #0x33
    SUB  X25, X28, #0x0
    ORR  V1.8H, #0x6b, LSL #8
    ADCS  W14, W3, W12
    BIC  V16.8B, V28.8B, V12.8B
    LSLV  X13, X18, X18
    ORN  X24, X18, X14, LSR #16
    BIC  W20, W12, W6, LSL #19
    CLS  X15, X14
    ORR  V12.2S, #0x74, LSL #16
    UBFM  X13, X8, #0x17, #0xc
    EOR  W5, W25, #0xc0c0c0c
    SUB  W26, W10, #0xd0
    UMULH  X25, X14, X15
    SUBS  W17, W22, W22, ASR #23
    LSRV  X14, X19, X7
    CSEL  X3, X18, X9, NE
    MADD  W10, W9, W16, W24
    SUBS  W16, W25, W26, UXTW #4
    EXTR  X12, X8, X20, #0x31
    CSINV  W3, W12, W20, VC
    ADD  W9, W28, W8, LSL #26
    ORR  V21.2S, #0xa, LSL #24
    ADC  X27, X20, X24
    LSLV  W27, W27, W22
    BICS  W5, W7, W9, LSL #29
    ASRV  W26, W20, W21
    SBFM  W8, W5, #0x17, #0x17
    ORR  X10, X13, X18, ASR #31
    CLS  W24, W8
    MADD  X7, X25, X16, X6
    CLS  V11.4H, V25.4H
    SMULH  X29, X5, X7
    ORR  X5, X27, #0xffffe0000000000
    UBFM  X2, X3, #0x1d, #0x3
    ADC  W8, W28, W16
    ADD  W28, W28, W4, UXTW #2
    MOVZ  X4, #0xb75c, LSL #0
    LSLV  X29, X13, X24
    ASRV  W17, W7, W15
    ADDS  X25, X9, #0xedf
    SUB  W12, W3, #0x498, LSL #12
    SUBS  W7, W26, #0xba
    EOR  W6, W10, W17, ASR #31
    SMADDL  X20, W28, W29, X25
    ANDS  W13, W18, #0xffff801f
    CRC32CX  W14, W19, X19
    SUB  W5, W12, W15, UXTW #3
    ANDS  W20, W23, W20, LSR #8
    ORN  X25, X2, X16, ASR #37
    BIC  V20.16B, V20.16B, V4.16B
    CLS  W13, W25
    MOVN  W16, #0x1e4, LSL #0
    CRC32CH  W15, W23, W24
    ANDS  W22, W13, W4, LSR #20
    CRC32H  W4, W8, W14
    ORR  X2, X27, #0x8181818181818181
    CRC32H  W4, W27, W8
    BIC  V31.8B, V6.8B, V14.8B
    BIC  X15, X10, X3, ROR #60
    ADDS  W8, W15, W24, LSR #23
    MOVK  X17, #0x3a17, LSL #16
    UBFM  W17, W16, #0x18, #0xe
    ORR  X29, X28, #0x7f007f007f007f
    SUBS  X24, X4, X15, ASR #63
    AND  W14, W16, #0x1fff1fff
    SUB  X29, X18, X2, ASR #7
    ADD  X19, X8, X7, ASR #6
    CSINV  W28, W25, W15, PL
    ADCS  X19, X17, X26
    CSINV  W15, W22, W27, LT
    MOVZ  W10, #0x5a08, LSL #16
    ORN  X27, X8, X28, LSL #2
    SUB  W8, W29, W5, SXTH #1
    ADD  X22, X20, #0xca0
    CSNEG  W18, W27, W18, HI
    ADDS  W8, W7, #0x972, LSL #12
    SMADDL  X7, W26, W22, X2
    ORR  V10.4H, #0x15, LSL #8
    LSRV  W21, W16, W15
    ADC  X27, X7, X27
    SUB  W22, W21, #0x890
    ORR  X3, X13, X28, ROR #19
    CSNEG  X17, X5, X22, MI
    ADDS  X12, X24, X28, LSL #17
    CLS  V19.16B, V5.16B
    CRC32X  W14, W10, X19
    SUBS  W13, W16, W16, UXTX #0
    EON  X24, X12, X20, ASR #61
    ORR  X13, X16, #0xfe07fe07fe07fe07
    SBFM  W18, W20, #0x6, #0xe
    ORR  V1.16B, V25.16B, V25.16B
    BIC  W29, W17, W18, ROR #28
    ANDS  W24, W3, W23, ROR #26
    MOVN  X12, #0x5c2c, LSL #0
    ORN  W16, W10, W27, LSR #1
    CSINC  X10, X3, X27, AL
    EOR  X26, X28, #0xcccccccccccccccc
    ADD  W8, W26, W23, ASR #3
    ORR  V21.2S, #0x52, LSL #16
    ANDS  W18, W4, #0xff00ff00
    ADCS  X14, X5, X5
    EOR  W8, W15, W24, ROR #8
    MOVK  X21, #0xa57b, LSL #32
    ORN  X19, X18, X9, ASR #5
    BICS  W2, W24, W2, ROR #18
    LSLV  X7, X21, X17
    ADDS  W27, W23, W17, ASR #10
    MOVK  W29, #0xab22, LSL #16
    MOVK  X26, #0x3b77, LSL #48
    ADDS  W17, W27, W24, SXTX #4
    ADDS  X3, X23, #0x364, LSL #12
    ADC  W9, W28, W8
    MOVK  X22, #0x9e1f, LSL #32
    ADDS  W12, W24, #0xf88
    SMADDL  X24, W20, W6, X4
    ADD  W20, W24, W24, LSL #16
    BICS  W12, W2, W24, LSR #4
    SBFM  X19, X18, #0x5, #0x1b
    CSINC  W4, W28, W27, CC
    ADD  W14, W4, W6, LSR #7
    ADC  X20, X27, X20
    ASRV  W19, W24, W21
    MADD  W5, W29, W29, W2
    ORR  W4, W19, #0xbbbbbbbb
    SUB  X2, X14, W26, UXTB #4
    SUBS  X23, X23, #0x1
    B.NE  TaishanIntAluP01_label_112
    MOVZ  X20, #0xfccf, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X15, X20, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X28, #0x4001, LSL #0
    MOVK  X28, #0x36, LSL #16
    SUB  X7, X28, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP01_TestFail
    MOVZ  X16, #0xfbff, LSL #0
    MOVK  X16, #0xfffb, LSL #16
    SUB  X25, X16, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X16, #0xf040, LSL #0
    MOVK  X16, #0x6c30, LSL #16
    SUB  X21, X16, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X7
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x3fff, LSL #0
    MOVK  X8, #0x6e21, LSL #16
    SUB  X23, X8, X8
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X14, #0x3ffe, LSL #0
    MOVK  X14, #0x6e21, LSL #16
    SUB  X29, X14, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X15, #0x1fff, LSL #0
    MOVK  X15, #0xe000, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X6, X15, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X15, X6, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X16, #0xfe1f, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xfe07, LSL #32
    MOVK  X16, #0xfe07, LSL #48
    SUB  X23, X16, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X7, #0x3ffe, LSL #0
    MOVK  X7, #0x6e21, LSL #16
    SUB  X21, X7, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP01_TestFail
    MOVZ  X17, #0xfe1f, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xfe07, LSL #32
    MOVK  X17, #0xfe07, LSL #48
    SUB  X20, X17, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP01_TestFail
    MOVZ  X12, #0xfe1f, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xfe07, LSL #32
    MOVK  X12, #0xfe07, LSL #48
    SUB  X13, X12, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X6, #0xc000, LSL #0
    MOVK  X6, #0xcc00, LSL #16
    SUB  X19, X6, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X13, X22, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X20
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X26, X23, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X26
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X9, #0xed80, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X28, X9, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
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
    MOVZ  X6, #0x14, LSL #0
TaishanIntAluP01_label_139:
    UMULH  X28, X15, X19
    ADC  W24, W5, W27
    AND  X28, X19, #0xffffffc00007ffff
    UMULH  X7, X25, X5
    ORR  V27.4S, #0x38, LSL #24
    CSINC  X28, X5, X26, HI
    BICS  X23, X15, X24, LSL #53
    LSRV  W24, W7, W19
    ANDS  W21, W23, W2, ASR #25
    CSNEG  X29, X10, X24, LT
    ADDS  W28, W2, #0xbcf
    ORR  X21, X7, #0xffff8003ffff8003
    LSRV  X3, X12, X4
    ANDS  X8, X5, #0xffc1ffc1ffc1ffc1
    CRC32X  W29, W28, X29
    CSINV  W19, W27, W18, LE
    CSNEG  X8, X8, X12, CC
    SUBS  W5, W19, W19, LSR #12
    UMSUBL  X27, W18, W29, X7
    ORR  V2.8B, V29.8B, V24.8B
    CLZ  V3.2S, V5.2S
    ANDS  W7, W21, W8, ASR #13
    ORR  W26, W12, W28, LSL #12
    SMADDL  X3, W29, W7, X8
    CLZ  W22, W20
    CLS  V8.4H, V17.4H
    SUBS  X5, X3, X7, LSR #60
    ORR  V27.8H, #0xdc, LSL #8
    ORR  X24, X8, X24, LSR #6
    SUBS  X17, X26, W22, UXTW #0
    CRC32CB  W19, W25, W27
    ORR  X4, X18, #0xfe000000fe0000
    CLZ  V22.16B, V6.16B
    SUB  W25, W29, W24, UXTW #3
    UMSUBL  X5, W23, W5, X28
    SBFM  W17, W19, #0x1f, #0x7
    ADD  W15, W7, W21, SXTW #3
    ANDS  W18, W6, W10, ASR #2
    ORN  X14, X3, X29, ROR #60
    CRC32CH  W29, W23, W27
    ORR  X3, X12, #0xff000000ff00000
    EOR  W17, W26, W2, LSR #9
    SUB  W3, W26, #0x4c0
    ADDS  X16, X27, W5, UXTB #0
    SUB  X25, X17, #0xa3a
    ORR  X2, X25, #0x3000300030003000
    SBFM  W2, W3, #0x11, #0x0
    CSEL  X20, X7, X24, PL
    CLS  W18, W12
    CLS  V8.4S, V19.4S
    ANDS  X21, X10, X13, ASR #3
    CSINC  X3, X19, X9, LS
    ANDS  W21, W19, W2, ROR #0
    BIC  V21.16B, V1.16B, V23.16B
    EXTR  X19, X27, X6, #0x28
    SUBS  X20, X25, #0x5a0
    ADD  X10, X18, #0x8ac, LSL #12
    SUB  X10, X9, W25, UXTB #0
    SUB  X7, X17, #0x6ad, LSL #12
    LSLV  X16, X13, X13
    CSINC  W2, W9, W3, HI
    SUB  W3, W8, W8, SXTW #4
    ANDS  W16, W13, #0x10
    EON  X7, X16, X5, LSR #12
    MOVZ  W26, #0x8ab9, LSL #0
    BICS  X10, X29, X26, LSL #43
    SUBS  W21, W15, W15, SXTW #2
    UMADDL  X17, W27, W3, X9
    ADCS  W20, W6, W22
    CSINV  W15, W19, W4, PL
    CRC32W  W4, W9, W9
    SMULH  X22, X29, X12
    ANDS  W18, W21, #0x1c001c00
    CRC32CX  W2, W5, X16
    SMADDL  X25, W13, W16, X20
    CSINV  W21, W26, W24, PL
    CLS  W5, W13
    ADCS  X14, X22, X28
    ORR  V11.2S, #0x5e, LSL #24
    CSNEG  W19, W28, W10, PL
    AND  W20, W23, W19, LSL #26
    SBFM  W19, W3, #0x9, #0xf
    SUBS  X8, X17, #0x488
    BIC  W16, W2, W7, LSL #12
    ORR  V15.16B, V28.16B, V11.16B
    SUB  X24, X17, X10, LSL #27
    UMADDL  X8, W8, W13, X12
    ORR  V26.8H, #0xa0
    SUBS  W5, W21, #0x321, LSL #12
    SUB  X17, X19, W3, UXTB #3
    ORN  X13, X25, X22, ROR #56
    SUBS  X24, X26, X2, LSL #21
    ADD  X2, X27, X15, LSR #3
    EOR  W4, W19, W12, LSR #1
    ADCS  W14, W17, W20
    CSNEG  X24, X25, X6, HI
    ANDS  W19, W21, W25, ASR #3
    CLZ  X22, X29
    SMADDL  X8, W16, W17, X19
    SUBS  X19, X2, X13, ASR #1
    ANDS  X12, X8, X5, LSL #57
    UMADDL  X13, W9, W13, X19
    ORR  V9.16B, V17.16B, V15.16B
    CLZ  X23, X19
    ORR  V11.16B, V16.16B, V12.16B
    ASRV  W9, W4, W27
    CSNEG  X21, X27, X28, AL
    BIC  W25, W9, W12, LSL #10
    ORR  X9, X19, X25, LSL #58
    EXTR  W4, W22, W19, #0xf
    LSLV  X25, X22, X18
    LSRV  X22, X5, X7
    ANDS  W15, W21, W18, LSL #6
    ADD  X16, X17, X4, LSR #9
    BIC  X16, X5, X27, ASR #11
    CSEL  W21, W15, W10, GE
    MOVK  W12, #0x3702, LSL #16
    CRC32B  W12, W10, W3
    CSEL  X13, X28, X26, CS
    ORR  V12.2S, #0x84
    ADD  X25, X19, #0x97d
    CSINC  X22, X14, X13, GE
    CRC32CX  W9, W4, X21
    MOVN  W9, #0x3254, LSL #16
    CSINC  X13, X22, X23, LT
    CRC32CW  W17, W10, W16
    CLZ  W12, W25
    AND  X17, X12, X18, LSL #32
    SUB  X14, X6, #0xeb8, LSL #12
    ADC  W26, W7, W5
    ORR  X2, X13, X9, ROR #1
    SUBS  X27, X14, W9, UXTB #3
    SUB  X23, X8, W16, SXTB #1
    MOVZ  X28, #0x3374, LSL #0
    ADD  W27, W6, W26, SXTH #1
    MOVZ  X21, #0x6eaa, LSL #32
    ADD  X22, X27, W24, SXTH #1
    ORR  V4.8H, #0x20, LSL #8
    ADD  X25, X17, X27, UXTX #0
    EOR  W25, W2, W9, LSR #12
    CSNEG  X13, X29, X23, NV
    ANDS  W13, W9, W18
    CLZ  W13, W24
    EON  W16, W12, W29, LSR #31
    MOVZ  W17, #0xbc46, LSL #0
    MOVK  W22, #0x1e89, LSL #16
    CLS  X23, X27
    CRC32CH  W26, W21, W2
    CRC32CX  W17, W3, X23
    CLZ  W27, W28
    ADCS  W18, W27, W22
    ADDS  X23, X8, W5, UXTB #3
    SUBS  W23, W2, W21, SXTX #4
    CLS  W25, W12
    CLZ  W23, W12
    SUBS  X28, X3, W22, UXTW #2
    ANDS  X29, X18, X29, ASR #36
    ORN  X28, X18, X16, ASR #41
    CSEL  W7, W28, W29, VC
    SUB  X24, X17, X19, LSR #4
    MOVZ  X8, #0x6b75, LSL #0
    AND  X14, X6, X5, ASR #38
    BIC  V5.8B, V7.8B, V16.8B
    BICS  X27, X8, X13, LSR #25
    ADDS  W23, W14, W29, LSL #28
    ANDS  X26, X26, #0xfff80000
    ADD  W16, W26, #0xb69, LSL #12
    ORR  V9.16B, V0.16B, V31.16B
    CRC32CH  W25, W29, W7
    UBFM  X16, X28, #0x35, #0x16
    SUBS  X24, X24, X5, UXTX #2
    SUBS  X27, X25, W6, UXTW #3
    ADC  W29, W2, W13
    ORR  W5, W8, #0x22222222
    MOVZ  X29, #0x9aa4, LSL #0
    CSEL  X28, X7, X21, PL
    AND  X25, X10, #0xffffc0000000001f
    CRC32CH  W7, W5, W19
    CSNEG  W27, W27, W6, HI
    UMSUBL  X9, W6, W8, X6
    SMSUBL  X29, W25, W2, X6
    ORR  X5, X3, #0x8000000000000007
    EXTR  W28, W25, W12, #0x10
    ASRV  X26, X16, X20
    ORR  X26, X13, #0xffe0007fffe0007f
    SUBS  X29, X22, #0xc88
    BIC  X2, X24, X12, LSL #25
    ORR  X15, X7, #0xf8000003f8000003
    MOVK  W29, #0xe99c, LSL #16
    CRC32H  W5, W14, W13
    UBFM  X5, X19, #0x15, #0x18
    ANDS  W23, W4, #0xffe3ffff
    ADDS  W2, W16, W7, LSR #13
    ANDS  X12, X27, #0xf8000000f8000
    ADCS  X8, X24, X5
    SMULH  X29, X9, X12
    ADC  W3, W24, W19
    CRC32CX  W24, W24, X19
    UMSUBL  X26, W19, W27, X24
    CSINV  X8, X29, X15, AL
    SUBS  X6, X6, #0x1
    B.NE  TaishanIntAluP01_label_139
    MOVZ  X4, #0x90ec, LSL #0
    SUB  X13, X4, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x67db, LSL #0
    MOVK  X6, #0x698, LSL #16
    SUB  X10, X6, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X5, #0x90ec, LSL #0
    SUB  X18, X5, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP01_TestFail
    MOVZ  X21, #0x90ec, LSL #0
    SUB  X9, X21, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X28, #0x67db, LSL #0
    MOVK  X28, #0x698, LSL #16
    SUB  X26, X28, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X18, #0x9219, LSL #0
    MOVK  X18, #0x131d, LSL #16
    SUB  X22, X18, X7
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X19, X10, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X4, X20, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X6, X23, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X26, #0xf800, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0x3, LSL #32
    SUB  X25, X26, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x9219, LSL #0
    MOVK  X6, #0x131d, LSL #16
    SUB  X5, X6, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x90ec, LSL #0
    SUB  X27, X20, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X22
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
    MOVZ  X24, #0xa71d, LSL #0
    MOVK  X24, #0xfc42, LSL #16
    SUB  X22, X24, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X24, #0xf800, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0x3, LSL #32
    SUB  X10, X24, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X29, #0x67db, LSL #0
    MOVK  X29, #0x698, LSL #16
    SUB  X19, X29, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X14, #0x67db, LSL #0
    MOVK  X14, #0x698, LSL #16
    SUB  X20, X14, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x9cbe, LSL #0
    MOVK  X2, #0x3cfb, LSL #16
    MOVK  X2, #0x6d52, LSL #32
    MOVK  X2, #0x5d9f, LSL #48
    MOVZ  X3, #0x5e87, LSL #0
    MOVK  X3, #0xc8a0, LSL #16
    MOVK  X3, #0x7319, LSL #32
    MOVK  X3, #0xaba9, LSL #48
    MOVZ  X4, #0x3d8e, LSL #0
    MOVK  X4, #0xf651, LSL #16
    MOVK  X4, #0x20e2, LSL #32
    MOVK  X4, #0x5b24, LSL #48
    MOVZ  X5, #0x5a8b, LSL #0
    MOVK  X5, #0x811a, LSL #16
    MOVK  X5, #0xdf41, LSL #32
    MOVK  X5, #0xdcc8, LSL #48
    MOVZ  X6, #0x6b53, LSL #0
    MOVK  X6, #0x6e8b, LSL #16
    MOVK  X6, #0xce80, LSL #32
    MOVK  X6, #0x6860, LSL #48
    MOVZ  X7, #0x7841, LSL #0
    MOVK  X7, #0xa6e9, LSL #16
    MOVK  X7, #0xcb21, LSL #32
    MOVK  X7, #0xb8a6, LSL #48
    MOVZ  X8, #0xd886, LSL #0
    MOVK  X8, #0x66b1, LSL #16
    MOVK  X8, #0xe683, LSL #32
    MOVK  X8, #0x4b9e, LSL #48
    MOVZ  X9, #0xa60f, LSL #0
    MOVK  X9, #0x23a4, LSL #16
    MOVK  X9, #0xe295, LSL #32
    MOVK  X9, #0x63b, LSL #48
    MOVZ  X10, #0x2880, LSL #0
    MOVK  X10, #0xa93d, LSL #16
    MOVK  X10, #0x8490, LSL #32
    MOVK  X10, #0x7289, LSL #48
    MOVZ  X12, #0xd1e0, LSL #0
    MOVK  X12, #0xd10c, LSL #16
    MOVK  X12, #0x9458, LSL #32
    MOVK  X12, #0xe1b0, LSL #48
    MOVZ  X13, #0x81f8, LSL #0
    MOVK  X13, #0x1819, LSL #16
    MOVK  X13, #0x5cfa, LSL #32
    MOVK  X13, #0x66d3, LSL #48
    MOVZ  X14, #0x3d93, LSL #0
    MOVK  X14, #0x2871, LSL #16
    MOVK  X14, #0xd5ef, LSL #32
    MOVK  X14, #0x5054, LSL #48
    MOVZ  X15, #0x39be, LSL #0
    MOVK  X15, #0xfde4, LSL #16
    MOVK  X15, #0x8d36, LSL #32
    MOVK  X15, #0x480a, LSL #48
    MOVZ  X16, #0xcef2, LSL #0
    MOVK  X16, #0xff3c, LSL #16
    MOVK  X16, #0x7fea, LSL #32
    MOVK  X16, #0x377e, LSL #48
    MOVZ  X17, #0xbab6, LSL #0
    MOVK  X17, #0x8ca2, LSL #16
    MOVK  X17, #0x6618, LSL #32
    MOVK  X17, #0xdb29, LSL #48
    MOVZ  X18, #0x6d3b, LSL #0
    MOVK  X18, #0x51e4, LSL #16
    MOVK  X18, #0xc67d, LSL #32
    MOVK  X18, #0x6c23, LSL #48
    MOVZ  X19, #0x2c06, LSL #0
    MOVK  X19, #0xfcc1, LSL #16
    MOVK  X19, #0xedf4, LSL #32
    MOVK  X19, #0x948f, LSL #48
    MOVZ  X20, #0x2e84, LSL #0
    MOVK  X20, #0xe574, LSL #16
    MOVK  X20, #0xc2ec, LSL #32
    MOVK  X20, #0xe7de, LSL #48
    MOVZ  X21, #0x823, LSL #0
    MOVK  X21, #0x96d7, LSL #16
    MOVK  X21, #0x4277, LSL #32
    MOVK  X21, #0xc82b, LSL #48
    MOVZ  X22, #0xb293, LSL #0
    MOVK  X22, #0xb3ff, LSL #16
    MOVK  X22, #0xa392, LSL #32
    MOVK  X22, #0x6504, LSL #48
    MOVZ  X23, #0xa475, LSL #0
    MOVK  X23, #0x343c, LSL #16
    MOVK  X23, #0x69c4, LSL #32
    MOVK  X23, #0x9870, LSL #48
    MOVZ  X24, #0x61a8, LSL #0
    MOVK  X24, #0xc96b, LSL #16
    MOVK  X24, #0x20e7, LSL #32
    MOVK  X24, #0x55b8, LSL #48
    MOVZ  X25, #0xeea0, LSL #0
    MOVK  X25, #0x9536, LSL #16
    MOVK  X25, #0x454a, LSL #32
    MOVK  X25, #0x1b0d, LSL #48
    MOVZ  X26, #0x9ed8, LSL #0
    MOVK  X26, #0x9f35, LSL #16
    MOVK  X26, #0x3aa9, LSL #32
    MOVK  X26, #0x5534, LSL #48
    MOVZ  X27, #0x32e9, LSL #0
    MOVK  X27, #0x57e6, LSL #16
    MOVK  X27, #0xaa88, LSL #32
    MOVK  X27, #0x1790, LSL #48
    MOVZ  X28, #0xf9b0, LSL #0
    MOVK  X28, #0x4417, LSL #16
    MOVK  X28, #0xa7e, LSL #32
    MOVK  X28, #0x788e, LSL #48
    MOVZ  X29, #0xab5c, LSL #0
    MOVK  X29, #0xed3, LSL #16
    MOVK  X29, #0xea4a, LSL #32
    MOVK  X29, #0xae4f, LSL #48
    MOVZ  X15, #0xa, LSL #0
TaishanIntAluP01_label_164:
    ORR  W7, W17, W29, ASR #31
    ADCS  W8, W10, W25
    CRC32CX  W6, W24, X8
    UMULH  X26, X25, X13
    ADC  X27, X4, X18
    UMSUBL  X4, W15, W27, X27
    SBFM  X14, X8, #0x3f, #0x18
    SMADDL  X26, W4, W21, X14
    AND  X12, X3, #0xe1e1e1e1e1e1e1e1
    ORR  V22.16B, V18.16B, V25.16B
    SUB  X7, X17, #0x833
    CRC32CH  W19, W12, W15
    AND  W8, W9, #0xe000003f
    SMADDL  X9, W6, W24, X7
    SMSUBL  X20, W28, W12, X16
    SUBS  X10, X4, #0x86d
    ORR  X9, X29, #0xfffff000000003ff
    ADCS  X22, X10, X29
    EOR  W10, W26, W25, LSL #22
    EOR  X8, X26, X21, LSL #53
    BIC  V1.8B, V27.8B, V8.8B
    CRC32CW  W26, W21, W19
    CSINV  X26, X23, X16, LS
    ADD  W27, W14, W17, LSR #11
    SBFM  W12, W13, #0xc, #0x1e
    UBFM  W22, W27, #0x18, #0xc
    ORN  W18, W26, W27, ASR #13
    AND  X16, X10, #0xffcfffffffcfffff
    CLZ  V16.4H, V17.4H
    ANDS  X24, X7, #0xff00000fff00000f
    ORR  X24, X15, #0x8000000000007fff
    BIC  X12, X4, X19, LSL #34
    EOR  X14, X20, X12, ASR #44
    EOR  X26, X18, #0xffff00003fffffff
    EOR  X19, X4, #0xffff8000001fffff
    CLZ  W2, W28
    CRC32X  W4, W24, X7
    ADD  X16, X28, X24, LSL #38
    ADD  X12, X19, W6, UXTB #3
    ANDS  X17, X2, X4, ASR #56
    ANDS  X29, X21, #0x1f001f001f001f
    ADD  X23, X12, X27, LSR #18
    SUB  W6, W4, W14, SXTW #3
    SUB  X7, X23, W23, UXTW #1
    EOR  X20, X14, #0x6000000000000000
    AND  X29, X22, #0x1c0000001c000000
    AND  W5, W26, W8, LSR #29
    ADDS  W10, W16, #0x6ee
    CRC32B  W18, W10, W16
    EON  X23, X20, X13, LSR #7
    LSRV  W16, W18, W15
    ANDS  X27, X24, #0xffc00000000
    SUB  W19, W19, W20, SXTX #2
    ADDS  X5, X26, W5, UXTH #3
    UMULH  X28, X5, X13
    SUB  X3, X13, #0xe1f, LSL #12
    SUB  X2, X14, #0xe1a
    EOR  X28, X9, #0x6000000060
    CRC32CH  W10, W22, W14
    ORR  X20, X9, X19, ROR #39
    SUBS  W16, W10, W18, LSL #12
    SUB  X29, X23, W27, SXTB #4
    UBFM  X2, X2, #0x11, #0x8
    ANDS  X6, X9, X5, LSR #12
    CRC32CW  W16, W23, W29
    AND  X28, X13, #0xfcfcfcfcfcfcfcfc
    ORR  V27.16B, V11.16B, V9.16B
    EOR  X10, X4, X10, LSL #20
    ORR  W18, W18, W10, ASR #24
    LSRV  X24, X26, X28
    MOVK  X7, #0xd5f2, LSL #0
    ADC  W14, W5, W20
    LSLV  W16, W6, W23
    CRC32CW  W27, W8, W4
    SUB  X3, X20, W18, UXTW #3
    SMSUBL  X23, W26, W3, X19
    SUBS  W20, W10, #0x2ec, LSL #12
    ORN  X25, X2, X10, ASR #8
    SUB  W2, W6, #0x5
    ASRV  X26, X22, X28
    CSEL  X23, X10, X20, VC
    ORR  W8, W23, #0x7fe07fe
    ORR  W7, W21, W14, LSR #19
    SUB  W28, W6, W5, UXTW #0
    CRC32H  W3, W2, W28
    BICS  W8, W3, W12, ASR #10
    ADC  W12, W14, W4
    EXTR  W5, W21, W25, #0x1b
    ORR  X25, X28, #0x1ff01ff01ff01ff
    SUBS  W29, W27, #0xb99
    SBFM  X9, X10, #0x1b, #0x27
    MOVK  X5, #0x9799, LSL #32
    ORR  W27, W5, W8, LSL #1
    MOVN  X21, #0xf6d3, LSL #0
    SUB  W20, W20, #0xe0, LSL #12
    MOVK  X17, #0x777e, LSL #0
    EON  W9, W10, W13, ASR #28
    ADDS  X19, X16, W26, UXTW #3
    MADD  X28, X24, X3, X13
    ANDS  X21, X23, #0x8000800080008000
    ADD  W20, W15, #0xac2
    ADDS  W28, W21, #0x299
    ADCS  X4, X9, X8
    MOVZ  W27, #0x6603, LSL #16
    ADD  X8, X7, X22, LSL #28
    MADD  W10, W13, W23, W17
    CLZ  W14, W20
    ADDS  W21, W8, W24, SXTW #1
    ORR  X12, X9, #0xffffffe0007fffff
    ASRV  X21, X4, X12
    ADD  W21, W15, #0x913, LSL #12
    ANDS  X16, X4, #0xc00fffffc00fffff
    EXTR  X8, X3, X15, #0x5
    SUB  X24, X8, #0xd84
    ADC  X12, X5, X21
    ORR  W22, W25, #0x77777777
    CSNEG  X21, X24, X16, EQ
    EOR  X2, X10, X16, LSL #63
    ADD  W12, W28, #0xad2, LSL #12
    CRC32CH  W14, W19, W5
    BICS  X3, X7, X26, LSR #29
    EXTR  W28, W19, W7, #0x3
    LSRV  W25, W14, W25
    SBFM  X29, X23, #0x14, #0x3a
    EOR  W2, W10, W23, LSL #15
    UBFM  W13, W6, #0xc, #0xb
    ADDS  W22, W3, W17, LSR #23
    ADDS  X9, X17, #0xd60, LSL #12
    MOVN  W28, #0x1587, LSL #16
    SUB  W9, W3, #0x960
    MOVN  W27, #0xd3c8, LSL #16
    ANDS  W13, W25, W17, LSL #10
    ADDS  W5, W25, W25, LSR #19
    LSLV  X22, X10, X8
    CRC32CH  W27, W6, W23
    SMULH  X22, X16, X25
    MADD  W27, W21, W2, W16
    ADDS  W19, W24, #0x5dd
    ORR  X20, X4, X9, ROR #31
    CLS  V24.4S, V15.4S
    SUBS  W2, W25, #0xb7, LSL #12
    BICS  X3, X4, X25, LSR #9
    CLS  X29, X26
    CSEL  W3, W19, W28, CC
    UBFM  X13, X2, #0x39, #0x34
    UMSUBL  X16, W24, W17, X17
    BICS  W6, W29, W19, ASR #28
    ORR  W12, W2, #0xc01fffff
    ORR  X21, X13, #0xfffc0000fffc00
    SUBS  X25, X21, X3, LSL #45
    EON  W19, W12, W14, LSL #11
    ADCS  X22, X24, X16
    ORR  W28, W19, W5, LSL #30
    MOVZ  W4, #0xdd95, LSL #0
    EON  W9, W28, W29, LSR #19
    ANDS  W14, W20, W24, LSR #7
    SBFM  W22, W29, #0x1d, #0x7
    CLZ  X16, X5
    CSINC  X20, X2, X19, PL
    CLS  X13, X9
    EOR  X19, X13, #0x3fffffffffff800
    SBFM  W13, W19, #0xc, #0x16
    LSLV  X27, X12, X16
    ORN  W8, W3, W18, LSR #24
    SUBS  W28, W28, W25, LSR #29
    SUBS  W9, W12, W13, ASR #6
    ANDS  X6, X24, X2, LSL #49
    SMADDL  X20, W9, W28, X7
    MOVK  X14, #0x5165, LSL #0
    CSINV  W14, W25, W21, MI
    BIC  V21.16B, V6.16B, V4.16B
    EOR  X3, X3, #0x8080808080808080
    BICS  X4, X5, X22, LSL #63
    CLS  W3, W10
    ADD  X28, X5, X24, LSR #47
    CLS  X24, X13
    MOVK  X3, #0x7cb3, LSL #16
    CRC32CH  W8, W2, W4
    ORN  X19, X8, X21, LSR #33
    BICS  W2, W4, W5, LSL #21
    BICS  X27, X19, X28, LSL #35
    UBFM  X8, X25, #0x3, #0xc
    CSINC  W24, W12, W22, LS
    ADC  X27, X22, X25
    ANDS  W16, W12, #0xf87fffff
    ANDS  W27, W29, #0x7800780
    ADDS  W20, W2, W14, SXTB #1
    EOR  W14, W28, W3, LSR #13
    SUBS  X25, X25, X9, LSL #27
    ANDS  W28, W8, W8, ROR #3
    SUBS  X29, X24, X24, ASR #59
    BIC  X4, X19, X10, LSR #47
    ORR  V18.16B, V27.16B, V4.16B
    SMADDL  X2, W29, W7, X22
    SUB  X10, X12, X4, ASR #62
    ADDS  X3, X13, W14, UXTH #2
    EOR  W8, W13, #0x1fff0
    ADDS  X25, X15, #0x895
    ORR  V16.4S, #0xd3, LSL #16
    ADDS  X19, X15, X18, ASR #9
    SUBS  X15, X15, #0x1
    B.NE  TaishanIntAluP01_label_164
    MOVZ  X17, #0x1f9, LSL #0
    MOVK  X17, #0x500, LSL #16
    SUB  X9, X17, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x965f, LSL #0
    MOVK  X6, #0x3, LSL #16
    MOVK  X6, #0x1, LSL #32
    SUB  X15, X6, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X21, #0x3e3, LSL #0
    MOVK  X21, #0xffa8, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X23, X21, X4
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X26, #0x1, LSL #0
    SUB  X14, X26, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP01_TestFail
    MOVZ  X13, #0x965f, LSL #0
    MOVK  X13, #0x3, LSL #16
    MOVK  X13, #0x1, LSL #32
    SUB  X4, X13, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xfaff, LSL #16
    SUB  X28, X24, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP01_TestFail
    MOVZ  X14, #0xf, LSL #0
    MOVK  X14, #0xfffe, LSL #16
    SUB  X26, X14, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x1, LSL #32
    SUB  X10, X13, X10
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X16, X3, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x1, LSL #32
    SUB  X29, X8, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X24, #0xf, LSL #0
    MOVK  X24, #0xfffe, LSL #16
    SUB  X27, X24, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X5, X16, X15
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X3, #0x1f9, LSL #0
    MOVK  X3, #0x500, LSL #16
    SUB  X25, X3, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X23, #0xcf79, LSL #0
    MOVK  X23, #0x47b2, LSL #16
    SUB  X25, X23, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X20, #0xff, LSL #0
    SUB  X8, X20, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X14, #0x1f8, LSL #0
    SUB  X21, X14, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X17, #0xcf79, LSL #0
    MOVK  X17, #0x47b2, LSL #16
    SUB  X15, X17, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X12, #0xf, LSL #0
    MOVK  X12, #0xfffe, LSL #16
    SUB  X15, X12, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X24, X8, X26
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X24, X8, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
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
    MOVZ  X17, #0xa, LSL #0
TaishanIntAluP01_label_190:
    SUBS  W4, W22, W27, LSL #26
    ORR  X3, X17, X27, ROR #57
    ADDS  W26, W21, #0x198, LSL #12
    ORR  X27, X19, #0xfffc00000000000f
    EON  X28, X28, X14, ROR #2
    ORN  W25, W8, W24, ASR #31
    EOR  W21, W9, #0xe00fe00f
    CRC32W  W19, W21, W24
    LSLV  X10, X13, X16
    CLS  W18, W8
    ANDS  W9, W26, W8, ROR #7
    CSNEG  X18, X16, X24, NV
    ORR  V14.8H, #0x53
    BICS  W7, W15, W15, ASR #28
    MOVK  W16, #0x2b4d, LSL #16
    MOVN  X7, #0xb5a6, LSL #16
    CSINV  W20, W8, W21, NV
    CLZ  X7, X25
    SUBS  W14, W23, #0x94b, LSL #12
    CRC32X  W4, W4, X18
    SBFM  W13, W21, #0x12, #0x8
    SMSUBL  X16, W22, W26, X25
    ORN  X9, X20, X27, LSR #24
    CLS  X23, X10
    MADD  X24, X9, X16, X13
    ORN  X23, X5, X14, LSL #35
    LSRV  X23, X24, X26
    ADCS  W15, W29, W14
    ORR  W28, W16, W25, LSR #27
    CSINC  X9, X6, X23, VS
    MOVZ  X24, #0x69d3, LSL #48
    SUBS  X28, X25, X2, LSL #27
    CLS  V6.4H, V24.4H
    UMULH  X23, X29, X10
    ADD  W16, W22, W5, UXTH #2
    ASRV  W29, W25, W29
    CRC32W  W5, W25, W15
    ASRV  X12, X8, X25
    LSRV  X18, X7, X8
    ADC  X18, X6, X15
    ORR  V5.2S, #0xcd
    SUBS  W6, W17, #0xf5d, LSL #12
    LSLV  X25, X10, X20
    ADCS  X13, X7, X23
    ORR  X4, X17, #0xc000ffffffffffff
    ORR  X3, X7, X26, LSL #50
    ADCS  X10, X9, X26
    CLZ  V17.8B, V17.8B
    ADC  W9, W18, W24
    CSNEG  X19, X10, X25, CS
    EON  W13, W27, W24, ROR #12
    UMSUBL  X5, W10, W17, X28
    ADDS  X22, X14, W26, UXTB #0
    ADD  W7, W22, W24, SXTX #3
    CRC32CB  W12, W20, W23
    CSNEG  W16, W2, W25, MI
    AND  X16, X29, #0x30003000300030
    ORR  V30.4S, #0xaf, LSL #16
    CLZ  W24, W12
    MADD  W23, W8, W14, W15
    SBFM  W22, W26, #0x3, #0x9
    CLS  W4, W6
    SUBS  W10, W22, W2, ASR #18
    SUBS  W29, W7, W22, LSR #6
    LSLV  X25, X25, X6
    BIC  W13, W8, W5, LSR #11
    BICS  X15, X13, X19, LSL #11
    AND  X21, X21, X3, ROR #50
    CSINV  W5, W9, W8, VC
    MOVK  X28, #0x4635, LSL #0
    ANDS  W21, W2, W20, LSL #31
    MADD  W16, W19, W25, W6
    CLS  V18.2S, V5.2S
    UBFM  X19, X21, #0xf, #0xc
    CRC32CB  W26, W29, W9
    ANDS  X4, X20, #0xfffffff801ffffff
    UMULH  X15, X19, X3
    MOVK  X26, #0x4e4a, LSL #0
    ADCS  W18, W29, W17
    CRC32CH  W16, W7, W7
    SUB  W4, W5, W8, SXTX #3
    LSRV  X2, X15, X26
    CRC32CB  W18, W28, W22
    MOVZ  W13, #0x848, LSL #16
    CRC32CH  W13, W15, W12
    MADD  X10, X4, X7, X24
    CRC32X  W2, W10, X4
    SBFM  X4, X28, #0xd, #0x2b
    SUBS  X26, X6, #0xb65
    CSINC  X26, X28, X26, CC
    CRC32CX  W26, W3, X26
    MOVN  X28, #0x71e8, LSL #32
    CRC32B  W25, W16, W9
    SUBS  W14, W10, W18, SXTB #1
    ADDS  W18, W4, W10, SXTW #2
    MOVN  W10, #0x7525, LSL #16
    SUBS  X4, X13, #0xd2
    ADC  W20, W7, W16
    SBFM  X22, X23, #0x27, #0x11
    BIC  X14, X13, X15, ASR #46
    SUBS  X8, X3, W22, UXTB #0
    AND  X12, X29, X4, LSR #33
    ASRV  X29, X29, X18
    LSLV  X12, X4, X12
    SBFM  W7, W5, #0x1, #0x11
    UMULH  X9, X8, X7
    SUBS  X26, X14, X23, LSL #13
    CSINC  W26, W24, W6, LT
    SMSUBL  X14, W26, W17, X25
    ADD  W25, W12, W27, UXTH #4
    BICS  W9, W25, W5, LSR #9
    SUB  X18, X7, X22, ASR #61
    ADD  X29, X20, W21, UXTB #3
    EOR  X5, X18, X26, LSL #45
    CSNEG  W16, W10, W6, CS
    SUB  X3, X5, #0x224
    SMSUBL  X26, W18, W7, X22
    ADC  W9, W25, W8
    ANDS  X22, X22, #0x80ff80ff80ff80ff
    CLS  X3, X17
    ADCS  W3, W18, W27
    ADD  W16, W24, W6, SXTW #2
    ORR  W16, W19, W21, ASR #30
    ORR  X21, X24, X12, LSL #48
    CSNEG  X21, X18, X20, AL
    EXTR  W29, W8, W28, #0x1a
    MOVK  W12, #0xca93, LSL #0
    SUB  X18, X9, #0x78e
    MOVN  W27, #0xb77b, LSL #16
    SUB  W8, W4, W19, LSR #0
    ASRV  W6, W25, W21
    CRC32CB  W14, W26, W25
    EOR  X22, X23, #0xfffffffffe00000
    SBFM  W8, W16, #0x8, #0x5
    CRC32B  W21, W24, W15
    CSINV  W5, W3, W28, NV
    EON  W27, W5, W3, LSL #3
    ADD  W27, W6, W8, SXTX #3
    SBFM  X6, X21, #0x5, #0x3b
    SUB  X18, X25, #0x20, LSL #12
    LSLV  W28, W26, W7
    CRC32W  W16, W13, W4
    EOR  X23, X8, X28, LSL #26
    ADCS  X2, X19, X27
    ADC  X7, X19, X8
    SUB  W29, W13, W19, SXTH #2
    BIC  V5.8B, V6.8B, V9.8B
    CRC32CB  W5, W13, W13
    CSINC  X5, X22, X24, LE
    SMSUBL  X14, W25, W7, X25
    ORN  X5, X29, X3, LSR #62
    SUBS  W14, W14, #0x516
    ADDS  W28, W8, W5, SXTW #1
    CRC32X  W28, W28, X25
    ADC  X27, X22, X22
    ANDS  X22, X12, #0xcfcfcfcfcfcfcfcf
    CLS  V21.4S, V16.4S
    SMSUBL  X18, W23, W18, X27
    ADD  W22, W14, #0x438
    ADDS  X15, X24, X6, LSR #57
    MOVN  W8, #0x436f, LSL #16
    ADD  X29, X3, #0xab0
    ORN  W2, W13, W18, LSR #20
    LSLV  X12, X28, X15
    AND  W13, W4, #0xf8fff8ff
    SUBS  W7, W15, W9, SXTX #4
    ANDS  W7, W12, W4, ASR #19
    ADDS  W5, W19, W16, UXTB #4
    SMSUBL  X18, W22, W5, X5
    SUBS  W13, W6, W4, ASR #27
    SUBS  X23, X25, #0xc71, LSL #12
    EOR  X12, X7, #0x40000000400000
    EOR  X28, X12, #0xfffffffff0007fff
    ORN  X3, X21, X8, LSR #6
    CSNEG  X18, X25, X23, PL
    SMSUBL  X23, W13, W29, X3
    ADCS  W12, W26, W5
    SUBS  X22, X25, #0x51
    SUB  X25, X28, X6, ASR #20
    UMULH  X7, X24, X4
    ASRV  X4, X26, X28
    UMSUBL  X15, W9, W20, X28
    ASRV  W21, W7, W27
    MOVZ  X6, #0x7a90, LSL #0
    ORR  X21, X25, #0x1e00000000000
    MOVK  X3, #0x1eba, LSL #16
    ANDS  W8, W8, #0xbfbfbfbf
    SUBS  X4, X29, #0x6d0
    LSRV  X4, X13, X17
    SMADDL  X28, W15, W9, X21
    ANDS  W18, W15, #0xf7f7f7f7
    EXTR  X25, X22, X17, #0xf
    ADDS  W9, W12, W9, UXTB #2
    ADDS  W3, W23, W7, ASR #11
    SUBS  W18, W3, W29, ASR #8
    LSLV  X10, X12, X5
    CSNEG  X3, X12, X26, VC
    SMSUBL  X9, W28, W21, X9
    EON  W6, W5, W4, ROR #3
    SUBS  X19, X14, #0x39a
    SUBS  X17, X17, #0x1
    B.NE  TaishanIntAluP01_label_190
    MOVZ  X10, #0xf7fd, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X2, X10, X2
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP01_TestFail
    MOVZ  X23, #0xe3b1, LSL #0
    MOVK  X23, #0xcd4, LSL #16
    SUB  X20, X23, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x4, LSL #0
    SUB  X5, X6, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X3, X20, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x4, LSL #0
    SUB  X10, X2, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP01_TestFail
    MOVZ  X29, #0xbfbf, LSL #0
    MOVK  X29, #0xbc90, LSL #16
    SUB  X4, X29, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x70fa, LSL #0
    MOVK  X20, #0x1e12, LSL #16
    MOVK  X20, #0x8f9d, LSL #32
    MOVK  X20, #0x10f1, LSL #48
    SUB  X4, X20, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x9, LSL #0
    SUB  X5, X2, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X15, #0x3ff4, LSL #0
    MOVK  X15, #0xd221, LSL #16
    SUB  X4, X15, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x3ff4, LSL #0
    MOVK  X20, #0xd221, LSL #16
    SUB  X9, X20, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X15, #0x497b, LSL #0
    MOVK  X15, #0xa30d, LSL #16
    SUB  X17, X15, X16
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X23, X22, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X24, #0xf5ea, LSL #0
    MOVK  X24, #0xed7b, LSL #16
    SUB  X13, X24, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X19
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X17, #0x3ff4, LSL #0
    MOVK  X17, #0xd221, LSL #16
    SUB  X22, X17, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X28, #0x2a7f, LSL #0
    MOVK  X28, #0x3803, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffbf, LSL #48
    SUB  X24, X28, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x8972, LSL #48
    SUB  X7, X2, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP01_TestFail
    MOVZ  X15, #0xdc00, LSL #0
    MOVK  X15, #0xcd4, LSL #16
    MOVK  X15, #0x7e, LSL #32
    SUB  X3, X15, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP01_TestFail
    MOVZ  X16, #0x7e13, LSL #0
    MOVK  X16, #0xaa28, LSL #16
    MOVK  X16, #0xfffe, LSL #32
    MOVK  X16, #0x1fff, LSL #48
    SUB  X28, X16, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X18, X23, X29
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP01_TestFail
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
    MOVZ  X2, #0x14, LSL #0
TaishanIntAluP01_label_217:
    CSEL  X15, X12, X28, NV
    SMADDL  X24, W15, W9, X3
    SUB  W20, W26, #0x76, LSL #12
    ADDS  W12, W13, #0x2e4
    SUB  X27, X2, W4, SXTH #1
    BIC  X8, X8, X13, LSR #19
    CLS  X24, X4
    SUB  W12, W12, #0xed0, LSL #12
    ADD  X29, X24, X13, LSL #13
    MOVZ  W24, #0xa7f4, LSL #0
    CSINC  X5, X12, X22, PL
    CLS  X16, X20
    SMULH  X10, X29, X16
    LSRV  X17, X18, X22
    LSLV  X10, X17, X19
    EXTR  X19, X13, X27, #0x5
    CRC32W  W13, W28, W25
    ADC  W25, W15, W25
    CSNEG  X28, X20, X29, GE
    ORN  W7, W14, W13, ASR #11
    EXTR  W5, W16, W19, #0x1a
    EOR  W4, W20, W7, LSL #25
    BIC  V7.16B, V28.16B, V17.16B
    ADC  X23, X6, X17
    ORR  V23.2S, #0xfe
    AND  W26, W14, W17, LSL #11
    BIC  V23.8B, V18.8B, V9.8B
    SUB  W23, W29, W9, LSL #10
    EOR  X23, X18, X23, ROR #50
    CRC32CH  W29, W15, W2
    BICS  W26, W17, W8, ROR #15
    BIC  X29, X14, X28, LSL #41
    SMSUBL  X7, W2, W29, X21
    ASRV  W27, W8, W2
    SUBS  X23, X13, X4, LSR #44
    BIC  W23, W8, W6, LSL #23
    EOR  W13, W25, W25, ASR #15
    ORR  X17, X18, #0x1fe000001fe0000
    UBFM  W15, W22, #0x4, #0x13
    ADDS  X25, X5, W9, UXTW #2
    SBFM  X15, X7, #0x39, #0x3a
    BIC  W29, W21, W15, LSR #29
    EXTR  W18, W23, W14, #0x14
    ASRV  W10, W5, W6
    SMULH  X21, X29, X27
    EXTR  W9, W23, W8, #0x1d
    ADD  W8, W16, W13, UXTB #0
    AND  W23, W4, #0x7f800
    SBFM  X9, X2, #0x2a, #0x16
    ADDS  X8, X5, X13, ASR #58
    ADD  X23, X6, X24, ASR #13
    MOVZ  X28, #0x2d6e, LSL #0
    UMULH  X6, X23, X2
    ANDS  W16, W23, W26, LSL #7
    ANDS  W10, W27, W25, LSR #9
    BICS  X23, X6, X14, ASR #39
    ADC  W6, W7, W16
    ANDS  X10, X2, X10, ROR #46
    ADDS  X13, X5, #0x4b5, LSL #12
    ADDS  X28, X24, W12, SXTH #2
    EOR  X8, X24, #0xc001ffffc001ffff
    MOVN  W7, #0x5f40, LSL #16
    ADDS  X26, X20, X23, LSR #19
    ADCS  W26, W24, W3
    ORN  X4, X4, X6, ROR #49
    CRC32W  W5, W27, W17
    SBFM  W25, W5, #0x18, #0x4
    UMULH  X4, X3, X14
    ORR  V26.4H, #0xaa
    AND  W10, W4, W29, ASR #0
    UMSUBL  X23, W13, W20, X29
    CLS  W4, W24
    ASRV  X10, X7, X25
    EOR  X17, X6, X26, ASR #49
    ANDS  W21, W4, #0x60000000
    SMULH  X16, X15, X10
    CSINC  W4, W7, W3, LT
    CRC32CX  W23, W16, X6
    CLZ  X8, X20
    ORR  W7, W23, #0xfffe00ff
    EOR  X14, X12, X22, ASR #23
    CRC32W  W17, W15, W19
    ADDS  X17, X4, W21, UXTB #3
    CLZ  V18.8H, V15.8H
    CLZ  V19.4S, V7.4S
    SUBS  X9, X14, X17
    ORR  V3.16B, V25.16B, V6.16B
    ANDS  W16, W9, #0xffff8
    BIC  W24, W7, W23, LSL #29
    ADD  W10, W19, #0x79b
    ADD  W13, W4, #0xbc9
    CSINC  W20, W17, W14, GE
    CSNEG  W7, W29, W21, CS
    CSINV  X20, X20, X20, LE
    ANDS  X8, X2, X3, LSL #61
    EXTR  X16, X22, X13, #0x7
    MOVZ  W16, #0x6196, LSL #16
    ORR  V22.16B, V16.16B, V7.16B
    SUB  W12, W18, W15, LSL #3
    CLZ  W9, W28
    ANDS  W8, W6, #0xfeffffff
    SUBS  X29, X20, X8, ASR #54
    SMULH  X22, X23, X7
    CSEL  X26, X17, X10, PL
    AND  W7, W13, #0xff9fff9f
    CSINC  W9, W27, W13, LT
    BIC  W6, W2, W9, ASR #18
    EON  X7, X15, X20, ROR #41
    SMULH  X12, X4, X6
    SUB  W29, W22, #0xab1, LSL #12
    SUBS  W26, W12, #0x6e4
    SMULH  X6, X16, X17
    SUB  W4, W19, #0x0
    EOR  W4, W12, #0x1fff8000
    EOR  X3, X20, X29, LSL #10
    BIC  X16, X2, X7, ROR #43
    MOVN  W26, #0x43e6, LSL #0
    BICS  W21, W17, W27, LSL #8
    EON  X7, X13, X5, LSL #18
    ORR  X26, X29, #0xe7e7e7e7e7e7e7e7
    SUBS  W6, W3, W6, LSR #15
    SUBS  X18, X23, W16, UXTB #3
    BICS  X17, X27, X26, ASR #42
    AND  W8, W25, W2, ROR #11
    ADDS  W18, W6, W16, LSL #12
    SBFM  W6, W8, #0x14, #0x8
    ASRV  X18, X9, X5
    ORR  W15, W9, #0x88888888
    MOVK  X10, #0xc993, LSL #48
    ADD  W8, W16, W19, LSL #31
    SUBS  X15, X8, W19, UXTH #3
    AND  X20, X14, #0xfffffc07ffffffff
    MADD  X4, X14, X10, X10
    LSLV  W9, W18, W26
    UMADDL  X9, W5, W14, X6
    MOVZ  X15, #0xe446, LSL #0
    MOVK  X10, #0x430e, LSL #32
    CRC32CX  W20, W18, X12
    CSEL  W10, W10, W15, PL
    CRC32CB  W3, W18, W12
    ADC  X8, X17, X27
    ADD  X23, X5, #0x59c, LSL #12
    MOVK  W20, #0x7b0e, LSL #0
    ASRV  W14, W3, W10
    ADDS  W8, W27, W15, ASR #10
    ADD  X23, X13, #0x6d5, LSL #12
    EON  X15, X15, X10, LSR #54
    EOR  X19, X17, #0xe1e1e1e1e1e1e1e1
    UBFM  X20, X6, #0x1c, #0x1d
    ANDS  W3, W28, W4, ROR #19
    ASRV  X14, X22, X5
    MOVZ  X3, #0xfabd, LSL #16
    BICS  W25, W10, W25, LSR #13
    CLS  X27, X13
    ADD  W13, W16, #0x50e, LSL #12
    ADDS  X16, X14, W18, SXTH #3
    ORR  X3, X3, #0xe000007fe000007f
    CLZ  V30.16B, V16.16B
    BIC  V11.8B, V6.8B, V14.8B
    CSINC  W8, W19, W4, CS
    EON  W7, W13, W5, ASR #9
    ADD  X4, X3, #0xd54, LSL #12
    ANDS  W25, W22, #0xffff03ff
    BIC  V22.8B, V6.8B, V3.8B
    ANDS  X22, X13, #0x3c003c003c003c
    ADD  W10, W6, #0xb3b
    ORR  W6, W15, #0xffffcfff
    CLS  X29, X15
    ADCS  X27, X7, X20
    CSNEG  W29, W26, W21, NE
    SUBS  W22, W28, #0xac, LSL #12
    CRC32X  W19, W21, X14
    ANDS  X6, X5, X28, LSL #51
    LSLV  X19, X3, X20
    CLZ  W20, W4
    CRC32CH  W22, W23, W16
    EXTR  X13, X16, X21, #0x9
    ADDS  W28, W4, W29, SXTW #1
    CSNEG  X27, X22, X28, NE
    ORR  X16, X8, #0xfffffe0000ffffff
    ADDS  X20, X10, X9, LSL #50
    SUB  W7, W9, W13, LSR #2
    ADD  W29, W26, #0x1e9
    ADDS  X4, X27, W10, SXTH #0
    SUB  X25, X23, W14, SXTW #3
    CSINC  W19, W20, W14, LT
    ADDS  W14, W28, W23, LSL #20
    SMULH  X5, X3, X25
    CSINC  W13, W26, W13, EQ
    EXTR  X13, X14, X9, #0x17
    CSINC  X9, X15, X13, AL
    ADDS  X16, X27, X18, ASR #50
    ORN  W6, W27, W18, ASR #17
    LSRV  W14, W29, W6
    ADDS  W28, W26, #0x500
    SUBS  W24, W28, W26, SXTH #3
    ADDS  X28, X20, W24, SXTB #2
    ADCS  X21, X29, X4
    CSINV  W24, W4, W16, NV
    CRC32CX  W14, W23, X5
    SUBS  X2, X2, #0x1
    B.NE  TaishanIntAluP01_label_217
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X17, #0x7f, LSL #0
    MOVK  X17, #0xfabd, LSL #16
    MOVK  X17, #0x7f, LSL #32
    MOVK  X17, #0xe000, LSL #48
    SUB  X16, X17, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP01_TestFail
    MOVZ  X7, #0xfc1c, LSL #0
    MOVK  X7, #0x9fac, LSL #16
    SUB  X19, X7, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X28, #0xb4f4, LSL #0
    MOVK  X28, #0xe09a, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X26, X28, X5
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X19, #0xfeed, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X7, X19, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X8
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP01_TestFail
    MOVZ  X17, #0xb3b, LSL #0
    SUB  X14, X17, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP01_TestFail
    MOVZ  X5, #0x53b2, LSL #0
    MOVK  X5, #0x121e, LSL #16
    MOVK  X5, #0x9a0c, LSL #32
    MOVK  X5, #0x2460, LSL #48
    SUB  X8, X5, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X26, X28, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X15, #0x1bb9, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X25, X15, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
    MOVZ  X13, #0xb3b, LSL #0
    SUB  X9, X13, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X23, #0xb3b, LSL #0
    MOVK  X23, #0x11e0, LSL #48
    SUB  X9, X23, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X26, #0xf5ed, LSL #0
    MOVK  X26, #0x9fa4, LSL #16
    MOVK  X26, #0x1, LSL #32
    SUB  X19, X26, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X19, #0xf0e1, LSL #0
    MOVK  X19, #0x9fac, LSL #16
    SUB  X5, X19, X22
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X21, #0xb3b, LSL #0
    MOVK  X21, #0x11e0, LSL #48
    SUB  X14, X21, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP01_TestFail
    MOVZ  X27, #0xfc1c, LSL #0
    MOVK  X27, #0x9fac, LSL #16
    SUB  X7, X27, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X8, #0xf5ed, LSL #0
    MOVK  X8, #0x9fa4, LSL #16
    MOVK  X8, #0x1, LSL #32
    SUB  X9, X8, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X10, #0xfc1c, LSL #0
    MOVK  X10, #0x9fac, LSL #16
    SUB  X28, X10, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP01_TestFail
    MOVZ  X20, #0xf9d0, LSL #0
    MOVK  X20, #0xfff7, LSL #16
    SUB  X29, X20, X29
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X2, #0xff11, LSL #0
    MOVK  X2, #0x854, LSL #16
    MOVK  X2, #0x8fb1, LSL #32
    MOVK  X2, #0x734b, LSL #48
    MOVZ  X3, #0x810e, LSL #0
    MOVK  X3, #0xe2c5, LSL #16
    MOVK  X3, #0x719a, LSL #32
    MOVK  X3, #0x39ef, LSL #48
    MOVZ  X4, #0xcf11, LSL #0
    MOVK  X4, #0x9a83, LSL #16
    MOVK  X4, #0x7044, LSL #32
    MOVK  X4, #0x8a8e, LSL #48
    MOVZ  X5, #0x22f1, LSL #0
    MOVK  X5, #0x47ea, LSL #16
    MOVK  X5, #0xca92, LSL #32
    MOVK  X5, #0xc9f9, LSL #48
    MOVZ  X6, #0x7769, LSL #0
    MOVK  X6, #0xe16d, LSL #16
    MOVK  X6, #0xa508, LSL #32
    MOVK  X6, #0x1b64, LSL #48
    MOVZ  X7, #0x4ef0, LSL #0
    MOVK  X7, #0x251b, LSL #16
    MOVK  X7, #0xc7c0, LSL #32
    MOVK  X7, #0x5a2d, LSL #48
    MOVZ  X8, #0xa73b, LSL #0
    MOVK  X8, #0x8422, LSL #16
    MOVK  X8, #0x7b9e, LSL #32
    MOVK  X8, #0x69, LSL #48
    MOVZ  X9, #0x564d, LSL #0
    MOVK  X9, #0x4411, LSL #16
    MOVK  X9, #0xc73f, LSL #32
    MOVK  X9, #0x28eb, LSL #48
    MOVZ  X10, #0x6ae6, LSL #0
    MOVK  X10, #0xb11e, LSL #16
    MOVK  X10, #0xa040, LSL #32
    MOVK  X10, #0x4695, LSL #48
    MOVZ  X12, #0x47ca, LSL #0
    MOVK  X12, #0xb71f, LSL #16
    MOVK  X12, #0x5c3, LSL #32
    MOVK  X12, #0x6ebb, LSL #48
    MOVZ  X13, #0x1a08, LSL #0
    MOVK  X13, #0xc3a8, LSL #16
    MOVK  X13, #0xd55c, LSL #32
    MOVK  X13, #0x9707, LSL #48
    MOVZ  X14, #0x3e22, LSL #0
    MOVK  X14, #0x3b94, LSL #16
    MOVK  X14, #0xd667, LSL #32
    MOVK  X14, #0x69c, LSL #48
    MOVZ  X15, #0x9c5d, LSL #0
    MOVK  X15, #0x1e22, LSL #16
    MOVK  X15, #0x2524, LSL #32
    MOVK  X15, #0x7288, LSL #48
    MOVZ  X16, #0x7d09, LSL #0
    MOVK  X16, #0xed86, LSL #16
    MOVK  X16, #0x548a, LSL #32
    MOVK  X16, #0xb734, LSL #48
    MOVZ  X17, #0xe444, LSL #0
    MOVK  X17, #0xec45, LSL #16
    MOVK  X17, #0x7378, LSL #32
    MOVK  X17, #0x4ccb, LSL #48
    MOVZ  X18, #0x1c13, LSL #0
    MOVK  X18, #0x5825, LSL #16
    MOVK  X18, #0x26d7, LSL #32
    MOVK  X18, #0x7a27, LSL #48
    MOVZ  X19, #0xa718, LSL #0
    MOVK  X19, #0x9cad, LSL #16
    MOVK  X19, #0xdd07, LSL #32
    MOVK  X19, #0x76aa, LSL #48
    MOVZ  X20, #0xa9dc, LSL #0
    MOVK  X20, #0xd517, LSL #16
    MOVK  X20, #0x7b84, LSL #32
    MOVK  X20, #0x4b0e, LSL #48
    MOVZ  X21, #0x609c, LSL #0
    MOVK  X21, #0x19f1, LSL #16
    MOVK  X21, #0x6aa, LSL #32
    MOVK  X21, #0xa937, LSL #48
    MOVZ  X22, #0xc573, LSL #0
    MOVK  X22, #0x12a6, LSL #16
    MOVK  X22, #0x7b55, LSL #32
    MOVK  X22, #0xffa2, LSL #48
    MOVZ  X23, #0x73f8, LSL #0
    MOVK  X23, #0x4281, LSL #16
    MOVK  X23, #0xf58b, LSL #32
    MOVK  X23, #0x70c2, LSL #48
    MOVZ  X24, #0x9a9f, LSL #0
    MOVK  X24, #0x71bb, LSL #16
    MOVK  X24, #0x48d9, LSL #32
    MOVK  X24, #0xc3ce, LSL #48
    MOVZ  X25, #0x531f, LSL #0
    MOVK  X25, #0x5208, LSL #16
    MOVK  X25, #0xb86e, LSL #32
    MOVK  X25, #0x8cc2, LSL #48
    MOVZ  X26, #0x1a9d, LSL #0
    MOVK  X26, #0x5dca, LSL #16
    MOVK  X26, #0xa92a, LSL #32
    MOVK  X26, #0x43df, LSL #48
    MOVZ  X27, #0x9f5f, LSL #0
    MOVK  X27, #0x4297, LSL #16
    MOVK  X27, #0xa54a, LSL #32
    MOVK  X27, #0x7729, LSL #48
    MOVZ  X28, #0xf59, LSL #0
    MOVK  X28, #0x17ce, LSL #16
    MOVK  X28, #0x5757, LSL #32
    MOVK  X28, #0x55e1, LSL #48
    MOVZ  X29, #0x8b5f, LSL #0
    MOVK  X29, #0xa7b9, LSL #16
    MOVK  X29, #0xed1c, LSL #32
    MOVK  X29, #0xe302, LSL #48
    MOVZ  X28, #0xa, LSL #0
TaishanIntAluP01_label_244:
    ANDS  X24, X12, #0xffffffff03ffffff
    CRC32H  W29, W29, W14
    ORR  W5, W25, W25, ROR #10
    MOVZ  X19, #0x94b5, LSL #0
    SUB  X5, X22, X2, LSR #0
    EXTR  X14, X19, X13, #0x17
    ORR  V2.4H, #0xff, LSL #8
    MOVK  X9, #0x9dad, LSL #32
    BIC  W20, W15, W28, ROR #3
    CRC32B  W23, W5, W23
    CLS  X19, X14
    ADCS  W3, W9, W6
    ORR  X17, X9, X20, ASR #31
    BIC  X29, X20, X24, ASR #53
    ADDS  X7, X24, #0x432
    BIC  X6, X5, X17, ASR #10
    MADD  W23, W24, W3, W16
    CSINC  W19, W22, W29, NE
    CLS  V25.8H, V8.8H
    CSINV  W6, W17, W24, VS
    CRC32CB  W25, W14, W13
    MOVN  X25, #0x2e2e, LSL #16
    ADD  X21, X19, #0x381
    EOR  W21, W8, #0xf0
    ORR  W22, W3, W15, ASR #15
    SUB  W15, W12, #0xc93, LSL #12
    EOR  W8, W29, W13, LSR #23
    ANDS  X19, X15, #0xc000000
    CRC32B  W27, W14, W29
    LSLV  W14, W12, W2
    ANDS  X2, X9, #0x38003800380038
    UMSUBL  X19, W2, W5, X8
    ADD  W14, W7, W27, ASR #27
    ADD  X19, X12, W3, UXTW #3
    UMULH  X25, X24, X8
    MOVZ  W8, #0x8d1a, LSL #0
    CSINV  W26, W29, W6, LS
    ADDS  X27, X17, X14, LSL #52
    EXTR  W2, W8, W12, #0xb
    CSEL  W16, W13, W24, EQ
    ADDS  W27, W19, W13, UXTW #4
    MOVN  X3, #0x4fb3, LSL #48
    ADDS  W7, W20, #0x760, LSL #12
    ORN  W6, W28, W7, LSL #15
    ADCS  X5, X16, X2
    SUB  X14, X13, #0x5ad, LSL #12
    AND  X5, X26, #0xfffffff800003fff
    BICS  W6, W9, W21, ROR #17
    CSINV  X22, X9, X26, PL
    ORN  W16, W29, W14, ASR #6
    ADD  X18, X8, X8, LSR #57
    BIC  W10, W27, W17, LSR #7
    EON  X22, X10, X3, ROR #30
    SUB  X14, X5, X14, ASR #59
    BIC  W5, W22, W7, ASR #11
    UMADDL  X16, W16, W10, X25
    ADDS  X17, X6, W14, UXTW #1
    BIC  V0.8B, V30.8B, V21.8B
    CSEL  X5, X8, X8, NE
    SMADDL  X14, W9, W27, X16
    AND  W18, W21, W21, ROR #23
    ADDS  X2, X15, #0x5a6
    ADD  W22, W16, #0x433
    EON  X14, X22, X15, LSR #10
    CRC32CB  W12, W26, W13
    CSEL  W20, W24, W5, EQ
    SUBS  X5, X20, #0xfe6, LSL #12
    CSNEG  W2, W27, W5, NE
    CLZ  W2, W27
    ANDS  W29, W15, W22, LSL #9
    ORR  X8, X2, X10, LSR #55
    ORR  X25, X29, #0xffffffffffe00001
    BICS  W6, W21, W20, ROR #21
    ADD  X25, X19, X5, UXTX #3
    CSINV  X9, X17, X12, CC
    SUBS  W23, W16, #0xeb7
    UMULH  X5, X26, X14
    SUB  X15, X3, W7, SXTW #2
    ORR  X5, X29, X18, LSL #56
    ORR  V11.8H, #0xb8, LSL #8
TaishanIntAluP01_label_184:
    EXTR  W10, W29, W26, #0x8
    UBFM  W27, W12, #0xa, #0x3
    CRC32X  W9, W9, X22
    EOR  W9, W20, #0x18001800
    MOVZ  X6, #0x7bb, LSL #48
    SUBS  W2, W28, W13, SXTX #4
    SUBS  X16, X29, W16, UXTH #1
    SUB  W21, W19, W20, LSR #13
    SUBS  X19, X14, #0x856, LSL #12
    ANDS  X27, X29, #0xff3fff3fff3fff3f
    ADDS  X15, X28, #0x3f0
    CSINV  W13, W16, W10, VC
    EOR  W12, W9, W23, ROR #13
    UBFM  X5, X17, #0x18, #0x25
    SUBS  X6, X5, #0x855
    CRC32W  W27, W6, W24
    SUBS  W23, W2, #0xd18
    CRC32H  W15, W8, W7
    CLZ  W3, W2
    ADDS  X22, X4, #0x533, LSL #12
    EXTR  X4, X23, X28, #0x1f
    CLZ  V28.8H, V5.8H
    ADC  X17, X13, X25
    SUBS  X8, X27, X19, ASR #29
    UMADDL  X8, W3, W8, X19
    MOVK  X10, #0x1fce, LSL #0
    CSEL  W29, W9, W28, CC
    MOVK  X12, #0x47fa, LSL #0
    SUBS  X2, X16, #0x9d0
    ADD  X2, X7, X7, LSR #31
    ORN  W18, W5, W4, ROR #22
    AND  W14, W19, #0x1ff00000
    CLZ  V17.4H, V11.4H
    CSINC  W16, W16, W5, LE
    MADD  X14, X16, X29, X19
    UBFM  X13, X3, #0x16, #0x0
    ADD  W10, W14, #0x1ad, LSL #12
    LSLV  W14, W21, W28
    CSINV  W13, W13, W23, AL
    MADD  X9, X18, X8, X26
    MADD  X2, X2, X10, X7
    MOVZ  W29, #0x2fe1, LSL #16
    SUBS  W27, W7, W14, LSR #11
    SMSUBL  X12, W5, W12, X8
    ORR  V31.16B, V13.16B, V22.16B
    AND  W12, W7, #0xbfbfbfbf
    ADDS  W22, W12, W26, SXTW #0
    SUB  W18, W4, W12, LSR #6
    SUB  X26, X16, W8, SXTW #4
    MADD  W25, W22, W12, W24
    AND  W9, W24, W14, LSR #17
    CSINC  X7, X9, X18, VC
    SMSUBL  X26, W19, W6, X20
    AND  W5, W5, W26, ROR #4
    BIC  X29, X18, X6, LSL #63
    EXTR  X24, X8, X22, #0x36
    SUB  W16, W22, #0x8d0, LSL #12
    ASRV  X5, X18, X19
    EOR  W16, W18, #0x7fff0
    ADDS  X20, X2, X22, LSR #27
    CRC32H  W15, W24, W4
    SUB  W8, W24, W25, ASR #4
    CLS  W24, W29
    CSEL  W19, W17, W23, NE
    UMULH  X10, X19, X16
    SMULH  X27, X17, X6
    ADD  X13, X8, #0xc70
    SUB  W20, W23, W25, SXTH #4
    AND  X19, X27, #0xc1c1c1c1c1c1c1c1
    CSINV  X15, X5, X6, VS
    CSEL  W17, W18, W14, NV
    ADDS  X17, X29, W17, UXTW #3
    ADD  W7, W26, W16, UXTW #2
    CSINC  X20, X29, X15, CC
    LSRV  X5, X5, X22
    ADD  X18, X17, #0x8c0
    ADCS  X9, X20, X5
    SUBS  W13, W23, #0x6dd
    ADCS  X7, X28, X13
    CSNEG  W8, W10, W19, EQ
    LSLV  W18, W12, W29
    CRC32B  W18, W16, W23
    SUB  X17, X8, X10, LSL #41
    ORR  V31.4S, #0xe8, LSL #8
    CRC32CB  W24, W17, W20
    ANDS  W17, W23, W21, LSR #25
    SBFM  X17, X25, #0x3b, #0x5
    ADCS  W16, W18, W17
    ADDS  W13, W3, W3, LSL #8
    MADD  X12, X14, X3, X15
    MOVK  X14, #0x65d0, LSL #48
    EOR  X18, X12, X14, ROR #26
    EOR  X21, X18, #0x3ffffc003ffffc00
    ADC  W10, W9, W19
    AND  X9, X24, #0xfffe00fffffe00ff
    EOR  X21, X9, X13, ROR #9
    ORN  W12, W23, W4, ROR #11
    LSRV  X8, X20, X24
    ADC  X16, X20, X16
    SMADDL  X17, W15, W27, X23
    MOVK  X14, #0xdb63, LSL #0
    LSRV  X24, X3, X2
    SMULH  X7, X5, X17
    CRC32B  W13, W16, W16
    ADDS  X27, X14, #0xe21, LSL #12
    UBFM  X2, X2, #0x2d, #0x0
    ANDS  W10, W20, #0x1f801f8
    SUBS  X4, X20, X27, ASR #26
    ADCS  X8, X10, X23
    EXTR  X19, X4, X15, #0x33
    ORR  V19.4S, #0xd7, LSL #8
    ANDS  X20, X28, #0xfffffffffff801ff
    CLS  W27, W10
    ORR  V7.2S, #0x97, LSL #16
    ORR  W24, W24, W2, LSL #24
    SUBS  X8, X26, W22, UXTW #3
    SUBS  X22, X18, W2, UXTB #4
    BICS  X19, X8, X27, ASR #61
    BICS  W26, W3, W24, LSR #15
    SUB  W3, W23, #0x76b
    SUBS  X28, X28, #0x1
    B.NE  TaishanIntAluP01_label_244
    MOVZ  X15, #0x0, LSL #0
    SUB  X24, X15, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X23, #0xb5fe, LSL #0
    MOVK  X23, #0xf24b, LSL #16
    SUB  X2, X23, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP01_TestFail
    MOVZ  X28, #0x27a8, LSL #0
    MOVK  X28, #0x8bff, LSL #16
    MOVK  X28, #0xffe7, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X16, X28, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X5
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X29, #0xf834, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X5, X29, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X7, X5, X7
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP01_TestFail
    MOVZ  X27, #0x68d6, LSL #0
    MOVK  X27, #0xf72e, LSL #16
    MOVK  X27, #0x2ea, LSL #32
    SUB  X20, X27, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP01_TestFail
    MOVZ  X25, #0xb1, LSL #0
    MOVK  X25, #0x8dfe, LSL #16
    SUB  X20, X25, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP01_TestFail
    MOVZ  X29, #0x1e0, LSL #0
    MOVK  X29, #0x1f8, LSL #16
    SUB  X12, X29, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X5, #0x2557, LSL #0
    MOVK  X5, #0x29, LSL #16
    SUB  X10, X5, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X4, #0xdb63, LSL #0
    MOVK  X4, #0xdfdf, LSL #16
    MOVK  X4, #0x65d0, LSL #48
    SUB  X26, X4, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X19, X3, X16
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X10, #0xb59e, LSL #0
    MOVK  X10, #0xf24b, LSL #16
    SUB  X29, X10, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x7fc, LSL #0
    MOVK  X20, #0x7400, LSL #16
    MOVK  X20, #0x9199, LSL #32
    MOVK  X20, #0xf7e1, LSL #48
    SUB  X24, X20, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X5, #0x7fc, LSL #0
    MOVK  X5, #0x7400, LSL #16
    MOVK  X5, #0x9199, LSL #32
    MOVK  X5, #0xf7e1, LSL #48
    SUB  X24, X5, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X15, #0xb1, LSL #0
    MOVK  X15, #0x8dfe, LSL #16
    SUB  X22, X15, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X27, X19, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X6, X29, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X24
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X24, X15, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X26
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X15, X29, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X23, X21, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
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
    MOVZ  X18, #0xa, LSL #0
TaishanIntAluP01_label_271:
    ADDS  W28, W16, #0x10f
    CLS  W12, W17
    MOVN  X27, #0xcca1, LSL #48
    SMADDL  X24, W28, W21, X25
    ANDS  W22, W28, W20, ASR #3
    UBFM  W15, W23, #0x1f, #0x4
    ADD  W6, W27, W14, UXTH #2
    ANDS  X14, X28, #0x7fff8000000000
    ADCS  X9, X29, X7
    UMULH  X21, X3, X2
    ADCS  X17, X17, X23
    LSLV  X13, X19, X3
    ADC  W28, W27, W23
    ANDS  X9, X12, X18, LSL #57
    ORR  V6.4H, #0xd8, LSL #8
    ADCS  X19, X14, X12
    SUB  X25, X15, W26, UXTW #4
    SMULH  X12, X20, X22
    MADD  X19, X14, X23, X19
    SUB  X19, X7, X25, ASR #47
    SUBS  X24, X25, X24, ASR #42
    ASRV  X13, X9, X28
    ADDS  W22, W26, W8, LSR #9
    MOVZ  X12, #0x15da, LSL #16
    MOVK  X14, #0xc466, LSL #0
    CSNEG  W5, W20, W8, LT
    EON  W6, W16, W7, LSL #14
    AND  W7, W25, W6, ROR #24
    BICS  X15, X14, X6, ROR #17
    ORR  W22, W26, #0xc00001ff
    ORR  V7.8H, #0xde, LSL #8
    ADD  X20, X23, X9, SXTX #1
    ANDS  W9, W4, #0x1000100
    ANDS  X8, X16, X26, LSR #25
    EON  X9, X4, X18, LSL #7
    AND  X12, X4, X9, ASR #36
    CSNEG  W4, W4, W22, NE
    SUBS  W14, W24, W23, ASR #8
    CSINC  W27, W23, W25, LE
    ADC  X9, X8, X19
    ADD  W8, W25, #0xb20
    CLZ  X20, X24
    ASRV  W23, W7, W16
    SMULH  X24, X14, X15
    SUBS  W26, W22, #0x5c7
    BICS  X24, X18, X15, LSR #45
    CLS  X25, X18
    EOR  X28, X25, #0x7e00000000000
    BIC  W8, W18, W7, LSR #11
    EOR  X7, X24, #0x1ffffffff800
    ANDS  W19, W23, #0x7fe07fe
    ADDS  W24, W25, W19, UXTB #0
    SUBS  X16, X16, X21, ASR #62
    MOVK  X4, #0xf546, LSL #32
    CSINV  X23, X23, X9, LE
    ADD  X9, X27, #0xa10
    SUB  W10, W7, W16, LSR #12
    ADD  W15, W20, W25, UXTW #2
    ADDS  X22, X9, X28, LSL #33
    ADDS  X7, X9, X29, LSR #9
    AND  W4, W6, W27, ROR #4
    BIC  X29, X3, X15, ASR #47
    BICS  X29, X4, X24, ROR #11
    ANDS  W12, W5, W14, LSL #3
    CSNEG  X23, X6, X5, NV
    EOR  W7, W8, W29, LSL #31
    MOVK  W26, #0xa646, LSL #0
    SUBS  W22, W24, #0xa1c, LSL #12
    ADD  W8, W21, #0xa33, LSL #12
    CSEL  W24, W14, W18, VC
    MOVZ  W26, #0x9e2a, LSL #16
    UMSUBL  X10, W16, W3, X29
    CLS  W17, W16
    ADCS  W29, W8, W9
    MADD  X22, X3, X22, X28
    SUBS  W14, W28, #0x32a, LSL #12
    BIC  V8.16B, V26.16B, V24.16B
    SBFM  X27, X22, #0x9, #0x26
    ADD  X28, X23, W18, SXTB #3
    ORR  W20, W10, W9, ROR #26
    SUB  W20, W22, W8, SXTW #1
    EON  X24, X27, X4, ROR #26
    ORR  W24, W23, W23, LSL #10
    ADDS  W13, W6, W5, UXTH #3
    CRC32W  W26, W24, W18
    CLS  V11.8B, V6.8B
    ADDS  W24, W7, W7, UXTB #1
    SMULH  X26, X20, X17
    ADD  X23, X13, X16, LSL #31
    ADD  W13, W18, W5, LSL #31
    EON  W16, W24, W6, LSL #26
    CRC32CH  W29, W6, W26
    CLZ  X19, X21
    ANDS  X25, X27, #0xfffff00000007fff
    BIC  X19, X19, X10, LSL #9
    CLS  V11.8B, V29.8B
    CSEL  X5, X20, X17, HI
    ADD  X3, X10, #0xc18
    ORR  X14, X7, X28, LSR #42
    BIC  X10, X12, X5, LSR #16
    EXTR  X12, X25, X19, #0x1d
    EXTR  W7, W21, W16, #0x1b
    MOVK  W5, #0x8acb, LSL #0
    ADDS  W5, W6, #0x8ef, LSL #12
    ANDS  W20, W26, #0x7fffc
    SBFM  X13, X27, #0x1f, #0x27
    ADD  X25, X21, W3, UXTB #1
    CLS  V26.4S, V17.4S
    CLZ  V26.16B, V19.16B
    BICS  X7, X2, X19, LSR #19
    SMADDL  X17, W18, W14, X20
    ANDS  W14, W10, W7, ASR #26
    CRC32X  W23, W8, X10
    CLZ  X20, X28
    SUB  W28, W20, W14, ASR #16
    UBFM  X27, X24, #0x2c, #0x1c
    CRC32CW  W8, W17, W4
    CRC32B  W22, W27, W12
    MADD  X16, X4, X5, X3
    SUBS  X16, X2, W18, SXTB #1
    MOVN  X17, #0x274a, LSL #48
    MOVK  X13, #0x6151, LSL #48
    EXTR  W17, W6, W9, #0x5
    ADDS  W4, W28, W6, LSR #26
    EOR  X29, X21, #0x7ffffffffffe0
    AND  W2, W5, W24, LSL #10
    CLS  V11.4H, V23.4H
    CSNEG  X16, X7, X22, LE
    ADDS  X16, X10, X5, LSL #46
    ORR  V13.2S, #0x67, LSL #24
    CRC32B  W22, W13, W6
    CLZ  W14, W4
    ADC  W22, W26, W27
    UMULH  X6, X26, X19
    SMULH  X25, X13, X17
    ADDS  X29, X3, X25, LSL #35
    ORN  X25, X17, X17, LSL #51
    UMADDL  X9, W20, W7, X6
    CSINV  W5, W9, W15, VC
    LSRV  X16, X4, X27
    AND  X28, X27, X25, LSL #54
    ORR  X17, X2, X6, LSR #61
    SUBS  W14, W7, #0x0
    SUBS  X25, X26, X4, LSL #40
    CRC32CH  W13, W8, W23
    ASRV  X19, X25, X27
    SBFM  X24, X27, #0x21, #0x2f
    ANDS  W4, W12, W9, ROR #11
    ADCS  W29, W2, W2
    SUB  X7, X5, #0x0
    ADDS  X2, X24, #0xa5c
    CLZ  W14, W27
    SMULH  X5, X21, X12
    EON  W29, W28, W25, LSR #23
    BICS  W10, W2, W8, ASR #4
    BICS  X9, X23, X10, LSR #49
    ORR  W22, W8, #0x3e003e
    CRC32CX  W5, W17, X16
    EON  X23, X13, X29, LSR #50
    ANDS  W20, W6, W14, LSL #20
    MOVN  W4, #0x2741, LSL #16
    ADD  W6, W4, W16, UXTX #2
    SMULH  X14, X16, X10
    ORR  X6, X25, X13, ROR #3
    ADDS  W29, W21, W14, UXTH #1
    ORR  X19, X12, #0xffffe0003fffffff
    ADD  X23, X2, W16, SXTH #0
    AND  X8, X5, #0xff000000ff0000
    SUB  W27, W15, W8, UXTX #1
    SUBS  W10, W15, #0xd2b
    CRC32H  W17, W29, W22
    SMADDL  X15, W7, W12, X14
    SUBS  W5, W20, W5, UXTX #1
    SMSUBL  X10, W22, W23, X3
    ADD  W25, W12, W23, ASR #9
    CRC32B  W3, W29, W14
    MOVZ  W3, #0x90f7, LSL #16
    SMADDL  X23, W24, W24, X8
    BICS  W24, W3, W16, LSL #7
    ADDS  X10, X7, #0x4b4, LSL #12
    ADD  W7, W15, #0x8aa, LSL #12
    MOVK  X23, #0xb8e7, LSL #32
    AND  X13, X29, #0xfff8fffffff8ffff
    SUB  W9, W12, W24, SXTW #1
    BIC  X26, X16, X25, LSR #47
    ORR  V19.4H, #0xb2
    ASRV  W22, W8, W22
    ADDS  X10, X29, #0xa4d
    BIC  X12, X22, X12, ASR #61
    SMULH  X8, X22, X7
    CLS  W28, W23
    ORR  W5, W7, #0xff000000
    BICS  X28, X5, X10, LSR #25
    CSINV  W7, W9, W4, MI
    ORN  W2, W3, W13, ROR #21
    ANDS  W12, W17, W5, LSL #25
    ORR  W15, W13, W19, LSL #8
    MOVZ  W3, #0xd906, LSL #0
    CSNEG  W15, W7, W20, GT
    ORR  V6.8H, #0xce
    SUBS  X18, X18, #0x1
    B.NE  TaishanIntAluP01_label_271
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X15, X8, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X6, #0xd906, LSL #0
    SUB  X9, X6, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xd8be, LSL #16
    SUB  X4, X24, X4
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
    MOVZ  X15, #0xa000, LSL #0
    MOVK  X15, #0xff8a, LSL #16
    SUB  X21, X15, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X5, #0xd906, LSL #0
    SUB  X19, X5, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x2741, LSL #16
    SUB  X17, X5, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X24, X10, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X9
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X29, X15, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X9, X20, X12
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X15
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
    MOVZ  X17, #0x4f, LSL #0
    SUB  X20, X17, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x4f, LSL #0
    SUB  X14, X9, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X13, X12, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X19, X20, X22
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xaf, LSL #16
    MOVK  X12, #0xb8e7, LSL #32
    SUB  X17, X12, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X22, #0x5, LSL #0
    SUB  X23, X22, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X10, X4, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X27, #0xa000, LSL #0
    MOVK  X27, #0xff8a, LSL #16
    SUB  X24, X27, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
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
    MOVZ  X10, #0x14, LSL #0
TaishanIntAluP01_label_295:
    ORR  X13, X2, #0xff803fffffffffff
    ADDS  W6, W14, #0xadf, LSL #12
    CRC32H  W14, W12, W26
    ADDS  W5, W5, W12, ASR #30
    SMADDL  X24, W3, W12, X29
    ORR  W5, W24, #0xf00007ff
    SMULH  X6, X21, X9
    ORR  W26, W9, #0x55555555
    ADDS  W4, W27, #0x2c9
    ANDS  W22, W5, W13, LSR #19
    ADD  X29, X26, W23, SXTH #0
    ADCS  W18, W27, W23
    EOR  W5, W13, W4, ROR #20
    ADD  W22, W20, #0x168
    SUB  X8, X15, #0x44d
    MOVK  X24, #0x86, LSL #0
    MOVK  X8, #0x8e73, LSL #0
    CRC32W  W25, W15, W15
    MADD  W7, W6, W25, W20
    UMSUBL  X22, W5, W28, X19
    MOVN  X15, #0xa020, LSL #16
    SMADDL  X9, W14, W9, X24
    CRC32H  W15, W21, W6
    EOR  W27, W14, W4, LSR #19
    ASRV  X28, X26, X21
    ORN  W29, W21, W14, LSL #29
    CLS  W7, W20
    EOR  X26, X6, #0xfe000000fe0000
    EON  X18, X3, X5, ASR #8
    ADD  W17, W29, W3, ASR #20
    ADD  W14, W25, #0x7a6, LSL #12
    AND  W15, W24, #0x10001
    EOR  X29, X9, #0x78000000000000
    MADD  X12, X27, X22, X8
    SUBS  W22, W25, W13, UXTW #0
    LSRV  W23, W8, W26
    EON  W15, W24, W12, LSR #15
    SMULH  X29, X18, X29
    EOR  W15, W16, #0xdddddddd
    SMADDL  X16, W21, W19, X25
    ADDS  X12, X14, X2, LSL #12
    CRC32X  W9, W22, X26
    CRC32CB  W16, W12, W24
    CRC32CH  W6, W19, W27
    ADDS  W8, W23, #0x8e0, LSL #12
    SMULH  X24, X8, X13
    ANDS  X25, X3, X18, LSL #17
    EOR  X29, X6, X25, ROR #63
    EOR  X21, X22, X14, LSR #21
    MOVK  W7, #0x6ca2, LSL #16
    CSINC  X28, X2, X2, LE
    ADD  W26, W16, W10, LSL #3
    BICS  X8, X10, X28, ASR #10
    AND  X28, X10, #0xbbbbbbbbbbbbbbbb
    SUBS  W15, W7, #0x630
    ORR  W12, W29, #0x6060606
    MOVN  X28, #0xad25, LSL #0
    CSNEG  X29, X2, X6, GE
    SUBS  W15, W2, W8, ASR #28
    ADD  W21, W26, W18, ASR #19
    CSEL  X19, X9, X9, PL
    SUBS  W4, W10, W6, UXTW #0
    ADD  X21, X13, #0x7da, LSL #12
    SMULH  X6, X12, X4
    LSRV  W17, W22, W23
    ADDS  W22, W17, W3, SXTH #3
    MOVK  W24, #0xa707, LSL #0
    UMADDL  X6, W21, W26, X26
    ADCS  W6, W8, W21
    UBFM  W19, W6, #0x18, #0x1c
    ANDS  W18, W17, W26, ROR #8
    CRC32CW  W16, W15, W24
    ADD  W15, W2, W22, SXTW #0
    CLS  X9, X21
    MOVZ  W3, #0x5aa3, LSL #16
    LSLV  X3, X28, X26
    SBFM  X3, X3, #0x30, #0x26
    SUB  W14, W20, #0xa55, LSL #12
    ORR  X19, X7, X6, ASR #2
    SUBS  W14, W19, W20, UXTH #2
    ORR  V17.16B, V7.16B, V10.16B
    CSINV  W18, W8, W9, NV
    ADD  X8, X15, X9, SXTX #2
    EOR  X17, X8, #0x3ffe
    ORR  X27, X3, #0x1ffe000000000000
    CSNEG  X17, X4, X24, GE
    CRC32CX  W8, W8, X20
    ADDS  X3, X6, X26, SXTX #1
    ORR  W7, W16, #0x7f807f8
    ADDS  X4, X19, W6, SXTW #2
    SUBS  X14, X3, #0xfa0
    EOR  W13, W13, W10, LSL #30
    MOVK  W4, #0x9d40, LSL #16
    ADD  W27, W4, #0x130
    ADDS  X15, X2, X2, LSL #46
    EON  X4, X18, X5, LSL #14
    CSEL  X23, X6, X7, LT
    ADDS  X21, X14, W8, UXTH #4
    UMULH  X24, X28, X17
    ADDS  X3, X21, W8, UXTW #1
    CRC32B  W14, W18, W25
    SUBS  X3, X27, W24, SXTH #0
    SUBS  W25, W22, W18, LSL #12
    CSEL  W27, W9, W25, NE
    CSINC  W6, W19, W23, MI
    ADD  W29, W4, W3, LSL #30
    ADDS  X20, X5, #0x277, LSL #12
    ADDS  W15, W26, W29, SXTW #4
    SMULH  X14, X16, X5
    ANDS  W12, W12, #0x38003800
    CSEL  W29, W17, W5, AL
    ORR  W28, W18, W15, ASR #17
    ADCS  X27, X4, X22
    EOR  X25, X26, X17, LSR #20
    SBFM  W12, W23, #0x0, #0x19
    SUB  X2, X2, X13, LSR #30
    ORN  X16, X6, X14, LSR #28
    ADD  X19, X27, W5, SXTH #4
    ORN  W7, W12, W21, ASR #9
    CLZ  W27, W7
    CLZ  W22, W3
    ADC  X21, X7, X5
    SUBS  X17, X8, W20, UXTB #1
    BIC  W9, W13, W24, ASR #13
    EOR  W21, W21, #0xe1ffe1ff
    CSEL  W27, W26, W20, MI
    CRC32CX  W28, W6, X22
    MOVZ  X15, #0xf9ba, LSL #16
    CRC32W  W5, W13, W14
    CRC32CB  W28, W14, W5
    SMSUBL  X22, W12, W19, X5
    ANDS  W23, W29, W21, LSR #19
    UMSUBL  X18, W3, W3, X24
    AND  X2, X25, X8, LSR #18
    CSNEG  X8, X19, X26, LT
    BIC  W27, W29, W28, ROR #17
    SUB  X24, X9, X5, UXTX #0
    CLZ  X26, X22
    SUBS  W22, W29, W10, SXTX #4
    BIC  W3, W25, W26, ROR #22
    ANDS  W8, W6, #0xff000001
    CSINC  W9, W20, W5, LE
    SUB  X21, X19, W8, UXTW #3
    ADDS  X17, X6, W10, SXTW #3
    EOR  W21, W17, W22, LSR #27
    CLZ  W22, W4
    CSEL  X22, X15, X29, GE
    ASRV  W20, W7, W6
    SBFM  W20, W4, #0x7, #0x15
    SUBS  W28, W28, #0x1ca
    CRC32H  W19, W5, W29
    UBFM  X7, X6, #0x3f, #0x17
    AND  X20, X3, #0x8001ffff8001ffff
    LSLV  W8, W14, W9
    LSLV  W21, W29, W12
    SMULH  X17, X24, X27
    SUBS  X2, X22, X6, ASR #29
    MOVK  W6, #0xe743, LSL #0
    ADD  W17, W26, #0xb99
    ADCS  X8, X15, X14
    CRC32X  W6, W23, X16
    ORR  V8.8H, #0x39, LSL #8
    SMADDL  X9, W5, W17, X13
    CLS  V28.4S, V1.4S
    ADD  X17, X16, #0xea9
    CSINV  X16, X14, X9, CS
    EON  W19, W2, W2, ASR #11
    BICS  X20, X18, X13, ASR #21
    LSRV  W22, W12, W10
    LSRV  W23, W13, W29
    EOR  W14, W12, W20, LSL #11
    ADDS  X5, X13, #0x490
    CLS  W18, W5
    SMSUBL  X5, W28, W2, X23
    EOR  X4, X10, X29, ROR #12
    ORR  V5.16B, V20.16B, V19.16B
    ADD  X5, X6, W13, SXTB #0
    SMADDL  X15, W7, W3, X26
    ADD  W28, W5, W23, SXTW #4
    ORR  W17, W6, #0x3fc00
    CSEL  X5, X5, X26, MI
    ORR  X15, X25, #0x801f801f801f801f
    ANDS  X2, X12, #0x1ffe00001ffe000
    ORR  V25.4H, #0xff, LSL #8
    CLZ  X27, X18
    CLS  X28, X17
    UMULH  X3, X4, X5
    EXTR  W3, W5, W24, #0x3
    AND  X14, X22, X12, LSL #36
    ORR  V11.8H, #0x72
    CRC32H  W24, W29, W13
    CRC32CW  W2, W2, W24
    ADCS  W22, W24, W21
    CSNEG  W4, W25, W27, PL
    CRC32CW  W18, W6, W5
    ADD  W22, W24, W10, LSR #14
    SUBS  W13, W22, W3, SXTB #1
    ORN  X4, X25, X29, LSR #44
    SUB  X12, X13, X20, LSL #46
    BIC  X29, X7, X20, ASR #19
    SUBS  X10, X10, #0x1
    B.NE  TaishanIntAluP01_label_295
    MOVZ  X14, #0x137f, LSL #0
    MOVK  X14, #0x7675, LSL #16
    SUB  X12, X14, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X29, #0x8918, LSL #0
    MOVK  X29, #0xaf3, LSL #16
    SUB  X25, X29, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X5, X3, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X4, X18, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
    MOVZ  X29, #0xd000, LSL #0
    MOVK  X29, #0x17e, LSL #16
    SUB  X24, X29, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X27, #0x1, LSL #0
    MOVK  X27, #0xf9ba, LSL #16
    SUB  X4, X27, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
    MOVZ  X5, #0x2eba, LSL #0
    MOVK  X5, #0xd6f9, LSL #16
    MOVK  X5, #0xfc08, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X24, X5, X9
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X14, #0x2bd7, LSL #0
    MOVK  X14, #0xafb7, LSL #16
    SUB  X25, X14, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X26, #0x2bd7, LSL #0
    MOVK  X26, #0xafb7, LSL #16
    SUB  X23, X26, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X15
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP01_TestFail
    MOVZ  X28, #0xd145, LSL #0
    MOVK  X28, #0x2906, LSL #16
    MOVK  X28, #0x3f7, LSL #32
    SUB  X25, X28, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X24, #0xfcdb, LSL #0
    MOVK  X24, #0x1597, LSL #16
    SUB  X18, X24, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X4, #0x373d, LSL #0
    MOVK  X4, #0xf9b9, LSL #16
    SUB  X29, X4, X19
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X10, #0x800, LSL #0
    MOVK  X10, #0xe2ce, LSL #16
    MOVK  X10, #0xac80, LSL #32
    MOVK  X10, #0x9f67, LSL #48
    SUB  X26, X10, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X24, #0x4a0f, LSL #0
    MOVK  X24, #0x8ab9, LSL #16
    SUB  X16, X24, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP01_TestFail
    MOVZ  X7, #0x2c07, LSL #0
    MOVK  X7, #0xafb7, LSL #16
    SUB  X21, X7, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X22, X21, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x4a0f, LSL #0
    MOVK  X6, #0x8ab9, LSL #16
    SUB  X17, X6, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x0, LSL #0
TaishanIntAluP01_label_213:
    SUB  X21, X20, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X27
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP01_TestFail
    MOVZ  X10, #0xd145, LSL #0
    MOVK  X10, #0x2906, LSL #16
    MOVK  X10, #0x3f7, LSL #32
    SUB  X26, X10, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x675a, LSL #0
    MOVK  X2, #0x4f8d, LSL #16
    MOVK  X2, #0xa406, LSL #32
    MOVK  X2, #0x8947, LSL #48
    MOVZ  X3, #0x764c, LSL #0
    MOVK  X3, #0x1962, LSL #16
    MOVK  X3, #0x14f3, LSL #32
    MOVK  X3, #0xb166, LSL #48
    MOVZ  X4, #0xdd17, LSL #0
    MOVK  X4, #0x790e, LSL #16
    MOVK  X4, #0xcae6, LSL #32
    MOVK  X4, #0x8514, LSL #48
    MOVZ  X5, #0x1178, LSL #0
    MOVK  X5, #0x6d49, LSL #16
    MOVK  X5, #0x9dc1, LSL #32
    MOVK  X5, #0xfd60, LSL #48
    MOVZ  X6, #0x8948, LSL #0
    MOVK  X6, #0xe43b, LSL #16
    MOVK  X6, #0xaaa, LSL #32
    MOVK  X6, #0xcaa5, LSL #48
    MOVZ  X7, #0x78a9, LSL #0
    MOVK  X7, #0xef6f, LSL #16
    MOVK  X7, #0xcd19, LSL #32
    MOVK  X7, #0x562e, LSL #48
    MOVZ  X8, #0x1ea1, LSL #0
    MOVK  X8, #0xb968, LSL #16
    MOVK  X8, #0x2b9b, LSL #32
    MOVK  X8, #0xd860, LSL #48
    MOVZ  X9, #0xf99b, LSL #0
    MOVK  X9, #0xe15b, LSL #16
    MOVK  X9, #0x17dd, LSL #32
    MOVK  X9, #0xbcae, LSL #48
    MOVZ  X10, #0x5468, LSL #0
    MOVK  X10, #0xf296, LSL #16
    MOVK  X10, #0xd7dc, LSL #32
    MOVK  X10, #0x694a, LSL #48
    MOVZ  X12, #0x1918, LSL #0
    MOVK  X12, #0x278b, LSL #16
    MOVK  X12, #0x172d, LSL #32
    MOVK  X12, #0x5ac7, LSL #48
    MOVZ  X13, #0x823d, LSL #0
    MOVK  X13, #0xbfd3, LSL #16
    MOVK  X13, #0x48f6, LSL #32
    MOVK  X13, #0xb948, LSL #48
    MOVZ  X14, #0x44af, LSL #0
    MOVK  X14, #0xdc77, LSL #16
    MOVK  X14, #0x427b, LSL #32
    MOVK  X14, #0xcc06, LSL #48
    MOVZ  X15, #0xdd93, LSL #0
    MOVK  X15, #0x8350, LSL #16
    MOVK  X15, #0xa23f, LSL #32
    MOVK  X15, #0xd18b, LSL #48
    MOVZ  X16, #0x6123, LSL #0
    MOVK  X16, #0x5080, LSL #16
    MOVK  X16, #0xf16b, LSL #32
    MOVK  X16, #0x42da, LSL #48
    MOVZ  X17, #0xdd93, LSL #0
    MOVK  X17, #0x717d, LSL #16
    MOVK  X17, #0xb1c3, LSL #32
    MOVK  X17, #0x6301, LSL #48
    MOVZ  X18, #0x4515, LSL #0
    MOVK  X18, #0x157c, LSL #16
    MOVK  X18, #0x65f5, LSL #32
    MOVK  X18, #0xaa65, LSL #48
    MOVZ  X19, #0x7614, LSL #0
    MOVK  X19, #0xa37c, LSL #16
    MOVK  X19, #0x7176, LSL #32
    MOVK  X19, #0x715d, LSL #48
    MOVZ  X20, #0x36de, LSL #0
    MOVK  X20, #0x4443, LSL #16
    MOVK  X20, #0xd122, LSL #32
    MOVK  X20, #0x1389, LSL #48
    MOVZ  X21, #0x10b8, LSL #0
    MOVK  X21, #0xd2cf, LSL #16
    MOVK  X21, #0x711, LSL #32
    MOVK  X21, #0x8b9b, LSL #48
    MOVZ  X22, #0xe224, LSL #0
    MOVK  X22, #0xd2a5, LSL #16
    MOVK  X22, #0xe960, LSL #32
    MOVK  X22, #0xb716, LSL #48
    MOVZ  X23, #0x5fc1, LSL #0
    MOVK  X23, #0x141e, LSL #16
    MOVK  X23, #0x7908, LSL #32
    MOVK  X23, #0x3cdf, LSL #48
    MOVZ  X24, #0xac1a, LSL #0
    MOVK  X24, #0x97a8, LSL #16
    MOVK  X24, #0xdba7, LSL #32
    MOVK  X24, #0xf154, LSL #48
    MOVZ  X25, #0xd77b, LSL #0
    MOVK  X25, #0x770c, LSL #16
    MOVK  X25, #0x19ba, LSL #32
    MOVK  X25, #0x96a1, LSL #48
    MOVZ  X26, #0xf310, LSL #0
    MOVK  X26, #0xba83, LSL #16
    MOVK  X26, #0xac28, LSL #32
    MOVK  X26, #0x283b, LSL #48
    MOVZ  X27, #0xfb5b, LSL #0
    MOVK  X27, #0xc939, LSL #16
    MOVK  X27, #0x8bcf, LSL #32
    MOVK  X27, #0x5cc5, LSL #48
    MOVZ  X28, #0x4094, LSL #0
    MOVK  X28, #0x8d57, LSL #16
    MOVK  X28, #0xbf62, LSL #32
    MOVK  X28, #0xfc19, LSL #48
    MOVZ  X29, #0x9369, LSL #0
    MOVK  X29, #0x4532, LSL #16
    MOVK  X29, #0xd74a, LSL #32
    MOVK  X29, #0xf09c, LSL #48
    MOVZ  X17, #0xa, LSL #0
TaishanIntAluP01_label_320:
    AND  X15, X23, #0x8888888888888888
    ADDS  W2, W29, W25, LSR #9
    CSNEG  X27, X25, X28, EQ
    AND  X19, X17, #0x780000007800
    MOVZ  X28, #0xa8af, LSL #0
    BIC  V31.8B, V26.8B, V12.8B
    CSNEG  W21, W9, W16, VS
    CRC32W  W27, W27, W12
    CLS  V13.2S, V10.2S
    EOR  W15, W15, #0x7ffff80
    CLS  V26.8B, V8.8B
    ADCS  W8, W22, W28
    EXTR  X3, X21, X27, #0x14
    CRC32CH  W12, W20, W16
    MOVK  W4, #0x877c, LSL #0
    ASRV  W19, W28, W19
    MOVK  W13, #0xd391, LSL #0
    EOR  X10, X21, #0x101010101010101
    CRC32H  W23, W23, W19
    SBFM  W13, W15, #0x18, #0x2
    ADDS  X13, X7, X4, LSR #6
    ADD  X20, X17, X8, ASR #17
    CSINV  W10, W21, W27, GT
    UMULH  X23, X14, X29
    ADDS  X24, X26, X15, LSL #3
    CRC32CH  W28, W23, W29
    BICS  X18, X18, X22, LSL #59
    EON  X9, X21, X14, ROR #54
    CLZ  X2, X2
    SMADDL  X25, W28, W3, X18
    ADCS  W12, W27, W8
    ANDS  W26, W9, W18, ASR #18
    SUB  X14, X6, X23, LSR #39
    SUBS  X3, X23, #0xfb6
    MOVN  W2, #0x360b, LSL #16
    CRC32X  W16, W29, X2
    CLS  V3.4H, V14.4H
    CSNEG  X27, X24, X28, VC
    UBFM  W27, W24, #0x1c, #0x16
    EXTR  X20, X21, X2, #0x34
    EON  X10, X20, X17, LSL #58
    MOVZ  X12, #0x1e, LSL #32
    CLZ  V14.8B, V23.8B
    CSEL  X2, X26, X17, CS
    EON  W10, W28, W2, LSR #23
    SUBS  X7, X10, X23, ASR #6
    ADC  X16, X15, X20
    ADC  X10, X17, X8
    SMADDL  X20, W12, W24, X24
    SUBS  W2, W4, W16, ASR #11
    ANDS  X26, X23, X8, LSR #59
    CLZ  V18.4H, V27.4H
    AND  X2, X16, X29, ROR #59
    BIC  W7, W26, W10, ASR #21
    EXTR  X20, X16, X3, #0x3a
    SMULH  X28, X27, X21
    CSINV  W20, W17, W23, CS
    ADDS  W18, W13, W18, UXTH #3
    EOR  W20, W16, W7, ROR #0
    EOR  W2, W7, #0xfe0000ff
    BIC  X24, X26, X12, LSL #8
    ANDS  X7, X21, X14, LSR #51
    CRC32H  W7, W28, W29
    LSLV  X16, X27, X18
    SBFM  W8, W29, #0x1a, #0x2
    SUB  W20, W26, #0x0
    ORR  W14, W3, #0xe3ffe3ff
    EON  W20, W23, W24, ROR #26
    CSEL  X28, X8, X3, MI
    ASRV  X10, X29, X17
    CRC32CW  W13, W10, W4
    SUBS  W7, W24, W16, ASR #29
    ADCS  X7, X13, X9
    SUB  X7, X23, X14, ASR #41
    ADDS  W23, W2, #0x829, LSL #12
    ANDS  X2, X18, #0x1ffffffffffc0000
    ADDS  W8, W25, W16, UXTW #4
    SUB  X5, X22, W3, UXTH #1
    CSINV  X18, X26, X18, NE
    CRC32CX  W8, W8, X23
    SMADDL  X24, W27, W10, X16
    MOVZ  X10, #0x8f88, LSL #48
    ADD  X18, X4, X8, ASR #13
    ASRV  W29, W20, W28
    SUBS  W29, W22, #0xfb0
    ADDS  X7, X6, X19, LSR #36
    SMSUBL  X28, W2, W8, X14
    CSNEG  X8, X26, X24, NV
    CLS  V26.16B, V17.16B
    BICS  W24, W16, W26, ROR #10
    UBFM  W25, W12, #0x1e, #0x17
    CLS  V18.2S, V5.2S
    SUBS  X3, X13, W8, SXTB #1
    CSINC  W29, W5, W21, NE
    CRC32X  W23, W4, X12
    SUB  X27, X7, X28, LSR #55
    CSNEG  W12, W27, W22, VS
    ADD  X6, X28, W13, UXTB #1
    BIC  X3, X18, X19, LSL #17
    CSEL  X13, X28, X25, VS
    CSNEG  W7, W18, W19, HI
    BIC  W4, W18, W20, ASR #8
    LSLV  W29, W29, W16
    CLZ  W25, W13
    CRC32X  W19, W18, X2
    ADDS  X26, X5, X13, ASR #62
    SUB  W15, W20, W8, ASR #15
    CRC32CX  W14, W10, X26
    CLS  W5, W17
    ANDS  X22, X22, X27, LSR #39
    ORN  X3, X9, X16, ASR #46
    ADD  X4, X25, #0xdb6, LSL #12
    ASRV  X15, X8, X21
    CSEL  X26, X28, X4, AL
    MOVN  X6, #0xc41b, LSL #0
    SUBS  X25, X6, X20
    ADC  X26, X21, X4
    ORR  X26, X14, X9, ROR #43
    ADD  W29, W24, W26, SXTX #0
    ANDS  X22, X17, #0xffffffffff000007
    ADCS  X15, X2, X8
    BIC  V5.8B, V9.8B, V23.8B
    SBFM  W3, W10, #0xa, #0xd
    ORR  V14.2S, #0xef, LSL #24
    ANDS  X24, X3, #0x87ff87ff87ff87ff
    MOVK  X21, #0x444c, LSL #48
    AND  W18, W26, W16, LSR #26
    CLS  V13.2S, V28.2S
    BICS  W18, W29, W4, ASR #18
    CSNEG  W29, W18, W22, HI
    AND  W28, W24, #0xffffc07f
    UMULH  X24, X23, X27
    SUBS  X14, X25, X13, ASR #17
    SUB  X9, X16, #0xdf3, LSL #12
    MOVZ  X20, #0xe31d, LSL #16
    SBFM  X21, X24, #0x4, #0x2c
    SUBS  X14, X26, #0x5cc, LSL #12
    EOR  W14, W28, #0xffff03ff
    BIC  X28, X5, X23, ROR #26
    MOVZ  X21, #0x4339, LSL #32
    CRC32CB  W27, W22, W29
    EXTR  W16, W4, W24, #0x12
    CRC32X  W8, W13, X28
    ASRV  X13, X16, X19
    ADCS  X23, X23, X19
    CRC32CH  W18, W17, W22
    BIC  X8, X17, X4, ASR #49
    ADDS  X19, X3, W2, UXTH #4
    UMULH  X19, X25, X18
    ORN  X3, X4, X9, LSL #30
    CRC32H  W13, W25, W5
    CLZ  X4, X26
    SUB  W28, W16, W2, ASR #15
    EON  X18, X12, X28, LSL #35
    ASRV  W3, W20, W29
    ANDS  X27, X19, #0xffffffffc1ffffff
    SUB  W14, W9, W26, SXTH #3
    LSRV  W21, W7, W13
    SMSUBL  X4, W24, W4, X26
    ADD  W4, W28, W19, LSR #3
    EXTR  X29, X22, X27, #0x16
    BICS  W3, W18, W4, ROR #31
    MOVN  X26, #0xa568, LSL #0
    UMULH  X20, X12, X8
    CSEL  W13, W12, W13, CC
    MOVK  X28, #0xc910, LSL #32
    MADD  W8, W19, W21, W13
    SBFM  W23, W22, #0x11, #0xa
    MOVK  X9, #0xe485, LSL #16
    AND  X10, X9, #0xffffe00001ffffff
    ADDS  X12, X24, X4, LSR #60
    ADD  X10, X7, #0x56c, LSL #12
    CSINV  W8, W9, W6, AL
    EON  X25, X21, X10, ROR #39
    CSINV  W26, W19, W7, CC
    SUB  X25, X9, X20, SXTX #4
    MADD  W9, W8, W29, W15
    ANDS  W27, W14, W29, ROR #20
    SUBS  W7, W6, #0x6f8, LSL #12
    CRC32CB  W14, W20, W16
    ADCS  X3, X20, X25
    ANDS  X9, X5, X18, LSR #63
    ORR  V11.8B, V2.8B, V27.8B
    ADDS  X4, X4, X10, LSL #41
    SUB  X3, X21, #0x9d0
    AND  X6, X18, #0x800007ff800007ff
    ADC  X28, X28, X12
    SUB  X3, X12, W2, UXTB #1
    ADC  X22, X8, X25
    UMULH  X13, X14, X21
    CRC32H  W15, W2, W21
    SUB  X14, X26, #0x664, LSL #12
    ADD  W9, W23, W24, LSR #24
    UBFM  X28, X25, #0x8, #0xa
    ANDS  X20, X16, X2, LSR #41
    SUB  X13, X7, #0x539
    EON  W18, W28, W21, LSL #26
    CRC32CH  W18, W20, W29
    CRC32CX  W10, W24, X13
    MOVK  W4, #0xfac5, LSL #0
    SUBS  X17, X17, #0x1
    B.NE  TaishanIntAluP01_label_320
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x2ec, LSL #16
    SUB  X17, X27, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP01_TestFail
    MOVZ  X24, #0x445, LSL #0
    SUB  X2, X24, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP01_TestFail
    MOVZ  X26, #0xfac5, LSL #0
    MOVK  X26, #0xd807, LSL #16
    SUB  X25, X26, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x1e, LSL #0
    SUB  X3, X9, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP01_TestFail
    MOVZ  X18, #0x7ff, LSL #0
    MOVK  X18, #0x8000, LSL #16
    MOVK  X18, #0x6bf, LSL #32
    SUB  X29, X18, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X23, #0xbbe4, LSL #0
    MOVK  X23, #0xff8f, LSL #16
    SUB  X12, X23, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X13, #0x5000, LSL #0
    MOVK  X13, #0xe485, LSL #16
    SUB  X3, X13, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP01_TestFail
    MOVZ  X15, #0x1e, LSL #0
    SUB  X20, X15, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP01_TestFail
    MOVZ  X10, #0x578e, LSL #0
    MOVK  X10, #0xc18, LSL #16
    SUB  X27, X10, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP01_TestFail
    MOVZ  X16, #0x5000, LSL #0
    MOVK  X16, #0xe485, LSL #16
    SUB  X21, X16, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X22, #0xc000, LSL #0
    MOVK  X22, #0xff99, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X23, X22, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X3, #0x1e, LSL #0
    SUB  X28, X3, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP01_TestFail
    MOVZ  X10, #0x5000, LSL #0
    MOVK  X10, #0xe485, LSL #16
    SUB  X15, X10, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X3, X28, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP01_TestFail
    MOVZ  X5, #0x7ff, LSL #0
    MOVK  X5, #0x8000, LSL #16
    MOVK  X5, #0x6bf, LSL #32
    SUB  X19, X5, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
TaishanIntAluP01_label_206:
    MOVZ  X14, #0xc000, LSL #0
    MOVK  X14, #0xff99, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X9, X14, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x445, LSL #0
    SUB  X24, X8, X24
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP01_TestFail
    MOVZ  X26, #0xfac5, LSL #0
    MOVK  X26, #0xd807, LSL #16
    SUB  X28, X26, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
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
    MOVZ  X8, #0xa, LSL #0
TaishanIntAluP01_label_348:
    CRC32CW  W2, W15, W4
    ASRV  X10, X23, X28
    CRC32CX  W27, W13, X20
    LSLV  W14, W12, W2
    ADDS  W15, W26, #0x800
    MOVK  W15, #0xdc9, LSL #16
    ANDS  W7, W19, W9, LSR #5
    ADD  X5, X9, #0x200
    MOVK  X5, #0xf40f, LSL #16
    AND  X25, X27, X29, LSL #36
    EON  X14, X20, X10, LSL #25
    CSINV  X25, X20, X16, LS
    MADD  W10, W8, W22, W27
    CSEL  W23, W17, W27, LS
    UBFM  X23, X15, #0x5, #0x34
    CSINV  W10, W14, W21, GT
    ADD  W7, W21, #0x7d0
    ADC  W5, W5, W17
    LSLV  X22, X25, X9
    ANDS  W29, W9, #0xfe00ffff
    SBFM  X25, X27, #0x1, #0x17
    MOVN  W13, #0x9975, LSL #16
    SUB  X9, X19, #0x31, LSL #12
    ADC  W29, W21, W22
    ADC  W29, W14, W24
    ADDS  W22, W29, W15, SXTH #2
    LSLV  X12, X5, X28
    SBFM  X2, X16, #0x12, #0x12
    ORN  W3, W12, W16, LSL #5
    SUB  X15, X14, W17, SXTW #0
    ADDS  X10, X28, W5, SXTH #3
    UMSUBL  X16, W21, W5, X23
    EXTR  X9, X20, X3, #0x3d
    ADD  X13, X19, X12, LSR #21
    ORR  V29.8B, V11.8B, V18.8B
    ADDS  W2, W12, W27, ASR #21
    CSNEG  W10, W24, W27, GT
    MOVZ  W12, #0xdf50, LSL #0
    AND  W9, W27, W24, LSL #1
    ADDS  W15, W6, W25, SXTB #3
    EXTR  W29, W27, W5, #0xd
    CLS  V4.4H, V13.4H
    BIC  X9, X13, X8, LSR #12
    CSEL  W22, W16, W12, VS
    CLS  V26.8B, V18.8B
    ORR  V6.8H, #0x67
    CLS  W29, W19
    MOVK  X14, #0x405e, LSL #48
    ORR  X14, X21, #0x1fe000000000000
    CLS  W2, W24
    ADD  X20, X19, #0x648
    MADD  W28, W24, W16, W28
    BICS  X23, X13, X10, ROR #55
    ADC  W13, W25, W28
    ANDS  X29, X8, X3, ROR #45
    UBFM  W25, W6, #0x7, #0x1a
    CRC32CX  W26, W6, X21
    MOVN  W26, #0x3262, LSL #16
    ADDS  W17, W26, #0x231
    ADD  W25, W2, W25, UXTB #4
    UMSUBL  X13, W9, W27, X22
    SUB  W9, W25, #0x2d0
    CLZ  X20, X24
    AND  X17, X12, #0x3ffc0000000000
    AND  W28, W23, W9, LSR #23
    CSINC  W27, W24, W20, VS
    MOVN  X14, #0x255, LSL #32
    EOR  W28, W21, #0x40404040
    LSLV  W19, W21, W18
    SUBS  W13, W29, #0xea8, LSL #12
    CSEL  W28, W9, W23, NE
    CSNEG  X19, X3, X5, GT
    AND  X23, X26, X20, LSL #12
    UMADDL  X19, W17, W23, X21
    BICS  X4, X17, X2, LSR #2
    ADDS  X20, X23, X9, ASR #34
    ANDS  W9, W3, W4, LSR #12
    EON  X27, X3, X5, LSR #47
    UBFM  W26, W17, #0x4, #0xd
    CRC32B  W3, W8, W17
    BIC  V9.8B, V17.8B, V9.8B
    CRC32W  W4, W8, W5
    MOVN  X19, #0x6b98, LSL #48
    ANDS  X12, X25, #0xe3e3e3e3e3e3e3e3
    CLS  X23, X18
    CRC32H  W26, W9, W4
    SUB  X28, X3, X2, ASR #19
    CLS  X2, X21
    ADDS  W10, W5, W8, LSL #18
    BIC  V6.16B, V15.16B, V8.16B
    ADDS  W16, W25, W6, LSL #20
    ADDS  X3, X21, X2, ASR #62
    MOVK  X29, #0xdf09, LSL #16
    MOVN  X14, #0x8439, LSL #0
    UMADDL  X6, W14, W9, X27
    SUBS  W26, W5, W29, ASR #17
    CLZ  V5.16B, V1.16B
    SUBS  X12, X22, W3, SXTB #2
    ADD  X29, X12, W12, UXTH #0
    ANDS  W18, W29, #0xfffff803
    ORR  X18, X16, X20, ASR #14
    CLZ  X20, X17
    ANDS  X18, X19, X5, LSR #9
    BICS  W22, W14, W8, ROR #4
    SBFM  X12, X23, #0x0, #0x5
    CSINC  W27, W6, W10, VS
    UMULH  X10, X18, X5
    LSLV  W17, W7, W2
    ADD  W9, W26, #0x140, LSL #12
    SUBS  X2, X19, #0x17b, LSL #12
    AND  X26, X27, X7, ROR #54
    ADD  X5, X12, #0x898
    CRC32CX  W20, W3, X20
    MADD  X9, X18, X22, X19
    ANDS  W4, W8, #0x7fffffc
    LSRV  X21, X6, X10
    MOVK  X9, #0xe95f, LSL #48
    ORN  X17, X10, X22, LSR #49
    SUB  X6, X7, W8, UXTB #0
    BICS  X28, X20, X15, ASR #41
    AND  X27, X21, #0x3f3f3f3f3f3f3f3f
    AND  W21, W18, W2, ASR #22
    ADD  W26, W19, W25, UXTW #4
    ORR  V15.8B, V0.8B, V22.8B
    ADD  X16, X16, W15, SXTH #0
    EOR  X25, X21, X13, ASR #38
    UMADDL  X28, W5, W18, X9
    ASRV  W9, W6, W15
    ORR  W28, W24, W27, ASR #31
    BIC  V22.8B, V16.8B, V17.8B
    ORR  W2, W13, #0xffe1ffff
    SUB  X25, X22, #0x93d
    EXTR  X19, X24, X19, #0x33
    CSINV  X24, X25, X23, CC
    CLZ  V8.8H, V18.8H
    MADD  X9, X7, X14, X29
    UMULH  X17, X3, X25
    BIC  W10, W20, W24, LSL #30
    MOVN  X16, #0x6e09, LSL #48
    ORN  W13, W20, W15, LSL #1
    ADD  X17, X22, W10, SXTB #3
    SMSUBL  X3, W21, W8, X22
    SMSUBL  X5, W15, W28, X21
    SUB  X3, X29, #0xa91, LSL #12
    ORN  X24, X4, X20, LSR #15
    SUB  W25, W17, W15, UXTH #2
    MOVK  X16, #0x4cc2, LSL #0
    ADD  W21, W26, W18, LSL #30
    ANDS  W18, W15, W14, LSR #27
    EOR  X17, X17, #0xfefefefefefefefe
    LSLV  W3, W27, W28
    CSINC  X21, X13, X2, NE
    CSEL  X21, X6, X16, VC
    CRC32CB  W5, W7, W19
    LSRV  W20, W10, W2
    BIC  W15, W21, W7, LSL #6
    CSEL  X16, X4, X13, LS
    UMADDL  X20, W25, W16, X2
    ADDS  W15, W23, W8, UXTH #3
    SUB  X9, X15, X2, LSL #22
    SUBS  W9, W25, W9, SXTB #4
    ASRV  W12, W18, W7
    CLZ  W18, W5
    SUBS  W19, W13, W27, SXTH #1
    ADDS  W6, W4, W23, UXTW #0
    EOR  X23, X10, X14, LSR #14
    CLZ  X13, X28
    ORR  V25.16B, V0.16B, V30.16B
    SUBS  X24, X16, #0x246
    SBFM  X19, X19, #0x39, #0x7
    ADD  X17, X21, W19, UXTB #4
    BICS  X25, X28, X20, ROR #41
    SUBS  X20, X10, X29, LSL #37
    UMSUBL  X20, W24, W5, X28
    ADCS  X21, X14, X26
    SUBS  X19, X18, X9, LSR #22
    ADCS  X17, X12, X4
    LSRV  W3, W12, W22
    SUBS  W24, W14, W10, ASR #21
    CSNEG  W26, W21, W14, NE
    ADD  W20, W2, W28, ASR #11
    ADD  W7, W14, W3, UXTW #2
    ANDS  X18, X14, #0xfefffefffefffeff
    UBFM  W23, W4, #0x1e, #0xa
    EON  X22, X23, X8, LSR #44
    MOVK  X18, #0xda3a, LSL #0
    BICS  W25, W7, W8, ROR #30
    ADDS  X23, X7, X25, LSR #61
    SUB  X12, X23, W2, UXTW #3
    ADD  X13, X24, X22, LSL #14
    CRC32CX  W20, W15, X6
    CSINC  W25, W8, W26, NE
    BIC  V20.16B, V10.16B, V19.16B
    SUBS  W22, W17, W13, UXTH #1
    SBFM  W29, W6, #0x15, #0x9
    EOR  X29, X16, #0xfdfffffffdffffff
    EON  X23, X29, X23, ASR #20
    ASRV  W22, W10, W8
    ADD  W7, W17, W18, SXTH #4
    AND  X14, X27, X26, ROR #23
    SUBS  X8, X8, #0x1
    B.NE  TaishanIntAluP01_label_348
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xfff5, LSL #16
    SUB  X16, X29, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X4
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
    MOVZ  X23, #0x2448, LSL #0
    MOVK  X23, #0x784d, LSL #16
    SUB  X19, X23, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X13, #0x6, LSL #0
    SUB  X15, X13, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X18, #0xa3a0, LSL #0
    MOVK  X18, #0xfffd, LSL #16
    SUB  X24, X18, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X8
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X24, #0xc84d, LSL #0
    MOVK  X24, #0xaeff, LSL #16
    SUB  X6, X24, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x7bce, LSL #0
    MOVK  X9, #0x4f, LSL #16
    MOVK  X9, #0xfff9, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X21, X9, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X19, #0x6, LSL #0
    SUB  X12, X19, X13
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x2a00, LSL #32
    MOVK  X19, #0x3e39, LSL #48
    SUB  X18, X19, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X19, X14, X15
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X24, X28, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X18, #0xe426, LSL #0
    MOVK  X18, #0xd77f, LSL #16
    SUB  X4, X18, X22
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X5, #0x1, LSL #0
    SUB  X15, X5, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X13, #0x7cb5, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X22, X13, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x3f3f, LSL #32
    MOVK  X20, #0x3f3f, LSL #48
    SUB  X9, X20, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xfff5, LSL #16
    SUB  X9, X22, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
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
    MOVZ  X10, #0x14, LSL #0
TaishanIntAluP01_label_376:
    AND  W12, W17, #0xff
    UBFM  W9, W29, #0xd, #0x15
    CLZ  V20.4H, V1.4H
    SUBS  X3, X8, W21, UXTW #1
    SBFM  X16, X24, #0x38, #0x14
    ADDS  W22, W28, W28, LSL #14
    SBFM  W20, W3, #0x2, #0x1d
    MOVN  X15, #0xc41f, LSL #32
    ADCS  W12, W6, W18
    SBFM  X9, X9, #0x17, #0x32
    CLZ  V3.16B, V16.16B
    ORN  W14, W14, W10, LSR #28
    UBFM  W14, W25, #0x1f, #0x8
    SUB  W29, W23, W5, LSL #26
    EOR  W28, W12, #0xfffe3fff
    ADD  W21, W14, #0x70a
    ORR  V6.8B, V30.8B, V23.8B
    BICS  W21, W22, W26, LSL #2
    ADDS  X2, X12, X29, LSL #17
    CLZ  W21, W4
    ANDS  X21, X9, X10, ASR #53
    AND  W25, W24, #0xc1ffffff
    ADC  X3, X5, X25
    EON  W21, W8, W15, LSR #19
    SUBS  X6, X12, X17, UXTX #2
    BIC  X14, X3, X10, LSL #62
    ANDS  W16, W20, #0x1f8
    EXTR  X25, X17, X21, #0x3f
    SUB  X15, X24, X6, LSR #54
    CRC32CW  W14, W14, W27
    MOVZ  W15, #0xc79, LSL #0
    UBFM  W8, W22, #0x16, #0xe
    AND  X23, X12, #0xffe000ffffe000ff
    ANDS  X18, X6, X19, LSR #43
    ORR  V22.16B, V8.16B, V30.16B
    SUBS  W9, W23, W15, UXTW #4
    MOVN  X16, #0x9d97, LSL #48
    ADD  W3, W7, W2, SXTH #0
    SUB  W25, W12, W17, SXTH #1
    ADD  X3, X19, X28, LSL #30
    ASRV  X17, X23, X8
    ANDS  W24, W3, #0xf01fffff
    ORR  X17, X16, #0xf3f3f3f3f3f3f3f3
    SMSUBL  X25, W14, W5, X13
    ADD  X5, X25, X24, LSR #45
    ADDS  W14, W17, #0x2cb
    CLZ  X19, X5
    SUBS  X6, X14, #0x9d6
    ADDS  W23, W22, W28, UXTX #2
    EOR  X15, X17, X15, ASR #27
    AND  W9, W28, W18, LSR #26
    BIC  V14.8B, V8.8B, V13.8B
    ADDS  X7, X12, W24, SXTW #4
    ADDS  X17, X22, W19, SXTH #2
    CRC32CH  W29, W2, W8
    ADD  W18, W3, #0x645, LSL #12
    ASRV  X20, X17, X12
    CSINV  W2, W12, W27, LE
    EOR  W18, W7, W7, ROR #25
    SMADDL  X15, W25, W12, X12
    ASRV  W15, W14, W14
    ASRV  W6, W24, W7
    LSRV  W12, W9, W9
    BICS  W5, W17, W16, LSR #10
    SUB  W14, W21, W29, UXTX #0
    ADC  X18, X28, X23
    SMULH  X18, X27, X19
    CRC32X  W28, W12, X9
    AND  W9, W3, #0x80000fff
    UBFM  X9, X25, #0x2a, #0x5
    CRC32H  W13, W13, W19
    MADD  W7, W19, W10, W18
    MOVK  W29, #0x884b, LSL #16
    ANDS  X21, X8, X9, ASR #52
    ADD  W14, W7, #0xfa0
    UMADDL  X3, W26, W18, X16
    ADDS  W14, W16, W22, UXTH #0
    BIC  V18.8B, V8.8B, V16.8B
    ORR  X12, X3, #0xfe000007fe000007
    CRC32CB  W17, W7, W18
    CRC32B  W12, W27, W24
    ADDS  W14, W20, W23, UXTH #1
    ORR  W8, W12, #0xc00fc00f
    EXTR  X17, X13, X25, #0xe
    SUB  X3, X13, X3, ASR #61
    CLS  X3, X24
    ANDS  W23, W6, W2, ASR #17
    BIC  W8, W16, W28, LSL #10
    CSINV  W28, W3, W6, EQ
    CSINV  X13, X13, X25, NE
    ADDS  X29, X17, W14, UXTH #3
    SBFM  W18, W19, #0x19, #0x14
    ORN  X18, X13, X9, LSL #4
    CSINC  X21, X24, X15, LE
    CRC32B  W29, W17, W21
    CRC32CH  W16, W29, W5
    EOR  W14, W24, #0xfc1ffc1f
    CRC32W  W4, W14, W2
    EXTR  X9, X7, X12, #0x1
    CRC32H  W27, W10, W6
    SMULH  X15, X23, X20
    ADCS  X2, X8, X16
    BIC  X5, X4, X19, ROR #20
    ANDS  X20, X24, X21, LSL #50
    CLS  V7.16B, V22.16B
    CRC32H  W17, W18, W23
    ADD  X23, X28, W9, UXTW #1
    ADCS  X15, X19, X24
    SUBS  X6, X12, X2, ASR #44
    ASRV  X15, X19, X14
    CLS  W15, W5
    CLZ  V6.2S, V8.2S
    ADC  X29, X24, X15
    ORR  V19.16B, V11.16B, V7.16B
    MADD  W29, W29, W7, W17
    SUB  W5, W8, W9, LSL #12
    EOR  W28, W7, #0xffe1ffff
    SUB  X26, X15, #0x0
    ADDS  X15, X22, W4, SXTH #0
    EXTR  W4, W9, W9, #0x3
    ADCS  X4, X13, X26
    LSRV  W4, W5, W20
    LSLV  W21, W2, W5
    SMSUBL  X24, W6, W8, X6
    ADDS  X22, X15, X27, LSR #31
    LSLV  W29, W24, W22
    LSLV  W6, W10, W9
    CRC32CH  W23, W12, W3
    CLZ  V16.16B, V12.16B
    SUB  W2, W22, #0x8b7
    CLZ  V5.16B, V6.16B
    UBFM  X28, X4, #0x3d, #0xb
    SUBS  X15, X10, W21, UXTH #2
    ADDS  W23, W6, W6, LSR #8
    MOVN  W23, #0xa606, LSL #0
    SUBS  X22, X2, #0xcae, LSL #12
    CLZ  X29, X23
    ADCS  W16, W9, W19
    UBFM  X15, X20, #0x33, #0x1f
    EON  X22, X20, X28, ROR #19
    CSEL  X14, X9, X26, VS
    ADDS  X14, X14, #0xef9
    CRC32CW  W18, W6, W27
    SUB  X7, X15, #0xb7b, LSL #12
    MOVK  X29, #0x176f, LSL #48
    CRC32X  W5, W14, X5
    ADD  W3, W4, W6, SXTX #2
    SUBS  W2, W4, W7, UXTH #2
    MOVZ  X3, #0x1a1d, LSL #0
    SBFM  X25, X3, #0x17, #0x24
    CSINC  W19, W19, W18, LE
    CSEL  X16, X8, X10, GE
    ORN  W18, W5, W22, LSL #31
    BIC  X16, X18, X19, LSR #57
    MOVN  W26, #0xf1b2, LSL #16
    ADDS  X26, X9, #0x70b
    CRC32CX  W23, W26, X25
    SMSUBL  X2, W22, W26, X26
    SUB  W19, W10, W16, SXTX #2
    BIC  W23, W16, W19, ROR #11
    ORN  W3, W12, W29, LSR #20
    SMADDL  X20, W3, W23, X3
    SUBS  W8, W5, W5, ASR #23
    ADCS  X28, X17, X17
    MOVZ  X23, #0xea96, LSL #48
    MADD  W9, W10, W21, W2
    CLS  W20, W4
    ADD  X26, X3, X6, SXTX #0
    MOVZ  W27, #0xda87, LSL #0
    CLZ  X8, X29
    SUBS  X25, X8, X18, LSL #17
    ORR  V6.2S, #0x1f, LSL #8
    ORR  X4, X15, #0x8000001f8000001f
    CSINC  W19, W27, W28, NE
    SUBS  X25, X16, #0x3df, LSL #12
    MOVK  X21, #0xc938, LSL #16
    CRC32CW  W26, W9, W26
    SUB  X7, X15, W22, UXTW #1
    SUBS  X29, X4, X15, ASR #8
    LSRV  X6, X10, X21
    CSINC  X16, X16, X18, LS
    CRC32CH  W3, W29, W14
    ORR  V26.4H, #0xa0
    EOR  W28, W17, #0xfffff87f
    SUBS  W25, W13, W6, SXTX #4
    CSINC  W2, W9, W5, PL
    CRC32B  W28, W9, W8
    LSLV  X19, X27, X28
    EOR  X22, X21, X25, ROR #44
    CSNEG  W17, W27, W24, MI
    ADC  X27, X29, X3
    ADD  W26, W6, W25, UXTH #2
    CLS  W29, W7
    ANDS  X25, X12, #0xfffe0000000
    SUB  W27, W27, W4, ASR #18
    MOVN  X7, #0x1c5e, LSL #0
    LSRV  W5, W27, W22
    ADD  W6, W18, W8, UXTX #4
    SUBS  X19, X4, W22, SXTH #1
    BIC  W21, W17, W9, ROR #27
    SUBS  X10, X10, #0x1
    B.NE  TaishanIntAluP01_label_376
    MOVZ  X3, #0xcc7f, LSL #0
    MOVK  X3, #0xfb6c, LSL #16
    SUB  X8, X3, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X6, #0xcc7f, LSL #0
    MOVK  X6, #0xfb6c, LSL #16
    SUB  X15, X6, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X10, #0x1f, LSL #0
    MOVK  X10, #0x8000, LSL #16
    MOVK  X10, #0x1f, LSL #32
    MOVK  X10, #0x8000, LSL #48
    SUB  X6, X10, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
    MOVZ  X14, #0x3993, LSL #0
    MOVK  X14, #0xa0f, LSL #16
    SUB  X23, X14, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP01_TestFail
    MOVZ  X26, #0xe3a1, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X25, X26, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X8
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X19, #0x1a4e, LSL #0
    MOVK  X19, #0x6de3, LSL #16
    SUB  X5, X19, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X5, #0x1f, LSL #0
    MOVK  X5, #0x8000, LSL #16
    MOVK  X5, #0x1f, LSL #32
    MOVK  X5, #0x8000, LSL #48
    SUB  X15, X5, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X7, #0xc39, LSL #0
    MOVK  X7, #0x6de3, LSL #16
    SUB  X23, X7, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP01_TestFail
    MOVZ  X21, #0x3993, LSL #0
    MOVK  X21, #0xa0f, LSL #16
    SUB  X24, X21, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X10, X18, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X15, #0x1a4e, LSL #0
    MOVK  X15, #0x6de3, LSL #16
    SUB  X18, X15, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x2, LSL #0
    SUB  X13, X9, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X16, #0x3993, LSL #0
    MOVK  X16, #0xa0f, LSL #16
    SUB  X26, X16, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x9e68, LSL #16
    MOVK  X3, #0xb9e2, LSL #32
    MOVK  X3, #0xf, LSL #48
    SUB  X23, X3, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X8, X24, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X24
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X18, X3, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X26
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X4, #0x3993, LSL #0
    MOVK  X4, #0xa0f, LSL #16
    SUB  X15, X4, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP01_TestFail
    MOVZ  X16, #0x1d, LSL #0
    SUB  X18, X16, X29
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP01_TestFail
    MOVZ  X2, #0xabf0, LSL #0
    MOVK  X2, #0x39b1, LSL #16
    MOVK  X2, #0x7edc, LSL #32
    MOVK  X2, #0x2ed3, LSL #48
    MOVZ  X3, #0xe4b5, LSL #0
    MOVK  X3, #0xa7da, LSL #16
    MOVK  X3, #0x357f, LSL #32
    MOVK  X3, #0x5fc9, LSL #48
    MOVZ  X4, #0xbda8, LSL #0
    MOVK  X4, #0xa9f6, LSL #16
    MOVK  X4, #0x3aae, LSL #32
    MOVK  X4, #0x4a00, LSL #48
    MOVZ  X5, #0x8233, LSL #0
    MOVK  X5, #0x5c4a, LSL #16
    MOVK  X5, #0xbb21, LSL #32
    MOVK  X5, #0xfecc, LSL #48
    MOVZ  X6, #0x21fd, LSL #0
    MOVK  X6, #0x6947, LSL #16
    MOVK  X6, #0x54ab, LSL #32
    MOVK  X6, #0x9ee5, LSL #48
    MOVZ  X7, #0xeb19, LSL #0
    MOVK  X7, #0x79fa, LSL #16
    MOVK  X7, #0x8212, LSL #32
    MOVK  X7, #0x3c69, LSL #48
    MOVZ  X8, #0xbb2f, LSL #0
    MOVK  X8, #0x66fe, LSL #16
    MOVK  X8, #0x4b99, LSL #32
    MOVK  X8, #0x87c0, LSL #48
    MOVZ  X9, #0x7a96, LSL #0
    MOVK  X9, #0x6ed5, LSL #16
    MOVK  X9, #0x65ac, LSL #32
    MOVK  X9, #0x75d7, LSL #48
    MOVZ  X10, #0xc337, LSL #0
    MOVK  X10, #0x5328, LSL #16
    MOVK  X10, #0x99a8, LSL #32
    MOVK  X10, #0x646c, LSL #48
    MOVZ  X12, #0x61d8, LSL #0
    MOVK  X12, #0x681, LSL #16
    MOVK  X12, #0x1e02, LSL #32
    MOVK  X12, #0xe13a, LSL #48
    MOVZ  X13, #0x7d3e, LSL #0
    MOVK  X13, #0xe3f0, LSL #16
    MOVK  X13, #0xfb42, LSL #32
    MOVK  X13, #0x7485, LSL #48
    MOVZ  X14, #0xc9c, LSL #0
    MOVK  X14, #0x3f12, LSL #16
    MOVK  X14, #0xbdeb, LSL #32
    MOVK  X14, #0xa029, LSL #48
    MOVZ  X15, #0x74a5, LSL #0
    MOVK  X15, #0x9edd, LSL #16
    MOVK  X15, #0x46d6, LSL #32
    MOVK  X15, #0x85fe, LSL #48
    MOVZ  X16, #0x40e, LSL #0
    MOVK  X16, #0x7d9f, LSL #16
    MOVK  X16, #0x3f6f, LSL #32
    MOVK  X16, #0x65b7, LSL #48
    MOVZ  X17, #0x8d22, LSL #0
    MOVK  X17, #0xaba9, LSL #16
    MOVK  X17, #0x9f50, LSL #32
    MOVK  X17, #0x354e, LSL #48
    MOVZ  X18, #0x9d55, LSL #0
    MOVK  X18, #0xc5d4, LSL #16
    MOVK  X18, #0x50b, LSL #32
    MOVK  X18, #0xdd59, LSL #48
    MOVZ  X19, #0x93d8, LSL #0
    MOVK  X19, #0x3997, LSL #16
    MOVK  X19, #0x91f, LSL #32
    MOVK  X19, #0x4ca5, LSL #48
    MOVZ  X20, #0x7dc1, LSL #0
    MOVK  X20, #0x2ec8, LSL #16
    MOVK  X20, #0x3501, LSL #32
    MOVK  X20, #0x9e49, LSL #48
    MOVZ  X21, #0x381a, LSL #0
    MOVK  X21, #0xf589, LSL #16
    MOVK  X21, #0x73ab, LSL #32
    MOVK  X21, #0xb5f0, LSL #48
    MOVZ  X22, #0x9967, LSL #0
    MOVK  X22, #0x4e9f, LSL #16
    MOVK  X22, #0x5e52, LSL #32
    MOVK  X22, #0x5cc4, LSL #48
    MOVZ  X23, #0xb9aa, LSL #0
    MOVK  X23, #0x9ebc, LSL #16
    MOVK  X23, #0x383e, LSL #32
    MOVK  X23, #0x9e9, LSL #48
    MOVZ  X24, #0xa145, LSL #0
    MOVK  X24, #0xba2f, LSL #16
    MOVK  X24, #0x668c, LSL #32
    MOVK  X24, #0x536c, LSL #48
    MOVZ  X25, #0xa44f, LSL #0
    MOVK  X25, #0x4773, LSL #16
    MOVK  X25, #0x34d1, LSL #32
    MOVK  X25, #0xedb0, LSL #48
    MOVZ  X26, #0xb398, LSL #0
    MOVK  X26, #0xb08c, LSL #16
    MOVK  X26, #0x435, LSL #32
    MOVK  X26, #0x831f, LSL #48
    MOVZ  X27, #0x8375, LSL #0
    MOVK  X27, #0x86bf, LSL #16
    MOVK  X27, #0x4d16, LSL #32
    MOVK  X27, #0xf64f, LSL #48
    MOVZ  X28, #0x9dcd, LSL #0
    MOVK  X28, #0x5ff6, LSL #16
    MOVK  X28, #0xe67e, LSL #32
    MOVK  X28, #0x445b, LSL #48
    MOVZ  X29, #0x3f20, LSL #0
    MOVK  X29, #0xa1bf, LSL #16
    MOVK  X29, #0x418b, LSL #32
    MOVK  X29, #0xe4c0, LSL #48
    MOVZ  X9, #0xa, LSL #0
TaishanIntAluP01_label_402:
    ADC  X28, X13, X7
    ADCS  W26, W19, W28
    ADCS  X18, X27, X29
    CSINV  X13, X20, X25, LT
    ADDS  W13, W18, W18, SXTX #2
    CRC32CH  W4, W5, W24
    LSLV  W7, W10, W18
    ADD  W14, W9, W5, ASR #29
    EON  W16, W26, W27, LSR #16
    SUBS  W20, W13, #0xa5f, LSL #12
    SUB  W28, W3, W28, UXTX #3
    UBFM  W14, W19, #0x17, #0x1e
    ASRV  W24, W8, W20
    ORR  X28, X15, X7, ROR #28
    CSINV  X25, X15, X5, CS
    ADD  X10, X28, X17, UXTX #3
    AND  X25, X2, X9, LSR #31
    ADDS  X19, X25, X6, UXTX #3
    CSINV  X26, X18, X15, MI
    ANDS  W2, W3, W5, LSR #4
    LSRV  X2, X19, X4
    ADDS  X19, X16, X23, UXTX #1
    UBFM  X7, X22, #0xa, #0x32
    CLZ  W8, W15
    ADC  X7, X12, X2
    CLZ  X7, X29
    AND  X3, X21, X22, ASR #19
    UMSUBL  X20, W7, W3, X6
    CSINV  X20, X9, X20, LS
    EON  X8, X15, X8, LSR #28
    ANDS  W6, W25, #0x1f800000
    BIC  X10, X27, X9, LSL #6
    SUBS  X20, X15, X5, LSR #10
    MOVN  X26, #0x645c, LSL #32
    LSRV  W24, W17, W8
    CSEL  W12, W27, W28, MI
    SUB  W4, W6, W7, ASR #2
    UBFM  W24, W12, #0x3, #0x15
    SUB  X27, X13, W20, UXTW #4
    SUB  X18, X28, X8, ASR #50
    ADD  W6, W19, #0xe26
    CSNEG  X20, X2, X20, HI
    ORN  W25, W2, W7, LSR #29
    ADD  X12, X25, #0xbc7, LSL #12
    CLZ  V16.8B, V15.8B
    CLS  X8, X14
    SUBS  W18, W9, #0xec3, LSL #12
    SUB  W14, W22, #0x9ad
    CRC32CB  W8, W17, W19
    ADDS  X8, X5, X4, LSL #4
    SUB  X15, X2, X8, LSL #33
    CRC32B  W20, W2, W14
    SUBS  W13, W2, #0xdb5
    SUB  X22, X4, #0x0
    BIC  X23, X10, X4, LSL #28
    CRC32H  W28, W16, W10
    CRC32B  W21, W16, W23
    SUBS  W20, W5, #0xd02
    SUB  W6, W7, #0x27f
    CLZ  X13, X22
    SUB  X19, X8, W23, SXTB #2
    SUB  X8, X13, W20, UXTW #2
    AND  W28, W9, #0xfffffbff
    CSEL  X10, X5, X16, LT
    ORN  W6, W18, W5, ASR #7
    MOVK  W13, #0xc407, LSL #16
    SBFM  W29, W12, #0x13, #0x5
    CSEL  X2, X9, X23, EQ
    MOVZ  W5, #0x67ed, LSL #0
    EOR  W8, W8, W12, LSL #20
    ADDS  W5, W25, #0x59c
    ADD  X14, X5, X6, SXTX #3
    LSLV  W13, W16, W6
    SUB  X19, X29, X19, ASR #38
    SMULH  X4, X27, X9
    SUB  W15, W25, W17, ASR #22
    EXTR  W14, W10, W27, #0x5
    SMSUBL  X15, W2, W19, X17
    EXTR  X21, X19, X25, #0x36
    CSINV  W28, W19, W9, HI
    MOVN  X3, #0xfe33, LSL #32
    CLZ  V3.2S, V20.2S
    ORN  W15, W17, W8, LSL #8
    CSNEG  W16, W20, W16, LS
    ADD  X20, X17, X3, LSR #44
    SUBS  W3, W5, #0x7e8
    ASRV  W12, W28, W14
    BICS  X25, X15, X6, LSL #1
    ADDS  W2, W2, #0x180
    ADD  W22, W29, #0x23f, LSL #12
    CSEL  X12, X8, X14, VS
    UMSUBL  X3, W17, W23, X26
    SMULH  X13, X5, X26
    SUBS  W17, W25, W2, ASR #30
    CLZ  V27.2S, V15.2S
    CSNEG  W19, W5, W8, VS
    BICS  X27, X9, X19, ASR #22
    SBFM  X27, X7, #0x20, #0x2d
    ANDS  W23, W13, W27, LSR #28
    ORR  V29.2S, #0x2f, LSL #24
    UMADDL  X27, W22, W8, X28
    ORN  X28, X9, X10, LSL #47
    SMADDL  X17, W5, W7, X16
    SMSUBL  X6, W21, W22, X16
    LSLV  W4, W24, W25
    ASRV  X13, X23, X19
    AND  X5, X13, X22, ROR #61
    CRC32CW  W10, W27, W18
    MOVN  W6, #0x5881, LSL #0
    SUBS  W28, W4, W26, SXTB #2
    ADCS  W16, W4, W26
    ASRV  X7, X21, X26
    ADCS  W19, W22, W22
    CSINC  X12, X26, X14, PL
    UBFM  W21, W6, #0x11, #0x12
    CRC32CX  W3, W3, X23
    EON  W10, W15, W5, LSL #30
    SUB  X12, X23, X4, ASR #16
    ANDS  X4, X22, #0x7ff07ff07ff07ff0
    SUBS  X4, X12, W18, SXTW #0
    ADDS  X26, X10, X16, ASR #45
    CLZ  W8, W6
    CLS  V11.8B, V24.8B
    BIC  X21, X22, X15, LSL #27
    SUB  W8, W10, W15, UXTH #0
    CSEL  W21, W29, W9, GT
    SBFM  W19, W12, #0x4, #0x10
    ANDS  W18, W23, W17, LSL #8
    BICS  W27, W7, W7, LSL #23
    ADDS  W5, W22, W17, UXTB #1
    CRC32W  W25, W13, W24
    LSRV  X28, X19, X4
    CSINC  X13, X21, X3, VC
    CSINC  W21, W21, W7, EQ
    UBFM  W13, W22, #0x1e, #0x10
    BICS  X6, X5, X18, ROR #0
    UBFM  X28, X21, #0x28, #0x7
    ADDS  W27, W3, #0xba0
    ORR  V24.2S, #0x29, LSL #8
    LSLV  X4, X26, X19
    MOVN  X10, #0xe897, LSL #48
    MOVZ  X19, #0x5a24, LSL #16
    MOVK  W17, #0xcedd, LSL #16
    SBFM  X19, X17, #0x33, #0x2d
    SUBS  W19, W10, W28, ASR #29
    EOR  X26, X22, X13, ASR #31
    CSEL  X20, X8, X14, AL
    SUBS  X25, X26, X6, ASR #16
    ADD  W22, W23, W10, LSL #1
    ADDS  X5, X13, X26, ASR #35
    ADC  W24, W29, W28
    EON  W14, W19, W26, ROR #13
    BICS  W14, W25, W22, LSL #7
    ORN  X29, X18, X15, LSL #21
    LSLV  W7, W16, W10
    CLZ  W29, W20
    ADDS  W16, W24, W14, SXTX #4
    SUB  W23, W21, W5, ASR #28
    ORR  V27.2S, #0x4d, LSL #16
    SUBS  W17, W17, W2, SXTX #0
    ASRV  W23, W8, W28
    SUBS  X10, X15, X20, LSL #20
    UMULH  X21, X24, X5
    MOVZ  W2, #0x867b, LSL #16
    MOVK  X8, #0x1ed8, LSL #32
    ANDS  X14, X2, X23, LSR #43
    CRC32CX  W28, W21, X6
    ADD  W5, W5, W28, SXTW #3
    ANDS  X19, X20, X20, ROR #60
    UBFM  W15, W19, #0x1f, #0x19
    UBFM  X19, X6, #0x5, #0x3b
    ANDS  W4, W17, W5, LSR #10
    CRC32CX  W24, W7, X18
    EOR  X4, X20, X29, LSL #53
    SMSUBL  X4, W8, W18, X4
    CSINC  W20, W7, W24, LT
    EOR  X20, X20, #0xc000c000c000c0
    ADCS  X5, X14, X5
    MOVN  X5, #0xc152, LSL #16
    EOR  X25, X10, X10, LSL #11
    ADCS  X5, X19, X5
    SUB  X3, X5, X5, SXTX #1
    ANDS  W18, W6, W4, ROR #5
    ADD  W2, W13, #0x48f
    CSNEG  X24, X23, X22, VS
    ORR  V14.2S, #0xc8
    EOR  X23, X4, #0xffff0003ffff0003
    CLS  X16, X9
    ANDS  W4, W7, W7, ROR #5
    CRC32CH  W17, W19, W7
    MOVK  X28, #0x4b5, LSL #16
    ADD  X25, X2, W2, SXTH #4
    ADDS  X2, X4, X21, LSL #54
    SUB  W29, W26, W13, UXTB #4
    SMSUBL  X10, W25, W28, X29
    ASRV  W3, W17, W3
    ADD  X15, X24, #0x926, LSL #12
    SUBS  X13, X20, X21, LSL #40
    UBFM  W18, W5, #0xc, #0xf
    ANDS  W21, W17, W2, LSL #7
    SUBS  X9, X9, #0x1
    B.NE  TaishanIntAluP01_label_402
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X28, #0xf87d, LSL #0
    MOVK  X28, #0xffff, LSL #16
    SUB  X26, X28, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X7, #0x1e8c, LSL #0
    MOVK  X7, #0x3eaf, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X17, X7, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP01_TestFail
    MOVZ  X10, #0xd1a2, LSL #0
    MOVK  X10, #0x23, LSL #16
    SUB  X26, X10, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x1e8c, LSL #0
    MOVK  X6, #0x3eaf, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X15, X6, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x1801, LSL #0
    MOVK  X20, #0x2109, LSL #16
    MOVK  X20, #0x1ed8, LSL #32
    SUB  X13, X20, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X2, #0xd1a2, LSL #0
    MOVK  X2, #0x23, LSL #16
    SUB  X13, X2, X10
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X12
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X16, X21, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X29, X26, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X18, X9, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x1e8d, LSL #0
    MOVK  X2, #0x1, LSL #16
    SUB  X14, X2, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP01_TestFail
    MOVZ  X4, #0x1801, LSL #0
    MOVK  X4, #0x2109, LSL #16
    MOVK  X4, #0x1ed8, LSL #32
    SUB  X9, X4, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X20, #0xfffe, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X6, X20, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x2, LSL #0
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X13, X6, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X29, X26, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X10, X24, X29
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
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
    MOVZ  X29, #0xa, LSL #0
TaishanIntAluP01_label_428:
    SMADDL  X21, W5, W6, X4
    SUBS  W26, W27, W7, UXTH #4
    CRC32X  W25, W26, X29
    MOVK  X16, #0xd433, LSL #32
    UBFM  W14, W23, #0x8, #0x1c
    SUBS  W27, W13, W25, LSR #20
    SUBS  X8, X20, W26, SXTB #1
    ADD  W26, W12, W14, LSL #29
    ASRV  X24, X13, X23
    SBFM  X2, X4, #0x5, #0x2e
    ADDS  X8, X16, W28, SXTW #3
    AND  X22, X21, X7, ROR #19
    CLZ  X16, X26
    CLZ  V18.8H, V0.8H
    CRC32H  W19, W5, W16
    ORR  V10.4S, #0xc5, LSL #16
    UMADDL  X7, W5, W9, X26
    UBFM  X26, X20, #0xa, #0xc
    ORR  V19.4H, #0x8f, LSL #8
    MOVZ  W4, #0x24f5, LSL #16
    ADD  X7, X21, #0x510
    EXTR  W26, W21, W9, #0x1b
    CLZ  X22, X20
    ORR  V31.4S, #0x7d, LSL #16
    ANDS  X23, X12, #0xfff80000fff800
    ANDS  X12, X25, X17, ROR #27
    EOR  W5, W2, #0xff0fffff
    CSNEG  W9, W17, W2, NE
    ADD  W22, W4, W23, ASR #12
    ASRV  W9, W5, W16
    BIC  W25, W12, W20, ROR #5
    CRC32B  W2, W10, W3
    ADD  W23, W2, W4, LSR #6
    ORR  V9.4S, #0x33, LSL #8
    SUB  X24, X29, X2, LSL #14
    ORR  X7, X26, #0x7f8000007f800000
    ADDS  X2, X16, X25, UXTX #1
    ADDS  X3, X19, #0x3e0
    AND  W15, W29, W27, ROR #18
    MOVZ  X17, #0x6085, LSL #32
    SUBS  W5, W29, W16, ASR #31
    ADDS  X9, X18, W12, UXTH #0
    ASRV  X26, X10, X29
    ORR  W17, W24, #0xf80007ff
    MOVN  W16, #0x123a, LSL #0
    CRC32CH  W26, W20, W20
    EXTR  X13, X15, X16, #0xe
    SUBS  W3, W22, W8, LSR #3
    ORR  V27.8H, #0xaf, LSL #8
    ORR  W25, W17, #0x7ffff0
    CSEL  W13, W9, W3, CS
    ORN  X8, X25, X18, ASR #52
    ADDS  W26, W6, #0xe1
    CLS  X23, X13
    ORR  W5, W19, #0xffe0000f
    ADD  X9, X19, #0x134, LSL #12
    ADD  X26, X8, X16, ASR #46
    SUB  X6, X3, X5, ASR #11
    EOR  W23, W17, #0xfeffffff
    EOR  X21, X15, #0x1c0000001c
    EXTR  W14, W5, W4, #0x2
    SUB  W26, W9, W7, ASR #17
    UMSUBL  X24, W14, W13, X9
    CRC32X  W5, W20, X22
    CLZ  W6, W23
    SUBS  X17, X6, W10, UXTH #1
    ADCS  W18, W2, W24
    CLZ  W12, W9
    BIC  X26, X12, X4, ROR #35
    CRC32B  W22, W9, W12
    CRC32H  W19, W25, W21
    SMSUBL  X5, W27, W18, X7
    SMADDL  X20, W5, W25, X19
    CSEL  X17, X3, X26, LE
    ORR  W17, W15, #0x3fe00
    MADD  X6, X6, X20, X20
    ASRV  W10, W26, W17
    ASRV  X24, X8, X17
    CSINC  X16, X26, X15, NE
    CRC32W  W16, W6, W21
    EXTR  W7, W7, W10, #0x4
    CLS  V2.4H, V31.4H
    ADC  W23, W6, W21
    ADD  X6, X21, W25, UXTW #0
    CRC32CB  W6, W7, W15
    EOR  X3, X3, X10, LSL #2
    ADDS  X3, X18, X6, LSR #60
    UBFM  W6, W21, #0x7, #0xd
    MOVZ  X5, #0x2166, LSL #0
    CLZ  X16, X16
    CLZ  V11.4H, V17.4H
    ADD  W27, W9, W21, SXTH #3
    CRC32X  W6, W20, X26
    AND  X28, X13, X29, LSL #12
    AND  X23, X21, X28, LSR #33
    ORR  V5.8B, V10.8B, V14.8B
    CSNEG  W24, W14, W24, GT
    ORR  V0.4S, #0xc4, LSL #16
    ASRV  X23, X22, X16
    ADDS  W7, W5, W7, LSR #18
    ANDS  X25, X25, #0x1ffffffffe
    ADD  W18, W2, W7, ASR #18
    EOR  W7, W25, W22, LSR #22
    SUBS  X10, X3, X23, LSL #27
    CLZ  V12.2S, V24.2S
    ORR  W14, W2, #0xff83ff83
    MOVN  X5, #0x205f, LSL #32
    LSRV  X12, X22, X18
    EOR  X5, X13, #0xffffffc0000001ff
    SUB  X9, X27, X12, LSR #22
    CLS  W25, W13
    ADD  X25, X15, X28, LSR #4
    MOVZ  W22, #0xc25f, LSL #0
    ADCS  W19, W17, W20
    MOVZ  X13, #0x1be, LSL #16
    EOR  W22, W25, #0x30303030
    MOVZ  X19, #0x7b24, LSL #16
    CRC32CX  W15, W17, X19
    AND  W21, W24, #0xf800f800
    SUBS  W10, W10, #0xc85
    SUBS  X15, X21, X18, SXTX #3
    ORR  X13, X5, X19, LSL #56
    LSLV  W27, W7, W15
    EXTR  X7, X6, X25, #0x2d
    ORR  V25.8B, V25.8B, V1.8B
    CSINV  X25, X8, X2, CS
    EOR  W5, W18, W10, ROR #2
    CSINC  X13, X22, X28, NV
    MOVN  X28, #0x17b1, LSL #48
    CLZ  W3, W28
    BIC  W15, W27, W26, LSR #31
    ORR  X8, X7, #0xffffffffe00007ff
    BICS  W6, W13, W10, LSL #2
    CSINV  W18, W9, W25, LS
    ADD  X5, X12, #0xe80
    CRC32CW  W12, W21, W6
    ADD  X9, X6, W15, UXTB #0
    ORR  V19.8B, V31.8B, V9.8B
    ADD  X3, X29, X3, ASR #47
    ADCS  W4, W8, W2
    UMSUBL  X20, W22, W12, X10
    ANDS  W25, W3, #0x77777777
    LSLV  X9, X9, X20
    SBFM  X9, X29, #0x3, #0x2f
    ADC  X4, X4, X9
    ORR  X28, X15, #0xfffc0007fffc0007
    CSEL  W19, W5, W21, MI
    ADCS  X7, X21, X19
    SUB  W28, W8, #0x7a9, LSL #12
    SUB  W28, W14, #0xf4c, LSL #12
    ADD  X19, X15, W6, SXTW #4
    ORR  W13, W19, W3, LSR #3
    CRC32X  W15, W20, X28
    ADDS  W12, W2, W6, ASR #17
    ADC  X28, X21, X8
    ADDS  W18, W5, W27, ASR #19
    ORN  W13, W12, W15, LSR #15
    CRC32CH  W28, W9, W18
    ASRV  X3, X5, X27
    SUBS  X14, X18, X8, LSR #14
    UMSUBL  X13, W18, W5, X19
    EXTR  W26, W16, W22, #0x9
    MOVN  X2, #0x2c0f, LSL #16
    ADDS  W25, W22, W6, LSL #16
    BICS  X19, X6, X27, LSL #36
    SUBS  X20, X21, W7, UXTH #3
    CSINV  X7, X27, X6, GE
    LSRV  W18, W10, W23
    SUBS  W20, W26, W25, SXTB #1
    CLS  V2.16B, V1.16B
    ADD  X4, X26, W16, SXTH #3
    MOVN  W25, #0x76f1, LSL #0
    ADD  W10, W7, #0x102, LSL #12
    BIC  V17.8B, V25.8B, V19.8B
    CRC32CX  W21, W27, X10
    BICS  W28, W28, W20, ASR #0
    SUB  W4, W14, W28, ASR #20
    CRC32W  W27, W13, W22
    CSINC  X5, X29, X21, NE
    CSNEG  X9, X26, X13, VS
    ANDS  W4, W6, #0x1ffffffc
    CSNEG  X23, X21, X28, LS
    MOVZ  X15, #0x1d38, LSL #0
    ASRV  W4, W16, W5
    SUB  X4, X5, #0x1e6, LSL #12
    ANDS  X25, X9, X24
    ADCS  X5, X2, X18
    SUB  W27, W23, #0xa50
    ANDS  W2, W24, W17, LSR #12
    CSNEG  X5, X22, X26, VS
    ADDS  W15, W26, #0xee2
    ANDS  W5, W28, W29, ASR #3
    ADDS  X10, X4, W18, UXTH #3
    ORN  X4, X9, X12, ROR #26
    MOVN  W28, #0xf41c, LSL #16
    SUB  X20, X10, #0x1a0
    SMSUBL  X17, W18, W19, X12
    ANDS  X5, X27, #0x7fffffe
    CLZ  V15.16B, V29.16B
    CSINV  W8, W28, W2, MI
    SUBS  X29, X29, #0x1
    B.NE  TaishanIntAluP01_label_428
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X25, #0xe80, LSL #0
    SUB  X14, X25, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X15, X7, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X8, #0xa932, LSL #0
    MOVK  X8, #0x557, LSL #16
    SUB  X3, X8, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP01_TestFail
    MOVZ  X10, #0x1030, LSL #0
    MOVK  X10, #0x30, LSL #16
    SUB  X6, X10, X6
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X28, X15, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP01_TestFail
    MOVZ  X29, #0xa932, LSL #0
    MOVK  X29, #0x557, LSL #16
    SUB  X9, X29, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X15, X6, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X15, #0x1030, LSL #0
    MOVK  X15, #0x30, LSL #16
    SUB  X3, X15, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP01_TestFail
    MOVZ  X26, #0x1079, LSL #0
    MOVK  X26, #0x1, LSL #16
    SUB  X10, X26, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X4, #0x300, LSL #0
    MOVK  X4, #0x5d88, LSL #16
    SUB  X9, X4, X13
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X13, #0x1030, LSL #0
    MOVK  X13, #0x30, LSL #16
    SUB  X15, X13, X15
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x20, LSL #0
    SUB  X2, X9, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x8a79, LSL #0
    MOVK  X2, #0xe66e, LSL #16
    MOVK  X2, #0x6d06, LSL #32
    MOVK  X2, #0xfff1, LSL #48
    SUB  X5, X2, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x5820, LSL #0
    MOVK  X20, #0x4da0, LSL #16
    SUB  X26, X20, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X5, #0x1030, LSL #0
    MOVK  X5, #0x30, LSL #16
    SUB  X25, X5, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X12, #0x5820, LSL #0
    MOVK  X12, #0x4da0, LSL #16
    SUB  X21, X12, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP01_TestFail
    MOVZ  X23, #0x3030, LSL #0
    MOVK  X23, #0x3030, LSL #16
    SUB  X4, X23, X22
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
    MOVZ  X25, #0x3030, LSL #0
    MOVK  X25, #0x3030, LSL #16
    SUB  X9, X25, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
    MOVZ  X21, #0x3030, LSL #0
    MOVK  X21, #0x3030, LSL #16
    SUB  X23, X21, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X28, X7, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP01_TestFail
    MOVZ  X3, #0xa932, LSL #0
    MOVK  X3, #0x557, LSL #16
    SUB  X21, X3, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
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
    MOVZ  X5, #0x14, LSL #0
TaishanIntAluP01_label_455:
    ORR  V10.8H, #0x15, LSL #8
    ANDS  X25, X19, #0x40000000400000
    ORN  X20, X3, X7, ASR #17
    MADD  X25, X3, X29, X4
    CRC32B  W22, W25, W8
    ADDS  W24, W2, W13, LSR #19
    LSRV  X24, X20, X15
    CRC32B  W25, W29, W25
    ADD  W23, W5, W20, UXTW #0
    SUB  W21, W3, W5, LSR #11
    MOVZ  W17, #0x3596, LSL #0
    SUB  W19, W2, #0x780
    MADD  W16, W26, W10, W23
    UMSUBL  X28, W17, W9, X27
    CLZ  X28, X13
    CLZ  V1.2S, V22.2S
    CLS  V27.4H, V12.4H
    ADDS  X4, X19, W3, UXTH #1
    ADDS  X13, X22, #0xbf8
    ADDS  W25, W13, #0x3aa
    MOVZ  W19, #0xb2f5, LSL #16
    ADCS  W19, W2, W24
    SUBS  W6, W8, W16, LSR #30
    AND  X28, X22, #0x1f001f001f001f
    ORR  X19, X28, #0xf80000007fffffff
    ANDS  X19, X19, X21, ROR #59
    MADD  X20, X10, X27, X13
    ADD  X9, X21, X2, ASR #6
    SMULH  X17, X25, X24
    MADD  X2, X9, X19, X29
    ANDS  W20, W15, #0xc0c0c0c
    ORN  W22, W29, W14, ROR #5
    SUB  X21, X28, X5, UXTX #3
    EOR  X27, X17, #0xffdfffffffdfffff
    ADCS  X15, X27, X21
    SBFM  X27, X4, #0x1c, #0x10
    EON  W28, W25, W23, LSR #2
    CLZ  V24.2S, V21.2S
    SUBS  W28, W27, #0x216
    CSNEG  X22, X27, X20, LT
    AND  W21, W13, W25, ASR #19
    UMULH  X18, X8, X13
    EOR  W4, W9, W19, LSR #16
    CSEL  X2, X2, X17, GE
    LSRV  X9, X20, X5
    SUBS  X28, X21, X29, ASR #40
    ADD  X19, X7, #0x8ba
    UBFM  X21, X24, #0xb, #0x18
    CRC32H  W21, W7, W2
    ADDS  W14, W15, W23, SXTX #2
    LSRV  W16, W23, W18
    BIC  V7.8B, V0.8B, V14.8B
    BIC  X7, X8, X19, ROR #20
    EOR  X22, X18, #0xfff803ffffffffff
    SUBS  W4, W4, W8, ASR #5
    UMULH  X4, X14, X2
    ANDS  X3, X22, #0x7ffffff0
    EOR  W19, W17, #0x7fe07fe0
    BICS  W22, W6, W13, ASR #25
    ASRV  W4, W7, W3
    CRC32CH  W28, W19, W20
    SUBS  W28, W16, #0x456, LSL #12
    CRC32X  W24, W27, X15
    CSINC  W12, W10, W18, LS
    CRC32CH  W23, W29, W2
    ASRV  X3, X26, X17
    SUB  X22, X2, W9, UXTB #3
    SUBS  X8, X6, #0xf25
    ADDS  W17, W7, W21, UXTH #2
    CLS  W22, W4
    ASRV  W22, W15, W22
    MOVN  X13, #0xba90, LSL #0
    ORR  W16, W7, #0x3f803f8
    MOVK  W13, #0xed54, LSL #0
    CRC32W  W12, W3, W7
    ADDS  X19, X28, #0x2e8, LSL #12
    CRC32CX  W16, W24, X4
    MOVN  W29, #0x5fca, LSL #16
    SUBS  X8, X13, #0x948, LSL #12
    CSINV  X22, X10, X10, PL
    CRC32CX  W16, W23, X20
    ANDS  X10, X9, X15, ASR #46
    CSINC  X7, X29, X21, VC
    SUB  X3, X20, #0x85e, LSL #12
    MOVN  W6, #0x3c5d, LSL #0
    CLZ  V11.8B, V5.8B
    SBFM  X15, X21, #0xc, #0x32
    ADD  X10, X28, #0xe0
    SUBS  W10, W18, W28, UXTH #2
    ADDS  X4, X14, #0x419, LSL #12
    SUBS  X27, X21, X13, UXTX #0
    BIC  X24, X24, X24, ROR #36
    UBFM  X20, X5, #0x2f, #0x18
    UMSUBL  X12, W29, W5, X26
    ASRV  W29, W15, W25
    CRC32CX  W20, W8, X27
    MOVK  X10, #0x2cf9, LSL #32
    CSINV  X4, X27, X25, CC
    ORR  V30.8B, V27.8B, V1.8B
    MADD  W29, W3, W21, W28
    AND  W18, W2, #0x78007800
    CRC32W  W29, W16, W19
    ADDS  X20, X15, #0xc47, LSL #12
    ADD  X28, X7, X9, LSR #51
    CRC32H  W23, W9, W4
    ADC  X25, X18, X27
    MOVK  X21, #0xd3a3, LSL #0
    SUBS  W10, W24, #0x553
    SUBS  X18, X14, #0xf50, LSL #12
    LSRV  W18, W15, W22
    MOVN  W20, #0x34dc, LSL #16
    BIC  X4, X27, X2, LSL #12
    CLS  X15, X20
    CSEL  X20, X18, X7, GT
    ADD  W4, W18, W15, LSL #21
    CSINV  X9, X15, X16, NE
    SMULH  X13, X21, X29
    CSINV  X3, X20, X18, LE
    CSINV  X3, X29, X15, EQ
    ADDS  X16, X6, X25, LSL #29
    BICS  X29, X10, X2, LSL #19
    ASRV  X2, X14, X9
    AND  W19, W3, W24, ASR #1
    BIC  W10, W6, W20, ROR #0
    UBFM  X2, X6, #0x18, #0x3
    UMADDL  X22, W10, W6, X21
    ORR  V30.16B, V8.16B, V6.16B
    SUB  X15, X2, #0xa95
    ASRV  W3, W7, W18
    CLZ  V14.4S, V6.4S
    AND  W13, W28, W24, LSL #30
    SUBS  X29, X29, X7, LSL #50
    CLZ  V13.4S, V3.4S
    ADD  X9, X20, W28, UXTB #3
    CSNEG  W15, W22, W22, NE
    ORR  W14, W25, #0xf3fff3ff
    CLZ  V31.4H, V26.4H
    CRC32CH  W3, W22, W13
    LSLV  W10, W22, W6
    CRC32CW  W4, W18, W7
    CSEL  X20, X29, X9, HI
    CRC32CX  W8, W9, X26
    AND  X18, X18, X14, LSR #4
    CRC32X  W28, W2, X18
    SUBS  W23, W19, W28, ASR #14
    ORR  V11.8B, V9.8B, V8.8B
    UMADDL  X24, W5, W16, X9
    CRC32H  W20, W18, W24
    AND  W20, W21, W25, ROR #19
    UMSUBL  X29, W25, W23, X20
    ADCS  X3, X5, X10
    CRC32CX  W16, W22, X23
    EON  W3, W2, W15, LSL #12
    ORR  V3.4H, #0x91, LSL #8
    AND  W26, W26, #0xe7ffffff
    CSEL  W18, W29, W4, LE
    SUB  W24, W8, #0xbd0
    CLZ  V20.16B, V7.16B
    CRC32X  W24, W16, X13
    AND  X13, X27, #0xfffffffff00000ff
    EON  X20, X29, X25, LSR #12
    EON  X9, X8, X26, LSL #9
    ORR  X13, X12, #0xfffffffffc000000
    ADDS  W21, W21, W25, UXTW #1
    LSRV  X7, X15, X14
    EON  X3, X22, X9, ROR #15
    CRC32CB  W15, W27, W6
    CLZ  W28, W15
    AND  X14, X15, #0xffffffe7ffffffe7
    MADD  X20, X18, X18, X19
    ADDS  W25, W17, W5, LSL #9
    SBFM  X27, X20, #0x3a, #0x3b
    SUB  W24, W5, #0x10
    AND  X15, X12, X26, LSL #5
    EXTR  W24, W22, W28, #0x15
    CLS  V9.16B, V31.16B
    CRC32X  W16, W5, X10
    ORR  V10.4S, #0xa7, LSL #8
    EON  X18, X17, X16, LSL #25
    BIC  W7, W9, W9, LSR #26
    ANDS  W21, W16, #0xffff80ff
    SMADDL  X23, W28, W3, X4
    ORN  W16, W25, W2, ASR #29
    SMADDL  X22, W16, W2, X2
    AND  W22, W12, #0x1c1c1c1c
    LSLV  W21, W7, W16
    CSINC  X13, X29, X21, VC
    ADD  X23, X7, X20, ASR #22
    MOVN  X10, #0xef94, LSL #16
    SUB  W18, W16, #0x6cd
    MOVZ  X16, #0x9fe4, LSL #16
    ADDS  W22, W15, W26, LSL #6
    LSLV  X28, X18, X22
    MOVK  W2, #0x5324, LSL #16
    CSINV  W6, W29, W9, AL
    BICS  X15, X21, X27, ROR #11
    ADDS  W7, W13, #0x4b9
    CRC32H  W23, W14, W18
    ADDS  X2, X24, X12, ASR #54
    MOVZ  W14, #0x7dc7, LSL #0
    SUBS  X5, X5, #0x1
    B.NE  TaishanIntAluP01_label_455
    MOVZ  X22, #0x1800, LSL #0
    MOVK  X22, #0x5e9d, LSL #16
    SUB  X23, X22, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X18, #0x6df8, LSL #0
    MOVK  X18, #0x2bb4, LSL #16
    MOVK  X18, #0xe96a, LSL #32
    MOVK  X18, #0x4653, LSL #48
    SUB  X8, X18, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X14, #0x9d64, LSL #0
    MOVK  X14, #0x62b, LSL #16
    SUB  X6, X14, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
    MOVZ  X23, #0xdb9c, LSL #0
    MOVK  X23, #0xc42c, LSL #16
    SUB  X10, X23, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X8
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X26, #0x7332, LSL #0
    MOVK  X26, #0x20d2, LSL #16
    MOVK  X26, #0xfe30, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X10, X26, X9
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x47ca, LSL #16
    SUB  X18, X8, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP01_TestFail
    MOVZ  X7, #0xd6e3, LSL #0
    MOVK  X7, #0xc42c, LSL #16
    MOVK  X7, #0xfb8f, LSL #32
    MOVK  X7, #0xe4a4, LSL #48
    SUB  X13, X7, X13
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X24, #0x9d64, LSL #0
    MOVK  X24, #0x62b, LSL #16
    SUB  X9, X24, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x9fe4, LSL #16
    SUB  X18, X8, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP01_TestFail
    MOVZ  X23, #0x9da0, LSL #0
    MOVK  X23, #0x20d5, LSL #16
    SUB  X15, X23, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X18, #0x6fa0, LSL #0
    MOVK  X18, #0xc0ae, LSL #16
    SUB  X19, X18, X19
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X23, #0x3eb0, LSL #0
    MOVK  X23, #0xb10a, LSL #16
    MOVK  X23, #0x12cf, LSL #32
    MOVK  X23, #0x26, LSL #48
    SUB  X3, X23, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X22, X23, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X8, X24, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x7332, LSL #0
    MOVK  X8, #0x20d2, LSL #16
    MOVK  X8, #0xfe30, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X6, X8, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X21, X23, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X26, #0xf932, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X19, X26, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X3, X20, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x75c0, LSL #0
    MOVK  X2, #0x298f, LSL #16
    MOVK  X2, #0x3400, LSL #32
    MOVK  X2, #0xd8dd, LSL #48
    MOVZ  X3, #0x685e, LSL #0
    MOVK  X3, #0x7193, LSL #16
    MOVK  X3, #0x1866, LSL #32
    MOVK  X3, #0x35bd, LSL #48
    MOVZ  X4, #0x2c1, LSL #0
    MOVK  X4, #0x8b3c, LSL #16
    MOVK  X4, #0xc9f2, LSL #32
    MOVK  X4, #0xf00b, LSL #48
    MOVZ  X5, #0x83f8, LSL #0
    MOVK  X5, #0xad14, LSL #16
    MOVK  X5, #0xa75, LSL #32
    MOVK  X5, #0x9540, LSL #48
    MOVZ  X6, #0x3c58, LSL #0
    MOVK  X6, #0xd98f, LSL #16
    MOVK  X6, #0x67a, LSL #32
    MOVK  X6, #0x786e, LSL #48
    MOVZ  X7, #0x4072, LSL #0
    MOVK  X7, #0x752c, LSL #16
    MOVK  X7, #0x3e84, LSL #32
    MOVK  X7, #0xd1, LSL #48
    MOVZ  X8, #0x6f9f, LSL #0
    MOVK  X8, #0x79f8, LSL #16
    MOVK  X8, #0x8430, LSL #32
    MOVK  X8, #0xa7d2, LSL #48
    MOVZ  X9, #0xa255, LSL #0
    MOVK  X9, #0x164b, LSL #16
    MOVK  X9, #0x1d23, LSL #32
    MOVK  X9, #0x5adc, LSL #48
    MOVZ  X10, #0xbe63, LSL #0
    MOVK  X10, #0x98fb, LSL #16
    MOVK  X10, #0x27b, LSL #32
    MOVK  X10, #0x1e96, LSL #48
    MOVZ  X12, #0x8c83, LSL #0
    MOVK  X12, #0x6d3b, LSL #16
    MOVK  X12, #0xf18b, LSL #32
    MOVK  X12, #0x2f91, LSL #48
    MOVZ  X13, #0x7d10, LSL #0
    MOVK  X13, #0xf8d3, LSL #16
    MOVK  X13, #0xaa6a, LSL #32
    MOVK  X13, #0xf706, LSL #48
    MOVZ  X14, #0x9e2, LSL #0
    MOVK  X14, #0x68f4, LSL #16
    MOVK  X14, #0x2c9a, LSL #32
    MOVK  X14, #0x816b, LSL #48
    MOVZ  X15, #0x7ecf, LSL #0
    MOVK  X15, #0x3ba5, LSL #16
    MOVK  X15, #0xd401, LSL #32
    MOVK  X15, #0xe240, LSL #48
    MOVZ  X16, #0x31ea, LSL #0
    MOVK  X16, #0x876d, LSL #16
    MOVK  X16, #0xc293, LSL #32
    MOVK  X16, #0xceab, LSL #48
    MOVZ  X17, #0xdc9f, LSL #0
    MOVK  X17, #0x86c7, LSL #16
    MOVK  X17, #0x55cc, LSL #32
    MOVK  X17, #0x9be3, LSL #48
    MOVZ  X18, #0x5aa2, LSL #0
    MOVK  X18, #0x8bd9, LSL #16
    MOVK  X18, #0xbc5e, LSL #32
    MOVK  X18, #0x4556, LSL #48
    MOVZ  X19, #0x78f1, LSL #0
    MOVK  X19, #0x85f3, LSL #16
    MOVK  X19, #0xede4, LSL #32
    MOVK  X19, #0x7045, LSL #48
    MOVZ  X20, #0xf7d4, LSL #0
    MOVK  X20, #0x8b65, LSL #16
    MOVK  X20, #0x959a, LSL #32
    MOVK  X20, #0x6977, LSL #48
    MOVZ  X21, #0x4e07, LSL #0
    MOVK  X21, #0x629e, LSL #16
    MOVK  X21, #0xaff6, LSL #32
    MOVK  X21, #0x9e81, LSL #48
    MOVZ  X22, #0x4f2a, LSL #0
    MOVK  X22, #0x521d, LSL #16
    MOVK  X22, #0x2a27, LSL #32
    MOVK  X22, #0x61a6, LSL #48
    MOVZ  X23, #0xacff, LSL #0
    MOVK  X23, #0xc00b, LSL #16
    MOVK  X23, #0x34dc, LSL #32
    MOVK  X23, #0xc9c4, LSL #48
    MOVZ  X24, #0x952, LSL #0
    MOVK  X24, #0xb344, LSL #16
    MOVK  X24, #0xa5a1, LSL #32
    MOVK  X24, #0x83db, LSL #48
    MOVZ  X25, #0x3c5d, LSL #0
    MOVK  X25, #0x8c31, LSL #16
    MOVK  X25, #0xa8d4, LSL #32
    MOVK  X25, #0x4b8b, LSL #48
    MOVZ  X26, #0x1ba1, LSL #0
    MOVK  X26, #0x3bac, LSL #16
    MOVK  X26, #0xe72b, LSL #32
    MOVK  X26, #0x56d6, LSL #48
    MOVZ  X27, #0xce94, LSL #0
    MOVK  X27, #0x3a2d, LSL #16
    MOVK  X27, #0xa4c5, LSL #32
    MOVK  X27, #0xb362, LSL #48
    MOVZ  X28, #0xc088, LSL #0
    MOVK  X28, #0x3c70, LSL #16
    MOVK  X28, #0xc3fa, LSL #32
    MOVK  X28, #0x2387, LSL #48
    MOVZ  X29, #0xcc7c, LSL #0
    MOVK  X29, #0x88e3, LSL #16
    MOVK  X29, #0x238c, LSL #32
    MOVK  X29, #0x9734, LSL #48
    MOVZ  X2, #0xa, LSL #0
TaishanIntAluP01_label_482:
    BICS  X4, X13, X14, ROR #23
    ADCS  X4, X27, X23
    SUB  W19, W13, #0xd36, LSL #12
    EOR  W13, W19, W28, ROR #26
    ORN  X20, X13, X15, LSL #27
    CLS  W19, W8
    MOVN  X5, #0xabf5, LSL #48
    SUB  W28, W29, #0x2a, LSL #12
    ADCS  W16, W28, W23
    ADD  X25, X22, X29, ASR #28
    SUB  X16, X17, W10, UXTW #0
    EXTR  X5, X2, X18, #0x29
    ADC  W24, W14, W25
    BIC  W25, W22, W20, ROR #21
    CLZ  W16, W20
    MOVN  W18, #0xd90a, LSL #16
    ADCS  W7, W12, W29
    SUB  W21, W16, W4, LSR #9
    CSEL  W7, W14, W14, CS
    ADDS  W27, W19, #0x200
    CLS  X16, X24
    EON  W16, W28, W23, LSR #18
    ORR  V9.8B, V13.8B, V13.8B
    ADCS  W17, W18, W2
    ORN  X26, X22, X2, ASR #31
    CSNEG  X7, X13, X5, GT
    ADD  X25, X12, X16, LSR #35
    EXTR  W27, W9, W8, #0x6
    BICS  W12, W19, W26, ASR #11
    AND  X8, X10, #0xfc1ffc1ffc1ffc1f
    SUB  W25, W17, W16, UXTX #4
    CRC32CB  W21, W25, W21
    SBFM  X26, X3, #0x37, #0x8
    LSRV  W20, W21, W6
    ASRV  X8, X25, X4
    ADD  X13, X18, #0xf2b
    CSEL  X3, X14, X17, NE
    EXTR  X7, X28, X23, #0xd
    BICS  W4, W3, W21, ROR #7
    EOR  X22, X8, #0xffffffe000000000
    LSRV  W14, W7, W22
    LSLV  W17, W3, W12
    CRC32B  W10, W8, W19
    UMADDL  X26, W8, W22, X20
    ASRV  W27, W2, W14
    ADD  W25, W24, #0x3dc, LSL #12
    ORR  W10, W21, #0xffe3ffe3
    MOVZ  X17, #0xbc9c, LSL #48
    EON  W24, W12, W19, ASR #16
    ORR  W3, W27, #0x10101010
    ADC  W27, W9, W21
    SMADDL  X17, W23, W5, X16
    ANDS  W13, W16, W20, ASR #6
    ADD  X24, X5, #0xcd0
    ANDS  W28, W24, #0x3ffc0
    CRC32CH  W23, W12, W20
    SMSUBL  X24, W19, W10, X6
    CLS  W26, W25
    ADC  W21, W6, W23
    ORR  V22.16B, V16.16B, V12.16B
    LSLV  X3, X8, X9
    MOVN  W3, #0xd14d, LSL #16
    EOR  X17, X3, X21, LSR #58
    ANDS  W16, W18, #0x7ffffff0
    ORN  X13, X27, X21, LSR #8
    BICS  X19, X2, X19, ROR #33
    LSLV  X14, X17, X19
    ADD  W14, W24, W3, SXTB #2
    MADD  W13, W20, W21, W7
    ADCS  X20, X17, X28
    ADDS  W14, W7, #0xc5, LSL #12
    SUBS  X3, X23, X9, LSR #57
    CLS  V22.8B, V8.8B
    ORR  W19, W15, W22, LSL #18
    BIC  W8, W27, W4, ASR #24
    ORR  X17, X5, X24, ASR #25
    MADD  X17, X26, X8, X10
    SUBS  W19, W6, #0x663, LSL #12
    CLS  X20, X9
    CLZ  V7.2S, V19.2S
    ASRV  X3, X3, X23
    CRC32CB  W17, W19, W16
    SUBS  X12, X28, #0xb1f
    SMULH  X23, X17, X10
    MOVN  W4, #0xff88, LSL #0
    EOR  X25, X20, #0x1f00000000
    ADD  X14, X18, X12, UXTX #0
    CSINC  X21, X23, X13, AL
    CLS  W25, W4
    SMULH  X25, X14, X26
    ADDS  W7, W2, W15, LSL #12
    BIC  W5, W14, W13, LSL #25
    ADD  X21, X21, X20, LSR #59
    MADD  W25, W26, W8, W10
    MOVN  W26, #0x9731, LSL #0
    SMADDL  X10, W21, W25, X27
    EOR  X8, X22, #0xffffff80000003ff
    CLZ  W12, W3
    MOVN  X17, #0xd52, LSL #0
    CRC32B  W18, W17, W26
    CSINV  X23, X25, X23, LE
    SUBS  X16, X4, W13, UXTW #3
    MOVK  X28, #0x9ddd, LSL #48
    BIC  X18, X12, X20, LSR #43
    SMSUBL  X7, W18, W26, X7
    ADDS  X21, X14, X9, ASR #32
    SUBS  W27, W3, W19, UXTX #1
    SUB  W5, W24, W14, SXTH #3
    UMSUBL  X8, W6, W3, X23
    MADD  W22, W21, W13, W4
    ADD  X21, X10, W3, UXTH #1
    CLS  X4, X17
    ADCS  X13, X13, X14
    BICS  X6, X17, X15, LSL #47
    CRC32CB  W24, W3, W28
    EOR  X5, X28, X10, ROR #38
    CLS  X27, X25
    ADDS  X24, X7, #0x79a, LSL #12
    CSEL  X19, X15, X12, AL
    ADDS  W21, W9, W9, LSR #7
    SBFM  X25, X6, #0x15, #0x28
    ORN  W17, W16, W10, ASR #27
    LSRV  W26, W26, W29
    AND  W22, W21, W7, LSR #24
    SUBS  W3, W4, W24, UXTX #2
    ADD  W23, W9, W16, UXTX #3
    ADD  W15, W3, W28, UXTX #2
    SUBS  X24, X27, X12, LSL #48
    SMSUBL  X8, W7, W26, X18
    CLZ  W19, W12
    BIC  W12, W17, W16, ROR #21
    SUBS  X20, X24, X19, UXTX #2
    MOVN  W15, #0xdd70, LSL #16
    ADD  W17, W2, W2, ASR #5
    EOR  W25, W14, #0x7ff000
    SUB  W16, W6, W22, SXTH #3
    CRC32CH  W21, W22, W23
    SUBS  X27, X5, #0x8f8
    CLZ  W10, W5
    ANDS  W24, W8, #0xe3e3e3e3
    EOR  W28, W24, #0x18181818
    SUBS  X20, X14, X14, LSR #51
    CLS  X8, X15
    SUBS  W22, W6, W14, SXTB #0
    LSLV  X10, X5, X16
    ANDS  X28, X28, X26, ROR #25
    ADC  W21, W7, W3
    EOR  W12, W20, #0xfc00fc0
    SUBS  X13, X6, X17, LSL #24
    CLS  V22.16B, V11.16B
    ADCS  X27, X20, X12
    SUBS  X19, X13, W5, UXTH #3
    ADDS  X17, X20, #0x83b
    EOR  X20, X18, #0x7ffc00007ffc00
    ADD  W23, W18, W28, ASR #27
    CSINC  W24, W10, W20, LE
    LSLV  X13, X2, X24
    CSINC  X19, X10, X18, NV
    ADD  X27, X27, #0xbaf
    EOR  W28, W23, W17, ROR #4
    MOVK  W9, #0xf6ce, LSL #16
    BICS  W13, W15, W2, LSL #10
    SUB  X26, X9, #0x800, LSL #12
    EOR  W19, W19, #0x1f0
    MOVK  X17, #0x51f0, LSL #48
    CRC32CB  W13, W4, W10
    MADD  W26, W8, W15, W22
    ADD  W6, W29, W23, SXTB #3
    CSINV  W5, W6, W28, GT
    CLZ  X12, X20
    ADDS  W12, W10, #0x96c
    LSLV  W14, W14, W4
    EXTR  X29, X14, X27, #0xc
    EXTR  W20, W9, W21, #0xa
    SMADDL  X20, W24, W22, X16
    EOR  X4, X27, X5, ASR #6
    UMULH  X28, X5, X28
    SMADDL  X5, W24, W24, X27
    ADD  X17, X4, W29, UXTW #1
    AND  X9, X13, X10, LSR #63
    ADDS  W4, W13, W13, LSL #20
    ORR  V25.4H, #0x56
    CLZ  V19.8B, V24.8B
    MADD  X22, X23, X25, X23
    SUBS  W28, W20, #0xe0d, LSL #12
    CLS  W17, W20
    MADD  W6, W12, W10, W25
    SUB  X25, X17, W13, UXTW #4
    ADD  W19, W21, W29, LSR #27
    MOVK  X14, #0x8a7f, LSL #48
    ASRV  X25, X6, X25
    CSINC  W9, W29, W7, VS
    ADDS  W26, W14, #0x50a, LSL #12
    EXTR  W13, W12, W27, #0xe
    UBFM  W8, W20, #0x2, #0x1f
    SUBS  X19, X2, X23, UXTX #3
    CRC32B  W5, W26, W3
    CSNEG  X18, X25, X6, GT
    EON  X18, X21, X4, ROR #16
    CLZ  W26, W20
    SUBS  X2, X2, #0x1
    B.NE  TaishanIntAluP01_label_482
    MOVZ  X28, #0x0, LSL #0
    SUB  X10, X28, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X12, #0x272f, LSL #0
    MOVK  X12, #0xfdce, LSL #16
    SUB  X7, X12, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP01_TestFail
    MOVZ  X13, #0xba45, LSL #0
    MOVK  X13, #0xc803, LSL #16
    SUB  X9, X13, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x6df9, LSL #0
    MOVK  X2, #0xab28, LSL #16
    SUB  X22, X2, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X3, #0x2f20, LSL #0
    MOVK  X3, #0x2687, LSL #16
    SUB  X21, X3, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X10, X24, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X29, #0xb6, LSL #0
    MOVK  X29, #0x11ad, LSL #16
    SUB  X2, X29, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X18, #0x272f, LSL #0
    MOVK  X18, #0xfdce, LSL #16
    SUB  X26, X18, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X15, #0xba45, LSL #0
    MOVK  X15, #0xc803, LSL #16
    SUB  X19, X15, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xf900, LSL #16
    MOVK  X8, #0x8a7f, LSL #48
    SUB  X2, X8, X14
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP01_TestFail
    MOVZ  X10, #0xba45, LSL #0
    MOVK  X10, #0xc803, LSL #16
    SUB  X21, X10, X15
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X22, #0xf2ad, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X24, X22, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x272f, LSL #0
    MOVK  X6, #0xfdce, LSL #16
    SUB  X12, X6, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X26, #0x2da, LSL #0
    MOVK  X26, #0x46b4, LSL #16
    MOVK  X26, #0xfffa, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X19, X26, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X22
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X14, #0x20, LSL #0
    SUB  X13, X14, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X4, X8, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x2da, LSL #0
    MOVK  X20, #0x46b4, LSL #16
    MOVK  X20, #0xfffa, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X14, X20, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP01_TestFail
    MOVZ  X9, #0xbbb0, LSL #0
    MOVK  X9, #0x5031, LSL #16
    SUB  X10, X9, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X5, X25, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
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
    MOVZ  X6, #0xa, LSL #0
TaishanIntAluP01_label_507:
    ORR  V21.4S, #0x72, LSL #24
    ASRV  W28, W24, W8
    EXTR  X28, X2, X23, #0x2f
    MADD  W17, W10, W2, W14
    ADDS  W19, W7, #0x32e
    EXTR  X22, X14, X16, #0x2
    ADC  W16, W10, W9
    UMULH  X28, X25, X19
    CSINC  W21, W5, W17, LS
    AND  X26, X29, #0xf3f3f3f3f3f3f3f3
    EXTR  X18, X7, X18, #0xc
    SBFM  W10, W18, #0x10, #0xb
    CLS  W13, W12
    CRC32B  W26, W28, W15
    SBFM  W25, W24, #0x1c, #0x5
    MADD  X19, X5, X10, X13
    ADDS  W10, W8, W27, UXTX #3
    CSINV  W16, W10, W15, MI
    SMSUBL  X7, W19, W5, X17
    MOVK  X29, #0x13bc, LSL #16
    MOVK  X23, #0xec82, LSL #48
    SUBS  X14, X4, W14, UXTH #0
    ORN  X4, X26, X5, ROR #25
    EXTR  X15, X9, X21, #0x10
    UMSUBL  X27, W25, W22, X14
    ORR  W8, W24, W14, ASR #29
    EON  X8, X2, X18, LSL #5
    MOVZ  X26, #0x72b, LSL #32
    CRC32CW  W13, W21, W4
    EOR  X5, X14, X8, ROR #37
    CRC32CH  W29, W22, W13
    CRC32X  W10, W20, X12
    ASRV  X7, X13, X14
    ADDS  W9, W22, #0xdd, LSL #12
    ADD  W21, W18, #0x8c0
    ADDS  W14, W15, #0x318
    ORR  V23.8H, #0x37, LSL #8
    SUB  X7, X5, #0x465
    SUB  W24, W12, W19, LSL #24
    CRC32CW  W16, W8, W6
    CLZ  X22, X15
    ORR  X28, X21, #0x1fffffffffc
    SMSUBL  X2, W14, W5, X23
    ADD  W9, W2, W15, ASR #23
    EOR  X17, X9, #0xffc7ffffffffffff
    MADD  X18, X9, X24, X7
    ORR  X16, X2, X26, LSR #3
    LSLV  W19, W10, W29
    SUBS  X9, X25, #0xfed
    ORR  V27.8H, #0x66, LSL #8
    SUB  W28, W15, #0x24c, LSL #12
    CRC32CH  W13, W6, W29
    SUB  X18, X27, #0x6be
    EON  X10, X9, X17, ASR #49
    UBFM  W13, W17, #0x1e, #0xb
    CSNEG  X28, X15, X9, GE
    ANDS  W4, W27, #0xff000001
    SUBS  X8, X20, #0x0
    CSEL  W8, W13, W13, CS
    UBFM  X28, X14, #0x2c, #0x34
    CLZ  X25, X23
    AND  X7, X17, #0x1c0000001c000
    ORR  X7, X21, #0x1c00000000
    MADD  W15, W29, W6, W29
    SUBS  W3, W5, W19, ASR #12
    CLS  X14, X10
    MOVZ  W21, #0x8f6a, LSL #0
    CRC32X  W28, W7, X18
    ADCS  X8, X23, X3
    ANDS  X20, X13, #0xffffffffffffc000
    ORR  V20.4H, #0x88
    SBFM  X4, X2, #0x22, #0x7
    CRC32CB  W2, W20, W25
    ORN  W19, W12, W25, ASR #18
    SBFM  X2, X16, #0x34, #0x23
    ADCS  W29, W12, W27
    MADD  X27, X19, X18, X4
    LSRV  W19, W15, W7
    ORR  X28, X20, X6, ROR #55
    CRC32W  W15, W6, W29
    BICS  W24, W4, W12, LSR #22
    EON  W16, W9, W5, ROR #5
    ORR  X20, X9, #0xffffffff00007fff
    ADD  W17, W18, W21, ASR #7
    AND  X17, X18, X7, LSL #11
    CLS  V16.8H, V0.8H
    ADDS  W18, W2, #0x5b3
    SBFM  X2, X5, #0x29, #0x14
    CLS  X17, X2
    ADDS  X8, X14, X4, LSL #43
    SMSUBL  X2, W5, W9, X24
    ANDS  W9, W26, W24, ASR #25
    ADD  W4, W8, #0xd77
    EOR  X15, X15, X25, LSL #46
    ORN  W22, W6, W19, LSL #22
    CSNEG  W29, W10, W27, MI
    SUBS  W26, W10, W17, LSL #23
    EON  X9, X7, X15, ASR #28
    BIC  W8, W23, W12, ASR #29
    ADC  X18, X10, X16
    MOVZ  W18, #0xb67e, LSL #0
    SUB  X5, X14, X4, ASR #20
    ANDS  X15, X16, X9, LSR #35
    ADDS  X24, X18, #0x90
    SUBS  X26, X29, X26, LSR #18
    EON  X29, X29, X8, ASR #60
    AND  X22, X9, X4, LSR #57
    CRC32CX  W7, W23, X12
    ADD  X4, X17, X26, LSL #6
    CRC32B  W16, W29, W3
    CSINC  X3, X14, X25, AL
    BIC  X5, X2, X7, ROR #21
    UBFM  W27, W2, #0xa, #0x4
    EOR  W18, W2, W7, LSR #30
    CRC32CH  W10, W19, W22
    EON  X17, X21, X18, LSR #54
    CSINC  W19, W4, W5, GE
    ANDS  X21, X7, #0x1ffe00000000
    SUBS  W27, W22, W18, UXTH #4
    ADD  W23, W3, #0x10
    MOVK  X14, #0xd669, LSL #48
    ORN  W19, W6, W14, ROR #8
    ADDS  W12, W26, W10, LSL #25
    CSNEG  X19, X23, X18, CS
    ADD  X29, X29, W10, UXTB #4
    ADCS  W16, W28, W8
    ORR  W24, W20, W23, LSR #9
    SBFM  W27, W22, #0xa, #0xa
    ORN  W16, W6, W27, LSL #4
    AND  X3, X28, #0xffff0000ffff0
    EOR  X23, X12, X17, ASR #21
    EXTR  X4, X6, X25, #0x18
    LSLV  W8, W10, W14
    CSNEG  X29, X28, X21, VS
    SUB  X10, X5, W14, SXTW #1
    SUBS  X24, X16, #0xd90
    SUBS  X26, X26, X8, LSL #52
    SUBS  X24, X24, #0x3f6
    ADD  W22, W4, W20, SXTB #2
    EXTR  X24, X26, X3, #0x3
    ORR  W24, W15, #0xfe0ffe0f
    ADDS  X21, X4, #0x38c, LSL #12
    LSRV  W4, W4, W23
    EON  W23, W17, W22, ROR #7
    EXTR  W19, W10, W29, #0x6
    CSINC  W14, W22, W20, CS
    SUB  W18, W3, W18, UXTW #0
    UMADDL  X5, W9, W7, X29
    ORR  X23, X5, X20, ASR #28
    ORR  W22, W28, #0x8000003f
    ORR  V6.4H, #0xb3
    EOR  W9, W23, W12, ROR #27
    ORR  W28, W19, W19, LSL #20
    ADCS  X27, X10, X24
    ANDS  W9, W9, #0x3800380
    SUB  W8, W18, W5, ASR #2
    ORN  W22, W8, W4, LSR #19
    ADD  X13, X3, X24, LSR #10
    ADDS  W7, W18, W7, SXTB #0
    ADDS  X27, X21, W15, UXTB #1
    ANDS  X14, X22, X17, LSR #24
    ADC  X15, X6, X4
    ADCS  W18, W28, W19
    ANDS  W3, W21, W23, LSL #4
    CRC32B  W13, W6, W16
    LSRV  X16, X25, X20
    CRC32W  W10, W16, W21
    SUB  X15, X20, X5, LSR #22
    ADDS  W3, W12, #0x940
    EOR  X15, X26, #0x7800000078000
    CRC32H  W3, W8, W12
    CRC32CX  W3, W17, X26
    MADD  X22, X22, X4, X10
    ORR  V17.8B, V6.8B, V31.8B
    AND  X24, X17, #0xffe0ffe0ffe0ffe0
    EON  X10, X28, X17, LSL #58
    ADC  X19, X16, X23
    ANDS  X3, X26, #0xfff7fff7fff7fff7
    ADD  X21, X12, X19, LSR #9
    ADD  X28, X7, #0x1c0
    ADDS  W13, W16, #0x960
    ORN  W24, W20, W15, ROR #17
    EOR  X15, X20, #0xfe00000000007fff
    EON  W24, W4, W19, ROR #15
    CRC32CH  W3, W27, W10
    CLZ  X21, X15
    ANDS  W20, W23, #0xffc00fff
    EOR  X25, X16, #0xefffffffefffffff
    SUB  W20, W8, W14, SXTX #3
    CRC32B  W25, W13, W6
    ORR  W9, W6, W26, LSR #22
    CSINC  W21, W3, W4, GE
    SUBS  W5, W28, #0x140
    LSLV  W9, W10, W24
    BIC  W23, W26, W19, LSR #29
    SUB  X20, X4, X4, LSL #31
    CRC32CX  W4, W2, X15
    EOR  X9, X23, X22, LSR #13
    AND  W13, W9, #0xc07fffff
    MOVZ  X4, #0xa697, LSL #48
    SUBS  X6, X6, #0x1
    B.NE  TaishanIntAluP01_label_507
    MOVZ  X15, #0xddc6, LSL #0
    MOVK  X15, #0x3ea4, LSL #16
    MOVK  X15, #0xf975, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X18, X15, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP01_TestFail
    MOVZ  X9, #0xdce9, LSL #0
    MOVK  X9, #0x997d, LSL #16
    SUB  X5, X9, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xa697, LSL #48
    SUB  X19, X23, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X9, X17, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X22, #0x2487, LSL #0
    MOVK  X22, #0xc15b, LSL #16
    SUB  X5, X22, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X13, #0x4d85, LSL #0
    MOVK  X13, #0xa70f, LSL #16
    SUB  X23, X13, X8
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0x97ff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xabff, LSL #48
    SUB  X25, X24, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X26, X23, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X10, #0x4d85, LSL #0
    MOVK  X10, #0xa70f, LSL #16
    SUB  X6, X10, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP01_TestFail
    MOVZ  X12, #0xddc6, LSL #0
    MOVK  X12, #0x3ea4, LSL #16
    MOVK  X12, #0xf975, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X21, X12, X15
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X17
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X4, X18, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X19
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X21
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP01_TestFail
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
    MOVZ  X15, #0x14, LSL #0
TaishanIntAluP01_label_535:
    ORR  X28, X4, X22, ROR #46
    CRC32CW  W8, W15, W8
    SUB  W20, W15, W4, LSL #26
    ORR  V31.4S, #0x9e, LSL #8
    SUBS  X10, X14, #0x70a, LSL #12
    BIC  V29.16B, V24.16B, V18.16B
    CRC32CW  W9, W28, W16
    UBFM  X29, X26, #0x7, #0x19
    CSINC  X29, X10, X25, PL
    AND  W4, W27, #0x30003000
    ADC  X14, X4, X9
    ORR  W8, W28, W15, LSR #4
    ADC  W6, W19, W13
    MADD  W17, W15, W6, W24
    MOVK  W29, #0x2683, LSL #16
    SUBS  X6, X17, X28, LSL #23
    ADCS  X9, X3, X10
    BIC  W14, W17, W4, ASR #16
    ANDS  X23, X16, X10, ROR #45
    CRC32CH  W7, W17, W24
    ORR  V14.8H, #0x77
    AND  W2, W8, #0xff8fff8f
    EON  X13, X18, X19, ROR #28
    BIC  V23.16B, V28.16B, V5.16B
    CRC32CH  W27, W29, W15
    CLZ  W27, W18
    CRC32CW  W25, W22, W2
    MOVK  X23, #0xbd01, LSL #32
    CLS  V3.4S, V24.4S
    ORR  W25, W28, W12, ASR #24
    MOVK  W23, #0x499f, LSL #0
    ASRV  X24, X26, X8
    MOVN  W7, #0x9670, LSL #0
    SUBS  X25, X27, #0x447
    MOVZ  W13, #0x4dda, LSL #0
    ADDS  W6, W22, W23, SXTH #0
    SUB  W22, W10, W14, SXTW #2
    LSRV  W4, W24, W4
    EOR  X25, X7, #0x1ff800000000000
    EOR  X13, X14, #0xffff8fffffffffff
    ADC  W9, W6, W9
    CRC32W  W22, W25, W14
    MOVK  W22, #0x33df, LSL #16
    CRC32W  W13, W3, W15
    EOR  W7, W10, W15, ASR #24
    CSINV  X3, X23, X2, CC
    CRC32CX  W8, W10, X6
    MADD  X29, X16, X10, X25
    UMSUBL  X13, W8, W24, X27
    CRC32CH  W21, W20, W7
    CRC32B  W28, W3, W20
    CRC32CB  W2, W15, W28
    CRC32W  W13, W21, W21
    EXTR  W5, W9, W16, #0x3
    CRC32W  W9, W26, W22
    SUBS  X17, X14, #0x1e6
    ADDS  W19, W14, W26, UXTH #0
    SBFM  X5, X19, #0x3e, #0x6
    SUBS  W29, W26, W28, ASR #22
    SUBS  W7, W6, #0x9e2
    CSNEG  X16, X27, X3, GT
    ORN  X24, X8, X9, LSL #43
    SBFM  W9, W29, #0xc, #0xf
    CRC32W  W13, W3, W4
    MOVK  W29, #0x3628, LSL #16
    CLZ  V26.2S, V3.2S
    SUBS  W2, W20, W3, LSL #13
    MOVK  W12, #0x15f0, LSL #0
    ORN  W2, W23, W5, LSR #6
    CLZ  V17.8H, V27.8H
    LSLV  W2, W10, W21
    ORN  X20, X19, X9, ASR #7
    SUBS  W3, W20, W21, LSL #14
    ADC  W23, W3, W23
    SUB  W25, W18, #0x76c, LSL #12
    ADDS  W9, W23, W17, ASR #19
    MOVZ  W28, #0x71c4, LSL #16
    MADD  W25, W23, W4, W5
    CLZ  X23, X20
    SBFM  X23, X5, #0x4, #0x1e
    CSINV  W2, W19, W21, AL
    MOVZ  X17, #0x2b5, LSL #0
    ORR  V3.8B, V11.8B, V8.8B
    CLZ  V31.8H, V21.8H
    MOVZ  X27, #0x677c, LSL #16
    CSINV  X6, X23, X25, NV
    UMSUBL  X18, W27, W24, X6
    EXTR  X20, X2, X17, #0x7
    ORN  W29, W27, W26, LSL #28
    EXTR  W8, W25, W27, #0x1c
    SBFM  W8, W28, #0x1b, #0x4
    ADCS  X21, X14, X19
    UMADDL  X29, W18, W18, X23
    CRC32X  W3, W2, X3
    AND  W14, W5, W24, LSL #10
    LSLV  X12, X13, X6
    MADD  X5, X25, X3, X20
    MADD  X10, X4, X19, X17
    ADCS  X18, X27, X28
    ADD  W3, W25, #0xda0
    EXTR  X21, X26, X4, #0x3a
    AND  X19, X5, #0x1ffffe001ffffe
    LSLV  X29, X12, X8
    EOR  W17, W29, W19, ROR #30
    SUB  W28, W28, W23, SXTW #3
    ORR  W20, W14, #0xfff80001
    BICS  X20, X6, X9, ASR #46
    CSEL  W10, W20, W24, NV
    CRC32CB  W2, W27, W10
    ORR  V6.4S, #0x43, LSL #24
    ADDS  W13, W13, W14, SXTW #3
    ANDS  W22, W14, #0xfbffffff
    CRC32H  W23, W21, W19
    CSINC  W24, W15, W22, AL
    SUB  W2, W12, W21, SXTX #1
    SMULH  X13, X3, X21
    CRC32H  W28, W12, W17
    EXTR  X18, X2, X18, #0x29
    SUBS  X8, X18, W18, SXTH #1
    BICS  W26, W10, W2, LSL #27
    ADD  W14, W26, W10, LSL #15
    SMSUBL  X8, W12, W23, X5
    BICS  W2, W22, W9, LSL #26
    ORN  X12, X26, X14, ASR #34
    UMADDL  X23, W8, W2, X17
    LSRV  W4, W18, W12
    SUB  W21, W9, W20, SXTW #0
    ADDS  X25, X17, X26, ASR #10
    ANDS  X13, X5, X10, ROR #61
    CSINV  X5, X3, X16, NE
    CRC32CB  W28, W3, W4
    ADDS  W25, W5, #0xb58
    EON  X22, X21, X28, ROR #25
    CLZ  V10.4H, V27.4H
    LSLV  W8, W13, W8
    EON  X23, X6, X15, ASR #15
    BIC  V2.16B, V4.16B, V4.16B
    SUBS  W3, W7, #0x970
    CSINC  W9, W7, W19, NV
    UMADDL  X28, W18, W29, X27
    ANDS  X21, X3, X18, LSR #32
    ORR  W12, W18, W7, ROR #10
    SMULH  X4, X18, X15
    EXTR  W17, W4, W8, #0x12
    CSEL  W25, W8, W22, HI
    SUBS  X26, X28, X22, SXTX #3
    CSINV  W21, W21, W22, LS
    CRC32CX  W3, W14, X25
    SBFM  X20, X16, #0x38, #0x30
    EOR  X21, X5, X25, ROR #13
    CSNEG  W21, W16, W25, GE
    UBFM  W26, W15, #0x11, #0xd
    ORR  V29.16B, V21.16B, V16.16B
    SUBS  W16, W10, #0xfed
    ADD  X26, X9, #0x4e0
    CLZ  W9, W14
    CLZ  W17, W17
    ADCS  X17, X16, X7
    SUB  W12, W10, W5, LSL #31
    MOVZ  W20, #0xbdb1, LSL #0
    ORR  V27.2S, #0x17, LSL #8
    CSINC  W9, W6, W7, LS
    ORR  V6.4H, #0x14
    BIC  X12, X7, X25, ROR #29
    ORR  V17.4H, #0x1d
    SUBS  X10, X8, X14, LSR #14
    CRC32X  W8, W16, X26
    CLS  X21, X21
    AND  W26, W29, W17, LSL #28
    LSLV  W26, W29, W26
    EXTR  W26, W15, W28, #0xb
    EXTR  X5, X21, X26, #0x14
    UBFM  X27, X8, #0x2b, #0x37
    SUBS  W3, W16, #0xa1d
    BIC  X21, X29, X24, ROR #2
    ADCS  W16, W3, W16
    ADDS  W10, W12, W22, LSR #4
    SMULH  X12, X17, X6
    MOVZ  X18, #0xe41, LSL #48
    ADD  W21, W16, W9, LSR #9
    ORR  V10.16B, V22.16B, V22.16B
    SUB  X24, X17, X24, LSR #26
    CLS  V18.4H, V13.4H
    AND  W8, W19, #0xaaaaaaaa
    CLZ  X12, X22
    ADCS  W19, W10, W20
    ADD  W9, W6, #0x3c8
    CLS  X13, X3
    EOR  X20, X20, X10, LSL #31
    ASRV  X29, X17, X12
    SBFM  W27, W24, #0x5, #0x5
    UBFM  X8, X10, #0x7, #0x1d
    LSRV  W9, W24, W28
    ANDS  W26, W23, #0x22222222
    CSNEG  W6, W18, W24, CS
    BICS  X3, X10, X28, ROR #60
    ANDS  W23, W9, W24, ROR #23
    MOVN  X2, #0xf798, LSL #0
    CSINV  W21, W25, W8, CC
    CSNEG  X3, X21, X29, NV
    SUBS  X15, X15, #0x1
    B.NE  TaishanIntAluP01_label_535
    MOVZ  X3, #0x867, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X13, X3, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X4, #0x867, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X27, X4, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x867, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X19, X8, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X13, #0x2, LSL #0
    MOVK  X13, #0x9000, LSL #32
    MOVK  X13, #0x3, LSL #48
    SUB  X17, X13, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x14eb, LSL #0
    MOVK  X9, #0x9994, LSL #16
    SUB  X12, X9, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X21, #0xfafb, LSL #0
    MOVK  X21, #0x666b, LSL #16
    SUB  X10, X21, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X24, #0x867, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X8, X24, X8
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X26, #0x14eb, LSL #0
    MOVK  X26, #0x9994, LSL #16
    SUB  X23, X26, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x2, LSL #0
    MOVK  X9, #0x9000, LSL #32
    MOVK  X9, #0x3, LSL #48
    SUB  X19, X9, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X10, #0x8007, LSL #0
    MOVK  X10, #0x3, LSL #16
    SUB  X26, X10, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP01_TestFail
    MOVZ  X18, #0xd618, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X26, X18, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X13, #0xd618, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X12, X13, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X23, #0xbdb1, LSL #0
    MOVK  X23, #0x8000, LSL #16
    MOVK  X23, #0x23ac, LSL #32
    MOVK  X23, #0x39a7, LSL #48
    SUB  X9, X23, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X10, #0xfafb, LSL #0
    MOVK  X10, #0x666b, LSL #16
    SUB  X25, X10, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X6, #0xbdb1, LSL #0
    MOVK  X6, #0x8000, LSL #16
    MOVK  X6, #0x23ac, LSL #32
    MOVK  X6, #0x39a7, LSL #48
    SUB  X13, X6, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X2, #0xeb15, LSL #0
    MOVK  X2, #0x666b, LSL #16
    MOVK  X2, #0x1, LSL #32
    SUB  X19, X2, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X2, #0xb903, LSL #0
    MOVK  X2, #0xed6, LSL #16
    MOVK  X2, #0x6b4e, LSL #32
    MOVK  X2, #0xfdee, LSL #48
    MOVZ  X3, #0x579b, LSL #0
    MOVK  X3, #0x428b, LSL #16
    MOVK  X3, #0xcd8b, LSL #32
    MOVK  X3, #0x17ed, LSL #48
    MOVZ  X4, #0x5962, LSL #0
    MOVK  X4, #0xca49, LSL #16
    MOVK  X4, #0x1291, LSL #32
    MOVK  X4, #0x907, LSL #48
    MOVZ  X5, #0x138d, LSL #0
    MOVK  X5, #0x97e6, LSL #16
    MOVK  X5, #0xe459, LSL #32
    MOVK  X5, #0xd9da, LSL #48
    MOVZ  X6, #0x8b94, LSL #0
    MOVK  X6, #0xfa6d, LSL #16
    MOVK  X6, #0xc61c, LSL #32
    MOVK  X6, #0x9279, LSL #48
    MOVZ  X7, #0xd9d4, LSL #0
    MOVK  X7, #0x6615, LSL #16
    MOVK  X7, #0x7263, LSL #32
    MOVK  X7, #0x2578, LSL #48
    MOVZ  X8, #0x34d1, LSL #0
    MOVK  X8, #0x78c9, LSL #16
    MOVK  X8, #0x99f, LSL #32
    MOVK  X8, #0x345b, LSL #48
    MOVZ  X9, #0xb5a5, LSL #0
    MOVK  X9, #0xaa59, LSL #16
    MOVK  X9, #0xb95d, LSL #32
    MOVK  X9, #0xc2d4, LSL #48
    MOVZ  X10, #0x3fa0, LSL #0
    MOVK  X10, #0xda7, LSL #16
    MOVK  X10, #0xa201, LSL #32
    MOVK  X10, #0x6ffb, LSL #48
    MOVZ  X12, #0xf57c, LSL #0
    MOVK  X12, #0xc35e, LSL #16
    MOVK  X12, #0x41af, LSL #32
    MOVK  X12, #0xdd71, LSL #48
    MOVZ  X13, #0x9924, LSL #0
    MOVK  X13, #0x7efb, LSL #16
    MOVK  X13, #0x1193, LSL #32
    MOVK  X13, #0x98f, LSL #48
    MOVZ  X14, #0x9edd, LSL #0
    MOVK  X14, #0xd929, LSL #16
    MOVK  X14, #0x251d, LSL #32
    MOVK  X14, #0xdab, LSL #48
    MOVZ  X15, #0xc655, LSL #0
    MOVK  X15, #0x24fa, LSL #16
    MOVK  X15, #0xad81, LSL #32
    MOVK  X15, #0x87ae, LSL #48
    MOVZ  X16, #0xcca6, LSL #0
    MOVK  X16, #0xcf1c, LSL #16
    MOVK  X16, #0x1c80, LSL #32
    MOVK  X16, #0xa70f, LSL #48
    MOVZ  X17, #0x7ec7, LSL #0
    MOVK  X17, #0x7a14, LSL #16
    MOVK  X17, #0x3fd2, LSL #32
    MOVK  X17, #0x6f1e, LSL #48
    MOVZ  X18, #0x3453, LSL #0
    MOVK  X18, #0xc5ea, LSL #16
    MOVK  X18, #0x8a99, LSL #32
    MOVK  X18, #0x3622, LSL #48
    MOVZ  X19, #0x7bec, LSL #0
    MOVK  X19, #0xa998, LSL #16
    MOVK  X19, #0xa991, LSL #32
    MOVK  X19, #0x429, LSL #48
    MOVZ  X20, #0x93d, LSL #0
    MOVK  X20, #0xf26d, LSL #16
    MOVK  X20, #0x8aa5, LSL #32
    MOVK  X20, #0xf202, LSL #48
    MOVZ  X21, #0xd35a, LSL #0
    MOVK  X21, #0xbf85, LSL #16
    MOVK  X21, #0x18cb, LSL #32
    MOVK  X21, #0xbfce, LSL #48
    MOVZ  X22, #0x6ab2, LSL #0
    MOVK  X22, #0x7007, LSL #16
    MOVK  X22, #0x9a60, LSL #32
    MOVK  X22, #0x4726, LSL #48
    MOVZ  X23, #0x2abb, LSL #0
    MOVK  X23, #0x6771, LSL #16
    MOVK  X23, #0x35e6, LSL #32
    MOVK  X23, #0xfda2, LSL #48
    MOVZ  X24, #0xd5ef, LSL #0
    MOVK  X24, #0xc6bd, LSL #16
    MOVK  X24, #0xef58, LSL #32
    MOVK  X24, #0x7ab1, LSL #48
    MOVZ  X25, #0x74a7, LSL #0
    MOVK  X25, #0xc539, LSL #16
    MOVK  X25, #0x15ec, LSL #32
    MOVK  X25, #0x854f, LSL #48
    MOVZ  X26, #0xae50, LSL #0
    MOVK  X26, #0xecec, LSL #16
    MOVK  X26, #0x7ae0, LSL #32
    MOVK  X26, #0xa4c6, LSL #48
    MOVZ  X27, #0xc746, LSL #0
    MOVK  X27, #0xc111, LSL #16
    MOVK  X27, #0x5c28, LSL #32
    MOVK  X27, #0x797e, LSL #48
    MOVZ  X28, #0x5e2d, LSL #0
    MOVK  X28, #0x806e, LSL #16
    MOVK  X28, #0x8b17, LSL #32
    MOVK  X28, #0x3038, LSL #48
    MOVZ  X29, #0xfce5, LSL #0
    MOVK  X29, #0xbae9, LSL #16
    MOVK  X29, #0xa401, LSL #32
    MOVK  X29, #0xbcf, LSL #48
    MOVZ  X21, #0xa, LSL #0
TaishanIntAluP01_label_561:
    ORR  V1.4H, #0x5e
    SBFM  X27, X15, #0x12, #0x8
    LSRV  W27, W21, W29
    SUBS  W26, W8, #0xfdb, LSL #12
    ADDS  W29, W23, W7, LSR #4
    CLS  W22, W6
    ANDS  W2, W5, W22, LSR #9
    AND  X8, X23, #0xffffc00000
    MOVN  W29, #0x2437, LSL #0
    ASRV  W15, W17, W29
    SUB  X5, X18, W13, SXTB #2
    CRC32H  W10, W7, W4
    CSNEG  W15, W10, W14, NV
    ORR  X12, X6, #0x3fffc000000
    SUBS  W13, W6, #0x37f, LSL #12
    ANDS  W7, W26, W29, LSL #29
    ADDS  X15, X16, X5, LSR #34
    EOR  X8, X2, X2, LSL #26
    ORR  W16, W8, W24, LSL #30
    ORR  X26, X12, #0x7e000000
    ADDS  W15, W15, #0xef0, LSL #12
    ORR  W5, W6, #0xfffe7fff
    SUB  W13, W24, W28, SXTB #2
    CSNEG  W19, W2, W24, EQ
    MOVK  W8, #0x44, LSL #16
    EXTR  W25, W18, W24, #0x5
    ORR  X20, X2, #0xfffffc0ffffffc0f
    MADD  X28, X5, X17, X5
    SBFM  W24, W16, #0x1d, #0x7
    BICS  X16, X29, X21, LSR #28
    CSNEG  W26, W10, W27, HI
    MOVZ  X7, #0x6030, LSL #16
    SUB  W26, W14, W25, UXTB #2
    EON  W17, W29, W17, ASR #24
    BIC  X20, X25, X18, LSL #37
    ORR  W12, W4, #0xc000007f
    CRC32W  W23, W28, W3
    MOVK  X6, #0x8bbd, LSL #48
    ADDS  X23, X28, W20, SXTH #3
    SMULH  X16, X15, X29
    AND  W24, W2, W24, LSR #30
    SMULH  X7, X8, X27
    ADDS  W6, W27, W24, ASR #26
    ANDS  X17, X23, X10, LSR #13
    MOVZ  X14, #0xc892, LSL #48
    ADD  W20, W3, #0x3f1, LSL #12
    SUB  X24, X23, W14, UXTH #4
    EOR  X13, X29, X29, ROR #31
    BIC  X5, X12, X14, ASR #60
    SUBS  X3, X17, #0xbbd, LSL #12
    AND  W13, W6, W25, ASR #31
    CRC32H  W5, W9, W29
    UMSUBL  X29, W12, W20, X29
    CLZ  V21.2S, V9.2S
    ORR  X2, X10, #0xfc7ffc7ffc7ffc7f
    CRC32B  W3, W15, W8
    BIC  X19, X3, X17, LSL #27
    CRC32CB  W19, W26, W26
    EXTR  X17, X16, X7, #0x13
    EOR  X22, X18, #0xfffffff00000001f
    ADDS  W20, W20, W9, ASR #4
    CSINV  W10, W23, W19, NV
    CRC32CH  W22, W16, W5
    SMULH  X4, X16, X15
    CSNEG  W23, W15, W24, CC
    BICS  W19, W14, W16, LSL #22
    ORR  X3, X8, X5, LSL #42
    SUB  X20, X17, W21, SXTB #3
    ADCS  X22, X27, X21
    SUBS  W4, W24, W10, ASR #5
    ADD  W25, W15, W15, SXTH #2
    CRC32CW  W3, W4, W26
    SMADDL  X12, W26, W6, X9
    EOR  W16, W3, W17, LSL #28
    MOVK  W2, #0x310, LSL #0
    SUB  W17, W3, W15, SXTB #0
    ADCS  X17, X18, X29
    ADD  X14, X12, W21, SXTH #1
    EXTR  X24, X28, X28, #0x8
    SUB  X26, X19, X12, LSL #6
    ADD  X20, X4, #0xe72, LSL #12
    SUBS  W26, W21, W2, ASR #21
    CRC32CX  W6, W7, X7
    EOR  W24, W14, #0xe0e0e0e
    ORR  V26.4H, #0x8e, LSL #8
    CRC32CH  W27, W17, W6
    BIC  X2, X20, X17, ROR #59
    ADD  X19, X22, #0x362
    SUBS  X25, X26, X22, LSL #5
    UMADDL  X10, W18, W23, X28
    ANDS  X25, X17, X7, LSL #47
    CSNEG  X19, X4, X29, NV
    CRC32H  W23, W25, W3
    SUB  X26, X15, #0x850
    CSINC  X26, X24, X12, LE
    CSNEG  W23, W22, W4, VS
    ORR  V28.4H, #0x1b, LSL #8
    SUB  W19, W6, W27, UXTX #0
    ADCS  W10, W27, W16
    SMULH  X2, X25, X27
    AND  X2, X26, #0x3f0000003f
    ADD  X17, X27, X9, LSR #23
    UMULH  X18, X20, X25
    SUBS  X27, X17, X19, ASR #15
    SUB  X12, X26, W16, SXTW #0
    SUBS  W2, W8, W26, SXTW #1
    SUB  X7, X21, #0x0
    MADD  X14, X6, X19, X10
    ANDS  W3, W16, #0x1e0
    CRC32CH  W5, W15, W6
    CRC32B  W29, W18, W23
    EXTR  W18, W8, W16, #0x1
    ORR  X15, X27, X4, ASR #47
    EOR  W23, W26, W12, ROR #1
    ADD  W6, W26, W4, SXTX #0
    ADD  W22, W14, W6, ASR #24
    ADDS  X15, X28, W14, UXTH #1
    SUB  W2, W2, W25, LSL #25
    ORR  V2.8B, V7.8B, V5.8B
    ANDS  X12, X10, #0x3c0000000
    LSRV  X27, X28, X4
    SUBS  W29, W13, W18, LSR #4
    CRC32CB  W12, W6, W8
    ANDS  X19, X20, X28, LSL #41
    MOVZ  W15, #0x9398, LSL #16
    CSINV  W16, W13, W20, LT
    ORN  X12, X12, X13, LSR #42
    ASRV  W7, W23, W5
    ADD  X18, X29, #0x9af
    CSEL  W22, W12, W22, NV
    ORR  V6.4S, #0xa6
    SBFM  X20, X2, #0x3, #0x3f
TaishanIntAluP01_label_132:
    BICS  X17, X29, X25, LSL #37
    SMSUBL  X23, W14, W29, X24
    SUBS  X12, X26, #0x227, LSL #12
    UMSUBL  X26, W6, W2, X28
    EOR  W20, W6, W2, ROR #28
    ADDS  X13, X29, X14, ASR #59
    ADDS  W4, W28, #0xc60
    BIC  V29.8B, V26.8B, V22.8B
    ADD  X25, X28, W9, SXTB #2
    ORR  V5.4S, #0x5d, LSL #16
    CLZ  W7, W12
    ORR  V0.8H, #0x48
    CRC32CX  W12, W20, X25
    LSLV  W22, W27, W16
    ADDS  X18, X4, X26, ASR #40
    SUB  W20, W15, #0x530
    AND  X27, X23, #0x800000ffffffffff
    CLZ  X22, X20
    SUB  X6, X13, W2, UXTW #3
    MOVZ  W22, #0xfaff, LSL #0
    SMSUBL  X25, W2, W18, X9
    CSNEG  X18, X28, X7, GT
    ORN  W22, W12, W17, ASR #25
    ORR  V12.8H, #0xf5
    SUB  X22, X22, W22, SXTB #0
    ADD  W10, W16, #0x3b2
    ORR  V29.8B, V7.8B, V31.8B
    MOVK  W18, #0xe5f7, LSL #0
    SMADDL  X2, W8, W7, X20
    AND  X2, X3, X10, LSL #1
    MOVK  X13, #0xf811, LSL #0
    EOR  W28, W28, W9, ASR #25
    CSNEG  W16, W15, W26, EQ
    CRC32X  W25, W14, X9
    MOVZ  W12, #0x487e, LSL #0
    ORN  W29, W19, W4, ASR #15
    CLZ  W15, W3
    CSINV  W7, W4, W6, LT
    CRC32H  W27, W14, W26
    ORR  V19.4S, #0xfb
    ADDS  W7, W3, W9, UXTB #1
    AND  W22, W9, W7, LSR #15
    CSEL  X6, X22, X3, GT
    ADCS  W2, W22, W2
    SUBS  X13, X9, X4, SXTX #2
    CSINC  W9, W5, W27, CC
    ORR  V4.2S, #0x8, LSL #16
    ANDS  W16, W4, #0xfffc001f
    CSEL  X9, X22, X23, GT
    ANDS  W27, W4, #0xfbfbfbfb
    CRC32CW  W19, W19, W9
    MOVK  X19, #0xc6a0, LSL #0
    UBFM  X14, X27, #0x20, #0x2d
    ASRV  X7, X6, X3
    BIC  X6, X19, X24, LSL #57
    SUB  W16, W14, W4, ASR #2
    ORN  X18, X27, X7, ASR #58
    EON  X17, X3, X9, ASR #33
    ANDS  W24, W4, W15, LSL #17
    SUBS  W20, W18, W24, LSR #11
    LSRV  W5, W17, W19
    ANDS  X24, X5, #0xffff0000ffff
    AND  X27, X3, X13, ROR #36
    ADD  X9, X26, X22, LSR #39
    SUB  W7, W10, W16, UXTB #3
    LSRV  W19, W21, W23
    SBFM  W24, W5, #0xb, #0x15
    ORN  X9, X18, X8, ASR #37
    SUBS  X21, X21, #0x1
    B.NE  TaishanIntAluP01_label_561
    MOVZ  X12, #0xc0, LSL #0
    SUB  X8, X12, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X28, #0xc0, LSL #0
    SUB  X24, X28, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X26, #0xdc0, LSL #0
    MOVK  X26, #0x160, LSL #16
    SUB  X13, X26, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X19, #0xff3f, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X9, X19, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X17, #0xc6a0, LSL #0
    SUB  X22, X17, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X16, #0xdde3, LSL #0
    MOVK  X16, #0xfdc3, LSL #16
    SUB  X23, X16, X7
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X16, #0xe263, LSL #0
    MOVK  X16, #0xfdc3, LSL #16
    SUB  X26, X16, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X12
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X15
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X13, #0xe263, LSL #0
    MOVK  X13, #0xfdc3, LSL #16
    SUB  X5, X13, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X13, #0xc6a0, LSL #0
    SUB  X20, X13, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X28, #0xff3f, LSL #0
    MOVK  X28, #0xffff, LSL #16
    SUB  X3, X28, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X24, X7, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X26, #0x2607, LSL #0
    MOVK  X26, #0x5688, LSL #16
    SUB  X22, X26, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x2607, LSL #0
    MOVK  X6, #0x5688, LSL #16
    SUB  X14, X6, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP01_TestFail
    MOVZ  X9, #0xff3f, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X14, X9, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
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
    MOVZ  X9, #0xa, LSL #0
TaishanIntAluP01_label_585:
    SUB  X20, X10, X24, ASR #59
    ADD  W8, W29, #0x119, LSL #12
    ADD  W17, W18, W4, LSL #28
    ADD  X28, X21, W22, SXTH #2
    ADD  X17, X3, X7, LSL #8
    MOVK  X2, #0x12c5, LSL #48
    ADD  W7, W25, #0x9f8
    EOR  W23, W18, W28, LSR #8
    EXTR  X12, X8, X28, #0x22
    SUBS  X6, X27, W15, SXTH #3
    SUB  X7, X20, W4, SXTW #0
    EOR  W26, W21, W22, LSL #30
    MOVK  X29, #0xb501, LSL #16
    ADDS  W2, W13, W26, SXTX #1
    BICS  W29, W2, W13, ROR #24
    ORR  X29, X23, X9, ASR #29
    ANDS  X22, X7, X19, LSR #44
    ASRV  X22, X26, X24
    CSNEG  W18, W23, W23, GE
    UMADDL  X20, W19, W4, X12
    CSEL  W15, W3, W29, GT
    AND  X20, X17, X27, LSL #35
    BIC  W22, W26, W21, ASR #9
    ADD  X13, X17, X22, LSR #51
    ADDS  X24, X3, X9, ASR #37
    MOVN  X13, #0x2cf7, LSL #0
    EOR  W7, W24, W18, ROR #17
    CLZ  W22, W26
    MOVN  W6, #0xe1c0, LSL #16
    EOR  X3, X23, X22, ASR #17
    ORR  V22.4H, #0xbd, LSL #8
    SUB  W23, W15, W29, UXTW #3
    ADD  W19, W13, W6, LSR #13
    CSNEG  W26, W27, W5, LE
    ORR  X20, X21, #0x3f0000000000
    CRC32CW  W24, W21, W14
    SUB  X8, X29, #0x501
    CRC32CX  W14, W22, X14
    UMSUBL  X10, W9, W18, X15
    CSNEG  W24, W23, W15, HI
    ADD  W2, W6, #0xee5, LSL #12
    CSINC  W5, W25, W17, CS
    CRC32CH  W10, W17, W8
    SUB  X10, X21, #0x513, LSL #12
    ADD  W18, W21, W16, LSR #20
    LSLV  X23, X15, X9
    ADD  W24, W14, #0x253
    UBFM  W27, W28, #0x10, #0x9
    CLZ  W8, W17
    SUBS  W27, W21, W13, SXTH #3
    EON  W29, W5, W3, LSR #8
    ANDS  W7, W17, #0xff80003f
    CRC32W  W15, W20, W18
    ORR  V3.4H, #0xed
    ORN  W2, W12, W18, LSR #22
    SBFM  W17, W21, #0x4, #0x11
    CRC32CX  W2, W18, X22
    ADCS  X6, X21, X24
    EOR  X5, X26, X4, LSL #3
    CSINV  W19, W28, W20, LT
    ANDS  W19, W14, W24, ROR #9
    CSINC  X5, X25, X19, LS
    MADD  X21, X28, X10, X15
    ADDS  X24, X27, #0x130
    SUB  W22, W7, W7, UXTB #3
    UMULH  X2, X2, X24
    ADD  W12, W29, W26, LSR #23
    ORR  V11.16B, V29.16B, V9.16B
    ADDS  W24, W20, W12, UXTX #4
    CRC32B  W14, W18, W4
    ADDS  W14, W4, W3, ASR #3
    LSRV  X29, X10, X24
    CRC32W  W6, W26, W23
    MOVK  X19, #0xe0ca, LSL #48
    LSLV  W22, W8, W13
    UMADDL  X25, W14, W24, X13
    MOVK  X27, #0xe520, LSL #48
    CRC32CX  W23, W21, X4
    CRC32X  W23, W21, X29
    ANDS  W23, W6, W18, LSL #26
    CSINV  W6, W22, W23, NV
    EXTR  W20, W28, W10, #0x13
    ANDS  W18, W26, #0xc000000f
    ORR  W2, W2, W21, LSR #29
    AND  X27, X17, #0x1fffffffffffffc
    MOVN  X4, #0x8176, LSL #32
    LSLV  W19, W3, W19
    AND  W5, W16, #0xfc00000
    MADD  X26, X5, X24, X27
    EON  W4, W14, W29, LSL #6
    SUBS  X12, X17, #0x692
    ADCS  X19, X23, X6
    MOVZ  W8, #0x955, LSL #0
    AND  X21, X13, #0xf87ff87ff87ff87f
    MADD  W24, W9, W6, W2
    ADC  W15, W13, W17
    ORR  V14.16B, V11.16B, V31.16B
    ORR  V22.4H, #0x42
    UBFM  W12, W4, #0x17, #0x3
    LSRV  W23, W12, W28
    EOR  X14, X3, X18, LSL #30
    ANDS  W6, W25, W20, ROR #2
    ADDS  X2, X18, #0xa3d, LSL #12
    CLS  W12, W10
    CLZ  W24, W12
    UBFM  W13, W23, #0x18, #0xa
    SUB  W17, W28, #0x2b6, LSL #12
    ORR  X27, X13, X9, ROR #12
    ANDS  W17, W15, #0xffc7ffff
    ADDS  X20, X29, #0x4e7, LSL #12
    CSINC  W5, W2, W15, MI
    MOVZ  X3, #0xa190, LSL #48
    ADD  X18, X26, X12, LSL #44
    ORN  W16, W10, W17, ROR #14
    UMADDL  X14, W20, W8, X24
    ORR  W8, W3, W25, LSR #12
    MOVK  X4, #0x9f10, LSL #32
    CRC32CB  W6, W27, W6
    EOR  W5, W27, #0xfffe0007
    CLZ  X18, X6
    SUBS  X23, X12, X26, ASR #35
    SUB  X21, X17, X27, LSR #56
    ORR  X20, X21, X26, LSR #61
    CSINC  X16, X5, X15, LS
    EOR  W16, W6, #0x1fe01fe0
    SUBS  X12, X14, #0xa74
    EXTR  X14, X18, X12, #0x16
    CRC32CH  W16, W12, W15
    BIC  W4, W8, W26, ASR #15
    LSLV  W6, W4, W29
    CSINC  X23, X13, X15, LE
    ADCS  X5, X9, X23
    ADC  W23, W5, W24
    ADC  W6, W28, W13
    LSLV  X26, X2, X28
    ORN  W8, W18, W10, LSR #11
    ADDS  X15, X20, X8, LSR #41
    MOVK  W5, #0x6c44, LSL #16
    UMSUBL  X2, W5, W14, X8
    EOR  X15, X21, X13, ROR #9
    ANDS  W3, W8, W23, LSR #30
    CRC32CW  W24, W6, W24
    CRC32W  W15, W26, W26
    CLZ  V31.8B, V19.8B
    CRC32B  W28, W12, W9
    EXTR  W14, W18, W3, #0xa
    LSLV  W8, W16, W3
    CRC32H  W5, W15, W13
    SBFM  W19, W18, #0x1c, #0xe
    AND  W18, W16, W6, ASR #13
    MADD  W4, W8, W25, W6
    ASRV  W25, W5, W5
    MOVN  X4, #0x1028, LSL #16
    ADCS  W3, W5, W19
    UBFM  X5, X25, #0x24, #0x14
    SUB  W28, W15, #0x0
    BICS  W7, W10, W28, LSR #30
    ADDS  W24, W28, W24, UXTW #4
    SUB  W21, W15, W14, UXTB #4
    MOVK  X17, #0xbb84, LSL #32
    SUBS  W7, W5, #0xc31
    CSNEG  W5, W27, W10, NE
    UMADDL  X15, W2, W23, X4
    SUB  W21, W25, W21, LSR #28
    CSINC  X26, X9, X24, MI
    BIC  X27, X17, X26, ASR #12
    MADD  W7, W20, W3, W27
    SUB  X4, X16, W29, UXTB #0
    UMSUBL  X16, W21, W23, X4
    BICS  X19, X29, X25, LSL #52
    ORR  V17.4H, #0x35
    EOR  X22, X6, X7, ASR #8
    SUB  X15, X13, X3, ASR #44
    ANDS  W3, W7, W10, ROR #9
    ADDS  X28, X23, W26, UXTW #2
    LSRV  W19, W14, W7
    SUBS  W2, W18, #0x10
    ANDS  W24, W9, W20, LSL #20
    MOVZ  X22, #0x3454, LSL #16
    SUB  X15, X9, X7, UXTX #0
    UMSUBL  X3, W21, W29, X2
    LSLV  X15, X15, X29
    BICS  X16, X15, X7, LSR #7
    BIC  V25.8B, V15.8B, V31.8B
    CSNEG  X17, X5, X16, CS
    ORN  X14, X15, X17, LSL #26
    ADCS  X14, X14, X13
    CRC32CX  W16, W5, X10
    CRC32X  W16, W7, X7
    MOVN  X20, #0x1feb, LSL #48
    BICS  X6, X3, X15, LSL #11
    MOVZ  X23, #0xe22b, LSL #32
    SUBS  X29, X15, W27, UXTH #4
    BICS  W5, W5, W27, ROR #21
    ORR  V0.4H, #0xff
    ORR  W17, W6, W12, ROR #3
    ORR  X21, X27, X15, LSR #43
    EXTR  X29, X29, X25, #0x3d
    ANDS  X17, X5, X2, ASR #21
    UMADDL  X28, W10, W9, X28
    SUBS  X9, X9, #0x1
    B.NE  TaishanIntAluP01_label_585
    MOVZ  X2, #0xa98, LSL #0
    MOVK  X2, #0x5f16, LSL #16
    SUB  X26, X2, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X2, #0xa98, LSL #0
    MOVK  X2, #0x5f16, LSL #16
    SUB  X5, X2, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X20, #0xba8, LSL #0
    MOVK  X20, #0x5f16, LSL #16
    SUB  X2, X20, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X6, #0xa98, LSL #0
    MOVK  X6, #0x1c06, LSL #16
    SUB  X10, X6, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X12, #0xcafd, LSL #0
    MOVK  X12, #0x8f69, LSL #16
    SUB  X2, X12, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x2ea4, LSL #0
    MOVK  X9, #0x7c58, LSL #16
    SUB  X19, X9, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X4, #0x2ea4, LSL #0
    MOVK  X4, #0x7c58, LSL #16
    SUB  X26, X4, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
    MOVZ  X12, #0xcafd, LSL #0
    MOVK  X12, #0x8f69, LSL #16
    SUB  X21, X12, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X3, X18, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xfffe, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X17, X27, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP01_TestFail
    MOVZ  X10, #0x6a08, LSL #0
    MOVK  X10, #0xe12c, LSL #16
    MOVK  X10, #0xfffe, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X14, X10, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X26, X28, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X18
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X19
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP01_TestFail
    MOVZ  X23, #0xba8, LSL #0
    MOVK  X23, #0x5f16, LSL #16
    SUB  X25, X23, X20
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X21
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X27, X25, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP01_TestFail
    MOVZ  X17, #0xba8, LSL #0
    MOVK  X17, #0x5f16, LSL #16
    SUB  X16, X17, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X24
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X26
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X19, #0xd1c0, LSL #0
    MOVK  X19, #0x8fa, LSL #16
    MOVK  X19, #0xfff7, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X29, X19, X29
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
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
    MOVZ  X22, #0x14, LSL #0
TaishanIntAluP01_label_611:
    CSEL  X19, X12, X9, GT
    EOR  X17, X29, X25, LSR #4
    MADD  X28, X19, X4, X22
    AND  X17, X26, X22, ASR #17
    BIC  W5, W17, W27, ASR #25
    EXTR  W5, W6, W23, #0xe
    SUB  X12, X18, #0x94
    ASRV  X12, X6, X12
    CRC32CW  W2, W25, W28
    BIC  V29.8B, V16.8B, V28.8B
    LSRV  W2, W20, W27
    SMADDL  X5, W22, W20, X16
    ADDS  X26, X12, #0x3a3, LSL #12
    EXTR  X8, X20, X2, #0x2
    SUB  W2, W17, #0x6
    ADC  W29, W19, W4
    CRC32H  W4, W17, W27
    SBFM  X27, X3, #0x31, #0x28
    MOVK  W14, #0x664b, LSL #0
    ADD  W14, W14, W28, LSL #16
    CRC32CX  W5, W19, X6
    SBFM  X14, X26, #0x1, #0x3e
    UMSUBL  X8, W4, W26, X8
    CLS  X6, X17
    CRC32X  W2, W18, X14
    BIC  X8, X19, X15, ASR #57
    MOVZ  X6, #0x164d, LSL #16
    SUBS  X21, X3, X12, LSL #37
    CRC32CW  W26, W19, W29
    BIC  W12, W19, W18, LSL #14
    CSEL  W7, W5, W14, EQ
    ORR  X6, X21, #0x7e000000000000
    CRC32CW  W25, W23, W5
    BIC  W28, W14, W29, ROR #1
    SMADDL  X23, W7, W6, X6
    SUB  W17, W21, W14, LSR #6
    CSNEG  X9, X17, X13, HI
    SUBS  X2, X14, #0xc0
    SUBS  W26, W19, #0xb70
    SUBS  X15, X12, #0x5c0, LSL #12
    ORR  X6, X17, X18, LSR #19
    SUBS  X17, X20, X7, LSR #61
    MOVN  X9, #0xfa90, LSL #16
    EOR  W16, W8, #0xff03ff03
    SMADDL  X26, W12, W23, X26
    SUBS  W14, W6, #0x694, LSL #12
    ORN  W18, W25, W2, ASR #21
    ADC  W19, W28, W23
    MOVZ  X26, #0xfaff, LSL #0
    ADD  X9, X29, #0x3c6, LSL #12
    CRC32CB  W5, W5, W2
    CRC32CB  W12, W25, W9
    SUBS  X5, X2, #0x3b0
    ANDS  W26, W22, W15, ASR #14
    ORR  V1.8H, #0x26, LSL #8
    AND  X4, X17, #0x606060606060606
    SUB  W7, W8, W7, UXTW #3
    SMADDL  X6, W22, W22, X12
    MOVK  W13, #0x1ef8, LSL #0
    ORR  W6, W26, W29, LSL #6
    MOVK  X18, #0x6479, LSL #0
    SUBS  W8, W12, #0x8ea, LSL #12
    LSLV  X23, X28, X27
    ANDS  W18, W2, W16, LSL #30
    ORN  X24, X13, X7, LSR #52
    UMADDL  X24, W14, W18, X23
    CRC32CB  W7, W13, W22
    ADD  W26, W5, #0x741
    AND  W27, W29, W13, ASR #17
    AND  X21, X8, #0xfffffffff0000007
    EOR  W21, W24, #0x33333333
    LSRV  X8, X27, X13
    ORN  W8, W26, W6, LSR #7
    SBFM  W12, W19, #0xb, #0x3
    ADCS  W4, W10, W12
    MOVK  X23, #0xc66, LSL #48
    ANDS  X27, X16, #0xbfffbfffbfffbfff
    CSINV  W26, W27, W9, LS
    CSEL  X10, X28, X29, GT
    EOR  W18, W6, W15, LSL #7
    BICS  X24, X14, X15, LSL #50
    EON  W5, W17, W8, LSR #15
    ORR  W12, W22, #0x7ff00000
    ASRV  X19, X17, X18
    SBFM  X5, X9, #0x36, #0x1
    ORR  W20, W24, #0xf9fff9ff
    CLZ  X19, X10
    CRC32B  W20, W26, W18
    UBFM  X29, X23, #0x31, #0x23
    ADC  X13, X22, X14
    CRC32X  W23, W26, X16
    MADD  W9, W14, W27, W15
    CRC32W  W18, W23, W14
    MADD  W15, W8, W23, W8
    SUB  W4, W20, #0x322
    ADDS  X25, X23, #0x4aa
    CRC32CW  W24, W26, W27
    LSRV  X9, X26, X19
    CSNEG  W6, W13, W16, CC
    ORR  X5, X15, #0xfff03fffffffffff
    MOVN  W29, #0xf278, LSL #16
    CLZ  W20, W22
    CRC32H  W18, W8, W6
    ORN  W27, W28, W6, LSR #14
    CSINC  W13, W5, W24, LS
    ANDS  W2, W4, W27, ROR #12
    ASRV  W9, W28, W13
    LSRV  X29, X20, X14
    BIC  X20, X16, X29, LSR #17
    ANDS  W25, W2, W17, ASR #6
    AND  W23, W8, W19, ROR #13
    ADDS  X21, X6, X15, SXTX #4
    SUBS  X29, X25, W12, UXTH #1
    SUBS  W29, W13, W17, ASR #14
    SUBS  X18, X26, X20, ASR #47
    UMSUBL  X18, W23, W10, X28
    AND  W3, W21, #0xfc007fff
    ADDS  W18, W28, #0xa5a, LSL #12
    CRC32CW  W16, W18, W19
    SUBS  W9, W9, #0xfbc
    CRC32W  W12, W29, W12
    CRC32CB  W5, W8, W28
    ADD  W27, W5, W12, LSL #10
    CRC32CH  W28, W24, W22
    MOVZ  W28, #0x985b, LSL #0
    ADC  W12, W3, W12
    ORR  V9.8B, V10.8B, V23.8B
    MOVN  W26, #0x681e, LSL #16
    UBFM  X4, X27, #0x32, #0x31
    MOVN  X4, #0x8a1b, LSL #0
    CLZ  V8.8H, V24.8H
    ASRV  X2, X10, X24
    EOR  X9, X28, #0xf0f0f0f0f0f0f0f
    ORN  W10, W27, W23, LSR #30
    ORR  W10, W12, W7, LSR #6
    BIC  W2, W10, W19, ROR #25
    CSNEG  X16, X25, X13, GT
    LSLV  W7, W4, W21
    BICS  W20, W28, W9, ROR #11
    ORR  V25.4H, #0xf4, LSL #8
    UBFM  X2, X19, #0x21, #0x3b
    ADDS  W17, W20, W14, UXTH #1
    UMADDL  X2, W23, W19, X16
    CSNEG  W7, W3, W26, VS
    ORN  W15, W2, W2, ASR #10
    ADCS  W24, W10, W9
    ADC  X2, X17, X7
    CRC32CW  W8, W3, W20
    ORN  X2, X21, X29, LSR #51
    CSINV  X23, X19, X10, CC
    CLZ  W23, W6
    ASRV  X8, X3, X10
    ADDS  X13, X27, W7, UXTB #4
    EOR  X15, X7, X18, ASR #59
    AND  X4, X8, X2
    UMSUBL  X3, W2, W27, X13
    MOVN  W27, #0x50a2, LSL #16
    SUB  X5, X25, #0xfe0
    MOVZ  W24, #0x1be7, LSL #16
    UBFM  X21, X22, #0x3, #0x28
    UBFM  W8, W27, #0x2, #0x19
    EXTR  X15, X7, X8, #0x32
    CRC32CH  W6, W20, W12
    LSRV  W23, W10, W2
    LSRV  X26, X27, X4
    ORN  X16, X28, X23, LSR #55
    ORR  V25.8B, V16.8B, V4.8B
    UBFM  X5, X7, #0x12, #0x31
    ADC  X14, X20, X5
    ADDS  X12, X12, W16, SXTB #0
    CSEL  W16, W3, W2, EQ
    SMSUBL  X4, W3, W8, X23
    ADDS  W6, W10, W10, LSR #12
    ANDS  W16, W29, #0x11111111
    ANDS  W8, W18, W10, LSL #27
    BIC  X13, X28, X21, ROR #46
    EON  X16, X26, X28, ROR #29
    SUBS  W27, W24, #0x6c6, LSL #12
    ADDS  W16, W5, #0xb16, LSL #12
    EON  W29, W6, W27, LSL #6
    EXTR  X15, X18, X17, #0x2a
    EOR  W28, W23, W17, ASR #17
    CLZ  W14, W22
    ORR  W12, W13, #0x88888888
    ORR  V13.2S, #0x4c, LSL #16
    ADD  X23, X19, W5, SXTB #3
    CSINC  X16, X16, X24, VC
    ADCS  X20, X2, X28
    UBFM  W12, W10, #0x7, #0x1b
    ORR  V25.8H, #0x26
    ORR  V4.8H, #0x4f
    CRC32CW  W12, W20, W15
    ORR  V16.2S, #0x4a, LSL #24
    AND  W16, W29, #0x80001fff
    CRC32CH  W14, W25, W28
    CLZ  W12, W12
    BICS  X20, X13, X24, LSR #48
    EOR  X16, X4, #0x1ff000000000
    ADDS  X2, X23, X18, LSR #37
    CLZ  W12, W29
    SUBS  X22, X22, #0x1
    B.NE  TaishanIntAluP01_label_611
    MOVZ  X16, #0x63, LSL #0
    SUB  X22, X16, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X18, #0x1c4c, LSL #0
    MOVK  X18, #0x4fdf, LSL #16
    MOVK  X18, #0x71e2, LSL #32
    MOVK  X18, #0xd810, LSL #48
    SUB  X5, X18, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X15, #0x1c4d, LSL #0
    MOVK  X15, #0xfde5, LSL #16
    MOVK  X15, #0xc3af, LSL #32
    MOVK  X15, #0xffbc, LSL #48
    SUB  X24, X15, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X5
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X13, #0x5dce, LSL #0
    MOVK  X13, #0xce3c, LSL #16
    SUB  X14, X13, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP01_TestFail
    MOVZ  X18, #0x1, LSL #0
    MOVK  X18, #0x681e, LSL #16
    SUB  X15, X18, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP01_TestFail
    MOVZ  X15, #0x9754, LSL #0
    MOVK  X15, #0xf0f, LSL #16
    MOVK  X15, #0xf0f, LSL #32
    MOVK  X15, #0xf0f, LSL #48
    SUB  X10, X15, X9
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X10
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X12
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X23, #0x5dce, LSL #0
    MOVK  X23, #0xce3c, LSL #16
    SUB  X17, X23, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x9754, LSL #0
    MOVK  X9, #0xf0f, LSL #16
    MOVK  X9, #0xf0f, LSL #32
    MOVK  X9, #0xf0f, LSL #48
    SUB  X29, X9, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X4, #0x63, LSL #0
    SUB  X5, X4, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X18, #0x2b, LSL #0
    SUB  X16, X18, X19
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X24
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X19, X26, X25
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X2, #0xb5bc, LSL #0
    MOVK  X2, #0xb9ac, LSL #16
    MOVK  X2, #0xf0d2, LSL #32
    MOVK  X2, #0x93b5, LSL #48
    MOVZ  X3, #0x868e, LSL #0
    MOVK  X3, #0x620e, LSL #16
    MOVK  X3, #0x7e9c, LSL #32
    MOVK  X3, #0x9c0, LSL #48
    MOVZ  X4, #0x394, LSL #0
    MOVK  X4, #0xa81d, LSL #16
    MOVK  X4, #0xf6e7, LSL #32
    MOVK  X4, #0x9589, LSL #48
    MOVZ  X5, #0xe09f, LSL #0
    MOVK  X5, #0xe621, LSL #16
    MOVK  X5, #0x3523, LSL #32
    MOVK  X5, #0x6aa4, LSL #48
    MOVZ  X6, #0x33cb, LSL #0
    MOVK  X6, #0xe534, LSL #16
    MOVK  X6, #0xcd57, LSL #32
    MOVK  X6, #0xf316, LSL #48
    MOVZ  X7, #0xd90e, LSL #0
    MOVK  X7, #0x3643, LSL #16
    MOVK  X7, #0xd560, LSL #32
    MOVK  X7, #0x7129, LSL #48
    MOVZ  X8, #0xf1b4, LSL #0
    MOVK  X8, #0x72e2, LSL #16
    MOVK  X8, #0x83dc, LSL #32
    MOVK  X8, #0xcb3b, LSL #48
    MOVZ  X9, #0x7058, LSL #0
    MOVK  X9, #0x693f, LSL #16
    MOVK  X9, #0x2f00, LSL #32
    MOVK  X9, #0x7cb, LSL #48
    MOVZ  X10, #0xdca0, LSL #0
    MOVK  X10, #0x2bbc, LSL #16
    MOVK  X10, #0x6ad6, LSL #32
    MOVK  X10, #0xe63d, LSL #48
    MOVZ  X12, #0x9104, LSL #0
    MOVK  X12, #0xf2d4, LSL #16
    MOVK  X12, #0xf8a1, LSL #32
    MOVK  X12, #0x4b55, LSL #48
    MOVZ  X13, #0x8a1e, LSL #0
    MOVK  X13, #0xd78e, LSL #16
    MOVK  X13, #0xe9fe, LSL #32
    MOVK  X13, #0xed22, LSL #48
    MOVZ  X14, #0x1e33, LSL #0
    MOVK  X14, #0x1771, LSL #16
    MOVK  X14, #0xc0ab, LSL #32
    MOVK  X14, #0xad4d, LSL #48
    MOVZ  X15, #0x782, LSL #0
    MOVK  X15, #0x702a, LSL #16
    MOVK  X15, #0x833d, LSL #32
    MOVK  X15, #0x6625, LSL #48
    MOVZ  X16, #0x56df, LSL #0
    MOVK  X16, #0xecc4, LSL #16
    MOVK  X16, #0xc0f5, LSL #32
    MOVK  X16, #0xec25, LSL #48
    MOVZ  X17, #0x8642, LSL #0
    MOVK  X17, #0xd9c5, LSL #16
    MOVK  X17, #0xedc8, LSL #32
    MOVK  X17, #0xa846, LSL #48
    MOVZ  X18, #0xad99, LSL #0
    MOVK  X18, #0x34ab, LSL #16
    MOVK  X18, #0xf09b, LSL #32
    MOVK  X18, #0xaf35, LSL #48
    MOVZ  X19, #0x6c97, LSL #0
    MOVK  X19, #0xae9f, LSL #16
    MOVK  X19, #0x7f36, LSL #32
    MOVK  X19, #0x5f7d, LSL #48
    MOVZ  X20, #0x8162, LSL #0
    MOVK  X20, #0x392f, LSL #16
    MOVK  X20, #0xf506, LSL #32
    MOVK  X20, #0x3f9b, LSL #48
    MOVZ  X21, #0x99dd, LSL #0
    MOVK  X21, #0x9ca, LSL #16
    MOVK  X21, #0xfffc, LSL #32
    MOVK  X21, #0xa32b, LSL #48
    MOVZ  X22, #0x22de, LSL #0
    MOVK  X22, #0xb7ae, LSL #16
    MOVK  X22, #0x9c93, LSL #32
    MOVK  X22, #0xd867, LSL #48
    MOVZ  X23, #0xd681, LSL #0
    MOVK  X23, #0x6ad1, LSL #16
    MOVK  X23, #0x8025, LSL #32
    MOVK  X23, #0x42bf, LSL #48
    MOVZ  X24, #0x658, LSL #0
    MOVK  X24, #0x6776, LSL #16
    MOVK  X24, #0xfb8e, LSL #32
    MOVK  X24, #0x7cd3, LSL #48
    MOVZ  X25, #0x5e6d, LSL #0
    MOVK  X25, #0x626d, LSL #16
    MOVK  X25, #0xf00f, LSL #32
    MOVK  X25, #0x805, LSL #48
    MOVZ  X26, #0x4dc2, LSL #0
    MOVK  X26, #0x78fe, LSL #16
    MOVK  X26, #0xd602, LSL #32
    MOVK  X26, #0x190e, LSL #48
    MOVZ  X27, #0x80c8, LSL #0
    MOVK  X27, #0x3022, LSL #16
    MOVK  X27, #0x68, LSL #32
    MOVK  X27, #0x1434, LSL #48
    MOVZ  X28, #0x7301, LSL #0
    MOVK  X28, #0x279, LSL #16
    MOVK  X28, #0x5e4e, LSL #32
    MOVK  X28, #0x1ed8, LSL #48
    MOVZ  X29, #0xbefb, LSL #0
    MOVK  X29, #0x906c, LSL #16
    MOVK  X29, #0x7446, LSL #32
    MOVK  X29, #0xf850, LSL #48
    MOVZ  X27, #0xa, LSL #0
TaishanIntAluP01_label_636:
    CSNEG  W9, W28, W27, CS
    SMULH  X17, X26, X7
    ADDS  X17, X5, X17, LSR #35
    EXTR  X21, X28, X2, #0x16
    SUBS  W15, W27, W18, LSL #30
    EOR  X21, X22, #0xffffffffc0000007
    CLZ  W26, W29
    CRC32W  W18, W9, W5
    ADDS  X17, X20, #0xd24, LSL #12
    CSINC  X8, X18, X6, LS
    CRC32H  W22, W26, W7
    ORN  W15, W13, W22, LSR #2
    SUB  W28, W2, W19, SXTW #4
    ANDS  X17, X23, X20, ASR #49
    SUB  W12, W7, W4, UXTH #0
    BIC  V27.8B, V2.8B, V13.8B
    ADDS  W18, W17, W14, LSR #5
    BIC  V13.16B, V24.16B, V9.16B
    EOR  W9, W21, #0xff8003ff
    EOR  W24, W22, W17, LSL #4
    SUB  W6, W12, #0x2eb, LSL #12
    ADD  X20, X21, X20, LSL #15
    SUB  W29, W28, #0xe24, LSL #12
    MOVZ  W29, #0x68cc, LSL #0
    EXTR  W18, W13, W2, #0x8
    LSLV  X26, X24, X8
    ADCS  X16, X24, X2
    ADDS  X24, X25, X12, LSL #16
    UMSUBL  X13, W23, W16, X20
    LSRV  W15, W21, W6
    SUBS  X10, X7, X9, LSR #61
    ADD  X22, X4, W17, SXTW #3
    EOR  X22, X24, #0xffffbfffffffbfff
    SUBS  X18, X24, #0x557, LSL #12
    UBFM  X6, X14, #0x2d, #0x34
    SBFM  W17, W28, #0x8, #0x8
    ORR  X15, X10, X27, LSR #46
    AND  W9, W9, #0xe1e1e1e1
    ASRV  W8, W22, W18
    SUBS  W28, W12, W27, LSR #17
    ADD  W7, W4, #0xf24
    CRC32CB  W19, W16, W19
    ADC  X15, X29, X23
    BIC  X9, X23, X28, ROR #33
    CRC32CW  W21, W25, W22
    CRC32CX  W26, W5, X14
    CSEL  W12, W20, W22, PL
    SUB  X3, X13, #0x55b, LSL #12
    CSNEG  X6, X21, X2, AL
    CRC32X  W4, W23, X19
    CRC32X  W2, W9, X15
    MOVK  W5, #0x3f2f, LSL #0
    CRC32CB  W20, W14, W26
    ADD  W16, W2, W17, SXTB #2
    EOR  W13, W21, #0xc1c1c1c1
    ADDS  W4, W16, W7, LSR #3
    CRC32X  W14, W27, X25
    ADD  X29, X3, W26, UXTW #2
    ANDS  X6, X26, X14, LSR #41
    EON  W26, W14, W19, LSL #22
    BICS  X10, X19, X25, LSR #24
    ADDS  X13, X25, #0x39f, LSL #12
    ADDS  W12, W17, W13, LSR #20
    CLZ  X10, X2
    EON  X8, X5, X17, LSL #2
    ORR  X2, X26, X27, LSL #52
    EON  W13, W3, W27, ASR #24
    CRC32B  W4, W21, W22
    CRC32X  W29, W4, X27
    EXTR  W7, W17, W5, #0x1a
    SUB  W20, W16, W2, LSL #11
    AND  W6, W19, #0xe00fe00f
    ADC  W2, W19, W7
    ADCS  W21, W16, W23
    CRC32W  W8, W8, W12
    ADDS  X29, X29, X10, LSR #61
    SBFM  W9, W19, #0x11, #0xc
    UBFM  W9, W27, #0x3, #0x11
    SBFM  X3, X8, #0x1a, #0x3
    CSINV  X13, X8, X24, MI
    ORR  V20.2S, #0x94, LSL #24
    LSRV  W13, W25, W13
    CRC32W  W9, W10, W16
    ORR  V5.16B, V4.16B, V26.16B
    ANDS  X7, X20, X16, LSR #4
    UBFM  W20, W27, #0x1b, #0xe
    CRC32CX  W19, W8, X16
    ORR  V4.4H, #0x9, LSL #8
    ADCS  X2, X9, X4
    ORR  W15, W10, W14, LSR #14
    SUBS  X21, X25, X13, ASR #61
    CSINC  W3, W24, W22, PL
    ADDS  X16, X10, #0x590
    ORR  V26.4S, #0x25, LSL #24
    EON  X12, X25, X13, LSL #37
    EOR  W21, W27, #0x7ffc7ffc
    ADD  X29, X18, X7, ASR #32
    EOR  X2, X3, X21, LSL #11
    EOR  X2, X4, X15, ASR #12
    EOR  X2, X25, #0xe001ffffe001ffff
    EXTR  X29, X26, X23, #0x0
    UMSUBL  X15, W16, W3, X24
    ASRV  W8, W18, W10
    CRC32W  W10, W8, W9
    ANDS  X18, X18, X8, LSR #18
    LSLV  X25, X27, X14
    ADD  W13, W6, W25, ASR #10
    ASRV  W4, W7, W24
    ADCS  W2, W25, W20
    ADCS  X14, X29, X16
    CLZ  W28, W23
    MOVN  W28, #0x912e, LSL #16
    ADC  W14, W3, W5
    CRC32H  W9, W21, W25
    ORR  W14, W2, W21, ROR #20
    SMSUBL  X7, W21, W5, X9
    ADDS  W18, W9, W22, UXTH #4
    ANDS  X12, X21, #0xffffffffe00007ff
    ADD  W10, W21, #0x3b4
    ORR  W8, W17, W18, LSR #26
    ADD  X4, X4, X25, LSL #35
    CLS  X12, X12
    CLS  W18, W15
    UBFM  W9, W23, #0x14, #0x10
    ADDS  X6, X16, #0xb89, LSL #12
    CLZ  W13, W21
    CRC32CX  W8, W12, X29
    ADDS  W9, W21, W20, ASR #2
    CLZ  W14, W29
    LSRV  X4, X26, X13
    AND  X18, X4, #0xffe3ffe3ffe3ffe3
    CLS  W20, W7
    CLS  V16.2S, V25.2S
    CLS  V24.4H, V0.4H
    ADDS  X25, X16, #0x357
    SUBS  W23, W14, W27, LSL #27
    BICS  X26, X3, X23, ROR #17
    CLZ  X13, X9
    ADD  X16, X7, X9, LSR #24
    SUBS  W25, W20, W22, LSR #21
    EOR  W21, W12, #0xfe000007
    ORR  X19, X10, #0x7ffff8007ffff8
    UMULH  X21, X14, X21
    ADDS  W22, W29, W15, LSR #23
    CSEL  X7, X5, X20, LT
    CLS  X16, X4
    MOVK  W21, #0x56d4, LSL #0
    UMSUBL  X16, W17, W17, X22
    EON  W29, W10, W21, LSL #13
    ADC  X13, X22, X25
    SUB  X23, X26, X9, ASR #35
    ASRV  W12, W20, W14
    ANDS  W21, W22, #0xff000007
    EXTR  X24, X18, X12, #0x25
    CLS  W29, W5
    UMULH  X6, X28, X12
    SUBS  W7, W21, W4, UXTX #3
    ADDS  X26, X3, X15, ASR #40
    MOVZ  X7, #0xef7f, LSL #48
    UMSUBL  X7, W23, W29, X10
    EON  W8, W22, W12, LSR #1
    ADDS  X2, X24, #0x91a, LSL #12
    LSRV  X8, X25, X16
    MADD  W4, W12, W23, W25
    CLS  X15, X5
    ANDS  X25, X7, X12, LSR #50
    ADD  W4, W6, #0x35e
    CLS  W8, W24
    CRC32CH  W12, W7, W6
    ADCS  W17, W27, W26
    LSRV  X5, X10, X22
    CSINV  X25, X13, X17, AL
    ADD  X28, X28, X19, LSL #6
    LSRV  X8, X24, X8
    MOVK  W7, #0x94eb, LSL #16
    EXTR  X2, X29, X25, #0x1b
    ADDS  X15, X26, X6, LSL #47
    SUB  X12, X22, X22, LSL #35
    MOVK  W3, #0xe255, LSL #0
    UBFM  W6, W19, #0x19, #0xe
    ADC  X4, X29, X20
    LSRV  W17, W19, W21
    BIC  X19, X5, X3, LSR #10
    BICS  X28, X13, X3, LSL #13
    LSLV  X12, X29, X15
    ADD  W29, W9, W20, UXTX #1
    ADD  X19, X20, W2, UXTW #0
    SBFM  X24, X4, #0x1c, #0x1
    ADDS  X4, X16, X6, UXTX #0
    UBFM  X8, X6, #0x3, #0x17
    MOVZ  X8, #0xa0dc, LSL #16
    SUB  X29, X6, #0xe4e
    SUBS  W12, W5, W18, ASR #1
    SUBS  X21, X4, X2, LSL #15
    ADCS  W21, W9, W5
    AND  X7, X10, X12, ROR #54
    UMSUBL  X22, W3, W12, X9
    ADDS  X7, X29, X2, ASR #21
    CRC32H  W4, W27, W20
    BIC  V18.8B, V17.8B, V12.8B
    SUBS  X27, X27, #0x1
    B.NE  TaishanIntAluP01_label_636
    MOVZ  X28, #0x3c, LSL #0
    MOVK  X28, #0x220, LSL #32
    SUB  X7, X28, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP01_TestFail
    MOVZ  X26, #0xe255, LSL #0
    MOVK  X26, #0x84ea, LSL #16
    SUB  X3, X26, X3
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X6, #0xff, LSL #0
    SUB  X20, X6, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP01_TestFail
    MOVZ  X14, #0xff, LSL #0
    SUB  X7, X14, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X3, X14, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xa0dc, LSL #16
    SUB  X5, X27, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X16, #0x8005, LSL #0
    MOVK  X16, #0x7ffc, LSL #16
    SUB  X7, X16, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x83b1, LSL #0
    MOVK  X8, #0x7ffc, LSL #16
    SUB  X10, X8, X10
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X12, #0xe47e, LSL #0
    MOVK  X12, #0xd22f, LSL #16
    SUB  X19, X12, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X25, X5, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X15, #0xa86, LSL #0
    MOVK  X15, #0x84ea, LSL #16
    SUB  X21, X15, X15
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X23, #0x8005, LSL #0
    MOVK  X23, #0x7ffc, LSL #16
    SUB  X22, X23, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP01_TestFail
    MOVZ  X27, #0x3902, LSL #0
    MOVK  X27, #0x5ba0, LSL #16
    SUB  X7, X27, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X15, X6, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x8005, LSL #0
    MOVK  X6, #0x7ffc, LSL #16
    SUB  X13, X6, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0xffe0, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X12, X6, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X2, #0xe255, LSL #0
    MOVK  X2, #0x84ea, LSL #16
    SUB  X26, X2, X26
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x3c, LSL #0
    MOVK  X9, #0x220, LSL #32
    SUB  X27, X9, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP01_TestFail
    MOVZ  X9, #0xee32, LSL #0
    MOVK  X9, #0x3f, LSL #16
    SUB  X4, X9, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
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
    MOVZ  X15, #0xa, LSL #0
TaishanIntAluP01_label_663:
    CLS  W10, W8
    SBFM  W12, W19, #0x1b, #0x2
    ANDS  W7, W9, W4, ASR #18
    ORR  V26.4S, #0xdb, LSL #16
    UMADDL  X25, W14, W5, X2
    SUB  W2, W14, W22, ASR #11
    CSINV  W9, W17, W29, LS
    MOVK  W22, #0x573a, LSL #0
    EON  W27, W20, W7, LSL #8
    ADCS  W25, W14, W3
    UMADDL  X19, W3, W28, X15
    ORR  V7.8H, #0xb3, LSL #8
    LSRV  W29, W10, W9
    SUB  X26, X2, X17, SXTX #0
    SMADDL  X12, W7, W25, X12
    ADD  X27, X8, #0x6d0
    CSINV  X16, X23, X5, CS
    UMSUBL  X14, W29, W16, X23
    CRC32CX  W10, W20, X24
    LSRV  W25, W14, W18
    UMSUBL  X13, W22, W20, X8
    ANDS  W23, W10, #0xffffe00
    CLS  X25, X18
    UBFM  X29, X27, #0x2c, #0x2e
    CRC32CW  W4, W8, W21
    SUB  W14, W16, W28, LSR #18
    ADDS  W25, W2, W20, LSR #4
    UMSUBL  X17, W17, W6, X27
    ADD  W5, W29, W27, UXTW #3
    ANDS  W16, W17, W10, LSR #0
    CRC32W  W18, W7, W14
    ADDS  W17, W29, W16, SXTB #2
    CSEL  W27, W14, W10, GT
    ADD  X5, X13, X19, ASR #5
    EXTR  W10, W18, W13, #0x14
    EOR  X27, X27, #0xc000c000c000c0
    AND  X9, X14, X2, ASR #59
    EON  X7, X12, X25, ASR #37
    CRC32CX  W12, W7, X17
    ORR  V25.8H, #0xc5, LSL #8
    ADC  X12, X26, X4
    SUBS  W25, W6, W29, UXTX #3
    MOVN  W2, #0xb1d0, LSL #16
    CSINV  W27, W9, W3, VC
    CLZ  W18, W17
    ADCS  W23, W12, W28
    SUBS  W16, W27, W22, LSL #18
    ORR  V21.4H, #0x6c, LSL #8
    SUB  X23, X13, X16, ASR #11
    SBFM  X22, X9, #0x2b, #0x12
    BIC  V22.16B, V7.16B, V18.16B
    ADDS  X19, X6, X23, LSR #62
    MOVZ  W25, #0x8352, LSL #0
    MOVZ  X16, #0xb8e, LSL #16
    SUBS  W19, W24, W28, UXTB #2
    ASRV  W19, W14, W16
    SUB  X7, X2, X9, LSL #59
    ORR  W29, W18, W27, LSR #20
    BICS  W2, W27, W29, LSR #11
    ADC  X4, X16, X23
    CSINV  X9, X22, X3, LE
    BICS  X10, X7, X21, ROR #8
    CLZ  W23, W22
    MOVK  W7, #0x699, LSL #0
    CSINV  W17, W20, W19, VS
    ADDS  W22, W25, W22, LSR #5
    CSINV  W19, W27, W4, PL
    ADD  W9, W23, W28, SXTX #0
    CRC32H  W8, W2, W20
    EON  W7, W17, W14, LSR #9
    AND  W17, W12, W6, ROR #15
    EOR  W29, W13, W16, LSL #21
    CSINC  W21, W10, W17, NV
    SUB  W3, W27, #0x331
    AND  W12, W17, #0x380000
    CSINC  W16, W14, W17, MI
    ADCS  W29, W9, W2
    LSLV  W27, W21, W13
    ORR  X2, X16, #0x7ffffe007ffffe
    ADD  X25, X3, X7, ASR #62
    SUB  W5, W10, #0x9ff
    EON  X20, X10, X9, ROR #38
    EOR  W12, W15, W2, ROR #31
    BICS  W4, W3, W25, ROR #30
    ORR  X18, X5, #0x7fc000007fc00
    LSLV  W23, W21, W16
    CSINV  W9, W8, W23, LT
    SUB  X5, X28, W29, UXTB #0
    BICS  X2, X6, X5, ROR #45
    ORR  V10.16B, V12.16B, V29.16B
    CLS  V16.4H, V30.4H
    SUBS  X17, X19, W12, UXTB #0
    AND  X10, X6, #0x380000
    MOVN  X27, #0x4a51, LSL #16
    AND  W20, W29, W24, LSR #30
    EOR  W9, W16, W4, LSR #4
    ANDS  X12, X5, #0x800f800f800f800f
    BIC  W7, W14, W5, ROR #25
    MADD  W18, W25, W16, W6
    SUB  X20, X9, #0xd41, LSL #12
    EOR  X4, X3, #0x707070707070707
    EON  W7, W15, W12, LSL #2
    EOR  X29, X12, X7, ROR #33
    SUB  X21, X18, X23, LSL #18
    SUBS  X26, X15, W20, UXTW #3
    MOVZ  W5, #0x8948, LSL #0
    CSEL  W2, W22, W19, MI
    CLS  W2, W17
    ADC  X21, X26, X5
    SUBS  W26, W15, #0x0
    ORR  X26, X22, X20, LSL #21
    CRC32X  W19, W26, X17
    SUBS  W21, W27, W10, LSL #15
    CLZ  V29.4H, V25.4H
    CLS  W19, W15
    CRC32CX  W4, W17, X5
    ORR  W29, W21, W29, LSR #31
    ADD  W19, W2, #0x9f7, LSL #12
    UMSUBL  X20, W6, W4, X19
    BICS  X17, X20, X5, LSR #37
    AND  X26, X14, X23, ASR #32
    MADD  W18, W26, W27, W4
    ORN  W2, W10, W29, LSL #28
    AND  W7, W21, W17
    UMULH  X7, X26, X4
    MOVZ  W2, #0x331c, LSL #16
    MADD  X8, X10, X15, X20
    SMADDL  X23, W21, W18, X21
    CSINV  W10, W16, W28, VC
    MOVK  X17, #0xf6c9, LSL #32
    CLZ  X12, X9
    SUBS  X7, X9, #0x63a, LSL #12
    ORR  W16, W22, W2, LSL #15
    CLZ  V11.4H, V24.4H
    ADD  X10, X16, X7, LSL #52
    MADD  X26, X21, X12, X16
    CSEL  X13, X17, X5, LE
    ADDS  W19, W19, W26, SXTB #0
    MOVZ  W16, #0x24e7, LSL #0
    SUB  W17, W9, W3, LSR #15
    SUB  X2, X3, #0xd94, LSL #12
    ORR  X19, X17, #0xfffffe03fffffe03
    ANDS  X24, X19, X22, ROR #20
    BIC  W22, W5, W6, ROR #6
    MOVZ  W16, #0xa8a6, LSL #0
    SMSUBL  X28, W4, W18, X17
    ANDS  X5, X8, #0xfe07ffffffffffff
    AND  W24, W13, W2, ASR #22
    CRC32W  W26, W15, W23
    EXTR  W10, W17, W9, #0x10
    BIC  X22, X9, X20, LSL #16
    ORR  V24.8H, #0x33
    CSINV  X29, X2, X26, PL
    MOVZ  X16, #0x6d90, LSL #16
TaishanIntAluP01_label_225:
    CSINV  W22, W9, W27, CS
    MOVZ  X16, #0x2412, LSL #16
    LSRV  W23, W24, W29
    SBFM  X23, X2, #0x11, #0x2b
    SBFM  X28, X25, #0x28, #0x11
    ADD  W18, W19, #0xc6e
    ORR  V28.16B, V14.16B, V26.16B
    MOVN  X25, #0x29e4, LSL #0
    ORR  V22.8B, V23.8B, V1.8B
    BIC  X14, X6, X16, ROR #27
    ORN  X5, X16, X2, ASR #36
    UMSUBL  X26, W27, W19, X24
    SUBS  W26, W27, W6
    ADDS  W17, W26, W25, SXTX #4
    ADDS  X6, X2, X25, UXTX #1
    BIC  V21.8B, V2.8B, V20.8B
    UMSUBL  X28, W27, W29, X16
    AND  W29, W18, W16, ROR #16
    AND  X5, X12, #0xffff000fffff000f
    BIC  W12, W26, W26, ASR #1
    CRC32W  W14, W25, W12
    MADD  W21, W20, W8, W17
    ADC  X22, X4, X21
    CSINV  X5, X24, X14, EQ
    ADD  W24, W5, #0xdaf, LSL #12
    SUBS  W9, W12, #0x73e
    ADCS  X16, X19, X27
    MOVN  W6, #0xa71a, LSL #0
    CLS  W2, W22
    CLZ  W22, W28
    CRC32H  W8, W29, W28
    CRC32B  W7, W2, W5
    CLS  V15.16B, V28.16B
    ORR  W20, W22, W12, ROR #30
    SUBS  X10, X27, X21, LSL #34
    EON  X16, X24, X24, LSL #62
    SUB  X10, X22, #0x852, LSL #12
    CSINV  W12, W14, W7, AL
    CLS  W6, W7
    ADD  W29, W9, #0x2f3, LSL #12
    MOVK  W6, #0x845d, LSL #0
    SUB  W28, W7, W3, ASR #23
    MOVZ  W16, #0x90b0, LSL #16
    ADD  X24, X12, X22, LSR #48
    LSRV  X10, X25, X23
    ORR  V18.16B, V4.16B, V30.16B
    SUBS  X15, X15, #0x1
    B.NE  TaishanIntAluP01_label_663
    MOVZ  X19, #0x0, LSL #0
    SUB  X27, X19, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP01_TestFail
    MOVZ  X13, #0xfccf, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X22, X13, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X17, #0xea3e, LSL #0
    MOVK  X17, #0x3cfd, LSL #16
    SUB  X12, X17, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X17, #0x30ea, LSL #0
    MOVK  X17, #0x20b9, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X25, X17, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X28, #0x845d, LSL #0
    SUB  X17, X28, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP01_TestFail
    MOVZ  X14, #0xb66, LSL #0
    MOVK  X14, #0x40df, LSL #16
    SUB  X3, X14, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP01_TestFail
    MOVZ  X29, #0xa2c6, LSL #0
    MOVK  X29, #0x4c2b, LSL #16
    SUB  X17, X29, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP01_TestFail
    MOVZ  X21, #0x3ae4, LSL #0
    MOVK  X21, #0x2528, LSL #16
    SUB  X28, X21, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0x1fff, LSL #32
    SUB  X25, X21, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP01_TestFail
    MOVZ  X15, #0xb66, LSL #0
    MOVK  X15, #0x40df, LSL #16
    SUB  X10, X15, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X26, #0xb66, LSL #0
    MOVK  X26, #0x40df, LSL #16
    SUB  X23, X26, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X21, X9, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X12, #0xb3d, LSL #0
    SUB  X18, X12, X18
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X21
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X21, #0xcf15, LSL #0
    MOVK  X21, #0xdf46, LSL #16
    SUB  X15, X21, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X26
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP01_TestFail
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
    MOVZ  X13, #0x14, LSL #0
TaishanIntAluP01_label_687:
    ADD  W23, W26, #0x415, LSL #12
    SMSUBL  X28, W4, W5, X15
    SBFM  X19, X22, #0xc, #0x1a
    EOR  W29, W22, W29, LSL #12
    UMADDL  X27, W29, W17, X12
    ORN  W26, W19, W18, ASR #10
    CSEL  X21, X10, X25, CS
    ORR  X17, X16, X14, LSR #39
TaishanIntAluP01_label_382:
    SUB  W6, W13, #0x393
    SMULH  X19, X23, X6
    ORR  V22.8H, #0x66, LSL #8
    CSINV  X15, X4, X24, VC
    CRC32X  W25, W22, X9
    CLS  V29.4S, V31.4S
    UBFM  W25, W25, #0x7, #0x1d
    SMULH  X18, X5, X27
    EOR  X6, X20, X12, ROR #49
    CSEL  X20, X29, X20, CS
    CLZ  W21, W19
    MOVK  X15, #0xdbc4, LSL #16
    SUBS  X26, X10, X7, LSL #49
    ANDS  X20, X14, X17, LSR #58
    CRC32H  W16, W28, W8
    ADCS  X20, X3, X14
    CSINV  W27, W29, W8, GT
    CRC32B  W27, W21, W24
    BIC  X27, X4, X3, ROR #47
    ANDS  X9, X19, #0xffe00000ffe
    CRC32B  W19, W28, W5
    CRC32CH  W2, W21, W25
    CRC32X  W22, W19, X19
    ANDS  X27, X7, #0x4000000040000
    AND  X9, X26, X15, ROR #63
    MOVZ  W2, #0x767e, LSL #16
    MADD  X27, X12, X22, X23
    ANDS  X27, X20, X3, LSR #12
    ADDS  W6, W13, W18, SXTB #1
    ORR  W6, W3, W19, ASR #5
    SUB  W15, W8, W18, SXTW #1
    AND  X22, X12, #0xfbfbfbfbfbfbfbfb
    CRC32X  W25, W13, X21
    CSINC  X6, X3, X2, GT
    BIC  W25, W6, W9, LSL #29
    MOVN  W7, #0xeae3, LSL #0
    SUB  X22, X29, X25, ASR #61
    ANDS  X22, X23, X22, LSR #6
    EOR  W5, W28, #0xf807f807
    ORN  X8, X20, X22, LSL #21
    ANDS  W15, W6, W13, LSL #19
    CRC32CW  W20, W25, W8
    EON  X28, X13, X12, LSR #45
    SUB  X28, X29, W26, SXTW #2
    MOVK  X9, #0xe391, LSL #16
    CLZ  V13.2S, V0.2S
    AND  X3, X9, X10, LSR #23
    EOR  W16, W5, #0xfe1fffff
    SUBS  X6, X27, #0xd06, LSL #12
    ANDS  W27, W15, #0x1f80
    AND  X16, X15, X13, LSL #46
    CRC32CH  W25, W29, W13
    EOR  W3, W9, #0xffff000
    ORR  X5, X10, X3, LSL #6
    SUBS  X28, X20, X10, LSR #25
    ADC  W17, W22, W16
    CLS  V10.4S, V8.4S
    BICS  W2, W12, W9, ROR #4
    CRC32B  W18, W14, W12
    UBFM  X24, X6, #0x30, #0x3f
    CSINV  X8, X26, X12, NE
    MOVK  W3, #0x28eb, LSL #0
    ANDS  X16, X6, #0xff07ff07ff07ff07
    BIC  W26, W9, W28, LSR #20
    CLS  W14, W26
    BIC  X16, X28, X20, ASR #24
    ORR  X10, X4, X10
    LSLV  X16, X24, X15
    SUBS  W28, W28, W12, UXTW #3
    MOVZ  W12, #0xf6cd, LSL #0
    ANDS  X16, X8, #0x7c00000000000
    ORR  W6, W16, #0x1fffff
    CLS  W26, W15
    ORR  V26.16B, V12.16B, V26.16B
    ORR  W8, W24, W8, LSR #10
    MOVZ  X15, #0x6b0f, LSL #48
    CLS  X8, X2
    SMSUBL  X26, W17, W2, X3
    SMULH  X17, X14, X18
    ANDS  X6, X17, #0x1f8000000000
    ADD  X26, X15, #0x3af
    MOVZ  W29, #0xe138, LSL #0
    SUB  X10, X29, #0xe7e, LSL #12
    BIC  X2, X4, X12, ASR #5
TaishanIntAluP01_label_618:
    CRC32CB  W7, W4, W21
    ANDS  X28, X26, #0xfffe0000
    ORR  X24, X26, X8, ROR #15
    EXTR  W7, W2, W8, #0xf
    MOVN  X12, #0x67ab, LSL #16
    AND  W10, W23, #0xf3f3f3f3
    ORN  W16, W25, W25, LSL #24
    SUBS  X29, X10, #0x7a0
    SMSUBL  X16, W13, W18, X9
    SUBS  W20, W7, #0x40a, LSL #12
    CRC32CB  W5, W26, W7
    EON  W23, W3, W20, LSR #25
    SMADDL  X3, W24, W15, X26
    SUB  W27, W13, W2, UXTH #4
    EOR  X23, X23, X19, ASR #62
    AND  W12, W6, #0xe0007fff
    AND  X28, X15, X16, ROR #25
    CLS  V20.4H, V7.4H
    ORR  X23, X18, X9, LSL #63
    CRC32CW  W20, W5, W18
    ADD  W14, W6, W25, ASR #27
    LSLV  W8, W2, W8
    SMSUBL  X8, W26, W5, X20
    ADC  X12, X5, X18
    ORR  W12, W12, #0xf000f00
    CLZ  W24, W17
    MADD  W20, W3, W4, W22
    MOVN  W20, #0x69c2, LSL #0
    SMSUBL  X15, W7, W21, X9
    ADCS  W27, W27, W28
    MOVZ  W14, #0x1659, LSL #0
    ORR  V6.8B, V4.8B, V12.8B
    SUBS  W20, W29, W2, SXTW #1
    MOVN  W28, #0xbbb3, LSL #0
    ANDS  W20, W17, #0xffffe001
    SUBS  X29, X8, #0x503, LSL #12
    AND  X24, X14, X21, ROR #13
    ORN  W21, W4, W24
    ORR  X3, X2, X27, LSL #2
    CLZ  W23, W29
    CLZ  X26, X2
    LSRV  W18, W15, W7
    ADDS  X24, X7, X23, UXTX #0
    EOR  X19, X7, X6, LSR #12
    AND  W25, W20, #0x40000000
    ANDS  W18, W2, #0xf83fffff
    CRC32CW  W23, W2, W17
    EOR  X15, X12, #0xbbbbbbbbbbbbbbbb
    SMULH  X28, X21, X29
    ORR  X3, X23, X24, ASR #27
    AND  X26, X17, X18, LSR #46
    ADDS  W15, W24, W5, LSR #14
    ORN  W20, W2, W18, LSL #2
    CSINC  X8, X6, X26, GE
    ASRV  X12, X6, X20
    CRC32CH  W5, W7, W21
    BIC  V7.16B, V5.16B, V21.16B
    SUBS  W12, W17, #0x0
    CSNEG  X29, X20, X3, CS
    CSINV  W14, W24, W17, GE
    CRC32W  W28, W29, W3
    ORN  W6, W15, W8, LSL #18
    CLZ  X28, X6
    ORR  V2.8B, V3.8B, V28.8B
    BICS  X5, X17, X28, ROR #43
    ADDS  X2, X7, X24, LSL #55
    EON  W5, W6, W21, LSL #15
    CLZ  X23, X9
    CSEL  W2, W7, W27, LS
    CSINC  W26, W23, W18, VS
    CSINV  W15, W18, W15, LS
    CSINC  W6, W19, W6, CS
    ASRV  X29, X28, X7
    CRC32H  W23, W22, W28
    SUBS  X20, X27, W8, UXTW #3
    SMADDL  X3, W5, W25, X5
    MOVN  W26, #0x6d87, LSL #0
    EOR  W2, W19, W24, LSR #4
    MADD  W29, W23, W13, W26
    ANDS  W20, W19, W9, ASR #20
    MOVK  X7, #0xc0f6, LSL #0
    UBFM  W17, W25, #0x12, #0x9
    SUB  W19, W10, W17, LSR #30
    LSRV  X7, X21, X22
    SMADDL  X6, W7, W22, X17
    SUB  W18, W29, W18, UXTX #3
    ADDS  W4, W9, #0x5a4, LSL #12
    UMADDL  X9, W7, W8, X27
    CSEL  X15, X4, X2, VS
    MOVN  W19, #0x4d7c, LSL #0
    AND  W25, W18, W26, LSL #2
    AND  W18, W5, W21, LSL #29
    MOVZ  X10, #0x3c3a, LSL #0
    ADC  X5, X27, X26
    AND  X18, X28, X20, LSR #19
    ADD  W15, W16, W22, LSL #5
    MOVK  X15, #0x8188, LSL #16
    MOVZ  W3, #0x37ef, LSL #0
    CSEL  W23, W10, W18, LS
    CLZ  V30.16B, V24.16B
    CSNEG  X28, X17, X17, PL
    EOR  W12, W7, #0xc000000f
    LSRV  W22, W19, W8
    EON  X28, X13, X10, LSR #17
    SUB  W19, W29, W22, ASR #19
    CRC32X  W15, W10, X5
    CSINC  W6, W28, W23, MI
    CSINC  W16, W16, W29, LS
    SUBS  X13, X13, #0x1
    B.NE  TaishanIntAluP01_label_687
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x8800, LSL #16
    SUB  X26, X2, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x37ef, LSL #0
    SUB  X28, X20, X3
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x4000, LSL #0
    MOVK  X9, #0xe3eb, LSL #16
    SUB  X3, X9, X4
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP01_TestFail
    MOVZ  X27, #0x927a, LSL #0
    MOVK  X27, #0xfffb, LSL #16
    MOVK  X27, #0x1, LSL #32
    SUB  X8, X27, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X8, #0xfffe, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X15, X8, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X2, X29, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP01_TestFail
    MOVZ  X10, #0xfffe, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X13, X10, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X29, #0x4000, LSL #0
    MOVK  X29, #0xe3eb, LSL #16
    SUB  X19, X29, X9
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntAluP01_TestFail
    MOVZ  X20, #0xfffe, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X15, X20, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X9, #0xf, LSL #0
    MOVK  X9, #0xc000, LSL #16
    SUB  X28, X9, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X12, X9, X13
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x8000, LSL #16
    SUB  X6, X9, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X29, X12, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X21, #0xe26f, LSL #0
    MOVK  X21, #0x5351, LSL #16
    SUB  X8, X21, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X5, X17, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X28, X7, X18
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X19
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP01_TestFail
    MOVZ  X27, #0xfffe, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X10, X27, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X6, #0xe26f, LSL #0
    MOVK  X6, #0x5351, LSL #16
    SUB  X8, X6, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X3, #0xd941, LSL #0
    MOVK  X3, #0x7fff, LSL #16
    SUB  X13, X3, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X4, #0x3c3a, LSL #0
    SUB  X23, X4, X23
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x8000, LSL #16
    SUB  X6, X18, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x60, LSL #0
    MOVK  X20, #0x69c2, LSL #16
    SUB  X13, X20, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X12, #0xfffe, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X9, X12, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X6, X25, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP01_TestFail
    MOVZ  X2, #0xe750, LSL #0
    MOVK  X2, #0x6cec, LSL #16
    MOVK  X2, #0x25c4, LSL #32
    MOVK  X2, #0xa1fb, LSL #48
    MOVZ  X3, #0x23b5, LSL #0
    MOVK  X3, #0x5dc3, LSL #16
    MOVK  X3, #0x3fcb, LSL #32
    MOVK  X3, #0x5512, LSL #48
    MOVZ  X4, #0x3f4b, LSL #0
    MOVK  X4, #0xbd94, LSL #16
    MOVK  X4, #0x918, LSL #32
    MOVK  X4, #0xf513, LSL #48
    MOVZ  X5, #0x99c0, LSL #0
    MOVK  X5, #0x7171, LSL #16
    MOVK  X5, #0x6cdc, LSL #32
    MOVK  X5, #0xd943, LSL #48
    MOVZ  X6, #0x5e30, LSL #0
    MOVK  X6, #0x4af0, LSL #16
    MOVK  X6, #0x2ada, LSL #32
    MOVK  X6, #0xc102, LSL #48
    MOVZ  X7, #0x2370, LSL #0
    MOVK  X7, #0xee58, LSL #16
    MOVK  X7, #0x7cdf, LSL #32
    MOVK  X7, #0x56f0, LSL #48
    MOVZ  X8, #0xe4a6, LSL #0
    MOVK  X8, #0xee74, LSL #16
    MOVK  X8, #0xf7d2, LSL #32
    MOVK  X8, #0x408c, LSL #48
    MOVZ  X9, #0x8cce, LSL #0
    MOVK  X9, #0xe072, LSL #16
    MOVK  X9, #0x73f7, LSL #32
    MOVK  X9, #0xd04b, LSL #48
    MOVZ  X10, #0xc102, LSL #0
    MOVK  X10, #0xa938, LSL #16
    MOVK  X10, #0x4a1a, LSL #32
    MOVK  X10, #0x6899, LSL #48
    MOVZ  X12, #0xc628, LSL #0
    MOVK  X12, #0xa64e, LSL #16
    MOVK  X12, #0x6751, LSL #32
    MOVK  X12, #0x7d02, LSL #48
    MOVZ  X13, #0x9849, LSL #0
    MOVK  X13, #0x2f1d, LSL #16
    MOVK  X13, #0xe51e, LSL #32
    MOVK  X13, #0x6cf0, LSL #48
    MOVZ  X14, #0x1b, LSL #0
    MOVK  X14, #0x3681, LSL #16
    MOVK  X14, #0x6a5a, LSL #32
    MOVK  X14, #0x2d2b, LSL #48
    MOVZ  X15, #0x6992, LSL #0
    MOVK  X15, #0xfe2a, LSL #16
    MOVK  X15, #0xa2a8, LSL #32
    MOVK  X15, #0x8297, LSL #48
    MOVZ  X16, #0x13ec, LSL #0
    MOVK  X16, #0xab13, LSL #16
    MOVK  X16, #0x20c8, LSL #32
    MOVK  X16, #0x45a8, LSL #48
    MOVZ  X17, #0x753, LSL #0
    MOVK  X17, #0x8327, LSL #16
    MOVK  X17, #0x28cf, LSL #32
    MOVK  X17, #0x7ec8, LSL #48
    MOVZ  X18, #0x3227, LSL #0
    MOVK  X18, #0xae73, LSL #16
    MOVK  X18, #0x8b78, LSL #32
    MOVK  X18, #0x8f2, LSL #48
    MOVZ  X19, #0x31c5, LSL #0
    MOVK  X19, #0xa900, LSL #16
    MOVK  X19, #0xbaa1, LSL #32
    MOVK  X19, #0x96d0, LSL #48
TaishanIntAluP01_label_573:
    MOVZ  X20, #0x9ba1, LSL #0
    MOVK  X20, #0x7f8, LSL #16
    MOVK  X20, #0x9886, LSL #32
    MOVK  X20, #0x27ab, LSL #48
    MOVZ  X21, #0x22ea, LSL #0
    MOVK  X21, #0xce54, LSL #16
    MOVK  X21, #0x342e, LSL #32
    MOVK  X21, #0xfca2, LSL #48
    MOVZ  X22, #0x4014, LSL #0
    MOVK  X22, #0xb2f6, LSL #16
    MOVK  X22, #0xc343, LSL #32
    MOVK  X22, #0x52ee, LSL #48
    MOVZ  X23, #0xa160, LSL #0
    MOVK  X23, #0xdea5, LSL #16
    MOVK  X23, #0xc0f2, LSL #32
    MOVK  X23, #0x9c9c, LSL #48
    MOVZ  X24, #0x828c, LSL #0
    MOVK  X24, #0x752e, LSL #16
    MOVK  X24, #0x1cbd, LSL #32
    MOVK  X24, #0x322e, LSL #48
    MOVZ  X25, #0x3dc4, LSL #0
    MOVK  X25, #0xe542, LSL #16
    MOVK  X25, #0xb7ea, LSL #32
    MOVK  X25, #0x3c92, LSL #48
    MOVZ  X26, #0xe949, LSL #0
    MOVK  X26, #0x599a, LSL #16
    MOVK  X26, #0x2c5f, LSL #32
    MOVK  X26, #0xdfcc, LSL #48
    MOVZ  X27, #0x84e5, LSL #0
    MOVK  X27, #0x677b, LSL #16
    MOVK  X27, #0x752d, LSL #32
    MOVK  X27, #0xaf56, LSL #48
    MOVZ  X28, #0x3204, LSL #0
    MOVK  X28, #0x5afb, LSL #16
    MOVK  X28, #0xa6d6, LSL #32
    MOVK  X28, #0x9e30, LSL #48
    MOVZ  X29, #0x1c0e, LSL #0
    MOVK  X29, #0x2e38, LSL #16
    MOVK  X29, #0x94e4, LSL #32
    MOVK  X29, #0xf42d, LSL #48
    MOVZ  X18, #0xa, LSL #0
TaishanIntAluP01_label_710:
    MOVN  W25, #0xa8ec, LSL #0
    ANDS  W4, W29, W13, ROR #31
    ADD  W10, W27, W13, UXTH #2
    ORN  X24, X27, X22, ROR #45
    SUBS  X4, X26, X27, LSL #46
    CSEL  W3, W23, W7, LE
    EON  X3, X28, X20, ASR #40
    ADDS  W16, W12, W12, UXTB #4
    SBFM  W27, W27, #0x13, #0xa
    CLZ  X7, X16
    ADCS  W8, W14, W24
    SUBS  X8, X22, X4, LSR #13
    ADD  X15, X25, #0x401, LSL #12
    MOVZ  W20, #0x489a, LSL #16
    ORR  W2, W15, #0xffff8
    AND  X3, X8, X17, ASR #37
    BIC  X2, X18, X17, LSL #6
    ORR  W12, W3, #0xf8f8f8f8
    MADD  X9, X2, X27, X7
    SMADDL  X29, W4, W10, X25
    ADD  W17, W4, W18, ASR #3
    CSINV  W5, W14, W17, VS
    EOR  X13, X5, X4, LSR #44
    ADD  X23, X21, X13, LSR #1
    ADDS  W6, W23, W8, LSL #13
    ADDS  X5, X27, X20, LSL #56
    ASRV  W8, W10, W7
    CLS  X24, X8
    LSRV  W4, W19, W5
    EOR  X8, X26, X6, ASR #31
    CSINC  X13, X29, X26, LE
    ADDS  X8, X19, #0x889
    ORR  W25, W21, W4, LSR #26
    ANDS  X29, X28, #0x7e7e7e7e7e7e7e7e
    CLS  X23, X21
    CRC32B  W23, W19, W6
    SUBS  W10, W4, #0x183, LSL #12
    CRC32CX  W9, W3, X23
    UBFM  X5, X23, #0x31, #0x1f
    UMADDL  X22, W23, W4, X19
    CSINV  W16, W21, W5, LS
    SUB  W22, W27, W7, LSL #9
    ADD  X15, X27, W25, SXTH #2
    CSINC  W15, W23, W16, CC
    LSRV  X24, X9, X19
    ORN  W12, W26, W9, ASR #2
    ADDS  W13, W22, W28, LSL #22
    ADD  X5, X9, W9, UXTW #0
    AND  X7, X3, #0xffffff8000
    SUBS  X25, X3, W17, SXTB #0
    CSEL  X24, X7, X6, VS
    SUB  W10, W29, #0x429, LSL #12
    EXTR  W13, W22, W24, #0xc
    ADDS  X14, X12, X25, ASR #3
    SUBS  X23, X29, X18, UXTX #2
    ORR  X22, X10, X6, LSR #48
    SUB  X24, X18, X14, LSR #7
    CSEL  W17, W28, W24, LS
    SUBS  W10, W6, W20, LSR #31
    CRC32CX  W8, W15, X12
    SUB  W20, W9, W21, SXTB #2
    SUBS  W3, W22, W4, ASR #4
    ANDS  W3, W17, #0xffc003ff
    ASRV  W20, W26, W28
    ASRV  W12, W13, W10
    ANDS  X3, X9, X5, LSL #54
    EXTR  X29, X18, X5, #0x11
    ORR  V31.8B, V28.8B, V2.8B
    ADD  X9, X7, X6, LSL #26
    BIC  V5.8B, V16.8B, V14.8B
    SBFM  X15, X22, #0x1e, #0x17
    UBFM  X16, X16, #0x4, #0x17
    ADD  X10, X27, W20, SXTB #4
    CRC32CH  W17, W22, W13
    EOR  W28, W16, #0x600
    SMSUBL  X12, W18, W7, X19
    LSLV  X23, X25, X8
    CRC32CW  W22, W25, W21
    BIC  V12.8B, V6.8B, V11.8B
    EOR  X3, X15, X6, ROR #35
    SUBS  W29, W4, #0xe88, LSL #12
    SUB  X24, X16, X9, LSL #5
    BICS  X29, X16, X26, ROR #62
    ADD  X3, X17, X10, LSL #58
    SUB  X17, X21, W23, SXTB #4
    ORR  W4, W8, W26, ROR #28
    SMULH  X14, X7, X13
    MADD  W3, W24, W28, W4
    CLZ  W7, W10
    EOR  W26, W13, W20, ROR #19
    MOVN  X22, #0x5df6, LSL #16
    BIC  V15.16B, V17.16B, V4.16B
    ADD  X12, X20, #0xe64
    UMSUBL  X17, W26, W18, X2
    UMULH  X10, X27, X22
    CRC32CB  W6, W22, W2
    BICS  W3, W21, W3, ASR #6
    ORR  V3.4S, #0xf, LSL #24
    CLZ  V24.16B, V21.16B
    LSRV  W12, W29, W8
    SUB  X5, X7, W24, SXTH #2
    EON  W2, W14, W3, LSR #6
    CLZ  X8, X13
    MOVZ  W2, #0xa314, LSL #16
    ORN  W10, W3, W28, ASR #31
    ASRV  W2, W6, W6
    SUBS  X24, X8, X27, ASR #57
    ADDS  W9, W26, W8, LSR #16
    BIC  W25, W15, W9, LSL #21
    ADD  W27, W22, W25, LSR #25
    BICS  W7, W4, W19, LSL #21
    SMADDL  X10, W10, W26, X26
    CRC32X  W28, W14, X18
    CRC32H  W27, W28, W4
    ADCS  W26, W7, W7
    ADDS  X26, X15, #0xc34
    EON  X26, X6, X28, LSL #10
    ANDS  W6, W29, #0xffff0007
    UBFM  X4, X10, #0x33, #0x1d
    ADCS  X15, X24, X12
    CSINV  X5, X6, X8, NV
    SMADDL  X6, W8, W28, X9
    ASRV  X27, X8, X18
    MOVN  W2, #0x360d, LSL #0
    EOR  X2, X9, X17, ROR #6
    ADD  X6, X16, W23, UXTB #4
    EOR  X26, X8, #0xc0000000000
    CLZ  W26, W14
    ADD  W19, W2, #0x6db, LSL #12
    BICS  X7, X18, X7, LSL #1
    SBFM  X15, X6, #0xa, #0x28
    ADDS  X26, X7, W12, UXTB #1
    CSINC  W7, W9, W9, VS
    ADC  X16, X27, X12
    ANDS  W4, W13, #0xeeeeeeee
    CLS  X6, X24
    UMULH  X4, X28, X26
    ADDS  X6, X6, X19, LSR #32
    SUB  X19, X6, #0x384, LSL #12
    SMULH  X5, X23, X15
    ORR  V8.4S, #0x4c, LSL #8
    MOVK  W4, #0x8469, LSL #0
    CSEL  W23, W27, W8, LT
    ORR  W7, W23, #0xfffff0ff
    CLS  V26.8B, V29.8B
    MOVZ  X16, #0x752f, LSL #32
    UMULH  X23, X8, X27
    SUB  W27, W13, W21, UXTX #4
    ORR  X24, X14, X6, LSR #19
    EON  X24, X9, X7, LSL #18
    SUB  X24, X28, W25, SXTH #1
    MOVK  W3, #0x71da, LSL #0
    EXTR  W24, W26, W27, #0x8
    ADC  X4, X24, X13
    ADCS  X22, X21, X28
    ADD  X19, X19, X16, LSL #17
    CLZ  W28, W23
    ORN  W3, W24, W17, ROR #15
    ADC  W3, W27, W22
    ORR  V21.2S, #0x3
    BIC  V13.8B, V14.8B, V12.8B
    CLZ  W6, W19
    ORR  V23.2S, #0x1b, LSL #16
    EON  W27, W4, W26, LSR #19
    ADDS  X8, X22, W9, UXTW #3
    SUB  X8, X13, X4, LSR #8
    SUB  X27, X6, X10, LSR #34
    CRC32CX  W28, W9, X28
    ADDS  X27, X25, X12, ASR #62
    AND  X4, X28, #0xfe00000
    CSINV  X22, X12, X26, GE
    LSLV  W15, W9, W21
    CRC32W  W28, W12, W3
    ADDS  X3, X20, X16, UXTX #4
    CSINV  X6, X27, X3, CS
    AND  X27, X26, X21, ASR #57
    SUB  X16, X10, X19, ASR #34
    SMSUBL  X25, W22, W8, X22
    ADD  W19, W8, W13, ASR #1
    CRC32H  W14, W18, W15
    ASRV  W26, W17, W4
    ORR  W27, W21, #0xff7fff7f
    BICS  X9, X6, X27, LSR #22
    EXTR  X25, X16, X28, #0x1f
    ADC  W12, W18, W23
    ADD  W26, W26, W26, LSL #30
    CRC32W  W17, W6, W12
    ORR  V10.4S, #0xcf, LSL #8
    UBFM  W16, W28, #0x11, #0x14
    CLS  W6, W3
    ADDS  X17, X28, X2, LSL #46
    ADDS  W25, W6, W22, UXTW #3
    AND  X8, X17, X17, ASR #43
    ADDS  X23, X25, #0xcb2
    MOVK  X25, #0x18c1, LSL #48
    SBFM  W8, W6, #0x15, #0xd
    ADDS  X29, X29, W26, UXTW #3
    ASRV  W4, W22, W20
    CSINC  W3, W12, W14, LS
    EOR  X15, X29, X29, LSR #4
    SUBS  X18, X18, #0x1
    B.NE  TaishanIntAluP01_label_710
    MOVZ  X23, #0x66f4, LSL #0
    MOVK  X23, #0x3c24, LSL #16
TaishanIntAluP01_label_52:
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0x87ff, LSL #48
    SUB  X8, X23, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x1, LSL #0
    SUB  X25, X2, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X5, #0x65, LSL #0
    SUB  X22, X5, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X4, #0x65, LSL #0
    SUB  X26, X4, X5
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X4, #0xa, LSL #0
    SUB  X15, X4, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X15, #0xf0ff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X16, X15, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP01_TestFail
    MOVZ  X15, #0xf802, LSL #0
    MOVK  X15, #0x1f, LSL #16
    MOVK  X15, #0xad0f, LSL #32
    MOVK  X15, #0xfff8, LSL #48
    SUB  X3, X15, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x1, LSL #32
    SUB  X8, X22, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X25, #0x1, LSL #0
    SUB  X16, X25, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP01_TestFail
    MOVZ  X23, #0xe51c, LSL #0
    MOVK  X23, #0xc008, LSL #16
    SUB  X14, X23, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X8, #0xf802, LSL #0
    MOVK  X8, #0x1f, LSL #16
    MOVK  X8, #0xad0f, LSL #32
    MOVK  X8, #0xfff8, LSL #48
    SUB  X12, X8, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X17, #0x29, LSL #0
    MOVK  X17, #0xe2ad, LSL #16
    MOVK  X17, #0x19bd, LSL #48
    SUB  X26, X17, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x73ff, LSL #0
    MOVK  X20, #0x9e81, LSL #16
    SUB  X24, X20, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X7, #0x73ff, LSL #0
    MOVK  X7, #0x9e81, LSL #16
    SUB  X27, X7, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP01_TestFail
    MOVZ  X22, #0x22ea, LSL #0
    MOVK  X22, #0xce54, LSL #16
    MOVK  X22, #0x342e, LSL #32
    MOVK  X22, #0xfca2, LSL #48
    SUB  X27, X22, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP01_TestFail
    MOVZ  X23, #0x22ea, LSL #0
    MOVK  X23, #0xce54, LSL #16
    MOVK  X23, #0x342e, LSL #32
    MOVK  X23, #0xfca2, LSL #48
    SUB  X15, X23, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X22, #0x22ea, LSL #0
    MOVK  X22, #0xce54, LSL #16
    MOVK  X22, #0x342e, LSL #32
    MOVK  X22, #0xfca2, LSL #48
    SUB  X6, X22, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntAluP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X5, X12, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntAluP01_TestFail
    MOVZ  X24, #0x1, LSL #0
    SUB  X16, X24, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X12, #0x29, LSL #0
    MOVK  X12, #0xe2ad, LSL #16
    SUB  X7, X12, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP01_TestFail
    MOVZ  X12, #0xc017, LSL #0
    MOVK  X12, #0xf939, LSL #16
    MOVK  X12, #0x3, LSL #32
    SUB  X15, X12, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
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
    MOVZ  X5, #0xa, LSL #0
TaishanIntAluP01_label_734:
    BIC  V12.8B, V29.8B, V2.8B
    CRC32B  W15, W12, W25
    CSINC  W10, W7, W9, AL
    SUBS  W18, W26, #0x38a, LSL #12
    ADDS  X24, X6, X8, ASR #15
    MADD  X26, X26, X4, X14
    UMULH  X19, X28, X21
    CSINV  W22, W3, W22, CC
    SBFM  W21, W5, #0x7, #0x1a
    ADD  W21, W26, W19, ASR #30
    SUBS  X3, X28, W21, UXTH #1
    CRC32CB  W25, W9, W5
    BIC  V25.8B, V29.8B, V16.8B
    MADD  X2, X15, X7, X22
    LSLV  X9, X28, X29
    AND  W4, W24, W29, LSL #20
    SMSUBL  X16, W13, W17, X26
    EXTR  X19, X22, X14, #0x1b
    LSLV  W13, W3, W29
    ORN  W19, W3, W4, ASR #31
    ANDS  X21, X2, #0xe0e0e0e0e0e0e0e
    SUB  W25, W9, W17, SXTW #2
    ADDS  W26, W16, W22, UXTW #0
    BIC  V17.16B, V12.16B, V11.16B
    ADD  X3, X6, X25, LSL #1
    ADC  X26, X16, X14
    ADDS  W12, W4, W13, LSL #24
    SUB  X29, X4, X19, SXTX #4
    CSEL  X24, X26, X21, EQ
    ORN  X13, X12, X29, LSR #63
    MOVN  X14, #0xed6c, LSL #48
    CSINC  X3, X29, X15, EQ
    SBFM  X16, X24, #0x2f, #0x28
    SBFM  W19, W26, #0x17, #0x2
    ADDS  W9, W10, W19, LSL #12
    ADDS  X12, X4, X13, ASR #62
    CSINV  X21, X14, X5, NV
    SUBS  X12, X15, X29, ASR #1
    SUBS  W3, W18, W4, UXTW #4
    CRC32CW  W3, W16, W16
    SUB  W23, W8, #0x62b
    SUB  W9, W9, W17, LSR #20
    BIC  X10, X25, X9, ROR #0
    ORR  V9.4S, #0x36, LSL #16
    SUBS  X27, X3, W26, UXTW #3
    EOR  X7, X14, #0xff0003ffff0003ff
    CRC32B  W29, W7, W12
    CRC32B  W8, W3, W22
    LSRV  X8, X14, X22
    ORN  X9, X2, X14, ROR #4
    EOR  W16, W24, #0xff00003f
    ORR  X23, X21, #0x8000800080008
    ORR  W23, W18, #0x400040
    ANDS  X4, X19, #0xe000ffffe000ffff
    AND  X25, X17, #0x1fffffffffff00
    CRC32X  W16, W18, X9
    ANDS  X10, X13, X9, LSR #22
    CLS  W8, W25
    AND  X29, X24, X23, LSL #58
    UBFM  W4, W5, #0x18, #0x1f
    AND  W24, W28, W5, LSR #22
    ADD  X27, X13, X10, LSL #31
    UMULH  X23, X5, X28
    CSINV  W19, W5, W28, LS
    BIC  W18, W10, W14, ROR #25
    ORR  W10, W21, W15, LSR #25
    MOVZ  X18, #0xda0d, LSL #32
    SBFM  W24, W23, #0x19, #0xb
    UBFM  X27, X22, #0x4, #0x18
    ADC  W22, W17, W5
    ORR  X6, X29, X16, ROR #52
    ANDS  X21, X17, #0xffffff800000001f
    CLS  W29, W29
    CRC32CH  W3, W15, W22
    CRC32CW  W8, W13, W14
    CRC32CW  W22, W26, W16
    CLS  W22, W21
    LSLV  W3, W17, W17
    MOVK  W12, #0x2a0c, LSL #16
    LSLV  W2, W20, W20
    CRC32CH  W7, W6, W10
    UMADDL  X18, W27, W27, X15
    CLS  W19, W17
    EOR  X6, X8, X27, LSR #48
    SUB  X12, X27, #0xbb4, LSL #12
    CSNEG  X23, X3, X25, VC
    SUB  W21, W13, W4, UXTW #1
    CSINC  W26, W19, W21, LT
    UMULH  X25, X9, X14
    EOR  W14, W19, #0xc001c001
    CLZ  X2, X7
    AND  W8, W28, #0xffff83ff
    ADDS  X7, X20, X5, LSR #4
    CRC32CX  W22, W8, X24
    CLZ  W4, W26
    ADC  W19, W15, W20
    ASRV  X10, X29, X26
    CRC32CH  W6, W29, W25
    SUBS  W24, W10, W25, SXTW #0
    CSINV  W19, W26, W8, PL
    CSINC  W14, W16, W5, HI
    SMSUBL  X7, W7, W27, X17
    ORR  W24, W4, W13
    CLS  X12, X29
    UMADDL  X26, W15, W22, X17
    EXTR  W10, W24, W3, #0x5
    BICS  W17, W9, W27, ASR #24
    SMULH  X16, X18, X19
    SUB  W12, W20, W26, UXTX #1
    CRC32H  W19, W27, W23
    SUB  X23, X15, X9, ASR #45
    EXTR  X23, X14, X24, #0x1e
    ORR  X23, X3, #0xffff8
    AND  X7, X22, X8, LSR #9
    ANDS  X2, X12, X29, ROR #6
    ANDS  W24, W3, #0xffe7ffff
    ADC  W10, W23, W21
    BICS  W17, W25, W28, ASR #1
    ANDS  X4, X10, X18, LSL #40
    CSINV  X4, X13, X17, GT
    MOVN  X14, #0xace3, LSL #0
    ADD  W28, W13, #0xcd4, LSL #12
    LSRV  W16, W28, W26
    ADD  X14, X3, W24, SXTW #2
    MOVK  X4, #0x61b, LSL #16
    SUB  X16, X5, W8, SXTB #0
    MADD  W2, W29, W13, W6
    EXTR  W14, W28, W3, #0x6
    CSEL  W6, W26, W10, AL
    SBFM  W15, W22, #0x14, #0x1a
    LSRV  W9, W20, W23
    ADC  W25, W4, W14
    SUB  X18, X20, #0x7b7, LSL #12
    CRC32B  W29, W8, W28
    CRC32CX  W16, W27, X12
    ADDS  W21, W17, W26, ASR #12
    CRC32CW  W18, W19, W10
    LSLV  W3, W17, W2
    AND  X4, X8, X29, ROR #34
    CSINV  X25, X20, X14, NV
    LSLV  W21, W21, W16
    AND  W9, W21, #0x1c001c0
    ADDS  X19, X8, W17, SXTB #1
    ADC  W7, W22, W3
    ORR  V29.8H, #0xc8
    CLZ  V6.8H, V9.8H
    CSINV  X19, X21, X29, MI
    MOVK  X12, #0x7bcc, LSL #16
    ADDS  W12, W21, #0x9e0
    UMULH  X15, X9, X19
    BIC  W15, W25, W6, ROR #14
    LSRV  W28, W12, W21
    BICS  X18, X7, X8, LSR #12
    SBFM  X19, X20, #0x1c, #0x32
    SUBS  X4, X16, X20, SXTX #2
    EON  X4, X4, X3, ASR #9
    ORR  V20.4H, #0x6a
    BIC  X20, X4, X20, ROR #16
    SUB  X15, X18, W13, SXTH #0
    SBFM  W12, W6, #0x14, #0x8
    ADD  W12, W10, W14, LSL #6
    CSEL  W8, W12, W19, AL
    ORR  V7.8B, V28.8B, V4.8B
    ORR  X25, X25, X27, LSL #24
    BIC  X2, X25, X7, LSR #33
    ORR  V31.4S, #0xd3, LSL #16
    SBFM  X12, X24, #0x3b, #0x21
    ADD  W27, W14, #0x6c3, LSL #12
    ADD  W2, W15, W23, SXTW #0
    CRC32CW  W18, W3, W28
    CRC32H  W15, W25, W14
    ADD  W13, W14, W14, LSR #29
    SBFM  W16, W29, #0xe, #0x7
    CRC32B  W7, W6, W17
    SMULH  X3, X13, X2
    ORR  V17.8H, #0x8a, LSL #8
    CSINV  W20, W8, W14, LE
    EOR  W6, W15, #0xf8000fff
    ADDS  W23, W18, W27, LSR #11
    ADC  W20, W13, W6
    SUBS  X2, X24, X12, LSL #34
    CSNEG  W16, W7, W2, NE
    BICS  X24, X21, X13, ROR #25
    AND  X15, X24, X17, ASR #47
    BICS  X2, X29, X24, LSL #53
    SMULH  X15, X6, X12
    EOR  X21, X17, #0xbfffbfffbfffbfff
    CRC32W  W4, W6, W28
    MOVK  W12, #0x48b3, LSL #0
    EON  W10, W8, W2, LSL #10
    EOR  W16, W18, W12, LSL #27
    ANDS  W20, W22, W29, ROR #12
    CRC32CH  W3, W27, W14
    MOVN  X22, #0x65b6, LSL #0
    CSEL  X28, X22, X16, MI
    BIC  X16, X21, X27, LSL #57
    SBFM  X21, X29, #0x1f, #0x37
    SUBS  W27, W24, #0x76, LSL #12
    ANDS  X27, X14, #0xffe07fffffe07fff
    UMULH  X23, X29, X19
    SUBS  X5, X5, #0x1
    B.NE  TaishanIntAluP01_label_734
    MOVZ  X6, #0xd389, LSL #0
    MOVK  X6, #0x97da, LSL #16
    SUB  X7, X6, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP01_TestFail
    MOVZ  X20, #0xb1dc, LSL #0
    MOVK  X20, #0x30e3, LSL #16
    SUB  X24, X20, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X4, #0xc6d4, LSL #0
    MOVK  X4, #0x8ca, LSL #16
    SUB  X27, X4, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X25, X8, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X17, #0xd389, LSL #0
    MOVK  X17, #0x97da, LSL #16
    SUB  X7, X17, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X8
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x40, LSL #0
    MOVK  X9, #0x180, LSL #16
    SUB  X24, X9, X9
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x5c09, LSL #0
    MOVK  X9, #0x9420, LSL #16
    SUB  X23, X9, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X7, #0x48b3, LSL #0
    MOVK  X7, #0x831, LSL #16
    SUB  X12, X7, X12
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X29, #0x627, LSL #0
    MOVK  X29, #0xf801, LSL #16
    SUB  X24, X29, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X7, #0x620, LSL #0
    MOVK  X7, #0xf801, LSL #16
    SUB  X21, X7, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X9, X20, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X24, #0xd389, LSL #0
    MOVK  X24, #0x97da, LSL #16
    SUB  X10, X24, X17
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X28, #0xa13e, LSL #0
    MOVK  X28, #0x2334, LSL #16
    SUB  X20, X28, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP01_TestFail
    MOVZ  X5, #0x1, LSL #0
    SUB  X16, X5, X19
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X21, X9, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntAluP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X18, #0xd389, LSL #0
    MOVK  X18, #0x97da, LSL #16
    SUB  X2, X18, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X25, X20, X25
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X21, #0xa75a, LSL #0
    MOVK  X21, #0x6269, LSL #16
    MOVK  X21, #0x8c2d, LSL #32
    MOVK  X21, #0x1f5c, LSL #48
    SUB  X17, X21, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntAluP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntAluP01_TestFail
    MOVZ  X21, #0x627, LSL #0
    MOVK  X21, #0xf801, LSL #16
    SUB  X9, X21, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
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
    MOVZ  X16, #0x14, LSL #0
TaishanIntAluP01_label_759:
    EON  W15, W24, W17, ROR #31
    EOR  W25, W19, W26, ASR #19
    EOR  W5, W5, #0xf00ff00f
    MADD  X27, X4, X10, X19
    ADD  W27, W29, W27, LSR #27
    CLZ  X24, X9
    ADC  W5, W29, W14
    ADD  W5, W13, W2, ASR #9
    SMSUBL  X21, W28, W13, X5
    CRC32CX  W7, W26, X2
    MOVZ  W25, #0xa37c, LSL #0
    LSRV  W13, W13, W8
    MOVZ  X10, #0x27e9, LSL #32
    SUB  W20, W2, W26, SXTX #2
    ORN  X12, X2, X13, LSR #48
    SUBS  X27, X26, X15, UXTX #4
    CRC32H  W15, W17, W9
    SUBS  W12, W23, #0x5f5, LSL #12
    CRC32CB  W15, W21, W26
    SUBS  X5, X3, W14, SXTH #1
    EOR  X28, X18, X2, LSL #61
    ORR  W9, W28, #0x3ffffc0
    ADD  W20, W9, W27, ASR #21
    SBFM  W3, W9, #0x7, #0x1c
    ANDS  X7, X25, X7, LSL #27
    ADCS  W2, W26, W21
    AND  X27, X27, X29, LSR #41
    ORR  W21, W14, #0xfffffc07
    CRC32H  W28, W17, W23
    EOR  X28, X29, #0xfffffff81fffffff
    ANDS  X14, X22, #0xe0000000e00000
    SUBS  X9, X3, W13, SXTB #4
    SUBS  W27, W9, W2, UXTX #3
    CLS  W10, W2
    MOVZ  W28, #0xf390, LSL #16
    ADDS  W3, W3, #0x20a
    ADDS  X22, X12, #0x687
    ADCS  W2, W28, W14
    LSRV  W18, W3, W13
    SUB  W8, W15, W7, ASR #10
    CLS  W12, W13
    MOVN  X6, #0x65c0, LSL #0
    AND  W20, W23, #0x8000800
    AND  W6, W3, #0xffffff9f
    BICS  X24, X28, X23, ROR #26
    EXTR  W22, W10, W13, #0x18
    CSNEG  X13, X15, X15, LS
    LSRV  X21, X3, X20
    MOVN  X14, #0xc30a, LSL #32
    CSEL  X25, X18, X3, MI
    CLZ  W18, W7
    UBFM  X2, X3, #0x1e, #0x1f
    CSINC  X29, X7, X22, GE
    ADD  W21, W3, W7, LSR #20
    EOR  W25, W7, #0x7800780
    SMSUBL  X6, W14, W26, X17
    ORR  W26, W14, #0xfefefefe
    CLZ  V17.8H, V19.8H
    EON  W25, W22, W15, ROR #29
    SUBS  X10, X26, #0xdfa
    CRC32CW  W26, W23, W26
    ANDS  X9, X15, X25, LSL #47
    UBFM  X29, X3, #0x9, #0x2e
    ORR  X29, X13, X17, LSL #22
    UBFM  X4, X26, #0x35, #0x2
    UBFM  W21, W3, #0x16, #0x10
    ADD  X2, X16, #0xa2a, LSL #12
    SMSUBL  X17, W9, W10, X18
    SUBS  X22, X10, X4, LSR #19
    ADD  X5, X20, X27, LSR #48
    UBFM  W21, W27, #0x4, #0xd
    CSEL  W5, W20, W10, MI
    UBFM  W3, W14, #0x8, #0x5
    SUB  X26, X23, W20, UXTB #3
    BICS  W29, W29, W8, ASR #25
    EOR  W27, W29, #0x1ff8
    ORN  X10, X16, X17, LSR #55
    SUBS  X20, X7, #0x743, LSL #12
    EOR  W24, W18, #0x2000200
    ADD  W13, W27, W20, UXTH #1
    SBFM  X26, X7, #0x20, #0x5
    ORR  W18, W25, W25, ROR #26
    ORN  W13, W23, W4, LSL #1
    UMSUBL  X25, W24, W20, X8
    UMULH  X6, X21, X17
    CRC32X  W4, W6, X24
    SUBS  W3, W17, #0x8ba, LSL #12
    CRC32B  W25, W22, W26
    ASRV  X28, X14, X29
    UBFM  W24, W16, #0x0, #0xb
    UBFM  W24, W4, #0x1e, #0x8
    ADC  X6, X26, X6
    CSNEG  X24, X24, X9, LT
    ORR  V23.2S, #0x75, LSL #16
    UBFM  X13, X25, #0x31, #0x21
    UBFM  X6, X17, #0x2f, #0x2f
    ANDS  X15, X18, #0xffffffffff0003ff
    LSLV  W17, W13, W3
    BICS  W28, W7, W28, ASR #21
    CRC32B  W15, W17, W6
    ORR  W13, W2, #0xe0001fff
    MADD  X19, X23, X10, X15
    SMSUBL  X8, W15, W19, X5
    SUBS  X12, X23, X5, UXTX #4
    BIC  W6, W20, W12, LSR #7
    EOR  X9, X15, X28, ROR #25
    CLZ  X18, X16
    ADC  X19, X20, X17
    ADCS  W5, W10, W9
    ORR  V2.2S, #0x9c
    CSINC  W2, W21, W16, PL
    CSINV  W18, W3, W5, NV
    EOR  W22, W23, #0x1fc0000
    EON  W26, W12, W17, LSR #17
    SUBS  X19, X14, W23, UXTW #4
    SUBS  X3, X28, #0x0
    SBFM  W15, W16, #0x15, #0x1c
    LSRV  X20, X10, X8
    SUBS  X21, X9, X22, ASR #14
    EXTR  X20, X12, X9, #0x15
    MOVN  X5, #0xb08d, LSL #16
    SUBS  W15, W17, #0xe4f, LSL #12
    MADD  W27, W2, W3, W12
    ADDS  W25, W21, W24, SXTX #4
    CSINV  W29, W16, W19, NV
    CLS  V2.4S, V22.4S
    ADD  W24, W20, #0x1b8, LSL #12
    CLS  V15.2S, V4.2S
    SMSUBL  X13, W9, W13, X28
    ANDS  X23, X26, #0x1ff000001ff0000
    ADDS  W14, W23, W2, SXTH #2
    CRC32B  W5, W21, W14
    CLZ  V11.16B, V0.16B
    ADCS  W2, W2, W17
    CLS  X29, X24
    SBFM  W7, W13, #0x5, #0x14
    ADCS  W19, W3, W6
    ADC  X8, X12, X24
    ASRV  W13, W12, W7
    ORN  X7, X4, X20, ASR #0
    CLS  X15, X19
    CSINV  W18, W23, W19, NV
    SMADDL  X26, W18, W4, X20
    ANDS  X27, X9, #0xfffc0000fffc000
    EXTR  X4, X4, X2, #0xf
    SUBS  X15, X2, W26, SXTW #0
    EOR  W20, W12, W25, ASR #8
    EOR  X17, X17, X29, LSL #21
    LSRV  W3, W2, W12
    ADD  X29, X9, #0x450
    CLS  W12, W18
    ORR  V3.8B, V14.8B, V5.8B
    CSNEG  W17, W19, W13, AL
    ORR  W12, W15, W29, LSL #31
    ADDS  X2, X24, X29, LSR #42
    ADCS  W5, W15, W2
    MADD  X18, X6, X22, X8
    ADD  W8, W26, #0x852, LSL #12
    CLZ  X24, X24
    MOVZ  X29, #0xb4f8, LSL #16
    ANDS  W15, W13, #0xf0000fff
    BIC  W8, W28, W23, LSL #7
    SBFM  W9, W25, #0x2, #0x7
    ADD  X23, X17, W10, UXTH #1
    ADDS  W12, W25, W9, ASR #13
    MOVN  W19, #0x4a15, LSL #0
    ADD  X10, X20, W3, UXTW #2
    ADC  X6, X27, X17
    CLS  V8.4S, V16.4S
    ADD  X5, X8, #0xf82, LSL #12
    ORN  W25, W22, W10, LSL #14
    AND  W8, W15, #0xfc0000
    LSLV  X4, X29, X20
    CRC32B  W26, W13, W5
    ADCS  W7, W27, W28
    UMADDL  X29, W6, W21, X3
    CRC32B  W10, W4, W4
    SUBS  W22, W25, W17, SXTX #0
    ANDS  W19, W17, #0xfff807ff
    CSEL  W12, W16, W28, NV
    LSRV  W12, W8, W7
    ORR  V26.8H, #0x85, LSL #8
    ANDS  W5, W19, W5, LSL #5
    EOR  W17, W22, W15, LSR #9
    CSINC  X4, X26, X10, EQ
    CRC32CB  W24, W2, W8
    CLS  V4.2S, V3.2S
    ADD  W15, W29, W13, UXTB #2
    CRC32CB  W24, W22, W19
    ADDS  X22, X26, X23, SXTX #4
    ANDS  X5, X14, X29, LSR #45
    ADDS  W20, W24, W17, LSR #18
    MOVK  W22, #0x7c4c, LSL #16
    ANDS  W18, W2, W24, LSR #31
    CSINC  X29, X12, X29, NE
    CLZ  W29, W3
    SUBS  W17, W17, #0x5ba, LSL #12
    EXTR  X3, X18, X20, #0x9
    ANDS  X8, X22, #0xfffffff0fffffff0
    ADD  W23, W18, W10, SXTW #0
    SUBS  X16, X16, #0x1
    B.NE  TaishanIntAluP01_label_759
    MOVZ  X14, #0x8004, LSL #0
    MOVK  X14, #0x1b, LSL #16
    SUB  X16, X14, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP01_TestFail
    MOVZ  X21, #0x8c9d, LSL #0
    MOVK  X21, #0x56, LSL #16
    SUB  X20, X21, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntAluP01_TestFail
    MOVZ  X24, #0x1, LSL #0
    SUB  X16, X24, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X2, X20, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP01_TestFail
    MOVZ  X15, #0x5000, LSL #0
    MOVK  X15, #0x11, LSL #16
    MOVK  X15, #0x1, LSL #32
    SUB  X24, X15, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntAluP01_TestFail
    MOVZ  X19, #0x8000, LSL #0
    MOVK  X19, #0x85, LSL #16
    SUB  X25, X19, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntAluP01_TestFail
    MOVZ  X24, #0xffe0, LSL #0
    MOVK  X24, #0x7c4c, LSL #16
    SUB  X9, X24, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntAluP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP01_TestFail
    MOVZ  X17, #0x8004, LSL #0
    MOVK  X17, #0x1b, LSL #16
    SUB  X8, X17, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntAluP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X26, X13, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntAluP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x8004, LSL #0
    MOVK  X20, #0x1b, LSL #16
    SUB  X29, X20, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntAluP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X3, #0x8000, LSL #0
    MOVK  X3, #0x85, LSL #16
    SUB  X14, X3, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntAluP01_TestFail
    MOVZ  X20, #0x8004, LSL #0
    MOVK  X20, #0x1b, LSL #16
    SUB  X22, X20, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X4, #0x8c9d, LSL #0
    MOVK  X4, #0x56, LSL #16
    SUB  X2, X4, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntAluP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntAluP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntAluP01_TestFail
    MOVZ  X23, #0xffe0, LSL #0
    MOVK  X23, #0x7c4c, LSL #16
    SUB  X7, X23, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntAluP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntAluP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntAluP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntAluP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntAluP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntAluP01_TestFail

TaishanIntAluP01_TestEnd:
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
TaishanIntAluP01_TestFail:
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