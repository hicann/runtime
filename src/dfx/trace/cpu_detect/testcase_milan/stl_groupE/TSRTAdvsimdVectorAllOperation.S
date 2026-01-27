.global TSRTAdvsimdVectorAllOperation

.text
.p2align 4

TSRTAdvsimdVectorAllOperation:

TSRTAdvsimdVectorAllOperation_TestBegin:
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
    MOVZ  X2, #0xdc11, LSL #0
    MOVK  X2, #0x395e, LSL #16
    MOVK  X2, #0x2168, LSL #32
    MOVK  X2, #0x8c6e, LSL #48
    MOVZ  X3, #0xb5d5, LSL #0
    MOVK  X3, #0xee0b, LSL #16
    MOVK  X3, #0xc58, LSL #32
    MOVK  X3, #0xef85, LSL #48
    MOVZ  X4, #0x6e98, LSL #0
    MOVK  X4, #0x34ba, LSL #16
    MOVK  X4, #0x8024, LSL #32
    MOVK  X4, #0x8f58, LSL #48
    MOVZ  X5, #0xcb47, LSL #0
    MOVK  X5, #0x64c3, LSL #16
    MOVK  X5, #0xe702, LSL #32
    MOVK  X5, #0xd0ce, LSL #48
    MOVZ  X6, #0x7f0c, LSL #0
    MOVK  X6, #0xe0ea, LSL #16
    MOVK  X6, #0xa707, LSL #32
    MOVK  X6, #0xd40a, LSL #48
    MOVZ  X7, #0x9cf0, LSL #0
    MOVK  X7, #0xdb1a, LSL #16
    MOVK  X7, #0xed5d, LSL #32
    MOVK  X7, #0x5764, LSL #48
    MOVZ  X8, #0xcf02, LSL #0
    MOVK  X8, #0x4569, LSL #16
    MOVK  X8, #0x702b, LSL #32
    MOVK  X8, #0xe392, LSL #48
    MOVZ  X9, #0x1cba, LSL #0
    MOVK  X9, #0xcc5c, LSL #16
    MOVK  X9, #0x4023, LSL #32
    MOVK  X9, #0xd18b, LSL #48
    MOVZ  X10, #0x3c07, LSL #0
    MOVK  X10, #0x5881, LSL #16
    MOVK  X10, #0xb48b, LSL #32
    MOVK  X10, #0x700, LSL #48
    MOVZ  X12, #0xd202, LSL #0
    MOVK  X12, #0x6f43, LSL #16
    MOVK  X12, #0xbb87, LSL #32
    MOVK  X12, #0xc2e4, LSL #48
    MOVZ  X13, #0x341d, LSL #0
    MOVK  X13, #0x5cd7, LSL #16
    MOVK  X13, #0x67fb, LSL #32
    MOVK  X13, #0xc66f, LSL #48
    MOVZ  X15, #0x15fe, LSL #0
    MOVK  X15, #0x58e5, LSL #16
    MOVK  X15, #0x3a1d, LSL #32
    MOVK  X15, #0xd798, LSL #48
    MOVZ  X16, #0x314, LSL #0
    MOVK  X16, #0xc01b, LSL #16
    MOVK  X16, #0x2af7, LSL #32
    MOVK  X16, #0xca1c, LSL #48
    MOVZ  X17, #0xb4d2, LSL #0
    MOVK  X17, #0x3264, LSL #16
    MOVK  X17, #0x6ce3, LSL #32
    MOVK  X17, #0xb734, LSL #48
    MOVZ  X19, #0xae74, LSL #0
    MOVK  X19, #0x98ed, LSL #16
    MOVK  X19, #0xa052, LSL #32
    MOVK  X19, #0x1d60, LSL #48
    MOVZ  X20, #0x31ab, LSL #0
    MOVK  X20, #0x722d, LSL #16
    MOVK  X20, #0x1171, LSL #32
    MOVK  X20, #0x34ba, LSL #48
    MOVZ  X22, #0xc26a, LSL #0
    MOVK  X22, #0xb4f0, LSL #16
    MOVK  X22, #0x9275, LSL #32
    MOVK  X22, #0xebf1, LSL #48
    MOVZ  X23, #0xf810, LSL #0
    MOVK  X23, #0xea19, LSL #16
    MOVK  X23, #0x26c1, LSL #32
    MOVK  X23, #0x5d4a, LSL #48
    MOVZ  X24, #0x57f3, LSL #0
    MOVK  X24, #0xd374, LSL #16
    MOVK  X24, #0xaffe, LSL #32
    MOVK  X24, #0x9fdb, LSL #48
    MOVZ  X25, #0xec3c, LSL #0
    MOVK  X25, #0xa017, LSL #16
    MOVK  X25, #0xbd14, LSL #32
    MOVK  X25, #0x6937, LSL #48
    MOVZ  X26, #0xf49, LSL #0
    MOVK  X26, #0x5567, LSL #16
    MOVK  X26, #0x6eed, LSL #32
    MOVK  X26, #0x647d, LSL #48
    MOVZ  X27, #0x23b2, LSL #0
    MOVK  X27, #0x8ab9, LSL #16
    MOVK  X27, #0x3d2c, LSL #32
    MOVK  X27, #0xd526, LSL #48
    MOVZ  X28, #0x239e, LSL #0
    MOVK  X28, #0xe112, LSL #16
    MOVK  X28, #0xbbe0, LSL #32
    MOVK  X28, #0x2996, LSL #48
    MOVZ  X29, #0xd139, LSL #0
    MOVK  X29, #0x562c, LSL #16
    MOVK  X29, #0xa3f8, LSL #32
    MOVK  X29, #0x7774, LSL #48
    MOVZ  X22, #0x6294, LSL #0
    MOVK  X22, #0x89ba, LSL #16
    MOVK  X22, #0x1234, LSL #32
    MOVK  X22, #0xe77a, LSL #48
    MSR  FPCR, X22
    MOVZ  X22, #0xc3fc, LSL #0
    MOVK  X22, #0xe412, LSL #16
    MOVK  X22, #0x26a9, LSL #32
    MOVK  X22, #0x6e6, LSL #48
    MSR  FPSR, X22
    MRS  X23, FPSR
    MOVZ  X3, #0xff60, LSL #0
    MOVK  X3, #0x7ff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    AND  X23, X23, X3
    MOVZ  X3, #0x0, LSL #0
    ORR  X23, X23, X3
    MSR  FPSR, X23
    ISB  SY
    SUBS  X8, X4, X19
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0xdec5, LSL #0
    MOVK  X2, #0x7585, LSL #16
    MOVK  X2, #0x4b9, LSL #32
    MOVK  X2, #0xcb88, LSL #48
    MOVZ  X3, #0x9f71, LSL #0
    MOVK  X3, #0xfe4f, LSL #16
    MOVK  X3, #0xc898, LSL #32
    MOVK  X3, #0xde0f, LSL #48
    MOVZ  X4, #0x5635, LSL #0
    MOVK  X4, #0x4747, LSL #16
    MOVK  X4, #0x3cd2, LSL #32
    MOVK  X4, #0xe72b, LSL #48
    MOVZ  X5, #0xd8e5, LSL #0
    MOVK  X5, #0x5e15, LSL #16
    MOVK  X5, #0x3a45, LSL #32
    MOVK  X5, #0x4e17, LSL #48
    MOVZ  X6, #0xacc8, LSL #0
    MOVK  X6, #0x41ad, LSL #16
    MOVK  X6, #0x653e, LSL #32
    MOVK  X6, #0xef3e, LSL #48
    MOVZ  X7, #0xd743, LSL #0
    MOVK  X7, #0x2aa4, LSL #16
    MOVK  X7, #0x9dda, LSL #32
    MOVK  X7, #0x7a25, LSL #48
    MOVZ  X8, #0x1f36, LSL #0
    MOVK  X8, #0x41e6, LSL #16
    MOVK  X8, #0xa198, LSL #32
    MOVK  X8, #0x4bc2, LSL #48
    MOVZ  X9, #0x4407, LSL #0
    MOVK  X9, #0x2bf0, LSL #16
    MOVK  X9, #0xc149, LSL #32
    MOVK  X9, #0x8e21, LSL #48
    MOVZ  X10, #0xa2a9, LSL #0
    MOVK  X10, #0x8767, LSL #16
    MOVK  X10, #0x36fc, LSL #32
    MOVK  X10, #0x9ac1, LSL #48
    MOVZ  X12, #0xcb9f, LSL #0
    MOVK  X12, #0xdcf6, LSL #16
    MOVK  X12, #0xaef7, LSL #32
    MOVK  X12, #0x8fa, LSL #48
    MOVZ  X13, #0x2c4d, LSL #0
    MOVK  X13, #0xc706, LSL #16
    MOVK  X13, #0x32cd, LSL #32
    MOVK  X13, #0xdeb5, LSL #48
    MOVZ  X15, #0x2bd1, LSL #0
    MOVK  X15, #0x2daf, LSL #16
    MOVK  X15, #0xb49b, LSL #32
    MOVK  X15, #0x227c, LSL #48
    MOVZ  X16, #0x73c6, LSL #0
    MOVK  X16, #0xa1ab, LSL #16
    MOVK  X16, #0xe5bb, LSL #32
    MOVK  X16, #0x1f7b, LSL #48
    MOVZ  X17, #0x4507, LSL #0
    MOVK  X17, #0xfa0a, LSL #16
    MOVK  X17, #0x187d, LSL #32
    MOVK  X17, #0xce0a, LSL #48
    MOVZ  X19, #0x88ae, LSL #0
    MOVK  X19, #0xb9e3, LSL #16
    MOVK  X19, #0xfb9c, LSL #32
    MOVK  X19, #0x64c6, LSL #48
    MOVZ  X20, #0xdcfd, LSL #0
    MOVK  X20, #0xf1e1, LSL #16
    MOVK  X20, #0x4ea4, LSL #32
    MOVK  X20, #0xdcc3, LSL #48
    MOVZ  X22, #0xd859, LSL #0
    MOVK  X22, #0x3dd6, LSL #16
    MOVK  X22, #0x7752, LSL #32
    MOVK  X22, #0xb6a5, LSL #48
    MOVZ  X23, #0x831f, LSL #0
    MOVK  X23, #0xa4bf, LSL #16
    MOVK  X23, #0x8e78, LSL #32
    MOVK  X23, #0x5e4f, LSL #48
    MOVZ  X24, #0x1166, LSL #0
    MOVK  X24, #0xb6f1, LSL #16
    MOVK  X24, #0x3445, LSL #32
    MOVK  X24, #0xe252, LSL #48
    MOVZ  X25, #0xafbd, LSL #0
    MOVK  X25, #0x20c3, LSL #16
    MOVK  X25, #0xcdbf, LSL #32
    MOVK  X25, #0x3b5c, LSL #48
    MOVZ  X26, #0x93fd, LSL #0
    MOVK  X26, #0x425f, LSL #16
    MOVK  X26, #0x8488, LSL #32
    MOVK  X26, #0x8c45, LSL #48
    MOVZ  X27, #0x3e88, LSL #0
    MOVK  X27, #0x4baf, LSL #16
    MOVK  X27, #0x1902, LSL #32
    MOVK  X27, #0x307a, LSL #48
    MOVZ  X28, #0x555e, LSL #0
    MOVK  X28, #0xd5cc, LSL #16
    MOVK  X28, #0xdf03, LSL #32
    MOVK  X28, #0x895a, LSL #48
    MOVZ  X29, #0x60ea, LSL #0
    MOVK  X29, #0xf092, LSL #16
    MOVK  X29, #0x4a48, LSL #32
    MOVK  X29, #0xb81d, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X28
    FMOV  D1, X29
    FMOV  V1.D[1], X27
    FMOV  D2, X13
    FMOV  V2.D[1], X25
    FMOV  D3, X5
    FMOV  V3.D[1], X10
    FMOV  D4, X28
    FMOV  V4.D[1], X3
    FMOV  D5, X5
    FMOV  V5.D[1], X25
    FMOV  D6, X5
    FMOV  V6.D[1], X10
    FMOV  D7, X19
    FMOV  V7.D[1], X10
    FMOV  D8, X17
    FMOV  V8.D[1], X27
    FMOV  D9, X20
    FMOV  V9.D[1], X9
    FMOV  D10, X10
    FMOV  V10.D[1], X13
    FMOV  D11, X15
    FMOV  V11.D[1], X19
    FMOV  D12, X3
    FMOV  V12.D[1], X28
    FMOV  D13, X16
    FMOV  V13.D[1], X17
    FMOV  D14, X6
    FMOV  V14.D[1], X17
    FMOV  D15, X5
    FMOV  V15.D[1], X20
    FMOV  D16, X19
    FMOV  V16.D[1], X25
    FMOV  D17, X27
    FMOV  V17.D[1], X13
    FMOV  D18, X22
    FMOV  V18.D[1], X8
    FMOV  D19, X29
    FMOV  V19.D[1], X25
    FMOV  D20, X16
    FMOV  V20.D[1], X26
    FMOV  D21, X3
    FMOV  V21.D[1], X9
    FMOV  D22, X13
    FMOV  V22.D[1], X27
    FMOV  D23, X6
    FMOV  V23.D[1], X29
    FMOV  D24, X13
    FMOV  V24.D[1], X10
    FMOV  D25, X9
    FMOV  V25.D[1], X13
    FMOV  D26, X26
    FMOV  V26.D[1], X13
    FMOV  D27, X9
    FMOV  V27.D[1], X2
    FMOV  D28, X29
    FMOV  V28.D[1], X26
    FMOV  D29, X12
    FMOV  V29.D[1], X13
    FMOV  D30, X10
    FMOV  V30.D[1], X23
    FMOV  D31, X27
    FMOV  V31.D[1], X7
    MOVZ  X4, #0xa, LSL #0
TSRTAdvsimdVectorAllOperation_label_0:
    BIC  V5.8B, V27.8B, V26.8B
    FDIV  V21.4H, V21.4H, V24.4H
    FRSQRTS  V2.4H, V21.4H, V25.4H
    DUP  V29.2S, V30.S[0x2]
    UQSHRN V29.2S, V28.2D, #29
    RSHRN V13.8B, V29.8H, #1
    FABS  V14.8H, V5.8H
    UMAX  V22.2S, V14.2S, V22.2S
    FCVTZU  V25.2D, V31.2D
    UMLAL2  V9.4S, V25.8H, V13.8H
    FCMEQ  V6.4H, V9.4H, V9.4H
    SXTL V11.8H, V23.8B
    SQSHL  V10.8H, V22.8H, #0x4
    FADDP  V31.8H, V2.8H, V11.8H
    UCVTF V2.2D, V31.2D, #26
    ADD  V7.4S, V2.4S, V2.4S
    FMINNMP D2, V7.2D
    SHLL2  V7.8H, V2.16B, #8
    UQSHL V26.2D, V6.2D, #0x36
    SHL V20.2D, V10.2D, #0x3b
    SQRSHRUN2 V5.8H, V7.4S, #5
    SSUBL  V24.2D, V5.2S, V26.2S
    UQRSHRN V10.2S, V28.2D, #10
    SLI  V31.4H, V20.4H, #0x4
    SMAX  V20.4H, V31.4H, V0.4H
    UADDW2  V7.8H, V10.8H, V20.16B
    SRI  V0.4S, V7.4S, #31
    FMAXNMP  V14.8H, V0.8H, V0.8H
    SRI V25.2D, V24.2D, #52
    FRINTA  V11.2S, V14.2S
    UQSHL V0.2D, V25.2D, #0xa
    SMLAL V24.4S, V11.4H, V11.H[0x4]
    MOVI  V26.4S, #0x58, LSL #24
    TRN2  V11.4S, V24.4S, V26.4S
    SLI  V29.4S, V0.4S, #0x15
    FCVTAU  V24.2D, V29.2D
    SRHADD  V26.4H, V27.4H, V11.4H
    NOT  V2.8B, V26.8B
    UABAL  V29.8H, V2.8B, V2.8B
    FMINP  V28.4S, V29.4S, V24.4S
    SQDMULH  V27.8H, V16.8H, V5.H[0x0]
    ADDP  V14.8H, V14.8H, V10.8H
    SMINV  S31, V7.4S
    SSHLL2 V24.2D, V1.4S, #0x14
    FABS  V20.8H, V21.8H
    SABAL2  V26.2D, V26.4S, V10.4S
    SXTL V7.8H, V20.8B
    SMLSL  V20.8H, V9.8B, V25.8B
    MOVI  V9.2D, #18446463698244468735
    FACGE  V2.8H, V31.8H, V28.8H
    SMINV  B0, V27.16B
    FRINTM  V28.8H, V0.8H
    SABA  V20.16B, V14.16B, V2.16B
    URSHR  V5.8B, V28.8B, #4
    UQSHL  V10.8H, V5.8H, V26.8H
    DUP V14.16B, W2
    REV16  V11.16B, V10.16B
    FMAXP D27, V7.2D
    UHADD  V21.4H, V7.4H, V20.4H
    FRINTX  V1.4S, V22.4S
    FRINTI  V10.4H, V14.4H
    FMAXP D0, V11.2D
    FABS  V25.2S, V10.2S
    FACGT  V20.4H, V1.4H, V21.4H
    SMLSL2 V31.2D, V27.4S, V20.S[0x2]
    PMULL  V22.1Q, V9.1D, V24.1D
    CMEQ  V9.4S, V31.4S, #0
    SHSUB  V16.4S, V9.4S, V0.4S
    FMLS S27, S16, V25.S[0x3]
    USHLL2 V11.8H, V27.16B, #0x7
    FMAXP  V19.4H, V11.4H, V22.4H
    FMLA  V27.8H, V7.8H, V0.8H
    SQSHRN2 V1.8H, V25.4S, #15
    SMLAL V10.4S, V8.4H, V8.H[0x1]
    MOV V14.S[0x2], W27
    FMINV  S7, V22.4S
    INS V16.S[0x0], V23.S[0x1]
    SABAL  V0.8H, V1.8B, V27.8B
    SHSUB  V23.16B, V9.16B, V11.16B
    FMLS V9.4S, V11.4S, V19.S[0x2]
    UADALP  V27.8H, V12.16B
    FCVTZS  V8.4H, V6.4H
    SQRSHRN2 V22.4S, V14.2D, #18
    FMLA S14, S22, V10.S[0x2]
    MOV  V1.16B, V16.16B
    SQSHLU  V12.8B, V0.8B, #0x1
    UADDLV  H31, V7.16B
    UXTL V7.2D, V27.2S
    MOV V25.B[0x6], V31.B[0xb]
    UQSHL  V22.8B, V17.8B, V12.8B
    SHA1C  Q31, S7, V9.4S
    FRINTM  V21.8H, V1.8H
    FCMLT  V9.4S, V22.4S, #0.0
    SQRSHRUN2 V10.4S, V8.2D, #12
    SABAL2  V27.2D, V31.4S, V10.4S
    SHRN V16.8B, V23.8H, #3
    UMOV W15, V14.B[0x7]
    UABD  V0.2S, V25.2S, V1.2S
    SQDMLSL V14.2D, V0.2S, V21.S[0x3]
    UMULL V10.2D, V9.2S, V9.S[0x1]
    SMOV  X12, V27.B[0xf]
    SMLAL2 V19.2D, V16.4S, V16.S[0x2]
    FMAXP H25, V19.2H
    FCMEQ  V12.2S, V14.2S, V14.2S
    MOVI  V1.2D, #18374687579183251455
    INS V8.B[0xb], V25.B[0x3]
    FRINTP  V31.2S, V8.2S
    FMLS V6.4H, V1.4H, V1.H[0x2]
    USHR  V23.2S, V12.2S, #2
    TBL  V9.16B, { V1.16B, V2.16B, V3.16B }, V16.16B
    SXTL V17.2D, V10.2S
    FMINP  V22.2S, V4.2S, V6.2S
    SCVTF  V21.2S, V17.2S, #19
    SQSHRUN2 V27.16B, V21.8H, #2
    SADDW2  V0.8H, V9.8H, V31.16B
    FMINV  S25, V27.4S
    UMLSL2 V27.4S, V25.8H, V0.H[0x2]
    UQSHL  V2.4H, V27.4H, #0xa
    SQDMLAL S27, H2, V0.H[0x0]
    UMLSL2  V17.8H, V27.16B, V27.16B
    SQSHL  V3.8B, V23.8B, #0x0
    FADDP  V6.4H, V17.4H, V3.4H
    MOV V3.D[0x0], V6.D[0x0]
    DUP D0, V3.D[0x1]
    SABAL  V23.8H, V22.8B, V0.8B
    FMAXP D3, V4.2D
    FRSQRTE  V10.8H, V31.8H
    FCVTZS  V8.4S, V4.4S, #11
    USRA  V22.4H, V1.4H, #8
    FRINTZ  V6.2D, V22.2D
    UADDLP  V1.4H, V5.8B
    UMINV  B25, V24.16B
    SMLSL V9.2D, V23.2S, V23.S[0x2]
    FMINNMV  S22, V12.4S
    UMINP  V12.4S, V10.4S, V8.4S
    SHA1SU0  V10.4S, V12.4S, V3.4S
    PMULL2  V5.8H, V17.16B, V30.16B
    SADDW2  V27.8H, V18.8H, V27.16B
    FNEG  V2.2D, V3.2D
    FCVTL2  V3.4S, V6.8H
    UMULL2 V4.2D, V22.4S, V1.S[0x1]
    SQSHL  V0.8B, V4.8B, #0x1
    USHLL V24.4S, V3.4H, #0x4
    SMULL  V23.4S, V25.4H, V9.4H
    DUP  V30.2S, V21.S[0x1]
    SMINV  B6, V2.8B
    FRECPS  V3.8H, V10.8H, V2.8H
    SABD  V18.8H, V5.8H, V5.8H
    SRSRA  V21.16B, V3.16B, #5
    UQSHL  V1.16B, V30.16B, #0x1
    SQXTN2  V3.4S, V24.2D
    RSHRN V25.4H, V3.4S, #11
    CMHI  V31.2S, V6.2S, V27.2S
    FMAXP D10, V18.2D
    FDIV  V27.4H, V10.4H, V25.4H
    SADDW  V17.4S, V0.4S, V27.4H
    FCVTPU  V27.2D, V23.2D
    FMAXNMP D24, V21.2D
    UQSHRN V21.2S, V27.2D, #29
    FMAXNMP D27, V31.2D
    UADDLV  H6, V21.16B
    FMAXNMP  V3.4H, V24.4H, V24.4H
    SMOV  X12, V3.B[0x3]
    UMLAL  V24.4S, V1.4H, V27.4H
    UXTL2 V4.2D, V24.4S
    UMLAL  V2.8H, V4.8B, V4.8B
    FMINP S10, V6.2S
    TRN2  V27.16B, V2.16B, V8.16B
    FCVTN  V31.4H, V17.4S
    FACGE  V0.4H, V21.4H, V10.4H
    RSHRN V18.4H, V27.4S, #15
    USHR  V27.2S, V0.2S, #8
    URSHR V17.2D, V27.2D, #50
    SSRA  V30.16B, V31.16B, #4
    SABD  V3.8B, V22.8B, V18.8B
    SADDW2  V22.8H, V30.8H, V3.16B
    FCVTL2  V3.4S, V17.8H
    UADDLP  V8.2D, V22.4S
    SQRSHRUN2 V6.16B, V8.8H, #1
    RSHRN V27.2S, V3.2D, #30
    RSUBHN2  V30.16B, V6.8H, V27.8H
    FMLS V23.2S, V12.2S, V9.S[0x3]
    SCVTF  V6.4S, V27.4S, #19
    SHRN2 V10.4S, V22.2D, #20
    INS V1.H[0x7], W9
    UABDL2  V8.4S, V4.8H, V25.8H
    MOV  X26, V4.D[0x0]
    FMAXNMV  S24, V6.4S
    SQDMLAL S31, H7, V9.H[0x7]
    SMAXV  B17, V26.16B
    UQRSHRN2 V7.8H, V8.4S, #12
    SHA256SU0  V0.4S, V15.4S
    FCVTZU  V22.8H, V23.8H
    MUL  V4.4H, V22.4H, V10.H[0x3]
    SQXTN  V8.8B, V2.8H
    FABD  V10.8H, V17.8H, V7.8H
    FMAX  V9.8H, V8.8H, V31.8H
    FMAX  V18.8H, V24.8H, V1.8H
    FRINTM  V21.4H, V10.4H
    TRN1  V12.4H, V21.4H, V21.4H
    FCVTZU V25.2D, V26.2D, #38
    FCMEQ  V6.2S, V4.2S, V0.2S
    SABAL  V10.4S, V18.4H, V30.4H
    SMLSL V21.2D, V3.2S, V9.S[0x0]
    SSHL  V15.2S, V21.2S, V21.2S
    SHL V23.2D, V15.2D, #0xb
    FMULX  V21.4H, V12.4H, V18.4H
    SQSHRUN2 V27.16B, V21.8H, #1
    PMULL2  V4.1Q, V25.2D, V27.2D
    FMAXNMP  V17.4H, V6.4H, V6.4H
    SCVTF  V26.8H, V10.8H
    UXTL2 V0.4S, V23.8H
    ADDV  S12, V4.4S
    SADDW2  V18.4S, V17.4S, V29.8H
    FMAXP H9, V26.2H
    MOV  W3, V12.S[0x2]
    FMAXNMP H3, V0.2H
    SMLAL2  V30.8H, V18.16B, V3.16B
    MVNI  V6.8H, #0xce
    ADDV  B15, V30.8B
    FMLA V23.2D, V15.2D, V6.D[0x1]
    SHA1SU0  V0.4S, V18.4S, V23.4S
    MOV S3, V0.S[0x3]
    SQSHRUN V6.8B, V3.8H, #2
    SHLL  V0.8H, V22.8B, #8
    SSHLL2 V10.4S, V19.8H, #0x5
    UMOV W16, V6.S[0x2]
    PMULL  V4.1Q, V9.1D, V5.1D
    FMINNMP D29, V0.2D
    SHL  V18.8B, V29.8B, #0x2
    RSHRN2 V3.4S, V18.2D, #18
    SRSHL  V26.2D, V26.2D, V4.2D
    INS V17.H[0x7], V10.H[0x2]
    SABAL  V23.2D, V24.2S, V17.2S
    FDIV  V19.4S, V23.4S, V26.4S
    DUP V15.2D, V3.D[0x1]
    CMLE  V12.2D, V15.2D, #0
    UZP2  V26.8H, V19.8H, V12.8H
    ORR  V0.8H, #0x42
    SMIN  V24.8B, V18.8B, V10.8B
    UMINV  S6, V1.4S
    FMOV  V22.4S, #-2.87500000
    UMAXP  V19.4S, V8.4S, V13.4S
    FCMGT  V4.4H, V11.4H, V18.4H
    AESD  V8.16B, V10.16B
    FRSQRTE  V30.8H, V29.8H
    FNEG  V17.2S, V4.2S
    FMINNMV  H3, V8.4H
    SQRSHRUN2 V11.16B, V0.8H, #2
    SUB  V10.4H, V11.4H, V22.4H
    USHLL V13.2D, V30.2S, #0xc
    INS V23.S[0x3], W25
    FABD  V18.2S, V26.2S, V24.2S
    FRINTX  V0.4S, V19.4S
    SMAXP  V1.4S, V6.4S, V3.4S
    FMLA V6.2S, V31.2S, V0.S[0x2]
    SMULL V30.4S, V1.4H, V1.H[0x5]
    SRSHR V4.2D, V23.2D, #14
    MOV S29, V6.S[0x3]
    AESE  V19.16B, V4.16B
    INS V0.H[0x7], W8
    UQSHL  V3.4H, V13.4H, #0xb
    SQRDMULH H31, H30, V10.H[0x0]
    SSHLL V4.2D, V31.2S, #0x19
    SMOV W13, V18.B[0x6]
    SQDMLSL2 V6.2D, V4.4S, V17.S[0x0]
    SSRA  V23.16B, V19.16B, #4
    FMLS D11, D23, V0.D[0x0]
    UABAL  V26.8H, V11.8B, V30.8B
    UMLSL2 V24.4S, V26.8H, V3.H[0x2]
    SSUBL2  V30.4S, V24.8H, V6.8H
    FRSQRTS  V13.2S, V30.2S, V30.2S
    UQSHL  V10.4S, V29.4S, #0x17
    UQSHL  V17.2D, V3.2D, V24.2D
    MOV D0, V17.D[0x1]
    SABA  V31.2S, V0.2S, V4.2S
    SMULL V24.4S, V31.4H, V4.H[0x2]
    SQDMULH S3, S13, V10.S[0x0]
    FMLS V13.2D, V3.2D, V24.D[0x1]
    BIT  V10.16B, V30.16B, V2.16B
    SCVTF V19.2D, V6.2D, #38
    URSRA  V23.2S, V2.2S, #12
    REV64  V6.8B, V14.8B
    USUBW2  V18.2D, V5.2D, V17.4S
    TRN2  V30.8B, V14.8B, V15.8B
    SSHLL V29.2D, V5.2S, #0x18
    FRSQRTS  V17.4H, V18.4H, V6.4H
    MOV V27.S[0x3], W13
    SQDMULH  V24.4S, V30.4S, V16.S[0x3]
    FMIN  V4.2S, V4.2S, V6.2S
    SHA1M  Q3, S17, V13.4S
    DUP H15, V29.H[0x4]
    CNT  V11.16B, V10.16B
    FRINTI  V5.8H, V11.8H
    UXTL V10.2D, V27.2S
    FSUB  V18.4H, V4.4H, V23.4H
    FMAXNM  V29.8H, V19.8H, V3.8H
    FCVTZS  V14.8H, V24.8H, #5
    FMINNM  V0.8H, V10.8H, V14.8H
    SCVTF  V26.4H, V0.4H, #15
    SUBS  X4, X4, #0x1
    B.NE  TSRTAdvsimdVectorAllOperation_label_0
    MOVZ  X24, #0xdec5, LSL #0
    MOVK  X24, #0x7585, LSL #16
    MOVK  X24, #0x4b9, LSL #32
    MOVK  X24, #0xcb88, LSL #48
    SUB  X10, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X10, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X10, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xd8e5, LSL #0
    MOVK  X24, #0x5e15, LSL #16
    MOVK  X24, #0x3a45, LSL #32
    MOVK  X24, #0x4e17, LSL #48
    SUB  X10, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xacc8, LSL #0
    MOVK  X24, #0x41ad, LSL #16
    MOVK  X24, #0x653e, LSL #32
    MOVK  X24, #0xef3e, LSL #48
    SUB  X10, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xd743, LSL #0
    MOVK  X24, #0x2aa4, LSL #16
    MOVK  X24, #0x9dda, LSL #32
    MOVK  X24, #0x7a25, LSL #48
    SUB  X10, X24, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x1f36, LSL #0
    MOVK  X24, #0x41e6, LSL #16
    MOVK  X24, #0xa198, LSL #32
    MOVK  X24, #0x4bc2, LSL #48
    SUB  X10, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x4407, LSL #0
    MOVK  X24, #0x2bf0, LSL #16
    MOVK  X24, #0xc149, LSL #32
    MOVK  X24, #0x8e21, LSL #48
    SUB  X10, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X10, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffc0, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X10, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X10, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X10, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x4507, LSL #0
    MOVK  X24, #0xfa0a, LSL #16
    MOVK  X24, #0x187d, LSL #32
    MOVK  X24, #0xce0a, LSL #48
    SUB  X10, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x88ae, LSL #0
    MOVK  X24, #0xb9e3, LSL #16
    MOVK  X24, #0xfb9c, LSL #32
    MOVK  X24, #0x64c6, LSL #48
    SUB  X10, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xd859, LSL #0
    MOVK  X24, #0x3dd6, LSL #16
    MOVK  X24, #0x7752, LSL #32
    MOVK  X24, #0xb6a5, LSL #48
    SUB  X10, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x831f, LSL #0
    MOVK  X24, #0xa4bf, LSL #16
    MOVK  X24, #0x8e78, LSL #32
    MOVK  X24, #0x5e4f, LSL #48
    SUB  X10, X24, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xafbd, LSL #0
    MOVK  X24, #0x20c3, LSL #16
    MOVK  X24, #0xcdbf, LSL #32
    MOVK  X24, #0x3b5c, LSL #48
    SUB  X10, X24, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X10, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x3e88, LSL #0
    MOVK  X24, #0x4baf, LSL #16
    MOVK  X24, #0x1902, LSL #32
    MOVK  X24, #0x307a, LSL #48
    SUB  X10, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x555e, LSL #0
    MOVK  X24, #0xd5cc, LSL #16
    MOVK  X24, #0xdf03, LSL #32
    MOVK  X24, #0x895a, LSL #48
    SUB  X10, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x60ea, LSL #0
    MOVK  X24, #0xf092, LSL #16
    MOVK  X24, #0x4a48, LSL #32
    MOVK  X24, #0xb81d, LSL #48
    SUB  X10, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x97, LSL #0
    MOVK  X24, #0x800, LSL #16
    MRS  X10, FPSR
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V0.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, D0
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x3a52, LSL #0
    FMOV  X10, V1.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, D1
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x8000, LSL #48
    FMOV  X10, V2.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x8000, LSL #48
    FMOV  X10, D2
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xeffd, LSL #0
    MOVK  X24, #0xfff1, LSL #16
    MOVK  X24, #0xf7f, LSL #32
    MOVK  X24, #0xef80, LSL #48
    FMOV  X10, V3.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xef76, LSL #0
    MOVK  X24, #0x8e7f, LSL #16
    MOVK  X24, #0xfeff, LSL #32
    MOVK  X24, #0xf8f7, LSL #48
    FMOV  X10, D3
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V4.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xe031, LSL #32
    MOVK  X24, #0xd245, LSL #48
    FMOV  X10, D4
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V5.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, D5
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V6.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x100, LSL #16
    MOVK  X24, #0xe031, LSL #32
    MOVK  X24, #0xd245, LSL #48
    FMOV  X10, D6
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V7.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x1fd, LSL #0
    MOVK  X24, #0x81fd, LSL #16
    FMOV  X10, D7
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x5252, LSL #0
    MOVK  X24, #0x5252, LSL #16
    MOVK  X24, #0x5252, LSL #32
    MOVK  X24, #0x3a52, LSL #48
    FMOV  X10, V8.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x5252, LSL #0
    MOVK  X24, #0x3a52, LSL #16
    MOVK  X24, #0x5252, LSL #32
    MOVK  X24, #0x5252, LSL #48
    FMOV  X10, D8
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V9.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, D9
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V10.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, D10
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x100, LSL #48
    FMOV  X10, V11.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, D11
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    FMOV  X10, V12.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    FMOV  X10, D12
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x8000, LSL #48
    FMOV  X10, V13.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0x7fff, LSL #16
    MOVK  X24, #0x3fc0, LSL #48
    FMOV  X10, D13
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V14.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, D14
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V15.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, D15
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V16.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    FMOV  X10, D16
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V17.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x3e00, LSL #0
    MOVK  X24, #0x3e00, LSL #16
    MOVK  X24, #0x3e00, LSL #32
    MOVK  X24, #0x3e00, LSL #48
    FMOV  X10, D17
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V18.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x8606, LSL #0
    MOVK  X24, #0x86fb, LSL #16
    MOVK  X24, #0xe032, LSL #32
    MOVK  X24, #0x7e0e, LSL #48
    FMOV  X10, D18
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V19.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x80c0, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0x3f8f, LSL #48
    FMOV  X10, D19
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V20.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #48
    FMOV  X10, D20
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V21.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, D21
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xc038, LSL #16
    MOVK  X24, #0xc038, LSL #48
    FMOV  X10, V22.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xc038, LSL #16
    MOVK  X24, #0xc038, LSL #48
    FMOV  X10, D22
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V23.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x606, LSL #0
    MOVK  X24, #0x6fb, LSL #16
    MOVK  X24, #0x606, LSL #32
    MOVK  X24, #0x7c0e, LSL #48
    FMOV  X10, D23
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V24.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, D24
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V25.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, D25
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V26.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, D26
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xffc0, LSL #32
    MOVK  X24, #0xffff, LSL #48
    FMOV  X10, V27.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, D27
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V28.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, D28
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xf7f, LSL #32
    FMOV  X10, V29.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x8000, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0x3f8f, LSL #48
    FMOV  X10, D29
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V30.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x45, LSL #0
    MOVK  X24, #0x31, LSL #16
    FMOV  X10, D30
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V31.D[1]
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, D31
    SUB  X20, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
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
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X20
    FMOV  V0.D[1], X23
    FMOV  D1, X12
    FMOV  V1.D[1], X25
    FMOV  D2, X17
    FMOV  V2.D[1], X19
    FMOV  D3, X24
    FMOV  V3.D[1], X26
    FMOV  D4, X22
    FMOV  V4.D[1], X27
    FMOV  D5, X29
    FMOV  V5.D[1], X28
    FMOV  D6, X23
    FMOV  V6.D[1], X25
    FMOV  D7, X22
    FMOV  V7.D[1], X19
    FMOV  D8, X10
    FMOV  V8.D[1], X3
    FMOV  D9, X26
    FMOV  V9.D[1], X29
    FMOV  D10, X3
    FMOV  V10.D[1], X27
    FMOV  D11, X3
    FMOV  V11.D[1], X12
    FMOV  D12, X10
    FMOV  V12.D[1], X10
    FMOV  D13, X3
    FMOV  V13.D[1], X26
    FMOV  D14, X13
    FMOV  V14.D[1], X22
    FMOV  D15, X4
    FMOV  V15.D[1], X8
    FMOV  D16, X2
    FMOV  V16.D[1], X22
    FMOV  D17, X16
    FMOV  V17.D[1], X6
    FMOV  D18, X25
    FMOV  V18.D[1], X27
    FMOV  D19, X20
    FMOV  V19.D[1], X9
    FMOV  D20, X6
    FMOV  V20.D[1], X10
    FMOV  D21, X24
    FMOV  V21.D[1], X3
    FMOV  D22, X15
    FMOV  V22.D[1], X2
    FMOV  D23, X27
    FMOV  V23.D[1], X9
    FMOV  D24, X29
    FMOV  V24.D[1], X5
    FMOV  D25, X27
    FMOV  V25.D[1], X4
    FMOV  D26, X28
    FMOV  V26.D[1], X5
    FMOV  D27, X17
    FMOV  V27.D[1], X22
    FMOV  D28, X26
    FMOV  V28.D[1], X6
    FMOV  D29, X27
    FMOV  V29.D[1], X23
    FMOV  D30, X17
    FMOV  V30.D[1], X19
    FMOV  D31, X13
    FMOV  V31.D[1], X3
    MOVZ  X4, #0xa, LSL #0
TSRTAdvsimdVectorAllOperation_label_1:
    SHA256SU0  V22.4S, V23.4S
    SQRSHRN2 V24.16B, V25.8H, #5
    FMLS S30, S29, V27.S[0x2]
    ADD  V11.4S, V20.4S, V31.4S
    SQDMLAL2 V10.2D, V26.4S, V22.S[0x0]
    SQADD  V15.8H, V24.8H, V24.8H
    ZIP1  V2.2S, V28.2S, V15.2S
    UXTL2 V30.4S, V30.8H
    FCMLE  V15.8H, V2.8H, #0.0
    FRINTP  V15.4H, V10.4H
    USHLL2 V0.2D, V4.4S, #0x9
    MLA  V7.4H, V11.4H, V11.H[0x1]
    RSHRN V23.4H, V15.4S, #14
    FMINNM  V3.8H, V23.8H, V30.8H
    FRINTM  V27.2S, V7.2S
    INS V7.H[0x4], V27.H[0x2]
    USHL  V25.4H, V7.4H, V3.4H
    SQDMLAL2  V31.2D, V0.4S, V0.4S
    RSUBHN  V2.8B, V25.8H, V31.8H
    UABAL  V13.8H, V12.8B, V12.8B
    SSRA  V4.2S, V21.2S, #28
    URSHL  V10.8B, V26.8B, V22.8B
    SHA1P  Q25, S15, V27.4S
    DUP V15.2D, V18.D[0x0]
    FMULX V26.2D, V27.2D, V19.D[0x1]
    FRINTZ  V29.2D, V21.2D
    SMLAL V20.4S, V5.4H, V1.H[0x7]
    SQDMULL2  V18.4S, V20.8H, V20.8H
    UMULL V21.4S, V19.4H, V10.H[0x2]
    CMEQ  V23.8B, V18.8B, #0
    UQSHRN V24.8B, V23.8H, #5
    SSHLL V27.8H, V15.8B, #0x4
    FMLS  V22.4S, V2.4S, V27.4S
    MOV  V18.16B, V13.16B
    SMLSL V27.2D, V4.2S, V18.S[0x3]
    SQSHL  V20.4S, V22.4S, #0xf
    FMINP  V22.4S, V25.4S, V20.4S
    FRINTM  V12.4S, V26.4S
    EXT  V4.16B, V4.16B, V28.16B, #0xb
    SQRDMULH H19, H7, V13.H[0x1]
    FMULX V20.8H, V29.8H, V12.H[0x7]
    DUP V28.2D, X29
    SRI  V29.4H, V27.4H, #6
    UMOV W17, V29.S[0x1]
    SQSHL  V23.2S, V24.2S, V24.2S
    CLZ  V12.8B, V4.8B
    INS V31.H[0x3], W26
    SQRDMULH H4, H21, V12.H[0x2]
    SMAXV  S27, V4.4S
    URSRA  V12.8B, V23.8B, #3
    MOVI  V26.4S, #0x2
    FCMGE  V7.4H, V28.4H, V27.4H
    UMULL2 V2.2D, V7.4S, V7.S[0x0]
    SQDMULL  V4.4S, V2.4H, V26.4H
    USHR  V27.8H, V12.8H, #2
    URSHR  V23.2S, V27.2S, #15
    MOV V26.S[0x3], W5
    SSRA  V13.2S, V31.2S, #9
    SSHLL2 V31.8H, V4.16B, #0x6
    BIC  V21.4H, #0x18, LSL #8
    USQADD  V18.2D, V19.2D
    FMINNM  V15.2D, V31.2D, V31.2D
    MUL  V24.4S, V23.4S, V15.S[0x1]
    FMUL  V31.2S, V26.2S, V24.2S
    UMLSL V7.2D, V31.2S, V13.S[0x3]
    FRSQRTS  V4.4H, V7.4H, V7.4H
    XTN2  V15.8H, V18.4S
    FCVTZU  V19.2S, V4.2S, #3
    FMLA D31, D15, V15.D[0x0]
    USRA  V26.8B, V21.8B, #8
    FRINTM  V15.8H, V26.8H
    SADDW2  V23.2D, V15.2D, V7.4S
    SSHLL2 V21.8H, V19.16B, #0x4
    SADDLV  S4, V31.4H
    FCVTXN  V12.2S, V4.2D
    USUBW  V15.2D, V23.2D, V21.2S
    SQDMLAL V24.4S, V28.4H, V15.H[0x7]
    FCMEQ  V28.8H, V24.8H, V12.8H
    FMUL V13.4S, V13.4S, V29.S[0x1]
    SUBHN  V2.4H, V17.4S, V19.4S
    SMLSL V18.2D, V6.2S, V26.S[0x1]
    FMLS  V26.4H, V29.4H, V9.4H
    FCVTXN2  V31.4S, V25.2D
    FADD  V25.2S, V22.2S, V14.2S
    UMOV W9, V20.H[0x1]
    FSQRT  V7.4H, V8.4H
    MOV  W20, V26.S[0x3]
    FMINNM  V9.4S, V7.4S, V18.4S
    FCVTNS  V18.4H, V13.4H
    FCMLE  V19.8H, V25.8H, #0.0
    USHL  V24.8H, V1.8H, V29.8H
    SQSHLU  V1.8B, V31.8B, #0x1
    INS V17.B[0x8], W17
    FMLA  V22.2D, V25.2D, V0.2D
    FMAXNM  V14.4H, V2.4H, V28.4H
    FRSQRTS  V25.8H, V1.8H, V24.8H
    USHLL2 V29.8H, V9.16B, #0x1
    USHLL2 V7.4S, V18.8H, #0xd
    FCVTN2  V20.8H, V19.4S
    FMAXNM  V0.2D, V20.2D, V17.2D
    RSHRN2 V26.16B, V14.8H, #7
    USQADD  V31.2D, V0.2D
    SQSHLU  V0.8H, V28.8H, #0x3
    SMULL2 V13.4S, V0.8H, V15.H[0x4]
    URECPE  V2.4S, V13.4S
    SHA1SU0  V24.4S, V31.4S, V22.4S
    SMLAL2 V13.2D, V25.4S, V24.S[0x3]
    SMINP  V28.16B, V0.16B, V13.16B
    INS V25.S[0x0], W24
    FMULX H17, H28, V7.H[0x3]
    FCMEQ  V19.2S, V25.2S, #0.0
    MLS  V13.4S, V17.4S, V2.S[0x3]
    SUBHN2  V31.4S, V29.2D, V13.2D
    FMINV  H14, V14.8H
    FMLA  V22.8H, V19.8H, V19.8H
    SSHL  V8.8B, V26.8B, V22.8B
    SXTL2 V18.2D, V31.4S
    SMULL2  V29.4S, V8.8H, V8.8H
    UQSHL  V15.8B, V14.8B, V29.8B
    UQRSHL  V26.16B, V15.16B, V18.16B
    FCVTZS  V19.4H, V10.4H
    UMAXV  B10, V7.16B
    SMAXV  B13, V14.16B
    UMLAL2 V22.2D, V11.4S, V21.S[0x2]
    RSHRN V17.2S, V23.2D, #3
    MLA  V21.4H, V31.4H, V13.H[0x1]
    MVNI  V8.2S, #0x76, LSL #16
    SSUBW2  V7.8H, V21.8H, V26.16B
    EOR  V28.8B, V22.8B, V9.8B
    FMUL V23.8H, V16.8H, V2.H[0x3]
    FRINTI  V29.4S, V21.4S
    SADDLV  H21, V14.16B
    SLI  V16.8H, V17.8H, #0x7
    NEG  V13.2S, V21.2S
    UADDLV  S31, V14.4H
    SHRN2 V15.4S, V29.2D, #32
    DUP V17.2S, W5
    UMULL2 V18.4S, V19.8H, V15.H[0x1]
    UQRSHRN2 V19.8H, V16.4S, #12
    UMAXP  V26.4H, V13.4H, V7.4H
    SSHR  V2.16B, V23.16B, #3
    SHL  V22.4S, V10.4S, #0xc
    FCVTXN  V24.2S, V31.2D
    SHLL2  V9.2D, V22.4S, #32
    SRSRA V22.2D, V8.2D, #47
    FMLA  V8.2S, V26.2S, V24.2S
    UMULL2  V11.2D, V8.4S, V18.4S
    CMGE  V18.2S, V14.2S, V22.2S
    SXTL V8.2D, V19.2S
    FCMGE  V15.2S, V9.2S, V17.2S
    URSRA  V23.2S, V18.2S, #25
    SQSHL  V24.8B, V8.8B, V8.8B
    SXTL V8.4S, V2.4H
    FABS  V26.8H, V8.8H
    FMAXP  V8.2S, V24.2S, V28.2S
    CNT  V17.16B, V11.16B
    SQRSHRUN V9.4H, V17.4S, #8
    SSHLL V22.4S, V2.4H, #0x6
    TRN2  V18.16B, V15.16B, V26.16B
    SHA1SU1  V19.4S, V18.4S
    SQDMLAL V28.4S, V8.4H, V0.H[0x2]
    CNT  V24.16B, V23.16B
    FRINTN  V14.2D, V9.2D
    UQSHRN V18.2S, V22.2D, #1
    FSUB  V11.2S, V28.2S, V19.2S
    UQRSHRN2 V22.8H, V18.4S, #9
    SADDL2  V9.8H, V24.16B, V3.16B
    FMLA  V16.2S, V9.2S, V9.2S
    UMINV  H17, V16.8H
    FMUL H16, H14, V14.H[0x3]
    UCVTF  V31.4H, V11.4H
    CMTST  V15.4S, V17.4S, V31.4S
    FADDP H24, V22.2H
    FCVTZU  V8.4S, V24.4S
    SXTL V9.4S, V16.4H
    SADDL2  V22.8H, V9.16B, V15.16B
    UADDLV  D30, V22.4S
    RSHRN V26.2S, V8.2D, #27
    FACGT  V18.8H, V30.8H, V30.8H
    SQDMLSL V24.4S, V18.4H, V5.H[0x3]
    FMINV  H30, V24.8H
    AESIMC  V31.16B, V30.16B
    MOVI  V15.16B, #0x59
    FRECPS  V5.2D, V26.2D, V26.2D
    FCVTL  V2.2D, V5.2S
    ADDP  V17.16B, V2.16B, V15.16B
    USHLL2 V8.8H, V17.16B, #0x2
    TBL  V5.16B, { V18.16B }, V31.16B
    DUP V11.16B, W20
    URSQRTE  V17.4S, V8.4S
    SMAX  V16.4S, V17.4S, V5.4S
    SMLSL2  V2.8H, V16.16B, V16.16B
    UQSHL  V9.4S, V2.4S, #0x13
    SXTL2 V5.4S, V9.8H
    SLI V19.2D, V11.2D, #0x1c
    FRINTI  V24.8H, V19.8H
    FMINNM  V3.4S, V5.4S, V24.4S
    SQRDMULH  V19.4H, V24.4H, V9.H[0x5]
    SHRN V30.4H, V11.4S, #8
    MOV D8, V28.D[0x0]
    FMULX V26.2S, V6.2S, V23.S[0x0]
    FMAXNM  V28.4H, V29.4H, V15.4H
    UMLSL2 V11.2D, V15.4S, V14.S[0x3]
    SADALP  V6.2D, V16.4S
    SSHLL V31.2D, V30.2S, #0xf
    SABA  V5.16B, V9.16B, V10.16B
    FMULX D16, D19, V31.D[0x0]
    UMLAL2  V17.2D, V3.4S, V3.4S
    URSRA  V3.4H, V8.4H, #14
    FMAXNMP S9, V11.2S
    ADDV  H19, V9.8H
    FMAXNMP  V30.4H, V11.4H, V19.4H
    UABAL2  V14.2D, V28.4S, V6.4S
    SHA256SU1  V11.4S, V14.4S, V26.4S
    UABAL  V26.8H, V5.8B, V5.8B
    FCMGE  V24.4H, V30.4H, V16.4H
    SQXTUN2  V30.4S, V3.2D
    RSHRN V3.4H, V26.4S, #12
    SQDMLAL  V29.4S, V24.4H, V17.4H
    MOV D10, V12.D[0x0]
    UMLSL  V14.4S, V10.4H, V11.4H
    EOR  V9.16B, V14.16B, V14.16B
    FCVTL2  V6.2D, V9.4S
    SQRDMULH S26, S29, V29.S[0x3]
    SRSHL  V15.4H, V26.4H, V6.4H
    CLZ  V24.4S, V3.4S
    UQSHRN2 V29.8H, V24.4S, #11
    FRSQRTS  V5.4H, V30.4H, V30.4H
    SMAX  V9.8B, V15.8B, V5.8B
    FNEG  V15.8H, V29.8H
    SQSHRUN V14.4H, V15.4S, #11
    ORR  V19.2S, #0xd3
    SSHR  V16.8B, V19.8B, #3
    CMLE  V11.4S, V9.4S, #0
    DUP  V12.2S, V14.S[0x2]
    TBX  V29.16B, { V26.16B, V27.16B, V28.16B, V29.16B }, V16.16B
    FCVTAU  V14.8H, V11.8H
    UMULL V8.2D, V12.2S, V12.S[0x0]
    SQDMLAL V30.4S, V8.4H, V14.H[0x4]
    SQRSHRUN V11.2S, V29.2D, #20
    FMAX  V17.8H, V30.8H, V11.8H
    SMULL V6.4S, V29.4H, V5.H[0x6]
    FRSQRTE  V30.2S, V5.2S
    FMAXNM  V11.4H, V15.4H, V11.4H
    FMINNMV  S12, V2.4S
    FMAXNMV  H16, V1.8H
    MOV V14.H[0x6], V21.H[0x5]
    CMLE  V9.2S, V14.2S, #0
    DUP  V19.2S, V26.S[0x2]
    SCVTF  V5.8H, V17.8H, #12
    FMUL V24.4H, V8.4H, V7.H[0x3]
    SQDMLAL V29.2D, V16.2S, V6.S[0x1]
    UABAL2  V1.2D, V29.4S, V24.4S
    SRSHR  V8.16B, V9.16B, #1
    SQRSHRUN2 V17.16B, V19.8H, #1
    SQDMULH S14, S5, V30.S[0x3]
    MVN  V6.8B, V11.8B
    UMLAL2 V24.4S, V14.8H, V15.H[0x1]
    FMAXNMP S19, V8.2S
    FMUL  V26.4H, V24.4H, V1.4H
    SXTL V1.2D, V11.2S
    FSUB  V14.8H, V1.8H, V6.8H
    MVN  V9.8B, V12.8B
    DUP B7, V26.B[0xd]
    USHLL2 V11.2D, V7.4S, #0x18
    FMAXNMP H24, V30.2H
    FCMGE  V5.8H, V9.8H, V17.8H
    SQXTUN  V15.2S, V14.2D
    FMAXNMV  H14, V15.8H
    MUL  V17.4H, V14.4H, V19.4H
    SHA1SU1  V8.4S, V5.4S
    SSHLL2 V26.2D, V8.4S, #0x9
    SHA256SU0  V12.4S, V11.4S
    FCVTMS  V1.2S, V24.2S
    FMINNMV  S24, V17.4S
    SABDL2  V14.8H, V24.16B, V24.16B
    SRSHR V9.2D, V26.2D, #7
    FCMEQ  V24.8H, V1.8H, V9.8H
    SQDMLSL V26.4S, V14.4H, V5.H[0x0]
    ORR  V17.4S, #0x53, LSL #8
    SHRN2 V1.8H, V26.4S, #11
    SMAXP  V8.8H, V1.8H, V12.8H
    SQRSHRUN2 V26.16B, V8.8H, #3
    SSRA  V19.2S, V17.2S, #15
    FCMLE  V1.8H, V19.8H, #0.0
    UHSUB  V15.4S, V16.4S, V26.4S
    SHSUB  V9.4S, V15.4S, V15.4S
    FCVTAS  V17.2D, V24.2D
    SQXTUN  V11.4H, V17.4S
    UQRSHRN V12.4H, V1.4S, #4
    UQSHRN2 V1.4S, V12.2D, #9
    UMLSL2 V17.4S, V11.8H, V1.H[0x2]
    FMINNM  V14.2S, V9.2S, V17.2S
    SQDMULH  V5.4H, V1.4H, V12.H[0x5]
    FCVTZS  V1.2S, V18.2S, #11
    SMLAL2  V18.4S, V31.8H, V23.8H
    UCVTF  V8.4H, V23.4H
    SQRSHRN2 V19.8H, V22.4S, #7
    FACGT  V11.8H, V1.8H, V2.8H
    DUP V24.4S, W13
    SUBS  X4, X4, #0x1
    B.NE  TSRTAdvsimdVectorAllOperation_label_1
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x97, LSL #0
    MOVK  X23, #0x800, LSL #16
    MRS  X7, FPSR
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V0.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D0
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V1.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D1
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x4000, LSL #48
    FMOV  X7, V2.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D2
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V3.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0xfffe, LSL #0
    FMOV  X7, D3
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V4.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D4
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V5.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D5
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V6.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0xdfff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X7, D6
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V7.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D7
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V8.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x57f0, LSL #0
    MOVK  X23, #0x57f0, LSL #32
    FMOV  X7, D8
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V9.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D9
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V10.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D10
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V11.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D11
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V12.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X7, D12
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V13.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D13
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V14.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D14
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V15.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x100, LSL #0
    MOVK  X23, #0x8000, LSL #16
    MOVK  X23, #0x8000, LSL #48
    FMOV  X7, D15
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V16.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D16
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V17.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D17
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V18.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D18
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V19.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D19
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X7, V20.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D20
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V21.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D21
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V22.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D22
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V23.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x7f, LSL #0
    MOVK  X23, #0x7f, LSL #32
    FMOV  X7, D23
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V24.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D24
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x3e00, LSL #0
    MOVK  X23, #0x3e00, LSL #16
    MOVK  X23, #0x3e00, LSL #32
    MOVK  X23, #0x3e00, LSL #48
    FMOV  X7, V25.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x3e00, LSL #32
    MOVK  X23, #0x3e00, LSL #48
    FMOV  X7, D25
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V26.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0xfe00, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X7, D26
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V27.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0xa0a, LSL #0
    MOVK  X23, #0xa0a, LSL #16
    MOVK  X23, #0x42, LSL #32
    MOVK  X23, #0x40, LSL #48
    FMOV  X7, D27
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V28.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x5959, LSL #0
    MOVK  X23, #0x5959, LSL #16
    MOVK  X23, #0x5959, LSL #32
    MOVK  X23, #0x5959, LSL #48
    FMOV  X7, D28
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V29.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x2, LSL #0
    MOVK  X23, #0x2, LSL #32
    FMOV  X7, D29
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V30.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x8000, LSL #0
    MOVK  X23, #0x4034, LSL #16
    MOVK  X23, #0x8000, LSL #32
    MOVK  X23, #0x4034, LSL #48
    FMOV  X7, D30
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V31.D[1]
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D31
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
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
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
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
    FMOV  D0, X27
    FMOV  V0.D[1], X28
    FMOV  D1, X23
    FMOV  V1.D[1], X24
    FMOV  D2, X29
    FMOV  V2.D[1], X25
    FMOV  D3, X26
    FMOV  V3.D[1], X20
    FMOV  D4, X8
    FMOV  V4.D[1], X27
    FMOV  D5, X26
    FMOV  V5.D[1], X26
    FMOV  D6, X19
    FMOV  V6.D[1], X9
    FMOV  D7, X20
    FMOV  V7.D[1], X5
    FMOV  D8, X8
    FMOV  V8.D[1], X4
    FMOV  D9, X25
    FMOV  V9.D[1], X22
    FMOV  D10, X8
    FMOV  V10.D[1], X9
    FMOV  D11, X6
    FMOV  V11.D[1], X23
    FMOV  D12, X4
    FMOV  V12.D[1], X3
    FMOV  D13, X9
    FMOV  V13.D[1], X8
    FMOV  D14, X24
    FMOV  V14.D[1], X19
    FMOV  D15, X20
    FMOV  V15.D[1], X26
    FMOV  D16, X28
    FMOV  V16.D[1], X23
    FMOV  D17, X16
    FMOV  V17.D[1], X20
    FMOV  D18, X16
    FMOV  V18.D[1], X7
    FMOV  D19, X2
    FMOV  V19.D[1], X29
    FMOV  D20, X10
    FMOV  V20.D[1], X8
    FMOV  D21, X17
    FMOV  V21.D[1], X5
    FMOV  D22, X4
    FMOV  V22.D[1], X13
    FMOV  D23, X10
    FMOV  V23.D[1], X6
    FMOV  D24, X28
    FMOV  V24.D[1], X4
    FMOV  D25, X9
    FMOV  V25.D[1], X22
    FMOV  D26, X28
    FMOV  V26.D[1], X12
    FMOV  D27, X12
    FMOV  V27.D[1], X26
    FMOV  D28, X4
    FMOV  V28.D[1], X24
    FMOV  D29, X23
    FMOV  V29.D[1], X20
    FMOV  D30, X10
    FMOV  V30.D[1], X3
    FMOV  D31, X9
    FMOV  V31.D[1], X22
    MOVZ  X29, #0xa, LSL #0
TSRTAdvsimdVectorAllOperation_label_2:
    FCVTL2  V6.4S, V25.8H
    SQDMLAL2 V29.2D, V24.4S, V31.S[0x3]
    SQRSHRN2 V9.8H, V18.4S, #4
    XTN2  V18.8H, V26.4S
    FCVTMU  V27.2S, V30.2S
    MOV S1, V28.S[0x2]
    UADDL2  V11.4S, V1.8H, V9.8H
    SMLSL V18.4S, V23.4H, V11.H[0x7]
    SSRA  V6.4S, V6.4S, #16
    CMEQ  V19.16B, V6.16B, V29.16B
    AESE  V8.16B, V18.16B
    FCMEQ  V27.2S, V2.2S, #0.0
    CMGT  V6.8B, V27.8B, V19.8B
    ZIP1  V9.8H, V8.8H, V8.8H
    FABD  V25.4S, V9.4S, V9.4S
    FMULX V1.2D, V25.2D, V6.D[0x1]
    SQDMLAL V28.4S, V2.4H, V3.H[0x6]
    CMEQ  V24.4S, V18.4S, V10.4S
    FMLS V6.2D, V28.2D, V7.D[0x0]
    SMLSL  V26.8H, V3.8B, V4.8B
    USUBW  V9.4S, V5.4S, V25.4H
    SQDMLAL S23, H27, V11.H[0x7]
    REV16  V31.16B, V27.16B
    SQRSHRUN V4.2S, V6.2D, #9
    UHADD  V13.4S, V4.4S, V1.4S
    SSHLL2 V2.8H, V19.16B, #0x1
    ORN  V18.8B, V9.8B, V27.8B
    SLI  V3.16B, V15.16B, #0x6
    AESMC  V29.16B, V4.16B
    MOV S9, V3.S[0x1]
    INS V1.H[0x5], V23.H[0x0]
    SQRSHRN V30.2S, V9.2D, #13
    MVN  V3.8B, V24.8B
    FMULX V19.4S, V18.4S, V29.S[0x1]
    INS V4.B[0xf], W20
    ZIP1  V6.8H, V30.8H, V1.8H
    FMAXNMP H27, V2.2H
    FRECPE  V7.2D, V4.2D
    UMINV  S23, V31.4S
    EXT  V1.16B, V27.16B, V19.16B, #0x3
    MOV B11, V3.B[0x8]
    SHA1SU0  V8.4S, V23.4S, V26.4S
    USHLL V10.2D, V6.2S, #0x12
    REV64  V31.4S, V0.4S
    FCVTNU  V15.4H, V8.4H
    UADDW  V9.2D, V31.2D, V7.2S
    SHL V2.2D, V9.2D, #0x20
    URSHR  V0.8B, V1.8B, #6
    FMIN  V31.4S, V11.4S, V11.4S
    FSQRT  V24.4H, V0.4H
    SSHR  V18.8H, V24.8H, #8
    UMOV W4, V13.H[0x0]
    PMUL  V27.8B, V10.8B, V18.8B
    FRECPE  V30.2S, V27.2S
    SRSRA V1.2D, V31.2D, #3
    FMINV  S4, V2.4S
    UADDW  V9.4S, V4.4S, V1.4H
    FRINTZ  V1.4S, V9.4S
    FCVTMU  V13.2S, V30.2S
    FMAXNMP D2, V1.2D
    ABS  V0.4H, V13.4H
    FRSQRTE  V31.4H, V15.4H
    SQDMLAL2  V1.2D, V2.4S, V31.4S
    SSHLL2 V2.2D, V1.4S, #0x3
    UMOV W24, V2.H[0x3]
    SQDMULL  V31.4S, V10.4H, V1.4H
    DUP  V9.4S, V16.S[0x0]
    SRSHL  V11.2S, V1.2S, V5.2S
    FACGE  V15.8H, V7.8H, V27.8H
    SLI V4.2D, V18.2D, #0x17
    MVNI  V13.2S, #0xdf, LSL #16
    SADDLV  S27, V7.4H
    SXTL V2.8H, V13.8B
    URSHL  V30.2D, V21.2D, V24.2D
    UMULL2  V1.4S, V2.8H, V0.8H
    URSRA  V2.4H, V1.4H, #3
    SADDLV  S16, V31.8H
    SRI  V18.8H, V16.8H, #8
    CMEQ  V5.8B, V9.8B, #0
    REV64  V13.4S, V4.4S
    SQSHL  V10.4H, V27.4H, #0x3
    ADDHN  V4.8B, V10.8H, V10.8H
    ADDV  S10, V2.4S
    ADDHN  V2.4H, V10.4S, V30.4S
    URSHL  V31.4S, V5.4S, V5.4S
    UMLSL V5.4S, V2.4H, V11.H[0x5]
    CMEQ  V0.16B, V4.16B, #0
    FACGT  V24.4H, V15.4H, V0.4H
    SSHLL V2.8H, V24.8B, #0x5
    UMULL2 V1.2D, V2.4S, V5.S[0x3]
    UMIN  V2.8H, V1.8H, V13.8H
    ORR  V27.4S, #0x7b, LSL #24
    MOV H7, V18.H[0x3]
    UMINV  S18, V31.4S
    FMAXNMP S30, V18.2S
    FACGT  V13.2S, V2.2S, V30.2S
    RBIT  V1.16B, V27.16B
    TBX  V21.8B, { V20.16B }, V7.8B
    FMAX  V10.4H, V21.4H, V1.4H
    SHL  V4.2S, V13.2S, #0x1d
    FCVTMS  V1.4H, V27.4H
    SHA1M  Q18, S1, V10.4S
    SLI V11.2D, V4.2D, #0x1d
    UQSHRN2 V9.16B, V11.8H, #4
    FMINP  V21.2D, V18.2D, V18.2D
    SHA1P  Q16, S21, V9.4S
    SADDL  V15.4S, V9.4H, V18.4H
    FABS  V31.8H, V24.8H
    MOV  W23, V13.S[0x0]
    UMULL2 V0.2D, V9.4S, V27.S[0x2]
    SADDL2  V5.8H, V6.16B, V8.16B
    FMLA S25, S5, V24.S[0x1]
    SQRSHRUN2 V20.8H, V18.4S, #15
    SQRSHRUN2 V7.4S, V23.2D, #24
    SQDMLAL D5, S4, V0.S[0x1]
    SQDMLAL2  V6.2D, V10.4S, V4.4S
    DUP V1.2D, V31.D[0x1]
    UADDLV  S18, V13.8H
    USUBL  V21.8H, V16.8B, V5.8B
    SHA256H2  Q8, Q7, V25.4S
    SSRA  V11.2S, V20.2S, #4
    FCVTL  V20.4S, V15.4H
    SXTL2 V9.2D, V8.4S
    MOVI  V16.8H, #0x37, LSL #8
    SMOV W24, V21.B[0xa]
    FRINTX  V4.4H, V9.4H
    DUP V13.16B, W10
    BSL  V23.16B, V11.16B, V26.16B
    FCVTL  V25.4S, V18.4H
    SQRSHRUN2 V7.4S, V16.2D, #3
    SQSHL V15.2D, V20.2D, #0x20
    SMOV  X12, V4.B[0x1]
    ADDV  S5, V13.4S
    SSUBL2  V9.8H, V25.16B, V7.16B
    SQRSHRUN V21.2S, V5.2D, #21
    SSHR V0.2D, V6.2D, #40
    UMLSL  V26.4S, V15.4H, V21.4H
    UMLSL2 V15.2D, V26.4S, V26.S[0x2]
    UMAXV  B26, V9.16B
    MLS  V5.2S, V23.2S, V26.2S
    SQADD  V13.8B, V0.8B, V5.8B
    USHR  V23.4S, V15.4S, #3
    FMLA S8, S23, V23.S[0x0]
    FRINTP  V9.4S, V8.4S
    UMAXV  S23, V13.4S
    UQADD  V16.8B, V9.8B, V23.8B
    UQSHL  V6.16B, V16.16B, V16.16B
    MUL  V21.4S, V6.4S, V6.S[0x0]
    SMOV  X24, V21.S[0x2]
    SABD  V9.4H, V9.4H, V2.4H
    SQRSHRUN2 V0.4S, V4.2D, #9
    UCVTF  V16.4S, V27.4S, #10
    UMLAL V23.4S, V29.4H, V2.H[0x0]
    SQRSHRN V11.8B, V1.8H, #1
    FCVTMU  V18.2D, V24.2D
    FACGE  V5.8H, V5.8H, V13.8H
    ORR  V15.4H, #0x72, LSL #8
    UQRSHRN2 V24.16B, V29.8H, #3
    FRECPS  V29.8H, V23.8H, V15.8H
    FCVTZS  V2.2S, V0.2S, #20
    FMULX  V0.8H, V11.8H, V29.8H
    MOV B23, V9.B[0x2]
    FMINNMV  H9, V16.8H
    MOV D1, V0.D[0x1]
    FNEG  V21.4S, V5.4S
    FCVTMU  V11.4H, V2.4H
    MUL  V6.4H, V18.4H, V11.H[0x7]
    FCMGE  V8.8H, V24.8H, #0.0
    FMINNMP H24, V3.2H
    FMINNMV  S16, V24.4S
    FMINNMP S13, V23.2S
    SQDMULL2 V29.2D, V1.4S, V1.S[0x1]
    UCVTF  V18.2S, V29.2S, #13
    FADDP H29, V21.2H
    UMLAL V11.4S, V24.4H, V9.H[0x7]
    FMAXNMP S23, V6.2S
    SABAL  V15.2D, V16.2S, V13.2S
    SRSHR  V24.16B, V11.16B, #4
    FMAXNMV  H3, V19.8H
    MOVI  V4.4H, #0x8c
    SSHLL2 V1.8H, V18.16B, #0x2
    SHRN2 V6.8H, V12.4S, #6
    UQXTN2  V13.4S, V8.2D
    SHL  V8.2S, V13.2S, #0x14
    USHLL2 V21.4S, V8.8H, #0xd
    MLS  V9.8H, V0.8H, V24.8H
    SHA256H  Q0, Q9, V1.4S
    UXTL2 V16.2D, V23.4S
    FRINTM  V11.8H, V29.8H
    MOV H13, V21.H[0x0]
    FCVTAS  V18.2S, V13.2S
    MVNI  V1.4H, #0xfe, LSL #8
    FCVTZU  V12.2D, V23.2D
    SQSHLU  V23.4S, V16.4S, #0x5
    FABS  V16.2S, V0.2S
    SCVTF  V19.4S, V6.4S, #21
    FCVTNS  V29.4S, V11.4S
    SQDMLSL2  V0.2D, V15.4S, V19.4S
    FCMEQ  V15.4S, V23.4S, V18.4S
    USHLL V29.4S, V3.4H, #0x4
    UXTL2 V21.8H, V15.16B
    UCVTF  V9.2S, V16.2S
    UABDL2  V13.4S, V1.8H, V9.8H
    FCVTN  V16.2S, V12.2D
    SQSHRUN V23.8B, V0.8H, #3
    FCVTL  V19.4S, V21.4H
    FRSQRTS  V12.4H, V29.4H, V16.4H
    UMAXV  H15, V4.4H
    SMLSL  V18.4S, V19.4H, V13.4H
    SQRDMULH  V8.4H, V23.4H, V12.H[0x7]
    SRSHR  V21.2S, V15.2S, #19
    SRSRA  V11.8H, V18.8H, #11
    URSQRTE  V18.2S, V15.2S
    AESD  V16.16B, V8.16B
    EXT  V6.8B, V27.8B, V21.8B, #0x5
    UABDL  V19.2D, V16.2S, V11.2S
    SHLL2  V23.2D, V18.4S, #32
    SMINP  V28.8H, V6.8H, V6.8H
    UABA  V1.8H, V19.8H, V23.8H
    FRINTI  V8.2D, V1.2D
    INS V12.S[0x1], V28.S[0x2]
    DUP B29, V12.B[0x7]
    TBX  V3.8B, { V29.16B }, V8.8B
    FMLA V6.4H, V3.4H, V2.H[0x0]
    CNT  V19.16B, V11.16B
    SQXTN  V16.2S, V26.2D
    SLI V15.2D, V11.2D, #0x38
    UQXTN2  V26.8H, V11.4S
    UQSHRN2 V3.4S, V2.2D, #26
    SABA  V18.16B, V2.16B, V12.16B
    SLI  V8.8H, V9.8H, #0x7
    UMOV W28, V20.S[0x3]
    FSQRT  V23.8H, V10.8H
    UMOV W22, V6.B[0x7]
    SSUBW  V0.2D, V19.2D, V23.2S
    RSUBHN  V10.8B, V16.8H, V18.8H
    SMLSL2 V29.2D, V15.4S, V10.S[0x1]
    SQRSHRN V9.8B, V26.8H, #4
    SHADD  V20.8H, V0.8H, V3.8H
    UMIN  V2.16B, V8.16B, V8.16B
    FRINTI  V28.4H, V11.4H
    FACGT  V8.4S, V29.4S, V28.4S
    SSRA  V10.2S, V20.2S, #11
    SQDMLAL  V20.4S, V9.4H, V10.4H
    BIC  V10.8H, #0x12, LSL #8
    UXTL2 V16.2D, V2.4S
    UMLAL V18.4S, V8.4H, V10.H[0x6]
    RBIT  V9.8B, V18.8B
    SHA256H  Q6, Q20, V9.4S
    USHLL V1.8H, V16.8B, #0x2
    FCVTZS  V20.2S, V6.2S, #1
    FRSQRTE  V15.8H, V1.8H
    FSQRT  V19.4S, V20.4S
    FRINTI  V1.4H, V11.4H
    NOT  V20.8B, V1.8B
    SQRDMULH S16, S20, V15.S[0x2]
    FMLS  V18.8H, V22.8H, V19.8H
    MLS  V12.4S, V16.4S, V11.S[0x2]
    SMLAL V1.2D, V12.2S, V12.S[0x2]
    SSUBL  V29.2D, V1.2S, V18.2S
    FCVTL  V16.2D, V19.2S
    MOV V1.H[0x0], V2.H[0x1]
    CMHS  V19.16B, V17.16B, V3.16B
    USQADD  V20.8H, V0.8H
    FCVTL2  V6.2D, V25.4S
    MOV  X17, V0.D[0x1]
    SQRSHRN2 V18.16B, V31.8H, #4
    RBIT  V22.16B, V19.16B
    UQRSHRN V15.2S, V21.2D, #18
    TBX  V11.8B, { V19.16B, V20.16B, V21.16B, V22.16B }, V1.8B
    BIC  V28.4H, #0x5f, LSL #8
    USHR  V3.2S, V31.2S, #24
    DUP V0.2D, V23.D[0x1]
    FMOV  V20.2D, #7.75000000
    SHL  V31.4S, V3.4S, #0x1d
    SQRDMULH H2, H28, V15.H[0x6]
    SQRSHRUN2 V17.4S, V18.2D, #19
    TBX  V25.16B, { V31.16B, V0.16B }, V17.16B
    FCVTZS  V12.2S, V2.2S
    SQDMLSL S3, H11, V6.H[0x6]
    UQRSHRN V22.2S, V3.2D, #23
    UMLSL V3.2D, V22.2S, V25.S[0x0]
    FMAXNM  V23.2D, V12.2D, V12.2D
    FMLS S18, S20, V23.S[0x1]
    SQRDMULH  V19.2S, V3.2S, V3.S[0x2]
    SHRN V22.8B, V18.8H, #2
    USUBL2  V0.2D, V22.4S, V22.4S
    FMLS  V11.4H, V19.4H, V19.4H
    UQRSHRN V22.2S, V0.2D, #15
    SQDMULL V3.2D, V11.2S, V11.S[0x1]
    MUL  V28.4S, V3.4S, V3.4S
    RSUBHN2  V12.4S, V28.2D, V22.2D
    UCVTF  V2.8H, V12.8H
    FRINTX  V6.2D, V15.2D
    SQSHL V21.2D, V15.2D, #0x21
    UABDL  V12.8H, V18.8B, V3.8B
    SQRSHRN2 V0.4S, V11.2D, #7
    SQDMULL  V20.4S, V26.4H, V24.4H
    SQDMLSL2 V25.2D, V19.4S, V17.S[0x2]
    FMULX H15, H11, V10.H[0x1]
    SUBS  X29, X29, #0x1
    B.NE  TSRTAdvsimdVectorAllOperation_label_2
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X8, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X8, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X8, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X8, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X8, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X8, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X8, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X8, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X8, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X8, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X8, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X8, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xe000, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X8, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x97, LSL #0
    MOVK  X27, #0x800, LSL #16
    MRS  X8, FPSR
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xff00, LSL #0
    MOVK  X27, #0xffff, LSL #16
    FMOV  X8, V0.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, D0
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, V1.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x2000, LSL #0
    FMOV  X8, D1
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, V2.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, D2
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x2, LSL #0
    FMOV  X8, V3.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x1, LSL #16
    FMOV  X8, D3
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, V4.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x8c, LSL #0
    MOVK  X27, #0x8c, LSL #16
    MOVK  X27, #0x8c, LSL #32
    MOVK  X27, #0x8c, LSL #48
    FMOV  X8, D4
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    FMOV  X8, V5.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    FMOV  X8, D5
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, V6.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, D6
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    FMOV  X8, V7.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, D7
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, V8.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, D8
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, V9.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xbcff, LSL #0
    MOVK  X27, #0xbcff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    FMOV  X8, D9
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, V10.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xc0a2, LSL #0
    MOVK  X27, #0xedff, LSL #32
    MOVK  X27, #0xedff, LSL #48
    FMOV  X8, D10
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, V11.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x8000, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    FMOV  X8, D11
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, V12.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xff, LSL #0
    MOVK  X27, #0xff, LSL #16
    MOVK  X27, #0xfe, LSL #32
    MOVK  X27, #0x7f, LSL #48
    FMOV  X8, D12
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, V13.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, D13
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    FMOV  X8, V14.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    FMOV  X8, D14
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, V15.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x8000, LSL #0
    FMOV  X8, D15
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, V16.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xe000, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0x7fff, LSL #48
    FMOV  X8, D16
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, V17.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    FMOV  X8, D17
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, V18.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0x7fff, LSL #16
    FMOV  X8, D18
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, V19.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, D19
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, V20.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, D20
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, V21.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, D21
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, V22.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, D22
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, V23.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, D23
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, V24.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, D24
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, V25.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, D25
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x8000, LSL #0
    FMOV  X8, V26.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x1, LSL #0
    FMOV  X8, D26
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x7b00, LSL #16
    MOVK  X27, #0x7b00, LSL #48
    FMOV  X8, V27.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x7ff0, LSL #0
    MOVK  X27, #0x7b00, LSL #16
    MOVK  X27, #0x7b00, LSL #48
    FMOV  X8, D27
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x4, LSL #0
    FMOV  X8, V28.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, D28
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x1, LSL #0
    FMOV  X8, V29.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x8001, LSL #0
    MOVK  X27, #0x8000, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    FMOV  X8, D29
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, V30.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, D30
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, V31.D[1]
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X8, D31
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X2, #0x4752, LSL #0
    MOVK  X2, #0x909b, LSL #16
    MOVK  X2, #0x126a, LSL #32
    MOVK  X2, #0x7a0e, LSL #48
    MOVZ  X3, #0x2020, LSL #0
    MOVK  X3, #0xfb6a, LSL #16
    MOVK  X3, #0xbea7, LSL #32
    MOVK  X3, #0xb4e3, LSL #48
    MOVZ  X4, #0x46f6, LSL #0
    MOVK  X4, #0x5442, LSL #16
    MOVK  X4, #0x752b, LSL #32
    MOVK  X4, #0x6e79, LSL #48
    MOVZ  X5, #0x28de, LSL #0
    MOVK  X5, #0xdaf2, LSL #16
    MOVK  X5, #0xf97e, LSL #32
    MOVK  X5, #0x3240, LSL #48
    MOVZ  X6, #0x4c55, LSL #0
    MOVK  X6, #0x8b19, LSL #16
    MOVK  X6, #0x1a27, LSL #32
    MOVK  X6, #0xd18d, LSL #48
    MOVZ  X7, #0x251e, LSL #0
    MOVK  X7, #0x948, LSL #16
    MOVK  X7, #0x7656, LSL #32
    MOVK  X7, #0x5bd5, LSL #48
    MOVZ  X8, #0xa383, LSL #0
    MOVK  X8, #0xa537, LSL #16
    MOVK  X8, #0xe23d, LSL #32
    MOVK  X8, #0xec16, LSL #48
    MOVZ  X9, #0x4b89, LSL #0
    MOVK  X9, #0xd514, LSL #16
    MOVK  X9, #0x40a3, LSL #32
    MOVK  X9, #0xf92f, LSL #48
    MOVZ  X10, #0x1dbc, LSL #0
    MOVK  X10, #0x68fe, LSL #16
    MOVK  X10, #0xd8f, LSL #32
    MOVK  X10, #0x48b5, LSL #48
    MOVZ  X12, #0xcbef, LSL #0
    MOVK  X12, #0xcc3d, LSL #16
    MOVK  X12, #0x9f93, LSL #32
    MOVK  X12, #0xa7fc, LSL #48
    MOVZ  X13, #0xb0d5, LSL #0
    MOVK  X13, #0xd739, LSL #16
    MOVK  X13, #0x3831, LSL #32
    MOVK  X13, #0x1c7b, LSL #48
    MOVZ  X15, #0x5e0b, LSL #0
    MOVK  X15, #0xe5d6, LSL #16
    MOVK  X15, #0xe262, LSL #32
    MOVK  X15, #0xc9e4, LSL #48
    MOVZ  X16, #0x1d8e, LSL #0
    MOVK  X16, #0x8744, LSL #16
    MOVK  X16, #0x482a, LSL #32
    MOVK  X16, #0x3eed, LSL #48
    MOVZ  X17, #0x1ae7, LSL #0
    MOVK  X17, #0xb946, LSL #16
    MOVK  X17, #0x21a9, LSL #32
    MOVK  X17, #0x8153, LSL #48
    MOVZ  X19, #0xe598, LSL #0
    MOVK  X19, #0xd90e, LSL #16
    MOVK  X19, #0xd89d, LSL #32
    MOVK  X19, #0xd57a, LSL #48
    MOVZ  X20, #0x9ee8, LSL #0
    MOVK  X20, #0xa783, LSL #16
    MOVK  X20, #0x3341, LSL #32
    MOVK  X20, #0xd2ef, LSL #48
    MOVZ  X22, #0xcaad, LSL #0
    MOVK  X22, #0xf2c8, LSL #16
    MOVK  X22, #0x5537, LSL #32
    MOVK  X22, #0xe3fd, LSL #48
    MOVZ  X23, #0x7161, LSL #0
    MOVK  X23, #0xcb57, LSL #16
    MOVK  X23, #0x92a9, LSL #32
    MOVK  X23, #0x865f, LSL #48
    MOVZ  X24, #0x782f, LSL #0
    MOVK  X24, #0xc6c3, LSL #16
    MOVK  X24, #0x2fc5, LSL #32
    MOVK  X24, #0x3880, LSL #48
    MOVZ  X25, #0x4dec, LSL #0
    MOVK  X25, #0x5274, LSL #16
    MOVK  X25, #0xd9e0, LSL #32
    MOVK  X25, #0x5b63, LSL #48
    MOVZ  X26, #0xac8f, LSL #0
    MOVK  X26, #0xccfa, LSL #16
    MOVK  X26, #0x754c, LSL #32
    MOVK  X26, #0x23bb, LSL #48
    MOVZ  X27, #0xed3a, LSL #0
    MOVK  X27, #0xf2cf, LSL #16
    MOVK  X27, #0xe6e5, LSL #32
    MOVK  X27, #0x725, LSL #48
    MOVZ  X28, #0x324f, LSL #0
    MOVK  X28, #0xd421, LSL #16
    MOVK  X28, #0xfc8d, LSL #32
    MOVK  X28, #0x49c2, LSL #48
    MOVZ  X29, #0x5b8f, LSL #0
    MOVK  X29, #0xb37e, LSL #16
    MOVK  X29, #0xa13, LSL #32
    MOVK  X29, #0x9f2a, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X29
    FMOV  D1, X23
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X6
    FMOV  D3, X16
    FMOV  V3.D[1], X7
    FMOV  D4, X28
    FMOV  V4.D[1], X25
    FMOV  D5, X15
    FMOV  V5.D[1], X24
    FMOV  D6, X22
    FMOV  V6.D[1], X29
    FMOV  D7, X3
    FMOV  V7.D[1], X12
    FMOV  D8, X26
    FMOV  V8.D[1], X29
    FMOV  D9, X17
    FMOV  V9.D[1], X5
    FMOV  D10, X28
    FMOV  V10.D[1], X4
    FMOV  D11, X25
    FMOV  V11.D[1], X7
    FMOV  D12, X2
    FMOV  V12.D[1], X25
    FMOV  D13, X29
    FMOV  V13.D[1], X19
    FMOV  D14, X5
    FMOV  V14.D[1], X17
    FMOV  D15, X8
    FMOV  V15.D[1], X22
    FMOV  D16, X17
    FMOV  V16.D[1], X7
    FMOV  D17, X2
    FMOV  V17.D[1], X17
    FMOV  D18, X13
    FMOV  V18.D[1], X17
    FMOV  D19, X29
    FMOV  V19.D[1], X3
    FMOV  D20, X27
    FMOV  V20.D[1], X4
    FMOV  D21, X9
    FMOV  V21.D[1], X12
    FMOV  D22, X28
    FMOV  V22.D[1], X28
    FMOV  D23, X24
    FMOV  V23.D[1], X16
    FMOV  D24, X29
    FMOV  V24.D[1], X19
    FMOV  D25, X28
    FMOV  V25.D[1], X9
    FMOV  D26, X20
    FMOV  V26.D[1], X16
    FMOV  D27, X16
    FMOV  V27.D[1], X13
    FMOV  D28, X16
    FMOV  V28.D[1], X9
    FMOV  D29, X23
    FMOV  V29.D[1], X12
    FMOV  D30, X8
    FMOV  V30.D[1], X4
    FMOV  D31, X7
    FMOV  V31.D[1], X10
    MOVZ  X24, #0xa, LSL #0
TSRTAdvsimdVectorAllOperation_label_3:
    URSRA V0.2D, V22.2D, #48
    SUBHN2  V28.4S, V24.2D, V18.2D
    URECPE  V20.2S, V26.2S
    USUBL  V14.8H, V21.8B, V25.8B
    UABA  V17.2S, V31.2S, V30.2S
    SMAX  V9.16B, V23.16B, V29.16B
    UMLSL2 V9.4S, V0.8H, V13.H[0x6]
    TBX  V13.8B, { V6.16B, V7.16B }, V27.8B
    SQSHL  V13.4H, V28.4H, #0x5
    SQRSHRN2 V26.16B, V13.8H, #4
    SMOV W5, V15.B[0xe]
    FMAXV  H22, V26.4H
    SMAXP  V7.4H, V22.4H, V20.4H
    FCMGE  V23.8H, V9.8H, V9.8H
    USHLL V20.2D, V14.2S, #0x16
    UMINV  B24, V22.8B
    FCVTL2  V25.2D, V24.4S
    FMUL  V27.4S, V23.4S, V23.4S
    UABA  V9.8B, V27.8B, V7.8B
    ZIP2  V27.16B, V9.16B, V25.16B
    UMINV  B13, V17.16B
    SQSHL  V31.16B, V27.16B, #0x2
    CMHS  V21.4S, V13.4S, V31.4S
    DUP V31.2S, W29
    SQDMLAL2 V13.4S, V20.8H, V6.H[0x5]
    SHLL2  V18.2D, V21.4S, #32
    DUP H22, V18.H[0x7]
    SABA  V15.4S, V31.4S, V31.4S
    FCMEQ  V31.8H, V13.8H, #0.0
    MUL  V14.2S, V31.2S, V31.S[0x1]
    SQDMLAL D17, S15, V15.S[0x3]
    FSQRT  V9.4H, V14.4H
    SSHLL V26.2D, V22.2S, #0x13
    TBL  V21.8B, { V26.16B, V27.16B, V28.16B }, V17.8B
    UQRSHRN V18.8B, V21.8H, #4
    URSHR  V25.8B, V18.8B, #4
    SRSRA  V15.8H, V25.8H, #9
    FMAXNM  V28.4S, V9.4S, V9.4S
    RSUBHN  V27.8B, V15.8H, V28.8H
    FCMGE  V24.8H, V25.8H, V22.8H
    SQSHL  V13.8H, V2.8H, #0x4
    SMINV  S31, V8.4S
    SQRSHRN2 V15.8H, V2.4S, #2
    SQDMULL2  V23.2D, V11.4S, V27.4S
    SABA  V11.8B, V17.8B, V2.8B
    SMAXV  S8, V7.4S
    SUBHN  V18.4H, V22.4S, V27.4S
    USUBL  V26.2D, V25.2S, V19.2S
    FMAXV  S28, V8.4S
    FCVTNS  V22.2D, V24.2D
    FCVTPU  V7.2D, V11.2D
    SCVTF  V9.8H, V22.8H
    USHLL V22.4S, V18.4H, #0xc
    UQRSHRN V19.2S, V28.2D, #6
    SHRN2 V21.8H, V26.4S, #13
    SQSHLU  V27.4S, V19.4S, #0x13
    CMGT  V18.4H, V15.4H, V27.4H
    DUP V17.2D, X17
    CMHI  V24.2S, V13.2S, V23.2S
    UXTL V14.2D, V28.2S
    INS V27.B[0x0], V7.B[0xe]
    FMAXNM  V7.2D, V9.2D, V17.2D
    FCVTPS  V17.2D, V7.2D
    SQDMULL  V19.2D, V24.2S, V14.2S
    SADDLP  V24.2S, V19.4H
    MOVI  V25.4S, #0x33, MSL #8
    SRI  V13.16B, V25.16B, #2
    FMAXP H25, V22.2H
    SQDMLAL2 V28.2D, V13.4S, V18.S[0x0]
    FMAXP  V18.2D, V25.2D, V31.2D
    SQDMLSL2 V2.2D, V13.4S, V28.S[0x2]
    FCMEQ  V15.2D, V17.2D, V27.2D
    FADDP  V31.4H, V28.4H, V24.4H
    USRA V19.2D, V18.2D, #20
    FMINNM  V7.4H, V4.4H, V2.4H
    FMLA  V18.2S, V15.2S, V19.2S
    SQRDMULH H13, H7, V7.H[0x5]
    SHRN2 V9.4S, V31.2D, #17
    URSHR  V23.16B, V18.16B, #1
    UCVTF  V31.4H, V21.4H
    ZIP1  V19.2D, V13.2D, V9.2D
    USHLL V17.2D, V23.2S, #0x1
    RSHRN2 V28.4S, V19.2D, #12
    SQDMULL2 V15.2D, V31.4S, V31.S[0x0]
    FCMGE  V4.4S, V28.4S, #0.0
    FCMEQ  V14.8H, V4.8H, #0.0
    TRN1  V22.16B, V17.16B, V14.16B
    SQSHRN V18.4H, V15.4S, #8
    CMGT  V2.8B, V18.8B, #0
    SMIN  V14.4S, V22.4S, V22.4S
    URSHR  V7.8H, V14.8H, #4
    SXTL V14.4S, V2.4H
    SHSUB  V21.8H, V7.8H, V7.8H
    UMINP  V17.2S, V14.2S, V14.2S
    ABS  V31.4H, V21.4H
    SRI  V7.16B, V17.16B, #6
    FRSQRTE  V24.4H, V31.4H
    FMLS V15.2D, V24.2D, V7.D[0x0]
    FMULX  V27.2S, V28.2S, V29.2S
    SQRSHRN2 V21.8H, V9.4S, #16
    FCVTZS  V4.4S, V0.4S
    UMULL2 V28.4S, V20.8H, V8.H[0x1]
    UABA  V17.8H, V22.8H, V13.8H
    FCMEQ  V9.4S, V7.4S, V23.4S
    FCMGE  V14.4S, V29.4S, #0.0
    FCMEQ  V24.4S, V10.4S, #0.0
    RSHRN2 V0.4S, V9.2D, #29
    URSRA  V2.16B, V0.16B, #6
    USHLL V19.8H, V17.8B, #0x7
    SHL  V22.16B, V19.16B, #0x1
    FCMGE  V20.4H, V24.4H, V21.4H
    SMULL2  V9.4S, V0.8H, V15.8H
    MOVI  V19.4H, #0xc8
    FCVTPS  V10.8H, V14.8H
    UADDLV  D17, V2.4S
    SSHLL2 V8.2D, V27.4S, #0xb
    USUBL2  V21.4S, V4.8H, V12.8H
    CMGT  V14.4S, V9.4S, #0
    UMOV W2, V22.S[0x1]
    SHLL2  V24.2D, V20.4S, #32
    XTN2  V31.16B, V28.8H
    SQSHRN V2.2S, V17.2D, #28
    SQDMLSL2 V15.4S, V6.8H, V2.H[0x3]
    UQSHL  V20.16B, V19.16B, #0x7
    USRA  V0.8B, V2.8B, #8
    FSUB  V2.8H, V15.8H, V14.8H
    FCMGE  V14.4H, V21.4H, V10.4H
    FADD  V13.8H, V8.8H, V14.8H
    SSHLL2 V17.4S, V31.8H, #0x5
    SQDMULL  V14.2D, V24.2S, V24.2S
    FMLS  V28.4H, V14.4H, V2.4H
    FCVTAS  V24.8H, V20.8H
    FRINTM  V19.4H, V13.4H
    UQSHRN2 V6.16B, V19.8H, #5
    SHL V19.2D, V24.2D, #0x0
    SCVTF  V24.8H, V6.8H
    UABDL  V6.2D, V24.2S, V28.2S
    USHR  V4.4S, V0.4S, #21
    REV64  V2.2S, V19.2S
    SQSHRUN2 V22.16B, V17.8H, #4
    CMLT  V13.2D, V6.2D, #0
    FCMEQ  V9.2D, V4.2D, #0.0
    SQDMULL2  V27.2D, V9.4S, V2.4S
    FCVTZS  V24.2D, V22.2D
    UADDW  V12.2D, V13.2D, V27.2S
    SADALP  V31.2S, V0.4H
    FMOV  V8.8H, #0.87500000
    RADDHN2  V22.8H, V24.4S, V8.4S
    FCVTZS V19.2D, V22.2D, #60
    MOVI  V24.4S, #0x5d
    USHR  V2.8H, V19.8H, #3
    SMAXV  B8, V12.16B
    FRINTN  V19.4H, V31.4H
    FCVTZU  V17.2S, V8.2S
    CMHI  V9.4S, V2.4S, V17.4S
    SHSUB  V28.16B, V18.16B, V24.16B
    FCVTPU  V22.4H, V1.4H
    FMAXNMP S12, V9.2S
    UADDW  V27.2D, V22.2D, V12.2S
    SQRDMULH  V0.2S, V28.2S, V19.S[0x1]
    UXTL2 V22.8H, V27.16B
    UQSHRN2 V31.16B, V22.8H, #8
    ADDHN2  V9.4S, V31.2D, V31.2D
    MOV V13.S[0x3], W24
    CMEQ  V28.8B, V13.8B, V9.8B
    FMINV  S17, V0.4S
    UQRSHRN2 V9.4S, V17.2D, #30
    UZP2  V2.4S, V9.4S, V5.4S
    FCVTZU V13.2D, V2.2D, #12
    SMLAL  V0.8H, V13.8B, V28.8B
    SADDW2  V18.8H, V30.8H, V31.16B
    UXTL2 V13.4S, V28.8H
    SQDMLSL V30.4S, V17.4H, V0.H[0x3]
    FRINTZ  V31.2D, V24.2D
    SQDMULL  V5.2D, V20.2S, V2.2S
    FABS  V22.2S, V9.2S
    SABDL  V28.2D, V7.2S, V11.2S
    DUP V27.2S, W16
    SQDMLSL V19.4S, V2.4H, V1.H[0x6]
    SQDMULL2 V20.2D, V19.4S, V27.S[0x3]
    MOV V19.B[0x5], W5
    USUBW  V0.2D, V28.2D, V18.2S
    SQSHL  V1.2S, V22.2S, #0x6
    SQRSHRN2 V17.8H, V19.4S, #14
    SMULL V24.4S, V5.4H, V5.H[0x3]
    TBL  V28.16B, { V31.16B, V0.16B }, V17.16B
    FADDP  V9.4S, V30.4S, V28.4S
    SSHLL2 V12.8H, V24.16B, #0x2
    UMLAL V31.4S, V13.4H, V10.H[0x7]
    UQSHRN2 V11.4S, V9.2D, #18
    SMLSL2 V10.4S, V11.8H, V15.H[0x4]
    SQSHRUN2 V5.4S, V20.2D, #5
    SQRSHRUN V15.8B, V1.8H, #1
    FCMEQ  V3.8H, V12.8H, #0.0
    FCMGE  V19.4H, V31.4H, #0.0
    MOV V18.S[0x3], W28
    SHA1M  Q30, S10, V18.4S
    DUP V18.4H, W25
    UMAX  V24.16B, V30.16B, V30.16B
    SQRDMULH  V11.4S, V18.4S, V24.S[0x3]
    UQSHL  V24.4S, V15.4S, #0x16
    FCVTZU  V22.8H, V24.8H
    SQRSHRUN2 V31.8H, V22.4S, #12
    ADDP  V1.2S, V19.2S, V19.2S
    SXTL2 V10.8H, V1.16B
    SRI  V1.4S, V11.4S, #29
    SQDMULL2  V19.2D, V3.4S, V5.4S
    SQDMULH  V13.4H, V10.4H, V1.H[0x3]
    FABS  V5.8H, V13.8H
    SSRA  V12.4H, V5.4H, #4
    DUP B24, V31.B[0xc]
    SSHL  V13.2S, V24.2S, V12.2S
    FADDP S11, V13.2S
    UMLSL V15.4S, V19.4H, V7.H[0x4]
    SQSHLU V22.2D, V15.2D, #0x3d
    FCVTZU  V18.8H, V11.8H, #3
    FMAXNMP H12, V18.2H
    SMOV W20, V12.H[0x4]
    FCMEQ  V9.4H, V20.4H, V25.4H
    FMAXNM  V18.8H, V20.8H, V23.8H
    SQRDMULH H13, H18, V13.H[0x7]
    FCVTMU  V7.8H, V26.8H
    FCVTNU  V26.2S, V20.2S
    FCVTZS  V30.4S, V18.4S, #4
    UMLSL V23.2D, V13.2S, V23.S[0x2]
    USRA  V20.4H, V15.4H, #4
    NEG  V13.2S, V9.2S
    FRECPE  V3.8H, V10.8H
    FCVTPU  V10.4S, V5.4S
    CMGT  V25.16B, V7.16B, #0
    CMLT  V18.2S, V30.2S, #0
    RBIT  V9.16B, V13.16B
    FMULX V12.2D, V18.2D, V25.D[0x1]
    FMINNMV  H15, V22.4H
    UQRSHRN V11.2S, V15.2D, #9
    TRN2  V15.8H, V10.8H, V26.8H
    SRSRA V26.2D, V3.2D, #58
    URSHR  V3.8B, V26.8B, #7
    SQSHL  V26.8H, V9.8H, #0x7
    URSRA  V5.16B, V12.16B, #8
    MVN  V30.16B, V15.16B
    FCVTAS  V15.8H, V11.8H
    INS V11.B[0x8], W28
    SLI  V7.8B, V30.8B, #0x6
    UMULL V10.4S, V3.4H, V5.H[0x1]
    SQDMULH  V25.4S, V15.4S, V11.S[0x3]
    UHADD  V12.2S, V26.2S, V20.2S
    SMLAL2 V11.2D, V7.4S, V12.S[0x0]
    SMINV  S30, V10.4S
    UCVTF  V9.4H, V30.4H, #13
    SMLAL V10.2D, V11.2S, V11.S[0x0]
    SMLAL2 V5.2D, V10.4S, V10.S[0x2]
    USQADD  V15.2S, V25.2S
    SMINV  B7, V15.8B
    USRA  V22.8H, V23.8H, #3
    FMUL  V23.8H, V30.8H, V22.8H
    EXT  V18.16B, V23.16B, V23.16B, #0x9
    FMULX V22.4H, V5.4H, V9.H[0x1]
    SQRSHRN V10.2S, V22.2D, #3
    FMIN  V13.8H, V18.8H, V18.8H
    SSHLL V15.8H, V7.8B, #0x5
    MLS  V7.4S, V23.4S, V16.4S
    CMGT  V25.2S, V13.2S, V15.2S
    INS V23.H[0x0], V10.H[0x4]
    FMULX V18.2D, V5.2D, V7.D[0x1]
    SABAL  V30.4S, V25.4H, V25.4H
    SQDMLSL S9, H23, V1.H[0x7]
    MUL  V23.8H, V9.8H, V9.H[0x7]
    FCVTZU  V1.4S, V18.4S, #6
    SRSRA  V18.8B, V31.8B, #6
    SQRSHRUN V9.4H, V30.4S, #16
    TBX  V22.16B, { V1.16B, V2.16B, V3.16B }, V9.16B
    MOV B16, V23.B[0x1]
    USHR V23.2D, V18.2D, #20
    FABD  V9.4H, V23.4H, V23.4H
    SSUBL2  V1.8H, V22.16B, V16.16B
    UQSHRN2 V15.16B, V9.8H, #7
    FMINNMP S13, V1.2S
    FCMGT  V25.2D, V15.2D, V0.2D
    FMAXP H15, V25.2H
    SSRA V11.2D, V15.2D, #33
    SCVTF  V22.8H, V13.8H
    FMINP  V18.2S, V22.2S, V11.2S
    DUP D7, V8.D[0x0]
    FCMGT  V13.2D, V12.2D, #0.0
    UMINV  H31, V17.8H
    USHR  V30.8B, V22.8B, #4
    UADDW2  V8.2D, V5.2D, V2.4S
    FRECPS  V10.4H, V31.4H, V10.4H
    NOT  V22.16B, V20.16B
    SQDMULH  V25.8H, V20.8H, V5.H[0x7]
    UXTL V11.2D, V13.2S
    BIC  V23.2S, #0xef
    SQRDMULH  V12.4H, V7.4H, V2.H[0x3]
    FMAXP  V3.4S, V18.4S, V8.4S
    FCVTZU  V0.4H, V30.4H, #9
    SQRSHRN2 V15.16B, V10.8H, #5
    FCVTN  V10.2S, V0.2D
    UMINV  S16, V10.4S
    SQADD  V9.4S, V4.4S, V22.4S
    SUBS  X24, X24, #0x1
    B.NE  TSRTAdvsimdVectorAllOperation_label_3
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x2020, LSL #0
    MOVK  X13, #0xfb6a, LSL #16
    MOVK  X13, #0xbea7, LSL #32
    MOVK  X13, #0xb4e3, LSL #48
    SUB  X22, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x46f6, LSL #0
    MOVK  X13, #0x5442, LSL #16
    MOVK  X13, #0x752b, LSL #32
    MOVK  X13, #0x6e79, LSL #48
    SUB  X22, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x4c55, LSL #0
    MOVK  X13, #0x8b19, LSL #16
    MOVK  X13, #0x1a27, LSL #32
    MOVK  X13, #0xd18d, LSL #48
    SUB  X22, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x251e, LSL #0
    MOVK  X13, #0x948, LSL #16
    MOVK  X13, #0x7656, LSL #32
    MOVK  X13, #0x5bd5, LSL #48
    SUB  X22, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x4b89, LSL #0
    MOVK  X13, #0xd514, LSL #16
    MOVK  X13, #0x40a3, LSL #32
    MOVK  X13, #0xf92f, LSL #48
    SUB  X22, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x1dbc, LSL #0
    MOVK  X13, #0x68fe, LSL #16
    MOVK  X13, #0xd8f, LSL #32
    MOVK  X13, #0x48b5, LSL #48
    SUB  X22, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xcbef, LSL #0
    MOVK  X13, #0xcc3d, LSL #16
    MOVK  X13, #0x9f93, LSL #32
    MOVK  X13, #0xa7fc, LSL #48
    SUB  X22, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x5e0b, LSL #0
    MOVK  X13, #0xe5d6, LSL #16
    MOVK  X13, #0xe262, LSL #32
    MOVK  X13, #0xc9e4, LSL #48
    SUB  X22, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x1d8e, LSL #0
    MOVK  X13, #0x8744, LSL #16
    MOVK  X13, #0x482a, LSL #32
    MOVK  X13, #0x3eed, LSL #48
    SUB  X22, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x1ae7, LSL #0
    MOVK  X13, #0xb946, LSL #16
    MOVK  X13, #0x21a9, LSL #32
    MOVK  X13, #0x8153, LSL #48
    SUB  X22, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xe598, LSL #0
    MOVK  X13, #0xd90e, LSL #16
    MOVK  X13, #0xd89d, LSL #32
    MOVK  X13, #0xd57a, LSL #48
    SUB  X22, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x7161, LSL #0
    MOVK  X13, #0xcb57, LSL #16
    MOVK  X13, #0x92a9, LSL #32
    MOVK  X13, #0x865f, LSL #48
    SUB  X22, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x4dec, LSL #0
    MOVK  X13, #0x5274, LSL #16
    MOVK  X13, #0xd9e0, LSL #32
    MOVK  X13, #0x5b63, LSL #48
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xac8f, LSL #0
    MOVK  X13, #0xccfa, LSL #16
    MOVK  X13, #0x754c, LSL #32
    MOVK  X13, #0x23bb, LSL #48
    SUB  X22, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xed3a, LSL #0
    MOVK  X13, #0xf2cf, LSL #16
    MOVK  X13, #0xe6e5, LSL #32
    MOVK  X13, #0x725, LSL #48
    SUB  X22, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x324f, LSL #0
    MOVK  X13, #0xd421, LSL #16
    MOVK  X13, #0xfc8d, LSL #32
    MOVK  X13, #0x49c2, LSL #48
    SUB  X22, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x5b8f, LSL #0
    MOVK  X13, #0xb37e, LSL #16
    MOVK  X13, #0xa13, LSL #32
    MOVK  X13, #0x9f2a, LSL #48
    SUB  X22, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x97, LSL #0
    MOVK  X13, #0x800, LSL #16
    MRS  X22, FPSR
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V0.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D0
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V1.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D1
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V2.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D2
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V3.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D3
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V4.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D4
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V5.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D5
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V6.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xeccd, LSL #0
    MOVK  X13, #0xeccd, LSL #16
    FMOV  X22, D6
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V7.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D7
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V8.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D8
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X22, V9.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X22, D9
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V10.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D10
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V11.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D11
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V12.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D12
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V13.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D13
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V14.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D14
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x7f7f, LSL #0
    MOVK  X13, #0x7f7f, LSL #16
    FMOV  X22, V15.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D15
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V16.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D16
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V17.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D17
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V18.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D18
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V19.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D19
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V20.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D20
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V21.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D21
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X22, V22.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X22, D22
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V23.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D23
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V24.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D24
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V25.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D25
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V26.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x4000, LSL #0
    MOVK  X13, #0x4000, LSL #32
    FMOV  X22, D26
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V27.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x1d8e, LSL #0
    MOVK  X13, #0x8744, LSL #16
    MOVK  X13, #0x1d8e, LSL #32
    MOVK  X13, #0x8744, LSL #48
    FMOV  X22, D27
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V28.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D28
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xcbef, LSL #0
    MOVK  X13, #0xcc3d, LSL #16
    MOVK  X13, #0x9f93, LSL #32
    MOVK  X13, #0xa7fc, LSL #48
    FMOV  X22, V29.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x7161, LSL #0
    MOVK  X13, #0xcb57, LSL #16
    MOVK  X13, #0x92a9, LSL #32
    MOVK  X13, #0x865f, LSL #48
    FMOV  X22, D29
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V30.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D30
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V31.D[1]
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D31
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorAllOperation_TestFail
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
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X2
    FMOV  V0.D[1], X8
    FMOV  D1, X29
    FMOV  V1.D[1], X15
    FMOV  D2, X25
    FMOV  V2.D[1], X23
    FMOV  D3, X26
    FMOV  V3.D[1], X28
    FMOV  D4, X24
    FMOV  V4.D[1], X17
    FMOV  D5, X27
    FMOV  V5.D[1], X20
    FMOV  D6, X22
    FMOV  V6.D[1], X22
    FMOV  D7, X9
    FMOV  V7.D[1], X5
    FMOV  D8, X24
    FMOV  V8.D[1], X24
    FMOV  D9, X28
    FMOV  V9.D[1], X8
    FMOV  D10, X5
    FMOV  V10.D[1], X9
    FMOV  D11, X23
    FMOV  V11.D[1], X9
    FMOV  D12, X8
    FMOV  V12.D[1], X7
    FMOV  D13, X12
    FMOV  V13.D[1], X7
    FMOV  D14, X12
    FMOV  V14.D[1], X17
    FMOV  D15, X28
    FMOV  V15.D[1], X17
    FMOV  D16, X28
    FMOV  V16.D[1], X27
    FMOV  D17, X3
    FMOV  V17.D[1], X12
    FMOV  D18, X10
    FMOV  V18.D[1], X28
    FMOV  D19, X26
    FMOV  V19.D[1], X4
    FMOV  D20, X15
    FMOV  V20.D[1], X26
    FMOV  D21, X26
    FMOV  V21.D[1], X22
    FMOV  D22, X4
    FMOV  V22.D[1], X10
    FMOV  D23, X19
    FMOV  V23.D[1], X25
    FMOV  D24, X4
    FMOV  V24.D[1], X3
    FMOV  D25, X17
    FMOV  V25.D[1], X6
    FMOV  D26, X17
    FMOV  V26.D[1], X10
    FMOV  D27, X10
    FMOV  V27.D[1], X24
    FMOV  D28, X19
    FMOV  V28.D[1], X5
    FMOV  D29, X20
    FMOV  V29.D[1], X5
    FMOV  D30, X23
    FMOV  V30.D[1], X23
    FMOV  D31, X19
    FMOV  V31.D[1], X8
    MOVZ  X5, #0xa, LSL #0
TSRTAdvsimdVectorAllOperation_label_4:
    SQXTUN  V28.8B, V30.8H
    FMULX V17.4H, V27.4H, V14.H[0x7]
    SSHLL2 V31.4S, V29.8H, #0xc
    INS V6.D[0x1], X4
    SSUBL  V21.2D, V24.2S, V24.2S
    AESMC  V24.16B, V28.16B
    FCVTZU  V4.8H, V25.8H, #7
    UADDL2  V14.2D, V17.4S, V17.4S
    SADDW  V24.4S, V24.4S, V4.4H
    SMULL V9.4S, V24.4H, V7.H[0x5]
    SMLSL2  V28.2D, V14.4S, V31.4S
    FCVTPS  V28.4H, V21.4H
    SMLAL V25.4S, V6.4H, V6.H[0x4]
    UMAXP  V5.4H, V25.4H, V9.4H
    MLA  V15.8B, V5.8B, V28.8B
    SHA256H  Q29, Q26, V15.4S
    FADDP  V30.2D, V11.2D, V19.2D
    SMLSL2  V26.8H, V29.16B, V3.16B
    FCVTMS  V1.8H, V9.8H
    SQDMULH  V9.8H, V1.8H, V3.H[0x1]
    UMULL2 V28.2D, V26.4S, V30.S[0x1]
    SRSHL  V6.2D, V31.2D, V1.2D
    SQDMULL V7.2D, V21.2S, V19.S[0x1]
    UQRSHRN2 V3.4S, V4.2D, #14
    SABA  V29.4H, V28.4H, V31.4H
    UQRSHRN2 V26.16B, V0.8H, #7
    FMIN  V0.8H, V22.8H, V20.8H
    UQSHL  V14.4S, V2.4S, #0x12
    SQRSHL  V25.8H, V12.8H, V17.8H
    UQSUB  V20.4H, V6.4H, V26.4H
    SQDMULL2  V5.2D, V9.4S, V9.4S
    FSQRT  V27.4H, V20.4H
    CLZ  V20.16B, V25.16B
    UMAXV  S2, V20.4S
    UQRSHRN2 V11.8H, V5.4S, #14
    ORN  V22.16B, V11.16B, V15.16B
    UADDL  V20.4S, V2.4H, V2.4H
    FCMGE  V25.8H, V20.8H, #0.0
    SMULL V9.4S, V29.4H, V14.H[0x5]
    FMINV  S5, V20.4S
    SQXTUN  V4.2S, V25.2D
    SQSHRN2 V1.8H, V22.4S, #11
    CLS  V28.8H, V27.8H
    XTN2  V22.4S, V9.2D
    INS V20.S[0x3], V22.S[0x0]
    SRSHR  V25.8H, V0.8H, #3
    SQDMLAL2 V9.4S, V7.8H, V5.H[0x1]
    FSQRT  V11.4H, V1.4H
    UCVTF  V15.8H, V28.8H, #6
    TBX  V14.8B, { V24.16B, V25.16B, V26.16B, V27.16B }, V20.8B
    SQDMULL S2, H4, V3.H[0x2]
    SQSHL  V3.4S, V2.4S, #0x3
    UXTL V22.4S, V3.4H
    FMAXP S3, V9.2S
    SRHADD  V0.8B, V22.8B, V11.8B
    MVNI  V22.4H, #0x5
    FCVTZU  V2.8H, V14.8H
    FABD  V5.2D, V3.2D, V2.2D
    UMLSL2  V7.8H, V22.16B, V15.16B
    SSHL  V6.8H, V0.8H, V0.8H
    FMINNMP H29, V5.2H
    SMULL V25.2D, V29.2S, V6.S[0x3]
    ADD  V2.8B, V25.8B, V7.8B
    FMOV  V17.2D, #0.31250000
    FMAXNMP D9, V22.2D
    SSHLL2 V27.8H, V6.16B, #0x5
    SQSHRUN2 V6.16B, V6.8H, #7
    UQADD  V15.4S, V29.4S, V1.4S
    SMLAL2 V26.2D, V31.4S, V2.S[0x3]
    FMLS  V5.4S, V16.4S, V11.4S
    ADDV  H0, V21.4H
    SUQADD  V1.4H, V24.4H
    RSUBHN  V25.8B, V5.8H, V17.8H
    FADDP H4, V0.2H
    URSHR V22.2D, V4.2D, #56
    DUP V3.16B, W15
    FCVTPU  V7.2S, V25.2S
    FCVTZU V17.2D, V27.2D, #13
    UXTL V27.2D, V15.2S
    SQRSHRN V20.2S, V22.2D, #24
    UQSHRN V14.4H, V21.4S, #2
    FMAXNMV  S31, V3.4S
    ADDV  H25, V7.4H
    FDIV  V15.2S, V25.2S, V20.2S
    FRECPE  V25.4H, V27.4H
    FADDP  V0.2D, V6.2D, V26.2D
    URSQRTE  V2.2S, V17.2S
    INS V16.S[0x0], V15.S[0x3]
    SMLAL2  V26.4S, V1.8H, V16.8H
    FABD  V15.2S, V2.2S, V26.2S
    SLI V27.2D, V14.2D, #0x12
    SHA256SU0  V7.4S, V0.4S
    SQDMLSL D20, S31, V25.S[0x3]
    FMULX V2.2S, V15.2S, V15.S[0x2]
    SQSHLU V5.2D, V27.2D, #0x12
    FMAXNMP H17, V2.2H
    SHL V2.2D, V7.2D, #0x3e
    FMUL H31, H5, V2.H[0x5]
    RADDHN2  V25.8H, V26.4S, V31.4S
    RSHRN2 V22.4S, V20.2D, #25
    FCVTPU  V6.4S, V25.4S
    FMLS  V24.4S, V22.4S, V17.4S
    REV16  V15.16B, V24.16B
    BIC  V4.4S, #0xa5, LSL #8
    SADDLV  S31, V0.4H
    SQDMLAL D16, S31, V31.S[0x3]
    SADDLV  D5, V6.4S
    FMINNMP D24, V5.2D
    CMHS  V0.8B, V4.8B, V24.8B
    ADDV  B27, V0.16B
    FRINTZ  V17.4H, V15.4H
    BIC  V15.4H, #0x9c
    USHLL2 V26.2D, V27.4S, #0xe
    REV64  V25.4S, V15.4S
    FMINP D4, V16.2D
    FADDP  V20.4H, V17.4H, V4.4H
    ORN  V27.16B, V24.16B, V25.16B
    MOV V4.S[0x3], V26.S[0x2]
    UMINP  V22.8B, V4.8B, V4.8B
    SSHR  V4.2S, V22.2S, #16
    FCVTZS  V15.2D, V4.2D
    UQSHRN V2.8B, V27.8H, #6
    MOV  W4, V20.S[0x0]
    SXTL V22.2D, V15.2S
    SLI  V7.8B, V22.8B, #0x2
    EXT  V5.8B, V7.8B, V7.8B, #0x0
    SQDMULH  V31.8H, V31.8H, V5.8H
    SQRSHRN2 V26.16B, V31.8H, #4
    RSHRN2 V22.8H, V2.4S, #15
    SQRDMULH S16, S22, V22.S[0x3]
    BIT  V22.8B, V16.8B, V16.8B
    SLI  V20.16B, V26.16B, #0x5
    USHR  V0.4S, V22.4S, #19
    SQDMLAL2 V17.4S, V20.8H, V0.H[0x5]
    UQSHRN V4.8B, V5.8H, #5
    CMLT  V6.16B, V6.16B, #0
    UHSUB  V16.16B, V15.16B, V30.16B
    XTN2  V22.4S, V12.2D
    FNEG  V30.8H, V5.8H
    ADDV  B0, V15.16B
    FADDP  V31.4S, V4.4S, V26.4S
    SLI V2.2D, V12.2D, #0x3d
    SMOV  X25, V5.S[0x2]
    SADDLV  S26, V18.4H
    UMLAL2 V7.2D, V26.4S, V6.S[0x0]
    SSHR  V12.8H, V7.8H, #13
    AESD  V20.16B, V12.16B
    SQSHRUN V15.8B, V17.8H, #4
    FCVTZS  V17.4S, V2.4S
    REV32  V4.8H, V0.8H
    UMLSL  V5.2D, V30.2S, V31.2S
    USRA  V0.2S, V26.2S, #23
    UQRSHRN V31.2S, V16.2D, #14
    SADDW  V18.8H, V5.8H, V22.8B
    EXT  V5.8B, V4.8B, V20.8B, #0x3
    CMGE  V4.16B, V17.16B, #0
    UADDLV  H6, V4.8B
    UABAL2  V4.2D, V0.4S, V0.4S
    SQDMLSL V20.4S, V31.4H, V15.H[0x6]
    SQRSHRN2 V15.8H, V18.4S, #4
    SHA256SU0  V7.4S, V6.4S
    SQSHRUN V30.8B, V7.8H, #3
    UQRSHRN2 V7.8H, V11.4S, #12
    SQRSHL  V18.2S, V7.2S, V7.2S
    UQRSHRN2 V11.16B, V5.8H, #3
    UQSHL  V7.8H, V11.8H, #0x2
    SQSHRUN V17.4H, V20.4S, #14
    FCMEQ  V6.2S, V17.2S, V15.2S
    FMLS  V5.4H, V18.4H, V4.4H
    FNEG  V16.8H, V7.8H
    SMINV  S18, V16.4S
    SHL  V0.16B, V30.16B, #0x1
    FADDP S31, V6.2S
    SXTL2 V26.4S, V31.8H
    SQRSHL  V7.8B, V5.8B, V5.8B
    UQSHRN2 V4.16B, V21.8H, #8
    URSRA  V17.2S, V18.2S, #27
    FMAXNMP  V21.4S, V7.4S, V26.4S
    FRSQRTS  V7.8H, V21.8H, V18.8H
    FNEG  V31.8H, V4.8H
    FMINP D16, V0.2D
    UABA  V15.4H, V16.4H, V31.4H
    UMLSL V11.4S, V15.4H, V7.H[0x3]
    ADDV  B30, V9.16B
    SRSRA  V18.16B, V30.16B, #1
    SMULL V6.2D, V17.2S, V11.S[0x0]
    SMULL2  V5.2D, V18.4S, V18.4S
    ORR  V21.4H, #0x44
    SQRSHRN V26.8B, V6.8H, #6
    SQSHLU  V11.8H, V5.8H, #0x6
    UHSUB  V5.2S, V11.2S, V11.2S
    SQRSHRN V11.8B, V5.8H, #1
    FMULX H18, H11, V11.H[0x4]
    MOV V20.H[0x0], V18.H[0x2]
    FMAXP S18, V20.2S
    ADDV  S20, V21.4S
    SRSHR  V21.2S, V20.2S, #11
    ADDP  V17.4S, V18.4S, V26.4S
    EXT  V30.8B, V17.8B, V17.8B, #0x2
    FCVTAS  V16.4S, V21.4S
    FCMEQ  V0.2S, V16.2S, V16.2S
    MOVI  V20.8B, #0x59
    SADDL2  V9.8H, V20.16B, V0.16B
    FCVTPS  V21.8H, V30.8H
    FRINTN  V31.2S, V9.2S
    UADDL  V16.8H, V21.8B, V31.8B
    AESD  V5.16B, V14.16B
    UMLSL V11.4S, V30.4H, V8.H[0x7]
    RSHRN2 V31.4S, V16.2D, #22
    SRSHR  V21.4S, V10.4S, #6
    ADDP  D14, V19.2D
    URSRA  V10.16B, V2.16B, #5
    SCVTF  V0.8H, V23.8H, #3
    SHSUB  V17.4S, V8.4S, V16.4S
    USHLL V16.2D, V30.2S, #0x1d
    UQRSHRN2 V6.4S, V14.2D, #16
    FCVTXN  V19.2S, V5.2D
    SQSHRUN2 V30.16B, V19.8H, #8
    MLS  V2.8H, V15.8H, V6.8H
    UQRSHL  V15.4S, V2.4S, V10.4S
    UCVTF  V6.4H, V14.4H, #4
    SMOV  X27, V11.S[0x2]
    FMAXNM  V10.4H, V6.4H, V0.4H
    USHLL2 V0.8H, V17.16B, #0x1
    URSHR V11.2D, V10.2D, #61
    SQDMLSL2 V14.2D, V16.4S, V30.S[0x1]
    SMLAL2 V30.4S, V0.8H, V15.H[0x6]
    SHA256SU1  V0.4S, V31.4S, V13.4S
    RSUBHN2  V6.8H, V14.4S, V15.4S
    FCVTPU  V23.2S, V0.2S
    SMAXV  H0, V6.8H
    UMLSL2 V17.2D, V30.4S, V0.S[0x1]
    MOV V9.D[0x0], V17.D[0x0]
    FCVTZU  V14.4H, V9.4H, #5
    URSHR  V8.4S, V14.4S, #10
    FMINNMP  V6.4S, V8.4S, V21.4S
    SLI V15.2D, V11.2D, #0x8
    INS V2.B[0xc], V15.B[0x9]
    FMULX S15, S23, V6.S[0x3]
    SQSHRN2 V0.16B, V2.8H, #7
    SQSHRN V9.4H, V15.4S, #4
    FRINTN  V14.2D, V0.2D
    RSHRN V21.4H, V9.4S, #14
    CMGE  V10.8H, V14.8H, #0
    SQDMULL  V15.4S, V21.4H, V10.4H
    SCVTF  V23.2S, V25.2S, #14
    UMOV W15, V18.S[0x0]
    UZP1  V30.8H, V12.8H, V0.8H
    MOV V11.B[0xe], W23
    INS V17.B[0x6], W23
    SQRSHRN2 V2.16B, V10.8H, #6
    SXTL V14.8H, V13.8B
    UQSHL  V21.2S, V4.2S, #0x1c
    MLA  V18.2S, V19.2S, V31.2S
    UMLAL V6.4S, V15.4H, V15.H[0x5]
    SMULL V4.2D, V14.2S, V30.S[0x3]
    FMAXV  S9, V21.4S
    FMAX  V8.2S, V23.2S, V9.2S
    FRINTP  V18.4H, V8.4H
    UXTL2 V23.8H, V17.16B
    FMLA  V6.2S, V4.2S, V6.2S
    UXTL V8.4S, V11.4H
    FMAX  V25.4H, V22.4H, V8.4H
    FRINTM  V17.2D, V25.2D
    TBL  V19.8B, { V30.16B, V31.16B, V0.16B }, V18.8B
    SRI  V8.16B, V17.16B, #6
    FADDP H12, V8.2H
    SQSHRN2 V13.4S, V19.2D, #27
    UQSHL  V8.2D, V23.2D, V13.2D
    NOT  V10.8B, V6.8B
    CMGT  V21.16B, V12.16B, #0
    FACGT  V11.4H, V8.4H, V10.4H
    DUP V19.2D, X20
    FRINTZ  V13.8H, V21.8H
    FMINP D17, V13.2D
    FNEG  V8.8H, V17.8H
    FSUB  V25.2D, V11.2D, V2.2D
    FCVTZU  V12.4S, V19.4S, #14
    FADDP S30, V8.2S
    ADDP  V19.8B, V12.8B, V25.8B
    MVN  V10.8B, V30.8B
    SMOV  X15, V19.H[0x7]
    BIT  V0.8B, V2.8B, V0.8B
    UQSHRN2 V17.4S, V20.2D, #23
    FADDP D4, V29.2D
    SSHR V9.2D, V22.2D, #47
    FNEG  V11.4H, V10.4H
    UCVTF  V30.2D, V3.2D
    FCMLE  V21.4H, V8.4H, #0.0
    FMAXNMP H13, V17.2H
    SCVTF V19.2D, V27.2D, #19
    MOV S31, V2.S[0x0]
    FRINTX  V25.2S, V11.2S
    URSHR  V17.4H, V0.4H, #5
    MOV D2, V19.D[0x0]
    CMLE  V29.4S, V2.4S, #0
    SMULL V0.4S, V21.4H, V14.H[0x7]
    SQSHRUN V2.4H, V30.4S, #12
    MOV V20.H[0x1], V9.H[0x7]
    FMULX H6, H4, V13.H[0x2]
    SUBS  X5, X5, #0x1
    B.NE  TSRTAdvsimdVectorAllOperation_label_4
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x97, LSL #0
    MOVK  X13, #0x800, LSL #16
    MRS  X16, FPSR
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V0.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, D0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V1.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, D1
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V2.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, D2
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V3.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, D3
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V4.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, D4
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x5252, LSL #0
    MOVK  X13, #0x5252, LSL #16
    MOVK  X13, #0x5252, LSL #32
    MOVK  X13, #0x5252, LSL #48
    FMOV  X16, V5.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x5252, LSL #0
    MOVK  X13, #0x5252, LSL #16
    MOVK  X13, #0x5252, LSL #32
    MOVK  X13, #0x5252, LSL #48
    FMOV  X16, D5
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V6.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, D6
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x3e00, LSL #0
    MOVK  X13, #0x3e00, LSL #16
    MOVK  X13, #0x3e00, LSL #32
    MOVK  X13, #0x3e00, LSL #48
    FMOV  X16, V7.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x3e00, LSL #0
    MOVK  X13, #0x3e00, LSL #16
    MOVK  X13, #0x3e00, LSL #32
    MOVK  X13, #0x3e00, LSL #48
    FMOV  X16, D7
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x8000, LSL #0
    MOVK  X13, #0x8000, LSL #16
    MOVK  X13, #0x8000, LSL #32
    MOVK  X13, #0x8000, LSL #48
    FMOV  X16, V8.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x8000, LSL #0
    MOVK  X13, #0x8000, LSL #16
    MOVK  X13, #0x8000, LSL #32
    MOVK  X13, #0x8000, LSL #48
    FMOV  X16, D8
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V9.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, D9
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V10.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0x7fff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X16, D10
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V11.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x7fff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0x7fff, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    FMOV  X16, D11
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V12.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, D12
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V13.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, D13
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V14.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, D14
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V15.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, D15
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x4000, LSL #32
    MOVK  X13, #0xa4a, LSL #48
    FMOV  X16, V16.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x4000, LSL #16
    MOVK  X13, #0xa4a, LSL #32
    FMOV  X16, D16
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V17.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x10c, LSL #0
    FMOV  X16, D17
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V18.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    FMOV  X16, D18
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xbec0, LSL #48
    FMOV  X16, V19.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xbec0, LSL #48
    FMOV  X16, D19
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V20.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x5959, LSL #0
    MOVK  X13, #0x5959, LSL #32
    MOVK  X13, #0x5959, LSL #48
    FMOV  X16, D20
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V21.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X16, D21
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V22.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, D22
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xe6, LSL #0
    MOVK  X13, #0x3f, LSL #16
    MOVK  X13, #0xc0, LSL #48
    FMOV  X16, V23.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x40, LSL #16
    MOVK  X13, #0xc0, LSL #48
    FMOV  X16, D23
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V24.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, D24
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V25.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x7fff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0x7fff, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    FMOV  X16, D25
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V26.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x7f80, LSL #0
    MOVK  X13, #0x7c80, LSL #32
    FMOV  X16, D26
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X16, V27.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X16, D27
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xf, LSL #0
    MOVK  X13, #0xf, LSL #16
    MOVK  X13, #0xf, LSL #32
    MOVK  X13, #0xf, LSL #48
    FMOV  X16, V28.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xf, LSL #16
    MOVK  X13, #0xf, LSL #48
    FMOV  X16, D28
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X16, V29.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X16, D29
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V30.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, D30
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V31.D[1]
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xa1ff, LSL #0
    MOVK  X13, #0xaf02, LSL #16
    FMOV  X16, D31
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorAllOperation_TestFail
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
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
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
    FMOV  D0, X27
    FMOV  V0.D[1], X26
    FMOV  D1, X29
    FMOV  V1.D[1], X28
    FMOV  D2, X25
    FMOV  V2.D[1], X15
    FMOV  D3, X17
    FMOV  V3.D[1], X16
    FMOV  D4, X6
    FMOV  V4.D[1], X17
    FMOV  D5, X2
    FMOV  V5.D[1], X6
    FMOV  D6, X27
    FMOV  V6.D[1], X9
    FMOV  D7, X15
    FMOV  V7.D[1], X23
    FMOV  D8, X28
    FMOV  V8.D[1], X23
    FMOV  D9, X3
    FMOV  V9.D[1], X13
    FMOV  D10, X25
    FMOV  V10.D[1], X8
    FMOV  D11, X10
    FMOV  V11.D[1], X8
    FMOV  D12, X28
    FMOV  V12.D[1], X15
    FMOV  D13, X6
    FMOV  V13.D[1], X13
    FMOV  D14, X9
    FMOV  V14.D[1], X6
    FMOV  D15, X15
    FMOV  V15.D[1], X12
    FMOV  D16, X23
    FMOV  V16.D[1], X19
    FMOV  D17, X23
    FMOV  V17.D[1], X13
    FMOV  D18, X3
    FMOV  V18.D[1], X16
    FMOV  D19, X28
    FMOV  V19.D[1], X29
    FMOV  D20, X12
    FMOV  V20.D[1], X10
    FMOV  D21, X5
    FMOV  V21.D[1], X5
    FMOV  D22, X3
    FMOV  V22.D[1], X3
    FMOV  D23, X13
    FMOV  V23.D[1], X15
    FMOV  D24, X28
    FMOV  V24.D[1], X28
    FMOV  D25, X15
    FMOV  V25.D[1], X6
    FMOV  D26, X20
    FMOV  V26.D[1], X20
    FMOV  D27, X7
    FMOV  V27.D[1], X25
    FMOV  D28, X17
    FMOV  V28.D[1], X19
    FMOV  D29, X8
    FMOV  V29.D[1], X9
    FMOV  D30, X7
    FMOV  V30.D[1], X9
    FMOV  D31, X3
    FMOV  V31.D[1], X17
    MOVZ  X8, #0xa, LSL #0
TSRTAdvsimdVectorAllOperation_label_5:
    MOV D28, V20.D[0x0]
    SQSHLU V20.2D, V29.2D, #0x1e
    FMAXP  V28.2D, V27.2D, V20.2D
    TRN2  V5.2D, V25.2D, V31.2D
    FMINP  V9.4H, V26.4H, V24.4H
    FMLA V12.2D, V28.2D, V9.D[0x1]
    SQDMLSL2 V14.4S, V23.8H, V5.H[0x0]
    FRINTZ  V31.4S, V30.4S
    SHA1P  Q11, S12, V12.4S
    SMLSL  V29.8H, V11.8B, V22.8B
    SHA1SU0  V9.4S, V14.4S, V14.4S
    UQXTN  V2.4H, V29.4S
    FACGE  V8.4S, V9.4S, V9.4S
    FCVTAU  V12.2D, V31.2D
    UMLSL2  V26.2D, V12.4S, V8.4S
    SMLSL  V23.4S, V26.4H, V2.4H
    FRINTP  V31.2D, V23.2D
    FMLA S2, S8, V30.S[0x2]
    SADDL  V24.2D, V8.2S, V2.2S
    RBIT  V26.8B, V3.8B
    SRHADD  V2.8H, V11.8H, V16.8H
    SQDMULH  V25.4H, V26.4H, V0.H[0x5]
    DUP V14.4S, W28
    FDIV  V29.2D, V9.2D, V12.2D
    MOV V28.H[0x5], W19
    FRINTZ  V23.8H, V4.8H
    TRN1  V9.4S, V28.4S, V30.4S
    SQDMULH  V12.4S, V22.4S, V17.4S
    URSRA  V3.16B, V31.16B, #1
    DUP H5, V29.H[0x1]
    FMLA V29.2S, V9.2S, V5.S[0x3]
    MVNI  V20.4S, #0xca
    FMLS S8, S2, V23.S[0x0]
    UADDLV  D23, V3.4S
    SQDMULL2 V30.4S, V14.8H, V12.H[0x3]
    EXT  V14.16B, V29.16B, V25.16B, #0x9
    URSRA  V25.4H, V20.4H, #16
    SADDW  V2.8H, V8.8H, V25.8B
    MOVI  V12.4S, #0x57, MSL #16
    FCVTNS  V22.8H, V14.8H
    FNEG  V29.2D, V30.2D
    SRSRA  V8.8H, V22.8H, #1
    SRSRA  V17.2S, V2.2S, #27
    SADDL  V3.8H, V29.8B, V23.8B
    SLI  V25.4S, V24.4S, #0xd
    UMLSL2 V4.4S, V25.8H, V12.H[0x2]
    USUBL  V26.8H, V6.8B, V8.8B
    FMINNMP  V25.8H, V26.8H, V4.8H
    FSUB  V24.4H, V25.4H, V1.4H
    SQSHL  V26.8B, V24.8B, #0x1
    USUBW  V1.8H, V17.8H, V17.8B
    CMLE  V28.8H, V1.8H, #0
    UMULL V6.4S, V3.4H, V3.H[0x6]
    FMAXNMP  V22.8H, V28.8H, V26.8H
    SMLAL  V1.2D, V22.2S, V6.2S
    SHRN V20.2S, V28.2D, #1
    FRECPE  V12.8H, V18.8H
    SXTL V18.2D, V3.2S
    CMEQ  V4.4S, V0.4S, #0
    USHLL V17.4S, V8.4H, #0x4
    SHRN2 V23.16B, V31.8H, #6
    SHRN2 V29.8H, V17.4S, #8
    UCVTF  V14.4S, V2.4S, #9
    FMIN  V25.4S, V7.4S, V25.4S
    SQDMLAL V7.4S, V23.4H, V6.H[0x1]
    FRINTX  V23.8H, V7.8H
    FMUL D30, D29, V23.D[0x1]
    FCMGE  V31.2S, V1.2S, V30.2S
    FMULX V23.2D, V14.2D, V12.D[0x0]
    SQDMLSL2  V22.4S, V25.8H, V31.8H
    FADDP S26, V22.2S
    URHADD  V22.4S, V18.4S, V11.4S
    FMULX V17.2S, V4.2S, V23.S[0x3]
    SQSHRUN V28.2S, V22.2D, #25
    FCVTXN2  V2.4S, V26.2D
    USUBW2  V14.8H, V28.8H, V17.16B
    FCVTZU  V6.4H, V2.4H
    SMLSL V11.2D, V14.2S, V14.S[0x0]
    FRINTZ  V4.4H, V6.4H
    USRA V28.2D, V11.2D, #58
    FSUB  V12.4S, V20.4S, V4.4S
    FRINTI  V17.8H, V12.8H
    SQDMLAL V7.2D, V28.2S, V17.S[0x2]
    SMOV  X26, V16.H[0x7]
    FMLA D31, D3, V11.D[0x1]
    UQXTN  V26.8B, V13.8H
    UQSUB  V11.16B, V15.16B, V13.16B
    SSHL  V25.16B, V30.16B, V27.16B
    MOV  V14.8B, V8.8B
    SSHR  V18.16B, V22.16B, #6
    FCMEQ  V3.2S, V7.2S, V6.2S
    SQRSHRN V16.2S, V14.2D, #16
    FMAXP D22, V12.2D
    SMINV  H30, V23.4H
    SQDMULL2 V14.2D, V31.4S, V11.S[0x0]
    RADDHN2  V17.16B, V16.8H, V25.8H
    SQSHLU  V23.4S, V30.4S, #0x1f
    UQSHL  V31.2S, V3.2S, V26.2S
    PMUL  V30.16B, V17.16B, V23.16B
    SMLAL V25.2D, V27.2S, V18.S[0x1]
    USUBL  V20.4S, V25.4H, V31.4H
    SCVTF  V25.2D, V20.2D
    UQSHL  V12.2S, V14.2S, V28.2S
    SQSHL  V13.8B, V30.8B, #0x6
    FCMGT  V11.8H, V25.8H, #0.0
    CMTST  V28.2D, V20.2D, V12.2D
    SHA1SU0  V15.4S, V13.4S, V22.4S
    SABA  V13.16B, V15.16B, V11.16B
    FMAXNMP H20, V28.2H
    RSHRN2 V14.16B, V20.8H, #8
    SLI  V28.16B, V14.16B, #0x7
    UMAXV  H3, V13.4H
    UQSHL  V7.8H, V28.8H, #0x1
    TBL  V25.8B, { V25.16B, V26.16B, V27.16B }, V27.8B
    SSHLL2 V18.2D, V25.4S, #0xa
    ORR  V23.8B, V3.8B, V18.8B
    SHA1M  Q16, S7, V23.4S
    SHA1M  Q3, S11, V23.4S
    SQDMLAL  V12.4S, V17.4H, V21.4H
    SSUBW  V13.8H, V30.8H, V18.8B
    USRA  V27.8H, V6.8H, #10
    UMOV X7, V15.D[0x0]
    FMAXNMP S25, V13.2S
    MLS  V17.4S, V17.4S, V17.4S
    FMUL  V15.2D, V27.2D, V20.2D
    FMLS V30.4H, V20.4H, V11.H[0x3]
    SLI V14.2D, V18.2D, #0xf
    SRI  V23.16B, V29.16B, #2
    UADDW  V31.4S, V12.4S, V23.4H
    SSHL  V22.4H, V14.4H, V3.4H
    DUP V18.2D, X4
    FRINTN  V7.4S, V25.4S
    UADDW2  V15.8H, V7.8H, V2.16B
    ORR  V13.8H, #0xc6, LSL #8
    FSUB  V26.4S, V18.4S, V31.4S
    FMLS D12, D15, V30.D[0x1]
    USUBW  V3.8H, V17.8H, V22.8B
    FMLA H20, H12, V13.H[0x3]
    CMLE  V6.2S, V26.2S, #0
    SABD  V14.4H, V20.4H, V6.4H
    DUP V20.2D, X7
    DUP H6, V16.H[0x5]
    SHRN2 V11.16B, V3.8H, #6
    MLA  V12.4S, V30.4S, V9.S[0x1]
    NEG  V30.8H, V12.8H
    FMUL  V25.8H, V14.8H, V14.8H
    SQSHLU  V12.16B, V11.16B, #0x4
    SSUBW2  V27.2D, V6.2D, V12.4S
    RSUBHN2  V7.4S, V25.2D, V27.2D
    SHLL2  V16.2D, V5.4S, #32
    SHSUB  V27.8H, V20.8H, V16.8H
    SMLAL2  V11.2D, V27.4S, V7.4S
    USRA  V13.2S, V5.2S, #26
    SRI  V2.4S, V30.4S, #22
    SQRSHRN V20.4H, V2.4S, #9
    MOV V3.D[0x0], V11.D[0x0]
    FCVTN2  V26.4S, V20.2D
    FCVTAU  V9.4H, V13.4H
    INS V20.S[0x0], W2
    FMINP  V14.2S, V3.2S, V20.2S
    CMGE  V20.4S, V4.4S, #0
    SQSHRN V13.8B, V14.8H, #5
    SQDMLAL V14.2D, V13.2S, V9.S[0x3]
    ORR  V18.4H, #0x15, LSL #8
    FCVTNS  V30.4H, V20.4H
    UQSHRN2 V3.16B, V26.8H, #7
    SCVTF  V9.2S, V17.2S, #8
    SQRSHRUN V7.8B, V9.8H, #5
    UMLSL2 V16.4S, V30.8H, V4.H[0x6]
    FRINTI  V27.2S, V7.2S
    SLI  V13.4H, V14.4H, #0xc
    SQDMULL V2.4S, V26.4H, V13.H[0x3]
    FMULX V20.2D, V2.2D, V2.D[0x1]
    FACGT  V13.8H, V3.8H, V20.8H
    USHLL V14.8H, V18.8B, #0x5
    FABS  V26.8H, V10.8H
    SSHL  V10.8B, V16.8B, V26.8B
    FCVTNU  V26.4S, V13.4S
    SXTL2 V16.8H, V6.16B
    UMINV  B9, V10.8B
    FCMGT  V11.4S, V14.4S, #0.0
    SQDMULH  V2.2S, V26.2S, V9.S[0x1]
    SQRDMULH  V5.4H, V27.4H, V16.4H
    SMULL2 V3.4S, V11.8H, V11.H[0x1]
    SHA1C  Q17, S2, V27.4S
    MOVI  V20.8B, #0x60
    FCVTZS  V10.4H, V20.4H, #4
    FMLS  V26.4H, V5.4H, V17.4H
    MOV  V17.16B, V26.16B
    SQSHRUN2 V11.16B, V10.8H, #7
    UXTL2 V20.2D, V3.4S
    ADDHN  V13.8B, V20.8H, V17.8H
    UMLSL V7.4S, V11.4H, V11.H[0x6]
    CMEQ  V9.8H, V7.8H, #0
    FMIN  V18.4H, V9.4H, V9.4H
    SMLSL2 V6.4S, V18.8H, V13.H[0x3]
    FMINNMP S18, V29.2S
    SQRDMULH  V20.4S, V21.4S, V16.S[0x2]
    SMLAL V17.2D, V12.2S, V12.S[0x0]
    SQDMULL2  V5.4S, V0.8H, V17.8H
    FCVTMS  V21.4H, V22.4H
    FRINTM  V26.8H, V24.8H
    SCVTF  V0.4H, V7.4H, #9
    FRECPS  V27.8H, V3.8H, V28.8H
    UQXTN  V13.4H, V28.4S
    SMIN  V16.8B, V6.8B, V24.8B
    SSHL  V12.4H, V18.4H, V18.4H
    SRSRA V14.2D, V5.2D, #20
    BIF  V17.16B, V12.16B, V14.16B
    FMAXP  V3.2S, V20.2S, V20.2S
    RSHRN2 V11.16B, V3.8H, #4
    SRSHR V20.2D, V0.2D, #32
    SQRDMULH S22, S28, V16.S[0x0]
    FMINNMV  S3, V21.4S
    CMTST  V28.2S, V13.2S, V17.2S
    FMAXNMP  V16.4H, V21.4H, V1.4H
    SCVTF  V1.4H, V26.4H
    FMAX  V29.4S, V11.4S, V3.4S
    REV64  V12.4S, V27.4S
    CMGE  V14.8H, V20.8H, V20.8H
    TBL  V6.16B, { V13.16B, V14.16B, V15.16B, V16.16B }, V14.16B
    FRINTX  V0.4H, V12.4H
    SXTL V15.2D, V22.2S
    SSHR  V24.4H, V28.4H, #15
    SXTL2 V27.8H, V28.16B
    SCVTF  V17.8H, V1.8H
    SHADD  V5.4S, V17.4S, V29.4S
    UMLAL2 V21.4S, V5.8H, V14.H[0x3]
    UQSHRN2 V26.16B, V21.8H, #5
    SHL  V21.2S, V6.2S, #0x9
    FNEG  V12.4S, V24.4S
    DUP V29.4S, W5
    FSUB  V5.4H, V0.4H, V27.4H
    INS V1.S[0x2], V26.S[0x3]
    FRINTP  V20.2S, V15.2S
    SLI  V3.2S, V21.2S, #0x8
    FMLA V28.2D, V20.2D, V5.D[0x1]
    SQNEG  V6.2D, V12.2D
    SQSHLU  V22.2S, V29.2S, #0x4
    FCVTL  V17.4S, V22.4H
    FADDP  V15.4S, V28.4S, V17.4S
    SSHR  V21.2S, V6.2S, #31
    DUP V22.2D, V15.D[0x0]
    SRSHR  V29.8H, V3.8H, #8
    ORR  V15.8H, #0x87
    FCVTPS  V3.4S, V1.4S
    USHR  V6.8H, V15.8H, #1
    FRINTN  V12.8H, V29.8H
    CMEQ  V28.8H, V12.8H, #0
    MLS  V5.2S, V28.2S, V21.S[0x3]
    UADDLV  D14, V6.4S
    SLI  V15.8B, V5.8B, #0x2
    SQSHRN2 V26.8H, V22.4S, #16
    FMUL S24, S15, V15.S[0x3]
    FCMGE  V6.8H, V3.8H, #0.0
    UQSUB  V5.16B, V14.16B, V26.16B
    SABAL2  V22.2D, V24.4S, V6.4S
    UMLAL V1.2D, V22.2S, V22.S[0x0]
    SABDL2  V12.8H, V1.16B, V1.16B
    CLZ  V17.4H, V12.4H
    FCVTZS  V24.2D, V5.2D
    SQABS  V12.4H, V24.4H
    SCVTF  V1.4H, V27.4H
    FCVTAS  V29.4H, V17.4H
    SQDMULL V3.4S, V12.4H, V1.H[0x0]
    PMULL2  V27.1Q, V3.2D, V3.2D
    SQRSHRUN2 V28.4S, V27.2D, #19
    SABA  V1.4S, V28.4S, V28.4S
    SQDMLAL V3.2D, V29.2S, V29.S[0x3]
    UQSHRN V12.2S, V1.2D, #13
    SHRN V15.4H, V12.4S, #11
    SQSHRN V12.8B, V3.8H, #6
    TBX  V21.8B, { V28.16B, V29.16B }, V19.8B
    UMOV W3, V21.B[0xd]
    UCVTF  V6.2S, V15.2S, #13
    SQDMLSL V30.4S, V12.4H, V6.H[0x7]
    MOV V22.H[0x4], V17.H[0x4]
    DUP B15, V15.B[0x7]
    REV16  V17.16B, V13.16B
    SQSUB  V28.2S, V15.2S, V25.2S
    SABA  V25.2S, V29.2S, V9.2S
    UADDW  V24.2D, V5.2D, V13.2S
    UMINP  V14.4S, V15.4S, V14.4S
    SQRSHL  V15.16B, V21.16B, V24.16B
    CMGE  V27.16B, V3.16B, #0
    SQDMULL2 V5.4S, V6.8H, V0.H[0x1]
    CMGT  V19.4H, V30.4H, #0
    TRN1  V1.4H, V14.4H, V19.4H
    ZIP2  V9.2S, V1.2S, V1.2S
    UADDLV  H1, V9.8B
    SQRSHRN V29.8B, V17.8H, #5
    SRHADD  V12.2S, V22.2S, V5.2S
    URSRA  V30.8H, V27.8H, #2
    SHL  V19.4H, V1.4H, #0x1
    SMAXV  S13, V30.4S
    UADDLV  H30, V28.8B
    SQABS  V27.4H, V25.4H
    SRHADD  V22.2S, V15.2S, V13.2S
    SQRDMULH S1, S14, V30.S[0x0]
    SHADD  V15.8B, V12.8B, V1.8B
    SUBS  X8, X8, #0x1
    B.NE  TSRTAdvsimdVectorAllOperation_label_5
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x97, LSL #0
    MOVK  X13, #0x800, LSL #16
    MRS  X25, FPSR
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V0.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x4000, LSL #0
    MOVK  X13, #0x4000, LSL #16
    MOVK  X13, #0x4000, LSL #32
    MOVK  X13, #0x4000, LSL #48
    FMOV  X25, D0
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V1.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, D1
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V2.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, D2
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V3.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, D3
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V4.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, D4
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V5.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, D5
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V6.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, D6
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V7.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, D7
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V8.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    FMOV  X25, D8
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V9.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, D9
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V10.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x2300, LSL #0
    MOVK  X13, #0x2300, LSL #16
    MOVK  X13, #0x2300, LSL #32
    MOVK  X13, #0x2300, LSL #48
    FMOV  X25, D10
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V11.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X25, D11
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V12.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x1, LSL #0
    FMOV  X25, D12
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V13.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x4000, LSL #0
    MOVK  X13, #0x4000, LSL #16
    FMOV  X25, D13
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V14.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, D14
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V15.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, D15
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V16.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, D16
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V17.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, D17
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V18.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8000, LSL #16
    FMOV  X25, D18
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V19.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, D19
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V20.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, D20
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V21.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X25, D21
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V22.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x9fc0, LSL #0
    MOVK  X13, #0x1fc0, LSL #16
    FMOV  X25, D22
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x33f, LSL #0
    MOVK  X13, #0x33f, LSL #16
    FMOV  X25, V23.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x8080, LSL #0
    MOVK  X13, #0x2000, LSL #48
    FMOV  X25, D23
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V24.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xb, LSL #0
    MOVK  X13, #0xb, LSL #16
    FMOV  X25, D24
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V25.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x8000, LSL #0
    MOVK  X13, #0x1, LSL #32
    FMOV  X25, D25
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V26.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xff01, LSL #0
    MOVK  X13, #0xff01, LSL #16
    MOVK  X13, #0x8000, LSL #32
    MOVK  X13, #0x8000, LSL #48
    FMOV  X25, D26
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V27.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x7fff, LSL #0
    MOVK  X13, #0x1, LSL #32
    FMOV  X25, D27
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V28.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x8001, LSL #0
    MOVK  X13, #0xffff, LSL #16
    FMOV  X25, D28
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V29.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, D29
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V30.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x27f, LSL #0
    FMOV  X25, D30
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x2, LSL #0
    MOVK  X13, #0x2002, LSL #32
    FMOV  X25, V31.D[1]
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x8082, LSL #0
    MOVK  X13, #0x2, LSL #32
    FMOV  X25, D31
    SUB  X20, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X2, #0x7a83, LSL #0
    MOVK  X2, #0x4ba4, LSL #16
    MOVK  X2, #0xf553, LSL #32
    MOVK  X2, #0x2a2, LSL #48
    MOVZ  X3, #0x941c, LSL #0
    MOVK  X3, #0xfc09, LSL #16
    MOVK  X3, #0x9172, LSL #32
    MOVK  X3, #0x35f8, LSL #48
    MOVZ  X4, #0x37c1, LSL #0
    MOVK  X4, #0x200a, LSL #16
    MOVK  X4, #0x854b, LSL #32
    MOVK  X4, #0x7101, LSL #48
    MOVZ  X5, #0x2895, LSL #0
    MOVK  X5, #0xf040, LSL #16
    MOVK  X5, #0x2cfc, LSL #32
    MOVK  X5, #0xf0c8, LSL #48
    MOVZ  X6, #0xdb12, LSL #0
    MOVK  X6, #0x3d4b, LSL #16
    MOVK  X6, #0xb0da, LSL #32
    MOVK  X6, #0x2a87, LSL #48
    MOVZ  X7, #0xda43, LSL #0
    MOVK  X7, #0x87a3, LSL #16
    MOVK  X7, #0xd35e, LSL #32
    MOVK  X7, #0xa42f, LSL #48
    MOVZ  X8, #0x8372, LSL #0
    MOVK  X8, #0xb454, LSL #16
    MOVK  X8, #0xde4a, LSL #32
    MOVK  X8, #0xf313, LSL #48
    MOVZ  X9, #0xbb90, LSL #0
    MOVK  X9, #0xe94e, LSL #16
    MOVK  X9, #0x2998, LSL #32
    MOVK  X9, #0xf153, LSL #48
    MOVZ  X10, #0xaaa2, LSL #0
    MOVK  X10, #0x1f19, LSL #16
    MOVK  X10, #0x6904, LSL #32
    MOVK  X10, #0x8bc7, LSL #48
    MOVZ  X12, #0x33b2, LSL #0
    MOVK  X12, #0x499e, LSL #16
    MOVK  X12, #0x3c4e, LSL #32
    MOVK  X12, #0xe2a7, LSL #48
    MOVZ  X13, #0x4f2c, LSL #0
    MOVK  X13, #0x4a5c, LSL #16
    MOVK  X13, #0xd7bc, LSL #32
    MOVK  X13, #0x9432, LSL #48
    MOVZ  X15, #0x9975, LSL #0
    MOVK  X15, #0x8a85, LSL #16
    MOVK  X15, #0x4e47, LSL #32
    MOVK  X15, #0x8f3d, LSL #48
    MOVZ  X16, #0x2416, LSL #0
    MOVK  X16, #0x41d5, LSL #16
    MOVK  X16, #0x3d76, LSL #32
    MOVK  X16, #0x45ab, LSL #48
    MOVZ  X17, #0xe451, LSL #0
    MOVK  X17, #0x79ec, LSL #16
    MOVK  X17, #0x803c, LSL #32
    MOVK  X17, #0xa96f, LSL #48
    MOVZ  X19, #0x3931, LSL #0
    MOVK  X19, #0xb71c, LSL #16
    MOVK  X19, #0x876, LSL #32
    MOVK  X19, #0xe891, LSL #48
    MOVZ  X20, #0x91c8, LSL #0
    MOVK  X20, #0xacfd, LSL #16
    MOVK  X20, #0x6da9, LSL #32
    MOVK  X20, #0x2ebe, LSL #48
    MOVZ  X22, #0xc2d6, LSL #0
    MOVK  X22, #0x3d11, LSL #16
    MOVK  X22, #0x2864, LSL #32
    MOVK  X22, #0x3625, LSL #48
    MOVZ  X23, #0xb7a8, LSL #0
    MOVK  X23, #0x6640, LSL #16
    MOVK  X23, #0x8482, LSL #32
    MOVK  X23, #0xfc89, LSL #48
    MOVZ  X24, #0xbab9, LSL #0
    MOVK  X24, #0xc8bf, LSL #16
    MOVK  X24, #0xf3ee, LSL #32
    MOVK  X24, #0xe17f, LSL #48
    MOVZ  X25, #0x5695, LSL #0
    MOVK  X25, #0x7853, LSL #16
    MOVK  X25, #0xf32a, LSL #32
    MOVK  X25, #0xd634, LSL #48
    MOVZ  X26, #0xe62a, LSL #0
    MOVK  X26, #0x420e, LSL #16
    MOVK  X26, #0x6345, LSL #32
    MOVK  X26, #0x1f49, LSL #48
    MOVZ  X27, #0x7663, LSL #0
    MOVK  X27, #0x4f2, LSL #16
    MOVK  X27, #0xcf3e, LSL #32
    MOVK  X27, #0x69c2, LSL #48
    MOVZ  X28, #0x2c82, LSL #0
    MOVK  X28, #0x14ad, LSL #16
    MOVK  X28, #0x5685, LSL #32
    MOVK  X28, #0xa5f1, LSL #48
    MOVZ  X29, #0xde22, LSL #0
    MOVK  X29, #0x98b0, LSL #16
    MOVK  X29, #0xfde0, LSL #32
    MOVK  X29, #0x4f50, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X26
    FMOV  D1, X25
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X7
    FMOV  D3, X20
    FMOV  V3.D[1], X29
    FMOV  D4, X26
    FMOV  V4.D[1], X13
    FMOV  D5, X20
    FMOV  V5.D[1], X15
    FMOV  D6, X23
    FMOV  V6.D[1], X28
    FMOV  D7, X17
    FMOV  V7.D[1], X17
    FMOV  D8, X17
    FMOV  V8.D[1], X25
    FMOV  D9, X13
    FMOV  V9.D[1], X19
    FMOV  D10, X13
    FMOV  V10.D[1], X7
    FMOV  D11, X3
    FMOV  V11.D[1], X3
    FMOV  D12, X5
    FMOV  V12.D[1], X22
    FMOV  D13, X24
    FMOV  V13.D[1], X6
    FMOV  D14, X19
    FMOV  V14.D[1], X29
    FMOV  D15, X6
    FMOV  V15.D[1], X13
    FMOV  D16, X13
    FMOV  V16.D[1], X24
    FMOV  D17, X4
    FMOV  V17.D[1], X28
    FMOV  D18, X5
    FMOV  V18.D[1], X19
    FMOV  D19, X13
    FMOV  V19.D[1], X22
    FMOV  D20, X17
    FMOV  V20.D[1], X2
    FMOV  D21, X25
    FMOV  V21.D[1], X22
    FMOV  D22, X16
    FMOV  V22.D[1], X20
    FMOV  D23, X19
    FMOV  V23.D[1], X17
    FMOV  D24, X5
    FMOV  V24.D[1], X6
    FMOV  D25, X9
    FMOV  V25.D[1], X27
    FMOV  D26, X23
    FMOV  V26.D[1], X9
    FMOV  D27, X26
    FMOV  V27.D[1], X9
    FMOV  D28, X20
    FMOV  V28.D[1], X2
    FMOV  D29, X15
    FMOV  V29.D[1], X25
    FMOV  D30, X16
    FMOV  V30.D[1], X6
    FMOV  D31, X20
    FMOV  V31.D[1], X5
    MOVZ  X24, #0xa, LSL #0
TSRTAdvsimdVectorAllOperation_label_6:
    UXTL2 V4.4S, V17.8H
    INS V18.B[0xb], W22
    UMULL2 V15.4S, V29.8H, V4.H[0x4]
    URSRA V13.2D, V28.2D, #59
    FDIV  V31.4S, V22.4S, V18.4S
    SMINV  B6, V27.8B
    SHA256SU0  V19.4S, V26.4S
    BSL  V16.16B, V6.16B, V19.16B
    FMAXNMV  S19, V31.4S
    XTN  V18.8B, V19.8H
    UCVTF V16.2D, V15.2D, #56
    USUBW  V10.8H, V30.8H, V30.8B
    UQSHL V8.2D, V23.2D, #0x15
    URSRA V13.2D, V18.2D, #17
    SQRDMULH S23, S10, V13.S[0x1]
    URSRA  V29.16B, V16.16B, #7
    UZP2  V4.4H, V29.4H, V29.4H
    FRSQRTS  V15.4S, V23.4S, V4.4S
    FMAXNM  V5.4H, V15.4H, V15.4H
    FRSQRTS  V6.2S, V5.2S, V8.2S
    SQDMULL2  V30.2D, V25.4S, V14.4S
    FMINNMV  H4, V18.4H
    FRINTI  V29.4S, V17.4S
    SSUBL  V14.8H, V30.8B, V1.8B
    SHRN2 V8.4S, V24.2D, #16
    SSHR  V15.8H, V3.8H, #9
    SADDLV  H1, V10.8B
    FMIN  V18.4S, V23.4S, V17.4S
    ADDV  B13, V8.16B
    SRSHL  V24.4H, V2.4H, V4.4H
    CLS  V23.8H, V27.8H
    SRSRA  V27.16B, V14.16B, #4
    SADDL  V5.2D, V27.2S, V7.2S
    MOV V30.S[0x1], W20
    SQABS  V25.2S, V24.2S
    INS V7.B[0x2], W5
    ZIP2  V24.8H, V29.8H, V6.8H
    UHADD  V6.8B, V15.8B, V18.8B
    FMOV  V3.8H, #-0.20312500
    FCMGE  V14.2D, V12.2D, #0.0
    FCVTL  V4.4S, V14.4H
    SHA256SU1  V27.4S, V4.4S, V4.4S
    UQRSHRN V17.2S, V5.2D, #21
    BIF  V29.8B, V3.8B, V1.8B
    CMLT  V3.2D, V27.2D, #0
    SQRSHRUN V15.4H, V17.4S, #7
    TBL  V2.16B, { V15.16B, V16.16B }, V6.16B
    URSRA  V8.8H, V2.8H, #9
    SQSHLU V4.2D, V25.2D, #0x35
    SQSHRUN2 V27.8H, V23.4S, #11
    MOV S5, V27.S[0x0]
    SQRSHRN2 V12.4S, V8.2D, #19
    SMLAL V1.4S, V4.4H, V5.H[0x7]
    FCVTNU  V2.4H, V24.4H
    UQSHRN V23.8B, V3.8H, #4
    SMLSL  V6.8H, V12.8B, V7.8B
    AESD  V3.16B, V30.16B
    BIT  V25.16B, V1.16B, V3.16B
    URSHR  V14.2S, V13.2S, #5
    SRSRA  V15.16B, V25.16B, #7
    SMLSL2 V16.2D, V15.4S, V23.S[0x1]
    FMAXNMP D23, V16.2D
    SSHR V12.2D, V29.2D, #48
    RADDHN  V24.4H, V23.4S, V23.4S
    UCVTF  V17.4H, V9.4H, #1
    FCVTAU  V27.4H, V6.4H
    SQDMULL S7, H14, V4.H[0x2]
    SHL V30.2D, V7.2D, #0x30
    REV64  V29.4S, V12.4S
    SQSHL  V4.2D, V2.2D, V17.2D
    MOV V25.B[0xc], V4.B[0x2]
    SHRN2 V12.4S, V29.2D, #7
    FCVTAS  V15.8H, V6.8H
    FCVTNU  V9.2D, V27.2D
    RSHRN V29.4H, V25.4S, #6
    FCMEQ  V27.2D, V15.2D, V30.2D
    FMINNMP S16, V29.2S
    FADDP  V2.8H, V27.8H, V16.8H
    FCMEQ  V6.2D, V12.2D, V2.2D
    CMGE  V16.4S, V9.4S, #0
    FMAXNMP  V13.4H, V16.4H, V24.4H
    FMULX D14, D23, V23.D[0x0]
    UQXTN2  V5.4S, V13.2D
    SQDMLSL V25.4S, V5.4H, V6.H[0x6]
    UQSHRN V5.2S, V25.2D, #15
    UXTL V12.4S, V14.4H
    SMLSL  V16.4S, V5.4H, V5.4H
    SCVTF  V17.4H, V16.4H, #11
    UQSHL V25.2D, V17.2D, #0xd
    SMAXV  S30, V12.4S
    FMAXNMP H27, V30.2H
    FMINP D16, V25.2D
    UADDL  V23.2D, V16.2S, V27.2S
    SLI  V5.2S, V27.2S, #0x13
    SSHR  V14.2S, V1.2S, #12
    FADDP S12, V6.2S
    FADDP S17, V21.2S
    SQSHL  V30.4S, V9.4S, #0x1f
    USUBL2  V6.2D, V19.4S, V8.4S
    PMUL  V2.8B, V28.8B, V10.8B
    ABS  V9.2S, V8.2S
    SUBHN  V13.8B, V17.8H, V9.8H
    FMINNM  V21.8H, V13.8H, V5.8H
    USQADD  V15.4S, V2.4S
    FCMGT  V25.4H, V6.4H, #0.0
    SQRDMULH H5, H12, V15.H[0x7]
    USRA  V16.8B, V30.8B, #2
    SQXTN2  V27.16B, V14.8H
    UMLSL2  V1.4S, V23.8H, V25.8H
    SMLAL2  V24.4S, V22.8H, V21.8H
    UHSUB  V12.4S, V24.4S, V5.4S
    FMINP  V6.2S, V12.2S, V16.2S
    MOV V25.S[0x1], V6.S[0x3]
    DUP  V30.4H, V25.H[0x3]
    UHADD  V16.16B, V2.16B, V1.16B
    UXTL2 V28.4S, V27.8H
    FCMGE  V14.8H, V26.8H, V30.8H
    FMIN  V21.2D, V16.2D, V28.2D
    FMINNMP S24, V14.2S
    UQRSHRN2 V15.8H, V21.4S, #9
    FCMGE  V14.4S, V15.4S, V24.4S
    FCVTMS  V13.2D, V6.2D
    SSUBL  V1.4S, V27.4H, V23.4H
    ZIP1  V26.4S, V24.4S, V13.4S
    FCVTZU  V6.8H, V16.8H, #15
    FCMEQ  V21.4H, V6.4H, V24.4H
    SCVTF  V2.4S, V17.4S, #16
    EXT  V17.8B, V19.8B, V13.8B, #0x6
    FABS  V12.4S, V4.4S
    SUBHN2  V28.8H, V6.4S, V9.4S
    UQSHRN V9.8B, V5.8H, #5
    MOV V22.H[0x0], W5
    FABS  V5.8H, V28.8H
    CLZ  V6.4S, V5.4S
    INS V23.B[0x4], W12
    SMOV  X8, V1.B[0x9]
    URSQRTE  V24.2S, V6.2S
    FCVTAS  V28.4S, V17.4S
    FMLS V25.4S, V21.4S, V24.S[0x3]
    UMOV W17, V14.B[0xb]
    ORN  V30.8B, V28.8B, V12.8B
    SQSHRUN V28.8B, V26.8H, #7
    TBL  V17.8B, { V23.16B, V24.16B }, V23.8B
    SMLAL2  V12.2D, V22.4S, V16.4S
    FMINNMP D15, V0.2D
    EOR  V19.8B, V2.8B, V2.8B
    SHLL2  V13.4S, V12.8H, #16
    SCVTF  V0.4S, V9.4S
    MVNI  V16.4S, #0xf6
    FCVTAU  V22.2S, V25.2S
    UMULL  V14.4S, V17.4H, V16.4H
    FCVTMU  V6.4S, V30.4S
    FMAXV  H26, V0.4H
    UZP1  V4.8H, V15.8H, V15.8H
    SCVTF  V15.8H, V4.8H, #2
    FMLS V25.4H, V15.4H, V6.H[0x1]
    URSHL  V15.16B, V22.16B, V26.16B
    REV16  V6.8B, V15.8B
    UMINV  H2, V13.8H
    SCVTF  V26.4H, V27.4H
    UCVTF  V5.8H, V19.8H
    SADDL  V23.4S, V25.4H, V2.4H
    SHRN V30.2S, V14.2D, #23
    FCVTPU  V1.4H, V6.4H
    FMINV  H22, V28.8H
    REV16  V15.16B, V23.16B
    URSRA  V4.4S, V26.4S, #6
    FRINTP  V14.2D, V22.2D
    FMAXP S23, V15.2S
    FMULX S17, S1, V23.S[0x3]
    FMAXP S15, V4.2S
    FMLA V28.4H, V30.4H, V15.H[0x0]
    SMOV  X28, V28.B[0xd]
    FMLA V13.2S, V11.2S, V5.S[0x3]
    MLA  V25.4H, V13.4H, V21.4H
    RSUBHN2  V4.16B, V2.8H, V25.8H
    DUP B27, V17.B[0x6]
    SQDMLSL2 V0.4S, V4.8H, V14.H[0x6]
    SQDMULH H14, H27, V0.H[0x2]
    FMINNMP H25, V14.2H
    SMULL2  V1.2D, V17.4S, V22.4S
    FRINTZ  V28.8H, V19.8H
    UABDL2  V23.4S, V3.8H, V6.8H
    SMLAL2 V15.2D, V23.4S, V2.S[0x0]
    FMUL D14, D20, V2.D[0x1]
    SQDMULL V30.2D, V30.2S, V27.S[0x3]
    USHR  V17.8H, V2.8H, #4
    SQDMLSL D11, S20, V19.S[0x2]
    SQDMULH S3, S1, V19.S[0x1]
    FCMEQ  V20.4H, V19.4H, V9.4H
    SSHR  V6.4S, V25.4S, #14
    SMLSL V26.4S, V11.4H, V1.H[0x0]
    SQSHRUN V4.8B, V28.8H, #6
    SSHR  V23.4H, V20.4H, #11
    SSRA  V5.2S, V15.2S, #5
    FRECPS  V15.4H, V26.4H, V10.4H
    DUP V0.4H, W25
    SRI  V2.2S, V14.2S, #14
    FCMGE  V1.2D, V17.2D, #0.0
    SHA1C  Q9, S30, V1.4S
    CMGT  V26.8H, V6.8H, #0
    ADDV  S14, V26.4S
    SMAXV  B26, V14.16B
    FCVTZS  V25.8H, V4.8H
    SQADD  V4.4H, V26.4H, V0.4H
    URSHR V26.2D, V2.2D, #18
    FMULX S17, S9, V15.S[0x1]
    RBIT  V6.8B, V23.8B
    SADDW  V15.2D, V3.2D, V5.2S
    SQDMULL D11, S6, V15.S[0x2]
    SMLAL  V14.4S, V4.4H, V4.4H
    MUL  V23.16B, V14.16B, V17.16B
    FRINTX  V1.4H, V11.4H
    SADDL  V6.2D, V26.2S, V23.2S
    SMAXP  V14.2S, V25.2S, V1.2S
    FDIV  V26.4S, V6.4S, V22.4S
    UMINP  V5.16B, V14.16B, V26.16B
    SSHLL2 V22.4S, V25.8H, #0x6
    SSHR  V26.4S, V27.4S, #8
    UMAXP  V14.16B, V20.16B, V28.16B
    SSHR  V17.4S, V31.4S, #23
    SQRDMULH  V20.4S, V14.4S, V23.4S
    SQSHLU  V0.4S, V20.4S, #0xb
    USQADD  V3.8B, V15.8B
    SQRSHRN2 V23.16B, V27.8H, #7
    SQXTN  V14.4H, V8.4S
    SQDMLSL S28, H13, V7.H[0x1]
    FMINNMP S31, V23.2S
    MVNI  V13.4S, #0x9d, LSL #16
    TRN1  V20.16B, V13.16B, V3.16B
    UADALP  V25.4H, V5.8B
    SQSHRN2 V11.16B, V26.8H, #1
    SADDL2  V1.2D, V25.4S, V11.4S
    SMLAL2  V3.4S, V14.8H, V20.8H
    FCVTZS  V6.8H, V28.8H, #3
    FMULX  V5.2D, V31.2D, V31.2D
    INS V31.B[0xc], W8
    URSHR  V7.16B, V22.16B, #8
    SXTL V23.2D, V17.2S
    RSHRN V15.4H, V23.4S, #12
    SCVTF  V11.2D, V15.2D
    UMAXP  V15.8H, V31.8H, V31.8H
    UABDL  V31.8H, V7.8B, V4.8B
    BIT  V13.8B, V31.8B, V11.8B
    CMEQ  V8.8H, V3.8H, V5.8H
    SSRA V28.2D, V1.2D, #30
    MOV V26.H[0x4], W17
    SQDMULH  V7.4S, V13.4S, V26.4S
    FMINV  H1, V28.8H
    TBX  V4.16B, { V6.16B, V7.16B, V8.16B, V9.16B }, V1.16B
    FMULX  V17.2D, V0.2D, V0.2D
    URSHL  V5.2S, V15.2S, V17.2S
    UMAXP  V27.8H, V4.8H, V4.8H
    SCVTF V20.2D, V5.2D, #10
    MOV  X26, V20.D[0x0]
    SQDMULH H13, H7, V7.H[0x2]
    FCVTZS  V6.4H, V25.4H, #13
    RBIT  V14.8B, V8.8B
    DUP V3.8H, W7
    FMAX  V5.2D, V4.2D, V24.2D
    UCVTF  V28.8H, V25.8H, #13
    SQRSHRUN2 V4.16B, V1.8H, #5
    SABD  V23.8B, V18.8B, V27.8B
    SQDMLAL  V27.2D, V11.2S, V27.2S
    SUBHN  V31.8B, V23.8H, V4.8H
    UCVTF  V18.2S, V23.2S
    MLA  V8.8H, V18.8H, V0.8H
    MOVI  V24.2D, #18374687574905061120
    FMINP H7, V28.2H
    FMUL V23.2S, V31.2S, V6.S[0x2]
    USRA V15.2D, V14.2D, #2
    FMINNMP S20, V23.2S
    SHADD  V23.2S, V20.2S, V8.2S
    SQDMULH S0, S23, V27.S[0x2]
    SQRSHL  V23.2S, V7.2S, V0.2S
    NOT  V25.8B, V23.8B
    SQDMULL2 V28.4S, V25.8H, V5.H[0x3]
    FRINTP  V1.8H, V15.8H
    SQDMLAL V31.2D, V24.2S, V3.S[0x3]
    FRECPS  V11.8H, V13.8H, V13.8H
    SQDMLAL S6, H1, V14.H[0x2]
    DUP V15.2D, V31.D[0x0]
    SQSHRUN V13.2S, V11.2D, #6
    FMINNMP H0, V28.2H
    SQDMULL V31.2D, V6.2S, V21.S[0x3]
    TRN2  V7.8H, V13.8H, V31.8H
    SQNEG  V13.16B, V7.16B
    FRINTX  V20.2D, V15.2D
    RSHRN V28.2S, V13.2D, #20
    MOV V25.D[0x0], V0.D[0x1]
    SQRSHRN2 V23.8H, V19.4S, #13
    FMINNMP  V27.4S, V23.4S, V20.4S
    SQDMULH  V21.8H, V13.8H, V27.8H
    SCVTF  V15.8H, V28.8H, #12
    FCMGT  V5.8H, V25.8H, V31.8H
    FCVTPU  V13.8H, V15.8H
    FRECPE  V25.8H, V21.8H
    SMULL2  V24.4S, V25.8H, V5.8H
    SQSHRN V6.2S, V24.2D, #8
    SRSRA V24.2D, V13.2D, #5
    SUBS  X24, X24, #0x1
    B.NE  TSRTAdvsimdVectorAllOperation_label_6
    MOVZ  X6, #0x7a83, LSL #0
    MOVK  X6, #0x4ba4, LSL #16
    MOVK  X6, #0xf553, LSL #32
    MOVK  X6, #0x2a2, LSL #48
    SUB  X3, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x2895, LSL #0
    MOVK  X6, #0xf040, LSL #16
    MOVK  X6, #0x2cfc, LSL #32
    MOVK  X6, #0xf0c8, LSL #48
    SUB  X3, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0xda43, LSL #0
    MOVK  X6, #0x87a3, LSL #16
    MOVK  X6, #0xd35e, LSL #32
    MOVK  X6, #0xa42f, LSL #48
    SUB  X3, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0xbb90, LSL #0
    MOVK  X6, #0xe94e, LSL #16
    MOVK  X6, #0x2998, LSL #32
    MOVK  X6, #0xf153, LSL #48
    SUB  X3, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0xaaa2, LSL #0
    MOVK  X6, #0x1f19, LSL #16
    MOVK  X6, #0x6904, LSL #32
    MOVK  X6, #0x8bc7, LSL #48
    SUB  X3, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x33b2, LSL #0
    MOVK  X6, #0x499e, LSL #16
    MOVK  X6, #0x3c4e, LSL #32
    MOVK  X6, #0xe2a7, LSL #48
    SUB  X3, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x4f2c, LSL #0
    MOVK  X6, #0x4a5c, LSL #16
    MOVK  X6, #0xd7bc, LSL #32
    MOVK  X6, #0x9432, LSL #48
    SUB  X3, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x9975, LSL #0
    MOVK  X6, #0x8a85, LSL #16
    MOVK  X6, #0x4e47, LSL #32
    MOVK  X6, #0x8f3d, LSL #48
    SUB  X3, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x2416, LSL #0
    MOVK  X6, #0x41d5, LSL #16
    MOVK  X6, #0x3d76, LSL #32
    MOVK  X6, #0x45ab, LSL #48
    SUB  X3, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0xff, LSL #0
    SUB  X3, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x3931, LSL #0
    MOVK  X6, #0xb71c, LSL #16
    MOVK  X6, #0x876, LSL #32
    MOVK  X6, #0xe891, LSL #48
    SUB  X3, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x91c8, LSL #0
    MOVK  X6, #0xacfd, LSL #16
    MOVK  X6, #0x6da9, LSL #32
    MOVK  X6, #0x2ebe, LSL #48
    SUB  X3, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0xc2d6, LSL #0
    MOVK  X6, #0x3d11, LSL #16
    MOVK  X6, #0x2864, LSL #32
    MOVK  X6, #0x3625, LSL #48
    SUB  X3, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0xb7a8, LSL #0
    MOVK  X6, #0x6640, LSL #16
    MOVK  X6, #0x8482, LSL #32
    MOVK  X6, #0xfc89, LSL #48
    SUB  X3, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x5695, LSL #0
    MOVK  X6, #0x7853, LSL #16
    MOVK  X6, #0xf32a, LSL #32
    MOVK  X6, #0xd634, LSL #48
    SUB  X3, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x7700, LSL #32
    MOVK  X6, #0x404c, LSL #48
    SUB  X3, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x7663, LSL #0
    MOVK  X6, #0x4f2, LSL #16
    MOVK  X6, #0xcf3e, LSL #32
    MOVK  X6, #0x69c2, LSL #48
    SUB  X3, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0xde22, LSL #0
    MOVK  X6, #0x98b0, LSL #16
    MOVK  X6, #0xfde0, LSL #32
    MOVK  X6, #0x4f50, LSL #48
    SUB  X3, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x97, LSL #0
    MOVK  X6, #0x800, LSL #16
    MRS  X3, FPSR
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, V0.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, D0
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0xe3b8, LSL #0
    FMOV  X3, V1.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0xe3b6, LSL #0
    MOVK  X6, #0x4000, LSL #48
    FMOV  X3, D1
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, V2.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x2, LSL #48
    FMOV  X3, D2
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0xda43, LSL #0
    MOVK  X6, #0xda43, LSL #16
    MOVK  X6, #0xda43, LSL #32
    MOVK  X6, #0xda43, LSL #48
    FMOV  X3, V3.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0xda43, LSL #0
    MOVK  X6, #0xda43, LSL #16
    MOVK  X6, #0xda43, LSL #32
    MOVK  X6, #0xda43, LSL #48
    FMOV  X3, D3
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, V4.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, D4
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, V5.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, D5
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, V6.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, D6
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, V7.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #32
    FMOV  X3, D7
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    FMOV  X3, V8.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    FMOV  X3, D8
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xbfff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    FMOV  X3, V9.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0xfbdc, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffde, LSL #32
    MOVK  X6, #0xffff, LSL #48
    FMOV  X3, D9
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, V10.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, D10
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x4000, LSL #0
    MOVK  X6, #0x4000, LSL #16
    MOVK  X6, #0x4000, LSL #32
    MOVK  X6, #0x4000, LSL #48
    FMOV  X3, V11.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x4000, LSL #0
    MOVK  X6, #0x4000, LSL #16
    MOVK  X6, #0x4000, LSL #32
    MOVK  X6, #0x4000, LSL #48
    FMOV  X3, D11
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, V12.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, D12
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, V13.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x1, LSL #0
    MOVK  X6, #0x1, LSL #16
    FMOV  X3, D13
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, V14.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    FMOV  X3, D14
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, V15.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x3c00, LSL #0
    MOVK  X6, #0x1c00, LSL #16
    FMOV  X3, D15
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0xff09, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xff09, LSL #32
    MOVK  X6, #0xffff, LSL #48
    FMOV  X3, V16.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0xff09, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xff09, LSL #32
    MOVK  X6, #0xffff, LSL #48
    FMOV  X3, D16
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, V17.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, D17
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, V18.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, D18
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, V19.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, D19
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x7a00, LSL #0
    MOVK  X6, #0xfe4b, LSL #16
    MOVK  X6, #0x87ff, LSL #32
    MOVK  X6, #0xffb4, LSL #48
    FMOV  X3, V20.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x7a00, LSL #0
    MOVK  X6, #0xfe4b, LSL #16
    MOVK  X6, #0x87ff, LSL #32
    MOVK  X6, #0xffb4, LSL #48
    FMOV  X3, D20
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, V21.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, D21
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, V22.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, D22
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, V23.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, D23
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, V24.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x800, LSL #0
    FMOV  X3, D24
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x7c00, LSL #0
    MOVK  X6, #0x7c00, LSL #16
    MOVK  X6, #0x7c00, LSL #32
    MOVK  X6, #0x7c00, LSL #48
    FMOV  X3, V25.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x7c00, LSL #0
    MOVK  X6, #0x7c00, LSL #16
    MOVK  X6, #0x7c00, LSL #32
    MOVK  X6, #0x7c00, LSL #48
    FMOV  X3, D25
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0xff, LSL #0
    FMOV  X3, V26.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, D26
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x87ff, LSL #0
    MOVK  X6, #0xfff4, LSL #16
    MOVK  X6, #0x87ff, LSL #32
    MOVK  X6, #0xfff4, LSL #48
    FMOV  X3, V27.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, D27
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, V28.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x1000, LSL #0
    MOVK  X6, #0x10, LSL #16
    FMOV  X3, D28
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, V29.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, D29
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, V30.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, D30
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, V31.D[1]
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X3, D31
    SUB  X4, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
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
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X16
    FMOV  V0.D[1], X7
    FMOV  D1, X28
    FMOV  V1.D[1], X23
    FMOV  D2, X4
    FMOV  V2.D[1], X29
    FMOV  D3, X19
    FMOV  V3.D[1], X24
    FMOV  D4, X17
    FMOV  V4.D[1], X20
    FMOV  D5, X25
    FMOV  V5.D[1], X8
    FMOV  D6, X22
    FMOV  V6.D[1], X27
    FMOV  D7, X26
    FMOV  V7.D[1], X15
    FMOV  D8, X3
    FMOV  V8.D[1], X28
    FMOV  D9, X5
    FMOV  V9.D[1], X5
    FMOV  D10, X7
    FMOV  V10.D[1], X12
    FMOV  D11, X5
    FMOV  V11.D[1], X7
    FMOV  D12, X19
    FMOV  V12.D[1], X12
    FMOV  D13, X22
    FMOV  V13.D[1], X26
    FMOV  D14, X24
    FMOV  V14.D[1], X13
    FMOV  D15, X7
    FMOV  V15.D[1], X2
    FMOV  D16, X3
    FMOV  V16.D[1], X28
    FMOV  D17, X27
    FMOV  V17.D[1], X2
    FMOV  D18, X3
    FMOV  V18.D[1], X6
    FMOV  D19, X23
    FMOV  V19.D[1], X19
    FMOV  D20, X12
    FMOV  V20.D[1], X7
    FMOV  D21, X2
    FMOV  V21.D[1], X15
    FMOV  D22, X8
    FMOV  V22.D[1], X27
    FMOV  D23, X28
    FMOV  V23.D[1], X19
    FMOV  D24, X26
    FMOV  V24.D[1], X20
    FMOV  D25, X6
    FMOV  V25.D[1], X19
    FMOV  D26, X7
    FMOV  V26.D[1], X8
    FMOV  D27, X8
    FMOV  V27.D[1], X2
    FMOV  D28, X3
    FMOV  V28.D[1], X6
    FMOV  D29, X5
    FMOV  V29.D[1], X16
    FMOV  D30, X24
    FMOV  V30.D[1], X17
    FMOV  D31, X12
    FMOV  V31.D[1], X12
    MOVZ  X4, #0xa, LSL #0
TSRTAdvsimdVectorAllOperation_label_7:
    SSHR V7.2D, V28.2D, #29
    BIT  V20.8B, V27.8B, V30.8B
    SMOV  X3, V29.B[0x6]
    MUL  V30.2S, V21.2S, V31.S[0x0]
    MOVI  V9.4S, #0x61
    FCVTNU  V0.8H, V26.8H
    FMLS D2, D25, V0.D[0x1]
    FMINNMV  H25, V9.4H
    SHRN V7.4H, V7.4S, #16
    UQSHL  V8.4H, V20.4H, #0x5
    DUP  V0.16B, V30.B[0xe]
    FRINTN  V19.8H, V2.8H
    SQDMULH  V21.8H, V19.8H, V0.H[0x6]
    UMAXV  B26, V7.16B
    SHRN2 V19.16B, V24.8H, #2
    INS V16.B[0x3], W7
    FMLA D6, D21, V21.D[0x0]
    FCVTPS  V21.4H, V6.4H
    MOV V18.S[0x0], V6.S[0x1]
    FCVTZS  V10.8H, V26.8H, #9
    FCMEQ  V16.4H, V8.4H, V21.4H
    RADDHN  V0.4H, V10.4S, V10.4S
    FADD  V20.8H, V19.8H, V19.8H
    SMLSL V31.4S, V0.4H, V4.H[0x5]
    CMLE  V0.8H, V18.8H, #0
    FCMGT  V2.4S, V0.4S, #0.0
    SQRSHRUN V6.8B, V2.8H, #8
    SQSHRN V2.2S, V25.2D, #11
    UQRSHL  V21.8B, V20.8B, V20.8B
    SSHR  V7.4S, V31.4S, #31
    MOV V4.B[0xe], W7
    SQRSHRUN2 V24.8H, V11.4S, #13
    SQXTN2  V11.4S, V24.2D
    USHLL2 V25.4S, V21.8H, #0x6
    RSUBHN2  V31.16B, V12.8H, V16.8H
    SABAL  V0.4S, V31.4H, V6.4H
    UCVTF  V6.4H, V2.4H, #11
    SQRSHRUN2 V19.8H, V11.4S, #2
    SQDMULH  V8.2S, V7.2S, V0.S[0x2]
    SQDMULH  V21.4H, V25.4H, V4.H[0x5]
    DUP  V2.4S, V31.S[0x2]
    SQRDMULH  V7.4S, V2.4S, V6.S[0x0]
    FMOV  V24.4H, #5.75000000
    TRN1  V20.2D, V8.2D, V24.2D
    FMAXP  V6.8H, V7.8H, V21.8H
    FMAXNM  V12.4S, V19.4S, V19.4S
    SHL V10.2D, V12.2D, #0x23
    UQSHRN V7.8B, V10.8H, #8
    FACGE  V12.2D, V20.2D, V7.2D
    UMLAL2 V19.2D, V6.4S, V6.S[0x3]
    SHA1M  Q10, S19, V19.4S
    SMAXV  H8, V12.4H
    URSRA  V31.4H, V8.4H, #2
    SQSHL  V2.4S, V31.4S, #0x2
    MUL  V8.8H, V13.8H, V10.H[0x1]
    UMINV  B16, V8.8B
    SRHADD  V19.8H, V2.8H, V4.8H
    DUP H25, V16.H[0x6]
    FMLS  V0.4H, V25.4H, V25.4H
    FMINP S8, V0.2S
    UMINV  B31, V19.16B
    FRINTP  V16.2S, V8.2S
    FACGT  V12.8H, V31.8H, V31.8H
    SHL  V6.16B, V12.16B, #0x3
    SQRSHRN V25.4H, V16.4S, #6
    USHR  V2.8H, V25.8H, #3
    SQSHRUN2 V13.8H, V6.4S, #4
    MVNI  V25.8H, #0x58, LSL #8
    SMAXV  H31, V25.4H
    UMLAL2  V7.2D, V2.4S, V2.4S
    FMULX  V4.8H, V7.8H, V12.8H
    ADDHN  V16.8B, V13.8H, V4.8H
    FMAXP  V25.4H, V31.4H, V31.4H
    SQDMULL2  V10.2D, V16.4S, V25.4S
    FMINP  V0.8H, V26.8H, V20.8H
    RSHRN V7.2S, V21.2D, #3
    USHLL2 V8.4S, V4.8H, #0xa
    MVNI  V19.8H, #0xf6, LSL #8
    CNT  V13.16B, V19.16B
    SSHR  V1.8H, V23.8H, #5
    DUP D6, V9.D[0x0]
    SQRDMULH  V4.8H, V4.8H, V12.H[0x5]
    INS V2.H[0x6], W5
    DUP V9.2D, X6
    MLA  V26.4H, V9.4H, V4.H[0x6]
    UMLSL2 V20.2D, V7.4S, V2.S[0x1]
    FMAXP  V31.4S, V20.4S, V6.4S
    SMOV W23, V0.B[0x7]
    SQSHRN V20.8B, V10.8H, #2
    SQSHRUN2 V19.8H, V26.4S, #3
    UQRSHRN V1.4H, V13.4S, #15
    SHL V12.2D, V8.2D, #0x11
    DUP V23.16B, W10
    UMLSL V10.2D, V31.2S, V31.S[0x2]
    UQRSHRN V16.2S, V19.2D, #8
    BSL  V19.16B, V23.16B, V20.16B
    UMLSL V31.2D, V10.2S, V1.S[0x0]
    RSHRN V26.2S, V19.2D, #11
    SXTL2 V6.2D, V26.4S
    CNT  V25.8B, V16.8B
    SCVTF  V13.8H, V25.8H
    SXTL2 V0.8H, V31.16B
    FDIV  V16.2S, V19.2S, V12.2S
    FMINNMV  S8, V6.4S
    SQRDMULH  V20.2S, V8.2S, V31.S[0x1]
    FADDP  V31.4H, V13.4H, V24.4H
    FMULX V10.2S, V0.2S, V0.S[0x2]
    FMAXV  H23, V27.4H
    FRECPE  V12.2D, V23.2D
    MOV V6.H[0x0], W7
    SSUBL  V1.8H, V16.8B, V16.8B
    SQRSHRN V16.2S, V20.2D, #10
    SQSHRUN V27.4H, V31.4S, #15
    ORR  V26.16B, V16.16B, V27.16B
    FCVTMU  V0.2S, V10.2S
    UMLSL V24.4S, V12.4H, V0.H[0x3]
    UABD  V0.8B, V6.8B, V24.8B
    UQXTN  V25.4H, V1.4S
    UQRSHRN2 V8.4S, V25.2D, #3
    CLZ  V20.16B, V8.16B
    SMINV  S23, V26.4S
    DUP V16.2D, X13
    FMAXNMP D26, V0.2D
    SQRSHRUN2 V6.4S, V26.2D, #19
    SSUBW2  V0.8H, V23.8H, V20.16B
    FRINTP  V12.8H, V16.8H
    SQSHL  V26.4H, V12.4H, #0x8
    FMINP H31, V6.2H
    SQRSHRUN V6.4H, V0.4S, #15
    UMLSL  V23.8H, V6.8B, V6.8B
    INS V6.H[0x5], W20
    UABA  V25.8H, V6.8H, V23.8H
    SSHLL V10.2D, V26.2S, #0x1d
    ADDV  B8, V31.8B
    FMINNMV  H12, V8.4H
    UMINV  B24, V10.16B
    SQRSHRN2 V23.16B, V25.8H, #4
    UCVTF  V26.8H, V14.8H
    SSHLL V20.4S, V15.4H, #0x5
    SQSHL  V10.8H, V26.8H, #0xd
    SADDLP  V8.4S, V10.8H
    FADDP S15, V8.2S
    MOV  V6.16B, V23.16B
    USHLL V0.8H, V6.8B, #0x1
    UXTL2 V14.8H, V0.16B
    SQRSHRN V23.2S, V7.2D, #13
    UMULL2 V7.4S, V20.8H, V14.H[0x3]
    PMULL2  V16.8H, V23.16B, V15.16B
    UMULL2  V9.8H, V16.16B, V12.16B
    FADD  V3.8H, V24.8H, V29.8H
    FCVTAS  V26.4S, V3.4S
    UMULL V25.4S, V9.4H, V7.H[0x4]
    SQRDMULH  V10.4S, V25.4S, V16.S[0x2]
    UHSUB  V8.4H, V10.4H, V26.4H
    MVN  V6.8B, V17.8B
    DUP V31.4H, W9
    SQSHLU  V16.4S, V23.4S, #0x1
    BIC  V17.4H, #0x67, LSL #8
    SQDMLAL2 V25.2D, V5.4S, V22.S[0x2]
    USHLL2 V0.4S, V15.8H, #0xa
    ZIP1  V24.2S, V25.2S, V21.2S
    SMAX  V26.2S, V9.2S, V29.2S
    FMAXNMP  V20.8H, V4.8H, V18.8H
    FCMEQ  V14.4S, V8.4S, #0.0
    SQDMULH  V25.2S, V26.2S, V31.S[0x3]
    UMOV W19, V25.S[0x3]
    UMLSL2  V10.4S, V17.8H, V31.8H
    FCVTZS  V7.4H, V20.4H, #10
    FADDP D23, V16.2D
    NOT  V21.16B, V0.16B
    SQSHLU V22.2D, V10.2D, #0x0
    SHA256SU0  V20.4S, V14.4S
    MVNI  V26.2S, #0x4b, MSL #16
    SMLAL2  V16.2D, V26.4S, V7.4S
    SSHR V29.2D, V21.2D, #14
    MOV  V25.16B, V6.16B
    UZP1  V8.2D, V24.2D, V16.2D
    SHA1SU1  V17.4S, V8.4S
    CMLT  V6.4H, V17.4H, #0
    FMINNMV  S17, V23.4S
    FMUL V16.8H, V25.8H, V6.H[0x2]
    SQDMULH  V24.2S, V29.2S, V29.2S
    MLS  V23.4H, V20.4H, V0.H[0x6]
    SXTL V5.8H, V22.8B
    RSHRN2 V25.16B, V16.8H, #5
    MOV  W19, V5.S[0x0]
    CMLT  V14.2D, V22.2D, #0
    FABD  V22.4H, V23.4H, V14.4H
    SQXTUN  V23.4H, V22.4S
    SCVTF  V29.4S, V17.4S, #23
    UQSHRN V10.8B, V23.8H, #4
    FMINNMP D21, V24.2D
    SHRN2 V7.4S, V29.2D, #19
    SSHLL V31.8H, V25.8B, #0x2
    FRINTX  V16.4S, V10.4S
    FCVTN  V25.2S, V11.2D
    MOV V22.S[0x0], V25.S[0x2]
    FMLS V25.2D, V7.2D, V21.D[0x1]
    FCMLE  V11.2S, V30.2S, #0.0
    SQSHL  V10.8H, V31.8H, #0x6
    FMAXNMP D0, V16.2D
    RSHRN2 V29.16B, V22.8H, #8
    CLS  V20.8H, V25.8H
    FCVTPS  V16.4S, V29.4S
    SSHLL V22.2D, V11.2S, #0xd
    USHR  V8.2S, V10.2S, #1
    SSHR  V31.8B, V0.8B, #1
    FMINP D29, V31.2D
    SMINV  S5, V22.4S
    FCVTPS  V23.2D, V5.2D
    ADDHN2  V24.4S, V20.2D, V16.2D
    FACGE  V25.2D, V3.2D, V8.2D
    ZIP2  V10.16B, V29.16B, V24.16B
    FMAXNMV  S29, V10.4S
    FMAXNMV  S10, V20.4S
    SHRN V3.4H, V10.4S, #2
    FMLS S20, S3, V25.S[0x2]
    UMOV X24, V20.D[0x1]
    FMINV  H25, V29.4H
    SQDMULL2 V0.4S, V21.8H, V8.H[0x6]
    SMINV  S11, V25.4S
    FADDP S20, V0.2S
    FMULX V25.4S, V23.4S, V23.S[0x2]
    FCVTAS  V24.4H, V25.4H
    SQSHRUN V21.4H, V11.4S, #14
    SQDMLAL2 V16.4S, V20.8H, V1.H[0x0]
    SQDMLSL V29.4S, V16.4H, V5.H[0x1]
    SABDL  V1.4S, V29.4H, V21.4H
    USUBW  V25.4S, V24.4S, V24.4H
    FMOV  V20.2S, #-1.06250000
    SRSHR  V11.8H, V20.8H, #5
    SQSHRUN2 V5.8H, V25.4S, #8
    FRECPE  V8.4S, V1.4S
    FMAXP  V23.2D, V11.2D, V8.2D
    UXTL2 V20.4S, V5.8H
    SADDL2  V3.2D, V20.4S, V23.4S
    FRECPS  V16.2D, V3.2D, V28.2D
    BIC  V24.4S, #0x8d
    FMLS V0.2D, V0.2D, V0.D[0x1]
    SQRDMULH S11, S26, V1.S[0x0]
    MVNI  V25.2S, #0x7c, LSL #16
    SQRSHRUN V23.8B, V7.8H, #8
    FCMEQ  V8.4S, V18.4S, V7.4S
    SXTL2 V21.4S, V17.8H
    UQSUB  V28.4H, V24.4H, V12.4H
    FRINTM  V24.4H, V0.4H
    FRINTA  V26.4H, V3.4H
    DUP B3, V16.B[0x2]
    SMINV  B29, V24.16B
    FSQRT  V1.8H, V21.8H
    SSRA V17.2D, V8.2D, #60
    FCVTZS  V12.2S, V16.2S
    SMLSL  V20.2D, V16.2S, V28.2S
    SQRSHRN2 V18.4S, V26.2D, #11
    FMAX  V0.8H, V11.8H, V12.8H
    MUL  V7.4H, V3.4H, V0.H[0x6]
    UMULL2  V3.4S, V18.8H, V25.8H
    FMAX  V0.2D, V20.2D, V7.2D
    SRI  V26.2S, V3.2S, #15
    SQDMLAL V12.4S, V0.4H, V1.H[0x7]
    SLI  V20.8H, V26.8H, #0x4
    TBX  V18.16B, { V17.16B }, V23.16B
    FCVTPS  V28.2S, V29.2S
    SMLSL V29.2D, V28.2S, V20.S[0x0]
    UCVTF  V11.4S, V29.4S
    MOV  V8.16B, V11.16B
    UABDL2  V16.8H, V18.16B, V18.16B
    SQDMLSL2  V20.2D, V12.4S, V16.4S
    MVN  V9.16B, V8.16B
    FCVTZS V16.2D, V20.2D, #31
    INS V3.H[0x6], W8
    SMINV  H20, V9.4H
    FCVTMS  V1.4S, V20.4S
    SQSHRUN2 V0.8H, V3.4S, #10
    FCVTNS  V7.8H, V29.8H
    USHR  V9.4H, V18.4H, #14
    SMOV  X9, V9.S[0x0]
    FCVTXN  V3.2S, V1.2D
    UMULL V11.4S, V16.4H, V0.H[0x4]
    MOV V8.B[0x6], V7.B[0x9]
    MOV  V1.16B, V11.16B
    UHSUB  V29.8B, V3.8B, V7.8B
    MVNI  V28.2S, #0xe6, MSL #16
    SSHR  V3.8B, V4.8B, #6
    SADDLP  V4.4H, V28.8B
    UQSHRN V25.4H, V20.4S, #8
    SMLSL2 V0.2D, V3.4S, V25.S[0x1]
    SXTL2 V11.8H, V8.16B
    ADDV  H17, V11.8H
    UQSUB  V7.16B, V1.16B, V29.16B
    UQSHL V28.2D, V7.2D, #0x3c
    FMLS V16.2D, V10.2D, V17.D[0x0]
    FMULX  V29.4H, V28.4H, V0.4H
    UQSHL  V12.4S, V29.4S, #0xa
    FSQRT  V20.4S, V4.4S
    ZIP2  V17.8B, V16.8B, V20.8B
    BIC  V9.4S, #0x56, LSL #8
    SSUBL  V8.8H, V12.8B, V17.8B
    SCVTF  V4.8H, V17.8H
    ORR  V20.8H, #0x3e
    SUBS  X4, X4, #0x1
    B.NE  TSRTAdvsimdVectorAllOperation_label_7
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x97, LSL #0
    MOVK  X12, #0x800, LSL #16
    MRS  X27, FPSR
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V0.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D0
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V1.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D1
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V2.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D2
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V3.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D3
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V4.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x5800, LSL #48
    FMOV  X27, D4
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V5.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0xe000, LSL #0
    MOVK  X12, #0xffff, LSL #16
    FMOV  X27, D5
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V6.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D6
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V7.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D7
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x80, LSL #32
    FMOV  X27, V8.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D8
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V9.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D9
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V10.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D10
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V11.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D11
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V12.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D12
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V13.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x6804, LSL #0
    MOVK  X12, #0x6804, LSL #16
    FMOV  X27, D13
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V14.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D14
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V15.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D15
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #48
    FMOV  X27, V16.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #48
    FMOV  X27, D16
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V17.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x80, LSL #48
    FMOV  X27, D17
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V18.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D18
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V19.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D19
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x3e, LSL #0
    MOVK  X12, #0x3e, LSL #16
    MOVK  X12, #0x3e, LSL #32
    MOVK  X12, #0x3e, LSL #48
    FMOV  X27, V20.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x3e, LSL #0
    MOVK  X12, #0x3e, LSL #16
    MOVK  X12, #0x3e, LSL #32
    MOVK  X12, #0x3e, LSL #48
    FMOV  X27, D20
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V21.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D21
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0xe000, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    FMOV  X27, V22.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0xe000, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    FMOV  X27, D22
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V23.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D23
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V24.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #48
    FMOV  X27, D24
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V25.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0xbc, LSL #0
    FMOV  X27, D25
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V26.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x7f80, LSL #16
    FMOV  X27, D26
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V27.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x9380, LSL #16
    FMOV  X27, D27
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V28.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D28
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V29.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D29
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V30.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D30
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V31.D[1]
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D31
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorAllOperation_TestFail
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
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
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
    FMOV  D0, X25
    FMOV  V0.D[1], X28
    FMOV  D1, X26
    FMOV  V1.D[1], X29
    FMOV  D2, X27
    FMOV  V2.D[1], X16
    FMOV  D3, X17
    FMOV  V3.D[1], X22
    FMOV  D4, X8
    FMOV  V4.D[1], X4
    FMOV  D5, X13
    FMOV  V5.D[1], X15
    FMOV  D6, X4
    FMOV  V6.D[1], X13
    FMOV  D7, X23
    FMOV  V7.D[1], X12
    FMOV  D8, X26
    FMOV  V8.D[1], X12
    FMOV  D9, X9
    FMOV  V9.D[1], X19
    FMOV  D10, X10
    FMOV  V10.D[1], X20
    FMOV  D11, X25
    FMOV  V11.D[1], X2
    FMOV  D12, X3
    FMOV  V12.D[1], X3
    FMOV  D13, X29
    FMOV  V13.D[1], X23
    FMOV  D14, X13
    FMOV  V14.D[1], X17
    FMOV  D15, X12
    FMOV  V15.D[1], X3
    FMOV  D16, X26
    FMOV  V16.D[1], X3
    FMOV  D17, X22
    FMOV  V17.D[1], X22
    FMOV  D18, X8
    FMOV  V18.D[1], X15
    FMOV  D19, X24
    FMOV  V19.D[1], X22
    FMOV  D20, X10
    FMOV  V20.D[1], X6
    FMOV  D21, X8
    FMOV  V21.D[1], X12
    FMOV  D22, X20
    FMOV  V22.D[1], X13
    FMOV  D23, X15
    FMOV  V23.D[1], X27
    FMOV  D24, X5
    FMOV  V24.D[1], X13
    FMOV  D25, X5
    FMOV  V25.D[1], X17
    FMOV  D26, X29
    FMOV  V26.D[1], X15
    FMOV  D27, X5
    FMOV  V27.D[1], X26
    FMOV  D28, X3
    FMOV  V28.D[1], X13
    FMOV  D29, X25
    FMOV  V29.D[1], X17
    FMOV  D30, X6
    FMOV  V30.D[1], X12
    FMOV  D31, X24
    FMOV  V31.D[1], X13
    MOVZ  X29, #0xa, LSL #0
TSRTAdvsimdVectorAllOperation_label_8:
    MOV D9, V21.D[0x1]
    URSHR  V23.16B, V26.16B, #7
    URSHR V13.2D, V31.2D, #6
    UMLSL2 V19.2D, V22.4S, V24.S[0x1]
    ORN  V30.16B, V19.16B, V20.16B
    SMULL2 V9.2D, V29.4S, V9.S[0x2]
    ADDP  V18.2S, V27.2S, V21.2S
    USRA  V7.16B, V25.16B, #8
    UMAXV  H0, V7.4H
    FCVTNU  V16.8H, V9.8H
    UQSHL  V27.2S, V18.2S, #0x5
    UADDW  V24.8H, V27.8H, V0.8B
    USUBW  V14.8H, V28.8H, V28.8B
    UCVTF V6.2D, V13.2D, #62
    FCVTL2  V31.4S, V6.8H
    REV64  V22.8B, V31.8B
    UMLSL V9.4S, V14.4H, V14.H[0x1]
    USHR  V6.4H, V23.4H, #9
    SCVTF V23.2D, V22.2D, #16
    FCVTZU  V14.4H, V16.4H
    URSHL  V29.4H, V23.4H, V24.4H
    FMAXNMV  S7, V6.4S
    FMLS V19.2D, V9.2D, V7.D[0x0]
    UQRSHRN V23.2S, V19.2D, #25
    TBL  V6.8B, { V17.16B, V18.16B, V19.16B }, V30.8B
    CMGE  V30.4H, V6.4H, V6.4H
    SMLSL2 V9.4S, V29.8H, V14.H[0x7]
    SHA256SU0  V26.4S, V9.4S
    FMINV  H28, V23.8H
    SUB  V13.4H, V28.4H, V28.4H
    SHL V23.2D, V13.2D, #0x25
    FSQRT  V31.8H, V23.8H
    FMINNM  V29.8H, V26.8H, V31.8H
    FMAXV  H9, V30.4H
    SMAXV  B14, V29.16B
    SQDMULH  V30.4H, V9.4H, V9.4H
    SABDL2  V9.8H, V14.16B, V14.16B
    FRINTA  V14.4H, V30.4H
    SHRN2 V6.8H, V9.4S, #3
    INS V7.D[0x0], X15
    FADDP H29, V14.2H
    FCVTZU  V18.2D, V9.2D
    FRECPE  V28.8H, V18.8H
    UQRSHL  V31.2D, V7.2D, V13.2D
    FMOV  V14.8H, #-5.25000000
    FCVTZU  V30.2S, V28.2S, #5
    FMLA V23.2D, V30.2D, V30.D[0x0]
    FCVTAU  V28.8H, V14.8H
    MOV V30.D[0x0], V31.D[0x1]
    SQSHLU  V17.4S, V30.4S, #0x8
    SQSHL  V7.4H, V23.4H, #0xf
    USRA  V9.2S, V7.2S, #4
    FCMLE  V26.8H, V17.8H, #0.0
    TRN2  V14.2D, V6.2D, V9.2D
    UMOV W19, V18.S[0x3]
    SQSHRUN2 V18.16B, V28.8H, #7
    SHLL  V9.2D, V29.2S, #32
    TBX  V7.16B, { V30.16B, V31.16B }, V21.16B
    SHL V0.2D, V7.2D, #0x2c
    SQSHRN2 V31.4S, V0.2D, #20
    UQSHRN V28.2S, V26.2D, #18
    FRINTP  V6.8H, V14.8H
    FRINTX  V23.4H, V6.4H
    SQSHRUN V17.4H, V18.4S, #16
    UQRSHRN V13.4H, V17.4S, #11
    SRSRA V17.2D, V31.2D, #11
    SHRN2 V29.16B, V23.8H, #8
    FADD  V16.2S, V28.2S, V9.2S
    USUBW  V21.8H, V16.8H, V17.8B
    UQSHL  V28.4S, V21.4S, #0xa
    SQSHL  V21.2S, V13.2S, V28.2S
    UADDW  V30.8H, V29.8H, V21.8B
    SHRN2 V16.16B, V28.8H, #3
    FMULX H28, H27, V4.H[0x1]
    SQRSHRUN2 V0.16B, V23.8H, #1
    RADDHN2  V18.4S, V21.2D, V24.2D
    UMLAL2 V29.4S, V27.8H, V12.H[0x2]
    SRSHR  V4.2S, V24.2S, #1
    USHLL V1.4S, V29.4H, #0x8
    SQRDMULH  V6.8H, V18.8H, V5.H[0x0]
    USHLL V31.4S, V26.4H, #0xe
    RSHRN2 V17.4S, V25.2D, #25
    INS V5.B[0x2], V17.B[0x9]
    FCVTMU  V12.8H, V31.8H
    SQSHLU  V31.4H, V30.4H, #0x4
    FMINNMP D9, V25.2D
    FCVTNU  V13.4H, V6.4H
    SMINP  V30.16B, V4.16B, V31.16B
    FMLS  V23.2D, V12.2D, V5.2D
    FNEG  V29.8H, V28.8H
    FRINTI  V24.4S, V29.4S
    SMOV W17, V23.H[0x7]
    SXTL V21.2D, V30.2S
    FCVTMS  V31.8H, V16.8H
    FMUL  V16.4H, V13.4H, V31.4H
    SCVTF  V21.2S, V16.2S
    DUP V30.2S, W12
    FRINTA  V23.8H, V24.8H
    SSHLL V29.2D, V1.2S, #0xa
    USHL  V31.4H, V0.4H, V9.4H
    SQSHLU  V17.2S, V21.2S, #0x1f
    SMULL2  V27.2D, V24.4S, V17.4S
    TRN2  V25.8B, V30.8B, V23.8B
    SMLAL V5.2D, V25.2S, V25.S[0x1]
    SQSHRUN V23.2S, V29.2D, #21
    XTN  V16.2S, V31.2D
    SRI V29.2D, V27.2D, #29
    FMINNMV  H1, V29.8H
    USHLL2 V28.4S, V5.8H, #0xb
    SQDMLSL2  V6.2D, V28.4S, V23.4S
    USHR  V0.8H, V6.8H, #5
    UMAXV  S25, V16.4S
    PMULL  V16.8H, V25.8B, V1.8B
    SQSHRUN2 V13.8H, V16.4S, #1
    FMAXP S5, V0.2S
    SQSHL  V1.4H, V13.4H, V5.4H
    SHL V24.2D, V18.2D, #0x1a
    SQSHRUN2 V12.16B, V25.8H, #1
    SQDMLAL D30, S31, V2.S[0x2]
    UQSHL V9.2D, V12.2D, #0x28
    UQRSHRN V6.2S, V13.2D, #22
    UZP2  V21.4S, V8.4S, V26.4S
    SQXTUN  V26.4H, V30.4S
    UADDLP  V16.2D, V27.4S
    SXTL2 V27.4S, V22.8H
    FMAXP  V22.4S, V8.4S, V8.4S
    USHR  V8.2S, V9.2S, #16
    SRSHR  V2.2S, V26.2S, #25
    UMLAL2 V12.4S, V1.8H, V6.H[0x0]
    URSHR  V30.4S, V24.4S, #14
    SQDMLSL  V26.4S, V30.4H, V21.4H
    UHSUB  V9.8B, V16.8B, V8.8B
    CLS  V18.8H, V6.8H
    UMLSL2  V16.4S, V2.8H, V22.8H
    TBL  V13.16B, { V26.16B, V27.16B, V28.16B, V29.16B }, V16.16B
    UABAL  V6.2D, V13.2S, V18.2S
    MOV B1, V9.B[0x5]
    FCMGT  V8.2D, V6.2D, V12.2D
    SRI  V23.8H, V1.8H, #3
    UMLAL  V1.8H, V8.8B, V23.8B
    ADDV  S30, V18.4S
    FMAXP H23, V29.2H
    FMAX  V2.2S, V22.2S, V22.2S
    FCMGT  V21.8H, V4.8H, V14.8H
    ADDP  D14, V11.2D
    FMULX  V12.8H, V19.8H, V23.8H
    MVNI  V19.4S, #0xc5
    FRINTA  V4.4S, V11.4S
    TBL  V24.16B, { V23.16B, V24.16B, V25.16B, V26.16B }, V16.16B
    FMLS V11.4H, V30.4H, V12.H[0x0]
    SMINV  B13, V11.8B
    NOT  V16.8B, V24.8B
    MOVI  V8.4S, #0x15, LSL #24
    UMLAL V9.2D, V1.2S, V2.S[0x3]
    TBX  V22.8B, { V29.16B, V30.16B }, V21.8B
    FRECPS  V1.2S, V9.2S, V13.2S
    SHRN V26.8B, V4.8H, #5
    FADD  V13.2S, V19.2S, V19.2S
    FMUL  V18.8H, V13.8H, V22.8H
    UQRSHRN2 V25.4S, V1.2D, #20
    SQSHL V23.2D, V26.2D, #0x35
    UQSHL  V11.2S, V16.2S, #0x1a
    AND  V26.16B, V11.16B, V18.16B
    SSHLL2 V22.8H, V14.16B, #0x6
    FMINNMP  V12.4H, V25.4H, V8.4H
    FMLA  V14.2D, V12.2D, V23.2D
    CLZ  V18.4S, V14.4S
    FACGT  V4.2S, V22.2S, V18.2S
    UMLAL2 V18.2D, V26.4S, V4.S[0x2]
    FMULX H30, H16, V9.H[0x7]
    FCMGT  V8.8H, V2.8H, #0.0
    MOVI  V16.8B, #0xb9
    SSUBW  V14.4S, V14.4S, V23.4H
    MOV  V1.16B, V16.16B
    FMUL V19.2D, V16.2D, V19.D[0x1]
    INS V11.B[0xf], V11.B[0x9]
    UABA  V13.4H, V5.4H, V31.4H
    SADDLV  S2, V25.4H
    FMINNMP  V5.8H, V19.8H, V2.8H
    UADDLV  S4, V30.4H
    SQSHRUN V26.4H, V18.4S, #13
    SUQADD  V30.4H, V13.4H
    FCVTZS  V29.2S, V4.2S, #8
    FMIN  V2.4S, V14.4S, V8.4S
    FMAXNMP S23, V1.2S
    FMAXV  S25, V29.4S
    INS V16.S[0x3], V11.S[0x1]
    SABAL2  V13.2D, V16.4S, V25.4S
    FRECPE  V4.2S, V13.2S
    SMINV  B16, V4.8B
    SQDMLAL  V31.4S, V16.4H, V2.4H
    ADDHN  V14.2S, V5.2D, V4.2D
    SRHADD  V4.16B, V23.16B, V31.16B
    ZIP2  V2.2D, V0.2D, V30.2D
    SQDMULL V13.4S, V4.4H, V14.H[0x3]
    UADDLV  S16, V2.8H
    UQRSHL  V23.4H, V16.4H, V26.4H
    FMLS V8.2S, V23.2S, V18.S[0x3]
    FCVTPU  V19.8H, V13.8H
    SUBHN2  V18.4S, V19.2D, V19.2D
    SQRSHL  V29.2S, V18.2S, V8.2S
    RSUBHN  V27.2S, V0.2D, V1.2D
    FADDP D2, V8.2D
    FMAXNM  V8.2D, V16.2D, V21.2D
    FRINTA  V26.2S, V4.2S
    URSHL  V0.4S, V16.4S, V16.4S
    UQRSHRN2 V18.4S, V19.2D, #9
    FMULX V31.2S, V18.2S, V11.S[0x0]
    UMULL2 V14.2D, V15.4S, V2.S[0x2]
    TBL  V1.8B, { V9.16B, V10.16B, V11.16B, V12.16B }, V3.8B
    ADDHN  V4.2S, V7.2D, V22.2D
    FCVTPS  V30.2S, V27.2S
    SRHADD  V19.8H, V4.8H, V30.8H
    UADDLP  V7.4H, V31.8B
    ADDP  D27, V26.2D
    ADDHN2  V15.16B, V0.8H, V14.8H
    INS V25.S[0x1], V27.S[0x2]
    FRECPS  V18.2S, V8.2S, V8.2S
    RSHRN2 V5.16B, V17.8H, #5
    SADDLP  V30.4S, V29.8H
    UQRSHRN2 V16.4S, V30.2D, #2
    TBL  V3.8B, { V19.16B }, V1.8B
    SQRSHRUN V2.4H, V15.4S, #16
    DUP S22, V18.S[0x0]
    UMLSL  V27.4S, V16.4H, V25.4H
    FMINNMP D4, V27.2D
    FRECPE  V16.8H, V29.8H
    FMAXNMP H29, V3.2H
    SHA1SU0  V13.4S, V7.4S, V2.4S
    UQRSHRN V3.4H, V18.4S, #6
    UADDW  V12.2D, V1.2D, V16.2S
    FMUL  V2.8H, V24.8H, V7.8H
    FADDP  V16.2D, V2.2D, V13.2D
    URSHR  V10.16B, V3.16B, #3
    SQDMLAL V11.2D, V10.2S, V29.S[0x0]
    ADD  V18.4S, V4.4S, V11.4S
    DUP H15, V5.H[0x2]
    FMULX V11.2S, V22.2S, V22.S[0x2]
    FMLS H1, H11, V12.H[0x5]
    SQDMLAL  V25.2D, V16.2S, V16.2S
    DUP V7.4S, W29
    FACGT  V10.4S, V18.4S, V7.4S
    UMULL V11.4S, V25.4H, V15.H[0x1]
    CMGE  V5.2D, V1.2D, V1.2D
    SRSRA  V13.8H, V21.8H, #4
    RSUBHN2  V1.4S, V13.2D, V11.2D
    SHL V25.2D, V10.2D, #0x2e
    FMULX V11.2D, V1.2D, V5.D[0x0]
    UADALP  V13.2S, V13.4H
    SHA256H  Q5, Q15, V11.4S
    SHRN V10.4H, V25.4S, #8
    MOV V1.S[0x2], W5
    ADDP  D16, V13.2D
    FCVTNS  V21.4H, V10.4H
    AESE  V10.16B, V21.16B
    FSUB  V3.8H, V16.8H, V16.8H
    SQXTUN2  V16.4S, V5.2D
    SABAL  V18.4S, V16.4H, V1.4H
    ADDHN  V22.8B, V10.8H, V3.8H
    SMIN  V16.2S, V18.2S, V22.2S
    UQRSHL  V7.4S, V18.4S, V10.4S
    SRSHR  V15.2S, V15.2S, #18
    URSRA  V11.4H, V27.4H, #3
    SMINP  V18.4H, V1.4H, V19.4H
    UMAX  V27.16B, V8.16B, V20.16B
    SQSHLU  V3.8B, V22.8B, #0x3
    UMLAL V10.4S, V6.4H, V0.H[0x6]
    FRINTX  V1.4H, V4.4H
    FMLS D5, D23, V1.D[0x1]
    UQRSHRN V19.2S, V11.2D, #8
    DUP H6, V5.H[0x1]
    TBL  V13.16B, { V8.16B, V9.16B, V10.16B }, V7.16B
    SQSHLU  V21.4S, V15.4S, #0x1a
    FMAXP S25, V19.2S
    UADDLV  D0, V25.4S
    FCMGE  V15.8H, V16.8H, V16.8H
    FCMEQ  V16.4S, V13.4S, V10.4S
    SQSHL  V20.8H, V3.8H, #0x4
    FACGE  V22.4H, V6.4H, V20.4H
    FRECPS  V6.2S, V27.2S, V27.2S
    FCVTZU  V1.8H, V0.8H
    URSHL  V13.4H, V22.4H, V1.4H
    UMULL V0.2D, V9.2S, V13.S[0x3]
    URSHR V13.2D, V6.2D, #38
    SQSHRN V9.4H, V21.4S, #11
    UMLSL2  V3.4S, V9.8H, V15.8H
    FRINTA  V7.4S, V3.4S
    UCVTF  V21.2S, V16.2S, #18
    FMAXNMP  V10.4H, V21.4H, V7.4H
    SQDMULL V21.4S, V10.4H, V0.H[0x4]
    UMOV W10, V13.B[0xe]
    FCVTNU  V25.4H, V21.4H
    FMLS V7.2D, V25.2D, V25.D[0x0]
    SMOV  X15, V7.B[0x1]
    SRI  V0.8H, V26.8H, #7
    FSUB  V25.2D, V4.2D, V18.2D
    INS V4.H[0x1], W10
    FMIN  V16.8H, V24.8H, V11.8H
    SRI  V27.8H, V18.8H, #6
    SADDLV  D21, V0.4S
    SUBS  X29, X29, #0x1
    B.NE  TSRTAdvsimdVectorAllOperation_label_8
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X26, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X26, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X26, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X26, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X26, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X26, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X26, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X26, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X26, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x8000, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X26, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X26, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X26, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X26, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X26, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X26, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x97, LSL #0
    MOVK  X27, #0x800, LSL #16
    MRS  X26, FPSR
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, V0.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x1bb, LSL #0
    MOVK  X27, #0x1bb, LSL #16
    FMOV  X26, D0
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, V1.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, D1
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, V2.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, D2
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, V3.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, D3
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, V4.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, D4
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, V5.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x1278, LSL #0
    MOVK  X27, #0x5530, LSL #16
    MOVK  X27, #0xa8d0, LSL #32
    MOVK  X27, #0xe711, LSL #48
    FMOV  X26, D5
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, V6.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x4000, LSL #16
    MOVK  X27, #0x4000, LSL #48
    FMOV  X26, D6
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x8000, LSL #48
    FMOV  X26, V7.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x8000, LSL #48
    FMOV  X26, D7
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, V8.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, D8
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, V9.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, D9
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, V10.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, D10
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, V11.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x1bbb, LSL #0
    MOVK  X27, #0x1bbb, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    FMOV  X26, D11
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x7c00, LSL #0
    MOVK  X27, #0x7c00, LSL #16
    FMOV  X26, V12.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xfc80, LSL #0
    MOVK  X27, #0xfc80, LSL #16
    MOVK  X27, #0x8080, LSL #32
    MOVK  X27, #0x8080, LSL #48
    FMOV  X26, D12
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, V13.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x100, LSL #16
    FMOV  X26, D13
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, V14.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, D14
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    FMOV  X26, V15.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    FMOV  X26, D15
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, V16.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    FMOV  X26, D16
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, V17.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, D17
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, V18.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, D18
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, V19.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    FMOV  X26, D19
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, V20.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, D20
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, V21.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x1bb, LSL #0
    MOVK  X27, #0x1bb, LSL #16
    FMOV  X26, D21
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, V22.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    FMOV  X26, D22
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, V23.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x7e, LSL #0
    FMOV  X26, D23
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, V24.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, D24
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x8000, LSL #48
    FMOV  X26, V25.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x8000, LSL #48
    FMOV  X26, D25
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, V26.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xdddd, LSL #0
    MOVK  X27, #0xdddd, LSL #16
    FMOV  X26, D26
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, V27.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, D27
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x1800, LSL #0
    MOVK  X27, #0x7e8, LSL #16
    MOVK  X27, #0x800, LSL #32
    MOVK  X27, #0x1f8, LSL #48
    FMOV  X26, V28.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x800, LSL #0
    MOVK  X27, #0x7f0, LSL #16
    MOVK  X27, #0x1000, LSL #32
    MOVK  X27, #0x7e0, LSL #48
    FMOV  X26, D28
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, V29.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, D29
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, V30.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x3, LSL #0
    FMOV  X26, D30
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X26, V31.D[1]
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    FMOV  X26, D31
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X2, #0x7755, LSL #0
    MOVK  X2, #0x8ed6, LSL #16
    MOVK  X2, #0x3f9c, LSL #32
    MOVK  X2, #0x5948, LSL #48
    MOVZ  X3, #0x3013, LSL #0
    MOVK  X3, #0x39fe, LSL #16
    MOVK  X3, #0x28f3, LSL #32
    MOVK  X3, #0x4dee, LSL #48
    MOVZ  X4, #0x2fd0, LSL #0
    MOVK  X4, #0x490e, LSL #16
    MOVK  X4, #0x500, LSL #32
    MOVK  X4, #0x7f5, LSL #48
    MOVZ  X5, #0xf12a, LSL #0
    MOVK  X5, #0xc32b, LSL #16
    MOVK  X5, #0x24ce, LSL #32
    MOVK  X5, #0xa384, LSL #48
    MOVZ  X6, #0x92f4, LSL #0
    MOVK  X6, #0x105c, LSL #16
    MOVK  X6, #0x7fab, LSL #32
    MOVK  X6, #0x4af3, LSL #48
    MOVZ  X7, #0x9ad2, LSL #0
    MOVK  X7, #0xc497, LSL #16
    MOVK  X7, #0xd904, LSL #32
    MOVK  X7, #0xd9c8, LSL #48
    MOVZ  X8, #0x7dfe, LSL #0
    MOVK  X8, #0xee5f, LSL #16
    MOVK  X8, #0x23ef, LSL #32
    MOVK  X8, #0xb3c8, LSL #48
    MOVZ  X9, #0xda7c, LSL #0
    MOVK  X9, #0x2343, LSL #16
    MOVK  X9, #0x232e, LSL #32
    MOVK  X9, #0x823a, LSL #48
    MOVZ  X10, #0x4074, LSL #0
    MOVK  X10, #0x4e93, LSL #16
    MOVK  X10, #0x2bae, LSL #32
    MOVK  X10, #0x4e6b, LSL #48
    MOVZ  X12, #0x5506, LSL #0
    MOVK  X12, #0x5410, LSL #16
    MOVK  X12, #0x1b94, LSL #32
    MOVK  X12, #0xe13a, LSL #48
    MOVZ  X13, #0x91c0, LSL #0
    MOVK  X13, #0x9578, LSL #16
    MOVK  X13, #0xff36, LSL #32
    MOVK  X13, #0x517e, LSL #48
    MOVZ  X15, #0x5ed6, LSL #0
    MOVK  X15, #0x8bcf, LSL #16
    MOVK  X15, #0xd136, LSL #32
    MOVK  X15, #0x5a6f, LSL #48
    MOVZ  X16, #0x4, LSL #0
    MOVK  X16, #0x968, LSL #16
    MOVK  X16, #0xfc45, LSL #32
    MOVK  X16, #0x85f3, LSL #48
    MOVZ  X17, #0xf123, LSL #0
    MOVK  X17, #0xf617, LSL #16
    MOVK  X17, #0xd41d, LSL #32
    MOVK  X17, #0xadc9, LSL #48
    MOVZ  X19, #0x7229, LSL #0
    MOVK  X19, #0xb137, LSL #16
    MOVK  X19, #0xec3c, LSL #32
    MOVK  X19, #0x74e1, LSL #48
    MOVZ  X20, #0xcbd9, LSL #0
    MOVK  X20, #0xbaae, LSL #16
    MOVK  X20, #0x1c3c, LSL #32
    MOVK  X20, #0xa08d, LSL #48
    MOVZ  X22, #0x92c5, LSL #0
    MOVK  X22, #0xd7e2, LSL #16
    MOVK  X22, #0xfcb3, LSL #32
    MOVK  X22, #0xce45, LSL #48
    MOVZ  X23, #0xe775, LSL #0
    MOVK  X23, #0x303e, LSL #16
    MOVK  X23, #0x354e, LSL #32
    MOVK  X23, #0x7745, LSL #48
    MOVZ  X24, #0xfc86, LSL #0
    MOVK  X24, #0xd6f9, LSL #16
    MOVK  X24, #0xa8a8, LSL #32
    MOVK  X24, #0x6596, LSL #48
    MOVZ  X25, #0x11c, LSL #0
    MOVK  X25, #0xb9ce, LSL #16
    MOVK  X25, #0x6600, LSL #32
    MOVK  X25, #0x49a3, LSL #48
    MOVZ  X26, #0x1a90, LSL #0
    MOVK  X26, #0xa1b6, LSL #16
    MOVK  X26, #0xf28b, LSL #32
    MOVK  X26, #0xdc7b, LSL #48
    MOVZ  X27, #0x8a47, LSL #0
    MOVK  X27, #0x63b, LSL #16
    MOVK  X27, #0x825f, LSL #32
    MOVK  X27, #0x75e5, LSL #48
    MOVZ  X28, #0x3f5e, LSL #0
    MOVK  X28, #0x7d64, LSL #16
    MOVK  X28, #0x21c2, LSL #32
    MOVK  X28, #0x8881, LSL #48
    MOVZ  X29, #0x45d8, LSL #0
    MOVK  X29, #0xc06a, LSL #16
    MOVK  X29, #0xc63e, LSL #32
    MOVK  X29, #0x376c, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X29
    FMOV  D1, X28
    FMOV  V1.D[1], X25
    FMOV  D2, X27
    FMOV  V2.D[1], X26
    FMOV  D3, X28
    FMOV  V3.D[1], X10
    FMOV  D4, X12
    FMOV  V4.D[1], X3
    FMOV  D5, X27
    FMOV  V5.D[1], X20
    FMOV  D6, X27
    FMOV  V6.D[1], X17
    FMOV  D7, X22
    FMOV  V7.D[1], X28
    FMOV  D8, X17
    FMOV  V8.D[1], X26
    FMOV  D9, X19
    FMOV  V9.D[1], X15
    FMOV  D10, X25
    FMOV  V10.D[1], X25
    FMOV  D11, X26
    FMOV  V11.D[1], X3
    FMOV  D12, X4
    FMOV  V12.D[1], X12
    FMOV  D13, X2
    FMOV  V13.D[1], X4
    FMOV  D14, X19
    FMOV  V14.D[1], X15
    FMOV  D15, X29
    FMOV  V15.D[1], X7
    FMOV  D16, X19
    FMOV  V16.D[1], X8
    FMOV  D17, X26
    FMOV  V17.D[1], X16
    FMOV  D18, X9
    FMOV  V18.D[1], X15
    FMOV  D19, X4
    FMOV  V19.D[1], X29
    FMOV  D20, X6
    FMOV  V20.D[1], X23
    FMOV  D21, X13
    FMOV  V21.D[1], X26
    FMOV  D22, X5
    FMOV  V22.D[1], X19
    FMOV  D23, X6
    FMOV  V23.D[1], X23
    FMOV  D24, X4
    FMOV  V24.D[1], X23
    FMOV  D25, X24
    FMOV  V25.D[1], X27
    FMOV  D26, X3
    FMOV  V26.D[1], X7
    FMOV  D27, X24
    FMOV  V27.D[1], X29
    FMOV  D28, X5
    FMOV  V28.D[1], X16
    FMOV  D29, X16
    FMOV  V29.D[1], X22
    FMOV  D30, X6
    FMOV  V30.D[1], X19
    FMOV  D31, X12
    FMOV  V31.D[1], X29
    MOVZ  X10, #0xa, LSL #0
TSRTAdvsimdVectorAllOperation_label_9:
    SSHR  V15.2S, V25.2S, #14
    UABDL2  V27.4S, V22.8H, V27.8H
    SQSHRUN2 V12.4S, V24.2D, #16
    SHA256SU0  V6.4S, V31.4S
    FMLA  V10.4S, V26.4S, V27.4S
    FCMGT  V27.8H, V10.8H, V20.8H
    SQRSHRN V1.8B, V27.8H, #3
    ORN  V0.16B, V29.16B, V30.16B
    SSUBL2  V12.2D, V28.4S, V0.4S
    MOV B16, V15.B[0x5]
    FMLA V14.2S, V12.2S, V23.S[0x1]
    FRINTM  V25.2S, V14.2S
    SQSUB  V29.4H, V16.4H, V25.4H
    MVN  V12.8B, V6.8B
    UMLAL2 V0.4S, V1.8H, V12.H[0x0]
    UMULL V31.4S, V0.4H, V3.H[0x7]
    USRA V14.2D, V29.2D, #1
    URSRA  V24.4H, V31.4H, #15
    SQSHRUN V31.2S, V14.2D, #24
    USHR V30.2D, V24.2D, #63
    SQDMULL2 V12.2D, V30.4S, V31.S[0x3]
    USHLL2 V20.4S, V24.8H, #0xe
    SSUBL  V14.2D, V31.2S, V3.2S
    SHA1SU0  V22.4S, V18.4S, V18.4S
    UQSUB  V18.8B, V5.8B, V22.8B
    FCVTZU  V1.2S, V11.2S, #1
    UMAXP  V15.16B, V18.16B, V20.16B
    BSL  V3.16B, V7.16B, V29.16B
    SABAL  V10.4S, V3.4H, V5.4H
    SQXTUN  V22.4H, V3.4S
    FMULX V0.2D, V28.2D, V11.D[0x0]
    EOR  V11.16B, V23.16B, V11.16B
    TBL  V5.16B, { V18.16B, V19.16B }, V7.16B
    SQABS  V23.16B, V27.16B
    FACGE  V24.4S, V22.4S, V5.4S
    SQDMLAL  V31.2D, V0.2S, V24.2S
    DUP  V27.2S, V1.S[0x3]
    CMEQ  V30.4H, V23.4H, #0
    SHA1SU1  V7.4S, V14.4S
    FMLA  V28.8H, V10.8H, V21.8H
    FCMLE  V20.4H, V31.4H, #0.0
    CMLT  V16.4S, V27.4S, #0
    SRI  V25.4H, V15.4H, #1
    RSHRN V6.4H, V11.4S, #5
    RBIT  V27.8B, V30.8B
    SQSHRUN2 V3.4S, V12.2D, #28
    SMULL  V20.4S, V20.4H, V3.4H
    SSHLL V31.8H, V27.8B, #0x3
    UQSHRN V14.2S, V31.2D, #15
    FMLA H21, H25, V14.H[0x4]
    SQDMULL S19, H16, V12.H[0x3]
    FABS  V29.2D, V21.2D
    SSHR  V31.8B, V29.8B, #8
    SHRN V10.4H, V7.4S, #12
    MOV  W17, V2.S[0x2]
    SQDMULL V16.2D, V10.2S, V28.S[0x0]
    URSRA V12.2D, V20.2D, #17
    FMLA V2.4S, V12.4S, V31.S[0x3]
    FSQRT  V11.8H, V16.8H
    FCMGE  V15.2D, V2.2D, V19.2D
    MUL  V14.4H, V6.4H, V6.H[0x0]
    FMUL  V7.4H, V21.4H, V14.4H
    FADD  V31.2D, V15.2D, V11.2D
    ORR  V11.4H, #0x2b, LSL #8
    SQRDMULH S30, S7, V11.S[0x2]
    SHA1C  Q11, S31, V31.4S
    SQSHLU  V14.16B, V30.16B, #0x4
    SQSHL  V29.4H, V14.4H, V14.4H
    FCVTNS  V3.2D, V29.2D
    SQSHRN2 V12.16B, V17.8H, #4
    UMINV  S25, V12.4S
    SABAL2  V21.8H, V25.16B, V25.16B
    FMULX V25.8H, V3.8H, V11.H[0x6]
    SCVTF  V15.2D, V25.2D
    UADDL2  V7.2D, V21.4S, V15.4S
    SQDMLSL S2, H4, V9.H[0x6]
    FCVTMS  V11.4H, V24.4H
    SSHLL2 V19.2D, V24.4S, #0xf
    SQDMLAL2 V4.4S, V15.8H, V15.H[0x3]
    TRN1  V30.4S, V21.4S, V22.4S
    FCVTZS  V6.8H, V23.8H, #1
    URSHR  V31.2S, V8.2S, #3
    SMOV W20, V17.H[0x2]
    FRINTI  V24.8H, V16.8H
    SABD  V14.4H, V1.4H, V11.4H
    TBX  V29.8B, { V30.16B }, V25.8B
    FCVTZS  V20.8H, V19.8H, #4
    SQDMULL S19, H20, V7.H[0x0]
    SMLAL2 V12.2D, V14.4S, V31.S[0x3]
    FADD  V20.2D, V4.2D, V19.2D
    FMAXP D23, V12.2D
    FCVTPU  V9.2S, V24.2S
    SQRSHRN2 V3.4S, V20.2D, #24
    UMULL V7.4S, V23.4H, V3.H[0x6]
    SQSHL  V4.4H, V7.4H, V2.4H
    UMAXV  S1, V6.4S
    SMAXV  S19, V4.4S
    SQDMLSL  V12.4S, V19.4H, V29.4H
    URHADD  V22.2S, V9.2S, V9.2S
    UXTL2 V29.8H, V12.16B
    UADDL2  V8.2D, V29.4S, V29.4S
    SMLSL  V15.4S, V24.4H, V1.4H
    UQSHRN V23.4H, V15.4S, #8
    UHSUB  V7.16B, V8.16B, V31.16B
    SQSHL  V6.16B, V23.16B, #0x5
    USQADD  V2.16B, V6.16B
    FCVTNU  V29.2S, V7.2S
    FACGE  V14.8H, V29.8H, V22.8H
    CMHI  V9.4H, V2.4H, V2.4H
    FMINNM  V24.4H, V9.4H, V20.4H
    DUP V2.4S, W20
    SQSHLU  V22.8H, V5.8H, #0x5
    SQRSHRN V5.4H, V2.4S, #10
    MLA  V23.2S, V5.2S, V5.S[0x1]
    CLZ  V8.16B, V23.16B
    UQADD  V7.2D, V22.2D, V18.2D
    UMLSL  V15.4S, V27.4H, V7.4H
    FMLS V31.8H, V14.8H, V11.H[0x5]
    TBX  V18.16B, { V2.16B, V3.16B, V4.16B }, V8.16B
    FMINNMP  V29.2D, V24.2D, V18.2D
    FMLA V6.2S, V31.2S, V15.S[0x2]
    FCMGE  V11.8H, V6.8H, #0.0
    BIT  V6.8B, V11.8B, V29.8B
    UMAX  V29.16B, V7.16B, V7.16B
    FADD  V24.8H, V5.8H, V5.8H
    RSHRN2 V5.4S, V14.2D, #15
    XTN2  V23.16B, V14.8H
    FMLS  V20.8H, V17.8H, V30.8H
    DUP V17.2D, V16.D[0x0]
    SXTL2 V14.2D, V26.4S
    UMOV W22, V0.S[0x3]
    USUBL2  V1.2D, V30.4S, V20.4S
    FMAX  V4.2S, V25.2S, V27.2S
    FCMGT  V15.2S, V6.2S, #0.0
    SQRSHRUN V6.4H, V15.4S, #2
    SADDL2  V2.2D, V4.4S, V1.4S
    FMAXNM  V7.2D, V17.2D, V29.2D
    FCVTAU  V17.2D, V14.2D
    FMINP D22, V6.2D
    FMUL V11.4H, V22.4H, V7.H[0x3]
    UMLSL2 V31.2D, V17.4S, V11.S[0x3]
    SMLAL2 V16.2D, V2.4S, V23.S[0x3]
    SMINV  S8, V9.4S
    FMOV  V3.4S, #0.93750000
    SUBHN  V17.2S, V31.2D, V31.2D
    SQRSHRUN2 V27.4S, V5.2D, #28
    UMAXP  V7.16B, V16.16B, V3.16B
    SHL  V18.8H, V27.8H, #0xc
    URSRA V4.2D, V24.2D, #19
    SHLL  V9.8H, V8.8B, #8
    UADDLV  H2, V10.16B
    SQRSHL  V10.8H, V2.8H, V17.8H
    SQDMULL V8.2D, V9.2S, V9.S[0x1]
    UABDL2  V22.2D, V7.4S, V4.4S
    SMOV  X5, V10.S[0x0]
    RSHRN2 V6.16B, V22.8H, #5
    MLA  V3.16B, V8.16B, V18.16B
    SHA1P  Q4, S3, V2.4S
    INS V2.S[0x1], W28
    FCMGT  V9.4H, V2.4H, V2.4H
    FRECPE  V16.4H, V9.4H
    URSHR  V9.2S, V6.2S, #25
    FCMEQ  V3.2D, V9.2D, V9.2D
    FMINNMP S7, V4.2S
    SQABS  V10.2D, V7.2D
    SRI V11.2D, V10.2D, #55
    SQSHRN V22.8B, V11.8H, #5
    FMAXNMP D10, V8.2D
    SLI  V9.4H, V3.4H, #0x4
    FCMGE  V4.4H, V16.4H, #0.0
    FRINTM  V11.2S, V9.2S
    SHRN V2.2S, V11.2D, #26
    FMULX  V17.8H, V2.8H, V2.8H
    USHLL2 V6.8H, V4.16B, #0x7
    USHLL V18.8H, V6.8B, #0x5
    UABDL  V6.8H, V18.8B, V18.8B
    UCVTF  V27.2S, V22.2S
    MOV V7.B[0x5], V6.B[0xf]
    SABDL2  V8.8H, V17.16B, V17.16B
    FMLS  V6.4H, V10.4H, V27.4H
    FMAXP  V18.2S, V6.2S, V6.2S
    FCVTNS  V27.2D, V8.2D
    MOV V17.B[0xc], V27.B[0x1]
    SMLAL  V17.4S, V7.4H, V23.4H
    SSHLL2 V27.8H, V18.16B, #0x2
    UMLSL  V22.8H, V27.8B, V17.8B
    UQSHL  V12.2S, V30.2S, #0xe
    SQNEG  V10.4H, V18.4H
    USHR V6.2D, V17.2D, #39
    SQSHRN2 V17.4S, V2.2D, #6
    TBL  V27.16B, { V25.16B, V26.16B, V27.16B, V28.16B }, V18.16B
    FRINTM  V3.2S, V27.2S
    RBIT  V16.16B, V3.16B
    URSRA V2.2D, V21.2D, #62
    UMLSL V7.4S, V21.4H, V4.H[0x0]
    SLI V23.2D, V0.2D, #0xb
    SSRA V18.2D, V23.2D, #49
    TBL  V25.8B, { V26.16B, V27.16B, V28.16B, V29.16B }, V12.8B
    FCVTXN  V23.2S, V22.2D
    SQABS  V28.4S, V7.4S
    FMAX  V0.2S, V23.2S, V2.2S
    SABDL  V3.4S, V18.4H, V6.4H
    UMINP  V21.2S, V3.2S, V28.2S
    USHR  V8.2S, V16.2S, #11
    FSUB  V25.2S, V8.2S, V25.2S
    UQXTN  V4.8B, V19.8H
    UCVTF  V30.8H, V0.8H, #5
    FCVTPS  V19.4S, V17.4S
    SQRDMULH H7, H19, V13.H[0x3]
    SMLSL  V22.4S, V10.4H, V21.4H
    TBX  V10.8B, { V7.16B }, V15.8B
    DUP  V15.16B, V16.B[0x2]
    SQSHL V13.2D, V15.2D, #0x3
    SQRSHRN2 V15.16B, V13.8H, #1
    FRINTX  V13.4S, V25.4S
    SRSRA  V18.8H, V17.8H, #16
    SHA1P  Q0, S4, V15.4S
    MOV B4, V30.B[0x0]
    USHLL2 V26.2D, V22.4S, #0xe
    UMLSL  V8.2D, V2.2S, V0.2S
    SADDW2  V21.8H, V10.8H, V10.16B
    FRSQRTE  V10.2S, V21.2S
    FMUL H25, H10, V10.H[0x7]
    SHADD  V27.8B, V13.8B, V25.8B
    SQRSHRN V16.2S, V18.2D, #19
    SMLAL2 V21.4S, V8.8H, V12.H[0x0]
    FMLS D10, D4, V19.D[0x0]
    UMIN  V0.8B, V10.8B, V10.8B
    SQABS  V4.16B, V26.16B
    SRSRA  V2.2S, V27.2S, #19
    UQRSHRN2 V27.4S, V2.2D, #30
    UQXTN2  V22.16B, V16.8H
    UADDLP  V17.2S, V21.4H
    SQSHRUN V15.2S, V17.2D, #27
    FRSQRTE  V2.8H, V4.8H
    FMLS D16, D0, V2.D[0x0]
    UQSUB  V13.4S, V15.4S, V27.4S
    FMINP S26, V22.2S
    UADDLV  S10, V13.4H
    FRSQRTS  V30.2S, V16.2S, V10.2S
    SLI V8.2D, V30.2D, #0x31
    UQRSHL  V10.8H, V8.8H, V8.8H
    SQRSHL  V17.16B, V26.16B, V26.16B
    MOV V14.B[0x4], W9
    SQSHRN V12.8B, V14.8H, #3
    FMINP D18, V12.2D
    SHA1SU1  V0.4S, V18.4S
    UMLSL2 V27.2D, V10.4S, V17.S[0x0]
    UZP1  V13.2D, V0.2D, V27.2D
    CMGE  V26.2S, V24.2S, V4.2S
    FSUB  V8.2D, V21.2D, V25.2D
    CMLE  V16.4S, V18.4S, #0
    USHR V30.2D, V23.2D, #33
    SHADD  V19.4S, V24.4S, V1.4S
    UMULL  V9.2D, V26.2S, V1.2S
    SQSHRUN2 V28.16B, V7.8H, #8
    FCMLE  V25.4S, V4.4S, #0.0
    SHRN2 V26.4S, V27.2D, #19
    FRINTM  V21.2D, V19.2D
    USRA V23.2D, V25.2D, #53
    TBL  V18.8B, { V8.16B, V9.16B }, V24.8B
    BSL  V25.16B, V16.16B, V1.16B
    FADDP D27, V28.2D
    TBL  V28.8B, { V27.16B }, V13.8B
    FMULX V13.4S, V30.4S, V21.S[0x0]
    SRI  V10.16B, V13.16B, #4
    SQSHRN V0.4H, V28.4S, #10
    FMLA D17, D23, V0.D[0x1]
    FRINTP  V19.8H, V25.8H
    FRINTM  V7.4H, V10.4H
    MOV V4.B[0x7], W8
    FCVTNU  V10.2S, V6.2S
    USRA  V23.16B, V18.16B, #7
    UCVTF  V18.4S, V4.4S, #31
    SQDMLAL S12, H18, V10.H[0x0]
    UMULL V4.4S, V12.4H, V12.H[0x3]
    FCVTAS  V1.4S, V23.4S
    INS V17.B[0x2], W10
    SRSHL  V6.4S, V26.4S, V4.4S
    SQDMULL  V25.2D, V1.2S, V1.2S
    FABS  V9.2S, V25.2S
    SHA256H2  Q13, Q9, V10.4S
    SHA1M  Q10, S13, V13.4S
    SHA256SU0  V27.4S, V7.4S
    FRINTN  V13.4S, V27.4S
    UQRSHRN2 V7.16B, V6.8H, #4
    FRINTI  V1.8H, V25.8H
    MOV V4.D[0x0], V10.D[0x0]
    SCVTF  V10.2D, V13.2D
    AESMC  V6.16B, V1.16B
    UMAXV  S8, V17.4S
    MOVI  V16.2D, #18446744069414649600
    MVNI  V1.8H, #0xfb
    SXTL V18.2D, V7.2S
    SUBHN  V25.2S, V10.2D, V4.2D
    USHLL2 V26.4S, V25.8H, #0xc
    FCVTZS  V27.4S, V6.4S
    FCVTZS V10.2D, V18.2D, #53
    FMLA V13.4S, V19.4S, V8.S[0x3]
    EOR  V4.16B, V13.16B, V10.16B
    SUBS  X10, X10, #0x1
    B.NE  TSRTAdvsimdVectorAllOperation_label_9
    MOVZ  X25, #0x7755, LSL #0
    MOVK  X25, #0x8ed6, LSL #16
    MOVK  X25, #0x3f9c, LSL #32
    MOVK  X25, #0x5948, LSL #48
    SUB  X6, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x3013, LSL #0
    MOVK  X25, #0x39fe, LSL #16
    MOVK  X25, #0x28f3, LSL #32
    MOVK  X25, #0x4dee, LSL #48
    SUB  X6, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x2fd0, LSL #0
    MOVK  X25, #0x490e, LSL #16
    MOVK  X25, #0x500, LSL #32
    MOVK  X25, #0x7f5, LSL #48
    SUB  X6, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x4ec, LSL #0
    SUB  X6, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x9ad2, LSL #0
    MOVK  X25, #0xc497, LSL #16
    MOVK  X25, #0xd904, LSL #32
    MOVK  X25, #0xd9c8, LSL #48
    SUB  X6, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x7dfe, LSL #0
    MOVK  X25, #0xee5f, LSL #16
    MOVK  X25, #0x23ef, LSL #32
    MOVK  X25, #0xb3c8, LSL #48
    SUB  X6, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0xda7c, LSL #0
    MOVK  X25, #0x2343, LSL #16
    MOVK  X25, #0x232e, LSL #32
    MOVK  X25, #0x823a, LSL #48
    SUB  X6, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X6, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x5506, LSL #0
    MOVK  X25, #0x5410, LSL #16
    MOVK  X25, #0x1b94, LSL #32
    MOVK  X25, #0xe13a, LSL #48
    SUB  X6, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x5ed6, LSL #0
    MOVK  X25, #0x8bcf, LSL #16
    MOVK  X25, #0xd136, LSL #32
    MOVK  X25, #0x5a6f, LSL #48
    SUB  X6, X25, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x4, LSL #0
    MOVK  X25, #0x968, LSL #16
    MOVK  X25, #0xfc45, LSL #32
    MOVK  X25, #0x85f3, LSL #48
    SUB  X6, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x7c00, LSL #0
    MOVK  X25, #0x7c00, LSL #16
    SUB  X6, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x7229, LSL #0
    MOVK  X25, #0xb137, LSL #16
    MOVK  X25, #0xec3c, LSL #32
    MOVK  X25, #0x74e1, LSL #48
    SUB  X6, X25, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X6, X25, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0xfff0, LSL #0
    MOVK  X25, #0xfff8, LSL #16
    SUB  X6, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0xe775, LSL #0
    MOVK  X25, #0x303e, LSL #16
    MOVK  X25, #0x354e, LSL #32
    MOVK  X25, #0x7745, LSL #48
    SUB  X6, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0xfc86, LSL #0
    MOVK  X25, #0xd6f9, LSL #16
    MOVK  X25, #0xa8a8, LSL #32
    MOVK  X25, #0x6596, LSL #48
    SUB  X6, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x1a90, LSL #0
    MOVK  X25, #0xa1b6, LSL #16
    MOVK  X25, #0xf28b, LSL #32
    MOVK  X25, #0xdc7b, LSL #48
    SUB  X6, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x8a47, LSL #0
    MOVK  X25, #0x63b, LSL #16
    MOVK  X25, #0x825f, LSL #32
    MOVK  X25, #0x75e5, LSL #48
    SUB  X6, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x3f5e, LSL #0
    MOVK  X25, #0x7d64, LSL #16
    MOVK  X25, #0x21c2, LSL #32
    MOVK  X25, #0x8881, LSL #48
    SUB  X6, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x45d8, LSL #0
    MOVK  X25, #0xc06a, LSL #16
    MOVK  X25, #0xc63e, LSL #32
    MOVK  X25, #0x376c, LSL #48
    SUB  X6, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x9f, LSL #0
    MOVK  X25, #0x800, LSL #16
    MRS  X6, FPSR
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, V0.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, D0
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0xff04, LSL #0
    MOVK  X25, #0xff04, LSL #16
    MOVK  X25, #0xff04, LSL #32
    MOVK  X25, #0xff04, LSL #48
    FMOV  X6, V1.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0xff04, LSL #0
    MOVK  X25, #0xff04, LSL #16
    MOVK  X25, #0xff04, LSL #32
    MOVK  X25, #0xff04, LSL #48
    FMOV  X6, D1
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x7c00, LSL #0
    MOVK  X25, #0x7c00, LSL #16
    MOVK  X25, #0x7c00, LSL #32
    MOVK  X25, #0x7c00, LSL #48
    FMOV  X6, V2.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x7c00, LSL #0
    MOVK  X25, #0x7c00, LSL #16
    MOVK  X25, #0x7c00, LSL #32
    MOVK  X25, #0x7c00, LSL #48
    FMOV  X6, D2
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x8000, LSL #32
    FMOV  X6, V3.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x1c01, LSL #0
    MOVK  X25, #0x7fff, LSL #32
    FMOV  X6, D3
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X6, V4.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X6, D4
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, V5.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, D5
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, V6.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, D6
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xff, LSL #32
    MOVK  X25, #0xff, LSL #48
    FMOV  X6, V7.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, D7
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, V8.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x1, LSL #16
    FMOV  X6, D8
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, V9.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, D9
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, V10.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, D10
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, V11.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0xfff0, LSL #0
    MOVK  X25, #0xfff0, LSL #16
    MOVK  X25, #0xfff0, LSL #32
    MOVK  X25, #0xfff0, LSL #48
    FMOV  X6, D11
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, V12.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xf, LSL #16
    FMOV  X6, D12
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X6, V13.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X6, D13
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, V14.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7c, LSL #32
    FMOV  X6, D14
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, V15.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, D15
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0xff00, LSL #0
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X6, V16.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0xff00, LSL #0
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X6, D16
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, V17.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x1, LSL #16
    FMOV  X6, D17
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, V18.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, D18
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X6, V19.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X6, D19
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X6, V20.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X6, D20
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X6, V21.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X6, D21
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0xff00, LSL #0
    FMOV  X6, V22.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, D22
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x7ff, LSL #0
    FMOV  X6, V23.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x7ff, LSL #0
    FMOV  X6, D23
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, V24.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, D24
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, V25.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, D25
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, V26.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, D26
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, V27.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, D27
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, V28.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, D28
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, V29.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, D29
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, V30.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X6, D30
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x7fff, LSL #0
    MOVK  X25, #0x7fff, LSL #16
    MOVK  X25, #0x7fff, LSL #32
    MOVK  X25, #0x7fff, LSL #48
    FMOV  X6, V31.D[1]
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X25, #0x7fff, LSL #0
    MOVK  X25, #0x7fff, LSL #16
    MOVK  X25, #0x7fff, LSL #32
    MOVK  X25, #0x7fff, LSL #48
    FMOV  X6, D31
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorAllOperation_TestFail
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
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X12
    FMOV  V0.D[1], X24
    FMOV  D1, X6
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X27
    FMOV  D3, X17
    FMOV  V3.D[1], X22
    FMOV  D4, X28
    FMOV  V4.D[1], X20
    FMOV  D5, X19
    FMOV  V5.D[1], X29
    FMOV  D6, X23
    FMOV  V6.D[1], X29
    FMOV  D7, X24
    FMOV  V7.D[1], X16
    FMOV  D8, X13
    FMOV  V8.D[1], X2
    FMOV  D9, X2
    FMOV  V9.D[1], X16
    FMOV  D10, X23
    FMOV  V10.D[1], X6
    FMOV  D11, X5
    FMOV  V11.D[1], X29
    FMOV  D12, X13
    FMOV  V12.D[1], X17
    FMOV  D13, X22
    FMOV  V13.D[1], X8
    FMOV  D14, X7
    FMOV  V14.D[1], X19
    FMOV  D15, X19
    FMOV  V15.D[1], X19
    FMOV  D16, X25
    FMOV  V16.D[1], X5
    FMOV  D17, X26
    FMOV  V17.D[1], X2
    FMOV  D18, X26
    FMOV  V18.D[1], X7
    FMOV  D19, X4
    FMOV  V19.D[1], X7
    FMOV  D20, X2
    FMOV  V20.D[1], X24
    FMOV  D21, X5
    FMOV  V21.D[1], X26
    FMOV  D22, X28
    FMOV  V22.D[1], X29
    FMOV  D23, X5
    FMOV  V23.D[1], X29
    FMOV  D24, X19
    FMOV  V24.D[1], X28
    FMOV  D25, X16
    FMOV  V25.D[1], X4
    FMOV  D26, X12
    FMOV  V26.D[1], X25
    FMOV  D27, X9
    FMOV  V27.D[1], X27
    FMOV  D28, X8
    FMOV  V28.D[1], X8
    FMOV  D29, X16
    FMOV  V29.D[1], X6
    FMOV  D30, X3
    FMOV  V30.D[1], X5
    FMOV  D31, X17
    FMOV  V31.D[1], X13
    MOVZ  X6, #0xa, LSL #0
TSRTAdvsimdVectorAllOperation_label_10:
    SHRN V29.2S, V27.2D, #12
    FMAXNMV  S17, V28.4S
    DUP  V3.16B, V18.B[0x1]
    MVNI  V6.2S, #0x76
    SQSHRUN V11.2S, V30.2D, #3
    FCVTMU  V1.2S, V31.2S
    UMLAL V24.4S, V6.4H, V1.H[0x6]
    MOVI  V21.16B, #0x4b
    SHL  V24.16B, V26.16B, #0x4
    UMIN  V29.16B, V24.16B, V24.16B
    SHA256H2  Q6, Q17, V29.4S
    FCVTPU  V12.8H, V3.8H
    FADDP H30, V12.2H
    UQSHL  V30.16B, V30.16B, #0x6
    SQSHRUN V26.4H, V6.4S, #2
    FABS  V12.4S, V11.4S
    SQSHL V3.2D, V30.2D, #0xd
    SQRSHRUN V4.4H, V26.4S, #1
    FACGT  V7.8H, V3.8H, V4.8H
    SQSHLU V9.2D, V12.2D, #0x21
    FMAX  V17.2D, V7.2D, V9.2D
    FCMLT  V28.2S, V17.2S, #0.0
    FMLS D27, D5, V28.D[0x0]
    SQSHL V3.2D, V27.2D, #0x23
    SMLAL V29.2D, V3.2S, V3.S[0x2]
    FCVTPU  V11.4H, V29.4H
    FCVTMU  V7.2S, V11.2S
    FCVTZU V24.2D, V21.2D, #43
    SQDMLSL2 V3.2D, V24.4S, V14.S[0x3]
    UCVTF  V5.4S, V7.4S
    FCMLT  V4.8H, V5.8H, #0.0
    UXTL2 V18.2D, V3.4S
    FCMEQ  V14.4H, V18.4H, #0.0
    ORR  V6.8B, V4.8B, V14.8B
    FMINNMP D21, V28.2D
    SMULL2 V29.4S, V20.8H, V10.H[0x4]
    FCVTZS  V27.2D, V19.2D
    UMLAL  V17.8H, V4.8B, V29.8B
    UMOV W15, V25.B[0x2]
    SQDMLSL2 V10.2D, V23.4S, V1.S[0x2]
    SQNEG  V11.8H, V29.8H
    UXTL V24.2D, V18.2S
    UMINV  B18, V23.8B
    UMLSL2 V23.2D, V17.4S, V13.S[0x2]
    UQSUB  V5.2S, V27.2S, V17.2S
    SADDLV  S26, V7.8H
    DUP V1.4H, W5
    SQDMLAL V25.2D, V20.2S, V1.S[0x0]
    FCVTZS  V14.4H, V11.4H
    UMINV  B3, V24.16B
    SRSRA V13.2D, V14.2D, #34
    UQRSHRN V28.4H, V10.4S, #11
    SSHLL2 V20.2D, V26.4S, #0x19
    SQDMLSL2  V29.4S, V5.8H, V13.8H
    UCVTF  V4.8H, V23.8H, #1
    SSHLL V7.8H, V4.8B, #0x7
    FCVTNU  V26.2D, V25.2D
    USUBW2  V13.2D, V6.2D, V18.4S
    EXT  V23.8B, V3.8B, V21.8B, #0x1
    MOV V11.D[0x0], X15
    SQSHRN V25.2S, V18.2D, #13
    FMUL V19.2D, V18.2D, V25.D[0x1]
    DUP  V18.2S, V19.S[0x2]
    FCMGE  V6.2S, V7.2S, V26.2S
    FMINV  S1, V6.4S
    SUQADD  V5.16B, V1.16B
    UABAL2  V7.4S, V28.8H, V20.8H
    SCVTF  V10.2S, V23.2S, #32
    FMOV  V24.4S, #-21.00000000
    FCVTPS  V14.4S, V24.4S
    FCVTXN2  V23.4S, V7.2D
    UMLSL V4.2D, V18.2S, V9.S[0x3]
    ORR  V25.4S, #0xd4, LSL #24
    FMULX V28.4S, V23.4S, V4.S[0x2]
    FCVTZS V21.2D, V28.2D, #39
    MOVI  V3.4S, #0x1a, MSL #8
    FCVTN  V24.4H, V25.4S
    SHL V9.2D, V29.2D, #0x6
    ORR  V19.2S, #0x6f, LSL #24
    UMOV W3, V24.H[0x0]
    USHLL2 V24.8H, V14.16B, #0x1
    URSHR V25.2D, V24.2D, #10
    ADDV  H7, V10.8H
    USUBW  V20.2D, V5.2D, V25.2S
    DUP  V14.16B, V20.B[0x2]
    FRINTZ  V18.8H, V14.8H
    SQDMULL  V14.2D, V3.2S, V3.2S
    FMLS H10, H7, V11.H[0x2]
    UMLSL2 V25.2D, V14.4S, V19.S[0x2]
    UMULL  V19.4S, V31.4H, V25.4H
    SHA1C  Q1, S19, V9.4S
    SSHR  V19.16B, V10.16B, #3
    USHLL V28.4S, V19.4H, #0xf
    SQDMLSL D7, S18, V21.S[0x1]
    SHA256H2  Q14, Q1, V28.4S
    REV32  V5.8H, V7.8H
    FMINNM  V31.4S, V5.4S, V14.4S
    UMAXV  H24, V28.4H
    USHLL2 V19.4S, V7.8H, #0xa
    FCVTAS  V29.8H, V6.8H
    UMLSL2 V20.2D, V3.4S, V11.S[0x0]
    UQRSHRN V9.2S, V2.2D, #15
    SRI  V2.2S, V31.2S, #2
    MOV  W3, V21.S[0x3]
    URSHR  V21.16B, V26.16B, #4
    PMUL  V26.16B, V20.16B, V29.16B
    FNEG  V3.4S, V8.4S
    FADDP  V31.8H, V31.8H, V18.8H
    RSHRN2 V20.16B, V2.8H, #3
    FMAXNMP  V8.2D, V6.2D, V10.2D
    MVNI  V18.8H, #0xe4, LSL #8
    FMULX D25, D24, V18.D[0x0]
    FMLA V11.2S, V9.2S, V8.S[0x0]
    FRINTI  V18.2D, V11.2D
    MOV V29.D[0x0], V20.D[0x1]
    XTN2  V2.16B, V29.8H
    SQDMLSL D28, S25, V18.S[0x0]
    FCVTPU  V7.8H, V19.8H
    FCMGE  V24.4S, V2.4S, #0.0
    SSUBW  V10.8H, V31.8H, V31.8B
    FMULX  V31.8H, V10.8H, V10.8H
    UHSUB  V19.4S, V28.4S, V3.4S
    UMINV  B3, V26.8B
    SQDMLAL2  V6.2D, V3.4S, V31.4S
    FRSQRTS  V25.4H, V21.4H, V24.4H
    UQSHL  V2.4H, V6.4H, V7.4H
    FMAX  V29.4H, V2.4H, V2.4H
    FMLS  V10.4H, V29.4H, V25.4H
    FNEG  V20.4H, V10.4H
    SSHR  V8.8B, V20.8B, #7
    BIC  V29.16B, V19.16B, V5.16B
    SMAXP  V2.8H, V29.8H, V8.8H
    SADDL  V9.4S, V3.4H, V25.4H
    MVNI  V19.4H, #0x4, LSL #8
    FCVTAS  V6.8H, V20.8H
    FMIN  V11.4H, V17.4H, V5.4H
    SQDMULL D18, S5, V18.S[0x3]
    MOVI  V5.2S, #0x14, LSL #8
    SMLSL2 V20.4S, V18.8H, V12.H[0x6]
    MOV V3.B[0x7], W9
    FCMGT  V28.8H, V22.8H, #0.0
    FCVTMU  V21.2D, V11.2D
    SQRSHRUN2 V7.16B, V5.8H, #2
    FMULX  V11.2D, V7.2D, V12.2D
    FCVTMS  V24.2D, V20.2D
    FRSQRTE  V17.8H, V6.8H
    SMLSL V7.4S, V21.4H, V3.H[0x6]
    URSHR  V5.4H, V24.4H, #10
    SQDMULH H29, H17, V5.H[0x0]
    SQRDMULH S18, S28, V2.S[0x3]
    CNT  V28.16B, V18.16B
    FMINNMP H24, V11.2H
    SMLSL2 V8.2D, V7.4S, V19.S[0x1]
    RSUBHN2  V18.16B, V9.8H, V8.8H
    SUBHN2  V11.4S, V18.2D, V29.2D
    FMUL V6.2D, V11.2D, V24.D[0x1]
    FCVTZU V22.2D, V6.2D, #42
    SHRN2 V9.4S, V22.2D, #24
    SSHR  V19.4S, V28.4S, #1
    FCVTL  V12.4S, V9.4H
    SXTL V7.2D, V12.2S
    SABAL  V25.4S, V7.4H, V19.4H
    SRSRA  V19.4H, V9.4H, #8
    MOV V7.S[0x0], W24
    SQRSHRUN V2.4H, V12.4S, #3
    UMOV W15, V21.S[0x2]
    SMAX  V11.16B, V24.16B, V13.16B
    EXT  V6.8B, V2.8B, V8.8B, #0x7
    RSHRN V5.8B, V17.8H, #7
    MOVI  V13.8H, #0xba, LSL #8
    FMINNM  V12.8H, V25.8H, V20.8H
    SLI  V17.8H, V8.8H, #0x4
    SSRA  V3.4H, V30.4H, #16
    FCMGE  V21.2D, V17.2D, #0.0
    USHLL V24.8H, V6.8B, #0x3
    UMLAL2  V2.4S, V12.8H, V19.8H
    FMUL V25.4S, V2.4S, V21.S[0x1]
    FCVTZU  V19.4H, V7.4H
    RBIT  V12.8B, V24.8B
    UHADD  V20.16B, V11.16B, V13.16B
    SQRSHRN2 V8.8H, V23.4S, #1
    UMINV  S9, V8.4S
    CMHS  V11.8B, V20.8B, V25.8B
    FMINP S24, V3.2S
    SQSHL  V6.2S, V11.2S, #0x14
    UZP1  V2.2S, V24.2S, V19.2S
    ZIP1  V19.8H, V6.8H, V9.8H
    DUP V30.2D, V19.D[0x0]
    FMUL D6, D30, V2.D[0x1]
    FMLS V13.4S, V6.4S, V6.S[0x0]
    BIC  V25.4H, #0x69, LSL #8
    DUP V8.2D, X16
    ADDV  B20, V8.8B
    FMAXNMP H19, V13.2H
    UQSHL V2.2D, V12.2D, #0x2b
    SQDMULH  V24.4H, V19.4H, V25.4H
    RSHRN2 V13.16B, V20.8H, #2
    USUBW2  V7.2D, V2.2D, V13.4S
    FMAXNMP D20, V24.2D
    UMULL V2.4S, V7.4H, V7.H[0x0]
    MLS  V8.2S, V20.2S, V20.S[0x0]
    SQSHL  V30.2S, V8.2S, #0x13
    SMAXV  B19, V30.16B
    FCVTN2  V17.8H, V19.4S
    UADDW  V11.8H, V19.8H, V2.8B
    FADD  V13.4S, V11.4S, V17.4S
    UABDL  V2.4S, V10.4H, V29.4H
    FCVTZU V23.2D, V25.2D, #32
    FRINTN  V12.2S, V18.2S
    UCVTF V25.2D, V23.2D, #59
    USHR V24.2D, V26.2D, #29
    SMLAL2 V17.2D, V22.4S, V19.S[0x0]
    SHRN V30.4H, V29.4S, #9
    UQRSHRN2 V18.8H, V12.4S, #4
    FCVTAU  V7.4S, V20.4S
    UQRSHRN2 V22.8H, V18.4S, #5
    FCVTAS  V8.4H, V2.4H
    SQSHRN V20.8B, V31.8H, #3
    MOV V11.S[0x3], W16
    FMULX H10, H13, V13.H[0x2]
    FMINNMP S23, V24.2S
    FCVTPS  V13.2S, V25.2S
    SXTL V19.4S, V13.4H
    INS V29.B[0x3], V22.B[0x8]
    FMAXP S26, V17.2S
    URSHL  V31.2S, V30.2S, V26.2S
    UQSHL  V24.2S, V7.2S, V20.2S
    SMLAL2 V13.4S, V20.8H, V8.H[0x0]
    MOV H8, V23.H[0x7]
    UADDLV  S2, V24.4H
    SUBHN  V18.8B, V13.8H, V3.8H
    SMLSL2  V24.4S, V18.8H, V18.8H
    FCVTPS  V23.2S, V2.2S
    USHL  V25.4H, V24.4H, V3.4H
    SADDLV  S12, V8.8H
    FADDP S20, V25.2S
    SSHLL V22.4S, V20.4H, #0x5
    SQXTN  V26.4H, V11.4S
    UQSHRN V8.8B, V31.8H, #2
    SRHADD  V8.4S, V26.4S, V23.4S
    FCVTMU  V3.2S, V12.2S
    USHLL V8.8H, V22.8B, #0x4
    SQNEG  V23.8B, V10.8B
    FCMLE  V31.8H, V23.8H, #0.0
    SHL  V18.2S, V31.2S, #0x14
    USUBW  V25.2D, V18.2D, V3.2S
    SMLAL V3.2D, V25.2S, V25.S[0x1]
    SQXTUN2  V17.16B, V29.8H
    UQSHRN2 V25.4S, V3.2D, #20
    FCMGT  V3.8H, V8.8H, #0.0
    URSHR V8.2D, V19.2D, #14
    SRSRA  V31.8B, V8.8B, #2
    SSHR  V24.2S, V17.2S, #22
    FRINTX  V10.4H, V24.4H
    CMGT  V26.2D, V25.2D, V25.2D
    FCVTZU  V24.4H, V26.4H
    UABD  V11.16B, V27.16B, V10.16B
    SMLSL  V12.8H, V11.8B, V31.8B
    SADDLP  V22.2S, V12.4H
    FMLS D12, D3, V3.D[0x1]
    FMOV  V8.8H, #-0.34375000
    SXTL V3.4S, V8.4H
    FMLA H19, H3, V3.H[0x4]
    SABAL  V17.2D, V24.2S, V22.2S
    SMIN  V20.8B, V17.8B, V12.8B
    UXTL2 V26.8H, V20.16B
    FCMGE  V3.2D, V26.2D, #0.0
    FCMGE  V25.4S, V3.4S, V3.4S
    FCVTPU  V24.2D, V25.2D
    FMLS S17, S24, V24.S[0x2]
    UMAXP  V18.4H, V19.4H, V17.4H
    FMULX V24.8H, V29.8H, V10.H[0x7]
    DUP V17.4S, W9
    UADDL2  V19.2D, V9.4S, V21.4S
    SABDL2  V10.2D, V1.4S, V26.4S
    TBX  V31.16B, { V7.16B, V8.16B, V9.16B, V10.16B }, V20.16B
    SMLAL  V12.2D, V4.2S, V24.2S
    SMOV  X12, V10.H[0x2]
    FRSQRTS  V10.4S, V17.4S, V29.4S
    SABD  V22.2S, V29.2S, V11.2S
    SMIN  V25.2S, V12.2S, V24.2S
    FMAXNMP D3, V31.2D
    FCMEQ  V8.4H, V20.4H, V23.4H
    SSUBL2  V11.8H, V14.16B, V22.16B
    UMAXV  S17, V22.4S
    MOV D27, V29.D[0x0]
    RSUBHN2  V4.16B, V25.8H, V3.8H
    ADDHN2  V23.16B, V27.8H, V19.8H
    REV32  V21.8H, V17.8H
    USRA  V24.8B, V23.8B, #2
    FRINTP  V19.4S, V29.4S
    SQSHRN V26.2S, V19.2D, #24
    UCVTF  V22.4H, V21.4H
    FRSQRTE  V9.2D, V10.2D
    FCVTPS  V17.4H, V24.4H
    USHLL2 V7.4S, V17.8H, #0x3
    SQXTUN  V10.2S, V7.2D
    SMLAL  V1.2D, V10.2S, V26.2S
    SQSHRN V23.4H, V4.4S, #13
    FCMGT  V23.2S, V18.2S, V1.2S
    SUBS  X6, X6, #0x1
    B.NE  TSRTAdvsimdVectorAllOperation_label_10
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x9f, LSL #0
    MOVK  X4, #0x800, LSL #16
    MRS  X25, FPSR
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V0.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, D0
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X25, V1.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffde, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xfffe, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X25, D1
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V2.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, D2
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V3.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, D3
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V4.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, D4
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V5.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xf8f8, LSL #0
    MOVK  X4, #0xf8f8, LSL #16
    MOVK  X4, #0xf8f8, LSL #32
    MOVK  X4, #0xf8f8, LSL #48
    FMOV  X25, D5
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V6.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, D6
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V7.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, D7
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V8.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, D8
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x9000, LSL #32
    MOVK  X4, #0x4006, LSL #48
    FMOV  X25, V9.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x9000, LSL #32
    MOVK  X4, #0x4006, LSL #48
    FMOV  X25, D9
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V10.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, D10
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x5f, LSL #0
    MOVK  X4, #0x71, LSL #16
    MOVK  X4, #0xff9c, LSL #32
    MOVK  X4, #0xffc8, LSL #48
    FMOV  X25, V11.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffb2, LSL #0
    MOVK  X4, #0x71, LSL #16
    MOVK  X4, #0x25, LSL #32
    MOVK  X4, #0x21, LSL #48
    FMOV  X25, D11
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V12.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X25, D12
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V13.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, D13
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x71b2, LSL #0
    MOVK  X4, #0x2125, LSL #16
    MOVK  X4, #0x715f, LSL #32
    MOVK  X4, #0xc89c, LSL #48
    FMOV  X25, V14.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xd69c, LSL #0
    MOVK  X4, #0xc5ab, LSL #16
    MOVK  X4, #0x5d88, LSL #32
    MOVK  X4, #0x710d, LSL #48
    FMOV  X25, D14
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V15.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, D15
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V16.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, D16
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V17.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x1, LSL #0
    FMOV  X25, D17
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V18.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x2f90, LSL #0
    MOVK  X4, #0xcfe0, LSL #32
    FMOV  X25, D18
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V19.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, D19
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V20.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xcfe0, LSL #0
    MOVK  X4, #0x9000, LSL #16
    MOVK  X4, #0xc0ff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X25, D20
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V21.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x1c0, LSL #16
    FMOV  X25, D21
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V22.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x5f00, LSL #16
    FMOV  X25, D22
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V23.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, D23
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V24.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x1f00, LSL #0
    FMOV  X25, D24
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V25.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X25, D25
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V26.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, D26
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V27.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, D27
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V28.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, D28
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V29.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, D29
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V30.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, D30
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X25, V31.D[1]
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xff00, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X25, D31
    SUB  X29, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
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
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
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
    FMOV  D0, X27
    FMOV  V0.D[1], X28
    FMOV  D1, X29
    FMOV  V1.D[1], X25
    FMOV  D2, X23
    FMOV  V2.D[1], X26
    FMOV  D3, X6
    FMOV  V3.D[1], X24
    FMOV  D4, X26
    FMOV  V4.D[1], X24
    FMOV  D5, X10
    FMOV  V5.D[1], X16
    FMOV  D6, X24
    FMOV  V6.D[1], X26
    FMOV  D7, X29
    FMOV  V7.D[1], X20
    FMOV  D8, X17
    FMOV  V8.D[1], X16
    FMOV  D9, X8
    FMOV  V9.D[1], X13
    FMOV  D10, X12
    FMOV  V10.D[1], X7
    FMOV  D11, X5
    FMOV  V11.D[1], X24
    FMOV  D12, X24
    FMOV  V12.D[1], X26
    FMOV  D13, X4
    FMOV  V13.D[1], X29
    FMOV  D14, X12
    FMOV  V14.D[1], X16
    FMOV  D15, X5
    FMOV  V15.D[1], X13
    FMOV  D16, X26
    FMOV  V16.D[1], X13
    FMOV  D17, X23
    FMOV  V17.D[1], X24
    FMOV  D18, X17
    FMOV  V18.D[1], X10
    FMOV  D19, X28
    FMOV  V19.D[1], X19
    FMOV  D20, X25
    FMOV  V20.D[1], X12
    FMOV  D21, X4
    FMOV  V21.D[1], X9
    FMOV  D22, X8
    FMOV  V22.D[1], X28
    FMOV  D23, X10
    FMOV  V23.D[1], X22
    FMOV  D24, X20
    FMOV  V24.D[1], X8
    FMOV  D25, X10
    FMOV  V25.D[1], X29
    FMOV  D26, X13
    FMOV  V26.D[1], X15
    FMOV  D27, X22
    FMOV  V27.D[1], X22
    FMOV  D28, X26
    FMOV  V28.D[1], X28
    FMOV  D29, X15
    FMOV  V29.D[1], X4
    FMOV  D30, X26
    FMOV  V30.D[1], X7
    FMOV  D31, X15
    FMOV  V31.D[1], X27
    MOVZ  X27, #0xa, LSL #0
TSRTAdvsimdVectorAllOperation_label_11:
    UMLAL V4.2D, V31.2S, V30.S[0x2]
    SQDMULL D6, S27, V24.S[0x2]
    SQSHLU  V26.4H, V6.4H, #0x9
    SSHLL V7.4S, V29.4H, #0x4
    FABS  V13.2D, V28.2D
    FADDP  V26.8H, V13.8H, V25.8H
    UCVTF V27.2D, V26.2D, #64
    UQRSHRN V17.8B, V27.8H, #6
    FMULX V17.4H, V4.4H, V4.H[0x0]
    UMIN  V22.8B, V17.8B, V7.8B
    SCVTF  V5.8H, V22.8H
    SQDMULH  V29.4S, V5.4S, V5.4S
    SCVTF  V28.8H, V29.8H, #10
    MLS  V16.8H, V28.8H, V1.H[0x4]
    FRINTZ  V28.8H, V16.8H
    FMLA V13.2S, V30.2S, V11.S[0x3]
    FMINNMV  H31, V24.4H
    SMLAL V11.2D, V3.2S, V10.S[0x2]
    TBX  V6.8B, { V5.16B, V6.16B, V7.16B }, V8.8B
    SXTL V22.8H, V25.8B
    SQDMLAL  V31.2D, V26.2S, V31.2S
    UMLAL V4.4S, V29.4H, V1.H[0x5]
    FMLS V5.2D, V31.2D, V21.D[0x0]
    FMULX H16, H26, V13.H[0x4]
    UQSHRN V21.4H, V29.4S, #5
    SMLSL V27.2D, V29.2S, V20.S[0x3]
    RADDHN2  V10.4S, V22.2D, V5.2D
    UCVTF  V22.8H, V6.8H
    SQDMLSL  V2.2D, V28.2S, V16.2S
    SHLL  V8.8H, V22.8B, #8
    SCVTF  V25.2S, V8.2S, #8
    SHA1SU0  V1.4S, V21.4S, V11.4S
    SADDLV  H21, V1.16B
    FRINTI  V13.4H, V10.4H
    SMINV  S28, V27.4S
    SMINV  B22, V28.16B
    FMUL  V20.4S, V4.4S, V13.4S
    FMAX  V30.2S, V22.2S, V20.2S
    SHA1C  Q13, S2, V21.4S
    FRSQRTS  V27.4H, V13.4H, V13.4H
    FMAX  V5.8H, V25.8H, V27.8H
    FCVTAS  V6.4S, V30.4S
    MLA  V30.16B, V5.16B, V6.16B
    DUP  V29.16B, V26.B[0x3]
    FMLA  V16.4S, V26.4S, V24.4S
    SRSHL  V13.8B, V9.8B, V14.8B
    FCVTL  V8.4S, V7.4H
    RSHRN V28.4H, V25.4S, #6
    UCVTF  V26.4H, V24.4H
    FMAXNMP  V2.4S, V11.4S, V12.4S
    SMAXV  H7, V13.4H
    URSQRTE  V11.4S, V18.4S
    USHLL2 V14.2D, V18.4S, #0x13
    SQDMLAL D10, S26, V30.S[0x1]
    RSHRN V9.2S, V16.2D, #22
    SQSHRUN V1.4H, V29.4S, #7
    MOV S22, V14.S[0x3]
    UQXTN2  V25.8H, V10.4S
    FMAXV  S29, V28.4S
    FABD  V24.4H, V9.4H, V8.4H
    UMLSL V16.2D, V11.2S, V2.S[0x0]
    FCMEQ  V12.4S, V29.4S, #0.0
    DUP  V6.8H, V12.H[0x0]
    FSUB  V30.2D, V25.2D, V24.2D
    SHA1SU1  V29.4S, V0.4S
    SRSHR  V14.16B, V6.16B, #2
    UQSHRN2 V28.4S, V29.2D, #19
    UXTL V6.4S, V16.4H
    SQRSHRUN2 V27.16B, V1.8H, #8
    USHLL V29.8H, V25.8B, #0x6
    FMLS V0.2S, V22.2S, V24.S[0x1]
    FCMEQ  V16.4S, V28.4S, V0.4S
    SRI  V22.2S, V16.2S, #30
    FACGT  V12.8H, V30.8H, V22.8H
    SLI  V2.16B, V27.16B, #0x4
    UQRSHRN2 V28.8H, V14.4S, #6
    SHA1P  Q10, S2, V28.4S
    SRHADD  V2.8H, V29.8H, V29.8H
    UMULL2 V1.2D, V2.4S, V6.S[0x2]
    FMUL S2, S7, V7.S[0x3]
    FNEG  V29.2S, V12.2S
    UQSHL V25.2D, V6.2D, #0x3c
    UMINP  V26.2S, V1.2S, V10.2S
    SQRSHL  V12.2D, V25.2D, V2.2D
    FMOV  V27.8H, #0.28125000
    FMULX  V24.2D, V12.2D, V27.2D
    SQSHRUN V14.4H, V29.4S, #9
    SMLAL  V22.4S, V14.4H, V6.4H
    FMINP S28, V24.2S
    RADDHN  V30.8B, V22.8H, V28.8H
    FRINTM  V12.4H, V30.4H
    FCMGE  V28.4H, V26.4H, #0.0
    FCVTN  V22.2S, V28.2D
    FMINNM  V7.4H, V22.4H, V5.4H
    FCVTXN  V28.2S, V7.2D
    FSUB  V25.4H, V28.4H, V28.4H
    UADDW2  V26.2D, V19.2D, V25.4S
    MOV H19, V12.H[0x6]
    TBL  V28.16B, { V22.16B, V23.16B, V24.16B }, V18.16B
    SCVTF  V29.8H, V19.8H
    MUL  V2.8H, V29.8H, V11.H[0x0]
    SADDLV  S30, V26.8H
    SADDL  V10.2D, V30.2S, V28.2S
    SQRSHRN2 V18.8H, V16.4S, #6
    DUP B6, V2.B[0xb]
    SABDL2  V5.8H, V10.16B, V18.16B
    FMLS V7.4H, V5.4H, V8.H[0x3]
    ORR  V25.4H, #0x7c
    SQDMULL2 V11.2D, V25.4S, V6.S[0x2]
    SQXTN2  V25.16B, V7.8H
    DUP H5, V25.H[0x0]
    USRA  V12.4H, V11.4H, #5
    SQSHLU  V6.16B, V5.16B, #0x2
    SSHR V25.2D, V12.2D, #4
    UXTL V8.4S, V6.4H
    FCVTMU  V12.4H, V25.4H
    FMAXNMP H7, V12.2H
    SQSHRUN V19.2S, V7.2D, #30
    FMUL S28, S19, V8.S[0x3]
    FMULX  V6.2D, V21.2D, V26.2D
    UABDL2  V2.8H, V19.16B, V7.16B
    SQSHRUN V18.4H, V20.4S, #15
    SMINV  B8, V31.8B
    SQDMULL S16, H14, V12.H[0x1]
    UCVTF  V14.2S, V24.2S
    UADDLP  V21.2S, V17.4H
    CMEQ  V17.16B, V31.16B, V15.16B
    UMAX  V31.16B, V6.16B, V17.16B
    USHLL V17.8H, V18.8B, #0x4
    SQRSHRUN2 V18.8H, V8.4S, #11
    URSRA  V25.16B, V2.16B, #7
    SQXTN2  V15.16B, V18.8H
    SQRDMULH  V12.8H, V21.8H, V25.8H
    SQNEG  V10.4H, V31.4H
    FCVTZS V20.2D, V28.2D, #39
    SADDLV  D26, V12.4S
    UMAXV  H12, V10.8H
    UADDLV  D24, V14.4S
    SHA256SU0  V6.4S, V16.4S
    TBX  V25.8B, { V13.16B, V14.16B }, V27.8B
    SRSHR  V7.16B, V15.16B, #6
    RSHRN V27.2S, V7.2D, #18
    NEG  V8.2D, V12.2D
    SQRSHRUN2 V21.8H, V27.4S, #15
    SQDMULL V15.2D, V17.2S, V31.S[0x3]
    URSHR  V17.8B, V21.8B, #6
    FMAX  V31.4H, V20.4H, V25.4H
    FCVTZU  V10.8H, V8.8H
    SSRA  V20.16B, V6.16B, #3
    RSHRN V6.4H, V20.4S, #12
    MLA  V25.4H, V26.4H, V15.H[0x4]
    SSHLL V15.2D, V2.2S, #0xd
    SRHADD  V13.16B, V17.16B, V17.16B
    SQDMLAL2  V8.2D, V24.4S, V6.4S
    UQRSHRN V16.4H, V31.4S, #6
    SSHR  V18.4S, V10.4S, #28
    MUL  V12.8H, V27.8H, V15.H[0x7]
    ADDP  D24, V18.2D
    SMULL2 V7.4S, V24.8H, V2.H[0x2]
    SCVTF  V31.2S, V25.2S, #15
    TBX  V10.8B, { V10.16B, V11.16B, V12.16B, V13.16B }, V31.8B
    SQRSHRUN V21.8B, V10.8H, #1
    SUBHN2  V20.4S, V16.2D, V16.2D
    SQDMLSL D25, S8, V20.S[0x2]
    FCVTNS  V20.8H, V25.8H
    INS V14.B[0xd], V20.B[0xb]
    INS V31.B[0x0], V14.B[0x0]
    UQXTN2  V14.16B, V31.8H
    FMLA  V6.4H, V7.4H, V21.4H
    UCVTF  V18.8H, V14.8H, #9
    MLS  V17.8H, V7.8H, V6.H[0x2]
    SRI  V11.8B, V18.8B, #7
    SADDW  V15.8H, V9.8H, V17.8B
    SQRSHRN V26.2S, V11.2D, #5
    FCVTAS  V20.2S, V26.2S
    FCVTMU  V24.4H, V20.4H
    XTN  V10.8B, V15.8H
    SQDMULH  V8.8H, V10.8H, V24.8H
    UMAXV  B18, V10.16B
    FMAX  V12.2S, V28.2S, V15.2S
    FMULX H26, H8, V10.H[0x0]
    UQXTN2  V11.16B, V13.8H
    SMLSL2  V2.8H, V10.16B, V21.16B
    SHA1M  Q31, S1, V13.4S
    EXT  V24.16B, V25.16B, V10.16B, #0x0
    DUP V10.2D, V4.D[0x0]
    USHR V16.2D, V10.2D, #49
    SQDMLSL2  V1.2D, V20.4S, V10.4S
    FMLA H20, H18, V12.H[0x0]
    FCMGT  V13.2D, V31.2D, V26.2D
    ADDP  D21, V13.2D
    MLA  V15.16B, V1.16B, V20.16B
    SQRSHRUN2 V4.4S, V16.2D, #17
    FCVTZU  V8.2S, V4.2S
    SMLAL  V26.8H, V24.8B, V2.8B
    CMEQ  V7.4H, V15.4H, V15.4H
    SUBHN2  V4.16B, V8.8H, V21.8H
    SMLSL2 V28.2D, V11.4S, V11.S[0x1]
    SHA256SU1  V13.4S, V26.4S, V25.4S
    FCVTZU  V12.4H, V7.4H, #12
    FABD  V15.8H, V28.8H, V4.8H
    FACGT  V7.2D, V13.2D, V24.2D
    DUP S10, V12.S[0x1]
    FCVTXN2  V18.4S, V10.2D
    UMAX  V20.4H, V18.4H, V15.4H
    FMINNMP S24, V20.2S
    USHR  V18.8H, V7.8H, #6
    SLI  V15.2S, V24.2S, #0x18
    UCVTF  V31.4H, V15.4H
    SXTL V4.4S, V31.4H
    UMLSL2 V21.2D, V4.4S, V4.S[0x1]
    UXTL2 V24.2D, V12.4S
    UXTL V2.4S, V24.4H
    INS V20.H[0x5], W10
    FMAXNMP  V10.4H, V21.4H, V15.4H
    SRSHR  V31.4S, V23.4S, #22
    SMULL2 V21.4S, V2.8H, V2.H[0x3]
    ADDV  B26, V10.8B
    UQSHRN V23.2S, V18.2D, #23
    SQSHL  V25.8H, V31.8H, #0x3
    SSRA  V12.2S, V23.2S, #6
    FRINTP  V18.8H, V12.8H
    FCVTMU  V8.2S, V20.2S
    SUQADD  V24.2S, V8.2S
    ADDV  S11, V18.4S
    SQSHLU  V4.8H, V21.8H, #0x2
    FMULX  V7.2D, V26.2D, V4.2D
    FMLS V20.4S, V7.4S, V7.S[0x2]
    SHA1SU1  V13.4S, V25.4S
    MUL  V12.8H, V24.8H, V13.8H
    UABDL2  V13.2D, V11.4S, V7.4S
    FMUL D1, D13, V28.D[0x0]
    CNT  V31.16B, V1.16B
    SQSHRUN2 V4.4S, V12.2D, #25
    SQRSHRN2 V24.4S, V4.2D, #24
    FCVTPU  V2.2S, V24.2S
    USHR  V12.2S, V31.2S, #5
    UMULL2 V15.2D, V12.4S, V20.S[0x0]
    FMULX  V18.8H, V15.8H, V15.8H
    UABAL2  V31.8H, V2.16B, V2.16B
    SQDMULL D25, S18, V18.S[0x3]
    EXT  V1.8B, V31.8B, V31.8B, #0x0
    ZIP2  V4.4S, V25.4S, V25.4S
    SSUBW2  V13.2D, V4.2D, V4.4S
    SQDMULH H10, H13, V13.H[0x4]
    UABD  V12.4H, V10.4H, V10.4H
    RSHRN2 V26.8H, V1.4S, #7
    SMLAL  V8.8H, V26.8B, V26.8B
    FMOV  V24.4H, #-7.00000000
    UMLSL2 V28.2D, V12.4S, V12.S[0x3]
    CMTST  V31.16B, V8.16B, V8.16B
    SSUBW2  V20.4S, V31.4S, V24.8H
    URSHR  V2.4H, V28.4H, #3
    SQDMULL2 V15.2D, V20.4S, V20.S[0x2]
    SADDW2  V4.8H, V15.8H, V15.16B
    UCVTF V15.2D, V4.2D, #61
    RSHRN2 V13.4S, V2.2D, #7
    FRINTZ  V7.8H, V15.8H
    SQRSHRN V4.2S, V7.2D, #32
    FCVTMS  V31.4S, V13.4S
    FMINP  V28.8H, V4.8H, V31.8H
    SQXTN2  V26.8H, V16.4S
    FABS  V10.2S, V31.2S
    FACGT  V16.2S, V27.2S, V29.2S
    SXTL V15.4S, V19.4H
    UXTL V12.8H, V11.8B
    SHA256SU1  V18.4S, V11.4S, V11.4S
    FCVTL2  V24.4S, V8.8H
    SSUBW2  V11.2D, V25.2D, V26.4S
    SMINP  V4.4S, V4.4S, V29.4S
    UMLAL V29.4S, V28.4H, V4.H[0x7]
    FRINTZ  V2.4H, V11.4H
    FMAX  V27.4H, V10.4H, V18.4H
    MOV V20.H[0x6], W26
    CMLE  V26.8H, V20.8H, #0
    FMULX  V19.4H, V20.4H, V27.4H
    UMLAL2  V8.8H, V16.16B, V16.16B
    SMLAL2 V27.4S, V15.8H, V2.H[0x7]
    SQDMLSL  V15.4S, V12.4H, V24.4H
    CNT  V7.16B, V29.16B
    UQRSHL  V12.16B, V26.16B, V26.16B
    RSHRN2 V29.4S, V8.2D, #29
    FCVTAU  V25.4H, V26.4H
    SMAXV  H8, V19.4H
    FCMGT  V19.4H, V31.4H, #0.0
    FCVTNU  V20.8H, V25.8H
    SABDL2  V2.2D, V29.4S, V8.4S
    EXT  V13.8B, V2.8B, V31.8B, #0x3
    MOVI  V16.2S, #0x16, MSL #16
    FCMLE  V25.8H, V7.8H, #0.0
    SCVTF  V4.2D, V16.2D
    SSHLL2 V26.2D, V12.4S, #0x5
    SHA1M  Q24, S26, V10.4S
    UQSHL  V29.16B, V4.16B, #0x2
    FCVTNS  V31.8H, V29.8H
    URECPE  V8.2S, V13.2S
    SHLL  V7.8H, V8.8B, #8
    CLZ  V2.2S, V19.2S
    SQDMLAL2  V19.4S, V15.8H, V24.8H
    FCVTZS  V12.4H, V7.4H
    SUBS  X27, X27, #0x1
    B.NE  TSRTAdvsimdVectorAllOperation_label_11
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X20, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X20, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X20, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X20, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X20, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X20, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X20, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X20, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X20, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X20, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X20, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X20, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X20, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X20, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X20, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X20, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X20, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X20, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X20, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X20, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x9f, LSL #0
    MOVK  X4, #0x800, LSL #16
    MRS  X20, FPSR
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V0.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X20, D0
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V1.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x801, LSL #0
    MOVK  X4, #0x701, LSL #16
    MOVK  X4, #0x800, LSL #32
    MOVK  X4, #0x808, LSL #48
    FMOV  X20, D1
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V2.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x20, LSL #0
    MOVK  X4, #0x20, LSL #32
    FMOV  X20, D2
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X20, V3.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X20, D3
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V4.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0x16, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0x4336, LSL #48
    FMOV  X20, D4
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V5.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x807c, LSL #0
    FMOV  X20, D5
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V6.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, D6
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xff00, LSL #0
    MOVK  X4, #0xff00, LSL #16
    MOVK  X4, #0xff00, LSL #32
    MOVK  X4, #0xff00, LSL #48
    FMOV  X20, V7.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xff00, LSL #0
    MOVK  X4, #0xff00, LSL #16
    MOVK  X4, #0xff00, LSL #32
    MOVK  X4, #0xff00, LSL #48
    FMOV  X20, D7
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V8.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X20, D8
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V9.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xf400, LSL #16
    FMOV  X20, D9
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V10.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, D10
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xde65, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X20, V11.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xde65, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X20, D11
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V12.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, D12
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V13.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, D13
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xff, LSL #0
    FMOV  X20, V14.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0x4f7f, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0x4f7f, LSL #48
    FMOV  X20, D14
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V15.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, D15
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V16.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0x16, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0x16, LSL #48
    FMOV  X20, D16
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V17.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x404, LSL #0
    MOVK  X4, #0x404, LSL #32
    FMOV  X20, D17
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X20, V18.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, D18
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V19.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, D19
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V20.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, D20
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V21.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, D21
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V22.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    FMOV  X20, D22
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V23.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X20, D23
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x8000, LSL #0
    MOVK  X4, #0x8080, LSL #16
    MOVK  X4, #0x400, LSL #32
    MOVK  X4, #0x404, LSL #48
    FMOV  X20, V24.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x808, LSL #0
    MOVK  X4, #0x800, LSL #16
    MOVK  X4, #0x40, LSL #32
    MOVK  X4, #0x4040, LSL #48
    FMOV  X20, D24
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X20, V25.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X20, D25
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x1000, LSL #0
    MOVK  X4, #0x1010, LSL #16
    MOVK  X4, #0xfff0, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X20, V26.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x1000, LSL #0
    MOVK  X4, #0x1010, LSL #16
    MOVK  X4, #0xfff0, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X20, D26
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V27.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, D27
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xfffd, LSL #32
    FMOV  X20, V28.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, D28
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V29.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0x58, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffd8, LSL #48
    FMOV  X20, D29
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V30.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, D30
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V31.D[1]
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, D31
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X2, #0xb127, LSL #0
    MOVK  X2, #0x23cc, LSL #16
    MOVK  X2, #0x6595, LSL #32
    MOVK  X2, #0x21ae, LSL #48
    MOVZ  X3, #0xf0ff, LSL #0
    MOVK  X3, #0x8756, LSL #16
    MOVK  X3, #0x7d85, LSL #32
    MOVK  X3, #0x54df, LSL #48
    MOVZ  X4, #0x8b90, LSL #0
    MOVK  X4, #0xff2b, LSL #16
    MOVK  X4, #0x70a4, LSL #32
    MOVK  X4, #0x9cca, LSL #48
    MOVZ  X5, #0x4351, LSL #0
    MOVK  X5, #0xb35, LSL #16
    MOVK  X5, #0xffe4, LSL #32
    MOVK  X5, #0xabae, LSL #48
    MOVZ  X6, #0x81dd, LSL #0
    MOVK  X6, #0x22c7, LSL #16
    MOVK  X6, #0xd67c, LSL #32
    MOVK  X6, #0x26ca, LSL #48
    MOVZ  X7, #0xd63f, LSL #0
    MOVK  X7, #0x40a1, LSL #16
    MOVK  X7, #0xe81e, LSL #32
    MOVK  X7, #0x253e, LSL #48
    MOVZ  X8, #0xa9ab, LSL #0
    MOVK  X8, #0xebba, LSL #16
    MOVK  X8, #0x1f89, LSL #32
    MOVK  X8, #0x4064, LSL #48
    MOVZ  X9, #0x5cfe, LSL #0
    MOVK  X9, #0x2ca0, LSL #16
    MOVK  X9, #0xa8fd, LSL #32
    MOVK  X9, #0xfdc5, LSL #48
    MOVZ  X10, #0x6ea8, LSL #0
    MOVK  X10, #0xfbac, LSL #16
    MOVK  X10, #0xb356, LSL #32
    MOVK  X10, #0x64d3, LSL #48
    MOVZ  X12, #0x8aa8, LSL #0
    MOVK  X12, #0x190b, LSL #16
    MOVK  X12, #0xddbe, LSL #32
    MOVK  X12, #0xec74, LSL #48
    MOVZ  X13, #0x3713, LSL #0
    MOVK  X13, #0x614f, LSL #16
    MOVK  X13, #0x2aa9, LSL #32
    MOVK  X13, #0x2056, LSL #48
    MOVZ  X15, #0x2589, LSL #0
    MOVK  X15, #0xabe9, LSL #16
    MOVK  X15, #0x4934, LSL #32
    MOVK  X15, #0x3c5a, LSL #48
    MOVZ  X16, #0x348d, LSL #0
    MOVK  X16, #0x923c, LSL #16
    MOVK  X16, #0x1f7f, LSL #32
    MOVK  X16, #0xaca, LSL #48
    MOVZ  X17, #0x657d, LSL #0
    MOVK  X17, #0x73cf, LSL #16
    MOVK  X17, #0xdb3a, LSL #32
    MOVK  X17, #0xdd01, LSL #48
    MOVZ  X19, #0x2909, LSL #0
    MOVK  X19, #0xd5d5, LSL #16
    MOVK  X19, #0x8538, LSL #32
    MOVK  X19, #0x14f5, LSL #48
    MOVZ  X20, #0x3ed0, LSL #0
    MOVK  X20, #0x7262, LSL #16
    MOVK  X20, #0xecd1, LSL #32
    MOVK  X20, #0xdea3, LSL #48
    MOVZ  X22, #0x81e4, LSL #0
    MOVK  X22, #0x28ce, LSL #16
    MOVK  X22, #0x3e0f, LSL #32
    MOVK  X22, #0xaae5, LSL #48
    MOVZ  X23, #0x3f19, LSL #0
    MOVK  X23, #0xad64, LSL #16
    MOVK  X23, #0xae46, LSL #32
    MOVK  X23, #0x7fd1, LSL #48
    MOVZ  X24, #0xd793, LSL #0
    MOVK  X24, #0x97f, LSL #16
    MOVK  X24, #0x8605, LSL #32
    MOVK  X24, #0x2c35, LSL #48
    MOVZ  X25, #0xdd99, LSL #0
    MOVK  X25, #0xdf2b, LSL #16
    MOVK  X25, #0x3d5a, LSL #32
    MOVK  X25, #0xb6a2, LSL #48
    MOVZ  X26, #0xd8af, LSL #0
    MOVK  X26, #0x2463, LSL #16
    MOVK  X26, #0x70eb, LSL #32
    MOVK  X26, #0x7cbe, LSL #48
    MOVZ  X27, #0x4a1f, LSL #0
    MOVK  X27, #0xd24b, LSL #16
    MOVK  X27, #0x4585, LSL #32
    MOVK  X27, #0x50c9, LSL #48
    MOVZ  X28, #0x7a3b, LSL #0
    MOVK  X28, #0x4e23, LSL #16
    MOVK  X28, #0xb7b2, LSL #32
    MOVK  X28, #0x102, LSL #48
    MOVZ  X29, #0x214a, LSL #0
    MOVK  X29, #0xd2bc, LSL #16
    MOVK  X29, #0x17bc, LSL #32
    MOVK  X29, #0x8f13, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X25
    FMOV  D1, X28
    FMOV  V1.D[1], X29
    FMOV  D2, X26
    FMOV  V2.D[1], X7
    FMOV  D3, X24
    FMOV  V3.D[1], X5
    FMOV  D4, X24
    FMOV  V4.D[1], X16
    FMOV  D5, X16
    FMOV  V5.D[1], X9
    FMOV  D6, X9
    FMOV  V6.D[1], X4
    FMOV  D7, X13
    FMOV  V7.D[1], X19
    FMOV  D8, X2
    FMOV  V8.D[1], X10
    FMOV  D9, X8
    FMOV  V9.D[1], X22
    FMOV  D10, X29
    FMOV  V10.D[1], X3
    FMOV  D11, X29
    FMOV  V11.D[1], X28
    FMOV  D12, X26
    FMOV  V12.D[1], X23
    FMOV  D13, X28
    FMOV  V13.D[1], X9
    FMOV  D14, X3
    FMOV  V14.D[1], X9
    FMOV  D15, X26
    FMOV  V15.D[1], X4
    FMOV  D16, X9
    FMOV  V16.D[1], X5
    FMOV  D17, X23
    FMOV  V17.D[1], X4
    FMOV  D18, X15
    FMOV  V18.D[1], X10
    FMOV  D19, X8
    FMOV  V19.D[1], X4
    FMOV  D20, X15
    FMOV  V20.D[1], X19
    FMOV  D21, X29
    FMOV  V21.D[1], X2
    FMOV  D22, X13
    FMOV  V22.D[1], X26
    FMOV  D23, X22
    FMOV  V23.D[1], X5
    FMOV  D24, X6
    FMOV  V24.D[1], X9
    FMOV  D25, X15
    FMOV  V25.D[1], X26
    FMOV  D26, X17
    FMOV  V26.D[1], X2
    FMOV  D27, X2
    FMOV  V27.D[1], X8
    FMOV  D28, X24
    FMOV  V28.D[1], X23
    FMOV  D29, X27
    FMOV  V29.D[1], X6
    FMOV  D30, X13
    FMOV  V30.D[1], X15
    FMOV  D31, X24
    FMOV  V31.D[1], X13
    MOVZ  X10, #0xa, LSL #0
TSRTAdvsimdVectorAllOperation_label_12:
    SQRSHRUN V24.4H, V27.4S, #10
    UXTL V2.2D, V26.2S
    UCVTF  V29.8H, V2.8H
    MOV V23.S[0x3], W3
    EOR  V5.8B, V24.8B, V24.8B
    FMLA  V31.8H, V30.8H, V31.8H
    SMLAL2 V4.2D, V25.4S, V5.S[0x1]
    RBIT  V1.8B, V29.8B
    UQXTN2  V11.4S, V23.2D
    FMINP S14, V1.2S
    SQSHRUN V9.4H, V31.4S, #8
    FMINNMP  V21.4H, V9.4H, V4.4H
    UQSHL  V18.16B, V11.16B, #0x7
    SMLAL2  V8.2D, V14.4S, V18.4S
    USUBL2  V30.2D, V21.4S, V8.4S
    FADDP  V8.4S, V30.4S, V30.4S
    MLA  V18.2S, V8.2S, V8.2S
    FCMEQ  V14.2D, V18.2D, #0.0
    FMOV  V4.4S, #28.00000000
    FMAXP S18, V28.2S
    ORR  V11.8H, #0x58
    FSUB  V29.2S, V10.2S, V11.2S
    UMULL  V1.8H, V14.8B, V18.8B
    FMAXP  V9.4S, V1.4S, V1.4S
    UMLSL2 V10.4S, V4.8H, V9.H[0x6]
    SQDMULH H5, H31, V10.H[0x6]
    ORN  V9.8B, V5.8B, V29.8B
    DUP V23.4H, W10
    SSUBW  V28.4S, V9.4S, V26.4H
    SQSUB  V1.16B, V24.16B, V11.16B
    FRINTM  V24.2D, V8.2D
    FMLA V9.4H, V26.4H, V11.H[0x0]
    FRECPE  V30.8H, V29.8H
    SQSHRUN V25.4H, V30.4S, #2
    FADDP D30, V5.2D
    FMLS  V5.8H, V25.8H, V7.8H
    FRINTX  V14.4S, V14.4S
    FADDP D8, V25.2D
    FMINNM  V18.4S, V23.4S, V5.4S
    FCVTZS V31.2D, V18.2D, #51
    SQDMULL2 V11.4S, V28.8H, V4.H[0x7]
    SHADD  V25.2S, V9.2S, V11.2S
    SHSUB  V23.8B, V14.8B, V1.8B
    SMAXV  H26, V30.8H
    INS V29.H[0x4], V23.H[0x5]
    SQDMULH H10, H24, V8.H[0x2]
    FCVTNU  V23.4S, V10.4S
    SMULL  V7.4S, V31.4H, V31.4H
    SRSRA  V18.8B, V7.8B, #7
    USUBW2  V31.8H, V25.8H, V25.16B
    SSHLL2 V5.8H, V31.16B, #0x4
    SXTL V30.2D, V23.2S
    UMLAL  V23.2D, V26.2S, V30.2S
    FMOV  V11.2D, #-3.12500000
    SADDLV  D8, V18.4S
    SQNEG  V18.2D, V29.2D
    FRINTN  V7.4H, V12.4H
    FADDP D24, V5.2D
    USRA V5.2D, V7.2D, #22
    UADDL  V12.4S, V5.4H, V11.4H
    TBL  V11.16B, { V19.16B, V20.16B, V21.16B }, V18.16B
    UQSHRN V26.4H, V24.4S, #5
    SUQADD  V18.16B, V20.16B
    SSRA  V5.4S, V8.4S, #7
    BIT  V29.8B, V12.8B, V23.8B
    FCMGE  V30.2S, V5.2S, V29.2S
    SQDMULL D12, S11, V11.S[0x1]
    FSUB  V31.4H, V12.4H, V12.4H
    SMULL2  V10.2D, V26.4S, V31.4S
    SQDMLAL2 V7.4S, V18.8H, V7.H[0x4]
    UQRSHL  V8.2S, V30.2S, V7.2S
    UABA  V21.8B, V8.8B, V8.8B
    FCVTZS  V1.4S, V10.4S, #30
    FCVTN  V19.2S, V1.2D
    SABDL2  V1.8H, V19.16B, V21.16B
    USHR V31.2D, V12.2D, #3
    SQRSHRN V12.4H, V25.4S, #13
    UABD  V25.4H, V12.4H, V1.4H
    SHRN V24.2S, V19.2D, #23
    MLA  V23.2S, V21.2S, V24.S[0x2]
    UADDL  V20.8H, V10.8B, V27.8B
    SMLAL2 V21.2D, V11.4S, V24.S[0x0]
    AESIMC  V29.16B, V28.16B
    FRINTZ  V18.4S, V21.4S
    FMULX  V5.4S, V30.4S, V20.4S
    SSHLL2 V30.8H, V22.16B, #0x1
    FCVTZS  V12.4S, V28.4S
    USRA  V20.8B, V19.8B, #4
    EXT  V8.16B, V31.16B, V18.16B, #0x4
    FRINTA  V24.4H, V5.4H
    UQRSHRN2 V5.16B, V12.8H, #4
    SQSHRUN2 V21.8H, V8.4S, #2
    SHA1M  Q10, S7, V24.4S
    UMAXV  S11, V30.4S
    SRI  V12.16B, V11.16B, #5
    SQSHRUN V24.4H, V4.4S, #3
    UADDLP  V7.1D, V10.2S
    FCMLT  V19.2D, V5.2D, #0.0
    SQDMLAL D5, S25, V23.S[0x2]
    USHR  V30.16B, V19.16B, #1
    MLS  V28.8B, V29.8B, V30.8B
    FCMGT  V22.4H, V7.4H, #0.0
    UABAL  V10.4S, V12.4H, V24.4H
    FCVTNS  V27.8H, V20.8H
    MUL  V4.2S, V27.2S, V21.S[0x1]
    SSUBW2  V31.2D, V10.2D, V4.4S
    SQDMLSL2  V8.2D, V22.4S, V5.4S
    SQRSHRUN V19.8B, V28.8H, #7
    FRINTI  V10.2S, V19.2S
    SQRSHRN2 V20.16B, V10.8H, #6
    UABDL2  V10.8H, V20.16B, V20.16B
    SQSUB  V11.4H, V31.4H, V10.4H
    SHLL2  V25.4S, V8.8H, #16
    CMLE  V19.8H, V25.8H, #0
    FCMGT  V22.2S, V19.2S, V11.2S
    SSRA  V24.4S, V10.4S, #4
    MVNI  V8.4S, #0x4d, MSL #16
    ORR  V25.4H, #0x1d
    UCVTF V4.2D, V18.2D, #15
    SQRDMULH H31, H11, V1.H[0x7]
    UABAL2  V19.8H, V8.16B, V2.16B
    SMLSL2 V5.2D, V29.4S, V10.S[0x1]
    CMEQ  V18.8H, V20.8H, V20.8H
    FMINNM  V21.4S, V20.4S, V23.4S
    SQRDMULH S20, S21, V22.S[0x1]
    FCMLE  V10.4H, V24.4H, #0.0
    FADDP D24, V25.2D
    SSUBL  V27.4S, V5.4H, V5.4H
    CMLE  V25.2D, V4.2D, #0
    UQXTN2  V4.16B, V10.8H
    FCMGE  V22.2S, V4.2S, V31.2S
    SUQADD  V4.4H, V11.4H
    UABAL2  V28.2D, V27.4S, V18.4S
    USRA V11.2D, V28.2D, #44
    FCMEQ  V18.2D, V11.2D, #0.0
    MOV V28.B[0x1], V4.B[0xb]
    TBX  V27.16B, { V25.16B, V26.16B, V27.16B, V28.16B }, V25.16B
    SHRN2 V5.16B, V24.8H, #8
    MVN  V3.16B, V19.16B
    FMAXP D21, V5.2D
    FCVTMS  V24.2S, V18.2S
    FCVTNS  V28.2D, V20.2D
    USHR  V23.2S, V22.2S, #6
    FMLA D5, D3, V27.D[0x0]
    CMLT  V10.2D, V5.2D, #0
    SQSHRUN V4.2S, V21.2D, #31
    UQADD  V29.8B, V4.8B, V4.8B
    FMLS D22, D24, V28.D[0x1]
    SQSHRUN2 V18.16B, V22.8H, #8
    FMAXNMP H27, V10.2H
    MOV V5.S[0x0], W25
    UMAXV  B19, V5.8B
    FCVTXN2  V20.4S, V19.2D
    FACGT  V3.4S, V27.4S, V27.4S
    USUBL2  V21.4S, V20.8H, V20.8H
    RSHRN2 V26.8H, V23.4S, #5
    SHADD  V31.8H, V18.8H, V18.8H
    SUBHN2  V5.16B, V3.8H, V29.8H
    SQDMULH  V4.8H, V10.8H, V15.H[0x3]
    SRHADD  V15.8B, V4.8B, V21.8B
    SSUBL  V27.2D, V26.2S, V15.2S
    SMOV  X6, V27.H[0x2]
    SQSHRN V27.4H, V31.4S, #5
    FMAXP S22, V27.2S
    FMINNMP H20, V5.2H
    SSRA  V5.8H, V20.8H, #5
    FCMGE  V18.8H, V5.8H, #0.0
    MOVI  V31.16B, #0xcb
    SUB  V24.2D, V22.2D, V30.2D
    UMLAL2 V30.2D, V31.4S, V18.S[0x3]
    FCMGE  V4.2S, V30.2S, #0.0
    SMULL V28.4S, V24.4H, V4.H[0x2]
    SQDMLSL V19.2D, V6.2S, V3.S[0x1]
    SRSHR  V21.4S, V13.4S, #2
    ADDP  V20.8H, V6.8H, V5.8H
    SMOV  X28, V28.S[0x2]
    SRSHL  V23.2D, V27.2D, V27.2D
    UQSUB  V15.2S, V7.2S, V8.2S
    CMGT  V24.4H, V0.4H, V12.4H
    FACGT  V22.4H, V22.4H, V6.4H
    SMOV  X27, V16.B[0x0]
    MOV V26.S[0x1], W17
    SQXTUN  V5.2S, V5.2D
    CMGT  V7.16B, V23.16B, #0
    SSHLL V30.4S, V20.4H, #0xa
    CMGE  V29.4H, V30.4H, #0
    SQDMLSL2 V8.2D, V15.4S, V29.S[0x0]
    FMINP  V27.4H, V21.4H, V26.4H
    FCVTZU  V31.8H, V8.8H
    USHR V3.2D, V19.2D, #19
    FMOV  V6.8H, #0.26562500
    FCVTAS  V21.8H, V3.8H
    SRSHR V15.2D, V21.2D, #5
    SADDL  V28.4S, V31.4H, V16.4H
    SADDLV  H23, V15.16B
    SQADD  V20.8H, V6.8H, V7.8H
    FMAXNMV  S19, V20.4S
    UQRSHRN V12.8B, V23.8H, #1
    SQRSHRN V20.8B, V28.8H, #8
    MVNI  V30.4H, #0x82, LSL #8
    ZIP2  V3.4S, V12.4S, V27.4S
    FRSQRTE  V12.2S, V5.2S
    TBX  V27.8B, { V1.16B, V2.16B, V3.16B }, V30.8B
    FMLS V23.4H, V20.4H, V12.H[0x0]
    FMULX V1.2S, V23.2S, V19.S[0x1]
    EOR  V28.16B, V27.16B, V27.16B
    FCVTN  V7.2S, V1.2D
    SHA256SU1  V5.4S, V7.4S, V24.4S
    MOVI  V20.8B, #0x42
    SQSHRUN2 V7.8H, V20.4S, #4
    SQDMULL S2, H28, V5.H[0x3]
    FMAXNM  V28.2S, V9.2S, V7.2S
    UXTL2 V7.2D, V2.4S
    FMINP  V6.4S, V7.4S, V28.4S
    SQSHRUN V3.4H, V13.4S, #8
    SUBHN2  V13.8H, V27.4S, V26.4S
    UADDL  V19.4S, V1.4H, V18.4H
    SQSHRUN V1.4H, V22.4S, #16
    SQDMULH  V2.8H, V26.8H, V6.H[0x1]
    UADDL2  V7.8H, V17.16B, V0.16B
    FRINTN  V22.4S, V16.4S
    USHR V6.2D, V23.2D, #36
    FCVTMS  V17.4H, V16.4H
    UQRSHRN2 V5.4S, V17.2D, #22
    UXTL V24.4S, V19.4H
    FRECPE  V28.4H, V3.4H
    UXTL2 V19.2D, V28.4S
    SSHL  V26.16B, V13.16B, V6.16B
    FCMLT  V13.8H, V5.8H, #0.0
    FCMGT  V20.8H, V24.8H, V19.8H
    FCMEQ  V17.8H, V7.8H, #0.0
    SHRN V24.4H, V20.4S, #8
    SHL  V19.8B, V26.8B, #0x7
    FMAX  V7.8H, V13.8H, V13.8H
    FCMGE  V26.2D, V17.2D, #0.0
    SQABS  V18.4S, V24.4S
    SLI V24.2D, V7.2D, #0x2
    SQRSHRN2 V17.4S, V2.2D, #29
    FADDP  V20.8H, V19.8H, V1.8H
    SQDMULH H9, H22, V13.H[0x3]
    FMAXNMV  S2, V11.4S
    USQADD  V27.8B, V26.8B
    SSRA  V13.8H, V9.8H, #6
    SQRSHRN2 V5.8H, V28.4S, #10
    FCMGE  V26.4S, V18.4S, #0.0
    NEG  V7.4S, V20.4S
    ORR  V6.8B, V26.8B, V24.8B
    USHLL2 V18.4S, V13.8H, #0xd
    CMEQ  V22.2D, V5.2D, V17.2D
    SRSHR  V9.8H, V6.8H, #6
    USHLL V28.2D, V27.2S, #0x11
    SHLL  V6.2D, V18.2S, #32
    UMULL V11.4S, V22.4H, V6.H[0x7]
    USUBL2  V20.4S, V11.8H, V11.8H
    FMAXNMP H19, V24.2H
    SHA1P  Q3, S2, V19.4S
    FCMGT  V26.2D, V9.2D, V3.2D
    FCVTZS  V1.4H, V20.4H, #11
    TBX  V5.16B, { V27.16B, V28.16B, V29.16B }, V28.16B
    MOV V13.H[0x6], W29
    FCMEQ  V17.4H, V7.4H, #0.0
    SRHADD  V9.4S, V17.4S, V26.4S
    UMLSL  V27.4S, V13.4H, V5.4H
    UQSHRN2 V5.4S, V9.2D, #31
    FCVTZS  V28.8H, V27.8H
    FSUB  V6.2S, V1.2S, V28.2S
    FCVTPU  V2.8H, V5.8H
    UADDW2  V1.4S, V6.4S, V2.8H
    UQRSHRN V0.8B, V17.8H, #3
    SXTL2 V29.2D, V9.4S
    SSUBW  V5.2D, V25.2D, V8.2S
    RSHRN V30.2S, V29.2D, #2
    SHA256H2  Q26, Q28, V14.4S
    UMINV  H11, V6.4H
    SRSRA V2.2D, V23.2D, #23
    UABAL2  V28.2D, V19.4S, V25.4S
    FNEG  V17.2D, V17.2D
    SMLSL V24.4S, V0.4H, V1.H[0x0]
    TBX  V19.8B, { V26.16B, V27.16B }, V17.8B
    XTN2  V6.4S, V28.2D
    SSHR  V9.16B, V8.16B, #3
    UABAL2  V25.2D, V9.4S, V6.4S
    SCVTF  V26.8H, V5.8H
    FMLA V27.8H, V30.8H, V1.H[0x0]
    URSRA  V1.8H, V26.8H, #10
    FMINP D26, V24.2D
    FMLA V5.2S, V25.2S, V27.S[0x2]
    FDIV  V7.4H, V26.4H, V5.4H
    MOVI  V30.2D, #18446744069431296000
    SQSHRUN V23.8B, V16.8H, #3
    FCMGE  V14.4S, V23.4S, V19.4S
    SHRN2 V5.8H, V14.4S, #4
    USHLL2 V27.2D, V1.4S, #0x6
    UMULL V8.4S, V2.4H, V11.H[0x4]
    SQDMLAL V6.2D, V7.2S, V7.S[0x3]
    SMOV  X7, V5.H[0x3]
    FCVTL2  V28.4S, V27.8H
    UMULL V16.4S, V16.4H, V8.H[0x1]
    SQSHL V9.2D, V16.2D, #0x29
    ABS  V25.2D, V9.2D
    SUBS  X10, X10, #0x1
    B.NE  TSRTAdvsimdVectorAllOperation_label_12
    MOVZ  X26, #0xb127, LSL #0
    MOVK  X26, #0x23cc, LSL #16
    MOVK  X26, #0x6595, LSL #32
    MOVK  X26, #0x21ae, LSL #48
    SUB  X22, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0xf0ff, LSL #0
    MOVK  X26, #0x8756, LSL #16
    MOVK  X26, #0x7d85, LSL #32
    MOVK  X26, #0x54df, LSL #48
    SUB  X22, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x4351, LSL #0
    MOVK  X26, #0xb35, LSL #16
    MOVK  X26, #0xffe4, LSL #32
    MOVK  X26, #0xabae, LSL #48
    SUB  X22, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0xa9ab, LSL #0
    MOVK  X26, #0xebba, LSL #16
    MOVK  X26, #0x1f89, LSL #32
    MOVK  X26, #0x4064, LSL #48
    SUB  X22, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x5cfe, LSL #0
    MOVK  X26, #0x2ca0, LSL #16
    MOVK  X26, #0xa8fd, LSL #32
    MOVK  X26, #0xfdc5, LSL #48
    SUB  X22, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x8aa8, LSL #0
    MOVK  X26, #0x190b, LSL #16
    MOVK  X26, #0xddbe, LSL #32
    MOVK  X26, #0xec74, LSL #48
    SUB  X22, X26, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x3713, LSL #0
    MOVK  X26, #0x614f, LSL #16
    MOVK  X26, #0x2aa9, LSL #32
    MOVK  X26, #0x2056, LSL #48
    SUB  X22, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x2589, LSL #0
    MOVK  X26, #0xabe9, LSL #16
    MOVK  X26, #0x4934, LSL #32
    MOVK  X26, #0x3c5a, LSL #48
    SUB  X22, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x348d, LSL #0
    MOVK  X26, #0x923c, LSL #16
    MOVK  X26, #0x1f7f, LSL #32
    MOVK  X26, #0xaca, LSL #48
    SUB  X22, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x657d, LSL #0
    MOVK  X26, #0x73cf, LSL #16
    MOVK  X26, #0xdb3a, LSL #32
    MOVK  X26, #0xdd01, LSL #48
    SUB  X22, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x2909, LSL #0
    MOVK  X26, #0xd5d5, LSL #16
    MOVK  X26, #0x8538, LSL #32
    MOVK  X26, #0x14f5, LSL #48
    SUB  X22, X26, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x3ed0, LSL #0
    MOVK  X26, #0x7262, LSL #16
    MOVK  X26, #0xecd1, LSL #32
    MOVK  X26, #0xdea3, LSL #48
    SUB  X22, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x3f19, LSL #0
    MOVK  X26, #0xad64, LSL #16
    MOVK  X26, #0xae46, LSL #32
    MOVK  X26, #0x7fd1, LSL #48
    SUB  X22, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0xd793, LSL #0
    MOVK  X26, #0x97f, LSL #16
    MOVK  X26, #0x8605, LSL #32
    MOVK  X26, #0x2c35, LSL #48
    SUB  X22, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0xdd99, LSL #0
    MOVK  X26, #0xdf2b, LSL #16
    MOVK  X26, #0x3d5a, LSL #32
    MOVK  X26, #0xb6a2, LSL #48
    SUB  X22, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x214a, LSL #0
    MOVK  X26, #0xd2bc, LSL #16
    MOVK  X26, #0x17bc, LSL #32
    MOVK  X26, #0x8f13, LSL #48
    SUB  X22, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x9f, LSL #0
    MOVK  X26, #0x800, LSL #16
    MRS  X22, FPSR
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, V0.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    FMOV  X22, D0
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x2f, LSL #0
    MOVK  X26, #0x15, LSL #16
    FMOV  X22, V1.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x2f, LSL #0
    MOVK  X26, #0x8015, LSL #16
    MOVK  X26, #0x857d, LSL #48
    FMOV  X22, D1
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, V2.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x100, LSL #0
    MOVK  X26, #0x100, LSL #16
    MOVK  X26, #0xff00, LSL #32
    MOVK  X26, #0xffff, LSL #48
    FMOV  X22, D2
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0xdf8, LSL #0
    MOVK  X26, #0x8114, LSL #16
    MOVK  X26, #0x8fef, LSL #32
    MOVK  X26, #0xc408, LSL #48
    FMOV  X22, V3.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x7800, LSL #0
    MOVK  X26, #0x690, LSL #16
    MOVK  X26, #0x7bff, LSL #32
    MOVK  X26, #0x9a31, LSL #48
    FMOV  X22, D3
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, V4.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    FMOV  X22, D4
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    FMOV  X22, V5.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, D5
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    FMOV  X22, V6.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x8000, LSL #16
    MOVK  X26, #0x857d, LSL #48
    FMOV  X22, D6
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, V7.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x7e00, LSL #0
    MOVK  X26, #0x7e00, LSL #16
    MOVK  X26, #0x7e00, LSL #32
    MOVK  X26, #0x7e00, LSL #48
    FMOV  X22, D7
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, V8.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, D8
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, V9.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, D9
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, V10.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    FMOV  X22, D10
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, V11.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, D11
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, V12.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x7f80, LSL #16
    MOVK  X26, #0x7f80, LSL #48
    FMOV  X22, D12
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x214a, LSL #32
    FMOV  X22, V13.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, D13
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    FMOV  X22, V14.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    FMOV  X22, D14
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, V15.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, D15
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, V16.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, D16
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x8000, LSL #48
    FMOV  X22, V17.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0x7fff, LSL #48
    FMOV  X22, D17
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, V18.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, D18
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, V19.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, D19
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, V20.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, D20
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, V21.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, D21
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, V22.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, D22
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, V23.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, D23
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, V24.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, D24
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, V25.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, D25
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, V26.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, D26
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, V27.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0xbc0, LSL #0
    MOVK  X26, #0x540, LSL #16
    FMOV  X22, D27
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, V28.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, D28
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, V29.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, D29
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0xff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    FMOV  X22, V30.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0xff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    FMOV  X22, D30
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, V31.D[1]
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X22, D31
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
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
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X17
    FMOV  V0.D[1], X28
    FMOV  D1, X27
    FMOV  V1.D[1], X16
    FMOV  D2, X24
    FMOV  V2.D[1], X29
    FMOV  D3, X25
    FMOV  V3.D[1], X15
    FMOV  D4, X26
    FMOV  V4.D[1], X23
    FMOV  D5, X7
    FMOV  V5.D[1], X22
    FMOV  D6, X9
    FMOV  V6.D[1], X4
    FMOV  D7, X26
    FMOV  V7.D[1], X12
    FMOV  D8, X6
    FMOV  V8.D[1], X19
    FMOV  D9, X28
    FMOV  V9.D[1], X8
    FMOV  D10, X15
    FMOV  V10.D[1], X20
    FMOV  D11, X19
    FMOV  V11.D[1], X22
    FMOV  D12, X16
    FMOV  V12.D[1], X3
    FMOV  D13, X13
    FMOV  V13.D[1], X7
    FMOV  D14, X13
    FMOV  V14.D[1], X23
    FMOV  D15, X5
    FMOV  V15.D[1], X19
    FMOV  D16, X22
    FMOV  V16.D[1], X8
    FMOV  D17, X2
    FMOV  V17.D[1], X23
    FMOV  D18, X10
    FMOV  V18.D[1], X16
    FMOV  D19, X23
    FMOV  V19.D[1], X16
    FMOV  D20, X29
    FMOV  V20.D[1], X12
    FMOV  D21, X4
    FMOV  V21.D[1], X25
    FMOV  D22, X2
    FMOV  V22.D[1], X29
    FMOV  D23, X12
    FMOV  V23.D[1], X4
    FMOV  D24, X25
    FMOV  V24.D[1], X28
    FMOV  D25, X15
    FMOV  V25.D[1], X17
    FMOV  D26, X27
    FMOV  V26.D[1], X13
    FMOV  D27, X19
    FMOV  V27.D[1], X5
    FMOV  D28, X9
    FMOV  V28.D[1], X22
    FMOV  D29, X6
    FMOV  V29.D[1], X8
    FMOV  D30, X17
    FMOV  V30.D[1], X13
    FMOV  D31, X16
    FMOV  V31.D[1], X16
    MOVZ  X25, #0xa, LSL #0
TSRTAdvsimdVectorAllOperation_label_13:
    BIC  V11.16B, V24.16B, V26.16B
    SUBHN  V26.2S, V31.2D, V27.2D
    FMINNMP  V25.4H, V25.4H, V11.4H
    URSHR  V12.2S, V28.2S, #8
    UMULL  V22.8H, V12.8B, V12.8B
    SRSRA  V29.8H, V25.8H, #4
    SHA1SU1  V19.4S, V26.4S
    FRSQRTS  V15.8H, V30.8H, V29.8H
    USRA  V13.4S, V19.4S, #6
    RADDHN  V15.4H, V15.4S, V15.4S
    MOVI  V31.2D, #18374966859414962175
    UQRSHRN V28.8B, V31.8H, #3
    MLA  V2.8H, V22.8H, V12.H[0x6]
    FCVTXN2  V17.4S, V28.2D
    SXTL V23.2D, V13.2S
    SQXTN2  V23.8H, V23.4S
    FSUB  V28.4H, V15.4H, V23.4H
    SQRSHRUN V18.2S, V28.2D, #18
    URSRA  V11.8B, V2.8B, #3
    DUP V24.2D, V11.D[0x0]
    MLS  V26.2S, V17.2S, V17.S[0x0]
    SQDMULL2 V29.4S, V26.8H, V11.H[0x0]
    FMLS S22, S17, V31.S[0x3]
    UMLAL2  V28.2D, V29.4S, V24.4S
    UQSHL V13.2D, V18.2D, #0x39
    FMINP S26, V22.2S
    RSHRN2 V2.8H, V28.4S, #1
    DUP S31, V2.S[0x1]
    FMIN  V11.2S, V31.2S, V13.2S
    SLI  V23.8H, V11.8H, #0xa
    FDIV  V15.2S, V23.2S, V23.2S
    ADDP  D12, V15.2D
    UCVTF  V17.8H, V26.8H, #4
    SCVTF  V31.2S, V17.2S
    UCVTF  V2.4S, V31.4S
    TBX  V15.8B, { V8.16B, V9.16B }, V12.8B
    FMAXNMP D23, V2.2D
    SMULL V30.2D, V15.2S, V23.S[0x3]
    CMEQ  V15.4H, V14.4H, V1.4H
    FCVTZU  V11.4H, V11.4H, #2
    CMGT  V26.4S, V6.4S, #0
    TBX  V1.8B, { V24.16B, V25.16B, V26.16B, V27.16B }, V22.8B
    FNEG  V17.8H, V24.8H
    SXTL2 V22.8H, V7.16B
    FMULX  V31.2D, V15.2D, V31.2D
    SQDMLAL2 V24.4S, V18.8H, V12.H[0x2]
    FRINTZ  V25.2D, V18.2D
    FCVTZU  V13.4H, V9.4H, #16
    UQADD  V14.8B, V1.8B, V13.8B
    FCMEQ  V13.2D, V14.2D, V17.2D
    USHR V17.2D, V21.2D, #54
    SQSHRUN2 V9.8H, V11.4S, #8
    FMLA H15, H30, V14.H[0x2]
    FSQRT  V21.2D, V22.2D
    USHR  V22.4H, V31.4H, #1
    RSHRN V11.4H, V25.4S, #11
    FDIV  V30.4S, V11.4S, V13.4S
    FMUL D26, D22, V30.D[0x0]
    UQSUB  V13.16B, V24.16B, V21.16B
    SHRN2 V14.4S, V15.2D, #5
    UCVTF  V27.2S, V13.2S, #18
    UMULL2  V1.4S, V26.8H, V27.8H
    SQADD  V26.8B, V9.8B, V14.8B
    MVNI  V11.2S, #0x4c
    SHRN V27.2S, V26.2D, #15
    FCVTAS  V13.4S, V1.4S
    CMLT  V14.4H, V13.4H, #0
    SUBHN  V26.8B, V14.8H, V14.8H
    SMAX  V14.2S, V27.2S, V27.2S
    SQDMULL S25, H11, V11.H[0x6]
    USUBW  V13.2D, V26.2D, V14.2S
    USHLL V31.8H, V13.8B, #0x4
    SCVTF  V9.2S, V25.2S, #10
    UABD  V7.16B, V9.16B, V9.16B
    FRSQRTE  V9.8H, V17.8H
    UQSHL  V14.2S, V31.2S, #0x0
    SMLSL2 V21.2D, V9.4S, V7.S[0x0]
    UMOV W2, V21.B[0x8]
    BIC  V24.4S, #0xa
    UABDL  V7.4S, V23.4H, V31.4H
    SQSUB  V1.8H, V25.8H, V0.8H
    FRINTA  V26.4H, V1.4H
    UABA  V22.4H, V26.4H, V30.4H
    UQSHRN2 V26.4S, V25.2D, #18
    FMUL  V17.2S, V16.2S, V29.2S
    MVNI  V11.4S, #0x14, MSL #16
    UCVTF  V15.8H, V12.8H
    FMULX S31, S10, V22.S[0x3]
    SQSUB  V0.2D, V22.2D, V11.2D
    SQXTUN2  V23.16B, V17.8H
    FMUL  V10.4H, V22.4H, V15.4H
    BSL  V9.8B, V13.8B, V23.8B
    SMULL V12.4S, V21.4H, V1.H[0x4]
    FADDP  V21.2S, V7.2S, V24.2S
    ADDP  D17, V26.2D
    FABS  V29.2S, V21.2S
    CMHS  V25.4S, V29.4S, V12.4S
    SHLL  V11.2D, V17.2S, #32
    FMINV  H17, V11.4H
    FMAXNMV  H11, V17.4H
    SCVTF  V21.2D, V14.2D
    FMOV  V1.4H, #-0.48437500
    SXTL V16.2D, V11.2S
    FCVTAS  V12.8H, V16.8H
    SABDL2  V24.2D, V9.4S, V10.4S
    SQSUB  V11.4S, V21.4S, V25.4S
    SQDMLAL2 V26.4S, V24.8H, V1.H[0x2]
    RSUBHN  V15.4H, V26.4S, V0.4S
    SQDMLSL D7, S15, V31.S[0x1]
    MOV V31.B[0x6], W10
    REV64  V23.4S, V31.4S
    FCVTZS  V14.8H, V7.8H, #14
    ORN  V17.16B, V11.16B, V11.16B
    SHA1SU0  V11.4S, V17.4S, V18.4S
    FCVTMS  V21.4S, V12.4S
    UQSHRN V16.2S, V14.2D, #6
    SMAXP  V14.4H, V16.4H, V16.4H
    FCMGT  V25.2S, V14.2S, V14.2S
    USQADD  V1.8B, V25.8B
    UQRSHRN2 V15.4S, V23.2D, #7
    FMINV  H14, V11.8H
    URSRA  V25.4H, V14.4H, #4
    UQSHL  V29.4S, V25.4S, V15.4S
    FMAXP  V24.2D, V29.2D, V29.2D
    NEG  V12.8B, V1.8B
    ZIP2  V25.8H, V12.8H, V21.8H
    SRSRA V12.2D, V24.2D, #26
    CLZ  V26.4S, V25.4S
    SQDMLAL V0.4S, V26.4H, V12.H[0x1]
    FMAXP H21, V30.2H
    FMULX  V16.8H, V3.8H, V26.8H
    SMOV W9, V23.H[0x1]
    SHA256H2  Q24, Q16, V14.4S
    UABA  V16.8B, V18.8B, V14.8B
    SHA1SU0  V11.4S, V26.4S, V2.4S
    PMULL  V23.1Q, V17.1D, V5.1D
    FCMGE  V5.8H, V0.8H, V15.8H
    SRSRA  V29.8H, V20.8H, #12
    SMOV  X23, V18.S[0x1]
    UMULL2  V14.8H, V21.16B, V12.16B
    SRSRA  V26.16B, V7.16B, #1
    FMAXP H18, V8.2H
    FMUL H8, H11, V5.H[0x5]
    SQSHL  V2.16B, V16.16B, V18.16B
    UMULL2  V3.8H, V2.16B, V0.16B
    INS V17.B[0xe], V14.B[0x8]
    UMAXV  S7, V26.4S
    SQSHLU  V18.4H, V3.4H, #0x9
    FADDP S14, V8.2S
    BIC  V30.4H, #0x3b
    URSHR V21.2D, V7.2D, #60
    SMOV  X16, V23.B[0xb]
    FRINTI  V8.4H, V17.4H
    URHADD  V17.4H, V29.4H, V29.4H
    UQADD  V0.8B, V30.8B, V30.8B
    FCMGT  V15.4H, V18.4H, #0.0
    SQRSHRUN2 V30.4S, V8.2D, #22
    FRINTN  V25.2D, V0.2D
    SQRSHRUN2 V7.4S, V17.2D, #19
    FMULX  V12.2S, V14.2S, V14.2S
    RSUBHN  V16.4H, V25.4S, V15.4S
    FCMGT  V18.4H, V21.4H, #0.0
    FMLA  V14.2S, V12.2S, V16.2S
    SRHADD  V2.4S, V7.4S, V7.4S
    FCMGT  V8.4H, V2.4H, V30.4H
    USRA V23.2D, V8.2D, #45
    URSHR  V0.4H, V14.4H, #3
    SHSUB  V17.4S, V23.4S, V18.4S
    FRECPE  V25.4S, V0.4S
    SQSHRUN2 V15.8H, V25.4S, #2
    SQDMULH  V7.4H, V15.4H, V24.4H
    INS V15.H[0x6], W12
    REV16  V23.16B, V17.16B
    UZP2  V12.8H, V15.8H, V15.8H
    SSRA  V2.16B, V3.16B, #1
    SMULL2  V15.2D, V7.4S, V7.4S
    FDIV  V7.4H, V15.4H, V23.4H
    FMLS V29.2D, V12.2D, V15.D[0x1]
    SQDMULH S3, S2, V29.S[0x0]
    AND  V24.16B, V7.16B, V7.16B
    FCVTMU  V16.4S, V3.4S
    SADDW2  V0.2D, V16.2D, V24.4S
    UQSHRN2 V21.4S, V21.2D, #28
    UHSUB  V8.8B, V7.8B, V25.8B
    BIF  V3.16B, V20.16B, V16.16B
    UABDL  V7.2D, V3.2S, V11.2S
    FCMEQ  V18.8H, V13.8H, V28.8H
    SRSRA V13.2D, V24.2D, #63
    FMAXNM  V17.8H, V5.8H, V12.8H
    SABAL  V20.4S, V12.4H, V8.4H
    FMULX  V3.2S, V28.2S, V20.2S
    UMAXV  B5, V3.8B
    FMAXP D14, V2.2D
    FCMGE  V24.4H, V11.4H, V8.4H
    UMIN  V11.16B, V0.16B, V7.16B
    TBL  V25.8B, { V11.16B }, V5.8B
    SQDMLSL2 V16.4S, V17.8H, V14.H[0x0]
    MUL  V29.4H, V9.4H, V14.H[0x4]
    SMLSL2 V3.2D, V18.4S, V29.S[0x3]
    URSHR V2.2D, V25.2D, #32
    DUP V25.16B, W23
    MOV D11, V13.D[0x1]
    SQSHRUN2 V29.16B, V2.8H, #7
    SRSRA  V2.2S, V25.2S, #7
    FMUL V20.4H, V11.4H, V2.H[0x4]
    SQXTUN  V2.2S, V20.2D
    FACGT  V15.2D, V24.2D, V2.2D
    SQDMLSL D14, S16, V16.S[0x2]
    UMAXV  S13, V29.4S
    FCMGT  V5.4S, V3.4S, #0.0
    FMINP H25, V5.2H
    SMLAL V24.2D, V25.2S, V14.S[0x0]
    UADDLP  V7.1D, V15.2S
    SQDMULH  V3.4S, V13.4S, V13.S[0x2]
    SHL  V12.16B, V3.16B, #0x0
    UQSHRN V9.8B, V7.8H, #2
    SQSHLU  V7.8H, V24.8H, #0x6
    SMULL V24.4S, V12.4H, V9.H[0x2]
    FRSQRTE  V9.2S, V24.2S
    FDIV  V12.2S, V7.2S, V9.2S
    UHADD  V3.4H, V16.4H, V3.4H
    MLA  V13.8B, V3.8B, V23.8B
    MOV V11.B[0x5], V21.B[0xc]
    FRECPE  V5.2S, V12.2S
    UADALP  V23.1D, V24.2S
    UHADD  V20.4H, V6.4H, V18.4H
    AESIMC  V7.16B, V16.16B
    FMAX  V9.4H, V28.4H, V24.4H
    FCMEQ  V3.8H, V27.8H, V18.8H
    DUP H16, V14.H[0x4]
    FMINNMP D14, V20.2D
    SCVTF  V2.8H, V7.8H
    FRINTI  V15.8H, V13.8H
    SHRN V29.8B, V5.8H, #2
    FCVTMS  V5.2D, V11.2D
    FMAXNM  V11.4H, V5.4H, V5.4H
    FCMGE  V27.2S, V23.2S, V15.2S
    SQDMULL  V23.2D, V2.2S, V16.2S
    FMLA S5, S23, V14.S[0x2]
    FMOV  V15.4H, #-1.50000000
    FRINTX  V28.4H, V27.4H
    FMINNMP D6, V3.2D
    FMINNM  V20.8H, V9.8H, V6.8H
    BIC  V14.8B, V11.8B, V20.8B
    SRI  V2.4S, V13.4S, #11
    TBX  V9.8B, { V14.16B, V15.16B }, V28.8B
    FCVTMS  V15.8H, V9.8H
    FRINTP  V20.4S, V2.4S
    FSQRT  V9.4S, V5.4S
    MOVI  V16.8H, #0xe5, LSL #8
    ABS  V27.2S, V16.2S
    UMINP  V14.4H, V9.4H, V15.4H
    SABD  V9.2S, V14.2S, V21.2S
    SABD  V28.4S, V29.4S, V20.4S
    FACGE  V15.4H, V28.4H, V27.4H
    EXT  V28.8B, V9.8B, V9.8B, #0x5
    USHR  V11.16B, V28.16B, #8
    FMLS D16, D11, V15.D[0x1]
    MOVI  V13.4S, #0x70
    UMOV W2, V3.B[0x6]
    TBL  V14.8B, { V25.16B, V26.16B, V27.16B }, V3.8B
    FMLS  V6.4H, V19.4H, V1.4H
    FMULX S25, S5, V27.S[0x1]
    MLA  V28.4S, V24.4S, V14.S[0x0]
    SADDW2  V1.4S, V20.4S, V23.8H
    FCVTXN  V2.2S, V23.2D
    UMINV  S21, V6.4S
    FMAXNM  V11.4H, V14.4H, V7.4H
    FMINV  H20, V24.4H
    UMULL2 V26.2D, V5.4S, V20.S[0x2]
    FCVTPS  V23.2D, V18.2D
    SQSHRUN V15.8B, V1.8H, #5
    UQRSHRN V26.4H, V13.4S, #8
    SQDMLSL2 V19.4S, V26.8H, V15.H[0x5]
    FRECPS  V7.4H, V16.4H, V16.4H
    FMAX  V1.2D, V2.2D, V11.2D
    SQRDMULH S2, S7, V25.S[0x1]
    FMLS V29.4H, V23.4H, V2.H[0x4]
    MUL  V9.16B, V19.16B, V8.16B
    SQXTN  V14.4H, V1.4S
    SSRA  V3.4S, V21.4S, #32
    URSRA  V18.2S, V29.2S, #23
    FRINTZ  V16.2S, V3.2S
    DUP D26, V18.D[0x0]
    SQSHLU  V27.2S, V9.2S, #0xf
    SQRSHRUN2 V15.4S, V14.2D, #9
    UMAX  V8.2S, V28.2S, V16.2S
    SADDW  V1.2D, V8.2D, V29.2S
    FRINTX  V19.8H, V1.8H
    FMULX S20, S15, V26.S[0x2]
    UMLAL2 V11.4S, V19.8H, V10.H[0x6]
    URSHR  V26.4H, V27.4H, #11
    PMULL2  V13.8H, V20.16B, V26.16B
    UMLSL  V9.4S, V13.4H, V24.4H
    SUBHN2  V21.16B, V9.8H, V9.8H
    MLA  V19.2S, V11.2S, V11.S[0x1]
    TBL  V16.16B, { V4.16B, V5.16B, V6.16B }, V19.16B
    UXTL V3.8H, V16.8B
    FRECPS  V5.2S, V3.2S, V3.2S
    UMLAL  V13.2D, V10.2S, V5.2S
    SUBS  X25, X25, #0x1
    B.NE  TSRTAdvsimdVectorAllOperation_label_13
    MOVZ  X29, #0xff, LSL #0
    SUB  X3, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0xffc0, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X3, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x9f, LSL #0
    MOVK  X29, #0x800, LSL #16
    MRS  X3, FPSR
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V0.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, D0
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x8000, LSL #0
    MOVK  X29, #0x8000, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X3, V1.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0xe000, LSL #0
    MOVK  X29, #0xdfff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X3, D1
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V2.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, D2
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V3.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, D3
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V4.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, D4
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V5.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x4000, LSL #16
    MOVK  X29, #0x4000, LSL #48
    FMOV  X3, D5
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V6.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0xbbc2, LSL #0
    MOVK  X29, #0xbbc2, LSL #16
    MOVK  X29, #0x7fff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    FMOV  X3, D6
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V7.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0xfc00, LSL #0
    MOVK  X29, #0xfc00, LSL #16
    MOVK  X29, #0xfc00, LSL #32
    MOVK  X29, #0xfc00, LSL #48
    FMOV  X3, D7
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V8.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X3, D8
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V9.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x4000, LSL #0
    MOVK  X29, #0x40c0, LSL #16
    MOVK  X29, #0x8181, LSL #32
    MOVK  X29, #0xc031, LSL #48
    FMOV  X3, D9
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V10.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X3, D10
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V11.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, D11
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V12.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, D12
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xc000, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x3fff, LSL #48
    FMOV  X3, V13.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xc000, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x3fff, LSL #48
    FMOV  X3, D13
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V14.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, D14
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V15.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, D15
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V16.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, D16
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xffff, LSL #48
    FMOV  X3, V17.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, D17
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V18.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x1c0, LSL #0
    MOVK  X29, #0x100, LSL #32
    FMOV  X3, D18
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V19.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0xe000, LSL #0
    MOVK  X29, #0xe000, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X3, D19
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V20.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, D20
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V21.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, D21
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V22.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X3, D22
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V23.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, D23
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V24.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, D24
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V25.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, D25
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V26.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x20, LSL #0
    MOVK  X29, #0x20, LSL #16
    FMOV  X3, D26
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V27.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    FMOV  X3, D27
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V28.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, D28
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V29.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0xe000, LSL #0
    MOVK  X29, #0xe000, LSL #16
    MOVK  X29, #0x8000, LSL #32
    MOVK  X29, #0x8000, LSL #48
    FMOV  X3, D29
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V30.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0xffc4, LSL #0
    MOVK  X29, #0xffc4, LSL #16
    MOVK  X29, #0xffc4, LSL #32
    MOVK  X29, #0xffc4, LSL #48
    FMOV  X3, D30
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X3, V31.D[1]
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    FMOV  X3, D31
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorAllOperation_TestFail
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
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
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
    FMOV  V0.D[1], X25
    FMOV  D1, X26
    FMOV  V1.D[1], X27
    FMOV  D2, X29
    FMOV  V2.D[1], X23
    FMOV  D3, X2
    FMOV  V3.D[1], X19
    FMOV  D4, X20
    FMOV  V4.D[1], X16
    FMOV  D5, X16
    FMOV  V5.D[1], X10
    FMOV  D6, X16
    FMOV  V6.D[1], X8
    FMOV  D7, X4
    FMOV  V7.D[1], X26
    FMOV  D8, X29
    FMOV  V8.D[1], X3
    FMOV  D9, X10
    FMOV  V9.D[1], X2
    FMOV  D10, X5
    FMOV  V10.D[1], X28
    FMOV  D11, X5
    FMOV  V11.D[1], X13
    FMOV  D12, X2
    FMOV  V12.D[1], X6
    FMOV  D13, X13
    FMOV  V13.D[1], X8
    FMOV  D14, X28
    FMOV  V14.D[1], X19
    FMOV  D15, X7
    FMOV  V15.D[1], X5
    FMOV  D16, X3
    FMOV  V16.D[1], X12
    FMOV  D17, X28
    FMOV  V17.D[1], X9
    FMOV  D18, X20
    FMOV  V18.D[1], X2
    FMOV  D19, X8
    FMOV  V19.D[1], X2
    FMOV  D20, X7
    FMOV  V20.D[1], X5
    FMOV  D21, X5
    FMOV  V21.D[1], X4
    FMOV  D22, X6
    FMOV  V22.D[1], X3
    FMOV  D23, X27
    FMOV  V23.D[1], X19
    FMOV  D24, X9
    FMOV  V24.D[1], X3
    FMOV  D25, X24
    FMOV  V25.D[1], X23
    FMOV  D26, X17
    FMOV  V26.D[1], X23
    FMOV  D27, X9
    FMOV  V27.D[1], X4
    FMOV  D28, X13
    FMOV  V28.D[1], X2
    FMOV  D29, X19
    FMOV  V29.D[1], X28
    FMOV  D30, X13
    FMOV  V30.D[1], X17
    FMOV  D31, X16
    FMOV  V31.D[1], X24
    MOVZ  X2, #0xa, LSL #0
TSRTAdvsimdVectorAllOperation_label_14:
    PMULL2  V23.8H, V23.16B, V23.16B
    ADDV  B12, V26.16B
    FMLS H6, H12, V8.H[0x6]
    SMLAL  V0.2D, V23.2S, V25.2S
    SQDMULH  V12.4S, V24.4S, V28.S[0x2]
    SADDW  V24.2D, V29.2D, V6.2S
    SHA1M  Q23, S30, V24.4S
    FCMLT  V2.2D, V31.2D, #0.0
    FMINV  H24, V12.4H
    CMGE  V20.2S, V0.2S, #0
    SHL  V15.4H, V23.4H, #0x1
    UMAXV  B25, V15.8B
    SQXTN  V28.8B, V2.8H
    MVNI  V17.8H, #0x75
    USHLL2 V26.8H, V25.16B, #0x4
    FRINTZ  V10.2D, V27.2D
    MVNI  V29.4H, #0xd9, LSL #8
    FMOV  V27.8H, #27.00000000
    SSRA  V4.16B, V10.16B, #4
    UHADD  V15.8H, V28.8H, V26.8H
    FCMEQ  V5.2S, V8.2S, #0.0
    UMOV W24, V20.H[0x7]
    SRSRA  V20.4H, V24.4H, #8
    UCVTF V23.2D, V29.2D, #7
    SQRDMULH  V7.4S, V17.4S, V15.S[0x0]
    FACGT  V31.2S, V27.2S, V4.2S
    BIC  V2.16B, V23.16B, V7.16B
    SRI  V8.8B, V2.8B, #4
    FMLS V10.4H, V31.4H, V5.H[0x1]
    SMAXV  B2, V20.8B
    FCMGT  V20.8H, V29.8H, #0.0
    UADDW2  V7.2D, V20.2D, V20.4S
    SQDMLAL V15.4S, V2.4H, V8.H[0x1]
    UMLAL V2.4S, V10.4H, V15.H[0x4]
    UABA  V29.4S, V2.4S, V2.4S
    FRINTZ  V31.2S, V7.2S
    SMULL  V4.2D, V31.2S, V21.2S
    MOV S28, V4.S[0x0]
    FMINP S4, V29.2S
    UADDLV  D29, V12.4S
    UABAL2  V10.4S, V28.8H, V29.8H
    RBIT  V8.16B, V4.16B
    SHLL  V23.2D, V10.2S, #32
    RSHRN V31.2S, V8.2D, #24
    URSQRTE  V12.2S, V31.2S
    FMULX H5, H23, V12.H[0x6]
    SSHLL2 V23.4S, V14.8H, #0xd
    FMINNMV  S28, V24.4S
    UQSHL  V4.16B, V6.16B, V13.16B
    UMLSL2 V13.4S, V3.8H, V8.H[0x1]
    FCVTPS  V17.8H, V3.8H
    FMAXV  S24, V23.4S
    FMAXP  V27.4H, V11.4H, V20.4H
    UMAXP  V14.16B, V9.16B, V12.16B
    ADD  V31.4H, V13.4H, V15.4H
    SQDMLAL2 V20.4S, V1.8H, V0.H[0x1]
    FSQRT  V9.8H, V17.8H
    FMIN  V10.2D, V28.2D, V20.2D
    MLS  V6.2S, V14.2S, V14.S[0x0]
    DUP V13.16B, W25
    XTN2  V7.16B, V9.8H
    UMULL V9.2D, V5.2S, V4.S[0x0]
    FCVTZS  V4.4S, V31.4S, #17
    SMOV  X15, V4.B[0x4]
    UQRSHL  V4.2D, V24.2D, V24.2D
    SHL V3.2D, V27.2D, #0x2
    MOVI  V31.4S, #0x57, MSL #16
    FRINTM  V29.4H, V6.4H
    SRSHR  V5.4S, V10.4S, #10
    UMAXV  B14, V31.8B
    FMUL S28, S14, V5.S[0x1]
    UQRSHL  V14.16B, V3.16B, V21.16B
    SQSHLU  V24.8B, V4.8B, #0x4
    FMULX  V8.2D, V29.2D, V4.2D
    FMAXV  S4, V13.4S
    XTN2  V3.16B, V9.8H
    UMLSL2 V21.2D, V18.4S, V4.S[0x2]
    SHL V20.2D, V14.2D, #0x34
    UMIN  V9.16B, V5.16B, V28.16B
    FMINNMP  V27.4H, V21.4H, V4.4H
    SQRSHRN V1.2S, V8.2D, #5
    MOVI  V31.4S, #0xa5, MSL #16
    SMINV  H29, V3.8H
    URSHR V10.2D, V31.2D, #3
    AND  V13.16B, V29.16B, V24.16B
    USRA  V31.8B, V1.8B, #5
    FMINNM  V17.8H, V31.8H, V7.8H
    UMULL  V29.8H, V17.8B, V20.8B
    FCVTMU  V4.4H, V13.4H
    ADD  V24.8B, V4.8B, V27.8B
    FSUB  V21.8H, V24.8H, V29.8H
    SADDL2  V7.8H, V9.16B, V21.16B
    SABDL2  V13.2D, V27.4S, V10.4S
    USUBL2  V6.2D, V13.4S, V7.4S
    SXTL V5.2D, V30.2S
    SLI  V21.16B, V2.16B, #0x6
    FCMEQ  V18.2S, V13.2S, #0.0
    USUBW  V28.2D, V6.2D, V8.2S
    SRI  V13.2S, V27.2S, #10
    ADD  V30.8B, V21.8B, V22.8B
    USUBL  V14.2D, V22.2S, V8.2S
    UHSUB  V22.8B, V16.8B, V24.8B
    SMULL V27.2D, V2.2S, V19.S[0x3]
    FSQRT  V3.4H, V28.4H
    SRHADD  V21.8H, V24.8H, V0.8H
    SMULL  V8.8H, V22.8B, V30.8B
    SRI  V20.8H, V18.8H, #15
    FMUL H17, H20, V13.H[0x5]
    MOV B9, V5.B[0x1]
    FMLA S30, S9, V8.S[0x1]
    UZP1  V8.4S, V30.4S, V21.4S
    FMINNMV  S18, V3.4S
    FMAXP S9, V8.2S
    FMINP D3, V9.2D
    SHL V13.2D, V3.2D, #0x1a
    UCVTF  V16.4H, V13.4H
    USHLL2 V2.4S, V27.8H, #0x5
    CMGE  V0.2S, V18.2S, #0
    REV32  V5.8B, V14.8B
    UXTL2 V13.2D, V5.4S
    DUP V30.8H, W25
    FRSQRTS  V9.2D, V0.2D, V17.2D
    PMULL2  V21.1Q, V2.2D, V6.2D
    FCVTAS  V5.4H, V13.4H
    ADDV  H2, V16.8H
    UHSUB  V27.4S, V2.4S, V2.4S
    FMAXNM  V18.2S, V27.2S, V30.2S
    FMAXP S8, V21.2S
    SQSHRUN2 V2.8H, V9.4S, #2
    UQSHL  V3.4S, V5.4S, #0xf
    MOVI  V14.2D, #1099494915840
    FCVTNU  V13.4S, V18.4S
    SMLAL  V30.2D, V8.2S, V3.2S
    XTN  V17.8B, V14.8H
    SMLSL2 V5.2D, V30.4S, V17.S[0x3]
    CMGT  V17.4S, V13.4S, #0
    UMLSL2 V0.4S, V17.8H, V11.H[0x3]
    BSL  V17.16B, V0.16B, V0.16B
    SMINP  V11.8H, V5.8H, V2.8H
    CMGE  V5.16B, V17.16B, #0
    FCMEQ  V16.4S, V5.4S, V5.4S
    PMUL  V18.16B, V16.16B, V11.16B
    FCVTPS  V27.4S, V19.4S
    DUP  V17.2S, V20.S[0x0]
    NEG  V8.4H, V22.4H
    SQDMULH  V0.4S, V22.4S, V26.S[0x2]
    FABD  V19.8H, V25.8H, V23.8H
    MOV V21.S[0x2], W8
    UQRSHRN V13.8B, V26.8H, #8
    SSRA  V2.2S, V29.2S, #24
    USRA  V3.2S, V17.2S, #6
    INS V5.S[0x3], V27.S[0x1]
    UMULL2 V14.4S, V6.8H, V3.H[0x1]
    SADDW  V27.4S, V18.4S, V8.4H
    URSHR  V25.4S, V14.4S, #28
    FRSQRTE  V29.2D, V0.2D
    FMAXNMP H16, V19.2H
    FMUL H17, H21, V9.H[0x6]
    SMAXV  S19, V17.4S
    UQSHRN2 V20.8H, V5.4S, #10
    SRSHR  V0.16B, V13.16B, #3
    FCMLT  V13.2S, V2.2S, #0.0
    SQRSHRUN V6.8B, V13.8H, #2
    UMULL2 V5.4S, V8.8H, V0.H[0x3]
    UQSHRN2 V26.8H, V5.4S, #11
    MOV V2.S[0x1], W27
    UQRSHRN2 V3.16B, V27.8H, #7
    MOV S11, V29.S[0x0]
    UMULL V5.4S, V6.4H, V11.H[0x2]
    UCVTF  V8.4S, V16.4S, #1
    SRI  V27.16B, V5.16B, #3
    SADDW  V11.2D, V20.2D, V26.2S
    URECPE  V22.2S, V14.2S
    SABD  V16.4H, V25.4H, V19.4H
    FMUL H21, H2, V3.H[0x4]
    FCVTNS  V0.8H, V11.8H
    DUP V23.8B, W20
    FMUL S13, S27, V16.S[0x1]
    DUP V20.8H, W29
    FCVTZU  V6.8H, V23.8H
    FMAXP H11, V21.2H
    FCVTNS  V23.4S, V22.4S
    CMLE  V16.4S, V6.4S, #0
    SMULL  V26.4S, V11.4H, V13.4H
    FCVTNS  V11.4S, V8.4S
    FRINTX  V5.4S, V14.4S
    FMAXP H25, V0.2H
    UQRSHRN2 V21.8H, V25.4S, #9
    MOVI  V8.8B, #0xb9
    SQRSHRN V27.4H, V16.4S, #1
    SHA256H  Q25, Q20, V23.4S
    SQDMLSL S2, H25, V5.H[0x3]
    SQDMLSL S22, H11, V11.H[0x5]
    FMLA S11, S26, V22.S[0x0]
    USQADD  V16.8H, V27.8H
    MOVI  V19.2S, #0xc9, LSL #24
    UQSHL V27.2D, V21.2D, #0x27
    FCVTPS  V20.4H, V11.4H
    SQSHRUN V5.4H, V7.4S, #14
    FCMGE  V3.4H, V27.4H, V5.4H
    FDIV  V14.8H, V3.8H, V2.8H
    FCVTPS  V23.4S, V16.4S
    UABDL2  V6.2D, V15.4S, V20.4S
    UABAL2  V26.8H, V23.16B, V14.16B
    SQXTUN  V15.8B, V8.8H
    SMLSL2 V2.4S, V19.8H, V15.H[0x4]
    UQSHL  V5.4H, V6.4H, V22.4H
    UABAL2  V8.2D, V5.4S, V2.4S
    CMGT  V25.4H, V26.4H, V26.4H
    CMGT  V23.8H, V8.8H, V8.8H
    SQDMULL D21, S25, V23.S[0x2]
    SSHR  V15.16B, V17.16B, #2
    SMULL2 V11.2D, V7.4S, V7.S[0x1]
    SMLAL2  V20.4S, V15.8H, V14.8H
    FSQRT  V6.8H, V16.8H
    SSUBW  V5.4S, V0.4S, V30.4H
    SHLL  V27.8H, V20.8B, #8
    RBIT  V2.8B, V18.8B
    ZIP1  V8.4H, V24.4H, V18.4H
    SQADD  V3.8H, V15.8H, V23.8H
    TBX  V26.8B, { V23.16B }, V29.8B
    SQDMULL V24.4S, V5.4H, V5.H[0x6]
    FCMGT  V14.4H, V26.4H, V2.4H
    MOV V20.D[0x1], V14.D[0x1]
    UADALP  V30.4S, V21.8H
    RBIT  V21.8B, V30.8B
    FMLA V30.4S, V11.4S, V3.S[0x1]
    SHA256H2  Q3, Q21, V24.4S
    ADDP  V29.2S, V6.2S, V3.2S
    UQADD  V17.8B, V30.8B, V27.8B
    FMULX  V16.4H, V8.4H, V20.4H
    ADDV  H0, V16.8H
    UQSHL V7.2D, V0.2D, #0x30
    SQDMULL  V0.2D, V17.2S, V7.2S
    FCVTMU  V23.2D, V0.2D
    FMULX S3, S23, V29.S[0x0]
    UADDLV  S14, V23.8H
    FMINP  V20.4H, V0.4H, V7.4H
    SQSHRUN V18.2S, V16.2D, #2
    UXTL2 V23.4S, V0.8H
    FMAXP H25, V20.2H
    SQRDMULH S29, S9, V22.S[0x0]
    FCVTL2  V30.4S, V25.8H
    SABA  V20.8B, V3.8B, V14.8B
    MOV  W25, V13.S[0x0]
    SABDL2  V7.4S, V2.8H, V13.8H
    SMLAL V25.2D, V10.2S, V10.S[0x0]
    CMGT  V22.8H, V27.8H, V18.8H
    RBIT  V0.16B, V1.16B
    SMOV W10, V8.B[0x4]
    UMIN  V14.8H, V30.8H, V22.8H
    BIC  V17.8H, #0x3
    SHA256H2  Q10, Q14, V6.4S
    FADDP H13, V9.2H
    FMLS S9, S25, V17.S[0x1]
    USHLL V2.2D, V13.2S, #0x14
    UABA  V16.4S, V0.4S, V2.4S
    UMOV X8, V29.D[0x0]
    XTN2  V29.4S, V16.2D
    RSUBHN2  V3.4S, V9.2D, V7.2D
    SHLL2  V14.8H, V20.16B, #8
    UMAXP  V16.4S, V23.4S, V29.4S
    URSHR  V27.8B, V16.8B, #7
    SSHLL2 V25.8H, V14.16B, #0x1
    FCMGT  V29.2S, V27.2S, V31.2S
    SQSHLU  V5.2S, V3.2S, #0x1a
    FMLA S3, S29, V5.S[0x2]
    SHA256SU1  V3.4S, V6.4S, V10.4S
    RADDHN  V31.8B, V25.8H, V25.8H
    DUP V16.16B, W25
    FMLA H10, H3, V6.H[0x7]
    USRA  V30.4H, V31.4H, #10
    URECPE  V25.2S, V16.2S
    UMULL2  V20.2D, V25.4S, V0.4S
    FCVTAU  V16.2D, V30.2D
    SQXTN  V13.8B, V10.8H
    SQSHRN V5.8B, V13.8H, #5
    UMLSL2  V3.4S, V19.8H, V5.8H
    UHADD  V17.4H, V20.4H, V3.4H
    SHRN2 V23.8H, V17.4S, #16
    SMULL V27.2D, V28.2S, V23.S[0x1]
    SQDMLSL D29, S27, V27.S[0x2]
    URSHR  V7.16B, V16.16B, #7
    FCVTNU  V13.4H, V29.4H
    UADDLV  D6, V7.4S
    FRINTM  V30.2S, V13.2S
    SUQADD  V7.2S, V30.2S
    FCVTZU  V31.8H, V7.8H, #1
    SQRSHL  V23.8H, V6.8H, V6.8H
    FMLS D13, D23, V23.D[0x1]
    FMLA V14.4H, V10.4H, V13.H[0x6]
    UMLSL2 V25.2D, V14.4S, V8.S[0x2]
    FMULX  V14.8H, V17.8H, V31.8H
    SMINV  S23, V25.4S
    UMAX  V6.16B, V14.16B, V23.16B
    SQSHRN2 V19.16B, V2.8H, #7
    FMAXP  V30.2S, V28.2S, V31.2S
    SRSHR  V20.4H, V10.4H, #10
    SRSHL  V16.2S, V29.2S, V13.2S
    FCMGT  V10.8H, V10.8H, #0.0
    SUBS  X2, X2, #0x1
    B.NE  TSRTAdvsimdVectorAllOperation_label_14
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x9f, LSL #0
    MOVK  X5, #0x800, LSL #16
    MRS  X26, FPSR
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V0.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, D0
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V1.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, D1
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V2.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xfff0, LSL #16
    MOVK  X5, #0xf, LSL #32
    FMOV  X26, D2
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0xa665, LSL #0
    MOVK  X5, #0x7ccc, LSL #16
    MOVK  X5, #0x8dd2, LSL #32
    MOVK  X5, #0x9333, LSL #48
    FMOV  X26, V3.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0xcb45, LSL #0
    MOVK  X5, #0x1a20, LSL #16
    MOVK  X5, #0x4d31, LSL #32
    MOVK  X5, #0x7acd, LSL #48
    FMOV  X26, D3
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V4.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, D4
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V5.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x7, LSL #0
    FMOV  X26, D5
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V6.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    FMOV  X26, D6
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V7.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, D7
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V8.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, D8
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V9.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    FMOV  X26, D9
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V10.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, D10
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x4000, LSL #32
    FMOV  X26, V11.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x4000, LSL #32
    FMOV  X26, D11
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V12.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    FMOV  X26, D12
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V13.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x8000, LSL #48
    FMOV  X26, D13
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V14.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, D14
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V15.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, D15
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V16.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, D16
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V17.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x65a2, LSL #0
    MOVK  X5, #0xd10, LSL #16
    MOVK  X5, #0x2698, LSL #32
    MOVK  X5, #0x3d66, LSL #48
    FMOV  X26, D17
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V18.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, D18
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0xff00, LSL #0
    FMOV  X26, V19.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xc900, LSL #16
    MOVK  X5, #0xc900, LSL #48
    FMOV  X26, D19
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V20.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, D20
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V21.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, D21
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V22.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, D22
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V23.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    FMOV  X26, D23
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V24.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, D24
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V25.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    FMOV  X26, D25
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V26.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7e, LSL #48
    FMOV  X26, D26
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V27.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, D27
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x80, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    FMOV  X26, V28.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0xbfff, LSL #0
    MOVK  X5, #0x94, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    FMOV  X26, D28
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V29.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, D29
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V30.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    FMOV  X26, D30
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, V31.D[1]
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X26, D31
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X2, #0x741, LSL #0
    MOVK  X2, #0xd9d2, LSL #16
    MOVK  X2, #0x9697, LSL #32
    MOVK  X2, #0x2111, LSL #48
    MOVZ  X3, #0xc1f3, LSL #0
    MOVK  X3, #0x9be0, LSL #16
    MOVK  X3, #0xa46d, LSL #32
    MOVK  X3, #0xd1ed, LSL #48
    MOVZ  X4, #0x14c4, LSL #0
    MOVK  X4, #0x6aff, LSL #16
    MOVK  X4, #0x407e, LSL #32
    MOVK  X4, #0x7904, LSL #48
    MOVZ  X5, #0x26ee, LSL #0
    MOVK  X5, #0xb8b0, LSL #16
    MOVK  X5, #0x7676, LSL #32
    MOVK  X5, #0x4283, LSL #48
    MOVZ  X6, #0x5936, LSL #0
    MOVK  X6, #0x2ba4, LSL #16
    MOVK  X6, #0xbf0b, LSL #32
    MOVK  X6, #0xe0b9, LSL #48
    MOVZ  X7, #0xc428, LSL #0
    MOVK  X7, #0xd54c, LSL #16
    MOVK  X7, #0xcf17, LSL #32
    MOVK  X7, #0x78f, LSL #48
    MOVZ  X8, #0xe944, LSL #0
    MOVK  X8, #0xebd, LSL #16
    MOVK  X8, #0xf5f8, LSL #32
    MOVK  X8, #0x5edb, LSL #48
    MOVZ  X9, #0xbe1b, LSL #0
    MOVK  X9, #0xbf68, LSL #16
    MOVK  X9, #0xd7b1, LSL #32
    MOVK  X9, #0x8645, LSL #48
    MOVZ  X10, #0xffe4, LSL #0
    MOVK  X10, #0x7e8f, LSL #16
    MOVK  X10, #0x97cd, LSL #32
    MOVK  X10, #0x4dbe, LSL #48
    MOVZ  X12, #0x338f, LSL #0
    MOVK  X12, #0xfa0c, LSL #16
    MOVK  X12, #0xce5a, LSL #32
    MOVK  X12, #0x75cb, LSL #48
    MOVZ  X13, #0xf84a, LSL #0
    MOVK  X13, #0x3f33, LSL #16
    MOVK  X13, #0xf961, LSL #32
    MOVK  X13, #0x7274, LSL #48
    MOVZ  X15, #0x5d89, LSL #0
    MOVK  X15, #0xe839, LSL #16
    MOVK  X15, #0xd689, LSL #32
    MOVK  X15, #0x262e, LSL #48
    MOVZ  X16, #0xab76, LSL #0
    MOVK  X16, #0xc525, LSL #16
    MOVK  X16, #0x13e5, LSL #32
    MOVK  X16, #0xb3a6, LSL #48
    MOVZ  X17, #0x2068, LSL #0
    MOVK  X17, #0xdc6e, LSL #16
    MOVK  X17, #0xd4e0, LSL #32
    MOVK  X17, #0x9384, LSL #48
    MOVZ  X19, #0xe7e4, LSL #0
    MOVK  X19, #0xbc26, LSL #16
    MOVK  X19, #0x963c, LSL #32
    MOVK  X19, #0x1ddd, LSL #48
    MOVZ  X20, #0xfbee, LSL #0
    MOVK  X20, #0x97b6, LSL #16
    MOVK  X20, #0xa0d, LSL #32
    MOVK  X20, #0x2b20, LSL #48
    MOVZ  X22, #0xdae1, LSL #0
    MOVK  X22, #0xded7, LSL #16
    MOVK  X22, #0xbeec, LSL #32
    MOVK  X22, #0x3f5f, LSL #48
    MOVZ  X23, #0x60cc, LSL #0
    MOVK  X23, #0x1324, LSL #16
    MOVK  X23, #0x638b, LSL #32
    MOVK  X23, #0xfc79, LSL #48
    MOVZ  X24, #0xdc, LSL #0
    MOVK  X24, #0x7ac5, LSL #16
    MOVK  X24, #0x4f88, LSL #32
    MOVK  X24, #0x4ec8, LSL #48
    MOVZ  X25, #0x8ff1, LSL #0
    MOVK  X25, #0xef46, LSL #16
    MOVK  X25, #0xe6d, LSL #32
    MOVK  X25, #0x5f69, LSL #48
    MOVZ  X26, #0xb4eb, LSL #0
    MOVK  X26, #0x89d8, LSL #16
    MOVK  X26, #0x759a, LSL #32
    MOVK  X26, #0x2e1c, LSL #48
    MOVZ  X27, #0x682e, LSL #0
    MOVK  X27, #0x9012, LSL #16
    MOVK  X27, #0xce76, LSL #32
    MOVK  X27, #0x48db, LSL #48
    MOVZ  X28, #0x9ef, LSL #0
    MOVK  X28, #0x188b, LSL #16
    MOVK  X28, #0x7660, LSL #32
    MOVK  X28, #0x6950, LSL #48
    MOVZ  X29, #0xb0c4, LSL #0
    MOVK  X29, #0x6ba5, LSL #16
    MOVK  X29, #0x82b8, LSL #32
    MOVK  X29, #0x600a, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X22
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X26
    FMOV  D3, X10
    FMOV  V3.D[1], X4
    FMOV  D4, X22
    FMOV  V4.D[1], X5
    FMOV  D5, X16
    FMOV  V5.D[1], X3
    FMOV  D6, X3
    FMOV  V6.D[1], X10
    FMOV  D7, X20
    FMOV  V7.D[1], X29
    FMOV  D8, X28
    FMOV  V8.D[1], X17
    FMOV  D9, X24
    FMOV  V9.D[1], X28
    FMOV  D10, X6
    FMOV  V10.D[1], X20
    FMOV  D11, X23
    FMOV  V11.D[1], X24
    FMOV  D12, X6
    FMOV  V12.D[1], X23
    FMOV  D13, X20
    FMOV  V13.D[1], X24
    FMOV  D14, X20
    FMOV  V14.D[1], X3
    FMOV  D15, X22
    FMOV  V15.D[1], X3
    FMOV  D16, X28
    FMOV  V16.D[1], X24
    FMOV  D17, X29
    FMOV  V17.D[1], X27
    FMOV  D18, X13
    FMOV  V18.D[1], X28
    FMOV  D19, X12
    FMOV  V19.D[1], X8
    FMOV  D20, X23
    FMOV  V20.D[1], X4
    FMOV  D21, X10
    FMOV  V21.D[1], X5
    FMOV  D22, X9
    FMOV  V22.D[1], X3
    FMOV  D23, X16
    FMOV  V23.D[1], X27
    FMOV  D24, X8
    FMOV  V24.D[1], X24
    FMOV  D25, X4
    FMOV  V25.D[1], X17
    FMOV  D26, X29
    FMOV  V26.D[1], X17
    FMOV  D27, X13
    FMOV  V27.D[1], X7
    FMOV  D28, X22
    FMOV  V28.D[1], X2
    FMOV  D29, X10
    FMOV  V29.D[1], X5
    FMOV  D30, X5
    FMOV  V30.D[1], X3
    FMOV  D31, X20
    FMOV  V31.D[1], X20
    MOVZ  X15, #0xa, LSL #0
TSRTAdvsimdVectorAllOperation_label_15:
    SQDMULH S4, S27, V31.S[0x3]
    MOV V20.D[0x0], V28.D[0x1]
    SQABS  V8.8H, V4.8H
    SADDW2  V24.8H, V8.8H, V19.16B
    FACGE  V26.4S, V30.4S, V29.4S
    SHRN2 V26.8H, V20.4S, #3
    SQSHL  V23.4H, V25.4H, #0xa
    USHLL V13.4S, V24.4H, #0xa
    UCVTF  V2.4H, V26.4H
    FCMEQ  V31.2S, V13.2S, #0.0
    UADDL2  V3.4S, V31.8H, V2.8H
    SRSHR  V0.16B, V3.16B, #8
    FCVTZU  V27.8H, V23.8H, #7
    SQRDMULH S4, S0, V21.S[0x1]
    SQADD  V24.4S, V4.4S, V27.4S
    FMAXNM  V28.4S, V18.4S, V3.4S
    RADDHN2  V13.16B, V11.8H, V20.8H
    PMUL  V26.8B, V14.8B, V30.8B
    SQSHRUN2 V30.16B, V14.8H, #6
    USHLL V29.8H, V27.8B, #0x6
    SHSUB  V3.8B, V19.8B, V4.8B
    FMAXNMV  S31, V9.4S
    SMULL V14.2D, V23.2S, V19.S[0x2]
    UABDL2  V2.4S, V30.8H, V28.8H
    UADDW  V30.2D, V13.2D, V13.2S
    SSHR V18.2D, V3.2D, #10
    SQDMULL2 V9.4S, V18.8H, V13.H[0x5]
    BIC  V0.2S, #0x11, LSL #8
    URSHR  V11.4S, V20.4S, #24
    UCVTF  V21.8H, V14.8H, #14
    MOV H14, V30.H[0x7]
    SLI V27.2D, V31.2D, #0xc
    FMIN  V28.4H, V21.4H, V27.4H
    SMULL  V30.8H, V28.8B, V11.8B
    SQDMLAL2 V20.4S, V14.8H, V2.H[0x3]
    UADDW  V25.4S, V9.4S, V24.4H
    FCVTZU  V4.2S, V26.2S, #25
    FMAXP  V11.2D, V30.2D, V30.2D
    SMLAL2  V19.8H, V0.16B, V29.16B
    FCVTAS  V21.4H, V11.4H
    SQSHRN2 V1.8H, V4.4S, #9
    DUP  V9.4S, V21.S[0x0]
    SHRN V30.8B, V19.8H, #7
    SCVTF  V19.4H, V20.4H
    SMULL  V31.2D, V25.2S, V25.2S
    FABS  V0.4H, V31.4H
    USHLL2 V2.8H, V30.16B, #0x7
    FMAXNMP D18, V0.2D
    CMLT  V20.8H, V2.8H, #0
    UQSHL  V24.8H, V2.8H, V18.8H
    UMINV  B18, V20.8B
    FMLS V25.4H, V18.4H, V14.H[0x7]
    UQSHL  V21.4H, V1.4H, #0x9
    SMINV  B26, V14.8B
    FCVTZS  V2.2S, V9.2S, #8
    FMINV  S13, V21.4S
    SHSUB  V20.2S, V2.2S, V24.2S
    FMUL V31.4H, V26.4H, V13.H[0x3]
    SMLAL2 V11.4S, V31.8H, V11.H[0x0]
    FMINNMV  H21, V19.8H
    UXTL2 V31.2D, V21.4S
    FMAXNMP S30, V20.2S
    FCMGT  V2.8H, V25.8H, V30.8H
    SQSUB  V26.16B, V2.16B, V31.16B
    FMAXV  S24, V11.4S
    SHA1P  Q4, S24, V26.4S
    USHL  V19.4S, V20.4S, V10.4S
    SHSUB  V20.4S, V9.4S, V7.4S
    FADD  V10.4S, V29.4S, V5.4S
    FABS  V18.4S, V14.4S
    UXTL V14.4S, V9.4H
    FCVTZS  V29.8H, V6.8H, #11
    FMINNMP D13, V26.2D
    SRI  V5.2S, V0.2S, #10
    UABDL  V7.2D, V14.2S, V27.2S
    USHR  V14.16B, V7.16B, #5
    UMULL V7.2D, V4.2S, V5.S[0x1]
    SMAXV  H1, V19.8H
    UQADD  V4.2S, V10.2S, V20.2S
    UMAXV  S9, V18.4S
    SQRDMULH  V21.8H, V9.8H, V13.H[0x1]
    FMOV  V6.2D, #-5.00000000
    SSHR  V18.2S, V29.2S, #23
    UHADD  V10.16B, V18.16B, V7.16B
    FRINTA  V7.4H, V6.4H
    CMLE  V29.4H, V4.4H, #0
    UQSHRN V6.8B, V14.8H, #6
    MOV  V0.8B, V23.8B
    SQRDMULH  V26.4S, V7.4S, V10.S[0x2]
    FMAXNMP D27, V9.2D
    CMEQ  V9.4S, V29.4S, #0
    SADDL  V5.4S, V9.4H, V9.4H
    FMAXNM  V9.4H, V0.4H, V21.4H
    FACGE  V10.4H, V27.4H, V26.4H
    SHA1P  Q4, S7, V9.4S
    FRINTZ  V18.8H, V1.8H
    SXTL V10.4S, V5.4H
    FMAXV  H21, V5.8H
    MUL  V14.8H, V21.8H, V21.8H
    URECPE  V19.4S, V18.4S
    SQSHLU  V13.4H, V6.4H, #0x6
    FCVTZS V29.2D, V4.2D, #44
    FMUL V21.4H, V13.4H, V14.H[0x6]
    REV64  V14.8H, V4.8H
    SQRSHRUN2 V13.4S, V10.2D, #1
    SQSHL  V5.16B, V6.16B, V19.16B
    DUP V4.8B, W8
    FMAXNMP H1, V21.2H
    ADDP  D21, V13.2D
    DUP S19, V29.S[0x2]
    SQDMULL2 V6.2D, V5.4S, V19.S[0x1]
    SRSHR  V0.8H, V6.8H, #10
    FMAXP  V9.2S, V14.2S, V14.2S
    UHSUB  V27.4H, V21.4H, V9.4H
    SRI  V13.8B, V0.8B, #4
    FMAX  V26.8H, V4.8H, V4.8H
    SMLAL V4.4S, V13.4H, V13.H[0x7]
    USHL  V14.4H, V27.4H, V27.4H
    CMHS  V9.16B, V1.16B, V4.16B
    UQSUB  V10.8B, V26.8B, V14.8B
    UMOV W22, V9.B[0xa]
    USHLL V9.4S, V27.4H, #0x7
    URSHR  V4.2S, V26.2S, #4
    SCVTF  V18.2D, V4.2D
    SQDMULL2 V13.4S, V10.8H, V13.H[0x3]
    CLS  V1.4H, V29.4H
    SMLAL V19.2D, V10.2S, V15.S[0x1]
    ADDV  H10, V20.8H
    SXTL V0.4S, V14.4H
    SMINV  S21, V12.4S
    MOVI  V29.2S, #0x3
    FMAXNMV  S12, V9.4S
    SSRA  V9.8H, V29.8H, #12
    CLZ  V20.8H, V18.8H
    DUP V4.8B, W28
    SHA256H2  Q29, Q21, V19.4S
    DUP H27, V29.H[0x3]
    CMTST  V6.2D, V13.2D, V1.2D
    DUP D26, V10.D[0x1]
    MOV  W25, V20.S[0x2]
    FMAXNMP H15, V0.2H
    SHA1SU1  V18.4S, V25.4S
    FMOV  V19.2S, #1.18750000
    SRHADD  V21.8H, V9.8H, V6.8H
    RSUBHN2  V6.16B, V12.8H, V12.8H
    SRSHR V29.2D, V27.2D, #56
    USHR  V27.8H, V26.8H, #3
    SQRDMULH  V1.4H, V15.4H, V1.H[0x1]
    FCVTNS  V15.2D, V29.2D
    FRSQRTE  V26.2D, V20.2D
    SADDLV  H14, V21.8B
    FCMGE  V27.8H, V4.8H, V27.8H
    MUL  V20.4H, V6.4H, V9.H[0x2]
    FMLS H10, H12, V14.H[0x3]
    FMAXP  V21.2S, V19.2S, V27.2S
    UMLAL2  V27.2D, V21.4S, V1.4S
    SHA256SU0  V13.4S, V27.4S
    ADD  V4.4S, V26.4S, V10.4S
    FRINTN  V0.4H, V18.4H
    SHL V25.2D, V20.2D, #0xe
    SSRA  V29.16B, V4.16B, #8
    UMLSL V11.2D, V29.2S, V25.S[0x1]
    UQRSHRN2 V18.8H, V13.4S, #15
    SQDMULL D29, S30, V2.S[0x1]
    DUP V12.8H, W5
    SMINV  S2, V29.4S
    FMINNM  V9.2S, V12.2S, V2.2S
    SMLSL V25.2D, V0.2S, V11.S[0x2]
    UMLSL V20.4S, V25.4H, V15.H[0x1]
    UQADD  V25.4H, V9.4H, V18.4H
    FADDP H4, V25.2H
    UMOV W5, V20.S[0x2]
    RSHRN2 V13.4S, V18.2D, #21
    SSHLL2 V9.2D, V27.4S, #0x1b
    FCVTNU  V6.8H, V14.8H
    SQDMLAL V19.2D, V31.2S, V5.S[0x1]
    SHA256H  Q29, Q22, V10.4S
    TBL  V30.16B, { V10.16B, V11.16B, V12.16B, V13.16B }, V24.16B
    SQABS  V18.2D, V4.2D
    SQDMLAL S21, H22, V5.H[0x2]
    FMINP  V5.4H, V25.4H, V12.4H
    FMLS V26.2D, V23.2D, V13.D[0x1]
    FMINNMV  H22, V9.4H
    SABDL2  V2.8H, V6.16B, V10.16B
    UADDL2  V15.2D, V2.4S, V26.4S
    FMINNM  V31.4S, V15.4S, V10.4S
    UMOV W10, V14.B[0xf]
    SQDMLSL D0, S24, V19.S[0x1]
    FRECPS  V25.8H, V29.8H, V26.8H
    SRI  V27.8H, V22.8H, #4
    SQRSHRN2 V29.4S, V0.2D, #8
    FADDP  V19.4S, V18.4S, V30.4S
    FSQRT  V22.2D, V5.2D
    FMINNMP S24, V31.2S
    FCMLT  V11.2S, V27.2S, #0.0
    FMAXNMV  H23, V21.4H
    FCMGT  V2.8H, V23.8H, V23.8H
    FMAXNMP  V27.8H, V24.8H, V2.8H
    REV64  V18.16B, V11.16B
    FMULX H26, H18, V12.H[0x0]
    FCVTL2  V30.4S, V26.8H
    FRECPS  V23.4H, V25.4H, V2.4H
    SADDLV  S4, V19.4H
    FMLA S24, S22, V22.S[0x2]
    SHRN V21.8B, V24.8H, #2
    SQRSHRUN V31.2S, V21.2D, #28
    FMINNMP  V11.8H, V27.8H, V29.8H
    DUP  V5.4H, V23.H[0x3]
    BIC  V2.16B, V30.16B, V31.16B
    MLS  V0.4S, V5.4S, V10.4S
    FRINTX  V12.2S, V11.2S
    SQSHRUN2 V11.8H, V4.4S, #12
    SMOV  X10, V2.B[0x8]
    BSL  V10.16B, V11.16B, V0.16B
    SQDMULH  V2.2S, V10.2S, V12.S[0x1]
    SQDMLAL2 V10.2D, V1.4S, V24.S[0x3]
    FMAXNM  V14.2D, V0.2D, V16.2D
    TRN2  V4.4S, V5.4S, V10.4S
    FRINTI  V27.4S, V15.4S
    SHL  V12.16B, V10.16B, #0x0
    SHA256SU0  V15.4S, V20.4S
    FMULX  V11.2D, V1.2D, V5.2D
    SCVTF  V30.4S, V1.4S, #5
    UABDL  V20.2D, V9.2S, V29.2S
    RSUBHN2  V1.16B, V2.8H, V4.8H
    USUBL2  V2.2D, V1.4S, V27.4S
    UMLSL2 V5.4S, V30.8H, V14.H[0x3]
    FADDP H29, V5.2H
    MOV  W28, V15.S[0x3]
    SHRN2 V30.4S, V12.2D, #10
    FMOV  V14.4S, #-1.87500000
    SSRA  V1.4S, V30.4S, #18
    FNEG  V9.4H, V20.4H
    FMINNMP H0, V14.2H
    SQRSHRUN2 V4.16B, V1.8H, #2
    UMULL  V27.8H, V4.8B, V29.8B
    UMOV X4, V2.D[0x1]
    FMUL S20, S9, V0.S[0x3]
    MLA  V5.4S, V27.4S, V11.4S
    UQSHRN2 V16.16B, V5.8H, #5
    SQRDMULH H5, H16, V8.H[0x0]
    SHA1M  Q15, S20, V20.4S
    MOVI  V10.4S, #0x40
    URSHR  V24.4H, V15.4H, #16
    SRSRA  V15.4H, V5.4H, #7
    UQRSHRN V14.2S, V10.2D, #21
    UQRSHRN V11.2S, V14.2D, #22
    SMULL2 V2.4S, V24.8H, V5.H[0x2]
    CMGT  V10.4S, V2.4S, #0
    RADDHN  V14.8B, V15.8H, V10.8H
    FCMLE  V2.4H, V11.4H, #0.0
    FRSQRTS  V20.4H, V14.4H, V14.4H
    SHA256H  Q5, Q2, V2.4S
    SQRSHRN2 V30.4S, V5.2D, #12
    SQDMLSL S1, H20, V6.H[0x7]
    SQSUB  V15.16B, V1.16B, V1.16B
    FDIV  V8.2D, V15.2D, V15.2D
    SMLSL V24.4S, V30.4H, V8.H[0x3]
    FRINTM  V16.4H, V31.4H
    USHLL2 V31.8H, V27.16B, #0x4
    URHADD  V9.4S, V24.4S, V17.4S
    RADDHN  V15.2S, V1.2D, V9.2D
    URECPE  V20.2S, V10.2S
    SQDMULL2  V11.2D, V25.4S, V27.4S
    MLA  V10.4S, V17.4S, V14.S[0x2]
    SQSHRUN2 V30.8H, V13.4S, #2
    FCMGE  V24.4H, V18.4H, V6.4H
    FRECPE  V13.4S, V1.4S
    UQSHL  V2.4H, V10.4H, #0x4
    SQDMLSL2 V5.4S, V11.8H, V2.H[0x2]
    FMLA D8, D5, V16.D[0x1]
    UMAXV  B27, V27.8B
    FCMGE  V5.2D, V8.2D, V27.2D
    USRA  V1.4H, V5.4H, #8
    INS V18.S[0x3], W9
    FMINNMV  H2, V24.4H
    SMULL  V24.8H, V30.8B, V13.8B
    SMLSL2 V30.2D, V20.4S, V15.S[0x3]
    RSUBHN  V27.4H, V30.4S, V1.4S
    USHLL V17.4S, V27.4H, #0x3
    UMINV  H8, V17.8H
    USHR V6.2D, V8.2D, #45
    MOV V9.H[0x3], V31.H[0x0]
    UADDLP  V8.1D, V13.2S
    SHL  V15.4S, V24.4S, #0x1d
    NEG  V31.16B, V18.16B
    SRI V5.2D, V3.2D, #13
    SHRN V13.4H, V2.4S, #12
    SXTL2 V24.8H, V6.16B
    SQDMULH S2, S19, V24.S[0x1]
    FMAX  V16.2D, V31.2D, V9.2D
    SADDW  V24.2D, V8.2D, V16.2S
    FMLS H3, H15, V2.H[0x4]
    USHR  V20.4H, V5.4H, #15
    SMLSL2 V8.2D, V13.4S, V20.S[0x1]
    FRINTA  V30.8H, V3.8H
    SQSHRN2 V17.16B, V8.8H, #6
    DUP S16, V30.S[0x0]
    SQDMLSL  V18.2D, V17.2S, V16.2S
    UADDL2  V6.2D, V15.4S, V21.4S
    SUBS  X15, X15, #0x1
    B.NE  TSRTAdvsimdVectorAllOperation_label_15
    MOVZ  X29, #0x741, LSL #0
    MOVK  X29, #0xd9d2, LSL #16
    MOVK  X29, #0x9697, LSL #32
    MOVK  X29, #0x2111, LSL #48
    SUB  X12, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0xc1f3, LSL #0
    MOVK  X29, #0x9be0, LSL #16
    MOVK  X29, #0xa46d, LSL #32
    MOVK  X29, #0xd1ed, LSL #48
    SUB  X12, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x5936, LSL #0
    MOVK  X29, #0x2ba4, LSL #16
    MOVK  X29, #0xbf0b, LSL #32
    MOVK  X29, #0xe0b9, LSL #48
    SUB  X12, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0xe944, LSL #0
    MOVK  X29, #0xebd, LSL #16
    MOVK  X29, #0xf5f8, LSL #32
    MOVK  X29, #0x5edb, LSL #48
    SUB  X12, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0xbe1b, LSL #0
    MOVK  X29, #0xbf68, LSL #16
    MOVK  X29, #0xd7b1, LSL #32
    MOVK  X29, #0x8645, LSL #48
    SUB  X12, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0xf84a, LSL #0
    MOVK  X29, #0x3f33, LSL #16
    MOVK  X29, #0xf961, LSL #32
    MOVK  X29, #0x7274, LSL #48
    SUB  X12, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0xab76, LSL #0
    MOVK  X29, #0xc525, LSL #16
    MOVK  X29, #0x13e5, LSL #32
    MOVK  X29, #0xb3a6, LSL #48
    SUB  X12, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x2068, LSL #0
    MOVK  X29, #0xdc6e, LSL #16
    MOVK  X29, #0xd4e0, LSL #32
    MOVK  X29, #0x9384, LSL #48
    SUB  X12, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0xe7e4, LSL #0
    MOVK  X29, #0xbc26, LSL #16
    MOVK  X29, #0x963c, LSL #32
    MOVK  X29, #0x1ddd, LSL #48
    SUB  X12, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0xfbee, LSL #0
    MOVK  X29, #0x97b6, LSL #16
    MOVK  X29, #0xa0d, LSL #32
    MOVK  X29, #0x2b20, LSL #48
    SUB  X12, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0xff, LSL #0
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x60cc, LSL #0
    MOVK  X29, #0x1324, LSL #16
    MOVK  X29, #0x638b, LSL #32
    MOVK  X29, #0xfc79, LSL #48
    SUB  X12, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0xdc, LSL #0
    MOVK  X29, #0x7ac5, LSL #16
    MOVK  X29, #0x4f88, LSL #32
    MOVK  X29, #0x4ec8, LSL #48
    SUB  X12, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x10, LSL #0
    MOVK  X29, #0x10, LSL #16
    SUB  X12, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0xb4eb, LSL #0
    MOVK  X29, #0x89d8, LSL #16
    MOVK  X29, #0x759a, LSL #32
    MOVK  X29, #0x2e1c, LSL #48
    SUB  X12, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x682e, LSL #0
    MOVK  X29, #0x9012, LSL #16
    MOVK  X29, #0xce76, LSL #32
    MOVK  X29, #0x48db, LSL #48
    SUB  X12, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x9f, LSL #0
    MOVK  X29, #0x800, LSL #16
    MRS  X12, FPSR
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, V0.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0xbff0, LSL #0
    FMOV  X12, D0
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, V1.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, D1
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, V2.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, D2
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, V3.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x8000, LSL #0
    FMOV  X12, D3
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x4, LSL #32
    FMOV  X12, V4.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0xfff0, LSL #0
    MOVK  X29, #0xfff0, LSL #16
    MOVK  X29, #0x8000, LSL #48
    FMOV  X12, D4
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xfff8, LSL #48
    FMOV  X12, V5.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, D5
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, V6.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, D6
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, V7.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xc000, LSL #48
    FMOV  X12, D7
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, V8.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xff00, LSL #16
    FMOV  X12, D8
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x7e00, LSL #0
    FMOV  X12, V9.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x8000, LSL #32
    FMOV  X12, D9
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, V10.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, D10
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, V11.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, D11
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, V12.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xe002, LSL #16
    MOVK  X29, #0x8000, LSL #48
    FMOV  X12, D12
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, V13.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, D13
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, V14.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x124f, LSL #0
    MOVK  X29, #0x8101, LSL #16
    FMOV  X12, D14
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, V15.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, D15
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, V16.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x8000, LSL #0
    FMOV  X12, D16
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0xfc00, LSL #0
    FMOV  X12, V17.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, D17
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xbe1b, LSL #32
    MOVK  X29, #0xbf68, LSL #48
    FMOV  X12, V18.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X12, D18
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, V19.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, D19
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, V20.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, D20
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, V21.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, D21
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, V22.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, D22
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, V23.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x4000, LSL #0
    MOVK  X29, #0x4000, LSL #16
    MOVK  X29, #0x4000, LSL #32
    MOVK  X29, #0xfff0, LSL #48
    FMOV  X12, D23
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x101, LSL #0
    MOVK  X29, #0x101, LSL #16
    FMOV  X12, V24.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x101, LSL #0
    MOVK  X29, #0x1, LSL #16
    MOVK  X29, #0x1, LSL #32
    FMOV  X12, D24
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x4000, LSL #0
    MOVK  X29, #0x4000, LSL #16
    MOVK  X29, #0x5420, LSL #32
    MOVK  X29, #0x4000, LSL #48
    FMOV  X12, V25.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x4000, LSL #0
    MOVK  X29, #0x4000, LSL #16
    MOVK  X29, #0x4000, LSL #32
    MOVK  X29, #0x7ff0, LSL #48
    FMOV  X12, D25
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, V26.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    FMOV  X12, D26
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, V27.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x1, LSL #48
    FMOV  X12, D27
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, V28.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, D28
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, V29.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0xfff0, LSL #0
    FMOV  X12, D29
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X12, V30.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x8000, LSL #0
    FMOV  X12, D30
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x42e5, LSL #32
    MOVK  X29, #0x4198, LSL #48
    FMOV  X12, V31.D[1]
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X29, #0x101, LSL #0
    MOVK  X29, #0x101, LSL #16
    MOVK  X29, #0x101, LSL #32
    MOVK  X29, #0x101, LSL #48
    FMOV  X12, D31
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorAllOperation_TestFail
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
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X16
    FMOV  V0.D[1], X9
    FMOV  D1, X25
    FMOV  V1.D[1], X17
    FMOV  D2, X29
    FMOV  V2.D[1], X12
    FMOV  D3, X15
    FMOV  V3.D[1], X19
    FMOV  D4, X20
    FMOV  V4.D[1], X24
    FMOV  D5, X28
    FMOV  V5.D[1], X26
    FMOV  D6, X8
    FMOV  V6.D[1], X27
    FMOV  D7, X12
    FMOV  V7.D[1], X5
    FMOV  D8, X26
    FMOV  V8.D[1], X29
    FMOV  D9, X23
    FMOV  V9.D[1], X9
    FMOV  D10, X20
    FMOV  V10.D[1], X23
    FMOV  D11, X19
    FMOV  V11.D[1], X25
    FMOV  D12, X26
    FMOV  V12.D[1], X26
    FMOV  D13, X13
    FMOV  V13.D[1], X9
    FMOV  D14, X22
    FMOV  V14.D[1], X12
    FMOV  D15, X10
    FMOV  V15.D[1], X26
    FMOV  D16, X6
    FMOV  V16.D[1], X8
    FMOV  D17, X17
    FMOV  V17.D[1], X3
    FMOV  D18, X15
    FMOV  V18.D[1], X8
    FMOV  D19, X6
    FMOV  V19.D[1], X19
    FMOV  D20, X7
    FMOV  V20.D[1], X5
    FMOV  D21, X4
    FMOV  V21.D[1], X26
    FMOV  D22, X4
    FMOV  V22.D[1], X2
    FMOV  D23, X19
    FMOV  V23.D[1], X3
    FMOV  D24, X20
    FMOV  V24.D[1], X8
    FMOV  D25, X24
    FMOV  V25.D[1], X29
    FMOV  D26, X8
    FMOV  V26.D[1], X13
    FMOV  D27, X19
    FMOV  V27.D[1], X10
    FMOV  D28, X17
    FMOV  V28.D[1], X25
    FMOV  D29, X19
    FMOV  V29.D[1], X7
    FMOV  D30, X29
    FMOV  V30.D[1], X8
    FMOV  D31, X3
    FMOV  V31.D[1], X4
    MOVZ  X23, #0xa, LSL #0
TSRTAdvsimdVectorAllOperation_label_16:
    SMULL  V31.4S, V31.4H, V26.4H
    MVN  V29.8B, V30.8B
    FRSQRTS  V12.2D, V28.2D, V23.2D
    MOV B15, V24.B[0x7]
    INS V6.D[0x0], V15.D[0x1]
    UQADD  V24.8B, V29.8B, V20.8B
    SLI  V15.8H, V31.8H, #0xf
    UMLAL2  V22.4S, V15.8H, V27.8H
    SQRDMULH S0, S12, V24.S[0x2]
    SMLSL2 V14.2D, V22.4S, V25.S[0x3]
    UMINV  S6, V14.4S
    FADDP  V19.8H, V0.8H, V0.8H
    SQDMLSL S0, H6, V10.H[0x1]
    FMAXP  V23.2S, V6.2S, V19.2S
    DUP H20, V0.H[0x1]
    DUP V12.4S, W25
    FMAXP H6, V22.2H
    SQRSHRN2 V28.8H, V20.4S, #15
    SADDLP  V20.8H, V12.16B
    URSQRTE  V0.4S, V23.4S
    SLI  V23.4H, V28.4H, #0x0
    ADDHN  V26.4H, V6.4S, V0.4S
    SHL  V14.4S, V26.4S, #0xd
    FDIV  V29.8H, V23.8H, V14.8H
    FMINNMV  H24, V29.4H
    SHLL  V15.4S, V20.4H, #16
    SRHADD  V19.8B, V15.8B, V24.8B
    SADDW2  V28.4S, V30.4S, V24.8H
    SSHLL V25.8H, V7.8B, #0x2
    SXTL V22.2D, V12.2S
    TBL  V0.8B, { V30.16B, V31.16B, V0.16B }, V4.8B
    FCVTAU  V10.8H, V1.8H
    SHL  V27.2S, V0.2S, #0xb
    UCVTF V25.2D, V28.2D, #25
    SQSHRUN V15.4H, V6.4S, #16
    SLI V31.2D, V30.2D, #0x10
    SRI  V4.16B, V5.16B, #5
    FRINTM  V26.2S, V10.2S
    UQSHRN V23.8B, V10.8H, #6
    TBX  V24.16B, { V25.16B, V26.16B, V27.16B }, V19.16B
    FADDP D20, V4.2D
    FABD  V4.4H, V23.4H, V20.4H
    SSUBW  V6.4S, V4.4S, V15.4H
    SRSRA  V1.2S, V8.2S, #8
    FMULX D15, D31, V22.D[0x0]
    UMLAL2  V7.2D, V24.4S, V1.4S
    UMULL2 V4.4S, V15.8H, V15.H[0x4]
    SHL  V12.4S, V6.4S, #0x15
    UHSUB  V28.8H, V12.8H, V29.8H
    MOVI  V5.16B, #0xb8
    FMAXNMP H23, V5.2H
    SCVTF  V31.8H, V7.8H
    XTN2  V0.16B, V28.8H
    FMUL V30.2D, V4.2D, V4.D[0x1]
    SXTL2 V27.8H, V23.16B
    FCVTNU  V7.2D, V0.2D
    FMINNMP  V23.4H, V31.4H, V7.4H
    SQRSHRUN2 V26.16B, V27.8H, #5
    UMLAL V0.2D, V30.2S, V30.S[0x1]
    UQSHRN V1.4H, V23.4S, #8
    SHRN V7.8B, V25.8H, #7
    SSRA  V15.4H, V1.4H, #15
    SSHLL V8.2D, V26.2S, #0x18
    UADDLV  S20, V0.4H
    SRSHR  V23.8B, V31.8B, #3
    SQRDMULH S22, S23, V7.S[0x1]
    RSHRN V28.4H, V10.4S, #9
    SMLSL2 V0.4S, V28.8H, V15.H[0x7]
    SHA1M  Q12, S0, V8.4S
    SRSHL  V31.8H, V12.8H, V20.8H
    MVNI  V4.4H, #0x82, LSL #8
    FCMLT  V6.4H, V4.4H, #0.0
    URHADD  V4.4S, V22.4S, V22.4S
    UMULL  V10.2D, V31.2S, V4.2S
    SXTL2 V28.4S, V10.8H
    FRINTN  V26.8H, V28.8H
    SHA1SU1  V5.4S, V26.4S
    USRA  V30.8B, V5.8B, #2
    SQDMULL2 V26.4S, V30.8H, V6.H[0x0]
    SADDLV  H6, V28.8B
    BIC  V27.8B, V11.8B, V13.8B
    FACGE  V23.4H, V7.4H, V4.4H
    UQSHL  V10.8H, V20.8H, #0x5
    CMGE  V13.8B, V17.8B, #0
    UMULL2 V8.2D, V5.4S, V9.S[0x2]
    FCVTMS  V20.8H, V7.8H
    UMLSL V11.2D, V23.2S, V20.S[0x3]
    TRN1  V0.4S, V18.4S, V13.4S
    MVNI  V12.4H, #0x88, LSL #8
    UXTL2 V4.2D, V5.4S
    SQSHRUN V28.2S, V4.2D, #6
    SRSRA  V31.8B, V27.8B, #3
    ZIP1  V30.8B, V28.8B, V11.8B
    CLZ  V13.8B, V10.8B
    FRINTX  V22.4H, V26.4H
    SQDMLAL V4.4S, V8.4H, V5.H[0x3]
    FCMLT  V26.4H, V13.4H, #0.0
    SHA1P  Q15, S21, V4.4S
    EOR  V27.16B, V30.16B, V22.16B
    SHRN V4.8B, V27.8H, #6
    USHR  V9.2S, V12.2S, #18
    UMLSL2 V12.4S, V0.8H, V0.H[0x5]
    SRSHR  V8.4S, V31.4S, #14
    BIC  V0.8B, V8.8B, V6.8B
    FMIN  V8.4H, V15.4H, V0.4H
    MUL  V22.8H, V8.8H, V9.H[0x0]
    UABDL  V31.2D, V22.2S, V12.2S
    SRI  V12.16B, V4.16B, #7
    SQDMULL2 V6.4S, V12.8H, V12.H[0x1]
    SHL  V10.4H, V26.4H, #0xb
    FMULX S13, S6, V31.S[0x0]
    SQSHLU  V31.8B, V10.8B, #0x2
    SQRSHRN V5.8B, V15.8H, #3
    UQSHRN V4.2S, V13.2D, #24
    FDIV  V30.4H, V31.4H, V27.4H
    SQDMULL2  V27.4S, V5.8H, V4.8H
    FRINTZ  V6.4S, V30.4S
    USRA V12.2D, V27.2D, #36
    ORR  V26.8H, #0xbd
    NOT  V4.16B, V31.16B
    SADALP  V10.2D, V6.4S
    DUP V5.4H, W19
    SQRSHRN2 V11.16B, V26.8H, #1
    FMLS V31.4S, V9.4S, V12.S[0x2]
    SSHL  V6.4H, V12.4H, V31.4H
    FMOV  V22.4H, #-0.23437500
    ADDP  V13.8H, V5.8H, V22.8H
    FCVTAU  V9.4S, V4.4S
    FACGE  V27.8H, V10.8H, V10.8H
    FMAXNMP  V0.4S, V11.4S, V2.4S
    UCVTF  V12.4S, V0.4S
    FMINP D11, V6.2D
    MVNI  V5.8H, #0x6e, LSL #8
    UQSHL  V31.4H, V12.4H, #0x2
    SADDLP  V10.2S, V27.4H
    RADDHN2  V2.16B, V13.8H, V9.8H
    SLI  V13.8B, V31.8B, #0x6
    SMLAL  V6.4S, V13.4H, V10.4H
    USHLL V12.4S, V5.4H, #0x8
    SQDMLAL D31, S2, V2.S[0x1]
    FMINV  S0, V11.4S
    SMLSL  V9.2D, V31.2S, V0.2S
    FNEG  V27.4H, V9.4H
    CMEQ  V5.8H, V12.8H, #0
    SLI  V10.8B, V6.8B, #0x5
    SQRSHRN V13.8B, V27.8H, #1
    FMUL V4.2D, V17.2D, V3.D[0x1]
    FCVTL  V6.2D, V10.2S
    FCVTZU  V10.4H, V6.4H, #15
    UQSHL  V9.16B, V4.16B, #0x0
    UXTL V31.2D, V10.2S
    SSHR  V26.2S, V5.2S, #2
    SQSHL  V22.2S, V18.2S, #0x1c
    FCVTZU V11.2D, V22.2D, #46
    FCMGE  V22.2D, V13.2D, V4.2D
    SMULL2 V0.2D, V9.4S, V11.S[0x3]
    FABD  V11.2S, V31.2S, V12.2S
    FMLS V31.2S, V11.2S, V11.S[0x2]
    FMAXP H4, V8.2H
    UQXTN2  V18.8H, V26.4S
    SSHR  V11.2S, V22.2S, #23
    FADDP  V13.4H, V0.4H, V11.4H
    PMULL  V27.1Q, V4.1D, V13.1D
    SSUBL  V11.4S, V27.4H, V18.4H
    FCMLE  V2.2S, V7.2S, #0.0
    FMUL V10.4S, V31.4S, V31.S[0x3]
    FMLA V8.2D, V11.2D, V2.D[0x0]
    UQSHRN2 V18.4S, V15.2D, #16
    SHA256H  Q27, Q18, V10.4S
    USHLL2 V22.4S, V8.8H, #0xb
    SABA  V18.2S, V22.2S, V27.2S
    FMAXP D9, V22.2D
    SHRN2 V22.4S, V7.2D, #3
    DUP V0.2D, X4
    SADDL  V10.4S, V10.4H, V13.4H
    TBL  V12.16B, { V28.16B, V29.16B }, V21.16B
    URSQRTE  V8.2S, V24.2S
    RADDHN  V2.2S, V13.2D, V10.2D
    TBL  V4.8B, { V10.16B, V11.16B, V12.16B, V13.16B }, V24.8B
    SQDMLAL2 V27.2D, V18.4S, V31.S[0x1]
    SQSHRUN V21.2S, V5.2D, #26
    INS V10.D[0x0], V3.D[0x0]
    SSHLL V7.4S, V10.4H, #0xf
    MOV V13.B[0xa], W19
    UMAXV  B15, V21.8B
    DUP B29, V15.B[0xe]
    UADDLV  S31, V29.4H
    AESMC  V5.16B, V7.16B
    FNEG  V11.2D, V8.2D
    FACGE  V15.8H, V2.8H, V13.8H
    INS V28.S[0x2], W25
    SQDMLSL  V5.4S, V27.4H, V9.4H
    SQRSHRUN2 V13.16B, V0.8H, #8
    MOVI  V24.8B, #0xb1
    SQRSHRN2 V27.4S, V4.2D, #16
    SRSHR  V18.2S, V5.2S, #7
    UQADD  V12.2D, V18.2D, V27.2D
    SRHADD  V2.4S, V22.4S, V12.4S
    TBX  V9.16B, { V31.16B }, V2.16B
    FRSQRTE  V3.4S, V24.4S
    FMINNMP  V18.2S, V28.2S, V9.2S
    SSUBL2  V16.4S, V18.8H, V11.8H
    SADDLV  S0, V13.4H
    SQSHL  V27.2S, V0.2S, #0x1a
    USHL  V22.8B, V27.8B, V27.8B
    MOVI  V11.8B, #0x76
    MVN  V24.16B, V3.16B
    UQRSHRN2 V27.4S, V15.2D, #6
    FCVTAU  V28.8H, V24.8H
    FCMEQ  V2.2S, V28.2S, #0.0
    SSHLL V8.2D, V16.2S, #0x16
    MLA  V9.4H, V8.4H, V2.4H
    SHA1P  Q15, S27, V22.4S
    UQRSHRN V2.8B, V9.8H, #5
    UQXTN  V18.8B, V2.8H
    SQSHRUN V31.8B, V15.8H, #8
    UQRSHRN2 V3.16B, V18.8H, #7
    FRINTM  V18.8H, V3.8H
    SSHLL V24.8H, V31.8B, #0x2
    SSRA V13.2D, V18.2D, #53
    SQDMULH  V31.4H, V24.4H, V11.4H
    UMULL  V12.8H, V13.8B, V31.8B
    FSUB  V11.4S, V25.4S, V26.4S
    UMOV W13, V29.B[0xf]
    MLA  V3.8H, V4.8H, V5.H[0x0]
    SXTL V15.2D, V30.2S
    SADDW2  V26.2D, V23.2D, V23.4S
    SHRN V25.8B, V30.8H, #8
    USHR  V13.16B, V14.16B, #6
    SQSHRUN2 V22.16B, V19.8H, #8
    SADDLP  V23.2S, V13.4H
    UADDW  V29.8H, V10.8H, V22.8B
    USHR  V9.16B, V9.16B, #4
    FMINP H14, V9.2H
    SQDMLSL D10, S12, V14.S[0x1]
    URSHR V13.2D, V15.2D, #42
    UMAX  V31.4H, V29.4H, V3.4H
    FRINTA  V3.8H, V26.8H
    MOVI  V15.2S, #0x3f, MSL #16
    USHR V4.2D, V10.2D, #20
    FNEG  V19.2S, V23.2S
    MOV  V9.16B, V4.16B
    USHLL V10.4S, V13.4H, #0x2
    FRINTP  V13.2S, V10.2S
    CMHS  V26.8B, V13.8B, V13.8B
    MVN  V4.8B, V15.8B
    UADDLV  D22, V25.4S
    UADDW2  V12.2D, V19.2D, V22.4S
    SQRSHRUN V10.2S, V9.2D, #23
    SMAXV  B9, V26.8B
    BIF  V26.8B, V3.8B, V4.8B
    FMINNMP  V14.2S, V11.2S, V12.2S
    FRINTX  V19.4H, V10.4H
    MLS  V10.4H, V9.4H, V14.4H
    SQRDMULH S25, S10, V19.S[0x1]
    CMGE  V30.16B, V25.16B, #0
    SMLAL V13.2D, V26.2S, V31.S[0x2]
    MOVI  V26.8B, #0x64
    SQADD  V3.4S, V13.4S, V30.4S
    SQDMULL2 V30.2D, V26.4S, V3.S[0x0]
    SSHLL2 V14.2D, V21.4S, #0xe
    URSQRTE  V21.2S, V9.2S
    FABS  V25.4S, V6.4S
    DUP V6.4S, W23
    SMLAL2 V15.2D, V7.4S, V28.S[0x1]
    MOV V19.H[0x2], V6.H[0x4]
    SQSHL  V11.8B, V18.8B, #0x0
    SMULL  V12.8H, V13.8B, V8.8B
    ADDP  V31.2S, V30.2S, V6.2S
    UXTL2 V13.8H, V19.16B
    UQSHRN2 V28.16B, V13.8H, #5
    MUL  V6.2S, V15.2S, V1.S[0x1]
    SRSHL  V7.8B, V12.8B, V20.8B
    SQDMULH S15, S4, V9.S[0x2]
    MVN  V10.16B, V9.16B
    SCVTF  V3.2S, V25.2S, #27
    FRINTP  V26.4S, V31.4S
    REV16  V20.16B, V26.16B
    FMAXNMP  V13.4S, V15.4S, V7.4S
    UMINP  V12.8H, V13.8H, V20.8H
    FACGE  V19.2D, V10.2D, V6.2D
    USHLL2 V25.2D, V19.4S, #0x2
    SQSHLU  V18.4S, V25.4S, #0x6
    PMUL  V20.8B, V11.8B, V18.8B
    SQSHRUN V8.8B, V3.8H, #8
    SQSHLU  V9.16B, V28.16B, #0x4
    USHR  V0.4S, V8.4S, #24
    FMULX  V13.4S, V0.4S, V0.4S
    FMINNMV  H30, V13.8H
    FMINNM  V31.2S, V9.2S, V30.2S
    INS V26.D[0x1], V31.D[0x0]
    SHRN2 V19.8H, V21.4S, #14
    INS V25.H[0x7], V12.H[0x4]
    EXT  V8.16B, V26.16B, V26.16B, #0xd
    SRSHR V26.2D, V20.2D, #13
    FRSQRTS  V20.4H, V19.4H, V26.4H
    SLI  V28.8B, V20.8B, #0x6
    SQSHL V15.2D, V8.2D, #0x24
    SSHLL2 V18.4S, V15.8H, #0xf
    SMOV  X28, V28.B[0x6]
    SUBS  X23, X23, #0x1
    B.NE  TSRTAdvsimdVectorAllOperation_label_16
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x9f, LSL #0
    MOVK  X17, #0x800, LSL #16
    MRS  X26, FPSR
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V0.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x41, LSL #0
    FMOV  X26, D0
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V1.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, D1
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V2.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x40ff, LSL #0
    MOVK  X17, #0x40ff, LSL #16
    FMOV  X26, D2
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V3.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x3030, LSL #32
    MOVK  X17, #0x4108, LSL #48
    FMOV  X26, D3
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V4.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xffc0, LSL #16
    MOVK  X17, #0xffc0, LSL #48
    FMOV  X26, D4
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0xc000, LSL #0
    MOVK  X17, #0x2d84, LSL #16
    MOVK  X17, #0x74ea, LSL #32
    MOVK  X17, #0xc509, LSL #48
    FMOV  X26, V5.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x5000, LSL #0
    MOVK  X17, #0x363, LSL #16
    MOVK  X17, #0x7f0a, LSL #32
    MOVK  X17, #0x187, LSL #48
    FMOV  X26, D5
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V6.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, D6
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V7.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, D7
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V8.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, D8
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V9.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, D9
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X26, V10.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0xff00, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X26, D10
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V11.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7fc0, LSL #16
    MOVK  X17, #0x7fc0, LSL #48
    FMOV  X26, D11
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V12.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, D12
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V13.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, D13
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V14.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, D14
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V15.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, D15
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x8000, LSL #32
    FMOV  X26, V16.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, D16
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V17.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, D17
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V18.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, D18
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    FMOV  X26, V19.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, D19
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V20.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x3e00, LSL #0
    MOVK  X17, #0x3e00, LSL #16
    MOVK  X17, #0x3e00, LSL #32
    MOVK  X17, #0x3e00, LSL #48
    FMOV  X26, D20
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V21.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X26, D21
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V22.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x7e7e, LSL #0
    MOVK  X17, #0x7f80, LSL #16
    FMOV  X26, D22
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V23.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x300, LSL #0
    MOVK  X17, #0x603, LSL #32
    FMOV  X26, D23
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x100, LSL #16
    MOVK  X17, #0xf8, LSL #48
    FMOV  X26, V24.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x1d0, LSL #0
    MOVK  X17, #0xf8, LSL #16
    MOVK  X17, #0xc, LSL #32
    FMOV  X26, D24
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V25.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, D25
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V26.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, D26
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X26, V27.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xf800, LSL #16
    FMOV  X26, D27
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V28.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x8000, LSL #0
    MOVK  X17, #0x8000, LSL #16
    MOVK  X17, #0x8000, LSL #32
    MOVK  X17, #0x8000, LSL #48
    FMOV  X26, D28
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0x7fff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X26, V29.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x3030, LSL #32
    MOVK  X17, #0x4108, LSL #48
    FMOV  X26, D29
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V30.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, D30
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V31.D[1]
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, D31
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorAllOperation_TestFail
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
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
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
    FMOV  V0.D[1], X26
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X29
    FMOV  V2.D[1], X16
    FMOV  D3, X23
    FMOV  V3.D[1], X29
    FMOV  D4, X2
    FMOV  V4.D[1], X3
    FMOV  D5, X29
    FMOV  V5.D[1], X6
    FMOV  D6, X28
    FMOV  V6.D[1], X27
    FMOV  D7, X7
    FMOV  V7.D[1], X10
    FMOV  D8, X13
    FMOV  V8.D[1], X4
    FMOV  D9, X3
    FMOV  V9.D[1], X7
    FMOV  D10, X15
    FMOV  V10.D[1], X8
    FMOV  D11, X7
    FMOV  V11.D[1], X24
    FMOV  D12, X24
    FMOV  V12.D[1], X5
    FMOV  D13, X28
    FMOV  V13.D[1], X7
    FMOV  D14, X12
    FMOV  V14.D[1], X5
    FMOV  D15, X29
    FMOV  V15.D[1], X13
    FMOV  D16, X7
    FMOV  V16.D[1], X5
    FMOV  D17, X19
    FMOV  V17.D[1], X19
    FMOV  D18, X9
    FMOV  V18.D[1], X17
    FMOV  D19, X24
    FMOV  V19.D[1], X3
    FMOV  D20, X3
    FMOV  V20.D[1], X22
    FMOV  D21, X10
    FMOV  V21.D[1], X23
    FMOV  D22, X27
    FMOV  V22.D[1], X20
    FMOV  D23, X6
    FMOV  V23.D[1], X19
    FMOV  D24, X9
    FMOV  V24.D[1], X29
    FMOV  D25, X6
    FMOV  V25.D[1], X8
    FMOV  D26, X24
    FMOV  V26.D[1], X28
    FMOV  D27, X22
    FMOV  V27.D[1], X22
    FMOV  D28, X9
    FMOV  V28.D[1], X2
    FMOV  D29, X12
    FMOV  V29.D[1], X3
    FMOV  D30, X9
    FMOV  V30.D[1], X19
    FMOV  D31, X24
    FMOV  V31.D[1], X4
    MOVZ  X23, #0xa, LSL #0
TSRTAdvsimdVectorAllOperation_label_17:
    FCMLT  V23.4H, V24.4H, #0.0
    FADD  V15.4H, V26.4H, V28.4H
    CMGT  V13.2S, V27.2S, #0
    UQXTN2  V25.8H, V30.4S
    SHRN V3.8B, V31.8H, #6
    FMINNMP  V24.8H, V15.8H, V23.8H
    UMULL2 V29.2D, V25.4S, V25.S[0x1]
    SQDMULL2 V12.2D, V13.4S, V13.S[0x3]
    MUL  V24.2S, V3.2S, V21.S[0x3]
    URSHR  V24.16B, V22.16B, #4
    SSHR  V9.4S, V24.4S, #4
    UCVTF  V29.2S, V12.2S
    URSRA  V7.8H, V29.8H, #12
    URSRA  V28.2S, V7.2S, #23
    BIC  V29.4H, #0xe0
    SQDMLSL V7.4S, V28.4H, V9.H[0x6]
    SLI  V24.8B, V7.8B, #0x3
    FCMGT  V7.4H, V24.4H, #0.0
    RSHRN2 V9.16B, V29.8H, #3
    UQRSHRN V7.4H, V9.4S, #13
    UMAXP  V23.4H, V29.4H, V21.4H
    SADDLV  H3, V28.16B
    SMLAL2  V12.8H, V7.16B, V11.16B
    SABAL2  V24.2D, V7.4S, V2.4S
    UADDLV  S31, V25.8H
    FCVTXN  V25.2S, V11.2D
    UQSHRN2 V22.16B, V21.8H, #8
    SMLAL2 V21.4S, V16.8H, V0.H[0x5]
    FMAXNMP  V9.2S, V21.2S, V19.2S
    ADDHN2  V15.8H, V9.4S, V23.4S
    MOVI  V19.2D, #18374967954631622400
    TBL  V9.8B, { V18.16B, V19.16B, V20.16B, V21.16B }, V14.8B
    SABA  V21.2S, V24.2S, V4.2S
    BIT  V28.8B, V12.8B, V22.8B
    SQRDMULH  V29.4H, V22.4H, V10.H[0x3]
    SQDMULH S2, S15, V15.S[0x1]
    SQDMULH H22, H16, V0.H[0x5]
    SSUBW  V7.4S, V9.4S, V10.4H
    SADDW2  V9.8H, V25.8H, V6.16B
    SMINV  H25, V22.8H
    UADDLV  D23, V9.4S
    UABDL  V20.8H, V28.8B, V29.8B
    SQRDMULH S28, S3, V21.S[0x2]
    SMLAL2 V9.2D, V31.4S, V20.S[0x0]
    SRSHL  V24.2D, V23.2D, V7.2D
    CMGE  V12.4S, V2.4S, V24.4S
    FCVTNS  V31.4S, V28.4S
    UABDL  V2.4S, V31.4H, V25.4H
    PMULL  V11.1Q, V2.1D, V12.1D
    FDIV  V20.4H, V11.4H, V11.4H
    USHLL V11.4S, V20.4H, #0x2
    CMHI  V0.2S, V11.2S, V9.2S
    UMULL2  V9.8H, V24.16B, V5.16B
    UXTL2 V28.4S, V11.8H
    DUP V15.16B, W25
    FCVTMS  V5.4H, V8.4H
    FNEG  V19.2D, V4.2D
    TBX  V21.16B, { V0.16B }, V17.16B
    UMLSL2 V22.4S, V26.8H, V6.H[0x3]
    UADDW  V24.2D, V22.2D, V17.2S
    UMOV X29, V29.D[0x0]
    FMLS  V11.4H, V24.4H, V12.4H
    UQXTN2  V25.8H, V10.4S
    CMLE  V12.2D, V18.2D, #0
    NEG  V8.8B, V11.8B
    SADDW2  V20.8H, V15.8H, V19.16B
    SQRSHRUN V0.8B, V9.8H, #6
    AESE  V24.16B, V0.16B
    FMLA  V9.4H, V24.4H, V8.4H
    FCVTL  V22.4S, V9.4H
    FACGT  V18.4H, V28.4H, V21.4H
    CMEQ  V19.4H, V25.4H, V12.4H
    UXTL V6.4S, V5.4H
    BIT  V12.8B, V19.8B, V6.8B
    XTN  V5.8B, V20.8H
    SHA256H  Q17, Q21, V22.4S
    SQDMLAL  V29.4S, V5.4H, V17.4H
    SHLL2  V11.2D, V18.4S, #32
    FMAXV  H4, V11.4H
    FCMEQ  V8.4H, V4.4H, V4.4H
    UABD  V22.16B, V8.16B, V8.16B
    SMLAL2  V20.8H, V29.16B, V22.16B
    FRSQRTS  V17.2S, V12.2S, V20.2S
    SRSRA  V0.2S, V0.2S, #22
    SHRN2 V19.16B, V25.8H, #6
    SQRDMULH  V9.4H, V25.4H, V8.H[0x4]
    SQSHL  V29.4S, V28.4S, #0x2
    SRSHR  V12.4S, V24.4S, #29
    RSHRN2 V6.16B, V2.8H, #4
    SABDL2  V2.4S, V8.8H, V10.8H
    SMULL2 V24.4S, V13.8H, V10.H[0x0]
    SHLL2  V15.8H, V2.16B, #8
    SHA1SU1  V10.4S, V0.4S
    USHR  V25.2S, V19.2S, #22
    UQXTN2  V0.16B, V25.8H
    FMULX  V20.2D, V28.2D, V10.2D
    UXTL2 V5.8H, V9.16B
    CMGE  V22.4S, V0.4S, V12.4S
    SQDMLSL V4.2D, V5.2S, V22.S[0x3]
    USRA  V22.4H, V4.4H, #3
    FMULX S4, S29, V24.S[0x2]
    RADDHN2  V18.8H, V4.4S, V15.4S
    ADDP  D25, V4.2D
    FCMEQ  V4.2S, V6.2S, #0.0
    FADD  V29.4H, V20.4H, V18.4H
    SQRSHRUN2 V19.16B, V29.8H, #5
    ADDP  V15.4H, V19.4H, V25.4H
    SQRDMULH S24, S15, V15.S[0x1]
    MVNI  V2.4S, #0xb8, LSL #8
    SQDMLAL V15.4S, V4.4H, V1.H[0x2]
    FMULX  V5.8H, V15.8H, V24.8H
    INS V6.D[0x0], V22.D[0x1]
    FRINTN  V9.8H, V6.8H
    FMULX D25, D2, V2.D[0x0]
    SQRSHL  V0.8H, V5.8H, V25.8H
    FMIN  V1.4S, V0.4S, V0.4S
    REV64  V22.16B, V9.16B
    SRSHL  V2.8B, V1.8B, V22.8B
    UMAXV  H1, V26.8H
    UQXTN  V26.4H, V30.4S
    UMAXV  S4, V13.4S
    UMIN  V22.2S, V30.2S, V18.2S
    UQXTN  V5.4H, V14.4S
    SQDMLAL2  V15.4S, V14.8H, V11.8H
    EOR  V25.8B, V17.8B, V27.8B
    SQRSHRUN V9.8B, V8.8H, #3
    MOV V13.S[0x3], W9
    BIF  V8.8B, V25.8B, V4.8B
    MVNI  V24.2S, #0x85, MSL #8
    USHLL2 V4.8H, V5.16B, #0x4
    UXTL2 V5.4S, V8.8H
    UCVTF  V27.4H, V4.4H, #11
    SQDMLAL S6, H27, V4.H[0x5]
    UQSHRN V27.4H, V24.4S, #16
    FMAXP D17, V5.2D
    SHLL2  V5.4S, V6.8H, #16
    URSRA  V8.4S, V4.4S, #16
    SQDMULL V0.4S, V26.4H, V15.H[0x6]
    SHRN2 V4.8H, V5.4S, #13
    FRINTI  V5.2S, V0.2S
    SRSHR  V6.8H, V22.8H, #7
    UADDLV  H0, V27.8B
    FMINNMP D27, V8.2D
    SMOV  X8, V5.H[0x4]
    UCVTF  V22.2S, V17.2S, #1
    FMINV  H25, V2.4H
    MOVI  V26.16B, #0x47
    SSHLL V2.2D, V22.2S, #0xa
    SSUBW  V22.8H, V2.8H, V2.8B
    FNEG  V15.4H, V25.4H
    SMULL2  V14.2D, V4.4S, V0.4S
    USRA  V25.4H, V6.4H, #10
    UMLSL V5.4S, V26.4H, V9.H[0x0]
    UQSUB  V6.4H, V22.4H, V22.4H
    UMLSL2 V2.4S, V27.8H, V1.H[0x2]
    FACGT  V1.8H, V6.8H, V25.8H
    FMLA V27.2D, V1.2D, V1.D[0x1]
    SQSHRN V8.4H, V5.4S, #6
    UMIN  V4.2S, V15.2S, V8.2S
    UMOV W9, V27.S[0x1]
    SQDMULL S8, H2, V4.H[0x1]
    SQXTN2  V5.8H, V14.4S
    SQSHLU  V1.8B, V8.8B, #0x4
    FRSQRTE  V17.4H, V1.4H
    ADDV  S26, V17.4S
    FRINTA  V22.8H, V26.8H
    FADD  V15.8H, V22.8H, V22.8H
    SQRSHRN2 V27.4S, V15.2D, #22
    FCVTZU  V9.4S, V5.4S
    FMUL H22, H27, V15.H[0x1]
    FRINTA  V1.4S, V9.4S
    FMLA V26.2S, V3.2S, V22.S[0x2]
    SCVTF  V25.8H, V1.8H
    SQSHRUN2 V2.16B, V26.8H, #7
    FCVTAS  V22.2S, V25.2S
    SHA256SU1  V26.4S, V22.4S, V2.4S
    UMIN  V3.4H, V28.4H, V31.4H
    FMULX  V4.4H, V6.4H, V10.4H
    FMULX  V1.4H, V2.4H, V25.4H
    SQSHL  V5.2S, V8.2S, #0x16
    FRECPE  V22.8H, V26.8H
    TRN2  V15.8B, V17.8B, V30.8B
    TBX  V8.16B, { V10.16B }, V13.16B
    FRINTM  V31.2D, V9.2D
    FRINTZ  V30.2D, V9.2D
    UMULL  V6.2D, V30.2S, V20.2S
    URSHR V17.2D, V6.2D, #25
    FCVTPU  V27.2D, V5.2D
    SCVTF  V5.8H, V15.8H
    SQRSHRN2 V28.16B, V31.8H, #3
    SQSHLU  V26.4S, V3.4S, #0xb
    UCVTF  V3.4H, V28.4H
    TBL  V2.8B, { V6.16B, V7.16B }, V17.8B
    FCVTMS  V17.2S, V31.2S
    FCVTNS  V9.4H, V2.4H
    SUBHN  V28.8B, V9.8H, V5.8H
    UZP1  V9.4S, V23.4S, V8.4S
    FMULX V2.2D, V17.2D, V17.D[0x0]
    UADDL  V17.8H, V3.8B, V4.8B
    UMLAL V10.2D, V27.2S, V28.S[0x3]
    UQSHRN2 V3.4S, V1.2D, #29
    CMGT  V15.4S, V26.4S, V22.4S
    SQSHLU  V13.4H, V9.4H, #0xe
    FRINTZ  V7.4H, V15.4H
    USRA  V6.16B, V2.16B, #6
    SSHLL2 V20.4S, V7.8H, #0x4
    UADDLV  H1, V20.8B
    RSUBHN  V25.4H, V3.4S, V17.4S
    SQSHRUN2 V27.8H, V25.4S, #16
    SRHADD  V31.8B, V30.8B, V1.8B
    FRINTI  V26.4H, V10.4H
    URHADD  V31.8B, V26.8B, V27.8B
    SRSRA V23.2D, V18.2D, #18
    FADDP H22, V11.2H
    FMLS D5, D13, V22.D[0x0]
    SMLAL V18.4S, V5.4H, V6.H[0x0]
    UXTL2 V1.2D, V5.4S
    SADDL2  V13.4S, V23.8H, V1.8H
    UMOV W27, V18.S[0x1]
    FMULX V30.2D, V13.2D, V13.D[0x1]
    UQSHRN V5.4H, V31.4S, #7
    TBX  V27.8B, { V22.16B, V23.16B }, V30.8B
    SRI V13.2D, V5.2D, #63
    MOV V6.B[0xb], W19
    SSHR  V11.8B, V27.8B, #1
    UMLSL2  V18.8H, V13.16B, V13.16B
    SABDL2  V27.8H, V18.16B, V6.16B
    CMGT  V31.4S, V27.4S, #0
    SABDL2  V25.2D, V11.4S, V11.4S
    SQSHLU  V23.4S, V25.4S, #0x17
    DUP S5, V22.S[0x0]
    FMAXNMP S22, V31.2S
    SQRDMULH  V30.2S, V22.2S, V14.S[0x1]
    FACGE  V1.8H, V23.8H, V30.8H
    UHSUB  V25.8B, V1.8B, V5.8B
    FMAXNM  V13.2S, V17.2S, V25.2S
    SHA256H2  Q14, Q13, V10.4S
    SRI V13.2D, V5.2D, #43
    UABDL2  V5.2D, V23.4S, V11.4S
    UCVTF  V10.8H, V17.8H
    SHL  V1.2S, V31.2S, #0x12
    ADDV  B18, V25.16B
    FMUL H23, H2, V6.H[0x3]
    MOV D30, V31.D[0x0]
    SRI  V11.16B, V2.16B, #2
    SSRA V30.2D, V14.2D, #49
    MOV H27, V18.H[0x2]
    USRA  V2.16B, V30.16B, #4
    SMAXP  V17.8B, V5.8B, V13.8B
    URHADD  V22.16B, V17.16B, V10.16B
    UXTL2 V25.4S, V1.8H
    FMUL  V6.4H, V27.4H, V23.4H
    SSHR  V27.8H, V11.8H, #14
    FMUL  V10.4S, V6.4S, V25.4S
    URSHL  V6.8H, V2.8H, V22.8H
    TBX  V31.16B, { V27.16B }, V10.16B
    SHA256H2  Q2, Q6, V6.4S
    SMINV  H14, V31.8H
    SQDMLSL2  V18.4S, V2.8H, V2.8H
    UQXTN  V2.8B, V14.8H
    FCMGE  V14.8H, V2.8H, V10.8H
    FCVTZU  V24.4H, V14.4H, #7
    SQDMULL V27.2D, V18.2S, V18.S[0x2]
    FRINTA  V1.2D, V24.2D
    SSHR  V23.4H, V27.4H, #12
    ADDV  H11, V17.8H
    SHSUB  V14.4S, V11.4S, V1.4S
    FMAXNMP D10, V14.2D
    SQRSHRN2 V22.16B, V11.8H, #7
    FRSQRTS  V24.8H, V10.8H, V10.8H
    UADDW  V18.2D, V23.2D, V24.2S
    BIC  V23.16B, V18.16B, V18.16B
    MOV V10.S[0x0], V22.S[0x3]
    SHLL2  V14.2D, V10.4S, #32
    SRSRA  V13.16B, V23.16B, #6
    SMAXP  V6.8H, V13.8H, V11.8H
    SSHR V2.2D, V6.2D, #62
    FMINNMP S6, V14.2S
    SQSHL  V24.16B, V2.16B, #0x4
    FMLA V18.2D, V6.2D, V6.D[0x0]
    UMULL V22.4S, V24.4H, V7.H[0x6]
    UQSHRN2 V31.16B, V22.8H, #5
    FCVTMU  V7.8H, V31.8H
    ORR  V1.4H, #0xcd, LSL #8
    FRINTI  V14.4S, V7.4S
    UQRSHRN V23.4H, V1.4S, #4
    USUBL2  V24.8H, V18.16B, V18.16B
    SSHL  V22.16B, V14.16B, V24.16B
    FSQRT  V14.2S, V23.2S
    FMLS S31, S14, V22.S[0x0]
    FRINTI  V11.4S, V2.4S
    SQSHL  V6.2S, V15.2S, #0x1e
    SHA256SU0  V23.4S, V10.4S
    MOV V13.S[0x3], V15.S[0x0]
    ORR  V2.8H, #0x50
    TBL  V14.8B, { V0.16B, V1.16B, V2.16B }, V4.8B
    SQDMULH  V2.4H, V6.4H, V28.4H
    SQDMLSL V1.4S, V1.4H, V15.H[0x5]
    SQDMULH  V10.2S, V20.2S, V12.S[0x2]
    FMLS V20.2D, V14.2D, V2.D[0x1]
    SUBS  X23, X23, #0x1
    B.NE  TSRTAdvsimdVectorAllOperation_label_17
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X4, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X4, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X4, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X4, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X4, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X4, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X4, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X4, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X4, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X4, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X4, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X4, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X4, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x9f, LSL #0
    MOVK  X15, #0x800, LSL #16
    MRS  X4, FPSR
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, V0.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x3fc, LSL #0
    FMOV  X4, D0
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, V1.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0xcd00, LSL #0
    MOVK  X15, #0xcd00, LSL #16
    MOVK  X15, #0xcd00, LSL #32
    MOVK  X15, #0xcd00, LSL #48
    FMOV  X4, D1
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, V2.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xec6c, LSL #16
    FMOV  X4, D2
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, V3.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x7bc0, LSL #0
    MOVK  X15, #0x3c00, LSL #32
    FMOV  X4, D3
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, V4.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, D4
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, V5.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, D5
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, V6.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc000, LSL #16
    FMOV  X4, D6
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, V7.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, D7
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, V8.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, D8
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, V9.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, D9
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, V10.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, D10
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, V11.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, D11
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x3, LSL #0
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X4, V12.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x3, LSL #0
    MOVK  X15, #0x3, LSL #32
    FMOV  X4, D12
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X4, V13.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7f60, LSL #16
    MOVK  X15, #0x7f7f, LSL #32
    MOVK  X15, #0x7f7f, LSL #48
    FMOV  X4, D13
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, V14.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0xfcfc, LSL #0
    MOVK  X15, #0xfcfc, LSL #16
    MOVK  X15, #0xfcfc, LSL #32
    MOVK  X15, #0xfcfc, LSL #48
    FMOV  X4, D14
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, V15.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    FMOV  X4, D15
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X4, V16.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X4, D16
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, V17.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7f00, LSL #32
    MOVK  X15, #0x7f7f, LSL #48
    FMOV  X4, D17
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, V18.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, D18
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, V19.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, D19
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #48
    FMOV  X4, V20.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, D20
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X4, V21.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0x7ff, LSL #32
    MOVK  X15, #0x707, LSL #48
    FMOV  X4, D21
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, V22.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, D22
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, V23.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    FMOV  X4, D23
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, V24.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, D24
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, V25.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, D25
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, V26.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, D26
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x8800, LSL #0
    MOVK  X15, #0xa936, LSL #16
    MOVK  X15, #0x61e4, LSL #32
    MOVK  X15, #0x2919, LSL #48
    FMOV  X4, V27.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x86a0, LSL #0
    MOVK  X15, #0xbcef, LSL #16
    MOVK  X15, #0xb1, LSL #32
    MOVK  X15, #0x1f1, LSL #48
    FMOV  X4, D27
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, V28.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0xa88c, LSL #0
    MOVK  X15, #0x2727, LSL #16
    FMOV  X4, D28
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, V29.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, D29
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, V30.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x3fbf, LSL #0
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X4, D30
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X4, V31.D[1]
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0x7fff, LSL #16
    FMOV  X4, D31
    SUB  X3, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X2, #0xee82, LSL #0
    MOVK  X2, #0x2a09, LSL #16
    MOVK  X2, #0x7d1a, LSL #32
    MOVK  X2, #0xc286, LSL #48
    MOVZ  X3, #0x57f0, LSL #0
    MOVK  X3, #0xc4d8, LSL #16
    MOVK  X3, #0xfd2f, LSL #32
    MOVK  X3, #0xa794, LSL #48
    MOVZ  X4, #0x2e54, LSL #0
    MOVK  X4, #0x865, LSL #16
    MOVK  X4, #0xb074, LSL #32
    MOVK  X4, #0xa627, LSL #48
    MOVZ  X5, #0x6cb6, LSL #0
    MOVK  X5, #0x92b1, LSL #16
    MOVK  X5, #0xd7e6, LSL #32
    MOVK  X5, #0xdc12, LSL #48
    MOVZ  X6, #0xea50, LSL #0
    MOVK  X6, #0xe7ba, LSL #16
    MOVK  X6, #0xea3a, LSL #32
    MOVK  X6, #0x3175, LSL #48
    MOVZ  X7, #0xa5b5, LSL #0
    MOVK  X7, #0xbf46, LSL #16
    MOVK  X7, #0xd4e2, LSL #32
    MOVK  X7, #0xf0a0, LSL #48
    MOVZ  X8, #0x7eac, LSL #0
    MOVK  X8, #0x1a8a, LSL #16
    MOVK  X8, #0x2bb, LSL #32
    MOVK  X8, #0xc09d, LSL #48
    MOVZ  X9, #0x75d3, LSL #0
    MOVK  X9, #0x878c, LSL #16
    MOVK  X9, #0xb178, LSL #32
    MOVK  X9, #0x79ae, LSL #48
    MOVZ  X10, #0x7ef6, LSL #0
    MOVK  X10, #0xe253, LSL #16
    MOVK  X10, #0x5e8f, LSL #32
    MOVK  X10, #0x65f5, LSL #48
    MOVZ  X12, #0xceb1, LSL #0
    MOVK  X12, #0x70e2, LSL #16
    MOVK  X12, #0x6061, LSL #32
    MOVK  X12, #0x245a, LSL #48
    MOVZ  X13, #0xde55, LSL #0
    MOVK  X13, #0x4070, LSL #16
    MOVK  X13, #0x356e, LSL #32
    MOVK  X13, #0x27ed, LSL #48
    MOVZ  X15, #0xb670, LSL #0
    MOVK  X15, #0xf993, LSL #16
    MOVK  X15, #0x73b7, LSL #32
    MOVK  X15, #0x3d97, LSL #48
    MOVZ  X16, #0xd116, LSL #0
    MOVK  X16, #0x1729, LSL #16
    MOVK  X16, #0x7b95, LSL #32
    MOVK  X16, #0x44fb, LSL #48
    MOVZ  X17, #0xcaf3, LSL #0
    MOVK  X17, #0xfade, LSL #16
    MOVK  X17, #0x63e9, LSL #32
    MOVK  X17, #0x1ba3, LSL #48
    MOVZ  X19, #0xb52b, LSL #0
    MOVK  X19, #0x988, LSL #16
    MOVK  X19, #0xfe68, LSL #32
    MOVK  X19, #0x7af2, LSL #48
    MOVZ  X20, #0xd305, LSL #0
    MOVK  X20, #0x9752, LSL #16
    MOVK  X20, #0xa873, LSL #32
    MOVK  X20, #0xe070, LSL #48
    MOVZ  X22, #0x3cb, LSL #0
    MOVK  X22, #0xef93, LSL #16
    MOVK  X22, #0xdf3, LSL #32
    MOVK  X22, #0x528a, LSL #48
    MOVZ  X23, #0x9a9c, LSL #0
    MOVK  X23, #0xd30d, LSL #16
    MOVK  X23, #0x9acd, LSL #32
    MOVK  X23, #0x9502, LSL #48
    MOVZ  X24, #0xd2a5, LSL #0
    MOVK  X24, #0x56c8, LSL #16
    MOVK  X24, #0x7093, LSL #32
    MOVK  X24, #0x9625, LSL #48
    MOVZ  X25, #0xca40, LSL #0
    MOVK  X25, #0xa015, LSL #16
    MOVK  X25, #0x16c, LSL #32
    MOVK  X25, #0xf9fe, LSL #48
    MOVZ  X26, #0xd42c, LSL #0
    MOVK  X26, #0x3293, LSL #16
    MOVK  X26, #0x3e36, LSL #32
    MOVK  X26, #0x533b, LSL #48
    MOVZ  X27, #0x657e, LSL #0
    MOVK  X27, #0x673d, LSL #16
    MOVK  X27, #0x810d, LSL #32
    MOVK  X27, #0xe0b4, LSL #48
    MOVZ  X28, #0x60b8, LSL #0
    MOVK  X28, #0x1c13, LSL #16
    MOVK  X28, #0x9df5, LSL #32
    MOVK  X28, #0x4474, LSL #48
    MOVZ  X29, #0x4cc2, LSL #0
    MOVK  X29, #0x4d94, LSL #16
    MOVK  X29, #0xce4b, LSL #32
    MOVK  X29, #0x6280, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X29
    FMOV  D1, X28
    FMOV  V1.D[1], X25
    FMOV  D2, X27
    FMOV  V2.D[1], X24
    FMOV  D3, X20
    FMOV  V3.D[1], X29
    FMOV  D4, X13
    FMOV  V4.D[1], X23
    FMOV  D5, X7
    FMOV  V5.D[1], X3
    FMOV  D6, X3
    FMOV  V6.D[1], X19
    FMOV  D7, X24
    FMOV  V7.D[1], X16
    FMOV  D8, X29
    FMOV  V8.D[1], X24
    FMOV  D9, X17
    FMOV  V9.D[1], X25
    FMOV  D10, X19
    FMOV  V10.D[1], X3
    FMOV  D11, X23
    FMOV  V11.D[1], X24
    FMOV  D12, X22
    FMOV  V12.D[1], X27
    FMOV  D13, X25
    FMOV  V13.D[1], X24
    FMOV  D14, X27
    FMOV  V14.D[1], X8
    FMOV  D15, X17
    FMOV  V15.D[1], X13
    FMOV  D16, X10
    FMOV  V16.D[1], X16
    FMOV  D17, X9
    FMOV  V17.D[1], X5
    FMOV  D18, X17
    FMOV  V18.D[1], X20
    FMOV  D19, X19
    FMOV  V19.D[1], X2
    FMOV  D20, X29
    FMOV  V20.D[1], X4
    FMOV  D21, X27
    FMOV  V21.D[1], X17
    FMOV  D22, X22
    FMOV  V22.D[1], X4
    FMOV  D23, X6
    FMOV  V23.D[1], X6
    FMOV  D24, X23
    FMOV  V24.D[1], X26
    FMOV  D25, X27
    FMOV  V25.D[1], X3
    FMOV  D26, X23
    FMOV  V26.D[1], X4
    FMOV  D27, X10
    FMOV  V27.D[1], X12
    FMOV  D28, X27
    FMOV  V28.D[1], X24
    FMOV  D29, X13
    FMOV  V29.D[1], X7
    FMOV  D30, X22
    FMOV  V30.D[1], X23
    FMOV  D31, X5
    FMOV  V31.D[1], X2
    MOVZ  X6, #0xa, LSL #0
TSRTAdvsimdVectorAllOperation_label_18:
    UCVTF V5.2D, V28.2D, #17
    SQNEG  V24.4S, V27.4S
    SQRSHRUN V23.2S, V21.2D, #29
    SMULL2 V28.4S, V26.8H, V6.H[0x2]
    INS V7.S[0x3], W24
    SSRA  V25.16B, V29.16B, #1
    SQSHLU  V23.8H, V24.8H, #0x0
    SHL  V6.16B, V31.16B, #0x0
    FMLS D28, D6, V30.D[0x0]
    CMLE  V30.4S, V5.4S, #0
    MOV V17.H[0x2], W6
    SHA256H2  Q6, Q17, V25.4S
    CMLT  V13.2D, V28.2D, #0
    FMULX H5, H30, V6.H[0x7]
    SQDMULL2 V31.2D, V13.4S, V7.S[0x1]
    CMEQ  V23.4S, V23.4S, #0
    SHRN2 V14.8H, V23.4S, #5
    USHLL V23.8H, V14.8B, #0x4
    FCMGE  V7.2D, V5.2D, V31.2D
    FACGE  V8.2S, V23.2S, V23.2S
    RSHRN V6.4H, V7.4S, #15
    SCVTF  V30.2S, V15.2S, #2
    TBL  V25.16B, { V17.16B, V18.16B }, V8.16B
    UQSHRN2 V29.16B, V25.8H, #2
    SQDMLSL2 V26.2D, V6.4S, V29.S[0x2]
    TBL  V25.8B, { V30.16B }, V26.8B
    SABA  V26.4H, V26.4H, V7.4H
    FRSQRTE  V28.2S, V20.2S
    SQSHRN V20.4H, V14.4S, #2
    MOV V24.B[0x7], W2
    SRI  V15.8H, V11.8H, #6
    FCVTZU V7.2D, V10.2D, #52
    DUP V23.2D, V28.D[0x0]
    FMAXNM  V6.4H, V16.4H, V16.4H
    MLA  V28.4H, V10.4H, V11.H[0x2]
    FACGT  V17.8H, V28.8H, V0.8H
    FMINNM  V18.4H, V6.4H, V6.4H
    SQDMULL D16, S17, V26.S[0x2]
    FMUL  V17.8H, V20.8H, V18.8H
    SQXTN2  V11.8H, V24.4S
    USHR  V29.8B, V25.8B, #4
    FRINTA  V13.2D, V15.2D
    SQSHRUN V10.8B, V7.8H, #6
    SHA1C  Q25, S23, V10.4S
    FCVTZS V15.2D, V11.2D, #48
    FCVTZU  V30.8H, V16.8H, #15
    FADDP H16, V30.2H
    ZIP2  V23.16B, V16.16B, V13.16B
    SUBHN2  V28.16B, V15.8H, V17.8H
    FCMEQ  V0.2S, V23.2S, #0.0
    MUL  V20.4H, V1.4H, V0.H[0x2]
    AESMC  V1.16B, V20.16B
    SCVTF  V26.8H, V25.8H, #4
    EXT  V10.8B, V28.8B, V28.8B, #0x6
    SQSHL  V20.8B, V29.8B, #0x3
    FMULX  V14.2D, V1.2D, V1.2D
    USUBL  V18.4S, V26.4H, V26.4H
    XTN2  V16.8H, V20.4S
    URSHL  V25.2D, V16.2D, V18.2D
    SRI  V7.16B, V10.16B, #1
    SHSUB  V29.16B, V7.16B, V27.16B
    SCVTF  V1.2S, V29.2S, #22
    FCMEQ  V18.8H, V14.8H, V1.8H
    SMLSL V14.4S, V25.4H, V1.H[0x4]
    SQSHLU V10.2D, V14.2D, #0x8
    FCVTZU  V6.4H, V22.4H, #5
    UCVTF V23.2D, V6.2D, #25
    UMLSL  V1.4S, V18.4H, V23.4H
    REV16  V7.16B, V1.16B
    USHL  V26.8B, V10.8B, V7.8B
    SLI  V28.16B, V0.16B, #0x1
    UABAL  V10.8H, V12.8B, V25.8B
    SQXTN  V20.2S, V9.2D
    MOV V6.H[0x2], W24
    SQSHL  V16.4S, V2.4S, #0x9
    UQSHRN V17.8B, V22.8H, #8
    SQDMULH  V15.4H, V14.4H, V15.H[0x2]
    UMULL  V18.8H, V26.8B, V8.8B
    BIC  V7.16B, V30.16B, V30.16B
    SHA1M  Q14, S28, V7.4S
    SRSRA  V7.8B, V20.8B, #7
    SRSHL  V25.4H, V6.4H, V17.4H
    UMLSL  V9.4S, V18.4H, V10.4H
    URSRA V2.2D, V22.2D, #63
    FCVTZS V12.2D, V25.2D, #56
    UADDLV  S28, V12.8H
    SQSHLU V0.2D, V9.2D, #0x23
    CMTST  V26.2D, V18.2D, V7.2D
    SQDMLSL D9, S2, V16.S[0x0]
    UMINP  V29.4H, V9.4H, V9.4H
    URSRA V2.2D, V14.2D, #58
    FMINP D14, V28.2D
    SXTL2 V8.2D, V15.4S
    SRHADD  V17.8H, V8.8H, V15.8H
    FMUL V22.8H, V26.8H, V2.H[0x2]
    SRSHR  V9.16B, V22.16B, #7
    URSRA  V25.4S, V0.4S, #18
    FMAX  V15.4S, V29.4S, V9.4S
    UMINV  H22, V17.4H
    SXTL V29.8H, V14.8B
    FMINV  H10, V25.8H
    FMINNMP  V12.8H, V10.8H, V22.8H
    FMULX D25, D29, V12.D[0x0]
    SSHLL V0.4S, V15.4H, #0x2
    SQRSHRN V17.4H, V0.4S, #1
    SADDW  V10.4S, V25.4S, V25.4H
    UMOV X23, V17.D[0x1]
    UADDLV  D8, V7.4S
    SQDMLAL V26.4S, V3.4H, V9.H[0x0]
    FMAXP S14, V10.2S
    SQSHLU  V25.8H, V14.8H, #0x2
    UXTL V2.2D, V12.2S
    FMAXP D18, V29.2D
    FRSQRTE  V12.4H, V4.4H
    SHLL2  V4.2D, V5.4S, #32
    UZP2  V7.4H, V28.4H, V14.4H
    INS V0.H[0x3], W19
    MOV V22.H[0x5], V0.H[0x4]
    SQDMLSL2  V10.2D, V18.4S, V22.4S
    SQRSHRN V19.4H, V26.4S, #6
    SHLL  V14.4S, V2.4H, #16
    FNEG  V30.4H, V8.4H
    FCVTNU  V9.2S, V10.2S
    UMINV  S18, V9.4S
    SUB  V15.16B, V14.16B, V25.16B
    URSHR V26.2D, V7.2D, #57
    MLS  V17.4H, V12.4H, V12.H[0x4]
    FCVTMU  V3.4H, V15.4H
    SQSHRUN2 V5.16B, V17.8H, #5
    FRINTZ  V9.8H, V30.8H
    UCVTF  V0.4H, V26.4H
    FMAX  V22.4S, V4.4S, V19.4S
    UADDL  V29.8H, V5.8B, V5.8B
    RSHRN V28.4H, V3.4S, #3
    UQRSHRN2 V30.8H, V29.4S, #2
    FCVTPS  V14.2D, V22.2D
    AESD  V15.16B, V14.16B
    SSRA  V12.16B, V18.16B, #1
    FCMGE  V19.2D, V12.2D, #0.0
    MOV B1, V9.B[0x3]
    FMULX D2, D30, V24.D[0x0]
    UMLSL V12.4S, V0.4H, V0.H[0x7]
    UQSHRN V18.2S, V12.2D, #28
    FCVTPU  V4.8H, V19.8H
    CMLE  V25.2S, V28.2S, #0
    USUBL  V9.4S, V25.4H, V15.4H
    FCMGE  V17.4S, V1.4S, #0.0
    SSHLL V25.2D, V2.2S, #0x16
    UMIN  V12.2S, V25.2S, V18.2S
    SQABS  V7.2S, V12.2S
    SQXTUN2  V12.8H, V7.4S
    UQSHL  V0.2S, V9.2S, #0x11
    UMLSL V14.4S, V4.4H, V0.H[0x4]
    INS V30.D[0x0], X29
    SQDMLAL S22, H17, V14.H[0x4]
    FCVTXN  V0.2S, V30.2D
    FRSQRTE  V30.2S, V0.2S
    RADDHN2  V14.16B, V12.8H, V22.8H
    UHADD  V25.8H, V30.8H, V30.8H
    FCVTZS  V0.8H, V25.8H, #16
    SCVTF  V25.8H, V14.8H
    FMAXNM  V17.8H, V0.8H, V0.8H
    SUQADD  V28.2D, V25.2D
    UMOV W23, V17.S[0x2]
    SMLAL  V30.2D, V11.2S, V19.2S
    FMIN  V24.4S, V22.4S, V9.4S
    USUBL  V14.2D, V20.2S, V18.2S
    SMINV  B0, V17.8B
    SQSHRUN V4.8B, V28.8H, #2
    SRI  V28.16B, V19.16B, #1
    MUL  V12.8H, V31.8H, V2.8H
    SQRSHRN2 V20.8H, V1.4S, #12
    FCMGE  V11.2S, V0.2S, V10.2S
    FCMGE  V1.2D, V4.2D, #0.0
    UMLAL2 V18.4S, V1.8H, V8.H[0x1]
    FMINV  S8, V6.4S
    FMAXP  V22.8H, V28.8H, V4.8H
    URECPE  V7.2S, V20.2S
    SHRN2 V17.16B, V8.8H, #7
    SSRA  V26.8B, V7.8B, #1
    ZIP1  V19.2S, V22.2S, V22.2S
    SADDLP  V0.4S, V30.8H
    FCVTZS V8.2D, V11.2D, #3
    SHRN V9.2S, V11.2D, #17
    FDIV  V2.4S, V14.4S, V19.4S
    FMULX V7.8H, V8.8H, V1.H[0x3]
    SMOV W9, V0.B[0xe]
    INS V4.H[0x7], V17.H[0x0]
    FACGT  V10.4S, V7.4S, V12.4S
    MOVI  V6.2S, #0x3b, MSL #8
    USUBL2  V28.2D, V26.4S, V26.4S
    MOV  V20.8B, V28.8B
    SHL  V14.8H, V24.8H, #0x4
    URSHR  V26.8H, V9.8H, #9
    SQSHRUN2 V30.8H, V4.4S, #11
    FCMGT  V1.2S, V18.2S, V10.2S
    FCVTZU  V11.2S, V30.2S
    SQRDMULH S22, S2, V6.S[0x2]
    ORN  V8.16B, V22.16B, V22.16B
    FMAX  V19.2D, V1.2D, V11.2D
    FMUL V0.8H, V26.8H, V1.H[0x1]
    FCVTL  V18.4S, V20.4H
    MUL  V22.8H, V18.8H, V3.H[0x1]
    UMLSL V18.4S, V0.4H, V8.H[0x7]
    UHADD  V2.4H, V14.4H, V14.4H
    SMINV  B28, V22.8B
    FRECPS  V22.8H, V28.8H, V19.8H
    SSHR  V24.4S, V2.4S, #21
    USHLL2 V12.8H, V22.16B, #0x7
    SADDL  V8.2D, V24.2S, V24.2S
    USHLL V7.8H, V8.8B, #0x6
    SQDMULL V22.4S, V7.4H, V7.H[0x4]
    SQXTUN  V28.4H, V22.4S
    FCVTAU  V9.8H, V28.8H
    ADD  V3.2D, V4.2D, V9.2D
    SSHR  V2.4S, V12.4S, #31
    URSHL  V4.2D, V2.2D, V18.2D
    SSRA  V1.8H, V3.8H, #15
    UQSHL  V0.4H, V4.4H, #0x3
    SMINV  H8, V1.4H
    URSRA  V9.4S, V0.4S, #9
    FMINP H30, V9.2H
    FMINNMV  S0, V30.4S
    FRINTA  V19.4H, V0.4H
    XTN  V9.8B, V19.8H
    SSUBL2  V19.2D, V9.4S, V8.4S
    TBX  V0.8B, { V6.16B, V7.16B, V8.16B, V9.16B }, V22.8B
    FMLS H30, H17, V12.H[0x7]
    FMULX V26.2D, V12.2D, V27.D[0x1]
    UHSUB  V28.2S, V15.2S, V20.2S
    RSUBHN  V24.8B, V26.8H, V7.8H
    FMAXNMP D15, V20.2D
    FABS  V20.8H, V2.8H
    SQRSHRUN2 V27.16B, V16.8H, #2
    SXTL V9.2D, V4.2S
    FMUL V6.2S, V19.2S, V0.S[0x1]
    UQSHRN2 V2.16B, V30.8H, #5
    UMLAL V4.2D, V6.2S, V6.S[0x2]
    UABA  V6.4S, V27.4S, V28.4S
    MOV  W26, V2.S[0x0]
    TBL  V2.8B, { V30.16B, V31.16B }, V4.8B
    SSRA  V12.8H, V6.8H, #3
    SRI  V18.8H, V15.8H, #12
    SRSHR V15.2D, V24.2D, #47
    SQSHL  V31.4S, V29.4S, #0x8
    FRINTI  V19.4H, V2.4H
    SMLAL2 V4.2D, V20.4S, V18.S[0x3]
    UQSHRN V17.2S, V9.2D, #1
    CMHI  V18.2S, V17.2S, V17.2S
    FMLA H7, H12, V15.H[0x0]
    ORR  V6.2S, #0x62, LSL #16
    SQSHRN V20.8B, V6.8H, #4
    SSHR V28.2D, V31.2D, #45
    FCMGT  V26.8H, V18.8H, #0.0
    SQRDMULH  V6.4H, V7.4H, V4.H[0x7]
    FCMGT  V16.4H, V6.4H, V28.4H
    SXTL2 V22.8H, V19.16B
    FRINTP  V27.2S, V16.2S
    SHA1SU0  V9.4S, V27.4S, V27.4S
    SMAXV  S12, V26.4S
    SQSHLU  V15.2S, V12.2S, #0x0
    FSQRT  V18.4S, V20.4S
    UMOV W9, V18.S[0x1]
    SQNEG  V31.8B, V15.8B
    SMULL V29.2D, V9.2S, V22.S[0x0]
    FMUL V18.2S, V31.2S, V31.S[0x1]
    FCVTN  V26.4H, V29.4S
    UMLAL  V28.4S, V26.4H, V15.4H
    SMOV W29, V0.B[0x5]
    FMLS D31, D18, V28.D[0x1]
    FRINTI  V28.8H, V10.8H
    UMAX  V4.4H, V3.4H, V14.4H
    FMAXP D27, V7.2D
    MOV  V22.16B, V2.16B
    FCVTXN2  V18.4S, V26.2D
    SADALP  V17.8H, V20.16B
    TBL  V20.8B, { V30.16B }, V30.8B
    SQABS  V16.4S, V29.4S
    SMLSL2 V7.2D, V16.4S, V27.S[0x1]
    SQDMLSL2 V9.2D, V18.4S, V28.S[0x1]
    AESE  V3.16B, V9.16B
    UABD  V19.8B, V22.8B, V31.8B
    UCVTF  V15.2S, V4.2S
    SMOV W27, V7.B[0xd]
    MOV  V2.8B, V15.8B
    SHSUB  V14.8H, V19.8H, V19.8H
    SHRN V26.4H, V7.4S, #4
    FRINTX  V0.4S, V17.4S
    SQXTN  V12.2S, V29.2D
    UMAXV  B30, V3.16B
    FCVTAU  V28.2S, V2.2S
    SRSRA  V31.4H, V12.4H, #13
    FRINTN  V7.8H, V31.8H
    FMINNMP S12, V20.2S
    FCVTZU V20.2D, V0.2D, #47
    UABA  V0.8H, V20.8H, V28.8H
    TBL  V15.8B, { V14.16B }, V12.8B
    SQXTUN  V20.8B, V13.8H
    PMUL  V2.8B, V30.8B, V20.8B
    FCMEQ  V16.8H, V26.8H, V26.8H
    SUBS  X6, X6, #0x1
    B.NE  TSRTAdvsimdVectorAllOperation_label_18
    MOVZ  X13, #0xee82, LSL #0
    MOVK  X13, #0x2a09, LSL #16
    MOVK  X13, #0x7d1a, LSL #32
    MOVK  X13, #0xc286, LSL #48
    SUB  X17, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x2e54, LSL #0
    MOVK  X13, #0x865, LSL #16
    MOVK  X13, #0xb074, LSL #32
    MOVK  X13, #0xa627, LSL #48
    SUB  X17, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x6cb6, LSL #0
    MOVK  X13, #0x92b1, LSL #16
    MOVK  X13, #0xd7e6, LSL #32
    MOVK  X13, #0xdc12, LSL #48
    SUB  X17, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xa5b5, LSL #0
    MOVK  X13, #0xbf46, LSL #16
    MOVK  X13, #0xd4e2, LSL #32
    MOVK  X13, #0xf0a0, LSL #48
    SUB  X17, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x7eac, LSL #0
    MOVK  X13, #0x1a8a, LSL #16
    MOVK  X13, #0x2bb, LSL #32
    MOVK  X13, #0xc09d, LSL #48
    SUB  X17, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x7ef6, LSL #0
    MOVK  X13, #0xe253, LSL #16
    MOVK  X13, #0x5e8f, LSL #32
    MOVK  X13, #0x65f5, LSL #48
    SUB  X17, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xceb1, LSL #0
    MOVK  X13, #0x70e2, LSL #16
    MOVK  X13, #0x6061, LSL #32
    MOVK  X13, #0x245a, LSL #48
    SUB  X17, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xb670, LSL #0
    MOVK  X13, #0xf993, LSL #16
    MOVK  X13, #0x73b7, LSL #32
    MOVK  X13, #0x3d97, LSL #48
    SUB  X17, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xd116, LSL #0
    MOVK  X13, #0x1729, LSL #16
    MOVK  X13, #0x7b95, LSL #32
    MOVK  X13, #0x44fb, LSL #48
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xb52b, LSL #0
    MOVK  X13, #0x988, LSL #16
    MOVK  X13, #0xfe68, LSL #32
    MOVK  X13, #0x7af2, LSL #48
    SUB  X17, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xd305, LSL #0
    MOVK  X13, #0x9752, LSL #16
    MOVK  X13, #0xa873, LSL #32
    MOVK  X13, #0xe070, LSL #48
    SUB  X17, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x3cb, LSL #0
    MOVK  X13, #0xef93, LSL #16
    MOVK  X13, #0xdf3, LSL #32
    MOVK  X13, #0x528a, LSL #48
    SUB  X17, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xd2a5, LSL #0
    MOVK  X13, #0x56c8, LSL #16
    MOVK  X13, #0x7093, LSL #32
    MOVK  X13, #0x9625, LSL #48
    SUB  X17, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xca40, LSL #0
    MOVK  X13, #0xa015, LSL #16
    MOVK  X13, #0x16c, LSL #32
    MOVK  X13, #0xf9fe, LSL #48
    SUB  X17, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x60b8, LSL #0
    MOVK  X13, #0x1c13, LSL #16
    MOVK  X13, #0x9df5, LSL #32
    MOVK  X13, #0x4474, LSL #48
    SUB  X17, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X17, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x9f, LSL #0
    MOVK  X13, #0x800, LSL #16
    MRS  X17, FPSR
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V0.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D0
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V1.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D1
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V2.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D2
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x6363, LSL #0
    MOVK  X13, #0x6363, LSL #16
    MOVK  X13, #0x6363, LSL #32
    MOVK  X13, #0x6363, LSL #48
    FMOV  X17, V3.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x6363, LSL #0
    MOVK  X13, #0x6363, LSL #16
    MOVK  X13, #0x6363, LSL #32
    MOVK  X13, #0x6363, LSL #48
    FMOV  X17, D3
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V4.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D4
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V5.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    FMOV  X17, D5
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V6.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D6
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V7.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8000, LSL #48
    FMOV  X17, D7
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V8.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D8
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V9.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D9
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V10.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D10
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V11.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X17, D11
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V12.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D12
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V13.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D13
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V14.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D14
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V15.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D15
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X17, V16.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X17, D16
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V17.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xfe, LSL #0
    MOVK  X13, #0xfe, LSL #16
    FMOV  X17, D17
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V18.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D18
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V19.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8000, LSL #48
    FMOV  X17, D19
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V20.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D20
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0xcaf3, LSL #0
    MOVK  X13, #0xfade, LSL #16
    MOVK  X13, #0x63e9, LSL #32
    MOVK  X13, #0x1ba3, LSL #48
    FMOV  X17, V21.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x657e, LSL #0
    MOVK  X13, #0x673d, LSL #16
    MOVK  X13, #0x810d, LSL #32
    MOVK  X13, #0xe0b4, LSL #48
    FMOV  X17, D21
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V22.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D22
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V23.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D23
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V24.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D24
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V25.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D25
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V26.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D26
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V27.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D27
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V28.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D28
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V29.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D29
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V30.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x63, LSL #0
    FMOV  X17, D30
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V31.D[1]
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8000, LSL #48
    FMOV  X17, D31
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorAllOperation_TestFail
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
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X29
    FMOV  V0.D[1], X24
    FMOV  D1, X19
    FMOV  V1.D[1], X27
    FMOV  D2, X5
    FMOV  V2.D[1], X25
    FMOV  D3, X15
    FMOV  V3.D[1], X16
    FMOV  D4, X26
    FMOV  V4.D[1], X23
    FMOV  D5, X22
    FMOV  V5.D[1], X10
    FMOV  D6, X28
    FMOV  V6.D[1], X3
    FMOV  D7, X10
    FMOV  V7.D[1], X17
    FMOV  D8, X3
    FMOV  V8.D[1], X17
    FMOV  D9, X20
    FMOV  V9.D[1], X27
    FMOV  D10, X8
    FMOV  V10.D[1], X2
    FMOV  D11, X9
    FMOV  V11.D[1], X12
    FMOV  D12, X12
    FMOV  V12.D[1], X3
    FMOV  D13, X22
    FMOV  V13.D[1], X29
    FMOV  D14, X29
    FMOV  V14.D[1], X17
    FMOV  D15, X17
    FMOV  V15.D[1], X13
    FMOV  D16, X12
    FMOV  V16.D[1], X10
    FMOV  D17, X17
    FMOV  V17.D[1], X12
    FMOV  D18, X15
    FMOV  V18.D[1], X20
    FMOV  D19, X3
    FMOV  V19.D[1], X3
    FMOV  D20, X27
    FMOV  V20.D[1], X24
    FMOV  D21, X29
    FMOV  V21.D[1], X22
    FMOV  D22, X29
    FMOV  V22.D[1], X4
    FMOV  D23, X27
    FMOV  V23.D[1], X4
    FMOV  D24, X7
    FMOV  V24.D[1], X29
    FMOV  D25, X5
    FMOV  V25.D[1], X20
    FMOV  D26, X20
    FMOV  V26.D[1], X16
    FMOV  D27, X17
    FMOV  V27.D[1], X20
    FMOV  D28, X15
    FMOV  V28.D[1], X13
    FMOV  D29, X27
    FMOV  V29.D[1], X23
    FMOV  D30, X22
    FMOV  V30.D[1], X4
    FMOV  D31, X6
    FMOV  V31.D[1], X15
    MOVZ  X22, #0xa, LSL #0
TSRTAdvsimdVectorAllOperation_label_19:
    FMINP H17, V24.2H
    RBIT  V26.16B, V28.16B
    FMINP  V4.4H, V25.4H, V23.4H
    FCMGE  V27.2D, V27.2D, #0.0
    MUL  V14.4H, V29.4H, V29.4H
    SQSHRN2 V27.8H, V31.4S, #14
    ZIP1  V1.2D, V27.2D, V4.2D
    SQSHRUN V13.8B, V26.8H, #3
    FCMLT  V15.4H, V30.4H, #0.0
    REV32  V26.16B, V17.16B
    FADDP H26, V26.2H
    FRINTI  V17.8H, V15.8H
    FRECPS  V15.4H, V14.4H, V14.4H
    UMLSL2  V30.8H, V13.16B, V26.16B
    SRSRA  V10.8H, V1.8H, #4
    SXTL V19.8H, V10.8B
    RSUBHN  V30.8B, V19.8H, V5.8H
    SMLSL V27.4S, V17.4H, V1.H[0x0]
    FMAX  V4.8H, V27.8H, V30.8H
    SQSHL  V19.8B, V4.8B, #0x5
    SRSRA  V24.4H, V19.4H, #16
    FCVTZS  V14.4S, V24.4S, #16
    SHA1C  Q26, S25, V14.4S
    USHLL2 V31.4S, V26.8H, #0x9
    DUP H29, V15.H[0x0]
    SRHADD  V23.8B, V31.8B, V29.8B
    DUP H28, V9.H[0x5]
    UQSHL V17.2D, V4.2D, #0x2
    UMOV W16, V26.B[0xe]
    MOV D26, V22.D[0x1]
    SMULL  V1.8H, V26.8B, V17.8B
    FMLA D9, D13, V10.D[0x1]
    SMAXV  H24, V21.4H
    INS V21.H[0x7], W24
    SSHLL2 V27.2D, V25.4S, #0xb
    SQDMULL2 V5.4S, V11.8H, V13.H[0x7]
    SQSHRN2 V2.4S, V27.2D, #17
    SMLAL  V19.8H, V22.8B, V5.8B
    MOV  W23, V14.S[0x0]
    FDIV  V30.2D, V0.2D, V21.2D
    SHADD  V29.2S, V25.2S, V4.2S
    UCVTF  V22.4S, V23.4S, #18
    MOV H27, V2.H[0x6]
    SQDMLAL2 V11.2D, V22.4S, V24.S[0x2]
    ADDV  S31, V27.4S
    ADDHN2  V27.16B, V30.8H, V30.8H
    FCVTN2  V25.8H, V1.4S
    FMAX  V14.4S, V25.4S, V9.4S
    SXTL2 V5.2D, V28.4S
    SSRA  V13.16B, V19.16B, #3
    URSRA  V0.8B, V11.8B, #2
    UMLAL V22.2D, V17.2S, V5.S[0x1]
    SQDMLSL  V21.2D, V0.2S, V27.2S
    UQRSHRN V19.2S, V21.2D, #2
    REV16  V27.8B, V31.8B
    UABA  V21.2S, V14.2S, V14.2S
    BIF  V11.16B, V29.16B, V27.16B
    INS V28.S[0x2], W3
    SQABS  V4.4S, V13.4S
    INS V31.D[0x0], V22.D[0x0]
    MLA  V14.8H, V31.8H, V4.H[0x1]
    PMULL2  V10.1Q, V19.2D, V28.2D
    ORR  V5.4H, #0x6f, LSL #8
    USHLL2 V25.2D, V5.4S, #0x12
    FMLS D9, D25, V8.D[0x1]
    UADDW2  V31.4S, V9.4S, V14.8H
    FRSQRTS  V9.4S, V31.4S, V11.4S
    MVNI  V25.2S, #0x8f, MSL #16
    SQDMLAL V0.2D, V10.2S, V21.S[0x0]
    UHADD  V22.4S, V0.4S, V9.4S
    FRINTN  V19.8H, V22.8H
    SADALP  V30.2D, V25.4S
    UMLSL V14.4S, V30.4H, V10.H[0x2]
    UMINP  V21.4H, V14.4H, V14.4H
    SQDMULL2 V10.4S, V19.8H, V12.H[0x4]
    SQDMULL V1.4S, V21.4H, V10.H[0x5]
    CLS  V14.4H, V25.4H
    SQDMLAL  V10.4S, V9.4H, V19.4H
    SMLSL  V28.2D, V26.2S, V3.2S
    SMULL2 V31.2D, V29.4S, V10.S[0x0]
    UMINV  H22, V28.8H
    SMIN  V5.8H, V15.8H, V19.8H
    FMUL H4, H10, V6.H[0x3]
    FMAXP S21, V29.2S
    SSRA V15.2D, V15.2D, #25
    FMOV  V19.4S, #-2.00000000
    FRINTX  V9.8H, V15.8H
    SHA1C  Q12, S9, V21.4S
    USHLL2 V25.2D, V31.4S, #0x1d
    FCVTNS  V29.2S, V19.2S
    FCVTN2  V26.8H, V4.4S
    SADDLV  D4, V25.4S
    UXTL2 V25.2D, V5.4S
    INS V15.D[0x1], X27
    REV32  V6.8B, V12.8B
    UXTL V5.4S, V26.4H
    FMLS S19, S25, V5.S[0x0]
    SXTL2 V31.4S, V6.8H
    FMINP D21, V22.2D
    SQRSHRN2 V0.4S, V29.2D, #6
    TRN2  V29.2S, V15.2S, V4.2S
    UADDLV  H25, V31.8B
    FDIV  V5.2S, V14.2S, V19.2S
    FCVTZU  V12.2D, V25.2D
    FCVTZS  V22.4H, V21.4H, #9
    SHRN V19.4H, V22.4S, #11
    FRINTM  V21.8H, V19.8H
    MVNI  V31.4S, #0xdc, MSL #8
    ABS  V9.8B, V21.8B
    UQSHRN2 V19.4S, V9.2D, #5
    SQSHRUN2 V21.4S, V19.2D, #4
    SRSHL  V19.2S, V0.2S, V12.2S
    URSHR  V10.8H, V19.8H, #11
    DUP B6, V1.B[0x9]
    USHR  V19.4H, V21.4H, #6
    UMLAL2 V1.4S, V31.8H, V5.H[0x4]
    FMOV  V22.4H, #-14.50000000
    UMULL2 V9.2D, V22.4S, V1.S[0x3]
    SQRSHRN V15.2S, V9.2D, #30
    FCVTXN2  V12.4S, V15.2D
    SQDMLAL V25.4S, V16.4H, V7.H[0x2]
    DUP H0, V6.H[0x3]
    FMLS V16.2D, V10.2D, V0.D[0x0]
    SQSHRUN2 V14.4S, V12.2D, #7
    SADDL  V21.8H, V19.8B, V29.8B
    SMULL V7.4S, V14.4H, V14.H[0x3]
    SQDMLSL2 V5.4S, V16.8H, V7.H[0x6]
    FCVTPU  V0.2S, V25.2S
    REV64  V6.16B, V21.16B
    MLS  V31.2S, V5.2S, V6.S[0x1]
    SQDMULL V25.4S, V0.4H, V7.H[0x6]
    CMEQ  V15.2D, V25.2D, V25.2D
    FMIN  V9.4H, V15.4H, V31.4H
    FCVTPS  V29.2D, V2.2D
    FMLA  V6.2S, V5.2S, V6.2S
    FMULX V5.8H, V29.8H, V5.H[0x2]
    CMHI  V2.4S, V21.4S, V21.4S
    BIT  V7.16B, V3.16B, V13.16B
    SUBHN2  V0.8H, V30.4S, V27.4S
    SRI  V19.4S, V29.4S, #12
    UMLSL  V27.2D, V27.2S, V28.2S
    BIF  V29.16B, V14.16B, V22.16B
    UQSHRN2 V13.16B, V9.8H, #8
    FSQRT  V22.4H, V6.4H
    ADDV  H6, V22.8H
    UCVTF V16.2D, V5.2D, #7
    USRA  V21.2S, V17.2S, #14
    UMINV  B30, V6.8B
    SUQADD  V28.4H, V2.4H
    ADDV  H5, V7.4H
    SRSHL  V9.4H, V16.4H, V27.4H
    FCMLE  V3.2S, V22.2S, #0.0
    FCMGT  V17.2D, V28.2D, #0.0
    FDIV  V28.2S, V0.2S, V9.2S
    UCVTF  V22.2D, V16.2D
    SABDL2  V27.2D, V13.4S, V19.4S
    SLI  V13.4S, V30.4S, #0x4
    SSHR V14.2D, V5.2D, #51
    USHL  V19.8B, V29.8B, V21.8B
    SQSHRN V6.2S, V14.2D, #18
    FMINNMP D7, V28.2D
    AESE  V14.16B, V13.16B
    UCVTF  V21.8H, V15.8H, #9
    SQXTUN2  V9.16B, V21.8H
    UADDL2  V15.4S, V9.8H, V9.8H
    FMAXNMV  H9, V3.8H
    SSHLL2 V14.2D, V6.4S, #0x1a
    FMOV  V29.4S, #4.75000000
    DUP V2.8B, W3
    SHRN2 V30.8H, V22.4S, #6
    SRI  V21.16B, V29.16B, #1
    UQRSHRN V0.8B, V7.8H, #1
    SQSHRN V16.8B, V27.8H, #8
    FCVTAS  V5.8H, V19.8H
    SQDMLSL2  V13.2D, V9.4S, V15.4S
    FMAXNMP D28, V14.2D
    UQRSHRN2 V3.16B, V17.8H, #6
    USRA  V6.8H, V3.8H, #10
    SQDMLAL2 V17.2D, V13.4S, V2.S[0x1]
    SSHR  V29.4H, V17.4H, #7
    FMAXNMP H2, V21.2H
    FADDP  V18.4H, V6.4H, V16.4H
    DUP V26.8H, W22
    SADDLP  V13.2D, V31.4S
    SUQADD  V14.2S, V5.2S
    FMLA H6, H26, V8.H[0x5]
    SHA1SU0  V7.4S, V14.4S, V28.4S
    UQRSHRN2 V27.4S, V16.2D, #9
    SLI  V5.8H, V29.8H, #0xa
    FCMGT  V13.2D, V2.2D, V0.2D
    CMHI  V22.4S, V6.4S, V13.4S
    MUL  V0.2S, V18.2S, V30.2S
    SXTL V26.4S, V0.4H
    FMLS V17.2D, V22.2D, V15.D[0x1]
    USQADD  V8.4H, V17.4H
    SQDMULH H13, H26, V8.H[0x7]
    ZIP1  V21.2D, V13.2D, V13.2D
    FADDP  V31.2D, V21.2D, V7.2D
    UXTL V26.2D, V31.2S
    FMULX S6, S27, V5.S[0x1]
    SMULL V27.2D, V6.2S, V20.S[0x0]
    DUP  V19.8H, V27.H[0x1]
    FMLS H17, H26, V7.H[0x7]
    FCVTPU  V13.8H, V17.8H
    FMLS S31, S13, V13.S[0x1]
    CLZ  V0.4S, V19.4S
    MOV V6.B[0x3], W13
    ZIP2  V28.2S, V6.2S, V31.2S
    SQABS  V16.4H, V0.4H
    UABA  V20.8B, V16.8B, V16.8B
    SABAL  V15.8H, V20.8B, V28.8B
    UADDLV  D22, V4.4S
    SQDMLSL2 V21.4S, V9.8H, V14.H[0x4]
    MLS  V31.2S, V5.2S, V30.S[0x1]
    SQSHLU  V16.4S, V1.4S, #0x16
    MVNI  V1.8H, #0xc7
    SMULL V0.4S, V5.4H, V10.H[0x7]
    SADDW  V27.8H, V15.8H, V16.8B
    UMLSL2 V5.4S, V9.8H, V5.H[0x7]
    SQSHRN2 V14.4S, V4.2D, #31
    ADDHN2  V30.4S, V12.2D, V6.2D
    SQRSHRUN2 V18.4S, V30.2D, #21
    FMLA V7.8H, V18.8H, V0.H[0x1]
    SMINV  S9, V22.4S
    SRI  V13.4H, V7.4H, #1
    UABAL  V6.4S, V21.4H, V7.4H
    SHA1P  Q16, S31, V9.4S
    ZIP1  V9.2D, V5.2D, V13.2D
    SHL  V4.8H, V16.8H, #0x0
    FCMEQ  V10.4H, V1.4H, V1.4H
    CMEQ  V20.4S, V6.4S, #0
    UADDW  V6.8H, V10.8H, V10.8B
    INS V19.D[0x1], V9.D[0x1]
    FSQRT  V21.8H, V28.8H
    FCVTNS  V4.4S, V27.4S
    SQDMLAL V13.2D, V21.2S, V20.S[0x3]
    UMINV  S28, V13.4S
    FABS  V0.2D, V19.2D
    ORR  V10.16B, V28.16B, V17.16B
    UMLAL V22.2D, V10.2S, V10.S[0x1]
    SQRSHRN V15.2S, V22.2D, #17
    UQSHRN2 V10.4S, V6.2D, #10
    BIF  V30.8B, V14.8B, V10.8B
    FMAXNMP H22, V4.2H
    AESIMC  V20.16B, V30.16B
    CMEQ  V4.4H, V10.4H, V0.4H
    FCVTPU  V0.2D, V20.2D
    BIC  V12.8B, V4.8B, V4.8B
    SHA256H  Q13, Q27, V15.4S
    SQDMULH  V9.4S, V22.4S, V22.S[0x2]
    MOVI  V6.8H, #0x1d
    FRECPS  V28.4H, V6.4H, V0.4H
    SQRDMULH  V4.4S, V28.4S, V13.S[0x1]
    UMLSL2 V17.4S, V4.8H, V4.H[0x7]
    SADDW2  V21.4S, V17.4S, V23.8H
    SSHR  V19.2S, V12.2S, #21
    SQRSHRUN2 V23.8H, V9.4S, #1
    SABDL2  V14.2D, V21.4S, V19.4S
    SQDMULL2  V16.4S, V14.8H, V23.8H
    UMAXV  H30, V1.8H
    USRA  V9.16B, V31.16B, #8
    SHL  V13.2S, V0.2S, #0x4
    DUP H22, V29.H[0x6]
    UMLAL2  V10.4S, V18.8H, V18.8H
    SQSHRUN2 V14.4S, V14.2D, #6
    FABD  V29.4S, V28.4S, V8.4S
    SHA1C  Q27, S24, V6.4S
    PMULL2  V19.8H, V10.16B, V16.16B
    RADDHN2  V8.4S, V29.2D, V29.2D
    SMLSL V29.4S, V8.4H, V8.H[0x4]
    SHLL2  V15.2D, V12.4S, #32
    SQDMULL D0, S26, V13.S[0x1]
    SRSHR  V4.8H, V22.8H, #4
    MOV V26.B[0x2], V29.B[0x9]
    SSHR V12.2D, V15.2D, #43
    ORN  V15.16B, V0.16B, V9.16B
    UQSHL  V20.8H, V14.8H, #0x4
    SQSHRUN V8.8B, V27.8H, #6
    SQRSHRUN2 V18.16B, V14.8H, #3
    FCVTXN  V27.2S, V4.2D
    SRSRA  V28.2S, V15.2S, #7
    FCVTN2  V13.4S, V18.2D
    ORR  V15.4H, #0xaa, LSL #8
    CMTST  V18.8B, V19.8B, V26.8B
    SMLSL2 V14.4S, V8.8H, V12.H[0x4]
    SMULL  V19.2D, V20.2S, V18.2S
    FMINP  V22.2D, V14.2D, V13.2D
    SQRSHRUN2 V26.16B, V27.8H, #4
    FCVTZS V14.2D, V28.2D, #42
    SSHR  V8.8B, V26.8B, #5
    SMLSL  V28.2D, V14.2S, V14.2S
    FMLS D14, D22, V0.D[0x0]
    SXTL2 V12.2D, V14.4S
    SMINV  B29, V12.8B
    SQSHRUN V14.4H, V28.4S, #15
    FCVTZS  V4.4S, V14.4S
    UMLSL V12.2D, V29.2S, V8.S[0x1]
    FMAXNMP S27, V19.2S
    UQSUB  V29.8B, V4.8B, V12.8B
    SQSHLU V20.2D, V29.2D, #0x19
    SUBS  X22, X22, #0x1
    B.NE  TSRTAdvsimdVectorAllOperation_label_19
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x9f, LSL #0
    MOVK  X10, #0x800, LSL #16
    MRS  X4, FPSR
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V0.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, D0
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0xff38, LSL #0
    MOVK  X10, #0xff38, LSL #16
    MOVK  X10, #0xff38, LSL #32
    MOVK  X10, #0xff38, LSL #48
    FMOV  X4, V1.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0xff38, LSL #0
    MOVK  X10, #0xff38, LSL #16
    MOVK  X10, #0xff38, LSL #32
    MOVK  X10, #0xff38, LSL #48
    FMOV  X4, D1
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V2.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x20cc, LSL #0
    FMOV  X4, D2
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V3.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    FMOV  X4, D3
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V4.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, D4
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V5.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, D5
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x1d, LSL #0
    MOVK  X10, #0x1d, LSL #16
    MOVK  X10, #0x1d, LSL #32
    MOVK  X10, #0x1d, LSL #48
    FMOV  X4, V6.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x1d, LSL #0
    MOVK  X10, #0x1d, LSL #16
    MOVK  X10, #0x1d, LSL #32
    MOVK  X10, #0x1d, LSL #48
    FMOV  X4, D6
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V7.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, D7
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V8.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, D8
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V9.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, D9
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V10.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x8000, LSL #0
    FMOV  X4, D10
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V11.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X4, D11
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V12.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, D12
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V13.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, D13
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V14.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x7000, LSL #0
    MOVK  X10, #0x8000, LSL #16
    FMOV  X4, D14
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V15.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X4, D15
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V16.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, D16
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V17.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x8000, LSL #0
    FMOV  X4, D17
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V18.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, D18
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V19.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, D19
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V20.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, D20
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V21.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x8000, LSL #0
    FMOV  X4, D21
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V22.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, D22
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V23.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x2000, LSL #0
    FMOV  X4, D23
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V24.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, D24
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V25.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, D25
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V26.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, D26
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V27.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, D27
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0xfc00, LSL #0
    MOVK  X10, #0xffbd, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X4, V28.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x3c00, LSL #0
    MOVK  X10, #0x3800, LSL #16
    MOVK  X10, #0x3c00, LSL #32
    MOVK  X10, #0x4000, LSL #48
    FMOV  X4, D28
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V29.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, D29
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V30.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0xff38, LSL #0
    FMOV  X4, D30
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V31.D[1]
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x8000, LSL #16
    FMOV  X4, D31
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
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
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
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
    FMOV  V0.D[1], X29
    FMOV  D1, X25
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X28
    FMOV  D3, X7
    FMOV  V3.D[1], X4
    FMOV  D4, X26
    FMOV  V4.D[1], X24
    FMOV  D5, X4
    FMOV  V5.D[1], X25
    FMOV  D6, X25
    FMOV  V6.D[1], X7
    FMOV  D7, X19
    FMOV  V7.D[1], X29
    FMOV  D8, X19
    FMOV  V8.D[1], X13
    FMOV  D9, X16
    FMOV  V9.D[1], X17
    FMOV  D10, X9
    FMOV  V10.D[1], X27
    FMOV  D11, X28
    FMOV  V11.D[1], X13
    FMOV  D12, X19
    FMOV  V12.D[1], X24
    FMOV  D13, X25
    FMOV  V13.D[1], X7
    FMOV  D14, X6
    FMOV  V14.D[1], X6
    FMOV  D15, X26
    FMOV  V15.D[1], X5
    FMOV  D16, X3
    FMOV  V16.D[1], X22
    FMOV  D17, X16
    FMOV  V17.D[1], X20
    FMOV  D18, X25
    FMOV  V18.D[1], X19
    FMOV  D19, X13
    FMOV  V19.D[1], X8
    FMOV  D20, X5
    FMOV  V20.D[1], X6
    FMOV  D21, X17
    FMOV  V21.D[1], X5
    FMOV  D22, X28
    FMOV  V22.D[1], X22
    FMOV  D23, X27
    FMOV  V23.D[1], X20
    FMOV  D24, X13
    FMOV  V24.D[1], X10
    FMOV  D25, X4
    FMOV  V25.D[1], X17
    FMOV  D26, X25
    FMOV  V26.D[1], X22
    FMOV  D27, X5
    FMOV  V27.D[1], X8
    FMOV  D28, X26
    FMOV  V28.D[1], X10
    FMOV  D29, X26
    FMOV  V29.D[1], X15
    FMOV  D30, X12
    FMOV  V30.D[1], X24
    FMOV  D31, X10
    FMOV  V31.D[1], X24
    MOVZ  X2, #0xa, LSL #0
TSRTAdvsimdVectorAllOperation_label_20:
    URSHR  V8.8B, V22.8B, #7
    UQADD  V29.8B, V24.8B, V30.8B
    UQRSHRN V24.2S, V8.2D, #26
    SMLAL2  V23.4S, V26.8H, V26.8H
    URHADD  V15.4S, V25.4S, V31.4S
    RSHRN V30.2S, V24.2D, #3
    FCVTZU  V15.8H, V27.8H, #11
    FCVTAS  V29.2D, V21.2D
    URSHR  V8.8B, V8.8B, #5
    SSHR  V31.4H, V7.4H, #5
    FCVTMU  V15.8H, V28.8H
    FMINV  S2, V23.4S
    UQSHL  V30.8B, V15.8B, #0x5
    FMAXNMP S24, V8.2S
    USRA  V0.4H, V2.4H, #9
    MOV V7.B[0xf], V24.B[0x7]
    URSHR  V30.2S, V12.2S, #10
    UMLSL2 V19.2D, V31.4S, V31.S[0x2]
    FMLA  V10.8H, V19.8H, V30.8H
    SABAL  V28.2D, V29.2S, V29.2S
    SHLL  V4.8H, V8.8B, #8
    SQDMULL S21, H10, V4.H[0x2]
    USHR V31.2D, V7.2D, #48
    SMIN  V27.16B, V31.16B, V21.16B
    FCVTZS  V23.2D, V27.2D
    FMAXNMP  V15.4H, V28.4H, V23.4H
    SQSHRUN2 V22.4S, V0.2D, #21
    USHLL V21.2D, V22.2S, #0x6
    SMLAL V8.4S, V15.4H, V0.H[0x7]
    SADDLV  H31, V8.16B
    SSRA  V10.4H, V31.4H, #15
    CLS  V0.4H, V21.4H
    SADDL  V24.2D, V10.2S, V0.2S
    FCVTN2  V29.8H, V12.4S
    SQRSHRUN V2.2S, V27.2D, #32
    SCVTF  V8.4H, V30.4H
    SABA  V15.2S, V21.2S, V8.2S
    SMLSL2  V7.8H, V14.16B, V5.16B
    CMGT  V4.8B, V27.8B, V9.8B
    BIC  V8.16B, V12.16B, V14.16B
    USHL  V12.2S, V30.2S, V22.2S
    UMINV  B14, V16.16B
    FCMEQ  V19.4S, V24.4S, #0.0
    SABDL2  V31.4S, V7.8H, V19.8H
    UADDLP  V7.4H, V4.8B
    FMLA H22, H8, V7.H[0x5]
    SMAXV  B27, V22.8B
    UMLAL2  V0.8H, V15.16B, V2.16B
    DUP  V21.4S, V12.S[0x0]
    FMLS  V22.2D, V29.2D, V29.2D
    SQRSHRN V5.4H, V14.4S, #2
    FRINTN  V9.2S, V27.2S
    SRSRA  V7.4H, V31.4H, #16
    PMULL  V31.8H, V22.8B, V24.8B
    SXTL2 V16.4S, V12.8H
    FCMGE  V19.4S, V21.4S, V0.4S
    UMLSL  V22.4S, V31.4H, V7.4H
    SABA  V7.2S, V5.2S, V5.2S
    SHRN V31.4H, V19.4S, #2
    FMAXP H2, V31.2H
    FMOV  V12.2S, #-0.12500000
    SMAX  V4.4S, V22.4S, V22.4S
    FNEG  V19.8H, V16.8H
    FMIN  V31.8H, V9.8H, V9.8H
    CMHS  V14.16B, V2.16B, V17.16B
    MOV V15.H[0x1], V14.H[0x4]
    FCVTAU  V30.8H, V15.8H
    SMAX  V5.2S, V7.2S, V12.2S
    AESD  V29.16B, V5.16B
    SMLSL2  V27.8H, V29.16B, V4.16B
    FMLA H4, H19, V15.H[0x5]
    FMAXP  V0.4H, V27.4H, V27.4H
    SRSRA V2.2D, V0.2D, #25
    FABD  V8.8H, V31.8H, V31.8H
    CMEQ  V12.2D, V8.2D, #0
    FMINNMP D14, V30.2D
    MVNI  V8.4H, #0x84
    SMLSL2 V30.2D, V4.4S, V4.S[0x1]
    ADDV  H5, V2.4H
    RADDHN2  V29.16B, V30.8H, V12.8H
    MUL  V0.4S, V8.4S, V14.4S
    USHL  V14.2S, V29.2S, V0.2S
    UCVTF  V4.8H, V5.8H, #2
    UQSHRN V17.2S, V4.2D, #3
    SMOV W19, V14.H[0x6]
    SRSRA  V15.8B, V11.8B, #2
    SHA1M  Q8, S29, V1.4S
    FMINP H9, V5.2H
    UMOV W12, V1.B[0x0]
    SADDLP  V1.8H, V4.16B
    FRSQRTS  V0.2D, V12.2D, V15.2D
    SHRN V12.2S, V1.2D, #20
    ORR  V7.8H, #0x3b, LSL #8
    UQSHRN2 V30.8H, V21.4S, #5
    TRN1  V14.2D, V14.2D, V30.2D
    FMAXNMP D31, V27.2D
    SQRDMULH  V29.2S, V1.2S, V14.S[0x0]
    UADDLV  H30, V18.8B
    SXTL V2.4S, V7.4H
    FMAX  V19.4S, V28.4S, V7.4S
    SSHR V5.2D, V27.2D, #51
    FMAXNMP H1, V12.2H
    FCMEQ  V4.4H, V31.4H, #0.0
    FMLS V18.4S, V0.4S, V8.S[0x3]
    FADDP S28, V18.2S
    UQXTN  V18.4H, V28.4S
    SQNEG  V28.4H, V18.4H
    MOVI  V12.4H, #0x2, LSL #8
    FMLS S18, S19, V30.S[0x3]
    ADD  V15.4H, V18.4H, V1.4H
    FMLA S18, S4, V9.S[0x3]
    SQDMLSL2 V14.2D, V15.4S, V29.S[0x3]
    SXTL V30.2D, V5.2S
    TBX  V4.8B, { V13.16B, V14.16B }, V12.8B
    FMAXV  S14, V18.4S
    DUP  V8.2S, V2.S[0x0]
    FCVTZU  V1.4S, V28.4S, #12
    SQDMULL2 V2.4S, V8.8H, V4.H[0x3]
    SADDW  V15.2D, V1.2D, V2.2S
    TRN2  V4.4H, V30.4H, V14.4H
    FACGE  V27.4H, V4.4H, V4.4H
    MOVI  V19.8B, #0xf7
    SQXTUN2  V2.4S, V15.2D
    FNEG  V4.8H, V27.8H
    CMEQ  V9.4H, V2.4H, V4.4H
    SCVTF  V30.4S, V19.4S, #26
    UMULL V29.4S, V30.4H, V14.H[0x7]
    SQDMLSL  V8.4S, V29.4H, V9.4H
    SHA1SU0  V30.4S, V24.4S, V17.4S
    FCMEQ  V19.2D, V23.2D, #0.0
    ADDP  D13, V20.2D
    FMUL V23.4H, V23.4H, V15.H[0x5]
    SXTL V27.8H, V28.8B
    URSRA  V24.4H, V4.4H, #14
    USHLL2 V15.8H, V5.16B, #0x1
    SHSUB  V17.8H, V26.8H, V23.8H
    FCVTMS  V4.4S, V26.4S
    UQSHRN V18.2S, V4.2D, #12
    UQSHL  V5.8B, V13.8B, #0x4
    FCMLE  V13.4H, V19.4H, #0.0
    MOV V20.S[0x2], V15.S[0x1]
    FCVTZS  V1.4H, V20.4H, #15
    FCMEQ  V28.2S, V7.2S, #0.0
    FMAXP D29, V24.2D
    FMLS  V26.4H, V28.4H, V27.4H
    SQSHRUN V4.8B, V8.8H, #8
    UQSHL V27.2D, V4.2D, #0x37
    SADDLV  H7, V30.16B
    RADDHN2  V20.4S, V26.2D, V18.2D
    SQSHL  V23.2D, V1.2D, V17.2D
    FMULX  V28.8H, V27.8H, V29.8H
    RSUBHN2  V17.8H, V23.4S, V7.4S
    FMULX D4, D28, V5.D[0x0]
    MOVI  V26.4H, #0xd4, LSL #8
    FMAXNMV  S19, V13.4S
    INS V9.D[0x0], V20.D[0x1]
    FMIN  V24.8H, V17.8H, V26.8H
    FMAXV  S23, V9.4S
    FCVTZU  V13.4H, V23.4H, #5
    UMLSL  V7.2D, V24.2S, V4.2S
    UADALP  V28.2S, V7.4H
    MUL  V8.4S, V19.4S, V19.S[0x3]
    FCMEQ  V30.2S, V13.2S, V8.2S
    FMAXP S24, V30.2S
    BIC  V9.16B, V24.16B, V17.16B
    SHRN2 V23.4S, V9.2D, #13
    RADDHN2  V26.8H, V28.4S, V23.4S
    SMINV  H9, V7.8H
    UADDW  V23.8H, V15.8H, V3.8B
    UMAXV  H13, V24.8H
    FRINTI  V4.2D, V9.2D
    SRSRA  V8.2S, V4.2S, #30
    FMAXNMV  S7, V23.4S
    SLI V18.2D, V20.2D, #0x39
    SQSHRN2 V29.8H, V19.4S, #10
    FMAXNMP S28, V3.2S
    SQRSHRN V15.8B, V16.8H, #6
    UXTL V23.4S, V6.4H
    FMULX D6, D3, V28.D[0x0]
    TBL  V4.8B, { V6.16B, V7.16B, V8.16B }, V6.8B
    UMLAL2 V8.4S, V26.8H, V15.H[0x6]
    SQDMLSL2  V19.4S, V8.8H, V29.8H
    MLA  V26.16B, V4.16B, V18.16B
    UMLSL V15.2D, V23.2S, V11.S[0x0]
    SQSHRN V3.8B, V15.8H, #6
    SQDMLAL  V6.2D, V3.2S, V3.2S
    TRN1  V11.4H, V6.4H, V19.4H
    SSRA V15.2D, V26.2D, #64
    SQRSHRN2 V20.16B, V11.8H, #7
    FADD  V23.4S, V13.4S, V20.4S
    SSHL  V9.8H, V15.8H, V23.8H
    FRINTZ  V6.8H, V21.8H
    URSRA  V17.2S, V19.2S, #30
    UQSUB  V16.16B, V7.16B, V24.16B
    UQXTN2  V28.16B, V1.8H
    FMUL V21.2D, V4.2D, V4.D[0x0]
    FMAX  V3.8H, V25.8H, V28.8H
    SMLAL V1.2D, V3.2S, V2.S[0x2]
    SQRSHRN2 V6.4S, V15.2D, #7
    FMAXV  H28, V19.4H
    MOV V26.B[0x8], W15
    FDIV  V19.2D, V30.2D, V24.2D
    URSQRTE  V15.4S, V28.4S
    SRSHR  V13.8H, V19.8H, #10
    SQSHRUN2 V11.4S, V7.2D, #3
    ADDV  H29, V9.8H
    UZP1  V8.16B, V17.16B, V17.16B
    SQRSHRUN2 V24.16B, V6.8H, #5
    FMLS V30.2D, V18.2D, V21.D[0x0]
    SMOV W27, V16.H[0x1]
    SHA256SU1  V4.4S, V18.4S, V24.4S
    UMLSL V19.4S, V4.4H, V1.H[0x4]
    FMAXV  S18, V19.4S
    FMAXP  V7.4H, V13.4H, V5.4H
    SQSHRN2 V17.4S, V26.2D, #3
    BSL  V9.16B, V11.16B, V11.16B
    BSL  V13.16B, V14.16B, V29.16B
    SHA1M  Q20, S7, V15.4S
    SQSHLU  V11.8H, V30.8H, #0x1
    URSHR  V3.4S, V18.4S, #32
    UADDLV  H23, V13.8B
    SMOV  X27, V23.H[0x1]
    UABDL2  V28.4S, V18.8H, V2.8H
    ADDP  D7, V3.2D
    SABDL  V30.2D, V28.2S, V17.2S
    FMLS  V13.8H, V7.8H, V7.8H
    FMLA  V21.2S, V8.2S, V9.2S
    FCVTZU  V23.2S, V30.2S, #22
    USHLL V18.8H, V23.8B, #0x4
    UXTL V17.4S, V15.4H
    FMAXP H2, V20.2H
    SRSHR  V3.8B, V11.8B, #7
    FMLA D11, D7, V2.D[0x1]
    CMGT  V7.8H, V11.8H, #0
    DUP D28, V21.D[0x1]
    FRINTM  V14.4S, V27.4S
    SQDMLSL S29, H14, V13.H[0x1]
    URSHR  V13.4S, V29.4S, #12
    SQDMLAL  V15.2D, V13.2S, V7.2S
    USHLL V21.2D, V15.2S, #0x19
    MOV V13.B[0x5], V21.B[0x4]
    SQDMULL2 V4.2D, V13.4S, V3.S[0x3]
    SABDL  V8.2D, V28.2S, V4.2S
    FMULX V15.2S, V8.2S, V17.S[0x0]
    DUP V11.2D, V20.D[0x0]
    MOV V7.S[0x1], W17
    SSUBW2  V2.2D, V11.2D, V18.4S
    SQSHRN2 V13.4S, V7.2D, #23
    FSUB  V23.8H, V13.8H, V2.8H
    UCVTF  V30.2S, V23.2S, #22
    FABD  V27.2S, V15.2S, V15.2S
    SQRSHRN2 V15.4S, V27.2D, #16
    URSHR  V13.8B, V30.8B, #2
    SMAXV  S30, V19.4S
    FCMLE  V8.4H, V15.4H, #0.0
    RBIT  V23.16B, V13.16B
    ADDP  D29, V8.2D
    USUBW  V28.4S, V30.4S, V30.4H
    ADDP  D18, V26.2D
    FCVTN  V27.4H, V18.4S
    SQSUB  V14.4S, V23.4S, V27.4S
    SQDMULL  V3.4S, V28.4H, V29.4H
    SHL V19.2D, V3.2D, #0x1d
    DUP V30.2D, V19.D[0x0]
    FCMGE  V13.8H, V14.8H, V30.8H
    SSHR  V11.16B, V24.16B, #6
    FRINTA  V24.8H, V8.8H
    UQSHRN2 V28.16B, V1.8H, #7
    SQSUB  V3.4H, V15.4H, V6.4H
    URSHL  V27.2D, V0.2D, V29.2D
    UQRSHRN V0.4H, V12.4S, #9
    TRN1  V12.4H, V2.4H, V19.4H
    UHADD  V8.8H, V15.8H, V7.8H
    FMLA  V6.4H, V12.4H, V13.4H
    UMULL  V1.8H, V0.8B, V11.8B
    SMULL V0.4S, V8.4H, V8.H[0x5]
    ORR  V30.16B, V27.16B, V0.16B
    SXTL V2.2D, V6.2S
    SQRSHRN2 V6.4S, V1.2D, #5
    SQRSHRN2 V14.8H, V30.4S, #2
    URSRA  V11.2S, V2.2S, #6
    FCVTZS  V29.8H, V14.8H, #14
    FMAXNMP H12, V3.2H
    SMAXV  H27, V6.4H
    FCMGE  V14.2D, V11.2D, #0.0
    SQDMLAL D11, S29, V28.S[0x3]
    AESD  V23.16B, V12.16B
    UADDW  V2.2D, V27.2D, V24.2S
    TBL  V0.8B, { V7.16B, V8.16B }, V2.8B
    SQSHRUN V1.8B, V0.8H, #3
    FMUL D3, D14, V11.D[0x0]
    UADDW  V13.4S, V1.4S, V3.4H
    DUP  V6.2S, V13.S[0x3]
    FCVTAU  V30.8H, V6.8H
    SQRSHRUN V8.4H, V30.4S, #13
    SHLL2  V30.2D, V11.4S, #32
    SHLL  V28.2D, V8.2S, #32
    FABD  V29.4H, V23.4H, V28.4H
    UMLAL  V1.8H, V30.8B, V19.8B
    FCMLT  V12.8H, V1.8H, #0.0
    SUBS  X2, X2, #0x1
    B.NE  TSRTAdvsimdVectorAllOperation_label_20
    MOVZ  X24, #0x0, LSL #0
    SUB  X9, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X9, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X9, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X9, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X9, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X9, X24, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X9, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X9, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X9, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X9, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X9, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X9, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X9, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X9, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X9, X24, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X9, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X9, X24, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X9, X24, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X9, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X9, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X9, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x9f, LSL #0
    MOVK  X24, #0x800, LSL #16
    MRS  X9, FPSR
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, V0.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, D0
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, V1.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, D1
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    FMOV  X9, V2.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    FMOV  X9, D2
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, V3.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    FMOV  X9, D3
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, V4.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, D4
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, V5.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xff90, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    FMOV  X9, D5
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, V6.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #32
    FMOV  X9, D6
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, V7.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    FMOV  X9, D7
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, V8.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, D8
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x2027, LSL #0
    MOVK  X24, #0x21, LSL #16
    FMOV  X9, V9.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x41c1, LSL #0
    FMOV  X9, D9
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, V10.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    FMOV  X9, D10
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, V11.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x3ff, LSL #0
    FMOV  X9, D11
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, V12.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, D12
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #32
    FMOV  X9, V13.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #32
    FMOV  X9, D13
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    FMOV  X9, V14.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    FMOV  X9, D14
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, V15.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, D15
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, V16.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, D16
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #32
    FMOV  X9, V17.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #32
    FMOV  X9, D17
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, V18.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xd4ff, LSL #0
    MOVK  X24, #0xd400, LSL #16
    MOVK  X24, #0xd401, LSL #32
    MOVK  X24, #0xd400, LSL #48
    FMOV  X9, D18
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x1ffe, LSL #32
    MOVK  X24, #0x4000, LSL #48
    FMOV  X9, V19.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, D19
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x5e6a, LSL #0
    MOVK  X24, #0x85b6, LSL #16
    MOVK  X24, #0xb18a, LSL #32
    MOVK  X24, #0xf825, LSL #48
    FMOV  X9, V20.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x670f, LSL #0
    MOVK  X24, #0x83a6, LSL #16
    MOVK  X24, #0x19cb, LSL #32
    MOVK  X24, #0xcbf1, LSL #48
    FMOV  X9, D20
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xfe00, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0x1ff, LSL #48
    FMOV  X9, V21.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xfe00, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0x1ff, LSL #48
    FMOV  X9, D21
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x8000, LSL #48
    FMOV  X9, V22.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x8000, LSL #48
    FMOV  X9, D22
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x1c52, LSL #0
    MOVK  X24, #0x5230, LSL #16
    MOVK  X24, #0x5252, LSL #32
    MOVK  X24, #0x178c, LSL #48
    FMOV  X9, V23.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x5252, LSL #0
    MOVK  X24, #0x9752, LSL #16
    MOVK  X24, #0x556a, LSL #32
    MOVK  X24, #0x5252, LSL #48
    FMOV  X9, D23
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, V24.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    FMOV  X9, D24
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    FMOV  X9, V25.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    FMOV  X9, D25
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xff, LSL #0
    MOVK  X24, #0x1, LSL #32
    FMOV  X9, V26.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0xd400, LSL #0
    MOVK  X24, #0xd400, LSL #16
    MOVK  X24, #0xd400, LSL #32
    MOVK  X24, #0xd400, LSL #48
    FMOV  X9, D26
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, V27.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, D27
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, V28.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, D28
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, V29.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x5252, LSL #0
    MOVK  X24, #0x1752, LSL #16
    MOVK  X24, #0x556a, LSL #32
    MOVK  X24, #0x5252, LSL #48
    FMOV  X9, D29
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, V30.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, D30
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X9, V31.D[1]
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x2900, LSL #48
    FMOV  X9, D31
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorAllOperation_TestFail

TSRTAdvsimdVectorAllOperation_TestEnd:
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
TSRTAdvsimdVectorAllOperation_TestFail:
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
