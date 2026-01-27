.global TaishanIntMduP02

.text
.p2align 4

TaishanIntMduP02:

TaishanIntMduP02_TestBegin:
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
    MOVK  X2, #0x7aa1, LSL #48
    MOVK  X2, #0x56d, LSL #32
    MOVK  X2, #0x9e1c, LSL #16
    MOVK  X2, #0x9811, LSL #0
    MOVK  X3, #0x7d42, LSL #48
    MOVK  X3, #0x8dae, LSL #32
    MOVK  X3, #0x45c8, LSL #16
    MOVK  X3, #0xcd4b, LSL #0
    MOVK  X5, #0xfe1d, LSL #48
    MOVK  X5, #0x9c17, LSL #32
    MOVK  X5, #0xd06a, LSL #16
    MOVK  X5, #0xd4b6, LSL #0
    MOVK  X6, #0x3ff1, LSL #48
    MOVK  X6, #0x9198, LSL #32
    MOVK  X6, #0x5457, LSL #16
    MOVK  X6, #0x1775, LSL #0
    MOVK  X7, #0xbc44, LSL #48
    MOVK  X7, #0x3878, LSL #32
    MOVK  X7, #0x472d, LSL #16
    MOVK  X7, #0xc32d, LSL #0
    MOVK  X8, #0xa143, LSL #48
    MOVK  X8, #0xb7d1, LSL #32
    MOVK  X8, #0x6bde, LSL #16
    MOVK  X8, #0xd30, LSL #0
    MOVK  X9, #0x1a36, LSL #48
    MOVK  X9, #0x9f76, LSL #32
    MOVK  X9, #0xdde2, LSL #16
    MOVK  X9, #0x4b0, LSL #0
    MOVK  X10, #0x9db4, LSL #48
    MOVK  X10, #0xdee0, LSL #32
    MOVK  X10, #0xdee1, LSL #16
    MOVK  X10, #0x6f19, LSL #0
    MOVK  X11, #0xd2e5, LSL #48
    MOVK  X11, #0x29f8, LSL #32
    MOVK  X11, #0x47de, LSL #16
    MOVK  X11, #0x2d28, LSL #0
    MOVK  X12, #0x7f6d, LSL #48
    MOVK  X12, #0xf54d, LSL #32
    MOVK  X12, #0x5ca2, LSL #16
    MOVK  X12, #0x58b2, LSL #0
    MOVK  X13, #0xb04, LSL #48
    MOVK  X13, #0xbf3f, LSL #32
    MOVK  X13, #0xcf15, LSL #16
    MOVK  X13, #0x9a29, LSL #0
    MOVK  X14, #0xd53c, LSL #48
    MOVK  X14, #0x69e, LSL #32
    MOVK  X14, #0x31a8, LSL #16
    MOVK  X14, #0x14e3, LSL #0
    MOVK  X15, #0x5f20, LSL #48
    MOVK  X15, #0xa6d0, LSL #32
    MOVK  X15, #0x6d8, LSL #16
    MOVK  X15, #0x6dd7, LSL #0
    MOVK  X16, #0xac05, LSL #48
    MOVK  X16, #0x4b22, LSL #32
    MOVK  X16, #0x5346, LSL #16
    MOVK  X16, #0x5eb7, LSL #0
    MOVK  X17, #0x8430, LSL #48
    MOVK  X17, #0x6bcd, LSL #32
    MOVK  X17, #0x512f, LSL #16
    MOVK  X17, #0x7fc5, LSL #0
    MOVK  X18, #0xc61c, LSL #48
    MOVK  X18, #0x121f, LSL #32
    MOVK  X18, #0x86ea, LSL #16
    MOVK  X18, #0x5b24, LSL #0
    MOVK  X19, #0x57d2, LSL #48
    MOVK  X19, #0x3ca8, LSL #32
    MOVK  X19, #0x7f2, LSL #16
    MOVK  X19, #0x57de, LSL #0
    MOVK  X20, #0xd67, LSL #48
    MOVK  X20, #0x550b, LSL #32
    MOVK  X20, #0xeee2, LSL #16
    MOVK  X20, #0x269d, LSL #0
    MOVK  X21, #0xf2ca, LSL #48
    MOVK  X21, #0x9dda, LSL #32
    MOVK  X21, #0x1d4e, LSL #16
    MOVK  X21, #0xe8f7, LSL #0
    MOVK  X22, #0xe405, LSL #48
    MOVK  X22, #0x61bb, LSL #32
    MOVK  X22, #0x210f, LSL #16
    MOVK  X22, #0x7cf5, LSL #0
    MOVK  X23, #0xdcef, LSL #48
    MOVK  X23, #0x456c, LSL #32
    MOVK  X23, #0xac16, LSL #16
    MOVK  X23, #0xa302, LSL #0
    MOVK  X24, #0xa8c0, LSL #48
    MOVK  X24, #0x30c0, LSL #32
    MOVK  X24, #0x1b04, LSL #16
    MOVK  X24, #0xa8c4, LSL #0
    MOVK  X25, #0xb08a, LSL #48
    MOVK  X25, #0xd5b8, LSL #32
    MOVK  X25, #0x7c70, LSL #16
    MOVK  X25, #0x4a67, LSL #0
    MOVK  X26, #0xfc8b, LSL #48
    MOVK  X26, #0x6fef, LSL #32
    MOVK  X26, #0xd9fc, LSL #16
    MOVK  X26, #0x6d91, LSL #0
    MOVK  X27, #0x9466, LSL #48
    MOVK  X27, #0x1dc, LSL #32
    MOVK  X27, #0x7d00, LSL #16
    MOVK  X27, #0xd95e, LSL #0
    MOVK  X28, #0x2d3f, LSL #48
    MOVK  X28, #0x3321, LSL #32
    MOVK  X28, #0x9c8d, LSL #16
    MOVK  X28, #0x598d, LSL #0
    MOVK  X29, #0x8ac2, LSL #48
    MOVK  X29, #0x26db, LSL #32
    MOVK  X29, #0xfee2, LSL #16
    MOVK  X29, #0xf2a6, LSL #0
    ANDS  W25, W7, W26, LSR #3
    MOVZ  X2, #0xb38e, LSL #0
    MOVK  X2, #0x57b1, LSL #16
    MOVK  X2, #0xdba9, LSL #32
    MOVK  X2, #0x68ed, LSL #48
    MOVZ  X3, #0xd56a, LSL #0
    MOVK  X3, #0x66c1, LSL #16
    MOVK  X3, #0x10bd, LSL #32
    MOVK  X3, #0x53d0, LSL #48
    MOVZ  X5, #0xaf1, LSL #0
    MOVK  X5, #0xd9a4, LSL #16
    MOVK  X5, #0x826, LSL #32
    MOVK  X5, #0x16a3, LSL #48
    MOVZ  X6, #0x9cf5, LSL #0
    MOVK  X6, #0xcfa5, LSL #16
    MOVK  X6, #0xd136, LSL #32
    MOVK  X6, #0x474b, LSL #48
    MOVZ  X7, #0x3b50, LSL #0
    MOVK  X7, #0xd03c, LSL #16
    MOVK  X7, #0x999b, LSL #32
    MOVK  X7, #0xff, LSL #48
    MOVZ  X8, #0xa990, LSL #0
    MOVK  X8, #0xadd6, LSL #16
    MOVK  X8, #0xe75, LSL #32
    MOVK  X8, #0xb262, LSL #48
    MOVZ  X9, #0x3bb5, LSL #0
    MOVK  X9, #0xccaf, LSL #16
    MOVK  X9, #0x95aa, LSL #32
    MOVK  X9, #0xc989, LSL #48
    MOVZ  X10, #0x9296, LSL #0
    MOVK  X10, #0x43a7, LSL #16
    MOVK  X10, #0x6904, LSL #32
    MOVK  X10, #0x16ac, LSL #48
    MOVZ  X11, #0x56be, LSL #0
    MOVK  X11, #0x27fa, LSL #16
    MOVK  X11, #0xd0b0, LSL #32
    MOVK  X11, #0x8891, LSL #48
    MOVZ  X12, #0x99ee, LSL #0
    MOVK  X12, #0x5f30, LSL #16
    MOVK  X12, #0x1ddb, LSL #32
    MOVK  X12, #0x5199, LSL #48
    MOVZ  X13, #0xbd39, LSL #0
    MOVK  X13, #0x664a, LSL #16
    MOVK  X13, #0x4fc1, LSL #32
    MOVK  X13, #0x6b82, LSL #48
    MOVZ  X14, #0x4f7c, LSL #0
    MOVK  X14, #0xcb10, LSL #16
    MOVK  X14, #0x28e7, LSL #32
    MOVK  X14, #0x249f, LSL #48
    MOVZ  X15, #0x16b7, LSL #0
    MOVK  X15, #0xbbe6, LSL #16
    MOVK  X15, #0x8ab1, LSL #32
    MOVK  X15, #0x863e, LSL #48
    MOVZ  X16, #0xc824, LSL #0
    MOVK  X16, #0x3db6, LSL #16
    MOVK  X16, #0xfc75, LSL #32
    MOVK  X16, #0x2a8, LSL #48
    MOVZ  X17, #0x7828, LSL #0
    MOVK  X17, #0xae31, LSL #16
    MOVK  X17, #0x54ce, LSL #32
    MOVK  X17, #0x50de, LSL #48
    MOVZ  X18, #0xe19b, LSL #0
    MOVK  X18, #0xe96, LSL #16
    MOVK  X18, #0xa4a6, LSL #32
    MOVK  X18, #0xc671, LSL #48
    MOVZ  X19, #0xd20c, LSL #0
    MOVK  X19, #0xbccc, LSL #16
    MOVK  X19, #0xe62f, LSL #32
    MOVK  X19, #0x9479, LSL #48
    MOVZ  X20, #0x3ad8, LSL #0
    MOVK  X20, #0xb448, LSL #16
    MOVK  X20, #0x93b1, LSL #32
    MOVK  X20, #0x2e7f, LSL #48
    MOVZ  X21, #0xd3a6, LSL #0
    MOVK  X21, #0x5b04, LSL #16
    MOVK  X21, #0x9334, LSL #32
    MOVK  X21, #0xd8a2, LSL #48
    MOVZ  X22, #0x5339, LSL #0
    MOVK  X22, #0xb95d, LSL #16
    MOVK  X22, #0x9998, LSL #32
    MOVK  X22, #0xca8c, LSL #48
    MOVZ  X23, #0x3f84, LSL #0
    MOVK  X23, #0x2c2e, LSL #16
    MOVK  X23, #0x3799, LSL #32
    MOVK  X23, #0xddad, LSL #48
    MOVZ  X24, #0x94e6, LSL #0
    MOVK  X24, #0x74d3, LSL #16
    MOVK  X24, #0x88ad, LSL #32
    MOVK  X24, #0xe2eb, LSL #48
    MOVZ  X25, #0x99eb, LSL #0
    MOVK  X25, #0xece2, LSL #16
    MOVK  X25, #0x283c, LSL #32
    MOVK  X25, #0xca88, LSL #48
    MOVZ  X26, #0xbbb9, LSL #0
    MOVK  X26, #0xf75a, LSL #16
    MOVK  X26, #0x5325, LSL #32
    MOVK  X26, #0x49e3, LSL #48
    MOVZ  X27, #0x46b, LSL #0
    MOVK  X27, #0x9480, LSL #16
    MOVK  X27, #0x3a87, LSL #32
    MOVK  X27, #0x46f4, LSL #48
    MOVZ  X28, #0x928f, LSL #0
    MOVK  X28, #0x7345, LSL #16
    MOVK  X28, #0x854f, LSL #32
    MOVK  X28, #0xb58b, LSL #48
    MOVZ  X29, #0x9822, LSL #0
    MOVK  X29, #0xfd43, LSL #16
    MOVK  X29, #0xc98a, LSL #32
    MOVK  X29, #0x9778, LSL #48
    MOVZ  X8, #0xa, LSL #0
TaishanIntMduP02_label_0:
    CRC32CX  W17, W16, X26
    UBFM  W25, W8, #0x16, #0x3
    ORN  X21, X28, X3, LSR #60
    ANDS  W14, W2, #0x100010
    MOVZ  W10, #0xfea5, LSL #0
    AND  X19, X21, #0x3ffffffc3ffffffc
    MOVZ  X6, #0x3d08, LSL #16
    CSINV  W2, W9, W14, CS
    CRC32W  W24, W12, W17
    MADD  W22, W2, W2, W27
    LSRV  X22, X29, X12
    BICS  X3, X15, X3, LSR #58
    CSEL  X25, X29, X6, NV
    SUB  X20, X13, X28, ASR #18
    MADD  X10, X24, X27, X5
    BIC  X28, X19, X10, LSL #29
    ADC  W14, W20, W28
    EOR  X19, X21, X24, LSL #49
    CSEL  W25, W9, W10, GT
    MOVN  X6, #0x539d, LSL #32
    ANDS  W3, W2, #0xfbfbfbfb
    LSRV  W13, W8, W14
    EXTR  W22, W6, W15, #0x12
    CLZ  W22, W10
    CSINV  W15, W13, W28, CC
    ADDS  X22, X11, X20, LSL #33
    LSLV  X21, X16, X23
    CLS  X16, X10
    EOR  W22, W6, #0xff07ff07
    SUBS  X10, X19, X20, ASR #41
    ADC  X3, X12, X21
    EOR  W28, W12, #0x11111111
    SUB  X7, X28, X2, ASR #33
    SBFM  X25, X10, #0x1a, #0x19
    SUB  W12, W11, W25, SXTH #4
    CRC32CW  W13, W3, W27
    MADD  W2, W23, W22, W14
    CRC32B  W18, W22, W16
    CRC32CB  W7, W12, W24
    SUB  W26, W15, #0xe9f
    ORR  V27.16B, V2.16B, V9.16B
    ADD  X7, X12, W28, UXTH #3
    SBFM  W7, W23, #0x1f, #0x1a
    EOR  W23, W20, #0x3ffe000
    ADD  W24, W13, #0xbff, LSL #12
    ADDS  X15, X15, W2, UXTH #3
    CLZ  W24, W27
    SUB  W10, W5, W3, UXTW #2
    UBFM  W23, W15, #0x11, #0x13
    LSLV  X6, X15, X19
    SMULH  X15, X17, X7
    ANDS  W15, W13, #0x3f803f8
    CRC32CH  W20, W16, W23
    ADD  W5, W24, W15, UXTX #3
    SUB  W23, W20, W28, LSL #17
    SUB  W3, W15, W5, UXTW #2
    ADDS  X23, X5, W6, UXTB #3
    LSRV  X25, X3, X19
    UBFM  W5, W9, #0x1f, #0x1b
    CRC32CW  W22, W11, W18
    EOR  X23, X18, X11, LSR #40
    EON  W15, W29, W17, LSL #18
    CRC32W  W10, W5, W23
    ANDS  X10, X15, #0x7000700070007000
    SUBS  X2, X24, #0xd75
    AND  X28, X16, #0x3fff00003fff0000
    BIC  X18, X29, X19, ASR #29
    CRC32CB  W20, W23, W16
    SUBS  X5, X3, #0x420, LSL #12
    SUB  W5, W25, W17, ASR #28
    BICS  X29, X15, X23, ASR #57
    ADD  W24, W29, W20, SXTB #1
    BIC  V21.16B, V19.16B, V2.16B
    SUB  X28, X29, #0xe1a
    ADDS  X14, X26, W28, SXTB #4
    CRC32CB  W18, W26, W18
    ANDS  W14, W18, W3, ASR #1
    BIC  W9, W10, W19, LSR #11
    SUBS  W29, W14, #0x1e0
    CSEL  W2, W13, W26, MI
    SUBS  W15, W23, W5
    CLZ  X5, X11
    ADD  X24, X8, #0x830
    SMSUBL  X5, W28, W15, X16
    CSINV  W11, W19, W15, CC
    CLZ  V19.8B, V4.8B
    ADDS  W21, W11, W9, SXTX #4
    CSNEG  X6, X11, X5, LT
    SMADDL  X27, W11, W5, X3
    MADD  W2, W15, W11, W18
    ANDS  X6, X3, X6, ROR #13
    UMADDL  X12, W29, W14, X20
    EXTR  X18, X12, X13, #0xe
    BIC  W2, W10, W22
    ORR  X13, X6, X6, LSR #40
    EOR  X9, X3, #0x1e00000000
    SUB  X16, X27, #0x610
    ORR  V2.16B, V15.16B, V11.16B
    ADCS  W11, W29, W27
    SBFM  X7, X12, #0x2a, #0xa
    ORR  X22, X9, #0xfc0000000000ffff
    EON  W9, W18, W15, LSL #3
    CSEL  W23, W25, W3, CS
    AND  W20, W18, W16, LSL #26
    EXTR  X21, X23, X23, #0x1d
    CRC32B  W2, W6, W24
    SMULH  X12, X22, X28
    ORR  X21, X22, X25, LSR #50
    ADDS  W10, W16, #0x7aa, LSL #12
    MOVZ  X16, #0x4ee1, LSL #48
    AND  X18, X20, X11, LSR #30
    ANDS  W9, W15, W8, ASR #15
    EXTR  X21, X2, X14, #0x2
    SUB  X13, X16, W2, SXTW #3
    UBFM  W3, W29, #0x19, #0x18
    LSLV  W14, W15, W14
    UBFM  X22, X11, #0x21, #0xa
    ADDS  X21, X19, #0x7a0, LSL #12
    ADD  W25, W21, #0x535, LSL #12
    ADCS  X28, X26, X13
    ANDS  W26, W21, #0xffffff07
    EXTR  X25, X16, X18, #0x36
    SBFM  X16, X8, #0x2d, #0x15
    UMADDL  X11, W23, W3, X14
    MOVK  X26, #0xc6d5, LSL #16
    ORR  W29, W15, W18, ROR #12
    CRC32X  W29, W15, X13
    EOR  X5, X19, X3, LSL #35
    SUBS  X13, X8, X2, ASR #38
    CRC32X  W5, W12, X15
    SUBS  W29, W9, #0x7e9
    EOR  X16, X9, X8, LSL #63
    ORN  W21, W16, W22, LSL #21
    EOR  X21, X5, X14, ASR #63
    ANDS  X6, X21, X21, LSL #1
    SUBS  X11, X8, W20, SXTH #4
    ANDS  W10, W12, W18, LSR #28
    EOR  X29, X28, #0x60000000600000
    SMADDL  X14, W10, W3, X11
    SUB  W24, W26, W11, LSR #4
    ADC  W2, W26, W28
    CRC32X  W3, W25, X12
    ADD  X9, X2, W10, UXTB #1
    MOVZ  W25, #0xe4a9, LSL #16
    ADDS  W9, W3, W24, ASR #18
    ADCS  X13, X22, X16
    ADDS  X13, X19, W2, SXTW #2
    AND  W13, W18, W6, ROR #13
    MOVZ  W3, #0xcea8, LSL #16
    ADDS  X15, X14, #0x36c
    ORR  V25.4H, #0x50, LSL #8
    CLS  V27.2S, V12.2S
    EOR  X27, X24, X14, LSL #54
    UBFM  W15, W9, #0x14, #0xe
    ANDS  X21, X13, X21, LSR #49
    SUB  W18, W11, W18, ASR #2
    SBFM  X29, X11, #0x20, #0xe
    MADD  W17, W9, W14, W23
    MOVK  X25, #0xf8e1, LSL #32
    CLS  W2, W6
    LSRV  X6, X27, X19
    ADC  X18, X7, X14
    AND  W18, W24, #0x8000000f
    ORR  V22.8H, #0x2c, LSL #8
    SUBS  X19, X6, #0x21b, LSL #12
    UMULH  X6, X13, X26
    EOR  X29, X17, X6, LSL #58
    SUBS  X19, X18, #0xfda, LSL #12
    SMULH  X15, X10, X19
    SUBS  W23, W26, #0x919
    SUBS  X18, X7, #0x7ca, LSL #12
    MOVZ  W2, #0xd0c0, LSL #0
    ADD  W20, W5, W15, UXTB #1
    MADD  X3, X9, X11, X10
    BICS  X25, X16, X6, LSL #25
    EON  X7, X25, X13, ROR #1
    SMSUBL  X9, W3, W29, X27
    ORR  X27, X26, #0xfffe0000ffffffff
    ADDS  X26, X23, W3, UXTB #0
    EON  W12, W6, W23, LSL #8
    EOR  X24, X27, X14, ROR #15
    ORN  X3, X3, X29, LSR #38
    ORR  W3, W18, #0xfff00001
    CRC32CB  W18, W10, W13
    AND  X10, X6, #0xaaaaaaaaaaaaaaaa
    ORR  X10, X3, #0x1fffffffffff0
    CRC32H  W29, W28, W24
    ADDS  W18, W16, #0x6e2, LSL #12
    ASRV  W17, W2, W8
    CLZ  V30.16B, V0.16B
    ADD  X18, X22, X18, UXTX #0
    LSLV  X21, X26, X16
    ANDS  X15, X3, X10, ASR #31
    EXTR  X20, X27, X10, #0x18
    UMADDL  X25, W5, W29, X12
    MOVZ  W25, #0xaf5e, LSL #16
    ORN  X5, X19, X18, LSR #50
    ADDS  X13, X11, W5, UXTH #4
    SUBS  W28, W25, #0xb40, LSL #12
    ORR  X27, X18, #0xc000
    SUBS  X8, X8, #0x1
    B.NE  TaishanIntMduP02_label_0
    MOVZ  X23, #0xd0c0, LSL #0
    SUB  X19, X23, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X12, #0x6001, LSL #0
    MOVK  X12, #0xfff3, LSL #16
    SUB  X11, X12, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X15, X14, X5
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0x7fff, LSL #48
    SUB  X7, X2, X7
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X10, #0xcc86, LSL #0
    MOVK  X10, #0x62ea, LSL #16
    MOVK  X10, #0x4b80, LSL #32
    MOVK  X10, #0xe6f9, LSL #48
    SUB  X3, X10, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X29, #0xcc86, LSL #0
    MOVK  X29, #0x62ea, LSL #16
    MOVK  X29, #0x4b80, LSL #32
    MOVK  X29, #0xe6f9, LSL #48
    SUB  X11, X29, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X16, X14, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X29, #0xfff1, LSL #0
    MOVK  X29, #0xf, LSL #16
    SUB  X3, X29, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP02_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X14, X28, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X7, #0x6860, LSL #0
    SUB  X20, X7, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X18, X21, X18
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X19
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X10, X13, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x332, LSL #32
    SUB  X8, X10, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP02_TestFail
    MOVZ  X13, #0xd0c0, LSL #0
    SUB  X5, X13, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP02_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xfffc, LSL #48
    SUB  X18, X25, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xfffc, LSL #48
    SUB  X3, X22, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X27, X17, X26
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X19, #0xfff1, LSL #0
    MOVK  X19, #0xf, LSL #16
    SUB  X24, X19, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP02_TestFail
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
    MOVZ  X3, #0xa, LSL #0
TaishanIntMduP02_label_28:
    MOVN  X20, #0x7ff9, LSL #48
    ADCS  X24, X12, X20
    ADC  W20, W23, W17
    EON  W26, W26, W12, ASR #8
    ANDS  W8, W11, W29, LSL #4
    MADD  W5, W19, W6, W16
    EOR  W22, W13, W9, ROR #2
    CRC32CW  W20, W24, W9
    AND  W24, W21, #0xff80001f
    SBFM  X28, X20, #0x8, #0x13
    SUB  W22, W14, W25, SXTH #4
    CLZ  W12, W16
    LSRV  W7, W21, W19
    CLS  X14, X26
    CSEL  W17, W21, W23, LE
    SUBS  X22, X10, X6, LSR #40
    SUB  W21, W15, W3, ASR #12
    ADD  X17, X6, W19, SXTB #4
    ORR  W28, W25, #0x77777777
    CLS  X24, X2
    ORR  V20.4H, #0x67, LSL #8
    ADC  X20, X17, X22
    SMADDL  X9, W19, W23, X17
    LSLV  X16, X16, X21
    UMULH  X27, X28, X17
    BICS  W11, W9, W9, LSR #5
    LSLV  W5, W19, W17
    UMADDL  X14, W24, W3, X12
    UBFM  X16, X27, #0x28, #0x6
    CRC32X  W24, W15, X27
    ADD  X16, X10, #0x312
    EXTR  W26, W8, W27, #0x19
    ORR  W2, W27, #0xff80
    CSINC  X2, X19, X12, HI
    EOR  W2, W28, W6, ROR #6
    ORN  X28, X26, X17, ASR #13
    LSLV  W7, W5, W22
    SUB  W19, W10, W29, UXTB #1
    MOVN  W27, #0xaca6, LSL #16
    ANDS  W27, W23, #0x6000
    UBFM  X11, X14, #0x5, #0x33
    ANDS  W7, W14, #0xffffffe1
    CSNEG  X15, X24, X6, NE
    CRC32X  W7, W21, X20
    CSEL  X23, X9, X14, GT
    UBFM  X15, X20, #0x3a, #0x35
    ORR  W10, W10, W28, LSR #4
    MOVN  W25, #0x7df7, LSL #16
    ORR  V21.16B, V25.16B, V22.16B
    EON  W24, W6, W24, LSR #31
    SUB  W12, W11, W20, LSL #20
    CSEL  W7, W10, W21, PL
    CSEL  X26, X7, X16, CS
    UMULH  X29, X10, X10
    BIC  W20, W25, W20, ROR #5
    ADD  W6, W2, #0x11e
    ADDS  W20, W20, W6, ASR #20
    CRC32CX  W29, W8, X8
    SMADDL  X20, W5, W19, X22
    CSINV  X25, X25, X18, HI
    CLS  V31.16B, V22.16B
    CRC32CB  W10, W26, W9
    CSINC  W21, W16, W6, NE
    SUB  W27, W26, W5, LSL #9
    SUB  W13, W25, W24, LSL #7
    CSINV  W2, W12, W17, GE
    ANDS  W23, W26, W15, ASR #11
    MADD  X17, X15, X11, X25
    ANDS  W24, W2, #0xe000e00
    MADD  X25, X9, X11, X17
    ADDS  W7, W15, W18, ASR #1
    ORR  V13.4S, #0x8d, LSL #8
    CSINV  X23, X10, X25, GE
    UMULH  X14, X8, X5
    EON  W28, W24, W10, ROR #6
    ADD  X24, X25, X24, LSL #51
    EOR  X2, X14, X27, LSL #40
    ADDS  W9, W18, W12, LSL #30
    SUBS  W2, W23, W26, SXTX #1
    AND  X15, X25, X26, LSR #17
    ADD  W17, W21, W6, ASR #19
    SUB  W14, W26, W6, LSL #24
    SUB  W28, W15, #0xc03
    CLS  V7.8B, V2.8B
    ANDS  W13, W12, W7, ROR #25
    CRC32X  W5, W7, X2
    ORN  X19, X26, X24, LSR #18
    LSRV  X14, X16, X22
    ADD  X10, X23, X24, ASR #7
    ASRV  X27, X5, X10
    MOVN  X26, #0x212b, LSL #0
    CSINC  W10, W19, W18, VC
    CRC32W  W8, W15, W25
    CLS  X2, X23
    AND  W8, W9, #0x1ff8000
    BICS  W11, W3, W21, LSL #19
    MADD  X6, X21, X2, X16
    UMADDL  X27, W13, W13, X6
    EXTR  W15, W23, W26, #0xe
    AND  W28, W27, W17, ROR #28
    ADD  W26, W8, #0xc4b
    MOVN  W15, #0x3882, LSL #16
    UMSUBL  X11, W21, W17, X27
    UMADDL  X12, W9, W16, X23
    ADC  X8, X12, X10
    ORR  V0.8B, V29.8B, V21.8B
    ADCS  X15, X12, X14
    CSEL  W27, W21, W13, NE
    ADDS  X28, X9, X24, LSR #39
    SUBS  X18, X28, #0x2d0
    ADCS  X15, X28, X2
    ADD  X19, X29, W27, UXTH #1
    ADC  W2, W9, W28
    ORR  X26, X16, X19, LSL #34
    EON  X27, X11, X18, LSR #16
    EXTR  X19, X14, X22, #0x33
    EOR  X5, X22, X9, LSR #54
    CRC32CH  W10, W21, W21
    CSINC  W2, W8, W8, CS
    CRC32W  W14, W2, W11
    CSEL  X2, X16, X25, VC
    UBFM  W25, W19, #0x7, #0x7
    AND  W8, W6, W8, LSL #25
    SMSUBL  X11, W18, W28, X22
    CRC32CW  W6, W9, W18
    UBFM  X29, X18, #0x37, #0x35
    CRC32CW  W29, W26, W24
    CLZ  W17, W16
    EOR  X15, X12, X2, ROR #1
    MOVN  X7, #0xe19f, LSL #48
    MADD  W6, W21, W25, W19
    CLZ  W14, W21
    BICS  W22, W8, W16, ROR #9
    CLZ  X28, X24
    ADDS  X21, X14, #0x6e0
    EOR  X23, X20, X11, LSR #31
    MOVN  W20, #0xddf9, LSL #16
    ORN  W7, W29, W9, LSL #3
    ANDS  W14, W7, W19, ROR #29
    ASRV  X28, X17, X17
    CLZ  W8, W14
    LSRV  X18, X27, X13
    LSRV  W17, W3, W17
    ORR  V0.4H, #0x10, LSL #8
    SUBS  W21, W29, W11, UXTW #1
    EOR  X20, X8, #0xf81ff81ff81ff81f
    SUBS  X28, X27, X15, LSR #49
    SMSUBL  X28, W28, W25, X27
    ADDS  X2, X6, X26, LSL #36
    EOR  X8, X12, #0xffffff00ffffff
    CRC32X  W23, W12, X22
    ADDS  X15, X24, W9, SXTB #2
    LSLV  X21, X12, X2
    CSINV  X19, X18, X2, CS
    UBFM  W28, W2, #0x10, #0x1b
    CRC32W  W9, W24, W29
    CLZ  X29, X9
    LSLV  X6, X5, X11
    SUB  W2, W7, W23, UXTX #2
    SUB  W26, W19, W27, LSR #11
    ADD  W23, W26, #0xbf0
    BICS  X18, X2, X24, LSL #7
    LSRV  W22, W15, W22
    ORN  W8, W11, W23, LSL #20
    ORN  W9, W18, W21, LSR #11
    ADDS  X27, X29, #0x533
    CRC32CW  W29, W5, W27
    BIC  W6, W14, W3, ASR #22
    MOVK  W8, #0x9882, LSL #16
    ADD  W2, W9, W11, LSL #13
    CRC32CH  W17, W7, W18
    SUB  W9, W20, W15, UXTW #1
    ORN  X6, X25, X22, ASR #29
    MOVZ  W29, #0x440e, LSL #16
    ORR  W24, W12, W20, ROR #11
    ADD  W19, W9, #0x720
    CRC32W  W18, W28, W19
    SUB  X21, X14, #0x6b2, LSL #12
    CRC32X  W12, W5, X29
    ORR  X23, X19, X26, LSR #61
    ADD  X23, X14, X17, UXTX #2
    CRC32X  W9, W12, X9
    AND  W9, W29, #0xe07fe07f
    ADDS  W5, W27, W21, LSL #20
    CRC32CW  W17, W23, W7
    ORN  W20, W5, W20, LSR #5
    CRC32CX  W21, W29, X9
    ADC  X27, X19, X12
    CRC32CB  W26, W21, W19
    ORN  X20, X2, X7, LSL #2
    EOR  X28, X6, X21, ASR #28
    ORR  W2, W28, #0x3fe03fe0
    CSINV  W28, W12, W27, NV
    ADD  W25, W27, W12, ASR #24
    SBFM  W21, W20, #0x2, #0x1a
    SBFM  W17, W17, #0x4, #0xd
    ANDS  W6, W28, #0x3fffe0
    CLZ  W20, W17
    BICS  W23, W25, W14, ASR #18
    SUB  W29, W2, W27, UXTW #3
    SUBS  X3, X3, #0x1
    B.NE  TaishanIntMduP02_label_28
    MOVZ  X7, #0xfff2, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X8, X7, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP02_TestFail
    MOVZ  X12, #0x553, LSL #0
    SUB  X27, X12, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X15, #0x9fe0, LSL #0
    MOVK  X15, #0x39, LSL #16
    SUB  X11, X15, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X8, #0xfff2, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X24, X8, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP02_TestFail
    MOVZ  X16, #0xfff2, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X26, X16, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x400e, LSL #16
    SUB  X26, X5, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X7, #0x553, LSL #0
    SUB  X22, X7, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP02_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x1010, LSL #16
    SUB  X24, X8, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x312, LSL #16
    SUB  X9, X6, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X22, #0x9fe0, LSL #0
    MOVK  X22, #0x39, LSL #16
    SUB  X12, X22, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP02_TestFail
    MOVZ  X26, #0xfff2, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X7, X26, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X6, #0x168, LSL #0
    SUB  X9, X6, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X21, #0xa9aa, LSL #0
    MOVK  X21, #0x9c84, LSL #16
    SUB  X23, X21, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP02_TestFail
    MOVZ  X21, #0x1af1, LSL #0
    MOVK  X21, #0x11bc, LSL #16
    SUB  X9, X21, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X17, #0x17, LSL #0
    SUB  X7, X17, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X19, #0x1af1, LSL #0
    MOVK  X19, #0x11bc, LSL #16
    SUB  X11, X19, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X13, #0x9fe0, LSL #0
    MOVK  X13, #0x39, LSL #16
    SUB  X14, X13, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X20, X17, X23
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X29, X28, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X11, #0xba81, LSL #0
    MOVK  X11, #0xa935, LSL #16
    SUB  X23, X11, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP02_TestFail
    MOVZ  X19, #0xfff2, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X21, X19, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X28, X15, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X13, X3, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X29
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
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
    MOVZ  X23, #0xa, LSL #0
TaishanIntMduP02_label_56:
    SBFM  W25, W12, #0x1f, #0x1a
    ORR  V31.16B, V31.16B, V26.16B
    CLS  V22.8H, V14.8H
    LSRV  W18, W17, W5
    ADDS  X19, X18, #0x300
    ADD  W5, W18, W26, ASR #30
    SMSUBL  X5, W22, W29, X3
    EON  W14, W15, W5, ASR #3
    MOVK  W8, #0xafb6, LSL #0
    LSLV  W7, W24, W23
    ASRV  X25, X16, X26
    ORR  V9.8H, #0x5e
    CRC32CB  W28, W28, W17
    SBFM  W2, W28, #0x16, #0x16
    ORR  V6.4H, #0x42
    ADC  W28, W8, W27
    EOR  X7, X17, #0xfffe0000fffe
    ADD  W17, W12, W2, SXTX #3
    BICS  X14, X12, X19
    EOR  W13, W14, W17, ASR #31
    ADCS  X17, X18, X11
    UMULH  X13, X21, X19
    CSEL  W22, W15, W24, GT
    UMADDL  X2, W5, W21, X20
    CLS  W16, W9
    LSLV  W24, W16, W22
    ADDS  X14, X25, #0x7b0
    ORN  W25, W2, W6, ASR #17
    ORR  V9.16B, V21.16B, V0.16B
    CSINC  X19, X19, X14, HI
    UMULH  X11, X19, X11
    SUBS  W22, W9, #0x706
    LSLV  X21, X6, X22
    BICS  X28, X11, X8, ASR #31
    CSEL  X5, X15, X18, GT
    MOVK  W26, #0x6668, LSL #16
    BICS  W21, W10, W15, LSL #30
    MADD  X6, X18, X12, X3
    MOVK  X7, #0xfa22, LSL #48
    AND  W17, W14, W6, LSR #30
    EOR  W8, W13, W20, LSL #21
    ADD  W17, W13, W21, SXTB #2
    LSLV  W13, W28, W19
    SUB  X11, X17, X18, LSL #60
    MOVZ  W21, #0x5674, LSL #0
    LSLV  X5, X9, X6
    EOR  X28, X6, X7, LSL #35
    MOVN  W7, #0x303a, LSL #0
    UMADDL  X10, W26, W10, X3
    MOVK  X8, #0x78dd, LSL #32
    MADD  W12, W20, W9, W24
    ADD  W14, W23, #0x170
    SMADDL  X12, W8, W6, X2
    ADD  X20, X10, X18, LSL #4
    MOVZ  X9, #0xbe4d, LSL #32
    BICS  X2, X27, X10, ROR #40
    EOR  X17, X11, #0xf000000000
    EOR  X5, X7, X2, ROR #36
    AND  W19, W24, #0x80008
    AND  W18, W24, #0xfffe001f
    SUBS  X13, X23, X21, LSR #26
    UMSUBL  X7, W5, W24, X28
    CRC32H  W16, W17, W18
    BICS  W9, W25, W25, ROR #22
    ANDS  W19, W14, W8, ASR #4
    SUBS  X8, X5, X12, LSL #34
    SUB  W8, W26, #0x231, LSL #12
    ADDS  W16, W26, W2, UXTX #1
    ORR  W6, W26, #0x1ffc1ffc
    EOR  W19, W26, #0xfcfcfcfc
    EON  W14, W17, W22, LSL #2
    ORR  W15, W24, #0xdfdfdfdf
    BICS  X14, X20, X3, LSL #7
    SMULH  X14, X5, X14
    UMADDL  X28, W10, W13, X28
    CRC32CX  W7, W8, X18
    ORN  W9, W23, W18, LSL #10
    ORR  V29.4H, #0xf6, LSL #8
    ORR  X8, X17, X15, ROR #30
    ADCS  W25, W21, W18
    SMULH  X24, X8, X22
    AND  X8, X24, X24, LSR #56
    AND  W14, W7, W2, ROR #10
    UMULH  X10, X27, X14
    EOR  X3, X10, X12, LSR #41
    ADDS  X24, X19, X5, LSL #30
    SUBS  W5, W9, #0xd35, LSL #12
    ANDS  W13, W5, #0xfffffeff
    ORN  X6, X5, X14, LSL #24
    CLZ  V26.4S, V1.4S
    BICS  X16, X27, X6, ROR #58
    UBFM  X25, X25, #0xd, #0x2
    EOR  X29, X27, #0xffc00000000003ff
    BICS  W27, W3, W12, ASR #6
    EXTR  W9, W26, W3, #0x13
    CSEL  X10, X8, X15, VC
    BICS  X18, X9, X10, LSR #60
    MOVZ  X3, #0xb99a, LSL #16
    CLZ  W26, W2
    CLZ  X6, X16
    BICS  X19, X13, X11, ROR #4
    ASRV  X14, X11, X15
    ADD  X7, X21, X27, ASR #39
    ASRV  W9, W7, W25
    EOR  X24, X6, X22, ASR #45
    ADDS  X16, X12, X13, LSL #52
    ADCS  W26, W3, W26
    CLZ  V3.8H, V30.8H
    CSINC  X24, X22, X19, EQ
    ANDS  W9, W29, #0xff80000
    CSINC  X14, X10, X17, CS
    MOVZ  W6, #0xb06f, LSL #0
    MOVK  X16, #0x76ca, LSL #32
    CSINC  X29, X15, X26, GE
    MOVN  X5, #0x6662, LSL #48
    ADC  W22, W29, W22
    MOVZ  X15, #0x6853, LSL #32
    SUBS  X5, X26, X5, SXTX #1
    CSNEG  W14, W6, W24, LT
    CLS  W19, W2
    BIC  X3, X24, X2, LSR #3
    CRC32H  W6, W17, W22
    SUBS  W19, W18, W29, LSL #22
    CSNEG  W22, W28, W25, NE
    ADCS  X10, X3, X25
    ADD  X6, X21, #0x6c9
    CSINV  X28, X24, X17, LS
    BICS  W26, W11, W13, LSR #24
    ANDS  X15, X18, X26, LSL #52
    BICS  W21, W3, W18, LSR #12
    LSRV  X21, X7, X3
    CSINV  W2, W14, W26, LT
    ADC  W18, W15, W21
    CRC32B  W14, W2, W22
    BIC  W21, W29, W17, ASR #22
    LSLV  W16, W28, W18
    SUBS  W19, W14, W9, UXTX #1
    ORR  W14, W7, #0xf00
    LSRV  W15, W20, W5
    LSLV  X26, X2, X16
    ANDS  X12, X10, #0xe7ffffffe7ffffff
    SUB  W16, W9, W22, SXTH #1
    SUB  X15, X25, W2, UXTB #4
    ADDS  X6, X3, #0x380
    CRC32H  W28, W5, W22
    CSNEG  X12, X13, X19, GE
    UMSUBL  X27, W2, W17, X24
    ADC  W17, W29, W3
    SUB  X2, X26, W6, UXTB #0
    SUB  W24, W15, W23, UXTH #0
    MOVZ  X17, #0x66f2, LSL #0
    AND  X12, X2, X24, ASR #30
    ADDS  X17, X9, #0x9f0
    ADDS  W7, W25, W16, SXTX #1
    BIC  W3, W29, W8, LSL #18
    SUBS  W8, W7, W12, SXTX #3
    ADDS  X13, X3, #0x1ca, LSL #12
    BICS  X16, X19, X17, ROR #38
    SUBS  W19, W27, W10, UXTX #2
    SMSUBL  X2, W17, W9, X24
    SUB  X7, X19, X24, LSL #13
    ORR  X9, X11, #0xffffffc0ffffffc0
    ADDS  X28, X29, W21, SXTB #3
    SUBS  X6, X12, X11, LSL #5
    SUBS  W13, W29, W9, LSR #23
    ORN  W15, W29, W3, LSL #10
    ADDS  X5, X18, #0x190
    ADC  W24, W13, W26
    ORR  V31.4H, #0xf5
    SUB  X6, X18, #0x94
    ADD  X3, X5, W5, UXTB #4
    ANDS  X18, X16, X16, LSR #61
    EON  X8, X17, X16, LSL #18
    ASRV  W7, W28, W8
    ADDS  X25, X27, #0x3d7, LSL #12
    MOVK  W17, #0xa87f, LSL #16
    MOVK  X2, #0x1042, LSL #32
    SUB  X10, X16, W26, SXTW #2
    CSNEG  W10, W21, W14, MI
    CRC32W  W22, W28, W12
    CRC32X  W27, W25, X3
    SUB  X3, X13, W5, SXTH #4
    EOR  W18, W17, #0x81818181
    MOVN  W26, #0xe5db, LSL #0
    MADD  W26, W20, W5, W17
    MADD  X12, X5, X19, X8
    EOR  X20, X20, #0x7fe0
    CLZ  X20, X19
    EXTR  W13, W20, W18, #0xe
    MOVZ  X20, #0x33c, LSL #16
    EXTR  X19, X18, X11, #0x8
    ADD  W18, W27, W19, ASR #2
    EXTR  X17, X19, X29, #0x2f
    CLS  X16, X5
    ADCS  W7, W24, W19
    CRC32H  W10, W20, W13
    CRC32CB  W12, W2, W20
    SUBS  X25, X19, X22, ASR #31
    CRC32CH  W26, W8, W5
    SUB  W14, W25, W17, SXTW #4
    SUBS  X23, X23, #0x1
    B.NE  TaishanIntMduP02_label_56
    MOVZ  X28, #0xf90f, LSL #0
    MOVK  X28, #0x64ff, LSL #16
    MOVK  X28, #0x1042, LSL #32
    MOVK  X28, #0xffba, LSL #48
    SUB  X11, X28, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X29, #0xc4e0, LSL #0
    MOVK  X29, #0xdfdf, LSL #16
    SUB  X8, X29, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP02_TestFail
    MOVZ  X8, #0x190, LSL #0
    SUB  X20, X8, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X27, #0xff6c, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X21, X27, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X15, #0xdde1, LSL #0
    MOVK  X15, #0xdfdf, LSL #16
    SUB  X7, X15, X7
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X12, #0x190, LSL #0
    SUB  X21, X12, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X10, #0xffc0, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffc0, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X27, X10, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X25, #0xffc0, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffc0, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X28, X25, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP02_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X22, #0x190, LSL #0
    SUB  X8, X22, X12
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP02_TestFail
    MOVZ  X23, #0xa7fa, LSL #0
    MOVK  X23, #0x90, LSL #16
    SUB  X14, X23, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP02_TestFail
    MOVZ  X22, #0xdde1, LSL #0
    MOVK  X22, #0xdfdf, LSL #16
    SUB  X23, X22, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x2, LSL #16
    SUB  X14, X24, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X12, #0x72f7, LSL #0
    MOVK  X12, #0xf856, LSL #16
    SUB  X7, X12, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X23, #0x1, LSL #0
    MOVK  X23, #0x71e0, LSL #48
    SUB  X5, X23, X19
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X21
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X25, #0xdde1, LSL #0
    MOVK  X25, #0xdfdf, LSL #16
    SUB  X10, X25, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
    MOVZ  X8, #0x1, LSL #0
    MOVK  X8, #0x71e0, LSL #48
    SUB  X19, X8, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x2, LSL #16
    SUB  X10, X16, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
    MOVZ  X18, #0xdde1, LSL #0
    MOVK  X18, #0xdfdf, LSL #16
    SUB  X22, X18, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP02_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X26
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X7, X11, X27
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X5, X16, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP02_TestFail
    MOVZ  X7, #0xc4e0, LSL #0
    MOVK  X7, #0xdfdf, LSL #16
    SUB  X26, X7, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X2, #0x69fc, LSL #0
    MOVK  X2, #0x5789, LSL #16
    MOVK  X2, #0x9916, LSL #32
    MOVK  X2, #0x8c1a, LSL #48
    MOVZ  X3, #0x2dbb, LSL #0
    MOVK  X3, #0xa20c, LSL #16
    MOVK  X3, #0xbf45, LSL #32
    MOVK  X3, #0x42f5, LSL #48
    MOVZ  X5, #0x933e, LSL #0
    MOVK  X5, #0xb707, LSL #16
    MOVK  X5, #0xbe5f, LSL #32
    MOVK  X5, #0x2f8a, LSL #48
    MOVZ  X6, #0xf2fa, LSL #0
    MOVK  X6, #0xf775, LSL #16
    MOVK  X6, #0x8048, LSL #32
    MOVK  X6, #0xf3f6, LSL #48
    MOVZ  X7, #0xc348, LSL #0
    MOVK  X7, #0xabd2, LSL #16
    MOVK  X7, #0x8a21, LSL #32
    MOVK  X7, #0x8927, LSL #48
    MOVZ  X8, #0xabc9, LSL #0
    MOVK  X8, #0xd486, LSL #16
    MOVK  X8, #0x1dde, LSL #32
    MOVK  X8, #0x8e00, LSL #48
    MOVZ  X9, #0x2f67, LSL #0
    MOVK  X9, #0xcded, LSL #16
    MOVK  X9, #0x17ef, LSL #32
    MOVK  X9, #0x5ff0, LSL #48
    MOVZ  X10, #0x4375, LSL #0
    MOVK  X10, #0x890c, LSL #16
    MOVK  X10, #0xcf80, LSL #32
    MOVK  X10, #0x75fc, LSL #48
    MOVZ  X11, #0xe737, LSL #0
    MOVK  X11, #0x7e79, LSL #16
    MOVK  X11, #0xfedf, LSL #32
    MOVK  X11, #0x384f, LSL #48
    MOVZ  X12, #0xa0d8, LSL #0
    MOVK  X12, #0x641a, LSL #16
    MOVK  X12, #0x8ea3, LSL #32
    MOVK  X12, #0x5a6d, LSL #48
    MOVZ  X13, #0x43d, LSL #0
    MOVK  X13, #0xfb42, LSL #16
    MOVK  X13, #0x8cf6, LSL #32
    MOVK  X13, #0x202b, LSL #48
    MOVZ  X14, #0xce67, LSL #0
    MOVK  X14, #0x94b4, LSL #16
    MOVK  X14, #0x9db0, LSL #32
    MOVK  X14, #0xbfa4, LSL #48
    MOVZ  X15, #0xd74, LSL #0
    MOVK  X15, #0xd936, LSL #16
    MOVK  X15, #0xbef1, LSL #32
    MOVK  X15, #0x9686, LSL #48
    MOVZ  X16, #0x5489, LSL #0
    MOVK  X16, #0x190d, LSL #16
    MOVK  X16, #0x7c6b, LSL #32
    MOVK  X16, #0x7814, LSL #48
    MOVZ  X17, #0x8fd0, LSL #0
    MOVK  X17, #0x147a, LSL #16
    MOVK  X17, #0xd400, LSL #32
    MOVK  X17, #0x7235, LSL #48
    MOVZ  X18, #0x735, LSL #0
    MOVK  X18, #0x604b, LSL #16
    MOVK  X18, #0x4adc, LSL #32
    MOVK  X18, #0x19b4, LSL #48
    MOVZ  X19, #0x4267, LSL #0
    MOVK  X19, #0x7266, LSL #16
    MOVK  X19, #0x6d51, LSL #32
    MOVK  X19, #0x9a57, LSL #48
    MOVZ  X20, #0x1d44, LSL #0
    MOVK  X20, #0x6bf1, LSL #16
    MOVK  X20, #0x857, LSL #32
    MOVK  X20, #0xf389, LSL #48
    MOVZ  X21, #0x7462, LSL #0
    MOVK  X21, #0xf05b, LSL #16
    MOVK  X21, #0x2fbb, LSL #32
    MOVK  X21, #0x7061, LSL #48
    MOVZ  X22, #0x2f24, LSL #0
    MOVK  X22, #0x3bd5, LSL #16
    MOVK  X22, #0xe5a8, LSL #32
    MOVK  X22, #0x1f28, LSL #48
    MOVZ  X23, #0x6411, LSL #0
    MOVK  X23, #0x114, LSL #16
    MOVK  X23, #0xce62, LSL #32
    MOVK  X23, #0x83ab, LSL #48
    MOVZ  X24, #0xf6e5, LSL #0
    MOVK  X24, #0x10f1, LSL #16
    MOVK  X24, #0x283f, LSL #32
    MOVK  X24, #0xabd0, LSL #48
    MOVZ  X25, #0x19b6, LSL #0
    MOVK  X25, #0x40c1, LSL #16
    MOVK  X25, #0xc18d, LSL #32
    MOVK  X25, #0x2f21, LSL #48
    MOVZ  X26, #0x8483, LSL #0
    MOVK  X26, #0xf972, LSL #16
    MOVK  X26, #0x1de8, LSL #32
    MOVK  X26, #0x27b5, LSL #48
    MOVZ  X27, #0xabd6, LSL #0
    MOVK  X27, #0x5673, LSL #16
    MOVK  X27, #0x5854, LSL #32
    MOVK  X27, #0x2f63, LSL #48
    MOVZ  X28, #0x8c6d, LSL #0
    MOVK  X28, #0xb6ae, LSL #16
    MOVK  X28, #0x40ae, LSL #32
    MOVK  X28, #0x8fa4, LSL #48
    MOVZ  X29, #0x42c9, LSL #0
    MOVK  X29, #0x3fc9, LSL #16
    MOVK  X29, #0xdd9c, LSL #32
    MOVK  X29, #0x2f00, LSL #48
    MOVZ  X19, #0xa, LSL #0
TaishanIntMduP02_label_84:
    ADD  X18, X27, W3, SXTB #3
    SMULH  X26, X13, X13
    ADDS  W14, W29, W27, ASR #29
    EOR  W25, W19, W23, LSL #15
    EXTR  X18, X26, X24, #0x1b
    UBFM  X21, X28, #0x12, #0x25
    ADC  X14, X27, X25
    ADD  W3, W9, W6, SXTW #0
    ADDS  X12, X3, X16, LSR #35
    ADDS  X18, X27, X23, LSR #58
    CRC32CH  W24, W12, W26
    BIC  W27, W21, W21, LSR #31
    MOVZ  X27, #0x9e48, LSL #48
    MOVZ  X28, #0x98e7, LSL #32
    UBFM  W23, W12, #0x14, #0x1d
    SUB  X6, X19, W26, UXTB #0
    EOR  W14, W6, #0x7fffe
    BIC  V20.16B, V31.16B, V21.16B
    AND  X2, X28, X10, ROR #3
    SMSUBL  X3, W23, W27, X25
    UMULH  X15, X27, X13
    SUB  W16, W18, W23, LSL #10
    CRC32W  W7, W23, W23
    ORR  V22.2S, #0xed, LSL #8
    LSRV  W23, W2, W24
    BIC  W23, W29, W12, ROR #29
    AND  X8, X18, X28, ASR #63
    MOVK  X6, #0xcc9b, LSL #32
    SMADDL  X16, W8, W20, X21
    MADD  X18, X26, X19, X3
    SUB  W3, W27, W23, SXTW #1
    MOVZ  X11, #0xcc3f, LSL #48
    AND  X26, X10, X28, ASR #8
    BIC  V12.16B, V15.16B, V12.16B
    CSNEG  X27, X24, X6, LT
    CLZ  X27, X3
    ADDS  W7, W9, #0x410
    AND  W7, W27, W12, ASR #12
    AND  W20, W19, #0x1e001e0
    ADC  X6, X26, X8
    AND  W23, W27, W9, LSR #24
    SUBS  X8, X12, X24, LSL #26
    CSNEG  X27, X15, X20, VC
    CSEL  X15, X11, X13, NV
    SUB  X8, X6, #0xa70
    CRC32CB  W2, W21, W21
    CSINC  X16, X10, X6, PL
    CLS  X7, X10
    SBFM  X26, X7, #0x3a, #0x26
    CSINV  X12, X21, X15, AL
    SUB  X12, X18, W26, SXTH #3
    ORR  X29, X14, #0x3fffc0000
    ADD  W20, W3, #0x142
    BICS  W2, W5, W16, LSR #9
    CSEL  X6, X10, X10, AL
    MOVZ  W23, #0x14fc, LSL #16
    SUB  X28, X27, #0xf83
    AND  X17, X28, X11, LSR #55
    MOVN  W12, #0xed7, LSL #16
    CSNEG  W18, W2, W20, CC
    MADD  W17, W7, W2, W23
    ADD  W6, W12, W24, ASR #9
    BIC  X7, X7, X8, LSR #52
    CRC32CX  W7, W16, X14
    ADCS  W7, W5, W9
    SUB  X7, X23, W20, UXTB #3
    BIC  X9, X25, X29, LSR #40
    LSLV  W28, W28, W19
    CSINC  X27, X10, X21, AL
    ADD  W14, W28, #0x6c
    SUB  X23, X24, X2, LSR #16
    SUBS  X21, X18, X20, ASR #33
    MOVZ  W9, #0x526, LSL #16
    ORR  X7, X2, X10, LSL #54
    SUB  X20, X14, #0x154
    CSEL  X17, X17, X28, VC
    CSEL  X17, X23, X21, EQ
    ADCS  W25, W9, W14
    CSINC  X25, X18, X12, LE
    CLZ  W9, W7
    SBFM  X11, X22, #0x3, #0x31
    ADD  W21, W23, W25, UXTB #1
    AND  X20, X29, #0xff8000007fffffff
    CSINV  X15, X11, X27, CC
    EXTR  X8, X10, X5, #0x31
    SMADDL  X12, W8, W9, X17
    ANDS  W15, W29, #0x80018001
    MOVN  W8, #0x80d7, LSL #16
    EON  X25, X8, X17, ASR #53
    CLZ  W26, W11
    ADCS  W26, W14, W22
    EXTR  X13, X6, X14, #0x9
    SUB  X12, X15, X23, ASR #55
    ANDS  X27, X5, X6, LSR #56
    UMSUBL  X7, W27, W12, X22
    ORR  W2, W7, W18, LSR #22
    CSINV  W12, W7, W8, LE
    SBFM  X27, X29, #0x33, #0x8
    EXTR  W12, W15, W26, #0x5
    CRC32CW  W5, W21, W14
    SUB  X21, X8, W23, SXTH #1
    LSLV  W2, W6, W26
    CSEL  W11, W18, W13, CS
    SMADDL  X14, W11, W14, X20
    SUB  W9, W2, W21, LSR #0
    CLS  X14, X25
    ANDS  W6, W17, W18, LSR #26
    EXTR  X23, X28, X7, #0x38
    MADD  X21, X24, X29, X9
    ORR  W25, W6, W26, ASR #16
    SUBS  X23, X13, W11, SXTW #0
    SBFM  X2, X27, #0x2, #0x5
    AND  W8, W11, #0x40404040
    SUBS  W15, W7, #0x1c0
    ANDS  X17, X7, #0x3fffffffffe000
    ADCS  X10, X9, X16
    MOVK  X21, #0x5594, LSL #16
    CRC32X  W16, W3, X14
    UMADDL  X9, W8, W14, X14
    ASRV  W15, W25, W15
    SUB  X5, X10, X24, ASR #63
    ADCS  X18, X6, X7
    ORN  W21, W18, W28, LSL #10
    SUB  X12, X29, X7, LSR #5
    MOVK  X22, #0xfb3a, LSL #0
    CRC32X  W29, W29, X15
    SUBS  W16, W23, W5, UXTB #3
    ADD  X12, X27, X28, LSL #51
    UMSUBL  X3, W24, W25, X27
    BICS  W13, W25, W8, LSL #27
    EXTR  X26, X28, X22, #0x18
    ORN  X22, X23, X17, ASR #22
    SUB  W18, W25, #0xcec
    ANDS  X12, X27, #0x1ffff00000
    CSEL  X16, X8, X11, GT
    UMADDL  X5, W21, W18, X12
    MADD  W8, W18, W28, W22
    ANDS  W21, W28, #0xffff07ff
    MADD  X10, X9, X24, X22
    SBFM  X8, X3, #0x2f, #0x25
    EOR  X9, X13, X15, LSL #13
    BICS  X7, X13, X21, ROR #23
    ORR  V25.4H, #0x8a, LSL #8
    SUBS  W13, W8, #0x328
    UBFM  X24, X2, #0x1d, #0x26
    BIC  X9, X23, X3, ROR #42
    ORR  X24, X10, X19, LSR #27
    SUBS  X26, X17, X8, LSL #36
    AND  W7, W23, #0x8000000
    ASRV  X13, X7, X23
    CLZ  V17.4S, V7.4S
    ADD  W10, W13, W29, LSR #17
    BIC  V27.16B, V4.16B, V7.16B
    MOVN  X5, #0xba1f, LSL #16
    CSINC  X11, X5, X29, VS
    BIC  W28, W21, W7, LSL #6
    ADD  W27, W16, W29, UXTX #1
    CLZ  V23.2S, V18.2S
    EON  W21, W17, W24, ASR #24
    SUBS  W20, W27, W27, LSR #23
    SUBS  X10, X16, W18, UXTW #3
    ADCS  W16, W10, W23
    ASRV  X17, X29, X8
    ADDS  X28, X11, X12, LSL #9
    ADD  X8, X25, X26, LSL #6
    ORR  V17.4S, #0x67, LSL #24
    ADD  X26, X29, W25, UXTW #4
    CSNEG  X10, X26, X11, GT
    SUB  X12, X16, W16, UXTW #0
    MADD  X8, X21, X6, X26
    CRC32H  W16, W6, W12
    ORR  X2, X2, X19, ASR #31
    MOVZ  X21, #0x889, LSL #32
    CSEL  W10, W19, W21, HI
    SUB  W2, W24, W6, ASR #17
    SUB  X21, X23, W18, SXTW #4
    ADD  W7, W15, W27, SXTW #3
    MADD  X17, X16, X28, X21
    EON  W18, W6, W15, ROR #29
    BICS  X8, X18, X29, LSR #41
    CSINV  W5, W21, W8, HI
    SUB  X13, X18, #0xe4d, LSL #12
    BIC  X23, X19, X12, LSR #43
    CSEL  X2, X18, X14, NE
    CLZ  V15.8H, V12.8H
    ORR  W24, W7, W2, LSL #12
    UBFM  W24, W7, #0x12, #0x8
    ADCS  W25, W17, W5
    SUB  W15, W24, W13, ASR #7
    MADD  X9, X13, X11, X11
    CSEL  X12, X27, X9, GE
    SUB  X6, X12, #0xdec
    CRC32W  W26, W26, W17
    SUB  W7, W11, W12, ASR #9
    ORR  W18, W19, #0xf3fff3ff
    ADDS  W11, W2, #0xb27
    CLZ  X5, X24
    ORR  X12, X23, #0xc0000000000001ff
    LSLV  X6, X25, X9
    ADD  W16, W6, W27, UXTB #2
    SUBS  X19, X19, #0x1
    B.NE  TaishanIntMduP02_label_84
    MOVZ  X9, #0x20, LSL #0
    SUB  X11, X9, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X17, #0xe7bc, LSL #0
    MOVK  X17, #0x5ab7, LSL #16
    MOVK  X17, #0x530d, LSL #32
    MOVK  X17, #0xdd6d, LSL #48
    SUB  X25, X17, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x29, LSL #0
    SUB  X18, X20, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X12, #0xc0fe, LSL #0
    MOVK  X12, #0x1, LSL #16
    SUB  X16, X12, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X22, #0xdfe1, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X6, X22, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP02_TestFail
    MOVZ  X12, #0x20, LSL #0
    SUB  X7, X12, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x20, LSL #0
    SUB  X12, X20, X12
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X13
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X24, #0x20, LSL #0
    SUB  X14, X24, X14
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X18, #0x89a0, LSL #0
    MOVK  X18, #0x81, LSL #16
    SUB  X9, X18, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X8, #0xe7bc, LSL #0
    MOVK  X8, #0x5ab7, LSL #16
    MOVK  X8, #0x530d, LSL #32
    MOVK  X8, #0xdd6d, LSL #48
    SUB  X12, X8, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP02_TestFail
    MOVZ  X21, #0x89a0, LSL #0
    MOVK  X21, #0x81, LSL #16
    SUB  X28, X21, X18
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP02_TestFail
    MOVZ  X3, #0x20, LSL #0
    SUB  X21, X3, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X11, X19, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X6, #0x1, LSL #0
    SUB  X8, X6, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x20, LSL #0
    SUB  X23, X26, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X2, #0x20, LSL #0
    SUB  X13, X2, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP02_TestFail
    MOVZ  X9, #0x4040, LSL #0
    MOVK  X9, #0x40, LSL #16
    SUB  X21, X9, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X16, X14, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X2, X20, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
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
    MOVZ  X16, #0xa, LSL #0
TaishanIntMduP02_label_112:
    EON  W19, W5, W28, LSR #31
    EOR  W12, W18, #0x2000200
    AND  X22, X6, #0xffffff8000003fff
    ORR  X8, X11, X17, ROR #16
    ADD  X25, X23, #0x77f
    ORR  W28, W15, #0xfc007fff
    ANDS  X9, X24, X5, ASR #49
    CSNEG  X12, X18, X6, CC
    EXTR  W17, W18, W15, #0x2
    MOVK  W24, #0x3c9c, LSL #16
    SBFM  X17, X11, #0x3d, #0x18
    ADD  W18, W27, W10, ASR #18
    LSRV  X17, X19, X5
    SBFM  W2, W17, #0xf, #0xa
    MOVN  X28, #0xbe52, LSL #0
    UMADDL  X7, W16, W18, X5
    CLS  W17, W25
    MADD  X9, X3, X28, X8
    ADDS  X18, X19, W25, UXTH #3
    ADD  W3, W13, W9, UXTX #1
    UMSUBL  X29, W8, W2, X14
    ADCS  W6, W23, W7
    SUBS  W6, W8, W24, LSR #18
    ORR  W8, W15, #0x20000000
    ADD  W8, W22, W10, UXTB #2
    CLS  X17, X8
    MOVK  X14, #0x39d6, LSL #16
    CLZ  X18, X23
    ADD  X3, X2, W8, UXTB #4
    BIC  W21, W6, W27, ASR #8
    SUB  X21, X9, #0x7bb, LSL #12
    LSLV  X15, X13, X25
    ADD  W24, W14, W29, LSL #13
    UMULH  X17, X7, X5
    UBFM  W17, W19, #0x0, #0x11
    CSNEG  W22, W26, W23, LT
    ORR  X22, X10, X6, LSL #27
    CSINV  X13, X20, X18, CC
    CRC32CW  W12, W8, W22
    EOR  X27, X5, X26, ASR #56
    MADD  X11, X28, X3, X17
    SUB  X29, X13, W27, SXTB #1
    CRC32H  W11, W3, W21
    SUB  W14, W15, #0x0
    CSEL  W12, W24, W17, LS
    MOVK  W11, #0x4656, LSL #0
    ADD  X13, X23, W17, UXTB #3
    CRC32H  W9, W19, W29
    CLS  V21.8H, V21.8H
    CLZ  W2, W18
    UBFM  X13, X16, #0x2c, #0x7
    CRC32CW  W2, W11, W11
    ADDS  X18, X6, #0xde, LSL #12
    LSLV  W26, W19, W16
    ORR  X24, X25, X7, LSL #4
    ANDS  W3, W28, #0xfe00007f
    ANDS  X17, X7, X18, ROR #44
    ADCS  X7, X5, X17
    ADD  W2, W24, W3, UXTB #2
    SUB  W28, W21, #0xe40, LSL #12
    ANDS  X11, X16, X2, LSR #8
    ANDS  X11, X9, X9, LSL #4
    ORR  V27.8H, #0x84, LSL #8
    CLZ  X18, X25
    MOVN  X18, #0x60d8, LSL #16
    CSINC  W8, W20, W23, HI
    ADD  W20, W18, W18, ASR #10
    ADDS  W28, W28, #0xc92, LSL #12
    BICS  X8, X9, X10, LSR #14
    CLS  W15, W29
    CRC32H  W26, W3, W14
    SMULH  X6, X26, X19
    EON  W23, W10, W16, LSR #31
    SUB  X3, X29, X16, LSL #33
    ASRV  X14, X24, X15
    BIC  X26, X26, X23, ROR #54
    SMADDL  X3, W26, W20, X24
    ADDS  W3, W17, W10, LSL #16
    CRC32CW  W26, W29, W6
    AND  X15, X19, X19, LSL #7
    ADDS  W5, W20, W5, SXTW #4
    MOVZ  W12, #0xa994, LSL #0
    ANDS  X5, X8, #0xf0000000f000000
    BICS  W8, W21, W29, LSL #15
    BICS  X23, X19, X28, LSL #23
    ANDS  W10, W22, W8, LSR #9
    CSINV  X12, X24, X10, GT
    SUBS  X14, X2, X23, LSR #45
    ADD  X19, X26, #0xebb, LSL #12
    BICS  W19, W19, W20, LSL #15
    CRC32B  W23, W27, W8
    CSNEG  X17, X17, X15, NE
    ORR  X11, X14, #0x38000000000
    CSNEG  X15, X14, X19, GT
    SUB  X10, X16, #0x757
    ADD  W2, W10, W24, SXTW #0
    SUB  W14, W23, #0x0
    ADD  X17, X9, #0x790
    CLZ  W27, W10
    LSRV  W7, W16, W11
    ANDS  W3, W11, W11, ASR #4
    CSEL  X15, X9, X5, MI
    AND  X23, X24, X10, ASR #42
    CSINC  W25, W8, W15, GT
    AND  W10, W2, #0x7fc
    ADDS  W25, W6, W10, UXTB #3
    CSINV  W26, W23, W6, EQ
    ORR  W9, W25, W22, ASR #14
    MOVK  W27, #0x71ef, LSL #0
    MOVZ  W13, #0xb0e5, LSL #0
    LSLV  W19, W23, W23
    ADCS  X12, X20, X3
    SUBS  W14, W24, W27, LSR #23
    SMULH  X28, X9, X24
    EXTR  W6, W19, W14, #0x14
    EOR  X29, X24, #0xffffffe000ffffff
    MADD  X26, X16, X26, X12
    CSEL  X28, X6, X9, LS
    SUB  W27, W2, W7, UXTW #1
    ADCS  W19, W9, W13
    SUB  X23, X2, #0xe8f
    CLS  X26, X27
    EXTR  X2, X29, X17, #0x15
    MADD  X2, X16, X9, X2
    CRC32B  W19, W22, W22
    SUBS  X19, X26, X18, ASR #12
    UBFM  X20, X15, #0x20, #0x5
    UMSUBL  X13, W28, W17, X12
    ADD  X22, X13, X20, LSL #53
    ADD  W29, W15, #0x9e0, LSL #12
    ADD  X21, X22, W7, UXTW #2
    SUB  W26, W28, #0x460
    ORR  V28.4H, #0x7f, LSL #8
    LSLV  X11, X5, X26
    EON  W19, W3, W12, ROR #4
    SBFM  X3, X24, #0x22, #0x18
    CLZ  X6, X5
    LSLV  W21, W7, W13
    BICS  X17, X16, X24, LSR #26
    ADDS  W23, W7, W6, SXTW #2
    EOR  W28, W10, #0xfffffdff
    BICS  X6, X21, X7, ASR #56
    ORR  V4.8B, V4.8B, V15.8B
    SMULH  X10, X14, X23
    CSINC  W2, W2, W2, HI
    CRC32X  W10, W5, X21
    ADCS  W25, W6, W18
    UMULH  X7, X21, X9
    ORR  V16.8B, V16.8B, V30.8B
    BIC  W3, W11, W29, ASR #1
    ADD  X9, X18, X24, LSL #28
    ORR  X22, X22, #0xf3f3f3f3f3f3f3f3
    CSINV  X22, X11, X20, EQ
    ADD  X25, X28, X23, LSR #7
    BIC  X11, X15, X22, ROR #32
    MOVK  X8, #0xef8c, LSL #48
    SUBS  X2, X27, #0xce
    CRC32H  W11, W15, W19
    CLS  W3, W9
    ASRV  W28, W14, W20
    CLZ  V15.2S, V17.2S
    SUB  W5, W28, #0x768, LSL #12
    ASRV  W15, W9, W9
    ORR  W3, W19, #0x3fffc00
    UBFM  W9, W2, #0x15, #0x4
    ORN  W10, W2, W18, ROR #17
    SMULH  X12, X25, X5
    ASRV  W26, W7, W18
    UMSUBL  X25, W3, W6, X28
    MOVZ  X15, #0xf05d, LSL #16
    AND  W23, W13, #0xe7ffe7ff
    ADD  W8, W17, W9, SXTH #2
    ANDS  X8, X21, X22, ROR #40
    CLS  X6, X21
    SBFM  X10, X2, #0x12, #0x5
    CSEL  X17, X22, X29, NE
    BICS  W6, W13, W21, ROR #9
    CRC32W  W7, W6, W25
    UMULH  X27, X9, X6
    CSINV  W21, W12, W2, PL
    CLZ  W13, W3
    ADD  X25, X17, W29, UXTW #3
    AND  X11, X18, X5, LSR #9
    SUBS  X2, X19, #0xed6, LSL #12
    SUB  W13, W16, W19, SXTX #0
    SUBS  X23, X3, X5, LSL #12
    CRC32CH  W13, W21, W29
    CRC32CB  W17, W22, W21
    CLZ  V2.2S, V22.2S
    AND  W25, W2, W29, LSL #5
    MOVN  W21, #0x4d1e, LSL #16
    SUBS  W28, W7, W17, SXTB #4
    CRC32CX  W18, W6, X16
    ADCS  W19, W10, W16
    ORR  W5, W10, #0xffffffc1
    CSINV  W12, W28, W13, CS
    SUB  W28, W26, #0x226, LSL #12
    EON  X19, X22, X3, ROR #54
    CRC32H  W13, W19, W9
    EXTR  W12, W26, W16, #0x18
    SUBS  X16, X16, #0x1
    B.NE  TaishanIntMduP02_label_112
    MOVZ  X11, #0x9ecd, LSL #0
    MOVK  X11, #0x4903, LSL #16
    SUB  X20, X11, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X7, #0xfecd, LSL #0
    MOVK  X7, #0x4bff, LSL #16
    SUB  X16, X7, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X10, #0xffc1, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X11, X10, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X19, #0xbf64, LSL #0
    MOVK  X19, #0x8343, LSL #16
    SUB  X21, X19, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X19, #0xfecd, LSL #0
    MOVK  X19, #0x4bff, LSL #16
    SUB  X24, X19, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP02_TestFail
    MOVZ  X11, #0xb800, LSL #0
    SUB  X13, X11, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP02_TestFail
    MOVZ  X16, #0xffc1, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X24, X16, X10
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP02_TestFail
    MOVZ  X21, #0xb800, LSL #0
    SUB  X19, X21, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X25, X5, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP02_TestFail
    MOVZ  X17, #0xfcbb, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X9, X17, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xf05d, LSL #16
    SUB  X20, X27, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X18, #0xffc1, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X5, X18, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP02_TestFail
    MOVZ  X23, #0xfcbb, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X17, X23, X17
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP02_TestFail
    MOVZ  X27, #0xffc1, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X23, X27, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X19
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
    MOVZ  X18, #0xb800, LSL #0
    SUB  X6, X18, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xfff8, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X16, X7, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X24
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X2, #0xffc1, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X14, X2, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X13, #0xa000, LSL #0
    MOVK  X13, #0xffdd, LSL #16
    SUB  X24, X13, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP02_TestFail
    MOVZ  X3, #0x2d87, LSL #0
    MOVK  X3, #0xc2ed, LSL #16
    SUB  X23, X3, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP02_TestFail
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
    MOVZ  X29, #0xa, LSL #0
TaishanIntMduP02_label_139:
    CSINC  X26, X26, X25, CC
    CRC32H  W14, W24, W20
    AND  X24, X29, X13, ASR #34
    ANDS  X7, X27, X28, ASR #25
    CSNEG  X3, X7, X7, CS
    ADDS  W17, W25, W22, UXTW #4
    CSINC  X26, X22, X13, HI
    CRC32CB  W16, W24, W22
    ADC  X18, X14, X22
    MOVN  W16, #0x83d6, LSL #0
    SBFM  W16, W22, #0x5, #0x10
    ORR  V27.4H, #0xe6, LSL #8
    ANDS  X14, X9, X21, LSL #29
    SUBS  X10, X18, W18, SXTB #1
    ORN  W26, W28, W12, LSR #8
    ADD  W19, W26, W25, SXTW #1
    CLZ  V19.16B, V10.16B
    ADD  W3, W6, #0xb72, LSL #12
    ORR  V15.2S, #0xc5
    SUBS  W23, W18, W19, LSL #14
    AND  W14, W29, W14, ASR #21
    CLS  V29.4H, V23.4H
    ORR  V27.8B, V16.8B, V30.8B
    CRC32CX  W16, W5, X17
    SUBS  W22, W22, #0xa08
    ADDS  X28, X23, W29, SXTH #1
    ORR  V14.8B, V24.8B, V5.8B
    MADD  X14, X29, X5, X24
    BIC  X7, X17, X3, ROR #60
    ORN  X23, X18, X9, ROR #32
    ADDS  X16, X19, #0x106
    CSNEG  W21, W14, W25, HI
    SBFM  W6, W20, #0x7, #0x1d
    CRC32CH  W5, W3, W29
    CSINC  W13, W15, W28, GT
    SUB  W19, W22, W16, LSR #29
    CRC32CX  W8, W17, X22
    UBFM  W25, W8, #0x7, #0x8
    CLZ  V8.16B, V9.16B
    CSEL  X27, X24, X3, EQ
    ADDS  W27, W15, #0xab4, LSL #12
    ASRV  X24, X8, X3
    BICS  W23, W3, W18, ROR #19
    EON  X16, X3, X10, LSR #35
    SUBS  W21, W15, W3, UXTW #4
    CLS  V1.4H, V12.4H
    ASRV  X5, X19, X22
    CRC32H  W20, W22, W13
    MOVZ  X21, #0x9f2e, LSL #48
    UBFM  W11, W6, #0x1b, #0x3
    ADCS  X14, X6, X18
    SUB  W14, W10, W5, UXTX #2
    SBFM  X11, X28, #0x24, #0x29
    CRC32CH  W9, W3, W12
    LSRV  W23, W5, W8
    SUB  X6, X8, X29, LSL #50
    ANDS  X2, X15, #0x1ff8000000000000
    CRC32CX  W6, W18, X28
    CSINC  X25, X11, X15, LS
    BICS  X8, X29, X15, ASR #36
    UMADDL  X2, W12, W20, X16
    ADDS  X14, X12, X12, LSL #4
    SUB  W20, W3, W8, UXTW #1
    CSNEG  X12, X6, X13, NV
    SUBS  W25, W29, W14, LSL #19
    ADCS  X17, X21, X25
    ADD  X13, X19, #0xf10
    CSNEG  X3, X12, X18, MI
    SUB  X17, X22, X3, SXTX #3
    CSINC  X24, X10, X22, NE
    SUB  X20, X17, X11, SXTX #2
    ADC  X13, X22, X19
    ORR  V2.8H, #0x53, LSL #8
    MADD  X3, X7, X16, X5
    EOR  X6, X24, X22, LSL #27
    BICS  X16, X2, X11, ROR #34
    SUBS  W24, W14, W20, SXTW #1
    ADD  X18, X18, W3, SXTH #0
    ADDS  W2, W18, W26, LSL #17
    ADCS  X16, X22, X24
    ORR  V4.2S, #0x11, LSL #24
    CRC32B  W26, W14, W5
    SUBS  X27, X19, X16, LSL #14
    ORN  X6, X10, X12, ASR #37
    BIC  V23.16B, V16.16B, V20.16B
    ADD  W22, W27, #0x1a0
    BIC  X2, X5, X5, ASR #14
    EON  X22, X26, X22, LSR #42
    LSLV  X13, X3, X27
    LSRV  W11, W2, W21
    ORN  X13, X13, X23, ROR #37
    ADC  W15, W5, W21
    ANDS  X7, X6, X19, LSL #38
    BIC  X16, X26, X14, ROR #5
    ORR  X14, X2, X15, LSR #16
    LSLV  W16, W25, W19
    MOVZ  X7, #0xb76e, LSL #0
    ORR  V7.8H, #0x6b, LSL #8
    ADD  X18, X3, W20, UXTW #1
    EOR  W13, W20, #0x1800180
    EXTR  X12, X3, X17, #0x1a
    CRC32B  W23, W17, W14
    CRC32H  W23, W17, W23
    ADDS  X6, X11, #0xe2a
    SUBS  W16, W23, #0xcb6
    CLZ  W28, W22
    LSRV  X27, X16, X23
    MOVN  X25, #0xe132, LSL #48
    ORR  V11.4H, #0x3
    ORN  X16, X20, X17, ASR #23
    ADDS  W15, W18, #0x281, LSL #12
    ORR  X7, X5, #0x7ffffc0000
    ASRV  X14, X18, X22
    SUB  X11, X5, W23, UXTH #1
    MOVN  W10, #0x7001, LSL #16
    ORR  V6.2S, #0x8e
    AND  X10, X5, #0xfffffc0000001fff
    ASRV  X5, X25, X26
    MOVK  X5, #0x225c, LSL #0
    EXTR  W27, W3, W19, #0xb
    ANDS  X12, X22, #0x1fffffffffe0000
    ORR  V6.2S, #0xed, LSL #16
    ADCS  X20, X18, X3
    ORR  X9, X19, X7, ROR #55
    CLS  W21, W23
    MOVN  W19, #0x7c4, LSL #0
    EON  X21, X19, X7, LSL #38
    LSRV  X26, X16, X26
    SUBS  W5, W9, W24, SXTH #2
    MOVZ  W26, #0xc076, LSL #16
    LSLV  W3, W24, W14
    LSLV  W2, W25, W3
    LSRV  W6, W24, W3
    MADD  X17, X28, X26, X22
    CSINV  W19, W14, W10, AL
    AND  W12, W2, #0xfffc0007
    ORR  V29.2S, #0xec, LSL #16
    EON  W9, W18, W20, ASR #21
    MOVZ  X28, #0x3868, LSL #48
    SUBS  W7, W29, W27, LSL #12
    CRC32W  W22, W5, W22
    EXTR  X24, X22, X2, #0x18
    BIC  X3, X14, X24, LSL #27
    ANDS  W12, W3, #0x7f80
    SMULH  X18, X12, X21
    BIC  V14.16B, V24.16B, V23.16B
    EOR  X9, X19, X29, ROR #7
    CSEL  X14, X27, X24, EQ
    MOVZ  X23, #0xab43, LSL #16
    SMSUBL  X9, W16, W16, X9
    SMSUBL  X2, W14, W5, X14
    ADD  W24, W10, W10, UXTX #3
    AND  W11, W12, #0x3fff80
    UMADDL  X13, W18, W21, X23
    BICS  X28, X15, X17, ROR #51
    ADCS  X11, X15, X26
    BIC  X23, X14, X20, ASR #9
    CSNEG  W9, W28, W5, CC
    MOVK  W14, #0x2efc, LSL #16
    UBFM  W2, W7, #0x7, #0x9
    ORR  V25.8B, V16.8B, V26.8B
    MOVK  W9, #0x7596, LSL #16
    CRC32CW  W17, W8, W25
    SBFM  X24, X8, #0x2f, #0x38
    CRC32H  W14, W13, W5
    CSNEG  X19, X17, X22, LT
    SMADDL  X16, W13, W7, X27
    CSEL  W22, W20, W3, GE
    UBFM  X26, X26, #0x3d, #0x1e
    CSNEG  X16, X22, X11, MI
    ADD  X21, X23, W28, UXTH #3
    CSINC  W17, W24, W19, LT
    MOVK  X3, #0xc99e, LSL #48
    SBFM  X26, X2, #0x33, #0x1d
    ADDS  W3, W26, W9, LSL #1
    EXTR  X6, X6, X6, #0x35
    ADD  X17, X6, W20, UXTB #3
    ADC  X18, X29, X5
    CSEL  X10, X11, X7, AL
    SBFM  X5, X27, #0xd, #0x4
    SBFM  W28, W3, #0xd, #0x19
    SUB  X11, X15, X13, SXTX #1
    SBFM  X25, X26, #0x3e, #0x28
    MADD  W8, W12, W18, W16
    CRC32CW  W11, W17, W20
    CRC32X  W23, W20, X9
    CSINC  X24, X18, X25, VS
    ORR  V1.16B, V8.16B, V25.16B
    CLZ  W10, W14
    ORR  X3, X10, X20, LSR #20
    EON  W20, W12, W23, LSR #15
    BICS  X24, X12, X9, ROR #62
    SUB  X3, X19, #0x2b2
    EON  X3, X5, X16, ASR #17
    ANDS  W11, W6, #0xfe3ffe3f
    CSINV  X16, X8, X2, EQ
    ORR  V7.8H, #0xf6
    ORR  V20.2S, #0xa
    ORR  W3, W26, W29, ROR #5
    UBFM  W23, W28, #0x9, #0xa
    SUBS  X29, X29, #0x1
    B.NE  TaishanIntMduP02_label_139
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X2
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x800, LSL #16
    SUB  X8, X20, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x70, LSL #48
    SUB  X19, X18, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X16, #0xa000, LSL #0
    MOVK  X16, #0x63eb, LSL #16
    MOVK  X16, #0x417, LSL #32
    SUB  X19, X16, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X14, #0x2001, LSL #0
    MOVK  X14, #0x7bff, LSL #16
    SUB  X6, X14, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X17, #0x54ac, LSL #0
    MOVK  X17, #0x7596, LSL #16
    SUB  X20, X17, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X10
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
    MOVZ  X15, #0xa000, LSL #0
    MOVK  X15, #0x622b, LSL #16
    SUB  X22, X15, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP02_TestFail
    MOVZ  X15, #0x7f80, LSL #0
    SUB  X26, X15, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X15, #0xda3c, LSL #0
    MOVK  X15, #0xab46, LSL #16
    SUB  X14, X15, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X20, #0xda3c, LSL #0
    MOVK  X20, #0xab46, LSL #16
    SUB  X3, X20, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X15, #0xa000, LSL #0
    MOVK  X15, #0x63eb, LSL #16
    MOVK  X15, #0x417, LSL #32
    SUB  X5, X15, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP02_TestFail
    MOVZ  X22, #0x54ac, LSL #0
    MOVK  X22, #0x7596, LSL #16
    SUB  X25, X22, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x70, LSL #48
    SUB  X2, X11, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X15, #0xda3c, LSL #0
    MOVK  X15, #0xab46, LSL #16
    SUB  X17, X15, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP02_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X24, X7, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP02_TestFail
    MOVZ  X29, #0x54ac, LSL #0
    MOVK  X29, #0x7596, LSL #16
    SUB  X2, X29, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X21, X20, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP02_TestFail
    MOVZ  X9, #0x400e, LSL #0
    MOVK  X9, #0xf408, LSL #16
    SUB  X18, X9, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X2, #0xf965, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X6, X2, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X2, #0x54ac, LSL #0
    MOVK  X2, #0x7596, LSL #16
    SUB  X29, X2, X29
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X2, #0xb96a, LSL #0
    MOVK  X2, #0xd2a3, LSL #16
    MOVK  X2, #0x8b64, LSL #32
    MOVK  X2, #0x70ce, LSL #48
    MOVZ  X3, #0x8413, LSL #0
    MOVK  X3, #0xa16d, LSL #16
    MOVK  X3, #0x15f0, LSL #32
    MOVK  X3, #0xcc54, LSL #48
    MOVZ  X5, #0x8c5, LSL #0
    MOVK  X5, #0x7b2d, LSL #16
    MOVK  X5, #0x226d, LSL #32
    MOVK  X5, #0x6f64, LSL #48
    MOVZ  X6, #0x2a7e, LSL #0
    MOVK  X6, #0xd9a3, LSL #16
    MOVK  X6, #0x45cc, LSL #32
    MOVK  X6, #0x299c, LSL #48
    MOVZ  X7, #0xb4fa, LSL #0
    MOVK  X7, #0x64de, LSL #16
    MOVK  X7, #0x9975, LSL #32
    MOVK  X7, #0xe4c1, LSL #48
    MOVZ  X8, #0x7729, LSL #0
    MOVK  X8, #0x87a6, LSL #16
    MOVK  X8, #0xef76, LSL #32
    MOVK  X8, #0x596f, LSL #48
    MOVZ  X9, #0xe4c3, LSL #0
    MOVK  X9, #0x3610, LSL #16
    MOVK  X9, #0xce94, LSL #32
    MOVK  X9, #0x2388, LSL #48
    MOVZ  X10, #0x367f, LSL #0
    MOVK  X10, #0x1a50, LSL #16
    MOVK  X10, #0xf18a, LSL #32
    MOVK  X10, #0xf201, LSL #48
    MOVZ  X11, #0xe749, LSL #0
    MOVK  X11, #0xb5f8, LSL #16
    MOVK  X11, #0xdf83, LSL #32
    MOVK  X11, #0x89cd, LSL #48
    MOVZ  X12, #0x914f, LSL #0
    MOVK  X12, #0xeef9, LSL #16
    MOVK  X12, #0xd376, LSL #32
    MOVK  X12, #0xff53, LSL #48
    MOVZ  X13, #0x94b8, LSL #0
    MOVK  X13, #0x17af, LSL #16
    MOVK  X13, #0x42c1, LSL #32
    MOVK  X13, #0x4acf, LSL #48
    MOVZ  X14, #0xbba8, LSL #0
    MOVK  X14, #0x55a6, LSL #16
    MOVK  X14, #0x488, LSL #32
    MOVK  X14, #0xaed2, LSL #48
    MOVZ  X15, #0xd292, LSL #0
    MOVK  X15, #0x676a, LSL #16
    MOVK  X15, #0x1d75, LSL #32
    MOVK  X15, #0x6490, LSL #48
    MOVZ  X16, #0x3e82, LSL #0
    MOVK  X16, #0x87c4, LSL #16
    MOVK  X16, #0xecf5, LSL #32
    MOVK  X16, #0xab37, LSL #48
    MOVZ  X17, #0xd5ec, LSL #0
    MOVK  X17, #0xbddd, LSL #16
    MOVK  X17, #0x54be, LSL #32
    MOVK  X17, #0xdc39, LSL #48
    MOVZ  X18, #0x2b0, LSL #0
    MOVK  X18, #0xd2d0, LSL #16
    MOVK  X18, #0x869b, LSL #32
    MOVK  X18, #0x1275, LSL #48
    MOVZ  X19, #0x6f55, LSL #0
    MOVK  X19, #0xaa64, LSL #16
    MOVK  X19, #0x7533, LSL #32
    MOVK  X19, #0xba13, LSL #48
    MOVZ  X20, #0x7d3e, LSL #0
    MOVK  X20, #0xb6e3, LSL #16
    MOVK  X20, #0xb511, LSL #32
    MOVK  X20, #0x217e, LSL #48
    MOVZ  X21, #0xa5f5, LSL #0
    MOVK  X21, #0x7813, LSL #16
    MOVK  X21, #0x5a9, LSL #32
    MOVK  X21, #0xa130, LSL #48
    MOVZ  X22, #0xd72c, LSL #0
    MOVK  X22, #0x6394, LSL #16
    MOVK  X22, #0xecc2, LSL #32
    MOVK  X22, #0x5d97, LSL #48
    MOVZ  X23, #0x4f54, LSL #0
    MOVK  X23, #0x5b72, LSL #16
    MOVK  X23, #0xf18f, LSL #32
    MOVK  X23, #0x552f, LSL #48
    MOVZ  X24, #0x2c28, LSL #0
    MOVK  X24, #0xfd19, LSL #16
    MOVK  X24, #0xb845, LSL #32
    MOVK  X24, #0xa18c, LSL #48
    MOVZ  X25, #0xfbba, LSL #0
    MOVK  X25, #0x35cf, LSL #16
    MOVK  X25, #0x2da0, LSL #32
    MOVK  X25, #0x282f, LSL #48
    MOVZ  X26, #0x462b, LSL #0
    MOVK  X26, #0x287, LSL #16
    MOVK  X26, #0x6aef, LSL #32
    MOVK  X26, #0xe22d, LSL #48
    MOVZ  X27, #0x2a87, LSL #0
    MOVK  X27, #0xac07, LSL #16
    MOVK  X27, #0x16e0, LSL #32
    MOVK  X27, #0x5a22, LSL #48
    MOVZ  X28, #0xe577, LSL #0
    MOVK  X28, #0xcec4, LSL #16
    MOVK  X28, #0xd066, LSL #32
    MOVK  X28, #0xa9b8, LSL #48
    MOVZ  X29, #0xb76, LSL #0
    MOVK  X29, #0xdf30, LSL #16
    MOVK  X29, #0xf7d8, LSL #32
    MOVK  X29, #0xe248, LSL #48
    MOVZ  X20, #0xa, LSL #0
TaishanIntMduP02_label_167:
    ORR  X16, X29, #0x3fc0000000000
    UMULH  X10, X28, X13
    BIC  X8, X17, X21, ASR #24
    CRC32CB  W23, W8, W20
    ORR  X13, X23, X3, LSR #39
    ADD  X16, X17, #0x459, LSL #12
    CRC32B  W25, W24, W23
    MOVN  W10, #0x28d, LSL #16
    ADD  W22, W25, W15, SXTH #4
    SUBS  W16, W5, #0x9f3, LSL #12
    ANDS  X13, X28, #0xfff0000000007fff
    ADC  X21, X23, X16
    LSLV  X19, X5, X6
    ASRV  X7, X19, X26
    SUBS  W15, W9, #0xe40
    CSINC  X8, X2, X10, VS
    ADDS  W9, W9, W5, LSR #15
    CSEL  X23, X26, X29, GE
    CRC32CX  W28, W24, X29
    UMADDL  X10, W23, W15, X16
    SUBS  W27, W8, W13, UXTH #4
    MOVZ  X15, #0x8d70, LSL #16
    ASRV  X18, X26, X10
    MOVK  X24, #0x507b, LSL #32
    AND  X17, X6, X16, LSR #41
    ADCS  X27, X28, X7
    ADDS  W27, W9, W2, ASR #11
    ADD  W3, W23, W9, LSL #3
    ADCS  W6, W2, W17
    SBFM  X9, X19, #0x7, #0x7
    CSNEG  W6, W7, W3, CS
    ANDS  X28, X13, X24, LSL #23
    CSEL  W3, W12, W9, PL
    SUB  W5, W8, W3, LSR #19
    EOR  X9, X2, #0xf8000007f8000007
    ADD  W3, W18, W17, LSR #10
    CLS  W18, W8
    SUBS  X16, X15, X14, LSL #60
    CRC32B  W17, W27, W24
    CLS  X29, X26
    CSINC  X9, X27, X20, EQ
    ORR  W5, W22, #0xfe00fe00
    CSNEG  X17, X6, X11, LS
    SUB  X10, X16, #0x4bc
    SUBS  W5, W20, #0x9b7, LSL #12
    AND  W2, W13, #0xfc7ffc7f
    UBFM  W13, W3, #0xb, #0x8
    ADDS  X6, X6, #0x388, LSL #12
    CRC32H  W6, W16, W21
    BIC  X11, X22, X18, LSL #6
    MADD  W11, W13, W29, W26
    MOVZ  X28, #0x5c9e, LSL #16
    MADD  X21, X16, X5, X26
    MOVK  W12, #0xc11a, LSL #0
    EXTR  X28, X25, X2, #0x21
    CSNEG  W25, W13, W20, LT
    ADDS  X28, X7, X27, LSR #44
    CLZ  W29, W10
    ADD  W6, W17, #0xc20
    CLS  W2, W8
    SBFM  X19, X27, #0x2d, #0x5
    UMULH  X5, X3, X26
    AND  X9, X12, X12, ROR #1
    EON  W26, W13, W28, LSL #3
    MOVZ  X7, #0xe61, LSL #0
    LSRV  W2, W20, W8
    AND  X12, X12, X18, ASR #27
    EON  X8, X24, X19, ROR #47
    BIC  W7, W20, W23, LSR #30
    BIC  W3, W29, W5, ASR #26
    CLS  V2.4H, V24.4H
    SUBS  W6, W7, W26, LSL #18
    CRC32W  W27, W10, W18
    EOR  W12, W3, W14, ROR #12
    SMULH  X24, X19, X9
    EXTR  W8, W13, W2, #0x1d
    ORR  X11, X29, X16, LSR #55
    SUB  X7, X10, W18, UXTW #4
    CRC32W  W16, W6, W7
    CRC32CH  W3, W12, W2
    BIC  V13.16B, V20.16B, V0.16B
    SBFM  X21, X24, #0x1b, #0x14
    CLS  V24.4H, V9.4H
    ADDS  W3, W20, #0x250
    ORR  V20.16B, V27.16B, V15.16B
    ORR  V30.4H, #0xb1
    BICS  X12, X6, X18, LSL #42
    LSRV  W21, W27, W3
    ASRV  W13, W13, W15
    LSRV  X8, X22, X13
    SUB  X10, X16, X26, SXTX #4
    AND  X11, X5, #0x18001800180018
    BICS  X29, X12, X3, LSL #3
    ADDS  X21, X26, #0x3da, LSL #12
    EON  W2, W15, W19, LSR #12
    SUB  W18, W13, W2, UXTH #1
    SUB  X24, X13, X10, LSR #36
    MOVN  X13, #0x5900, LSL #48
    ANDS  X26, X12, #0x7ffffc0
    UMULH  X27, X14, X24
    ADDS  W22, W3, #0xe0f
    CRC32H  W9, W9, W19
    MOVK  X11, #0xf774, LSL #48
    SUBS  W3, W25, #0x319, LSL #12
    EXTR  W28, W26, W2, #0x19
    AND  X16, X8, #0xffc0000000000fff
    ADC  X13, X9, X28
    SUBS  W9, W21, #0xd38, LSL #12
    ANDS  X21, X28, X13, ASR #0
    SUB  X11, X21, #0x7e, LSL #12
    SUB  X8, X15, X21, SXTX #1
    CSINV  W22, W5, W25, CC
    ANDS  W3, W9, W7, ASR #10
    ADDS  X15, X19, W12, SXTW #2
    AND  X27, X26, X20, ASR #41
    ADD  W22, W10, W23, SXTW #2
    ADC  X15, X21, X7
    AND  X12, X14, X24, LSL #41
    CLZ  V30.8B, V13.8B
    SUB  X26, X20, X23, ASR #26
    UBFM  W12, W6, #0x1, #0x18
    CSEL  X5, X16, X8, LS
    UMADDL  X27, W26, W11, X5
    SMSUBL  X12, W12, W27, X8
    ANDS  X3, X8, #0xffff000003ffffff
    MOVN  X24, #0xd75a, LSL #16
    ADD  X13, X24, X22, LSR #1
    CLZ  X19, X6
    SUB  W24, W15, #0x548, LSL #12
    ADC  X10, X22, X27
    ORR  X16, X10, X10, ROR #55
    LSLV  W16, W18, W27
    UBFM  W22, W14, #0x17, #0x1d
    ADCS  W12, W13, W25
    AND  W27, W25, #0xfff00
    ANDS  W8, W26, W3, LSL #18
    CSNEG  W11, W21, W28, EQ
    LSRV  X14, X17, X6
    ORR  X8, X26, X5, LSR #51
    ORN  W18, W8, W27, ROR #14
    ADDS  W15, W24, W10, UXTW #2
    SUBS  X11, X16, X2, LSL #54
    ANDS  W13, W7, W27
    CRC32W  W24, W7, W3
    CRC32CH  W25, W22, W24
    ORR  V22.8H, #0xcf
    MOVN  X11, #0x48db, LSL #16
    SUBS  X28, X28, #0x440
    CRC32W  W23, W21, W27
    ORR  V4.4H, #0xd1, LSL #8
    SUB  X16, X29, #0xf50, LSL #12
    ASRV  W19, W16, W23
    ORR  W15, W26, W15, LSR #23
    ADCS  X27, X27, X19
    EON  X11, X2, X29, LSL #32
    SUB  X23, X6, W26, SXTB #4
    ADD  W3, W14, W14, ASR #19
    EOR  W28, W13, W7, LSL #5
    ADD  W3, W24, #0x42e, LSL #12
    MOVN  W21, #0x4683, LSL #16
    BICS  W19, W12, W20, ASR #30
    CSINV  W14, W29, W12, CC
    ORN  X6, X21, X22, ROR #15
    UMSUBL  X2, W18, W16, X5
    BIC  V17.8B, V16.8B, V28.8B
    ORR  V29.4S, #0x2a, LSL #16
    SBFM  X22, X15, #0x25, #0xf
    CRC32H  W29, W15, W20
    CSEL  W22, W25, W5, GT
    ADDS  X17, X14, #0x270
    ADDS  X24, X15, X26, ASR #52
    CRC32W  W14, W23, W10
    ANDS  W16, W29, #0x1fe00
    SUB  W5, W28, W27, LSL #29
    SUBS  W18, W13, W17, SXTX #4
    ADD  W19, W3, #0x5e0
    ANDS  W26, W25, W22, LSL #24
    ADDS  X13, X15, X23, LSR #2
    ORR  X3, X14, X13, LSR #60
    SMSUBL  X9, W27, W25, X15
    CSINV  X2, X25, X10, EQ
    ADCS  X23, X9, X29
    CSINC  W2, W2, W5, HI
    EON  X10, X29, X13, LSL #2
    CLZ  V1.4S, V10.4S
    BICS  X10, X5, X5, ROR #39
    BICS  W2, W28, W25, LSL #24
    CSINV  W17, W18, W21, EQ
    SMADDL  X27, W23, W9, X24
    SUBS  W13, W19, W24, LSL #18
    CSEL  W5, W25, W9, GE
    CSINC  X2, X16, X25, VC
    BIC  V21.16B, V3.16B, V17.16B
    ADC  X25, X12, X20
    UBFM  X17, X12, #0x3c, #0x1d
    MOVZ  W21, #0x9f40, LSL #0
    BICS  W14, W10, W2, LSL #4
    ADD  X26, X14, X14, LSR #49
    BIC  V18.16B, V24.16B, V18.16B
    CRC32H  W12, W5, W2
    SUBS  X20, X20, #0x1
    B.NE  TaishanIntMduP02_label_167
    MOVZ  X2, #0xdc00, LSL #0
    MOVK  X2, #0x1, LSL #16
    SUB  X20, X2, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X11, #0x169e, LSL #0
    MOVK  X11, #0xe20a, LSL #16
    SUB  X26, X11, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X11, #0x30d3, LSL #0
    MOVK  X11, #0xe8ca, LSL #16
    SUB  X17, X11, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP02_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffc9, LSL #48
    SUB  X15, X28, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X18, #0xfaf4, LSL #0
    MOVK  X18, #0x8d6f, LSL #16
    SUB  X23, X18, X7
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP02_TestFail
    MOVZ  X18, #0xffcd, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X27, X18, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X15, #0x30d3, LSL #0
    MOVK  X15, #0xe8ca, LSL #16
    MOVK  X15, #0x9aca, LSL #32
    MOVK  X15, #0x1, LSL #48
    SUB  X23, X15, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP02_TestFail
    MOVZ  X9, #0xa480, LSL #0
    MOVK  X9, #0x2df0, LSL #16
    SUB  X19, X9, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X3, #0x30d3, LSL #0
    MOVK  X3, #0xe8ca, LSL #16
    SUB  X20, X3, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X22, #0xd045, LSL #0
    MOVK  X22, #0x3a9, LSL #16
    SUB  X7, X22, X12
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X25, #0x1b69, LSL #0
    MOVK  X25, #0xcde0, LSL #16
    SUB  X8, X25, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP02_TestFail
    MOVZ  X15, #0x2480, LSL #0
    MOVK  X15, #0x2de0, LSL #16
    SUB  X29, X15, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X6, #0x2480, LSL #0
    MOVK  X6, #0x2de0, LSL #16
    SUB  X19, X6, X15
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X24, #0xdc00, LSL #0
    MOVK  X24, #0x1, LSL #16
    SUB  X28, X24, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP02_TestFail
    MOVZ  X15, #0xffcd, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X19, X15, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X27, #0x9f40, LSL #0
    SUB  X2, X27, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X28, #0xd045, LSL #0
    MOVK  X28, #0x3a9, LSL #16
    SUB  X16, X28, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X10, #0xdc00, LSL #0
    MOVK  X10, #0x1, LSL #16
    SUB  X15, X10, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X5, #0x1b69, LSL #0
    MOVK  X5, #0xcde0, LSL #16
    SUB  X13, X5, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X27, #0x9f40, LSL #0
    SUB  X29, X27, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X19, #0xd045, LSL #0
    MOVK  X19, #0x3a9, LSL #16
    SUB  X28, X19, X28
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X29
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
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
    MOVZ  X3, #0xa, LSL #0
TaishanIntMduP02_label_195:
    BIC  V27.16B, V3.16B, V11.16B
    SBFM  W19, W3, #0x1d, #0xd
    ANDS  W25, W19, W23, ROR #14
    CRC32B  W19, W26, W24
    ADD  W20, W18, W16, SXTH #0
    MOVZ  X8, #0x2dbc, LSL #32
    UBFM  W13, W16, #0x6, #0x1d
    CSNEG  W12, W26, W18, GE
    SUB  X16, X19, #0x298, LSL #12
    EOR  W20, W9, #0xffe0ffe
    UMADDL  X9, W16, W13, X15
    ADDS  X27, X10, W27, SXTH #2
    ADD  W18, W8, W27, LSL #14
    SUB  W29, W13, W29, LSR #28
    ASRV  X23, X15, X9
    SMSUBL  X13, W14, W25, X6
    ADD  X13, X6, #0x8d0
    EOR  X27, X11, #0x7f807f807f807f8
    UBFM  X18, X10, #0x33, #0xe
    CRC32CX  W19, W29, X7
    CLS  W12, W25
    UMSUBL  X9, W5, W18, X5
    CRC32CH  W10, W18, W28
    ORR  W19, W23, W27, ASR #22
    UBFM  W21, W25, #0x17, #0x16
    ORR  V29.2S, #0xf, LSL #16
    SUB  X14, X27, X25, UXTX #0
    ORR  V18.2S, #0x2
    ADC  X21, X16, X2
    ADDS  X20, X10, X22, UXTX #4
    ORR  V19.16B, V15.16B, V6.16B
    MOVK  X28, #0xd35c, LSL #32
    ORR  V14.2S, #0xa3
    EXTR  W27, W13, W19, #0x0
    ADD  X25, X13, W27, SXTH #0
    CSINV  X16, X18, X19, PL
    LSRV  W16, W12, W12
    EOR  W11, W11, #0x3fe00
    EOR  W25, W22, W11, ASR #15
    ADC  X10, X16, X22
    CRC32H  W13, W28, W14
    SUB  X6, X27, X6, ASR #33
    AND  X28, X12, X20, ASR #19
    UBFM  W28, W18, #0x1a, #0x16
    LSRV  X21, X16, X26
    ADDS  X26, X27, W2, UXTB #2
    CRC32CH  W12, W8, W9
    ADD  X26, X19, #0xeb0
    MOVK  X27, #0x686c, LSL #0
    CSINC  W23, W12, W24, NE
    BICS  X22, X19, X24, ASR #48
    SUB  X14, X21, X22, SXTX #3
    LSRV  X14, X16, X18
    ANDS  W26, W28, W6, LSL #28
    SUB  W25, W13, W22, UXTB #1
    ADCS  X12, X2, X29
    LSRV  X26, X12, X26
    ADDS  W22, W10, W9, UXTB #2
    ANDS  W8, W2, #0xffc0ffc0
    EON  W25, W9, W2, ROR #12
    CSINV  W9, W24, W24, LE
    CRC32CW  W24, W22, W14
    EOR  X16, X23, X10, ROR #27
    SUB  X18, X28, W2, UXTB #2
    SUB  X2, X9, W3, UXTB #2
    ADDS  X26, X3, W11, SXTB #2
    CSNEG  W27, W24, W20, EQ
    MADD  X26, X5, X24, X8
    AND  W6, W3, W15, LSL #21
    UBFM  W16, W22, #0xd, #0x10
    MOVZ  X29, #0xe5aa, LSL #48
    LSLV  W16, W8, W28
    ORR  W10, W5, #0xfe00fe0
    CRC32H  W2, W13, W5
    LSLV  X2, X6, X28
    CRC32CW  W27, W18, W3
    ORN  W18, W10, W18, LSL #17
    ORR  X23, X8, #0xffffffc00000ffff
    SBFM  W26, W5, #0x16, #0x1d
    CLS  V14.16B, V25.16B
    SMADDL  X10, W14, W20, X27
    CRC32CH  W22, W9, W13
    SBFM  W25, W2, #0x1c, #0x7
    MOVZ  W19, #0x8eba, LSL #16
    UMULH  X2, X5, X13
    SUB  W15, W2, #0x0
    UBFM  W28, W14, #0xc, #0x7
    ORR  V2.4S, #0xbb, LSL #24
    SBFM  X5, X25, #0x8, #0x1e
    SUB  X6, X9, X2, LSR #17
    ADDS  W2, W5, W16, UXTH #0
    BIC  V20.16B, V24.16B, V23.16B
    SUBS  W15, W23, W5, SXTW #3
    SUB  W20, W14, W24, LSL #10
    SUB  X27, X2, W22, UXTB #1
    ASRV  X12, X11, X8
    MADD  X9, X23, X9, X21
    LSRV  X7, X14, X17
    EXTR  X15, X25, X14, #0x25
    AND  X18, X15, X25, ASR #55
    CRC32CW  W26, W3, W5
    CLS  W19, W25
    ADD  X11, X21, #0x4e7, LSL #12
    MADD  X24, X19, X10, X26
    ANDS  X12, X15, X16, ASR #26
    BIC  W23, W3, W28, ROR #7
    LSLV  W11, W8, W11
    CSNEG  W13, W19, W2, CC
    CSINV  W23, W17, W18, HI
    CSINV  X28, X11, X12, NE
    CRC32B  W14, W22, W28
    ORN  W13, W5, W14, ASR #18
    MOVZ  X11, #0x5b2b, LSL #48
    SUB  W24, W23, W8, ASR #20
    SUBS  W28, W21, W13, ASR #1
    CRC32H  W6, W19, W17
    LSLV  W6, W24, W24
    CSINV  W2, W6, W13, CS
    LSLV  X6, X10, X28
    CLZ  W21, W20
    BIC  V6.8B, V6.8B, V5.8B
    MOVZ  X8, #0xddd5, LSL #16
    CRC32B  W2, W23, W23
    ADDS  X8, X2, W10, UXTW #4
    CSEL  W21, W28, W9, CS
    CSNEG  W27, W25, W6, LS
    CSNEG  W25, W18, W11, NE
    SUB  W16, W21, W21, UXTX #0
    ADDS  X15, X8, X19, LSL #46
    SUBS  W15, W11, #0x256
    ORR  V20.4S, #0x70, LSL #16
    SUB  W29, W19, #0x2eb
    AND  X15, X24, X5, LSR #5
    SUB  W7, W16, W26, SXTH #1
    LSLV  X18, X24, X24
    ANDS  W20, W18, #0x4040404
    ANDS  X20, X15, X14, LSL #15
    CLZ  X13, X26
    ADD  W10, W19, W7, UXTB #0
    ORR  V6.16B, V10.16B, V0.16B
    MADD  X20, X16, X10, X20
    ADD  X5, X24, X16, UXTX #2
    MOVZ  X18, #0x2dbb, LSL #48
    SUB  W8, W22, W27, LSR #5
    EXTR  W26, W23, W27, #0x9
    SBFM  X5, X21, #0x1a, #0x1a
    UMULH  X9, X19, X23
    EXTR  W8, W22, W19, #0x0
    ORR  X25, X8, #0xf000f000f000f0
    CLZ  V17.8H, V8.8H
    SUBS  X7, X14, #0xa8c
    CLZ  V30.2S, V4.2S
    ORN  W20, W15, W27, LSR #17
    CRC32H  W11, W5, W15
    ADD  X27, X17, #0x3b4
    CSNEG  W29, W27, W23, CC
    MOVZ  X21, #0x17fb, LSL #32
    SBFM  W29, W27, #0x1a, #0xa
    ASRV  X5, X5, X17
    EXTR  W26, W5, W13, #0xc
    EOR  X7, X9, #0xff83ffffff83ffff
    MOVZ  X17, #0xa389, LSL #48
    ANDS  W28, W21, #0xfc00ffff
    CRC32B  W27, W26, W25
    CLZ  V12.2S, V7.2S
    ADDS  X16, X5, X28, LSR #21
    ANDS  W9, W14, W9, LSL #29
    LSLV  X29, X25, X22
    UBFM  W11, W17, #0x14, #0x16
    ADD  X23, X10, #0xe69
    CRC32B  W23, W8, W27
    AND  W10, W10, W13, ROR #16
    CLZ  V4.16B, V20.16B
    CSINV  X20, X23, X26, CC
    ADDS  X22, X7, X14, LSR #49
    ORR  V14.2S, #0xa, LSL #8
    CSINC  W16, W20, W16, MI
    ADDS  W19, W6, #0x480
    AND  W26, W10, W18, ROR #26
    CSINC  W6, W29, W8, PL
    ORR  W12, W2, #0x7f807f8
    SUBS  X8, X29, X25, LSR #3
    AND  W16, W7, W27, ROR #26
    SBFM  X7, X13, #0x11, #0x3
    SMULH  X19, X22, X21
    ORR  V22.16B, V5.16B, V25.16B
    UMADDL  X26, W13, W21, X22
    SUBS  W10, W15, #0x6be, LSL #12
    SUB  W11, W13, #0x0
    UMADDL  X16, W5, W16, X15
    ADD  W22, W8, W6, LSR #19
    CLS  X29, X3
    ORR  X29, X26, X17, ROR #60
    CLZ  X18, X16
    UMADDL  X9, W18, W29, X6
    CRC32CB  W10, W9, W29
    LSLV  W2, W26, W29
    MOVK  X22, #0x4e8b, LSL #32
    EXTR  X26, X22, X21, #0x5
    CLS  W12, W23
    SUBS  X3, X3, #0x1
    B.NE  TaishanIntMduP02_label_195
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x8000, LSL #16
    SUB  X29, X25, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP02_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X12, X13, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP02_TestFail
    MOVZ  X5, #0x20, LSL #0
    SUB  X26, X5, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X11, #0xffe1, LSL #0
    MOVK  X11, #0xdfe1, LSL #16
    MOVK  X11, #0x1, LSL #32
    SUB  X6, X11, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X11, #0x1f, LSL #0
    MOVK  X11, #0xff84, LSL #16
    SUB  X26, X11, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X29, #0x2c1a, LSL #0
    MOVK  X29, #0xe3cf, LSL #16
    SUB  X15, X29, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x1f, LSL #0
    MOVK  X26, #0xff84, LSL #16
    SUB  X29, X26, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X12
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP02_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X5, X17, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X16
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP02_TestFail
    MOVZ  X9, #0x1, LSL #0
    SUB  X28, X9, X18
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x17fb, LSL #32
    SUB  X18, X16, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X18, #0xffe1, LSL #0
    MOVK  X18, #0xdfe1, LSL #16
    MOVK  X18, #0x4e8b, LSL #32
    SUB  X24, X18, X22
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x8000, LSL #16
    SUB  X11, X26, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x8000, LSL #16
    SUB  X10, X5, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X24, X23, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP02_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X29
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
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
    MOVZ  X18, #0xa, LSL #0
TaishanIntMduP02_label_223:
    ORR  X23, X3, X13, LSL #48
    UMSUBL  X28, W19, W23, X29
    SUBS  W3, W25, W5, LSL #17
    CRC32X  W29, W29, X21
    ADD  X28, X25, W9, SXTW #1
    BIC  X19, X16, X13, ROR #1
    ADD  X26, X24, W24, SXTH #2
    SUB  W26, W28, #0x663
    ADDS  X19, X24, X26, ASR #12
    ADCS  X26, X29, X23
    ADDS  X28, X18, X22, LSL #52
    ADDS  W6, W12, W22, LSR #8
    ADD  W21, W21, #0xb90
    AND  X28, X8, #0x3fffffe03fffffe
    CSEL  X22, X18, X2, LS
    ANDS  X15, X15, #0xcfcfcfcfcfcfcfcf
    ANDS  W28, W27, #0xfffffc01
    CRC32W  W25, W20, W10
    CSINV  X26, X20, X21, NE
    ADD  X25, X3, W10, SXTB #0
    ADDS  W3, W29, W29, ASR #12
    UBFM  X20, X9, #0x1d, #0x21
    ADD  W5, W17, #0x536, LSL #12
    EOR  X7, X21, X26, LSR #25
    ORR  W11, W3, #0xfbfbfbfb
    BIC  X24, X26, X19, LSR #36
    ADC  W24, W20, W9
    CRC32W  W15, W19, W7
    ADDS  X25, X8, #0x400
    CSINC  W9, W29, W16, MI
    SUBS  X7, X17, X5, LSL #48
    ADDS  W10, W9, W25, LSL #9
    ADC  X7, X9, X10
    BIC  W22, W17, W27, ASR #5
    SMSUBL  X7, W23, W22, X3
    CSNEG  X23, X6, X2, LT
    ADDS  W17, W6, W24, SXTW #2
    CLZ  W3, W3
    ADD  X17, X3, X25, LSR #40
    ANDS  W17, W29, W17, LSL #3
    BICS  X15, X16, X17, LSL #3
    ADD  X22, X23, X8, LSL #4
    ADDS  X28, X27, W17, UXTH #3
    ORR  V12.4S, #0x8, LSL #16
    EOR  X23, X19, #0xffffffffff000001
    CRC32CX  W15, W2, X11
    SUB  W17, W28, W28, SXTW #3
    ASRV  X29, X14, X26
    CLZ  V14.4H, V3.4H
    UMULH  X19, X18, X21
    ORN  W10, W9, W18, ROR #7
    CRC32W  W8, W27, W14
    ANDS  X17, X6, #0xffffe000007fffff
    SUB  W11, W6, #0xc16, LSL #12
    ADDS  W5, W7, W13, SXTH #3
    ADD  X26, X13, X27, LSR #25
    ADD  X3, X2, X20, LSR #42
    ADDS  W28, W5, #0x6da, LSL #12
    UMULH  X11, X2, X11
    CSINC  X27, X12, X24, MI
    EOR  X3, X9, X10, ROR #12
    ORR  V3.4S, #0x93, LSL #16
    CRC32CX  W17, W17, X28
    EOR  X11, X19, #0xfffffff80000000f
    ADD  W28, W14, W3, SXTB #1
    ADD  W26, W9, W20, ASR #15
    SUBS  W8, W21, W5, UXTB #3
    CSINV  W13, W25, W14, GT
    UMADDL  X12, W3, W11, X18
    AND  W27, W22, #0x3ffe00
    ADCS  X12, X27, X15
    MADD  X13, X18, X17, X14
    CSEL  X2, X26, X8, NE
    LSRV  W10, W25, W27
    ADD  W19, W19, W10, LSL #27
    EON  W13, W14, W18, ASR #29
    ORR  W17, W9, W6, LSL #23
    EOR  W12, W12, #0xfffffc3f
    MADD  X20, X26, X8, X19
    SUB  X12, X2, X25, LSR #2
    BICS  W17, W28, W12, LSR #19
    ORR  V31.2S, #0xed, LSL #8
    CRC32CB  W27, W12, W12
    ORR  V30.4H, #0x1c, LSL #8
    CSEL  X14, X12, X11, NE
    CSINC  X26, X3, X7, LE
    ORR  W3, W6, #0xf8f8f8f8
    BIC  X23, X28, X12, ASR #57
    SUBS  W15, W16, #0x656, LSL #12
    UMSUBL  X25, W15, W18, X2
    ADD  W3, W27, W29, LSR #10
    CSINC  W6, W13, W6, EQ
    ADCS  X3, X18, X25
    LSLV  W26, W2, W26
    SUBS  W3, W26, W14, UXTX #3
    ASRV  X6, X21, X8
    BICS  X28, X11, X14, ASR #49
    LSRV  X22, X29, X20
    ORR  X11, X29, #0xffffffffffffc07f
    SMADDL  X26, W10, W11, X22
    ANDS  W22, W6, W26, LSR #25
    UMSUBL  X28, W8, W18, X29
    ADDS  W19, W23, #0x427, LSL #12
    CSINV  W13, W27, W2, LT
    ORR  V24.8H, #0xde, LSL #8
    ADDS  X16, X10, X28, ASR #23
    ADCS  X26, X25, X10
    SUBS  W22, W22, W20, ASR #17
    EXTR  X15, X6, X2, #0xe
    AND  X11, X20, #0xffc0ffc0ffc0ffc
    ASRV  X29, X3, X21
    BICS  W23, W5, W16, LSR #2
    SUB  W8, W27, #0xd85, LSL #12
    ASRV  X28, X8, X12
    EOR  W10, W25, #0xf800007f
    CSNEG  W9, W7, W27, HI
    EOR  W29, W3, W5, LSR #3
    ADD  X21, X18, X7, ASR #62
    UMADDL  X11, W9, W23, X5
    ADD  X16, X11, X20, LSR #12
    ADD  X10, X25, X22, UXTX #1
    EXTR  W29, W26, W10, #0x1f
    EOR  W13, W29, #0x7ffffc00
    UMSUBL  X28, W12, W10, X11
    SUB  W12, W26, W24, UXTX #3
    MOVZ  X10, #0xdfa3, LSL #0
    UMSUBL  X5, W9, W3, X9
    ADD  W24, W6, #0x7f2
    ASRV  W19, W18, W23
    CSNEG  W19, W20, W16, HI
    SUBS  X6, X6, X7, ASR #29
    SUBS  X25, X9, W3, UXTW #3
    ORR  V19.4S, #0x2c, LSL #16
    CSINV  X17, X28, X9, GE
    MOVK  X8, #0x71d1, LSL #48
    AND  X22, X24, #0x3fffe00000
    AND  W21, W23, W26, LSL #23
    ORR  V24.2S, #0x89, LSL #16
    ADD  X23, X29, #0xde0
    CSEL  W6, W25, W28, GT
    SUB  W13, W11, #0xef1
    UBFM  X29, X18, #0x8, #0x1
    CSNEG  W23, W8, W7, CC
    ADCS  W24, W8, W27
    SUBS  W10, W9, #0xa95, LSL #12
    CLZ  V25.16B, V1.16B
    ORR  W17, W26, W5, LSL #18
    CRC32CH  W11, W6, W18
    CLZ  W10, W18
    SUBS  W8, W9, W8, LSL #8
    ADDS  W29, W19, W17, LSL #8
    SUBS  X8, X23, #0x3c3, LSL #12
    ADCS  X22, X22, X21
    ADD  W13, W13, W21, SXTW #3
    BICS  X13, X26, X20, ROR #34
    SMADDL  X20, W7, W19, X5
    BIC  X17, X27, X5, LSR #25
    EXTR  X9, X18, X21, #0x3d
    CRC32CX  W27, W13, X5
    EOR  W13, W8, W3, ROR #2
    ADDS  X22, X11, X5, ASR #34
    SUB  W29, W12, #0x183
    SMADDL  X16, W26, W25, X27
    ADDS  W25, W10, #0xf2d
    SUB  W22, W3, W8, ASR #13
    EOR  X14, X8, X20, ASR #20
    MOVN  W14, #0xc919, LSL #0
    SMADDL  X21, W6, W13, X8
    ADDS  W3, W11, #0x730
    EON  W11, W7, W16, ROR #28
    ADC  X13, X20, X26
    ADC  X14, X7, X28
    MADD  X8, X19, X7, X10
    BIC  V6.8B, V1.8B, V16.8B
    CSEL  W9, W5, W15, LE
    ADD  W21, W23, W22, LSR #14
    SUBS  X17, X11, W13, UXTH #2
    CRC32X  W14, W21, X23
    SUBS  X11, X3, #0x48c
    SUB  X3, X18, #0x791
    CLS  V11.2S, V16.2S
    ADCS  X25, X18, X10
    CSINC  W11, W14, W7, GE
    MOVK  X11, #0x83fd, LSL #16
    ORN  W25, W19, W11, LSR #21
    ORR  V12.8B, V14.8B, V21.8B
    LSRV  W20, W3, W21
    ADDS  W12, W21, W14, LSR #20
    SUBS  X25, X25, X23, LSL #13
    BIC  W3, W18, W19, LSL #28
    MOVN  W20, #0xa2fa, LSL #16
    CLS  V18.4S, V3.4S
    ORR  V5.8B, V14.8B, V19.8B
    BIC  W29, W26, W28, ROR #11
    ORR  V1.8H, #0x9c
    ANDS  W15, W12, W13, LSR #27
    ANDS  X11, X12, #0x4444444444444444
    SUB  X28, X21, #0x117, LSL #12
    MOVN  W20, #0x8dde, LSL #0
    CRC32X  W6, W19, X18
    SUBS  X18, X18, #0x1
    B.NE  TaishanIntMduP02_label_223
    MOVZ  X22, #0xc851, LSL #0
    MOVK  X22, #0xbe85, LSL #16
    SUB  X18, X22, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X10, #0x1, LSL #0
    SUB  X14, X10, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X29, #0x82c, LSL #0
    MOVK  X29, #0x4765, LSL #16
    MOVK  X29, #0xac0c, LSL #32
    MOVK  X29, #0x57a2, LSL #48
    SUB  X15, X29, X5
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X20, #0xfef0, LSL #0
    MOVK  X20, #0xcb0e, LSL #16
    SUB  X17, X20, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP02_TestFail
    MOVZ  X26, #0xea64, LSL #0
    MOVK  X26, #0x1b4f, LSL #16
    SUB  X18, X26, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X9, #0xbab, LSL #0
    MOVK  X9, #0xd0af, LSL #16
    MOVK  X9, #0x6de, LSL #32
    MOVK  X9, #0x1c, LSL #48
    SUB  X12, X9, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP02_TestFail
    MOVZ  X2, #0xbab, LSL #0
    MOVK  X2, #0xd0af, LSL #16
    MOVK  X2, #0x6de, LSL #32
    MOVK  X2, #0x1c, LSL #48
    SUB  X26, X2, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X21, #0x1, LSL #0
    SUB  X19, X21, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X24, #0x4004, LSL #0
    SUB  X20, X24, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X14, X28, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X23, #0xc372, LSL #0
    MOVK  X23, #0xadfc, LSL #16
    MOVK  X23, #0xb2eb, LSL #32
    MOVK  X23, #0x57be, LSL #48
    SUB  X19, X23, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x56d2, LSL #0
    MOVK  X20, #0xdedc, LSL #16
    MOVK  X20, #0x4547, LSL #32
    MOVK  X20, #0x1df0, LSL #48
    SUB  X17, X20, X16
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X20, X21, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X20, X11, X20
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
    MOVZ  X13, #0xc372, LSL #0
    MOVK  X13, #0xadfc, LSL #16
    MOVK  X13, #0xb2eb, LSL #32
    MOVK  X13, #0x57be, LSL #48
    SUB  X26, X13, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X12, X9, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP02_TestFail
    MOVZ  X14, #0x7bfb, LSL #0
    MOVK  X14, #0xe561, LSL #16
    SUB  X6, X14, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X2, X29, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X29
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X2, #0xfda, LSL #0
    MOVK  X2, #0x2ffa, LSL #16
    MOVK  X2, #0xce1f, LSL #32
    MOVK  X2, #0xe87c, LSL #48
    MOVZ  X3, #0x4e06, LSL #0
    MOVK  X3, #0xea92, LSL #16
    MOVK  X3, #0x4b95, LSL #32
    MOVK  X3, #0xea2b, LSL #48
    MOVZ  X5, #0xbf99, LSL #0
    MOVK  X5, #0xb9dd, LSL #16
    MOVK  X5, #0x5328, LSL #32
    MOVK  X5, #0x549, LSL #48
    MOVZ  X6, #0x560f, LSL #0
    MOVK  X6, #0x532c, LSL #16
    MOVK  X6, #0x61f3, LSL #32
    MOVK  X6, #0xef41, LSL #48
    MOVZ  X7, #0xd77f, LSL #0
    MOVK  X7, #0x2fc4, LSL #16
    MOVK  X7, #0xeb35, LSL #32
    MOVK  X7, #0x42f6, LSL #48
    MOVZ  X8, #0x55c0, LSL #0
    MOVK  X8, #0x16ea, LSL #16
    MOVK  X8, #0x76fc, LSL #32
    MOVK  X8, #0x973a, LSL #48
    MOVZ  X9, #0x42a6, LSL #0
    MOVK  X9, #0xc20e, LSL #16
    MOVK  X9, #0xd27b, LSL #32
    MOVK  X9, #0xa779, LSL #48
    MOVZ  X10, #0xab0f, LSL #0
    MOVK  X10, #0x6333, LSL #16
    MOVK  X10, #0x7c6d, LSL #32
    MOVK  X10, #0x482, LSL #48
    MOVZ  X11, #0x8b88, LSL #0
    MOVK  X11, #0xc45f, LSL #16
    MOVK  X11, #0x3886, LSL #32
    MOVK  X11, #0xf383, LSL #48
    MOVZ  X12, #0x4822, LSL #0
    MOVK  X12, #0xec17, LSL #16
    MOVK  X12, #0x9f73, LSL #32
    MOVK  X12, #0x63eb, LSL #48
    MOVZ  X13, #0xb124, LSL #0
    MOVK  X13, #0xfa9e, LSL #16
    MOVK  X13, #0xbf29, LSL #32
    MOVK  X13, #0xe945, LSL #48
    MOVZ  X14, #0xdbdb, LSL #0
    MOVK  X14, #0xc4df, LSL #16
    MOVK  X14, #0xf60a, LSL #32
    MOVK  X14, #0xe692, LSL #48
    MOVZ  X15, #0x9382, LSL #0
    MOVK  X15, #0x6b28, LSL #16
    MOVK  X15, #0x5b57, LSL #32
    MOVK  X15, #0x47c0, LSL #48
    MOVZ  X16, #0xae72, LSL #0
    MOVK  X16, #0xfffe, LSL #16
    MOVK  X16, #0x4f0c, LSL #32
    MOVK  X16, #0x9c37, LSL #48
    MOVZ  X17, #0xa3c8, LSL #0
    MOVK  X17, #0xeafd, LSL #16
    MOVK  X17, #0xfd1d, LSL #32
    MOVK  X17, #0x2d84, LSL #48
    MOVZ  X18, #0x4ca3, LSL #0
    MOVK  X18, #0x909, LSL #16
    MOVK  X18, #0x2e50, LSL #32
    MOVK  X18, #0xea1b, LSL #48
    MOVZ  X19, #0xf021, LSL #0
    MOVK  X19, #0x1711, LSL #16
    MOVK  X19, #0xe227, LSL #32
    MOVK  X19, #0xa94, LSL #48
    MOVZ  X20, #0x3db, LSL #0
    MOVK  X20, #0x5d59, LSL #16
    MOVK  X20, #0xfbf0, LSL #32
    MOVK  X20, #0x1050, LSL #48
    MOVZ  X21, #0x6ee1, LSL #0
    MOVK  X21, #0xf809, LSL #16
    MOVK  X21, #0x234f, LSL #32
    MOVK  X21, #0xa6f, LSL #48
    MOVZ  X22, #0xe445, LSL #0
    MOVK  X22, #0x2039, LSL #16
    MOVK  X22, #0x1139, LSL #32
    MOVK  X22, #0x57be, LSL #48
    MOVZ  X23, #0xf8dc, LSL #0
    MOVK  X23, #0x8aab, LSL #16
    MOVK  X23, #0x103, LSL #32
    MOVK  X23, #0x3056, LSL #48
    MOVZ  X24, #0xc82d, LSL #0
    MOVK  X24, #0x388a, LSL #16
    MOVK  X24, #0x72b1, LSL #32
    MOVK  X24, #0x2b31, LSL #48
    MOVZ  X25, #0x79fd, LSL #0
    MOVK  X25, #0x9af4, LSL #16
    MOVK  X25, #0xea87, LSL #32
    MOVK  X25, #0x7e9, LSL #48
    MOVZ  X26, #0x7526, LSL #0
    MOVK  X26, #0xba8a, LSL #16
    MOVK  X26, #0xd99e, LSL #32
    MOVK  X26, #0x9454, LSL #48
    MOVZ  X27, #0x3237, LSL #0
    MOVK  X27, #0x5bff, LSL #16
    MOVK  X27, #0xfcc6, LSL #32
    MOVK  X27, #0x6e0, LSL #48
    MOVZ  X28, #0x9bcc, LSL #0
    MOVK  X28, #0xe738, LSL #16
    MOVK  X28, #0x62e6, LSL #32
    MOVK  X28, #0x6222, LSL #48
    MOVZ  X29, #0x4ca3, LSL #0
    MOVK  X29, #0x13e0, LSL #16
    MOVK  X29, #0x540, LSL #32
    MOVK  X29, #0x9b5e, LSL #48
    MOVZ  X15, #0xa, LSL #0
TaishanIntMduP02_label_250:
    ORR  V3.2S, #0x66, LSL #8
    SUBS  W5, W15, W25, LSR #10
    SUB  X26, X3, W29, UXTB #4
    ORR  W3, W10, W5, LSR #31
    ADD  X9, X9, X28, UXTX #3
    ADDS  W7, W3, W27, SXTX #1
    SUB  X29, X7, #0x1d1, LSL #12
    MOVK  X29, #0x4021, LSL #16
    ADCS  W9, W10, W28
    AND  X3, X14, #0x3fc000003fc000
    AND  X26, X7, X11, ROR #25
    ADD  W5, W7, #0x14b, LSL #12
    CLZ  X25, X20
    LSRV  X8, X14, X16
    BICS  W28, W16, W19, LSR #2
    UBFM  W29, W26, #0x10, #0xa
    SUB  X22, X25, X19, LSR #2
    ADCS  X26, X29, X27
    MOVN  X23, #0x1017, LSL #16
    BIC  W19, W11, W23, ASR #6
    MOVZ  X2, #0x8619, LSL #48
    LSRV  X22, X6, X15
    SUB  X21, X26, #0xd0c
    SUBS  W22, W19, #0x95e, LSL #12
    CSNEG  X11, X28, X8, LS
    CRC32CH  W2, W18, W21
    CLS  V3.2S, V9.2S
    SUB  X10, X16, X17, LSR #13
    ADDS  W26, W7, W17, UXTW #3
    ORR  V1.4S, #0x39, LSL #8
    ORN  X12, X20, X12, LSR #33
    MOVK  X21, #0x5671, LSL #32
    LSRV  X26, X26, X11
    EON  X7, X20, X21, LSL #53
    LSRV  X20, X26, X8
    ADDS  X20, X27, W13, UXTH #3
    MOVZ  W20, #0x54b6, LSL #0
    SUBS  X19, X29, #0xd70, LSL #12
    BICS  W11, W25, W16, LSR #24
    SUBS  X20, X26, #0xe83, LSL #12
    ADD  X25, X20, X29, LSR #52
    EOR  X17, X10, #0xe00fffffe00fffff
    CRC32CB  W13, W6, W26
    BIC  X2, X22, X19, LSR #43
    CLS  V0.16B, V9.16B
    CSINV  X25, X18, X8, VS
    MOVZ  X18, #0x634d, LSL #48
    CRC32H  W20, W24, W9
    CLZ  X12, X12
    LSRV  X10, X14, X15
    CSINV  W7, W19, W6, MI
    CRC32H  W27, W26, W6
    ORR  V8.4H, #0x96
    SUBS  W29, W6, W17, ASR #23
    ADDS  X3, X15, #0x3e5
    EXTR  X20, X16, X18, #0x25
    SUBS  X16, X25, #0xaea
    SUBS  X14, X6, #0x517
    BIC  V1.16B, V19.16B, V15.16B
    CSNEG  W8, W5, W22, AL
    ASRV  X14, X7, X20
    AND  X3, X15, X16, ROR #19
    UBFM  X9, X28, #0x35, #0x3d
    AND  W11, W24, #0x8
    SMADDL  X21, W11, W25, X23
    ADD  W24, W12, #0xc82, LSL #12
    LSRV  X25, X24, X16
    AND  W26, W5, W24, LSR #18
    MOVN  W29, #0x884c, LSL #0
    ASRV  X2, X28, X12
    ORR  X25, X29, X5, ROR #7
    UBFM  W26, W9, #0xc, #0x17
    MADD  X25, X15, X16, X18
    CLZ  W17, W14
    CRC32W  W19, W27, W26
    ORR  W17, W29, #0xfffe
    MOVN  W18, #0x4ce2, LSL #0
    CLZ  W12, W11
    CSEL  X19, X3, X17, GT
    EOR  X3, X7, #0xf000000000000003
    ADC  X11, X9, X6
    LSRV  W3, W12, W12
    SMADDL  X7, W28, W12, X9
    ADDS  X19, X6, W10, UXTW #1
    ADCS  X28, X2, X6
    UMSUBL  X8, W6, W11, X10
    SUB  X24, X8, X28, LSR #39
    MOVZ  W26, #0xae90, LSL #16
    SUBS  W16, W14, W13, LSL #27
    ORR  W27, W26, #0xc000c000
    CLZ  X28, X8
    ADC  X22, X27, X24
    EXTR  X23, X23, X28, #0x1f
    ADDS  X23, X29, W21, UXTW #2
    ANDS  X6, X14, #0xfc00000000007fff
    EXTR  W8, W10, W15, #0x18
    LSLV  X10, X23, X9
    CLS  X6, X19
    SMULH  X12, X7, X5
    SUBS  W25, W5, #0xe45
    CRC32CH  W13, W18, W3
    EON  X19, X2, X14, LSR #49
    ADD  X17, X14, X17, SXTX #1
    ADD  W13, W17, W21, LSR #3
    ADD  X10, X28, W28, SXTB #4
    LSLV  W5, W16, W15
    CSINV  W3, W8, W14, NE
    ORR  X13, X21, X3, LSL #23
    ASRV  X9, X28, X18
    MADD  X3, X27, X10, X9
    SUBS  W16, W18, W27, LSR #18
    CLZ  W17, W18
    ORR  W26, W28, #0x1c001c
    ANDS  W24, W11, #0x8080808
    CSEL  W10, W17, W20, VS
    ORR  V10.2S, #0xfc
    ANDS  X2, X19, #0xffffffffffffc003
    ADCS  X10, X3, X8
    ADD  X11, X16, W21, SXTH #0
    LSRV  W11, W5, W23
    CSNEG  X20, X3, X15, VC
    SUB  W20, W11, #0xcc2, LSL #12
    MADD  W21, W2, W13, W8
    CRC32CB  W25, W8, W11
    SUBS  W2, W6, W8, UXTH #1
    UBFM  X19, X5, #0x16, #0x26
    SMULH  X20, X9, X26
    CLS  W20, W3
    ADDS  W5, W5, #0xd9d, LSL #12
    SUBS  X17, X29, #0x4b9, LSL #12
    ADC  X12, X12, X17
    ADD  W10, W29, W26, LSL #8
    LSRV  W21, W19, W16
    ADC  X2, X28, X9
    AND  X17, X6, X8, ROR #20
    ORR  V25.2S, #0xc8, LSL #16
    ORN  W21, W13, W20, ASR #17
    BIC  V0.8B, V21.8B, V18.8B
    ADD  X9, X21, X11, SXTX #3
    EOR  W2, W16, #0xff80000f
    ANDS  X8, X11, #0xffc001ffffc001ff
    MOVN  W29, #0xd558, LSL #0
    ADD  X13, X11, X11, UXTX #4
    SUBS  W9, W6, #0x0
    ADDS  X10, X5, #0x274
    MOVN  X23, #0xad50, LSL #32
    CLS  V28.4S, V28.4S
    ADDS  X26, X25, X13, ASR #49
    ADDS  W20, W9, W27, LSL #13
    LSRV  X13, X12, X13
    CRC32B  W20, W10, W21
    AND  X26, X16, #0xdfffdfffdfffdfff
    SMULH  X13, X29, X27
    CLS  W6, W28
    SUBS  W19, W2, #0xe4f
    BICS  X11, X14, X28, LSR #59
    MADD  W7, W17, W9, W18
    CLZ  X6, X16
    CLZ  V8.16B, V19.16B
    ADD  X28, X12, #0x981
    ADDS  X8, X2, W2, UXTW #2
    BIC  W9, W13, W21, LSL #10
    UBFM  X19, X19, #0x36, #0x37
    CRC32B  W16, W12, W26
    MADD  X2, X26, X9, X25
    ORR  X17, X25, X28, ROR #3
    MOVK  X24, #0x6b84, LSL #32
    SUBS  X24, X6, #0x53d
    EOR  W13, W27, #0xfe1ffe1f
    SUBS  X23, X28, X11, LSL #47
    CLS  W11, W7
    AND  X19, X28, #0xf1fff1fff1fff1ff
    LSRV  W22, W11, W27
    SUB  X8, X10, W17, SXTH #1
    ANDS  W6, W8, #0xfc003fff
    CLS  W23, W20
    UMADDL  X7, W8, W26, X28
    CSINV  W21, W19, W19, VC
    ADD  W24, W18, #0x47b
    SUB  X27, X16, X12, UXTX #1
    MADD  X9, X26, X14, X10
    CRC32X  W2, W5, X16
    ADDS  X13, X2, X14, ASR #50
    ADD  X5, X10, X16, ASR #25
    MOVZ  X27, #0xfd4b, LSL #32
    BIC  W6, W15, W6, LSL #8
    SUB  X13, X6, #0x4f9, LSL #12
    ADD  W10, W13, W18, LSR #28
    BIC  X21, X22, X12, LSL #26
    ADDS  X9, X28, W17, UXTW #3
    BIC  X26, X8, X7, ROR #26
    ASRV  X18, X18, X5
    ORR  X10, X9, #0xfffff8007fffffff
    UBFM  X12, X28, #0x9, #0x13
    UMULH  X12, X22, X23
    SUBS  X11, X22, W12, SXTH #3
    ORR  X28, X10, #0x3030303030303030
    ADCS  X23, X23, X15
    SUB  W23, W24, W15, ASR #11
    ORN  X13, X20, X15, ROR #21
    SUBS  X15, X15, #0x1
    B.NE  TaishanIntMduP02_label_250
    MOVZ  X12, #0xcccc, LSL #0
    MOVK  X12, #0x1c3f, LSL #16
    SUB  X3, X12, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X5, #0xd2e0, LSL #0
    MOVK  X5, #0xf0d9, LSL #16
    SUB  X11, X5, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X3, #0x1, LSL #0
    SUB  X15, X3, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X27, #0x68b5, LSL #0
    MOVK  X27, #0xa09, LSL #16
    MOVK  X27, #0xfa83, LSL #32
    MOVK  X27, #0xd2bd, LSL #48
    SUB  X11, X27, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X17, #0xd380, LSL #0
    MOVK  X17, #0xf0d9, LSL #16
    SUB  X25, X17, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP02_TestFail
    MOVZ  X11, #0xeced, LSL #0
    MOVK  X11, #0xffb3, LSL #16
    MOVK  X11, #0x6, LSL #32
    SUB  X18, X11, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xf806, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X26, X6, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X2, #0xeced, LSL #0
    MOVK  X2, #0xffb3, LSL #16
    MOVK  X2, #0x6, LSL #32
    SUB  X11, X2, X11
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X2, #0xcccc, LSL #0
    MOVK  X2, #0x1c3f, LSL #16
    SUB  X7, X2, X12
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xf7ff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP02_TestFail
    MOVZ  X29, #0xfffd, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X13, X29, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP02_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X15
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X8, #0xdea, LSL #0
    MOVK  X8, #0xe52a, LSL #16
    SUB  X17, X8, X16
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP02_TestFail
    MOVZ  X14, #0xf135, LSL #0
    MOVK  X14, #0xf1b3, LSL #16
    SUB  X12, X14, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP02_TestFail
    MOVZ  X7, #0x7a00, LSL #0
    MOVK  X7, #0x87f8, LSL #16
    SUB  X14, X7, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X2, #0x10, LSL #0
    SUB  X15, X2, X21
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X16, #0xb798, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X2, X16, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X24, X23, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP02_TestFail
    MOVZ  X21, #0xfffd, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X6, X21, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
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
    MOVZ  X24, #0xa, LSL #0
TaishanIntMduP02_label_278:
    AND  W29, W18, #0x10001
    CRC32CB  W3, W14, W26
    CSNEG  W11, W21, W20, GE
    CRC32H  W28, W7, W21
    ADD  W28, W7, W16, ASR #11
    MOVZ  X9, #0x47dd, LSL #0
    ADDS  X22, X8, #0x740
    MOVN  X10, #0x988a, LSL #0
    EXTR  X21, X27, X5, #0x31
    AND  X13, X12, #0xffffffffc00
    EOR  W17, W23, #0xfff0001f
    SUBS  W14, W5, W10, ASR #23
    ADD  X9, X14, #0xcb7, LSL #12
    EXTR  X22, X8, X24, #0x33
    ADD  W25, W25, W12, LSR #29
    CSINV  X21, X11, X29, LT
    ADD  W13, W3, W23, UXTW #0
    EON  X14, X7, X19, ROR #23
    ADD  W21, W7, #0xa46, LSL #12
    CLS  W22, W8
    CRC32X  W8, W9, X29
    ORR  X16, X11, X26, LSL #56
    ADD  X20, X3, X17, LSL #10
    CSINC  W20, W28, W14, VS
    EOR  W19, W20, #0xfffffe1f
    SBFM  X26, X3, #0x13, #0x4
    BICS  X25, X15, X2, ROR #43
    CSNEG  W18, W28, W2, AL
    UMSUBL  X28, W11, W10, X13
    SUBS  W9, W24, #0x298, LSL #12
    CSINC  X2, X10, X27, NE
    ANDS  W11, W13, #0x78007800
    CRC32CB  W18, W15, W14
    ADC  X17, X28, X5
    ORR  V1.8B, V22.8B, V23.8B
    ANDS  W6, W7, #0x3c000000
    CRC32CB  W6, W6, W20
    BIC  V30.16B, V17.16B, V3.16B
    LSRV  W8, W3, W20
    ADDS  X26, X23, #0x130
    UMULH  X9, X25, X21
    CLZ  X9, X10
    MOVK  W15, #0xb013, LSL #16
    CRC32CW  W10, W3, W2
    ADC  X2, X18, X18
    SBFM  W8, W2, #0xa, #0xd
    AND  W9, W17, W12, LSL #21
    SBFM  X6, X15, #0x31, #0x3c
    SMULH  X14, X9, X22
    MOVZ  W5, #0x63ac, LSL #16
    MOVK  X7, #0x3906, LSL #16
    LSRV  W5, W10, W29
    EXTR  X7, X19, X12, #0x7
    SUB  W8, W2, W7, SXTH #4
    CSINC  X7, X15, X25, PL
    ANDS  X12, X21, X15, LSR #52
    EOR  X7, X23, #0x3fffffffffc
    ADDS  X5, X24, #0xab8
    SUB  W2, W3, W14, ASR #25
    CRC32CX  W25, W21, X2
    BIC  V22.16B, V12.16B, V9.16B
    ORR  X29, X25, #0x5555555555555555
    ASRV  W14, W8, W26
    ORN  W7, W24, W24, ROR #6
    CLZ  W5, W6
    ADC  W27, W12, W18
    CSNEG  W2, W29, W29, CS
    BIC  X12, X2, X8, ROR #43
    CSNEG  X2, X9, X11, LE
    UMADDL  X21, W7, W29, X24
    EOR  W3, W23, W2, ROR #30
    SUB  W19, W7, #0xcf9, LSL #12
    ADCS  X14, X13, X15
    EXTR  W12, W3, W11, #0x1c
    SUBS  X7, X19, X8, LSR #15
    SBFM  X6, X24, #0x2d, #0x1
    ADDS  X21, X23, W21, UXTW #3
    ADD  W5, W22, #0x349
    ORR  V20.16B, V15.16B, V3.16B
    LSLV  W27, W21, W6
    EXTR  W14, W8, W16, #0x18
    MOVK  X9, #0x24cd, LSL #32
    SUB  X28, X26, X3, LSR #2
    SUBS  W11, W28, W25, ASR #1
    SMULH  X11, X6, X19
    SMULH  X27, X11, X5
    CRC32CH  W27, W6, W2
    EOR  X7, X14, #0xffc0001fffc0001f
    AND  W16, W24, #0xfffc007f
    ANDS  X2, X22, #0x7000000000
    MOVK  W23, #0x2978, LSL #0
    ORR  X25, X7, #0x3ff000003ff0
    AND  W6, W14, #0x77777777
    SMADDL  X17, W22, W19, X11
    SUBS  X6, X29, #0x67c
    CRC32CH  W12, W23, W13
    SUB  X13, X21, #0x440
    CSINV  W28, W3, W8, CC
    ADC  W11, W26, W24
    CSEL  X15, X20, X16, LT
    SUBS  X9, X10, X5, UXTX #4
    ANDS  W20, W9, W25, LSR #1
    CLS  W22, W2
    SBFM  W2, W27, #0xf, #0x16
    CSINV  W23, W28, W7, LS
    UBFM  X13, X15, #0x1c, #0x2b
    CLS  X11, X26
    SMSUBL  X10, W25, W9, X20
    EXTR  W8, W2, W23, #0x8
    CSEL  X16, X26, X8, NE
    ADDS  X17, X9, #0xa80
    AND  W8, W13, #0x7ffffc00
    CSINC  X21, X16, X18, MI
    CSNEG  X8, X6, X20, EQ
    SUBS  X27, X6, W3, SXTW #3
    ADD  X12, X14, #0x8a9
    MOVN  X12, #0xef50, LSL #48
    CRC32CH  W12, W27, W24
    CSINV  X10, X27, X29, LT
    ADDS  X10, X13, W27, SXTB #4
    ANDS  W7, W23, W18, LSL #7
    SUB  W28, W5, W13, UXTW #4
    ADDS  W12, W29, #0x4f4
    MOVN  X8, #0x96d8, LSL #0
    MADD  W28, W3, W21, W11
    CLS  X17, X8
    SUBS  W15, W29, W5, SXTX #4
    AND  W2, W14, W14, LSL #2
    SUBS  W3, W6, W12, ASR #1
    ADD  X5, X17, X14, SXTX #4
    UMADDL  X29, W15, W5, X24
    CSINV  W22, W29, W29, LE
    UMULH  X3, X6, X20
    CRC32CH  W5, W15, W21
    ADDS  X20, X24, X9, LSR #38
    SUBS  X16, X15, W26, UXTB #2
    UBFM  W18, W20, #0x1, #0x14
    ANDS  X23, X12, X24, LSR #15
    EOR  W15, W14, W16, LSR #31
    CRC32H  W7, W20, W12
    LSLV  W10, W7, W3
    ADDS  W7, W29, W17, LSR #29
    SUBS  W15, W5, #0xc
    SMADDL  X20, W9, W20, X12
    UMADDL  X18, W15, W6, X29
    BIC  W8, W9, W22, LSL #28
    CLZ  X25, X10
    ADDS  X21, X29, X16, LSL #2
    MADD  W17, W8, W25, W29
    ADDS  W8, W17, W3, UXTH #3
    CLZ  X6, X28
    SUBS  X23, X3, X21, UXTX #2
    AND  X11, X2, X15, ASR #49
    SUB  W26, W7, W12, UXTH #4
    ORN  W17, W12, W8, ROR #31
    ORN  X19, X24, X16
    BIC  W7, W14, W26, ASR #27
    SBFM  X29, X8, #0x11, #0x3e
    CLS  X17, X19
    ANDS  X28, X7, #0xfffffffffff1ffff
    EOR  X5, X15, #0xfffc00
    BICS  X10, X18, X29, LSR #21
    ADD  W25, W22, W29, ASR #24
    ORR  V5.2S, #0xf2, LSL #16
    ORR  W22, W6, #0x1fffe0
    ORR  X18, X17, #0xffffffffffc003ff
    ADD  W28, W6, W25, UXTW #3
    ORN  W8, W23, W6, LSL #23
    CLZ  W2, W21
    ANDS  X9, X18, #0x1ffffe000
    UMSUBL  X5, W20, W8, X26
    MADD  W3, W11, W27, W13
    ADDS  W7, W18, #0xad0
    SUBS  W19, W17, W22, UXTH #1
    CRC32CW  W8, W27, W12
    UMULH  X14, X5, X8
    ADDS  X21, X29, #0x8b0
    CSNEG  X11, X26, X5, CC
    SUBS  W7, W10, #0x620, LSL #12
    SUBS  W19, W26, W7, ASR #27
    ADCS  W13, W9, W2
    ORR  V4.8B, V19.8B, V31.8B
    SUB  X12, X2, X27, LSL #58
    LSRV  W29, W3, W3
    CSINC  X16, X13, X24, GT
    ASRV  W11, W9, W19
    ANDS  W29, W9, #0xff07ff07
    CSINC  W21, W20, W24, HI
    ANDS  W12, W20, W16, LSL #23
    CLS  V3.4H, V27.4H
    UBFM  W28, W11, #0x1d, #0x19
    CSNEG  X17, X14, X11, CC
    SMULH  X11, X27, X28
    ANDS  W29, W19, W12, LSR #18
    ADDS  X13, X13, W26, SXTW #2
    SBFM  W8, W25, #0xe, #0x1d
    SMADDL  X8, W8, W23, X16
    AND  X10, X3, X10, LSL #33
    ORR  X21, X2, X16, LSR #43
    MOVZ  X13, #0xe1af, LSL #16
    SUBS  X24, X24, #0x1
    B.NE  TaishanIntMduP02_label_278
    MOVZ  X29, #0x1, LSL #0
    SUB  X10, X29, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X11, #0x8056, LSL #0
    MOVK  X11, #0x7deb, LSL #16
    MOVK  X11, #0x925e, LSL #32
    MOVK  X11, #0xeb29, LSL #48
    SUB  X8, X11, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP02_TestFail
    MOVZ  X29, #0x99ca, LSL #0
    MOVK  X29, #0x48cc, LSL #16
    SUB  X3, X29, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xffc0, LSL #16
    MOVK  X28, #0x1, LSL #32
    SUB  X11, X28, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X17, X20, X10
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X3, X20, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP02_TestFail
    MOVZ  X23, #0xd769, LSL #0
    MOVK  X23, #0x7a57, LSL #16
    SUB  X29, X23, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP02_TestFail
    MOVZ  X6, #0x2, LSL #0
    SUB  X16, X6, X16
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X28, X3, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP02_TestFail
    MOVZ  X21, #0x3ff, LSL #0
    MOVK  X21, #0xffc0, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X18, X21, X18
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X24, X25, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X11, #0x3ff, LSL #0
    MOVK  X11, #0xffc0, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X7, X11, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X29, X28, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X21, #0xd769, LSL #0
    MOVK  X21, #0x7a57, LSL #16
    SUB  X14, X21, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X14, #0x12b4, LSL #0
    MOVK  X14, #0x6915, LSL #16
    SUB  X19, X14, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X5, #0x2139, LSL #0
    MOVK  X5, #0x6cbf, LSL #16
    MOVK  X5, #0x5558, LSL #32
    MOVK  X5, #0x5555, LSL #48
    SUB  X22, X5, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X15, X6, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
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
    MOVZ  X2, #0xa, LSL #0
TaishanIntMduP02_label_305:
    SMULH  X19, X5, X27
    ANDS  X26, X12, X2, ROR #41
    CSNEG  X16, X29, X14, LT
    EON  W8, W25, W16, LSL #30
    CRC32B  W5, W26, W12
    MOVK  X3, #0x9c99, LSL #16
    MOVN  W3, #0x3eff, LSL #0
    ADDS  W3, W24, #0xef4
    SUBS  W6, W24, W26, ASR #16
    ASRV  X8, X28, X6
    ADD  W3, W26, W22, LSR #8
    LSRV  X20, X13, X26
    ADDS  W5, W10, W20, UXTX #2
    ADDS  W15, W27, W12, SXTB #4
    ORR  V21.2S, #0x52, LSL #24
    SUBS  X18, X19, X15, LSR #45
    EOR  X7, X9, #0xffffffffff80ffff
    CSNEG  W15, W14, W23, EQ
    SBFM  X6, X6, #0x3d, #0x9
    SUB  X24, X9, #0xfce, LSL #12
    CSINV  W24, W2, W6, AL
    UBFM  X8, X29, #0x19, #0x0
    CLS  V29.8H, V6.8H
    CLZ  W13, W13
    ASRV  X13, X12, X26
    CRC32CX  W12, W19, X7
    SBFM  W5, W9, #0x7, #0xc
    UBFM  W22, W20, #0x19, #0xf
    SUBS  W15, W15, #0x1ea
    CSINV  W20, W2, W14, LT
    SMSUBL  X21, W18, W5, X23
    BICS  X29, X5, X3, ROR #43
    SUB  W22, W2, W8, LSR #3
    SUB  X3, X24, X26, LSL #58
    ADDS  W18, W20, W2, ASR #31
    CSINV  W12, W13, W13, MI
    SUB  X18, X15, X7, LSL #63
    ADD  X22, X13, #0xf9d
    BICS  X25, X9, X26, ROR #27
    UMSUBL  X24, W28, W15, X23
    SUBS  W10, W24, W25, SXTB #2
    ADDS  X21, X16, X10, LSR #12
    CRC32CW  W15, W19, W19
    CLZ  W29, W13
    CRC32B  W12, W8, W6
    CSINV  W16, W6, W13, MI
    ADD  X14, X16, #0xbb9, LSL #12
    CRC32W  W24, W29, W7
    ASRV  X11, X27, X28
    SUBS  X23, X17, W20, SXTB #0
    CRC32X  W22, W20, X15
    LSRV  X21, X11, X13
    ANDS  X20, X2, X9, ROR #57
    MOVN  W11, #0x433b, LSL #16
    ORR  W16, W13, W29, ASR #19
    EOR  X24, X17, #0x808080808080808
    SMULH  X15, X3, X26
    CLZ  V30.4S, V0.4S
    EOR  W20, W28, W12, ROR #11
    EXTR  X24, X11, X12, #0x30
    ADD  W25, W24, W25, SXTX #1
    ORN  X14, X8, X5, ROR #13
    EOR  X13, X14, #0x7fffffffffff000
    CRC32W  W8, W3, W17
    CSINC  W11, W22, W13, VC
    ORR  V29.8H, #0x8a, LSL #8
    ADDS  W29, W15, #0x4ee
    CSNEG  X15, X27, X9, CC
    ADD  X17, X28, X2, LSR #59
    SUB  X6, X15, X20, LSL #40
    SUB  X25, X22, X29, LSL #45
    ADDS  X29, X26, #0x6d0
    ORN  W25, W7, W29, LSL #30
    CLS  X9, X28
    MADD  W21, W9, W16, W28
    CLS  X3, X13
    EXTR  X27, X7, X16, #0x16
    ASRV  X27, X27, X27
    UBFM  W6, W6, #0x14, #0x1b
    SUBS  X5, X28, X29, LSL #45
    MOVZ  X18, #0x1a60, LSL #48
    EXTR  X7, X26, X22, #0x27
    UMADDL  X22, W27, W18, X29
    CLZ  W9, W25
    UBFM  W8, W11, #0x9, #0x8
    CSNEG  X11, X14, X20, CS
    SUBS  W13, W21, #0xdc3, LSL #12
    MADD  X19, X28, X5, X20
    CSINC  X13, X17, X27, HI
    AND  X6, X10, #0xf0f0f0f0f0f0f0f
    CLS  V17.4H, V23.4H
    SUB  X15, X13, W11, SXTW #0
    SBFM  X26, X25, #0x1f, #0xb
    CLZ  W14, W3
    ADCS  X29, X21, X22
    EXTR  X11, X23, X15, #0x33
    ORR  X15, X28, #0xe001ffffe001ffff
    CLZ  X6, X28
    ORN  X22, X18, X15, ASR #34
    ANDS  X8, X6, X21, ASR #27
    CRC32B  W19, W8, W11
    ADDS  X25, X8, X10, LSL #38
    CLS  X22, X26
    BIC  X7, X14, X3, LSL #56
    CLS  V20.4H, V15.4H
    ASRV  W20, W20, W20
    SUBS  W29, W22, W29, UXTX #2
    ADD  X24, X27, #0xa6b, LSL #12
    MOVN  X14, #0x7f01, LSL #0
    SUB  W16, W17, W21, SXTW #2
    ADCS  W5, W19, W16
    ADD  W27, W6, W23, SXTB #3
    CSNEG  W19, W9, W23, EQ
    ADDS  X13, X25, #0xd3e, LSL #12
    EON  X3, X28, X14, LSL #22
    MOVN  W6, #0x1332, LSL #0
    ORR  V22.4H, #0x30, LSL #8
    AND  X12, X15, #0xffffffffffc0007f
    CLS  W13, W22
    ANDS  X12, X15, #0xfffe0007fffe0007
    CLS  X14, X21
    ORR  V14.8H, #0x9b, LSL #8
    ADD  X16, X6, #0xb00
    AND  W13, W11, #0xfffffe07
    SUB  X21, X7, W18, UXTH #0
    CSEL  W26, W13, W15, VC
    SUBS  W9, W24, W27, LSL #8
    LSRV  X5, X10, X5
    MOVK  X29, #0x81ca, LSL #16
    CLS  X6, X13
    SUBS  X21, X9, X21, LSR #19
    ADDS  W16, W11, W13, LSL #7
    BIC  V8.8B, V13.8B, V22.8B
    CRC32CW  W7, W14, W10
    BICS  X12, X14, X3, LSL #37
    SUB  W25, W11, W17, ASR #12
    ORN  W6, W2, W18, LSR #24
    ADDS  X20, X26, X23, LSL #33
    BIC  V14.16B, V28.16B, V25.16B
    SUBS  W8, W15, #0xb6f, LSL #12
    MOVK  W7, #0xae50, LSL #16
    MADD  W26, W2, W3, W2
    MOVK  W20, #0x5af, LSL #16
    CLZ  X27, X18
    SBFM  X14, X27, #0x1e, #0x1e
    ADD  W8, W12, #0xf22, LSL #12
    ANDS  X11, X21, X24, ROR #20
    CSINC  W17, W18, W13, VS
    ORN  W29, W24, W13, ROR #23
    SUB  W23, W6, #0x152, LSL #12
    ADC  W5, W3, W23
    SBFM  X29, X26, #0x3a, #0x13
    ORR  X3, X15, X27, ASR #42
    SUB  X25, X13, W20, SXTW #2
    SMULH  X27, X21, X3
    ADC  X12, X3, X9
    SUBS  W19, W6, #0x3f3, LSL #12
    SBFM  W12, W14, #0xf, #0x1e
    CLZ  V1.4S, V14.4S
    ASRV  W19, W16, W8
    ORR  V7.16B, V22.16B, V2.16B
    SUBS  X25, X17, X19, SXTX #2
    SMSUBL  X12, W16, W6, X26
    ADC  W27, W7, W24
    CSEL  X27, X29, X11, EQ
    SUB  X7, X29, X26, LSR #15
    ADD  X25, X12, X9, ASR #48
    CLS  X12, X26
    ORR  W29, W2, #0x7fffffe0
    CSEL  X17, X8, X14, VC
    CSNEG  W9, W7, W23, PL
    EON  W3, W20, W22, LSL #5
    CSINC  X27, X13, X26, LE
    SUBS  W15, W13, W11, ASR #26
    SMSUBL  X29, W19, W9, X11
    ADC  W18, W18, W7
    ORR  X19, X3, X15, LSL #41
    EXTR  W21, W24, W29, #0xb
    UBFM  X25, X19, #0x2b, #0x2
    ORR  X13, X10, X23, LSL #36
    ANDS  X18, X10, X18, LSL #56
    CRC32B  W12, W21, W28
    ORR  V4.8B, V25.8B, V12.8B
    ADDS  X12, X29, #0x250, LSL #12
    ASRV  W3, W10, W2
    ADDS  X12, X2, #0xf23
    ORR  X19, X24, #0x7ffff80000
    EXTR  W24, W23, W22, #0xd
    ADC  W27, W18, W18
    ADDS  W26, W12, #0x869, LSL #12
    ANDS  W7, W28, W7, ASR #24
    ADD  W23, W3, W19, LSR #25
    AND  W29, W12, #0xffe000ff
    ANDS  W7, W11, W13, LSL #8
    ORR  V22.2S, #0xef
    CRC32CH  W10, W21, W11
    EOR  W28, W26, #0xfffe0001
    ADDS  W5, W16, W17, UXTX #0
    AND  W6, W19, #0x7fe07fe0
    EXTR  X29, X14, X19, #0x11
    SUBS  X2, X2, #0x1
    B.NE  TaishanIntMduP02_label_305
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X7, #0x153a, LSL #0
    MOVK  X7, #0xfdff, LSL #16
    SUB  X20, X7, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X14, #0xe01f, LSL #0
    MOVK  X14, #0x46d5, LSL #16
    SUB  X19, X14, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X16, #0x3000, LSL #0
    MOVK  X16, #0x7fe0, LSL #16
    SUB  X23, X16, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x153a, LSL #0
    MOVK  X26, #0xfdff, LSL #16
    SUB  X27, X26, X7
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X5, #0x201f, LSL #0
    MOVK  X5, #0xf2, LSL #16
    SUB  X9, X5, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X23, X19, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X21, #0xf24, LSL #0
    SUB  X7, X21, X12
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X28, X17, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP02_TestFail
    MOVZ  X23, #0xe01f, LSL #0
    MOVK  X23, #0x46d5, LSL #16
    SUB  X14, X23, X14
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X2, #0xc000, LSL #0
    MOVK  X2, #0x4403, LSL #16
    SUB  X29, X2, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X28, #0x3000, LSL #0
    MOVK  X28, #0x7fe0, LSL #16
    SUB  X14, X28, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X29, X26, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X6, X25, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X12, #0xf24, LSL #0
    SUB  X10, X12, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
    MOVZ  X22, #0x1e, LSL #0
    SUB  X20, X22, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X13, #0xe01f, LSL #0
    MOVK  X13, #0x46d5, LSL #16
    SUB  X3, X13, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X27
TaishanIntMduP02_label_85:
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X17, #0x3000, LSL #0
    MOVK  X17, #0x7fe0, LSL #16
    SUB  X22, X17, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X2, #0xb43d, LSL #0
    MOVK  X2, #0xb92c, LSL #16
    MOVK  X2, #0xaa25, LSL #32
    MOVK  X2, #0x142, LSL #48
    MOVZ  X3, #0x9f3, LSL #0
    MOVK  X3, #0x2cf9, LSL #16
    MOVK  X3, #0x5e61, LSL #32
    MOVK  X3, #0x5b8e, LSL #48
    MOVZ  X5, #0xac1c, LSL #0
    MOVK  X5, #0xcf00, LSL #16
    MOVK  X5, #0xfb4b, LSL #32
    MOVK  X5, #0x1e7b, LSL #48
    MOVZ  X6, #0x533a, LSL #0
    MOVK  X6, #0xa42c, LSL #16
    MOVK  X6, #0x85a2, LSL #32
    MOVK  X6, #0x459e, LSL #48
    MOVZ  X7, #0xd7c0, LSL #0
    MOVK  X7, #0x1d97, LSL #16
    MOVK  X7, #0xf120, LSL #32
    MOVK  X7, #0x6cea, LSL #48
    MOVZ  X8, #0x28, LSL #0
    MOVK  X8, #0xa496, LSL #16
    MOVK  X8, #0x359b, LSL #32
    MOVK  X8, #0xa5b5, LSL #48
    MOVZ  X9, #0x3931, LSL #0
    MOVK  X9, #0x6fb3, LSL #16
    MOVK  X9, #0x1d4b, LSL #32
    MOVK  X9, #0x5951, LSL #48
    MOVZ  X10, #0xf556, LSL #0
    MOVK  X10, #0x9ff5, LSL #16
    MOVK  X10, #0x6c4f, LSL #32
    MOVK  X10, #0xb5b9, LSL #48
    MOVZ  X11, #0x4658, LSL #0
    MOVK  X11, #0x25c8, LSL #16
    MOVK  X11, #0xf45, LSL #32
    MOVK  X11, #0x2698, LSL #48
    MOVZ  X12, #0x1bb, LSL #0
    MOVK  X12, #0xad1b, LSL #16
    MOVK  X12, #0x7ab7, LSL #32
    MOVK  X12, #0x6f53, LSL #48
    MOVZ  X13, #0x292a, LSL #0
    MOVK  X13, #0x43cc, LSL #16
    MOVK  X13, #0xc046, LSL #32
    MOVK  X13, #0xa590, LSL #48
    MOVZ  X14, #0x1c7c, LSL #0
    MOVK  X14, #0x2684, LSL #16
    MOVK  X14, #0x2d34, LSL #32
    MOVK  X14, #0xbf98, LSL #48
    MOVZ  X15, #0xf503, LSL #0
    MOVK  X15, #0xdf57, LSL #16
    MOVK  X15, #0x186f, LSL #32
    MOVK  X15, #0xfb3f, LSL #48
    MOVZ  X16, #0x665, LSL #0
    MOVK  X16, #0xef3f, LSL #16
    MOVK  X16, #0xb971, LSL #32
    MOVK  X16, #0xb3f2, LSL #48
    MOVZ  X17, #0xc610, LSL #0
    MOVK  X17, #0xbf59, LSL #16
    MOVK  X17, #0x840, LSL #32
    MOVK  X17, #0x101, LSL #48
    MOVZ  X18, #0x9d64, LSL #0
    MOVK  X18, #0xf61a, LSL #16
    MOVK  X18, #0x35a3, LSL #32
    MOVK  X18, #0x4b45, LSL #48
    MOVZ  X19, #0xab67, LSL #0
    MOVK  X19, #0xfaf8, LSL #16
    MOVK  X19, #0x907, LSL #32
    MOVK  X19, #0x10e9, LSL #48
    MOVZ  X20, #0xe5cb, LSL #0
    MOVK  X20, #0x648e, LSL #16
    MOVK  X20, #0x687f, LSL #32
    MOVK  X20, #0xbdbd, LSL #48
    MOVZ  X21, #0xbd03, LSL #0
    MOVK  X21, #0x9a89, LSL #16
    MOVK  X21, #0xbc07, LSL #32
    MOVK  X21, #0x4c9, LSL #48
    MOVZ  X22, #0x5efb, LSL #0
    MOVK  X22, #0xe68a, LSL #16
    MOVK  X22, #0x95b9, LSL #32
    MOVK  X22, #0xcdd4, LSL #48
    MOVZ  X23, #0x7daf, LSL #0
    MOVK  X23, #0x196f, LSL #16
    MOVK  X23, #0xda06, LSL #32
    MOVK  X23, #0xb568, LSL #48
    MOVZ  X24, #0x33fd, LSL #0
    MOVK  X24, #0xec66, LSL #16
    MOVK  X24, #0xa4e3, LSL #32
    MOVK  X24, #0x26d5, LSL #48
    MOVZ  X25, #0xec04, LSL #0
    MOVK  X25, #0x9bc7, LSL #16
    MOVK  X25, #0x40bc, LSL #32
    MOVK  X25, #0x68f6, LSL #48
    MOVZ  X26, #0x165b, LSL #0
    MOVK  X26, #0xec6c, LSL #16
    MOVK  X26, #0xd508, LSL #32
    MOVK  X26, #0xed2f, LSL #48
    MOVZ  X27, #0x59d8, LSL #0
    MOVK  X27, #0x9ddb, LSL #16
    MOVK  X27, #0xb8aa, LSL #32
    MOVK  X27, #0xe4d5, LSL #48
    MOVZ  X28, #0xe4ed, LSL #0
    MOVK  X28, #0xa788, LSL #16
    MOVK  X28, #0x547c, LSL #32
    MOVK  X28, #0xbc82, LSL #48
    MOVZ  X29, #0xfb4e, LSL #0
    MOVK  X29, #0xc83f, LSL #16
    MOVK  X29, #0x8282, LSL #32
    MOVK  X29, #0x9207, LSL #48
    MOVZ  X18, #0xa, LSL #0
TaishanIntMduP02_label_333:
    CLZ  V6.8B, V2.8B
    MADD  W14, W9, W27, W24
    CSINV  W15, W7, W9, LS
    BIC  V27.8B, V1.8B, V28.8B
    SMADDL  X15, W3, W25, X3
    CSNEG  X15, X26, X25, LE
    MADD  W21, W8, W14, W22
    ANDS  X21, X27, X14, LSR #28
    CLZ  X2, X29
    MOVK  X7, #0xcd18, LSL #0
    AND  X20, X23, X18, ROR #53
    ORR  W28, W8, #0xc7c7c7c7
    EOR  W29, W28, W17, ROR #5
    EXTR  W15, W24, W18, #0x15
    SUB  X5, X16, #0xdb, LSL #12
    MOVK  W21, #0x65c1, LSL #16
    UMADDL  X11, W21, W8, X28
    CSINC  W20, W25, W17, VS
    LSLV  W16, W27, W11
    ADD  W11, W8, #0xda0
    ASRV  X13, X29, X19
    ORR  V17.4H, #0x55
    SBFM  W2, W11, #0xf, #0x0
    MOVK  W11, #0x3294, LSL #0
    UMSUBL  X25, W27, W28, X9
    ADDS  W7, W15, W3, ASR #20
    AND  W12, W21, W19, LSR #14
    LSLV  X12, X6, X25
    EOR  X27, X10, X19, LSL #4
    ADDS  W20, W24, #0xc57
    LSLV  X6, X13, X7
    ADDS  W13, W9, #0xf50
    ADD  W25, W17, W25, SXTW #0
    CRC32CH  W7, W12, W24
    ANDS  X15, X23, #0xf0000ffff0000fff
    UBFM  W8, W23, #0x1c, #0x11
    SUB  X5, X23, W22, SXTH #0
    ADC  W15, W27, W17
    CSINC  X7, X12, X20, GT
    AND  W25, W11, W24, ASR #28
    ADD  W19, W7, W16, LSL #3
    LSLV  X5, X16, X21
    ADD  W19, W8, W15, LSL #10
    ADC  X19, X19, X2
    BIC  X24, X24, X21, ROR #28
    SUBS  W26, W13, #0x8d0
    AND  W21, W2, #0xffe0000f
    LSLV  W6, W15, W3
    CLS  W9, W14
    ORR  W13, W24, W6, LSL #2
    LSRV  X12, X13, X9
    ADD  W23, W8, W20, UXTB #0
    BIC  X23, X5, X14, LSL #56
    CLZ  V12.4S, V21.4S
    ADD  W25, W13, W28, SXTH #1
    ANDS  X12, X21, #0x78
    LSRV  W6, W19, W6
    CRC32CX  W28, W28, X25
    EOR  X26, X26, #0xfff0003ffff0003f
    AND  W14, W25, #0xf3f3f3f3
    SMULH  X26, X10, X15
    ORR  V12.16B, V24.16B, V11.16B
    SMSUBL  X6, W28, W8, X9
    CRC32B  W7, W10, W9
    CSINC  W7, W9, W15, CC
    CSNEG  W21, W22, W23, HI
    EON  W26, W5, W15, LSR #1
    EOR  X24, X20, X24, LSR #38
    SUBS  W12, W12, #0x66f, LSL #12
    SMULH  X7, X7, X14
    ORR  W23, W14, #0xe0e0e0e0
    EOR  X13, X3, #0x8080808080808080
    LSRV  X25, X28, X22
    AND  W21, W18, #0x7ffff000
    ADDS  X29, X18, X6, ASR #23
    EOR  W3, W6, W23, LSR #11
    ANDS  X22, X19, #0x1ffffff81ffffff8
    SUBS  W13, W2, #0x0
    CSNEG  X19, X28, X12, GE
    CSINV  W5, W25, W3, GT
    EXTR  W9, W24, W2, #0x6
    ADCS  W28, W23, W21
    SUB  X7, X29, #0x96e, LSL #12
    EON  X15, X12, X18, LSL #8
    ADD  X23, X16, X7, SXTX #3
    ORN  X15, X10, X20, ASR #12
    BIC  W5, W15, W10, ROR #3
    UMSUBL  X22, W9, W5, X22
    CSINV  X22, X27, X23, GT
    BIC  V12.16B, V10.16B, V25.16B
    EOR  X25, X2, #0x3c003c003c003c00
    EON  W20, W25, W6, LSR #1
    ADD  X28, X27, W22, SXTB #3
    UMSUBL  X3, W3, W7, X22
    ANDS  X14, X7, #0x3ffffe00000
    ORR  X14, X16, #0x7000700070007
    ANDS  W22, W24, #0xf801f801
    CLS  W9, W23
    ADD  X28, X20, #0xa09
    EOR  X10, X29, X22, ROR #50
    CSINV  X3, X21, X10, HI
    ANDS  X8, X17, X23, ROR #32
    CRC32CB  W8, W28, W25
    SUB  W12, W18, W2, ASR #29
    SUB  W14, W3, #0x7b0
    SUBS  X9, X18, #0x459, LSL #12
    CRC32CH  W29, W6, W22
    SUB  W24, W18, #0xb68
    ORR  X23, X14, #0xc007ffffc007ffff
    EOR  X17, X18, #0xfc0000000000
    CRC32CH  W24, W16, W17
    CSINV  X29, X10, X18, VC
    ORR  V3.4H, #0xef, LSL #8
    ORR  X28, X15, #0xfffffff0000000
    SUBS  W14, W22, #0x750
    SUB  X3, X14, X22, ASR #60
    EON  W23, W2, W23, LSL #8
    LSRV  X3, X24, X5
    CRC32CX  W5, W14, X10
    ADC  X12, X29, X8
    ADDS  W9, W20, W11, LSR #18
    SMADDL  X28, W15, W5, X26
    EOR  X12, X9, #0x7000700070007000
    AND  X17, X18, X10, ROR #46
    SBFM  X29, X14, #0x1a, #0x1b
    ORN  X28, X16, X25, LSL #42
    CSNEG  X19, X9, X11, CC
    SUBS  X20, X3, #0x6fb
    AND  W20, W25, W25, ROR #4
    ANDS  W26, W19, W8, LSL #22
    ORR  W27, W16, #0xe00000
    SBFM  X19, X22, #0x2, #0x6
    SUB  W2, W3, W19, SXTH #0
    UBFM  X11, X6, #0x3d, #0x8
    MADD  W8, W21, W8, W18
    EOR  X11, X20, #0xff00003fffffffff
    ORN  W16, W17, W27, ASR #5
    EOR  W23, W11, #0x7ffffe
    CRC32X  W14, W25, X11
    CLZ  X5, X8
    ADD  W8, W20, #0x806
    SMULH  X13, X8, X15
    MOVZ  W23, #0xf078, LSL #16
    MADD  W17, W24, W29, W29
    SUBS  W22, W9, #0x46c
    ASRV  X8, X6, X16
    CLS  W3, W28
    ORR  V16.4H, #0xb, LSL #8
    ADDS  W17, W22, #0xf05, LSL #12
    LSRV  W7, W28, W22
    UBFM  X3, X17, #0xa, #0xa
    BIC  X28, X5, X13, ASR #63
    CRC32X  W9, W18, X8
    BICS  X8, X22, X16, LSR #25
    MADD  W21, W18, W9, W29
    CSINV  W2, W14, W22, EQ
    CRC32CW  W3, W18, W6
    ADD  X16, X17, #0x6ed, LSL #12
    ADC  X6, X29, X6
    MOVN  W13, #0xf80f, LSL #16
    SUB  X6, X26, #0xe9c, LSL #12
    SBFM  W14, W17, #0x9, #0xf
    BIC  V28.16B, V27.16B, V26.16B
    ASRV  W7, W12, W3
    SUBS  W29, W20, W23, ASR #12
    CRC32W  W24, W14, W11
    ADDS  W19, W5, #0x66a, LSL #12
    MOVN  W23, #0xaa79, LSL #0
    ORR  W13, W12, #0x1fff8000
    CSNEG  W16, W14, W14, CC
    CLS  X9, X28
    MADD  W6, W22, W3, W16
    ANDS  X23, X9, #0x1800000018
    UMSUBL  X14, W12, W24, X29
    SMSUBL  X3, W29, W17, X20
    ADDS  X21, X3, #0xbf7, LSL #12
    SUBS  W3, W28, W8, LSR #6
    SMSUBL  X2, W8, W2, X11
    CSEL  W14, W8, W14, CS
    ANDS  W21, W13, W20, LSR #28
    LSRV  X26, X13, X11
    ADD  W5, W13, #0x830
    BICS  W3, W19, W19, ASR #13
    LSRV  W2, W8, W5
    ADD  W20, W20, #0x957
    MOVZ  W9, #0x3b9e, LSL #0
    ORR  W5, W13, W20, LSL #15
    SUBS  X14, X29, #0x726
    EOR  W26, W27, W22, LSL #17
    ANDS  X16, X7, #0xf7f7f7f7f7f7f7f7
    SUB  X5, X16, W11, UXTH #0
    EON  X21, X2, X14, LSR #38
    ORR  X12, X29, X17, LSR #39
    SBFM  X28, X13, #0x31, #0x19
    CLS  W21, W10
    ADD  W10, W11, W3, SXTW #1
    SUB  X24, X26, X13, LSR #53
    SUB  X11, X11, #0xd9d, LSL #12
    ADD  X23, X26, #0x7c, LSL #12
    ASRV  X7, X7, X2
    SUBS  X18, X18, #0x1
    B.NE  TaishanIntMduP02_label_333
    MOVZ  X22, #0x152, LSL #0
    SUB  X15, X22, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X22, #0xa00a, LSL #0
    MOVK  X22, #0x66, LSL #16
    SUB  X24, X22, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP02_TestFail
    MOVZ  X27, #0xf6c1, LSL #0
    MOVK  X27, #0xf7f6, LSL #16
    SUB  X9, X27, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X11, #0x4062, LSL #0
    MOVK  X11, #0x771d, LSL #16
    SUB  X26, X11, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X18, #0x3fff, LSL #0
    SUB  X20, X18, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X29, #0xc781, LSL #0
    MOVK  X29, #0xa905, LSL #16
    SUB  X10, X29, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X9, X12, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X21, X10, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X10, #0xbc27, LSL #0
    MOVK  X10, #0xdfff, LSL #16
    SUB  X14, X10, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP02_TestFail
    MOVZ  X8, #0xf6c0, LSL #0
    MOVK  X8, #0xf7f7, LSL #16
    SUB  X23, X8, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP02_TestFail
    MOVZ  X21, #0x17bb, LSL #0
    MOVK  X21, #0xa9f6, LSL #16
    SUB  X9, X21, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X13, #0x3fff, LSL #0
    SUB  X2, X13, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X26, #0xa03f, LSL #0
    MOVK  X26, #0x66, LSL #16
    SUB  X15, X26, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X24, #0x17bb, LSL #0
    MOVK  X24, #0xa9f6, LSL #16
    SUB  X7, X24, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X3, #0xa00a, LSL #0
    MOVK  X3, #0x66, LSL #16
    SUB  X26, X3, X22
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X9, X12, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X27, #0x17bb, LSL #0
    MOVK  X27, #0xa9f6, LSL #16
    SUB  X7, X27, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP02_TestFail
    MOVZ  X27, #0x17bb, LSL #0
    MOVK  X27, #0xa9f6, LSL #16
    SUB  X18, X27, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X2, #0x8000, LSL #0
    MOVK  X2, #0xde13, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X29, X2, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
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
    MOVZ  X10, #0xa, LSL #0
TaishanIntMduP02_label_361:
    SUBS  W29, W26, W28, ASR #14
    ORR  V31.8H, #0xfb
    SUBS  X7, X9, #0x8cc, LSL #12
    SBFM  W26, W10, #0x1a, #0x16
    SMADDL  X25, W15, W12, X25
    AND  W2, W19, #0x44444444
    ADD  X20, X24, #0x272, LSL #12
    EOR  X19, X26, X28, ROR #41
    ORR  V22.16B, V15.16B, V30.16B
    CRC32X  W3, W22, X2
    ADD  W19, W29, W3, LSL #29
    SUB  X28, X8, #0x0
    ORR  X28, X17, X29, ASR #21
    ADDS  X18, X25, #0x148
    MOVK  W12, #0xd9bb, LSL #0
    CRC32B  W7, W21, W8
    ADD  W15, W9, #0x6e9, LSL #12
    CSINV  X2, X19, X19, AL
    SUB  X28, X14, #0x0
    ADDS  X15, X26, X18, UXTX #2
    ORR  V14.8B, V15.8B, V27.8B
    CSNEG  W15, W13, W13, HI
    ANDS  X19, X15, #0xe0e0e0e0e0e0e0e0
    SUBS  X24, X7, #0xb64
    EON  X3, X20, X10, ROR #33
    MOVK  W3, #0xa5ee, LSL #0
    ADD  X12, X21, X12, LSR #43
    BICS  W22, W15, W6, ASR #21
    MOVZ  W8, #0xa6d5, LSL #0
    EXTR  X16, X15, X28, #0x3d
    BIC  X21, X5, X24, LSR #41
    EOR  W28, W25, #0x81ff81ff
    BIC  X11, X29, X17, LSR #12
    LSLV  X3, X28, X28
    BIC  V24.16B, V13.16B, V14.16B
    SUBS  X11, X25, X26, LSR #59
    CSNEG  W19, W27, W13, NE
    ADCS  W28, W8, W13
    EON  X13, X10, X27, ROR #26
    CRC32CW  W18, W11, W22
    SBFM  W22, W25, #0x16, #0x17
    ADDS  W3, W21, #0xaeb
    MOVZ  W23, #0x40c0, LSL #0
    ANDS  X6, X6, #0x800001ff800001ff
    MOVK  X9, #0xcd7c, LSL #16
    ADD  W24, W28, W13, LSL #7
    ADD  W24, W8, #0xc73
    AND  X20, X23, #0xfff0000000003fff
    CRC32X  W12, W8, X8
    ORR  X7, X17, #0xffffefffffffefff
    ORR  V9.4H, #0x2b, LSL #8
    CRC32CX  W6, W7, X26
    ORR  V1.4H, #0xbd, LSL #8
    SUB  X26, X10, #0x0
    SMULH  X26, X15, X14
    SUB  X5, X18, W20, SXTH #4
    ASRV  X25, X29, X16
    EOR  W29, W11, W19, ASR #9
    EXTR  X23, X9, X11, #0x15
    ADD  X17, X26, W14, UXTH #1
    ORR  V12.8B, V5.8B, V12.8B
    ASRV  W5, W10, W15
    SUB  X29, X13, W28, UXTH #1
    CLS  V22.8B, V14.8B
    BICS  W2, W25, W13, LSR #11
    SUB  W24, W2, W25, UXTX #4
    ORR  V16.8B, V6.8B, V19.8B
    AND  X16, X8, #0xfffff0000000003f
    MADD  X11, X9, X12, X11
    BICS  X8, X7, X18, ROR #62
    LSRV  W9, W25, W26
    UBFM  X16, X6, #0x9, #0x18
    ORR  W5, W16, W23, ASR #30
    CLZ  X25, X14
    ADD  X7, X11, W3, UXTB #2
    AND  W9, W23, W6, ASR #26
    EOR  X25, X9, X26, ROR #15
    CSINC  X14, X7, X22, NV
    ADD  W20, W25, W14, UXTX #3
    CSINV  X25, X27, X24, LT
    ANDS  X27, X12, #0xc1ffffffc1ffffff
    ORR  V19.2S, #0xe5, LSL #24
    CRC32X  W17, W23, X25
    MADD  X23, X9, X18, X14
    CRC32W  W3, W8, W10
    SUB  X2, X28, W17, SXTW #2
    ADDS  W21, W3, #0x290
    AND  W21, W26, W2, LSR #20
    ADCS  X15, X19, X7
    SMADDL  X28, W22, W24, X9
    ADD  X6, X17, X12, ASR #62
    ANDS  W21, W18, W21, ASR #29
    ADC  W26, W12, W23
    LSRV  W23, W22, W26
    MADD  W2, W20, W21, W15
    AND  W6, W12, W19, ROR #0
    CSNEG  W11, W5, W15, AL
    CSNEG  X26, X21, X11, NE
    SMSUBL  X16, W18, W5, X29
    ADD  X28, X9, X6, LSL #44
    MOVN  X23, #0xdcd, LSL #16
    EXTR  W17, W24, W22, #0x11
    EON  X17, X21, X19, LSR #36
    LSLV  X20, X18, X15
    SUBS  X20, X28, W16, UXTB #4
    SUB  X14, X24, W12, SXTW #4
    EON  W2, W11, W26, ROR #16
    CSNEG  W29, W21, W18, NE
    SMADDL  X14, W9, W8, X26
    CLZ  V4.8H, V5.8H
    CSEL  W27, W3, W2, HI
    ADC  W15, W2, W18
    ORR  W12, W16, W25, ASR #14
    CLS  X14, X26
    CLZ  X17, X12
    ASRV  W15, W17, W23
    CLS  V1.4S, V31.4S
    AND  W7, W18, W14, LSL #22
    MOVZ  X25, #0x6c70, LSL #32
    SUBS  X19, X12, #0xd3d
    ADD  W16, W5, #0xc02
    ANDS  W2, W25, #0xfffe1fff
    SUB  X18, X21, W10, UXTW #2
    ANDS  X16, X7, #0xfff8000000000000
    ADD  X11, X12, X14, ASR #55
    CLZ  V18.16B, V15.16B
    ASRV  W19, W26, W15
    ADDS  X6, X7, #0x23c, LSL #12
    UMULH  X2, X19, X27
    AND  X5, X13, #0x3ffffff00000
    UBFM  X20, X17, #0x3c, #0x19
    ADD  X15, X23, W29, UXTB #2
    ORR  V21.2S, #0x9b
    CSINC  X25, X15, X8, VS
    CRC32CW  W12, W14, W26
    CLS  X25, X3
    ADDS  X21, X26, #0x7f0
    CLZ  V4.8H, V26.8H
    SUB  X22, X22, X21, ASR #24
    ORR  W16, W18, #0x1f000000
    SMULH  X11, X11, X29
    EOR  W18, W5, W19, LSL #26
    UBFM  W18, W15, #0x7, #0x10
    ANDS  X15, X14, X10, LSR #46
    EON  W7, W10, W21, ASR #1
    ADDS  W20, W5, #0x510
    ADDS  X17, X14, X20, ASR #3
    LSLV  X28, X22, X3
    CLZ  X12, X21
    UMULH  X3, X19, X20
    ORR  V3.8H, #0x5f
    ADDS  X2, X29, #0x657
    AND  X19, X22, #0xe1e1e1e1e1e1e1e1
    LSLV  W27, W26, W10
    ANDS  X25, X7, #0xffffffffc000000
    ADD  X14, X17, X26, LSR #48
    CRC32CW  W25, W12, W15
    CSINV  W23, W14, W15, NV
    SMULH  X23, X18, X28
    SUB  W14, W27, #0x6df
    CLS  W25, W27
    AND  X14, X22, X15, LSR #6
    CLS  X18, X7
    MOVZ  W21, #0x7a59, LSL #16
    AND  X19, X15, X2, LSL #29
    CRC32CH  W29, W5, W2
    AND  W9, W22, #0x78000000
    SMSUBL  X13, W22, W25, X11
    MADD  W11, W17, W25, W24
    SUB  X13, X11, W15, UXTW #3
    CLS  V6.8H, V9.8H
    ORR  W19, W15, W19, LSR #25
    AND  X8, X21, #0x7fffffc00000
    CRC32CX  W28, W27, X27
    ADC  X26, X28, X28
    CSINC  X25, X11, X9, AL
    ORR  X14, X11, X2, ASR #49
    CLS  W6, W17
    SUB  W23, W12, W19, UXTB #0
    SUB  X12, X7, W23, UXTW #0
    CLS  X11, X24
    ADDS  W11, W3, #0x425, LSL #12
    EON  W12, W20, W13, ROR #22
    SUBS  W20, W10, W13
    ADDS  X18, X24, #0x809
    SMSUBL  X20, W22, W25, X21
    ORR  V10.4H, #0xdc, LSL #8
    CRC32CH  W27, W17, W17
    ADCS  W24, W24, W23
    ADDS  W17, W22, #0x951, LSL #12
    MOVZ  X28, #0xc549, LSL #0
    CSEL  X28, X6, X12, LE
    CRC32CW  W6, W17, W7
    ORR  X6, X11, X15, ROR #20
    CRC32CX  W5, W9, X27
    ORR  W20, W28, #0x3030303
    CSNEG  X26, X25, X26, GT
    MOVK  W26, #0xda19, LSL #16
    LSRV  X18, X2, X8
    CSNEG  W14, W24, W24, GE
    SUBS  X10, X10, #0x1
    B.NE  TaishanIntMduP02_label_361
    MOVZ  X13, #0x657, LSL #0
    SUB  X24, X13, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP02_TestFail
    MOVZ  X10, #0xfafe, LSL #0
    MOVK  X10, #0x99ba, LSL #16
    SUB  X3, X10, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X22, #0x5000, LSL #0
    MOVK  X22, #0x42, LSL #16
    SUB  X23, X22, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP02_TestFail
    MOVZ  X2, #0x71e8, LSL #0
    SUB  X15, X2, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7a40, LSL #16
    SUB  X12, X5, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP02_TestFail
    MOVZ  X7, #0xfafe, LSL #0
    MOVK  X7, #0x99ba, LSL #16
    SUB  X18, X7, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X13, #0x5000, LSL #0
    MOVK  X13, #0x42, LSL #16
    SUB  X23, X13, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X12, #0x5000, LSL #0
    MOVK  X12, #0x42, LSL #16
    SUB  X2, X12, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X5, #0xf260, LSL #0
    MOVK  X5, #0xffff, LSL #16
    SUB  X10, X5, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X15
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X14, #0xfffc, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X21, X14, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP02_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X19
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X21, X10, X21
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X10, #0x5000, LSL #0
    MOVK  X10, #0x42, LSL #16
    SUB  X26, X10, X22
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X13, X3, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
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
TaishanIntMduP02_label_387:
    ADCS  W28, W25, W22
    SMADDL  X28, W27, W17, X29
    ADDS  W11, W13, #0x906, LSL #12
    CSNEG  X26, X12, X9, NE
    SMADDL  X29, W11, W28, X22
    CSINV  W25, W12, W19, LE
    ADDS  X8, X25, #0x3f3
    ADDS  W8, W13, W17, ASR #13
    CSEL  X27, X8, X7, PL
    ASRV  W29, W12, W7
    BICS  W26, W7, W29, LSR #31
    EOR  X27, X27, #0x7ffffe00
    CRC32CX  W27, W14, X26
    CSINV  X18, X10, X27, LT
    BIC  W3, W26, W10, ASR #13
    SBFM  W3, W9, #0x16, #0xb
    SUBS  X22, X9, X28, ASR #23
    CSEL  X20, X9, X7, CS
    SUB  X29, X23, X29, LSR #49
    ORR  X21, X13, X20, LSL #36
    SBFM  W10, W19, #0x8, #0xe
    BIC  V20.16B, V19.16B, V20.16B
    AND  X23, X26, X9, ASR #2
    ADDS  W17, W28, W26, SXTH #3
    SUBS  W16, W22, W23, UXTH #2
    ANDS  W3, W24, W12, LSR #28
    EOR  X28, X25, X25, ROR #7
    ADD  X11, X23, W22, SXTH #4
    EXTR  X3, X8, X27, #0x29
    ANDS  X17, X3, #0xfffe000000003fff
    CLZ  V31.16B, V11.16B
    SBFM  X7, X7, #0x36, #0x35
    CSINC  X18, X29, X10, CC
    SUBS  X10, X10, W15, SXTB #3
    CLZ  V16.4H, V2.4H
    CRC32CB  W18, W3, W17
    LSLV  X8, X17, X11
    ORR  V22.8B, V1.8B, V12.8B
    ADDS  X11, X12, #0xb50
    SBFM  W14, W3, #0xb, #0xb
    AND  W25, W14, W10, LSR #18
    SMSUBL  X25, W9, W13, X22
    ADDS  W27, W24, #0x847, LSL #12
    CLZ  W26, W16
    ADCS  X5, X18, X8
    AND  X29, X17, #0x1ffffff000000
    MOVK  W14, #0x5552, LSL #0
    AND  X17, X7, #0x7c0000007c00000
    LSRV  W29, W3, W21
    SUB  X14, X13, X20, LSR #4
    ANDS  X16, X18, #0xfe000000fe000
    CRC32CW  W13, W5, W20
    ADD  X14, X17, W10, SXTH #4
    SUB  X21, X23, #0xb9d, LSL #12
    CLS  X17, X6
    LSRV  X6, X8, X21
    ORR  V6.2S, #0xe1, LSL #24
    SUBS  X6, X20, X28, LSL #19
    SUB  X22, X29, #0xf21
    ADC  X28, X26, X11
    CRC32CB  W6, W11, W28
    CRC32W  W10, W28, W24
    ANDS  W5, W22, W10, LSR #30
    SMSUBL  X22, W28, W8, X10
    UMSUBL  X21, W22, W20, X16
    SMADDL  X29, W29, W20, X18
    MOVZ  W28, #0x9a0e, LSL #0
    ORR  V26.16B, V5.16B, V26.16B
    BIC  V11.16B, V16.16B, V23.16B
    SBFM  X23, X21, #0x34, #0x23
    CRC32CX  W14, W20, X29
    BIC  X26, X29, X26, LSR #55
    SUB  X25, X23, X10, LSR #8
    SMADDL  X9, W28, W18, X22
    LSLV  X24, X10, X8
    MOVZ  W3, #0xe351, LSL #0
    ADD  X18, X22, X29, ASR #10
    ORR  V14.2S, #0x1b
    ADD  X15, X27, W11, UXTH #2
    SMSUBL  X15, W18, W12, X5
    SUBS  W20, W23, W10, UXTH #3
    SUBS  W14, W20, W28, LSR #8
    MADD  W2, W14, W25, W25
    ADD  W21, W7, W3, SXTH #3
    CRC32CB  W11, W23, W2
    LSRV  X5, X19, X18
    AND  X17, X26, X3, LSL #3
    EXTR  W16, W16, W26, #0x1b
    CSNEG  W9, W20, W22, NV
    MOVZ  X28, #0xb535, LSL #32
    CSINC  W9, W6, W26, GE
    SUBS  X13, X26, X15, ASR #39
    AND  X14, X6, #0xfe0000fffe0000ff
    BIC  V30.16B, V13.16B, V11.16B
    ADDS  X6, X17, W8, UXTH #0
    MOVZ  X14, #0xfd4a, LSL #16
    EOR  X2, X21, X26, LSR #39
    LSLV  W6, W9, W7
    SUBS  W11, W20, W12, SXTX #1
    MADD  X7, X28, X14, X3
    SUBS  X23, X2, X16, ASR #5
    AND  W12, W24, W18, ROR #2
    MADD  X26, X14, X2, X22
    CSNEG  X22, X5, X8, NE
    BIC  V22.8B, V1.8B, V19.8B
    CLZ  V11.2S, V25.2S
    LSLV  X22, X19, X11
    MADD  X15, X23, X13, X23
    ORR  V26.8H, #0x6d, LSL #8
    ADD  W26, W15, W20, SXTW #3
    CSNEG  W6, W8, W9, MI
    SUBS  W22, W14, #0xc30
    AND  W18, W7, W2, ROR #30
    ORR  X28, X12, #0x7fff000
    CSINC  X18, X7, X28, VC
    CSINC  X24, X15, X15, LE
    CSNEG  W20, W21, W26, EQ
    CSNEG  X5, X3, X22, VS
    ADDS  W15, W2, W7, SXTB #2
    ADD  W8, W19, #0x2be
    CLZ  X11, X23
    LSRV  W27, W20, W23
    ORR  X15, X26, #0xffff00000000007f
    ASRV  X17, X8, X13
    SUBS  W5, W7, W22, ASR #15
    ADDS  X12, X29, #0x610
    CRC32X  W14, W2, X9
    SBFM  X18, X6, #0x25, #0x36
    CRC32B  W18, W24, W20
    EON  X11, X15, X27, ASR #56
    CSNEG  W21, W25, W11, LE
    CSINC  X21, X21, X25, NE
    SBFM  W8, W24, #0x19, #0xc
    CLZ  X3, X24
    ORN  X21, X23, X26, LSL #27
    SUBS  W21, W8, #0x263
    ADD  W10, W13, W21, ASR #3
    CLZ  W14, W28
    ADC  W7, W10, W26
    ADD  X28, X17, #0xf6d
    CSNEG  W20, W3, W14, CC
    ADDS  W24, W24, W22, LSL #16
    CRC32CW  W18, W2, W28
    ADDS  X9, X13, #0x440
    CLZ  W23, W9
    CSINV  X29, X20, X17, GE
    SUB  W6, W29, W9, UXTX #0
    CRC32H  W21, W15, W19
    CSINC  W7, W22, W7, VC
    SUBS  W3, W15, #0xcc8, LSL #12
    SUB  X25, X3, X3, ASR #23
    SUBS  W23, W19, #0x3c5
    CSINV  W23, W3, W6, CS
    LSLV  W15, W24, W22
    ASRV  W23, W24, W19
    CRC32B  W20, W23, W23
    UMSUBL  X13, W16, W21, X26
    CRC32B  W23, W17, W26
    LSRV  W22, W3, W20
    ADD  W15, W17, W3, UXTH #0
    LSLV  W14, W13, W20
    AND  X7, X13, #0xf00000000001ffff
    ADD  X5, X23, W25, UXTW #3
    ORR  W20, W23, #0x1fc01fc
    ADDS  X5, X10, #0x944
    LSLV  X24, X29, X8
    CSEL  W12, W26, W9, GE
    ANDS  X29, X10, X19, ROR #13
    ADD  W20, W20, #0xfa3
    AND  X10, X3, #0xff00003fff00003f
    ADDS  W23, W7, W22, SXTX #2
    SMULH  X24, X20, X20
    UMULH  X6, X18, X17
    ORR  W2, W15, W23, LSL #27
    CLS  X13, X14
    ORR  W10, W9, W16, LSL #29
    MOVZ  X8, #0x64a7, LSL #32
    CRC32CX  W26, W7, X22
    SUB  X10, X12, W21, SXTW #2
    SUBS  W3, W27, W5, SXTB #3
    SBFM  W29, W12, #0x2, #0x4
    CLS  W12, W2
    SBFM  W25, W10, #0x10, #0x1b
    CSINC  W24, W9, W21, GE
    BICS  W13, W8, W13, LSR #28
    ADD  W16, W25, W27, LSL #17
    SUBS  X9, X10, W19, UXTH #4
    ORR  W18, W16, W13
    SUBS  X18, X12, #0xeb8, LSL #12
    MOVN  W16, #0x7a42, LSL #16
    SMSUBL  X24, W25, W22, X14
    ANDS  X9, X23, X22, LSL #41
    ADDS  X18, X26, X17, LSL #46
    MADD  X3, X8, X2, X23
    AND  X9, X5, #0xff00000007ffffff
    ADDS  X7, X27, X20, LSL #24
    SUB  X27, X12, X21, ASR #53
    CLS  X12, X12
    UMADDL  X15, W6, W14, X12
    CLS  V2.4H, V31.4H
    SUBS  X19, X19, #0x1
    B.NE  TaishanIntMduP02_label_387
    MOVZ  X22, #0x323e, LSL #0
    MOVK  X22, #0x4000, LSL #16
    SUB  X24, X22, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP02_TestFail
    MOVZ  X9, #0xb0a8, LSL #0
    MOVK  X9, #0xfe72, LSL #32
    MOVK  X9, #0xd3c0, LSL #48
    SUB  X7, X9, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X7, #0x3177, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X28, X7, X5
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X24, #0x3177, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X27, X24, X7
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x64a7, LSL #32
    SUB  X6, X24, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X5, #0xb0a8, LSL #0
    MOVK  X5, #0xfe72, LSL #32
    MOVK  X5, #0xd3c0, LSL #48
    SUB  X2, X5, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X5, #0x3f7c, LSL #0
    MOVK  X5, #0xd29d, LSL #16
    SUB  X18, X5, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X10, #0x3f, LSL #0
    SUB  X14, X10, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X24, X15, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP02_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0x85bd, LSL #16
    SUB  X17, X15, X16
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP02_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X17
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X21, X11, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X19, X3, X19
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X11, #0x77a0, LSL #0
    MOVK  X11, #0x23fd, LSL #16
    SUB  X26, X11, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
    MOVZ  X8, #0x323e, LSL #0
    MOVK  X8, #0x4000, LSL #16
    SUB  X12, X8, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X13, X7, X27
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X2, #0x1a68, LSL #0
    MOVK  X2, #0xb912, LSL #16
    MOVK  X2, #0xe0cb, LSL #32
    MOVK  X2, #0x1d9e, LSL #48
    MOVZ  X3, #0x38ed, LSL #0
    MOVK  X3, #0x1a37, LSL #16
    MOVK  X3, #0x9e3a, LSL #32
    MOVK  X3, #0xa55f, LSL #48
    MOVZ  X5, #0x9e1, LSL #0
    MOVK  X5, #0xee38, LSL #16
    MOVK  X5, #0xaa1f, LSL #32
    MOVK  X5, #0xded7, LSL #48
    MOVZ  X6, #0x432f, LSL #0
    MOVK  X6, #0xecfb, LSL #16
    MOVK  X6, #0x177e, LSL #32
    MOVK  X6, #0x234b, LSL #48
    MOVZ  X7, #0x939, LSL #0
    MOVK  X7, #0xd902, LSL #16
    MOVK  X7, #0x765a, LSL #32
    MOVK  X7, #0x4a5d, LSL #48
    MOVZ  X8, #0xe082, LSL #0
    MOVK  X8, #0x2198, LSL #16
    MOVK  X8, #0xe09d, LSL #32
    MOVK  X8, #0x3a60, LSL #48
    MOVZ  X9, #0x6563, LSL #0
    MOVK  X9, #0xac12, LSL #16
    MOVK  X9, #0xd3e9, LSL #32
    MOVK  X9, #0x1b40, LSL #48
    MOVZ  X10, #0xec8c, LSL #0
    MOVK  X10, #0x7d2d, LSL #16
    MOVK  X10, #0x489a, LSL #32
    MOVK  X10, #0x852d, LSL #48
    MOVZ  X11, #0xdf01, LSL #0
    MOVK  X11, #0x9955, LSL #16
    MOVK  X11, #0xe07, LSL #32
    MOVK  X11, #0x7646, LSL #48
    MOVZ  X12, #0x2635, LSL #0
    MOVK  X12, #0x8e53, LSL #16
    MOVK  X12, #0xe604, LSL #32
    MOVK  X12, #0xa6f4, LSL #48
    MOVZ  X13, #0x28bd, LSL #0
    MOVK  X13, #0x8be6, LSL #16
    MOVK  X13, #0x2b8d, LSL #32
    MOVK  X13, #0x8f64, LSL #48
    MOVZ  X14, #0x836b, LSL #0
    MOVK  X14, #0xe3a7, LSL #16
    MOVK  X14, #0x269d, LSL #32
    MOVK  X14, #0x8c1c, LSL #48
    MOVZ  X15, #0xb09, LSL #0
    MOVK  X15, #0x36f7, LSL #16
    MOVK  X15, #0x7e74, LSL #32
    MOVK  X15, #0x9bbf, LSL #48
    MOVZ  X16, #0x789a, LSL #0
    MOVK  X16, #0x1e99, LSL #16
    MOVK  X16, #0x325, LSL #32
    MOVK  X16, #0x8940, LSL #48
    MOVZ  X17, #0x288c, LSL #0
    MOVK  X17, #0xacf0, LSL #16
    MOVK  X17, #0x5650, LSL #32
    MOVK  X17, #0x4bb1, LSL #48
    MOVZ  X18, #0xc705, LSL #0
    MOVK  X18, #0x6163, LSL #16
    MOVK  X18, #0x3d09, LSL #32
    MOVK  X18, #0xb81b, LSL #48
    MOVZ  X19, #0x57f1, LSL #0
    MOVK  X19, #0xbe89, LSL #16
    MOVK  X19, #0x5c1d, LSL #32
    MOVK  X19, #0xa586, LSL #48
    MOVZ  X20, #0x33a5, LSL #0
    MOVK  X20, #0x5730, LSL #16
    MOVK  X20, #0xaad1, LSL #32
    MOVK  X20, #0xab28, LSL #48
    MOVZ  X21, #0xce80, LSL #0
    MOVK  X21, #0xb5ac, LSL #16
    MOVK  X21, #0xe97f, LSL #32
    MOVK  X21, #0x41fe, LSL #48
    MOVZ  X22, #0x4f50, LSL #0
    MOVK  X22, #0xc223, LSL #16
    MOVK  X22, #0x44f2, LSL #32
    MOVK  X22, #0x7733, LSL #48
    MOVZ  X23, #0xdaf7, LSL #0
    MOVK  X23, #0xcd61, LSL #16
    MOVK  X23, #0x8d1f, LSL #32
    MOVK  X23, #0xf424, LSL #48
    MOVZ  X24, #0xdf2a, LSL #0
    MOVK  X24, #0x5ee7, LSL #16
    MOVK  X24, #0x821d, LSL #32
    MOVK  X24, #0x6371, LSL #48
    MOVZ  X25, #0x8e69, LSL #0
    MOVK  X25, #0x8669, LSL #16
    MOVK  X25, #0x539c, LSL #32
    MOVK  X25, #0xd4c5, LSL #48
    MOVZ  X26, #0x28b3, LSL #0
    MOVK  X26, #0x2805, LSL #16
    MOVK  X26, #0xb4a5, LSL #32
    MOVK  X26, #0xf6b3, LSL #48
    MOVZ  X27, #0x21cb, LSL #0
    MOVK  X27, #0x7eb7, LSL #16
    MOVK  X27, #0xefbf, LSL #32
    MOVK  X27, #0x28a8, LSL #48
    MOVZ  X28, #0xbb9a, LSL #0
    MOVK  X28, #0x8537, LSL #16
    MOVK  X28, #0x83a2, LSL #32
    MOVK  X28, #0xbd3e, LSL #48
    MOVZ  X29, #0x1201, LSL #0
    MOVK  X29, #0xd354, LSL #16
    MOVK  X29, #0x859e, LSL #32
    MOVK  X29, #0x3b9, LSL #48
    MOVZ  X2, #0xa, LSL #0
TaishanIntMduP02_label_415:
    UMSUBL  X22, W7, W20, X16
    UMADDL  X16, W27, W7, X22
    CSINC  W6, W21, W14, LS
    CSINV  W11, W24, W28, GT
    SUBS  W3, W24, #0x390
    ORR  W29, W13, #0x1fff0
    SUB  W25, W3, #0xcb2, LSL #12
    ADDS  X11, X26, W18, UXTH #1
    CSNEG  X17, X25, X8, AL
    MADD  W17, W24, W28, W9
    EON  X3, X2, X7, ROR #26
    AND  W3, W5, #0xffe007ff
    UMSUBL  X6, W22, W28, X14
    LSLV  X14, X5, X11
    SUBS  X27, X12, X20, LSR #12
    BICS  W29, W12, W13, LSR #8
    CSEL  W11, W3, W16, HI
    ADD  X29, X26, #0x5ee, LSL #12
    ADDS  W5, W10, #0xe40
    EON  X17, X10, X10, ROR #33
    AND  W15, W6, #0x7f8
    SUBS  X8, X24, X26, LSL #31
    SBFM  W3, W27, #0x17, #0x8
    SBFM  X17, X28, #0x2d, #0x29
    SUBS  X11, X14, #0xac1
    CLS  X12, X26
    ORR  W23, W26, #0x1800
    ADDS  W28, W3, W9
    CSNEG  X6, X24, X20, EQ
    SMSUBL  X15, W7, W22, X2
    SMULH  X10, X13, X19
    CLZ  V27.4S, V29.4S
    SUB  X17, X19, #0xef9
    UMULH  X20, X23, X20
    ORR  V31.16B, V31.16B, V14.16B
    LSRV  W27, W12, W22
    ADDS  X5, X17, X20, LSL #15
    AND  W3, W9, #0xf800
    ADD  X15, X6, W15, UXTH #2
    ORR  X18, X24, #0x7e00000
    MOVN  X27, #0x8ac9, LSL #0
    MOVZ  W6, #0xa861, LSL #16
    BIC  X13, X7, X16, ROR #42
    SUB  W26, W26, W20, ASR #30
    CRC32CX  W6, W6, X22
    SBFM  W16, W9, #0xa, #0x16
    CSNEG  W7, W3, W28, GT
    LSRV  X20, X22, X2
    ORR  X10, X19, X24, ROR #13
    ADDS  X7, X16, X3, LSL #26
    MADD  X15, X14, X12, X14
    AND  X17, X13, X25, LSR #26
    ADDS  W10, W19, W25, ASR #19
    MOVN  X28, #0x2cc5, LSL #32
    MOVN  W26, #0x9aac, LSL #16
    ADC  W13, W17, W28
    ANDS  W23, W27, #0x66666666
    ADCS  W14, W5, W2
    CRC32X  W28, W20, X9
    SUB  X5, X13, X6, LSR #57
    ORR  V29.8H, #0xe7, LSL #8
    EOR  X28, X23, X15, LSL #26
    LSLV  X19, X26, X14
    ADDS  W26, W27, W19, ASR #19
    EON  X3, X22, X3, ROR #38
    SUB  X26, X12, X29, LSR #5
    AND  W14, W24, #0x7fffc00
    ADD  W18, W24, #0xb0
    EOR  W27, W14, W13, ROR #27
    CLZ  V26.2S, V11.2S
    ORR  V14.16B, V6.16B, V26.16B
    ASRV  W16, W7, W25
    LSRV  W12, W13, W27
    ADCS  W5, W24, W7
    MADD  X7, X7, X10, X18
    ORR  V20.4H, #0xb1
    ANDS  W15, W6, #0xfc0007ff
    ASRV  X18, X19, X25
    LSLV  W12, W14, W28
    ORN  W14, W5, W11, LSR #14
    AND  X9, X6, #0xffffffc3ffffffc3
    ADD  W13, W22, W23, LSL #14
    LSLV  X19, X26, X17
    EOR  W29, W7, #0xf3f3f3f3
    SBFM  W3, W11, #0x19, #0x12
    LSLV  W19, W22, W13
    CLZ  V15.4S, V16.4S
    ADC  X20, X3, X11
    ORR  W26, W29, W15, ROR #8
    CLS  W13, W26
    SUB  W25, W19, W27, UXTX #0
    SUB  X12, X28, W3, SXTH #0
    CRC32B  W26, W5, W23
    MOVZ  W11, #0x1711, LSL #0
    CSINV  X5, X14, X18, AL
    SUBS  X7, X3, X13, LSL #2
    SBFM  X20, X24, #0x24, #0x25
    LSRV  X20, X18, X21
    ADDS  X20, X29, #0x1f8
    CRC32CX  W11, W24, X28
    CRC32B  W5, W29, W22
    SUB  X5, X15, X18, ASR #31
    AND  X18, X12, #0x3333333333333333
    SUBS  W14, W22, #0x81e, LSL #12
    ADD  W21, W29, #0xcd1
    EOR  X20, X26, X7, ASR #9
    SUBS  X9, X9, W14, SXTW #1
    MOVK  W27, #0x9ac3, LSL #16
    EOR  W8, W7, W28, ROR #0
    EXTR  W19, W13, W8, #0x19
    ORR  W7, W11, W16, ASR #27
    ASRV  W14, W8, W24
    ANDS  X22, X25, #0xc000c000c000c00
    ADC  X27, X21, X13
    UMADDL  X3, W28, W14, X9
    UMULH  X17, X19, X7
    SUBS  W12, W23, W26, UXTB #1
    CLS  X20, X8
    CRC32W  W19, W19, W23
    SUB  X29, X12, X3, LSL #12
    ORR  V14.16B, V15.16B, V20.16B
    ADDS  W7, W27, W17, SXTB #1
    UMADDL  X16, W3, W26, X17
    UBFM  X7, X23, #0x17, #0x2f
    EOR  X21, X7, #0x3c0000003c0000
    EON  W24, W29, W8, ROR #23
    MOVN  W28, #0x6d4a, LSL #0
    CSINC  W24, W9, W16, CS
    SUBS  W22, W16, W26, ASR #28
    ADD  W20, W22, #0xb10
    BIC  X22, X20, X9, LSR #43
    ORR  V12.4S, #0xed
    EON  X17, X6, X29, ROR #26
    CRC32CB  W14, W17, W22
    ADCS  X14, X14, X26
    LSLV  X29, X7, X17
    CRC32H  W8, W11, W21
    EOR  X28, X6, #0xff0000000001ffff
    ADDS  W23, W14, #0x400
    ORR  W5, W14, #0x3ffe
    MOVN  X17, #0xefa8, LSL #16
    ADDS  X26, X12, W19, SXTB #0
    CLS  X16, X3
    ADDS  W27, W8, W28, LSR #28
    SUB  X14, X29, X20, LSL #37
    EON  W15, W5, W7, ROR #7
    ORR  V9.8H, #0xcf
    CRC32X  W3, W19, X23
    EON  W7, W27, W22, ASR #19
    CSINC  W18, W18, W27, NV
    ORR  X24, X6, #0x3fffffffffffffe
    SMULH  X11, X12, X5
    AND  X12, X3, #0x1ffffffffff8000
    SUBS  W21, W8, W16, LSR #0
    SUBS  W23, W28, W18, SXTH #1
    ADDS  W20, W28, W28, UXTW #2
    UMADDL  X18, W11, W11, X15
    ADC  W23, W11, W18
    CLZ  X11, X8
    SUB  W26, W11, #0xd3b, LSL #12
    SUBS  X26, X12, #0xcf0
    CLZ  V20.16B, V0.16B
    CSEL  X7, X12, X23, PL
    SUB  X19, X18, X18, SXTX #3
    MADD  W21, W27, W15, W27
    CLZ  V18.8B, V26.8B
    EOR  X7, X23, X18, ASR #19
    CSINV  W24, W17, W23, CS
    LSLV  X9, X21, X20
    ADD  W22, W22, W18, LSL #20
    MADD  W12, W6, W16, W12
    EOR  X6, X29, X19, LSR #25
    CLZ  X3, X19
    CSINV  X6, X17, X21, NE
    SUB  X8, X22, X8, LSL #28
    ADC  X27, X13, X17
    SUBS  X26, X29, #0xf50
    ANDS  X26, X9, X12, LSR #30
    CLZ  X3, X21
    SUB  X7, X17, #0x29c, LSL #12
    ORR  W28, W7, #0xc000
    SMULH  X15, X25, X13
    BICS  X14, X20, X28, LSR #40
    EXTR  X10, X5, X8, #0x35
    CRC32CH  W9, W20, W15
    EON  X6, X7, X24, LSR #42
    ADD  W5, W14, #0x240
    CRC32CX  W9, W20, X8
    LSRV  X18, X23, X21
    SMADDL  X14, W28, W8, X25
    BIC  V16.8B, V15.8B, V6.8B
    SUBS  X9, X18, X11, ASR #41
    SUB  W3, W11, W5, UXTH #2
    SUB  W23, W28, #0x1eb
    ADCS  X21, X23, X27
    ADD  W23, W26, #0xe11, LSL #12
    ORR  W22, W24, #0x1ffffffc
    CSEL  X22, X15, X15, LT
    SUB  W10, W25, W20, UXTX #4
    LSRV  W8, W26, W3
    SUBS  X2, X2, #0x1
    B.NE  TaishanIntMduP02_label_415
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP02_TestFail
    MOVZ  X23, #0x1316, LSL #0
    MOVK  X23, #0xfffc, LSL #16
    SUB  X3, X23, X3
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X24, #0xfb43, LSL #0
    MOVK  X24, #0xa251, LSL #16
    SUB  X22, X24, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP02_TestFail
    MOVZ  X10, #0xc000, LSL #0
    MOVK  X10, #0xefd1, LSL #16
    SUB  X11, X10, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X17, #0x3fff, LSL #0
    MOVK  X17, #0x102e, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X22, X17, X7
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP02_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X27, X8, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X9, #0xc000, LSL #0
    MOVK  X9, #0xefd1, LSL #16
    SUB  X25, X9, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP02_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X13, X7, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP02_TestFail
    MOVZ  X24, #0xc798, LSL #0
    MOVK  X24, #0x838a, LSL #16
    SUB  X23, X24, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP02_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X6, X8, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X13, #0x3c0, LSL #0
    MOVK  X13, #0x29a8, LSL #16
    MOVK  X13, #0xeec1, LSL #32
    MOVK  X13, #0xf8be, LSL #48
    SUB  X9, X13, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X15
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X29, #0x21, LSL #0
    SUB  X13, X29, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP02_TestFail
    MOVZ  X23, #0x3fff, LSL #0
    MOVK  X23, #0x102e, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X16, X23, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X9, X20, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X22, #0xc000, LSL #0
    MOVK  X22, #0x41f0, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X7, X22, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X3, #0xc000, LSL #0
    MOVK  X3, #0x41f0, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X25, X3, X22
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP02_TestFail
    MOVZ  X2, #0x3fff, LSL #0
    MOVK  X2, #0x102e, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X29, X2, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X5, X12, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP02_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0x102e, LSL #16
    SUB  X23, X14, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP02_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
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
    MOVZ  X10, #0xa, LSL #0
TaishanIntMduP02_label_440:
    ADDS  W15, W27, #0xa8e, LSL #12
    UMSUBL  X5, W2, W18, X19
    ADCS  W25, W16, W28
    ADD  X11, X26, X3, LSL #11
    EOR  X21, X20, X9, ROR #57
    EOR  X27, X24, #0x7ffffe00
    ORR  W14, W8, #0xf0f0f0f0
    SUB  X23, X25, X5, LSL #3
    CSINC  W27, W12, W12, CS
    EOR  W6, W20, #0x1e00
    ANDS  W18, W19, #0x800007ff
    CLS  W15, W21
    CSINC  W11, W23, W6, NE
    SMADDL  X9, W27, W15, X23
    LSLV  X6, X11, X17
    CSNEG  X11, X23, X14, HI
    MOVK  W6, #0x3164, LSL #0
    CSEL  X17, X17, X18, GT
    CSNEG  X26, X5, X8, LS
    AND  W21, W11, #0x1fc0
    CSNEG  W24, W21, W10, VC
    UMADDL  X12, W7, W24, X26
    CLS  X25, X17
    ADCS  W12, W23, W14
    SMSUBL  X5, W12, W25, X29
    ADC  X14, X28, X19
    MADD  W24, W2, W11, W11
    BICS  W5, W11, W18, ROR #3
    AND  W8, W20, #0x3f00000
    ADDS  W24, W3, W23, ASR #3
    CLZ  V15.8H, V2.8H
    CSINV  X24, X9, X6, AL
    CLS  W6, W22
    SUBS  X25, X8, X27, LSR #42
    BICS  W15, W22, W25, LSR #31
    UBFM  X14, X14, #0x2, #0x1e
    CSINC  X12, X28, X27, EQ
    MADD  W23, W22, W18, W10
    CRC32W  W17, W12, W26
    EXTR  X11, X24, X15, #0x1e
    MOVK  W6, #0x6ded, LSL #16
    ADDS  X22, X14, #0x1c, LSL #12
    BICS  W11, W22, W18, ROR #2
    ORR  X17, X7, #0xff0fff0fff0fff0f
    SUB  X28, X3, W6, UXTW #2
    LSRV  W16, W7, W20
    CRC32CH  W11, W18, W28
    EOR  W21, W5, W24, ASR #22
    MADD  W28, W10, W7, W23
    EON  X6, X23, X24
    UMADDL  X5, W29, W17, X3
    SUB  W17, W14, W25, LSL #10
    MOVK  X27, #0x3b86, LSL #32
    SUB  W27, W15, W7, ASR #11
    ANDS  X2, X21, X16, ROR #12
    ORN  W8, W14, W6, ROR #14
    EOR  W3, W26, W23, LSL #8
    EXTR  W29, W14, W9, #0x1d
    SMSUBL  X17, W2, W5, X3
    ORR  V27.4H, #0xed, LSL #8
    CSNEG  W13, W28, W10, CS
    SBFM  X14, X21, #0x2b, #0x39
    ORR  V24.2S, #0x15
    CSNEG  W26, W15, W12, VC
    MOVK  X6, #0x3f3b, LSL #32
    SUBS  X16, X19, X15, ASR #50
    MADD  X27, X28, X21, X24
    CLZ  X5, X23
    EOR  W2, W10, W8, ROR #17
    SUBS  W24, W23, #0x0
    EOR  X11, X14, #0xffffffffffe0000f
    ADDS  X28, X12, W9, UXTB #3
    EOR  W26, W14, #0xffe1ffff
    CLZ  X3, X19
    CRC32W  W7, W6, W23
    UMADDL  X23, W11, W6, X14
    ORN  W15, W23, W7, LSR #18
    ORR  W11, W29, #0xc3c3c3c3
    BICS  W19, W23, W24, LSR #11
    SMADDL  X9, W10, W8, X24
    CLZ  X7, X23
    CSINV  W15, W14, W28, GT
    SUBS  W9, W11, W3, LSL #4
    CSINV  X21, X16, X29, CS
    MOVN  X19, #0x8a61, LSL #16
    ASRV  X19, X28, X27
    LSLV  W27, W18, W28
    EXTR  W20, W29, W27, #0xb
    CSINC  X2, X2, X12, AL
    CRC32CW  W21, W14, W12
    ORN  W22, W21, W7, LSR #20
    MOVN  X29, #0x5b7, LSL #48
    ORR  X27, X21, X3, ROR #34
    SUBS  W15, W24, W2, ASR #2
    MADD  X24, X26, X20, X23
    AND  X14, X29, X5, LSR #40
    ADD  W18, W23, W2, ASR #31
    SUBS  X18, X18, #0x783
    EOR  X17, X10, #0x3e0000003e
    ANDS  W19, W22, W28, ROR #28
    ORR  V18.2S, #0xb6, LSL #16
    SUB  X21, X21, #0xeb8, LSL #12
    UBFM  W19, W19, #0x15, #0x16
    ADD  W9, W16, #0x185, LSL #12
    UMSUBL  X18, W25, W3, X22
    UMSUBL  X29, W24, W14, X7
    UMSUBL  X3, W15, W5, X12
    SUB  X17, X28, #0xe66, LSL #12
    ADD  W29, W19, W11, SXTW #4
    CRC32B  W19, W25, W8
    UBFM  X28, X16, #0x2f, #0x17
    SUB  X26, X17, X25, ASR #60
    SBFM  X11, X27, #0x3a, #0x1d
    MOVN  W3, #0x11b3, LSL #0
    MADD  W3, W7, W17, W11
    CSEL  X28, X15, X18, MI
    CRC32CX  W21, W21, X24
    ORR  X27, X19, #0xffffc3ffffffc3ff
    ADDS  W9, W14, W17
    BICS  X25, X14, X5, LSR #13
    ADDS  X14, X27, #0x5fd, LSL #12
    EOR  X27, X10, #0xe00fe00fe00fe00f
    ADDS  X20, X28, #0x598, LSL #12
    CSINC  X11, X3, X10, CS
    ADDS  X25, X18, X12, LSR #41
    SUBS  X2, X19, W18, UXTB #0
    EXTR  W12, W9, W3, #0xd
    ASRV  W6, W19, W18
    ADD  W29, W22, W29, SXTB #0
    MOVK  W16, #0x45f8, LSL #16
    CSNEG  X19, X18, X2, GE
    CSINV  W3, W12, W16, VC
    ANDS  W2, W6, W24, LSR #3
    CLS  W15, W3
    ORR  V8.8H, #0xbb
    CLS  W12, W27
    ADCS  W5, W27, W24
    SUB  X25, X5, X22, ASR #14
    EOR  X2, X29, #0x2222222222222222
    BIC  V1.8B, V1.8B, V2.8B
    LSLV  W21, W7, W11
    ASRV  W25, W10, W19
    ORN  W20, W25, W15
    ADD  W18, W11, W28, SXTW #1
    CRC32CB  W20, W28, W3
    UBFM  W17, W29, #0x19, #0x1a
    MADD  X15, X29, X10, X22
    BICS  X29, X10, X10, ROR #28
    CSINC  W22, W22, W18, MI
    ADDS  W25, W11, W10, LSR #12
    ORR  V3.8H, #0xae
    CRC32X  W15, W3, X5
    ADC  X21, X10, X13
    CSNEG  X24, X17, X2, VS
    EOR  X5, X27, #0x1f8000001f800
    BIC  V0.16B, V27.16B, V28.16B
    SUBS  X3, X3, #0xaed, LSL #12
    BIC  X22, X7, X15, LSR #10
    ORN  X25, X28, X11, ASR #13
    AND  W23, W3, #0xf001ffff
    CRC32CX  W17, W29, X24
    EON  X21, X5, X10, ASR #28
    SUBS  W11, W15, #0x141
    EXTR  X20, X9, X29, #0x3e
    ADD  X6, X17, #0x21e, LSL #12
    MADD  X21, X20, X24, X10
    SUBS  X25, X15, X22, LSL #14
    ADD  X11, X14, #0x43f
    CRC32B  W23, W28, W9
    LSLV  W24, W15, W23
    SUB  X13, X17, X6, SXTX #0
    MOVZ  X13, #0x52f0, LSL #48
    SMULH  X19, X25, X24
    AND  W14, W9, #0x1ffffffc
    ORN  X15, X7, X21, ROR #34
    BIC  V13.8B, V28.8B, V16.8B
    BICS  W16, W22, W11, ASR #10
    AND  W16, W6, W18
    ANDS  W23, W15, W20, ASR #8
    MOVK  W23, #0x5537, LSL #0
    ORR  W12, W16, #0xffc0003f
    SUBS  X26, X12, X10, ASR #24
    LSLV  X13, X28, X29
    MADD  X2, X21, X11, X9
    CRC32B  W12, W18, W19
    ORN  W20, W15, W17, ASR #10
    ADCS  W19, W8, W7
    CSEL  W20, W5, W13, MI
    CLS  V23.2S, V19.2S
    ADD  W23, W26, #0x9cf
    LSLV  X14, X23, X23
    EOR  X8, X19, X25, ROR #6
    EOR  X13, X24, #0xffff0000ffff0000
    SUB  W20, W18, #0xc4a, LSL #12
    SMULH  X12, X3, X8
    AND  X5, X21, X20, ASR #39
    ANDS  X26, X12, #0xffc000ffffc000ff
    LSLV  X25, X13, X7
    SUB  W23, W14, #0xd24, LSL #12
    ORR  X26, X3, X6, LSR #38
    SUBS  X10, X10, #0x1
    B.NE  TaishanIntMduP02_label_440
    MOVZ  X14, #0x99e1, LSL #0
    MOVK  X14, #0x3bfa, LSL #16
    MOVK  X14, #0x7621, LSL #32
    MOVK  X14, #0xec14, LSL #48
    SUB  X26, X14, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X18, #0x5f54, LSL #0
    MOVK  X18, #0x242d, LSL #16
    SUB  X7, X18, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X8, #0xe918, LSL #0
    MOVK  X8, #0x714, LSL #16
    SUB  X2, X8, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X22, #0xe918, LSL #0
    MOVK  X22, #0x714, LSL #16
    SUB  X2, X22, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X6, X18, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X3, #0xa43e, LSL #0
    MOVK  X3, #0x5f, LSL #16
    MOVK  X3, #0xc400, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X9, X3, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X7, #0xa257, LSL #0
    MOVK  X7, #0x87a, LSL #16
    SUB  X15, X7, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x3fff, LSL #16
    MOVK  X10, #0xffff, LSL #48
    SUB  X21, X10, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X29, #0x99e1, LSL #0
    MOVK  X29, #0x3bfa, LSL #16
    MOVK  X29, #0x7621, LSL #32
    MOVK  X29, #0xec14, LSL #48
    SUB  X19, X29, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X25, X20, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X27, X14, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X19
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP02_TestFail
    MOVZ  X27, #0x4000, LSL #0
    MOVK  X27, #0x1b1, LSL #16
    SUB  X6, X27, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X2, #0x4000, LSL #0
    MOVK  X2, #0x1b1, LSL #16
    SUB  X27, X2, X27
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0x93ff, LSL #16
    SUB  X16, X21, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X26, X9, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
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
TaishanIntMduP02_label_467:
    CRC32B  W10, W17, W27
    CLZ  V16.2S, V29.2S
    SUBS  X28, X23, X5, ASR #54
    ANDS  W20, W26, W26, LSL #24
    ANDS  X21, X12, X28, ASR #17
    BIC  V28.8B, V17.8B, V10.8B
    LSLV  W21, W17, W25
    CRC32CX  W29, W24, X20
    AND  X26, X3, #0x3fff00003fff
    MOVK  W21, #0xb44b, LSL #0
    ADDS  X26, X20, X14, LSR #32
    ORN  W16, W12, W20, ROR #3
    SMSUBL  X29, W21, W28, X22
    BIC  V28.16B, V24.16B, V28.16B
    ADDS  X17, X8, #0x5e2
    ADDS  X23, X22, X26
    ORR  W18, W28, #0xf000f0
    ORR  V25.2S, #0x8e, LSL #24
    SUBS  X12, X16, W24, SXTW #1
    ORR  X28, X6, #0x3e003e003e003e00
    ASRV  W23, W27, W12
    AND  W29, W12, #0x3ff0000
    CSEL  W21, W9, W11, LT
    AND  X18, X11, X14, ROR #50
    ADC  X17, X3, X29
    ADDS  X8, X9, #0xea0
    ADD  X22, X23, X16, UXTX #2
    CSEL  X24, X12, X27, CS
    SUB  X16, X21, X27, ASR #16
    SUBS  X13, X18, W12, UXTW #3
    CRC32X  W11, W6, X25
    AND  X24, X15, #0x3ffff8000000
    SMADDL  X24, W16, W17, X21
    UMADDL  X10, W11, W24, X17
    ASRV  W9, W12, W27
    ORR  X28, X13, #0x1fff80001fff80
    SUB  W17, W23, W8, UXTH #2
    UBFM  X17, X24, #0x4, #0x2a
    CSINV  X29, X11, X17, VS
    CSINC  X9, X29, X22, VS
    CLS  V10.16B, V4.16B
    EOR  X16, X18, X3, LSL #10
    ADD  X20, X22, X9, LSL #26
    CRC32W  W20, W14, W23
    SUB  X20, X15, #0x6e2
    ADDS  X28, X25, W23, UXTH #0
    EOR  W6, W19, #0xff07ff07
    CSNEG  X28, X26, X16, LT
    ADDS  W18, W24, #0x8e3, LSL #12
    MOVZ  X6, #0xc4ed, LSL #32
    SUBS  X14, X21, #0x5d8, LSL #12
    SUBS  W10, W10, W3, UXTB #1
    CLS  W2, W15
    CRC32CH  W7, W27, W19
    MOVZ  W24, #0xab5d, LSL #0
    ADC  W16, W10, W16
    ANDS  X11, X23, X8, ASR #31
    MOVZ  W9, #0x81e, LSL #0
    EON  X2, X10, X17, ROR #28
    ADC  W14, W15, W10
    SBFM  X22, X21, #0x3a, #0x12
    EXTR  X13, X23, X23, #0xe
    MADD  X6, X21, X22, X26
    MOVN  X21, #0xdab1, LSL #16
    SUBS  W23, W12, W22, LSR #22
    ADD  X10, X25, W26, UXTB #1
    EOR  W29, W6, #0xf9fff9ff
    SUB  W10, W6, #0x2d1, LSL #12
    SBFM  W24, W12, #0x11, #0x15
    SUBS  X5, X10, #0x78b, LSL #12
    SUB  X18, X17, W23, UXTW #2
    ORN  W14, W23, W12, LSR #17
    MOVZ  W10, #0x6b50, LSL #16
    SMADDL  X10, W7, W12, X19
    CRC32CX  W15, W29, X3
    ADD  X25, X23, X3, SXTX #1
    SUBS  W17, W14, W22, LSL #23
    CSNEG  W5, W25, W7, CC
    SUB  X10, X10, W14, SXTW #1
    ADCS  X24, X15, X26
    AND  W16, W25, #0x1fffffff
    EXTR  W3, W10, W14, #0x5
    ADD  W18, W5, W25, LSR #3
    ADC  W24, W21, W3
    ORN  W26, W24, W18, LSL #16
    ADDS  W26, W25, W22, LSR #11
    ADD  X12, X12, X28, LSR #17
    MOVN  X28, #0xdcb9, LSL #48
    EON  X24, X2, X6, LSL #7
    MOVK  X16, #0x7566, LSL #0
    ORN  X11, X26, X29, LSL #36
    UBFM  X28, X26, #0x14, #0x1b
    CLZ  W12, W9
    ADC  X17, X22, X24
    ADD  X16, X18, #0xadd, LSL #12
    ADD  X10, X7, #0xd80
    CRC32X  W3, W24, X23
    ADD  W9, W25, W26, UXTB #3
    ADD  W11, W14, W24, UXTX #2
    CRC32B  W17, W19, W6
    ADD  X24, X19, X20, LSR #43
    ADDS  W8, W2, W5, LSR #26
    SUB  X16, X12, X29, LSR #29
    CRC32CW  W14, W20, W29
    MOVN  W13, #0xbd46, LSL #16
    ANDS  X19, X19, #0x1e0000001e
    MADD  W28, W29, W12, W28
    ADDS  X8, X15, X29, ASR #28
    MOVK  W21, #0x47ff, LSL #0
    CRC32X  W16, W15, X26
    SUB  X14, X21, W5, UXTH #1
    AND  X15, X21, #0xffe001ffffe001ff
    ADDS  W9, W22, W24, LSR #20
    ORR  W7, W21, W28, LSL #23
    SUB  X6, X7, W6, UXTH #4
    ADD  W17, W8, W9, UXTH #4
    AND  W24, W16, #0x7c7c7c7c
    BICS  X6, X13, X24, ASR #45
    CSINV  W25, W7, W15, VC
    SUB  X23, X7, X29, ASR #62
    SBFM  W24, W20, #0x0, #0x10
    SUB  W23, W17, W10, LSL #6
    CSNEG  W2, W19, W23, LE
    SUB  W25, W6, W10, ASR #27
    CSEL  X5, X29, X13, NE
    CLZ  V26.8H, V19.8H
    ADDS  X6, X6, #0x880
    CRC32CB  W19, W18, W26
    SUBS  W11, W26, W22, ASR #23
    CSNEG  W16, W2, W6, HI
    ORR  W18, W3, #0x7ffffc0
    SUB  W24, W24, W13, UXTB #2
    SUBS  X25, X8, #0x820
    EXTR  W19, W21, W18, #0xb
    SUB  W25, W20, W19, LSR #21
    ORR  X25, X15, #0xf800f800f800f800
    BIC  X10, X9, X11, LSL #58
    CRC32B  W28, W17, W19
    AND  W10, W26, #0x3fff
    EOR  X2, X26, #0x1fffff001fffff
    SUB  W12, W18, W23, SXTH #1
    ADDS  X16, X2, X27, SXTX #4
    SUBS  X2, X29, #0xebb
    EOR  X26, X22, #0xf800000003ffffff
    UBFM  X22, X11, #0x3, #0x1c
    MOVN  X16, #0xa2b2, LSL #0
    ORN  W11, W11, W20, LSR #25
    ADD  W10, W10, W23, LSR #8
    ADD  X6, X10, W27, UXTB #0
    ORR  W2, W28, W11, ROR #16
    CRC32B  W3, W16, W10
    BICS  X21, X25, X22, ROR #5
    ANDS  W10, W6, #0x7fc07fc0
    MOVZ  W23, #0x73c8, LSL #0
    LSLV  X12, X14, X5
    MADD  W16, W27, W19, W22
    CSINC  W14, W7, W27, LE
    BIC  W28, W27, W14, LSR #19
    SUB  X7, X16, W22, UXTH #3
    SBFM  X21, X5, #0x18, #0x21
    CSINV  W10, W28, W10, HI
    ASRV  X7, X28, X10
    ADD  W29, W5, #0x937
    MOVZ  X12, #0x6f7, LSL #48
    SMADDL  X12, W29, W16, X13
    CRC32H  W19, W8, W20
    CRC32X  W15, W22, X15
    CRC32H  W13, W27, W27
    ANDS  X7, X19, X21, LSL #10
    AND  W11, W2, W29, ROR #26
    SMSUBL  X26, W26, W22, X16
    CLZ  W22, W16
    EON  W29, W24, W12, ROR #17
    SUB  W6, W8, W28, UXTX #0
    MOVZ  X19, #0x41dd, LSL #48
    AND  W6, W10, W15, LSR #18
    UBFM  W16, W12, #0x2, #0x1b
    MOVZ  X2, #0xb314, LSL #16
    SUBS  X26, X18, X19, LSR #37
    AND  X16, X21, X2, LSL #4
    SUBS  W22, W5, W6, ASR #25
    CRC32CW  W6, W25, W22
    EON  W5, W26, W19, ASR #6
    SUB  W8, W27, W17, SXTH #3
    UBFM  X20, X29, #0x2b, #0x30
    CRC32H  W29, W14, W18
    MOVK  W16, #0xb623, LSL #16
    MOVK  W8, #0xab11, LSL #16
    UBFM  X5, X19, #0x3d, #0xb
    ADD  X19, X5, X9, LSR #22
    CSINC  X22, X20, X9, GE
    ADDS  W29, W15, #0x16f
    SMULH  X18, X18, X8
    SUB  X20, X16, W25, UXTW #0
    SMSUBL  X6, W22, W22, X27
    ADDS  W29, W17, #0xd5f
    ADDS  W16, W2, W17, SXTX #0
    ADCS  W25, W10, W16
    UMULH  X11, X14, X2
    SBFM  X19, X18, #0x27, #0x3c
    SUBS  X27, X27, #0x1
    B.NE  TaishanIntMduP02_label_467
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xb314, LSL #16
    SUB  X22, X9, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP02_TestFail
    MOVZ  X25, #0x5cfb, LSL #0
    MOVK  X25, #0x244b, LSL #16
    SUB  X15, X25, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X15, #0x1, LSL #0
    SUB  X26, X15, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X9, #0x4000, LSL #0
    SUB  X25, X9, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x1791, LSL #0
    MOVK  X20, #0xab11, LSL #16
    SUB  X29, X20, X8
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X27, #0x4000, LSL #0
    SUB  X26, X27, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X11, #0xb27f, LSL #0
    MOVK  X11, #0xffbf, LSL #16
    SUB  X9, X11, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X28, #0xb27f, LSL #0
    MOVK  X28, #0xffbf, LSL #16
    SUB  X23, X28, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP02_TestFail
    MOVZ  X6, #0x7efb, LSL #0
    MOVK  X6, #0x2929, LSL #16
    MOVK  X6, #0xa360, LSL #32
    MOVK  X6, #0x1b, LSL #48
    SUB  X12, X6, X12
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X11, X3, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x2, LSL #0
    SUB  X6, X20, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X3, #0x1, LSL #0
    SUB  X9, X3, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X15, #0x5d0e, LSL #0
    MOVK  X15, #0xef60, LSL #16
    SUB  X26, X15, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X18, #0x5d0e, LSL #0
    MOVK  X18, #0x3c4c, LSL #16
    SUB  X2, X18, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X3, #0x5d0e, LSL #0
    MOVK  X3, #0x3c4c, LSL #16
    SUB  X27, X3, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X6, #0x2, LSL #0
    SUB  X3, X6, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X18, #0x3c, LSL #0
    SUB  X22, X18, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X24, #0xe007, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X9, X24, X24
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X5, X17, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X2, #0xb27f, LSL #0
    MOVK  X2, #0xffbf, LSL #16
    SUB  X8, X2, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP02_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X20, X28, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X2, #0xa863, LSL #0
    MOVK  X2, #0xd7cc, LSL #16
    MOVK  X2, #0x63a, LSL #32
    MOVK  X2, #0x7d39, LSL #48
    MOVZ  X3, #0x8775, LSL #0
    MOVK  X3, #0x3ca8, LSL #16
    MOVK  X3, #0x7efa, LSL #32
    MOVK  X3, #0xa078, LSL #48
    MOVZ  X5, #0x2282, LSL #0
    MOVK  X5, #0x87bd, LSL #16
    MOVK  X5, #0x2e52, LSL #32
    MOVK  X5, #0x644a, LSL #48
    MOVZ  X6, #0xfd04, LSL #0
    MOVK  X6, #0x164e, LSL #16
    MOVK  X6, #0x7e8e, LSL #32
    MOVK  X6, #0x2c49, LSL #48
    MOVZ  X7, #0x8df3, LSL #0
    MOVK  X7, #0x65e8, LSL #16
    MOVK  X7, #0x9fc, LSL #32
    MOVK  X7, #0x3e97, LSL #48
    MOVZ  X8, #0xbcd5, LSL #0
    MOVK  X8, #0x9d07, LSL #16
    MOVK  X8, #0xa7d7, LSL #32
    MOVK  X8, #0x2837, LSL #48
    MOVZ  X9, #0xc95c, LSL #0
    MOVK  X9, #0xc90, LSL #16
    MOVK  X9, #0x763f, LSL #32
    MOVK  X9, #0x2fe7, LSL #48
    MOVZ  X10, #0x2485, LSL #0
    MOVK  X10, #0xfe16, LSL #16
    MOVK  X10, #0x14ec, LSL #32
    MOVK  X10, #0xc5a9, LSL #48
    MOVZ  X11, #0xad92, LSL #0
    MOVK  X11, #0xc294, LSL #16
    MOVK  X11, #0x7308, LSL #32
    MOVK  X11, #0x99b2, LSL #48
    MOVZ  X12, #0x8472, LSL #0
    MOVK  X12, #0x103e, LSL #16
    MOVK  X12, #0xbcf9, LSL #32
    MOVK  X12, #0xb2b8, LSL #48
    MOVZ  X13, #0xf9ce, LSL #0
    MOVK  X13, #0x882b, LSL #16
    MOVK  X13, #0x2b9c, LSL #32
    MOVK  X13, #0x3a94, LSL #48
    MOVZ  X14, #0x2cf8, LSL #0
    MOVK  X14, #0xaaad, LSL #16
    MOVK  X14, #0x540c, LSL #32
    MOVK  X14, #0x6d9f, LSL #48
    MOVZ  X15, #0x8b8, LSL #0
    MOVK  X15, #0x1a29, LSL #16
    MOVK  X15, #0x943f, LSL #32
    MOVK  X15, #0x6be9, LSL #48
    MOVZ  X16, #0xb47d, LSL #0
    MOVK  X16, #0xcf44, LSL #16
    MOVK  X16, #0xf3a1, LSL #32
    MOVK  X16, #0x86d9, LSL #48
    MOVZ  X17, #0xdb95, LSL #0
    MOVK  X17, #0x3973, LSL #16
    MOVK  X17, #0x3e84, LSL #32
    MOVK  X17, #0x5e01, LSL #48
    MOVZ  X18, #0x683d, LSL #0
    MOVK  X18, #0x3fb5, LSL #16
    MOVK  X18, #0xacbf, LSL #32
    MOVK  X18, #0xc93, LSL #48
    MOVZ  X19, #0x2aa, LSL #0
    MOVK  X19, #0xc57a, LSL #16
    MOVK  X19, #0x7f75, LSL #32
    MOVK  X19, #0x3850, LSL #48
    MOVZ  X20, #0xfe3a, LSL #0
    MOVK  X20, #0x49ef, LSL #16
    MOVK  X20, #0xa9e1, LSL #32
    MOVK  X20, #0x6697, LSL #48
    MOVZ  X21, #0x8ac5, LSL #0
    MOVK  X21, #0x2221, LSL #16
    MOVK  X21, #0xf7d1, LSL #32
    MOVK  X21, #0x2080, LSL #48
    MOVZ  X22, #0xf918, LSL #0
    MOVK  X22, #0xc4ed, LSL #16
    MOVK  X22, #0x651e, LSL #32
    MOVK  X22, #0x89e1, LSL #48
    MOVZ  X23, #0xb21c, LSL #0
    MOVK  X23, #0xb63a, LSL #16
    MOVK  X23, #0xb7fc, LSL #32
    MOVK  X23, #0xb2cc, LSL #48
    MOVZ  X24, #0x8976, LSL #0
    MOVK  X24, #0xd6e9, LSL #16
    MOVK  X24, #0x8dbc, LSL #32
    MOVK  X24, #0x8520, LSL #48
    MOVZ  X25, #0xc3c, LSL #0
    MOVK  X25, #0x9c4c, LSL #16
    MOVK  X25, #0xf2a9, LSL #32
    MOVK  X25, #0xcf5, LSL #48
    MOVZ  X26, #0xea98, LSL #0
    MOVK  X26, #0xa9d1, LSL #16
    MOVK  X26, #0x2e4c, LSL #32
    MOVK  X26, #0xa2b2, LSL #48
    MOVZ  X27, #0xadd3, LSL #0
    MOVK  X27, #0x8d58, LSL #16
    MOVK  X27, #0xaa61, LSL #32
    MOVK  X27, #0x9ced, LSL #48
    MOVZ  X28, #0xdf92, LSL #0
    MOVK  X28, #0xce8e, LSL #16
    MOVK  X28, #0x19bd, LSL #32
    MOVK  X28, #0xa008, LSL #48
    MOVZ  X29, #0x7f0, LSL #0
    MOVK  X29, #0x6284, LSL #16
    MOVK  X29, #0x1b83, LSL #32
    MOVK  X29, #0xd40d, LSL #48
    MOVZ  X3, #0xa, LSL #0
TaishanIntMduP02_label_495:
    SUBS  W22, W25, W28, UXTW #1
    CSNEG  W29, W3, W29, GE
    CSEL  W7, W26, W14, HI
    ADDS  W13, W29, W27, LSL #15
    MOVZ  X27, #0xa22e, LSL #16
    SUB  W10, W23, W19, ASR #2
    AND  X14, X22, X28, ROR #23
    EXTR  X14, X9, X13, #0x3c
    MADD  X2, X14, X15, X2
    ORN  W19, W19, W24, ASR #16
    CSNEG  X26, X14, X12, LT
    ADD  X26, X6, X5, ASR #2
    LSLV  X13, X10, X18
    EOR  X12, X20, #0x303030303030303
    BIC  X15, X22, X20, ASR #29
    ADDS  X18, X5, X24, UXTX #1
    SBFM  W11, W22, #0x1e, #0x17
    ADDS  W5, W5, #0x607, LSL #12
    LSRV  X27, X23, X13
    BIC  W28, W18, W28, ASR #31
    UMSUBL  X5, W11, W19, X24
    CRC32CH  W9, W5, W12
    ADCS  X17, X13, X2
    ADDS  X18, X7, X2, UXTX #3
    LSLV  X10, X17, X20
    ADC  W9, W16, W18
    CSINC  W22, W20, W14, LE
    CSNEG  X9, X27, X21, EQ
    ADD  X10, X10, W2, SXTB #3
    SUB  X10, X6, #0xc37
    CLZ  X12, X16
    SUB  W15, W21, #0xe98, LSL #12
    CLS  X12, X21
    ANDS  W17, W17, W7, ROR #3
    ORR  W8, W12, W8, ROR #3
    SUB  X10, X19, X28, SXTX #4
    LSRV  W19, W15, W9
    ORN  W5, W10, W10, ROR #15
    ADD  X23, X15, W16, UXTB #0
    CRC32CH  W23, W2, W3
    BIC  V4.8B, V21.8B, V22.8B
    LSRV  W27, W26, W27
    SUBS  X27, X11, W23, UXTH #4
    MOVZ  W11, #0xd39c, LSL #16
    ADD  X18, X27, X10, LSL #16
    ANDS  X11, X11, X19, LSR #5
    AND  W19, W6, #0xffffc00f
    ORN  X28, X6, X5, ROR #52
    ADCS  W21, W19, W29
    ORR  V31.2S, #0x93, LSL #16
TaishanIntMduP02_label_243:
    AND  W29, W22, W7, LSR #7
    SBFM  X14, X24, #0x13, #0x3
TaishanIntMduP02_label_249:
    SUBS  X21, X5, #0xe36
    CRC32CH  W5, W22, W18
    BICS  X28, X21, X8, LSL #6
    EOR  X28, X9, #0xfffff00000000001
    ORR  W21, W16, #0x10001
    AND  X12, X10, #0x3838383838383838
    CRC32CH  W8, W28, W7
    BICS  X14, X21, X13, LSR #55
    ORN  X14, X19, X2, LSR #23
    UMSUBL  X20, W11, W22, X10
    CLZ  W5, W14
    SUB  W5, W11, #0x6c0
    SMADDL  X10, W11, W11, X8
    AND  W12, W17, W26, ASR #25
    SUBS  W14, W10, W26, UXTH #4
    MOVK  W29, #0xbaa8, LSL #0
    LSLV  W19, W22, W18
    SUBS  W20, W5, W2, SXTW #2
    SUB  X8, X24, X19, SXTX #1
    UMULH  X8, X20, X23
    EON  W20, W19, W7, LSR #16
    SUBS  X12, X13, W17, UXTW #3
    SMADDL  X2, W18, W26, X6
    MOVN  W23, #0x9d8, LSL #16
    ANDS  W17, W23, #0xc0c0c0c
    ADDS  X23, X21, X23, ASR #35
    CRC32CB  W26, W12, W16
    EXTR  W17, W6, W3, #0xa
    ADD  W29, W10, #0xd20
    SBFM  W22, W17, #0x12, #0x19
    EON  W17, W11, W26, LSR #1
    ANDS  X17, X11, #0xfff0000000000000
    AND  W6, W20, #0x40004
    EXTR  X5, X28, X8, #0xe
    SBFM  W2, W5, #0x4, #0x1b
    ADC  X27, X10, X17
    ASRV  W8, W22, W24
    LSRV  W14, W7, W14
    CRC32CB  W18, W12, W25
    ADD  W25, W29, W20, SXTW #0
    CSINC  W8, W28, W23, AL
    CRC32CB  W29, W28, W10
    SUB  W20, W22, W12, LSL #25
    UMULH  X6, X27, X9
    CRC32X  W7, W3, X19
    CRC32CB  W20, W7, W18
    MOVZ  W5, #0x325, LSL #16
    BIC  X6, X23, X26, ROR #38
    ORR  X21, X10, #0xff8fffffffffffff
    MADD  W11, W23, W3, W3
    ORR  V0.4S, #0x83, LSL #16
    SUBS  W28, W27, W21, LSL #26
    ADC  W18, W5, W6
    CRC32CX  W18, W16, X20
    CRC32CX  W25, W9, X29
    SUBS  W16, W20, W12, UXTW #4
    BICS  X18, X16, X10, ROR #6
    ADDS  W14, W5, #0x310
    CLZ  W24, W26
    SMULH  X27, X20, X26
    MADD  W21, W22, W28, W16
    ADDS  X2, X3, X29, ASR #55
    MOVK  W12, #0x15a2, LSL #0
    ANDS  X28, X25, #0xfffe000
    MOVK  W29, #0x8f02, LSL #16
    UMULH  X23, X14, X24
    ORR  X6, X19, X28, LSL #23
    CSEL  W20, W11, W11, CC
    ADD  W8, W19, W14, ASR #5
    SUB  W23, W19, W5, LSR #8
    SUBS  X29, X23, X18, ASR #12
    ADCS  X6, X16, X15
    LSRV  W18, W29, W28
    CLS  V15.4S, V15.4S
    ADDS  W19, W12, W5, SXTH #3
    EON  X23, X13, X17, ASR #19
    EON  W20, W6, W27, LSL #21
    ADDS  W29, W6, W24, SXTH #0
    BICS  X24, X19, X23, LSR #6
    SUB  W25, W25, #0xd49
    UBFM  W12, W6, #0xa, #0x16
    SUB  X13, X11, #0x81c
    CSINC  X6, X29, X22, LS
    CRC32W  W8, W2, W14
    ADC  X20, X12, X17
    CLZ  X20, X18
    ORR  W25, W14, W3, ASR #6
    EOR  X26, X29, X25, LSR #31
    CLZ  W10, W7
    AND  X22, X14, #0xffffffffffffe0
    ANDS  W23, W24, #0x1ffffc00
    AND  W11, W7, #0xff83ff83
    ASRV  W11, W17, W3
    ADD  X22, X25, #0xdc9
    EOR  W15, W8, #0x7f807f80
    UMULH  X27, X13, X12
    SUB  X2, X7, #0x92a, LSL #12
    BIC  W26, W22, W20, LSR #15
    CSEL  X8, X22, X19, NV
    ORR  V5.4S, #0x5c, LSL #24
    SUB  W29, W10, W27, SXTX #2
    UBFM  W28, W24, #0x0, #0x17
    CSEL  X5, X6, X29, LE
    ADD  W23, W14, W22, SXTB #3
    ADC  W23, W25, W17
    BIC  W23, W3, W8, ASR #25
    ORR  V14.8H, #0xea, LSL #8
    UBFM  X22, X22, #0xe, #0x8
    CLZ  V17.16B, V29.16B
    SUBS  X14, X9, X3, LSR #44
    BIC  V13.16B, V13.16B, V13.16B
    SUBS  X19, X12, W9, SXTB #3
    AND  X18, X11, X15, ASR #50
    ORR  V26.16B, V22.16B, V11.16B
    AND  W22, W28, #0xfff03fff
    MADD  W28, W10, W23, W15
    EON  W20, W27, W3, LSR #9
    EOR  X28, X14, #0xfc01fc01fc01fc01
    MADD  W19, W11, W7, W11
    EOR  X7, X9, X20, LSR #63
    ADC  W26, W11, W7
    CRC32CH  W9, W19, W12
    MOVN  W5, #0xff7d, LSL #16
    EXTR  W11, W27, W14, #0x2
    ADD  W13, W15, #0xc33
    UMULH  X12, X18, X8
    ASRV  X26, X13, X18
    ADDS  X5, X20, X10, LSR #28
    SMULH  X29, X25, X11
    CSEL  X23, X9, X14, CS
    ANDS  X26, X19, #0xbbbbbbbbbbbbbbbb
    SUBS  X28, X26, X2, LSL #18
    AND  X9, X5, X8, ASR #43
    EOR  X17, X7, X24, LSL #16
    AND  W14, W28, W12, ASR #21
    CSEL  X8, X26, X29, MI
    SUB  X14, X10, X6, ASR #7
    ORR  X7, X10, #0x1f8000001f800
    LSLV  W26, W29, W7
    CRC32W  W13, W2, W26
    ORR  W16, W17, W5, ASR #21
    ADDS  X21, X14, X11, LSR #62
    EOR  X5, X15, #0xfdfdfdfdfdfdfdfd
    ASRV  W20, W19, W5
    CLZ  W13, W9
    ADDS  W14, W21, #0x962, LSL #12
    MOVZ  W11, #0xed7e, LSL #0
    CLZ  X25, X20
    SUBS  X3, X3, #0x1
    B.NE  TaishanIntMduP02_label_495
    MOVZ  X13, #0x6000, LSL #0
    MOVK  X13, #0xff6d, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X12, X13, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X5, X20, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X29, #0x60ba, LSL #0
    MOVK  X29, #0x17e, LSL #16
    SUB  X17, X29, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP02_TestFail
    MOVZ  X12, #0xf820, LSL #0
    MOVK  X12, #0x1, LSL #16
    MOVK  X12, #0xf800, LSL #32
    MOVK  X12, #0x1, LSL #48
    SUB  X2, X12, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X10, #0x20, LSL #0
    SUB  X20, X10, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X13, #0xed7e, LSL #0
    SUB  X24, X13, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP02_TestFail
    MOVZ  X5, #0xf820, LSL #0
    MOVK  X5, #0x1, LSL #16
    MOVK  X5, #0xf800, LSL #32
    MOVK  X5, #0x1, LSL #48
    SUB  X22, X5, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP02_TestFail
    MOVZ  X20, #0xed7e, LSL #0
    SUB  X25, X20, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X19, #0x707e, LSL #0
    MOVK  X19, #0xe499, LSL #16
    SUB  X2, X19, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X26, X2, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X24, #0x707e, LSL #0
    MOVK  X24, #0xe499, LSL #16
    SUB  X12, X24, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP02_TestFail
    MOVZ  X17, #0xed7e, LSL #0
    SUB  X3, X17, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x35f, LSL #0
    MOVK  X20, #0xfffd, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X25, X20, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x8497, LSL #0
    MOVK  X20, #0x175, LSL #16
    SUB  X6, X20, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x707e, LSL #0
    MOVK  X26, #0xe499, LSL #16
    SUB  X5, X26, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X14, #0x707e, LSL #0
    MOVK  X14, #0xe499, LSL #16
    SUB  X29, X14, X26
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X22, X21, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP02_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
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
    MOVZ  X27, #0xa, LSL #0
TaishanIntMduP02_label_520:
    CRC32CX  W6, W11, X21
    ADDS  W2, W7, W29, SXTH #1
    ANDS  W8, W15, #0x3ffff00
    ORN  W24, W6, W12, LSR #23
    CRC32CH  W14, W25, W15
    ADD  X28, X7, X29, LSL #19
    ANDS  W6, W6, #0x70707070
    CSINV  W9, W14, W11, NE
    SUBS  W26, W5, #0x0
    ADD  W21, W18, W3, SXTX #2
    BIC  W13, W9, W6, LSR #6
    SMULH  X23, X29, X27
    MOVK  X13, #0xcc18, LSL #0
    SMULH  X28, X28, X6
    MOVN  W10, #0x5d43, LSL #16
    UBFM  W8, W9, #0x15, #0x6
    UMSUBL  X25, W27, W25, X8
    ORR  W15, W19, #0xc0ffffff
    LSRV  W23, W22, W22
    ADCS  W26, W23, W9
    CRC32CX  W24, W29, X21
    ADD  W9, W26, W22, LSR #0
    CSNEG  X13, X6, X8, VC
    LSRV  W18, W27, W6
    CRC32CX  W2, W7, X25
    SBFM  X2, X2, #0x18, #0x3c
    CLZ  W9, W6
    SMSUBL  X15, W6, W10, X12
    ASRV  W18, W26, W22
    CRC32B  W28, W3, W24
    EXTR  X10, X15, X16, #0x23
    ADC  W2, W24, W11
    BIC  V16.16B, V0.16B, V26.16B
    BIC  X25, X2, X2, ASR #36
    ORR  V22.4H, #0xf8, LSL #8
    SUBS  W19, W6, #0xc2e, LSL #12
    LSLV  W14, W3, W15
    EON  W7, W7, W16, ROR #17
    ORR  X29, X22, #0xffffffffc000007f
    CRC32W  W24, W15, W13
    EON  X24, X9, X18, LSL #17
    ADD  W2, W21, W8, LSL #22
    MOVK  X10, #0x159b, LSL #16
    ADDS  W29, W18, #0xde7
    CLZ  X23, X9
    ADDS  X15, X25, #0xc39, LSL #12
    ANDS  W26, W5, #0xfffffe
    CSINV  X14, X29, X29, CS
    EOR  X18, X28, X29, LSL #42
    ORR  W11, W24, W18, LSL #16
    ADD  W16, W17, W27, UXTB #3
    ORR  X20, X18, X7, ASR #43
    UBFM  W6, W6, #0xd, #0x5
    CSINC  W10, W25, W13, AL
    ADDS  W17, W9, W14, ASR #0
    SUBS  X12, X5, #0x4fb, LSL #12
    ORR  X11, X16, #0xff003fffff003fff
    SUBS  W9, W29, #0x5f9, LSL #12
    EXTR  X9, X10, X24, #0x3f
    SMSUBL  X15, W18, W29, X25
    SUBS  X17, X13, #0x866
    ORR  W26, W22, #0xfc00000f
    ADD  W3, W7, W28, SXTW #0
    SUB  W25, W19, W17, ASR #9
    ADCS  W6, W24, W15
    CLZ  W29, W14
    MOVN  X13, #0xba, LSL #0
    UMADDL  X28, W17, W26, X26
    LSRV  W25, W11, W3
    MOVK  W11, #0x312f, LSL #0
    EOR  X20, X18, #0x1fffffff1fffffff
    CRC32W  W8, W20, W13
    SUBS  X18, X28, W8, UXTB #0
    CRC32X  W9, W12, X24
    CSEL  W8, W28, W27, LE
    ADD  W18, W13, W25, SXTW #1
    ADD  W10, W10, #0xde4
    EON  W12, W11, W23, ROR #26
    MOVN  W5, #0xd863, LSL #16
    LSLV  X22, X24, X28
    ASRV  X11, X15, X15
    LSLV  X11, X13, X14
    SMSUBL  X3, W18, W22, X28
    CSNEG  X10, X6, X11, EQ
    SUBS  X13, X11, X12, ASR #40
    ORR  V8.4H, #0x4d, LSL #8
    CSINC  X22, X24, X7, HI
    ASRV  W8, W7, W19
    MADD  W10, W13, W12, W29
    ANDS  W18, W24, W23, LSL #11
    SUBS  W18, W26, #0x825
    ADC  W23, W11, W19
    ORR  W3, W6, #0x807fffff
    SMSUBL  X19, W12, W13, X27
    SUB  X14, X11, W11, SXTB #0
    UBFM  X28, X12, #0x23, #0x2b
    CRC32CH  W19, W8, W25
    CSINC  X9, X28, X24, MI
    CSINC  W15, W15, W26, GE
    ORR  X15, X29, #0xfffffffe000007ff
    CRC32CX  W16, W27, X19
    LSRV  X5, X8, X3
    CRC32CX  W14, W2, X18
    ANDS  W13, W22, W5, ROR #27
    EON  X9, X28, X10, ASR #35
    EOR  X15, X17, X25, LSL #57
    ASRV  W13, W8, W2
    ORR  V19.4H, #0x74, LSL #8
    ORR  V8.8H, #0x1b, LSL #8
    ORR  V24.8B, V3.8B, V16.8B
    ANDS  X14, X13, X17, ASR #26
    ADDS  X19, X14, #0xacb
    SUB  W19, W27, W7, LSR #27
    UMSUBL  X5, W19, W24, X3
    MOVN  W3, #0xa7e9, LSL #16
    CRC32B  W3, W26, W15
    ORR  V31.2S, #0xd6
    EON  X17, X18, X21, LSR #9
    ADC  X29, X29, X3
    SBFM  X25, X19, #0x28, #0x29
    SUB  W7, W12, W22, UXTH #0
    EOR  W14, W5, W3, LSL #11
    CRC32CB  W11, W17, W28
    BICS  X8, X9, X17, ROR #18
    CRC32W  W18, W28, W7
    ADDS  W10, W25, W18, UXTX #3
    ORN  X12, X20, X11, LSR #60
    ADD  X8, X11, W27, UXTB #3
    CSEL  W29, W19, W25, LS
    ORR  V30.4S, #0x59
    MADD  X14, X29, X24, X18
    ADCS  X14, X28, X18
    ADC  X25, X8, X28
    CRC32CW  W12, W9, W26
    CSINC  W13, W26, W27, LS
    CLZ  X25, X19
    SUBS  W17, W21, W9, SXTB #4
    CLS  X14, X7
    CRC32B  W29, W23, W20
    UMSUBL  X21, W7, W13, X6
    EOR  X8, X22, X20, LSR #60
    LSRV  W9, W11, W8
    CRC32W  W7, W24, W12
    MOVZ  X25, #0xf3e0, LSL #48
    LSLV  X9, X6, X9
    ADD  W17, W19, W21, ASR #15
    ORR  W3, W14, #0x40404040
    ASRV  W13, W20, W29
    ADDS  X25, X24, #0x577
    CRC32CX  W26, W7, X9
    SMADDL  X7, W21, W15, X23
    LSRV  W12, W6, W7
    EXTR  W13, W2, W2, #0x9
    CRC32CW  W25, W25, W28
    ADD  X22, X17, X28, LSR #53
    MADD  W24, W7, W27, W26
    MOVN  X12, #0x6d09, LSL #48
    BICS  W12, W9, W18, ASR #2
    SMULH  X3, X3, X13
    AND  W5, W19, #0x3ffffe00
    MOVK  X29, #0x2702, LSL #32
    SMADDL  X13, W2, W12, X29
    CLZ  V28.4H, V27.4H
    SUBS  W25, W23, #0x11e
    CRC32W  W20, W14, W22
    UMULH  X7, X13, X10
    ORR  V7.4H, #0x58
    CRC32CW  W7, W6, W20
    SUBS  X5, X28, #0x66d, LSL #12
    ADDS  W25, W26, W23, UXTW #0
    ADD  X8, X29, #0xb27
    CSEL  W26, W27, W18, AL
    CRC32CB  W14, W3, W29
    LSRV  W23, W10, W20
    LSRV  X21, X28, X19
    BICS  X11, X27, X24, LSL #16
    CSNEG  X18, X14, X19, HI
    BICS  X25, X20, X29, ROR #61
    AND  X22, X22, #0xf000f000f000f
    CSINC  W22, W7, W19, GT
    ORN  X29, X29, X12
    BIC  X13, X3, X3, ASR #46
    CRC32CX  W28, W17, X8
    ADD  W6, W22, W12, UXTH #4
    ADD  X26, X3, #0x96f, LSL #12
    CRC32CB  W22, W11, W17
    UBFM  W14, W12, #0x1b, #0x10
    CSEL  W5, W10, W5, PL
    AND  X8, X27, X25, ROR #54
    ADC  X14, X25, X22
    UMULH  X3, X22, X21
    CRC32CB  W6, W7, W18
    CLZ  W11, W11
    CLS  X25, X19
    MOVZ  W20, #0x2069, LSL #16
    SMULH  X20, X29, X23
    EON  X29, X17, X8, ROR #39
    SUB  W14, W27, W18, ASR #5
    EOR  X10, X20, #0xfffffc003fffffff
    LSRV  X26, X7, X18
    SUBS  X27, X27, #0x1
    B.NE  TaishanIntMduP02_label_520
    MOVZ  X3, #0x1d, LSL #0
    SUB  X6, X3, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X28, #0x1d, LSL #0
    SUB  X19, X28, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X27, #0x8ce0, LSL #0
    MOVK  X27, #0xa2db, LSL #16
    SUB  X14, X27, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X22, #0x4ea9, LSL #0
    MOVK  X22, #0x5cb0, LSL #16
    SUB  X8, X22, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X17, X14, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x2800, LSL #16
    MOVK  X25, #0xb1be, LSL #32
    MOVK  X25, #0x2a2, LSL #48
    SUB  X17, X25, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xc000, LSL #16
    MOVK  X11, #0x3ff, LSL #32
    SUB  X18, X11, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0xc000, LSL #16
    MOVK  X20, #0x3ff, LSL #32
    SUB  X27, X20, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x800, LSL #16
    SUB  X29, X6, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X21, #0x67da, LSL #0
    MOVK  X21, #0x7020, LSL #16
    MOVK  X21, #0xfe00, LSL #48
    SUB  X5, X21, X15
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP02_TestFail
    MOVZ  X9, #0x83cb, LSL #0
    MOVK  X9, #0x9c8d, LSL #16
    SUB  X5, X9, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X19
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X26, X19, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X14, #0x67da, LSL #0
    MOVK  X14, #0x7020, LSL #16
    MOVK  X14, #0xfe00, LSL #48
    SUB  X3, X14, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X21, #0x4ea9, LSL #0
    MOVK  X21, #0x5cb0, LSL #16
    SUB  X11, X21, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X27, #0x28b, LSL #0
    SUB  X21, X27, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X11, #0x1644, LSL #0
    MOVK  X11, #0x919, LSL #16
    SUB  X12, X11, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x2800, LSL #16
    MOVK  X9, #0xb1be, LSL #32
    MOVK  X9, #0x2a2, LSL #48
    SUB  X26, X9, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X23, #0x28b, LSL #0
    SUB  X25, X23, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x1d, LSL #0
    SUB  X21, X20, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X29
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
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
    MOVZ  X20, #0xa, LSL #0
TaishanIntMduP02_label_547:
    BIC  X23, X23, X10, ASR #26
    ORN  W12, W28, W24, LSR #25
    UMSUBL  X7, W16, W17, X15
    CSEL  X13, X27, X9, VS
    BICS  W13, W26, W12, ASR #14
    CRC32CB  W29, W23, W25
    CSINV  W25, W23, W19, EQ
    AND  X6, X6, X3, ASR #17
    CLZ  V7.4H, V27.4H
    ORR  V9.4H, #0x84
    SUB  W14, W25, W22, UXTH #2
    ASRV  X6, X12, X15
    CLZ  V27.4H, V5.4H
    ANDS  W22, W17, W16, LSR #19
    SMADDL  X29, W29, W26, X3
    SMULH  X17, X22, X23
    CRC32CH  W6, W28, W21
    LSRV  X27, X13, X10
    MOVK  W13, #0xa0df, LSL #16
    ADDS  X28, X19, W16, SXTW #2
    SUB  W24, W19, W7, UXTX #1
    SUB  W10, W17, W17, ASR #26
    EON  W13, W2, W10, LSL #30
    CLZ  W27, W14
    EOR  X12, X16, #0xff00003fffffffff
    EOR  W13, W9, #0xffe0001f
    SUB  W3, W25, W29, LSR #14
    AND  W3, W5, #0x70007
    EOR  X11, X14, X19, LSL #53
    ADDS  W21, W6, #0x611, LSL #12
    SUBS  W26, W16, W20, SXTX #2
    CLZ  V10.16B, V30.16B
    ORR  W29, W19, #0x3ffffffe
    LSRV  X8, X2, X16
    AND  X11, X18, #0xe0000000000000
    MOVN  X15, #0xa734, LSL #16
    ADDS  W29, W19, #0xc6b, LSL #12
    SUBS  X10, X20, X21, SXTX #2
    CLZ  W15, W25
    CSINC  W17, W23, W14, VS
    MOVK  X28, #0xb9f, LSL #16
    CLZ  X21, X14
    LSLV  X9, X16, X5
    CSEL  W26, W10, W15, EQ
    CRC32CW  W8, W6, W7
    ADDS  W28, W11, W25, ASR #31
    EOR  X16, X27, #0x1ffff0001ffff0
    ADC  X18, X21, X20
    CSNEG  W16, W22, W11, AL
    CLS  X16, X23
    EOR  W28, W12, #0xfff807ff
    ANDS  X19, X5, X6, ROR #28
    LSRV  W7, W25, W18
    CSNEG  W23, W14, W28, AL
    SMULH  X26, X3, X27
    MOVZ  W13, #0xc161, LSL #0
    LSLV  X6, X28, X29
    SUBS  W5, W18, W21, UXTW #3
    LSRV  X10, X5, X19
    ANDS  W15, W18, #0x7800780
    ADD  W2, W6, W14, LSR #6
    CSEL  X14, X29, X2, NV
    CRC32CW  W14, W20, W11
    CSNEG  W18, W21, W6, GE
    LSRV  W25, W29, W23
    SUB  X21, X7, W12, SXTH #0
    UBFM  W9, W3, #0x7, #0x12
    CRC32CW  W9, W21, W23
    ADDS  W24, W26, #0x5e0
    MOVK  W24, #0x662c, LSL #16
    MOVZ  W8, #0x746, LSL #0
    LSLV  X10, X21, X26
    CRC32CX  W5, W15, X29
    CSINV  W22, W7, W6, LS
    AND  X7, X15, X2, LSR #63
    EOR  X22, X18, #0xffe0ffe0ffe0ffe
    BIC  V29.16B, V10.16B, V7.16B
    MOVZ  W10, #0xba7c, LSL #16
    ORR  V20.4S, #0xd8, LSL #8
    CRC32H  W10, W15, W18
    SUBS  W27, W5, #0xb56
    SBFM  X21, X7, #0x5, #0x3c
    LSRV  X8, X22, X23
    LSLV  X11, X5, X10
    UMADDL  X11, W16, W7, X27
    LSRV  W21, W22, W29
    UMULH  X2, X6, X25
    SUBS  X6, X15, X22, SXTX #0
    ANDS  W16, W3, W28, LSR #20
    ADDS  W10, W27, W7, SXTX #2
    SUB  W13, W8, W5, LSL #21
    SUBS  W28, W19, W22, LSL #24
    CRC32X  W9, W10, X26
    CLS  W27, W28
    CRC32B  W2, W11, W23
    CRC32B  W27, W13, W29
    ANDS  W22, W25, W29, ASR #20
    SUBS  X24, X24, X22, LSR #52
    ANDS  X6, X7, #0xe00fffffffffffff
    CRC32CX  W9, W11, X6
    ORN  W11, W28, W23, LSL #5
    AND  W23, W23, W3, ROR #22
    SUBS  W7, W19, #0x603
    CRC32CB  W15, W16, W29
    ASRV  X21, X2, X17
    ADD  X18, X13, #0xb81, LSL #12
    MOVZ  X3, #0x8c83, LSL #48
    CSINV  X3, X22, X22, LT
    ADDS  W15, W15, W11, LSR #26
    ANDS  W14, W15, #0x3ff00000
    LSLV  X16, X14, X23
    CRC32CB  W7, W27, W15
    ADC  W17, W18, W19
    MOVN  W9, #0x36a0, LSL #16
    CLZ  W17, W6
    SBFM  W9, W24, #0x18, #0x8
    BIC  W22, W9, W7, LSL #27
    ASRV  X21, X26, X22
    SUB  X25, X26, #0x5f8
    ANDS  W16, W18, #0x3fff80
    CLS  X21, X17
    BIC  V22.16B, V12.16B, V9.16B
    MOVK  X17, #0x15cd, LSL #32
    CLS  W26, W15
    LSLV  X22, X27, X17
    MADD  W21, W5, W25, W18
    CRC32B  W9, W8, W17
    CRC32X  W16, W27, X20
    SUBS  W2, W6, #0x16a
    ADCS  X29, X26, X14
    BIC  X18, X9, X27, LSR #6
    AND  X21, X15, X21, LSR #46
    SUBS  W25, W3, #0x4dc
    MOVZ  X11, #0x7dd0, LSL #0
    ANDS  W28, W15, W5, ROR #24
    MOVZ  W21, #0xf2a1, LSL #0
    UBFM  W7, W9, #0x19, #0xa
    CSNEG  W18, W28, W6, LS
    SUBS  W25, W9, W6, SXTW #1
    MADD  W9, W9, W25, W16
    MOVK  X7, #0x6af9, LSL #48
    LSRV  X17, X7, X29
    ADC  W18, W22, W12
    ADD  W5, W8, W9, SXTB #3
    CRC32CB  W7, W26, W15
    BIC  W6, W22, W22, LSR #28
    CLZ  W9, W15
    CLZ  W5, W16
    CLS  W2, W7
    ANDS  X12, X25, #0x1ff0000000
    ORN  W17, W27, W2, ASR #6
    BIC  V14.8B, V6.8B, V10.8B
    AND  W18, W24, W10, ASR #17
    CRC32H  W9, W12, W16
    CSINC  X10, X6, X20, NE
    BICS  X9, X17, X3, LSR #59
    ORR  W27, W24, #0x1fffff
    AND  W9, W19, #0x3f803f8
    SBFM  X25, X17, #0x2b, #0x17
    MOVN  W22, #0xf801, LSL #0
    ADDS  X11, X15, #0x810
    AND  W25, W29, W17, ROR #4
    ORR  V29.16B, V31.16B, V15.16B
    SUBS  X26, X6, #0xbef, LSL #12
    MOVK  W26, #0xfe72, LSL #16
    SUB  X17, X22, X6, LSR #63
    MOVK  X2, #0x19f9, LSL #32
    AND  X9, X27, #0x2000200020002000
    ADDS  W11, W26, W13, LSL #22
    ASRV  X2, X2, X23
    ORN  X5, X15, X18, LSL #35
    ANDS  X21, X8, #0xfffffffff1ffffff
    SMULH  X29, X24, X27
    CRC32W  W6, W6, W7
    ADD  X14, X10, W28, SXTB #0
    ADDS  W25, W23, W10, UXTH #3
    EOR  W17, W25, W12, ROR #4
    MOVK  W8, #0x57d0, LSL #0
    EOR  X23, X3, #0x8888888888888888
    SUBS  X10, X22, #0xd88
    UMULH  X12, X17, X25
    CLZ  W23, W15
    CRC32CX  W11, W24, X2
    AND  W23, W8, #0x7800780
    MOVN  X23, #0x98e8, LSL #16
    CRC32CH  W10, W5, W15
    CSNEG  X8, X14, X27, LS
    CLS  X23, X22
    SUBS  X10, X10, X6, ASR #2
    EXTR  X7, X19, X9, #0x20
    LSRV  X23, X15, X14
    BIC  W11, W25, W9, ROR #25
    SUB  W12, W7, W10, LSL #15
    EON  W26, W17, W17, LSL #15
    SMSUBL  X10, W26, W21, X8
    ANDS  X23, X16, #0xe000000003ffffff
    ADD  W10, W17, W15, LSL #20
    SUB  X23, X28, W15, UXTH #2
    SMSUBL  X23, W9, W29, X15
    UMSUBL  X16, W14, W10, X23
    SUBS  X20, X20, #0x1
    B.NE  TaishanIntMduP02_label_547
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x19f9, LSL #32
    SUB  X26, X22, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X17, #0xc, LSL #0
    SUB  X5, X17, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X19, #0x9a03, LSL #0
    MOVK  X19, #0x9819, LSL #16
    SUB  X8, X19, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x8, LSL #32
    SUB  X3, X29, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X27, X22, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X21, #0x2000, LSL #0
    MOVK  X21, #0x2000, LSL #16
    SUB  X29, X21, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X5, #0xc00, LSL #0
    MOVK  X5, #0x5090, LSL #16
    SUB  X2, X5, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X7, #0xc00, LSL #0
    MOVK  X7, #0xc00, LSL #16
    SUB  X20, X7, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X12
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X28, X19, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x20, LSL #0
    SUB  X29, X20, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X2, #0x1439, LSL #0
    MOVK  X2, #0x35f1, LSL #16
    SUB  X21, X2, X15
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X14, #0xc, LSL #0
    SUB  X22, X14, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP02_TestFail
    MOVZ  X22, #0x100, LSL #0
    SUB  X19, X22, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP02_TestFail
    MOVZ  X5, #0x20, LSL #0
    SUB  X26, X5, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X7, #0x100, LSL #0
    SUB  X15, X7, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X8, #0x1439, LSL #0
    MOVK  X8, #0x35f1, LSL #16
    SUB  X7, X8, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X10, #0xc00, LSL #0
    MOVK  X10, #0xc00, LSL #16
    SUB  X8, X10, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X2, #0xb6f1, LSL #0
    MOVK  X2, #0xe88e, LSL #16
    MOVK  X2, #0x8053, LSL #32
    MOVK  X2, #0x2796, LSL #48
    MOVZ  X3, #0x90cc, LSL #0
    MOVK  X3, #0xb34a, LSL #16
    MOVK  X3, #0xf3a2, LSL #32
    MOVK  X3, #0x59f3, LSL #48
    MOVZ  X5, #0x8901, LSL #0
    MOVK  X5, #0xbab8, LSL #16
    MOVK  X5, #0xe1c9, LSL #32
    MOVK  X5, #0xbfac, LSL #48
    MOVZ  X6, #0x9c7a, LSL #0
    MOVK  X6, #0x6d3, LSL #16
    MOVK  X6, #0xa096, LSL #32
    MOVK  X6, #0x1bbb, LSL #48
    MOVZ  X7, #0xf52e, LSL #0
    MOVK  X7, #0x990d, LSL #16
    MOVK  X7, #0x327, LSL #32
    MOVK  X7, #0x7536, LSL #48
    MOVZ  X8, #0x6edb, LSL #0
    MOVK  X8, #0x4bca, LSL #16
    MOVK  X8, #0xc61, LSL #32
    MOVK  X8, #0xa340, LSL #48
    MOVZ  X9, #0x7267, LSL #0
    MOVK  X9, #0xff08, LSL #16
    MOVK  X9, #0x7fa8, LSL #32
    MOVK  X9, #0x5286, LSL #48
    MOVZ  X10, #0x485b, LSL #0
    MOVK  X10, #0xc0fe, LSL #16
    MOVK  X10, #0x36e2, LSL #32
    MOVK  X10, #0x6b09, LSL #48
    MOVZ  X11, #0xef56, LSL #0
    MOVK  X11, #0x2741, LSL #16
    MOVK  X11, #0x149f, LSL #32
    MOVK  X11, #0x8c30, LSL #48
    MOVZ  X12, #0x8294, LSL #0
    MOVK  X12, #0xee4f, LSL #16
    MOVK  X12, #0xcd76, LSL #32
    MOVK  X12, #0xe040, LSL #48
    MOVZ  X13, #0x30ce, LSL #0
    MOVK  X13, #0x5ccb, LSL #16
    MOVK  X13, #0xcade, LSL #32
    MOVK  X13, #0x7969, LSL #48
    MOVZ  X14, #0x354b, LSL #0
    MOVK  X14, #0x90e5, LSL #16
    MOVK  X14, #0x2cec, LSL #32
    MOVK  X14, #0x154f, LSL #48
    MOVZ  X15, #0x85fb, LSL #0
    MOVK  X15, #0xbf23, LSL #16
    MOVK  X15, #0x6cf0, LSL #32
    MOVK  X15, #0x2a16, LSL #48
    MOVZ  X16, #0x136a, LSL #0
    MOVK  X16, #0x9b0, LSL #16
    MOVK  X16, #0x8d3c, LSL #32
    MOVK  X16, #0x99d1, LSL #48
    MOVZ  X17, #0x7d63, LSL #0
    MOVK  X17, #0xf515, LSL #16
    MOVK  X17, #0x9a09, LSL #32
    MOVK  X17, #0x2315, LSL #48
    MOVZ  X18, #0x8e0a, LSL #0
    MOVK  X18, #0x5efc, LSL #16
    MOVK  X18, #0xf16f, LSL #32
    MOVK  X18, #0xaa7f, LSL #48
    MOVZ  X19, #0x9f04, LSL #0
    MOVK  X19, #0x4c1, LSL #16
    MOVK  X19, #0x8eec, LSL #32
    MOVK  X19, #0x76a1, LSL #48
    MOVZ  X20, #0xb15c, LSL #0
    MOVK  X20, #0xb6fd, LSL #16
    MOVK  X20, #0x8050, LSL #32
    MOVK  X20, #0x157f, LSL #48
    MOVZ  X21, #0x868e, LSL #0
    MOVK  X21, #0x64ed, LSL #16
    MOVK  X21, #0x17d6, LSL #32
    MOVK  X21, #0xc726, LSL #48
    MOVZ  X22, #0xfcd9, LSL #0
    MOVK  X22, #0x6af3, LSL #16
    MOVK  X22, #0xad7f, LSL #32
    MOVK  X22, #0x6ce3, LSL #48
    MOVZ  X23, #0x23eb, LSL #0
    MOVK  X23, #0x4faf, LSL #16
    MOVK  X23, #0xad52, LSL #32
    MOVK  X23, #0x2f55, LSL #48
    MOVZ  X24, #0x8847, LSL #0
    MOVK  X24, #0xe2af, LSL #16
    MOVK  X24, #0xf14, LSL #32
    MOVK  X24, #0x33ad, LSL #48
    MOVZ  X25, #0x56f1, LSL #0
    MOVK  X25, #0x87c4, LSL #16
    MOVK  X25, #0x5057, LSL #32
    MOVK  X25, #0x2aec, LSL #48
    MOVZ  X26, #0xd19d, LSL #0
    MOVK  X26, #0x7002, LSL #16
    MOVK  X26, #0x7ebf, LSL #32
    MOVK  X26, #0xf822, LSL #48
    MOVZ  X27, #0x6012, LSL #0
    MOVK  X27, #0xb33a, LSL #16
    MOVK  X27, #0x2425, LSL #32
    MOVK  X27, #0x91ec, LSL #48
    MOVZ  X28, #0x8744, LSL #0
    MOVK  X28, #0x2616, LSL #16
    MOVK  X28, #0x17ec, LSL #32
    MOVK  X28, #0x73ab, LSL #48
    MOVZ  X29, #0xd821, LSL #0
    MOVK  X29, #0xc580, LSL #16
    MOVK  X29, #0xb36, LSL #32
    MOVK  X29, #0x923c, LSL #48
    MOVZ  X11, #0xa, LSL #0
TaishanIntMduP02_label_575:
    SUB  X25, X19, #0x88c, LSL #12
    ORR  X27, X23, #0xff00000000000001
    SUBS  X22, X25, #0xba0, LSL #12
    ASRV  W5, W16, W27
    EOR  X20, X28, #0xfffffff8000fffff
    AND  X20, X8, #0x7fffff807fffff8
    MOVZ  W8, #0xea07, LSL #0
    SUBS  X24, X17, W7, UXTW #4
    MOVN  X9, #0xb454, LSL #16
    ADDS  W18, W16, W2, SXTX #4
    EOR  X5, X14, #0xfffffe0000000007
    CSINV  W10, W16, W16, HI
    ORR  V22.8B, V18.8B, V4.8B
    ADCS  X18, X14, X16
    ORR  X25, X16, X22, LSR #22
    LSRV  W13, W19, W25
    SUBS  X27, X9, X18, ASR #16
    BICS  X25, X14, X14, ASR #21
    ORR  V0.16B, V17.16B, V19.16B
    CRC32CH  W24, W24, W18
    CRC32W  W13, W19, W8
    ADCS  X22, X13, X26
    MOVK  W26, #0xaa03, LSL #0
    MOVZ  W24, #0x2256, LSL #16
    ADCS  X17, X14, X7
    UBFM  X6, X21, #0x2e, #0x36
    SUB  X14, X11, X16, LSR #5
    LSRV  X22, X5, X17
    ADD  W20, W5, #0x290
    SMADDL  X17, W6, W10, X6
    SUB  W22, W15, W22, LSR #2
    SUB  W23, W5, W25, UXTH #3
    SBFM  X23, X22, #0xa, #0x13
    CSNEG  X20, X18, X27, GE
    BIC  X6, X17, X7, ASR #4
    CSINV  W24, W18, W6, VS
    CSINV  W29, W29, W27, PL
    SUB  W22, W27, W21, LSR #9
    ORR  X3, X12, #0xfffff800003fffff
    ADD  X15, X11, #0x628
    ADC  W16, W5, W9
    AND  X9, X16, #0xffffffffffe000ff
    CLZ  X9, X10
    EOR  W21, W28, #0xe000e000
    ANDS  X27, X26, #0x3fffff803fffff8
    ADDS  W17, W20, W26, LSL #24
    SUB  W15, W18, #0x719, LSL #12
    ADD  W17, W21, #0xa8c
    AND  X27, X13, #0xffffffc000000
    CSINV  X3, X12, X12, NV
    ANDS  W22, W17, W6, ASR #17
    ADCS  W6, W23, W14
    SUBS  W19, W11, W3, UXTB #4
    BIC  W2, W26, W25, ROR #29
    ADD  W6, W12, W25, UXTB #3
    ORR  V14.4S, #0x53, LSL #16
    SUB  X9, X11, X27, SXTX #1
    ORR  X22, X5, X2, ASR #48
    ADD  W21, W26, W8, UXTX #1
    ADCS  W29, W3, W25
    CSINC  W15, W21, W3, GT
    SUBS  W22, W17, W5, UXTW #4
    AND  W24, W5, #0x7fff0
    MADD  W19, W13, W14, W17
    SUB  X23, X19, X20, LSR #41
    EOR  X24, X27, #0xfffffffff000003f
    ADD  X17, X6, #0x2ce, LSL #12
    ASRV  W12, W19, W6
    CSNEG  W7, W13, W9, NE
    CSINV  X27, X3, X20, AL
    SUB  W7, W15, W23, LSL #20
    SUB  X29, X23, X26, LSR #19
    CLZ  X29, X27
    ORR  X2, X19, #0x3ffe00000000000
    ORR  V2.8H, #0xde, LSL #8
    CSNEG  W27, W8, W2, GT
    AND  W9, W3, #0xfff8fff8
    SUB  X29, X23, X14, ASR #25
    MOVK  W24, #0x2c16, LSL #0
    ADDS  W7, W6, W12, LSR #28
    CSINC  X27, X17, X10, LS
    EOR  W24, W22, W20, LSR #3
    CRC32X  W9, W25, X15
    SUB  X26, X10, X15
    ORN  W29, W3, W5, ROR #8
    ADD  W9, W20, #0x5c0
    SUB  W6, W8, #0xa0b
    LSRV  W26, W19, W9
    CRC32H  W23, W6, W25
    CRC32CW  W10, W13, W18
    SMULH  X12, X21, X15
    CRC32CH  W22, W17, W24
    CSNEG  W2, W15, W27, LE
    AND  X23, X18, X17, LSL #46
    CLS  X10, X27
    SUBS  W10, W10, W14, LSL #31
    EOR  W6, W21, #0xffffc00f
    BICS  W12, W26, W15, ASR #2
    SUB  W10, W28, #0x66e
    EXTR  X20, X25, X3, #0x2b
    EOR  W27, W6, #0x18181818
    CSINC  W9, W13, W17, LE
    CSINV  X20, X8, X14, LT
    MOVZ  X2, #0xa380, LSL #0
    ADDS  X3, X19, #0xcff
    EXTR  W27, W26, W18, #0x17
    MOVK  W14, #0x585b, LSL #0
    SUB  W15, W24, W5, ASR #1
    LSLV  X26, X27, X8
    CRC32CX  W12, W29, X28
    CRC32H  W17, W17, W23
    ADD  X23, X21, X19, LSL #55
    AND  W19, W14, #0x6000600
    CSINV  X21, X15, X27, PL
    LSLV  W3, W28, W26
    UBFM  W5, W8, #0xf, #0x1c
    ADDS  W15, W13, #0x9c0
    SUBS  X28, X8, #0x616, LSL #12
    MOVN  X7, #0x6a6a, LSL #48
    MOVK  W14, #0x309b, LSL #0
    SUB  W7, W24, #0xcbc, LSL #12
    MOVZ  X14, #0x8f39, LSL #16
    SMADDL  X23, W20, W13, X26
    ORR  V19.8H, #0x19
    CSINC  X18, X14, X5, MI
    SUBS  W17, W14, W15, ASR #17
    BIC  W28, W25, W22, LSL #18
    EON  X21, X7, X15, ROR #33
    ORR  W13, W22, #0xf1f1f1f1
    EXTR  X12, X29, X12, #0x3e
    ADDS  W26, W21, #0x68d, LSL #12
    SUB  W25, W7, W10, LSR #16
    BIC  V7.8B, V12.8B, V31.8B
    MOVN  W20, #0x152, LSL #16
    CSINV  W5, W11, W24, PL
    SUBS  W5, W29, W18, LSL #14
    ORR  W5, W15, W20, ROR #14
    SUB  X24, X10, X11, LSL #43
    SMULH  X22, X19, X27
    ORN  W10, W25, W16, LSL #27
    SUB  W15, W26, #0x944
    CRC32CB  W17, W13, W27
    ADCS  X28, X22, X25
    SUBS  X24, X25, X27, LSR #60
    UBFM  W16, W5, #0x9, #0x7
    LSRV  X7, X14, X17
    AND  X2, X8, X19, LSR #35
    ORR  W12, W9, W10, LSR #5
    CRC32CX  W15, W20, X13
    CLZ  W17, W15
    ORR  W15, W9, #0x1ffff000
    MOVZ  X12, #0x178d, LSL #48
    ANDS  W10, W7, #0x3ffe000
    ANDS  W15, W18, W27, LSL #3
    CSEL  X9, X29, X20, LS
    ADD  X9, X7, W14, UXTB #4
    ADD  X14, X24, X18, ASR #45
    SUB  W9, W14, #0x422
    ORR  W25, W19, W15, LSR #25
    LSLV  X13, X11, X5
    MADD  W29, W14, W28, W6
    LSRV  W8, W14, W23
    ORR  V4.16B, V12.16B, V23.16B
    SMADDL  X2, W23, W29, X10
    ORR  W9, W27, W22, LSR #13
    ADD  X12, X8, W19, SXTW #0
    EON  W3, W22, W2, LSR #14
    EON  W18, W17, W7, ROR #2
    ORR  V1.16B, V4.16B, V15.16B
    ANDS  W9, W14, W24, LSR #7
    CRC32H  W26, W15, W17
    EOR  W27, W23, W19, ROR #6
    EOR  X20, X27, X10, ASR #52
    CSEL  W5, W3, W22, GE
    AND  W17, W18, #0x7fff0
    SUBS  X25, X9, X28, LSL #43
    EON  X25, X17, X15, LSR #39
    SUBS  W3, W8, #0xe52
    LSLV  X3, X17, X7
    SUB  W29, W21, W24, LSR #21
    UMSUBL  X2, W21, W17, X28
    ADCS  X20, X3, X6
    CRC32W  W15, W23, W18
    MOVN  X6, #0x2309, LSL #48
    SUBS  X20, X29, W14, UXTW #4
    EOR  W7, W26, W6, LSL #17
    LSLV  W13, W29, W8
    EOR  X3, X5, X24, ASR #23
    UMADDL  X19, W22, W7, X26
    LSRV  W28, W22, W29
    SUBS  X15, X19, X2, ASR #41
    ANDS  X24, X18, X21, ASR #3
    ADD  W16, W10, #0x8fc, LSL #12
    EON  W5, W27, W29, ASR #4
    LSLV  W13, W9, W20
    LSLV  X17, X29, X17
    MADD  X12, X6, X16, X3
    EOR  W26, W13, W29, ROR #15
    ADD  X20, X5, W5, UXTW #3
    BIC  V0.8B, V16.8B, V7.8B
    SUBS  X11, X11, #0x1
    B.NE  TaishanIntMduP02_label_575
    MOVZ  X24, #0xc161, LSL #0
    MOVK  X24, #0x503, LSL #16
    MOVK  X24, #0xd5eb, LSL #32
    MOVK  X24, #0xfffe, LSL #48
    SUB  X12, X24, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP02_TestFail
    MOVZ  X22, #0x89ec, LSL #0
    MOVK  X22, #0xfffd, LSL #16
    SUB  X7, X22, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X28, #0x114a, LSL #0
    MOVK  X28, #0xe8a6, LSL #16
    SUB  X9, X28, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xdcf6, LSL #48
    SUB  X11, X21, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X18, X21, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X10, #0x4, LSL #0
    SUB  X6, X10, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X21, #0x4, LSL #0
    SUB  X6, X21, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X20, X22, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X26, #0xf760, LSL #0
    MOVK  X26, #0x403b, LSL #16
    SUB  X24, X26, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP02_TestFail
    MOVZ  X8, #0x96, LSL #0
    SUB  X25, X8, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x69f, LSL #48
    SUB  X19, X25, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X5, X12, X19
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X14, #0x4, LSL #0
    SUB  X25, X14, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X8, #0xdedc, LSL #0
    MOVK  X8, #0xecbd, LSL #16
    MOVK  X8, #0x77ab, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X20, X8, X23
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X20, X28, X25
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
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
    MOVZ  X7, #0xa, LSL #0
TaishanIntMduP02_label_602:
    ADDS  W21, W7, #0x110
    EOR  W13, W28, W2, LSL #16
    SUBS  X8, X9, W13, SXTH #2
    CRC32X  W21, W29, X5
    BIC  X25, X9, X26, ROR #50
    EOR  X17, X3, #0x1e0000
    CLS  W3, W22
    ADDS  X11, X21, #0x925, LSL #12
    LSLV  X11, X2, X15
    EOR  X9, X2, #0xffffffffc000003f
    CRC32B  W14, W11, W26
    EOR  X21, X26, X22, LSR #26
    BIC  V20.16B, V14.16B, V17.16B
    CLZ  W2, W21
    EOR  X14, X2, X3, ASR #38
    SUB  W8, W20, #0x976, LSL #12
    SBFM  X9, X27, #0x34, #0x13
    EOR  W15, W27, W14, ROR #9
    LSLV  W16, W22, W2
    UBFM  W28, W8, #0xd, #0x10
    ADDS  X20, X6, #0xbde, LSL #12
    CRC32CX  W17, W18, X5
    ADC  W16, W22, W27
    SUB  W17, W26, W14, SXTH #4
    SUBS  W13, W11, W12, ASR #3
    MOVK  W5, #0x9ebf, LSL #0
    EOR  X9, X25, X6, ASR #26
    BIC  W10, W6, W27, ROR #18
    SBFM  W10, W6, #0x1b, #0x1e
    SMULH  X6, X18, X17
    ORR  V3.4S, #0x19, LSL #16
    ANDS  X16, X21, #0x7000700070007000
    SUBS  W20, W11, W5, ASR #18
    SUB  W16, W18, W22, ASR #10
    MOVN  W19, #0x3aa6, LSL #16
    AND  X28, X17, #0xc00fffffc00fffff
    AND  X19, X15, X22, LSL #37
    AND  X14, X19, X29, ASR #50
    SMSUBL  X6, W7, W9, X20
    LSRV  X3, X29, X10
    CRC32CX  W29, W13, X21
    SUBS  X3, X8, W24, UXTW #2
    LSLV  X2, X13, X22
    ORR  X10, X3, #0xfffffff80000001f
    ADD  X15, X25, W5, SXTH #1
    ADD  X15, X12, #0xe3d, LSL #12
    UMSUBL  X14, W6, W25, X13
    SUBS  X22, X26, X26, ASR #7
    CRC32CB  W10, W28, W5
    CSINV  X14, X8, X27, VC
    ADDS  X12, X22, #0xec0
    CSINV  W15, W19, W24, NE
    BICS  X25, X19, X22, ASR #6
    ADD  X2, X6, #0xe2c
    ANDS  X23, X5, #0x1ffffff01ffffff
    MOVZ  X29, #0xd789, LSL #48
    MOVZ  X6, #0xd23, LSL #16
    BIC  V2.8B, V7.8B, V1.8B
    SBFM  X5, X23, #0x3, #0xc
    BICS  X14, X18, X2, LSR #61
    BICS  W18, W18, W19, ROR #10
    SUBS  X6, X19, W26, UXTB #2
    ADD  W19, W27, W28, ASR #6
    ORR  X3, X25, #0xfffffffffffc07ff
    BIC  V12.8B, V16.8B, V7.8B
    EOR  W25, W25, #0xffe3ffe3
    MOVZ  W23, #0xc737, LSL #16
    CRC32B  W21, W22, W29
    MADD  X9, X24, X9, X21
    EOR  X28, X7, X28, ROR #25
    ANDS  X25, X15, X6, ROR #13
    MOVK  W25, #0x7536, LSL #0
    BIC  W6, W14, W22, LSR #24
    ANDS  X8, X17, X14, ASR #54
    CLS  X29, X7
    ASRV  X10, X14, X27
    ANDS  W5, W19, W24, LSL #27
    ANDS  W21, W9, #0xffffe1ff
    CRC32B  W8, W23, W22
    ADDS  W14, W28, W27, SXTH #2
    ADD  W15, W13, W17, LSL #21
    CRC32CH  W22, W14, W26
    CRC32H  W3, W22, W26
    ADD  W19, W22, #0x331
    ANDS  W17, W17, W10, ASR #16
    ORR  V21.2S, #0xd3, LSL #24
    CLS  V3.4S, V23.4S
    CSNEG  W12, W6, W2, CC
    CSNEG  W2, W7, W19, AL
    ADD  W17, W20, #0xa0b, LSL #12
    MOVN  X9, #0x8a5b, LSL #48
    ADCS  W22, W20, W3
    ASRV  X26, X24, X23
    CSINV  W2, W19, W9, PL
    ADC  W8, W15, W29
    CSINV  X19, X10, X10, NE
    CSEL  X13, X15, X21, HI
    SUB  W12, W22, W16, SXTX #3
    UMADDL  X19, W19, W25, X16
    SMADDL  X11, W15, W17, X29
    BICS  W25, W9, W6, ROR #23
    AND  X14, X15, X17, LSR #49
    ANDS  W9, W14, #0xe1e1e1e1
    ORR  W29, W7, #0xe000e0
    BICS  W18, W14, W11, LSR #13
    MOVK  X22, #0xf712, LSL #16
    AND  X20, X2, #0xffff8000ffff8000
    ADC  W21, W11, W3
    SUBS  X23, X25, X27, LSL #59
    EOR  X21, X9, X28, LSR #13
    CSNEG  W12, W2, W18, NE
    CRC32CW  W15, W12, W29
    BICS  W12, W23, W6, LSR #31
    BIC  V10.8B, V11.8B, V6.8B
    SUB  X9, X29, X20, LSL #18
    ADDS  W13, W23, #0x764
    SUB  X6, X22, W24, SXTH #4
    BIC  X18, X27, X17, ASR #45
    CRC32CB  W26, W2, W15
    ANDS  W20, W27, #0x22222222
    CSINV  W8, W20, W22, CS
    BIC  X8, X11, X13, LSL #42
    MADD  X20, X27, X3, X20
    CLZ  X16, X18
    SUBS  W13, W9, W8, ASR #1
    ANDS  X17, X15, #0xbfbfbfbfbfbfbfbf
    MOVZ  W29, #0x8736, LSL #0
    ORR  V15.4S, #0x5f, LSL #8
    CLS  V16.2S, V25.2S
    ADD  W11, W7, W21, SXTW #2
    CLS  W5, W24
    AND  X17, X25, X6, ASR #5
    SUB  X24, X12, W29, SXTB #3
    EOR  X6, X15, X17, LSL #25
    EOR  W24, W29, #0x1ffff800
    SMSUBL  X11, W26, W2, X11
    MADD  X10, X11, X22, X27
    CLS  X19, X29
    ANDS  X10, X16, #0x3f800000
    ADDS  X5, X2, #0x4cd
    MOVZ  W21, #0x2ae4, LSL #16
    LSRV  W21, W3, W6
    MOVN  W5, #0xf985, LSL #16
    BICS  W17, W23, W15, LSR #26
    CRC32X  W3, W20, X17
    EOR  W21, W3, W15, ASR #9
    MADD  X17, X17, X6, X5
    UBFM  X8, X7, #0x3e, #0x1e
    ORN  W16, W25, W8, LSL #30
    ORR  V1.8B, V10.8B, V12.8B
    ORR  W15, W14, #0x1ff0
    SUB  X26, X25, W28, SXTW #0
    ANDS  X20, X11, #0xffffffff001fffff
    EXTR  X19, X5, X2, #0x14
    ADCS  W27, W21, W5
    MOVK  W2, #0xb0d3, LSL #16
    CSINC  W26, W19, W18, LE
    CLZ  W9, W17
    CSEL  X26, X2, X21, EQ
    ADC  W15, W20, W27
    CRC32CB  W29, W3, W17
    EXTR  W9, W17, W8, #0x0
    MOVN  W9, #0x7645, LSL #0
    EON  X16, X22, X17, LSL #32
    ASRV  W29, W2, W24
    CLZ  V14.16B, V29.16B
    ASRV  X26, X11, X11
    ORR  X11, X26, #0x7ffffffffff8
    MOVN  X16, #0x6e3, LSL #16
    EOR  W5, W23, W7, LSL #8
    CLS  W15, W8
    CLS  W28, W9
    UMULH  X5, X11, X7
    ADDS  W14, W21, #0x5dc
    SUB  W20, W17, W27, UXTH #2
    CSNEG  W28, W16, W19, HI
    CSNEG  W14, W16, W28, LS
    UBFM  W14, W26, #0x9, #0xd
    CLS  V14.2S, V8.2S
    ADDS  W5, W7, W27, SXTW #4
    SMSUBL  X10, W23, W15, X11
    ADD  X6, X6, W8, UXTW #1
    CRC32W  W10, W23, W14
    ADDS  W6, W20, W20, SXTW #0
    CSINC  W18, W13, W7, PL
    AND  W20, W27, #0x8000003f
    SUB  W23, W25, W22, LSR #26
    BIC  V3.8B, V16.8B, V7.8B
    AND  X23, X11, X2, ROR #40
    AND  X21, X23, X12, LSL #58
    BICS  W2, W25, W12, LSR #23
    CSEL  W21, W5, W19, CC
    SUBS  X15, X12, X17, LSL #27
    MOVZ  X14, #0x97df, LSL #0
    ADDS  X12, X22, W2, UXTH #0
    SUBS  X29, X3, X17, ASR #2
    ORN  W12, W3, W26, LSL #28
    SBFM  X10, X11, #0xc, #0x3d
    CRC32W  W21, W10, W5
    CRC32X  W23, W20, X25
    SUBS  X7, X7, #0x1
    B.NE  TaishanIntMduP02_label_602
    MOVZ  X23, #0x4e12, LSL #0
    MOVK  X23, #0xa0c8, LSL #16
    SUB  X14, X23, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X18, #0xddfa, LSL #0
    MOVK  X18, #0xf69a, LSL #16
    SUB  X16, X18, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X22, #0xcec1, LSL #0
    MOVK  X22, #0xff97, LSL #16
    SUB  X27, X22, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X19, #0x911e, LSL #0
    MOVK  X19, #0x7007, LSL #16
    SUB  X17, X19, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X12, #0x4, LSL #0
    SUB  X14, X12, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X14, #0x89ba, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X28, X14, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP02_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xff7f, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X16, X14, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X25, #0xfff9, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xfff7, LSL #48
    SUB  X10, X25, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
    MOVZ  X21, #0x4, LSL #0
    SUB  X19, X21, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X10, #0xa231, LSL #0
    MOVK  X10, #0xc48f, LSL #16
    SUB  X6, X10, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xff7f, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X7, X16, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X15, #0x4e52, LSL #0
    MOVK  X15, #0xa8c8, LSL #16
    MOVK  X15, #0xd21e, LSL #32
    MOVK  X15, #0xce3f, LSL #48
    SUB  X23, X15, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP02_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xff7f, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X11, X9, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X2, #0xddfa, LSL #0
    MOVK  X2, #0xf69a, LSL #16
    SUB  X25, X2, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP02_TestFail
    MOVZ  X13, #0x2c, LSL #0
    SUB  X27, X13, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X19, #0x4, LSL #0
    SUB  X13, X19, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP02_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X11, X23, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X5, #0x7f36, LSL #0
    MOVK  X5, #0x1fff, LSL #16
    SUB  X11, X5, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X21, X27, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X23, X17, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP02_TestFail
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
TaishanIntMduP02_label_628:
    ADCS  X26, X24, X21
    SUB  X16, X19, X11, ASR #44
    ORR  V14.8B, V27.8B, V7.8B
    MADD  W24, W21, W27, W9
    ANDS  W7, W5, #0xf1f1f1f1
    MOVK  W17, #0x8503, LSL #0
    SUB  X27, X24, #0x0
    LSRV  X15, X2, X8
    SUBS  X29, X29, #0x1f2, LSL #12
    ADDS  X15, X21, W20, UXTH #4
    AND  W27, W26, W28, ROR #1
    SBFM  X7, X17, #0x2e, #0x1f
    ADDS  W5, W14, W24, LSL #15
    UMSUBL  X24, W27, W25, X6
    UMADDL  X27, W22, W27, X28
    MOVN  X22, #0x1284, LSL #32
    ORR  W21, W22, W10, ROR #4
    SBFM  X22, X5, #0x24, #0x3a
    SUBS  X12, X26, #0xab3, LSL #12
    CSNEG  X8, X19, X9, NV
    ADDS  W29, W24, W5, UXTB #1
    BIC  V16.16B, V27.16B, V13.16B
    CRC32X  W27, W26, X26
    SUB  W6, W26, #0xcee, LSL #12
    EOR  X7, X28, #0x2222222222222222
    LSRV  X29, X21, X14
    CRC32CW  W13, W8, W17
    CLZ  W21, W25
    CRC32CH  W16, W24, W26
    ADDS  X15, X10, X23, ASR #3
    EXTR  W10, W20, W22, #0xb
    ASRV  W29, W5, W16
    EOR  W8, W22, #0xdfdfdfdf
    ADDS  W24, W21, W19, LSL #1
    CRC32CB  W20, W15, W2
    ANDS  W10, W12, #0x2
    ORN  W17, W14, W17, LSR #31
    ORR  V19.4S, #0x59, LSL #16
    ADDS  X20, X13, W28, UXTH #3
TaishanIntMduP02_label_288:
    CRC32CB  W18, W7, W8
    ASRV  W27, W17, W28
    EON  W10, W20, W29, ASR #11
    AND  W29, W12, #0xefefefef
    ADDS  X17, X7, W23, UXTH #4
    ORN  X22, X17, X18, ASR #14
    AND  W7, W21, #0x78007800
    CRC32CB  W9, W10, W24
    ADC  W22, W8, W26
    ANDS  X24, X13, #0xf0f0f0f0f0f0f0f
    EXTR  W23, W29, W10, #0x2
    SUB  W27, W22, W27, ASR #28
    BIC  W2, W14, W3, LSR #9
    ORR  X12, X5, X23, ROR #14
    CRC32CW  W12, W10, W12
    SUBS  W19, W2, W11, LSL #25
    CRC32B  W20, W24, W18
    CSNEG  X7, X10, X28, GT
    CLZ  V26.8B, V8.8B
    EOR  W9, W6, W2, LSL #5
    ADC  W29, W16, W18
    BICS  W3, W7, W14, LSL #30
    SUB  X16, X16, X10, ASR #19
    ORN  X18, X13, X27, ROR #52
    SMSUBL  X20, W19, W9, X16
    ANDS  W9, W26, #0xf800007f
    BIC  W11, W26, W17, LSL #21
    MOVK  X29, #0xd67e, LSL #32
    MADD  W22, W16, W5, W11
    UBFM  W16, W14, #0x15, #0x7
    CRC32CX  W29, W29, X18
    AND  W27, W12, W13, ROR #4
    ADC  X23, X23, X8
    ORR  X15, X17, #0xfff80000fff8000
    SBFM  W5, W25, #0x1c, #0xf
    SMULH  X13, X20, X21
    SUBS  X19, X15, X21, ASR #20
    SUB  X19, X29, #0x880
    ADD  W13, W3, W27, SXTH #4
    ORR  X24, X13, #0x1fffffffffc0
    ADC  X2, X21, X5
    UMADDL  X13, W19, W26, X7
    BIC  X18, X24, X10, LSR #52
    CSNEG  X16, X3, X14, VC
    ORR  V17.16B, V26.16B, V31.16B
    ORR  W7, W23, W24, LSR #17
    ADC  W7, W28, W12
    ANDS  W26, W6, W21, LSR #11
    MOVZ  X2, #0x5071, LSL #0
    ADD  X6, X16, W23, SXTW #0
    MADD  X8, X25, X14, X11
    ADD  X13, X26, X2, LSL #37
    CRC32X  W18, W13, X7
    ADDS  W20, W18, W10, ASR #3
    CRC32CW  W16, W11, W13
    LSLV  X6, X23, X16
    ADCS  W6, W11, W2
    CRC32H  W20, W24, W10
    ADCS  W22, W5, W20
    CLS  X16, X26
    BICS  W5, W15, W11, LSL #20
    SUB  W16, W16, W18, LSR #30
    ORR  X12, X12, #0x7ffff0007ffff0
    ADCS  W7, W22, W23
    ORR  X6, X18, X6, LSR #33
    ADDS  W23, W28, W29, LSR #7
    ADCS  W29, W13, W20
    SUBS  W20, W13, W15, UXTH #3
    ADDS  W24, W6, #0xf50
    SUBS  X16, X6, X7, LSL #33
    CSINV  W22, W29, W25, GE
    LSRV  W26, W28, W24
    UBFM  W15, W24, #0x8, #0x13
    AND  X15, X11, #0x38003800380038
    ADD  W6, W23, W18, LSR #3
    ADDS  X12, X29, #0x620
    MOVN  X22, #0xaa41, LSL #32
    CSINV  X13, X11, X18, EQ
    BIC  X20, X20, X2, ASR #44
    CRC32B  W26, W15, W7
    CRC32B  W12, W20, W12
    SUB  W12, W16, W12, UXTW #3
    SBFM  X6, X19, #0x1a, #0x35
    CRC32X  W11, W16, X9
    ADCS  X25, X26, X16
    MOVZ  X16, #0x9fad, LSL #16
    MOVK  W16, #0xb475, LSL #16
    SUBS  X6, X26, W6, UXTW #2
    BIC  W23, W25, W18, LSR #25
    SUB  W22, W5, W18, UXTW #3
    ADD  X15, X10, W22, UXTH #2
    ORR  V16.4S, #0xff, LSL #24
    LSRV  X11, X6, X29
    CRC32W  W20, W20, W3
    ADCS  W25, W11, W10
    ORR  X22, X13, X13, ASR #17
    CRC32CW  W7, W18, W12
    EXTR  W10, W23, W29, #0x2
    SUBS  X13, X20, W19, SXTB #2
    BIC  X26, X19, X29, ROR #52
    CLS  V12.16B, V26.16B
    SUBS  X10, X12, W18, UXTB #3
    UBFM  X2, X22, #0x3a, #0x26
    ASRV  W2, W3, W7
    CRC32CW  W17, W15, W23
    ORN  X23, X7, X25, ROR #35
    ORR  X11, X10, #0x3ffffff000000000
    CRC32CH  W6, W12, W26
    SUB  X20, X18, #0xff0
    CLZ  W6, W8
    ADD  X17, X20, X22, ASR #5
    SUB  X19, X3, W26, SXTW #3
    CSEL  X9, X12, X26, CC
    ANDS  X9, X3, X27, LSL #9
    EON  W27, W13, W24, ROR #30
    ADD  W3, W19, #0xdb6, LSL #12
    ADCS  W10, W29, W8
    ORR  X19, X11, X26, ROR #52
    SUB  X13, X6, W11, SXTH #3
    AND  X16, X19, X11, ROR #31
    ADDS  W5, W3, W24, SXTW #1
    CLS  X14, X28
    SUBS  W15, W28, #0x659
    ADDS  W25, W6, W19, SXTW #3
    CLZ  W7, W23
    CRC32W  W2, W15, W2
    MOVK  W7, #0xd521, LSL #16
    BICS  W19, W15, W20, ASR #12
    MADD  X21, X10, X26, X13
    EOR  W15, W28, W29, LSR #26
    AND  W25, W8, W22, ROR #18
    CSINC  X27, X24, X6, VC
    EOR  X10, X29, X9, LSL #16
    ADD  X22, X24, X24, LSL #17
    EOR  W21, W19, W20, ROR #28
    ORR  W15, W16, #0xf01ff01f
    MOVN  X14, #0x68cd, LSL #48
    CRC32CH  W29, W29, W26
    BICS  X19, X2, X13, ASR #50
    CRC32CB  W12, W15, W18
    ANDS  W24, W7, #0xfc00
    SUBS  X26, X24, W7, SXTW #1
    ASRV  X26, X16, X12
    SUB  X22, X27, #0x53
    LSRV  W14, W11, W25
    ANDS  X7, X10, #0xe0000000ffffffff
    ADD  X3, X25, X28, ASR #58
    ORR  X5, X14, X29, ASR #14
    CLS  W3, W11
    EOR  W6, W26, W11, ASR #15
    EON  W2, W26, W20, LSR #1
    ADDS  W7, W18, #0xf8a, LSL #12
    MOVK  X17, #0x3222, LSL #0
    ADDS  X12, X26, #0x8fc
    SUB  W5, W10, #0x95c
    EON  X7, X19, X8, ROR #23
    BIC  X5, X6, X5, LSR #37
    ORR  V10.2S, #0x71, LSL #16
    LSRV  W16, W26, W6
    ASRV  X27, X16, X16
    SUB  X26, X15, X2, LSR #13
    SUBS  X28, X28, #0x1
    B.NE  TaishanIntMduP02_label_628
    MOVZ  X22, #0xb65a, LSL #0
    MOVK  X22, #0x87ab, LSL #16
    SUB  X16, X22, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X10, #0x1, LSL #0
    SUB  X6, X10, X3
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X13, #0xae5b, LSL #0
    MOVK  X13, #0x26c3, LSL #16
    SUB  X9, X13, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X9, X29, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X24, #0x5e85, LSL #0
    MOVK  X24, #0xa25c, LSL #16
    MOVK  X24, #0xf7ff, LSL #32
    MOVK  X24, #0x385a, LSL #48
    SUB  X13, X24, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP02_TestFail
    MOVZ  X23, #0xd284, LSL #0
    MOVK  X23, #0xa163, LSL #16
    MOVK  X23, #0x1c8, LSL #32
    SUB  X14, X23, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP02_TestFail
    MOVZ  X8, #0x1, LSL #0
    SUB  X22, X8, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP02_TestFail
    MOVZ  X6, #0xa253, LSL #0
    MOVK  X6, #0x283f, LSL #16
    MOVK  X6, #0xfff0, LSL #32
    MOVK  X6, #0x3fff, LSL #48
    SUB  X25, X6, X11
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP02_TestFail
    MOVZ  X17, #0x720, LSL #0
    MOVK  X17, #0x26c4, LSL #16
    MOVK  X17, #0xf44a, LSL #32
    MOVK  X17, #0x107, LSL #48
    SUB  X25, X17, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP02_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X12, #0xf25f, LSL #0
    MOVK  X12, #0xfc3f, LSL #16
    SUB  X29, X12, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X20, X6, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X15, #0x720, LSL #0
    MOVK  X15, #0x26c4, LSL #16
    MOVK  X15, #0xf44a, LSL #32
    MOVK  X15, #0x107, LSL #48
    SUB  X28, X15, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP02_TestFail
    MOVZ  X2, #0x7ef3, LSL #0
    MOVK  X2, #0xbd2f, LSL #16
    SUB  X20, X2, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X28, #0x3038, LSL #0
    MOVK  X28, #0x5da0, LSL #16
    SUB  X10, X28, X19
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X28, X22, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP02_TestFail
    MOVZ  X15, #0xd284, LSL #0
    MOVK  X15, #0xa163, LSL #16
    MOVK  X15, #0x1c8, LSL #32
    SUB  X18, X15, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X24, X7, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP02_TestFail
    MOVZ  X2, #0x374d, LSL #0
    MOVK  X2, #0x12ef, LSL #16
    MOVK  X2, #0xe387, LSL #32
    MOVK  X2, #0x9589, LSL #48
    MOVZ  X3, #0x844b, LSL #0
    MOVK  X3, #0x6229, LSL #16
    MOVK  X3, #0x20c4, LSL #32
    MOVK  X3, #0xbeac, LSL #48
    MOVZ  X5, #0x5031, LSL #0
    MOVK  X5, #0x7581, LSL #16
    MOVK  X5, #0x9814, LSL #32
    MOVK  X5, #0xe6ae, LSL #48
    MOVZ  X6, #0x5d92, LSL #0
    MOVK  X6, #0x324b, LSL #16
    MOVK  X6, #0xc7e3, LSL #32
    MOVK  X6, #0x98af, LSL #48
    MOVZ  X7, #0x8fad, LSL #0
    MOVK  X7, #0xe913, LSL #16
    MOVK  X7, #0xa392, LSL #32
    MOVK  X7, #0x319, LSL #48
    MOVZ  X8, #0x899b, LSL #0
    MOVK  X8, #0xe021, LSL #16
    MOVK  X8, #0xa882, LSL #32
    MOVK  X8, #0xa5b6, LSL #48
    MOVZ  X9, #0x62e, LSL #0
    MOVK  X9, #0x7d92, LSL #16
    MOVK  X9, #0x79ad, LSL #32
    MOVK  X9, #0xba77, LSL #48
    MOVZ  X10, #0xbeaf, LSL #0
    MOVK  X10, #0x4e27, LSL #16
    MOVK  X10, #0x1dd1, LSL #32
    MOVK  X10, #0x3560, LSL #48
    MOVZ  X11, #0xf1cf, LSL #0
    MOVK  X11, #0xe825, LSL #16
    MOVK  X11, #0x392e, LSL #32
    MOVK  X11, #0xe47f, LSL #48
    MOVZ  X12, #0x5142, LSL #0
    MOVK  X12, #0x70fa, LSL #16
    MOVK  X12, #0x61f6, LSL #32
    MOVK  X12, #0x71a2, LSL #48
    MOVZ  X13, #0x380e, LSL #0
    MOVK  X13, #0x90e9, LSL #16
    MOVK  X13, #0x4af6, LSL #32
    MOVK  X13, #0x6716, LSL #48
    MOVZ  X14, #0x7e86, LSL #0
    MOVK  X14, #0xc85c, LSL #16
    MOVK  X14, #0x8423, LSL #32
    MOVK  X14, #0xfa57, LSL #48
    MOVZ  X15, #0xcc05, LSL #0
    MOVK  X15, #0x88cb, LSL #16
    MOVK  X15, #0x4da0, LSL #32
    MOVK  X15, #0x81a9, LSL #48
    MOVZ  X16, #0xd906, LSL #0
    MOVK  X16, #0xa4f4, LSL #16
    MOVK  X16, #0x9be6, LSL #32
    MOVK  X16, #0x7757, LSL #48
    MOVZ  X17, #0x9d17, LSL #0
    MOVK  X17, #0xaf63, LSL #16
    MOVK  X17, #0x60c1, LSL #32
    MOVK  X17, #0x480c, LSL #48
    MOVZ  X18, #0xc713, LSL #0
    MOVK  X18, #0x4b2d, LSL #16
    MOVK  X18, #0xcec7, LSL #32
    MOVK  X18, #0x8741, LSL #48
    MOVZ  X19, #0xf2fe, LSL #0
    MOVK  X19, #0x5705, LSL #16
    MOVK  X19, #0x26e1, LSL #32
    MOVK  X19, #0xde54, LSL #48
    MOVZ  X20, #0x385f, LSL #0
    MOVK  X20, #0x887c, LSL #16
    MOVK  X20, #0x1e37, LSL #32
    MOVK  X20, #0x5a99, LSL #48
    MOVZ  X21, #0x63e, LSL #0
    MOVK  X21, #0x41cc, LSL #16
    MOVK  X21, #0x2e37, LSL #32
    MOVK  X21, #0xcea7, LSL #48
    MOVZ  X22, #0xe0b, LSL #0
    MOVK  X22, #0x8ab1, LSL #16
    MOVK  X22, #0x167f, LSL #32
    MOVK  X22, #0xb0cc, LSL #48
    MOVZ  X23, #0xf8db, LSL #0
    MOVK  X23, #0x1075, LSL #16
    MOVK  X23, #0x59ac, LSL #32
    MOVK  X23, #0x82f9, LSL #48
    MOVZ  X24, #0xc872, LSL #0
    MOVK  X24, #0x48fe, LSL #16
    MOVK  X24, #0x3545, LSL #32
    MOVK  X24, #0xf24f, LSL #48
    MOVZ  X25, #0x932f, LSL #0
    MOVK  X25, #0x2511, LSL #16
    MOVK  X25, #0xf57a, LSL #32
    MOVK  X25, #0x2573, LSL #48
    MOVZ  X26, #0x1fc8, LSL #0
    MOVK  X26, #0x7d52, LSL #16
    MOVK  X26, #0x4e90, LSL #32
    MOVK  X26, #0x2cd6, LSL #48
    MOVZ  X27, #0x59f7, LSL #0
    MOVK  X27, #0x390b, LSL #16
    MOVK  X27, #0x964e, LSL #32
    MOVK  X27, #0x579d, LSL #48
    MOVZ  X28, #0x18ea, LSL #0
    MOVK  X28, #0x6922, LSL #16
    MOVK  X28, #0xe8c6, LSL #32
    MOVK  X28, #0x7d1a, LSL #48
    MOVZ  X29, #0xff24, LSL #0
    MOVK  X29, #0xeeab, LSL #16
    MOVK  X29, #0x20fe, LSL #32
    MOVK  X29, #0xe19c, LSL #48
    MOVZ  X12, #0xa, LSL #0
TaishanIntMduP02_label_654:
    EON  W16, W6, W3, ROR #16
    UBFM  W29, W14, #0x2, #0x18
    CLS  X5, X18
    CSINV  W28, W21, W17, GT
    ORR  X8, X3, #0x7ffffff
    ASRV  W2, W27, W15
    SBFM  W18, W6, #0x1d, #0xc
    MOVN  W10, #0xab2a, LSL #0
    ORR  W10, W15, W3, LSL #19
    ORR  V2.4H, #0x99, LSL #8
    AND  X2, X17, X14, ROR #29
    ADCS  X25, X21, X11
    MOVZ  W28, #0x8c5f, LSL #16
    CRC32CX  W13, W27, X10
    ADDS  X11, X25, W18, UXTW #2
    MOVZ  X22, #0xa565, LSL #32
    EOR  W28, W24, #0x77777777
    ORR  V22.2S, #0x32, LSL #24
    CLS  X29, X19
    ORR  V2.4H, #0x1b
    SUBS  W3, W28, #0xf2a, LSL #12
    SUB  X25, X24, X17, LSR #43
    ADDS  W3, W29, W11, LSL #14
    ADD  W22, W10, W24, UXTB #4
    SMULH  X27, X20, X19
    UBFM  W21, W23, #0x0, #0x12
    SUB  X7, X29, W17, SXTW #3
    ADD  X8, X23, #0xdff
    SMADDL  X9, W12, W28, X22
    ADC  X20, X12, X11
    EON  W26, W24, W20, ASR #6
    LSRV  W20, W29, W19
    CLZ  V19.8H, V11.8H
    UBFM  X14, X24, #0x2f, #0x22
    ADCS  X11, X23, X2
    LSLV  X29, X18, X7
    BICS  W8, W3, W16, ROR #8
    UMSUBL  X21, W25, W20, X20
    SMADDL  X19, W28, W20, X21
    SUB  X25, X20, X10, LSL #32
    CLZ  W10, W3
    EON  X3, X16, X27
    ORR  W24, W25, #0xffffffe3
    BIC  W26, W13, W2, LSR #18
    UBFM  X2, X28, #0x3d, #0x2b
    EXTR  W9, W28, W6, #0x17
    MADD  W20, W15, W15, W24
    ADD  X28, X14, X11, ASR #58
    CSNEG  X13, X13, X18, LT
    SUB  X19, X22, W27, UXTH #4
    ADDS  X10, X7, #0x980
    EOR  W11, W5, W29, ROR #24
    ADC  X11, X21, X18
    ORR  X16, X25, #0x2000000020
    ASRV  W16, W25, W26
    SUBS  X10, X12, W7, UXTW #3
    CRC32X  W10, W18, X7
    ADDS  X21, X9, W10, SXTH #1
    ADDS  W9, W16, W8, LSL #4
    MOVZ  X13, #0x62e3, LSL #48
    MOVZ  W27, #0x54a4, LSL #16
    ADDS  X28, X21, X2, ASR #48
    MOVK  W28, #0x2d26, LSL #16
    CRC32CH  W10, W5, W3
    CLZ  X20, X13
    ADD  W7, W12, W14, LSR #31
    ORR  V15.4S, #0xda, LSL #24
    BIC  V31.16B, V7.16B, V11.16B
    MOVZ  W8, #0xf5c7, LSL #16
    CSEL  X28, X24, X19, NV
    ORR  W14, W11, W21, LSL #29
    ORR  V5.8B, V22.8B, V30.8B
    SBFM  X7, X8, #0x2c, #0xf
    ADD  X14, X22, W24, UXTW #3
    EXTR  X27, X17, X9, #0x34
    MOVN  W23, #0x1373, LSL #16
    SUB  W20, W8, W25, SXTH #2
    EXTR  X10, X15, X7, #0x21
    EOR  W19, W3, #0x7ffffc
    CRC32B  W13, W27, W3
    CLZ  X27, X28
    SUB  X9, X6, X24, LSL #25
    SUBS  X14, X6, #0x5a4, LSL #12
    ORN  X21, X26, X25, ROR #13
    CSINC  W24, W12, W21, NV
    CRC32CW  W6, W13, W11
    CSINV  W10, W25, W6, GE
    ADDS  X22, X28, #0x930
    UMADDL  X18, W2, W28, X16
    ADDS  X23, X11, X12, LSL #14
    CSINC  X3, X23, X8, AL
    UBFM  X18, X2, #0x34, #0x2d
    CSINV  X2, X29, X8, CC
    ADCS  X9, X5, X20
    EON  X18, X22, X29, LSL #40
    SUBS  W27, W14, W8, SXTX #4
    ADCS  W9, W26, W16
    CSINV  W14, W10, W9, LT
    SMULH  X18, X2, X22
    SUBS  W27, W8, #0x685
    CRC32B  W13, W24, W7
    UBFM  W13, W20, #0x3, #0x15
    CSINV  X27, X15, X21, PL
    CRC32CX  W3, W3, X10
    ADDS  X10, X28, X18, LSR #52
    CRC32B  W15, W21, W14
    BIC  W20, W15, W28, ASR #16
    UMADDL  X23, W12, W5, X10
    BIC  W18, W10, W9, ASR #9
    ADD  X2, X12, X9, LSR #41
    ASRV  W28, W20, W17
    BIC  V22.8B, V13.8B, V6.8B
    CRC32CB  W28, W25, W28
    SUB  X29, X12, #0xa53, LSL #12
    ANDS  W15, W18, W2, ASR #17
    CSNEG  X29, X29, X24, NV
    EOR  W27, W14, #0xff83ffff
    MOVZ  X16, #0x7277, LSL #48
    BIC  V5.8B, V17.8B, V29.8B
    ORR  V3.8B, V13.8B, V23.8B
    SBFM  X3, X22, #0x4, #0x28
    ORR  X19, X11, X22, ASR #55
    SUBS  X29, X29, #0xca2, LSL #12
    EOR  W13, W7, #0x66666666
    ORR  V14.8H, #0x43, LSL #8
    MOVN  W10, #0x8395, LSL #16
    ADC  X29, X6, X29
    CLZ  V29.8H, V19.8H
    CRC32B  W5, W25, W17
    BICS  X14, X5, X20, ROR #54
    ADDS  W17, W26, #0x86d, LSL #12
    MOVN  W9, #0x9ad3, LSL #0
    ORR  W29, W7, #0x7f807f8
    SUB  X16, X27, X2, LSL #32
    SUB  W3, W6, W6, LSR #0
    BICS  X14, X15, X25, LSL #9
    CSINC  X21, X23, X27, EQ
    CLZ  W24, W25
    AND  X15, X18, #0x800f800f800f800f
    ORR  X3, X19, X12, ASR #37
    ORR  V28.2S, #0xe5, LSL #16
    UBFM  W16, W13, #0xb, #0x2
    UBFM  W24, W23, #0x1a, #0x4
    ORR  W6, W14, #0x100010
    LSRV  W10, W17, W17
    MOVK  X26, #0x57a9, LSL #0
    ADDS  X17, X8, X21, ASR #22
    ORR  V5.2S, #0x85, LSL #8
    MOVN  X29, #0x3e40, LSL #48
    ADDS  W26, W13, #0x744
    ORR  W24, W13, #0xe7ffe7ff
    UMADDL  X23, W5, W27, X17
    MOVN  W25, #0x980e, LSL #16
    SMADDL  X10, W29, W29, X13
    SMADDL  X19, W25, W18, X24
    ORR  X21, X11, #0xc00000000007ffff
    UMADDL  X14, W27, W13, X17
    CLZ  X8, X18
    ANDS  X28, X3, X2, LSL #19
    MADD  X27, X21, X20, X15
    BICS  W19, W2, W9, LSR #10
    ASRV  X27, X8, X6
    CSINC  X19, X7, X26, NE
    CLS  X6, X5
    ASRV  X18, X12, X17
    SMULH  X23, X11, X8
    ORR  V0.4H, #0x1, LSL #8
    EOR  W14, W14, #0xbbbbbbbb
    CSINC  W10, W14, W24, LS
    CSINC  W20, W12, W10, VC
    MOVN  X20, #0xc25, LSL #16
    ADD  W29, W13, W13, ASR #21
    UBFM  W13, W2, #0x7, #0x15
    EOR  W13, W11, W13, ROR #11
    LSRV  X5, X9, X29
    EXTR  W26, W10, W26, #0x0
    ORR  X24, X25, X23, LSR #2
    CRC32H  W27, W7, W10
    ADCS  X27, X23, X19
    UBFM  W21, W9, #0x11, #0x4
    BIC  X18, X5, X29, ROR #34
    EON  W24, W9, W29, ROR #16
    MADD  X9, X11, X19, X11
    ORR  V0.8H, #0x82, LSL #8
    ASRV  W15, W9, W3
    ADDS  X25, X16, #0x9ef
    ADDS  X8, X22, X28, ASR #55
    ORR  W7, W25, #0x8000800
    BICS  W17, W19, W10, ROR #24
    ANDS  W18, W3, W23, ROR #16
    CSNEG  X16, X12, X23, LE
    ADDS  X7, X20, #0xa84, LSL #12
    ADCS  X7, X19, X14
    CSNEG  W25, W24, W10, CS
    SMSUBL  X16, W22, W14, X7
    ADCS  W18, W27, W23
    UMADDL  X10, W18, W22, X19
    SUB  X17, X5, #0xaa6, LSL #12
    ANDS  X9, X27, #0x7c0000007c000000
    LSRV  W24, W3, W25
    SUBS  X12, X12, #0x1
    B.NE  TaishanIntMduP02_label_654
    MOVZ  X15, #0x1, LSL #0
    SUB  X25, X15, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP02_TestFail
    MOVZ  X15, #0x10d0, LSL #0
    MOVK  X15, #0x7df, LSL #16
    MOVK  X15, #0xffc1, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X2, X15, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X2, #0x7f, LSL #0
    SUB  X10, X2, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
    MOVZ  X3, #0x20, LSL #0
    SUB  X26, X3, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X13, #0x1de, LSL #0
    MOVK  X13, #0x1ed6, LSL #16
    MOVK  X13, #0x1, LSL #32
    SUB  X14, X13, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x92f, LSL #0
    MOVK  X20, #0x1, LSL #32
    SUB  X7, X20, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x6400, LSL #16
    SUB  X25, X14, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X10
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
    MOVZ  X7, #0x10d0, LSL #0
    MOVK  X7, #0x7df, LSL #16
    MOVK  X7, #0xffc1, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X13, X7, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x6400, LSL #16
    SUB  X10, X16, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
    MOVZ  X28, #0x10d0, LSL #0
    MOVK  X28, #0x7df, LSL #16
    MOVK  X28, #0xffc1, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X15, X28, X15
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x6400, LSL #16
    SUB  X19, X12, X16
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X29, #0xa07f, LSL #0
    MOVK  X29, #0xff55, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X28, #0x6da9, LSL #0
    MOVK  X28, #0x6666, LSL #16
    SUB  X22, X28, X18
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X19
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X7, #0x92f, LSL #0
    MOVK  X7, #0x1, LSL #32
    SUB  X26, X7, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x6, LSL #16
    SUB  X27, X13, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X3, X27, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X22, #0x3ef8, LSL #0
    SUB  X13, X22, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X9, X29, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X26
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X21, X5, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
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
    MOVZ  X19, #0xa, LSL #0
TaishanIntMduP02_label_682:
    ADD  W23, W23, W13, ASR #26
    ADD  X16, X28, #0xfa0
    ADDS  X11, X10, W29, SXTB #1
    EXTR  W11, W20, W25, #0x1a
    UBFM  X25, X27, #0x20, #0x14
    ADCS  W16, W19, W27
    SUBS  W17, W23, W17, UXTH #0
    ADDS  W24, W29, W5, UXTX #3
    AND  X16, X20, X7, ASR #2
    SUBS  W22, W16, #0x0
    LSRV  X18, X2, X11
    CRC32CH  W6, W21, W25
    SUB  W23, W2, W7, LSL #29
    CLZ  W26, W10
    ORN  X24, X17, X3, LSL #49
    MADD  W22, W17, W18, W23
    CSEL  X13, X26, X27, HI
    CSINC  X17, X19, X19, GT
    MOVN  X17, #0x63a, LSL #48
    ADD  X22, X17, #0x707
    CRC32H  W22, W2, W28
    ADDS  W14, W7, #0xede, LSL #12
    EON  X3, X20, X27, ASR #18
    ADDS  W25, W24, W27, ASR #9
    CLS  W25, W22
    ADC  X23, X25, X8
    SUBS  W7, W24, W13, LSL #24
    MOVN  W14, #0x422f, LSL #0
    EOR  W25, W5, #0xc007c007
    ADD  X22, X16, #0xbd3, LSL #12
    AND  W25, W22, #0xfffffc1f
    ANDS  X14, X29, X7, LSL #55
    ADCS  W15, W20, W23
    ANDS  W10, W26, W19, ASR #24
    LSRV  W6, W13, W14
    ADD  X7, X20, W14, UXTH #4
    SUBS  W11, W2, #0x83c, LSL #12
    EXTR  W5, W18, W8, #0xc
    EON  W11, W3, W15, LSL #24
    AND  X13, X16, X13, LSL #34
    CRC32CW  W13, W23, W25
    ANDS  W8, W13, W3, LSL #26
    ORN  W11, W10, W16, ROR #13
    SUBS  X22, X21, W21, SXTB #0
    ADCS  X13, X21, X9
    AND  W15, W29, W24, ROR #2
    ORR  W2, W15, #0x3c003c0
    ORR  W11, W2, #0xff0
    BIC  X9, X23, X15, ROR #28
    MOVK  X10, #0x3911, LSL #48
    CSINC  X16, X11, X23, VS
    EOR  W27, W27, W16, LSR #15
    ADD  W29, W23, W14, UXTX #4
    EON  X2, X26, X7, LSL #40
    ANDS  X24, X3, #0x7fffffff7fffffff
    ADC  W21, W11, W8
    LSRV  W23, W15, W11
    ADD  W15, W29, W5, LSL #22
    CRC32X  W8, W17, X11
    CRC32H  W28, W7, W27
    ORR  V21.8H, #0x80
    SUB  W2, W14, W11, LSR #14
    ADD  X15, X11, #0x42d, LSL #12
    SUBS  X16, X2, X5, SXTX #2
    SUB  X26, X5, X21, UXTX #2
    EOR  X13, X23, X8, ROR #48
    ADDS  X26, X23, W23, SXTH #0
    UMSUBL  X18, W28, W8, X16
    CRC32H  W15, W6, W29
    BIC  X3, X27, X5, LSR #54
    LSLV  W23, W18, W22
    ORR  X15, X23, #0xfffffffffffff80f
    UBFM  X16, X21, #0x1f, #0x5
    SUB  X26, X21, X27, LSR #53
    LSLV  W15, W22, W2
    MADD  X27, X2, X12, X20
    ADC  X29, X27, X7
    SUBS  X28, X10, #0x5f8
    BIC  W9, W19, W6, LSR #16
    UMSUBL  X22, W27, W12, X16
    ADD  X26, X3, #0xba8, LSL #12
    LSRV  X21, X24, X8
    EOR  W25, W10, W15, LSR #7
    CSEL  X25, X10, X17, LT
    ADDS  W15, W26, W11, LSR #31
    CLS  V6.16B, V9.16B
    CLZ  V18.4H, V25.4H
    ADD  X14, X12, X29, LSR #11
    SUBS  X14, X20, X25, LSL #34
    CRC32W  W12, W21, W8
    CSNEG  X15, X16, X3, LE
    MOVK  X22, #0x8251, LSL #0
    AND  X9, X8, X8, ROR #20
    EON  X25, X2, X16, ROR #31
    LSLV  X25, X16, X20
    SUB  X27, X16, W17, UXTH #1
    CSINV  W11, W28, W14, GE
    ADD  X27, X22, X3, ASR #57
    LSLV  X29, X21, X16
    CRC32B  W18, W2, W29
    CSINC  X27, X26, X15, VC
    EXTR  X22, X10, X22, #0x14
    ASRV  W17, W27, W14
    ANDS  X25, X28, #0xffffffffc0001fff
    BICS  X9, X19, X28, ASR #35
    ORR  X21, X7, #0xfffc00000000ffff
    UMULH  X10, X9, X9
    ASRV  X28, X24, X22
    CSNEG  W2, W17, W28, CS
    EOR  X29, X27, #0xff07ff07ff07ff07
    SUBS  W18, W21, W5, LSR #8
    ASRV  W10, W11, W24
    MADD  X25, X23, X28, X28
    ADC  X26, X29, X5
    CRC32B  W28, W17, W16
    CLZ  X8, X16
    CLZ  V21.2S, V27.2S
    LSLV  W21, W8, W14
    CSINC  X17, X17, X2, VS
    BIC  W9, W27, W21, ASR #11
    SUB  X24, X12, X23, LSL #38
    ADCS  X22, X16, X9
    ORN  X3, X20, X3, LSL #51
    SUB  W17, W11, W25, LSR #14
    LSRV  X29, X16, X29
    BIC  W26, W10, W19, ROR #30
    SUBS  W29, W17, W29, UXTB #0
    ANDS  W10, W17, #0x80000007
    BIC  W28, W17, W5, LSR #14
    ASRV  X28, X24, X22
    LSRV  W15, W19, W24
    CSINC  W12, W9, W12, EQ
    MADD  X12, X9, X13, X27
    SMULH  X7, X9, X15
    EON  W3, W11, W18, LSR #2
    ADDS  W26, W10, W19, LSR #3
    SBFM  X11, X28, #0x1, #0x1b
    EXTR  X6, X22, X12, #0x4
    CLZ  X7, X11
    ANDS  X23, X3, #0xfffff00000000007
    SUB  X29, X13, X15, ASR #55
    SUB  X15, X17, X24, ASR #25
    AND  W5, W27, W15, LSR #12
    CSEL  X6, X10, X12, NV
    SUBS  W5, W27, #0x700
    CSEL  W5, W10, W26, CC
    SUBS  X7, X9, W29, SXTW #4
    CSINV  W21, W8, W6, PL
    MOVK  W7, #0x338d, LSL #0
    ADDS  W6, W24, #0xb15
    CSEL  W18, W8, W19, GE
    EOR  W9, W18, W26, ASR #25
    SUB  W2, W23, #0xc4b, LSL #12
    ORR  V20.4S, #0x85
    EON  W23, W18, W24, LSL #9
    EOR  X29, X28, #0xffe00000ffe0000
    SUB  X9, X12, X5, ASR #42
    CRC32X  W28, W7, X21
    EOR  X8, X18, #0xfffffffff83fffff
    CSINV  W8, W6, W7, GE
    CRC32X  W6, W8, X18
    ADDS  X24, X2, #0xd0
    CLS  V15.2S, V24.2S
    CLS  X11, X3
    MOVZ  W10, #0x3c9c, LSL #0
    UBFM  W22, W18, #0x19, #0xf
    ADD  W12, W22, #0x91e
    AND  W9, W8, W27, ASR #17
    CRC32B  W24, W17, W22
    ADCS  W18, W23, W5
    ORR  W18, W27, W10, LSR #9
    CRC32CW  W14, W14, W23
    ADD  W27, W7, #0xe50, LSL #12
    CSINC  W11, W22, W21, LT
    SUBS  X7, X14, #0x7d1
    ADCS  X24, X6, X26
    EXTR  X16, X28, X29, #0x0
    BIC  X28, X7, X11, ROR #32
    ADD  W18, W12, W24, UXTH #1
    ADDS  X12, X27, X16, ASR #50
    CSINC  W3, W10, W26, HI
    CLZ  X3, X10
    ADD  X10, X2, X6, ASR #33
    ADC  W8, W28, W7
    BIC  W2, W17, W20, ROR #16
    CSINV  X27, X12, X9, HI
    ANDS  X11, X3, #0xe007e007e007e007
    UMULH  X5, X3, X12
    EOR  W9, W11, #0xffffffc1
    SUBS  W9, W22, W6, ASR #5
    ADCS  X20, X3, X9
    ANDS  X27, X26, #0xfffdfffdfffdfffd
    ORN  X24, X15, X3, LSL #5
    ORR  X26, X9, #0xfe003ffffe003fff
    EON  W3, W5, W23, ROR #18
    ADD  X5, X7, #0x69b
    ADD  W17, W26, #0x50d
    CLS  V3.4S, V0.4S
    CRC32W  W27, W22, W28
    CRC32CX  W5, W23, X21
    SUBS  X19, X19, #0x1
    B.NE  TaishanIntMduP02_label_682
    MOVZ  X27, #0x200f, LSL #0
    MOVK  X27, #0x41c8, LSL #16
    SUB  X16, X27, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X11, #0x7824, LSL #0
    MOVK  X11, #0xa80, LSL #16
    SUB  X20, X11, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X21, #0xea28, LSL #0
    MOVK  X21, #0x88b5, LSL #16
    SUB  X9, X21, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X22, #0x688e, LSL #0
    MOVK  X22, #0x5724, LSL #16
    SUB  X6, X22, X6
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X28, #0xd2f9, LSL #0
    MOVK  X28, #0xb0a8, LSL #16
    SUB  X27, X28, X7
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X10, #0xa5f3, LSL #0
    MOVK  X10, #0x6151, LSL #16
    SUB  X7, X10, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X11, #0xa5f3, LSL #0
    MOVK  X11, #0x6151, LSL #16
    SUB  X18, X11, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X9, #0xa5f3, LSL #0
    MOVK  X9, #0x6151, LSL #16
    SUB  X22, X9, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP02_TestFail
    MOVZ  X9, #0x2f8d, LSL #0
    MOVK  X9, #0xdc2f, LSL #16
    SUB  X10, X9, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
    MOVZ  X19, #0x19f, LSL #0
    MOVK  X19, #0x9885, LSL #16
    MOVK  X19, #0xf4bd, LSL #32
    SUB  X11, X19, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X26, #0xdaca, LSL #0
    MOVK  X26, #0xb0a8, LSL #16
    SUB  X16, X26, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X18, X7, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP02_TestFail
    MOVZ  X24, #0x50c, LSL #0
    MOVK  X24, #0xff47, LSL #16
    SUB  X5, X24, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
    MOVZ  X3, #0x19f, LSL #0
    MOVK  X3, #0x9885, LSL #16
    MOVK  X3, #0xf4bd, LSL #32
    SUB  X17, X3, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X25, X20, X20
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP02_TestFail
    MOVZ  X9, #0xea28, LSL #0
    MOVK  X9, #0x88b5, LSL #16
    SUB  X19, X9, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X19, #0xd5fe, LSL #0
    MOVK  X19, #0x1f6f, LSL #16
    SUB  X17, X19, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP02_TestFail
    MOVZ  X8, #0x50c, LSL #0
    MOVK  X8, #0xff47, LSL #16
    SUB  X2, X8, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X24, #0xdaca, LSL #0
    MOVK  X24, #0xb0a8, LSL #16
    SUB  X7, X24, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X8, #0xd2f9, LSL #0
    MOVK  X8, #0xb0a8, LSL #16
    SUB  X2, X8, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
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
    MOVZ  X22, #0xa, LSL #0
TaishanIntMduP02_label_709:
    CLZ  X19, X17
    AND  X3, X8, #0x1800000000000000
    SUB  W26, W29, W19, UXTB #2
    EOR  X6, X15, X26, ROR #58
    EXTR  X27, X26, X15, #0x26
    LSLV  X14, X2, X19
    MOVZ  W15, #0x5a61, LSL #16
    CSINC  X15, X27, X8, CC
    ORR  W10, W5, #0x70007000
    ORR  X28, X27, X29, ROR #15
    CLS  V3.4S, V26.4S
    MADD  X7, X18, X29, X2
    CRC32W  W12, W15, W25
    AND  X9, X12, #0xfe0000
    ASRV  X3, X24, X28
    UBFM  W6, W15, #0x8, #0x10
    CSINV  W7, W28, W14, VS
    CLS  X17, X20
    ADCS  W18, W15, W5
    ADDS  W20, W17, W6, ASR #10
    CRC32CW  W24, W5, W7
    ORR  X26, X19, #0xbfffffffbfffffff
    ADCS  W15, W18, W7
    SMULH  X8, X6, X25
    MOVK  W15, #0x2b60, LSL #16
    ORR  X27, X26, X29, LSL #29
    CRC32X  W9, W27, X8
    UBFM  W6, W17, #0xd, #0x17
    SUBS  W18, W24, W24, SXTW #4
    ORR  W28, W2, W2, LSR #8
    SMSUBL  X19, W19, W29, X10
    AND  W17, W20, W24, ASR #1
    CRC32CW  W23, W22, W28
    SUBS  X19, X14, X21, SXTX #3
    ADDS  W25, W23, W15, UXTH #4
    MOVK  W17, #0x9236, LSL #16
    SBFM  W20, W11, #0x4, #0x15
    AND  W27, W17, W9, ASR #11
    CRC32X  W21, W20, X3
    SBFM  W6, W17, #0x13, #0x13
    MOVN  W17, #0x7533, LSL #0
    CLS  X3, X25
    CLS  X28, X16
    MOVN  X9, #0xe985, LSL #0
    ADC  X8, X8, X19
    MADD  X27, X23, X15, X8
    CRC32X  W16, W21, X12
    CRC32B  W6, W20, W2
    ORR  W13, W18, #0xe3ffe3ff
    AND  X24, X14, #0xff83ffffff83ffff
    ORR  W13, W11, W13, LSR #5
    EOR  W3, W3, #0xffe0ffe
    ADDS  X16, X22, #0xa18
    CSINV  X15, X21, X25, EQ
    CRC32X  W21, W3, X5
    ADDS  W9, W14, W11, SXTW #4
    BICS  W24, W29, W22, LSL #19
    UBFM  X21, X5, #0x12, #0x29
    EOR  W27, W3, W15, LSR #20
    CRC32W  W23, W18, W19
    UBFM  X19, X18, #0x2c, #0x2f
    BIC  X11, X28, X14, LSR #38
    CSEL  X14, X2, X10, HI
    MADD  W27, W15, W7, W29
    SUBS  X6, X17, X24, LSL #13
    ADC  X10, X22, X3
    EOR  W8, W11, #0x3f0
    MOVN  X16, #0x35a, LSL #0
    ORN  W20, W16, W13, ROR #24
    SUB  X29, X13, X8, UXTX #2
    SBFM  W20, W28, #0xc, #0x0
    ORR  V22.16B, V2.16B, V21.16B
    CRC32W  W8, W12, W6
    AND  W16, W14, #0xffffc03f
    ORR  V16.8B, V7.8B, V25.8B
    ADDS  X7, X20, #0xe6d, LSL #12
    MOVK  X16, #0x6b48, LSL #32
    ADD  X3, X27, #0x8f6
    SBFM  W7, W9, #0xc, #0x16
    SUB  W23, W14, #0x12f
    ORN  W10, W2, W14, LSL #24
    ORN  W6, W2, W22, LSL #25
    ADDS  X25, X6, W13, SXTH #4
    CLS  W25, W29
    CSINC  W14, W5, W25, CS
    ADDS  X12, X11, X3, ASR #27
    ASRV  W16, W8, W9
    ADC  W18, W17, W6
    SMADDL  X14, W27, W19, X16
    MADD  X2, X27, X8, X28
    MOVK  X29, #0x5099, LSL #0
    BICS  W17, W28, W20, ASR #18
    SUB  W9, W12, #0x278
    CSNEG  X29, X8, X24, NV
    ANDS  X26, X12, #0xc0000001c0000001
    ADD  X7, X5, W19, UXTH #4
    CLS  X16, X13
    CSEL  W12, W5, W24, VC
    LSRV  W16, W3, W29
    EON  W5, W29, W25, LSL #16
    SUBS  X6, X22, W9, SXTW #4
    CRC32B  W11, W7, W7
    LSLV  W14, W2, W5
    MOVK  X7, #0x9544, LSL #48
    ADCS  X16, X16, X19
    MOVN  X20, #0xd38, LSL #32
    SUBS  X11, X16, W25, UXTB #4
    UMULH  X19, X10, X14
    ORN  W2, W21, W3, LSR #12
    MOVN  X17, #0x96eb, LSL #0
    EOR  W11, W3, #0xc0ffc0ff
    ADCS  W24, W25, W13
    MADD  X23, X8, X11, X23
    ORR  V11.8B, V31.8B, V2.8B
    UMULH  X28, X14, X8
    CLS  V0.8H, V10.8H
    CLZ  W21, W25
    SUBS  X17, X6, X14, LSL #16
    ASRV  W21, W7, W21
    EOR  W29, W2, W8, LSR #6
    CLS  W15, W2
    SUB  X13, X27, #0x511, LSL #12
    MOVZ  W10, #0x636, LSL #16
    CSINC  X11, X23, X18, LT
    BIC  V27.8B, V11.8B, V24.8B
    SUBS  W26, W7, W27, UXTW #0
    ORR  W2, W11, #0xfffffc01
    CRC32CH  W7, W13, W6
    ORR  X8, X25, X22, ASR #31
    ASRV  X18, X10, X7
    ADD  X14, X9, W9, UXTB #3
    SUB  X18, X9, #0xe98
    MADD  W2, W16, W9, W22
    ADCS  X26, X23, X2
    SBFM  X16, X7, #0x1b, #0x2
    ADC  X10, X29, X7
    BIC  X2, X29, X26, ROR #52
    MADD  X5, X15, X2, X10
    SUBS  X27, X20, X3, LSR #34
    CLS  W20, W16
    ORR  W24, W8, W11, ROR #20
    ORR  V17.16B, V3.16B, V27.16B
    CSNEG  X13, X2, X18, HI
    CSINV  W2, W3, W29, MI
    CLZ  V24.8B, V9.8B
    ADDS  W27, W14, W9, SXTB #2
    SUBS  W26, W9, W17, UXTW #2
    EOR  W24, W15, W18, LSL #1
    ADDS  X15, X16, #0x2ae
    CRC32X  W26, W5, X16
    ORR  W18, W13, W26, ASR #31
    ADCS  X10, X9, X27
    ADDS  X29, X14, #0x4b5
    ORR  W11, W5, #0x801f801f
    UMSUBL  X3, W16, W25, X10
    UMULH  X7, X2, X17
    BICS  W8, W27, W3, ASR #27
    BIC  W17, W9, W5, ROR #17
    ADD  W16, W22, W8, SXTX #2
    AND  X5, X20, X23, LSL #27
    ASRV  X29, X23, X23
    EOR  X20, X6, X6, ROR #42
    EXTR  X21, X27, X2, #0x18
    SUBS  W17, W24, W11, LSL #21
    LSLV  W7, W10, W21
    EOR  W21, W14, #0x7ffe000
    SUB  W29, W21, W2, LSL #28
    AND  W15, W22, W12, LSL #28
    CLS  V22.16B, V23.16B
    ORR  W24, W3, W23, ROR #21
    ASRV  X3, X18, X7
    CSINC  W9, W14, W24, NE
    ADD  W12, W14, #0xbf2, LSL #12
    EON  X13, X9, X22, LSL #39
    UBFM  W21, W11, #0x10, #0x1
    SUBS  X6, X24, #0x470
    ASRV  W23, W25, W13
    CSEL  W12, W12, W26, CS
    EOR  W26, W10, #0x7fe00
    ADCS  W21, W11, W5
    MOVZ  W9, #0xa5bf, LSL #16
    ADD  X15, X3, #0x6f
    ADD  W6, W15, W24, UXTH #3
    ADDS  X2, X7, #0xae9
    SUBS  W20, W16, #0xab1, LSL #12
    MADD  W3, W14, W17, W10
    CSINV  W9, W29, W23, GE
    BICS  W8, W16, W9, LSL #7
    SUBS  X29, X16, X9, ASR #26
    ORR  X23, X26, #0xf01fffffffffffff
    UMULH  X26, X14, X21
    EON  W3, W8, W15, ROR #25
    ANDS  W21, W2, #0x1c1c1c1c
    EON  W17, W11, W28, ASR #25
    AND  W2, W7, W6, LSL #21
    CRC32H  W12, W14, W2
    LSRV  X2, X14, X27
    SUB  W25, W17, #0x120
    MOVK  W17, #0x1aef, LSL #16
    ADD  X27, X11, X11, LSR #11
    SUBS  X22, X22, #0x1
    B.NE  TaishanIntMduP02_label_709
    MOVZ  X12, #0x4, LSL #0
    SUB  X9, X12, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X27, #0x467d, LSL #0
    MOVK  X27, #0xb47e, LSL #16
    SUB  X25, X27, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X15, #0x232b, LSL #0
    MOVK  X15, #0xf69d, LSL #16
    SUB  X20, X15, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8000, LSL #16
    SUB  X8, X28, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X7, #0x1b4, LSL #0
    MOVK  X7, #0x1, LSL #32
    SUB  X3, X7, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X28, #0xdd9f, LSL #0
    MOVK  X28, #0xb79f, LSL #16
    SUB  X25, X28, X11
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP02_TestFail
    MOVZ  X24, #0x4, LSL #0
    SUB  X18, X24, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X17, #0xfb79, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xff7f, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X29, X17, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X14
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X10, #0x232b, LSL #0
    MOVK  X10, #0xf69d, LSL #16
    SUB  X13, X10, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP02_TestFail
    MOVZ  X18, #0xf79, LSL #0
    SUB  X20, X18, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X7, #0xfb79, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xff7f, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X22, X7, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP02_TestFail
    MOVZ  X5, #0xf79, LSL #0
    SUB  X29, X5, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X27, X8, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X7, #0x808, LSL #0
    SUB  X23, X7, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X5, #0x4, LSL #0
    SUB  X26, X5, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X21, X17, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X28
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X2, #0x2d7e, LSL #0
    MOVK  X2, #0x875a, LSL #16
    MOVK  X2, #0x70e8, LSL #32
    MOVK  X2, #0x5ae, LSL #48
    MOVZ  X3, #0xc9e9, LSL #0
    MOVK  X3, #0xc20, LSL #16
    MOVK  X3, #0x6969, LSL #32
    MOVK  X3, #0xe146, LSL #48
    MOVZ  X5, #0xc4e9, LSL #0
    MOVK  X5, #0x6b30, LSL #16
    MOVK  X5, #0xba5a, LSL #32
    MOVK  X5, #0xe7de, LSL #48
    MOVZ  X6, #0x6cf3, LSL #0
    MOVK  X6, #0x5f56, LSL #16
    MOVK  X6, #0x94a8, LSL #32
    MOVK  X6, #0x261c, LSL #48
    MOVZ  X7, #0x572c, LSL #0
    MOVK  X7, #0xb4fa, LSL #16
    MOVK  X7, #0x9a38, LSL #32
    MOVK  X7, #0xff92, LSL #48
    MOVZ  X8, #0x896, LSL #0
    MOVK  X8, #0xab68, LSL #16
    MOVK  X8, #0x76b0, LSL #32
    MOVK  X8, #0x8177, LSL #48
    MOVZ  X9, #0xa6b0, LSL #0
    MOVK  X9, #0xe0dc, LSL #16
    MOVK  X9, #0x8e54, LSL #32
    MOVK  X9, #0x5bd2, LSL #48
    MOVZ  X10, #0xd20f, LSL #0
    MOVK  X10, #0x9098, LSL #16
    MOVK  X10, #0x66, LSL #32
    MOVK  X10, #0x298, LSL #48
    MOVZ  X11, #0xd22c, LSL #0
    MOVK  X11, #0x154a, LSL #16
    MOVK  X11, #0xffc2, LSL #32
    MOVK  X11, #0xacae, LSL #48
    MOVZ  X12, #0x621c, LSL #0
    MOVK  X12, #0x566, LSL #16
    MOVK  X12, #0xbd5f, LSL #32
    MOVK  X12, #0x93b2, LSL #48
    MOVZ  X13, #0xf4b2, LSL #0
    MOVK  X13, #0x6ed3, LSL #16
    MOVK  X13, #0xf69d, LSL #32
    MOVK  X13, #0x6452, LSL #48
    MOVZ  X14, #0xaa0d, LSL #0
    MOVK  X14, #0xc86e, LSL #16
    MOVK  X14, #0xf12f, LSL #32
    MOVK  X14, #0xd0a4, LSL #48
    MOVZ  X15, #0x5945, LSL #0
    MOVK  X15, #0x97ee, LSL #16
    MOVK  X15, #0x3aa6, LSL #32
    MOVK  X15, #0xa0f2, LSL #48
    MOVZ  X16, #0x52ca, LSL #0
    MOVK  X16, #0x5976, LSL #16
    MOVK  X16, #0x8d18, LSL #32
    MOVK  X16, #0x2c1, LSL #48
    MOVZ  X17, #0x324a, LSL #0
    MOVK  X17, #0x6f8, LSL #16
    MOVK  X17, #0x33bf, LSL #32
    MOVK  X17, #0x872a, LSL #48
    MOVZ  X18, #0xe73b, LSL #0
    MOVK  X18, #0x8b96, LSL #16
    MOVK  X18, #0xd4ce, LSL #32
    MOVK  X18, #0xc62f, LSL #48
    MOVZ  X19, #0x2f4a, LSL #0
    MOVK  X19, #0xbba6, LSL #16
    MOVK  X19, #0x2b34, LSL #32
    MOVK  X19, #0xb226, LSL #48
    MOVZ  X20, #0x608, LSL #0
    MOVK  X20, #0xb01c, LSL #16
    MOVK  X20, #0xd55f, LSL #32
    MOVK  X20, #0xef7f, LSL #48
    MOVZ  X21, #0x37e, LSL #0
    MOVK  X21, #0x64ac, LSL #16
    MOVK  X21, #0x131, LSL #32
    MOVK  X21, #0x7964, LSL #48
    MOVZ  X22, #0x4a39, LSL #0
    MOVK  X22, #0x1e24, LSL #16
    MOVK  X22, #0xd79, LSL #32
    MOVK  X22, #0xab7, LSL #48
    MOVZ  X23, #0x6c19, LSL #0
    MOVK  X23, #0x7aa2, LSL #16
    MOVK  X23, #0x62e9, LSL #32
    MOVK  X23, #0x413e, LSL #48
    MOVZ  X24, #0xb665, LSL #0
    MOVK  X24, #0xb983, LSL #16
    MOVK  X24, #0xc482, LSL #32
    MOVK  X24, #0x52dd, LSL #48
    MOVZ  X25, #0xa9fa, LSL #0
    MOVK  X25, #0x2f19, LSL #16
    MOVK  X25, #0x2990, LSL #32
    MOVK  X25, #0x16c5, LSL #48
    MOVZ  X26, #0x58e0, LSL #0
    MOVK  X26, #0x9018, LSL #16
    MOVK  X26, #0x7243, LSL #32
    MOVK  X26, #0xcc78, LSL #48
    MOVZ  X27, #0xbd94, LSL #0
    MOVK  X27, #0xc8fa, LSL #16
    MOVK  X27, #0xe74, LSL #32
    MOVK  X27, #0x39e0, LSL #48
    MOVZ  X28, #0x2df1, LSL #0
    MOVK  X28, #0x38b0, LSL #16
    MOVK  X28, #0x6c80, LSL #32
    MOVK  X28, #0xc2ea, LSL #48
    MOVZ  X29, #0x4e39, LSL #0
    MOVK  X29, #0x2eed, LSL #16
    MOVK  X29, #0x12c9, LSL #32
    MOVK  X29, #0x172b, LSL #48
    MOVZ  X16, #0xa, LSL #0
TaishanIntMduP02_label_737:
    ADD  X5, X16, #0x500
    SBFM  W8, W10, #0x1e, #0x8
    CRC32CH  W11, W14, W10
    BIC  W27, W28, W26, LSL #28
    ORR  W24, W29, W16, ASR #11
    CLZ  X23, X25
    SUB  W25, W12, W12, UXTX #4
    BIC  W25, W27, W23, ASR #13
    SUB  X10, X11, X24, SXTX #2
    ORR  W25, W25, #0x400040
    ADDS  W9, W16, #0x349, LSL #12
    ADCS  X13, X5, X19
    ANDS  W29, W14, #0x7ff8
    CRC32CW  W8, W25, W5
    SBFM  W20, W27, #0xc, #0x15
    MOVZ  W8, #0xa1aa, LSL #0
    SUB  W24, W15, W29, UXTH #1
    UBFM  W13, W13, #0xc, #0x1
    SBFM  W13, W17, #0xd, #0x14
    BICS  W9, W18, W7, LSL #28
    ANDS  X8, X29, X8, ASR #54
    SUBS  X15, X16, X24, ASR #56
    CLZ  X23, X12
    SUBS  X20, X24, X14, ASR #12
    ADD  W11, W5, W22, SXTX #4
    ASRV  X2, X8, X7
    MOVK  X29, #0x2fa4, LSL #0
    CLZ  W24, W29
    CSNEG  X11, X9, X13, LT
    SUB  W17, W5, W11, LSR #21
    ORR  V15.2S, #0x14, LSL #16
    CSEL  X27, X14, X13, CS
    SUBS  X17, X16, X21, LSR #37
    CSINC  W25, W14, W14, PL
    EOR  X24, X23, X17, LSL #21
    SBFM  W10, W15, #0x15, #0x1b
    SBFM  W17, W9, #0x6, #0x1a
    SUBS  X9, X5, X29, ASR #63
    CSINC  X22, X25, X14, LS
    MOVZ  X19, #0xf89c, LSL #32
    SUBS  W24, W24, #0xed2
    CSINV  W21, W19, W16, LS
    SUBS  X20, X25, #0xaa3, LSL #12
    CLS  V23.8H, V25.8H
    ADD  X14, X29, W21, SXTW #3
    AND  W20, W11, #0x803f803f
    EXTR  X10, X20, X18, #0x3b
    ORR  X9, X16, #0x1fe000
    BIC  V11.16B, V30.16B, V15.16B
    CSEL  W27, W10, W27, PL
    EOR  W15, W26, W25, ROR #20
    EXTR  X25, X20, X26, #0x26
    ASRV  W22, W19, W25
    SMSUBL  X10, W23, W7, X27
    ORR  V3.4S, #0x13, LSL #8
    EXTR  W14, W24, W10, #0x19
    ADD  W28, W9, W22, SXTB #1
    MOVZ  X10, #0x6e50, LSL #0
    ORR  W12, W5, W13, LSR #13
    ORR  V0.4S, #0x5a, LSL #8
    MOVN  X29, #0x8e48, LSL #0
    SUBS  X29, X3, X5, ASR #49
    SMULH  X25, X15, X9
    ORR  V17.4S, #0x83, LSL #8
    CRC32X  W15, W6, X13
    ORR  W22, W29, #0x83ff83ff
    EOR  X7, X26, X18, ROR #15
    MOVZ  W6, #0x3ed6, LSL #0
    ASRV  W5, W20, W27
    CSINV  W28, W15, W3, CS
    EON  X10, X8, X25, LSR #55
    ADDS  W9, W14, #0x24f, LSL #12
    SBFM  W19, W12, #0x1, #0x1a
    UMULH  X25, X22, X14
    ADDS  X6, X14, X17, LSL #60
    EOR  X21, X20, #0xfc7ffc7ffc7ffc7f
    SUB  X5, X15, X15, UXTX #1
    MOVN  W28, #0x27cc, LSL #0
    SMSUBL  X23, W29, W9, X18
    EON  W27, W24, W23, LSL #17
    ADDS  W15, W12, #0x498
    EON  X19, X29, X12, ROR #47
    BIC  V19.16B, V25.16B, V20.16B
    MOVN  X9, #0x432, LSL #16
    EOR  X13, X6, X20, ROR #38
    EON  X7, X19, X10, ASR #7
    ORR  V31.4H, #0xf3
    ORR  V10.4S, #0xe6, LSL #24
    SUB  W26, W27, W21, LSL #25
    CRC32W  W26, W8, W5
    ADD  X18, X9, W5, SXTB #0
    MOVZ  X29, #0x4ec9, LSL #16
    ADDS  W28, W9, W11, LSL #18
    ADD  X12, X21, #0x73d
    ADC  X27, X28, X27
    ADCS  W19, W27, W22
    ORN  W25, W24, W19, LSR #12
    LSLV  W18, W24, W2
    ADD  X9, X8, X6, ASR #34
    ADD  W18, W15, W19, SXTW #1
    CRC32H  W13, W20, W5
    CLZ  W24, W19
    AND  W24, W21, #0xfe0003ff
    ADCS  W25, W3, W2
    ADDS  W14, W7, #0xc90
    SUB  X10, X13, W19, SXTB #3
    CLS  V31.16B, V25.16B
    ORN  X23, X21, X12, ASR #32
    SUB  W29, W14, W13, LSL #15
    ADDS  X22, X9, X23, SXTX #1
    SUB  W25, W5, W21, ASR #16
    CLS  V21.4H, V5.4H
    ASRV  X29, X21, X17
    ORR  V29.8H, #0x6d
    LSRV  W14, W18, W25
    CRC32CB  W20, W15, W12
    EOR  W27, W17, #0x80ff80ff
    UMSUBL  X6, W2, W28, X2
    EON  W27, W14, W5, ASR #29
    ANDS  W6, W11, #0x1fff8
    EON  W7, W22, W22, LSR #13
    CLS  W7, W3
    BICS  W11, W10, W5, ASR #27
    SUBS  W29, W25, #0xcc3
    UBFM  X26, X11, #0x1a, #0x34
    SMSUBL  X11, W18, W7, X27
    ORR  W23, W25, W20, LSR #16
    CRC32CX  W18, W14, X17
    BIC  X24, X3, X16, ROR #61
    ADDS  X27, X10, X10, ASR #2
    MOVZ  W26, #0xc82f, LSL #16
    EOR  W21, W15, W7, LSL #11
    AND  W14, W10, W12, ASR #5
    ORR  X12, X26, #0xff8000000000001f
    CRC32B  W28, W16, W27
    UMULH  X5, X7, X5
    BIC  V19.8B, V28.8B, V7.8B
    LSLV  W26, W25, W29
    ORR  W21, W15, #0xff0007ff
    EOR  W18, W8, #0x700070
    MADD  W12, W18, W17, W23
    EOR  X21, X22, #0xfff00000fff0
    SUB  W25, W25, W11, LSR #11
    ORR  V22.16B, V24.16B, V30.16B
    ANDS  W17, W15, #0xf803ffff
    UMULH  X14, X9, X14
    MOVK  W19, #0xe411, LSL #16
    EOR  X15, X25, X24, LSR #15
    ASRV  W9, W29, W6
    MOVZ  W9, #0xc6e5, LSL #16
    CSINV  X24, X25, X13, GT
    ADCS  W28, W3, W11
    BIC  W8, W26, W7, ASR #25
    ORR  V2.8H, #0xde, LSL #8
    ASRV  W19, W25, W8
    EXTR  W29, W24, W7, #0x13
    ASRV  W7, W9, W24
    SUB  X18, X2, #0x19c, LSL #12
    CLZ  X11, X28
    ANDS  W15, W22, #0x70707070
    UBFM  W17, W19, #0x1a, #0x1c
    ORN  X19, X12, X21, ASR #45
    CLS  X27, X19
    ASRV  X26, X19, X12
    UBFM  W19, W15, #0x5, #0x10
    ADD  X21, X13, W11, UXTW #0
    AND  W8, W16, W8, LSR #24
    EXTR  W21, W17, W19, #0x18
    ANDS  X10, X8, X15, ASR #57
    ORN  X12, X8, X16, LSR #25
    SBFM  X21, X17, #0x3a, #0x2b
    SUB  X18, X27, W14, UXTW #1
    ADC  X9, X21, X9
    SBFM  X28, X26, #0x20, #0x39
    SUBS  W8, W29, W7, SXTX #3
    MADD  W13, W5, W10, W26
    UMSUBL  X27, W8, W16, X12
    CSINV  W5, W10, W22, LT
    CSINV  X5, X6, X26, PL
    MOVN  W20, #0x7745, LSL #16
    ADD  X15, X18, #0x937, LSL #12
    BIC  W5, W17, W17, ROR #24
    EOR  X26, X11, #0xffffffffffffe
    ORR  V17.2S, #0x77
    CRC32W  W18, W6, W7
    SMSUBL  X9, W26, W11, X22
    MOVZ  X20, #0x4cf1, LSL #0
    SUB  X14, X21, #0x60
    AND  X12, X18, X9, ASR #8
    UBFM  W21, W6, #0x14, #0xf
    ORR  W18, W22, #0xe00001ff
    ADCS  X12, X17, X11
    CSINV  X14, X7, X26, CS
    MOVN  X13, #0xad91, LSL #0
    CLZ  W9, W29
    MOVN  X13, #0xed33, LSL #0
    BICS  X6, X19, X19, ROR #42
    UMADDL  X9, W22, W20, X24
    ASRV  W10, W3, W11
    BICS  W13, W21, W15, ASR #0
    SUBS  X16, X16, #0x1
    B.NE  TaishanIntMduP02_label_737
    MOVZ  X7, #0x0, LSL #0
    SUB  X28, X7, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP02_TestFail
    MOVZ  X18, #0xc9e9, LSL #0
    MOVK  X18, #0xc20, LSL #16
    MOVK  X18, #0x6969, LSL #32
    MOVK  X18, #0xe146, LSL #48
    SUB  X2, X18, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X13, #0x4, LSL #0
    SUB  X21, X13, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X21, #0x383, LSL #0
    SUB  X24, X21, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
    MOVZ  X11, #0x6000, LSL #0
    MOVK  X11, #0x19af, LSL #16
    SUB  X26, X11, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X26, #0xc163, LSL #0
    MOVK  X26, #0x4f87, LSL #16
    MOVK  X26, #0x4bbd, LSL #32
    SUB  X16, X26, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X21, #0x6000, LSL #0
    MOVK  X21, #0x19af, LSL #16
    SUB  X27, X21, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X3, #0x24, LSL #0
    SUB  X26, X3, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X6, #0x4, LSL #0
    SUB  X7, X6, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X17, #0x21, LSL #0
    MOVK  X17, #0xfff0, LSL #48
    SUB  X10, X17, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X13, X22, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X2, #0x21, LSL #0
    MOVK  X2, #0xfff0, LSL #48
    SUB  X21, X2, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X29, #0xc9e9, LSL #0
    MOVK  X29, #0xc20, LSL #16
    MOVK  X29, #0x6969, LSL #32
    MOVK  X29, #0xe146, LSL #48
    SUB  X7, X29, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X9, #0x383, LSL #0
    SUB  X28, X9, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP02_TestFail
    MOVZ  X22, #0x4cf1, LSL #0
    SUB  X19, X22, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X21
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X11, #0x4cf1, LSL #0
    SUB  X19, X11, X22
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X23, #0x7fdd, LSL #0
    MOVK  X23, #0x13a3, LSL #16
    SUB  X22, X23, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntMduP02_TestFail
    MOVZ  X9, #0x5b45, LSL #0
    MOVK  X9, #0x1388, LSL #16
    SUB  X18, X9, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X24, #0xc9e9, LSL #0
    MOVK  X24, #0xc20, LSL #16
    MOVK  X24, #0x6969, LSL #32
    MOVK  X24, #0xe146, LSL #48
    SUB  X23, X24, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP02_TestFail
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
    MOVZ  X8, #0xa, LSL #0
TaishanIntMduP02_label_764:
    SUB  W13, W22, W15, UXTX #1
    ANDS  W5, W22, W27, LSR #9
    CSINV  X5, X6, X19, EQ
    SMULH  X21, X8, X20
    LSRV  W11, W27, W10
    ADDS  X25, X16, #0xe0c, LSL #12
    SMSUBL  X16, W12, W28, X15
    BIC  X25, X23, X9, ROR #61
    CRC32CH  W28, W6, W16
    MADD  W14, W22, W21, W16
    CSINV  W21, W13, W24, EQ
    SMADDL  X9, W21, W16, X21
    EXTR  X10, X26, X6, #0x8
    SMSUBL  X23, W17, W5, X25
    MOVK  X28, #0x5fdb, LSL #16
    SUBS  X13, X2, W11, SXTB #3
    EOR  W24, W14, #0xc1ffc1ff
    ORR  V29.16B, V24.16B, V10.16B
    CRC32H  W16, W5, W12
    MOVK  X3, #0xef86, LSL #0
    ADD  X16, X2, W12, UXTB #4
    SUB  X24, X6, W6, SXTB #1
    CLZ  X12, X29
    CLS  V11.2S, V5.2S
    ANDS  W27, W22, #0xff07ff07
    CSNEG  X19, X19, X6, EQ
    EOR  W16, W15, W22, ASR #18
    BICS  X22, X9, X19, ROR #23
    UBFM  W11, W20, #0xd, #0xf
    ADCS  X10, X6, X20
    CSEL  X12, X23, X26, PL
    ADDS  W22, W6, #0x154
    SUBS  X29, X25, #0x1b6, LSL #12
    EOR  W18, W3, #0xc00001ff
    ADDS  W6, W13, W17, LSR #4
    ANDS  W24, W28, #0x800000ff
    ADDS  X6, X29, #0x12a, LSL #12
    LSRV  W24, W18, W5
    LSLV  W20, W21, W26
    ANDS  X5, X22, X19, ROR #2
    MOVN  W17, #0x908e, LSL #16
    CSINV  W19, W29, W19, CS
    ANDS  X23, X20, #0xffffff800003ffff
    LSLV  X3, X8, X8
    SUBS  W20, W11, W11, UXTW #4
    SUB  X5, X18, #0xea7
    CRC32CH  W25, W17, W10
    LSRV  X14, X27, X8
    CSNEG  X5, X22, X19, LT
    CRC32CW  W18, W23, W14
    CSNEG  X18, X10, X21, AL
    SUBS  W18, W18, W21, UXTH #2
    SUB  X12, X8, #0xfb5
    ORN  W20, W25, W17, ASR #11
    ADD  X20, X15, X24, ASR #54
    CLZ  X6, X20
    CSEL  X12, X14, X20, AL
    SUBS  X29, X8, X3, SXTX #3
    CSEL  X11, X29, X5, MI
    EXTR  X3, X22, X24, #0x11
    ADCS  X20, X16, X29
    CRC32CX  W18, W11, X28
    LSRV  W25, W8, W10
    SBFM  X18, X21, #0xc, #0x1c
    ADD  X13, X8, X8, LSL #52
    SUBS  X9, X27, #0x4f
    ASRV  X9, X19, X10
    EXTR  X23, X26, X16, #0x33
    SMADDL  X13, W20, W10, X24
    CRC32CW  W15, W7, W10
    UMULH  X26, X7, X5
    ADDS  W3, W21, W16, LSR #7
    SMULH  X6, X27, X10
    BICS  W26, W7, W28, LSR #23
    MOVZ  W13, #0x783, LSL #16
    ORR  V14.16B, V25.16B, V14.16B
    CSINC  X12, X3, X7, VC
    BICS  X6, X27, X26, LSL #61
    ADDS  X19, X3, #0x9a4
    ORR  X17, X10, #0xfffffffffc000
    UMSUBL  X6, W20, W24, X8
    ANDS  X18, X16, #0xe0000000
    EOR  W17, W14, W17, LSR #8
    CSINC  X19, X14, X25, LT
    ADD  X14, X20, #0x263
    ADC  X28, X28, X16
    ANDS  W21, W14, W11, LSL #9
    ORR  W29, W24, W9, ASR #13
    CLZ  V7.2S, V16.2S
    CRC32W  W3, W5, W14
    EXTR  X21, X20, X7, #0x4
    BIC  W13, W6, W25, LSL #25
    CRC32H  W12, W17, W25
    ADD  W13, W26, #0x3ba, LSL #12
    SUBS  W23, W6, #0x540
    CRC32X  W19, W8, X21
    AND  W10, W10, #0x6
    ADDS  W9, W12, #0x2bc, LSL #12
    UMADDL  X18, W12, W2, X2
    CRC32H  W27, W23, W13
    CRC32CX  W19, W3, X3
    AND  W17, W19, #0x1c0000
    AND  W18, W17, W21, ROR #12
    ADDS  X29, X6, W11, SXTB #0
    EON  W17, W20, W15, LSL #25
    EOR  X6, X14, #0xffe03fffffe03fff
    SUB  X20, X6, W20, UXTH #1
    ADC  X15, X25, X19
    EXTR  X13, X24, X15, #0x10
    ORN  W3, W28, W23, LSL #7
    ANDS  W19, W14, W13, ASR #19
    SMULH  X23, X13, X27
    SUBS  W12, W20, W6, ASR #31
    BIC  X3, X2, X21, ASR #3
    AND  X17, X11, #0xffc
    ADD  W17, W22, #0xb54, LSL #12
    UBFM  X23, X19, #0xc, #0x4
    CLS  V23.16B, V14.16B
    CRC32CB  W23, W7, W26
    CRC32CB  W22, W23, W13
    LSLV  X7, X11, X22
    ADD  X28, X25, X14, LSR #56
    ADC  X3, X26, X16
    CSNEG  W11, W11, W24, LT
    UMSUBL  X11, W21, W7, X20
    ADD  W12, W12, #0x32d
    SUBS  X5, X11, X2, ASR #24
    ADD  X15, X12, X28, ASR #26
    SUBS  W17, W26, W12, SXTH #3
    MOVZ  X27, #0x111a, LSL #48
    ADDS  X13, X19, X7, LSR #33
    ADDS  X23, X17, #0xa48
    CSEL  X24, X27, X5, LS
    CRC32H  W3, W29, W13
    EOR  W21, W5, W9, LSR #19
    CSEL  W6, W13, W26, HI
    SMSUBL  X3, W2, W10, X25
    MOVZ  X2, #0x5853, LSL #0
    BICS  X11, X12, X20, ASR #2
    SMSUBL  X17, W24, W28, X15
    ASRV  X11, X8, X3
    CSINC  W22, W23, W24, EQ
    SBFM  W28, W23, #0x12, #0x18
    ADD  X10, X28, W24, SXTB #0
    ADDS  W11, W17, #0x4fa, LSL #12
    SUBS  X14, X28, W25, SXTH #3
    CSINC  W6, W28, W2, NE
    CRC32H  W18, W22, W9
    EOR  X14, X16, X23, ASR #53
    SUBS  W10, W26, W7, SXTX #0
    ADD  X10, X14, W21, SXTH #1
    LSLV  X14, X25, X3
    ASRV  X15, X27, X19
    ADDS  W15, W6, #0x316
    MOVN  W10, #0x73c1, LSL #16
    MOVZ  W17, #0x2eb0, LSL #16
    CSINC  W15, W16, W10, CS
    ANDS  W27, W23, #0xe7e7e7e7
    AND  X11, X2, X8, ROR #22
    ADDS  W22, W15, #0x8c0
    LSRV  W22, W25, W2
    ORR  V16.4H, #0xbf, LSL #8
    EOR  X27, X27, #0x303030303030303
    SBFM  X9, X13, #0x36, #0x1c
    ADD  W7, W14, W28, ASR #9
    ORN  W19, W5, W29, LSR #6
    EOR  W23, W6, #0xff00ff0
    CLZ  X26, X13
    SBFM  X16, X17, #0x2f, #0x1e
    EOR  X16, X7, #0x20000
    MOVK  X26, #0xdf49, LSL #48
    ORN  W26, W14, W9, LSL #23
    ADCS  X29, X20, X14
    ASRV  X2, X19, X29
    ADDS  X13, X27, X9, LSR #32
    UBFM  X14, X9, #0x3f, #0x2e
    CSEL  X14, X14, X26, VC
    ADDS  X25, X20, W14, SXTH #3
    EXTR  W17, W10, W16, #0x14
    CLS  W24, W29
    SUBS  W28, W28, W19, LSR #6
    CSINC  W14, W6, W20, NE
    SUB  X14, X2, W9, UXTB #1
    ADD  W17, W6, W3, UXTH #0
    MOVN  W17, #0xc995, LSL #16
    EOR  X27, X22, X23, ASR #59
    MOVN  W3, #0x8373, LSL #16
    CSINV  X19, X2, X24, HI
    LSRV  X29, X8, X16
    LSRV  X17, X13, X24
    UBFM  X10, X9, #0x31, #0x2c
    LSRV  X6, X2, X7
    SUB  X7, X26, #0x254
    CLZ  V12.4S, V27.4S
    CSINC  X21, X27, X9, VC
    SBFM  X14, X8, #0xa, #0x2c
    ADDS  W6, W8, W23, SXTH #1
    ADD  W23, W8, W21, LSL #17
    BIC  X6, X8, X19, LSR #52
    ADD  W14, W29, W16, LSL #18
    SUBS  X8, X8, #0x1
    B.NE  TaishanIntMduP02_label_764
    MOVZ  X24, #0xefb7, LSL #0
    MOVK  X24, #0x7f, LSL #16
    SUB  X12, X24, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP02_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0x7c8c, LSL #16
    SUB  X9, X6, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X14, #0x2bf9, LSL #0
    MOVK  X14, #0xf3dd, LSL #16
    MOVK  X14, #0x402c, LSL #32
    MOVK  X14, #0xefe0, LSL #48
    SUB  X29, X14, X5
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0x7c8c, LSL #16
    SUB  X15, X6, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X6, #0xfdab, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X3, X6, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X14, X12, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0xfe00, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xfff, LSL #48
    SUB  X13, X20, X10
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntMduP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X21, X10, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X15
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP02_TestFail
    MOVZ  X26, #0xe482, LSL #0
    MOVK  X26, #0xe4e6, LSL #16
    MOVK  X26, #0x304, LSL #32
    MOVK  X26, #0x303, LSL #48
    SUB  X19, X26, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X9, #0xfcc7, LSL #0
    MOVK  X9, #0xc97a, LSL #16
    SUB  X15, X9, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntMduP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xfe00, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xfff, LSL #48
    SUB  X9, X19, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntMduP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X21
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntMduP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntMduP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X20, #0xefb7, LSL #0
    MOVK  X20, #0x7f, LSL #16
    SUB  X21, X20, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X5, X17, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP02_TestFail
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
TaishanIntMduP02_label_659:
    MOVK  X19, #0xffff, LSL #48
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
TaishanIntMduP02_label_30:
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
    MOVZ  X11, #0xa, LSL #0
TaishanIntMduP02_label_791:
    LSRV  W26, W11, W14
    ASRV  W29, W12, W6
    CLS  X3, X29
    ADDS  X10, X24, X14, LSR #30
    UMADDL  X21, W10, W3, X27
    SBFM  W8, W17, #0x1c, #0x18
    ADD  X21, X22, W21, SXTH #2
    UMSUBL  X28, W6, W9, X10
    BICS  W22, W8, W21, ASR #11
    UBFM  X25, X8, #0x1, #0x31
    SBFM  X18, X28, #0x2d, #0x3
    ADD  X17, X12, X15, LSR #19
    CLS  V11.4S, V7.4S
    ADDS  W7, W19, #0x330
    ANDS  W19, W19, #0x7070707
    SUBS  X10, X28, X26, LSR #47
    CSINC  W28, W11, W9, PL
    ADCS  X27, X26, X22
    BICS  X17, X26, X12, ASR #17
    SBFM  X29, X24, #0x3e, #0x23
    ADD  W18, W21, W12, UXTH #0
    CSEL  W23, W23, W6, NV
    ADDS  X26, X12, X22, SXTX #1
    ADDS  X19, X21, #0x7d8, LSL #12
    CRC32CX  W27, W18, X6
    SUB  X26, X27, #0x5a7, LSL #12
    SUB  X22, X17, X13, ASR #0
    EXTR  X24, X22, X10, #0x2d
    ORR  X25, X3, X27, ROR #59
    ORR  X19, X13, #0xfff0007ffff0007f
    ADCS  W9, W16, W22
    UBFM  X20, X9, #0x1e, #0x38
    EON  W17, W11, W8, LSL #13
    CSINC  X17, X19, X7, VC
    ORR  V7.8B, V31.8B, V24.8B
    MOVN  X27, #0x362c, LSL #32
    ADDS  W19, W21, W20, LSR #1
    SBFM  W23, W5, #0x3, #0x13
    SUBS  W6, W27, W27, LSL #21
    BICS  X18, X24, X13, LSL #2
    ADCS  W19, W19, W16
    ORR  W14, W9, W8, LSL #9
    ORR  V27.4S, #0xa, LSL #8
    MADD  X13, X25, X27, X21
    CLS  V2.8H, V30.8H
    EOR  X18, X5, X12, LSR #14
    SUB  W3, W20, W10, LSR #11
    LSRV  X8, X3, X13
    EXTR  W18, W19, W22, #0xb
    AND  X15, X27, #0x5555555555555555
    CSEL  W13, W9, W9, LS
    EXTR  W5, W5, W15, #0x12
    BICS  W27, W21, W17, ROR #12
    CRC32CW  W13, W23, W24
    LSLV  X26, X13, X17
    ADD  W19, W6, W3, LSL #2
    LSLV  W7, W22, W10
    SBFM  W5, W11, #0x0, #0x5
    ADC  W26, W7, W25
    CRC32B  W8, W17, W19
    CSINC  X3, X15, X10, VS
    MOVZ  W18, #0x6646, LSL #0
    MOVZ  X18, #0xfa3e, LSL #32
    SUB  X21, X18, W16, SXTW #3
    SMSUBL  X22, W21, W3, X9
    SUB  W20, W11, #0xa73, LSL #12
    AND  W5, W18, #0x60606060
    SMADDL  X8, W27, W24, X21
    ADCS  X8, X18, X26
    SUB  X29, X25, X20, ASR #36
    ADC  W22, W24, W16
    EOR  X20, X25, X5, ROR #11
    CRC32H  W3, W3, W5
    MOVN  X24, #0x34bc, LSL #48
    SMADDL  X24, W12, W18, X3
    EOR  X29, X15, #0x5555555555555555
    BICS  X21, X10, X15, LSL #19
    AND  X14, X29, X26, ASR #50
    ANDS  X27, X22, #0xff000000000007ff
    ORR  W28, W11, W13, ASR #5
    ADD  W24, W17, W13, LSR #30
    ANDS  X15, X15, #0xfe00fe00fe00fe0
    SMULH  X17, X21, X15
    SUB  W6, W28, W25, UXTW #0
    SUB  X20, X5, X19, LSL #10
    ORR  V6.16B, V5.16B, V3.16B
    SUBS  X19, X17, W10, UXTH #3
    ORR  W26, W13, W28, ROR #4
    CLZ  V11.2S, V23.2S
    ADD  W18, W23, #0x8d4
    MOVK  X14, #0x6617, LSL #0
    AND  W17, W2, #0xbfffbfff
    ASRV  W15, W8, W26
    SMULH  X21, X28, X26
    SUBS  X2, X29, X2, LSR #13
    EON  W19, W22, W25, ROR #28
    ORR  V4.2S, #0xa3, LSL #8
    EXTR  W3, W16, W22, #0xb
    UBFM  W25, W21, #0x5, #0x8
    CSEL  X21, X21, X16, NE
    CLS  X5, X2
    ORR  W26, W8, #0xf7fff7ff
    CRC32CH  W2, W23, W18
    ADDS  X14, X12, #0x313
    ADD  X24, X3, X19, LSL #23
    SMULH  X22, X14, X5
    AND  W22, W22, W19, LSL #10
    ADD  W5, W3, #0xa0f
    ADCS  W3, W14, W25
    ANDS  W17, W28, W15, ROR #9
    ANDS  X19, X21, X17, ASR #39
    CRC32X  W3, W14, X26
    CLS  W29, W19
    ORR  X29, X9, #0x3ffc0
    SUBS  W8, W16, #0x39d, LSL #12
    SUBS  W9, W3, #0x772
    CSINC  X15, X26, X23, HI
    ORN  X3, X23, X7, ASR #27
    AND  X5, X6, #0x3030303030303030
    LSRV  X26, X17, X26
    UMADDL  X16, W24, W21, X24
    SUB  X24, X9, X17, LSR #2
    CLZ  V17.8B, V19.8B
    AND  X21, X26, #0xffffe000000007ff
    ANDS  W19, W2, W15, ROR #8
    UMADDL  X25, W23, W22, X24
    SUB  X9, X14, X16, ASR #61
    CLZ  W25, W11
    SBFM  X22, X15, #0x39, #0x2b
    ASRV  X8, X26, X26
    SBFM  X5, X18, #0xb, #0x37
    ORR  V17.16B, V24.16B, V29.16B
    SUB  X18, X11, #0xcf0, LSL #12
    ORR  V9.4S, #0x28, LSL #8
    CRC32B  W26, W9, W12
    ORR  V23.2S, #0x8b, LSL #8
    CSEL  W24, W14, W17, PL
    BIC  W8, W12, W3, LSL #7
    SUBS  W10, W19, W15, SXTW #0
    ANDS  W3, W23, W10, LSL #22
    ADCS  W27, W16, W29
    CLZ  W13, W23
    SUB  W23, W11, #0x143
    ADDS  W25, W2, W13, LSL #18
    ORR  X8, X2, #0xfffffbfffffffbff
    ORR  V29.4S, #0x27, LSL #8
    ADD  X18, X28, X22, ASR #44
    CRC32CH  W26, W6, W14
    CRC32H  W12, W24, W5
    CSINC  W5, W26, W28, NE
    MOVK  X23, #0x8fc1, LSL #0
    LSLV  X13, X3, X28
    ADD  X6, X5, W12, UXTW #1
    ADCS  W19, W27, W22
    UBFM  X7, X12, #0x0, #0xe
    ADC  X5, X15, X29
    SUBS  W12, W24, W21, SXTX #0
    UMADDL  X13, W21, W14, X11
    CRC32B  W23, W21, W6
    SUBS  X13, X17, W23, SXTB #0
    SBFM  W18, W3, #0xa, #0xf
    SMADDL  X9, W24, W10, X23
    CSEL  X20, X9, X5, LS
    SBFM  W20, W10, #0x17, #0xf
    UMSUBL  X18, W16, W29, X12
    ADD  W7, W23, #0x975
    SBFM  X29, X11, #0x2, #0x33
    ANDS  W21, W27, #0xfffff03f
    CLZ  V25.16B, V2.16B
    CSEL  W23, W11, W17, MI
    CRC32CB  W23, W7, W17
TaishanIntMduP02_label_269:
    SUB  X12, X11, #0x0
    UBFM  X8, X25, #0x2e, #0x24
    CLZ  X21, X12
    CRC32CW  W2, W13, W26
    CLZ  V31.8H, V11.8H
    ADD  X23, X12, #0x9af
    CRC32X  W7, W10, X17
    ORR  X18, X11, X5, ASR #51
    SUBS  X28, X28, X12, LSL #39
    SUB  W8, W20, #0x86f
    MADD  W22, W21, W13, W20
    CRC32CX  W20, W24, X22
    SUB  W19, W9, #0xbd0, LSL #12
    CLS  W21, W29
    CRC32CB  W15, W2, W18
    MOVN  W28, #0x8d0e, LSL #16
    UBFM  X27, X28, #0x3a, #0x7
    LSLV  X20, X7, X11
    SUBS  X2, X11, W22, UXTW #3
    EOR  W12, W6, W7, ASR #18
    CSINC  X2, X27, X25, NE
    CRC32CB  W6, W9, W12
    CLS  W7, W17
    CSNEG  X22, X13, X29, CS
    AND  X9, X19, #0xffff0001ffff0001
    EXTR  W5, W22, W24, #0x9
    SMADDL  X29, W3, W10, X9
    ANDS  W22, W9, W12, LSL #9
    SMSUBL  X24, W8, W22, X3
    SUBS  X11, X11, #0x1
    B.NE  TaishanIntMduP02_label_791
    MOVZ  X9, #0x3fc0, LSL #0
    SUB  X7, X9, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X3, X20, X3
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X6, #0x532f, LSL #0
    MOVK  X6, #0x6e, LSL #16
    SUB  X16, X6, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x532f, LSL #0
    MOVK  X20, #0x6e, LSL #16
    SUB  X2, X20, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntMduP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X10, X2, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntMduP02_TestFail
    MOVZ  X3, #0xa791, LSL #0
    MOVK  X3, #0x6f, LSL #16
    SUB  X18, X3, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X14, #0x3fc0, LSL #0
    SUB  X27, X14, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X19, X14, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntMduP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X18, X3, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntMduP02_TestFail
    MOVZ  X25, #0xb570, LSL #0
    MOVK  X25, #0x46d0, LSL #16
    SUB  X27, X25, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X2, #0xe554, LSL #0
    MOVK  X2, #0x28c, LSL #16
    SUB  X21, X2, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X14, X28, X14
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntMduP02_TestFail
    MOVZ  X18, #0xc3d6, LSL #0
    MOVK  X18, #0xf835, LSL #16
    SUB  X29, X18, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntMduP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP02_TestFail
    MOVZ  X11, #0xe595, LSL #0
    MOVK  X11, #0x28c, LSL #16
    SUB  X27, X11, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntMduP02_TestFail
    MOVZ  X14, #0xc3d6, LSL #0
    MOVK  X14, #0xf835, LSL #16
    SUB  X5, X14, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntMduP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanIntMduP02_TestFail
    MOVZ  X13, #0x532f, LSL #0
    MOVK  X13, #0x6e, LSL #16
    SUB  X17, X13, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntMduP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X28, X13, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x8100, LSL #16
    SUB  X20, X9, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X3, #0x9b0, LSL #0
    SUB  X21, X3, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntMduP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xef00, LSL #16
    MOVK  X16, #0x6420, LSL #32
    MOVK  X16, #0x37, LSL #48
    SUB  X20, X16, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntMduP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntMduP02_TestFail
    MOVZ  X26, #0x16fc, LSL #0
    MOVK  X26, #0x881d, LSL #16
    SUB  X25, X26, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntMduP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntMduP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntMduP02_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntMduP02_TestFail

TaishanIntMduP02_TestEnd:
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
TaishanIntMduP02_TestFail:
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
