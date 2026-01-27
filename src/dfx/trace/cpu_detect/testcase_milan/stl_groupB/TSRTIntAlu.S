.global TSRTIntAlu

.text
.p2align 4

TSRTIntAlu:

TSRTIntAlu_TestBegin:
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
    MOVZ  X4, #0xd615, LSL #0
    MOVK  X4, #0xf931, LSL #16
    MOVK  X4, #0x83d0, LSL #32
    MOVK  X4, #0x7c1, LSL #48
    MOVZ  X5, #0x1fe8, LSL #0
    MOVK  X5, #0x342a, LSL #16
    MOVK  X5, #0xbdd7, LSL #32
    MOVK  X5, #0x1c2e, LSL #48
    MOVZ  X6, #0x45aa, LSL #0
    MOVK  X6, #0xa713, LSL #16
    MOVK  X6, #0x46a9, LSL #32
    MOVK  X6, #0x9816, LSL #48
    MOVZ  X7, #0xc672, LSL #0
    MOVK  X7, #0xb2e7, LSL #16
    MOVK  X7, #0x3717, LSL #32
    MOVK  X7, #0xde73, LSL #48
    MOVZ  X8, #0xd9bc, LSL #0
    MOVK  X8, #0xea40, LSL #16
    MOVK  X8, #0xcc83, LSL #32
    MOVK  X8, #0x6727, LSL #48
    MOVZ  X11, #0x11c6, LSL #0
    MOVK  X11, #0x6dd4, LSL #16
    MOVK  X11, #0x4a3, LSL #32
    MOVK  X11, #0x7cef, LSL #48
    MOVZ  X12, #0x5d16, LSL #0
    MOVK  X12, #0xb899, LSL #16
    MOVK  X12, #0xd529, LSL #32
    MOVK  X12, #0x4dda, LSL #48
    MOVZ  X13, #0xe917, LSL #0
    MOVK  X13, #0x6c8d, LSL #16
    MOVK  X13, #0x4326, LSL #32
    MOVK  X13, #0x620, LSL #48
    MOVZ  X14, #0xeb3d, LSL #0
    MOVK  X14, #0x165a, LSL #16
    MOVK  X14, #0x846e, LSL #32
    MOVK  X14, #0xe629, LSL #48
    MOVZ  X15, #0x8cbc, LSL #0
    MOVK  X15, #0xa4a0, LSL #16
    MOVK  X15, #0x8eab, LSL #32
    MOVK  X15, #0x1f2d, LSL #48
    MOVZ  X16, #0x48db, LSL #0
    MOVK  X16, #0x193f, LSL #16
    MOVK  X16, #0x398f, LSL #32
    MOVK  X16, #0xe5ea, LSL #48
    MOVZ  X17, #0xda3c, LSL #0
    MOVK  X17, #0x2f27, LSL #16
    MOVK  X17, #0xd9d3, LSL #32
    MOVK  X17, #0x2282, LSL #48
    MOVZ  X18, #0xfc2b, LSL #0
    MOVK  X18, #0x3a7, LSL #16
    MOVK  X18, #0x6ef4, LSL #32
    MOVK  X18, #0x4b3f, LSL #48
    MOVZ  X19, #0xf5ee, LSL #0
    MOVK  X19, #0xcdb4, LSL #16
    MOVK  X19, #0x4511, LSL #32
    MOVK  X19, #0xb16f, LSL #48
    MOVZ  X20, #0xda9c, LSL #0
    MOVK  X20, #0xaa26, LSL #16
    MOVK  X20, #0x3ca6, LSL #32
    MOVK  X20, #0xf43d, LSL #48
    MOVZ  X21, #0x2207, LSL #0
    MOVK  X21, #0x2aa0, LSL #16
    MOVK  X21, #0xe8d1, LSL #32
    MOVK  X21, #0xfa69, LSL #48
    MOVZ  X22, #0xd5d8, LSL #0
    MOVK  X22, #0x43f4, LSL #16
    MOVK  X22, #0xe6fa, LSL #32
    MOVK  X22, #0x5bf0, LSL #48
    MOVZ  X23, #0x2fa3, LSL #0
    MOVK  X23, #0xf24f, LSL #16
    MOVK  X23, #0xeef1, LSL #32
    MOVK  X23, #0xf22d, LSL #48
    MOVZ  X24, #0x4427, LSL #0
    MOVK  X24, #0x2a71, LSL #16
    MOVK  X24, #0xa288, LSL #32
    MOVK  X24, #0xab07, LSL #48
    MOVZ  X25, #0xce1f, LSL #0
    MOVK  X25, #0x47da, LSL #16
    MOVK  X25, #0xcaff, LSL #32
    MOVK  X25, #0x6ded, LSL #48
    MOVZ  X26, #0xf0bf, LSL #0
    MOVK  X26, #0x537f, LSL #16
    MOVK  X26, #0xfde3, LSL #32
    MOVK  X26, #0x4cc2, LSL #48
    MOVZ  X27, #0xe2f7, LSL #0
    MOVK  X27, #0x4c95, LSL #16
    MOVK  X27, #0xc5cc, LSL #32
    MOVK  X27, #0x8083, LSL #48
    MOVZ  X28, #0x5ce4, LSL #0
    MOVK  X28, #0xce24, LSL #16
    MOVK  X28, #0x9d3c, LSL #32
    MOVK  X28, #0x9200, LSL #48
    MOVZ  X29, #0xcea3, LSL #0
    MOVK  X29, #0x1fb7, LSL #16
    MOVK  X29, #0x4660, LSL #32
    MOVK  X29, #0x4e81, LSL #48
    ANDS  X26, X23, #0xfffffc07fffffc07
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X4, #0x3f41, LSL #0
    MOVK  X4, #0xc97, LSL #16
    MOVK  X4, #0xa814, LSL #32
    MOVK  X4, #0xb592, LSL #48
    MOVZ  X5, #0xf5f9, LSL #0
    MOVK  X5, #0x12ff, LSL #16
    MOVK  X5, #0x6d65, LSL #32
    MOVK  X5, #0xed6b, LSL #48
    MOVZ  X6, #0xe6e, LSL #0
    MOVK  X6, #0xc22c, LSL #16
    MOVK  X6, #0x8ae8, LSL #32
    MOVK  X6, #0x7de8, LSL #48
    MOVZ  X7, #0x2110, LSL #0
    MOVK  X7, #0x96b1, LSL #16
    MOVK  X7, #0x78c1, LSL #32
    MOVK  X7, #0xc199, LSL #48
    MOVZ  X8, #0xc040, LSL #0
    MOVK  X8, #0x571a, LSL #16
    MOVK  X8, #0x655b, LSL #32
    MOVK  X8, #0x4d8a, LSL #48
    MOVZ  X11, #0x9914, LSL #0
    MOVK  X11, #0x72a8, LSL #16
    MOVK  X11, #0x547f, LSL #32
    MOVK  X11, #0xb1c, LSL #48
    MOVZ  X12, #0x6c0, LSL #0
    MOVK  X12, #0x5558, LSL #16
    MOVK  X12, #0x6bbe, LSL #32
    MOVK  X12, #0x1370, LSL #48
    MOVZ  X13, #0xc346, LSL #0
    MOVK  X13, #0x1f00, LSL #16
    MOVK  X13, #0x5eb5, LSL #32
    MOVK  X13, #0x3412, LSL #48
    MOVZ  X14, #0xda66, LSL #0
    MOVK  X14, #0x621f, LSL #16
    MOVK  X14, #0xc407, LSL #32
    MOVK  X14, #0x6508, LSL #48
    MOVZ  X15, #0x4620, LSL #0
    MOVK  X15, #0xa12a, LSL #16
    MOVK  X15, #0xff1f, LSL #32
    MOVK  X15, #0x9625, LSL #48
    MOVZ  X16, #0xdaf2, LSL #0
    MOVK  X16, #0xec31, LSL #16
    MOVK  X16, #0xbbe6, LSL #32
    MOVK  X16, #0x6315, LSL #48
    MOVZ  X17, #0x4749, LSL #0
    MOVK  X17, #0x9e73, LSL #16
    MOVK  X17, #0x5ca6, LSL #32
    MOVK  X17, #0x2a41, LSL #48
    MOVZ  X18, #0x40e8, LSL #0
    MOVK  X18, #0x3f6b, LSL #16
    MOVK  X18, #0xb5b, LSL #32
    MOVK  X18, #0x616d, LSL #48
    MOVZ  X19, #0xbcba, LSL #0
    MOVK  X19, #0x848c, LSL #16
    MOVK  X19, #0x23d4, LSL #32
    MOVK  X19, #0x2159, LSL #48
    MOVZ  X20, #0xde7c, LSL #0
    MOVK  X20, #0xd6e9, LSL #16
    MOVK  X20, #0xc9a3, LSL #32
    MOVK  X20, #0x3d12, LSL #48
    MOVZ  X21, #0x79a5, LSL #0
    MOVK  X21, #0x2498, LSL #16
    MOVK  X21, #0x3df6, LSL #32
    MOVK  X21, #0xcc23, LSL #48
    MOVZ  X22, #0x367a, LSL #0
    MOVK  X22, #0xd134, LSL #16
    MOVK  X22, #0x8eba, LSL #32
    MOVK  X22, #0xb034, LSL #48
    MOVZ  X23, #0x778e, LSL #0
    MOVK  X23, #0x5732, LSL #16
    MOVK  X23, #0xbe21, LSL #32
    MOVK  X23, #0xb9bd, LSL #48
    MOVZ  X24, #0xca55, LSL #0
    MOVK  X24, #0x5363, LSL #16
    MOVK  X24, #0x422c, LSL #32
    MOVK  X24, #0x2a7c, LSL #48
    MOVZ  X25, #0x8ec4, LSL #0
    MOVK  X25, #0xfb74, LSL #16
    MOVK  X25, #0x5f4e, LSL #32
    MOVK  X25, #0xd702, LSL #48
    MOVZ  X26, #0x5819, LSL #0
    MOVK  X26, #0x70eb, LSL #16
    MOVK  X26, #0xd8a0, LSL #32
    MOVK  X26, #0xb4db, LSL #48
    MOVZ  X27, #0xb2a, LSL #0
    MOVK  X27, #0x816a, LSL #16
    MOVK  X27, #0x387b, LSL #32
    MOVK  X27, #0x13e4, LSL #48
    MOVZ  X28, #0x188b, LSL #0
    MOVK  X28, #0x9f26, LSL #16
    MOVK  X28, #0xa171, LSL #32
    MOVK  X28, #0x18f6, LSL #48
    MOVZ  X29, #0x4569, LSL #0
    MOVK  X29, #0x5292, LSL #16
    MOVK  X29, #0xc362, LSL #32
    MOVK  X29, #0xb41b, LSL #48
    MOVZ  X16, #0xf, LSL #0
TSRTIntAlu_label_0:
    SUB  X23, X28, #0xdd4, LSL #12
    SMADDL  X17, W16, W25, X27
    NGC  X17, X26
    NEGS  X14, X17, ASR #20
    ADC  X27, X29, X14
    TST  X23, #0x7fe07fe07fe07fe0
    ASR  X21, X27, #0x29
    EON  X29, X21, X21, ASR #57
    NEGS  X29, X29, LSR #15
    EXTR  X13, X29, X29, #0x37
    MADD  W26, W13, W13, W13
    MNEG  X8, X29, X26
    AND  X25, X17, #0xc000007fc000007f
    UMSUBL  X18, W13, W25, X14
    TST  W6, #0xfc000fff
    SBC  X26, X16, X21
    SMULL  X21, W20, W22
    ROR  X15, X16, X29
    UBFM  X6, X16, #0x0, #0x39
    ADC  W22, W8, W17
    ASR  W28, W19, W20
    MNEG  X21, X6, X13
    AND  W21, W12, W6, ASR #24
    ORR  X28, X28, #0xffffffc000000001
    CSINV  X29, X23, X20, HI
    ADD  X4, X20, X20, LSL #50
    SDIV  X23, X12, X6
    MVN  W17, W21, LSR #27
    SXTH  W6, W22
    UBFM  X17, X29, #0x18, #0x12
    UMNEGL  X14, W28, W18
    ASRV  W26, W23, W26
    UBFM  X13, X17, #0x3f, #0x1b
    AND  X14, X15, #0x7f800000000
    ADCS  W19, W12, W26
    NGC  W20, W19
    ADDS  W21, W13, #0xa80
    ADD  X22, X14, #0x998, LSL #12
    AND  X29, X20, X20, LSL #37
    RORV  X28, X6, X6
    TST  W28, W4, ROR #10
    MSUB  X13, X13, X21, X22
    UXTH  W22, W29
    BFI  W17, W13, #23, #5
    MSUB  W12, W17, W22, W17
    MADD  X4, X12, X27, X13
    SMNEGL  X27, W7, W18
    RORV  X22, X5, X25
    RORV  W13, W25, W17
    BIC  X17, X29, X20, ASR #27
    EXTR  W21, W27, W16, #0x11
    UBFM  X25, X20, #0x27, #0xc
    MNEG  X28, X12, X12
    MSUB  W15, W16, W16, W21
    UMULH  X12, X16, X7
    NGCS  X6, X5
    CLZ  X21, X6
    MSUB  X20, X4, X12, X17
    NEG  W12, W22, ASR #6
    CSNEG  W6, W21, W13, LE
    SBFX  W29, W6, #0x6, #6
    ASRV  W17, W15, W29
    ADC  X27, X17, X28
    RORV  W4, W13, W27
    BFI  W13, W25, #8, #21
    CSNEG  W25, W13, W26, VS
    BFXIL  W26, W12, #0x4, #21
    NEG  W29, W20, ASR #30
    BIC  X28, X29, X4, LSR #0
    SMULL  X12, W25, W28
    MSUB  W27, W26, W12, W26
    ADD  X20, X7, X7, LSR #56
    REV  X13, X17
    MVN  W5, W16, LSL #1
    TST  X7, #0x803fffff803fffff
    ADD  W29, W6, W29, ASR #8
    SUB  W4, W29, W5, LSL #6
    ORR  W12, W25, W14, LSR #28
    CSINV  W25, W21, W23, CS
    TST  W16, W23, ASR #10
    RBIT  X15, X5
    AND  W29, W7, #0xe01fffff
    CLZ  W23, W19
    ADD  W6, W12, #0x36e
    CSINV  X26, X27, X8, GT
    ANDS  W7, W26, W4, LSR #27
    NEG  W17, W15, LSL #9
    UBFX  W14, W17, #0xe, #4
    RORV  X28, X20, X29
    BFXIL  X15, X21, #0x3b, #2
    CSINV  W19, W13, W6, AL
    BIC  W29, W23, W7, LSL #18
    BFXIL  W23, W14, #0x11, #11
    TST  X25, #0x6000600060006000
    ORR  X20, X14, X28, LSL #38
    ASRV  X21, X5, X21
    NGC  W18, W15
    ADDS  W12, W20, W18, SXTX #0
    UMADDL  X17, W23, W21, X4
    BICS  X8, X19, X17, ROR #19
    SUBS  X23, X12, X29, LSL #36
    NGC  W29, W23
    MVN  X20, X8, ASR #2
    ADDS  X18, X13, #0x83
    ADDS  W6, W29, #0xb0f
    SUB  W13, W6, #0x9d3
    MADD  X6, X20, X20, X13
    CSNEG  X19, X6, X18, NV
    SUBS  W18, W18, #0xa24
    CLS  X12, X28
    SUB  W29, W12, W25, UXTW #3
    MADD  W28, W27, W17, W13
    SUB  X4, X13, #0x9ac
    SXTH  W14, W15
    ASRV  W21, W12, W13
    CLZ  X23, X4
    ROR  W7, W5, W5
    BFI  X23, X8, #44, #7
    SUB  W20, W4, #0x5ac, LSL #12
    UMULH  X15, X19, X20
    TST  W18, #0xfffffcff
    ORN  W6, W15, W18, LSL #11
    SUB  X4, X29, #0x6f4, LSL #12
    ADC  W29, W28, W28
    NGCS  X13, X6
    MADD  W6, W13, W13, W23
    ADC  X28, X4, X17
    SUB  W12, W19, W7, ASR #1
    EOR  X15, X6, X6, LSR #6
    SUB  W18, W12, W14, ASR #23
    BFI  X27, X14, #56, #6
    BFXIL  W20, W21, #0x13, #1
    SBFIZ  X21, X28, #13, #39
    BFM  W25, W29, #0x19, #0x2
    CLS  W7, W15
    TST  X25, X7, LSR #5
    ADD  W12, W27, #0x7d0, LSL #12
    ROR  W14, W18, #0xb
    ADD  W8, W14, W20, SXTH #3
    EON  X23, X21, X8, LSL #1
    CSEL  X14, X23, X23, MI
    UXTH  W5, W14
    ORN  W14, W12, W5, LSL #29
    ORN  W13, W21, W26, ASR #12
    SXTH  X15, W26
    UMSUBL  X29, W17, W13, X15
    MSUB  W4, W16, W22, W12
    SBFIZ  X19, X23, #23, #8
    EOR  W12, W25, #0xff80ff8
    ROR  W28, W13, #0x19
    MADD  X21, X18, X15, X28
    BFI  W18, W13, #4, #25
    MVN  X22, X14, LSR #3
    ADD  X5, X14, #0xc85
    ORR  X20, X16, X19, LSL #48
    BICS  W13, W28, W4, LSL #4
    SUBS  W26, W17, W22, LSR #20
    BFM  X23, X29, #0x1e, #0x15
    RBIT  W8, W16
    REV  X17, X13
    SXTB  X13, W17
    ASR  X12, X23, X13
    EON  W15, W18, W5, LSR #22
    CSEL  X27, X8, X15, VC
    SMULH  X25, X21, X26
    ANDS  W22, W13, W27, ASR #24
    SUB  X22, X22, #0x0
    REV  X28, X20
    NGCS  X20, X12
    ROR  W26, W22, W19
    REV16  W14, W28
    UBFX  X23, X25, #0x32, #5
    UXTB  W25, W26
    CLZ  X7, X14
    NGCS  W14, W20
    ROR  W20, W14, W14
    AND  X8, X23, #0xfff03ffffff03fff
    CSEL  W13, W25, W25, VC
    ANDS  W4, W8, #0xfc03ffff
    SMSUBL  X28, W20, W20, X4
    MADD  X15, X28, X28, X28
    SBCS  W14, W13, W7
    MUL  X20, X14, X29
    SXTH  W28, W15
    SUBS  X14, X28, X28, SXTX #2
    SXTH  X8, W20
    UBFIZ  X27, X8, #21, #19
    AND  X12, X14, #0x3fff80003fff8
    MUL  X4, X27, X27
    SUB  W14, W27, #0x567
    UMSUBL  X15, W12, W14, X12
    NGCS  W23, W4
    MSUB  X28, X8, X15, X23
    TST  W5, W15, ROR #0
    NEG  X20, X17, LSR #23
    NGC  W12, W20
    SBFX  W5, W4, #0x3, #24
    NGCS  W29, W26
    EON  X7, X13, X28, ASR #45
    SBFM  X23, X16, #0x29, #0x8
    SUBS  X16, X16, #0x1
    B.NE  TSRTIntAlu_label_0
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x2240, LSL #48
    SUB  X24, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xd040, LSL #16
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntAlu_TestFail
    MOVZ  X11, #0x5c04, LSL #0
    MOVK  X11, #0x2, LSL #16
    SUB  X24, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntAlu_TestFail
    MOVZ  X11, #0xcf40, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X24, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntAlu_TestFail
    MOVZ  X11, #0xe7ff, LSL #0
    MOVK  X11, #0xfe5b, LSL #16
    SUB  X24, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntAlu_TestFail
    MOVZ  X11, #0xfa99, LSL #0
    MOVK  X11, #0xe7ff, LSL #16
    SUB  X24, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntAlu_TestFail
    MOVZ  X11, #0x2000, LSL #0
    MOVK  X11, #0x1c6, LSL #16
    MOVK  X11, #0xb3d8, LSL #32
    MOVK  X11, #0x3, LSL #48
    SUB  X24, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x2df4, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X24, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntAlu_TestFail
    MOVZ  X11, #0xbff6, LSL #0
    MOVK  X11, #0x1fff, LSL #16
    SUB  X24, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xff80, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X24, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntAlu_TestFail
    MOVZ  X11, #0x1800, LSL #0
    MOVK  X11, #0x1a4, LSL #16
    MOVK  X11, #0xfe00, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X24, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntAlu_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xfffd, LSL #16
    SUB  X24, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x80, LSL #16
    SUB  X24, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xe800, LSL #16
    MOVK  X11, #0xf9, LSL #32
    SUB  X24, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntAlu_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0x7a97, LSL #16
    MOVK  X11, #0x6257, LSL #32
    MOVK  X11, #0xb47f, LSL #48
    SUB  X24, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntAlu_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X24, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntAlu_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
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
    MOVZ  X27, #0xf, LSL #0
TSRTIntAlu_label_1:
    NEG  W18, W19, ASR #14
    ADDS  X17, X17, X12, ASR #30
    MUL  X21, X27, X5
    ASR  X22, X16, X18
    RORV  W14, W15, W20
    BICS  X4, X14, X22, LSR #30
    UMSUBL  X29, W27, W4, X28
    TST  W21, W26, ROR #30
    SUB  X13, X29, W29, UXTH #2
    TST  X17, #0x4000400040004000
    REV16  W29, W25
    MUL  W20, W6, W13
    ADCS  X19, X29, X29
    ADCS  X29, X20, X19
    AND  W6, W29, #0xfffc03ff
    SUBS  X20, X6, #0x5ca
    MUL  W15, W20, W20
    SUB  W17, W15, #0x741
    BFM  W13, W17, #0x1f, #0x19
    MSUB  W22, W13, W13, W13
    EOR  X14, X22, X22, LSR #22
    ADDS  W5, W14, W14, LSL #23
    EON  X20, X5, X5, LSL #35
    CSINV  W14, W20, W20, LS
    CSNEG  X16, X14, X14, VC
    EOR  W22, W16, W16, ASR #8
    ADDS  X12, X15, W21, SXTB #2
    RORV  X20, X8, X20
    ADDS  W28, W12, W14, UXTH #1
    SUB  X16, X11, X18, LSL #18
    CSINV  W26, W27, W7, LE
    ADDS  X15, X22, X6, UXTX #4
    ADCS  X17, X8, X4
    SMULH  X12, X14, X15
    ADDS  X6, X15, #0x46d
    CLZ  W25, W16
    UBFX  X16, X28, #0x7, #12
    UBFX  W4, W28, #0x10, #6
    ADD  W13, W14, W8, ASR #26
    ADD  X22, X12, #0x48b, LSL #12
    BFXIL  X29, X26, #0x3a, #4
    MNEG  X15, X17, X13
    CLZ  W5, W16
    UDIV  X19, X29, X29
    RBIT  W17, W5
    NEGS  X28, X20, ASR #11
    TST  X28, X22, LSL #1
    ADD  X21, X4, W17, SXTB #0
    SBFX  X8, X19, #0xd, #27
    CSINV  W18, W25, W15, NE
    NEGS  W25, W21, ASR #16
    EOR  X22, X6, #0x7800000078000
    SDIV  W26, W22, W21
    SMSUBL  X13, W8, W26, X8
    MSUB  X11, X13, X18, X4
    ADDS  X7, X25, X25, LSL #35
    ROR  X6, X7, #0x7
    SUBS  X5, X6, X11, LSR #6
    REV16  W21, W20
    ORR  W14, W7, #0x1f1f1f1f
    MSUB  X12, X8, X21, X27
    SMNEGL  X25, W25, W27
    EOR  W22, W19, #0xffff7fff
    NGC  X26, X17
    SMULH  X28, X17, X17
    BICS  X8, X25, X20, LSR #31
    ADDS  X13, X7, W13, UXTB #0
    UDIV  X14, X19, X13
    TST  W15, #0x1ffffffc
    SUBS  X14, X6, #0x0
    SXTB  X19, W15
    SUB  X4, X16, W13, UXTH #2
    UDIV  W16, W8, W12
    ADDS  W11, W17, W22, ASR #5
    ADDS  W20, W4, W4, UXTH #0
    SBFX  X13, X26, #0x20, #23
    TST  X14, X13, ASR #15
    ROR  X12, X19, #0x3f
    BICS  X11, X28, X16, ROR #0
    UBFIZ  X6, X11, #23, #6
    MADD  W28, W12, W20, W20
    MSUB  X25, X6, X6, X6
    SBCS  X20, X25, X28
    TST  W20, W20, ASR #3
    SBCS  W20, W17, W14
    SXTH  X22, W21
    ADDS  W17, W6, W29, UXTB #4
    SBFM  X28, X26, #0x2a, #0x3c
    ASR  W14, W28, #0x2
    SBC  W12, W4, W20
    SXTW  X21, W18
    NGC  X19, X13
    ADD  W25, W4, W17, ASR #21
    EON  X28, X7, X22, LSL #21
    ASRV  W7, W12, W19
    AND  X16, X11, #0xffffffffff8fffff
    NEGS  X6, X19, LSL #7
    ASR  X15, X14, X11
    EON  X13, X18, X12, ASR #54
    NGCS  X14, X15
    ASRV  X29, X27, X27
    REV16  W17, W28
    MNEG  X18, X16, X7
    SBC  X11, X21, X29
    ANDS  X19, X6, #0xaaaaaaaaaaaaaaaa
    SUBS  X26, X11, X13, UXTX #1
    SBC  W11, W25, W25
    MNEG  X28, X14, X14
    MUL  W12, W6, W8
    MSUB  W22, W17, W11, W18
    UBFM  X13, X19, #0x11, #0x3a
    ANDS  W18, W19, #0xf83fffff
    ADDS  X21, X18, W26, SXTH #1
    ADD  W26, W13, #0xee8, LSL #12
    MSUB  X16, X28, X29, X5
    TST  X22, X16, LSR #27
    SMSUBL  X22, W26, W7, X12
    UBFIZ  W17, W22, #24, #2
    SUBS  X25, X29, W21, UXTH #0
    AND  W11, W17, #0x4040404
    SUBS  X4, X25, #0x3f6
    SUBS  X21, X4, #0xd6, LSL #12
    MSUB  X14, X11, X11, X29
    NEG  W29, W14, LSL #26
    ORR  X15, X21, X21, ASR #9
    SBCS  X21, X15, X15
    NEG  X22, X29, ASR #30
    SUB  X25, X21, X22, LSR #50
    SUB  W6, W21, W12, ASR #27
    NEGS  W14, W15, LSL #19
    NGC  X7, X15
    ASR  W8, W5, W7
    UBFM  W17, W5, #0xa, #0xd
    RBIT  W15, W29
    ADCS  X26, X4, X22
    ADCS  X29, X21, X19
    EXTR  W22, W8, W15, #0x1
    SMNEGL  X16, W19, W5
    SMULH  X5, X15, X11
    UDIV  X19, X27, X16
    ASRV  W21, W19, W22
    SUBS  W22, W21, W14, LSL #20
    SBFIZ  X8, X5, #6, #57
    AND  W15, W22, #0xc001ffff
    REV16  W4, W15
    BFM  W12, W12, #0x2, #0x8
    BICS  W13, W25, W6, LSR #25
    TST  W4, W29, ROR #0
    UMSUBL  X25, W26, W13, X17
    BICS  W7, W25, W8, LSR #29
    ORN  X25, X7, X12, LSR #34
    SUB  W16, W15, W22, LSR #16
    ADD  W18, W14, #0xe0
    REV  W19, W17
    NEG  W21, W27, ASR #25
    MADD  X5, X17, X5, X20
    REV  W15, W26
    UBFIZ  X6, X21, #17, #15
    ROR  W11, W20, #0x9
    ANDS  W12, W21, #0xff007fff
    NGCS  X22, X15
    BFM  X19, X5, #0x2, #0x9
    TST  X25, X6, LSL #12
    ADD  W6, W27, #0xa99
    ADC  X20, X16, X12
    SUB  W17, W22, W6, ASR #14
    RORV  X22, X17, X19
    UBFM  X13, X11, #0x3f, #0x2e
    UDIV  X11, X6, X18
    CSINC  X14, X20, X11, GT
    TST  X22, X13, ROR #31
    SUB  W25, W11, W16, ASR #17
    NEG  X15, X27, ASR #43
    ASR  X13, X22, #0x37
    UMULL  X21, W6, W6
    SUB  W12, W20, W26, SXTH #3
    SUBS  W16, W19, W26, UXTH #2
    ASR  W18, W11, #0x0
    SUBS  X17, X21, #0x745, LSL #12
    BIC  W22, W8, W17, ASR #2
    ORR  W26, W21, W18, LSR #3
    UMULH  X17, X27, X22
    SDIV  X6, X13, X25
    RORV  W20, W6, W21
    BICS  X19, X27, X8, ROR #30
    NEGS  X8, X15, LSR #35
    NEGS  X22, X21, ASR #58
    SXTB  X6, W17
    ADC  X5, X15, X8
    BIC  W11, W22, W14, ROR #7
    MUL  W14, W7, W29
    SBCS  W14, W5, W26
    SMADDL  X25, W5, W12, X12
    NGCS  W7, W6
    AND  X26, X11, X7, LSR #53
    SDIV  X8, X25, X14
    NEG  X17, X19, LSR #56
    EOR  X21, X8, X20, LSL #62
    UMSUBL  X29, W16, W17, X21
    SUBS  W17, W29, W26, SXTW #4
    SUBS  X27, X27, #0x1
    B.NE  TSRTIntAlu_label_1
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X24, #0x1, LSL #0
    SUB  X23, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X23, X24, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X24, #0x1f90, LSL #0
    SUB  X23, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X24, #0x9b5d, LSL #0
    MOVK  X24, #0xff8f, LSL #16
    SUB  X23, X24, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X24, #0x10c7, LSL #0
    MOVK  X24, #0xfffc, LSL #16
    SUB  X23, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X24, #0x1, LSL #0
    SUB  X23, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X24, #0x3f20, LSL #0
    SUB  X23, X24, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0x1, LSL #32
    SUB  X23, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
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
    MOVZ  X20, #0xf, LSL #0
TSRTIntAlu_label_2:
    ANDS  W23, W14, W26, ROR #30
    UDIV  X25, X18, X25
    ADDS  X22, X20, X24, LSL #43
    ASR  X13, X22, X22
    UDIV  W25, W27, W25
    ORR  W6, W23, #0x800000
    AND  X27, X20, X6, LSR #18
    SMNEGL  X7, W25, W26
    SUB  X24, X15, W13, UXTB #1
    SUBS  W14, W8, #0xa6f
    MSUB  W8, W4, W15, W24
    ANDS  X26, X12, X7, LSR #25
    BFXIL  X14, X27, #0x38, #1
    UBFIZ  X24, X26, #26, #6
    SXTH  W8, W8
    SUB  X19, X8, X17, UXTX #1
    SDIV  W17, W14, W14
    ANDS  W25, W7, #0x7ffe7ffe
    UMADDL  X13, W25, W25, X17
    ANDS  W26, W14, #0xc0c0c0c
    SMNEGL  X27, W13, W24
    EOR  W14, W27, W27, ASR #1
    ASRV  X25, X19, X26
    SDIV  X7, X13, X14
    SUB  W24, W7, W7, SXTX #2
    UBFM  W14, W25, #0x5, #0x1a
    ANDS  W8, W24, W14
    RBIT  X17, X8
    ORN  X27, X16, X17, LSR #41
    ADDS  W17, W27, #0xed1
    SBCS  X16, X7, X27
    SBCS  X26, X17, X16
    UMULH  X16, X15, X7
    UBFIZ  X13, X22, #6, #43
    ASR  W19, W4, W12
    ADD  W6, W22, W6, LSR #1
    REV  W16, W16
    ADD  X8, X8, X8, UXTX #3
    RORV  X25, X15, X23
    ASR  X22, X17, X16
    UBFIZ  W12, W8, #8, #3
    SBFX  X4, X25, #0x11, #13
    MADD  W11, W12, W24, W12
    EOR  W27, W15, #0x11111111
    MADD  X24, X18, X24, X23
    SBC  W14, W22, W22
    SMULL  X22, W14, W19
    ANDS  W16, W4, W27, LSR #29
    ORN  W7, W22, W6, LSR #21
    CSNEG  X17, X11, X11, NE
    ADD  W4, W13, #0x96b, LSL #12
    BFI  X19, X4, #24, #29
    BICS  X25, X24, X24, ASR #0
    BFM  W12, W16, #0x14, #0x3
    UBFX  X18, X17, #0x18, #35
    SXTB  X8, W26
    ORR  X23, X7, #0x8007ffff8007ffff
    SUBS  W14, W23, W23, ASR #21
    SBFM  W17, W25, #0xb, #0x5
    CSINC  W11, W19, W8, MI
    AND  X15, X23, #0xc0000003ffffffff
    AND  X26, X15, X17, ASR #17
    BFXIL  W22, W26, #0x1b, #5
    ADDS  X13, X22, #0x620
    SXTB  W6, W18
    ORR  X23, X13, X12, LSL #13
    ROR  X16, X11, X23
    NGC  W27, W14
    UBFM  W21, W6, #0x1d, #0xc
    RORV  W4, W17, W17
    UBFIZ  W24, W27, #1, #21
    MVN  W15, W4, LSR #4
    SXTB  X13, W24
    ROR  W25, W16, #0xb
    UDIV  W19, W13, W21
    MSUB  W8, W19, W15, W15
    ADC  X24, X8, X25
    UMULL  X11, W8, W19
    SUBS  X26, X7, X16, UXTX #4
    NEG  W8, W17, LSL #9
    ADCS  W23, W11, W17
    TST  X23, X16, ROR #2
    SUBS  W6, W24, W6, ASR #5
    MVN  W24, W27, ASR #4
    REV16  W27, W11
    SBFM  X22, X8, #0x1b, #0x2b
    ADD  X14, X6, X26, LSR #5
    UXTH  W18, W14
    UMULH  X16, X23, X24
    NGCS  W25, W19
    RBIT  W4, W22
    SBFM  X11, X22, #0x35, #0x31
    SXTB  W12, W6
    MVN  X19, X16, ROR #42
    NEG  W7, W4, LSR #7
    SDIV  W4, W26, W7
    SXTH  W6, W26
    SUBS  X15, X8, X11, UXTX #0
    REV16  W16, W12
    TST  X6, X19, LSL #24
    MVN  W19, W7, LSR #12
    CSNEG  X26, X18, X11, VC
    UBFX  X12, X8, #0xe, #38
    ADDS  X21, X8, X21, ASR #48
    RBIT  X14, X19
    NGC  W6, W25
    ASR  X17, X14, X4
    SUBS  W7, W12, W15, ASR #17
    UMULH  X15, X7, X16
    NEG  W24, W27, ASR #31
    ROR  W22, W24, W21
    SUB  X19, X6, #0xaff, LSL #12
    RORV  W23, W7, W26
    SMSUBL  X27, W15, W17, X17
    CSINV  X17, X19, X19, VC
    SUB  X11, X23, #0xa10, LSL #12
    SXTH  X12, W27
    TST  W22, #0x1fff1fff
    BIC  X27, X17, X17, LSR #30
    ROR  W26, W27, W27
    SUB  X25, X17, X26, SXTX #0
    MADD  W21, W11, W25, W12
    SBFM  W12, W5, #0x1d, #0x13
    SUB  X15, X23, X14, SXTX #1
    TST  W24, #0x1000000
    ADD  W25, W25, #0x3ff
    UMULH  X5, X19, X25
    SUB  X25, X12, X25, ASR #41
    SBFM  X7, X24, #0x1b, #0x3
    CLS  X12, X20
    SUBS  X8, X26, X19, ASR #7
    BFM  W22, W22, #0xb, #0x14
    BIC  W24, W16, W15, LSR #30
    UBFIZ  X26, X14, #57, #7
    ANDS  X11, X21, X21, ROR #20
    MSUB  X19, X24, X8, X13
    REV16  W13, W12
    SUBS  W16, W13, #0xe0d
    ROR  X21, X16, X11
    CSINV  X6, X21, X21, NE
    ANDS  X13, X19, X6, LSL #6
    CLZ  W12, W22
    SMNEGL  X23, W5, W25
    ADDS  X11, X13, #0x6e6, LSL #12
    EON  X25, X12, X7, ROR #61
    NEG  X6, X26, LSR #50
    SBFIZ  X24, X25, #58, #4
    UBFM  W25, W24, #0x1f, #0x1a
    SBCS  X26, X15, X11
    CSNEG  X14, X23, X23, GT
    NEGS  W8, W6, LSR #8
    SMSUBL  X22, W26, W8, X27
    CSINC  W21, W22, W22, VC
    ASR  W16, W14, #0xd
    TST  X16, #0xf7f7f7f7f7f7f7f7
    BFI  W6, W21, #29, #3
    ASR  W19, W6, W25
    ASR  X7, X24, #0xc
    MSUB  X12, X23, X8, X13
    SBFX  W11, W26, #0x4, #19
    BICS  X13, X6, X27, ROR #20
    BFM  W16, W23, #0x17, #0xd
    CSNEG  X15, X8, X12, NE
    AND  W22, W15, #0x3ffff800
    ASR  X5, X4, X16
    ASR  W16, W17, #0x18
    ADDS  X15, X27, X13, LSL #32
    SMNEGL  X14, W5, W16
    CLS  X26, X17
    ANDS  W21, W8, #0x33333333
    SMULL  X5, W26, W24
    MSUB  W27, W21, W6, W24
    ASR  W16, W13, W13
    SUB  X24, X19, #0x265
    ASR  X26, X11, #0x3b
    SUB  W11, W5, W14, SXTW #2
    BFXIL  X6, X24, #0x1d, #23
    SUB  W12, W11, #0x6b1
    ASRV  X4, X7, X6
    SMULL  X8, W12, W27
    SXTH  X23, W16
    ADD  X16, X26, X8, LSR #46
    SUBS  X27, X4, X23, ASR #54
    BFXIL  W13, W16, #0xa, #13
    ADDS  X12, X27, X15, SXTX #2
    UXTH  W21, W13
    ROR  X26, X21, #0x8
    EON  W23, W26, W12, ROR #5
    SXTH  X5, W23
    BIC  X24, X5, X5, ASR #12
    UBFM  W5, W22, #0x8, #0x1d
    ADDS  X17, X5, W5, UXTB #2
    UMNEGL  X5, W24, W17
    MSUB  W23, W13, W11, W19
    CSNEG  W24, W5, W4, LE
    ORR  X21, X23, X17, LSL #21
    NEG  X12, X20, LSR #53
    MNEG  X14, X4, X21
    NGC  X26, X22
    BFM  X4, X20, #0x39, #0xd
    SUBS  X20, X20, #0x1
    B.NE  TSRTIntAlu_label_2
    MOVZ  X29, #0x80, LSL #0
    MOVK  X29, #0xf800, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X28, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTIntAlu_TestFail
    MOVZ  X29, #0x3, LSL #0
    MOVK  X29, #0x8000, LSL #16
    SUB  X28, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xc000, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X28, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x8000, LSL #16
    SUB  X28, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTIntAlu_TestFail
    MOVZ  X29, #0xffc, LSL #0
    MOVK  X29, #0xff50, LSL #16
    MOVK  X29, #0x8000, LSL #48
    SUB  X28, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTIntAlu_TestFail
    MOVZ  X29, #0xfffe, LSL #0
    SUB  X28, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x8000, LSL #16
    SUB  X28, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x8000, LSL #16
    SUB  X28, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x8000, LSL #16
    SUB  X28, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTIntAlu_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X28, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xf800, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X28, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTIntAlu_TestFail
    MOVZ  X4, #0x4dd5, LSL #0
    MOVK  X4, #0x660, LSL #16
    MOVK  X4, #0xad25, LSL #32
    MOVK  X4, #0xeae1, LSL #48
    MOVZ  X5, #0xf037, LSL #0
    MOVK  X5, #0x7122, LSL #16
    MOVK  X5, #0x362d, LSL #32
    MOVK  X5, #0x734b, LSL #48
    MOVZ  X6, #0xb4de, LSL #0
    MOVK  X6, #0xb731, LSL #16
    MOVK  X6, #0x5ec4, LSL #32
    MOVK  X6, #0x131b, LSL #48
    MOVZ  X7, #0xdeb4, LSL #0
    MOVK  X7, #0xd0b8, LSL #16
    MOVK  X7, #0x2733, LSL #32
    MOVK  X7, #0x4ecf, LSL #48
    MOVZ  X8, #0xef91, LSL #0
    MOVK  X8, #0x78dd, LSL #16
    MOVK  X8, #0xde73, LSL #32
    MOVK  X8, #0x5fa3, LSL #48
    MOVZ  X11, #0x886d, LSL #0
    MOVK  X11, #0xf3e4, LSL #16
    MOVK  X11, #0x9fbc, LSL #32
    MOVK  X11, #0xb314, LSL #48
    MOVZ  X12, #0x19fd, LSL #0
    MOVK  X12, #0x9d24, LSL #16
    MOVK  X12, #0x1713, LSL #32
    MOVK  X12, #0x31e7, LSL #48
    MOVZ  X13, #0x1c3d, LSL #0
    MOVK  X13, #0xbd38, LSL #16
    MOVK  X13, #0xa70e, LSL #32
    MOVK  X13, #0xebc7, LSL #48
    MOVZ  X14, #0xea8c, LSL #0
    MOVK  X14, #0x5cf9, LSL #16
    MOVK  X14, #0xdc64, LSL #32
    MOVK  X14, #0x28d3, LSL #48
    MOVZ  X15, #0x1e82, LSL #0
    MOVK  X15, #0x824b, LSL #16
    MOVK  X15, #0x6118, LSL #32
    MOVK  X15, #0x3f9b, LSL #48
    MOVZ  X16, #0x1a10, LSL #0
    MOVK  X16, #0x2f4c, LSL #16
    MOVK  X16, #0xe96e, LSL #32
    MOVK  X16, #0x48e5, LSL #48
    MOVZ  X17, #0x4dcc, LSL #0
    MOVK  X17, #0xaa, LSL #16
    MOVK  X17, #0x754e, LSL #32
    MOVK  X17, #0xaca9, LSL #48
    MOVZ  X18, #0xa244, LSL #0
    MOVK  X18, #0x15b3, LSL #16
    MOVK  X18, #0x5cde, LSL #32
    MOVK  X18, #0x946c, LSL #48
    MOVZ  X19, #0xd09c, LSL #0
    MOVK  X19, #0x7f0a, LSL #16
    MOVK  X19, #0x8864, LSL #32
    MOVK  X19, #0x7d88, LSL #48
    MOVZ  X20, #0x7f5a, LSL #0
    MOVK  X20, #0xab78, LSL #16
    MOVK  X20, #0x293b, LSL #32
    MOVK  X20, #0xe03f, LSL #48
    MOVZ  X21, #0x4179, LSL #0
    MOVK  X21, #0xada4, LSL #16
    MOVK  X21, #0x8b68, LSL #32
    MOVK  X21, #0x9da9, LSL #48
    MOVZ  X22, #0x8a79, LSL #0
    MOVK  X22, #0x3713, LSL #16
    MOVK  X22, #0xb4d3, LSL #32
    MOVK  X22, #0x87a, LSL #48
    MOVZ  X23, #0xbfd3, LSL #0
    MOVK  X23, #0xa6c1, LSL #16
    MOVK  X23, #0x1508, LSL #32
    MOVK  X23, #0x5b56, LSL #48
    MOVZ  X24, #0xa262, LSL #0
    MOVK  X24, #0x5f9c, LSL #16
    MOVK  X24, #0xcf88, LSL #32
    MOVK  X24, #0x4a30, LSL #48
    MOVZ  X25, #0x647d, LSL #0
    MOVK  X25, #0xf90a, LSL #16
    MOVK  X25, #0xdfc7, LSL #32
    MOVK  X25, #0x5ac6, LSL #48
    MOVZ  X26, #0x7349, LSL #0
    MOVK  X26, #0x3dc5, LSL #16
    MOVK  X26, #0xc2e1, LSL #32
    MOVK  X26, #0xe4f4, LSL #48
    MOVZ  X27, #0x6982, LSL #0
    MOVK  X27, #0xa9a0, LSL #16
    MOVK  X27, #0xd3e4, LSL #32
    MOVK  X27, #0xbb96, LSL #48
    MOVZ  X28, #0xd33b, LSL #0
    MOVK  X28, #0xf8c1, LSL #16
    MOVK  X28, #0xa47b, LSL #32
    MOVK  X28, #0x9d57, LSL #48
    MOVZ  X29, #0xeb3e, LSL #0
    MOVK  X29, #0xe49f, LSL #16
    MOVK  X29, #0x3a20, LSL #32
    MOVK  X29, #0x40fb, LSL #48
    MOVZ  X7, #0xf, LSL #0
TSRTIntAlu_label_3:
    TST  W28, #0x10101010
    SBFX  X20, X25, #0x2d, #14
    BFM  W13, W27, #0x16, #0x13
    SXTH  X27, W26
    UMADDL  X27, W27, W29, X13
    ASR  X5, X24, X7
    ROR  W23, W27, W5
    BIC  W25, W23, W23, LSR #8
    EOR  W20, W20, W20, ROR #23
    CSNEG  W4, W20, W25, NV
    MUL  X26, X29, X11
    EOR  W6, W29, #0xff03ff03
    SBC  X15, X29, X21
    ADD  X21, X27, X8, UXTX #2
    UMULH  X23, X7, X22
    NGC  X16, X22
    CLZ  W23, W22
    CSNEG  X13, X16, X15, MI
    SUB  W20, W22, W18, SXTB #3
    SUBS  W8, W8, #0xe4a
    ORR  W16, W16, W8, LSL #22
    CSNEG  W20, W26, W20, AL
    ADD  W21, W18, W18, UXTX #1
    SBFM  W29, W23, #0xd, #0x1
    ASRV  W18, W24, W6
    NEG  W15, W5, ASR #1
    BICS  W6, W27, W23, ROR #17
    BIC  W23, W6, W6, ROR #8
    ADDS  X5, X19, #0x9a8, LSL #12
    SMULL  X28, W21, W29
    EXTR  X11, X4, X4, #0xc
    SBC  W5, W18, W15
    SBFM  X18, X23, #0x19, #0x3f
    ORR  X26, X5, #0x3fffffe03fffffe0
    CSEL  X8, X28, X20, NE
    MNEG  W20, W26, W13
    TST  W18, W20, LSL #11
    EOR  X27, X11, X16, LSR #12
    AND  X13, X8, #0x9f9f9f9f9f9f9f9f
    UBFM  W20, W27, #0x14, #0x4
    MVN  W27, W13, ROR #25
    CSINV  X23, X5, X20, PL
    EXTR  X24, X27, X23, #0x24
    SBC  W18, W12, W28
    ADCS  W26, W21, W20
    CSNEG  W23, W20, W27, LT
    NEGS  X21, X12, LSL #19
    EOR  X4, X8, #0xff1fff1fff1fff1f
    SBFM  X28, X8, #0xd, #0x22
    SUB  X20, X21, X21, LSL #7
    ADDS  X27, X23, W6, UXTB #1
    ORN  X16, X8, X7, LSL #18
    ROR  X12, X6, #0x3a
    ASR  W5, W24, W24
    SXTB  W24, W5
    NGC  W6, W24
    SUB  W5, W18, #0xaba
    CLZ  X23, X27
    UBFM  W21, W21, #0x16, #0x8
    REV  X8, X5
    SUBS  X13, X20, #0x31b, LSL #12
    EOR  W24, W4, #0xfff7ffff
    SUBS  W11, W6, W23, ASR #30
    SUBS  X23, X12, #0xed9
    RBIT  X12, X21
    UMULH  X18, X28, X23
    NEGS  W4, W16, LSL #11
    CSINC  W13, W4, W12, VC
    BICS  X28, X18, X13, ASR #12
    RBIT  W23, W28
    SXTH  X21, W23
    SUB  X18, X8, W21, SXTW #3
    ORN  W24, W18, W11, LSR #17
    SMULH  X27, X24, X24
    REV  X12, X27
    ASRV  W28, W12, W26
    REV16  X4, X6
    MSUB  X5, X27, X16, X18
    SUB  W11, W21, #0xf32
    ORN  X20, X26, X7, ROR #38
    EOR  W16, W21, #0x77777777
    EOR  X19, X7, #0xffdfffffffdfffff
    ASRV  W19, W16, W28
    SMULL  X16, W24, W26
    CSNEG  W13, W21, W29, EQ
    BIC  X18, X19, X19, ROR #23
    EOR  X8, X23, X16, ROR #21
    SBC  W12, W8, W22
    MUL  X24, X28, X25
    BICS  X8, X25, X16, ROR #37
    UMULL  X22, W15, W18
    ASR  W21, W12, #0xc
    SBC  W26, W4, W25
    ADCS  X27, X28, X19
    UBFIZ  W6, W5, #27, #5
    BFXIL  X28, X6, #0x1f, #33
    REV16  W18, W24
    BFI  W23, W26, #25, #6
    REV16  W24, W21
    NEGS  W25, W20, LSR #8
    ORN  W15, W25, W8, ROR #16
    REV  W12, W22
    TST  W11, #0xfff80003
    NGC  X16, X27
    SMNEGL  X26, W12, W13
    BFM  W4, W26, #0x1b, #0x5
    SUB  W19, W24, W16, SXTH #3
    ORN  X8, X28, X15, ASR #16
    EOR  X26, X18, X8, ASR #53
    SBFIZ  W20, W23, #26, #1
    CSINV  X5, X19, X20, GT
    SXTH  X22, W4
    UDIV  X11, X16, X12
    ADD  W13, W5, #0x24e
    NEG  W6, W13, LSL #20
    MVN  X21, X26, LSR #2
    UMULL  X24, W11, W21
    UBFIZ  X25, X22, #14, #16
    UXTB  W22, W6
    UXTH  W27, W24
    MUL  X13, X27, X27
    ADDS  W16, W25, W22, ASR #12
    UDIV  X12, X28, X23
    ROR  W20, W12, W13
    SXTH  X24, W16
    AND  X8, X24, X24, ASR #18
    MSUB  W11, W8, W8, W20
    SDIV  X15, X13, X15
    BFXIL  W20, W28, #0x13, #3
    BIC  W27, W21, W16, LSL #12
    ORN  W4, W27, W29, ROR #26
    MNEG  W28, W13, W29
    REV16  X29, X6
    MSUB  W21, W19, W19, W6
    AND  W23, W24, #0x3fe
    REV16  X12, X25
    SUB  X8, X11, #0x8f0
    SMULH  X11, X28, X8
    NGCS  W22, W15
    ADD  W25, W20, W12, SXTX #1
    REV16  W16, W25
    EOR  W13, W4, #0xfff0fff0
    REV16  W26, W11
    ADD  X28, X16, W21, UXTH #1
    ASR  X27, X22, X29
    CSEL  X11, X27, X27, VS
    ASR  W4, W23, #0x3
    UBFIZ  W23, W28, #26, #6
    UDIV  W27, W6, W23
    ROR  W22, W4, #0x5
    MADD  X8, X13, X22, X11
    SXTB  X16, W26
    ROR  X23, X27, X16
    UMNEGL  X25, W8, W23
    NGCS  X28, X26
    TST  W26, W8, ROR #16
    SUB  W20, W22, W13, ASR #10
    NEGS  W19, W26, LSL #26
    ANDS  X6, X4, X20, LSL #1
    NEG  X23, X18, ASR #40
    ADDS  W12, W7, W18, ASR #28
    MVN  W4, W8, ASR #17
    SUB  W13, W5, W29, LSL #27
    ORR  X27, X19, X23, ROR #61
    ANDS  W26, W25, W28, LSL #23
    ROR  X18, X23, #0x29
    MVN  W15, W5, ASR #27
    SDIV  X11, X7, X13
    ANDS  W28, W26, #0xdddddddd
    NEGS  W23, W11, LSR #16
    UMULL  X22, W13, W19
    REV32  X8, X28
    SXTW  X5, W21
    ORN  W26, W8, W4, ROR #7
    ADDS  X13, X15, W5, UXTB #0
    CSINV  X20, X13, X22, PL
    ANDS  X25, X15, X6, LSL #40
    UBFIZ  X19, X23, #34, #25
    RBIT  X11, X20
    UBFM  X8, X19, #0x3, #0x5
    UDIV  X20, X27, X8
    BFI  W11, W18, #6, #13
    CSINV  X23, X26, X26, VC
    TST  W12, #0xf0000000
    ADD  X22, X25, #0xa81, LSL #12
    UDIV  W15, W20, W22
    ORR  X18, X15, X11, ASR #12
    BFXIL  X13, X18, #0x9, #25
    ASRV  X18, X23, X13
    SUBS  X23, X22, X20, UXTX #2
    SMULL  X13, W16, W25
    SMULL  X11, W25, W4
    UXTH  W19, W6
    EOR  W15, W16, #0xfffcfffc
    ASR  X20, X19, #0x30
    REV32  X16, X15
    ASR  W25, W5, #0x16
    CSEL  W27, W29, W15, VC
    ROR  X28, X28, X7
    TST  X23, X18, LSL #20
    SUBS  X7, X7, #0x1
    B.NE  TSRTIntAlu_label_3
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X17, #0x7c07, LSL #0
    MOVK  X17, #0x6d7b, LSL #16
    SUB  X14, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X17, #0x1, LSL #0
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X17, #0xfffc, LSL #0
    MOVK  X17, #0xfffc, LSL #16
    SUB  X14, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X17, #0xfcff, LSL #0
    MOVK  X17, #0xfcff, LSL #16
    SUB  X14, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X14, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X17, #0x7c07, LSL #0
    MOVK  X17, #0x6d7b, LSL #16
    SUB  X14, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X17, #0x1000, LSL #0
    MOVK  X17, #0xa8, LSL #16
    SUB  X14, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X17, #0x1000, LSL #0
    MOVK  X17, #0xa8, LSL #16
    SUB  X14, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X17, #0xc000, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X14, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X17, #0x1b5, LSL #0
    SUB  X14, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X14, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x30db, LSL #16
    SUB  X14, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x30db, LSL #16
    SUB  X14, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
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
    MOVZ  X12, #0xf, LSL #0
TSRTIntAlu_label_4:
    ADD  W7, W8, #0xafc, LSL #12
    ORR  X7, X14, X27, ASR #38
    NGCS  W23, W29
    REV16  X17, X16
    MSUB  W29, W22, W24, W24
    BFI  X11, X12, #51, #1
    SBFX  X17, X23, #0xa, #2
    SXTH  W7, W15
    ROR  W6, W19, #0x1
    SXTH  W16, W18
    UMADDL  X15, W25, W11, X25
    EOR  X15, X26, #0x3ff80
    MNEG  X6, X20, X28
    SBCS  X7, X6, X6
    SUBS  X25, X16, W16, SXTH #2
    ANDS  W28, W25, W29, ROR #22
    ADD  W14, W28, W15, LSL #11
    REV32  X22, X14
    ADD  X19, X7, X7, SXTX #0
    SUB  W20, W15, #0x9c8, LSL #12
    UMULL  X23, W20, W17
    ROR  X6, X19, X22
    ORR  X16, X23, #0xfffffc01fffffc01
    ADD  X26, X6, W16, SXTH #4
    EON  X7, X11, X20, LSL #49
    SMULL  X18, W27, W7
    BFM  X19, X11, #0x30, #0x28
    NEG  W20, W8, ASR #20
    ORN  X29, X15, X20, LSR #26
    ASR  X11, X15, #0x1a
    RORV  X25, X6, X28
    REV  X17, X11
    EOR  W23, W5, #0x70000
    MUL  W22, W6, W5
    MSUB  W20, W29, W22, W15
    UBFM  X7, X6, #0x27, #0x37
    ADD  W8, W20, #0x2f6
    SMADDL  X16, W24, W20, X23
    EXTR  X24, X16, X14, #0x2b
    CSEL  W27, W12, W28, LT
    ASR  X11, X19, X26
    UBFIZ  W4, W23, #7, #14
    SUBS  W6, W7, W7, LSL #6
    ASR  W20, W6, #0x11
    ROR  W14, W8, W11
    ROR  X5, X20, #0x1c
    ADC  W25, W4, W5
    REV16  X5, X14
    CLZ  X22, X5
    NGCS  W5, W17
    CLS  W23, W24
    MADD  W14, W18, W23, W22
    ROR  W20, W25, W17
    SMULH  X23, X27, X27
    BICS  W4, W5, W5, LSR #30
    BIC  W29, W20, W22, LSR #0
    EOR  W24, W24, W5, ROR #31
    ASR  W17, W20, #0x11
    SXTB  W27, W17
    ADC  X17, X29, X23
    SBFM  X5, X18, #0x30, #0x16
    UMSUBL  X7, W4, W5, X27
    EXTR  W6, W17, W17, #0x1
    CSINC  X19, X14, X7, NV
    BFXIL  W23, W6, #0x1b, #4
    TST  X24, X19, ROR #43
    SUBS  X14, X27, #0x336, LSL #12
    UDIV  X8, X18, X6
    MADD  X7, X5, X8, X29
    NEGS  W24, W23, LSL #5
    ASR  X26, X28, X27
    SXTB  W17, W29
    BFI  W20, W17, #26, #4
    ADDS  W4, W24, W8, SXTW #4
    CSINV  X5, X12, X7, CS
    BFM  W22, W15, #0x16, #0x9
    EON  W18, W17, W28, ASR #26
    CSEL  W6, W29, W6, VS
    SDIV  X25, X17, X20
    SMNEGL  X17, W16, W23
    RORV  X29, X14, X25
    SUB  W27, W29, W23, LSR #22
    UMSUBL  X19, W17, W22, X22
    EOR  X22, X26, #0xfff0fff0fff0fff0
    NGC  W26, W18
    ASR  X16, X5, X6
    ORR  X6, X19, #0xf001fffff001ffff
    SUBS  W18, W16, W4, LSL #29
    UDIV  W29, W6, W6
    SUBS  W20, W26, W27, LSR #1
    EXTR  W17, W22, W29, #0x12
    EXTR  W29, W20, W18, #0x2
    CSNEG  W19, W29, W29, GE
    SMULH  X16, X17, X19
    REV16  W15, W25
    ANDS  X29, X19, X23, ASR #54
    MVN  W5, W16, ROR #11
    ASR  X24, X24, #0x3c
    ROR  W27, W8, W22
    UMULH  X23, X7, X6
    UBFIZ  W26, W25, #16, #6
    SBFM  W17, W11, #0x1d, #0x18
    CSINC  X11, X23, X24, LE
    BIC  W4, W4, W7, LSL #5
    ROR  W23, W24, W6
    SBFX  W24, W27, #0x1b, #3
    CLS  W25, W11
    ANDS  W16, W23, W24, ROR #13
    SMNEGL  X7, W15, W15
    EOR  X24, X4, #0xfffe000
    ORR  W18, W24, W24, LSR #6
    MSUB  X4, X7, X17, X16
    BFXIL  X17, X25, #0x0, #32
    TST  W26, #0x78000000
    SUBS  X25, X17, X14, ASR #46
    RBIT  X22, X25
    CSINC  X24, X29, X5, NE
    CSINV  X27, X18, X22, CS
    EOR  X11, X27, X24, LSL #11
    SUB  W5, W11, W14, LSR #29
    ADDS  X11, X5, X4, LSL #25
    SXTH  W16, W25
    SXTW  X8, W5
    ADD  X7, X15, X22, UXTX #4
    SXTH  X19, W6
    RBIT  W26, W16
    ORR  W17, W16, W26, LSL #4
    EOR  X29, X24, #0x1ff000000000
    SUBS  W18, W29, W18, LSR #15
    ORR  W26, W28, #0xdddddddd
    MVN  X4, X28, ROR #49
    SBFX  X16, X18, #0x12, #32
    ASRV  W25, W29, W28
    CSINC  X27, X25, X17, LS
    EOR  X14, X4, X26, LSR #51
    ROR  X5, X11, X11
    SBCS  X4, X8, X8
    EON  X24, X4, X4, LSL #44
    ROR  W26, W5, W5
    ROR  W18, W19, #0x1b
    ASR  W29, W24, W27
    SBFIZ  W28, W16, #21, #4
    TST  X7, X22, LSR #60
    RORV  W26, W28, W14
    UMADDL  X22, W26, W29, X18
    NEG  W17, W8, LSL #8
    SUB  W25, W29, W28, LSR #27
    RBIT  X26, X6
    MNEG  X6, X12, X19
    UMULL  X14, W26, W19
    SUB  X4, X14, X7, SXTX #2
    SUB  W7, W15, W19, UXTX #2
    SBFM  W28, W20, #0xb, #0x14
    REV32  X16, X4
    MUL  W18, W18, W25
    AND  W24, W29, W12, LSR #18
    BFI  X8, X5, #56, #8
    ROR  X11, X7, #0x2f
    ROR  X29, X28, X22
    SDIV  X28, X15, X6
    SMADDL  X25, W28, W16, X16
    RORV  W14, W17, W27
    ADD  X15, X18, #0xa01, LSL #12
    SUBS  W6, W8, #0xb21, LSL #12
    EOR  W4, W24, W11, ROR #14
    SBFIZ  W19, W15, #9, #10
    UBFM  X18, X16, #0x1, #0x1b
    SBFX  X16, X25, #0x12, #13
    BFI  X5, X4, #39, #8
    SUB  X4, X14, X5, SXTX #0
    NGC  W5, W18
    NGCS  X18, X19
    SUB  W17, W29, #0x8c4
    CLS  W11, W18
    ADDS  W29, W6, W4, SXTW #4
    UMSUBL  X27, W16, W29, X5
    SBCS  X29, X6, X20
    TST  W11, #0x30003
    TST  W29, #0x81818181
    ADD  W20, W27, W17, ASR #23
    REV16  W6, W14
    REV  W17, W18
    CSEL  X25, X26, X5, MI
    ADD  W8, W28, #0x991
    SBFIZ  W5, W28, #5, #1
    SUB  X14, X11, #0x60, LSL #12
    ASRV  X19, X25, X16
    SUBS  W16, W27, W28, UXTW #4
    ASR  W25, W18, #0xe
    CSINC  W24, W25, W5, HI
    MUL  X4, X17, X17
    UBFX  W25, W4, #0x12, #4
    ASRV  X4, X6, X14
    SXTH  X11, W19
    ANDS  W14, W4, W22, ASR #29
    SBCS  X26, X25, X11
    MADD  W29, W8, W16, W12
    ADD  W16, W14, #0x38d, LSL #12
    SUBS  W27, W20, W24, LSR #19
    BFM  X19, X26, #0x2b, #0x37
    SUBS  X12, X12, #0x1
    B.NE  TSRTIntAlu_label_4
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X21, #0x8, LSL #0
    SUB  X13, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X21, #0x4, LSL #0
    SUB  X13, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X21, #0x991, LSL #0
    SUB  X13, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X21, #0x1, LSL #0
    SUB  X13, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X21, #0x101f, LSL #0
    MOVK  X21, #0xa0, LSL #16
    SUB  X13, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X21, #0xd000, LSL #0
    MOVK  X21, #0x38, LSL #16
    SUB  X13, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xc2, LSL #16
    SUB  X13, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X21, #0xc200, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X13, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X21, #0x52f7, LSL #0
    MOVK  X21, #0x7cb5, LSL #16
    SUB  X13, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X13, X21, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X13, X21, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X21, #0xe, LSL #0
    SUB  X13, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X21, #0xc, LSL #0
    SUB  X13, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X21, #0x32f8, LSL #0
    MOVK  X21, #0x7cb5, LSL #16
    SUB  X13, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X21, #0xb679, LSL #0
    MOVK  X21, #0x29e, LSL #16
    SUB  X13, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
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
    MOVZ  X20, #0xf, LSL #0
TSRTIntAlu_label_5:
    CSEL  X19, X28, X29, LS
    MNEG  W8, W20, W20
    ROR  W23, W19, W19
    SMADDL  X8, W23, W8, X24
    NGCS  X25, X27
    SUB  X21, X24, W26, UXTB #4
    REV32  X6, X22
    SBC  X28, X6, X8
    SBFM  X23, X25, #0x35, #0x20
    UMULH  X25, X21, X23
    NGC  X14, X25
    EON  X29, X28, X14, LSL #46
    MSUB  X23, X16, X14, X11
    NGC  X26, X25
    ORR  X18, X4, #0xfffffff0000000ff
    AND  X13, X11, X5, ROR #2
    CSINV  X8, X14, X11, MI
    ASR  W6, W18, W5
    ASR  W16, W26, #0x0
    ASR  W11, W16, W11
    RORV  X27, X6, X18
    SUB  W25, W29, #0x770, LSL #12
    MUL  W4, W16, W15
    ADDS  X6, X14, #0xec8
    ADDS  X21, X15, W21, SXTW #4
    SMULH  X15, X21, X11
    CLS  X22, X8
    ADD  W28, W27, W8, UXTX #1
    BFM  W14, W22, #0x1c, #0x8
    ORN  W16, W25, W25, LSL #22
    ASRV  W5, W14, W15
    SDIV  W29, W6, W23
    MSUB  W25, W5, W16, W4
    SBC  X5, X13, X29
    NEG  W11, W5, LSL #10
    SXTH  W21, W25
    SBC  W29, W11, W28
    SBC  W15, W21, W21
    ADDS  W11, W15, W15, SXTW #2
    ASRV  W25, W22, W11
    BICS  X18, X29, X25, LSR #43
    SUB  X21, X5, #0x48d
    ASRV  W27, W5, W4
    EXTR  X28, X26, X4, #0x3f
    UBFIZ  W26, W27, #12, #8
    EXTR  X16, X13, X22, #0x22
    AND  W5, W14, #0x7070707
    UDIV  W14, W18, W22
    BIC  W6, W27, W28, ASR #15
    SMULL  X8, W26, W24
    AND  X18, X16, #0xffff800fffff800f
    ROR  X24, X5, X15
    EON  W13, W8, W17, ROR #8
    ASRV  X23, X21, X13
    SBFM  W22, W13, #0x8, #0x5
    RORV  W15, W20, W23
    ADCS  X4, X8, X11
    UBFM  X17, X21, #0x12, #0x1e
    ORR  W29, W21, W5, LSL #21
    SMULL  X23, W29, W14
    SXTW  X28, W22
    SUBS  X16, X17, W13, UXTW #3
    CLZ  W22, W28
    UXTH  W29, W4
    SBFIZ  W4, W22, #4, #18
    SUBS  W5, W6, W24, UXTH #3
    RORV  W18, W23, W18
    BFI  X23, X4, #39, #18
    SBFIZ  W22, W29, #5, #10
    UBFM  X27, X15, #0x3f, #0x1d
    BFI  W26, W16, #30, #1
    ADDS  W11, W22, W26, ASR #21
    UBFIZ  W15, W11, #15, #13
    ASR  X11, X27, #0x1a
    SBC  W8, W11, W23
    ROR  W27, W23, #0x2
    ORN  W14, W18, W27, LSL #26
    UMULL  X17, W5, W14
    CSNEG  X6, X17, X20, GE
    REV32  X4, X15
    CSEL  X21, X29, X8, CC
    UBFIZ  W11, W6, #13, #12
    MVN  W23, W11, ASR #8
    ADDS  X14, X21, #0xa46
    BFM  W28, W4, #0x1b, #0x1b
    UMULL  X29, W23, W14
    CSINV  X27, X28, X29, HI
    ADDS  X13, X14, X25, ASR #55
    TST  X13, #0x1fffe000000
    SDIV  X18, X24, X15
    EOR  W26, W13, W27, ROR #28
    UXTH  W22, W20
    CSINV  W17, W14, W14, CC
    ADDS  X25, X11, X4, LSL #55
    MUL  X5, X23, X4
    EOR  W29, W17, #0xfc00007f
    NEGS  X6, X27, ASR #62
    SBFM  W11, W19, #0xb, #0x11
    SMULH  X27, X17, X14
    TST  X25, X27, LSR #45
    SBC  W14, W18, W6
    BIC  W8, W11, W5, ROR #5
    ORR  X27, X22, #0x1f001f001f001f0
    EON  W28, W29, W14, ASR #16
    CLZ  W15, W8
    TST  X27, X6, ROR #39
    SDIV  X17, X15, X28
    EXTR  X25, X17, X26, #0x1c
    MSUB  W22, W26, W6, W23
    BFI  X6, X25, #16, #6
    ASR  X21, X25, #0x27
    ORR  X18, X4, X15, LSL #61
    ASR  X11, X11, X20
    RORV  X27, X24, X20
    ANDS  X19, X5, #0xc0000001c0000001
    ADC  W13, W8, W14
    MADD  W14, W4, W21, W6
    ANDS  W8, W29, W5
    BICS  X29, X19, X22, ASR #38
    AND  W6, W22, W26, ASR #15
    UXTB  W23, W25
    SMSUBL  X25, W21, W18, X6
    ANDS  W15, W27, W18, ROR #5
    SUB  X28, X24, X15, SXTX #0
    NGCS  W6, W29
    BICS  W21, W8, W13, LSR #6
    TST  X14, X21, ROR #3
    NEGS  W5, W11, LSR #1
    SUB  X17, X5, W22, UXTB #2
    ASRV  W24, W23, W6
    CSEL  X15, X24, X24, CC
    ORR  W24, W15, #0xc000c
    ANDS  W27, W24, W24, ROR #30
    ROR  W11, W17, W25
    UXTB  W11, W27
    MNEG  X22, X28, X28
    SUB  X24, X11, X11, LSR #46
    NGCS  X13, X24
    SBCS  X28, X13, X13
    BICS  X23, X22, X22, ASR #47
    ADD  W22, W23, W28, LSR #16
    MNEG  W13, W8, W26
    ANDS  W29, W15, W14, ASR #16
    TST  X8, #0x1ff800001ff8
    ROR  W4, W26, #0x3
    UMULL  X17, W20, W19
    NEG  W23, W29, LSR #22
    SBCS  X14, X4, X24
    ROR  X4, X14, #0x17
    UXTH  W15, W14
    UBFIZ  X8, X20, #16, #31
    SUBS  X25, X22, #0x726
    ORR  W28, W21, W17, ROR #0
    RORV  W14, W22, W29
    BFXIL  W22, W25, #0xe, #14
    CLS  X25, X24
    AND  W26, W23, #0x6
    CLZ  X6, X25
    SUB  X29, X8, W14, SXTH #3
    UMULH  X17, X13, X14
    ADDS  X8, X15, #0xc93, LSL #12
    ASRV  X23, X4, X22
    MADD  W24, W6, W23, W6
    SUB  X15, X29, X8, ASR #51
    RORV  W6, W26, W15
    EOR  W11, W28, #0xfffff80f
    ORN  X29, X11, X17, ROR #31
    ROR  X19, X6, X29
    CSINV  W28, W19, W19, PL
    BICS  W15, W20, W24, ROR #30
    EOR  W24, W28, #0xe000ffff
    CSINC  X29, X15, X15, HI
    AND  W4, W24, #0x40
    ROR  W24, W4, W29
    MUL  W23, W15, W22
    UBFIZ  X22, X11, #36, #12
    SUBS  W13, W13, W15, UXTW #3
    MVN  W29, W6, LSR #12
    RORV  X14, X8, X19
    UBFX  W26, W23, #0x13, #6
    ADC  W17, W11, W16
    MUL  X4, X26, X14
    REV16  X16, X27
    EON  W6, W16, W18, ASR #27
    SUBS  X15, X27, #0x0
    SDIV  X14, X21, X8
    CLZ  X26, X22
    SXTB  W28, W5
    SXTB  X11, W4
    SUBS  X19, X29, X6, SXTX #3
    EON  W23, W14, W17, ROR #4
    AND  X5, X24, #0xffffffffffffe007
    ADD  X18, X11, #0x24c
    UMSUBL  X24, W5, W5, X28
    SBFM  W27, W13, #0x1d, #0x0
    UMULL  X13, W18, W27
    BFI  X16, X23, #7, #29
    SUBS  X11, X15, #0x7ba
    SUB  W15, W11, W22, SXTX #1
    SUB  W4, W15, W26, LSR #9
    SUBS  X20, X20, #0x1
    B.NE  TSRTIntAlu_label_5
    MOVZ  X7, #0xf846, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X12, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X12, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X7, #0xd041, LSL #0
    MOVK  X7, #0xc9, LSL #16
    SUB  X12, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X7, #0xf846, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X12, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X7, #0xeda0, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0x24b, LSL #32
    SUB  X12, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X7, #0x13f, LSL #0
    SUB  X12, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X7, #0xf846, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X12, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X7, #0xe280, LSL #0
    MOVK  X7, #0xc598, LSL #16
    MOVK  X7, #0x8, LSL #32
    SUB  X12, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X7, #0xf05e, LSL #0
    MOVK  X7, #0xe74c, LSL #16
    SUB  X12, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X7, #0x24c, LSL #0
    SUB  X12, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X7, #0x7, LSL #0
    MOVK  X7, #0xfff9, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X12, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xfc00, LSL #16
    SUB  X12, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x80e0, LSL #32
    SUB  X12, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X7, #0x31c5, LSL #0
    MOVK  X7, #0x118b, LSL #16
    SUB  X12, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X7, #0x1, LSL #0
    SUB  X12, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X7, #0x3f, LSL #0
    SUB  X12, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X7, #0x10, LSL #0
    SUB  X12, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X7, #0xfff8, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X7, #0x1, LSL #0
    SUB  X12, X7, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X12, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X4, #0xd591, LSL #0
    MOVK  X4, #0x1015, LSL #16
    MOVK  X4, #0x3569, LSL #32
    MOVK  X4, #0x8802, LSL #48
    MOVZ  X5, #0xbf19, LSL #0
    MOVK  X5, #0x8d0b, LSL #16
    MOVK  X5, #0x2f1a, LSL #32
    MOVK  X5, #0x850e, LSL #48
    MOVZ  X6, #0x2cf6, LSL #0
    MOVK  X6, #0xf8b4, LSL #16
    MOVK  X6, #0x2276, LSL #32
    MOVK  X6, #0x3ef5, LSL #48
    MOVZ  X7, #0x5fd5, LSL #0
    MOVK  X7, #0x1cee, LSL #16
    MOVK  X7, #0x16a4, LSL #32
    MOVK  X7, #0xe25d, LSL #48
    MOVZ  X8, #0x3a6a, LSL #0
    MOVK  X8, #0x7cc3, LSL #16
    MOVK  X8, #0xf8f2, LSL #32
    MOVK  X8, #0xe2ec, LSL #48
    MOVZ  X11, #0x98ab, LSL #0
    MOVK  X11, #0x3ad9, LSL #16
    MOVK  X11, #0x76a6, LSL #32
    MOVK  X11, #0xd65e, LSL #48
    MOVZ  X12, #0x9292, LSL #0
    MOVK  X12, #0x18a2, LSL #16
    MOVK  X12, #0x99a3, LSL #32
    MOVK  X12, #0x48ac, LSL #48
    MOVZ  X13, #0xcf9b, LSL #0
    MOVK  X13, #0x7212, LSL #16
    MOVK  X13, #0xfb8f, LSL #32
    MOVK  X13, #0x9a8c, LSL #48
    MOVZ  X14, #0x70eb, LSL #0
    MOVK  X14, #0x32f8, LSL #16
    MOVK  X14, #0x6230, LSL #32
    MOVK  X14, #0xf89b, LSL #48
    MOVZ  X15, #0x2b9d, LSL #0
    MOVK  X15, #0xe8e1, LSL #16
    MOVK  X15, #0x256b, LSL #32
    MOVK  X15, #0x3c7d, LSL #48
    MOVZ  X16, #0xc3f2, LSL #0
    MOVK  X16, #0x715f, LSL #16
    MOVK  X16, #0xab6, LSL #32
    MOVK  X16, #0x4a91, LSL #48
    MOVZ  X17, #0x4985, LSL #0
    MOVK  X17, #0xa470, LSL #16
    MOVK  X17, #0x9030, LSL #32
    MOVK  X17, #0x8e8a, LSL #48
    MOVZ  X18, #0x9051, LSL #0
    MOVK  X18, #0x4a7e, LSL #16
    MOVK  X18, #0x2e21, LSL #32
    MOVK  X18, #0xda3, LSL #48
    MOVZ  X19, #0x38fc, LSL #0
    MOVK  X19, #0x15ce, LSL #16
    MOVK  X19, #0x1335, LSL #32
    MOVK  X19, #0xd07e, LSL #48
    MOVZ  X20, #0xf986, LSL #0
    MOVK  X20, #0x25bd, LSL #16
    MOVK  X20, #0xb2f9, LSL #32
    MOVK  X20, #0x577f, LSL #48
    MOVZ  X21, #0xa04, LSL #0
    MOVK  X21, #0x6324, LSL #16
    MOVK  X21, #0x9e40, LSL #32
    MOVK  X21, #0xd0b0, LSL #48
    MOVZ  X22, #0xce7e, LSL #0
    MOVK  X22, #0xae34, LSL #16
    MOVK  X22, #0x8c78, LSL #32
    MOVK  X22, #0x8c14, LSL #48
    MOVZ  X23, #0xabe5, LSL #0
    MOVK  X23, #0x6213, LSL #16
    MOVK  X23, #0x8586, LSL #32
    MOVK  X23, #0x61e7, LSL #48
    MOVZ  X24, #0x1d38, LSL #0
    MOVK  X24, #0x95b5, LSL #16
    MOVK  X24, #0x5d37, LSL #32
    MOVK  X24, #0x62f2, LSL #48
    MOVZ  X25, #0x3a72, LSL #0
    MOVK  X25, #0xda8c, LSL #16
    MOVK  X25, #0x9df9, LSL #32
    MOVK  X25, #0xcb1f, LSL #48
    MOVZ  X26, #0x73c, LSL #0
    MOVK  X26, #0xafc1, LSL #16
    MOVK  X26, #0xb737, LSL #32
    MOVK  X26, #0x95f6, LSL #48
    MOVZ  X27, #0xf01d, LSL #0
    MOVK  X27, #0xcbe1, LSL #16
    MOVK  X27, #0xadb3, LSL #32
    MOVK  X27, #0x975, LSL #48
    MOVZ  X28, #0x8406, LSL #0
    MOVK  X28, #0xab85, LSL #16
    MOVK  X28, #0xd1c1, LSL #32
    MOVK  X28, #0xf93e, LSL #48
    MOVZ  X29, #0xa4df, LSL #0
    MOVK  X29, #0xba52, LSL #16
    MOVK  X29, #0x2c5c, LSL #32
    MOVK  X29, #0x7ec5, LSL #48
    MOVZ  X27, #0xf, LSL #0
TSRTIntAlu_label_6:
    TST  W27, W26, ROR #3
    SMNEGL  X19, W29, W25
    MSUB  X19, X28, X28, X19
    SDIV  X26, X23, X19
    SMSUBL  X6, W26, W26, X26
    SBFIZ  W7, W6, #18, #9
    CLS  W19, W7
    ASRV  X6, X19, X19
    SUB  W26, W24, #0x47f
    SUB  X11, X26, X6, ASR #62
    CSNEG  W29, W16, W20, VC
    TST  X29, #0x3fff80000000000
    ADDS  W5, W15, #0xfc7
    CLZ  W17, W15
    BICS  X17, X11, X18, ASR #54
    NGC  X28, X27
    REV16  W18, W28
    EXTR  W11, W25, W15, #0x18
    CSINV  X20, X27, X21, GE
    SDIV  X23, X4, X25
    RORV  W25, W16, W23
    SUB  W24, W24, W18, LSR #29
    REV32  X16, X19
    SUB  X28, X27, W16, SXTH #4
    NGCS  X26, X4
    BICS  W14, W28, W24, ROR #24
    SMULL  X18, W17, W5
    ORR  W21, W27, W23, ROR #26
    RORV  W5, W26, W23
    MSUB  X15, X27, X24, X20
    CLS  X19, X29
    CSEL  W17, W18, W22, CC
    SMULL  X4, W23, W24
    BFXIL  X20, X14, #0x36, #8
    BFI  W23, W20, #4, #24
    SBFM  W20, W11, #0xc, #0x5
    ROR  W29, W25, W20
    ADD  W6, W5, W21, SXTH #0
    ADDS  W16, W15, W19, ASR #4
    UXTB  W19, W4
    ORR  X25, X16, X23, LSR #7
    ORR  X22, X17, X17, LSL #25
    EXTR  X5, X29, X29, #0x2e
    ASRV  W28, W6, W25
    CSNEG  W17, W28, W19, MI
    ADD  X28, X22, X17, LSL #49
    UMSUBL  X18, W28, W28, X5
    SUB  X17, X14, W17, UXTB #2
    NGC  W14, W28
    ANDS  W11, W29, #0xf801f801
    SBFX  X22, X5, #0x2a, #4
    MADD  W19, W19, W23, W28
    ASR  W24, W15, #0x18
    NGC  X4, X24
    SUBS  W21, W22, W15, SXTW #1
    ROR  X25, X21, X4
    TST  X22, #0xffffff800001ffff
    ORR  X22, X26, X24, ASR #22
    MVN  W5, W17, ASR #9
    ADD  X16, X20, W20, SXTW #2
    MNEG  X6, X20, X11
    NEG  W17, W15, LSR #14
    NEG  X29, X14, LSR #13
    EOR  W16, W19, #0x1f8000
    MUL  X26, X25, X22
    SUBS  W4, W29, W26, LSR #4
    ANDS  W26, W29, #0xe3e3e3e3
    SMULH  X21, X5, X18
    ANDS  W23, W4, W26, LSR #1
    NEGS  W4, W16, ASR #2
    BICS  X18, X4, X6, ROR #19
    MNEG  W6, W21, W23
    ROR  X20, X17, X18
    BIC  X29, X6, X19, LSL #56
    TST  X29, #0x3fffffffff8
    BFM  X14, X15, #0xe, #0x28
    CLZ  W28, W13
    SXTH  X5, W17
    ADDS  W15, W13, W25, LSR #11
    MVN  X6, X24, ASR #10
    BFXIL  W16, W23, #0x3, #23
    SUBS  W22, W20, W24, LSR #0
    SBCS  X20, X24, X4
    BFM  W26, W6, #0x7, #0x1e
    SXTB  X13, W28
    ROR  W29, W19, W18
    ORR  W23, W29, #0x7ffff8
    BFI  X25, X5, #4, #14
    BFM  W21, W25, #0x16, #0x19
    UMULL  X19, W21, W21
    SUB  W29, W4, #0x45e
    UXTH  W4, W14
    ADDS  W18, W16, W20, ASR #19
    BFI  X7, X23, #40, #2
    EON  W17, W7, W18, LSR #17
    ORN  W28, W22, W22, ASR #29
    UXTH  W14, W15
    SBC  X16, X13, X17
    UBFX  W6, W5, #0x1a, #2
    AND  W21, W6, #0x8000003f
    UDIV  X24, X16, X26
    ASRV  X20, X19, X19
    UMNEGL  X15, W26, W4
    ROR  W26, W28, #0x8
    SUB  W23, W20, #0xbfa, LSL #12
    ASR  X25, X14, X24
    ADDS  X4, X23, X29, ASR #53
    NGC  X19, X25
    CLS  X25, X4
    ADDS  X28, X21, X25, ASR #53
    SBFIZ  W16, W15, #7, #24
    SBFIZ  W5, W22, #8, #7
    SBFX  X15, X5, #0x0, #53
    SXTH  X13, W15
    BICS  W24, W13, W26, ASR #4
    REV16  W15, W24
    MNEG  W24, W19, W16
    BIC  W19, W7, W28, LSR #4
    MUL  X20, X19, X19
    UDIV  X23, X20, X15
    SMULH  X19, X23, X24
    ASR  X21, X28, #0x2f
    UMSUBL  X25, W20, W4, X27
    NGC  X4, X25
    RBIT  X15, X21
    RBIT  X24, X18
    BFM  X17, X4, #0x28, #0x24
    BFXIL  X13, X29, #0x18, #11
    SUBS  X25, X29, #0x6e4
    CSINC  W26, W18, W17, AL
    UBFM  X5, X18, #0x1c, #0x2a
    MVN  X22, X18, ASR #63
    SXTB  W18, W23
    MUL  X7, X4, X21
    BFI  X23, X7, #62, #2
    ADDS  X4, X4, W23, UXTB #2
    ANDS  X28, X4, X15, LSL #56
    ROR  W20, W18, #0x15
    AND  X23, X28, X25, LSL #47
    TST  W22, #0xe00fe00f
    UBFX  X16, X5, #0x4, #58
    CSINC  X15, X19, X26, AL
    SUBS  W7, W16, W20, LSL #17
    EXTR  W17, W13, W7, #0x15
    MVN  X7, X23, LSR #7
    ANDS  X18, X15, X24, LSL #28
    RORV  X29, X17, X17
    ADDS  X28, X7, X29, ASR #36
    EOR  X15, X18, #0xffc007ffffffffff
    CSINC  X16, X15, X28, LS
    SUBS  X15, X17, X23, ASR #55
    ANDS  W24, W4, #0xfc00fc00
    ADC  W22, W13, W20
    CSNEG  W21, W7, W23, EQ
    MSUB  X4, X26, X26, X27
    CSEL  X23, X20, X26, PL
    EXTR  W25, W25, W18, #0x10
    ASR  W19, W23, W22
    UBFX  X7, X6, #0xb, #22
    UBFIZ  X26, X15, #22, #38
    BIC  X21, X17, X6, LSR #62
    EOR  W22, W5, W16, LSR #13
    CSINV  W16, W19, W14, EQ
    SUBS  X23, X24, X7, ASR #32
    TST  X11, #0xffffe3ffffffe3ff
    ADDS  X6, X26, #0x73a
    BIC  W16, W27, W4, ROR #13
    EOR  W7, W5, #0xfcfffcff
    BICS  X11, X24, X17, LSL #47
    MADD  W18, W6, W21, W19
    SUBS  W21, W11, W24, LSR #29
    ORR  W14, W23, #0x1e
    NEGS  W5, W19, LSL #25
    CSINV  W15, W25, W18, PL
    EXTR  X23, X28, X29, #0x32
    ANDS  W13, W18, #0x3ffe00
    CSINC  X18, X21, X14, PL
    MNEG  W6, W22, W22
    UBFIZ  W4, W18, #14, #1
    EXTR  W11, W4, W13, #0xd
    TST  W5, #0xfffff007
    ASR  X21, X23, #0xe
    ADDS  X19, X11, X7, UXTX #1
    CSINC  W11, W21, W21, NV
    ADDS  X14, X15, #0xbd7
    ORR  W5, W11, W14, LSR #6
    MSUB  X7, X6, X6, X16
    REV  X13, X7
    SXTB  X29, W11
    ORR  W14, W19, #0x7e007e0
    AND  W4, W14, #0x100000
    CLZ  X23, X4
    SXTB  X14, W23
    MUL  X25, X14, X29
    REV16  X6, X25
    MADD  W15, W13, W6, W13
    SMULH  X21, X15, X5
    EOR  X16, X27, #0xfcfcfcfcfcfcfcfc
    SMULL  X7, W13, W17
    NEG  X25, X5, LSL #13
    SUBS  X27, X27, #0x1
    B.NE  TSRTIntAlu_label_6
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x10, LSL #16
    SUB  X12, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X12, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X8, #0xd5ff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X12, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X8, #0x4000, LSL #0
    MOVK  X8, #0xc03f, LSL #16
    MOVK  X8, #0xd935, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X12, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0x9c, LSL #16
    MOVK  X8, #0xff7c, LSL #32
    MOVK  X8, #0xf0d8, LSL #48
    SUB  X12, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X8, #0x2b, LSL #0
    SUB  X12, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X8, #0x2a00, LSL #0
    MOVK  X8, #0x3e00, LSL #16
    SUB  X12, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X8, #0xfcfd, LSL #0
    MOVK  X8, #0xfcfc, LSL #16
    MOVK  X8, #0xfcfc, LSL #32
    MOVK  X8, #0xfcfc, LSL #48
    SUB  X12, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X8, #0xc000, LSL #0
    MOVK  X8, #0xffc0, LSL #16
    SUB  X12, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X8, #0xfbf9, LSL #0
    MOVK  X8, #0xfc00, LSL #16
    SUB  X12, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X8, #0xfb47, LSL #0
    MOVK  X8, #0xf9ff, LSL #16
    MOVK  X8, #0x1, LSL #32
    SUB  X12, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X8, #0xfff6, LSL #0
    MOVK  X8, #0x7, LSL #16
    SUB  X12, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X8, #0x2b, LSL #0
    SUB  X12, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X8, #0xfc00, LSL #0
    MOVK  X8, #0xfc00, LSL #16
    SUB  X12, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X8, #0x2000, LSL #0
    MOVK  X8, #0xe000, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X12, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xf030, LSL #32
    MOVK  X8, #0x3f, LSL #48
    SUB  X12, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X12, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntAlu_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
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
    MOVZ  X5, #0xf, LSL #0
TSRTIntAlu_label_7:
    AND  W8, W20, #0x7f7f7f7f
    MVN  W16, W12, ASR #18
    BFI  W29, W22, #31, #1
    SXTH  W18, W14
    ROR  W13, W23, W28
    ASR  X11, X13, X21
    CSEL  X29, X29, X11, HI
    AND  W12, W26, #0x100010
    MNEG  W7, W27, W5
    UMADDL  X20, W25, W24, X8
    EOR  W21, W16, #0x3
    ROR  X19, X20, X12
    UXTH  W8, W7
    ANDS  X11, X21, X21, ROR #41
    SBFM  W21, W19, #0x1d, #0x1e
    BFM  W25, W8, #0x1, #0x10
    SUBS  W13, W18, W11, ASR #25
    SUBS  X11, X25, X29, LSR #29
    UBFM  X27, X13, #0x20, #0x14
    RORV  X29, X11, X27
    NGCS  X25, X21
    ADDS  W23, W29, #0x95f
    UMADDL  X20, W22, W23, X23
    SMULH  X8, X25, X20
    ASR  W11, W27, #0x1c
    SUB  X20, X13, W7, UXTB #0
    SMNEGL  X29, W28, W12
    RBIT  X7, X14
    ADDS  W24, W24, W4, ASR #8
    ASR  W25, W27, W25
    CLS  X18, X5
    ORR  X19, X24, #0xff00ffffff00ffff
    BIC  X27, X29, X13, ASR #35
    ADDS  W23, W11, W4, SXTW #0
    BFM  X14, X5, #0x39, #0xc
    RBIT  W22, W18
    ANDS  X12, X20, #0xc0007fffc0007fff
    CSNEG  W21, W7, W26, NE
    CLS  X26, X8
    BFXIL  W4, W25, #0x12, #5
    ASR  X28, X4, #0x24
    TST  X28, #0x80000000800000
    SBFX  W28, W27, #0x0, #26
    ORN  X27, X19, X28, LSL #46
    BFI  W28, W22, #6, #25
    ORR  W13, W28, #0xe0000fff
    UBFM  W28, W13, #0x12, #0xa
    UMULH  X11, X18, X28
    ORN  W13, W21, W21, ROR #8
    SBFM  X28, X26, #0x25, #0x3f
    CSNEG  X22, X23, X12, GE
    REV16  X4, X13
    UBFX  X29, X22, #0xf, #23
    NEG  X19, X14, ASR #51
    BFM  W18, W27, #0x12, #0x19
    ADCS  X22, X11, X4
    EON  X21, X18, X28, LSR #52
    UBFIZ  W12, W19, #16, #12
    EOR  W20, W21, W29, LSR #17
    UMULL  X25, W22, W20
    EOR  X19, X12, X25, ASR #42
    ASR  X22, X23, #0x2f
    REV32  X23, X26
    SUBS  X28, X22, #0x0
    UXTH  W22, W25
    EON  W25, W5, W24, ASR #20
    ADD  W7, W8, W19, LSR #25
    SBC  W14, W4, W22
    ADD  X20, X11, #0x8cc
    BICS  X18, X24, X8, ROR #51
    SUBS  X19, X8, W29, SXTW #0
    NEGS  X26, X22, LSR #1
    ADD  W28, W27, W25, SXTH #2
    SUBS  W25, W19, W28, LSL #12
    ASR  X13, X25, X26
    SMADDL  X22, W18, W18, X13
    SBFIZ  X26, X20, #51, #8
    SXTB  X11, W11
    SBFIZ  X24, X14, #50, #6
    SMSUBL  X12, W23, W22, X22
    CSNEG  W21, W7, W7, CS
    BFM  W26, W12, #0xa, #0x11
    TST  W11, #0x7fc00000
    SUB  X18, X26, X26, ASR #36
    AND  X11, X21, #0x1fffe00000000000
    ANDS  X23, X29, X24, ASR #15
    CSNEG  W4, W13, W16, GT
    REV  W16, W4
    ADDS  W29, W18, #0xed8, LSL #12
    TST  X11, #0x7ffff800000
    BFXIL  W21, W29, #0x17, #4
    ORR  X29, X21, #0xfffffffffffffff8
    SBFIZ  W27, W23, #14, #2
    SUB  X11, X16, W27, UXTH #2
    ASR  W12, W29, #0x5
    ADC  W28, W11, W11
    BFXIL  W18, W12, #0x14, #4
    BFM  W12, W28, #0x5, #0xa
    SXTH  X11, W25
    SUBS  X28, X18, W23, UXTH #4
    SUBS  X29, X26, W12, SXTH #1
    BFXIL  X21, X29, #0x1f, #32
    ORN  W27, W28, W28, ROR #7
    SBCS  X4, X20, X17
    EON  W13, W4, W4, ASR #1
    SUBS  W22, W11, #0xa78
    EXTR  W18, W21, W22, #0xc
    CSINV  X4, X27, X13, MI
    CLS  X28, X4
    SBFIZ  W7, W18, #30, #2
    SBCS  W16, W28, W28
    ORR  X24, X16, X7, ASR #45
    TST  W21, W21, LSL #26
    TST  X16, #0xfff8000ffff8000f
    ORN  X18, X29, X18, ASR #6
    TST  W14, #0xe00fffff
    SMNEGL  X16, W22, W4
    MUL  W29, W13, W13
    MNEG  W18, W28, W26
    UDIV  W20, W24, W25
    MVN  X12, X11, LSL #40
    SUBS  W23, W20, W5, LSR #10
    SBFIZ  X24, X14, #49, #9
    NEG  X13, X22, LSR #59
    BFM  W22, W27, #0xf, #0x0
    CSEL  X17, X22, X12, VC
    ADDS  X12, X26, X14, UXTX #2
    SUBS  X14, X20, W16, UXTW #4
    RBIT  W4, W17
    ADDS  X21, X8, #0xf3e
    UMNEGL  X26, W13, W21
    SMSUBL  X27, W4, W29, X24
    SBC  W28, W23, W18
    SBC  X29, X27, X28
    UMULL  X25, W26, W29
    NEG  W29, W4, LSL #11
    SUB  W27, W29, W14, LSR #2
    ANDS  W7, W27, #0xfefffeff
    MUL  X29, X25, X25
    CSINC  X20, X23, X12, CC
    CLS  W16, W7
    NGCS  X21, X29
    RORV  X28, X21, X21
    UMULH  X8, X29, X20
    BIC  W24, W16, W8, ASR #14
    BICS  W25, W28, W24, ROR #18
    EXTR  W26, W18, W16, #0x1d
    SDIV  W4, W11, W4
    SUBS  W12, W16, #0x3
    UMULH  X27, X18, X18
    NGCS  W28, W5
    BFM  W14, W19, #0x12, #0x13
    SBFM  X8, X4, #0x19, #0xc
    REV  W20, W27
    ADD  X21, X11, X17, LSR #40
    SUBS  W17, W17, W14, LSR #30
    MVN  W18, W17, ASR #8
    TST  W5, W20, ROR #27
    BFI  X14, X26, #24, #38
    CLS  X27, X4
    UMNEGL  X26, W22, W18
    NEGS  X16, X16, LSL #11
    CLS  X11, X8
    SBCS  X22, X28, X16
    BFI  X17, X11, #15, #49
    SMULL  X24, W12, W12
    BFI  W11, W17, #26, #3
    BFI  W17, W24, #5, #16
    SMNEGL  X18, W21, W17
    MADD  W8, W11, W18, W18
    UBFX  X24, X26, #0x24, #9
    ORR  W18, W24, #0x3fff00
    SDIV  W4, W8, W22
    ADDS  X19, X14, X18, LSL #24
    ADC  X8, X19, X27
    TST  W25, #0x1ff01ff
    BICS  X12, X8, X4, ROR #11
    EON  W16, W27, W8, ROR #6
    UMULH  X20, X11, X4
    ADCS  X27, X28, X5
    SXTH  W21, W7
    ROR  W17, W25, W11
    ROR  W26, W27, #0x14
    UBFIZ  W8, W13, #28, #4
    ASR  W28, W13, #0x17
    ROR  X7, X17, #0x22
    CSINC  X25, X7, X12, NE
    TST  W19, #0x1f801f8
    REV32  X28, X7
    ANDS  X19, X20, #0x20000000200000
    SBFX  X18, X4, #0x12, #18
    AND  W21, W21, #0x7f807f80
    SBC  X4, X11, X27
    NEG  W7, W8, LSR #19
    ASR  W17, W19, #0x1c
    BIC  W11, W17, W18, LSL #21
    EXTR  W27, W28, W11, #0x15
    REV  X12, X26
    ADDS  X13, X7, X21, UXTX #0
    BIC  X21, X13, X4, LSL #17
    SUBS  X5, X5, #0x1
    B.NE  TSRTIntAlu_label_7
    MOVZ  X15, #0x3e, LSL #0
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X6, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    MOVK  X15, #0x7f80, LSL #16
    SUB  X6, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X15, #0x2783, LSL #0
    MOVK  X15, #0xe008, LSL #16
    MOVK  X15, #0xffe4, LSL #32
    MOVK  X15, #0xff, LSL #48
    SUB  X6, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X15, #0xdf5f, LSL #0
    MOVK  X15, #0xf4a3, LSL #16
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    MOVK  X15, #0x7f80, LSL #16
    SUB  X6, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X15, #0x1ffe, LSL #0
    MOVK  X15, #0x1, LSL #32
    SUB  X6, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X15, #0x1f7, LSL #0
    SUB  X6, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc000, LSL #16
    MOVK  X15, #0x7fff, LSL #32
    MOVK  X15, #0x3fff, LSL #48
    SUB  X6, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x6, LSL #16
    SUB  X6, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X15, #0xc0, LSL #0
    MOVK  X15, #0xff3f, LSL #32
    MOVK  X15, #0xff7f, LSL #48
    SUB  X6, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
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
    MOVZ  X6, #0xf, LSL #0
TSRTIntAlu_label_8:
    SBC  W22, W16, W29
    BIC  W23, W23, W25
    ASR  X18, X28, X22
    AND  X21, X27, X18, ROR #45
    EON  W15, W25, W24, LSL #16
    UMADDL  X28, W6, W15, X15
    SUBS  W4, W19, W23, LSR #23
    SUBS  W23, W14, W4, LSL #16
    RBIT  W28, W21
    SBFIZ  W20, W23, #4, #5
    CSINV  X8, X28, X20, EQ
    UXTB  W20, W8
    ORR  X22, X20, X21, LSR #10
    SUB  W29, W20, #0xebd, LSL #12
    ADD  X20, X22, X28, LSL #63
    ADDS  W22, W29, #0xd69
    REV  X8, X20
    BICS  X28, X22, X22, ROR #59
    ASRV  W25, W8, W8
    BFI  X15, X25, #53, #11
    UBFIZ  X18, X28, #57, #5
    ADD  W29, W15, W23, LSL #8
    SXTW  X21, W29
    SMSUBL  X20, W18, W21, X21
    ASR  X23, X20, X21
    UBFX  X22, X25, #0x11, #23
    ANDS  X21, X25, #0xff03ffffffffffff
    BFXIL  W25, W24, #0xd, #4
    SUB  X14, X16, X6, LSR #47
    ANDS  X24, X12, #0x9f9f9f9f9f9f9f9f
    RBIT  X27, X29
    CLS  X19, X4
    BFI  X20, X23, #2, #40
    SUB  W15, W23, W24, LSL #17
    UBFM  W24, W18, #0x8, #0x14
    MADD  W28, W24, W27, W22
    ROR  W8, W28, #0x15
    AND  W17, W8, W20, ROR #18
    EON  W18, W15, W21, ROR #26
    SBFX  W20, W19, #0x6, #17
    ROR  X23, X17, #0x1
    EON  X29, X23, X25, ASR #47
    SXTH  X16, W18
    CSINC  W4, W14, W14, HI
    RORV  W28, W20, W29
    SMULH  X8, X16, X28
    SUBS  W23, W4, #0x0
    UDIV  W20, W23, W8
    ASR  W19, W20, W22
    SXTH  W4, W5
    ADD  X18, X19, #0xba4
    NEG  W25, W25, ASR #16
    NEGS  X8, X28, LSR #4
    AND  W22, W16, #0x1fff8
    SUBS  W14, W8, W6, ASR #21
    UBFX  X23, X23, #0xc, #9
    SBCS  W29, W24, W21
    MNEG  W24, W5, W8
    UMULL  X21, W17, W23
    AND  W23, W28, W11, ASR #26
    MUL  W19, W22, W28
    NGC  X20, X19
    ADD  W17, W29, W4, ASR #12
    BFI  X19, X23, #6, #51
    ORN  X15, X12, X19, LSR #40
    SMNEGL  X29, W17, W14
    EOR  X14, X29, #0xdfdfdfdfdfdfdfdf
    SBFM  X16, X25, #0x1b, #0x1f
    CLZ  W5, W21
    EXTR  X25, X5, X20, #0x3a
    TST  X15, X18, ROR #21
    ADD  W24, W24, W24, LSL #17
    CLS  W23, W16
    SUBS  X20, X14, X23, SXTX #3
    BIC  W22, W20, W24, ROR #16
    BFI  W4, W22, #26, #2
    SBCS  X8, X29, X12
    ASR  W15, W14, #0x18
    NEG  W24, W25, LSR #30
    UMULL  X5, W4, W24
    ROR  W21, W8, W8
    EXTR  X17, X15, X5, #0x1c
    ADD  X22, X17, X21, SXTX #3
    UBFM  X21, X12, #0xb, #0x30
    SUB  W24, W28, W4, UXTX #2
    REV  W29, W14
    ASR  W11, W19, W18
    BFM  X16, X19, #0x24, #0xe
    ORN  X14, X25, X8, ROR #58
    SUB  X20, X27, X15, LSL #43
    CLS  X23, X5
    SUBS  W17, W16, #0x209
    UDIV  X16, X23, X24
    ASR  W4, W29, #0x5
    ORR  W25, W14, W22, ASR #19
    EON  W5, W21, W25, LSR #1
    ASRV  W18, W11, W17
    SUBS  X25, X5, #0x161
    NEG  X29, X4, LSL #2
    SUB  X28, X16, X16, LSL #23
    SXTH  X11, W29
    NGC  W23, W18
    BFM  W24, W11, #0x7, #0x16
    SXTB  X8, W8
    SUB  X27, X12, #0xf76
    SBC  W15, W23, W27
    REV16  W22, W25
    SDIV  X11, X13, X14
    EOR  X25, X20, X20, ASR #17
    RORV  X20, X25, X8
    CSINV  W25, W23, W20, LE
    SUBS  W27, W25, W28, SXTB #4
    CSNEG  X5, X11, X11, CC
    MUL  X12, X18, X4
    RBIT  X23, X12
    SUB  X16, X23, W27, SXTH #0
    EXTR  W28, W5, W5, #0x6
    UBFM  X29, X22, #0x10, #0x3
    ASR  X14, X24, #0x2b
    TST  X14, #0x1e1e1e1e1e1e1e1e
    UXTB  W27, W15
    NEGS  W12, W16, LSR #26
    CSINV  W18, W29, W13, CC
    SBFX  W11, W28, #0x1b, #1
    EOR  X25, X27, X11, LSL #34
    CSNEG  X8, X12, X25, AL
    EXTR  W12, W18, W8, #0x1
    EOR  X15, X19, #0xfffffffe0
    UDIV  X28, X28, X15
    REV  X4, X5
    SBC  X5, X21, X24
    SUB  X14, X13, X5, ASR #57
    ADDS  X27, X8, W19, SXTB #3
    ASR  W20, W6, #0x6
    SBFX  X8, X12, #0x13, #44
    ADD  X18, X13, W27, UXTB #1
    SUB  X21, X22, #0x683
    SBFX  X25, X17, #0x3d, #1
    SBFX  X11, X6, #0x19, #35
    SUB  X17, X11, #0xc19, LSL #12
    UXTB  W13, W25
    ASR  W23, W4, #0x19
    ASR  X19, X20, X23
    ADC  X15, X17, X14
    ADD  X24, X17, #0x65a
    SUBS  X25, X28, X21, LSR #41
    ROR  X27, X8, X15
    CLZ  W16, W13
    SUB  W5, W19, #0x389
    MSUB  W8, W5, W23, W16
    ROR  W12, W24, W24
    UXTB  W29, W12
    ORR  X17, X18, #0xffe00000000001ff
    UMULL  X16, W8, W17
    SXTH  W14, W27
    SBFX  W20, W14, #0x5, #2
    ADCS  W4, W25, W29
    AND  W21, W16, #0xfff8001f
    EON  X13, X18, X21, ROR #35
    SBFM  W25, W4, #0x0, #0x12
    REV16  X17, X20
    SUB  X29, X25, #0x679, LSL #12
    MNEG  W25, W29, W17
    ORR  X20, X8, X25, LSL #2
    EOR  W15, W13, W13, ROR #21
    EXTR  X5, X15, X20, #0x37
    SUB  X13, X15, #0x566, LSL #12
    TST  X19, #0x8000000000000
    ANDS  W19, W8, W12, ASR #4
    SUBS  X4, X19, #0x20
    SMADDL  X28, W6, W6, X16
    NGCS  X29, X17
    UBFIZ  W14, W29, #10, #12
    RORV  X8, X21, X21
    SXTH  W21, W8
    MNEG  W27, W13, W20
    BFI  X25, X29, #32, #25
    NGC  W8, W18
    UMULL  X15, W13, W23
    MVN  X17, X4, ROR #43
    SMNEGL  X4, W11, W8
    ANDS  X13, X21, #0x1fffffffffff000
    TST  X13, #0xfffffffffff00
    UBFM  X18, X14, #0x29, #0x0
    MSUB  W19, W5, W15, W5
    SXTB  W16, W4
    SUBS  W27, W27, W21, ASR #16
    CLS  X14, X18
    BFXIL  X8, X19, #0x28, #18
    ADCS  W23, W27, W8
    MUL  W4, W16, W28
    SMULH  X8, X21, X25
    SXTB  W19, W14
    CLS  W18, W19
    NEG  W18, W18, LSR #29
    RBIT  W15, W23
    NEGS  X23, X17, LSL #22
    EON  X11, X23, X12, ROR #23
    ASR  W27, W8, #0x16
    UMULL  X5, W27, W27
    SUBS  X6, X6, #0x1
    B.NE  TSRTIntAlu_label_8
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X7, #0xfe60, LSL #0
    MOVK  X7, #0xffbf, LSL #16
    MOVK  X7, #0x81ff, LSL #32
    MOVK  X7, #0xc4d2, LSL #48
    SUB  X26, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X7, #0x96bf, LSL #0
    MOVK  X7, #0xcf9d, LSL #16
    SUB  X26, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X7, #0x3f, LSL #0
    SUB  X26, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X7, #0x3350, LSL #0
    MOVK  X7, #0x8000, LSL #16
    SUB  X26, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X26, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X7, #0x3f, LSL #0
    SUB  X26, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X7, #0x20, LSL #0
    SUB  X26, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X7, #0x34f2, LSL #0
    MOVK  X7, #0x1980, LSL #16
    SUB  X26, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x40, LSL #16
    SUB  X26, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X7, #0x765a, LSL #0
    MOVK  X7, #0xff3e, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X26, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X7, #0x3fe1, LSL #0
    SUB  X26, X7, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X4, #0x5d0e, LSL #0
    MOVK  X4, #0xf7c2, LSL #16
    MOVK  X4, #0x86b1, LSL #32
    MOVK  X4, #0x16ec, LSL #48
    MOVZ  X5, #0x4acc, LSL #0
    MOVK  X5, #0xc246, LSL #16
    MOVK  X5, #0xea8a, LSL #32
    MOVK  X5, #0x8de9, LSL #48
    MOVZ  X6, #0xbce2, LSL #0
    MOVK  X6, #0xbf7, LSL #16
    MOVK  X6, #0xbeb7, LSL #32
    MOVK  X6, #0xda11, LSL #48
    MOVZ  X7, #0x2ccd, LSL #0
    MOVK  X7, #0x2499, LSL #16
    MOVK  X7, #0x4df3, LSL #32
    MOVK  X7, #0x9fe8, LSL #48
    MOVZ  X8, #0x917d, LSL #0
    MOVK  X8, #0x7ed3, LSL #16
    MOVK  X8, #0x1ea9, LSL #32
    MOVK  X8, #0x40e4, LSL #48
    MOVZ  X11, #0x7278, LSL #0
    MOVK  X11, #0x166b, LSL #16
    MOVK  X11, #0x9d4a, LSL #32
    MOVK  X11, #0x7245, LSL #48
    MOVZ  X12, #0xd217, LSL #0
    MOVK  X12, #0x6b2b, LSL #16
    MOVK  X12, #0x9552, LSL #32
    MOVK  X12, #0x1538, LSL #48
    MOVZ  X13, #0x3eb1, LSL #0
    MOVK  X13, #0x2c87, LSL #16
    MOVK  X13, #0xef10, LSL #32
    MOVK  X13, #0xbede, LSL #48
    MOVZ  X14, #0x894b, LSL #0
    MOVK  X14, #0xce7, LSL #16
    MOVK  X14, #0xb128, LSL #32
    MOVK  X14, #0x446d, LSL #48
    MOVZ  X15, #0x7f10, LSL #0
    MOVK  X15, #0x7f0c, LSL #16
    MOVK  X15, #0x8de6, LSL #32
    MOVK  X15, #0xf4e5, LSL #48
    MOVZ  X16, #0xfc56, LSL #0
    MOVK  X16, #0x6855, LSL #16
    MOVK  X16, #0x2e1e, LSL #32
    MOVK  X16, #0x29fd, LSL #48
    MOVZ  X17, #0xf0ea, LSL #0
    MOVK  X17, #0x6ec9, LSL #16
    MOVK  X17, #0x3b16, LSL #32
    MOVK  X17, #0x6b07, LSL #48
    MOVZ  X18, #0x9937, LSL #0
    MOVK  X18, #0xdd8c, LSL #16
    MOVK  X18, #0x4902, LSL #32
    MOVK  X18, #0x5db1, LSL #48
    MOVZ  X19, #0x948b, LSL #0
    MOVK  X19, #0x9951, LSL #16
    MOVK  X19, #0xf6a4, LSL #32
    MOVK  X19, #0x66a7, LSL #48
    MOVZ  X20, #0xcda, LSL #0
    MOVK  X20, #0x91fe, LSL #16
    MOVK  X20, #0x4e43, LSL #32
    MOVK  X20, #0x484d, LSL #48
    MOVZ  X21, #0xc09d, LSL #0
    MOVK  X21, #0x4eb, LSL #16
    MOVK  X21, #0xcaa, LSL #32
    MOVK  X21, #0xfdda, LSL #48
    MOVZ  X22, #0x6d38, LSL #0
    MOVK  X22, #0xb894, LSL #16
    MOVK  X22, #0x53ff, LSL #32
    MOVK  X22, #0xf8a0, LSL #48
    MOVZ  X23, #0xdbd1, LSL #0
    MOVK  X23, #0x74fd, LSL #16
    MOVK  X23, #0x3edd, LSL #32
    MOVK  X23, #0x95c9, LSL #48
    MOVZ  X24, #0xb3f9, LSL #0
    MOVK  X24, #0x77c3, LSL #16
    MOVK  X24, #0x11d9, LSL #32
    MOVK  X24, #0x6c3b, LSL #48
    MOVZ  X25, #0x3023, LSL #0
    MOVK  X25, #0x788f, LSL #16
    MOVK  X25, #0x4222, LSL #32
    MOVK  X25, #0xa77f, LSL #48
    MOVZ  X26, #0xc9b0, LSL #0
    MOVK  X26, #0x762a, LSL #16
    MOVK  X26, #0x71ab, LSL #32
    MOVK  X26, #0xf3c6, LSL #48
    MOVZ  X27, #0x5a4f, LSL #0
    MOVK  X27, #0x7c2c, LSL #16
    MOVK  X27, #0xd838, LSL #32
    MOVK  X27, #0x425f, LSL #48
    MOVZ  X28, #0xc7f4, LSL #0
    MOVK  X28, #0x349, LSL #16
    MOVK  X28, #0xffde, LSL #32
    MOVK  X28, #0xe648, LSL #48
    MOVZ  X29, #0x3e45, LSL #0
    MOVK  X29, #0xd061, LSL #16
    MOVK  X29, #0xe49a, LSL #32
    MOVK  X29, #0xa931, LSL #48
    MOVZ  X14, #0xf, LSL #0
TSRTIntAlu_label_9:
    UXTH  W25, W17
    ADDS  X19, X29, #0xd13, LSL #12
    CLS  W12, W19
    NGC  W23, W25
    RORV  X16, X14, X28
    AND  X5, X12, X12, ROR #23
    REV16  X11, X23
    NGC  W28, W16
    SXTH  X5, W27
    SUB  W22, W11, W5, SXTH #4
    SBC  X20, X28, X22
    UXTB  W11, W20
    AND  X25, X11, X11, ROR #44
    CSINC  W5, W25, W27, AL
    NGCS  W23, W5
    ASR  X19, X23, X23
    SXTW  X22, W19
    SXTH  X19, W22
    NEGS  X5, X19, LSL #9
    NGCS  W25, W8
    ADCS  X29, X16, X19
    MNEG  W27, W19, W21
    AND  W22, W29, W20, LSL #5
    MVN  X21, X12, ROR #22
    SBFX  W15, W7, #0xa, #17
    UBFX  W7, W12, #0xd, #1
    UMULL  X7, W6, W29
    SMULL  X13, W7, W5
    CSNEG  W25, W15, W22, GT
    BFI  W23, W16, #1, #9
    SUBS  X22, X8, W7, SXTW #1
    SMULL  X11, W23, W16
    NEGS  X16, X18, LSR #6
    NEGS  X28, X23, LSR #6
    BFXIL  X5, X19, #0x4, #45
    ADC  W19, W28, W13
    MADD  W6, W27, W27, W19
    CSNEG  W12, W27, W22, NV
    UBFM  X20, X21, #0x3, #0x14
    TST  W12, W25, LSL #7
    AND  W8, W20, W5, ASR #0
    NGC  W7, W8
    SXTW  X20, W6
    ADC  X21, X20, X18
    ROR  X25, X16, #0xa
    SBFIZ  X27, X25, #16, #30
    UBFIZ  X5, X27, #54, #3
    ROR  X12, X7, X7
    EOR  X19, X21, X21, LSR #9
    BIC  W21, W5, W12, ROR #24
    EOR  X13, X6, X21, ROR #6
    SMADDL  X18, W19, W11, X19
    SUBS  W22, W13, W13, ASR #29
    EOR  W29, W22, #0x1c001c
    RORV  W13, W29, W18
    AND  W8, W21, #0xffc0ffc0
    ANDS  W29, W12, #0xe000001f
    CSINC  X20, X19, X28, LE
    RORV  W19, W12, W28
    ADD  X16, X22, X25, ASR #35
    CSEL  X25, X27, X17, CC
    SUB  W6, W16, #0xcc9
    SMULH  X16, X12, X23
    SUBS  X27, X7, X8, LSR #38
    CLS  W5, W17
    REV32  X28, X13
    MUL  X8, X29, X5
    EOR  W18, W8, #0x3c
    UMADDL  X11, W18, W25, X25
    SDIV  X29, X27, X21
    EOR  W13, W20, W20, ROR #21
    SBFX  X27, X19, #0x1d, #33
    CSINV  W22, W6, W6, LE
    UBFM  W11, W28, #0x10, #0x13
    NEGS  W17, W16, ASR #13
    UXTB  W19, W27
    SXTH  X6, W29
    SBFX  X16, X17, #0x38, #6
    MUL  X8, X16, X19
    NGC  W16, W6
    SXTH  W7, W11
    SBFIZ  X20, X7, #54, #1
    RBIT  W11, W8
    ORR  W23, W22, #0xfffffc0f
    ADDS  X21, X23, #0x619, LSL #12
    BICS  X27, X15, X21, ASR #47
    SDIV  W5, W27, W16
    ANDS  W12, W7, #0xff3fff3f
    UMADDL  X23, W11, W20, X12
    NEGS  W11, W5, ASR #23
    SBFX  W12, W23, #0x8, #18
    ADC  W29, W12, W13
    SXTB  W6, W29
    NGC  W19, W6
    CSINC  W5, W19, W11, VS
    EXTR  W12, W27, W12, #0xb
    CSNEG  X23, X14, X17, LS
    MADD  W8, W11, W18, W5
    SUB  X27, X15, #0xb36, LSL #12
    ADD  W22, W5, W29, UXTH #0
    ADD  X13, X7, W24, SXTB #0
    UBFM  X17, X6, #0x4, #0x6
    CLZ  X6, X17
    SDIV  X24, X23, X11
    SMSUBL  X20, W12, W11, X11
    NEG  X23, X27, LSL #30
    UBFM  X12, X14, #0x0, #0x2d
    UBFM  W18, W27, #0x6, #0x5
    CLS  W27, W8
    ANDS  W19, W24, W27, LSL #20
    UDIV  W29, W20, W14
    BIC  W11, W27, W19, ROR #12
    BICS  W8, W11, W22, ASR #20
    UMULL  X21, W29, W13
    TST  W23, W8, ASR #29
    ADDS  X19, X18, W21, UXTH #1
    MNEG  X5, X6, X19
    BFXIL  X29, X12, #0x29, #4
    ASR  W6, W5, W5
    AND  X11, X6, X29, LSR #1
    REV32  X15, X29
    EON  W23, W27, W15, ASR #7
    ASR  W20, W25, #0xe
    ADDS  X21, X16, X20, ASR #16
    BFXIL  X5, X18, #0x18, #5
    CLS  X22, X12
    MVN  X17, X13, ROR #10
    CSEL  X18, X6, X18, PL
    NEG  X8, X11, ASR #12
    UMULL  X25, W5, W7
    BFXIL  W11, W8, #0x1b, #2
    ANDS  X29, X25, #0xdfdfdfdfdfdfdfdf
    BIC  X19, X17, X18, LSL #63
    MNEG  W17, W27, W27
    ADC  X16, X6, X12
    RORV  X7, X20, X7
    BICS  X15, X21, X7, ASR #29
    ADDS  X13, X29, #0x28a, LSL #12
    SMADDL  X21, W13, W17, X23
    ROR  X13, X25, #0x25
    UMULL  X25, W15, W11
    ASRV  X20, X13, X21
    RBIT  W7, W19
    ORR  X5, X25, #0xe007e007e007e007
    SUB  X8, X20, X5, SXTX #2
    NEGS  X21, X16, LSL #25
    MUL  X29, X7, X21
    SUBS  W21, W29, W8, SXTX #0
    CSINC  X18, X21, X21, LS
    REV16  W27, W22
    SUBS  X6, X27, X27, LSR #53
    SDIV  W12, W6, W6
    ADDS  X17, X12, X18, SXTX #4
    SUB  W7, W13, W17, UXTX #1
    SMNEGL  X27, W5, W28
    ADCS  W21, W25, W8
    ADDS  W13, W28, W20, LSR #24
    EOR  X29, X6, X27, LSL #18
    ADDS  X19, X27, W7, SXTB #4
    SMADDL  X12, W5, W20, X24
    ADD  X11, X24, X7, LSL #30
    MADD  X6, X22, X21, X14
    UMNEGL  X27, W13, W25
    MNEG  W16, W17, W14
    EOR  X23, X23, X21, LSL #36
    TST  X18, #0xc07fffffc07fffff
    MADD  W15, W25, W7, W25
    UXTB  W22, W15
    SBC  X15, X12, X29
    UBFX  X29, X11, #0x10, #29
    AND  X5, X15, #0x3ffffc00
    RORV  W11, W16, W19
    REV  X22, X6
    ADD  X12, X11, #0x227
    EXTR  W11, W12, W27, #0x1e
    CLZ  W24, W23
    SBCS  W8, W7, W29
    ORR  W28, W5, W5, LSL #18
    RORV  W21, W8, W28
    AND  X19, X24, #0x1fff00000000
    CLZ  X20, X21
    EXTR  W23, W20, W22, #0x1a
    BFI  W7, W11, #7, #16
    UXTB  W16, W7
    NGCS  X15, X16
    SBCS  X5, X15, X15
    ADDS  W7, W21, #0x49a, LSL #12
    MADD  X22, X19, X19, X7
    BIC  W19, W22, W22, ROR #16
    TST  X5, #0x7f80000
    SUBS  W15, W19, #0x60d
    NGCS  W28, W23
    UBFIZ  X20, X28, #18, #26
    CSINC  W24, W15, W15, GT
    BFXIL  X22, X24, #0x1a, #17
    ORR  W18, W20, W22, LSL #30
    ADDS  X21, X6, X6, SXTX #0
    MNEG  X16, X20, X24
    BFI  X20, X8, #15, #3
    SBCS  X28, X22, X24
    SUBS  X14, X14, #0x1
    B.NE  TSRTIntAlu_label_9
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X26, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X4, #0xfa6f, LSL #0
    MOVK  X4, #0xc8de, LSL #16
    MOVK  X4, #0x22, LSL #32
    SUB  X26, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X4, #0x1d1d, LSL #0
    MOVK  X4, #0x1512, LSL #16
    SUB  X26, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X4, #0x7d1d, LSL #0
    MOVK  X4, #0x14c8, LSL #16
    SUB  X26, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X4, #0x2d8, LSL #0
    MOVK  X4, #0x6820, LSL #16
    SUB  X26, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X4, #0xb6, LSL #0
    MOVK  X4, #0xda08, LSL #16
    SUB  X26, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X4, #0xd0f, LSL #0
    MOVK  X4, #0x1cfc, LSL #16
    SUB  X26, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X4, #0x200, LSL #0
    MOVK  X4, #0x2, LSL #16
    SUB  X26, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x6320, LSL #16
    MOVK  X4, #0x3686, LSL #32
    MOVK  X4, #0xdfe0, LSL #48
    SUB  X26, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X4, #0x171, LSL #0
    MOVK  X4, #0x25f8, LSL #16
    MOVK  X4, #0x7, LSL #32
    SUB  X26, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xdce0, LSL #16
    SUB  X26, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X4, #0x80d, LSL #0
    MOVK  X4, #0x2, LSL #16
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X4, #0x8000, LSL #0
    MOVK  X4, #0xdce2, LSL #16
    MOVK  X4, #0xfff, LSL #32
    SUB  X26, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X4, #0xf4de, LSL #0
    MOVK  X4, #0x91bd, LSL #16
    MOVK  X4, #0x45, LSL #32
    SUB  X26, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x1512, LSL #16
    SUB  X26, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X4, #0x8c8, LSL #0
    SUB  X26, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X4, #0x201, LSL #0
    MOVK  X4, #0x2, LSL #16
    SUB  X26, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X4, #0xfdfe, LSL #0
    MOVK  X4, #0x150f, LSL #16
    SUB  X26, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X4, #0x8000, LSL #0
    MOVK  X4, #0x1f47, LSL #16
    SUB  X26, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntAlu_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
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
    MOVZ  X24, #0xf, LSL #0
TSRTIntAlu_label_10:
    ANDS  W13, W21, W28, ROR #31
    SUB  W16, W11, #0x0
    AND  W6, W23, #0x7fe000
    NEGS  X13, X6, ASR #11
    ADD  W12, W16, #0x6d9
    SMNEGL  X26, W25, W24
    RBIT  X7, X7
    MVN  W4, W19, ASR #15
    EOR  X13, X20, #0x5555555555555555
    UDIV  X15, X23, X12
    EON  X26, X22, X26, LSL #9
    BFM  W6, W7, #0x3, #0x19
    ADDS  W20, W26, #0xf1
    AND  X17, X20, X17, LSR #61
    CSNEG  X21, X4, X18, NE
    SBFM  X6, X27, #0x3d, #0x22
    CLS  X20, X6
    REV  X22, X17
    SMSUBL  X12, W21, W21, X20
    CSNEG  X25, X12, X15, GE
    AND  X11, X13, X13, ROR #39
    ASR  W23, W22, #0xf
    CLS  X6, X23
    REV16  W7, W25
    SDIV  W26, W17, W7
    SUB  X27, X26, X6, LSL #42
    NGC  X16, X27
    BFM  W27, W16, #0x19, #0x1f
    CSNEG  X6, X27, X27, LT
    ORR  X13, X6, #0x1e00000000000000
    SXTH  X18, W11
    UMNEGL  X19, W13, W13
    ADDS  W25, W18, W18, SXTH #4
    SMULH  X23, X19, X19
    SBCS  X4, X23, X25
    ASR  X25, X21, #0x19
    SMULL  X26, W23, W22
    NEGS  W19, W11, LSR #10
    SUB  X16, X12, X21, LSR #62
    ANDS  W15, W4, #0x1fffffc
    ANDS  W20, W20, #0x7ffffffe
    SBFX  W6, W26, #0xd, #12
    TST  W7, #0xbbbbbbbb
    ADDS  W11, W18, #0x976, LSL #12
    UMADDL  X18, W6, W5, X18
    ASR  X7, X18, X5
    SBFX  X13, X26, #0x2d, #2
    BFXIL  X6, X8, #0x19, #3
    BFI  X12, X25, #4, #13
    CLZ  X26, X6
    CLS  W5, W12
    MNEG  X25, X15, X11
    SDIV  W11, W11, W25
    EOR  W4, W16, W26, ROR #1
    ANDS  X25, X7, X13, ROR #61
    NEGS  W22, W5, LSR #12
    SMADDL  X5, W11, W19, X20
    SXTB  W26, W5
    SDIV  X12, X22, X26
    RORV  W5, W25, W4
    NEGS  X16, X5, LSR #62
    ADDS  W6, W13, W16, SXTB #0
    ROR  W11, W6, W6
    ROR  W6, W11, W12
    TST  W7, #0xff83ff83
    MSUB  X13, X23, X13, X4
    BICS  W25, W24, W4, LSR #4
    NEGS  W19, W23, LSL #29
    BFI  W18, W11, #2, #12
    CSINV  W22, W15, W25, MI
    UXTB  W7, W11
    MSUB  W11, W25, W26, W21
    SUB  W8, W4, W24, LSL #31
    SMULL  X15, W8, W8
    SMNEGL  X4, W12, W7
    SUBS  W23, W26, W18, LSL #16
    CLS  X21, X20
    ADC  X25, X13, X21
    UDIV  X26, X4, X23
    SUBS  X16, X6, X25, UXTX #0
    SBFM  W23, W16, #0xc, #0x2
    BFM  W21, W26, #0x6, #0x1b
    ANDS  X13, X19, #0xc0000000c00000
    MVN  X17, X13, LSL #9
    TST  X22, X17, ASR #37
    EON  X22, X21, X15, ASR #9
    ASR  W20, W11, #0xf
    CSINC  W11, W23, W23, CC
    NEG  X5, X22, ASR #58
    EON  W18, W5, W5, LSL #14
    NEG  W8, W20, LSL #9
    NEGS  X6, X4, LSR #25
    UDIV  W25, W18, W11
    SUB  X19, X8, #0x78b, LSL #12
    EOR  X8, X19, #0x2222222222222222
    TST  X25, X6, LSR #28
    SXTW  X11, W15
    ANDS  W15, W11, #0x1e001e
    ORR  X4, X17, X25, ROR #10
    AND  X6, X26, #0xffe0000000000003
    UMULH  X21, X5, X23
    SBFX  W20, W8, #0x2, #20
    RBIT  W17, W20
    AND  X26, X21, X15, ASR #55
    ORN  W5, W5, W23, ASR #30
    ROR  W22, W4, W15
    AND  W21, W16, #0xf800001f
    ADDS  W19, W28, W4, UXTH #3
    SUBS  W16, W16, W6, UXTH #1
    MADD  X11, X7, X5, X6
    UMADDL  X18, W24, W4, X19
    ADDS  W4, W18, W17, SXTB #4
    BIC  X25, X8, X23, LSL #8
    UBFIZ  W15, W16, #18, #13
    EXTR  W27, W26, W17, #0x1a
    AND  W5, W16, #0xf8007fff
    MNEG  W8, W20, W11
    ADD  X28, X26, X22, ASR #8
    ADDS  W6, W22, #0x370
    MVN  X20, X4, LSL #60
    AND  W18, W20, W28, LSR #25
    CLZ  W17, W5
    NEGS  X11, X21, LSR #3
    ROR  X25, X11, #0x22
    ROR  W19, W6, W6
    SDIV  W4, W8, W19
    SBC  W21, W25, W27
    ORR  X16, X15, #0xfffe03fffffe03ff
    SXTB  X23, W16
    SUB  W20, W17, W18, LSL #16
    UBFIZ  X22, X20, #31, #27
    RORV  W28, W22, W21
    REV32  X7, X28
    ADCS  X27, X4, X7
    ROR  W7, W27, #0x3
    ADDS  W11, W7, #0x101
    AND  W25, W23, #0x3ff80
    EXTR  X26, X25, X11, #0x3f
    MUL  W20, W6, W25
    TST  W6, #0x9fff9fff
    SUBS  X11, X19, W19, UXTB #1
    REV  W5, W6
    NGCS  X15, X28
    MADD  X19, X28, X11, X17
    ADDS  W17, W27, #0x57d, LSL #12
    REV32  X6, X24
    NEG  X25, X25, ASR #55
    ORR  X28, X16, #0xffffff000000
    ORN  W16, W18, W6, LSR #18
    CSNEG  W21, W12, W26, NV
    EXTR  X7, X16, X17, #0x3c
    CSINC  W8, W25, W20, HI
    TST  W8, #0xbfffbfff
    BFXIL  X11, X5, #0xe, #34
    ASR  X22, X19, X28
    MSUB  X27, X21, X11, X22
    ASRV  X11, X27, X5
    UXTB  W5, W15
    SBFX  X15, X7, #0xc, #41
    AND  W23, W11, W11, LSR #18
    MVN  X22, X23, LSR #53
    ORN  W8, W15, W5, LSL #29
    TST  X8, #0xffffffff0000000
    ADD  X6, X17, #0x835
    UBFIZ  W20, W13, #5, #6
    SUB  X28, X5, W23, SXTW #4
    ADDS  W27, W12, W28, ASR #17
    NEG  W11, W22, LSR #20
    SBFX  X7, X12, #0x9, #15
    ORN  W23, W17, W26, LSR #3
    MSUB  X22, X21, X5, X23
    AND  X8, X23, X16, LSR #10
    SBFX  W16, W8, #0x17, #1
    SXTB  X13, W26
    ORN  W26, W21, W7, ASR #17
    SMADDL  X17, W16, W23, X20
    EON  X8, X25, X27, ROR #39
    CSEL  W15, W22, W26, NV
    CSNEG  W19, W19, W19, LS
    EXTR  X22, X7, X23, #0x13
    UXTH  W12, W11
    SBCS  W7, W12, W16
    SUB  X5, X23, #0x819, LSL #12
    REV16  X16, X13
    SUBS  W23, W8, W17, SXTH #0
    ORN  X20, X23, X15, LSR #48
    BFXIL  X4, X5, #0x3, #36
    TST  W19, W6, LSL #10
    SUB  W26, W7, W28, UXTB #4
    SBCS  X17, X22, X22
    MADD  W5, W24, W8, W22
    RBIT  X15, X5
    SXTW  X7, W15
    AND  X8, X4, X4, ROR #29
    ORN  X22, X16, X17, ROR #49
    BFM  W21, W8, #0x1, #0xf
    CLS  X19, X20
    SXTH  W20, W22
    UMSUBL  X6, W21, W5, X20
    NGC  X28, X26
    SUBS  X24, X24, #0x1
    B.NE  TSRTIntAlu_label_10
    MOVZ  X14, #0xc803, LSL #0
    MOVK  X14, #0x1fef, LSL #16
    SUB  X29, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntAlu_TestFail
    MOVZ  X14, #0x1ffe, LSL #0
    SUB  X29, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntAlu_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntAlu_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntAlu_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntAlu_TestFail
    MOVZ  X14, #0xf001, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X29, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntAlu_TestFail
    MOVZ  X14, #0xf001, LSL #0
    SUB  X29, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntAlu_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntAlu_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x7ff8, LSL #48
    SUB  X29, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntAlu_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntAlu_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X29, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntAlu_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntAlu_TestFail
    MOVZ  X14, #0x3f, LSL #0
    SUB  X29, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntAlu_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntAlu_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntAlu_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntAlu_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X29, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntAlu_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntAlu_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntAlu_TestFail
    MOVZ  X14, #0xf000, LSL #0
    SUB  X29, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntAlu_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntAlu_TestFail
    MOVZ  X14, #0xfff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X29, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntAlu_TestFail
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
    MOVZ  X23, #0xf, LSL #0
TSRTIntAlu_label_11:
    ROR  W16, W29, W25
    TST  X27, #0xcfffcfffcfffcfff
    ASR  X4, X28, #0x2d
    SUB  W6, W16, #0xdab
    BICS  W7, W4, W24, LSR #5
    ORN  X14, X23, X6, ASR #8
    CSINC  X25, X7, X26, LT
    ADD  X12, X14, W25, SXTB #4
    TST  W25, W24, LSR #23
    SMULH  X16, X19, X4
    MNEG  W17, W25, W12
    BIC  W22, W20, W23, LSL #17
    SBFM  X4, X12, #0x16, #0x38
    UMSUBL  X25, W14, W22, X11
    SDIV  X12, X23, X11
    TST  W27, W6, LSL #2
    UDIV  X29, X13, X22
    EON  W5, W16, W23, LSR #6
    ROR  X4, X28, #0x1c
    ORN  X14, X27, X5, ROR #27
    BFI  W25, W11, #5, #9
    ANDS  X4, X16, X17, LSL #59
    MSUB  W28, W4, W6, W12
    REV16  X26, X22
    AND  X27, X11, #0x1111111111111111
    ASR  W5, W7, #0x0
    NEGS  X13, X18, LSR #54
    UBFIZ  W19, W28, #17, #4
    SUBS  X29, X26, W19, UXTW #2
    RBIT  W22, W18
    REV32  X7, X17
    EXTR  W28, W24, W4, #0x19
    SBFIZ  W28, W22, #15, #14
    BICS  X4, X14, X5, ASR #60
    NEG  X16, X4, ASR #48
    BFM  X11, X16, #0x14, #0x3e
    RORV  W12, W25, W11
    UMNEGL  X16, W28, W27
    UMNEGL  X22, W4, W16
    BIC  X18, X22, X7, LSR #60
    UMSUBL  X28, W12, W13, X8
    UMSUBL  X14, W28, W18, X28
    BIC  X4, X14, X14, LSR #40
    ADD  W11, W4, W29, UXTH #3
    MADD  X19, X20, X13, X17
    CSINV  W25, W6, W12, LE
    BFI  X17, X13, #43, #4
    BFI  W27, W17, #20, #1
    SBCS  X16, X17, X28
    EOR  W17, W5, W28, LSL #29
    UBFX  W29, W16, #0x3, #5
    ASRV  W26, W26, W12
    UBFM  X7, X24, #0x22, #0x2d
    CSEL  X8, X20, X11, NE
    BFM  W22, W5, #0x8, #0x4
    CLZ  X28, X27
    ADDS  W24, W29, W8, ASR #5
    ASRV  W16, W26, W19
    UBFM  X11, X25, #0x37, #0x16
    CLZ  W18, W27
    ADDS  W20, W7, #0x508, LSL #12
    ASR  X14, X20, X17
    SBCS  W6, W22, W14
    NEGS  W19, W28, LSL #25
    REV32  X13, X16
    SXTB  X7, W24
    UMULL  X24, W7, W11
    ASRV  W14, W18, W6
    SBFM  X25, X11, #0xa, #0x7
    SBC  W18, W13, W25
    SUB  X22, X19, X19, LSR #45
    BICS  X11, X24, X22, ROR #62
    UBFM  W27, W13, #0x14, #0xd
    SUB  W12, W27, W14, LSL #5
    SMULH  X14, X18, X12
    EON  W25, W11, W11, ROR #22
    RBIT  X26, X25
    NGC  X13, X11
    SUBS  W19, W14, W14, ASR #28
    ADD  W6, W26, #0xfa0
    ORN  W12, W6, W19, LSL #28
    EOR  W7, W13, W12, LSL #17
    SUBS  W27, W19, W26, UXTB #2
    ANDS  X14, X11, X17, LSL #17
    UBFIZ  X25, X11, #16, #12
    MSUB  X20, X18, X22, X22
    REV16  X13, X29
    ANDS  W18, W14, W16, LSL #26
    ADDS  W24, W7, W27, SXTH #2
    SUB  W26, W27, W6, ASR #21
    NGCS  W17, W23
    SUBS  X12, X6, X7, ASR #5
    UBFIZ  X7, X5, #6, #47
    BFM  W22, W7, #0x1e, #0x5
    SUB  X5, X17, X20, UXTX #2
    EOR  X19, X13, X25, ASR #49
    UXTH  W11, W24
    REV32  X27, X18
    EON  X6, X22, X12, ASR #34
    CLZ  W19, W26
    CSNEG  W16, W11, W11, PL
    SMADDL  X12, W23, W16, X5
    ADD  X14, X12, #0xbcf, LSL #12
    EON  X5, X20, X14, ROR #5
    ADDS  W29, W5, W19, ASR #8
    SUB  X7, X6, #0x330, LSL #12
    ASR  X14, X27, X27
    ADDS  W26, W7, W29, UXTH #1
    ORN  W11, W14, W14, LSR #9
    ADD  X18, X6, X26, LSL #51
    REV16  X16, X18
    ADCS  W26, W20, W27
    EOR  W29, W20, #0x55555555
    RORV  W5, W16, W29
    CSINC  W7, W26, W25, VC
    NGCS  W13, W7
    SXTH  X24, W13
    CSNEG  X22, X11, X24, MI
    BIC  X24, X5, X5, LSR #42
    EOR  W26, W24, W22, LSL #9
    UMSUBL  X6, W25, W16, X11
    SUB  X22, X23, #0x43a, LSL #12
    EXTR  X13, X6, X28, #0x24
    BFM  X5, X4, #0x5, #0x1e
    RORV  X19, X29, X7
    REV  W27, W29
    SBFX  W20, W11, #0x4, #1
    BICS  W18, W25, W11, ASR #4
    SUBS  W14, W23, W11, LSR #5
    TST  X13, #0xfff000ffffffffff
    SUBS  X6, X19, W22, SXTH #4
    ROR  W29, W27, W5
    ADDS  X28, X18, W29, SXTB #3
    SXTB  X5, W20
    ADC  W29, W28, W14
    NEG  X28, X17, LSL #2
    BIC  W24, W26, W28, ASR #15
    SUB  X4, X6, X6, LSL #56
    SMNEGL  X7, W5, W18
    ORN  W17, W29, W29, LSL #28
    NGCS  W19, W17
    MADD  X16, X19, X19, X24
    SDIV  X17, X4, X4
    SMSUBL  X4, W7, W16, X17
    SXTH  W22, W28
    BFI  X14, X8, #18, #2
    ASRV  W28, W28, W28
    EOR  X27, X28, #0xc0ffc0ffc0ffc0ff
    ADCS  W25, W12, W26
    SBCS  W12, W12, W7
    ORR  W26, W17, W6, ASR #15
    BFXIL  X16, X4, #0x20, #16
    ADDS  W20, W28, W24, SXTX #3
    SUB  X19, X20, X22, LSL #2
    SXTH  X24, W4
    ADD  X4, X4, #0xcf, LSL #12
    MSUB  W29, W25, W12, W4
    NGC  W5, W19
    MVN  W28, W5, ROR #29
    MUL  X4, X14, X28
    ASR  X28, X16, #0x36
    EOR  X12, X27, X4, ROR #30
    BIC  W18, W28, W12, LSL #30
    CLS  X6, X18
    ROR  X27, X24, X26
    CSEL  X12, X7, X27, LT
    NEGS  W17, W6, LSL #18
    UMULL  X26, W12, W29
    SBC  W27, W26, W17
    UMULH  X16, X11, X26
    ORN  W12, W25, W22, LSR #26
    UBFX  X19, X19, #0x38, #3
    REV16  W20, W13
    ADCS  W26, W29, W16
    ADD  W8, W22, W5, LSL #18
    SDIV  W17, W20, W24
    SUB  W7, W23, W5, UXTB #4
    ORR  X25, X8, X20, LSL #54
    SMADDL  X4, W4, W4, X7
    BIC  X28, X23, X7, ASR #57
    SUBS  W6, W19, #0x0
    CSINV  X14, X29, X8, CC
    SXTB  W16, W27
    BFXIL  X11, X12, #0xe, #32
    ADDS  W24, W6, W26, LSR #31
    RBIT  X7, X28
    ADD  W6, W7, W12, LSL #18
    CSNEG  X8, X17, X24, LT
    ASR  X13, X8, #0xe
    MNEG  X27, X25, X25
    SMSUBL  X26, W6, W16, X14
    MNEG  X28, X11, X4
    SUB  X29, X28, X13, UXTX #0
    AND  X5, X29, #0x1000000000
    NGCS  W14, W27
    SUB  X11, X5, #0x51b
    SBFIZ  W13, W11, #26, #3
    CLS  X17, X26
    SUB  W6, W17, W14, SXTW #4
    MSUB  X26, X13, X19, X13
    SUBS  X23, X23, #0x1
    B.NE  TSRTIntAlu_label_11
    MOVZ  X15, #0x36b5, LSL #0
    MOVK  X15, #0xdef4, LSL #16
    MOVK  X15, #0x2fe8, LSL #32
    MOVK  X15, #0x240, LSL #48
    SUB  X21, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x10, LSL #32
    SUB  X21, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X15, #0xfc31, LSL #0
    MOVK  X15, #0x23ff, LSL #16
    SUB  X21, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #48
    SUB  X21, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X21, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X15, #0xfae5, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xf, LSL #32
    SUB  X21, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X21, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xf400, LSL #16
    SUB  X21, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X15, #0x3f, LSL #0
    MOVK  X15, #0xfdc0, LSL #16
    SUB  X21, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X21, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X15, #0x21, LSL #0
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xf0, LSL #16
    SUB  X21, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X15, #0x8, LSL #0
    SUB  X21, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X15, #0x1, LSL #0
    SUB  X21, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X15, #0x8, LSL #0
    MOVK  X15, #0x3fdc, LSL #16
    SUB  X21, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xf400, LSL #16
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X15, #0xffc0, LSL #0
    MOVK  X15, #0x23f, LSL #16
    MOVK  X15, #0xfaec, LSL #32
    MOVK  X15, #0xf011, LSL #48
    SUB  X21, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X15, #0x36b5, LSL #0
    MOVK  X15, #0x420, LSL #16
    MOVK  X15, #0xb418, LSL #32
    MOVK  X15, #0x429c, LSL #48
    SUB  X21, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X15, #0x36b6, LSL #0
    MOVK  X15, #0x420, LSL #16
    MOVK  X15, #0xb418, LSL #32
    MOVK  X15, #0x429c, LSL #48
    SUB  X21, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X4, #0x9beb, LSL #0
    MOVK  X4, #0x5161, LSL #16
    MOVK  X4, #0xab1d, LSL #32
    MOVK  X4, #0x54f9, LSL #48
    MOVZ  X5, #0x6a25, LSL #0
    MOVK  X5, #0x6d, LSL #16
    MOVK  X5, #0xaa85, LSL #32
    MOVK  X5, #0x2f74, LSL #48
    MOVZ  X6, #0x9063, LSL #0
    MOVK  X6, #0x15a, LSL #16
    MOVK  X6, #0xc797, LSL #32
    MOVK  X6, #0x3f67, LSL #48
    MOVZ  X7, #0xf6dc, LSL #0
    MOVK  X7, #0xfdeb, LSL #16
    MOVK  X7, #0xd944, LSL #32
    MOVK  X7, #0x526f, LSL #48
    MOVZ  X8, #0x3cc3, LSL #0
    MOVK  X8, #0x203a, LSL #16
    MOVK  X8, #0x1ebd, LSL #32
    MOVK  X8, #0x910d, LSL #48
    MOVZ  X11, #0xa07e, LSL #0
    MOVK  X11, #0x26eb, LSL #16
    MOVK  X11, #0x70b1, LSL #32
    MOVK  X11, #0xd15f, LSL #48
    MOVZ  X12, #0xd7b1, LSL #0
    MOVK  X12, #0x88e9, LSL #16
    MOVK  X12, #0x6cb6, LSL #32
    MOVK  X12, #0x5095, LSL #48
    MOVZ  X13, #0xe1b4, LSL #0
    MOVK  X13, #0x9776, LSL #16
    MOVK  X13, #0x729c, LSL #32
    MOVK  X13, #0x6bb, LSL #48
    MOVZ  X14, #0xe043, LSL #0
    MOVK  X14, #0x8b1e, LSL #16
    MOVK  X14, #0x9422, LSL #32
    MOVK  X14, #0x6139, LSL #48
    MOVZ  X15, #0x63d3, LSL #0
    MOVK  X15, #0xaf5e, LSL #16
    MOVK  X15, #0xaf6f, LSL #32
    MOVK  X15, #0x5bb0, LSL #48
    MOVZ  X16, #0x38cf, LSL #0
    MOVK  X16, #0xf80d, LSL #16
    MOVK  X16, #0xed0e, LSL #32
    MOVK  X16, #0xfb80, LSL #48
    MOVZ  X17, #0xa5ca, LSL #0
    MOVK  X17, #0x50da, LSL #16
    MOVK  X17, #0x6a0b, LSL #32
    MOVK  X17, #0xa325, LSL #48
    MOVZ  X18, #0xd6bd, LSL #0
    MOVK  X18, #0xf20c, LSL #16
    MOVK  X18, #0xfa43, LSL #32
    MOVK  X18, #0x1224, LSL #48
    MOVZ  X19, #0x8bcb, LSL #0
    MOVK  X19, #0xb741, LSL #16
    MOVK  X19, #0x6d98, LSL #32
    MOVK  X19, #0xcbbf, LSL #48
    MOVZ  X20, #0x5796, LSL #0
    MOVK  X20, #0xcec0, LSL #16
    MOVK  X20, #0xbd89, LSL #32
    MOVK  X20, #0x3235, LSL #48
    MOVZ  X21, #0x6b10, LSL #0
    MOVK  X21, #0x72e0, LSL #16
    MOVK  X21, #0xe160, LSL #32
    MOVK  X21, #0x4eaf, LSL #48
    MOVZ  X22, #0x8062, LSL #0
    MOVK  X22, #0xffad, LSL #16
    MOVK  X22, #0x9af7, LSL #32
    MOVK  X22, #0xeb79, LSL #48
    MOVZ  X23, #0x5080, LSL #0
    MOVK  X23, #0xccc4, LSL #16
    MOVK  X23, #0xa9a7, LSL #32
    MOVK  X23, #0x1ed1, LSL #48
    MOVZ  X24, #0xe691, LSL #0
    MOVK  X24, #0xf1a3, LSL #16
    MOVK  X24, #0x92f, LSL #32
    MOVK  X24, #0xb1f1, LSL #48
    MOVZ  X25, #0x2c9, LSL #0
    MOVK  X25, #0x3ce2, LSL #16
    MOVK  X25, #0x41ea, LSL #32
    MOVK  X25, #0xf9b4, LSL #48
    MOVZ  X26, #0x3795, LSL #0
    MOVK  X26, #0xe9a9, LSL #16
    MOVK  X26, #0x9a3c, LSL #32
    MOVK  X26, #0x8f2c, LSL #48
    MOVZ  X27, #0x3bc2, LSL #0
    MOVK  X27, #0x1a9e, LSL #16
    MOVK  X27, #0x9184, LSL #32
    MOVK  X27, #0xcc13, LSL #48
    MOVZ  X28, #0x7043, LSL #0
    MOVK  X28, #0x562a, LSL #16
    MOVK  X28, #0xe30f, LSL #32
    MOVK  X28, #0xbd0e, LSL #48
    MOVZ  X29, #0x191a, LSL #0
    MOVK  X29, #0x7d6, LSL #16
    MOVK  X29, #0xc7f1, LSL #32
    MOVK  X29, #0x3f8c, LSL #48
    MOVZ  X28, #0xf, LSL #0
TSRTIntAlu_label_12:
    REV16  W27, W27
    MVN  X8, X25, LSL #4
    EON  X21, X29, X27, LSL #46
    ASR  X12, X28, X28
    MVN  W11, W21, LSR #26
    ORR  X6, X12, X26, ASR #48
    MVN  X20, X11, ASR #13
    SXTH  W18, W20
    UBFX  X18, X6, #0xe, #22
    REV16  W20, W26
    SUB  W20, W20, #0x18d
    UMSUBL  X16, W8, W8, X8
    SBFX  W13, W20, #0x15, #8
    ANDS  W14, W18, #0x60006000
    UXTB  W25, W16
    UMADDL  X16, W25, W13, X13
    REV16  W21, W16
    ASR  W11, W14, W14
    BICS  W21, W21, W11, ROR #3
    UBFIZ  X4, X7, #5, #31
    RORV  X26, X15, X17
    SDIV  X25, X7, X27
    SUB  W16, W15, #0xa92, LSL #12
    ROR  W6, W8, W15
    BICS  X20, X18, X15, LSL #19
    BFI  W12, W18, #4, #15
    BFXIL  X18, X8, #0x27, #7
    AND  W8, W15, W6, LSR #9
    SUB  X13, X8, X16, SXTX #2
    SBFM  W27, W13, #0x1b, #0x2
    MSUB  W13, W25, W18, W25
    SBC  X7, X25, X28
    EOR  X17, X26, X13, ROR #37
    EOR  X15, X7, #0x1ffffffc0000
    UBFIZ  W14, W21, #12, #14
    SDIV  X18, X6, X25
    SUB  X6, X18, W12, SXTB #2
    CSNEG  W18, W27, W27, NE
    ADDS  W8, W4, W15, ASR #29
    EON  W12, W17, W17, ASR #14
    SUBS  W16, W14, #0xb0b
    MSUB  X13, X6, X6, X18
    ORR  W11, W20, #0x20202020
    ADD  X27, X16, X11, UXTX #4
    AND  W25, W13, W8, ROR #26
    ASR  X11, X12, X12
    RORV  X6, X25, X11
    UMNEGL  X17, W27, W27
    SDIV  X7, X22, X26
    UBFM  W21, W6, #0xe, #0x13
    REV16  X26, X26
    ADDS  W25, W26, #0x5ff
    NEGS  X4, X25, LSL #44
    ADD  W15, W17, W17, ASR #17
    NEG  X16, X7, LSR #39
    ROR  W14, W21, #0x13
    CSNEG  X21, X4, X14, MI
    EOR  W17, W15, #0x83ff83ff
    RORV  X18, X17, X21
    ADD  W12, W7, W18, ASR #4
    RORV  W25, W12, W12
    ROR  X24, X25, X16
    ASR  X8, X19, #0x1d
    UMADDL  X13, W20, W17, X28
    ADD  W17, W26, W16, LSL #11
    ADD  W20, W20, #0x7d9, LSL #12
    MSUB  X14, X29, X28, X17
    MUL  W17, W4, W6
    NEG  W15, W17, LSR #8
    ANDS  X18, X22, #0x8007ffffffffffff
    CSEL  W7, W15, W29, VC
    EOR  W19, W8, W27, LSR #28
    BFXIL  W6, W12, #0x10, #6
    BIC  W26, W6, W28, LSR #19
    ADDS  W21, W14, #0x665
    SUB  X8, X20, X18, LSR #37
    ADD  X14, X6, X12, ASR #22
    NGCS  X7, X28
    ADCS  X15, X12, X17
    TST  X13, #0xffff00000000000f
    BFI  X20, X19, #14, #43
    SBC  W6, W7, W26
    ANDS  W19, W6, W6, ASR #6
    ORR  W25, W14, W20, ROR #0
    ASR  X6, X15, #0x38
    SMADDL  X15, W21, W24, X19
    ADC  W16, W6, W8
    BICS  X26, X25, X16, ASR #15
    RORV  X4, X26, X26
    BFM  X24, X15, #0x2d, #0x30
    SXTH  X22, W4
    BFI  W7, W22, #11, #5
    SBC  W6, W24, W24
    SUB  X29, X7, X6, LSR #59
    ANDS  X19, X24, X6, LSR #37
    SXTB  X18, W18
    ORR  X21, X14, X17, LSR #59
    CLZ  X13, X25
    BFXIL  X22, X16, #0x2f, #7
    SBFX  X6, X8, #0x21, #6
    ROR  X14, X8, #0x32
    SBFM  X8, X20, #0x18, #0x1b
    RBIT  W20, W13
    AND  W13, W21, #0xfefefefe
    ADD  X24, X13, #0x24e
    SUBS  W12, W24, #0xe13
    UMULH  X26, X22, X18
    SUB  X4, X6, #0x853
    UMULL  X25, W4, W29
    MADD  X22, X26, X19, X19
    SBFIZ  W21, W22, #20, #7
    SUB  W16, W14, #0x3dc, LSL #12
    NEGS  W17, W25, LSL #9
    SBCS  X13, X17, X28
    SBFX  X17, X8, #0x35, #2
    BFM  W6, W13, #0x15, #0xa
    NEGS  W26, W16, LSR #21
    RORV  X24, X26, X25
    AND  X4, X20, X21, LSR #34
    ROR  X29, X12, #0x25
    SBC  X7, X24, X17
    UDIV  X20, X7, X29
    SBFM  X14, X20, #0x2c, #0x2
    TST  W4, W6, LSR #14
    ADC  X4, X18, X20
    EOR  W19, W8, #0xe7e7e7e7
    UMULL  X27, W20, W12
    SBCS  W12, W17, W14
    CSINC  W21, W24, W20, GE
    TST  W8, #0xffe007ff
    UMULL  X26, W7, W4
    SMADDL  X13, W11, W15, X26
    ADC  X17, X19, X27
    MSUB  X18, X17, X7, X8
    SUBS  X25, X12, #0x19d, LSL #12
    BFI  X12, X28, #63, #1
    MVN  W22, W29, LSL #23
    UDIV  X20, X29, X12
    MSUB  X14, X21, X8, X17
    NEG  X21, X18, LSR #29
    CSNEG  W29, W13, W11, GT
    REV16  W16, W19
    SMSUBL  X13, W17, W13, X29
    ORN  X17, X8, X26, ASR #20
    CLZ  W12, W28
    TST  W13, W26, ROR #9
    MADD  X15, X27, X14, X26
    AND  X19, X21, #0x7ffffffffe00000
    NEG  X7, X25, LSR #16
    SDIV  W11, W18, W21
    SXTW  X4, W22
    MADD  W29, W20, W12, W16
    CLZ  X24, X29
    ORR  X29, X24, #0xffffffffc0007fff
    SUB  W12, W4, W15, SXTH #4
    CSEL  W22, W7, W19, VC
    MVN  W16, W11, ROR #19
    MNEG  W26, W12, W16
    REV32  X12, X17
    ORR  X18, X29, X12, LSR #5
    SXTW  X16, W22
    UXTH  W14, W16
    SBCS  W4, W21, W27
    SBFIZ  W7, W22, #28, #4
    RORV  W20, W4, W4
    UXTH  W19, W20
    RORV  W8, W7, W26
    UMADDL  X25, W19, W18, X18
    MUL  W24, W25, W8
    BFI  W22, W24, #15, #2
    BFXIL  X15, X22, #0x27, #7
    ADDS  X24, X15, #0x462, LSL #12
    TST  X24, #0xfffffff000000001
    BIC  W24, W12, W12, LSR #3
    SUB  X17, X15, W6, UXTW #0
    UXTH  W25, W11
    REV16  W12, W13
    UBFIZ  X8, X20, #25, #14
    SMULH  X18, X26, X16
    ADDS  W27, W4, W20, LSR #10
    CLS  X6, X8
    MADD  X15, X26, X28, X28
    MNEG  X7, X24, X15
    SMULL  X16, W27, W7
    NEG  X11, X6, LSR #40
    UDIV  W27, W18, W11
    MVN  X4, X14, LSL #45
    ADDS  X22, X16, W27, SXTH #4
    REV  W18, W4
    ORR  W15, W18, W22, LSL #11
    MADD  W13, W12, W12, W17
    EOR  W4, W13, #0xc007c007
    ANDS  W14, W15, W25, LSR #12
    UBFX  X15, X14, #0x38, #5
    REV  X18, X8
    ADD  W17, W4, W18, ASR #28
    UBFM  W18, W15, #0x17, #0x1f
    TST  W17, W18, ROR #24
    ORR  W27, W17, W25, LSL #29
    SBFM  X14, X24, #0x1, #0x33
    SUBS  X28, X28, #0x1
    B.NE  TSRTIntAlu_label_12
    MOVZ  X5, #0xd007, LSL #0
    MOVK  X5, #0x3fe7, LSL #16
    SUB  X23, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X5, #0x19, LSL #0
    SUB  X23, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x2000, LSL #48
    SUB  X23, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x1a00, LSL #16
    MOVK  X5, #0x34, LSL #32
    SUB  X23, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X5, #0x1000, LSL #0
    MOVK  X5, #0xffe0, LSL #16
    SUB  X23, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7000, LSL #16
    SUB  X23, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X5, #0xd00a, LSL #0
    MOVK  X5, #0x3fe7, LSL #16
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X5, #0xda0d, LSL #0
    SUB  X23, X5, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X5, #0xda0d, LSL #0
    MOVK  X5, #0x8d8e, LSL #16
    SUB  X23, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X5, #0x63b7, LSL #0
    MOVK  X5, #0x8363, LSL #16
    MOVK  X5, #0xfffa, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X23, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xe000, LSL #16
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    SUB  X23, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X5, #0xd00a, LSL #0
    MOVK  X5, #0x3fe7, LSL #16
    SUB  X23, X5, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X5, #0x7fff, LSL #0
    MOVK  X5, #0xc000, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X23, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
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
    MOVZ  X29, #0xf, LSL #0
TSRTIntAlu_label_13:
    ASR  W5, W14, W27
    REV16  X25, X29
    ROR  W23, W17, #0x4
    RBIT  W6, W21
    SMULL  X5, W26, W22
    MVN  W11, W25, ROR #26
    EOR  X11, X23, #0x4444444444444444
    SMULH  X17, X5, X24
    UBFX  W14, W28, #0x17, #3
    SMULL  X15, W14, W14
    MADD  W23, W11, W17, W15
    CSEL  X18, X6, X6, EQ
    MNEG  X22, X23, X18
    MVN  W6, W22, ASR #16
    SMADDL  X22, W6, W6, X6
    CSINV  X28, X22, X16, HI
    ADCS  W24, W28, W28
    SUBS  X6, X24, X24, UXTX #4
    RORV  W27, W6, W6
    UBFIZ  W14, W27, #15, #6
    SXTH  X22, W14
    ADDS  W5, W22, W22, LSL #12
    SUBS  X25, X29, #0x3
    ASRV  W15, W5, W27
    UXTH  W26, W26
    EOR  W11, W4, #0x200000
    MNEG  W5, W18, W24
    REV16  X14, X16
    MUL  X23, X15, X17
    UDIV  W6, W11, W6
    AND  W28, W13, #0x8f8f8f8f
    ROR  W22, W22, W5
    ORN  X26, X16, X17, LSL #30
    AND  W17, W21, #0x7800
    ANDS  X18, X21, #0x10000000100000
    NEGS  W21, W28, ASR #13
    SBFX  W15, W22, #0x1, #20
    RORV  W4, W26, W17
    SUB  W28, W4, W14, LSR #6
    ROR  W4, W23, #0x1a
    TST  X18, #0xc0000001c0000001
    ADDS  W13, W15, #0xe04
    NEG  X11, X4, ASR #48
    CSINC  X15, X6, X11, LT
    CLS  W11, W21
    NGC  X22, X15
    NEG  W5, W13, LSR #18
    ADDS  W16, W25, W25, LSL #24
    SMSUBL  X23, W11, W16, X22
    EOR  W17, W8, W23, ROR #25
    CSINV  W24, W26, W28, LS
    MUL  W23, W24, W17
    BFXIL  W8, W5, #0x4, #21
    SMSUBL  X27, W8, W23, X8
    BFXIL  W16, W24, #0x13, #7
    REV16  X14, X29
    UDIV  W28, W18, W25
    SBFX  X21, X8, #0x39, #3
    SUBS  W8, W24, W20, LSL #10
    RBIT  W17, W28
    SXTW  X22, W25
    BICS  W11, W20, W22, LSR #26
    SBC  X26, X15, X27
    ANDS  W22, W25, W25, ROR #29
    NEG  X25, X21, LSL #23
    ADD  W23, W5, #0xe68
    SBCS  W24, W29, W20
    MNEG  W18, W17, W16
    ASRV  W28, W22, W22
    SBCS  X5, X26, X18
    ADDS  X22, X28, #0x58
    RORV  W20, W24, W8
    UXTH  W28, W14
    ASRV  W15, W25, W23
    EON  W8, W15, W22, LSL #24
    SBFX  W22, W11, #0x17, #1
    RORV  W23, W5, W28
    BIC  X27, X20, X8, ASR #14
    BFXIL  X24, X27, #0x39, #2
    BICS  W15, W23, W24, ROR #3
    SBFIZ  X24, X15, #48, #10
    UDIV  X25, X24, X22
    UMSUBL  X21, W12, W17, X12
    AND  W15, W22, #0x11111111
    CSEL  X16, X22, X16, GT
    UDIV  X14, X13, X4
    REV16  X27, X22
    SBFIZ  X23, X16, #44, #13
    ORR  W28, W21, W27, LSR #6
    UDIV  W26, W28, W13
    MVN  W5, W11, LSR #18
    CLS  W12, W4
    BFXIL  W18, W6, #0x1e, #2
    UDIV  W8, W16, W20
    UMADDL  X13, W23, W5, X25
    ADD  X22, X18, X15, UXTX #4
    ASRV  W27, W26, W26
    CSINV  X26, X27, X14, GT
    SBCS  X4, X8, X13
    CSNEG  W21, W4, W12, CS
    SBFX  X12, X26, #0x23, #3
    ROR  X14, X22, X22
    ROR  X5, X16, X12
    SUB  X27, X5, X5, LSR #26
    SUBS  W25, W27, W27, LSR #24
    UXTH  W22, W21
    BFI  X6, X22, #21, #35
    TST  X14, #0x1ffffffffc0
    ASR  X28, X25, X25
    RORV  W27, W28, W6
    ADD  W15, W22, #0xe22
    SBFX  X5, X26, #0x1d, #27
    CLS  X11, X18
    CLS  X14, X29
    ADD  X26, X23, #0xab7, LSL #12
    NGCS  W23, W8
    SUB  W18, W23, W4, LSR #31
    CSEL  W21, W21, W23, HI
    NGCS  X4, X6
    EOR  X8, X18, #0x3ffe000
    ADD  X12, X8, X5, LSR #27
    SUBS  X16, X26, X12, LSR #3
    CLS  X25, X15
    SUBS  X26, X21, X14, ASR #51
    ORN  X23, X27, X4, LSL #16
    UMULH  X4, X25, X16
    ASR  W16, W26, #0x7
    SUBS  X8, X16, X4, UXTX #0
    EOR  W13, W8, W8, LSR #1
    MNEG  X21, X13, X11
    UBFM  W22, W21, #0x15, #0x15
    NEG  X12, X12, LSL #5
    SDIV  X6, X26, X15
    UBFM  W18, W23, #0xe, #0xb
    SBFIZ  X21, X27, #46, #7
    SXTH  X6, W12
    SMSUBL  X11, W6, W11, X22
    NEG  W15, W18, LSL #21
    ORR  W14, W15, W16, LSR #3
    EXTR  W15, W11, W11, #0x16
    MUL  W26, W21, W15
    UBFX  W18, W26, #0x1a, #1
    ORN  X5, X14, X14, LSR #30
    TST  W18, W5, ASR #19
    NEGS  X4, X12, LSR #5
    ADCS  X6, X25, X11
    SXTB  W15, W16
    MSUB  X8, X14, X29, X13
    CLZ  X27, X21
    ORR  W23, W4, #0x70000000
    SBFIZ  W25, W26, #19, #3
    SUBS  W16, W15, W21, LSL #20
    ORR  W11, W6, W27, ASR #25
    MSUB  X6, X17, X24, X15
    BFI  X26, X5, #43, #21
    SMSUBL  X5, W16, W23, X16
    SUBS  W14, W27, #0x10
    SUB  W18, W14, W13, SXTX #4
    SXTB  W23, W18
    TST  X8, #0x3f8000003f800000
    SUBS  W20, W5, #0x2be, LSL #12
    ADCS  X17, X21, X23
    ADC  X5, X8, X27
    CSNEG  W24, W18, W21, PL
    REV  W4, W5
    ROR  W14, W22, #0xa
    ADD  X13, X25, X14, UXTX #3
    SBFX  X14, X6, #0x3, #6
    SBFIZ  W15, W20, #5, #3
    BICS  W20, W26, W11, LSR #20
    NGC  X16, X13
    ASR  X6, X22, X17
    ROR  X23, X6, #0x25
    ORN  W28, W14, W20, ROR #7
    ADD  W21, W4, W15, ASR #13
    ROR  X18, X24, #0x2a
    CSINC  X26, X28, X16, NE
    CSINC  W8, W23, W23, PL
    CSINV  W25, W26, W21, LE
    SUB  X26, X4, X18, ASR #18
    AND  W23, W26, W26, LSR #29
    MVN  X21, X21, LSR #19
    UBFM  W20, W8, #0xc, #0x10
    TST  W23, #0x1ff
    CLZ  X11, X20
    ADCS  X8, X25, X21
    RBIT  X5, X11
    SBC  X28, X5, X8
    NGC  W23, W13
    ORN  W27, W4, W5, LSR #31
    SBC  X11, X4, X29
    ADC  X28, X27, X25
    UBFIZ  W18, W24, #8, #22
    TST  X17, #0xffffe00000ffffff
    BFXIL  W17, W13, #0x10, #3
    EXTR  X24, X5, X18, #0x2d
    ASRV  X27, X5, X4
    UXTB  W25, W16
    ORR  W18, W23, W18, LSR #16
    REV16  X26, X16
    SUBS  X29, X29, #0x1
    B.NE  TSRTIntAlu_label_13
    MOVZ  X7, #0x60, LSL #0
    MOVK  X7, #0x7c00, LSL #16
    SUB  X19, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x200, LSL #48
    SUB  X19, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X19, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X7, #0xf07f, LSL #0
    MOVK  X7, #0xfdff, LSL #16
    SUB  X19, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X7, #0x5f, LSL #0
    MOVK  X7, #0x7c00, LSL #16
    SUB  X19, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X7, #0x40, LSL #0
    MOVK  X7, #0x7ffc, LSL #16
    MOVK  X7, #0xffe0, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X19, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x200, LSL #16
    SUB  X19, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X19, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X7, #0xffa0, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X19, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xfdff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X19, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X7, #0xff80, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X19, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X7, #0x3ffc, LSL #0
    MOVK  X7, #0xfe00, LSL #16
    SUB  X19, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X19, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X7, #0xf07f, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X19, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X7, #0x1, LSL #0
    SUB  X19, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xfe00, LSL #16
    SUB  X19, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X19, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X7, #0xff, LSL #0
    SUB  X19, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xfffd, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X19, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x200, LSL #16
    SUB  X19, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xfe00, LSL #16
    MOVK  X7, #0x1, LSL #32
    SUB  X19, X7, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X19, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
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
    MOVZ  X21, #0xf, LSL #0
TSRTIntAlu_label_14:
    EOR  X14, X26, #0xff000007ffffffff
    UXTH  W11, W21
    ROR  X23, X27, #0x31
    CSEL  X16, X29, X28, CC
    CLZ  W26, W23
    UXTB  W4, W16
    SUBS  X20, X14, X4, UXTX #2
    UMULL  X7, W26, W20
    CSINV  X28, X7, X11, LS
    BFXIL  X29, X28, #0x38, #3
    ROR  W17, W29, #0x0
    NGCS  X8, X17
    UBFX  X7, X8, #0x0, #21
    SBC  X26, X7, X7
    REV  X20, X26
    ADDS  W17, W14, #0x293
    TST  W8, W29, ASR #2
    REV  X26, X11
    SBC  W25, W15, W17
    UBFIZ  W23, W14, #7, #14
    MNEG  X22, X17, X23
    ADC  W18, W25, W8
    SXTW  X26, W25
    CSEL  W11, W7, W11, GT
    REV  X27, X20
    SMULH  X24, X12, X7
    CSINV  X4, X5, X8, HI
    REV32  X17, X28
    MVN  W24, W21, ASR #26
    SXTW  X8, W20
    EXTR  W20, W22, W22, #0x1f
    NGC  X28, X8
    MNEG  X22, X20, X20
    TST  X28, X22, LSR #29
    UXTB  W12, W11
    BIC  W23, W24, W4, ASR #31
    REV16  X8, X12
    ADDS  W29, W17, W17, LSL #15
    CSINV  W24, W23, W23, GE
    NGC  X7, X26
    REV16  W22, W27
    CLZ  X26, X22
    ROR  W14, W29, W26
    SXTH  W11, W14
    ROR  W28, W11, W8
    ORR  W23, W28, W28, ASR #22
    CSINC  W25, W23, W24, GE
    ASR  W15, W7, #0x13
    ROR  W14, W15, W25
    BFM  X26, X14, #0x22, #0x13
    TST  X26, #0xfff000fffff000ff
    MUL  W8, W6, W22
    ADD  W15, W22, W15, UXTW #4
    SUB  W29, W20, W11, LSR #27
    SXTH  W12, W27
    SBFM  X24, X8, #0x24, #0x27
    CSINV  W20, W24, W16, EQ
    NEGS  X4, X25, ASR #44
    BIC  X25, X16, X22, ASR #0
    TST  W28, W28, ROR #22
    SXTH  X6, W18
    UMADDL  X26, W7, W12, X18
    ADDS  X18, X20, W12, UXTB #3
    ROR  W20, W6, W24
    ORN  X28, X24, X15, LSL #62
    UBFX  W22, W4, #0x0, #28
    CSNEG  W27, W7, W28, AL
    NEGS  X15, X18, LSR #12
    ADD  X6, X7, W4, UXTH #3
    NEG  W14, W27, ASR #13
    SUB  X18, X15, X11, ASR #22
    EXTR  W11, W24, W15, #0x10
    NEG  W16, W28
    BICS  W23, W22, W29, ROR #11
    NGCS  W15, W18
    NGC  W24, W26
    CSINC  W7, W25, W6, NV
    ADCS  X8, X20, X7
    MVN  X12, X24, LSR #43
    CLZ  W24, W14
    CSNEG  W25, W15, W6, VS
    ADD  W14, W16, #0xdb9, LSL #12
    MUL  W20, W25, W23
    SBCS  W15, W15, W14
    UXTB  W7, W24
    SBFX  X4, X8, #0x23, #11
    ADD  X26, X20, X4, LSR #15
    ADD  W29, W11, #0x1ea, LSL #12
    MSUB  X24, X12, X12, X12
    BFXIL  W6, W7, #0x6, #22
    EOR  W11, W24, W26, LSL #10
    ASR  X27, X12, #0x35
    ADDS  W7, W15, W29, ASR #30
    SBFM  X14, X7, #0x1a, #0x10
    SDIV  X26, X14, X14
    BFM  W4, W26, #0x1a, #0x15
    REV16  W7, W27
    ADD  X12, X4, #0x365
    RORV  W4, W12, W11
    SMNEGL  X12, W4, W7
    REV  W22, W12
    ROR  X18, X6, X22
    UBFX  X25, X18, #0x1e, #16
    EXTR  W29, W7, W15, #0xf
    AND  X11, X5, #0xff800000ff8000
    CSEL  W20, W22, W11, LT
    SDIV  W26, W4, W25
    MADD  X4, X12, X4, X15
    SXTB  W14, W25
    SUB  X16, X8, #0x169, LSL #12
    TST  W12, #0xfffff9ff
    ROR  X15, X21, X4
    ASR  X8, X7, X8
    RBIT  X25, X5
    CSINV  W27, W12, W12, NE
    BFM  X7, X14, #0xc, #0xa
    SXTW  X5, W29
    CSNEG  W29, W7, W20, HI
    EON  W20, W26, W8, LSL #16
    CSEL  W26, W20, W27, LE
    SUBS  X8, X22, #0xc94
    REV  X4, X16
    UBFX  X6, X5, #0xa, #36
    RORV  X27, X15, X4
    CSINV  W20, W27, W29, EQ
    ANDS  W4, W20, W20, LSR #17
    MNEG  X29, X4, X25
    SXTH  W25, W8
    ASR  W8, W22, #0x0
    NGC  W27, W29
    MNEG  W7, W8, W26
    SBFM  W20, W7, #0x1, #0x4
    REV  X7, X20
    CLZ  W16, W11
    CLZ  X4, X7
    ANDS  W15, W16, W4, ASR #28
    BFXIL  W16, W15, #0x14, #11
    SXTW  X20, W27
    SBFX  W26, W16, #0xa, #7
    ROR  W7, W20, #0x13
    MVN  W8, W25, ASR #26
    ROR  W14, W8, W25
    SMULH  X5, X26, X14
    NGC  W22, W6
    SBFX  X25, X22, #0x6, #3
    SUBS  W20, W7, #0xf89, LSL #12
    UDIV  W7, W25, W20
    CSEL  X22, X5, X7, NV
    ANDS  X20, X28, X15, ROR #60
    ADDS  X8, X12, #0x81d
    ADDS  X7, X15, X17, SXTX #2
    SBFX  W4, W18, #0x19, #6
    MVN  X16, X26, LSL #18
    ROR  X14, X26, X17
    UMADDL  X17, W8, W14, X6
    UDIV  X29, X17, X6
    SBFM  W27, W5, #0x18, #0xb
    TST  X28, #0xfe000ffffe000fff
    ASRV  W26, W7, W29
    EOR  X5, X24, #0xffffe00000000001
    ADD  W25, W16, W12, ASR #24
    ADDS  X15, X5, X29, SXTX #4
    CSNEG  X6, X28, X17, GE
    RBIT  X18, X12
    SMULH  X12, X4, X4
    SBC  X24, X5, X27
    SUBS  X7, X26, X20, LSR #22
    UBFIZ  W16, W24, #29, #3
    ASR  X8, X25, X22
    CSINC  X14, X7, X12, MI
    SBCS  X17, X16, X20
    ADC  X28, X27, X17
    SUB  W25, W6, #0x83e, LSL #12
    ADD  X5, X18, X8, ASR #48
    SUB  W4, W14, W5, LSL #15
    SBC  X17, X28, X28
    ANDS  W29, W5, #0x70007000
    UBFX  X22, X15, #0x36, #2
    NGCS  X14, X4
    EON  X4, X14, X29, LSR #52
    SXTH  W22, W4
    AND  X15, X22, #0xc7c7c7c7c7c7c7c7
    ASR  W18, W25, #0x1d
    BFI  X8, X15, #39, #4
    RBIT  X4, X27
    SBFX  X24, X8, #0xe, #7
    SXTH  W5, W17
    ADDS  W25, W18, #0x8f9
    ROR  X29, X25, #0x1a
    MNEG  X27, X5, X4
    BICS  W5, W29, W24, LSR #17
    MSUB  W25, W27, W5, W27
    MUL  W18, W23, W6
    ASR  X28, X18, X27
    SMULH  X14, X7, X17
    ASR  X4, X11, #0x38
    SUB  W16, W29, #0x85c, LSL #12
    CSINV  X15, X29, X26, PL
    ORR  X26, X4, #0xffe00007ffffffff
    RBIT  X12, X21
    SUBS  X21, X21, #0x1
    B.NE  TSRTIntAlu_label_14
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0x3fff, LSL #48
    SUB  X19, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X13, #0xfffe, LSL #0
    MOVK  X13, #0xfdff, LSL #16
    SUB  X19, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0x80, LSL #32
    SUB  X19, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8000, LSL #48
    SUB  X19, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x3e00, LSL #32
    MOVK  X13, #0x2, LSL #48
    SUB  X19, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X13, #0x4000, LSL #0
    MOVK  X13, #0xff7a, LSL #16
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X13, #0x1, LSL #0
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X19, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0x7, LSL #32
    MOVK  X13, #0xffe0, LSL #48
    SUB  X19, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x3e00, LSL #32
    MOVK  X13, #0x2, LSL #48
    SUB  X19, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntAlu_TestFail
    MOVZ  X4, #0x8593, LSL #0
    MOVK  X4, #0x266e, LSL #16
    MOVK  X4, #0x184b, LSL #32
    MOVK  X4, #0xbb91, LSL #48
    MOVZ  X5, #0x56fd, LSL #0
    MOVK  X5, #0xb003, LSL #16
    MOVK  X5, #0xa86, LSL #32
    MOVK  X5, #0xa28e, LSL #48
    MOVZ  X6, #0xf947, LSL #0
    MOVK  X6, #0xd27a, LSL #16
    MOVK  X6, #0x4f20, LSL #32
    MOVK  X6, #0x9532, LSL #48
    MOVZ  X7, #0xf4f9, LSL #0
    MOVK  X7, #0x703b, LSL #16
    MOVK  X7, #0x498b, LSL #32
    MOVK  X7, #0xb20b, LSL #48
    MOVZ  X8, #0xbeb, LSL #0
    MOVK  X8, #0xafcb, LSL #16
    MOVK  X8, #0xc6e8, LSL #32
    MOVK  X8, #0xa764, LSL #48
    MOVZ  X11, #0xcf1c, LSL #0
    MOVK  X11, #0xaadb, LSL #16
    MOVK  X11, #0x7939, LSL #32
    MOVK  X11, #0x64a2, LSL #48
    MOVZ  X12, #0xb354, LSL #0
    MOVK  X12, #0x6ea3, LSL #16
    MOVK  X12, #0xbfb1, LSL #32
    MOVK  X12, #0x8286, LSL #48
    MOVZ  X13, #0x7b2b, LSL #0
    MOVK  X13, #0x588b, LSL #16
    MOVK  X13, #0x69fc, LSL #32
    MOVK  X13, #0x8973, LSL #48
    MOVZ  X14, #0x48da, LSL #0
    MOVK  X14, #0xe2a, LSL #16
    MOVK  X14, #0x8478, LSL #32
    MOVK  X14, #0x6dfd, LSL #48
    MOVZ  X15, #0x4d6e, LSL #0
    MOVK  X15, #0x67a9, LSL #16
    MOVK  X15, #0x3bf1, LSL #32
    MOVK  X15, #0x281, LSL #48
    MOVZ  X16, #0x2ab, LSL #0
    MOVK  X16, #0x9f63, LSL #16
    MOVK  X16, #0xbdf, LSL #32
    MOVK  X16, #0x5bd1, LSL #48
    MOVZ  X17, #0xf688, LSL #0
    MOVK  X17, #0x935e, LSL #16
    MOVK  X17, #0x212a, LSL #32
    MOVK  X17, #0xb83f, LSL #48
    MOVZ  X18, #0x91f6, LSL #0
    MOVK  X18, #0x2a4b, LSL #16
    MOVK  X18, #0xdef5, LSL #32
    MOVK  X18, #0x3b34, LSL #48
    MOVZ  X19, #0x14b, LSL #0
    MOVK  X19, #0x84be, LSL #16
    MOVK  X19, #0x79bb, LSL #32
    MOVK  X19, #0x7193, LSL #48
    MOVZ  X20, #0x54b, LSL #0
    MOVK  X20, #0xeb80, LSL #16
    MOVK  X20, #0x9143, LSL #32
    MOVK  X20, #0xc409, LSL #48
    MOVZ  X21, #0xc60e, LSL #0
    MOVK  X21, #0xf975, LSL #16
    MOVK  X21, #0x87f6, LSL #32
    MOVK  X21, #0x543e, LSL #48
    MOVZ  X22, #0x69d5, LSL #0
    MOVK  X22, #0xf9ce, LSL #16
    MOVK  X22, #0xc043, LSL #32
    MOVK  X22, #0x47f8, LSL #48
    MOVZ  X23, #0x3416, LSL #0
    MOVK  X23, #0x9f97, LSL #16
    MOVK  X23, #0xfe30, LSL #32
    MOVK  X23, #0x6cd5, LSL #48
    MOVZ  X24, #0xc818, LSL #0
    MOVK  X24, #0xf6d, LSL #16
    MOVK  X24, #0xf50a, LSL #32
    MOVK  X24, #0x997, LSL #48
    MOVZ  X25, #0xd42e, LSL #0
    MOVK  X25, #0x6e30, LSL #16
    MOVK  X25, #0xfe83, LSL #32
    MOVK  X25, #0x5113, LSL #48
    MOVZ  X26, #0xcd6f, LSL #0
    MOVK  X26, #0x91f6, LSL #16
    MOVK  X26, #0x3f7b, LSL #32
    MOVK  X26, #0x67dc, LSL #48
    MOVZ  X27, #0xcb5a, LSL #0
    MOVK  X27, #0xf0e8, LSL #16
    MOVK  X27, #0xa329, LSL #32
    MOVK  X27, #0x4312, LSL #48
    MOVZ  X28, #0xe1ea, LSL #0
    MOVK  X28, #0x1b67, LSL #16
    MOVK  X28, #0xde6c, LSL #32
    MOVK  X28, #0xc5bd, LSL #48
    MOVZ  X29, #0x61f2, LSL #0
    MOVK  X29, #0x7250, LSL #16
    MOVK  X29, #0x478c, LSL #32
    MOVK  X29, #0xfa9a, LSL #48
    MOVZ  X5, #0xf, LSL #0
TSRTIntAlu_label_15:
    TST  W27, #0xfff0000
    CSEL  X27, X28, X26, CC
    UBFX  W13, W27, #0x11, #5
    SXTB  W11, W5
    ASR  W24, W29, W29
    ANDS  W8, W24, #0x40000000
    CSNEG  W15, W8, W8, CC
    ADDS  X24, X15, W13, UXTH #2
    REV32  X16, X11
    MADD  X17, X8, X5, X13
    ADD  W20, W16, W17, UXTH #1
    SBC  W12, W24, W20
    ROR  X28, X12, #0x2d
    NEG  W11, W28, LSR #25
    EOR  W28, W11, W11, LSR #9
    AND  W12, W20, #0x81818181
    SUBS  X6, X20, W7, SXTB #1
    CSNEG  W16, W11, W24, EQ
    SBFIZ  X13, X11, #4, #4
    EOR  W20, W14, #0x7ff87ff8
    MNEG  W14, W27, W5
    AND  X12, X5, #0x1f0000001f000000
    ADC  X18, X24, X17
    ORR  W26, W26, W14, ASR #19
    SUB  X14, X13, X26, LSL #39
    EXTR  W14, W14, W16, #0x10
    TST  X25, #0xfc0003fffc0003ff
    SUBS  X17, X19, X6, LSR #43
    ASR  X25, X18, X17
    ANDS  X11, X6, X12, ASR #20
    CSINC  X18, X13, X24, HI
    SBCS  X26, X24, X25
    MUL  W19, W23, W20
    SXTH  W23, W19
    REV32  X16, X14
    ADD  X19, X11, #0xb80
    ASR  W25, W28, #0x13
    BFXIL  W27, W29, #0x16, #2
    UXTH  W7, W18
    ADD  W24, W25, #0x211
    SXTW  X14, W7
    CSEL  X28, X11, X21, GE
    RBIT  X17, X14
    BFI  W14, W7, #2, #20
    SBC  W29, W17, W19
    ANDS  X7, X8, #0xfff07fffffffffff
    AND  W6, W29, #0xc1ffc1ff
    REV16  W20, W6
    ADD  X8, X20, W24, UXTH #2
    SMSUBL  X12, W23, W8, X23
    REV32  X19, X6
    ROR  X13, X16, #0x39
    BFM  X23, X13, #0x35, #0x33
    CLZ  X14, X23
    BFI  W23, W28, #18, #11
    SDIV  X25, X12, X23
    EOR  W16, W7, #0xfffdfffd
    ROR  X21, X16, #0x38
    ANDS  X20, X19, #0x7ffc000000000
    SUB  W17, W25, W20, SXTH #1
    EOR  X23, X21, #0xc007ffffc007ffff
    ADDS  W6, W14, W23, SXTH #4
    SUBS  W20, W6, W6, SXTH #0
    UBFM  X8, X20, #0x31, #0xf
    BFXIL  X13, X17, #0x1a, #36
    RBIT  W28, W13
    UBFM  X21, X8, #0x17, #0x3d
    MNEG  W18, W28, W21
    ANDS  X12, X27, #0xe000e000e000e000
    CSNEG  W27, W18, W18, CS
    BFM  X18, X12, #0x31, #0x1b
    ADD  W17, W18, W18, LSL #3
    AND  X8, X27, #0xf07ff07ff07ff07f
    SUB  W24, W17, #0xac4
    MVN  X7, X8, ROR #30
    ADDS  W28, W5, #0x4aa
    REV32  X19, X7
    AND  W18, W24, W24, LSR #25
    CSNEG  X23, X28, X19, HI
    ADDS  X12, X18, #0x506
    RBIT  W16, W12
    NGC  W8, W23
    BFI  X7, X16, #53, #7
    ROR  X14, X8, #0x19
    REV16  X29, X14
    ROR  W21, W7, W7
    SBFIZ  W7, W21, #12, #7
    CSINV  W24, W7, W29, CC
    NGC  X7, X21
    REV16  X6, X24
    REV16  W21, W8
    CSINC  W14, W27, W26, LS
    BFM  X23, X12, #0x6, #0x23
    ADDS  X16, X28, #0xd33
    UXTB  W29, W29
    REV  W21, W5
    ASR  X19, X11, #0x1e
    ASRV  X8, X29, X29
    EOR  W18, W5, W19, ROR #29
    ASR  X29, X18, #0x1d
    ADDS  X18, X27, #0x78b
    UMULL  X27, W21, W7
    SUBS  W21, W6, W27, ASR #8
    CSINC  W19, W14, W23, EQ
    UMNEGL  X12, W8, W16
    EOR  W11, W12, W12, LSL #23
    ASR  W28, W21, W11
    TST  X28, #0xffe07fffffe07fff
    REV16  W24, W18
    SBFX  W23, W29, #0x7, #18
    ADD  W16, W24, W24, UXTX #2
    REV16  W23, W23
    ADD  X26, X19, #0x3bd
    CSINV  X7, X23, X26, LT
    UXTB  W18, W7
    BIC  W14, W18, W18, ASR #15
    ADDS  W7, W14, #0xd02
    SXTB  W6, W7
    UXTH  W23, W16
    SXTH  W28, W6
    BFM  W12, W23, #0x0, #0x6
    UMULL  X8, W28, W28
    ORN  W29, W8, W12, ROR #15
    NEG  X27, X5, LSL #56
    SDIV  X28, X14, X12
    SMULL  X11, W7, W12
    ADDS  X16, X7, X26, ASR #45
    SBC  X18, X23, X19
    UBFIZ  W14, W17, #24, #6
    ROR  X8, X16, X16
    ADDS  X26, X5, X19, LSR #40
    ADC  X6, X28, X16
    EXTR  W23, W11, W6, #0x6
    ADCS  W6, W23, W28
    REV  W12, W23
    UMULH  X7, X8, X23
    ANDS  X19, X15, #0xffffffc7ffffffc7
    SUB  W8, W6, W18, ASR #20
    SMNEGL  X6, W27, W6
    SUBS  W24, W26, W12, LSL #10
    SXTW  X17, W24
    UXTB  W26, W14
    ADD  X23, X29, #0x2fa, LSL #12
    SMULH  X8, X7, X23
    SBC  W28, W17, W26
    RBIT  W25, W28
    SUB  X16, X8, X25, ASR #26
    UMADDL  X28, W16, W15, X19
    NGC  W27, W6
    MSUB  X14, X7, X27, X28
    ADD  X11, X11, X27, ASR #60
    RBIT  W27, W19
    UBFIZ  W25, W20, #15, #17
    ASRV  W23, W17, W25
    ANDS  W29, W16, W17, ASR #8
    ASR  W24, W5, W18
    TST  X14, X13, ROR #12
    UXTH  W19, W14
    SUBS  X6, X21, W23, UXTB #2
    SDIV  X13, X5, X15
    EON  X20, X18, X6, LSR #41
    REV  W12, W7
    SBFX  W28, W13, #0xf, #7
    EOR  X13, X11, X14, ASR #43
    ADDS  X6, X5, W28, SXTB #3
    MVN  X26, X19, LSL #15
    ADDS  W6, W5, W15, UXTB #1
    SUBS  W7, W17, W15, SXTB #2
    ANDS  X21, X7, X24, LSR #43
    UMULH  X24, X20, X21
    EOR  X28, X27, #0xf1f1f1f1f1f1f1f1
    UBFIZ  X16, X13, #3, #14
    CSNEG  W7, W29, W12, LE
    UXTB  W23, W6
    SBFIZ  W17, W23, #31, #1
    EXTR  X6, X5, X6, #0x32
    SXTH  X15, W26
    SXTH  W14, W24
    CSEL  X19, X6, X14, MI
    SUB  X11, X19, #0x0
    SMNEGL  X20, W16, W11
    ADDS  W21, W28, W17, ASR #8
    ORN  X25, X15, X7, LSR #43
    RBIT  W23, W25
    SUB  W24, W7, #0x9ba
    ASR  W12, W24, #0x6
    UXTB  W27, W20
    ADCS  W29, W12, W27
    NEG  X7, X29, LSL #24
    ADC  W26, W12, W6
    MNEG  W28, W26, W7
    SDIV  W25, W23, W15
    SBFIZ  X24, X25, #36, #1
    CSINC  W15, W28, W24, EQ
    CSINC  W17, W15, W21, GE
    ADC  X13, X14, X19
    SXTB  X23, W25
    NGCS  W11, W5
    ADD  X20, X21, X12, LSL #16
    SMNEGL  X21, W23, W19
    SUBS  X5, X5, #0x1
    B.NE  TSRTIntAlu_label_15
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTIntAlu_TestFail
    MOVZ  X4, #0x4000, LSL #0
    SUB  X22, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTIntAlu_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x2600, LSL #16
    MOVK  X4, #0xff00, LSL #48
    SUB  X22, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTIntAlu_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTIntAlu_TestFail
    MOVZ  X4, #0xfffe, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X22, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTIntAlu_TestFail
    MOVZ  X4, #0xffd9, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTIntAlu_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTIntAlu_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTIntAlu_TestFail
    MOVZ  X4, #0x1, LSL #0
    SUB  X22, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTIntAlu_TestFail
    MOVZ  X4, #0x6a50, LSL #0
    SUB  X22, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTIntAlu_TestFail
    MOVZ  X4, #0xf1f4, LSL #0
    MOVK  X4, #0xf171, LSL #16
    SUB  X22, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTIntAlu_TestFail
    MOVZ  X4, #0xb70c, LSL #0
    SUB  X22, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTIntAlu_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTIntAlu_TestFail
    MOVZ  X4, #0xf1f3, LSL #0
    MOVK  X4, #0xf14a, LSL #16
    MOVK  X4, #0x1, LSL #48
    SUB  X22, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTIntAlu_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTIntAlu_TestFail
    MOVZ  X4, #0x1, LSL #0
    SUB  X22, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTIntAlu_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xfff0, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X22, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTIntAlu_TestFail
    MOVZ  X4, #0x1, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTIntAlu_TestFail
    MOVZ  X4, #0x3fd9, LSL #0
    SUB  X22, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTIntAlu_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTIntAlu_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xca00, LSL #16
    SUB  X22, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTIntAlu_TestFail
    MOVZ  X4, #0xffda, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X22, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTIntAlu_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
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
    MOVZ  X4, #0xf, LSL #0
TSRTIntAlu_label_16:
    NEG  X26, X4, LSR #30
    NGCS  X22, X29
    RBIT  X12, X16
    ADD  X12, X21, #0x9d2, LSL #12
    ANDS  W7, W12, #0x1f001f
    ADCS  X29, X23, X22
    BICS  X5, X7, X17, ASR #52
    EXTR  W12, W24, W29, #0x8
    ADDS  X26, X19, W28, SXTB #1
    BIC  X14, X15, X15, LSL #9
    UBFX  X17, X5, #0x21, #5
    CSEL  W29, W13, W26, GE
    ANDS  W17, W20, W20, ASR #30
    ADDS  W24, W17, #0xcbb, LSL #12
    SBCS  X17, X5, X28
    CLZ  X26, X29
    TST  W12, #0xf0f0f0f
    RORV  X17, X17, X24
    BIC  W24, W17, W27, LSL #3
    BIC  X15, X24, X26, ROR #59
    SXTW  X21, W15
    UBFIZ  X26, X14, #25, #27
    ASR  X12, X26, X21
    UXTH  W27, W12
    ANDS  W15, W27, #0xff03ff03
    UXTH  W5, W15
    TST  W5, W5, LSL #19
    BFI  W29, W19, #13, #9
    BFI  W5, W7, #10, #17
    SUBS  X23, X29, #0xc62
    BFI  X17, X21, #54, #8
    SBC  X24, X4, X12
    ORR  X14, X16, #0x7e0000007e
    AND  W7, W21, W26, ROR #22
    ORR  W27, W23, W15, LSL #17
    AND  X19, X12, #0xc3c3c3c3c3c3c3c3
    CSNEG  X12, X25, X21, GT
    SUBS  X29, X20, X11, LSR #52
    ADD  W20, W7, W14, UXTX #3
    BICS  X11, X5, X12, ASR #26
    SXTH  W25, W11
    SUB  X11, X19, X19, ASR #7
    BFI  W28, W24, #3, #24
    TST  W16, W29, LSL #20
    ORN  W26, W20, W28, LSL #29
    MUL  W19, W26, W27
    NGC  X27, X17
    CLS  W28, W19
    ORN  X29, X25, X28, ASR #34
    ADD  W15, W27, W29, ASR #0
    SUB  W24, W15, W11, LSR #12
    REV  X15, X12
    NEGS  X11, X16, ASR #52
    AND  W26, W24, #0x30303030
    RBIT  W29, W24
    CLS  X19, X21
    MNEG  W23, W7, W25
    NEGS  W5, W26, ASR #0
    ASR  W27, W29, W11
    SUBS  X17, X13, #0x4a0, LSL #12
    ADC  X20, X20, X14
    MVN  W28, W14, ASR #20
    SBFX  X16, X6, #0x28, #23
    CSEL  W25, W19, W27, MI
    ORR  X13, X4, X25, ROR #40
    NGCS  X6, X15
    ADDS  W27, W6, W23, LSL #21
    REV16  X21, X5
    UBFX  X11, X17, #0xa, #38
    NGCS  X19, X21
    ADCS  X17, X27, X16
    EXTR  X14, X20, X20, #0x32
    UMSUBL  X12, W11, W13, X28
    SBFIZ  X5, X14, #48, #5
    ASR  W6, W19, #0x12
    MSUB  X19, X17, X5, X6
    MADD  W5, W19, W19, W12
    ADD  X27, X22, #0xbb8
    SMNEGL  X17, W14, W23
    ADD  W15, W24, #0x5ad, LSL #12
    CSEL  X26, X25, X4, NV
    BFXIL  W6, W15, #0x18, #8
    BFI  W16, W21, #4, #13
    ADC  X21, X24, X26
    UBFM  X24, X24, #0x35, #0x21
    EON  X25, X5, X29, LSL #12
    SUBS  X12, X21, W13, SXTH #3
    MUL  W14, W19, W28
    ANDS  X23, X28, X27, ROR #62
    SBCS  W28, W29, W4
    SBFX  W21, W28, #0x13, #10
    CSEL  X15, X24, X6, EQ
    NGCS  W20, W17
    ASRV  W6, W23, W16
    NGCS  X26, X25
    EXTR  W19, W14, W12, #0x19
    SUBS  W12, W21, #0x2df
    NEGS  W27, W6, LSR #24
    SBC  X6, X27, X27
    AND  W11, W15, W20, LSR #30
    EON  W24, W26, W6, LSL #16
    SUBS  W15, W24, W19, UXTX #2
    ANDS  W26, W15, W15, ASR #9
    REV  W23, W26
    ASR  W16, W12, #0xa
    CLZ  X25, X23
    CSINC  X15, X11, X25, PL
    BFM  W24, W15, #0x6, #0x17
    EXTR  X14, X4, X16, #0x25
    ANDS  W21, W24, #0xffc0ffc0
    TST  W14, W14, LSL #18
    NGCS  W27, W12
    MSUB  W17, W23, W16, W24
    ADCS  W16, W17, W19
    BFXIL  W12, W11, #0x19, #5
    ORN  W15, W6, W6, LSR #9
    NGC  W23, W15
    MSUB  W24, W6, W6, W13
    TST  W6, W11, ASR #2
    ORR  W19, W4, W23, LSL #23
    ORR  W14, W28, W12, ROR #16
    SUB  W26, W14, W5, ASR #14
    ORN  W13, W22, W26, LSL #19
    ADD  W25, W17, W13, UXTH #2
    SUB  X14, X22, X6, ASR #55
    SUBS  X15, X5, W23, UXTH #4
    BIC  W13, W25, W15, LSL #23
    SMULH  X17, X12, X19
    NEGS  W20, W14, LSR #9
    UMADDL  X14, W28, W4, X20
    CSINV  X11, X19, X7, LE
    UMNEGL  X26, W19, W16
    AND  W20, W24, W17, ASR #18
    CSINV  W7, W6, W4, AL
    UMADDL  X28, W7, W13, X28
    ADCS  W13, W21, W16
    NGC  W25, W4
    EOR  W24, W26, W6, ASR #25
    MADD  W26, W23, W21, W6
    SUB  X12, X14, W27, SXTW #2
    UMULH  X5, X11, X11
    ADD  X19, X28, #0x35a, LSL #12
    ADDS  W15, W25, #0xc2a, LSL #12
    ORR  X16, X15, #0xfc00000000
    RBIT  W21, W24
    SUB  W24, W21, W12, SXTW #2
    ADDS  W11, W5, W13, LSL #6
    ADDS  X21, X26, W11, SXTH #4
    EXTR  X23, X20, X20, #0x30
    REV16  X22, X19
    BFI  X28, X22, #20, #8
    SUBS  W26, W16, #0x239
    BFXIL  W14, W28, #0x7, #17
    CSEL  W27, W23, W14, LT
    TST  X27, X27, ROR #49
    MADD  W15, W24, W24, W25
    MNEG  X28, X21, X19
    ASRV  W23, W28, W26
    SUB  X6, X23, X23, LSR #58
    REV  X26, X15
    BIC  X20, X4, X6, LSR #15
    BFI  W12, W16, #6, #15
    ADD  X19, X12, #0xcbf
    RBIT  W28, W19
    SDIV  W6, W22, W24
    MVN  X26, X13, LSR #22
    NEG  X24, X28, LSL #3
    SUBS  X14, X24, X6, UXTX #3
    CSINC  W5, W20, W20, VC
    EON  X5, X5, X27, ASR #23
    UBFX  X21, X5, #0x12, #11
    CSNEG  X28, X21, X21, AL
    BFXIL  W11, W26, #0x15, #11
    MNEG  X26, X4, X11
    SBCS  X5, X22, X24
    MVN  W14, W14, ROR #6
    ADDS  W25, W28, W14, SXTB #4
    TST  X26, #0x1fff00000000000
    REV  X22, X5
    ADDS  W27, W25, #0x6b0
    MVN  X20, X27, LSL #46
    MSUB  W27, W20, W20, W22
    UXTB  W22, W6
    BFI  W12, W16, #9, #3
    ASR  W28, W23, W13
    REV16  W23, W28
    UMSUBL  X5, W20, W19, X7
    MSUB  W11, W19, W27, W14
    BICS  X15, X20, X5, ASR #13
    MADD  W6, W7, W28, W5
    REV16  W16, W21
    EON  X24, X26, X27, LSR #0
    ADD  W21, W20, W23, LSL #7
    CSEL  W25, W7, W16, VC
    ANDS  X19, X14, X25, ROR #14
    TST  W19, W11, ROR #1
    BFXIL  W13, W26, #0x18, #2
    UXTH  W26, W24
    ADD  X28, X16, X26, LSL #3
    UMULL  X20, W15, W12
    SUBS  X4, X4, #0x1
    B.NE  TSRTIntAlu_label_16
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntAlu_TestFail
    MOVZ  X18, #0xc53, LSL #0
    MOVK  X18, #0x8dc8, LSL #16
    MOVK  X18, #0xf3ad, LSL #32
    MOVK  X18, #0x7237, LSL #48
    SUB  X8, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntAlu_TestFail
    MOVZ  X18, #0x6f4c, LSL #0
    MOVK  X18, #0x8dc8, LSL #16
    SUB  X8, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntAlu_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X8, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntAlu_TestFail
    MOVZ  X18, #0x7f0a, LSL #0
    MOVK  X18, #0x7701, LSL #16
    SUB  X8, X18, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntAlu_TestFail
    MOVZ  X18, #0xfd95, LSL #0
    MOVK  X18, #0x8dc7, LSL #16
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntAlu_TestFail
    MOVZ  X18, #0x46, LSL #0
    MOVK  X18, #0x7ba6, LSL #16
    SUB  X8, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntAlu_TestFail
    MOVZ  X18, #0x276, LSL #0
    MOVK  X18, #0x1d46, LSL #16
    SUB  X8, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntAlu_TestFail
    MOVZ  X18, #0x91bf, LSL #0
    MOVK  X18, #0x6293, LSL #16
    MOVK  X18, #0x2e40, LSL #32
    MOVK  X18, #0xfa7c, LSL #48
    SUB  X8, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntAlu_TestFail
    MOVZ  X18, #0xff07, LSL #0
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntAlu_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntAlu_TestFail
    MOVZ  X18, #0x276, LSL #0
    MOVK  X18, #0x2, LSL #16
    SUB  X8, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntAlu_TestFail
    MOVZ  X18, #0x972b, LSL #0
    MOVK  X18, #0xb566, LSL #16
    MOVK  X18, #0x49a1, LSL #32
    MOVK  X18, #0x3698, LSL #48
    SUB  X8, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntAlu_TestFail
    MOVZ  X18, #0xce7f, LSL #0
    MOVK  X18, #0xff83, LSL #16
    SUB  X8, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntAlu_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntAlu_TestFail
    MOVZ  X18, #0x79d, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X8, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntAlu_TestFail
    MOVZ  X18, #0x47d1, LSL #0
    MOVK  X18, #0xef7c, LSL #16
    SUB  X8, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntAlu_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X8, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntAlu_TestFail
    MOVZ  X18, #0x47d1, LSL #0
    SUB  X8, X18, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntAlu_TestFail
    MOVZ  X18, #0x502f, LSL #0
    MOVK  X18, #0x6fc, LSL #16
    SUB  X8, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntAlu_TestFail
    MOVZ  X18, #0x3d8f, LSL #0
    MOVK  X18, #0x3, LSL #16
    SUB  X8, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntAlu_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0x8e23, LSL #16
    SUB  X8, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntAlu_TestFail
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
    MOVZ  X27, #0xf, LSL #0
TSRTIntAlu_label_17:
    REV16  X20, X28
    ASR  W20, W29, W26
    NEG  X5, X25, LSR #21
    ADDS  W23, W20, W20, ASR #3
    ADDS  X25, X5, X27, LSL #52
    MUL  W4, W23, W23
    SUBS  W24, W25, W25, SXTB #4
    SMADDL  X16, W4, W24, X16
    ORR  W5, W5, #0x88888888
    ADD  X5, X4, X18, UXTX #0
    CLZ  X18, X23
    UMSUBL  X13, W13, W12, X24
    UBFM  X20, X29, #0x36, #0x10
    ASR  X4, X5, X4
    SBFX  W7, W28, #0x0, #9
    CLZ  W25, W12
    ASRV  X19, X28, X14
    SMSUBL  X28, W29, W25, X19
    ADDS  W5, W18, W22, SXTH #2
    MUL  W18, W28, W19
    CLS  X6, X7
    AND  X8, X17, X16, ASR #2
    TST  X14, #0xffff00000000000f
    CLZ  X20, X16
    CLS  X16, X14
    ADDS  W6, W24, W23, UXTH #4
    ROR  W5, W25, W23
    TST  X12, X6, LSR #20
    RORV  W6, W8, W29
    AND  W17, W24, W25, ROR #22
    BICS  X17, X24, X29, LSR #44
    SMNEGL  X21, W23, W13
    UMULL  X13, W12, W24
    CLZ  W24, W21
    SUB  X12, X6, X20, LSR #11
    EON  X24, X4, X4, ROR #35
    ADDS  W26, W12, W16, ASR #9
    SUBS  W12, W13, W17, UXTW #0
    RORV  W14, W24, W5
    CSEL  X8, X14, X18, HI
    EOR  W25, W8, #0xe7e7e7e7
    SUBS  W28, W26, W26, LSL #27
    SUBS  W17, W28, #0x772
    ROR  W29, W25, #0x14
    CSINV  X7, X29, X12, LT
    SMULL  X21, W17, W7
    BFM  X25, X25, #0xa, #0xb
    MUL  W14, W25, W22
    SDIV  W16, W6, W6
    ANDS  X28, X6, X16, ASR #5
    SUB  X23, X5, W26, UXTB #1
    ADC  W20, W29, W18
    ADDS  X24, X16, W14, SXTB #3
    AND  W6, W21, #0x8000007f
    BFM  W26, W23, #0x15, #0x2
    REV16  W23, W17
    ORR  X8, X24, X12, ASR #9
    ASR  X17, X26, #0x29
    ASR  X29, X6, X20
    SUB  W12, W28, W14, LSR #25
    ORN  W24, W24, W16, LSL #25
    ASR  X21, X14, #0x2a
    UMADDL  X18, W29, W27, X27
    ADDS  W28, W24, #0x0
    SUB  W20, W26, #0xe97, LSL #12
    EXTR  X13, X16, X14, #0x33
    EON  W26, W13, W13, ROR #9
    TST  X25, X17, ROR #11
    SBC  W5, W18, W12
    NEG  W25, W23, LSL #9
    ORN  X13, X26, X8, LSR #19
    CLS  X26, X20
    BFM  X22, X5, #0x27, #0x29
    ADD  W7, W28, #0xc36, LSL #12
    SMSUBL  X17, W12, W22, X7
    BFI  X18, X13, #16, #26
    SBCS  X7, X14, X18
    ADDS  W6, W26, W21, LSL #21
    CSEL  X16, X16, X25, HI
    SMULH  X24, X16, X6
    SUB  W21, W7, #0x6cb
    ADDS  W22, W17, W24, UXTX #2
    UDIV  X26, X19, X12
    SXTB  X23, W26
    UMULL  X29, W21, W22
    ORN  W7, W29, W29, ROR #18
    ANDS  W26, W7, #0x1c00
    MUL  W28, W26, W26
    REV32  X25, X22
    BFI  X12, X23, #63, #1
    NGC  W17, W12
    ASRV  X6, X25, X17
    SUBS  X12, X28, X28, ASR #9
    ADCS  X28, X6, X6
    ROR  W24, W28, W28
    EOR  W21, W12, #0xf800f800
    SUBS  W17, W24, W24, UXTB #2
    CSNEG  X7, X21, X21, CC
    UDIV  X21, X17, X7
    UDIV  W24, W26, W4
    ROR  X19, X23, #0x33
    NEGS  W12, W29, LSL #20
    EXTR  X22, X7, X18, #0x2e
    SMULL  X18, W17, W29
    NGC  W23, W20
    ADD  X29, X12, X27, LSR #14
    MADD  W25, W7, W24, W18
    NGCS  W7, W13
    SDIV  W12, W6, W6
    SUBS  W6, W4, W25, UXTH #3
    SBFX  W25, W28, #0x3, #4
    NEG  W17, W25, LSR #3
    CSINV  X25, X7, X17, EQ
    EOR  W4, W21, W25, LSL #21
    UXTB  W25, W23
    AND  W20, W25, W19, ROR #8
    UBFM  X24, X4, #0x1f, #0x24
    ADDS  X23, X24, X20, LSL #7
    AND  W18, W22, W22, ASR #30
    UMULH  X22, X18, X23
    CSINC  W20, W12, W22, GT
    ORR  X23, X8, X6, ROR #26
    UMULH  X17, X20, X20
    NEGS  X7, X23, ASR #28
    SBCS  W4, W28, W24
    SBFIZ  X19, X17, #60, #2
    ADD  W20, W19, W19, SXTB #3
    RORV  X13, X29, X4
    BFXIL  W22, W20, #0x10, #2
    NGC  X25, X7
    REV32  X8, X25
    SBFIZ  X7, X22, #11, #53
    ANDS  W6, W7, W7, LSL #21
    SBC  W18, W28, W7
    UMULL  X4, W18, W6
    REV16  W28, W4
    SUBS  X19, X28, #0x8c4, LSL #12
    SBFM  W12, W8, #0x2, #0x0
    UMULL  X28, W12, W12
    MSUB  X7, X13, X19, X23
    RORV  X8, X28, X17
    NGCS  X28, X7
    UXTB  W13, W8
    REV16  W7, W13
    SBFM  X23, X21, #0x28, #0xe
    ASR  X22, X28, #0x26
    ASRV  W4, W7, W7
    UMADDL  X25, W12, W4, X4
    BIC  W8, W22, W25, LSR #11
    SUBS  X29, X8, W8, UXTB #0
    ORR  W12, W23, #0xdddddddd
    ORR  W17, W12, W29, ROR #3
    NGC  X19, X26
    NEGS  W13, W22, ASR #1
    ORR  X22, X28, #0x8007800780078007
    CSNEG  W28, W23, W20, MI
    MUL  W26, W18, W24
    REV32  X4, X12
    SUB  X6, X18, #0x995, LSL #12
    CSEL  X12, X27, X12, LS
    NEG  X20, X12, LSL #9
    UDIV  X29, X8, X20
    ROR  X23, X17, X6
    ORR  X12, X23, #0x1fffffffffffc00
    MNEG  X24, X12, X13
    REV16  X6, X22
    ASRV  X8, X28, X4
    ROR  W23, W6, W26
    SXTB  W12, W17
    SBFX  W13, W12, #0x11, #2
    NGCS  W25, W29
    SUBS  X4, X13, X25, ASR #48
    AND  X25, X8, X24, ASR #62
    CLZ  W20, W25
    AND  X24, X19, #0x1000000010
    ADD  W6, W24, W4, SXTH #2
    TST  W23, #0xffe3ffe3
    TST  X20, X6, LSL #52
    ORN  X20, X27, X25, LSL #9
    TST  W26, W19, LSL #13
    ASR  X22, X28, X5
    NEG  X12, X16, LSR #31
    CSINC  X23, X21, X21, VS
    SDIV  W6, W24, W17
    MVN  W17, W17, ASR #10
    ORN  X24, X16, X25, LSL #52
    NEG  W18, W29, ASR #16
    UXTH  W4, W29
    CSINV  W4, W24, W24, VS
    TST  X22, #0xf803f803f803f803
    BFI  X8, X22, #33, #16
    SUB  W16, W12, W17, ASR #1
    SUBS  W25, W18, W20, ASR #2
    TST  X25, X16, ASR #61
    SBFX  X21, X4, #0x32, #10
    CSEL  W5, W6, W18, EQ
    SBFM  X28, X23, #0xe, #0x16
    MUL  W17, W28, W8
    ADD  X16, X21, X5, LSL #61
    SUBS  W18, W16, W16, LSR #11
    SUBS  X27, X27, #0x1
    B.NE  TSRTIntAlu_label_17
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntAlu_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X15, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntAlu_TestFail
    MOVZ  X11, #0xec00, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X15, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntAlu_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X15, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntAlu_TestFail
    MOVZ  X11, #0x1, LSL #0
    SUB  X15, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntAlu_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X15, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntAlu_TestFail
    MOVZ  X11, #0x1, LSL #0
    SUB  X15, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntAlu_TestFail
    MOVZ  X4, #0x37e5, LSL #0
    MOVK  X4, #0x8153, LSL #16
    MOVK  X4, #0x8e38, LSL #32
    MOVK  X4, #0x9da7, LSL #48
    MOVZ  X5, #0x32c3, LSL #0
    MOVK  X5, #0xc9df, LSL #16
    MOVK  X5, #0x6def, LSL #32
    MOVK  X5, #0xe079, LSL #48
    MOVZ  X6, #0x209, LSL #0
    MOVK  X6, #0x7d7, LSL #16
    MOVK  X6, #0xb375, LSL #32
    MOVK  X6, #0x3480, LSL #48
    MOVZ  X7, #0xda85, LSL #0
    MOVK  X7, #0xf6d2, LSL #16
    MOVK  X7, #0xb60b, LSL #32
    MOVK  X7, #0x5010, LSL #48
    MOVZ  X8, #0x3426, LSL #0
    MOVK  X8, #0xdc99, LSL #16
    MOVK  X8, #0x94ba, LSL #32
    MOVK  X8, #0x9c2b, LSL #48
    MOVZ  X11, #0xbb8f, LSL #0
    MOVK  X11, #0xbc31, LSL #16
    MOVK  X11, #0x9f, LSL #32
    MOVK  X11, #0x57be, LSL #48
    MOVZ  X12, #0x2dda, LSL #0
    MOVK  X12, #0x900f, LSL #16
    MOVK  X12, #0x6054, LSL #32
    MOVK  X12, #0xae19, LSL #48
    MOVZ  X13, #0xe6f9, LSL #0
    MOVK  X13, #0x38d5, LSL #16
    MOVK  X13, #0x8963, LSL #32
    MOVK  X13, #0x3233, LSL #48
    MOVZ  X14, #0xcd6a, LSL #0
    MOVK  X14, #0x8a92, LSL #16
    MOVK  X14, #0xe4f2, LSL #32
    MOVK  X14, #0xfd0a, LSL #48
    MOVZ  X15, #0xe379, LSL #0
    MOVK  X15, #0x1724, LSL #16
    MOVK  X15, #0x51de, LSL #32
    MOVK  X15, #0xb221, LSL #48
    MOVZ  X16, #0xd5f5, LSL #0
    MOVK  X16, #0x57b2, LSL #16
    MOVK  X16, #0xa98f, LSL #32
    MOVK  X16, #0x2263, LSL #48
    MOVZ  X17, #0x1895, LSL #0
    MOVK  X17, #0x8823, LSL #16
    MOVK  X17, #0x7815, LSL #32
    MOVK  X17, #0x6cea, LSL #48
    MOVZ  X18, #0x89cd, LSL #0
    MOVK  X18, #0x7d64, LSL #16
    MOVK  X18, #0x5b92, LSL #32
    MOVK  X18, #0x829, LSL #48
    MOVZ  X19, #0x54ac, LSL #0
    MOVK  X19, #0xbed2, LSL #16
    MOVK  X19, #0xecf, LSL #32
    MOVK  X19, #0x411e, LSL #48
    MOVZ  X20, #0x8a6b, LSL #0
    MOVK  X20, #0xf019, LSL #16
    MOVK  X20, #0x6338, LSL #32
    MOVK  X20, #0xa99, LSL #48
    MOVZ  X21, #0xf14d, LSL #0
    MOVK  X21, #0x28c4, LSL #16
    MOVK  X21, #0xa0b, LSL #32
    MOVK  X21, #0x2d0, LSL #48
    MOVZ  X22, #0x5fcf, LSL #0
    MOVK  X22, #0xd288, LSL #16
    MOVK  X22, #0xbb0e, LSL #32
    MOVK  X22, #0xae44, LSL #48
    MOVZ  X23, #0x7c44, LSL #0
    MOVK  X23, #0x9a8c, LSL #16
    MOVK  X23, #0x3e75, LSL #32
    MOVK  X23, #0x6bb4, LSL #48
    MOVZ  X24, #0x7504, LSL #0
    MOVK  X24, #0xd18a, LSL #16
    MOVK  X24, #0xc1b, LSL #32
    MOVK  X24, #0xa489, LSL #48
    MOVZ  X25, #0x17cc, LSL #0
    MOVK  X25, #0xa13a, LSL #16
    MOVK  X25, #0x52, LSL #32
    MOVK  X25, #0xd4ba, LSL #48
    MOVZ  X26, #0x58da, LSL #0
    MOVK  X26, #0x33d0, LSL #16
    MOVK  X26, #0xfca0, LSL #32
    MOVK  X26, #0x235c, LSL #48
    MOVZ  X27, #0x5ce6, LSL #0
    MOVK  X27, #0x9ae2, LSL #16
    MOVK  X27, #0x65b6, LSL #32
    MOVK  X27, #0xf96c, LSL #48
    MOVZ  X28, #0xeba5, LSL #0
    MOVK  X28, #0x1f38, LSL #16
    MOVK  X28, #0x6151, LSL #32
    MOVK  X28, #0xe372, LSL #48
    MOVZ  X29, #0xbe81, LSL #0
    MOVK  X29, #0xca7c, LSL #16
    MOVK  X29, #0xa117, LSL #32
    MOVK  X29, #0xcfb4, LSL #48
    MOVZ  X11, #0xf, LSL #0
TSRTIntAlu_label_18:
    BFXIL  X26, X24, #0x11, #19
    REV32  X6, X26
    REV  W21, W11
    BFM  X22, X27, #0x3f, #0x12
    CSINV  X5, X28, X29, CS
    ROR  X22, X22, X21
    TST  X22, X22, LSR #21
    SXTB  X19, W6
    SUB  W16, W19, #0x722, LSL #12
    SXTH  W15, W16
    SBFX  X13, X5, #0x2c, #14
    SMADDL  X21, W15, W13, X13
    UMSUBL  X21, W21, W21, X21
    ADD  W16, W21, #0xcad
    SMULL  X7, W18, W16
    UXTH  W26, W24
    CLS  X16, X5
    ADD  W18, W19, W25, SXTB #4
    ADD  X22, X24, X6, LSL #27
    BFM  W19, W18, #0x13, #0x1b
    ORR  X21, X25, X26, ASR #44
    ORN  W18, W15, W4, LSL #26
    UMNEGL  X5, W18, W7
    SUBS  W25, W15, #0x871, LSL #12
    SXTH  W13, W15
    NEG  W6, W12, ASR #17
    UBFIZ  W15, W28, #2, #21
    MSUB  X12, X16, X6, X6
    TST  W15, #0xc0ffc0ff
    ROR  W27, W12, #0x1d
    SDIV  X29, X26, X6
    NGCS  W7, W27
    CLS  W4, W19
    SUB  X18, X22, #0xba5, LSL #12
    NGC  X12, X7
    ROR  X21, X12, #0x14
    ASRV  X24, X5, X18
    SUBS  X27, X29, X21, LSL #60
    MADD  X28, X21, X7, X13
    ORN  X5, X28, X25, LSL #53
    SMADDL  X12, W5, W5, X27
    CSNEG  W14, W24, W4, LT
    CSEL  X4, X12, X12, LS
    SBCS  X16, X14, X4
    ASR  X22, X13, X24
    MSUB  W21, W15, W19, W21
    SUBS  W26, W22, W11, SXTH #4
    UBFIZ  W12, W12, #15, #6
    ADDS  X14, X28, X13, UXTX #1
    BFXIL  X6, X21, #0x23, #5
    UMULH  X13, X7, X26
    ANDS  W29, W26, W16, LSR #4
    CLS  W28, W6
    AND  X18, X24, X5, ROR #48
    UDIV  X27, X12, X29
    SXTH  X25, W8
    BIC  X16, X26, X11, LSR #25
    ADC  W26, W26, W28
    UXTH  W12, W7
    ANDS  W29, W7, W4, ROR #29
    TST  W29, W27, LSR #16
    NGC  X28, X16
    NGC  W5, W25
    SDIV  X13, X12, X14
    ROR  W19, W18, W28
    EOR  W15, W5, W19, ROR #16
    UBFIZ  W14, W26, #13, #4
    CSINC  X26, X14, X15, VS
    SBFM  X25, X13, #0x33, #0x1
    UBFIZ  W21, W25, #31, #1
    CLZ  X18, X26
    MSUB  W26, W18, W21, W27
    SBFM  X24, X16, #0x10, #0x8
    ADDS  X5, X29, W14, UXTW #2
    CLZ  W20, W11
    ADCS  X22, X26, X5
    BFM  W5, W29, #0x1a, #0x7
    SUBS  X15, X11, X20, LSL #50
    ORR  X7, X27, X7, ROR #50
    NGCS  X27, X14
    NGC  W20, W22
    ADD  W13, W25, #0xda6
    ASR  X12, X6, #0x26
    CLS  W29, W22
    REV16  X22, X13
    BIC  X21, X7, X20, LSL #57
    CSNEG  X20, X24, X12, AL
    BICS  X6, X21, X29, LSR #39
    CLZ  X14, X15
    SBC  X15, X14, X27
    EOR  X19, X21, #0x7c007c007c007c00
    ROR  X26, X5, X6
    ASR  X24, X22, #0x19
    UBFM  X21, X15, #0x32, #0x29
    TST  X19, #0xffffffc0000001ff
    SUB  X19, X4, #0x0
    REV32  X13, X19
    EXTR  W7, W13, W11, #0x16
    SMULH  X4, X26, X20
    ORN  W25, W7, W21, LSR #25
    SUBS  X12, X4, W24, UXTB #1
    BFI  X26, X12, #60, #2
    SUB  X16, X25, X7, LSR #25
    ADDS  W24, W26, W26, LSR #24
    SDIV  X20, X14, X16
    ORR  X16, X20, X20, LSR #0
    CLS  X19, X24
    AND  X22, X19, X16, ROR #53
    ASRV  W4, W16, W20
    NGCS  X29, X11
    ADDS  X20, X19, X28, LSL #12
    REV16  X21, X7
    SBC  X6, X26, X29
    SUB  W5, W8, W21, UXTX #1
    ADDS  X13, X19, #0x4d
    BFI  W29, W25, #18, #8
    REV  W25, W6
    ADD  W6, W21, #0x4fa
    SBFX  W19, W27, #0x1b, #1
    ADDS  X8, X22, X22, LSL #62
    SDIV  W28, W29, W8
    ORR  X29, X28, #0x4444444444444444
    REV16  X14, X29
    ADD  W26, W14, W20, SXTH #3
    EOR  W24, W13, W19, LSL #29
    EOR  W7, W26, W4, LSR #30
    SBFM  W4, W5, #0x4, #0x0
    EON  X5, X6, X25, ROR #12
    SXTB  W19, W5
    REV32  X26, X7
    UMADDL  X27, W26, W19, X24
    BICS  X29, X27, X4, LSL #62
    REV16  X4, X19
    SUB  X14, X29, #0x89b, LSL #12
    CLZ  W19, W27
    SMSUBL  X22, W19, W22, X11
    MUL  X29, X28, X13
    UMULL  X6, W24, W5
    ADCS  X26, X18, X21
    ADDS  W27, W26, W7, UXTX #1
    ADCS  W13, W25, W18
    SMULL  X18, W24, W21
    ADDS  W7, W14, #0x499
    SXTH  W28, W18
    ROR  W14, W14, #0x5
    SDIV  X26, X6, X14
    ADD  X25, X29, #0x2ba, LSL #12
    ADD  X24, X21, #0xb87
    UBFM  X6, X13, #0x18, #0x1b
    ANDS  W21, W6, W11, LSR #25
    ADDS  W29, W4, W28, SXTH #0
    RBIT  X5, X26
    BFM  W14, W29, #0x11, #0x7
    BIC  W20, W16, W7, LSL #12
    SBFM  X19, X21, #0x2f, #0xd
    SUBS  W4, W20, W24, SXTB #4
    ADD  X13, X27, #0x8c7
    MADD  W29, W5, W4, W13
    SMULL  X7, W14, W25
    EON  X14, X7, X29, ROR #51
    SBFM  X18, X14, #0x30, #0x2
    BIC  W26, W18, W19, LSR #24
    ANDS  W25, W26, #0xfc00fc00
    ASR  W7, W25, #0x18
    CLZ  W4, W7
    BICS  X25, X4, X4, ROR #21
    EXTR  X6, X25, X25, #0x9
    REV32  X21, X6
    AND  W28, W6, W26, LSR #2
    ANDS  X24, X26, X29, ROR #14
    NGC  X4, X18
    BIC  X19, X25, X13, ROR #16
    SXTH  X18, W21
    MVN  W6, W6, ROR #12
    UXTH  W5, W22
    ADD  X7, X20, X19, ASR #43
    ORR  W22, W15, W16, LSR #20
    MUL  W21, W19, W11
    MSUB  X13, X18, X28, X26
    SUBS  X19, X21, W5, UXTH #4
    CSNEG  W5, W24, W19, LS
    ANDS  X21, X6, #0x4444444444444444
    UMSUBL  X6, W4, W4, X29
    UBFM  W27, W7, #0x14, #0x4
    SBCS  X18, X22, X22
    UBFIZ  W22, W13, #20, #3
    ASR  X4, X27, X5
    UMULH  X5, X21, X8
    ASR  W8, W18, W5
    SMADDL  X14, W4, W22, X6
    AND  W5, W8, #0xff00ff00
    REV32  X15, X5
    ROR  W13, W14, W14
    BFM  X19, X15, #0x22, #0xe
    CSINC  W7, W13, W5, GT
    ADD  X25, X7, X19, ASR #44
    NEG  X16, X19, LSR #54
    EON  X19, X16, X4, LSL #43
    SXTH  W4, W24
    SBFM  X29, X22, #0x6, #0x5
    SUBS  X11, X11, #0x1
    B.NE  TSRTIntAlu_label_18
    MOVZ  X17, #0x0, LSL #0
    SUB  X23, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X17, #0xff00, LSL #0
    MOVK  X17, #0xff00, LSL #16
    SUB  X23, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X17, #0x8cde, LSL #0
    MOVK  X17, #0x888a, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X23, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X17, #0xff01, LSL #0
    MOVK  X17, #0xff00, LSL #16
    SUB  X23, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X23, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X23, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X17, #0xfff8, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0x7fff, LSL #32
    MOVK  X17, #0x8, LSL #48
    SUB  X23, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X17, #0x337a, LSL #0
    MOVK  X17, #0x222a, LSL #16
    SUB  X23, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X17, #0x8cde, LSL #0
    MOVK  X17, #0x888a, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X23, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X17, #0xff, LSL #0
    MOVK  X17, #0xff, LSL #16
    SUB  X23, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X17, #0xfc01, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X23, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X23, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X17, #0x3fe, LSL #0
    SUB  X23, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X23, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X17, #0x4444, LSL #0
    MOVK  X17, #0x4444, LSL #16
    SUB  X23, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X23, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x2, LSL #16
    SUB  X23, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X17, #0xfeff, LSL #0
    MOVK  X17, #0xff00, LSL #16
    SUB  X23, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X23, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X23, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X23, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X23, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntAlu_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
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
    MOVZ  X20, #0xf, LSL #0
TSRTIntAlu_label_19:
    MNEG  W28, W15, W8
    MNEG  X19, X22, X20
    ASR  W5, W24, #0x1c
    ADD  W18, W18, W21, SXTX #1
    AND  X4, X19, #0xfc000000fc000000
    BFXIL  X11, X5, #0x2b, #16
    SBC  X25, X20, X25
    NGC  X27, X23
    SMADDL  X26, W28, W26, X28
    ANDS  X17, X14, #0xffffffffe00001ff
    ADCS  W22, W26, W5
    ADDS  W19, W11, W12, UXTH #0
    RORV  X4, X18, X27
    SUBS  W22, W17, W4, LSR #15
    AND  X17, X22, #0x8888888888888888
    CSINC  X24, X25, X6, VS
    BICS  W15, W20, W17, LSL #1
    SUB  X25, X26, #0x0
    ADD  X14, X15, #0x39c, LSL #12
    REV32  X6, X25
    REV  X11, X19
    ASR  W22, W24, W26
    SXTW  X19, W11
    BFXIL  W21, W22, #0xc, #15
    SMULL  X4, W21, W21
    UMNEGL  X11, W14, W14
    EOR  W17, W6, #0x1ff81ff8
    ORR  X26, X17, X4, LSR #31
    UBFX  W4, W19, #0x1d, #2
    MUL  X19, X21, X26
    SDIV  W12, W4, W4
    UBFX  X22, X11, #0x12, #36
    SBCS  X24, X19, X22
    SXTH  X25, W24
    TST  X12, X12, LSL #56
    SUBS  X14, X23, #0x3fd
    ASR  X26, X12, #0x1b
    UDIV  W12, W4, W17
    BFM  W21, W17, #0x15, #0x1f
    UMULL  X6, W23, W6
    ASR  X24, X22, #0x25
    ADD  X11, X26, W5, UXTW #2
    UDIV  X15, X20, X7
    NGCS  W5, W15
    SMSUBL  X4, W22, W28, X28
    CSEL  W22, W25, W25, LS
    UBFX  W25, W14, #0x16, #1
    SMADDL  X19, W12, W11, X22
    ANDS  W14, W5, #0x55555555
    REV  X17, X14
    SBFM  W15, W21, #0x1d, #0x4
    SBFX  X23, X4, #0x37, #5
    EOR  W28, W19, W6, ASR #23
    SDIV  W22, W24, W24
    UDIV  X7, X22, X15
    REV32  X14, X25
    MADD  W22, W26, W27, W5
    ANDS  W17, W17, #0x80008000
    SUBS  X27, X14, W22, SXTW #0
    ADDS  X11, X23, W27, UXTB #4
    CSNEG  W27, W24, W17, CS
    BICS  X4, X11, X27, ROR #47
    EOR  X24, X28, #0xf0000000000fffff
    TST  X7, X4, ROR #0
    UMSUBL  X5, W22, W14, X17
    SXTH  X11, W20
    CLZ  W7, W22
    SBCS  W15, W20, W19
    REV  W6, W18
    ROR  W4, W19, W12
    BFI  W21, W16, #18, #3
    SUB  X19, X23, X17, LSR #54
    REV16  X12, X24
    MADD  X24, X23, X19, X20
    MNEG  X18, X4, X12
    ORR  X22, X15, #0xfff0000000000
    ASR  W27, W14, W5
    RORV  W5, W11, W21
    SMADDL  X28, W7, W5, X24
    CSEL  W23, W28, W28, VS
    ANDS  X28, X18, #0xf7f7f7f7f7f7f7f7
    NEGS  X14, X6, LSR #34
    ROR  X16, X23, X14
    EOR  W17, W22, #0x3030303
    MVN  W22, W27, ROR #10
    ADCS  W19, W22, W6
    SBFM  W26, W24, #0x10, #0x1f
    CSEL  W14, W28, W25, NE
    TST  X16, X17, ASR #52
    REV  W14, W19
    UMNEGL  X4, W14, W26
    BIC  W28, W7, W6
    UDIV  X17, X12, X19
    ADDS  W18, W11, W16, ASR #22
    SMULH  X19, X4, X17
    UBFM  W23, W5, #0x18, #0xd
    ADDS  X26, X27, #0xba1, LSL #12
    SUBS  X27, X21, #0x37
    RORV  W6, W18, W15
    SBC  X4, X15, X12
    SUBS  X12, X18, #0xa81, LSL #12
    CSINV  X7, X17, X25, VC
    MUL  X14, X7, X27
    EXTR  W24, W12, W12, #0x8
    ADD  X22, X23, #0x11d
    REV  W21, W22
    ANDS  W16, W19, #0xfc03ffff
    SUB  W19, W24, W16, SXTW #0
    MVN  X24, X19, ROR #50
    CSEL  X7, X28, X6, MI
    SMSUBL  X11, W8, W26, X24
    SUB  W12, W14, W21, SXTH #0
    ANDS  X14, X12, #0x8007800780078007
    MADD  X24, X25, X19, X8
    SUB  X27, X24, W24, SXTH #3
    ADDS  X8, X27, X4, LSL #48
    SMNEGL  X16, W8, W7
    ADC  X5, X16, X11
    SUBS  W19, W5, W14, SXTB #4
    BICS  X7, X8, X6, ASR #8
    SBFX  W24, W12, #0xa, #3
    SUBS  W5, W25, #0x5e2
    SBFM  W22, W8, #0x14, #0x1d
    CSINC  X14, X5, X25, CC
    SUBS  W8, W4, #0x5d2, LSL #12
    CSEL  X28, X18, X20, HI
    NGCS  X18, X27
    EOR  W15, W20, #0xfe000000
    SBFX  X5, X7, #0x24, #6
    UBFIZ  X7, X28, #47, #11
    UMULL  X12, W18, W19
    SUB  W16, W5, W24, SXTH #3
    ASR  X6, X12, X22
    ORR  W22, W7, W8, ASR #21
    NEG  W23, W14, LSR #0
    NGC  X19, X15
    UMSUBL  X12, W19, W19, X6
    ORR  X26, X16, X22, LSL #39
    UDIV  W15, W26, W23
    MSUB  W23, W12, W12, W12
    MVN  W19, W23, ASR #24
    ADCS  X4, X14, X8
    ROR  X14, X15, X7
    ADCS  W18, W20, W14
    SBFX  W25, W4, #0xf, #10
    TST  W25, #0x1ff8
    AND  W5, W19, #0xf7fff7ff
    ADDS  W28, W5, W18, SXTB #2
    BICS  W27, W23, W8, ASR #31
    EOR  W19, W6, #0xf803f803
    SUBS  W15, W19, #0xe5e
    ASRV  W12, W5, W22
    TST  W12, #0x80ff80ff
    EON  W12, W18, W6, LSR #18
    MVN  X19, X17, ASR #1
    ADD  W22, W16, W7, LSR #14
    SBFIZ  X14, X16, #22, #16
    ASRV  W6, W17, W18
    SUB  W7, W25, W15, LSR #11
    ADDS  X24, X21, X26, LSR #59
    ADC  X25, X28, X28
    ADDS  W8, W6, W12, LSL #2
    TST  W27, W26, LSR #8
    SUB  W4, W25, #0xb6f
    REV32  X23, X5
    SUB  W16, W8, W4, SXTX #2
    ANDS  W12, W24, W24, ASR #1
    EXTR  W18, W8, W23, #0xd
    NEG  W25, W22, ASR #4
    CLZ  W6, W18
    MVN  W18, W19, ROR #10
    ROR  X19, X14, #0x2d
    UMULL  X24, W16, W24
    CSINV  X22, X18, X12, PL
    UBFIZ  X17, X28, #55, #7
    UDIV  X8, X19, X7
    EON  W14, W25, W6, LSL #3
    SMNEGL  X6, W24, W24
    UBFX  W23, W22, #0x2, #29
    SUBS  W28, W21, W28, SXTH #4
    CLS  W21, W28
    AND  W28, W14, #0xfffe0003
    TST  X6, #0xfe00fe00fe00fe00
    ANDS  X12, X17, X12, LSR #58
    SUB  X25, X17, #0xd7d, LSL #12
    ASR  X17, X23, X28
    BIC  W23, W17, W17, LSR #18
    SBC  W6, W22, W12
    NGCS  W24, W6
    SUBS  W18, W23, W8, LSR #29
    BICS  W8, W18, W18, LSL #6
    SBCS  X26, X21, X21
    SUB  W18, W24, #0x34d
    SBFX  X21, X8, #0x2d, #4
    ORR  W23, W26, #0xffc0000f
    MSUB  W19, W18, W18, W25
    ROR  X14, X19, X19
    SBCS  X6, X5, X21
    SUB  W18, W23, #0x1a7
    SBCS  W19, W23, W15
    SUBS  X20, X20, #0x1
    B.NE  TSRTIntAlu_label_19
    MOVZ  X29, #0xf23b, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X13, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X29, #0x39, LSL #0
    SUB  X13, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X29, #0x38, LSL #0
    SUB  X13, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X29, #0x15ea, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X29, #0x400, LSL #0
    MOVK  X29, #0xfc, LSL #16
    SUB  X13, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xd5e3, LSL #16
    MOVK  X29, #0x25e8, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X13, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X29, #0x25c0, LSL #0
    MOVK  X29, #0xabcd, LSL #16
    SUB  X13, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X29, #0xe096, LSL #0
    MOVK  X29, #0x75a, LSL #16
    SUB  X13, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X29, #0xca0b, LSL #0
    MOVK  X29, #0xff56, LSL #16
    SUB  X13, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X29, #0x564, LSL #0
    MOVK  X29, #0x7fc, LSL #16
    SUB  X13, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X29, #0xfe58, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X13, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X29, #0x1f69, LSL #0
    MOVK  X29, #0xf8a5, LSL #16
    SUB  X13, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X29, #0x564b, LSL #0
    MOVK  X29, #0xffc0, LSL #16
    SUB  X13, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X13, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X29, #0xa9b5, LSL #0
    MOVK  X29, #0x3f, LSL #16
    SUB  X13, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X29, #0x3000, LSL #0
    MOVK  X29, #0xff28, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x2a7f, LSL #48
    SUB  X13, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X13, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X29, #0x6c4a, LSL #0
    MOVK  X29, #0xc654, LSL #16
    SUB  X13, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
    MOVZ  X29, #0x2, LSL #0
    MOVK  X29, #0xfffe, LSL #16
    SUB  X13, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntAlu_TestFail
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
    MOVZ  X27, #0xf, LSL #0
TSRTIntAlu_label_20:
    UMNEGL  X18, W26, W28
    NGC  X6, X27
    CSINV  X12, X6, X18, NE
    BICS  X8, X12, X25, ASR #39
    SUBS  W15, W8, W8, ASR #0
    REV16  X7, X15
    UMULH  X24, X7, X7
    SXTW  X14, W24
    ADDS  X16, X19, W14, SXTH #3
    ANDS  W7, W16, #0x1ffffc0
    SUB  X22, X7, #0x123
    UBFIZ  X19, X22, #41, #2
    SXTW  X16, W19
    SBFM  X21, X16, #0x2e, #0x2d
    BIC  X28, X13, X21, LSR #37
    SMULH  X18, X28, X28
    EXTR  W6, W18, W7, #0x1e
    SBFIZ  W28, W22, #16, #7
    UMADDL  X21, W28, W6, X6
    EXTR  X25, X4, X21, #0x2
    ORN  X28, X25, X25, ROR #58
    SUBS  X13, X21, W4, SXTH #3
    ADDS  X19, X28, X13, ASR #55
    CLZ  X26, X19
    SUB  W8, W26, #0x64
    ASRV  X18, X8, X8
    ASR  X4, X18, #0x1c
    ADD  W16, W4, W4, LSR #18
    MNEG  W13, W13, W16
    SMNEGL  X14, W13, W13
    BFI  W18, W14, #16, #7
    UMSUBL  X21, W14, W18, X8
    ADDS  X4, X24, X24, LSL #14
    MADD  W28, W23, W11, W16
    ADD  W8, W23, #0x5e7, LSL #12
    ADDS  W13, W20, W16, UXTH #2
    BIC  X7, X12, X13, ROR #36
    SUB  X24, X27, #0x66d
    EXTR  W19, W7, W8, #0x19
    SUB  X16, X19, W21, UXTW #1
    NEGS  X11, X21, LSL #53
    ORR  W8, W19, W22, ASR #26
    SDIV  X6, X18, X28
    SMSUBL  X21, W18, W26, X13
    ORR  X7, X26, #0xffe00000ffe
    SUBS  X28, X13, X6, LSL #5
    BFM  X6, X27, #0x1d, #0x37
    UDIV  X25, X4, X28
    BIC  W22, W21, W14, ROR #20
    RBIT  X19, X24
    BFXIL  X24, X8, #0x2b, #3
    SBFM  X11, X24, #0x4, #0x10
    SUBS  X24, X6, X22, ASR #15
    BIC  W12, W19, W24, ROR #21
    REV32  X23, X16
    ADDS  W14, W23, W23, LSR #30
    ADC  W23, W7, W14
    SBCS  X14, X11, X12
    ASRV  W18, W23, W14
    NGC  W28, W25
    NEG  X6, X18, LSL #50
    NGCS  X8, X6
    SUB  W4, W28, #0x1d9, LSL #12
    UBFX  X6, X8, #0x9, #26
    ADDS  X16, X4, #0x5c5
    ROR  X20, X6, #0x30
    MSUB  W4, W28, W16, W16
    SUBS  W18, W4, #0x97a
    ASR  W12, W20, W20
    BFXIL  X6, X18, #0x19, #6
    SXTH  X11, W12
    SXTH  W28, W6
    NGC  W8, W11
    ANDS  W16, W8, #0xc3c3c3c3
    NGCS  X18, X13
    SBFM  X23, X18, #0x3d, #0x2f
    ADDS  X11, X23, W23, UXTH #3
    SXTB  W18, W11
    SBC  X4, X18, X28
    SUBS  X8, X4, X4, LSL #1
    SXTH  X20, W25
    AND  W28, W20, W20, ROR #11
    ADDS  W6, W16, W28, LSL #31
    RBIT  X12, X8
    BIC  W23, W12, W6, ASR #13
    BFXIL  X11, X22, #0x2b, #17
    ADCS  X22, X6, X12
    ADDS  X12, X28, X20, LSR #14
    SBFM  X28, X4, #0x2c, #0x6
    SBFIZ  W18, W22, #6, #15
    REV16  W16, W6
    MVN  X20, X8, ROR #23
    RORV  X13, X13, X12
    SUB  W25, W15, #0x947, LSL #12
    RBIT  X15, X18
    CSNEG  W12, W24, W22, PL
    MSUB  W4, W25, W23, W11
    ADDS  W22, W12, #0x4a4, LSL #12
    ADD  X6, X22, X16, LSL #36
    CSEL  X18, X28, X28, GT
    ASR  X12, X15, #0x3a
    MADD  X22, X12, X12, X20
    ASRV  X11, X22, X13
    SUBS  X28, X11, W4, SXTH #2
    SDIV  X8, X4, X14
    ADDS  X11, X6, #0xf91, LSL #12
    BFI  W25, W8, #14, #14
    SMULH  X13, X25, X18
    TST  X13, X28, ROR #18
    TST  W27, W7, LSR #9
    BFXIL  W4, W17, #0x8, #24
    ASRV  W14, W19, W11
    SUB  W7, W19, W14, UXTX #1
    SUB  X14, X8, X12, UXTX #1
    ADDS  W23, W25, W23, LSL #4
    UMADDL  X20, W16, W24, X24
    SUBS  X6, X6, X7, ASR #26
    SBFIZ  W19, W23, #3, #29
    ADDS  W16, W27, W12, LSR #0
    MSUB  X28, X16, X12, X26
    TST  W13, #0x7ffc7ffc
    ROR  W18, W14, W19
    SUB  W8, W14, W20, ASR #17
    CLS  W12, W7
    ANDS  W24, W15, W18, LSL #23
    ADDS  W26, W25, W11, ASR #25
    ADD  X23, X28, X28, ASR #1
    REV16  X21, X7
    REV  X28, X21
    ASRV  X17, X4, X7
    BFXIL  W11, W18, #0x14, #8
    ADDS  W4, W12, #0xc0f, LSL #12
    SUB  X21, X28, X4, LSR #46
    CSINC  X14, X8, X21, NV
    EOR  X21, X24, #0x3ffffffffe000000
    NGC  W18, W6
    ORN  X13, X11, X17, LSL #27
    NEGS  X7, X13, LSL #32
    SMULH  X16, X18, X23
    MVN  X15, X16, ASR #59
    REV32  X18, X26
    ROR  X26, X21, #0x7
    SUB  W20, W26, #0x5c7, LSL #12
    REV  X25, X20
    CLS  W24, W7
    ADD  W26, W24, W18, UXTB #1
    SUBS  X24, X14, W14, SXTW #4
    BIC  X4, X15, X24, ASR #42
    BICS  X21, X26, X25, ROR #42
    EXTR  W6, W21, W4, #0x5
    TST  W11, W18, ASR #22
    SUB  W25, W16, W21, LSR #6
    CSNEG  X17, X27, X28, LT
    ADCS  X8, X23, X18
    ADC  W12, W22, W8
    ANDS  X16, X17, X26, LSR #1
    ADD  W20, W21, W21, ASR #27
    ADDS  W7, W18, W11, UXTH #1
    BFI  X13, X15, #21, #19
    UBFIZ  W28, W28, #21, #10
    CSINV  W14, W14, W26, PL
    EXTR  W4, W14, W28, #0xa
    SXTB  W14, W6
    ADD  X23, X12, X16, ASR #1
    ROR  X28, X23, #0x3b
    SBC  W21, W13, W14
    UBFIZ  X6, X28, #42, #1
    UBFM  W18, W6, #0x18, #0xa
    MUL  W6, W25, W25
    UBFIZ  W15, W20, #4, #9
    ADD  X24, X8, X18, ASR #56
    RBIT  X6, X21
    UBFM  W16, W25, #0x15, #0xd
    CLZ  X23, X4
    ASRV  W12, W15, W24
    SUB  W11, W6, #0x258, LSL #12
    UBFIZ  X18, X11, #59, #1
    BIC  X15, X7, X12, ASR #38
    UDIV  W17, W15, W16
    ADC  X7, X17, X17
    REV32  X11, X23
    ORR  X4, X18, X11, LSL #11
    ASR  W12, W4, #0x14
    SDIV  X15, X21, X15
    ASRV  X8, X15, X15
    ORR  X21, X8, #0x4000000040
    UXTB  W17, W7
    UBFM  W18, W12, #0x8, #0x10
    SUB  X26, X18, X21, UXTX #2
    NEGS  X25, X12, ASR #8
    MUL  W21, W26, W16
    ASRV  X11, X21, X27
    NEG  X21, X8, LSR #62
    CSINV  W24, W17, W17, EQ
    BFXIL  W23, W25, #0xe, #6
    RORV  W12, W11, W23
    EOR  X25, X12, #0x1c001c001c001c
    UXTH  W12, W25
    ADDS  W4, W21, W12, LSL #13
    ADD  X7, X24, W4, SXTH #1
    SUBS  X27, X27, #0x1
    B.NE  TSRTIntAlu_label_20
    MOVZ  X29, #0x8000, LSL #0
    MOVK  X29, #0x3, LSL #16
    SUB  X5, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X5, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X5, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x1c, LSL #16
    SUB  X5, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X29, #0x1c, LSL #0
    SUB  X5, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xfc03, LSL #48
    SUB  X5, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X5, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X29, #0xf65, LSL #0
    SUB  X5, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X29, #0xc800, LSL #0
    MOVK  X29, #0x1ff, LSL #16
    SUB  X5, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X29, #0x7f80, LSL #0
    MOVK  X29, #0x8000, LSL #16
    SUB  X5, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X29, #0x1d8, LSL #0
    SUB  X5, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X29, #0x1ff, LSL #0
    MOVK  X29, #0x7000, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X5, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X29, #0x40, LSL #0
    SUB  X5, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X29, #0x1c, LSL #0
    MOVK  X29, #0x1c, LSL #32
    MOVK  X29, #0x1c, LSL #48
    SUB  X5, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X29, #0xff00, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xfeff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X5, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X29, #0x5de0, LSL #0
    MOVK  X29, #0x200, LSL #16
    SUB  X5, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail

TSRTIntAlu_TestEnd:
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
TSRTIntAlu_TestFail:
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
