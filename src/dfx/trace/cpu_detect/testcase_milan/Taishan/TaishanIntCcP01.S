.global TaishanIntCcP01

.text
.p2align 4

TaishanIntCcP01:

TaishanIntCcP01_TestBegin:
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
    MOVK  X2, #0xae9f, LSL #48
    MOVK  X2, #0x2125, LSL #32
    MOVK  X2, #0xc9c6, LSL #16
    MOVK  X2, #0x5636, LSL #0
    MOVK  X4, #0x4536, LSL #48
    MOVK  X4, #0x66f0, LSL #32
    MOVK  X4, #0x632f, LSL #16
    MOVK  X4, #0x90bf, LSL #0
    MOVK  X5, #0xdf97, LSL #48
    MOVK  X5, #0x9bd0, LSL #32
    MOVK  X5, #0xe110, LSL #16
    MOVK  X5, #0xe33, LSL #0
    MOVK  X6, #0x87cc, LSL #48
    MOVK  X6, #0xc35f, LSL #32
    MOVK  X6, #0xe460, LSL #16
    MOVK  X6, #0xafc3, LSL #0
    MOVK  X7, #0x5a0b, LSL #48
    MOVK  X7, #0xa6a0, LSL #32
    MOVK  X7, #0xad9c, LSL #16
    MOVK  X7, #0x89b, LSL #0
    MOVK  X8, #0xb5b3, LSL #48
    MOVK  X8, #0xc08d, LSL #32
    MOVK  X8, #0xb57a, LSL #16
    MOVK  X8, #0xae39, LSL #0
    MOVK  X9, #0xb86e, LSL #48
    MOVK  X9, #0x43c0, LSL #32
    MOVK  X9, #0x56c3, LSL #16
    MOVK  X9, #0xe8c2, LSL #0
    MOVK  X10, #0xc4cb, LSL #48
    MOVK  X10, #0x7a36, LSL #32
    MOVK  X10, #0x4168, LSL #16
    MOVK  X10, #0x6402, LSL #0
    MOVK  X11, #0x88cb, LSL #48
    MOVK  X11, #0x1c24, LSL #32
    MOVK  X11, #0x9270, LSL #16
    MOVK  X11, #0x8031, LSL #0
    MOVK  X12, #0x511e, LSL #48
    MOVK  X12, #0x67a2, LSL #32
    MOVK  X12, #0x6e49, LSL #16
    MOVK  X12, #0xdb5c, LSL #0
    MOVK  X13, #0x4c0a, LSL #48
    MOVK  X13, #0x6568, LSL #32
    MOVK  X13, #0x9e23, LSL #16
    MOVK  X13, #0x2082, LSL #0
    MOVK  X14, #0xa9d5, LSL #48
    MOVK  X14, #0xd0fb, LSL #32
    MOVK  X14, #0x2e79, LSL #16
    MOVK  X14, #0xbacd, LSL #0
    MOVK  X15, #0xb344, LSL #48
    MOVK  X15, #0x4dab, LSL #32
    MOVK  X15, #0x90e7, LSL #16
    MOVK  X15, #0xc639, LSL #0
    MOVK  X16, #0xf346, LSL #48
    MOVK  X16, #0x89cd, LSL #32
    MOVK  X16, #0x7685, LSL #16
    MOVK  X16, #0x4e41, LSL #0
    MOVK  X17, #0xb0ac, LSL #48
    MOVK  X17, #0x1f89, LSL #32
    MOVK  X17, #0xf2ab, LSL #16
    MOVK  X17, #0xf17b, LSL #0
    MOVK  X18, #0xd904, LSL #48
    MOVK  X18, #0x8a2b, LSL #32
    MOVK  X18, #0x1730, LSL #16
    MOVK  X18, #0x6e0c, LSL #0
    MOVK  X19, #0x968e, LSL #48
    MOVK  X19, #0x700e, LSL #32
    MOVK  X19, #0xb1a0, LSL #16
    MOVK  X19, #0x14e7, LSL #0
    MOVK  X20, #0x889a, LSL #48
    MOVK  X20, #0xfc45, LSL #32
    MOVK  X20, #0x32de, LSL #16
    MOVK  X20, #0x2148, LSL #0
    MOVK  X21, #0xae3e, LSL #48
    MOVK  X21, #0xa8e9, LSL #32
    MOVK  X21, #0x90ae, LSL #16
    MOVK  X21, #0xd3d1, LSL #0
    MOVK  X22, #0x27c1, LSL #48
    MOVK  X22, #0x1513, LSL #32
    MOVK  X22, #0x6abc, LSL #16
    MOVK  X22, #0xb36a, LSL #0
    MOVK  X23, #0xc236, LSL #48
    MOVK  X23, #0x28ed, LSL #32
    MOVK  X23, #0xae0e, LSL #16
    MOVK  X23, #0x3f02, LSL #0
    MOVK  X24, #0x4c56, LSL #48
    MOVK  X24, #0x5ad3, LSL #32
    MOVK  X24, #0xf180, LSL #16
    MOVK  X24, #0x2bb6, LSL #0
    MOVK  X25, #0xbcc7, LSL #48
    MOVK  X25, #0xe245, LSL #32
    MOVK  X25, #0x832d, LSL #16
    MOVK  X25, #0xc862, LSL #0
    MOVK  X26, #0x4417, LSL #48
    MOVK  X26, #0xb351, LSL #32
    MOVK  X26, #0xcdde, LSL #16
    MOVK  X26, #0xf158, LSL #0
    MOVK  X27, #0x6e0d, LSL #48
    MOVK  X27, #0xe76e, LSL #32
    MOVK  X27, #0x5d6e, LSL #16
    MOVK  X27, #0x19f4, LSL #0
    MOVK  X28, #0xe3c6, LSL #48
    MOVK  X28, #0xdbb9, LSL #32
    MOVK  X28, #0x1c2, LSL #16
    MOVK  X28, #0x187a, LSL #0
    MOVK  X29, #0xf704, LSL #48
    MOVK  X29, #0xd66a, LSL #32
    MOVK  X29, #0x541b, LSL #16
    MOVK  X29, #0x235f, LSL #0
    SUBS  X8, X22, #0x6d1
    MOVZ  X2, #0x1bbe, LSL #0
    MOVK  X2, #0x5853, LSL #16
    MOVK  X2, #0x78f7, LSL #32
    MOVK  X2, #0x33f7, LSL #48
    MOVZ  X4, #0xd4f4, LSL #0
    MOVK  X4, #0x9405, LSL #16
    MOVK  X4, #0xef01, LSL #32
    MOVK  X4, #0x7a3c, LSL #48
    MOVZ  X5, #0xc25d, LSL #0
    MOVK  X5, #0xa850, LSL #16
    MOVK  X5, #0x2b7f, LSL #32
    MOVK  X5, #0x1ba0, LSL #48
    MOVZ  X6, #0x2f6a, LSL #0
    MOVK  X6, #0x549, LSL #16
    MOVK  X6, #0x44f3, LSL #32
    MOVK  X6, #0x22f, LSL #48
    MOVZ  X7, #0x9494, LSL #0
    MOVK  X7, #0xb9ae, LSL #16
    MOVK  X7, #0xeed1, LSL #32
    MOVK  X7, #0x9c88, LSL #48
    MOVZ  X8, #0xa2f2, LSL #0
    MOVK  X8, #0xdd1, LSL #16
    MOVK  X8, #0x62de, LSL #32
    MOVK  X8, #0xfbc1, LSL #48
    MOVZ  X9, #0xca28, LSL #0
    MOVK  X9, #0xeb5b, LSL #16
    MOVK  X9, #0xd21c, LSL #32
    MOVK  X9, #0x8d0a, LSL #48
    MOVZ  X10, #0x373a, LSL #0
    MOVK  X10, #0xd77a, LSL #16
    MOVK  X10, #0xa096, LSL #32
    MOVK  X10, #0xec35, LSL #48
    MOVZ  X11, #0x5fd8, LSL #0
    MOVK  X11, #0x59ec, LSL #16
    MOVK  X11, #0x923d, LSL #32
    MOVK  X11, #0x442c, LSL #48
    MOVZ  X12, #0x4e9a, LSL #0
    MOVK  X12, #0xaa87, LSL #16
    MOVK  X12, #0xc086, LSL #32
    MOVK  X12, #0x901a, LSL #48
    MOVZ  X13, #0xf11e, LSL #0
    MOVK  X13, #0xf6ed, LSL #16
    MOVK  X13, #0x48d4, LSL #32
    MOVK  X13, #0x69df, LSL #48
    MOVZ  X14, #0x7cdb, LSL #0
    MOVK  X14, #0x215b, LSL #16
    MOVK  X14, #0xb56, LSL #32
    MOVK  X14, #0x681c, LSL #48
    MOVZ  X15, #0x58da, LSL #0
    MOVK  X15, #0x8ac3, LSL #16
    MOVK  X15, #0x7dd, LSL #32
    MOVK  X15, #0xa0b9, LSL #48
    MOVZ  X16, #0xc2a2, LSL #0
    MOVK  X16, #0x9c5c, LSL #16
    MOVK  X16, #0xc4fe, LSL #32
    MOVK  X16, #0x5245, LSL #48
    MOVZ  X17, #0xbcf2, LSL #0
    MOVK  X17, #0x3ac0, LSL #16
    MOVK  X17, #0x3d48, LSL #32
    MOVK  X17, #0x163a, LSL #48
    MOVZ  X18, #0x1c8, LSL #0
    MOVK  X18, #0x2b32, LSL #16
    MOVK  X18, #0xe956, LSL #32
    MOVK  X18, #0xb2b1, LSL #48
    MOVZ  X19, #0xfaa1, LSL #0
    MOVK  X19, #0x5076, LSL #16
    MOVK  X19, #0xb39d, LSL #32
    MOVK  X19, #0xe152, LSL #48
    MOVZ  X20, #0x493d, LSL #0
    MOVK  X20, #0x7b3e, LSL #16
    MOVK  X20, #0x6a49, LSL #32
    MOVK  X20, #0xe87a, LSL #48
    MOVZ  X21, #0x9053, LSL #0
    MOVK  X21, #0x3edd, LSL #16
    MOVK  X21, #0x666b, LSL #32
    MOVK  X21, #0xe244, LSL #48
    MOVZ  X22, #0x9824, LSL #0
    MOVK  X22, #0x474, LSL #16
    MOVK  X22, #0x9725, LSL #32
    MOVK  X22, #0xb688, LSL #48
    MOVZ  X23, #0xb6d0, LSL #0
    MOVK  X23, #0xe487, LSL #16
    MOVK  X23, #0x8ccf, LSL #32
    MOVK  X23, #0x3d2c, LSL #48
    MOVZ  X24, #0xde1f, LSL #0
    MOVK  X24, #0x6352, LSL #16
    MOVK  X24, #0xea49, LSL #32
    MOVK  X24, #0xe3df, LSL #48
    MOVZ  X25, #0x7626, LSL #0
    MOVK  X25, #0x1aa5, LSL #16
    MOVK  X25, #0x23f2, LSL #32
    MOVK  X25, #0x322b, LSL #48
    MOVZ  X26, #0x8817, LSL #0
    MOVK  X26, #0x56c1, LSL #16
    MOVK  X26, #0xb3ba, LSL #32
    MOVK  X26, #0x4377, LSL #48
    MOVZ  X27, #0xbe2, LSL #0
    MOVK  X27, #0x35af, LSL #16
    MOVK  X27, #0x5208, LSL #32
    MOVK  X27, #0xcf60, LSL #48
    MOVZ  X28, #0xc24f, LSL #0
    MOVK  X28, #0xd41a, LSL #16
    MOVK  X28, #0x567, LSL #32
    MOVK  X28, #0x3388, LSL #48
    MOVZ  X29, #0x1242, LSL #0
    MOVK  X29, #0x3b44, LSL #16
    MOVK  X29, #0xa54, LSL #32
    MOVK  X29, #0xd947, LSL #48
    MOVZ  X18, #0x14, LSL #0
TaishanIntCcP01_label_0:
    ADDS  X9, X6, W26, SXTW #2
    ADDS  X19, X10, X9, LSL #17
    FCMP  S30, S0
    ANDS  X6, X4, X19, LSR #14
    SUBS  W26, W5, W5, LSR #10
    SUBS  W26, W25, W16, ASR #14
    ANDS  W20, W26, #0xfffe003f
    ANDS  W22, W20, W20, LSL #10
    SUBS  X7, X2, #0xcd5
    SUBS  X7, X26, X10, LSR #2
    ADDS  X21, X14, X24, ASR #6
    ANDS  W28, W25, W2, ASR #25
    ADDS  X20, X7, X23, SXTX #1
    ANDS  X12, X23, X8, ASR #41
    ADDS  X21, X26, X17, LSL #62
    ANDS  W28, W4, W5, ROR #22
    ANDS  X20, X17, X22, LSR #1
    ADDS  W4, W6, #0x950
    ANDS  W17, W7, W5, ASR #25
    SUBS  X24, X9, X15, LSL #1
    ANDS  X16, X19, #0xfffff80000007fff
    ADDS  X21, X18, W12, UXTB #2
    ADDS  X23, X9, X17, LSR #38
    SUBS  X28, X9, W20, UXTH #2
    SUBS  W21, W28, W25, LSL #25
    ANDS  W23, W11, W8, ASR #6
    SUBS  W2, W22, W23, LSL #14
    ANDS  X16, X26, X28, ASR #30
    ADDS  W5, W10, #0x3d1, LSL #12
    ANDS  X17, X5, X11, LSL #38
    SUBS  X19, X28, W14, UXTW #1
    SUBS  X17, X11, #0xde0
    ANDS  W7, W18, #0xfe3ffe3f
    ANDS  X4, X7, X21, LSL #7
    SUBS  W16, W10, W20, UXTW #1
    ADDS  W9, W13, W9, ASR #15
    FCMP  S23, S10
    ADDS  X10, X24, #0x3c2, LSL #12
    ADDS  W15, W9, #0x869
    ANDS  X29, X11, #0x3f8000003f800000
    ADDS  W27, W25, #0xe35
    ANDS  X9, X24, X16, ASR #18
    ADDS  W2, W19, W8, SXTX #3
    ADDS  X23, X9, W18, SXTW #1
    ANDS  W20, W22, #0xfc00007f
    ADDS  W10, W27, W20, SXTB #2
    ADDS  X15, X16, X11, SXTX #0
    ADDS  X23, X27, #0xb42
    SUBS  W10, W18, W16, LSL #9
    ADDS  X15, X5, W16, SXTW #1
    ANDS  W26, W10, #0xeeeeeeee
    ANDS  W8, W17, W2, ROR #7
    SUBS  W6, W25, W23, SXTH #3
    FCMPE  S3, #0.0
    SUBS  X12, X19, W29, SXTB #4
    SUBS  X29, X2, W10, UXTH #4
    ADDS  W22, W12, W11, UXTH #3
    SUBS  W27, W19, W27, ASR #4
    ANDS  W26, W18, #0xefefefef
    ADDS  W6, W13, #0xb00
    ANDS  W16, W9, W12, LSL #20
    FCMP  S2, #0.0
    SUBS  W22, W5, W8, SXTX #4
    SUBS  W6, W15, #0x480
    ADDS  W29, W24, W28, LSL #7
    ADDS  X4, X23, X16, SXTX #0
    ANDS  X8, X28, X18, LSR #21
    ANDS  W29, W22, #0x7f80000
    SUBS  W19, W11, W19, ASR #21
    ADDS  W8, W6, W7, UXTW #3
    ANDS  X15, X12, #0xfffffe00000
    ADDS  X17, X8, #0x73f, LSL #12
    SUBS  X17, X9, X10, SXTX #2
    ADDS  X2, X25, #0xc9c
    ANDS  W4, W29, #0x20202020
    SUBS  X4, X19, X19, LSR #15
    ADDS  X2, X19, X25, SXTX #1
    ADDS  X9, X26, W29, UXTB #2
    SUBS  X9, X27, #0xc65, LSL #12
    ADDS  W19, W16, W28, UXTW #0
    ADDS  W22, W4, W24, SXTH #1
    ADDS  X8, X6, X5, UXTX #2
    ADDS  W2, W16, #0x32d
    ADDS  X5, X10, X27, LSL #7
    ADDS  W25, W22, #0xf84
    ANDS  W15, W26, W2, LSR #4
    SUBS  W8, W7, W15, SXTX #3
    ADDS  W4, W15, #0x98e, LSL #12
    ADDS  X7, X25, W29, UXTH #2
    SUBS  W11, W22, W5, LSR #23
    FCMPE  S14, #0.0
    SUBS  W19, W13, W2, LSR #5
    ADDS  W12, W9, W24, SXTW #1
    SUBS  W24, W21, W11, ASR #7
    ADDS  W8, W10, W18, SXTW #3
    ADDS  W22, W18, #0xd00
    SUBS  W4, W27, W17, SXTB #0
    ANDS  W24, W15, #0x3fe03fe0
    ANDS  X29, X11, #0xfff800000000003f
    ADDS  X26, X15, W25, SXTH #0
    ADDS  X27, X24, X12, SXTX #3
    SUBS  X21, X16, W11, UXTH #4
    ANDS  X8, X21, #0xbfffbfffbfffbfff
    SUBS  X29, X15, #0x7f9, LSL #12
    ANDS  X13, X19, X8, LSR #15
    ADDS  X24, X11, X12, ASR #24
    ANDS  W20, W8, W4, ROR #21
    FCMP  S8, #0.0
    FCMP  S0, #0.0
    ADDS  W24, W22, W15, LSR #19
    ADDS  W11, W13, W14, ASR #24
    ADDS  X6, X15, #0x8cb
    ADDS  X15, X2, X8, UXTX #1
    ADDS  W26, W14, W2, UXTW #3
    ADDS  X26, X4, #0x850
    ADDS  W21, W11, W2, SXTW #0
    ADDS  X19, X5, X26, LSL #34
    SUBS  X22, X11, #0x899
    SUBS  X16, X11, #0xb44, LSL #12
    FCMP  D13, D5
    FCMPE  D2, #0.0
    ADDS  W11, W12, W18, UXTH #3
    ANDS  W7, W2, #0xfffffc1f
    SUBS  X25, X16, X10, LSR #58
    ANDS  X29, X15, X6, LSL #4
    ADDS  W15, W16, #0xcc4, LSL #12
    ADDS  X4, X25, X4, LSL #52
    SUBS  X19, X7, #0xf0e
    ADDS  W7, W28, W25, UXTB #2
    SUBS  X17, X11, X22, LSL #8
    ANDS  X23, X5, X29, LSR #32
    ANDS  X24, X21, #0x60000000600
    SUBS  W9, W8, W20, LSR #21
    ADDS  W22, W9, #0x217, LSL #12
    ADDS  W28, W29, #0x65d
    ADDS  X15, X29, X16, LSR #61
    SUBS  W8, W4, #0x3ff, LSL #12
    ADDS  W25, W28, W16, LSL #4
    ADDS  W8, W22, #0x143, LSL #12
    SUBS  X10, X23, X12, LSR #28
    ADDS  W15, W18, W21, UXTH #0
    ANDS  X25, X23, #0xfff0000007ffffff
    ANDS  W7, W6, W2, LSL #29
    SUBS  X24, X7, X5, LSL #18
    ADDS  X2, X19, #0x1c5, LSL #12
    SUBS  X8, X15, X8, UXTX #2
    SUBS  W15, W13, W22, UXTW #4
    ANDS  X19, X18, X26, ROR #3
    FCMP  S30, #0.0
    SUBS  X22, X27, W2, SXTH #2
    ANDS  W6, W18, #0xfdfdfdfd
    ADDS  X21, X8, X16, LSR #24
    ADDS  X12, X26, #0x3f0
    SUBS  X28, X12, W17, SXTH #1
    SUBS  W12, W26, W10, UXTH #2
    ADDS  X8, X9, W18, SXTH #3
    ADDS  W16, W24, #0x114, LSL #12
    ADDS  X24, X7, #0x7c, LSL #12
    ANDS  W23, W9, #0x3fffff
    ADDS  X23, X25, W10, SXTB #4
    ANDS  W5, W4, W17, LSR #22
    SUBS  W16, W17, W25, LSL #1
    ANDS  X22, X28, X17, ROR #41
    ANDS  W26, W2, W29, ROR #24
    ADDS  X27, X14, #0xa26, LSL #12
    ADDS  W29, W10, W23, LSL #30
    SUBS  W23, W16, #0x400
    ANDS  W27, W8, #0xfffff803
    ADDS  W14, W6, W25, LSL #22
    ANDS  W28, W19, W18, ROR #31
    ANDS  X13, X11, X17, ROR #24
    SUBS  X16, X19, #0x91c
    ANDS  W17, W4, W7, LSR #20
    FCMPE  D10, #0.0
    SUBS  X24, X13, X29, ASR #47
    SUBS  X6, X9, X19, SXTX #0
    SUBS  X5, X10, X25, LSR #57
    ADDS  X2, X29, X10, UXTX #0
    SUBS  X9, X8, X5, LSL #14
    ADDS  W17, W18, #0xbb5
    ANDS  X17, X13, #0x1111111111111111
    SUBS  W12, W4, W22, UXTB #1
    ADDS  X14, X11, #0x81a, LSL #12
    SUBS  W9, W11, W4, UXTB #3
    ADDS  X10, X11, #0xe59, LSL #12
    ADDS  X15, X4, #0xb64
    SUBS  W11, W25, W18, LSR #1
    SUBS  W12, W9, W24, UXTW #2
    FCMPE  S30, S17
    ADDS  W2, W21, #0x840
    ANDS  W8, W27, W26, ROR #1
    ADDS  W15, W23, W8, SXTW #4
    ANDS  X11, X11, #0xff8fff8fff8fff8f
    FCMPE  D25, #0.0
    ADDS  X25, X20, #0x846
    SUBS  W19, W15, #0x888
    ANDS  W28, W4, W23, ROR #6
    ADDS  W6, W29, W29, LSL #4
    SUBS  X27, X2, #0x70a
    FCMPE  D21, D26
    SUBS  X18, X18, #0x1
    B.NE  TaishanIntCcP01_label_0
    MOVZ  X12, #0xd365, LSL #0
    MOVK  X12, #0xff49, LSL #16
    SUB  X22, X12, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x4002, LSL #0
    MOVK  X17, #0x21a8, LSL #16
    MOVK  X17, #0x59d0, LSL #48
    SUB  X11, X17, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X21, #0xfffc, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X28, X21, X5
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X28, #0xffbc, LSL #0
    MOVK  X28, #0xffff, LSL #16
    SUB  X19, X28, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X4, #0x3e45, LSL #0
    MOVK  X4, #0x4993, LSL #16
    SUB  X23, X4, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X12, #0xce55, LSL #0
    MOVK  X12, #0x4a78, LSL #16
    SUB  X6, X12, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X15, #0x1c45, LSL #0
    MOVK  X15, #0x4993, LSL #16
    SUB  X5, X15, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntCcP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X25, #0x1c45, LSL #0
    MOVK  X25, #0x4993, LSL #16
    SUB  X27, X25, X15
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntCcP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X20
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X20, #0xfffc, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X19, X20, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X22
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x1c45, LSL #0
    MOVK  X8, #0x4993, LSL #16
    SUB  X19, X8, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X26
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
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
    MOVZ  X18, #0x14, LSL #0
TaishanIntCcP01_label_28:
    SUBS  X26, X6, #0xd4d, LSL #12
    ADDS  W21, W14, W15, SXTX #3
    ADDS  X20, X12, W27, SXTW #3
    ANDS  W27, W23, W29, LSL #30
    SUBS  W5, W29, #0xcf, LSL #12
    ANDS  X23, X4, X29, ASR #40
    ANDS  X11, X23, #0x800001ff800001ff
    FCMPE  S24, #0.0
    ANDS  W29, W15, #0x3ffffc0
    ADDS  X23, X4, W2, UXTW #0
    SUBS  X16, X28, W23, SXTH #1
    SUBS  W11, W14, W9, SXTW #4
    FCMPE  S7, S27
    ADDS  W6, W2, W21, LSR #26
    ANDS  X16, X15, #0xffff800000000001
    SUBS  W26, W21, W6, SXTX #3
    ADDS  X21, X15, #0xdd0
    SUBS  X22, X28, X20, UXTX #3
    ANDS  W17, W14, W13, ASR #24
    SUBS  X21, X22, #0xf21, LSL #12
    ANDS  X12, X19, X5, LSR #17
    ADDS  X11, X7, X12, ASR #42
    FCMPE  S17, #0.0
    SUBS  W8, W28, W18, SXTX #4
    ADDS  X24, X25, #0xe5e, LSL #12
    ADDS  W6, W5, W26, LSL #20
    SUBS  W24, W11, W21, ASR #8
    ANDS  W6, W19, #0x7ffff80
    ADDS  X29, X9, #0xf6
    ADDS  X6, X8, #0xd2f, LSL #12
    ANDS  X22, X28, X18, LSL #59
    ADDS  W19, W22, W27, ASR #28
    SUBS  W7, W29, W2, UXTX #3
    SUBS  X24, X15, #0x29d
    ANDS  W22, W15, W13, LSL #7
    SUBS  X23, X8, W7, SXTH #2
    ADDS  W12, W13, #0xdd0
    SUBS  X26, X25, W6, UXTH #2
    ADDS  X19, X6, #0xf50
    SUBS  W26, W22, W13, SXTB #3
    SUBS  W25, W13, W28, UXTX #0
    SUBS  X20, X8, X5, LSL #10
    ADDS  W22, W26, #0x89a
    SUBS  X16, X21, W11, SXTW #4
    SUBS  X8, X23, #0x4e0
    ADDS  X20, X14, X8, LSL #48
    ADDS  X5, X25, X12, ASR #41
    SUBS  W19, W14, W2, UXTX #3
    ADDS  W28, W11, #0x8cb, LSL #12
    ADDS  X9, X7, #0xa30
    ANDS  W6, W21, W28, ROR #5
    ADDS  W15, W17, W19, ASR #18
    SUBS  W20, W4, #0xadd, LSL #12
    SUBS  X16, X11, W9, SXTH #0
    ADDS  X24, X6, #0xe50
    ADDS  X13, X26, X24, SXTX #1
    SUBS  W17, W6, W22, LSR #24
    SUBS  W19, W15, #0xb10
    ANDS  W19, W28, W24, ASR #7
    ANDS  X7, X20, #0x7ffffff8
    ADDS  W28, W7, W25, LSR #20
    ADDS  X19, X23, X23, LSL #34
    SUBS  W21, W28, W12, ASR #13
    ANDS  W8, W10, #0x1ffff0
    ANDS  W2, W20, #0x83838383
    ANDS  W14, W18, #0xc003c003
    SUBS  X11, X10, #0x15c, LSL #12
    SUBS  X7, X12, #0x638, LSL #12
    ADDS  X29, X4, W12, SXTB #4
    FCMP  D8, #0.0
    SUBS  X10, X25, W17, UXTH #0
    ADDS  X7, X25, X5, LSL #30
    ADDS  X27, X23, X28, LSL #22
    SUBS  X4, X26, X13, LSR #19
    ADDS  X9, X21, W19, SXTB #4
    ANDS  W23, W15, #0xc0ffc0ff
    SUBS  X8, X5, #0x4f4, LSL #12
    ADDS  W24, W14, W9, SXTX #2
    SUBS  X27, X6, #0x20
    ADDS  X17, X16, X13, LSR #52
    ADDS  W9, W24, #0x7d0
    ANDS  X6, X11, #0xf3f3f3f3f3f3f3f3
    ADDS  X22, X2, X29, ASR #55
    SUBS  W26, W22, W2, SXTH #1
    ANDS  W4, W12, #0x700000
    ADDS  W7, W18, W9, LSR #1
    ADDS  W15, W22, W7, UXTW #3
    ANDS  X25, X24, #0x2222222222222222
    FCMPE  D19, #0.0
    ANDS  W13, W10, #0x83838383
    SUBS  W27, W5, W12, LSR #15
    ANDS  X17, X25, #0x1f0000001f0000
    ADDS  X13, X29, W19, UXTH #1
    ADDS  W4, W28, #0x3d5
    ADDS  W5, W10, W8, UXTW #3
    SUBS  X10, X14, X5, LSL #6
    ADDS  W21, W12, W16, UXTX #2
    ADDS  W2, W29, W22, SXTH #1
    ANDS  X19, X12, X12, LSR #0
    SUBS  X4, X13, W8, SXTH #0
    ADDS  W26, W6, W10, UXTB #1
    ANDS  W12, W25, #0x7ffe00
    FCMP  D8, D21
    SUBS  W25, W11, #0x7f2
    ADDS  W13, W7, #0xbfd
    SUBS  W13, W5, W14, LSR #11
    ANDS  W16, W8, #0x7e7e7e7e
    SUBS  W25, W15, W12, ASR #11
    ANDS  W19, W10, W12, ASR #13
    FCMPE  D15, D6
    FCMP  D27, #0.0
    SUBS  X24, X17, W26, SXTW #0
    ANDS  W16, W27, #0xf3f3f3f3
    ADDS  W6, W2, #0x844, LSL #12
    FCMP  D31, #0.0
    ADDS  W7, W27, W19, SXTB #4
    ANDS  W16, W23, #0x1e001e00
    ADDS  X29, X4, #0xd60
    SUBS  W24, W22, W19, LSR #26
    ANDS  W5, W27, #0x7fff8000
    SUBS  W23, W2, #0x6b
    ANDS  X7, X21, #0xff80000fff80000f
    SUBS  X15, X24, #0x260
    ADDS  W11, W21, #0x204, LSL #12
    SUBS  W12, W17, W19, ASR #22
    SUBS  X13, X9, #0xb62
    SUBS  W2, W23, W5, UXTH #4
    SUBS  X19, X19, W2, SXTW #0
    ADDS  W19, W4, W27, LSR #14
    ADDS  W25, W13, W25, SXTW #4
    SUBS  X27, X12, X4, LSL #33
    ANDS  X29, X11, #0x7fffffffffc0000
    ADDS  X19, X8, X5, LSL #1
    SUBS  W25, W2, #0x36, LSL #12
    SUBS  W15, W29, W19, LSR #5
    SUBS  W22, W17, #0xc4
    ADDS  X9, X23, X27, UXTX #2
    ADDS  W13, W11, W12, UXTW #0
    ADDS  W9, W17, #0x45d
    ANDS  W4, W7, #0x38383838
    ANDS  W26, W25, #0x7ffffc
    ADDS  W23, W22, W21, SXTX #3
    FCMPE  D27, #0.0
    SUBS  X19, X26, X16, LSL #63
    ANDS  X19, X19, #0x1fc000001fc000
    ANDS  X14, X22, #0x7fe07fe07fe07fe0
    ADDS  W24, W19, W17, SXTH #3
    SUBS  W11, W9, W24, SXTW #4
    SUBS  W6, W8, #0x874, LSL #12
    ADDS  W6, W22, W10, LSR #22
    ANDS  W5, W17, #0xbbbbbbbb
    SUBS  X25, X4, W5, UXTB #1
    ANDS  X15, X8, X19, ROR #21
    ADDS  X14, X8, X17, LSR #23
    ADDS  X29, X16, #0xb27, LSL #12
    ADDS  W17, W21, W12, SXTX #4
    SUBS  W7, W2, #0x210
    ADDS  X6, X14, X4, LSL #28
    ANDS  X28, X11, #0x1f8000001f8000
    ANDS  W2, W26, #0x3ffe00
    SUBS  W25, W28, W19, LSR #21
    ANDS  W14, W26, #0xfffc03ff
    FCMP  S21, #0.0
    ADDS  W28, W11, W4, ASR #15
    SUBS  X13, X12, #0xf8f
    SUBS  W8, W21, #0xc1
    FCMP  S8, #0.0
    SUBS  X19, X9, W21, SXTH #0
    ADDS  W23, W6, #0xaa4, LSL #12
    SUBS  W16, W13, W27, ASR #1
    SUBS  X26, X28, X19, LSL #34
    ADDS  X28, X10, X12, ASR #28
    ADDS  X14, X7, #0x1a0
    SUBS  W9, W4, #0x920
    FCMP  D11, D0
    FCMP  D8, #0.0
    ADDS  X25, X11, X4, ASR #10
    SUBS  X27, X8, X2, LSR #21
    SUBS  W16, W14, #0x190
    SUBS  W19, W13, #0x9e1
    ADDS  X6, X13, #0x4f3
    ANDS  W21, W7, W14, LSL #30
    ANDS  W26, W18, #0x3fe03fe
    SUBS  X12, X26, X20, ASR #39
    FCMPE  D9, #0.0
    SUBS  W12, W29, W28, LSL #16
    SUBS  W27, W19, #0x5f5
    ADDS  W16, W29, W29, LSL #19
    ANDS  X5, X17, #0xffffffffffffe3ff
    ADDS  W2, W10, W2, LSL #2
    ADDS  X4, X10, #0x5c2
    ADDS  W21, W13, W25, ASR #27
    ADDS  W9, W26, W24, UXTB #2
    ADDS  X20, X26, #0xe10
    ADDS  X10, X8, W20, SXTB #4
    ADDS  W22, W10, #0xea0
    ADDS  X14, X18, X6, LSR #29
    ADDS  X8, X11, #0x244
    SUBS  W26, W8, W15, LSL #11
    SUBS  W2, W12, #0x330, LSL #12
    SUBS  X18, X18, #0x1
    B.NE  TaishanIntCcP01_label_28
    MOVZ  X22, #0x7000, LSL #0
    MOVK  X22, #0xba3e, LSL #16
    SUB  X16, X22, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X16, #0x4c03, LSL #0
    MOVK  X16, #0x9c03, LSL #16
    MOVK  X16, #0xffef, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X2, X16, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X9, #0x4209, LSL #0
    MOVK  X9, #0x953d, LSL #16
    SUB  X13, X9, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntCcP01_TestFail
    MOVZ  X7, #0xf564, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X20, X7, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X4, #0xf564, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X17, X4, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X20, #0x6a1, LSL #0
    MOVK  X20, #0xfee4, LSL #16
    SUB  X4, X20, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntCcP01_TestFail
    MOVZ  X9, #0x4209, LSL #0
    MOVK  X9, #0x953d, LSL #16
    SUB  X13, X9, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntCcP01_TestFail
    MOVZ  X7, #0x5248, LSL #0
    MOVK  X7, #0x953d, LSL #16
    SUB  X26, X7, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X14, #0x45d, LSL #0
    MOVK  X14, #0xfee4, LSL #16
    SUB  X8, X14, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x7000, LSL #0
    MOVK  X23, #0xba71, LSL #16
    SUB  X26, X23, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X22, #0x45d, LSL #0
    MOVK  X22, #0xfee4, LSL #16
    SUB  X6, X22, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X5, #0x4c03, LSL #0
    MOVK  X5, #0x9c03, LSL #16
    MOVK  X5, #0xffef, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X13, X5, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntCcP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X26, X9, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X2, #0xe690, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X13, X2, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntCcP01_TestFail
    MOVZ  X21, #0x6a1, LSL #0
    MOVK  X21, #0xfee4, LSL #16
    SUB  X20, X21, X20
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X19, #0x6a1, LSL #0
    MOVK  X19, #0xfee4, LSL #16
    SUB  X10, X19, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X12, #0x7000, LSL #0
    MOVK  X12, #0xba71, LSL #16
    SUB  X11, X12, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X27, #0xc000, LSL #0
    MOVK  X27, #0x11, LSL #16
    SUB  X14, X27, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X15, #0x45d, LSL #0
    MOVK  X15, #0xfee8, LSL #16
    SUB  X28, X15, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X26
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X20, X17, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x7000, LSL #0
    MOVK  X2, #0xb2, LSL #16
    SUB  X24, X2, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x0, LSL #0
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
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X20, #0x14, LSL #0
TaishanIntCcP01_label_56:
    SUBS  W2, W24, #0x278, LSL #12
    ADDS  W16, W11, W26, UXTW #1
    ADDS  W25, W16, #0xce0
    ADDS  W10, W9, W22, SXTX #0
    SUBS  W7, W27, W25, LSR #0
    SUBS  W18, W8, W8, SXTB #4
    ANDS  X13, X17, #0x3ffff00000000000
    SUBS  X22, X7, X8, LSR #3
    SUBS  W21, W6, W21, SXTB #4
    SUBS  W18, W10, #0xe02, LSL #12
    ANDS  X7, X15, #0x180018001800180
    ANDS  X19, X22, X4, ASR #45
    SUBS  W4, W29, #0x21
    ADDS  X6, X10, W21, UXTH #2
    FCMPE  S16, #0.0
    ANDS  W16, W14, W17, ROR #1
    SUBS  W18, W27, W6, LSL #24
    SUBS  X2, X15, X13, ASR #32
    FCMPE  D1, D18
    SUBS  W2, W28, W2, UXTX #3
    SUBS  W25, W25, #0x8fe, LSL #12
    ADDS  W10, W28, W6, SXTH #0
    SUBS  W25, W16, #0xf5e
    ANDS  W18, W21, #0xc007c007
    SUBS  X27, X17, #0x44d
    SUBS  X15, X26, X8, LSR #3
    ANDS  W28, W21, W26, LSR #21
    ADDS  W5, W6, W6, SXTB #3
    SUBS  W26, W5, W29, UXTB #1
    ADDS  X8, X16, X16, ASR #30
    ADDS  X14, X9, X26, LSR #36
    SUBS  X4, X5, X27, LSL #8
    ADDS  X23, X26, W14, UXTW #4
    ADDS  W25, W23, W12, UXTB #1
    SUBS  W6, W24, W8, SXTB #1
    SUBS  X17, X6, X23, SXTX #2
    ADDS  W6, W16, W2, UXTW #1
    SUBS  W17, W10, W29, LSL #7
    ADDS  X11, X2, X12, LSR #33
    ANDS  W12, W2, #0x3ffffc0
    ADDS  X17, X13, X18, LSL #17
    ANDS  X14, X8, X19, LSR #29
    SUBS  W29, W26, W26, LSL #3
    ANDS  W29, W2, #0x30003000
    ADDS  X9, X17, #0x522
    SUBS  X17, X24, #0x1d
    ANDS  W9, W6, W25, LSR #17
    ANDS  X10, X9, #0xfffffc03fffffc03
    ADDS  X9, X5, W16, SXTB #1
    SUBS  X16, X22, X18, LSR #9
    ADDS  W11, W5, #0xf12, LSL #12
    ADDS  X2, X25, X21, ASR #32
    ADDS  W8, W25, #0x2ac, LSL #12
    SUBS  X8, X25, W22, SXTW #2
    ANDS  W8, W7, #0x3fff8
    ADDS  W27, W13, W9, ASR #1
    ADDS  X26, X26, #0xd30
    SUBS  X11, X14, W18, SXTH #0
    SUBS  X13, X16, X27, ASR #15
    SUBS  X19, X2, #0x0
    SUBS  W2, W13, W8, LSR #20
    SUBS  W23, W25, W10, UXTX #3
    ADDS  W9, W25, W13, ASR #22
    FCMP  D15, #0.0
    ANDS  X22, X26, X27, ASR #0
    ADDS  X5, X29, X23, UXTX #3
    ADDS  X4, X2, #0xc20
    ADDS  W22, W2, #0x210
    ANDS  X12, X19, #0x1fffff80000000
    FCMP  S16, #0.0
    ADDS  W4, W11, #0x827
    SUBS  W5, W20, W23, UXTW #1
    ADDS  X15, X5, X9, ASR #5
    ADDS  W9, W7, #0xe35, LSL #12
    ANDS  W19, W18, W2, LSL #9
    ADDS  X11, X21, X6, LSL #16
    FCMPE  S5, S28
    SUBS  X17, X21, #0x0
    ADDS  W7, W26, W6, SXTW #3
    SUBS  W16, W28, W22, SXTH #1
    SUBS  X4, X13, W25, SXTB #1
    SUBS  W17, W10, #0xc47
    ADDS  W28, W10, W20, SXTW #2
    ADDS  W17, W14, #0x65e, LSL #12
    SUBS  W18, W4, W18, SXTX #4
    SUBS  W4, W5, W18, UXTX #3
    ANDS  W10, W26, W21, ASR #20
    ADDS  X10, X11, #0xcf4, LSL #12
    ADDS  W2, W19, W22, UXTW #0
    SUBS  W23, W28, W22, LSL #14
    SUBS  X10, X21, X17, ASR #14
    SUBS  X25, X25, X17, LSR #54
    ANDS  W15, W2, #0x3e003e00
    SUBS  X14, X21, #0x680, LSL #12
    ANDS  X6, X13, X10, ASR #34
    ADDS  X27, X14, W28, SXTW #2
    ANDS  X21, X5, #0x3ffffff80
    SUBS  X12, X17, W12, SXTH #0
    ADDS  W19, W21, #0xb90
    SUBS  X23, X5, X5, LSL #27
    SUBS  W5, W5, W27, LSR #0
    SUBS  X9, X12, #0xc03, LSL #12
    ANDS  W16, W27, #0x99999999
    SUBS  X9, X12, #0xe6, LSL #12
    ADDS  X14, X18, X25, SXTX #4
    ANDS  X28, X27, X20, ASR #28
    SUBS  W17, W2, W21, ASR #10
    ADDS  X4, X15, X29, LSR #12
    SUBS  X7, X9, #0x221
    ANDS  W2, W15, #0xfc0001ff
    ANDS  W27, W13, W15, LSL #29
    ADDS  W21, W24, #0x65a, LSL #12
    ANDS  X21, X20, #0xffffffffc0000
    SUBS  X6, X16, #0x7a0
    FCMP  D27, D29
    ADDS  W22, W29, W25, LSR #6
    ADDS  X9, X26, #0x2e0
    SUBS  X25, X14, X4, LSL #50
    ANDS  X8, X13, X16, LSR #0
    SUBS  W2, W13, #0x26a
    ADDS  X29, X14, #0x6ba, LSL #12
    FCMP  D6, D11
    SUBS  W13, W8, #0xabe, LSL #12
    SUBS  X15, X29, X25, SXTX #0
    ADDS  X24, X7, W29, UXTH #0
    SUBS  W13, W4, W10, LSL #16
    SUBS  W9, W4, W7, UXTX #1
    ANDS  X12, X14, X29, LSR #33
    ADDS  W15, W22, W15, SXTX #2
    SUBS  X16, X10, #0x5bf, LSL #12
    ADDS  W2, W2, W26, SXTX #2
    ADDS  W21, W7, W20, UXTB #3
    FCMPE  D1, #0.0
    ADDS  W16, W8, #0xc7c, LSL #12
    ADDS  W10, W5, W5, LSL #19
    SUBS  W15, W14, W27, SXTB #1
    ANDS  X6, X23, X16, LSL #9
    SUBS  W24, W12, W2, ASR #8
    ANDS  X8, X4, #0xfff8000000003fff
    SUBS  W6, W13, W8, ASR #15
    ADDS  X9, X26, X29, LSR #45
    ADDS  W14, W6, W17, LSR #30
    ANDS  X17, X15, X6, LSL #47
    ANDS  W14, W8, W6, ROR #9
    SUBS  X17, X11, X14, ASR #12
    ADDS  X21, X10, X10, LSL #28
    ANDS  X9, X5, X8, LSR #15
    ANDS  W22, W21, W28, LSL #18
    ADDS  W24, W28, W14, LSL #1
    SUBS  X6, X8, #0xa23, LSL #12
    ADDS  X17, X13, #0x920
    ANDS  X9, X2, X4, ASR #61
    ADDS  W6, W20, #0x325, LSL #12
    SUBS  X13, X20, #0x10
    SUBS  W12, W8, W21, UXTW #0
    ANDS  W28, W22, #0x3030303
    ANDS  W5, W7, #0x8007ffff
    SUBS  W29, W26, W6, LSL #30
    SUBS  W14, W10, W11, LSL #16
    SUBS  X10, X15, X24, LSR #3
    ADDS  W11, W16, W6, UXTX #0
    ADDS  W24, W21, #0xc3a
    SUBS  X28, X21, #0xa71, LSL #12
    SUBS  X6, X15, #0x716
    ADDS  W14, W2, W20, ASR #11
    ANDS  X27, X7, #0x1fe000
    ANDS  X27, X27, X15, ASR #33
    ANDS  W18, W9, #0x7
    ANDS  W27, W21, #0x3ff
    ANDS  X9, X20, #0xfffdfffffffdffff
    SUBS  X26, X15, X22, LSR #8
    ADDS  X6, X10, X8, SXTX #1
    ADDS  X18, X21, X23, ASR #46
    SUBS  X16, X2, X13, LSR #59
    SUBS  X11, X20, #0xebc
    SUBS  X5, X8, #0xdd0
    SUBS  X8, X12, W2, UXTB #2
    ADDS  X2, X27, #0xb60
    SUBS  X29, X9, #0xcda, LSL #12
    ANDS  W26, W15, W15, LSR #9
    ANDS  X15, X4, X4, ROR #14
    ADDS  W23, W27, W22, ASR #9
    ADDS  W18, W20, #0x2f0
    ANDS  X26, X8, #0xfffc00000000001f
    SUBS  W27, W12, W9, UXTH #0
    SUBS  X9, X13, W23, UXTH #3
    ANDS  W6, W16, W9, LSL #29
    ADDS  X27, X13, #0x39a
    SUBS  W29, W22, W29, LSR #25
    ADDS  X22, X2, W20, UXTH #4
    ANDS  X29, X12, #0x7fffffc
    ANDS  W10, W6, #0xe0e0e0e
    ADDS  X19, X14, X21, LSL #55
    SUBS  X18, X27, #0x32a, LSL #12
    ADDS  X2, X28, #0xcba
    SUBS  W8, W19, #0xa7e, LSL #12
    SUBS  X14, X2, X10, LSL #57
    SUBS  X21, X7, #0xe41, LSL #12
    ADDS  W12, W13, W24, SXTW #2
    ANDS  X12, X21, #0xf80000000fffffff
    SUBS  X20, X20, #0x1
    B.NE  TaishanIntCcP01_label_56
    MOVZ  X20, #0x6c6f, LSL #0
    MOVK  X20, #0x8d6e, LSL #16
    MOVK  X20, #0x56fb, LSL #32
    MOVK  X20, #0x3e1, LSL #48
    SUB  X26, X20, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X21, #0x3001, LSL #0
    MOVK  X21, #0x2201, LSL #16
    SUB  X22, X21, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X19, #0x2231, LSL #0
    SUB  X26, X19, X5
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x2000, LSL #16
    SUB  X2, X23, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X27, #0x7ddf, LSL #0
    MOVK  X27, #0x57, LSL #16
    SUB  X17, X27, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X6, #0x26a9, LSL #0
    MOVK  X6, #0xe2da, LSL #16
    SUB  X29, X6, X8
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X6, #0xe249, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X25, X6, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X10
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntCcP01_TestFail
    MOVZ  X19, #0xf145, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X14, X19, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X11, #0x6ddf, LSL #0
    MOVK  X11, #0xf73, LSL #16
    MOVK  X11, #0xf800, LSL #48
    SUB  X28, X11, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X7, #0xfff1, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X9, X7, X13
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntCcP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntCcP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X15, #0x68a, LSL #0
    MOVK  X15, #0xe382, LSL #16
    SUB  X6, X15, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X29, X28, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x638b, LSL #0
    MOVK  X2, #0xffcd, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X25, X2, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X5, #0xf145, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X22, X5, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X10, #0x6c6f, LSL #0
    MOVK  X10, #0x8d6e, LSL #16
    MOVK  X10, #0x56fb, LSL #32
    MOVK  X10, #0x3e1, LSL #48
    SUB  X23, X10, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X20, #0x3001, LSL #0
    MOVK  X20, #0x2201, LSL #16
    SUB  X14, X20, X21
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X26, X16, X22
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X21, #0x7bef, LSL #0
    MOVK  X21, #0x8e15, LSL #16
    SUB  X15, X21, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntCcP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X29, X26, X26
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x7ddf, LSL #0
    MOVK  X17, #0x57, LSL #16
    SUB  X16, X17, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntCcP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X14, X12, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X2, #0xe689, LSL #0
    MOVK  X2, #0x3e78, LSL #16
    MOVK  X2, #0xdaea, LSL #32
    MOVK  X2, #0x1a0f, LSL #48
    MOVZ  X4, #0xf498, LSL #0
    MOVK  X4, #0xaf32, LSL #16
    MOVK  X4, #0x2c15, LSL #32
    MOVK  X4, #0xe0b8, LSL #48
    MOVZ  X5, #0xc6aa, LSL #0
    MOVK  X5, #0xd2a4, LSL #16
    MOVK  X5, #0x493, LSL #32
    MOVK  X5, #0xd944, LSL #48
    MOVZ  X6, #0xa1db, LSL #0
    MOVK  X6, #0x6ab7, LSL #16
    MOVK  X6, #0xfcb, LSL #32
    MOVK  X6, #0x24e4, LSL #48
    MOVZ  X7, #0x75b4, LSL #0
    MOVK  X7, #0x3438, LSL #16
    MOVK  X7, #0x4abd, LSL #32
    MOVK  X7, #0x17e1, LSL #48
    MOVZ  X8, #0x365a, LSL #0
    MOVK  X8, #0xd425, LSL #16
    MOVK  X8, #0xc559, LSL #32
    MOVK  X8, #0x5fc7, LSL #48
    MOVZ  X9, #0xf95d, LSL #0
    MOVK  X9, #0x71d5, LSL #16
    MOVK  X9, #0xee0d, LSL #32
    MOVK  X9, #0xaf64, LSL #48
    MOVZ  X10, #0xecae, LSL #0
    MOVK  X10, #0x27aa, LSL #16
    MOVK  X10, #0xacdd, LSL #32
    MOVK  X10, #0xae36, LSL #48
    MOVZ  X11, #0x5a8a, LSL #0
    MOVK  X11, #0x27e4, LSL #16
    MOVK  X11, #0x578b, LSL #32
    MOVK  X11, #0x727, LSL #48
    MOVZ  X12, #0x6d1, LSL #0
    MOVK  X12, #0x2d1c, LSL #16
    MOVK  X12, #0xe94e, LSL #32
    MOVK  X12, #0x4e9a, LSL #48
    MOVZ  X13, #0x171d, LSL #0
    MOVK  X13, #0x942c, LSL #16
    MOVK  X13, #0xdbe1, LSL #32
    MOVK  X13, #0xcc57, LSL #48
    MOVZ  X14, #0xc164, LSL #0
    MOVK  X14, #0xe071, LSL #16
    MOVK  X14, #0x7648, LSL #32
    MOVK  X14, #0xe71c, LSL #48
    MOVZ  X15, #0xfd0, LSL #0
    MOVK  X15, #0x8c88, LSL #16
    MOVK  X15, #0x3aa1, LSL #32
    MOVK  X15, #0xf63, LSL #48
    MOVZ  X16, #0x1218, LSL #0
    MOVK  X16, #0x6a3a, LSL #16
    MOVK  X16, #0x68a1, LSL #32
    MOVK  X16, #0x56e3, LSL #48
    MOVZ  X17, #0x8765, LSL #0
    MOVK  X17, #0x3819, LSL #16
    MOVK  X17, #0x1bc0, LSL #32
    MOVK  X17, #0x8a89, LSL #48
    MOVZ  X18, #0x1e5c, LSL #0
    MOVK  X18, #0xb269, LSL #16
    MOVK  X18, #0x64bd, LSL #32
    MOVK  X18, #0x94e4, LSL #48
    MOVZ  X19, #0xcc78, LSL #0
    MOVK  X19, #0xab47, LSL #16
    MOVK  X19, #0x1578, LSL #32
    MOVK  X19, #0x31, LSL #48
    MOVZ  X20, #0x82d4, LSL #0
    MOVK  X20, #0x68cc, LSL #16
    MOVK  X20, #0x1c2a, LSL #32
    MOVK  X20, #0x32cb, LSL #48
    MOVZ  X21, #0xab2f, LSL #0
    MOVK  X21, #0xb3a8, LSL #16
    MOVK  X21, #0x546c, LSL #32
    MOVK  X21, #0xad8, LSL #48
    MOVZ  X22, #0xd67b, LSL #0
    MOVK  X22, #0x5a03, LSL #16
    MOVK  X22, #0x55f8, LSL #32
    MOVK  X22, #0x377f, LSL #48
    MOVZ  X23, #0x5c2e, LSL #0
    MOVK  X23, #0x186e, LSL #16
    MOVK  X23, #0xc65f, LSL #32
    MOVK  X23, #0xbbbc, LSL #48
    MOVZ  X24, #0x7f59, LSL #0
    MOVK  X24, #0x4cc4, LSL #16
    MOVK  X24, #0xc210, LSL #32
    MOVK  X24, #0xb590, LSL #48
    MOVZ  X25, #0x1904, LSL #0
    MOVK  X25, #0x8304, LSL #16
    MOVK  X25, #0xfce0, LSL #32
    MOVK  X25, #0x6d3, LSL #48
    MOVZ  X26, #0x3284, LSL #0
    MOVK  X26, #0xde42, LSL #16
    MOVK  X26, #0xcee8, LSL #32
    MOVK  X26, #0x7956, LSL #48
    MOVZ  X27, #0x341c, LSL #0
    MOVK  X27, #0x78ab, LSL #16
    MOVK  X27, #0xd0e8, LSL #32
    MOVK  X27, #0x4735, LSL #48
    MOVZ  X28, #0x804b, LSL #0
    MOVK  X28, #0x9348, LSL #16
    MOVK  X28, #0x12e6, LSL #32
    MOVK  X28, #0x2d9, LSL #48
    MOVZ  X29, #0xa019, LSL #0
    MOVK  X29, #0x6c4f, LSL #16
    MOVK  X29, #0xbf7e, LSL #32
    MOVK  X29, #0x41e, LSL #48
    MOVZ  X13, #0x14, LSL #0
TaishanIntCcP01_label_84:
    SUBS  W22, W15, W27, LSR #3
    ANDS  X25, X29, X27, LSL #62
    SUBS  X6, X19, W13, SXTB #2
    ADDS  X17, X6, #0x8ba
    SUBS  W8, W29, W28, UXTB #4
    ADDS  X5, X5, X24, ASR #17
    SUBS  X5, X11, #0x62f, LSL #12
    SUBS  W8, W19, W14, LSR #22
    ANDS  W22, W23, #0xfff8fff8
    ADDS  X5, X5, X4, LSR #23
    ADDS  W7, W13, W14, ASR #8
    ADDS  X17, X11, #0x1a7, LSL #12
    ADDS  W15, W25, W27, UXTH #4
    SUBS  W19, W5, #0x1b2
    SUBS  X5, X16, X20, ASR #54
    ANDS  X12, X18, #0xfffff800003fffff
    ADDS  W7, W8, W23, ASR #14
    ADDS  W8, W21, W28, SXTX #3
    ADDS  W15, W5, W8, UXTX #4
    SUBS  X14, X29, W23, SXTB #0
    FCMPE  S23, #0.0
    FCMP  D28, D23
    ANDS  W20, W10, W4, ASR #19
    SUBS  W19, W16, #0x300
    SUBS  X6, X22, X21, LSR #25
    ANDS  W27, W16, W20, ASR #7
    ANDS  W24, W4, #0xc3ffc3ff
    ADDS  X20, X21, W14, UXTH #1
    SUBS  X27, X22, #0xd50
    SUBS  X19, X17, X19, LSR #32
    SUBS  X21, X17, #0xba8, LSL #12
    SUBS  W26, W21, #0x62f
    ADDS  X6, X7, #0x82f, LSL #12
    ANDS  X17, X16, X15, LSL #57
    ANDS  X24, X12, X20, LSL #28
    ANDS  X24, X28, #0x1ffc1ffc1ffc1ffc
    FCMPE  D7, D0
    ANDS  W6, W6, W29, ASR #5
    SUBS  X25, X19, X28, UXTX #1
    ANDS  W23, W8, #0x1ffe
    ANDS  W21, W17, W21, ASR #27
    ADDS  X27, X5, X17, ASR #33
    ANDS  X4, X23, #0xffe00000ffe0
    SUBS  W7, W24, #0xff0, LSL #12
    SUBS  X18, X25, X29, LSL #53
    ADDS  X18, X7, X14, SXTX #4
    SUBS  X4, X29, W18, SXTB #0
    SUBS  X26, X20, X28, ASR #58
    SUBS  X26, X27, X10, LSL #54
    ADDS  W5, W18, W28, LSR #7
    SUBS  X4, X22, W6, UXTH #1
    ADDS  W4, W28, #0xfed
    ADDS  X21, X16, W27, UXTH #0
    SUBS  W5, W29, #0x428
    ADDS  W21, W29, W4, UXTW #1
    SUBS  X11, X10, X13, ASR #14
    ADDS  W25, W17, W15, LSL #31
    ADDS  X15, X16, #0x744, LSL #12
    ANDS  X18, X26, #0xff000001ff000001
    ANDS  X9, X8, #0xffffff80003fffff
    SUBS  X20, X24, X10, UXTX #2
    SUBS  W21, W21, W4, LSR #30
    ADDS  X18, X7, #0x6f
    ADDS  X22, X9, #0xd61
    ADDS  X27, X21, W8, UXTH #1
    ADDS  X8, X29, X5, ASR #28
    SUBS  W20, W21, #0x5df, LSL #12
    ADDS  W27, W6, W8, UXTB #4
    SUBS  X20, X10, W9, SXTW #0
    ANDS  X15, X9, X10, ASR #52
    ADDS  X11, X5, W5, SXTH #1
    ADDS  X19, X20, X24, ASR #47
    ADDS  W11, W22, W23, ASR #14
    ADDS  X18, X22, X12, LSL #41
    ADDS  X18, X7, X28, ASR #35
    SUBS  X4, X16, W15, SXTW #4
    SUBS  W8, W6, W20, LSR #14
    SUBS  X26, X21, X18, LSL #36
    SUBS  X17, X19, X11, SXTX #0
    SUBS  X4, X19, W20, UXTW #1
    ADDS  X22, X24, #0x79a, LSL #12
    ADDS  W7, W26, W29, SXTW #2
    SUBS  X10, X25, W28, SXTW #3
    SUBS  W4, W5, W9, SXTX #1
    ANDS  X19, X23, X16, LSR #42
    FCMPE  S28, #0.0
    ADDS  W25, W23, W9, SXTB #0
    ADDS  W29, W11, #0x628
    ADDS  X7, X26, #0xdd, LSL #12
    SUBS  X7, X6, X12, ASR #14
    ANDS  X25, X6, X8, LSL #30
    ANDS  X16, X12, X18, ROR #26
    SUBS  W29, W7, W17, UXTH #1
    SUBS  X21, X12, X16, ASR #1
    SUBS  X27, X21, X26, ASR #22
    SUBS  X20, X6, X28, LSR #61
    ADDS  W19, W16, #0xb0d
    FCMP  D1, D12
    ANDS  X22, X8, X22, ASR #27
    ANDS  X26, X2, X18, LSR #60
    ANDS  W7, W7, W27, LSR #18
    ADDS  W11, W16, W21, UXTX #4
    SUBS  W22, W10, W25, ASR #25
    SUBS  X19, X26, #0x0
    ANDS  X17, X10, X26, ROR #1
    ANDS  W14, W8, #0xffff8fff
    ADDS  W11, W23, W18, ASR #2
    ANDS  X20, X24, #0x3fffff000000
    ADDS  W10, W13, #0xa69
    ADDS  X8, X23, X12, LSR #11
    ANDS  W18, W20, W10, ROR #18
    ANDS  W10, W20, #0x7fc00000
    ADDS  X5, X8, X7, SXTX #4
    SUBS  W16, W25, #0x25d
    ADDS  W8, W22, W2, SXTH #2
    ADDS  W26, W25, W23, SXTH #2
    ANDS  X11, X27, #0x8383838383838383
    ADDS  W24, W27, W21, UXTX #0
    SUBS  W17, W9, #0xb5c
    ADDS  X17, X6, X12, LSR #59
    SUBS  X29, X5, #0x369, LSL #12
    ANDS  X22, X6, #0xfffffff7fffffff7
    ANDS  W22, W8, #0x700070
    ANDS  W8, W24, W21, LSR #11
    FCMPE  D0, #0.0
    ANDS  X6, X29, X5, ASR #59
    FCMPE  D5, #0.0
    SUBS  W19, W17, #0x419
    SUBS  W29, W8, W5, LSL #6
    ADDS  W29, W26, #0xd17, LSL #12
    SUBS  W25, W6, W19, UXTW #0
    ANDS  X7, X10, #0xffffff0000000fff
    ADDS  X19, X5, #0x7fc, LSL #12
    ADDS  X23, X25, X27, ASR #17
    ADDS  X12, X15, #0xf80
    ANDS  X22, X21, X9, ROR #16
    SUBS  W22, W20, W8, SXTB #2
    SUBS  X18, X6, #0x117
    ANDS  W23, W26, #0xf807f807
    SUBS  W18, W12, W16, SXTB #2
    SUBS  X20, X13, #0x0
    FCMPE  D15, #0.0
    ADDS  X23, X18, X7, UXTX #4
    SUBS  W23, W21, W2, LSL #30
    SUBS  X29, X5, W10, SXTW #0
    SUBS  X14, X22, #0x9cc
    SUBS  X26, X23, W20, SXTW #1
    ADDS  X14, X17, X27, SXTX #4
    ANDS  X14, X6, #0xf0007fffffffffff
    ANDS  W17, W22, #0xffff801f
    ADDS  X29, X8, W29, SXTB #1
    ANDS  X24, X18, #0x7c0000007c
    ADDS  W9, W16, W24, ASR #11
    ANDS  W6, W8, W19, ROR #21
    ANDS  W4, W12, #0xfc1ffc1f
    SUBS  X27, X11, X9, LSL #4
    ADDS  W29, W28, W13, SXTX #3
    ANDS  X16, X26, X20, LSR #39
    SUBS  W28, W29, W17, ASR #0
    SUBS  X12, X9, #0x4cb, LSL #12
    SUBS  X23, X28, X16, LSL #13
    ADDS  W16, W15, #0x1d8
    ADDS  W12, W17, W26, ASR #26
    SUBS  W29, W5, #0x45e
    ADDS  X15, X29, #0x50e, LSL #12
    ANDS  X16, X12, X27, ASR #29
    ADDS  W10, W11, W20, LSR #11
    ANDS  X15, X10, X12, ASR #30
    ANDS  X4, X28, X18, ROR #40
    SUBS  X6, X23, W15, SXTH #4
    ADDS  X11, X14, X25, LSR #2
    ADDS  W23, W11, #0x5a8, LSL #12
    FCMPE  S5, S10
    FCMPE  S19, #0.0
    ANDS  W16, W23, #0xc7c7c7c7
    ADDS  X15, X6, #0x749, LSL #12
    SUBS  W15, W20, W13, SXTW #3
    SUBS  X19, X13, X19, LSL #54
    ANDS  W11, W26, #0x3e003e00
    SUBS  X2, X24, W9, UXTW #0
    SUBS  W23, W26, W29, LSL #23
    SUBS  X10, X22, #0xe5e, LSL #12
    ADDS  W9, W8, #0xc1, LSL #12
    ADDS  W27, W19, #0x4b0
    ANDS  W27, W16, W26, LSR #12
    SUBS  X8, X17, #0xb44, LSL #12
    SUBS  X16, X15, W5, UXTW #2
    ADDS  X29, X11, X2, LSL #15
    FCMPE  D18, D18
    SUBS  W9, W14, W14, ASR #2
    SUBS  W23, W20, W26, UXTX #3
    SUBS  W25, W14, W4, ASR #4
    SUBS  W9, W16, #0x598, LSL #12
    SUBS  X27, X27, W19, UXTH #3
    ANDS  X16, X9, X23, LSL #55
    ANDS  W23, W11, W19, LSR #15
    ANDS  W18, W24, #0xfffff003
    SUBS  X12, X16, W25, SXTW #3
    ANDS  X2, X10, X12, ASR #33
    ADDS  X5, X29, X26, ASR #43
    SUBS  X13, X13, #0x1
    B.NE  TaishanIntCcP01_label_84
    MOVZ  X10, #0x2000, LSL #0
    MOVK  X10, #0xff1a, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X21, X10, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8000, LSL #16
    SUB  X29, X28, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X12, #0xbdff, LSL #0
    MOVK  X12, #0x3f44, LSL #16
    MOVK  X12, #0x8000, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X18, X12, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntCcP01_TestFail
    MOVZ  X20, #0x6af, LSL #0
    MOVK  X20, #0x8049, LSL #16
    SUB  X11, X20, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X21, #0xc000, LSL #0
    MOVK  X21, #0xff4b, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X22, X21, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x2919, LSL #0
    MOVK  X17, #0xffa6, LSL #16
    SUB  X23, X17, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X15, #0x2000, LSL #0
    MOVK  X15, #0xff1a, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X2, X15, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntCcP01_TestFail
    MOVZ  X26, #0xbdff, LSL #0
    MOVK  X26, #0x3f44, LSL #16
    MOVK  X26, #0x8000, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X14, X26, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntCcP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X4, X5, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x2000, LSL #0
    MOVK  X23, #0xff1a, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X20, X23, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntCcP01_TestFail
    MOVZ  X26, #0x2919, LSL #0
    MOVK  X26, #0xffa6, LSL #16
    SUB  X12, X26, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X18
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X24, #0x1, LSL #0
    MOVK  X24, #0x9200, LSL #48
    SUB  X20, X24, X19
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X26, #0xc000, LSL #0
    MOVK  X26, #0xff4b, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X29, X26, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X6, X25, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x2000, LSL #0
    MOVK  X17, #0xff1a, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X25, X17, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X18, #0x1, LSL #0
    MOVK  X18, #0x9200, LSL #48
    SUB  X15, X18, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntCcP01_TestFail
    MOVZ  X8, #0xc000, LSL #0
    MOVK  X8, #0xff4b, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X19, X8, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X23, #0xc0fe, LSL #0
    MOVK  X23, #0x1, LSL #16
    SUB  X8, X23, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x8000, LSL #16
    SUB  X17, X19, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntCcP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
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
    MOVZ  X20, #0x14, LSL #0
TaishanIntCcP01_label_112:
    SUBS  X9, X2, X10, UXTX #4
    ANDS  X26, X15, X22, ROR #11
    ADDS  X19, X18, W21, SXTW #0
    ADDS  X28, X26, W12, UXTB #2
    ADDS  X17, X27, W19, SXTB #0
    SUBS  W28, W9, W24, ASR #4
    SUBS  X24, X9, W28, SXTB #2
    ADDS  W17, W6, W15, UXTW #4
    ADDS  W29, W11, W7, ASR #19
    SUBS  X21, X10, X24, LSL #38
    ADDS  X7, X8, X14, LSR #25
    ADDS  W26, W20, #0x710
    SUBS  W22, W12, #0x201, LSL #12
    ANDS  W11, W19, #0xffc1ffff
    SUBS  X14, X11, X15, ASR #55
    ADDS  X21, X8, X18, LSL #8
    ADDS  X29, X27, X23, LSL #38
    ADDS  X11, X7, W14, SXTW #2
    ANDS  W15, W20, #0xc3ffc3ff
    ANDS  W17, W15, W18, LSR #23
    ADDS  X28, X14, X6, LSR #35
    FCMP  S24, S6
    SUBS  W28, W11, W6, LSR #30
    FCMP  D30, #0.0
    SUBS  X7, X17, X19, LSR #11
    ANDS  W2, W12, W26, ROR #29
    ANDS  W28, W21, W10, LSL #29
    SUBS  X23, X17, #0x3b4
    ADDS  W12, W25, W24, ASR #9
    SUBS  W19, W29, W9, SXTH #3
    SUBS  X5, X22, X21, ASR #13
    FCMP  D30, D0
    SUBS  X13, X10, X26, LSL #40
    ADDS  W25, W21, W11, SXTW #2
    ANDS  X19, X12, X10, ASR #33
    ADDS  W23, W24, #0x7c5
    ADDS  W6, W17, W10, UXTX #0
    SUBS  W22, W21, W25, SXTB #0
    ADDS  X19, X14, #0xd32
    ADDS  X29, X7, X28, LSR #10
    SUBS  W28, W17, #0x10
    SUBS  X5, X6, #0x10
    ADDS  X4, X17, W8, SXTB #2
    SUBS  X16, X9, #0xb18
    ANDS  W4, W16, W22, ASR #28
    ANDS  W19, W23, #0x7ff0000
    ADDS  W25, W27, W5, UXTH #4
    ANDS  W2, W21, W12, LSL #15
    ANDS  X8, X19, #0x1ffffffffffe0
    ADDS  W12, W26, W12, ASR #10
    FCMPE  S0, #0.0
    ANDS  W23, W13, W23, ROR #23
    FCMPE  S14, S4
    ADDS  X5, X22, #0xb7c, LSL #12
    SUBS  W18, W4, W23, SXTX #0
    ADDS  W21, W7, #0x8ec, LSL #12
    SUBS  W7, W7, W15, UXTH #0
    FCMPE  D1, #0.0
    ADDS  X26, X18, X4, LSR #36
    ANDS  X8, X4, X2, LSL #56
    ADDS  X25, X24, W7, UXTH #4
    FCMPE  D25, #0.0
    SUBS  W25, W4, W15, UXTH #4
    ADDS  W14, W22, W4, LSR #25
    ANDS  W14, W25, #0x83ff83ff
    SUBS  X17, X21, #0x2e8, LSL #12
    FCMPE  S28, S8
    SUBS  W17, W22, W15, UXTH #4
    ANDS  W18, W18, W22, LSR #25
    ANDS  X14, X14, #0x6000600060006
    ANDS  W26, W4, W28, LSR #5
    SUBS  X19, X22, W2, UXTB #1
    SUBS  X21, X20, #0xb5f, LSL #12
    ADDS  X15, X13, X4, SXTX #2
    ADDS  X14, X16, #0x6ff
    ANDS  X28, X18, #0x40004000400040
    SUBS  X17, X14, X7, ASR #19
    ADDS  W28, W21, W29, SXTH #3
    ANDS  W25, W13, W11, ROR #19
    SUBS  X24, X28, X27, LSR #48
    ANDS  W28, W15, #0xe1e1e1e1
    SUBS  W2, W8, W19, SXTX #4
    ANDS  W23, W25, #0xfe00003f
    ANDS  W23, W7, #0xe03fe03f
    SUBS  X11, X26, #0x6f0
    SUBS  X26, X13, X24, ASR #53
    SUBS  X16, X14, W27, UXTW #2
    ANDS  X5, X29, #0x1818181818181818
    ANDS  W22, W13, W22, LSR #7
    ANDS  X12, X14, X17, LSR #53
    SUBS  X23, X28, W25, UXTW #2
    SUBS  X2, X11, W20, UXTH #0
    SUBS  X28, X10, X11, UXTX #0
    ADDS  W29, W25, W28, ASR #0
    SUBS  X15, X24, X13, SXTX #2
    ADDS  X19, X13, W28, UXTH #1
    ANDS  W8, W24, W12, ROR #28
    ADDS  X9, X17, X7, LSR #22
    FCMPE  D15, #0.0
    ADDS  X6, X6, W24, UXTB #2
    SUBS  X23, X5, W11, SXTW #4
    SUBS  X25, X8, #0x666
    ADDS  W28, W27, W7, ASR #21
    SUBS  X27, X6, W29, UXTW #1
    ADDS  W17, W20, W16, ASR #10
    ADDS  W11, W9, W27, LSR #31
    ANDS  X15, X11, X22, ASR #3
    SUBS  X23, X9, X18, ASR #63
    ADDS  W23, W22, W9, LSL #24
    ANDS  X26, X20, X23, LSR #23
    ADDS  W16, W17, #0xd86, LSL #12
    ANDS  W8, W13, #0xcccccccc
    ADDS  W14, W9, W18, ASR #18
    SUBS  W6, W2, W16, ASR #9
    ADDS  W18, W13, W5, LSR #12
    ADDS  W2, W20, W24, SXTB #2
    ADDS  W28, W4, W26, ASR #28
    SUBS  X27, X22, X18, ASR #56
    ADDS  X26, X26, W22, SXTH #0
    ANDS  W14, W15, W12, ASR #23
    ADDS  X25, X2, X11, ASR #18
    ADDS  W2, W5, W10, SXTB #3
    ANDS  W24, W19, W4, LSR #27
    SUBS  W21, W24, W7, ASR #3
    SUBS  W24, W13, W27, SXTW #1
    FCMP  S5, #0.0
    ANDS  X13, X12, X14, ROR #1
    ADDS  W9, W16, W28, ASR #11
    ANDS  W25, W5, W8, LSR #9
    SUBS  X6, X25, X6, LSR #63
    SUBS  X27, X21, X10, ASR #46
    ADDS  W12, W9, W25, LSL #7
    ANDS  W6, W26, #0x1fffffc0
    SUBS  W14, W13, W16, LSR #14
    ANDS  W17, W22, #0xe000e
    ADDS  X18, X16, #0xc40, LSL #12
    SUBS  W9, W18, #0xae3
    SUBS  X23, X24, #0xfe0
    SUBS  W12, W5, W4, UXTH #0
    SUBS  W2, W19, W4, UXTX #0
    SUBS  W27, W8, W16, UXTX #1
    ANDS  X27, X28, X27, LSL #4
    SUBS  W25, W29, W28, UXTB #1
    ANDS  X4, X6, #0xfdfdfdfdfdfdfdfd
    ADDS  W12, W9, W26, ASR #0
    ANDS  W25, W15, W13, ROR #21
    ADDS  W19, W22, #0xd50
    SUBS  X28, X12, #0x3f4
    ADDS  X18, X7, W18, SXTW #2
    SUBS  W7, W12, #0xdbd, LSL #12
    ADDS  W19, W24, W4, SXTX #0
    ADDS  X14, X26, #0xcfb
    SUBS  X9, X7, W19, UXTH #4
    SUBS  W25, W27, W11, SXTW #4
    ANDS  W28, W17, W4, ASR #24
    SUBS  X14, X19, W19, UXTW #1
    ANDS  W5, W29, #0x4000400
    ADDS  X28, X10, X29, ASR #8
    ADDS  X15, X8, #0x6e
    SUBS  X7, X13, #0x9b0, LSL #12
    ADDS  W16, W13, #0x773
    SUBS  W28, W4, W6, UXTH #0
    SUBS  W18, W19, W16, ASR #2
    ADDS  W13, W2, W25, LSR #14
    ANDS  W7, W13, #0x7f
    ANDS  X17, X23, #0x80001fff80001fff
    SUBS  W8, W5, #0xe43
    SUBS  W29, W5, W18, UXTB #1
    SUBS  X22, X13, X7, ASR #54
    SUBS  X8, X13, X23, LSL #10
    ADDS  X7, X11, #0xaf0
    SUBS  X15, X6, X2, ASR #55
    ANDS  X7, X12, X14, ROR #50
    SUBS  X16, X19, W10, UXTW #2
    SUBS  X8, X16, W23, UXTH #2
    ADDS  X28, X10, X22, ASR #23
    FCMPE  S16, #0.0
    ADDS  X22, X22, W23, UXTW #3
    ADDS  W12, W21, W15, SXTX #2
    ANDS  W9, W27, #0x1fc
    ADDS  X9, X2, #0x6ba, LSL #12
    SUBS  W12, W23, W6, UXTX #2
    SUBS  X21, X18, #0x5c0
    ADDS  W23, W5, #0xd82, LSL #12
    ANDS  X6, X14, #0xfffffffffffff803
    ADDS  X12, X14, #0x8e1, LSL #12
    FCMPE  D13, D3
    ADDS  X15, X10, #0xa50
    ANDS  X29, X4, #0xe001e001e001e001
    ADDS  X5, X21, W9, UXTW #2
    ANDS  X6, X22, #0x1fffc00000
    ANDS  W22, W16, W28, ROR #31
    SUBS  W16, W17, W7, LSR #9
    FCMP  S16, S13
    ANDS  X8, X27, #0x707070707070707
    ANDS  W16, W23, #0x3fffe
    ANDS  X12, X15, #0x1c0000001c00000
    SUBS  W23, W2, W13, SXTH #2
    SUBS  W19, W23, W12, LSL #5
    SUBS  X19, X17, X19, LSL #51
    SUBS  X20, X20, #0x1
    B.NE  TaishanIntCcP01_label_112
    MOVZ  X14, #0x1eb1, LSL #0
    SUB  X17, X14, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X14, #0x2000, LSL #0
    SUB  X25, X14, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X27, #0xcf0b, LSL #0
    MOVK  X27, #0xfea8, LSL #16
    SUB  X2, X27, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xe7c0, LSL #16
    MOVK  X11, #0x7, LSL #32
    SUB  X14, X11, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x772d, LSL #0
    MOVK  X17, #0x104, LSL #16
    SUB  X10, X17, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x100, LSL #16
    SUB  X10, X23, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntCcP01_TestFail
    MOVZ  X12, #0xbeb1, LSL #0
    MOVK  X12, #0x6b, LSL #16
    SUB  X25, X12, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntCcP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xe7c0, LSL #16
    MOVK  X5, #0x7, LSL #32
    SUB  X15, X5, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X18, #0xbeb1, LSL #0
    MOVK  X18, #0x6b, LSL #16
    SUB  X13, X18, X12
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntCcP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X14
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X22, #0x2000, LSL #0
    SUB  X9, X22, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntCcP01_TestFail
    MOVZ  X21, #0x772d, LSL #0
    MOVK  X21, #0x104, LSL #16
    SUB  X17, X21, X17
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X22, #0xbeb1, LSL #0
    MOVK  X22, #0x6b, LSL #16
    SUB  X2, X22, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X25, #0x772d, LSL #0
    MOVK  X25, #0x104, LSL #16
    SUB  X14, X25, X21
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X22, #0xbeb1, LSL #0
    MOVK  X22, #0x6b, LSL #16
    SUB  X9, X22, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x100, LSL #16
    SUB  X28, X13, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X10, #0xbbe3, LSL #0
    MOVK  X10, #0xfcf9, LSL #16
    SUB  X29, X10, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x772d, LSL #0
    MOVK  X28, #0x104, LSL #16
    SUB  X11, X28, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X28, #0xcf0b, LSL #0
    MOVK  X28, #0xfea8, LSL #16
    SUB  X20, X28, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X8, #0xcf0b, LSL #0
    MOVK  X8, #0xfea8, LSL #16
    SUB  X11, X8, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x0, LSL #0
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
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X10, #0x14, LSL #0
TaishanIntCcP01_label_140:
    ADDS  X11, X29, #0xa23, LSL #12
    ANDS  X9, X25, #0xfffff0007fffffff
    SUBS  X12, X16, #0xf4d
    SUBS  W13, W26, #0x115
    ADDS  W19, W2, W12, UXTB #0
    ANDS  W11, W11, W9, LSR #2
    FCMPE  D6, D31
    ADDS  X7, X5, #0xe75, LSL #12
    FCMPE  S3, #0.0
    ADDS  W29, W17, W21, LSR #21
    SUBS  W5, W9, W9, SXTW #0
    SUBS  W25, W29, W7, LSL #6
    ADDS  X21, X14, #0x737, LSL #12
    ANDS  W11, W22, W24, LSL #14
    ANDS  X23, X29, #0x3fffe0003fffe
    SUBS  X28, X23, W13, SXTH #1
    ANDS  X14, X23, X8, ASR #3
    SUBS  W28, W29, #0xa01
    ANDS  X12, X4, #0xff81ff81ff81ff81
    ANDS  X20, X19, #0xf
    SUBS  X5, X9, W17, UXTH #0
    ADDS  X17, X28, X26, LSL #43
    ADDS  X17, X10, X10, UXTX #4
    ADDS  W7, W24, #0xd60
    SUBS  X16, X29, #0xc6b
    ANDS  X21, X18, #0x303030303030303
    ANDS  W13, W10, #0x7ffffffc
    ADDS  W6, W10, #0x849
    ADDS  W16, W22, W29, LSL #1
    ADDS  W4, W24, #0x5b9, LSL #12
    ANDS  W19, W18, #0x38003800
    ADDS  W5, W2, #0x7b0
    FCMPE  D17, #0.0
    ANDS  X6, X7, X16, ROR #28
    SUBS  W17, W22, W28, ASR #11
    ADDS  X6, X22, W9, SXTH #4
    SUBS  X5, X7, #0x590
    ADDS  X7, X5, X13, LSR #19
    SUBS  W20, W15, W20, UXTH #4
    ADDS  W17, W20, W11, SXTW #4
    SUBS  W11, W11, W16, SXTH #0
    ADDS  X12, X29, X11, ASR #39
    SUBS  W2, W10, W17, LSR #25
    ANDS  X11, X10, X28, ASR #12
    ADDS  W23, W28, W14, SXTW #0
    ADDS  X15, X18, #0x6b7
    SUBS  W26, W18, W16, SXTX #1
    SUBS  W19, W27, #0x566, LSL #12
    ANDS  W4, W23, #0xf00fffff
    ADDS  X14, X29, X25, ASR #38
    SUBS  W27, W10, #0x10
    ADDS  X5, X22, W15, SXTB #2
    ANDS  W26, W23, #0xfffff807
    SUBS  W7, W6, #0x0
    SUBS  X14, X13, X12, LSR #29
    SUBS  X7, X24, X7, ASR #3
    SUBS  W28, W9, #0x3cc
    ADDS  X18, X4, #0x791
    ADDS  X22, X20, #0xe0b, LSL #12
    SUBS  X15, X18, #0x230
    ADDS  W9, W4, W17, LSR #21
    SUBS  X19, X29, X6, LSL #21
    ADDS  X12, X6, #0x5c6
    ANDS  X26, X16, X25, ASR #9
    SUBS  W27, W13, #0xdca, LSL #12
    SUBS  W22, W17, W15, LSR #10
    ANDS  W22, W11, #0xffe00000
    ANDS  X27, X11, #0xf8000000f800
    ADDS  W20, W24, W9, LSL #9
    SUBS  X22, X24, #0x18f
    ADDS  X18, X22, #0xc4a
    ANDS  X2, X6, X8, ROR #16
    ADDS  W14, W23, #0x817, LSL #12
    SUBS  W20, W15, W2, LSR #18
    SUBS  X21, X20, #0x479, LSL #12
    SUBS  X9, X17, X27, ASR #17
    ANDS  X16, X11, X23, LSR #3
    ADDS  W13, W6, W26, LSL #13
    ANDS  X19, X24, X11, LSL #60
    SUBS  W13, W4, W13, LSL #29
    ADDS  W13, W11, W14, LSR #3
    ANDS  X22, X23, #0xfffff80000000000
    SUBS  W25, W14, W25, SXTB #1
    SUBS  X27, X10, X14, LSR #15
    ANDS  W16, W6, #0xfff9fff9
    SUBS  W26, W10, #0xf9f
    ADDS  X23, X14, X18, LSL #24
    ANDS  X11, X15, X15, LSL #2
    SUBS  W8, W15, W29, SXTX #4
    SUBS  W26, W19, #0x8fb
    ADDS  W23, W21, W17, SXTH #2
    SUBS  W21, W6, #0x486, LSL #12
    ANDS  W23, W12, #0xf1f1f1f1
    ADDS  X14, X13, X16, ASR #62
    ANDS  X22, X28, X12, LSR #48
    SUBS  W26, W9, W21, SXTW #1
    FCMP  S19, S6
    ADDS  X4, X11, X11, ASR #10
    ADDS  X6, X22, #0x600
    ADDS  X28, X28, X24, UXTX #1
    ADDS  W2, W21, W27, UXTH #3
    ADDS  X28, X13, W26, SXTB #1
    ADDS  W11, W25, W15, LSL #9
    SUBS  X5, X7, X12, LSL #62
    SUBS  X23, X6, #0xa0
    SUBS  X28, X18, W14, SXTW #3
    FCMP  S14, S3
    SUBS  W7, W21, W4, UXTH #1
    SUBS  W24, W23, W16, SXTW #4
    ADDS  W5, W9, W7, UXTX #0
    SUBS  X27, X10, X17, ASR #61
    FCMPE  D23, D5
    ADDS  W8, W28, W29, LSR #16
    ADDS  X24, X10, #0xebb
    SUBS  X24, X14, X29, ASR #63
    SUBS  W18, W16, W19, UXTX #3
    ADDS  W24, W6, W15, SXTX #1
    ADDS  X13, X2, X21, ASR #17
    FCMPE  S28, #0.0
    ADDS  W4, W24, W22, UXTH #1
    ANDS  X18, X8, X10, ROR #14
    SUBS  X11, X15, W19, SXTB #3
    SUBS  X22, X18, #0x0
    ADDS  W25, W10, W29, LSL #1
    ADDS  X16, X5, X29, LSL #42
    ADDS  W22, W24, W8, LSL #2
    ANDS  X16, X16, X27, ASR #2
    ADDS  W5, W13, #0xab9, LSL #12
    FCMP  D30, D0
    SUBS  W27, W26, W4, UXTH #0
    SUBS  W12, W13, W6, ASR #3
    FCMPE  S23, S14
    ANDS  W26, W18, W12, LSL #12
    ANDS  W12, W21, #0xff000007
    SUBS  W16, W4, W19, UXTB #1
    SUBS  X5, X9, X28, ASR #22
    SUBS  W23, W16, W15, SXTX #2
    SUBS  W5, W24, W15, LSL #16
    ANDS  W17, W6, W22, ASR #29
    ANDS  X11, X17, X19, ASR #39
    SUBS  X21, X17, X15, LSR #13
    ANDS  W16, W12, W20, ASR #19
    SUBS  X13, X18, X14, ASR #43
    ADDS  W25, W8, #0xc6b
    ADDS  W18, W8, W21, LSL #18
    ANDS  X15, X10, X8, ROR #5
    SUBS  W23, W23, #0xaf8, LSL #12
    ADDS  X24, X14, #0x4e0
    SUBS  X4, X9, X28, ASR #46
    ADDS  X22, X27, X17, LSL #43
    SUBS  X19, X26, X6, LSR #8
    SUBS  W15, W15, W8, UXTH #3
    ADDS  X23, X16, #0xe1e
    SUBS  X16, X17, #0x380
    SUBS  W18, W13, W17, LSL #28
    ADDS  X4, X29, #0xa29, LSL #12
    SUBS  X19, X16, X21, LSR #45
    ANDS  X7, X6, X20, LSL #46
    ANDS  X12, X10, #0xfff0000000007fff
    FCMPE  S22, #0.0
    ADDS  W14, W27, W8, LSL #4
    SUBS  X2, X24, W14, UXTB #4
    ADDS  X9, X2, #0xfcd
    ANDS  X24, X25, X8, LSR #27
    SUBS  W19, W18, #0xd77, LSL #12
    SUBS  X2, X6, W15, UXTW #1
    ANDS  W14, W26, #0x6060606
    ANDS  W11, W4, #0x1f8000
    ANDS  X6, X11, X14, LSR #23
    SUBS  X18, X27, W8, UXTW #2
    SUBS  W12, W17, #0xb42
    ADDS  W14, W11, W18, SXTW #3
    ADDS  W13, W2, #0xdd0
    ADDS  W19, W23, #0xaf8
    SUBS  W25, W13, W16, UXTW #0
    FCMP  D0, #0.0
    ANDS  X12, X22, #0xfffc000007ffffff
    FCMPE  D0, D27
    ANDS  X15, X11, #0xf8000000f800000
    SUBS  X24, X29, #0xc23
    SUBS  X9, X26, X15, LSL #53
    ADDS  X9, X10, X7, ASR #24
    ANDS  W29, W13, W11, ASR #18
    ANDS  X16, X2, #0xffc00003ffc00003
    ADDS  W22, W17, W8, LSL #2
    FCMP  S6, S30
    SUBS  W27, W12, W23, UXTH #0
    SUBS  W19, W27, #0xc0d, LSL #12
    ADDS  X28, X11, X12, UXTX #4
    ANDS  X9, X14, #0x7ff800007ff8000
    SUBS  X6, X24, W17, UXTB #2
    ADDS  W15, W4, W12, LSL #21
    ADDS  X27, X20, W22, SXTB #0
    ADDS  W14, W26, #0x29
    ADDS  W12, W5, #0xd1c
    ANDS  W29, W18, #0x7c0
    SUBS  X17, X11, X7, SXTX #2
    FCMPE  D21, #0.0
    ANDS  W14, W21, #0xfffe00
    ADDS  W22, W2, #0x73a
    SUBS  X10, X10, #0x1
    B.NE  TaishanIntCcP01_label_140
    MOVZ  X27, #0x27c2, LSL #0
    MOVK  X27, #0x2, LSL #16
    MOVK  X27, #0xfffe, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X6, #0x1000, LSL #0
    MOVK  X6, #0xb2, LSL #16
    SUB  X13, X6, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x9414, LSL #0
    MOVK  X2, #0x84a5, LSL #16
    SUB  X23, X2, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X5, #0x1000, LSL #0
    MOVK  X5, #0xb2, LSL #16
    SUB  X11, X5, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X26, #0x18a7, LSL #0
    MOVK  X26, #0xff79, LSL #16
    SUB  X4, X26, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntCcP01_TestFail
    MOVZ  X22, #0x8000, LSL #0
    MOVK  X22, #0x7b6, LSL #16
    SUB  X28, X22, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X6, #0xa130, LSL #0
    MOVK  X6, #0x84a5, LSL #16
    SUB  X20, X6, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X7, #0x9c00, LSL #0
    SUB  X11, X7, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X10, #0x1000, LSL #0
    MOVK  X10, #0x60b2, LSL #16
    SUB  X6, X10, X15
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X27, #0x2, LSL #0
    MOVK  X27, #0x2, LSL #32
    MOVK  X27, #0xffc0, LSL #48
    SUB  X21, X27, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X16, #0x9864, LSL #0
    MOVK  X16, #0x77f4, LSL #16
    MOVK  X16, #0xfffc, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X19, X16, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X26, X19, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X18, #0x8000, LSL #0
    MOVK  X18, #0x7b6, LSL #16
    SUB  X15, X18, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X12, #0x9bbe, LSL #0
    MOVK  X12, #0x1, LSL #16
    SUB  X15, X12, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x2, LSL #0
    MOVK  X28, #0x2, LSL #32
    MOVK  X28, #0xffc0, LSL #48
    SUB  X27, X28, X27
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntCcP01_TestFail
    MOVZ  X5, #0x2, LSL #0
    MOVK  X5, #0x2, LSL #32
    MOVK  X5, #0xffc0, LSL #48
    SUB  X14, X5, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X2, #0xb9d6, LSL #0
    MOVK  X2, #0xa409, LSL #16
    MOVK  X2, #0x4415, LSL #32
    MOVK  X2, #0x8474, LSL #48
    MOVZ  X4, #0x9674, LSL #0
    MOVK  X4, #0x3d6, LSL #16
    MOVK  X4, #0xdbb1, LSL #32
    MOVK  X4, #0x8961, LSL #48
    MOVZ  X5, #0xa6b5, LSL #0
    MOVK  X5, #0x519b, LSL #16
    MOVK  X5, #0x3d22, LSL #32
    MOVK  X5, #0xd2d8, LSL #48
    MOVZ  X6, #0xdf83, LSL #0
    MOVK  X6, #0xee49, LSL #16
    MOVK  X6, #0x9f6e, LSL #32
    MOVK  X6, #0x1a5d, LSL #48
    MOVZ  X7, #0x5905, LSL #0
    MOVK  X7, #0x2857, LSL #16
    MOVK  X7, #0x896b, LSL #32
    MOVK  X7, #0x20c5, LSL #48
    MOVZ  X8, #0xbf90, LSL #0
    MOVK  X8, #0xc8a6, LSL #16
    MOVK  X8, #0x6165, LSL #32
    MOVK  X8, #0x7ea2, LSL #48
    MOVZ  X9, #0xf4a6, LSL #0
    MOVK  X9, #0x6c75, LSL #16
    MOVK  X9, #0xe9e3, LSL #32
    MOVK  X9, #0x7fd4, LSL #48
    MOVZ  X10, #0xb48f, LSL #0
    MOVK  X10, #0x9aeb, LSL #16
    MOVK  X10, #0xa229, LSL #32
    MOVK  X10, #0x743d, LSL #48
    MOVZ  X11, #0x246b, LSL #0
    MOVK  X11, #0xe08a, LSL #16
    MOVK  X11, #0xb495, LSL #32
    MOVK  X11, #0x1909, LSL #48
    MOVZ  X12, #0xd78f, LSL #0
    MOVK  X12, #0xfd74, LSL #16
    MOVK  X12, #0xdccf, LSL #32
    MOVK  X12, #0xccc4, LSL #48
    MOVZ  X13, #0xd37b, LSL #0
    MOVK  X13, #0x99b8, LSL #16
    MOVK  X13, #0x15d4, LSL #32
    MOVK  X13, #0xa59b, LSL #48
    MOVZ  X14, #0x110, LSL #0
    MOVK  X14, #0x7f79, LSL #16
    MOVK  X14, #0xf046, LSL #32
    MOVK  X14, #0x4648, LSL #48
    MOVZ  X15, #0xd03f, LSL #0
    MOVK  X15, #0x5632, LSL #16
    MOVK  X15, #0x1686, LSL #32
    MOVK  X15, #0xe1ef, LSL #48
    MOVZ  X16, #0xb575, LSL #0
    MOVK  X16, #0xe8ce, LSL #16
    MOVK  X16, #0xbf8f, LSL #32
    MOVK  X16, #0x6f4d, LSL #48
    MOVZ  X17, #0x4b, LSL #0
    MOVK  X17, #0xfaf, LSL #16
    MOVK  X17, #0xe7f1, LSL #32
    MOVK  X17, #0xeaa9, LSL #48
    MOVZ  X18, #0x811d, LSL #0
    MOVK  X18, #0x88a6, LSL #16
    MOVK  X18, #0x8ba7, LSL #32
    MOVK  X18, #0x2206, LSL #48
    MOVZ  X19, #0xe8b1, LSL #0
    MOVK  X19, #0xf78a, LSL #16
    MOVK  X19, #0xf5ca, LSL #32
    MOVK  X19, #0x185a, LSL #48
    MOVZ  X20, #0x4345, LSL #0
    MOVK  X20, #0x913b, LSL #16
    MOVK  X20, #0xc9dd, LSL #32
    MOVK  X20, #0x153b, LSL #48
    MOVZ  X21, #0x7eb7, LSL #0
    MOVK  X21, #0xb671, LSL #16
    MOVK  X21, #0xa908, LSL #32
    MOVK  X21, #0x1900, LSL #48
    MOVZ  X22, #0x356a, LSL #0
    MOVK  X22, #0x27df, LSL #16
    MOVK  X22, #0x193, LSL #32
    MOVK  X22, #0x4999, LSL #48
    MOVZ  X23, #0xd3, LSL #0
    MOVK  X23, #0x28c2, LSL #16
    MOVK  X23, #0x3a00, LSL #32
    MOVK  X23, #0x465d, LSL #48
    MOVZ  X24, #0x1e74, LSL #0
    MOVK  X24, #0xba88, LSL #16
    MOVK  X24, #0x6b39, LSL #32
    MOVK  X24, #0x61d6, LSL #48
    MOVZ  X25, #0x63bc, LSL #0
    MOVK  X25, #0x263a, LSL #16
    MOVK  X25, #0x3dfb, LSL #32
    MOVK  X25, #0x99b2, LSL #48
    MOVZ  X26, #0x9968, LSL #0
    MOVK  X26, #0x36eb, LSL #16
    MOVK  X26, #0xde91, LSL #32
    MOVK  X26, #0x8664, LSL #48
    MOVZ  X27, #0x20c2, LSL #0
    MOVK  X27, #0x10ff, LSL #16
    MOVK  X27, #0x5860, LSL #32
    MOVK  X27, #0x2d8f, LSL #48
    MOVZ  X28, #0xbcac, LSL #0
    MOVK  X28, #0x4d50, LSL #16
    MOVK  X28, #0xe5b1, LSL #32
    MOVK  X28, #0xdf05, LSL #48
    MOVZ  X29, #0x42d6, LSL #0
    MOVK  X29, #0xe17b, LSL #16
    MOVK  X29, #0x3961, LSL #32
    MOVK  X29, #0x1cd, LSL #48
    MOVZ  X18, #0x14, LSL #0
TaishanIntCcP01_label_168:
    SUBS  W26, W22, W27, SXTH #0
    ANDS  W29, W10, W18, ROR #31
    ANDS  X7, X7, #0xfffffffff000
    SUBS  X5, X19, W18, UXTB #2
    FCMPE  D23, D24
    ADDS  W6, W28, W25, LSL #24
    ADDS  X26, X2, X25, LSR #28
    ANDS  X9, X2, #0x1fffffe00000000
    FCMP  D18, D3
    SUBS  X9, X26, W7, SXTB #3
    SUBS  X24, X7, X19, SXTX #0
    ADDS  X7, X8, W9, UXTW #1
    ANDS  X4, X22, X19, LSL #18
    ADDS  W22, W6, W29, LSL #22
    ADDS  X6, X19, #0x81e
    SUBS  W11, W14, W19, LSR #0
    SUBS  W19, W20, W5, ASR #15
    SUBS  W26, W12, W4, LSL #18
    ANDS  X6, X27, #0xffc0000003ffffff
    ADDS  X10, X24, X21, ASR #12
    ANDS  X26, X11, #0x7fc000
    ADDS  W27, W22, #0x5fb
    ADDS  W8, W8, W29, LSL #4
    ADDS  W26, W29, W16, UXTH #4
    ADDS  W6, W22, W7, SXTX #1
    SUBS  X28, X16, X26, LSR #30
    ADDS  X12, X2, #0xc4f
    SUBS  W13, W14, W5, ASR #0
    ANDS  W11, W18, #0x3c003c0
    ADDS  W14, W4, W29, UXTW #0
    SUBS  X8, X22, #0x7e0
    ADDS  W7, W23, W25, SXTH #1
    SUBS  W29, W17, W15, UXTH #2
    ADDS  W20, W4, W6, UXTB #4
    SUBS  X14, X19, #0x586
    ANDS  X16, X16, #0xfff8fffffff8ffff
    SUBS  W23, W14, #0xa0d, LSL #12
    ADDS  W8, W27, W7, UXTB #0
    ANDS  W12, W14, W24, LSL #16
    SUBS  X13, X25, X14, LSL #6
    ANDS  X24, X24, X27, LSL #10
    SUBS  X10, X17, X21, SXTX #1
    SUBS  W19, W2, #0xace, LSL #12
    SUBS  X25, X26, X18, ASR #39
    ADDS  X21, X16, W10, SXTW #3
    ANDS  X21, X21, X4, ROR #6
    SUBS  X26, X6, #0xdf0
    ANDS  X12, X10, #0x7fe000000000000
    ADDS  X11, X19, X10, LSL #1
    ADDS  W11, W19, W27, UXTB #1
    SUBS  W14, W17, W18, UXTX #4
    SUBS  W7, W13, W17, ASR #28
    SUBS  W12, W28, W18, UXTB #3
    ANDS  X23, X18, X6, ROR #51
    FCMP  S17, #0.0
    SUBS  W15, W13, W15, UXTW #3
    SUBS  X22, X18, W16, UXTB #3
    ANDS  W19, W18, W8, ROR #15
    ADDS  W20, W2, W10, UXTX #2
    SUBS  X15, X27, W14, SXTW #0
    SUBS  W28, W14, W25, LSR #24
    SUBS  W12, W28, W26, ASR #0
    ADDS  X25, X29, X14, SXTX #3
    ANDS  X2, X7, X7, LSL #3
    ADDS  W6, W8, W21, LSL #10
    SUBS  W29, W17, #0x2a3, LSL #12
    SUBS  X21, X27, #0x930
    ANDS  W26, W10, #0x1ff8
    ANDS  X20, X13, X20, LSL #16
    ADDS  X10, X11, #0x820
    ADDS  X25, X16, X16, UXTX #4
    ANDS  W4, W7, W24, ASR #22
    ADDS  X7, X2, #0xf20
    SUBS  W8, W22, W19, LSR #19
    ADDS  W24, W26, W8, UXTH #1
    FCMP  S16, #0.0
    ANDS  W2, W24, #0xffc0007f
    ANDS  X28, X22, #0xfc001ffffc001fff
    ADDS  W17, W5, #0x211, LSL #12
    ANDS  W14, W18, W28, ASR #19
    ADDS  X6, X18, W11, UXTW #4
    ADDS  X17, X10, X26, ASR #45
    SUBS  X16, X19, W8, SXTW #3
    ANDS  W2, W20, #0x7c000
    ANDS  X22, X13, X12, ASR #36
    SUBS  X6, X20, W19, SXTH #4
    ADDS  W22, W4, W16, SXTB #1
    ANDS  X12, X15, X11, LSR #38
    SUBS  W27, W14, W25, SXTH #3
    ADDS  W4, W25, W7, SXTB #2
    ADDS  X15, X14, #0x5e, LSL #12
    ADDS  X11, X2, #0x99c, LSL #12
    ANDS  W13, W23, W11, ASR #6
    ANDS  W11, W13, #0x3ff83ff8
    ADDS  W5, W18, #0x1d0
    ADDS  W5, W10, W16, SXTB #4
    ADDS  W5, W21, W11, ASR #24
    SUBS  X9, X18, W22, SXTH #2
    ANDS  W4, W9, W22, ASR #6
    ADDS  X24, X26, X28, LSL #26
    ADDS  W15, W5, #0x890
    SUBS  X28, X28, X22, LSL #7
    SUBS  X19, X25, #0x8c8
    ADDS  X28, X19, #0xbb6
    ADDS  X15, X19, X28, ASR #22
    SUBS  X23, X16, W10, UXTW #3
    ADDS  W11, W27, #0x9cb
    FCMPE  S26, S21
    ANDS  W23, W2, W15, LSL #6
    ADDS  W20, W2, W23, LSL #18
    SUBS  X23, X19, X9, UXTX #1
    ANDS  X14, X12, X13, LSL #47
    ADDS  X11, X21, X11, LSL #12
    ADDS  W28, W25, #0x638, LSL #12
    ANDS  X22, X16, #0xe007e007e007e007
    SUBS  X26, X8, X7, ASR #30
    FCMPE  S10, #0.0
    ADDS  W16, W21, #0x35a
    SUBS  W26, W20, W28, SXTH #1
    SUBS  W7, W9, W28, LSR #30
    SUBS  W24, W27, #0x3fc, LSL #12
    ADDS  X7, X12, #0x4e0
    ADDS  W15, W4, W4, SXTH #1
    ADDS  W9, W2, W23, SXTB #0
    SUBS  X29, X8, X23, ASR #46
    ANDS  W12, W4, W15, LSL #22
    ADDS  W28, W24, W4, UXTB #0
    ADDS  X6, X28, #0x1c6
    SUBS  W9, W16, W16, ASR #2
    ADDS  X29, X2, #0x614
    SUBS  X4, X14, W7, SXTW #2
    ANDS  W20, W25, W16, ROR #25
    ADDS  W2, W10, W23, LSR #12
    ANDS  X2, X23, X23, LSL #24
    ANDS  X27, X12, X2, LSR #42
    ADDS  W25, W13, #0xc50
    ADDS  W26, W8, W19, ASR #9
    ANDS  W15, W29, W2, ROR #18
    ADDS  X24, X24, #0xbbe, LSL #12
    ADDS  W16, W25, W11, LSR #6
    SUBS  X6, X16, #0xdec
    SUBS  W13, W7, W5, LSL #6
    SUBS  X10, X4, #0x5fc
    ADDS  W15, W24, #0x181
    ADDS  X6, X13, #0xebf
    FCMP  D12, D4
    ADDS  X10, X20, W10, SXTH #4
    SUBS  X13, X4, X14, LSL #23
    SUBS  W20, W8, #0x20a
    ANDS  X14, X20, #0xffffffffff80
    ANDS  W28, W2, W29, LSL #1
    SUBS  W23, W9, #0x3fe, LSL #12
    SUBS  X9, X5, X19, LSR #5
    ADDS  W4, W7, W14, LSL #12
    ANDS  X17, X20, X24, LSR #33
    SUBS  W25, W15, #0xfb5
    FCMPE  S1, #0.0
    SUBS  W13, W25, #0x889
    SUBS  W7, W2, W10, UXTB #1
    SUBS  W21, W19, W24, UXTX #4
    ADDS  X17, X6, W21, UXTH #4
    ADDS  W21, W25, W9, UXTH #0
    SUBS  X10, X14, X22, SXTX #2
    ANDS  X10, X19, #0x7e00
    ANDS  W14, W13, #0x1e001e
    ADDS  W5, W4, #0xb92
    ADDS  W14, W11, W25, SXTB #4
    SUBS  X5, X11, X28, LSR #56
    ANDS  W29, W21, W14, LSL #3
    ADDS  X27, X29, W11, SXTB #4
    SUBS  W22, W28, W4, LSR #4
    ANDS  W4, W5, #0x20202020
    SUBS  X21, X15, W17, UXTW #1
    ANDS  W16, W28, #0xf00001ff
    FCMPE  S9, #0.0
    ADDS  X12, X25, W19, SXTW #4
    FCMPE  D9, D1
    SUBS  X16, X9, X27, SXTX #1
    ANDS  W7, W14, #0xffe003ff
    ADDS  X11, X10, #0xf54, LSL #12
    ADDS  W21, W24, #0x55c, LSL #12
    ADDS  W12, W26, W14, SXTW #3
    ADDS  X8, X24, #0xf20
    FCMP  S2, S3
    ADDS  W15, W23, W25, UXTX #0
    ANDS  X12, X15, X22, ROR #39
    ADDS  W16, W12, W8, SXTH #1
    ANDS  W25, W13, #0xfffc0000
    ADDS  X29, X16, #0x667, LSL #12
    ANDS  W22, W7, W24, ASR #6
    SUBS  X29, X26, X19, LSL #6
    FCMPE  S18, S1
    ADDS  W11, W11, #0xded, LSL #12
    ADDS  X19, X27, #0xcf0
    ADDS  W5, W23, #0xe03, LSL #12
    SUBS  X7, X14, #0xca
    ANDS  X24, X5, #0xff000000000fffff
    SUBS  W26, W7, #0xc53, LSL #12
    ADDS  X26, X11, #0xce0, LSL #12
    ANDS  X12, X23, X14, ASR #63
    SUBS  X18, X18, #0x1
    B.NE  TaishanIntCcP01_label_168
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X19, #0x2000, LSL #0
    MOVK  X19, #0x2020, LSL #16
    SUB  X24, X19, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntCcP01_TestFail
    MOVZ  X15, #0x501c, LSL #0
    MOVK  X15, #0xa0, LSL #16
    SUB  X11, X15, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X13, #0xa8c1, LSL #0
    MOVK  X13, #0xf17c, LSL #16
    SUB  X21, X13, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X5, #0xbc20, LSL #0
    MOVK  X5, #0xffff, LSL #16
    SUB  X16, X5, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X20, #0x1400, LSL #0
    SUB  X26, X20, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X11, X24, X11
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X2, #0xa8c1, LSL #0
    MOVK  X2, #0xf17c, LSL #16
    SUB  X19, X2, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X22, #0xa98b, LSL #0
    MOVK  X22, #0xf17c, LSL #16
    SUB  X10, X22, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntCcP01_TestFail
    MOVZ  X24, #0x501c, LSL #0
    MOVK  X24, #0xa0, LSL #16
    SUB  X22, X24, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntCcP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntCcP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntCcP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntCcP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x78, LSL #16
    SUB  X10, X18, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntCcP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntCcP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntCcP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
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
    MOVZ  X11, #0x14, LSL #0
TaishanIntCcP01_label_196:
    SUBS  X10, X21, #0x96
    ANDS  W9, W23, W19, LSL #24
    SUBS  X23, X4, #0x39e
    SUBS  X17, X10, W24, UXTH #0
    ANDS  X8, X20, X21, LSL #15
    SUBS  W27, W11, W17, LSL #10
    ADDS  X17, X10, X29, LSL #39
    ADDS  W23, W12, W5, SXTX #2
    ADDS  X8, X16, #0x650
    ADDS  W9, W14, W28, UXTB #1
    ANDS  W25, W9, W6, LSR #5
    SUBS  W19, W15, #0x18b
    ANDS  X4, X17, X10, ROR #29
    ADDS  W4, W5, W14, UXTW #0
    FCMP  S11, S2
    ANDS  X27, X7, X10, ASR #7
    SUBS  X21, X11, W19, UXTW #2
    ANDS  W19, W21, W16, ASR #3
    ADDS  W23, W29, W15, LSR #11
    ADDS  X25, X18, W17, UXTH #3
    FCMP  D29, #0.0
    ANDS  W23, W10, W22, LSL #11
    ANDS  X12, X20, #0xe03fe03fe03fe03f
    ADDS  W28, W4, W28, LSL #29
    ADDS  X27, X16, #0xfa4
    SUBS  W20, W13, #0x530
    SUBS  X29, X25, #0x39c, LSL #12
    SUBS  W8, W12, W5, UXTW #4
    ANDS  X10, X16, X8, ASR #16
    SUBS  X4, X29, X29, LSL #39
    SUBS  X20, X12, #0xc60, LSL #12
    ADDS  W5, W11, W20, LSR #21
    ANDS  X29, X6, #0xfffffc7ffffffc7f
    ADDS  X17, X9, X29, LSR #21
    ADDS  X5, X26, X5, ASR #23
    ADDS  X10, X26, #0x470
    ANDS  X28, X14, #0xfefefefefefefefe
    ADDS  W19, W12, #0xfe1
    ADDS  W27, W24, W22, LSR #9
    ANDS  W28, W4, W9, ASR #18
    ADDS  W22, W7, W15, SXTX #0
    ANDS  X19, X28, X21, LSL #62
    ADDS  X28, X19, W17, SXTH #1
    ANDS  W28, W9, #0xfe00fe0
    FCMPE  S3, S24
    ADDS  W29, W16, #0xc05, LSL #12
    ADDS  X7, X25, W21, SXTH #3
    ADDS  X2, X18, W10, SXTH #0
    SUBS  W12, W11, #0x7f0, LSL #12
    ADDS  W2, W7, W21, SXTH #0
    ANDS  X9, X27, #0xf3fff3fff3fff3ff
    SUBS  X13, X13, #0x271, LSL #12
    SUBS  W7, W28, W19, ASR #12
    ANDS  X19, X2, #0xffffff800000003f
    SUBS  W14, W29, W6, SXTX #1
    SUBS  W17, W23, W16, SXTB #4
    ADDS  X10, X4, W14, UXTW #0
    SUBS  W24, W9, W4, ASR #16
    ANDS  X10, X24, #0xe7ffffffe7ffffff
    SUBS  X26, X29, W22, SXTW #4
    SUBS  W29, W14, W2, ASR #6
    SUBS  W17, W23, W10, SXTX #2
    ANDS  W24, W5, W15, LSL #30
    ADDS  X18, X28, X18, LSL #8
    ADDS  X25, X16, X9, ASR #9
    ADDS  X23, X24, W14, SXTB #1
    SUBS  W4, W28, W22, SXTB #3
    ADDS  W29, W6, W18, SXTH #1
    SUBS  W18, W7, W24, UXTX #4
    SUBS  W23, W2, W17, UXTH #1
    ADDS  X24, X24, X18, UXTX #3
    SUBS  W18, W21, W29, SXTB #4
    SUBS  W4, W6, W18, SXTX #1
    ANDS  X9, X25, X6, ASR #0
    SUBS  W17, W10, #0xc40
    ADDS  W28, W22, W24, SXTX #0
    SUBS  W20, W16, #0x580
    ADDS  X2, X14, W2, SXTB #2
    SUBS  W9, W13, #0x60, LSL #12
    SUBS  X20, X16, #0x1e0, LSL #12
    FCMP  S4, #0.0
    ANDS  W5, W13, W7, ROR #5
    FCMPE  S9, #0.0
    ADDS  W25, W14, W8, UXTH #3
    ANDS  W17, W16, W21, ROR #11
    SUBS  X24, X16, W23, UXTW #2
    ANDS  W16, W17, #0x18181818
    SUBS  X27, X16, X21, UXTX #4
    SUBS  X12, X15, W20, UXTW #3
    SUBS  W21, W10, #0xdd0
    ADDS  X20, X16, X9, LSR #2
    SUBS  W25, W24, #0x80
    SUBS  W28, W8, #0x2c0
    ADDS  W19, W10, #0xba2, LSL #12
    ANDS  X22, X6, #0xf80003fff80003ff
    SUBS  W8, W7, #0xe0
    ADDS  W2, W13, W10, UXTB #3
    SUBS  X27, X6, X29, LSL #21
    ADDS  W10, W18, W12, ASR #9
    SUBS  X22, X23, W15, SXTW #2
    FCMP  S2, #0.0
    ADDS  W23, W16, W10, ASR #28
    SUBS  W7, W8, W25, UXTW #3
    ADDS  X14, X24, #0x43a, LSL #12
    SUBS  W14, W13, W28, UXTB #0
    ADDS  W17, W19, #0x7ce, LSL #12
    SUBS  X9, X26, X2, LSL #1
    SUBS  W22, W8, #0xeb0, LSL #12
    ANDS  X17, X20, X2, LSL #6
    SUBS  W24, W15, #0xd38
    FCMPE  S12, S4
    ANDS  W7, W26, W16, LSR #2
    ADDS  W4, W15, W14, SXTX #0
    ADDS  W4, W21, #0x8db
    SUBS  X27, X23, #0x990
    ANDS  W26, W27, #0x3fffffc
    ANDS  X6, X8, X27, ASR #58
    ADDS  W29, W29, W26, ASR #26
    ANDS  X6, X19, X16, ASR #31
    ADDS  W2, W4, W24, LSL #27
    ADDS  W24, W16, #0x8f5, LSL #12
    ADDS  X7, X23, W28, SXTH #3
    ADDS  X24, X10, #0xee4
    SUBS  X29, X4, W26, SXTH #4
    ADDS  X22, X23, #0x802, LSL #12
    ANDS  X21, X14, #0xfffffff801ffffff
    SUBS  W8, W15, W2, ASR #30
    ADDS  X15, X16, W17, SXTW #4
    ANDS  X8, X9, #0xff800000000
    ADDS  X26, X29, X6, LSL #49
    SUBS  X2, X6, X21, LSL #49
    SUBS  W29, W17, W18, SXTW #2
    ADDS  X27, X17, X17, ASR #25
    ANDS  W2, W25, #0x80808080
    ADDS  X15, X19, #0x9d0
    ADDS  X13, X15, W6, SXTW #1
    ADDS  X2, X22, W21, UXTW #3
    ANDS  X6, X14, X17, LSR #41
    ADDS  W17, W29, W19, ASR #22
    ANDS  X24, X26, #0xcccccccccccccccc
    ADDS  X8, X21, X22, ASR #17
    ANDS  W14, W10, #0x7f7f7f7f
    ANDS  X24, X13, #0xcccccccccccccccc
    SUBS  W18, W10, W25, LSR #10
    SUBS  X6, X25, #0xf8a
    ADDS  W10, W21, W15, LSR #23
    SUBS  X27, X5, X27, ASR #27
    ADDS  X8, X6, W13, UXTW #1
    ANDS  W6, W25, W27, ASR #31
    ADDS  W19, W26, #0x2f0
    SUBS  W12, W27, W6, LSR #30
    SUBS  W27, W22, #0xd79
    ADDS  X20, X8, #0x840
    ADDS  X5, X8, W22, SXTW #2
    ANDS  X21, X8, X15, LSR #29
    ADDS  X5, X26, X20, LSL #18
    ADDS  W8, W8, W7, UXTB #0
    SUBS  W25, W15, #0x9e7
    SUBS  X26, X4, W29, SXTH #0
    ADDS  W28, W9, #0x50
    ANDS  X2, X2, #0xfffffffe0003ffff
    SUBS  W17, W8, W21, LSR #16
    ANDS  W28, W26, #0xffc0ffc0
    ADDS  X5, X8, X11, ASR #9
    SUBS  W27, W15, W11, ASR #25
    ANDS  X8, X2, #0x1c001c001c001c0
    SUBS  X21, X29, W11, SXTH #0
    ANDS  W21, W6, #0x3fff800
    SUBS  W10, W18, W8, LSL #26
    ANDS  X6, X10, #0x7ffffffc000000
    ADDS  W24, W12, W25, LSL #19
    ADDS  W6, W23, W28, UXTH #3
    ADDS  X26, X5, X24, LSL #12
    SUBS  X21, X13, W27, SXTB #3
    ANDS  W8, W19, W26, ROR #10
    ADDS  W29, W23, W25, LSR #8
    ANDS  W25, W21, #0x3ffffc00
    ADDS  W17, W19, W14, LSL #2
    SUBS  W6, W5, #0x327, LSL #12
    SUBS  W8, W7, W21, ASR #10
    ADDS  X28, X29, X14, LSR #13
    FCMP  D30, D10
    SUBS  W15, W5, W15, LSR #16
    ADDS  X28, X13, X18, ASR #37
    SUBS  W17, W17, #0x703, LSL #12
    SUBS  X18, X8, W12, SXTH #3
    ANDS  W12, W7, W2, LSR #31
    ADDS  X8, X12, X19, ASR #7
    SUBS  X15, X28, X20, UXTX #3
    ANDS  W25, W9, W26, ASR #22
    ANDS  X7, X23, #0xffffffffe00007ff
    SUBS  W20, W8, #0x33b
    SUBS  X19, X11, X23, ASR #14
    ADDS  W21, W17, W11, ASR #11
    ADDS  X24, X17, X23, LSL #13
    ADDS  W7, W26, W24, UXTW #3
    ADDS  W7, W11, W23, ASR #7
    SUBS  W26, W13, W14, LSR #24
    SUBS  X13, X2, X9, ASR #45
    FCMP  D26, #0.0
    SUBS  X11, X11, #0x1
    B.NE  TaishanIntCcP01_label_196
    MOVZ  X29, #0x546a, LSL #0
    MOVK  X29, #0x3, LSL #16
    SUB  X26, X29, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X7, #0xaf0a, LSL #0
    MOVK  X7, #0x46, LSL #16
    SUB  X25, X7, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X18, #0xda3a, LSL #0
    MOVK  X18, #0x1cd, LSL #16
    SUB  X20, X18, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X4, #0x6a3a, LSL #0
    MOVK  X4, #0x19b, LSL #16
    SUB  X2, X4, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X8, #0xaf0a, LSL #0
    MOVK  X8, #0x46, LSL #16
    SUB  X11, X8, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X22, #0xaf0a, LSL #0
    MOVK  X22, #0x46, LSL #16
    SUB  X10, X22, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x751e, LSL #0
    MOVK  X23, #0xb81f, LSL #16
    SUB  X15, X23, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X12, X23, X13
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X18, #0x140, LSL #0
    MOVK  X18, #0x2d30, LSL #16
    SUB  X26, X18, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X15
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntCcP01_TestFail
    MOVZ  X24, #0x207a, LSL #0
    MOVK  X24, #0xb497, LSL #16
    SUB  X28, X24, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x140, LSL #0
    MOVK  X13, #0x2d30, LSL #16
    SUB  X17, X13, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x2, LSL #0
    MOVK  X23, #0xfffc, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X24, X23, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntCcP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X16, #0x207a, LSL #0
    MOVK  X16, #0xb497, LSL #16
    SUB  X11, X16, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X28, #0xaf0a, LSL #0
    MOVK  X28, #0x46, LSL #16
    SUB  X17, X28, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X11, #0x2, LSL #0
    MOVK  X11, #0xfffc, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X17, X11, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X24
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X28, X13, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X29, X28, X26
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X21, #0xddcf, LSL #0
    MOVK  X21, #0x100, LSL #16
    SUB  X28, X21, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x0, LSL #0
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
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X5, #0x14, LSL #0
TaishanIntCcP01_label_224:
    SUBS  W6, W10, #0x957, LSL #12
    SUBS  W12, W19, #0x0
    ADDS  W28, W9, W2, LSR #10
    ANDS  W4, W19, #0x55555555
    SUBS  X27, X18, X17, LSL #28
    ADDS  W17, W14, W4, LSR #4
    SUBS  X15, X14, X28, ASR #48
    SUBS  X19, X17, #0x0
    ADDS  X28, X5, #0x7e0
    ANDS  X23, X7, #0x1ffe000
    ANDS  W24, W15, W26, LSR #2
    ANDS  X6, X29, X22, LSL #47
    ADDS  W9, W17, W7, ASR #26
    ANDS  X11, X8, #0x1ffffc00000000
    ADDS  X16, X12, X19, LSL #7
    ADDS  X8, X13, #0x477, LSL #12
    SUBS  W16, W9, #0x0
    SUBS  X15, X29, #0x4c0, LSL #12
    SUBS  X22, X29, W7, SXTW #1
    ANDS  X19, X10, #0xffff83ffffff83ff
    SUBS  W10, W22, #0x0
    ADDS  W23, W15, W6, UXTX #2
    ADDS  W18, W26, W13, UXTW #3
    ANDS  W8, W2, W15, LSR #17
    ADDS  W28, W2, W7, LSR #1
    SUBS  W16, W26, W9, UXTH #2
    SUBS  W22, W11, W26, ASR #29
    ANDS  W8, W28, W23, ROR #14
    ANDS  X2, X6, #0x7ffffffffff000
    SUBS  W12, W2, W11, LSR #11
    ADDS  X18, X20, #0xfe5
    SUBS  W24, W13, W2, SXTW #1
    SUBS  X24, X19, #0x916
    ADDS  W16, W28, W21, LSL #11
    SUBS  W12, W9, W12, UXTW #1
    ADDS  X2, X11, W20, SXTW #1
    SUBS  W22, W5, W11, SXTB #4
    SUBS  W10, W25, #0x3ed
    SUBS  X9, X8, X8, UXTX #2
    SUBS  X17, X18, X29, UXTX #3
    ADDS  X28, X27, #0xbab, LSL #12
    ADDS  X14, X26, #0x872
    ANDS  X18, X6, #0xfff000fffff000ff
    ADDS  W26, W28, #0x2f2
    SUBS  X16, X26, W10, SXTH #2
    SUBS  X25, X22, X17, ASR #27
    SUBS  W10, W2, W20, LSL #26
    FCMP  D22, #0.0
    ANDS  W22, W20, W10, LSR #24
    ADDS  W25, W18, W11, SXTW #0
    ADDS  X13, X2, X11, ASR #62
    SUBS  X14, X5, X25, SXTX #0
    ADDS  W12, W9, W12, LSR #22
    FCMP  S31, #0.0
    ADDS  X28, X13, W17, UXTW #3
    ANDS  X14, X28, #0xfe000000fe000000
    ADDS  W14, W12, #0xf7d, LSL #12
    ANDS  W24, W29, #0xfffff7ff
    ADDS  W16, W12, W17, UXTW #3
    SUBS  X18, X14, X23, SXTX #2
    ANDS  X15, X2, #0x8007ffff8007ffff
    SUBS  W22, W4, #0x0
    SUBS  X6, X20, X15, LSR #41
    ADDS  X29, X12, X17, LSR #33
    ADDS  X20, X15, #0xb82, LSL #12
    SUBS  W15, W28, #0x9b0
    ADDS  W25, W4, W21, LSR #22
    ADDS  W2, W6, W10, SXTX #0
    ANDS  X24, X5, X10, LSR #61
    SUBS  X12, X24, X23, LSR #10
    SUBS  W21, W7, W12, UXTX #2
    SUBS  W22, W7, #0x89a
    SUBS  W6, W19, W27, LSR #6
    ADDS  X4, X13, W25, SXTH #0
    SUBS  W12, W29, W18, ASR #25
    ADDS  W19, W16, W17, LSR #27
    FCMP  S8, S18
    ADDS  W22, W2, W19, UXTH #0
    ADDS  X28, X24, X10, LSR #52
    ADDS  W27, W18, W5, UXTH #4
    ADDS  X24, X13, W10, UXTW #1
    SUBS  W17, W21, W25, SXTB #3
    ANDS  X11, X24, X6, ASR #41
    SUBS  X20, X15, W15, UXTH #4
    ADDS  X17, X11, #0x2c4
    ADDS  X20, X25, X24, SXTX #4
    ADDS  X22, X28, W7, UXTB #0
    ADDS  X17, X24, #0x7d2, LSL #12
    SUBS  W20, W4, W26, SXTH #2
    ADDS  W14, W11, W27, ASR #7
    SUBS  W27, W24, #0xde4, LSL #12
    ANDS  W24, W17, #0x7fff000
    SUBS  W26, W19, W28, LSL #6
    ANDS  W23, W5, W21, LSL #31
    ADDS  X12, X27, W27, UXTW #2
    SUBS  W6, W24, W7, LSR #13
    ANDS  X7, X27, X6, LSL #9
    SUBS  X20, X24, X28, SXTX #2
    ADDS  X18, X19, #0xa0a, LSL #12
    SUBS  W8, W28, W24, UXTH #1
    SUBS  X28, X9, W17, SXTB #2
    ADDS  X13, X6, #0xf28
    ADDS  W9, W5, W13, UXTW #3
    ADDS  X21, X27, W23, SXTB #0
    SUBS  W9, W7, W22, SXTB #2
    ADDS  X17, X20, X28, ASR #50
    ADDS  X18, X26, X10, LSL #6
    ANDS  W4, W27, #0xfffffc3f
    ANDS  X20, X15, #0xffffffffff81ffff
    SUBS  X17, X4, W8, SXTB #0
    ANDS  W27, W18, #0x1ffe00
    SUBS  W18, W24, W10, SXTB #0
    ANDS  X27, X16, X23, LSL #5
    SUBS  X4, X19, X12, ASR #54
    ANDS  W27, W8, W29, LSR #24
    ADDS  X7, X24, X15, LSR #8
    SUBS  W26, W26, W10, UXTW #1
    ADDS  W24, W26, W22, LSL #7
    ADDS  W7, W6, W18, ASR #2
    ANDS  W28, W28, #0xbbbbbbbb
    SUBS  W16, W13, W15, UXTX #2
    SUBS  X21, X5, W8, SXTW #1
    SUBS  X16, X7, X15, ASR #46
    SUBS  X7, X11, #0x0
    ADDS  X9, X27, #0x343, LSL #12
    SUBS  X27, X4, X23, ASR #14
    SUBS  X2, X21, #0xdf6, LSL #12
    ADDS  X17, X20, X7, LSL #37
    FCMP  D11, #0.0
    SUBS  X20, X26, #0xf4c
    ADDS  X25, X14, X7, LSR #54
    ADDS  W26, W19, #0x67b, LSL #12
    SUBS  W16, W2, #0x84e
    ADDS  W21, W7, W7, LSL #25
    FCMP  S28, #0.0
    ADDS  W18, W4, W12, LSR #19
    ADDS  W17, W6, W22, ASR #15
    ADDS  X17, X21, X10, LSR #8
    SUBS  W18, W25, W26, ASR #4
    SUBS  X21, X10, #0xab8
    SUBS  W21, W13, W28, SXTW #2
    ADDS  W7, W27, W13, SXTX #2
    ANDS  X28, X19, X25, LSR #26
    SUBS  W12, W4, #0x4a8
    SUBS  W20, W27, W2, UXTW #1
    SUBS  W20, W7, W9, SXTX #0
    SUBS  W18, W20, #0x350
    SUBS  W18, W19, W24, SXTB #1
    ADDS  X27, X17, X12, UXTX #4
    SUBS  W4, W7, W19, LSL #24
    FCMPE  S20, #0.0
    ANDS  W17, W24, W14, LSR #6
    ADDS  W17, W19, #0x681
    SUBS  W16, W12, W21, UXTW #1
    SUBS  X8, X2, X29, LSL #16
    SUBS  W13, W27, #0x910
    SUBS  W7, W8, W10, ASR #0
    FCMP  D25, #0.0
    SUBS  W8, W7, #0x95b, LSL #12
    SUBS  W11, W23, #0x0
    SUBS  X25, X7, W7, SXTW #3
    ADDS  W17, W10, W25, LSR #22
    FCMP  D21, #0.0
    ANDS  W6, W18, #0x3ffff800
    ANDS  W9, W4, W6, LSR #11
    ADDS  W24, W21, W9, SXTH #1
    FCMP  S22, #0.0
    ADDS  W22, W9, #0x113, LSL #12
    ANDS  W8, W13, W11, LSL #12
    SUBS  X18, X29, X20, LSR #32
    ANDS  W2, W14, W23, LSL #31
    ADDS  W7, W12, W16, LSL #5
    ADDS  W19, W8, W4, ASR #5
    ADDS  W19, W27, W26, SXTB #2
    ANDS  X18, X9, #0x1ffff0001ffff0
    SUBS  X27, X4, #0xb40
    SUBS  X29, X21, #0x742
    SUBS  W29, W4, W25, SXTW #1
    ADDS  W26, W8, W6, ASR #28
    ANDS  W14, W2, #0xaaaaaaaa
    SUBS  X23, X25, X8, UXTX #4
    ADDS  W28, W19, W13, UXTH #1
    FCMP  D16, D15
    FCMP  D5, #0.0
    ADDS  X15, X14, #0xa60
    SUBS  W16, W14, W9, UXTH #1
    ANDS  X10, X27, X21, LSL #42
    ADDS  W10, W14, #0xde0
    ADDS  X26, X17, W9, SXTH #4
    ADDS  W24, W10, W2, SXTB #1
    SUBS  W16, W21, W22, UXTW #4
    SUBS  W26, W20, W12, LSL #3
    ADDS  W26, W13, W26, UXTW #4
    SUBS  W19, W14, W23, LSR #26
    ADDS  W24, W18, W5, SXTX #1
    SUBS  W25, W14, W7, ASR #28
    ADDS  X25, X29, #0x110
    ANDS  X20, X27, #0xfffffe00
    ADDS  W24, W8, W10, SXTH #3
    SUBS  W23, W4, W22, LSL #3
    SUBS  X5, X5, #0x1
    B.NE  TaishanIntCcP01_label_224
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X28, #0xd5f7, LSL #0
    MOVK  X28, #0xfa2c, LSL #16
    SUB  X5, X28, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X29, #0xa000, LSL #0
    MOVK  X29, #0x3e81, LSL #16
    SUB  X14, X29, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X6, #0x4383, LSL #0
    MOVK  X6, #0x879c, LSL #16
    SUB  X5, X6, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntCcP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X8, X9, X8
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X24, X7, X9
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntCcP01_TestFail
    MOVZ  X2, #0xde0, LSL #0
    SUB  X9, X2, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntCcP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntCcP01_TestFail
    MOVZ  X4, #0x9ae3, LSL #0
    MOVK  X4, #0x7e81, LSL #16
    SUB  X16, X4, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X8, #0xa54, LSL #0
    MOVK  X8, #0xe90a, LSL #16
    SUB  X22, X8, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X26, #0xa60, LSL #0
    SUB  X5, X26, X15
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntCcP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X15, #0x3650, LSL #0
    MOVK  X15, #0xf065, LSL #16
    SUB  X19, X15, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X6, #0xd030, LSL #0
    MOVK  X6, #0x4, LSL #16
    SUB  X29, X6, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntCcP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X11, X19, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X7, #0x62cf, LSL #0
    MOVK  X7, #0x331c, LSL #16
    SUB  X22, X7, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X19, X28, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntCcP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X25, #0xa60, LSL #0
    SUB  X22, X25, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x9b3d, LSL #0
    MOVK  X2, #0x44e9, LSL #16
    MOVK  X2, #0xd936, LSL #32
    MOVK  X2, #0x38ca, LSL #48
    MOVZ  X4, #0x1253, LSL #0
    MOVK  X4, #0x30d7, LSL #16
    MOVK  X4, #0x8d2f, LSL #32
    MOVK  X4, #0xa7ad, LSL #48
    MOVZ  X5, #0xf44a, LSL #0
    MOVK  X5, #0x42ee, LSL #16
    MOVK  X5, #0x57a5, LSL #32
    MOVK  X5, #0xb9d3, LSL #48
    MOVZ  X6, #0x5537, LSL #0
    MOVK  X6, #0xd7db, LSL #16
    MOVK  X6, #0x9e0f, LSL #32
    MOVK  X6, #0x6326, LSL #48
    MOVZ  X7, #0xe300, LSL #0
    MOVK  X7, #0xde2, LSL #16
    MOVK  X7, #0xfe0f, LSL #32
    MOVK  X7, #0x5b35, LSL #48
    MOVZ  X8, #0x2c68, LSL #0
    MOVK  X8, #0xb207, LSL #16
    MOVK  X8, #0x7963, LSL #32
    MOVK  X8, #0x999f, LSL #48
    MOVZ  X9, #0xe5be, LSL #0
    MOVK  X9, #0x200f, LSL #16
    MOVK  X9, #0x6038, LSL #32
    MOVK  X9, #0xad69, LSL #48
    MOVZ  X10, #0xc1d, LSL #0
    MOVK  X10, #0x18b, LSL #16
    MOVK  X10, #0xde1c, LSL #32
    MOVK  X10, #0x9708, LSL #48
    MOVZ  X11, #0xfab5, LSL #0
    MOVK  X11, #0xe1bb, LSL #16
    MOVK  X11, #0xab3d, LSL #32
    MOVK  X11, #0xe6af, LSL #48
    MOVZ  X12, #0xa32b, LSL #0
    MOVK  X12, #0xfdbf, LSL #16
    MOVK  X12, #0x655e, LSL #32
    MOVK  X12, #0x3328, LSL #48
    MOVZ  X13, #0xd2a7, LSL #0
    MOVK  X13, #0x4314, LSL #16
    MOVK  X13, #0xf2a4, LSL #32
    MOVK  X13, #0x556f, LSL #48
    MOVZ  X14, #0x9edb, LSL #0
    MOVK  X14, #0x1007, LSL #16
    MOVK  X14, #0xae68, LSL #32
    MOVK  X14, #0x4360, LSL #48
    MOVZ  X15, #0xcc29, LSL #0
    MOVK  X15, #0x4dd5, LSL #16
    MOVK  X15, #0xab87, LSL #32
    MOVK  X15, #0xef1d, LSL #48
    MOVZ  X16, #0x2603, LSL #0
    MOVK  X16, #0x7db, LSL #16
    MOVK  X16, #0x214c, LSL #32
    MOVK  X16, #0xd2c0, LSL #48
    MOVZ  X17, #0x8ebe, LSL #0
    MOVK  X17, #0x26a0, LSL #16
    MOVK  X17, #0x590, LSL #32
    MOVK  X17, #0xfa28, LSL #48
    MOVZ  X18, #0x5134, LSL #0
    MOVK  X18, #0xd802, LSL #16
    MOVK  X18, #0x8101, LSL #32
    MOVK  X18, #0xc16c, LSL #48
    MOVZ  X19, #0x32c6, LSL #0
    MOVK  X19, #0x97a6, LSL #16
    MOVK  X19, #0x50b6, LSL #32
    MOVK  X19, #0x7251, LSL #48
    MOVZ  X20, #0x9d1d, LSL #0
    MOVK  X20, #0x5626, LSL #16
    MOVK  X20, #0xbafb, LSL #32
    MOVK  X20, #0xfde6, LSL #48
    MOVZ  X21, #0x5394, LSL #0
    MOVK  X21, #0xf206, LSL #16
    MOVK  X21, #0x9828, LSL #32
    MOVK  X21, #0x78, LSL #48
    MOVZ  X22, #0x181b, LSL #0
    MOVK  X22, #0x4703, LSL #16
    MOVK  X22, #0xdd31, LSL #32
    MOVK  X22, #0x2a2a, LSL #48
    MOVZ  X23, #0x5f7f, LSL #0
    MOVK  X23, #0xb72, LSL #16
    MOVK  X23, #0x57d1, LSL #32
    MOVK  X23, #0xa56f, LSL #48
    MOVZ  X24, #0x7c5a, LSL #0
    MOVK  X24, #0xea03, LSL #16
    MOVK  X24, #0xd0b3, LSL #32
    MOVK  X24, #0x6b8a, LSL #48
    MOVZ  X25, #0xdc1a, LSL #0
    MOVK  X25, #0xbcb7, LSL #16
    MOVK  X25, #0xd311, LSL #32
    MOVK  X25, #0x1e76, LSL #48
    MOVZ  X26, #0x820a, LSL #0
    MOVK  X26, #0x3349, LSL #16
    MOVK  X26, #0xa11, LSL #32
    MOVK  X26, #0xd712, LSL #48
    MOVZ  X27, #0x1eed, LSL #0
    MOVK  X27, #0x604, LSL #16
    MOVK  X27, #0x9049, LSL #32
    MOVK  X27, #0x297a, LSL #48
    MOVZ  X28, #0x29e7, LSL #0
    MOVK  X28, #0x8e03, LSL #16
    MOVK  X28, #0x52c, LSL #32
    MOVK  X28, #0xd593, LSL #48
    MOVZ  X29, #0xd346, LSL #0
    MOVK  X29, #0x6776, LSL #16
    MOVK  X29, #0x3afe, LSL #32
    MOVK  X29, #0x974d, LSL #48
    MOVZ  X22, #0x14, LSL #0
TaishanIntCcP01_label_252:
    SUBS  X2, X28, X27, LSL #30
    ADDS  W26, W25, W24, UXTX #0
    SUBS  X14, X16, W2, UXTW #3
    SUBS  X17, X29, X25, ASR #7
    ADDS  W13, W19, #0x7d4, LSL #12
    ANDS  W17, W13, W13, ROR #13
    ANDS  W14, W5, W18, ROR #12
    ADDS  W12, W20, W16, LSL #11
    SUBS  X17, X12, X13, LSL #39
    ADDS  W7, W25, W26, LSR #17
    ANDS  W25, W18, W14, ROR #9
    ANDS  W5, W22, W5, LSL #22
    SUBS  X28, X17, #0x180
    ANDS  X28, X9, X24, ASR #55
    ANDS  X18, X27, X8, ROR #21
    ADDS  X7, X19, #0xc3f, LSL #12
    FCMPE  D11, #0.0
    ANDS  X12, X25, #0x7fffffff000
    SUBS  W2, W4, W26, UXTX #1
    ADDS  X2, X14, X14, LSR #12
    SUBS  W11, W29, W20, UXTB #2
    ADDS  X26, X26, X23, SXTX #3
    ADDS  X14, X7, X8, LSL #49
    ADDS  W18, W4, #0x89c, LSL #12
    ADDS  X26, X8, X13, LSL #17
    FCMPE  D3, D21
    ADDS  W25, W10, #0xc40
    FCMP  S30, S22
    FCMPE  S10, #0.0
    SUBS  W28, W22, #0xff6, LSL #12
    SUBS  X18, X16, X25, UXTX #4
    ADDS  W25, W10, #0x8d6, LSL #12
    ADDS  X15, X25, #0x73a
    ANDS  X14, X7, #0x800001ffffffffff
    SUBS  X27, X20, W2, UXTW #0
    ADDS  W8, W11, #0xe50, LSL #12
    SUBS  X7, X28, W4, SXTW #0
    ADDS  W6, W27, #0x52
    ANDS  W24, W11, W27, LSR #21
    SUBS  W19, W8, W16, LSR #4
    ANDS  W11, W26, W11, ASR #26
    ADDS  X5, X2, X14, SXTX #2
    SUBS  X18, X16, X18, LSL #12
    ANDS  X25, X27, #0x7f8000007f8
    ANDS  W13, W10, #0xdddddddd
    ADDS  W14, W22, W20, ASR #15
    ADDS  W16, W28, #0x836, LSL #12
    FCMP  D27, D12
    ADDS  X28, X28, #0xa7f
    ADDS  W4, W6, W8, UXTB #2
    ADDS  X29, X17, X8, LSL #31
    ADDS  W4, W13, W19, UXTX #1
    ADDS  W24, W13, W28, LSL #1
    ANDS  X6, X24, X6, LSR #20
    ADDS  X13, X17, X7, LSL #58
    SUBS  X10, X19, X29, ASR #46
    ANDS  W6, W24, W22, LSL #12
    ANDS  W29, W28, W16, LSR #24
    SUBS  X25, X8, #0x262
    ADDS  X28, X27, X19, LSR #49
    ADDS  W2, W7, W26, ASR #25
    ANDS  W21, W20, W17, LSR #18
    ANDS  W27, W27, W13, LSL #26
    SUBS  W18, W28, W11, SXTB #0
    ADDS  X16, X18, W15, SXTH #0
    ADDS  W5, W14, W24, SXTX #2
    ADDS  X20, X4, X16, UXTX #4
    FCMP  D31, #0.0
    SUBS  X28, X29, #0x5e3, LSL #12
    ANDS  X13, X10, X2, ROR #63
    SUBS  X27, X20, #0x950
    ADDS  X9, X10, W21, UXTH #2
    SUBS  W24, W5, #0xe9e
    ANDS  W10, W28, #0x3ff0
    ANDS  X25, X28, X5, ASR #41
    ADDS  X16, X18, X20, LSL #14
    SUBS  W26, W24, W17, ASR #28
    ANDS  W13, W2, #0xe01fe01f
    ADDS  W13, W21, W7, LSR #27
    ADDS  W13, W7, #0xd5f, LSL #12
    SUBS  X25, X11, X29, SXTX #2
    SUBS  X29, X13, X25, LSL #25
    ADDS  W9, W17, W29, SXTH #2
    SUBS  W16, W14, W29, UXTB #0
    ADDS  W26, W29, W19, ASR #26
    SUBS  W17, W10, W21, SXTX #1
    ADDS  X27, X7, #0xec2
    ADDS  W20, W11, #0x256
    ADDS  W24, W18, W25, ASR #20
    FCMPE  D16, #0.0
    SUBS  X20, X27, W23, UXTH #2
    SUBS  W23, W20, W15, ASR #28
    ANDS  X13, X25, X23, LSR #30
    ANDS  X17, X13, X25, ROR #11
    SUBS  X2, X6, #0x174, LSL #12
    ADDS  X18, X9, W23, SXTW #1
    SUBS  X13, X6, W17, UXTB #2
    ADDS  W28, W13, #0xdf0
    ANDS  W29, W26, #0x200020
    SUBS  W10, W6, W14, LSL #6
    SUBS  W17, W6, W27, LSL #10
    ADDS  X7, X19, X20, ASR #18
    SUBS  X9, X14, W10, SXTW #4
    ANDS  W11, W29, #0x10101010
    SUBS  X16, X10, #0xc5b, LSL #12
    ANDS  W12, W5, W24, ROR #6
    ANDS  X27, X26, X27, ROR #10
    ANDS  X18, X26, X16, LSL #40
    SUBS  X10, X13, X29, UXTX #2
    SUBS  W25, W24, #0xce0
    SUBS  X4, X25, W11, UXTH #0
    ADDS  X23, X5, W7, UXTB #1
    SUBS  W24, W16, W2, LSL #23
    ANDS  X27, X23, #0xf007f007f007f007
    SUBS  W12, W18, W9, ASR #20
    ADDS  W19, W6, #0xa52
    SUBS  X28, X4, W23, SXTW #1
    ADDS  W10, W2, W28, LSR #20
    SUBS  W4, W24, W9, LSR #13
    ANDS  X20, X27, X11, LSR #42
    ADDS  W14, W27, W17, UXTW #3
    ADDS  W28, W12, W11, SXTB #3
    ANDS  W20, W2, #0x3f0000
    SUBS  W8, W27, W26, ASR #28
    ANDS  W19, W14, #0x3c0000
    SUBS  W16, W8, W20, LSL #30
    SUBS  W8, W4, W5, LSR #20
    SUBS  W4, W4, W10, ASR #5
    SUBS  W26, W26, W8, SXTB #3
    SUBS  X20, X10, #0x4fd, LSL #12
    ADDS  X28, X2, W13, UXTH #3
    FCMP  S13, #0.0
    SUBS  W29, W6, W16, LSL #3
    ANDS  W6, W19, W8, ASR #26
    SUBS  X24, X8, W5, SXTW #3
    ANDS  X4, X4, X12, ASR #32
    SUBS  W6, W26, W29, LSL #2
    SUBS  X27, X18, #0x818
    SUBS  X26, X2, #0xa5
    SUBS  X21, X15, X18, LSL #48
    ANDS  W28, W9, W21, ASR #27
    ANDS  X16, X20, X20, ROR #19
    ANDS  W2, W24, W23, ROR #31
    ADDS  W28, W25, W6, LSL #31
    SUBS  X15, X28, #0x57b
    SUBS  W4, W18, W10, UXTW #4
    SUBS  X4, X29, W13, UXTH #0
    SUBS  X16, X4, X11, UXTX #0
    ANDS  W11, W22, W2, LSR #22
    ANDS  X16, X16, #0x7fffffffffc00
    ANDS  W4, W28, #0x7c007c
    SUBS  W4, W19, #0x3bb, LSL #12
    ANDS  X29, X24, X13, ROR #43
    ANDS  W21, W15, #0xc0c0c0c
    ADDS  X4, X9, W10, SXTH #0
    ANDS  W29, W9, #0xfbfbfbfb
    SUBS  W16, W11, W24, SXTH #4
    ANDS  W8, W11, #0x1ffff800
    SUBS  X10, X28, X19, ASR #57
    ADDS  W6, W21, #0x140
    SUBS  W29, W22, #0x893
    SUBS  W13, W8, W16, SXTB #4
    SUBS  W4, W17, #0x2a2
    ANDS  W18, W26, #0xffffffe1
    ADDS  W8, W29, #0x44c, LSL #12
    SUBS  X15, X9, X17, ASR #46
    ADDS  W18, W4, #0xd59, LSL #12
    ANDS  W27, W16, W18, ASR #6
    ANDS  X25, X25, #0x7ffffffffc0000
    ANDS  X16, X12, #0xffe07fffffe07fff
    ANDS  X20, X24, X9, ASR #34
    ADDS  X9, X28, W28, SXTB #2
    ADDS  X29, X28, X4, SXTX #0
    SUBS  X10, X17, #0x850
    ANDS  X8, X14, X15, ROR #33
    SUBS  W6, W12, W25, LSR #18
    ADDS  W18, W27, W15, SXTX #4
    ANDS  X16, X4, X27, ASR #17
    ADDS  X28, X29, W6, SXTH #4
    ADDS  W23, W19, W18, SXTH #0
    ANDS  W16, W9, W27, LSL #3
    FCMPE  D25, D9
    ANDS  W25, W13, #0x11111111
    SUBS  X11, X26, X17, LSR #51
    ANDS  W6, W6, #0xfefefefe
    ANDS  X4, X21, X9, ROR #19
    SUBS  X17, X18, X26, LSL #53
    FCMPE  D24, D20
    ADDS  X18, X6, #0x970
    SUBS  W10, W12, #0xa1, LSL #12
    FCMPE  D23, D3
    ANDS  X29, X24, #0xfffe000000007fff
    ADDS  W6, W19, #0xec1, LSL #12
    ADDS  X19, X26, X10, ASR #38
    ADDS  W20, W17, #0xf9b, LSL #12
    SUBS  X16, X4, X8, SXTX #2
    SUBS  W13, W27, W4, UXTB #4
    ANDS  X9, X5, X8, ROR #16
    SUBS  X23, X28, W4, UXTB #3
    SUBS  X26, X4, X28, LSL #2
    SUBS  X22, X22, #0x1
    B.NE  TaishanIntCcP01_label_252
    MOVZ  X24, #0x2268, LSL #0
    MOVK  X24, #0x8410, LSL #16
    SUB  X23, X24, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x4, LSL #0
    SUB  X5, X8, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntCcP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X21, #0x1000, LSL #0
    MOVK  X21, #0x118, LSL #16
    SUB  X5, X21, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntCcP01_TestFail
    MOVZ  X14, #0x81d7, LSL #0
    MOVK  X14, #0xe5, LSL #16
    SUB  X27, X14, X7
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntCcP01_TestFail
    MOVZ  X11, #0x4, LSL #0
    SUB  X5, X11, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X9
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntCcP01_TestFail
    MOVZ  X16, #0x4, LSL #0
    SUB  X17, X16, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X10, #0x3fc0, LSL #0
    SUB  X5, X10, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntCcP01_TestFail
    MOVZ  X14, #0x81d7, LSL #0
    MOVK  X14, #0xe5, LSL #16
    SUB  X12, X14, X14
TaishanIntCcP01_label_99:
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X25, #0x1b86, LSL #0
    MOVK  X25, #0xe, LSL #16
    SUB  X7, X25, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntCcP01_TestFail
    MOVZ  X24, #0x4, LSL #0
    SUB  X6, X24, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X22, #0xa860, LSL #0
    MOVK  X22, #0x1db, LSL #16
    SUB  X24, X22, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntCcP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X8, #0xa860, LSL #0
    MOVK  X8, #0x1db, LSL #16
    SUB  X20, X8, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X9, #0x1b86, LSL #0
    MOVK  X9, #0xe, LSL #16
    SUB  X16, X9, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x7a10, LSL #0
    MOVK  X13, #0x42e, LSL #16
    MOVK  X13, #0xfffb, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X10, X13, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntCcP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntCcP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
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
    MOVZ  X24, #0x14, LSL #0
TaishanIntCcP01_label_280:
    ADDS  X7, X24, X27, ASR #11
    ANDS  W12, W9, #0xc0c0c0c0
    ANDS  X26, X23, X6, LSR #53
    SUBS  X7, X11, X29, LSL #14
    ANDS  X13, X6, #0x400040004000400
    ANDS  X13, X18, X10, LSR #22
    ADDS  W26, W13, #0xc79, LSL #12
    SUBS  W28, W17, #0xd65, LSL #12
    ANDS  X19, X12, X12, LSL #44
    ADDS  X10, X24, X13, LSL #42
    ADDS  W8, W6, W24, UXTH #4
    ADDS  W28, W8, #0x803
    ADDS  W6, W22, W7, LSL #9
    ADDS  W6, W24, W22, UXTB #2
    ANDS  X7, X14, X23, ASR #27
    ADDS  W22, W5, W25, LSR #23
    ADDS  X16, X23, #0x7a3, LSL #12
    ADDS  W6, W2, #0xea
    SUBS  W17, W2, #0x3ad, LSL #12
    SUBS  X25, X11, #0x3d2, LSL #12
    SUBS  W25, W10, W28, LSR #14
    ADDS  X6, X11, W24, SXTW #0
    ANDS  W21, W19, W2, ASR #26
    ADDS  X21, X13, W10, SXTB #3
    ADDS  X8, X15, X26, ASR #26
    ANDS  X27, X12, X27, ROR #55
    ADDS  W14, W6, W20, SXTX #4
    FCMP  S7, S0
    ADDS  X6, X24, X20, UXTX #0
    ADDS  X23, X20, W2, UXTH #4
    ADDS  W13, W15, W6, LSL #12
    SUBS  X16, X23, X5, LSR #43
    ADDS  W15, W29, W27, UXTX #3
    ADDS  X8, X2, W18, UXTW #2
    ADDS  W15, W10, #0xb9
    ADDS  W2, W26, W2, LSR #7
    ADDS  W2, W15, W15, UXTW #4
    ADDS  X19, X28, X23, LSR #23
    ANDS  W11, W23, #0x1800180
    SUBS  W13, W26, W27, LSR #20
    ANDS  X12, X26, #0xfffffe00003fffff
    SUBS  X23, X6, X13, UXTX #1
    SUBS  W15, W18, W18, SXTH #4
    ANDS  W26, W12, #0x88888888
    ADDS  X8, X15, #0x937, LSL #12
    SUBS  W26, W8, W28, UXTX #2
    ADDS  W17, W28, W13, LSR #16
    SUBS  X5, X15, X26, LSL #24
    ADDS  X16, X16, W6, UXTH #3
    ANDS  W11, W9, W2, LSL #6
    ANDS  X17, X15, X2, LSR #59
    ADDS  W5, W25, W23, SXTX #0
    ANDS  X17, X19, X2, ROR #24
    ANDS  W5, W14, #0x4000400
    SUBS  W2, W19, #0x360
    ADDS  X17, X29, X6, UXTX #1
    ADDS  X13, X9, #0x78f, LSL #12
    ADDS  X16, X20, #0x790, LSL #12
    SUBS  X28, X2, #0xc6
    SUBS  W28, W7, W10, SXTB #0
    ADDS  W28, W2, W5, SXTB #1
    SUBS  X11, X7, W16, UXTH #0
    ADDS  W14, W27, W9, SXTH #1
    SUBS  W28, W22, W18, SXTX #4
    ADDS  W18, W26, W21, LSR #9
    ADDS  W16, W7, W7, ASR #5
    SUBS  W20, W16, #0x20
    SUBS  X5, X18, X20, ASR #0
    ADDS  W23, W28, W8, SXTB #1
    SUBS  X9, X21, #0x253
    ANDS  W18, W28, W27, ROR #29
    SUBS  W18, W6, W23, SXTB #2
    SUBS  X7, X4, X11, UXTX #1
    ADDS  X16, X22, W22, SXTW #3
    ANDS  X21, X18, X26, ROR #9
    ANDS  W23, W9, W14, LSR #11
    ANDS  W13, W11, W15, LSL #30
    ADDS  W2, W2, #0x5db, LSL #12
    SUBS  W17, W10, #0x27d, LSL #12
    ANDS  W6, W6, #0xf3fff3ff
    SUBS  X15, X24, X23, UXTX #0
    SUBS  W13, W5, W21, LSR #10
    FCMPE  D11, D6
    FCMP  S22, S28
    ANDS  X19, X2, #0x3ffffffffffff80
    ADDS  X29, X22, #0xb10
    SUBS  X4, X29, W23, SXTB #0
    SUBS  W7, W10, #0x4ca, LSL #12
    SUBS  X7, X25, #0x0
    ADDS  W19, W28, W25, ASR #24
    SUBS  W10, W29, W8, LSL #14
    ADDS  W23, W10, #0x1f6, LSL #12
    ADDS  X20, X28, #0xa3e, LSL #12
    ANDS  X27, X19, X7, LSR #51
    ANDS  W2, W6, W24, LSR #7
    ANDS  W25, W20, W26, LSR #13
    SUBS  W27, W28, W19, ASR #0
    ADDS  X22, X18, X21, LSL #8
    SUBS  W14, W10, W15, UXTX #2
    SUBS  W9, W13, #0xddb, LSL #12
    SUBS  X2, X28, W7, SXTW #3
    ADDS  X25, X26, X22, UXTX #2
    ADDS  W10, W11, W24, UXTX #3
    SUBS  W4, W22, W10, SXTB #1
    ANDS  X9, X27, X28, LSR #33
    ADDS  X14, X2, #0x1de
    SUBS  X9, X25, X9, UXTX #2
    ANDS  X2, X21, X9, ASR #38
    SUBS  X26, X10, #0x461
    ADDS  W18, W19, W21, SXTW #4
    SUBS  X20, X18, #0xb78, LSL #12
    SUBS  X6, X10, X10, LSR #26
    SUBS  W29, W14, W17, LSR #3
    SUBS  X11, X14, W26, UXTB #2
    ADDS  X23, X23, W9, SXTB #0
    ANDS  W4, W25, #0xf1f1f1f1
    SUBS  W13, W2, W15, ASR #5
    SUBS  X10, X12, X22, LSR #18
    ADDS  X9, X14, X25, UXTX #1
    ADDS  W15, W18, W13, UXTH #0
    ADDS  X6, X22, W8, UXTH #0
    ADDS  X12, X17, #0x5cf, LSL #12
    SUBS  X16, X18, W18, UXTH #4
    ANDS  X9, X9, X6, ASR #60
    ANDS  W6, W19, #0xfffffffe
    SUBS  W10, W20, W9, SXTW #2
    ANDS  W21, W16, W25, ROR #12
    ANDS  X10, X21, X12, LSL #54
    ANDS  W23, W22, W26, ROR #4
    SUBS  W15, W25, #0x714
    ANDS  X16, X4, X6, LSL #46
    SUBS  X17, X23, W24, UXTB #1
    ADDS  W11, W16, #0xaad
    FCMP  S31, S2
    SUBS  X12, X15, #0x2e8
    SUBS  W22, W15, W26, UXTW #0
    ANDS  W12, W11, W20, LSL #29
    FCMPE  D1, #0.0
    ANDS  X16, X22, X18, ROR #23
    ADDS  W17, W2, W14, UXTX #1
    ADDS  X10, X24, #0xe95
    SUBS  X14, X16, W7, UXTW #1
    SUBS  W15, W26, #0xabd, LSL #12
    ANDS  X23, X28, #0x400000004000000
    ANDS  X27, X2, #0xff00000000000007
    ADDS  W10, W20, #0xbd5, LSL #12
    ANDS  W6, W16, W15, ROR #23
    SUBS  X18, X24, X28, UXTX #4
    SUBS  X18, X8, #0xb9a, LSL #12
    ADDS  X23, X25, X16, SXTX #4
    ADDS  W17, W5, #0x954
    ADDS  X12, X19, #0xcc0
    SUBS  X21, X12, #0x98c, LSL #12
    ANDS  X6, X21, #0xfffe000000000003
    SUBS  X12, X24, X25, LSL #62
    SUBS  X7, X17, W28, UXTB #0
    ANDS  X15, X14, X4, ROR #23
    ADDS  W25, W11, #0xf46, LSL #12
    ADDS  X2, X24, #0x440
    ADDS  W20, W24, #0x9a1
    ANDS  X8, X5, X27, ASR #31
    ADDS  W28, W10, W20, LSL #18
    SUBS  X21, X22, #0x690
    ANDS  X5, X7, #0xcccccccccccccccc
    SUBS  W26, W6, #0x0
    SUBS  W19, W14, W26, SXTB #1
    ADDS  W9, W24, #0x6b8
    SUBS  W14, W21, #0x8f0
    FCMPE  S22, S22
    SUBS  W12, W11, W28, UXTB #0
    ANDS  W4, W18, #0x30
    ANDS  X20, X28, #0xffffff7fffffff7f
    ADDS  X27, X20, W2, SXTB #3
    ADDS  X9, X17, #0xaee, LSL #12
    SUBS  X22, X7, X17, LSR #13
    SUBS  X4, X5, X16, LSL #45
    FCMP  S9, S27
    ADDS  W28, W26, #0x200, LSL #12
    ADDS  W14, W9, #0x678, LSL #12
    SUBS  W2, W7, W17, LSL #15
    ADDS  X12, X27, X28, LSR #0
    ADDS  W12, W21, #0xf32
    SUBS  W12, W21, W26, SXTX #1
    SUBS  W8, W12, W14, ASR #24
    SUBS  X19, X9, W27, UXTH #4
    ANDS  W11, W12, #0xf0f0f0f
    SUBS  X15, X23, W26, UXTB #3
    SUBS  W5, W25, W23, UXTW #1
    ADDS  X22, X21, X19, LSL #5
    ANDS  X25, X25, X17, ASR #58
    ADDS  W18, W22, W23, ASR #16
    ADDS  X21, X14, X7, LSR #14
    ADDS  X26, X14, #0x226, LSL #12
    ANDS  W29, W26, #0xffffe007
    ANDS  W13, W22, #0xfc00fc
    FCMP  S1, #0.0
    SUBS  X11, X15, #0xd31
    ADDS  W19, W13, #0x198, LSL #12
    ADDS  W26, W6, W8, SXTW #2
    SUBS  W2, W22, #0x72a
    SUBS  X24, X24, #0x1
    B.NE  TaishanIntCcP01_label_280
    MOVZ  X8, #0x7634, LSL #0
    MOVK  X8, #0xcdfe, LSL #16
    SUB  X21, X8, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X13, #0xc88, LSL #0
    MOVK  X13, #0xc804, LSL #16
    MOVK  X13, #0xc000, LSL #32
    MOVK  X13, #0xffee, LSL #48
    SUB  X15, X13, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X20, #0xf51, LSL #0
    MOVK  X20, #0x9863, LSL #16
    SUB  X28, X20, X5
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X24, #0x1, LSL #0
    SUB  X12, X24, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X5, #0xdaa, LSL #0
    MOVK  X5, #0xe826, LSL #16
    SUB  X18, X5, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntCcP01_TestFail
    MOVZ  X5, #0x7634, LSL #0
    MOVK  X5, #0xcdfe, LSL #16
    SUB  X22, X5, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X27, #0xede3, LSL #0
    MOVK  X27, #0xe8d4, LSL #16
    SUB  X29, X27, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X21, #0x7239, LSL #0
    MOVK  X21, #0x5d4a, LSL #16
    SUB  X27, X21, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntCcP01_TestFail
    MOVZ  X13, #0xa075, LSL #0
    MOVK  X13, #0xb448, LSL #16
    MOVK  X13, #0x4, LSL #32
    SUB  X24, X13, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X12
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X21, #0xa075, LSL #0
    MOVK  X21, #0xb448, LSL #16
    MOVK  X21, #0x4, LSL #32
    SUB  X23, X21, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X24, #0x6de3, LSL #0
    MOVK  X24, #0xe93c, LSL #16
    SUB  X22, X24, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X10, #0xde3, LSL #0
    MOVK  X10, #0xe826, LSL #16
    SUB  X16, X10, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X15, X6, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X4, #0x805c, LSL #0
    MOVK  X4, #0x115, LSL #16
    SUB  X6, X4, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X11, #0xf51, LSL #0
    MOVK  X11, #0x9863, LSL #16
    SUB  X13, X11, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntCcP01_TestFail
    MOVZ  X16, #0xa075, LSL #0
    MOVK  X16, #0xb448, LSL #16
    MOVK  X16, #0x4, LSL #32
    SUB  X11, X16, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X28, X8, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X29, #0x6de3, LSL #0
    MOVK  X29, #0xe93c, LSL #16
    SUB  X16, X29, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X7, #0xc4d, LSL #0
    MOVK  X7, #0xd125, LSL #16
    SUB  X28, X7, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntCcP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x6de3, LSL #0
    MOVK  X28, #0xe93c, LSL #16
    SUB  X20, X28, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x0, LSL #0
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
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X22, #0x14, LSL #0
TaishanIntCcP01_label_308:
    ADDS  X23, X23, X5, LSR #28
    ADDS  W4, W28, W26, UXTW #2
    SUBS  W27, W28, W27, ASR #7
    FCMPE  S19, #0.0
    ANDS  W5, W9, W23, ROR #11
    ADDS  X13, X9, X10, LSL #22
    ANDS  X29, X22, #0xfffe00fffffe00ff
    SUBS  X19, X6, X10, LSL #61
    SUBS  W28, W16, W26, UXTX #2
    SUBS  W16, W4, W18, SXTW #3
    ANDS  W14, W25, W27, ASR #9
    SUBS  W13, W18, #0x979, LSL #12
    ADDS  W15, W23, #0x90b
    SUBS  X4, X20, X21, LSL #16
    ADDS  X23, X16, X14, LSR #56
    SUBS  X4, X14, #0xca4, LSL #12
    FCMPE  S4, S0
    SUBS  W2, W23, W13, SXTX #1
    ADDS  X4, X15, X2, LSR #18
    ADDS  X18, X17, W4, SXTH #3
    ADDS  W18, W11, W24, SXTH #4
    ADDS  W15, W27, W15, SXTB #1
    SUBS  X15, X15, X5, LSR #35
    ADDS  W5, W2, W10, LSR #11
    ANDS  W4, W7, W5, ROR #10
    ANDS  X20, X29, #0x3fffff00000
    ADDS  X6, X11, X18, LSL #54
    FCMP  S22, #0.0
    SUBS  X19, X14, X27, ASR #62
    ADDS  W15, W15, #0xaa8
    ADDS  W4, W24, #0x50
    ADDS  W29, W4, W2, SXTX #3
    SUBS  W23, W23, W20, ASR #7
    ADDS  X11, X24, X5, LSL #60
    ADDS  X21, X2, X15, SXTX #1
    ANDS  X29, X22, X22, LSL #34
    ANDS  W6, W19, #0x33333333
    ADDS  X9, X10, W6, SXTW #1
    ADDS  W11, W27, #0x5f0, LSL #12
    SUBS  X18, X23, #0x5ab
    ANDS  W14, W7, W15, ROR #4
    SUBS  X17, X17, W15, SXTW #3
    FCMPE  D9, #0.0
    SUBS  X12, X15, X5, ASR #48
    ADDS  W17, W21, #0x535, LSL #12
    ADDS  X12, X26, #0x8c2
    FCMP  S21, #0.0
    ANDS  X4, X12, X4, ASR #16
    ADDS  W20, W7, W20, UXTX #1
    FCMPE  S25, #0.0
    ADDS  X23, X14, X26, ASR #36
    ADDS  W21, W14, #0x15f, LSL #12
    SUBS  X7, X7, W12, SXTB #2
    SUBS  W10, W21, W27, SXTW #2
    SUBS  X26, X14, X23, SXTX #4
    SUBS  W21, W26, W17, LSR #6
    ADDS  W6, W29, #0xb90
    FCMP  S24, #0.0
    ADDS  X12, X14, #0xb62, LSL #12
    SUBS  X11, X18, #0xe71
    ADDS  W24, W7, #0x563
    ANDS  X13, X22, X28, ROR #23
    SUBS  W24, W28, #0x2ba, LSL #12
    SUBS  W2, W9, #0xfd1, LSL #12
    SUBS  X27, X8, X6, ASR #34
    ADDS  W27, W23, #0x880
    SUBS  X4, X27, X5, ASR #33
    ADDS  X14, X5, #0xa1d
    SUBS  W9, W28, #0x884
    ANDS  W14, W24, #0x1e001e0
    SUBS  X8, X24, #0xd94
    ADDS  X24, X7, #0x8e1, LSL #12
    ADDS  X16, X20, #0xa27, LSL #12
    SUBS  W15, W11, W2, LSL #25
    SUBS  X23, X2, #0x530
    ANDS  W2, W6, #0xff800007
    ADDS  W14, W4, W5, UXTX #2
    ANDS  X14, X27, #0x3c00000000000
    ANDS  W18, W13, #0xffff07ff
    ADDS  X9, X9, X28, UXTX #0
    SUBS  W13, W8, W2, SXTH #2
    SUBS  X23, X14, W13, UXTH #0
    SUBS  X2, X16, W14, SXTH #2
    SUBS  X23, X5, #0x266, LSL #12
    ADDS  X8, X18, W24, UXTW #2
    ANDS  W5, W28, #0x80000
    ADDS  X2, X19, X18, LSL #21
    ADDS  X12, X24, #0x748, LSL #12
    SUBS  W27, W16, W2, LSR #25
    SUBS  X21, X5, X12, ASR #28
    ANDS  X12, X5, #0xc000001fc000001f
    SUBS  W24, W19, W13, SXTX #2
    SUBS  W26, W15, W8, ASR #15
    ADDS  X8, X11, X25, SXTX #4
    SUBS  X27, X21, X12, LSR #15
    SUBS  W2, W22, #0x10
    SUBS  X15, X23, X15, LSR #6
    SUBS  W23, W2, W16, LSL #29
    ANDS  W16, W6, W4, ROR #16
    ANDS  X15, X28, #0xff00ff00ff00ff0
    ADDS  X23, X15, X4, SXTX #0
    FCMP  S7, S6
    ADDS  X18, X23, X23, LSR #60
    ANDS  W27, W17, #0x3fffff8
    SUBS  W24, W25, W9, UXTB #0
    SUBS  W19, W25, W6, SXTX #2
    SUBS  W13, W23, W22, LSR #15
    SUBS  W2, W25, W11, SXTH #2
    SUBS  X6, X20, X25, UXTX #0
    SUBS  X29, X15, X29, LSL #38
    SUBS  X20, X28, #0xe2b, LSL #12
    ADDS  X29, X12, X20, UXTX #1
    ANDS  X21, X29, X26, LSL #45
    ANDS  X4, X13, #0xfffffbfffffffbff
    SUBS  X21, X16, X23, LSL #27
    SUBS  X6, X16, W10, UXTB #0
    SUBS  X13, X21, X10, ASR #55
    SUBS  W7, W25, W12, LSL #17
    ANDS  W20, W27, #0x600
    ANDS  X11, X11, X21, LSL #52
    ADDS  W5, W6, #0xd14, LSL #12
    FCMP  D2, #0.0
    FCMP  S23, S16
    SUBS  W23, W16, W17, UXTX #0
    SUBS  X15, X10, X2, ASR #24
    ANDS  X27, X23, #0xffc0000000001fff
    ANDS  W8, W10, W14, ASR #12
    ANDS  X4, X19, X16, LSL #44
    ADDS  W18, W5, W18, LSL #30
    ADDS  W2, W5, W27, LSL #11
    SUBS  X28, X10, X10, ASR #30
    ADDS  W16, W29, #0x999
    ADDS  W21, W28, W29, ASR #1
    SUBS  W4, W4, #0x0
    ADDS  W29, W6, W14, UXTB #1
    ADDS  X12, X11, X17, LSR #59
    SUBS  X14, X19, X19, ASR #61
    ADDS  X23, X19, #0x2e8
    SUBS  W25, W26, W18, LSL #21
    ANDS  X12, X15, X21, ASR #10
    ADDS  X7, X10, X15, LSL #32
    FCMPE  S26, S31
    ADDS  W18, W25, #0x983
    ANDS  X29, X28, #0xe0000000e
    ANDS  W21, W10, W29, LSR #25
    ADDS  X8, X16, W23, UXTH #4
    SUBS  W7, W23, #0xe60
    ADDS  X2, X4, #0x8cf, LSL #12
    ADDS  W16, W22, W17, SXTX #4
    ANDS  X19, X11, X8, ROR #56
    SUBS  W4, W16, W15, UXTB #3
    SUBS  X17, X26, #0x1da
    ANDS  X18, X21, #0x7ffffff0000
    ADDS  X12, X22, X15, ASR #24
    ADDS  X29, X29, W4, UXTB #1
    ADDS  W12, W26, #0x160
    ANDS  W6, W2, W9, LSR #23
    ANDS  W19, W9, #0xfefefefe
    SUBS  X8, X8, X17, ASR #40
    ANDS  X15, X8, X19, LSR #37
    ANDS  X16, X12, #0xfc01fc01fc01fc01
    ADDS  X4, X19, #0x796, LSL #12
    ADDS  W5, W2, #0xdc0
    ADDS  W8, W8, W12, LSL #13
    SUBS  X18, X20, X5, LSR #19
    SUBS  X12, X7, #0xa37, LSL #12
    ANDS  W11, W4, #0x7c007c
    ADDS  W4, W11, #0x18a, LSL #12
    ADDS  X4, X15, #0x589, LSL #12
    SUBS  W27, W21, W25, ASR #28
    ANDS  X18, X2, #0x380000003800
    ADDS  X24, X11, X8, LSL #32
    ANDS  W7, W23, #0x800001ff
    ANDS  W23, W10, #0x83ff83ff
    SUBS  W5, W5, W11, LSR #30
    SUBS  X19, X12, #0x5a7, LSL #12
    ADDS  W28, W5, W8, SXTH #2
    SUBS  W29, W29, W19, LSL #15
    ANDS  W15, W26, W4, LSL #5
    ADDS  W28, W16, W18, ASR #22
    ADDS  X8, X2, X9, ASR #61
    ADDS  W10, W9, W17, SXTH #3
    SUBS  W4, W19, W10, LSL #4
    SUBS  W21, W23, #0x2d0, LSL #12
    ANDS  W21, W23, #0xe0
    SUBS  X8, X15, #0x259, LSL #12
    SUBS  W25, W11, #0x3f1
    SUBS  X28, X8, X21, LSR #29
    ANDS  W19, W22, W12, ASR #9
    ANDS  W4, W7, #0x7c00000
    SUBS  W29, W11, W14, LSR #22
    SUBS  W11, W27, W4, SXTH #0
    SUBS  X23, X15, #0x142
    SUBS  X23, X27, W19, SXTH #3
    FCMP  D3, D9
    SUBS  X23, X19, X5, LSL #17
    SUBS  X2, X25, W24, SXTB #3
    ADDS  W27, W10, W20, LSL #25
    ADDS  W9, W23, #0x573
    ANDS  W11, W17, #0x7f80000
    SUBS  X22, X22, #0x1
    B.NE  TaishanIntCcP01_label_308
    MOVZ  X11, #0xf98b, LSL #0
    MOVK  X11, #0xf, LSL #16
    SUB  X23, X11, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X8, X24, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X11, #0xfdc0, LSL #0
    MOVK  X11, #0x8c, LSL #16
    SUB  X13, X11, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X20, #0x113, LSL #0
    SUB  X11, X20, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X8
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X10, #0x574, LSL #0
    MOVK  X10, #0x480, LSL #16
    SUB  X2, X10, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X7, #0x574, LSL #0
    MOVK  X7, #0x480, LSL #16
    SUB  X8, X7, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X27, X17, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x52b3, LSL #0
    MOVK  X13, #0xff6c, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X16, #0x52b3, LSL #0
    MOVK  X16, #0xff6c, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X20, X16, X13
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X24, #0xce2b, LSL #0
    MOVK  X24, #0xf, LSL #16
    SUB  X6, X24, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X17, X27, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x52b3, LSL #0
    MOVK  X2, #0xff6c, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X23, X2, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X19
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X26, X13, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X10, #0xce2b, LSL #0
    MOVK  X10, #0xf, LSL #16
    SUB  X16, X10, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x5c, LSL #0
    MOVK  X23, #0x10, LSL #16
    SUB  X12, X23, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X2, #0xf236, LSL #0
    MOVK  X2, #0x78d9, LSL #16
    MOVK  X2, #0x3, LSL #32
    MOVK  X2, #0xfb08, LSL #48
    MOVZ  X4, #0x9000, LSL #0
    MOVK  X4, #0x8417, LSL #16
    MOVK  X4, #0x4911, LSL #32
    MOVK  X4, #0x3a00, LSL #48
    MOVZ  X5, #0x46c8, LSL #0
    MOVK  X5, #0xca49, LSL #16
    MOVK  X5, #0x388b, LSL #32
    MOVK  X5, #0x66c, LSL #48
    MOVZ  X6, #0xd13b, LSL #0
    MOVK  X6, #0xa9a1, LSL #16
    MOVK  X6, #0x91b0, LSL #32
    MOVK  X6, #0x9fe8, LSL #48
    MOVZ  X7, #0x69e8, LSL #0
    MOVK  X7, #0x3e6e, LSL #16
    MOVK  X7, #0x9a00, LSL #32
    MOVK  X7, #0x5250, LSL #48
    MOVZ  X8, #0x46c9, LSL #0
    MOVK  X8, #0xcb8e, LSL #16
    MOVK  X8, #0x4e35, LSL #32
    MOVK  X8, #0xf1d4, LSL #48
    MOVZ  X9, #0x33f0, LSL #0
    MOVK  X9, #0xd8f2, LSL #16
    MOVK  X9, #0x9cc3, LSL #32
    MOVK  X9, #0xf57c, LSL #48
    MOVZ  X10, #0x554b, LSL #0
    MOVK  X10, #0x692d, LSL #16
    MOVK  X10, #0x3de4, LSL #32
    MOVK  X10, #0x176, LSL #48
    MOVZ  X11, #0x558, LSL #0
    MOVK  X11, #0xe84b, LSL #16
    MOVK  X11, #0x4b44, LSL #32
    MOVK  X11, #0xb6b2, LSL #48
    MOVZ  X12, #0x9ea5, LSL #0
    MOVK  X12, #0xc3b2, LSL #16
    MOVK  X12, #0x9294, LSL #32
    MOVK  X12, #0xd106, LSL #48
    MOVZ  X13, #0xa797, LSL #0
    MOVK  X13, #0xb356, LSL #16
    MOVK  X13, #0xd045, LSL #32
    MOVK  X13, #0x3ac2, LSL #48
    MOVZ  X14, #0xac, LSL #0
    MOVK  X14, #0x104a, LSL #16
    MOVK  X14, #0xe832, LSL #32
    MOVK  X14, #0x65d3, LSL #48
    MOVZ  X15, #0x40cf, LSL #0
    MOVK  X15, #0xa2fe, LSL #16
    MOVK  X15, #0xe341, LSL #32
    MOVK  X15, #0x91fb, LSL #48
    MOVZ  X16, #0xeffe, LSL #0
    MOVK  X16, #0xe2b0, LSL #16
    MOVK  X16, #0x9f1d, LSL #32
    MOVK  X16, #0x51ef, LSL #48
    MOVZ  X17, #0x906b, LSL #0
    MOVK  X17, #0x7241, LSL #16
    MOVK  X17, #0x81fa, LSL #32
    MOVK  X17, #0xb8dd, LSL #48
    MOVZ  X18, #0x3e27, LSL #0
    MOVK  X18, #0x7d81, LSL #16
    MOVK  X18, #0x4294, LSL #32
    MOVK  X18, #0x852f, LSL #48
    MOVZ  X19, #0x4ffa, LSL #0
    MOVK  X19, #0x4911, LSL #16
    MOVK  X19, #0xa014, LSL #32
    MOVK  X19, #0xd68, LSL #48
    MOVZ  X20, #0xbd04, LSL #0
    MOVK  X20, #0xb201, LSL #16
    MOVK  X20, #0xbfb0, LSL #32
    MOVK  X20, #0x6104, LSL #48
    MOVZ  X21, #0xc314, LSL #0
    MOVK  X21, #0x785e, LSL #16
    MOVK  X21, #0x8a6f, LSL #32
    MOVK  X21, #0xf158, LSL #48
    MOVZ  X22, #0xbcb1, LSL #0
    MOVK  X22, #0x241, LSL #16
    MOVK  X22, #0xa6d6, LSL #32
    MOVK  X22, #0x9cd7, LSL #48
    MOVZ  X23, #0x8c75, LSL #0
    MOVK  X23, #0x8392, LSL #16
    MOVK  X23, #0x4fab, LSL #32
    MOVK  X23, #0x1f92, LSL #48
    MOVZ  X24, #0xeb20, LSL #0
    MOVK  X24, #0x6748, LSL #16
    MOVK  X24, #0x21d6, LSL #32
    MOVK  X24, #0x80ac, LSL #48
    MOVZ  X25, #0x122c, LSL #0
    MOVK  X25, #0xdd09, LSL #16
    MOVK  X25, #0xce97, LSL #32
    MOVK  X25, #0xb78b, LSL #48
    MOVZ  X26, #0x343, LSL #0
    MOVK  X26, #0x7352, LSL #16
    MOVK  X26, #0xa7a5, LSL #32
    MOVK  X26, #0xecce, LSL #48
    MOVZ  X27, #0xf857, LSL #0
    MOVK  X27, #0x4663, LSL #16
    MOVK  X27, #0xfe9a, LSL #32
    MOVK  X27, #0xec5c, LSL #48
    MOVZ  X28, #0xe4e3, LSL #0
    MOVK  X28, #0xab1b, LSL #16
    MOVK  X28, #0xd321, LSL #32
    MOVK  X28, #0xdbde, LSL #48
    MOVZ  X29, #0x615b, LSL #0
    MOVK  X29, #0xec6c, LSL #16
    MOVK  X29, #0x8f1, LSL #32
    MOVK  X29, #0x4b50, LSL #48
    MOVZ  X15, #0x14, LSL #0
TaishanIntCcP01_label_335:
    SUBS  W27, W11, W21, LSR #24
    ANDS  W11, W22, W5, LSR #1
    ANDS  W6, W29, W12, ROR #21
    ADDS  W2, W28, #0x3eb, LSL #12
    FCMP  S27, #0.0
    ADDS  X4, X8, #0x132, LSL #12
    ANDS  X26, X14, X26, ASR #22
    ADDS  W2, W18, #0xdb0
    ANDS  X5, X8, #0x7fc000000
    ANDS  X24, X15, X4, LSR #7
    FCMPE  S28, #0.0
    SUBS  W28, W27, #0x504, LSL #12
    ADDS  W17, W24, W21, UXTB #3
    ANDS  W24, W12, W13, LSR #16
    ADDS  W26, W6, W26, UXTW #0
    ANDS  X2, X8, X28, LSL #11
    ADDS  W16, W19, #0x9f7, LSL #12
    ANDS  W2, W16, W28, ASR #15
    SUBS  X24, X22, X26, LSR #21
    SUBS  X13, X19, X16, LSL #20
    FCMP  D3, D29
    SUBS  X26, X15, X11, LSR #14
    ANDS  X2, X5, #0xffffffffff800007
    ANDS  W10, W16, #0x1fff
    ANDS  W17, W4, #0x9f9f9f9f
    SUBS  X18, X29, W7, UXTH #2
    SUBS  X2, X17, #0x8c2, LSL #12
    SUBS  X18, X22, X11, LSR #2
    ANDS  W5, W28, #0xe1e1e1e1
    SUBS  W21, W22, W12, SXTB #1
    SUBS  X21, X9, X17, LSR #1
    ADDS  X26, X7, #0xe74, LSL #12
    ADDS  W10, W14, #0xbf9, LSL #12
    SUBS  X19, X9, #0x389
    ANDS  X4, X14, #0x7ffc00007ffc00
    SUBS  W13, W21, W9, ASR #9
    ADDS  X9, X10, #0xa00
    ANDS  W5, W16, W26, LSL #5
    ADDS  W18, W20, #0x264
    ADDS  W8, W17, #0x650
    ADDS  X8, X17, #0x371, LSL #12
    ADDS  X14, X2, X8, SXTX #3
    SUBS  W11, W5, W20, LSR #4
    ADDS  W26, W29, W16, UXTB #1
    ANDS  W7, W26, W24, ASR #29
    ADDS  X19, X19, #0x856, LSL #12
    ADDS  X7, X27, #0x2ba
    ADDS  W18, W21, W13, LSR #0
    ANDS  X29, X11, X4, LSR #19
    ADDS  W19, W19, #0x50
    ADDS  W5, W25, W26, LSL #29
    ANDS  W13, W9, W15, LSR #17
    ADDS  W14, W13, W13, UXTX #1
    ADDS  X29, X28, #0x4c1, LSL #12
    ANDS  X6, X8, X18, ASR #50
    FCMPE  D16, #0.0
    ADDS  X29, X2, W27, UXTW #3
    SUBS  X19, X22, X29, UXTX #3
    SUBS  W19, W19, W20, SXTX #2
    ADDS  W12, W13, W20, LSL #2
    SUBS  W7, W21, #0x9a2, LSL #12
    ANDS  W29, W27, #0xffff00ff
    ANDS  W24, W11, #0x3c3c3c3c
    SUBS  W12, W10, #0xa9
    ADDS  X13, X19, X11, LSR #23
    SUBS  X20, X13, W5, UXTB #3
    SUBS  W19, W20, W2, LSL #15
    ADDS  W12, W27, W7, UXTB #3
    ADDS  X16, X17, W18, UXTH #2
    SUBS  W8, W6, W14, UXTB #2
    ANDS  W2, W24, #0x66666666
    SUBS  W2, W6, W20, UXTW #1
    ANDS  X25, X16, X29, ROR #21
    ANDS  W5, W16, W27, ASR #18
    ANDS  X5, X13, X5, LSL #17
    SUBS  X12, X21, X5, ASR #52
    ADDS  W7, W12, W5, LSR #5
    ADDS  W25, W10, W22, LSL #23
    SUBS  W19, W25, W6, LSL #28
    SUBS  W20, W19, W14, LSR #17
    ADDS  W2, W6, W14, SXTB #2
    ADDS  X20, X28, X27, LSL #39
    SUBS  W16, W13, #0xbf0
    ADDS  X16, X21, X19, LSR #3
    ANDS  W5, W8, W21, ROR #25
    SUBS  W25, W5, W8, ASR #31
    SUBS  W19, W17, W2, LSR #12
    ANDS  X5, X7, X19, LSL #48
    ADDS  W21, W25, W12, SXTX #1
    SUBS  W13, W28, W5, LSL #2
    SUBS  W7, W17, #0x520
    ADDS  X8, X6, X4, LSL #31
    SUBS  X17, X13, #0x7a7, LSL #12
    ADDS  W20, W4, W6, ASR #24
    SUBS  W11, W10, W14, SXTH #3
    ADDS  X7, X16, W4, SXTW #2
    SUBS  W28, W16, W29
    FCMP  D29, D3
    ADDS  W17, W28, W26, LSR #18
    SUBS  X14, X20, W13, SXTW #0
    ADDS  X17, X8, #0xa8, LSL #12
    SUBS  X13, X27, X27, UXTX #0
    SUBS  W26, W16, W21, UXTH #2
    FCMPE  D29, #0.0
    ANDS  X26, X11, #0x3fc03fc03fc03fc
    ADDS  X14, X7, X4, LSR #36
    ADDS  X28, X2, #0x504, LSL #12
    ANDS  X13, X4, #0xfcfcfcfcfcfcfcfc
    ADDS  X16, X14, #0xd5f
    ANDS  W2, W18, W6, ROR #8
    SUBS  X16, X4, X2, SXTX #1
    FCMP  D4, D25
    SUBS  W22, W10, W14, ASR #6
    SUBS  X16, X17, #0x5c3, LSL #12
    ANDS  W16, W26, #0xf007ffff
    ADDS  W16, W12, #0xad9, LSL #12
    ADDS  W13, W5, W10, ASR #7
    SUBS  W22, W18, W19, SXTB #3
    FCMPE  D19, D5
    ADDS  W5, W9, #0x458
    ADDS  W25, W10, W4, SXTB #3
    SUBS  W20, W13, W28, LSL #31
    ANDS  W2, W17, #0x3ff8000
    SUBS  X16, X17, X22, LSR #13
    ANDS  W5, W11, W5, LSL #27
    ANDS  X6, X26, #0xc001c001c001c001
    ADDS  X21, X6, #0x359
    ADDS  W2, W2, W15, SXTW #0
    ANDS  X28, X27, X2, ASR #14
    ANDS  W21, W27, W28, ROR #22
    ANDS  W25, W16, W25, LSL #7
    ADDS  X21, X20, X8, ASR #39
    ANDS  X4, X21, #0xfffe0000fffe0
    ANDS  W17, W12, #0x3fffc000
    ADDS  X4, X15, #0x5cb
    ANDS  W7, W9, #0x1c00
    ADDS  W19, W24, W8, LSR #15
    SUBS  X12, X28, X20, LSR #50
    ADDS  W28, W18, W2, LSR #21
    ANDS  W28, W5, W12, ROR #21
    ANDS  X12, X7, X14, LSR #56
    ANDS  X13, X10, X26, LSR #11
    ADDS  X21, X26, #0x742
    SUBS  X11, X12, X10, LSL #39
    FCMP  D15, D15
    ADDS  X28, X15, X25, LSR #12
    ADDS  W28, W11, W28, LSL #14
    ANDS  X23, X16, #0xffffffffff80
    FCMP  S14, S14
    SUBS  X26, X20, W21, SXTB #1
    SUBS  X23, X2, #0x2e0
    ANDS  W11, W25, W4, ASR #22
    ADDS  W17, W28, #0xbde
    ANDS  W2, W14, W8, ASR #24
    SUBS  W24, W20, #0x638
    ANDS  X5, X27, X19, LSR #4
    ADDS  X29, X2, #0x623, LSL #12
    SUBS  W17, W13, W19, UXTH #3
    ADDS  X28, X9, #0x3d0
    SUBS  X11, X16, X12, LSL #62
    ADDS  X14, X6, W7, UXTH #1
    ANDS  X6, X7, X19, ASR #7
    ADDS  W4, W26, W7, ASR #17
    ANDS  X16, X25, X29, ROR #24
    SUBS  X5, X10, X24, UXTX #2
    ANDS  X28, X6, #0x7777777777777777
    SUBS  W17, W8, W17, SXTW #1
    ANDS  X6, X26, X22, ROR #37
    SUBS  W6, W24, W22, LSR #15
    SUBS  X27, X8, #0xe06, LSL #12
    ADDS  X6, X15, W16, UXTB #0
    ADDS  W10, W29, #0x5c1
    SUBS  X12, X17, W21, SXTB #3
    SUBS  W21, W19, #0x775, LSL #12
    ANDS  X8, X5, X15, LSL #48
    ADDS  W26, W12, #0x7d0
    SUBS  W13, W22, #0xb27, LSL #12
    SUBS  W22, W29, #0xefc, LSL #12
    SUBS  W13, W10, #0x4dd
    SUBS  X2, X21, #0x480
    SUBS  X4, X29, #0x13, LSL #12
    SUBS  X5, X24, #0x3a1, LSL #12
    ADDS  X2, X4, X19, LSR #52
    ADDS  X25, X24, #0xed6, LSL #12
    ADDS  X9, X24, #0xc2e, LSL #12
    ANDS  W13, W12, W4, LSL #22
    FCMP  S1, S16
    ADDS  W22, W5, W16, UXTB #4
    SUBS  W25, W20, W14, UXTB #0
    ANDS  W29, W21, #0x80007fff
    ADDS  X16, X20, W14, UXTW #0
    SUBS  X4, X26, X21, SXTX #3
    ANDS  X5, X29, #0xffffff80ffffff8
    ANDS  X17, X27, X17, ROR #14
    ADDS  X11, X8, X22, LSL #61
    FCMP  S19, S2
    SUBS  X10, X9, X5, LSR #9
    SUBS  X26, X15, W27, SXTW #4
    ADDS  X24, X22, X26, LSR #60
    SUBS  X29, X24, X24, LSR #57
    SUBS  X15, X15, #0x1
    B.NE  TaishanIntCcP01_label_335
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x61, LSL #16
    SUB  X7, X23, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntCcP01_TestFail
    MOVZ  X27, #0xc620, LSL #0
    MOVK  X27, #0x237b, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X20, X27, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X6, #0x5808, LSL #0
    SUB  X23, X6, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X27, #0x5808, LSL #0
    SUB  X22, X27, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X4, #0x58dc, LSL #0
    MOVK  X4, #0xc4, LSL #16
    SUB  X13, X4, X10
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntCcP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X28, X22, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X24, X28, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntCcP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X20, X4, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x8f40, LSL #0
    MOVK  X17, #0x1, LSL #16
    SUB  X12, X17, X16
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X25, #0x8f40, LSL #0
    MOVK  X25, #0x1, LSL #16
    SUB  X4, X25, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntCcP01_TestFail
    MOVZ  X11, #0x4fe4, LSL #0
    MOVK  X11, #0x175, LSL #16
    SUB  X19, X11, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X19
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X20, #0xd80c, LSL #0
    MOVK  X20, #0x1b90, LSL #16
    SUB  X24, X20, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntCcP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
TaishanIntCcP01_label_77:
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntCcP01_TestFail
    MOVZ  X7, #0x8f40, LSL #0
    MOVK  X7, #0x1, LSL #16
    SUB  X16, X7, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x5808, LSL #0
    SUB  X9, X8, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntCcP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X14, X12, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
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
TaishanIntCcP01_label_363:
    ADDS  X27, X19, X26, LSL #20
    ANDS  X16, X14, X2, ROR #0
    SUBS  X15, X15, X24, LSR #5
    ANDS  X25, X6, X29, LSR #43
    FCMP  D23, #0.0
    ADDS  X27, X8, X15, UXTX #2
    ADDS  X27, X13, X2, ASR #42
    SUBS  X24, X15, X29, UXTX #2
    ANDS  X23, X16, #0x3e0000003e000
    ANDS  X22, X28, X11, LSR #23
    ANDS  X10, X20, #0x3fffffffffe000
    FCMP  D4, #0.0
    ADDS  W25, W10, W27, ASR #9
    SUBS  W22, W12, W18, ASR #7
    ADDS  X24, X23, X8, ASR #34
    ANDS  X27, X8, X24, ASR #6
    SUBS  W25, W6, W13, LSR #3
    FCMP  S10, S5
    SUBS  W22, W25, #0xa3e, LSL #12
    SUBS  W24, W18, W17, SXTB #4
    ANDS  W23, W7, #0xfff1ffff
    ADDS  X20, X27, W27, SXTH #0
    SUBS  X23, X6, X26, LSR #56
    SUBS  W22, W15, #0x221, LSL #12
    SUBS  X20, X20, X16, LSL #36
    ANDS  W7, W24, #0x3ffff0
    ADDS  W23, W26, W4, LSL #3
    SUBS  X16, X25, #0x7d0
    ANDS  W8, W25, W24, LSL #1
    ANDS  X28, X20, X12, ASR #18
    SUBS  W8, W4, W22, UXTB #1
    ADDS  X12, X14, X7, ASR #15
    ANDS  X20, X23, #0xfffff0000000001f
    ADDS  W22, W11, W19, ASR #18
    ADDS  W12, W29, W25, LSL #10
    ADDS  W26, W22, W15, UXTX #1
    ADDS  W27, W20, #0x8c0
    ADDS  X21, X16, #0x5b0
    ANDS  X6, X28, X24, ROR #45
    SUBS  W11, W9, W19, LSL #12
    SUBS  W12, W19, W12, ASR #10
    FCMP  S21, S1
    SUBS  W12, W26, W4, LSL #10
    ADDS  W4, W12, W4, SXTW #4
    ADDS  W8, W8, #0xd82
    SUBS  X14, X23, #0x331
    ANDS  W14, W20, W14, ROR #31
    SUBS  X16, X22, X17, LSL #38
    ADDS  W11, W8, #0x7ac, LSL #12
    ADDS  W11, W27, #0x7d0
    SUBS  X23, X11, X16, LSL #29
    ANDS  W6, W21, #0xffc00001
    ADDS  X26, X19, #0x2b4, LSL #12
    ANDS  W18, W17, #0xfc00000
    FCMPE  D27, #0.0
    SUBS  W14, W14, #0x0
    ANDS  X15, X20, X19, ROR #17
    SUBS  W29, W25, W22, SXTH #1
    SUBS  X12, X9, #0x504, LSL #12
    SUBS  W18, W6, W9, LSL #5
    ADDS  X27, X10, #0x792
    SUBS  W24, W14, #0xe3
    SUBS  X23, X12, #0x8cf
    ADDS  W17, W26, #0x6c9
    ADDS  X19, X17, W15, SXTB #4
    ANDS  W21, W28, #0x33333333
    SUBS  W7, W26, #0x16e, LSL #12
    ADDS  W22, W21, W12, UXTB #2
    ADDS  X14, X24, X7, LSR #12
    ANDS  X16, X16, X16, LSR #62
    SUBS  X27, X29, W14, UXTH #3
    ANDS  X20, X15, #0x2222222222222222
    ADDS  X23, X6, #0x983, LSL #12
    ADDS  X21, X20, #0x84c, LSL #12
    SUBS  W6, W11, W6, UXTH #2
    ADDS  X14, X17, X10, LSL #3
    ADDS  W14, W21, W16, UXTB #1
    ANDS  W26, W23, #0xfffe007f
    ADDS  W9, W17, #0xebb
    ANDS  X27, X6, #0xffffc000ffffc0
    ANDS  X10, X8, X18, ASR #31
    ANDS  W18, W8, #0x3fffc00
    ADDS  X10, X18, W21, SXTW #4
    SUBS  W11, W7, W15, LSL #1
    SUBS  W12, W29, #0xb0e
    ADDS  X27, X24, X23, LSR #21
    ANDS  X25, X14, #0xffffffffe00000
    FCMP  S14, S10
    FCMPE  S25, #0.0
    SUBS  X20, X20, X11, LSR #45
    ANDS  W17, W19, W26, LSL #24
    ADDS  W14, W11, #0x575
    ANDS  X11, X11, X11, LSL #31
    ADDS  X25, X16, X13, LSL #6
    ADDS  W24, W13, W27, LSL #2
    ADDS  W6, W21, W14, LSL #12
    ANDS  X10, X15, X5, ROR #38
    ANDS  X11, X22, #0xff007fffff007fff
    SUBS  X19, X9, W14, UXTW #3
    FCMP  S30, #0.0
    SUBS  X23, X12, #0x7ef, LSL #12
    SUBS  X27, X21, W25, SXTW #4
    ANDS  X26, X19, X11, ROR #8
    SUBS  W23, W22, W10, UXTX #4
    ANDS  W28, W7, #0x3ffe
    SUBS  W19, W11, #0xb60
    ADDS  W4, W27, #0x186, LSL #12
    ADDS  W20, W28, W18, ASR #18
    ADDS  W24, W26, W5, LSR #23
    ADDS  W26, W20, W26, UXTX #1
    SUBS  W19, W10, #0x3a1
    ANDS  W6, W24, W26, ASR #28
    SUBS  X6, X17, W9, UXTB #2
    ADDS  W29, W28, #0xa51
    SUBS  X28, X24, #0x80
    ADDS  W18, W29, W12, UXTB #0
    ANDS  W6, W20, W12, LSL #1
    ANDS  X17, X28, #0xe000ffffffffffff
    ADDS  X28, X18, X10, UXTX #0
    ADDS  X26, X19, W7, SXTW #3
    ADDS  W26, W13, W16, UXTW #2
    SUBS  W22, W28, W27, SXTB #4
    ADDS  W25, W16, W14, ASR #2
    ANDS  X15, X18, X9, LSL #8
    ANDS  W5, W4, #0xf0000003
    SUBS  X14, X6, W21, UXTB #1
    SUBS  X18, X24, #0xd0
    ANDS  W14, W29, W20, ASR #15
    ADDS  X21, X15, X17, LSL #20
    ADDS  W13, W20, W12, ASR #24
    SUBS  W4, W23, W12, UXTX #4
    ADDS  W18, W5, #0x92, LSL #12
    SUBS  W18, W4, W20, UXTW #1
    ANDS  W12, W10, W13, ASR #11
    ANDS  W11, W12, W5, ASR #27
    ADDS  W20, W29, #0xcff
    SUBS  X15, X11, X20, LSR #63
    FCMPE  S17, #0.0
    SUBS  W7, W26, W24, UXTB #2
    SUBS  W5, W19, #0xfc0
    ANDS  X25, X4, X19, ASR #5
    ADDS  W14, W6, W9, UXTH #0
    ADDS  W12, W28, W17, LSR #3
    SUBS  X9, X5, W16, SXTB #2
    ADDS  X13, X26, #0xd10
    SUBS  W22, W23, #0xdb1, LSL #12
    ADDS  W26, W20, W8, ASR #25
    SUBS  W14, W25, W21, UXTB #4
    ADDS  X17, X20, X8, LSL #19
    SUBS  X14, X17, X10, LSL #29
    SUBS  W26, W5, #0xe8b
    SUBS  X10, X15, #0xe54, LSL #12
    ADDS  W17, W6, W13, LSR #14
    ADDS  X7, X28, #0xce, LSL #12
    SUBS  X23, X8, #0xe52, LSL #12
    ADDS  X11, X26, X17, LSL #2
    ADDS  W23, W24, #0x83b
    ADDS  W25, W17, W16, UXTX #4
    ADDS  X22, X12, W8, SXTB #4
    ANDS  W10, W27, W22, ROR #16
    FCMP  D0, D14
    SUBS  X20, X25, W23, SXTH #3
    SUBS  W10, W25, W9, LSL #14
    ADDS  W9, W28, W29, SXTH #2
    SUBS  X26, X20, #0xf45, LSL #12
    SUBS  X14, X8, #0xe4
    FCMP  D10, D8
    SUBS  X28, X25, #0x629
    ANDS  X10, X25, #0xfffffe03fffffe03
    SUBS  W20, W2, W23, ASR #5
    SUBS  W20, W26, #0xe21
    SUBS  X29, X17, #0x445
    ADDS  X7, X12, X26, ASR #15
    ADDS  X23, X28, X9, LSR #60
    SUBS  X8, X26, X10, LSL #31
    ADDS  W21, W27, W28, UXTB #1
    SUBS  X22, X13, W22, UXTW #3
    SUBS  W12, W8, #0xb, LSL #12
    ANDS  X6, X17, #0x7f7f7f7f7f7f7f7f
    ADDS  X15, X9, X9, LSL #48
    SUBS  X10, X26, #0x85b, LSL #12
    ADDS  X28, X17, #0xef1
    SUBS  W29, W2, #0x10
    SUBS  X22, X28, X2, UXTX #3
    ADDS  W9, W27, W25, ASR #21
    ADDS  X27, X14, X15, LSL #44
    FCMPE  D2, #0.0
    ANDS  W16, W25, W6, ASR #9
    ANDS  W22, W16, #0xc03fc03f
    ADDS  W10, W9, W28, UXTH #4
    ANDS  W28, W16, W20, LSR #10
    SUBS  X15, X12, #0x1e0
    ANDS  W25, W8, #0x30000000
    ADDS  X29, X17, W23, SXTB #1
    ANDS  W10, W19, W20, LSR #4
    SUBS  X9, X29, X6, LSR #54
    FCMP  S5, #0.0
    ANDS  X29, X24, X2, ROR #63
    ADDS  W24, W9, W8, LSL #20
    ANDS  W23, W16, W2, ASR #5
    SUBS  X2, X2, #0x1
    B.NE  TaishanIntCcP01_label_363
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntCcP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X21, #0x1c4e, LSL #0
    SUB  X16, X21, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X20, #0x256a, LSL #0
    SUB  X17, X20, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X8
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X18, #0x1cf8, LSL #0
    SUB  X8, X18, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X18, #0xb448, LSL #0
    MOVK  X18, #0xff0, LSL #16
    SUB  X27, X18, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntCcP01_TestFail
    MOVZ  X22, #0x4f4c, LSL #0
    MOVK  X22, #0x1, LSL #32
    SUB  X17, X22, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X18, #0x61f, LSL #0
    MOVK  X18, #0x1, LSL #16
    SUB  X29, X18, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X12, #0x42da, LSL #0
    SUB  X28, X12, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X22, #0xc8c6, LSL #0
    MOVK  X22, #0xff0a, LSL #16
    SUB  X26, X22, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntCcP01_TestFail
    MOVZ  X21, #0x61f, LSL #0
    MOVK  X21, #0x1, LSL #16
    SUB  X8, X21, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X29, #0xfc5f, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X18, X29, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntCcP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X20
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X26, #0x61f, LSL #0
    MOVK  X26, #0x1, LSL #16
    SUB  X12, X26, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X5, #0xc8c6, LSL #0
    MOVK  X5, #0xff0a, LSL #16
    SUB  X26, X5, X22
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X28, X13, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X14, X11, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X6, #0xfc5f, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X24, X6, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x0, LSL #0
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
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X24, #0x14, LSL #0
TaishanIntCcP01_label_391:
    ANDS  W18, W6, W13, LSL #7
    ANDS  X23, X20, #0xfffffffe007fffff
    FCMP  S26, #0.0
    SUBS  W14, W24, W14, SXTH #3
    SUBS  X17, X21, W5, UXTW #3
    ANDS  W23, W29, #0xf8000
    ANDS  W8, W27, W20, ASR #0
    ADDS  W18, W24, W25, SXTH #0
    ADDS  X6, X8, X2, UXTX #3
    ANDS  X5, X28, X20, LSL #62
    ADDS  X17, X24, W11, SXTH #1
    ADDS  X11, X27, W11, UXTH #3
    FCMPE  D4, D7
    SUBS  X17, X4, X11, LSL #36
    SUBS  X5, X28, #0x0
    ANDS  W16, W28, #0xfffe03ff
    ANDS  W20, W6, #0xffff8007
    ADDS  W4, W5, W25, LSL #5
    FCMP  D6, #0.0
    ANDS  X10, X25, X9, LSR #61
    SUBS  W6, W24, W20, LSR #8
    FCMP  S2, #0.0
    SUBS  W21, W24, W7, UXTW #0
    ANDS  X5, X13, X8, ASR #32
    ADDS  X9, X2, X11, ASR #54
    SUBS  W2, W24, #0xe41
    ADDS  X25, X5, X24, SXTX #4
    ADDS  W22, W28, #0xd6c, LSL #12
    ADDS  X21, X17, #0xa50
    ADDS  W4, W8, #0xc8b
    ADDS  X21, X26, X20, LSL #23
    ANDS  W19, W12, W15, LSR #19
    ADDS  X16, X25, X15, SXTX #3
    SUBS  W8, W16, W29, UXTX #4
    SUBS  W10, W12, W24, SXTX #1
    FCMPE  S11, S29
    ANDS  W2, W13, #0xfff00
    ANDS  W22, W15, #0x1ff0000
    SUBS  X22, X2, #0x0
    SUBS  W16, W9, W22, LSR #3
    SUBS  X23, X20, X8, LSL #11
    SUBS  X6, X20, #0x5c2, LSL #12
    SUBS  X21, X8, X28, LSL #46
    SUBS  W4, W16, W4, LSR #11
    ANDS  W22, W21, W6, LSL #9
    SUBS  W26, W9, #0x797, LSL #12
    SUBS  W18, W26, W16, UXTB #2
    ADDS  W16, W19, W6, SXTW #3
    ANDS  X14, X23, X7, LSR #16
    SUBS  W18, W20, W18, ASR #14
    ANDS  X8, X8, #0xff3fffffff3fffff
    ADDS  X8, X9, X21, LSL #5
    ANDS  W19, W6, #0xfff80fff
    SUBS  X26, X10, #0x544
    SUBS  X2, X13, #0xc1c
    ADDS  W20, W11, W4, UXTW #0
    ADDS  W7, W5, W2, SXTB #0
    ADDS  W21, W26, W23, UXTH #1
    ANDS  X9, X5, X8, ASR #3
    SUBS  W14, W25, #0x0
    SUBS  X7, X29, #0x0
    ADDS  W5, W6, W13, LSL #16
    ADDS  W16, W16, W27, SXTB #4
    ANDS  W19, W21, #0xffc003ff
    ADDS  X28, X5, X19, LSR #22
    ADDS  W27, W21, #0x21f
    SUBS  W7, W22, #0x54b
    ADDS  W4, W20, W8, LSL #21
    SUBS  W16, W18, W24, UXTH #0
    ANDS  W29, W28, #0x1fffe
    SUBS  X6, X24, X2, LSL #10
    SUBS  X26, X11, #0x3ab, LSL #12
    SUBS  W20, W8, #0x470
    ANDS  X11, X9, #0xffffff80003fffff
    ANDS  X12, X11, X26, LSL #17
    ADDS  X21, X26, #0x58e, LSL #12
    ADDS  W13, W4, W2, SXTW #1
    SUBS  X13, X14, X25, LSR #14
    FCMP  S1, #0.0
    ANDS  X23, X23, X13, ASR #2
    SUBS  X7, X14, X19, LSR #55
    SUBS  W16, W18, #0xfd
    SUBS  W27, W12, W11, SXTW #4
    ANDS  W12, W9, W13, LSR #19
    SUBS  X8, X8, #0x89f
    SUBS  W20, W22, W27, SXTB #0
    SUBS  W13, W4, #0xbf8
    SUBS  X20, X15, X5, ASR #62
    ANDS  W29, W23, W12, LSL #25
    ADDS  X16, X19, X27, LSR #6
    SUBS  W5, W21, W18, SXTB #4
    SUBS  X29, X13, #0xa40
    SUBS  X20, X11, #0xf92, LSL #12
    ANDS  X2, X25, X29, LSR #13
    SUBS  X10, X13, W14, UXTB #4
    ADDS  X5, X11, X15, ASR #18
    SUBS  X20, X12, #0x382
    ANDS  X12, X12, X7, LSR #5
    ANDS  X10, X14, X18, LSR #48
    SUBS  X25, X24, #0x88, LSL #12
    SUBS  X4, X2, #0xdb, LSL #12
    SUBS  X25, X11, W17, SXTW #2
    SUBS  X6, X22, X2, LSL #12
    ANDS  W4, W26, #0xff1fffff
    SUBS  X10, X24, W14, SXTH #1
    SUBS  W16, W16, W23, LSL #23
    ADDS  X13, X4, W22, SXTB #2
    FCMP  S1, S27
    SUBS  W4, W23, W11, UXTB #2
    SUBS  W6, W27, W18, ASR #12
    ADDS  X21, X20, X19, ASR #8
    ADDS  W5, W10, #0x97, LSL #12
    ADDS  W9, W5, W2, LSR #20
    ADDS  X26, X20, X9, LSR #40
    SUBS  W28, W6, W22, ASR #31
    ADDS  X11, X28, W5, UXTH #3
    ADDS  W9, W28, W14, SXTH #3
    ANDS  X22, X13, X22, ROR #21
    ADDS  W14, W19, #0x23b
    ADDS  W20, W11, W22, UXTX #4
    SUBS  X7, X26, #0x2a4
    ADDS  X20, X11, X4, LSR #36
    SUBS  W20, W13, #0x373
    FCMPE  D25, D27
    ADDS  X2, X2, #0x96b, LSL #12
    ADDS  X23, X23, X28, SXTX #4
    ADDS  X26, X4, W10, SXTW #3
    SUBS  W9, W13, W27, ASR #11
    ANDS  W14, W19, W25, ROR #23
    ANDS  X20, X21, #0xbbbbbbbbbbbbbbbb
    SUBS  X21, X10, #0x480
    SUBS  W19, W18, #0x756
    SUBS  X4, X4, W18, SXTB #1
    FCMP  D4, #0.0
    ANDS  X21, X26, X16, LSL #45
    ANDS  X6, X19, X28, LSL #22
    SUBS  X20, X22, X21, ASR #28
    ANDS  W2, W13, W26, LSL #30
    SUBS  W20, W6, W27, UXTX #0
    ANDS  W26, W23, W18, LSL #8
    ADDS  W11, W16, W19, LSR #6
    SUBS  X20, X14, X14, LSL #29
    SUBS  X7, X26, X6, ASR #21
    ADDS  X4, X28, X28, LSL #7
    ADDS  W28, W14, W7, SXTB #0
    SUBS  W29, W18, W4, LSR #26
    SUBS  X23, X4, X15, ASR #45
    ADDS  W23, W21, W9, LSR #26
    ANDS  X25, X20, #0xaaaaaaaaaaaaaaaa
    SUBS  W7, W25, W19, ASR #26
    SUBS  W4, W6, #0x5bd, LSL #12
    SUBS  X11, X26, W27, SXTW #1
    ADDS  X19, X13, #0x989, LSL #12
    ADDS  W27, W7, W15, SXTX #3
    FCMP  D4, D10
    ADDS  X29, X11, X6, ASR #59
    SUBS  X2, X25, W19, SXTB #0
    ADDS  X28, X8, X22, UXTX #1
    SUBS  X11, X22, X7, ASR #8
    ADDS  W10, W20, W29, LSL #25
    ANDS  W15, W10, W9, ASR #17
    FCMPE  S13, S6
    ADDS  W8, W6, W12, LSR #27
    ANDS  W4, W20, W20, ROR #4
    SUBS  W8, W20, W24, UXTH #3
    ADDS  X14, X9, W5, SXTW #4
    ADDS  W5, W23, W11, SXTW #4
    ANDS  W25, W20, W5, ROR #8
    ADDS  X16, X20, #0xebb
    ADDS  X15, X8, X14, ASR #2
    ANDS  W2, W16, W16, ROR #27
    SUBS  X28, X18, X24, ASR #15
    SUBS  X26, X27, W19, UXTH #3
    ADDS  W2, W13, #0x550
    SUBS  X23, X19, W20, SXTH #0
    ANDS  W28, W15, W16, LSR #30
    ANDS  W23, W28, #0x1ffe000
    SUBS  X4, X27, X17, LSR #34
    SUBS  X25, X29, W10, SXTB #4
    SUBS  X16, X19, #0x6cb, LSL #12
    ADDS  X11, X16, X28, ASR #10
    ADDS  W16, W20, #0xed0
    ADDS  W28, W22, #0x210
    ANDS  X2, X28, #0xfffffff3fffffff3
    FCMP  D30, D22
    ADDS  W2, W6, #0xc54
    ADDS  W8, W26, W17, SXTW #4
    ADDS  W29, W24, #0x1a6, LSL #12
    ADDS  W25, W7, W4, LSR #1
    SUBS  W21, W20, W9, UXTH #3
    SUBS  X6, X2, X15, LSR #61
    ADDS  X17, X13, X25, LSR #61
    ADDS  X11, X23, W12, SXTH #2
    FCMPE  D11, D14
    ADDS  W17, W23, #0x39d, LSL #12
    SUBS  X13, X22, #0x0
    SUBS  X17, X22, X11, LSL #34
    ADDS  X11, X6, X11, LSR #9
    ADDS  W8, W25, W6, UXTW #2
    ADDS  W2, W16, #0xaf8, LSL #12
    SUBS  X24, X24, #0x1
    B.NE  TaishanIntCcP01_label_391
    MOVZ  X24, #0x8eea, LSL #0
    MOVK  X24, #0xc0af, LSL #16
    SUB  X16, X24, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x978d, LSL #0
    MOVK  X17, #0x6a9c, LSL #16
    SUB  X19, X17, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x109f, LSL #0
    MOVK  X28, #0xf800, LSL #16
    SUB  X14, X28, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X5, #0xc54, LSL #0
    MOVK  X5, #0x40, LSL #16
    SUB  X2, X5, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X14, #0x9, LSL #0
    MOVK  X14, #0x8000, LSL #16
    SUB  X11, X14, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X19, #0x7d1f, LSL #0
    MOVK  X19, #0xb64e, LSL #16
    SUB  X16, X19, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X13, #0xf927, LSL #0
    MOVK  X13, #0xff10, LSL #16
    SUB  X2, X13, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x1a, LSL #0
    MOVK  X2, #0xc000, LSL #16
    SUB  X19, X2, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X22, #0xf927, LSL #0
    MOVK  X22, #0xff10, LSL #16
    SUB  X16, X22, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X27, #0x9, LSL #0
    MOVK  X27, #0x8000, LSL #16
    SUB  X10, X27, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntCcP01_TestFail
    MOVZ  X11, #0xfddf, LSL #0
    MOVK  X11, #0xffe9, LSL #16
    SUB  X25, X11, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X16
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X6, #0xff28, LSL #0
    MOVK  X6, #0x57b, LSL #16
    SUB  X21, X6, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X15, #0x1a, LSL #0
    MOVK  X15, #0xc000, LSL #16
    MOVK  X15, #0xfffc, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X18, X15, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntCcP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X24
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X25
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X9, #0xa9b9, LSL #0
    MOVK  X9, #0x6d69, LSL #16
    SUB  X19, X9, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X24, X2, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntCcP01_TestFail
    MOVZ  X15, #0x6001, LSL #0
    MOVK  X15, #0x1a, LSL #16
    SUB  X22, X15, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x6809, LSL #0
    MOVK  X2, #0x8c80, LSL #16
    MOVK  X2, #0xdf12, LSL #32
    MOVK  X2, #0x80e0, LSL #48
    MOVZ  X4, #0x191d, LSL #0
    MOVK  X4, #0xb898, LSL #16
    MOVK  X4, #0x492a, LSL #32
    MOVK  X4, #0x8dc9, LSL #48
    MOVZ  X5, #0xe565, LSL #0
    MOVK  X5, #0x7d42, LSL #16
    MOVK  X5, #0xe7c7, LSL #32
    MOVK  X5, #0xe9c0, LSL #48
    MOVZ  X6, #0x985b, LSL #0
    MOVK  X6, #0x435d, LSL #16
    MOVK  X6, #0xe43a, LSL #32
    MOVK  X6, #0x4d0f, LSL #48
    MOVZ  X7, #0x5855, LSL #0
    MOVK  X7, #0xde56, LSL #16
    MOVK  X7, #0x59c2, LSL #32
    MOVK  X7, #0xeee3, LSL #48
    MOVZ  X8, #0x4bac, LSL #0
    MOVK  X8, #0xc837, LSL #16
    MOVK  X8, #0xf865, LSL #32
    MOVK  X8, #0x9871, LSL #48
    MOVZ  X9, #0x1dc, LSL #0
    MOVK  X9, #0x9f5b, LSL #16
    MOVK  X9, #0xe5eb, LSL #32
    MOVK  X9, #0x9787, LSL #48
    MOVZ  X10, #0xf73e, LSL #0
    MOVK  X10, #0x9cca, LSL #16
    MOVK  X10, #0x3926, LSL #32
    MOVK  X10, #0x2a53, LSL #48
    MOVZ  X11, #0x3a8b, LSL #0
    MOVK  X11, #0x125d, LSL #16
    MOVK  X11, #0xe5f5, LSL #32
    MOVK  X11, #0xed61, LSL #48
    MOVZ  X12, #0xec2f, LSL #0
    MOVK  X12, #0x404e, LSL #16
    MOVK  X12, #0x2005, LSL #32
    MOVK  X12, #0xc866, LSL #48
    MOVZ  X13, #0x8050, LSL #0
    MOVK  X13, #0xd9d2, LSL #16
    MOVK  X13, #0xcb7, LSL #32
    MOVK  X13, #0x3753, LSL #48
    MOVZ  X14, #0xf79d, LSL #0
    MOVK  X14, #0x7b44, LSL #16
    MOVK  X14, #0x7a1d, LSL #32
    MOVK  X14, #0xc50f, LSL #48
    MOVZ  X15, #0x2733, LSL #0
    MOVK  X15, #0xf879, LSL #16
    MOVK  X15, #0x14be, LSL #32
    MOVK  X15, #0x6f43, LSL #48
    MOVZ  X16, #0x2caa, LSL #0
    MOVK  X16, #0x2ea5, LSL #16
    MOVK  X16, #0xb321, LSL #32
    MOVK  X16, #0xf543, LSL #48
    MOVZ  X17, #0x9f7f, LSL #0
    MOVK  X17, #0x1c90, LSL #16
    MOVK  X17, #0x26a7, LSL #32
    MOVK  X17, #0xdf0, LSL #48
    MOVZ  X18, #0x5b61, LSL #0
    MOVK  X18, #0x8ec3, LSL #16
    MOVK  X18, #0x63a8, LSL #32
    MOVK  X18, #0x3980, LSL #48
    MOVZ  X19, #0x1534, LSL #0
    MOVK  X19, #0x3c8b, LSL #16
    MOVK  X19, #0xda65, LSL #32
    MOVK  X19, #0x3f38, LSL #48
    MOVZ  X20, #0xdbbf, LSL #0
    MOVK  X20, #0xdc1, LSL #16
    MOVK  X20, #0x6a2c, LSL #32
    MOVK  X20, #0xa8da, LSL #48
    MOVZ  X21, #0x72c8, LSL #0
    MOVK  X21, #0x36e7, LSL #16
    MOVK  X21, #0x6e1e, LSL #32
    MOVK  X21, #0x1762, LSL #48
    MOVZ  X22, #0x47dc, LSL #0
    MOVK  X22, #0xd1fa, LSL #16
    MOVK  X22, #0xbfcc, LSL #32
    MOVK  X22, #0xd6cf, LSL #48
    MOVZ  X23, #0x8ebf, LSL #0
    MOVK  X23, #0xac0e, LSL #16
    MOVK  X23, #0xada3, LSL #32
    MOVK  X23, #0x9c37, LSL #48
    MOVZ  X24, #0x5d8d, LSL #0
    MOVK  X24, #0x2b8a, LSL #16
    MOVK  X24, #0x7330, LSL #32
    MOVK  X24, #0x1a25, LSL #48
    MOVZ  X25, #0x8139, LSL #0
    MOVK  X25, #0xe1ed, LSL #16
    MOVK  X25, #0x5399, LSL #32
    MOVK  X25, #0x6d58, LSL #48
    MOVZ  X26, #0xb48, LSL #0
    MOVK  X26, #0xfd33, LSL #16
    MOVK  X26, #0x8a49, LSL #32
    MOVK  X26, #0x5e1a, LSL #48
    MOVZ  X27, #0x1300, LSL #0
    MOVK  X27, #0x3403, LSL #16
    MOVK  X27, #0xcc3a, LSL #32
    MOVK  X27, #0x8313, LSL #48
    MOVZ  X28, #0xfc4d, LSL #0
    MOVK  X28, #0xaae6, LSL #16
    MOVK  X28, #0xc433, LSL #32
    MOVK  X28, #0x4967, LSL #48
    MOVZ  X29, #0x310d, LSL #0
    MOVK  X29, #0x3c60, LSL #16
    MOVK  X29, #0xfa74, LSL #32
    MOVK  X29, #0x273, LSL #48
    MOVZ  X14, #0x14, LSL #0
TaishanIntCcP01_label_419:
    ADDS  W28, W18, W10, SXTB #0
    ADDS  W21, W25, W23, SXTX #1
    ADDS  X2, X7, X9, LSL #24
    ANDS  W17, W12, W10, ASR #6
    SUBS  W6, W25, #0xee0
    ADDS  X27, X28, W23, SXTB #4
    ADDS  W29, W15, W17, LSR #29
    SUBS  W26, W5, W19, SXTW #2
    ANDS  X24, X24, #0xfe0000000000001f
    SUBS  W23, W29, #0xd8e
    ADDS  W8, W7, W23, ASR #24
    SUBS  W5, W5, W26, SXTB #1
    SUBS  X11, X24, #0x149
    ADDS  X29, X20, #0x41
    ANDS  W8, W20, #0xfffffe7f
    ANDS  W2, W11, #0x66666666
    ADDS  X24, X29, X17, LSR #35
    ANDS  W24, W10, W16, LSL #17
    ADDS  W5, W27, #0x15e
    SUBS  W19, W17, W16, SXTH #1
    ADDS  X29, X26, W24, SXTW #3
    ADDS  W19, W2, W28, SXTX #2
    SUBS  W11, W17, W28, UXTB #1
    ADDS  X27, X2, X16, UXTX #1
    ADDS  W8, W20, W19, ASR #1
    SUBS  X8, X23, #0x0
    ADDS  X15, X14, #0xa00
    ADDS  X15, X15, #0xd10, LSL #12
    SUBS  W25, W10, W2, UXTH #2
    ANDS  W19, W2, W6, ASR #28
    SUBS  W6, W15, #0xc12, LSL #12
    ANDS  W23, W15, #0xff8fff8f
    ANDS  X27, X18, X17, LSR #53
    ANDS  X29, X25, #0x3e0000003e
    SUBS  W5, W14, #0x0
    ANDS  X10, X15, #0xffffffe0007fffff
    ADDS  W7, W7, W4, SXTW #3
    SUBS  X28, X11, X19, UXTX #2
    SUBS  X8, X8, W4, UXTB #1
    ADDS  W15, W7, W29, LSL #14
    ANDS  W9, W6, #0xfc000003
    ADDS  X13, X23, W28, SXTB #1
    ANDS  W24, W24, #0x3ffffffc
    SUBS  X5, X2, X26, LSR #40
    SUBS  X26, X7, #0x2c4, LSL #12
    SUBS  W16, W16, #0x950
    SUBS  X16, X15, #0x98
    SUBS  W23, W27, W19, SXTB #0
    ANDS  W16, W28, #0xbbbbbbbb
    ANDS  W11, W28, W14, ASR #24
    SUBS  X8, X25, W5, UXTW #0
    SUBS  X21, X5, X7, ASR #56
    ADDS  W21, W24, W9, ASR #23
    ADDS  W7, W6, W14, UXTX #3
    ADDS  W13, W16, W26, SXTW #1
    FCMPE  D29, D11
    ANDS  X7, X2, #0xff80000000000fff
    ADDS  X8, X14, W15, SXTH #0
    ADDS  X21, X16, #0x4b0
    FCMP  S16, S2
    SUBS  W7, W29, W16, UXTX #4
    ADDS  W23, W9, #0x1a0
    ANDS  X18, X18, #0x1fc00000
    SUBS  W2, W29, #0x10
    SUBS  W13, W25, W10, ASR #5
    SUBS  W11, W22, #0xfd8
    ADDS  W22, W23, W13, ASR #19
    ANDS  W8, W19, #0xc3c3c3c3
    ANDS  X17, X14, X20, LSL #3
    SUBS  X22, X9, X26, LSL #37
    ADDS  X16, X11, X7, ASR #53
    SUBS  X27, X23, X27, ASR #30
    SUBS  W8, W25, #0xda
    ADDS  W22, W8, #0x931, LSL #12
    SUBS  X25, X4, X4, LSL #43
    SUBS  X2, X13, #0x912, LSL #12
    ANDS  W22, W22, W24, LSL #15
    SUBS  X25, X25, X17, UXTX #1
    ADDS  W26, W12, W19, SXTB #1
    ANDS  X12, X8, #0x3ff800003ff8000
    SUBS  W8, W18, W27, SXTW #2
    ADDS  W29, W28, W4, ASR #9
    ADDS  W17, W29, W11, SXTX #1
    ADDS  X18, X10, W6, SXTB #2
    FCMP  S8, S17
    ANDS  W23, W12, W6, ROR #1
    SUBS  W24, W21, W6, SXTH #0
    ANDS  X7, X11, X6, ASR #1
    ANDS  X13, X12, X11, LSL #57
    ADDS  X12, X26, W21, SXTH #0
    ADDS  X12, X2, #0xfa0
    ANDS  X26, X17, X8, ASR #48
    SUBS  W16, W27, #0x45d
    SUBS  W9, W9, W11, ASR #21
    SUBS  W8, W24, W21, UXTB #2
    SUBS  X20, X28, W19, SXTB #3
    ADDS  X12, X4, W26, UXTW #0
    FCMPE  D4, #0.0
    SUBS  X22, X17, X21, ASR #40
    FCMPE  D27, #0.0
    ANDS  W19, W11, #0x80000000
    ADDS  W16, W15, W6, LSL #14
    SUBS  X28, X23, X12, ASR #14
    ADDS  W25, W6, W8, UXTW #0
    ANDS  W10, W20, W9
    ANDS  W9, W20, W17, LSL #7
    SUBS  W17, W27, W22, SXTB #0
    SUBS  X10, X25, #0x150
    FCMP  S10, #0.0
    ADDS  X4, X11, X8, ASR #61
    ADDS  X10, X26, #0x620
    FCMPE  D8, D12
    ANDS  X4, X7, #0x1ff000001ff00000
    SUBS  W27, W13, W15, SXTW #2
    SUBS  X25, X11, #0xb60
    SUBS  W13, W17, #0x814, LSL #12
    ADDS  X5, X21, #0xaa7
    FCMP  D9, #0.0
    ADDS  X29, X6, W16, SXTW #0
    ADDS  X8, X2, W15, UXTB #2
    ADDS  W9, W5, #0x8
    ADDS  W16, W25, #0x857, LSL #12
    ANDS  X21, X24, #0xfc0000000000007f
    FCMP  D6, #0.0
    ANDS  X20, X24, #0xfffffff1fffffff1
    SUBS  W20, W10, W25, UXTX #3
    SUBS  X17, X21, #0x30
    SUBS  X26, X18, X19, LSR #22
    ADDS  W24, W20, W22, SXTH #4
    SUBS  X18, X22, X25, LSL #55
    ANDS  X4, X14, X10, LSL #12
    ADDS  W20, W23, W21, UXTX #1
    SUBS  W23, W23, W20, UXTB #1
    SUBS  X22, X19, X25, UXTX #1
    ANDS  X6, X23, X27, LSR #0
    ADDS  W17, W22, W9, SXTW #3
    SUBS  X22, X15, #0x7cc, LSL #12
    ADDS  X11, X6, W24, UXTB #2
    ANDS  W8, W10, W15, ROR #12
    SUBS  W24, W17, #0x720
    ADDS  X5, X9, X11, ASR #50
    ADDS  X9, X10, #0xa3
    ADDS  X25, X9, X9, LSR #60
    SUBS  W10, W13, #0xf51
    FCMPE  D22, D26
    ANDS  X25, X22, #0xfffe3ffffffe3fff
    SUBS  W18, W22, W4, LSL #22
    SUBS  X7, X25, #0x61d, LSL #12
    ADDS  X21, X7, #0xbbe, LSL #12
    ADDS  X25, X27, X21, ASR #32
    ADDS  X25, X23, X25, LSL #46
    ADDS  X5, X13, W11, SXTH #2
    ADDS  X5, X4, #0x290
    ADDS  W19, W23, W5, LSL #30
    ADDS  X28, X11, #0x3f0
    SUBS  W19, W26, W14, ASR #17
    SUBS  X22, X22, X14, UXTX #2
    ADDS  X8, X24, X9, ASR #44
    ANDS  X21, X15, X25, LSL #22
    SUBS  W20, W23, W20, LSL #24
    ADDS  W22, W28, W23, LSL #18
    ANDS  X29, X25, #0xaaaaaaaaaaaaaaaa
    ADDS  X11, X13, X27, ASR #29
    ADDS  W27, W8, W15, SXTW #2
    ANDS  W23, W14, #0x7fc07fc
    ANDS  W23, W20, #0xcfcfcfcf
    FCMP  D11, #0.0
    SUBS  W24, W27, W23, UXTH #2
    SUBS  W26, W4, #0x931, LSL #12
    ADDS  W18, W21, W2, ASR #8
    ADDS  W28, W4, W9, LSR #17
    SUBS  X29, X23, X4, ASR #56
    ANDS  W13, W12, W18, LSR #8
    ADDS  X4, X9, #0xf95, LSL #12
    SUBS  W27, W6, W14, UXTW #1
    ADDS  X6, X14, X20, LSL #33
    FCMPE  D10, #0.0
    ADDS  W15, W11, W7, SXTH #3
    SUBS  X2, X7, X23, LSL #9
    SUBS  X8, X23, X5, LSR #6
    ADDS  X25, X11, X29, LSL #51
    ADDS  X29, X21, X25, LSL #22
    ANDS  X26, X21, X11, LSR #30
TaishanIntCcP01_label_190:
    ADDS  X18, X6, W23, SXTB #3
    SUBS  W17, W27, W17, LSL #9
    ADDS  X26, X9, #0x942, LSL #12
    SUBS  W28, W21, W21, SXTB #3
    ANDS  X20, X27, #0x3ffffff83ffffff8
    ADDS  W26, W17, #0x54e
    ADDS  W10, W20, #0x313
    ANDS  W10, W7, #0x55555555
    ANDS  X11, X7, X2, ASR #36
    SUBS  X25, X23, X18, LSL #53
    SUBS  X6, X20, X27, LSL #29
    ANDS  W26, W24, #0x3c003c
    FCMP  D13, #0.0
    ANDS  W24, W29, W27, ROR #11
    ADDS  W6, W5, W27, LSR #13
    ADDS  W13, W28, W8, ASR #3
    SUBS  W28, W21, W4, LSR #2
    SUBS  X14, X14, #0x1
    B.NE  TaishanIntCcP01_label_419
    MOVZ  X25, #0xd505, LSL #0
    MOVK  X25, #0x230f, LSL #16
    MOVK  X25, #0xffe8, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X26, X25, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x56c3, LSL #0
    MOVK  X8, #0xf9, LSL #16
    SUB  X20, X8, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X29, #0x290, LSL #0
    SUB  X22, X29, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x291, LSL #0
    SUB  X25, X13, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x6505, LSL #0
    MOVK  X28, #0x26ac, LSL #16
    SUB  X2, X28, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X27, #0x56c3, LSL #0
    MOVK  X27, #0xf9, LSL #16
    SUB  X12, X27, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X15, #0x6c3, LSL #0
    SUB  X26, X15, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X20, #0x4505, LSL #0
    MOVK  X20, #0x404, LSL #16
    SUB  X26, X20, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x6504, LSL #0
    MOVK  X28, #0x26ac, LSL #16
    SUB  X4, X28, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X14, #0x291, LSL #0
    SUB  X6, X14, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X12, #0x291, LSL #0
    SUB  X29, X12, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X12, #0x9ebc, LSL #0
    MOVK  X12, #0xfc97, LSL #16
    SUB  X14, X12, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X25, #0xfa66, LSL #0
    MOVK  X25, #0x1c99, LSL #16
    SUB  X11, X25, X17
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X6, #0x241, LSL #0
    MOVK  X6, #0xfcf0, LSL #32
    MOVK  X6, #0x7803, LSL #48
    SUB  X25, X6, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x805, LSL #0
    MOVK  X17, #0x51, LSL #16
    SUB  X5, X17, X19
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntCcP01_TestFail
    MOVZ  X10, #0x4505, LSL #0
    MOVK  X10, #0x404, LSL #16
    SUB  X20, X10, X20
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x600, LSL #16
    SUB  X8, X15, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntCcP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntCcP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x4880, LSL #16
    SUB  X29, X22, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X18, X7, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntCcP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X14, X11, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X21, #0x56c3, LSL #0
    MOVK  X21, #0xf9, LSL #16
    SUB  X25, X21, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X19, #0x6504, LSL #0
    MOVK  X19, #0x26ac, LSL #16
    SUB  X17, X19, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
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
    MOVZ  X25, #0x14, LSL #0
TaishanIntCcP01_label_447:
    SUBS  W16, W27, #0x514, LSL #12
    ADDS  W18, W28, W10, UXTB #3
    ADDS  W12, W18, W11, LSR #27
    SUBS  W4, W23, W29, SXTW #4
    ADDS  X4, X29, X17, LSL #19
    SUBS  X16, X9, X29, ASR #36
    ADDS  X11, X14, W26, UXTW #3
    ADDS  W23, W25, W7, LSL #6
    ANDS  X28, X14, X29, ASR #38
    ANDS  W4, W12, #0xfffdfffd
    SUBS  X2, X16, #0x9ed, LSL #12
    SUBS  W6, W14, W13, UXTB #0
    ANDS  X28, X5, X21, LSR #15
    SUBS  W21, W28, W23, ASR #14
    ADDS  X6, X10, W25, UXTW #0
    ANDS  X20, X7, #0x1ffc00001ffc00
    SUBS  W23, W6, W18
    ANDS  W22, W10, #0x33333333
    ADDS  X18, X25, #0xe1d
    SUBS  W26, W12, #0xa5a
    SUBS  X8, X24, W27, SXTW #0
    SUBS  W12, W4, W17, LSR #26
    ADDS  X13, X4, X24, LSR #40
    ANDS  X12, X8, #0x3838383838383838
    SUBS  W12, W7, W20, SXTB #2
    ADDS  W2, W27, #0x587
    SUBS  W5, W2, W16, UXTB #2
    ANDS  X12, X21, #0xcfffcfffcfffcfff
    ADDS  X18, X20, X11, ASR #5
    SUBS  W29, W18, W23, ASR #31
    ANDS  X4, X27, #0xfe000000fe
    SUBS  X24, X12, X17, LSL #52
    ADDS  W5, W6, #0x2a
    ADDS  X28, X12, #0xbeb, LSL #12
    SUBS  X13, X28, X17, LSR #56
    ANDS  X12, X5, X14, LSL #8
    SUBS  W27, W12, #0x213, LSL #12
    SUBS  W7, W14, #0xe59, LSL #12
    FCMP  D31, D15
    SUBS  X7, X7, W19, SXTH #4
    ADDS  W22, W10, #0x358
    SUBS  X11, X5, #0x30
    SUBS  X23, X6, X24, LSR #54
    SUBS  X29, X10, W8, SXTB #1
    SUBS  X14, X7, #0xb00
    ADDS  X29, X2, #0x97d
    SUBS  W27, W26, #0xc80
    ADDS  W18, W8, W4, LSR #8
    FCMP  D10, #0.0
    ADDS  X23, X4, X10, ASR #14
    SUBS  X6, X21, #0x0
    SUBS  W23, W26, W11, SXTB #1
    SUBS  X2, X15, X22, LSR #2
    ANDS  W17, W18, #0x7fc07fc0
    ANDS  W15, W22, #0xf0f0f0f
    SUBS  W15, W17, W8, SXTH #1
    SUBS  W17, W18, W22, ASR #27
    ANDS  W14, W17, #0xe1e1e1e1
    SUBS  W19, W2, #0xe06
    SUBS  X24, X22, #0x310
    SUBS  X14, X10, X6, LSL #8
    SUBS  X23, X23, X11, ASR #43
    ADDS  X23, X21, W22, UXTB #1
    SUBS  X27, X15, W4, SXTH #2
    SUBS  W12, W27, W26, ASR #5
    ADDS  W8, W7, #0x45e, LSL #12
    ADDS  X18, X2, #0x472, LSL #12
    ADDS  W20, W17, W21, SXTB #2
    ANDS  W20, W21, #0x7ff00000
    SUBS  W18, W21, W2, LSL #23
    SUBS  W17, W5, W23, LSR #11
    ADDS  W12, W8, #0x4d0
    ADDS  W8, W17, W7, LSL #24
    ANDS  W5, W15, W26, ASR #25
    ADDS  X12, X10, X24, LSR #13
    ANDS  W27, W21, #0x7fe07fe
    ADDS  W19, W19, W20, LSR #24
    SUBS  X23, X24, X29, LSL #16
    SUBS  X23, X6, #0xbf1
    ANDS  W21, W12, #0xf0fff0ff
    SUBS  X8, X22, X18, UXTX #2
    ANDS  X26, X13, #0xf83ffffff83fffff
    SUBS  W2, W5, W18, LSL #9
    FCMPE  D12, #0.0
    ADDS  X17, X12, #0x91f, LSL #12
    ANDS  X17, X10, #0x1fffe
    ANDS  X23, X20, X2, ASR #50
    SUBS  X15, X13, X2, ASR #9
    ANDS  X27, X29, X15, ROR #51
    ADDS  W10, W21, W16, LSR #18
    ADDS  X10, X22, X17, LSR #49
    ADDS  X27, X16, X26, LSR #27
    SUBS  X16, X25, X17, UXTX #3
    SUBS  W12, W19, W22, LSL #14
    ANDS  W16, W12, W29, ROR #31
    ADDS  W18, W4, W12, UXTH #0
    SUBS  W19, W21, W8, UXTB #0
    ADDS  X21, X19, #0xd38, LSL #12
    ANDS  W8, W20, #0x99999999
    FCMP  S15, S14
    ANDS  W13, W26, W27, ASR #14
    SUBS  X27, X10, X2, UXTX #0
    ANDS  W29, W17, W23, ASR #10
    ANDS  W17, W23, W23, LSL #27
    ANDS  W24, W25, #0x83838383
    ANDS  W12, W26, #0xfc03fc03
    ADDS  X24, X22, #0xa7a, LSL #12
    SUBS  W6, W2, W18, LSL #12
    SUBS  X21, X17, #0xe3
    ANDS  W16, W24, W27, ASR #20
    SUBS  W6, W10, W5, LSL #5
    SUBS  X10, X28, W16, SXTB #0
    SUBS  W21, W12, W4, UXTB #4
    FCMP  D27, #0.0
    SUBS  W18, W19, #0x80e, LSL #12
    ADDS  W14, W20, W8, SXTW #3
    FCMP  S26, S29
    SUBS  W2, W24, W16, ASR #0
    SUBS  W20, W25, W16, SXTH #3
    SUBS  X5, X8, X6, ASR #14
    SUBS  W19, W23, W21, UXTH #2
    ANDS  X11, X19, X18, ROR #24
    ANDS  X9, X4, X12, LSL #33
    ADDS  X10, X28, W9, UXTH #3
    ADDS  W21, W19, W16, SXTB #1
    SUBS  X19, X4, X28, LSL #11
    ADDS  X16, X17, X21, SXTX #4
    ANDS  W4, W19, W26, ROR #24
    SUBS  X21, X17, W14, UXTW #2
    ANDS  W10, W18, W16, LSR #24
    SUBS  W9, W12, W22, UXTB #3
    SUBS  W12, W16, W25, UXTW #4
    SUBS  W28, W29, W14, SXTX #3
    SUBS  X2, X22, X20, SXTX #0
    ADDS  X13, X11, #0x4b0
    SUBS  W26, W5, W23, LSL #9
    ADDS  X6, X9, W22, SXTB #0
    FCMP  S4, S9
    ANDS  X18, X4, #0xc001ffffffffffff
    ADDS  X7, X8, X4, ASR #20
    ADDS  W10, W22, #0xd51
    ADDS  W4, W21, W6, LSR #30
    FCMP  S2, #0.0
    SUBS  X21, X12, X7, ASR #47
    ADDS  X5, X13, W25, UXTH #3
    ADDS  X19, X11, X16, UXTX #1
    ANDS  W23, W24, W4, LSL #5
    ANDS  X28, X15, #0x7fffffe0000
    ANDS  W10, W20, W25, ASR #9
    SUBS  W17, W18, W24, SXTH #0
    SUBS  X2, X10, X2, LSR #46
    ADDS  X9, X29, W19, SXTH #4
    SUBS  X9, X6, W17, UXTH #4
    ANDS  W2, W2, W11, ASR #3
    SUBS  W14, W8, W29, LSR #0
    ADDS  X6, X21, #0x9fc
    ADDS  X5, X11, X16, SXTX #0
    SUBS  W17, W27, W20, SXTH #1
    ANDS  X23, X19, X2, ROR #58
    ANDS  W11, W17, #0xffff800f
    ADDS  X16, X20, #0xf11
    SUBS  W14, W13, W21, UXTX #4
    ADDS  W21, W10, #0xb10
    SUBS  W28, W28, W6, UXTH #2
    ANDS  X26, X23, X12, ASR #42
    SUBS  X15, X25, #0x8c7
    SUBS  W20, W4, W22, SXTH #0
    SUBS  X24, X17, X16, LSR #48
    ADDS  W9, W16, #0x761
    SUBS  W19, W26, W13, SXTH #3
    SUBS  W13, W11, W29, LSL #1
    SUBS  W6, W23, #0x998, LSL #12
    ANDS  W6, W4, #0xfc1ffc1f
    SUBS  W5, W22, W12, ASR #26
    SUBS  X16, X12, X6, UXTX #3
    ADDS  X19, X23, #0xe80
    ANDS  X19, X24, X7, LSL #37
    SUBS  W26, W24, #0xd0
    FCMPE  D6, D24
    ADDS  W5, W4, W25, SXTW #1
    FCMP  S25, S26
    ADDS  W16, W27, W29, SXTW #0
    ANDS  W13, W8, W27, ROR #25
    ADDS  W22, W14, #0x430
    ADDS  W27, W13, W9, UXTW #4
    ADDS  W26, W4, W24, SXTH #4
    ADDS  W10, W11, W28, UXTW #2
    ADDS  W23, W12, W12, UXTB #3
    ANDS  X26, X15, X13, ROR #19
    SUBS  X13, X24, X24, LSL #39
    ANDS  X29, X23, X19, ASR #6
    ANDS  X7, X21, X14, ROR #42
    SUBS  X27, X7, W14, UXTW #0
    ADDS  X15, X10, X20, LSR #10
    ANDS  W16, W17, #0xefffefff
    ANDS  W2, W12, #0xffe0ffe
    SUBS  W26, W9, W13, ASR #2
    ADDS  X19, X9, #0x494, LSL #12
    ADDS  W10, W17, W13, ASR #30
    ANDS  X22, X19, #0x40004000400040
    SUBS  X25, X25, #0x1
    B.NE  TaishanIntCcP01_label_447
    MOVZ  X4, #0xff0, LSL #0
    MOVK  X4, #0xfd4, LSL #16
    SUB  X28, X4, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X24, #0xff0, LSL #0
    MOVK  X24, #0xfd4, LSL #16
    SUB  X15, X24, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X29, #0x2, LSL #0
    SUB  X14, X29, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X6
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntCcP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x413b, LSL #0
    SUB  X18, X17, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntCcP01_TestFail
    MOVZ  X8, #0xb, LSL #0
    SUB  X2, X8, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X27, #0x3ff0, LSL #0
    MOVK  X27, #0xffd5, LSL #16
    SUB  X19, X27, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X15, #0x413b, LSL #0
    MOVK  X15, #0x6280, LSL #32
    MOVK  X15, #0xffdf, LSL #48
    SUB  X16, X15, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X14
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X22, #0x413b, LSL #0
    MOVK  X22, #0x6280, LSL #32
    MOVK  X22, #0xffdf, LSL #48
    SUB  X25, X22, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X16
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X19, #0x413b, LSL #0
    SUB  X11, X19, X17
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X20, X28, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X21, #0x413b, LSL #0
    SUB  X4, X21, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X6, #0x413b, LSL #0
    SUB  X4, X6, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntCcP01_TestFail
    MOVZ  X20, #0x413b, LSL #0
    MOVK  X20, #0x6280, LSL #32
    MOVK  X20, #0xffdf, LSL #48
    SUB  X10, X20, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntCcP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X13, X18, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntCcP01_TestFail
    MOVZ  X13, #0xff0, LSL #0
    MOVK  X13, #0xfd4, LSL #16
    SUB  X10, X13, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X7, #0x625, LSL #0
    SUB  X2, X7, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X11, #0x3ff0, LSL #0
    MOVK  X11, #0xffd5, LSL #16
    SUB  X23, X11, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x0, LSL #0
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
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X8, #0x14, LSL #0
TaishanIntCcP01_label_475:
    ANDS  W13, W8, #0xf7f7f7f7
    SUBS  W23, W24, #0x342, LSL #12
    SUBS  W12, W2, W18, LSL #25
    SUBS  W25, W23, #0x9d3, LSL #12
    ADDS  W19, W9, W6, LSR #3
    ADDS  W27, W21, #0x450
    ANDS  X19, X11, #0x3ff000003ff
    SUBS  W17, W26, #0x0
    SUBS  X4, X21, X23, LSR #35
    SUBS  W4, W13, W20, UXTW #4
    ADDS  X4, X4, X25, LSL #21
    SUBS  W4, W25, W20, LSR #30
    SUBS  W23, W24, W5, SXTH #0
    SUBS  X21, X15, #0xd84, LSL #12
    FCMP  S15, S17
    ADDS  X4, X12, X26, LSR #19
    ADDS  X11, X26, X10, LSR #10
    ADDS  W29, W11, W13, LSL #8
    SUBS  X6, X29, #0x720
    SUBS  W26, W8, W27, UXTB #4
    SUBS  X23, X25, #0x1c5, LSL #12
    ANDS  X5, X2, #0xffffc000ffffc
    SUBS  W20, W29, W24, SXTH #1
    ANDS  X17, X9, X8, LSR #47
    SUBS  W16, W19, W29, SXTX #4
    SUBS  X12, X27, W29, SXTW #3
    SUBS  W7, W12, W6, UXTH #2
    SUBS  W22, W18, #0x795, LSL #12
    SUBS  X6, X16, #0xb6, LSL #12
    SUBS  W5, W25, #0xbbe
    ANDS  W16, W2, W22, LSL #3
    ANDS  X4, X22, #0xe007e007e007e007
    SUBS  W17, W18, #0x9bb
    ADDS  W23, W25, W10, SXTW #2
    ADDS  X7, X11, W20, UXTH #2
    ADDS  W2, W2, W26, LSR #26
    ADDS  X14, X4, X25, LSR #16
    SUBS  W19, W28, W13, LSR #18
    ANDS  X18, X20, X28, LSL #8
    ANDS  X7, X16, #0xfffffffffffe00
    ANDS  W5, W5, #0xc3c3c3c3
    SUBS  W14, W12, W23, LSL #13
    ADDS  W19, W19, W18, SXTH #3
    SUBS  X19, X12, W6, SXTB #1
    FCMP  D26, D9
    ADDS  X11, X4, #0x610
    SUBS  X4, X19, #0xc71, LSL #12
    FCMPE  D19, #0.0
    SUBS  W12, W9, W12, LSL #26
    SUBS  W10, W2, #0x95a, LSL #12
    SUBS  W19, W27, #0x2d0
    ADDS  X29, X10, X14, LSL #10
    ADDS  W14, W15, W22, LSR #5
    ANDS  X5, X12, #0x101010101010101
    SUBS  W19, W12, W13, ASR #24
    ANDS  X5, X26, X25, ASR #34
    ANDS  X25, X24, X19, LSR #1
    ADDS  X26, X28, W17, SXTB #3
    ADDS  X25, X5, X19, UXTX #2
    SUBS  X25, X8, X14, LSL #11
    ANDS  X19, X9, #0x3f80000000000
    ANDS  W7, W16, W23, ROR #16
    SUBS  W28, W27, W18, LSL #25
    SUBS  X5, X29, X27, ASR #0
    ANDS  X28, X26, X25, LSL #62
    ANDS  X12, X8, #0x7fe0000000
    FCMP  S30, #0.0
    ADDS  X28, X12, X29, LSR #46
    ADDS  X16, X2, X28, SXTX #0
    SUBS  W24, W7, W8, ASR #21
    SUBS  W19, W19, W7, UXTB #1
    ADDS  X11, X21, X5, ASR #24
    ANDS  W14, W28, #0x6060606
    ADDS  X2, X27, X13, LSR #50
    ADDS  X18, X10, #0xeba, LSL #12
    ADDS  W29, W24, W9, LSL #26
    ANDS  W11, W23, W6, ASR #9
    ANDS  W10, W24, #0xc00001ff
    SUBS  X23, X25, X19, LSR #62
    SUBS  W26, W17, #0x228, LSL #12
    SUBS  X26, X18, W19, UXTW #0
    ADDS  X10, X15, #0xe54, LSL #12
    SUBS  W10, W26, W6, LSL #16
    ANDS  W29, W13, W10, LSL #22
    ANDS  W20, W16, #0xfc00fc0
    ANDS  X5, X11, #0x1ffffe000000
    SUBS  W20, W5, W13, UXTH #2
    SUBS  X6, X5, X8, LSL #40
    SUBS  W4, W20, W23, UXTW #4
    ANDS  W18, W17, W5, LSR #9
    ANDS  W6, W16, #0xc00007ff
    FCMPE  S20, #0.0
    FCMPE  S19, S28
    FCMPE  S6, S30
    ADDS  X28, X2, W8, UXTH #2
    ADDS  W13, W16, W27, ASR #16
    SUBS  X4, X16, W26, SXTW #1
    ADDS  X24, X12, X4, LSR #28
    SUBS  X4, X16, W23, UXTH #4
    ADDS  X18, X25, W9, SXTW #3
    SUBS  X26, X18, W17, UXTB #2
    SUBS  W27, W20, #0x8c1, LSL #12
    ADDS  X23, X16, #0xf3c, LSL #12
    SUBS  X9, X24, W28, UXTW #2
    ADDS  W19, W2, #0xb3b, LSL #12
    ANDS  W26, W10, W28, LSR #14
    ADDS  W5, W19, #0x8d2
    ADDS  W25, W6, #0xe79
    ADDS  W10, W25, #0x840
    ANDS  X10, X16, X19, ASR #43
    ADDS  X2, X29, #0x593, LSL #12
    ADDS  W17, W9, W19, LSL #3
    SUBS  W7, W15, W13, ASR #10
    ADDS  W19, W13, W28, LSR #1
    FCMPE  D22, D29
    SUBS  W27, W7, W24, UXTW #4
    ANDS  W23, W26, #0xc001c001
    ADDS  W7, W25, W15, LSR #11
    ADDS  W12, W26, W29, SXTW #2
    ANDS  X17, X20, X20, ROR #61
    ADDS  X27, X16, X13, ASR #45
    SUBS  W17, W22, W19, ASR #23
    ADDS  W9, W22, W29, UXTB #4
    ANDS  X23, X27, X16, ROR #20
    ADDS  W25, W13, W19, SXTB #0
    ADDS  W11, W21, W9, SXTX #0
    SUBS  X2, X13, X15, LSR #60
    SUBS  W10, W12, W24, SXTX #2
    ADDS  W26, W11, W10, ASR #10
    ADDS  W27, W17, #0xbb5
    ANDS  W9, W9, W24, ROR #14
    SUBS  X2, X24, X29, SXTX #4
    FCMP  S20, S28
    SUBS  X29, X25, X22, LSL #32
    SUBS  W18, W18, W24, UXTX #0
    FCMP  S27, #0.0
    SUBS  X23, X28, W19, SXTH #3
    ANDS  W22, W22, W18, LSR #26
    SUBS  W18, W4, W11, LSL #22
    ADDS  W22, W2, W15, UXTX #2
    ANDS  W7, W11, W18, LSL #11
    SUBS  X15, X23, #0x731
    SUBS  W20, W27, W7, LSR #16
    ANDS  W23, W17, W5, LSL #21
    SUBS  W23, W28, #0x812, LSL #12
    ANDS  X21, X22, X4, ASR #42
    ANDS  W17, W25, #0x80003fff
    SUBS  X2, X24, X11, LSL #42
    SUBS  W18, W29, #0xca0
    FCMPE  S20, #0.0
    ADDS  X6, X19, X5, SXTX #1
    ADDS  W13, W8, #0xf67, LSL #12
    ANDS  W28, W16, W27, ROR #21
    SUBS  X10, X16, #0x0
    ANDS  W10, W20, #0xc0000fff
    SUBS  X21, X21, W18, UXTH #2
    ANDS  X13, X18, X15, LSR #51
    ADDS  X26, X27, W14, UXTB #3
    SUBS  W28, W6, W4, LSL #1
    ADDS  W28, W27, #0x14c, LSL #12
    ADDS  W20, W9, #0xf20
    SUBS  X25, X8, X7, LSL #59
    ANDS  W21, W27, #0xc000
    SUBS  W15, W25, W10, UXTB #3
    SUBS  W13, W17, W26, LSL #15
    SUBS  W12, W28, #0xe60
    SUBS  X20, X6, W4, SXTB #2
    SUBS  X9, X16, W12, SXTB #2
    SUBS  X5, X20, #0x8fc, LSL #12
    SUBS  W17, W11, W25, LSR #25
    ADDS  W14, W16, W5, SXTB #4
    SUBS  X17, X9, X6, LSL #54
    ANDS  W4, W13, W4, LSL #20
    SUBS  W2, W15, W7, LSR #24
    ANDS  W4, W15, #0xe07fe07f
    ADDS  X12, X11, #0x7af
    SUBS  W14, W2, W18, ASR #2
    SUBS  X25, X21, #0xf00
    ADDS  W28, W4, W11, SXTW #2
    SUBS  X16, X11, #0x8b2, LSL #12
    ANDS  W13, W19, #0x300
    SUBS  W6, W5, #0x79f, LSL #12
    ANDS  W5, W19, #0xfc07fc07
    SUBS  W2, W12, #0x587, LSL #12
    SUBS  W2, W22, W26, ASR #2
    SUBS  W26, W27, W12, SXTW #0
    ADDS  X28, X2, X4, SXTX #1
    ANDS  X9, X21, X10, LSR #41
    ANDS  W22, W24, W17, ASR #1
    SUBS  W24, W5, #0x82e, LSL #12
    SUBS  X12, X17, #0xdd6, LSL #12
    SUBS  X29, X27, X20, SXTX #0
    ADDS  X27, X17, X26, LSR #54
    SUBS  W5, W17, #0xd00
    SUBS  W27, W15, W29, UXTW #1
    SUBS  X20, X21, X28, ASR #15
    ADDS  W10, W6, W11, ASR #2
    ADDS  W17, W4, #0xae2, LSL #12
    SUBS  W9, W19, W28, LSR #19
    SUBS  W12, W10, #0xde4
    SUBS  X8, X8, #0x1
    B.NE  TaishanIntCcP01_label_475
    MOVZ  X22, #0x3e23, LSL #0
    MOVK  X22, #0x18, LSL #16
    SUB  X15, X22, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X6, #0xe069, LSL #0
    MOVK  X6, #0xe07f, LSL #16
    SUB  X22, X6, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X11, #0x2351, LSL #0
    MOVK  X11, #0x18, LSL #16
    SUB  X24, X11, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntCcP01_TestFail
    MOVZ  X22, #0xe069, LSL #0
    MOVK  X22, #0xe07f, LSL #16
    SUB  X26, X22, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X10, #0x2000, LSL #0
    MOVK  X10, #0x7040, LSL #16
    SUB  X6, X10, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X22, #0x7925, LSL #0
    MOVK  X22, #0x18, LSL #16
    SUB  X29, X22, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X15, #0x2000, LSL #0
    MOVK  X15, #0x7040, LSL #16
    SUB  X6, X15, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x2351, LSL #0
    MOVK  X23, #0x18, LSL #16
    SUB  X16, X23, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X12, #0x762d, LSL #0
    MOVK  X12, #0x29, LSL #16
    SUB  X18, X12, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntCcP01_TestFail
    MOVZ  X4, #0x100, LSL #0
    SUB  X17, X4, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X18, #0xf048, LSL #0
    MOVK  X18, #0xfff9, LSL #16
    SUB  X27, X18, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x2000, LSL #0
    MOVK  X2, #0x7040, LSL #16
    SUB  X28, X2, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X17
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntCcP01_TestFail
    MOVZ  X29, #0xf048, LSL #0
    MOVK  X29, #0xfff9, LSL #16
    SUB  X12, X29, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x9147, LSL #0
    MOVK  X8, #0x18, LSL #16
    SUB  X9, X8, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntCcP01_TestFail
    MOVZ  X6, #0x3dd1, LSL #0
    MOVK  X6, #0xfffd, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X27, X6, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntCcP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X21
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X4, #0x7925, LSL #0
    MOVK  X4, #0x18, LSL #16
    SUB  X21, X4, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X15, #0x2351, LSL #0
    MOVK  X15, #0x18, LSL #16
    SUB  X5, X15, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntCcP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X23, #0xb100, LSL #0
    SUB  X29, X23, X25
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntCcP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntCcP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x55d6, LSL #0
    MOVK  X2, #0x9350, LSL #16
    MOVK  X2, #0xa27e, LSL #32
    MOVK  X2, #0xf0b0, LSL #48
    MOVZ  X4, #0x67ba, LSL #0
    MOVK  X4, #0x7d42, LSL #16
    MOVK  X4, #0x14a6, LSL #32
    MOVK  X4, #0x1dfc, LSL #48
    MOVZ  X5, #0x7495, LSL #0
    MOVK  X5, #0x272c, LSL #16
    MOVK  X5, #0xe6c7, LSL #32
    MOVK  X5, #0xf040, LSL #48
    MOVZ  X6, #0x4791, LSL #0
    MOVK  X6, #0x9105, LSL #16
    MOVK  X6, #0xa0ea, LSL #32
    MOVK  X6, #0xa29e, LSL #48
    MOVZ  X7, #0x1c55, LSL #0
    MOVK  X7, #0x9336, LSL #16
    MOVK  X7, #0x5975, LSL #32
    MOVK  X7, #0xdcdf, LSL #48
    MOVZ  X8, #0xda67, LSL #0
    MOVK  X8, #0x8f91, LSL #16
    MOVK  X8, #0x5be5, LSL #32
    MOVK  X8, #0x269d, LSL #48
    MOVZ  X9, #0xf153, LSL #0
    MOVK  X9, #0x8e5c, LSL #16
    MOVK  X9, #0xe5c4, LSL #32
    MOVK  X9, #0x1a71, LSL #48
    MOVZ  X10, #0xcd84, LSL #0
    MOVK  X10, #0x1350, LSL #16
    MOVK  X10, #0xd687, LSL #32
    MOVK  X10, #0x8d9c, LSL #48
    MOVZ  X11, #0xcace, LSL #0
    MOVK  X11, #0xcd1d, LSL #16
    MOVK  X11, #0x300a, LSL #32
    MOVK  X11, #0xf24d, LSL #48
    MOVZ  X12, #0x7c87, LSL #0
    MOVK  X12, #0xb0e6, LSL #16
    MOVK  X12, #0x3a62, LSL #32
    MOVK  X12, #0x88d0, LSL #48
    MOVZ  X13, #0x6152, LSL #0
    MOVK  X13, #0x7113, LSL #16
    MOVK  X13, #0x8a52, LSL #32
    MOVK  X13, #0x8ac4, LSL #48
    MOVZ  X14, #0x89a5, LSL #0
    MOVK  X14, #0x44ae, LSL #16
    MOVK  X14, #0xe326, LSL #32
    MOVK  X14, #0xcdbe, LSL #48
    MOVZ  X15, #0x5d12, LSL #0
    MOVK  X15, #0x6b41, LSL #16
    MOVK  X15, #0x706f, LSL #32
    MOVK  X15, #0xbfff, LSL #48
    MOVZ  X16, #0xcc2d, LSL #0
    MOVK  X16, #0xe5f0, LSL #16
    MOVK  X16, #0xdcb2, LSL #32
    MOVK  X16, #0x8b43, LSL #48
    MOVZ  X17, #0x46ca, LSL #0
    MOVK  X17, #0x9f57, LSL #16
    MOVK  X17, #0x6aba, LSL #32
    MOVK  X17, #0xa27b, LSL #48
    MOVZ  X18, #0xeb55, LSL #0
    MOVK  X18, #0xd523, LSL #16
    MOVK  X18, #0x2782, LSL #32
    MOVK  X18, #0xc805, LSL #48
    MOVZ  X19, #0x7406, LSL #0
    MOVK  X19, #0xb2b3, LSL #16
    MOVK  X19, #0x725e, LSL #32
    MOVK  X19, #0x2f1c, LSL #48
    MOVZ  X20, #0x176b, LSL #0
    MOVK  X20, #0x7cf, LSL #16
    MOVK  X20, #0xe713, LSL #32
    MOVK  X20, #0x9961, LSL #48
    MOVZ  X21, #0xb4b0, LSL #0
    MOVK  X21, #0x6ed2, LSL #16
    MOVK  X21, #0xeb15, LSL #32
    MOVK  X21, #0x8d37, LSL #48
    MOVZ  X22, #0x5751, LSL #0
    MOVK  X22, #0x3378, LSL #16
    MOVK  X22, #0xe77a, LSL #32
    MOVK  X22, #0x6918, LSL #48
    MOVZ  X23, #0xaf7f, LSL #0
    MOVK  X23, #0xf557, LSL #16
    MOVK  X23, #0xe02f, LSL #32
    MOVK  X23, #0x2de8, LSL #48
    MOVZ  X24, #0x4ae5, LSL #0
    MOVK  X24, #0xd111, LSL #16
    MOVK  X24, #0xd0e, LSL #32
    MOVK  X24, #0x7f93, LSL #48
    MOVZ  X25, #0x6e39, LSL #0
    MOVK  X25, #0xc6cf, LSL #16
    MOVK  X25, #0x33ad, LSL #32
    MOVK  X25, #0xcebf, LSL #48
    MOVZ  X26, #0xa0ee, LSL #0
    MOVK  X26, #0xbc0f, LSL #16
    MOVK  X26, #0x179c, LSL #32
    MOVK  X26, #0xe8d2, LSL #48
    MOVZ  X27, #0xbd91, LSL #0
    MOVK  X27, #0x1c8f, LSL #16
    MOVK  X27, #0x159a, LSL #32
    MOVK  X27, #0x799e, LSL #48
    MOVZ  X28, #0xdf0f, LSL #0
    MOVK  X28, #0xc0ec, LSL #16
    MOVK  X28, #0xc19f, LSL #32
    MOVK  X28, #0xb2aa, LSL #48
    MOVZ  X29, #0xc447, LSL #0
    MOVK  X29, #0xe00f, LSL #16
    MOVK  X29, #0x7a2d, LSL #32
    MOVK  X29, #0xb908, LSL #48
    MOVZ  X14, #0x14, LSL #0
TaishanIntCcP01_label_503:
    ADDS  X17, X19, X28, SXTX #3
    ADDS  W20, W27, #0x5fd
    SUBS  W26, W14, W9, UXTH #3
    ADDS  X29, X2, #0x617
    ADDS  X20, X29, #0x621
    ADDS  X17, X29, X26, ASR #37
    FCMP  D13, D19
    SUBS  W23, W12, W22, SXTH #1
    SUBS  X19, X27, #0x5bc
    ADDS  X25, X19, X23, SXTX #3
    SUBS  X2, X17, #0xf81
    ADDS  W2, W8, W2, ASR #27
    SUBS  W26, W16, W13, ASR #17
    SUBS  X9, X23, #0x175, LSL #12
    ANDS  W17, W26, W10, ASR #23
    ANDS  W16, W8, #0xffff3fff
    ADDS  W21, W21, W22, UXTB #3
    ADDS  X20, X23, W20, UXTB #1
    SUBS  X29, X10, #0x5f, LSL #12
    ADDS  W29, W12, W12, UXTX #4
    SUBS  X10, X29, X6, LSR #29
    ANDS  X10, X12, #0xffffff000000000
    ANDS  W18, W6, #0xe3ffe3ff
    ADDS  X10, X20, #0xf22, LSL #12
    SUBS  X6, X5, X16, SXTX #3
    ANDS  X5, X9, #0xf007ffffffffffff
    ADDS  W11, W19, #0xcde
    ANDS  W11, W6, #0xe0ffe0ff
    ANDS  W20, W26, #0x81ff81ff
    ANDS  X7, X10, #0x3333333333333333
    ADDS  X13, X23, #0x41f, LSL #12
    ANDS  W18, W11, #0xfffffe01
    SUBS  W21, W21, W27, ASR #25
    ANDS  W5, W12, #0x20002
    ANDS  X5, X14, #0x7f8000007f80000
    ADDS  W22, W12, W8, UXTH #0
    SUBS  W16, W26, W26, LSR #12
    SUBS  X12, X12, X4, SXTX #3
    SUBS  X8, X5, W24, SXTH #4
    ANDS  X20, X9, X9, ASR #54
    SUBS  W24, W27, W26, ASR #17
    SUBS  X9, X9, X10, LSL #45
    SUBS  W23, W6, #0xab8
    SUBS  X25, X13, W21, SXTH #3
    ADDS  X6, X4, X25, LSR #41
    ADDS  W7, W5, W14, SXTB #3
    SUBS  X2, X2, X11, UXTX #1
    SUBS  W9, W5, W5, LSL #8
    ADDS  X25, X27, X18, LSL #16
    ANDS  X25, X16, X24, LSL #59
    ANDS  W13, W27, W17, ROR #23
    SUBS  W20, W11, #0x770
    SUBS  W18, W5, W12, SXTX #0
    ANDS  X16, X14, #0xffc01fffffc01fff
    ADDS  W24, W27, W20, LSR #9
    ADDS  X24, X27, X17, ASR #0
    ADDS  X16, X21, W7, UXTB #3
    ANDS  X11, X22, #0xfe00000000001fff
    SUBS  W9, W27, W2, ASR #5
    ADDS  X16, X23, W9, SXTH #4
    ADDS  W25, W4, W17, ASR #26
    SUBS  W5, W21, #0x7ef
    ANDS  W18, W18, W29
    ANDS  X24, X29, #0xffcfffcfffcfffcf
    SUBS  W26, W12, W6, ASR #29
    FCMP  S7, S11
    ADDS  X15, X9, X7, LSL #22
    SUBS  W13, W15, W5, ASR #28
    ANDS  X22, X5, #0x3ffe00003ffe
    SUBS  W20, W29, W5, LSL #7
    SUBS  X19, X28, W16, UXTB #2
    SUBS  W15, W25, W21, LSR #22
    ADDS  W9, W22, W11, LSL #7
    ADDS  W19, W10, W10, SXTH #2
    SUBS  X28, X5, W10, SXTH #4
    ANDS  W10, W14, #0x3ffc
    SUBS  W22, W20, W13, LSL #24
    ANDS  W20, W2, #0x6
    SUBS  W20, W25, W7, UXTB #2
    SUBS  W17, W14, W26, SXTH #3
    SUBS  X27, X29, W13, UXTH #2
    SUBS  W2, W16, W26, UXTW #0
    ANDS  W5, W8, W29, LSR #18
    SUBS  X22, X21, #0xbd7, LSL #12
    ANDS  X7, X15, #0xfff00001fff00001
    SUBS  X20, X9, #0x724
    SUBS  W16, W6, #0xe75, LSL #12
    ANDS  W26, W19, W6, LSR #10
    SUBS  X6, X18, X10, LSL #26
    SUBS  W20, W15, #0xfd0
    ANDS  X16, X9, X28, LSL #60
    SUBS  X9, X16, #0x20e, LSL #12
    ADDS  X13, X15, X16, ASR #28
    ADDS  X7, X21, X23, UXTX #3
TaishanIntCcP01_label_145:
    SUBS  X15, X19, X25, UXTX #4
    ADDS  W12, W21, #0x6b0
    ADDS  W9, W18, #0x52d
    ADDS  W2, W13, W9, SXTH #1
    ADDS  W9, W12, W16, UXTW #0
    SUBS  W5, W28, #0x790
    ADDS  X23, X5, X12, LSL #46
    ANDS  X11, X11, #0xfff7fff7fff7fff7
    ANDS  X21, X12, X29, LSL #22
    ANDS  W10, W18, W29, LSL #27
    SUBS  W29, W23, W25, SXTB #4
    ADDS  W13, W19, W15, ASR #10
    ANDS  W9, W8, #0xffc0000
    ANDS  W15, W2, W19, LSR #21
    ANDS  X27, X20, #0x3ffe0000000
    SUBS  W15, W28, W12, UXTW #0
    ANDS  W22, W2, W12, ROR #30
    ADDS  X6, X22, X28, ASR #52
    SUBS  X26, X5, X5, SXTX #0
    SUBS  X19, X27, X10, LSR #27
    ADDS  W16, W9, W17, LSL #14
    ADDS  W16, W13, W5, LSL #21
    SUBS  W23, W16, W10, LSL #6
    SUBS  X9, X8, X19, LSR #26
    SUBS  W24, W6, W23, ASR #29
    ANDS  X12, X23, X8, ROR #21
    ANDS  W11, W2, #0xfffff07f
    FCMPE  S20, #0.0
    ADDS  X16, X22, W29, SXTH #3
    ADDS  X9, X10, X9
    SUBS  X22, X24, X25, UXTX #1
    ANDS  X15, X22, #0x1ff8000000
    ADDS  W26, W26, W19, SXTB #3
    SUBS  W13, W18, #0xc58
    ADDS  X5, X18, W14, SXTH #0
    ADDS  X24, X5, X19, LSR #49
    FCMP  S25, S25
    ADDS  W2, W15, W12, UXTB #4
    ANDS  X2, X24, X14, ASR #42
    ANDS  X27, X8, #0x1fffc
    SUBS  X24, X29, #0x718
    ADDS  X24, X13, W19, UXTB #4
    ANDS  X19, X2, X25, ROR #23
    ADDS  W6, W5, W17, SXTB #3
    FCMPE  D31, D27
    SUBS  W25, W17, W12, UXTX #1
    ADDS  X17, X8, X22, ASR #25
    ANDS  W6, W17, W11, LSR #20
    ADDS  W7, W15, W29, SXTX #4
    ANDS  X13, X27, #0xfefffffffeffffff
    ANDS  W4, W17, #0xf1f1f1f1
    SUBS  W28, W2, W17, UXTH #1
    ANDS  W9, W24, #0xff83ff83
    ADDS  W28, W2, #0x310
    SUBS  W10, W9, W22, UXTW #3
    SUBS  X7, X13, X19, SXTX #1
    ANDS  X8, X4, X17, ROR #10
    SUBS  W12, W13, W27, UXTH #1
    ADDS  W12, W20, #0x5e0
    SUBS  X9, X23, X11, LSR #33
    ADDS  X25, X5, X8, ASR #2
    ADDS  X20, X10, X9, ASR #34
    ANDS  W26, W20, W18, ROR #22
    ANDS  X17, X4, X7, ASR #4
    ANDS  W6, W29, #0x7c007c
    ADDS  X22, X21, X12, UXTX #2
    FCMP  D26, #0.0
    ADDS  X28, X11, X19, LSL #10
    SUBS  X24, X16, #0x14f, LSL #12
    SUBS  X7, X17, X20, SXTX #0
    SUBS  X8, X6, #0xcd5, LSL #12
    FCMP  S4, #0.0
    ADDS  X7, X24, #0xc70
    ANDS  W4, W17, W28, LSL #31
    ADDS  X29, X29, X8, LSR #52
    ADDS  W5, W26, #0x122
    ADDS  X6, X18, #0x10c, LSL #12
    SUBS  X18, X24, X24, LSR #12
    ANDS  W26, W5, W21, LSL #4
    FCMPE  D31, D24
    SUBS  W18, W17, #0x4ba
    SUBS  X5, X19, X10, LSR #42
    SUBS  X25, X2, #0x0
    FCMPE  S7, #0.0
    ANDS  W22, W12, W27, ASR #7
    ANDS  W10, W9, W27, LSL #9
    SUBS  X16, X13, #0x107
    ANDS  X29, X4, X26, ASR #17
    SUBS  X7, X13, #0xc09
    SUBS  W8, W5, W13, UXTB #4
    ANDS  W2, W16, W17, ASR #16
    FCMP  S29, S5
    ANDS  X16, X22, #0x8888888888888888
    SUBS  W18, W8, W6, SXTB #2
    SUBS  W13, W23, #0xdb3, LSL #12
    ADDS  W20, W18, W10, SXTH #1
    FCMP  S27, S14
    ANDS  X21, X21, X5, ASR #33
    FCMP  S5, S13
    ANDS  W23, W16, #0xf03ff03f
    ADDS  W20, W2, W19, LSL #5
    SUBS  X27, X16, W29, UXTB #2
    ANDS  X10, X22, #0xffffffe0ffffffe
    ANDS  W21, W16, W22, ROR #11
    ADDS  X23, X5, #0x489, LSL #12
    SUBS  W19, W13, #0xffb, LSL #12
    SUBS  X14, X14, #0x1
    B.NE  TaishanIntCcP01_label_503
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X24, #0xc110, LSL #0
    MOVK  X24, #0x10, LSL #16
    SUB  X16, X24, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X19, #0xaf77, LSL #0
    SUB  X16, X19, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X13, #0xf800, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X14, X13, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X26, #0xac7b, LSL #0
    MOVK  X26, #0x6112, LSL #16
    SUB  X24, X26, X9
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntCcP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntCcP01_TestFail
    MOVZ  X28, #0xf610, LSL #0
    MOVK  X28, #0xffff, LSL #16
    SUB  X16, X28, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X4, #0xf800, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X29, X4, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x180, LSL #0
    SUB  X9, X17, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntCcP01_TestFail
    MOVZ  X28, #0xf7c0, LSL #0
    MOVK  X28, #0xffff, LSL #16
    SUB  X27, X28, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntCcP01_TestFail
    MOVZ  X11, #0xaf77, LSL #0
    SUB  X19, X11, X19
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X8, X28, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntCcP01_TestFail
    MOVZ  X18, #0x10, LSL #0
    SUB  X6, X18, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntCcP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X25
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X7, #0xac7b, LSL #0
    MOVK  X7, #0x6112, LSL #16
    SUB  X4, X7, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntCcP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X17, X22, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
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
TaishanIntCcP01_label_531:
    ANDS  W15, W25, W15, ASR #28
    SUBS  W15, W24, #0xc33
    ADDS  X15, X23, X19, ASR #33
    ADDS  W23, W19, #0x841, LSL #12
    SUBS  X27, X23, #0xe00
    SUBS  X29, X28, X10, LSR #10
    ADDS  X26, X12, W28, UXTW #2
    ADDS  W23, W19, W17, LSL #18
    ANDS  W25, W18, W21, LSR #14
    ADDS  W25, W6, W17, ASR #23
    ANDS  W26, W29, W2, LSR #3
    ADDS  W27, W13, W4, LSR #31
    SUBS  W7, W12, W8, UXTH #3
    SUBS  W26, W27, W15, SXTB #3
    ANDS  X26, X6, #0xfe0000000000003f
    SUBS  X9, X12, X23, LSL #30
    SUBS  X17, X25, #0xdff, LSL #12
    ANDS  X7, X14, X17, ASR #61
    ADDS  X7, X6, W26, UXTH #1
    SUBS  W19, W18, #0xd89
    ADDS  X11, X13, W27, SXTH #2
    SUBS  W24, W9, W26, UXTB #0
    ADDS  W9, W15, W13, SXTB #2
    SUBS  W16, W8, W24, ASR #16
    ADDS  W26, W27, W19, UXTH #0
    ANDS  X19, X7, X13, LSR #31
    FCMP  D11, D12
    ADDS  X5, X28, #0x67, LSL #12
    SUBS  X21, X25, #0x10
    ADDS  X27, X23, #0xebc
    FCMPE  S0, #0.0
    SUBS  X15, X6, W19, UXTH #1
    ADDS  W25, W25, #0xb05, LSL #12
    SUBS  W4, W29, W7, LSL #18
    ANDS  W16, W5, W2, ROR #8
    ADDS  X5, X4, X10, LSR #24
    ANDS  W5, W9, W7, ASR #19
    SUBS  X15, X8, W15, UXTB #4
    ANDS  X18, X5, X8, ASR #27
    ANDS  W19, W9, W9, LSL #7
    ANDS  W23, W9, W27, LSL #29
    ADDS  W17, W14, #0x9e5, LSL #12
    ADDS  W25, W19, #0x5b0
    ANDS  X26, X20, #0xfff8007fffffffff
    ANDS  X5, X2, #0xfc000000000001ff
    SUBS  W13, W11, #0x53f, LSL #12
    SUBS  X8, X16, W17, SXTB #2
    ANDS  W18, W15, #0xfefefefe
    ANDS  W24, W27, W20, ROR #0
    SUBS  W24, W7, W9, LSL #23
    ADDS  W24, W23, W20, UXTX #0
    FCMPE  S27, S21
    SUBS  W25, W2, W15, LSR #31
    SUBS  X18, X21, W19, SXTB #4
    SUBS  W2, W2, #0x36d, LSL #12
    ANDS  W19, W2, W15, ASR #3
    ADDS  W10, W25, W18, LSR #12
    ADDS  X9, X28, X17, ASR #48
    ANDS  W23, W17, #0xe00fffff
    ADDS  W21, W12, W24, SXTB #4
    ADDS  W4, W8, W6, SXTH #3
    SUBS  X20, X9, #0xa3f, LSL #12
    SUBS  X26, X2, #0x3, LSL #12
    SUBS  X15, X20, W16, SXTW #4
    SUBS  X10, X11, #0x9a8
    SUBS  X24, X10, X14, ASR #15
    ADDS  W26, W10, #0x8a7
    SUBS  X19, X7, #0x10
    SUBS  X22, X21, X24, LSL #55
    ADDS  W22, W4, W23, ASR #11
    SUBS  X13, X11, W13, SXTB #3
    ADDS  X27, X9, #0x332, LSL #12
    FCMP  D13, D18
    ADDS  X2, X7, W15, SXTW #1
    ANDS  X23, X2, X28, LSR #1
    ADDS  W20, W28, #0xf34
    FCMPE  D6, #0.0
    ANDS  X18, X9, #0x1ffffffc1ffffffc
    ANDS  X11, X15, #0xffe00000ffe00000
    ADDS  W4, W9, W26, SXTX #3
    ANDS  W15, W16, #0x7f007f0
    FCMPE  S7, #0.0
    ADDS  W7, W15, W13, LSL #16
    SUBS  X22, X4, X16, SXTX #1
    ADDS  W19, W28, W15, ASR #11
    FCMPE  S14, #0.0
    ADDS  W19, W15, W9, UXTX #1
    SUBS  X2, X15, W20, UXTH #2
    ADDS  W21, W19, W28, LSL #12
    SUBS  X16, X7, W19, SXTW #1
    ANDS  X21, X8, X16, LSL #13
    ANDS  W19, W17, #0x801f801f
    ADDS  X22, X27, #0xe9e
    FCMPE  S24, #0.0
    SUBS  X26, X17, #0x9d1
    SUBS  X11, X5, X14, LSR #5
    SUBS  X11, X22, W16, UXTH #0
    FCMPE  S16, #0.0
    SUBS  W15, W5, W28, LSL #17
    ADDS  W18, W20, #0xb5b, LSL #12
    ANDS  X7, X8, #0xffffff000000
    ADDS  X4, X20, X5, LSL #31
    ADDS  W2, W19, W26, LSL #12
    ADDS  W4, W14, W7, UXTH #1
    ANDS  X2, X4, X25, ASR #60
    SUBS  W11, W6, W10, SXTW #1
    ADDS  W20, W21, #0xd57
    ANDS  W27, W15, W18, LSR #1
    ADDS  X25, X19, X17, LSR #2
    ADDS  X15, X20, #0x1e6, LSL #12
    ADDS  X18, X23, W6, UXTH #2
    ANDS  W23, W8, W10, LSR #26
    ADDS  W2, W4, W8, LSR #3
    ADDS  X18, X16, X18, SXTX #3
    ANDS  W13, W22, W21, LSL #31
    ADDS  W7, W4, #0x4a
    ADDS  W12, W22, W11, LSR #17
    ADDS  W10, W21, #0xfd0
    ADDS  W16, W26, #0x985, LSL #12
    ANDS  W25, W10, W11, ROR #29
    ANDS  W19, W24, W13, LSL #31
    ADDS  W4, W7, W20, LSL #30
    FCMP  S18, S27
    ADDS  X8, X11, X13, ASR #0
    ADDS  X18, X22, W12, SXTB #0
    ADDS  W26, W8, W6, ASR #14
    ADDS  X13, X26, #0x565, LSL #12
    SUBS  W27, W22, #0xb45
    ANDS  W26, W11, #0x3c3c3c3c
    SUBS  W24, W28, #0x1d0
    ADDS  W9, W26, W29, UXTB #1
    SUBS  W21, W17, W18, UXTH #0
    ADDS  W10, W16, W9, UXTW #1
    SUBS  W16, W10, #0x5a2, LSL #12
    ADDS  X25, X25, W4, UXTW #0
    ADDS  W21, W26, W15, LSL #10
    SUBS  W20, W29, #0xcf0
    ANDS  W11, W25, #0x7fc07fc
    ANDS  W16, W28, W24, LSR #20
    ANDS  X13, X16, #0xf3fffffff3ffffff
    SUBS  X7, X16, #0x580
    ADDS  X26, X28, #0xe10
    ANDS  W21, W29, #0xfffe7fff
    ADDS  W20, W8, W6, ASR #5
    ANDS  X7, X12, #0x7777777777777777
    ANDS  W28, W19, W4, LSR #28
    ADDS  W13, W7, W7, SXTW #3
    ADDS  W16, W16, W4, SXTX #2
    SUBS  W14, W25, W20, UXTB #1
    ADDS  X27, X27, X20, ASR #11
    ADDS  W29, W29, W27, ASR #1
    ADDS  X20, X15, W10, UXTB #1
    SUBS  W12, W6, W5, SXTX #0
    SUBS  W13, W11, #0x2bd, LSL #12
    ADDS  W29, W5, #0xc21, LSL #12
    ANDS  X11, X16, X6, ROR #31
    SUBS  W16, W11, W27, LSR #5
    SUBS  X29, X20, X24, LSR #30
    SUBS  X29, X13, X19, LSR #0
    SUBS  X16, X13, #0xdad
    ANDS  W4, W25, #0xf8fff8ff
    ANDS  X27, X29, #0x7800000000000
    ANDS  W12, W24, W16, ROR #29
    SUBS  X24, X10, W5, UXTH #0
    SUBS  X12, X23, X20, LSL #9
    ADDS  X12, X20, W15, SXTB #4
    ADDS  W11, W27, #0xfbb, LSL #12
    ADDS  X11, X27, W29, SXTH #3
    SUBS  W17, W27, #0x1b9, LSL #12
    ADDS  W13, W13, W15, UXTH #3
    ADDS  W17, W27, W4, LSR #12
    SUBS  X14, X14, X2, LSR #16
    ADDS  X26, X12, X19, UXTX #2
    SUBS  W18, W23, W8, LSR #13
    ADDS  X16, X13, W13, SXTH #2
    ADDS  W16, W10, W24, LSL #28
    ADDS  W11, W19, W18, SXTX #4
    ADDS  X23, X20, #0x1ef, LSL #12
    ANDS  W20, W17, #0x7fc0000
    ADDS  W29, W29, W26, ASR #2
    SUBS  X29, X26, W21, SXTH #0
    SUBS  X28, X25, X22, LSR #48
    ANDS  X29, X2, #0x1ffffff0000
    FCMPE  D24, #0.0
    ADDS  W12, W16, W14, SXTW #4
    SUBS  W12, W16, W28, UXTW #1
    ADDS  X27, X19, W12, SXTB #0
    FCMP  D23, #0.0
    ANDS  W18, W6, W16, ROR #30
    FCMPE  D30, #0.0
    ANDS  W12, W4, W20, ASR #13
    SUBS  W7, W18, W12, UXTB #3
    ANDS  W19, W13, W19, ASR #20
    ANDS  W15, W27, W9, ASR #5
    SUBS  X15, X14, #0xb70
    ANDS  W16, W15, W13, ASR #10
    SUBS  X18, X17, #0xc91, LSL #12
    ADDS  W7, W27, W23, LSR #10
    ADDS  W17, W14, W4, SXTH #4
    ADDS  X16, X20, #0x57f, LSL #12
    SUBS  X6, X6, #0x1
    B.NE  TaishanIntCcP01_label_531
    MOVZ  X12, #0xb12d, LSL #0
    MOVK  X12, #0x4b20, LSL #16
    SUB  X21, X12, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x58e3, LSL #0
    MOVK  X17, #0x20, LSL #16
    SUB  X21, X17, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X10, #0xe0, LSL #0
    SUB  X22, X10, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X19, #0xff1, LSL #0
    SUB  X23, X19, X7
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X27, #0xc929, LSL #0
    MOVK  X27, #0xfa13, LSL #16
    SUB  X16, X27, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x95c, LSL #0
    MOVK  X2, #0x3810, LSL #16
    SUB  X23, X2, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X9, #0xe0, LSL #0
    SUB  X4, X9, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntCcP01_TestFail
    MOVZ  X18, #0xf620, LSL #0
    MOVK  X18, #0xff82, LSL #16
    SUB  X20, X18, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X9, #0xb12d, LSL #0
    MOVK  X9, #0x4b20, LSL #16
    SUB  X8, X9, X12
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X18, #0x9d98, LSL #0
    MOVK  X18, #0x2fb, LSL #16
    SUB  X8, X18, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X2, #0xf71, LSL #0
    MOVK  X2, #0x320, LSL #16
    SUB  X20, X2, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X4, #0x401, LSL #0
    MOVK  X4, #0x320, LSL #16
    SUB  X25, X4, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x58e3, LSL #0
    MOVK  X23, #0x20, LSL #16
    SUB  X29, X23, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X15, #0x9d98, LSL #0
    MOVK  X15, #0x2fb, LSL #16
    SUB  X26, X15, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X24, #0xff1, LSL #0
    SUB  X22, X24, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X9, X24, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntCcP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntCcP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X22
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X7, #0x58e3, LSL #0
    MOVK  X7, #0x20, LSL #16
    SUB  X11, X7, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X28, X7, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X21, X12, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X4, #0xc929, LSL #0
    MOVK  X4, #0xfa13, LSL #16
    SUB  X11, X4, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x0, LSL #0
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
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X8, #0x14, LSL #0
TaishanIntCcP01_label_559:
    ADDS  X24, X29, W7, SXTB #3
    SUBS  X7, X10, X8, UXTX #0
    ADDS  X13, X19, X7, UXTX #2
    ADDS  W15, W6, W10, SXTH #3
    ANDS  W28, W15, #0xe007e007
    SUBS  W22, W13, #0x78f, LSL #12
    ADDS  W12, W18, W12, UXTH #0
    FCMP  S9, #0.0
    ADDS  X5, X20, #0xcab
    ANDS  X6, X17, #0x7fc00000000000
    ADDS  X10, X21, #0x145
    ADDS  X23, X24, W24, UXTW #0
    ADDS  W29, W25, #0xeef, LSL #12
    ANDS  X28, X26, X22, ROR #3
    ANDS  X19, X13, X22, ASR #5
    SUBS  W7, W7, #0x867, LSL #12
    SUBS  X2, X27, #0x0
    ADDS  X2, X11, X29, ASR #42
    ADDS  W7, W25, #0x859
    ANDS  W6, W10, #0x66666666
    SUBS  W10, W8, #0x0
    ADDS  X11, X8, #0x9c4
    ANDS  X14, X27, #0x1800000
    ANDS  X19, X24, #0xc0003fffc0003fff
    ADDS  W4, W13, W5, SXTX #3
    ADDS  W29, W4, #0x500
    ANDS  W22, W21, #0xfe000
    SUBS  W23, W27, W19, LSL #31
    ADDS  X28, X20, X2, ASR #13
    FCMPE  D3, #0.0
    ANDS  W15, W14, #0x55555555
    ANDS  X23, X21, X2, LSR #35
    ANDS  W22, W22, W14, ROR #22
    SUBS  W20, W23, W22, LSL #4
    SUBS  X26, X23, X28, LSR #5
    ANDS  W23, W21, W23, LSR #1
    ADDS  X12, X19, W16, SXTB #4
    SUBS  W22, W2, W15, LSR #1
    SUBS  W4, W7, #0x4a0
    ADDS  X29, X10, X13, ASR #29
    SUBS  X14, X20, #0x0
    SUBS  X21, X10, #0xf84, LSL #12
    SUBS  W7, W14, W5, LSL #19
    SUBS  X12, X16, X14, LSL #62
    ADDS  W5, W15, W15, UXTW #3
    ANDS  W26, W2, #0xe03fe03f
    ADDS  W21, W13, W29, ASR #26
    ANDS  X4, X9, #0xffffe
    ANDS  W10, W15, #0x780078
    ANDS  W23, W22, #0x4040404
    SUBS  X11, X2, X6, ASR #18
    SUBS  W26, W17, #0x0
    ANDS  W10, W23, #0xbfffbfff
    FCMPE  S6, #0.0
    SUBS  X4, X25, #0xa29, LSL #12
    ADDS  W27, W4, W20, LSR #2
    ANDS  W5, W24, W9, LSL #6
    ADDS  X12, X28, X11, LSL #6
    ADDS  W20, W23, W15, ASR #26
    SUBS  W2, W20, W20, UXTH #0
    ANDS  X15, X8, #0xfff0001ffff0001f
    ANDS  W22, W10, W7, ASR #1
    SUBS  X27, X26, #0xc65, LSL #12
    SUBS  W12, W27, #0xb86
    ADDS  W20, W8, W9, LSR #20
    SUBS  W14, W25, W19, UXTH #4
    SUBS  W12, W23, W19, UXTH #2
    ADDS  X27, X13, #0x32f, LSL #12
    SUBS  W11, W22, #0x0
    SUBS  W6, W26, W14, ASR #4
    ADDS  X11, X13, W11, UXTH #1
    ANDS  W2, W11, W14, ROR #10
    SUBS  W9, W12, W5, SXTX #3
    ADDS  X20, X27, X11, ASR #1
    SUBS  X20, X2, W6, SXTH #2
    ADDS  X19, X22, X20, LSR #33
    ANDS  X25, X7, X28, ASR #42
    ADDS  W23, W25, #0xa12, LSL #12
    SUBS  X29, X26, W22, UXTB #1
    ADDS  W2, W6, #0x50b
    ADDS  X29, X8, X5, LSR #38
    ANDS  W17, W10, W20, ASR #12
    SUBS  X21, X9, #0x4a4, LSL #12
    ADDS  W18, W27, W15, UXTX #1
    SUBS  X19, X14, #0x7a4, LSL #12
    ADDS  W5, W22, W10, SXTH #2
    ANDS  X2, X28, #0xff1fff1fff1fff1f
    ADDS  W20, W9, #0x7d0
    SUBS  W12, W6, W17, UXTH #1
    ANDS  W17, W11, #0xfffff87f
    ANDS  W14, W20, W19, LSR #10
    SUBS  X7, X12, X26, LSL #30
    ADDS  W17, W10, #0x3f9, LSL #12
    FCMP  D15, #0.0
    ADDS  W14, W21, W6, UXTB #3
    ADDS  W28, W8, W7, UXTH #4
    SUBS  W28, W23, #0x2c7, LSL #12
    SUBS  W29, W6, #0x6f4
    ADDS  X15, X28, X2, ASR #57
    ANDS  X26, X17, X22, LSL #51
    SUBS  X20, X5, X25, ASR #6
    SUBS  W23, W7, W16, UXTX #3
    ADDS  X21, X10, #0x906
    SUBS  W21, W14, #0x66e
    SUBS  X11, X2, #0x9dc, LSL #12
    SUBS  X29, X8, X29, LSL #53
    ANDS  W17, W16, W2, ASR #1
    ANDS  X18, X29, X26, LSR #35
    ANDS  W21, W10, W26, ROR #16
    SUBS  W21, W19, W10, UXTX #0
    ADDS  W2, W21, W7, ASR #26
    ANDS  X11, X17, #0xffffffffffffff81
    SUBS  W10, W8, W29, LSR #11
    ADDS  W16, W28, #0xa5f
    SUBS  X26, X23, #0x316
    SUBS  W22, W16, #0x409, LSL #12
    SUBS  X7, X20, W23, SXTH #3
    ADDS  W24, W10, W7, SXTX #0
    SUBS  X15, X27, X24, UXTX #0
    ADDS  X2, X16, #0x580
    ANDS  W25, W15, #0x600060
    SUBS  X2, X22, X17, LSL #33
    ANDS  W10, W16, W2, ASR #20
    ADDS  W10, W13, W24, SXTW #4
    SUBS  W24, W16, #0x6b0
    SUBS  W19, W18, W2, LSL #8
    ADDS  X5, X2, X2, UXTX #2
    ADDS  W9, W15, #0x4a7
    ADDS  X9, X7, X22, SXTX #2
    SUBS  X24, X10, X16, LSL #1
    SUBS  X4, X13, W29, SXTW #0
    SUBS  W16, W25, W21, ASR #24
    SUBS  X10, X20, X10, LSL #2
    SUBS  X14, X14, #0x5fe
    ADDS  X23, X18, X27, ASR #52
    SUBS  X28, X25, X29, LSL #55
    ADDS  X24, X23, #0xdd4
    ADDS  X26, X28, W16, SXTW #3
    ANDS  X5, X7, #0x1fffffffffe0000
    SUBS  W13, W6, W12, SXTX #3
    ADDS  W10, W25, W11, LSL #1
    SUBS  X10, X19, X17, SXTX #0
    ADDS  X7, X20, X20, LSR #23
    ADDS  W29, W22, #0xea8
    ADDS  W7, W25, #0xb0
    SUBS  X7, X27, X6, LSR #59
    ADDS  X16, X12, #0x23, LSL #12
    SUBS  X29, X22, W14, SXTH #1
    ADDS  X2, X13, #0x235
    ANDS  W27, W22, W2, ROR #25
    SUBS  W7, W6, W10, LSR #16
    ADDS  X24, X26, #0xded, LSL #12
    ANDS  W5, W6, #0x3c3c3c3c
    ANDS  X26, X20, X4, ROR #49
    ADDS  X2, X27, X18, LSL #40
    ADDS  W2, W24, W28, UXTW #3
    ADDS  X10, X9, #0xbce
    SUBS  W5, W10, #0x8ee, LSL #12
    ANDS  W21, W10, #0x1ff01ff0
    ANDS  W11, W16, #0xfffe000
    SUBS  X12, X28, #0x981, LSL #12
    SUBS  X24, X9, X20, ASR #0
    SUBS  W17, W24, W18, LSR #16
    ADDS  W24, W24, #0x18a, LSL #12
    ADDS  X26, X20, W4, UXTH #4
    SUBS  W5, W13, W23, LSL #31
    ANDS  W26, W18, #0xfffc000f
    ANDS  W12, W27, W14, LSR #28
    ANDS  X17, X4, #0xf00007ffffffffff
    ADDS  X15, X12, W16, UXTB #4
    ANDS  W29, W2, W7, LSR #21
    FCMP  S8, #0.0
    SUBS  W16, W5, #0x3f8, LSL #12
    ANDS  X12, X21, #0x7ffff800000
    ADDS  X17, X24, X4, ASR #58
    ANDS  W24, W20, #0x1fff8
    SUBS  W27, W17, W2, ASR #16
    SUBS  X16, X13, #0x2fd
    SUBS  X21, X26, X10, LSR #2
    ADDS  W21, W17, W23, ASR #14
    ADDS  W4, W19, W24, LSR #31
    ANDS  W13, W20, #0x7fc000
    SUBS  W17, W12, #0x8a7, LSL #12
    ADDS  X11, X22, #0xd5f, LSL #12
    SUBS  W23, W29, #0x145, LSL #12
    FCMPE  S20, S16
    ANDS  X15, X14, X27, LSR #48
    SUBS  W5, W17, #0xac1
    SUBS  X5, X25, #0x0
    SUBS  X15, X16, X9, SXTX #1
    ADDS  W22, W9, W23, UXTX #4
    ANDS  X16, X21, #0x3ffffffff0000000
    ADDS  X24, X17, #0xa61, LSL #12
    ANDS  X13, X4, #0xc03fc03fc03fc03f
    ADDS  X4, X24, W13, SXTH #4
    ADDS  W11, W5, W21, UXTB #4
    ANDS  W20, W10, W6, LSL #16
    ANDS  X16, X27, #0x1c0000000
    ADDS  W15, W5, #0xfae
    ADDS  W25, W22, W24, ASR #19
    SUBS  X8, X8, #0x1
    B.NE  TaishanIntCcP01_label_559
    MOVZ  X24, #0xd668, LSL #0
    MOVK  X24, #0x51e, LSL #16
    SUB  X6, X24, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X4, #0xa000, LSL #0
    MOVK  X4, #0x93, LSL #16
    MOVK  X4, #0x1, LSL #32
    SUB  X15, X4, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x60, LSL #0
    MOVK  X23, #0x40, LSL #16
    SUB  X24, X23, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X28, X17, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x273c, LSL #0
    MOVK  X8, #0xfffc, LSL #16
    SUB  X16, X8, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x273c, LSL #0
    MOVK  X28, #0xfffc, LSL #16
    SUB  X23, X28, X8
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X25, #0x20f4, LSL #0
    MOVK  X25, #0xd1, LSL #16
    SUB  X18, X25, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntCcP01_TestFail
    MOVZ  X20, #0x2cc2, LSL #0
    MOVK  X20, #0xd1, LSL #16
    SUB  X27, X20, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntCcP01_TestFail
    MOVZ  X19, #0xfa0, LSL #0
    MOVK  X19, #0x40, LSL #16
    SUB  X29, X19, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x80, LSL #16
    SUB  X19, X29, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x8000, LSL #0
    MOVK  X2, #0xc015, LSL #16
    SUB  X6, X2, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X10, #0xe84a, LSL #0
    MOVK  X10, #0x5a69, LSL #16
    SUB  X9, X10, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntCcP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntCcP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X10, #0x2cc2, LSL #0
    MOVK  X10, #0xd1, LSL #16
    SUB  X5, X10, X20
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntCcP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X20, #0x8774, LSL #0
    MOVK  X20, #0xff8c, LSL #16
    SUB  X9, X20, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X23
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntCcP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x20f4, LSL #0
    MOVK  X13, #0xd1, LSL #16
    SUB  X6, X13, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X24, X8, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntCcP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x17dd, LSL #0
    MOVK  X2, #0x61ef, LSL #16
    MOVK  X2, #0x4e43, LSL #32
    MOVK  X2, #0xed9c, LSL #48
    MOVZ  X4, #0x832e, LSL #0
    MOVK  X4, #0x4ca1, LSL #16
    MOVK  X4, #0x364a, LSL #32
    MOVK  X4, #0x82e1, LSL #48
    MOVZ  X5, #0xb383, LSL #0
    MOVK  X5, #0x5a8c, LSL #16
    MOVK  X5, #0x60b6, LSL #32
    MOVK  X5, #0x2940, LSL #48
    MOVZ  X6, #0x61f8, LSL #0
    MOVK  X6, #0xb51d, LSL #16
    MOVK  X6, #0x2716, LSL #32
    MOVK  X6, #0xe5ce, LSL #48
    MOVZ  X7, #0x35c1, LSL #0
    MOVK  X7, #0xed7d, LSL #16
    MOVK  X7, #0x1625, LSL #32
    MOVK  X7, #0xef55, LSL #48
    MOVZ  X8, #0x44d, LSL #0
    MOVK  X8, #0x5856, LSL #16
    MOVK  X8, #0xab12, LSL #32
    MOVK  X8, #0x977e, LSL #48
    MOVZ  X9, #0x2837, LSL #0
    MOVK  X9, #0xae97, LSL #16
    MOVK  X9, #0xc2c4, LSL #32
    MOVK  X9, #0x26ac, LSL #48
    MOVZ  X10, #0x1d9c, LSL #0
    MOVK  X10, #0x5a8a, LSL #16
    MOVK  X10, #0x5cf4, LSL #32
    MOVK  X10, #0x3966, LSL #48
    MOVZ  X11, #0x4a3e, LSL #0
    MOVK  X11, #0x1055, LSL #16
    MOVK  X11, #0x4cca, LSL #32
    MOVK  X11, #0x34e8, LSL #48
    MOVZ  X12, #0x42cd, LSL #0
    MOVK  X12, #0x5c89, LSL #16
    MOVK  X12, #0x4fa3, LSL #32
    MOVK  X12, #0xac73, LSL #48
    MOVZ  X13, #0x3e3d, LSL #0
    MOVK  X13, #0xe1fc, LSL #16
    MOVK  X13, #0x5ad7, LSL #32
    MOVK  X13, #0x5359, LSL #48
    MOVZ  X14, #0x30b8, LSL #0
    MOVK  X14, #0x90e1, LSL #16
    MOVK  X14, #0xc687, LSL #32
    MOVK  X14, #0x189, LSL #48
    MOVZ  X15, #0xd2c1, LSL #0
    MOVK  X15, #0xa9b1, LSL #16
    MOVK  X15, #0xd0aa, LSL #32
    MOVK  X15, #0x9411, LSL #48
    MOVZ  X16, #0x2263, LSL #0
    MOVK  X16, #0xbc5, LSL #16
    MOVK  X16, #0x4818, LSL #32
    MOVK  X16, #0xe2c2, LSL #48
    MOVZ  X17, #0x93ec, LSL #0
    MOVK  X17, #0x4f2c, LSL #16
    MOVK  X17, #0x8830, LSL #32
    MOVK  X17, #0x778, LSL #48
    MOVZ  X18, #0x1792, LSL #0
    MOVK  X18, #0x5557, LSL #16
    MOVK  X18, #0xe6b4, LSL #32
    MOVK  X18, #0x92af, LSL #48
    MOVZ  X19, #0xcdfc, LSL #0
    MOVK  X19, #0xd7d8, LSL #16
    MOVK  X19, #0xadb9, LSL #32
    MOVK  X19, #0x4fd, LSL #48
    MOVZ  X20, #0x4705, LSL #0
    MOVK  X20, #0x5db1, LSL #16
    MOVK  X20, #0xc435, LSL #32
    MOVK  X20, #0xf946, LSL #48
    MOVZ  X21, #0x80d9, LSL #0
    MOVK  X21, #0x6900, LSL #16
    MOVK  X21, #0xe7d9, LSL #32
    MOVK  X21, #0x4250, LSL #48
    MOVZ  X22, #0xbb4a, LSL #0
    MOVK  X22, #0x6f18, LSL #16
    MOVK  X22, #0x2e31, LSL #32
    MOVK  X22, #0x12e3, LSL #48
    MOVZ  X23, #0x9edf, LSL #0
    MOVK  X23, #0x6674, LSL #16
    MOVK  X23, #0x8e18, LSL #32
    MOVK  X23, #0xe9, LSL #48
    MOVZ  X24, #0xf824, LSL #0
    MOVK  X24, #0x2513, LSL #16
    MOVK  X24, #0x4221, LSL #32
    MOVK  X24, #0x783b, LSL #48
    MOVZ  X25, #0x807b, LSL #0
    MOVK  X25, #0xda77, LSL #16
    MOVK  X25, #0xa0c7, LSL #32
    MOVK  X25, #0x2bba, LSL #48
    MOVZ  X26, #0x892d, LSL #0
    MOVK  X26, #0xa992, LSL #16
    MOVK  X26, #0x39f8, LSL #32
    MOVK  X26, #0x4cac, LSL #48
    MOVZ  X27, #0x7b24, LSL #0
    MOVK  X27, #0x7142, LSL #16
    MOVK  X27, #0x9a2f, LSL #32
    MOVK  X27, #0xb02f, LSL #48
    MOVZ  X28, #0x3628, LSL #0
    MOVK  X28, #0x6d7f, LSL #16
    MOVK  X28, #0xacfd, LSL #32
    MOVK  X28, #0x1a25, LSL #48
    MOVZ  X29, #0xc789, LSL #0
    MOVK  X29, #0xa496, LSL #16
    MOVK  X29, #0xd9fc, LSL #32
    MOVK  X29, #0x3118, LSL #48
    MOVZ  X8, #0x14, LSL #0
TaishanIntCcP01_label_586:
    SUBS  X24, X11, X10, LSR #23
    ADDS  W29, W21, #0xab0
    SUBS  W2, W9, #0x960
    SUBS  X2, X27, X28, ASR #42
    SUBS  W25, W8, #0x0
    ANDS  W25, W6, #0x3ffff
    SUBS  W12, W29, W12, ASR #28
    SUBS  X10, X12, X12, UXTX #1
    ADDS  X16, X25, X7, LSL #19
    ADDS  X5, X26, X17, LSR #20
    SUBS  X4, X4, X8, ASR #22
    SUBS  W10, W21, #0x820
    ADDS  W5, W13, W10, UXTX #0
    SUBS  X17, X8, #0x90b
    ANDS  W13, W5, #0x100010
    ANDS  X14, X11, X22, ROR #1
    ANDS  X22, X29, #0xffffff000000000f
    ADDS  W7, W7, W27, SXTW #4
    ADDS  X6, X17, X21, UXTX #4
    ANDS  W27, W14, W25, ASR #21
    ANDS  W17, W19, W11, LSL #22
    SUBS  W25, W29, #0x76d, LSL #12
    SUBS  W24, W6, W4, SXTB #4
    ADDS  X25, X24, #0x360
    ANDS  X28, X13, #0xff81ffffffffffff
    SUBS  W9, W21, #0xcfc
    SUBS  W19, W9, W16, SXTB #1
    SUBS  X12, X26, X25, LSL #2
    ADDS  W18, W7, #0x89d, LSL #12
    SUBS  X27, X18, X19, ASR #15
    SUBS  X11, X27, #0x87f, LSL #12
    FCMP  D2, D5
    SUBS  X23, X16, X18, LSL #4
    SUBS  X29, X8, #0x71e
    ADDS  W17, W2, W10, LSL #5
    ADDS  X14, X18, W14, SXTW #4
    ANDS  W17, W8, #0xffc1ffc1
    ADDS  W2, W18, #0x71e
    ANDS  W4, W11, W10, ASR #7
    SUBS  X24, X20, W16, UXTB #2
    ADDS  X17, X4, X10, LSL #9
    ANDS  W21, W29, #0x30303030
    ADDS  W23, W8, W14, ASR #31
    ANDS  W25, W15, #0xfbfbfbfb
    ADDS  W4, W7, W28, SXTH #3
    SUBS  X25, X26, W10, UXTW #0
    ADDS  X21, X12, X10, LSL #6
    ADDS  X17, X13, #0x2b0
    SUBS  X27, X6, X19, UXTX #2
    ADDS  X12, X25, W2, UXTH #3
    SUBS  W21, W12, W6, SXTB #1
    ANDS  W29, W18, #0x7c007c0
    ADDS  W13, W24, #0x9e0
    SUBS  X29, X20, W6, UXTH #4
    SUBS  W29, W7, W7, UXTX #3
    SUBS  X16, X25, W28, SXTW #1
    ADDS  W9, W19, #0xd3b, LSL #12
    ADDS  W21, W14, W26, SXTX #1
    SUBS  W19, W8, W15, UXTB #4
    ADDS  X14, X8, W11, SXTH #4
    ANDS  X17, X19, #0xfffc0000001fffff
    FCMPE  S15, S24
    ANDS  W24, W17, #0x7fffc0
    ADDS  X19, X24, X13, UXTX #4
    ANDS  W13, W13, #0x7fff
    SUBS  X26, X27, W16, UXTB #2
    SUBS  W7, W26, W4, LSR #15
    ANDS  W19, W27, W12, LSL #29
    ADDS  X27, X25, X19, ASR #3
    FCMPE  S23, S18
    ADDS  W26, W17, #0xe7b
    SUBS  W27, W2, W10, SXTX #4
    ADDS  X19, X28, X14, LSL #62
    ADDS  W26, W13, W21, LSR #3
    SUBS  X21, X11, #0xa04, LSL #12
    ADDS  W10, W19, W22, SXTW #4
    ADDS  X10, X8, X17, LSL #32
    SUBS  X22, X29, #0x23c, LSL #12
    ADDS  X22, X21, X21, LSR #15
    ADDS  X7, X22, #0xe6b
    SUBS  X14, X8, #0xd3c
    ADDS  X20, X8, #0x405
    ANDS  W9, W28, #0xffffffe1
    ADDS  X24, X27, X29, ASR #34
    ADDS  W13, W28, #0xf40
    SUBS  W28, W8, #0x16c, LSL #12
    ADDS  W13, W2, W23, UXTW #2
    ADDS  W29, W26, W27, SXTH #4
    ADDS  X23, X26, W22, SXTH #1
    ANDS  X14, X27, #0xfff01ffffff01fff
    FCMPE  D18, #0.0
    SUBS  X19, X19, #0xe0e
    SUBS  X7, X2, #0xd95
    SUBS  X21, X17, W19, UXTW #4
    FCMPE  S4, S21
    ANDS  W9, W24, #0xffe0ffe0
    ADDS  X26, X11, #0x952, LSL #12
    SUBS  X24, X11, X20, LSR #48
    ADDS  W19, W14, W16, UXTX #4
    ANDS  X7, X8, #0xfff00000000000ff
    ADDS  X20, X13, X2, ASR #36
    SUBS  X22, X13, W7, SXTW #2
    SUBS  W6, W16, W20, LSL #22
    ADDS  W13, W25, #0x982, LSL #12
    SUBS  X7, X22, X20, LSL #48
    ADDS  X2, X29, X19, ASR #52
    FCMPE  D31, #0.0
    ANDS  X11, X2, #0x8080808080808080
    ANDS  X29, X23, #0xf00ff00ff00ff00f
    SUBS  W25, W11, W13, UXTB #3
    ANDS  W11, W6, #0xff80000f
    ANDS  W22, W25, #0xf03ff03f
    ANDS  W16, W20, W23, ASR #4
    ADDS  W25, W23, W4, UXTB #4
    ADDS  W14, W7, W29, LSL #4
    SUBS  W12, W2, W2, SXTX #0
    ADDS  W7, W7, W5, ASR #26
    SUBS  W29, W19, W29, SXTX #3
    ANDS  W17, W16, W21, ASR #27
    ANDS  W11, W11, W5, ASR #17
    ADDS  X5, X20, X6, LSR #61
    ADDS  X29, X28, #0xcdc, LSL #12
    ADDS  X28, X29, #0x35d, LSL #12
    SUBS  W9, W12, W7, LSR #12
    ADDS  X9, X19, #0x9c0
    FCMP  S30, S31
    ADDS  X6, X29, X14, LSL #25
    SUBS  W5, W15, #0x3d9, LSL #12
    SUBS  W28, W28, W18, SXTH #3
    ANDS  W9, W14, #0xffffc00f
    ANDS  W23, W16, W14, ASR #0
    ANDS  W17, W19, #0x700070
    ANDS  W2, W25, W8, ASR #16
    SUBS  X20, X11, #0x4b7
    ADDS  X7, X10, X6, ASR #46
    FCMP  S25, S28
    ADDS  W26, W5, W10, ASR #13
    ANDS  W11, W12, W22, LSL #1
    ADDS  X27, X18, #0x9c0
    FCMP  S16, #0.0
    SUBS  X6, X6, X4, SXTX #4
    SUBS  W29, W26, #0xca0
    SUBS  W26, W12, W5, LSL #22
    ADDS  W13, W25, #0xc9e
    SUBS  W25, W27, W18, LSR #31
    SUBS  X28, X2, #0xd0f
    SUBS  X14, X16, X8, UXTX #4
    SUBS  W19, W17, #0xf06
    ADDS  X9, X13, W10, UXTW #3
    SUBS  X18, X5, W7, SXTH #3
    ADDS  W29, W2, W28, LSL #12
    SUBS  X12, X4, W22, UXTB #3
    ADDS  X16, X15, #0xe85, LSL #12
    ANDS  W20, W28, W20, LSR #4
    ANDS  W10, W8, #0xfff001ff
    SUBS  W26, W21, W20, LSL #25
    ADDS  X26, X14, W17, SXTW #2
    ADDS  W13, W6, W16, UXTW #1
    ADDS  X25, X25, W16, SXTB #2
    ADDS  W25, W6, W10, SXTX #0
    ANDS  X13, X2, X26, LSL #8
    ADDS  X5, X22, X22, ASR #4
    ADDS  X18, X15, X27, ASR #55
    ANDS  X7, X6, X8, LSL #40
    ADDS  X20, X5, #0xca5, LSL #12
    SUBS  X20, X8, X29, LSR #33
    ADDS  X18, X9, W12, UXTW #1
    SUBS  W26, W7, W12, LSR #13
    ANDS  W26, W14, #0xfffff80
    SUBS  X22, X18, X29, LSR #21
    SUBS  W19, W12, W21, ASR #25
    SUBS  X26, X19, X12, LSR #3
    ADDS  W9, W16, W5, ASR #23
    ANDS  X6, X9, X16, ASR #34
    SUBS  X13, X8, #0x7ec
    FCMPE  D17, D1
    ADDS  X25, X5, X2, LSR #48
    ANDS  X2, X14, #0x1e0000
    FCMPE  S23, #0.0
    SUBS  X26, X19, #0xf0d, LSL #12
    SUBS  W29, W10, #0x10
    ANDS  W5, W15, #0xe000000f
    ADDS  X4, X29, W13, UXTB #3
    SUBS  W12, W15, W19, SXTH #2
    SUBS  W16, W14, #0x99d
    ADDS  W21, W6, W20, LSR #8
    SUBS  W16, W2, W16, UXTX #4
    ANDS  W22, W4, #0xfffff87f
    ADDS  X19, X6, X29, ASR #41
    ADDS  X2, X19, #0x5fa, LSL #12
    ADDS  X12, X29, W7, SXTB #2
    ADDS  X16, X8, #0x150
    SUBS  W26, W26, W29, SXTH #1
    SUBS  X15, X20, X11, ASR #10
    ADDS  W9, W24, W17, SXTH #4
    FCMPE  S23, S27
    SUBS  X12, X22, X17, LSL #49
    SUBS  W14, W8, W25, SXTX #2
    ADDS  W14, W10, #0x466
    SUBS  W10, W26, W4, SXTW #2
    SUBS  X8, X8, #0x1
    B.NE  TaishanIntCcP01_label_586
    MOVZ  X26, #0xa000, LSL #0
    MOVK  X26, #0x5f, LSL #16
    SUB  X6, X26, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x99, LSL #0
    MOVK  X8, #0x1, LSL #32
    SUB  X14, X8, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X12, #0x2, LSL #0
    SUB  X10, X12, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntCcP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntCcP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x2, LSL #0
    SUB  X4, X17, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntCcP01_TestFail
    MOVZ  X20, #0xf815, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X28, X20, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X24, #0x2, LSL #0
    SUB  X8, X24, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X6, #0xab2b, LSL #0
    MOVK  X6, #0xd1aa, LSL #16
    SUB  X4, X6, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntCcP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X19
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X20
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntCcP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X12, X24, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X5, #0x3120, LSL #0
    SUB  X17, X5, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X25, X22, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
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
    MOVZ  X27, #0x14, LSL #0
TaishanIntCcP01_label_614:
    ANDS  W29, W28, W7, ROR #18
    ADDS  W24, W28, W16, LSR #25
    ADDS  W21, W23, W26, UXTX #0
    ADDS  W21, W29, #0x34c
    ANDS  X13, X16, #0xffff0000000fffff
    SUBS  W26, W14, W16, UXTB #3
    ADDS  W21, W18, W25, LSR #18
    ADDS  W5, W12, W26, SXTB #4
    SUBS  W29, W13, W5, ASR #25
    ADDS  W12, W25, W10, ASR #29
    ADDS  X29, X19, #0xb93, LSL #12
    ADDS  W21, W16, #0x4da
    ANDS  W2, W28, #0xe
    SUBS  X28, X13, W21, UXTH #0
    ADDS  W13, W26, W19, SXTB #3
    ADDS  X2, X13, #0xa, LSL #12
    SUBS  X20, X24, X12, LSL #41
    ANDS  X26, X27, #0x2000000020
    ADDS  X23, X26, #0x2f0
    SUBS  W8, W5, #0xc93
    ANDS  W23, W14, #0xf83fffff
    SUBS  X13, X9, W23, UXTW #3
    SUBS  W29, W4, #0xe03, LSL #12
    ADDS  X8, X7, #0x39c, LSL #12
    SUBS  W18, W2, #0xcaa, LSL #12
    ANDS  W5, W8, W11, ROR #14
    ADDS  X5, X5, W14, SXTB #4
    ADDS  W5, W16, W6, LSR #30
    ADDS  W23, W2, #0x181, LSL #12
    ANDS  X22, X15, X21, LSL #45
    SUBS  X18, X7, X12, ASR #60
    ANDS  W4, W29, #0xffc3ffff
    ADDS  W11, W28, W18, UXTH #3
    ADDS  X4, X13, W22, SXTW #0
    SUBS  X19, X24, #0x854
    ADDS  X12, X24, X18, LSL #46
    ADDS  W6, W18, #0x36, LSL #12
    SUBS  X6, X16, X29, LSR #62
    ANDS  X28, X11, X19, ASR #1
    SUBS  W16, W23, W7, ASR #27
    ADDS  W11, W22, W16, LSR #3
    ADDS  W5, W5, #0x23a
    ADDS  W2, W15, W24, ASR #2
    ADDS  X20, X29, X11, ASR #43
    FCMPE  D16, D11
    ANDS  W20, W28, W22, LSL #13
    ADDS  X11, X9, X29, ASR #43
    ADDS  X2, X14, #0xd35, LSL #12
    FCMPE  S9, S7
    ANDS  X4, X17, #0x1
    ADDS  W29, W12, #0x12c
    SUBS  X22, X21, W10, UXTH #3
    SUBS  W14, W28, W24, ASR #22
    ADDS  X26, X4, X14, LSR #1
    ADDS  X4, X29, #0x6f0
    SUBS  W16, W8, #0xf2c, LSL #12
    ADDS  W7, W13, W11, SXTH #1
    SUBS  W19, W26, #0x877
    ADDS  X16, X24, X17, LSR #60
    SUBS  W16, W9, W15, ASR #28
    ADDS  X24, X15, W5, SXTW #1
    ANDS  W24, W7, #0x7fff00
    FCMPE  D23, D7
    SUBS  X26, X12, W22, UXTB #2
    ADDS  W20, W5, W13, UXTX #1
    SUBS  X12, X29, X11, ASR #24
    SUBS  X4, X27, W7, SXTB #2
    SUBS  X2, X14, X18, UXTX #2
    ANDS  X14, X12, #0xffffe001ffffe001
    SUBS  X22, X18, #0xe4a, LSL #12
    SUBS  X17, X23, X11, SXTX #1
    SUBS  X22, X17, W15, SXTB #0
    ANDS  X5, X21, X19, LSL #23
    SUBS  W5, W8, W26, UXTH #2
    SUBS  W29, W10, W10, LSL #8
    SUBS  X13, X16, W28, UXTB #4
    ADDS  W14, W24, W12, ASR #23
    ANDS  W23, W13, #0xfffffc01
    ANDS  X13, X29, #0xfffffe03ffffffff
    SUBS  W24, W4, W23, LSL #29
    ADDS  W23, W24, #0xfec
    ANDS  X16, X23, #0x7fff00007fff00
    ADDS  X2, X27, #0xa60
    SUBS  W4, W6, W4, UXTX #1
    SUBS  W16, W8, W15, SXTX #3
    ANDS  W14, W10, #0x66666666
    SUBS  X6, X18, #0x775
    SUBS  W29, W5, #0x951
    ANDS  W20, W12, W25, LSL #29
    ANDS  W13, W8, #0x1fffe00
    ADDS  X17, X14, X24, LSL #48
    ANDS  X2, X19, X14, LSL #51
    ADDS  W14, W2, W23, ASR #14
    ADDS  X13, X16, X2, SXTX #2
    SUBS  X9, X13, X6, LSR #49
    ANDS  W8, W2, W27, LSL #3
    ANDS  W17, W21, W4, ASR #23
    FCMP  D15, D0
    ANDS  W25, W28, #0x10000000
    FCMP  D2, #0.0
    ANDS  W13, W22, #0x3fe03fe
    SUBS  X21, X22, #0x891
    ADDS  W24, W20, W8, LSL #26
    FCMP  S1, S20
    SUBS  W17, W25, W17, LSL #13
    SUBS  X15, X20, #0xa38, LSL #12
    FCMPE  D10, D13
    ADDS  X24, X22, #0x6d9
    ADDS  X13, X18, X9, ASR #33
    SUBS  W8, W4, #0x143, LSL #12
    ANDS  W28, W24, W21, ROR #28
    ADDS  X13, X6, X15, UXTX #1
    ANDS  W16, W17, W25, ROR #27
    SUBS  X16, X27, X24, ASR #53
    SUBS  W2, W17, W4, LSL #18
    ANDS  W2, W4, #0x3e003e
    ANDS  W16, W17, #0x7070707
    ANDS  W4, W26, #0x7ffff8
    SUBS  X6, X25, X25, ASR #32
    ADDS  X16, X18, W20, SXTB #3
    ADDS  X4, X14, W16, SXTH #0
    ANDS  W10, W17, #0x8000800
    ADDS  X15, X23, W17, UXTW #3
    SUBS  W16, W26, #0xa19, LSL #12
    ADDS  X22, X17, X17, ASR #39
    ADDS  X29, X15, W13, SXTH #1
    ADDS  X7, X14, W25, UXTB #2
    ADDS  W2, W16, W21, UXTW #3
    FCMPE  S19, #0.0
    SUBS  X8, X13, W11, SXTW #4
    FCMPE  D25, D16
    SUBS  W20, W10, W15, SXTW #1
    FCMP  D9, D27
    ADDS  W8, W2, #0xa91
    SUBS  W28, W17, #0x60a, LSL #12
    ANDS  W23, W4, W13, LSR #1
    FCMP  D21, #0.0
    ADDS  X14, X12, W23, UXTB #3
    SUBS  W15, W14, #0x50
    ANDS  X29, X28, X7, LSR #59
    SUBS  W26, W7, W11, LSL #29
    ADDS  W21, W22, #0x7a0
    ADDS  X6, X22, X20, SXTX #4
    ADDS  X15, X22, X20, LSR #49
    FCMP  D12, #0.0
    ADDS  X10, X22, #0x37d
    FCMPE  D20, #0.0
    SUBS  X4, X20, X16, LSL #60
    ADDS  W8, W4, W21, UXTB #2
    SUBS  W13, W8, #0x6e0
    ADDS  W19, W6, W16, UXTB #4
TaishanIntCcP01_label_325:
    SUBS  W28, W29, W15, UXTX #3
    SUBS  W23, W27, #0xe06, LSL #12
    ANDS  X23, X24, #0x7e0000
    FCMPE  S10, #0.0
    ANDS  W13, W21, W14, ROR #10
    ADDS  X10, X19, X28, ASR #20
    ADDS  X17, X21, #0x966
    ADDS  W6, W27, W17, UXTB #1
    ADDS  W7, W2, W28, LSR #11
    ADDS  W19, W12, W26, UXTB #4
    SUBS  X4, X16, W21, UXTH #3
    SUBS  X20, X26, W16, UXTB #0
    SUBS  W12, W21, W14, SXTW #1
    ADDS  X17, X22, #0xa30
    ADDS  W2, W14, W27, ASR #26
    SUBS  W8, W14, #0xa0
    ADDS  W19, W14, #0xc40
    ADDS  X28, X17, X2, ASR #44
    SUBS  W9, W7, W19, ASR #8
    FCMP  S30, #0.0
    SUBS  X7, X7, #0x300
    ADDS  W22, W11, #0x829, LSL #12
    ADDS  W14, W26, W28, LSL #14
    SUBS  W8, W17, W29, LSL #31
    SUBS  W28, W6, #0x4a4
    SUBS  W19, W6, #0x10
    ADDS  W24, W6, #0x19a
    SUBS  X11, X14, X22, SXTX #0
    ADDS  X6, X14, W16, UXTW #3
    ADDS  X13, X9, X21, SXTX #0
    SUBS  W17, W8, W9, LSR #3
    SUBS  W9, W15, W25, LSR #1
    ADDS  X26, X29, X13, LSL #46
    ANDS  W15, W7, #0xfff
    ANDS  X7, X21, X6, LSL #9
    SUBS  X6, X13, W12, UXTH #1
    FCMP  D22, #0.0
    ANDS  X11, X2, #0xffff07ffffff07ff
    ANDS  W24, W29, W15, LSL #17
    ADDS  X15, X11, X14, LSL #14
    ADDS  X16, X21, #0xeba, LSL #12
    ANDS  X26, X7, #0xfffffffffff8003f
    SUBS  W18, W8, W18, LSR #9
    ANDS  X6, X18, #0xfffffc0000000
    SUBS  W26, W17, #0x8b6
    ADDS  X26, X10, #0x740
    FCMP  S30, S19
    SUBS  X25, X7, W24, SXTB #1
    ANDS  X11, X9, #0x2222222222222222
    SUBS  X27, X27, #0x1
    B.NE  TaishanIntCcP01_label_614
    MOVZ  X9, #0xfc96, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X22, X9, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X16, #0x2a82, LSL #0
    MOVK  X16, #0xff5e, LSL #16
    SUB  X21, X16, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X12, #0xe1f8, LSL #0
    MOVK  X12, #0x35, LSL #16
    SUB  X21, X12, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X6
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X16, #0xa30, LSL #0
    SUB  X10, X16, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntCcP01_TestFail
    MOVZ  X15, #0xfc96, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X20, X15, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X2, #0xe1f8, LSL #0
    MOVK  X2, #0x35, LSL #16
    SUB  X14, X2, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X19, #0x855a, LSL #0
    MOVK  X19, #0x147f, LSL #16
    SUB  X28, X19, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X14, #0xfc96, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X19, X14, X15
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X28, #0xa30, LSL #0
    SUB  X12, X28, X16
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X7, #0x1a79, LSL #0
    MOVK  X7, #0xfd70, LSL #16
    SUB  X4, X7, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntCcP01_TestFail
    MOVZ  X5, #0xa30, LSL #0
    SUB  X20, X5, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X19, X25, X19
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X24, X20, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntCcP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntCcP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x0, LSL #0
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
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X25, #0x14, LSL #0
TaishanIntCcP01_label_642:
    SUBS  W22, W29, #0x320
    ADDS  W22, W2, W10, LSR #26
    ADDS  W21, W9, #0xf6c, LSL #12
    ANDS  W8, W26, W10, LSR #7
    ADDS  W2, W27, W29, LSL #19
    SUBS  X17, X25, X7, LSR #0
    ANDS  W12, W4, #0xfbffffff
    SUBS  W9, W24, W23, ASR #28
    SUBS  X24, X29, X29, LSL #15
    ADDS  W10, W14, #0x539
    ANDS  X26, X14, X14, ROR #21
    ADDS  X22, X24, X26, ASR #51
    SUBS  W24, W10, W26, LSL #20
    ADDS  X23, X28, X11, SXTX #1
    SUBS  W7, W4, W15, LSL #12
    ADDS  W2, W21, W25, SXTX #1
    ANDS  W8, W29, #0x81818181
    ADDS  X7, X20, #0x5a1
    SUBS  X15, X15, X8, SXTX #2
    ADDS  X18, X5, X9, LSL #24
    ANDS  X18, X15, X22, LSR #12
    ANDS  W14, W13, W10, LSL #12
    SUBS  W10, W7, #0x3a
    FCMPE  S25, S29
    SUBS  W21, W15, W4, LSL #7
    ADDS  W17, W27, W8, SXTX #1
    ADDS  W4, W23, W29, SXTB #1
    ADDS  X6, X21, W19, UXTH #2
    ANDS  W24, W25, W22, LSR #19
    ADDS  X24, X11, X8, LSL #6
    ADDS  W15, W2, W15, SXTX #0
    SUBS  W13, W12, W27, SXTB #0
    ADDS  W22, W16, W10, UXTW #2
    ANDS  X28, X12, X21, LSL #5
    ADDS  W26, W7, W26, LSR #9
    ANDS  X22, X26, #0x3c003c003c003c0
    ADDS  W2, W9, W11, UXTX #0
    SUBS  X4, X2, #0x15a, LSL #12
TaishanIntCcP01_label_104:
    ANDS  W5, W9, #0xc03fc03f
    ANDS  W8, W15, W10, ASR #1
    FCMP  D16, D13
    SUBS  X21, X16, X25, LSL #31
    ANDS  X27, X4, #0x7ffffffffe000000
    SUBS  X22, X14, #0x3a4
    SUBS  W20, W26, W24, LSR #20
    ADDS  W4, W13, W11, ASR #28
    SUBS  X9, X25, X14, LSL #58
    ANDS  X14, X18, X27, LSR #17
    ADDS  X24, X21, W12, UXTH #1
    SUBS  X24, X27, #0x141
    ADDS  W29, W19, W25, SXTW #2
    SUBS  X21, X11, X24, LSL #28
    ADDS  W28, W28, W11, UXTW #1
    SUBS  W18, W29, W22, SXTW #4
    SUBS  W13, W17, W11, UXTH #2
    SUBS  X20, X8, X11, LSR #33
    ADDS  W8, W10, W21, UXTH #3
    ADDS  X19, X8, W8, SXTW #3
    ANDS  W21, W20, W16, LSL #1
    SUBS  X20, X17, #0x0
    ADDS  W27, W5, W12, UXTB #2
    FCMPE  D21, D6
    SUBS  W11, W12, W16, UXTH #2
    ANDS  X19, X11, X10, LSL #47
    SUBS  W29, W11, W19, SXTH #3
    ADDS  W7, W15, W11, UXTH #4
    ANDS  X19, X4, X5, LSL #34
    ADDS  W16, W10, W25, ASR #13
    SUBS  X26, X15, W27, SXTW #0
    SUBS  X9, X16, X2, UXTX #0
    ANDS  X6, X10, #0xffffff83ffffff83
    ADDS  W23, W8, #0x468
    SUBS  X21, X15, W5, SXTW #0
    FCMPE  S28, #0.0
    SUBS  W12, W24, W22, SXTW #4
    ADDS  W13, W4, W17, UXTX #2
    ADDS  W13, W8, W22, LSR #13
    ADDS  W20, W5, W20, SXTH #0
    ADDS  W28, W17, #0x8e8, LSL #12
    ANDS  W6, W10, #0x7fffe
    ADDS  X17, X29, X21, LSL #36
    ADDS  X13, X8, W19, UXTH #3
    ANDS  X12, X6, #0x1fffffffff8000
    ADDS  X15, X17, W22, SXTW #4
    ADDS  W12, W2, #0xd8d
    ADDS  X13, X29, X20, ASR #45
    ANDS  X28, X18, #0xf0000000f000000
    ADDS  W21, W26, W28, LSL #26
    ADDS  W13, W25, #0x73c, LSL #12
    ADDS  W9, W10, #0xa52, LSL #12
    SUBS  W26, W24, W13, ASR #13
    SUBS  W29, W14, #0x0
    ANDS  W4, W9, W20, LSR #24
    ADDS  X16, X9, X4, SXTX #3
    ANDS  X21, X16, #0xffff8000ffff8
    ANDS  X19, X21, #0xffe01fffffe01fff
    FCMP  D0, #0.0
    SUBS  X27, X10, X15, ASR #55
    ADDS  X20, X16, #0xae
    ANDS  W20, W5, #0xff3fff3f
    ADDS  W12, W19, #0x289, LSL #12
    ANDS  X12, X12, X29, LSR #22
    SUBS  W7, W22, W6, SXTW #0
    ANDS  W9, W8, W9, ASR #15
    SUBS  X24, X13, X25, ASR #25
    SUBS  X27, X11, W29, UXTH #3
    ADDS  X17, X12, #0x3a8, LSL #12
    SUBS  W9, W20, W6, SXTW #4
    ANDS  X15, X23, X9, LSL #41
    ADDS  X10, X12, W16, UXTH #1
    ADDS  W19, W2, #0xa37, LSL #12
    SUBS  X13, X8, X14, LSL #14
    SUBS  X22, X21, X7, ASR #0
    ADDS  W8, W14, W19, UXTX #3
    SUBS  W12, W17, W13, LSL #1
    ADDS  X22, X21, W15, SXTH #2
    ADDS  X13, X4, X27, LSL #9
    ANDS  W10, W13, W11, LSR #15
    SUBS  W24, W24, #0xde1, LSL #12
    SUBS  X24, X12, X26, ASR #25
    ADDS  X18, X8, #0xf3d
    FCMP  S10, S13
    ADDS  W8, W2, W18, SXTH #1
    ANDS  X7, X22, X14, ROR #52
    ADDS  W8, W22, #0xea0
    ANDS  X10, X26, #0x7fffc0007fffc
    ADDS  X17, X21, X5, ASR #29
    SUBS  X18, X24, W10, UXTB #2
    ADDS  W23, W19, #0xced, LSL #12
    ANDS  W15, W7, #0x6
    ANDS  X14, X8, X17, ROR #16
    SUBS  W14, W18, W5, LSR #30
    ANDS  X14, X15, #0x1fffe0001fffe
    SUBS  X20, X11, W4, UXTH #3
    ADDS  X14, X2, X14, SXTX #2
    SUBS  W10, W12, #0xb19
    ADDS  X10, X21, W14, SXTB #4
    ADDS  X23, X21, #0xd5b, LSL #12
    ADDS  X2, X15, W15, UXTW #3
    ADDS  W6, W22, W23, LSR #21
    ADDS  W20, W25, W2, SXTX #2
    SUBS  X26, X9, X8, UXTX #2
    SUBS  W20, W8, W21, LSR #13
    FCMPE  S18, S1
    ANDS  X16, X10, #0x1fc000000000
    SUBS  W29, W10, W20, UXTH #3
    ADDS  W6, W5, W16, LSR #30
    SUBS  X6, X5, W14, UXTW #1
    ADDS  W19, W29, W11, ASR #10
    ADDS  X15, X21, W29, UXTH #4
    ADDS  W6, W17, W14, LSL #2
    SUBS  X26, X2, #0x0
    ADDS  W29, W5, #0xdd9
    ADDS  X20, X27, X29, UXTX #4
    SUBS  W22, W15, W24, UXTH #4
    ADDS  W19, W28, W22, LSR #10
    ADDS  W10, W13, #0x460, LSL #12
    ADDS  X19, X5, X28, LSL #17
    ANDS  X5, X19, X25, LSL #56
    ADDS  X10, X5, X14, LSR #48
    ADDS  W28, W15, W9, UXTB #3
    ADDS  X19, X17, X13, SXTX #3
    FCMPE  D16, D24
    SUBS  W10, W6, W7, LSL #31
    ANDS  X17, X26, #0xfffffff800000000
    SUBS  W14, W7, #0xb43, LSL #12
    ADDS  W19, W23, #0xf50
    ADDS  W4, W27, W16, SXTB #3
    ANDS  W11, W27, #0xff9fff9f
    ADDS  W16, W2, W11, SXTB #1
    ADDS  X14, X4, #0x8d0
    SUBS  W21, W13, W25, SXTX #1
    SUBS  W6, W13, W8, SXTB #1
    ADDS  W14, W9, W19, SXTW #3
    ANDS  W28, W26, #0x55555555
    ADDS  X5, X4, X29, UXTX #4
    ADDS  X6, X4, X6, ASR #31
    SUBS  W26, W25, #0xc14, LSL #12
    SUBS  W20, W23, #0xaf0
    ADDS  W18, W20, W4, LSR #19
    ANDS  X14, X4, X21, ROR #30
    SUBS  W14, W16, W21, SXTH #0
    ADDS  W28, W18, W19, SXTW #0
    SUBS  X13, X23, #0xcfb
    SUBS  X27, X20, X13, LSL #55
    ADDS  W10, W14, #0x921
    SUBS  X27, X26, W15, SXTW #3
    SUBS  X11, X19, W21, SXTH #2
    ANDS  X19, X11, X24, ROR #45
    ADDS  W18, W8, W18, UXTX #2
    ADDS  W27, W13, W10, ASR #22
    ADDS  W2, W17, #0xaa0
    ADDS  W7, W28, W17, LSL #25
    SUBS  W23, W23, W7, LSR #16
    SUBS  W20, W6, W23, UXTB #4
    FCMPE  S2, #0.0
    ADDS  W21, W13, W8, LSL #15
    SUBS  W5, W2, #0x880
    ANDS  X21, X12, X13, ROR #30
    ADDS  W8, W2, W5, UXTB #3
    SUBS  X25, X25, #0x1
    B.NE  TaishanIntCcP01_label_642
    MOVZ  X18, #0xaa0, LSL #0
    SUB  X8, X18, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X18, X23, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntCcP01_TestFail
    MOVZ  X21, #0x220, LSL #0
    SUB  X13, X21, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntCcP01_TestFail
    MOVZ  X7, #0xaed0, LSL #0
    MOVK  X7, #0x1b5, LSL #16
    SUB  X12, X7, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X26, X19, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x6c91, LSL #0
    MOVK  X13, #0x2c, LSL #16
    SUB  X15, X13, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X9, #0x923, LSL #0
    SUB  X11, X9, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntCcP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X26, #0x6c91, LSL #0
    MOVK  X26, #0x2c, LSL #16
    SUB  X20, X26, X13
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x2, LSL #0
    SUB  X4, X2, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntCcP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X27, X17, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X12, X23, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X14, X19, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X26, #0x220, LSL #0
    SUB  X6, X26, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X5, #0x1128, LSL #0
    MOVK  X5, #0xb, LSL #16
    SUB  X12, X5, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X19, X12, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X22, #0x2391, LSL #0
    MOVK  X22, #0x2d, LSL #16
    SUB  X6, X22, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X5, X12, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x220, LSL #0
    SUB  X10, X2, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntCcP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X4, X20, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x4d91, LSL #0
    MOVK  X2, #0xe6fa, LSL #16
    MOVK  X2, #0xdb49, LSL #32
    MOVK  X2, #0x257f, LSL #48
    MOVZ  X4, #0x3fd4, LSL #0
    MOVK  X4, #0x9a05, LSL #16
    MOVK  X4, #0x7901, LSL #32
    MOVK  X4, #0x89e4, LSL #48
    MOVZ  X5, #0x26c0, LSL #0
    MOVK  X5, #0x3985, LSL #16
    MOVK  X5, #0x8314, LSL #32
    MOVK  X5, #0xae99, LSL #48
    MOVZ  X6, #0xa0d7, LSL #0
    MOVK  X6, #0xc21b, LSL #16
    MOVK  X6, #0xaa07, LSL #32
    MOVK  X6, #0x6310, LSL #48
    MOVZ  X7, #0xc04c, LSL #0
    MOVK  X7, #0x76c3, LSL #16
    MOVK  X7, #0x440a, LSL #32
    MOVK  X7, #0x6f8a, LSL #48
    MOVZ  X8, #0x7a14, LSL #0
    MOVK  X8, #0x198a, LSL #16
    MOVK  X8, #0xbbe6, LSL #32
    MOVK  X8, #0x5112, LSL #48
    MOVZ  X9, #0x7a11, LSL #0
    MOVK  X9, #0x3c9, LSL #16
    MOVK  X9, #0xfa7d, LSL #32
    MOVK  X9, #0xe739, LSL #48
    MOVZ  X10, #0xfff2, LSL #0
    MOVK  X10, #0x9357, LSL #16
    MOVK  X10, #0xee22, LSL #32
    MOVK  X10, #0xb3e9, LSL #48
    MOVZ  X11, #0xd32b, LSL #0
    MOVK  X11, #0x942d, LSL #16
    MOVK  X11, #0xc253, LSL #32
    MOVK  X11, #0xdca2, LSL #48
    MOVZ  X12, #0xee8b, LSL #0
    MOVK  X12, #0x3442, LSL #16
    MOVK  X12, #0x7359, LSL #32
    MOVK  X12, #0x64a9, LSL #48
    MOVZ  X13, #0x7078, LSL #0
    MOVK  X13, #0xebbd, LSL #16
    MOVK  X13, #0x5e11, LSL #32
    MOVK  X13, #0x4307, LSL #48
    MOVZ  X14, #0xa5fe, LSL #0
    MOVK  X14, #0xedd0, LSL #16
    MOVK  X14, #0x29e3, LSL #32
    MOVK  X14, #0xe903, LSL #48
    MOVZ  X15, #0x480c, LSL #0
    MOVK  X15, #0xf577, LSL #16
    MOVK  X15, #0x330f, LSL #32
    MOVK  X15, #0xb1f6, LSL #48
    MOVZ  X16, #0x3ee0, LSL #0
    MOVK  X16, #0xc424, LSL #16
    MOVK  X16, #0xb8a3, LSL #32
    MOVK  X16, #0xb1f7, LSL #48
    MOVZ  X17, #0x43d0, LSL #0
    MOVK  X17, #0x4bf0, LSL #16
    MOVK  X17, #0x3ac5, LSL #32
    MOVK  X17, #0xd6a8, LSL #48
    MOVZ  X18, #0x8df, LSL #0
    MOVK  X18, #0x20ce, LSL #16
    MOVK  X18, #0x98ee, LSL #32
    MOVK  X18, #0x45a4, LSL #48
    MOVZ  X19, #0x34ab, LSL #0
    MOVK  X19, #0x8617, LSL #16
    MOVK  X19, #0x4eb6, LSL #32
    MOVK  X19, #0x2068, LSL #48
    MOVZ  X20, #0x313, LSL #0
    MOVK  X20, #0xfcd9, LSL #16
    MOVK  X20, #0x15a8, LSL #32
    MOVK  X20, #0xf2f5, LSL #48
    MOVZ  X21, #0x4682, LSL #0
    MOVK  X21, #0x77ce, LSL #16
    MOVK  X21, #0x23c2, LSL #32
    MOVK  X21, #0x8fce, LSL #48
    MOVZ  X22, #0x2eec, LSL #0
    MOVK  X22, #0x958e, LSL #16
    MOVK  X22, #0xc35, LSL #32
    MOVK  X22, #0xd296, LSL #48
    MOVZ  X23, #0xe521, LSL #0
    MOVK  X23, #0x1ded, LSL #16
    MOVK  X23, #0x5da8, LSL #32
    MOVK  X23, #0x945e, LSL #48
    MOVZ  X24, #0x75fe, LSL #0
    MOVK  X24, #0x6166, LSL #16
    MOVK  X24, #0x9dfe, LSL #32
    MOVK  X24, #0x8f98, LSL #48
    MOVZ  X25, #0x4cb3, LSL #0
    MOVK  X25, #0x384f, LSL #16
    MOVK  X25, #0x997e, LSL #32
    MOVK  X25, #0x4267, LSL #48
    MOVZ  X26, #0x679, LSL #0
    MOVK  X26, #0x7dac, LSL #16
    MOVK  X26, #0x83d4, LSL #32
    MOVK  X26, #0xf5a4, LSL #48
    MOVZ  X27, #0x1a47, LSL #0
    MOVK  X27, #0x1c31, LSL #16
    MOVK  X27, #0xe60e, LSL #32
    MOVK  X27, #0xb143, LSL #48
    MOVZ  X28, #0xb37e, LSL #0
    MOVK  X28, #0xd313, LSL #16
    MOVK  X28, #0x704a, LSL #32
    MOVK  X28, #0x6476, LSL #48
    MOVZ  X29, #0xb34, LSL #0
    MOVK  X29, #0x53c4, LSL #16
    MOVK  X29, #0xbdbd, LSL #32
    MOVK  X29, #0xba24, LSL #48
    MOVZ  X25, #0x14, LSL #0
TaishanIntCcP01_label_670:
    ANDS  X2, X18, #0xfffffffff800ffff
    ADDS  X9, X29, X23, ASR #0
    ANDS  X9, X25, #0x7fe000007fe
    ADDS  W8, W26, W17, LSR #22
    ADDS  W28, W17, W18, LSR #8
    ADDS  W29, W8, #0x4bb
    ADDS  W19, W24, W8, UXTX #3
    SUBS  W27, W10, W22, UXTH #1
    SUBS  X23, X23, X24, LSL #20
    ADDS  X23, X23, W16, SXTH #4
    SUBS  X2, X26, W23, UXTB #1
    ANDS  W13, W20, #0xfe00fe0
    SUBS  W14, W24, W6, ASR #6
    ANDS  W13, W20, #0x200020
    SUBS  W27, W21, W7, SXTB #2
    SUBS  X20, X5, #0xcf2, LSL #12
    ANDS  W16, W28, #0xfe00000f
    SUBS  X28, X11, X6, ASR #38
    ANDS  W12, W14, #0xff80ffff
    ANDS  X21, X10, X9, ROR #57
    ADDS  W11, W14, W16, SXTB #1
    SUBS  X24, X7, #0x8a8
    ANDS  W13, W28, W18, ROR #8
    ADDS  X2, X22, W12, SXTB #4
    ANDS  X7, X29, #0xf8000007ffffffff
    SUBS  X28, X15, #0x26d
    SUBS  W11, W7, W29, SXTW #4
    ADDS  W21, W29, W26, UXTH #1
    SUBS  W16, W21, #0x427
    SUBS  W5, W20, #0xfb5, LSL #12
    ADDS  X9, X21, W20, UXTB #4
    SUBS  W5, W24, W24, UXTX #2
    SUBS  W28, W25, #0xd39
    ANDS  X11, X8, #0xffffff000000
    ANDS  W27, W16, W15, LSL #31
    ADDS  W16, W20, W28, SXTW #0
    SUBS  X24, X5, W4, UXTW #1
    ANDS  X13, X8, #0xf0007ffff0007fff
    SUBS  X11, X15, W26, SXTW #1
    ANDS  W7, W13, W20, LSR #4
    ANDS  W24, W2, W22, LSR #27
    SUBS  X27, X18, #0xaa9
    ANDS  W11, W7, W14, LSR #26
    SUBS  W19, W9, W26, LSR #22
    SUBS  X16, X14, #0x750
    ADDS  X11, X14, #0x7e9, LSL #12
    SUBS  W20, W16, #0xf65
    ANDS  X5, X22, X19, ROR #59
    ANDS  W21, W25, #0x801f801f
    FCMPE  S24, #0.0
    SUBS  X15, X17, X23, UXTX #2
    SUBS  W15, W28, W19, SXTH #2
    ANDS  W28, W25, W18, LSR #13
    ADDS  W11, W19, W15, LSR #6
    ADDS  X10, X15, X5, ASR #4
    ANDS  X8, X22, #0x1ffe00001ffe000
    SUBS  X24, X8, #0xa85, LSL #12
    ADDS  W21, W20, W20, LSR #11
    ADDS  X22, X22, W21, SXTB #4
    ADDS  W20, W27, #0xde4, LSL #12
    ANDS  W17, W24, #0xe1ffe1ff
    ADDS  X14, X11, X6, LSR #3
    ANDS  X4, X9, X7, ROR #21
    FCMPE  D2, D24
    ADDS  X4, X22, #0xe21
    ADDS  X10, X14, W11, UXTH #1
    SUBS  X9, X9, #0x51b
    ADDS  X11, X20, #0x620
    SUBS  W26, W17, #0xa6b, LSL #12
    SUBS  X14, X16, #0x308
    ANDS  X5, X27, X10, ROR #19
    ADDS  W8, W16, #0x45a
    ANDS  W2, W21, W23, ROR #15
    ADDS  X29, X11, #0x2de, LSL #12
    ADDS  X17, X8, #0xac0
    SUBS  W19, W28, W14, LSR #19
    ADDS  X28, X20, W15, SXTH #4
    SUBS  X24, X19, #0x30b, LSL #12
    SUBS  X16, X5, X6, UXTX #3
    SUBS  W23, W2, W17, UXTW #3
    ADDS  W23, W20, W2, LSL #15
    SUBS  W18, W19, W29, ASR #12
    ADDS  W12, W14, #0x1c6
    ADDS  X8, X9, W8, SXTH #4
    SUBS  X11, X9, #0xb1c
    ANDS  X14, X26, X23, ROR #36
    ADDS  X11, X11, X23, LSL #16
    ANDS  X18, X14, X11, LSR #32
    ANDS  W22, W17, #0xfe0
    ANDS  W29, W6, W7, ROR #15
    ADDS  W26, W11, #0xa00
    SUBS  X16, X26, X27, LSR #40
    SUBS  X8, X2, W27, SXTB #2
    ADDS  W8, W11, W10, LSR #26
    SUBS  X15, X2, W22, UXTH #2
    FCMPE  S27, #0.0
    SUBS  W15, W24, W20, ASR #16
    SUBS  X12, X13, #0x6e
    SUBS  W9, W23, W29, UXTB #2
    SUBS  X26, X24, X15, LSL #36
    SUBS  X12, X22, X12, ASR #12
    ANDS  W24, W2, #0xffc3ffc3
    ADDS  W24, W27, W29, SXTX #3
    ADDS  W18, W25, W24, LSR #25
    ADDS  W12, W9, #0x36f
    ADDS  X12, X22, X22, LSL #30
    ADDS  X15, X22, W28, SXTH #4
    ANDS  X16, X17, X18, ROR #56
    SUBS  X15, X8, W11, UXTH #0
    ADDS  X10, X26, X10, LSR #14
    ANDS  X28, X27, X15, ASR #48
    SUBS  X9, X22, W17, UXTH #4
    FCMPE  S11, #0.0
    ADDS  W27, W11, W6, LSL #8
    ANDS  W13, W5, #0xc0
    ADDS  W9, W28, W27, UXTW #0
    ADDS  X15, X18, W25, UXTW #2
    ANDS  W9, W14, #0x1f
    ADDS  W17, W16, W15, LSR #30
    SUBS  W17, W10, W28, UXTB #4
    SUBS  W14, W5, W16, LSL #24
    ADDS  W5, W23, #0x69c
    SUBS  W10, W17, W23, LSL #4
    SUBS  X8, X27, X7, SXTX #3
    SUBS  X9, X14, X5, LSL #15
    SUBS  X17, X16, #0xfd9, LSL #12
    SUBS  W23, W22, W28, ASR #1
    ANDS  X4, X10, #0xfc000000001fffff
    ADDS  W27, W5, #0x623, LSL #12
    ADDS  X6, X15, X18, LSL #63
    SUBS  X24, X5, X6, LSL #44
    SUBS  X16, X8, W28, UXTB #1
    SUBS  X7, X13, X9, SXTX #0
    ADDS  X10, X6, X12, SXTX #3
    ANDS  W14, W15, #0x1ffe
    ADDS  W4, W11, W17, SXTW #1
    ANDS  X2, X8, #0xfc01fc01fc01fc01
    FCMPE  S22, #0.0
    SUBS  X12, X8, #0xda3
    ADDS  X12, X6, #0xb28
    SUBS  W2, W2, W8, UXTH #4
    ADDS  W29, W23, W22, ASR #25
    ANDS  X5, X4, X24, ROR #62
    ANDS  W24, W24, W6, LSR #3
    SUBS  W17, W2, W9, SXTH #4
    SUBS  W24, W18, W4, LSR #10
    ANDS  W28, W12, #0x1e001e0
    FCMPE  D22, #0.0
    ANDS  X11, X17, X18, LSL #34
    ANDS  X8, X27, X15, LSL #34
    SUBS  W16, W19, #0x3d2, LSL #12
    SUBS  X28, X14, W11, UXTB #1
    SUBS  W28, W6, W13, UXTH #1
    ADDS  W28, W2, W15, SXTH #2
    ANDS  W18, W2, #0x3ffffe
    SUBS  X2, X7, X12, LSL #5
    SUBS  X9, X19, X18, LSR #57
    ANDS  W17, W9, W24, LSL #20
    ANDS  X2, X12, #0x3fffff003fffff0
    ADDS  X5, X2, X6, UXTX #3
    ADDS  W27, W27, W28, UXTX #4
    ADDS  W9, W10, #0x481
    ADDS  X6, X5, X10, LSL #61
    FCMPE  S20, #0.0
    ADDS  W29, W23, #0xb1b
    ADDS  X14, X2, #0x8c4
    SUBS  W6, W8, #0xacc, LSL #12
    ANDS  X21, X10, #0xfffffffe003fffff
    ADDS  W22, W5, W2, LSR #8
    ANDS  W11, W13, W14, ROR #30
    ADDS  X18, X10, W4, UXTW #2
    SUBS  X5, X29, X2, LSR #45
    FCMP  S1, #0.0
    ANDS  X10, X2, X5, ROR #4
    SUBS  X8, X28, W2, SXTH #3
    SUBS  W9, W21, W9, SXTW #4
    FCMPE  D5, #0.0
    FCMPE  D26, #0.0
    ANDS  X12, X4, X19, LSR #27
    ADDS  X15, X5, #0xb21, LSL #12
    ADDS  X20, X16, X17, LSL #8
    SUBS  X12, X20, X27, ASR #17
    SUBS  W8, W19, W26, LSL #17
    ADDS  W5, W11, W9, ASR #26
    SUBS  W8, W5, #0x5f0
    SUBS  X13, X9, #0xaae, LSL #12
    SUBS  X23, X26, X19, LSL #43
    SUBS  X24, X28, #0xd28
    ADDS  X5, X6, X27, LSR #15
    ANDS  W12, W27, #0x3f0000
    SUBS  X18, X8, #0x770
    ADDS  W21, W27, #0x720, LSL #12
    SUBS  X4, X15, X16, LSR #4
    FCMP  S15, #0.0
    SUBS  X10, X25, W2, SXTW #0
    FCMPE  S29, S31
    ADDS  W19, W26, W13, UXTB #0
    ANDS  X20, X23, X26, ASR #41
    ADDS  X11, X20, W29, UXTB #2
    SUBS  W26, W24, W19, LSR #14
    SUBS  X25, X25, #0x1
    B.NE  TaishanIntCcP01_label_670
    MOVZ  X6, #0xb20, LSL #0
    SUB  X11, X6, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X19, #0xf783, LSL #0
    MOVK  X19, #0xf0b5, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X6, X19, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X8, #0xc993, LSL #0
    MOVK  X8, #0xff54, LSL #16
    SUB  X12, X8, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntCcP01_TestFail
    MOVZ  X8, #0xf7ce, LSL #0
    MOVK  X8, #0x1768, LSL #16
    MOVK  X8, #0x273, LSL #32
    SUB  X9, X8, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntCcP01_TestFail
    MOVZ  X22, #0xf7ce, LSL #0
    MOVK  X22, #0x1768, LSL #16
    MOVK  X22, #0x273, LSL #32
    SUB  X10, X22, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntCcP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntCcP01_TestFail
    MOVZ  X26, #0x24fb, LSL #0
    MOVK  X26, #0xb2, LSL #16
    SUB  X11, X26, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X29, #0xd783, LSL #0
    MOVK  X29, #0xffc2, LSL #16
    SUB  X23, X29, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x5870, LSL #16
    SUB  X2, X26, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X10, #0xf29f, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X12, X10, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X22, #0xf783, LSL #0
    MOVK  X22, #0xf0b5, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X21, X22, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X29, #0x582, LSL #0
    MOVK  X29, #0x1, LSL #16
    SUB  X19, X29, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X6, X8, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X14, #0xf783, LSL #0
    MOVK  X14, #0xf0b5, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X27, X14, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntCcP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntCcP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntCcP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X26
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X29
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
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
TaishanIntCcP01_label_202:
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    MOVZ  X21, #0x14, LSL #0
TaishanIntCcP01_label_697:
    SUBS  X28, X27, #0xb0f
    ADDS  W17, W28, W23, LSL #31
    SUBS  W17, W17, #0x809, LSL #12
    ANDS  X13, X13, #0xffffffe0000003ff
    ANDS  X25, X25, X15, ASR #12
    SUBS  X24, X15, #0x79f, LSL #12
    SUBS  W20, W9, #0x40
    SUBS  W20, W12, W22, LSL #12
    ANDS  W20, W8, W24, ROR #4
    ADDS  X20, X18, W20, UXTH #1
    FCMPE  D25, #0.0
    SUBS  X2, X5, X20, SXTX #2
    SUBS  W18, W7, W5, UXTB #1
    ADDS  W27, W25, W5, SXTB #0
    SUBS  W25, W18, W29, UXTX #3
    SUBS  W17, W16, #0x570
    ANDS  W27, W25, W21, ASR #5
    SUBS  X12, X25, X24, LSL #33
    ANDS  X13, X9, X20, ROR #3
    ANDS  W25, W19, #0xff7fffff
    SUBS  W18, W8, #0xaed, LSL #12
    ADDS  W23, W17, #0x8a9
    SUBS  W25, W29, W17, LSR #10
    SUBS  W15, W25, W15, LSR #24
    ADDS  W15, W2, W24, ASR #4
    SUBS  W12, W28, W9, LSL #4
    SUBS  X17, X27, W5, UXTH #0
    ANDS  W27, W9, W7, LSL #24
    ADDS  W27, W6, W13, ASR #27
    SUBS  X23, X26, #0xe7a
    ADDS  X6, X23, W17, SXTH #4
    ANDS  W4, W7, #0x3c3c3c3c
    ADDS  W23, W14, W14, ASR #31
    ANDS  X25, X12, #0xf8000000f800000
    SUBS  X7, X22, X16, LSR #63
    ADDS  W16, W26, W4, UXTH #2
    SUBS  W19, W21, W17, SXTW #2
    SUBS  W14, W23, #0x294
    ADDS  W10, W5, #0x494
    ANDS  W2, W26, #0xc000007f
    ANDS  W11, W25, #0x30303030
    ANDS  X7, X7, #0x1f80000000
    SUBS  W23, W6, #0xef0
    ANDS  X10, X19, #0x1fc000
    SUBS  W6, W11, #0x736, LSL #12
    ADDS  W4, W8, W7, LSL #13
    ANDS  W11, W5, #0xfffffe0
    SUBS  W6, W19, #0x19e, LSL #12
    SUBS  W7, W22, W27, ASR #20
    SUBS  W12, W19, W26, ASR #31
    SUBS  W16, W19, #0x801
    ADDS  X6, X2, X10, UXTX #3
    SUBS  X9, X14, #0xc00
    ANDS  X11, X14, #0x9fff9fff9fff9fff
    SUBS  X17, X4, W17, UXTB #1
    SUBS  W14, W25, #0x4c4, LSL #12
    ADDS  W12, W26, W27, SXTX #3
    SUBS  X8, X11, W21, SXTW #4
    ADDS  X29, X28, X13, UXTX #4
    ADDS  X9, X19, #0x2e0
    SUBS  W6, W25, W28, UXTW #2
    FCMPE  D29, D23
    ANDS  W9, W5, #0x1f000000
    ADDS  W28, W12, #0xda6
    SUBS  W25, W9, W9, ASR #1
    ANDS  X18, X7, X16, ROR #62
    ADDS  X17, X8, #0x2e
    SUBS  W26, W19, W5, SXTW #3
    ADDS  W24, W15, W28, UXTB #2
    SUBS  W10, W29, W24, SXTB #1
    ADDS  X11, X11, X21, LSR #46
    ADDS  W22, W15, W14, UXTB #4
    SUBS  X20, X23, X10, UXTX #4
    SUBS  X28, X21, #0x925
    ADDS  X5, X12, #0xa9e, LSL #12
    SUBS  X12, X8, X22, LSL #34
    SUBS  W27, W11, #0x15
    ADDS  W6, W20, W29, UXTW #2
    FCMPE  S26, #0.0
    SUBS  X28, X22, #0xd0
    SUBS  W11, W15, #0x5f6, LSL #12
    ADDS  W8, W25, W20, UXTX #0
    ANDS  X6, X29, #0xf803fffff803ffff
    ANDS  X7, X18, X4, LSR #47
    ANDS  X15, X4, #0xfffffe00003fffff
    ADDS  X10, X10, W28, SXTB #3
    ADDS  X15, X27, X22, LSR #57
    FCMP  D16, #0.0
    ANDS  X17, X12, #0x7fe07fe07fe07fe
    SUBS  X15, X17, X21, ASR #10
    FCMPE  D24, D4
    ANDS  X26, X14, X25, LSL #45
    ADDS  W17, W29, W10, LSL #20
    ANDS  W7, W25, #0xffff003f
    ANDS  X14, X15, X26, LSL #52
    ANDS  W6, W16, W6, LSL #22
    ADDS  W16, W10, W5, ASR #27
    ADDS  W25, W23, W19, UXTW #2
    SUBS  X8, X27, W27, UXTW #1
    ADDS  W29, W16, W18, UXTB #3
    ANDS  W9, W17, W27, ASR #12
    SUBS  W18, W6, #0x222, LSL #12
    ADDS  W23, W19, #0x662
    SUBS  X28, X23, X24, LSL #57
    ANDS  X13, X14, X29, LSR #58
    ADDS  X5, X7, W13, UXTH #0
    SUBS  W27, W9, W21, ASR #0
    SUBS  X27, X10, X11, LSL #43
    SUBS  X5, X16, X15, LSR #34
    ADDS  X5, X5, X2, LSR #39
    SUBS  W10, W16, W16, UXTW #3
    SUBS  X28, X28, W12, UXTW #0
    SUBS  X7, X29, #0xa39, LSL #12
    ADDS  X26, X18, X24, LSR #38
    SUBS  W16, W11, #0xaae, LSL #12
    ADDS  X26, X22, #0xd20
    FCMP  D17, #0.0
    ANDS  W13, W22, #0xfffc03ff
    SUBS  W9, W18, #0x8a4
    ADDS  W26, W16, #0xcbf
    ANDS  X17, X12, #0xfc00000000001fff
    ANDS  W22, W21, W26, ASR #13
    ANDS  W20, W14, #0x40004000
    SUBS  W20, W23, W22, LSR #14
    ANDS  X15, X5, #0xfff8000ffff8000f
    ADDS  X10, X13, X9, LSR #24
    SUBS  W14, W27, W8, LSL #10
    SUBS  W6, W9, W12, UXTW #2
    ADDS  W9, W26, #0xea3, LSL #12
    ADDS  W14, W28, W7, LSR #28
    ANDS  W24, W11, #0x3f000000
    ADDS  X6, X12, #0x9a8, LSL #12
    ADDS  W26, W4, #0x261
    ANDS  X27, X15, X26, LSR #24
    ADDS  W2, W26, W13, LSR #15
    ADDS  X14, X17, X9, LSR #54
    SUBS  W15, W20, W22, UXTX #3
    ADDS  X19, X4, W15, UXTW #4
    ADDS  X11, X26, W6, SXTH #3
    FCMP  D27, #0.0
    ANDS  X10, X8, X10, ROR #54
    ADDS  X9, X27, #0x4a8
    ADDS  X23, X20, W21, UXTB #0
    SUBS  W28, W11, W12, SXTW #0
    SUBS  X12, X21, #0xfc
    ANDS  W13, W17, W16, LSR #27
    SUBS  W29, W19, W4, ASR #17
    SUBS  W26, W22, W28, ASR #15
    SUBS  W22, W22, W15, SXTH #4
    ADDS  X28, X17, W26, SXTB #3
    ANDS  W2, W8, W5, ASR #4
    SUBS  W23, W19, #0x83e
    ADDS  W19, W18, #0xc30
    ADDS  X13, X24, X15, ASR #1
    SUBS  X19, X21, W15, SXTB #3
    ADDS  W26, W28, W12, ASR #9
    ANDS  X28, X18, X17, LSR #38
    ANDS  X16, X14, X11, ROR #48
    SUBS  X7, X27, W26, UXTW #4
    ADDS  W28, W22, W4, LSR #4
    FCMP  D12, D23
    ADDS  X13, X10, #0x841
    SUBS  W2, W24, W14, UXTW #4
    ADDS  X14, X5, #0x47d
    SUBS  W8, W6, W7, SXTW #4
    ANDS  X7, X27, #0xfffe00003fffffff
    ANDS  W14, W19, #0x7ffc7ffc
    SUBS  X23, X20, X14, LSL #59
    SUBS  W18, W6, W10, LSL #20
    SUBS  W10, W27, #0xddb
    ANDS  W5, W25, W16, LSR #2
    SUBS  W28, W18, W19, UXTH #2
    SUBS  X27, X4, X15, LSL #5
    ADDS  X20, X28, W29, UXTH #2
    ADDS  W4, W17, W16, LSR #22
    SUBS  X15, X9, W2, UXTW #0
    SUBS  X23, X10, X14, ASR #41
    ANDS  W12, W22, #0xfffffe01
    ADDS  W16, W7, #0x639
    ADDS  W4, W15, W19, LSR #3
    ADDS  W5, W29, #0x1c
    ANDS  W13, W17, #0x8000800
    FCMPE  S24, #0.0
    ANDS  W12, W13, W7, LSR #17
    ADDS  X16, X24, W8, SXTH #2
    ADDS  X2, X22, W5, SXTH #3
    ADDS  X12, X13, W9, UXTW #1
    ADDS  X15, X29, #0xd3f
    ADDS  X10, X10, #0x760
    SUBS  W16, W11, #0xdde, LSL #12
    SUBS  W17, W10, W16, UXTB #4
    ANDS  X26, X14, #0xfffffc00fffffc
    SUBS  X28, X5, W16, SXTH #0
    ANDS  W5, W15, W20, ASR #25
    ADDS  X2, X2, #0xea7, LSL #12
    ADDS  X12, X13, X27, LSL #30
    ADDS  X23, X20, W19, SXTH #2
    SUBS  W4, W16, W17, ASR #28
    ADDS  X2, X5, #0xcb4, LSL #12
    ANDS  W6, W21, W5, LSL #4
    SUBS  X21, X21, #0x1
    B.NE  TaishanIntCcP01_label_697
    MOVZ  X7, #0x4010, LSL #0
    MOVK  X7, #0xcb, LSL #16
    SUB  X4, X7, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntCcP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x10, LSL #0
    SUB  X5, X13, X5
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntCcP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X21, #0x4010, LSL #0
    MOVK  X21, #0xcb, LSL #16
    SUB  X10, X21, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x773c, LSL #0
    MOVK  X2, #0x20af, LSL #16
    SUB  X21, X2, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x4a8, LSL #0
    SUB  X9, X13, X9
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntCcP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X13, X12, X10
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntCcP01_TestFail
    MOVZ  X29, #0xde25, LSL #0
    MOVK  X29, #0xa0b2, LSL #16
    SUB  X22, X29, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X20, X13, X13
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X24, #0x328, LSL #0
    SUB  X23, X24, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X15
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X18, #0xfe25, LSL #0
    MOVK  X18, #0x9fd4, LSL #16
    SUB  X8, X18, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X4, #0xf735, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X26, X4, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X16, #0xfe25, LSL #0
    MOVK  X16, #0x9fd4, LSL #16
    SUB  X9, X16, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntCcP01_TestFail
    MOVZ  X15, #0x329, LSL #0
    SUB  X6, X15, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X5, X16, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X18, #0x328, LSL #0
    SUB  X26, X18, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X12, #0x617a, LSL #0
    MOVK  X12, #0xfc, LSL #16
    SUB  X23, X12, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X7, #0x2684, LSL #0
    MOVK  X7, #0xa0b5, LSL #16
    SUB  X10, X7, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntCcP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntCcP01_TestFail
    MOVZ  X7, #0xde25, LSL #0
    MOVK  X7, #0xa0b2, LSL #16
    SUB  X15, X7, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x0, LSL #0
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
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X4, #0x14, LSL #0
TaishanIntCcP01_label_725:
    ANDS  W15, W15, W19, ASR #10
    ADDS  X14, X17, #0x8d0
    SUBS  W11, W29, W25, LSR #22
    ADDS  W8, W13, W2, ASR #5
    ADDS  X16, X21, X26, ASR #16
    SUBS  X14, X21, W25, SXTH #4
    ADDS  W28, W8, W15, ASR #9
    SUBS  W24, W9, #0x1c5, LSL #12
    ADDS  X12, X20, #0x9e8
    SUBS  W24, W14, W4, LSL #15
    ADDS  W13, W22, #0xe38, LSL #12
    ADDS  W5, W19, W2, LSL #2
    ADDS  W25, W9, W9, LSR #30
    ADDS  W12, W24, W20, LSL #27
    SUBS  W13, W4, #0x0
    SUBS  X11, X5, W26, UXTW #4
    SUBS  X18, X20, #0x8d, LSL #12
    ADDS  X15, X22, W18, SXTB #2
    SUBS  X26, X4, W6, SXTH #1
    SUBS  W17, W27, W26, SXTW #0
    SUBS  W16, W26, W11, UXTB #4
    SUBS  X25, X19, X17, LSR #23
    SUBS  W25, W29, W28, UXTH #0
    SUBS  X17, X28, #0x180
    ADDS  X27, X15, W7, SXTW #2
    SUBS  X16, X27, #0xddc
    ANDS  X7, X6, #0xe0e0e0e0e0e0e0e
    ADDS  W16, W22, W11, UXTH #3
    ADDS  W6, W27, W14, UXTX #4
    ANDS  W26, W14, #0x60000
    ADDS  W13, W11, W13, UXTW #2
    ANDS  X14, X25, X25, LSR #11
    FCMPE  D16, D14
    ANDS  W16, W19, #0x1f8
    ADDS  X2, X29, X11, LSR #8
    SUBS  X2, X18, #0x994
    ANDS  X24, X24, #0x7fe07fe07fe07fe
    SUBS  X22, X19, W29, UXTH #4
    SUBS  W16, W24, #0xc80
    ANDS  X21, X2, #0x38003800380038
    SUBS  X8, X29, X28, LSL #49
    FCMPE  S13, #0.0
    SUBS  X8, X12, W25, UXTH #1
    SUBS  X19, X29, W14, UXTB #2
    FCMPE  S14, #0.0
    ADDS  X24, X10, W6, UXTB #4
    ANDS  W23, W14, #0xff000001
    FCMPE  S15, #0.0
    ADDS  W29, W4, W27, SXTX #4
    SUBS  W21, W13, W12, LSR #7
    FCMP  S11, #0.0
    SUBS  W13, W5, W21, SXTH #2
    ANDS  X25, X13, #0x3e00000
    FCMP  S21, S23
    SUBS  X17, X29, X25, ASR #24
    ADDS  X11, X27, W19, SXTB #1
    ADDS  W22, W10, W2, ASR #17
    SUBS  W18, W12, #0xc0
    ADDS  X14, X13, X4, LSR #56
    FCMPE  S18, S22
    ADDS  X23, X6, X25, LSL #16
    ADDS  W15, W7, #0xf05
    FCMP  D20, #0.0
    ADDS  X6, X8, #0x8d5
    SUBS  W5, W2, W9, UXTX #4
    ANDS  X5, X29, X17, LSL #58
    ADDS  X7, X20, X17, LSL #35
    SUBS  W17, W16, W25, UXTX #4
    ANDS  X28, X29, #0x1fffffff1fffffff
    ANDS  W7, W7, W22, LSR #6
    ANDS  W21, W18, W15, ASR #7
    ANDS  W19, W21, W11, ROR #20
    ANDS  X12, X16, #0xffffffffffff01ff
    ADDS  X8, X5, X7, ASR #8
    ANDS  X23, X11, #0xfffff80fffffffff
    ADDS  X11, X19, X8, ASR #57
    SUBS  X2, X28, W13, SXTW #3
    SUBS  W16, W4, #0x654, LSL #12
    ADDS  W22, W4, W21, ASR #23
    SUBS  X10, X7, #0x713
    ANDS  X28, X11, X5, ASR #41
    SUBS  X22, X17, #0xf97
    SUBS  X19, X28, X14, ASR #24
    ADDS  X11, X27, X23, ASR #32
    ANDS  X26, X16, X18, ASR #10
    ADDS  W5, W19, W28, LSL #13
    ANDS  W21, W19, W4, ASR #11
    SUBS  X24, X18, X23, ASR #11
    SUBS  W25, W23, W16, UXTH #2
    ADDS  W17, W22, W17, UXTW #0
    ADDS  X13, X17, X25, LSR #59
    SUBS  X7, X26, X28, ASR #3
    SUBS  X13, X27, X12, ASR #60
    SUBS  W8, W5, W15, SXTH #3
    SUBS  X29, X18, X8, LSL #38
    ANDS  X28, X10, X8, LSR #0
    ANDS  X9, X5, #0x803f803f803f803f
    ANDS  W23, W12, W29, LSL #20
    ADDS  X23, X2, X10, ASR #2
    ANDS  W21, W9, #0x7800780
    ADDS  W10, W22, #0xda, LSL #12
    SUBS  W26, W4, #0x184, LSL #12
    FCMP  S12, #0.0
    ADDS  W8, W18, W11, UXTX #3
    SUBS  W27, W29, W23, LSL #10
    SUBS  X29, X24, X24, SXTX #0
    ADDS  X23, X11, W6, SXTW #1
    FCMPE  S23, #0.0
    SUBS  X28, X10, W25, SXTW #3
    SUBS  X6, X18, W7, SXTB #0
    SUBS  W26, W21, W6, UXTH #1
    SUBS  X6, X27, X22, ASR #54
    SUBS  X26, X16, W18, SXTH #3
    SUBS  W27, W8, #0x5be, LSL #12
    ADDS  W25, W27, W27, ASR #27
    SUBS  W19, W26, W9, UXTW #3
    ADDS  W8, W13, W14, ASR #27
    FCMP  D12, D17
    ADDS  W25, W24, W28, LSL #27
    ANDS  X11, X25, #0xe000e000e000e00
    FCMP  S23, S21
    SUBS  W15, W17, #0x120
    ADDS  W29, W7, W13, UXTX #4
    ADDS  W29, W11, W18, ASR #21
    SUBS  X22, X20, X13, ASR #39
    SUBS  W16, W21, #0x4c1
    ADDS  X17, X14, X29, LSL #55
    SUBS  X2, X14, #0xf90
    SUBS  X14, X5, #0xa33
    ANDS  X19, X22, #0xffffc00001ffffff
    ANDS  X21, X23, #0xc7ffc7ffc7ffc7ff
    ANDS  X20, X6, #0xfe01fe01fe01fe01
    ADDS  W19, W7, #0x69c, LSL #12
    ADDS  X29, X21, #0x664
    SUBS  X20, X25, X10, ASR #58
    SUBS  W9, W10, W7, SXTW #2
    FCMPE  S17, #0.0
    SUBS  W20, W11, W10, SXTH #4
    SUBS  X6, X12, #0xcc1
    ADDS  X29, X25, X23, LSR #41
    SUBS  W24, W19, #0x784, LSL #12
    ADDS  X7, X12, W16, SXTH #1
    ANDS  W2, W10, #0x400000
    SUBS  X24, X9, X28, ASR #18
    FCMPE  S12, #0.0
    ADDS  W28, W2, W4, LSL #7
    ADDS  W29, W14, #0x5f9, LSL #12
    ANDS  X7, X29, #0xfffff3fffffff3ff
    ANDS  W6, W12, #0x33333333
    ADDS  X14, X28, #0xf11
    ADDS  W7, W28, W14, ASR #16
    ADDS  X16, X7, X29, ASR #25
    ADDS  X6, X23, #0x831, LSL #12
    ADDS  W9, W26, W23, SXTW #3
    SUBS  W13, W8, W15, LSL #15
    SUBS  W19, W20, #0x50e
    ADDS  W12, W26, #0x758, LSL #12
    ANDS  W23, W25, W6, ROR #25
    ADDS  X10, X28, X6, UXTX #3
    ANDS  X20, X15, #0xfffffffffc7fffff
    ADDS  W5, W16, #0xd23
    SUBS  W29, W4, #0x532
    ANDS  X25, X23, X12, ROR #44
    ANDS  W12, W5, W17, ROR #2
    ADDS  X16, X6, X28, UXTX #0
    FCMPE  S31, S30
    ADDS  X18, X9, W20, SXTB #4
    ANDS  X17, X15, #0xffffffffffff0003
    ANDS  W22, W23, #0x100010
    SUBS  W11, W2, #0x2c9
    ADDS  X26, X16, W27, UXTW #4
    SUBS  W28, W29, W15, SXTW #0
    ANDS  X10, X8, X13, LSL #42
    ANDS  W8, W29, W18, LSR #20
    ADDS  W18, W16, #0xbc2, LSL #12
    SUBS  W12, W10, #0xb61, LSL #12
    ADDS  W29, W6, #0xfc0
    FCMP  D26, #0.0
    FCMPE  S21, S25
    SUBS  X8, X24, #0x1f3
    FCMPE  S18, S29
    FCMP  S30, #0.0
    SUBS  W2, W21, W12, SXTW #4
    ADDS  X19, X21, X21, SXTX #4
    ADDS  X6, X20, X21, LSR #6
    FCMP  D27, D6
    ANDS  W27, W20, #0x1ffe1ffe
    SUBS  W10, W2, #0xffa, LSL #12
    ANDS  W22, W11, W9, ASR #0
    SUBS  X22, X24, X28, LSR #7
    ADDS  X24, X15, W12, UXTB #3
    ADDS  W7, W27, W8, UXTX #3
    ADDS  X27, X5, X7, LSL #33
    ANDS  X11, X18, X25, ROR #55
    SUBS  X27, X9, X17, SXTX #0
    ADDS  W8, W28, #0x530
    SUBS  W29, W5, #0xa8a, LSL #12
    SUBS  X8, X24, #0xe23, LSL #12
    SUBS  X11, X13, W12, SXTW #1
    SUBS  W27, W11, W18, SXTH #2
    SUBS  X4, X4, #0x1
    B.NE  TaishanIntCcP01_label_725
    MOVZ  X19, #0xc724, LSL #0
    MOVK  X19, #0xcc6b, LSL #16
    SUB  X2, X19, X2
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X5, #0x9d9, LSL #0
    MOVK  X5, #0xe73c, LSL #16
    SUB  X18, X5, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntCcP01_TestFail
    MOVZ  X7, #0x7074, LSL #0
    MOVK  X7, #0x973c, LSL #16
    SUB  X2, X7, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X16, #0xaebd, LSL #0
    MOVK  X16, #0xe3d5, LSL #16
    SUB  X5, X16, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntCcP01_TestFail
    MOVZ  X27, #0x5d51, LSL #0
    MOVK  X27, #0xc7f2, LSL #16
    SUB  X9, X27, X9
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntCcP01_TestFail
    MOVZ  X10, #0x2724, LSL #0
    MOVK  X10, #0xcb6c, LSL #16
    SUB  X20, X10, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x857, LSL #0
    MOVK  X13, #0xd261, LSL #16
    SUB  X19, X13, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X8, #0xf000, LSL #0
    MOVK  X8, #0xff49, LSL #16
    SUB  X7, X8, X12
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntCcP01_TestFail
    MOVZ  X22, #0x857, LSL #0
    MOVK  X22, #0xd261, LSL #16
    SUB  X19, X22, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X15, #0xf91, LSL #0
    MOVK  X15, #0x40, LSL #16
    SUB  X26, X15, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X25, #0xf91, LSL #0
    MOVK  X25, #0x40, LSL #16
    SUB  X8, X25, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X27, #0xaebd, LSL #0
    MOVK  X27, #0xe3d5, LSL #16
    SUB  X25, X27, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X7, #0x1, LSL #0
    MOVK  X7, #0xe4b7, LSL #16
    SUB  X26, X7, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X4, X20, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanIntCcP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X5, #0xc724, LSL #0
    MOVK  X5, #0xc10a, LSL #16
    SUB  X28, X5, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x857, LSL #0
    MOVK  X13, #0xd261, LSL #16
    SUB  X12, X13, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X21, #0x900c, LSL #0
    MOVK  X21, #0x400, LSL #16
    SUB  X23, X21, X23
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X26, #0xdebd, LSL #0
    MOVK  X26, #0xe4b7, LSL #16
    SUB  X7, X26, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntCcP01_TestFail
    MOVZ  X26, #0xdebd, LSL #0
    MOVK  X26, #0xe4b7, LSL #16
    SUB  X22, X26, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X24, #0xaebd, LSL #0
    MOVK  X24, #0xe3d5, LSL #16
    SUB  X14, X24, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntCcP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntCcP01_TestFail
    MOVZ  X2, #0xbf9f, LSL #0
    MOVK  X2, #0x76ac, LSL #16
    MOVK  X2, #0x6c4f, LSL #32
    MOVK  X2, #0x65fe, LSL #48
    MOVZ  X4, #0x1a61, LSL #0
    MOVK  X4, #0x9fb7, LSL #16
    MOVK  X4, #0x369, LSL #32
    MOVK  X4, #0xd5, LSL #48
    MOVZ  X5, #0x95e1, LSL #0
    MOVK  X5, #0xbcfc, LSL #16
    MOVK  X5, #0xe46f, LSL #32
    MOVK  X5, #0x3dbc, LSL #48
    MOVZ  X6, #0xc09b, LSL #0
    MOVK  X6, #0x58da, LSL #16
    MOVK  X6, #0x9f3, LSL #32
    MOVK  X6, #0x8b79, LSL #48
    MOVZ  X7, #0xfe54, LSL #0
    MOVK  X7, #0x1470, LSL #16
    MOVK  X7, #0x422f, LSL #32
    MOVK  X7, #0x5d2, LSL #48
    MOVZ  X8, #0xc969, LSL #0
    MOVK  X8, #0x2417, LSL #16
    MOVK  X8, #0x870f, LSL #32
    MOVK  X8, #0x28c0, LSL #48
    MOVZ  X9, #0x6ad8, LSL #0
    MOVK  X9, #0x26a9, LSL #16
    MOVK  X9, #0xe19e, LSL #32
    MOVK  X9, #0xb620, LSL #48
    MOVZ  X10, #0x9680, LSL #0
    MOVK  X10, #0xbd4e, LSL #16
    MOVK  X10, #0x20d, LSL #32
    MOVK  X10, #0x97d0, LSL #48
    MOVZ  X11, #0xd3cd, LSL #0
    MOVK  X11, #0x9710, LSL #16
    MOVK  X11, #0x1e54, LSL #32
    MOVK  X11, #0xa13b, LSL #48
    MOVZ  X12, #0xa498, LSL #0
    MOVK  X12, #0x7505, LSL #16
    MOVK  X12, #0xb5ed, LSL #32
    MOVK  X12, #0x5030, LSL #48
    MOVZ  X13, #0x42cd, LSL #0
    MOVK  X13, #0x637c, LSL #16
    MOVK  X13, #0xa513, LSL #32
    MOVK  X13, #0x816, LSL #48
    MOVZ  X14, #0x3a87, LSL #0
    MOVK  X14, #0xdd61, LSL #16
    MOVK  X14, #0x975a, LSL #32
    MOVK  X14, #0x4f41, LSL #48
    MOVZ  X15, #0x26de, LSL #0
    MOVK  X15, #0x793f, LSL #16
    MOVK  X15, #0x3959, LSL #32
    MOVK  X15, #0x3ce7, LSL #48
    MOVZ  X16, #0x3b45, LSL #0
    MOVK  X16, #0xd5c9, LSL #16
    MOVK  X16, #0x4ddf, LSL #32
    MOVK  X16, #0xfd25, LSL #48
    MOVZ  X17, #0xd23b, LSL #0
    MOVK  X17, #0xf305, LSL #16
    MOVK  X17, #0x17f2, LSL #32
    MOVK  X17, #0xaba3, LSL #48
    MOVZ  X18, #0x5110, LSL #0
    MOVK  X18, #0xdb43, LSL #16
    MOVK  X18, #0xb17, LSL #32
    MOVK  X18, #0x7983, LSL #48
    MOVZ  X19, #0x8688, LSL #0
    MOVK  X19, #0xa3c6, LSL #16
    MOVK  X19, #0xfecd, LSL #32
    MOVK  X19, #0xd9e0, LSL #48
    MOVZ  X20, #0x7414, LSL #0
    MOVK  X20, #0x7a3a, LSL #16
    MOVK  X20, #0xb014, LSL #32
    MOVK  X20, #0x35bf, LSL #48
    MOVZ  X21, #0x4c14, LSL #0
    MOVK  X21, #0xa0f7, LSL #16
    MOVK  X21, #0x25a8, LSL #32
    MOVK  X21, #0x14c2, LSL #48
    MOVZ  X22, #0x48bb, LSL #0
    MOVK  X22, #0xabc0, LSL #16
    MOVK  X22, #0x64e0, LSL #32
    MOVK  X22, #0xeb02, LSL #48
    MOVZ  X23, #0xf85, LSL #0
    MOVK  X23, #0xe6eb, LSL #16
    MOVK  X23, #0xf6ac, LSL #32
    MOVK  X23, #0x844c, LSL #48
    MOVZ  X24, #0xfe08, LSL #0
    MOVK  X24, #0x543b, LSL #16
    MOVK  X24, #0x798c, LSL #32
    MOVK  X24, #0x3541, LSL #48
    MOVZ  X25, #0x215f, LSL #0
    MOVK  X25, #0xba9, LSL #16
    MOVK  X25, #0x5b77, LSL #32
    MOVK  X25, #0x19cd, LSL #48
    MOVZ  X26, #0xf3f2, LSL #0
    MOVK  X26, #0xa561, LSL #16
    MOVK  X26, #0xec73, LSL #32
    MOVK  X26, #0xbefc, LSL #48
    MOVZ  X27, #0xd8b6, LSL #0
    MOVK  X27, #0xb15f, LSL #16
    MOVK  X27, #0x7c43, LSL #32
    MOVK  X27, #0xcfe7, LSL #48
    MOVZ  X28, #0x410f, LSL #0
    MOVK  X28, #0xaca, LSL #16
    MOVK  X28, #0xe9a9, LSL #32
    MOVK  X28, #0x59b, LSL #48
    MOVZ  X29, #0xfd6c, LSL #0
    MOVK  X29, #0x39e8, LSL #16
    MOVK  X29, #0xbb4c, LSL #32
    MOVK  X29, #0x9166, LSL #48
    MOVZ  X8, #0x14, LSL #0
TaishanIntCcP01_label_753:
    SUBS  W4, W25, W15, UXTW #2
    SUBS  W6, W21, #0x7c0
    SUBS  W20, W27, #0x780
    ANDS  W16, W26, W17, LSL #7
    ADDS  W27, W28, W28, LSL #12
    SUBS  X10, X11, #0x39d, LSL #12
    ANDS  X10, X27, X26, ROR #15
    FCMPE  S26, #0.0
    ANDS  X10, X6, #0xfe03ffffffffffff
    SUBS  W18, W25, W22, ASR #2
    SUBS  W19, W2, #0x200
    SUBS  X26, X6, X19, LSL #35
    SUBS  X11, X29, X24, SXTX #0
    ANDS  X23, X2, #0xffffffffffffffc7
    SUBS  W27, W4, #0xe10
    ANDS  W29, W2, #0xf80
    ANDS  X29, X17, #0xffc0ffc0ffc0ffc0
    SUBS  X6, X4, X10, LSR #40
    ADDS  W12, W29, W25, SXTX #0
    SUBS  W28, W11, W17, LSR #4
    ANDS  W12, W27, W4, ROR #10
    ADDS  W6, W5, W29, SXTB #1
    SUBS  X19, X11, W18, SXTW #2
    ANDS  X13, X9, X10, ROR #57
    ADDS  X19, X2, X26, ASR #1
    ANDS  X25, X22, X24, LSR #44
    ADDS  X10, X13, #0x590
    ADDS  X7, X12, X24, LSL #37
    SUBS  W2, W17, #0x666, LSL #12
    ADDS  W4, W9, W28, LSR #1
    SUBS  W23, W2, W21, SXTH #2
    ADDS  X6, X10, X27, LSR #5
    SUBS  X21, X11, #0x5c, LSL #12
    ANDS  W4, W21, #0xf000f000
    SUBS  W6, W19, W6, LSR #16
    ANDS  X10, X13, X25, ASR #62
    SUBS  W13, W12, W10, SXTH #0
    SUBS  X4, X27, X29, ASR #2
    ADDS  W19, W29, #0xb73, LSL #12
    ANDS  W7, W6, #0xf803f803
    SUBS  W10, W6, W7, UXTX #0
    ADDS  X29, X15, #0xb6f, LSL #12
    ADDS  X6, X10, W13, SXTH #0
    ADDS  X20, X19, #0x920, LSL #12
    SUBS  X19, X10, X16, LSR #46
    SUBS  W17, W14, W15, SXTH #2
    ADDS  X24, X4, W24, UXTH #2
    SUBS  W2, W26, W4, LSR #27
    SUBS  W18, W11, W20, SXTH #2
    ADDS  W20, W16, W29, LSL #24
    ADDS  W22, W2, W16, LSL #20
    SUBS  X6, X11, #0x33c, LSL #12
    ADDS  W12, W27, W19, LSL #23
    ADDS  W21, W23, W25, ASR #5
    SUBS  W25, W11, #0x690
    ADDS  W14, W4, W22, SXTH #1
    SUBS  X27, X18, #0xf5c, LSL #12
    SUBS  X13, X27, X2, ASR #19
    FCMP  D7, D6
    SUBS  W29, W18, W17, LSL #18
    ADDS  X16, X19, #0xd12
    ANDS  W9, W27, #0xfc00fc0
    ANDS  X23, X12, X29, LSR #33
    SUBS  W4, W14, W15, LSR #3
    SUBS  W10, W24, #0x4df
    ANDS  W14, W23, W9, LSR #4
    ADDS  W2, W19, W9, SXTB #0
    SUBS  W4, W5, #0x8b0
    FCMP  S8, S9
    SUBS  X23, X23, #0xa12, LSL #12
    ADDS  W12, W23, W11, ASR #29
    FCMPE  S29, #0.0
    ANDS  W25, W18, W23, ASR #31
    ADDS  X27, X4, #0x5d8
    ANDS  W6, W11, #0x3ff83ff8
    ADDS  X21, X11, #0xeea, LSL #12
    SUBS  X5, X29, W24, SXTH #0
    SUBS  W10, W12, W22, LSL #15
    ANDS  W2, W27, W10, LSR #25
    FCMPE  S26, #0.0
    ANDS  X19, X9, X15, ASR #11
    ANDS  W15, W22, W7, LSL #7
    SUBS  W19, W11, W10, SXTH #1
    ADDS  X19, X10, X10, SXTX #0
    ADDS  X10, X9, X15, LSR #11
    SUBS  W28, W14, W14, ASR #17
    SUBS  X5, X27, X15, LSL #23
    SUBS  X24, X26, W8, SXTB #1
    ADDS  W11, W5, W13, LSL #29
    ADDS  W14, W14, #0xed4, LSL #12
    ADDS  X4, X11, X8, ASR #8
    ADDS  X15, X22, #0x8b5, LSL #12
    SUBS  X24, X28, X18, SXTX #2
    ANDS  X14, X29, X29, LSR #26
    ANDS  W6, W24, #0xf000000
    ADDS  W11, W15, #0xe44
    ANDS  W13, W24, W29, ROR #30
    ADDS  X4, X4, X10, LSL #36
    FCMP  D25, #0.0
TaishanIntCcP01_label_564:
    ADDS  W19, W22, W23, SXTH #3
    ADDS  X22, X15, #0x54, LSL #12
    ADDS  W28, W5, W19, LSR #6
    ADDS  X9, X12, W25, SXTW #1
    ANDS  W11, W6, #0xe3ffe3ff
    SUBS  W28, W19, W23, UXTX #2
    SUBS  X26, X11, #0x64f
    ANDS  W23, W20, W4, LSR #26
    ADDS  X29, X10, #0xedc
    ADDS  X9, X18, W13, SXTH #3
    ANDS  X14, X26, X28, ROR #59
    ANDS  X26, X19, X4, LSL #12
    ADDS  X25, X10, X9, LSR #9
    FCMPE  S17, S31
    ADDS  W19, W27, #0x4a7, LSL #12
    SUBS  W26, W28, #0x59b
    ADDS  W29, W19, #0x608, LSL #12
    ADDS  X9, X2, #0x29d, LSL #12
    ANDS  W21, W7, #0xf0007fff
    SUBS  W26, W29, #0x141
    SUBS  W11, W12, W7, UXTH #3
    ADDS  W16, W20, W11, UXTH #3
    SUBS  X6, X8, X6, ASR #24
    SUBS  W27, W9, W26, UXTB #4
    SUBS  W13, W5, W23, LSL #29
    ADDS  X18, X22, #0x892
    ADDS  W23, W28, W17, LSR #22
    ADDS  X7, X9, X15, LSL #16
    ADDS  W9, W17, W2, LSR #31
    ADDS  W21, W25, W20, SXTW #1
    ADDS  W15, W19, #0xa18, LSL #12
    SUBS  W5, W18, #0x3a0
    ADDS  W14, W13, W12, SXTW #3
    ANDS  W29, W9, W17, ROR #18
    SUBS  W17, W13, W21, UXTW #3
    FCMP  D23, D8
    ADDS  W4, W26, W6, UXTH #4
    ADDS  X21, X13, X25, ASR #7
    SUBS  W12, W25, W28, LSL #4
    ADDS  X27, X29, W15, UXTW #2
    SUBS  X12, X29, X22, LSL #63
    ADDS  X17, X20, #0x83d, LSL #12
    ADDS  W29, W27, W20, UXTB #0
    SUBS  X16, X14, X29, ASR #62
    SUBS  X29, X13, W23, UXTW #1
    SUBS  X16, X4, W2, SXTW #0
    SUBS  W15, W11, W16, SXTB #1
    SUBS  W18, W7, W2, ASR #14
    SUBS  X9, X13, #0x430, LSL #12
    SUBS  X10, X8, W19, SXTW #1
    SUBS  W10, W5, W10, UXTB #4
    ADDS  X17, X9, X16, ASR #7
    ADDS  X5, X10, #0xb58
    SUBS  X29, X21, W7, SXTB #2
    ADDS  X21, X15, #0x769, LSL #12
    ANDS  W13, W7, W25, ROR #12
    FCMP  D2, #0.0
    ANDS  X14, X18, X29, ROR #47
    ADDS  W13, W28, #0xcca
    SUBS  X27, X20, X13, LSL #54
    FCMPE  S22, S13
    SUBS  W26, W20, #0xf30
    SUBS  X27, X12, #0xee0, LSL #12
    SUBS  W16, W6, W6, SXTB #0
    SUBS  W18, W22, W17, LSR #10
    ANDS  W4, W19, #0x7ff
    ADDS  X10, X27, X18, LSL #35
    ANDS  W14, W10, W16, LSR #9
    ADDS  X16, X21, #0x42f
    ADDS  X26, X15, #0x830
    ANDS  X11, X26, X14, ROR #38
    SUBS  W12, W9, #0xb50
    ANDS  X12, X5, #0xfffffffffffe000
    SUBS  X10, X19, X12, LSL #21
    ADDS  X26, X16, #0xec9, LSL #12
    ADDS  W13, W27, #0xb39, LSL #12
    ANDS  X7, X11, X11, ASR #61
    ADDS  W7, W26, W5, LSR #5
    SUBS  X7, X21, #0x843
    SUBS  W7, W13, W4, ASR #6
    SUBS  X17, X21, #0x254, LSL #12
    SUBS  X9, X20, W22, SXTB #1
    ADDS  W29, W21, #0x410
    ADDS  W10, W14, W17, LSR #22
    SUBS  W14, W24, W22, LSR #12
    ANDS  W29, W22, W10, LSL #22
    SUBS  W25, W2, W10, SXTX #2
    ANDS  W11, W7, #0xf0003fff
    SUBS  W21, W11, #0xc17
    SUBS  W19, W20, W24, SXTB #2
    SUBS  X9, X9, #0xd67, LSL #12
    SUBS  W6, W28, W12, LSR #10
    SUBS  W10, W17, W24, LSR #19
    ADDS  W9, W16, W18, LSR #13
    SUBS  X7, X26, X9, LSL #22
    SUBS  W17, W7, W13, SXTH #2
    ANDS  X4, X27, #0xff01ffffffffffff
    ANDS  X13, X14, #0xffff0007ffffffff
    SUBS  X13, X12, #0xad7, LSL #12
    ADDS  X5, X16, #0x780
    ADDS  X27, X8, W28, SXTW #3
    SUBS  X8, X8, #0x1
    B.NE  TaishanIntCcP01_label_753
    MOVZ  X22, #0x6c, LSL #0
    SUB  X15, X22, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X14, #0x2085, LSL #0
    MOVK  X14, #0x86b6, LSL #16
    MOVK  X14, #0x8000, LSL #48
    SUB  X5, X14, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntCcP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X16, #0x69e1, LSL #0
    MOVK  X16, #0x3277, LSL #16
    SUB  X26, X16, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X24, #0x515, LSL #0
    MOVK  X24, #0x1a42, LSL #16
    MOVK  X24, #0xa43, LSL #32
    MOVK  X24, #0xffc0, LSL #48
    SUB  X22, X24, X7
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntCcP01_TestFail
    MOVZ  X8, #0xf79a, LSL #0
    MOVK  X8, #0xffd6, LSL #16
    SUB  X28, X8, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X5, #0x1540, LSL #0
    MOVK  X5, #0xffb0, LSL #16
    SUB  X19, X5, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X16, #0x3066, LSL #0
    MOVK  X16, #0x8000, LSL #16
    SUB  X17, X16, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X16, #0xa000, LSL #0
    MOVK  X16, #0x3090, LSL #16
    SUB  X15, X16, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X24, #0x3000, LSL #0
    MOVK  X24, #0x2fe3, LSL #16
    SUB  X25, X24, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X6, #0x2085, LSL #0
    MOVK  X6, #0x86b6, LSL #16
    MOVK  X6, #0x8000, LSL #48
    SUB  X14, X6, X14
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X22, #0xa000, LSL #0
    MOVK  X22, #0x3090, LSL #16
    SUB  X24, X22, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntCcP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X26, #0xb944, LSL #0
    MOVK  X26, #0x3050, LSL #16
    SUB  X23, X26, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X16, #0x8300, LSL #0
    MOVK  X16, #0x1841, LSL #16
    SUB  X24, X16, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntCcP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X17, X22, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanIntCcP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanIntCcP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanIntCcP01_TestFail
    MOVZ  X5, #0xb944, LSL #0
    MOVK  X5, #0x3050, LSL #16
    SUB  X23, X5, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X29
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntCcP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
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
TaishanIntCcP01_label_781:
    ANDS  W18, W18, #0x10101010
    ADDS  X22, X13, #0x73e
    SUBS  W19, W17, #0x7bb
    SUBS  W16, W15, #0x51c
    ANDS  X29, X22, #0xff01ffffff01ffff
    SUBS  X5, X9, X8, LSR #23
    ANDS  W8, W4, #0x3ff03ff
    SUBS  W17, W16, W7, ASR #5
    ADDS  X24, X18, #0xcee, LSL #12
    ADDS  W26, W23, #0x1e9
    ADDS  W19, W26, W10, LSR #15
    FCMP  D16, D0
    ANDS  W29, W8, #0xfffc001f
    ANDS  W4, W16, #0x1fe01fe
    SUBS  X14, X11, W25, SXTW #1
    ANDS  W12, W26, W19, LSR #20
    SUBS  W12, W4, W4, SXTH #0
    SUBS  W24, W17, W8, SXTH #0
    ADDS  X17, X8, W4, UXTW #0
    ADDS  W14, W23, #0x611, LSL #12
    ANDS  W23, W24, W16, LSR #26
    ANDS  X5, X11, #0xffffe000007fffff
    ADDS  W14, W23, W25, SXTB #4
    ANDS  W23, W14, #0x2000200
    ADDS  W25, W26, W14, SXTW #3
    SUBS  W27, W5, #0x167, LSL #12
    SUBS  X2, X24, X8, UXTX #0
    FCMPE  S30, S28
    FCMPE  S3, #0.0
    SUBS  W27, W7, W29, UXTW #1
    ANDS  W23, W26, W17, ROR #21
    ADDS  W12, W16, W16, LSR #9
    SUBS  X8, X4, #0x7d1
    ADDS  X23, X12, X23, SXTX #2
    ADDS  X21, X13, #0x6bb
    SUBS  W12, W5, #0x9d0
    ADDS  W21, W14, #0xbc, LSL #12
    SUBS  X18, X14, X12, LSR #18
    SUBS  W11, W21, W23, ASR #4
    SUBS  X17, X20, X16, LSR #40
    ADDS  W19, W24, #0x496
    ADDS  X25, X23, #0x93f, LSL #12
    SUBS  W27, W21, W14, LSL #11
    ANDS  W24, W19, #0x3fffe0
    ANDS  W17, W4, #0xe0000fff
    ADDS  W6, W17, W13, UXTW #1
    SUBS  W8, W27, W24, SXTB #1
    SUBS  X28, X11, #0x300
    FCMP  S0, S6
    SUBS  W6, W7, #0x136, LSL #12
    ANDS  W4, W2, #0xffff81ff
    ANDS  X17, X19, #0xf3f3f3f3f3f3f3f3
    ANDS  W5, W5, #0x1fc
    SUBS  X19, X16, W19, UXTW #2
    SUBS  W16, W21, #0xf06, LSL #12
    ANDS  X13, X27, X17, LSL #41
    ADDS  W21, W7, #0xa10
    ANDS  X17, X7, #0x7f800
    ADDS  W15, W10, W21, UXTX #4
    ANDS  W20, W4, W27, LSL #6
    ADDS  X18, X5, X14, SXTX #1
    ADDS  X18, X19, W15, UXTW #0
    SUBS  W22, W24, W28, UXTB #4
    ANDS  W15, W19, W12, ASR #7
    SUBS  X8, X13, W11, UXTW #0
    SUBS  W21, W6, #0x488
    ADDS  X13, X10, X24, LSL #39
    ADDS  W18, W7, W18, UXTW #0
    ADDS  X17, X2, #0x9ea, LSL #12
    ADDS  X23, X18, W27, UXTH #1
    ADDS  W11, W6, #0x1d0
    SUBS  W16, W14, W5, ASR #1
    ADDS  X7, X4, X27, UXTX #1
    ADDS  X24, X9, X20, LSR #3
    SUBS  W5, W28, #0x602, LSL #12
    SUBS  X6, X29, X22, LSR #27
    ADDS  W23, W2, #0x50b, LSL #12
    ADDS  X5, X7, X19, ASR #1
    SUBS  X12, X7, X24, LSL #60
    ADDS  X27, X6, X24, ASR #42
    ANDS  W7, W18, #0x3f3f3f3f
    ADDS  X13, X28, #0xe45, LSL #12
    SUBS  W7, W16, W13, SXTB #3
    ADDS  X24, X5, X6, LSR #33
    ADDS  W25, W21, #0x774
    ADDS  W25, W8, W8, UXTH #4
    SUBS  X23, X17, X20, ASR #23
    ADDS  X25, X6, #0x70
    ADDS  W21, W11, W24, LSL #1
    ANDS  W18, W29, #0x7ffffff0
    ADDS  X5, X21, X8, LSR #25
    SUBS  W27, W28, W27, SXTH #4
    ADDS  X28, X5, #0xb2d
    ANDS  X4, X22, #0xc00fffffc00fffff
    SUBS  W14, W29, W14, UXTX #1
    SUBS  W9, W14, #0x9ee
    ADDS  X29, X22, X11, LSR #47
    ADDS  X4, X25, X25, LSR #15
    ANDS  W13, W8, #0xf9f9f9f9
    ADDS  W13, W13, W23, UXTX #4
    ANDS  W27, W20, #0xfc00
    ADDS  W5, W12, W15, UXTX #3
    ANDS  W7, W25, #0xffc0ffc
    SUBS  X15, X26, X15, ASR #31
    SUBS  W4, W26, W29, SXTX #2
    ANDS  W16, W11, W21, ASR #9
    SUBS  W16, W16, #0xd99, LSL #12
    ANDS  X27, X13, #0xfbfbfbfbfbfbfbfb
    ADDS  W8, W15, W9, UXTB #3
    SUBS  W20, W9, W18, UXTH #0
    ADDS  W28, W18, W12, SXTB #4
    ADDS  X13, X12, X22, ASR #62
    SUBS  W24, W25, #0xaf, LSL #12
    FCMP  S25, #0.0
    SUBS  X25, X17, X10, LSL #48
    ANDS  W9, W11, W27, LSL #28
    ADDS  W5, W15, W15, UXTW #2
    SUBS  W18, W28, W16, LSR #9
    SUBS  X29, X20, X27, ASR #10
    ANDS  X19, X29, X20, LSL #22
    ANDS  X4, X27, X20, LSR #35
    ADDS  W16, W18, W19, ASR #1
    SUBS  X16, X18, X24, LSR #40
    SUBS  X9, X7, W14, UXTH #3
    ANDS  X23, X25, X21, LSR #35
    ADDS  X8, X27, #0x9c5
    FCMP  D9, #0.0
    ANDS  W29, W17, #0xe01fffff
    SUBS  X22, X27, X18, LSL #2
    SUBS  X5, X18, #0xe1a, LSL #12
    SUBS  X23, X10, W27, SXTH #0
    SUBS  W9, W2, W29, ASR #19
    ADDS  W14, W11, #0x9e6
    ADDS  X8, X21, W6, SXTW #1
    FCMP  S27, #0.0
    ADDS  X27, X4, X14, LSR #36
    ANDS  W13, W17, W22, ASR #30
    ANDS  X16, X17, X28, ROR #0
    FCMPE  D10, D0
    ANDS  X21, X12, X26, ASR #51
    ADDS  W7, W5, W28, UXTW #2
    ADDS  X18, X21, W25, UXTB #3
    ADDS  W7, W23, #0xae3, LSL #12
    ANDS  W9, W21, #0xffc0ffc0
    ANDS  W6, W6, W23, ASR #18
    ANDS  W25, W24, #0x3fff3fff
    SUBS  W28, W12, #0x40
    SUBS  X24, X18, X7, ASR #26
    ANDS  X5, X27, X8, ASR #52
    ADDS  X6, X19, X26, LSR #15
    ANDS  W21, W28, W11, LSL #26
    SUBS  X6, X28, #0x199, LSL #12
    ADDS  W4, W15, W23, UXTX #2
    ADDS  X15, X4, #0xc13
    SUBS  X24, X8, #0x206
    SUBS  W22, W8, W5, UXTB #3
    ANDS  W4, W23, W24, LSL #20
    ANDS  W19, W26, #0xf0f0f0f0
    SUBS  X8, X22, X16, LSR #30
    SUBS  W19, W2, W11, ASR #18
    ADDS  W21, W6, W14, SXTB #2
    ANDS  X9, X5, X13, LSR #20
    SUBS  W27, W19, #0x827, LSL #12
    ANDS  X14, X11, #0x6060606060606060
    ANDS  X16, X15, X20, ASR #47
    ANDS  W12, W19, W10, LSL #20
    SUBS  X17, X28, #0x90d
    ANDS  X12, X26, X15, ASR #47
    ADDS  X20, X2, X10, LSR #22
    ADDS  X16, X14, W28, UXTH #1
    SUBS  W25, W6, W13, SXTX #0
    ADDS  X5, X27, X5, UXTX #3
    FCMPE  D30, D3
    ADDS  W19, W8, #0xbe2, LSL #12
    SUBS  W20, W20, W25, UXTH #2
    SUBS  W22, W14, W5, LSL #13
    ANDS  X16, X21, X17, ASR #26
    SUBS  W9, W25, W29, ASR #14
    ADDS  X12, X26, #0x8e5
    ANDS  W19, W23, W16, ROR #0
    ANDS  X7, X19, #0xffc3ffc3ffc3ffc3
    SUBS  X4, X24, W12, UXTH #1
    SUBS  X6, X7, W5, UXTW #2
    ADDS  W29, W11, #0x7fc, LSL #12
    ANDS  X28, X16, X27, ASR #36
    SUBS  W4, W22, W7, UXTX #1
TaishanIntCcP01_label_61:
    SUBS  X2, X25, X21, ASR #38
    SUBS  W18, W11, W6, ASR #0
    SUBS  X2, X28, X26, LSR #54
    ANDS  W9, W17, W20, ROR #7
    SUBS  X8, X17, W27, SXTW #2
    ADDS  W14, W11, W8, LSL #20
    ANDS  X5, X7, X4, LSR #43
    ADDS  X12, X15, X14, ASR #12
    SUBS  X28, X13, #0x9c
    ADDS  X22, X18, X2, ASR #22
    SUBS  W2, W23, W28, SXTW #0
    ADDS  X11, X9, W23, UXTB #1
    ADDS  X2, X25, #0x7f0
    ADDS  X5, X26, X24, UXTX #3
    SUBS  X10, X10, #0x1
    B.NE  TaishanIntCcP01_label_781
    MOVZ  X9, #0xc7d1, LSL #0
    MOVK  X9, #0xffd1, LSL #16
    SUB  X8, X9, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x203e, LSL #0
    MOVK  X8, #0x1d9e, LSL #16
    SUB  X13, X8, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntCcP01_TestFail
    MOVZ  X25, #0xd89b, LSL #0
    MOVK  X25, #0xa4, LSL #16
    MOVK  X25, #0x8, LSL #32
    SUB  X2, X25, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X21, #0xa7c1, LSL #0
    MOVK  X21, #0x2b7, LSL #16
    MOVK  X21, #0xfffc, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X23, X21, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X27, #0x1, LSL #0
    SUB  X13, X27, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanIntCcP01_TestFail
    MOVZ  X4, #0x203e, LSL #0
    MOVK  X4, #0x1d9e, LSL #16
    SUB  X18, X4, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntCcP01_TestFail
    MOVZ  X11, #0xc7d1, LSL #0
    MOVK  X11, #0xffd1, LSL #16
    SUB  X23, X11, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanIntCcP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X13, #0xc7d1, LSL #0
    MOVK  X13, #0xffd1, LSL #16
    SUB  X5, X13, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x3c0c, LSL #0
    MOVK  X23, #0x10, LSL #16
    SUB  X25, X23, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X6, #0xc7d1, LSL #0
    MOVK  X6, #0xffd1, LSL #16
    SUB  X10, X6, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntCcP01_TestFail
    MOVZ  X11, #0xa1d0, LSL #0
    MOVK  X11, #0xe92c, LSL #16
    SUB  X20, X11, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X29, #0xa942, LSL #0
    MOVK  X29, #0x1, LSL #16
    SUB  X8, X29, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x39, LSL #0
    SUB  X25, X17, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x39, LSL #0
    SUB  X25, X17, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanIntCcP01_TestFail
    MOVZ  X24, #0x9, LSL #0
    SUB  X10, X24, X19
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntCcP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X20
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X28, #0xa7c1, LSL #0
    MOVK  X28, #0x2b7, LSL #16
    MOVK  X28, #0xfffc, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X19, X28, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X17, #0xfa0f, LSL #0
    MOVK  X17, #0xfd34, LSL #16
    SUB  X10, X17, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanIntCcP01_TestFail
    MOVZ  X15, #0x3c0c, LSL #0
    MOVK  X15, #0x10, LSL #16
    SUB  X17, X15, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X9, #0x9, LSL #0
    SUB  X16, X9, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X26
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X16, #0x1, LSL #0
    SUB  X6, X16, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanIntCcP01_TestFail
    MOVZ  X12, #0xa7c1, LSL #0
    MOVK  X12, #0x2b7, LSL #16
    MOVK  X12, #0xfffc, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X27, X12, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanIntCcP01_TestFail
    MOVZ  X5, #0xa942, LSL #0
    MOVK  X5, #0x1, LSL #16
    SUB  X17, X5, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x0, LSL #0
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
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X18, #0x14, LSL #0
TaishanIntCcP01_label_809:
    ADDS  X26, X14, X18, LSR #22
    SUBS  X28, X9, #0x663
    SUBS  W15, W26, W15, UXTB #2
    ADDS  X7, X16, X24, ASR #60
    SUBS  X15, X29, W27, UXTB #2
    SUBS  W5, W25, W28, LSL #4
    SUBS  X27, X18, X25, LSR #62
    ANDS  W29, W20, #0x55555555
    ADDS  W11, W7, W11, LSR #22
    FCMP  D24, #0.0
    ANDS  W16, W15, W20, ROR #15
    ADDS  W23, W19, #0xb4c
    ADDS  W12, W11, W23, ASR #29
TaishanIntCcP01_label_436:
    ADDS  W27, W12, #0x1aa
    ANDS  W27, W19, #0x22222222
    ADDS  W5, W28, W24, UXTX #3
    ADDS  W5, W16, W28, LSL #12
    SUBS  X9, X13, X11, LSL #56
    SUBS  X24, X19, X25, ASR #62
    ADDS  W7, W5, W24, SXTX #0
    SUBS  X7, X7, #0x937, LSL #12
    ANDS  W27, W19, W22, LSL #12
    ADDS  X24, X27, #0xe46, LSL #12
    SUBS  W17, W12, W7, LSL #22
    ADDS  X10, X9, W15, UXTH #3
    ADDS  W29, W19, W11, SXTW #0
    SUBS  W10, W7, #0x2ee, LSL #12
    ADDS  W17, W13, #0x144, LSL #12
    ADDS  X16, X18, W9, SXTH #2
    ADDS  W6, W9, W10, UXTB #3
    ADDS  W27, W11, W9, SXTB #2
    SUBS  X12, X14, X12, LSL #62
    ADDS  W29, W11, W6, UXTH #1
    ADDS  W9, W29, W2, LSL #31
    SUBS  X15, X7, #0xda0
    ADDS  X5, X27, X27, ASR #60
    ADDS  W20, W7, #0x385
    ADDS  X4, X21, #0x494, LSL #12
    SUBS  X27, X27, W16, UXTH #2
    ADDS  X14, X14, W16, UXTH #4
    ADDS  X11, X23, X23, LSR #22
    SUBS  W5, W29, #0x0
    ADDS  W25, W5, W14, SXTW #3
    ADDS  W26, W24, W13, ASR #15
    ANDS  X27, X5, #0x2222222222222222
    SUBS  W4, W18, W28, UXTH #3
    SUBS  X16, X25, X2, ASR #52
    ANDS  W6, W7, #0xfffff807
    SUBS  W12, W20, #0x8d8, LSL #12
    ADDS  X29, X18, #0x6ca, LSL #12
    SUBS  X2, X15, W5, SXTH #0
    SUBS  X4, X11, X18, LSR #49
    ADDS  X11, X2, X8, LSR #48
    ANDS  W26, W26, #0xe000e0
    ANDS  W4, W4, #0xcccccccc
    SUBS  X2, X21, W29, SXTB #2
    ANDS  X21, X27, #0xff000000ff0
    SUBS  X11, X21, W22, SXTH #3
    SUBS  W5, W4, #0x3d0
    ADDS  W19, W14, #0x24
    ANDS  X28, X11, X10, ROR #27
    SUBS  W23, W16, #0x290
    ADDS  X13, X25, X20, SXTX #3
    FCMP  S27, #0.0
    SUBS  X11, X19, W23, UXTH #0
    SUBS  W17, W20, #0x2ab
    SUBS  X17, X6, #0xa12
    ADDS  W17, W8, W26, LSR #28
    ANDS  W23, W26, #0x3fc000
    SUBS  W22, W16, #0xf93
    ANDS  X25, X9, X23, LSL #21
    SUBS  X21, X4, #0xf69
    SUBS  X25, X11, #0x32c, LSL #12
    ANDS  X24, X23, #0xffffffffffc01fff
    SUBS  W17, W10, W23, SXTB #3
    ADDS  X13, X21, W11, UXTH #1
    SUBS  X19, X7, #0x5fb, LSL #12
    ADDS  W25, W20, W20, UXTW #4
    SUBS  X17, X23, #0x0
    ADDS  W6, W4, #0xdc0
    ADDS  W22, W28, W17, ASR #29
    ADDS  W27, W20, W19, UXTX #3
    ADDS  W25, W5, W24, LSR #12
    SUBS  W22, W16, W16, SXTH #1
    ANDS  W28, W16, #0xffe3ffe3
    ANDS  X2, X21, X19, ASR #7
    ANDS  X22, X21, X13, ASR #34
    SUBS  W11, W22, W6, ASR #12
    ADDS  W19, W28, W2, UXTX #0
    SUBS  W14, W10, W19, LSR #31
    ANDS  W28, W9, #0x20000000
    FCMP  S9, #0.0
    SUBS  X10, X7, #0xaf6, LSL #12
    ADDS  W16, W4, #0xa6f
    ADDS  X5, X5, X11, LSR #59
    ANDS  W26, W29, W21, LSL #31
    ANDS  W12, W2, W14, ASR #8
    ANDS  W28, W2, #0x1e00000
    ANDS  X9, X23, X2, LSL #29
    SUBS  W24, W5, W7, LSR #12
    ADDS  W6, W25, W2, SXTX #2
    ADDS  W17, W8, W8, LSL #24
    ADDS  W21, W13, W29, ASR #12
    SUBS  W14, W17, W8, ASR #3
    SUBS  X20, X29, X23, LSR #7
    ANDS  W21, W13, W8, ASR #20
    ANDS  W21, W20, W12, ASR #23
    ADDS  X16, X22, W15, SXTB #0
    ADDS  W22, W15, #0xe70
    SUBS  X25, X11, W10, SXTW #1
    ADDS  X25, X15, #0x843
    ANDS  X29, X27, #0xfffff000fffff00
    ADDS  W6, W29, W21, ASR #18
    ADDS  W24, W15, W13, LSL #25
    SUBS  W10, W29, W24, SXTX #2
    ANDS  X20, X13, X19, ROR #57
    ADDS  X4, X13, X6, ASR #58
    ADDS  X25, X5, X10, LSL #20
    SUBS  W6, W24, W21, ASR #2
    ADDS  W12, W4, #0x8e6, LSL #12
    SUBS  W8, W20, W12, SXTW #4
    ADDS  X17, X19, X23, LSL #34
    ADDS  W4, W18, W24, LSR #1
    ADDS  X27, X16, X2, LSL #48
    SUBS  X15, X7, #0xede
    ADDS  W11, W19, #0xaa4
    ADDS  X19, X19, #0x1a0, LSL #12
    SUBS  W2, W25, W29, LSR #16
    ANDS  W13, W20, W6, ASR #1
    SUBS  W6, W29, #0xbc6, LSL #12
    SUBS  W27, W17, W7, UXTH #2
    SUBS  W29, W12, #0x9ef, LSL #12
    ADDS  X23, X4, W11, UXTW #2
    ADDS  W15, W20, #0x59c
    SUBS  X28, X16, W4, UXTW #0
    SUBS  W7, W29, #0x293, LSL #12
    ADDS  W23, W8, W28, ASR #8
    ADDS  X23, X15, W11, SXTW #3
    SUBS  W27, W15, #0x176
    ADDS  X28, X15, W29, SXTH #1
    ADDS  X14, X29, #0xf14, LSL #12
    SUBS  W28, W18, #0xa66, LSL #12
    ADDS  W9, W8, W14, LSR #15
    SUBS  X6, X2, #0xfb7, LSL #12
    SUBS  X11, X23, #0x1a2
    ADDS  X6, X7, X6, LSL #29
    SUBS  X19, X2, #0xf51
    SUBS  X4, X25, #0xd9b, LSL #12
    SUBS  X14, X25, #0xbfe, LSL #12
    ADDS  W26, W12, W6, ASR #7
    ANDS  X23, X22, X4, ASR #18
    ANDS  W25, W28, #0x60606060
    ANDS  X22, X7, X7, ASR #12
    SUBS  W9, W14, #0xbba, LSL #12
    SUBS  W20, W17, #0x490
    ADDS  X22, X22, #0xf8
    ADDS  X11, X27, W10, SXTB #0
    ADDS  W17, W15, W18, UXTX #2
    ADDS  W9, W9, W22, SXTB #0
    ADDS  W7, W8, #0x380
    ADDS  W14, W20, W14, UXTW #4
    ANDS  W14, W18, #0x77777777
    SUBS  W22, W16, W2, UXTX #3
    SUBS  W22, W12, W22, LSR #2
    ADDS  X19, X22, W19, SXTB #3
    ANDS  X20, X29, X26, ROR #32
    ADDS  W6, W18, W10, SXTB #0
    ADDS  X13, X24, #0x914, LSL #12
    SUBS  X17, X10, X15, LSL #45
    ADDS  W14, W24, W28, SXTH #1
    ANDS  X10, X8, #0x7fffffffff000000
    ADDS  W20, W27, #0x8e2, LSL #12
    SUBS  X17, X20, X11, UXTX #1
    ADDS  X11, X16, X7, ASR #28
    FCMPE  S10, #0.0
    ANDS  X17, X29, X13, LSR #34
    ADDS  W2, W23, #0x59d
    ADDS  W10, W17, #0x0, LSL #12
    SUBS  X24, X11, #0xb24, LSL #12
    SUBS  X19, X29, #0x3c4
    ADDS  W14, W16, W19, UXTW #4
    ANDS  W2, W28, #0x8000ffff
    ANDS  W15, W15, #0x1e1e1e1e
    FCMPE  S15, S23
    SUBS  X24, X5, X2, LSR #63
    SUBS  W2, W15, #0x3b0
    FCMP  D22, D30
    FCMPE  D14, #0.0
    ADDS  W6, W10, W4, LSR #1
    ANDS  X9, X2, #0xe1e1e1e1e1e1e1e1
    ANDS  X9, X24, #0x7ffffffe000000
    SUBS  X23, X20, X27, LSL #25
    ADDS  W21, W29, #0xd97, LSL #12
    ADDS  X5, X25, #0xaa5, LSL #12
    SUBS  W9, W25, #0xd84, LSL #12
    ADDS  W13, W9, #0xc00
    ANDS  W7, W27, #0xe000e000
    ADDS  X16, X28, X15, ASR #3
    SUBS  X4, X14, W20, SXTW #4
    ANDS  X4, X29, #0xc00000000007ffff
    SUBS  X18, X18, #0x1
    B.NE  TaishanIntCcP01_label_809
    MOVZ  X14, #0x126c, LSL #0
    SUB  X24, X14, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntCcP01_TestFail
    MOVZ  X25, #0x8ba1, LSL #0
    SUB  X9, X25, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntCcP01_TestFail
    MOVZ  X19, #0x7000, LSL #0
    MOVK  X19, #0x60ea, LSL #16
    SUB  X16, X19, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanIntCcP01_TestFail
    MOVZ  X19, #0x6638, LSL #0
    MOVK  X19, #0x5b13, LSL #16
    SUB  X18, X19, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8000, LSL #16
    SUB  X14, X13, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X27, #0x5670, LSL #0
    MOVK  X27, #0xb309, LSL #16
    SUB  X20, X27, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X24, X8, X9
    ADD X1, X1, #1
    CBNZ   X24, TaishanIntCcP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanIntCcP01_TestFail
    MOVZ  X14, #0x60, LSL #0
    SUB  X19, X14, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x7ba1, LSL #0
    MOVK  X13, #0x8ccf, LSL #16
    SUB  X26, X13, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X24, #0x7ba1, LSL #0
    MOVK  X24, #0x8ccf, LSL #16
    SUB  X26, X24, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x60, LSL #0
    SUB  X25, X8, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanIntCcP01_TestFail
    MOVZ  X23, #0x161c, LSL #0
    SUB  X22, X23, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanIntCcP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntCcP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntCcP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X18
    ADD X1, X1, #1
    CBNZ   X18, TaishanIntCcP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntCcP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanIntCcP01_TestFail
    MOVZ  X27, #0xfba1, LSL #0
    MOVK  X27, #0x8d09, LSL #16
    SUB  X2, X27, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanIntCcP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X22
    ADD X1, X1, #1
    CBNZ   X5, TaishanIntCcP01_TestFail
    MOVZ  X21, #0x161c, LSL #0
    SUB  X12, X21, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X7, X11, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanIntCcP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X11, #0xfba1, LSL #0
    MOVK  X11, #0x8d09, LSL #16
    SUB  X14, X11, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanIntCcP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanIntCcP01_TestFail
    MOVZ  X2, #0x8ba1, LSL #0
    MOVK  X2, #0x8c30, LSL #16
    SUB  X8, X2, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanIntCcP01_TestFail

TaishanIntCcP01_TestEnd:
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
TaishanIntCcP01_TestFail:
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
