.global TSRTAdvsimdVectorGeneralOperation

.text
.p2align 4

TSRTAdvsimdVectorGeneralOperation:

TSRTAdvsimdVectorGeneralOperation_TestBegin:
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
    MOVZ  X2, #0x8dd, LSL #0
    MOVK  X2, #0x4ebf, LSL #16
    MOVK  X2, #0x51e6, LSL #32
    MOVK  X2, #0x2dd9, LSL #48
    MOVZ  X4, #0xb411, LSL #0
    MOVK  X4, #0x106f, LSL #16
    MOVK  X4, #0x84a4, LSL #32
    MOVK  X4, #0x870f, LSL #48
    MOVZ  X5, #0x844f, LSL #0
    MOVK  X5, #0x53a1, LSL #16
    MOVK  X5, #0xfdc9, LSL #32
    MOVK  X5, #0x330f, LSL #48
    MOVZ  X6, #0xb5e3, LSL #0
    MOVK  X6, #0x41e3, LSL #16
    MOVK  X6, #0x6ad, LSL #32
    MOVK  X6, #0xb3e8, LSL #48
    MOVZ  X7, #0x5315, LSL #0
    MOVK  X7, #0xe376, LSL #16
    MOVK  X7, #0x970c, LSL #32
    MOVK  X7, #0x589, LSL #48
    MOVZ  X8, #0x7f9f, LSL #0
    MOVK  X8, #0xf354, LSL #16
    MOVK  X8, #0x529c, LSL #32
    MOVK  X8, #0xed04, LSL #48
    MOVZ  X9, #0xd385, LSL #0
    MOVK  X9, #0x3680, LSL #16
    MOVK  X9, #0xb60a, LSL #32
    MOVK  X9, #0xf253, LSL #48
    MOVZ  X10, #0x4e89, LSL #0
    MOVK  X10, #0xf474, LSL #16
    MOVK  X10, #0x1a3b, LSL #32
    MOVK  X10, #0xb4f3, LSL #48
    MOVZ  X11, #0x6fcc, LSL #0
    MOVK  X11, #0xd93e, LSL #16
    MOVK  X11, #0xbc0a, LSL #32
    MOVK  X11, #0x1025, LSL #48
    MOVZ  X13, #0x4097, LSL #0
    MOVK  X13, #0x734e, LSL #16
    MOVK  X13, #0x22fb, LSL #32
    MOVK  X13, #0xd2cc, LSL #48
    MOVZ  X14, #0x93a5, LSL #0
    MOVK  X14, #0x740d, LSL #16
    MOVK  X14, #0x89d1, LSL #32
    MOVK  X14, #0xf46b, LSL #48
    MOVZ  X15, #0x9fde, LSL #0
    MOVK  X15, #0x983d, LSL #16
    MOVK  X15, #0x47f4, LSL #32
    MOVK  X15, #0xaadb, LSL #48
    MOVZ  X16, #0x7037, LSL #0
    MOVK  X16, #0xb215, LSL #16
    MOVK  X16, #0x523a, LSL #32
    MOVK  X16, #0xa3c4, LSL #48
    MOVZ  X17, #0xb6b1, LSL #0
    MOVK  X17, #0x1b92, LSL #16
    MOVK  X17, #0xe36e, LSL #32
    MOVK  X17, #0xa017, LSL #48
    MOVZ  X18, #0x3805, LSL #0
    MOVK  X18, #0xf072, LSL #16
    MOVK  X18, #0xc55d, LSL #32
    MOVK  X18, #0xc98b, LSL #48
    MOVZ  X19, #0x4b62, LSL #0
    MOVK  X19, #0xb542, LSL #16
    MOVK  X19, #0x8c64, LSL #32
    MOVK  X19, #0xfeae, LSL #48
    MOVZ  X20, #0x9ab0, LSL #0
    MOVK  X20, #0x91c8, LSL #16
    MOVK  X20, #0xe18e, LSL #32
    MOVK  X20, #0xad04, LSL #48
    MOVZ  X21, #0x2622, LSL #0
    MOVK  X21, #0x68fa, LSL #16
    MOVK  X21, #0x8317, LSL #32
    MOVK  X21, #0x3d55, LSL #48
    MOVZ  X23, #0x7af1, LSL #0
    MOVK  X23, #0x4d71, LSL #16
    MOVK  X23, #0x7c6, LSL #32
    MOVK  X23, #0xbcf7, LSL #48
    MOVZ  X24, #0x2fe, LSL #0
    MOVK  X24, #0xd01, LSL #16
    MOVK  X24, #0x29b8, LSL #32
    MOVK  X24, #0x70e4, LSL #48
    MOVZ  X25, #0xd13b, LSL #0
    MOVK  X25, #0xe7c4, LSL #16
    MOVK  X25, #0xd477, LSL #32
    MOVK  X25, #0x2e59, LSL #48
    MOVZ  X26, #0x6599, LSL #0
    MOVK  X26, #0xaf7c, LSL #16
    MOVK  X26, #0xd798, LSL #32
    MOVK  X26, #0x3d72, LSL #48
    MOVZ  X27, #0xc92a, LSL #0
    MOVK  X27, #0x6445, LSL #16
    MOVK  X27, #0x2c0c, LSL #32
    MOVK  X27, #0x21c4, LSL #48
    MOVZ  X28, #0xc2f6, LSL #0
    MOVK  X28, #0x5d5a, LSL #16
    MOVK  X28, #0xb3b8, LSL #32
    MOVK  X28, #0x3762, LSL #48
    MOVZ  X5, #0x8398, LSL #0
    MOVK  X5, #0x7ed0, LSL #16
    MOVK  X5, #0x9a89, LSL #32
    MOVK  X5, #0x144, LSL #48
    MSR  FPCR, X5
    MOVZ  X5, #0x67ad, LSL #0
    MOVK  X5, #0x10f9, LSL #16
    MOVK  X5, #0x7ad4, LSL #32
    MOVK  X5, #0x273e, LSL #48
    MSR  FPSR, X5
    MRS  X10, FPSR
    MOVZ  X19, #0xff60, LSL #0
    MOVK  X19, #0x7ff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    AND  X10, X10, X19
    MOVZ  X19, #0x0, LSL #0
    ORR  X10, X10, X19
    MSR  FPSR, X10
    ISB  SY
    SUBS  W7, W4, #0x5fa
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x926e, LSL #0
    MOVK  X2, #0x6ff6, LSL #16
    MOVK  X2, #0xb6c, LSL #32
    MOVK  X2, #0x9e5a, LSL #48
    MOVZ  X4, #0xafb2, LSL #0
    MOVK  X4, #0x936a, LSL #16
    MOVK  X4, #0x9ce0, LSL #32
    MOVK  X4, #0xecfd, LSL #48
    MOVZ  X5, #0x6b1d, LSL #0
    MOVK  X5, #0xfae3, LSL #16
    MOVK  X5, #0x7b39, LSL #32
    MOVK  X5, #0x9cc6, LSL #48
    MOVZ  X6, #0x6fca, LSL #0
    MOVK  X6, #0x7a1f, LSL #16
    MOVK  X6, #0x30a9, LSL #32
    MOVK  X6, #0x607d, LSL #48
    MOVZ  X7, #0xda1b, LSL #0
    MOVK  X7, #0xe420, LSL #16
    MOVK  X7, #0x519b, LSL #32
    MOVK  X7, #0x9b8a, LSL #48
    MOVZ  X8, #0x7e4, LSL #0
    MOVK  X8, #0x5895, LSL #16
    MOVK  X8, #0x467c, LSL #32
    MOVK  X8, #0xe889, LSL #48
    MOVZ  X9, #0x4cb7, LSL #0
    MOVK  X9, #0xf32, LSL #16
    MOVK  X9, #0xc06f, LSL #32
    MOVK  X9, #0x2cfc, LSL #48
    MOVZ  X10, #0x2fe8, LSL #0
    MOVK  X10, #0x6c84, LSL #16
    MOVK  X10, #0xec00, LSL #32
    MOVK  X10, #0xd8e8, LSL #48
    MOVZ  X11, #0xb69d, LSL #0
    MOVK  X11, #0x7d20, LSL #16
    MOVK  X11, #0x701, LSL #32
    MOVK  X11, #0x9c12, LSL #48
    MOVZ  X13, #0xef7d, LSL #0
    MOVK  X13, #0x62e3, LSL #16
    MOVK  X13, #0x65a9, LSL #32
    MOVK  X13, #0xb148, LSL #48
    MOVZ  X14, #0x8442, LSL #0
    MOVK  X14, #0x54af, LSL #16
    MOVK  X14, #0x13c, LSL #32
    MOVK  X14, #0x72eb, LSL #48
    MOVZ  X15, #0x96fc, LSL #0
    MOVK  X15, #0xcb00, LSL #16
    MOVK  X15, #0x2a0d, LSL #32
    MOVK  X15, #0xfbcc, LSL #48
    MOVZ  X16, #0xd523, LSL #0
    MOVK  X16, #0xd98a, LSL #16
    MOVK  X16, #0xa636, LSL #32
    MOVK  X16, #0x437a, LSL #48
    MOVZ  X17, #0x6e21, LSL #0
    MOVK  X17, #0x5550, LSL #16
    MOVK  X17, #0x9749, LSL #32
    MOVK  X17, #0x180a, LSL #48
    MOVZ  X18, #0x953, LSL #0
    MOVK  X18, #0xba1f, LSL #16
    MOVK  X18, #0x1b5c, LSL #32
    MOVK  X18, #0x33e9, LSL #48
    MOVZ  X19, #0x471b, LSL #0
    MOVK  X19, #0x4967, LSL #16
    MOVK  X19, #0x8952, LSL #32
    MOVK  X19, #0x4929, LSL #48
    MOVZ  X20, #0x925e, LSL #0
    MOVK  X20, #0x708d, LSL #16
    MOVK  X20, #0x5b1f, LSL #32
    MOVK  X20, #0xbb36, LSL #48
    MOVZ  X21, #0xbf3b, LSL #0
    MOVK  X21, #0x7953, LSL #16
    MOVK  X21, #0x5b85, LSL #32
    MOVK  X21, #0x51f0, LSL #48
    MOVZ  X23, #0xb5ce, LSL #0
    MOVK  X23, #0xcf4c, LSL #16
    MOVK  X23, #0xc901, LSL #32
    MOVK  X23, #0x713a, LSL #48
    MOVZ  X24, #0x483c, LSL #0
    MOVK  X24, #0x8f4c, LSL #16
    MOVK  X24, #0x637b, LSL #32
    MOVK  X24, #0xfbce, LSL #48
    MOVZ  X25, #0x4db4, LSL #0
    MOVK  X25, #0xf8e4, LSL #16
    MOVK  X25, #0x42a1, LSL #32
    MOVK  X25, #0xb7c3, LSL #48
    MOVZ  X26, #0x2feb, LSL #0
    MOVK  X26, #0xc5e2, LSL #16
    MOVK  X26, #0xb7d0, LSL #32
    MOVK  X26, #0x845e, LSL #48
    MOVZ  X27, #0x2950, LSL #0
    MOVK  X27, #0x3927, LSL #16
    MOVK  X27, #0x4160, LSL #32
    MOVK  X27, #0x7aae, LSL #48
    MOVZ  X28, #0x6655, LSL #0
    MOVK  X28, #0x464d, LSL #16
    MOVK  X28, #0xd60d, LSL #32
    MOVK  X28, #0xe3ac, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X25
    FMOV  D1, X26
    FMOV  V1.D[1], X21
    FMOV  D2, X23
    FMOV  V2.D[1], X28
    FMOV  D3, X2
    FMOV  V3.D[1], X19
    FMOV  D4, X10
    FMOV  V4.D[1], X21
    FMOV  D5, X17
    FMOV  V5.D[1], X23
    FMOV  D6, X16
    FMOV  V6.D[1], X4
    FMOV  D7, X11
    FMOV  V7.D[1], X14
    FMOV  D8, X16
    FMOV  V8.D[1], X4
    FMOV  D9, X24
    FMOV  V9.D[1], X28
    FMOV  D10, X15
    FMOV  V10.D[1], X19
    FMOV  D11, X21
    FMOV  V11.D[1], X2
    FMOV  D12, X8
    FMOV  V12.D[1], X13
    FMOV  D13, X21
    FMOV  V13.D[1], X23
    FMOV  D14, X5
    FMOV  V14.D[1], X24
    FMOV  D15, X26
    FMOV  V15.D[1], X17
    FMOV  D16, X27
    FMOV  V16.D[1], X21
    FMOV  D17, X14
    FMOV  V17.D[1], X23
    FMOV  D18, X5
    FMOV  V18.D[1], X24
    FMOV  D19, X7
    FMOV  V19.D[1], X17
    FMOV  D20, X19
    FMOV  V20.D[1], X13
    FMOV  D21, X20
    FMOV  V21.D[1], X2
    FMOV  D22, X6
    FMOV  V22.D[1], X23
    FMOV  D23, X27
    FMOV  V23.D[1], X2
    FMOV  D24, X26
    FMOV  V24.D[1], X9
    FMOV  D25, X28
    FMOV  V25.D[1], X25
    FMOV  D26, X10
    FMOV  V26.D[1], X20
    FMOV  D27, X17
    FMOV  V27.D[1], X5
    FMOV  D28, X11
    FMOV  V28.D[1], X18
    FMOV  D29, X15
    FMOV  V29.D[1], X21
    FMOV  D30, X2
    FMOV  V30.D[1], X16
    FMOV  D31, X23
    FMOV  V31.D[1], X13
    MOVZ  X14, #0xf, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_0:
    MOVI  V7.4H, #0x96, LSL #8
    DUP V7.2D, X17
    MOV  X26, V31.D[0x0]
    MOV  X17, V26.D[0x0]
    INS V11.H[0x0], W28
    TBL  V8.8B, { V11.16B, V12.16B }, V30.8B
    DUP D14, V8.D[0x1]
    AESE  V27.16B, V7.16B
    MOV V23.H[0x7], V28.H[0x3]
    DUP H27, V29.H[0x0]
    TRN1  V17.2S, V27.2S, V24.2S
    AESE  V31.16B, V23.16B
    SRI  V9.8H, V14.8H, #3
    REV64  V19.16B, V9.16B
    TBL  V23.16B, { V2.16B, V3.16B, V4.16B, V5.16B }, V19.16B
    ADD  V24.2D, V17.2D, V17.2D
    SLI  V18.16B, V31.16B, #0x0
    INS V29.D[0x0], X2
    MLA  V30.4S, V23.4S, V29.S[0x3]
    MOV V29.H[0x2], V24.H[0x6]
    MOVI  V8.16B, #0xa5
    MOV H7, V17.H[0x5]
    MOV V31.H[0x4], W7
    MUL  V11.2S, V30.2S, V7.2S
    AND  V4.16B, V31.16B, V18.16B
    SLI V31.2D, V4.2D, #0x20
    MVNI  V17.2S, #0xd1, MSL #16
    DUP H27, V8.H[0x2]
    MVNI  V2.8H, #0x57
    ORR  V23.4S, #0x18
    ADD  V7.16B, V29.16B, V23.16B
    RSUBHN2  V14.16B, V29.8H, V11.8H
    MOV V28.D[0x0], X28
    RSHRN V5.4H, V17.4S, #11
    CNT  V3.8B, V27.8B
    MLS  V30.2S, V14.2S, V31.S[0x2]
    ADDHN2  V24.4S, V30.2D, V5.2D
    PMULL2  V8.8H, V30.16B, V24.16B
    REV32  V18.4H, V7.4H
    MLA  V5.8H, V18.8H, V3.H[0x4]
    BIC  V27.4H, #0xa9, LSL #8
    BIT  V4.8B, V8.8B, V5.8B
    MVNI  V8.2S, #0xd6, MSL #16
    MLS  V19.4S, V27.4S, V2.S[0x0]
    REV64  V2.4H, V29.4H
    DUP V7.2D, X16
    XTN  V5.4H, V19.4S
    MVNI  V31.4S, #0x5a, MSL #16
    SHRN V24.2S, V8.2D, #19
    EXT  V24.16B, V4.16B, V24.16B, #0xe
    DUP V18.2D, V31.D[0x1]
    SRI  V17.8B, V2.8B, #2
    DUP D3, V24.D[0x0]
    XTN  V27.2S, V18.2D
    RSHRN2 V2.16B, V5.8H, #8
    SHL  V18.8H, V7.8H, #0x6
    NEG  V24.4H, V17.4H
    MOVI  V30.8B, #0xb5
    AESE  V19.16B, V30.16B
    MUL  V17.4H, V19.4H, V9.H[0x5]
    MOV V7.D[0x1], X26
    MOV H29, V24.H[0x1]
    AESD  V5.16B, V3.16B
    DUP  V3.16B, V29.B[0xd]
    RSHRN V4.2S, V18.2D, #19
    MOVI  V31.2S, #0x25, MSL #16
    SHL V30.2D, V17.2D, #0x6
    MOV V17.D[0x1], X5
    MOV H24, V2.H[0x6]
    SHL  V18.4H, V17.4H, #0x6
    MVNI  V8.4S, #0xcf, MSL #8
    RSHRN2 V21.8H, V27.4S, #2
    SHRN V27.4H, V21.4S, #4
    INS V19.B[0xd], V27.B[0x4]
    MVNI  V21.2S, #0x8c, MSL #16
    DUP V29.8H, W23
    ZIP1  V27.4H, V19.4H, V18.4H
    ABS  V19.16B, V30.16B
    ZIP2  V9.8H, V4.8H, V31.8H
    TBX  V18.8B, { V27.16B }, V7.8B
    DUP D17, V3.D[0x1]
    BIC  V3.16B, V5.16B, V5.16B
    SHRN2 V5.16B, V3.8H, #3
    ADDP  D2, V29.2D
    SHLL  V29.4S, V9.4H, #16
    NOT  V9.16B, V24.16B
    RSHRN2 V7.16B, V17.8H, #7
    SLI  V24.4H, V21.4H, #0xc
    MLA  V3.8H, V18.8H, V9.8H
    MOV V4.D[0x1], X24
    AESIMC  V17.16B, V5.16B
    SRI  V18.8H, V8.8H, #8
    ADDV  H31, V3.4H
    RSHRN V21.4H, V29.4S, #16
    DUP  V29.16B, V17.B[0xb]
    SHRN V27.8B, V11.8H, #8
    TBL  V8.8B, { V21.16B, V22.16B }, V29.8B
    INS V30.H[0x3], V31.H[0x1]
    ORR  V29.16B, V18.16B, V8.16B
    BIC  V5.16B, V2.16B, V19.16B
    MOV H17, V5.H[0x6]
    MOVI  V11.4S, #0xb3, MSL #16
    TBL  V3.8B, { V17.16B }, V11.8B
    MOV V8.H[0x3], W15
    UZP1  V9.4H, V24.4H, V24.4H
    MOVI  V22.8H, #0xf9, LSL #8
    MOVI  V21.2S, #0x31, LSL #8
    DUP V5.2D, V4.D[0x0]
    SHLL  V31.8H, V27.8B, #8
    MOV V18.B[0x4], V29.B[0x0]
    BIC  V17.8H, #0x1
    DUP B2, V22.B[0x9]
    TBL  V24.8B, { V27.16B, V28.16B }, V2.8B
    SLI  V22.2S, V21.2S, #0x1d
    ORR  V2.4S, #0xc9, LSL #16
    REV64  V4.8B, V8.8B
    DUP S28, V30.S[0x0]
    MLA  V11.4H, V3.4H, V15.H[0x3]
    TBL  V27.16B, { V18.16B, V19.16B }, V9.16B
    SLI V21.2D, V28.2D, #0x17
    INS V28.D[0x0], V5.D[0x0]
    UZP1  V18.4H, V4.4H, V31.4H
    RSHRN2 V9.16B, V17.8H, #2
    SHRN V17.2S, V11.2D, #32
    MLS  V29.16B, V28.16B, V24.16B
    EOR  V28.8B, V29.8B, V27.8B
    INS V8.B[0xe], W15
    ADDHN  V19.8B, V21.8H, V22.8H
    TRN2  V31.2S, V2.2S, V9.2S
    ADDV  B9, V18.16B
    MOV V18.H[0x7], W21
    INS V2.H[0x3], W6
    XTN2  V5.4S, V28.2D
    RSHRN V28.4H, V13.4S, #2
    DUP D29, V19.D[0x0]
    ORR  V11.4S, #0x0, LSL #16
    MLA  V27.2S, V9.2S, V11.S[0x0]
    MOV  X2, V5.D[0x1]
    PMULL2  V4.1Q, V17.2D, V31.2D
    AND  V17.8B, V2.8B, V18.8B
    INS V2.S[0x0], W15
    UZP1  V19.4H, V2.4H, V17.4H
    INS V21.S[0x2], V19.S[0x2]
    SHRN2 V22.4S, V27.2D, #8
    AESIMC  V24.16B, V21.16B
    MVNI  V19.4S, #0x84
    RADDHN2  V2.4S, V14.2D, V8.2D
    INS V15.H[0x2], V2.H[0x3]
    MOV  V14.8B, V22.8B
    MOV H13, V15.H[0x3]
    DUP  V15.8H, V29.H[0x5]
    TBX  V4.8B, { V4.16B }, V14.8B
    BIC  V29.2S, #0xf7, LSL #16
    MLA  V8.4S, V19.4S, V28.4S
    BIC  V19.4S, #0x5d, LSL #8
    INS V6.D[0x0], V29.D[0x0]
    RADDHN  V27.8B, V15.8H, V24.8H
    XTN  V2.2S, V13.2D
    MOV D14, V8.D[0x0]
    INS V22.B[0x6], V14.B[0x0]
    DUP H21, V4.H[0x2]
    ADDP  V15.4H, V19.4H, V22.4H
    RSHRN2 V28.8H, V2.4S, #16
    PMULL2  V29.1Q, V15.2D, V21.2D
    MOV V21.B[0xe], V29.B[0xd]
    MOV V4.D[0x1], X18
    BSL  V22.16B, V28.16B, V21.16B
    ADDV  H15, V27.8H
    MOVI  V17.4S, #0x3, MSL #8
    MVNI  V14.2S, #0x82, LSL #16
    SRI  V8.2S, V6.2S, #12
    TBX  V19.8B, { V22.16B, V23.16B }, V22.8B
    MLA  V6.8H, V14.8H, V8.8H
    REV32  V13.16B, V4.16B
    INS V23.D[0x1], X26
    RSHRN2 V24.8H, V19.4S, #5
    MOV V2.B[0x9], V17.B[0x5]
    MVNI  V29.2S, #0x2, MSL #16
    ADDV  S22, V29.4S
    SHL V14.2D, V23.2D, #0x31
    INS V28.D[0x1], X15
    ADDP  V29.2S, V2.2S, V15.2S
    EXT  V19.8B, V13.8B, V14.8B, #0x6
    RSUBHN  V2.2S, V6.2D, V19.2D
    REV64  V17.8H, V29.8H
    MOV V5.H[0x7], V2.H[0x7]
    RSHRN2 V2.8H, V25.4S, #13
    ZIP1  V4.8B, V27.8B, V5.8B
    MOV  X25, V10.D[0x1]
    RSUBHN2  V10.16B, V24.8H, V22.8H
    REV64  V29.4H, V2.4H
    DUP  V14.4H, V29.H[0x0]
    SHL  V5.16B, V10.16B, #0x4
    MOV V10.B[0x7], W26
    EXT  V27.8B, V28.8B, V14.8B, #0x5
    INS V15.B[0x8], V5.B[0x8]
    MVNI  V2.2S, #0x18, MSL #8
    SRI  V14.8B, V10.8B, #2
    ADDV  B29, V14.8B
    MOV V14.D[0x1], V17.D[0x1]
    SUBS  X14, X14, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_0
    MOVZ  X9, #0x3000, LSL #0
    MOVK  X9, #0x30cf, LSL #16
    SUB  X11, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x6b1d, LSL #0
    MOVK  X9, #0xfae3, LSL #16
    MOVK  X9, #0x7b39, LSL #32
    MOVK  X9, #0x9cc6, LSL #48
    SUB  X11, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x6fca, LSL #0
    MOVK  X9, #0x7a1f, LSL #16
    MOVK  X9, #0x30a9, LSL #32
    MOVK  X9, #0x607d, LSL #48
    SUB  X11, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0xda1b, LSL #0
    MOVK  X9, #0xe420, LSL #16
    MOVK  X9, #0x519b, LSL #32
    MOVK  X9, #0x9b8a, LSL #48
    SUB  X11, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x7e4, LSL #0
    MOVK  X9, #0x5895, LSL #16
    MOVK  X9, #0x467c, LSL #32
    MOVK  X9, #0xe889, LSL #48
    SUB  X11, X9, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x2fe8, LSL #0
    MOVK  X9, #0x6c84, LSL #16
    MOVK  X9, #0xec00, LSL #32
    MOVK  X9, #0xd8e8, LSL #48
    SUB  X11, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0xef7d, LSL #0
    MOVK  X9, #0x62e3, LSL #16
    MOVK  X9, #0x65a9, LSL #32
    MOVK  X9, #0xb148, LSL #48
    SUB  X11, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x96fc, LSL #0
    MOVK  X9, #0xcb00, LSL #16
    MOVK  X9, #0x2a0d, LSL #32
    MOVK  X9, #0xfbcc, LSL #48
    SUB  X11, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0xd523, LSL #0
    MOVK  X9, #0xd98a, LSL #16
    MOVK  X9, #0xa636, LSL #32
    MOVK  X9, #0x437a, LSL #48
    SUB  X11, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x2fe8, LSL #0
    MOVK  X9, #0x6c84, LSL #16
    MOVK  X9, #0xec00, LSL #32
    MOVK  X9, #0xd8e8, LSL #48
    SUB  X11, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x953, LSL #0
    MOVK  X9, #0xba1f, LSL #16
    MOVK  X9, #0x1b5c, LSL #32
    MOVK  X9, #0x33e9, LSL #48
    SUB  X11, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x471b, LSL #0
    MOVK  X9, #0x4967, LSL #16
    MOVK  X9, #0x8952, LSL #32
    MOVK  X9, #0x4929, LSL #48
    SUB  X11, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x925e, LSL #0
    MOVK  X9, #0x708d, LSL #16
    MOVK  X9, #0x5b1f, LSL #32
    MOVK  X9, #0xbb36, LSL #48
    SUB  X11, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0xbf3b, LSL #0
    MOVK  X9, #0x7953, LSL #16
    MOVK  X9, #0x5b85, LSL #32
    MOVK  X9, #0x51f0, LSL #48
    SUB  X11, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0xb5ce, LSL #0
    MOVK  X9, #0xcf4c, LSL #16
    MOVK  X9, #0xc901, LSL #32
    MOVK  X9, #0x713a, LSL #48
    SUB  X11, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x483c, LSL #0
    MOVK  X9, #0x8f4c, LSL #16
    MOVK  X9, #0x637b, LSL #32
    MOVK  X9, #0xfbce, LSL #48
    SUB  X11, X9, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x6736, LSL #0
    MOVK  X9, #0x500, LSL #32
    SUB  X11, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xc9, LSL #16
    SUB  X11, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x2950, LSL #0
    MOVK  X9, #0x3927, LSL #16
    MOVK  X9, #0x4160, LSL #32
    MOVK  X9, #0x7aae, LSL #48
    SUB  X11, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x6655, LSL #0
    MOVK  X9, #0x464d, LSL #16
    MOVK  X9, #0xd60d, LSL #32
    MOVK  X9, #0xe3ac, LSL #48
    SUB  X11, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    MRS  X11, FPSR
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x4db4, LSL #0
    MOVK  X9, #0xf8e4, LSL #16
    MOVK  X9, #0x42a1, LSL #32
    MOVK  X9, #0xb7c3, LSL #48
    FMOV  X11, V0.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x483c, LSL #0
    MOVK  X9, #0x8f4c, LSL #16
    MOVK  X9, #0x637b, LSL #32
    MOVK  X9, #0xfbce, LSL #48
    FMOV  X11, D0
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0xbf3b, LSL #0
    MOVK  X9, #0x7953, LSL #16
    MOVK  X9, #0x5b85, LSL #32
    MOVK  X9, #0x51f0, LSL #48
    FMOV  X11, V1.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x2feb, LSL #0
    MOVK  X9, #0xc5e2, LSL #16
    MOVK  X9, #0xb7d0, LSL #32
    MOVK  X9, #0x845e, LSL #48
    FMOV  X11, D1
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V2.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0xe700, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xe700, LSL #32
    MOVK  X9, #0xffff, LSL #48
    FMOV  X11, D2
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V3.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D3
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V4.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x5036, LSL #0
    MOVK  X9, #0xc67, LSL #16
    MOVK  X9, #0xb000, LSL #32
    MOVK  X9, #0x1100, LSL #48
    FMOV  X11, D4
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x7060, LSL #0
    MOVK  X9, #0x5000, LSL #32
    FMOV  X11, V5.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x60c0, LSL #0
    MOVK  X9, #0xb000, LSL #16
    MOVK  X9, #0xa0d0, LSL #32
    MOVK  X9, #0xc0, LSL #48
    FMOV  X11, D5
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0xafb2, LSL #0
    MOVK  X9, #0x936a, LSL #16
    MOVK  X9, #0x9ce0, LSL #32
    MOVK  X9, #0xecfd, LSL #48
    FMOV  X11, V6.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x88a9, LSL #0
    MOVK  X9, #0x1885, LSL #16
    MOVK  X9, #0xf190, LSL #48
    FMOV  X11, D6
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V7.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0xd523, LSL #0
    MOVK  X9, #0xd98a, LSL #16
    MOVK  X9, #0xa636, LSL #32
    MOVK  X9, #0x437a, LSL #48
    FMOV  X11, D7
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V8.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x9081, LSL #0
    MOVK  X9, #0x1, LSL #16
    MOVK  X9, #0x8cd0, LSL #48
    FMOV  X11, D8
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V9.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x92, LSL #0
    FMOV  X11, D9
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x6736, LSL #0
    MOVK  X9, #0x500, LSL #32
    FMOV  X11, V10.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x96fc, LSL #0
    MOVK  X9, #0xcb00, LSL #16
    MOVK  X9, #0x2a0d, LSL #32
    MOVK  X9, #0xcc, LSL #48
    FMOV  X11, D10
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V11.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xb3, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xb3, LSL #48
    FMOV  X11, D11
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0xef7d, LSL #0
    MOVK  X9, #0x62e3, LSL #16
    MOVK  X9, #0x65a9, LSL #32
    MOVK  X9, #0xb148, LSL #48
    FMOV  X11, V12.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x7e4, LSL #0
    MOVK  X9, #0x5895, LSL #16
    MOVK  X9, #0x467c, LSL #32
    MOVK  X9, #0xe889, LSL #48
    FMOV  X11, D12
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x1fba, LSL #0
    MOVK  X9, #0x5309, LSL #16
    MOVK  X9, #0xe933, LSL #32
    MOVK  X9, #0x5c1b, LSL #48
    FMOV  X11, V13.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D13
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V14.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0xe5ff, LSL #0
    MOVK  X9, #0xf2c0, LSL #16
    MOVK  X9, #0xcac3, LSL #32
    MOVK  X9, #0xc0f3, LSL #48
    FMOV  X11, D14
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x60, LSL #0
    FMOV  X11, V15.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x6736, LSL #0
    FMOV  X11, D15
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0xbf3b, LSL #0
    MOVK  X9, #0x7953, LSL #16
    MOVK  X9, #0x5b85, LSL #32
    MOVK  X9, #0x51f0, LSL #48
    FMOV  X11, V16.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x2950, LSL #0
    MOVK  X9, #0x3927, LSL #16
    MOVK  X9, #0x4160, LSL #32
    MOVK  X9, #0x7aae, LSL #48
    FMOV  X11, D16
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V17.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x6736, LSL #16
    FMOV  X11, D17
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xbf3b, LSL #48
    FMOV  X11, V18.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0xfc96, LSL #0
    FMOV  X11, D18
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V19.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D19
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0xef7d, LSL #0
    MOVK  X9, #0x62e3, LSL #16
    MOVK  X9, #0x65a9, LSL #32
    MOVK  X9, #0xb148, LSL #48
    FMOV  X11, V20.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x471b, LSL #0
    MOVK  X9, #0x4967, LSL #16
    MOVK  X9, #0x8952, LSL #32
    MOVK  X9, #0x4929, LSL #48
    FMOV  X11, D20
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V21.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D21
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V22.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xfffa, LSL #16
    FMOV  X11, D22
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xc9, LSL #16
    FMOV  X11, V23.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x18, LSL #0
    MOVK  X9, #0x18, LSL #32
    FMOV  X11, D23
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x510, LSL #16
    FMOV  X11, V24.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x35c0, LSL #0
    MOVK  X9, #0x66a2, LSL #16
    FMOV  X11, D24
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x4db4, LSL #0
    MOVK  X9, #0xf8e4, LSL #16
    MOVK  X9, #0x42a1, LSL #32
    MOVK  X9, #0xb7c3, LSL #48
    FMOV  X11, V25.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x6655, LSL #0
    MOVK  X9, #0x464d, LSL #16
    MOVK  X9, #0xd60d, LSL #32
    MOVK  X9, #0xe3ac, LSL #48
    FMOV  X11, D25
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x925e, LSL #0
    MOVK  X9, #0x708d, LSL #16
    MOVK  X9, #0x5b1f, LSL #32
    MOVK  X9, #0xbb36, LSL #48
    FMOV  X11, V26.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x2fe8, LSL #0
    MOVK  X9, #0x6c84, LSL #16
    MOVK  X9, #0xec00, LSL #32
    MOVK  X9, #0xd8e8, LSL #48
    FMOV  X11, D26
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V27.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x4d47, LSL #0
    MOVK  X9, #0xfdfa, LSL #16
    MOVK  X9, #0xfdec, LSL #32
    MOVK  X9, #0xfdec, LSL #48
    FMOV  X11, D27
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x96fc, LSL #0
    MOVK  X9, #0xcb00, LSL #16
    MOVK  X9, #0x2a0d, LSL #32
    MOVK  X9, #0xfbcc, LSL #48
    FMOV  X11, V28.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x47ef, LSL #32
    MOVK  X9, #0xfa4d, LSL #48
    FMOV  X11, D28
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V29.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0xd6, LSL #0
    FMOV  X11, D29
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V30.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D30
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V31.D[1]
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xc9, LSL #16
    FMOV  X11, D31
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    FMOV  D0, X25
    FMOV  V0.D[1], X21
    FMOV  D1, X5
    FMOV  V1.D[1], X10
    FMOV  D2, X11
    FMOV  V2.D[1], X17
    FMOV  D3, X28
    FMOV  V3.D[1], X26
    FMOV  D4, X19
    FMOV  V4.D[1], X18
    FMOV  D5, X27
    FMOV  V5.D[1], X23
    FMOV  D6, X20
    FMOV  V6.D[1], X24
    FMOV  D7, X9
    FMOV  V7.D[1], X16
    FMOV  D8, X6
    FMOV  V8.D[1], X28
    FMOV  D9, X5
    FMOV  V9.D[1], X14
    FMOV  D10, X11
    FMOV  V10.D[1], X16
    FMOV  D11, X2
    FMOV  V11.D[1], X13
    FMOV  D12, X19
    FMOV  V12.D[1], X2
    FMOV  D13, X23
    FMOV  V13.D[1], X19
    FMOV  D14, X7
    FMOV  V14.D[1], X28
    FMOV  D15, X23
    FMOV  V15.D[1], X27
    FMOV  D16, X4
    FMOV  V16.D[1], X18
    FMOV  D17, X6
    FMOV  V17.D[1], X27
    FMOV  D18, X28
    FMOV  V18.D[1], X8
    FMOV  D19, X28
    FMOV  V19.D[1], X17
    FMOV  D20, X24
    FMOV  V20.D[1], X18
    FMOV  D21, X26
    FMOV  V21.D[1], X7
    FMOV  D22, X17
    FMOV  V22.D[1], X10
    FMOV  D23, X9
    FMOV  V23.D[1], X16
    FMOV  D24, X6
    FMOV  V24.D[1], X4
    FMOV  D25, X19
    FMOV  V25.D[1], X28
    FMOV  D26, X18
    FMOV  V26.D[1], X4
    FMOV  D27, X15
    FMOV  V27.D[1], X23
    FMOV  D28, X18
    FMOV  V28.D[1], X7
    FMOV  D29, X4
    FMOV  V29.D[1], X27
    FMOV  D30, X8
    FMOV  V30.D[1], X17
    FMOV  D31, X19
    FMOV  V31.D[1], X7
    MOVZ  X7, #0xf, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_1:
    ORR  V12.16B, V18.16B, V27.16B
    ADDHN2  V16.4S, V29.2D, V28.2D
    SUBHN2  V24.4S, V31.2D, V23.2D
    DUP D21, V24.D[0x0]
    MVNI  V8.4S, #0x48, MSL #8
    TBL  V21.8B, { V2.16B, V3.16B, V4.16B }, V21.8B
    CNT  V4.8B, V16.8B
    DUP  V12.4S, V12.S[0x1]
    REV32  V30.8H, V8.8H
    SHRN V21.8B, V21.8H, #4
    SHRN V5.2S, V4.2D, #6
    DUP  V26.16B, V21.B[0x1]
    DUP B16, V26.B[0x3]
    TRN2  V17.2S, V5.2S, V25.2S
    UZP1  V28.8H, V16.8H, V17.8H
    SUBHN2  V31.16B, V12.8H, V28.8H
    TBX  V2.8B, { V6.16B, V7.16B, V8.16B, V9.16B }, V31.8B
    INS V12.H[0x2], V2.H[0x1]
    REV32  V18.16B, V12.16B
    SLI V12.2D, V30.2D, #0x11
    ABS  V18.4H, V18.4H
    SHRN V2.2S, V12.2D, #10
    MOV V23.B[0xa], W27
    AESE  V12.16B, V23.16B
    ABS  V21.2S, V12.2S
    TBX  V30.8B, { V21.16B }, V2.8B
    TBL  V3.16B, { V16.16B, V17.16B, V18.16B, V19.16B }, V30.16B
    ADD  V24.8B, V25.8B, V2.8B
    TBX  V21.8B, { V13.16B, V14.16B }, V4.8B
    MOV V25.D[0x0], V8.D[0x0]
    ADD  V13.4S, V18.4S, V3.4S
    DUP S29, V14.S[0x0]
    INS V6.B[0x4], W11
    SLI  V3.2S, V12.2S, #0x1c
    PMULL  V23.8H, V0.8B, V17.8B
    ADDV  B26, V24.8B
    SHRN V17.2S, V29.2D, #28
    MLS  V14.4H, V21.4H, V24.4H
    SHL V5.2D, V16.2D, #0x1f
    MOV V21.S[0x3], W15
    INS V19.S[0x1], V14.S[0x2]
    RADDHN2  V2.4S, V5.2D, V19.2D
    MVNI  V0.2S, #0x3, MSL #8
    MOV V12.H[0x5], W14
    SRI V8.2D, V17.2D, #43
    SHLL2  V5.8H, V25.16B, #8
    MUL  V18.4H, V3.4H, V0.H[0x1]
    XTN  V14.8B, V21.8H
    ADDV  H21, V18.4H
    MLS  V25.2S, V2.2S, V9.2S
    SLI  V16.4H, V23.4H, #0x9
    SHRN V0.4H, V13.4S, #7
    INS V3.H[0x7], W15
    ORR  V13.4H, #0xfd, LSL #8
    MLA  V4.4H, V26.4H, V12.H[0x3]
    MVNI  V17.8H, #0x17
    DUP S26, V21.S[0x3]
    TBX  V12.8B, { V4.16B, V5.16B }, V8.8B
    TBX  V21.16B, { V13.16B, V14.16B, V15.16B, V16.16B }, V12.16B
    INS V23.S[0x2], W27
    INS V14.S[0x1], V25.S[0x2]
    RSHRN V24.2S, V21.2D, #23
    TBL  V16.8B, { V4.16B, V5.16B, V6.16B, V7.16B }, V0.8B
    UZP2  V6.2D, V3.2D, V26.2D
    RADDHN2  V12.8H, V6.4S, V17.4S
    REV64  V19.4H, V23.4H
    SHRN2 V8.8H, V14.4S, #4
    MOV V26.S[0x2], V8.S[0x0]
    SLI  V6.4S, V12.4S, #0x9
    SHRN2 V18.4S, V24.2D, #21
    SUB  V2.2S, V18.2S, V17.2S
    ADDV  H23, V16.8H
    MOV V18.D[0x1], V6.D[0x0]
    TBL  V6.16B, { V26.16B }, V19.16B
    ORR  V15.2S, #0x49, LSL #24
    MOV  V4.16B, V6.16B
    NEG  V3.4S, V2.4S
    MOV  V14.8B, V4.8B
    CNT  V2.8B, V23.8B
    TBX  V5.16B, { V13.16B, V14.16B, V15.16B, V16.16B }, V2.16B
    AESE  V0.16B, V5.16B
    XTN  V25.2S, V18.2D
    INS V2.D[0x0], X23
    BIC  V8.8B, V3.8B, V3.8B
    MOV V17.H[0x2], V2.H[0x0]
    SHL  V4.4S, V17.4S, #0x16
    PMULL2  V2.8H, V3.16B, V10.16B
    RSHRN V19.2S, V8.2D, #28
    SHRN V18.4H, V19.4S, #6
    MOV V16.H[0x1], W23
    SHLL2  V23.2D, V6.4S, #32
    TRN1  V5.16B, V16.16B, V10.16B
    EXT  V17.16B, V5.16B, V25.16B, #0xc
    EXT  V3.8B, V0.8B, V7.8B, #0x7
    DUP  V8.4H, V3.H[0x3]
    MOV V13.S[0x3], V4.S[0x2]
    SLI  V15.4H, V22.4H, #0xa
    ZIP1  V25.8B, V23.8B, V15.8B
    SHRN V16.4H, V2.4S, #9
    MLS  V14.2S, V17.2S, V3.2S
    MOV V3.B[0xf], W23
    MOV  V17.16B, V16.16B
    RSHRN V7.8B, V25.8H, #2
    UZP2  V26.4S, V14.4S, V7.4S
    DUP S4, V8.S[0x1]
    MOV H16, V17.H[0x5]
    PMUL  V16.8B, V16.8B, V16.8B
    RSHRN V14.2S, V3.2D, #11
    SLI  V7.8H, V4.8H, #0xf
    AESD  V17.16B, V13.16B
    INS V13.H[0x4], V17.H[0x5]
    EXT  V4.16B, V14.16B, V14.16B, #0x1
    DUP S6, V16.S[0x3]
    BIC  V5.8B, V6.8B, V6.8B
    ADDV  B14, V13.16B
    MVNI  V25.2S, #0x5f, MSL #8
    RSHRN2 V16.16B, V25.8H, #4
    ABS  V25.8B, V26.8B
    SRI V2.2D, V7.2D, #26
    MUL  V26.2S, V2.2S, V2.S[0x3]
    BIC  V3.16B, V16.16B, V16.16B
    CLZ  V17.8H, V3.8H
    SHLL2  V0.2D, V14.4S, #32
    SHRN2 V6.4S, V4.2D, #27
    SHL V13.2D, V5.2D, #0x28
    MUL  V14.8H, V25.8H, V6.H[0x1]
    MUL  V4.2S, V17.2S, V9.S[0x1]
    SHRN2 V5.16B, V4.8H, #2
    SUB  V25.2S, V26.2S, V26.2S
    RSHRN2 V7.4S, V13.2D, #24
    ADDP  D8, V7.2D
    DUP V7.8H, W2
    SLI  V17.16B, V0.16B, #0x1
    DUP V0.2D, X17
    BIC  V2.4H, #0xf9
    ZIP1  V15.2S, V14.2S, V2.2S
    ADDV  S9, V8.4S
    MOV V2.B[0x1], W8
    SHRN V6.4H, V1.4S, #8
    MOV V14.D[0x0], V25.D[0x0]
    MUL  V3.4H, V15.4H, V14.H[0x3]
    DUP H13, V17.H[0x0]
    SUBHN  V4.2S, V7.2D, V13.2D
    INS V17.S[0x2], W17
    SHLL  V8.4S, V0.4H, #16
    AESD  V26.16B, V2.16B
    SRI V7.2D, V5.2D, #59
    DUP V13.4S, W5
    SHL  V14.16B, V6.16B, #0x0
    RBIT  V0.16B, V14.16B
    MOV V2.D[0x0], X7
    MOV D14, V6.D[0x0]
    MLS  V15.2S, V26.2S, V2.2S
    ADDP  V6.2S, V13.2S, V13.2S
    MOV  W27, V17.S[0x0]
    MOV V17.D[0x0], X10
    SHL  V13.8H, V9.8H, #0x7
    MOV B2, V3.B[0xb]
    TBX  V1.16B, { V15.16B, V16.16B }, V4.16B
    ZIP2  V25.2D, V7.2D, V1.2D
    REV32  V15.8H, V6.8H
    ADDHN2  V1.16B, V17.8H, V25.8H
    AESIMC  V22.16B, V0.16B
    MOVI  V4.16B, #0x51
    INS V9.H[0x6], W26
    MUL  V26.8B, V14.8B, V22.8B
    BSL  V25.8B, V2.8B, V4.8B
    ADDHN  V5.8B, V9.8H, V13.8H
    EXT  V4.16B, V8.16B, V15.16B, #0x0
    REV64  V7.8B, V4.8B
    PMUL  V6.16B, V1.16B, V6.16B
    SUBHN2  V16.8H, V25.4S, V7.4S
    SHRN2 V14.4S, V16.2D, #18
    RSUBHN2  V17.4S, V6.2D, V5.2D
    CNT  V8.8B, V26.8B
    ADDV  S26, V29.4S
    CNT  V16.8B, V29.8B
    ORN  V29.8B, V14.8B, V15.8B
    INS V15.B[0x8], W19
    DUP V7.2D, X5
    MOV V14.S[0x3], W13
    DUP V2.2D, X25
    MOVI  V22.2S, #0x74, MSL #8
    DUP V13.2D, V7.D[0x0]
    MOV V7.S[0x1], W24
    MLS  V25.4H, V13.4H, V14.H[0x7]
    SHRN V9.4H, V7.4S, #12
    ADDV  B5, V8.8B
    SLI  V14.4S, V22.4S, #0x8
    REV32  V13.8H, V26.8H
    ORR  V0.8H, #0x1d
    DUP V22.2D, X25
    SHLL2  V6.8H, V17.16B, #8
    CLS  V4.4S, V2.4S
    MLA  V2.8H, V15.8H, V3.H[0x0]
    SHL  V15.4H, V6.4H, #0x5
    MOV V7.B[0x8], V15.B[0xb]
    AND  V17.8B, V14.8B, V4.8B
    MOV V26.D[0x0], X17
    MVN  V8.16B, V26.16B
    SUBS  X7, X7, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_1
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    MRS  X16, FPSR
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x1d, LSL #0
    MOVK  X6, #0x1d, LSL #16
    MOVK  X6, #0x1d, LSL #32
    MOVK  X6, #0x1d, LSL #48
    FMOV  X16, V0.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x3a3f, LSL #0
    MOVK  X6, #0x3a3f, LSL #16
    MOVK  X6, #0x1d, LSL #32
    MOVK  X6, #0x3a3f, LSL #48
    FMOV  X16, D0
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0xaeae, LSL #32
    MOVK  X6, #0xaeae, LSL #48
    FMOV  X16, V1.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0xaeae, LSL #0
    MOVK  X6, #0xaeae, LSL #16
    MOVK  X6, #0xaeae, LSL #32
    MOVK  X6, #0xaeae, LSL #48
    FMOV  X16, D1
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V2.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D2
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V3.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D3
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x1f, LSL #0
    MOVK  X6, #0x1f, LSL #32
    FMOV  X16, V4.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x1f, LSL #0
    MOVK  X6, #0x1f, LSL #32
    FMOV  X16, D4
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V5.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x17, LSL #0
    FMOV  X16, D5
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V6.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D6
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V7.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D7
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    FMOV  X16, V8.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    FMOV  X16, D8
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V9.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D9
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V10.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D10
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V11.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D11
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0xffe9, LSL #0
    MOVK  X6, #0xffe9, LSL #16
    MOVK  X6, #0xffe9, LSL #32
    MOVK  X6, #0xffe9, LSL #48
    FMOV  X16, V12.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x5959, LSL #0
    MOVK  X6, #0x16bb, LSL #16
    MOVK  X6, #0x6359, LSL #32
    MOVK  X6, #0x1616, LSL #48
    FMOV  X16, D12
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V13.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x74, LSL #0
    MOVK  X6, #0xff0a, LSL #16
    FMOV  X16, D13
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V14.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0xff5c, LSL #0
    MOVK  X6, #0x74, LSL #16
    MOVK  X6, #0xff00, LSL #32
    MOVK  X6, #0x74, LSL #48
    FMOV  X16, D14
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V15.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D15
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V16.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x802, LSL #0
    MOVK  X6, #0x4, LSL #16
    FMOV  X16, D16
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V17.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x1c, LSL #0
    FMOV  X16, D17
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V18.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D18
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V19.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D19
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V20.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D20
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V21.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x1000, LSL #0
    FMOV  X16, D21
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V22.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D22
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V23.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D23
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V24.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D24
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V25.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x5151, LSL #0
    MOVK  X6, #0x5151, LSL #16
    MOVK  X6, #0x5151, LSL #32
    MOVK  X6, #0x5151, LSL #48
    FMOV  X16, D25
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V26.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D26
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V27.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D27
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x5151, LSL #16
    FMOV  X16, V28.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D28
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V29.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    FMOV  X16, D29
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V30.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xb700, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xb700, LSL #48
    FMOV  X16, D30
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0xae00, LSL #32
    FMOV  X16, V31.D[1]
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D31
    SUB  X4, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
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
    FMOV  D0, X27
    FMOV  V0.D[1], X24
    FMOV  D1, X28
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X15
    FMOV  D3, X16
    FMOV  V3.D[1], X15
    FMOV  D4, X28
    FMOV  V4.D[1], X28
    FMOV  D5, X27
    FMOV  V5.D[1], X17
    FMOV  D6, X5
    FMOV  V6.D[1], X27
    FMOV  D7, X17
    FMOV  V7.D[1], X7
    FMOV  D8, X19
    FMOV  V8.D[1], X28
    FMOV  D9, X4
    FMOV  V9.D[1], X10
    FMOV  D10, X6
    FMOV  V10.D[1], X21
    FMOV  D11, X8
    FMOV  V11.D[1], X8
    FMOV  D12, X7
    FMOV  V12.D[1], X11
    FMOV  D13, X16
    FMOV  V13.D[1], X23
    FMOV  D14, X18
    FMOV  V14.D[1], X14
    FMOV  D15, X25
    FMOV  V15.D[1], X26
    FMOV  D16, X13
    FMOV  V16.D[1], X16
    FMOV  D17, X14
    FMOV  V17.D[1], X7
    FMOV  D18, X2
    FMOV  V18.D[1], X19
    FMOV  D19, X10
    FMOV  V19.D[1], X15
    FMOV  D20, X19
    FMOV  V20.D[1], X28
    FMOV  D21, X16
    FMOV  V21.D[1], X11
    FMOV  D22, X6
    FMOV  V22.D[1], X21
    FMOV  D23, X23
    FMOV  V23.D[1], X16
    FMOV  D24, X16
    FMOV  V24.D[1], X15
    FMOV  D25, X5
    FMOV  V25.D[1], X21
    FMOV  D26, X4
    FMOV  V26.D[1], X20
    FMOV  D27, X4
    FMOV  V27.D[1], X14
    FMOV  D28, X21
    FMOV  V28.D[1], X4
    FMOV  D29, X23
    FMOV  V29.D[1], X18
    FMOV  D30, X8
    FMOV  V30.D[1], X26
    FMOV  D31, X26
    FMOV  V31.D[1], X7
    MOVZ  X11, #0xf, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_2:
    MOV V22.S[0x2], W25
    SLI  V15.8B, V21.8B, #0x3
    PMULL2  V29.1Q, V30.2D, V31.2D
    REV32  V28.4H, V28.4H
    SUBHN2  V7.4S, V26.2D, V29.2D
    PMULL2  V20.1Q, V22.2D, V25.2D
    MLA  V2.8H, V15.8H, V27.8H
    AESD  V31.16B, V28.16B
    DUP  V4.16B, V31.B[0xc]
    ADDP  D30, V2.2D
    AESD  V24.16B, V4.16B
    MLS  V11.8H, V30.8H, V30.8H
    ORR  V12.2S, #0x15
    INS V2.S[0x0], V11.S[0x3]
    PMULL  V22.1Q, V24.1D, V20.1D
    ADDV  S22, V12.4S
    INS V27.D[0x1], X6
    MUL  V21.4S, V2.4S, V7.S[0x0]
    AESD  V12.16B, V27.16B
    AESMC  V30.16B, V21.16B
    TBL  V19.8B, { V22.16B }, V30.8B
    MOVI  V2.8H, #0xd1
    DUP V24.2S, W21
    MOV V11.D[0x0], X14
    MLA  V4.8H, V2.8H, V13.H[0x3]
    SHRN V15.2S, V4.2D, #14
    ZIP1  V13.4S, V24.4S, V19.4S
    MOV  W14, V13.S[0x3]
    SHL V21.2D, V15.2D, #0x1f
    INS V19.H[0x3], V11.H[0x6]
    BSL  V22.16B, V12.16B, V12.16B
    ADDHN  V2.8B, V21.8H, V22.8H
    BIF  V22.16B, V2.16B, V26.16B
    ADDHN  V26.2S, V19.2D, V19.2D
    SHRN2 V13.16B, V26.8H, #5
    RSHRN2 V30.16B, V13.8H, #3
    MOV V27.B[0x5], W15
    MOV  X6, V22.D[0x1]
    INS V2.D[0x1], V27.D[0x1]
    BSL  V27.16B, V2.16B, V30.16B
    CNT  V19.16B, V4.16B
    AESMC  V4.16B, V8.16B
    DUP V8.16B, W5
    MOV V22.B[0x5], V0.B[0x0]
    TBL  V26.8B, { V0.16B, V1.16B }, V0.8B
    ORN  V24.8B, V12.8B, V26.8B
    INS V12.H[0x3], W20
    MOV V21.B[0xf], W17
    MUL  V0.8H, V9.8H, V10.H[0x7]
    ORR  V2.4H, #0x8e
    MOVI  V1.4S, #0x54, LSL #16
    MOV V13.D[0x0], X11
    MOV V30.B[0x3], W19
    RSHRN V26.8B, V12.8H, #4
    SUBHN2  V12.4S, V19.2D, V19.2D
    SRI  V10.4H, V13.4H, #16
    ADDHN  V9.8B, V26.8H, V30.8H
    RSHRN2 V26.8H, V12.4S, #15
    INS V19.B[0x5], V8.B[0xe]
    SHRN2 V12.8H, V0.4S, #11
    INS V30.B[0xa], V12.B[0xe]
    CLZ  V12.2S, V19.2S
    MLA  V28.2S, V27.2S, V30.S[0x3]
    BIT  V13.16B, V21.16B, V21.16B
    MOV V21.H[0x1], W16
    RSHRN V30.2S, V2.2D, #13
    MOVI  V2.2S, #0x6d, LSL #16
    MLS  V0.8H, V26.8H, V4.H[0x2]
    MOV  V26.16B, V2.16B
    SRI  V2.8H, V24.8H, #3
    SHL  V8.16B, V12.16B, #0x0
    BSL  V24.16B, V9.16B, V9.16B
    ORN  V12.16B, V30.16B, V8.16B
    DUP V9.8H, W13
    SRI V30.2D, V28.2D, #13
    MOV  W5, V30.S[0x3]
    NEG  V8.2S, V13.2S
    ADDP  D4, V21.2D
    SLI  V13.4S, V4.4S, #0xf
    DUP H30, V13.H[0x1]
    DUP  V28.8H, V24.H[0x3]
    MOV V21.S[0x2], V10.S[0x2]
    BSL  V27.16B, V28.16B, V0.16B
    MLS  V0.4S, V8.4S, V2.S[0x1]
    ADDV  H2, V30.4H
    MOV V10.B[0x6], V9.B[0x7]
    SHRN V19.8B, V18.8H, #2
    SHL V13.2D, V2.2D, #0xe
    SHRN V30.4H, V26.4S, #3
    MOVI  V9.4S, #0x3e, LSL #24
    DUP V26.4H, W9
    AESMC  V4.16B, V9.16B
    DUP  V9.16B, V13.B[0x0]
    SLI  V8.2S, V9.2S, #0x15
    MLS  V13.4S, V30.4S, V8.S[0x2]
    MOV V15.S[0x3], V12.S[0x0]
    TBX  V30.8B, { V19.16B }, V15.8B
    MVNI  V9.2S, #0xfb, LSL #8
    TBL  V12.8B, { V28.16B, V29.16B, V30.16B }, V9.8B
    BSL  V29.16B, V4.16B, V13.16B
    SLI  V4.8H, V26.8H, #0x4
    TRN2  V13.4S, V12.4S, V29.4S
    SHL  V18.8B, V21.8B, #0x2
    BIC  V9.16B, V0.16B, V10.16B
    MUL  V19.8H, V9.8H, V4.H[0x4]
    MVN  V2.8B, V18.8B
    RSHRN V8.4H, V2.4S, #14
    MVNI  V26.4H, #0x3, LSL #8
    TBL  V15.8B, { V8.16B, V9.16B, V10.16B, V11.16B }, V26.8B
    MOV  X16, V13.D[0x1]
    SUB  V28.2S, V15.2S, V19.2S
    MOVI  V19.2D, #280379759984895
    MLA  V21.2S, V28.2S, V28.S[0x2]
    INS V15.B[0x6], W23
    SHL  V8.8B, V19.8B, #0x2
    DUP D12, V21.D[0x1]
    INS V29.S[0x2], V15.S[0x3]
    CNT  V15.16B, V8.16B
    BIC  V13.8B, V12.8B, V25.8B
    SLI  V8.8H, V29.8H, #0xe
    DUP  V29.16B, V20.B[0x0]
    SHLL2  V12.8H, V29.16B, #8
    SHRN V29.4H, V12.4S, #2
    MVNI  V18.4S, #0x1f, MSL #8
    MOV D28, V15.D[0x1]
    SRI V15.2D, V8.2D, #33
    MVNI  V0.4S, #0xb4, LSL #16
    DUP V4.8B, W21
    MOV S19, V4.S[0x1]
    DUP H25, V29.H[0x6]
    MUL  V8.4H, V13.4H, V14.H[0x3]
    MOV  V14.16B, V18.16B
    INS V13.B[0xa], W16
    MOV  V20.16B, V13.16B
    MOVI  V18.2S, #0x98, MSL #8
    DUP  V12.4S, V8.S[0x0]
    SHL  V4.8B, V23.8B, #0x7
    EXT  V13.8B, V28.8B, V28.8B, #0x0
    ADDV  B23, V27.16B
    CNT  V27.8B, V20.8B
    AND  V28.16B, V12.16B, V0.16B
    BSL  V8.8B, V19.8B, V4.8B
    SHRN V12.2S, V14.2D, #27
    ADDP  D4, V25.2D
    MOV B25, V13.B[0x4]
    SHL  V21.8H, V18.8H, #0x2
    MOV V14.S[0x0], V21.S[0x0]
    MOV S21, V23.S[0x3]
    NOT  V29.16B, V25.16B
    ADDP  D23, V27.2D
    MOV B20, V4.B[0x7]
    SRI  V19.16B, V28.16B, #7
    DUP V13.2D, V20.D[0x0]
    AESIMC  V18.16B, V21.16B
    MOV V21.B[0x8], W14
    NOT  V3.8B, V23.8B
    MVN  V27.16B, V29.16B
    RSHRN V0.8B, V19.8H, #7
    XTN  V28.4H, V21.4S
    PMULL2  V21.1Q, V28.2D, V0.2D
    INS V0.D[0x1], X13
    MLS  V31.8H, V14.8H, V0.H[0x1]
    CNT  V4.8B, V12.8B
    MVNI  V20.4H, #0x87
    MOV D29, V13.D[0x1]
    TBX  V13.16B, { V3.16B, V4.16B }, V4.16B
    MVNI  V19.8H, #0xf5
    AESMC  V23.16B, V19.16B
    ADD  V28.8B, V31.8B, V20.8B
    MOVI  V3.4H, #0xd5, LSL #8
    NEG  V0.2D, V13.2D
    RBIT  V14.8B, V18.8B
    INS V13.H[0x6], W27
    ADDHN2  V19.4S, V27.2D, V21.2D
    MOV B4, V23.B[0x1]
    SHRN2 V27.4S, V0.2D, #8
    AESE  V0.16B, V16.16B
    INS V12.B[0xb], V29.B[0xb]
    SLI V29.2D, V27.2D, #0x3
    DUP V27.4S, W11
    RADDHN  V18.8B, V27.8H, V12.8H
    MUL  V23.2S, V18.2S, V4.S[0x2]
    MLS  V20.4H, V29.4H, V14.H[0x2]
    SLI  V16.8B, V0.8B, #0x7
    BIC  V14.16B, V23.16B, V19.16B
    ADDV  H12, V16.4H
    RSHRN V21.4H, V31.4S, #13
    MVNI  V27.2S, #0x41, LSL #8
    BIC  V19.16B, V14.16B, V13.16B
    MLS  V13.4S, V12.4S, V21.S[0x1]
    RSHRN2 V18.8H, V27.4S, #8
    SUBHN  V14.4H, V18.4S, V19.4S
    MUL  V18.8B, V3.8B, V20.8B
    TRN1  V4.2S, V28.2S, V18.2S
    EXT  V29.16B, V4.16B, V4.16B, #0x4
    RSHRN2 V12.8H, V14.4S, #6
    SHLL2  V14.8H, V12.16B, #8
    TBX  V28.8B, { V29.16B }, V13.8B
    MUL  V16.4H, V14.4H, V28.4H
    TBX  V14.8B, { V1.16B, V2.16B, V3.16B }, V12.8B
    SUBS  X11, X11, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_2
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X28, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X28, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X28, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X28, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X28, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X28, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X28, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X28, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X28, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X28, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X28, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X28, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X28, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X28, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X28, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X28, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    MRS  X28, FPSR
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x637c, LSL #0
    MOVK  X2, #0x7863, LSL #16
    MOVK  X2, #0x6363, LSL #32
    MOVK  X2, #0x6363, LSL #48
    FMOV  X28, V0.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xe17c, LSL #0
    MOVK  X2, #0x6363, LSL #16
    MOVK  X2, #0x6363, LSL #32
    MOVK  X2, #0x1663, LSL #48
    FMOV  X28, D0
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x54, LSL #16
    MOVK  X2, #0x54, LSL #48
    FMOV  X28, V1.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x54, LSL #16
    MOVK  X2, #0x54, LSL #48
    FMOV  X28, D1
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, V2.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xa3af, LSL #32
    MOVK  X2, #0xa3af, LSL #48
    FMOV  X28, D2
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, V3.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xd500, LSL #0
    MOVK  X2, #0xd500, LSL #16
    MOVK  X2, #0xd500, LSL #32
    MOVK  X2, #0xd500, LSL #48
    FMOV  X28, D3
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, V4.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x1420, LSL #0
    MOVK  X2, #0x2d69, LSL #16
    MOVK  X2, #0x2b00, LSL #32
    MOVK  X2, #0x2b00, LSL #48
    FMOV  X28, D4
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X28, V5.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X28, D5
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X28, V6.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X28, D6
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xfcff, LSL #0
    MOVK  X2, #0xfcff, LSL #16
    FMOV  X28, V7.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X28, D7
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, V8.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, D8
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, V9.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, D9
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, V10.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X28, D10
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X28, V11.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, D11
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x3ff, LSL #16
    FMOV  X28, V12.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x1f80, LSL #0
    FMOV  X28, D12
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X28, V13.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x7dff, LSL #0
    MOVK  X2, #0xc75a, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xff, LSL #48
    FMOV  X28, D13
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, V14.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, D14
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, V15.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x1e00, LSL #0
    MOVK  X2, #0x600, LSL #32
    FMOV  X28, D15
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, V16.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0xe000, LSL #32
    MOVK  X2, #0x3b00, LSL #48
    FMOV  X28, D16
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X28, V17.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X28, D17
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, V18.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x2b00, LSL #0
    MOVK  X2, #0x2b00, LSL #16
    MOVK  X2, #0x2b00, LSL #32
    MOVK  X2, #0x2b00, LSL #48
    FMOV  X28, D18
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, V19.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, D19
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, V20.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xff78, LSL #0
    MOVK  X2, #0xff78, LSL #16
    MOVK  X2, #0xff78, LSL #32
    MOVK  X2, #0xff78, LSL #48
    FMOV  X28, D20
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, V21.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x7789, LSL #0
    MOVK  X2, #0x378b, LSL #16
    MOVK  X2, #0xb3fc, LSL #32
    MOVK  X2, #0x4bf9, LSL #48
    FMOV  X28, D21
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, V22.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x5158, LSL #0
    MOVK  X2, #0x7d52, LSL #16
    MOVK  X2, #0x7cbb, LSL #32
    MOVK  X2, #0x5152, LSL #48
    FMOV  X28, D22
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, V23.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, D23
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, V24.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xffd6, LSL #0
    MOVK  X2, #0x6e9e, LSL #16
    MOVK  X2, #0x1b00, LSL #32
    FMOV  X28, D24
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, V25.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, D25
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, V26.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xfcff, LSL #0
    MOVK  X2, #0xfcff, LSL #16
    MOVK  X2, #0xfcff, LSL #32
    MOVK  X2, #0xfcff, LSL #48
    FMOV  X28, D26
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, V27.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xbeff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xbeff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X28, D27
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, V28.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x1420, LSL #0
    MOVK  X2, #0x2d69, LSL #16
    MOVK  X2, #0x6820, LSL #32
    MOVK  X2, #0x69, LSL #48
    FMOV  X28, D28
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x1420, LSL #32
    MOVK  X2, #0x2d69, LSL #48
    FMOV  X28, V29.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x2b00, LSL #0
    MOVK  X2, #0x2b00, LSL #16
    FMOV  X28, D29
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X28, V30.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xa000, LSL #0
    MOVK  X2, #0xa000, LSL #16
    FMOV  X28, D30
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x765b, LSL #0
    MOVK  X2, #0x767f, LSL #16
    MOVK  X2, #0x265b, LSL #32
    MOVK  X2, #0x697f, LSL #48
    FMOV  X28, V31.D[1]
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x15a8, LSL #0
    MOVK  X2, #0x2ef1, LSL #16
    MOVK  X2, #0x69a8, LSL #32
    MOVK  X2, #0x26f1, LSL #48
    FMOV  X28, D31
    SUB  X26, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x4fbe, LSL #0
    MOVK  X2, #0x1065, LSL #16
    MOVK  X2, #0x42d4, LSL #32
    MOVK  X2, #0xbe70, LSL #48
    MOVZ  X4, #0x9620, LSL #0
    MOVK  X4, #0x5bc3, LSL #16
    MOVK  X4, #0xcddf, LSL #32
    MOVK  X4, #0xde10, LSL #48
    MOVZ  X5, #0x1044, LSL #0
    MOVK  X5, #0x4fda, LSL #16
    MOVK  X5, #0xf6cc, LSL #32
    MOVK  X5, #0xd7b6, LSL #48
    MOVZ  X6, #0x7877, LSL #0
    MOVK  X6, #0x2af4, LSL #16
    MOVK  X6, #0xe1c7, LSL #32
    MOVK  X6, #0x297f, LSL #48
    MOVZ  X7, #0xae0f, LSL #0
    MOVK  X7, #0x1a46, LSL #16
    MOVK  X7, #0x958b, LSL #32
    MOVK  X7, #0x8d03, LSL #48
    MOVZ  X8, #0xc092, LSL #0
    MOVK  X8, #0x8a41, LSL #16
    MOVK  X8, #0x8f6a, LSL #32
    MOVK  X8, #0x14c5, LSL #48
    MOVZ  X9, #0x4f05, LSL #0
    MOVK  X9, #0x7f51, LSL #16
    MOVK  X9, #0x75c1, LSL #32
    MOVK  X9, #0xa120, LSL #48
    MOVZ  X10, #0xf40b, LSL #0
    MOVK  X10, #0x38ee, LSL #16
    MOVK  X10, #0xfe21, LSL #32
    MOVK  X10, #0x4ea7, LSL #48
    MOVZ  X11, #0x7f0a, LSL #0
    MOVK  X11, #0xa89b, LSL #16
    MOVK  X11, #0x6b1e, LSL #32
    MOVK  X11, #0x9c59, LSL #48
    MOVZ  X13, #0x21e3, LSL #0
    MOVK  X13, #0x16b1, LSL #16
    MOVK  X13, #0x12b2, LSL #32
    MOVK  X13, #0x7dae, LSL #48
    MOVZ  X14, #0xe7db, LSL #0
    MOVK  X14, #0x6122, LSL #16
    MOVK  X14, #0x2f5a, LSL #32
    MOVK  X14, #0x7d11, LSL #48
    MOVZ  X15, #0x7f87, LSL #0
    MOVK  X15, #0xa1d2, LSL #16
    MOVK  X15, #0xd028, LSL #32
    MOVK  X15, #0xdc4f, LSL #48
    MOVZ  X16, #0x37e8, LSL #0
    MOVK  X16, #0x14ba, LSL #16
    MOVK  X16, #0xa896, LSL #32
    MOVK  X16, #0xe482, LSL #48
    MOVZ  X17, #0xad00, LSL #0
    MOVK  X17, #0x2b29, LSL #16
    MOVK  X17, #0xe0b6, LSL #32
    MOVK  X17, #0xe327, LSL #48
    MOVZ  X18, #0xf44, LSL #0
    MOVK  X18, #0x1ab8, LSL #16
    MOVK  X18, #0xc033, LSL #32
    MOVK  X18, #0xd3c, LSL #48
    MOVZ  X19, #0x3cfa, LSL #0
    MOVK  X19, #0x5717, LSL #16
    MOVK  X19, #0xf292, LSL #32
    MOVK  X19, #0xa331, LSL #48
    MOVZ  X20, #0x7ee1, LSL #0
    MOVK  X20, #0xb867, LSL #16
    MOVK  X20, #0xbf32, LSL #32
    MOVK  X20, #0xd162, LSL #48
    MOVZ  X21, #0x63c9, LSL #0
    MOVK  X21, #0xd774, LSL #16
    MOVK  X21, #0x6dce, LSL #32
    MOVK  X21, #0xd4dd, LSL #48
    MOVZ  X23, #0x33e5, LSL #0
    MOVK  X23, #0x77b7, LSL #16
    MOVK  X23, #0x4946, LSL #32
    MOVK  X23, #0xca9, LSL #48
    MOVZ  X24, #0x80f4, LSL #0
    MOVK  X24, #0x9fdb, LSL #16
    MOVK  X24, #0xc30, LSL #32
    MOVK  X24, #0x614b, LSL #48
    MOVZ  X25, #0xa1fa, LSL #0
    MOVK  X25, #0x8efe, LSL #16
    MOVK  X25, #0x15bf, LSL #32
    MOVK  X25, #0x19c9, LSL #48
    MOVZ  X26, #0xc19, LSL #0
    MOVK  X26, #0x6a27, LSL #16
    MOVK  X26, #0x6142, LSL #32
    MOVK  X26, #0x2261, LSL #48
    MOVZ  X27, #0x1b10, LSL #0
    MOVK  X27, #0x3b0b, LSL #16
    MOVK  X27, #0xb421, LSL #32
    MOVK  X27, #0x9614, LSL #48
    MOVZ  X28, #0x3692, LSL #0
    MOVK  X28, #0x46, LSL #16
    MOVK  X28, #0xfeb6, LSL #32
    MOVK  X28, #0xf080, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X28
    FMOV  D1, X24
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X7
    FMOV  D3, X17
    FMOV  V3.D[1], X26
    FMOV  D4, X15
    FMOV  V4.D[1], X5
    FMOV  D5, X5
    FMOV  V5.D[1], X27
    FMOV  D6, X20
    FMOV  V6.D[1], X21
    FMOV  D7, X18
    FMOV  V7.D[1], X5
    FMOV  D8, X11
    FMOV  V8.D[1], X16
    FMOV  D9, X13
    FMOV  V9.D[1], X11
    FMOV  D10, X7
    FMOV  V10.D[1], X26
    FMOV  D11, X18
    FMOV  V11.D[1], X20
    FMOV  D12, X9
    FMOV  V12.D[1], X27
    FMOV  D13, X26
    FMOV  V13.D[1], X9
    FMOV  D14, X7
    FMOV  V14.D[1], X14
    FMOV  D15, X17
    FMOV  V15.D[1], X24
    FMOV  D16, X15
    FMOV  V16.D[1], X7
    FMOV  D17, X15
    FMOV  V17.D[1], X21
    FMOV  D18, X6
    FMOV  V18.D[1], X10
    FMOV  D19, X6
    FMOV  V19.D[1], X28
    FMOV  D20, X28
    FMOV  V20.D[1], X8
    FMOV  D21, X2
    FMOV  V21.D[1], X9
    FMOV  D22, X16
    FMOV  V22.D[1], X26
    FMOV  D23, X5
    FMOV  V23.D[1], X10
    FMOV  D24, X2
    FMOV  V24.D[1], X10
    FMOV  D25, X17
    FMOV  V25.D[1], X2
    FMOV  D26, X7
    FMOV  V26.D[1], X21
    FMOV  D27, X4
    FMOV  V27.D[1], X10
    FMOV  D28, X20
    FMOV  V28.D[1], X26
    FMOV  D29, X20
    FMOV  V29.D[1], X20
    FMOV  D30, X19
    FMOV  V30.D[1], X21
    FMOV  D31, X13
    FMOV  V31.D[1], X18
    MOVZ  X26, #0xf, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_3:
    AESMC  V27.16B, V30.16B
    MOV V27.B[0x8], W16
    SHRN V19.2S, V21.2D, #20
    SLI  V2.16B, V19.16B, #0x5
    SHRN2 V17.4S, V27.2D, #4
    CLZ  V31.16B, V17.16B
    EXT  V26.8B, V2.8B, V28.8B, #0x2
    DUP  V3.16B, V26.B[0xc]
    MVNI  V11.2S, #0x18
    AESD  V7.16B, V11.16B
    SLI V27.2D, V31.2D, #0x26
    ORR  V29.4S, #0x57
    MOVI  V0.4H, #0x1c
    DUP V17.8B, W7
    MOVI  V12.2D, #281474959998975
    INS V25.H[0x1], V29.H[0x7]
    DUP V3.2D, V7.D[0x0]
    BIC  V20.16B, V0.16B, V3.16B
    PMUL  V22.16B, V27.16B, V27.16B
    MOV V15.S[0x1], W2
    INS V10.D[0x1], V17.D[0x0]
    DUP H16, V12.H[0x4]
    ADDHN2  V12.16B, V10.8H, V25.8H
    MLS  V17.4H, V16.4H, V8.H[0x1]
    MOV  X2, V15.D[0x0]
    BSL  V16.16B, V20.16B, V22.16B
    MOV V20.H[0x2], V17.H[0x7]
    PMUL  V31.16B, V20.16B, V20.16B
    XTN2  V15.8H, V31.4S
    TRN2  V28.8H, V15.8H, V15.8H
    DUP V17.2D, V16.D[0x0]
    MOV B8, V28.B[0xa]
    SHL  V22.16B, V8.16B, #0x2
    DUP S29, V17.S[0x1]
    TBL  V10.16B, { V30.16B, V31.16B, V0.16B, V1.16B }, V12.16B
    MUL  V25.8H, V10.8H, V3.H[0x7]
    TBX  V27.16B, { V8.16B, V9.16B, V10.16B }, V22.16B
    MOV V12.H[0x4], W20
    RSHRN V20.8B, V29.8H, #7
    MOVI  V11.2D, #71776123356119040
    SHRN V17.8B, V1.8H, #7
    CNT  V15.8B, V17.8B
    MLA  V10.2S, V15.2S, V25.S[0x0]
    MOV S8, V27.S[0x0]
    TRN2  V29.8B, V10.8B, V8.8B
    ORR  V31.8B, V29.8B, V12.8B
    MOVI  V0.2S, #0xb7, MSL #16
    SRI  V15.8H, V25.8H, #13
    BIC  V3.4S, #0x1f, LSL #8
    BIC  V22.4H, #0x41
    MOVI  V28.16B, #0x3d
    DUP B27, V31.B[0x2]
    SUBHN2  V9.8H, V0.4S, V28.4S
    SHRN V30.8B, V27.8H, #3
    MLA  V27.4H, V11.4H, V12.H[0x6]
    MVNI  V11.8H, #0xd6
    INS V29.D[0x1], V15.D[0x0]
    SHRN2 V10.4S, V29.2D, #28
    ORR  V31.8H, #0x4c, LSL #8
    ABS  V0.4S, V31.4S
    BIT  V16.8B, V20.8B, V0.8B
    DUP  V28.16B, V22.B[0xb]
    MLA  V15.4S, V3.4S, V28.S[0x1]
    TBL  V25.16B, { V0.16B, V1.16B, V2.16B, V3.16B }, V15.16B
    INS V17.D[0x0], V11.D[0x1]
    MOV V28.B[0x9], W14
    INS V22.B[0x1], V27.B[0x6]
    MOV V29.S[0x2], W7
    BIC  V12.8B, V16.8B, V22.8B
    ADDV  H3, V10.4H
    BIC  V31.8H, #0x80
    ORN  V20.8B, V12.8B, V17.8B
    UZP2  V27.8B, V29.8B, V7.8B
    SUBHN2  V11.8H, V25.4S, V30.4S
    ADDHN  V10.4H, V31.4S, V28.4S
    ORR  V30.16B, V11.16B, V20.16B
    MOV H0, V9.H[0x2]
    SLI V15.2D, V19.2D, #0x8
    INS V16.H[0x7], V3.H[0x5]
    DUP V28.2D, X26
    MOVI  V17.8B, #0x17
    SHL  V7.16B, V16.16B, #0x2
    SRI  V25.8B, V0.8B, #8
    SRI  V3.2S, V17.2S, #2
    DUP S16, V15.S[0x2]
    MVNI  V20.4S, #0xb3
    SRI V12.2D, V27.2D, #12
    MLS  V9.2S, V10.2S, V25.S[0x3]
    MUL  V31.2S, V30.2S, V3.2S
    MOV V25.S[0x0], V3.S[0x1]
    BSL  V19.16B, V28.16B, V9.16B
    SUBHN  V9.4H, V19.4S, V7.4S
    DUP  V10.8H, V9.H[0x2]
    ADDV  B27, V12.8B
    CLS  V11.16B, V16.16B
    MOV V0.B[0xf], W19
    SUB  V17.8B, V31.8B, V0.8B
    TBX  V30.16B, { V15.16B, V16.16B, V17.16B, V18.16B }, V12.16B
    RSUBHN2  V16.4S, V11.2D, V27.2D
    MOV V11.H[0x3], W24
    MOVI  V28.8H, #0xa7, LSL #8
    UZP1  V9.8H, V25.8H, V20.8H
    MOV D31, V16.D[0x1]
    MOV D19, V30.D[0x0]
    RSHRN V0.4H, V4.4S, #9
    MOVI  V16.2D, #18446463698227691775
    DUP V20.4H, W14
    TBX  V25.8B, { V0.16B }, V20.8B
    ABS  V15.2S, V19.2S
    SRI  V7.4H, V25.4H, #10
    TBX  V27.8B, { V28.16B }, V16.8B
    SLI  V16.4S, V10.4S, #0x3
    TRN1  V4.16B, V9.16B, V7.16B
    ORR  V30.8B, V31.8B, V16.8B
    RSUBHN  V31.2S, V30.2D, V11.2D
    BIC  V12.8B, V27.8B, V31.8B
    DUP D17, V12.D[0x0]
    INS V11.S[0x2], W4
    XTN  V27.8B, V4.8H
    ADDHN2  V28.16B, V27.8H, V11.8H
    ADDV  H19, V15.4H
    MVNI  V10.4S, #0xeb
    RSUBHN  V7.8B, V0.8H, V10.8H
    MLA  V27.4H, V28.4H, V5.H[0x5]
    SHRN V4.2S, V17.2D, #21
    DUP V10.16B, W28
    MOV  X27, V19.D[0x0]
    MOV V25.D[0x0], X9
    TBL  V19.8B, { V4.16B }, V17.8B
    MOVI  V30.2D, #18374686479688335615
    EOR  V4.8B, V7.8B, V7.8B
    SHL  V7.8B, V25.8B, #0x3
    DUP B25, V30.B[0xb]
    DUP S15, V26.S[0x0]
    MOV V0.S[0x2], W19
    BIC  V20.4H, #0x43
    MOVI  V12.2D, #71776123356184575
    MLA  V16.4H, V10.4H, V15.H[0x3]
    MLS  V17.8H, V16.8H, V7.8H
    XTN  V30.4H, V0.4S
    SLI  V16.16B, V25.16B, #0x3
    DUP S15, V30.S[0x0]
    TBL  V7.8B, { V15.16B, V16.16B }, V19.8B
    MOVI  V26.8B, #0x9c
    MOVI  V10.4S, #0xc1, LSL #8
    PMULL  V0.8H, V26.8B, V10.8B
    SHRN V26.8B, V20.8H, #3
    MOV S25, V7.S[0x1]
    XTN  V19.8B, V26.8H
    RSHRN2 V26.16B, V0.8H, #5
    MOV B5, V27.B[0xa]
    ADDP  D30, V17.2D
    MVN  V28.8B, V4.8B
    TBL  V16.16B, { V12.16B }, V25.16B
    EXT  V7.16B, V16.16B, V19.16B, #0xd
    SHL  V20.4S, V7.4S, #0x4
    MUL  V10.8H, V20.8H, V2.H[0x2]
    MVNI  V16.2S, #0x4a, MSL #8
    RSHRN2 V15.4S, V16.2D, #3
    TRN2  V0.8H, V10.8H, V5.8H
    DUP V10.2D, V26.D[0x1]
    SUB  V27.2S, V0.2S, V15.2S
    SHRN2 V17.8H, V27.4S, #9
    SUBHN2  V4.4S, V30.2D, V30.2D
    DUP D27, V4.D[0x0]
    EXT  V5.16B, V28.16B, V10.16B, #0x9
    TBX  V26.8B, { V27.16B }, V5.8B
    DUP V25.4H, W20
    DUP V15.4H, W24
    MOV V7.H[0x4], W16
    MOV V2.H[0x4], W8
    SUBHN  V21.8B, V7.8H, V7.8H
    RSHRN2 V19.8H, V25.4S, #16
    TBX  V16.8B, { V24.16B, V25.16B }, V17.8B
    MOV V28.H[0x5], V4.H[0x4]
    AESMC  V5.16B, V28.16B
    SRI V4.2D, V15.2D, #52
    XTN  V27.2S, V2.2D
    TBX  V0.8B, { V20.16B, V21.16B, V22.16B, V23.16B }, V4.8B
    DUP V24.2S, W18
    MOV  W18, V16.S[0x2]
    MOV V7.B[0x0], V26.B[0x3]
    DUP  V22.16B, V5.B[0x0]
    RSUBHN2  V28.16B, V7.8H, V27.8H
    RADDHN2  V26.16B, V28.8H, V19.8H
    SHLL  V7.2D, V26.2S, #32
    TBX  V26.16B, { V25.16B, V26.16B, V27.16B }, V22.16B
    MLA  V4.8B, V7.8B, V26.8B
    AND  V2.8B, V0.8B, V24.8B
    DUP V16.2S, W13
    MLS  V25.8B, V19.8B, V16.8B
    ADDP  D27, V25.2D
    SHL V25.2D, V4.2D, #0x7
    TBL  V21.16B, { V18.16B, V19.16B }, V25.16B
    TBX  V16.8B, { V1.16B, V2.16B, V3.16B }, V21.8B
    MVNI  V0.8H, #0x14, LSL #8
    MOV D17, V27.D[0x0]
    AND  V4.16B, V16.16B, V0.16B
    MOV S22, V17.S[0x0]
    MOV  V5.16B, V22.16B
    SUBS  X26, X26, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_3
    MOVZ  X23, #0x80f4, LSL #0
    MOVK  X23, #0x80f4, LSL #16
    MOVK  X23, #0x80f4, LSL #32
    MOVK  X23, #0x80f4, LSL #48
    SUB  X6, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x9620, LSL #0
    MOVK  X23, #0x5bc3, LSL #16
    MOVK  X23, #0xcddf, LSL #32
    MOVK  X23, #0xde10, LSL #48
    SUB  X6, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x1044, LSL #0
    MOVK  X23, #0x4fda, LSL #16
    MOVK  X23, #0xf6cc, LSL #32
    MOVK  X23, #0xd7b6, LSL #48
    SUB  X6, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xae0f, LSL #0
    MOVK  X23, #0x1a46, LSL #16
    MOVK  X23, #0x958b, LSL #32
    MOVK  X23, #0x8d03, LSL #48
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xc092, LSL #0
    MOVK  X23, #0x8a41, LSL #16
    MOVK  X23, #0x8f6a, LSL #32
    MOVK  X23, #0x14c5, LSL #48
    SUB  X6, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x4f05, LSL #0
    MOVK  X23, #0x7f51, LSL #16
    MOVK  X23, #0x75c1, LSL #32
    MOVK  X23, #0xa120, LSL #48
    SUB  X6, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xf40b, LSL #0
    MOVK  X23, #0x38ee, LSL #16
    MOVK  X23, #0xfe21, LSL #32
    MOVK  X23, #0x4ea7, LSL #48
    SUB  X6, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x21e3, LSL #0
    MOVK  X23, #0x16b1, LSL #16
    MOVK  X23, #0x12b2, LSL #32
    MOVK  X23, #0x7dae, LSL #48
    SUB  X6, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xe7db, LSL #0
    MOVK  X23, #0x6122, LSL #16
    MOVK  X23, #0x2f5a, LSL #32
    MOVK  X23, #0x7d11, LSL #48
    SUB  X6, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x7f87, LSL #0
    MOVK  X23, #0xa1d2, LSL #16
    MOVK  X23, #0xd028, LSL #32
    MOVK  X23, #0xdc4f, LSL #48
    SUB  X6, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x37e8, LSL #0
    MOVK  X23, #0x14ba, LSL #16
    MOVK  X23, #0xa896, LSL #32
    MOVK  X23, #0xe482, LSL #48
    SUB  X6, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xad00, LSL #0
    MOVK  X23, #0x2b29, LSL #16
    MOVK  X23, #0xe0b6, LSL #32
    MOVK  X23, #0xe327, LSL #48
    SUB  X6, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X6, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x3cfa, LSL #0
    MOVK  X23, #0x5717, LSL #16
    MOVK  X23, #0xf292, LSL #32
    MOVK  X23, #0xa331, LSL #48
    SUB  X6, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x7ee1, LSL #0
    MOVK  X23, #0xb867, LSL #16
    MOVK  X23, #0xbf32, LSL #32
    MOVK  X23, #0xd162, LSL #48
    SUB  X6, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x63c9, LSL #0
    MOVK  X23, #0xd774, LSL #16
    MOVK  X23, #0x6dce, LSL #32
    MOVK  X23, #0xd4dd, LSL #48
    SUB  X6, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x80f4, LSL #0
    MOVK  X23, #0x9fdb, LSL #16
    MOVK  X23, #0xc30, LSL #32
    MOVK  X23, #0x614b, LSL #48
    SUB  X6, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xa1fa, LSL #0
    MOVK  X23, #0x8efe, LSL #16
    MOVK  X23, #0x15bf, LSL #32
    MOVK  X23, #0x19c9, LSL #48
    SUB  X6, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X6, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xfc3b, LSL #0
    SUB  X6, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x3692, LSL #0
    MOVK  X23, #0x46, LSL #16
    MOVK  X23, #0xfeb6, LSL #32
    MOVK  X23, #0xf080, LSL #48
    SUB  X6, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MRS  X6, FPSR
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xebff, LSL #0
    MOVK  X23, #0xebff, LSL #16
    MOVK  X23, #0xebff, LSL #32
    MOVK  X23, #0xebff, LSL #48
    FMOV  X6, V0.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xebff, LSL #0
    MOVK  X23, #0xebff, LSL #16
    MOVK  X23, #0xebff, LSL #32
    MOVK  X23, #0xebff, LSL #48
    FMOV  X6, D0
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xa1fa, LSL #0
    MOVK  X23, #0x8efe, LSL #16
    MOVK  X23, #0x15bf, LSL #32
    MOVK  X23, #0x19c9, LSL #48
    FMOV  X6, V1.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x80f4, LSL #0
    MOVK  X23, #0x9fdb, LSL #16
    MOVK  X23, #0xc30, LSL #32
    MOVK  X23, #0x614b, LSL #48
    FMOV  X6, D1
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V2.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, D2
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V3.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xc5c5, LSL #0
    MOVK  X23, #0x5c5, LSL #16
    MOVK  X23, #0xc5c5, LSL #32
    MOVK  X23, #0x5c5, LSL #48
    FMOV  X6, D3
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V4.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xf4, LSL #0
    MOVK  X23, #0x2b1, LSL #16
    MOVK  X23, #0x21e3, LSL #32
    MOVK  X23, #0x2b1, LSL #48
    FMOV  X6, D4
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V5.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x2b68, LSL #0
    MOVK  X23, #0x7ee1, LSL #16
    FMOV  X6, D5
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x63c9, LSL #0
    MOVK  X23, #0xd774, LSL #16
    MOVK  X23, #0x6dce, LSL #32
    MOVK  X23, #0xd4dd, LSL #48
    FMOV  X6, V6.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x7ee1, LSL #0
    MOVK  X23, #0xb867, LSL #16
    MOVK  X23, #0xbf32, LSL #32
    MOVK  X23, #0xd162, LSL #48
    FMOV  X6, D6
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V7.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, D7
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V8.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, D8
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xff4c, LSL #0
    MOVK  X23, #0xff4c, LSL #16
    MOVK  X23, #0xff4c, LSL #32
    MOVK  X23, #0xff4c, LSL #48
    FMOV  X6, V9.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xc5c5, LSL #0
    MOVK  X23, #0xff01, LSL #16
    FMOV  X6, D9
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x4d00, LSL #0
    MOVK  X23, #0x4d00, LSL #32
    FMOV  X6, V10.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x4d00, LSL #0
    MOVK  X23, #0x4d00, LSL #32
    FMOV  X6, D10
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x9620, LSL #0
    MOVK  X23, #0x5bc3, LSL #16
    MOVK  X23, #0x707, LSL #32
    MOVK  X23, #0x707, LSL #48
    FMOV  X6, V11.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x707, LSL #0
    MOVK  X23, #0x707, LSL #16
    MOVK  X23, #0x707, LSL #32
    MOVK  X23, #0x80f4, LSL #48
    FMOV  X6, D11
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xff, LSL #48
    FMOV  X6, V12.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xff, LSL #48
    FMOV  X6, D12
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x4f05, LSL #0
    MOVK  X23, #0x7f51, LSL #16
    MOVK  X23, #0x75c1, LSL #32
    MOVK  X23, #0xa120, LSL #48
    FMOV  X6, V13.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xc19, LSL #0
    MOVK  X23, #0x6a27, LSL #16
    MOVK  X23, #0x6142, LSL #32
    MOVK  X23, #0x2261, LSL #48
    FMOV  X6, D13
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xe7db, LSL #0
    MOVK  X23, #0x6122, LSL #16
    MOVK  X23, #0x2f5a, LSL #32
    MOVK  X23, #0x7d11, LSL #48
    FMOV  X6, V14.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xae0f, LSL #0
    MOVK  X23, #0x1a46, LSL #16
    MOVK  X23, #0x958b, LSL #32
    MOVK  X23, #0x8d03, LSL #48
    FMOV  X6, D14
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V15.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x80f4, LSL #0
    MOVK  X23, #0x80f4, LSL #16
    MOVK  X23, #0x80f4, LSL #32
    MOVK  X23, #0x80f4, LSL #48
    FMOV  X6, D15
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V16.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xf4, LSL #0
    MOVK  X23, #0x16b1, LSL #16
    MOVK  X23, #0x21e3, LSL #32
    MOVK  X23, #0x16b1, LSL #48
    FMOV  X6, D16
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V17.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x2b68, LSL #0
    MOVK  X23, #0x7ee1, LSL #16
    MOVK  X23, #0x7ee1, LSL #32
    MOVK  X23, #0x7ee1, LSL #48
    FMOV  X6, D17
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xf40b, LSL #0
    MOVK  X23, #0x38ee, LSL #16
    MOVK  X23, #0xfe21, LSL #32
    MOVK  X23, #0x4ea7, LSL #48
    FMOV  X6, V18.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x7877, LSL #0
    MOVK  X23, #0x2af4, LSL #16
    MOVK  X23, #0xe1c7, LSL #32
    MOVK  X23, #0x297f, LSL #48
    FMOV  X6, D18
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x7ee1, LSL #0
    MOVK  X23, #0x7ee1, LSL #16
    FMOV  X6, V19.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xf3f3, LSL #0
    FMOV  X6, D19
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V20.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xfff0, LSL #0
    MOVK  X23, #0x3fff, LSL #16
    MOVK  X23, #0xf30, LSL #32
    FMOV  X6, D20
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x7777, LSL #0
    MOVK  X23, #0x7777, LSL #16
    MOVK  X23, #0x7777, LSL #32
    MOVK  X23, #0x7777, LSL #48
    FMOV  X6, V21.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x2900, LSL #0
    MOVK  X23, #0x77c7, LSL #16
    MOVK  X23, #0x7777, LSL #32
    MOVK  X23, #0x7777, LSL #48
    FMOV  X6, D21
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V22.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x2b68, LSL #0
    MOVK  X23, #0x7ee1, LSL #16
    FMOV  X6, D22
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xf40b, LSL #0
    MOVK  X23, #0x38ee, LSL #16
    MOVK  X23, #0xfe21, LSL #32
    MOVK  X23, #0x4ea7, LSL #48
    FMOV  X6, V23.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x1044, LSL #0
    MOVK  X23, #0x4fda, LSL #16
    MOVK  X23, #0xf6cc, LSL #32
    MOVK  X23, #0xd7b6, LSL #48
    FMOV  X6, D23
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V24.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, D24
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V25.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x780, LSL #0
    MOVK  X23, #0x4, LSL #16
    FMOV  X6, D25
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xf4, LSL #0
    MOVK  X23, #0x7f92, LSL #32
    FMOV  X6, V26.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, D26
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V27.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x2b68, LSL #0
    MOVK  X23, #0x7ee1, LSL #16
    MOVK  X23, #0x7ee1, LSL #32
    MOVK  X23, #0x7ee1, LSL #48
    FMOV  X6, D27
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x131f, LSL #0
    MOVK  X23, #0x40, LSL #16
    MOVK  X23, #0x38, LSL #32
    FMOV  X6, V28.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X6, D28
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xae0f, LSL #0
    MOVK  X23, #0x1a46, LSL #16
    MOVK  X23, #0x400, LSL #32
    MOVK  X23, #0x406, LSL #48
    FMOV  X6, V29.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x88, LSL #16
    MOVK  X23, #0xf8, LSL #48
    FMOV  X6, D29
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V30.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xb7e0, LSL #0
    MOVK  X23, #0x67c8, LSL #32
    FMOV  X6, D30
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V31.D[1]
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x8613, LSL #16
    MOVK  X23, #0xf8f9, LSL #32
    MOVK  X23, #0xf8f8, LSL #48
    FMOV  X6, D31
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    FMOV  D0, X27
    FMOV  V0.D[1], X14
    FMOV  D1, X16
    FMOV  V1.D[1], X13
    FMOV  D2, X21
    FMOV  V2.D[1], X5
    FMOV  D3, X25
    FMOV  V3.D[1], X24
    FMOV  D4, X28
    FMOV  V4.D[1], X26
    FMOV  D5, X18
    FMOV  V5.D[1], X19
    FMOV  D6, X20
    FMOV  V6.D[1], X23
    FMOV  D7, X28
    FMOV  V7.D[1], X23
    FMOV  D8, X15
    FMOV  V8.D[1], X23
    FMOV  D9, X25
    FMOV  V9.D[1], X18
    FMOV  D10, X24
    FMOV  V10.D[1], X19
    FMOV  D11, X24
    FMOV  V11.D[1], X23
    FMOV  D12, X10
    FMOV  V12.D[1], X7
    FMOV  D13, X23
    FMOV  V13.D[1], X11
    FMOV  D14, X21
    FMOV  V14.D[1], X8
    FMOV  D15, X24
    FMOV  V15.D[1], X6
    FMOV  D16, X19
    FMOV  V16.D[1], X9
    FMOV  D17, X27
    FMOV  V17.D[1], X15
    FMOV  D18, X25
    FMOV  V18.D[1], X18
    FMOV  D19, X28
    FMOV  V19.D[1], X23
    FMOV  D20, X21
    FMOV  V20.D[1], X24
    FMOV  D21, X9
    FMOV  V21.D[1], X26
    FMOV  D22, X21
    FMOV  V22.D[1], X23
    FMOV  D23, X21
    FMOV  V23.D[1], X11
    FMOV  D24, X2
    FMOV  V24.D[1], X8
    FMOV  D25, X7
    FMOV  V25.D[1], X19
    FMOV  D26, X27
    FMOV  V26.D[1], X21
    FMOV  D27, X10
    FMOV  V27.D[1], X24
    FMOV  D28, X25
    FMOV  V28.D[1], X23
    FMOV  D29, X13
    FMOV  V29.D[1], X15
    FMOV  D30, X4
    FMOV  V30.D[1], X4
    FMOV  D31, X19
    FMOV  V31.D[1], X2
    MOVZ  X25, #0xf, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_4:
    DUP  V13.4S, V25.S[0x2]
    DUP  V15.8H, V28.H[0x3]
    DUP V27.2D, X9
    RADDHN2  V22.8H, V26.4S, V26.4S
    MOV V21.H[0x1], W21
    ZIP1  V23.8H, V29.8H, V15.8H
    SLI  V15.4S, V13.4S, #0x1f
    BSL  V10.8B, V23.8B, V15.8B
    SRI V23.2D, V30.2D, #27
    MOV  W23, V23.S[0x0]
    SHL  V13.8H, V10.8H, #0x5
    BIC  V17.8B, V13.8B, V22.8B
    ADDP  D26, V17.2D
    MVN  V30.8B, V24.8B
    SHL  V2.8B, V21.8B, #0x2
    ZIP1  V25.16B, V27.16B, V27.16B
    MOV V4.S[0x2], V31.S[0x2]
    DUP V0.4H, W6
    BIT  V14.16B, V0.16B, V4.16B
    MOV V2.D[0x0], V30.D[0x0]
    XTN2  V28.4S, V2.2D
    MOVI  V2.4H, #0xb4, LSL #8
    TBX  V29.16B, { V23.16B, V24.16B, V25.16B }, V26.16B
    AESMC  V10.16B, V14.16B
    INS V22.B[0x3], W16
    ADDV  B30, V2.16B
    MVN  V2.8B, V30.8B
    DUP S13, V2.S[0x1]
    TBL  V2.16B, { V6.16B, V7.16B, V8.16B, V9.16B }, V13.16B
    CNT  V14.16B, V29.16B
    DUP B0, V2.B[0x0]
    DUP D30, V10.D[0x1]
    DUP V31.4S, W5
    MLS  V15.4S, V28.4S, V30.4S
    RSUBHN  V10.2S, V15.2D, V31.2D
    INS V13.D[0x1], X17
    ADDV  H31, V22.8H
    DUP  V15.8H, V14.H[0x2]
    MOV V29.D[0x1], X25
    BIT  V26.8B, V13.8B, V29.8B
    AESE  V17.16B, V0.16B
    TBL  V24.8B, { V10.16B }, V26.8B
    AESMC  V13.16B, V17.16B
    TRN2  V0.2S, V13.2S, V31.2S
    MOVI  V9.8H, #0x71, LSL #8
    TRN1  V26.8H, V0.8H, V16.8H
    TBL  V28.16B, { V23.16B, V24.16B, V25.16B, V26.16B }, V26.16B
    REV16  V22.16B, V9.16B
    PMULL  V16.8H, V15.8B, V15.8B
    PMULL2  V8.1Q, V16.2D, V28.2D
    AESIMC  V2.16B, V22.16B
    SUBHN  V22.4H, V8.4S, V2.4S
    RSHRN V14.4H, V3.4S, #12
    AND  V0.8B, V5.8B, V15.8B
    MUL  V10.4H, V4.4H, V4.H[0x6]
    MLS  V5.8B, V22.8B, V26.8B
    CLS  V25.8B, V17.8B
    ADDHN2  V9.8H, V22.4S, V16.4S
    MLA  V24.8H, V24.8H, V6.H[0x7]
    XTN  V17.8B, V17.8H
    PMUL  V31.16B, V10.16B, V31.16B
    REV32  V3.8H, V4.8H
    ADD  V6.4H, V3.4H, V14.4H
    DUP  V13.8B, V0.B[0xf]
    NOT  V16.16B, V9.16B
    ADD  V26.8B, V13.8B, V16.8B
    DUP V15.2D, V5.D[0x0]
    ORR  V29.4S, #0x8a, LSL #24
    TBX  V2.16B, { V24.16B, V25.16B, V26.16B }, V24.16B
    SUBHN  V3.8B, V2.8H, V29.8H
    INS V8.S[0x2], W13
    MLS  V10.2S, V8.2S, V15.2S
    TBL  V22.16B, { V6.16B, V7.16B, V8.16B }, V6.16B
    SHRN V2.2S, V3.2D, #21
    TBL  V26.16B, { V16.16B, V17.16B, V18.16B, V19.16B }, V2.16B
    BIC  V9.4S, #0x1b
    RSHRN V15.8B, V26.8H, #3
    TBL  V28.8B, { V0.16B, V1.16B, V2.16B }, V22.8B
    DUP V25.8H, W10
    BIF  V26.8B, V25.8B, V28.8B
    ORR  V25.8B, V10.8B, V31.8B
    BIC  V28.16B, V26.16B, V9.16B
    AESMC  V26.16B, V15.16B
    DUP  V4.8B, V26.B[0x7]
    TRN1  V2.2S, V25.2S, V28.2S
    MOVI  V29.4S, #0xa3, MSL #8
    RSHRN2 V18.4S, V4.2D, #32
    TBL  V15.16B, { V30.16B, V31.16B, V0.16B, V1.16B }, V18.16B
    RBIT  V13.16B, V2.16B
    INS V1.H[0x4], W13
    SUB  V0.4S, V19.4S, V13.4S
    MOV V10.S[0x3], V29.S[0x1]
    MOV  V6.8B, V30.8B
    MUL  V9.16B, V6.16B, V6.16B
    CLZ  V2.8H, V0.8H
    TRN1  V18.4S, V9.4S, V15.4S
    RSHRN V26.8B, V2.8H, #4
    AESMC  V30.16B, V18.16B
    SHL  V17.2S, V1.2S, #0x1e
    AESMC  V16.16B, V30.16B
    ADDV  B2, V10.8B
    RSHRN2 V1.8H, V2.4S, #12
    PMULL2  V9.8H, V29.16B, V10.16B
    MUL  V10.2S, V1.2S, V16.S[0x0]
    RADDHN2  V15.4S, V10.2D, V10.2D
    REV32  V30.8H, V26.8H
    REV64  V13.2S, V9.2S
    TBL  V18.16B, { V21.16B, V22.16B, V23.16B }, V13.16B
    DUP B0, V17.B[0xd]
    CLZ  V2.8H, V18.8H
    RSUBHN2  V22.16B, V30.8H, V2.8H
    EOR  V26.16B, V22.16B, V22.16B
    MUL  V2.4S, V26.4S, V2.4S
    MUL  V9.2S, V2.2S, V2.2S
    SRI  V31.16B, V0.16B, #1
    MVNI  V23.8H, #0x42, LSL #8
    TBX  V0.8B, { V14.16B, V15.16B }, V9.8B
    ADDV  H29, V16.4H
    TBL  V26.16B, { V29.16B }, V26.16B
    AESE  V1.16B, V31.16B
    DUP  V14.4S, V23.S[0x1]
    ZIP1  V18.4H, V26.4H, V22.4H
    SHL  V26.8H, V14.8H, #0x6
    RSHRN V2.8B, V0.8H, #3
    MOVI  V29.2S, #0x7c, MSL #16
    BIC  V17.8B, V18.8B, V29.8B
    MUL  V31.2S, V17.2S, V1.2S
    SHRN2 V22.8H, V2.4S, #12
    RSUBHN2  V16.4S, V26.2D, V31.2D
    CNT  V9.8B, V16.8B
    INS V15.B[0xe], V22.B[0x2]
    MOVI  V23.4H, #0x8
    SHRN2 V22.16B, V9.8H, #1
    EOR  V31.8B, V23.8B, V23.8B
    PMULL  V18.8H, V31.8B, V31.8B
    BIC  V9.8B, V18.8B, V15.8B
    BIC  V30.8B, V22.8B, V9.8B
    REV32  V14.16B, V29.16B
    AESD  V0.16B, V3.16B
    REV32  V24.8B, V13.8B
    MOVI  V9.2D, #280379760050175
    RSHRN V1.4H, V21.4S, #12
    EOR  V19.8B, V11.8B, V5.8B
    INS V22.H[0x1], W20
    MOVI  V15.2S, #0xa3, LSL #8
    TBX  V26.16B, { V4.16B, V5.16B, V6.16B, V7.16B }, V15.16B
    ADDV  S23, V30.4S
    MOV V2.B[0x7], V24.B[0xa]
    DUP V18.2D, V0.D[0x0]
    INS V31.D[0x0], V18.D[0x1]
    MLA  V4.8H, V31.8H, V14.8H
    AND  V29.8B, V19.8B, V22.8B
    RADDHN2  V17.16B, V2.8H, V23.8H
    INS V24.H[0x4], W9
    RSHRN2 V2.16B, V9.8H, #2
    XTN  V18.8B, V29.8H
    MOV V9.S[0x2], V1.S[0x0]
    MOV V23.D[0x0], V26.D[0x0]
    MOV H14, V9.H[0x1]
    SHL  V7.4H, V4.4H, #0x0
    TRN1  V0.2D, V14.2D, V17.2D
    DUP H30, V7.H[0x1]
    MOV V26.H[0x3], W5
    DUP V7.8B, W18
    RADDHN2  V9.8H, V7.4S, V26.4S
    MVNI  V26.4S, #0x5d, MSL #8
    PMUL  V29.8B, V26.8B, V26.8B
    ORR  V26.4S, #0x39
    RSHRN2 V17.8H, V0.4S, #9
    SUBHN2  V1.8H, V9.4S, V23.4S
    TBX  V22.16B, { V12.16B, V13.16B, V14.16B, V15.16B }, V30.16B
    SHRN2 V4.8H, V24.4S, #4
    REV16  V24.16B, V18.16B
    DUP  V0.16B, V2.B[0x2]
    SUBHN2  V2.4S, V26.2D, V17.2D
    RADDHN2  V9.16B, V2.8H, V29.8H
    MLS  V7.8H, V24.8H, V0.H[0x1]
    MVNI  V14.4S, #0x32, LSL #8
    BIC  V0.16B, V19.16B, V7.16B
    CLZ  V18.8B, V9.8B
    AESD  V9.16B, V1.16B
    SRI  V26.4S, V0.4S, #9
    MLS  V2.8H, V22.8H, V26.8H
    MOV S7, V2.S[0x3]
    ZIP2  V3.2S, V7.2S, V4.2S
    MVN  V0.16B, V3.16B
    SHL  V23.16B, V14.16B, #0x4
    DUP  V19.4S, V23.S[0x3]
    ADDV  H26, V19.8H
    MLS  V30.2S, V18.2S, V9.2S
    SHRN2 V14.4S, V0.2D, #27
    ADDHN  V24.4H, V26.4S, V19.4S
    SHL  V7.2S, V14.2S, #0x7
    RSHRN2 V9.4S, V24.2D, #26
    BSL  V23.8B, V30.8B, V30.8B
    SHRN2 V29.16B, V23.8H, #1
    SHL V19.2D, V7.2D, #0x0
    ZIP2  V26.8B, V29.8B, V9.8B
    TBL  V17.8B, { V19.16B }, V19.8B
    MVNI  V18.4H, #0x15
    SUBS  X25, X25, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_4
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xae00, LSL #0
    MOVK  X4, #0x9382, LSL #16
    SUB  X24, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MRS  X24, FPSR
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X24, V0.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0x73ff, LSL #32
    MOVK  X4, #0x5251, LSL #48
    FMOV  X24, D0
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    FMOV  X24, V1.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, D1
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xa239, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xa239, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X24, V2.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, D2
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V3.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8c00, LSL #32
    MOVK  X4, #0xadae, LSL #48
    FMOV  X24, D3
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V4.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xb800, LSL #0
    MOVK  X4, #0xf0ae, LSL #16
    MOVK  X4, #0x8c00, LSL #32
    MOVK  X4, #0xadae, LSL #48
    FMOV  X24, D4
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V5.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xc784, LSL #0
    MOVK  X4, #0x8440, LSL #16
    FMOV  X24, D5
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V6.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x3900, LSL #0
    MOVK  X4, #0xdf02, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X24, D6
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V7.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xff80, LSL #0
    MOVK  X4, #0xffe6, LSL #16
    MOVK  X4, #0xff80, LSL #32
    MOVK  X4, #0xffe6, LSL #48
    FMOV  X24, D7
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V8.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, D8
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x3c3c, LSL #0
    MOVK  X4, #0x3c3c, LSL #16
    FMOV  X24, V9.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x527d, LSL #0
    MOVK  X4, #0x5230, LSL #16
    MOVK  X4, #0x7d52, LSL #32
    MOVK  X4, #0xed1a, LSL #48
    FMOV  X24, D9
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V10.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, D10
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V11.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, D11
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V12.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, D12
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V13.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, D13
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x7fff, LSL #0
    MOVK  X4, #0x4a2e, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X24, V14.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xcdff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xcdff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X24, D14
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V15.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xa300, LSL #0
    MOVK  X4, #0xa300, LSL #32
    FMOV  X24, D15
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x7fc0, LSL #0
    MOVK  X4, #0x7fc0, LSL #16
    MOVK  X4, #0x7fc0, LSL #32
    MOVK  X4, #0x7fc0, LSL #48
    FMOV  X24, V16.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x5c10, LSL #0
    MOVK  X4, #0xac14, LSL #16
    FMOV  X24, D16
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V17.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, D17
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V18.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffea, LSL #0
    MOVK  X4, #0xffea, LSL #16
    MOVK  X4, #0xffea, LSL #32
    MOVK  X4, #0xffea, LSL #48
    FMOV  X24, D18
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V19.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xff80, LSL #0
    MOVK  X4, #0xffe6, LSL #16
    MOVK  X4, #0xff80, LSL #32
    MOVK  X4, #0xffe6, LSL #48
    FMOV  X24, D19
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V20.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, D20
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V21.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, D21
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V22.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, D22
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V23.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xf0ae, LSL #0
    MOVK  X4, #0x1570, LSL #32
    MOVK  X4, #0x1c9c, LSL #48
    FMOV  X24, D23
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V24.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xf0f0, LSL #0
    MOVK  X4, #0xf0f0, LSL #16
    MOVK  X4, #0xf0f0, LSL #32
    MOVK  X4, #0xf0f0, LSL #48
    FMOV  X24, D24
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V25.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, D25
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V26.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x5200, LSL #0
    MOVK  X4, #0x7d04, LSL #16
    MOVK  X4, #0x1a55, LSL #32
    MOVK  X4, #0xed55, LSL #48
    FMOV  X24, D26
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V27.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, D27
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V28.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, D28
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x57, LSL #0
    MOVK  X4, #0x4eb8, LSL #16
    FMOV  X24, V29.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x400, LSL #0
    MOVK  X4, #0x5555, LSL #16
    MOVK  X4, #0x400, LSL #32
    MOVK  X4, #0x5555, LSL #48
    FMOV  X24, D29
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V30.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xf0ae, LSL #0
    MOVK  X4, #0x1570, LSL #32
    MOVK  X4, #0x1c9c, LSL #48
    FMOV  X24, D30
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V31.D[1]
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x5252, LSL #0
    MOVK  X4, #0xf52, LSL #16
    MOVK  X4, #0xf7d, LSL #32
    MOVK  X4, #0x5252, LSL #48
    FMOV  X24, D31
    SUB  X8, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
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
    FMOV  D0, X27
    FMOV  V0.D[1], X24
    FMOV  D1, X28
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X25
    FMOV  D3, X19
    FMOV  V3.D[1], X20
    FMOV  D4, X10
    FMOV  V4.D[1], X6
    FMOV  D5, X6
    FMOV  V5.D[1], X18
    FMOV  D6, X24
    FMOV  V6.D[1], X6
    FMOV  D7, X14
    FMOV  V7.D[1], X28
    FMOV  D8, X14
    FMOV  V8.D[1], X8
    FMOV  D9, X13
    FMOV  V9.D[1], X5
    FMOV  D10, X18
    FMOV  V10.D[1], X26
    FMOV  D11, X2
    FMOV  V11.D[1], X23
    FMOV  D12, X15
    FMOV  V12.D[1], X21
    FMOV  D13, X16
    FMOV  V13.D[1], X14
    FMOV  D14, X5
    FMOV  V14.D[1], X8
    FMOV  D15, X23
    FMOV  V15.D[1], X13
    FMOV  D16, X6
    FMOV  V16.D[1], X2
    FMOV  D17, X4
    FMOV  V17.D[1], X16
    FMOV  D18, X10
    FMOV  V18.D[1], X24
    FMOV  D19, X21
    FMOV  V19.D[1], X8
    FMOV  D20, X26
    FMOV  V20.D[1], X8
    FMOV  D21, X10
    FMOV  V21.D[1], X4
    FMOV  D22, X19
    FMOV  V22.D[1], X24
    FMOV  D23, X5
    FMOV  V23.D[1], X19
    FMOV  D24, X19
    FMOV  V24.D[1], X14
    FMOV  D25, X19
    FMOV  V25.D[1], X27
    FMOV  D26, X27
    FMOV  V26.D[1], X19
    FMOV  D27, X27
    FMOV  V27.D[1], X17
    FMOV  D28, X21
    FMOV  V28.D[1], X25
    FMOV  D29, X23
    FMOV  V29.D[1], X25
    FMOV  D30, X13
    FMOV  V30.D[1], X14
    FMOV  D31, X25
    FMOV  V31.D[1], X18
    MOVZ  X28, #0xf, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_5:
    CNT  V1.8B, V30.8B
    TBL  V5.16B, { V29.16B }, V26.16B
    AESD  V23.16B, V23.16B
    MOVI  V28.8B, #0x2a
    RSHRN V5.4H, V5.4S, #8
    BIF  V29.16B, V1.16B, V25.16B
    RSUBHN  V5.4H, V27.4S, V28.4S
    DUP B21, V5.B[0xd]
    AND  V30.8B, V24.8B, V29.8B
    AESMC  V17.16B, V21.16B
    SHRN V11.2S, V17.2D, #2
    BIC  V19.8B, V30.8B, V23.8B
    SHRN V4.2S, V19.2D, #12
    INS V16.B[0x3], V11.B[0xc]
    BIC  V20.4H, #0x58, LSL #8
    RSHRN2 V6.8H, V16.4S, #3
    ADDHN  V11.8B, V6.8H, V28.8H
    CLS  V5.8B, V11.8B
    MOV  V24.16B, V4.16B
    BIC  V14.8B, V24.8B, V20.8B
    CLZ  V24.4H, V5.4H
    DUP V4.2D, X7
    BSL  V5.16B, V24.16B, V14.16B
    MUL  V11.2S, V4.2S, V4.S[0x0]
    MOV V17.S[0x3], W15
    INS V19.H[0x3], V31.H[0x4]
    ADDV  S29, V19.4S
    DUP V23.8H, W24
    INS V16.B[0x6], W21
    RSHRN2 V20.4S, V16.2D, #5
    DUP V6.4H, W6
    INS V14.H[0x1], W6
    SHLL  V25.4S, V5.4H, #16
    INS V31.S[0x0], W10
    SRI  V16.2S, V6.2S, #1
    DUP H19, V11.H[0x6]
    TRN2  V24.8B, V25.8B, V19.8B
    MVNI  V11.2S, #0x66, MSL #16
    MOVI  V5.4S, #0xba, LSL #16
    AESE  V6.16B, V5.16B
    MOVI  V28.16B, #0xc8
    REV64  V4.2S, V28.2S
    DUP S25, V3.S[0x3]
    MVNI  V15.4S, #0xbe, MSL #8
    ZIP2  V3.2D, V31.2D, V15.2D
    TBL  V28.8B, { V16.16B }, V16.8B
    SHRN2 V5.4S, V20.2D, #30
    DUP V19.8B, W9
    RSHRN V15.2S, V23.2D, #18
    INS V25.D[0x1], X27
    TBX  V23.8B, { V6.16B, V7.16B, V8.16B }, V14.8B
    MOV V31.H[0x6], W5
    ADDV  H7, V11.8H
    RSHRN2 V16.16B, V7.8H, #5
    RSUBHN2  V14.16B, V25.8H, V25.8H
    DUP V7.16B, W8
    INS V6.H[0x5], V31.H[0x6]
    SRI  V20.8H, V14.8H, #3
    ZIP1  V11.4S, V19.4S, V4.4S
    DUP  V8.8B, V15.B[0xd]
    RSHRN2 V4.8H, V23.4S, #15
    SHL  V15.16B, V24.16B, #0x1
    BIC  V19.4H, #0x23
    SLI  V14.4S, V8.4S, #0xb
    SLI  V8.8B, V16.8B, #0x3
    MUL  V7.2S, V14.2S, V7.S[0x1]
    PMULL2  V21.1Q, V8.2D, V8.2D
    BIF  V24.16B, V5.16B, V7.16B
    CLS  V16.2S, V6.2S
    SUB  V6.2D, V4.2D, V11.2D
    MLS  V31.8H, V21.8H, V4.H[0x3]
    MOV  W8, V20.S[0x3]
    DUP V4.2D, X5
    SUBHN  V7.4H, V19.4S, V4.4S
    AND  V5.16B, V15.16B, V24.16B
    SUB  V8.16B, V7.16B, V6.16B
    XTN  V11.8B, V5.8H
    AESMC  V14.16B, V11.16B
    EXT  V25.16B, V14.16B, V8.16B, #0xf
    MLA  V23.8H, V31.8H, V3.H[0x6]
    SHRN V6.2S, V16.2D, #8
    PMULL  V7.1Q, V6.1D, V23.1D
    DUP V24.16B, W8
    TBX  V6.8B, { V24.16B, V25.16B }, V24.8B
    MOV H11, V7.H[0x6]
    MLA  V23.8H, V6.8H, V11.H[0x2]
    PMULL  V14.8H, V11.8B, V5.8B
    RSHRN V21.2S, V2.2D, #10
    ORR  V20.16B, V13.16B, V31.16B
    TBX  V15.16B, { V6.16B }, V0.16B
    SHRN2 V5.4S, V3.2D, #10
    ADDP  V25.4H, V15.4H, V17.4H
    SHL  V18.4S, V8.4S, #0x11
    ABS  V16.2S, V13.2S
    XTN2  V13.8H, V1.4S
    MVNI  V2.2S, #0xb6, MSL #8
    DUP  V11.2S, V14.S[0x3]
    MOVI  V6.8H, #0x7d
    SHL  V8.4S, V23.4S, #0x10
    RSHRN V15.2S, V25.2D, #22
    EXT  V4.16B, V30.16B, V20.16B, #0x2
    BIC  V23.8B, V4.8B, V3.8B
    RSHRN2 V31.8H, V23.4S, #8
    SUBHN2  V19.4S, V5.2D, V31.2D
    MLA  V0.4S, V28.4S, V21.S[0x3]
    ABS  V17.4H, V0.4H
    MUL  V30.8B, V13.8B, V11.8B
    SHL V14.2D, V2.2D, #0x35
    DUP V2.2D, X8
    BIC  V24.8B, V18.8B, V2.8B
    INS V28.S[0x1], W26
    DUP V20.8H, W18
    ABS  V1.2S, V8.2S
    AND  V18.8B, V24.8B, V28.8B
    PMULL2  V31.1Q, V15.2D, V19.2D
    ADDV  B8, V16.8B
    MOV V11.H[0x7], V31.H[0x4]
    DUP H16, V17.H[0x7]
    BSL  V17.16B, V20.16B, V18.16B
    EOR  V2.16B, V1.16B, V6.16B
    TBL  V18.16B, { V7.16B, V8.16B }, V8.16B
    MOV D3, V13.D[0x0]
    XTN2  V24.8H, V30.4S
    RSUBHN  V23.8B, V14.8H, V14.8H
    ZIP2  V1.2S, V24.2S, V24.2S
    MLA  V31.4H, V1.4H, V12.H[0x4]
    ADDV  S13, V18.4S
    MOV H28, V23.H[0x2]
    SUBHN2  V5.8H, V2.4S, V3.4S
    ADDV  S4, V17.4S
    DUP D19, V13.D[0x0]
    RADDHN  V13.2S, V4.2D, V16.2D
    ADD  V14.4S, V19.4S, V31.4S
    NOT  V15.16B, V5.16B
    CLS  V16.16B, V11.16B
    TBX  V20.8B, { V14.16B, V15.16B, V16.16B }, V28.8B
    DUP  V16.4H, V20.H[0x7]
    XTN2  V6.16B, V13.8H
    SRI  V11.4S, V6.4S, #4
    PMUL  V30.8B, V11.8B, V16.8B
    SHL  V7.8H, V3.8H, #0x9
    TBX  V31.8B, { V19.16B, V20.16B, V21.16B }, V19.8B
    RSHRN2 V12.4S, V26.2D, #16
    BIT  V4.16B, V3.16B, V14.16B
    CLZ  V3.4S, V9.4S
    PMULL  V1.1Q, V26.1D, V15.1D
    EOR  V16.16B, V29.16B, V24.16B
    MLS  V17.8B, V28.8B, V0.8B
    RSHRN V18.8B, V1.8H, #7
    MUL  V28.8H, V30.8H, V14.H[0x1]
    MUL  V23.4S, V16.4S, V7.4S
    MOV V0.S[0x2], W6
    SHRN2 V16.16B, V17.8H, #1
    MOV V13.D[0x1], X4
    AESE  V9.16B, V18.16B
    UZP2  V11.16B, V0.16B, V22.16B
    BIC  V21.8B, V4.8B, V16.8B
    SRI V15.2D, V11.2D, #39
    MOVI  V6.2D, #18374686479688400895
    REV16  V16.8B, V31.8B
    MUL  V20.2S, V23.2S, V3.S[0x1]
    AND  V19.8B, V12.8B, V16.8B
    MOV  X10, V15.D[0x1]
    TBL  V22.8B, { V20.16B, V21.16B }, V19.8B
    MLA  V31.2S, V22.2S, V13.2S
    MUL  V6.4S, V31.4S, V9.4S
    MOV V7.H[0x1], V6.H[0x3]
    TBL  V0.8B, { V24.16B, V25.16B, V26.16B }, V7.8B
    MOVI  V15.8B, #0xac
    ADDHN2  V22.16B, V15.8H, V15.8H
    SUBHN2  V25.16B, V0.8H, V0.8H
    ORR  V11.4H, #0xa5, LSL #8
    SHRN V1.8B, V22.8H, #7
    MVN  V23.16B, V1.16B
    TRN2  V22.2S, V25.2S, V11.2S
    SUBHN  V17.8B, V23.8H, V22.8H
    MOV V15.S[0x0], V17.S[0x0]
    ORR  V7.4S, #0xd9, LSL #8
    TBL  V0.8B, { V7.16B }, V15.8B
    SLI  V6.4S, V0.4S, #0x4
    MUL  V17.2S, V6.2S, V6.S[0x0]
    SUB  V7.4S, V17.4S, V17.4S
    MOVI  V23.8B, #0x30
    MOV  X5, V24.D[0x1]
    XTN  V26.2S, V13.2D
    REV16  V31.16B, V3.16B
    MOV  W4, V25.S[0x3]
    SUB  V15.8B, V31.8B, V9.8B
    INS V31.B[0xa], W11
    RSUBHN2  V22.16B, V21.8H, V2.8H
    RSHRN2 V11.16B, V15.8H, #1
    DUP  V25.4H, V17.H[0x5]
    DUP  V9.8H, V20.H[0x5]
    MOV V15.H[0x2], W14
    EOR  V17.8B, V23.8B, V23.8B
    UZP2  V1.16B, V26.16B, V17.16B
    RADDHN2  V12.8H, V15.4S, V1.4S
    RSHRN2 V21.4S, V12.2D, #5
    BSL  V19.16B, V15.16B, V7.16B
    UZP1  V2.4H, V31.4H, V19.4H
    SUBS  X28, X28, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_5
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x1d5, LSL #0
    MOVK  X17, #0xe800, LSL #16
    MOVK  X17, #0xff82, LSL #32
    MOVK  X17, #0xff82, LSL #48
    SUB  X2, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MRS  X2, FPSR
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V0.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, D0
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V1.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, D1
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V2.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x2000, LSL #0
    MOVK  X17, #0x2000, LSL #16
    FMOV  X2, D2
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x20, LSL #0
    MOVK  X17, #0x20, LSL #32
    FMOV  X2, V3.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x20, LSL #0
    MOVK  X17, #0x20, LSL #32
    FMOV  X2, D3
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V4.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x2, LSL #16
    FMOV  X2, D4
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x2b6b, LSL #0
    MOVK  X17, #0x166b, LSL #16
    MOVK  X17, #0x7d, LSL #32
    MOVK  X17, #0x7d, LSL #48
    FMOV  X2, V5.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, D5
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V6.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, D6
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V7.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, D7
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V8.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, D8
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V9.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, D9
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X2, V10.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X2, D10
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xcfcf, LSL #0
    MOVK  X17, #0xcfcf, LSL #16
    FMOV  X2, V11.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xa500, LSL #0
    MOVK  X17, #0xa500, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xa500, LSL #48
    FMOV  X2, D11
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x9d9e, LSL #0
    MOVK  X17, #0x9d9e, LSL #16
    FMOV  X2, V12.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X2, D12
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V13.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, D13
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V14.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x773c, LSL #16
    MOVK  X17, #0x773c, LSL #48
    FMOV  X2, D14
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V15.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xbd9d, LSL #0
    MOVK  X17, #0x9d9d, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0x9d9d, LSL #48
    FMOV  X2, D15
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V16.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, D16
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V17.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, D17
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V18.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, D18
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V19.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, D19
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V20.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, D20
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xf4ed, LSL #32
    MOVK  X17, #0x4ec, LSL #48
    FMOV  X2, V21.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, D21
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xd500, LSL #0
    MOVK  X17, #0xea00, LSL #16
    FMOV  X2, V22.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xa500, LSL #48
    FMOV  X2, D22
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V23.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x3030, LSL #0
    MOVK  X17, #0x3030, LSL #16
    MOVK  X17, #0x3030, LSL #32
    MOVK  X17, #0x3030, LSL #48
    FMOV  X2, D23
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V24.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x6e26, LSL #16
    MOVK  X17, #0x202, LSL #48
    FMOV  X2, D24
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V25.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, D25
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V26.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, D26
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X2, V27.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X2, D27
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V28.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, D28
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V29.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x2000, LSL #16
    FMOV  X2, D29
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V30.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, D30
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x2000, LSL #0
    MOVK  X17, #0xff, LSL #16
    MOVK  X17, #0x2000, LSL #32
    FMOV  X2, V31.D[1]
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x2000, LSL #0
    MOVK  X17, #0x2000, LSL #32
    FMOV  X2, D31
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x9485, LSL #0
    MOVK  X2, #0xf600, LSL #16
    MOVK  X2, #0xc4a7, LSL #32
    MOVK  X2, #0x8437, LSL #48
    MOVZ  X4, #0xcb56, LSL #0
    MOVK  X4, #0x759f, LSL #16
    MOVK  X4, #0x6d4c, LSL #32
    MOVK  X4, #0x75d9, LSL #48
    MOVZ  X5, #0x4aa0, LSL #0
    MOVK  X5, #0x2ee0, LSL #16
    MOVK  X5, #0xe1f1, LSL #32
    MOVK  X5, #0x6a32, LSL #48
    MOVZ  X6, #0xbffe, LSL #0
    MOVK  X6, #0xe526, LSL #16
    MOVK  X6, #0xe08d, LSL #32
    MOVK  X6, #0x5141, LSL #48
    MOVZ  X7, #0xd676, LSL #0
    MOVK  X7, #0x5f25, LSL #16
    MOVK  X7, #0x10f, LSL #32
    MOVK  X7, #0xf90a, LSL #48
    MOVZ  X8, #0xe593, LSL #0
    MOVK  X8, #0xb8f5, LSL #16
    MOVK  X8, #0x9527, LSL #32
    MOVK  X8, #0xa6af, LSL #48
    MOVZ  X9, #0xe4ba, LSL #0
    MOVK  X9, #0xeae, LSL #16
    MOVK  X9, #0x5a6d, LSL #32
    MOVK  X9, #0xd3bc, LSL #48
    MOVZ  X10, #0x4777, LSL #0
    MOVK  X10, #0xc2ad, LSL #16
    MOVK  X10, #0xb55e, LSL #32
    MOVK  X10, #0x39c, LSL #48
    MOVZ  X11, #0x931, LSL #0
    MOVK  X11, #0x55a8, LSL #16
    MOVK  X11, #0xebeb, LSL #32
    MOVK  X11, #0x280d, LSL #48
    MOVZ  X13, #0xbdfb, LSL #0
    MOVK  X13, #0x442c, LSL #16
    MOVK  X13, #0xffeb, LSL #32
    MOVK  X13, #0xf916, LSL #48
    MOVZ  X14, #0x84e2, LSL #0
    MOVK  X14, #0x6990, LSL #16
    MOVK  X14, #0x6c1, LSL #32
    MOVK  X14, #0x441a, LSL #48
    MOVZ  X15, #0xd7c9, LSL #0
    MOVK  X15, #0x3223, LSL #16
    MOVK  X15, #0xe4ca, LSL #32
    MOVK  X15, #0xcc85, LSL #48
    MOVZ  X16, #0x3846, LSL #0
    MOVK  X16, #0x3887, LSL #16
    MOVK  X16, #0x69f8, LSL #32
    MOVK  X16, #0x32a9, LSL #48
    MOVZ  X17, #0x47ab, LSL #0
    MOVK  X17, #0xb7c7, LSL #16
    MOVK  X17, #0x3c65, LSL #32
    MOVK  X17, #0x912, LSL #48
    MOVZ  X18, #0x3e61, LSL #0
    MOVK  X18, #0xc64b, LSL #16
    MOVK  X18, #0x5a8c, LSL #32
    MOVK  X18, #0x8fb0, LSL #48
    MOVZ  X19, #0xc3af, LSL #0
    MOVK  X19, #0x8c6c, LSL #16
    MOVK  X19, #0xb407, LSL #32
    MOVK  X19, #0xc15a, LSL #48
    MOVZ  X20, #0xc029, LSL #0
    MOVK  X20, #0x847e, LSL #16
    MOVK  X20, #0x55e4, LSL #32
    MOVK  X20, #0xb8, LSL #48
    MOVZ  X21, #0xf07d, LSL #0
    MOVK  X21, #0xbf60, LSL #16
    MOVK  X21, #0x602e, LSL #32
    MOVK  X21, #0xd9f9, LSL #48
    MOVZ  X23, #0x9cf, LSL #0
    MOVK  X23, #0xa19, LSL #16
    MOVK  X23, #0x7882, LSL #32
    MOVK  X23, #0x7075, LSL #48
    MOVZ  X24, #0xc1a3, LSL #0
    MOVK  X24, #0x6ec2, LSL #16
    MOVK  X24, #0x526a, LSL #32
    MOVK  X24, #0xd5cf, LSL #48
    MOVZ  X25, #0x3b57, LSL #0
    MOVK  X25, #0x8f3b, LSL #16
    MOVK  X25, #0xf86c, LSL #32
    MOVK  X25, #0x57c2, LSL #48
    MOVZ  X26, #0x8855, LSL #0
    MOVK  X26, #0xf9fb, LSL #16
    MOVK  X26, #0x550e, LSL #32
    MOVK  X26, #0xc78e, LSL #48
    MOVZ  X27, #0xad08, LSL #0
    MOVK  X27, #0xfe9, LSL #16
    MOVK  X27, #0xe6b0, LSL #32
    MOVK  X27, #0x1ea0, LSL #48
    MOVZ  X28, #0xca56, LSL #0
    MOVK  X28, #0xc0d8, LSL #16
    MOVK  X28, #0xbd76, LSL #32
    MOVK  X28, #0xd120, LSL #48
    FMOV  D0, X20
    FMOV  V0.D[1], X27
    FMOV  D1, X24
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X28
    FMOV  D3, X14
    FMOV  V3.D[1], X5
    FMOV  D4, X4
    FMOV  V4.D[1], X6
    FMOV  D5, X13
    FMOV  V5.D[1], X5
    FMOV  D6, X28
    FMOV  V6.D[1], X6
    FMOV  D7, X11
    FMOV  V7.D[1], X6
    FMOV  D8, X28
    FMOV  V8.D[1], X15
    FMOV  D9, X20
    FMOV  V9.D[1], X10
    FMOV  D10, X5
    FMOV  V10.D[1], X2
    FMOV  D11, X28
    FMOV  V11.D[1], X15
    FMOV  D12, X26
    FMOV  V12.D[1], X9
    FMOV  D13, X2
    FMOV  V13.D[1], X11
    FMOV  D14, X13
    FMOV  V14.D[1], X11
    FMOV  D15, X4
    FMOV  V15.D[1], X23
    FMOV  D16, X5
    FMOV  V16.D[1], X5
    FMOV  D17, X15
    FMOV  V17.D[1], X11
    FMOV  D18, X24
    FMOV  V18.D[1], X15
    FMOV  D19, X10
    FMOV  V19.D[1], X27
    FMOV  D20, X18
    FMOV  V20.D[1], X17
    FMOV  D21, X26
    FMOV  V21.D[1], X16
    FMOV  D22, X5
    FMOV  V22.D[1], X26
    FMOV  D23, X25
    FMOV  V23.D[1], X14
    FMOV  D24, X8
    FMOV  V24.D[1], X26
    FMOV  D25, X18
    FMOV  V25.D[1], X10
    FMOV  D26, X7
    FMOV  V26.D[1], X5
    FMOV  D27, X16
    FMOV  V27.D[1], X5
    FMOV  D28, X21
    FMOV  V28.D[1], X18
    FMOV  D29, X11
    FMOV  V29.D[1], X26
    FMOV  D30, X10
    FMOV  V30.D[1], X23
    FMOV  D31, X23
    FMOV  V31.D[1], X7
    MOVZ  X16, #0xf, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_6:
    MOV  X8, V24.D[0x1]
    MVNI  V24.2S, #0x8c, MSL #16
    SUBHN  V10.4H, V18.4S, V29.4S
    XTN  V26.8B, V25.8H
    INS V2.D[0x0], V28.D[0x1]
    MLS  V8.4H, V2.4H, V13.H[0x5]
    NEG  V26.2S, V8.2S
    MOV V6.B[0xc], V24.B[0xf]
    ZIP1  V22.8H, V30.8H, V26.8H
    ORN  V27.8B, V31.8B, V10.8B
    SRI  V7.2S, V27.2S, #29
    BIC  V8.8H, #0x61, LSL #8
    SHRN2 V31.8H, V6.4S, #6
    SHL  V30.4H, V7.4H, #0xe
    MVNI  V8.4H, #0x41, LSL #8
    SLI  V30.8H, V22.8H, #0x6
    MOV S2, V31.S[0x1]
    MOV V1.S[0x3], V2.S[0x2]
    RADDHN2  V26.4S, V30.2D, V1.2D
    PMULL2  V6.8H, V26.16B, V26.16B
    MOV V1.H[0x3], W7
    DUP  V31.8B, V8.B[0xc]
    MOV V8.B[0xd], V31.B[0xf]
    SHL  V10.2S, V8.2S, #0x13
    SHRN V13.4H, V10.4S, #13
    ADDHN2  V30.16B, V1.8H, V6.8H
    BIC  V7.8B, V13.8B, V30.8B
    MOV V24.H[0x3], V2.H[0x1]
    SHLL  V31.8H, V12.8B, #8
    SRI  V10.8B, V12.8B, #8
    DUP S8, V18.S[0x3]
    DUP  V12.4S, V17.S[0x0]
    MOV V2.S[0x1], W25
    PMULL  V1.1Q, V24.1D, V13.1D
    RSHRN2 V22.8H, V6.4S, #6
    ORN  V30.8B, V18.8B, V1.8B
    SRI  V18.8H, V0.8H, #16
    MOV V17.D[0x1], X16
    PMUL  V26.8B, V17.8B, V2.8B
    MLA  V17.2S, V8.2S, V10.2S
    REV32  V1.8H, V17.8H
    NEG  V13.2D, V31.2D
    SHL V2.2D, V1.2D, #0x36
    SUBHN2  V0.8H, V22.4S, V7.4S
    ADDV  H24, V18.4H
    MOV V10.D[0x0], X27
    BIC  V8.8H, #0xa4, LSL #8
    SHRN V22.8B, V30.8H, #6
    CLS  V17.4H, V13.4H
    MLS  V7.8B, V26.8B, V0.8B
    EXT  V31.8B, V2.8B, V17.8B, #0x7
    BIC  V13.4H, #0x17
    DUP H1, V13.H[0x3]
    TBX  V15.16B, { V12.16B }, V22.16B
    SHLL  V22.2D, V7.2S, #32
    MVN  V18.16B, V10.16B
    MLA  V30.4S, V24.4S, V24.S[0x2]
    SUB  V6.16B, V8.16B, V22.16B
    SHRN2 V12.8H, V6.4S, #16
    PMULL2  V13.1Q, V30.2D, V18.2D
    MOV  V7.16B, V13.16B
    RSHRN2 V10.16B, V7.8H, #6
    RSHRN V17.2S, V29.2D, #28
    MOV V2.H[0x5], V0.H[0x1]
    TBL  V0.8B, { V5.16B, V6.16B, V7.16B, V8.16B }, V15.8B
    SHRN2 V22.8H, V0.4S, #11
    TBL  V15.16B, { V24.16B, V25.16B, V26.16B }, V2.16B
    MLA  V26.4H, V12.4H, V10.H[0x4]
    SRI  V29.4S, V1.4S, #9
    AND  V12.16B, V10.16B, V31.16B
    MOVI  V13.2S, #0xe9, LSL #16
    RSHRN V7.8B, V29.8H, #8
    DUP  V1.16B, V22.B[0x8]
    DUP V2.8B, W2
    AND  V2.16B, V7.16B, V12.16B
    INS V29.S[0x2], V2.S[0x2]
    PMULL2  V21.8H, V15.16B, V29.16B
    SHL  V6.16B, V17.16B, #0x3
    DUP V24.8B, W26
    INS V18.H[0x7], W11
    MLS  V8.8H, V18.8H, V1.H[0x0]
    MOV V0.S[0x2], V5.S[0x1]
    MOVI  V15.4S, #0xba
    MOVI  V18.2D, #281470698520320
    MOV  X27, V19.D[0x1]
    AESD  V30.16B, V26.16B
    RSUBHN2  V25.16B, V24.8H, V30.8H
    EXT  V5.8B, V25.8B, V13.8B, #0x3
    SHL  V24.8B, V0.8B, #0x0
    SLI  V17.8B, V21.8B, #0x3
    PMULL2  V21.1Q, V5.2D, V5.2D
    DUP  V30.8B, V8.B[0xe]
    INS V5.H[0x6], V30.H[0x6]
    TRN1  V25.8B, V24.8B, V18.8B
    MUL  V0.4H, V21.4H, V5.H[0x4]
    TBX  V29.8B, { V6.16B }, V15.8B
    MVNI  V26.4S, #0xa2, LSL #8
    DUP  V31.16B, V26.B[0x9]
    PMULL  V24.1Q, V25.1D, V29.1D
    MVN  V21.16B, V24.16B
    UZP2  V19.2D, V0.2D, V17.2D
    TBL  V18.8B, { V18.16B }, V8.8B
    DUP  V5.4S, V21.S[0x1]
    DUP  V15.8H, V16.H[0x5]
    INS V29.B[0xd], V5.B[0x5]
    MUL  V13.8B, V31.8B, V19.8B
    MLS  V25.4H, V18.4H, V5.H[0x1]
    SHRN2 V30.16B, V25.8H, #2
    MOV D6, V30.D[0x1]
    INS V25.H[0x3], V13.H[0x3]
    SUBHN  V8.4H, V25.4S, V15.4S
    EXT  V26.8B, V29.8B, V29.8B, #0x0
    DUP V5.16B, W6
    SUB  V25.2D, V6.2D, V6.2D
    SHL V6.2D, V5.2D, #0xa
    ZIP2  V24.2D, V25.2D, V6.2D
    MOVI  V16.4H, #0x8f
    DUP  V19.2S, V16.S[0x1]
    MOV  X20, V24.D[0x0]
    EXT  V31.8B, V19.8B, V19.8B, #0x6
    MVNI  V6.8H, #0xef
    TBX  V25.8B, { V24.16B, V25.16B, V26.16B }, V6.8B
    ADDHN  V17.8B, V8.8H, V25.8H
    TBL  V24.8B, { V13.16B, V14.16B }, V31.8B
    SHL  V8.4H, V17.4H, #0x5
    EOR  V16.16B, V8.16B, V8.16B
    PMULL2  V5.1Q, V16.2D, V24.2D
    MLS  V19.4H, V14.4H, V3.H[0x6]
    ORR  V13.4H, #0xb2
    SUBHN2  V21.4S, V14.2D, V20.2D
    SHRN2 V26.4S, V26.2D, #20
    RADDHN2  V6.4S, V13.2D, V13.2D
    SHRN2 V15.4S, V20.2D, #5
    DUP H16, V20.H[0x4]
    SHLL  V25.4S, V31.4H, #16
    INS V14.H[0x3], V17.H[0x6]
    ADDHN  V29.8B, V5.8H, V19.8H
    CLZ  V20.4S, V21.4S
    SHRN2 V24.4S, V6.2D, #8
    MOV S31, V16.S[0x0]
    MOV V28.B[0x8], V15.B[0x4]
    INS V17.H[0x5], W10
    RSUBHN2  V15.4S, V26.2D, V28.2D
    DUP V19.8B, W16
    SHRN V6.2S, V14.2D, #6
    BIC  V5.2S, #0x84, LSL #8
    UZP2  V21.8B, V25.8B, V20.8B
    SLI  V25.2S, V5.2S, #0x1
    ADDHN  V16.8B, V6.8H, V25.8H
    INS V28.S[0x0], V17.S[0x1]
    UZP1  V17.2S, V28.2S, V16.2S
    DUP  V13.4H, V24.H[0x6]
    TBL  V14.8B, { V19.16B, V20.16B }, V17.8B
    MOV S20, V31.S[0x3]
    TBX  V19.8B, { V13.16B }, V20.8B
    INS V17.B[0xa], V14.B[0x7]
    ADDV  B26, V19.8B
    TBX  V5.16B, { V6.16B, V7.16B, V8.16B, V9.16B }, V21.16B
    TBX  V14.16B, { V19.16B, V20.16B }, V15.16B
    MOV  X26, V26.D[0x1]
    AESIMC  V28.16B, V17.16B
    BIC  V15.2S, #0xd4
    DUP S8, V5.S[0x1]
    DUP H21, V28.H[0x1]
    RSHRN V25.4H, V29.4S, #10
    BIC  V17.8H, #0x2b, LSL #8
    SUB  V24.8H, V15.8H, V14.8H
    SHRN2 V19.4S, V8.2D, #12
    BIF  V15.8B, V19.8B, V21.8B
    REV32  V9.4H, V28.4H
    DUP B14, V28.B[0xd]
    RSUBHN  V5.4H, V14.4S, V14.4S
    SHL  V14.4S, V24.4S, #0x7
    SHRN2 V16.16B, V27.8H, #8
    DUP V28.4H, W26
    ORR  V27.4H, #0x57, LSL #8
    MOV  W19, V25.S[0x0]
    CLZ  V20.2S, V9.2S
    AESMC  V25.16B, V14.16B
    MOV V21.B[0x7], V25.B[0xa]
    ORN  V9.16B, V5.16B, V15.16B
    MUL  V19.2S, V16.2S, V28.S[0x3]
    SHL V8.2D, V27.2D, #0xe
    EXT  V14.16B, V20.16B, V17.16B, #0x5
    ADDP  D24, V19.2D
    BIT  V20.8B, V9.8B, V21.8B
    MOV V27.D[0x0], V8.D[0x1]
    INS V15.S[0x3], W11
    TRN1  V9.16B, V27.16B, V20.16B
    EOR  V19.16B, V15.16B, V16.16B
    SHL  V29.8H, V9.8H, #0x4
    EXT  V25.8B, V10.8B, V19.8B, #0x7
    PMULL  V8.8H, V24.8B, V29.8B
    DUP H5, V8.H[0x7]
    MOV  X6, V25.D[0x0]
    BIC  V19.4S, #0x98
    ORN  V28.16B, V25.16B, V19.16B
    MOV V21.S[0x3], W20
    MLS  V17.4H, V28.4H, V14.H[0x1]
    SHL V29.2D, V5.2D, #0x2d
    SUBS  X16, X16, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_6
    MOVZ  X17, #0x9485, LSL #0
    MOVK  X17, #0xf600, LSL #16
    MOVK  X17, #0xc4a7, LSL #32
    MOVK  X17, #0x8437, LSL #48
    SUB  X14, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xcb56, LSL #0
    MOVK  X17, #0x759f, LSL #16
    MOVK  X17, #0x6d4c, LSL #32
    MOVK  X17, #0x75d9, LSL #48
    SUB  X14, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x4aa0, LSL #0
    MOVK  X17, #0x2ee0, LSL #16
    MOVK  X17, #0xe1f1, LSL #32
    MOVK  X17, #0x6a32, LSL #48
    SUB  X14, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x155, LSL #0
    MOVK  X17, #0x101, LSL #16
    MOVK  X17, #0x101, LSL #32
    MOVK  X17, #0x101, LSL #48
    SUB  X14, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xd676, LSL #0
    MOVK  X17, #0x5f25, LSL #16
    MOVK  X17, #0x10f, LSL #32
    MOVK  X17, #0xf90a, LSL #48
    SUB  X14, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xe4ba, LSL #0
    MOVK  X17, #0xeae, LSL #16
    MOVK  X17, #0x5a6d, LSL #32
    MOVK  X17, #0xd3bc, LSL #48
    SUB  X14, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x4777, LSL #0
    MOVK  X17, #0xc2ad, LSL #16
    MOVK  X17, #0xb55e, LSL #32
    MOVK  X17, #0x39c, LSL #48
    SUB  X14, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x931, LSL #0
    MOVK  X17, #0x55a8, LSL #16
    MOVK  X17, #0xebeb, LSL #32
    MOVK  X17, #0x280d, LSL #48
    SUB  X14, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xbdfb, LSL #0
    MOVK  X17, #0x442c, LSL #16
    MOVK  X17, #0xffeb, LSL #32
    MOVK  X17, #0xf916, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xd7c9, LSL #0
    MOVK  X17, #0x3223, LSL #16
    MOVK  X17, #0xe4ca, LSL #32
    MOVK  X17, #0xcc85, LSL #48
    SUB  X14, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x3e61, LSL #0
    MOVK  X17, #0xc64b, LSL #16
    MOVK  X17, #0x5a8c, LSL #32
    MOVK  X17, #0x8fb0, LSL #48
    SUB  X14, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xf07d, LSL #0
    MOVK  X17, #0xbf60, LSL #16
    MOVK  X17, #0x602e, LSL #32
    MOVK  X17, #0xd9f9, LSL #48
    SUB  X14, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x9cf, LSL #0
    MOVK  X17, #0xa19, LSL #16
    MOVK  X17, #0x7882, LSL #32
    MOVK  X17, #0x7075, LSL #48
    SUB  X14, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x3b57, LSL #0
    MOVK  X17, #0x8f3b, LSL #16
    MOVK  X17, #0xf86c, LSL #32
    MOVK  X17, #0x57c2, LSL #48
    SUB  X14, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xff67, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0x921, LSL #32
    MOVK  X17, #0x55a8, LSL #48
    SUB  X14, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xca56, LSL #0
    MOVK  X17, #0xc0d8, LSL #16
    MOVK  X17, #0xbd76, LSL #32
    MOVK  X17, #0xd120, LSL #48
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MRS  X14, FPSR
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, V0.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, D0
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, V1.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, D1
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, V2.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, D2
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x4aa0, LSL #0
    MOVK  X17, #0x2ee0, LSL #16
    MOVK  X17, #0xe1f1, LSL #32
    MOVK  X17, #0x6a32, LSL #48
    FMOV  X14, V3.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x84e2, LSL #0
    MOVK  X17, #0x6990, LSL #16
    MOVK  X17, #0x6c1, LSL #32
    MOVK  X17, #0x441a, LSL #48
    FMOV  X14, D3
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xbffe, LSL #0
    MOVK  X17, #0xe526, LSL #16
    MOVK  X17, #0xe08d, LSL #32
    MOVK  X17, #0x5141, LSL #48
    FMOV  X14, V4.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xcb56, LSL #0
    MOVK  X17, #0x759f, LSL #16
    MOVK  X17, #0x6d4c, LSL #32
    MOVK  X17, #0x75d9, LSL #48
    FMOV  X14, D4
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, V5.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, D5
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, V6.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, D6
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, V7.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, D7
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, V8.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, D8
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, V9.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x2000, LSL #0
    MOVK  X17, #0x2000, LSL #32
    FMOV  X14, D9
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, V10.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xff67, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0x921, LSL #32
    MOVK  X17, #0x55a8, LSL #48
    FMOV  X14, D10
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xd7c9, LSL #0
    MOVK  X17, #0x3223, LSL #16
    MOVK  X17, #0xe4ca, LSL #32
    MOVK  X17, #0xcc85, LSL #48
    FMOV  X14, V11.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xca56, LSL #0
    MOVK  X17, #0xc0d8, LSL #16
    MOVK  X17, #0xbd76, LSL #32
    MOVK  X17, #0xd120, LSL #48
    FMOV  X14, D11
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, V12.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xf00, LSL #0
    MOVK  X17, #0x300, LSL #16
    MOVK  X17, #0x900, LSL #32
    MOVK  X17, #0x500, LSL #48
    FMOV  X14, D12
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, V13.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x6401, LSL #0
    MOVK  X17, #0x6401, LSL #16
    MOVK  X17, #0x6401, LSL #32
    MOVK  X17, #0x6401, LSL #48
    FMOV  X14, D13
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, V14.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, D14
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x931, LSL #32
    MOVK  X17, #0x55a8, LSL #48
    FMOV  X14, V15.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x101, LSL #0
    MOVK  X17, #0x101, LSL #16
    MOVK  X17, #0x101, LSL #32
    MOVK  X17, #0x101, LSL #48
    FMOV  X14, D15
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    FMOV  X14, V16.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, D16
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, V17.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, D17
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, V18.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, D18
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xff67, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0x921, LSL #32
    MOVK  X17, #0x55a8, LSL #48
    FMOV  X14, V19.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x101, LSL #0
    MOVK  X17, #0x101, LSL #16
    MOVK  X17, #0x101, LSL #32
    MOVK  X17, #0x101, LSL #48
    FMOV  X14, D19
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, V20.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x20, LSL #0
    MOVK  X17, #0x20, LSL #32
    MOVK  X17, #0x9a00, LSL #48
    FMOV  X14, D20
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, V21.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x9b00, LSL #48
    FMOV  X14, D21
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, V22.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xbfc0, LSL #32
    MOVK  X17, #0xbfc0, LSL #48
    FMOV  X14, D22
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x84e2, LSL #0
    MOVK  X17, #0x6990, LSL #16
    MOVK  X17, #0x6c1, LSL #32
    MOVK  X17, #0x441a, LSL #48
    FMOV  X14, V23.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x3b57, LSL #0
    MOVK  X17, #0x8f3b, LSL #16
    MOVK  X17, #0xf86c, LSL #32
    MOVK  X17, #0x57c2, LSL #48
    FMOV  X14, D23
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, V24.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, D24
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, V25.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x155, LSL #0
    MOVK  X17, #0x101, LSL #16
    MOVK  X17, #0x101, LSL #32
    MOVK  X17, #0x101, LSL #48
    FMOV  X14, D25
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, V26.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x8, LSL #0
    FMOV  X14, D26
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, V27.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, D27
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x98, LSL #0
    MOVK  X17, #0xf6de, LSL #32
    MOVK  X17, #0xaa57, LSL #48
    FMOV  X14, V28.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X14, D28
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, V29.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, D29
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xc000, LSL #0
    MOVK  X17, #0xc0, LSL #16
    FMOV  X14, V30.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, D30
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, V31.D[1]
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X14, D31
    SUB  X24, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    FMOV  D0, X6
    FMOV  V0.D[1], X21
    FMOV  D1, X10
    FMOV  V1.D[1], X28
    FMOV  D2, X11
    FMOV  V2.D[1], X20
    FMOV  D3, X5
    FMOV  V3.D[1], X15
    FMOV  D4, X25
    FMOV  V4.D[1], X24
    FMOV  D5, X27
    FMOV  V5.D[1], X26
    FMOV  D6, X23
    FMOV  V6.D[1], X28
    FMOV  D7, X23
    FMOV  V7.D[1], X27
    FMOV  D8, X24
    FMOV  V8.D[1], X16
    FMOV  D9, X27
    FMOV  V9.D[1], X18
    FMOV  D10, X5
    FMOV  V10.D[1], X2
    FMOV  D11, X11
    FMOV  V11.D[1], X19
    FMOV  D12, X9
    FMOV  V12.D[1], X23
    FMOV  D13, X17
    FMOV  V13.D[1], X11
    FMOV  D14, X20
    FMOV  V14.D[1], X4
    FMOV  D15, X10
    FMOV  V15.D[1], X15
    FMOV  D16, X26
    FMOV  V16.D[1], X9
    FMOV  D17, X16
    FMOV  V17.D[1], X13
    FMOV  D18, X11
    FMOV  V18.D[1], X24
    FMOV  D19, X26
    FMOV  V19.D[1], X21
    FMOV  D20, X21
    FMOV  V20.D[1], X2
    FMOV  D21, X13
    FMOV  V21.D[1], X14
    FMOV  D22, X4
    FMOV  V22.D[1], X23
    FMOV  D23, X24
    FMOV  V23.D[1], X14
    FMOV  D24, X28
    FMOV  V24.D[1], X9
    FMOV  D25, X14
    FMOV  V25.D[1], X27
    FMOV  D26, X19
    FMOV  V26.D[1], X23
    FMOV  D27, X28
    FMOV  V27.D[1], X9
    FMOV  D28, X24
    FMOV  V28.D[1], X20
    FMOV  D29, X18
    FMOV  V29.D[1], X5
    FMOV  D30, X28
    FMOV  V30.D[1], X11
    FMOV  D31, X4
    FMOV  V31.D[1], X6
    MOVZ  X2, #0xf, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_7:
    MOV D13, V21.D[0x1]
    CLZ  V25.2S, V13.2S
    MOV V17.D[0x1], V29.D[0x1]
    MVNI  V30.8H, #0x7c
    XTN2  V8.4S, V19.2D
    DUP V30.16B, W28
    SHL  V24.16B, V8.16B, #0x3
    MLA  V8.2S, V24.2S, V27.2S
    SUBHN  V1.4H, V31.4S, V22.4S
    AESIMC  V2.16B, V1.16B
    INS V7.S[0x1], V8.S[0x2]
    TBX  V9.8B, { V14.16B, V15.16B, V16.16B }, V30.8B
    DUP B20, V28.B[0x5]
    ADDV  S21, V9.4S
    SHRN2 V28.16B, V21.8H, #8
    AESE  V21.16B, V17.16B
    SHL  V19.8B, V20.8B, #0x5
    ADD  V13.2D, V2.2D, V28.2D
    SLI  V14.16B, V7.16B, #0x6
    SUBHN2  V7.8H, V14.4S, V21.4S
    TRN1  V1.16B, V19.16B, V13.16B
    TBL  V2.16B, { V26.16B, V27.16B, V28.16B }, V1.16B
    RSHRN2 V27.4S, V2.2D, #23
    DUP  V17.2S, V7.S[0x2]
    MOV D9, V17.D[0x1]
    SHLL2  V15.2D, V27.4S, #32
    SRI  V29.2S, V15.2S, #20
    CLS  V27.8H, V29.8H
    SRI  V2.2S, V25.2S, #20
    DUP V30.2D, V9.D[0x1]
    PMULL2  V15.8H, V27.16B, V30.16B
    AESMC  V20.16B, V15.16B
    DUP B17, V2.B[0x8]
    SUBHN  V15.4H, V17.4S, V20.4S
    MOV V1.S[0x1], V6.S[0x0]
    MOV  V13.16B, V25.16B
    MLA  V21.4S, V1.4S, V16.S[0x2]
    BIC  V25.4S, #0xc4
    RSHRN V7.2S, V26.2D, #19
    MVNI  V28.2S, #0xb
    ADDV  H17, V7.4H
    DUP H6, V24.H[0x5]
    AND  V9.16B, V10.16B, V18.16B
    INS V18.S[0x1], V17.S[0x3]
    BIC  V26.4S, #0xd, LSL #8
    DUP H20, V25.H[0x1]
    MOV V2.B[0xd], W2
    SHL V19.2D, V14.2D, #0x2f
    AESIMC  V29.16B, V13.16B
    DUP D25, V29.D[0x1]
    MOV V17.H[0x5], V13.H[0x4]
    SHRN V7.2S, V6.2D, #5
    ORR  V1.2S, #0x68, LSL #16
    SHL V24.2D, V11.2D, #0x26
    MLA  V6.4S, V7.4S, V25.S[0x1]
    ADDHN2  V13.16B, V26.8H, V18.8H
    DUP  V10.2S, V21.S[0x0]
    INS V26.S[0x0], V13.S[0x1]
    TBL  V30.8B, { V13.16B, V14.16B, V15.16B, V16.16B }, V9.8B
    MOV V16.D[0x0], V19.D[0x1]
    INS V9.S[0x2], V1.S[0x3]
    SHRN V25.4H, V26.4S, #1
    ORR  V29.16B, V25.16B, V16.16B
    DUP V25.2D, X26
    MOV  V19.8B, V30.8B
    TBL  V2.16B, { V3.16B, V4.16B, V5.16B }, V6.16B
    DUP  V16.16B, V25.B[0x1]
    SHL  V25.8H, V24.8H, #0x0
    MOV V26.B[0x6], W9
    MOV  X5, V25.D[0x1]
    SRI  V3.4S, V9.4S, #26
    DUP V30.2D, X19
    INS V24.B[0xb], W14
    BIC  V7.8H, #0x45
    ADDP  V6.4H, V29.4H, V3.4H
    PMUL  V29.16B, V2.16B, V10.16B
    AESMC  V3.16B, V16.16B
    BSL  V1.8B, V17.8B, V17.8B
    UZP1  V9.4H, V19.4H, V6.4H
    ADD  V10.8H, V7.8H, V9.8H
    MVNI  V15.2S, #0x3b
    XTN2  V7.8H, V15.4S
    BIC  V6.4S, #0x83
    MLA  V5.4S, V26.4S, V6.4S
    RSHRN V2.8B, V5.8H, #5
    AESIMC  V25.16B, V2.16B
    MOVI  V6.2S, #0xff, LSL #24
    TBL  V2.16B, { V27.16B, V28.16B }, V6.16B
    TRN2  V28.16B, V2.16B, V15.16B
    RSHRN2 V27.8H, V28.4S, #8
    DUP  V5.8H, V27.H[0x3]
    EOR  V6.16B, V30.16B, V25.16B
    DUP B19, V10.B[0x7]
    DUP  V10.16B, V7.B[0x9]
    MLA  V25.8B, V10.8B, V1.8B
    SRI  V10.16B, V3.16B, #2
    BIC  V26.8H, #0x78
    SRI V9.2D, V19.2D, #12
    SRI  V3.4S, V26.4S, #28
    UZP2  V26.2D, V5.2D, V5.2D
    MOV V28.S[0x2], V26.S[0x3]
    DUP  V2.16B, V28.B[0x1]
    MOV  X7, V2.D[0x0]
    PMULL2  V15.8H, V3.16B, V9.16B
    SHLL  V3.8H, V10.8B, #8
    INS V17.H[0x7], W21
    ADDP  V19.8B, V17.8B, V29.8B
    SUBHN2  V27.4S, V19.2D, V3.2D
    PMULL  V5.1Q, V25.1D, V27.1D
    TBX  V26.16B, { V5.16B, V6.16B }, V5.16B
    TBX  V7.16B, { V10.16B, V11.16B, V12.16B, V13.16B }, V26.16B
    DUP V30.2D, X16
    RSHRN2 V1.4S, V15.2D, #14
    DUP B11, V1.B[0x8]
    MOV D27, V7.D[0x0]
    MUL  V9.8B, V30.8B, V23.8B
    AND  V2.8B, V27.8B, V9.8B
    AND  V9.16B, V2.16B, V11.16B
    ADDP  V28.2D, V4.2D, V4.2D
    MOVI  V30.2D, #18446462598749552895
    MOV V17.B[0x7], W20
    RSHRN V29.8B, V14.8H, #2
    TBL  V3.16B, { V19.16B, V20.16B }, V14.16B
    SLI  V12.2S, V28.2S, #0x8
    ORR  V15.8H, #0x48
    MVNI  V19.2S, #0x89, LSL #16
    NOT  V10.8B, V10.8B
    ADDV  H20, V10.8H
    MLS  V5.2S, V9.2S, V29.S[0x3]
    MOV D1, V5.D[0x0]
    EXT  V27.8B, V1.8B, V12.8B, #0x4
    ADDHN2  V23.8H, V15.4S, V17.4S
    ADDV  B17, V19.16B
    MOV V14.B[0x0], W14
    MOV  W19, V27.S[0x3]
    TBL  V4.16B, { V30.16B }, V3.16B
    INS V15.H[0x6], W16
    UZP1  V3.8H, V17.8H, V14.8H
    AESD  V28.16B, V23.16B
    MLA  V30.16B, V28.16B, V20.16B
    EXT  V19.16B, V3.16B, V3.16B, #0x7
    SHL  V14.8H, V19.8H, #0x1
    INS V19.D[0x1], V24.D[0x0]
    BIC  V17.4S, #0x72, LSL #16
    AESMC  V10.16B, V19.16B
    MOVI  V1.2D, #18446742974197923840
    TBX  V2.16B, { V4.16B, V5.16B, V6.16B }, V14.16B
    REV16  V11.8B, V15.8B
    MOVI  V27.4H, #0x1e
    TBX  V3.8B, { V14.16B, V15.16B, V16.16B, V17.16B }, V11.8B
    ADDHN  V19.2S, V30.2D, V10.2D
    SRI  V23.4H, V1.4H, #16
    TBL  V9.8B, { V23.16B }, V19.8B
    ADDP  D4, V9.2D
    MOVI  V9.4H, #0xd6, LSL #8
    EOR  V24.16B, V9.16B, V7.16B
    INS V1.B[0x5], W8
    RSHRN V20.8B, V2.8H, #8
    AESMC  V6.16B, V1.16B
    ADDP  D5, V27.2D
    BIT  V2.8B, V4.8B, V5.8B
    ABS  V27.4S, V3.4S
    INS V30.D[0x0], V27.D[0x0]
    MOVI  V27.2S, #0x17, MSL #16
    SLI  V28.8B, V24.8B, #0x2
    MVNI  V1.2S, #0xb9, LSL #8
    ADDP  V24.4S, V30.4S, V2.4S
    MOV  W17, V6.S[0x0]
    CLZ  V6.8H, V20.8H
    XTN  V10.2S, V27.2D
    ORR  V23.4S, #0xf8, LSL #24
    DUP D9, V24.D[0x1]
    MOVI  V19.4S, #0x93, LSL #24
    RSHRN V5.8B, V19.8H, #8
    DUP V4.2D, V28.D[0x0]
    SHRN2 V20.4S, V4.2D, #11
    DUP V3.4H, W2
    SHRN V24.8B, V5.8H, #4
    ORR  V2.2S, #0xe, LSL #8
    MOV S27, V9.S[0x0]
    MLS  V19.2S, V20.2S, V20.S[0x3]
    SHL V5.2D, V23.2D, #0x1c
    MOV V20.B[0x0], V1.B[0x2]
    ABS  V30.2S, V10.2S
    MOVI  V28.2D, #72057594037862655
    MUL  V4.8H, V9.8H, V13.H[0x0]
    UZP1  V10.8B, V27.8B, V27.8B
    MOV H6, V6.H[0x3]
    RSUBHN2  V26.8H, V2.4S, V5.4S
    PMUL  V23.16B, V13.16B, V26.16B
    SUBHN2  V5.8H, V8.4S, V3.4S
    INS V9.B[0xc], V28.B[0x0]
    XTN2  V13.4S, V4.2D
    SHLL  V4.8H, V9.8B, #8
    SHRN2 V18.16B, V24.8H, #6
    INS V3.D[0x0], X20
    DUP V8.4H, W6
    SLI  V2.4S, V1.4S, #0x15
    MUL  V28.4S, V20.4S, V30.4S
    UZP1  V26.4H, V2.4H, V19.4H
    SUBS  X2, X2, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_7
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X25, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MRS  X25, FPSR
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, V0.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, D0
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, V1.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x46ff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0x46ff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X25, D1
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, V2.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0xe00, LSL #0
    MOVK  X15, #0xdfe0, LSL #16
    MOVK  X15, #0xe00, LSL #32
    MOVK  X15, #0xdfe0, LSL #48
    FMOV  X25, D2
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, V3.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, D3
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, V4.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, D4
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0xfffe, LSL #0
    MOVK  X15, #0xfffe, LSL #16
    FMOV  X25, V5.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xf000, LSL #16
    MOVK  X15, #0xff80, LSL #48
    FMOV  X25, D5
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, V6.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x10, LSL #0
    FMOV  X25, D6
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0xc0c0, LSL #0
    MOVK  X15, #0xff00, LSL #16
    FMOV  X25, V7.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0xc0c0, LSL #0
    MOVK  X15, #0xc0c0, LSL #16
    MOVK  X15, #0xc0c0, LSL #32
    MOVK  X15, #0xc0c0, LSL #48
    FMOV  X25, D7
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, V8.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, D8
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xff, LSL #32
    FMOV  X25, V9.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, D9
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, V10.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, D10
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, V11.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x4800, LSL #0
    MOVK  X15, #0x4800, LSL #16
    MOVK  X15, #0x4800, LSL #32
    MOVK  X15, #0x4800, LSL #48
    FMOV  X25, D11
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, V12.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, D12
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, V13.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x1, LSL #0
    MOVK  X15, #0x1, LSL #32
    FMOV  X25, D13
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0xcc00, LSL #0
    FMOV  X25, V14.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x18, LSL #48
    FMOV  X25, D14
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x48, LSL #0
    MOVK  X15, #0x48, LSL #16
    MOVK  X15, #0x48, LSL #48
    FMOV  X25, V15.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x48, LSL #0
    MOVK  X15, #0x48, LSL #16
    MOVK  X15, #0x48, LSL #32
    MOVK  X15, #0x48, LSL #48
    FMOV  X25, D15
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, V16.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, D16
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, V17.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0xe6, LSL #0
    FMOV  X25, D17
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0xc0c0, LSL #0
    FMOV  X25, V18.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, D18
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, V19.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x9300, LSL #16
    MOVK  X15, #0x9300, LSL #48
    FMOV  X25, D19
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x400b, LSL #0
    MOVK  X15, #0x406b, LSL #16
    MOVK  X15, #0x400b, LSL #32
    MOVK  X15, #0x406b, LSL #48
    FMOV  X25, V20.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0xff, LSL #0
    FMOV  X25, D20
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x6363, LSL #0
    MOVK  X15, #0x6363, LSL #16
    MOVK  X15, #0x6363, LSL #32
    MOVK  X15, #0x6363, LSL #48
    FMOV  X25, V21.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x638e, LSL #0
    MOVK  X15, #0x6363, LSL #16
    MOVK  X15, #0x6363, LSL #32
    MOVK  X15, #0x6363, LSL #48
    FMOV  X25, D21
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, V22.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, D22
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0xe000, LSL #0
    FMOV  X25, V23.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0xf, LSL #0
    MOVK  X15, #0xf, LSL #32
    FMOV  X25, D23
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, V24.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x3030, LSL #0
    MOVK  X15, #0x3030, LSL #16
    FMOV  X25, D24
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, V25.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0xf9a1, LSL #0
    MOVK  X15, #0x2ef9, LSL #16
    FMOV  X25, D25
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, V26.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0xe00, LSL #0
    MOVK  X15, #0xe00, LSL #16
    FMOV  X25, D26
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, V27.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, D27
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, V28.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0xff01, LSL #0
    MOVK  X15, #0x17e7, LSL #16
    FMOV  X25, D28
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, V29.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x600, LSL #16
    FMOV  X25, D29
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, V30.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0x17, LSL #16
    FMOV  X25, D30
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, V31.D[1]
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X25, D31
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
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
    FMOV  D0, X28
    FMOV  V0.D[1], X27
    FMOV  D1, X24
    FMOV  V1.D[1], X25
    FMOV  D2, X21
    FMOV  V2.D[1], X26
    FMOV  D3, X28
    FMOV  V3.D[1], X21
    FMOV  D4, X2
    FMOV  V4.D[1], X13
    FMOV  D5, X14
    FMOV  V5.D[1], X26
    FMOV  D6, X25
    FMOV  V6.D[1], X13
    FMOV  D7, X28
    FMOV  V7.D[1], X8
    FMOV  D8, X15
    FMOV  V8.D[1], X7
    FMOV  D9, X27
    FMOV  V9.D[1], X19
    FMOV  D10, X15
    FMOV  V10.D[1], X4
    FMOV  D11, X11
    FMOV  V11.D[1], X4
    FMOV  D12, X16
    FMOV  V12.D[1], X11
    FMOV  D13, X2
    FMOV  V13.D[1], X28
    FMOV  D14, X11
    FMOV  V14.D[1], X6
    FMOV  D15, X27
    FMOV  V15.D[1], X4
    FMOV  D16, X8
    FMOV  V16.D[1], X13
    FMOV  D17, X4
    FMOV  V17.D[1], X23
    FMOV  D18, X15
    FMOV  V18.D[1], X16
    FMOV  D19, X8
    FMOV  V19.D[1], X2
    FMOV  D20, X17
    FMOV  V20.D[1], X19
    FMOV  D21, X13
    FMOV  V21.D[1], X19
    FMOV  D22, X14
    FMOV  V22.D[1], X7
    FMOV  D23, X11
    FMOV  V23.D[1], X16
    FMOV  D24, X11
    FMOV  V24.D[1], X23
    FMOV  D25, X6
    FMOV  V25.D[1], X16
    FMOV  D26, X19
    FMOV  V26.D[1], X27
    FMOV  D27, X13
    FMOV  V27.D[1], X23
    FMOV  D28, X10
    FMOV  V28.D[1], X11
    FMOV  D29, X24
    FMOV  V29.D[1], X18
    FMOV  D30, X14
    FMOV  V30.D[1], X2
    FMOV  D31, X25
    FMOV  V31.D[1], X10
    MOVZ  X5, #0xf, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_8:
    SHRN2 V14.4S, V29.2D, #1
    MOV V24.S[0x3], W9
    PMUL  V17.16B, V30.16B, V28.16B
    CLZ  V8.16B, V14.16B
    MVN  V4.16B, V27.16B
    MOV V30.B[0x7], V31.B[0x6]
    DUP  V19.8B, V25.B[0xb]
    CLZ  V13.2S, V8.2S
    MOV V14.D[0x0], V19.D[0x1]
    RSHRN2 V11.4S, V23.2D, #27
    ADDV  S23, V11.4S
    DUP  V20.8B, V14.B[0x5]
    SUBHN2  V0.8H, V17.4S, V26.4S
    RSHRN2 V6.4S, V3.2D, #14
    REV64  V12.8H, V23.8H
    BIC  V16.2S, #0xcd
    ADDP  V4.8H, V4.8H, V12.8H
    AESD  V30.16B, V6.16B
    RSHRN V29.8B, V0.8H, #3
    DUP V27.4H, W6
    MOV V28.S[0x1], W14
    SHRN2 V17.8H, V24.4S, #1
    SUBHN2  V18.16B, V4.8H, V17.8H
    DUP V12.4S, W13
    MOV V3.H[0x5], W28
    SHRN V23.2S, V16.2D, #7
    MOV  W6, V3.S[0x0]
    RSHRN V6.4H, V30.4S, #6
    SHLL2  V11.4S, V20.8H, #16
    ADDHN2  V17.16B, V12.8H, V27.8H
    DUP V16.8H, W7
    INS V24.S[0x2], W14
    SHRN V30.4H, V29.4S, #4
    DUP  V0.4S, V23.S[0x1]
    MOVI  V23.2D, #18446742978476114175
    RSUBHN2  V3.4S, V18.2D, V6.2D
    XTN2  V20.4S, V0.2D
    ADD  V12.2D, V16.2D, V13.2D
    BIC  V29.8B, V12.8B, V30.8B
    ORN  V12.8B, V11.8B, V11.8B
    MOVI  V27.2S, #0xdc, MSL #16
    TBL  V6.16B, { V4.16B, V5.16B }, V17.16B
    EOR  V11.8B, V3.8B, V12.8B
    AESMC  V4.16B, V23.16B
    SHRN V30.4H, V27.4S, #1
    MLS  V17.8B, V6.8B, V20.8B
    ZIP1  V5.2D, V29.2D, V4.2D
    SHLL  V12.8H, V30.8B, #8
    RSUBHN2  V3.8H, V17.4S, V5.4S
    ADDP  V30.8B, V11.8B, V12.8B
    MOV V13.D[0x1], X13
    MLA  V16.2S, V30.2S, V30.S[0x0]
    AND  V18.8B, V24.8B, V3.8B
    MOVI  V30.2D, #281470681743360
    DUP  V3.8B, V22.B[0xd]
    ADDP  V23.4S, V30.4S, V13.4S
    SLI V27.2D, V23.2D, #0xb
    MOV V17.H[0x7], V3.H[0x0]
    AESE  V24.16B, V17.16B
    RSUBHN  V22.4H, V24.4S, V18.4S
    MOVI  V5.8H, #0xd3
    AND  V11.16B, V5.16B, V16.16B
    DUP  V20.8B, V27.B[0x2]
    DUP  V13.4S, V20.S[0x3]
    BIC  V18.4H, #0x9c, LSL #8
    ADDV  B12, V18.8B
    RSUBHN2  V4.4S, V11.2D, V11.2D
    MOVI  V11.8H, #0x89, LSL #8
    MUL  V24.4H, V4.4H, V4.4H
    AESMC  V23.16B, V11.16B
    MVNI  V3.4S, #0x10, LSL #8
    TBX  V17.16B, { V23.16B, V24.16B }, V24.16B
    ORR  V20.4S, #0x6f, LSL #24
    SHRN V29.4H, V17.4S, #8
    NEG  V16.16B, V3.16B
    MOV V18.H[0x4], V22.H[0x6]
    XTN2  V27.16B, V13.8H
    MUL  V23.8H, V27.8H, V11.H[0x7]
    UZP1  V4.4S, V23.4S, V23.4S
    UZP1  V24.2S, V21.2S, V16.2S
    EOR  V17.16B, V20.16B, V18.16B
    DUP  V22.16B, V29.B[0x2]
    DUP V21.8H, W9
    SUBHN2  V5.4S, V4.2D, V4.2D
    XTN  V3.2S, V21.2D
    INS V21.B[0xc], W8
    EXT  V4.8B, V3.8B, V21.8B, #0x3
    MVNI  V23.2S, #0x16, MSL #16
    ZIP2  V27.16B, V24.16B, V23.16B
    SHL V16.2D, V12.2D, #0x1c
    DUP  V18.16B, V16.B[0xb]
    MVNI  V23.2S, #0x66, LSL #24
    MOV V20.B[0x5], V22.B[0xa]
    SRI  V13.4S, V17.4S, #13
    ZIP1  V21.2S, V5.2S, V23.2S
    EOR  V23.8B, V20.8B, V15.8B
    INS V20.D[0x0], V4.D[0x1]
    MVNI  V11.4S, #0xff, LSL #8
    INS V5.D[0x1], V18.D[0x1]
    MLS  V18.16B, V5.16B, V5.16B
    MLS  V17.8B, V30.8B, V7.8B
    MOV V15.H[0x2], W8
    DUP  V5.4H, V11.H[0x2]
    MOVI  V4.4S, #0x42
    TBL  V29.16B, { V16.16B, V17.16B }, V27.16B
    MOV V24.S[0x3], V21.S[0x3]
    MLA  V22.4H, V13.4H, V13.H[0x4]
    TBX  V13.8B, { V22.16B, V23.16B, V24.16B }, V18.8B
    MOV V18.S[0x1], W19
    MOV D23, V18.D[0x0]
    XTN  V12.2S, V20.2D
    MOV V11.D[0x0], V15.D[0x1]
    ADDP  D3, V13.2D
    ZIP2  V13.4H, V5.4H, V6.4H
    TRN2  V5.2S, V11.2S, V3.2S
    REV16  V15.8B, V5.8B
    ADDHN  V5.4H, V29.4S, V13.4S
    ADDV  H18, V5.4H
    BIC  V3.2S, #0xa
    REV32  V29.16B, V9.16B
    SHRN V22.8B, V3.8H, #8
    AESD  V21.16B, V22.16B
    CLS  V13.4H, V18.4H
    RADDHN2  V27.4S, V12.2D, V4.2D
    BIF  V9.16B, V29.16B, V21.16B
    MOV V11.D[0x0], V13.D[0x0]
    ADDP  D29, V23.2D
    DUP V24.2D, V9.D[0x0]
    MVNI  V9.8H, #0xa9
    ADDV  H30, V11.4H
    DUP V20.2D, X18
    MLS  V21.2S, V15.2S, V27.S[0x0]
    SHRN V18.4H, V24.4S, #1
    DUP  V22.2S, V18.S[0x0]
    PMULL2  V11.8H, V22.16B, V9.16B
    BIC  V12.8B, V29.8B, V15.8B
    MOV V23.B[0xe], W10
    ADD  V9.2D, V23.2D, V23.2D
    DUP  V5.4S, V21.S[0x1]
    EXT  V6.16B, V5.16B, V5.16B, #0x8
    DUP V21.8B, W7
    INS V4.H[0x6], W6
    MOV V5.S[0x0], W14
    MOV D23, V4.D[0x0]
    ABS  V13.2D, V11.2D
    MVNI  V22.4S, #0x14, LSL #16
    DUP V27.8B, W25
    TBL  V24.8B, { V20.16B, V21.16B, V22.16B }, V12.8B
    SHRN2 V29.16B, V27.8H, #7
    DUP  V12.4S, V24.S[0x2]
    INS V24.B[0x5], W5
    TBL  V11.8B, { V29.16B, V30.16B, V31.16B, V0.16B }, V23.8B
    RSHRN V21.2S, V11.2D, #4
    SHRN V15.8B, V12.8H, #8
    TBX  V29.8B, { V27.16B, V28.16B, V29.16B, V30.16B }, V9.8B
    AESIMC  V30.16B, V24.16B
    SLI V20.2D, V13.2D, #0x10
    NOT  V23.8B, V30.8B
    TBL  V27.8B, { V7.16B, V8.16B, V9.16B, V10.16B }, V5.8B
    NOT  V4.8B, V21.8B
    REV16  V22.16B, V20.16B
    ADDV  B20, V22.16B
    SLI  V31.8B, V4.8B, #0x3
    REV32  V21.8H, V23.8H
    SHL  V0.4H, V20.4H, #0xe
    PMULL2  V24.1Q, V29.2D, V31.2D
    SUBHN  V27.2S, V24.2D, V6.2D
    SLI  V11.2S, V27.2S, #0x1
    PMULL  V13.1Q, V15.1D, V15.1D
    MOVI  V9.4S, #0xca, MSL #16
    ADDHN2  V5.8H, V9.4S, V0.4S
    SHL  V22.16B, V21.16B, #0x6
    DUP D31, V22.D[0x1]
    BIF  V30.8B, V5.8B, V11.8B
    DUP H27, V30.H[0x4]
    MOV B15, V27.B[0xa]
    CNT  V7.16B, V13.16B
    MOVI  V0.4S, #0x99, MSL #8
    TBX  V29.8B, { V5.16B, V6.16B, V7.16B, V8.16B }, V7.8B
    SRI V24.2D, V26.2D, #44
    SHL V7.2D, V29.2D, #0x1d
    DUP  V4.4S, V15.S[0x3]
    AESE  V20.16B, V31.16B
    MOV V27.D[0x0], X9
    SHRN2 V10.4S, V0.2D, #11
    MOV V31.S[0x2], V10.S[0x3]
    AESE  V22.16B, V24.16B
    MVNI  V0.2S, #0x8, LSL #16
    MOV  X7, V27.D[0x1]
    DUP V23.4S, W17
    INS V31.D[0x0], V23.D[0x0]
    MVN  V30.8B, V0.8B
    SUBHN2  V10.16B, V22.8H, V31.8H
    SHRN2 V5.16B, V7.8H, #6
    ADDP  D26, V10.2D
    SHRN V13.8B, V4.8H, #6
    BIC  V27.8B, V20.8B, V5.8B
    SHLL2  V31.8H, V27.16B, #8
    SLI  V7.4S, V30.4S, #0x16
    SHRN2 V11.4S, V13.2D, #9
    SUBS  X5, X5, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_8
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X11, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x9f5, LSL #0
    MOVK  X4, #0x9ff, LSL #16
    SUB  X11, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X11, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X11, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X11, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X11, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X11, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X11, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X11, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X11, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X11, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X11, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X11, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X11, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X11, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X11, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X11, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X11, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MRS  X11, FPSR
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X11, V0.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xfff7, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xfff7, LSL #48
    FMOV  X11, D0
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X11, V1.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X11, D1
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X11, V2.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X11, D2
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X11, V3.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x9f5, LSL #0
    MOVK  X4, #0x9ff, LSL #16
    MOVK  X4, #0x9f5, LSL #32
    MOVK  X4, #0x9ff, LSL #48
    FMOV  X11, D3
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X11, V4.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X11, D4
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x8000, LSL #0
    MOVK  X4, #0xffff, LSL #16
    FMOV  X11, V5.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0x407d, LSL #32
    MOVK  X4, #0x5252, LSL #48
    FMOV  X11, D5
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x407d, LSL #0
    MOVK  X4, #0x5252, LSL #16
    MOVK  X4, #0x407d, LSL #32
    MOVK  X4, #0x5252, LSL #48
    FMOV  X11, V6.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x407d, LSL #0
    MOVK  X4, #0x5252, LSL #16
    MOVK  X4, #0x407d, LSL #32
    MOVK  X4, #0x5252, LSL #48
    FMOV  X11, D6
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X11, V7.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0x3f, LSL #48
    FMOV  X11, D7
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x808, LSL #32
    MOVK  X4, #0x808, LSL #48
    FMOV  X11, V8.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x808, LSL #0
    MOVK  X4, #0x808, LSL #16
    MOVK  X4, #0x808, LSL #32
    MOVK  X4, #0x808, LSL #48
    FMOV  X11, D8
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xca, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xca, LSL #48
    FMOV  X11, V9.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xca, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xca, LSL #48
    FMOV  X11, D9
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x63ba, LSL #0
    MOVK  X4, #0x963, LSL #16
    MOVK  X4, #0x8d63, LSL #32
    MOVK  X4, #0x63d2, LSL #48
    FMOV  X11, V10.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X11, D10
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X11, V11.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x7f04, LSL #0
    MOVK  X4, #0x5b5b, LSL #16
    MOVK  X4, #0x7f04, LSL #32
    MOVK  X4, #0x5b5b, LSL #48
    FMOV  X11, D11
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X11, V12.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X11, D12
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X11, V13.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X11, D13
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    FMOV  X11, V14.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X11, D14
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X11, V15.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X11, D15
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X11, V16.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7000, LSL #16
    MOVK  X4, #0x2, LSL #32
    FMOV  X11, D16
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X11, V17.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xfedf, LSL #0
    MOVK  X4, #0xfff9, LSL #16
    MOVK  X4, #0xfefe, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X11, D17
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X11, V18.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xed3d, LSL #0
    MOVK  X4, #0xe53e, LSL #16
    MOVK  X4, #0xed3d, LSL #32
    MOVK  X4, #0xe53e, LSL #48
    FMOV  X11, D18
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X11, V19.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X11, D19
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x6363, LSL #0
    MOVK  X4, #0x6363, LSL #16
    MOVK  X4, #0x6363, LSL #32
    MOVK  X4, #0x6363, LSL #48
    FMOV  X11, V20.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x63b0, LSL #0
    MOVK  X4, #0x6363, LSL #16
    MOVK  X4, #0x6363, LSL #32
    MOVK  X4, #0x6363, LSL #48
    FMOV  X11, D20
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X11, V21.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xe51a, LSL #0
    MOVK  X4, #0xe51a, LSL #16
    MOVK  X4, #0x7f55, LSL #32
    MOVK  X4, #0x66b2, LSL #48
    FMOV  X11, D21
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x6363, LSL #0
    MOVK  X4, #0xcd44, LSL #16
    MOVK  X4, #0xd263, LSL #32
    MOVK  X4, #0x63cd, LSL #48
    FMOV  X11, V22.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xba40, LSL #0
    MOVK  X4, #0x6363, LSL #16
    MOVK  X4, #0x6309, LSL #32
    MOVK  X4, #0x963, LSL #48
    FMOV  X11, D22
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X11, V23.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X11, D23
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X11, V24.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x3ff2, LSL #0
    MOVK  X4, #0x6, LSL #16
    FMOV  X11, D24
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X11, V25.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X11, D25
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X11, V26.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x63b9, LSL #0
    MOVK  X4, #0x963, LSL #16
    MOVK  X4, #0x8d63, LSL #32
    MOVK  X4, #0x63d2, LSL #48
    FMOV  X11, D26
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X11, V27.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x2302, LSL #32
    MOVK  X4, #0x2121, LSL #48
    FMOV  X11, D27
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X11, V28.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X11, D28
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X11, V29.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X11, D29
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X11, V30.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8, LSL #16
    MOVK  X4, #0x8, LSL #48
    FMOV  X11, D30
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X11, V31.D[1]
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X11, D31
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xfd86, LSL #0
    MOVK  X2, #0x5d37, LSL #16
    MOVK  X2, #0xfd6d, LSL #32
    MOVK  X2, #0xc653, LSL #48
    MOVZ  X4, #0x670, LSL #0
    MOVK  X4, #0x7b1f, LSL #16
    MOVK  X4, #0xe1eb, LSL #32
    MOVK  X4, #0x3664, LSL #48
    MOVZ  X5, #0x6457, LSL #0
    MOVK  X5, #0x53e6, LSL #16
    MOVK  X5, #0x4f42, LSL #32
    MOVK  X5, #0x75c4, LSL #48
    MOVZ  X6, #0xb2ab, LSL #0
    MOVK  X6, #0x5799, LSL #16
    MOVK  X6, #0xb3df, LSL #32
    MOVK  X6, #0x8d35, LSL #48
    MOVZ  X7, #0x36e9, LSL #0
    MOVK  X7, #0x2e63, LSL #16
    MOVK  X7, #0x3266, LSL #32
    MOVK  X7, #0x1989, LSL #48
    MOVZ  X8, #0x4ba8, LSL #0
    MOVK  X8, #0x6d15, LSL #16
    MOVK  X8, #0xae86, LSL #32
    MOVK  X8, #0xf572, LSL #48
    MOVZ  X9, #0x5e4e, LSL #0
    MOVK  X9, #0xe152, LSL #16
    MOVK  X9, #0xc77e, LSL #32
    MOVK  X9, #0xdd90, LSL #48
    MOVZ  X10, #0x9e8, LSL #0
    MOVK  X10, #0xfe37, LSL #16
    MOVK  X10, #0xec64, LSL #32
    MOVK  X10, #0xcbf2, LSL #48
    MOVZ  X11, #0xb335, LSL #0
    MOVK  X11, #0x32ac, LSL #16
    MOVK  X11, #0x24a3, LSL #32
    MOVK  X11, #0xe3df, LSL #48
    MOVZ  X13, #0xddcf, LSL #0
    MOVK  X13, #0x92e3, LSL #16
    MOVK  X13, #0x7aea, LSL #32
    MOVK  X13, #0x129, LSL #48
    MOVZ  X14, #0xeee2, LSL #0
    MOVK  X14, #0x40d8, LSL #16
    MOVK  X14, #0x1739, LSL #32
    MOVK  X14, #0x56ff, LSL #48
    MOVZ  X15, #0x2419, LSL #0
    MOVK  X15, #0x9d8a, LSL #16
    MOVK  X15, #0x1f46, LSL #32
    MOVK  X15, #0x24ef, LSL #48
    MOVZ  X16, #0x6f94, LSL #0
    MOVK  X16, #0x3d49, LSL #16
    MOVK  X16, #0x18e2, LSL #32
    MOVK  X16, #0x6d7e, LSL #48
    MOVZ  X17, #0x6663, LSL #0
    MOVK  X17, #0x2109, LSL #16
    MOVK  X17, #0x7d40, LSL #32
    MOVK  X17, #0xcc3e, LSL #48
    MOVZ  X18, #0x59a0, LSL #0
    MOVK  X18, #0x54a8, LSL #16
    MOVK  X18, #0x3311, LSL #32
    MOVK  X18, #0x704, LSL #48
    MOVZ  X19, #0xc9e8, LSL #0
    MOVK  X19, #0x61c8, LSL #16
    MOVK  X19, #0xe407, LSL #32
    MOVK  X19, #0x6210, LSL #48
    MOVZ  X20, #0x6f96, LSL #0
    MOVK  X20, #0x5f6a, LSL #16
    MOVK  X20, #0x1eae, LSL #32
    MOVK  X20, #0xf71a, LSL #48
    MOVZ  X21, #0xc464, LSL #0
    MOVK  X21, #0xf8e0, LSL #16
    MOVK  X21, #0x1a81, LSL #32
    MOVK  X21, #0x9b47, LSL #48
    MOVZ  X23, #0x706d, LSL #0
    MOVK  X23, #0xdc19, LSL #16
    MOVK  X23, #0xfad7, LSL #32
    MOVK  X23, #0xeb25, LSL #48
    MOVZ  X24, #0x60c1, LSL #0
    MOVK  X24, #0xa6d9, LSL #16
    MOVK  X24, #0xf774, LSL #32
    MOVK  X24, #0x22a2, LSL #48
    MOVZ  X25, #0xd7ec, LSL #0
    MOVK  X25, #0x96b9, LSL #16
    MOVK  X25, #0xbe71, LSL #32
    MOVK  X25, #0xb60f, LSL #48
    MOVZ  X26, #0x3ba4, LSL #0
    MOVK  X26, #0x43d, LSL #16
    MOVK  X26, #0x2861, LSL #32
    MOVK  X26, #0x31c5, LSL #48
    MOVZ  X27, #0xfaf3, LSL #0
    MOVK  X27, #0x849b, LSL #16
    MOVK  X27, #0xa156, LSL #32
    MOVK  X27, #0xeee1, LSL #48
    MOVZ  X28, #0x8de0, LSL #0
    MOVK  X28, #0x4d4a, LSL #16
    MOVK  X28, #0xba6, LSL #32
    MOVK  X28, #0x51ea, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X20
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X25
    FMOV  D3, X8
    FMOV  V3.D[1], X17
    FMOV  D4, X24
    FMOV  V4.D[1], X4
    FMOV  D5, X17
    FMOV  V5.D[1], X14
    FMOV  D6, X7
    FMOV  V6.D[1], X20
    FMOV  D7, X4
    FMOV  V7.D[1], X10
    FMOV  D8, X4
    FMOV  V8.D[1], X10
    FMOV  D9, X15
    FMOV  V9.D[1], X10
    FMOV  D10, X9
    FMOV  V10.D[1], X8
    FMOV  D11, X27
    FMOV  V11.D[1], X27
    FMOV  D12, X20
    FMOV  V12.D[1], X19
    FMOV  D13, X14
    FMOV  V13.D[1], X21
    FMOV  D14, X16
    FMOV  V14.D[1], X14
    FMOV  D15, X10
    FMOV  V15.D[1], X2
    FMOV  D16, X18
    FMOV  V16.D[1], X11
    FMOV  D17, X6
    FMOV  V17.D[1], X6
    FMOV  D18, X6
    FMOV  V18.D[1], X4
    FMOV  D19, X15
    FMOV  V19.D[1], X27
    FMOV  D20, X11
    FMOV  V20.D[1], X17
    FMOV  D21, X9
    FMOV  V21.D[1], X15
    FMOV  D22, X9
    FMOV  V22.D[1], X18
    FMOV  D23, X26
    FMOV  V23.D[1], X2
    FMOV  D24, X26
    FMOV  V24.D[1], X6
    FMOV  D25, X11
    FMOV  V25.D[1], X24
    FMOV  D26, X26
    FMOV  V26.D[1], X2
    FMOV  D27, X18
    FMOV  V27.D[1], X16
    FMOV  D28, X19
    FMOV  V28.D[1], X16
    FMOV  D29, X16
    FMOV  V29.D[1], X14
    FMOV  D30, X16
    FMOV  V30.D[1], X19
    FMOV  D31, X27
    FMOV  V31.D[1], X4
    MOVZ  X5, #0xf, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_9:
    DUP V4.2D, X8
    INS V2.D[0x1], X26
    TRN1  V6.8B, V26.8B, V28.8B
    MOV V4.S[0x3], V29.S[0x3]
    BIF  V27.16B, V6.16B, V30.16B
    SRI  V11.16B, V31.16B, #8
    SHLL2  V19.8H, V23.16B, #8
    SHLL2  V10.4S, V11.8H, #16
    SRI V4.2D, V2.2D, #7
    BIC  V23.16B, V27.16B, V10.16B
    ADDHN2  V18.4S, V19.2D, V19.2D
    MOV V29.D[0x1], V18.D[0x1]
    SHL  V0.16B, V29.16B, #0x7
    TBL  V3.8B, { V0.16B }, V23.8B
    AND  V5.16B, V3.16B, V4.16B
    RSHRN V19.2S, V5.2D, #8
    DUP B31, V19.B[0xd]
    SHRN2 V19.8H, V31.4S, #15
    MOVI  V31.16B, #0xb0
    SRI  V5.8B, V19.8B, #7
    MLS  V6.4S, V31.4S, V5.S[0x2]
    ADDV  H10, V30.4H
    SHLL  V4.4S, V9.4H, #16
    DUP B11, V5.B[0xb]
    TRN2  V0.4H, V23.4H, V30.4H
    TBL  V19.8B, { V10.16B, V11.16B, V12.16B }, V2.8B
    SHL  V10.4S, V5.4S, #0x15
    SRI  V5.8H, V13.8H, #8
    RSHRN2 V31.16B, V16.8H, #6
    SHRN2 V29.16B, V19.8H, #8
    RSHRN V19.2S, V24.2D, #17
    MOVI  V24.2S, #0x5d, LSL #8
    ADD  V3.16B, V4.16B, V6.16B
    MUL  V16.8H, V2.8H, V3.H[0x7]
    CLZ  V13.2S, V16.2S
    ORR  V3.8B, V0.8B, V13.8B
    TBL  V30.16B, { V4.16B }, V24.16B
    ORR  V6.4S, #0xb7, LSL #16
    MOV V11.B[0x5], W2
    INS V16.S[0x0], W24
    ADDV  S9, V3.4S
    INS V4.D[0x0], V19.D[0x0]
    SHLL2  V13.8H, V23.16B, #8
    NEG  V3.16B, V4.16B
    MOV V2.D[0x0], X7
    INS V19.H[0x0], W10
    PMULL  V0.8H, V30.8B, V30.8B
    BIF  V23.8B, V10.8B, V10.8B
    MVNI  V4.2S, #0x84, MSL #8
    DUP V10.2D, X26
    MOVI  V12.4S, #0xa7, MSL #8
    ORR  V5.8B, V4.8B, V2.8B
    RSHRN2 V10.8H, V13.4S, #7
    EOR  V4.16B, V3.16B, V6.16B
    BIC  V3.8B, V0.8B, V0.8B
    DUP D0, V10.D[0x1]
    REV16  V9.16B, V0.16B
    RSHRN V5.4H, V23.4S, #11
    TBX  V15.8B, { V8.16B, V9.16B, V10.16B, V11.16B }, V19.8B
    MOV V3.H[0x5], V16.H[0x4]
    EXT  V31.16B, V12.16B, V15.16B, #0x6
    SHRN V13.8B, V4.8H, #6
    MLA  V6.4S, V3.4S, V3.S[0x0]
    INS V4.S[0x1], W11
    SHRN V8.2S, V5.2D, #14
    SRI  V19.4H, V4.4H, #14
    ORR  V30.4H, #0x7, LSL #8
    SHRN V9.4H, V6.4S, #12
    MOV V0.S[0x1], W16
    ABS  V16.4S, V30.4S
    SHRN2 V2.4S, V13.2D, #18
    DUP V23.2D, V31.D[0x1]
    AESE  V3.16B, V0.16B
    AND  V11.8B, V9.8B, V2.8B
    ABS  V6.4H, V19.4H
    MOV  W17, V16.S[0x3]
    TRN1  V10.8H, V6.8H, V6.8H
    EOR  V0.8B, V11.8B, V8.8B
    RSHRN2 V31.16B, V23.8H, #8
    SHRN V15.8B, V3.8H, #8
    MOV V11.B[0xd], V15.B[0x8]
    INS V12.D[0x0], X14
    ADDP  D16, V12.2D
    INS V19.D[0x1], X26
    SUBHN2  V15.4S, V11.2D, V10.2D
    DUP V5.8H, W10
    RSUBHN  V30.8B, V5.8H, V5.8H
    TBL  V9.16B, { V30.16B, V31.16B, V0.16B }, V30.16B
    BSL  V8.8B, V15.8B, V9.8B
    REV32  V15.16B, V16.16B
    MLA  V31.4H, V8.4H, V15.4H
    SUB  V9.16B, V31.16B, V31.16B
    MOV H6, V31.H[0x1]
    SHLL2  V3.4S, V19.8H, #16
    SHRN V16.2S, V9.2D, #22
    SHRN2 V31.8H, V16.4S, #14
    ADDHN2  V0.4S, V3.2D, V31.2D
    SHLL2  V23.8H, V6.16B, #8
    ADDP  D5, V23.2D
    SRI  V8.16B, V0.16B, #6
    MUL  V12.8H, V8.8H, V5.H[0x2]
    RSHRN V15.2S, V8.2D, #12
    MOVI  V23.8H, #0x27, LSL #8
    DUP  V30.16B, V5.B[0xb]
    SHRN V10.8B, V19.8H, #8
    BIC  V19.4S, #0xea
    RADDHN  V5.8B, V14.8H, V28.8H
    INS V11.H[0x3], V2.H[0x3]
    MOV V6.H[0x2], W15
    RBIT  V9.16B, V10.16B
    MOV H31, V12.H[0x3]
    SLI  V16.8H, V9.8H, #0xc
    DUP  V10.8B, V31.B[0xe]
    MOVI  V12.2S, #0x3
    TBL  V19.16B, { V1.16B, V2.16B, V3.16B, V4.16B }, V19.16B
    REV32  V28.4H, V3.4H
    AESE  V14.16B, V12.16B
    SRI  V9.4H, V5.4H, #9
    BIC  V0.2S, #0xa8, LSL #8
    DUP V8.2S, W20
    RSHRN2 V5.4S, V28.2D, #31
    MOV V3.S[0x2], W20
    DUP V28.8B, W13
    DUP H31, V30.H[0x6]
    NOT  V2.16B, V6.16B
    DUP V4.16B, W15
    DUP V1.8B, W15
    MLA  V6.4H, V4.4H, V0.H[0x5]
    MVNI  V30.2S, #0xf2, LSL #8
    DUP V12.4H, W4
    MVNI  V26.8H, #0x8, LSL #8
    TBL  V21.8B, { V2.16B, V3.16B }, V8.8B
    SRI  V0.8H, V14.8H, #10
    MUL  V21.8H, V31.8H, V5.H[0x0]
    MOV V9.H[0x0], V30.H[0x4]
    MLA  V16.4H, V0.4H, V12.H[0x2]
    DUP  V12.16B, V6.B[0xd]
    AND  V28.8B, V9.8B, V12.8B
    MOV V31.B[0x3], W19
    INS V23.S[0x0], W24
    SUBHN2  V24.8H, V23.4S, V26.4S
    SHL  V18.8B, V19.8B, #0x1
    TBX  V30.8B, { V18.16B }, V16.8B
    ADDV  B18, V1.16B
    EXT  V14.16B, V21.16B, V9.16B, #0x5
    INS V4.S[0x0], W16
    MOV V23.B[0xf], W14
    TRN1  V12.2D, V24.2D, V23.2D
    BIC  V6.8H, #0x3e, LSL #8
    CLZ  V8.2S, V12.2S
    MOV V16.H[0x1], V4.H[0x6]
    RBIT  V19.16B, V10.16B
    SRI  V24.4S, V28.4S, #30
    SHL  V0.2S, V8.2S, #0x1d
    RSHRN2 V12.16B, V16.8H, #5
    DUP B4, V14.B[0xa]
    RSHRN2 V1.4S, V18.2D, #23
    RSUBHN  V26.8B, V0.8H, V6.8H
    MOV V9.B[0x3], V1.B[0xd]
    RSHRN V21.4H, V30.4S, #10
    REV16  V5.8B, V24.8B
    INS V18.B[0x2], W14
    ADD  V24.4H, V31.4H, V5.4H
    SHL  V23.8B, V19.8B, #0x3
    DUP V5.2D, V12.D[0x0]
    RADDHN2  V16.16B, V20.8H, V4.8H
    BIC  V30.2S, #0x65, LSL #16
    RADDHN2  V12.4S, V30.2D, V30.2D
    SHRN V9.4H, V18.4S, #9
    BIT  V31.16B, V26.16B, V26.16B
    AESE  V26.16B, V12.16B
    PMULL  V12.8H, V9.8B, V23.8B
    MOV V1.H[0x7], W11
    SHLL  V30.8H, V1.8B, #8
    NOT  V23.8B, V21.8B
    TRN2  V6.4S, V31.4S, V26.4S
    SHRN2 V8.16B, V29.8H, #5
    ADDHN  V19.8B, V8.8H, V12.8H
    ZIP1  V29.8H, V16.8H, V31.8H
    TRN2  V21.8B, V30.8B, V29.8B
    EXT  V1.8B, V21.8B, V23.8B, #0x3
    SUBHN  V18.8B, V5.8H, V5.8H
    RADDHN2  V20.8H, V6.4S, V6.4S
    INS V12.D[0x0], V19.D[0x1]
    MOV S26, V24.S[0x1]
    ORR  V4.2S, #0xdd, LSL #8
    MOV  W24, V4.S[0x3]
    RADDHN2  V9.16B, V26.8H, V12.8H
    TRN2  V26.2D, V1.2D, V9.2D
    MOV V1.H[0x1], V26.H[0x3]
    RSHRN V26.4H, V20.4S, #11
    TBL  V23.8B, { V31.16B, V0.16B }, V26.8B
    EXT  V9.16B, V23.16B, V23.16B, #0x2
    MLS  V20.8H, V18.8H, V10.H[0x4]
    SRI  V12.2S, V9.2S, #18
    RSHRN2 V4.4S, V1.2D, #3
    REV64  V26.2S, V20.2S
    DUP V16.8B, W20
    DUP V30.2D, V16.D[0x1]
    AESMC  V31.16B, V30.16B
    SUBS  X5, X5, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_9
    MOVZ  X23, #0xfd86, LSL #0
    MOVK  X23, #0x5d37, LSL #16
    MOVK  X23, #0xfd6d, LSL #32
    MOVK  X23, #0xc653, LSL #48
    SUB  X6, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x670, LSL #0
    MOVK  X23, #0x7b1f, LSL #16
    MOVK  X23, #0xe1eb, LSL #32
    MOVK  X23, #0x3664, LSL #48
    SUB  X6, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X6, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x36e9, LSL #0
    MOVK  X23, #0x2e63, LSL #16
    MOVK  X23, #0x3266, LSL #32
    MOVK  X23, #0x1989, LSL #48
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x4ba8, LSL #0
    MOVK  X23, #0x6d15, LSL #16
    MOVK  X23, #0xae86, LSL #32
    MOVK  X23, #0xf572, LSL #48
    SUB  X6, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x5e4e, LSL #0
    MOVK  X23, #0xe152, LSL #16
    MOVK  X23, #0xc77e, LSL #32
    MOVK  X23, #0xdd90, LSL #48
    SUB  X6, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x9e8, LSL #0
    MOVK  X23, #0xfe37, LSL #16
    MOVK  X23, #0xec64, LSL #32
    MOVK  X23, #0xcbf2, LSL #48
    SUB  X6, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xb335, LSL #0
    MOVK  X23, #0x32ac, LSL #16
    MOVK  X23, #0x24a3, LSL #32
    MOVK  X23, #0xe3df, LSL #48
    SUB  X6, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xddcf, LSL #0
    MOVK  X23, #0x92e3, LSL #16
    MOVK  X23, #0x7aea, LSL #32
    MOVK  X23, #0x129, LSL #48
    SUB  X6, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xeee2, LSL #0
    MOVK  X23, #0x40d8, LSL #16
    MOVK  X23, #0x1739, LSL #32
    MOVK  X23, #0x56ff, LSL #48
    SUB  X6, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x2419, LSL #0
    MOVK  X23, #0x9d8a, LSL #16
    MOVK  X23, #0x1f46, LSL #32
    MOVK  X23, #0x24ef, LSL #48
    SUB  X6, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x6f94, LSL #0
    MOVK  X23, #0x3d49, LSL #16
    MOVK  X23, #0x18e2, LSL #32
    MOVK  X23, #0x6d7e, LSL #48
    SUB  X6, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X6, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x59a0, LSL #0
    MOVK  X23, #0x54a8, LSL #16
    MOVK  X23, #0x3311, LSL #32
    MOVK  X23, #0x704, LSL #48
    SUB  X6, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xc9e8, LSL #0
    MOVK  X23, #0x61c8, LSL #16
    MOVK  X23, #0xe407, LSL #32
    MOVK  X23, #0x6210, LSL #48
    SUB  X6, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x6f96, LSL #0
    MOVK  X23, #0x5f6a, LSL #16
    MOVK  X23, #0x1eae, LSL #32
    MOVK  X23, #0xf71a, LSL #48
    SUB  X6, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xc464, LSL #0
    MOVK  X23, #0xf8e0, LSL #16
    MOVK  X23, #0x1a81, LSL #32
    MOVK  X23, #0x9b47, LSL #48
    SUB  X6, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X6, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xd7ec, LSL #0
    MOVK  X23, #0x96b9, LSL #16
    MOVK  X23, #0xbe71, LSL #32
    MOVK  X23, #0xb60f, LSL #48
    SUB  X6, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x3ba4, LSL #0
    MOVK  X23, #0x43d, LSL #16
    MOVK  X23, #0x2861, LSL #32
    MOVK  X23, #0x31c5, LSL #48
    SUB  X6, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x8de0, LSL #0
    MOVK  X23, #0x4d4a, LSL #16
    MOVK  X23, #0xba6, LSL #32
    MOVK  X23, #0x51ea, LSL #48
    SUB  X6, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MRS  X6, FPSR
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V0.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x2000, LSL #16
    MOVK  X23, #0x2000, LSL #48
    FMOV  X6, D0
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V1.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x1920, LSL #0
    MOVK  X23, #0x3fe8, LSL #32
    MOVK  X23, #0x3c00, LSL #48
    FMOV  X6, D1
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X6, V2.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x5800, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xdbe6, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X6, D2
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x6f96, LSL #0
    MOVK  X23, #0x5f6a, LSL #16
    MOVK  X23, #0x31c5, LSL #48
    FMOV  X6, V3.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x3ba4, LSL #16
    MOVK  X23, #0x43d, LSL #48
    FMOV  X6, D3
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x324, LSL #0
    FMOV  X6, V4.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xdd00, LSL #0
    MOVK  X23, #0xdd00, LSL #32
    FMOV  X6, D4
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x5d00, LSL #0
    MOVK  X23, #0x5d00, LSL #32
    FMOV  X6, V5.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x5d00, LSL #0
    MOVK  X23, #0x5d00, LSL #32
    FMOV  X6, D5
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xff63, LSL #32
    MOVK  X23, #0x1663, LSL #48
    FMOV  X6, V6.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x9c63, LSL #32
    MOVK  X23, #0xb763, LSL #48
    FMOV  X6, D6
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x9e8, LSL #0
    MOVK  X23, #0xfe37, LSL #16
    MOVK  X23, #0xec64, LSL #32
    MOVK  X23, #0xcbf2, LSL #48
    FMOV  X6, V7.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x670, LSL #0
    MOVK  X23, #0x7b1f, LSL #16
    MOVK  X23, #0xe1eb, LSL #32
    MOVK  X23, #0x3664, LSL #48
    FMOV  X6, D7
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x374, LSL #0
    MOVK  X23, #0x40c8, LSL #16
    FMOV  X6, V8.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x11, LSL #0
    MOVK  X23, #0x11, LSL #32
    FMOV  X6, D8
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V9.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7e, LSL #32
    FMOV  X6, D9
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V10.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, D10
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V11.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x6e0, LSL #0
    MOVK  X23, #0xa60, LSL #16
    MOVK  X23, #0x260, LSL #32
    MOVK  X23, #0x1989, LSL #48
    FMOV  X6, D11
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V12.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, D12
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V13.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x32, LSL #0
    MOVK  X23, #0x200, LSL #16
    MOVK  X23, #0x200, LSL #48
    FMOV  X6, D13
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x8000, LSL #48
    FMOV  X6, V14.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, D14
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V15.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x10, LSL #0
    MOVK  X23, #0x10, LSL #16
    MOVK  X23, #0x2000, LSL #32
    FMOV  X6, D15
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V16.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x9696, LSL #0
    MOVK  X23, #0x9696, LSL #16
    MOVK  X23, #0x9696, LSL #32
    MOVK  X23, #0x9696, LSL #48
    FMOV  X6, D16
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xb2ab, LSL #0
    MOVK  X23, #0x5799, LSL #16
    MOVK  X23, #0xb3df, LSL #32
    MOVK  X23, #0x8d35, LSL #48
    FMOV  X6, V17.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xb2ab, LSL #0
    MOVK  X23, #0x5799, LSL #16
    MOVK  X23, #0xb3df, LSL #32
    MOVK  X23, #0x8d35, LSL #48
    FMOV  X6, D17
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V18.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, D18
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V19.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x4003, LSL #32
    FMOV  X6, D19
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x6ec7, LSL #16
    MOVK  X23, #0x2cc8, LSL #48
    FMOV  X6, V20.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xb335, LSL #0
    MOVK  X23, #0x32ac, LSL #16
    MOVK  X23, #0x24a3, LSL #32
    MOVK  X23, #0xe3df, LSL #48
    FMOV  X6, D20
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V21.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xe19, LSL #0
    MOVK  X23, #0x2019, LSL #16
    MOVK  X23, #0x1919, LSL #32
    MOVK  X23, #0xe819, LSL #48
    FMOV  X6, D21
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x59a0, LSL #0
    MOVK  X23, #0x54a8, LSL #16
    MOVK  X23, #0x3311, LSL #32
    MOVK  X23, #0x704, LSL #48
    FMOV  X6, V22.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x5e4e, LSL #0
    MOVK  X23, #0xe152, LSL #16
    MOVK  X23, #0xc77e, LSL #32
    MOVK  X23, #0xdd90, LSL #48
    FMOV  X6, D22
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V23.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7e, LSL #48
    FMOV  X6, D23
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V24.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x5d, LSL #0
    MOVK  X23, #0xe800, LSL #16
    MOVK  X23, #0x5d, LSL #32
    FMOV  X6, D24
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x60c1, LSL #0
    MOVK  X23, #0xa6d9, LSL #16
    MOVK  X23, #0xf774, LSL #32
    MOVK  X23, #0x22a2, LSL #48
    FMOV  X6, V25.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xb335, LSL #0
    MOVK  X23, #0x32ac, LSL #16
    MOVK  X23, #0x24a3, LSL #32
    MOVK  X23, #0xe3df, LSL #48
    FMOV  X6, D25
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V26.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x24a3, LSL #0
    MOVK  X23, #0xe3df, LSL #16
    MOVK  X23, #0xb335, LSL #32
    MOVK  X23, #0x32ac, LSL #48
    FMOV  X6, D26
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V27.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xa3, LSL #0
    MOVK  X23, #0xdf, LSL #16
    MOVK  X23, #0x35, LSL #32
    MOVK  X23, #0xac, LSL #48
    FMOV  X6, D27
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V28.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, D28
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xd680, LSL #0
    MOVK  X23, #0xca80, LSL #32
    FMOV  X6, V29.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xe80, LSL #0
    MOVK  X23, #0x207e, LSL #16
    MOVK  X23, #0x1919, LSL #32
    MOVK  X23, #0xe800, LSL #48
    FMOV  X6, D29
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V30.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, D30
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, V31.D[1]
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X6, D31
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    FMOV  D0, X26
    FMOV  V0.D[1], X6
    FMOV  D1, X18
    FMOV  V1.D[1], X21
    FMOV  D2, X4
    FMOV  V2.D[1], X17
    FMOV  D3, X28
    FMOV  V3.D[1], X27
    FMOV  D4, X24
    FMOV  V4.D[1], X20
    FMOV  D5, X23
    FMOV  V5.D[1], X25
    FMOV  D6, X7
    FMOV  V6.D[1], X13
    FMOV  D7, X21
    FMOV  V7.D[1], X18
    FMOV  D8, X21
    FMOV  V8.D[1], X15
    FMOV  D9, X26
    FMOV  V9.D[1], X28
    FMOV  D10, X6
    FMOV  V10.D[1], X4
    FMOV  D11, X10
    FMOV  V11.D[1], X9
    FMOV  D12, X23
    FMOV  V12.D[1], X2
    FMOV  D13, X2
    FMOV  V13.D[1], X18
    FMOV  D14, X19
    FMOV  V14.D[1], X7
    FMOV  D15, X27
    FMOV  V15.D[1], X28
    FMOV  D16, X7
    FMOV  V16.D[1], X23
    FMOV  D17, X14
    FMOV  V17.D[1], X17
    FMOV  D18, X8
    FMOV  V18.D[1], X21
    FMOV  D19, X7
    FMOV  V19.D[1], X6
    FMOV  D20, X10
    FMOV  V20.D[1], X4
    FMOV  D21, X21
    FMOV  V21.D[1], X10
    FMOV  D22, X8
    FMOV  V22.D[1], X20
    FMOV  D23, X20
    FMOV  V23.D[1], X19
    FMOV  D24, X18
    FMOV  V24.D[1], X26
    FMOV  D25, X15
    FMOV  V25.D[1], X25
    FMOV  D26, X17
    FMOV  V26.D[1], X28
    FMOV  D27, X20
    FMOV  V27.D[1], X6
    FMOV  D28, X9
    FMOV  V28.D[1], X10
    FMOV  D29, X21
    FMOV  V29.D[1], X15
    FMOV  D30, X24
    FMOV  V30.D[1], X21
    FMOV  D31, X23
    FMOV  V31.D[1], X21
    MOVZ  X15, #0xf, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_10:
    BIF  V21.16B, V27.16B, V22.16B
    MOVI  V2.4S, #0x4b, MSL #8
    TBX  V1.16B, { V28.16B, V29.16B, V30.16B, V31.16B }, V2.16B
    EXT  V11.16B, V20.16B, V1.16B, #0xa
    CLZ  V26.8B, V11.8B
    REV16  V21.8B, V21.8B
    PMULL2  V5.8H, V25.16B, V24.16B
    INS V19.H[0x1], W18
    INS V5.S[0x3], V19.S[0x0]
    BIT  V6.8B, V26.8B, V21.8B
    BIC  V2.2S, #0x16, LSL #8
    SHL V29.2D, V5.2D, #0x11
    RSHRN2 V22.8H, V29.4S, #1
    DUP V24.4H, W23
    MOV V26.B[0x8], W19
    SHRN2 V25.16B, V26.8H, #1
    MVNI  V11.2S, #0x81, MSL #8
    TBL  V5.8B, { V1.16B, V2.16B, V3.16B, V4.16B }, V2.8B
    CLS  V31.2S, V6.2S
    MOV H26, V22.H[0x1]
    DUP V1.16B, W24
    MUL  V20.4H, V1.4H, V14.H[0x2]
    MOV  V4.8B, V20.8B
    DUP H1, V24.H[0x7]
    DUP V20.4S, W26
    REV32  V2.16B, V11.16B
    SRI  V3.4H, V2.4H, #6
    RADDHN2  V29.8H, V1.4S, V20.4S
    ADD  V21.4H, V3.4H, V4.4H
    SHRN2 V24.8H, V21.4S, #10
    MOV V4.B[0x1], V29.B[0x1]
    RBIT  V20.16B, V4.16B
    MVNI  V22.8H, #0x3e
    CNT  V3.16B, V25.16B
    RADDHN2  V25.16B, V26.8H, V26.8H
    INS V4.S[0x2], V8.S[0x1]
    DUP  V8.8B, V20.B[0xa]
    MOV V2.S[0x2], W24
    EXT  V14.8B, V31.8B, V5.8B, #0x4
    RBIT  V11.8B, V2.8B
    SHRN2 V2.4S, V11.2D, #26
    DUP  V29.2S, V24.S[0x3]
    TBX  V1.16B, { V29.16B }, V2.16B
    RSHRN V21.4H, V3.4S, #14
    ADDV  B31, V1.16B
    TBX  V6.16B, { V30.16B, V31.16B, V0.16B, V1.16B }, V14.16B
    RSHRN V31.8B, V21.8H, #5
    SLI V5.2D, V22.2D, #0x33
    DUP V14.16B, W28
    INS V22.B[0xa], V8.B[0x8]
    SHRN V11.8B, V4.8H, #8
    ADDHN2  V1.4S, V6.2D, V11.2D
    MOV V24.S[0x0], V5.S[0x3]
    MOV V21.H[0x0], V31.H[0x2]
    REV64  V11.4S, V1.4S
    AESMC  V1.16B, V25.16B
    EOR  V29.8B, V24.8B, V11.8B
    MOV B24, V21.B[0xf]
    SLI V21.2D, V21.2D, #0x2b
    DUP V0.2S, W27
    AND  V30.8B, V2.8B, V21.8B
    SRI  V2.8H, V22.8H, #10
    MOV V5.H[0x3], W15
    MVN  V22.8B, V2.8B
    MVNI  V8.4S, #0x58, LSL #24
    MVN  V6.8B, V30.8B
    ZIP1  V11.2D, V14.2D, V1.2D
    MUL  V21.4H, V24.4H, V5.H[0x6]
    DUP V14.2D, X9
    SHRN V2.2S, V29.2D, #15
    RSUBHN2  V29.4S, V11.2D, V13.2D
    RSHRN V25.8B, V0.8H, #2
    INS V4.H[0x6], W9
    INS V3.D[0x0], V2.D[0x0]
    ABS  V2.4S, V22.4S
    SHRN V30.4H, V14.4S, #1
    MVN  V5.8B, V14.8B
    DUP B13, V21.B[0x4]
    SHLL2  V24.8H, V4.16B, #8
    EXT  V11.8B, V5.8B, V24.8B, #0x1
    MLA  V24.4S, V8.4S, V30.4S
    MOV V1.B[0x9], W5
    MOV B4, V13.B[0x6]
    ADDP  D22, V24.2D
    MOV V14.D[0x1], X28
    MOV V21.S[0x2], V30.S[0x1]
    REV16  V5.8B, V6.8B
    MLA  V6.8B, V2.8B, V11.8B
    ABS  V2.8H, V1.8H
    TBL  V30.16B, { V7.16B, V8.16B, V9.16B, V10.16B }, V2.16B
    MLS  V11.8B, V4.8B, V18.8B
    RSUBHN  V0.8B, V3.8H, V3.8H
    TBX  V1.16B, { V22.16B }, V0.16B
    EXT  V11.8B, V6.8B, V29.8B, #0x3
    BIF  V3.16B, V14.16B, V5.16B
    AESE  V2.16B, V30.16B
    BIT  V14.16B, V21.16B, V21.16B
    XTN  V18.4H, V25.4S
    DUP V7.2D, X14
    MOV V25.D[0x0], V2.D[0x0]
    XTN2  V10.8H, V3.4S
    DUP  V23.8B, V10.B[0xc]
    BIF  V2.8B, V18.8B, V18.8B
    SRI  V5.8H, V2.8H, #5
    SHRN2 V2.8H, V9.4S, #5
    SRI  V8.16B, V25.16B, #7
    PMUL  V10.16B, V7.16B, V1.16B
    NOT  V30.8B, V10.8B
    MOV S6, V11.S[0x1]
    RSUBHN2  V21.8H, V2.4S, V5.4S
    EOR  V29.8B, V21.8B, V14.8B
    RSHRN2 V0.4S, V30.2D, #12
    ADD  V14.8H, V23.8H, V23.8H
    PMUL  V18.8B, V8.8B, V0.8B
    RADDHN2  V23.8H, V29.4S, V6.4S
    MOVI  V6.2D, #1099511627775
    MVN  V30.8B, V6.8B
    ORN  V3.16B, V2.16B, V30.16B
    DUP V22.2D, X11
    MOV V0.B[0xa], W27
    UZP2  V1.2D, V14.2D, V0.2D
    SHLL2  V8.2D, V1.4S, #32
    TBL  V14.8B, { V8.16B }, V18.8B
    UZP2  V7.2D, V22.2D, V14.2D
    PMULL  V25.1Q, V7.1D, V23.1D
    AESE  V6.16B, V8.16B
    SHLL  V1.2D, V6.2S, #32
    MLS  V29.4H, V1.4H, V8.H[0x0]
    MOV V5.D[0x0], V25.D[0x1]
    REV16  V14.16B, V4.16B
    RADDHN  V4.4H, V5.4S, V14.4S
    AESE  V22.16B, V4.16B
    MVNI  V4.4S, #0x83, LSL #16
    MOV D0, V22.D[0x0]
    RSUBHN  V5.4H, V4.4S, V3.4S
    MOV D14, V0.D[0x1]
    ORR  V25.2S, #0xac, LSL #8
    UZP1  V21.4S, V5.4S, V5.4S
    MOV  V1.16B, V21.16B
    INS V8.H[0x6], W2
    MVN  V6.8B, V29.8B
    TBX  V23.16B, { V15.16B, V16.16B, V17.16B }, V1.16B
    PMULL2  V22.1Q, V6.2D, V8.2D
    UZP1  V5.2S, V22.2S, V23.2S
    RSUBHN  V7.2S, V5.2D, V25.2D
    PMUL  V6.16B, V7.16B, V7.16B
    BIC  V8.2S, #0xb2, LSL #24
    MLS  V21.4H, V6.4H, V14.H[0x3]
    RSUBHN  V1.2S, V8.2D, V8.2D
    DUP B18, V1.B[0xf]
    ZIP2  V1.4S, V18.4S, V18.4S
    ABS  V17.4S, V31.4S
    INS V29.S[0x0], V28.S[0x0]
    UZP2  V5.2S, V29.2S, V21.2S
    MVNI  V22.8H, #0x7a
    MOVI  V14.8H, #0xd6, LSL #8
    CLZ  V7.8H, V5.8H
    MOV V28.S[0x3], V22.S[0x1]
    TBL  V22.16B, { V28.16B }, V7.16B
    DUP S28, V26.S[0x3]
    MOV  W2, V0.S[0x0]
    MOV V31.H[0x2], W26
    UZP1  V7.2S, V31.2S, V31.2S
    SRI  V26.8H, V14.8H, #12
    DUP V18.2D, X19
    BSL  V0.16B, V17.16B, V18.16B
    INS V31.H[0x4], V28.H[0x4]
    SHRN V29.8B, V22.8H, #7
    SHRN2 V22.4S, V13.2D, #9
    BIC  V23.4H, #0xec, LSL #8
    MOV V21.S[0x3], W24
    ADDV  S14, V26.4S
    SLI  V5.4S, V14.4S, #0x19
    AND  V18.16B, V31.16B, V29.16B
    MVNI  V13.4S, #0x67, LSL #16
    INS V8.D[0x1], V7.D[0x0]
    RSHRN V17.8B, V21.8H, #7
    RSHRN2 V28.4S, V1.2D, #1
    TBL  V1.16B, { V7.16B, V8.16B, V9.16B }, V0.16B
    ABS  V26.2S, V1.2S
    MOV  X27, V18.D[0x0]
    MVN  V1.16B, V22.16B
    MOV V22.B[0x9], V3.B[0x0]
    MOV V21.B[0xe], V22.B[0x7]
    NOT  V3.16B, V5.16B
    DUP  V14.4H, V26.H[0x6]
    AESIMC  V8.16B, V14.16B
    ADDV  B29, V21.8B
    MOVI  V23.2D, #18446463693966278655
    DUP V7.2D, X19
    MOV D22, V23.D[0x0]
    BIT  V30.16B, V22.16B, V22.16B
    DUP S18, V29.S[0x2]
    UZP2  V9.4H, V13.4H, V1.4H
    INS V31.S[0x1], W15
    SHLL2  V26.4S, V8.8H, #16
    DUP H29, V20.H[0x2]
    SLI  V21.2S, V28.2S, #0x19
    MOV V1.D[0x0], V30.D[0x1]
    TBX  V5.16B, { V7.16B }, V1.16B
    SUBS  X15, X15, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_10
    MOVZ  X25, #0x6363, LSL #0
    MOVK  X25, #0x6363, LSL #16
    SUB  X13, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MRS  X13, FPSR
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, V0.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x20, LSL #16
    FMOV  X13, D0
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X13, V1.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, D1
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0xc7fc, LSL #0
    MOVK  X25, #0xffff, LSL #16
    FMOV  X13, V2.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, D2
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X13, V3.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xb7ff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X13, D3
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xff7c, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xff7c, LSL #48
    FMOV  X13, V4.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xff7c, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xff7c, LSL #48
    FMOV  X13, D4
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, V5.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, D5
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, V6.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x1000, LSL #0
    MOVK  X25, #0x5555, LSL #16
    FMOV  X13, D6
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, V7.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, D7
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, V8.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, D8
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, V9.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0xff98, LSL #0
    MOVK  X25, #0xff98, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X13, D9
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, V10.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, D10
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, V11.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0xfbff, LSL #0
    MOVK  X25, #0x7ffb, LSL #16
    MOVK  X25, #0xff, LSL #32
    MOVK  X25, #0x800, LSL #48
    FMOV  X13, D11
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, V12.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, D12
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xff98, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xff98, LSL #48
    FMOV  X13, V13.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xff98, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xff98, LSL #48
    FMOV  X13, D13
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, V14.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, D14
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, V15.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, D15
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, V16.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, D16
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, V17.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    FMOV  X13, D17
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, V18.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, D18
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, V19.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, D19
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, V20.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, D20
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, V21.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0xff7d, LSL #0
    MOVK  X25, #0x17d, LSL #16
    FMOV  X13, D21
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, V22.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xff, LSL #16
    MOVK  X25, #0xff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X13, D22
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xff, LSL #16
    MOVK  X25, #0xff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X13, V23.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xff, LSL #16
    MOVK  X25, #0xff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X13, D23
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, V24.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, D24
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, V25.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0xac00, LSL #0
    MOVK  X25, #0xac00, LSL #32
    FMOV  X13, D25
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, V26.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, D26
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, V27.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, D27
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, V28.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, D28
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, V29.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, D29
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, V30.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X13, D30
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X13, V31.D[1]
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x20, LSL #16
    MOVK  X25, #0x1, LSL #32
    FMOV  X13, D31
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
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
    FMOV  D0, X24
    FMOV  V0.D[1], X25
    FMOV  D1, X28
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X7
    FMOV  D3, X8
    FMOV  V3.D[1], X18
    FMOV  D4, X2
    FMOV  V4.D[1], X7
    FMOV  D5, X28
    FMOV  V5.D[1], X16
    FMOV  D6, X20
    FMOV  V6.D[1], X2
    FMOV  D7, X26
    FMOV  V7.D[1], X26
    FMOV  D8, X10
    FMOV  V8.D[1], X9
    FMOV  D9, X20
    FMOV  V9.D[1], X4
    FMOV  D10, X27
    FMOV  V10.D[1], X9
    FMOV  D11, X4
    FMOV  V11.D[1], X4
    FMOV  D12, X5
    FMOV  V12.D[1], X24
    FMOV  D13, X17
    FMOV  V13.D[1], X8
    FMOV  D14, X24
    FMOV  V14.D[1], X16
    FMOV  D15, X25
    FMOV  V15.D[1], X2
    FMOV  D16, X27
    FMOV  V16.D[1], X26
    FMOV  D17, X16
    FMOV  V17.D[1], X15
    FMOV  D18, X11
    FMOV  V18.D[1], X7
    FMOV  D19, X21
    FMOV  V19.D[1], X27
    FMOV  D20, X17
    FMOV  V20.D[1], X28
    FMOV  D21, X10
    FMOV  V21.D[1], X17
    FMOV  D22, X21
    FMOV  V22.D[1], X19
    FMOV  D23, X19
    FMOV  V23.D[1], X20
    FMOV  D24, X25
    FMOV  V24.D[1], X25
    FMOV  D25, X21
    FMOV  V25.D[1], X25
    FMOV  D26, X23
    FMOV  V26.D[1], X25
    FMOV  D27, X24
    FMOV  V27.D[1], X16
    FMOV  D28, X6
    FMOV  V28.D[1], X10
    FMOV  D29, X13
    FMOV  V29.D[1], X5
    FMOV  D30, X11
    FMOV  V30.D[1], X17
    FMOV  D31, X25
    FMOV  V31.D[1], X24
    MOVZ  X23, #0xf, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_11:
    RSHRN2 V15.8H, V23.4S, #12
    TBX  V10.16B, { V28.16B, V29.16B, V30.16B }, V28.16B
    INS V16.D[0x0], X7
    SLI  V26.8H, V16.8H, #0xa
    MOV V5.D[0x0], V27.D[0x1]
    TBX  V20.16B, { V10.16B, V11.16B, V12.16B }, V10.16B
    BIC  V2.8B, V25.8B, V21.8B
    ADDV  S16, V26.4S
    UZP1  V3.16B, V31.16B, V16.16B
    MOV  W25, V15.S[0x2]
    MOVI  V11.2D, #281474976645375
    ADDV  H14, V11.4H
    DUP V21.4S, W18
    RSHRN2 V5.4S, V20.2D, #10
    DUP V31.8B, W5
    ADD  V31.8B, V3.8B, V21.8B
    MOV B3, V2.B[0xe]
    ADDV  S10, V5.4S
    SHL  V11.4H, V14.4H, #0xc
    ZIP2  V29.2S, V3.2S, V31.2S
    REV32  V30.8H, V11.8H
    MVNI  V15.2S, #0x49, MSL #8
    EOR  V25.8B, V10.8B, V30.8B
    MLA  V20.4S, V29.4S, V25.4S
    MOV H12, V20.H[0x1]
    SHRN V27.8B, V15.8H, #4
    UZP1  V29.8B, V12.8B, V12.8B
    RSHRN V16.4H, V27.4S, #4
    DUP V30.2D, X9
    SUB  V11.4H, V30.4H, V29.4H
    INS V30.B[0x7], W24
    REV32  V25.4H, V11.4H
    MOV V14.D[0x0], V16.D[0x0]
    MOV B3, V30.B[0x1]
    ADDHN2  V31.16B, V3.8H, V25.8H
    ADDP  D26, V31.2D
    RSHRN V10.8B, V14.8H, #1
    ORR  V29.4H, #0x6d, LSL #8
    MUL  V27.4H, V10.4H, V14.H[0x7]
    DUP V12.2D, V26.D[0x0]
    MVN  V20.16B, V27.16B
    INS V15.S[0x3], V2.S[0x2]
    DUP  V2.2S, V12.S[0x2]
    CNT  V12.16B, V29.16B
    ZIP1  V30.8H, V20.8H, V7.8H
    XTN2  V16.16B, V15.8H
    BSL  V29.8B, V2.8B, V2.8B
    ORR  V3.8H, #0xbe
    BIC  V26.4S, #0xbb, LSL #24
    MOVI  V20.2D, #1099511562495
    BIT  V15.16B, V10.16B, V26.16B
    ADDP  V10.4S, V15.4S, V12.4S
    MOV V27.D[0x0], X28
    SHRN2 V7.16B, V30.8H, #8
    ADDV  H15, V29.8H
    XTN2  V12.8H, V17.4S
    INS V30.D[0x1], X27
    SHRN2 V26.4S, V20.2D, #32
    TBX  V29.16B, { V30.16B, V31.16B, V0.16B, V1.16B }, V22.16B
    ORR  V2.16B, V29.16B, V12.16B
    REV32  V17.4H, V16.4H
    SHRN V22.4H, V15.4S, #1
    INS V15.B[0x9], W8
    MVNI  V20.8H, #0x15
    RBIT  V14.8B, V26.8B
    INS V0.H[0x0], W28
    SRI  V26.8H, V14.8H, #12
    INS V1.H[0x5], V20.H[0x0]
    EXT  V20.8B, V15.8B, V27.8B, #0x0
    DUP V30.2D, V0.D[0x0]
    DUP V27.2D, X13
    DUP V31.16B, W21
    REV64  V0.16B, V2.16B
    SHRN V14.8B, V27.8H, #7
    SLI V15.2D, V17.2D, #0x7
    ZIP2  V2.8H, V26.8H, V0.8H
    RSHRN2 V12.8H, V1.4S, #2
    TBL  V29.8B, { V3.16B, V4.16B }, V31.8B
    SHRN V17.4H, V20.4S, #5
    MLS  V16.8H, V30.8H, V14.H[0x5]
    RSHRN2 V1.8H, V22.4S, #7
    AESMC  V4.16B, V17.16B
    TBL  V27.16B, { V8.16B, V9.16B, V10.16B, V11.16B }, V15.16B
    TRN2  V10.4S, V7.4S, V29.4S
    AESMC  V3.16B, V10.16B
    RSHRN V14.4H, V1.4S, #1
    EXT  V8.16B, V16.16B, V14.16B, #0x3
    MLA  V0.4S, V12.4S, V27.S[0x1]
    TBL  V20.8B, { V8.16B }, V19.8B
    DUP S14, V3.S[0x0]
    ORN  V10.8B, V14.8B, V20.8B
    PMULL2  V31.8H, V4.16B, V2.16B
    MOV  V19.16B, V10.16B
    BIC  V3.8H, #0x78
    MOV V17.B[0x7], W19
    UZP2  V15.8B, V30.8B, V0.8B
    MLS  V9.16B, V15.16B, V31.16B
    TBL  V12.16B, { V19.16B }, V9.16B
    BIC  V15.2S, #0x96
    INS V0.B[0x0], W7
    RSHRN V26.8B, V12.8H, #5
    TRN1  V22.2D, V26.2D, V0.2D
    AESD  V19.16B, V17.16B
    ADDHN  V31.4H, V19.4S, V29.4S
    SHRN2 V20.4S, V31.2D, #23
    ADD  V12.8B, V0.8B, V20.8B
    MOV  V9.16B, V15.16B
    DUP H26, V3.H[0x4]
    SHLL2  V30.4S, V9.8H, #16
    ZIP2  V9.16B, V6.16B, V22.16B
    MLS  V19.4S, V26.4S, V26.S[0x0]
    SLI  V22.16B, V12.16B, #0x5
    INS V17.D[0x0], X9
    RSHRN V12.2S, V30.2D, #8
    INS V30.D[0x1], V12.D[0x0]
    EOR  V3.8B, V17.8B, V30.8B
    SLI  V29.8B, V22.8B, #0x7
    MOV S22, V3.S[0x3]
    MOVI  V15.16B, #0xed
    INS V14.D[0x1], X6
    SLI  V17.8B, V9.8B, #0x7
    DUP S31, V19.S[0x2]
    SHLL  V12.2D, V29.2S, #32
    SLI  V20.4H, V12.4H, #0x0
    ADD  V0.2S, V22.2S, V31.2S
    EOR  V31.16B, V0.16B, V14.16B
    UZP1  V12.16B, V15.16B, V15.16B
    SUBHN  V22.2S, V31.2D, V17.2D
    BIC  V15.8B, V20.8B, V20.8B
    SUBHN2  V30.16B, V15.8H, V15.8H
    SUB  V6.8B, V12.8B, V27.8B
    ABS  V26.16B, V30.16B
    SHRN2 V17.4S, V6.2D, #30
    BIT  V29.8B, V22.8B, V27.8B
    ORN  V30.16B, V29.16B, V17.16B
    ZIP1  V0.2D, V30.2D, V26.2D
    BIC  V3.8B, V24.8B, V9.8B
    ZIP1  V19.4S, V12.4S, V21.4S
    INS V20.S[0x2], W24
    CLZ  V21.4S, V1.4S
    TBX  V31.16B, { V17.16B, V18.16B }, V29.16B
    ADDV  B15, V15.8B
    PMUL  V14.16B, V14.16B, V20.16B
    UZP1  V22.4S, V7.4S, V27.4S
    SHRN V27.2S, V27.2D, #31
    DUP  V7.4H, V19.H[0x4]
    MUL  V14.8B, V21.8B, V14.8B
    ADD  V12.4S, V7.4S, V0.4S
    ORR  V0.8H, #0x15
    DUP V9.2D, V22.D[0x0]
    SHL  V3.8B, V3.8B, #0x6
    MOV D7, V9.D[0x0]
    ORR  V6.16B, V7.16B, V7.16B
    INS V24.D[0x1], X6
    ADDP  V19.8H, V31.8H, V0.8H
    ORN  V1.8B, V3.8B, V27.8B
    SHL  V9.4H, V14.4H, #0x5
    PMULL  V30.1Q, V1.1D, V9.1D
    REV16  V27.16B, V15.16B
    MOV V21.D[0x0], X11
    SRI  V22.2S, V24.2S, #13
    PMUL  V20.16B, V19.16B, V1.16B
    XTN2  V7.8H, V25.4S
    MOV V24.H[0x3], V12.H[0x3]
    INS V9.S[0x3], V6.S[0x1]
    BIT  V19.16B, V22.16B, V7.16B
    BIC  V6.2S, #0xe8, LSL #16
    DUP V12.2D, V24.D[0x1]
    ABS  V31.4H, V6.4H
    BIC  V6.16B, V31.16B, V9.16B
    SHRN V14.8B, V6.8H, #3
    DUP V0.2S, W11
    TBX  V7.16B, { V19.16B, V20.16B, V21.16B }, V0.16B
    XTN2  V15.4S, V12.2D
    MLA  V22.8H, V14.8H, V14.H[0x3]
    ABS  V25.2S, V27.2S
    RBIT  V27.16B, V30.16B
    REV64  V24.8H, V27.8H
    SLI  V6.8H, V7.8H, #0xd
    MOV V14.S[0x1], W10
    TBL  V12.8B, { V1.16B, V2.16B }, V25.8B
    TBL  V25.16B, { V24.16B }, V22.16B
    SHRN V0.4H, V7.4S, #13
    MOV  V21.16B, V6.16B
    DUP V24.2D, X4
    BSL  V6.8B, V24.8B, V24.8B
    MOV S2, V15.S[0x3]
    AESMC  V9.16B, V25.16B
    SHRN V7.2S, V0.2D, #30
    AESE  V7.16B, V12.16B
    DUP V30.2D, V14.D[0x0]
    SHRN V12.2S, V2.2D, #16
    ZIP1  V1.8H, V6.8H, V21.8H
    MLS  V14.2S, V9.2S, V12.2S
    SHLL  V6.8H, V14.8B, #8
    DUP D14, V7.D[0x1]
    MVNI  V7.2S, #0xbe, LSL #24
    SRI  V31.8B, V7.8B, #5
    MOVI  V12.16B, #0xfc
    BSL  V24.8B, V14.8B, V12.8B
    SUBS  X23, X23, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_11
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    MRS  X16, FPSR
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V0.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xfff, LSL #0
    MOVK  X20, #0xfff, LSL #16
    MOVK  X20, #0xdbdb, LSL #32
    MOVK  X20, #0xdbdb, LSL #48
    FMOV  X16, D0
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xe001, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xe117, LSL #48
    FMOV  X16, V1.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xe001, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xe117, LSL #48
    FMOV  X16, D1
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V2.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    FMOV  X16, D2
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V3.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xc0, LSL #0
    MOVK  X20, #0x80c0, LSL #32
    MOVK  X20, #0x4000, LSL #48
    FMOV  X16, D3
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V4.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xb47d, LSL #0
    MOVK  X20, #0xc9b2, LSL #16
    FMOV  X16, D4
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xaaab, LSL #0
    MOVK  X20, #0xaaaa, LSL #16
    FMOV  X16, V5.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D5
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xff00, LSL #0
    MOVK  X20, #0xff00, LSL #16
    MOVK  X20, #0xff00, LSL #32
    MOVK  X20, #0xff00, LSL #48
    FMOV  X16, V6.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x2200, LSL #16
    MOVK  X20, #0x2200, LSL #48
    FMOV  X16, D6
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V7.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0x41ff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0x41ff, LSL #48
    FMOV  X16, D7
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xff, LSL #0
    FMOV  X16, V8.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0xff, LSL #48
    FMOV  X16, D8
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V9.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D9
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V10.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X16, D10
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V11.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xff55, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xff55, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X16, D11
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xfcfc, LSL #0
    MOVK  X20, #0xfcfc, LSL #16
    MOVK  X20, #0xfcfc, LSL #32
    MOVK  X20, #0xfcfc, LSL #48
    FMOV  X16, V12.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xfcfc, LSL #0
    MOVK  X20, #0xfcfc, LSL #16
    MOVK  X20, #0xfcfc, LSL #32
    MOVK  X20, #0xfcfc, LSL #48
    FMOV  X16, D12
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X16, V13.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X16, D13
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V14.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x6363, LSL #0
    MOVK  X20, #0x1660, LSL #16
    MOVK  X20, #0x6063, LSL #32
    MOVK  X20, #0x6316, LSL #48
    FMOV  X16, D14
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X16, V15.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D15
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xff00, LSL #0
    MOVK  X20, #0xff00, LSL #16
    FMOV  X16, V16.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xff6, LSL #0
    FMOV  X16, D16
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xb7b7, LSL #0
    MOVK  X20, #0xb7b7, LSL #16
    FMOV  X16, V17.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xff7f, LSL #0
    MOVK  X20, #0x7fff, LSL #16
    MOVK  X20, #0xff7f, LSL #32
    MOVK  X20, #0x7fff, LSL #48
    FMOV  X16, D17
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X16, V18.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X16, D18
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x2a, LSL #32
    MOVK  X20, #0x2a, LSL #48
    FMOV  X16, V19.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xb27b, LSL #0
    MOVK  X20, #0xfff8, LSL #16
    MOVK  X20, #0x18b2, LSL #32
    MOVK  X20, #0xfffb, LSL #48
    FMOV  X16, D19
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V20.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xaaaa, LSL #0
    MOVK  X20, #0xaaaa, LSL #16
    MOVK  X20, #0xaaaa, LSL #32
    MOVK  X20, #0xaaaa, LSL #48
    FMOV  X16, D20
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x6000, LSL #0
    MOVK  X20, #0x6000, LSL #16
    MOVK  X20, #0x6000, LSL #32
    MOVK  X20, #0x6000, LSL #48
    FMOV  X16, V21.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xe001, LSL #0
    MOVK  X20, #0xe117, LSL #16
    MOVK  X20, #0xe001, LSL #32
    MOVK  X20, #0xe117, LSL #48
    FMOV  X16, D21
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V22.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xb27b, LSL #0
    MOVK  X20, #0x41f8, LSL #16
    MOVK  X20, #0x18b2, LSL #32
    MOVK  X20, #0x41fb, LSL #48
    FMOV  X16, D22
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X16, V23.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X16, D23
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V24.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x6363, LSL #0
    MOVK  X20, #0x1660, LSL #16
    MOVK  X20, #0x6063, LSL #32
    MOVK  X20, #0x6316, LSL #48
    FMOV  X16, D24
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V25.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D25
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V26.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D26
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V27.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D27
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X16, V28.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X16, D28
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V29.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D29
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x2200, LSL #0
    MOVK  X20, #0x2200, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X16, V30.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x2200, LSL #0
    MOVK  X20, #0x2200, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X16, D30
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V31.D[1]
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x707, LSL #0
    MOVK  X20, #0x4217, LSL #16
    MOVK  X20, #0x707, LSL #32
    MOVK  X20, #0x4217, LSL #48
    FMOV  X16, D31
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x79d0, LSL #0
    MOVK  X2, #0x68e6, LSL #16
    MOVK  X2, #0xa10a, LSL #32
    MOVK  X2, #0xab24, LSL #48
    MOVZ  X4, #0x63ba, LSL #0
    MOVK  X4, #0x8cd0, LSL #16
    MOVK  X4, #0x25ef, LSL #32
    MOVK  X4, #0x3b29, LSL #48
    MOVZ  X5, #0xf032, LSL #0
    MOVK  X5, #0xd446, LSL #16
    MOVK  X5, #0xb1aa, LSL #32
    MOVK  X5, #0x8f95, LSL #48
    MOVZ  X6, #0x5413, LSL #0
    MOVK  X6, #0x3d32, LSL #16
    MOVK  X6, #0x1340, LSL #32
    MOVK  X6, #0x7743, LSL #48
    MOVZ  X7, #0x1463, LSL #0
    MOVK  X7, #0x5160, LSL #16
    MOVK  X7, #0x24ec, LSL #32
    MOVK  X7, #0x95b0, LSL #48
    MOVZ  X8, #0x4e4, LSL #0
    MOVK  X8, #0x3d11, LSL #16
    MOVK  X8, #0xa275, LSL #32
    MOVK  X8, #0x9418, LSL #48
    MOVZ  X9, #0x18c2, LSL #0
    MOVK  X9, #0x560c, LSL #16
    MOVK  X9, #0x3583, LSL #32
    MOVK  X9, #0x81df, LSL #48
    MOVZ  X10, #0xd77a, LSL #0
    MOVK  X10, #0xcd0b, LSL #16
    MOVK  X10, #0x9d3e, LSL #32
    MOVK  X10, #0xdaef, LSL #48
    MOVZ  X11, #0x606, LSL #0
    MOVK  X11, #0xb493, LSL #16
    MOVK  X11, #0x8c56, LSL #32
    MOVK  X11, #0x7286, LSL #48
    MOVZ  X13, #0x2c15, LSL #0
    MOVK  X13, #0xe2ec, LSL #16
    MOVK  X13, #0xfa7f, LSL #32
    MOVK  X13, #0x15a, LSL #48
    MOVZ  X14, #0xf0c7, LSL #0
    MOVK  X14, #0x9b24, LSL #16
    MOVK  X14, #0x9d75, LSL #32
    MOVK  X14, #0xbd7f, LSL #48
    MOVZ  X15, #0xa897, LSL #0
    MOVK  X15, #0x587f, LSL #16
    MOVK  X15, #0xf0c1, LSL #32
    MOVK  X15, #0xa7ce, LSL #48
    MOVZ  X16, #0xb571, LSL #0
    MOVK  X16, #0xb3f, LSL #16
    MOVK  X16, #0x69f2, LSL #32
    MOVK  X16, #0x52d4, LSL #48
    MOVZ  X17, #0x625b, LSL #0
    MOVK  X17, #0x6217, LSL #16
    MOVK  X17, #0xa0b9, LSL #32
    MOVK  X17, #0x1af3, LSL #48
    MOVZ  X18, #0xc6b0, LSL #0
    MOVK  X18, #0x6f59, LSL #16
    MOVK  X18, #0x1492, LSL #32
    MOVK  X18, #0xfe, LSL #48
    MOVZ  X19, #0xccb9, LSL #0
    MOVK  X19, #0x7b61, LSL #16
    MOVK  X19, #0x6f06, LSL #32
    MOVK  X19, #0x34b4, LSL #48
    MOVZ  X20, #0xde6f, LSL #0
    MOVK  X20, #0xbe5a, LSL #16
    MOVK  X20, #0xe4fb, LSL #32
    MOVK  X20, #0xc7fe, LSL #48
    MOVZ  X21, #0xe00, LSL #0
    MOVK  X21, #0x4f82, LSL #16
    MOVK  X21, #0x1675, LSL #32
    MOVK  X21, #0xcd72, LSL #48
    MOVZ  X23, #0x55e5, LSL #0
    MOVK  X23, #0xaba, LSL #16
    MOVK  X23, #0xf86e, LSL #32
    MOVK  X23, #0x3077, LSL #48
    MOVZ  X24, #0xde2d, LSL #0
    MOVK  X24, #0xc9a, LSL #16
    MOVK  X24, #0x6a21, LSL #32
    MOVK  X24, #0x7194, LSL #48
    MOVZ  X25, #0x81ff, LSL #0
    MOVK  X25, #0xae47, LSL #16
    MOVK  X25, #0xb3b2, LSL #32
    MOVK  X25, #0xcee, LSL #48
    MOVZ  X26, #0x94fd, LSL #0
    MOVK  X26, #0xc931, LSL #16
    MOVK  X26, #0x8c0d, LSL #32
    MOVK  X26, #0x3aa1, LSL #48
    MOVZ  X27, #0xd14f, LSL #0
    MOVK  X27, #0x9fb, LSL #16
    MOVK  X27, #0x13d6, LSL #32
    MOVK  X27, #0xdc7d, LSL #48
    MOVZ  X28, #0x263a, LSL #0
    MOVK  X28, #0x4fc1, LSL #16
    MOVK  X28, #0xef7a, LSL #32
    MOVK  X28, #0xde92, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X28
    FMOV  D1, X26
    FMOV  V1.D[1], X27
    FMOV  D2, X25
    FMOV  V2.D[1], X11
    FMOV  D3, X19
    FMOV  V3.D[1], X5
    FMOV  D4, X21
    FMOV  V4.D[1], X18
    FMOV  D5, X26
    FMOV  V5.D[1], X19
    FMOV  D6, X13
    FMOV  V6.D[1], X18
    FMOV  D7, X18
    FMOV  V7.D[1], X6
    FMOV  D8, X25
    FMOV  V8.D[1], X14
    FMOV  D9, X18
    FMOV  V9.D[1], X20
    FMOV  D10, X17
    FMOV  V10.D[1], X20
    FMOV  D11, X20
    FMOV  V11.D[1], X6
    FMOV  D12, X11
    FMOV  V12.D[1], X7
    FMOV  D13, X11
    FMOV  V13.D[1], X6
    FMOV  D14, X15
    FMOV  V14.D[1], X16
    FMOV  D15, X13
    FMOV  V15.D[1], X16
    FMOV  D16, X28
    FMOV  V16.D[1], X2
    FMOV  D17, X10
    FMOV  V17.D[1], X19
    FMOV  D18, X10
    FMOV  V18.D[1], X16
    FMOV  D19, X17
    FMOV  V19.D[1], X17
    FMOV  D20, X19
    FMOV  V20.D[1], X17
    FMOV  D21, X5
    FMOV  V21.D[1], X27
    FMOV  D22, X24
    FMOV  V22.D[1], X17
    FMOV  D23, X11
    FMOV  V23.D[1], X16
    FMOV  D24, X8
    FMOV  V24.D[1], X27
    FMOV  D25, X10
    FMOV  V25.D[1], X20
    FMOV  D26, X10
    FMOV  V26.D[1], X19
    FMOV  D27, X9
    FMOV  V27.D[1], X5
    FMOV  D28, X14
    FMOV  V28.D[1], X14
    FMOV  D29, X11
    FMOV  V29.D[1], X5
    FMOV  D30, X17
    FMOV  V30.D[1], X7
    FMOV  D31, X14
    FMOV  V31.D[1], X10
    MOVZ  X10, #0xf, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_12:
    REV16  V13.16B, V29.16B
    REV32  V15.8B, V24.8B
    RSUBHN  V4.2S, V25.2D, V25.2D
    PMULL  V30.1Q, V26.1D, V4.1D
    TRN2  V2.8B, V27.8B, V30.8B
    BIF  V29.8B, V13.8B, V13.8B
    MUL  V25.16B, V28.16B, V28.16B
    TBL  V15.16B, { V21.16B, V22.16B }, V25.16B
    BIC  V5.16B, V2.16B, V15.16B
    SHL  V16.4H, V5.4H, #0x8
    AND  V14.8B, V29.8B, V31.8B
    SHRN2 V29.16B, V16.8H, #1
    TBX  V21.16B, { V14.16B }, V29.16B
    BSL  V28.8B, V21.8B, V20.8B
    MLS  V4.4S, V28.4S, V28.4S
    SRI  V30.4S, V9.4S, #4
    INS V22.D[0x0], X8
    ORR  V9.8B, V25.8B, V31.8B
    BIF  V21.8B, V25.8B, V30.8B
    TBX  V24.16B, { V18.16B, V19.16B }, V19.16B
    MOV V28.D[0x1], V17.D[0x1]
    MVNI  V5.4H, #0x4e
    MLA  V19.4S, V3.4S, V12.S[0x0]
    SUBHN  V3.8B, V22.8H, V17.8H
    MOV D18, V25.D[0x0]
    ADDV  H17, V5.4H
    RSHRN2 V2.4S, V17.2D, #28
    MLS  V29.4S, V2.4S, V9.4S
    DUP H15, V4.H[0x7]
    SRI  V4.8H, V5.8H, #1
    SRI  V16.16B, V29.16B, #4
    CNT  V14.8B, V19.8B
    PMULL  V27.8H, V14.8B, V3.8B
    BIF  V17.16B, V16.16B, V18.16B
    MLS  V22.4S, V28.4S, V4.S[0x2]
    EXT  V12.8B, V24.8B, V24.8B, #0x1
    RSHRN V18.4H, V22.4S, #3
    MLS  V29.4H, V15.4H, V15.4H
    TBX  V5.16B, { V17.16B, V18.16B, V19.16B }, V12.16B
    INS V2.S[0x1], W26
    TBX  V14.8B, { V29.16B }, V2.8B
    BIC  V9.8B, V27.8B, V27.8B
    BIC  V22.8B, V9.8B, V5.8B
    MLS  V19.4S, V22.4S, V22.4S
    DUP  V25.8B, V21.B[0x0]
    AND  V5.16B, V25.16B, V25.16B
    SLI  V16.2S, V14.2S, #0x4
    MOVI  V12.2S, #0xe0, MSL #8
    RADDHN  V28.8B, V19.8H, V5.8H
    MOV  X8, V6.D[0x0]
    MOV  W7, V28.S[0x2]
    SHL V25.2D, V12.2D, #0x7
    DUP V27.2S, W5
    MOVI  V15.8H, #0xf
    MOV V24.H[0x6], V13.H[0x6]
    ZIP1  V13.2S, V21.2S, V15.2S
    MOV V12.S[0x2], W9
    MOVI  V22.2S, #0x35, LSL #8
    SHL  V15.4H, V13.4H, #0x2
    SHLL  V4.4S, V5.4H, #16
    SHL V5.2D, V25.2D, #0x34
    BIC  V3.16B, V13.16B, V4.16B
    MOVI  V13.4S, #0x42, MSL #8
    SHL  V21.4S, V12.4S, #0x1b
    MOV H14, V16.H[0x4]
    TBX  V4.8B, { V4.16B, V5.16B, V6.16B }, V4.8B
    ADDP  D12, V22.2D
    SHRN V19.4H, V12.4S, #14
    MOVI  V18.4H, #0x46, LSL #8
    PMUL  V25.16B, V2.16B, V3.16B
    DUP H22, V15.H[0x6]
    MOVI  V12.4S, #0x3c, MSL #16
    BSL  V6.8B, V19.8B, V13.8B
    MVNI  V5.2S, #0xc0, MSL #16
    BIC  V19.4H, #0x4c, LSL #8
    MVNI  V2.4S, #0x19, LSL #24
    MOV V3.B[0xa], W8
    SHLL  V16.2D, V3.2S, #32
    SLI  V3.4S, V2.4S, #0xb
    NEG  V15.4H, V19.4H
    UZP1  V28.2S, V25.2S, V22.2S
    PMUL  V13.16B, V4.16B, V27.16B
    SHL  V25.8B, V5.8B, #0x3
    CNT  V4.8B, V6.8B
    BIT  V6.16B, V18.16B, V16.16B
    SHL V2.2D, V21.2D, #0x1f
    MVNI  V5.4H, #0xd6
    PMULL  V27.1Q, V15.1D, V5.1D
    SLI  V5.16B, V27.16B, #0x7
    ZIP2  V18.8B, V4.8B, V25.8B
    ORR  V16.2S, #0xab, LSL #16
    RADDHN  V21.4H, V28.4S, V5.4S
    BIT  V19.8B, V3.8B, V6.8B
    INS V10.B[0xe], V13.B[0xa]
    RSHRN V27.2S, V2.2D, #8
    RBIT  V4.16B, V27.16B
    MOV H2, V19.H[0x4]
    MOV D22, V21.D[0x1]
    MLA  V13.4H, V12.4H, V2.H[0x3]
    SRI  V28.4S, V18.4S, #17
    EXT  V18.16B, V10.16B, V22.16B, #0x8
    RSHRN2 V15.16B, V13.8H, #3
    DUP B5, V16.B[0x9]
    SHLL  V27.2D, V15.2S, #32
    ADDV  B16, V4.16B
    SLI  V4.8B, V18.8B, #0x4
    INS V25.H[0x5], W2
    MOVI  V3.2D, #18374966859431608575
    DUP V6.2D, X24
    RSUBHN2  V19.16B, V27.8H, V29.8H
    SHL  V15.8H, V6.8H, #0xf
    AESE  V18.16B, V15.16B
    TBX  V15.8B, { V18.16B }, V28.8B
    SHRN V6.8B, V3.8H, #7
    DUP D12, V4.D[0x0]
    SHL V3.2D, V16.2D, #0x14
    TRN2  V29.16B, V5.16B, V3.16B
    MOV  W24, V25.S[0x1]
    MUL  V21.2S, V22.2S, V29.S[0x0]
    SHL  V5.16B, V21.16B, #0x5
    SHRN2 V25.4S, V19.2D, #5
    SHL  V22.8B, V15.8B, #0x1
    MOV V4.S[0x2], W25
    SHL  V18.2S, V6.2S, #0x12
    MOV V27.H[0x3], V12.H[0x2]
    SLI  V29.8B, V27.8B, #0x0
    CLZ  V28.8B, V29.8B
    DUP V21.4H, W16
    SHL  V12.4S, V15.4S, #0x9
    SRI  V3.4S, V5.4S, #26
    ADDP  V6.16B, V21.16B, V22.16B
    RSHRN2 V13.8H, V4.4S, #2
    MVNI  V5.8H, #0x96
    DUP  V16.2S, V25.S[0x1]
    DUP H25, V7.H[0x3]
    SHLL2  V7.8H, V18.16B, #8
    MUL  V19.8B, V25.8B, V7.8B
    SRI  V18.16B, V19.16B, #2
    ADDV  S22, V28.4S
    TBX  V27.8B, { V22.16B }, V18.8B
    TBX  V18.16B, { V29.16B, V30.16B, V31.16B }, V27.16B
    REV64  V21.2S, V18.2S
    RBIT  V15.8B, V6.8B
    CNT  V18.16B, V13.16B
    BIC  V28.2S, #0x72
    RADDHN  V13.2S, V5.2D, V16.2D
    TBL  V16.16B, { V12.16B }, V3.16B
    AESIMC  V25.16B, V15.16B
    AESMC  V19.16B, V21.16B
    MOV V3.S[0x3], W27
    ORR  V21.2S, #0x91, LSL #24
    MOVI  V4.4H, #0x48
    MVNI  V7.2S, #0xd9, LSL #16
    ZIP1  V22.2S, V7.2S, V28.2S
    NEG  V12.8H, V19.8H
    TBX  V19.8B, { V18.16B }, V12.8B
    SHL  V15.4H, V19.4H, #0x4
    INS V27.S[0x0], V16.S[0x0]
    RSHRN V5.4H, V27.4S, #11
    CLS  V29.8H, V6.8H
    REV16  V30.16B, V15.16B
    MLS  V27.8H, V13.8H, V1.H[0x4]
    EOR  V13.8B, V5.8B, V3.8B
    SUBHN2  V12.8H, V4.4S, V29.4S
    SUBHN  V29.8B, V27.8H, V25.8H
    SHRN2 V5.16B, V13.8H, #4
    SHL  V1.16B, V21.16B, #0x4
    SHLL2  V28.2D, V12.4S, #32
    INS V3.B[0x9], V22.B[0x5]
    RSHRN V7.2S, V5.2D, #26
    SRI  V19.8B, V7.8B, #3
    RSHRN V4.2S, V30.2D, #8
    DUP  V13.4H, V29.H[0x4]
    RSHRN2 V29.8H, V19.4S, #8
    BIC  V22.4S, #0x23, LSL #16
    NOT  V25.16B, V22.16B
    MOV V5.B[0x2], W18
    MOV D22, V29.D[0x1]
    DUP V27.2S, W26
    MVNI  V12.4S, #0xd, LSL #24
    ADDHN2  V29.16B, V2.8H, V25.8H
    ORN  V2.8B, V6.8B, V3.8B
    PMULL  V15.8H, V5.8B, V22.8B
    SRI V25.2D, V15.2D, #35
    SHL  V6.8H, V1.8H, #0xd
    SHRN V21.4H, V13.4S, #8
    SHL V15.2D, V6.2D, #0x14
    EXT  V7.16B, V4.16B, V21.16B, #0x0
    INS V3.D[0x0], X23
    TRN1  V19.8B, V25.8B, V2.8B
    INS V6.D[0x1], V12.D[0x1]
    DUP  V13.16B, V28.B[0x1]
    MOV H21, V27.H[0x0]
    MOV S1, V21.S[0x0]
    UZP1  V28.8H, V29.8H, V7.8H
    BIF  V5.8B, V15.8B, V15.8B
    SHLL  V7.2D, V1.2S, #32
    INS V12.S[0x0], V19.S[0x1]
    MLA  V29.16B, V28.16B, V28.16B
    BIC  V4.8B, V13.8B, V6.8B
    SUBS  X10, X10, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_12
    MOVZ  X11, #0x79d0, LSL #0
    MOVK  X11, #0x68e6, LSL #16
    MOVK  X11, #0xa10a, LSL #32
    MOVK  X11, #0xab24, LSL #48
    SUB  X4, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xf032, LSL #0
    MOVK  X11, #0xd446, LSL #16
    MOVK  X11, #0xb1aa, LSL #32
    MOVK  X11, #0x8f95, LSL #48
    SUB  X4, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x5413, LSL #0
    MOVK  X11, #0x3d32, LSL #16
    MOVK  X11, #0x1340, LSL #32
    MOVK  X11, #0x7743, LSL #48
    SUB  X4, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x18c2, LSL #0
    MOVK  X11, #0x560c, LSL #16
    MOVK  X11, #0x3583, LSL #32
    MOVK  X11, #0x81df, LSL #48
    SUB  X4, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xf0c7, LSL #0
    MOVK  X11, #0x9b24, LSL #16
    MOVK  X11, #0x9d75, LSL #32
    MOVK  X11, #0xbd7f, LSL #48
    SUB  X4, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xa897, LSL #0
    MOVK  X11, #0x587f, LSL #16
    MOVK  X11, #0xf0c1, LSL #32
    MOVK  X11, #0xa7ce, LSL #48
    SUB  X4, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xb571, LSL #0
    MOVK  X11, #0xb3f, LSL #16
    MOVK  X11, #0x69f2, LSL #32
    MOVK  X11, #0x52d4, LSL #48
    SUB  X4, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x625b, LSL #0
    MOVK  X11, #0x6217, LSL #16
    MOVK  X11, #0xa0b9, LSL #32
    MOVK  X11, #0x1af3, LSL #48
    SUB  X4, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xc6b0, LSL #0
    MOVK  X11, #0x6f59, LSL #16
    MOVK  X11, #0x1492, LSL #32
    MOVK  X11, #0xfe, LSL #48
    SUB  X4, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xccb9, LSL #0
    MOVK  X11, #0x7b61, LSL #16
    MOVK  X11, #0x6f06, LSL #32
    MOVK  X11, #0x34b4, LSL #48
    SUB  X4, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xde6f, LSL #0
    MOVK  X11, #0xbe5a, LSL #16
    MOVK  X11, #0xe4fb, LSL #32
    MOVK  X11, #0xc7fe, LSL #48
    SUB  X4, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xe00, LSL #0
    MOVK  X11, #0x4f82, LSL #16
    MOVK  X11, #0x1675, LSL #32
    MOVK  X11, #0xcd72, LSL #48
    SUB  X4, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x55e5, LSL #0
    MOVK  X11, #0xaba, LSL #16
    MOVK  X11, #0xf86e, LSL #32
    MOVK  X11, #0x3077, LSL #48
    SUB  X4, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xf8f8, LSL #16
    SUB  X4, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x81ff, LSL #0
    MOVK  X11, #0xae47, LSL #16
    MOVK  X11, #0xb3b2, LSL #32
    MOVK  X11, #0xcee, LSL #48
    SUB  X4, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x94fd, LSL #0
    MOVK  X11, #0xc931, LSL #16
    MOVK  X11, #0x8c0d, LSL #32
    MOVK  X11, #0x3aa1, LSL #48
    SUB  X4, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xd14f, LSL #0
    MOVK  X11, #0x9fb, LSL #16
    MOVK  X11, #0x13d6, LSL #32
    MOVK  X11, #0xdc7d, LSL #48
    SUB  X4, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x263a, LSL #0
    MOVK  X11, #0x4fc1, LSL #16
    MOVK  X11, #0xef7a, LSL #32
    MOVK  X11, #0xde92, LSL #48
    SUB  X4, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    MRS  X4, FPSR
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x263a, LSL #0
    MOVK  X11, #0x4fc1, LSL #16
    MOVK  X11, #0xef7a, LSL #32
    MOVK  X11, #0xde92, LSL #48
    FMOV  X4, V0.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xde2d, LSL #0
    MOVK  X11, #0xc9a, LSL #16
    MOVK  X11, #0x6a21, LSL #32
    MOVK  X11, #0x7194, LSL #48
    FMOV  X4, D0
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V1.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x94fd, LSL #0
    FMOV  X4, D1
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V2.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    FMOV  X4, D2
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x800, LSL #0
    MOVK  X11, #0xd14f, LSL #32
    MOVK  X11, #0x9fb, LSL #48
    FMOV  X4, V3.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x55e5, LSL #0
    MOVK  X11, #0xaba, LSL #16
    MOVK  X11, #0xf86e, LSL #32
    MOVK  X11, #0x3077, LSL #48
    FMOV  X4, D3
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V4.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D4
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V5.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D5
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xf2ff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xf2ff, LSL #48
    FMOV  X4, V6.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D6
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V7.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x94fd, LSL #32
    FMOV  X4, D7
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xf0c7, LSL #0
    MOVK  X11, #0x9b24, LSL #16
    MOVK  X11, #0x9d75, LSL #32
    MOVK  X11, #0xbd7f, LSL #48
    FMOV  X4, V8.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x81ff, LSL #0
    MOVK  X11, #0xae47, LSL #16
    MOVK  X11, #0xb3b2, LSL #32
    MOVK  X11, #0xcee, LSL #48
    FMOV  X4, D8
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V9.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D9
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xde6f, LSL #0
    MOVK  X11, #0xbe5a, LSL #16
    MOVK  X11, #0xe4fb, LSL #32
    MOVK  X11, #0xc700, LSL #48
    FMOV  X4, V10.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x625b, LSL #0
    MOVK  X11, #0x6217, LSL #16
    MOVK  X11, #0xa0b9, LSL #32
    MOVK  X11, #0x1af3, LSL #48
    FMOV  X4, D10
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x5413, LSL #0
    MOVK  X11, #0x3d32, LSL #16
    MOVK  X11, #0x1340, LSL #32
    MOVK  X11, #0x7743, LSL #48
    FMOV  X4, V11.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xde6f, LSL #0
    MOVK  X11, #0xbe5a, LSL #16
    MOVK  X11, #0xe4fb, LSL #32
    MOVK  X11, #0xc7fe, LSL #48
    FMOV  X4, D11
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xf2ff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xf2ff, LSL #48
    FMOV  X4, V12.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xfff7, LSL #0
    MOVK  X11, #0xfff7, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xf2ff, LSL #48
    FMOV  X4, D12
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V13.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D13
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V14.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D14
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V15.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D15
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V16.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D16
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x800, LSL #16
    FMOV  X4, V17.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xdec0, LSL #0
    MOVK  X11, #0x108, LSL #16
    MOVK  X11, #0xf05, LSL #32
    MOVK  X11, #0x4c04, LSL #48
    FMOV  X4, D17
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x304, LSL #0
    MOVK  X11, #0x103, LSL #16
    MOVK  X11, #0x301, LSL #32
    FMOV  X4, V18.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x304, LSL #16
    MOVK  X11, #0x304, LSL #48
    FMOV  X4, D18
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V19.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xff00, LSL #0
    MOVK  X11, #0xff00, LSL #16
    MOVK  X11, #0xfff7, LSL #32
    MOVK  X11, #0xfff7, LSL #48
    FMOV  X4, D19
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x625b, LSL #0
    MOVK  X11, #0x6217, LSL #16
    MOVK  X11, #0xa0b9, LSL #32
    MOVK  X11, #0x1af3, LSL #48
    FMOV  X4, V20.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xccb9, LSL #0
    MOVK  X11, #0x7b61, LSL #16
    MOVK  X11, #0x6f06, LSL #32
    MOVK  X11, #0x34b4, LSL #48
    FMOV  X4, D20
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V21.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x94fd, LSL #0
    FMOV  X4, D21
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V22.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x40c1, LSL #0
    FMOV  X4, D22
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xb571, LSL #0
    MOVK  X11, #0xb3f, LSL #16
    MOVK  X11, #0x69f2, LSL #32
    MOVK  X11, #0x52d4, LSL #48
    FMOV  X4, V23.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x606, LSL #0
    MOVK  X11, #0xb493, LSL #16
    MOVK  X11, #0x8c56, LSL #32
    MOVK  X11, #0x7286, LSL #48
    FMOV  X4, D23
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xffff, LSL #32
    FMOV  X4, V24.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x400, LSL #0
    MOVK  X11, #0x3d00, LSL #16
    MOVK  X11, #0xa275, LSL #32
    MOVK  X11, #0x1718, LSL #48
    FMOV  X4, D24
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xe000, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    FMOV  X4, V25.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xf7f7, LSL #32
    MOVK  X11, #0xf7f7, LSL #48
    FMOV  X4, D25
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xccb9, LSL #0
    MOVK  X11, #0x7b61, LSL #16
    MOVK  X11, #0x6f06, LSL #32
    MOVK  X11, #0x34b4, LSL #48
    FMOV  X4, V26.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xd77a, LSL #0
    MOVK  X11, #0xcd0b, LSL #16
    MOVK  X11, #0x9d3e, LSL #32
    MOVK  X11, #0xdaef, LSL #48
    FMOV  X4, D26
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V27.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x94fd, LSL #0
    MOVK  X11, #0xc931, LSL #16
    MOVK  X11, #0x94fd, LSL #32
    MOVK  X11, #0xc931, LSL #48
    FMOV  X4, D27
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xb500, LSL #0
    FMOV  X4, V28.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x9b9b, LSL #0
    MOVK  X11, #0xffff, LSL #48
    FMOV  X4, D28
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xf900, LSL #0
    MOVK  X11, #0xf7f7, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    FMOV  X4, V29.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x7474, LSL #0
    MOVK  X11, #0x4010, LSL #16
    MOVK  X11, #0x101, LSL #48
    FMOV  X4, D29
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V30.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xc, LSL #0
    MOVK  X11, #0xb0b5, LSL #16
    FMOV  X4, D30
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xd77a, LSL #0
    MOVK  X11, #0xcd0b, LSL #16
    MOVK  X11, #0x9d3e, LSL #32
    MOVK  X11, #0xdaef, LSL #48
    FMOV  X4, V31.D[1]
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X11, #0xf0c7, LSL #0
    MOVK  X11, #0x9b24, LSL #16
    MOVK  X11, #0x9d75, LSL #32
    MOVK  X11, #0xbd7f, LSL #48
    FMOV  X4, D31
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    FMOV  D0, X27
    FMOV  V0.D[1], X28
    FMOV  D1, X26
    FMOV  V1.D[1], X24
    FMOV  D2, X25
    FMOV  V2.D[1], X21
    FMOV  D3, X20
    FMOV  V3.D[1], X18
    FMOV  D4, X6
    FMOV  V4.D[1], X17
    FMOV  D5, X19
    FMOV  V5.D[1], X23
    FMOV  D6, X16
    FMOV  V6.D[1], X10
    FMOV  D7, X5
    FMOV  V7.D[1], X18
    FMOV  D8, X19
    FMOV  V8.D[1], X25
    FMOV  D9, X13
    FMOV  V9.D[1], X7
    FMOV  D10, X16
    FMOV  V10.D[1], X16
    FMOV  D11, X10
    FMOV  V11.D[1], X13
    FMOV  D12, X24
    FMOV  V12.D[1], X2
    FMOV  D13, X10
    FMOV  V13.D[1], X9
    FMOV  D14, X25
    FMOV  V14.D[1], X6
    FMOV  D15, X27
    FMOV  V15.D[1], X7
    FMOV  D16, X8
    FMOV  V16.D[1], X7
    FMOV  D17, X25
    FMOV  V17.D[1], X8
    FMOV  D18, X25
    FMOV  V18.D[1], X6
    FMOV  D19, X2
    FMOV  V19.D[1], X13
    FMOV  D20, X27
    FMOV  V20.D[1], X27
    FMOV  D21, X13
    FMOV  V21.D[1], X14
    FMOV  D22, X10
    FMOV  V22.D[1], X8
    FMOV  D23, X19
    FMOV  V23.D[1], X20
    FMOV  D24, X5
    FMOV  V24.D[1], X20
    FMOV  D25, X4
    FMOV  V25.D[1], X11
    FMOV  D26, X4
    FMOV  V26.D[1], X13
    FMOV  D27, X20
    FMOV  V27.D[1], X10
    FMOV  D28, X17
    FMOV  V28.D[1], X26
    FMOV  D29, X4
    FMOV  V29.D[1], X8
    FMOV  D30, X18
    FMOV  V30.D[1], X5
    FMOV  D31, X2
    FMOV  V31.D[1], X4
    MOVZ  X17, #0xf, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_13:
    MOVI  V21.2D, #72056494526300415
    EXT  V10.8B, V31.8B, V25.8B, #0x2
    SRI  V6.2S, V30.2S, #8
    RSHRN V12.2S, V10.2D, #27
    AESD  V2.16B, V22.16B
    DUP  V0.8B, V26.B[0xc]
    SLI  V22.4H, V28.4H, #0xa
    DUP  V10.4H, V27.H[0x3]
    ZIP2  V13.4H, V22.4H, V21.4H
    INS V31.D[0x0], X5
    MOV V24.D[0x1], X15
    SRI  V14.4H, V6.4H, #3
    SHL V3.2D, V29.2D, #0x1e
    AESMC  V18.16B, V10.16B
    TBL  V19.16B, { V12.16B, V13.16B }, V3.16B
    TBL  V30.16B, { V8.16B }, V19.16B
    MOVI  V11.4H, #0x6f
    RSHRN V3.4H, V18.4S, #4
    SRI  V25.8B, V24.8B, #1
    SHLL  V5.2D, V31.2S, #32
    ZIP1  V12.4S, V14.4S, V30.4S
    RADDHN2  V18.16B, V27.8H, V8.8H
    EXT  V19.16B, V22.16B, V25.16B, #0x6
    RSHRN V6.2S, V11.2D, #3
    TBX  V24.8B, { V14.16B, V15.16B }, V0.8B
    MOV  X5, V3.D[0x0]
    ADD  V30.2D, V24.2D, V12.2D
    EXT  V24.16B, V2.16B, V30.16B, #0x1
    SLI  V29.16B, V24.16B, #0x7
    INS V31.B[0xa], W16
    MOV  W15, V5.S[0x1]
    MOV  V12.8B, V6.8B
    TRN1  V30.2S, V12.2S, V18.2S
    BIF  V8.8B, V30.8B, V19.8B
    TBX  V5.8B, { V8.16B }, V29.8B
    DUP V8.2D, V5.D[0x1]
    DUP  V13.16B, V31.B[0x3]
    TBL  V24.8B, { V9.16B, V10.16B }, V8.8B
    MOV H15, V13.H[0x6]
    RSUBHN  V2.4H, V15.4S, V24.4S
    MOV S18, V4.S[0x0]
    RSHRN2 V25.8H, V9.4S, #3
    ADDHN  V29.4H, V8.4S, V24.4S
    MOV V24.D[0x1], V4.D[0x0]
    AESE  V6.16B, V25.16B
    SHLL  V9.8H, V27.8B, #8
    AESIMC  V19.16B, V1.16B
    MUL  V30.2S, V8.2S, V15.S[0x0]
    PMULL2  V4.8H, V24.16B, V2.16B
    XTN2  V24.8H, V12.4S
    MOVI  V1.2D, #18446744069414649855
    DUP S22, V6.S[0x0]
    MVNI  V6.4S, #0x24, MSL #16
    MOV V25.S[0x1], V24.S[0x2]
    MVNI  V8.4S, #0x74, LSL #8
    MOV V13.S[0x1], V1.S[0x1]
    BSL  V24.8B, V19.8B, V29.8B
    INS V12.D[0x0], V4.D[0x0]
    BIC  V2.4S, #0x18, LSL #24
    AESD  V1.16B, V30.16B
    DUP V31.8H, W26
    MOVI  V29.4H, #0xed, LSL #8
    MLA  V30.8B, V22.8B, V2.8B
    DUP B2, V9.B[0x2]
    DUP B19, V12.B[0x4]
    XTN2  V4.16B, V13.8H
    TBL  V22.8B, { V4.16B, V5.16B, V6.16B, V7.16B }, V6.8B
    ZIP2  V15.2D, V25.2D, V22.2D
    MLS  V25.2S, V30.2S, V24.S[0x3]
    SRI V27.2D, V18.2D, #26
    REV32  V7.8B, V15.8B
    SHRN2 V25.8H, V2.4S, #5
    TBL  V2.8B, { V4.16B, V5.16B, V6.16B }, V3.8B
    ADDV  B18, V27.16B
    SLI  V25.8H, V25.8H, #0x0
    RADDHN2  V5.4S, V29.2D, V25.2D
    SHL  V29.16B, V1.16B, #0x2
    MOV S15, V5.S[0x0]
    TBL  V25.16B, { V21.16B, V22.16B, V23.16B }, V29.16B
    MOV H29, V18.H[0x4]
    MOV  X13, V2.D[0x1]
    SHL  V9.16B, V8.16B, #0x5
    XTN2  V28.8H, V9.4S
    DUP V18.2D, V28.D[0x0]
    NOT  V9.16B, V15.16B
    SLI V3.2D, V7.2D, #0x26
    SUB  V2.16B, V25.16B, V18.16B
    SHL  V24.8B, V9.8B, #0x3
    SUB  V4.2D, V29.2D, V3.2D
    SRI  V25.4S, V24.4S, #26
    TBL  V1.8B, { V25.16B }, V2.8B
    SHLL  V9.2D, V1.2S, #32
    BIC  V6.4H, #0x51, LSL #8
    AESMC  V27.16B, V4.16B
    BIC  V18.8H, #0x9f
    RSHRN V2.2S, V18.2D, #3
    SLI  V18.2S, V26.2S, #0x12
    EXT  V3.16B, V8.16B, V18.16B, #0x6
    TBX  V4.8B, { V3.16B, V4.16B, V5.16B }, V6.8B
    EXT  V5.8B, V4.8B, V27.8B, #0x3
    UZP1  V21.16B, V2.16B, V9.16B
    INS V8.S[0x1], V21.S[0x2]
    INS V23.H[0x6], V8.H[0x5]
    MOVI  V22.2S, #0xec, MSL #8
    MLS  V1.8H, V23.8H, V22.8H
    DUP V8.2D, V1.D[0x0]
    ZIP2  V29.8B, V8.8B, V8.8B
    INS V25.S[0x1], W13
    TBX  V23.16B, { V25.16B }, V29.16B
    RSHRN V22.4H, V5.4S, #8
    SHRN V26.4H, V22.4S, #11
    MLS  V9.4H, V26.4H, V15.H[0x7]
    ADD  V26.4H, V23.4H, V9.4H
    SRI  V1.16B, V5.16B, #6
    TBL  V7.16B, { V28.16B, V29.16B, V30.16B }, V25.16B
    BIC  V24.4H, #0xc3, LSL #8
    MLA  V21.8H, V19.8H, V6.8H
    SHRN2 V6.8H, V14.4S, #16
    XTN  V8.8B, V13.8H
    INS V19.B[0x1], W27
    ADDHN2  V14.4S, V8.2D, V22.2D
    CNT  V25.8B, V24.8B
    RSUBHN  V9.4H, V20.4S, V18.4S
    RSHRN V15.4H, V7.4S, #7
    SLI  V20.4S, V26.4S, #0xc
    INS V24.D[0x1], V1.D[0x0]
    SRI  V18.2S, V6.2S, #1
    SHRN V2.8B, V21.8H, #6
    AND  V1.8B, V2.8B, V9.8B
    MOVI  V7.4H, #0xc
    SHLL2  V23.8H, V25.16B, #8
    SLI V25.2D, V18.2D, #0x25
    DUP D8, V15.D[0x0]
    SHRN2 V4.8H, V20.4S, #12
    AND  V26.8B, V8.8B, V19.8B
    MOV  V20.8B, V4.8B
    BSL  V4.8B, V24.8B, V1.8B
    RSHRN2 V22.16B, V23.8H, #7
    AESE  V6.16B, V7.16B
    INS V15.S[0x0], W26
    MOV D13, V14.D[0x1]
    SRI  V1.4S, V22.4S, #26
    PMULL2  V29.1Q, V4.2D, V4.2D
    TRN1  V23.4H, V1.4H, V25.4H
    MLS  V2.2S, V6.2S, V26.S[0x0]
    EOR  V18.8B, V23.8B, V20.8B
    RSHRN2 V19.16B, V2.8H, #5
    PMUL  V1.8B, V19.8B, V29.8B
    MUL  V24.2S, V15.2S, V1.S[0x2]
    CNT  V23.8B, V13.8B
    ADDP  D14, V18.2D
    MLS  V8.8H, V14.8H, V24.8H
    ADD  V21.2S, V23.2S, V23.2S
    MLA  V22.8H, V21.8H, V8.H[0x6]
    SLI V15.2D, V26.2D, #0x2e
    ZIP2  V19.4S, V20.4S, V5.4S
    XTN2  V4.8H, V9.4S
    EOR  V7.8B, V6.8B, V23.8B
    XTN  V26.4H, V1.4S
    SHRN2 V21.8H, V10.4S, #4
    ADD  V8.4H, V9.4H, V4.4H
    RSHRN2 V25.16B, V23.8H, #8
    TBL  V2.16B, { V8.16B, V9.16B, V10.16B, V11.16B }, V6.16B
    RSHRN V29.8B, V6.8H, #7
    SLI  V4.4S, V29.4S, #0x4
    SHL  V14.4S, V4.4S, #0xc
    MVNI  V6.4S, #0x21, LSL #24
    MOV D29, V6.D[0x0]
    DUP H9, V21.H[0x0]
    SLI  V13.16B, V22.16B, #0x4
    ADDHN  V23.8B, V25.8H, V13.8H
    MOVI  V20.2S, #0xd3, LSL #16
    DUP V13.2D, X2
    XTN  V25.8B, V15.8H
    BIC  V11.2S, #0x84
    MVNI  V10.2S, #0x23, MSL #8
    MOVI  V6.8H, #0x17, LSL #8
    MLS  V15.16B, V14.16B, V14.16B
    SLI  V14.8H, V29.8H, #0x5
    CLS  V22.2S, V2.2S
    DUP V29.8H, W11
    RSHRN2 V4.4S, V15.2D, #16
    MVNI  V8.4S, #0x5c, MSL #8
    MLA  V21.4S, V8.4S, V9.4S
    EXT  V8.16B, V22.16B, V21.16B, #0xf
    MLS  V5.8H, V23.8H, V8.H[0x2]
    AESMC  V8.16B, V20.16B
    MOV V9.B[0x2], V26.B[0xf]
    ADDP  V21.8B, V10.8B, V0.8B
    RSUBHN  V15.2S, V11.2D, V6.2D
    MUL  V10.8H, V15.8H, V15.H[0x5]
    SLI  V2.4S, V13.4S, #0x1e
    INS V22.S[0x1], V9.S[0x2]
    MOV V23.B[0x0], W8
    EOR  V9.16B, V23.16B, V4.16B
    MLA  V6.4H, V21.4H, V14.H[0x4]
    SRI V13.2D, V22.2D, #6
    CNT  V22.16B, V29.16B
    ADDHN  V26.2S, V5.2D, V6.2D
    RADDHN  V11.2S, V2.2D, V25.2D
    SUBS  X17, X17, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_13
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x7b2f, LSL #0
    MOVK  X10, #0x7b2f, LSL #16
    SUB  X18, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xd69f, LSL #0
    MOVK  X10, #0xd69f, LSL #16
    SUB  X18, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MRS  X18, FPSR
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, V0.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, D0
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, V1.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, D1
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x3800, LSL #48
    FMOV  X18, V2.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x3800, LSL #32
    FMOV  X18, D2
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x1e58, LSL #32
    FMOV  X18, V3.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x8bff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0x8bff, LSL #48
    FMOV  X18, D3
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xc0c0, LSL #0
    FMOV  X18, V4.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x8c88, LSL #0
    MOVK  X10, #0x94cc, LSL #16
    MOVK  X10, #0x8c68, LSL #32
    MOVK  X10, #0xac7c, LSL #48
    FMOV  X18, D4
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, V5.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xf55a, LSL #0
    MOVK  X10, #0xeff, LSL #16
    MOVK  X10, #0x7a80, LSL #32
    MOVK  X10, #0x792d, LSL #48
    FMOV  X18, D5
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, V6.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x1700, LSL #0
    MOVK  X10, #0x1700, LSL #16
    MOVK  X10, #0x1700, LSL #32
    MOVK  X10, #0x1700, LSL #48
    FMOV  X18, D6
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, V7.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x66f8, LSL #0
    MOVK  X10, #0x66e4, LSL #16
    MOVK  X10, #0x25fe, LSL #32
    MOVK  X10, #0xe463, LSL #48
    FMOV  X18, D7
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, V8.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x6ed3, LSL #0
    MOVK  X10, #0xd3bd, LSL #16
    MOVK  X10, #0x6ed3, LSL #32
    MOVK  X10, #0xd3bd, LSL #48
    FMOV  X18, D8
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xc0c0, LSL #0
    FMOV  X18, V9.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x5b88, LSL #0
    MOVK  X10, #0x79cc, LSL #16
    MOVK  X10, #0x8c6d, LSL #32
    MOVK  X10, #0xac7c, LSL #48
    FMOV  X18, D9
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, V10.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, D10
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, V11.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x3800, LSL #0
    MOVK  X10, #0x3800, LSL #48
    FMOV  X18, D11
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, V12.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, D12
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, V13.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, D13
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, V14.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffe0, LSL #0
    MOVK  X10, #0xdfe8, LSL #16
    MOVK  X10, #0xffe0, LSL #32
    MOVK  X10, #0xdfe6, LSL #48
    FMOV  X18, D14
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, V15.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xe96b, LSL #0
    MOVK  X10, #0xe96e, LSL #16
    MOVK  X10, #0xe900, LSL #32
    MOVK  X10, #0xe8ff, LSL #48
    FMOV  X18, D15
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, V16.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, D16
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, V17.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, D17
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, V18.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xfff4, LSL #0
    MOVK  X10, #0x85d2, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0x9e99, LSL #48
    FMOV  X18, D18
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, V19.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, D19
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, V20.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xd3, LSL #16
    MOVK  X10, #0xd3, LSL #48
    FMOV  X18, D20
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, V21.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xfedc, LSL #0
    MOVK  X10, #0xfedc, LSL #16
    FMOV  X18, D21
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, V22.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, D22
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, V23.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xd700, LSL #0
    MOVK  X10, #0xed00, LSL #16
    MOVK  X10, #0x5, LSL #32
    FMOV  X18, D23
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, V24.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, D24
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, V25.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, D25
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, V26.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x9180, LSL #0
    MOVK  X10, #0x902d, LSL #16
    FMOV  X18, D26
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, V27.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x2d7a, LSL #0
    MOVK  X10, #0x2f79, LSL #16
    MOVK  X10, #0xb3d1, LSL #32
    MOVK  X10, #0xfabe, LSL #48
    FMOV  X18, D27
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x60e0, LSL #0
    MOVK  X10, #0x60e0, LSL #16
    MOVK  X10, #0x60e0, LSL #32
    MOVK  X10, #0x60e0, LSL #48
    FMOV  X18, V28.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, D28
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, V29.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, D29
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, V30.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x528, LSL #0
    MOVK  X10, #0xd53b, LSL #16
    FMOV  X18, D30
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, V31.D[1]
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X18, D31
    SUB  X28, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
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
    FMOV  D0, X24
    FMOV  V0.D[1], X28
    FMOV  D1, X27
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X17
    FMOV  D3, X4
    FMOV  V3.D[1], X27
    FMOV  D4, X26
    FMOV  V4.D[1], X2
    FMOV  D5, X28
    FMOV  V5.D[1], X17
    FMOV  D6, X2
    FMOV  V6.D[1], X17
    FMOV  D7, X16
    FMOV  V7.D[1], X9
    FMOV  D8, X19
    FMOV  V8.D[1], X24
    FMOV  D9, X28
    FMOV  V9.D[1], X27
    FMOV  D10, X15
    FMOV  V10.D[1], X28
    FMOV  D11, X23
    FMOV  V11.D[1], X19
    FMOV  D12, X18
    FMOV  V12.D[1], X13
    FMOV  D13, X14
    FMOV  V13.D[1], X14
    FMOV  D14, X15
    FMOV  V14.D[1], X14
    FMOV  D15, X24
    FMOV  V15.D[1], X25
    FMOV  D16, X6
    FMOV  V16.D[1], X18
    FMOV  D17, X19
    FMOV  V17.D[1], X2
    FMOV  D18, X25
    FMOV  V18.D[1], X4
    FMOV  D19, X6
    FMOV  V19.D[1], X17
    FMOV  D20, X26
    FMOV  V20.D[1], X28
    FMOV  D21, X5
    FMOV  V21.D[1], X16
    FMOV  D22, X25
    FMOV  V22.D[1], X25
    FMOV  D23, X15
    FMOV  V23.D[1], X5
    FMOV  D24, X11
    FMOV  V24.D[1], X26
    FMOV  D25, X26
    FMOV  V25.D[1], X2
    FMOV  D26, X8
    FMOV  V26.D[1], X5
    FMOV  D27, X18
    FMOV  V27.D[1], X26
    FMOV  D28, X16
    FMOV  V28.D[1], X26
    FMOV  D29, X17
    FMOV  V29.D[1], X18
    FMOV  D30, X28
    FMOV  V30.D[1], X20
    FMOV  D31, X25
    FMOV  V31.D[1], X19
    MOVZ  X10, #0xf, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_14:
    RADDHN  V6.4H, V28.4S, V28.4S
    MVNI  V20.4S, #0x69
    REV32  V23.8B, V6.8B
    SRI  V3.2S, V25.2S, #28
    SRI  V17.16B, V19.16B, #5
    INS V25.D[0x1], V21.D[0x1]
    MUL  V28.8H, V25.8H, V3.H[0x1]
    ORN  V14.16B, V31.16B, V31.16B
    ZIP1  V21.2D, V20.2D, V27.2D
    DUP B17, V24.B[0xe]
    ADDV  S29, V29.4S
    INS V5.S[0x0], W2
    MOV  W2, V30.S[0x2]
    CLS  V4.4S, V23.4S
    SRI  V29.4H, V28.4H, #16
    SHLL  V31.8H, V21.8B, #8
    INS V30.H[0x7], V17.H[0x3]
    MOV V30.D[0x1], V30.D[0x1]
    INS V19.H[0x0], V4.H[0x4]
    SHL V3.2D, V14.2D, #0x2c
    MLS  V30.4S, V19.4S, V30.S[0x3]
    TRN2  V26.8H, V30.8H, V5.8H
    EOR  V22.16B, V31.16B, V26.16B
    DUP V23.2D, V22.D[0x0]
    MOV  V19.8B, V29.8B
    MOV S28, V9.S[0x0]
    MOV V21.D[0x0], X9
    SRI  V25.4S, V21.4S, #32
    SHRN2 V29.8H, V28.4S, #12
    TBL  V27.8B, { V6.16B, V7.16B, V8.16B }, V29.8B
    CLZ  V26.16B, V27.16B
    SHRN2 V8.8H, V3.4S, #7
    TRN2  V20.8B, V23.8B, V25.8B
    RSHRN2 V9.8H, V20.4S, #4
    ADDHN2  V17.4S, V19.2D, V9.2D
    ADD  V21.4S, V6.4S, V26.4S
    MOV V28.D[0x0], V8.D[0x1]
    ORR  V6.8H, #0xc8, LSL #8
    INS V30.S[0x1], V6.S[0x1]
    PMULL2  V22.8H, V17.16B, V30.16B
    RBIT  V8.8B, V28.8B
    INS V30.D[0x1], X9
    CLS  V5.16B, V30.16B
    ADDP  V26.16B, V5.16B, V5.16B
    DUP  V30.2S, V21.S[0x0]
    MOV B7, V30.B[0x9]
    REV64  V29.2S, V26.2S
    INS V21.S[0x1], W5
    RSUBHN2  V26.16B, V7.8H, V21.8H
    AESIMC  V6.16B, V25.16B
    BIC  V20.4S, #0x3a
    DUP  V19.4H, V29.H[0x4]
    MOVI  V17.4S, #0xe3, MSL #16
    SHL  V29.4H, V8.4H, #0x1
    CNT  V28.16B, V17.16B
    SLI V9.2D, V29.2D, #0xf
    MOV H25, V22.H[0x2]
    SHL  V5.8B, V9.8B, #0x1
    BIC  V8.16B, V5.16B, V28.16B
    MVNI  V17.4H, #0x96, LSL #8
    ORR  V27.4S, #0x6f, LSL #16
    MUL  V30.4S, V27.4S, V8.S[0x3]
    REV64  V9.8B, V19.8B
    MOV V7.H[0x7], W11
    SUB  V29.16B, V7.16B, V17.16B
    BIC  V8.4H, #0xc7
    MOV S21, V26.S[0x0]
    MOV V28.H[0x0], V6.H[0x0]
    MLS  V27.4S, V20.4S, V8.S[0x3]
    SHL V5.2D, V25.2D, #0x35
    SHRN V22.2S, V5.2D, #25
    MOV  V19.16B, V22.16B
    MOV V8.D[0x1], X5
    SHRN2 V25.4S, V14.2D, #19
    DUP V14.16B, W17
    ADDHN2  V22.4S, V8.2D, V27.2D
    SHRN V20.8B, V25.8H, #5
    BIC  V23.4S, #0xa7, LSL #8
    CLS  V7.2S, V19.2S
    SRI  V6.8B, V4.8B, #3
    TBL  V8.8B, { V20.16B, V21.16B, V22.16B, V23.16B }, V20.8B
    RSHRN2 V22.8H, V6.4S, #9
    AESIMC  V4.16B, V28.16B
    MUL  V17.2S, V4.2S, V29.S[0x1]
    INS V26.D[0x0], V8.D[0x1]
    CLS  V8.8B, V17.8B
    AESE  V19.16B, V14.16B
    MOVI  V27.4S, #0xf4, LSL #24
    RBIT  V25.8B, V27.8B
    REV16  V27.16B, V22.16B
    RSHRN2 V23.4S, V27.2D, #8
    ZIP2  V14.16B, V25.16B, V23.16B
    RSHRN V21.4H, V26.4S, #15
    DUP H22, V21.H[0x2]
    ADDP  D25, V19.2D
    RADDHN  V28.8B, V8.8H, V22.8H
    SHLL2  V5.2D, V7.4S, #32
    EXT  V20.8B, V5.8B, V14.8B, #0x2
    ZIP2  V17.2D, V20.2D, V25.2D
    BIC  V29.8B, V17.8B, V8.8B
    SRI  V5.4S, V28.4S, #13
    MLA  V25.4S, V29.4S, V5.S[0x0]
    SUBHN  V5.4H, V24.4S, V0.4S
    DUP  V21.16B, V3.B[0xb]
    REV32  V8.4H, V6.4H
    MLS  V22.4H, V17.4H, V9.4H
    BIC  V9.8B, V10.8B, V9.8B
    TRN2  V10.2S, V10.2S, V11.2S
    INS V7.H[0x7], V19.H[0x1]
    XTN2  V27.16B, V7.8H
    TBL  V14.8B, { V16.16B, V17.16B, V18.16B }, V27.8B
    ADD  V4.4S, V19.4S, V0.4S
    MVNI  V11.4S, #0xb4, MSL #8
    SRI  V3.4H, V25.4H, #13
    SHRN V19.8B, V10.8H, #8
    SHLL  V29.8H, V14.8B, #8
    DUP  V28.16B, V3.B[0x3]
    NEG  V0.8H, V5.8H
    EXT  V10.8B, V0.8B, V19.8B, #0x4
    AESIMC  V20.16B, V22.16B
    MOV V27.D[0x1], V20.D[0x1]
    SRI  V16.16B, V27.16B, #5
    CNT  V17.16B, V29.16B
    SHL  V6.2S, V4.2S, #0xb
    MUL  V19.2S, V11.2S, V16.S[0x2]
    RADDHN  V7.4H, V6.4S, V17.4S
    MUL  V25.2S, V19.2S, V28.2S
    DUP V24.2D, V7.D[0x0]
    MOV D12, V24.D[0x0]
    SHRN2 V18.4S, V12.2D, #12
    XTN  V26.8B, V18.8H
    MOV S3, V25.S[0x2]
    RSHRN2 V0.8H, V10.4S, #14
    TBX  V20.8B, { V11.16B, V12.16B }, V26.8B
    DUP V24.2D, X14
    DUP H28, V24.H[0x1]
    BSL  V7.16B, V3.16B, V20.16B
    SLI V12.2D, V28.2D, #0x8
    DUP V5.2S, W5
    EXT  V18.8B, V12.8B, V0.8B, #0x4
    SLI V25.2D, V5.2D, #0x38
    MOVI  V6.8H, #0x7b, LSL #8
    DUP V26.2S, W25
    TBX  V17.16B, { V7.16B }, V26.16B
    TRN1  V20.4S, V17.4S, V25.4S
    BIC  V19.2S, #0xca, LSL #24
    EXT  V10.8B, V20.8B, V6.8B, #0x2
    TRN1  V11.8H, V10.8H, V18.8H
    MOV  X17, V19.D[0x1]
    UZP2  V12.2S, V2.2S, V8.2S
    RSHRN V25.8B, V30.8H, #4
    MOV V3.S[0x0], V12.S[0x2]
    MOV V29.H[0x5], W11
    MOV V17.H[0x4], V4.H[0x2]
    DUP S4, V26.S[0x1]
    ORR  V15.4S, #0xc9
    SRI  V26.8H, V8.8H, #8
    RADDHN2  V6.16B, V28.8H, V0.8H
    MUL  V19.2S, V3.2S, V3.S[0x1]
    TBL  V24.8B, { V10.16B, V11.16B, V12.16B, V13.16B }, V26.8B
    XTN  V30.8B, V6.8H
    MOV H7, V19.H[0x4]
    DUP H3, V29.H[0x4]
    BIC  V8.4S, #0xa9, LSL #8
    MLS  V10.4H, V3.4H, V8.H[0x1]
    MLA  V19.4S, V7.4S, V15.S[0x3]
    TBX  V13.8B, { V24.16B, V25.16B }, V25.8B
    MOV V15.B[0x5], V10.B[0x1]
    BIF  V6.8B, V19.8B, V4.8B
    TBL  V28.16B, { V18.16B, V19.16B }, V17.16B
    MLA  V29.8H, V15.8H, V13.H[0x0]
    XTN  V12.8B, V29.8H
    INS V7.B[0xf], W5
    TBL  V10.8B, { V8.16B, V9.16B, V10.16B }, V12.8B
    MOV V3.D[0x1], X9
    MOV V15.S[0x2], W25
    RSHRN2 V0.4S, V7.2D, #1
    DUP  V7.16B, V10.B[0xa]
    SUBHN2  V18.4S, V7.2D, V3.2D
    SUB  V17.2S, V6.2S, V15.2S
    RSHRN V13.2S, V30.2D, #11
    SUB  V6.2D, V5.2D, V18.2D
    DUP  V30.8B, V28.B[0x6]
    MLS  V26.16B, V26.16B, V13.16B
    MOVI  V25.2S, #0x71, MSL #8
    PMULL  V3.1Q, V25.1D, V5.1D
    INS V15.B[0x0], V28.B[0xf]
    RSUBHN  V9.2S, V26.2D, V3.2D
    UZP2  V26.2S, V30.2S, V0.2S
    DUP  V28.8B, V9.B[0x8]
    INS V30.H[0x2], W26
    MOVI  V25.4H, #0xe7, LSL #8
    RSUBHN2  V18.4S, V26.2D, V25.2D
    MVNI  V10.2S, #0xbe, LSL #16
    MLA  V26.2S, V15.2S, V28.S[0x1]
    MLA  V5.4H, V6.4H, V6.H[0x5]
    ZIP1  V0.8H, V5.8H, V30.8H
    NOT  V30.16B, V0.16B
    RSUBHN  V7.4H, V26.4S, V30.4S
    MVNI  V30.2S, #0x4
    SUBS  X10, X10, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_14
    MOVZ  X23, #0x0, LSL #0
    SUB  X21, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X21, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X21, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X21, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X21, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X21, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X21, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X21, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X21, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X21, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X21, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X21, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X21, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X21, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X21, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X21, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X21, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X21, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X21, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X21, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X21, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MRS  X21, FPSR
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    FMOV  X21, V0.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #32
    FMOV  X21, D0
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X21, V1.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X21, D1
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X21, V2.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X21, D2
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x2f55, LSL #0
    MOVK  X23, #0x2f55, LSL #32
    FMOV  X21, V3.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x2f55, LSL #0
    MOVK  X23, #0x2f55, LSL #32
    FMOV  X21, D3
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X21, V4.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    FMOV  X21, D4
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X21, V5.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X21, D5
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x1, LSL #0
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X21, V6.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xfd, LSL #32
    MOVK  X23, #0xfd, LSL #48
    FMOV  X21, D6
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X21, V7.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x1, LSL #0
    MOVK  X23, #0x2, LSL #16
    MOVK  X23, #0x1, LSL #48
    FMOV  X21, D7
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X21, V8.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xc0, LSL #0
    MOVK  X23, #0x20c3, LSL #16
    MOVK  X23, #0xc0, LSL #32
    MOVK  X23, #0x20c3, LSL #48
    FMOV  X21, D8
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X21, V9.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xcfcb, LSL #0
    MOVK  X23, #0xff20, LSL #16
    MOVK  X23, #0xd0ab, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X21, D9
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X21, V10.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xff41, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xff41, LSL #48
    FMOV  X21, D10
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X21, V11.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x500, LSL #0
    MOVK  X23, #0xff02, LSL #48
    FMOV  X21, D11
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X21, V12.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x137, LSL #0
    MOVK  X23, #0x101, LSL #16
    MOVK  X23, #0x1, LSL #32
    MOVK  X23, #0x101, LSL #48
    FMOV  X21, D12
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X21, V13.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x1fe0, LSL #16
    FMOV  X21, D13
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X21, V14.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xf8f8, LSL #0
    MOVK  X23, #0xf8f8, LSL #16
    MOVK  X23, #0xf8f8, LSL #32
    MOVK  X23, #0xf8f8, LSL #48
    FMOV  X21, D14
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X21, V15.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xff00, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0x1dff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X21, D15
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xf8f8, LSL #0
    MOVK  X23, #0xf8f8, LSL #16
    MOVK  X23, #0xf8f8, LSL #32
    MOVK  X23, #0xf8f8, LSL #48
    FMOV  X21, V16.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xf8f8, LSL #0
    MOVK  X23, #0xf8f8, LSL #16
    MOVK  X23, #0xf8f8, LSL #32
    MOVK  X23, #0xf8f8, LSL #48
    FMOV  X21, D16
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X21, V17.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x7b37, LSL #0
    MOVK  X23, #0x7b00, LSL #16
    MOVK  X23, #0xe201, LSL #32
    FMOV  X21, D17
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x18ff, LSL #0
    MOVK  X23, #0x1900, LSL #16
    FMOV  X21, V18.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xff02, LSL #32
    MOVK  X23, #0xff02, LSL #48
    FMOV  X21, D18
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X21, V19.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X21, D19
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X21, V20.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x500, LSL #0
    MOVK  X23, #0x500, LSL #16
    FMOV  X21, D20
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X21, V21.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X21, D21
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X21, V22.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x2, LSL #0
    FMOV  X21, D22
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x6010, LSL #32
    MOVK  X23, #0x10, LSL #48
    FMOV  X21, V23.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x48ff, LSL #0
    MOVK  X23, #0xff00, LSL #16
    MOVK  X23, #0xff, LSL #32
    MOVK  X23, #0xff, LSL #48
    FMOV  X21, D23
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X21, V24.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xff, LSL #0
    MOVK  X23, #0xff, LSL #16
    MOVK  X23, #0xff, LSL #32
    MOVK  X23, #0xff, LSL #48
    FMOV  X21, D24
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X21, V25.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xe700, LSL #0
    MOVK  X23, #0xe700, LSL #16
    MOVK  X23, #0xe700, LSL #32
    MOVK  X23, #0xe700, LSL #48
    FMOV  X21, D25
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X21, V26.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x1, LSL #48
    FMOV  X21, D26
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X21, V27.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X21, D27
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X21, V28.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X21, D28
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xf801, LSL #0
    MOVK  X23, #0xf801, LSL #32
    MOVK  X23, #0xf801, LSL #48
    FMOV  X21, V29.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xf837, LSL #0
    MOVK  X23, #0xf801, LSL #16
    MOVK  X23, #0xda01, LSL #32
    MOVK  X23, #0xf801, LSL #48
    FMOV  X21, D29
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X21, V30.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xfffb, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xfffb, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X21, D30
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x9600, LSL #0
    MOVK  X23, #0xff00, LSL #16
    MOVK  X23, #0xff00, LSL #32
    MOVK  X23, #0xff00, LSL #48
    FMOV  X21, V31.D[1]
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x9600, LSL #0
    MOVK  X23, #0xff00, LSL #16
    MOVK  X23, #0xff00, LSL #32
    MOVK  X23, #0xff00, LSL #48
    FMOV  X21, D31
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x1f0e, LSL #0
    MOVK  X2, #0x641f, LSL #16
    MOVK  X2, #0xd65e, LSL #32
    MOVK  X2, #0x6a5a, LSL #48
    MOVZ  X4, #0xebf5, LSL #0
    MOVK  X4, #0x840c, LSL #16
    MOVK  X4, #0x2099, LSL #32
    MOVK  X4, #0xbca8, LSL #48
    MOVZ  X5, #0x7f50, LSL #0
    MOVK  X5, #0x62b6, LSL #16
    MOVK  X5, #0xbeee, LSL #32
    MOVK  X5, #0x116c, LSL #48
    MOVZ  X6, #0x93eb, LSL #0
    MOVK  X6, #0x7c8c, LSL #16
    MOVK  X6, #0x2b6a, LSL #32
    MOVK  X6, #0xaab3, LSL #48
    MOVZ  X7, #0x8262, LSL #0
    MOVK  X7, #0xc018, LSL #16
    MOVK  X7, #0x73d8, LSL #32
    MOVK  X7, #0x609e, LSL #48
    MOVZ  X8, #0xde83, LSL #0
    MOVK  X8, #0xf904, LSL #16
    MOVK  X8, #0xbea, LSL #32
    MOVK  X8, #0x711c, LSL #48
    MOVZ  X9, #0xd26e, LSL #0
    MOVK  X9, #0x1fc9, LSL #16
    MOVK  X9, #0x2c75, LSL #32
    MOVK  X9, #0x7617, LSL #48
    MOVZ  X10, #0x39c2, LSL #0
    MOVK  X10, #0x176b, LSL #16
    MOVK  X10, #0x2ed1, LSL #32
    MOVK  X10, #0x42ee, LSL #48
    MOVZ  X11, #0xfa47, LSL #0
    MOVK  X11, #0x9dfb, LSL #16
    MOVK  X11, #0x75cd, LSL #32
    MOVK  X11, #0xa0d3, LSL #48
    MOVZ  X13, #0xe2b5, LSL #0
    MOVK  X13, #0x6a69, LSL #16
    MOVK  X13, #0xa8a9, LSL #32
    MOVK  X13, #0x59e6, LSL #48
    MOVZ  X14, #0x702, LSL #0
    MOVK  X14, #0x3142, LSL #16
    MOVK  X14, #0x8655, LSL #32
    MOVK  X14, #0x6b3c, LSL #48
    MOVZ  X15, #0x2962, LSL #0
    MOVK  X15, #0x4d70, LSL #16
    MOVK  X15, #0xfb88, LSL #32
    MOVK  X15, #0x6151, LSL #48
    MOVZ  X16, #0xb982, LSL #0
    MOVK  X16, #0x34ef, LSL #16
    MOVK  X16, #0xcce3, LSL #32
    MOVK  X16, #0x7e9c, LSL #48
    MOVZ  X17, #0x3c51, LSL #0
    MOVK  X17, #0x62f3, LSL #16
    MOVK  X17, #0x373, LSL #32
    MOVK  X17, #0xc687, LSL #48
    MOVZ  X18, #0x44d8, LSL #0
    MOVK  X18, #0xfa7d, LSL #16
    MOVK  X18, #0xd44b, LSL #32
    MOVK  X18, #0x56a0, LSL #48
    MOVZ  X19, #0x7dd6, LSL #0
    MOVK  X19, #0x49b0, LSL #16
    MOVK  X19, #0xdaac, LSL #32
    MOVK  X19, #0xbd57, LSL #48
    MOVZ  X20, #0xd574, LSL #0
    MOVK  X20, #0x1c26, LSL #16
    MOVK  X20, #0x6919, LSL #32
    MOVK  X20, #0x8a80, LSL #48
    MOVZ  X21, #0x218e, LSL #0
    MOVK  X21, #0x6b7c, LSL #16
    MOVK  X21, #0xca62, LSL #32
    MOVK  X21, #0xf0d5, LSL #48
    MOVZ  X23, #0xda51, LSL #0
    MOVK  X23, #0xebe5, LSL #16
    MOVK  X23, #0x1fdd, LSL #32
    MOVK  X23, #0x112, LSL #48
    MOVZ  X24, #0x1ce8, LSL #0
    MOVK  X24, #0x721a, LSL #16
    MOVK  X24, #0x74ab, LSL #32
    MOVK  X24, #0x507f, LSL #48
    MOVZ  X25, #0xdabd, LSL #0
    MOVK  X25, #0x24b5, LSL #16
    MOVK  X25, #0xb555, LSL #32
    MOVK  X25, #0x98f0, LSL #48
    MOVZ  X26, #0x22b4, LSL #0
    MOVK  X26, #0xe05a, LSL #16
    MOVK  X26, #0xe6dd, LSL #32
    MOVK  X26, #0x389, LSL #48
    MOVZ  X27, #0x61e5, LSL #0
    MOVK  X27, #0x5fda, LSL #16
    MOVK  X27, #0xe407, LSL #32
    MOVK  X27, #0x902c, LSL #48
    MOVZ  X28, #0x6284, LSL #0
    MOVK  X28, #0x32d5, LSL #16
    MOVK  X28, #0xfda0, LSL #32
    MOVK  X28, #0x6d40, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X28
    FMOV  D1, X27
    FMOV  V1.D[1], X24
    FMOV  D2, X26
    FMOV  V2.D[1], X28
    FMOV  D3, X14
    FMOV  V3.D[1], X11
    FMOV  D4, X5
    FMOV  V4.D[1], X16
    FMOV  D5, X26
    FMOV  V5.D[1], X23
    FMOV  D6, X28
    FMOV  V6.D[1], X26
    FMOV  D7, X21
    FMOV  V7.D[1], X7
    FMOV  D8, X21
    FMOV  V8.D[1], X27
    FMOV  D9, X26
    FMOV  V9.D[1], X26
    FMOV  D10, X14
    FMOV  V10.D[1], X15
    FMOV  D11, X5
    FMOV  V11.D[1], X20
    FMOV  D12, X9
    FMOV  V12.D[1], X23
    FMOV  D13, X14
    FMOV  V13.D[1], X18
    FMOV  D14, X4
    FMOV  V14.D[1], X14
    FMOV  D15, X8
    FMOV  V15.D[1], X27
    FMOV  D16, X14
    FMOV  V16.D[1], X11
    FMOV  D17, X20
    FMOV  V17.D[1], X13
    FMOV  D18, X6
    FMOV  V18.D[1], X4
    FMOV  D19, X21
    FMOV  V19.D[1], X25
    FMOV  D20, X27
    FMOV  V20.D[1], X17
    FMOV  D21, X19
    FMOV  V21.D[1], X13
    FMOV  D22, X14
    FMOV  V22.D[1], X23
    FMOV  D23, X23
    FMOV  V23.D[1], X9
    FMOV  D24, X7
    FMOV  V24.D[1], X24
    FMOV  D25, X17
    FMOV  V25.D[1], X6
    FMOV  D26, X23
    FMOV  V26.D[1], X2
    FMOV  D27, X21
    FMOV  V27.D[1], X20
    FMOV  D28, X9
    FMOV  V28.D[1], X2
    FMOV  D29, X15
    FMOV  V29.D[1], X24
    FMOV  D30, X13
    FMOV  V30.D[1], X10
    FMOV  D31, X6
    FMOV  V31.D[1], X15
    MOVZ  X11, #0xf, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_15:
    INS V13.D[0x1], V28.D[0x0]
    MOV V27.H[0x6], V31.H[0x4]
    TBL  V22.8B, { V25.16B, V26.16B, V27.16B }, V13.8B
    MUL  V25.2S, V30.2S, V22.S[0x1]
    MOV S0, V24.S[0x2]
    RSHRN2 V4.4S, V29.2D, #23
    SLI V13.2D, V4.2D, #0x12
    RSHRN V8.8B, V25.8H, #3
    MLS  V26.4H, V13.4H, V13.H[0x0]
    MOV V24.H[0x5], W27
    SHRN V25.2S, V24.2D, #11
    RSHRN2 V20.4S, V25.2D, #22
    RSHRN V12.2S, V0.2D, #32
    SHLL2  V7.2D, V12.4S, #32
    SHRN V15.2S, V8.2D, #22
    TRN1  V4.16B, V26.16B, V15.16B
    PMULL  V20.1Q, V15.1D, V4.1D
    SRI  V13.16B, V20.16B, #3
    TBL  V22.16B, { V13.16B, V14.16B, V15.16B }, V13.16B
    DUP H8, V20.H[0x7]
    DUP  V6.4S, V7.S[0x3]
    INS V14.H[0x4], W21
    REV64  V30.4H, V14.4H
    MOV V24.S[0x0], W27
    MLS  V26.4S, V30.4S, V30.4S
    MOV V31.D[0x0], X14
    SUBHN2  V4.8H, V6.4S, V6.4S
    MOV H12, V24.H[0x3]
    MLS  V7.8B, V31.8B, V12.8B
    AND  V13.8B, V31.8B, V22.8B
    MUL  V14.8H, V26.8H, V4.H[0x4]
    MVN  V31.8B, V7.8B
    AND  V22.8B, V16.8B, V8.8B
    MVNI  V12.4S, #0xe7, LSL #24
    DUP D6, V12.D[0x1]
    SLI V20.2D, V6.2D, #0x36
    BIC  V7.8H, #0xc0, LSL #8
    ZIP1  V6.8B, V13.8B, V31.8B
    MOVI  V30.2D, #281470698520575
    SHRN2 V16.4S, V14.2D, #15
    SHL  V4.4H, V22.4H, #0xe
    TBX  V8.8B, { V8.16B, V9.16B, V10.16B }, V4.8B
    MVNI  V0.2S, #0x81, MSL #8
    NEG  V4.4H, V6.4H
    RSHRN2 V22.4S, V4.2D, #21
    PMULL  V14.1Q, V30.1D, V22.1D
    ORN  V13.16B, V0.16B, V8.16B
    TBX  V12.16B, { V25.16B }, V14.16B
    AESD  V10.16B, V7.16B
    MOVI  V14.8B, #0xf1
    MUL  V31.4S, V14.4S, V13.4S
    ORR  V22.8H, #0xf7, LSL #8
    EXT  V8.8B, V12.8B, V21.8B, #0x2
    UZP2  V6.4H, V16.4H, V17.4H
    MOV V9.B[0xf], W4
    AESE  V16.16B, V10.16B
    RADDHN2  V10.4S, V20.2D, V9.2D
    TBL  V30.8B, { V4.16B, V5.16B }, V16.8B
    REV64  V4.8B, V8.8B
    SLI V9.2D, V6.2D, #0x28
    BIC  V6.4H, #0x1d
    MOV  X9, V10.D[0x1]
    PMULL2  V21.8H, V31.16B, V4.16B
    TBX  V4.16B, { V28.16B, V29.16B }, V22.16B
    TBX  V25.8B, { V30.16B }, V30.8B
    TBX  V21.8B, { V25.16B, V26.16B, V27.16B, V28.16B }, V9.8B
    ORR  V12.4S, #0xbd
    AND  V30.8B, V21.8B, V12.8B
    MOVI  V20.8H, #0xfa
    MLS  V0.4H, V4.4H, V4.4H
    MLA  V28.4H, V30.4H, V14.H[0x0]
    PMULL  V30.8H, V0.8B, V20.8B
    XTN  V22.8B, V2.8H
    MOV V25.H[0x6], V25.H[0x3]
    ADDHN  V20.8B, V25.8H, V6.8H
    SRI V26.2D, V26.2D, #43
    MOV V6.H[0x5], V26.H[0x0]
    SRI  V9.4S, V6.4S, #22
    RSUBHN2  V26.8H, V20.4S, V9.4S
    MLS  V31.4H, V26.4H, V19.4H
    SHLL  V4.8H, V31.8B, #8
    CNT  V10.16B, V4.16B
    SRI  V17.8B, V10.8B, #1
    PMUL  V29.8B, V28.8B, V17.8B
    ZIP1  V25.8H, V30.8H, V29.8H
    MOV V19.B[0x0], V22.B[0x8]
    TBL  V0.8B, { V19.16B }, V25.8B
    TBX  V31.8B, { V29.16B, V30.16B }, V6.8B
    DUP V8.8B, W15
    SLI V20.2D, V23.2D, #0x17
    SRI  V25.4H, V16.4H, #12
    DUP V17.2D, X13
    MOV V23.D[0x1], X4
    INS V30.D[0x0], V3.D[0x0]
    INS V29.B[0xb], V27.B[0x9]
    MOV B19, V27.B[0xc]
    RSHRN2 V3.16B, V29.8H, #6
    INS V28.S[0x2], V31.S[0x1]
    MOV  X18, V23.D[0x0]
    MOV  X19, V8.D[0x0]
    TRN1  V27.2D, V0.2D, V19.2D
    MLS  V0.2S, V9.2S, V28.S[0x2]
    DUP V8.16B, W9
    ABS  V19.16B, V0.16B
    MOV S4, V30.S[0x3]
    MOV V6.B[0x1], W15
    MLA  V30.8B, V6.8B, V17.8B
    DUP S10, V3.S[0x1]
    MLS  V3.16B, V27.16B, V3.16B
    ADDV  H16, V4.4H
    NEG  V22.8B, V25.8B
    MOV D25, V19.D[0x1]
    SHLL2  V19.2D, V20.4S, #32
    MVNI  V28.4S, #0xb7, LSL #16
    MOV  V20.8B, V19.8B
    MOV B27, V8.B[0xa]
    TBX  V4.8B, { V9.16B, V10.16B, V11.16B, V12.16B }, V27.8B
    CLZ  V9.4S, V3.4S
    MOV H23, V9.H[0x6]
    INS V19.H[0x3], V25.H[0x5]
    SHRN2 V10.16B, V4.8H, #8
    DUP V17.2D, X5
    SRI V0.2D, V19.2D, #63
    MOV V6.S[0x1], W5
    BIC  V25.2S, #0x7a
    DUP S8, V23.S[0x3]
    DUP V9.4H, W15
    EXT  V19.8B, V6.8B, V10.8B, #0x2
    DUP V27.2D, X8
    MOVI  V30.16B, #0x6f
    INS V6.B[0x8], V16.B[0x8]
    SHRN V10.2S, V17.2D, #7
    XTN  V16.4H, V30.4S
    ADDV  H4, V28.8H
    MLA  V11.8H, V9.8H, V9.H[0x1]
    AESMC  V12.16B, V11.16B
    PMULL  V17.1Q, V0.1D, V8.1D
    DUP V3.4H, W26
    MVNI  V11.4S, #0xec
    DUP V30.2D, V16.D[0x1]
    RSHRN2 V28.16B, V25.8H, #4
    RSHRN V0.4H, V11.4S, #11
    MVNI  V2.4H, #0x9d
    UZP1  V16.2D, V19.2D, V27.2D
    EXT  V23.8B, V0.8B, V17.8B, #0x1
    SRI V9.2D, V12.2D, #51
    BIC  V8.4S, #0x3a, LSL #16
    DUP V0.2D, V4.D[0x1]
    INS V17.B[0xb], W19
    XTN2  V19.4S, V17.2D
    MLA  V25.2S, V28.2S, V19.S[0x1]
    AESE  V28.16B, V10.16B
    MVNI  V10.8H, #0xf1, LSL #8
    AND  V11.16B, V10.16B, V2.16B
    MOVI  V27.2D, #280379743338240
    SHRN2 V4.4S, V16.2D, #32
    MVNI  V19.2S, #0x91, LSL #24
    NOT  V17.16B, V19.16B
    MOV D12, V0.D[0x1]
    XTN2  V0.8H, V23.4S
    ZIP2  V24.8B, V11.8B, V3.8B
    SRI V23.2D, V12.2D, #55
    MOV D19, V9.D[0x1]
    RSHRN V11.8B, V28.8H, #6
    SHRN V12.2S, V4.2D, #26
    SLI  V28.8H, V30.8H, #0xd
    ADDP  D30, V23.2D
    MOV V2.D[0x0], X4
    INS V3.H[0x6], V19.H[0x2]
    XTN2  V10.8H, V24.4S
    BIF  V19.8B, V0.8B, V28.8B
    MOV V16.S[0x2], W6
    INS V9.S[0x3], W28
    XTN  V0.4H, V27.4S
    TBL  V28.16B, { V7.16B, V8.16B, V9.16B, V10.16B }, V9.16B
    MOV B7, V17.B[0x8]
    NOT  V4.16B, V11.16B
    MOV V27.D[0x1], X19
    DUP  V23.16B, V7.B[0xb]
    MVNI  V24.4S, #0x10, MSL #16
    MOV V9.S[0x2], W16
    REV32  V7.4H, V24.4H
    SHL  V10.4H, V31.4H, #0xc
    MOV V17.B[0x2], V19.B[0x5]
    NOT  V8.8B, V10.8B
    SHL V19.2D, V8.2D, #0x20
    DUP  V24.8B, V4.B[0xa]
    CLS  V4.8B, V9.8B
    MOV H9, V4.H[0x6]
    ADDV  H13, V28.4H
    SUBHN  V11.2S, V7.2D, V24.2D
    MOVI  V3.2D, #1099494850560
    INS V31.B[0x6], W27
    RSHRN2 V28.8H, V0.4S, #8
    AESIMC  V15.16B, V17.16B
    ADDV  H8, V19.8H
    MLS  V10.16B, V11.16B, V27.16B
    RADDHN  V0.8B, V23.8H, V2.8H
    ADDV  S3, V0.4S
    INS V0.S[0x2], V8.S[0x1]
    SUBS  X11, X11, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_15
    MOVZ  X23, #0x1f0e, LSL #0
    MOVK  X23, #0x641f, LSL #16
    MOVK  X23, #0xd65e, LSL #32
    MOVK  X23, #0x6a5a, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xebf5, LSL #0
    MOVK  X23, #0x840c, LSL #16
    MOVK  X23, #0x2099, LSL #32
    MOVK  X23, #0xbca8, LSL #48
    SUB  X10, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x7f50, LSL #0
    MOVK  X23, #0x62b6, LSL #16
    MOVK  X23, #0xbeee, LSL #32
    MOVK  X23, #0x116c, LSL #48
    SUB  X10, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x93eb, LSL #0
    MOVK  X23, #0x7c8c, LSL #16
    MOVK  X23, #0x2b6a, LSL #32
    MOVK  X23, #0xaab3, LSL #48
    SUB  X10, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x8262, LSL #0
    MOVK  X23, #0xc018, LSL #16
    MOVK  X23, #0x73d8, LSL #32
    MOVK  X23, #0x609e, LSL #48
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xde83, LSL #0
    MOVK  X23, #0xf904, LSL #16
    MOVK  X23, #0xbea, LSL #32
    MOVK  X23, #0x711c, LSL #48
    SUB  X10, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xffc0, LSL #16
    MOVK  X23, #0xf500, LSL #48
    SUB  X10, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xe2b5, LSL #0
    MOVK  X23, #0x6a69, LSL #16
    MOVK  X23, #0xa8a9, LSL #32
    MOVK  X23, #0x59e6, LSL #48
    SUB  X10, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x702, LSL #0
    MOVK  X23, #0x3142, LSL #16
    MOVK  X23, #0x8655, LSL #32
    MOVK  X23, #0x6b3c, LSL #48
    SUB  X10, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x2962, LSL #0
    MOVK  X23, #0x4d70, LSL #16
    MOVK  X23, #0xfb88, LSL #32
    MOVK  X23, #0x6151, LSL #48
    SUB  X10, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xb982, LSL #0
    MOVK  X23, #0x34ef, LSL #16
    MOVK  X23, #0xcce3, LSL #32
    MOVK  X23, #0x7e9c, LSL #48
    SUB  X10, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x3c51, LSL #0
    MOVK  X23, #0x62f3, LSL #16
    MOVK  X23, #0x373, LSL #32
    MOVK  X23, #0xc687, LSL #48
    SUB  X10, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x6262, LSL #0
    MOVK  X23, #0x6262, LSL #16
    MOVK  X23, #0x6262, LSL #32
    MOVK  X23, #0x6262, LSL #48
    SUB  X10, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xd574, LSL #0
    MOVK  X23, #0x1c26, LSL #16
    MOVK  X23, #0x6919, LSL #32
    MOVK  X23, #0x8a80, LSL #48
    SUB  X10, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x218e, LSL #0
    MOVK  X23, #0x6b7c, LSL #16
    MOVK  X23, #0xca62, LSL #32
    MOVK  X23, #0xf0d5, LSL #48
    SUB  X10, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x1ce8, LSL #0
    MOVK  X23, #0x721a, LSL #16
    MOVK  X23, #0x74ab, LSL #32
    MOVK  X23, #0x507f, LSL #48
    SUB  X10, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x22b4, LSL #0
    MOVK  X23, #0xe05a, LSL #16
    MOVK  X23, #0xe6dd, LSL #32
    MOVK  X23, #0x389, LSL #48
    SUB  X10, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x61e5, LSL #0
    MOVK  X23, #0x5fda, LSL #16
    MOVK  X23, #0xe407, LSL #32
    MOVK  X23, #0x902c, LSL #48
    SUB  X10, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x6284, LSL #0
    MOVK  X23, #0x32d5, LSL #16
    MOVK  X23, #0xfda0, LSL #32
    MOVK  X23, #0x6d40, LSL #48
    SUB  X10, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MRS  X10, FPSR
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X10, V0.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x84ec, LSL #0
    MOVK  X23, #0xbd21, LSL #16
    FMOV  X10, D0
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x1ce8, LSL #0
    MOVK  X23, #0x721a, LSL #16
    MOVK  X23, #0x74ab, LSL #32
    MOVK  X23, #0x507f, LSL #48
    FMOV  X10, V1.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x61e5, LSL #0
    MOVK  X23, #0x5fda, LSL #16
    MOVK  X23, #0xe407, LSL #32
    MOVK  X23, #0x902c, LSL #48
    FMOV  X10, D1
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X10, V2.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xebf5, LSL #0
    MOVK  X23, #0x840c, LSL #16
    MOVK  X23, #0x2099, LSL #32
    MOVK  X23, #0xbca8, LSL #48
    FMOV  X10, D2
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X10, V3.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x84ec, LSL #0
    MOVK  X23, #0xbd21, LSL #16
    FMOV  X10, D3
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X10, V4.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x100, LSL #0
    MOVK  X23, #0x100, LSL #16
    MOVK  X23, #0x100, LSL #32
    MOVK  X23, #0x100, LSL #48
    FMOV  X10, D4
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xda51, LSL #0
    MOVK  X23, #0xebe5, LSL #16
    MOVK  X23, #0x1fdd, LSL #32
    MOVK  X23, #0x112, LSL #48
    FMOV  X10, V5.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x22b4, LSL #0
    MOVK  X23, #0xe05a, LSL #16
    MOVK  X23, #0xe6dd, LSL #32
    MOVK  X23, #0x389, LSL #48
    FMOV  X10, D5
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x388c, LSL #16
    FMOV  X10, V6.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x6240, LSL #0
    MOVK  X23, #0x7f50, LSL #32
    MOVK  X23, #0x62b6, LSL #48
    FMOV  X10, D6
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X10, V7.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffef, LSL #0
    MOVK  X23, #0xffef, LSL #32
    FMOV  X10, D7
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X10, V8.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffe, LSL #0
    FMOV  X10, D8
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X10, V9.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X10, D9
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X10, V10.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xef00, LSL #0
    FMOV  X10, D10
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X10, V11.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffef, LSL #0
    FMOV  X10, D11
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X10, V12.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xfa80, LSL #32
    MOVK  X23, #0x4702, LSL #48
    FMOV  X10, D12
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X10, V13.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xff00, LSL #0
    FMOV  X10, D13
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X10, V14.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xf1f1, LSL #0
    MOVK  X23, #0xf1f1, LSL #16
    MOVK  X23, #0xf1f1, LSL #32
    MOVK  X23, #0xf1f1, LSL #48
    FMOV  X10, D14
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X10, V15.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x775, LSL #0
    MOVK  X23, #0xaf4c, LSL #16
    MOVK  X23, #0x775, LSL #32
    MOVK  X23, #0xaf4c, LSL #48
    FMOV  X10, D15
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x93eb, LSL #0
    MOVK  X23, #0x7c8c, LSL #16
    MOVK  X23, #0xbea, LSL #32
    MOVK  X23, #0x711c, LSL #48
    FMOV  X10, V16.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7f50, LSL #16
    MOVK  X23, #0x62b6, LSL #32
    FMOV  X10, D16
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X10, V17.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x9100, LSL #16
    MOVK  X23, #0x9100, LSL #48
    FMOV  X10, D17
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xebf5, LSL #0
    MOVK  X23, #0x840c, LSL #16
    MOVK  X23, #0x2099, LSL #32
    MOVK  X23, #0xbca8, LSL #48
    FMOV  X10, V18.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x93eb, LSL #0
    MOVK  X23, #0x7c8c, LSL #16
    MOVK  X23, #0x2b6a, LSL #32
    MOVK  X23, #0xaab3, LSL #48
    FMOV  X10, D18
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X10, V19.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xfff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X10, D19
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X10, V20.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X10, D20
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X10, V21.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X10, D21
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X10, V22.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xf6, LSL #0
    MOVK  X23, #0x200, LSL #16
    MOVK  X23, #0xf3, LSL #48
    FMOV  X10, D22
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X10, V23.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X10, D23
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X10, V24.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X10, D24
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X10, V25.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x9d4a, LSL #0
    MOVK  X23, #0x6fe5, LSL #16
    MOVK  X23, #0x9d4a, LSL #32
    MOVK  X23, #0x6fe5, LSL #48
    FMOV  X10, D25
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x9191, LSL #0
    MOVK  X23, #0xff81, LSL #16
    FMOV  X10, V26.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x388c, LSL #0
    MOVK  X23, #0x5282, LSL #16
    MOVK  X23, #0x624d, LSL #32
    MOVK  X23, #0x11c4, LSL #48
    FMOV  X10, D26
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x6262, LSL #0
    MOVK  X23, #0x6262, LSL #16
    MOVK  X23, #0x6262, LSL #32
    MOVK  X23, #0x6262, LSL #48
    FMOV  X10, V27.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xff00, LSL #0
    MOVK  X23, #0xff00, LSL #16
    MOVK  X23, #0xff00, LSL #32
    FMOV  X10, D27
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xff, LSL #0
    MOVK  X23, #0xff, LSL #16
    FMOV  X10, V28.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xff00, LSL #0
    FMOV  X10, D28
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x6200, LSL #16
    FMOV  X10, V29.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xfe00, LSL #0
    FMOV  X10, D29
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X10, V30.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X10, D30
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X10, V31.D[1]
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X23, #0xe0f, LSL #0
    MOVK  X23, #0xa000, LSL #32
    MOVK  X23, #0x1fe5, LSL #48
    FMOV  X10, D31
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    FMOV  D0, X19
    FMOV  V0.D[1], X21
    FMOV  D1, X9
    FMOV  V1.D[1], X24
    FMOV  D2, X17
    FMOV  V2.D[1], X18
    FMOV  D3, X16
    FMOV  V3.D[1], X20
    FMOV  D4, X28
    FMOV  V4.D[1], X23
    FMOV  D5, X27
    FMOV  V5.D[1], X25
    FMOV  D6, X26
    FMOV  V6.D[1], X15
    FMOV  D7, X6
    FMOV  V7.D[1], X11
    FMOV  D8, X10
    FMOV  V8.D[1], X2
    FMOV  D9, X16
    FMOV  V9.D[1], X6
    FMOV  D10, X7
    FMOV  V10.D[1], X9
    FMOV  D11, X23
    FMOV  V11.D[1], X27
    FMOV  D12, X20
    FMOV  V12.D[1], X10
    FMOV  D13, X24
    FMOV  V13.D[1], X7
    FMOV  D14, X6
    FMOV  V14.D[1], X23
    FMOV  D15, X10
    FMOV  V15.D[1], X19
    FMOV  D16, X16
    FMOV  V16.D[1], X27
    FMOV  D17, X10
    FMOV  V17.D[1], X16
    FMOV  D18, X15
    FMOV  V18.D[1], X2
    FMOV  D19, X21
    FMOV  V19.D[1], X7
    FMOV  D20, X24
    FMOV  V20.D[1], X25
    FMOV  D21, X18
    FMOV  V21.D[1], X18
    FMOV  D22, X20
    FMOV  V22.D[1], X10
    FMOV  D23, X19
    FMOV  V23.D[1], X5
    FMOV  D24, X14
    FMOV  V24.D[1], X8
    FMOV  D25, X7
    FMOV  V25.D[1], X23
    FMOV  D26, X23
    FMOV  V26.D[1], X21
    FMOV  D27, X24
    FMOV  V27.D[1], X4
    FMOV  D28, X19
    FMOV  V28.D[1], X7
    FMOV  D29, X25
    FMOV  V29.D[1], X10
    FMOV  D30, X2
    FMOV  V30.D[1], X28
    FMOV  D31, X4
    FMOV  V31.D[1], X8
    MOVZ  X20, #0xf, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_16:
    MLA  V17.8H, V25.8H, V8.H[0x5]
    INS V31.H[0x3], V27.H[0x0]
    INS V18.D[0x0], V26.D[0x0]
    DUP V27.2D, V28.D[0x0]
    SLI  V29.8H, V29.8H, #0xd
    DUP D16, V30.D[0x1]
    RSHRN V2.4H, V17.4S, #2
    SHLL  V3.4S, V2.4H, #16
    SUB  V3.16B, V24.16B, V27.16B
    TBX  V31.16B, { V16.16B }, V22.16B
    SHRN2 V4.16B, V31.8H, #5
    INS V21.H[0x0], W14
    CLZ  V30.8B, V18.8B
    CLS  V5.16B, V21.16B
    RSHRN V20.4H, V4.4S, #7
    AESE  V2.16B, V29.16B
    EOR  V30.8B, V2.8B, V5.8B
    SLI V25.2D, V30.2D, #0x3
    RSUBHN2  V22.8H, V20.4S, V20.4S
    MUL  V13.4H, V3.4H, V2.H[0x6]
    DUP V8.2D, X23
    AESD  V31.16B, V8.16B
    TBX  V26.16B, { V26.16B, V27.16B, V28.16B, V29.16B }, V31.16B
    TBL  V24.16B, { V25.16B }, V22.16B
    RSHRN V2.2S, V26.2D, #25
    AESD  V17.16B, V18.16B
    MLS  V16.4S, V24.4S, V2.S[0x3]
    INS V3.H[0x3], W6
    SHRN V2.4H, V3.4S, #3
    EXT  V21.8B, V2.8B, V13.8B, #0x4
    ADDV  S4, V21.4S
    RBIT  V11.8B, V17.8B
    RSHRN V30.2S, V16.2D, #4
    INS V16.D[0x1], X13
    DUP V21.2D, X21
    ADD  V5.16B, V4.16B, V10.16B
    AESMC  V3.16B, V21.16B
    ABS  V28.16B, V3.16B
    INS V8.H[0x0], V29.H[0x1]
    MOVI  V20.16B, #0xf0
    RSUBHN  V13.8B, V16.8H, V11.8H
    TBL  V18.16B, { V8.16B }, V3.16B
    DUP H18, V20.H[0x0]
    SRI  V21.4H, V28.4H, #14
    MVNI  V10.4S, #0x6f
    RADDHN2  V24.4S, V21.2D, V30.2D
    TBX  V17.8B, { V24.16B }, V2.8B
    SHRN2 V26.4S, V18.2D, #16
    MOVI  V4.8B, #0x10
    INS V18.S[0x0], W26
    MLS  V22.4H, V18.4H, V10.H[0x4]
    MOV V29.D[0x0], X10
    ABS  V2.16B, V13.16B
    ABS  V24.4H, V17.4H
    TRN1  V21.2S, V5.2S, V5.2S
    MOV V14.B[0x9], V26.B[0xd]
    MLA  V13.8H, V4.8H, V4.H[0x7]
    MLA  V3.2S, V2.2S, V13.S[0x2]
    SHL  V10.2S, V22.2S, #0x8
    ADDHN2  V28.8H, V21.4S, V29.4S
    ADDV  H20, V24.8H
    ORR  V5.16B, V3.16B, V3.16B
    TBL  V30.16B, { V30.16B, V31.16B }, V28.16B
    DUP  V18.2S, V30.S[0x2]
    SLI  V24.8H, V14.8H, #0x8
    MVNI  V17.8H, #0xf8, LSL #8
    TRN1  V29.8H, V5.8H, V24.8H
    ABS  V14.8B, V20.8B
    ADDP  D31, V10.2D
    ZIP2  V2.8H, V17.8H, V31.8H
    MOV V26.B[0x9], V18.B[0x9]
    MLA  V24.8H, V2.8H, V15.H[0x4]
    MUL  V21.16B, V27.16B, V26.16B
    DUP S31, V29.S[0x1]
    SLI  V13.8B, V14.8B, #0x0
    DUP  V26.2S, V24.S[0x2]
    RSHRN V18.2S, V13.2D, #12
    SRI  V4.8B, V21.8B, #5
    MUL  V22.2S, V4.2S, V26.2S
    MVNI  V30.4S, #0x1c, MSL #8
    MOVI  V14.2S, #0x19, MSL #16
    ADDHN2  V28.8H, V31.4S, V31.4S
    SUBHN2  V2.4S, V14.2D, V14.2D
    SUBHN  V31.8B, V30.8H, V28.8H
    REV64  V28.8H, V18.8H
    ABS  V14.16B, V31.16B
    RSHRN V29.8B, V22.8H, #6
    MVNI  V27.2S, #0x6e, MSL #16
    BIC  V15.8B, V2.8B, V28.8B
    TBL  V30.16B, { V14.16B, V15.16B }, V29.16B
    INS V14.D[0x1], V30.D[0x1]
    MOV D22, V27.D[0x1]
    MOV V13.D[0x0], V14.D[0x0]
    MVNI  V2.4S, #0x60, LSL #8
    REV16  V14.8B, V22.8B
    MLS  V18.4S, V25.4S, V10.S[0x2]
    MLA  V4.8H, V13.8H, V15.H[0x1]
    INS V25.H[0x6], W9
    SRI V24.2D, V25.2D, #43
    RADDHN2  V25.4S, V24.2D, V24.2D
    CNT  V21.16B, V18.16B
    XTN  V29.4H, V15.4S
    MOV V27.H[0x1], V2.H[0x4]
    AESMC  V22.16B, V25.16B
    ADDHN  V25.4H, V29.4S, V23.4S
    RSHRN V18.4H, V22.4S, #11
    SHRN V30.2S, V14.2D, #18
    BIC  V28.2S, #0xed
    SHRN2 V26.8H, V4.4S, #10
    CLZ  V29.8B, V21.8B
    TBX  V10.16B, { V2.16B, V3.16B, V4.16B }, V30.16B
    SHLL2  V13.4S, V12.8H, #16
    SRI  V12.16B, V23.16B, #2
    DUP V14.8B, W24
    RSUBHN2  V24.8H, V27.4S, V27.4S
    SRI  V27.8H, V28.8H, #4
    ABS  V21.2S, V26.2S
    MOV V29.D[0x0], V29.D[0x1]
    INS V15.S[0x3], W25
    SRI  V20.4S, V27.4S, #7
    INS V22.S[0x2], V24.S[0x0]
    DUP  V30.4H, V13.H[0x1]
    MOVI  V27.2S, #0x61, MSL #16
    SRI  V10.4H, V27.4H, #12
    TBL  V17.8B, { V12.16B }, V14.8B
    MOVI  V3.2D, #18374686483949879040
    INS V26.B[0x5], V17.B[0xb]
    MUL  V27.4S, V10.4S, V18.S[0x0]
    ZIP2  V28.2S, V29.2S, V21.2S
    MOVI  V23.4S, #0xe4, LSL #24
    CLS  V4.8B, V15.8B
    MOVI  V10.4S, #0xe, MSL #8
    MOVI  V13.2D, #18446744073709486080
    TRN1  V2.2S, V13.2S, V30.2S
    MVNI  V29.4H, #0xb, LSL #8
    ADDV  S30, V27.4S
    ADDP  V27.8H, V3.8H, V30.8H
    UZP2  V3.2D, V28.2D, V22.2D
    TBL  V15.8B, { V16.16B, V17.16B }, V27.8B
    DUP B21, V4.B[0xf]
    MLA  V30.8H, V21.8H, V10.H[0x1]
    NEG  V28.16B, V2.16B
    BIT  V2.16B, V20.16B, V23.16B
    DUP V18.16B, W5
    SHRN V20.2S, V2.2D, #22
    DUP B2, V26.B[0x2]
    DUP V13.2S, W2
    MLA  V26.16B, V28.16B, V18.16B
    ORR  V28.8B, V13.8B, V29.8B
    MVNI  V23.2S, #0x96, MSL #8
    SLI  V18.8B, V28.8B, #0x3
    SHL  V21.16B, V18.16B, #0x4
    CLS  V13.8B, V21.8B
    AESMC  V16.16B, V23.16B
    BIT  V4.8B, V30.8B, V16.8B
    ORR  V23.8B, V2.8B, V26.8B
    TRN1  V29.2S, V13.2S, V15.2S
    SHLL2  V27.8H, V20.16B, #8
    MOVI  V28.2S, #0x4
    MOV V18.D[0x1], V4.D[0x0]
    SLI  V10.8B, V3.8B, #0x3
    RSHRN V16.8B, V29.8H, #5
    TRN2  V4.8B, V29.8B, V16.8B
    CNT  V3.16B, V7.16B
    EXT  V20.8B, V3.8B, V4.8B, #0x7
    ZIP1  V22.8H, V23.8H, V20.8H
    SLI  V16.8B, V22.8B, #0x2
    MVNI  V17.2S, #0x34, LSL #16
    RSHRN V29.8B, V27.8H, #8
    XTN  V27.2S, V16.2D
    SUBHN  V23.2S, V18.2D, V28.2D
    MOVI  V16.2S, #0xc1, LSL #8
    SLI  V22.2S, V14.2S, #0x9
    ORR  V20.8B, V0.8B, V16.8B
    MOVI  V14.2D, #18374966859414896895
    PMUL  V13.16B, V17.16B, V17.16B
    MLS  V3.4S, V14.4S, V22.S[0x1]
    TBL  V28.8B, { V0.16B, V1.16B, V2.16B, V3.16B }, V3.8B
    SHRN2 V7.4S, V13.2D, #18
    MLA  V18.2S, V29.2S, V23.S[0x2]
    RSHRN2 V29.16B, V27.8H, #7
    MLA  V27.2S, V18.2S, V28.2S
    REV32  V1.8H, V10.8H
    MOV  X6, V7.D[0x1]
    SHRN2 V4.16B, V29.8H, #5
    NOT  V17.16B, V20.16B
    DUP D13, V17.D[0x0]
    DUP V16.2S, W5
    RBIT  V22.8B, V16.8B
    ZIP1  V17.4H, V27.4H, V27.4H
    CLZ  V27.8H, V22.8H
    UZP1  V22.2D, V1.2D, V1.2D
    ADDHN2  V1.16B, V27.8H, V27.8H
    MOV D28, V4.D[0x0]
    SHLL2  V2.8H, V13.16B, #8
    MOV V13.S[0x1], W15
    ADDV  B10, V13.16B
    ORR  V20.8B, V1.8B, V28.8B
    INS V13.B[0x7], W10
    CNT  V7.8B, V2.8B
    SUBS  X20, X20, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_16
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x5551, LSL #0
    MOVK  X27, #0x5555, LSL #16
    SUB  X7, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    MRS  X7, FPSR
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, V0.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, D0
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, V1.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x607, LSL #16
    MOVK  X27, #0x607, LSL #48
    FMOV  X7, D1
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, V2.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, D2
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, V3.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, D3
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xc7, LSL #32
    FMOV  X7, V4.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x3807, LSL #0
    MOVK  X27, #0x7, LSL #16
    FMOV  X7, D4
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, V5.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, D5
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, V6.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, D6
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, V7.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, D7
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, V8.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, D8
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, V9.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, D9
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, V10.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x3b, LSL #0
    FMOV  X7, D10
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, V11.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x4a4a, LSL #0
    MOVK  X27, #0x234a, LSL #16
    MOVK  X27, #0xab4a, LSL #32
    MOVK  X27, #0x4a4a, LSL #48
    FMOV  X7, D11
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, V12.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x283d, LSL #0
    MOVK  X27, #0x283e, LSL #16
    MOVK  X27, #0x1, LSL #32
    MOVK  X27, #0x100, LSL #48
    FMOV  X7, D12
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, V13.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x3eff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    FMOV  X7, D13
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xff, LSL #0
    MOVK  X27, #0xff00, LSL #16
    MOVK  X27, #0xff00, LSL #32
    MOVK  X27, #0xff00, LSL #48
    FMOV  X7, V14.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xff, LSL #0
    MOVK  X27, #0xff00, LSL #16
    MOVK  X27, #0xff00, LSL #32
    MOVK  X27, #0xff00, LSL #48
    FMOV  X7, D14
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, V15.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, D15
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, V16.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, D16
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, V17.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xfc00, LSL #0
    MOVK  X27, #0xfc00, LSL #16
    MOVK  X27, #0x1c00, LSL #32
    MOVK  X27, #0x1c00, LSL #48
    FMOV  X7, D17
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, V18.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xa0f8, LSL #0
    MOVK  X27, #0xa0f8, LSL #16
    MOVK  X27, #0xa0f8, LSL #32
    MOVK  X27, #0xa0f8, LSL #48
    FMOV  X7, D18
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, V19.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, D19
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, V20.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x3807, LSL #0
    MOVK  X27, #0x607, LSL #16
    MOVK  X27, #0x607, LSL #48
    FMOV  X7, D20
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, V21.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x80, LSL #0
    MOVK  X27, #0x80, LSL #16
    MOVK  X27, #0x80, LSL #32
    MOVK  X27, #0x80, LSL #48
    FMOV  X7, D21
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x607, LSL #16
    MOVK  X27, #0x607, LSL #48
    FMOV  X7, V22.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x607, LSL #16
    MOVK  X27, #0x607, LSL #48
    FMOV  X7, D22
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, V23.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xa0f4, LSL #0
    MOVK  X27, #0xa0f8, LSL #16
    MOVK  X27, #0x4, LSL #32
    MOVK  X27, #0x401, LSL #48
    FMOV  X7, D23
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, V24.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x63aa, LSL #0
    MOVK  X27, #0xa2, LSL #16
    MOVK  X27, #0xae, LSL #32
    MOVK  X27, #0x27, LSL #48
    FMOV  X7, D24
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, V25.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xa8f7, LSL #0
    MOVK  X27, #0x401, LSL #16
    FMOV  X7, D25
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x405, LSL #0
    MOVK  X27, #0x404, LSL #16
    FMOV  X7, V26.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xff00, LSL #0
    FMOV  X7, D26
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x10, LSL #0
    MOVK  X27, #0x10, LSL #16
    MOVK  X27, #0x10, LSL #32
    MOVK  X27, #0x10, LSL #48
    FMOV  X7, V27.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x10, LSL #0
    MOVK  X27, #0x10, LSL #16
    MOVK  X27, #0x10, LSL #32
    MOVK  X27, #0x10, LSL #48
    FMOV  X7, D27
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, V28.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x3807, LSL #0
    MOVK  X27, #0x7, LSL #16
    FMOV  X7, D28
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x38f8, LSL #0
    FMOV  X7, V29.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, D29
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, V30.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x2a24, LSL #0
    MOVK  X27, #0x2638, LSL #16
    FMOV  X7, D30
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X7, V31.D[1]
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xffe3, LSL #0
    MOVK  X27, #0xffe3, LSL #16
    MOVK  X27, #0xffe1, LSL #32
    MOVK  X27, #0xffe3, LSL #48
    FMOV  X7, D31
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
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
    FMOV  D0, X28
    FMOV  V0.D[1], X24
    FMOV  D1, X25
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X21
    FMOV  D3, X28
    FMOV  V3.D[1], X15
    FMOV  D4, X7
    FMOV  V4.D[1], X18
    FMOV  D5, X20
    FMOV  V5.D[1], X9
    FMOV  D6, X26
    FMOV  V6.D[1], X8
    FMOV  D7, X17
    FMOV  V7.D[1], X10
    FMOV  D8, X10
    FMOV  V8.D[1], X10
    FMOV  D9, X4
    FMOV  V9.D[1], X9
    FMOV  D10, X11
    FMOV  V10.D[1], X14
    FMOV  D11, X8
    FMOV  V11.D[1], X9
    FMOV  D12, X14
    FMOV  V12.D[1], X20
    FMOV  D13, X11
    FMOV  V13.D[1], X20
    FMOV  D14, X6
    FMOV  V14.D[1], X7
    FMOV  D15, X19
    FMOV  V15.D[1], X2
    FMOV  D16, X6
    FMOV  V16.D[1], X11
    FMOV  D17, X23
    FMOV  V17.D[1], X18
    FMOV  D18, X4
    FMOV  V18.D[1], X25
    FMOV  D19, X9
    FMOV  V19.D[1], X26
    FMOV  D20, X23
    FMOV  V20.D[1], X10
    FMOV  D21, X24
    FMOV  V21.D[1], X20
    FMOV  D22, X9
    FMOV  V22.D[1], X13
    FMOV  D23, X5
    FMOV  V23.D[1], X21
    FMOV  D24, X7
    FMOV  V24.D[1], X25
    FMOV  D25, X26
    FMOV  V25.D[1], X21
    FMOV  D26, X24
    FMOV  V26.D[1], X28
    FMOV  D27, X23
    FMOV  V27.D[1], X23
    FMOV  D28, X27
    FMOV  V28.D[1], X9
    FMOV  D29, X25
    FMOV  V29.D[1], X28
    FMOV  D30, X7
    FMOV  V30.D[1], X26
    FMOV  D31, X25
    FMOV  V31.D[1], X11
    MOVZ  X9, #0xf, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_17:
    SHLL  V31.4S, V22.4H, #16
    NEG  V26.4S, V26.4S
    RADDHN2  V29.8H, V24.4S, V21.4S
    AESE  V14.16B, V28.16B
    SHRN V13.2S, V14.2D, #30
    MOV H16, V31.H[0x2]
    DUP  V20.4H, V30.H[0x3]
    TBX  V1.8B, { V26.16B, V27.16B }, V16.8B
    UZP2  V2.16B, V20.16B, V20.16B
    SHL V2.2D, V29.2D, #0x2b
    CLZ  V14.8B, V1.8B
    AESMC  V24.16B, V13.16B
    MUL  V19.8H, V2.8H, V25.8H
    ADDV  S10, V16.4S
    DUP D1, V14.D[0x0]
    MOVI  V28.2D, #18446463698227756800
    DUP D27, V24.D[0x0]
    INS V11.H[0x2], V19.H[0x1]
    INS V10.H[0x4], W14
    NOT  V26.16B, V10.16B
    SLI  V1.4H, V1.4H, #0xa
    RSUBHN2  V10.8H, V28.4S, V26.4S
    MVNI  V21.4H, #0x2e
    DUP V13.2D, X15
    ABS  V2.8H, V1.8H
    SHLL  V24.2D, V11.2S, #32
    TBX  V30.16B, { V23.16B, V24.16B, V25.16B }, V13.16B
    MUL  V31.4H, V27.4H, V8.H[0x3]
    UZP1  V1.4S, V30.4S, V22.4S
    MOV B22, V14.B[0x3]
    RSHRN V25.2S, V21.2D, #2
    BIF  V21.8B, V2.8B, V31.8B
    MLA  V23.4H, V21.4H, V10.4H
    SHL  V26.8B, V1.8B, #0x5
    EXT  V16.8B, V26.8B, V26.8B, #0x5
    RSHRN V19.4H, V16.4S, #9
    DUP  V26.8H, V22.H[0x1]
    MOVI  V11.8H, #0xa9
    MOV V14.D[0x1], X16
    MOV D29, V14.D[0x0]
    DUP V10.16B, W26
    REV16  V21.16B, V25.16B
    DUP V28.2S, W6
    MLA  V1.2S, V23.2S, V29.S[0x3]
    MOV V5.B[0x3], V11.B[0x4]
    ORN  V14.8B, V5.8B, V5.8B
    XTN2  V5.16B, V19.8H
    MLS  V23.4H, V10.4H, V14.H[0x3]
    MOVI  V30.8B, #0xdb
    RSHRN2 V14.8H, V30.4S, #6
    SLI  V25.2S, V14.2S, #0xa
    NEG  V24.16B, V25.16B
    MOV V30.D[0x0], X27
    MOV V22.D[0x0], V21.D[0x0]
    MLA  V29.16B, V26.16B, V23.16B
    ZIP1  V23.4S, V23.4S, V1.4S
    BIT  V1.16B, V24.16B, V29.16B
    MLA  V14.2S, V28.2S, V1.S[0x3]
    RSUBHN  V19.2S, V5.2D, V5.2D
    DUP V5.8B, W6
    UZP1  V25.2D, V22.2D, V14.2D
    MOV  V16.16B, V30.16B
    ADDP  V26.4S, V16.4S, V16.4S
    DUP V22.8B, W26
    MOV B21, V26.B[0x1]
    SHL  V10.8H, V25.8H, #0xa
    SHLL  V26.4S, V23.4H, #16
    DUP V23.4H, W2
    MLS  V29.2S, V10.2S, V23.S[0x3]
    SRI V1.2D, V5.2D, #29
    TBL  V11.16B, { V21.16B, V22.16B }, V19.16B
    EOR  V28.16B, V26.16B, V26.16B
    MLA  V24.4S, V29.4S, V28.S[0x1]
    REV16  V16.8B, V23.8B
    AND  V26.8B, V16.8B, V24.8B
    DUP S29, V26.S[0x0]
    MOVI  V16.16B, #0xfa
    RSHRN2 V25.16B, V11.8H, #1
    SRI  V30.2S, V25.2S, #13
    MVN  V22.8B, V16.8B
    MOV V25.H[0x0], V1.H[0x1]
    MOV  W21, V25.S[0x3]
    MLA  V25.2S, V29.2S, V22.S[0x1]
    EXT  V14.16B, V25.16B, V25.16B, #0xf
    MLA  V11.4H, V14.4H, V14.H[0x2]
    SUBHN  V26.4H, V30.4S, V11.4S
    DUP  V5.8B, V9.B[0xc]
    MOVI  V1.4S, #0x18, MSL #8
    ORN  V28.8B, V10.8B, V23.8B
    DUP B30, V20.B[0xa]
    MOV V14.B[0xa], W7
    TBX  V21.16B, { V29.16B, V30.16B, V31.16B }, V15.16B
    MOV B24, V1.B[0x1]
    DUP V16.16B, W27
    MOV V11.H[0x6], W17
    SHRN2 V9.4S, V1.2D, #6
    ADDV  S15, V24.4S
    INS V30.D[0x0], X16
    DUP V29.8H, W9
    MLS  V22.4S, V5.4S, V14.S[0x0]
    INS V1.D[0x1], X14
    NOT  V24.8B, V9.8B
    TRN1  V14.8B, V2.8B, V29.8B
    ORR  V29.4H, #0xb5
    SHLL2  V31.4S, V26.8H, #16
    MVNI  V20.2S, #0x9a, LSL #16
    BIC  V25.8B, V28.8B, V28.8B
    DUP H5, V24.H[0x3]
    UZP1  V26.16B, V0.16B, V22.16B
    TBX  V22.8B, { V12.16B, V13.16B, V14.16B, V15.16B }, V15.8B
    SLI  V9.8H, V30.8H, #0x6
    ORN  V30.16B, V26.16B, V20.16B
    MVNI  V0.2S, #0x34, LSL #16
    RSHRN V28.4H, V11.4S, #1
    MOV D2, V22.D[0x0]
    SRI V11.2D, V1.2D, #57
    INS V1.H[0x6], V30.H[0x5]
    SLI V22.2D, V9.2D, #0x36
    SHRN2 V26.4S, V16.2D, #27
    EXT  V30.8B, V11.8B, V28.8B, #0x6
    MOVI  V24.8H, #0x14, LSL #8
    SRI  V11.8H, V22.8H, #13
    SLI V13.2D, V11.2D, #0x38
    ORN  V9.16B, V5.16B, V5.16B
    EXT  V14.16B, V0.16B, V31.16B, #0x0
    ORR  V16.8B, V13.8B, V30.8B
    SHRN V31.2S, V25.2D, #16
    RSUBHN2  V28.8H, V1.4S, V31.4S
    BSL  V20.8B, V2.8B, V2.8B
    SLI  V0.8H, V20.8H, #0xe
    SUBHN2  V22.16B, V26.8H, V29.8H
    MOV S29, V24.S[0x3]
    RSHRN V12.4H, V9.4S, #3
    AESMC  V11.16B, V16.16B
    RADDHN  V26.2S, V12.2D, V28.2D
    TBX  V30.16B, { V30.16B, V31.16B, V0.16B }, V11.16B
    SRI  V1.4S, V29.4S, #18
    ADD  V16.4H, V14.4H, V10.4H
    RSUBHN2  V24.16B, V30.8H, V22.8H
    UZP2  V15.16B, V16.16B, V1.16B
    PMULL  V5.1Q, V26.1D, V26.1D
    RSHRN V10.4H, V15.4S, #2
    MOV H29, V10.H[0x3]
    SHLL2  V2.4S, V29.8H, #16
    ORR  V20.4S, #0xc2, LSL #16
    TBX  V10.16B, { V5.16B }, V11.16B
    MLS  V14.4S, V24.4S, V10.4S
    MOV D15, V14.D[0x1]
    CNT  V29.16B, V20.16B
    MOV V22.H[0x3], V29.H[0x5]
    INS V16.B[0xb], W7
    CNT  V13.8B, V22.8B
    MOV  V30.8B, V15.8B
    MVNI  V15.2S, #0xe1
    RADDHN2  V25.8H, V2.4S, V16.4S
    CNT  V12.8B, V15.8B
    ZIP2  V15.2D, V12.2D, V13.2D
    TBX  V2.8B, { V25.16B }, V22.8B
    EOR  V10.16B, V30.16B, V2.16B
    MOV B24, V10.B[0x8]
    CNT  V12.16B, V24.16B
    REV16  V14.16B, V15.16B
    DUP V10.4S, W17
    MOV V16.B[0x6], V14.B[0x3]
    TRN1  V13.16B, V12.16B, V16.16B
    SUBHN2  V25.8H, V10.4S, V10.4S
    MOV V15.D[0x1], X15
    DUP D30, V13.D[0x0]
    DUP V24.4H, W23
    ORR  V2.4S, #0xa0
    PMUL  V10.8B, V25.8B, V2.8B
    RSHRN V11.8B, V30.8H, #8
    CLZ  V25.2S, V11.2S
    SHRN2 V11.4S, V25.2D, #19
    MVNI  V30.4S, #0xa4, MSL #8
    INS V2.D[0x0], V30.D[0x0]
    INS V22.D[0x1], X26
    SHL V13.2D, V22.2D, #0x8
    RADDHN  V20.8B, V11.8H, V13.8H
    MVN  V29.16B, V15.16B
    SHRN V15.4H, V18.4S, #7
    ZIP2  V30.2D, V10.2D, V10.2D
    UZP1  V11.16B, V2.16B, V30.16B
    NOT  V17.8B, V24.8B
    EOR  V25.16B, V29.16B, V17.16B
    AESMC  V16.16B, V15.16B
    BIT  V15.8B, V16.8B, V25.8B
    RSHRN V22.4H, V15.4S, #14
    SUBHN  V30.8B, V11.8H, V22.8H
    RSHRN2 V25.8H, V20.4S, #7
    NOT  V13.16B, V30.16B
    INS V29.D[0x0], V25.D[0x1]
    ADDHN2  V30.4S, V29.2D, V13.2D
    XTN  V20.4H, V9.4S
    SHRN2 V29.16B, V2.8H, #3
    EXT  V22.16B, V13.16B, V11.16B, #0x1
    INS V18.D[0x0], X5
    SLI  V11.2S, V30.2S, #0xb
    MOV H13, V26.H[0x2]
    SHRN V27.2S, V24.2D, #23
    SUBS  X9, X9, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_17
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X19, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X19, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X19, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X19, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X19, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X19, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X19, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X19, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X19, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X19, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X19, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X19, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X19, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X19, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X19, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X19, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X19, X10, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X19, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X19, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MRS  X19, FPSR
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X19, V0.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x3fcb, LSL #16
    MOVK  X10, #0x3fff, LSL #32
    MOVK  X10, #0x3fcb, LSL #48
    FMOV  X19, D0
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xc000, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xc000, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X19, V1.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x500, LSL #0
    FMOV  X19, D1
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xa0, LSL #0
    MOVK  X10, #0xa0, LSL #32
    FMOV  X19, V2.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x5b00, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0x5b00, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X19, D2
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X19, V3.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X19, D3
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X19, V4.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X19, D4
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X19, V5.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x1, LSL #0
    MOVK  X10, #0x4000, LSL #48
    FMOV  X19, D5
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X19, V6.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X19, D6
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X19, V7.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X19, D7
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X19, V8.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X19, D8
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X19, V9.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X19, D9
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X19, V10.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X19, D10
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X19, V11.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xff00, LSL #0
    MOVK  X10, #0x7ff, LSL #16
    MOVK  X10, #0xa0, LSL #32
    FMOV  X19, D11
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X19, V12.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X19, D12
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X19, V13.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X19, D13
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X19, V14.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X19, D14
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X19, V15.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X19, D15
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X19, V16.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X19, D16
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X19, V17.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X19, D17
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X19, V18.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X19, D18
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X19, V19.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X19, D19
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X19, V20.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X19, D20
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xc0c, LSL #0
    MOVK  X10, #0xc0c, LSL #16
    MOVK  X10, #0xc0c, LSL #32
    MOVK  X10, #0xc0c, LSL #48
    FMOV  X19, V21.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xff, LSL #0
    FMOV  X19, D21
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xff, LSL #48
    FMOV  X19, V22.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xff00, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X19, D22
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X19, V23.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X19, D23
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X19, V24.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X19, D24
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x4, LSL #0
    MOVK  X10, #0x2, LSL #16
    FMOV  X19, V25.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X19, D25
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X19, V26.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x1, LSL #0
    MOVK  X10, #0x8000, LSL #16
    FMOV  X19, D26
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X19, V27.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    FMOV  X19, D27
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X19, V28.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x4280, LSL #0
    MOVK  X10, #0x87c0, LSL #16
    MOVK  X10, #0x8000, LSL #48
    FMOV  X19, D28
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xff60, LSL #0
    MOVK  X10, #0xff60, LSL #16
    MOVK  X10, #0x14, LSL #32
    MOVK  X10, #0x14, LSL #48
    FMOV  X19, V29.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x4, LSL #0
    MOVK  X10, #0x2, LSL #16
    FMOV  X19, D29
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X19, V30.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    FMOV  X19, D30
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X19, V31.D[1]
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X19, D31
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xae81, LSL #0
    MOVK  X2, #0x91c7, LSL #16
    MOVK  X2, #0x6dc8, LSL #32
    MOVK  X2, #0x2972, LSL #48
    MOVZ  X4, #0x8c2d, LSL #0
    MOVK  X4, #0x7857, LSL #16
    MOVK  X4, #0x646e, LSL #32
    MOVK  X4, #0x7973, LSL #48
    MOVZ  X5, #0x309f, LSL #0
    MOVK  X5, #0x6993, LSL #16
    MOVK  X5, #0x5fa1, LSL #32
    MOVK  X5, #0x61d9, LSL #48
    MOVZ  X6, #0x31ea, LSL #0
    MOVK  X6, #0xab15, LSL #16
    MOVK  X6, #0x7a5d, LSL #32
    MOVK  X6, #0x42ca, LSL #48
    MOVZ  X7, #0xfe8b, LSL #0
    MOVK  X7, #0x5bab, LSL #16
    MOVK  X7, #0xc19e, LSL #32
    MOVK  X7, #0x7d71, LSL #48
    MOVZ  X8, #0x1eba, LSL #0
    MOVK  X8, #0xde6d, LSL #16
    MOVK  X8, #0xe19, LSL #32
    MOVK  X8, #0xe355, LSL #48
    MOVZ  X9, #0x1986, LSL #0
    MOVK  X9, #0x2466, LSL #16
    MOVK  X9, #0x5812, LSL #32
    MOVK  X9, #0xeb37, LSL #48
    MOVZ  X10, #0x714b, LSL #0
    MOVK  X10, #0x5fd7, LSL #16
    MOVK  X10, #0xf4ac, LSL #32
    MOVK  X10, #0x81ec, LSL #48
    MOVZ  X11, #0xd68b, LSL #0
    MOVK  X11, #0x3d6f, LSL #16
    MOVK  X11, #0xa902, LSL #32
    MOVK  X11, #0x2072, LSL #48
    MOVZ  X13, #0xd328, LSL #0
    MOVK  X13, #0x3590, LSL #16
    MOVK  X13, #0xbbfd, LSL #32
    MOVK  X13, #0xe956, LSL #48
    MOVZ  X14, #0x9100, LSL #0
    MOVK  X14, #0x3513, LSL #16
    MOVK  X14, #0xea0f, LSL #32
    MOVK  X14, #0x2cae, LSL #48
    MOVZ  X15, #0xdf31, LSL #0
    MOVK  X15, #0xb094, LSL #16
    MOVK  X15, #0x69c, LSL #32
    MOVK  X15, #0x943c, LSL #48
    MOVZ  X16, #0x154a, LSL #0
    MOVK  X16, #0xab6f, LSL #16
    MOVK  X16, #0xf8a4, LSL #32
    MOVK  X16, #0xdec9, LSL #48
    MOVZ  X17, #0x248a, LSL #0
    MOVK  X17, #0x6b2a, LSL #16
    MOVK  X17, #0x62cc, LSL #32
    MOVK  X17, #0x9d4a, LSL #48
    MOVZ  X18, #0x4d5d, LSL #0
    MOVK  X18, #0x937e, LSL #16
    MOVK  X18, #0xa46c, LSL #32
    MOVK  X18, #0x1398, LSL #48
    MOVZ  X19, #0xd49b, LSL #0
    MOVK  X19, #0x90be, LSL #16
    MOVK  X19, #0x2351, LSL #32
    MOVK  X19, #0xa56, LSL #48
    MOVZ  X20, #0x62c3, LSL #0
    MOVK  X20, #0x7709, LSL #16
    MOVK  X20, #0xffaf, LSL #32
    MOVK  X20, #0x810b, LSL #48
    MOVZ  X21, #0x56e0, LSL #0
    MOVK  X21, #0xa85e, LSL #16
    MOVK  X21, #0x86df, LSL #32
    MOVK  X21, #0xf0f4, LSL #48
    MOVZ  X23, #0x23a3, LSL #0
    MOVK  X23, #0xa31b, LSL #16
    MOVK  X23, #0x82d4, LSL #32
    MOVK  X23, #0xcc16, LSL #48
    MOVZ  X24, #0x99f0, LSL #0
    MOVK  X24, #0x41f8, LSL #16
    MOVK  X24, #0x4d2e, LSL #32
    MOVK  X24, #0xb478, LSL #48
    MOVZ  X25, #0xa061, LSL #0
    MOVK  X25, #0x8a6a, LSL #16
    MOVK  X25, #0xf939, LSL #32
    MOVK  X25, #0x7ad6, LSL #48
    MOVZ  X26, #0x6270, LSL #0
    MOVK  X26, #0x14ce, LSL #16
    MOVK  X26, #0xd301, LSL #32
    MOVK  X26, #0x9ca2, LSL #48
    MOVZ  X27, #0xb6e9, LSL #0
    MOVK  X27, #0xaed, LSL #16
    MOVK  X27, #0xe747, LSL #32
    MOVK  X27, #0xc6ed, LSL #48
    MOVZ  X28, #0x7479, LSL #0
    MOVK  X28, #0x6bd0, LSL #16
    MOVK  X28, #0x6c51, LSL #32
    MOVK  X28, #0xbe24, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X24
    FMOV  D1, X28
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X17
    FMOV  D3, X28
    FMOV  V3.D[1], X17
    FMOV  D4, X6
    FMOV  V4.D[1], X17
    FMOV  D5, X20
    FMOV  V5.D[1], X13
    FMOV  D6, X10
    FMOV  V6.D[1], X9
    FMOV  D7, X15
    FMOV  V7.D[1], X6
    FMOV  D8, X25
    FMOV  V8.D[1], X19
    FMOV  D9, X14
    FMOV  V9.D[1], X5
    FMOV  D10, X10
    FMOV  V10.D[1], X5
    FMOV  D11, X16
    FMOV  V11.D[1], X15
    FMOV  D12, X2
    FMOV  V12.D[1], X2
    FMOV  D13, X9
    FMOV  V13.D[1], X14
    FMOV  D14, X28
    FMOV  V14.D[1], X24
    FMOV  D15, X6
    FMOV  V15.D[1], X8
    FMOV  D16, X6
    FMOV  V16.D[1], X10
    FMOV  D17, X24
    FMOV  V17.D[1], X4
    FMOV  D18, X24
    FMOV  V18.D[1], X13
    FMOV  D19, X7
    FMOV  V19.D[1], X6
    FMOV  D20, X4
    FMOV  V20.D[1], X5
    FMOV  D21, X9
    FMOV  V21.D[1], X16
    FMOV  D22, X7
    FMOV  V22.D[1], X26
    FMOV  D23, X19
    FMOV  V23.D[1], X5
    FMOV  D24, X7
    FMOV  V24.D[1], X7
    FMOV  D25, X7
    FMOV  V25.D[1], X11
    FMOV  D26, X7
    FMOV  V26.D[1], X28
    FMOV  D27, X15
    FMOV  V27.D[1], X4
    FMOV  D28, X11
    FMOV  V28.D[1], X16
    FMOV  D29, X8
    FMOV  V29.D[1], X21
    FMOV  D30, X24
    FMOV  V30.D[1], X20
    FMOV  D31, X15
    FMOV  V31.D[1], X13
    MOVZ  X11, #0xf, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_18:
    SHRN V13.8B, V31.8H, #5
    BIC  V19.4S, #0xab, LSL #24
    UZP2  V31.2D, V24.2D, V20.2D
    MOV S16, V13.S[0x1]
    SRI V5.2D, V29.2D, #38
    DUP H8, V31.H[0x0]
    DUP V27.2D, X2
    RSUBHN  V18.8B, V28.8H, V5.8H
    ZIP2  V12.8B, V18.8B, V26.8B
    BIC  V13.16B, V8.16B, V27.16B
    MOV H11, V30.H[0x2]
    ORR  V9.4S, #0x78, LSL #8
    NOT  V10.16B, V25.16B
    DUP  V29.8B, V10.B[0x3]
    MUL  V18.4S, V28.4S, V29.S[0x0]
    MUL  V14.8H, V12.8H, V11.8H
    SHRN2 V15.16B, V16.8H, #8
    INS V27.H[0x3], W26
    ADDHN  V24.4H, V19.4S, V9.4S
    MOV V18.B[0x0], V19.B[0xe]
    DUP  V26.8B, V24.B[0xd]
    MOV V8.S[0x1], V14.S[0x3]
    MVNI  V25.4H, #0xa2, LSL #8
    ADDV  H31, V25.8H
    ORR  V29.4H, #0x15
    MUL  V25.2S, V31.2S, V27.S[0x3]
    EXT  V5.8B, V9.8B, V29.8B, #0x1
    MLS  V27.2S, V5.2S, V17.S[0x1]
    MOV V19.H[0x1], W26
    CNT  V12.16B, V15.16B
    MOV V24.H[0x1], V12.H[0x1]
    REV16  V31.8B, V24.8B
    MOV D28, V25.D[0x1]
    TBL  V29.16B, { V1.16B, V2.16B, V3.16B }, V27.16B
    MOV V30.D[0x0], V18.D[0x1]
    TBX  V14.16B, { V13.16B }, V19.16B
    CNT  V16.16B, V31.16B
    BIT  V12.16B, V28.16B, V8.16B
    SRI V10.2D, V29.2D, #12
    CLS  V28.8H, V22.8H
    REV64  V13.4H, V28.4H
    DUP V2.8B, W28
    EOR  V31.16B, V13.16B, V30.16B
    MUL  V25.2S, V31.2S, V31.S[0x2]
    EOR  V22.16B, V2.16B, V26.16B
    RSUBHN  V5.8B, V2.8H, V25.8H
    ADDV  S18, V14.4S
    DUP  V24.8B, V18.B[0xf]
    MLA  V18.4H, V16.4H, V10.H[0x4]
    SLI V13.2D, V1.2D, #0x36
    MOV B25, V5.B[0x4]
    INS V10.S[0x2], V18.S[0x3]
    TBL  V29.16B, { V25.16B }, V10.16B
    SHRN V2.2S, V22.2D, #3
    MVNI  V19.4H, #0x35
    SUB  V1.4H, V1.4H, V12.4H
    MOV S10, V2.S[0x1]
    MVNI  V8.2S, #0xf2, LSL #8
    ORR  V30.4S, #0xbe, LSL #16
    MOVI  V18.2S, #0x2f, LSL #24
    DUP H5, V1.H[0x7]
    SRI  V31.2S, V24.2S, #8
    RADDHN  V16.8B, V13.8H, V19.8H
    CLZ  V27.8B, V10.8B
    MLA  V13.2S, V18.2S, V27.S[0x0]
    DUP S18, V31.S[0x1]
    MOV  X10, V18.D[0x1]
    ADDHN  V22.4H, V13.4S, V29.4S
    SHLL  V2.4S, V22.4H, #16
    DUP  V31.16B, V16.B[0x8]
    MOV V16.S[0x3], V2.S[0x3]
    INS V14.S[0x1], W20
    MOV V24.B[0x5], V5.B[0x0]
    SHLL  V22.2D, V16.2S, #32
    PMUL  V29.16B, V31.16B, V20.16B
    SRI  V1.8B, V29.8B, #2
    MOV H2, V22.H[0x5]
    MOV V5.B[0x2], V14.B[0x7]
    SHL V22.2D, V30.2D, #0x25
    SLI V20.2D, V22.2D, #0x18
    XTN2  V13.16B, V24.8H
    SRI  V12.16B, V1.16B, #6
    INS V27.S[0x2], V12.S[0x2]
    INS V22.S[0x3], W4
    DUP  V31.4S, V8.S[0x3]
    ADDP  V16.4H, V2.4H, V2.4H
    MOV V8.H[0x0], W24
    MOV V12.H[0x3], W19
    XTN  V29.2S, V5.2D
    INS V14.D[0x1], X8
    MOVI  V24.16B, #0x52
    BIC  V1.4H, #0x77
    MOV B30, V16.B[0x5]
    SLI  V5.16B, V14.16B, #0x0
    MOV  X25, V16.D[0x1]
    REV16  V2.8B, V1.8B
    ADDV  B1, V8.16B
    DUP V14.2D, V22.D[0x0]
    PMUL  V22.16B, V5.16B, V27.16B
    INS V27.D[0x1], X19
    TRN1  V5.4H, V22.4H, V14.4H
    UZP2  V16.4H, V2.4H, V31.4H
    MVNI  V2.2S, #0x5, MSL #16
    BSL  V8.16B, V2.16B, V13.16B
    ORR  V22.2S, #0x50, LSL #16
    MOVI  V14.4S, #0x3
    AESMC  V31.16B, V5.16B
    DUP S2, V22.S[0x2]
    RSHRN V22.4H, V20.4S, #12
    RSHRN V20.8B, V2.8H, #8
    MLS  V2.8H, V1.8H, V1.8H
    MVNI  V5.2S, #0x23, MSL #8
    TBL  V29.8B, { V0.16B, V1.16B }, V31.8B
    MUL  V29.8H, V30.8H, V14.8H
    EXT  V31.16B, V29.16B, V2.16B, #0xd
    INS V18.B[0xd], W14
    AESIMC  V14.16B, V12.16B
    MLA  V19.4H, V27.4H, V5.H[0x5]
    DUP V15.2D, X4
    MOVI  V16.8H, #0x77, LSL #8
    RADDHN  V26.8B, V22.8H, V14.8H
    SLI  V8.8B, V20.8B, #0x4
    MVNI  V0.2S, #0x9d, MSL #16
    DUP  V12.16B, V16.B[0x4]
    REV64  V8.4S, V31.4S
    INS V21.H[0x3], V18.H[0x1]
    SUB  V29.16B, V17.16B, V12.16B
    SRI  V31.4S, V29.4S, #26
    REV32  V22.4H, V12.4H
    RSHRN2 V27.4S, V22.2D, #12
    ABS  V13.8B, V19.8B
    EXT  V21.16B, V13.16B, V21.16B, #0xa
    MOV V21.S[0x1], V0.S[0x0]
    SHL V29.2D, V26.2D, #0x33
    ADDV  S22, V8.4S
    TBL  V8.16B, { V10.16B, V11.16B, V12.16B }, V29.16B
    CLS  V19.8H, V31.8H
    SHL  V16.16B, V8.16B, #0x3
    REV16  V8.16B, V27.16B
    DUP  V27.8B, V16.B[0xd]
    MLS  V0.4S, V21.4S, V21.S[0x2]
    BIF  V20.8B, V19.8B, V22.8B
    ORR  V13.4S, #0x7d
    TBL  V31.16B, { V13.16B }, V20.16B
    INS V2.D[0x0], X20
    INS V21.H[0x4], W16
    EXT  V17.8B, V31.8B, V21.8B, #0x3
    SLI V31.2D, V0.2D, #0x3b
    SHL  V29.8H, V31.8H, #0x6
    SHLL  V14.4S, V2.4H, #16
    CLZ  V12.8H, V27.8H
    MVNI  V21.2S, #0xd4
    MVN  V2.8B, V12.8B
    SLI  V0.4S, V29.4S, #0x17
    MVNI  V20.8H, #0xa1
    TRN2  V19.2S, V17.2S, V0.2S
    DUP V17.2D, X16
    SHL  V31.2S, V20.2S, #0x7
    BIC  V20.4S, #0x7
    MOVI  V13.2D, #71777218572779520
    REV16  V12.8B, V8.8B
    PMULL2  V27.8H, V5.16B, V19.16B
    MVN  V22.16B, V27.16B
    MOV H0, V22.H[0x6]
    ADDP  D29, V20.2D
    RSHRN2 V20.8H, V14.4S, #15
    BIC  V22.2S, #0xd0, LSL #8
    MOV V8.B[0xa], W15
    MUL  V19.4S, V31.4S, V2.S[0x3]
    DUP  V14.4S, V22.S[0x0]
    EXT  V31.16B, V3.16B, V0.16B, #0x2
    ZIP2  V2.2S, V0.2S, V17.2S
    DUP V5.2D, V14.D[0x1]
    MOV  V0.8B, V20.8B
    MOVI  V14.4S, #0x70, LSL #24
    TBX  V27.8B, { V8.16B }, V19.8B
    UZP2  V20.2S, V29.2S, V5.2S
    CLZ  V22.2S, V31.2S
    DUP V3.8B, W4
    TBL  V31.8B, { V12.16B }, V0.8B
    BSL  V17.8B, V22.8B, V31.8B
    ADDV  B5, V17.8B
    MUL  V19.4H, V5.4H, V5.H[0x4]
    MOV V17.B[0xb], W7
    CLS  V0.2S, V2.2S
    DUP H8, V14.H[0x1]
    BIC  V31.16B, V8.16B, V0.16B
    SRI  V29.4S, V19.4S, #16
    MLA  V12.4S, V29.4S, V29.S[0x3]
    MVN  V29.8B, V12.8B
    RSUBHN  V14.2S, V17.2D, V27.2D
    AND  V17.8B, V20.8B, V3.8B
    ADDV  S0, V17.4S
    SHRN2 V17.8H, V1.4S, #16
    INS V1.D[0x1], X19
    BIT  V12.8B, V1.8B, V31.8B
    TBX  V1.8B, { V12.16B }, V12.8B
    SHRN V27.2S, V17.2D, #2
    BIC  V7.2S, #0xac
    ZIP2  V14.2D, V7.2D, V29.2D
    SUBS  X11, X11, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_18
    MOVZ  X18, #0xae81, LSL #0
    MOVK  X18, #0x91c7, LSL #16
    MOVK  X18, #0x6dc8, LSL #32
    MOVK  X18, #0x2972, LSL #48
    SUB  X5, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x8c2d, LSL #0
    MOVK  X18, #0x7857, LSL #16
    MOVK  X18, #0x646e, LSL #32
    MOVK  X18, #0x7973, LSL #48
    SUB  X5, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x31ea, LSL #0
    MOVK  X18, #0xab15, LSL #16
    MOVK  X18, #0x7a5d, LSL #32
    MOVK  X18, #0x42ca, LSL #48
    SUB  X5, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0xfe8b, LSL #0
    MOVK  X18, #0x5bab, LSL #16
    MOVK  X18, #0xc19e, LSL #32
    MOVK  X18, #0x7d71, LSL #48
    SUB  X5, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x1eba, LSL #0
    MOVK  X18, #0xde6d, LSL #16
    MOVK  X18, #0xe19, LSL #32
    MOVK  X18, #0xe355, LSL #48
    SUB  X5, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0xd328, LSL #0
    MOVK  X18, #0x3590, LSL #16
    MOVK  X18, #0xbbfd, LSL #32
    MOVK  X18, #0xe956, LSL #48
    SUB  X5, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x9100, LSL #0
    MOVK  X18, #0x3513, LSL #16
    MOVK  X18, #0xea0f, LSL #32
    MOVK  X18, #0x2cae, LSL #48
    SUB  X5, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0xdf31, LSL #0
    MOVK  X18, #0xb094, LSL #16
    MOVK  X18, #0x69c, LSL #32
    MOVK  X18, #0x943c, LSL #48
    SUB  X5, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x154a, LSL #0
    MOVK  X18, #0xab6f, LSL #16
    MOVK  X18, #0xf8a4, LSL #32
    MOVK  X18, #0xdec9, LSL #48
    SUB  X5, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x248a, LSL #0
    MOVK  X18, #0x6b2a, LSL #16
    MOVK  X18, #0x62cc, LSL #32
    MOVK  X18, #0x9d4a, LSL #48
    SUB  X5, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0xd49b, LSL #0
    MOVK  X18, #0x90be, LSL #16
    MOVK  X18, #0x2351, LSL #32
    MOVK  X18, #0xa56, LSL #48
    SUB  X5, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x62c3, LSL #0
    MOVK  X18, #0x7709, LSL #16
    MOVK  X18, #0xffaf, LSL #32
    MOVK  X18, #0x810b, LSL #48
    SUB  X5, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x56e0, LSL #0
    MOVK  X18, #0xa85e, LSL #16
    MOVK  X18, #0x86df, LSL #32
    MOVK  X18, #0xf0f4, LSL #48
    SUB  X5, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x23a3, LSL #0
    MOVK  X18, #0xa31b, LSL #16
    MOVK  X18, #0x82d4, LSL #32
    MOVK  X18, #0xcc16, LSL #48
    SUB  X5, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x99f0, LSL #0
    MOVK  X18, #0x41f8, LSL #16
    MOVK  X18, #0x4d2e, LSL #32
    MOVK  X18, #0xb478, LSL #48
    SUB  X5, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x6270, LSL #0
    MOVK  X18, #0x14ce, LSL #16
    MOVK  X18, #0xd301, LSL #32
    MOVK  X18, #0x9ca2, LSL #48
    SUB  X5, X18, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0xb6e9, LSL #0
    MOVK  X18, #0xaed, LSL #16
    MOVK  X18, #0xe747, LSL #32
    MOVK  X18, #0xc6ed, LSL #48
    SUB  X5, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x7479, LSL #0
    MOVK  X18, #0x6bd0, LSL #16
    MOVK  X18, #0x6c51, LSL #32
    MOVK  X18, #0xbe24, LSL #48
    SUB  X5, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    MRS  X5, FPSR
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, V0.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x594e, LSL #0
    MOVK  X18, #0x595a, LSL #16
    FMOV  X5, D0
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, V1.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, D1
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, V2.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xf8a4, LSL #32
    MOVK  X18, #0xdec9, LSL #48
    FMOV  X5, D2
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, V3.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x2d2d, LSL #0
    MOVK  X18, #0x2d2d, LSL #16
    MOVK  X18, #0x2d2d, LSL #32
    MOVK  X18, #0x2d2d, LSL #48
    FMOV  X5, D3
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x248a, LSL #0
    MOVK  X18, #0x6b2a, LSL #16
    MOVK  X18, #0x62cc, LSL #32
    MOVK  X18, #0x9d4a, LSL #48
    FMOV  X5, V4.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x31ea, LSL #0
    MOVK  X18, #0xab15, LSL #16
    MOVK  X18, #0x7a5d, LSL #32
    MOVK  X18, #0x42ca, LSL #48
    FMOV  X5, D4
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, V5.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x2, LSL #0
    FMOV  X5, D5
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x1986, LSL #0
    MOVK  X18, #0x2466, LSL #16
    MOVK  X18, #0x5812, LSL #32
    MOVK  X18, #0xeb37, LSL #48
    FMOV  X5, V6.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x714b, LSL #0
    MOVK  X18, #0x5fd7, LSL #16
    MOVK  X18, #0xf4ac, LSL #32
    MOVK  X18, #0x81ec, LSL #48
    FMOV  X5, D6
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, V7.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0xdf11, LSL #0
    MOVK  X18, #0xb094, LSL #16
    MOVK  X18, #0x610, LSL #32
    MOVK  X18, #0x943c, LSL #48
    FMOV  X5, D7
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, V8.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x7000, LSL #0
    FMOV  X5, D8
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x789f, LSL #0
    MOVK  X18, #0x6993, LSL #16
    MOVK  X18, #0x7fa1, LSL #32
    MOVK  X18, #0x61d9, LSL #48
    FMOV  X5, V9.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0xf900, LSL #0
    MOVK  X18, #0x3513, LSL #16
    MOVK  X18, #0xfa0f, LSL #32
    MOVK  X18, #0x2cae, LSL #48
    FMOV  X5, D9
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, V10.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, D10
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, V11.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, D11
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, V12.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x808, LSL #0
    MOVK  X18, #0x808, LSL #16
    MOVK  X18, #0x808, LSL #32
    MOVK  X18, #0x808, LSL #48
    FMOV  X5, D12
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xff, LSL #32
    MOVK  X18, #0xff, LSL #48
    FMOV  X5, V13.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xff, LSL #32
    MOVK  X18, #0xff, LSL #48
    FMOV  X5, D13
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, V14.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, D14
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x8c2d, LSL #0
    MOVK  X18, #0x7857, LSL #16
    MOVK  X18, #0x646e, LSL #32
    MOVK  X18, #0x7973, LSL #48
    FMOV  X5, V15.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x8c2d, LSL #0
    MOVK  X18, #0x7857, LSL #16
    MOVK  X18, #0x646e, LSL #32
    MOVK  X18, #0x7973, LSL #48
    FMOV  X5, D15
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, V16.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, D16
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, V17.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x2c21, LSL #0
    MOVK  X18, #0x2c2d, LSL #16
    MOVK  X18, #0x2d2d, LSL #32
    MOVK  X18, #0x2d2d, LSL #48
    FMOV  X5, D17
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, V18.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xff00, LSL #16
    FMOV  X5, D18
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, V19.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, D19
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, V20.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0xfeb1, LSL #0
    MOVK  X18, #0xfebd, LSL #16
    MOVK  X18, #0x2fff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    FMOV  X5, D20
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, V21.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0xff2b, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xff2b, LSL #32
    MOVK  X18, #0xffff, LSL #48
    FMOV  X5, D21
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, V22.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x2, LSL #0
    MOVK  X18, #0x12, LSL #32
    FMOV  X5, D22
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x309f, LSL #0
    MOVK  X18, #0x6993, LSL #16
    MOVK  X18, #0x5fa1, LSL #32
    MOVK  X18, #0x61d9, LSL #48
    FMOV  X5, V23.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0xd49b, LSL #0
    MOVK  X18, #0x90be, LSL #16
    MOVK  X18, #0x2351, LSL #32
    MOVK  X18, #0xa56, LSL #48
    FMOV  X5, D23
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x5252, LSL #0
    MOVK  X18, #0x5252, LSL #16
    MOVK  X18, #0x5252, LSL #32
    MOVK  X18, #0x5252, LSL #48
    FMOV  X5, V24.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x5252, LSL #0
    MOVK  X18, #0x5252, LSL #16
    MOVK  X18, #0x5252, LSL #32
    MOVK  X18, #0x5252, LSL #48
    FMOV  X5, D24
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, V25.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, D25
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, V26.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x334b, LSL #0
    MOVK  X18, #0x3d7c, LSL #16
    FMOV  X5, D26
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, V27.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x4b08, LSL #0
    MOVK  X18, #0x4b0b, LSL #16
    FMOV  X5, D27
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0xf, LSL #0
    MOVK  X18, #0xf, LSL #16
    MOVK  X18, #0xf, LSL #32
    MOVK  X18, #0xf, LSL #48
    FMOV  X5, V28.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0xd, LSL #0
    MOVK  X18, #0xf, LSL #16
    MOVK  X18, #0xa, LSL #32
    MOVK  X18, #0xf, LSL #48
    FMOV  X5, D28
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, V29.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0xf7f7, LSL #0
    MOVK  X18, #0xf7f7, LSL #16
    MOVK  X18, #0xf7f7, LSL #32
    MOVK  X18, #0xf7f7, LSL #48
    FMOV  X5, D29
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, V30.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, D30
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X5, V31.D[1]
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X18, #0x7000, LSL #0
    FMOV  X5, D31
    SUB  X9, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    FMOV  D0, X15
    FMOV  V0.D[1], X16
    FMOV  D1, X9
    FMOV  V1.D[1], X14
    FMOV  D2, X28
    FMOV  V2.D[1], X23
    FMOV  D3, X20
    FMOV  V3.D[1], X17
    FMOV  D4, X25
    FMOV  V4.D[1], X27
    FMOV  D5, X19
    FMOV  V5.D[1], X24
    FMOV  D6, X26
    FMOV  V6.D[1], X21
    FMOV  D7, X19
    FMOV  V7.D[1], X5
    FMOV  D8, X9
    FMOV  V8.D[1], X13
    FMOV  D9, X26
    FMOV  V9.D[1], X6
    FMOV  D10, X25
    FMOV  V10.D[1], X9
    FMOV  D11, X24
    FMOV  V11.D[1], X4
    FMOV  D12, X8
    FMOV  V12.D[1], X11
    FMOV  D13, X16
    FMOV  V13.D[1], X13
    FMOV  D14, X11
    FMOV  V14.D[1], X25
    FMOV  D15, X2
    FMOV  V15.D[1], X9
    FMOV  D16, X13
    FMOV  V16.D[1], X6
    FMOV  D17, X24
    FMOV  V17.D[1], X23
    FMOV  D18, X24
    FMOV  V18.D[1], X27
    FMOV  D19, X18
    FMOV  V19.D[1], X28
    FMOV  D20, X13
    FMOV  V20.D[1], X9
    FMOV  D21, X13
    FMOV  V21.D[1], X15
    FMOV  D22, X6
    FMOV  V22.D[1], X28
    FMOV  D23, X20
    FMOV  V23.D[1], X11
    FMOV  D24, X7
    FMOV  V24.D[1], X25
    FMOV  D25, X14
    FMOV  V25.D[1], X16
    FMOV  D26, X23
    FMOV  V26.D[1], X23
    FMOV  D27, X6
    FMOV  V27.D[1], X28
    FMOV  D28, X15
    FMOV  V28.D[1], X14
    FMOV  D29, X6
    FMOV  V29.D[1], X20
    FMOV  D30, X5
    FMOV  V30.D[1], X17
    FMOV  D31, X20
    FMOV  V31.D[1], X13
    MOVZ  X19, #0xf, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_19:
    DUP  V3.2S, V23.S[0x0]
    ADDV  H22, V27.8H
    SHRN2 V17.4S, V25.2D, #18
    MUL  V16.16B, V31.16B, V24.16B
    REV32  V9.4H, V29.4H
    TBL  V25.16B, { V16.16B, V17.16B }, V30.16B
    SRI  V3.4H, V28.4H, #14
    SHLL  V5.2D, V26.2S, #32
    MLS  V27.2S, V22.2S, V9.S[0x1]
    MUL  V13.4H, V27.4H, V3.H[0x7]
    DUP V15.2D, X13
    TRN2  V18.8B, V13.8B, V13.8B
    MVN  V9.8B, V15.8B
    INS V14.B[0x4], V25.B[0x3]
    PMUL  V13.16B, V5.16B, V5.16B
    AESE  V23.16B, V13.16B
    SUB  V13.8B, V14.8B, V18.8B
    SHL V5.2D, V13.2D, #0x3d
    MOV H27, V26.H[0x7]
    MOV V12.B[0x7], V27.B[0xd]
    MOV D31, V12.D[0x0]
    MLA  V3.2S, V5.2S, V9.S[0x1]
    MOV B29, V23.B[0x0]
    DUP  V25.4H, V29.H[0x0]
    TBX  V26.8B, { V17.16B, V18.16B, V19.16B }, V31.8B
    RSHRN V30.8B, V3.8H, #4
    ADDV  H17, V9.4H
    DUP B22, V19.B[0x2]
    EOR  V5.16B, V26.16B, V25.16B
    MOV D19, V17.D[0x1]
    RSUBHN  V9.8B, V30.8H, V30.8H
    SLI  V29.4H, V9.4H, #0x6
    BIT  V17.16B, V29.16B, V25.16B
    ADDP  V30.4H, V17.4H, V22.4H
    MOV  X8, V19.D[0x1]
    MOV  X26, V30.D[0x0]
    MOV H25, V17.H[0x3]
    RSHRN2 V29.16B, V11.8H, #1
    RSHRN V22.2S, V4.2D, #8
    SLI V23.2D, V26.2D, #0x11
    SRI  V3.2S, V18.2S, #2
    ADD  V9.8B, V25.8B, V24.8B
    ZIP1  V31.2S, V4.2S, V24.2S
    EXT  V4.16B, V2.16B, V11.16B, #0x7
    RSHRN2 V17.8H, V19.4S, #8
    RSUBHN  V26.4H, V9.4S, V7.4S
    SLI  V14.4S, V6.4S, #0x9
    MOV V6.D[0x0], V3.D[0x0]
    MOV V30.B[0x4], W6
    MOV V18.H[0x2], W24
    EXT  V25.16B, V30.16B, V26.16B, #0x0
    SLI  V3.8H, V31.8H, #0x1
    BIT  V31.16B, V4.16B, V18.16B
    AESD  V28.16B, V3.16B
    MOV V3.D[0x1], V31.D[0x0]
    SLI V24.2D, V14.2D, #0x1a
    SUBHN2  V2.16B, V29.8H, V28.8H
    SUBHN2  V11.16B, V2.8H, V25.8H
    TBX  V29.16B, { V23.16B, V24.16B, V25.16B, V26.16B }, V6.16B
    RSHRN V23.2S, V29.2D, #31
    INS V28.D[0x0], V11.D[0x0]
    MOV V7.H[0x6], W6
    DUP V4.4H, W18
    MOV V7.D[0x0], X14
    DUP  V30.4S, V7.S[0x2]
    BSL  V19.8B, V3.8B, V4.8B
    ABS  V11.2S, V19.2S
    SRI  V9.8H, V11.8H, #3
    MOVI  V7.2S, #0x44, LSL #24
    MLA  V11.4H, V30.4H, V6.H[0x2]
    MUL  V31.4S, V7.4S, V11.S[0x3]
    BIT  V25.16B, V17.16B, V17.16B
    MUL  V29.8H, V28.8H, V9.H[0x3]
    MOV H3, V23.H[0x6]
    EOR  V30.16B, V31.16B, V29.16B
    SUB  V4.8B, V3.8B, V4.8B
    INS V7.D[0x0], V30.D[0x1]
    SHL  V26.4H, V12.4H, #0x8
    SLI V11.2D, V3.2D, #0xe
    TRN1  V18.4S, V11.4S, V12.4S
    SHL  V6.4S, V18.4S, #0x1f
    DUP V29.8H, W6
    TBL  V17.16B, { V18.16B, V19.16B, V20.16B }, V25.16B
    EXT  V11.8B, V7.8B, V4.8B, #0x4
    MOV  V12.16B, V29.16B
    ABS  V19.2D, V6.2D
    REV16  V28.8B, V26.8B
    EXT  V2.8B, V28.8B, V29.8B, #0x5
    RADDHN2  V9.8H, V11.4S, V12.4S
    MOVI  V3.8H, #0x36, LSL #8
    ADDV  S12, V19.4S
    MOV  X4, V12.D[0x1]
    RSHRN V30.2S, V17.2D, #16
    ADDV  B26, V9.8B
    CLZ  V31.2S, V3.2S
    MUL  V9.16B, V2.16B, V31.16B
    DUP V6.2S, W5
    MVNI  V28.4S, #0x9a, MSL #16
    INS V2.H[0x0], W4
    MOV  W17, V2.S[0x3]
    MOVI  V31.16B, #0x1b
    TBL  V20.8B, { V8.16B, V9.16B, V10.16B }, V16.8B
    REV16  V19.16B, V20.16B
    BIF  V23.8B, V14.8B, V31.8B
    ORR  V11.4H, #0x69, LSL #8
    RBIT  V31.16B, V11.16B
    SLI V29.2D, V28.2D, #0x1d
    SHLL  V3.8H, V29.8B, #8
    ABS  V4.8H, V6.8H
    SLI  V18.16B, V26.16B, #0x4
    RSHRN2 V14.16B, V4.8H, #7
    BSL  V12.16B, V18.16B, V14.16B
    RSHRN V17.8B, V3.8H, #6
    MOV V9.D[0x0], X5
    XTN2  V28.8H, V30.4S
    AESIMC  V29.16B, V17.16B
    MOVI  V28.4H, #0x29, LSL #8
    DUP V14.8B, W8
    SUBHN  V10.8B, V19.8H, V12.8H
    AESMC  V16.16B, V28.16B
    ORR  V28.16B, V14.16B, V31.16B
    MOV H4, V29.H[0x2]
    ADD  V3.16B, V9.16B, V16.16B
    SHRN V11.4H, V10.4S, #2
    MLS  V17.4H, V28.4H, V11.H[0x3]
    MOV V29.D[0x1], X28
    PMUL  V16.16B, V29.16B, V17.16B
    MOV V6.B[0x3], W19
    EOR  V17.16B, V4.16B, V4.16B
    AESMC  V30.16B, V3.16B
    MUL  V29.8H, V23.8H, V14.H[0x2]
    SHRN2 V31.8H, V29.4S, #12
    TBL  V11.8B, { V22.16B, V23.16B, V24.16B, V25.16B }, V17.8B
    SHRN2 V26.8H, V16.4S, #3
    SHL  V25.4H, V31.4H, #0x7
    DUP  V23.2S, V11.S[0x3]
    BIT  V4.16B, V23.16B, V26.16B
    TBX  V19.8B, { V26.16B, V27.16B, V28.16B, V29.16B }, V6.8B
    MLS  V3.4S, V4.4S, V4.S[0x2]
    RBIT  V18.8B, V25.8B
    SHRN V22.8B, V30.8H, #1
    SHRN V31.8B, V18.8H, #5
    SUBHN  V6.2S, V3.2D, V31.2D
    ORR  V11.16B, V19.16B, V6.16B
    AND  V12.16B, V22.16B, V11.16B
    AESE  V16.16B, V4.16B
    DUP B24, V9.B[0xc]
    DUP  V6.8H, V15.H[0x4]
    MVN  V30.16B, V8.16B
    MVN  V10.8B, V11.8B
    SUBHN2  V12.8H, V5.4S, V26.4S
    MOV  V25.16B, V9.16B
    INS V23.H[0x4], V28.H[0x4]
    ABS  V4.16B, V17.16B
    ADDV  H8, V24.4H
    SLI  V26.4H, V31.4H, #0x8
    DUP V29.8H, W5
    CLS  V22.8H, V25.8H
    DUP  V9.4H, V30.H[0x1]
    MOV D17, V12.D[0x1]
    SHRN V24.2S, V4.2D, #11
    MOV B28, V22.B[0x4]
    MLA  V22.4S, V26.4S, V6.S[0x2]
    INS V25.S[0x0], W23
    RSHRN V4.4H, V16.4S, #2
    MOV V6.S[0x1], V4.S[0x3]
    MOV V30.S[0x0], W20
    MOV V16.B[0x2], V22.B[0x1]
    AESE  V31.16B, V8.16B
    AND  V12.16B, V30.16B, V9.16B
    SHLL2  V26.8H, V16.16B, #8
    MOV H9, V10.H[0x1]
    TBX  V16.16B, { V23.16B, V24.16B }, V6.16B
    ORN  V23.8B, V17.8B, V26.8B
    SHLL  V4.4S, V31.4H, #16
    RSHRN V10.2S, V29.2D, #24
    INS V31.H[0x3], V4.H[0x2]
    BIT  V24.16B, V16.16B, V23.16B
    RADDHN2  V30.8H, V9.4S, V9.4S
    RBIT  V6.8B, V25.8B
    ZIP2  V8.2S, V25.2S, V12.2S
    DUP V29.2D, V28.D[0x1]
    MOV D17, V29.D[0x1]
    BIF  V12.8B, V10.8B, V24.8B
    PMULL2  V23.8H, V12.16B, V12.16B
    ADDHN2  V10.16B, V23.8H, V8.8H
    RSUBHN2  V1.4S, V10.2D, V10.2D
    REV32  V28.8B, V17.8B
    ADDHN  V23.8B, V1.8H, V13.8H
    RSHRN V16.2S, V31.2D, #16
    INS V25.S[0x2], V30.S[0x1]
    SHLL  V12.8H, V6.8B, #8
    MOV  X2, V12.D[0x1]
    MLS  V8.2S, V23.2S, V28.S[0x1]
    EOR  V24.16B, V8.16B, V8.16B
    SHLL  V10.4S, V24.4H, #16
    AESE  V9.16B, V25.16B
    BIC  V29.2S, #0xc4, LSL #16
    SRI  V26.8H, V9.8H, #11
    SRI  V9.2S, V16.2S, #13
    SUBS  X19, X19, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_19
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xffbf, LSL #0
    SUB  X11, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    MRS  X11, FPSR
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, V0.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, D0
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, V1.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, D1
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, V2.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, D2
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, V3.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x7b52, LSL #0
    MOVK  X27, #0x7b52, LSL #16
    MOVK  X27, #0x7b52, LSL #32
    MOVK  X27, #0x7b52, LSL #48
    FMOV  X11, D3
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x6363, LSL #16
    MOVK  X27, #0x6363, LSL #48
    FMOV  X11, V4.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x6363, LSL #16
    MOVK  X27, #0x6363, LSL #48
    FMOV  X11, D4
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, V5.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x63, LSL #0
    MOVK  X27, #0x63, LSL #16
    MOVK  X27, #0x63, LSL #32
    MOVK  X27, #0x63, LSL #48
    FMOV  X11, D5
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, V6.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, D6
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, V7.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, D7
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, V8.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    FMOV  X11, D8
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, V9.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x1b1b, LSL #0
    MOVK  X27, #0x6313, LSL #16
    MOVK  X27, #0x1b1b, LSL #32
    MOVK  X27, #0x6363, LSL #48
    FMOV  X11, D9
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, V10.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, D10
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, V11.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x7b52, LSL #0
    MOVK  X27, #0x7b52, LSL #16
    FMOV  X11, D11
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, V12.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, D12
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, V13.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, D13
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, V14.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, D14
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, V15.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, D15
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, V16.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x6363, LSL #0
    MOVK  X27, #0x6363, LSL #16
    MOVK  X27, #0x6363, LSL #32
    MOVK  X27, #0x6363, LSL #48
    FMOV  X11, D16
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, V17.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, D17
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, V18.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, D18
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, V19.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, D19
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, V20.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, D20
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, V21.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, D21
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xf, LSL #0
    MOVK  X27, #0xf, LSL #16
    MOVK  X27, #0xf, LSL #32
    MOVK  X27, #0xf, LSL #48
    FMOV  X11, V22.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xf, LSL #0
    MOVK  X27, #0xf, LSL #16
    MOVK  X27, #0xf, LSL #32
    MOVK  X27, #0xf, LSL #48
    FMOV  X11, D22
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, V23.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, D23
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, V24.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, D24
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    FMOV  X11, V25.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, D25
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x630c, LSL #0
    MOVK  X27, #0xcc0c, LSL #16
    MOVK  X27, #0x600b, LSL #32
    MOVK  X27, #0x6302, LSL #48
    FMOV  X11, V26.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x630c, LSL #0
    MOVK  X27, #0x630c, LSL #16
    MOVK  X27, #0x6302, LSL #32
    MOVK  X27, #0x5f0c, LSL #48
    FMOV  X11, D26
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, V27.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x630c, LSL #0
    FMOV  X11, D27
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, V28.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, D28
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, V29.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X11, D29
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x1, LSL #0
    FMOV  X11, V30.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    FMOV  X11, D30
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x6363, LSL #0
    MOVK  X27, #0x6363, LSL #16
    MOVK  X27, #0x6363, LSL #32
    MOVK  X27, #0x6363, LSL #48
    FMOV  X11, V31.D[1]
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x6363, LSL #0
    MOVK  X27, #0x6363, LSL #16
    MOVK  X27, #0x6363, LSL #32
    FMOV  X11, D31
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
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
    FMOV  D0, X24
    FMOV  V0.D[1], X28
    FMOV  D1, X26
    FMOV  V1.D[1], X25
    FMOV  D2, X27
    FMOV  V2.D[1], X4
    FMOV  D3, X10
    FMOV  V3.D[1], X19
    FMOV  D4, X28
    FMOV  V4.D[1], X28
    FMOV  D5, X20
    FMOV  V5.D[1], X25
    FMOV  D6, X5
    FMOV  V6.D[1], X21
    FMOV  D7, X14
    FMOV  V7.D[1], X24
    FMOV  D8, X17
    FMOV  V8.D[1], X23
    FMOV  D9, X15
    FMOV  V9.D[1], X18
    FMOV  D10, X24
    FMOV  V10.D[1], X23
    FMOV  D11, X18
    FMOV  V11.D[1], X24
    FMOV  D12, X5
    FMOV  V12.D[1], X24
    FMOV  D13, X9
    FMOV  V13.D[1], X9
    FMOV  D14, X2
    FMOV  V14.D[1], X21
    FMOV  D15, X9
    FMOV  V15.D[1], X19
    FMOV  D16, X18
    FMOV  V16.D[1], X7
    FMOV  D17, X17
    FMOV  V17.D[1], X17
    FMOV  D18, X9
    FMOV  V18.D[1], X6
    FMOV  D19, X19
    FMOV  V19.D[1], X17
    FMOV  D20, X16
    FMOV  V20.D[1], X4
    FMOV  D21, X28
    FMOV  V21.D[1], X25
    FMOV  D22, X9
    FMOV  V22.D[1], X23
    FMOV  D23, X27
    FMOV  V23.D[1], X18
    FMOV  D24, X9
    FMOV  V24.D[1], X6
    FMOV  D25, X28
    FMOV  V25.D[1], X24
    FMOV  D26, X25
    FMOV  V26.D[1], X17
    FMOV  D27, X18
    FMOV  V27.D[1], X8
    FMOV  D28, X17
    FMOV  V28.D[1], X16
    FMOV  D29, X20
    FMOV  V29.D[1], X4
    FMOV  D30, X23
    FMOV  V30.D[1], X10
    FMOV  D31, X21
    FMOV  V31.D[1], X28
    MOVZ  X18, #0xf, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_20:
    CNT  V2.8B, V24.8B
    DUP V13.4H, W13
    SLI  V13.4H, V2.4H, #0x4
    ABS  V7.2S, V30.2S
    REV64  V25.8B, V26.8B
    SRI  V13.8B, V7.8B, #4
    MOV  W23, V27.S[0x2]
    MLA  V13.8H, V28.8H, V7.H[0x5]
    DUP  V3.2S, V31.S[0x0]
    INS V25.S[0x2], W2
    REV64  V9.8H, V13.8H
    BIF  V28.16B, V29.16B, V3.16B
    MOV V17.S[0x2], W13
    RADDHN2  V4.4S, V17.2D, V9.2D
    AESIMC  V0.16B, V25.16B
    SHL  V16.16B, V28.16B, #0x1
    XTN  V0.8B, V16.8H
    EXT  V30.16B, V0.16B, V4.16B, #0xa
    BSL  V7.8B, V4.8B, V11.8B
    SRI  V0.2S, V6.2S, #30
    TBX  V2.8B, { V18.16B, V19.16B, V20.16B }, V12.8B
    MOV  X4, V18.D[0x0]
    MOVI  V26.2S, #0x72, LSL #24
    MOV V11.D[0x0], X25
    INS V27.H[0x1], W21
    MLS  V18.8B, V11.8B, V29.8B
    MOV V13.H[0x6], W21
    MOVI  V29.4H, #0xe9, LSL #8
    DUP B24, V7.B[0x0]
    BIT  V3.16B, V2.16B, V26.16B
    TBX  V7.8B, { V29.16B, V30.16B, V31.16B, V0.16B }, V0.8B
    MOV S26, V24.S[0x3]
    AESIMC  V11.16B, V26.16B
    MOV V28.D[0x1], V7.D[0x1]
    DUP B19, V27.B[0x9]
    DUP V0.4S, W14
    TBX  V12.16B, { V6.16B, V7.16B, V8.16B }, V3.16B
    SRI  V20.16B, V18.16B, #4
    MUL  V25.8H, V17.8H, V12.H[0x3]
    BIC  V30.2S, #0x12
    AND  V16.16B, V19.16B, V11.16B
    MOV V11.H[0x5], W13
    INS V17.S[0x3], W25
    BIC  V27.8H, #0x63, LSL #8
    ADDHN  V3.4H, V0.4S, V20.4S
    ZIP2  V18.4S, V13.4S, V30.4S
    MOV B8, V28.B[0xb]
    SHL  V0.16B, V16.16B, #0x1
    XTN2  V16.8H, V11.4S
    DUP V6.8H, W9
    SRI  V20.8H, V5.8H, #8
    MOV V26.H[0x4], V17.H[0x6]
    MVNI  V29.4S, #0xc0, MSL #16
    MVNI  V7.2S, #0x9a
    CLZ  V11.4S, V26.4S
    DUP  V28.16B, V25.B[0x2]
    DUP B24, V0.B[0x4]
    SHRN2 V5.8H, V27.4S, #15
    DUP V30.8H, W16
    MUL  V17.2S, V30.2S, V6.S[0x3]
    ADDV  S26, V8.4S
    SUB  V13.2D, V3.2D, V20.2D
    MOV V8.B[0xb], W15
    ADDV  S0, V28.4S
    MOVI  V27.2D, #18446462603027742720
    RSHRN2 V28.8H, V5.4S, #11
    DUP V20.4S, W13
    ORR  V30.2S, #0x1a
    MVNI  V5.2S, #0xcc, MSL #16
    BIF  V3.8B, V27.8B, V27.8B
    MOV  V19.16B, V29.16B
    SRI  V23.4H, V8.4H, #2
    TBX  V27.16B, { V28.16B }, V24.16B
    RSHRN2 V6.16B, V11.8H, #5
    TBX  V29.16B, { V19.16B }, V5.16B
    SRI  V25.2S, V30.2S, #18
    MOV V11.H[0x5], V20.H[0x1]
    SRI  V27.8H, V17.8H, #9
    DUP V8.16B, W24
    TBX  V28.16B, { V27.16B, V28.16B }, V26.16B
    RADDHN2  V26.16B, V28.8H, V7.8H
    TRN1  V30.4H, V25.4H, V3.4H
    SRI  V24.8B, V23.8B, #8
    INS V28.H[0x3], V8.H[0x2]
    INS V17.H[0x3], W9
    SHRN V8.2S, V6.2D, #32
    INS V30.S[0x3], V26.S[0x1]
    MOVI  V23.4S, #0xb5, MSL #8
    RSHRN2 V7.4S, V8.2D, #24
    SRI  V26.8H, V29.8H, #16
    AND  V25.16B, V11.16B, V28.16B
    TBX  V6.16B, { V7.16B }, V25.16B
    DUP V27.4H, W9
    SHRN V3.8B, V0.8H, #6
    ADD  V8.16B, V6.16B, V8.16B
    TRN1  V19.16B, V22.16B, V3.16B
    SHRN V28.8B, V30.8H, #1
    SLI V30.2D, V27.2D, #0x32
    SRI V29.2D, V17.2D, #9
    DUP V17.4H, W24
    MOVI  V7.8H, #0x3b
    DUP  V25.2S, V30.S[0x2]
    TBX  V30.8B, { V13.16B, V14.16B, V15.16B, V16.16B }, V8.8B
    MOV H27, V26.H[0x3]
    AESE  V0.16B, V27.16B
    REV64  V14.2S, V0.2S
    MLS  V22.8H, V19.8H, V10.H[0x6]
    CLS  V26.2S, V29.2S
    UZP1  V8.8B, V28.8B, V28.8B
    DUP  V3.2S, V23.S[0x2]
    ORN  V16.8B, V8.8B, V22.8B
    MOV V6.D[0x1], X17
    RADDHN2  V22.4S, V3.2D, V6.2D
    ADDP  V29.16B, V22.16B, V26.16B
    ORN  V22.8B, V29.8B, V25.8B
    TBL  V26.16B, { V16.16B, V17.16B }, V14.16B
    RSUBHN  V0.2S, V26.2D, V22.2D
    MVNI  V3.4S, #0x82
    MOVI  V29.2S, #0xe0, MSL #16
    ADDV  S15, V3.4S
    PMUL  V22.8B, V7.8B, V7.8B
    RSUBHN  V19.8B, V15.8H, V30.8H
    SHRN V6.2S, V0.2D, #14
    SHRN V30.4H, V6.4S, #9
    MVNI  V0.4H, #0x34, LSL #8
    TBL  V10.16B, { V22.16B, V23.16B, V24.16B }, V0.16B
    SRI  V14.2S, V10.2S, #31
    MOV S27, V14.S[0x2]
    REV64  V17.4S, V29.4S
    DUP H3, V17.H[0x0]
    NEG  V17.2D, V3.2D
    CNT  V16.8B, V30.8B
    AESIMC  V14.16B, V17.16B
    TBL  V3.16B, { V28.16B, V29.16B }, V14.16B
    MLA  V10.4S, V16.4S, V16.S[0x3]
    MOVI  V30.4S, #0x98, MSL #16
    RSHRN V17.4H, V10.4S, #6
    RSUBHN  V10.2S, V30.2D, V17.2D
    TBX  V25.8B, { V6.16B, V7.16B, V8.16B, V9.16B }, V27.8B
    SLI V22.2D, V10.2D, #0x2b
    EXT  V14.16B, V19.16B, V15.16B, #0xc
    ADDV  S19, V25.4S
    RSHRN V27.8B, V14.8H, #4
    MOV V14.H[0x4], W7
    MOV V16.S[0x2], W9
    BIC  V7.8H, #0xda, LSL #8
    NEG  V25.2D, V22.2D
    SHRN V8.2S, V3.2D, #24
    MOV D15, V25.D[0x1]
    AESMC  V28.16B, V2.16B
    DUP V3.2D, V19.D[0x1]
    RSUBHN2  V25.4S, V3.2D, V27.2D
    PMUL  V19.8B, V28.8B, V16.8B
    INS V2.S[0x2], W13
    MLA  V9.4H, V14.4H, V7.4H
    ORR  V17.8B, V8.8B, V17.8B
    DUP  V22.4S, V25.S[0x1]
    DUP S7, V15.S[0x2]
    ZIP1  V8.8B, V7.8B, V17.8B
    ORR  V3.4S, #0x3f, LSL #24
    AESE  V7.16B, V3.16B
    MLA  V6.4H, V2.4H, V7.H[0x3]
    RADDHN2  V2.8H, V6.4S, V0.4S
    BIT  V10.16B, V8.16B, V2.16B
    XTN  V30.4H, V10.4S
    MOV H27, V19.H[0x2]
    MOV V19.B[0xe], W17
    DUP V17.2D, V30.D[0x0]
    REV64  V6.8B, V17.8B
    DUP  V4.8H, V6.H[0x1]
    RADDHN2  V14.16B, V4.8H, V27.8H
    CLZ  V10.16B, V19.16B
    MVN  V28.16B, V14.16B
    SLI  V4.16B, V10.16B, #0x5
    ZIP2  V3.2S, V22.2S, V22.2S
    EXT  V15.16B, V28.16B, V3.16B, #0x3
    RSHRN V16.4H, V4.4S, #8
    REV16  V19.8B, V16.8B
    SHRN V3.2S, V19.2D, #19
    INS V16.H[0x3], V3.H[0x1]
    DUP B4, V15.B[0x5]
    ADD  V19.4S, V4.4S, V4.4S
    EXT  V0.16B, V16.16B, V19.16B, #0xb
    DUP  V22.16B, V0.B[0xb]
    SHRN V7.8B, V22.8H, #5
    INS V10.D[0x0], V7.D[0x1]
    MOV V30.D[0x1], V10.D[0x1]
    ORR  V15.2S, #0xc0
    MOV V2.S[0x1], V15.S[0x0]
    INS V4.S[0x1], V31.S[0x0]
    BIF  V14.16B, V10.16B, V8.16B
    MLS  V15.4H, V29.4H, V15.H[0x3]
    MOV V7.D[0x1], X17
    SHL V8.2D, V12.2D, #0x1e
    DUP  V3.4S, V4.S[0x2]
    INS V10.H[0x3], V21.H[0x4]
    INS V16.H[0x3], V24.H[0x4]
    ADDV  S29, V14.4S
    RSHRN2 V0.8H, V2.4S, #8
    MLS  V14.2S, V15.2S, V3.S[0x0]
    SUBS  X18, X18, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_20
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X20, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X20, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X20, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X20, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X20, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X20, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X20, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X20, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X20, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X20, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X20, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X20, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X20, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X20, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X20, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X20, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    MRS  X20, FPSR
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x20c, LSL #16
    MOVK  X8, #0xcc, LSL #32
    FMOV  X20, V0.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xfe00, LSL #32
    MOVK  X8, #0x1, LSL #48
    FMOV  X20, D0
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X20, V1.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X20, D1
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xcc00, LSL #0
    MOVK  X8, #0xcc00, LSL #16
    FMOV  X20, V2.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xbff, LSL #32
    MOVK  X8, #0x2, LSL #48
    FMOV  X20, D2
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X20, V3.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X20, D3
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X20, V4.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xff, LSL #0
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X20, D4
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X20, V5.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xff33, LSL #16
    MOVK  X8, #0xff33, LSL #48
    FMOV  X20, D5
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X20, V6.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xeaea, LSL #48
    FMOV  X20, D6
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X20, V7.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X20, D7
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X20, V8.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xc000, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X20, D8
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X20, V9.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x873c, LSL #32
    MOVK  X8, #0xc6, LSL #48
    FMOV  X20, D9
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x808, LSL #0
    MOVK  X8, #0x808, LSL #16
    MOVK  X8, #0x808, LSL #32
    MOVK  X8, #0x800, LSL #48
    FMOV  X20, V10.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xffff, LSL #48
    FMOV  X20, D10
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x10, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0x20, LSL #32
    FMOV  X20, V11.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x20, LSL #0
    MOVK  X8, #0x20, LSL #32
    FMOV  X20, D11
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X20, V12.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X20, D12
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x1000, LSL #0
    MOVK  X8, #0xfff, LSL #16
    MOVK  X8, #0xfff, LSL #32
    MOVK  X8, #0xfff, LSL #48
    FMOV  X20, V13.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xf0, LSL #0
    MOVK  X8, #0xfef1, LSL #16
    MOVK  X8, #0xef, LSL #32
    MOVK  X8, #0xfff1, LSL #48
    FMOV  X20, D13
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X20, V14.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X20, D14
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X20, V15.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xbfe, LSL #0
    MOVK  X8, #0xe2, LSL #16
    MOVK  X8, #0xffbf, LSL #32
    MOVK  X8, #0xdf, LSL #48
    FMOV  X20, D15
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X20, V16.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X20, D16
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xeaea, LSL #0
    MOVK  X8, #0xffff, LSL #16
    FMOV  X20, V17.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xeaea, LSL #0
    MOVK  X8, #0xffff, LSL #16
    FMOV  X20, D17
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    FMOV  X20, V18.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X20, D18
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X20, V19.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x1fe, LSL #0
    FMOV  X20, D19
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X20, V20.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X20, D20
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X20, V21.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X20, D21
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X20, V22.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X20, D22
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xb5ff, LSL #0
    MOVK  X8, #0xb5ff, LSL #32
    FMOV  X20, V23.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xb5ff, LSL #0
    MOVK  X8, #0xb5ff, LSL #32
    FMOV  X20, D23
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X20, V24.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X20, D24
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X20, V25.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffbb, LSL #0
    MOVK  X8, #0xffba, LSL #16
    MOVK  X8, #0xafba, LSL #32
    MOVK  X8, #0xe0a8, LSL #48
    FMOV  X20, D25
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X20, V26.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X20, D26
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X20, V27.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X20, D27
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X20, V28.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0x20b, LSL #32
    FMOV  X20, D28
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X20, V29.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x1010, LSL #0
    MOVK  X8, #0x1008, LSL #16
    FMOV  X20, D29
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x808, LSL #0
    MOVK  X8, #0x808, LSL #16
    MOVK  X8, #0x808, LSL #32
    MOVK  X8, #0x800, LSL #48
    FMOV  X20, V30.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xeaea, LSL #0
    MOVK  X8, #0xffff, LSL #16
    FMOV  X20, D30
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X20, V31.D[1]
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    FMOV  X20, D31
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorGeneralOperation_TestFail

TSRTAdvsimdVectorGeneralOperation_TestEnd:
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
TSRTAdvsimdVectorGeneralOperation_TestFail:
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
