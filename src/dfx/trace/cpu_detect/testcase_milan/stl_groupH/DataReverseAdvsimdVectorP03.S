.global DataReverseAdvsimdVectorP03

.text
.p2align 4

DataReverseAdvsimdVectorP03:

DataReverseAdvsimdVectorP03_TestBegin:
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
    MRS  X4, NZCV
    STP  X2, X3, [SP, #-16]!
    STP  X4, X2, [SP, #-16]!
    MOVZ  X2, #0xe1cb, LSL #0
    MOVK  X2, #0x6a51, LSL #16
    MOVK  X2, #0xdeec, LSL #32
    MOVK  X2, #0x3d48, LSL #48
    MOVZ  X3, #0x1da, LSL #0
    MOVK  X3, #0x8538, LSL #16
    MOVK  X3, #0xe60, LSL #32
    MOVK  X3, #0x738b, LSL #48
    MOVZ  X4, #0x4fe1, LSL #0
    MOVK  X4, #0xb2c3, LSL #16
    MOVK  X4, #0x6d31, LSL #32
    MOVK  X4, #0x836b, LSL #48
    MOVZ  X5, #0x964f, LSL #0
    MOVK  X5, #0x4346, LSL #16
    MOVK  X5, #0x3347, LSL #32
    MOVK  X5, #0x9ef2, LSL #48
    MOVZ  X6, #0xd19f, LSL #0
    MOVK  X6, #0x8cfc, LSL #16
    MOVK  X6, #0xa738, LSL #32
    MOVK  X6, #0x294, LSL #48
    MOVZ  X7, #0x239c, LSL #0
    MOVK  X7, #0x2138, LSL #16
    MOVK  X7, #0x466f, LSL #32
    MOVK  X7, #0x3e04, LSL #48
    MOVZ  X8, #0xdf, LSL #0
    MOVK  X8, #0xa0d0, LSL #16
    MOVK  X8, #0x8aba, LSL #32
    MOVK  X8, #0x4544, LSL #48
    MOVZ  X9, #0x44d6, LSL #0
    MOVK  X9, #0x76d, LSL #16
    MOVK  X9, #0x141, LSL #32
    MOVK  X9, #0x51b4, LSL #48
    MOVZ  X10, #0x1c46, LSL #0
    MOVK  X10, #0x6a8c, LSL #16
    MOVK  X10, #0xb9b3, LSL #32
    MOVK  X10, #0x115f, LSL #48
    MOVZ  X11, #0x253c, LSL #0
    MOVK  X11, #0x1a9a, LSL #16
    MOVK  X11, #0xea20, LSL #32
    MOVK  X11, #0xc1b2, LSL #48
    MOVZ  X12, #0xc1b8, LSL #0
    MOVK  X12, #0xba47, LSL #16
    MOVK  X12, #0x61eb, LSL #32
    MOVK  X12, #0x1ab7, LSL #48
    MOVZ  X13, #0xea32, LSL #0
    MOVK  X13, #0x733, LSL #16
    MOVK  X13, #0x2395, LSL #32
    MOVK  X13, #0x65e3, LSL #48
    MOVZ  X14, #0xf8e1, LSL #0
    MOVK  X14, #0xdb14, LSL #16
    MOVK  X14, #0xb608, LSL #32
    MOVK  X14, #0xafb9, LSL #48
    MOVZ  X15, #0x448f, LSL #0
    MOVK  X15, #0xfd4f, LSL #16
    MOVK  X15, #0xe5f5, LSL #32
    MOVK  X15, #0xbc75, LSL #48
    MOVZ  X16, #0x8b50, LSL #0
    MOVK  X16, #0xa153, LSL #16
    MOVK  X16, #0xd9d2, LSL #32
    MOVK  X16, #0x41e3, LSL #48
    MOVZ  X17, #0x3099, LSL #0
    MOVK  X17, #0x8ada, LSL #16
    MOVK  X17, #0x2ae4, LSL #32
    MOVK  X17, #0x2362, LSL #48
    MOVZ  X20, #0xffd, LSL #0
    MOVK  X20, #0x3686, LSL #16
    MOVK  X20, #0xa847, LSL #32
    MOVK  X20, #0x61b, LSL #48
    MOVZ  X22, #0x2165, LSL #0
    MOVK  X22, #0xfca, LSL #16
    MOVK  X22, #0x4979, LSL #32
    MOVK  X22, #0xebdd, LSL #48
    MOVZ  X23, #0x7104, LSL #0
    MOVK  X23, #0x916f, LSL #16
    MOVK  X23, #0xbc28, LSL #32
    MOVK  X23, #0x7491, LSL #48
    MOVZ  X24, #0xe01e, LSL #0
    MOVK  X24, #0x6134, LSL #16
    MOVK  X24, #0x4bfa, LSL #32
    MOVK  X24, #0x582, LSL #48
    MOVZ  X25, #0x269, LSL #0
    MOVK  X25, #0xf47e, LSL #16
    MOVK  X25, #0x7e2a, LSL #32
    MOVK  X25, #0x802b, LSL #48
    MOVZ  X26, #0xd8a5, LSL #0
    MOVK  X26, #0x2847, LSL #16
    MOVK  X26, #0x7473, LSL #32
    MOVK  X26, #0x127b, LSL #48
    MOVZ  X27, #0x5a3a, LSL #0
    MOVK  X27, #0x5277, LSL #16
    MOVK  X27, #0x250, LSL #32
    MOVK  X27, #0xc5c0, LSL #48
    MOVZ  X29, #0xab20, LSL #0
    MOVK  X29, #0xceda, LSL #16
    MOVK  X29, #0x5d7b, LSL #32
    MOVK  X29, #0xa278, LSL #48
    MOVZ  X3, #0x4da3, LSL #0
    MOVK  X3, #0xed13, LSL #16
    MOVK  X3, #0xec67, LSL #32
    MOVK  X3, #0xffd2, LSL #48
    MSR  FPCR, X3
    MOVZ  X3, #0xdae8, LSL #0
    MOVK  X3, #0x9a69, LSL #16
    MOVK  X3, #0xd481, LSL #32
    MOVK  X3, #0x767a, LSL #48
    MSR  FPSR, X3
    MRS  X11, FPSR
    MOVZ  X25, #0xff60, LSL #0
    MOVK  X25, #0x7ff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    AND  X11, X11, X25
    MOVZ  X25, #0x0, LSL #0
    ORR  X11, X11, X25
    MSR  FPSR, X11
    ISB  SY
    SUBS  W9, W4, #0xb43, LSL #12
    MOVZ  X1, #0x0, LSL #0
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
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
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
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X24
    FMOV  D1, X27
    FMOV  V1.D[1], X26
    FMOV  D2, X25
    FMOV  V2.D[1], X25
    FMOV  D3, X13
    FMOV  V3.D[1], X12
    FMOV  D4, X7
    FMOV  V4.D[1], X20
    FMOV  D5, X2
    FMOV  V5.D[1], X29
    FMOV  D6, X29
    FMOV  V6.D[1], X2
    FMOV  D7, X13
    FMOV  V7.D[1], X14
    FMOV  D8, X3
    FMOV  V8.D[1], X6
    FMOV  D9, X14
    FMOV  V9.D[1], X2
    FMOV  D10, X24
    FMOV  V10.D[1], X25
    FMOV  D11, X9
    FMOV  V11.D[1], X16
    FMOV  D12, X12
    FMOV  V12.D[1], X26
    FMOV  D13, X25
    FMOV  V13.D[1], X23
    FMOV  D14, X26
    FMOV  V14.D[1], X3
    FMOV  D15, X13
    FMOV  V15.D[1], X6
    FMOV  D16, X10
    FMOV  V16.D[1], X17
    FMOV  D17, X11
    FMOV  V17.D[1], X6
    FMOV  D18, X23
    FMOV  V18.D[1], X8
    FMOV  D19, X24
    FMOV  V19.D[1], X29
    FMOV  D20, X20
    FMOV  V20.D[1], X22
    FMOV  D21, X23
    FMOV  V21.D[1], X10
    FMOV  D22, X10
    FMOV  V22.D[1], X8
    FMOV  D23, X17
    FMOV  V23.D[1], X27
    FMOV  D24, X11
    FMOV  V24.D[1], X2
    FMOV  D25, X4
    FMOV  V25.D[1], X15
    FMOV  D26, X8
    FMOV  V26.D[1], X4
    FMOV  D27, X13
    FMOV  V27.D[1], X4
    FMOV  D28, X17
    FMOV  V28.D[1], X14
    FMOV  D29, X29
    FMOV  V29.D[1], X5
    FMOV  D30, X15
    FMOV  V30.D[1], X8
    FMOV  D31, X15
    FMOV  V31.D[1], X5
    SABA  V4.16B, V28.16B, V27.16B
    SABAL  V28.4S, V30.4H, V26.4H
    SABAL2  V14.2D, V23.4S, V31.4S
    SABD  V11.2S, V25.2S, V24.2S
    SABDL  V29.8H, V29.8B, V29.8B
    SABDL2  V25.8H, V8.16B, V9.16B
    SADALP  V30.4H, V21.8B
    SADDL  V9.2D, V1.2S, V20.2S
    SADDL2  V17.2D, V13.4S, V31.4S
    SADDLP  V7.8H, V22.16B
    SADDLV  H19, V20.8B
    SADDLV  S21, V18.8H
    SADDLV  D24, V15.4S
    SADDW  V16.8H, V22.8H, V23.8B
    SADDW2  V10.2D, V5.2D, V15.4S
    SHADD  V26.2S, V3.2S, V0.2S
    SHSUB  V2.16B, V15.16B, V8.16B
    SMLAL V20.2D, V0.2S, V15.S[0x3]
    SMLAL V18.4S, V23.4H, V5.H[0x1]
    SMLAL  V13.8H, V12.8B, V1.8B
    SMLAL2 V1.2D, V31.4S, V27.S[0x2]
    SMLAL2 V0.4S, V27.8H, V3.H[0x1]
    SMLAL2  V12.4S, V22.8H, V31.8H
    SMLSL V27.2D, V31.2S, V23.S[0x3]
    SMLSL V22.4S, V3.4H, V3.H[0x1]
    SMLSL  V31.8H, V3.8B, V6.8B
    SMLSL2 V23.2D, V3.4S, V8.S[0x0]
    SMLSL2 V8.4S, V6.8H, V3.H[0x3]
    SMLSL2  V3.4S, V5.8H, V6.8H
    SMOV W5, V5.B[0x1]
    SMOV W10, V5.H[0x0]
    SMOV  X20, V5.B[0xe]
    SMOV  X8, V6.H[0x6]
    SMOV  X7, V5.S[0x1]
    SMULL V15.2D, V6.2S, V5.S[0x0]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a, LSL #0
    SUB  X4, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    SUB  X4, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    SUB  X4, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    SUB  X4, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a, LSL #0
    SUB  X4, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    MRS  X4, FPSR
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xc1fe, LSL #0
    MOVK  X29, #0x7a3d, LSL #16
    MOVK  X29, #0xc1fe, LSL #32
    MOVK  X29, #0x7a3d, LSL #48
    FMOV  X4, V0.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xc1fe, LSL #0
    MOVK  X29, #0x7a3d, LSL #16
    MOVK  X29, #0xc1fe, LSL #32
    MOVK  X29, #0x7a3d, LSL #48
    FMOV  X4, D0
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xc1fe, LSL #0
    MOVK  X29, #0x4985, LSL #16
    MOVK  X29, #0x1c5, LSL #32
    MOVK  X29, #0x7a3e, LSL #48
    FMOV  X4, V1.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xc1fe, LSL #0
    MOVK  X29, #0x4985, LSL #16
    MOVK  X29, #0x1c5, LSL #32
    MOVK  X29, #0x7a3e, LSL #48
    FMOV  X4, D1
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V2.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, D2
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xf2b6, LSL #0
    MOVK  X29, #0x3a76, LSL #16
    MOVK  X29, #0xf2b6, LSL #32
    MOVK  X29, #0x3a76, LSL #48
    FMOV  X4, V3.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xf2b6, LSL #0
    MOVK  X29, #0x3a76, LSL #16
    MOVK  X29, #0xf2b6, LSL #32
    MOVK  X29, #0x3a76, LSL #48
    FMOV  X4, D3
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V4.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D4
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V5.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D5
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V6.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D6
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xb4, LSL #0
    MOVK  X29, #0xb4, LSL #16
    MOVK  X29, #0xb4, LSL #32
    MOVK  X29, #0xb4, LSL #48
    FMOV  X4, V7.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xb4, LSL #0
    MOVK  X29, #0xb4, LSL #16
    MOVK  X29, #0xb4, LSL #32
    MOVK  X29, #0xb4, LSL #48
    FMOV  X4, D7
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xf2b6, LSL #0
    MOVK  X29, #0x3a76, LSL #16
    MOVK  X29, #0xf2b6, LSL #32
    MOVK  X29, #0x3a76, LSL #48
    FMOV  X4, V8.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xf2b6, LSL #0
    MOVK  X29, #0x3a76, LSL #16
    MOVK  X29, #0xf2b6, LSL #32
    MOVK  X29, #0x3a76, LSL #48
    FMOV  X4, D8
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xb4b4, LSL #0
    MOVK  X29, #0xb4b4, LSL #16
    FMOV  X4, V9.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xb4b4, LSL #0
    MOVK  X29, #0xb4b4, LSL #16
    FMOV  X4, D9
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xb4b4, LSL #0
    MOVK  X29, #0xb4b4, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V10.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xb4b4, LSL #0
    MOVK  X29, #0xb4b4, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D10
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V11.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, D11
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xc1fe, LSL #0
    MOVK  X29, #0x7a3d, LSL #16
    MOVK  X29, #0xc1fe, LSL #32
    MOVK  X29, #0x7a3d, LSL #48
    FMOV  X4, V12.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xc1fe, LSL #0
    MOVK  X29, #0x7a3d, LSL #16
    MOVK  X29, #0xc1fe, LSL #32
    MOVK  X29, #0x7a3d, LSL #48
    FMOV  X4, D12
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x79fe, LSL #0
    MOVK  X29, #0x79fe, LSL #16
    MOVK  X29, #0x79fe, LSL #32
    MOVK  X29, #0x79fe, LSL #48
    FMOV  X4, V13.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x79fe, LSL #0
    MOVK  X29, #0x79fe, LSL #16
    MOVK  X29, #0x79fe, LSL #32
    MOVK  X29, #0x79fe, LSL #48
    FMOV  X4, D13
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V14.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D14
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x67a4, LSL #0
    MOVK  X29, #0xef2b, LSL #16
    MOVK  X29, #0xa76a, LSL #32
    MOVK  X29, #0x1fe3, LSL #48
    FMOV  X4, V15.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x67a4, LSL #0
    MOVK  X29, #0xef2b, LSL #16
    MOVK  X29, #0xa76a, LSL #32
    MOVK  X29, #0x1fe3, LSL #48
    FMOV  X4, D15
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5ab4, LSL #0
    MOVK  X29, #0x5ab4, LSL #16
    MOVK  X29, #0x5ab4, LSL #32
    MOVK  X29, #0x5ab4, LSL #48
    FMOV  X4, V16.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5ab4, LSL #0
    MOVK  X29, #0x5ab4, LSL #16
    MOVK  X29, #0x5ab4, LSL #32
    MOVK  X29, #0x5ab4, LSL #48
    FMOV  X4, D16
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xb4b4, LSL #0
    MOVK  X29, #0xb4b4, LSL #16
    FMOV  X4, V17.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xb4b4, LSL #0
    MOVK  X29, #0xb4b4, LSL #16
    FMOV  X4, D17
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xc1fe, LSL #0
    MOVK  X29, #0x7a3d, LSL #16
    MOVK  X29, #0xc1fe, LSL #32
    MOVK  X29, #0x7a3d, LSL #48
    FMOV  X4, V18.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xc1fe, LSL #0
    MOVK  X29, #0x7a3d, LSL #16
    MOVK  X29, #0xc1fe, LSL #32
    MOVK  X29, #0x7a3d, LSL #48
    FMOV  X4, D18
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V19.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x2d0, LSL #0
    FMOV  X4, D19
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xc1fe, LSL #0
    MOVK  X29, #0x4985, LSL #16
    MOVK  X29, #0x1c5, LSL #32
    MOVK  X29, #0x7a3e, LSL #48
    FMOV  X4, V20.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xc1fe, LSL #0
    MOVK  X29, #0x4985, LSL #16
    MOVK  X29, #0x1c5, LSL #32
    MOVK  X29, #0x7a3e, LSL #48
    FMOV  X4, D20
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V21.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xd2d0, LSL #0
    MOVK  X29, #0x2, LSL #16
    FMOV  X4, D21
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xf2b6, LSL #0
    MOVK  X29, #0x3a76, LSL #16
    MOVK  X29, #0xf2b6, LSL #32
    MOVK  X29, #0x3a76, LSL #48
    FMOV  X4, V22.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xf2b6, LSL #0
    MOVK  X29, #0x3a76, LSL #16
    MOVK  X29, #0xf2b6, LSL #32
    MOVK  X29, #0x3a76, LSL #48
    FMOV  X4, D22
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xf2b6, LSL #0
    MOVK  X29, #0x6b2e, LSL #16
    MOVK  X29, #0xb2ef, LSL #32
    MOVK  X29, #0x3a76, LSL #48
    FMOV  X4, V23.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xf2b6, LSL #0
    MOVK  X29, #0x6b2e, LSL #16
    MOVK  X29, #0xb2ef, LSL #32
    MOVK  X29, #0x3a76, LSL #48
    FMOV  X4, D23
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V24.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x6968, LSL #0
    MOVK  X29, #0x6969, LSL #16
    MOVK  X29, #0x1, LSL #32
    FMOV  X4, D24
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V25.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, D25
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V26.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D26
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xf2b6, LSL #0
    MOVK  X29, #0x6b2e, LSL #16
    MOVK  X29, #0xb2ef, LSL #32
    MOVK  X29, #0x3a76, LSL #48
    FMOV  X4, V27.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xf2b6, LSL #0
    MOVK  X29, #0x6b2e, LSL #16
    MOVK  X29, #0xb2ef, LSL #32
    MOVK  X29, #0x3a76, LSL #48
    FMOV  X4, D27
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V28.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D28
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V29.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, D29
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V30.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5b0e, LSL #0
    MOVK  X29, #0x5b0e, LSL #16
    MOVK  X29, #0x5b0e, LSL #32
    MOVK  X29, #0x5b0e, LSL #48
    FMOV  X4, D30
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x3ab6, LSL #0
    MOVK  X29, #0x3ab6, LSL #16
    MOVK  X29, #0x3ab6, LSL #32
    MOVK  X29, #0x3ab6, LSL #48
    FMOV  X4, V31.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x3ab6, LSL #0
    MOVK  X29, #0x3ab6, LSL #16
    MOVK  X29, #0x3ab6, LSL #32
    MOVK  X29, #0x3ab6, LSL #48
    FMOV  X4, D31
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
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
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
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
    FMOV  D0, X26
    FMOV  V0.D[1], X23
    FMOV  D1, X20
    FMOV  V1.D[1], X24
    FMOV  D2, X25
    FMOV  V2.D[1], X27
    FMOV  D3, X22
    FMOV  V3.D[1], X3
    FMOV  D4, X3
    FMOV  V4.D[1], X8
    FMOV  D5, X5
    FMOV  V5.D[1], X25
    FMOV  D6, X6
    FMOV  V6.D[1], X27
    FMOV  D7, X7
    FMOV  V7.D[1], X20
    FMOV  D8, X8
    FMOV  V8.D[1], X10
    FMOV  D9, X17
    FMOV  V9.D[1], X14
    FMOV  D10, X16
    FMOV  V10.D[1], X12
    FMOV  D11, X2
    FMOV  V11.D[1], X13
    FMOV  D12, X5
    FMOV  V12.D[1], X27
    FMOV  D13, X3
    FMOV  V13.D[1], X10
    FMOV  D14, X17
    FMOV  V14.D[1], X10
    FMOV  D15, X26
    FMOV  V15.D[1], X11
    FMOV  D16, X11
    FMOV  V16.D[1], X10
    FMOV  D17, X2
    FMOV  V17.D[1], X17
    FMOV  D18, X12
    FMOV  V18.D[1], X2
    FMOV  D19, X27
    FMOV  V19.D[1], X16
    FMOV  D20, X5
    FMOV  V20.D[1], X5
    FMOV  D21, X23
    FMOV  V21.D[1], X2
    FMOV  D22, X24
    FMOV  V22.D[1], X24
    FMOV  D23, X22
    FMOV  V23.D[1], X14
    FMOV  D24, X15
    FMOV  V24.D[1], X26
    FMOV  D25, X24
    FMOV  V25.D[1], X10
    FMOV  D26, X10
    FMOV  V26.D[1], X6
    FMOV  D27, X22
    FMOV  V27.D[1], X6
    FMOV  D28, X16
    FMOV  V28.D[1], X24
    FMOV  D29, X8
    FMOV  V29.D[1], X5
    FMOV  D30, X17
    FMOV  V30.D[1], X14
    FMOV  D31, X5
    FMOV  V31.D[1], X27
    SMULL  V12.8H, V25.8B, V27.8B
    SMULL2 V28.2D, V31.4S, V24.S[0x0]
    SMULL2 V17.4S, V20.8H, V8.H[0x4]
    SMULL2  V10.8H, V23.16B, V23.16B
    SQABS  V5.2S, V26.2S
    SQADD  V7.2D, V29.2D, V29.2D
    SQDMLAL S27, H21, V1.H[0x5]
    SQDMLAL D29, S24, V0.S[0x0]
    SQDMLAL V14.2D, V30.2S, V4.S[0x3]
    SQDMLAL V1.4S, V23.4H, V8.H[0x2]
    SQDMLAL  V6.2D, V26.2S, V21.2S
    SQDMLAL2 V24.2D, V13.4S, V15.S[0x3]
    SQDMLAL2 V19.4S, V30.8H, V3.H[0x4]
    SQDMLAL2  V18.4S, V25.8H, V9.8H
    SQDMLSL S11, H25, V8.H[0x6]
    SQDMLSL D4, S23, V26.S[0x3]
    SQDMLSL V31.2D, V26.2S, V21.S[0x0]
    SQDMLSL V25.4S, V23.4H, V9.H[0x3]
    SQDMLSL  V23.2D, V13.2S, V26.2S
    SQDMLSL2 V2.2D, V0.4S, V9.S[0x1]
    SQDMLSL2 V3.4S, V0.8H, V13.H[0x3]
    SQDMLSL2  V20.2D, V0.4S, V30.4S
    SQDMULH H16, H9, V0.H[0x0]
    SQDMULH S0, S8, V9.S[0x1]
    SQDMULH  V9.4H, V15.4H, V15.H[0x3]
    SQDMULH  V30.2S, V30.2S, V15.S[0x0]
    SQDMULH  V21.2S, V8.2S, V26.2S
    SQDMULL S8, H13, V8.H[0x6]
    SQDMULL D15, S26, V26.S[0x0]
    SQDMULL V13.2D, V13.2S, V13.S[0x1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x800, LSL #16
    MRS  X4, FPSR
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V0.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x4ed5, LSL #0
    MOVK  X29, #0x3fc7, LSL #16
    FMOV  X4, D0
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0x7fff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, V1.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0x7fff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, D1
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x8b12, LSL #0
    MOVK  X29, #0x7c03, LSL #16
    MOVK  X29, #0xb84, LSL #32
    MOVK  X29, #0x1a93, LSL #48
    FMOV  X4, V2.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x8b12, LSL #0
    MOVK  X29, #0x7c03, LSL #16
    MOVK  X29, #0xb84, LSL #32
    MOVK  X29, #0x1a93, LSL #48
    FMOV  X4, D2
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x8b12, LSL #0
    MOVK  X29, #0x1a93, LSL #16
    MOVK  X29, #0x8b12, LSL #32
    MOVK  X29, #0x1a93, LSL #48
    FMOV  X4, V3.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x8b12, LSL #0
    MOVK  X29, #0x1a93, LSL #16
    MOVK  X29, #0x8b12, LSL #32
    MOVK  X29, #0x1a93, LSL #48
    FMOV  X4, D3
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V4.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x8b12, LSL #0
    MOVK  X29, #0x7c03, LSL #16
    MOVK  X29, #0xb84, LSL #32
    MOVK  X29, #0x1a93, LSL #48
    FMOV  X4, D4
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V5.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D5
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, V6.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, D6
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, V7.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, D7
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V8.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xcf48, LSL #0
    MOVK  X29, #0x3fc6, LSL #16
    FMOV  X4, D8
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V9.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x3fc6, LSL #0
    MOVK  X29, #0x3fc6, LSL #16
    MOVK  X29, #0x3fc6, LSL #32
    MOVK  X29, #0x3fc6, LSL #48
    FMOV  X4, D9
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x1fa4, LSL #0
    MOVK  X29, #0x1fa4, LSL #16
    MOVK  X29, #0x1fa4, LSL #32
    MOVK  X29, #0x1fa4, LSL #48
    FMOV  X4, V10.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x1fa4, LSL #0
    MOVK  X29, #0x1fa4, LSL #16
    MOVK  X29, #0x1fa4, LSL #32
    MOVK  X29, #0x1fa4, LSL #48
    FMOV  X4, D10
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V11.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x8b12, LSL #0
    MOVK  X29, #0x1a93, LSL #16
    FMOV  X4, D11
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x1fa4, LSL #0
    MOVK  X29, #0x1fa4, LSL #16
    MOVK  X29, #0x1fa4, LSL #32
    MOVK  X29, #0x1fa4, LSL #48
    FMOV  X4, V12.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x1fa4, LSL #0
    MOVK  X29, #0x1fa4, LSL #16
    MOVK  X29, #0x1fa4, LSL #32
    MOVK  X29, #0x1fa4, LSL #48
    FMOV  X4, D12
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xcf48, LSL #0
    MOVK  X29, #0xde56, LSL #16
    MOVK  X29, #0x4ed5, LSL #32
    MOVK  X29, #0x3fc7, LSL #48
    FMOV  X4, V13.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xcf48, LSL #0
    MOVK  X29, #0xde56, LSL #16
    MOVK  X29, #0x4ed5, LSL #32
    MOVK  X29, #0x3fc7, LSL #48
    FMOV  X4, D13
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, V14.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, D14
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V15.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xcf48, LSL #0
    MOVK  X29, #0xde56, LSL #16
    MOVK  X29, #0x4ed5, LSL #32
    MOVK  X29, #0x3fc7, LSL #48
    FMOV  X4, D15
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V16.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x3fc6, LSL #0
    FMOV  X4, D16
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x67a4, LSL #0
    MOVK  X29, #0x1fe3, LSL #16
    MOVK  X29, #0x67a4, LSL #32
    MOVK  X29, #0x1fe3, LSL #48
    FMOV  X4, V17.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x67a4, LSL #0
    MOVK  X29, #0x1fe3, LSL #16
    MOVK  X29, #0x67a4, LSL #32
    MOVK  X29, #0x1fe3, LSL #48
    FMOV  X4, D17
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0x7fff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, V18.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0x7fff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, D18
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0x7fff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, V19.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0x7fff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, D19
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x8b12, LSL #0
    MOVK  X29, #0x7c03, LSL #16
    MOVK  X29, #0xb84, LSL #32
    MOVK  X29, #0x1a93, LSL #48
    FMOV  X4, V20.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x8b12, LSL #0
    MOVK  X29, #0x7c03, LSL #16
    MOVK  X29, #0xb84, LSL #32
    MOVK  X29, #0x1a93, LSL #48
    FMOV  X4, D20
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V21.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x4ed5, LSL #0
    MOVK  X29, #0x3fc7, LSL #16
    MOVK  X29, #0x4ed5, LSL #32
    MOVK  X29, #0x3fc7, LSL #48
    FMOV  X4, D21
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V22.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D22
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x8b12, LSL #0
    MOVK  X29, #0x7c03, LSL #16
    MOVK  X29, #0xb84, LSL #32
    MOVK  X29, #0x1a93, LSL #48
    FMOV  X4, V23.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x8b12, LSL #0
    MOVK  X29, #0x7c03, LSL #16
    MOVK  X29, #0xb84, LSL #32
    MOVK  X29, #0x1a93, LSL #48
    FMOV  X4, D23
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, V24.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, D24
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x8b12, LSL #0
    MOVK  X29, #0x1a93, LSL #16
    MOVK  X29, #0x8b12, LSL #32
    MOVK  X29, #0x1a93, LSL #48
    FMOV  X4, V25.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x8b12, LSL #0
    MOVK  X29, #0x1a93, LSL #16
    MOVK  X29, #0x8b12, LSL #32
    MOVK  X29, #0x1a93, LSL #48
    FMOV  X4, D25
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V26.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D26
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V27.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0x7fff, LSL #16
    FMOV  X4, D27
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x67a4, LSL #0
    MOVK  X29, #0xef2b, LSL #16
    MOVK  X29, #0xa76a, LSL #32
    MOVK  X29, #0x1fe3, LSL #48
    FMOV  X4, V28.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x67a4, LSL #0
    MOVK  X29, #0xef2b, LSL #16
    MOVK  X29, #0xa76a, LSL #32
    MOVK  X29, #0x1fe3, LSL #48
    FMOV  X4, D28
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V29.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, D29
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V30.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x4ed5, LSL #0
    MOVK  X29, #0x3fc7, LSL #16
    MOVK  X29, #0x4ed5, LSL #32
    MOVK  X29, #0x3fc7, LSL #48
    FMOV  X4, D30
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x8b12, LSL #0
    MOVK  X29, #0x7c03, LSL #16
    MOVK  X29, #0xb84, LSL #32
    MOVK  X29, #0x1a93, LSL #48
    FMOV  X4, V31.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x8b12, LSL #0
    MOVK  X29, #0x7c03, LSL #16
    MOVK  X29, #0xb84, LSL #32
    MOVK  X29, #0x1a93, LSL #48
    FMOV  X4, D31
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
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
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
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
    FMOV  D0, X25
    FMOV  V0.D[1], X24
    FMOV  D1, X20
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X8
    FMOV  D3, X16
    FMOV  V3.D[1], X5
    FMOV  D4, X13
    FMOV  V4.D[1], X27
    FMOV  D5, X23
    FMOV  V5.D[1], X20
    FMOV  D6, X16
    FMOV  V6.D[1], X5
    FMOV  D7, X13
    FMOV  V7.D[1], X27
    FMOV  D8, X24
    FMOV  V8.D[1], X5
    FMOV  D9, X24
    FMOV  V9.D[1], X20
    FMOV  D10, X22
    FMOV  V10.D[1], X23
    FMOV  D11, X3
    FMOV  V11.D[1], X24
    FMOV  D12, X6
    FMOV  V12.D[1], X15
    FMOV  D13, X8
    FMOV  V13.D[1], X15
    FMOV  D14, X17
    FMOV  V14.D[1], X8
    FMOV  D15, X3
    FMOV  V15.D[1], X13
    FMOV  D16, X17
    FMOV  V16.D[1], X11
    FMOV  D17, X10
    FMOV  V17.D[1], X24
    FMOV  D18, X16
    FMOV  V18.D[1], X7
    FMOV  D19, X16
    FMOV  V19.D[1], X22
    FMOV  D20, X17
    FMOV  V20.D[1], X7
    FMOV  D21, X13
    FMOV  V21.D[1], X12
    FMOV  D22, X3
    FMOV  V22.D[1], X27
    FMOV  D23, X12
    FMOV  V23.D[1], X2
    FMOV  D24, X10
    FMOV  V24.D[1], X17
    FMOV  D25, X20
    FMOV  V25.D[1], X8
    FMOV  D26, X16
    FMOV  V26.D[1], X17
    FMOV  D27, X7
    FMOV  V27.D[1], X25
    FMOV  D28, X16
    FMOV  V28.D[1], X14
    FMOV  D29, X6
    FMOV  V29.D[1], X8
    FMOV  D30, X20
    FMOV  V30.D[1], X17
    FMOV  D31, X8
    FMOV  V31.D[1], X15
    SQDMULL  V22.2D, V18.2S, V30.2S
    SQDMULL2 V20.2D, V27.4S, V26.S[0x0]
    SQDMULL2 V19.4S, V24.8H, V13.H[0x5]
    SQDMULL2  V10.4S, V25.8H, V25.8H
    SQNEG  V11.16B, V29.16B
    SQRDMULH H23, H28, V15.H[0x2]
    SQRDMULH S7, S31, V21.S[0x3]
    SQRDMULH  V25.4H, V5.4H, V2.H[0x5]
    SQRDMULH  V26.2S, V9.2S, V0.S[0x2]
    SQRDMULH  V9.4H, V0.4H, V15.4H
    SQRSHL  V18.16B, V14.16B, V13.16B
    SQRSHRN V21.8B, V2.8H, #5
    SQRSHRN V5.4H, V6.4S, #9
    SQRSHRN V17.2S, V24.2D, #10
    SQRSHRN2 V3.16B, V0.8H, #8
    SQRSHRN2 V6.8H, V14.4S, #3
    SQRSHRN2 V0.4S, V4.2D, #6
    SQRSHRUN V27.8B, V16.8H, #5
    SQRSHRUN V31.4H, V15.4S, #9
    SQRSHRUN V24.2S, V14.2D, #21
    SQRSHRUN2 V28.16B, V28.8H, #6
    SQRSHRUN2 V2.8H, V8.4S, #5
    SQRSHRUN2 V29.4S, V12.2D, #9
    SQSHL  V30.8B, V14.8B, #0x0
    SQSHL V8.2D, V13.2D, #0x3d
    SQSHL  V4.4H, V12.4H, #0x2
    SQSHL  V12.4S, V14.4S, #0x8
    SQSHL  V14.4S, V14.4S, V15.4S
    SQSHLU  V1.16B, V1.16B, #0x1
    SQSHLU V15.2D, V13.2D, #0x1c
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x800, LSL #16
    MRS  X4, FPSR
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0x7fff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, V0.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D0
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xb4b4, LSL #0
    MOVK  X29, #0xb4b4, LSL #16
    MOVK  X29, #0xb4b4, LSL #32
    MOVK  X29, #0xb4b4, LSL #48
    FMOV  X4, V1.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xb4b4, LSL #0
    MOVK  X29, #0xb4b4, LSL #16
    MOVK  X29, #0xb4b4, LSL #32
    MOVK  X29, #0xb4b4, LSL #48
    FMOV  X4, D1
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X4, V2.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D2
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V3.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D3
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V4.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x7fff, LSL #0
    MOVK  X29, #0x7fff, LSL #16
    MOVK  X29, #0x7fff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, D4
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V5.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x7fff, LSL #0
    MOVK  X29, #0x7fff, LSL #16
    MOVK  X29, #0x7fff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, D5
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x7fff, LSL #0
    MOVK  X29, #0x7fff, LSL #16
    MOVK  X29, #0x7fff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, V6.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D6
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V7.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x4ed6, LSL #0
    MOVK  X29, #0x3fc7, LSL #16
    FMOV  X4, D7
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, V8.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, D8
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V9.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x3fc7, LSL #0
    MOVK  X29, #0x3fc7, LSL #16
    MOVK  X29, #0x3fc7, LSL #32
    MOVK  X29, #0x3fc7, LSL #48
    FMOV  X4, D9
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xcf48, LSL #0
    MOVK  X29, #0x3fc6, LSL #16
    MOVK  X29, #0xcf48, LSL #32
    MOVK  X29, #0x3fc6, LSL #48
    FMOV  X4, V10.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xcf48, LSL #0
    MOVK  X29, #0x3fc6, LSL #16
    MOVK  X29, #0xcf48, LSL #32
    MOVK  X29, #0x3fc6, LSL #48
    FMOV  X4, D10
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xa6a6, LSL #0
    MOVK  X29, #0xa6a6, LSL #16
    MOVK  X29, #0xa6a6, LSL #32
    MOVK  X29, #0xa6a6, LSL #48
    FMOV  X4, V11.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xa6a6, LSL #0
    MOVK  X29, #0xa6a6, LSL #16
    MOVK  X29, #0xa6a6, LSL #32
    MOVK  X29, #0xa6a6, LSL #48
    FMOV  X4, D11
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0x7fff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, V12.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0x7fff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, D12
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V13.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D13
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0x7fff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, V14.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0x7fff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, D14
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X4, V15.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X4, D15
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V16.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D16
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V17.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0x7fff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, D17
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x7f7f, LSL #0
    MOVK  X29, #0x7f7f, LSL #16
    MOVK  X29, #0x7f7f, LSL #32
    MOVK  X29, #0x7f7f, LSL #48
    FMOV  X4, V18.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x7f7f, LSL #0
    MOVK  X29, #0x7f7f, LSL #16
    MOVK  X29, #0x7f7f, LSL #32
    MOVK  X29, #0x7f7f, LSL #48
    FMOV  X4, D18
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xcf48, LSL #0
    MOVK  X29, #0x3fc6, LSL #16
    MOVK  X29, #0xcf48, LSL #32
    MOVK  X29, #0x3fc6, LSL #48
    FMOV  X4, V19.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xcf48, LSL #0
    MOVK  X29, #0x3fc6, LSL #16
    MOVK  X29, #0xcf48, LSL #32
    MOVK  X29, #0x3fc6, LSL #48
    FMOV  X4, D19
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xcf48, LSL #0
    MOVK  X29, #0xde56, LSL #16
    MOVK  X29, #0x4ed5, LSL #32
    MOVK  X29, #0x3fc7, LSL #48
    FMOV  X4, V20.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xcf48, LSL #0
    MOVK  X29, #0xde56, LSL #16
    MOVK  X29, #0x4ed5, LSL #32
    MOVK  X29, #0x3fc7, LSL #48
    FMOV  X4, D20
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V21.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x7f7f, LSL #0
    MOVK  X29, #0x7f7f, LSL #16
    MOVK  X29, #0x7f7f, LSL #32
    MOVK  X29, #0x7f7f, LSL #48
    FMOV  X4, D21
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xcf48, LSL #0
    MOVK  X29, #0xde56, LSL #16
    MOVK  X29, #0x4ed5, LSL #32
    MOVK  X29, #0x3fc7, LSL #48
    FMOV  X4, V22.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xcf48, LSL #0
    MOVK  X29, #0xde56, LSL #16
    MOVK  X29, #0x4ed5, LSL #32
    MOVK  X29, #0x3fc7, LSL #48
    FMOV  X4, D22
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V23.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x3fc7, LSL #0
    FMOV  X4, D23
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V24.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X4, D24
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V25.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x3fc7, LSL #0
    MOVK  X29, #0x3fc7, LSL #16
    MOVK  X29, #0x3fc7, LSL #32
    MOVK  X29, #0x3fc7, LSL #48
    FMOV  X4, D25
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V26.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x4ed6, LSL #0
    MOVK  X29, #0x3fc7, LSL #16
    MOVK  X29, #0x4ed6, LSL #32
    MOVK  X29, #0x3fc7, LSL #48
    FMOV  X4, D26
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V27.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X4, D27
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X4, V28.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D28
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X4, V29.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D29
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V30.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D30
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V31.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X4, D31
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
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
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
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
    FMOV  D0, X25
    FMOV  V0.D[1], X24
    FMOV  D1, X26
    FMOV  V1.D[1], X23
    FMOV  D2, X27
    FMOV  V2.D[1], X26
    FMOV  D3, X20
    FMOV  V3.D[1], X3
    FMOV  D4, X27
    FMOV  V4.D[1], X25
    FMOV  D5, X5
    FMOV  V5.D[1], X15
    FMOV  D6, X3
    FMOV  V6.D[1], X3
    FMOV  D7, X15
    FMOV  V7.D[1], X11
    FMOV  D8, X5
    FMOV  V8.D[1], X26
    FMOV  D9, X12
    FMOV  V9.D[1], X7
    FMOV  D10, X7
    FMOV  V10.D[1], X15
    FMOV  D11, X27
    FMOV  V11.D[1], X13
    FMOV  D12, X22
    FMOV  V12.D[1], X10
    FMOV  D13, X7
    FMOV  V13.D[1], X20
    FMOV  D14, X26
    FMOV  V14.D[1], X16
    FMOV  D15, X5
    FMOV  V15.D[1], X24
    FMOV  D16, X5
    FMOV  V16.D[1], X12
    FMOV  D17, X3
    FMOV  V17.D[1], X23
    FMOV  D18, X22
    FMOV  V18.D[1], X24
    FMOV  D19, X26
    FMOV  V19.D[1], X14
    FMOV  D20, X10
    FMOV  V20.D[1], X12
    FMOV  D21, X10
    FMOV  V21.D[1], X24
    FMOV  D22, X6
    FMOV  V22.D[1], X7
    FMOV  D23, X6
    FMOV  V23.D[1], X11
    FMOV  D24, X27
    FMOV  V24.D[1], X24
    FMOV  D25, X3
    FMOV  V25.D[1], X2
    FMOV  D26, X11
    FMOV  V26.D[1], X8
    FMOV  D27, X5
    FMOV  V27.D[1], X23
    FMOV  D28, X27
    FMOV  V28.D[1], X12
    FMOV  D29, X13
    FMOV  V29.D[1], X13
    FMOV  D30, X22
    FMOV  V30.D[1], X25
    FMOV  D31, X16
    FMOV  V31.D[1], X14
    SQSHLU  V0.2S, V23.2S, #0x19
    SQSHRN V20.8B, V25.8H, #7
    SQSHRN V1.4H, V31.4S, #3
    SQSHRN V5.2S, V27.2D, #29
    SQSHRN2 V21.16B, V21.8H, #5
    SQSHRN2 V24.8H, V26.4S, #15
    SQSHRN2 V15.4S, V28.2D, #12
    SQSHRUN V10.8B, V22.8H, #1
    SQSHRUN V11.4H, V27.4S, #4
    SQSHRUN V30.2S, V30.2D, #11
    SQSHRUN2 V27.16B, V3.8H, #7
    SQSHRUN2 V22.8H, V29.4S, #7
    SQSHRUN2 V31.4S, V16.2D, #17
    SQSUB  V6.4H, V7.4H, V13.4H
    SQXTN  V7.2S, V4.2D
    SQXTN2  V14.16B, V25.8H
    SQXTUN  V19.4H, V9.4S
    SQXTUN2  V18.4S, V4.2D
    SRHADD  V16.8B, V16.8B, V9.8B
    SRSHL  V17.8B, V3.8B, V12.8B
    SRSHR  V28.16B, V23.16B, #7
    SRSHR V26.2D, V2.2D, #40
    SRSHR  V2.8H, V9.8H, #12
    SRSHR  V12.2S, V3.2S, #2
    SRSRA  V3.16B, V29.16B, #1
    SRSRA V25.2D, V29.2D, #36
    SRSRA  V13.4H, V23.4H, #3
    SRSRA  V29.2S, V4.2S, #3
    SSHL  V23.2S, V8.2S, V9.2S
    SSHLL V8.2D, V8.2S, #0x1a
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x800, LSL #16
    MRS  X4, FPSR
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V0.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X4, D0
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V1.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x7fff, LSL #0
    MOVK  X29, #0x7fff, LSL #16
    MOVK  X29, #0x7fff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, D1
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x6, LSL #0
    MOVK  X29, #0x6, LSL #16
    MOVK  X29, #0x6, LSL #32
    MOVK  X29, #0x6, LSL #48
    FMOV  X4, V2.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x6, LSL #0
    MOVK  X29, #0x6, LSL #16
    MOVK  X29, #0x6, LSL #32
    MOVK  X29, #0x6, LSL #48
    FMOV  X4, D2
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x8787, LSL #0
    MOVK  X29, #0x8787, LSL #16
    MOVK  X29, #0x8787, LSL #32
    MOVK  X29, #0x8787, LSL #48
    FMOV  X4, V3.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x8787, LSL #0
    MOVK  X29, #0x8787, LSL #16
    MOVK  X29, #0x8787, LSL #32
    MOVK  X29, #0x8787, LSL #48
    FMOV  X4, D3
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V4.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D4
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V5.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0x7fff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, D5
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V6.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, D6
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V7.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0x7fff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, D7
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x6800, LSL #16
    MOVK  X29, #0x6969, LSL #32
    MOVK  X29, #0x169, LSL #48
    FMOV  X4, V8.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x6800, LSL #16
    MOVK  X29, #0x6969, LSL #32
    MOVK  X29, #0x169, LSL #48
    FMOV  X4, D8
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V9.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D9
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V10.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X4, D10
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V11.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X4, D11
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V12.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x9697, LSL #0
    MOVK  X29, #0x1696, LSL #16
    MOVK  X29, #0x9697, LSL #32
    MOVK  X29, #0x1696, LSL #48
    FMOV  X4, D12
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V13.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x65a5, LSL #0
    MOVK  X29, #0x65a5, LSL #16
    MOVK  X29, #0x65a5, LSL #32
    MOVK  X29, #0x65a5, LSL #48
    FMOV  X4, D13
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x7f7f, LSL #0
    MOVK  X29, #0x7f7f, LSL #16
    MOVK  X29, #0x7f7f, LSL #32
    MOVK  X29, #0x7f7f, LSL #48
    FMOV  X4, V14.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D14
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0x7fff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, V15.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D15
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V16.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D16
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V17.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, D17
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X4, V18.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D18
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V19.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X4, D19
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V20.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x7f7f, LSL #0
    MOVK  X29, #0x7f7f, LSL #16
    MOVK  X29, #0x7f7f, LSL #32
    MOVK  X29, #0x7f7f, LSL #48
    FMOV  X4, D20
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x7f7f, LSL #0
    MOVK  X29, #0x7f7f, LSL #16
    MOVK  X29, #0x7f7f, LSL #32
    MOVK  X29, #0x7f7f, LSL #48
    FMOV  X4, V21.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D21
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X4, V22.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D22
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V23.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, D23
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x7fff, LSL #0
    MOVK  X29, #0x7fff, LSL #16
    MOVK  X29, #0x7fff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, V24.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D24
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x6000, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V25.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x6000, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D25
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a, LSL #16
    FMOV  X4, V26.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a, LSL #16
    FMOV  X4, D26
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xb4b4, LSL #0
    MOVK  X29, #0xb4b4, LSL #16
    MOVK  X29, #0xb4b4, LSL #32
    MOVK  X29, #0xb4b4, LSL #48
    FMOV  X4, V27.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D27
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x101, LSL #0
    MOVK  X29, #0x101, LSL #16
    MOVK  X29, #0x101, LSL #32
    MOVK  X29, #0x101, LSL #48
    FMOV  X4, V28.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x101, LSL #0
    MOVK  X29, #0x101, LSL #16
    MOVK  X29, #0x101, LSL #32
    MOVK  X29, #0x101, LSL #48
    FMOV  X4, D28
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V29.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0x65a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0x65a5, LSL #48
    FMOV  X4, D29
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V30.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X4, D30
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X4, V31.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D31
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
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
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
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
    FMOV  D0, X23
    FMOV  V0.D[1], X26
    FMOV  D1, X25
    FMOV  V1.D[1], X24
    FMOV  D2, X27
    FMOV  V2.D[1], X22
    FMOV  D3, X17
    FMOV  V3.D[1], X7
    FMOV  D4, X12
    FMOV  V4.D[1], X22
    FMOV  D5, X10
    FMOV  V5.D[1], X13
    FMOV  D6, X24
    FMOV  V6.D[1], X11
    FMOV  D7, X6
    FMOV  V7.D[1], X8
    FMOV  D8, X20
    FMOV  V8.D[1], X8
    FMOV  D9, X25
    FMOV  V9.D[1], X25
    FMOV  D10, X3
    FMOV  V10.D[1], X7
    FMOV  D11, X6
    FMOV  V11.D[1], X27
    FMOV  D12, X8
    FMOV  V12.D[1], X6
    FMOV  D13, X8
    FMOV  V13.D[1], X26
    FMOV  D14, X22
    FMOV  V14.D[1], X6
    FMOV  D15, X6
    FMOV  V15.D[1], X12
    FMOV  D16, X8
    FMOV  V16.D[1], X23
    FMOV  D17, X15
    FMOV  V17.D[1], X24
    FMOV  D18, X24
    FMOV  V18.D[1], X15
    FMOV  D19, X8
    FMOV  V19.D[1], X15
    FMOV  D20, X23
    FMOV  V20.D[1], X15
    FMOV  D21, X26
    FMOV  V21.D[1], X2
    FMOV  D22, X5
    FMOV  V22.D[1], X12
    FMOV  D23, X6
    FMOV  V23.D[1], X13
    FMOV  D24, X16
    FMOV  V24.D[1], X27
    FMOV  D25, X14
    FMOV  V25.D[1], X10
    FMOV  D26, X2
    FMOV  V26.D[1], X7
    FMOV  D27, X25
    FMOV  V27.D[1], X5
    FMOV  D28, X8
    FMOV  V28.D[1], X5
    FMOV  D29, X3
    FMOV  V29.D[1], X22
    FMOV  D30, X22
    FMOV  V30.D[1], X3
    FMOV  D31, X14
    FMOV  V31.D[1], X17
    SSHLL V31.4S, V30.4H, #0x4
    SSHLL2 V16.2D, V29.4S, #0x1e
    SSHLL2 V30.8H, V24.16B, #0x3
    SSHLL2 V11.4S, V23.8H, #0x6
    SSHR  V27.8B, V21.8B, #6
    SSHR V0.2D, V28.2D, #54
    SSHR  V19.4H, V26.4H, #6
    SSHR  V4.4S, V25.4S, #10
    SSRA  V5.16B, V23.16B, #8
    SSRA V6.2D, V12.2D, #23
    SSRA  V3.4H, V28.4H, #3
    SSRA  V20.4S, V26.4S, #16
    SSUBL  V24.4S, V9.4H, V18.4H
    SSUBL2  V26.8H, V14.16B, V21.16B
    SSUBW  V17.2D, V18.2D, V10.2S
    SSUBW2  V25.2D, V22.2D, V14.4S
    SUQADD  V28.4S, V15.4S
    SXTL V8.2D, V12.2S
    SXTL V21.8H, V13.8B
    SXTL V13.4S, V7.4H
    SXTL2 V9.2D, V7.4S
    SXTL2 V15.8H, V22.16B
    SXTL2 V2.4S, V22.8H
    SCVTF V22.2D, V23.2D, #30
    SCVTF  V1.2S, V12.2S, #27
    SCVTF  V23.2D, V29.2D
    UCVTF V18.2D, V14.2D, #52
    UCVTF  V14.2S, V14.2S, #15
    UCVTF  V7.4S, V7.4S
    SCVTF  V10.4H, V10.4H, #15
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x10, LSL #0
    MOVK  X29, #0x800, LSL #16
    MRS  X4, FPSR
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x169, LSL #0
    FMOV  X4, V0.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x169, LSL #0
    FMOV  X4, D0
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V1.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xb4b5, LSL #0
    MOVK  X29, #0x4134, LSL #16
    MOVK  X29, #0xb4b5, LSL #32
    MOVK  X29, #0x4134, LSL #48
    FMOV  X4, D1
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #32
    FMOV  X4, V2.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #32
    FMOV  X4, D2
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V3.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x65a5, LSL #0
    MOVK  X29, #0x65a5, LSL #16
    MOVK  X29, #0x65a5, LSL #32
    MOVK  X29, #0x65a5, LSL #48
    FMOV  X4, D3
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x9696, LSL #0
    MOVK  X29, #0x16, LSL #16
    MOVK  X29, #0x9696, LSL #32
    MOVK  X29, #0x16, LSL #48
    FMOV  X4, V4.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x9696, LSL #0
    MOVK  X29, #0x16, LSL #16
    MOVK  X29, #0x9696, LSL #32
    MOVK  X29, #0x16, LSL #48
    FMOV  X4, D4
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V5.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D5
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xf0e, LSL #0
    MOVK  X29, #0xf0f, LSL #16
    MOVK  X29, #0x5b0f, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V6.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xf0e, LSL #0
    MOVK  X29, #0xf0f, LSL #16
    MOVK  X29, #0x5b0f, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D6
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xb4b5, LSL #0
    MOVK  X29, #0x4eb4, LSL #16
    MOVK  X29, #0xb4b5, LSL #32
    MOVK  X29, #0x4eb4, LSL #48
    FMOV  X4, V7.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xb4b5, LSL #0
    MOVK  X29, #0x4eb4, LSL #16
    MOVK  X29, #0xb4b5, LSL #32
    MOVK  X29, #0x4eb4, LSL #48
    FMOV  X4, D7
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    FMOV  X4, V8.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    FMOV  X4, D8
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    FMOV  X4, V9.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    FMOV  X4, D9
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V10.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x39a6, LSL #0
    MOVK  X29, #0x39a6, LSL #16
    MOVK  X29, #0x39a6, LSL #32
    MOVK  X29, #0x39a6, LSL #48
    FMOV  X4, D10
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x9680, LSL #0
    MOVK  X29, #0x16, LSL #16
    MOVK  X29, #0x9680, LSL #32
    MOVK  X29, #0x16, LSL #48
    FMOV  X4, V11.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x9680, LSL #0
    MOVK  X29, #0x16, LSL #16
    MOVK  X29, #0x9680, LSL #32
    MOVK  X29, #0x16, LSL #48
    FMOV  X4, D11
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V12.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D12
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #32
    FMOV  X4, V13.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #32
    FMOV  X4, D13
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V14.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xb4b5, LSL #0
    MOVK  X29, #0x4734, LSL #16
    MOVK  X29, #0xb4b5, LSL #32
    MOVK  X29, #0x4734, LSL #48
    FMOV  X4, D14
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a, LSL #0
    MOVK  X29, #0x5a, LSL #16
    MOVK  X29, #0x5a, LSL #32
    MOVK  X29, #0x5a, LSL #48
    FMOV  X4, V15.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a, LSL #0
    MOVK  X29, #0x5a, LSL #16
    MOVK  X29, #0x5a, LSL #32
    MOVK  X29, #0x5a, LSL #48
    FMOV  X4, D15
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x8000, LSL #16
    MOVK  X29, #0x9696, LSL #32
    MOVK  X29, #0x1696, LSL #48
    FMOV  X4, V16.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x8000, LSL #16
    MOVK  X29, #0x9696, LSL #32
    MOVK  X29, #0x1696, LSL #48
    FMOV  X4, D16
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V17.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D17
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x9697, LSL #0
    MOVK  X29, #0x9696, LSL #16
    MOVK  X29, #0x9696, LSL #32
    MOVK  X29, #0x4096, LSL #48
    FMOV  X4, V18.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x9697, LSL #0
    MOVK  X29, #0x9696, LSL #16
    MOVK  X29, #0x9696, LSL #32
    MOVK  X29, #0x4096, LSL #48
    FMOV  X4, D18
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V19.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x169, LSL #0
    MOVK  X29, #0x169, LSL #16
    MOVK  X29, #0x169, LSL #32
    MOVK  X29, #0x169, LSL #48
    FMOV  X4, D19
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xb4b4, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0xb4b4, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V20.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xb4b4, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0xb4b4, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D20
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a, LSL #0
    MOVK  X29, #0x5a, LSL #16
    MOVK  X29, #0x5a, LSL #32
    MOVK  X29, #0x5a, LSL #48
    FMOV  X4, V21.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a, LSL #0
    MOVK  X29, #0x5a, LSL #16
    MOVK  X29, #0x5a, LSL #32
    MOVK  X29, #0x5a, LSL #48
    FMOV  X4, D21
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x9697, LSL #0
    MOVK  X29, #0x9696, LSL #16
    MOVK  X29, #0x9696, LSL #32
    MOVK  X29, #0x41f6, LSL #48
    FMOV  X4, V22.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x9697, LSL #0
    MOVK  X29, #0x9696, LSL #16
    MOVK  X29, #0x9696, LSL #32
    MOVK  X29, #0x41f6, LSL #48
    FMOV  X4, D22
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x9697, LSL #0
    MOVK  X29, #0x9696, LSL #16
    MOVK  X29, #0x9696, LSL #32
    MOVK  X29, #0x43d6, LSL #48
    FMOV  X4, V23.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x9697, LSL #0
    MOVK  X29, #0x9696, LSL #16
    MOVK  X29, #0x9696, LSL #32
    MOVK  X29, #0x43d6, LSL #48
    FMOV  X4, D23
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V24.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, D24
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V25.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D25
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V26.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, D26
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V27.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x101, LSL #0
    MOVK  X29, #0x101, LSL #16
    MOVK  X29, #0x101, LSL #32
    MOVK  X29, #0x101, LSL #48
    FMOV  X4, D27
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0x7fff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, V28.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0x7fff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X4, D28
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V29.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D29
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x2d0, LSL #0
    MOVK  X29, #0x2d0, LSL #16
    MOVK  X29, #0x2d0, LSL #32
    MOVK  X29, #0x2d0, LSL #48
    FMOV  X4, V30.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x2d0, LSL #0
    MOVK  X29, #0x2d0, LSL #16
    MOVK  X29, #0x2d0, LSL #32
    MOVK  X29, #0x2d0, LSL #48
    FMOV  X4, D30
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xa5a0, LSL #0
    MOVK  X29, #0x5, LSL #16
    MOVK  X29, #0xa5a0, LSL #32
    MOVK  X29, #0x5, LSL #48
    FMOV  X4, V31.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0xa5a0, LSL #0
    MOVK  X29, #0x5, LSL #16
    MOVK  X29, #0xa5a0, LSL #32
    MOVK  X29, #0x5, LSL #48
    FMOV  X4, D31
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
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
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
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
    FMOV  D0, X25
    FMOV  V0.D[1], X22
    FMOV  D1, X23
    FMOV  V1.D[1], X27
    FMOV  D2, X24
    FMOV  V2.D[1], X26
    FMOV  D3, X13
    FMOV  V3.D[1], X25
    FMOV  D4, X7
    FMOV  V4.D[1], X10
    FMOV  D5, X26
    FMOV  V5.D[1], X15
    FMOV  D6, X5
    FMOV  V6.D[1], X22
    FMOV  D7, X23
    FMOV  V7.D[1], X10
    FMOV  D8, X3
    FMOV  V8.D[1], X23
    FMOV  D9, X25
    FMOV  V9.D[1], X8
    FMOV  D10, X24
    FMOV  V10.D[1], X8
    FMOV  D11, X3
    FMOV  V11.D[1], X2
    FMOV  D12, X22
    FMOV  V12.D[1], X27
    FMOV  D13, X13
    FMOV  V13.D[1], X14
    FMOV  D14, X27
    FMOV  V14.D[1], X24
    FMOV  D15, X2
    FMOV  V15.D[1], X5
    FMOV  D16, X3
    FMOV  V16.D[1], X16
    FMOV  D17, X27
    FMOV  V17.D[1], X26
    FMOV  D18, X16
    FMOV  V18.D[1], X20
    FMOV  D19, X27
    FMOV  V19.D[1], X22
    FMOV  D20, X26
    FMOV  V20.D[1], X17
    FMOV  D21, X14
    FMOV  V21.D[1], X23
    FMOV  D22, X12
    FMOV  V22.D[1], X27
    FMOV  D23, X16
    FMOV  V23.D[1], X8
    FMOV  D24, X11
    FMOV  V24.D[1], X6
    FMOV  D25, X2
    FMOV  V25.D[1], X6
    FMOV  D26, X25
    FMOV  V26.D[1], X12
    FMOV  D27, X5
    FMOV  V27.D[1], X7
    FMOV  D28, X22
    FMOV  V28.D[1], X27
    FMOV  D29, X5
    FMOV  V29.D[1], X16
    FMOV  D30, X23
    FMOV  V30.D[1], X25
    FMOV  D31, X15
    FMOV  V31.D[1], X10
    UCVTF  V31.8H, V30.8H, #6
    UCVTF  V9.4H, V21.4H
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X4, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x10, LSL #0
    MOVK  X29, #0x800, LSL #16
    MRS  X4, FPSR
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V0.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D0
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V1.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D1
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V2.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D2
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V3.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D3
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V4.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D4
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V5.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D5
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V6.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D6
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V7.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D7
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V8.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D8
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X4, V9.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x75a6, LSL #0
    MOVK  X29, #0x75a6, LSL #16
    MOVK  X29, #0x75a6, LSL #32
    MOVK  X29, #0x75a6, LSL #48
    FMOV  X4, D9
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V10.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D10
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V11.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D11
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V12.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D12
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V13.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D13
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V14.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D14
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V15.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D15
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V16.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D16
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V17.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D17
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V18.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D18
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V19.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D19
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V20.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D20
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V21.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D21
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V22.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D22
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V23.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D23
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V24.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D24
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V25.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D25
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V26.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D26
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V27.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D27
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V28.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D28
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V29.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D29
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, V30.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X4, D30
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5da6, LSL #0
    MOVK  X29, #0x5da6, LSL #16
    MOVK  X29, #0x5da6, LSL #32
    MOVK  X29, #0x5da6, LSL #48
    FMOV  X4, V31.D[1]
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X29, #0x5da6, LSL #0
    MOVK  X29, #0x5da6, LSL #16
    MOVK  X29, #0x5da6, LSL #32
    MOVK  X29, #0x5da6, LSL #48
    FMOV  X4, D31
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP03_TestFail
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
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
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
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X25
    FMOV  D1, X27
    FMOV  V1.D[1], X24
    FMOV  D2, X29
    FMOV  V2.D[1], X14
    FMOV  D3, X17
    FMOV  V3.D[1], X13
    FMOV  D4, X4
    FMOV  V4.D[1], X4
    FMOV  D5, X2
    FMOV  V5.D[1], X15
    FMOV  D6, X22
    FMOV  V6.D[1], X4
    FMOV  D7, X8
    FMOV  V7.D[1], X23
    FMOV  D8, X8
    FMOV  V8.D[1], X17
    FMOV  D9, X29
    FMOV  V9.D[1], X11
    FMOV  D10, X24
    FMOV  V10.D[1], X22
    FMOV  D11, X26
    FMOV  V11.D[1], X6
    FMOV  D12, X11
    FMOV  V12.D[1], X11
    FMOV  D13, X8
    FMOV  V13.D[1], X14
    FMOV  D14, X16
    FMOV  V14.D[1], X4
    FMOV  D15, X7
    FMOV  V15.D[1], X16
    FMOV  D16, X4
    FMOV  V16.D[1], X9
    FMOV  D17, X6
    FMOV  V17.D[1], X5
    FMOV  D18, X25
    FMOV  V18.D[1], X26
    FMOV  D19, X14
    FMOV  V19.D[1], X29
    FMOV  D20, X23
    FMOV  V20.D[1], X26
    FMOV  D21, X24
    FMOV  V21.D[1], X8
    FMOV  D22, X2
    FMOV  V22.D[1], X27
    FMOV  D23, X6
    FMOV  V23.D[1], X7
    FMOV  D24, X24
    FMOV  V24.D[1], X10
    FMOV  D25, X14
    FMOV  V25.D[1], X4
    FMOV  D26, X25
    FMOV  V26.D[1], X17
    FMOV  D27, X4
    FMOV  V27.D[1], X12
    FMOV  D28, X27
    FMOV  V28.D[1], X20
    FMOV  D29, X2
    FMOV  V29.D[1], X23
    FMOV  D30, X20
    FMOV  V30.D[1], X14
    FMOV  D31, X22
    FMOV  V31.D[1], X17
    SABA  V3.16B, V21.16B, V20.16B
    SABAL  V18.2D, V29.2S, V25.2S
    SABAL2  V28.4S, V26.8H, V27.8H
    SABD  V26.8B, V24.8B, V24.8B
    SABDL  V17.8H, V19.8B, V30.8B
    SABDL2  V19.8H, V21.16B, V31.16B
    SADALP  V1.2S, V22.4H
    SADDL  V15.2D, V10.2S, V16.2S
    SADDL2  V14.4S, V4.8H, V20.8H
    SADDLP  V25.4H, V16.8B
    SADDLV  H16, V16.16B
    SADDLV  S6, V6.8H
    SADDLV  D0, V2.4S
    SADDW  V12.8H, V30.8H, V21.8B
    SADDW2  V24.4S, V20.4S, V10.8H
    SHADD  V29.16B, V13.16B, V13.16B
    SHSUB  V13.8H, V8.8H, V7.8H
    SMLAL V9.2D, V30.2S, V21.S[0x2]
    SMLAL V11.4S, V5.4H, V11.H[0x3]
    SMLAL  V22.4S, V2.4H, V27.4H
    SMLAL2 V21.2D, V23.4S, V5.S[0x0]
    SMLAL2 V27.4S, V27.8H, V5.H[0x7]
    SMLAL2  V7.4S, V20.8H, V2.8H
    SMLSL V4.2D, V30.2S, V4.S[0x1]
    SMLSL V5.4S, V31.4H, V5.H[0x3]
    SMLSL  V2.4S, V23.4H, V23.4H
    SMLSL2 V30.2D, V10.4S, V10.S[0x2]
    SMLSL2 V31.4S, V31.8H, V10.H[0x3]
    SMLSL2  V23.2D, V8.4S, V20.4S
    SMOV W17, V8.B[0xf]
    SMOV W22, V10.H[0x0]
    SMOV  X9, V8.B[0x4]
    SMOV  X27, V10.H[0x5]
    SMOV  X14, V20.S[0x0]
    SMULL V20.2D, V8.2S, V8.S[0x0]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xffa5, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X2, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X2, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xffa5, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X2, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X2, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X2, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x10, LSL #0
    MOVK  X8, #0x800, LSL #16
    MRS  X2, FPSR
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V0.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x9694, LSL #0
    MOVK  X8, #0x9696, LSL #16
    MOVK  X8, #0xfffe, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X2, D0
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V1.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xf0ef, LSL #0
    MOVK  X8, #0xa5a4, LSL #16
    MOVK  X8, #0xf0ef, LSL #32
    MOVK  X8, #0xa5a4, LSL #48
    FMOV  X2, D1
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x894c, LSL #0
    MOVK  X8, #0x85c1, LSL #16
    MOVK  X8, #0x894c, LSL #32
    MOVK  X8, #0x85c1, LSL #48
    FMOV  X2, V2.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x894c, LSL #0
    MOVK  X8, #0x85c1, LSL #16
    MOVK  X8, #0x894c, LSL #32
    MOVK  X8, #0x85c1, LSL #48
    FMOV  X2, D2
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V3.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D3
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x894c, LSL #0
    MOVK  X8, #0x1c5, LSL #16
    MOVK  X8, #0xfe3a, LSL #32
    MOVK  X8, #0x85c1, LSL #48
    FMOV  X2, V4.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x894c, LSL #0
    MOVK  X8, #0x1c5, LSL #16
    MOVK  X8, #0xfe3a, LSL #32
    MOVK  X8, #0x85c1, LSL #48
    FMOV  X2, D4
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x894c, LSL #0
    MOVK  X8, #0x85c1, LSL #16
    MOVK  X8, #0x894c, LSL #32
    MOVK  X8, #0x85c1, LSL #48
    FMOV  X2, V5.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x894c, LSL #0
    MOVK  X8, #0x85c1, LSL #16
    MOVK  X8, #0x894c, LSL #32
    MOVK  X8, #0x85c1, LSL #48
    FMOV  X2, D5
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V6.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x2d28, LSL #0
    MOVK  X8, #0xfffd, LSL #16
    FMOV  X2, D6
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xc1fe, LSL #0
    MOVK  X8, #0xc589, LSL #16
    MOVK  X8, #0xc1fe, LSL #32
    MOVK  X8, #0xc589, LSL #48
    FMOV  X2, V7.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xc1fe, LSL #0
    MOVK  X8, #0xc589, LSL #16
    MOVK  X8, #0xc1fe, LSL #32
    MOVK  X8, #0xc589, LSL #48
    FMOV  X2, D7
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V8.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D8
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xc1fe, LSL #0
    MOVK  X8, #0x4985, LSL #16
    MOVK  X8, #0x4d11, LSL #32
    MOVK  X8, #0xc589, LSL #48
    FMOV  X2, V9.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xc1fe, LSL #0
    MOVK  X8, #0x4985, LSL #16
    MOVK  X8, #0x4d11, LSL #32
    MOVK  X8, #0xc589, LSL #48
    FMOV  X2, D9
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V10.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D10
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xc1fe, LSL #0
    MOVK  X8, #0xc589, LSL #16
    MOVK  X8, #0xc1fe, LSL #32
    MOVK  X8, #0xc589, LSL #48
    FMOV  X2, V11.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xc1fe, LSL #0
    MOVK  X8, #0xc589, LSL #16
    MOVK  X8, #0xc1fe, LSL #32
    MOVK  X8, #0xc589, LSL #48
    FMOV  X2, D11
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa54a, LSL #0
    MOVK  X8, #0xa54a, LSL #16
    MOVK  X8, #0xa54a, LSL #32
    MOVK  X8, #0xa54a, LSL #48
    FMOV  X2, V12.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa54a, LSL #0
    MOVK  X8, #0xa54a, LSL #16
    MOVK  X8, #0xa54a, LSL #32
    MOVK  X8, #0xa54a, LSL #48
    FMOV  X2, D12
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V13.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D13
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x4b4a, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0x4b4a, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X2, V14.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x4b4a, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0x4b4a, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X2, D14
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x4b4a, LSL #0
    MOVK  X8, #0x4b4b, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X2, V15.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x4b4a, LSL #0
    MOVK  X8, #0x4b4b, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X2, D15
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V16.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xfa50, LSL #0
    FMOV  X2, D16
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V17.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D17
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V18.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D18
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V19.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D19
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x1c59, LSL #0
    MOVK  X8, #0xa3e0, LSL #16
    MOVK  X8, #0xa76b, LSL #32
    MOVK  X8, #0x1fe3, LSL #48
    FMOV  X2, V20.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x1c59, LSL #0
    MOVK  X8, #0xa3e0, LSL #16
    MOVK  X8, #0xa76b, LSL #32
    MOVK  X8, #0x1fe3, LSL #48
    FMOV  X2, D20
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xc1fe, LSL #0
    MOVK  X8, #0x4985, LSL #16
    MOVK  X8, #0x4d11, LSL #32
    MOVK  X8, #0xc589, LSL #48
    FMOV  X2, V21.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xc1fe, LSL #0
    MOVK  X8, #0x4985, LSL #16
    MOVK  X8, #0x4d11, LSL #32
    MOVK  X8, #0xc589, LSL #48
    FMOV  X2, D21
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xc1fe, LSL #0
    MOVK  X8, #0xc589, LSL #16
    MOVK  X8, #0xc1fe, LSL #32
    MOVK  X8, #0xc589, LSL #48
    FMOV  X2, V22.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xc1fe, LSL #0
    MOVK  X8, #0xc589, LSL #16
    MOVK  X8, #0xc1fe, LSL #32
    MOVK  X8, #0xc589, LSL #48
    FMOV  X2, D22
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x894c, LSL #0
    MOVK  X8, #0x1c5, LSL #16
    MOVK  X8, #0xfe3a, LSL #32
    MOVK  X8, #0x85c1, LSL #48
    FMOV  X2, V23.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x894c, LSL #0
    MOVK  X8, #0x1c5, LSL #16
    MOVK  X8, #0xfe3a, LSL #32
    MOVK  X8, #0x85c1, LSL #48
    FMOV  X2, D23
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x4b4a, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0x4b4a, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V24.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x4b4a, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0x4b4a, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D24
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V25.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xff4a, LSL #0
    MOVK  X8, #0xff4a, LSL #16
    MOVK  X8, #0xff4a, LSL #32
    MOVK  X8, #0xff4a, LSL #48
    FMOV  X2, D25
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V26.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D26
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xc1fe, LSL #0
    MOVK  X8, #0xc589, LSL #16
    MOVK  X8, #0xc1fe, LSL #32
    MOVK  X8, #0xc589, LSL #48
    FMOV  X2, V27.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xc1fe, LSL #0
    MOVK  X8, #0xc589, LSL #16
    MOVK  X8, #0xc1fe, LSL #32
    MOVK  X8, #0xc589, LSL #48
    FMOV  X2, D27
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V28.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D28
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V29.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D29
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x894c, LSL #0
    MOVK  X8, #0x1c5, LSL #16
    MOVK  X8, #0xfe3a, LSL #32
    MOVK  X8, #0x85c1, LSL #48
    FMOV  X2, V30.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x894c, LSL #0
    MOVK  X8, #0x1c5, LSL #16
    MOVK  X8, #0xfe3a, LSL #32
    MOVK  X8, #0x85c1, LSL #48
    FMOV  X2, D30
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x894c, LSL #0
    MOVK  X8, #0x85c1, LSL #16
    MOVK  X8, #0x894c, LSL #32
    MOVK  X8, #0x85c1, LSL #48
    FMOV  X2, V31.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x894c, LSL #0
    MOVK  X8, #0x85c1, LSL #16
    MOVK  X8, #0x894c, LSL #32
    MOVK  X8, #0x85c1, LSL #48
    FMOV  X2, D31
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
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
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
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
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
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
    FMOV  D0, X24
    FMOV  V0.D[1], X27
    FMOV  D1, X26
    FMOV  V1.D[1], X25
    FMOV  D2, X16
    FMOV  V2.D[1], X20
    FMOV  D3, X17
    FMOV  V3.D[1], X13
    FMOV  D4, X22
    FMOV  V4.D[1], X5
    FMOV  D5, X6
    FMOV  V5.D[1], X4
    FMOV  D6, X13
    FMOV  V6.D[1], X26
    FMOV  D7, X10
    FMOV  V7.D[1], X25
    FMOV  D8, X5
    FMOV  V8.D[1], X24
    FMOV  D9, X15
    FMOV  V9.D[1], X15
    FMOV  D10, X27
    FMOV  V10.D[1], X20
    FMOV  D11, X10
    FMOV  V11.D[1], X22
    FMOV  D12, X9
    FMOV  V12.D[1], X4
    FMOV  D13, X7
    FMOV  V13.D[1], X6
    FMOV  D14, X17
    FMOV  V14.D[1], X9
    FMOV  D15, X20
    FMOV  V15.D[1], X3
    FMOV  D16, X20
    FMOV  V16.D[1], X13
    FMOV  D17, X25
    FMOV  V17.D[1], X15
    FMOV  D18, X14
    FMOV  V18.D[1], X22
    FMOV  D19, X4
    FMOV  V19.D[1], X5
    FMOV  D20, X23
    FMOV  V20.D[1], X25
    FMOV  D21, X16
    FMOV  V21.D[1], X10
    FMOV  D22, X11
    FMOV  V22.D[1], X7
    FMOV  D23, X12
    FMOV  V23.D[1], X14
    FMOV  D24, X26
    FMOV  V24.D[1], X25
    FMOV  D25, X5
    FMOV  V25.D[1], X16
    FMOV  D26, X3
    FMOV  V26.D[1], X26
    FMOV  D27, X22
    FMOV  V27.D[1], X4
    FMOV  D28, X22
    FMOV  V28.D[1], X10
    FMOV  D29, X14
    FMOV  V29.D[1], X4
    FMOV  D30, X17
    FMOV  V30.D[1], X25
    FMOV  D31, X25
    FMOV  V31.D[1], X3
    SMULL  V25.2D, V30.2S, V31.2S
    SMULL2 V17.2D, V26.4S, V29.S[0x3]
    SMULL2 V31.4S, V23.8H, V5.H[0x5]
    SMULL2  V1.4S, V24.8H, V24.8H
    SQABS  V18.2S, V28.2S
    SQADD  V23.2D, V27.2D, V27.2D
    SQDMLAL S29, H22, V7.H[0x5]
    SQDMLAL D5, S7, V28.S[0x1]
    SQDMLAL V8.2D, V27.2S, V10.S[0x1]
    SQDMLAL V28.4S, V26.4H, V11.H[0x6]
    SQDMLAL  V14.4S, V11.4H, V16.4H
    SQDMLAL2 V27.2D, V10.4S, V6.S[0x1]
    SQDMLAL2 V21.4S, V3.8H, V15.H[0x4]
    SQDMLAL2  V9.2D, V10.4S, V26.4S
    SQDMLSL S12, H0, V10.H[0x5]
    SQDMLSL D2, S24, V6.S[0x3]
    SQDMLSL V22.2D, V0.2S, V22.S[0x2]
    SQDMLSL V19.4S, V7.4H, V15.H[0x0]
    SQDMLSL  V20.2D, V0.2S, V6.2S
    SQDMLSL2 V30.2D, V16.4S, V3.S[0x2]
    SQDMLSL2 V26.4S, V13.8H, V6.H[0x6]
    SQDMLSL2  V7.2D, V10.4S, V10.4S
    SQDMULH H24, H24, V3.H[0x0]
    SQDMULH S13, S13, V0.S[0x2]
    SQDMULH  V16.4H, V0.4H, V11.H[0x3]
    SQDMULH  V4.2S, V4.2S, V0.S[0x2]
    SQDMULH  V11.8H, V3.8H, V11.8H
    SQDMULL S6, H15, V6.H[0x6]
    SQDMULL D0, S15, V10.S[0x1]
    SQDMULL V3.2D, V10.2S, V15.S[0x2]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x10, LSL #0
    MOVK  X8, #0x800, LSL #16
    MRS  X2, FPSR
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V0.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x38b2, LSL #0
    MOVK  X8, #0x47c0, LSL #16
    MOVK  X8, #0x4ed7, LSL #32
    MOVK  X8, #0x3fc7, LSL #48
    FMOV  X2, D0
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x1c59, LSL #0
    MOVK  X8, #0x1fe4, LSL #16
    MOVK  X8, #0x1c59, LSL #32
    MOVK  X8, #0x1fe4, LSL #48
    FMOV  X2, V1.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x1c59, LSL #0
    MOVK  X8, #0x1fe4, LSL #16
    MOVK  X8, #0x1c59, LSL #32
    MOVK  X8, #0x1fe4, LSL #48
    FMOV  X2, D1
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V2.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, D2
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x38b2, LSL #0
    MOVK  X8, #0x47c0, LSL #16
    MOVK  X8, #0x4ed7, LSL #32
    MOVK  X8, #0x3fc7, LSL #48
    FMOV  X2, V3.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x38b2, LSL #0
    MOVK  X8, #0x47c0, LSL #16
    MOVK  X8, #0x4ed7, LSL #32
    MOVK  X8, #0x3fc7, LSL #48
    FMOV  X2, D3
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V4.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x4ed7, LSL #0
    MOVK  X8, #0x3fc7, LSL #16
    MOVK  X8, #0x4ed7, LSL #32
    MOVK  X8, #0x3fc7, LSL #48
    FMOV  X2, D4
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V5.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xde57, LSL #0
    MOVK  X8, #0xed65, LSL #16
    MOVK  X8, #0xf47c, LSL #32
    MOVK  X8, #0xe56c, LSL #48
    FMOV  X2, D5
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V6.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x38b2, LSL #0
    MOVK  X8, #0x3fc8, LSL #16
    FMOV  X2, D6
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, V7.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, D7
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xde57, LSL #0
    MOVK  X8, #0xed65, LSL #16
    MOVK  X8, #0xf47c, LSL #32
    MOVK  X8, #0xe56c, LSL #48
    FMOV  X2, V8.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xde57, LSL #0
    MOVK  X8, #0xed65, LSL #16
    MOVK  X8, #0xf47c, LSL #32
    MOVK  X8, #0xe56c, LSL #48
    FMOV  X2, D8
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xde57, LSL #0
    MOVK  X8, #0xed65, LSL #16
    MOVK  X8, #0xf47c, LSL #32
    MOVK  X8, #0xe56c, LSL #48
    FMOV  X2, V9.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xde57, LSL #0
    MOVK  X8, #0xed65, LSL #16
    MOVK  X8, #0xf47c, LSL #32
    MOVK  X8, #0xe56c, LSL #48
    FMOV  X2, D9
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V10.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D10
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x3fc8, LSL #0
    MOVK  X8, #0x3fc8, LSL #16
    MOVK  X8, #0x3fc8, LSL #32
    MOVK  X8, #0x3fc8, LSL #48
    FMOV  X2, V11.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x3fc8, LSL #0
    MOVK  X8, #0x3fc8, LSL #16
    MOVK  X8, #0x3fc8, LSL #32
    MOVK  X8, #0x3fc8, LSL #48
    FMOV  X2, D11
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V12.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #16
    FMOV  X2, D12
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V13.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x4ed7, LSL #0
    MOVK  X8, #0x3fc7, LSL #16
    FMOV  X2, D13
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xde57, LSL #0
    MOVK  X8, #0xe56d, LSL #16
    MOVK  X8, #0xde57, LSL #32
    MOVK  X8, #0xe56d, LSL #48
    FMOV  X2, V14.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xde57, LSL #0
    MOVK  X8, #0xe56d, LSL #16
    MOVK  X8, #0xde57, LSL #32
    MOVK  X8, #0xe56d, LSL #48
    FMOV  X2, D14
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V15.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D15
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V16.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x3fc8, LSL #0
    MOVK  X8, #0x3fc8, LSL #16
    MOVK  X8, #0x3fc8, LSL #32
    MOVK  X8, #0x3fc8, LSL #48
    FMOV  X2, D16
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x1c59, LSL #0
    MOVK  X8, #0xa3e0, LSL #16
    MOVK  X8, #0xa76b, LSL #32
    MOVK  X8, #0x1fe3, LSL #48
    FMOV  X2, V17.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x1c59, LSL #0
    MOVK  X8, #0xa3e0, LSL #16
    MOVK  X8, #0xa76b, LSL #32
    MOVK  X8, #0x1fe3, LSL #48
    FMOV  X2, D17
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V18.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x5a5b, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5b, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X2, D18
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #16
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, V19.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #16
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, D19
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, V20.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, D20
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xde57, LSL #0
    MOVK  X8, #0xe56d, LSL #16
    MOVK  X8, #0xde57, LSL #32
    MOVK  X8, #0xe56d, LSL #48
    FMOV  X2, V21.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xde57, LSL #0
    MOVK  X8, #0xe56d, LSL #16
    MOVK  X8, #0xde57, LSL #32
    MOVK  X8, #0xe56d, LSL #48
    FMOV  X2, D21
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, V22.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, D22
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, V23.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, D23
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V24.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x3fc8, LSL #0
    FMOV  X2, D24
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x1c59, LSL #0
    MOVK  X8, #0xa3e0, LSL #16
    MOVK  X8, #0xa76b, LSL #32
    MOVK  X8, #0x1fe3, LSL #48
    FMOV  X2, V25.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x1c59, LSL #0
    MOVK  X8, #0xa3e0, LSL #16
    MOVK  X8, #0xa76b, LSL #32
    MOVK  X8, #0x1fe3, LSL #48
    FMOV  X2, D25
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #16
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, V26.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #16
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, D26
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xde57, LSL #0
    MOVK  X8, #0xed65, LSL #16
    MOVK  X8, #0xf47c, LSL #32
    MOVK  X8, #0xe56c, LSL #48
    FMOV  X2, V27.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xde57, LSL #0
    MOVK  X8, #0xed65, LSL #16
    MOVK  X8, #0xf47c, LSL #32
    MOVK  X8, #0xe56c, LSL #48
    FMOV  X2, D27
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xde57, LSL #0
    MOVK  X8, #0xe56d, LSL #16
    MOVK  X8, #0xde57, LSL #32
    MOVK  X8, #0xe56d, LSL #48
    FMOV  X2, V28.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xde57, LSL #0
    MOVK  X8, #0xe56d, LSL #16
    MOVK  X8, #0xde57, LSL #32
    MOVK  X8, #0xe56d, LSL #48
    FMOV  X2, D28
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V29.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xde57, LSL #0
    MOVK  X8, #0xe56d, LSL #16
    FMOV  X2, D29
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, V30.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, D30
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x1c59, LSL #0
    MOVK  X8, #0x1fe4, LSL #16
    MOVK  X8, #0x1c59, LSL #32
    MOVK  X8, #0x1fe4, LSL #48
    FMOV  X2, V31.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x1c59, LSL #0
    MOVK  X8, #0x1fe4, LSL #16
    MOVK  X8, #0x1c59, LSL #32
    MOVK  X8, #0x1fe4, LSL #48
    FMOV  X2, D31
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
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
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
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
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
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
    FMOV  D0, X26
    FMOV  V0.D[1], X25
    FMOV  D1, X23
    FMOV  V1.D[1], X22
    FMOV  D2, X27
    FMOV  V2.D[1], X24
    FMOV  D3, X7
    FMOV  V3.D[1], X20
    FMOV  D4, X13
    FMOV  V4.D[1], X24
    FMOV  D5, X27
    FMOV  V5.D[1], X10
    FMOV  D6, X12
    FMOV  V6.D[1], X16
    FMOV  D7, X7
    FMOV  V7.D[1], X10
    FMOV  D8, X24
    FMOV  V8.D[1], X22
    FMOV  D9, X16
    FMOV  V9.D[1], X26
    FMOV  D10, X23
    FMOV  V10.D[1], X11
    FMOV  D11, X25
    FMOV  V11.D[1], X22
    FMOV  D12, X7
    FMOV  V12.D[1], X9
    FMOV  D13, X27
    FMOV  V13.D[1], X16
    FMOV  D14, X14
    FMOV  V14.D[1], X4
    FMOV  D15, X10
    FMOV  V15.D[1], X14
    FMOV  D16, X14
    FMOV  V16.D[1], X27
    FMOV  D17, X27
    FMOV  V17.D[1], X15
    FMOV  D18, X23
    FMOV  V18.D[1], X16
    FMOV  D19, X22
    FMOV  V19.D[1], X12
    FMOV  D20, X16
    FMOV  V20.D[1], X13
    FMOV  D21, X13
    FMOV  V21.D[1], X20
    FMOV  D22, X24
    FMOV  V22.D[1], X6
    FMOV  D23, X24
    FMOV  V23.D[1], X20
    FMOV  D24, X24
    FMOV  V24.D[1], X27
    FMOV  D25, X4
    FMOV  V25.D[1], X24
    FMOV  D26, X4
    FMOV  V26.D[1], X26
    FMOV  D27, X9
    FMOV  V27.D[1], X27
    FMOV  D28, X24
    FMOV  V28.D[1], X6
    FMOV  D29, X4
    FMOV  V29.D[1], X5
    FMOV  D30, X16
    FMOV  V30.D[1], X24
    FMOV  D31, X27
    FMOV  V31.D[1], X23
    SQDMULL  V28.4S, V20.4H, V22.4H
    SQDMULL2 V21.2D, V31.4S, V17.S[0x0]
    SQDMULL2 V5.4S, V16.8H, V3.H[0x7]
    SQDMULL2  V10.4S, V29.8H, V30.8H
    SQNEG  V15.4S, V26.4S
    SQRDMULH H27, H24, V0.H[0x6]
    SQRDMULH S9, S25, V25.S[0x0]
    SQRDMULH  V16.4H, V11.4H, V11.H[0x5]
    SQRDMULH  V0.2S, V3.2S, V8.S[0x0]
    SQRDMULH  V11.8H, V23.8H, V11.8H
    SQRSHL  V12.2S, V30.2S, V8.2S
    SQRSHRN V19.8B, V3.8H, #1
    SQRSHRN V4.4H, V8.4S, #13
    SQRSHRN V18.2S, V22.2D, #20
    SQRSHRN2 V22.16B, V22.8H, #3
    SQRSHRN2 V29.8H, V6.4S, #16
    SQRSHRN2 V8.4S, V6.2D, #28
    SQRSHRUN V26.8B, V14.8H, #2
    SQRSHRUN V25.4H, V17.4S, #3
    SQRSHRUN V6.2S, V20.2D, #14
    SQRSHRUN2 V24.16B, V31.8H, #4
    SQRSHRUN2 V17.8H, V30.4S, #3
    SQRSHRUN2 V30.4S, V31.2D, #20
    SQSHL  V13.16B, V31.16B, #0x3
    SQSHL V7.2D, V23.2D, #0x31
    SQSHL  V14.4H, V31.4H, #0xd
    SQSHL  V2.4S, V20.4S, #0x1a
    SQSHL  V1.4H, V31.4H, V31.4H
    SQSHLU  V20.8B, V3.8B, #0x5
    SQSHLU V31.2D, V23.2D, #0x2b
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x10, LSL #0
    MOVK  X8, #0x800, LSL #16
    MRS  X2, FPSR
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V0.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x4ed7, LSL #0
    MOVK  X8, #0x3fc7, LSL #16
    MOVK  X8, #0x4ed7, LSL #32
    MOVK  X8, #0x3fc7, LSL #48
    FMOV  X2, D0
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V1.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X2, D1
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #16
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, V2.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #16
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, D2
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V3.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D3
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V4.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x8000, LSL #0
    MOVK  X8, #0x8000, LSL #16
    MOVK  X8, #0x8000, LSL #32
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, D4
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x38b2, LSL #0
    MOVK  X8, #0x3fc8, LSL #16
    MOVK  X8, #0x38b2, LSL #32
    MOVK  X8, #0x3fc8, LSL #48
    FMOV  X2, V5.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x38b2, LSL #0
    MOVK  X8, #0x3fc8, LSL #16
    MOVK  X8, #0x38b2, LSL #32
    MOVK  X8, #0x3fc8, LSL #48
    FMOV  X2, D5
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V6.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D6
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, V7.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, D7
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #16
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, V8.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D8
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V9.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x4ed7, LSL #0
    MOVK  X8, #0x3fc7, LSL #16
    FMOV  X2, D9
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x38b2, LSL #0
    MOVK  X8, #0x3fc8, LSL #16
    MOVK  X8, #0x38b2, LSL #32
    MOVK  X8, #0x3fc8, LSL #48
    FMOV  X2, V10.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x38b2, LSL #0
    MOVK  X8, #0x3fc8, LSL #16
    MOVK  X8, #0x38b2, LSL #32
    MOVK  X8, #0x3fc8, LSL #48
    FMOV  X2, D10
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x3fc8, LSL #0
    MOVK  X8, #0x3fc8, LSL #16
    MOVK  X8, #0x3fc8, LSL #32
    MOVK  X8, #0x3fc8, LSL #48
    FMOV  X2, V11.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x3fc8, LSL #0
    MOVK  X8, #0x3fc8, LSL #16
    MOVK  X8, #0x3fc8, LSL #32
    MOVK  X8, #0x3fc8, LSL #48
    FMOV  X2, D11
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V12.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D12
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x8080, LSL #0
    MOVK  X8, #0x8080, LSL #16
    MOVK  X8, #0x8080, LSL #32
    MOVK  X8, #0x8080, LSL #48
    FMOV  X2, V13.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x8080, LSL #0
    MOVK  X8, #0x8080, LSL #16
    MOVK  X8, #0x8080, LSL #32
    MOVK  X8, #0x8080, LSL #48
    FMOV  X2, D13
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V14.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x8000, LSL #0
    MOVK  X8, #0x8000, LSL #16
    MOVK  X8, #0x8000, LSL #32
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, D14
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x5a5b, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5b, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X2, V15.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x5a5b, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5b, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X2, D15
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V16.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x3fc8, LSL #0
    MOVK  X8, #0x3fc8, LSL #16
    MOVK  X8, #0x3fc8, LSL #32
    MOVK  X8, #0x3fc8, LSL #48
    FMOV  X2, D16
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V17.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D17
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V18.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #16
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, D18
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V19.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x8080, LSL #0
    MOVK  X8, #0x8080, LSL #16
    MOVK  X8, #0x8080, LSL #32
    MOVK  X8, #0x8080, LSL #48
    FMOV  X2, D19
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V20.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D20
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x38b2, LSL #0
    MOVK  X8, #0x47c0, LSL #16
    MOVK  X8, #0x4ed7, LSL #32
    MOVK  X8, #0x3fc7, LSL #48
    FMOV  X2, V21.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x38b2, LSL #0
    MOVK  X8, #0x47c0, LSL #16
    MOVK  X8, #0x4ed7, LSL #32
    MOVK  X8, #0x3fc7, LSL #48
    FMOV  X2, D21
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x8080, LSL #0
    MOVK  X8, #0x8080, LSL #16
    MOVK  X8, #0x8080, LSL #32
    MOVK  X8, #0x8080, LSL #48
    FMOV  X2, V22.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D22
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V23.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D23
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V24.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D24
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V25.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D25
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V26.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D26
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V27.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x3fc8, LSL #0
    FMOV  X2, D27
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x38b2, LSL #0
    MOVK  X8, #0x3fc8, LSL #16
    MOVK  X8, #0x38b2, LSL #32
    MOVK  X8, #0x3fc8, LSL #48
    FMOV  X2, V28.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x38b2, LSL #0
    MOVK  X8, #0x3fc8, LSL #16
    MOVK  X8, #0x38b2, LSL #32
    MOVK  X8, #0x3fc8, LSL #48
    FMOV  X2, D28
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a6, LSL #0
    MOVK  X8, #0xa5a6, LSL #16
    MOVK  X8, #0xa5a6, LSL #32
    MOVK  X8, #0xa5a6, LSL #48
    FMOV  X2, V29.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D29
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V30.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D30
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V31.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D31
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
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
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
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
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
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
    FMOV  D0, X24
    FMOV  V0.D[1], X25
    FMOV  D1, X20
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X4
    FMOV  D3, X20
    FMOV  V3.D[1], X3
    FMOV  D4, X10
    FMOV  V4.D[1], X16
    FMOV  D5, X23
    FMOV  V5.D[1], X11
    FMOV  D6, X22
    FMOV  V6.D[1], X27
    FMOV  D7, X20
    FMOV  V7.D[1], X24
    FMOV  D8, X7
    FMOV  V8.D[1], X6
    FMOV  D9, X25
    FMOV  V9.D[1], X6
    FMOV  D10, X7
    FMOV  V10.D[1], X4
    FMOV  D11, X20
    FMOV  V11.D[1], X13
    FMOV  D12, X27
    FMOV  V12.D[1], X17
    FMOV  D13, X3
    FMOV  V13.D[1], X23
    FMOV  D14, X7
    FMOV  V14.D[1], X24
    FMOV  D15, X25
    FMOV  V15.D[1], X15
    FMOV  D16, X25
    FMOV  V16.D[1], X15
    FMOV  D17, X5
    FMOV  V17.D[1], X16
    FMOV  D18, X15
    FMOV  V18.D[1], X27
    FMOV  D19, X13
    FMOV  V19.D[1], X25
    FMOV  D20, X20
    FMOV  V20.D[1], X24
    FMOV  D21, X15
    FMOV  V21.D[1], X17
    FMOV  D22, X27
    FMOV  V22.D[1], X15
    FMOV  D23, X7
    FMOV  V23.D[1], X12
    FMOV  D24, X12
    FMOV  V24.D[1], X6
    FMOV  D25, X3
    FMOV  V25.D[1], X4
    FMOV  D26, X20
    FMOV  V26.D[1], X17
    FMOV  D27, X25
    FMOV  V27.D[1], X6
    FMOV  D28, X6
    FMOV  V28.D[1], X24
    FMOV  D29, X16
    FMOV  V29.D[1], X26
    FMOV  D30, X12
    FMOV  V30.D[1], X12
    FMOV  D31, X4
    FMOV  V31.D[1], X20
    SQSHLU  V10.2S, V31.2S, #0x14
    SQSHRN V31.8B, V11.8H, #4
    SQSHRN V22.4H, V28.4S, #1
    SQSHRN V17.2S, V27.2D, #22
    SQSHRN2 V26.16B, V21.8H, #5
    SQSHRN2 V8.8H, V25.4S, #6
    SQSHRN2 V19.4S, V20.2D, #18
    SQSHRUN V29.8B, V27.8H, #1
    SQSHRUN V28.4H, V30.4S, #10
    SQSHRUN V20.2S, V30.2D, #18
    SQSHRUN2 V27.16B, V21.8H, #2
    SQSHRUN2 V9.8H, V13.4S, #9
    SQSHRUN2 V3.4S, V4.2D, #21
    SQSUB  V0.2D, V5.2D, V12.2D
    SQXTN  V6.2S, V2.2D
    SQXTN2  V16.8H, V11.4S
    SQXTUN  V23.2S, V21.2D
    SQXTUN2  V14.4S, V5.2D
    SRHADD  V2.16B, V30.16B, V30.16B
    SRSHL  V18.8H, V24.8H, V12.8H
    SRSHR  V5.16B, V4.16B, #8
    SRSHR V15.2D, V12.2D, #5
    SRSHR  V1.8H, V11.8H, #16
    SRSHR  V11.4S, V11.4S, #32
    SRSRA  V7.16B, V24.16B, #4
    SRSRA V21.2D, V21.2D, #37
    SRSRA  V25.8H, V25.8H, #9
    SRSRA  V13.4S, V12.4S, #1
    SSHL  V12.8B, V30.8B, V4.8B
    SSHLL V30.2D, V30.2S, #0xa
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x10, LSL #0
    MOVK  X8, #0x800, LSL #16
    MRS  X2, FPSR
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V0.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D0
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V1.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D1
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V2.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D2
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V3.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D3
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V4.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D4
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V5.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D5
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V6.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #16
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, D6
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x9f9f, LSL #0
    MOVK  X8, #0x9f9f, LSL #16
    MOVK  X8, #0x9f9f, LSL #32
    MOVK  X8, #0x9f9f, LSL #48
    FMOV  X2, V7.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x9f9f, LSL #0
    MOVK  X8, #0x9f9f, LSL #16
    MOVK  X8, #0x9f9f, LSL #32
    MOVK  X8, #0x9f9f, LSL #48
    FMOV  X2, D7
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x8000, LSL #0
    MOVK  X8, #0x8000, LSL #16
    MOVK  X8, #0x8000, LSL #32
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, V8.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D8
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V9.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D9
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V10.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D10
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V11.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D11
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V12.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X2, D12
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x7878, LSL #0
    MOVK  X8, #0x7878, LSL #16
    MOVK  X8, #0x7878, LSL #32
    MOVK  X8, #0x7878, LSL #48
    FMOV  X2, V13.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x7878, LSL #0
    MOVK  X8, #0x7878, LSL #16
    MOVK  X8, #0x7878, LSL #32
    MOVK  X8, #0x7878, LSL #48
    FMOV  X2, D13
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V14.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D14
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x2d2d, LSL #0
    MOVK  X8, #0x2d2d, LSL #16
    MOVK  X8, #0x2d2d, LSL #32
    MOVK  X8, #0xfd2d, LSL #48
    FMOV  X2, V15.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x2d2d, LSL #0
    MOVK  X8, #0x2d2d, LSL #16
    MOVK  X8, #0x2d2d, LSL #32
    MOVK  X8, #0xfd2d, LSL #48
    FMOV  X2, D15
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x8000, LSL #0
    MOVK  X8, #0x8000, LSL #16
    MOVK  X8, #0x8000, LSL #32
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, V16.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D16
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V17.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #16
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, D17
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V18.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D18
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #16
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, V19.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D19
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V20.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D20
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xd2d2, LSL #0
    MOVK  X8, #0xa2d2, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V21.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xd2d2, LSL #0
    MOVK  X8, #0xa2d2, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D21
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V22.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x8000, LSL #0
    MOVK  X8, #0x8000, LSL #16
    MOVK  X8, #0x8000, LSL #32
    MOVK  X8, #0x8000, LSL #48
    FMOV  X2, D22
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V23.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D23
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V24.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D24
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa578, LSL #0
    MOVK  X8, #0xa578, LSL #16
    MOVK  X8, #0xa578, LSL #32
    MOVK  X8, #0xa578, LSL #48
    FMOV  X2, V25.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa578, LSL #0
    MOVK  X8, #0xa578, LSL #16
    MOVK  X8, #0xa578, LSL #32
    MOVK  X8, #0xa578, LSL #48
    FMOV  X2, D25
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x8080, LSL #0
    MOVK  X8, #0x8080, LSL #16
    MOVK  X8, #0x8080, LSL #32
    MOVK  X8, #0x8080, LSL #48
    FMOV  X2, V26.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D26
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V27.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D27
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V28.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D28
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V29.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D29
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x9400, LSL #0
    MOVK  X8, #0x9696, LSL #16
    MOVK  X8, #0xfe96, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X2, V30.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x9400, LSL #0
    MOVK  X8, #0x9696, LSL #16
    MOVK  X8, #0xfe96, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X2, D30
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V31.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x8080, LSL #0
    MOVK  X8, #0x8080, LSL #16
    MOVK  X8, #0x8080, LSL #32
    MOVK  X8, #0x8080, LSL #48
    FMOV  X2, D31
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
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
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
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
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
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
    FMOV  D0, X24
    FMOV  V0.D[1], X25
    FMOV  D1, X26
    FMOV  V1.D[1], X22
    FMOV  D2, X27
    FMOV  V2.D[1], X5
    FMOV  D3, X23
    FMOV  V3.D[1], X25
    FMOV  D4, X6
    FMOV  V4.D[1], X3
    FMOV  D5, X12
    FMOV  V5.D[1], X11
    FMOV  D6, X16
    FMOV  V6.D[1], X10
    FMOV  D7, X13
    FMOV  V7.D[1], X24
    FMOV  D8, X17
    FMOV  V8.D[1], X27
    FMOV  D9, X11
    FMOV  V9.D[1], X14
    FMOV  D10, X22
    FMOV  V10.D[1], X27
    FMOV  D11, X14
    FMOV  V11.D[1], X5
    FMOV  D12, X3
    FMOV  V12.D[1], X23
    FMOV  D13, X11
    FMOV  V13.D[1], X16
    FMOV  D14, X5
    FMOV  V14.D[1], X4
    FMOV  D15, X24
    FMOV  V15.D[1], X20
    FMOV  D16, X27
    FMOV  V16.D[1], X20
    FMOV  D17, X17
    FMOV  V17.D[1], X11
    FMOV  D18, X26
    FMOV  V18.D[1], X25
    FMOV  D19, X17
    FMOV  V19.D[1], X17
    FMOV  D20, X25
    FMOV  V20.D[1], X26
    FMOV  D21, X20
    FMOV  V21.D[1], X25
    FMOV  D22, X25
    FMOV  V22.D[1], X17
    FMOV  D23, X22
    FMOV  V23.D[1], X7
    FMOV  D24, X23
    FMOV  V24.D[1], X20
    FMOV  D25, X13
    FMOV  V25.D[1], X10
    FMOV  D26, X16
    FMOV  V26.D[1], X7
    FMOV  D27, X12
    FMOV  V27.D[1], X20
    FMOV  D28, X5
    FMOV  V28.D[1], X11
    FMOV  D29, X3
    FMOV  V29.D[1], X13
    FMOV  D30, X11
    FMOV  V30.D[1], X3
    FMOV  D31, X11
    FMOV  V31.D[1], X10
    SSHLL V2.4S, V31.4H, #0x6
    SSHLL2 V4.2D, V27.4S, #0x1e
    SSHLL2 V16.8H, V21.16B, #0x4
    SSHLL2 V19.4S, V1.8H, #0x2
    SSHR  V24.16B, V25.16B, #3
    SSHR V9.2D, V28.2D, #34
    SSHR  V17.4H, V30.4H, #1
    SSHR  V28.2S, V5.2S, #24
    SSRA  V6.16B, V29.16B, #2
    SSRA V8.2D, V26.2D, #14
    SSRA  V0.8H, V10.8H, #4
    SSRA  V27.2S, V30.2S, #11
    SSUBL  V23.2D, V23.2S, V15.2S
    SSUBL2  V31.4S, V7.8H, V14.8H
    SSUBW  V11.8H, V29.8H, V15.8B
    SSUBW2  V10.2D, V13.2D, V15.4S
    SUQADD  V3.2D, V18.2D
    SXTL V13.2D, V1.2S
    SXTL V30.8H, V21.8B
    SXTL V22.4S, V20.4H
    SXTL2 V7.2D, V18.4S
    SXTL2 V12.8H, V20.16B
    SXTL2 V20.4S, V29.8H
    SCVTF V15.2D, V14.2D, #56
    SCVTF  V26.2S, V26.2S, #30
    SCVTF  V5.4S, V25.4S
    UCVTF V1.2D, V25.2D, #12
    UCVTF  V21.2S, V21.2S, #19
    UCVTF  V14.4S, V14.4S
    SCVTF  V25.4H, V18.4H, #1
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x10, LSL #0
    MOVK  X8, #0x800, LSL #16
    MRS  X2, FPSR
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x9fff, LSL #0
    MOVK  X8, #0x9fff, LSL #16
    MOVK  X8, #0x9fff, LSL #32
    MOVK  X8, #0x9fff, LSL #48
    FMOV  X2, V0.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x9fff, LSL #0
    MOVK  X8, #0x9fff, LSL #16
    MOVK  X8, #0x9fff, LSL #32
    MOVK  X8, #0x9fff, LSL #48
    FMOV  X2, D0
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xb4b5, LSL #0
    MOVK  X8, #0xb4b4, LSL #16
    MOVK  X8, #0xb4b4, LSL #32
    MOVK  X8, #0x4324, LSL #48
    FMOV  X2, V1.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xb4b5, LSL #0
    MOVK  X8, #0xb4b4, LSL #16
    MOVK  X8, #0xb4b4, LSL #32
    MOVK  X8, #0x4324, LSL #48
    FMOV  X2, D1
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x6940, LSL #0
    MOVK  X8, #0xffe9, LSL #16
    MOVK  X8, #0x6940, LSL #32
    MOVK  X8, #0xffe9, LSL #48
    FMOV  X2, V2.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x6940, LSL #0
    MOVK  X8, #0xffe9, LSL #16
    MOVK  X8, #0x6940, LSL #32
    MOVK  X8, #0xffe9, LSL #48
    FMOV  X2, D2
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x4b4a, LSL #0
    MOVK  X8, #0x4b4b, LSL #16
    MOVK  X8, #0x4b4b, LSL #32
    MOVK  X8, #0x4b4b, LSL #48
    FMOV  X2, V3.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x4b4a, LSL #0
    MOVK  X8, #0x4b4b, LSL #16
    MOVK  X8, #0x4b4b, LSL #32
    MOVK  X8, #0x4b4b, LSL #48
    FMOV  X2, D3
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x4000, LSL #16
    MOVK  X8, #0x6969, LSL #32
    MOVK  X8, #0xe969, LSL #48
    FMOV  X2, V4.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x4000, LSL #16
    MOVK  X8, #0x6969, LSL #32
    MOVK  X8, #0xe969, LSL #48
    FMOV  X2, D4
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xb4b5, LSL #0
    MOVK  X8, #0xceb4, LSL #16
    MOVK  X8, #0xb4b5, LSL #32
    MOVK  X8, #0xceb4, LSL #48
    FMOV  X2, V5.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xb4b5, LSL #0
    MOVK  X8, #0xceb4, LSL #16
    MOVK  X8, #0xb4b5, LSL #32
    MOVK  X8, #0xceb4, LSL #48
    FMOV  X2, D5
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x8e8e, LSL #0
    MOVK  X8, #0x8e8e, LSL #16
    MOVK  X8, #0x8e8e, LSL #32
    MOVK  X8, #0x8e8e, LSL #48
    FMOV  X2, V6.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x8e8e, LSL #0
    MOVK  X8, #0x8e8e, LSL #16
    MOVK  X8, #0x8e8e, LSL #32
    MOVK  X8, #0x8e8e, LSL #48
    FMOV  X2, D6
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X2, V7.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X2, D7
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x3c3b, LSL #0
    MOVK  X8, #0x3c3c, LSL #16
    MOVK  X8, #0x3c3c, LSL #32
    MOVK  X8, #0xa5a4, LSL #48
    FMOV  X2, V8.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x3c3b, LSL #0
    MOVK  X8, #0x3c3c, LSL #16
    MOVK  X8, #0x3c3c, LSL #32
    MOVK  X8, #0xa5a4, LSL #48
    FMOV  X2, D8
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x6969, LSL #0
    MOVK  X8, #0xe969, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X2, V9.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x6969, LSL #0
    MOVK  X8, #0xe969, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X2, D9
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xa5a6, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V10.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xa5a6, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D10
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa600, LSL #0
    MOVK  X8, #0xa600, LSL #16
    MOVK  X8, #0xa600, LSL #32
    MOVK  X8, #0xa600, LSL #48
    FMOV  X2, V11.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa600, LSL #0
    MOVK  X8, #0xa600, LSL #16
    MOVK  X8, #0xa600, LSL #32
    MOVK  X8, #0xa600, LSL #48
    FMOV  X2, D11
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xffa5, LSL #0
    MOVK  X8, #0xffa5, LSL #16
    MOVK  X8, #0xffa5, LSL #32
    MOVK  X8, #0xffa5, LSL #48
    FMOV  X2, V12.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xffa5, LSL #0
    MOVK  X8, #0xffa5, LSL #16
    MOVK  X8, #0xffa5, LSL #32
    MOVK  X8, #0xffa5, LSL #48
    FMOV  X2, D12
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X2, V13.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X2, D13
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a6, LSL #0
    MOVK  X8, #0x4f25, LSL #16
    MOVK  X8, #0xa5a6, LSL #32
    MOVK  X8, #0x4f25, LSL #48
    FMOV  X2, V14.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a6, LSL #0
    MOVK  X8, #0x4f25, LSL #16
    MOVK  X8, #0xa5a6, LSL #32
    MOVK  X8, #0x4f25, LSL #48
    FMOV  X2, D14
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x9697, LSL #0
    MOVK  X8, #0x9696, LSL #16
    MOVK  X8, #0x9696, LSL #32
    MOVK  X8, #0xc056, LSL #48
    FMOV  X2, V15.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x9697, LSL #0
    MOVK  X8, #0x9696, LSL #16
    MOVK  X8, #0x9696, LSL #32
    MOVK  X8, #0xc056, LSL #48
    FMOV  X2, D15
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xfa50, LSL #0
    MOVK  X8, #0xfa50, LSL #16
    MOVK  X8, #0xfa50, LSL #32
    MOVK  X8, #0xfa50, LSL #48
    FMOV  X2, V16.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xfa50, LSL #0
    MOVK  X8, #0xfa50, LSL #16
    MOVK  X8, #0xfa50, LSL #32
    MOVK  X8, #0xfa50, LSL #48
    FMOV  X2, D16
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V17.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xd2d2, LSL #0
    MOVK  X8, #0xd2d2, LSL #16
    MOVK  X8, #0xd2d2, LSL #32
    MOVK  X8, #0xd2d2, LSL #48
    FMOV  X2, D17
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V18.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D18
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x9694, LSL #0
    MOVK  X8, #0xfffe, LSL #16
    MOVK  X8, #0x9694, LSL #32
    MOVK  X8, #0xfffe, LSL #48
    FMOV  X2, V19.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x9694, LSL #0
    MOVK  X8, #0xfffe, LSL #16
    MOVK  X8, #0x9694, LSL #32
    MOVK  X8, #0xfffe, LSL #48
    FMOV  X2, D19
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X2, V20.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X2, D20
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V21.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a6, LSL #0
    MOVK  X8, #0x45a5, LSL #16
    MOVK  X8, #0xa5a6, LSL #32
    MOVK  X8, #0x45a5, LSL #48
    FMOV  X2, D21
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X2, V22.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X2, D22
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V23.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D23
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xf4f4, LSL #0
    MOVK  X8, #0xf4f4, LSL #16
    MOVK  X8, #0xf4f4, LSL #32
    MOVK  X8, #0xf4f4, LSL #48
    FMOV  X2, V24.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xf4f4, LSL #0
    MOVK  X8, #0xf4f4, LSL #16
    MOVK  X8, #0xf4f4, LSL #32
    MOVK  X8, #0xf4f4, LSL #48
    FMOV  X2, D24
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V25.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xf1a6, LSL #0
    MOVK  X8, #0xf1a6, LSL #16
    MOVK  X8, #0xf1a6, LSL #32
    MOVK  X8, #0xf1a6, LSL #48
    FMOV  X2, D25
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V26.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xb4b5, LSL #0
    MOVK  X8, #0xbfb4, LSL #16
    MOVK  X8, #0xb4b5, LSL #32
    MOVK  X8, #0xbfb4, LSL #48
    FMOV  X2, D26
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V27.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x5a59, LSL #0
    MOVK  X8, #0xa59a, LSL #16
    MOVK  X8, #0x5a59, LSL #32
    MOVK  X8, #0xa59a, LSL #48
    FMOV  X2, D27
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V28.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xffa5, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffa5, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X2, D28
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V29.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D29
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xffa5, LSL #0
    MOVK  X8, #0xffa5, LSL #16
    MOVK  X8, #0xffa5, LSL #32
    MOVK  X8, #0xffa5, LSL #48
    FMOV  X2, V30.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xffa5, LSL #0
    MOVK  X8, #0xffa5, LSL #16
    MOVK  X8, #0xffa5, LSL #32
    MOVK  X8, #0xffa5, LSL #48
    FMOV  X2, D30
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V31.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D31
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
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
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
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
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
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
    FMOV  D0, X24
    FMOV  V0.D[1], X27
    FMOV  D1, X26
    FMOV  V1.D[1], X23
    FMOV  D2, X25
    FMOV  V2.D[1], X26
    FMOV  D3, X22
    FMOV  V3.D[1], X17
    FMOV  D4, X15
    FMOV  V4.D[1], X13
    FMOV  D5, X17
    FMOV  V5.D[1], X24
    FMOV  D6, X16
    FMOV  V6.D[1], X27
    FMOV  D7, X4
    FMOV  V7.D[1], X7
    FMOV  D8, X6
    FMOV  V8.D[1], X15
    FMOV  D9, X27
    FMOV  V9.D[1], X27
    FMOV  D10, X11
    FMOV  V10.D[1], X26
    FMOV  D11, X16
    FMOV  V11.D[1], X20
    FMOV  D12, X7
    FMOV  V12.D[1], X7
    FMOV  D13, X22
    FMOV  V13.D[1], X10
    FMOV  D14, X5
    FMOV  V14.D[1], X11
    FMOV  D15, X10
    FMOV  V15.D[1], X10
    FMOV  D16, X10
    FMOV  V16.D[1], X12
    FMOV  D17, X10
    FMOV  V17.D[1], X13
    FMOV  D18, X24
    FMOV  V18.D[1], X4
    FMOV  D19, X27
    FMOV  V19.D[1], X16
    FMOV  D20, X27
    FMOV  V20.D[1], X11
    FMOV  D21, X13
    FMOV  V21.D[1], X27
    FMOV  D22, X27
    FMOV  V22.D[1], X5
    FMOV  D23, X6
    FMOV  V23.D[1], X3
    FMOV  D24, X3
    FMOV  V24.D[1], X23
    FMOV  D25, X12
    FMOV  V25.D[1], X15
    FMOV  D26, X20
    FMOV  V26.D[1], X24
    FMOV  D27, X26
    FMOV  V27.D[1], X23
    FMOV  D28, X4
    FMOV  V28.D[1], X26
    FMOV  D29, X14
    FMOV  V29.D[1], X26
    FMOV  D30, X16
    FMOV  V30.D[1], X25
    FMOV  D31, X10
    FMOV  V31.D[1], X22
    UCVTF  V12.4H, V18.4H, #6
    UCVTF  V10.8H, V25.8H
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x10, LSL #0
    MOVK  X8, #0x800, LSL #16
    MRS  X2, FPSR
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V0.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D0
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V1.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D1
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V2.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D2
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V3.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D3
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V4.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D4
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V5.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D5
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V6.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D6
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V7.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D7
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V8.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D8
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V9.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D9
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x792d, LSL #0
    MOVK  X8, #0x792d, LSL #16
    MOVK  X8, #0x792d, LSL #32
    MOVK  X8, #0x792d, LSL #48
    FMOV  X2, V10.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x792d, LSL #0
    MOVK  X8, #0x792d, LSL #16
    MOVK  X8, #0x792d, LSL #32
    MOVK  X8, #0x792d, LSL #48
    FMOV  X2, D10
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V11.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D11
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V12.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0x612d, LSL #0
    MOVK  X8, #0x612d, LSL #16
    MOVK  X8, #0x612d, LSL #32
    MOVK  X8, #0x612d, LSL #48
    FMOV  X2, D12
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V13.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D13
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V14.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D14
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V15.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D15
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V16.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D16
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V17.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D17
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V18.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D18
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V19.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D19
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V20.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D20
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V21.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D21
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V22.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D22
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V23.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D23
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V24.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D24
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V25.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D25
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V26.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D26
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V27.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D27
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V28.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D28
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V29.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D29
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V30.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D30
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, V31.D[1]
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X2, D31
    SUB  X29, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, DataReverseAdvsimdVectorP03_TestFail

DataReverseAdvsimdVectorP03_TestEnd:
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
    LDP  X4, X2, [SP], #16
    MSR  NZCV, X4
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
DataReverseAdvsimdVectorP03_TestFail:
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
    LDP  X4, X2, [SP], #16
    MSR  NZCV, X4
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
