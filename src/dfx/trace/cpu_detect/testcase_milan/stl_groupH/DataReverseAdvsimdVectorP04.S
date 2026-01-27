.global DataReverseAdvsimdVectorP04

.text
.p2align 4

DataReverseAdvsimdVectorP04:

DataReverseAdvsimdVectorP04_TestBegin:
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
    MOVZ  X2, #0xf9d1, LSL #0
    MOVK  X2, #0xe36b, LSL #16
    MOVK  X2, #0x7c56, LSL #32
    MOVK  X2, #0x4fe8, LSL #48
    MOVZ  X5, #0x1ef3, LSL #0
    MOVK  X5, #0x102c, LSL #16
    MOVK  X5, #0xd181, LSL #32
    MOVK  X5, #0xde88, LSL #48
    MOVZ  X6, #0x9e0, LSL #0
    MOVK  X6, #0x5296, LSL #16
    MOVK  X6, #0xa84d, LSL #32
    MOVK  X6, #0xe226, LSL #48
    MOVZ  X7, #0x2032, LSL #0
    MOVK  X7, #0xb696, LSL #16
    MOVK  X7, #0x8df8, LSL #32
    MOVK  X7, #0xdd7f, LSL #48
    MOVZ  X8, #0x8c42, LSL #0
    MOVK  X8, #0xe13f, LSL #16
    MOVK  X8, #0xbc5c, LSL #32
    MOVK  X8, #0xf067, LSL #48
    MOVZ  X9, #0xc77d, LSL #0
    MOVK  X9, #0x5397, LSL #16
    MOVK  X9, #0xd8c2, LSL #32
    MOVK  X9, #0x8b51, LSL #48
    MOVZ  X10, #0xc4c7, LSL #0
    MOVK  X10, #0x6339, LSL #16
    MOVK  X10, #0x2512, LSL #32
    MOVK  X10, #0xd945, LSL #48
    MOVZ  X11, #0xbf48, LSL #0
    MOVK  X11, #0xae40, LSL #16
    MOVK  X11, #0x73ef, LSL #32
    MOVK  X11, #0x9a21, LSL #48
    MOVZ  X12, #0x6e48, LSL #0
    MOVK  X12, #0x814d, LSL #16
    MOVK  X12, #0x7680, LSL #32
    MOVK  X12, #0x3848, LSL #48
    MOVZ  X13, #0x604e, LSL #0
    MOVK  X13, #0xda2a, LSL #16
    MOVK  X13, #0x20a0, LSL #32
    MOVK  X13, #0x4693, LSL #48
    MOVZ  X14, #0x8d9, LSL #0
    MOVK  X14, #0xd58f, LSL #16
    MOVK  X14, #0xdc04, LSL #32
    MOVK  X14, #0x754f, LSL #48
    MOVZ  X15, #0x1a02, LSL #0
    MOVK  X15, #0xc7b, LSL #16
    MOVK  X15, #0x8963, LSL #32
    MOVK  X15, #0x8d92, LSL #48
    MOVZ  X16, #0xecef, LSL #0
    MOVK  X16, #0xe4a9, LSL #16
    MOVK  X16, #0xbff, LSL #32
    MOVK  X16, #0xfa98, LSL #48
    MOVZ  X17, #0x88cb, LSL #0
    MOVK  X17, #0xcda, LSL #16
    MOVK  X17, #0xaa58, LSL #32
    MOVK  X17, #0x8732, LSL #48
    MOVZ  X18, #0x1d6d, LSL #0
    MOVK  X18, #0x1435, LSL #16
    MOVK  X18, #0xaa67, LSL #32
    MOVK  X18, #0x74ed, LSL #48
    MOVZ  X19, #0x16a0, LSL #0
    MOVK  X19, #0xfc55, LSL #16
    MOVK  X19, #0x331e, LSL #32
    MOVK  X19, #0x4726, LSL #48
    MOVZ  X20, #0x2c12, LSL #0
    MOVK  X20, #0x8dbf, LSL #16
    MOVK  X20, #0x825c, LSL #32
    MOVK  X20, #0xea0d, LSL #48
    MOVZ  X21, #0xc484, LSL #0
    MOVK  X21, #0x7b4f, LSL #16
    MOVK  X21, #0x4f89, LSL #32
    MOVK  X21, #0x2065, LSL #48
    MOVZ  X23, #0x1ddb, LSL #0
    MOVK  X23, #0x8eb4, LSL #16
    MOVK  X23, #0x29a4, LSL #32
    MOVK  X23, #0x687f, LSL #48
    MOVZ  X24, #0x881f, LSL #0
    MOVK  X24, #0x228f, LSL #16
    MOVK  X24, #0xcea4, LSL #32
    MOVK  X24, #0x5485, LSL #48
    MOVZ  X25, #0x2a4f, LSL #0
    MOVK  X25, #0x63be, LSL #16
    MOVK  X25, #0x1f49, LSL #32
    MOVK  X25, #0x8236, LSL #48
    MOVZ  X26, #0xf607, LSL #0
    MOVK  X26, #0xed9, LSL #16
    MOVK  X26, #0xc4f2, LSL #32
    MOVK  X26, #0xdb52, LSL #48
    MOVZ  X28, #0xee6a, LSL #0
    MOVK  X28, #0x74bb, LSL #16
    MOVK  X28, #0x7720, LSL #32
    MOVK  X28, #0xbb43, LSL #48
    MOVZ  X29, #0xab2, LSL #0
    MOVK  X29, #0xcda6, LSL #16
    MOVK  X29, #0xf597, LSL #32
    MOVK  X29, #0x2553, LSL #48
    MOVZ  X21, #0x7a1b, LSL #0
    MOVK  X21, #0xd1e, LSL #16
    MOVK  X21, #0x9d4, LSL #32
    MOVK  X21, #0x7b16, LSL #48
    MSR  FPCR, X21
    MOVZ  X21, #0x266f, LSL #0
    MOVK  X21, #0x452f, LSL #16
    MOVK  X21, #0x9ca4, LSL #32
    MOVK  X21, #0xcd9f, LSL #48
    MSR  FPSR, X21
    MRS  X7, FPSR
    MOVZ  X9, #0xff60, LSL #0
    MOVK  X9, #0x7ff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    AND  X7, X7, X9
    MOVZ  X9, #0x0, LSL #0
    ORR  X7, X7, X9
    MSR  FPSR, X7
    ISB  SY
    ANDS  W9, W20, W26, ROR #25
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X25
    FMOV  D1, X24
    FMOV  V1.D[1], X23
    FMOV  D2, X26
    FMOV  V2.D[1], X29
    FMOV  D3, X6
    FMOV  V3.D[1], X24
    FMOV  D4, X12
    FMOV  V4.D[1], X24
    FMOV  D5, X24
    FMOV  V5.D[1], X29
    FMOV  D6, X6
    FMOV  V6.D[1], X6
    FMOV  D7, X28
    FMOV  V7.D[1], X15
    FMOV  D8, X9
    FMOV  V8.D[1], X18
    FMOV  D9, X9
    FMOV  V9.D[1], X15
    FMOV  D10, X7
    FMOV  V10.D[1], X10
    FMOV  D11, X21
    FMOV  V11.D[1], X6
    FMOV  D12, X2
    FMOV  V12.D[1], X17
    FMOV  D13, X5
    FMOV  V13.D[1], X12
    FMOV  D14, X24
    FMOV  V14.D[1], X5
    FMOV  D15, X9
    FMOV  V15.D[1], X28
    FMOV  D16, X26
    FMOV  V16.D[1], X18
    FMOV  D17, X14
    FMOV  V17.D[1], X10
    FMOV  D18, X9
    FMOV  V18.D[1], X20
    FMOV  D19, X15
    FMOV  V19.D[1], X6
    FMOV  D20, X15
    FMOV  V20.D[1], X25
    FMOV  D21, X23
    FMOV  V21.D[1], X28
    FMOV  D22, X5
    FMOV  V22.D[1], X7
    FMOV  D23, X16
    FMOV  V23.D[1], X10
    FMOV  D24, X6
    FMOV  V24.D[1], X16
    FMOV  D25, X25
    FMOV  V25.D[1], X11
    FMOV  D26, X11
    FMOV  V26.D[1], X10
    FMOV  D27, X6
    FMOV  V27.D[1], X11
    FMOV  D28, X26
    FMOV  V28.D[1], X10
    FMOV  D29, X8
    FMOV  V29.D[1], X7
    FMOV  D30, X21
    FMOV  V30.D[1], X28
    FMOV  D31, X7
    FMOV  V31.D[1], X16
    UABA  V9.16B, V23.16B, V22.16B
    UABAL  V0.8H, V31.8B, V29.8B
    UABAL2  V31.8H, V18.16B, V18.16B
    UABD  V2.2S, V25.2S, V27.2S
    UABDL  V25.2D, V20.2S, V28.2S
    UABDL2  V6.2D, V26.4S, V26.4S
    UADALP  V28.4S, V30.8H
    UADDL  V19.2D, V14.2S, V19.2S
    UADDL2  V5.4S, V18.8H, V20.8H
    UADDLP  V29.1D, V11.2S
    UADDLV  H27, V20.16B
    UADDLV  S12, V30.4H
    UADDLV  D10, V8.4S
    UADDW  V22.4S, V21.4S, V24.4H
    UADDW2  V21.4S, V26.4S, V15.8H
    UHADD  V18.4H, V24.4H, V30.4H
    UHSUB  V15.4H, V23.4H, V13.4H
    UMLAL V4.2D, V20.2S, V17.S[0x2]
    UMLAL V17.4S, V8.4H, V14.H[0x3]
    UMLAL  V13.4S, V8.4H, V7.4H
    UMLAL2 V1.2D, V24.4S, V20.S[0x1]
    UMLAL2 V3.4S, V11.8H, V14.H[0x6]
    UMLAL2  V23.8H, V24.16B, V16.16B
    UMLSL V7.2D, V7.2S, V30.S[0x1]
    UMLSL V8.4S, V8.4H, V14.H[0x4]
    UMLSL  V30.8H, V20.8B, V11.8B
    UMLSL2 V24.2D, V20.4S, V26.S[0x1]
    UMLSL2 V11.4S, V20.8H, V14.H[0x5]
    UMLSL2  V14.8H, V20.16B, V26.16B
    UMOV W14, V16.B[0xc]
    UMOV W11, V26.H[0x4]
    UMOV W25, V16.S[0x1]
    UMOV X28, V26.D[0x1]
    UMULL V26.2D, V20.2S, V26.S[0x0]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    SUB  X15, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a, LSL #0
    SUB  X15, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    SUB  X15, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    MRS  X15, FPSR
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V0.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D0
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xc1fe, LSL #0
    MOVK  X8, #0x4985, LSL #16
    MOVK  X8, #0x1c5, LSL #32
    MOVK  X8, #0x7a3e, LSL #48
    FMOV  X15, V1.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xc1fe, LSL #0
    MOVK  X8, #0x4985, LSL #16
    MOVK  X8, #0x1c5, LSL #32
    MOVK  X8, #0x7a3e, LSL #48
    FMOV  X15, D1
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V2.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, D2
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xc1fe, LSL #0
    MOVK  X8, #0x7a3d, LSL #16
    MOVK  X8, #0xc1fe, LSL #32
    MOVK  X8, #0x7a3d, LSL #48
    FMOV  X15, V3.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xc1fe, LSL #0
    MOVK  X8, #0x7a3d, LSL #16
    MOVK  X8, #0xc1fe, LSL #32
    MOVK  X8, #0x7a3d, LSL #48
    FMOV  X15, D3
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xc1fe, LSL #0
    MOVK  X8, #0x4985, LSL #16
    MOVK  X8, #0x1c5, LSL #32
    MOVK  X8, #0x7a3e, LSL #48
    FMOV  X15, V4.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xc1fe, LSL #0
    MOVK  X8, #0x4985, LSL #16
    MOVK  X8, #0x1c5, LSL #32
    MOVK  X8, #0x7a3e, LSL #48
    FMOV  X15, D4
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xb4b4, LSL #0
    MOVK  X8, #0xb4b4, LSL #32
    FMOV  X15, V5.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xb4b4, LSL #0
    MOVK  X8, #0xb4b4, LSL #32
    FMOV  X15, D5
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V6.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, D6
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xf2b6, LSL #0
    MOVK  X8, #0x6b2e, LSL #16
    MOVK  X8, #0xb2ef, LSL #32
    MOVK  X8, #0x3a76, LSL #48
    FMOV  X15, V7.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xf2b6, LSL #0
    MOVK  X8, #0x6b2e, LSL #16
    MOVK  X8, #0xb2ef, LSL #32
    MOVK  X8, #0x3a76, LSL #48
    FMOV  X15, D7
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xf2b6, LSL #0
    MOVK  X8, #0x3a76, LSL #16
    MOVK  X8, #0xf2b6, LSL #32
    MOVK  X8, #0x3a76, LSL #48
    FMOV  X15, V8.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xf2b6, LSL #0
    MOVK  X8, #0x3a76, LSL #16
    MOVK  X8, #0xf2b6, LSL #32
    MOVK  X8, #0x3a76, LSL #48
    FMOV  X15, D8
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V9.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D9
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V10.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x6968, LSL #0
    MOVK  X8, #0x6969, LSL #16
    MOVK  X8, #0x1, LSL #32
    FMOV  X15, D10
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xf2b6, LSL #0
    MOVK  X8, #0x3a76, LSL #16
    MOVK  X8, #0xf2b6, LSL #32
    MOVK  X8, #0x3a76, LSL #48
    FMOV  X15, V11.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xf2b6, LSL #0
    MOVK  X8, #0x3a76, LSL #16
    MOVK  X8, #0xf2b6, LSL #32
    MOVK  X8, #0x3a76, LSL #48
    FMOV  X15, D11
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V12.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x6968, LSL #0
    MOVK  X8, #0x1, LSL #16
    FMOV  X15, D12
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xc1fe, LSL #0
    MOVK  X8, #0x7a3d, LSL #16
    MOVK  X8, #0xc1fe, LSL #32
    MOVK  X8, #0x7a3d, LSL #48
    FMOV  X15, V13.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xc1fe, LSL #0
    MOVK  X8, #0x7a3d, LSL #16
    MOVK  X8, #0xc1fe, LSL #32
    MOVK  X8, #0x7a3d, LSL #48
    FMOV  X15, D13
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x3ab6, LSL #0
    MOVK  X8, #0x3ab6, LSL #16
    MOVK  X8, #0x3ab6, LSL #32
    MOVK  X8, #0x3ab6, LSL #48
    FMOV  X15, V14.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x3ab6, LSL #0
    MOVK  X8, #0x3ab6, LSL #16
    MOVK  X8, #0x3ab6, LSL #32
    MOVK  X8, #0x3ab6, LSL #48
    FMOV  X15, D14
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V15.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, D15
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V16.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D16
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xc1fe, LSL #0
    MOVK  X8, #0x7a3d, LSL #16
    MOVK  X8, #0xc1fe, LSL #32
    MOVK  X8, #0x7a3d, LSL #48
    FMOV  X15, V17.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xc1fe, LSL #0
    MOVK  X8, #0x7a3d, LSL #16
    MOVK  X8, #0xc1fe, LSL #32
    MOVK  X8, #0x7a3d, LSL #48
    FMOV  X15, D17
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V18.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D18
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xb4b4, LSL #0
    MOVK  X8, #0xb4b4, LSL #16
    FMOV  X15, V19.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xb4b4, LSL #0
    MOVK  X8, #0xb4b4, LSL #16
    FMOV  X15, D19
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V20.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D20
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xb4b4, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0xb4b4, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V21.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xb4b4, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0xb4b4, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D21
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xb4b4, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0xb4b4, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V22.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xb4b4, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0xb4b4, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D22
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x79fe, LSL #0
    MOVK  X8, #0x79fe, LSL #16
    MOVK  X8, #0x79fe, LSL #32
    MOVK  X8, #0x79fe, LSL #48
    FMOV  X15, V23.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x79fe, LSL #0
    MOVK  X8, #0x79fe, LSL #16
    MOVK  X8, #0x79fe, LSL #32
    MOVK  X8, #0x79fe, LSL #48
    FMOV  X15, D23
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xf2b6, LSL #0
    MOVK  X8, #0x6b2e, LSL #16
    MOVK  X8, #0xb2ef, LSL #32
    MOVK  X8, #0x3a76, LSL #48
    FMOV  X15, V24.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xf2b6, LSL #0
    MOVK  X8, #0x6b2e, LSL #16
    MOVK  X8, #0xb2ef, LSL #32
    MOVK  X8, #0x3a76, LSL #48
    FMOV  X15, D24
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V25.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, D25
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x67a4, LSL #0
    MOVK  X8, #0xef2b, LSL #16
    MOVK  X8, #0xa76a, LSL #32
    MOVK  X8, #0x1fe3, LSL #48
    FMOV  X15, V26.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x67a4, LSL #0
    MOVK  X8, #0xef2b, LSL #16
    MOVK  X8, #0xa76a, LSL #32
    MOVK  X8, #0x1fe3, LSL #48
    FMOV  X15, D26
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V27.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a0, LSL #0
    FMOV  X15, D27
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xf0e, LSL #0
    MOVK  X8, #0x5a5b, LSL #16
    MOVK  X8, #0xf0e, LSL #32
    MOVK  X8, #0x5a5b, LSL #48
    FMOV  X15, V28.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xf0e, LSL #0
    MOVK  X8, #0x5a5b, LSL #16
    MOVK  X8, #0xf0e, LSL #32
    MOVK  X8, #0x5a5b, LSL #48
    FMOV  X15, D28
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V29.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xb4b4, LSL #0
    MOVK  X8, #0xb4b4, LSL #16
    FMOV  X15, D29
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x3ab6, LSL #0
    MOVK  X8, #0x3ab6, LSL #16
    MOVK  X8, #0x3ab6, LSL #32
    MOVK  X8, #0x3ab6, LSL #48
    FMOV  X15, V30.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x3ab6, LSL #0
    MOVK  X8, #0x3ab6, LSL #16
    MOVK  X8, #0x3ab6, LSL #32
    MOVK  X8, #0x3ab6, LSL #48
    FMOV  X15, D30
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V31.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D31
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
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
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X25
    FMOV  D1, X24
    FMOV  V1.D[1], X28
    FMOV  D2, X29
    FMOV  V2.D[1], X26
    FMOV  D3, X16
    FMOV  V3.D[1], X20
    FMOV  D4, X24
    FMOV  V4.D[1], X25
    FMOV  D5, X24
    FMOV  V5.D[1], X14
    FMOV  D6, X12
    FMOV  V6.D[1], X12
    FMOV  D7, X13
    FMOV  V7.D[1], X5
    FMOV  D8, X26
    FMOV  V8.D[1], X14
    FMOV  D9, X6
    FMOV  V9.D[1], X13
    FMOV  D10, X29
    FMOV  V10.D[1], X23
    FMOV  D11, X24
    FMOV  V11.D[1], X9
    FMOV  D12, X28
    FMOV  V12.D[1], X11
    FMOV  D13, X11
    FMOV  V13.D[1], X2
    FMOV  D14, X14
    FMOV  V14.D[1], X6
    FMOV  D15, X10
    FMOV  V15.D[1], X21
    FMOV  D16, X28
    FMOV  V16.D[1], X7
    FMOV  D17, X20
    FMOV  V17.D[1], X24
    FMOV  D18, X24
    FMOV  V18.D[1], X21
    FMOV  D19, X21
    FMOV  V19.D[1], X14
    FMOV  D20, X17
    FMOV  V20.D[1], X10
    FMOV  D21, X28
    FMOV  V21.D[1], X17
    FMOV  D22, X2
    FMOV  V22.D[1], X29
    FMOV  D23, X28
    FMOV  V23.D[1], X19
    FMOV  D24, X12
    FMOV  V24.D[1], X19
    FMOV  D25, X28
    FMOV  V25.D[1], X16
    FMOV  D26, X6
    FMOV  V26.D[1], X26
    FMOV  D27, X21
    FMOV  V27.D[1], X29
    FMOV  D28, X24
    FMOV  V28.D[1], X21
    FMOV  D29, X16
    FMOV  V29.D[1], X9
    FMOV  D30, X26
    FMOV  V30.D[1], X23
    FMOV  D31, X16
    FMOV  V31.D[1], X20
    UMULL  V3.2D, V22.2S, V31.2S
    UMULL2 V6.2D, V23.4S, V26.S[0x3]
    UMULL2 V26.4S, V20.8H, V0.H[0x1]
    UMULL2  V1.4S, V24.8H, V24.8H
    UQADD  V4.4H, V21.4H, V27.4H
    UQRSHL  V14.4S, V29.4S, V29.4S
    UQRSHRN V31.8B, V25.8H, #3
    UQRSHRN V17.4H, V30.4S, #4
    UQRSHRN V29.2S, V2.2D, #22
    UQRSHRN2 V15.16B, V0.8H, #4
    UQRSHRN2 V20.8H, V28.4S, #2
    UQRSHRN2 V24.4S, V19.2D, #12
    UQSHL  V0.16B, V13.16B, #0x6
    UQSHL V13.2D, V21.2D, #0x2e
    UQSHL  V7.8H, V7.8H, #0x1
    UQSHL  V28.2S, V27.2S, #0x1e
    UQSHL  V5.4S, V30.4S, V19.4S
    UQSHRN V11.8B, V25.8H, #5
    UQSHRN V8.4H, V27.4S, #14
    UQSHRN V23.2S, V2.2D, #28
    UQSHRN2 V18.16B, V22.8H, #5
    UQSHRN2 V25.8H, V9.4S, #8
    UQSHRN2 V21.4S, V27.2D, #14
    UQSUB  V30.8H, V30.8H, V27.8H
    UQXTN  V27.4H, V27.4S
    UQXTN2  V9.8H, V19.4S
    URECPE  V2.2S, V12.2S
    URHADD  V16.4S, V12.4S, V12.4S
    URSHL  V19.8H, V12.8H, V19.8H
    URSHR  V12.16B, V12.16B, #8
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x800, LSL #16
    MRS  X15, FPSR
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X15, V0.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X15, D0
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x67a4, LSL #0
    MOVK  X8, #0x1fe3, LSL #16
    MOVK  X8, #0x67a4, LSL #32
    MOVK  X8, #0x1fe3, LSL #48
    FMOV  X15, V1.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x67a4, LSL #0
    MOVK  X8, #0x1fe3, LSL #16
    MOVK  X8, #0x67a4, LSL #32
    MOVK  X8, #0x1fe3, LSL #48
    FMOV  X15, D1
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V2.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X15, D2
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x67a4, LSL #0
    MOVK  X8, #0xef2b, LSL #16
    MOVK  X8, #0xa76a, LSL #32
    MOVK  X8, #0x1fe3, LSL #48
    FMOV  X15, V3.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x67a4, LSL #0
    MOVK  X8, #0xef2b, LSL #16
    MOVK  X8, #0xa76a, LSL #32
    MOVK  X8, #0x1fe3, LSL #48
    FMOV  X15, D3
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V4.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xb4b4, LSL #0
    MOVK  X8, #0xb4b4, LSL #16
    MOVK  X8, #0xb4b4, LSL #32
    MOVK  X8, #0xb4b4, LSL #48
    FMOV  X15, D4
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X15, V5.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X15, D5
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x67a4, LSL #0
    MOVK  X8, #0xef2b, LSL #16
    MOVK  X8, #0xa76a, LSL #32
    MOVK  X8, #0x1fe3, LSL #48
    FMOV  X15, V6.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x67a4, LSL #0
    MOVK  X8, #0xef2b, LSL #16
    MOVK  X8, #0xa76a, LSL #32
    MOVK  X8, #0x1fe3, LSL #48
    FMOV  X15, D6
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xb4b4, LSL #0
    MOVK  X8, #0xb4b4, LSL #16
    MOVK  X8, #0xb4b4, LSL #32
    MOVK  X8, #0xb4b4, LSL #48
    FMOV  X15, V7.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xb4b4, LSL #0
    MOVK  X8, #0xb4b4, LSL #16
    MOVK  X8, #0xb4b4, LSL #32
    MOVK  X8, #0xb4b4, LSL #48
    FMOV  X15, D7
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V8.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X15, D8
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X15, V9.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D9
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V10.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D10
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V11.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X15, D11
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V12.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, D12
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X15, V13.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X15, D13
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X15, V14.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X15, D14
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X15, V15.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D15
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V16.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D16
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V17.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X15, D17
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X15, V18.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D18
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V19.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, D19
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X15, V20.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D20
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X15, V21.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D21
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V22.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D22
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V23.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X15, D23
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X15, V24.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D24
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X15, V25.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D25
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x67a4, LSL #0
    MOVK  X8, #0x1fe3, LSL #16
    MOVK  X8, #0x67a4, LSL #32
    MOVK  X8, #0x1fe3, LSL #48
    FMOV  X15, V26.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x67a4, LSL #0
    MOVK  X8, #0x1fe3, LSL #16
    MOVK  X8, #0x67a4, LSL #32
    MOVK  X8, #0x1fe3, LSL #48
    FMOV  X15, D26
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V27.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X15, D27
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V28.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X15, D28
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V29.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X15, D29
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V30.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, D30
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V31.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X15, D31
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
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
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X24
    FMOV  D1, X26
    FMOV  V1.D[1], X29
    FMOV  D2, X25
    FMOV  V2.D[1], X13
    FMOV  D3, X2
    FMOV  V3.D[1], X14
    FMOV  D4, X24
    FMOV  V4.D[1], X13
    FMOV  D5, X17
    FMOV  V5.D[1], X28
    FMOV  D6, X25
    FMOV  V6.D[1], X10
    FMOV  D7, X20
    FMOV  V7.D[1], X19
    FMOV  D8, X16
    FMOV  V8.D[1], X6
    FMOV  D9, X12
    FMOV  V9.D[1], X26
    FMOV  D10, X7
    FMOV  V10.D[1], X2
    FMOV  D11, X10
    FMOV  V11.D[1], X10
    FMOV  D12, X29
    FMOV  V12.D[1], X25
    FMOV  D13, X19
    FMOV  V13.D[1], X9
    FMOV  D14, X26
    FMOV  V14.D[1], X19
    FMOV  D15, X17
    FMOV  V15.D[1], X5
    FMOV  D16, X23
    FMOV  V16.D[1], X24
    FMOV  D17, X12
    FMOV  V17.D[1], X16
    FMOV  D18, X12
    FMOV  V18.D[1], X24
    FMOV  D19, X11
    FMOV  V19.D[1], X6
    FMOV  D20, X28
    FMOV  V20.D[1], X2
    FMOV  D21, X16
    FMOV  V21.D[1], X7
    FMOV  D22, X10
    FMOV  V22.D[1], X6
    FMOV  D23, X11
    FMOV  V23.D[1], X28
    FMOV  D24, X12
    FMOV  V24.D[1], X23
    FMOV  D25, X20
    FMOV  V25.D[1], X17
    FMOV  D26, X21
    FMOV  V26.D[1], X9
    FMOV  D27, X26
    FMOV  V27.D[1], X25
    FMOV  D28, X13
    FMOV  V28.D[1], X5
    FMOV  D29, X29
    FMOV  V29.D[1], X12
    FMOV  D30, X9
    FMOV  V30.D[1], X23
    FMOV  D31, X19
    FMOV  V31.D[1], X29
    URSHR  V7.4H, V25.4H, #16
    URSHR  V19.2S, V21.2S, #23
    URSQRTE  V18.2S, V30.2S
    URSRA  V12.8B, V27.8B, #1
    URSRA V23.2D, V26.2D, #27
    URSRA  V22.8H, V21.8H, #2
    URSRA  V29.4S, V29.4S, #5
    USHL  V21.4H, V31.4H, V31.4H
    USHLL V5.2D, V28.2S, #0x12
    USHLL V1.8H, V0.8B, #0x3
    USHLL V3.4S, V4.4H, #0x9
    USHLL2 V0.2D, V27.4S, #0x1c
    USHLL2 V16.8H, V16.16B, #0x7
    USHLL2 V27.4S, V6.8H, #0x3
    USHR  V26.16B, V31.16B, #6
    USHR V17.2D, V15.2D, #59
    USHR  V20.4H, V4.4H, #14
    USHR  V10.2S, V2.2S, #13
    USQADD  V25.4H, V25.4H
    USRA  V30.8B, V13.8B, #4
    USRA V2.2D, V11.2D, #20
    USRA  V11.4H, V8.4H, #1
    USRA  V8.4S, V8.4S, #29
    USUBL  V4.2D, V14.2S, V24.2S
    USUBL2  V15.8H, V28.16B, V15.16B
    USUBW  V24.8H, V6.8H, V31.8B
    USUBW2  V13.2D, V28.2D, V6.4S
    UXTL V14.2D, V9.2S
    UXTL V6.8H, V28.8B
    UXTL V9.4S, V9.4H
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x800, LSL #16
    MRS  X15, FPSR
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xa000, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0x5a5, LSL #48
    FMOV  X15, V0.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xa000, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0x5a5, LSL #48
    FMOV  X15, D0
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x2d0, LSL #0
    MOVK  X8, #0x2d0, LSL #16
    MOVK  X8, #0x2d0, LSL #32
    MOVK  X8, #0x2d0, LSL #48
    FMOV  X15, V1.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x2d0, LSL #0
    MOVK  X8, #0x2d0, LSL #16
    MOVK  X8, #0x2d0, LSL #32
    MOVK  X8, #0x2d0, LSL #48
    FMOV  X15, D1
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0x5fff, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V2.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0x5fff, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D2
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xb400, LSL #0
    MOVK  X8, #0xb4, LSL #16
    MOVK  X8, #0xb400, LSL #32
    MOVK  X8, #0xb4, LSL #48
    FMOV  X15, V3.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xb400, LSL #0
    MOVK  X8, #0xb4, LSL #16
    MOVK  X8, #0xb400, LSL #32
    MOVK  X8, #0xb4, LSL #48
    FMOV  X15, D3
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V4.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, D4
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x6968, LSL #16
    MOVK  X8, #0x6969, LSL #32
    MOVK  X8, #0x1, LSL #48
    FMOV  X15, V5.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x6968, LSL #16
    MOVK  X8, #0x6969, LSL #32
    MOVK  X8, #0x1, LSL #48
    FMOV  X15, D5
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a, LSL #0
    MOVK  X8, #0x5a, LSL #16
    MOVK  X8, #0x5a, LSL #32
    MOVK  X8, #0x5a, LSL #48
    FMOV  X15, V6.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a, LSL #0
    MOVK  X8, #0x5a, LSL #16
    MOVK  X8, #0x5a, LSL #32
    MOVK  X8, #0x5a, LSL #48
    FMOV  X15, D6
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V7.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, D7
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5c, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5c, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V8.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5c, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5c, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D8
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #32
    FMOV  X15, V9.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #32
    FMOV  X15, D9
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V10.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xd2d2, LSL #0
    MOVK  X8, #0x2, LSL #16
    MOVK  X8, #0xd2d2, LSL #32
    MOVK  X8, #0x2, LSL #48
    FMOV  X15, D10
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V11.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x8787, LSL #0
    MOVK  X8, #0x8787, LSL #16
    MOVK  X8, #0x8787, LSL #32
    MOVK  X8, #0x8787, LSL #48
    FMOV  X15, D11
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V12.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x8787, LSL #0
    MOVK  X8, #0x8787, LSL #16
    MOVK  X8, #0x8787, LSL #32
    MOVK  X8, #0x8787, LSL #48
    FMOV  X15, D12
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V13.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D13
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    FMOV  X15, V14.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    FMOV  X15, D14
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V15.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, D15
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x2d00, LSL #0
    MOVK  X8, #0x2d00, LSL #16
    MOVK  X8, #0x2d00, LSL #32
    MOVK  X8, #0x2d00, LSL #48
    FMOV  X15, V16.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x2d00, LSL #0
    MOVK  X8, #0x2d00, LSL #16
    MOVK  X8, #0x2d00, LSL #32
    MOVK  X8, #0x2d00, LSL #48
    FMOV  X15, D16
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xb, LSL #0
    FMOV  X15, V17.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xb, LSL #0
    FMOV  X15, D17
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V18.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xd780, LSL #16
    MOVK  X8, #0xd780, LSL #48
    FMOV  X15, D18
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V19.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xb5, LSL #0
    MOVK  X8, #0xb5, LSL #32
    FMOV  X15, D19
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V20.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x1, LSL #0
    MOVK  X8, #0x1, LSL #16
    MOVK  X8, #0x1, LSL #32
    MOVK  X8, #0x1, LSL #48
    FMOV  X15, D20
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V21.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, D21
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x70f1, LSL #0
    MOVK  X8, #0x70f1, LSL #16
    MOVK  X8, #0x70f1, LSL #32
    MOVK  X8, #0x70f1, LSL #48
    FMOV  X15, V22.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x70f1, LSL #0
    MOVK  X8, #0x70f1, LSL #16
    MOVK  X8, #0x70f1, LSL #32
    MOVK  X8, #0x70f1, LSL #48
    FMOV  X15, D22
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0x5a65, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V23.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0x5a65, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D23
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a00, LSL #0
    MOVK  X8, #0x5a00, LSL #16
    MOVK  X8, #0x5a00, LSL #32
    MOVK  X8, #0x5a00, LSL #48
    FMOV  X15, V24.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a00, LSL #0
    MOVK  X8, #0x5a00, LSL #16
    MOVK  X8, #0x5a00, LSL #32
    MOVK  X8, #0x5a00, LSL #48
    FMOV  X15, D24
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V25.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xb4b4, LSL #0
    MOVK  X8, #0xb4b4, LSL #16
    MOVK  X8, #0xb4b4, LSL #32
    MOVK  X8, #0xb4b4, LSL #48
    FMOV  X15, D25
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x101, LSL #0
    MOVK  X8, #0x101, LSL #16
    MOVK  X8, #0x101, LSL #32
    MOVK  X8, #0x101, LSL #48
    FMOV  X15, V26.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x101, LSL #0
    MOVK  X8, #0x101, LSL #16
    MOVK  X8, #0x101, LSL #32
    MOVK  X8, #0x101, LSL #48
    FMOV  X15, D26
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xd2d0, LSL #0
    MOVK  X8, #0x2, LSL #16
    MOVK  X8, #0xd2d0, LSL #32
    MOVK  X8, #0x2, LSL #48
    FMOV  X15, V27.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xd2d0, LSL #0
    MOVK  X8, #0x2, LSL #16
    MOVK  X8, #0xd2d0, LSL #32
    MOVK  X8, #0x2, LSL #48
    FMOV  X15, D27
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V28.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D28
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x2d2d, LSL #0
    MOVK  X8, #0x5d2d, LSL #16
    MOVK  X8, #0x2d2d, LSL #32
    MOVK  X8, #0x5d2d, LSL #48
    FMOV  X15, V29.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x2d2d, LSL #0
    MOVK  X8, #0x5d2d, LSL #16
    MOVK  X8, #0x2d2d, LSL #32
    MOVK  X8, #0x5d2d, LSL #48
    FMOV  X15, D29
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, V30.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5f5f, LSL #0
    MOVK  X8, #0x5f5f, LSL #16
    MOVK  X8, #0x5f5f, LSL #32
    MOVK  X8, #0x5f5f, LSL #48
    FMOV  X15, D30
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V31.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D31
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
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
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X20
    FMOV  V0.D[1], X25
    FMOV  D1, X29
    FMOV  V1.D[1], X26
    FMOV  D2, X28
    FMOV  V2.D[1], X12
    FMOV  D3, X13
    FMOV  V3.D[1], X2
    FMOV  D4, X7
    FMOV  V4.D[1], X24
    FMOV  D5, X7
    FMOV  V5.D[1], X17
    FMOV  D6, X21
    FMOV  V6.D[1], X6
    FMOV  D7, X17
    FMOV  V7.D[1], X5
    FMOV  D8, X12
    FMOV  V8.D[1], X17
    FMOV  D9, X17
    FMOV  V9.D[1], X28
    FMOV  D10, X5
    FMOV  V10.D[1], X10
    FMOV  D11, X10
    FMOV  V11.D[1], X29
    FMOV  D12, X20
    FMOV  V12.D[1], X10
    FMOV  D13, X10
    FMOV  V13.D[1], X13
    FMOV  D14, X29
    FMOV  V14.D[1], X23
    FMOV  D15, X29
    FMOV  V15.D[1], X20
    FMOV  D16, X17
    FMOV  V16.D[1], X17
    FMOV  D17, X28
    FMOV  V17.D[1], X20
    FMOV  D18, X29
    FMOV  V18.D[1], X20
    FMOV  D19, X16
    FMOV  V19.D[1], X26
    FMOV  D20, X9
    FMOV  V20.D[1], X13
    FMOV  D21, X10
    FMOV  V21.D[1], X25
    FMOV  D22, X28
    FMOV  V22.D[1], X25
    FMOV  D23, X17
    FMOV  V23.D[1], X19
    FMOV  D24, X20
    FMOV  V24.D[1], X19
    FMOV  D25, X21
    FMOV  V25.D[1], X16
    FMOV  D26, X20
    FMOV  V26.D[1], X16
    FMOV  D27, X26
    FMOV  V27.D[1], X6
    FMOV  D28, X29
    FMOV  V28.D[1], X5
    FMOV  D29, X13
    FMOV  V29.D[1], X24
    FMOV  D30, X5
    FMOV  V30.D[1], X29
    FMOV  D31, X17
    FMOV  V31.D[1], X26
    UXTL2 V5.8H, V29.16B
    UXTL2 V3.4S, V19.8H
    SHA1C  Q20, S23, V24.4S
    SHA1M  Q23, S19, V30.4S
    SHA1P  Q21, S27, V22.4S
    SHA1SU0  V16.4S, V26.4S, V27.4S
    SHA1SU1  V14.4S, V25.4S
    SHA256H  Q12, Q28, V28.4S
    SHA256H2  Q9, Q31, V31.4S
    SHA256SU0  V30.4S, V10.4S
    SHA256SU1  V22.4S, V18.4S, V2.4S
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X15, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x800, LSL #16
    MRS  X15, FPSR
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V0.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D0
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V1.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D1
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V2.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D2
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #32
    FMOV  X15, V3.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #32
    FMOV  X15, D3
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V4.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D4
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a, LSL #0
    MOVK  X8, #0x5a, LSL #16
    MOVK  X8, #0x5a, LSL #32
    MOVK  X8, #0x5a, LSL #48
    FMOV  X15, V5.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a, LSL #0
    MOVK  X8, #0x5a, LSL #16
    MOVK  X8, #0x5a, LSL #32
    MOVK  X8, #0x5a, LSL #48
    FMOV  X15, D5
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V6.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D6
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V7.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D7
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V8.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D8
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x3eba, LSL #0
    MOVK  X8, #0x589c, LSL #16
    MOVK  X8, #0x7877, LSL #32
    MOVK  X8, #0x7878, LSL #48
    FMOV  X15, V9.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xefc7, LSL #0
    MOVK  X8, #0xbaca, LSL #16
    MOVK  X8, #0xc5d1, LSL #32
    MOVK  X8, #0xd99f, LSL #48
    FMOV  X15, D9
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V10.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D10
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V11.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D11
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x158c, LSL #0
    MOVK  X8, #0xeb77, LSL #16
    MOVK  X8, #0xa5a4, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X15, V12.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xbb1a, LSL #0
    MOVK  X8, #0xc033, LSL #16
    MOVK  X8, #0x2e79, LSL #32
    MOVK  X8, #0xb5a9, LSL #48
    FMOV  X15, D12
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V13.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D13
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xb4b4, LSL #32
    MOVK  X8, #0xb4b4, LSL #48
    FMOV  X15, V14.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X15, D14
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V15.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D15
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V16.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D16
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V17.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D17
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V18.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D18
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V19.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D19
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x847c, LSL #0
    MOVK  X8, #0x4484, LSL #16
    MOVK  X8, #0x9696, LSL #32
    MOVK  X8, #0x5696, LSL #48
    FMOV  X15, V20.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xb517, LSL #0
    MOVK  X8, #0x3938, LSL #16
    MOVK  X8, #0x896c, LSL #32
    MOVK  X8, #0x8d8d, LSL #48
    FMOV  X15, D20
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xa59d, LSL #0
    MOVK  X8, #0x65a5, LSL #16
    MOVK  X8, #0x9696, LSL #32
    MOVK  X8, #0x5696, LSL #48
    FMOV  X15, V21.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x3f61, LSL #0
    MOVK  X8, #0x83c3, LSL #16
    MOVK  X8, #0xddbf, LSL #32
    MOVK  X8, #0xe1e1, LSL #48
    FMOV  X15, D21
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xfc53, LSL #0
    MOVK  X8, #0x1b14, LSL #16
    MOVK  X8, #0xfc53, LSL #32
    MOVK  X8, #0x1b14, LSL #48
    FMOV  X15, V22.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xa5a4, LSL #0
    MOVK  X8, #0x1b25, LSL #16
    MOVK  X8, #0xa5a4, LSL #32
    MOVK  X8, #0x1b25, LSL #48
    FMOV  X15, D22
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x968e, LSL #0
    MOVK  X8, #0x5696, LSL #16
    MOVK  X8, #0x9696, LSL #32
    MOVK  X8, #0x5696, LSL #48
    FMOV  X15, V23.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xd638, LSL #0
    MOVK  X8, #0x1a59, LSL #16
    MOVK  X8, #0x9275, LSL #32
    MOVK  X8, #0x9696, LSL #48
    FMOV  X15, D23
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V24.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D24
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V25.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D25
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V26.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D26
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V27.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D27
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V28.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D28
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V29.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D29
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xc3c3, LSL #0
    MOVK  X8, #0x83c3, LSL #16
    MOVK  X8, #0xc3c3, LSL #32
    MOVK  X8, #0x83c3, LSL #48
    FMOV  X15, V30.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0xc3c3, LSL #0
    MOVK  X8, #0x83c3, LSL #16
    MOVK  X8, #0xc3c3, LSL #32
    MOVK  X8, #0x83c3, LSL #48
    FMOV  X15, D30
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, V31.D[1]
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X15, D31
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X26
    FMOV  D1, X21
    FMOV  V1.D[1], X25
    FMOV  D2, X29
    FMOV  V2.D[1], X16
    FMOV  D3, X6
    FMOV  V3.D[1], X17
    FMOV  D4, X24
    FMOV  V4.D[1], X15
    FMOV  D5, X20
    FMOV  V5.D[1], X24
    FMOV  D6, X12
    FMOV  V6.D[1], X10
    FMOV  D7, X16
    FMOV  V7.D[1], X10
    FMOV  D8, X16
    FMOV  V8.D[1], X24
    FMOV  D9, X16
    FMOV  V9.D[1], X6
    FMOV  D10, X13
    FMOV  V10.D[1], X26
    FMOV  D11, X28
    FMOV  V11.D[1], X13
    FMOV  D12, X24
    FMOV  V12.D[1], X29
    FMOV  D13, X14
    FMOV  V13.D[1], X16
    FMOV  D14, X24
    FMOV  V14.D[1], X14
    FMOV  D15, X11
    FMOV  V15.D[1], X26
    FMOV  D16, X5
    FMOV  V16.D[1], X13
    FMOV  D17, X19
    FMOV  V17.D[1], X8
    FMOV  D18, X29
    FMOV  V18.D[1], X15
    FMOV  D19, X9
    FMOV  V19.D[1], X13
    FMOV  D20, X9
    FMOV  V20.D[1], X24
    FMOV  D21, X7
    FMOV  V21.D[1], X5
    FMOV  D22, X8
    FMOV  V22.D[1], X15
    FMOV  D23, X6
    FMOV  V23.D[1], X17
    FMOV  D24, X15
    FMOV  V24.D[1], X20
    FMOV  D25, X5
    FMOV  V25.D[1], X29
    FMOV  D26, X10
    FMOV  V26.D[1], X5
    FMOV  D27, X29
    FMOV  V27.D[1], X19
    FMOV  D28, X11
    FMOV  V28.D[1], X15
    FMOV  D29, X8
    FMOV  V29.D[1], X29
    FMOV  D30, X15
    FMOV  V30.D[1], X15
    FMOV  D31, X10
    FMOV  V31.D[1], X25
    UABA  V4.8H, V23.8H, V29.8H
    UABAL  V14.2D, V15.2S, V26.2S
    UABAL2  V8.4S, V31.8H, V25.8H
    UABD  V22.4H, V24.4H, V27.4H
    UABDL  V12.8H, V28.8B, V28.8B
    UABDL2  V6.4S, V30.8H, V30.8H
    UADALP  V20.4H, V21.8B
    UADDL  V23.8H, V9.8B, V18.8B
    UADDL2  V16.4S, V2.8H, V30.8H
    UADDLP  V29.1D, V25.2S
    UADDLV  H11, V13.8B
    UADDLV  S19, V18.4H
    UADDLV  D28, V10.4S
    UADDW  V2.2D, V1.2D, V17.2S
    UADDW2  V30.4S, V17.4S, V18.8H
    UHADD  V7.4S, V9.4S, V17.4S
    UHSUB  V21.4S, V3.4S, V9.4S
    UMLAL V25.2D, V13.2S, V25.S[0x0]
    UMLAL V3.4S, V3.4H, V1.H[0x1]
    UMLAL  V18.8H, V15.8B, V31.8B
    UMLAL2 V10.2D, V17.4S, V1.S[0x1]
    UMLAL2 V13.4S, V0.8H, V13.H[0x6]
    UMLAL2  V17.8H, V5.16B, V17.16B
    UMLSL V27.2D, V31.2S, V26.S[0x3]
    UMLSL V15.4S, V0.4H, V0.H[0x1]
    UMLSL  V0.8H, V9.8B, V0.8B
    UMLSL2 V31.2D, V26.4S, V31.S[0x3]
    UMLSL2 V9.4S, V9.8H, V5.H[0x0]
    UMLSL2  V5.4S, V24.8H, V5.8H
    UMOV W12, V1.B[0x8]
    UMOV W10, V24.H[0x7]
    UMOV W20, V24.S[0x3]
    UMOV X16, V24.D[0x1]
    UMULL V1.2D, V24.2S, V26.S[0x1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    SUB  X25, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5, LSL #0
    SUB  X25, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x800, LSL #16
    MRS  X25, FPSR
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x3b4c, LSL #0
    MOVK  X2, #0x3b4c, LSL #16
    MOVK  X2, #0x3b4c, LSL #32
    MOVK  X2, #0x3b4c, LSL #48
    FMOV  X25, V0.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x3b4c, LSL #0
    MOVK  X2, #0x3b4c, LSL #16
    MOVK  X2, #0x3b4c, LSL #32
    MOVK  X2, #0x3b4c, LSL #48
    FMOV  X25, D0
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x1c59, LSL #0
    MOVK  X2, #0xa3e0, LSL #16
    MOVK  X2, #0xf2b5, LSL #32
    MOVK  X2, #0x6b2e, LSL #48
    FMOV  X25, V1.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x1c59, LSL #0
    MOVK  X2, #0xa3e0, LSL #16
    MOVK  X2, #0xf2b5, LSL #32
    MOVK  X2, #0x6b2e, LSL #48
    FMOV  X25, D1
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x4b4a, LSL #0
    MOVK  X2, #0x4b4b, LSL #16
    MOVK  X2, #0xa5a6, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V2.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x4b4a, LSL #0
    MOVK  X2, #0x4b4b, LSL #16
    MOVK  X2, #0xa5a6, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D2
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xc1fe, LSL #0
    MOVK  X2, #0x10d3, LSL #16
    MOVK  X2, #0xc1fe, LSL #32
    MOVK  X2, #0x10d3, LSL #48
    FMOV  X25, V3.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xc1fe, LSL #0
    MOVK  X2, #0x10d3, LSL #16
    MOVK  X2, #0xc1fe, LSL #32
    MOVK  X2, #0x10d3, LSL #48
    FMOV  X25, D3
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V4.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D4
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x894c, LSL #0
    MOVK  X2, #0x3a77, LSL #16
    MOVK  X2, #0x894c, LSL #32
    MOVK  X2, #0x3a77, LSL #48
    FMOV  X25, V5.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x894c, LSL #0
    MOVK  X2, #0x3a77, LSL #16
    MOVK  X2, #0x894c, LSL #32
    MOVK  X2, #0x3a77, LSL #48
    FMOV  X25, D5
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V6.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, D6
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V7.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D7
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V8.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D8
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x894c, LSL #0
    MOVK  X2, #0x3a77, LSL #16
    MOVK  X2, #0x894c, LSL #32
    MOVK  X2, #0x3a77, LSL #48
    FMOV  X25, V9.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x894c, LSL #0
    MOVK  X2, #0x3a77, LSL #16
    MOVK  X2, #0x894c, LSL #32
    MOVK  X2, #0x3a77, LSL #48
    FMOV  X25, D9
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xc1fe, LSL #0
    MOVK  X2, #0x4985, LSL #16
    MOVK  X2, #0x985b, LSL #32
    MOVK  X2, #0x10d4, LSL #48
    FMOV  X25, V10.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xc1fe, LSL #0
    MOVK  X2, #0x4985, LSL #16
    MOVK  X2, #0x985b, LSL #32
    MOVK  X2, #0x10d4, LSL #48
    FMOV  X25, D10
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V11.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x528, LSL #0
    FMOV  X25, D11
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V12.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, D12
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xc1fe, LSL #0
    MOVK  X2, #0x10d3, LSL #16
    MOVK  X2, #0xc1fe, LSL #32
    MOVK  X2, #0x10d3, LSL #48
    FMOV  X25, V13.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xc1fe, LSL #0
    MOVK  X2, #0x10d3, LSL #16
    MOVK  X2, #0xc1fe, LSL #32
    MOVK  X2, #0x10d3, LSL #48
    FMOV  X25, D13
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V14.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D14
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x894c, LSL #0
    MOVK  X2, #0x3a77, LSL #16
    MOVK  X2, #0x894c, LSL #32
    MOVK  X2, #0x3a77, LSL #48
    FMOV  X25, V15.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x894c, LSL #0
    MOVK  X2, #0x3a77, LSL #16
    MOVK  X2, #0x894c, LSL #32
    MOVK  X2, #0x3a77, LSL #48
    FMOV  X25, D15
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x4b4a, LSL #0
    MOVK  X2, #0x1, LSL #16
    MOVK  X2, #0x4b4a, LSL #32
    MOVK  X2, #0x1, LSL #48
    FMOV  X25, V16.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x4b4a, LSL #0
    MOVK  X2, #0x1, LSL #16
    MOVK  X2, #0x4b4a, LSL #32
    MOVK  X2, #0x1, LSL #48
    FMOV  X25, D16
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xffe, LSL #0
    MOVK  X2, #0xffe, LSL #16
    MOVK  X2, #0xffe, LSL #32
    MOVK  X2, #0xffe, LSL #48
    FMOV  X25, V17.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xffe, LSL #0
    MOVK  X2, #0xffe, LSL #16
    MOVK  X2, #0xffe, LSL #32
    MOVK  X2, #0xffe, LSL #48
    FMOV  X25, D17
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xffe, LSL #0
    MOVK  X2, #0xffe, LSL #16
    MOVK  X2, #0xffe, LSL #32
    MOVK  X2, #0xffe, LSL #48
    FMOV  X25, V18.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xffe, LSL #0
    MOVK  X2, #0xffe, LSL #16
    MOVK  X2, #0xffe, LSL #32
    MOVK  X2, #0xffe, LSL #48
    FMOV  X25, D18
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V19.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x9694, LSL #0
    MOVK  X2, #0x2, LSL #16
    FMOV  X25, D19
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V20.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa6ef, LSL #0
    MOVK  X2, #0xa6ef, LSL #16
    MOVK  X2, #0xa6ef, LSL #32
    MOVK  X2, #0xa6ef, LSL #48
    FMOV  X25, D20
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V21.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, D21
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V22.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, D22
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x14a, LSL #0
    MOVK  X2, #0x14a, LSL #16
    MOVK  X2, #0x14a, LSL #32
    MOVK  X2, #0x14a, LSL #48
    FMOV  X25, V23.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x14a, LSL #0
    MOVK  X2, #0x14a, LSL #16
    MOVK  X2, #0x14a, LSL #32
    MOVK  X2, #0x14a, LSL #48
    FMOV  X25, D23
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V24.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D24
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xc1fe, LSL #0
    MOVK  X2, #0x4985, LSL #16
    MOVK  X2, #0x985b, LSL #32
    MOVK  X2, #0x10d4, LSL #48
    FMOV  X25, V25.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xc1fe, LSL #0
    MOVK  X2, #0x4985, LSL #16
    MOVK  X2, #0x985b, LSL #32
    MOVK  X2, #0x10d4, LSL #48
    FMOV  X25, D25
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V26.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D26
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x894c, LSL #0
    MOVK  X2, #0x1c5, LSL #16
    MOVK  X2, #0xb2f0, LSL #32
    MOVK  X2, #0x3a76, LSL #48
    FMOV  X25, V27.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x894c, LSL #0
    MOVK  X2, #0x1c5, LSL #16
    MOVK  X2, #0xb2f0, LSL #32
    MOVK  X2, #0x3a76, LSL #48
    FMOV  X25, D27
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V28.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x9694, LSL #0
    MOVK  X2, #0x9696, LSL #16
    MOVK  X2, #0x2, LSL #32
    FMOV  X25, D28
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V29.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x4b4a, LSL #0
    MOVK  X2, #0x4b4b, LSL #16
    MOVK  X2, #0x1, LSL #32
    FMOV  X25, D29
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x4b4a, LSL #0
    MOVK  X2, #0xa5a6, LSL #16
    MOVK  X2, #0x4b4a, LSL #32
    MOVK  X2, #0xa5a6, LSL #48
    FMOV  X25, V30.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x4b4a, LSL #0
    MOVK  X2, #0xa5a6, LSL #16
    MOVK  X2, #0x4b4a, LSL #32
    MOVK  X2, #0xa5a6, LSL #48
    FMOV  X25, D30
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x894c, LSL #0
    MOVK  X2, #0x1c5, LSL #16
    MOVK  X2, #0xb2f0, LSL #32
    MOVK  X2, #0x3a76, LSL #48
    FMOV  X25, V31.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x894c, LSL #0
    MOVK  X2, #0x1c5, LSL #16
    MOVK  X2, #0xb2f0, LSL #32
    MOVK  X2, #0x3a76, LSL #48
    FMOV  X25, D31
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
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
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X23
    FMOV  D1, X28
    FMOV  V1.D[1], X29
    FMOV  D2, X26
    FMOV  V2.D[1], X26
    FMOV  D3, X9
    FMOV  V3.D[1], X10
    FMOV  D4, X7
    FMOV  V4.D[1], X10
    FMOV  D5, X16
    FMOV  V5.D[1], X15
    FMOV  D6, X10
    FMOV  V6.D[1], X14
    FMOV  D7, X15
    FMOV  V7.D[1], X28
    FMOV  D8, X24
    FMOV  V8.D[1], X26
    FMOV  D9, X16
    FMOV  V9.D[1], X13
    FMOV  D10, X18
    FMOV  V10.D[1], X21
    FMOV  D11, X11
    FMOV  V11.D[1], X19
    FMOV  D12, X9
    FMOV  V12.D[1], X24
    FMOV  D13, X7
    FMOV  V13.D[1], X11
    FMOV  D14, X15
    FMOV  V14.D[1], X12
    FMOV  D15, X20
    FMOV  V15.D[1], X26
    FMOV  D16, X6
    FMOV  V16.D[1], X7
    FMOV  D17, X10
    FMOV  V17.D[1], X11
    FMOV  D18, X12
    FMOV  V18.D[1], X9
    FMOV  D19, X21
    FMOV  V19.D[1], X7
    FMOV  D20, X15
    FMOV  V20.D[1], X14
    FMOV  D21, X21
    FMOV  V21.D[1], X20
    FMOV  D22, X10
    FMOV  V22.D[1], X26
    FMOV  D23, X20
    FMOV  V23.D[1], X11
    FMOV  D24, X20
    FMOV  V24.D[1], X19
    FMOV  D25, X18
    FMOV  V25.D[1], X17
    FMOV  D26, X26
    FMOV  V26.D[1], X10
    FMOV  D27, X28
    FMOV  V27.D[1], X11
    FMOV  D28, X14
    FMOV  V28.D[1], X29
    FMOV  D29, X29
    FMOV  V29.D[1], X6
    FMOV  D30, X16
    FMOV  V30.D[1], X15
    FMOV  D31, X26
    FMOV  V31.D[1], X26
    UMULL  V23.8H, V31.8B, V30.8B
    UMULL2 V13.2D, V21.4S, V27.S[0x1]
    UMULL2 V6.4S, V28.8H, V6.H[0x0]
    UMULL2  V22.2D, V24.4S, V2.4S
    UQADD  V0.4S, V25.4S, V25.4S
    UQRSHL  V18.2D, V26.2D, V26.2D
    UQRSHRN V17.8B, V29.8H, #4
    UQRSHRN V19.4H, V29.4S, #16
    UQRSHRN V16.2S, V25.2D, #21
    UQRSHRN2 V5.16B, V30.8H, #8
    UQRSHRN2 V4.8H, V25.4S, #11
    UQRSHRN2 V15.4S, V27.2D, #12
    UQSHL  V20.16B, V2.16B, #0x4
    UQSHL V21.2D, V9.2D, #0x35
    UQSHL  V24.4H, V11.4H, #0x8
    UQSHL  V10.4S, V29.4S, #0x8
    UQSHL  V2.8B, V7.8B, V27.8B
    UQSHRN V11.8B, V11.8H, #7
    UQSHRN V30.4H, V9.4S, #1
    UQSHRN V27.2S, V7.2D, #13
    UQSHRN2 V25.16B, V31.8H, #2
    UQSHRN2 V14.8H, V28.4S, #12
    UQSHRN2 V12.4S, V1.2D, #29
    UQSUB  V31.2D, V26.2D, V29.2D
    UQXTN  V9.8B, V29.8H
    UQXTN2  V7.16B, V29.8H
    URECPE  V28.2S, V26.2S
    URHADD  V3.8B, V29.8B, V29.8B
    URSHL  V29.2S, V1.2S, V1.2S
    URSHR  V1.8B, V1.8B, #3
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x800, LSL #16
    MRS  X25, FPSR
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X25, V0.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X25, D0
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V1.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x1515, LSL #0
    MOVK  X2, #0x1515, LSL #16
    MOVK  X2, #0x1515, LSL #32
    MOVK  X2, #0x1515, LSL #48
    FMOV  X25, D1
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V2.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, D2
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V3.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D3
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X25, V4.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D4
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa6a6, LSL #0
    MOVK  X2, #0xa6a6, LSL #16
    MOVK  X2, #0xa6a6, LSL #32
    MOVK  X2, #0xa6a6, LSL #48
    FMOV  X25, V5.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D5
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x1c59, LSL #0
    MOVK  X2, #0x6b2e, LSL #16
    MOVK  X2, #0x1c59, LSL #32
    MOVK  X2, #0x6b2e, LSL #48
    FMOV  X25, V6.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x1c59, LSL #0
    MOVK  X2, #0x6b2e, LSL #16
    MOVK  X2, #0x1c59, LSL #32
    MOVK  X2, #0x6b2e, LSL #48
    FMOV  X25, D6
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X25, V7.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D7
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V8.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D8
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V9.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X25, D9
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X25, V10.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X25, D10
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V11.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X25, D11
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X25, V12.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D12
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x1c59, LSL #0
    MOVK  X2, #0xa3e0, LSL #16
    MOVK  X2, #0xf2b5, LSL #32
    MOVK  X2, #0x6b2e, LSL #48
    FMOV  X25, V13.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x1c59, LSL #0
    MOVK  X2, #0xa3e0, LSL #16
    MOVK  X2, #0xf2b5, LSL #32
    MOVK  X2, #0x6b2e, LSL #48
    FMOV  X25, D13
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X25, V14.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D14
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X25, V15.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D15
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V16.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X25, D16
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V17.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X25, D17
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V18.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, D18
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V19.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a6, LSL #0
    MOVK  X2, #0xa5a6, LSL #16
    MOVK  X2, #0xa5a6, LSL #32
    MOVK  X2, #0xa5a6, LSL #48
    FMOV  X25, D19
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X25, V20.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X25, D20
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X25, V21.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X25, D21
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x1c59, LSL #0
    MOVK  X2, #0xa3e0, LSL #16
    MOVK  X2, #0xf2b5, LSL #32
    MOVK  X2, #0x6b2e, LSL #48
    FMOV  X25, V22.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x1c59, LSL #0
    MOVK  X2, #0xa3e0, LSL #16
    MOVK  X2, #0xf2b5, LSL #32
    MOVK  X2, #0x6b2e, LSL #48
    FMOV  X25, D22
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x6a59, LSL #0
    MOVK  X2, #0x6a59, LSL #16
    MOVK  X2, #0x6a59, LSL #32
    MOVK  X2, #0x6a59, LSL #48
    FMOV  X25, V23.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x6a59, LSL #0
    MOVK  X2, #0x6a59, LSL #16
    MOVK  X2, #0x6a59, LSL #32
    MOVK  X2, #0x6a59, LSL #48
    FMOV  X25, D23
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V24.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X25, D24
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X25, V25.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D25
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V26.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D26
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V27.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X25, D27
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V28.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0xc580, LSL #16
    MOVK  X2, #0xc580, LSL #48
    FMOV  X25, D28
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V29.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, D29
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V30.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X25, D30
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V31.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, D31
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
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
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X26
    FMOV  D1, X23
    FMOV  V1.D[1], X29
    FMOV  D2, X28
    FMOV  V2.D[1], X23
    FMOV  D3, X23
    FMOV  V3.D[1], X14
    FMOV  D4, X8
    FMOV  V4.D[1], X12
    FMOV  D5, X29
    FMOV  V5.D[1], X21
    FMOV  D6, X8
    FMOV  V6.D[1], X24
    FMOV  D7, X6
    FMOV  V7.D[1], X15
    FMOV  D8, X6
    FMOV  V8.D[1], X16
    FMOV  D9, X28
    FMOV  V9.D[1], X9
    FMOV  D10, X21
    FMOV  V10.D[1], X29
    FMOV  D11, X8
    FMOV  V11.D[1], X6
    FMOV  D12, X29
    FMOV  V12.D[1], X28
    FMOV  D13, X9
    FMOV  V13.D[1], X23
    FMOV  D14, X13
    FMOV  V14.D[1], X13
    FMOV  D15, X11
    FMOV  V15.D[1], X15
    FMOV  D16, X13
    FMOV  V16.D[1], X26
    FMOV  D17, X20
    FMOV  V17.D[1], X16
    FMOV  D18, X8
    FMOV  V18.D[1], X17
    FMOV  D19, X11
    FMOV  V19.D[1], X26
    FMOV  D20, X26
    FMOV  V20.D[1], X28
    FMOV  D21, X10
    FMOV  V21.D[1], X11
    FMOV  D22, X12
    FMOV  V22.D[1], X9
    FMOV  D23, X14
    FMOV  V23.D[1], X8
    FMOV  D24, X24
    FMOV  V24.D[1], X26
    FMOV  D25, X14
    FMOV  V25.D[1], X20
    FMOV  D26, X15
    FMOV  V26.D[1], X9
    FMOV  D27, X20
    FMOV  V27.D[1], X8
    FMOV  D28, X28
    FMOV  V28.D[1], X16
    FMOV  D29, X12
    FMOV  V29.D[1], X6
    FMOV  D30, X11
    FMOV  V30.D[1], X23
    FMOV  D31, X29
    FMOV  V31.D[1], X19
    URSHR  V25.4H, V22.4H, #4
    URSHR  V13.4S, V23.4S, #26
    URSQRTE  V9.2S, V28.2S
    URSRA  V11.16B, V29.16B, #8
    URSRA V10.2D, V30.2D, #43
    URSRA  V8.8H, V26.8H, #4
    URSRA  V21.2S, V27.2S, #19
    USHL  V7.2D, V31.2D, V31.2D
    USHLL V3.2D, V26.2S, #0xc
    USHLL V15.8H, V4.8B, #0x2
    USHLL V1.4S, V24.4H, #0x9
    USHLL2 V17.2D, V19.4S, #0x4
    USHLL2 V2.8H, V18.16B, #0x5
    USHLL2 V5.4S, V24.8H, #0xd
    USHR  V26.8B, V29.8B, #7
    USHR V31.2D, V24.2D, #52
    USHR  V18.8H, V0.8H, #5
    USHR  V28.4S, V19.4S, #32
    USQADD  V22.8H, V22.8H
    USRA  V29.16B, V20.16B, #6
    USRA V14.2D, V6.2D, #58
    USRA  V20.8H, V0.8H, #1
    USRA  V19.4S, V24.4S, #17
    USUBL  V16.4S, V16.4H, V12.4H
    USUBL2  V0.8H, V23.16B, V30.16B
    USUBW  V4.8H, V27.8H, V24.8B
    USUBW2  V12.4S, V27.4S, V23.8H
    UXTL V24.2D, V23.2S
    UXTL V6.8H, V23.8B
    UXTL V30.4S, V30.4H
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x800, LSL #16
    MRS  X25, FPSR
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V0.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, D0
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x4a00, LSL #0
    MOVK  X2, #0x14b, LSL #16
    MOVK  X2, #0x4a00, LSL #32
    MOVK  X2, #0x14b, LSL #48
    FMOV  X25, V1.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x4a00, LSL #0
    MOVK  X2, #0x14b, LSL #16
    MOVK  X2, #0x4a00, LSL #32
    MOVK  X2, #0x14b, LSL #48
    FMOV  X25, D1
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x14a0, LSL #0
    MOVK  X2, #0x14a0, LSL #16
    MOVK  X2, #0x14a0, LSL #32
    MOVK  X2, #0x14a0, LSL #48
    FMOV  X25, V2.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x14a0, LSL #0
    MOVK  X2, #0x14a0, LSL #16
    MOVK  X2, #0x14a0, LSL #32
    MOVK  X2, #0x14a0, LSL #48
    FMOV  X25, D2
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x5000, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0xa5a, LSL #32
    FMOV  X25, V3.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x5000, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0xa5a, LSL #32
    FMOV  X25, D3
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa500, LSL #0
    MOVK  X2, #0xa500, LSL #16
    MOVK  X2, #0xa500, LSL #32
    MOVK  X2, #0xa500, LSL #48
    FMOV  X25, V4.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa500, LSL #0
    MOVK  X2, #0xa500, LSL #16
    MOVK  X2, #0xa500, LSL #32
    MOVK  X2, #0xa500, LSL #48
    FMOV  X25, D4
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa000, LSL #0
    MOVK  X2, #0x14b4, LSL #16
    MOVK  X2, #0xa000, LSL #32
    MOVK  X2, #0x14b4, LSL #48
    FMOV  X25, V5.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa000, LSL #0
    MOVK  X2, #0x14b4, LSL #16
    MOVK  X2, #0xa000, LSL #32
    MOVK  X2, #0x14b4, LSL #48
    FMOV  X25, D5
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5, LSL #0
    MOVK  X2, #0xa5, LSL #16
    MOVK  X2, #0xa5, LSL #32
    MOVK  X2, #0xa5, LSL #48
    FMOV  X25, V6.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5, LSL #0
    MOVK  X2, #0xa5, LSL #16
    MOVK  X2, #0xa5, LSL #32
    MOVK  X2, #0xa5, LSL #48
    FMOV  X25, D6
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V7.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, D7
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xafff, LSL #0
    MOVK  X2, #0xafff, LSL #16
    MOVK  X2, #0xafff, LSL #32
    MOVK  X2, #0xafff, LSL #48
    FMOV  X25, V8.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xafff, LSL #0
    MOVK  X2, #0xafff, LSL #16
    MOVK  X2, #0xafff, LSL #32
    MOVK  X2, #0xafff, LSL #48
    FMOV  X25, D8
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V9.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x9f00, LSL #16
    MOVK  X2, #0x9f00, LSL #48
    FMOV  X25, D9
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0xa5ba, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V10.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0xa5ba, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D10
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa6a6, LSL #0
    MOVK  X2, #0xa6a6, LSL #16
    MOVK  X2, #0xa6a6, LSL #32
    MOVK  X2, #0xa6a6, LSL #48
    FMOV  X25, V11.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa6a6, LSL #0
    MOVK  X2, #0xa6a6, LSL #16
    MOVK  X2, #0xa6a6, LSL #32
    MOVK  X2, #0xa6a6, LSL #48
    FMOV  X25, D11
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V12.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D12
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x29, LSL #0
    MOVK  X2, #0x29, LSL #32
    FMOV  X25, V13.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x29, LSL #0
    MOVK  X2, #0x29, LSL #32
    FMOV  X25, D13
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5ce, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V14.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5ce, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D14
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x294, LSL #0
    MOVK  X2, #0x294, LSL #16
    MOVK  X2, #0x294, LSL #32
    MOVK  X2, #0x294, LSL #48
    FMOV  X25, V15.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x294, LSL #0
    MOVK  X2, #0x294, LSL #16
    MOVK  X2, #0x294, LSL #32
    MOVK  X2, #0x294, LSL #48
    FMOV  X25, D15
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V16.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, D16
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x5a50, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0xa, LSL #32
    FMOV  X25, V17.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x5a50, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0xa, LSL #32
    FMOV  X25, D17
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x52d, LSL #0
    MOVK  X2, #0x52d, LSL #16
    MOVK  X2, #0x52d, LSL #32
    MOVK  X2, #0x52d, LSL #48
    FMOV  X25, V18.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x52d, LSL #0
    MOVK  X2, #0x52d, LSL #16
    MOVK  X2, #0x52d, LSL #32
    MOVK  X2, #0x52d, LSL #48
    FMOV  X25, D18
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xf877, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xf877, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V19.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xf877, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xf877, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D19
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xf877, LSL #0
    MOVK  X2, #0xf877, LSL #16
    MOVK  X2, #0xf877, LSL #32
    MOVK  X2, #0xf877, LSL #48
    FMOV  X25, V20.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xf877, LSL #0
    MOVK  X2, #0xf877, LSL #16
    MOVK  X2, #0xf877, LSL #32
    MOVK  X2, #0xf877, LSL #48
    FMOV  X25, D20
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V21.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xba5a, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xba5a, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D21
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x4b4a, LSL #0
    MOVK  X2, #0x4b4a, LSL #16
    MOVK  X2, #0x4b4a, LSL #32
    MOVK  X2, #0x4b4a, LSL #48
    FMOV  X25, V22.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x4b4a, LSL #0
    MOVK  X2, #0x4b4a, LSL #16
    MOVK  X2, #0x4b4a, LSL #32
    MOVK  X2, #0x4b4a, LSL #48
    FMOV  X25, D22
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V23.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D23
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    FMOV  X25, V24.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    FMOV  X25, D24
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V25.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a, LSL #0
    MOVK  X2, #0xa5a, LSL #16
    MOVK  X2, #0xa5a, LSL #32
    MOVK  X2, #0xa5a, LSL #48
    FMOV  X25, D25
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V26.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x101, LSL #0
    MOVK  X2, #0x101, LSL #16
    MOVK  X2, #0x101, LSL #32
    MOVK  X2, #0x101, LSL #48
    FMOV  X25, D26
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V27.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D27
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, V28.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, D28
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa7a7, LSL #0
    MOVK  X2, #0xa7a7, LSL #16
    MOVK  X2, #0xa7a7, LSL #32
    MOVK  X2, #0xa7a7, LSL #48
    FMOV  X25, V29.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa7a7, LSL #0
    MOVK  X2, #0xa7a7, LSL #16
    MOVK  X2, #0xa7a7, LSL #32
    MOVK  X2, #0xa7a7, LSL #48
    FMOV  X25, D29
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #32
    FMOV  X25, V30.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #32
    FMOV  X25, D30
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a, LSL #0
    FMOV  X25, V31.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a, LSL #0
    FMOV  X25, D31
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
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
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X29
    FMOV  D1, X24
    FMOV  V1.D[1], X28
    FMOV  D2, X6
    FMOV  V2.D[1], X20
    FMOV  D3, X7
    FMOV  V3.D[1], X26
    FMOV  D4, X19
    FMOV  V4.D[1], X12
    FMOV  D5, X23
    FMOV  V5.D[1], X26
    FMOV  D6, X14
    FMOV  V6.D[1], X11
    FMOV  D7, X29
    FMOV  V7.D[1], X29
    FMOV  D8, X17
    FMOV  V8.D[1], X19
    FMOV  D9, X17
    FMOV  V9.D[1], X17
    FMOV  D10, X23
    FMOV  V10.D[1], X28
    FMOV  D11, X8
    FMOV  V11.D[1], X9
    FMOV  D12, X7
    FMOV  V12.D[1], X10
    FMOV  D13, X23
    FMOV  V13.D[1], X19
    FMOV  D14, X24
    FMOV  V14.D[1], X21
    FMOV  D15, X11
    FMOV  V15.D[1], X21
    FMOV  D16, X24
    FMOV  V16.D[1], X7
    FMOV  D17, X18
    FMOV  V17.D[1], X19
    FMOV  D18, X24
    FMOV  V18.D[1], X20
    FMOV  D19, X14
    FMOV  V19.D[1], X8
    FMOV  D20, X21
    FMOV  V20.D[1], X11
    FMOV  D21, X21
    FMOV  V21.D[1], X7
    FMOV  D22, X13
    FMOV  V22.D[1], X18
    FMOV  D23, X18
    FMOV  V23.D[1], X16
    FMOV  D24, X16
    FMOV  V24.D[1], X20
    FMOV  D25, X18
    FMOV  V25.D[1], X16
    FMOV  D26, X16
    FMOV  V26.D[1], X26
    FMOV  D27, X26
    FMOV  V27.D[1], X9
    FMOV  D28, X12
    FMOV  V28.D[1], X21
    FMOV  D29, X17
    FMOV  V29.D[1], X11
    FMOV  D30, X20
    FMOV  V30.D[1], X16
    FMOV  D31, X14
    FMOV  V31.D[1], X14
    UXTL2 V21.8H, V24.16B
    UXTL2 V25.4S, V25.8H
    SHA1C  Q24, S29, V29.4S
    SHA1M  Q23, S28, V30.4S
    SHA1P  Q19, S18, V15.4S
    SHA1SU0  V2.4S, V27.4S, V27.4S
    SHA1SU1  V16.4S, V31.4S
    SHA256H  Q31, Q22, V26.4S
    SHA256H2  Q27, Q13, V15.4S
    SHA256SU0  V29.4S, V0.4S
    SHA256SU1  V11.4S, V9.4S, V5.4S
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X25, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x800, LSL #16
    MRS  X25, FPSR
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V0.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D0
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V1.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D1
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V2.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D2
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V3.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D3
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V4.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D4
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V5.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D5
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V6.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D6
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V7.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D7
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V8.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D8
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V9.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D9
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V10.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D10
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xd3b2, LSL #0
    MOVK  X2, #0xb196, LSL #16
    MOVK  X2, #0xd3b2, LSL #32
    MOVK  X2, #0xb196, LSL #48
    FMOV  X25, V11.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x5a59, LSL #0
    MOVK  X2, #0xb19a, LSL #16
    MOVK  X2, #0x5a59, LSL #32
    MOVK  X2, #0xb19a, LSL #48
    FMOV  X25, D11
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V12.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D12
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V13.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D13
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V14.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D14
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V15.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D15
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x4b4b, LSL #32
    MOVK  X2, #0x4b4b, LSL #48
    FMOV  X25, V16.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X25, D16
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V17.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D17
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V18.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D18
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x5a49, LSL #0
    MOVK  X2, #0xda5a, LSL #16
    MOVK  X2, #0x6968, LSL #32
    MOVK  X2, #0xe969, LSL #48
    FMOV  X25, V19.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x3377, LSL #0
    MOVK  X2, #0xbc3b, LSL #16
    MOVK  X2, #0x15da, LSL #32
    MOVK  X2, #0x1e1e, LSL #48
    FMOV  X25, D19
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V20.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D20
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5, LSL #0
    MOVK  X2, #0xa5, LSL #16
    MOVK  X2, #0xa5, LSL #32
    MOVK  X2, #0xa5, LSL #48
    FMOV  X25, V21.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5, LSL #0
    MOVK  X2, #0xa5, LSL #16
    MOVK  X2, #0xa5, LSL #32
    MOVK  X2, #0xa5, LSL #48
    FMOV  X25, D21
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V22.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D22
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x6958, LSL #0
    MOVK  X2, #0xe969, LSL #16
    MOVK  X2, #0x6968, LSL #32
    MOVK  X2, #0xe969, LSL #48
    FMOV  X25, V23.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x9d64, LSL #0
    MOVK  X2, #0x25a4, LSL #16
    MOVK  X2, #0x6127, LSL #32
    MOVK  X2, #0x6969, LSL #48
    FMOV  X25, D23
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x4837, LSL #0
    MOVK  X2, #0xc848, LSL #16
    MOVK  X2, #0x6968, LSL #32
    MOVK  X2, #0xe969, LSL #48
    FMOV  X25, V24.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x8b71, LSL #0
    MOVK  X2, #0x9392, LSL #16
    MOVK  X2, #0xd097, LSL #32
    MOVK  X2, #0xd8d8, LSL #48
    FMOV  X25, D24
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #32
    FMOV  X25, V25.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #32
    FMOV  X25, D25
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V26.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D26
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xc341, LSL #0
    MOVK  X2, #0xb7e3, LSL #16
    MOVK  X2, #0x8784, LSL #32
    MOVK  X2, #0x8787, LSL #48
    FMOV  X25, V27.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x89cb, LSL #0
    MOVK  X2, #0xd543, LSL #16
    MOVK  X2, #0x6c41, LSL #32
    MOVK  X2, #0x1781, LSL #48
    FMOV  X25, D27
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V28.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D28
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x3c3b, LSL #0
    MOVK  X2, #0xdc3c, LSL #16
    MOVK  X2, #0x3c3b, LSL #32
    MOVK  X2, #0xdc3c, LSL #48
    FMOV  X25, V29.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0x3c3b, LSL #0
    MOVK  X2, #0xdc3c, LSL #16
    MOVK  X2, #0x3c3b, LSL #32
    MOVK  X2, #0xdc3c, LSL #48
    FMOV  X25, D29
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, V30.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X25, D30
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xe06f, LSL #0
    MOVK  X2, #0xe530, LSL #16
    MOVK  X2, #0x5a56, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X25, V31.D[1]
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail
    MOVZ  X2, #0xb36f, LSL #0
    MOVK  X2, #0xb0ff, LSL #16
    MOVK  X2, #0x550b, LSL #32
    MOVK  X2, #0x90bf, LSL #48
    FMOV  X25, D31
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, DataReverseAdvsimdVectorP04_TestFail

DataReverseAdvsimdVectorP04_TestEnd:
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
DataReverseAdvsimdVectorP04_TestFail:
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
