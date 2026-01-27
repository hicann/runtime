.global TaishanSimdAddP01

.text
.p2align 4

TaishanSimdAddP01:

TaishanSimdAddP01_TestBegin:
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
    STP  Q0, Q1, [SP, #-32]!
    STP  Q2, Q3, [SP, #-32]!
    STP  Q4, Q5, [SP, #-32]!
    STP  Q6, Q7, [SP, #-32]!
    STP  Q8, Q9, [SP, #-32]!
    STP  Q10, Q11, [SP, #-32]!
    STP  Q12, Q13, [SP, #-32]!
    STP  Q14, Q15, [SP, #-32]!
    STP  Q16, Q17, [SP, #-32]!
    STP  Q18, Q19, [SP, #-32]!
    STP  Q20, Q21, [SP, #-32]!
    STP  Q22, Q23, [SP, #-32]!
    STP  Q24, Q25, [SP, #-32]!
    STP  Q26, Q27, [SP, #-32]!
    STP  Q28, Q29, [SP, #-32]!
    STP  Q30, Q31, [SP, #-32]!
    MRS  X2, FPCR
    MRS  X3, FPSR
    STP  X2, X3, [SP, #-16]!
    MRS  X1, NZCV
    STP  X1, X2, [SP, #-16]!
    MOVZ  X1, #0x0, LSL #0
    MOVK  X2, #0x993b, LSL #48
    MOVK  X2, #0xe0, LSL #32
    MOVK  X2, #0x28ae, LSL #16
    MOVK  X2, #0x8439, LSL #0
    MOVK  X3, #0x4198, LSL #48
    MOVK  X3, #0x5ccc, LSL #32
    MOVK  X3, #0xb8d3, LSL #16
    MOVK  X3, #0xcdf4, LSL #0
    MOVK  X4, #0x7135, LSL #48
    MOVK  X4, #0xc16f, LSL #32
    MOVK  X4, #0x1d8, LSL #16
    MOVK  X4, #0x5568, LSL #0
    MOVK  X6, #0xab22, LSL #48
    MOVK  X6, #0xb1c8, LSL #32
    MOVK  X6, #0xe52, LSL #16
    MOVK  X6, #0x28a3, LSL #0
    MOVK  X7, #0xc091, LSL #48
    MOVK  X7, #0xd81b, LSL #32
    MOVK  X7, #0x663f, LSL #16
    MOVK  X7, #0x7de0, LSL #0
    MOVK  X8, #0xe2d1, LSL #48
    MOVK  X8, #0x9568, LSL #32
    MOVK  X8, #0x8509, LSL #16
    MOVK  X8, #0xb867, LSL #0
    MOVK  X9, #0xd3b1, LSL #48
    MOVK  X9, #0xfc1e, LSL #32
    MOVK  X9, #0x6b8a, LSL #16
    MOVK  X9, #0xd015, LSL #0
    MOVK  X10, #0xf80d, LSL #48
    MOVK  X10, #0x5ed7, LSL #32
    MOVK  X10, #0x81a2, LSL #16
    MOVK  X10, #0xbefa, LSL #0
    MOVK  X11, #0xc2ef, LSL #48
    MOVK  X11, #0xd45d, LSL #32
    MOVK  X11, #0xb3ea, LSL #16
    MOVK  X11, #0x21ba, LSL #0
    MOVK  X12, #0x5333, LSL #48
    MOVK  X12, #0x5096, LSL #32
    MOVK  X12, #0x213a, LSL #16
    MOVK  X12, #0x4605, LSL #0
    MOVK  X13, #0x46c6, LSL #48
    MOVK  X13, #0x70f7, LSL #32
    MOVK  X13, #0xa6ba, LSL #16
    MOVK  X13, #0x567f, LSL #0
    MOVK  X14, #0xd959, LSL #48
    MOVK  X14, #0x5ced, LSL #32
    MOVK  X14, #0xf201, LSL #16
    MOVK  X14, #0x7cc0, LSL #0
    MOVK  X15, #0xf2ce, LSL #48
    MOVK  X15, #0xf188, LSL #32
    MOVK  X15, #0x1709, LSL #16
    MOVK  X15, #0xdf98, LSL #0
    MOVK  X16, #0x4ea4, LSL #48
    MOVK  X16, #0x87b2, LSL #32
    MOVK  X16, #0xf090, LSL #16
    MOVK  X16, #0x37db, LSL #0
    MOVK  X17, #0x4b2b, LSL #48
    MOVK  X17, #0x9733, LSL #32
    MOVK  X17, #0x163b, LSL #16
    MOVK  X17, #0xbcc4, LSL #0
    MOVK  X18, #0xc8d7, LSL #48
    MOVK  X18, #0x5df7, LSL #32
    MOVK  X18, #0xc4e5, LSL #16
    MOVK  X18, #0xb7fa, LSL #0
    MOVK  X19, #0xab09, LSL #48
    MOVK  X19, #0x1023, LSL #32
    MOVK  X19, #0x4518, LSL #16
    MOVK  X19, #0x650a, LSL #0
    MOVK  X20, #0xa68a, LSL #48
    MOVK  X20, #0x8bd7, LSL #32
    MOVK  X20, #0x1697, LSL #16
    MOVK  X20, #0x9cf3, LSL #0
    MOVK  X21, #0xd847, LSL #48
    MOVK  X21, #0x7cd9, LSL #32
    MOVK  X21, #0x265, LSL #16
    MOVK  X21, #0xaf33, LSL #0
    MOVK  X22, #0x5b12, LSL #48
    MOVK  X22, #0x1974, LSL #32
    MOVK  X22, #0xd0a4, LSL #16
    MOVK  X22, #0x48b2, LSL #0
    MOVK  X23, #0x720f, LSL #48
    MOVK  X23, #0x8d71, LSL #32
    MOVK  X23, #0xdeac, LSL #16
    MOVK  X23, #0x3764, LSL #0
    MOVK  X24, #0xaab8, LSL #48
    MOVK  X24, #0x335a, LSL #32
    MOVK  X24, #0xdbaf, LSL #16
    MOVK  X24, #0x4612, LSL #0
    MOVK  X25, #0xdd2b, LSL #48
    MOVK  X25, #0xeed3, LSL #32
    MOVK  X25, #0x8355, LSL #16
    MOVK  X25, #0xb8ad, LSL #0
    MOVK  X26, #0x40ee, LSL #48
    MOVK  X26, #0x1883, LSL #32
    MOVK  X26, #0xa96c, LSL #16
    MOVK  X26, #0x9eda, LSL #0
    MOVK  X27, #0x2188, LSL #48
    MOVK  X27, #0x19a5, LSL #32
    MOVK  X27, #0x16d0, LSL #16
    MOVK  X27, #0xeb75, LSL #0
    MOVK  X28, #0x4d80, LSL #48
    MOVK  X28, #0x4117, LSL #32
    MOVK  X28, #0x151a, LSL #16
    MOVK  X28, #0xbe98, LSL #0
    MOVK  X29, #0x2077, LSL #48
    MOVK  X29, #0x39af, LSL #32
    MOVK  X29, #0x93e0, LSL #16
    MOVK  X29, #0xb11b, LSL #0
    SUBS  W13, W11, #0x141
    MOVZ  X18, #0x612d, LSL #0
    MOVK  X18, #0x3f88, LSL #16
    MSR  FPCR, X18
    MRS  X7, FPSR
    MOVZ  X15, #0xff60, LSL #0
    MOVK  X15, #0x7ff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    AND  X7, X7, X15
    MOVZ  X15, #0x0, LSL #0
    ORR  X7, X7, X15
    MSR  FPSR, X7
    ISB  SY
    MOVZ  X2, #0x213e, LSL #0
    MOVK  X2, #0x904d, LSL #16
    MOVK  X2, #0xb5d6, LSL #32
    MOVK  X2, #0xbcf, LSL #48
    MOVZ  X3, #0x2c5a, LSL #0
    MOVK  X3, #0xc4c7, LSL #16
    MOVK  X3, #0x225a, LSL #32
    MOVK  X3, #0xa9c8, LSL #48
    MOVZ  X4, #0x809a, LSL #0
    MOVK  X4, #0xffd0, LSL #16
    MOVK  X4, #0xba21, LSL #32
    MOVK  X4, #0xf826, LSL #48
    MOVZ  X6, #0xa23e, LSL #0
    MOVK  X6, #0xc77a, LSL #16
    MOVK  X6, #0x3d64, LSL #32
    MOVK  X6, #0xd503, LSL #48
    MOVZ  X7, #0x9f31, LSL #0
    MOVK  X7, #0xa963, LSL #16
    MOVK  X7, #0x3c0b, LSL #32
    MOVK  X7, #0x3e3d, LSL #48
    MOVZ  X8, #0xdf, LSL #0
    MOVK  X8, #0x39fc, LSL #16
    MOVK  X8, #0xb611, LSL #32
    MOVK  X8, #0x3c22, LSL #48
    MOVZ  X9, #0x8eed, LSL #0
    MOVK  X9, #0xf584, LSL #16
    MOVK  X9, #0xfff9, LSL #32
    MOVK  X9, #0x1c8b, LSL #48
    MOVZ  X10, #0x4f67, LSL #0
    MOVK  X10, #0x77fd, LSL #16
    MOVK  X10, #0x4fe9, LSL #32
    MOVK  X10, #0xb2d8, LSL #48
    MOVZ  X11, #0xf5d9, LSL #0
    MOVK  X11, #0x3e0, LSL #16
    MOVK  X11, #0xaaa2, LSL #32
    MOVK  X11, #0x7fa, LSL #48
    MOVZ  X12, #0x3de7, LSL #0
    MOVK  X12, #0x7a45, LSL #16
    MOVK  X12, #0xc6ed, LSL #32
    MOVK  X12, #0xc418, LSL #48
    MOVZ  X13, #0xa56, LSL #0
    MOVK  X13, #0xbf38, LSL #16
    MOVK  X13, #0x49d3, LSL #32
    MOVK  X13, #0xe9d4, LSL #48
    MOVZ  X14, #0x4f46, LSL #0
    MOVK  X14, #0xa034, LSL #16
    MOVK  X14, #0xfc05, LSL #32
    MOVK  X14, #0x873d, LSL #48
    MOVZ  X15, #0x3850, LSL #0
    MOVK  X15, #0x80df, LSL #16
    MOVK  X15, #0x6951, LSL #32
    MOVK  X15, #0xf40f, LSL #48
    MOVZ  X16, #0x453e, LSL #0
    MOVK  X16, #0xfff8, LSL #16
    MOVK  X16, #0x6464, LSL #32
    MOVK  X16, #0x2d0c, LSL #48
    MOVZ  X17, #0xc8af, LSL #0
    MOVK  X17, #0x91a1, LSL #16
    MOVK  X17, #0x5c9b, LSL #32
    MOVK  X17, #0x9245, LSL #48
    MOVZ  X18, #0xb5d, LSL #0
    MOVK  X18, #0x5b2b, LSL #16
    MOVK  X18, #0x4e1e, LSL #32
    MOVK  X18, #0x17a6, LSL #48
    MOVZ  X19, #0x72f7, LSL #0
    MOVK  X19, #0xe76b, LSL #16
    MOVK  X19, #0x62b6, LSL #32
    MOVK  X19, #0x78d8, LSL #48
    MOVZ  X20, #0xce9e, LSL #0
    MOVK  X20, #0x3811, LSL #16
    MOVK  X20, #0x1ffa, LSL #32
    MOVK  X20, #0x5d26, LSL #48
    MOVZ  X21, #0x76d, LSL #0
    MOVK  X21, #0x74e, LSL #16
    MOVK  X21, #0x7ce9, LSL #32
    MOVK  X21, #0x258c, LSL #48
    MOVZ  X22, #0xa21a, LSL #0
    MOVK  X22, #0xa497, LSL #16
    MOVK  X22, #0x6d56, LSL #32
    MOVK  X22, #0x2cb, LSL #48
    MOVZ  X23, #0xc25e, LSL #0
    MOVK  X23, #0xd75d, LSL #16
    MOVK  X23, #0x3e4d, LSL #32
    MOVK  X23, #0x7b82, LSL #48
    MOVZ  X24, #0x3da5, LSL #0
    MOVK  X24, #0xc2b, LSL #16
    MOVK  X24, #0x88e9, LSL #32
    MOVK  X24, #0x3579, LSL #48
    MOVZ  X25, #0x258, LSL #0
    MOVK  X25, #0x7bb1, LSL #16
    MOVK  X25, #0xd0be, LSL #32
    MOVK  X25, #0x879e, LSL #48
    MOVZ  X26, #0x5a85, LSL #0
    MOVK  X26, #0x95, LSL #16
    MOVK  X26, #0x2065, LSL #32
    MOVK  X26, #0x8edb, LSL #48
    MOVZ  X27, #0x7507, LSL #0
    MOVK  X27, #0xe7e7, LSL #16
    MOVK  X27, #0x96b, LSL #32
    MOVK  X27, #0x3fd2, LSL #48
    MOVZ  X28, #0x9b80, LSL #0
    MOVK  X28, #0xd778, LSL #16
    MOVK  X28, #0x2b1d, LSL #32
    MOVK  X28, #0x216b, LSL #48
    MOVZ  X29, #0xe9d1, LSL #0
    MOVK  X29, #0x567e, LSL #16
    MOVK  X29, #0x98f3, LSL #32
    MOVK  X29, #0x74c, LSL #48
    FMOV  D0, X11
    FMOV  V0.D[1], X11
    FMOV  D1, X13
    FMOV  V1.D[1], X13
    FMOV  D2, X23
    FMOV  V2.D[1], X4
    FMOV  D3, X3
    FMOV  V3.D[1], X13
    FMOV  D4, X6
    FMOV  V4.D[1], X18
    FMOV  D5, X28
    FMOV  V5.D[1], X25
    FMOV  D6, X29
    FMOV  V6.D[1], X7
    FMOV  D7, X23
    FMOV  V7.D[1], X24
    FMOV  D8, X23
    FMOV  V8.D[1], X11
    FMOV  D9, X21
    FMOV  V9.D[1], X15
    FMOV  D10, X12
    FMOV  V10.D[1], X13
    FMOV  D11, X14
    FMOV  V11.D[1], X22
    FMOV  D12, X4
    FMOV  V12.D[1], X20
    FMOV  D13, X14
    FMOV  V13.D[1], X22
    FMOV  D14, X2
    FMOV  V14.D[1], X4
    FMOV  D15, X21
    FMOV  V15.D[1], X28
    FMOV  D16, X19
    FMOV  V16.D[1], X12
    FMOV  D17, X29
    FMOV  V17.D[1], X23
    FMOV  D18, X19
    FMOV  V18.D[1], X24
    FMOV  D19, X6
    FMOV  V19.D[1], X26
    FMOV  D20, X6
    FMOV  V20.D[1], X14
    FMOV  D21, X28
    FMOV  V21.D[1], X16
    FMOV  D22, X22
    FMOV  V22.D[1], X27
    FMOV  D23, X7
    FMOV  V23.D[1], X6
    FMOV  D24, X16
    FMOV  V24.D[1], X22
    FMOV  D25, X15
    FMOV  V25.D[1], X3
    FMOV  D26, X24
    FMOV  V26.D[1], X26
    FMOV  D27, X10
    FMOV  V27.D[1], X14
    FMOV  D28, X27
    FMOV  V28.D[1], X8
    FMOV  D29, X4
    FMOV  V29.D[1], X24
    FMOV  D30, X12
    FMOV  V30.D[1], X8
    FMOV  D31, X27
    FMOV  V31.D[1], X12
    MOVZ  X12, #0xa, LSL #0
TaishanSimdAddP01_label_0:
    SCVTF  V25.4S, V6.4S, #22
    FCVTMS  S25, S0
    FRINTN  S27, S10
    SCVTF V20.2D, V16.2D, #27
    FRINTX  S10, S30
    SCVTF  V19.4S, V6.4S, #12
    FCVTPU  S15, S0
    FCVTZU S13, S14, #4
    FRINTZ  D21, D0
    FCVTPS  D3, D15
    FCVTAU  D19, D21
    FCVTNU  V17.2D, V19.2D
    FCVTPS  D19, D23
    FCVTPU  V26.2D, V28.2D
    FCVTAU  S15, S26
    FCVTZU  V5.2S, V31.2S
    UCVTF  S3, X2
    SCVTF D10, D16, #60
    FCSEL  D13, D13, D29, AL
    FCVTMS  V2.2S, V24.2S
    FRINTZ  D9, D29
    FRINTI  D18, D28
    FMOV  W18, S30
    FCVTZU  V11.4S, V28.4S, #19
    FCVTZU V0.2D, V3.2D, #51
    FCVTZU  D17, D31
    FCVTNS  V22.2S, V2.2S
    FRINTN  D21, D28
    FRINTZ  H17, H20
    FCVTZS  S7, S26
    FCVTZS  S7, S6
    FRINTZ  H24, H18
    FCVTAU  D30, D28
    FCVTPU  S29, S26
    FRINTI  S1, S0
    FCVTZU  V31.2S, V13.2S, #4
    FRINTZ  D30, D16
    FCVTPS  V22.2D, V19.2D
    FCVTZS  V14.2S, V21.2S
    FCVTPS  S19, S7
    FRINTZ  S0, S8
    FCVTMU  D5, D26
    FRINTM  S13, S22
    FCVTNU  X14, H27
    FRINTI  H19, H9
    FCVTPS  H8, H11
    FCVTZU V31.2D, V30.2D, #26
    FCVTPU  D28, D30
    FRINTX  H27, H7
    FMOV  V3.D[1], X15
    FCVTZU  V31.4S, V5.4S, #29
    FCVTAU  X9, H4
    UCVTF  S10, W4, #2
    FCVTZU D31, D9, #58
    FCVTPU  S27, S27
    FRINTX  S24, S31
    FCVTZU  D15, D8
    FRINTZ  H11, H24
    DUP V12.2D, X25
    FCSEL  H15, H6, H0, EQ
    FCVTZU  D20, D12
    FCVTNS  V27.2S, V12.2S
    FRINTA  H15, H3
    FRINTP  S4, S12
    UCVTF  S3, X29
    FCVTZS  V3.2S, V6.2S, #14
    FCVTAS  S13, S25
    FCVTZS S2, S1, #29
    FCVTZU  V16.4S, V24.4S
    FCVTNS  V3.2D, V6.2D
    FCVTPU  S22, S27
    FCVTZS V6.2D, V12.2D, #22
    UCVTF  V16.2S, V7.2S, #6
    FRINTZ  D5, D16
    SCVTF V24.2D, V25.2D, #43
    UCVTF D11, D17, #59
    FCVTAU  S29, S8
    FCVTZU  D27, D14
    FRINTX  S1, S17
    FMOV  V9.D[1], X13
    FCVTAU  D10, D24
    FCVTNS  S29, S29
    SCVTF  D20, X23
    FCVTMU  S7, S0
    FCVTPS  S29, S0
    FCVTNU  S7, S2
    FRINTI  S4, S0
    UCVTF V12.2D, V6.2D, #64
    SCVTF  D15, D21
    FCVTPS  S29, S13
    FCVTZS  W14, H25, #8
    FCVTZU S11, S1, #17
    FCVTZS S2, S14, #5
    FRINTZ  S21, S21
    FRINTZ  H28, H17
    FCVTZU  D11, D13
    FCVTNU  D5, D3
    FMOV  X4, D28
    SCVTF  D16, D0
    SCVTF V14.2D, V16.2D, #64
    FRINTA  D28, D3
    FRINTX  H17, H11
    FRINTX  H12, H13
    FCVTZU  D11, D2
    UCVTF  D31, D3
    FRINTM  S1, S1
    FCVTAU  D1, D24
    FCVTNS  S12, S30
    UCVTF D12, D24, #44
    SCVTF V22.2D, V11.2D, #29
    SCVTF  V7.2S, V11.2S, #16
    FCVTMU  D16, D20
    FCVTPS  X8, S28
    SCVTF  V4.2S, V0.2S
    UCVTF  V28.2D, V17.2D
    FRINTX  D2, D24
    SCVTF D30, D14, #11
    FRINTZ  H30, H21
    FCVTZS S11, S8, #5
    FRINTI  H8, H6
    FRINTZ  D2, D17
    FCVTMS  V4.2D, V13.2D
    FCVTZS  V20.4S, V21.4S, #29
    FCVTPS  D6, D31
    FCVTZS  S16, S0
    UCVTF D3, D10, #35
    FCVTMS  D23, D10
    SCVTF  S19, S13
    SCVTF  H3, W14, #1
    FRINTI  D31, D6
    FCVTZS  V5.2S, V10.2S, #17
    FCVTAU  D21, D28
    FRINTI  S16, S19
    UCVTF  S1, S19
    FMOV  X20, D13
    FRINTM  S12, S1
    FCVTMS  D12, D13
    FCVTMU  D10, D0
    FCVTNS  S6, S2
    FCVTZS V13.2D, V16.2D, #56
    FCVTPS  S17, S19
    SCVTF  V29.4S, V20.4S
    FCVTNS  X25, H29
    SCVTF V13.2D, V28.2D, #36
    FCVTZU  V17.4S, V0.4S
    FCVTAS  D21, D20
    FCVTNS  V27.2D, V1.2D
    FCVTNS  S31, S13
    UCVTF  D27, D2
    SCVTF D1, D8, #14
    FCVTNS  S31, S5
    SCVTF  V1.2S, V20.2S, #29
    FCVTZU V28.2D, V24.2D, #7
    UCVTF D24, D29, #40
    FCVTZS  W28, S25
    FCVTZS  D31, D28
    FCVTMU  V20.2S, V19.2S
    FCVTZS  D11, D8
    FCVTAU  V8.2D, V15.2D
    FRINTZ  S17, S30
    FCVTPU  S24, S19
    SCVTF  V5.4S, V8.4S
    FRINTA  D31, D24
    FRINTP  D31, D0
    SCVTF S27, S29, #27
    FCVTAS  D8, D13
    FCVTZS S5, S10, #2
    SCVTF D2, D2, #37
    FCVTNU  S29, S24
    FMOV  W24, S31
    DUP V28.2D, X24
    SCVTF  S10, S29
    SCVTF  V6.2S, V26.2S, #11
    SCVTF  D28, D21
    FCVTNS  V7.8H, V6.8H
    FCVTZS S23, S15, #14
    FCVTPU  D7, D28
    FCVTPS  D4, D24
    FRINTI  D28, D13
    UCVTF  V9.4S, V14.4S
    FCSEL  S16, S30, S6, EQ
    FCVTAU  S0, S15
    FCVTAU  D6, D31
    FRINTA  S6, S29
    FMOV  V24.D[1], X23
    FCVTAU  D10, D9
    FRINTZ  S29, S15
    FCVTPS  D6, D20
    FCVTNS  D14, D10
    UCVTF  S20, S3
    SCVTF  S22, X29
    FCVTZU  S2, S7
    FCVTNS  D20, D25
    FCVTAS  S17, S31
    FCVTZS  D4, D22
    FCVTNS  S16, S11
    FRINTI  S0, S25
    FMOV  X23, D29
    FCVTNS  S24, S18
    FRINTZ  S6, S6
    SUBS  X12, X12, #0x1
    B.NE  TaishanSimdAddP01_label_0
    MOVZ  X28, #0x213e, LSL #0
    MOVK  X28, #0x904d, LSL #16
    MOVK  X28, #0xb5d6, LSL #32
    MOVK  X28, #0xbcf, LSL #48
    SUB  X29, X28, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    MOVZ  X4, #0x2c5a, LSL #0
    MOVK  X4, #0xc4c7, LSL #16
    MOVK  X4, #0x225a, LSL #32
    MOVK  X4, #0xa9c8, LSL #48
    SUB  X24, X4, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    MOVZ  X17, #0x2c5a, LSL #0
    MOVK  X17, #0xc4c7, LSL #16
    MOVK  X17, #0x225a, LSL #32
    MOVK  X17, #0xa9c8, LSL #48
    SUB  X8, X17, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    MOVZ  X13, #0xa23e, LSL #0
    MOVK  X13, #0xc77a, LSL #16
    MOVK  X13, #0x3d64, LSL #32
    MOVK  X13, #0xd503, LSL #48
    SUB  X9, X13, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    MOVZ  X21, #0x9f31, LSL #0
    MOVK  X21, #0xa963, LSL #16
    MOVK  X21, #0x3c0b, LSL #32
    MOVK  X21, #0x3e3d, LSL #48
    SUB  X17, X21, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X8, #0x4f67, LSL #0
    MOVK  X8, #0x77fd, LSL #16
    MOVK  X8, #0x4fe9, LSL #32
    MOVK  X8, #0xb2d8, LSL #48
    SUB  X21, X8, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    MOVZ  X18, #0xf5d9, LSL #0
    MOVK  X18, #0x3e0, LSL #16
    MOVK  X18, #0xaaa2, LSL #32
    MOVK  X18, #0x7fa, LSL #48
    SUB  X7, X18, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    MOVZ  X18, #0x3850, LSL #0
    MOVK  X18, #0x80df, LSL #16
    MOVK  X18, #0x6951, LSL #32
    MOVK  X18, #0xf40f, LSL #48
    SUB  X3, X18, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    MOVZ  X16, #0x453e, LSL #0
    MOVK  X16, #0xfff8, LSL #16
    MOVK  X16, #0x6464, LSL #32
    MOVK  X16, #0x2d0c, LSL #48
    SUB  X9, X16, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    MOVZ  X8, #0x3850, LSL #0
    MOVK  X8, #0x80df, LSL #16
    MOVK  X8, #0x6951, LSL #32
    MOVK  X8, #0xf40f, LSL #48
    SUB  X15, X8, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X3, #0x72f7, LSL #0
    MOVK  X3, #0xe76b, LSL #16
    MOVK  X3, #0x62b6, LSL #32
    MOVK  X3, #0x78d8, LSL #48
    SUB  X15, X3, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X19, X27, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0x5a85, LSL #0
    MOVK  X2, #0x95, LSL #16
    MOVK  X2, #0x2065, LSL #32
    MOVK  X2, #0x8edb, LSL #48
    SUB  X4, X2, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X23, D2
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X14, D3
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X29, D4
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X29, D6
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X20, D7
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X17, X28, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X7, D8
    MOVZ  X28, #0x0, LSL #0
    SUB  X17, X28, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X25, V9.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X25, D9
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X17, X27, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X4, D10
    MOVZ  X27, #0x0, LSL #0
    SUB  X17, X27, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X16
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X16, D11
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X16
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X21, V12.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X21, D12
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X22, V13.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X22, D13
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X7, X11, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X6, D14
    MOVZ  X11, #0x0, LSL #0
    SUB  X7, X11, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X9, D15
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X2, D16
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X21, X11, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X12, D17
    MOVZ  X11, #0x0, LSL #0
    SUB  X21, X11, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X17, D18
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X29, D19
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X12, D20
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X24, D21
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X23, D22
    MOVZ  X2, #0x931e, LSL #0
    MOVK  X2, #0x5ce9, LSL #16
    SUB  X3, X2, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X19, X27, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X11, D23
    MOVZ  X27, #0x0, LSL #0
    SUB  X19, X27, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X18, D24
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X20, D25
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X15, D26
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X18, V27.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X14, X22, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X18, D27
    MOVZ  X22, #0x0, LSL #0
    SUB  X14, X22, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X20, D28
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X24, D29
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
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
    FMOV  D0, X19
    FMOV  V0.D[1], X17
    FMOV  D1, X13
    FMOV  V1.D[1], X23
    FMOV  D2, X28
    FMOV  V2.D[1], X7
    FMOV  D3, X12
    FMOV  V3.D[1], X12
    FMOV  D4, X19
    FMOV  V4.D[1], X20
    FMOV  D5, X12
    FMOV  V5.D[1], X27
    FMOV  D6, X26
    FMOV  V6.D[1], X3
    FMOV  D7, X13
    FMOV  V7.D[1], X16
    FMOV  D8, X25
    FMOV  V8.D[1], X29
    FMOV  D9, X6
    FMOV  V9.D[1], X8
    FMOV  D10, X9
    FMOV  V10.D[1], X23
    FMOV  D11, X16
    FMOV  V11.D[1], X15
    FMOV  D12, X17
    FMOV  V12.D[1], X10
    FMOV  D13, X18
    FMOV  V13.D[1], X25
    FMOV  D14, X20
    FMOV  V14.D[1], X28
    FMOV  D15, X20
    FMOV  V15.D[1], X10
    FMOV  D16, X22
    FMOV  V16.D[1], X15
    FMOV  D17, X21
    FMOV  V17.D[1], X28
    FMOV  D18, X24
    FMOV  V18.D[1], X21
    FMOV  D19, X23
    FMOV  V19.D[1], X25
    FMOV  D20, X19
    FMOV  V20.D[1], X28
    FMOV  D21, X10
    FMOV  V21.D[1], X22
    FMOV  D22, X21
    FMOV  V22.D[1], X24
    FMOV  D23, X15
    FMOV  V23.D[1], X25
    FMOV  D24, X19
    FMOV  V24.D[1], X9
    FMOV  D25, X23
    FMOV  V25.D[1], X9
    FMOV  D26, X28
    FMOV  V26.D[1], X24
    FMOV  D27, X2
    FMOV  V27.D[1], X16
    FMOV  D28, X24
    FMOV  V28.D[1], X3
    FMOV  D29, X7
    FMOV  V29.D[1], X16
    FMOV  D30, X11
    FMOV  V30.D[1], X9
    FMOV  D31, X17
    FMOV  V31.D[1], X27
    MOVZ  X18, #0xa, LSL #0
TaishanSimdAddP01_label_83:
    FCVTZU  V21.2S, V16.2S
    FCVTZU  D31, D4
    FCVTPU  H30, H26
    FCVTZU  V9.2S, V29.2S
    FCVTPU  V24.2D, V27.2D
    FCVTZS  D22, D4
    FCVTAS  S21, S10
    FCVTNS  V11.2D, V30.2D
    FRINTX  H1, H28
    FRINTN  D0, D25
    FRINTN  D1, D25
    FRINTP  S9, S31
    FRINTA  H22, H9
    FRINTA  D11, D5
    FRINTP  H1, H0
    FRINTA  H11, H5
    FCVTZU D19, D5, #2
    FCVTZS  W8, S26, #23
    FCVTMU  S3, S19
    FCVTPU  S11, S16
    FCVTMS  S30, S1
    FCSEL  S19, S30, S27, PL
    FCVTPS  V13.2S, V15.2S
    FMOV  W23, S28
    FCVTMS  S18, S26
    DUP V23.2S, W27
    FRINTI  S19, S5
    FCVTPU  S26, S3
    FCVTZU  W14, S16
    FRINTI  D12, D6
    FCVTNS  V24.2S, V13.2S
    FCVTPU  D19, D0
    FCVTNU  V22.2D, V27.2D
    FCVTPU  V24.8H, V8.8H
    FCVTAU  V23.2S, V26.2S
    FCVTZU V16.2D, V21.2D, #5
    FRINTI  S3, S30
    FCVTZU S5, S10, #3
    FRINTN  D24, D14
    FCVTZU  X10, S24
    FCVTMS  V14.2S, V16.2S
    FRINTI  D24, D23
    FCVTMU  W23, H26
    SCVTF  D10, W28
    FCVTPS  D3, D31
    FRINTZ  H30, H30
    FCVTNU  X23, S4
    FCVTNU  V5.2D, V27.2D
    FRINTM  D14, D22
    SCVTF  V18.2S, V26.2S, #26
    FCVTZS  V5.2S, V6.2S, #13
    SCVTF  V27.2D, V16.2D
    FCVTPU  D21, D28
    FRINTN  H24, H7
    FRINTM  H3, H22
    FMOV  W4, S30
    FCVTPU  S31, S20
    FCVTZS  V11.4S, V23.4S, #23
    FCVTNU  S29, S25
    SCVTF  S19, S10
    SCVTF D14, D3, #11
    SCVTF D25, D7, #32
    FRINTZ  H0, H21
    FCVTPU  S22, S23
    FCVTZU  D21, D3
    FCVTZU V0.2D, V7.2D, #28
    FCVTAU  S28, S10
    FRINTI  H2, H20
    FCVTAU  D18, D29
    FCVTZS  V23.2S, V5.2S, #26
    FCVTZU V11.2D, V6.2D, #31
    SCVTF D30, D17, #40
    FMOV  V17.D[1], X29
    FCVTZS  S4, S26
    FCVTZU  D28, D12
    FCVTNS  D9, D22
    UCVTF S12, S13, #13
    FRINTZ  S25, S12
    FCVTMU  S22, S9
    FCVTAS  V31.2D, V11.2D
    FMOV  V13.D[1], X2
    FCVTZS D28, D22, #42
    FRINTI  D24, D11
    FCVTZU  S29, S11
    FRINTX  D31, D8
    FCVTAS  W3, S24
    FCVTNU  V7.2S, V17.2S
    FCVTAS  D3, D31
    FCVTPS  V24.2S, V3.2S
    FCVTZS V15.2D, V0.2D, #48
    FCVTNS  S25, S12
    FCVTNS  S25, S4
    FCVTZS  V19.2S, V13.2S
    FCVTMS  W25, S19
    FRINTM  S11, S21
    FCVTZU S5, S12, #22
    FRINTZ  H7, H29
    FCVTNS  V3.2D, V28.2D
    FCVTZU  D11, D31
    FCVTNS  H27, H18
    SCVTF  V25.2D, V6.2D
    FCVTZU  V26.2D, V7.2D
    UCVTF  V31.2S, V26.2S
    FRINTP  S31, S6
    FCVTNS  D10, D30
    UCVTF  S2, S15
    UCVTF V20.2D, V2.2D, #7
    FCVTZU  V16.2D, V9.2D
    SCVTF D18, D15, #50
    FRINTN  S16, S26
    FCVTMS  S12, S9
    FCVTMS  S16, S2
    UCVTF V29.2D, V3.2D, #49
    FRINTM  S18, S10
    FRINTM  H30, H8
    FRINTP  D15, D10
    FCVTMS  V19.2S, V10.2S
    FCVTZU  V26.2S, V3.2S, #7
    FCVTZU  S7, S16
    FCVTAS  V10.2D, V23.2D
    FCVTZU  V24.2D, V4.2D
    FCVTZS  D26, D6
    FCVTZU S4, S7, #23
    FCVTMU  D9, D10
    UCVTF V18.2D, V1.2D, #6
    FCVTMU  S22, S15
    FCVTPS  D15, D18
    FCVTAS  D4, D31
    UCVTF  V20.4S, V8.4S
    UCVTF  V28.4S, V2.4S
    FCVTZS  D10, D5
    FCVTAU  V8.2D, V23.2D
    FRINTI  S13, S5
    FCVTAS  W21, S19
    FCVTNS  D13, D1
    FCVTMS  V9.2D, V6.2D
    FCVTMS  D22, D27
    FRINTN  S10, S0
    FRINTA  H4, H1
    FRINTX  S1, S24
    UCVTF  D22, D9
    FCVTMS  W23, D9
    FCVTPS  W25, H7
    FRINTP  H6, H13
    FCVTMU  S0, S6
    UCVTF  S30, W3, #11
    FCVTMS  S20, S3
    SCVTF  V31.4S, V17.4S
    FCVTNS  D10, D22
    FCVTZS  D9, D27
    FRINTX  S16, S30
    FRINTP  H9, H3
    FRINTM  D8, D28
    FMOV  X14, D27
    FCVTZS D13, D27, #27
    FCVTMU  H3, H31
    FMOV  X22, D8
    UCVTF  D18, D14
    FCVTPU  H0, H8
    FCVTMU  D22, D12
    FRINTA  S10, S3
    FRINTM  D29, D6
    FCVTZU  V20.4S, V11.4S, #32
    FCVTAU  S1, S6
    UCVTF  D16, W13
    FRINTA  D6, D25
    FCVTAS  X20, S21
    UCVTF  S18, S7
    FRINTM  D4, D14
    UCVTF  H10, W9
    UCVTF  S8, W29
    FCVTAS  D13, D10
    FCVTZU V18.2D, V12.2D, #27
    FCVTZU  V23.2S, V0.2S, #15
    FCVTZS  D14, D26
    FCVTZS D11, D15, #39
    FCVTPU  V8.8H, V27.8H
    FCVTZU  S13, S4
    FCVTAS  D18, D3
    FCVTAU  V25.2S, V3.2S
    FCVTZS V13.2D, V7.2D, #7
    FCVTPU  V13.8H, V8.8H
    FCVTZU  V28.2S, V11.2S, #30
    FCVTMS  V17.4H, V8.4H
    FRINTA  H3, H19
    FRINTM  S3, S21
    FCVTZU S14, S15, #18
    FCVTZU D11, D12, #57
    FRINTN  H26, H6
    FRINTI  H9, H17
    FCVTZU  X3, H2, #61
    UCVTF V26.2D, V20.2D, #46
    FCVTPU  V12.2D, V17.2D
    FCVTPU  V6.8H, V6.8H
    FCVTZS V5.2D, V26.2D, #34
    FMOV  V3.D[1], X28
    FCVTZU D25, D3, #57
    SCVTF  V7.4S, V17.4S
    FCVTNS  D31, D6
    FCVTZS  X15, S8, #22
    SUBS  X18, X18, #0x1
    B.NE  TaishanSimdAddP01_label_83
    MOVZ  X20, #0x0, LSL #0
    SUB  X19, X20, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X6, X29, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X10, X28, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X26, X2, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X10, X3, X9
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X24, X8, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X19, X12, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X3, X28, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X2, X27, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X29
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X8, D2
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X27, X25, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X14, D3
    MOVZ  X25, #0x0, LSL #0
    SUB  X27, X25, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X13, V4.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X13
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X13, D4
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X13
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X24, X15, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X14, D6
    MOVZ  X15, #0x0, LSL #0
    SUB  X24, X15, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X17, D7
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X3, D8
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X4
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    FMOV  X4, D9
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X4
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X2, D10
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X22, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X22, D11
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X3, D12
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X27, V13.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X24, X25, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X27, D13
    MOVZ  X25, #0x0, LSL #0
    SUB  X24, X25, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X6, D14
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X18, V15.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X18, D15
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X27, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X27, D16
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X20, D17
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X27, D18
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X21, V19.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X21
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X21, D19
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X21
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X15, D20
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X9, D21
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X10, D22
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X19, V23.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X19
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X19, D23
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X19
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X12
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X12, D24
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X12
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X24, X20, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X12, D25
    MOVZ  X20, #0x0, LSL #0
    SUB  X24, X20, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X16, D26
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X13, D27
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X10, D28
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X18, D29
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
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
    FMOV  D0, X22
    FMOV  V0.D[1], X27
    FMOV  D1, X28
    FMOV  V1.D[1], X11
    FMOV  D2, X11
    FMOV  V2.D[1], X29
    FMOV  D3, X24
    FMOV  V3.D[1], X26
    FMOV  D4, X10
    FMOV  V4.D[1], X6
    FMOV  D5, X3
    FMOV  V5.D[1], X22
    FMOV  D6, X20
    FMOV  V6.D[1], X28
    FMOV  D7, X6
    FMOV  V7.D[1], X14
    FMOV  D8, X3
    FMOV  V8.D[1], X16
    FMOV  D9, X26
    FMOV  V9.D[1], X28
    FMOV  D10, X21
    FMOV  V10.D[1], X10
    FMOV  D11, X7
    FMOV  V11.D[1], X14
    FMOV  D12, X24
    FMOV  V12.D[1], X11
    FMOV  D13, X22
    FMOV  V13.D[1], X22
    FMOV  D14, X11
    FMOV  V14.D[1], X9
    FMOV  D15, X3
    FMOV  V15.D[1], X20
    FMOV  D16, X15
    FMOV  V16.D[1], X29
    FMOV  D17, X21
    FMOV  V17.D[1], X6
    FMOV  D18, X8
    FMOV  V18.D[1], X29
    FMOV  D19, X29
    FMOV  V19.D[1], X21
    FMOV  D20, X10
    FMOV  V20.D[1], X10
    FMOV  D21, X10
    FMOV  V21.D[1], X4
    FMOV  D22, X6
    FMOV  V22.D[1], X8
    FMOV  D23, X18
    FMOV  V23.D[1], X14
    FMOV  D24, X18
    FMOV  V24.D[1], X25
    FMOV  D25, X9
    FMOV  V25.D[1], X4
    FMOV  D26, X16
    FMOV  V26.D[1], X22
    FMOV  D27, X21
    FMOV  V27.D[1], X27
    FMOV  D28, X2
    FMOV  V28.D[1], X3
    FMOV  D29, X6
    FMOV  V29.D[1], X6
    FMOV  D30, X24
    FMOV  V30.D[1], X7
    FMOV  D31, X9
    FMOV  V31.D[1], X20
    MOVZ  X9, #0xf, LSL #0
TaishanSimdAddP01_label_166:
    FCVTNS  S27, S7
    FCVTMS  V19.2S, V2.2S
    FCVTMU  D23, D23
    FCVTNU  V15.2D, V19.2D
    FCVTZU  V28.4S, V17.4S, #11
    SCVTF  V29.4S, V2.4S, #5
    UCVTF  D26, W20
    FCVTPS  D28, D17
    SCVTF S7, S18, #12
    FCVTZU D24, D19, #63
    FCVTZS S10, S11, #11
    FCVTZS S6, S26, #11
    FMOV  W24, S27
    DUP V10.2S, W20
    SCVTF  V5.4S, V24.4S
    SCVTF  S31, W21
    UCVTF D31, D7, #21
    FCVTZS S30, S31, #27
    FCVTMS  X14, D9
    FMOV  X27, D19
    FRINTA  D30, D28
    FCVTAS  S17, S9
    FRINTM  D25, D23
    FCVTZU S16, S29, #3
    FMOV  X23, D15
    FCVTMS  S18, S21
    FCVTZS V15.2D, V30.2D, #32
    FCVTZU  X21, S22
    FCVTZS D23, D5, #55
    FCVTMU  V2.2S, V9.2S
    FCVTPS  D18, D9
    UCVTF  D3, X4
    FRINTZ  D0, D3
    FCVTPU  X19, S9
    FCVTZS  V29.2S, V30.2S, #1
    FCVTNS  S15, S29
    FCVTPS  D28, D7
    FMOV  V15.D[1], X8
    FCVTNS  S28, S5
    FCVTNS  S23, S10
    SCVTF  D10, D17
    FCVTPS  D17, D9
    FRINTN  H23, H1
    FMOV  W17, S20
    FCVTAU  S24, S30
    FCVTPS  V8.2S, V28.2S
    FCVTNU  V27.2S, V30.2S
    FCVTZU  S9, S8
    FRINTZ  H1, H15
    FCVTMU  D22, D17
    FCVTAS  H23, H2
    FRINTZ  H3, H31
    FCVTAS  X13, D15
    SCVTF  V23.2S, V1.2S, #10
    FCVTMS  X24, H27
    FCVTPS  V27.2S, V20.2S
    FCVTNS  V12.2S, V26.2S
    FCVTZS  D31, D1
    FCVTPS  V0.2D, V23.2D
    FCVTPS  S26, S22
    FRINTA  S20, S2
    FCVTZS  V21.2S, V0.2S
    FCVTMU  D29, D4
    FCVTPS  X18, D7
    FCVTAS  S1, S17
    FRINTZ  S15, S12
    DUP V9.2D, X14
    FCVTNU  D1, D23
    UCVTF D22, D3, #39
    FCVTPS  D26, D10
    FCVTPS  V3.2D, V29.2D
    FCVTAS  S15, S26
    FCVTNU  X2, H13
    SCVTF S3, S0, #30
    FCVTMS  H17, H26
    FMOV  X12, D19
    FCVTMS  V21.4S, V26.4S
    FRINTI  H4, H15
    FRINTA  D2, D15
    FRINTM  S13, S2
    FRINTX  H11, H3
    FCVTPS  V13.2D, V28.2D
    FRINTA  H20, H6
    SCVTF S3, S8, #6
    UCVTF V26.2D, V16.2D, #3
    FCVTMS  D21, D27
    FRINTA  H7, H10
    FRINTP  S2, S13
    FCVTZS  D4, D20
    SCVTF  S4, S28
    FMOV  V8.D[1], X8
    FMOV  W3, S9
    FCVTZU  S4, S29
    FCVTZS D26, D20, #25
    FMOV  V11.D[1], X22
    FCVTZS V0.2D, V31.2D, #31
    FRINTX  D15, D4
    FRINTN  D2, D10
    FCVTAS  S16, S10
    FCVTAS  H3, H20
    FCVTZS  S26, S29
    FCVTAU  D29, D24
    DUP V7.2S, W13
    FCVTNS  S7, S17
    FCVTPU  V3.2S, V22.2S
    FCVTMU  V24.2D, V2.2D
    FRINTA  H22, H2
    SCVTF S23, S30, #28
    UCVTF  D20, D19
    FCVTZS  D11, D31
    FMOV  V6.D[1], X8
    FCVTAS  D28, D12
    FCVTMU  S9, S4
    FCVTZU S17, S12, #1
    FRINTZ  S31, S7
    FRINTN  H31, H23
    FCVTZS D13, D21, #42
    FCVTPS  X21, D23
    UCVTF S3, S20, #3
    FRINTA  D8, D19
    DUP V19.16B, W2
    FMOV  X10, V0.D[1]
    FCVTZU  W8, S14
    UCVTF  S30, X29, #34
    FRINTZ  S9, S30
    FCVTZU  V4.4S, V18.4S, #32
    FCVTZU V2.2D, V30.2D, #47
    UCVTF  V16.4S, V2.4S
    FCVTPS  D13, D8
    FCVTPU  D28, D30
    FCVTZU D22, D23, #39
    FRINTN  D27, D5
    SCVTF  V5.4S, V22.4S, #4
    FRINTN  D28, D23
    FCVTZS V30.2D, V26.2D, #61
    UCVTF  V6.2S, V12.2S, #24
    FCVTAS  X23, H2
    FCVTZU D8, D6, #6
    FCVTZS  V3.2S, V8.2S, #26
    FRINTX  D0, D28
    FRINTP  S28, S5
    FCVTAU  D26, D21
    FCVTZU V29.2D, V23.2D, #49
    FCVTAU  W22, S31
    FRINTZ  D28, D3
    UCVTF S10, S31, #19
    FCVTPU  V30.2D, V13.2D
    DUP V6.2S, W7
    UCVTF  V22.2S, V10.2S, #15
    UCVTF  D12, D0
    FCVTPU  X16, H26
    UCVTF  H27, X16, #34
    FMOV  X24, D26
    FCVTZU  S2, S18
    FCVTZS  D2, D23
    FCVTZS D1, D12, #44
    UCVTF  D9, X16
    FRINTA  H29, H14
    FCVTAS  D9, D5
    FCVTAU  V23.2S, V19.2S
    SCVTF V5.2D, V31.2D, #23
    SCVTF D21, D27, #24
    FRINTA  S23, S12
    UCVTF  V29.2S, V25.2S, #29
    FCVTPS  V24.2S, V6.2S
    UCVTF S4, S6, #12
    FCVTZS D14, D28, #64
    FCVTAU  D19, D6
    FCVTAS  D30, D3
    FCVTNU  S15, S23
    FRINTZ  D0, D1
    FRINTM  D23, D15
    FCVTNU  D21, D8
    FCVTNS  V15.4S, V14.4S
    FCVTAU  D25, D27
    FCVTNU  S2, S3
    FCVTMU  S24, S30
    FRINTA  S23, S9
    FCVTAS  V25.2D, V30.2D
    FCVTMU  D25, D0
    FCVTZU  D2, D25
    FCVTNS  D5, D22
    FCVTZU S8, S3, #18
    FCVTNU  H23, H3
    FRINTZ  S16, S19
    UCVTF  V30.4S, V0.4S
    FCVTMU  V31.2D, V5.2D
    FCVTAS  D0, D18
    FRINTI  H1, H2
    FCVTZS  V27.2S, V25.2S, #27
    FCVTZU  X3, D3
    FCVTNU  D26, D18
    FCVTMU  X16, H7
    FCVTNS  S26, S27
    FRINTN  H22, H19
    FCVTNS  V27.4S, V9.4S
    FRINTA  D18, D23
    FCVTZS  V21.4S, V18.4S
    FRINTZ  D8, D15
    FCVTNU  V14.4S, V28.4S
    SUBS  X9, X9, #0x1
    B.NE  TaishanSimdAddP01_label_166
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X2
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X3, X14, X3
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X22, X24, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X3, X17, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X2, X22, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X6, X24, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X10
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X10, X6, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X4, X20, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X13, X24, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X26, X29, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X4, X24, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X28, X4, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X20, X22, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X21, X24, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X20, X22, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X19, X7, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X20
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X20, D2
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X20
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X27, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X27, D3
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X21, V4.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X21
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X21, D4
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0x497f, LSL #16
    SUB  X14, X17, X21
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X10, X24, X17
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X17, D6
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X10, X24, X17
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X13, X18, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X6, D7
    MOVZ  X18, #0x0, LSL #0
    SUB  X13, X18, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X10, X3, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X13, D8
    MOVZ  X3, #0x0, LSL #0
    SUB  X10, X3, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X13, D9
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X6, D10
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X20
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X20, D11
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X20
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X10, D12
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X11, D13
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X29, D14
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X25, V15.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X25, D15
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X24, D16
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X2, X27, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X16, D17
    MOVZ  X27, #0x0, LSL #0
    SUB  X2, X27, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X4, D18
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X8, D19
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X8, D20
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X2, D21
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X12, D22
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X25, V23.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X25, D23
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X22, V24.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X22, D24
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X9, D25
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X12, X9, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X27, D26
    MOVZ  X9, #0x0, LSL #0
    SUB  X12, X9, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X4, D27
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X3, X25, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X14, D28
    MOVZ  X25, #0x0, LSL #0
    SUB  X3, X25, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X18, D29
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0xf2c2, LSL #0
    MOVK  X2, #0xcf6d, LSL #16
    MOVK  X2, #0x41c1, LSL #32
    MOVK  X2, #0x71d4, LSL #48
    MOVZ  X3, #0x527f, LSL #0
    MOVK  X3, #0x2295, LSL #16
    MOVK  X3, #0xd55a, LSL #32
    MOVK  X3, #0x3eb7, LSL #48
    MOVZ  X4, #0x47b4, LSL #0
    MOVK  X4, #0x7185, LSL #16
    MOVK  X4, #0x55ba, LSL #32
    MOVK  X4, #0x2635, LSL #48
    MOVZ  X6, #0xb469, LSL #0
    MOVK  X6, #0x5a2, LSL #16
    MOVK  X6, #0x9b3a, LSL #32
    MOVK  X6, #0x9d64, LSL #48
    MOVZ  X7, #0x9b2f, LSL #0
    MOVK  X7, #0xc0c2, LSL #16
    MOVK  X7, #0x21db, LSL #32
    MOVK  X7, #0x76d4, LSL #48
    MOVZ  X8, #0xfe29, LSL #0
    MOVK  X8, #0xd212, LSL #16
    MOVK  X8, #0x1024, LSL #32
    MOVK  X8, #0x3d80, LSL #48
    MOVZ  X9, #0x899b, LSL #0
    MOVK  X9, #0x5a3f, LSL #16
    MOVK  X9, #0xe134, LSL #32
    MOVK  X9, #0x7901, LSL #48
    MOVZ  X10, #0xb663, LSL #0
    MOVK  X10, #0x2b5c, LSL #16
    MOVK  X10, #0xe8ec, LSL #32
    MOVK  X10, #0x247c, LSL #48
    MOVZ  X11, #0x43c5, LSL #0
    MOVK  X11, #0xf33a, LSL #16
    MOVK  X11, #0xb484, LSL #32
    MOVK  X11, #0xe2e1, LSL #48
    MOVZ  X12, #0x298c, LSL #0
    MOVK  X12, #0x7a4f, LSL #16
    MOVK  X12, #0x30bf, LSL #32
    MOVK  X12, #0x931f, LSL #48
    MOVZ  X13, #0xff62, LSL #0
    MOVK  X13, #0x6aa9, LSL #16
    MOVK  X13, #0x8d0d, LSL #32
    MOVK  X13, #0x6a85, LSL #48
    MOVZ  X14, #0xd7e3, LSL #0
    MOVK  X14, #0x6bea, LSL #16
    MOVK  X14, #0x5515, LSL #32
    MOVK  X14, #0xfbbc, LSL #48
    MOVZ  X15, #0x6a5b, LSL #0
    MOVK  X15, #0xaae1, LSL #16
    MOVK  X15, #0xea39, LSL #32
    MOVK  X15, #0xd40c, LSL #48
    MOVZ  X16, #0x9739, LSL #0
    MOVK  X16, #0x4333, LSL #16
    MOVK  X16, #0x2c21, LSL #32
    MOVK  X16, #0x4172, LSL #48
    MOVZ  X17, #0xc306, LSL #0
    MOVK  X17, #0x4570, LSL #16
    MOVK  X17, #0xe68d, LSL #32
    MOVK  X17, #0x84fa, LSL #48
    MOVZ  X18, #0x1568, LSL #0
    MOVK  X18, #0xccf4, LSL #16
    MOVK  X18, #0x49a2, LSL #32
    MOVK  X18, #0x82ec, LSL #48
    MOVZ  X19, #0xc27d, LSL #0
    MOVK  X19, #0xfc65, LSL #16
    MOVK  X19, #0xb78c, LSL #32
    MOVK  X19, #0x4ffe, LSL #48
    MOVZ  X20, #0xa2ea, LSL #0
    MOVK  X20, #0x2de6, LSL #16
    MOVK  X20, #0xa234, LSL #32
    MOVK  X20, #0x95d1, LSL #48
    MOVZ  X21, #0x8f69, LSL #0
    MOVK  X21, #0x5549, LSL #16
    MOVK  X21, #0x5ae, LSL #32
    MOVK  X21, #0x6866, LSL #48
    MOVZ  X22, #0x889f, LSL #0
    MOVK  X22, #0x4226, LSL #16
    MOVK  X22, #0xe158, LSL #32
    MOVK  X22, #0x5efe, LSL #48
    MOVZ  X23, #0x2645, LSL #0
    MOVK  X23, #0x839a, LSL #16
    MOVK  X23, #0xd3e1, LSL #32
    MOVK  X23, #0xc71b, LSL #48
    MOVZ  X24, #0x71b0, LSL #0
    MOVK  X24, #0xb6a3, LSL #16
    MOVK  X24, #0x4fc7, LSL #32
    MOVK  X24, #0x9338, LSL #48
    MOVZ  X25, #0xfff9, LSL #0
    MOVK  X25, #0x4fd7, LSL #16
    MOVK  X25, #0x960d, LSL #32
    MOVK  X25, #0x4008, LSL #48
    MOVZ  X26, #0x8685, LSL #0
    MOVK  X26, #0xd00d, LSL #16
    MOVK  X26, #0xa07, LSL #32
    MOVK  X26, #0x8f3d, LSL #48
    MOVZ  X27, #0x4c62, LSL #0
    MOVK  X27, #0x9121, LSL #16
    MOVK  X27, #0x3d1, LSL #32
    MOVK  X27, #0x4e38, LSL #48
    MOVZ  X28, #0x85ad, LSL #0
    MOVK  X28, #0x9128, LSL #16
    MOVK  X28, #0x79ae, LSL #32
    MOVK  X28, #0xa5ae, LSL #48
    MOVZ  X29, #0xa2a, LSL #0
    MOVK  X29, #0xda25, LSL #16
    MOVK  X29, #0x94e0, LSL #32
    MOVK  X29, #0xfcb, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X22
    FMOV  D1, X27
    FMOV  V1.D[1], X9
    FMOV  D2, X26
    FMOV  V2.D[1], X28
    FMOV  D3, X29
    FMOV  V3.D[1], X22
    FMOV  D4, X25
    FMOV  V4.D[1], X12
    FMOV  D5, X7
    FMOV  V5.D[1], X16
    FMOV  D6, X16
    FMOV  V6.D[1], X20
    FMOV  D7, X4
    FMOV  V7.D[1], X10
    FMOV  D8, X16
    FMOV  V8.D[1], X25
    FMOV  D9, X25
    FMOV  V9.D[1], X18
    FMOV  D10, X20
    FMOV  V10.D[1], X22
    FMOV  D11, X10
    FMOV  V11.D[1], X18
    FMOV  D12, X3
    FMOV  V12.D[1], X25
    FMOV  D13, X22
    FMOV  V13.D[1], X15
    FMOV  D14, X22
    FMOV  V14.D[1], X22
    FMOV  D15, X22
    FMOV  V15.D[1], X21
    FMOV  D16, X17
    FMOV  V16.D[1], X11
    FMOV  D17, X6
    FMOV  V17.D[1], X28
    FMOV  D18, X22
    FMOV  V18.D[1], X8
    FMOV  D19, X21
    FMOV  V19.D[1], X17
    FMOV  D20, X24
    FMOV  V20.D[1], X27
    FMOV  D21, X15
    FMOV  V21.D[1], X29
    FMOV  D22, X28
    FMOV  V22.D[1], X22
    FMOV  D23, X10
    FMOV  V23.D[1], X21
    FMOV  D24, X17
    FMOV  V24.D[1], X21
    FMOV  D25, X17
    FMOV  V25.D[1], X9
    FMOV  D26, X9
    FMOV  V26.D[1], X19
    FMOV  D27, X7
    FMOV  V27.D[1], X8
    FMOV  D28, X6
    FMOV  V28.D[1], X11
    FMOV  D29, X17
    FMOV  V29.D[1], X12
    FMOV  D30, X19
    FMOV  V30.D[1], X7
    FMOV  D31, X17
    FMOV  V31.D[1], X26
    MOVZ  X8, #0xa, LSL #0
TaishanSimdAddP01_label_248:
    FCVTZU V25.2D, V21.2D, #34
    SCVTF  D11, X18
    FCVTZU  X17, D12, #48
    FRINTZ  D16, D29
    UCVTF  V10.4S, V12.4S
    FCVTPS  S11, S27
    FMOV  W12, S4
    FCVTPU  V30.2S, V26.2S
    SCVTF  V26.4S, V16.4S, #2
    FRINTZ  H21, H0
    SCVTF  V19.2S, V12.2S, #17
    UCVTF D23, D14, #55
    FRINTP  D3, D15
    FCVTAS  W19, S1
    FCVTZS  S2, S31
    UCVTF S15, S1, #15
    FRINTI  S16, S3
    FCVTNU  V8.2D, V0.2D
    UCVTF  D13, D3
    FCVTZS  V13.4S, V28.4S, #6
    FCVTPS  W15, S18
    FCVTPU  S28, S24
    FMOV  X20, V11.D[1]
    FMOV  V7.D[1], X12
    FCVTZS S28, S7, #19
    FMOV  X12, D6
    FRINTA  H29, H28
    FCVTMU  D13, D23
    DUP V11.4H, W17
    SCVTF S18, S14, #16
    FCVTPU  V3.2S, V26.2S
    UCVTF D20, D10, #11
    FCVTPU  D16, D8
    FCVTAU  S10, S1
    SCVTF V3.2D, V5.2D, #23
    FCVTMS  S28, S29
    FCVTPU  S19, S19
    FCVTZU S13, S28, #21
    FCVTPS  S29, S11
    FCVTAU  D5, D11
    FCVTMS  V1.2D, V30.2D
    FRINTZ  D18, D24
    FCVTPS  D16, D6
    FCVTMU  S18, S6
    FCVTZU  S2, S30
    FRINTI  S30, S9
    UCVTF  S22, S11
    FCVTZU  V29.4S, V2.4S, #17
    FCVTPS  D11, D6
    FCVTPU  V28.4S, V16.4S
    FCVTNS  V9.4S, V18.4S
    SCVTF  H8, W20, #2
    FCVTZU  S23, S1
    FCVTNS  X9, H15
    FCVTNS  S20, S16
    FCVTPU  W6, S11
    FCVTZU S5, S2, #16
    FCVTNU  W3, S17
    FCVTAS  W3, H30
    FCVTPS  W21, D3
    UCVTF  D13, D7
    UCVTF  D20, D30
    FMOV  X24, D8
    FCVTAS  D15, D29
    FCVTAU  V13.4S, V3.4S
    DUP V6.2S, W20
    FRINTP  S12, S3
    FCVTZS D8, D6, #7
    FRINTP  H9, H3
    FCVTZS D30, D0, #60
    SCVTF  D16, D24
    FCVTNS  H15, H23
    FRINTP  S18, S21
    FRINTI  S3, S16
    FCVTNS  D31, D27
    FCVTMS  S9, S20
    UCVTF  D7, D1
    FRINTN  H7, H6
    SCVTF D7, D7, #51
    FRINTI  S12, S3
    FRINTN  H29, H4
    FRINTX  D13, D1
    SCVTF  D11, D13
    FCVTZU  V27.2S, V7.2S
    FCVTMU  D20, D7
    FRINTP  H20, H11
    FCVTZS D15, D9, #61
    FCVTAS  V8.4S, V18.4S
    FMOV  V19.D[1], X23
    FCVTAU  D22, D29
    FCVTPS  S29, S0
    SCVTF V18.2D, V31.2D, #24
    FCVTZS  S4, S3
    SCVTF D14, D1, #14
    FCVTZS  V4.8H, V18.8H, #8
    FCVTPU  V1.4S, V24.4S
    SCVTF S27, S5, #13
    FCVTZU  S10, S14
    UCVTF  D1, X14
    FCVTZS  X27, H3, #15
    FCVTNU  D24, D16
    FCVTAU  V9.2S, V6.2S
    FRINTA  S24, S25
    FRINTM  S8, S5
    FCVTMS  W29, S27
    FCVTZS  D24, D3
    FCVTNS  V31.2D, V1.2D
    FCVTPU  X22, D2
    FRINTZ  S4, S7
    FCVTPU  V28.2S, V22.2S
    UCVTF  S19, S16
    FCVTAU  S8, S29
    FRINTX  H14, H4
    FCVTZU S28, S6, #13
    FCVTMU  V3.2S, V2.2S
    FRINTM  H7, H22
    UCVTF  S19, S22
    FRINTZ  H2, H9
    FCVTPU  S27, S14
    FCVTZS  V26.2S, V13.2S
    FCVTNS  D31, D30
    FCVTZU  V2.2S, V8.2S, #16
    FRINTM  S4, S22
    UCVTF  V23.2S, V28.2S
    FCVTNU  V22.4S, V0.4S
    FCVTMU  S31, S20
    FRINTN  H29, H15
    FCVTPS  V13.2S, V4.2S
    FCVTMS  V0.2S, V13.2S
    FCVTPS  V20.8H, V29.8H
    FCVTPS  S0, S5
    FRINTM  D13, D20
    FRINTP  H9, H5
    FCVTAU  V16.2S, V27.2S
    FRINTZ  S21, S24
    FCVTZU  S23, S16
    FCVTAS  W23, H29
    FRINTZ  H22, H30
    FCVTZU D11, D15, #55
    FRINTP  H19, H30
    DUP V23.4H, W8
    FRINTX  D2, D27
    FCVTZU V0.2D, V26.2D, #56
    UCVTF  D19, X22
    FCVTMU  V13.2D, V17.2D
    SCVTF S6, S10, #25
    FCVTZU  H11, H2
    FRINTI  H9, H12
    UCVTF S14, S11, #2
    FCVTZU V28.2D, V5.2D, #57
    FCVTMS  D4, D19
    SCVTF  H2, X2, #44
    FCVTMU  W21, H31
    SCVTF  V0.2S, V29.2S, #9
    FCVTMU  S27, S22
    FCVTPU  D4, D12
    FRINTZ  D6, D4
    FCVTZS  V21.4S, V13.4S, #24
    FCVTPS  V10.4S, V11.4S
    FCVTAS  V13.2D, V26.2D
    UCVTF  V22.2S, V10.2S
    FCVTZS  V17.4S, V5.4S, #13
    FRINTP  S12, S5
    FCVTAU  X26, H19
    FCSEL  H12, H13, H22, HI
    FCVTAS  D2, D12
    UCVTF S26, S28, #22
    FCVTNS  V26.2D, V9.2D
    FCVTAU  D1, D28
    DUP V0.2D, X25
    UCVTF  V14.2D, V20.2D
    SCVTF  H21, W10
    FRINTI  S30, S22
    FCVTPS  V5.8H, V3.8H
    FCVTAU  H23, H25
    FCVTPS  V14.2D, V25.2D
    FRINTX  S6, S12
    FRINTZ  S16, S5
    FRINTX  D8, D30
    UCVTF  V28.2S, V2.2S, #3
    FCVTMU  X16, S13
    FCSEL  S14, S25, S16, LE
    FRINTM  S0, S3
    FRINTX  D22, D12
    FCVTNS  D5, D27
    UCVTF  S23, W8
    FCVTNS  V26.4H, V29.4H
    FMOV  X29, D21
    FCVTPU  S15, S5
    FCVTZS D26, D21, #24
    FCVTZU D15, D18, #44
    FCVTZU  S26, S20
    FCVTZS  D23, D3
    UCVTF  D18, W25, #7
    FRINTI  H18, H23
    UCVTF  S24, S10
    FCVTAU  D2, D6
    FMOV  W26, S6
    FCVTNS  D1, D15
    FRINTP  S2, S24
    SUBS  X8, X8, #0x1
    B.NE  TaishanSimdAddP01_label_248
    MOVZ  X8, #0xf2c2, LSL #0
    MOVK  X8, #0xcf6d, LSL #16
    MOVK  X8, #0x41c1, LSL #32
    MOVK  X8, #0x71d4, LSL #48
    SUB  X7, X8, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    MOVZ  X23, #0x47b4, LSL #0
    MOVK  X23, #0x7185, LSL #16
    MOVK  X23, #0x55ba, LSL #32
    MOVK  X23, #0x2635, LSL #48
    SUB  X12, X23, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    MOVZ  X21, #0xf2c2, LSL #0
    MOVK  X21, #0xcf6d, LSL #16
    MOVK  X21, #0x41c1, LSL #32
    MOVK  X21, #0x71d4, LSL #48
    SUB  X12, X21, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X9
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X10, X2, X10
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    MOVZ  X10, #0xff62, LSL #0
    MOVK  X10, #0x6aa9, LSL #16
    MOVK  X10, #0x8d0d, LSL #32
    MOVK  X10, #0x6a85, LSL #48
    SUB  X14, X10, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X15
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X8, #0xf2c2, LSL #0
    MOVK  X8, #0xcf6d, LSL #16
    MOVK  X8, #0x41c1, LSL #32
    MOVK  X8, #0x71d4, LSL #48
    SUB  X27, X8, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X24, X20, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X4, X8, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X12, D2
    MOVZ  X8, #0x0, LSL #0
    SUB  X4, X8, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X29, D3
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X19, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X19
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X19, D4
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X19
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    FMOV  X11, D6
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    FMOV  X4, V7.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X4, D7
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X3
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    FMOV  X3, D8
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X3
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X2, D9
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X7, D10
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X28, D11
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X28, V12.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X28, D12
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X24, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X24, D13
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X13, D14
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X27, V15.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X27
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X27, D15
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X27
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X25, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X2, X29, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X25, D16
    MOVZ  X29, #0x0, LSL #0
    SUB  X2, X29, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X24, D17
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X23, D18
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X28, D19
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X15, D20
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X14, X27, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X9, D21
    MOVZ  X27, #0x7bff, LSL #0
    SUB  X14, X27, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X29, X28, X26
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X26, D22
    MOVZ  X28, #0x0, LSL #0
    SUB  X29, X28, X26
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X10, V23.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X10, D23
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X10, D24
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X9, D25
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X13, D26
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X29, D27
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    FMOV  X16, D28
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    FMOV  X25, V29.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X25, D29
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
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
    FMOV  D0, X7
    FMOV  V0.D[1], X13
    FMOV  D1, X19
    FMOV  V1.D[1], X8
    FMOV  D2, X21
    FMOV  V2.D[1], X4
    FMOV  D3, X28
    FMOV  V3.D[1], X8
    FMOV  D4, X10
    FMOV  V4.D[1], X8
    FMOV  D5, X12
    FMOV  V5.D[1], X24
    FMOV  D6, X18
    FMOV  V6.D[1], X29
    FMOV  D7, X27
    FMOV  V7.D[1], X24
    FMOV  D8, X26
    FMOV  V8.D[1], X23
    FMOV  D9, X25
    FMOV  V9.D[1], X13
    FMOV  D10, X20
    FMOV  V10.D[1], X25
    FMOV  D11, X23
    FMOV  V11.D[1], X21
    FMOV  D12, X19
    FMOV  V12.D[1], X27
    FMOV  D13, X26
    FMOV  V13.D[1], X29
    FMOV  D14, X4
    FMOV  V14.D[1], X26
    FMOV  D15, X27
    FMOV  V15.D[1], X6
    FMOV  D16, X22
    FMOV  V16.D[1], X16
    FMOV  D17, X25
    FMOV  V17.D[1], X25
    FMOV  D18, X9
    FMOV  V18.D[1], X18
    FMOV  D19, X22
    FMOV  V19.D[1], X8
    FMOV  D20, X29
    FMOV  V20.D[1], X3
    FMOV  D21, X28
    FMOV  V21.D[1], X28
    FMOV  D22, X7
    FMOV  V22.D[1], X14
    FMOV  D23, X22
    FMOV  V23.D[1], X15
    FMOV  D24, X19
    FMOV  V24.D[1], X11
    FMOV  D25, X14
    FMOV  V25.D[1], X17
    FMOV  D26, X26
TaishanSimdAddP01_label_115:
    FMOV  V26.D[1], X14
    FMOV  D27, X16
    FMOV  V27.D[1], X9
    FMOV  D28, X29
    FMOV  V28.D[1], X2
    FMOV  D29, X16
    FMOV  V29.D[1], X25
    FMOV  D30, X24
    FMOV  V30.D[1], X4
    FMOV  D31, X16
    FMOV  V31.D[1], X14
    MOVZ  X15, #0xa, LSL #0
TaishanSimdAddP01_label_329:
    FCVTNU  H6, H24
    UCVTF D26, D18, #27
    FCVTMS  S5, S3
    FRINTM  D12, D28
    FCVTZU D19, D28, #54
    SCVTF  S10, S31
    UCVTF S26, S28, #25
    FRINTM  S30, S22
    FCVTAU  S2, S6
    UCVTF  S5, S16
    FCVTNU  D10, D12
    FCVTZU S22, S6, #2
    FCVTPS  S18, S30
    SCVTF  S16, S10
    SCVTF D29, D2, #55
    FCVTNU  V7.2S, V26.2S
    FRINTZ  D21, D21
    FCVTNS  S29, S19
    FCVTZS  D17, D31
    FRINTN  D23, D20
    FCVTMS  W12, D26
    FMOV  V16.D[1], X25
    FCVTAU  X25, S28
    FCVTNS  D17, D5
    FCVTZS  S25, S2
    SCVTF D16, D9, #58
    FRINTI  S11, S18
    FCVTZU D15, D11, #27
    FCVTMU  D19, D23
    SCVTF  S22, W4
    FMOV  X16, D16
    FCVTZU  D9, D17
    FCVTNS  S6, S12
    FCVTZU  V26.4S, V27.4S, #22
    FMOV  V21.D[1], X8
    FCVTNS  V9.4S, V24.4S
    UCVTF V10.2D, V0.2D, #38
    FRINTA  H17, H14
    FCSEL  D0, D4, D20, PL
    FCVTPS  D20, D0
    UCVTF  D16, D2
    FCVTZU V1.2D, V31.2D, #38
    UCVTF D4, D15, #32
    FCVTZS  V14.4S, V19.4S, #2
    FCVTAS  S5, S14
    FCVTZU V0.2D, V14.2D, #25
    FCVTZU V25.2D, V4.2D, #42
    FCVTNU  D6, D3
    UCVTF  V27.2D, V16.2D
    FCVTZU S29, S23, #16
    UCVTF  V3.2D, V17.2D
    FCVTZS  V18.2S, V17.2S, #2
    FRINTM  H16, H26
    SCVTF  D25, D21
    FCVTZS D9, D31, #52
    FCVTZU D15, D6, #54
    FMOV  X2, D27
    FCVTPS  D16, D31
    FRINTM  D19, D23
    FRINTA  S26, S16
    FCVTPU  S14, S9
    FRINTA  H6, H31
    FCVTAU  W10, D13
    FCVTAU  D5, D4
    UCVTF S31, S12, #6
    FCVTAS  S25, S23
    FCVTMS  D10, D5
    FMOV  X29, V15.D[1]
    FCVTZS  D13, D14
    FCSEL  D6, D24, D10, VS
    SCVTF  D0, D16
    FCVTMU  D11, D31
    FCVTPS  V8.4S, V23.4S
    FCVTMU  V9.4S, V26.4S
    FCVTZS  V6.4S, V14.4S, #4
    FCVTZU D25, D16, #19
    FCVTZU  D12, D16
    SCVTF S1, S26, #4
    FMOV  X19, D28
    FCVTZS  V25.2S, V0.2S
    FRINTP  D31, D6
    FCVTZU  W13, D31
    FRINTX  H30, H28
    FCVTMS  S12, S30
    UCVTF  D12, D11
    FCVTMU  X19, D24
    FCVTMS  S6, S13
    FRINTI  S20, S25
    FCVTPS  D11, D12
    FRINTM  S1, S28
    SCVTF  S23, S2
    FRINTN  H17, H26
    UCVTF  S6, S1
    FRINTA  D26, D0
    SCVTF  S28, S14
    FRINTI  S30, S18
    FCVTZU  X23, H10
    FRINTP  H6, H0
    FCVTZS  V11.4S, V26.4S, #28
    FRINTZ  D27, D22
    SCVTF D17, D8, #32
    FCVTPS  S18, S28
    SCVTF  S6, S24
    UCVTF S11, S26, #32
    FCVTNS  V1.2D, V3.2D
    FCVTZS  S18, S12
    FCVTPU  D23, D29
    FRINTA  H0, H15
    UCVTF D9, D10, #25
    FCVTZU  V20.2S, V22.2S
    UCVTF  S0, S30
    UCVTF  D29, W10
    FCVTZU  V30.4H, V15.4H
    FRINTN  S13, S2
    FRINTX  S10, S29
    UCVTF  S9, S13
    FRINTX  D18, D25
    FCVTZS S16, S0, #3
    SCVTF S3, S18, #5
    FCSEL  S22, S16, S18, CS
    FCVTAU  S8, S16
    FCVTNU  S6, S4
    FRINTP  H4, H15
    UCVTF  S22, S1
    SCVTF  V15.2S, V13.2S
    FCVTZS  D25, D10
    FRINTA  D2, D1
    FCVTMS  S0, S28
    FRINTP  S10, S0
    UCVTF V28.2D, V28.2D, #55
    FCVTZS  V16.2S, V0.2S, #1
    FCVTMU  S5, S19
    UCVTF  S10, S31
    UCVTF S18, S30, #15
    FRINTA  H20, H23
    SCVTF V12.2D, V9.2D, #55
    FCVTMU  D31, D25
    UCVTF S13, S29, #13
    FCVTNU  H16, H16
    FCVTAU  D7, D20
    FCVTZS D1, D29, #49
    FCVTPS  S26, S7
    FCVTNU  V27.2D, V22.2D
    FRINTM  H26, H5
    FCVTZU D6, D20, #14
    FRINTA  S29, S28
    FCVTAS  S21, S16
    FRINTM  D12, D10
    FCVTPS  D23, D27
    UCVTF S0, S21, #15
    FRINTP  H5, H12
    FRINTN  D17, D30
    FCVTZU  V26.2S, V10.2S, #30
    FCVTNS  V16.2D, V30.2D
    FCVTNS  D12, D1
    FMOV  V12.D[1], X21
    UCVTF S0, S27, #20
    FRINTZ  S11, S1
    FRINTN  S13, S5
    UCVTF  D22, D9
    FCVTZU V8.2D, V19.2D, #64
    SCVTF  H1, W12
    UCVTF  V6.2S, V15.2S, #14
    UCVTF  V27.4S, V19.4S
    UCVTF  S30, S25
    FCVTZS  V2.4H, V24.4H, #8
    FRINTN  S13, S24
    FCVTPS  D25, D15
    FCVTNS  S20, S25
    FCVTPU  V22.2D, V24.2D
    FCVTZS  S1, S24
    FMOV  X13, D23
    FCVTZS  S13, S23
    FRINTP  H1, H28
    FCVTZS V0.2D, V25.2D, #27
    SCVTF V7.2D, V30.2D, #31
    FCVTMU  S12, S11
    FMOV  W13, S15
    FCVTMS  D18, D4
    SCVTF S1, S23, #16
    FRINTI  S5, S29
    FCVTZS V23.2D, V5.2D, #6
    FCVTPU  D29, D21
    FCVTPS  V15.2S, V8.2S
    FRINTI  S25, S23
    SCVTF  D9, D22
    FMOV  X17, D4
    FCVTAU  S24, S5
    FRINTZ  H24, H24
    FCVTZU S30, S21, #8
    FRINTN  D9, D7
    FCVTAU  X10, D12
    FMOV  X27, V16.D[1]
    FCVTAS  V5.2S, V12.2S
    FRINTI  H24, H28
    FCVTZS  D24, D22
    UCVTF  D20, D9
    FCVTPS  S0, S7
    FCVTZS  V20.2S, V18.2S
    UCVTF D18, D0, #32
    SUBS  X15, X15, #0x1
    B.NE  TaishanSimdAddP01_label_329
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X19, X11, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X22, X27, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X10
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X27, X8, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X19, X28, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X25
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X20, X17, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X23, X17, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X24, X28, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X17
TaishanSimdAddP01_label_328:
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X17, D2
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X18, V3.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X21, X14, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X18, D3
    MOVZ  X14, #0x0, LSL #0
    SUB  X21, X14, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X25, V4.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X17, X20, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X25, D4
    MOVZ  X20, #0x0, LSL #0
    SUB  X17, X20, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X4, D6
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X17, D7
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X27, D8
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X3, D9
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X4, D10
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X14, X29, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X16, D11
    MOVZ  X29, #0x0, LSL #0
    SUB  X14, X29, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X6, D12
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X11, D13
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X25, V14.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X25, D14
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X16, D15
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X15, X6, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X12, D16
    MOVZ  X6, #0x0, LSL #0
    SUB  X15, X6, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X29, X15, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X3, D17
    MOVZ  X15, #0x0, LSL #0
    SUB  X29, X15, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X24, D18
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X8, D19
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X8, D20
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X6, D21
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X26, X9, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X14, D22
    MOVZ  X9, #0x0, LSL #0
    SUB  X26, X9, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X24, D23
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X21, V24.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X27, X19, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X21, D24
    MOVZ  X19, #0x0, LSL #0
    SUB  X27, X19, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X27, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X27, D25
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    FMOV  X12, D26
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X20, D27
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X26, X23, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X10, D28
    MOVZ  X23, #0x0, LSL #0
    SUB  X26, X23, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X26, D29
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
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
    FMOV  D0, X9
    FMOV  V0.D[1], X15
    FMOV  D1, X12
    FMOV  V1.D[1], X24
    FMOV  D2, X22
    FMOV  V2.D[1], X19
    FMOV  D3, X20
    FMOV  V3.D[1], X16
    FMOV  D4, X27
    FMOV  V4.D[1], X26
    FMOV  D5, X8
    FMOV  V5.D[1], X2
    FMOV  D6, X25
    FMOV  V6.D[1], X19
    FMOV  D7, X6
    FMOV  V7.D[1], X15
    FMOV  D8, X9
    FMOV  V8.D[1], X27
    FMOV  D9, X10
    FMOV  V9.D[1], X19
    FMOV  D10, X11
    FMOV  V10.D[1], X16
    FMOV  D11, X9
    FMOV  V11.D[1], X29
    FMOV  D12, X26
    FMOV  V12.D[1], X25
    FMOV  D13, X8
    FMOV  V13.D[1], X29
    FMOV  D14, X6
    FMOV  V14.D[1], X27
    FMOV  D15, X18
    FMOV  V15.D[1], X26
    FMOV  D16, X26
    FMOV  V16.D[1], X18
    FMOV  D17, X8
    FMOV  V17.D[1], X16
    FMOV  D18, X2
    FMOV  V18.D[1], X14
    FMOV  D19, X13
    FMOV  V19.D[1], X21
    FMOV  D20, X14
    FMOV  V20.D[1], X17
    FMOV  D21, X22
    FMOV  V21.D[1], X10
    FMOV  D22, X27
    FMOV  V22.D[1], X27
    FMOV  D23, X11
    FMOV  V23.D[1], X23
    FMOV  D24, X26
    FMOV  V24.D[1], X12
    FMOV  D25, X18
    FMOV  V25.D[1], X4
    FMOV  D26, X15
    FMOV  V26.D[1], X29
    FMOV  D27, X3
    FMOV  V27.D[1], X27
    FMOV  D28, X21
    FMOV  V28.D[1], X21
    FMOV  D29, X10
    FMOV  V29.D[1], X25
    FMOV  D30, X13
    FMOV  V30.D[1], X10
    FMOV  D31, X3
    FMOV  V31.D[1], X28
    MOVZ  X29, #0xf, LSL #0
TaishanSimdAddP01_label_409:
    FCVTZU S23, S22, #32
    FCVTAS  V21.2D, V30.2D
    SCVTF V22.2D, V30.2D, #30
    FCVTZU S6, S31, #22
    FCVTMU  D4, D26
    FCVTZS D25, D28, #13
    FRINTA  H7, H20
    FCVTNU  D31, D25
    FCVTZU  D18, D16
    FRINTZ  D26, D5
    SCVTF  S6, X28, #38
    FCVTAU  S7, S27
    FCVTMU  D29, D22
    SCVTF D5, D1, #5
    FCVTPS  S31, S6
    FCVTPU  S18, S25
    FCVTPS  W16, D23
    FCVTNU  D24, D11
    FRINTI  D17, D18
    FCVTMS  D3, D17
    FCVTZS V31.2D, V19.2D, #52
    FRINTN  D26, D23
    UCVTF  S18, S19
    FRINTA  D8, D5
    FCVTNU  D10, D2
    FRINTN  H30, H3
    FCVTZU  D25, D1
    SCVTF  H20, X7, #51
    FCVTZS  S17, S26
    SCVTF  D17, D14
    FCVTNU  D20, D13
    FCVTMU  V18.2D, V10.2D
    FCVTAU  V18.4S, V16.4S
    FCVTZS  D6, D15
    FCVTZU D12, D2, #38
    FCVTMS  D3, D12
    FCVTNU  D11, D13
    SCVTF  V5.4S, V3.4S, #1
    FCVTAU  X4, H14
    FCVTAU  S30, S14
    FRINTN  S8, S7
    FCVTPU  D6, D2
    FCVTPS  X22, H20
    SCVTF  S12, S15
    FCVTNU  S18, S8
    FCVTMS  V1.4S, V18.4S
    FCVTZS  D3, D14
    FCVTZS  S11, S18
    SCVTF  V1.4S, V27.4S
    FCVTZS  V30.8H, V29.8H, #4
    FCVTNS  V31.8H, V24.8H
    FCVTPU  V18.4S, V4.4S
    FCVTPS  D9, D1
    FCVTMS  V26.4S, V8.4S
    FRINTA  D26, D24
    FRINTN  H31, H28
    FCVTNU  D16, D14
    SCVTF  S28, S11
    FCVTMU  S16, S16
    FCVTPS  D24, D4
    FCVTAU  W4, S1
    SCVTF  V24.2D, V21.2D
    UCVTF D27, D21, #7
    UCVTF S26, S25, #23
    FCVTNS  X8, H9
    FRINTP  H29, H9
    SCVTF  V5.2S, V11.2S
    FCVTZU  S9, S19
    FRINTI  D21, D31
    FRINTZ  D14, D4
    FRINTM  H19, H16
    FCVTMS  S18, S29
    FCVTZU  V10.8H, V13.8H
    FMOV  W18, S28
    FCVTAU  V20.4H, V10.4H
    FCVTNS  S13, S4
    UCVTF  D19, D13
    FCVTAU  D10, D4
    FCVTMU  V5.4S, V29.4S
    FCVTNU  S25, S25
    SCVTF D14, D17, #3
    FCVTNU  W28, S30
    FCVTMU  W13, S26
    FCVTNS  S25, S11
    FCVTZS V5.2D, V20.2D, #9
    FCVTAS  S18, S30
    FRINTM  H6, H9
    SCVTF  D1, X19
    FCVTZS  V6.2D, V31.2D
    FRINTA  D20, D1
    FCVTMS  S6, S28
    FCVTPU  S4, S25
    FCVTMS  W12, H20
    FCVTZU V30.2D, V8.2D, #32
    FMOV  W15, S19
    FCVTZS  V23.2D, V8.2D
    FCVTZU  V30.2D, V20.2D
    FCVTAS  V11.4S, V20.4S
    FCVTPU  V5.2D, V29.2D
    FCVTMU  S29, S14
    FRINTX  S1, S23
    FCSEL  D31, D17, D29, GT
    FRINTP  H30, H6
    FMOV  V25.D[1], X7
    FCVTNU  V4.2D, V20.2D
    FCVTZS  V14.2S, V6.2S
    UCVTF  S23, S27
    FCVTNU  V10.4S, V6.4S
    FMOV  X4, D28
    FCVTPU  V9.2D, V4.2D
    FMOV  W10, S28
    FCVTPU  W20, H29
    FCVTZS  V15.2S, V4.2S, #2
    FCVTNU  S31, S28
    FCVTPU  D6, D15
    FCVTNS  V4.4S, V13.4S
    FCVTMU  V21.4S, V28.4S
    FCVTNS  V17.2D, V0.2D
    FRINTA  H27, H3
    UCVTF  S28, S8
    FCVTZS V21.2D, V3.2D, #37
    FCVTPU  S29, S22
    FCVTZS  W10, D2
    FCVTAU  V22.2S, V30.2S
    FCVTNS  V9.2D, V23.2D
    FCVTZU  V10.2S, V6.2S, #29
    FCVTPS  D5, D2
    UCVTF V2.2D, V0.2D, #55
    FCVTNU  W17, H24
    FCVTMS  V1.2D, V24.2D
    FCVTNU  D20, D6
    FCVTZU  D10, D3
    FCVTNS  S13, S4
    FCVTMU  X4, H24
    UCVTF  V29.4S, V0.4S
    FRINTZ  D2, D14
    UCVTF S12, S3, #22
    FCVTNU  D11, D21
    UCVTF  V31.2S, V21.2S, #6
    FRINTA  D3, D12
    SCVTF  V19.2S, V4.2S, #32
    FRINTP  H23, H30
    FRINTA  S24, S9
    FCVTMU  S28, S29
    UCVTF V15.2D, V9.2D, #30
    SCVTF V3.2D, V6.2D, #34
    FCVTAS  V1.2D, V29.2D
    FCSEL  H22, H12, H12, GT
    FRINTI  H8, H20
    FRINTA  H2, H12
    FCVTZS D17, D19, #6
    UCVTF D1, D9, #52
    FCVTMU  W9, D1
    FCVTAU  D27, D23
    FCVTZS  V31.4S, V7.4S, #24
    FCVTMU  S8, S13
    FCVTPU  V15.2D, V30.2D
    FCVTAU  V29.4S, V20.4S
    FCVTZS  S28, S24
    UCVTF  D2, D23
    SCVTF D4, D15, #52
    FCVTNU  V8.2S, V25.2S
    FRINTP  H14, H17
    FCVTZU  V29.2D, V31.2D
    FCVTNU  X25, D12
    FCVTNU  S27, S17
    FRINTP  D10, D19
    UCVTF V17.2D, V28.2D, #13
    FCVTAU  D9, D8
    FRINTN  S3, S31
    FCVTPU  V16.2D, V2.2D
    FCVTAU  D19, D26
    FCVTZS  V5.4S, V15.4S, #25
    FRINTA  H8, H13
    FCVTPS  H31, H29
    FMOV  V12.D[1], X3
    SCVTF V9.2D, V3.2D, #14
    SCVTF  V18.4S, V23.4S
    FCSEL  D17, D19, D28, LT
    FCVTZU S8, S22, #31
    FCVTAU  V25.4S, V25.4S
    FRINTM  S18, S4
    FCVTAU  V14.2S, V27.2S
    FRINTM  D31, D26
    FCVTZS  V29.2S, V4.2S
    FRINTI  H29, H18
    FCVTAS  D23, D10
    FCVTZS D1, D3, #24
    FCVTNS  S2, S2
    FCVTMS  D26, D11
    FRINTM  S11, S13
    FCVTZU D9, D1, #1
    FCVTNU  V7.2D, V17.2D
    FCVTMU  S17, S12
    FRINTA  H9, H11
    FCVTZU  V10.2S, V12.2S
    FCVTZS  V12.2S, V28.2S, #10
    FCVTZS  D3, D27
    FCVTPU  D27, D25
    FCVTNS  X19, S16
    SUBS  X29, X29, #0x1
    B.NE  TaishanSimdAddP01_label_409
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X6, X12, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X21, X3, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X16, X14, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X16, X23, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X6, X8, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X7, X2, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X25
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X3, X20, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X12, X10, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X29
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X25, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X25, D2
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X25, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X25, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X17, D4
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X28, D6
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X3, X28, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X29, D7
    MOVZ  X28, #0x0, LSL #0
    SUB  X3, X28, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X9, D8
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X11, D9
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X20, X22, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X28, D10
    MOVZ  X22, #0x0, LSL #0
    SUB  X20, X22, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X19, V11.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X19
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X19, D11
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X19
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X21, V12.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X21
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X21, D12
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X21
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X25, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X25, D13
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X28, D14
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X4, X6, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X10, D15
    MOVZ  X6, #0x0, LSL #0
    SUB  X4, X6, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X26, D16
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X14, D17
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X7, D18
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X25, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X25, D19
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X7, D20
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X3, V21.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X3, D21
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X2, D22
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X19, V23.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X19, D23
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X14, D24
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X14, X6, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X28, D25
    MOVZ  X6, #0x0, LSL #0
    SUB  X14, X6, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X9, D26
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X20, D27
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X21, V28.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X21
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X21, D28
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X21
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X4, X24, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X9, D29
    MOVZ  X24, #0x0, LSL #0
    SUB  X4, X24, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0x35a8, LSL #0
    MOVK  X2, #0xf2f0, LSL #16
    MOVK  X2, #0x51d2, LSL #32
    MOVK  X2, #0x3d34, LSL #48
    MOVZ  X3, #0x52c8, LSL #0
    MOVK  X3, #0x5d5, LSL #16
    MOVK  X3, #0x89ec, LSL #32
    MOVK  X3, #0xacd, LSL #48
    MOVZ  X4, #0xfcfd, LSL #0
    MOVK  X4, #0xdc8c, LSL #16
    MOVK  X4, #0x227e, LSL #32
    MOVK  X4, #0xceb9, LSL #48
    MOVZ  X6, #0x6ed9, LSL #0
    MOVK  X6, #0x8040, LSL #16
    MOVK  X6, #0xca06, LSL #32
    MOVK  X6, #0x130, LSL #48
    MOVZ  X7, #0x5660, LSL #0
    MOVK  X7, #0x5da0, LSL #16
    MOVK  X7, #0x4a1, LSL #32
    MOVK  X7, #0xd65e, LSL #48
    MOVZ  X8, #0x7214, LSL #0
    MOVK  X8, #0xaf1f, LSL #16
    MOVK  X8, #0xe49, LSL #32
    MOVK  X8, #0xabb6, LSL #48
    MOVZ  X9, #0x6076, LSL #0
    MOVK  X9, #0xfa96, LSL #16
    MOVK  X9, #0xc66d, LSL #32
    MOVK  X9, #0xd290, LSL #48
    MOVZ  X10, #0xa0dd, LSL #0
    MOVK  X10, #0xb7f0, LSL #16
    MOVK  X10, #0x4057, LSL #32
    MOVK  X10, #0x956b, LSL #48
    MOVZ  X11, #0x1bad, LSL #0
    MOVK  X11, #0x6bf2, LSL #16
    MOVK  X11, #0xc72a, LSL #32
    MOVK  X11, #0xe1f3, LSL #48
    MOVZ  X12, #0x7d74, LSL #0
    MOVK  X12, #0x4987, LSL #16
    MOVK  X12, #0xdb2f, LSL #32
    MOVK  X12, #0x888b, LSL #48
    MOVZ  X13, #0xac2a, LSL #0
    MOVK  X13, #0x3eca, LSL #16
    MOVK  X13, #0xb959, LSL #32
    MOVK  X13, #0x5cf9, LSL #48
    MOVZ  X14, #0xa56c, LSL #0
    MOVK  X14, #0x2571, LSL #16
    MOVK  X14, #0x8c0a, LSL #32
    MOVK  X14, #0x981f, LSL #48
    MOVZ  X15, #0xc205, LSL #0
    MOVK  X15, #0x3847, LSL #16
    MOVK  X15, #0xa641, LSL #32
    MOVK  X15, #0x30f0, LSL #48
    MOVZ  X16, #0xee91, LSL #0
    MOVK  X16, #0x653a, LSL #16
    MOVK  X16, #0xb981, LSL #32
    MOVK  X16, #0xd7ec, LSL #48
    MOVZ  X17, #0x50d9, LSL #0
    MOVK  X17, #0xbec4, LSL #16
    MOVK  X17, #0x34de, LSL #32
    MOVK  X17, #0xf51e, LSL #48
    MOVZ  X18, #0xa079, LSL #0
    MOVK  X18, #0xc686, LSL #16
    MOVK  X18, #0x2319, LSL #32
    MOVK  X18, #0x1095, LSL #48
    MOVZ  X19, #0xe194, LSL #0
    MOVK  X19, #0xfdb6, LSL #16
    MOVK  X19, #0xc27d, LSL #32
    MOVK  X19, #0xae7a, LSL #48
    MOVZ  X20, #0x921a, LSL #0
    MOVK  X20, #0xa0b5, LSL #16
    MOVK  X20, #0x8e82, LSL #32
    MOVK  X20, #0xdff2, LSL #48
    MOVZ  X21, #0xd24f, LSL #0
    MOVK  X21, #0xce5, LSL #16
    MOVK  X21, #0xef4, LSL #32
    MOVK  X21, #0x6b32, LSL #48
    MOVZ  X22, #0x74bc, LSL #0
    MOVK  X22, #0x6a34, LSL #16
    MOVK  X22, #0xf0be, LSL #32
    MOVK  X22, #0xcd2a, LSL #48
    MOVZ  X23, #0xa990, LSL #0
    MOVK  X23, #0x9f0a, LSL #16
    MOVK  X23, #0x2526, LSL #32
    MOVK  X23, #0x4254, LSL #48
    MOVZ  X24, #0x88b4, LSL #0
    MOVK  X24, #0xb6e5, LSL #16
    MOVK  X24, #0xc942, LSL #32
    MOVK  X24, #0xb08d, LSL #48
    MOVZ  X25, #0xe28d, LSL #0
    MOVK  X25, #0xa4b4, LSL #16
    MOVK  X25, #0x5b14, LSL #32
    MOVK  X25, #0xa78b, LSL #48
    MOVZ  X26, #0x415d, LSL #0
    MOVK  X26, #0x890c, LSL #16
    MOVK  X26, #0xc45c, LSL #32
    MOVK  X26, #0x4a0e, LSL #48
    MOVZ  X27, #0xd3cd, LSL #0
    MOVK  X27, #0x9fc1, LSL #16
    MOVK  X27, #0xe112, LSL #32
    MOVK  X27, #0x97e1, LSL #48
    MOVZ  X28, #0x35e5, LSL #0
    MOVK  X28, #0x3ab9, LSL #16
    MOVK  X28, #0x7027, LSL #32
    MOVK  X28, #0xf54a, LSL #48
    MOVZ  X29, #0x12cd, LSL #0
    MOVK  X29, #0x459a, LSL #16
    MOVK  X29, #0x81a7, LSL #32
    MOVK  X29, #0x36fa, LSL #48
    FMOV  D0, X16
    FMOV  V0.D[1], X25
    FMOV  D1, X23
    FMOV  V1.D[1], X23
    FMOV  D2, X20
    FMOV  V2.D[1], X2
    FMOV  D3, X14
    FMOV  V3.D[1], X4
    FMOV  D4, X29
    FMOV  V4.D[1], X12
    FMOV  D5, X14
    FMOV  V5.D[1], X23
    FMOV  D6, X28
    FMOV  V6.D[1], X4
    FMOV  D7, X22
    FMOV  V7.D[1], X13
    FMOV  D8, X25
    FMOV  V8.D[1], X27
    FMOV  D9, X23
    FMOV  V9.D[1], X27
    FMOV  D10, X14
    FMOV  V10.D[1], X7
    FMOV  D11, X27
    FMOV  V11.D[1], X11
    FMOV  D12, X26
    FMOV  V12.D[1], X29
    FMOV  D13, X4
    FMOV  V13.D[1], X8
    FMOV  D14, X17
    FMOV  V14.D[1], X7
    FMOV  D15, X14
    FMOV  V15.D[1], X13
    FMOV  D16, X13
    FMOV  V16.D[1], X22
    FMOV  D17, X3
    FMOV  V17.D[1], X18
    FMOV  D18, X6
    FMOV  V18.D[1], X7
    FMOV  D19, X11
    FMOV  V19.D[1], X11
    FMOV  D20, X27
    FMOV  V20.D[1], X22
    FMOV  D21, X7
    FMOV  V21.D[1], X25
    FMOV  D22, X26
    FMOV  V22.D[1], X22
    FMOV  D23, X27
    FMOV  V23.D[1], X16
    FMOV  D24, X15
    FMOV  V24.D[1], X3
    FMOV  D25, X12
    FMOV  V25.D[1], X26
    FMOV  D26, X28
    FMOV  V26.D[1], X19
    FMOV  D27, X17
    FMOV  V27.D[1], X23
    FMOV  D28, X25
    FMOV  V28.D[1], X25
    FMOV  D29, X7
    FMOV  V29.D[1], X7
    FMOV  D30, X29
    FMOV  V30.D[1], X23
    FMOV  D31, X7
    FMOV  V31.D[1], X2
    MOVZ  X8, #0xa, LSL #0
TaishanSimdAddP01_label_491:
    SCVTF  D4, D3
    FRINTM  D6, D14
    FCVTNS  V27.4S, V31.4S
    SCVTF  V16.4S, V13.4S
    FCVTMS  V24.4S, V4.4S
    UCVTF  V11.2S, V11.2S, #19
    FCVTAS  D24, D18
    FCVTAU  D2, D28
    FRINTX  H0, H9
    FCVTAS  S10, S17
    FCVTPU  S30, S30
    FCVTNS  D0, D16
    DUP V15.2S, W26
    FCVTNS  V24.2S, V7.2S
    FCVTAU  D24, D29
    FCVTZS  H4, H0
    FRINTM  D11, D6
    FRINTM  H15, H25
    FRINTN  S2, S27
    FMOV  W26, S4
    FMOV  W6, S11
    FRINTP  S24, S29
    FRINTP  D2, D19
    UCVTF  S19, X12
    FRINTI  S9, S16
    FCVTZU  D15, D11
    UCVTF  S22, S14
    FCVTZU D7, D12, #56
    FRINTX  S28, S25
    FCVTMS  X24, S3
    FCVTAU  S10, S12
    FCVTPS  D5, D21
    UCVTF V4.2D, V2.2D, #42
    FCVTZU  V24.2D, V13.2D
    FCVTNS  S2, S9
    FCVTZU S26, S27, #15
    FCVTNU  D19, D2
    FCVTZU  V24.2D, V26.2D
    FRINTA  H4, H14
    FMOV  V23.D[1], X12
    FCVTNU  V30.2S, V2.2S
    FCVTZU D30, D22, #6
    FCVTZS D0, D19, #20
    FCVTPS  S6, S29
    UCVTF  S17, S0
    FRINTM  H0, H12
    FCVTNU  V11.2D, V24.2D
    FCVTMS  S24, S7
    FCVTZU  V16.2D, V13.2D
    FRINTM  D22, D6
    SCVTF  D10, D15
    UCVTF  D24, D8
    SCVTF D10, D5, #24
    FCVTMS  V9.4H, V16.4H
    FCVTAU  D29, D10
    FRINTI  S3, S12
    FCVTAU  D11, D12
    FCVTAS  D0, D10
    FCVTZU  S6, S14
    FCVTMU  V19.2D, V18.2D
    FCVTAS  V27.2D, V28.2D
    FCVTZS  V17.2S, V0.2S
    FCVTPU  D31, D3
    FRINTA  H31, H16
    FRINTM  D22, D12
    FCVTAS  D7, D10
    FCVTMU  S30, S3
    UCVTF  D14, D2
    FCVTMU  S12, S18
    FCVTAS  V2.2D, V18.2D
    FRINTP  S31, S7
    FRINTX  S29, S6
    FCVTZS V30.2D, V26.2D, #40
    FCVTAU  S23, S11
    SCVTF  V7.4S, V19.4S, #28
    SCVTF S1, S15, #14
    FRINTM  D17, D25
    FCVTZS V21.2D, V29.2D, #52
    FRINTP  H5, H26
    FRINTP  H10, H13
    FCVTZS V18.2D, V3.2D, #35
    FCVTMU  D18, D9
    SCVTF S22, S14, #21
    FCVTAU  D18, D12
    FCVTZU  D18, D7
    FRINTP  H29, H8
    FCVTZU  S17, S25
    FCVTAU  S27, S6
    FCVTMS  S1, S21
    FCVTMS  S6, S8
    FRINTP  H4, H17
    FCVTNU  S21, S2
    FRINTZ  S16, S16
    FCVTAU  S17, S10
    FRINTN  H22, H14
    FCSEL  H19, H15, H13, LS
    FRINTX  D12, D6
    FCVTZU V27.2D, V6.2D, #16
    FRINTI  S21, S0
    FCVTZU  D1, D0
    FCVTZU  V6.2S, V16.2S, #1
    FCVTZS  V15.2S, V27.2S
    FCVTAS  S13, S27
    UCVTF D31, D15, #6
    SCVTF  D27, D28
    FCVTPU  S28, S16
    UCVTF  V25.2D, V28.2D
    FRINTM  S1, S5
    FCVTZS  W10, S15, #4
    UCVTF  V13.2S, V1.2S, #23
    SCVTF  V0.2S, V26.2S
    FCVTZS  S12, S7
    FCVTZU  S27, S18
    FCVTAU  S12, S28
    FCVTZU  V19.4S, V31.4S
    FCVTNU  X21, H9
    FCVTPS  S8, S28
    FMOV  X3, V2.D[1]
    FCVTAS  S26, S22
    SCVTF  S6, X29, #39
    FCVTPS  X17, H0
    FRINTI  D9, D2
    FCVTZU S25, S28, #31
    FMOV  V10.D[1], X15
    FMOV  W24, S26
    FRINTM  D31, D16
    UCVTF  S18, S25
    DUP V22.2D, X22
    FCVTPU  D26, D0
    FRINTA  D6, D28
    FCVTPU  D22, D8
    FCVTAS  D3, D21
    FCVTAS  S0, S22
    FMOV  V28.D[1], X26
    FCVTZS  S20, S18
    FCVTMU  S18, S15
    FCVTZU D16, D3, #32
    FCVTMS  S28, S26
    FCVTNU  X13, D11
    FRINTA  H19, H22
    UCVTF D1, D1, #13
    UCVTF  D31, D23
    UCVTF S28, S0, #14
    FCVTPU  V10.2D, V15.2D
    FRINTA  D0, D30
    UCVTF D29, D27, #10
    FRINTX  D1, D10
    FCVTMU  D26, D16
    FCVTZU  V8.2D, V10.2D
    FCVTMU  V20.2D, V23.2D
    FCVTNU  S28, S25
    FCVTZS V17.2D, V19.2D, #19
    FCVTAU  V26.8H, V27.8H
    SCVTF  D27, W17
    FCVTZS  S4, S21
    FCVTZU D30, D23, #23
    FRINTM  H7, H29
    FCVTZU V21.2D, V20.2D, #1
    SCVTF  S29, S10
    FRINTZ  D6, D20
    FCVTPS  D1, D24
    FCVTNU  D3, D12
    FCVTMU  D3, D6
    FCVTZU  S29, S0
    FCVTNU  D22, D23
    DUP V11.2D, X4
    FCVTPU  D17, D10
    FRINTX  S7, S23
    UCVTF  S27, X24, #29
    SCVTF  D23, D8
    FRINTZ  D17, D23
    UCVTF  D1, W7
    SCVTF V12.2D, V15.2D, #23
    FRINTN  S12, S23
    FCVTZS  V30.4S, V31.4S, #30
    FMOV  W28, S8
    FCVTAU  H16, H23
    FCVTZS  D7, D1
    FCVTNS  S22, S29
    FCVTZU  D20, D28
    FRINTN  H8, H15
    FRINTM  H18, H14
    FRINTP  D1, D6
    FCVTZS  D19, D0
    FCVTNU  V28.4S, V18.4S
    FCVTMS  H31, H23
    FCVTAU  D29, D16
    FCVTZU  V11.4S, V23.4S
    FCVTMS  V23.4S, V3.4S
    FRINTA  S20, S21
    UCVTF  S18, S19
    DUP V11.4S, W2
    FRINTA  S19, S29
    FRINTZ  D12, D30
    FCSEL  H22, H10, H0, NV
    FCVTMS  V11.2D, V2.2D
    FCVTPU  S0, S14
    UCVTF D29, D15, #8
    SCVTF  V9.4S, V1.4S, #8
    SCVTF S22, S24, #13
    SUBS  X8, X8, #0x1
    B.NE  TaishanSimdAddP01_label_491
    MOVZ  X29, #0x35a8, LSL #0
    MOVK  X29, #0xf2f0, LSL #16
    MOVK  X29, #0x51d2, LSL #32
    MOVK  X29, #0x3d34, LSL #48
    SUB  X21, X29, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X26, X2, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    MOVZ  X28, #0xfcfd, LSL #0
    MOVK  X28, #0xdc8c, LSL #16
    MOVK  X28, #0x227e, LSL #32
    MOVK  X28, #0xceb9, LSL #48
    SUB  X9, X28, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    MOVZ  X11, #0x5660, LSL #0
    MOVK  X11, #0x5da0, LSL #16
    MOVK  X11, #0x4a1, LSL #32
    MOVK  X11, #0xd65e, LSL #48
    SUB  X4, X11, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    MOVZ  X27, #0x5660, LSL #0
    MOVK  X27, #0x5da0, LSL #16
    MOVK  X27, #0x4a1, LSL #32
    MOVK  X27, #0xd65e, LSL #48
    SUB  X10, X27, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    MOVZ  X13, #0xa56c, LSL #0
    MOVK  X13, #0x2571, LSL #16
    MOVK  X13, #0x8c0a, LSL #32
    MOVK  X13, #0x981f, LSL #48
    SUB  X20, X13, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    MOVZ  X15, #0xc205, LSL #0
    MOVK  X15, #0x3847, LSL #16
    MOVK  X15, #0xa641, LSL #32
    MOVK  X15, #0x30f0, LSL #48
    SUB  X14, X15, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    MOVZ  X12, #0xee91, LSL #0
    MOVK  X12, #0x653a, LSL #16
    MOVK  X12, #0xb981, LSL #32
    MOVK  X12, #0xd7ec, LSL #48
    SUB  X25, X12, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X17
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X20, #0xa079, LSL #0
    MOVK  X20, #0xc686, LSL #16
    MOVK  X20, #0x2319, LSL #32
    MOVK  X20, #0x1095, LSL #48
    SUB  X16, X20, X18
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X4, X18, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    MOVZ  X6, #0xa079, LSL #0
    MOVK  X6, #0xc686, LSL #16
    MOVK  X6, #0x2319, LSL #32
    MOVK  X6, #0x1095, LSL #48
    SUB  X2, X6, X20
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    MOVZ  X28, #0x74bc, LSL #0
    MOVK  X28, #0x6a34, LSL #16
    MOVK  X28, #0xf0be, LSL #32
    MOVK  X28, #0xcd2a, LSL #48
    SUB  X7, X28, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    MOVZ  X6, #0xa990, LSL #0
    MOVK  X6, #0x9f0a, LSL #16
    MOVK  X6, #0x2526, LSL #32
    MOVK  X6, #0x4254, LSL #48
    SUB  X29, X6, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X19, X3, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X13, X12, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X26
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    MOVZ  X9, #0x5660, LSL #0
    MOVK  X9, #0x5da0, LSL #16
    MOVK  X9, #0x4a1, LSL #32
    MOVK  X9, #0xd65e, LSL #48
    SUB  X16, X9, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    MOVZ  X22, #0x74bc, LSL #0
    MOVK  X22, #0x6a34, LSL #16
    MOVK  X22, #0xf0be, LSL #32
    MOVK  X22, #0xcd2a, LSL #48
    SUB  X8, X22, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X3, X18, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X22, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X22, D2
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X9, X24, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X6, D3
    MOVZ  X24, #0x0, LSL #0
    SUB  X9, X24, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X6, D4
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X16, D6
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X3, D7
    MOVZ  X8, #0x5660, LSL #0
    MOVK  X8, #0x5da0, LSL #16
    SUB  X13, X8, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X16, D8
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X24, D9
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X9, X29, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X16, D10
    MOVZ  X29, #0x0, LSL #0
    SUB  X9, X29, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X14, X19, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X20, D11
    MOVZ  X19, #0x0, LSL #0
    SUB  X14, X19, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X21, V12.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X21, D12
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X27, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X27, D13
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X28, D14
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X3, V15.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X3
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    FMOV  X3, D15
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X3
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X12, D16
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X25, V17.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X20, X28, X25
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X25, D17
    MOVZ  X28, #0x0, LSL #0
    SUB  X20, X28, X25
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X10, D18
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X6, D19
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    FMOV  X24, D20
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X9, D21
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X13
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X13, D22
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X13
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X20, D23
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X28, D24
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X2, D25
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X24, D26
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X14, D27
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X7, D28
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X26, D29
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
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
    FMOV  D0, X3
    FMOV  V0.D[1], X29
    FMOV  D1, X20
    FMOV  V1.D[1], X2
    FMOV  D2, X21
    FMOV  V2.D[1], X29
    FMOV  D3, X11
    FMOV  V3.D[1], X13
    FMOV  D4, X2
    FMOV  V4.D[1], X28
    FMOV  D5, X23
    FMOV  V5.D[1], X24
    FMOV  D6, X27
    FMOV  V6.D[1], X28
    FMOV  D7, X25
    FMOV  V7.D[1], X17
    FMOV  D8, X26
    FMOV  V8.D[1], X17
    FMOV  D9, X29
    FMOV  V9.D[1], X15
    FMOV  D10, X19
    FMOV  V10.D[1], X6
    FMOV  D11, X26
    FMOV  V11.D[1], X11
    FMOV  D12, X18
    FMOV  V12.D[1], X26
    FMOV  D13, X8
    FMOV  V13.D[1], X17
    FMOV  D14, X27
    FMOV  V14.D[1], X20
    FMOV  D15, X26
    FMOV  V15.D[1], X25
    FMOV  D16, X15
    FMOV  V16.D[1], X10
    FMOV  D17, X7
    FMOV  V17.D[1], X9
    FMOV  D18, X17
    FMOV  V18.D[1], X20
    FMOV  D19, X25
    FMOV  V19.D[1], X10
    FMOV  D20, X9
    FMOV  V20.D[1], X4
    FMOV  D21, X9
    FMOV  V21.D[1], X10
    FMOV  D22, X2
    FMOV  V22.D[1], X17
    FMOV  D23, X21
    FMOV  V23.D[1], X19
    FMOV  D24, X28
    FMOV  V24.D[1], X7
    FMOV  D25, X24
    FMOV  V25.D[1], X24
    FMOV  D26, X3
    FMOV  V26.D[1], X7
    FMOV  D27, X20
    FMOV  V27.D[1], X20
    FMOV  D28, X7
    FMOV  V28.D[1], X8
    FMOV  D29, X9
    FMOV  V29.D[1], X9
    FMOV  D30, X10
    FMOV  V30.D[1], X28
    FMOV  D31, X17
    FMOV  V31.D[1], X14
    MOVZ  X6, #0xa, LSL #0
TaishanSimdAddP01_label_574:
    FCVTNU  D5, D31
    FCVTMU  X20, D24
    FRINTA  H28, H7
    FCVTMS  D12, D1
    SCVTF  V27.2S, V30.2S
    FCSEL  S26, S25, S7, GE
    FMOV  X20, V29.D[1]
    FMOV  W19, S3
    SCVTF S17, S14, #28
    FCVTZS S17, S23, #22
    SCVTF S20, S2, #1
    FCVTZS  S28, S24
    UCVTF D7, D0, #16
    FCVTNU  V10.2S, V2.2S
    FCVTNU  S19, S28
    FCVTPS  D11, D11
    FCSEL  H1, H20, H2, CS
    FCVTNS  D8, D28
    FCVTNU  V16.4S, V2.4S
    FCVTAS  W12, D29
    FRINTN  S30, S2
    FRINTI  H31, H10
    FCSEL  S26, S0, S7, AL
    FCVTAU  S31, S13
    FCVTZS  S16, S3
    FCVTAS  D0, D5
    FCVTMU  D0, D25
    FCVTZS  S10, S18
    FCVTZS  V21.2S, V14.2S, #22
    FCVTZU  D1, D15
    FRINTN  D22, D11
    FRINTP  D30, D22
    SCVTF  V25.2D, V0.2D
    FCVTZS V31.2D, V11.2D, #35
    FRINTP  S19, S31
    UCVTF  D26, W22, #26
    UCVTF V10.2D, V1.2D, #19
    SCVTF  D10, D11
    FCVTZU V15.2D, V10.2D, #54
    FRINTN  D4, D24
    FRINTI  H11, H26
    FCVTPU  D15, D5
    FCVTAS  V18.2D, V22.2D
    FCVTAS  S18, S25
    FCVTAS  S1, S15
    FRINTX  H17, H19
    SCVTF  D0, D31
    FCVTZU  V15.2S, V25.2S, #3
    FCVTNS  V5.2D, V18.2D
    FMOV  V19.D[1], X20
    FRINTN  D7, D17
    UCVTF  V10.2D, V14.2D
    FCVTAS  S22, S20
    FCVTZU D24, D10, #32
    FCVTAU  D13, D0
    FCVTNS  S22, S20
    FCVTZS S18, S6, #27
    FRINTP  S15, S17
    FCVTAU  V10.4S, V18.4S
    FRINTI  H30, H23
    FCVTZS S6, S30, #20
    FRINTI  H30, H20
    FCVTZU  W27, S23, #29
    FCVTNU  D21, D19
    FRINTX  D16, D11
    FCVTAU  X27, D13
    FMOV  X23, D31
    FRINTA  S23, S14
    FCVTZS  V1.4S, V5.4S, #24
    FCVTZS  V17.2S, V18.2S, #27
    FRINTA  D19, D4
    FCVTPS  D19, D15
    FCVTAU  S15, S20
    FCVTNS  V11.2D, V22.2D
    SCVTF  S0, S5
    FCVTPS  V23.4S, V10.4S
    FCVTZU V21.2D, V26.2D, #44
    FCVTZU S28, S1, #5
    FCVTZU D5, D18, #20
    FCVTAU  V6.2S, V4.2S
    FRINTA  D27, D27
    UCVTF S2, S4, #16
    FCVTZS  V7.2S, V11.2S
    FCVTNU  V8.2S, V16.2S
    DUP V21.2D, X20
    FCVTZU  V7.4S, V29.4S
    FCVTNU  D26, D21
    FCVTZU  D0, D16
    FCVTAU  W27, D20
    FCVTMU  S23, S11
    FCVTZS  S26, S29
    FCVTZS S29, S14, #9
    FCVTMS  D1, D10
    FCVTPU  S18, S25
    FCVTZU  D22, D21
    FRINTN  H22, H12
    FRINTX  H28, H10
    FCVTNS  V15.4S, V26.4S
    FCVTPU  S14, S0
    FCVTMS  V20.4S, V26.4S
    FCVTPU  X23, S25
    FCVTMS  V2.4S, V20.4S
    FCVTZS V7.2D, V13.2D, #55
    FCVTZS D18, D8, #52
    FRINTZ  S12, S23
    UCVTF  S12, S30
    FRINTZ  H1, H5
    FCVTPU  V18.2D, V28.2D
    FCVTNU  X22, D26
    FCVTPU  D7, D11
    UCVTF  S24, S17
    FCVTZS V21.2D, V21.2D, #29
    UCVTF D3, D21, #13
    FCVTZU S3, S17, #6
    FCVTPS  D23, D8
    FRINTZ  S30, S16
    FCVTNU  D5, D29
    FRINTM  H0, H17
    FCVTZS V31.2D, V7.2D, #36
    UCVTF V24.2D, V17.2D, #64
    FRINTN  S7, S23
    FCVTAU  S24, S26
    FCVTNS  V16.4S, V26.4S
    FCVTAU  S13, S13
    UCVTF V29.2D, V31.2D, #35
    FCVTMS  D12, D8
    FRINTX  H21, H20
    FCVTPU  D11, D7
    FCVTZU V0.2D, V9.2D, #56
    FCVTZU  V8.4H, V18.4H
    FRINTA  S25, S8
    FCVTPS  D7, D29
    FRINTA  S21, S7
    FRINTN  S14, S28
    FCVTNU  S25, S13
    FCVTMS  V16.4H, V13.4H
    FCVTPS  H14, H15
    UCVTF D3, D20, #62
    FRINTM  H6, H25
    FRINTN  H10, H24
    FRINTX  H16, H11
    FCVTZS  X15, D14, #24
    FCVTPS  V21.2S, V9.2S
    SCVTF V20.2D, V3.2D, #11
    FRINTN  H18, H27
    FRINTA  D1, D13
    FCVTMS  V16.4S, V0.4S
    FRINTX  D10, D1
    SCVTF  D6, D20
    FRINTP  S27, S17
    FCVTAU  S15, S2
    UCVTF S16, S4, #9
    SCVTF V27.2D, V29.2D, #39
    FRINTI  H4, H1
    FCVTZU  D13, D4
    FCVTPU  V5.2S, V3.2S
    FCVTNS  V17.4S, V3.4S
    SCVTF V12.2D, V2.2D, #48
    UCVTF  V9.4S, V8.4S, #23
    SCVTF V31.2D, V0.2D, #34
    UCVTF  V1.2S, V9.2S, #8
    FRINTZ  H24, H18
    FRINTM  D6, D13
    FCVTPU  D10, D6
    FCVTZS  V27.4S, V10.4S, #27
    FCVTZS D5, D20, #14
    FCVTMS  S10, S15
    FCVTNS  D5, D0
    FCVTMS  V5.2S, V3.2S
    FCVTPS  D0, D28
    FCVTZU D10, D31, #60
    FCVTNU  D5, D10
    SCVTF  D25, D31
    FCVTZS  D8, D26
    FCVTAS  W10, S29
    FCVTNS  V20.4S, V21.4S
    SCVTF  V21.4S, V4.4S, #8
    FCVTNS  W29, S26
    FCVTMS  D20, D10
    FCVTZS V15.2D, V4.2D, #58
    FCVTPS  D3, D26
    FCVTZS  V6.4S, V15.4S
    UCVTF V2.2D, V7.2D, #21
    FCVTAS  V24.2D, V31.2D
    FCVTAS  D17, D20
    UCVTF S13, S9, #19
    FCVTMU  D9, D15
    FCVTMS  S0, S27
    FCVTAU  V28.4S, V10.4S
    FRINTM  D25, D4
    FRINTZ  D23, D26
    DUP V16.8B, W20
    FRINTI  D18, D2
    FCVTNS  V18.4S, V13.4S
    FRINTZ  H15, H26
    FCVTPS  S1, S5
    FCVTAS  S29, S7
    FCVTZS  S8, S7
    UCVTF  V14.4S, V21.4S, #20
    FRINTX  H20, H30
    SUBS  X6, X6, #0x1
    B.NE  TaishanSimdAddP01_label_574
    MOVZ  X8, #0x0, LSL #0
    SUB  X6, X8, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X7, X11, X7
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X26, X13, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X4, X8, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X13
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X26, X28, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X18
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X19
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X16, X21, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X24, X23, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X17, X27, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X6, D2
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X21, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X21, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X18, D4
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X7, D6
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X24, D7
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X22, V8.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X22
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X22, D8
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X22
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X24, D9
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X7, D10
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X22, X27, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X24, D11
    MOVZ  X27, #0x0, LSL #0
    SUB  X22, X27, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X11, D12
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
TaishanSimdAddP01_label_374:
    FMOV  X26, D13
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X18, V14.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X18, D14
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X7, D15
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X8, D16
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X19, X26, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X20, D17
    MOVZ  X26, #0x0, LSL #0
    SUB  X19, X26, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X22, D18
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X14, D19
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X28, D20
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X26, X28, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X2, D21
    MOVZ  X28, #0x0, LSL #0
    SUB  X26, X28, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X14, X15, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X28, D22
    MOVZ  X15, #0x0, LSL #0
    SUB  X14, X15, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X4, X20, X27
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X27, D23
    MOVZ  X20, #0x0, LSL #0
    SUB  X4, X20, X27
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X18, X3, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    FMOV  X12, D24
    MOVZ  X3, #0x0, LSL #0
    SUB  X18, X3, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X26, D25
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X7, D26
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X28, X7, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    FMOV  X17, D27
    MOVZ  X7, #0x0, LSL #0
    SUB  X28, X7, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X24, X2, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X25, D28
    MOVZ  X2, #0x0, LSL #0
    SUB  X24, X2, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X13, D29
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
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
    FMOV  D0, X18
    FMOV  V0.D[1], X25
    FMOV  D1, X28
    FMOV  V1.D[1], X29
    FMOV  D2, X21
    FMOV  V2.D[1], X24
    FMOV  D3, X26
    FMOV  V3.D[1], X12
    FMOV  D4, X18
    FMOV  V4.D[1], X26
    FMOV  D5, X21
    FMOV  V5.D[1], X9
    FMOV  D6, X20
    FMOV  V6.D[1], X18
    FMOV  D7, X11
    FMOV  V7.D[1], X10
    FMOV  D8, X16
    FMOV  V8.D[1], X29
    FMOV  D9, X3
    FMOV  V9.D[1], X7
    FMOV  D10, X12
    FMOV  V10.D[1], X3
    FMOV  D11, X23
    FMOV  V11.D[1], X26
    FMOV  D12, X2
    FMOV  V12.D[1], X27
    FMOV  D13, X28
    FMOV  V13.D[1], X2
    FMOV  D14, X3
    FMOV  V14.D[1], X6
    FMOV  D15, X15
    FMOV  V15.D[1], X9
    FMOV  D16, X9
    FMOV  V16.D[1], X19
    FMOV  D17, X17
    FMOV  V17.D[1], X21
    FMOV  D18, X19
    FMOV  V18.D[1], X26
    FMOV  D19, X12
    FMOV  V19.D[1], X4
    FMOV  D20, X21
    FMOV  V20.D[1], X3
    FMOV  D21, X27
    FMOV  V21.D[1], X20
    FMOV  D22, X11
    FMOV  V22.D[1], X19
    FMOV  D23, X10
    FMOV  V23.D[1], X23
    FMOV  D24, X20
    FMOV  V24.D[1], X14
    FMOV  D25, X17
    FMOV  V25.D[1], X11
    FMOV  D26, X13
    FMOV  V26.D[1], X20
    FMOV  D27, X26
    FMOV  V27.D[1], X15
    FMOV  D28, X12
    FMOV  V28.D[1], X12
    FMOV  D29, X4
    FMOV  V29.D[1], X4
    FMOV  D30, X20
    FMOV  V30.D[1], X17
    FMOV  D31, X26
    FMOV  V31.D[1], X12
    MOVZ  X2, #0xf, LSL #0
TaishanSimdAddP01_label_655:
    FCVTNS  X17, D14
    FCVTMU  H22, H9
    SCVTF D22, D21, #6
    FCVTAU  V4.4S, V10.4S
    FRINTI  D21, D19
    FRINTN  H29, H16
    FRINTZ  H0, H20
    FRINTM  D25, D21
    FCVTAS  S3, S20
    FCVTMU  W15, H5
    FRINTZ  S31, S29
    FCVTNS  D12, D24
    FMOV  W14, S4
    FCVTPU  D18, D0
    FRINTN  S26, S18
    FRINTM  H7, H16
    FCVTAU  H9, H17
    UCVTF  S9, S3
    FCVTAS  X7, D9
    FCVTMS  V7.2D, V16.2D
    SCVTF D29, D12, #46
    FRINTA  S25, S0
    FCVTAU  W26, S0
    FRINTP  H12, H19
    FRINTI  D26, D7
    FRINTP  D22, D29
    UCVTF  V25.2S, V0.2S, #10
    UCVTF S30, S10, #22
    FMOV  X11, D6
    FMOV  X25, D9
    FCVTNU  D16, D17
    FCVTZS V24.2D, V12.2D, #60
    SCVTF  V5.2S, V18.2S, #13
    FCVTZU D16, D0, #50
    FMOV  V24.D[1], X12
    SCVTF D5, D31, #14
    FCVTNS  S16, S10
    FCVTNS  S11, S30
    FCVTZU  S25, S14
    UCVTF D4, D31, #55
    FRINTM  S5, S5
    FCVTPS  S24, S7
    FCVTAS  V5.2D, V8.2D
    FCVTPU  X22, H29
    FCVTPU  S2, S22
    FCVTZU  V22.2S, V28.2S, #3
    FRINTI  S26, S10
    FCVTZU  D14, D15
    FCVTPU  D30, D27
    SCVTF D16, D13, #43
    FRINTP  H18, H10
    FRINTI  D18, D7
    SCVTF  S28, X17, #54
    FCVTZU S10, S12, #23
    FCVTMU  D19, D25
    FRINTA  H15, H25
    FCVTAS  V20.4S, V8.4S
    FRINTN  S23, S2
    FRINTP  D30, D27
    FCVTAS  S1, S7
    FCVTMS  V6.2D, V28.2D
    FCVTPU  D26, D9
    FRINTP  D0, D11
    FRINTZ  H27, H14
    UCVTF S19, S7, #29
    FCVTAU  V20.4S, V31.4S
    FCVTPU  D16, D26
    SCVTF  D28, X11
    FCVTMS  D12, D30
    FCVTAU  V20.2D, V27.2D
    SCVTF V17.2D, V30.2D, #21
    FCVTNS  S20, S23
    FCVTAS  D0, D11
    FCVTNU  D12, D1
    FCVTZU  S1, S13
    FRINTM  H26, H3
    FCVTPU  S7, S26
    FMOV  X29, V24.D[1]
    FCVTPU  D1, D8
    FCVTZS D8, D27, #24
    FMOV  X3, D21
    FCVTMS  V24.4S, V8.4S
    FRINTI  S23, S22
    FCVTAU  S20, S5
    FRINTI  H0, H13
    FCVTZU  V9.8H, V23.8H
    FRINTN  S5, S4
    FCVTZS V7.2D, V30.2D, #8
    FCVTPU  W22, D25
    FCSEL  H30, H11, H13, NE
    FCVTNS  S19, S14
    UCVTF  S0, S19
    FCVTZU  S24, S0
    SCVTF D21, D25, #7
    UCVTF  V0.2S, V30.2S
    FCVTNU  D20, D20
    UCVTF  S26, S24
    FCVTNS  X11, H5
    FRINTZ  H18, H11
    FCVTAU  H30, H4
    FCVTPU  W11, H21
    FCVTNS  S30, S18
    FCVTZU  V5.4S, V11.4S
    FRINTN  H8, H8
    UCVTF  D14, D4
    FCVTAU  V17.2D, V28.2D
    FCVTAS  D24, D20
    FCVTZS  V9.2S, V4.2S
    FCVTZS V29.2D, V22.2D, #11
    FCVTZS  V21.4S, V23.4S, #7
    SCVTF  D22, D30
    FCVTNU  D5, D14
    FRINTI  H19, H23
    FCVTZU  V25.2D, V9.2D
    FCVTZS  X19, S31, #46
    UCVTF  S31, W8
    FCVTZS  V9.4S, V3.4S, #27
    FRINTZ  S9, S6
    FCVTZU  S19, S19
    FCVTZS V8.2D, V30.2D, #49
    FCVTZU  D3, D3
    FCVTAS  V13.4S, V14.4S
    FCSEL  S11, S2, S19, VS
    SCVTF  D10, D13
    FCVTZU S4, S11, #30
    FCVTNU  D31, D18
    FCVTNS  D22, D8
    FCVTNU  D30, D7
    FCVTZS V24.2D, V7.2D, #7
    UCVTF V8.2D, V20.2D, #3
    FRINTZ  D5, D12
    FCVTAU  D3, D23
    FCVTZU  S22, S13
    SCVTF  S10, S0
    FCVTAS  V6.2D, V11.2D
    FMOV  X28, V3.D[1]
    FRINTX  D4, D25
    SCVTF  V29.2S, V5.2S
    FCVTAU  V8.4S, V8.4S
    FRINTM  H18, H13
    FCVTZU  V12.2D, V13.2D
    FCVTZS  V29.4S, V6.4S, #8
    FCVTPU  V30.2D, V22.2D
    FRINTI  S3, S9
    FRINTZ  S8, S2
    FCVTAU  D10, D29
    FRINTM  H1, H20
    FRINTP  D16, D0
    FCVTZS  S2, S10
    FCVTMS  S18, S29
    FRINTX  H30, H30
    SCVTF  V11.2D, V7.2D
    FRINTX  H21, H5
    FRINTA  H10, H18
    FCVTZU S16, S6, #29
    FCVTMU  D7, D3
    FCVTMS  W27, D18
    FCVTZS V10.2D, V21.2D, #4
    FRINTA  H7, H3
    FMOV  V22.D[1], X25
    FCVTAS  D10, D19
    FCVTPS  S13, S17
    FRINTX  H22, H22
    FCVTPS  W12, S29
    FRINTN  D31, D14
    FRINTZ  S2, S11
    FCVTPS  S11, S15
    FRINTM  D18, D22
    FCVTNU  S20, S21
    UCVTF  V9.2D, V25.2D
    FCVTZU  X17, D22
    FMOV  W12, S2
    FCVTZU  V30.2S, V11.2S
    FCVTMU  D19, D8
    FRINTX  D9, D1
    FRINTN  D13, D11
    FCVTMS  D29, D10
    SCVTF V7.2D, V13.2D, #19
    FCVTPU  D5, D31
    FRINTI  S1, S10
    FRINTM  H20, H3
    FCVTPU  S30, S5
    SCVTF  V15.4S, V30.4S, #16
    FCVTNU  S16, S5
    FCVTZS  H18, H18
    UCVTF  V29.4S, V8.4S, #12
    FCVTNU  V19.4S, V15.4S
    FRINTX  D11, D16
    FCVTPS  V10.2S, V4.2S
    SCVTF  D29, D10
    FCVTZU V18.2D, V18.2D, #31
    FCVTAS  D23, D21
    SCVTF V13.2D, V2.2D, #14
    UCVTF V7.2D, V4.2D, #18
    FCVTNU  W10, D21
    FCVTMU  S3, S5
    UCVTF D11, D18, #4
    FCVTAU  V5.2S, V1.2S
    FCVTMU  V16.2S, V3.2S
    SCVTF  D10, W6, #4
    SUBS  X2, X2, #0x1
    B.NE  TaishanSimdAddP01_label_655
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X15, X17, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X20, X13, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X14, X27, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X10, X7, X9
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X6, X18, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X22, X29, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X9, X28, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X25, X29, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X6, X29, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X4, X6, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    FMOV  X12, D2
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X2, D3
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X28, D4
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X7, D6
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X16, D7
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X24, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X14, X22, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X24, D8
    MOVZ  X22, #0x0, LSL #0
    SUB  X14, X22, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X10
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X10, D9
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X10
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X14, D10
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xbfb0, LSL #48
    SUB  X12, X8, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X14, D11
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X27, V12.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X27, D12
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X17, V13.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X17, D13
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X17, D14
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    FMOV  X20, D15
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X23, D16
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X2, D17
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X11, X19, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X9, D18
    MOVZ  X19, #0x0, LSL #0
    SUB  X11, X19, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X29, D19
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X10, D20
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X25, V21.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X25, D21
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X3
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X3, D22
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X3
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X17, D23
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X2, D24
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X8, D25
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X29, D26
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X19, V27.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    FMOV  X19, D27
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X26, D28
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X26, D29
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0x1614, LSL #0
    MOVK  X2, #0x504e, LSL #16
    MOVK  X2, #0x61a5, LSL #32
    MOVK  X2, #0x88cb, LSL #48
    MOVZ  X3, #0x1717, LSL #0
    MOVK  X3, #0xdd1b, LSL #16
    MOVK  X3, #0xf143, LSL #32
    MOVK  X3, #0x24db, LSL #48
    MOVZ  X4, #0x98b4, LSL #0
    MOVK  X4, #0xaea8, LSL #16
    MOVK  X4, #0xca5, LSL #32
    MOVK  X4, #0x3031, LSL #48
    MOVZ  X6, #0x7991, LSL #0
    MOVK  X6, #0x4081, LSL #16
    MOVK  X6, #0xbf1e, LSL #32
    MOVK  X6, #0xe314, LSL #48
    MOVZ  X7, #0x37fe, LSL #0
    MOVK  X7, #0xf212, LSL #16
    MOVK  X7, #0x7698, LSL #32
    MOVK  X7, #0xcf96, LSL #48
    MOVZ  X8, #0x49db, LSL #0
    MOVK  X8, #0x2325, LSL #16
    MOVK  X8, #0x8e90, LSL #32
    MOVK  X8, #0x4698, LSL #48
    MOVZ  X9, #0xaa6f, LSL #0
    MOVK  X9, #0xf48e, LSL #16
    MOVK  X9, #0xa2cd, LSL #32
    MOVK  X9, #0x8141, LSL #48
    MOVZ  X10, #0x918f, LSL #0
    MOVK  X10, #0xe097, LSL #16
    MOVK  X10, #0x74cc, LSL #32
    MOVK  X10, #0x2221, LSL #48
    MOVZ  X11, #0x4e0a, LSL #0
    MOVK  X11, #0x6bdd, LSL #16
    MOVK  X11, #0x4c0, LSL #32
    MOVK  X11, #0xa6df, LSL #48
    MOVZ  X12, #0x20ef, LSL #0
    MOVK  X12, #0x2ff8, LSL #16
    MOVK  X12, #0xc12a, LSL #32
    MOVK  X12, #0x119a, LSL #48
    MOVZ  X13, #0x48f4, LSL #0
    MOVK  X13, #0x33b2, LSL #16
    MOVK  X13, #0xa911, LSL #32
    MOVK  X13, #0xe70e, LSL #48
    MOVZ  X14, #0xf428, LSL #0
    MOVK  X14, #0x12b5, LSL #16
    MOVK  X14, #0xfe82, LSL #32
    MOVK  X14, #0x7897, LSL #48
    MOVZ  X15, #0x572c, LSL #0
    MOVK  X15, #0x5538, LSL #16
    MOVK  X15, #0x7ff2, LSL #32
    MOVK  X15, #0x1567, LSL #48
    MOVZ  X16, #0x29ad, LSL #0
    MOVK  X16, #0x9f17, LSL #16
    MOVK  X16, #0x4f1e, LSL #32
    MOVK  X16, #0x34ff, LSL #48
    MOVZ  X17, #0x218b, LSL #0
    MOVK  X17, #0x4d39, LSL #16
    MOVK  X17, #0xa5a4, LSL #32
    MOVK  X17, #0x2731, LSL #48
    MOVZ  X18, #0xb878, LSL #0
    MOVK  X18, #0xa0b, LSL #16
    MOVK  X18, #0xcee8, LSL #32
    MOVK  X18, #0x8bd9, LSL #48
    MOVZ  X19, #0x3ae9, LSL #0
    MOVK  X19, #0xc5d5, LSL #16
    MOVK  X19, #0x92b6, LSL #32
    MOVK  X19, #0xfe1d, LSL #48
    MOVZ  X20, #0x9e33, LSL #0
    MOVK  X20, #0x6aac, LSL #16
    MOVK  X20, #0x7870, LSL #32
    MOVK  X20, #0x1a9b, LSL #48
    MOVZ  X21, #0xb067, LSL #0
    MOVK  X21, #0xf250, LSL #16
    MOVK  X21, #0x2073, LSL #32
    MOVK  X21, #0x49b, LSL #48
    MOVZ  X22, #0x2e4e, LSL #0
    MOVK  X22, #0x36ac, LSL #16
    MOVK  X22, #0xf049, LSL #32
    MOVK  X22, #0xd1df, LSL #48
    MOVZ  X23, #0xce0e, LSL #0
    MOVK  X23, #0xd4e4, LSL #16
    MOVK  X23, #0x126f, LSL #32
    MOVK  X23, #0x6876, LSL #48
    MOVZ  X24, #0xb415, LSL #0
    MOVK  X24, #0xf361, LSL #16
    MOVK  X24, #0x9948, LSL #32
    MOVK  X24, #0xd3e6, LSL #48
    MOVZ  X25, #0x2709, LSL #0
    MOVK  X25, #0x2318, LSL #16
    MOVK  X25, #0x4788, LSL #32
    MOVK  X25, #0xe92a, LSL #48
    MOVZ  X26, #0xc147, LSL #0
    MOVK  X26, #0x499, LSL #16
    MOVK  X26, #0xd7db, LSL #32
    MOVK  X26, #0xdb31, LSL #48
    MOVZ  X27, #0xeba0, LSL #0
    MOVK  X27, #0xb073, LSL #16
    MOVK  X27, #0x5257, LSL #32
    MOVK  X27, #0xa472, LSL #48
    MOVZ  X28, #0x7adc, LSL #0
    MOVK  X28, #0xf885, LSL #16
    MOVK  X28, #0x33d5, LSL #32
    MOVK  X28, #0xf3ce, LSL #48
    MOVZ  X29, #0xf0d0, LSL #0
    MOVK  X29, #0x7a1d, LSL #16
    MOVK  X29, #0x870a, LSL #32
    MOVK  X29, #0xa9b0, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X25
    FMOV  D1, X24
    FMOV  V1.D[1], X14
    FMOV  D2, X23
    FMOV  V2.D[1], X29
    FMOV  D3, X6
    FMOV  V3.D[1], X24
    FMOV  D4, X17
    FMOV  V4.D[1], X7
    FMOV  D5, X15
    FMOV  V5.D[1], X17
    FMOV  D6, X26
    FMOV  V6.D[1], X22
    FMOV  D7, X4
    FMOV  V7.D[1], X6
    FMOV  D8, X12
    FMOV  V8.D[1], X25
    FMOV  D9, X28
    FMOV  V9.D[1], X24
    FMOV  D10, X7
    FMOV  V10.D[1], X2
    FMOV  D11, X11
    FMOV  V11.D[1], X29
    FMOV  D12, X25
    FMOV  V12.D[1], X29
    FMOV  D13, X22
    FMOV  V13.D[1], X15
    FMOV  D14, X8
    FMOV  V14.D[1], X28
    FMOV  D15, X11
    FMOV  V15.D[1], X18
    FMOV  D16, X3
    FMOV  V16.D[1], X24
    FMOV  D17, X4
    FMOV  V17.D[1], X11
    FMOV  D18, X2
    FMOV  V18.D[1], X16
    FMOV  D19, X6
    FMOV  V19.D[1], X18
    FMOV  D20, X4
    FMOV  V20.D[1], X2
    FMOV  D21, X13
    FMOV  V21.D[1], X19
    FMOV  D22, X13
    FMOV  V22.D[1], X3
    FMOV  D23, X6
    FMOV  V23.D[1], X17
    FMOV  D24, X22
    FMOV  V24.D[1], X4
    FMOV  D25, X9
    FMOV  V25.D[1], X13
    FMOV  D26, X2
    FMOV  V26.D[1], X7
    FMOV  D27, X27
    FMOV  V27.D[1], X19
    FMOV  D28, X7
    FMOV  V28.D[1], X20
    FMOV  D29, X19
    FMOV  V29.D[1], X19
    FMOV  D30, X25
    FMOV  V30.D[1], X10
    FMOV  D31, X2
    FMOV  V31.D[1], X18
    MOVZ  X28, #0xa, LSL #0
TaishanSimdAddP01_label_735:
    FRINTI  D29, D1
    FRINTZ  D24, D27
    FCVTNU  S31, S27
    FRINTI  D10, D3
    FCVTNU  D26, D26
    FCVTAS  V11.2S, V25.2S
    FCSEL  S28, S28, S28, NV
    FCVTAU  S8, S11
    FMOV  V0.D[1], X13
    FCVTZU  D9, D25
    FCVTZU  V2.2S, V12.2S
    FRINTA  H8, H15
    FCVTAS  S11, S28
    UCVTF  H21, W10
    SCVTF  V16.2D, V29.2D
    FRINTA  S13, S2
    FCVTMU  V27.8H, V23.8H
    FRINTI  H23, H8
    SCVTF V0.2D, V31.2D, #36
    FCVTZU  W3, D30
    FRINTP  S21, S25
    FRINTZ  D22, D7
    FMOV  X29, D10
    FCVTPS  D30, D19
    FRINTA  S30, S18
    FRINTA  D13, D5
    FCVTMU  S4, S1
    FCVTZS S21, S20, #25
    FCVTPS  V15.4H, V23.4H
    FRINTN  H25, H21
    FCVTNU  V7.4S, V23.4S
    FCVTNU  V13.4S, V14.4S
    UCVTF  S7, W4
    FRINTA  D13, D31
    FRINTA  H30, H21
    FRINTA  H1, H28
    FRINTA  D16, D7
    FRINTP  S14, S20
    FRINTN  D15, D26
    FCVTZS  D19, D12
    FCVTZU  D12, D0
    FCVTPS  S12, S2
    FCVTPS  V17.2S, V17.2S
    UCVTF V9.2D, V9.2D, #45
    FCVTPU  S11, S28
    FCVTMS  S3, S25
    FCVTMU  D9, D24
    FCVTZS  D21, D29
    FCVTPS  H23, H12
    FRINTZ  D7, D24
    FCVTMU  S8, S15
    FCVTZU  V21.2S, V28.2S, #3
    FCVTNS  S26, S31
    FCVTAU  H23, H17
    SCVTF  S25, S19
    FCVTZS S1, S11, #4
    FRINTN  S10, S14
    FRINTI  D14, D10
    SCVTF  D20, X8
    UCVTF  H7, W29, #25
    SCVTF  V28.2S, V2.2S
    FRINTN  D29, D24
    DUP V17.4S, W9
    FCVTAU  V25.4S, V2.4S
    FCVTZS  D2, D25
    FRINTN  D24, D25
    FCVTZS  X10, S10, #1
    FCVTZU V12.2D, V18.2D, #55
    FCVTPS  X17, D10
    FCVTAU  D29, D9
    FRINTI  H22, H31
    DUP V19.2D, X9
    FCVTMU  D27, D25
    FCVTAS  S8, S14
    FCVTZS S14, S26, #9
    SCVTF  S26, S18
    FCVTAU  D4, D21
    FCVTPS  V10.2D, V18.2D
    FCVTMS  W24, D28
    FCVTZS  X14, D16, #54
    FCVTZS  V12.2S, V25.2S, #15
    FCVTZS  V4.2S, V9.2S, #3
    SCVTF  S18, X13, #32
    FCVTPS  S2, S5
    FCVTNU  S31, S9
    FCVTAU  X20, H21
    FCVTAS  D31, D9
    FCVTMS  D14, D1
    FRINTM  D10, D14
    FCVTPS  S12, S4
    SCVTF  D12, W7, #9
    FCVTNU  D18, D29
    FCVTMS  V10.2S, V1.2S
    SCVTF V29.2D, V22.2D, #27
    FCVTNU  S31, S25
    FCVTAU  D28, D14
    FCVTMU  X4, H13
    FRINTZ  D24, D18
    FCVTZU  D20, D23
    FCVTNS  X15, H13
    FRINTI  S2, S14
    FCVTNU  D5, D28
    FCVTZU V26.2D, V17.2D, #7
    FCSEL  D25, D7, D20, PL
    FCVTMU  D14, D19
    FCVTMS  S17, S0
    UCVTF D24, D7, #2
    FRINTZ  H10, H22
    FRINTM  D15, D11
    FCVTAS  S9, S2
    FRINTI  D18, D10
    FCVTZS  S15, S27
    FCVTAS  X25, H7
    SCVTF  V4.2S, V6.2S
    FRINTX  D20, D29
    FCVTZU D21, D9, #20
    FCVTPS  W15, D4
    FRINTM  H31, H10
    FCSEL  S14, S4, S9, VS
    FCVTPU  S2, S29
    FCVTMS  D11, D19
    SCVTF  V17.2S, V11.2S, #3
    FRINTZ  H11, H15
    FCVTNS  V26.4S, V5.4S
    UCVTF  S30, S21
    UCVTF D22, D1, #45
    FRINTM  D13, D27
    FCVTZS  V9.4S, V7.4S, #8
    FCVTMS  D1, D11
    SCVTF  V17.2S, V23.2S, #30
    SCVTF  S19, S30
    FRINTZ  D4, D27
    FCVTMU  S20, S25
    SCVTF  H25, X6
    FCVTMU  V14.4S, V30.4S
    FRINTA  D14, D27
    FCVTPS  S28, S27
    SCVTF  D9, D11
    UCVTF D27, D30, #14
    UCVTF D11, D21, #6
    SCVTF  V19.2S, V14.2S
    FRINTM  H23, H0
    FRINTX  D10, D15
    FCVTAU  V15.2S, V7.2S
    FCVTPS  W25, S16
    FCVTZU V1.2D, V28.2D, #16
    UCVTF  S20, S16
    FRINTZ  D24, D14
    UCVTF S16, S10, #6
    FCVTPS  D9, D10
    UCVTF  D11, X29, #33
    UCVTF  S15, X17
    FRINTM  D10, D28
    FRINTZ  H30, H22
    FRINTX  D22, D27
    FRINTI  S26, S7
    FCVTZU V24.2D, V22.2D, #11
    FCVTZS  V16.4S, V7.4S
    FCVTZS S20, S14, #30
    FCVTAU  D28, D26
    FRINTM  H7, H0
    FCVTMU  X29, H1
    SCVTF  V27.4S, V11.4S, #2
    FCVTZU V0.2D, V22.2D, #48
    FCVTAS  S19, S26
    FRINTP  H4, H30
    FCVTZU S16, S2, #2
    FCVTAU  V15.2S, V23.2S
    FMOV  V17.D[1], X14
    FCVTAU  D24, D29
    FMOV  V2.D[1], X7
    FCVTAS  V19.2D, V15.2D
    FCVTZS  V17.2S, V0.2S, #3
    FCVTPS  S11, S4
    FCVTAU  V17.2S, V20.2S
    FRINTP  D12, D15
    FCVTZU  D1, D1
    FCVTNU  S11, S28
    FMOV  X24, D12
    FRINTA  H25, H13
    FCVTAU  S16, S26
    SCVTF V0.2D, V23.2D, #37
    FRINTM  S27, S13
    FCVTZU  V8.2S, V5.2S
    FMOV  X17, V17.D[1]
    SCVTF  S30, W23
    FRINTP  H0, H29
    FRINTI  S0, S1
    FCVTZS  D24, D22
    SCVTF  V22.2S, V15.2S
    FCVTNS  W25, H14
    FCVTZS  W7, H3, #11
    SCVTF  V4.4S, V18.4S, #18
    FCVTNU  W4, S2
    FCVTAU  V19.2D, V12.2D
    FCVTZU  V9.2D, V3.2D
    FRINTN  H19, H2
    DUP V5.8H, W25
    FCVTNU  D28, D23
    FRINTX  S28, S16
    SUBS  X28, X28, #0x1
    B.NE  TaishanSimdAddP01_label_735
    MOVZ  X27, #0x1614, LSL #0
    MOVK  X27, #0x504e, LSL #16
    MOVK  X27, #0x61a5, LSL #32
    MOVK  X27, #0x88cb, LSL #48
    SUB  X9, X27, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X4
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    MOVZ  X13, #0x7991, LSL #0
    MOVK  X13, #0x4081, LSL #16
    MOVK  X13, #0xbf1e, LSL #32
    MOVK  X13, #0xe314, LSL #48
    SUB  X16, X13, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X15, X6, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X12, #0x49db, LSL #0
    MOVK  X12, #0x2325, LSL #16
    MOVK  X12, #0x8e90, LSL #32
    MOVK  X12, #0x4698, LSL #48
    SUB  X29, X12, X8
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X10, X28, X10
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X28, #0x4e0a, LSL #0
    MOVK  X28, #0x6bdd, LSL #16
    MOVK  X28, #0x4c0, LSL #32
    MOVK  X28, #0xa6df, LSL #48
    SUB  X9, X28, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    MOVZ  X26, #0x49db, LSL #0
    MOVK  X26, #0x2325, LSL #16
    MOVK  X26, #0x8e90, LSL #32
    MOVK  X26, #0x4698, LSL #48
    SUB  X6, X26, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X21, #0x7991, LSL #0
    MOVK  X21, #0x4081, LSL #16
    MOVK  X21, #0xbf1e, LSL #32
    MOVK  X21, #0xe314, LSL #48
    SUB  X16, X21, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    MOVZ  X19, #0x3ae9, LSL #0
    MOVK  X19, #0xc5d5, LSL #16
    MOVK  X19, #0x92b6, LSL #32
    MOVK  X19, #0xfe1d, LSL #48
    SUB  X9, X19, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    MOVZ  X11, #0x7991, LSL #0
    MOVK  X11, #0x4081, LSL #16
    MOVK  X11, #0xbf1e, LSL #32
    MOVK  X11, #0xe314, LSL #48
    SUB  X4, X11, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    MOVZ  X14, #0x2e4e, LSL #0
    MOVK  X14, #0x36ac, LSL #16
    MOVK  X14, #0xf049, LSL #32
    MOVK  X14, #0xd1df, LSL #48
    SUB  X2, X14, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X4, X8, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X7, X3, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    MOVZ  X29, #0x1614, LSL #0
    MOVK  X29, #0x504e, LSL #16
    MOVK  X29, #0x61a5, LSL #32
    MOVK  X29, #0x88cb, LSL #48
    SUB  X17, X29, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X15, X29, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X28, D2
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X6, D3
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X22, V4.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X22, D4
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X7, #0x2e4e, LSL #0
    MOVK  X7, #0x36ac, LSL #16
    MOVK  X7, #0xf049, LSL #32
    MOVK  X7, #0xd1df, LSL #48
    SUB  X26, X7, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X24, D6
    MOVZ  X7, #0xc147, LSL #0
    MOVK  X7, #0x499, LSL #16
    MOVK  X7, #0xd7db, LSL #32
    MOVK  X7, #0xdb31, LSL #48
    SUB  X26, X7, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X11, D7
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X29, X28, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X16, D8
    MOVZ  X28, #0x0, LSL #0
    SUB  X29, X28, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X23, X13, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X20, D9
    MOVZ  X13, #0x0, LSL #0
    SUB  X23, X13, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X25, X20, X11
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X11, D10
    MOVZ  X20, #0x0, LSL #0
    SUB  X25, X20, X11
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X19, X12, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X20, D11
    MOVZ  X12, #0x0, LSL #0
    SUB  X19, X12, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X10, D12
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X3, X28, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X20, D13
    MOVZ  X28, #0x0, LSL #0
    SUB  X3, X28, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X10, D14
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X4, D15
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X7, D16
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X8, X28, X12
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X12, D17
    MOVZ  X28, #0x0, LSL #0
    SUB  X8, X28, X12
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X20, D18
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X6, D19
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X7, D20
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X17, V21.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X17, D21
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X18, X7, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    FMOV  X14, D22
    MOVZ  X7, #0x0, LSL #0
    SUB  X18, X7, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X26
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X26, D23
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X26
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X13, D24
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X11, D25
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X21, V26.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X24, X28, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X21, D26
    MOVZ  X28, #0x0, LSL #0
    SUB  X24, X28, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X4, D27
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X6, D28
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X26, D29
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
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
    FMOV  D0, X17
    FMOV  V0.D[1], X4
    FMOV  D1, X13
    FMOV  V1.D[1], X10
    FMOV  D2, X3
    FMOV  V2.D[1], X27
    FMOV  D3, X9
    FMOV  V3.D[1], X3
    FMOV  D4, X12
    FMOV  V4.D[1], X8
    FMOV  D5, X26
    FMOV  V5.D[1], X16
    FMOV  D6, X13
    FMOV  V6.D[1], X7
    FMOV  D7, X17
    FMOV  V7.D[1], X20
    FMOV  D8, X22
    FMOV  V8.D[1], X21
    FMOV  D9, X13
    FMOV  V9.D[1], X16
    FMOV  D10, X24
    FMOV  V10.D[1], X7
    FMOV  D11, X10
    FMOV  V11.D[1], X29
    FMOV  D12, X6
    FMOV  V12.D[1], X19
    FMOV  D13, X3
    FMOV  V13.D[1], X18
    FMOV  D14, X22
    FMOV  V14.D[1], X26
    FMOV  D15, X21
    FMOV  V15.D[1], X3
    FMOV  D16, X6
    FMOV  V16.D[1], X26
    FMOV  D17, X23
    FMOV  V17.D[1], X19
    FMOV  D18, X21
    FMOV  V18.D[1], X7
    FMOV  D19, X18
    FMOV  V19.D[1], X20
    FMOV  D20, X19
    FMOV  V20.D[1], X21
    FMOV  D21, X20
    FMOV  V21.D[1], X3
    FMOV  D22, X7
    FMOV  V22.D[1], X9
    FMOV  D23, X9
    FMOV  V23.D[1], X4
    FMOV  D24, X23
    FMOV  V24.D[1], X3
    FMOV  D25, X27
    FMOV  V25.D[1], X26
    FMOV  D26, X19
    FMOV  V26.D[1], X24
    FMOV  D27, X25
    FMOV  V27.D[1], X16
    FMOV  D28, X11
    FMOV  V28.D[1], X26
    FMOV  D29, X4
    FMOV  V29.D[1], X24
    FMOV  D30, X28
    FMOV  V30.D[1], X6
    FMOV  D31, X15
    FMOV  V31.D[1], X27
    MOVZ  X27, #0xa, LSL #0
TaishanSimdAddP01_label_814:
    FCVTNS  D30, D11
    FCVTMU  S30, S27
    FCVTPU  H6, H4
    FCVTAS  V15.2S, V21.2S
    UCVTF  D18, D31
    FCVTNS  S18, S3
    FRINTA  H13, H14
    FCVTZU V28.2D, V17.2D, #39
    FMOV  V30.D[1], X6
    FRINTM  S24, S4
    FCVTZU  V31.4S, V7.4S, #21
    FCVTNS  V31.8H, V0.8H
    FCVTZU  V4.2S, V15.2S, #27
    UCVTF  V11.2D, V24.2D
    FCVTZS  D16, D2
    FRINTI  D5, D13
    FCVTMS  X6, S5
    FRINTZ  H27, H26
    FRINTZ  H4, H26
    FCVTZS  D29, D7
    FCVTZU D3, D11, #27
    SCVTF  V10.4S, V23.4S
    SCVTF V31.2D, V4.2D, #50
    FCVTZU  V19.2S, V0.2S, #29
    FCVTNS  V31.2D, V10.2D
    FCVTZU  V15.4S, V13.4S
    FCVTAS  S30, S13
    FCVTMS  V25.2S, V21.2S
    FCVTAU  V15.2D, V7.2D
    FCVTZU D21, D0, #58
    FCVTZS  D7, D28
    FCVTNU  S29, S15
    FCVTPU  S26, S31
    FCVTNS  V15.2D, V15.2D
    UCVTF  S18, S5
    FCVTMS  V10.2S, V11.2S
    FCVTAU  S24, S26
    FCVTZS  S27, S5
    FCVTMU  D2, D31
    FCVTMU  D28, D9
    FCVTZU V13.2D, V0.2D, #7
    FCVTAU  S30, S1
    FRINTM  H29, H14
    FRINTA  H11, H16
    UCVTF  V4.2S, V6.2S
    FRINTA  D31, D4
    FCSEL  S23, S15, S27, NE
    FCVTZU V8.2D, V8.2D, #30
    FCVTAU  S0, S15
    FCVTPU  S3, S23
    FCVTNU  V2.2D, V24.2D
    FCVTZU  V8.2S, V19.2S, #9
    UCVTF D28, D29, #27
    FRINTA  S23, S21
    FCVTAS  S10, S6
    FCVTZS S13, S14, #26
    FCVTZU  D12, D0
    UCVTF  D26, D24
    FCVTNU  D12, D30
    FCVTZU D3, D23, #7
    UCVTF S5, S2, #29
    FCVTNU  V11.4S, V10.4S
    FRINTZ  H28, H5
    FCVTNS  D26, D7
    FRINTI  H3, H16
    FCVTZU  D30, D0
    FCVTAS  S30, S14
    FRINTN  D31, D11
    FCVTAS  D28, D30
    FCVTAU  W9, D12
    SCVTF  D8, W22, #12
    FRINTI  H6, H26
    FCVTMU  X18, D26
    FCVTPS  W29, S6
TaishanSimdAddP01_label_692:
    FRINTM  S5, S13
    FCVTZS  V24.4S, V17.4S, #8
    FCVTPS  D28, D11
    FCVTZS  V26.2S, V24.2S, #28
    FRINTX  H2, H10
    FCVTMU  V31.2S, V5.2S
    FRINTA  H2, H28
    DUP V29.16B, W8
    FMOV  W10, S21
    UCVTF  V5.2D, V17.2D
    FCVTAU  V29.8H, V17.8H
    FCVTZS  S10, S14
    FRINTA  S26, S31
    FCVTPU  X2, D21
    FCVTZU  S30, S6
    FRINTM  S22, S24
    FCVTZS D1, D2, #35
    FCVTZS  V12.2S, V16.2S, #11
    FRINTA  H16, H15
    SCVTF D2, D2, #16
    SCVTF  S18, S27
    UCVTF D8, D16, #1
    SCVTF  S21, S27
    FCVTPU  W25, D12
    FRINTA  D10, D13
    FRINTI  H13, H7
    FCVTZS  D11, D15
TaishanSimdAddP01_label_13:
    SCVTF  D27, D0
    FRINTN  S3, S15
    FCVTMS  S7, S18
    FCVTZU  S7, S30
TaishanSimdAddP01_label_308:
    FCVTZS D3, D0, #36
    FRINTA  D17, D31
    FCVTNU  D24, D17
    FRINTZ  H30, H17
    FRINTM  H2, H14
    FRINTM  H26, H23
    FCVTZS  V23.2S, V6.2S
    FRINTA  D5, D0
    FCVTNU  D24, D13
    FRINTZ  D25, D30
    FCVTZU D26, D15, #4
    FCVTMS  S8, S10
    SCVTF S26, S0, #17
    FCVTZU  V6.2S, V12.2S, #29
    FCVTZU D14, D10, #44
    UCVTF  H4, X11
    FRINTN  H31, H15
    FCVTZU  S12, S1
    UCVTF D3, D18, #21
    FCVTMS  D0, D18
    FCVTZS S0, S14, #29
    FCSEL  H2, H6, H1, MI
    FCVTMS  V19.2S, V30.2S
    FCVTAS  D26, D31
    FCVTZU  V18.2S, V15.2S
    FRINTM  D10, D25
    FCVTNU  W3, H13
    DUP V8.2D, X14
    FCSEL  S12, S25, S4, VS
    FCVTNU  V29.4S, V4.4S
    FMOV  X18, D20
    DUP V14.4S, W20
    SCVTF V15.2D, V0.2D, #28
    FCVTMS  V8.2S, V15.2S
    FCVTAU  V3.2S, V1.2S
    FCVTAS  V8.4S, V8.4S
    FCVTPU  D2, D2
    FMOV  V8.D[1], X14
    SCVTF D18, D29, #16
    FCVTPS  X14, H25
    FCVTPS  V25.2D, V31.2D
    FCVTMU  D8, D16
    FCVTPS  D21, D27
    FCVTZS D30, D13, #31
    FCVTMS  S28, S26
    FCVTZU D16, D12, #29
    FRINTZ  H1, H8
    FCVTPU  V9.4S, V27.4S
    FCVTPS  V9.4S, V2.4S
    UCVTF  S11, S16
    FRINTA  D19, D28
    FCVTNS  D30, D17
    FCVTMU  V18.4S, V21.4S
    FCVTZU S15, S1, #19
    FRINTX  H6, H3
    DUP V22.2D, X27
    SCVTF D25, D0, #44
    SCVTF S19, S29, #5
    FRINTZ  D2, D31
    FCVTZU V13.2D, V16.2D, #4
    FCVTNS  W11, H23
    FRINTX  S0, S10
    FCVTZS  W22, D6, #13
    FCVTZS V0.2D, V18.2D, #18
    FRINTM  H0, H17
    FRINTP  H12, H3
    FMOV  X13, D24
    SCVTF S17, S22, #2
    FRINTI  D24, D8
    FMOV  V11.D[1], X13
    FCVTPU  V29.2D, V23.2D
    FCVTAS  X28, H28
    FCVTMU  D1, D1
    FCVTNU  D11, D4
    SCVTF  D16, D25
    FRINTP  D18, D27
    FRINTZ  H1, H16
    FRINTP  D25, D4
    FRINTI  H16, H19
    UCVTF D26, D16, #64
    FCVTMU  D10, D0
    UCVTF D17, D28, #63
    FCVTNU  V3.2S, V18.2S
    SCVTF  S2, S16
    FRINTZ  H31, H27
    FRINTI  S16, S19
    FRINTA  H28, H0
    FCVTPS  S21, S18
    SCVTF D6, D7, #17
    FCVTNS  D24, D17
    FCVTZS D19, D28, #20
    FRINTA  S16, S10
    SCVTF S4, S10, #3
    FCVTZU D5, D21, #49
    FRINTZ  S16, S21
    SUBS  X27, X27, #0x1
    B.NE  TaishanSimdAddP01_label_814
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X6, X18, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X20, X17, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X2, X22, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X13, X22, X13
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X28, X22, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X19
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X21, X17, X21
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X26, X2, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X10, X28, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X26, D2
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X25, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X24, X15, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X25, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X24, X15, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X14, D4
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X21, V6.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X21, D6
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X18, D7
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X18, D8
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X19, X28, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X20, D9
    MOVZ  X28, #0x0, LSL #0
    SUB  X19, X28, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X17, X14, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X18, D10
    MOVZ  X14, #0x0, LSL #0
    SUB  X17, X14, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X12, X9, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X2, D11
    MOVZ  X9, #0x0, LSL #0
    SUB  X12, X9, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X6, D12
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X24, X22, X10
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X10, D13
    MOVZ  X22, #0x0, LSL #0
    SUB  X24, X22, X10
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X3, X16, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X8, D14
    MOVZ  X16, #0x0, LSL #0
    SUB  X3, X16, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X14, D15
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X8, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X4, D17
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X12, D18
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X20, X11, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X4, D19
    MOVZ  X11, #0x0, LSL #0
    SUB  X20, X11, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X3, V20.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X3, D20
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X23, D21
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X21, #0x1, LSL #0
    SUB  X27, X21, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X8, D22
    MOVZ  X21, #0x1, LSL #0
    SUB  X27, X21, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X27, D23
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X26, X13, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X2, D24
    MOVZ  X13, #0x0, LSL #0
    SUB  X26, X13, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X22, X23, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X11, D25
    MOVZ  X23, #0x0, LSL #0
    SUB  X22, X23, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X3, D26
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X6, D27
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X15, V28.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X15, D28
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X12, D29
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
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
    FMOV  D0, X4
    FMOV  V0.D[1], X19
    FMOV  D1, X7
    FMOV  V1.D[1], X4
    FMOV  D2, X9
    FMOV  V2.D[1], X28
    FMOV  D3, X7
    FMOV  V3.D[1], X18
    FMOV  D4, X12
    FMOV  V4.D[1], X28
    FMOV  D5, X27
    FMOV  V5.D[1], X29
    FMOV  D6, X7
    FMOV  V6.D[1], X21
    FMOV  D7, X27
    FMOV  V7.D[1], X10
    FMOV  D8, X16
    FMOV  V8.D[1], X11
    FMOV  D9, X11
    FMOV  V9.D[1], X20
    FMOV  D10, X10
    FMOV  V10.D[1], X15
    FMOV  D11, X2
    FMOV  V11.D[1], X29
    FMOV  D12, X10
    FMOV  V12.D[1], X8
    FMOV  D13, X8
    FMOV  V13.D[1], X23
    FMOV  D14, X27
    FMOV  V14.D[1], X15
    FMOV  D15, X7
    FMOV  V15.D[1], X6
    FMOV  D16, X16
    FMOV  V16.D[1], X16
    FMOV  D17, X26
    FMOV  V17.D[1], X24
    FMOV  D18, X29
    FMOV  V18.D[1], X20
    FMOV  D19, X15
    FMOV  V19.D[1], X3
    FMOV  D20, X27
    FMOV  V20.D[1], X22
    FMOV  D21, X7
    FMOV  V21.D[1], X28
    FMOV  D22, X9
    FMOV  V22.D[1], X9
    FMOV  D23, X2
    FMOV  V23.D[1], X2
    FMOV  D24, X2
    FMOV  V24.D[1], X3
    FMOV  D25, X10
    FMOV  V25.D[1], X4
    FMOV  D26, X27
    FMOV  V26.D[1], X14
    FMOV  D27, X3
    FMOV  V27.D[1], X15
    FMOV  D28, X26
    FMOV  V28.D[1], X20
    FMOV  D29, X12
TaishanSimdAddP01_label_161:
    FMOV  V29.D[1], X25
    FMOV  D30, X13
    FMOV  V30.D[1], X3
    FMOV  D31, X23
    FMOV  V31.D[1], X19
    MOVZ  X4, #0xf, LSL #0
TaishanSimdAddP01_label_891:
    FRINTX  S31, S26
    SCVTF  S30, S8
    FRINTN  H0, H16
    UCVTF S23, S0, #18
    SCVTF  V29.2S, V3.2S
    FCVTZU  V15.4S, V31.4S
    FCVTZU V1.2D, V2.2D, #29
    FCVTZS  D5, D6
    UCVTF S21, S12, #25
    UCVTF  V8.4S, V12.4S
    FCVTPS  V13.2S, V1.2S
    FCVTZU D23, D10, #35
    FCVTMU  W18, D7
    FRINTP  H30, H23
    FCVTZU  V15.4S, V5.4S, #7
    FCVTZU  D1, D12
    FCVTAS  D28, D8
    FCVTZU  V31.2S, V29.2S, #4
    FCVTPU  S25, S1
    UCVTF  D8, W23
    FCVTMU  S24, S27
    FRINTX  H14, H2
    UCVTF  V20.2S, V12.2S
    FCVTPU  D14, D13
    FCVTMS  D13, D24
    UCVTF  V5.2D, V17.2D
    FCVTMU  D28, D4
    FCVTPU  X24, S27
    FCVTAU  D27, D13
    FMOV  X10, V17.D[1]
    FCVTZS  V24.4S, V3.4S, #1
    UCVTF  S30, S30
    FCVTZS  V11.2S, V26.2S, #7
    FCVTMU  V21.2S, V1.2S
    SCVTF D10, D11, #40
    FCVTAU  D5, D19
    FCVTPS  V27.2S, V8.2S
    FCVTPU  V29.2S, V26.2S
    UCVTF  S25, S6
    FCVTPS  S13, S0
    FCVTNS  V11.2S, V31.2S
    FCVTAU  V24.2S, V2.2S
    FCVTPU  S20, S3
    FCVTNU  S25, S18
    FCVTAS  V15.4S, V2.4S
    SCVTF  D6, D12
    FCVTZS  V25.2S, V25.2S
    FCVTZS  S26, S26
    FCVTAU  S19, S12
    FCVTPS  S21, S20
    FCVTZU  D17, D25
    UCVTF  V22.4S, V27.4S
    FCVTZU D17, D10, #26
    SCVTF  S4, W9, #25
    DUP V30.2D, X7
    FRINTM  D22, D21
    FRINTM  D28, D25
    UCVTF  V12.4S, V29.4S, #5
    SCVTF  V29.4S, V26.4S, #14
    FCVTMU  S30, S28
    FMOV  X23, V27.D[1]
    FRINTI  D31, D7
    FCVTNS  D1, D30
    FCVTZS H14, H18, #12
    FCVTMS  S7, S1
    FCVTPU  S11, S18
    FCVTPU  V28.2S, V6.2S
    SCVTF  D22, D14
    FCVTMS  D28, D6
    FCVTPS  D26, D5
    UCVTF  D28, X27, #11
    FCVTPS  D1, D28
    FCVTZU  S22, S18
    FCVTPS  V19.4S, V22.4S
    FRINTI  S20, S16
    FCVTZU V5.2D, V0.2D, #26
    FCVTPU  D31, D18
    UCVTF  V15.4S, V18.4S, #10
    FCVTZU S4, S6, #12
    FCVTMU  V23.2S, V25.2S
    FCVTZU  S10, S20
    FCVTAS  S2, S26
    FCVTPU  S4, S15
    FCVTMS  D27, D23
    FRINTN  D14, D26
    SCVTF  V14.4S, V11.4S
    FCVTNU  V26.2D, V18.2D
    SCVTF  S14, S28
    FRINTZ  D15, D10
    FRINTZ  H18, H23
    FCVTAS  S18, S22
    FCVTMU  S26, S10
    FCVTAU  V18.2D, V11.2D
    SCVTF  D22, W9
    FRINTA  S2, S3
    FCVTNS  S31, S22
    FRINTP  S16, S0
    FCVTPU  D25, D26
    FCVTNS  S20, S30
    FCVTZS  S5, S7
    FCVTPU  H30, H12
    SCVTF  D16, D24
    FCVTAS  V12.4S, V18.4S
    FCVTNS  S19, S25
    FRINTN  S25, S4
    FCVTAU  W10, H16
    FRINTA  S2, S16
    FCVTPU  D9, D29
    SCVTF V30.2D, V25.2D, #33
    FRINTN  S7, S21
    FCVTAU  X19, S29
    FCVTMU  V11.4S, V31.4S
    FCVTNS  V18.4S, V11.4S
    SCVTF  V23.4S, V17.4S, #16
    FCVTZU S24, S23, #29
    FMOV  X27, V20.D[1]
    FCVTZS  V23.2S, V29.2S, #21
    FRINTN  S18, S18
    FCVTMU  S17, S22
    FRINTA  S26, S22
    FCVTZU  V29.4H, V12.4H
    FCVTAS  S11, S31
    FCVTNS  D10, D3
    FRINTA  D11, D18
    FRINTN  H17, H27
    FCVTZS D25, D5, #40
    FCVTZS  S3, S13
    FCVTAS  V23.2S, V11.2S
    FCVTPS  V28.2S, V16.2S
    DUP V15.4H, W3
    FMOV  X6, D20
    FMOV  X21, D7
    FRINTZ  H6, H19
    FRINTN  D31, D19
    FCVTNU  S28, S7
    FCVTZS  V24.2S, V25.2S
    FCVTNU  W21, H25
    UCVTF  D12, D28
    FMOV  X19, D25
    FCVTZU  V15.4S, V6.4S, #26
    FCVTZS S15, S7, #19
    FRINTX  D18, D16
    FCVTAS  D7, D17
    SCVTF S18, S0, #18
    FCVTZU  V30.4S, V27.4S, #24
    FCVTZU  V24.2D, V31.2D
    FRINTX  D19, D20
    FCVTAS  X26, S5
    SCVTF D15, D24, #47
    FCVTPS  S24, S12
    FCVTZU D28, D29, #7
    SCVTF  V27.4S, V22.4S
    FRINTZ  D10, D0
    FRINTA  S29, S3
    FRINTX  S25, S2
    UCVTF S13, S27, #16
    FCVTNS  X12, H11
    FRINTZ  H7, H15
    FMOV  X28, D25
    FCVTZS  S13, S16
    FCVTNS  X23, D27
    FCVTZU  X13, S10, #3
    DUP V16.2D, X10
    UCVTF V31.2D, V7.2D, #21
    UCVTF  V5.4S, V16.4S, #11
    FRINTI  S5, S23
    FRINTZ  H21, H24
    FCSEL  H7, H25, H31, CC
    UCVTF  V29.2S, V18.2S, #22
    FCVTAU  V2.2S, V31.2S
    FCVTPU  V13.2S, V20.2S
    FCVTZS  S4, S2
    FCVTAS  D24, D2
    FRINTZ  S2, S3
    FCVTNS  S13, S9
    FCVTNU  S16, S10
    FCVTAU  S14, S5
    FRINTX  D25, D20
    FCVTZS  V7.2D, V15.2D
    FCVTZU  V7.4S, V9.4S, #23
    FCVTPS  X9, H25
    FCVTNU  V1.4S, V22.4S
    FCVTZS  V7.4S, V3.4S, #18
    FCVTZS  V23.2S, V21.2S
    FCVTPS  D3, D11
    FCVTNU  D29, D7
    FRINTN  H7, H4
    FRINTM  H29, H25
    FCVTNU  S23, S15
    FCVTZS V3.2D, V29.2D, #11
    FCVTPU  D19, D13
    FCVTZS  V9.4S, V5.4S, #32
    FCVTMS  V24.2D, V27.2D
    FRINTZ  H10, H10
    FCVTZU  D26, D31
    FRINTM  D10, D9
    FCVTZU  V16.2D, V29.2D
    FCVTPS  D26, D30
    FRINTZ  D24, D20
    FCVTZS S11, S22, #11
    SUBS  X4, X4, #0x1
    B.NE  TaishanSimdAddP01_label_891
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X20, X17, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X6, X18, X3
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X10, X23, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X28, X9, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X4, X8, X22
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X15, X26, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X23, X19, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X23, X19, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X11, X10, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X27
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X4, X16, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X23, D2
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X6, D3
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X16, D4
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X21, X14, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X24, D6
    MOVZ  X14, #0x0, LSL #0
    SUB  X21, X14, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X29, D7
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X15
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X15, D8
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X15
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X6, D9
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X27, V10.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X27, D10
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X19, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X19, D11
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X22, V12.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X22, D12
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X8, D13
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X12, D14
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X19, V15.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X19, D15
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X29, D16
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X28, D17
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X11, D18
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X20, D19
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X29, D20
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X23, D21
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X8, D22
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X16, D23
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X20, D24
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X22, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X22, D25
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X24, D26
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X21, V27.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X21
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X21, D27
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X21
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X14, X19, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X12, D28
    MOVZ  X19, #0x0, LSL #0
    SUB  X14, X19, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X14
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X14, D29
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X14
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0x2295, LSL #0
    MOVK  X2, #0x2f9a, LSL #16
    MOVK  X2, #0xf855, LSL #32
    MOVK  X2, #0xb7fd, LSL #48
    MOVZ  X3, #0xc872, LSL #0
    MOVK  X3, #0xd366, LSL #16
    MOVK  X3, #0xb392, LSL #32
    MOVK  X3, #0xed5d, LSL #48
    MOVZ  X4, #0xdb6d, LSL #0
    MOVK  X4, #0x10fb, LSL #16
    MOVK  X4, #0x5ea7, LSL #32
    MOVK  X4, #0xd6b7, LSL #48
    MOVZ  X6, #0x8261, LSL #0
    MOVK  X6, #0xaed2, LSL #16
    MOVK  X6, #0xcf9b, LSL #32
    MOVK  X6, #0x6245, LSL #48
    MOVZ  X7, #0x95c0, LSL #0
    MOVK  X7, #0xc474, LSL #16
    MOVK  X7, #0x4da9, LSL #32
    MOVK  X7, #0x4639, LSL #48
    MOVZ  X8, #0xcb79, LSL #0
    MOVK  X8, #0x279a, LSL #16
    MOVK  X8, #0x48cf, LSL #32
    MOVK  X8, #0x1b, LSL #48
    MOVZ  X9, #0xc84b, LSL #0
    MOVK  X9, #0x776, LSL #16
    MOVK  X9, #0x370f, LSL #32
    MOVK  X9, #0x73eb, LSL #48
    MOVZ  X10, #0x6493, LSL #0
    MOVK  X10, #0x3897, LSL #16
    MOVK  X10, #0xc453, LSL #32
    MOVK  X10, #0x8891, LSL #48
    MOVZ  X11, #0xc2ac, LSL #0
    MOVK  X11, #0x4640, LSL #16
    MOVK  X11, #0x9b49, LSL #32
    MOVK  X11, #0x465f, LSL #48
    MOVZ  X12, #0xe77a, LSL #0
    MOVK  X12, #0x168c, LSL #16
    MOVK  X12, #0x5c74, LSL #32
    MOVK  X12, #0x20e3, LSL #48
    MOVZ  X13, #0x5be8, LSL #0
    MOVK  X13, #0x2332, LSL #16
    MOVK  X13, #0x7c91, LSL #32
    MOVK  X13, #0xa9e9, LSL #48
    MOVZ  X14, #0xcf96, LSL #0
    MOVK  X14, #0xe6f4, LSL #16
    MOVK  X14, #0xdf99, LSL #32
    MOVK  X14, #0x577f, LSL #48
    MOVZ  X15, #0xe3b3, LSL #0
    MOVK  X15, #0x18a1, LSL #16
    MOVK  X15, #0xfdf1, LSL #32
    MOVK  X15, #0x6bf5, LSL #48
    MOVZ  X16, #0x5442, LSL #0
    MOVK  X16, #0x848a, LSL #16
    MOVK  X16, #0x87c6, LSL #32
    MOVK  X16, #0x658, LSL #48
    MOVZ  X17, #0xac0d, LSL #0
    MOVK  X17, #0xe4b0, LSL #16
    MOVK  X17, #0xa82a, LSL #32
    MOVK  X17, #0x4130, LSL #48
    MOVZ  X18, #0xe80e, LSL #0
    MOVK  X18, #0x3634, LSL #16
    MOVK  X18, #0x4e7a, LSL #32
    MOVK  X18, #0x9db8, LSL #48
    MOVZ  X19, #0xd1d, LSL #0
    MOVK  X19, #0x8b96, LSL #16
    MOVK  X19, #0x9e71, LSL #32
    MOVK  X19, #0x90bb, LSL #48
    MOVZ  X20, #0x252b, LSL #0
    MOVK  X20, #0x2249, LSL #16
    MOVK  X20, #0xab2a, LSL #32
    MOVK  X20, #0x1ff6, LSL #48
    MOVZ  X21, #0x5be7, LSL #0
    MOVK  X21, #0xe2aa, LSL #16
    MOVK  X21, #0xfb26, LSL #32
    MOVK  X21, #0x7d99, LSL #48
    MOVZ  X22, #0x36e, LSL #0
    MOVK  X22, #0x6247, LSL #16
    MOVK  X22, #0x7b71, LSL #32
    MOVK  X22, #0x6e66, LSL #48
    MOVZ  X23, #0xfdff, LSL #0
    MOVK  X23, #0x14ab, LSL #16
    MOVK  X23, #0xa70f, LSL #32
    MOVK  X23, #0xd4f1, LSL #48
    MOVZ  X24, #0x6612, LSL #0
    MOVK  X24, #0x534a, LSL #16
    MOVK  X24, #0xcb7f, LSL #32
    MOVK  X24, #0x3d81, LSL #48
    MOVZ  X25, #0x3faf, LSL #0
    MOVK  X25, #0x58d, LSL #16
    MOVK  X25, #0xc4c6, LSL #32
    MOVK  X25, #0xb654, LSL #48
    MOVZ  X26, #0x4082, LSL #0
    MOVK  X26, #0xcbbd, LSL #16
    MOVK  X26, #0x1ed0, LSL #32
    MOVK  X26, #0x4e23, LSL #48
    MOVZ  X27, #0x85a9, LSL #0
    MOVK  X27, #0xb196, LSL #16
    MOVK  X27, #0x78c, LSL #32
    MOVK  X27, #0x764d, LSL #48
    MOVZ  X28, #0x87ca, LSL #0
    MOVK  X28, #0x4381, LSL #16
    MOVK  X28, #0xaf21, LSL #32
    MOVK  X28, #0xff32, LSL #48
    MOVZ  X29, #0x28b3, LSL #0
    MOVK  X29, #0xd74e, LSL #16
    MOVK  X29, #0xee28, LSL #32
    MOVK  X29, #0x6c62, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X28
    FMOV  D1, X26
    FMOV  V1.D[1], X24
    FMOV  D2, X19
    FMOV  V2.D[1], X18
    FMOV  D3, X20
    FMOV  V3.D[1], X14
    FMOV  D4, X3
    FMOV  V4.D[1], X3
    FMOV  D5, X16
    FMOV  V5.D[1], X12
    FMOV  D6, X8
    FMOV  V6.D[1], X10
    FMOV  D7, X24
    FMOV  V7.D[1], X27
    FMOV  D8, X15
    FMOV  V8.D[1], X13
    FMOV  D9, X16
    FMOV  V9.D[1], X20
    FMOV  D10, X8
    FMOV  V10.D[1], X22
    FMOV  D11, X18
    FMOV  V11.D[1], X12
    FMOV  D12, X27
    FMOV  V12.D[1], X28
    FMOV  D13, X9
    FMOV  V13.D[1], X22
    FMOV  D14, X7
    FMOV  V14.D[1], X25
    FMOV  D15, X6
    FMOV  V15.D[1], X6
    FMOV  D16, X13
    FMOV  V16.D[1], X2
    FMOV  D17, X14
    FMOV  V17.D[1], X17
    FMOV  D18, X19
    FMOV  V18.D[1], X2
    FMOV  D19, X12
    FMOV  V19.D[1], X11
    FMOV  D20, X24
    FMOV  V20.D[1], X10
    FMOV  D21, X26
    FMOV  V21.D[1], X4
    FMOV  D22, X4
    FMOV  V22.D[1], X14
    FMOV  D23, X21
    FMOV  V23.D[1], X11
    FMOV  D24, X21
    FMOV  V24.D[1], X18
    FMOV  D25, X4
    FMOV  V25.D[1], X11
    FMOV  D26, X27
    FMOV  V26.D[1], X13
    FMOV  D27, X2
    FMOV  V27.D[1], X20
    FMOV  D28, X15
    FMOV  V28.D[1], X16
    FMOV  D29, X14
    FMOV  V29.D[1], X4
    FMOV  D30, X20
    FMOV  V30.D[1], X9
    FMOV  D31, X17
    FMOV  V31.D[1], X25
    MOVZ  X13, #0xa, LSL #0
TaishanSimdAddP01_label_966:
    FRINTZ  S6, S26
    FRINTP  S13, S9
    DUP V13.2D, X2
    FCVTMS  S27, S31
    FCVTMU  W21, D13
    FCVTZU  V27.2S, V11.2S
    FCVTZS  S3, S29
    FCVTAS  D16, D1
    FMOV  W8, S21
    FMOV  X8, D16
    UCVTF V28.2D, V22.2D, #10
    FCVTZS V13.2D, V3.2D, #60
    FCVTPS  S6, S23
    UCVTF  V25.2S, V6.2S, #4
    SCVTF V25.2D, V30.2D, #60
    FCVTNU  V21.2S, V15.2S
    FRINTI  S27, S31
    FCVTZS V6.2D, V17.2D, #12
    SCVTF D21, D27, #21
    UCVTF  V19.2S, V9.2S
    FCVTZS  S13, S11
    FRINTZ  H2, H31
    FCVTPU  V12.4S, V9.4S
    SCVTF  S18, S15
    FCVTMU  D19, D1
    FCVTZS  S13, S10
    FCVTMS  V18.2D, V11.2D
    FRINTP  H14, H10
    FCVTNS  V0.2D, V0.2D
    FCVTAU  S25, S31
    FCVTPS  S25, S2
    FCVTZU D21, D10, #38
    FCVTNU  V24.4S, V6.4S
    FCVTMS  V15.2S, V26.2S
    FCVTPS  V11.4S, V29.4S
    FRINTM  D25, D10
    FRINTP  D6, D16
    FCVTPU  S16, S12
    FCVTPU  D3, D6
    FCVTAU  X19, D5
    FRINTP  S27, S0
    FCVTPU  D31, D29
    FRINTA  H24, H29
    DUP V23.2S, W25
    FCVTAS  S29, S2
    FRINTM  S28, S15
    FCVTAS  S10, S26
    FCVTPS  S12, S11
    FMOV  V28.D[1], X7
    SCVTF  S20, S30
    SCVTF  D13, D10
    UCVTF  V15.2D, V16.2D
    FCVTZS  V25.2S, V9.2S
    FCVTMS  V19.4S, V25.4S
    SCVTF  S19, S28
    FRINTI  D11, D5
    FCVTPS  V23.4S, V5.4S
    FCVTZU  V7.4S, V8.4S, #26
    FRINTX  S27, S11
    UCVTF D29, D26, #17
    FCVTMS  V2.2D, V0.2D
    FRINTP  H13, H14
    FRINTZ  S28, S23
    FCVTNU  S6, S15
    FCVTZU  V25.4S, V4.4S
    FRINTA  H17, H8
    FCVTZS  D23, D14
    FRINTA  S23, S4
    FMOV  X22, D30
    FCVTZS D18, D15, #12
    SCVTF  V1.2S, V23.2S, #5
    FCVTMU  V6.4S, V8.4S
    FCVTZU  V1.2S, V29.2S, #20
    FRINTI  S3, S4
    FRINTA  S17, S8
    FRINTX  S30, S25
    FCVTPS  V31.4S, V22.4S
    FCVTAU  S16, S1
    FRINTZ  D6, D24
    FCVTMU  D24, D21
    SCVTF  H8, X17, #61
    FRINTI  H6, H7
    FRINTP  S9, S3
    SCVTF  V11.2D, V18.2D
    SCVTF  D19, D25
    SCVTF S17, S13, #22
    FCVTPU  S2, S23
    UCVTF V23.2D, V15.2D, #23
    FMOV  X25, V7.D[1]
    FCVTMS  V20.2D, V31.2D
    FCVTPU  V8.2D, V27.2D
    FCVTMU  S5, S14
    SCVTF  V4.2S, V30.2S, #21
    UCVTF V20.2D, V23.2D, #25
    FRINTN  S8, S30
    FCVTZS D20, D13, #21
    FRINTX  H3, H15
    FMOV  V15.D[1], X7
    FCVTZU  D19, D18
    FCVTAS  V6.2S, V7.2S
    FCVTPU  D11, D4
    FRINTN  D28, D0
    FCVTZU V24.2D, V0.2D, #16
    FCVTZU D11, D8, #10
    FCVTZS  V17.4S, V24.4S
    FCVTNU  W23, S25
    FRINTI  S7, S21
    UCVTF D16, D0, #36
    FRINTM  D28, D5
    FRINTZ  D6, D8
    FCVTMU  X4, D15
    FCVTMU  S25, S27
    FRINTZ  D30, D10
    SCVTF  V27.2S, V16.2S, #14
    FRINTZ  H29, H25
    FCVTPU  V7.2D, V3.2D
    FMOV  W2, S28
    FCVTMS  D0, D19
    FCVTPU  D11, D23
    FCVTZU  V18.2S, V0.2S, #13
    FCVTAU  V31.2S, V20.2S
    FCVTAS  D29, D5
    FCVTZS S12, S16, #23
    FCVTAU  S0, S16
    FMOV  W4, S27
    FCVTPU  D8, D25
    FCVTZS  V18.2S, V8.2S, #5
    FCVTZU S17, S6, #8
    DUP V12.4S, W27
    FRINTX  D9, D19
    FCVTZU  X20, D9
    FCVTNU  D8, D30
    FCVTPU  D3, D9
    FCVTNU  D30, D2
    FCVTPU  V22.2S, V1.2S
    FRINTN  S25, S10
    FCVTZU  V13.2D, V4.2D
    FCVTMU  V17.4S, V23.4S
    FRINTA  H24, H5
    FRINTI  S3, S20
    FCVTZS V11.2D, V27.2D, #8
    FRINTM  H2, H8
    FRINTP  D27, D9
    FCVTPS  H4, H19
    FRINTN  D3, D7
    FCVTZS S27, S30, #4
    FCVTZU  V8.2S, V22.2S, #6
    FCVTMS  S11, S5
    FCVTNU  S4, S27
    SCVTF S4, S8, #32
    FRINTM  S23, S1
    FCVTZS  S25, S29
    FCVTAS  S17, S21
    FCVTZS  V3.2S, V30.2S
    DUP V4.8B, W11
    FCVTMU  S1, S10
    FCVTPU  D0, D4
    FRINTI  S9, S1
    FRINTI  H7, H0
    FRINTZ  H3, H9
    FMOV  X21, D23
    FCVTNS  D3, D4
    FRINTI  S18, S2
    FMOV  X20, D24
    FCVTAS  S30, S3
    FCVTZS  V17.2S, V14.2S
    FCVTZU S16, S14, #28
    FCVTZU S29, S11, #8
    FCVTPS  S14, S12
    FMOV  W2, S25
    FCVTAU  D13, D18
    UCVTF  V29.4S, V7.4S, #30
    FCVTNU  D7, D23
    UCVTF S1, S16, #24
    UCVTF S1, S3, #16
    FCVTZU  D14, D22
    FRINTN  D12, D15
    FCVTNS  V9.2S, V15.2S
    FMOV  V13.D[1], X21
    FCVTMU  S7, S7
    FCVTMU  V9.2D, V10.2D
    FCVTMS  V13.8H, V12.8H
    FCVTZU  V31.4S, V30.4S
    FRINTN  H14, H31
    FCVTZU  V17.4S, V18.4S
    UCVTF V16.2D, V9.2D, #33
    FCVTZS D31, D3, #45
    FCVTZU  S23, S2
    FCVTZU  D20, D4
    FCVTPS  H10, H25
    FCVTMS  S22, S20
    FRINTX  D19, D30
    FCVTPU  V31.4H, V20.4H
    FCVTPS  S24, S2
    FCVTZU  S2, S16
    FCVTPU  V16.2S, V8.2S
    SCVTF S10, S10, #10
    FCVTMS  S3, S20
    FCVTNU  D15, D19
    FRINTA  H22, H19
    SUBS  X13, X13, #0x1
    B.NE  TaishanSimdAddP01_label_966
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    MOVZ  X11, #0xc872, LSL #0
    MOVK  X11, #0xd366, LSL #16
    MOVK  X11, #0xb392, LSL #32
    MOVK  X11, #0xed5d, LSL #48
    SUB  X27, X11, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    MOVZ  X28, #0x8261, LSL #0
    MOVK  X28, #0xaed2, LSL #16
    MOVK  X28, #0xcf9b, LSL #32
    MOVK  X28, #0x6245, LSL #48
    SUB  X17, X28, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    MOVZ  X29, #0x95c0, LSL #0
    MOVK  X29, #0xc474, LSL #16
    MOVK  X29, #0x4da9, LSL #32
    MOVK  X29, #0x4639, LSL #48
    SUB  X6, X29, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    MOVZ  X7, #0xc84b, LSL #0
    MOVK  X7, #0x776, LSL #16
    MOVK  X7, #0x370f, LSL #32
    MOVK  X7, #0x73eb, LSL #48
    SUB  X8, X7, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    MOVZ  X4, #0x6493, LSL #0
    MOVK  X4, #0x3897, LSL #16
    MOVK  X4, #0xc453, LSL #32
    MOVK  X4, #0x8891, LSL #48
    SUB  X26, X4, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0xc872, LSL #0
    MOVK  X24, #0xd366, LSL #16
    MOVK  X24, #0xb392, LSL #32
    MOVK  X24, #0xed5d, LSL #48
    SUB  X26, X24, X11
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    MOVZ  X26, #0xe77a, LSL #0
    MOVK  X26, #0x168c, LSL #16
    MOVK  X26, #0x5c74, LSL #32
    MOVK  X26, #0x20e3, LSL #48
    SUB  X16, X26, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    MOVZ  X7, #0xe3b3, LSL #0
    MOVK  X7, #0x18a1, LSL #16
    MOVK  X7, #0xfdf1, LSL #32
    MOVK  X7, #0x6bf5, LSL #48
    SUB  X12, X7, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X16
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X8, X2, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X3, #0xe77a, LSL #0
    MOVK  X3, #0x168c, LSL #16
    MOVK  X3, #0x5c74, LSL #32
    MOVK  X3, #0x20e3, LSL #48
    SUB  X13, X3, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    MOVZ  X4, #0x95c0, LSL #0
    MOVK  X4, #0xc474, LSL #16
    MOVK  X4, #0x4da9, LSL #32
    MOVK  X4, #0x4639, LSL #48
    SUB  X6, X4, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X11, D2
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X23, D3
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X9, D4
    MOVZ  X25, #0xacac, LSL #0
    MOVK  X25, #0xacac, LSL #16
    MOVK  X25, #0xacac, LSL #32
    MOVK  X25, #0xacac, LSL #48
    SUB  X7, X25, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X29, D6
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X14
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X14, D7
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X14
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    FMOV  X2, D8
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X13, X3, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X7, D9
    MOVZ  X3, #0x0, LSL #0
    SUB  X13, X3, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X14, X15, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X7, D10
    MOVZ  X15, #0x0, LSL #0
    SUB  X14, X15, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X10, D11
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X9, V12.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X9, D12
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X24, X8, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X6, D13
    MOVZ  X8, #0x0, LSL #0
    SUB  X24, X8, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X13, D14
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X19, V15.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X19, D15
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X12, D16
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X26, D17
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X9, X29, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X17, D18
    MOVZ  X29, #0x0, LSL #0
    SUB  X9, X29, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X24
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X24, D19
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X24
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X9, D20
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X28, V21.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X28, D21
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X8, X24, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X11, D22
    MOVZ  X24, #0x0, LSL #0
    SUB  X8, X24, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X15, V23.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X26, X16, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X15, D23
    MOVZ  X16, #0x0, LSL #0
    SUB  X26, X16, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X10, X4, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X13, D24
    MOVZ  X4, #0x0, LSL #0
    SUB  X10, X4, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X28, D25
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X10, #0x5be8, LSL #0
    MOVK  X10, #0x2332, LSL #16
    MOVK  X10, #0x7c91, LSL #32
    MOVK  X10, #0xa9e9, LSL #48
    SUB  X25, X10, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X2, D26
    MOVZ  X10, #0x85a9, LSL #0
    MOVK  X10, #0xb196, LSL #16
    MOVK  X10, #0x78c, LSL #32
    MOVK  X10, #0x764d, LSL #48
    SUB  X25, X10, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X16
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X16, D27
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X16
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X16, D28
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X4, D29
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
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
TaishanSimdAddP01_label_327:
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X24
    FMOV  V0.D[1], X10
    FMOV  D1, X24
    FMOV  V1.D[1], X9
    FMOV  D2, X23
    FMOV  V2.D[1], X23
    FMOV  D3, X25
    FMOV  V3.D[1], X22
    FMOV  D4, X29
    FMOV  V4.D[1], X18
    FMOV  D5, X22
    FMOV  V5.D[1], X27
    FMOV  D6, X28
    FMOV  V6.D[1], X11
    FMOV  D7, X24
    FMOV  V7.D[1], X18
    FMOV  D8, X2
    FMOV  V8.D[1], X27
    FMOV  D9, X17
    FMOV  V9.D[1], X17
    FMOV  D10, X15
    FMOV  V10.D[1], X17
    FMOV  D11, X26
    FMOV  V11.D[1], X19
    FMOV  D12, X2
    FMOV  V12.D[1], X29
    FMOV  D13, X27
    FMOV  V13.D[1], X14
    FMOV  D14, X9
    FMOV  V14.D[1], X6
    FMOV  D15, X24
    FMOV  V15.D[1], X12
    FMOV  D16, X9
    FMOV  V16.D[1], X27
    FMOV  D17, X15
    FMOV  V17.D[1], X13
    FMOV  D18, X19
    FMOV  V18.D[1], X23
    FMOV  D19, X13
    FMOV  V19.D[1], X4
    FMOV  D20, X27
    FMOV  V20.D[1], X15
    FMOV  D21, X11
    FMOV  V21.D[1], X21
    FMOV  D22, X27
    FMOV  V22.D[1], X24
    FMOV  D23, X14
    FMOV  V23.D[1], X12
    FMOV  D24, X15
    FMOV  V24.D[1], X25
    FMOV  D25, X21
    FMOV  V25.D[1], X16
    FMOV  D26, X10
    FMOV  V26.D[1], X23
    FMOV  D27, X20
    FMOV  V27.D[1], X21
    FMOV  D28, X24
    FMOV  V28.D[1], X19
    FMOV  D29, X6
    FMOV  V29.D[1], X7
    FMOV  D30, X26
    FMOV  V30.D[1], X23
    FMOV  D31, X11
    FMOV  V31.D[1], X22
    MOVZ  X6, #0xa, LSL #0
TaishanSimdAddP01_label_1040:
    FCVTZU  S25, S11
    FCVTZS  D3, D15
    FCVTZU S29, S24, #10
    FRINTI  D8, D24
    DUP V17.2D, X27
    FCVTNS  D7, D4
    FCVTNS  S31, S23
    FMOV  X21, D9
    FCVTZU  V29.8H, V15.8H
    FRINTM  S25, S17
    FCVTZU D30, D4, #58
    FCVTPU  D31, D11
    FCVTNU  W3, H24
    FRINTX  S13, S3
    FCVTPU  D13, D2
    SCVTF  S10, S22
    FCVTZS D25, D7, #25
    FCVTNU  X10, D17
    FRINTX  S12, S29
    FCVTMS  S28, S2
    DUP V22.16B, W15
    FCVTAU  W8, S0
    UCVTF  D13, D1
    FCVTZS  X22, D12, #2
    UCVTF  S28, X27
    DUP V26.8H, W19
    FCVTZU V25.2D, V15.2D, #53
    FCVTAU  S30, S25
    FRINTI  H10, H12
    FCVTPS  X25, H7
    UCVTF  D13, X7, #36
    FCVTZU  V31.4S, V13.4S, #22
    FRINTA  S20, S27
    UCVTF  H20, W7
    FCVTPS  S2, S23
    FCVTAS  D5, D20
    FCVTNS  V31.2S, V17.2S
    FCVTNS  V30.2D, V17.2D
    FRINTZ  H3, H30
    FCVTMS  D17, D0
    FRINTA  D6, D23
    FRINTI  D13, D27
    FCVTMU  W17, S7
    FRINTZ  S13, S5
    FCVTNS  H10, H3
    SCVTF  D0, X25, #49
    FCVTZS V8.2D, V27.2D, #56
    FCVTAS  D26, D0
    FRINTZ  H6, H20
    FCVTZS  D3, D30
    FRINTI  S30, S17
    FCVTMU  V29.4S, V7.4S
    FCVTMU  S19, S12
    FCSEL  D7, D8, D28, LE
    FRINTX  D11, D20
    FMOV  W10, S30
    FCVTPS  W29, H2
    FCVTZS  D9, D20
    FCVTZU S16, S2, #32
    FCVTMU  V8.8H, V10.8H
    FCVTPS  S28, S17
    FRINTZ  H5, H12
    FCVTAU  W12, D13
    FCVTAU  X4, S12
    FMOV  W29, S30
    FCVTZU  V6.4S, V27.4S, #12
    FRINTM  S9, S18
    FCVTZS S26, S20, #27
    UCVTF S4, S12, #11
    FCVTMS  S29, S31
    SCVTF  V7.4S, V19.4S, #24
    FCVTZS  V14.2D, V8.2D
    FCVTAU  S18, S12
    FCVTMS  S2, S30
    FCSEL  S12, S30, S8, VC
    FCVTMU  V30.2D, V29.2D
    SCVTF S20, S20, #12
    FRINTN  D19, D10
    FCVTPU  D17, D10
    FCVTZS S28, S19, #25
    FCVTZU  V29.4S, V2.4S
    FCVTNU  V21.4H, V25.4H
    FRINTM  S20, S6
    FMOV  W21, S30
    FCVTNS  S2, S0
    FRINTI  H9, H12
    FCVTMU  D9, D19
    FCVTZU  D26, D24
    FCVTMS  S2, S26
    FMOV  W28, S6
    FRINTI  S18, S12
    SCVTF D1, D1, #11
    SCVTF D20, D0, #1
    FCVTAS  H31, H29
    SCVTF  S21, S18
    FCVTAS  D28, D0
    FCVTPU  V30.8H, V17.8H
    FCVTNS  S10, S22
    FCVTZS  S25, S20
    FCVTZS D23, D24, #61
    FCVTPU  S3, S18
    FCVTMS  D20, D22
    FCVTZS  V22.4H, V24.4H
    FRINTZ  S30, S2
    FRINTP  D17, D3
    FMOV  X17, V18.D[1]
    FCVTMS  X3, D4
    FCVTZU  D12, D10
    SCVTF  V9.4S, V4.4S
    FRINTA  H8, H17
    FCVTAU  D22, D14
    FCVTMS  D28, D17
    FCVTAS  S5, S21
    SCVTF S21, S1, #2
    FCVTZU  D30, D11
    FCVTMU  W9, S31
    FCVTMS  V9.4S, V3.4S
    SCVTF D0, D4, #60
    FRINTZ  H1, H1
    FRINTX  H3, H9
    FCVTPS  X24, D14
    FCVTAU  S18, S7
    FRINTM  S8, S28
    FCVTAS  V9.2S, V21.2S
    UCVTF V23.2D, V25.2D, #51
    SCVTF  S17, S10
    SCVTF D12, D21, #45
    FRINTI  S21, S25
    FRINTA  D10, D8
    SCVTF  D21, D13
    FCVTAU  V24.2D, V0.2D
    SCVTF  V18.2S, V22.2S
    FCVTZU S12, S6, #12
    UCVTF V15.2D, V18.2D, #62
    FRINTP  D16, D12
    FCVTZU  S17, S11
    FCVTZS  V4.4S, V9.4S, #13
    FCVTAU  W4, H26
    FCVTPS  V3.2S, V26.2S
    FRINTN  D26, D23
    FCVTPU  V5.2D, V13.2D
    FRINTZ  S31, S7
    FRINTA  D19, D24
    UCVTF  S5, S4
    FRINTN  H10, H16
    SCVTF  V23.4S, V23.4S
    FCVTMU  V13.2D, V24.2D
    FCVTMS  D9, D0
    FCVTZU D29, D3, #7
    FRINTZ  H27, H29
    FCVTMS  V1.2S, V1.2S
    FMOV  W18, S14
    FCVTPU  V29.2S, V11.2S
    FCVTAS  H18, H18
    FRINTZ  D24, D8
    FCVTZS  V23.2D, V7.2D
    FRINTI  H3, H29
    SCVTF V29.2D, V10.2D, #14
    FCVTAU  V17.4S, V16.4S
    FCVTMU  S8, S30
    FCVTNS  H23, H22
    FCVTPU  D18, D17
    FRINTM  D18, D22
    SCVTF V29.2D, V1.2D, #40
    FCVTZU  S8, S28
    FCVTNS  D31, D8
    FRINTX  D26, D21
    FCVTZU S23, S5, #13
    FRINTX  D6, D17
    FRINTM  D1, D22
    FCVTMS  V23.4S, V27.4S
    FMOV  X8, D8
    FRINTX  S28, S21
    FCVTAU  H7, H18
    FCVTNS  D7, D10
    FCVTZU  V8.2S, V14.2S
    FRINTZ  S4, S26
    FCVTZS S22, S19, #8
    UCVTF  S23, S28
    FCVTAS  S0, S30
    FCVTNS  W4, H3
    UCVTF D18, D24, #5
    FCVTPS  D16, D19
    FCVTNS  X27, S22
    FCVTAU  W14, D21
    FMOV  X2, V14.D[1]
    FCVTZS  V9.2D, V6.2D
    UCVTF  V28.2S, V29.2S, #30
    FRINTI  S20, S16
    FCVTMS  X10, D23
    SCVTF D0, D21, #17
    FCVTNU  V4.2S, V18.2S
    UCVTF V23.2D, V5.2D, #50
    FRINTA  H14, H6
    FCVTNS  D29, D20
    FCVTAU  X21, H31
    FCVTZS D3, D24, #2
    FCVTMU  W9, H9
    FCVTNU  X10, D18
    FCVTAS  V0.2S, V20.2S
    SUBS  X6, X6, #0x1
    B.NE  TaishanSimdAddP01_label_1040
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X28, X4, X3
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X19, X27, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X19, X28, X9
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X3, X18, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X12, X24, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X16
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X3, X25, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X17, X20, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X8, D2
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X19, X7, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X6, D3
    MOVZ  X7, #0x0, LSL #0
    SUB  X19, X7, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X19, X14, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X24, D4
    MOVZ  X14, #0x0, LSL #0
    SUB  X19, X14, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X26
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X26, D6
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X26
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X9, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X9
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X9, D7
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X9
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X6, D8
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X14, D9
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X12
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X12, D10
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X12
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X21, X17, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X12, D11
    MOVZ  X17, #0x0, LSL #0
    SUB  X21, X17, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X3, D12
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X12, X24, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X4, D13
    MOVZ  X24, #0x0, LSL #0
    SUB  X12, X24, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X6, D14
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X6, X27, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X16, D15
    MOVZ  X27, #0x0, LSL #0
    SUB  X6, X27, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X13, D16
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X14, D17
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X23, D18
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X23
TaishanSimdAddP01_label_1006:
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X27, V19.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    FMOV  X27, D19
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X28, D20
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X14, D21
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X14, D22
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X10, V23.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X10, D23
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X19, X8, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X14, D24
    MOVZ  X8, #0x0, LSL #0
    SUB  X19, X8, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X6, V25.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X6, D25
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X10, D26
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X7, D27
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X22, V28.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X22, D28
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X10, D29
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
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
    FMOV  D0, X26
    FMOV  V0.D[1], X11
    FMOV  D1, X8
    FMOV  V1.D[1], X18
    FMOV  D2, X9
    FMOV  V2.D[1], X23
    FMOV  D3, X29
    FMOV  V3.D[1], X21
    FMOV  D4, X26
    FMOV  V4.D[1], X6
    FMOV  D5, X10
    FMOV  V5.D[1], X17
    FMOV  D6, X28
    FMOV  V6.D[1], X2
    FMOV  D7, X28
    FMOV  V7.D[1], X19
    FMOV  D8, X12
    FMOV  V8.D[1], X10
    FMOV  D9, X25
    FMOV  V9.D[1], X20
    FMOV  D10, X11
    FMOV  V10.D[1], X28
    FMOV  D11, X21
    FMOV  V11.D[1], X11
    FMOV  D12, X12
    FMOV  V12.D[1], X2
    FMOV  D13, X18
    FMOV  V13.D[1], X16
    FMOV  D14, X12
    FMOV  V14.D[1], X20
    FMOV  D15, X22
    FMOV  V15.D[1], X8
    FMOV  D16, X9
    FMOV  V16.D[1], X7
    FMOV  D17, X10
    FMOV  V17.D[1], X29
    FMOV  D18, X17
    FMOV  V18.D[1], X4
    FMOV  D19, X15
    FMOV  V19.D[1], X24
    FMOV  D20, X27
    FMOV  V20.D[1], X20
    FMOV  D21, X23
    FMOV  V21.D[1], X23
    FMOV  D22, X4
    FMOV  V22.D[1], X7
    FMOV  D23, X19
    FMOV  V23.D[1], X17
    FMOV  D24, X14
    FMOV  V24.D[1], X16
    FMOV  D25, X15
    FMOV  V25.D[1], X11
    FMOV  D26, X14
    FMOV  V26.D[1], X2
    FMOV  D27, X23
    FMOV  V27.D[1], X3
    FMOV  D28, X3
    FMOV  V28.D[1], X11
    FMOV  D29, X10
    FMOV  V29.D[1], X3
    FMOV  D30, X11
    FMOV  V30.D[1], X8
    FMOV  D31, X27
    FMOV  V31.D[1], X13
    MOVZ  X10, #0xf, LSL #0
TaishanSimdAddP01_label_1117:
    FCVTZS S22, S12, #30
    FCVTPU  W13, H27
    FRINTM  D23, D17
    FCVTZU  V22.2S, V4.2S, #13
    FCVTPU  V18.4S, V29.4S
    FCVTZS  D7, D16
    SCVTF S1, S5, #15
    FCVTNU  S18, S24
    FRINTI  S9, S4
    FCVTZS  D22, D9
    FMOV  X3, V20.D[1]
    SCVTF  S31, W11, #22
    SCVTF  D29, X2
    FRINTN  S30, S12
    FCVTNU  D23, D18
    FRINTI  H1, H1
    DUP V7.4S, W7
    FRINTN  H8, H18
    FCVTZU  V10.2D, V4.2D
    FCVTAS  V18.2S, V29.2S
    FCVTAU  V23.2S, V1.2S
    FCVTMU  V6.2D, V31.2D
    FCVTZU  V17.4S, V15.4S, #6
    SCVTF  S24, S1
    FCVTZU  V24.2S, V27.2S
    FMOV  X2, V5.D[1]
    FRINTA  S31, S30
    FCVTAS  S29, S7
    FCVTZS  W16, S2, #13
    FCVTZS  V15.2D, V3.2D
    FCVTMS  X11, H25
    SCVTF D22, D17, #20
    FCVTZS  D28, D20
    UCVTF S31, S5, #20
    FCVTAS  V29.4S, V17.4S
    FRINTX  H16, H4
    FCSEL  S4, S11, S0, NV
    FRINTP  D10, D13
    SCVTF  S31, S5
    FCVTAU  S6, S11
    FCVTMS  V7.2S, V12.2S
    FCVTZS D3, D15, #44
    FCVTZS S21, S25, #12
    UCVTF  V1.2D, V10.2D
    FCVTPU  S29, S2
    FCVTAU  D23, D31
    FCVTZS S21, S26, #9
    FCVTZU V12.2D, V7.2D, #24
    UCVTF D4, D20, #30
    FCVTMS  V6.4S, V23.4S
    FMOV  X23, V14.D[1]
    FCVTZS  V3.2D, V15.2D
    FMOV  X6, V28.D[1]
    FCVTAS  H1, H23
    FCVTMU  S14, S25
    FCVTZU V16.2D, V10.2D, #26
    FCVTZU S20, S16, #24
    FRINTP  D7, D29
    FRINTA  S2, S6
    FCVTZU  S23, S25
    FCVTZS  S7, S28
    FMOV  V20.D[1], X3
    FCVTMS  D31, D1
    FRINTZ  D1, D0
    FCVTZS D15, D22, #3
    FCVTZU  D16, D6
    UCVTF  V25.2S, V13.2S
    FCVTNU  V25.2D, V9.2D
    UCVTF D3, D1, #44
    SCVTF  V18.2S, V26.2S
    FCVTAU  S22, S19
    FCVTZS  V10.4S, V28.4S
    UCVTF D20, D2, #55
    DUP V13.2S, W7
    SCVTF  H7, X8
    FCVTNS  X27, D9
    FCVTZU  V18.2D, V20.2D
    FMOV  W4, S3
    FCVTNU  D15, D11
    FRINTZ  H1, H2
    FRINTN  S29, S1
    FCVTZS V27.2D, V1.2D, #5
    FCVTMU  V11.4S, V7.4S
    FCVTMU  S6, S28
    FRINTI  D15, D25
    FCVTAU  D16, D6
    FRINTZ  S30, S29
    FCVTAU  X16, D12
    FCVTZU V19.2D, V25.2D, #57
    FRINTN  S28, S1
    FRINTX  S14, S27
    FMOV  X11, D27
    FCVTAU  S16, S4
    FCVTZU  D7, D3
    UCVTF  V19.4S, V30.4S
    FCVTNS  D14, D31
    FRINTX  H7, H6
    DUP V2.4H, W14
    SCVTF D21, D24, #44
    FCVTPS  D18, D9
    FCVTZS  W22, H16, #10
    SCVTF  S6, S19
    FRINTN  D7, D5
    FMOV  X23, D4
    FRINTX  D0, D16
    FRINTP  H23, H6
    SCVTF  D16, D23
    SCVTF D31, D29, #15
    FCVTNS  V18.4S, V23.4S
    FRINTX  D15, D29
    FCVTAS  V31.2S, V3.2S
    SCVTF D25, D14, #45
    FRINTX  D7, D13
    FCVTZS  D16, D20
    FCVTPS  D15, D10
    UCVTF  D16, D2
    UCVTF  D6, D31
    FRINTA  D18, D0
    DUP V25.4H, W20
    FCVTMS  S15, S26
    FCVTMU  H0, H3
    FRINTA  H13, H4
    FCVTMS  S29, S7
    FCVTZS  D26, D19
    FCVTMU  V24.2S, V13.2S
    FCVTMU  V22.2S, V29.2S
    FRINTP  S19, S21
    FCVTPS  D0, D0
    FRINTP  D12, D7
    FRINTP  D10, D15
    FRINTP  H25, H25
    FCVTZU  D8, D0
    FCVTMU  D5, D11
    FRINTA  S19, S25
    FCVTAU  D13, D13
    FRINTN  H3, H10
    FCVTNS  D26, D20
    FCVTMU  V5.4S, V15.4S
    FRINTN  S27, S11
    FRINTX  H31, H3
    FRINTA  D13, D15
    SCVTF  H24, W12, #21
    FCVTZS  W26, H26, #2
    FCVTAU  D13, D29
    FRINTI  S0, S0
    SCVTF D11, D7, #33
    UCVTF D10, D7, #25
    FRINTM  D16, D19
    FCVTAU  S13, S8
    FCVTZS  D29, D27
    FRINTZ  S17, S30
    FRINTX  D20, D17
    UCVTF V0.2D, V29.2D, #58
    UCVTF  D30, D13
    SCVTF  V15.2D, V0.2D
    UCVTF S8, S25, #31
    FCVTNU  D25, D7
    FRINTZ  D29, D13
    FCVTPU  D30, D24
    DUP V19.2D, X24
    UCVTF S4, S28, #13
    FRINTX  S10, S24
    SCVTF S3, S4, #15
    FCVTZU  D19, D0
    FCVTPS  S3, S9
    UCVTF  S17, S0
    FCVTMU  S24, S7
    UCVTF  V9.2S, V1.2S, #32
    FCVTMU  D0, D8
    FRINTP  S16, S20
    FCVTNS  X24, H10
    SCVTF D11, D5, #22
    FCVTZU  X3, D25
    FRINTZ  H26, H25
    FCVTMS  V20.8H, V23.8H
    FRINTN  H27, H1
    FCVTMU  S4, S25
    FRINTM  D3, D17
    FCVTMU  V16.2S, V20.2S
    FCVTZS D8, D10, #37
    FCSEL  S27, S31, S17, LS
    UCVTF D21, D1, #40
    FRINTA  S24, S22
    FCVTZS  S15, S6
    FCVTPS  W25, S3
    UCVTF  S24, S5
    FCVTZS  W21, S16, #6
    FCVTPS  V20.4S, V26.4S
    FCSEL  D11, D22, D28, GT
    UCVTF  S25, W18
    FCVTMU  S5, S13
    SCVTF S26, S15, #14
    FCVTAS  S15, S20
    FCVTNU  S6, S1
    FCVTZS  V8.2D, V9.2D
    SCVTF  V5.4S, V23.4S
    FCVTZS D13, D31, #16
    FCVTMS  D25, D8
    FRINTA  H8, H16
    FCVTZS H3, H11, #6
    SUBS  X10, X10, #0x1
    B.NE  TaishanSimdAddP01_label_1117
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X6, X29, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X20, X28, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X28, X22, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X7, X19, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X17, X14, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X17
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X29, X26, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X19, X28, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X19, X14, X22
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X27, X8, X23
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X24
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X15, X11, X26
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X12, X24, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X28, D2
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X23, X12, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X11, D3
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X12, D4
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X7, D6
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X23, X17, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X20, D7
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7ff8, LSL #48
    SUB  X23, X17, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X17, V8.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X17, D8
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X7, D9
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X28, D10
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    FMOV  X28, D11
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X8
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X8, D12
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7ff8, LSL #48
    SUB  X15, X20, X8
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X14, D13
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X21, V14.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X21, D14
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X26, D15
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X27, V16.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X17, X6, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X27, D16
    MOVZ  X6, #0x0, LSL #0
    SUB  X17, X6, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X14, D17
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X28, D18
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X14, X6, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X24, D19
    MOVZ  X6, #0x0, LSL #0
    SUB  X14, X6, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X14, D20
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X29, D21
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X16, D22
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X25, V23.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X25, D23
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X6, D24
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X23, D25
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X25, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X25, D26
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X28, D27
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X29, D28
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X3, V29.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X12, X10, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X3, D29
    MOVZ  X10, #0x0, LSL #0
    SUB  X12, X10, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0xa7fc, LSL #0
    MOVK  X2, #0x4d98, LSL #16
    MOVK  X2, #0x32e6, LSL #32
    MOVK  X2, #0x435d, LSL #48
    MOVZ  X3, #0xe60c, LSL #0
    MOVK  X3, #0xc5da, LSL #16
    MOVK  X3, #0x34a1, LSL #32
    MOVK  X3, #0xde79, LSL #48
    MOVZ  X4, #0xbeae, LSL #0
    MOVK  X4, #0xa7f6, LSL #16
    MOVK  X4, #0x12a4, LSL #32
    MOVK  X4, #0x66a6, LSL #48
    MOVZ  X6, #0xded9, LSL #0
    MOVK  X6, #0x4e2a, LSL #16
    MOVK  X6, #0x231e, LSL #32
    MOVK  X6, #0x76a6, LSL #48
    MOVZ  X7, #0x5e7a, LSL #0
    MOVK  X7, #0xd393, LSL #16
    MOVK  X7, #0xe93, LSL #32
    MOVK  X7, #0x17b6, LSL #48
    MOVZ  X8, #0x1328, LSL #0
    MOVK  X8, #0xb7ac, LSL #16
    MOVK  X8, #0xf511, LSL #32
    MOVK  X8, #0x2242, LSL #48
    MOVZ  X9, #0x7a23, LSL #0
    MOVK  X9, #0xfcb3, LSL #16
    MOVK  X9, #0xa2fa, LSL #32
    MOVK  X9, #0xc40f, LSL #48
    MOVZ  X10, #0x530f, LSL #0
    MOVK  X10, #0x93b7, LSL #16
    MOVK  X10, #0xd63e, LSL #32
    MOVK  X10, #0xd91d, LSL #48
    MOVZ  X11, #0xb44a, LSL #0
    MOVK  X11, #0x3aaf, LSL #16
    MOVK  X11, #0x5154, LSL #32
    MOVK  X11, #0x6743, LSL #48
    MOVZ  X12, #0xf91f, LSL #0
    MOVK  X12, #0x55c9, LSL #16
    MOVK  X12, #0x353e, LSL #32
    MOVK  X12, #0xf425, LSL #48
    MOVZ  X13, #0x1244, LSL #0
    MOVK  X13, #0xbfec, LSL #16
    MOVK  X13, #0xb72a, LSL #32
    MOVK  X13, #0xbbaa, LSL #48
    MOVZ  X14, #0xd4a0, LSL #0
    MOVK  X14, #0xe884, LSL #16
    MOVK  X14, #0x22a, LSL #32
    MOVK  X14, #0xb8de, LSL #48
    MOVZ  X15, #0x666e, LSL #0
    MOVK  X15, #0x3059, LSL #16
    MOVK  X15, #0x49cf, LSL #32
    MOVK  X15, #0xebf, LSL #48
    MOVZ  X16, #0x2e67, LSL #0
    MOVK  X16, #0x9ac1, LSL #16
    MOVK  X16, #0x7447, LSL #32
    MOVK  X16, #0x3eec, LSL #48
    MOVZ  X17, #0x9177, LSL #0
    MOVK  X17, #0x1d5a, LSL #16
    MOVK  X17, #0xc366, LSL #32
    MOVK  X17, #0x5453, LSL #48
    MOVZ  X18, #0x6c75, LSL #0
    MOVK  X18, #0xea3a, LSL #16
    MOVK  X18, #0x7718, LSL #32
    MOVK  X18, #0x8c3f, LSL #48
    MOVZ  X19, #0xdf35, LSL #0
    MOVK  X19, #0x2a85, LSL #16
    MOVK  X19, #0xb781, LSL #32
    MOVK  X19, #0x4046, LSL #48
    MOVZ  X20, #0xb295, LSL #0
    MOVK  X20, #0xc672, LSL #16
    MOVK  X20, #0x582c, LSL #32
    MOVK  X20, #0x7819, LSL #48
    MOVZ  X21, #0xf951, LSL #0
    MOVK  X21, #0xee74, LSL #16
    MOVK  X21, #0x2ed3, LSL #32
    MOVK  X21, #0x87a5, LSL #48
    MOVZ  X22, #0xa98, LSL #0
    MOVK  X22, #0x91ba, LSL #16
    MOVK  X22, #0x38a5, LSL #32
    MOVK  X22, #0x42ba, LSL #48
    MOVZ  X23, #0xd4ca, LSL #0
    MOVK  X23, #0xa756, LSL #16
    MOVK  X23, #0x2bd, LSL #32
    MOVK  X23, #0xc36a, LSL #48
    MOVZ  X24, #0xbee0, LSL #0
    MOVK  X24, #0xc20b, LSL #16
    MOVK  X24, #0x9162, LSL #32
    MOVK  X24, #0xd0cb, LSL #48
    MOVZ  X25, #0xf763, LSL #0
    MOVK  X25, #0x5a70, LSL #16
    MOVK  X25, #0xc04a, LSL #32
    MOVK  X25, #0x2385, LSL #48
    MOVZ  X26, #0x4238, LSL #0
    MOVK  X26, #0xa3b8, LSL #16
    MOVK  X26, #0x3e47, LSL #32
    MOVK  X26, #0x62cc, LSL #48
    MOVZ  X27, #0xe85d, LSL #0
    MOVK  X27, #0x5362, LSL #16
    MOVK  X27, #0xd649, LSL #32
    MOVK  X27, #0x5c8, LSL #48
    MOVZ  X28, #0xba0, LSL #0
    MOVK  X28, #0xcc7e, LSL #16
    MOVK  X28, #0xe86b, LSL #32
    MOVK  X28, #0xb722, LSL #48
    MOVZ  X29, #0x4f35, LSL #0
    MOVK  X29, #0x5a30, LSL #16
    MOVK  X29, #0xbde7, LSL #32
    MOVK  X29, #0x59e, LSL #48
    FMOV  D0, X12
    FMOV  V0.D[1], X18
    FMOV  D1, X17
    FMOV  V1.D[1], X26
    FMOV  D2, X3
    FMOV  V2.D[1], X16
    FMOV  D3, X29
    FMOV  V3.D[1], X18
    FMOV  D4, X27
    FMOV  V4.D[1], X13
    FMOV  D5, X3
    FMOV  V5.D[1], X20
    FMOV  D6, X28
    FMOV  V6.D[1], X8
    FMOV  D7, X22
    FMOV  V7.D[1], X23
    FMOV  D8, X13
    FMOV  V8.D[1], X12
    FMOV  D9, X10
    FMOV  V9.D[1], X23
    FMOV  D10, X16
    FMOV  V10.D[1], X4
    FMOV  D11, X23
    FMOV  V11.D[1], X13
    FMOV  D12, X11
    FMOV  V12.D[1], X14
    FMOV  D13, X16
    FMOV  V13.D[1], X2
    FMOV  D14, X24
    FMOV  V14.D[1], X3
    FMOV  D15, X3
    FMOV  V15.D[1], X7
    FMOV  D16, X8
    FMOV  V16.D[1], X8
    FMOV  D17, X26
    FMOV  V17.D[1], X15
    FMOV  D18, X12
    FMOV  V18.D[1], X22
    FMOV  D19, X15
    FMOV  V19.D[1], X7
    FMOV  D20, X18
    FMOV  V20.D[1], X12
    FMOV  D21, X17
    FMOV  V21.D[1], X23
    FMOV  D22, X16
    FMOV  V22.D[1], X28
    FMOV  D23, X6
    FMOV  V23.D[1], X21
    FMOV  D24, X3
    FMOV  V24.D[1], X18
    FMOV  D25, X27
    FMOV  V25.D[1], X6
    FMOV  D26, X28
    FMOV  V26.D[1], X12
    FMOV  D27, X22
    FMOV  V27.D[1], X22
    FMOV  D28, X13
    FMOV  V28.D[1], X22
    FMOV  D29, X22
    FMOV  V29.D[1], X21
    FMOV  D30, X16
    FMOV  V30.D[1], X3
    FMOV  D31, X16
    FMOV  V31.D[1], X11
    MOVZ  X16, #0xa, LSL #0
TaishanSimdAddP01_label_1191:
    UCVTF  D10, D26
    FRINTN  S21, S9
    FRINTP  S12, S10
    FMOV  X3, V28.D[1]
    FCVTAU  D26, D4
    FRINTI  D16, D24
    FRINTZ  S16, S30
    FRINTZ  D20, D20
    FCVTMS  D29, D3
    FRINTZ  D13, D26
    FRINTI  H25, H30
    FCVTAS  H31, H31
    FCVTAS  S5, S2
    FCVTMS  V15.2S, V24.2S
    FCVTPS  V29.2D, V2.2D
    FMOV  X28, D2
    FCVTNU  V13.2S, V11.2S
    FRINTM  H15, H17
    FRINTM  S3, S25
    UCVTF  V22.2S, V17.2S, #21
    FRINTI  D3, D16
    FCVTAS  V13.2S, V12.2S
    FCSEL  S20, S19, S23, LE
    FCVTZS D31, D3, #17
    FCVTZU  D21, D5
    SCVTF D0, D2, #29
    FCSEL  S20, S6, S28, PL
    FMOV  X27, V25.D[1]
    FCVTPS  D10, D29
    FRINTM  H10, H11
    SCVTF  H6, X19, #14
    FCVTZS S20, S16, #28
    FCVTMU  V5.4S, V10.4S
    FRINTX  S11, S31
    FRINTM  S12, S12
    SCVTF  H16, X27, #53
    FRINTP  H22, H10
    FRINTP  S3, S31
    SCVTF D11, D3, #22
    FMOV  X12, D0
    FCVTZU S15, S31, #26
    SCVTF  V23.4S, V10.4S, #4
    FRINTA  S29, S20
    FCVTPU  S11, S20
    FRINTI  D20, D18
    FCVTAS  S3, S28
    UCVTF  D26, D27
    FCVTNS  D15, D28
    FRINTM  S16, S1
    FCVTPS  X17, D7
    FRINTN  S18, S5
    FCVTPS  S18, S2
    UCVTF D18, D7, #50
    FRINTZ  S28, S20
    FRINTN  S15, S19
    SCVTF  V6.2S, V16.2S, #17
    UCVTF V31.2D, V6.2D, #48
    DUP V18.8B, W23
    FCVTNU  V26.4S, V3.4S
    FCVTZU  S19, S29
    SCVTF S18, S2, #1
    SCVTF  S19, W15, #1
    SCVTF  H20, X14, #31
    FCVTZS  V26.2S, V15.2S, #22
    FCVTZS D1, D15, #11
    FCVTNU  S17, S28
    FCVTAS  D29, D19
    FCVTNU  V18.2S, V19.2S
    FCVTZU V11.2D, V28.2D, #26
    FCVTMU  S31, S7
    FCVTNS  X24, H5
    FCVTMS  S20, S31
    FCVTAS  S1, S2
    FRINTN  D5, D3
    FRINTZ  D0, D17
    FCVTZS  W6, H9
    UCVTF  S20, S8
    FRINTP  H28, H19
    FCVTPS  S2, S28
    FCVTMS  S27, S31
    FCVTAU  D22, D2
    FRINTM  S11, S1
    FMOV  W9, S26
    FCVTZS  D18, D6
    FCSEL  H21, H27, H16, PL
    FRINTI  H1, H13
    FCVTAU  S9, S8
    SCVTF V12.2D, V6.2D, #4
    FCVTNS  W28, D28
    FCVTMS  D19, D6
    FRINTZ  H1, H8
    FCVTAS  D25, D19
    FCVTMS  S28, S22
    FCVTZS S22, S25, #30
    FCVTPS  D7, D1
    FMOV  X24, D12
    FRINTX  H13, H30
    FCVTAU  W25, H18
    UCVTF  S21, S6
    FRINTZ  S3, S1
    FRINTA  H22, H25
    FCVTZU D6, D28, #37
    UCVTF  V16.4S, V26.4S, #24
    FCVTZU  H31, H8
    UCVTF  V28.4S, V28.4S, #30
    FRINTZ  D25, D8
    DUP V22.2D, X16
    FCVTZU  X9, S26
    FCVTNU  H7, H28
    FCVTAU  S25, S19
    FCVTMU  V11.2S, V0.2S
    FCVTAU  V3.4S, V11.4S
    UCVTF D5, D27, #54
    SCVTF  D25, D29
    FCVTZS S31, S28, #5
    FRINTI  H13, H4
    FCVTPU  S5, S26
    FRINTI  D27, D5
    FCVTMU  V4.2D, V1.2D
    FRINTZ  H31, H6
    FCVTNS  V26.2D, V17.2D
    FCVTZU S14, S8, #7
    FCVTNU  V4.4S, V15.4S
    FRINTI  D31, D24
    FCVTAS  D2, D18
    FCVTZS  V5.4S, V12.4S, #11
    FCVTZS  V22.4S, V29.4S
    FCVTPU  D20, D1
    FRINTN  S6, S25
    FCVTMS  V11.4S, V26.4S
    FCVTNS  V13.2S, V5.2S
    FCVTZU D21, D0, #6
    FCVTZS  S4, S20
    FCVTZS  D22, D6
    FRINTM  H15, H31
    FCSEL  H28, H31, H22, GE
    FCVTZS  S18, S24
    FCVTZU D5, D0, #30
    FCVTZU  S6, S29
    SCVTF S20, S20, #14
    FRINTX  D2, D10
    FCVTAU  X11, H26
    SCVTF D31, D26, #47
    SCVTF  V4.4S, V9.4S, #10
    FCVTZU  X24, S17
    UCVTF  H15, X11
    FRINTN  D8, D21
    FCVTAS  D28, D0
    FCVTZU  S9, S11
    FCVTPS  D9, D1
    FCVTAS  W11, H15
    FCVTNS  S16, S8
    UCVTF  S9, S8
    FCVTMS  V18.2S, V17.2S
    FCVTZS  D12, D31
    FCVTPU  D12, D12
    FCVTZU  V16.4S, V27.4S, #30
    FCVTZU  S22, S25
    FRINTZ  D19, D5
    FCVTPS  V11.4S, V14.4S
    FRINTN  H13, H9
    FCVTMU  D4, D30
    UCVTF D4, D28, #19
    FCVTNS  V15.2S, V14.2S
    FCVTNU  V18.2S, V17.2S
    SCVTF S16, S25, #4
    FRINTA  D13, D19
    UCVTF  D19, D26
    SCVTF V30.2D, V16.2D, #22
    FMOV  W25, S5
    FMOV  V6.D[1], X27
    UCVTF V21.2D, V12.2D, #8
    FRINTM  D14, D17
    FCVTMS  W20, H30
    SCVTF  V15.2D, V26.2D
    FCVTZU  S19, S17
    UCVTF  S25, S28
    FCVTAU  V16.2S, V1.2S
    FCVTPU  S18, S22
    FCVTPU  W7, D7
    UCVTF S21, S21, #6
    FCVTZS V31.2D, V18.2D, #64
    SCVTF V24.2D, V17.2D, #27
    FCVTZS  V15.4S, V30.4S
    FCVTZS  V21.4S, V30.4S, #8
    FCVTMS  V13.2S, V19.2S
    FRINTN  S21, S17
    FCVTZS  W22, S5, #22
    SCVTF  D28, D31
    FCVTZS  S28, S12
    UCVTF D4, D28, #19
    FCVTMS  V20.4S, V14.4S
    UCVTF V30.2D, V15.2D, #3
    FCVTAS  V12.2D, V22.2D
    FRINTP  D12, D26
    SCVTF  D1, D26
    UCVTF S18, S30, #32
    FRINTI  H28, H3
    FCVTNS  W3, D28
    FCVTMU  S21, S14
    SUBS  X16, X16, #0x1
    B.NE  TaishanSimdAddP01_label_1191
    MOVZ  X22, #0xa7fc, LSL #0
    MOVK  X22, #0x4d98, LSL #16
    MOVK  X22, #0x32e6, LSL #32
    MOVK  X22, #0x435d, LSL #48
    SUB  X11, X22, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    MOVZ  X8, #0xbeae, LSL #0
    MOVK  X8, #0xa7f6, LSL #16
    MOVK  X8, #0x12a4, LSL #32
    MOVK  X8, #0x66a6, LSL #48
    SUB  X6, X8, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    MOVZ  X9, #0xbeae, LSL #0
    MOVK  X9, #0xa7f6, LSL #16
    MOVK  X9, #0x12a4, LSL #32
    MOVK  X9, #0x66a6, LSL #48
    SUB  X12, X9, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    MOVZ  X26, #0xbeae, LSL #0
    MOVK  X26, #0xa7f6, LSL #16
    MOVK  X26, #0x12a4, LSL #32
    MOVK  X26, #0x66a6, LSL #48
    SUB  X10, X26, X9
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X18, X7, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X4, X6, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    MOVZ  X3, #0x1244, LSL #0
    MOVK  X3, #0xbfec, LSL #16
    MOVK  X3, #0xb72a, LSL #32
    MOVK  X3, #0xbbaa, LSL #48
    SUB  X21, X3, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    MOVZ  X29, #0xd4a0, LSL #0
    MOVK  X29, #0xe884, LSL #16
    MOVK  X29, #0x22a, LSL #32
    MOVK  X29, #0xb8de, LSL #48
    SUB  X17, X29, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X15
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X27, X17, X16
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X20, X11, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X18
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    MOVZ  X6, #0xdf35, LSL #0
    MOVK  X6, #0x2a85, LSL #16
    MOVK  X6, #0xb781, LSL #32
    MOVK  X6, #0x4046, LSL #48
    SUB  X15, X6, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X28, X15, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X3, X16, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    MOVZ  X7, #0xd4ca, LSL #0
    MOVK  X7, #0xa756, LSL #16
    MOVK  X7, #0x2bd, LSL #32
    MOVK  X7, #0xc36a, LSL #48
    SUB  X22, X7, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X6, X24, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X9, D2
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X14, D3
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X27, X25, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X17, D4
    MOVZ  X25, #0x0, LSL #0
    SUB  X27, X25, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X28, D6
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X2, X15, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X26, D7
    MOVZ  X15, #0x0, LSL #0
    SUB  X2, X15, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X27, D8
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X11, D9
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X14, X29, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X2, D10
    MOVZ  X29, #0x0, LSL #0
    SUB  X14, X29, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X15, V11.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X15, D11
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X26, D12
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X18, D13
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X29, D14
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X19, V15.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X19, D15
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X9, D16
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X21, X9, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X8, D17
    MOVZ  X9, #0x0, LSL #0
    SUB  X21, X9, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X6, D18
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X11, D19
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X29, D20
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X27, V21.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X27, D21
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X27
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X27, D22
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X27
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X16, D23
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X4, V24.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X4, D24
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X13, D25
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X27, D26
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X20, D27
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X21, X10, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X12, D28
    MOVZ  X10, #0x0, LSL #0
    SUB  X21, X10, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    FMOV  X9, D29
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
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
    FMOV  D0, X12
    FMOV  V0.D[1], X7
    FMOV  D1, X23
    FMOV  V1.D[1], X21
    FMOV  D2, X28
    FMOV  V2.D[1], X14
    FMOV  D3, X22
    FMOV  V3.D[1], X24
    FMOV  D4, X2
    FMOV  V4.D[1], X24
    FMOV  D5, X20
    FMOV  V5.D[1], X29
    FMOV  D6, X17
    FMOV  V6.D[1], X24
    FMOV  D7, X10
    FMOV  V7.D[1], X14
    FMOV  D8, X14
    FMOV  V8.D[1], X8
    FMOV  D9, X3
    FMOV  V9.D[1], X8
    FMOV  D10, X21
    FMOV  V10.D[1], X25
    FMOV  D11, X22
    FMOV  V11.D[1], X25
    FMOV  D12, X4
    FMOV  V12.D[1], X21
    FMOV  D13, X12
    FMOV  V13.D[1], X22
    FMOV  D14, X8
    FMOV  V14.D[1], X12
    FMOV  D15, X20
    FMOV  V15.D[1], X8
    FMOV  D16, X9
    FMOV  V16.D[1], X22
    FMOV  D17, X16
    FMOV  V17.D[1], X22
    FMOV  D18, X27
    FMOV  V18.D[1], X16
    FMOV  D19, X20
    FMOV  V19.D[1], X11
    FMOV  D20, X17
    FMOV  V20.D[1], X20
    FMOV  D21, X25
    FMOV  V21.D[1], X19
    FMOV  D22, X22
    FMOV  V22.D[1], X26
    FMOV  D23, X25
    FMOV  V23.D[1], X12
    FMOV  D24, X9
    FMOV  V24.D[1], X16
    FMOV  D25, X20
    FMOV  V25.D[1], X23
    FMOV  D26, X10
    FMOV  V26.D[1], X23
    FMOV  D27, X18
    FMOV  V27.D[1], X10
    FMOV  D28, X22
    FMOV  V28.D[1], X20
    FMOV  D29, X26
    FMOV  V29.D[1], X6
    FMOV  D30, X6
    FMOV  V30.D[1], X18
    FMOV  D31, X23
    FMOV  V31.D[1], X23
    MOVZ  X25, #0xa, LSL #0
TaishanSimdAddP01_label_1269:
    FCVTZU D29, D26, #6
    FCVTMS  D28, D21
    FCVTMS  W4, D22
    FRINTX  D17, D16
    FCSEL  H6, H17, H30, LT
    UCVTF  V4.4S, V16.4S
    FMOV  X18, D4
    FCVTZU  D31, D27
    FCVTNS  X23, D12
    FCVTZS  X6, S2, #11
    FRINTN  H4, H2
    FRINTZ  D17, D14
    FCVTZU  D22, D29
    FCVTNS  S30, S22
    FCVTZS  S27, S17
    FCSEL  S22, S27, S6, LS
    SCVTF D29, D26, #41
    FCVTMU  V2.4S, V9.4S
    FCVTZS V8.2D, V19.2D, #27
    FCVTZU  D30, D14
    FRINTI  S29, S28
    SCVTF  D21, D0
    FCVTZS D8, D31, #25
    FCVTAU  S29, S30
    FCVTZS  D31, D22
    FRINTA  H23, H8
    FCVTZU  V29.2D, V24.2D
    FCVTAS  D21, D26
    FMOV  W27, S0
    FRINTA  S8, S10
    FRINTP  S4, S10
    FCVTZU D24, D4, #18
    FCVTZS  S10, S29
    FRINTA  H31, H31
    DUP V21.2D, X14
    UCVTF  D2, D0
    FCVTPU  W22, S20
    FCVTZU  S12, S24
    SCVTF D24, D22, #16
    FMOV  X23, V29.D[1]
    FCVTZS  V2.2S, V4.2S
    FRINTI  S8, S5
    FCVTNU  S6, S28
    FCVTNU  V26.4S, V28.4S
    FCVTNS  X6, H24
    FRINTA  D10, D3
    SCVTF S28, S6, #11
    FCVTZS S15, S28, #5
    FCVTZS D17, D4, #14
    FCVTZU D2, D10, #44
    FCVTZU  V18.4S, V6.4S
    FCVTMS  D24, D24
    FMOV  X4, D18
    SCVTF  V3.4S, V8.4S, #11
    FCVTZU S28, S3, #19
    FCVTMS  S5, S19
    FCVTMS  D26, D16
    FRINTZ  D25, D12
    SCVTF D20, D30, #25
    FCVTZS V28.2D, V25.2D, #37
    FCVTZS  V30.2S, V22.2S, #4
    FCVTZU  W13, S16
    FCVTAS  D13, D0
    FRINTM  D21, D0
    FCVTPU  W6, D4
    FRINTN  S20, S3
    DUP V13.2D, X29
    FCVTAU  D12, D29
    FCVTNU  D0, D28
    SCVTF  D23, D13
    FCVTAS  D9, D20
    FCVTMU  D19, D17
    FCVTZS  V29.2S, V26.2S
    FCVTZU  V21.2S, V1.2S, #28
    UCVTF  V3.2S, V16.2S, #25
    FCVTZS  V26.4S, V14.4S, #29
    UCVTF D14, D1, #3
    FCVTAU  V17.4S, V29.4S
    FCVTNS  X29, S12
    FRINTZ  H9, H23
    UCVTF D13, D9, #37
    FCVTZS  V19.2S, V29.2S, #5
    FCVTAS  X18, S4
    FRINTZ  H5, H29
    UCVTF  V0.2S, V10.2S
    FRINTI  D26, D26
    FCVTPU  S19, S10
    FCVTZU S28, S14, #27
    FRINTX  S21, S28
    FCVTMU  S4, S28
    FRINTP  H19, H24
    FCVTZS D29, D28, #37
    FCVTPS  V27.2S, V18.2S
    FRINTP  D9, D17
    FCSEL  D23, D8, D13, MI
    FCVTAS  S3, S5
    FMOV  X2, D8
    FRINTZ  H9, H22
    SCVTF  V12.2D, V8.2D
    FCVTPU  S29, S5
    FCVTZU  S17, S8
    FRINTM  H28, H31
    FCVTNU  W8, H28
    FRINTZ  D28, D12
    FRINTX  S28, S28
    FCVTMS  V10.4S, V13.4S
    FCVTAU  D21, D30
    UCVTF D24, D25, #50
    FCVTZU  D17, D12
    SCVTF  V1.2S, V22.2S
    FCVTMU  X18, H3
    FCVTZS  D1, D26
    FCVTZS  D8, D14
    FCVTPU  D12, D29
    FCVTNU  V13.2S, V15.2S
    FCVTZS H22, H21, #14
    FCVTMU  X3, S6
    FCVTAU  S28, S5
    UCVTF V28.2D, V9.2D, #64
    FCVTPS  X19, D12
    FCVTZS  W13, D15, #27
    FRINTN  S14, S26
    FRINTM  D1, D23
    FCVTAS  S24, S12
    FRINTA  D0, D26
    FCVTMS  D1, D6
    FCVTNS  D16, D1
    UCVTF  D15, W21
    FCVTAU  S25, S21
    FCVTZU V7.2D, V14.2D, #34
    FCVTNS  D8, D23
    UCVTF  H9, W3, #12
    FRINTM  D13, D20
    FCVTNU  S4, S6
    FRINTM  S18, S28
    FCVTNS  D10, D5
    FCVTPU  V28.4S, V22.4S
    FRINTA  D19, D31
    FCVTZS V23.2D, V26.2D, #47
    FCVTAS  S12, S8
    FRINTZ  S16, S23
    FCVTNS  X29, D0
    FCVTPU  V1.4S, V26.4S
    FCVTAU  W23, H29
    FCVTZU  V9.2D, V23.2D
    FCVTPU  S9, S16
    FCVTZS  X26, D1
    UCVTF  V18.4S, V28.4S, #16
    UCVTF S8, S14, #17
    FCVTZU  D1, D18
    FCVTZU V29.2D, V12.2D, #25
    FCVTMU  W7, H9
    FCSEL  S13, S31, S19, GT
    FRINTZ  H4, H8
    FRINTZ  D5, D23
    FRINTZ  H1, H27
    SCVTF  V1.2S, V9.2S, #9
    FCVTAU  H21, H30
    UCVTF  V4.2D, V10.2D
    FRINTA  H4, H18
    FCVTPU  D8, D31
    FRINTP  H17, H31
    SCVTF  D31, D8
    UCVTF  S0, S22
    FRINTM  S4, S8
    FCVTAS  D9, D17
    FCVTNS  V9.4S, V17.4S
    FCVTZS S27, S26, #10
    FCVTZU S25, S4, #23
    SCVTF  S22, S2
    UCVTF D26, D19, #2
    SCVTF  D19, X26, #24
    SCVTF  D23, D11
    FCVTZU D11, D24, #54
    FCVTNS  S18, S4
    FCVTZU  V10.4S, V22.4S
    FCVTPU  D17, D10
    FCVTAU  X23, S22
    UCVTF  D7, W26
    FRINTN  D14, D22
    UCVTF D1, D22, #28
    SCVTF  S28, S3
    FCVTAS  S2, S31
    SCVTF S17, S12, #5
    SCVTF  V28.4S, V24.4S, #22
    FCVTZS S7, S2, #3
    FRINTX  D30, D31
    FRINTM  H27, H27
    FRINTM  D30, D23
    UCVTF  V30.2D, V8.2D
    FCVTAS  V4.2S, V0.2S
    FRINTP  S5, S2
    FCVTMS  S11, S4
    FCVTZS  S31, S18
    FRINTN  S22, S7
    FCVTZS  S12, S30
TaishanSimdAddP01_label_342:
    FCVTZS D28, D27, #4
TaishanSimdAddP01_label_790:
    SCVTF  D10, D6
    FCVTPU  D8, D14
    FCVTNS  S22, S1
    SUBS  X25, X25, #0x1
    B.NE  TaishanSimdAddP01_label_1269
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X13, X24, X12
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X17, X22, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X28, X22, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X16
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X19, X20, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X22, X21, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X24, X15, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X16, X21, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    FMOV  X6, D2
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X28, D3
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X14, D4
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X17, D6
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X25, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X26, X13, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X25, D7
    MOVZ  X13, #0x0, LSL #0
    SUB  X26, X13, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X18, D8
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X14, D9
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X8, D10
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X25, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    FMOV  X25, D11
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X13
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X13, D12
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X13
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X3, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X25, X8, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X3, D13
    MOVZ  X8, #0x0, LSL #0
    SUB  X25, X8, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X7, D14
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X28, X8, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    FMOV  X10, D15
    MOVZ  X8, #0x0, LSL #0
    SUB  X28, X8, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X24, D16
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X27, D17
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    FMOV  X26, D18
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X2, D19
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X18, V20.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X18, D20
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X26, X16, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X15, D21
    MOVZ  X16, #0x0, LSL #0
    SUB  X26, X16, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X13, D22
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X11
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X11, D23
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X11
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X6, D24
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X9, X17, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X15, D25
    MOVZ  X17, #0x0, LSL #0
    SUB  X9, X17, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X23, X17, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X18, D26
    MOVZ  X17, #0x0, LSL #0
    SUB  X23, X17, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X24, D27
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X14, D28
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X7, D29
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
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
    FMOV  D0, X11
    FMOV  V0.D[1], X20
    FMOV  D1, X11
    FMOV  V1.D[1], X26
    FMOV  D2, X29
    FMOV  V2.D[1], X26
    FMOV  D3, X27
    FMOV  V3.D[1], X9
    FMOV  D4, X3
    FMOV  V4.D[1], X28
    FMOV  D5, X3
    FMOV  V5.D[1], X27
    FMOV  D6, X2
    FMOV  V6.D[1], X28
    FMOV  D7, X14
    FMOV  V7.D[1], X7
    FMOV  D8, X20
    FMOV  V8.D[1], X29
    FMOV  D9, X2
    FMOV  V9.D[1], X29
    FMOV  D10, X17
    FMOV  V10.D[1], X3
    FMOV  D11, X11
    FMOV  V11.D[1], X19
    FMOV  D12, X23
    FMOV  V12.D[1], X14
    FMOV  D13, X8
    FMOV  V13.D[1], X23
    FMOV  D14, X28
    FMOV  V14.D[1], X20
    FMOV  D15, X6
    FMOV  V15.D[1], X18
    FMOV  D16, X20
    FMOV  V16.D[1], X18
    FMOV  D17, X16
    FMOV  V17.D[1], X12
    FMOV  D18, X4
    FMOV  V18.D[1], X19
    FMOV  D19, X18
    FMOV  V19.D[1], X27
    FMOV  D20, X9
    FMOV  V20.D[1], X29
    FMOV  D21, X13
    FMOV  V21.D[1], X10
    FMOV  D22, X26
    FMOV  V22.D[1], X21
    FMOV  D23, X27
    FMOV  V23.D[1], X3
    FMOV  D24, X28
    FMOV  V24.D[1], X6
    FMOV  D25, X24
    FMOV  V25.D[1], X23
    FMOV  D26, X18
    FMOV  V26.D[1], X20
    FMOV  D27, X2
    FMOV  V27.D[1], X13
    FMOV  D28, X8
    FMOV  V28.D[1], X16
    FMOV  D29, X4
    FMOV  V29.D[1], X6
    FMOV  D30, X8
    FMOV  V30.D[1], X29
    FMOV  D31, X11
    FMOV  V31.D[1], X3
    MOVZ  X9, #0xf, LSL #0
TaishanSimdAddP01_label_1347:
    FRINTI  S24, S25
    FRINTI  H19, H23
    FRINTX  S19, S25
    SCVTF S26, S20, #17
    FRINTP  D9, D11
    UCVTF D22, D0, #21
    FCVTAS  D30, D24
    FRINTA  D18, D21
    FCVTMS  S11, S21
    FCVTPU  D19, D20
    FCVTMU  V16.2S, V19.2S
    FCVTMS  W11, S28
    FMOV  W3, S0
    FCVTMU  S19, S5
    FCVTAU  D29, D4
    FCSEL  S29, S6, S2, LS
    FCVTMU  D23, D31
    FCVTMS  S28, S18
    UCVTF  V15.2D, V14.2D
    FCVTNS  S7, S27
    FCVTAS  S19, S26
    FCVTZU  S19, S0
    UCVTF  S31, S29
    FCVTNU  V28.2D, V12.2D
    SCVTF  S24, S18
    FCVTPU  D25, D7
    FMOV  X27, D9
    FCVTMU  D20, D14
    FRINTA  D17, D16
    FCVTZS  V14.2S, V21.2S
    SCVTF  D5, D0
    FCVTAS  S23, S25
    FRINTA  S23, S26
    FCVTPS  S20, S10
    UCVTF  V10.2S, V0.2S
    FRINTI  D3, D0
    SCVTF S6, S21, #14
    FCVTNS  V22.4S, V13.4S
    FCVTNU  X8, H28
    FCVTZS V12.2D, V13.2D, #29
    FRINTX  H15, H18
    FRINTA  D18, D1
    UCVTF  H23, W2
    UCVTF  V8.2S, V0.2S
    FRINTN  H16, H2
    FMOV  X6, D25
    FRINTI  S2, S7
    FCVTZS  V22.2D, V15.2D
    FCVTNU  W3, H31
    FCVTZU  D4, D28
    UCVTF S10, S12, #22
    FCVTMU  S11, S4
    FRINTI  D3, D24
    FCVTNS  W15, S27
    FCVTPS  S27, S14
    FCVTAU  W10, D27
    FCVTMU  H10, H27
    FCVTPS  S27, S0
    FCVTMU  S25, S0
    FCVTZU  D26, D28
    SCVTF V19.2D, V8.2D, #7
    FCVTZS  V8.2S, V1.2S, #31
    FCVTZU  V16.4H, V6.4H, #3
    FCVTNS  D10, D1
    FCVTPS  S29, S17
    FCVTPS  S30, S17
    FRINTM  H30, H6
    FRINTM  H22, H11
    FCVTMS  W25, D10
    UCVTF  S24, S4
    FCVTZU  D28, D6
    FCVTAU  D6, D24
    FRINTM  D28, D8
    FCVTNU  D4, D11
    FCVTMS  S29, S5
    FRINTZ  S26, S27
    FRINTP  S25, S17
    FMOV  V5.D[1], X24
    FRINTA  S7, S0
    SCVTF  S11, S12
    FCVTNU  V6.4S, V8.4S
    SCVTF V22.2D, V30.2D, #55
    FCVTMS  V1.2D, V29.2D
    DUP V22.2D, X14
    FCVTPU  S26, S3
    FRINTZ  H24, H30
    FCVTPU  D11, D15
    FCVTMU  V25.4S, V6.4S
    FMOV  V12.D[1], X14
    UCVTF V24.2D, V3.2D, #17
    FCVTZU D31, D7, #64
    FCVTZS  S13, S24
    FRINTI  D0, D3
    FCVTMS  S5, S6
    FCVTPS  W27, S31
    FCVTZU V8.2D, V26.2D, #6
    FCVTAS  V30.2S, V20.2S
    FCVTPU  D7, D2
    DUP V30.8H, W8
    FCVTZS S2, S14, #4
    FCSEL  D9, D19, D8, GE
    FCVTAU  V23.2S, V4.2S
    FCVTZU  V28.4S, V17.4S
    FCVTPU  V30.2S, V1.2S
    SCVTF D0, D17, #64
    FCVTAS  S22, S5
    FRINTN  D27, D30
    FCVTAU  S3, S17
    FCVTPS  W10, H2
    UCVTF V5.2D, V28.2D, #33
    SCVTF S3, S0, #31
    FCVTPU  V26.2S, V2.2S
    SCVTF  V24.4S, V22.4S, #4
    FCVTZS V0.2D, V22.2D, #58
    UCVTF  V3.4S, V24.4S, #15
    FCVTAU  D30, D7
    FCVTZU D24, D29, #34
    FRINTN  H20, H30
    FRINTP  S2, S24
    FRINTX  S27, S23
    FCVTMU  D4, D6
    FCVTNS  D3, D4
    UCVTF  V23.2D, V20.2D
    FCVTZU  W2, S25, #10
    UCVTF S10, S8, #11
    FCVTMS  D8, D21
    FRINTN  S2, S17
    FCVTMS  S5, S9
    FCVTPU  V20.2S, V19.2S
    FCVTNU  X20, D23
    FCVTNU  V20.2S, V26.2S
    FCVTMS  D13, D12
    FCVTNU  S10, S3
    FCVTZS  D3, D26
    FCVTMU  X24, D30
    FRINTN  D3, D4
    FCVTNS  X10, D5
    FCVTPU  V19.8H, V8.8H
    FRINTP  D8, D4
    FRINTP  S13, S14
    FCVTZU S14, S7, #20
    FCVTMS  S7, S15
    DUP V2.8H, W10
    FRINTN  H13, H10
    FCVTPU  D20, D31
    FRINTP  S3, S24
    FCVTZS S24, S1, #16
    FCVTPU  X8, H20
    FRINTA  S13, S21
    UCVTF D30, D15, #29
    FCVTPU  D10, D21
    FCVTPS  D12, D30
    FCVTAS  D4, D8
    FCSEL  H2, H25, H5, LS
    FMOV  X19, D19
    FCVTAU  V30.4S, V5.4S
    UCVTF D24, D7, #39
    UCVTF V5.2D, V2.2D, #46
    FCVTNS  S17, S31
    FCVTNS  S12, S0
    FCVTZU V4.2D, V24.2D, #21
    UCVTF D30, D30, #5
    SCVTF  S15, S30
    FRINTN  D30, D4
    FMOV  X11, D7
    FRINTZ  H30, H29
    FCVTZS  V30.4S, V4.4S
    SCVTF  D30, D16
    FCVTPU  S23, S19
    FRINTM  D15, D24
    FCVTZS  V18.2D, V5.2D
    FRINTN  S15, S10
    UCVTF  S1, S3
    FMOV  X16, D24
    UCVTF  D25, W12
    FRINTI  H13, H2
    FRINTN  S3, S31
    FCVTMS  D18, D10
    FMOV  V8.D[1], X10
    FRINTM  H7, H4
    FCVTPU  S21, S17
    FCVTZS V17.2D, V29.2D, #49
    FCVTZS D25, D16, #37
    FCVTNS  V24.2D, V0.2D
    FCVTAU  S23, S23
    FRINTP  D25, D13
    UCVTF  H2, X15
    DUP V29.8B, W9
    UCVTF D30, D0, #18
    FCVTAU  W29, S10
    FCVTPU  S15, S20
    FCVTAU  V17.4S, V17.4S
    FCVTNU  D19, D22
    FCVTMS  D29, D10
    FRINTA  D20, D17
    FCVTZS  D24, D22
    SCVTF  D30, W2, #9
    FCVTPU  S13, S30
    FCVTMS  V23.2S, V17.2S
    FCVTNU  V13.4S, V30.4S
    SUBS  X9, X9, #0x1
    B.NE  TaishanSimdAddP01_label_1347
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X3
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X2, X9, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X2, X22, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X12, X3, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X24, X7, X9
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X2, X20, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X12
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X13
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X17, X2, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X17
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X7, X28, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X4, X24, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X26
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X25, X8, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X29
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X27, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X6, X18, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X27, D2
    MOVZ  X18, #0x0, LSL #0
    SUB  X6, X18, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X10, V3.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X20, X21, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X10, D3
    MOVZ  X21, #0x0, LSL #0
    SUB  X20, X21, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X28, D4
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X13, D6
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X14, X12, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X17, D7
    MOVZ  X12, #0x0, LSL #0
    SUB  X14, X12, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X18, D8
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X19, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X19, D9
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X25, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X25, D10
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X28, D11
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X3, D12
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X19, X12, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X11, D13
    MOVZ  X12, #0x0, LSL #0
    SUB  X19, X12, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X12, X10, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X27, D14
    MOVZ  X10, #0x0, LSL #0
    SUB  X12, X10, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X21, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    FMOV  X21, D15
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    FMOV  X3, V16.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X3, D16
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X28, D17
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X29, D18
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X24, D19
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X15, D20
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X13, X22, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X16, D21
    MOVZ  X22, #0x0, LSL #0
    SUB  X13, X22, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X26, D22
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X29
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X29, D23
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X29
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X12, D24
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X28, D25
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X18, X23, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    FMOV  X6, D26
    MOVZ  X23, #0x0, LSL #0
    SUB  X18, X23, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X4, D27
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X29, D28
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X23, D29
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0xd81f, LSL #0
    MOVK  X2, #0xb9ad, LSL #16
    MOVK  X2, #0xb307, LSL #32
    MOVK  X2, #0xb086, LSL #48
    MOVZ  X3, #0x59b5, LSL #0
    MOVK  X3, #0x9867, LSL #16
    MOVK  X3, #0xca94, LSL #32
    MOVK  X3, #0x8319, LSL #48
    MOVZ  X4, #0xbf2f, LSL #0
    MOVK  X4, #0x231c, LSL #16
    MOVK  X4, #0xc49a, LSL #32
    MOVK  X4, #0x8629, LSL #48
    MOVZ  X6, #0xea1c, LSL #0
    MOVK  X6, #0x9aaf, LSL #16
    MOVK  X6, #0xb234, LSL #32
    MOVK  X6, #0xa4d1, LSL #48
    MOVZ  X7, #0x8e43, LSL #0
    MOVK  X7, #0x6a77, LSL #16
    MOVK  X7, #0x9c47, LSL #32
    MOVK  X7, #0x4c22, LSL #48
    MOVZ  X8, #0x4275, LSL #0
    MOVK  X8, #0xce82, LSL #16
    MOVK  X8, #0xdab6, LSL #32
    MOVK  X8, #0xb68f, LSL #48
    MOVZ  X9, #0xc08b, LSL #0
    MOVK  X9, #0x21c9, LSL #16
    MOVK  X9, #0xa68d, LSL #32
    MOVK  X9, #0xa80e, LSL #48
    MOVZ  X10, #0xbc9a, LSL #0
    MOVK  X10, #0x40fe, LSL #16
    MOVK  X10, #0x60f5, LSL #32
    MOVK  X10, #0x10ed, LSL #48
    MOVZ  X11, #0x4dd, LSL #0
    MOVK  X11, #0xbe74, LSL #16
    MOVK  X11, #0xaf59, LSL #32
    MOVK  X11, #0xf086, LSL #48
    MOVZ  X12, #0x5427, LSL #0
    MOVK  X12, #0x6cb7, LSL #16
    MOVK  X12, #0x381c, LSL #32
    MOVK  X12, #0x4138, LSL #48
    MOVZ  X13, #0x8ad7, LSL #0
    MOVK  X13, #0xe52c, LSL #16
    MOVK  X13, #0x2490, LSL #32
    MOVK  X13, #0x6322, LSL #48
    MOVZ  X14, #0x9156, LSL #0
    MOVK  X14, #0xbf3a, LSL #16
    MOVK  X14, #0x1ad4, LSL #32
    MOVK  X14, #0x2fbd, LSL #48
    MOVZ  X15, #0x4d41, LSL #0
    MOVK  X15, #0x26aa, LSL #16
    MOVK  X15, #0x54d3, LSL #32
    MOVK  X15, #0x3a24, LSL #48
    MOVZ  X16, #0x890, LSL #0
    MOVK  X16, #0xa1e6, LSL #16
    MOVK  X16, #0x8d6f, LSL #32
    MOVK  X16, #0x2539, LSL #48
    MOVZ  X17, #0xefe4, LSL #0
    MOVK  X17, #0xcf29, LSL #16
    MOVK  X17, #0xe5c2, LSL #32
    MOVK  X17, #0xfaf0, LSL #48
    MOVZ  X18, #0xcca, LSL #0
    MOVK  X18, #0x8021, LSL #16
    MOVK  X18, #0xa07d, LSL #32
    MOVK  X18, #0x9435, LSL #48
    MOVZ  X19, #0xe77d, LSL #0
    MOVK  X19, #0x8878, LSL #16
    MOVK  X19, #0xc33b, LSL #32
    MOVK  X19, #0xc76, LSL #48
    MOVZ  X20, #0x9f26, LSL #0
    MOVK  X20, #0xc7ca, LSL #16
    MOVK  X20, #0x5f64, LSL #32
    MOVK  X20, #0xba50, LSL #48
    MOVZ  X21, #0x2963, LSL #0
    MOVK  X21, #0x2901, LSL #16
    MOVK  X21, #0x9f3f, LSL #32
    MOVK  X21, #0x1c78, LSL #48
    MOVZ  X22, #0xec33, LSL #0
    MOVK  X22, #0x5d1c, LSL #16
    MOVK  X22, #0x27b5, LSL #32
    MOVK  X22, #0xf5e6, LSL #48
    MOVZ  X23, #0x219e, LSL #0
    MOVK  X23, #0x4c43, LSL #16
    MOVK  X23, #0x5733, LSL #32
    MOVK  X23, #0x166d, LSL #48
    MOVZ  X24, #0x2c78, LSL #0
    MOVK  X24, #0x20be, LSL #16
    MOVK  X24, #0xf620, LSL #32
    MOVK  X24, #0x193f, LSL #48
    MOVZ  X25, #0x9b7b, LSL #0
    MOVK  X25, #0xb4d8, LSL #16
    MOVK  X25, #0x2351, LSL #32
    MOVK  X25, #0x692d, LSL #48
    MOVZ  X26, #0x334c, LSL #0
    MOVK  X26, #0x5993, LSL #16
    MOVK  X26, #0x5833, LSL #32
    MOVK  X26, #0x63db, LSL #48
    MOVZ  X27, #0x3f14, LSL #0
    MOVK  X27, #0xbd4c, LSL #16
    MOVK  X27, #0x2c68, LSL #32
    MOVK  X27, #0xf60a, LSL #48
    MOVZ  X28, #0x5286, LSL #0
    MOVK  X28, #0xede6, LSL #16
    MOVK  X28, #0x921b, LSL #32
    MOVK  X28, #0xad7a, LSL #48
    MOVZ  X29, #0x55ce, LSL #0
    MOVK  X29, #0x7d9a, LSL #16
    MOVK  X29, #0x2952, LSL #32
    MOVK  X29, #0xd303, LSL #48
    FMOV  D0, X8
    FMOV  V0.D[1], X16
    FMOV  D1, X21
    FMOV  V1.D[1], X20
    FMOV  D2, X24
    FMOV  V2.D[1], X22
    FMOV  D3, X7
    FMOV  V3.D[1], X27
    FMOV  D4, X8
    FMOV  V4.D[1], X19
    FMOV  D5, X24
    FMOV  V5.D[1], X26
    FMOV  D6, X28
    FMOV  V6.D[1], X8
    FMOV  D7, X8
    FMOV  V7.D[1], X24
    FMOV  D8, X25
    FMOV  V8.D[1], X28
    FMOV  D9, X10
    FMOV  V9.D[1], X6
    FMOV  D10, X24
    FMOV  V10.D[1], X4
    FMOV  D11, X21
    FMOV  V11.D[1], X25
    FMOV  D12, X27
    FMOV  V12.D[1], X28
    FMOV  D13, X13
    FMOV  V13.D[1], X12
    FMOV  D14, X19
    FMOV  V14.D[1], X7
    FMOV  D15, X17
    FMOV  V15.D[1], X17
    FMOV  D16, X26
    FMOV  V16.D[1], X18
    FMOV  D17, X28
    FMOV  V17.D[1], X20
    FMOV  D18, X14
    FMOV  V18.D[1], X3
    FMOV  D19, X10
    FMOV  V19.D[1], X17
    FMOV  D20, X12
    FMOV  V20.D[1], X3
    FMOV  D21, X27
    FMOV  V21.D[1], X2
    FMOV  D22, X18
    FMOV  V22.D[1], X11
    FMOV  D23, X13
    FMOV  V23.D[1], X12
    FMOV  D24, X24
    FMOV  V24.D[1], X18
    FMOV  D25, X8
    FMOV  V25.D[1], X28
    FMOV  D26, X9
    FMOV  V26.D[1], X13
    FMOV  D27, X6
    FMOV  V27.D[1], X26
    FMOV  D28, X29
    FMOV  V28.D[1], X7
    FMOV  D29, X27
    FMOV  V29.D[1], X9
    FMOV  D30, X11
    FMOV  V30.D[1], X3
    FMOV  D31, X16
    FMOV  V31.D[1], X28
    MOVZ  X2, #0xa, LSL #0
TaishanSimdAddP01_label_1429:
    FCVTPU  D31, D8
    FCVTZS V0.2D, V14.2D, #29
    FRINTI  H26, H31
    UCVTF V12.2D, V21.2D, #12
    FRINTZ  D19, D31
    SCVTF  V30.2D, V5.2D
    FRINTZ  D7, D28
    FCVTPU  D22, D26
    SCVTF  S13, W26, #8
    FCVTZS D6, D29, #9
    FCVTZS V3.2D, V30.2D, #3
    FCVTPS  S0, S3
    FCVTAU  D14, D12
    FCVTNU  S11, S15
    FMOV  V0.D[1], X10
    FCVTMU  V6.2S, V24.2S
    UCVTF S3, S11, #30
    FRINTI  H9, H10
    FCVTZS V28.2D, V8.2D, #34
    FCVTMS  D8, D7
    FCVTMS  D21, D22
    FMOV  W26, S26
    FCVTMU  S24, S25
    FCVTMU  W25, H5
    FCVTMS  S16, S16
    SCVTF  V7.2S, V20.2S
    FRINTM  H28, H14
    FCVTZS V9.2D, V13.2D, #52
    FCVTAU  D11, D16
    FCVTPS  D3, D2
    FRINTA  S0, S7
    SCVTF D10, D21, #42
    FCVTAS  D12, D26
    FCVTMU  W27, H12
    FCVTAU  S6, S3
    FRINTP  S6, S10
    FRINTI  D24, D20
    SCVTF V10.2D, V25.2D, #64
    FCVTZU V6.2D, V1.2D, #60
    FCSEL  S20, S24, S20, PL
    FRINTI  D24, D24
    FCVTNU  S7, S25
    FRINTA  D3, D13
    FCVTNU  D12, D3
    FRINTZ  S1, S0
    FCVTZU  D9, D22
    SCVTF  V13.4S, V7.4S
    UCVTF  V27.2S, V17.2S, #19
    FCVTZU  X16, S20
    FCVTAU  V13.2D, V10.2D
    SCVTF  V17.2S, V22.2S, #4
    FCVTPS  D17, D10
    FCVTZS  V6.2S, V19.2S, #25
    FRINTM  D25, D22
    FCVTZS  D27, D14
    SCVTF S15, S27, #15
    FMOV  V19.D[1], X4
    FCVTZS D21, D13, #22
    FCVTAS  X26, D21
    FCVTPS  D0, D26
    FCVTAU  H26, H2
    UCVTF  S11, X19
    FCVTZS  X10, S13
    FRINTX  S2, S20
    FCVTZS  D15, D5
    FCVTZU D31, D5, #12
    FCVTAU  D29, D17
    FCVTZU  S10, S13
    FCVTMU  V6.2D, V9.2D
    FCVTMU  V24.4S, V24.4S
    FCVTNS  D29, D1
    FCVTMU  D20, D27
    SCVTF  S21, S19
    FMOV  X10, V5.D[1]
    FMOV  W19, S7
    FCVTMS  S5, S27
    FCVTPS  S31, S11
    FMOV  V11.D[1], X2
    UCVTF V5.2D, V24.2D, #58
    UCVTF  S25, S22
    FRINTI  S26, S16
    SCVTF S0, S29, #14
    FCVTZS  V17.4S, V25.4S
    FCVTAS  V21.2S, V27.2S
    FCVTNS  S16, S29
    FCVTPS  D20, D0
    FRINTZ  H27, H17
    FCVTPS  V9.4S, V1.4S
    FCVTZU  V21.4S, V26.4S, #4
    FCVTZS  X22, D19, #20
    FCVTZS  S6, S23
    FCVTMS  D26, D20
    FRINTZ  D5, D17
    FCVTMU  S24, S31
    FCVTZS V21.2D, V15.2D, #35
    FCVTMS  S3, S27
    FRINTN  D25, D11
    UCVTF  H15, X28, #12
    FCVTZS  S23, S18
    FCVTMS  V11.2S, V9.2S
    FCSEL  S6, S2, S18, PL
    UCVTF V14.2D, V17.2D, #51
    FRINTI  H8, H11
    FCVTPS  S21, S16
    FCVTNS  W18, H20
    FCVTNU  S24, S28
    FRINTA  S14, S26
    FCVTPS  S31, S11
    FMOV  X19, D1
    FMOV  X8, V13.D[1]
    FCVTMS  V26.2D, V15.2D
    FRINTA  D15, D0
    FCVTPU  S14, S20
    FCVTAU  V6.2S, V6.2S
    FRINTP  H21, H23
    FCVTPS  S9, S28
    UCVTF  S24, S7
    FRINTP  D9, D13
    FCVTMS  V23.2S, V21.2S
    SCVTF D6, D1, #45
    UCVTF  S13, X6
    FCVTZS D2, D23, #35
    FCVTMS  D25, D21
    UCVTF  V4.4S, V18.4S, #7
    FRINTX  S22, S21
    FCVTNS  D15, D9
    FCVTNU  V24.2D, V17.2D
    FMOV  X3, D28
    UCVTF  V30.4S, V8.4S
    FRINTP  H25, H4
    FCVTPU  V28.2S, V28.2S
    FRINTA  D23, D21
    FRINTZ  D1, D21
    UCVTF V1.2D, V16.2D, #26
    FCVTZS S24, S8, #23
    FCVTAS  V23.4S, V14.4S
    FRINTP  D18, D2
    UCVTF V8.2D, V5.2D, #15
    FCVTMU  S21, S13
    FCVTMU  S13, S10
    FRINTZ  S23, S22
    FCVTAU  S11, S9
    FRINTN  S6, S24
    FRINTZ  D10, D16
    SCVTF S23, S4, #14
    FCVTZS  W3, S4, #6
    FCVTAU  S22, S22
    FMOV  V14.D[1], X29
    FCVTAU  D30, D28
    FRINTA  S25, S6
    FCVTZS  V15.2S, V3.2S, #30
    FCVTZS D8, D2, #18
    SCVTF  S1, S16
    SCVTF  S6, S25
    FCVTZS  D1, D26
    FRINTN  H10, H5
    FCVTMS  S4, S3
    SCVTF  D24, W29
    FRINTZ  S11, S26
    FRINTX  S2, S21
    FCVTNS  D11, D18
    FCVTAS  S9, S5
    SCVTF  S22, S26
    SCVTF  V7.4S, V30.4S
    FCVTNS  V8.2D, V4.2D
    FCVTAS  V4.8H, V14.8H
    FCVTMS  V28.2D, V19.2D
    FRINTM  S3, S6
    FCVTMS  S27, S26
    FCVTZS  V3.2S, V9.2S, #22
    FRINTX  H2, H1
    FRINTZ  H22, H15
    FRINTA  S3, S11
    FCVTPS  X23, D0
    FCVTMU  D26, D0
    FCVTNS  S6, S17
    FCVTMU  D21, D17
    FCVTMS  X18, D11
    FCVTZS  D31, D13
    FCVTMS  D11, D28
    FCVTMU  X8, S19
    FCVTPU  D15, D7
    SCVTF  D15, X6, #36
    FCVTMS  X13, D11
    FCSEL  S13, S25, S14, LT
    FCVTZS V15.2D, V0.2D, #48
    FCVTZU  V28.4H, V17.4H, #2
    FCVTAS  D19, D23
    FCVTMS  D9, D14
    FRINTN  H5, H12
    UCVTF V11.2D, V29.2D, #11
    FMOV  X21, V21.D[1]
    FCVTZU  V11.2S, V28.2S
    FCVTAS  X17, H11
    FRINTA  D29, D9
    SCVTF  V7.2S, V29.2S, #3
    FCVTNS  V18.2D, V17.2D
    SCVTF V15.2D, V10.2D, #36
    SCVTF V12.2D, V31.2D, #36
    FRINTZ  H31, H13
    SUBS  X2, X2, #0x1
    B.NE  TaishanSimdAddP01_label_1429
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X29, #0xbf2f, LSL #0
    MOVK  X29, #0x231c, LSL #16
    MOVK  X29, #0xc49a, LSL #32
    MOVK  X29, #0x8629, LSL #48
    SUB  X7, X29, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    MOVZ  X28, #0xea1c, LSL #0
    MOVK  X28, #0x9aaf, LSL #16
    MOVK  X28, #0xb234, LSL #32
    MOVK  X28, #0xa4d1, LSL #48
    SUB  X20, X28, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X29, X26, X8
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    MOVZ  X26, #0xc08b, LSL #0
    MOVK  X26, #0x21c9, LSL #16
    MOVK  X26, #0xa68d, LSL #32
    MOVK  X26, #0xa80e, LSL #48
    SUB  X25, X26, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X16, #0x5427, LSL #0
    MOVK  X16, #0x6cb7, LSL #16
    MOVK  X16, #0x381c, LSL #32
    MOVK  X16, #0x4138, LSL #48
    SUB  X21, X16, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
TaishanSimdAddP01_label_73:
    MOVZ  X21, #0x0, LSL #0
    SUB  X20, X21, X13
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    MOVZ  X3, #0x9156, LSL #0
    MOVK  X3, #0xbf3a, LSL #16
    MOVK  X3, #0x1ad4, LSL #32
    MOVK  X3, #0x2fbd, LSL #48
    SUB  X26, X3, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    MOVZ  X12, #0x5427, LSL #0
    MOVK  X12, #0x6cb7, LSL #16
    MOVK  X12, #0x381c, LSL #32
    MOVK  X12, #0x4138, LSL #48
    SUB  X24, X12, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X17
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X3, X18, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X22
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X19, X7, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X6, X24, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X7, #0xea1c, LSL #0
    MOVK  X7, #0x9aaf, LSL #16
    MOVK  X7, #0xb234, LSL #32
    MOVK  X7, #0xa4d1, LSL #48
    SUB  X9, X7, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X13, X19, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X29, D2
    MOVZ  X19, #0x0, LSL #0
    SUB  X13, X19, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X17, V3.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X17
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X17, D3
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X17
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X26, #0x5d, LSL #0
    MOVK  X26, #0xffc8, LSL #48
    SUB  X9, X26, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X17, D4
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X12, D6
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X2, D7
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X11, D8
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X4, D9
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAddP01_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X11, D10
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X24, D11
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X11, D12
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X7, D13
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X29, #0x55ce, LSL #0
    MOVK  X29, #0x7d9a, LSL #16
    MOVK  X29, #0x2952, LSL #32
    MOVK  X29, #0xd303, LSL #48
    SUB  X21, X29, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X4, D14
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X24, D15
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X24, X25, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X20, D16
    MOVZ  X25, #0x0, LSL #0
    SUB  X24, X25, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X7, D17
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X3, D18
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X14, D19
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X22, V20.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X22, D20
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X11, D21
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X9, D22
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X25, V23.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X25, D23
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X22, V24.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X22, D24
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7380, LSL #16
    MOVK  X4, #0x6695, LSL #32
    MOVK  X4, #0x41df, LSL #48
    SUB  X7, X4, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X23, D25
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X16
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X16, D26
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X16
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X17, D27
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X4, D28
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X8, D29
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
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
    FMOV  D0, X21
    FMOV  V0.D[1], X2
    FMOV  D1, X11
    FMOV  V1.D[1], X24
    FMOV  D2, X6
    FMOV  V2.D[1], X20
    FMOV  D3, X23
    FMOV  V3.D[1], X22
    FMOV  D4, X28
    FMOV  V4.D[1], X8
    FMOV  D5, X29
    FMOV  V5.D[1], X20
    FMOV  D6, X27
    FMOV  V6.D[1], X17
    FMOV  D7, X21
    FMOV  V7.D[1], X7
    FMOV  D8, X25
    FMOV  V8.D[1], X11
    FMOV  D9, X21
    FMOV  V9.D[1], X2
    FMOV  D10, X8
    FMOV  V10.D[1], X29
    FMOV  D11, X18
    FMOV  V11.D[1], X10
    FMOV  D12, X13
    FMOV  V12.D[1], X4
    FMOV  D13, X14
    FMOV  V13.D[1], X17
    FMOV  D14, X2
    FMOV  V14.D[1], X29
    FMOV  D15, X8
    FMOV  V15.D[1], X21
    FMOV  D16, X24
    FMOV  V16.D[1], X26
    FMOV  D17, X18
    FMOV  V17.D[1], X3
    FMOV  D18, X18
    FMOV  V18.D[1], X2
    FMOV  D19, X19
    FMOV  V19.D[1], X7
    FMOV  D20, X8
    FMOV  V20.D[1], X17
    FMOV  D21, X11
    FMOV  V21.D[1], X21
    FMOV  D22, X11
    FMOV  V22.D[1], X28
    FMOV  D23, X3
    FMOV  V23.D[1], X26
    FMOV  D24, X20
    FMOV  V24.D[1], X19
    FMOV  D25, X27
    FMOV  V25.D[1], X2
    FMOV  D26, X3
    FMOV  V26.D[1], X21
    FMOV  D27, X8
    FMOV  V27.D[1], X23
    FMOV  D28, X28
    FMOV  V28.D[1], X29
    FMOV  D29, X12
    FMOV  V29.D[1], X10
    FMOV  D30, X18
    FMOV  V30.D[1], X19
    FMOV  D31, X21
    FMOV  V31.D[1], X18
    MOVZ  X4, #0xa, LSL #0
TaishanSimdAddP01_label_1504:
    SCVTF  V10.4S, V26.4S, #19
    FCVTMS  X16, D2
    FCVTNU  D13, D26
    SCVTF V22.2D, V10.2D, #49
    FRINTN  S13, S20
    FCVTNS  D28, D7
    FCVTPS  H17, H15
    FRINTA  S26, S4
    FCVTMU  V16.4S, V18.4S
    FCVTPS  S8, S31
    UCVTF S4, S22, #6
    UCVTF D3, D7, #8
TaishanSimdAddP01_label_1378:
    FCVTNU  D29, D21
    FRINTN  H18, H2
    SCVTF  V16.2S, V0.2S, #3
    FRINTM  H29, H29
    FCVTNS  D6, D4
    FCVTNU  W16, D13
    FMOV  W18, S27
    FCVTAU  V13.2S, V5.2S
    FRINTX  S28, S8
    FCVTAU  D5, D10
    FCVTZS S29, S2, #22
    UCVTF  D29, D21
    FCVTNU  H23, H9
    FCVTMS  S19, S29
    FRINTM  S17, S17
    SCVTF  S0, S20
    FCVTZS  D28, D17
    FCVTZS  V3.4S, V30.4S
    SCVTF  V19.2S, V14.2S, #1
    FCVTZS S3, S29, #15
    FCVTZS  V14.4S, V27.4S, #1
    UCVTF  S23, S27
    FCVTPU  S18, S26
    UCVTF  V18.4S, V3.4S
    FCVTNU  D27, D13
    FMOV  X2, D3
    FCVTNU  X7, H0
    FCVTZS  V28.2S, V25.2S
    FCVTZS  V11.4S, V30.4S
    FCVTZU V5.2D, V21.2D, #28
    FCVTNS  S24, S28
    FCVTMS  W17, H12
    SCVTF  V25.4S, V24.4S
    FCVTAU  V13.2S, V1.2S
    FRINTN  S5, S19
    FRINTZ  D8, D15
    FRINTX  D10, D4
    FCVTAS  D18, D25
    FCVTAS  D16, D30
    FCVTAU  D26, D8
    FRINTN  D15, D18
    FMOV  X8, V18.D[1]
    SCVTF  S26, S1
    UCVTF D15, D5, #21
    FCVTPS  S5, S29
    FMOV  X27, D20
    FCVTZS  D13, D19
    FCVTMU  S1, S4
    FRINTN  S10, S16
    FCVTZS  S26, S25
    FRINTZ  D18, D25
    SCVTF D18, D12, #18
    FCVTZU D26, D24, #1
    FRINTZ  H30, H15
    FCVTPS  S4, S22
    FCVTZS S22, S8, #19
    SCVTF  V6.2S, V15.2S, #8
    FCVTZU  V18.2D, V19.2D
    FCVTZS  V19.4S, V21.4S, #32
    SCVTF S8, S19, #18
    FRINTI  D8, D15
    FRINTN  H27, H11
    FCVTMU  X29, H7
    FCVTZS D24, D18, #24
    FCVTZU  X9, H30, #38
    FCVTZS  V22.4S, V9.4S, #18
    FRINTP  H23, H25
    FCVTAU  D12, D8
    FCVTNS  V18.4S, V6.4S
    FRINTM  S12, S13
    FCVTAU  V12.2D, V21.2D
    FCVTPU  V10.2D, V5.2D
    FCSEL  D11, D24, D29, MI
    FCVTAU  V15.4S, V19.4S
    FCVTMU  D22, D11
    FRINTZ  H11, H22
    FCVTAS  V24.4H, V1.4H
    FRINTP  D27, D30
    FRINTZ  D18, D31
    FRINTA  S8, S6
    FCVTAS  D23, D13
    FCVTZU  V28.2S, V20.2S, #20
    FMOV  X8, V25.D[1]
    FCVTPU  S12, S18
    FRINTZ  H0, H11
    FCVTPS  V17.2S, V24.2S
    FCVTZS V8.2D, V3.2D, #56
    FRINTP  S13, S13
    FCVTPS  S28, S10
    FCVTPS  S27, S23
    FRINTX  S5, S16
    UCVTF S2, S2, #9
    FRINTN  D21, D8
    FRINTP  S24, S30
    UCVTF V2.2D, V20.2D, #8
    FRINTM  D18, D6
    FCVTMS  V2.2S, V31.2S
    FCVTZU  V30.4S, V5.4S, #17
    FRINTZ  D12, D3
    SCVTF  D4, D17
    FCSEL  D31, D8, D3, LS
    FRINTN  H27, H15
    FCVTZU  D11, D4
    UCVTF  S30, S4
    FCVTPS  D16, D18
    UCVTF  D26, D2
    SCVTF V2.2D, V2.2D, #45
    SCVTF D30, D9, #32
    FCVTAS  D16, D20
    FCVTZS V18.2D, V15.2D, #11
    FRINTZ  S25, S24
    SCVTF  V7.4S, V21.4S
    FCVTZS V2.2D, V19.2D, #43
    FCVTZU V6.2D, V10.2D, #36
    FMOV  V10.D[1], X8
    FCVTAU  V26.2D, V16.2D
    FCVTMU  V26.2D, V4.2D
    FCVTPS  S9, S18
    FCVTPU  V10.4S, V11.4S
    SCVTF  V3.2S, V1.2S, #23
    FCVTPS  D13, D16
    UCVTF V30.2D, V30.2D, #41
    FRINTM  S19, S26
    FCVTMS  S5, S9
    FCVTZU  D16, D24
    FCVTZU V1.2D, V30.2D, #52
    FCVTZU  V5.2D, V30.2D
    FRINTZ  D13, D20
    UCVTF  S9, S13
    FRINTZ  D21, D24
    DUP V3.4H, W21
    FCVTPS  D12, D10
    FCVTPS  S21, S17
    FCVTMS  D11, D12
    FRINTZ  S2, S2
TaishanSimdAddP01_label_1408:
    UCVTF  V20.2S, V12.2S, #22
    FRINTX  D9, D2
    FRINTN  D5, D9
    FRINTN  D28, D16
    FCVTNU  V25.2D, V12.2D
    FCVTMU  W7, H21
    SCVTF V9.2D, V22.2D, #54
    FRINTP  D13, D14
    FRINTX  D12, D1
    SCVTF  V11.4S, V20.4S, #13
    FRINTX  S20, S19
    FRINTN  D25, D2
    FCVTAS  D0, D14
    FCVTZS  V20.2S, V26.2S
    UCVTF  H4, W24
    FRINTZ  D14, D23
    FCVTZS V30.2D, V18.2D, #24
    FCVTNS  X14, D25
    FCVTAS  W12, H29
    FCVTPU  V7.4S, V16.4S
    UCVTF  V2.4S, V25.4S, #28
    FCVTZS  S30, S20
    FCVTZU  X17, H21
    FCSEL  H16, H3, H27, GE
    SCVTF  H25, X14
    FCVTMS  W15, H25
    UCVTF  D22, D30
    FCVTZS  S17, S0
    DUP V0.2D, X8
    FCVTMU  D1, D28
    SCVTF  S26, S21
    FRINTZ  S25, S9
    FCVTMU  D1, D30
    FRINTI  S30, S1
    FCVTMS  D11, D14
    FRINTI  D1, D5
    FMOV  X28, V0.D[1]
    FCVTAS  V2.4S, V18.4S
    SCVTF  S8, S18
    FCVTMS  D3, D16
    FCVTPS  D27, D26
    UCVTF  V13.2D, V20.2D
    FRINTP  H30, H17
    FCSEL  D30, D5, D22, NE
    FCVTZU V25.2D, V2.2D, #36
    FRINTZ  D0, D12
    FCVTNS  X15, S21
    FCVTNS  D11, D0
    SCVTF  D8, D17
    FMOV  X21, V10.D[1]
    UCVTF  V24.2D, V15.2D
    FCVTAU  V3.2S, V29.2S
    SCVTF  S5, S27
    SUBS  X4, X4, #0x1
    B.NE  TaishanSimdAddP01_label_1504
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X15
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X17, X6, X16
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X14, X27, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X10, X4, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X22
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X6, X27, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X25, X20, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X21, X12, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X16, D2
    MOVZ  X12, #0x0, LSL #0
    SUB  X21, X12, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X19, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X19, D3
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X26, X13, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X12, D4
    MOVZ  X13, #0x0, LSL #0
    SUB  X26, X13, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X22, X27, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X26, D6
    MOVZ  X27, #0x0, LSL #0
    SUB  X22, X27, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X22, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X22
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X22, D7
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X22
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X9, D8
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X25, V9.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X25, D9
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X3, D10
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X17, D11
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X19, V12.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X19, D12
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X27, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X27, D13
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X4, D14
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X12, D15
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X6, D16
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X22, V17.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X22, D17
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    FMOV  X16, D18
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X3, D19
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X10, X28, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X24, D20
    MOVZ  X28, #0x0, LSL #0
    SUB  X10, X28, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X4, D21
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X6, V22.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    FMOV  X6, D22
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X7, D23
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X20, D24
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAddP01_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X8, D25
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X28, D26
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X19, X28, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X4, D27
    MOVZ  X28, #0x0, LSL #0
    SUB  X19, X28, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X8, X2, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X3, D28
    MOVZ  X2, #0x0, LSL #0
    SUB  X8, X2, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
    FMOV  X16, D29
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAddP01_TestFail
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
    FMOV  D0, X28
    FMOV  V0.D[1], X10
    FMOV  D1, X29
    FMOV  V1.D[1], X11
    FMOV  D2, X8
    FMOV  V2.D[1], X16
    FMOV  D3, X11
    FMOV  V3.D[1], X8
    FMOV  D4, X21
    FMOV  V4.D[1], X27
    FMOV  D5, X10
    FMOV  V5.D[1], X22
    FMOV  D6, X11
    FMOV  V6.D[1], X14
    FMOV  D7, X22
    FMOV  V7.D[1], X11
    FMOV  D8, X19
    FMOV  V8.D[1], X25
    FMOV  D9, X18
    FMOV  V9.D[1], X29
    FMOV  D10, X8
    FMOV  V10.D[1], X15
    FMOV  D11, X20
    FMOV  V11.D[1], X3
    FMOV  D12, X9
    FMOV  V12.D[1], X9
    FMOV  D13, X18
    FMOV  V13.D[1], X13
    FMOV  D14, X11
    FMOV  V14.D[1], X3
    FMOV  D15, X18
    FMOV  V15.D[1], X2
    FMOV  D16, X8
    FMOV  V16.D[1], X9
    FMOV  D17, X13
    FMOV  V17.D[1], X14
    FMOV  D18, X28
    FMOV  V18.D[1], X26
    FMOV  D19, X15
    FMOV  V19.D[1], X25
    FMOV  D20, X12
    FMOV  V20.D[1], X2
    FMOV  D21, X25
    FMOV  V21.D[1], X6
    FMOV  D22, X4
    FMOV  V22.D[1], X19
    FMOV  D23, X22
    FMOV  V23.D[1], X23
    FMOV  D24, X3
    FMOV  V24.D[1], X3
    FMOV  D25, X13
    FMOV  V25.D[1], X9
    FMOV  D26, X17
    FMOV  V26.D[1], X11
    FMOV  D27, X21
    FMOV  V27.D[1], X9
    FMOV  D28, X2
    FMOV  V28.D[1], X28
    FMOV  D29, X15
    FMOV  V29.D[1], X19
    FMOV  D30, X15
    FMOV  V30.D[1], X18
    FMOV  D31, X25
    FMOV  V31.D[1], X12
    MOVZ  X25, #0xf, LSL #0
TaishanSimdAddP01_label_1581:
    FRINTX  S30, S13
    UCVTF  S28, S4
    FCVTAU  D15, D8
    FCVTAS  D19, D15
    FCVTMU  D6, D8
    FCVTZU  D30, D3
    UCVTF  D31, W23
    FCVTZU V26.2D, V26.2D, #44
    FCVTPU  S15, S26
    FCSEL  S2, S19, S21, HI
    FCVTMU  D29, D5
    FCVTZU  D15, D10
    FCVTNU  D16, D29
    FRINTX  D10, D31
    FCVTNU  V2.4S, V17.4S
    FRINTM  S5, S6
    FRINTP  H24, H8
    FCVTNU  S25, S25
    FCVTZU  V29.2D, V8.2D
    FCVTPS  D0, D8
    FRINTX  D14, D25
    FRINTZ  D10, D27
    FCVTZU S23, S29, #17
    FRINTA  H2, H3
    FCVTZS S6, S13, #17
    FCVTNU  W4, D25
    FCVTAU  D12, D3
    FCVTMU  D29, D14
    SCVTF  S17, S10
    SCVTF V8.2D, V15.2D, #17
    UCVTF V29.2D, V28.2D, #4
    FCVTZU D21, D11, #15
    FCVTMS  D24, D27
    FRINTM  H14, H26
    FCVTZS S28, S25, #20
    FCVTMU  V21.2S, V14.2S
    FCVTPU  S7, S7
    FCVTZU  V27.4S, V2.4S, #29
    FCVTMU  V27.2D, V5.2D
    FCVTAU  D27, D7
    UCVTF  S1, S21
    FCVTMS  V3.8H, V25.8H
    FCVTAS  V8.2S, V4.2S
    FCVTZS S8, S31, #26
    FRINTA  H21, H26
    UCVTF  D12, D17
    FRINTZ  H10, H24
    FRINTP  S10, S27
    FCVTMS  D4, D27
    FCVTNS  X4, H13
    FCVTAS  D20, D4
    FCVTZS  V26.2D, V9.2D
    FCVTMU  V17.2S, V28.2S
    DUP V9.2D, X23
    FCVTPU  D2, D18
    FCVTNU  V15.4H, V19.4H
    UCVTF  V30.4S, V11.4S, #2
    FCVTZU  V9.2D, V16.2D
    FCVTPU  S3, S29
    FRINTA  S21, S9
    FRINTI  D27, D10
    FMOV  V11.D[1], X27
    FCVTAU  S20, S10
    FCVTMU  V26.4S, V22.4S
    FRINTM  D31, D5
    FRINTA  H25, H10
    FCVTPS  D5, D30
    FRINTA  D28, D24
    FCVTNU  D26, D20
    FCVTZU  S24, S0
    FCVTMU  D14, D11
    FRINTN  D13, D2
    FCVTZS  D3, D8
    FCSEL  D26, D24, D24, GT
    FCVTZS D6, D28, #46
    FRINTZ  H25, H27
    FCVTZS  S8, S20
    FRINTZ  S19, S13
    FCVTZU  D3, D20
    FRINTX  D7, D29
    UCVTF  D21, D24
    FCVTZU  D7, D10
    FCVTAU  D18, D6
    FRINTX  H16, H23
    FRINTM  S23, S26
    SCVTF  D15, D7
    FRINTI  H31, H26
    FCVTZU  V13.2D, V28.2D
    FCVTZS  S8, S29
    FRINTM  H19, H10
    FRINTM  D27, D6
    FCVTPU  S1, S28
    FCVTMS  D17, D24
    FRINTI  D2, D15
    FCVTZS  S18, S2
    FRINTN  S4, S5
    FCVTAU  W26, S24
    FRINTA  S7, S29
    FCVTZU  V18.4S, V7.4S
    SCVTF D18, D5, #40
    FRINTZ  H28, H2
    FCVTZS  V12.4S, V15.4S
    FCVTPS  D25, D3
    FCVTMU  V29.2D, V3.2D
    FCVTMS  S16, S18
    FRINTP  S31, S30
    FCVTMU  S13, S17
    FCVTZU S23, S28, #23
    FRINTI  H4, H29
    FRINTZ  H11, H18
    FCVTZU D28, D17, #21
    FCVTZS  V20.4S, V23.4S, #31
    FCVTZS V1.2D, V11.2D, #24
    FRINTX  D18, D9
    UCVTF  V9.2S, V18.2S, #18
    FCVTMS  V17.2S, V1.2S
    FCVTPU  S8, S21
    FCVTZU D8, D31, #40
    FRINTI  D6, D11
    FCVTMS  D1, D18
    UCVTF V5.2D, V16.2D, #25
    FRINTX  H21, H10
    UCVTF  V18.4S, V16.4S, #18
    FCVTPS  V1.8H, V3.8H
    UCVTF D9, D10, #33
    FCVTAU  V3.2D, V8.2D
    FCVTMS  S12, S27
    FCVTZS  D27, D31
    FRINTM  H15, H20
    FRINTZ  S29, S25
    FCVTZU D1, D6, #32
    FMOV  X6, V30.D[1]
    FCVTAS  S3, S9
    FCVTZS  S16, S26
    FCVTZU  D17, D16
    FCVTZS S30, S28, #32
    FCVTMU  V10.4S, V26.4S
    UCVTF  D12, W28, #10
    DUP V20.16B, W20
    FRINTN  D21, D27
    FCVTAU  S22, S10
    FCVTAU  D7, D5
    FRINTI  S8, S15
    FCVTNS  D23, D29
    FRINTA  D13, D21
    UCVTF S25, S16, #22
    FCVTZU  S3, S24
    FRINTP  D27, D1
    FCVTNU  V8.2D, V10.2D
    FRINTA  H21, H0
    FCVTZS  V1.2S, V12.2S, #3
    FCVTMS  S6, S23
    FMOV  X24, V21.D[1]
    FMOV  X8, V30.D[1]
    FRINTI  H25, H14
    SCVTF S0, S19, #18
    FCVTPS  D11, D13
    FRINTM  H20, H22
    FMOV  W2, S15
    FRINTP  H16, H17
    FCVTMS  S14, S23
    FCVTPU  S23, S19
    FRINTN  D28, D15
    FCVTZS  S13, S28
    FRINTZ  H13, H15
    UCVTF V11.2D, V17.2D, #57
    FRINTM  S24, S18
    FCVTZS  H18, H19
    FRINTM  D28, D0
    FCVTPU  S1, S15
    FMOV  V21.D[1], X8
    FCVTNU  S9, S11
    SCVTF  V11.4S, V14.4S, #22
    FRINTN  D14, D17
    FRINTA  H20, H25
    UCVTF  V7.2D, V6.2D
    FCVTZU D13, D18, #12
    FRINTM  H9, H22
    FCVTNS  S3, S9
    FCVTZS S10, S8, #18
    UCVTF  S23, S15
    FRINTI  H0, H15
    FMOV  X15, V19.D[1]
    FCVTZS  D19, D24
    SCVTF  V4.4S, V11.4S
    FCVTZU V20.2D, V19.2D, #37
    FRINTZ  D5, D28
    FCVTPS  S10, S20
    FRINTZ  D14, D14
    FCVTAS  S1, S22
    FMOV  X20, V21.D[1]
    FCVTMU  V0.4S, V3.4S
    FCVTZS D13, D25, #36
    DUP V25.4S, W27
    FCVTZU  D23, D19
    FRINTN  D20, D1
    FRINTA  H20, H23
    SCVTF D21, D25, #31
    FRINTM  H3, H8
    FRINTM  D18, D21
    SUBS  X25, X25, #0x1
    B.NE  TaishanSimdAddP01_label_1581
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X2
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X17, X29, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X6, X27, X6
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X8, X24, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X11, X23, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X4, X9, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X4, X16, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAddP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X23, X3, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAddP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X18, X13, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAddP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X10, X20, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAddP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X19, X3, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAddP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X9, X27, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X26, X27, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X14, X16, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X29, X28, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X26, X29, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X19, X27, X25
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAddP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X26
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAddP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAddP01_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X13, D2
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X2, D3
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAddP01_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X12, X28, X16
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X16, D4
    MOVZ  X28, #0x0, LSL #0
    SUB  X12, X28, X16
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X19, V6.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X19, D6
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X18, D7
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X26
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X26, D8
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X26
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X4, D9
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X13, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X7, D11
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAddP01_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X6, D12
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xffe0, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0x414f, LSL #48
    SUB  X14, X24, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X29, D13
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X7, X10, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X2, D14
    MOVZ  X10, #0x0, LSL #0
    SUB  X7, X10, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAddP01_TestFail
    FMOV  X21, V15.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X21
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X21, D15
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X21
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    FMOV  X15, D16
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAddP01_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X28, D17
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAddP01_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X13, D18
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xbff0, LSL #48
    SUB  X2, X23, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAddP01_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X29, X15, X26
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X26, D19
    MOVZ  X15, #0x0, LSL #0
    SUB  X29, X15, X26
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdAddP01_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X3, X25, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X10, D20
    MOVZ  X25, #0x0, LSL #0
    SUB  X3, X25, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAddP01_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X26, D21
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xbe00, LSL #48
    SUB  X6, X15, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X7, D22
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAddP01_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X12, D23
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAddP01_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X13
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X13, D24
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X13
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAddP01_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X14, X16, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X17, D25
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X14, X16, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X25, V26.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X20, X17, X25
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X25, D26
    MOVZ  X17, #0x0, LSL #0
    SUB  X20, X17, X25
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAddP01_TestFail
    FMOV  X21, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X21
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X21, D27
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X21
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAddP01_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X4, D28
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAddP01_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail
    FMOV  X10, D29
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAddP01_TestFail

TaishanSimdAddP01_TestEnd:
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
    LDP  X2, X3, [SP], #16
    MSR  FPCR, X2
    MSR  FPSR, X3
    ISB  SY

    LDP  Q30, Q31, [SP], #32
    LDP  Q28, Q29, [SP], #32
    LDP  Q26, Q27, [SP], #32
    LDP  Q24, Q25, [SP], #32
    LDP  Q22, Q23, [SP], #32
    LDP  Q20, Q21, [SP], #32
    LDP  Q18, Q19, [SP], #32
    LDP  Q16, Q17, [SP], #32
    LDP  Q14, Q15, [SP], #32
    LDP  Q12, Q13, [SP], #32
    LDP  Q10, Q11, [SP], #32
    LDP  Q8, Q9, [SP], #32
    LDP  Q6, Q7, [SP], #32
    LDP  Q4, Q5, [SP], #32
    LDP  Q2, Q3, [SP], #32
    LDP  Q0, Q1, [SP], #32
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
TaishanSimdAddP01_TestFail:
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
    LDP  X2, X3, [SP], #16
    MSR  FPCR, X2
    MSR  FPSR, X3
    ISB  SY

    LDP  Q30, Q31, [SP], #32
    LDP  Q28, Q29, [SP], #32
    LDP  Q26, Q27, [SP], #32
    LDP  Q24, Q25, [SP], #32
    LDP  Q22, Q23, [SP], #32
    LDP  Q20, Q21, [SP], #32
    LDP  Q18, Q19, [SP], #32
    LDP  Q16, Q17, [SP], #32
    LDP  Q14, Q15, [SP], #32
    LDP  Q12, Q13, [SP], #32
    LDP  Q10, Q11, [SP], #32
    LDP  Q8, Q9, [SP], #32
    LDP  Q6, Q7, [SP], #32
    LDP  Q4, Q5, [SP], #32
    LDP  Q2, Q3, [SP], #32
    LDP  Q0, Q1, [SP], #32
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