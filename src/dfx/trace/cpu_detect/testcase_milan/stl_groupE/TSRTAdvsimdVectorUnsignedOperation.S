.global TSRTAdvsimdVectorUnsignedOperation

.text
.p2align 4

TSRTAdvsimdVectorUnsignedOperation:

TSRTAdvsimdVectorUnsignedOperation_TestBegin:
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
    MOVZ  X2, #0x973b, LSL #0
    MOVK  X2, #0xe7ec, LSL #16
    MOVK  X2, #0x4319, LSL #32
    MOVK  X2, #0x652, LSL #48
    MOVZ  X3, #0xa760, LSL #0
    MOVK  X3, #0x1ab5, LSL #16
    MOVK  X3, #0xe044, LSL #32
    MOVK  X3, #0x9375, LSL #48
    MOVZ  X4, #0x6879, LSL #0
    MOVK  X4, #0x9d6f, LSL #16
    MOVK  X4, #0x4434, LSL #32
    MOVK  X4, #0xf4a8, LSL #48
    MOVZ  X5, #0xcde5, LSL #0
    MOVK  X5, #0x9ef4, LSL #16
    MOVK  X5, #0x2411, LSL #32
    MOVK  X5, #0xcf01, LSL #48
    MOVZ  X6, #0x883a, LSL #0
    MOVK  X6, #0x2327, LSL #16
    MOVK  X6, #0x6952, LSL #32
    MOVK  X6, #0xba3, LSL #48
    MOVZ  X7, #0x6752, LSL #0
    MOVK  X7, #0xe4ea, LSL #16
    MOVK  X7, #0xfb97, LSL #32
    MOVK  X7, #0x97f3, LSL #48
    MOVZ  X8, #0x99b6, LSL #0
    MOVK  X8, #0x7be5, LSL #16
    MOVK  X8, #0x3870, LSL #32
    MOVK  X8, #0x83c3, LSL #48
    MOVZ  X9, #0xcb33, LSL #0
    MOVK  X9, #0xced9, LSL #16
    MOVK  X9, #0xdf33, LSL #32
    MOVK  X9, #0xe55, LSL #48
    MOVZ  X10, #0xfa82, LSL #0
    MOVK  X10, #0xc662, LSL #16
    MOVK  X10, #0x7614, LSL #32
    MOVK  X10, #0x364b, LSL #48
    MOVZ  X12, #0xad9, LSL #0
    MOVK  X12, #0x4c34, LSL #16
    MOVK  X12, #0x2ea7, LSL #32
    MOVK  X12, #0xb4e, LSL #48
    MOVZ  X13, #0xc528, LSL #0
    MOVK  X13, #0xceea, LSL #16
    MOVK  X13, #0xa236, LSL #32
    MOVK  X13, #0x9367, LSL #48
    MOVZ  X14, #0xd233, LSL #0
    MOVK  X14, #0xa4a3, LSL #16
    MOVK  X14, #0x78f9, LSL #32
    MOVK  X14, #0xdf8e, LSL #48
    MOVZ  X15, #0x10b1, LSL #0
    MOVK  X15, #0x26f7, LSL #16
    MOVK  X15, #0xca06, LSL #32
    MOVK  X15, #0x6b34, LSL #48
    MOVZ  X16, #0x9df9, LSL #0
    MOVK  X16, #0xbdb2, LSL #16
    MOVK  X16, #0xe4b7, LSL #32
    MOVK  X16, #0xf019, LSL #48
    MOVZ  X17, #0x3921, LSL #0
    MOVK  X17, #0x84b, LSL #16
    MOVK  X17, #0x4d96, LSL #32
    MOVK  X17, #0x3ec4, LSL #48
    MOVZ  X20, #0x3cca, LSL #0
    MOVK  X20, #0x688a, LSL #16
    MOVK  X20, #0x776f, LSL #32
    MOVK  X20, #0x31c6, LSL #48
    MOVZ  X21, #0xbb4a, LSL #0
    MOVK  X21, #0x6182, LSL #16
    MOVK  X21, #0x753b, LSL #32
    MOVK  X21, #0x44c1, LSL #48
    MOVZ  X22, #0xa09, LSL #0
    MOVK  X22, #0x6d8, LSL #16
    MOVK  X22, #0x8363, LSL #32
    MOVK  X22, #0xbd05, LSL #48
    MOVZ  X23, #0x887a, LSL #0
    MOVK  X23, #0x8ade, LSL #16
    MOVK  X23, #0x2e7e, LSL #32
    MOVK  X23, #0xb61b, LSL #48
    MOVZ  X24, #0xe4ee, LSL #0
    MOVK  X24, #0x70a7, LSL #16
    MOVK  X24, #0xb415, LSL #32
    MOVK  X24, #0x695c, LSL #48
    MOVZ  X25, #0xa89b, LSL #0
    MOVK  X25, #0x46bb, LSL #16
    MOVK  X25, #0xfac, LSL #32
    MOVK  X25, #0x49f7, LSL #48
    MOVZ  X27, #0x19d, LSL #0
    MOVK  X27, #0x20e0, LSL #16
    MOVK  X27, #0xa6ba, LSL #32
    MOVK  X27, #0x9f6c, LSL #48
    MOVZ  X28, #0xb653, LSL #0
    MOVK  X28, #0x414d, LSL #16
    MOVK  X28, #0xe8b2, LSL #32
    MOVK  X28, #0xe14e, LSL #48
    MOVZ  X29, #0x4c34, LSL #0
    MOVK  X29, #0xaa2b, LSL #16
    MOVK  X29, #0x393d, LSL #32
    MOVK  X29, #0x9d43, LSL #48
    MOVZ  X20, #0x2edb, LSL #0
    MOVK  X20, #0x5793, LSL #16
    MOVK  X20, #0xe400, LSL #32
    MOVK  X20, #0x8c11, LSL #48
    MSR  FPCR, X20
    MOVZ  X20, #0x104e, LSL #0
    MOVK  X20, #0x3973, LSL #16
    MOVK  X20, #0x3e48, LSL #32
    MOVK  X20, #0x8809, LSL #48
    MSR  FPSR, X20
    MRS  X10, FPSR
    MOVZ  X27, #0xff60, LSL #0
    MOVK  X27, #0x7ff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    AND  X10, X10, X27
    MOVZ  X27, #0x0, LSL #0
    ORR  X10, X10, X27
    MSR  FPSR, X10
    ISB  SY
    ANDS  X22, X28, X28, ASR #22
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x1ac, LSL #0
    MOVK  X2, #0x4e3b, LSL #16
    MOVK  X2, #0xcb74, LSL #32
    MOVK  X2, #0xbe17, LSL #48
    MOVZ  X3, #0x9206, LSL #0
    MOVK  X3, #0x5bc1, LSL #16
    MOVK  X3, #0xa54b, LSL #32
    MOVK  X3, #0xc5a0, LSL #48
    MOVZ  X4, #0x5a81, LSL #0
    MOVK  X4, #0xfd03, LSL #16
    MOVK  X4, #0x980e, LSL #32
    MOVK  X4, #0x2b95, LSL #48
    MOVZ  X5, #0xac26, LSL #0
    MOVK  X5, #0x9f89, LSL #16
    MOVK  X5, #0x9d3d, LSL #32
    MOVK  X5, #0x38d1, LSL #48
    MOVZ  X6, #0x9373, LSL #0
    MOVK  X6, #0x24de, LSL #16
    MOVK  X6, #0x2e61, LSL #32
    MOVK  X6, #0x65b2, LSL #48
    MOVZ  X7, #0x208, LSL #0
    MOVK  X7, #0x48f4, LSL #16
    MOVK  X7, #0xa0fb, LSL #32
    MOVK  X7, #0xd0a5, LSL #48
    MOVZ  X8, #0xcce, LSL #0
    MOVK  X8, #0xb062, LSL #16
    MOVK  X8, #0x6801, LSL #32
    MOVK  X8, #0x5d84, LSL #48
    MOVZ  X9, #0xe6ef, LSL #0
    MOVK  X9, #0x54c3, LSL #16
    MOVK  X9, #0xe89f, LSL #32
    MOVK  X9, #0x5cd6, LSL #48
    MOVZ  X10, #0x449f, LSL #0
    MOVK  X10, #0x5660, LSL #16
    MOVK  X10, #0x9a30, LSL #32
    MOVK  X10, #0x733b, LSL #48
    MOVZ  X12, #0xd537, LSL #0
    MOVK  X12, #0xf61e, LSL #16
    MOVK  X12, #0xbf81, LSL #32
    MOVK  X12, #0x7cd2, LSL #48
    MOVZ  X13, #0x7536, LSL #0
    MOVK  X13, #0x11f1, LSL #16
    MOVK  X13, #0xa195, LSL #32
    MOVK  X13, #0x28df, LSL #48
    MOVZ  X14, #0x1b73, LSL #0
    MOVK  X14, #0x9e66, LSL #16
    MOVK  X14, #0x8d94, LSL #32
    MOVK  X14, #0x77d5, LSL #48
    MOVZ  X15, #0x8aea, LSL #0
    MOVK  X15, #0x6a0, LSL #16
    MOVK  X15, #0x3817, LSL #32
    MOVK  X15, #0x8e5a, LSL #48
    MOVZ  X16, #0x48fe, LSL #0
    MOVK  X16, #0xd422, LSL #16
    MOVK  X16, #0x3fa5, LSL #32
    MOVK  X16, #0x88c3, LSL #48
    MOVZ  X17, #0x68e6, LSL #0
    MOVK  X17, #0x98e6, LSL #16
    MOVK  X17, #0xcbc2, LSL #32
    MOVK  X17, #0x36e9, LSL #48
    MOVZ  X20, #0xb8b6, LSL #0
    MOVK  X20, #0xf047, LSL #16
    MOVK  X20, #0x7999, LSL #32
    MOVK  X20, #0x6457, LSL #48
    MOVZ  X21, #0x2001, LSL #0
    MOVK  X21, #0x25b6, LSL #16
    MOVK  X21, #0xc140, LSL #32
    MOVK  X21, #0x2b93, LSL #48
    MOVZ  X22, #0x1941, LSL #0
    MOVK  X22, #0x5bb4, LSL #16
    MOVK  X22, #0x53f5, LSL #32
    MOVK  X22, #0xc2bc, LSL #48
    MOVZ  X23, #0x48bb, LSL #0
    MOVK  X23, #0x960b, LSL #16
    MOVK  X23, #0x8a5f, LSL #32
    MOVK  X23, #0x122d, LSL #48
    MOVZ  X24, #0x173, LSL #0
    MOVK  X24, #0xa6ff, LSL #16
    MOVK  X24, #0xd8e3, LSL #32
    MOVK  X24, #0x5e5b, LSL #48
    MOVZ  X25, #0xee6d, LSL #0
    MOVK  X25, #0x7463, LSL #16
    MOVK  X25, #0x28d5, LSL #32
    MOVK  X25, #0x7eb3, LSL #48
    MOVZ  X27, #0xb4a2, LSL #0
    MOVK  X27, #0xbcc9, LSL #16
    MOVK  X27, #0x77f7, LSL #32
    MOVK  X27, #0x64a5, LSL #48
    MOVZ  X28, #0xf437, LSL #0
    MOVK  X28, #0xd25f, LSL #16
    MOVK  X28, #0x258e, LSL #32
    MOVK  X28, #0xa843, LSL #48
    MOVZ  X29, #0x49de, LSL #0
    MOVK  X29, #0x34f6, LSL #16
    MOVK  X29, #0x84ea, LSL #32
    MOVK  X29, #0x856a, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X29
    FMOV  D1, X25
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X21
    FMOV  D3, X5
    FMOV  V3.D[1], X27
    FMOV  D4, X23
    FMOV  V4.D[1], X4
    FMOV  D5, X9
    FMOV  V5.D[1], X7
    FMOV  D6, X21
    FMOV  V6.D[1], X10
    FMOV  D7, X22
    FMOV  V7.D[1], X4
    FMOV  D8, X17
    FMOV  V8.D[1], X2
    FMOV  D9, X6
    FMOV  V9.D[1], X13
    FMOV  D10, X5
    FMOV  V10.D[1], X21
    FMOV  D11, X7
    FMOV  V11.D[1], X25
    FMOV  D12, X12
    FMOV  V12.D[1], X6
    FMOV  D13, X10
    FMOV  V13.D[1], X20
    FMOV  D14, X29
    FMOV  V14.D[1], X25
    FMOV  D15, X6
    FMOV  V15.D[1], X7
    FMOV  D16, X16
    FMOV  V16.D[1], X10
    FMOV  D17, X21
    FMOV  V17.D[1], X21
    FMOV  D18, X13
    FMOV  V18.D[1], X24
    FMOV  D19, X13
    FMOV  V19.D[1], X15
    FMOV  D20, X16
    FMOV  V20.D[1], X15
    FMOV  D21, X24
    FMOV  V21.D[1], X3
    FMOV  D22, X13
    FMOV  V22.D[1], X3
    FMOV  D23, X4
    FMOV  V23.D[1], X28
    FMOV  D24, X4
    FMOV  V24.D[1], X10
    FMOV  D25, X25
    FMOV  V25.D[1], X2
    FMOV  D26, X8
    FMOV  V26.D[1], X4
    FMOV  D27, X6
    FMOV  V27.D[1], X4
    FMOV  D28, X16
    FMOV  V28.D[1], X8
    FMOV  D29, X2
    FMOV  V29.D[1], X5
    FMOV  D30, X17
    FMOV  V30.D[1], X13
    FMOV  D31, X4
    FMOV  V31.D[1], X14
    MOVZ  X25, #0xf, LSL #0
TSRTAdvsimdVectorUnsignedOperation_label_0:
    URSHR  V12.8H, V24.8H, #3
    URECPE  V29.4S, V18.4S
    UADDLP  V5.8H, V26.16B
    UQSHRN V29.8B, V31.8H, #2
    UQSHRN V17.4H, V12.4S, #6
    UMOV W5, V28.B[0x4]
    UQXTN  V29.8B, V5.8H
    USHLL2 V9.2D, V21.4S, #0xb
    UADDL2  V16.2D, V30.4S, V27.4S
    UXTL2 V27.8H, V17.16B
    URSQRTE  V23.2S, V27.2S
    URSRA  V26.8B, V25.8B, #4
    UQXTN2  V14.4S, V29.2D
    UMULL2 V22.2D, V14.4S, V14.S[0x0]
    USHL  V2.8H, V22.8H, V9.8H
    UXTL V28.8H, V26.8B
    UQSHL  V6.2S, V2.2S, #0xd
    UQRSHRN2 V27.16B, V16.8H, #1
    UMOV X15, V28.D[0x0]
    USHLL2 V25.4S, V23.8H, #0xe
    UABDL2  V5.8H, V6.16B, V6.16B
    UQSHL  V31.4S, V27.4S, #0x13
    UQSHRN2 V28.8H, V25.4S, #15
    UMLAL  V17.8H, V28.8B, V5.8B
    UMOV W29, V31.B[0x6]
    USUBL2  V26.4S, V23.8H, V26.8H
    USHL  V30.8B, V3.8B, V6.8B
    URSHR V3.2D, V30.2D, #29
    USHLL V14.8H, V5.8B, #0x6
    UQSHRN V29.4H, V29.4S, #12
    UQADD  V18.8H, V9.8H, V3.8H
    UQADD  V5.16B, V30.16B, V30.16B
    URSRA  V30.4S, V4.4S, #6
    UQSHRN2 V31.16B, V27.8H, #5
    UXTL2 V3.2D, V7.4S
    USHR V25.2D, V3.2D, #44
    UADDLV  H16, V14.16B
    URSHR  V28.2S, V5.2S, #3
    UQSHL V27.2D, V28.2D, #0x17
    UQSHRN2 V5.4S, V1.2D, #6
    USUBW2  V28.8H, V26.8H, V4.16B
    UQSHRN2 V26.16B, V28.8H, #7
    UQRSHRN V1.2S, V27.2D, #8
    UADDLV  D14, V31.4S
    UQSUB  V9.4S, V1.4S, V29.4S
    UMULL  V4.8H, V26.8B, V9.8B
    UQSHL  V9.8H, V4.8H, #0xd
    UHADD  V28.8B, V14.8B, V30.8B
    USUBW2  V3.8H, V16.8H, V28.16B
    URSHR  V7.8B, V3.8B, #3
    USHL  V1.16B, V25.16B, V5.16B
    UMULL  V14.8H, V9.8B, V9.8B
    UMULL2  V27.8H, V7.16B, V7.16B
    UXTL2 V7.2D, V1.4S
    UMOV X10, V14.D[0x1]
    UABAL  V31.4S, V27.4H, V27.4H
    UXTL V30.2D, V31.2S
    UMLSL  V31.8H, V30.8B, V30.8B
    UQSHRN2 V27.4S, V7.2D, #16
    UMOV W7, V27.S[0x3]
    URSHR V27.2D, V31.2D, #24
    UADDLV  D1, V27.4S
    UQSUB  V9.2S, V1.2S, V1.2S
    USHR  V16.4S, V8.4S, #31
    UQADD  V3.2D, V14.2D, V12.2D
    UABAL2  V31.2D, V19.4S, V10.4S
    USRA  V19.16B, V1.16B, #3
    USUBL  V25.8H, V23.8B, V5.8B
    UMLSL V8.4S, V16.4H, V4.H[0x1]
    USHR  V23.4S, V17.4S, #26
    UABDL2  V7.8H, V30.16B, V19.16B
    UADDW2  V27.8H, V24.8H, V26.16B
    UMLSL2  V10.8H, V29.16B, V16.16B
    USHR  V19.8H, V10.8H, #3
    UXTL V14.2D, V19.2S
    URSHR V12.2D, V31.2D, #10
    UXTL2 V31.8H, V12.16B
    UQSHL  V12.2S, V7.2S, #0x4
    UXTL V1.8H, V8.8B
    UMLSL V16.2D, V1.2S, V23.S[0x2]
    UMLSL V4.4S, V14.4H, V7.H[0x1]
    UMLSL2  V29.2D, V27.4S, V31.4S
    UHADD  V24.8H, V12.8H, V4.8H
    URSRA V14.2D, V25.2D, #42
    UADDW  V25.2D, V3.2D, V16.2S
    UADDLV  S8, V14.8H
    UQRSHRN2 V27.16B, V8.8H, #8
    UABAL2  V19.2D, V24.4S, V25.4S
    UHSUB  V10.16B, V19.16B, V19.16B
    USUBL2  V8.8H, V27.16B, V10.16B
    USRA  V26.8B, V29.8B, #6
    USHLL2 V10.4S, V26.8H, #0x7
    UXTL V29.8H, V8.8B
    URSHL  V3.4S, V10.4S, V28.4S
    UABAL  V24.8H, V3.8B, V29.8B
    UQRSHRN V7.4H, V9.4S, #12
    UABDL2  V19.2D, V7.4S, V22.4S
    UQSHL  V23.8H, V4.8H, #0x1
    URSRA V16.2D, V26.2D, #64
    UQRSHRN2 V25.8H, V8.4S, #3
    UMLSL V27.2D, V1.2S, V15.S[0x2]
    UMLSL2 V9.2D, V1.4S, V27.S[0x1]
    URSHR  V28.8H, V12.8H, #15
    USHLL2 V29.4S, V8.8H, #0x8
    URSHL  V10.8B, V15.8B, V25.8B
    USRA  V26.4S, V15.4S, #14
    UXTL V4.8H, V24.8B
    USHLL V24.8H, V26.8B, #0x6
    URSQRTE  V27.4S, V29.4S
    UMLSL  V29.8H, V27.8B, V26.8B
    UABAL2  V7.8H, V29.16B, V10.16B
    UQSHRN V15.2S, V28.2D, #9
    UADDLV  D27, V19.4S
    UQSHL  V14.2S, V23.2S, #0x3
    USQADD  V8.16B, V14.16B
    USUBW  V22.2D, V29.2D, V27.2S
    UQSHRN2 V29.16B, V16.8H, #7
    UQRSHRN V26.2S, V4.2D, #10
    UQADD  V27.2D, V29.2D, V7.2D
    URSHR  V3.16B, V7.16B, #6
    UMLSL2 V29.2D, V9.4S, V3.S[0x1]
    UMLAL2 V1.4S, V15.8H, V4.H[0x5]
    UMOV W28, V29.H[0x1]
    UMLAL V19.4S, V24.4H, V1.H[0x2]
    UQSHRN V12.4H, V19.4S, #6
    UMLAL2  V7.8H, V27.16B, V13.16B
    URHADD  V23.8B, V26.8B, V12.8B
    UADDLV  D29, V8.4S
    UADDW2  V3.2D, V22.2D, V7.4S
    UQRSHRN V16.8B, V23.8H, #2
    UADDL2  V12.4S, V3.8H, V16.8H
    UMULL2 V9.4S, V23.8H, V12.H[0x7]
    URSHR V15.2D, V9.2D, #15
    UQSHRN2 V26.16B, V29.8H, #8
    USRA  V22.8B, V7.8B, #8
    USHLL V13.4S, V22.4H, #0x6
    UMLAL V4.4S, V26.4H, V15.H[0x6]
    UADDLV  D8, V4.4S
    UADDL  V1.2D, V8.2S, V8.2S
    UMOV W22, V13.H[0x5]
    UADDW2  V8.8H, V23.8H, V14.16B
    UQRSHRN2 V9.8H, V22.4S, #16
    UMLSL  V20.8H, V24.8B, V26.8B
    USQADD  V14.16B, V4.16B
    UQSHRN V23.2S, V10.2D, #1
    UMLSL V3.2D, V19.2S, V19.S[0x2]
    USUBW  V22.4S, V15.4S, V29.4H
    USHR V13.2D, V25.2D, #11
    USRA  V27.4H, V14.4H, #9
    USHLL V19.4S, V23.4H, #0xe
    UADDL2  V15.4S, V13.8H, V9.8H
    UMOV W8, V20.S[0x3]
    USRA  V29.4H, V22.4H, #10
    USUBW2  V25.2D, V15.2D, V27.4S
    USHLL V16.2D, V25.2S, #0xc
    UQRSHRN2 V14.4S, V16.2D, #24
    UQXTN  V23.8B, V19.8H
    UMULL2  V10.2D, V3.4S, V3.4S
    USHR V26.2D, V0.2D, #43
    UQADD  V9.8H, V1.8H, V14.8H
    UQRSHRN V13.2S, V10.2D, #21
    UMLAL V4.2D, V13.2S, V29.S[0x2]
    UMLSL V20.4S, V23.4H, V11.H[0x7]
    USRA  V14.8H, V20.8H, #12
    UXTL V0.2D, V8.2S
    UABDL  V24.4S, V26.4H, V14.4H
    URSHR  V27.8H, V4.8H, #2
    URSRA  V8.8B, V9.8B, #2
    USHR  V11.8B, V0.8B, #6
    UQRSHRN V0.2S, V11.2D, #31
    UABAL2  V11.8H, V24.16B, V27.16B
    UADDW2  V31.8H, V11.8H, V8.16B
    UXTL2 V13.4S, V0.8H
    URSRA V24.2D, V13.2D, #38
    USRA  V20.16B, V31.16B, #7
    UADDLV  S3, V20.4H
    UMLAL2 V29.4S, V3.8H, V3.H[0x1]
    UQSHL  V4.8H, V29.8H, #0x5
    UMLSL2 V13.2D, V24.4S, V10.S[0x0]
    UMULL V9.2D, V13.2S, V4.S[0x0]
    USQADD  V24.4S, V18.4S
    USRA  V27.8H, V8.8H, #13
    USRA  V16.4H, V7.4H, #4
    UQSHRN2 V8.8H, V10.4S, #6
    USHR  V3.8B, V12.8B, #1
    USHLL V12.4S, V20.4H, #0x9
    UQSHRN V0.4H, V5.4S, #4
    UHADD  V29.16B, V8.16B, V13.16B
    UQRSHL  V31.4H, V30.4H, V19.4H
    URSRA  V20.4S, V16.4S, #32
    UQRSHRN V5.4H, V3.4S, #12
    USHLL V11.8H, V1.8B, #0x6
    URSHL  V16.8H, V26.8H, V29.8H
    URSHR  V29.4H, V5.4H, #5
    URSHR  V7.16B, V16.16B, #5
    UQSHRN V4.2S, V12.2D, #7
    UHADD  V10.8B, V4.8B, V4.8B
    UABAL2  V18.8H, V24.16B, V31.16B
    URSHL  V31.16B, V1.16B, V18.16B
    UMLSL2  V18.2D, V20.4S, V10.4S
    SUBS  X25, X25, #0x1
    B.NE  TSRTAdvsimdVectorUnsignedOperation_label_0
    MOVZ  X23, #0x1ac, LSL #0
    MOVK  X23, #0x4e3b, LSL #16
    MOVK  X23, #0xcb74, LSL #32
    MOVK  X23, #0xbe17, LSL #48
    SUB  X14, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x9206, LSL #0
    MOVK  X23, #0x5bc1, LSL #16
    MOVK  X23, #0xa54b, LSL #32
    MOVK  X23, #0xc5a0, LSL #48
    SUB  X14, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x5a81, LSL #0
    MOVK  X23, #0xfd03, LSL #16
    MOVK  X23, #0x980e, LSL #32
    MOVK  X23, #0x2b95, LSL #48
    SUB  X14, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x9373, LSL #0
    MOVK  X23, #0x24de, LSL #16
    MOVK  X23, #0x2e61, LSL #32
    MOVK  X23, #0x65b2, LSL #48
    SUB  X14, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xf857, LSL #0
    MOVK  X23, #0x8e5a, LSL #16
    SUB  X14, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xe6ef, LSL #0
    MOVK  X23, #0x54c3, LSL #16
    MOVK  X23, #0xe89f, LSL #32
    MOVK  X23, #0x5cd6, LSL #48
    SUB  X14, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x7536, LSL #0
    MOVK  X23, #0x11f1, LSL #16
    MOVK  X23, #0xa195, LSL #32
    MOVK  X23, #0x28df, LSL #48
    SUB  X14, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x48fe, LSL #0
    MOVK  X23, #0xd422, LSL #16
    MOVK  X23, #0x3fa5, LSL #32
    MOVK  X23, #0x88c3, LSL #48
    SUB  X14, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x68e6, LSL #0
    MOVK  X23, #0x98e6, LSL #16
    MOVK  X23, #0xcbc2, LSL #32
    MOVK  X23, #0x36e9, LSL #48
    SUB  X14, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xb8b6, LSL #0
    MOVK  X23, #0xf047, LSL #16
    MOVK  X23, #0x7999, LSL #32
    MOVK  X23, #0x6457, LSL #48
    SUB  X14, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x2001, LSL #0
    MOVK  X23, #0x25b6, LSL #16
    MOVK  X23, #0xc140, LSL #32
    MOVK  X23, #0x2b93, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x173, LSL #0
    MOVK  X23, #0xa6ff, LSL #16
    MOVK  X23, #0xd8e3, LSL #32
    MOVK  X23, #0x5e5b, LSL #48
    SUB  X14, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xb4a2, LSL #0
    MOVK  X23, #0xbcc9, LSL #16
    MOVK  X23, #0x77f7, LSL #32
    MOVK  X23, #0x64a5, LSL #48
    SUB  X14, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x800, LSL #16
    MRS  X14, FPSR
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V0.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D0
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V1.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x1fe, LSL #0
    FMOV  X14, D1
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V2.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D2
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V3.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D3
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V4.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X14, D4
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V5.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D5
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V6.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D6
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V7.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D7
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V8.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x40, LSL #0
    FMOV  X14, D8
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V9.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D9
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V10.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X14, D10
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V11.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x3f80, LSL #0
    MOVK  X23, #0x40, LSL #16
    FMOV  X14, D11
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xb000, LSL #0
    MOVK  X23, #0x7d, LSL #16
    MOVK  X23, #0x6c00, LSL #32
    MOVK  X23, #0x1ca, LSL #48
    FMOV  X14, V12.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xe200, LSL #0
    MOVK  X23, #0x10, LSL #16
    MOVK  X23, #0x1c00, LSL #32
    MOVK  X23, #0x6f, LSL #48
    FMOV  X14, D12
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V13.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D13
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xf, LSL #32
    MOVK  X23, #0x8, LSL #48
    FMOV  X14, V14.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x3, LSL #16
    MOVK  X23, #0x3, LSL #32
    MOVK  X23, #0xe, LSL #48
    FMOV  X14, D14
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V15.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D15
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V16.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D16
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V17.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0x1, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0x3, LSL #48
    FMOV  X14, D17
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x583b, LSL #0
    MOVK  X23, #0x530, LSL #16
    MOVK  X23, #0x62d, LSL #32
    FMOV  X14, V18.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x3003, LSL #0
    MOVK  X23, #0xce8, LSL #16
    MOVK  X23, #0x308, LSL #32
    MOVK  X23, #0x5, LSL #48
    FMOV  X14, D18
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V19.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D19
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xb6b, LSL #0
    MOVK  X23, #0x6a1, LSL #16
    MOVK  X23, #0xf857, LSL #32
    MOVK  X23, #0x8e5a, LSL #48
    FMOV  X14, V20.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x871, LSL #0
    MOVK  X23, #0x378e, LSL #16
    MOVK  X23, #0x3ed8, LSL #32
    MOVK  X23, #0xe536, LSL #48
    FMOV  X14, D20
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x9206, LSL #0
    MOVK  X23, #0x5bc1, LSL #16
    MOVK  X23, #0xa54b, LSL #32
    MOVK  X23, #0xc5a0, LSL #48
    FMOV  X14, V21.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x173, LSL #0
    MOVK  X23, #0xa6ff, LSL #16
    MOVK  X23, #0xd8e3, LSL #32
    MOVK  X23, #0x5e5b, LSL #48
    FMOV  X14, D21
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V22.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xff01, LSL #0
    MOVK  X23, #0xffff, LSL #16
    FMOV  X14, D22
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V23.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D23
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x5803, LSL #0
    MOVK  X23, #0x52a, LSL #16
    MOVK  X23, #0x63b, LSL #32
    FMOV  X14, V24.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x3000, LSL #0
    MOVK  X23, #0xc90, LSL #16
    MOVK  X23, #0x2e1, LSL #32
    FMOV  X14, D24
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V25.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D25
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V26.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D26
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V27.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x40, LSL #0
    FMOV  X14, D27
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V28.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D28
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V29.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D29
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V30.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D30
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V31.D[1]
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xf0, LSL #0
    FMOV  X14, D31
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
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
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X10
    FMOV  V0.D[1], X28
    FMOV  D1, X27
    FMOV  V1.D[1], X9
    FMOV  D2, X22
    FMOV  V2.D[1], X25
    FMOV  D3, X29
    FMOV  V3.D[1], X14
    FMOV  D4, X15
    FMOV  V4.D[1], X16
    FMOV  D5, X17
    FMOV  V5.D[1], X24
    FMOV  D6, X23
    FMOV  V6.D[1], X15
    FMOV  D7, X12
    FMOV  V7.D[1], X3
    FMOV  D8, X21
    FMOV  V8.D[1], X22
    FMOV  D9, X20
    FMOV  V9.D[1], X8
    FMOV  D10, X14
    FMOV  V10.D[1], X21
    FMOV  D11, X8
    FMOV  V11.D[1], X27
    FMOV  D12, X2
    FMOV  V12.D[1], X17
    FMOV  D13, X8
    FMOV  V13.D[1], X29
    FMOV  D14, X15
    FMOV  V14.D[1], X8
    FMOV  D15, X10
    FMOV  V15.D[1], X28
    FMOV  D16, X23
    FMOV  V16.D[1], X9
    FMOV  D17, X28
    FMOV  V17.D[1], X20
    FMOV  D18, X7
    FMOV  V18.D[1], X14
    FMOV  D19, X9
    FMOV  V19.D[1], X8
    FMOV  D20, X23
    FMOV  V20.D[1], X12
    FMOV  D21, X9
    FMOV  V21.D[1], X15
    FMOV  D22, X16
    FMOV  V22.D[1], X25
    FMOV  D23, X6
    FMOV  V23.D[1], X4
    FMOV  D24, X10
    FMOV  V24.D[1], X4
    FMOV  D25, X17
    FMOV  V25.D[1], X22
    FMOV  D26, X5
    FMOV  V26.D[1], X17
    FMOV  D27, X2
    FMOV  V27.D[1], X29
    FMOV  D28, X17
    FMOV  V28.D[1], X6
    FMOV  D29, X3
    FMOV  V29.D[1], X27
    FMOV  D30, X21
    FMOV  V30.D[1], X14
    FMOV  D31, X25
    FMOV  V31.D[1], X17
    MOVZ  X7, #0xf, LSL #0
TSRTAdvsimdVectorUnsignedOperation_label_1:
    URSHR  V27.4S, V25.4S, #8
    UABAL2  V0.2D, V30.4S, V28.4S
    UABDL2  V30.8H, V20.16B, V27.16B
    URSQRTE  V13.2S, V26.2S
    UQRSHRN V28.8B, V31.8H, #1
    UMLAL  V30.2D, V29.2S, V29.2S
    UQADD  V8.16B, V23.16B, V13.16B
    UMLAL2 V16.2D, V8.4S, V0.S[0x3]
    UMULL2  V25.8H, V30.16B, V30.16B
    UADDLP  V4.4H, V25.8B
    UQXTN  V13.8B, V28.8H
    UMULL V17.2D, V4.2S, V13.S[0x2]
    URSHR  V4.2S, V16.2S, #19
    UADDLV  D16, V17.4S
    UHSUB  V31.4S, V16.4S, V4.4S
    USHLL V25.8H, V31.8B, #0x6
    UADDLV  S8, V25.4H
    UMLSL2 V20.2D, V17.4S, V9.S[0x3]
    USHR  V26.8B, V24.8B, #5
    UQADD  V25.4S, V21.4S, V22.4S
    UADDLP  V31.2S, V29.4H
    UMULL2  V9.2D, V14.4S, V20.4S
    UMLAL  V23.8H, V31.8B, V15.8B
    USUBW2  V14.4S, V24.4S, V14.8H
    UXTL2 V28.2D, V13.4S
    UQSHRN2 V22.4S, V1.2D, #7
    UXTL V27.8H, V23.8B
    UADDL  V21.8H, V11.8B, V14.8B
    UMULL V30.4S, V16.4H, V6.H[0x0]
    USHLL V0.8H, V18.8B, #0x6
    UQSHL  V17.4H, V8.4H, #0x3
    USRA  V18.2S, V21.2S, #32
    UQSHL  V23.8H, V28.8H, V0.8H
    UHADD  V20.2S, V9.2S, V27.2S
    UXTL V21.4S, V30.4H
    USRA  V15.2S, V23.2S, #27
    UADDW  V23.8H, V25.8H, V22.8B
    USHLL V9.8H, V20.8B, #0x7
    USHR V22.2D, V26.2D, #4
    UADDLV  D25, V21.4S
    UXTL2 V21.2D, V17.4S
    UABA  V30.4H, V23.4H, V22.4H
    URSQRTE  V17.2S, V30.2S
    UXTL2 V20.4S, V9.8H
    UMOV W28, V17.B[0x4]
    UMOV W13, V25.S[0x3]
    UQSHL V6.2D, V18.2D, #0x36
    UABD  V18.16B, V20.16B, V6.16B
    URSRA V23.2D, V5.2D, #5
    UMLAL2 V27.2D, V23.4S, V23.S[0x1]
    URECPE  V23.2S, V18.2S
    UQADD  V25.16B, V15.16B, V27.16B
    UQRSHRN V20.8B, V25.8H, #5
    URSRA V17.2D, V20.2D, #39
    UABDL2  V6.4S, V7.8H, V23.8H
    UQSHRN V30.2S, V17.2D, #6
    UMULL  V22.4S, V10.4H, V6.4H
    UXTL V17.2D, V29.2S
    UQXTN  V27.8B, V21.8H
    UADDW  V25.8H, V22.8H, V17.8B
    UMLAL2 V17.4S, V25.8H, V14.H[0x2]
    URECPE  V15.2S, V27.2S
    UADDLV  D28, V15.4S
    UMULL2  V18.8H, V28.16B, V17.16B
    UMLAL V5.4S, V18.4H, V7.H[0x2]
    UMLAL2 V7.2D, V5.4S, V5.S[0x1]
    USRA V23.2D, V7.2D, #21
    URSHR  V7.2S, V23.2S, #16
    USHR  V6.4H, V30.4H, #5
    UQRSHRN V10.8B, V6.8H, #6
    UMLSL2 V27.4S, V7.8H, V10.H[0x2]
    URSRA V9.2D, V20.2D, #61
    URSHR  V14.4H, V8.4H, #12
    UMLAL2  V21.8H, V28.16B, V13.16B
    UQSHL  V8.16B, V8.16B, #0x3
    UQSHRN2 V7.8H, V3.4S, #12
    UADDLV  H25, V20.8B
    UHSUB  V30.8H, V29.8H, V22.8H
    UQSHL  V23.16B, V11.16B, #0x5
    USHLL V14.2D, V14.2S, #0xc
    UQRSHRN V13.2S, V2.2D, #8
    USHR V11.2D, V30.2D, #37
    UXTL2 V10.2D, V11.4S
    URSRA  V5.16B, V8.16B, #2
    USHR  V8.16B, V27.16B, #6
    USHR  V29.8H, V10.8H, #14
    USRA  V3.4H, V9.4H, #16
    UQXTN  V20.2S, V5.2D
    UADDLP  V17.4H, V25.8B
    UQSHL  V11.8H, V21.8H, #0x3
    UMOV W9, V14.S[0x1]
    UABDL  V27.4S, V29.4H, V20.4H
    USUBW  V21.8H, V11.8H, V23.8B
    UXTL2 V18.8H, V3.16B
    URSHR V14.2D, V7.2D, #63
    UMULL2  V10.4S, V3.8H, V13.8H
    URSQRTE  V25.4S, V14.4S
    USHR  V7.4S, V10.4S, #22
    USHR  V14.8H, V31.8H, #8
    UQSHL  V10.8B, V8.8B, #0x3
    UQADD  V13.4H, V17.4H, V10.4H
    UMLAL2 V3.2D, V13.4S, V7.S[0x0]
    UQRSHRN V29.2S, V3.2D, #11
    UADDW  V3.8H, V27.8H, V27.8B
    USRA  V2.4H, V3.4H, #13
    UMLAL  V31.8H, V25.8B, V29.8B
    UMOV W12, V14.S[0x0]
    URSRA V23.2D, V2.2D, #24
    UMLSL V25.2D, V18.2S, V18.S[0x1]
    USHLL V29.4S, V31.4H, #0x2
    UADDLP  V17.2D, V23.4S
    USUBW2  V11.8H, V21.8H, V21.16B
    UMLSL2  V21.4S, V11.8H, V13.8H
    UMULL2  V8.2D, V21.4S, V29.4S
    UADDLV  S27, V17.8H
    UXTL V10.4S, V8.4H
    UMLSL  V8.8H, V10.8B, V25.8B
    USHLL2 V5.2D, V8.4S, #0x10
    UQADD  V23.2D, V5.2D, V27.2D
    UMLSL V5.2D, V16.2S, V23.S[0x1]
    URHADD  V27.16B, V15.16B, V31.16B
    UADALP  V13.1D, V2.2S
    UADDLP  V2.2D, V18.4S
    URSRA  V18.16B, V5.16B, #5
    URSRA V17.2D, V12.2D, #6
    UADDLP  V11.2D, V19.4S
    USHL  V25.2S, V29.2S, V11.2S
    URHADD  V19.8B, V15.8B, V28.8B
    UMLAL V14.4S, V10.4H, V4.H[0x1]
    UMULL V29.2D, V15.2S, V23.S[0x1]
    UMLAL  V28.2D, V18.2S, V29.2S
    UQRSHRN2 V5.8H, V2.4S, #10
    UMLSL2  V2.4S, V5.8H, V31.8H
    URSRA V29.2D, V25.2D, #56
    UXTL V5.8H, V29.8B
    UQRSHRN V31.2S, V2.2D, #23
    USRA  V12.8B, V5.8B, #7
    UQRSHRN2 V11.8H, V12.4S, #15
    UABA  V4.8H, V11.8H, V14.8H
    UMULL2  V10.2D, V27.4S, V17.4S
    UQSHRN2 V2.16B, V13.8H, #8
    UMLSL2 V29.4S, V19.8H, V12.H[0x2]
    UABAL  V8.8H, V28.8B, V31.8B
    UADDLV  D15, V3.4S
    UMLAL2 V3.4S, V10.8H, V8.H[0x2]
    UMLAL V13.4S, V29.4H, V3.H[0x1]
    UMULL2 V14.2D, V13.4S, V4.S[0x0]
    USHLL V28.8H, V2.8B, #0x2
    USHR  V8.8H, V25.8H, #12
    UXTL2 V17.2D, V15.4S
    UMULL2 V3.2D, V14.4S, V17.S[0x2]
    UQXTN2  V31.8H, V3.4S
    UMLSL2  V12.4S, V8.8H, V8.8H
    UMOV W24, V28.B[0x2]
    URSQRTE  V29.2S, V31.2S
    USHLL2 V28.2D, V2.4S, #0xc
    UADDLV  D4, V19.4S
    UQRSHRN2 V3.8H, V12.4S, #12
    UQRSHRN2 V10.16B, V29.8H, #3
    UQSHL  V14.8B, V23.8B, #0x7
    UMLAL V8.4S, V14.4H, V10.H[0x3]
    UMLAL2 V29.2D, V28.4S, V28.S[0x1]
    UMULL2  V12.4S, V8.8H, V4.8H
    UMLSL V11.4S, V29.4H, V3.H[0x1]
    USHLL2 V17.4S, V11.8H, #0x3
    USHR  V5.2S, V17.2S, #3
    URHADD  V27.4H, V12.4H, V19.4H
    UABAL2  V31.2D, V5.4S, V27.4S
    URSRA  V13.4S, V1.4S, #20
    UMLSL2 V4.4S, V1.8H, V2.H[0x6]
    UMULL2 V11.2D, V16.4S, V28.S[0x1]
    UMLSL V23.4S, V18.4H, V11.H[0x0]
    UMLSL V14.4S, V4.4H, V14.H[0x7]
    UMLAL2 V8.4S, V9.8H, V4.H[0x6]
    UADDLV  S4, V20.4H
    UQADD  V9.2S, V2.2S, V21.2S
    USHLL V29.4S, V13.4H, #0x5
    USRA V10.2D, V4.2D, #14
    UADDL  V17.4S, V16.4H, V11.4H
    USHL  V18.16B, V28.16B, V24.16B
    UHSUB  V24.8H, V8.8H, V31.8H
    UQRSHRN V8.4H, V14.4S, #16
    UADDLV  H19, V9.8B
    UXTL V12.4S, V10.4H
    UQSUB  V3.2S, V17.2S, V12.2S
    UMLSL V25.4S, V3.4H, V15.H[0x4]
    UABDL  V20.2D, V19.2S, V8.2S
    UMLAL2 V14.2D, V18.4S, V20.S[0x3]
    USRA  V28.4S, V25.4S, #32
    UQSHRN2 V4.16B, V23.8H, #2
    URSHR  V19.4S, V14.4S, #4
    UXTL V10.8H, V19.8B
    USUBW2  V8.8H, V4.8H, V29.16B
    USRA  V3.2S, V24.2S, #10
    UQSHL  V2.2S, V28.2S, #0xf
    UMLAL2 V15.4S, V2.8H, V2.H[0x6]
    USHLL V28.2D, V15.2S, #0x15
    UQSHRN2 V19.16B, V10.8H, #6
    UABA  V18.4S, V19.4S, V19.4S
    USHLL2 V20.4S, V26.8H, #0x4
    SUBS  X7, X7, #0x1
    B.NE  TSRTAdvsimdVectorUnsignedOperation_label_1
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0xff, LSL #0
    SUB  X8, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x800, LSL #16
    MRS  X8, FPSR
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V0.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D0
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V1.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D1
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V2.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D2
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V3.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D3
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V4.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D4
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V5.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D5
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V6.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x7ff, LSL #0
    MOVK  X16, #0x7ff, LSL #16
    FMOV  X8, D6
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V7.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D7
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V8.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D8
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V9.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D9
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V10.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D10
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V11.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D11
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V12.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D12
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V13.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D13
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V14.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D14
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V15.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D15
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V16.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D16
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V17.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D17
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V18.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D18
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V19.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D19
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V20.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D20
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V21.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D21
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V22.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D22
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V23.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D23
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V24.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D24
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V25.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D25
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V26.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D26
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V27.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x8000, LSL #0
    MOVK  X16, #0x8000, LSL #16
    MOVK  X16, #0x4040, LSL #32
    MOVK  X16, #0x4040, LSL #48
    FMOV  X8, D27
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V28.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D28
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V29.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D29
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V30.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D30
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V31.D[1]
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D31
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
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
    FMOV  D0, X24
    FMOV  V0.D[1], X29
    FMOV  D1, X25
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X27
    FMOV  D3, X14
    FMOV  V3.D[1], X27
    FMOV  D4, X23
    FMOV  V4.D[1], X12
    FMOV  D5, X17
    FMOV  V5.D[1], X3
    FMOV  D6, X10
    FMOV  V6.D[1], X21
    FMOV  D7, X21
    FMOV  V7.D[1], X6
    FMOV  D8, X2
    FMOV  V8.D[1], X5
    FMOV  D9, X29
    FMOV  V9.D[1], X6
    FMOV  D10, X23
    FMOV  V10.D[1], X13
    FMOV  D11, X16
    FMOV  V11.D[1], X29
    FMOV  D12, X25
    FMOV  V12.D[1], X5
    FMOV  D13, X27
    FMOV  V13.D[1], X20
    FMOV  D14, X9
    FMOV  V14.D[1], X13
    FMOV  D15, X17
    FMOV  V15.D[1], X28
    FMOV  D16, X16
    FMOV  V16.D[1], X4
    FMOV  D17, X23
    FMOV  V17.D[1], X25
    FMOV  D18, X2
    FMOV  V18.D[1], X13
    FMOV  D19, X4
    FMOV  V19.D[1], X12
    FMOV  D20, X10
    FMOV  V20.D[1], X7
    FMOV  D21, X13
    FMOV  V21.D[1], X15
    FMOV  D22, X27
    FMOV  V22.D[1], X12
    FMOV  D23, X4
    FMOV  V23.D[1], X28
    FMOV  D24, X6
    FMOV  V24.D[1], X21
    FMOV  D25, X10
    FMOV  V25.D[1], X13
    FMOV  D26, X20
    FMOV  V26.D[1], X7
    FMOV  D27, X7
    FMOV  V27.D[1], X4
    FMOV  D28, X12
    FMOV  V28.D[1], X16
    FMOV  D29, X8
    FMOV  V29.D[1], X23
    FMOV  D30, X13
    FMOV  V30.D[1], X6
    FMOV  D31, X2
    FMOV  V31.D[1], X14
    MOVZ  X7, #0xf, LSL #0
TSRTAdvsimdVectorUnsignedOperation_label_2:
    UMLAL  V10.2D, V28.2S, V23.2S
    UMLAL2 V11.4S, V10.8H, V9.H[0x7]
    URSRA  V18.4H, V29.4H, #5
    UQSHL  V2.16B, V11.16B, V18.16B
    UQSHL  V6.4S, V26.4S, #0x17
    UXTL2 V16.8H, V27.16B
    UABA  V6.4S, V31.4S, V25.4S
    URSHR  V24.8B, V24.8B, #8
    URSRA  V2.4H, V2.4H, #12
    UADDLV  H5, V24.8B
    UABAL  V15.2D, V22.2S, V5.2S
    USHR  V28.16B, V15.16B, #3
    UQRSHRN V24.4H, V6.4S, #8
    UMULL2 V9.4S, V30.8H, V3.H[0x7]
    UQSHRN V3.8B, V28.8H, #1
    UABD  V27.8H, V9.8H, V2.8H
    URSHR  V18.16B, V3.16B, #5
    USHLL V26.2D, V1.2S, #0x18
    UHADD  V25.8H, V26.8H, V16.8H
    UQSHL  V15.4H, V24.4H, V27.4H
    UXTL2 V22.8H, V18.16B
    UABAL2  V24.4S, V25.8H, V25.8H
    UABA  V26.4H, V15.4H, V22.4H
    USRA  V2.16B, V24.16B, #1
    USUBL2  V15.4S, V2.8H, V2.8H
    USHLL2 V30.8H, V26.16B, #0x4
    URSQRTE  V25.2S, V30.2S
    UADDW  V31.2D, V25.2D, V25.2S
    UADDW2  V11.2D, V15.2D, V15.4S
    USHLL2 V6.2D, V31.4S, #0x1f
    UQSHL  V5.8B, V6.8B, #0x4
    UQSHL  V24.16B, V11.16B, V20.16B
    URECPE  V18.4S, V24.4S
    UADDLV  S20, V5.4H
    UQRSHRN2 V5.8H, V20.4S, #11
    URSRA  V3.16B, V18.16B, #2
    UHADD  V20.8B, V5.8B, V3.8B
    UQSHL V27.2D, V3.2D, #0x3e
    UABDL  V1.4S, V5.4H, V27.4H
    UQRSHRN2 V30.16B, V19.8H, #7
    USHLL V25.8H, V25.8B, #0x6
    USRA  V24.16B, V19.16B, #7
    UMLAL  V27.8H, V21.8B, V29.8B
    USHLL V31.4S, V8.4H, #0xc
    UABDL  V5.2D, V9.2S, V24.2S
    UQRSHRN2 V11.8H, V12.4S, #8
    UQSHRN V9.2S, V10.2D, #15
    UQRSHRN V12.4H, V11.4S, #4
    UMLSL2  V15.4S, V9.8H, V27.8H
    UQRSHRN2 V24.16B, V15.8H, #5
    UABDL  V19.2D, V31.2S, V5.2S
    UQSHL V29.2D, V12.2D, #0x9
    USHL  V8.8B, V19.8B, V25.8B
    UADDL  V26.2D, V30.2S, V8.2S
    USHLL V18.2D, V1.2S, #0x10
    UABDL2  V15.8H, V24.16B, V26.16B
    UMOV X15, V15.D[0x0]
    URSQRTE  V11.4S, V18.4S
    USHLL V15.2D, V11.2S, #0x3
    URSQRTE  V12.4S, V29.4S
    UMLAL2  V6.4S, V12.8H, V15.8H
    UMLSL2 V18.4S, V6.8H, V6.H[0x6]
    UQXTN2  V29.16B, V18.8H
    URSRA  V6.4H, V29.4H, #1
    UABD  V31.16B, V6.16B, V6.16B
    UQSHRN2 V27.4S, V31.2D, #28
    USHR  V5.4S, V27.4S, #7
    UADDW2  V11.8H, V5.8H, V5.16B
    UQSHRN2 V5.16B, V11.8H, #6
    USHLL V25.8H, V26.8B, #0x6
    URSRA V21.2D, V8.2D, #11
    URSRA  V29.8H, V16.8H, #14
    UABD  V26.8B, V2.8B, V1.8B
    UQRSHRN2 V30.16B, V17.8H, #4
    UQADD  V15.4H, V31.4H, V4.4H
    UQSHRN V6.4H, V22.4S, #4
    UQXTN2  V8.16B, V11.8H
    USQADD  V27.16B, V6.16B
    UQXTN2  V18.4S, V26.2D
    URSQRTE  V22.2S, V30.2S
    UQRSHRN2 V16.8H, V8.4S, #13
    UMLAL V6.4S, V15.4H, V5.H[0x1]
    UMOV W12, V7.S[0x1]
    USUBW  V1.8H, V21.8H, V18.8B
    UQSHRN2 V31.16B, V27.8H, #8
    UMULL2  V12.2D, V16.4S, V6.4S
    UQSHL  V2.4S, V6.4S, #0xf
    UMLSL2 V16.2D, V22.4S, V22.S[0x3]
    UQRSHRN V5.8B, V17.8H, #1
    UABDL  V6.8H, V1.8B, V3.8B
    UQSHL  V4.8H, V6.8H, #0xf
    UADDLV  D26, V16.4S
    UMLAL V18.4S, V29.4H, V8.H[0x0]
    URECPE  V17.4S, V26.4S
    UQRSHRN V15.2S, V18.2D, #11
    USRA  V30.16B, V25.16B, #6
    UXTL V8.4S, V15.4H
    USHLL V1.2D, V31.2S, #0x4
    USHLL V26.2D, V12.2S, #0x11
    URSQRTE  V11.2S, V4.2S
    UQRSHRN2 V3.4S, V2.2D, #22
    UQXTN2  V7.16B, V17.8H
    UMLAL2 V31.4S, V8.8H, V5.H[0x0]
    UQSHL  V18.8B, V11.8B, #0x4
    UQRSHRN2 V21.4S, V18.2D, #22
    UQRSHL  V4.16B, V26.16B, V21.16B
    UMLSL  V2.8H, V4.8B, V23.8B
    UQRSHRN V11.8B, V30.8H, #7
    UQXTN2  V27.8H, V2.4S
    UADDLV  D18, V2.4S
    UABD  V25.4H, V11.4H, V7.4H
    UMLSL2 V30.2D, V22.4S, V23.S[0x1]
    UQRSHL  V16.8H, V1.8H, V1.8H
    USHR V22.2D, V27.2D, #14
    UMOV W6, V22.S[0x0]
    UQRSHRN V6.8B, V30.8H, #5
    UMULL2 V29.4S, V3.8H, V6.H[0x2]
    UQRSHL  V4.2S, V29.2S, V25.2S
    URSRA V2.2D, V31.2D, #17
    UMLSL V15.4S, V18.4H, V2.H[0x0]
    UQRSHRN V31.2S, V4.2D, #23
    USHLL2 V7.4S, V31.8H, #0x6
    URSHR  V12.4S, V16.4S, #30
    UABA  V16.4S, V12.4S, V12.4S
    USUBW  V29.4S, V16.4S, V15.4H
    UQSHRN2 V22.16B, V7.8H, #4
    URSHR  V27.4H, V29.4H, #8
    URSHR  V11.4H, V27.4H, #10
    UMLSL2 V25.4S, V22.8H, V0.H[0x2]
    USHLL V0.2D, V11.2S, #0xe
    URSRA  V29.8B, V25.8B, #3
    URSRA  V5.16B, V29.16B, #8
    UQSHRN2 V27.8H, V0.4S, #10
    UMULL2 V31.2D, V5.4S, V27.S[0x3]
    UQXTN  V16.4H, V25.4S
    USUBL  V6.4S, V31.4H, V7.4H
    UMLSL V22.4S, V9.4H, V13.H[0x5]
    UADALP  V5.2D, V14.4S
    UQXTN2  V12.4S, V0.2D
    UQSHL  V27.2S, V14.2S, #0xf
    UADDLP  V25.4S, V9.8H
    USHLL V7.8H, V25.8B, #0x6
    UXTL V25.2D, V9.2S
    URSHR  V9.8B, V28.8B, #7
    UMLSL V28.2D, V7.2S, V27.S[0x0]
    UMLSL V4.2D, V12.2S, V28.S[0x1]
    URSRA  V13.2S, V16.2S, #29
    UQRSHRN2 V16.8H, V6.4S, #8
    UMOV W8, V15.B[0xe]
    URSRA  V12.4S, V4.4S, #6
    URSHL  V28.2D, V13.2D, V12.2D
    UQXTN  V7.2S, V9.2D
    UXTL2 V11.4S, V28.8H
    UABD  V14.8H, V7.8H, V5.8H
    USRA  V0.8H, V14.8H, #5
    UQSHL  V13.16B, V16.16B, #0x1
    USRA  V7.4H, V22.4H, #15
    USHR V6.2D, V7.2D, #48
    UABDL  V27.2D, V0.2S, V0.2S
    USUBW  V31.8H, V27.8H, V27.8B
    UQSHRN2 V7.8H, V11.4S, #7
    URSRA  V5.16B, V31.16B, #7
    USUBL2  V9.2D, V7.4S, V6.4S
    USHR V14.2D, V9.2D, #37
    URSRA  V0.16B, V14.16B, #8
    USRA  V2.2S, V5.2S, #19
    UMLSL V27.4S, V2.4H, V11.H[0x5]
    UMULL2 V28.2D, V0.4S, V25.S[0x1]
    USHLL V2.4S, V28.4H, #0x2
    URSRA  V31.8B, V13.8B, #1
    USHR V4.2D, V27.2D, #35
    UMLAL2 V22.4S, V31.8H, V2.H[0x2]
    USUBL2  V16.4S, V4.8H, V22.8H
    URSRA  V0.2S, V31.2S, #27
    UMLSL2 V15.4S, V19.8H, V13.H[0x7]
    UMULL2 V9.4S, V1.8H, V5.H[0x3]
    UMLAL2  V11.2D, V29.4S, V10.4S
    USHLL V29.4S, V0.4H, #0x9
    UXTL V12.2D, V10.2S
    UMOV W28, V31.H[0x7]
    USHL  V23.2S, V10.2S, V24.2S
    UQRSHRN2 V22.16B, V14.8H, #2
    USHR  V0.4H, V20.4H, #6
    URSRA  V19.8H, V27.8H, #5
    UMULL2 V25.2D, V12.4S, V11.S[0x2]
    USUBL  V2.8H, V29.8B, V29.8B
    UADDLV  D6, V2.4S
    USRA  V28.16B, V25.16B, #8
    USUBL2  V12.2D, V28.4S, V15.4S
    UQRSHRN2 V4.4S, V12.2D, #11
    UMLAL2 V12.2D, V22.4S, V4.S[0x2]
    UQSHL  V22.2S, V23.2S, #0x1d
    UQSHL  V31.4S, V0.4S, #0x2
    UABD  V20.4S, V31.4S, V16.4S
    UMOV W17, V22.B[0xf]
    UMLAL2 V10.2D, V20.4S, V6.S[0x2]
    USUBL  V6.8H, V12.8B, V9.8B
    UMLAL V14.2D, V19.2S, V19.S[0x2]
    USHLL V9.8H, V6.8B, #0x2
    UADDLP  V31.2D, V9.4S
    SUBS  X7, X7, #0x1
    B.NE  TSRTAdvsimdVectorUnsignedOperation_label_2
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X5, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X5, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x7787, LSL #0
    MOVK  X25, #0x3fbc, LSL #16
    SUB  X5, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X5, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X5, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X5, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x1, LSL #0
    SUB  X5, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X5, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X5, X25, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X5, X25, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X5, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X5, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X5, X25, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X5, X25, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X5, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X5, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X5, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X5, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X5, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X5, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x800, LSL #16
    MRS  X5, FPSR
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V0.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x80, LSL #0
    MOVK  X25, #0x280, LSL #16
    MOVK  X25, #0x27e, LSL #32
    MOVK  X25, #0x27e, LSL #48
    FMOV  X5, D0
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V1.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, D1
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V2.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, D2
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V3.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x413f, LSL #0
    MOVK  X25, #0x4240, LSL #16
    MOVK  X25, #0x3f3f, LSL #32
    MOVK  X25, #0x4040, LSL #48
    FMOV  X5, D3
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V4.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, D4
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V5.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X5, D5
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V6.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, D6
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V7.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x1, LSL #32
    FMOV  X5, D7
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x20, LSL #32
    FMOV  X5, V8.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xffe0, LSL #0
    MOVK  X25, #0x1f, LSL #32
    FMOV  X5, D8
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V9.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, D9
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xfffe, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X5, V10.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xfffe, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X5, D10
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V11.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, D11
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V12.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, D12
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V13.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xffff, LSL #16
    FMOV  X5, D13
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V14.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, D14
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V15.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xffe0, LSL #0
    MOVK  X25, #0x1f, LSL #16
    MOVK  X25, #0x20, LSL #48
    FMOV  X5, D15
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V16.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, D16
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X5, V17.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X5, D17
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V18.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, D18
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V19.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xffd, LSL #16
    FMOV  X5, D19
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V20.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x200, LSL #0
    MOVK  X25, #0xa00, LSL #16
    MOVK  X25, #0x9f8, LSL #32
    MOVK  X25, #0x9f8, LSL #48
    FMOV  X5, D20
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    FMOV  X5, V21.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X5, D21
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V22.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X5, D22
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V23.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xfffe, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X5, D23
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V24.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x1, LSL #16
    FMOV  X5, D24
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V25.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, D25
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V26.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, D26
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V27.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, D27
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V28.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, D28
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xfe00, LSL #0
    MOVK  X25, #0xf, LSL #16
    MOVK  X25, #0xfe00, LSL #32
    MOVK  X25, #0xf, LSL #48
    FMOV  X5, V29.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x1e00, LSL #0
    MOVK  X25, #0x10, LSL #16
    FMOV  X5, D29
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X5, V30.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, D30
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V31.D[1]
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, D31
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x7c6d, LSL #0
    MOVK  X2, #0xfa81, LSL #16
    MOVK  X2, #0x3af4, LSL #32
    MOVK  X2, #0x8204, LSL #48
    MOVZ  X3, #0xd9f2, LSL #0
    MOVK  X3, #0xe577, LSL #16
    MOVK  X3, #0xb05b, LSL #32
    MOVK  X3, #0x15ef, LSL #48
    MOVZ  X4, #0x4b72, LSL #0
    MOVK  X4, #0x827a, LSL #16
    MOVK  X4, #0x13f3, LSL #32
    MOVK  X4, #0xde10, LSL #48
    MOVZ  X5, #0xcc9e, LSL #0
    MOVK  X5, #0x6ae3, LSL #16
    MOVK  X5, #0xaaf2, LSL #32
    MOVK  X5, #0xcf4f, LSL #48
    MOVZ  X6, #0xa29d, LSL #0
    MOVK  X6, #0x95ee, LSL #16
    MOVK  X6, #0x9a26, LSL #32
    MOVK  X6, #0xf5da, LSL #48
    MOVZ  X7, #0xe46a, LSL #0
    MOVK  X7, #0x33b9, LSL #16
    MOVK  X7, #0x893e, LSL #32
    MOVK  X7, #0x6d6d, LSL #48
    MOVZ  X8, #0xb476, LSL #0
    MOVK  X8, #0x6199, LSL #16
    MOVK  X8, #0xcbcc, LSL #32
    MOVK  X8, #0xe7aa, LSL #48
    MOVZ  X9, #0x79d4, LSL #0
    MOVK  X9, #0x2b62, LSL #16
    MOVK  X9, #0xd0da, LSL #32
    MOVK  X9, #0x4aaf, LSL #48
    MOVZ  X10, #0xf2db, LSL #0
    MOVK  X10, #0x1df3, LSL #16
    MOVK  X10, #0xc666, LSL #32
    MOVK  X10, #0x8cbc, LSL #48
    MOVZ  X12, #0xd688, LSL #0
    MOVK  X12, #0x64eb, LSL #16
    MOVK  X12, #0xf2a9, LSL #32
    MOVK  X12, #0x5276, LSL #48
    MOVZ  X13, #0x72d3, LSL #0
    MOVK  X13, #0xc3ff, LSL #16
    MOVK  X13, #0x4bf2, LSL #32
    MOVK  X13, #0x1446, LSL #48
    MOVZ  X14, #0xade5, LSL #0
    MOVK  X14, #0x309d, LSL #16
    MOVK  X14, #0xedc3, LSL #32
    MOVK  X14, #0x3593, LSL #48
    MOVZ  X15, #0xf62c, LSL #0
    MOVK  X15, #0x3cd3, LSL #16
    MOVK  X15, #0xd8f2, LSL #32
    MOVK  X15, #0xa207, LSL #48
    MOVZ  X16, #0xd43f, LSL #0
    MOVK  X16, #0x6b7b, LSL #16
    MOVK  X16, #0x752, LSL #32
    MOVK  X16, #0x4868, LSL #48
    MOVZ  X17, #0x8c6, LSL #0
    MOVK  X17, #0x1b6a, LSL #16
    MOVK  X17, #0x3ef1, LSL #32
    MOVK  X17, #0xd015, LSL #48
    MOVZ  X20, #0x2cba, LSL #0
    MOVK  X20, #0x5539, LSL #16
    MOVK  X20, #0x69aa, LSL #32
    MOVK  X20, #0xbd0, LSL #48
    MOVZ  X21, #0x2d2c, LSL #0
    MOVK  X21, #0x6e00, LSL #16
    MOVK  X21, #0x4553, LSL #32
    MOVK  X21, #0xf380, LSL #48
    MOVZ  X22, #0x4396, LSL #0
    MOVK  X22, #0x7bf9, LSL #16
    MOVK  X22, #0x3822, LSL #32
    MOVK  X22, #0x83ad, LSL #48
    MOVZ  X23, #0x1aa9, LSL #0
    MOVK  X23, #0x1e2b, LSL #16
    MOVK  X23, #0x5cf0, LSL #32
    MOVK  X23, #0x2be, LSL #48
    MOVZ  X24, #0x1da8, LSL #0
    MOVK  X24, #0x1353, LSL #16
    MOVK  X24, #0xba87, LSL #32
    MOVK  X24, #0x1f7b, LSL #48
    MOVZ  X25, #0xd27b, LSL #0
    MOVK  X25, #0xd2fe, LSL #16
    MOVK  X25, #0x633a, LSL #32
    MOVK  X25, #0x33e0, LSL #48
    MOVZ  X27, #0x23c7, LSL #0
    MOVK  X27, #0xc49e, LSL #16
    MOVK  X27, #0x193f, LSL #32
    MOVK  X27, #0xdf2, LSL #48
    MOVZ  X28, #0xd873, LSL #0
    MOVK  X28, #0x76ee, LSL #16
    MOVK  X28, #0x1ba3, LSL #32
    MOVK  X28, #0x53b0, LSL #48
    MOVZ  X29, #0x2851, LSL #0
    MOVK  X29, #0x8191, LSL #16
    MOVK  X29, #0x21ce, LSL #32
    MOVK  X29, #0xffe1, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X25
    FMOV  D1, X24
    FMOV  V1.D[1], X22
    FMOV  D2, X28
    FMOV  V2.D[1], X29
    FMOV  D3, X4
    FMOV  V3.D[1], X24
    FMOV  D4, X22
    FMOV  V4.D[1], X17
    FMOV  D5, X23
    FMOV  V5.D[1], X9
    FMOV  D6, X28
    FMOV  V6.D[1], X2
    FMOV  D7, X28
    FMOV  V7.D[1], X29
    FMOV  D8, X8
    FMOV  V8.D[1], X9
    FMOV  D9, X21
    FMOV  V9.D[1], X28
    FMOV  D10, X7
    FMOV  V10.D[1], X13
    FMOV  D11, X4
    FMOV  V11.D[1], X28
    FMOV  D12, X14
    FMOV  V12.D[1], X2
    FMOV  D13, X22
    FMOV  V13.D[1], X25
    FMOV  D14, X15
    FMOV  V14.D[1], X23
    FMOV  D15, X20
    FMOV  V15.D[1], X25
    FMOV  D16, X25
    FMOV  V16.D[1], X7
    FMOV  D17, X23
    FMOV  V17.D[1], X16
    FMOV  D18, X14
    FMOV  V18.D[1], X8
    FMOV  D19, X20
    FMOV  V19.D[1], X7
    FMOV  D20, X13
    FMOV  V20.D[1], X15
    FMOV  D21, X14
    FMOV  V21.D[1], X12
    FMOV  D22, X28
    FMOV  V22.D[1], X22
    FMOV  D23, X9
    FMOV  V23.D[1], X27
    FMOV  D24, X22
    FMOV  V24.D[1], X28
    FMOV  D25, X7
    FMOV  V25.D[1], X17
    FMOV  D26, X9
    FMOV  V26.D[1], X23
    FMOV  D27, X21
    FMOV  V27.D[1], X9
    FMOV  D28, X29
    FMOV  V28.D[1], X24
    FMOV  D29, X22
    FMOV  V29.D[1], X27
    FMOV  D30, X21
    FMOV  V30.D[1], X14
    FMOV  D31, X16
    FMOV  V31.D[1], X8
    MOVZ  X3, #0xf, LSL #0
TSRTAdvsimdVectorUnsignedOperation_label_3:
    UMOV W23, V23.B[0x0]
    USUBL  V9.4S, V28.4H, V29.4H
    UQRSHRN2 V31.16B, V26.8H, #1
    UQSHRN V24.8B, V30.8H, #2
    URHADD  V6.4H, V27.4H, V9.4H
    URSHL  V11.4S, V24.4S, V25.4S
    UXTL V21.4S, V22.4H
    UHSUB  V22.4H, V21.4H, V6.4H
    UMOV W9, V31.H[0x4]
    UQRSHRN V0.2S, V11.2D, #7
    UABA  V2.16B, V0.16B, V0.16B
    USHL  V16.2S, V2.2S, V22.2S
    UADDLV  D23, V1.4S
    UADDLV  D31, V13.4S
    UMULL  V13.2D, V15.2S, V14.2S
    USHR  V0.2S, V21.2S, #7
    UQSHL  V10.16B, V21.16B, #0x0
    USHLL V9.8H, V4.8B, #0x4
    URSHR V27.2D, V14.2D, #5
    UXTL2 V10.2D, V22.4S
    UQSHRN V15.2S, V15.2D, #7
    UQSHL  V30.8B, V15.8B, #0x3
    UXTL2 V28.8H, V30.16B
    USUBL2  V14.2D, V9.4S, V31.4S
    UQADD  V22.16B, V13.16B, V28.16B
    UMLSL V4.2D, V27.2S, V10.S[0x1]
    UQSHL  V26.8B, V14.8B, #0x2
    UMLAL2  V15.4S, V23.8H, V23.8H
    UXTL2 V10.8H, V4.16B
    USUBL  V30.2D, V10.2S, V16.2S
    UXTL V9.8H, V0.8B
    UMULL2  V23.2D, V9.4S, V22.4S
    USHR  V13.8B, V26.8B, #3
    UQSHRN V31.8B, V12.8H, #5
    URSHL  V24.4H, V15.4H, V13.4H
    USUBW2  V28.8H, V30.8H, V30.16B
    UADDLP  V0.1D, V24.2S
    UADDLV  D16, V23.4S
    USHLL V1.2D, V16.2S, #0x8
    UQSHRN V16.8B, V31.8H, #7
    UMLAL V14.4S, V6.4H, V0.H[0x0]
    UXTL V27.4S, V14.4H
    USHLL V14.4S, V27.4H, #0x5
    UXTL2 V12.8H, V8.16B
    UQRSHRN V21.8B, V1.8H, #2
    UHSUB  V31.16B, V14.16B, V28.16B
    USHLL2 V23.4S, V12.8H, #0xd
    URSRA  V26.8B, V16.8B, #4
    USUBW2  V30.4S, V3.4S, V31.8H
    USHR V15.2D, V14.2D, #58
    UXTL2 V13.4S, V30.8H
    USQADD  V27.8B, V13.8B
    UXTL2 V24.2D, V27.4S
    UMULL2  V27.2D, V21.4S, V26.4S
    URECPE  V13.4S, V27.4S
    UQRSHRN V27.2S, V13.2D, #15
    USRA V4.2D, V27.2D, #14
    UMLSL V26.2D, V23.2S, V23.S[0x0]
    UMULL2 V31.4S, V26.8H, V4.H[0x2]
    UQSHL V10.2D, V31.2D, #0x17
    USHR V23.2D, V15.2D, #55
    USHLL2 V16.8H, V23.16B, #0x5
    UMLSL2  V6.2D, V16.4S, V16.4S
    USHR  V16.4H, V10.4H, #15
    URSHR  V10.8H, V24.8H, #16
    USHL  V4.16B, V6.16B, V25.16B
    UXTL V26.2D, V4.2S
    UADDW  V25.8H, V16.8H, V26.8B
    USHR  V28.2S, V10.2S, #7
    UMULL  V30.2D, V25.2S, V28.2S
    UMLSL V12.4S, V5.4H, V13.H[0x4]
    UHSUB  V23.4H, V2.4H, V8.4H
    USUBW  V8.2D, V14.2D, V5.2S
    USUBW  V25.2D, V9.2D, V30.2S
    USQADD  V15.2D, V11.2D
    URSRA V6.2D, V8.2D, #50
    USHLL V13.8H, V25.8B, #0x4
    UQRSHRN2 V31.8H, V10.4S, #11
    UXTL V28.2D, V22.2S
    UABAL  V14.4S, V17.4H, V7.4H
    UQXTN2  V25.16B, V11.8H
    UABDL  V30.8H, V25.8B, V15.8B
    URSHR  V10.8B, V12.8B, #1
    UQRSHRN2 V7.16B, V30.8H, #6
    UQRSHRN2 V8.8H, V6.4S, #11
    USUBW  V9.4S, V31.4S, V13.4H
    UQXTN  V26.8B, V8.8H
    UMOV W9, V14.S[0x3]
    USUBL  V30.2D, V9.2S, V28.2S
    UQSHL  V24.8B, V10.8B, #0x2
    UXTL V5.8H, V30.8B
    UXTL2 V9.2D, V26.4S
    UMLAL V30.2D, V24.2S, V23.S[0x1]
    UQRSHRN V4.8B, V7.8H, #3
    UQSHL  V28.16B, V4.16B, #0x6
    UMULL V4.4S, V30.4H, V9.H[0x5]
    UMLSL2  V11.4S, V5.8H, V28.8H
    URSHL  V22.2S, V11.2S, V11.2S
    URSHR V31.2D, V22.2D, #12
    UQSHL  V9.4S, V4.4S, #0x3
    UMLAL  V6.2D, V9.2S, V9.2S
    UMULL2  V4.4S, V6.8H, V6.8H
    URSHR  V15.8B, V16.8B, #6
    USUBW  V26.2D, V4.2D, V15.2S
    UADDW  V11.4S, V26.4S, V31.4H
    UMULL2 V9.4S, V23.8H, V2.H[0x5]
    UMLSL V23.2D, V26.2S, V10.S[0x0]
    UADDLV  H10, V30.8B
    UMLAL2 V15.2D, V20.4S, V5.S[0x1]
    URSRA V26.2D, V0.2D, #54
    USHLL V31.8H, V6.8B, #0x3
    USHLL V6.8H, V13.8B, #0x7
    UMULL  V4.4S, V24.4H, V24.4H
    UXTL V5.4S, V23.4H
    UMOV W10, V10.S[0x0]
    USUBW2  V2.2D, V5.2D, V15.4S
    UXTL2 V13.2D, V26.4S
    USHR  V5.2S, V11.2S, #9
    URSHL  V20.2S, V14.2S, V31.2S
    UQRSHRN2 V31.16B, V4.8H, #1
    UABA  V16.8B, V20.8B, V9.8B
    UQSHRN2 V26.4S, V2.2D, #20
    UMLAL2  V0.8H, V16.16B, V26.16B
    UADDLP  V9.4S, V5.8H
    URSRA  V30.8H, V13.8H, #11
    UMLSL V28.4S, V6.4H, V9.H[0x1]
    UQRSHRN V22.4H, V30.4S, #6
    UHSUB  V14.8B, V22.8B, V31.8B
    UQSUB  V9.8H, V28.8H, V13.8H
    UQSHRN2 V31.8H, V14.4S, #1
    UADALP  V16.4S, V0.8H
    USUBL2  V28.8H, V16.16B, V16.16B
    UABDL  V14.8H, V31.8B, V28.8B
    UQRSHRN2 V13.4S, V14.2D, #23
    UMULL  V4.4S, V9.4H, V9.4H
    UMLAL V28.2D, V13.2S, V13.S[0x2]
    UQSHRN2 V15.4S, V4.2D, #22
    UQSHRN2 V4.4S, V15.2D, #7
    USHLL2 V9.2D, V4.4S, #0x13
    UQRSHRN2 V0.8H, V28.4S, #14
    UQSHRN V16.8B, V0.8H, #2
    UMOV X4, V16.D[0x1]
    URSHR  V28.8B, V25.8B, #3
    UMLAL  V5.8H, V6.8B, V29.8B
    UQRSHRN V20.4H, V0.4S, #14
    USHL  V11.8H, V23.8H, V15.8H
    URSRA  V22.2S, V14.2S, #25
    USHL  V13.8B, V16.8B, V31.8B
    UMLSL2 V4.2D, V11.4S, V10.S[0x2]
    UMLAL V6.4S, V0.4H, V6.H[0x3]
    UABDL2  V2.4S, V31.8H, V31.8H
    UADDL2  V26.8H, V13.16B, V9.16B
    UMLSL2 V10.4S, V28.8H, V11.H[0x1]
    UXTL2 V16.4S, V6.8H
    UQXTN  V30.8B, V6.8H
    UXTL2 V31.4S, V2.8H
    UMLSL2 V14.2D, V20.4S, V26.S[0x1]
    USHLL V25.8H, V15.8B, #0x1
    UQSHRN V2.8B, V31.8H, #4
    UABA  V20.4S, V3.4S, V0.4S
    USHLL2 V26.2D, V14.4S, #0x12
    UADDLV  S9, V2.8H
    USHLL V23.4S, V30.4H, #0xa
    UMLAL2 V28.4S, V25.8H, V9.H[0x7]
    UADDL  V2.8H, V5.8B, V20.8B
    UMLSL2 V29.4S, V22.8H, V2.H[0x5]
    UMLSL V14.2D, V26.2S, V29.S[0x3]
    UQSHRN V13.8B, V28.8H, #7
    UQRSHRN2 V11.4S, V4.2D, #4
    UADDLV  H5, V23.8B
    USHLL2 V6.8H, V16.16B, #0x1
    UQSHRN V29.2S, V14.2D, #15
    URSHR V14.2D, V29.2D, #47
    USHL  V28.8H, V6.8H, V14.8H
    UQRSHRN V9.8B, V11.8H, #7
    UQSHRN2 V3.16B, V28.8H, #3
    UMLSL V23.2D, V13.2S, V3.S[0x3]
    USHR  V22.16B, V5.16B, #7
    UQSHRN V2.4H, V9.4S, #15
    USQADD  V6.4H, V2.4H
    URSRA V26.2D, V22.2D, #27
    UQRSHRN V22.4H, V6.4S, #2
    USHR  V20.4H, V26.4H, #14
    UMULL V4.2D, V22.2S, V22.S[0x3]
    UQRSHRN2 V16.8H, V20.4S, #1
    USHR V9.2D, V23.2D, #38
    UQSHL  V14.4S, V16.4S, #0x14
    UMLSL V28.4S, V16.4H, V9.H[0x6]
    UMLSL V26.4S, V14.4H, V5.H[0x4]
    UHADD  V2.8B, V4.8B, V4.8B
    UADDW2  V14.8H, V2.8H, V2.16B
    USUBL2  V30.4S, V26.8H, V28.8H
    UABAL2  V9.8H, V30.16B, V20.16B
    UQRSHRN2 V6.16B, V14.8H, #4
    USHR V4.2D, V6.2D, #9
    UADDL2  V22.2D, V4.4S, V4.4S
    UMLSL V2.4S, V9.4H, V9.H[0x1]
    UMLAL2  V28.4S, V2.8H, V2.8H
    UXTL2 V23.8H, V28.16B
    UMLSL  V9.8H, V22.8B, V23.8B
    SUBS  X3, X3, #0x1
    B.NE  TSRTAdvsimdVectorUnsignedOperation_label_3
    MOVZ  X24, #0x7c6d, LSL #0
    MOVK  X24, #0xfa81, LSL #16
    MOVK  X24, #0x3af4, LSL #32
    MOVK  X24, #0x8204, LSL #48
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0xa29d, LSL #0
    MOVK  X24, #0x95ee, LSL #16
    MOVK  X24, #0x9a26, LSL #32
    MOVK  X24, #0xf5da, LSL #48
    SUB  X5, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0xb476, LSL #0
    MOVK  X24, #0x6199, LSL #16
    MOVK  X24, #0xcbcc, LSL #32
    MOVK  X24, #0xe7aa, LSL #48
    SUB  X5, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x50f2, LSL #0
    SUB  X5, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0xd688, LSL #0
    MOVK  X24, #0x64eb, LSL #16
    MOVK  X24, #0xf2a9, LSL #32
    MOVK  X24, #0x5276, LSL #48
    SUB  X5, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x72d3, LSL #0
    MOVK  X24, #0xc3ff, LSL #16
    MOVK  X24, #0x4bf2, LSL #32
    MOVK  X24, #0x1446, LSL #48
    SUB  X5, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0xade5, LSL #0
    MOVK  X24, #0x309d, LSL #16
    MOVK  X24, #0xedc3, LSL #32
    MOVK  X24, #0x3593, LSL #48
    SUB  X5, X24, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0xf62c, LSL #0
    MOVK  X24, #0x3cd3, LSL #16
    MOVK  X24, #0xd8f2, LSL #32
    MOVK  X24, #0xa207, LSL #48
    SUB  X5, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0xd43f, LSL #0
    MOVK  X24, #0x6b7b, LSL #16
    MOVK  X24, #0x752, LSL #32
    MOVK  X24, #0x4868, LSL #48
    SUB  X5, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x8c6, LSL #0
    MOVK  X24, #0x1b6a, LSL #16
    MOVK  X24, #0x3ef1, LSL #32
    MOVK  X24, #0xd015, LSL #48
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x2cba, LSL #0
    MOVK  X24, #0x5539, LSL #16
    MOVK  X24, #0x69aa, LSL #32
    MOVK  X24, #0xbd0, LSL #48
    SUB  X5, X24, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x2d2c, LSL #0
    MOVK  X24, #0x6e00, LSL #16
    MOVK  X24, #0x4553, LSL #32
    MOVK  X24, #0xf380, LSL #48
    SUB  X5, X24, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x4396, LSL #0
    MOVK  X24, #0x7bf9, LSL #16
    MOVK  X24, #0x3822, LSL #32
    MOVK  X24, #0x83ad, LSL #48
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0xd27b, LSL #0
    MOVK  X24, #0xd2fe, LSL #16
    MOVK  X24, #0x633a, LSL #32
    MOVK  X24, #0x33e0, LSL #48
    SUB  X5, X24, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x23c7, LSL #0
    MOVK  X24, #0xc49e, LSL #16
    MOVK  X24, #0x193f, LSL #32
    MOVK  X24, #0xdf2, LSL #48
    SUB  X5, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0xd873, LSL #0
    MOVK  X24, #0x76ee, LSL #16
    MOVK  X24, #0x1ba3, LSL #32
    MOVK  X24, #0x53b0, LSL #48
    SUB  X5, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x2851, LSL #0
    MOVK  X24, #0x8191, LSL #16
    MOVK  X24, #0x21ce, LSL #32
    MOVK  X24, #0xffe1, LSL #48
    SUB  X5, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x800, LSL #16
    MRS  X5, FPSR
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, V0.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0x81ff, LSL #16
    FMOV  X5, D0
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, V1.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, D1
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, V2.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, D2
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, V3.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x4b72, LSL #0
    MOVK  X24, #0x827a, LSL #16
    MOVK  X24, #0x13f3, LSL #32
    MOVK  X24, #0xde10, LSL #48
    FMOV  X5, D3
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, V4.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, D4
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, V5.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, D5
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, V6.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x1, LSL #0
    FMOV  X5, D6
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x4, LSL #16
    FMOV  X5, V7.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0xd873, LSL #0
    MOVK  X24, #0x76ee, LSL #16
    MOVK  X24, #0x1ba3, LSL #32
    MOVK  X24, #0x53b0, LSL #48
    FMOV  X5, D7
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    FMOV  X5, V8.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x10, LSL #16
    FMOV  X5, D8
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, V9.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x1c, LSL #0
    FMOV  X5, D9
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, V10.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, D10
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    FMOV  X5, V11.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xfff8, LSL #16
    FMOV  X5, D11
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, V12.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0xff, LSL #0
    MOVK  X24, #0xff, LSL #16
    MOVK  X24, #0xff, LSL #32
    MOVK  X24, #0xff, LSL #48
    FMOV  X5, D12
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, V13.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, D13
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, V14.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, D14
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0x40, LSL #32
    FMOV  X5, V15.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, D15
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, V16.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, D16
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0xd43f, LSL #0
    MOVK  X24, #0x6b7b, LSL #16
    MOVK  X24, #0x752, LSL #32
    MOVK  X24, #0x4868, LSL #48
    FMOV  X5, V17.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x1aa9, LSL #0
    MOVK  X24, #0x1e2b, LSL #16
    MOVK  X24, #0x5cf0, LSL #32
    MOVK  X24, #0x2be, LSL #48
    FMOV  X5, D17
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0xb476, LSL #0
    MOVK  X24, #0x6199, LSL #16
    MOVK  X24, #0xcbcc, LSL #32
    MOVK  X24, #0xe7aa, LSL #48
    FMOV  X5, V18.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0xade5, LSL #0
    MOVK  X24, #0x309d, LSL #16
    MOVK  X24, #0xedc3, LSL #32
    MOVK  X24, #0x3593, LSL #48
    FMOV  X5, D18
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0xe46a, LSL #0
    MOVK  X24, #0x33b9, LSL #16
    MOVK  X24, #0x893e, LSL #32
    MOVK  X24, #0x6d6d, LSL #48
    FMOV  X5, V19.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x2cba, LSL #0
    MOVK  X24, #0x5539, LSL #16
    MOVK  X24, #0x69aa, LSL #32
    MOVK  X24, #0xbd0, LSL #48
    FMOV  X5, D19
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, V20.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, D20
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, V21.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, D21
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, V22.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, D22
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, V23.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, D23
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, V24.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0xff, LSL #0
    MOVK  X24, #0xff, LSL #16
    MOVK  X24, #0xff, LSL #32
    MOVK  X24, #0xff, LSL #48
    FMOV  X5, D24
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, V25.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, D25
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x3e0, LSL #16
    MOVK  X24, #0x1c, LSL #32
    FMOV  X5, V26.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x3e0, LSL #16
    MOVK  X24, #0x1c, LSL #32
    FMOV  X5, D26
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, V27.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    FMOV  X5, D27
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, V28.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, D28
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, V29.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    FMOV  X5, D29
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x1c, LSL #0
    FMOV  X5, V30.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x3e0, LSL #32
    FMOV  X5, D30
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, V31.D[1]
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X5, D31
    SUB  X7, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
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
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X9
    FMOV  V0.D[1], X10
    FMOV  D1, X25
    FMOV  V1.D[1], X15
    FMOV  D2, X22
    FMOV  V2.D[1], X27
    FMOV  D3, X21
    FMOV  V3.D[1], X14
    FMOV  D4, X16
    FMOV  V4.D[1], X20
    FMOV  D5, X29
    FMOV  V5.D[1], X28
    FMOV  D6, X24
    FMOV  V6.D[1], X13
    FMOV  D7, X23
    FMOV  V7.D[1], X5
    FMOV  D8, X7
    FMOV  V8.D[1], X6
    FMOV  D9, X22
    FMOV  V9.D[1], X16
    FMOV  D10, X8
    FMOV  V10.D[1], X28
    FMOV  D11, X21
    FMOV  V11.D[1], X17
    FMOV  D12, X27
    FMOV  V12.D[1], X25
    FMOV  D13, X27
    FMOV  V13.D[1], X28
    FMOV  D14, X12
    FMOV  V14.D[1], X2
    FMOV  D15, X28
    FMOV  V15.D[1], X16
    FMOV  D16, X25
    FMOV  V16.D[1], X3
    FMOV  D17, X14
    FMOV  V17.D[1], X15
    FMOV  D18, X24
    FMOV  V18.D[1], X14
    FMOV  D19, X6
    FMOV  V19.D[1], X5
    FMOV  D20, X2
    FMOV  V20.D[1], X7
    FMOV  D21, X2
    FMOV  V21.D[1], X2
    FMOV  D22, X24
    FMOV  V22.D[1], X29
    FMOV  D23, X3
    FMOV  V23.D[1], X6
    FMOV  D24, X17
    FMOV  V24.D[1], X9
    FMOV  D25, X10
    FMOV  V25.D[1], X10
    FMOV  D26, X13
    FMOV  V26.D[1], X23
    FMOV  D27, X9
    FMOV  V27.D[1], X2
    FMOV  D28, X17
    FMOV  V28.D[1], X12
    FMOV  D29, X13
    FMOV  V29.D[1], X17
    FMOV  D30, X4
    FMOV  V30.D[1], X24
    FMOV  D31, X2
    FMOV  V31.D[1], X5
    MOVZ  X9, #0xf, LSL #0
TSRTAdvsimdVectorUnsignedOperation_label_4:
    UABA  V25.8B, V26.8B, V26.8B
    UADDL  V30.8H, V28.8B, V23.8B
    USHLL2 V3.2D, V22.4S, #0x2
    URSRA V6.2D, V29.2D, #24
    UXTL2 V29.4S, V25.8H
    UABD  V30.4S, V27.4S, V3.4S
    UMLAL  V9.4S, V29.4H, V31.4H
    UQSHL  V25.2S, V30.2S, #0x8
    USRA  V3.8B, V6.8B, #8
    USHR V9.2D, V9.2D, #35
    URSRA  V15.4S, V9.4S, #20
    UMULL  V18.4S, V15.4H, V24.4H
    UQADD  V15.2D, V27.2D, V25.2D
    UMLSL2 V23.4S, V15.8H, V4.H[0x6]
    UXTL2 V3.4S, V1.8H
    UQSHRN V17.8B, V23.8H, #6
    UQXTN2  V22.4S, V18.2D
    UMULL  V9.4S, V3.4H, V17.4H
    UQSHRN V6.2S, V22.2D, #13
    URSHR  V17.8H, V6.8H, #2
    UMULL V1.2D, V9.2S, V9.S[0x0]
    UADDLP  V24.1D, V17.2S
    UQXTN  V30.4H, V1.4S
    USQADD  V25.16B, V24.16B
    UABDL2  V1.8H, V25.16B, V25.16B
    UQSUB  V4.8H, V16.8H, V30.8H
    USUBL  V23.8H, V4.8B, V1.8B
    USQADD  V16.4S, V24.4S
    URSRA  V31.2S, V20.2S, #25
    UQSHRN V15.2S, V20.2D, #2
    UMOV W15, V31.H[0x4]
    UMULL2 V24.2D, V23.4S, V23.S[0x3]
    UQSHRN V31.2S, V30.2D, #22
    UQRSHL  V25.8B, V6.8B, V3.8B
    UMLAL2  V22.8H, V30.16B, V19.16B
    USHL  V23.4S, V2.4S, V31.4S
    UMLAL  V30.2D, V12.2S, V24.2S
    UMLAL2 V2.4S, V20.8H, V5.H[0x1]
    UXTL2 V4.2D, V8.4S
    UQSHL  V27.4S, V20.4S, #0x1a
    UQSHRN2 V6.8H, V2.4S, #4
    UHSUB  V12.16B, V16.16B, V16.16B
    URSHR  V1.2S, V23.2S, #11
    UMULL2 V24.2D, V15.4S, V1.S[0x1]
    UQSHL  V19.8B, V30.8B, V25.8B
    UMOV W3, V4.B[0xc]
    UMOV X12, V12.D[0x0]
    UMOV W28, V24.B[0x4]
    UQSHL  V1.4H, V6.4H, #0xc
    USUBL  V9.4S, V22.4H, V22.4H
    USUBW  V2.8H, V9.8H, V27.8B
    UQSHRN2 V5.8H, V1.4S, #8
    URSQRTE  V20.4S, V5.4S
    UABD  V23.16B, V19.16B, V20.16B
    URSRA  V15.16B, V2.16B, #7
    URSHR  V22.8H, V23.8H, #11
    UQSHL  V12.4H, V22.4H, #0x8
    URECPE  V6.4S, V12.4S
    USHR  V2.8H, V15.8H, #3
    UXTL2 V30.2D, V2.4S
    USQADD  V12.4H, V6.4H
    UQSHRN2 V16.8H, V30.4S, #4
    UQSUB  V5.8H, V16.8H, V16.8H
    UADDL2  V22.4S, V5.8H, V5.8H
    UMLSL V5.2D, V4.2S, V22.S[0x2]
    USHL  V19.4H, V28.4H, V5.4H
    UMLSL2  V20.2D, V19.4S, V19.4S
    UQSHRN2 V6.8H, V12.4S, #9
    UHADD  V12.8B, V0.8B, V20.8B
    UXTL V2.8H, V6.8B
    UQXTN2  V1.16B, V2.8H
    UMLAL V23.4S, V12.4H, V1.H[0x2]
    UABDL2  V30.8H, V14.16B, V16.16B
    UQRSHRN V15.2S, V20.2D, #6
    USUBL2  V24.2D, V22.4S, V8.4S
    URSHR  V6.2S, V5.2S, #32
    URSRA  V8.16B, V20.16B, #2
    UQSHRN2 V20.8H, V14.4S, #9
    UMLAL2 V27.4S, V22.8H, V7.H[0x5]
    UQRSHRN2 V4.16B, V22.8H, #5
    UMLAL V7.2D, V23.2S, V23.S[0x0]
    URSRA  V14.16B, V7.16B, #8
    USHLL2 V23.4S, V30.8H, #0x5
    UQRSHRN2 V13.4S, V8.2D, #5
    USHR  V0.8B, V20.8B, #1
    URSHR  V30.4H, V14.4H, #16
    UMULL2  V20.2D, V30.4S, V13.4S
    URSQRTE  V16.4S, V20.4S
    UMLAL2  V28.2D, V4.4S, V9.4S
    UMOV W8, V6.S[0x3]
    UQSHL  V30.8B, V22.8B, #0x2
    UMLSL2 V1.4S, V23.8H, V15.H[0x7]
    UADDL2  V5.8H, V28.16B, V6.16B
    UMLAL  V13.4S, V27.4H, V24.4H
    USRA  V23.4S, V0.4S, #5
    UMLSL V28.2D, V1.2S, V7.S[0x2]
    UMOV W27, V5.S[0x3]
    URSHR  V14.4H, V28.4H, #4
    UQSHL  V7.8B, V14.8B, #0x0
    UMLAL V28.4S, V7.4H, V15.H[0x7]
    UMOV X14, V12.D[0x1]
    UMLSL V8.2D, V16.2S, V30.S[0x1]
    UADDW  V20.8H, V23.8H, V28.8B
    USUBL2  V5.8H, V13.16B, V8.16B
    UADDW2  V8.8H, V5.8H, V20.16B
    USRA  V4.4H, V15.4H, #11
    UADDL  V6.8H, V0.8B, V11.8B
    USHLL2 V5.4S, V31.8H, #0x6
    UADDL2  V11.8H, V14.16B, V29.16B
    UXTL V22.4S, V28.4H
    USHR V9.2D, V24.2D, #48
    UXTL2 V31.8H, V15.16B
    UMULL V1.4S, V23.4H, V10.H[0x0]
    UMOV W8, V31.H[0x5]
    URSRA  V20.2S, V5.2S, #31
    UXTL2 V14.2D, V6.4S
    URSRA V13.2D, V8.2D, #6
    UMLAL2 V27.4S, V22.8H, V4.H[0x0]
    URSHR  V12.8H, V11.8H, #3
    UQRSHRN2 V24.16B, V9.8H, #5
    UMULL2 V9.4S, V21.8H, V13.H[0x0]
    URSRA  V11.2S, V9.2S, #21
    UABD  V15.8B, V27.8B, V14.8B
    URSQRTE  V21.4S, V15.4S
    UQXTN2  V31.16B, V1.8H
    URSHR V9.2D, V31.2D, #61
    URSQRTE  V14.2S, V11.2S
    UXTL2 V8.8H, V24.16B
    UADALP  V13.2S, V20.4H
    UXTL V27.4S, V9.4H
    UMOV X28, V12.D[0x0]
    UMLSL2  V4.8H, V21.16B, V8.16B
    UQSHL  V8.2S, V4.2S, #0x1d
    UADALP  V15.4S, V8.8H
    UQSHL  V10.8H, V14.8H, #0x7
    UMLSL V22.4S, V10.4H, V15.H[0x5]
    USHLL2 V21.2D, V13.4S, #0x7
    UXTL2 V24.8H, V21.16B
    UXTL2 V1.4S, V24.8H
    UQSHRN V4.8B, V22.8H, #3
    USRA V8.2D, V27.2D, #17
    USUBL2  V12.2D, V4.4S, V1.4S
    UMULL V6.2D, V13.2S, V8.S[0x3]
    UQADD  V10.2D, V12.2D, V6.2D
    UMULL  V31.4S, V14.4H, V22.4H
    UMLAL V24.2D, V9.2S, V0.S[0x1]
    URSRA  V15.8H, V29.8H, #5
    UMLSL V22.4S, V3.4H, V1.H[0x2]
    UMLAL2 V27.4S, V17.8H, V14.H[0x3]
    UQSHL V4.2D, V17.2D, #0x9
    USHR  V21.8H, V22.8H, #16
    UMLSL2  V12.8H, V20.16B, V5.16B
    USUBL2  V5.8H, V11.16B, V15.16B
    USHR  V17.8H, V14.8H, #1
    UQADD  V13.4S, V27.4S, V5.4S
    UABA  V27.4H, V4.4H, V13.4H
    UABD  V13.16B, V31.16B, V31.16B
    UQXTN2  V6.16B, V12.8H
    UMLSL2  V8.8H, V27.16B, V13.16B
    UQRSHRN2 V31.4S, V17.2D, #5
    UADDLV  H17, V24.16B
    UQXTN  V3.2S, V6.2D
    UABAL2  V6.4S, V8.8H, V10.8H
    UMLSL2 V9.4S, V21.8H, V15.H[0x5]
    UADDLP  V4.2S, V9.4H
    UADALP  V24.2S, V31.4H
    UQRSHL  V20.16B, V17.16B, V17.16B
    URSRA  V13.8B, V24.8B, #8
    UXTL V12.4S, V6.4H
    UXTL V8.2D, V12.2S
    UQSHL  V10.8H, V20.8H, #0xe
    UMLAL V14.4S, V13.4H, V3.H[0x6]
    USHR  V27.16B, V14.16B, #8
    UQSHL  V22.8H, V8.8H, #0xe
    URSRA V8.2D, V10.2D, #52
    UQSHL  V12.16B, V4.16B, #0x5
    USUBW  V4.4S, V27.4S, V27.4H
    UABA  V5.2S, V22.2S, V12.2S
    UMLAL2 V10.2D, V5.4S, V5.S[0x2]
    UQRSHRN2 V9.8H, V8.4S, #2
    UQSHL  V14.16B, V9.16B, V4.16B
    UMLAL V13.4S, V14.4H, V10.H[0x1]
    UMLAL V27.2D, V9.2S, V30.S[0x1]
    URSHR V5.2D, V12.2D, #56
    UMLAL V17.2D, V8.2S, V12.S[0x2]
    UMLSL V22.2D, V31.2S, V24.S[0x1]
    UMOV W23, V20.H[0x1]
    UQSHRN V6.2S, V16.2D, #24
    UQXTN2  V10.8H, V28.4S
    UQSHL  V14.16B, V26.16B, #0x4
    URSQRTE  V4.4S, V29.4S
    UMLAL V30.2D, V4.2S, V22.S[0x3]
    UQSHRN V26.2S, V27.2D, #15
    UQADD  V9.4S, V13.4S, V30.4S
    URSHL  V3.16B, V9.16B, V9.16B
    UADALP  V27.2D, V17.4S
    USHLL V22.4S, V20.4H, #0x2
    UABDL2  V29.4S, V12.8H, V14.8H
    USHR  V8.4S, V27.4S, #16
    UMULL2 V12.2D, V2.4S, V3.S[0x3]
    SUBS  X9, X9, #0x1
    B.NE  TSRTAdvsimdVectorUnsignedOperation_label_4
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x800, LSL #16
    MRS  X7, FPSR
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V0.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x7f7f, LSL #0
    MOVK  X29, #0x7f7f, LSL #16
    MOVK  X29, #0x7f7f, LSL #32
    MOVK  X29, #0x7f7f, LSL #48
    FMOV  X7, D0
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V1.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, D1
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xff, LSL #0
    MOVK  X29, #0xff, LSL #16
    MOVK  X29, #0xff, LSL #32
    MOVK  X29, #0xff, LSL #48
    FMOV  X7, V2.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xff, LSL #0
    MOVK  X29, #0xff, LSL #16
    MOVK  X29, #0xff, LSL #32
    MOVK  X29, #0xff, LSL #48
    FMOV  X7, D2
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V3.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, D3
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X7, V4.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X7, D4
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V5.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, D5
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V6.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X7, D6
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V7.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, D7
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V8.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, D8
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V9.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, D9
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V10.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, D10
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V11.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, D11
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V12.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, D12
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V13.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, D13
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V14.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, D14
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V15.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x7d, LSL #0
    MOVK  X29, #0x81, LSL #16
    MOVK  X29, #0xfffe, LSL #32
    MOVK  X29, #0x1, LSL #48
    FMOV  X7, D15
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X7, V16.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X7, D16
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V17.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, D17
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V18.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, D18
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V19.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, D19
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V20.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, D20
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V21.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, D21
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V22.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, D22
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V23.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xfbfb, LSL #0
    MOVK  X29, #0x3fb, LSL #16
    MOVK  X29, #0xfbfb, LSL #32
    MOVK  X29, #0x3fb, LSL #48
    FMOV  X7, D23
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V24.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, D24
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V25.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, D25
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V26.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, D26
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V27.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, D27
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V28.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, D28
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V29.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, D29
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, V30.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, D30
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    FMOV  X7, V31.D[1]
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X7, D31
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorUnsignedOperation_TestFail
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
    FMOV  D0, X24
    FMOV  V0.D[1], X28
    FMOV  D1, X29
    FMOV  V1.D[1], X25
    FMOV  D2, X27
    FMOV  V2.D[1], X28
    FMOV  D3, X16
    FMOV  V3.D[1], X9
    FMOV  D4, X24
    FMOV  V4.D[1], X27
    FMOV  D5, X22
    FMOV  V5.D[1], X29
    FMOV  D6, X27
    FMOV  V6.D[1], X14
    FMOV  D7, X8
    FMOV  V7.D[1], X16
    FMOV  D8, X15
    FMOV  V8.D[1], X22
    FMOV  D9, X5
    FMOV  V9.D[1], X13
    FMOV  D10, X9
    FMOV  V10.D[1], X21
    FMOV  D11, X16
    FMOV  V11.D[1], X22
    FMOV  D12, X10
    FMOV  V12.D[1], X17
    FMOV  D13, X21
    FMOV  V13.D[1], X10
    FMOV  D14, X20
    FMOV  V14.D[1], X21
    FMOV  D15, X5
    FMOV  V15.D[1], X22
    FMOV  D16, X2
    FMOV  V16.D[1], X5
    FMOV  D17, X10
    FMOV  V17.D[1], X9
    FMOV  D18, X7
    FMOV  V18.D[1], X23
    FMOV  D19, X16
    FMOV  V19.D[1], X12
    FMOV  D20, X24
    FMOV  V20.D[1], X6
    FMOV  D21, X15
    FMOV  V21.D[1], X9
    FMOV  D22, X9
    FMOV  V22.D[1], X13
    FMOV  D23, X14
    FMOV  V23.D[1], X17
    FMOV  D24, X13
    FMOV  V24.D[1], X10
    FMOV  D25, X25
    FMOV  V25.D[1], X8
    FMOV  D26, X27
    FMOV  V26.D[1], X15
    FMOV  D27, X8
    FMOV  V27.D[1], X25
    FMOV  D28, X22
    FMOV  V28.D[1], X6
    FMOV  D29, X27
    FMOV  V29.D[1], X14
    FMOV  D30, X5
    FMOV  V30.D[1], X10
    FMOV  D31, X3
    FMOV  V31.D[1], X20
    MOVZ  X20, #0xf, LSL #0
TSRTAdvsimdVectorUnsignedOperation_label_5:
    UXTL2 V2.2D, V25.4S
    UQADD  V30.2S, V2.2S, V29.2S
    USHR  V8.16B, V20.16B, #3
    UQRSHRN2 V20.4S, V28.2D, #21
    UHADD  V2.2S, V26.2S, V27.2S
    URSHR V20.2D, V30.2D, #41
    UQSHL  V2.4S, V21.4S, #0x7
    URSRA  V0.16B, V24.16B, #1
    UMLAL2  V26.8H, V0.16B, V23.16B
    USHL  V8.4H, V31.4H, V2.4H
    USUBW  V8.8H, V20.8H, V26.8B
    URSRA  V25.8H, V9.8H, #9
    UMULL2 V2.4S, V8.8H, V8.H[0x7]
    UQSHL  V15.8B, V2.8B, #0x7
    USRA  V5.8B, V25.8B, #8
    URSHR  V2.4H, V5.4H, #2
    UMLSL2 V28.2D, V11.4S, V15.S[0x2]
    UQXTN  V26.4H, V28.4S
    UADDLV  S11, V2.4H
    URSHR  V24.2S, V26.2S, #31
    UABD  V5.16B, V24.16B, V24.16B
    UQRSHL  V25.8H, V5.8H, V11.8H
    USQADD  V31.4S, V24.4S
    UQRSHRN2 V21.8H, V15.4S, #8
    UQSHL V29.2D, V0.2D, #0x35
    UQRSHL  V0.16B, V17.16B, V10.16B
    UMOV W22, V15.S[0x2]
    UMULL2 V17.4S, V9.8H, V0.H[0x6]
    URSHR  V15.4S, V13.4S, #27
    UQSHL  V20.8B, V14.8B, #0x2
    UMLAL V30.2D, V18.2S, V1.S[0x3]
    USRA  V26.2S, V29.2S, #12
    UADDL2  V9.8H, V17.16B, V29.16B
    USHR  V28.8H, V0.8H, #16
    UMLAL2  V0.4S, V7.8H, V25.8H
    URHADD  V23.4H, V0.4H, V0.4H
    UADALP  V14.4H, V26.8B
    UQSHL  V25.4S, V31.4S, V1.4S
    UMOV W2, V15.B[0x0]
    UQSHL  V31.4S, V9.4S, V14.4S
    UADALP  V18.4H, V23.8B
    URECPE  V0.2S, V30.2S
    UHSUB  V9.8B, V28.8B, V28.8B
    UMLSL V10.2D, V4.2S, V31.S[0x1]
    UADDL  V17.2D, V21.2S, V10.2S
    UQSHRN V30.8B, V20.8H, #4
    USHR  V13.4H, V0.4H, #12
    URHADD  V7.16B, V13.16B, V30.16B
    UMULL V30.2D, V25.2S, V17.S[0x2]
    UQRSHRN2 V29.4S, V18.2D, #13
    URSHR V1.2D, V30.2D, #35
    URSHR  V15.2S, V7.2S, #22
    UADDW  V26.8H, V9.8H, V9.8B
    UABAL  V1.8H, V1.8B, V1.8B
    UABAL  V7.8H, V1.8B, V26.8B
    UADDLV  S30, V7.8H
    UABAL  V18.4S, V29.4H, V30.4H
    UQRSHRN V26.2S, V15.2D, #11
    USHLL V30.4S, V18.4H, #0x2
    UMOV X16, V14.D[0x0]
    UMLAL V23.4S, V26.4H, V15.H[0x2]
    UQSHL  V26.2S, V30.2S, #0x4
    UMLAL2 V9.4S, V26.8H, V3.H[0x7]
    USRA  V30.4H, V23.4H, #10
    URSHR  V29.8H, V30.8H, #1
    UQSHL  V3.8B, V29.8B, #0x1
    UMLSL V1.2D, V3.2S, V9.S[0x0]
    UQRSHRN2 V9.4S, V15.2D, #27
    UADDLV  H30, V27.16B
    URSHR  V26.4S, V27.4S, #22
    USRA  V18.4H, V14.4H, #7
    UMULL2  V23.4S, V24.8H, V4.8H
    UMULL V25.2D, V27.2S, V17.S[0x1]
    UMLSL V7.4S, V5.4H, V15.H[0x3]
    USQADD  V4.2D, V12.2D
    UABA  V29.8B, V1.8B, V23.8B
    UMULL  V3.2D, V9.2S, V25.2S
    UQSHRN2 V5.8H, V4.4S, #16
    UADDW2  V14.4S, V5.4S, V30.8H
    UABAL  V5.2D, V3.2S, V9.2S
    URSHR  V3.4H, V7.4H, #5
    UADDL  V27.8H, V26.8B, V3.8B
    URSQRTE  V9.4S, V18.4S
    UQRSHRN2 V30.16B, V5.8H, #2
    UMULL V12.2D, V30.2S, V27.S[0x2]
    UMLAL2 V24.2D, V12.4S, V9.S[0x0]
    UMOV W7, V29.H[0x6]
    USHR  V4.16B, V14.16B, #1
    UABDL2  V7.4S, V4.8H, V24.8H
    UQRSHRN2 V4.8H, V15.4S, #13
    UQSHRN V15.2S, V19.2D, #14
    UABAL  V25.8H, V31.8B, V18.8B
    USHLL V0.2D, V10.2S, #0x10
    UADDL  V31.4S, V20.4H, V30.4H
    UQSHL  V1.4S, V2.4S, #0x14
    UQSHRN2 V20.16B, V17.8H, #1
    USUBL2  V19.4S, V19.8H, V29.8H
    URSHR  V24.4S, V19.4S, #8
    URSHR  V5.2S, V20.2S, #7
    UMULL V29.4S, V5.4H, V4.H[0x6]
    UQSHRN2 V14.4S, V29.2D, #31
    USHLL V29.2D, V7.2S, #0x16
    UQXTN  V12.8B, V29.8H
    UMLSL V5.2D, V24.2S, V0.S[0x1]
    UMLAL V9.2D, V31.2S, V15.S[0x3]
    UMOV W4, V9.H[0x2]
    UMULL V10.2D, V25.2S, V8.S[0x0]
    UMLAL V9.4S, V14.4H, V5.H[0x7]
    UMLAL  V8.2D, V1.2S, V1.2S
    URSRA  V25.4H, V12.4H, #4
    URSHR  V7.2S, V23.2S, #25
    URSHR  V23.2S, V29.2S, #16
    UQADD  V27.8H, V25.8H, V10.8H
    USHLL2 V25.2D, V10.4S, #0xf
    UMLAL2 V19.2D, V23.4S, V27.S[0x1]
    USHLL2 V18.4S, V9.8H, #0x6
    UQADD  V10.16B, V17.16B, V7.16B
    UABDL2  V31.2D, V8.4S, V8.4S
    URSRA  V5.2S, V25.2S, #31
    UHADD  V23.8B, V19.8B, V19.8B
    UABA  V14.16B, V0.16B, V23.16B
    USHR V29.2D, V5.2D, #48
    UMOV W16, V29.H[0x2]
    URSRA  V9.8B, V14.8B, #2
    UXTL2 V15.8H, V9.16B
    USHLL2 V12.4S, V18.8H, #0x9
    URSHR V0.2D, V13.2D, #27
    UQSHL  V5.8B, V19.8B, #0x7
    UABDL  V23.4S, V0.4H, V0.4H
    UQRSHRN V8.2S, V12.2D, #15
    UMLSL  V17.4S, V10.4H, V8.4H
    USUBL  V9.8H, V31.8B, V15.8B
    UMLSL V15.4S, V9.4H, V5.H[0x7]
    UABD  V1.2S, V23.2S, V15.2S
    UQSHL  V25.8B, V0.8B, #0x4
    UQSHRN V18.4H, V1.4S, #4
    UXTL V27.4S, V18.4H
    URECPE  V1.2S, V27.2S
    UABDL  V19.2D, V1.2S, V1.2S
    USHLL V29.2D, V25.2S, #0x5
    UQSHL V1.2D, V17.2D, #0x24
    UMULL V7.4S, V19.4H, V4.H[0x6]
    UABAL  V13.8H, V29.8B, V7.8B
    UHSUB  V15.4S, V13.4S, V1.4S
    UMLSL V12.4S, V18.4H, V0.H[0x1]
    USQADD  V14.8H, V25.8H
    UMLSL  V13.2D, V3.2S, V25.2S
    USHR V5.2D, V16.2D, #55
    UQSHL  V17.16B, V20.16B, #0x0
    UMLAL  V10.4S, V26.4H, V27.4H
    UMLAL2 V0.4S, V27.8H, V2.H[0x2]
    UMLSL V3.2D, V12.2S, V26.S[0x3]
    UXTL V23.2D, V3.2S
    UABD  V25.2S, V14.2S, V21.2S
    UXTL V27.4S, V15.4H
    USRA  V12.4S, V8.4S, #17
    USRA V8.2D, V0.2D, #26
    UQSHRN V0.4H, V23.4S, #15
    UXTL V15.8H, V8.8B
    URSRA V18.2D, V27.2D, #2
    URSRA V21.2D, V25.2D, #46
    USHR  V31.2S, V13.2S, #30
    UMLAL2 V14.2D, V0.4S, V18.S[0x0]
    UXTL V4.2D, V12.2S
    UXTL V27.2D, V31.2S
    UMULL2 V16.2D, V10.4S, V10.S[0x1]
    URSQRTE  V8.4S, V4.4S
    USHR  V13.16B, V14.16B, #7
    UQSHL V18.2D, V16.2D, #0x36
    UQRSHRN2 V3.16B, V8.8H, #8
    USRA  V14.2S, V27.2S, #19
    UMULL2 V8.2D, V21.4S, V15.S[0x0]
    UMOV X3, V13.D[0x0]
    USHLL V13.8H, V8.8B, #0x4
    UXTL2 V27.8H, V3.16B
    UMOV X27, V14.D[0x0]
    UQSHL  V25.4S, V27.4S, #0x7
    URSRA  V3.8H, V25.8H, #9
    USHLL V14.4S, V13.4H, #0xd
    UMLSL V2.2D, V3.2S, V14.S[0x1]
    URSQRTE  V21.4S, V18.4S
    UMLAL V15.4S, V25.4H, V1.H[0x5]
    UXTL2 V23.4S, V2.8H
    USHR  V3.2S, V23.2S, #27
    UQSHL  V27.4S, V15.4S, #0xa
    USRA  V0.16B, V21.16B, #1
    UQSHL  V8.4S, V3.4S, #0x1c
    UQSHL  V18.16B, V8.16B, #0x5
    UXTL2 V16.4S, V27.8H
    URECPE  V14.4S, V0.4S
    URSRA V0.2D, V14.2D, #14
    UABAL2  V21.2D, V16.4S, V18.4S
    UXTL V13.8H, V21.8B
    USHLL2 V31.4S, V0.8H, #0x6
    UQRSHRN V25.4H, V31.4S, #13
    USHLL2 V0.4S, V25.8H, #0x1
    UMLAL2  V1.8H, V0.16B, V13.16B
    URSHR  V23.8H, V9.8H, #3
    UMLSL V9.4S, V14.4H, V15.H[0x5]
    USRA  V15.8B, V14.8B, #7
    SUBS  X20, X20, #0x1
    B.NE  TSRTAdvsimdVectorUnsignedOperation_label_5
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x1, LSL #0
    MOVK  X13, #0x101, LSL #16
    MOVK  X13, #0x101, LSL #32
    SUB  X12, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    SUB  X12, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X12, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X12, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X12, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X12, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X12, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X12, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X12, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X12, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X12, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X12, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x10ff, LSL #0
    MOVK  X13, #0xe0fc, LSL #16
    MOVK  X13, #0xf2ab, LSL #32
    SUB  X12, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X12, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X12, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x800, LSL #16
    MRS  X12, FPSR
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, V0.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, D0
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X12, V1.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X12, D1
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, V2.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, D2
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, V3.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, D3
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xfc00, LSL #0
    FMOV  X12, V4.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xfe00, LSL #0
    MOVK  X13, #0x1ff, LSL #16
    FMOV  X12, D4
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, V5.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, D5
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X12, V6.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X12, D6
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, V7.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, D7
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, V8.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, D8
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x7f82, LSL #0
    MOVK  X13, #0x807e, LSL #16
    MOVK  X13, #0x7f82, LSL #32
    MOVK  X13, #0x807e, LSL #48
    FMOV  X12, V9.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x7f82, LSL #0
    MOVK  X13, #0x807e, LSL #16
    MOVK  X13, #0x7f82, LSL #32
    MOVK  X13, #0x807e, LSL #48
    FMOV  X12, D9
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x8100, LSL #0
    MOVK  X13, #0xffff, LSL #16
    FMOV  X12, V10.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xcffb, LSL #0
    MOVK  X13, #0xf2ac, LSL #16
    FMOV  X12, D10
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, V11.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, D11
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x8000, LSL #0
    MOVK  X13, #0x1ff, LSL #16
    MOVK  X13, #0x7e00, LSL #32
    FMOV  X12, V12.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xfe00, LSL #0
    MOVK  X13, #0x1ff, LSL #16
    MOVK  X13, #0xfc00, LSL #32
    FMOV  X12, D12
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, V13.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xfe, LSL #0
    MOVK  X13, #0xff, LSL #16
    FMOV  X12, D13
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X12, V14.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X12, D14
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, V15.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x8280, LSL #0
    MOVK  X13, #0x8083, LSL #16
    MOVK  X13, #0x8181, LSL #32
    MOVK  X13, #0x817c, LSL #48
    FMOV  X12, D15
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #32
    FMOV  X12, V16.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #32
    FMOV  X12, D16
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #32
    FMOV  X12, V17.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X12, D17
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, V18.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, D18
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, V19.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, D19
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #32
    FMOV  X12, V20.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X12, D20
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xfffe, LSL #0
    FMOV  X12, V21.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xfffe, LSL #0
    FMOV  X12, D21
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X12, V22.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X12, D22
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, V23.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, D23
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, V24.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, D24
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, V25.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xff, LSL #0
    MOVK  X13, #0xff, LSL #16
    MOVK  X13, #0xff, LSL #32
    MOVK  X13, #0xff, LSL #48
    FMOV  X12, D25
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x400, LSL #0
    MOVK  X13, #0x400, LSL #32
    FMOV  X12, V26.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x400, LSL #0
    MOVK  X13, #0x400, LSL #32
    FMOV  X12, D26
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X12, V27.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X12, D27
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, V28.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, D28
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X12, V29.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x1fe0, LSL #0
    MOVK  X13, #0x1fe2, LSL #16
    MOVK  X13, #0x2, LSL #32
    FMOV  X12, D29
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xff, LSL #32
    MOVK  X13, #0x80, LSL #48
    FMOV  X12, V30.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xff0, LSL #0
    FMOV  X12, D30
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xdfc0, LSL #0
    MOVK  X13, #0x1f, LSL #16
    MOVK  X13, #0xe0c0, LSL #32
    MOVK  X13, #0x1f, LSL #48
    FMOV  X12, V31.D[1]
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X13, #0xdfc0, LSL #0
    MOVK  X13, #0x1f, LSL #16
    MOVK  X13, #0xdfc0, LSL #32
    MOVK  X13, #0x1f, LSL #48
    FMOV  X12, D31
    SUB  X23, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x9053, LSL #0
    MOVK  X2, #0xeb86, LSL #16
    MOVK  X2, #0xf792, LSL #32
    MOVK  X2, #0x7262, LSL #48
    MOVZ  X3, #0x2b90, LSL #0
    MOVK  X3, #0xa448, LSL #16
    MOVK  X3, #0xa8f7, LSL #32
    MOVK  X3, #0xe84f, LSL #48
    MOVZ  X4, #0x4d9e, LSL #0
    MOVK  X4, #0x3c16, LSL #16
    MOVK  X4, #0x5a9e, LSL #32
    MOVK  X4, #0x82fe, LSL #48
    MOVZ  X5, #0xc4a5, LSL #0
    MOVK  X5, #0x6b22, LSL #16
    MOVK  X5, #0x172e, LSL #32
    MOVK  X5, #0xebbd, LSL #48
    MOVZ  X6, #0x89ec, LSL #0
    MOVK  X6, #0xb882, LSL #16
    MOVK  X6, #0x791c, LSL #32
    MOVK  X6, #0x37cb, LSL #48
    MOVZ  X7, #0x960e, LSL #0
    MOVK  X7, #0x58b2, LSL #16
    MOVK  X7, #0x1cc8, LSL #32
    MOVK  X7, #0x6e11, LSL #48
    MOVZ  X8, #0x6a5a, LSL #0
    MOVK  X8, #0x6841, LSL #16
    MOVK  X8, #0xa399, LSL #32
    MOVK  X8, #0x2779, LSL #48
    MOVZ  X9, #0x241f, LSL #0
    MOVK  X9, #0x5898, LSL #16
    MOVK  X9, #0xcc45, LSL #32
    MOVK  X9, #0x7d9f, LSL #48
    MOVZ  X10, #0xdfe1, LSL #0
    MOVK  X10, #0x424e, LSL #16
    MOVK  X10, #0x78d9, LSL #32
    MOVK  X10, #0x6d92, LSL #48
    MOVZ  X12, #0x7f95, LSL #0
    MOVK  X12, #0xb00b, LSL #16
    MOVK  X12, #0xee8e, LSL #32
    MOVK  X12, #0x6af6, LSL #48
    MOVZ  X13, #0x3f93, LSL #0
    MOVK  X13, #0x24df, LSL #16
    MOVK  X13, #0x122, LSL #32
    MOVK  X13, #0x2d2d, LSL #48
    MOVZ  X14, #0x1a08, LSL #0
    MOVK  X14, #0x7072, LSL #16
    MOVK  X14, #0x6e14, LSL #32
    MOVK  X14, #0xcad, LSL #48
    MOVZ  X15, #0x801e, LSL #0
    MOVK  X15, #0x57c5, LSL #16
    MOVK  X15, #0xec18, LSL #32
    MOVK  X15, #0xfe3d, LSL #48
    MOVZ  X16, #0x677e, LSL #0
    MOVK  X16, #0xa161, LSL #16
    MOVK  X16, #0x5edc, LSL #32
    MOVK  X16, #0xcaf7, LSL #48
    MOVZ  X17, #0x2871, LSL #0
    MOVK  X17, #0x15b7, LSL #16
    MOVK  X17, #0x10e2, LSL #32
    MOVK  X17, #0x5f9, LSL #48
    MOVZ  X20, #0xb1e2, LSL #0
    MOVK  X20, #0x2ff9, LSL #16
    MOVK  X20, #0xde2f, LSL #32
    MOVK  X20, #0xac70, LSL #48
    MOVZ  X21, #0x8ab0, LSL #0
    MOVK  X21, #0xf8a3, LSL #16
    MOVK  X21, #0x7c4f, LSL #32
    MOVK  X21, #0x8a76, LSL #48
    MOVZ  X22, #0x6d9d, LSL #0
    MOVK  X22, #0x3865, LSL #16
    MOVK  X22, #0xfcda, LSL #32
    MOVK  X22, #0xc284, LSL #48
    MOVZ  X23, #0xd4dd, LSL #0
    MOVK  X23, #0x1143, LSL #16
    MOVK  X23, #0xe7a6, LSL #32
    MOVK  X23, #0x443b, LSL #48
    MOVZ  X24, #0xac51, LSL #0
    MOVK  X24, #0x44e8, LSL #16
    MOVK  X24, #0xa4d7, LSL #32
    MOVK  X24, #0x7e4e, LSL #48
    MOVZ  X25, #0xfefb, LSL #0
    MOVK  X25, #0xcbcd, LSL #16
    MOVK  X25, #0x257a, LSL #32
    MOVK  X25, #0xc22e, LSL #48
    MOVZ  X27, #0x518e, LSL #0
    MOVK  X27, #0xf85d, LSL #16
    MOVK  X27, #0x57dd, LSL #32
    MOVK  X27, #0xea81, LSL #48
    MOVZ  X28, #0x23ad, LSL #0
    MOVK  X28, #0xf601, LSL #16
    MOVK  X28, #0xfd04, LSL #32
    MOVK  X28, #0xd723, LSL #48
    MOVZ  X29, #0x7d3a, LSL #0
    MOVK  X29, #0xd1d5, LSL #16
    MOVK  X29, #0x2c70, LSL #32
    MOVK  X29, #0x597a, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X24
    FMOV  D1, X29
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X21
    FMOV  D3, X20
    FMOV  V3.D[1], X22
    FMOV  D4, X23
    FMOV  V4.D[1], X4
    FMOV  D5, X27
    FMOV  V5.D[1], X7
    FMOV  D6, X25
    FMOV  V6.D[1], X16
    FMOV  D7, X25
    FMOV  V7.D[1], X10
    FMOV  D8, X2
    FMOV  V8.D[1], X23
    FMOV  D9, X9
    FMOV  V9.D[1], X22
    FMOV  D10, X6
    FMOV  V10.D[1], X2
    FMOV  D11, X24
    FMOV  V11.D[1], X22
    FMOV  D12, X3
    FMOV  V12.D[1], X15
    FMOV  D13, X5
    FMOV  V13.D[1], X16
    FMOV  D14, X9
    FMOV  V14.D[1], X21
    FMOV  D15, X21
    FMOV  V15.D[1], X24
    FMOV  D16, X14
    FMOV  V16.D[1], X14
    FMOV  D17, X22
    FMOV  V17.D[1], X2
    FMOV  D18, X27
    FMOV  V18.D[1], X4
    FMOV  D19, X14
    FMOV  V19.D[1], X2
    FMOV  D20, X23
    FMOV  V20.D[1], X28
    FMOV  D21, X20
    FMOV  V21.D[1], X9
    FMOV  D22, X14
    FMOV  V22.D[1], X8
    FMOV  D23, X7
    FMOV  V23.D[1], X29
    FMOV  D24, X25
    FMOV  V24.D[1], X5
    FMOV  D25, X14
    FMOV  V25.D[1], X10
    FMOV  D26, X6
    FMOV  V26.D[1], X16
    FMOV  D27, X23
    FMOV  V27.D[1], X13
    FMOV  D28, X5
    FMOV  V28.D[1], X21
    FMOV  D29, X29
    FMOV  V29.D[1], X21
    FMOV  D30, X8
    FMOV  V30.D[1], X7
    FMOV  D31, X5
    FMOV  V31.D[1], X2
    MOVZ  X24, #0xf, LSL #0
TSRTAdvsimdVectorUnsignedOperation_label_6:
    URSRA  V29.4H, V17.4H, #4
    UQSHL  V20.8B, V25.8B, #0x6
    UQRSHRN V1.4H, V24.4S, #12
    UQSHL  V6.8H, V26.8H, #0xb
    UQRSHRN2 V5.16B, V28.8H, #6
    USQADD  V25.8H, V5.8H
    UQSHL V0.2D, V30.2D, #0x37
    UXTL2 V11.2D, V27.4S
    UHADD  V16.16B, V11.16B, V31.16B
    UQSHL  V4.8B, V16.8B, #0x4
    UQRSHRN2 V3.4S, V6.2D, #7
    UMULL2  V27.2D, V0.4S, V29.4S
    USUBW  V27.8H, V1.8H, V25.8B
    USHLL V11.4S, V20.4H, #0xe
    URSRA V5.2D, V11.2D, #25
    UADDL  V6.8H, V4.8B, V3.8B
    UABAL2  V20.8H, V27.16B, V29.16B
    UQSHRN2 V17.16B, V20.8H, #8
    UQXTN2  V30.8H, V17.4S
    UXTL2 V28.2D, V30.4S
    UHSUB  V17.8B, V5.8B, V5.8B
    UQRSHRN2 V11.8H, V18.4S, #2
    USHR  V31.8H, V11.8H, #7
    UMULL V16.2D, V28.2S, V6.S[0x3]
    UADALP  V5.4S, V17.8H
    USQADD  V28.8H, V5.8H
    UQRSHRN V5.2S, V28.2D, #32
    UQSHL V20.2D, V5.2D, #0x26
    UQSHRN2 V11.8H, V20.4S, #9
    UADDW  V26.4S, V11.4S, V11.4H
    USRA  V0.4H, V26.4H, #8
    UMLAL V6.4S, V0.4H, V1.H[0x1]
    UMULL2  V28.4S, V6.8H, V6.8H
    UMLSL2 V18.2D, V31.4S, V28.S[0x2]
    URSQRTE  V6.2S, V16.2S
    UADDW  V20.8H, V6.8H, V13.8B
    USHR  V0.2S, V20.2S, #9
    UQSHRN2 V16.16B, V0.8H, #3
    UQSHRN V31.8B, V16.8H, #4
    UQRSHRN2 V27.16B, V18.8H, #5
    UQRSHRN2 V28.16B, V27.8H, #4
    URSRA V4.2D, V28.2D, #39
    UXTL V1.8H, V4.8B
    UQRSHRN V17.2S, V1.2D, #15
    UQADD  V11.2S, V31.2S, V31.2S
    UMLAL2 V26.2D, V17.4S, V17.S[0x2]
    USRA V1.2D, V28.2D, #31
    UABD  V6.8B, V1.8B, V1.8B
    USHLL2 V31.8H, V26.16B, #0x5
    UQSHRN V16.2S, V31.2D, #22
    USRA  V31.16B, V16.16B, #2
    UQSHL  V16.4S, V11.4S, V31.4S
    UXTL2 V27.8H, V6.16B
    UQADD  V26.16B, V27.16B, V27.16B
    URSRA  V31.8H, V16.8H, #5
    UQSHL  V4.8H, V26.8H, #0x6
    UMLAL V17.2D, V4.2S, V4.S[0x2]
    USHLL V1.2D, V31.2S, #0x1c
    UQSHRN V28.2S, V1.2D, #30
    UMLAL2 V18.4S, V20.8H, V2.H[0x1]
    UQSHL  V16.8B, V28.8B, #0x0
    UQRSHRN V13.4H, V17.4S, #8
    USUBL2  V17.2D, V13.4S, V13.4S
    UMLAL V1.2D, V18.2S, V18.S[0x0]
    USHLL V28.8H, V16.8B, #0x5
    USRA  V16.16B, V28.16B, #1
    UMULL2  V28.8H, V16.16B, V6.16B
    UADDW2  V16.8H, V17.8H, V17.16B
    UMLAL V4.2D, V16.2S, V28.S[0x0]
    UADALP  V17.1D, V4.2S
    UMLAL  V31.8H, V17.8B, V1.8B
    UQRSHRN V13.8B, V31.8H, #6
    URSQRTE  V1.4S, V12.4S
    UMLSL V27.2D, V11.2S, V26.S[0x1]
    UQSHL  V4.16B, V6.16B, #0x2
    UMLAL2  V28.4S, V14.8H, V30.8H
    UQSHRN2 V2.8H, V15.4S, #16
    URSHR  V26.8H, V6.8H, #5
    UQRSHRN2 V26.8H, V31.4S, #7
    UADDL2  V17.8H, V27.16B, V14.16B
    UMOV W28, V12.H[0x5]
    USHLL V11.2D, V28.2S, #0x10
    USUBW  V18.8H, V21.8H, V10.8B
    URSRA  V12.4S, V24.4S, #11
    UXTL2 V16.8H, V18.16B
    UMLAL2 V21.2D, V2.4S, V11.S[0x3]
    UMLSL V24.2D, V4.2S, V12.S[0x2]
    UQSHRN V18.2S, V1.2D, #11
    USQADD  V30.8B, V19.8B
    UMLAL2 V12.2D, V30.4S, V13.S[0x3]
    URSHL  V31.16B, V12.16B, V2.16B
    URSHR  V13.4H, V31.4H, #15
    UMLAL V2.4S, V13.4H, V13.H[0x0]
    USUBW  V27.8H, V24.8H, V24.8B
    USHLL2 V13.2D, V17.4S, #0x13
    USHR  V3.4S, V13.4S, #4
    UMLSL2 V24.4S, V18.8H, V3.H[0x3]
    UQSHL V18.2D, V2.2D, #0x3e
    USHL  V19.2S, V18.2S, V21.2S
    UADDW2  V3.8H, V19.8H, V16.16B
    USHR  V13.2S, V3.2S, #14
    USHLL2 V18.8H, V27.16B, #0x5
    UQRSHL  V11.8H, V24.8H, V24.8H
    USUBL  V27.2D, V11.2S, V18.2S
    UQSUB  V14.8H, V13.8H, V27.8H
    UADDL2  V30.8H, V14.16B, V14.16B
    UADDLV  S13, V30.4H
    UABDL  V2.8H, V13.8B, V13.8B
    UMULL V17.4S, V2.4H, V2.H[0x4]
    UQRSHRN V13.2S, V17.2D, #26
    UQRSHRN2 V14.16B, V13.8H, #7
    UMULL V21.4S, V23.4H, V12.H[0x6]
    UABA  V12.16B, V8.16B, V14.16B
    UMOV W7, V17.H[0x7]
    UMLSL V18.2D, V13.2S, V20.S[0x3]
    UQSHRN2 V20.16B, V21.8H, #7
    USRA  V2.2S, V0.2S, #17
    USHR  V0.4S, V15.4S, #4
    UMULL V8.2D, V2.2S, V8.S[0x0]
    UXTL V21.2D, V19.2S
    UMOV W8, V6.S[0x0]
    UABDL  V2.8H, V11.8B, V12.8B
    UQSHRN V14.2S, V27.2D, #31
    UADDL2  V30.2D, V7.4S, V4.4S
    URSRA  V7.16B, V10.16B, #1
    USHLL V10.4S, V14.4H, #0xf
    UQRSHRN V14.4H, V18.4S, #9
    UADDL  V12.8H, V14.8B, V0.8B
    USHLL V13.8H, V21.8B, #0x2
    UQSHRN2 V23.8H, V2.4S, #8
    UMOV W5, V20.S[0x0]
    UQADD  V21.16B, V10.16B, V8.16B
    UHADD  V18.4S, V28.4S, V21.4S
    UHSUB  V10.8B, V18.8B, V7.8B
    UQRSHL  V11.2S, V30.2S, V23.2S
    UQXTN2  V7.4S, V10.2D
    UQSHRN2 V4.4S, V12.2D, #18
    UQRSHRN2 V0.4S, V7.2D, #32
    UQSHRN V2.8B, V0.8H, #3
    UMULL V7.4S, V11.4H, V2.H[0x6]
    UMULL V20.2D, V4.2S, V4.S[0x0]
    UQSHL  V4.8B, V7.8B, #0x6
    UQSHL  V19.2S, V13.2S, V20.2S
    UADDLV  D12, V4.4S
    URSRA  V2.4H, V12.4H, #9
    UABAL  V4.4S, V19.4H, V2.4H
    UABDL2  V28.2D, V25.4S, V21.4S
    USHR  V7.4H, V22.4H, #9
    UXTL V27.8H, V5.8B
    URSRA V8.2D, V9.2D, #52
    UMLSL V0.2D, V19.2S, V29.S[0x2]
    UQRSHL  V19.8B, V0.8B, V15.8B
    URSRA  V23.8B, V12.8B, #4
    UMLAL2 V9.4S, V12.8H, V8.H[0x3]
    UQSHL  V22.4S, V23.4S, #0x1f
    UQRSHL  V23.4S, V16.4S, V18.4S
    UMOV X13, V24.D[0x1]
    UMULL V8.2D, V21.2S, V17.S[0x3]
    USRA V5.2D, V8.2D, #30
    UABA  V30.4S, V7.4S, V27.4S
    UMLAL  V21.8H, V4.8B, V12.8B
    UQSHL V25.2D, V19.2D, #0x3e
    USHR  V27.8B, V22.8B, #5
    UQSHL  V16.16B, V21.16B, #0x7
    UQSHRN2 V15.16B, V5.8H, #6
    UMLAL  V0.4S, V27.4H, V9.4H
    UMLSL2 V18.4S, V23.8H, V0.H[0x0]
    UQSHRN V29.4H, V18.4S, #3
    UMLSL V17.4S, V15.4H, V15.H[0x2]
    UADDL  V7.2D, V16.2S, V29.2S
    UQRSHRN V16.8B, V28.8H, #5
    UADALP  V2.4S, V17.8H
    UADDLP  V21.2D, V25.4S
    UQSUB  V4.4S, V30.4S, V21.4S
    URSHR V22.2D, V4.2D, #32
    UMULL V4.4S, V22.4H, V4.H[0x6]
    UMULL V24.4S, V4.4H, V7.H[0x2]
    UMULL V8.2D, V24.2S, V27.S[0x1]
    UMOV W13, V2.H[0x6]
    UMLAL2  V17.8H, V8.16B, V27.16B
    UHSUB  V19.2S, V16.2S, V16.2S
    URSHR V25.2D, V29.2D, #3
    URSRA  V30.16B, V17.16B, #1
    UMLSL2 V22.2D, V19.4S, V30.S[0x0]
    UXTL2 V12.2D, V25.4S
    USHLL V7.8H, V12.8B, #0x6
    URSHR V21.2D, V22.2D, #38
    USHLL V27.8H, V7.8B, #0x1
    UADDW2  V25.8H, V27.8H, V21.16B
    URSHR  V29.8H, V0.8H, #16
    UADDL2  V19.4S, V7.8H, V18.8H
    UMOV W25, V16.H[0x6]
    URSHR  V17.16B, V25.16B, #5
    UABA  V4.8B, V13.8B, V5.8B
    UXTL V0.2D, V2.2S
    UQSHL  V7.8B, V23.8B, #0x3
    UQRSHRN2 V25.8H, V9.4S, #3
    UQXTN2  V27.4S, V2.2D
    UADDLV  S2, V22.4H
    UABA  V24.4H, V29.4H, V2.4H
    SUBS  X24, X24, #0x1
    B.NE  TSRTAdvsimdVectorUnsignedOperation_label_6
    MOVZ  X4, #0x9053, LSL #0
    MOVK  X4, #0xeb86, LSL #16
    MOVK  X4, #0xf792, LSL #32
    MOVK  X4, #0x7262, LSL #48
    SUB  X12, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x2b90, LSL #0
    MOVK  X4, #0xa448, LSL #16
    MOVK  X4, #0xa8f7, LSL #32
    MOVK  X4, #0xe84f, LSL #48
    SUB  X12, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X12, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x89ec, LSL #0
    MOVK  X4, #0xb882, LSL #16
    MOVK  X4, #0x791c, LSL #32
    MOVK  X4, #0x37cb, LSL #48
    SUB  X12, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x241f, LSL #0
    MOVK  X4, #0x5898, LSL #16
    MOVK  X4, #0xcc45, LSL #32
    MOVK  X4, #0x7d9f, LSL #48
    SUB  X12, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xdfe1, LSL #0
    MOVK  X4, #0x424e, LSL #16
    MOVK  X4, #0x78d9, LSL #32
    MOVK  X4, #0x6d92, LSL #48
    SUB  X12, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xda5a, LSL #0
    SUB  X12, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x1a08, LSL #0
    MOVK  X4, #0x7072, LSL #16
    MOVK  X4, #0x6e14, LSL #32
    MOVK  X4, #0xcad, LSL #48
    SUB  X12, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x677e, LSL #0
    MOVK  X4, #0xa161, LSL #16
    MOVK  X4, #0x5edc, LSL #32
    MOVK  X4, #0xcaf7, LSL #48
    SUB  X12, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x2871, LSL #0
    MOVK  X4, #0x15b7, LSL #16
    MOVK  X4, #0x10e2, LSL #32
    MOVK  X4, #0x5f9, LSL #48
    SUB  X12, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xb1e2, LSL #0
    MOVK  X4, #0x2ff9, LSL #16
    MOVK  X4, #0xde2f, LSL #32
    MOVK  X4, #0xac70, LSL #48
    SUB  X12, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x8ab0, LSL #0
    MOVK  X4, #0xf8a3, LSL #16
    MOVK  X4, #0x7c4f, LSL #32
    MOVK  X4, #0x8a76, LSL #48
    SUB  X12, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x6d9d, LSL #0
    MOVK  X4, #0x3865, LSL #16
    MOVK  X4, #0xfcda, LSL #32
    MOVK  X4, #0xc284, LSL #48
    SUB  X12, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xd4dd, LSL #0
    MOVK  X4, #0x1143, LSL #16
    MOVK  X4, #0xe7a6, LSL #32
    MOVK  X4, #0x443b, LSL #48
    SUB  X12, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x518e, LSL #0
    MOVK  X4, #0xf85d, LSL #16
    MOVK  X4, #0x57dd, LSL #32
    MOVK  X4, #0xea81, LSL #48
    SUB  X12, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x7d3a, LSL #0
    MOVK  X4, #0xd1d5, LSL #16
    MOVK  X4, #0x2c70, LSL #32
    MOVK  X4, #0x597a, LSL #48
    SUB  X12, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x800, LSL #16
    MRS  X12, FPSR
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xd8f6, LSL #0
    MOVK  X4, #0x1, LSL #16
    FMOV  X12, V0.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xb056, LSL #0
    MOVK  X4, #0x1, LSL #16
    FMOV  X12, D0
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X12, V1.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X12, D1
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, V2.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, D2
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x1a, LSL #0
    MOVK  X4, #0xff, LSL #32
    FMOV  X12, V3.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x9a, LSL #0
    MOVK  X4, #0xff, LSL #32
    FMOV  X12, D3
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, V4.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, D4
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, V5.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, D5
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, V6.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, D6
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, V7.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xff, LSL #0
    MOVK  X4, #0xff, LSL #16
    MOVK  X4, #0xff, LSL #32
    MOVK  X4, #0xff, LSL #48
    FMOV  X12, D7
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, V8.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, D8
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x6d9d, LSL #0
    MOVK  X4, #0x3865, LSL #16
    MOVK  X4, #0xfcda, LSL #32
    MOVK  X4, #0xc284, LSL #48
    FMOV  X12, V9.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x241f, LSL #0
    MOVK  X4, #0x5898, LSL #16
    MOVK  X4, #0xcc45, LSL #32
    MOVK  X4, #0x7d9f, LSL #48
    FMOV  X12, D9
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, V10.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x4dcd, LSL #0
    MOVK  X4, #0xe666, LSL #16
    MOVK  X4, #0x4dcd, LSL #32
    MOVK  X4, #0xe666, LSL #48
    FMOV  X12, D10
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, V11.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, D11
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, V12.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, D12
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, V13.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, D13
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, V14.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    FMOV  X12, D14
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, V15.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x8ab0, LSL #0
    MOVK  X4, #0xf8a3, LSL #16
    MOVK  X4, #0x7c4f, LSL #32
    MOVK  X4, #0x8a76, LSL #48
    FMOV  X12, D15
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, V16.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #32
    FMOV  X12, D16
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, V17.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, D17
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x8698, LSL #0
    MOVK  X4, #0xfffe, LSL #16
    MOVK  X4, #0x8a84, LSL #32
    MOVK  X4, #0xfff1, LSL #48
    FMOV  X12, V18.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x498, LSL #0
    MOVK  X4, #0x3ff7, LSL #16
    MOVK  X4, #0x4a84, LSL #32
    MOVK  X4, #0x3ff1, LSL #48
    FMOV  X12, D18
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x8a84, LSL #0
    MOVK  X4, #0xfff1, LSL #32
    FMOV  X12, V19.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x8698, LSL #0
    MOVK  X4, #0xfffe, LSL #32
    FMOV  X12, D19
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, V20.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, D20
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, V21.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, D21
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, V22.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, D22
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x9a, LSL #0
    MOVK  X4, #0xff, LSL #16
    MOVK  X4, #0x1a, LSL #32
    MOVK  X4, #0xff, LSL #48
    FMOV  X12, V23.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x33, LSL #0
    MOVK  X4, #0xff, LSL #16
    MOVK  X4, #0xb4, LSL #32
    MOVK  X4, #0xff, LSL #48
    FMOV  X12, D23
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, V24.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x1, LSL #32
    FMOV  X12, D24
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X12, V25.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, D25
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x10, LSL #16
    FMOV  X12, V26.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, D26
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X12, V27.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, D27
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xfffe, LSL #0
    MOVK  X4, #0xffff, LSL #16
    FMOV  X12, V28.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xfffe, LSL #0
    MOVK  X4, #0xffff, LSL #16
    FMOV  X12, D28
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x1, LSL #0
    MOVK  X4, #0x1, LSL #32
    FMOV  X12, V29.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x1, LSL #32
    FMOV  X12, D29
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x3050, LSL #0
    MOVK  X4, #0x6252, LSL #16
    MOVK  X4, #0xf4b, LSL #32
    MOVK  X4, #0x5e62, LSL #48
    FMOV  X12, V30.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x7a58, LSL #0
    MOVK  X4, #0x5e54, LSL #16
    MOVK  X4, #0x295a, LSL #32
    MOVK  X4, #0x4422, LSL #48
    FMOV  X12, D30
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, V31.D[1]
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X12, D31
    SUB  X15, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorUnsignedOperation_TestFail
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
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X2
    FMOV  V0.D[1], X27
    FMOV  D1, X24
    FMOV  V1.D[1], X29
    FMOV  D2, X16
    FMOV  V2.D[1], X14
    FMOV  D3, X28
    FMOV  V3.D[1], X15
    FMOV  D4, X21
    FMOV  V4.D[1], X23
    FMOV  D5, X22
    FMOV  V5.D[1], X25
    FMOV  D6, X27
    FMOV  V6.D[1], X25
    FMOV  D7, X24
    FMOV  V7.D[1], X29
    FMOV  D8, X23
    FMOV  V8.D[1], X15
    FMOV  D9, X17
    FMOV  V9.D[1], X3
    FMOV  D10, X8
    FMOV  V10.D[1], X21
    FMOV  D11, X7
    FMOV  V11.D[1], X21
    FMOV  D12, X7
    FMOV  V12.D[1], X13
    FMOV  D13, X3
    FMOV  V13.D[1], X3
    FMOV  D14, X17
    FMOV  V14.D[1], X24
    FMOV  D15, X14
    FMOV  V15.D[1], X8
    FMOV  D16, X5
    FMOV  V16.D[1], X17
    FMOV  D17, X5
    FMOV  V17.D[1], X27
    FMOV  D18, X15
    FMOV  V18.D[1], X28
    FMOV  D19, X5
    FMOV  V19.D[1], X22
    FMOV  D20, X21
    FMOV  V20.D[1], X7
    FMOV  D21, X28
    FMOV  V21.D[1], X10
    FMOV  D22, X9
    FMOV  V22.D[1], X5
    FMOV  D23, X28
    FMOV  V23.D[1], X7
    FMOV  D24, X8
    FMOV  V24.D[1], X9
    FMOV  D25, X25
    FMOV  V25.D[1], X13
    FMOV  D26, X20
    FMOV  V26.D[1], X9
    FMOV  D27, X25
    FMOV  V27.D[1], X14
    FMOV  D28, X29
    FMOV  V28.D[1], X16
    FMOV  D29, X25
    FMOV  V29.D[1], X17
    FMOV  D30, X9
    FMOV  V30.D[1], X21
    FMOV  D31, X22
    FMOV  V31.D[1], X12
    MOVZ  X28, #0xf, LSL #0
TSRTAdvsimdVectorUnsignedOperation_label_7:
    UQSHRN V15.2S, V21.2D, #6
    URSRA  V6.4H, V27.4H, #10
    USRA  V14.4H, V31.4H, #15
    UQSHL  V5.4H, V30.4H, #0xa
    URSQRTE  V6.2S, V29.2S
    UABAL2  V31.8H, V28.16B, V28.16B
    URSHR V1.2D, V6.2D, #53
    UQSHRN V6.8B, V26.8H, #6
    URSHR V0.2D, V1.2D, #29
    URSQRTE  V4.4S, V14.4S
    USRA V4.2D, V0.2D, #35
    UMOV W12, V15.S[0x1]
    UQSHL  V5.4H, V31.4H, V6.4H
    UQRSHRN V18.2S, V4.2D, #28
    URSRA  V8.4S, V5.4S, #13
    UMLAL  V30.8H, V18.8B, V18.8B
    USHLL V22.8H, V25.8B, #0x7
    URSRA  V18.8B, V22.8B, #3
    UMLAL  V14.2D, V31.2S, V8.2S
    UMULL V1.2D, V30.2S, V14.S[0x0]
    USHR  V22.16B, V1.16B, #7
    UXTL V26.2D, V18.2S
    UADDL  V29.2D, V26.2S, V26.2S
    UMLSL2  V4.4S, V29.8H, V22.8H
    USHR  V5.2S, V1.2S, #25
    UABDL  V30.8H, V12.8B, V3.8B
    UADALP  V6.2S, V4.4H
    URHADD  V4.8H, V0.8H, V18.8H
    UADDLP  V15.1D, V26.2S
    UADDW2  V26.8H, V18.8H, V12.16B
    URSQRTE  V1.2S, V27.2S
    UQSHL  V0.2S, V25.2S, #0x2
    UADDLV  S3, V4.8H
    USUBL2  V29.8H, V20.16B, V26.16B
    URHADD  V22.8B, V24.8B, V27.8B
    UQSHRN V14.4H, V29.4S, #6
    UABAL2  V26.4S, V0.8H, V16.8H
    UQRSHRN2 V25.4S, V9.2D, #8
    UQSHL V24.2D, V14.2D, #0x38
    USHR  V16.8B, V30.8B, #1
    UMOV W7, V3.H[0x3]
    UMLSL V3.2D, V1.2S, V15.S[0x1]
    UXTL2 V31.2D, V6.4S
    UMULL2 V6.2D, V5.4S, V5.S[0x1]
    USHR  V8.8H, V16.8H, #9
    USHLL V29.2D, V25.2S, #0x18
    UABAL2  V20.8H, V26.16B, V6.16B
    UADDW2  V16.8H, V24.8H, V20.16B
    UMULL  V1.8H, V31.8B, V29.8B
    USUBW2  V27.4S, V8.4S, V3.8H
    UXTL V26.8H, V22.8B
    UMLSL V15.4S, V16.4H, V1.H[0x1]
    UQSHL  V29.16B, V27.16B, #0x7
    UQXTN2  V30.8H, V15.4S
    USRA  V3.8B, V30.8B, #1
    UMULL  V30.2D, V29.2S, V3.2S
    URSQRTE  V5.2S, V26.2S
    UXTL V25.8H, V5.8B
    UXTL2 V6.2D, V25.4S
    UQRSHL  V20.4S, V6.4S, V30.4S
    UQRSHRN2 V27.8H, V29.4S, #13
    UMLAL V24.2D, V11.2S, V13.S[0x1]
    UMLSL V1.2D, V9.2S, V29.S[0x2]
    UQRSHRN V14.8B, V11.8H, #1
    UXTL V16.2D, V0.2S
    UADDLV  S0, V25.4H
    URHADD  V29.4H, V29.4H, V28.4H
    URHADD  V11.2S, V30.2S, V19.2S
    UMLSL  V9.2D, V14.2S, V20.2S
    URECPE  V15.2S, V0.2S
    UQSHL  V14.4H, V1.4H, #0xa
    UQRSHRN V13.2S, V15.2D, #32
    USRA V19.2D, V13.2D, #26
    UADDLP  V26.4H, V11.8B
    URSQRTE  V25.2S, V24.2S
    UQSHL  V1.2S, V19.2S, #0x14
    UQRSHRN2 V30.8H, V9.4S, #11
    URSHR V6.2D, V29.2D, #8
    UMLAL V8.2D, V16.2S, V27.S[0x1]
    USHR  V28.8H, V14.8H, #7
    USHLL2 V11.8H, V25.16B, #0x7
    USRA V5.2D, V11.2D, #62
    URECPE  V27.2S, V8.2S
    USUBL  V13.8H, V30.8B, V29.8B
    UMOV W12, V26.B[0xe]
    UMLSL V3.4S, V5.4H, V13.H[0x2]
    UXTL2 V11.2D, V3.4S
    URSHR V15.2D, V11.2D, #40
    UMLSL2 V15.4S, V15.8H, V1.H[0x6]
    UMULL V24.4S, V6.4H, V6.H[0x2]
    UQSHRN V20.2S, V27.2D, #29
    UQRSHRN V27.8B, V15.8H, #6
    USUBW  V9.8H, V2.8H, V20.8B
    URSHL  V25.16B, V24.16B, V1.16B
    UMULL V24.2D, V23.2S, V28.S[0x0]
    UMOV W7, V24.S[0x3]
    USRA V13.2D, V27.2D, #34
    UQSHRN2 V29.4S, V9.2D, #12
    UMULL2  V11.4S, V12.8H, V13.8H
    UQRSHRN2 V5.16B, V11.8H, #3
    UABAL2  V8.8H, V29.16B, V25.16B
    USHLL V30.8H, V8.8B, #0x1
    UADALP  V1.2S, V5.4H
    UQRSHRN V11.4H, V1.4S, #16
    UMULL  V8.4S, V11.4H, V11.4H
    URSRA  V5.8H, V8.8H, #2
    USHL  V27.4H, V5.4H, V30.4H
    UMLSL2  V8.2D, V10.4S, V15.4S
    UQXTN2  V30.4S, V2.2D
    UXTL2 V1.4S, V8.8H
    UQADD  V29.4S, V13.4S, V20.4S
    UXTL V8.8H, V29.8B
    UXTL2 V6.8H, V4.16B
    UQSHRN V15.2S, V5.2D, #4
    UMLSL2 V10.4S, V10.8H, V14.H[0x0]
    URSHR V11.2D, V2.2D, #52
    UMLAL V13.4S, V18.4H, V5.H[0x4]
    UXTL V18.8H, V13.8B
    UXTL V20.8H, V18.8B
    UADDLP  V25.8H, V20.16B
    UQRSHRN V13.2S, V25.2D, #6
    USUBL  V25.8H, V27.8B, V16.8B
    USRA  V5.8H, V6.8H, #14
    UQSHRN V18.8B, V24.8H, #1
    UMLAL2  V4.2D, V15.4S, V13.4S
    UQSHRN V20.2S, V5.2D, #20
    USHLL V24.4S, V14.4H, #0xa
    UMLSL2 V15.2D, V30.4S, V8.S[0x1]
    UADDLV  S8, V20.4H
    UMULL  V2.4S, V11.4H, V25.4H
    UMLAL V20.4S, V18.4H, V8.H[0x1]
    UMLAL V27.4S, V4.4H, V15.H[0x2]
    UXTL V30.4S, V27.4H
    URSHR  V25.4S, V24.4S, #14
    USQADD  V11.4H, V1.4H
    UABDL2  V14.8H, V2.16B, V2.16B
    UQRSHRN2 V4.4S, V10.2D, #16
    UMOV W14, V26.S[0x0]
    UADDLV  D2, V30.4S
    UQSHL  V5.8B, V25.8B, #0x0
    UXTL2 V13.4S, V5.8H
    USRA  V8.8B, V2.8B, #3
    UQSHL  V27.8B, V20.8B, #0x4
    UMOV X29, V27.D[0x0]
    URSHR V1.2D, V8.2D, #3
    USHLL2 V18.2D, V14.4S, #0x4
    UXTL2 V14.4S, V18.8H
    URSRA  V16.4S, V26.4S, #16
    URSHR  V25.4S, V13.4S, #31
    USRA  V6.16B, V25.16B, #2
    UADDL  V18.4S, V16.4H, V6.4H
    UQSHRN2 V2.8H, V1.4S, #8
    UMULL2 V24.4S, V14.8H, V14.H[0x4]
    UMULL  V14.4S, V11.4H, V18.4H
    UABAL2  V25.8H, V24.16B, V4.16B
    UXTL2 V13.4S, V2.8H
    UQSHL  V5.4H, V14.4H, #0x6
    UQRSHRN V10.8B, V25.8H, #5
    UMLAL  V8.4S, V13.4H, V13.4H
    UMULL V27.4S, V7.4H, V10.H[0x4]
    URSHR  V26.16B, V8.16B, #6
    USHR V10.2D, V5.2D, #48
    UABDL  V18.2D, V27.2S, V27.2S
    UABAL  V4.2D, V14.2S, V18.2S
    UMLSL V13.2D, V1.2S, V30.S[0x3]
    USHLL V1.8H, V4.8B, #0x3
    URSHR  V11.4S, V1.4S, #17
    UADDL  V1.4S, V10.4H, V13.4H
    UADDLV  S7, V1.4H
    UADALP  V4.8H, V26.16B
    USRA  V25.8H, V11.8H, #9
    UMLSL2 V24.2D, V25.4S, V4.S[0x2]
    UQRSHRN V2.8B, V24.8H, #6
    URECPE  V25.2S, V7.2S
    UMLAL2 V30.4S, V2.8H, V5.H[0x3]
    UMLSL  V2.8H, V25.8B, V25.8B
    URSRA  V18.8B, V10.8B, #7
    UQSHRN V8.4H, V19.4S, #1
    USHLL V26.2D, V8.2S, #0x1c
    UABD  V8.16B, V30.16B, V26.16B
    UABDL  V4.2D, V2.2S, V8.2S
    UABD  V13.4S, V4.4S, V18.4S
    URSRA  V8.8H, V4.8H, #4
    USHL  V14.16B, V27.16B, V30.16B
    USQADD  V1.16B, V13.16B
    UMOV W24, V27.B[0xc]
    UQRSHRN2 V26.4S, V26.2D, #5
    UQSHL V19.2D, V13.2D, #0x31
    UQXTN2  V7.16B, V25.8H
    UMLSL  V11.2D, V6.2S, V30.2S
    UXTL2 V6.2D, V3.4S
    USRA  V4.8B, V28.8B, #7
    UABAL2  V25.8H, V26.16B, V8.16B
    UQRSHRN2 V27.8H, V1.4S, #10
    URSRA V5.2D, V4.2D, #21
    USHLL2 V8.4S, V25.8H, #0x2
    UQSHRN2 V1.8H, V14.4S, #6
    UMLSL V14.2D, V7.2S, V19.S[0x0]
    USUBW2  V25.4S, V11.4S, V8.8H
    USHLL2 V26.2D, V6.4S, #0x2
    SUBS  X28, X28, #0x1
    B.NE  TSRTAdvsimdVectorUnsignedOperation_label_7
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x80, LSL #16
    SUB  X4, X25, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X4, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x800, LSL #16
    MRS  X4, FPSR
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, V0.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x3fc, LSL #0
    FMOV  X4, D0
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, V1.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x86db, LSL #0
    MOVK  X25, #0x1, LSL #16
    MOVK  X25, #0xef0f, LSL #32
    FMOV  X4, D1
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x1ff, LSL #0
    MOVK  X25, #0x1ff, LSL #16
    MOVK  X25, #0x1ff, LSL #32
    MOVK  X25, #0x1ff, LSL #48
    FMOV  X4, V2.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x1ff, LSL #0
    MOVK  X25, #0x1ff, LSL #16
    MOVK  X25, #0x1ff, LSL #32
    MOVK  X25, #0x1ff, LSL #48
    FMOV  X4, D2
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, V3.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x8345, LSL #0
    MOVK  X25, #0x41, LSL #16
    MOVK  X25, #0x22, LSL #32
    FMOV  X4, D3
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, V4.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x539, LSL #0
    MOVK  X25, #0xee01, LSL #16
    FMOV  X4, D4
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, V5.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x76f, LSL #0
    MOVK  X25, #0x1, LSL #16
    FMOV  X4, D5
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, V6.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, D6
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    FMOV  X4, V7.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x70b1, LSL #0
    MOVK  X25, #0x1, LSL #16
    FMOV  X4, D7
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x3c0, LSL #32
    FMOV  X4, V8.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x200, LSL #0
    MOVK  X25, #0x1fc, LSL #32
    FMOV  X4, D8
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x1ff, LSL #0
    MOVK  X25, #0x1ff, LSL #16
    MOVK  X25, #0x1ff, LSL #32
    MOVK  X25, #0x1ff, LSL #48
    FMOV  X4, V9.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x100, LSL #0
    MOVK  X25, #0x100, LSL #16
    MOVK  X25, #0x100, LSL #32
    MOVK  X25, #0x100, LSL #48
    FMOV  X4, D9
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, V10.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, D10
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x200, LSL #0
    MOVK  X25, #0x200, LSL #32
    FMOV  X4, V11.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xfc, LSL #0
    MOVK  X25, #0x200, LSL #32
    FMOV  X4, D11
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, V12.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, D12
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xfefe, LSL #0
    MOVK  X25, #0x1fe, LSL #16
    FMOV  X4, V13.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x539, LSL #0
    MOVK  X25, #0xee01, LSL #16
    FMOV  X4, D13
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, V14.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x70b1, LSL #0
    MOVK  X25, #0x1, LSL #16
    MOVK  X25, #0x8f4f, LSL #32
    MOVK  X25, #0xfffe, LSL #48
    FMOV  X4, D14
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xff, LSL #0
    MOVK  X25, #0xff, LSL #16
    MOVK  X25, #0xff01, LSL #32
    MOVK  X25, #0xff00, LSL #48
    FMOV  X4, V15.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xfe, LSL #0
    MOVK  X25, #0xff, LSL #16
    MOVK  X25, #0xff02, LSL #32
    MOVK  X25, #0xff00, LSL #48
    FMOV  X4, D15
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x800, LSL #0
    FMOV  X4, V16.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x1e0, LSL #0
    MOVK  X25, #0x80, LSL #32
    FMOV  X4, D16
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, V17.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, D17
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, V18.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, D18
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X4, V19.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X4, D19
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, V20.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    FMOV  X4, D20
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, V21.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, D21
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, V22.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, D22
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, V23.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, D23
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, V24.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, D24
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xfe40, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0x200, LSL #32
    FMOV  X4, V25.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xfc, LSL #0
    MOVK  X25, #0x200, LSL #32
    FMOV  X4, D25
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, V26.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, D26
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x62, LSL #0
    MOVK  X25, #0x3c, LSL #16
    MOVK  X25, #0x403f, LSL #32
    MOVK  X25, #0x40, LSL #48
    FMOV  X4, V27.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, D27
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, V28.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, D28
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, V29.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    FMOV  X4, D29
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7f80, LSL #32
    FMOV  X4, V30.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x738, LSL #0
    MOVK  X25, #0x300, LSL #32
    FMOV  X4, D30
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, V31.D[1]
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X4, D31
    SUB  X3, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
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
    FMOV  V0.D[1], X27
    FMOV  D1, X29
    FMOV  V1.D[1], X28
    FMOV  D2, X23
    FMOV  V2.D[1], X22
    FMOV  D3, X7
    FMOV  V3.D[1], X28
    FMOV  D4, X17
    FMOV  V4.D[1], X5
    FMOV  D5, X6
    FMOV  V5.D[1], X4
    FMOV  D6, X17
    FMOV  V6.D[1], X24
    FMOV  D7, X13
    FMOV  V7.D[1], X23
    FMOV  D8, X6
    FMOV  V8.D[1], X24
    FMOV  D9, X22
    FMOV  V9.D[1], X28
    FMOV  D10, X22
    FMOV  V10.D[1], X4
    FMOV  D11, X6
    FMOV  V11.D[1], X13
    FMOV  D12, X10
    FMOV  V12.D[1], X27
    FMOV  D13, X25
    FMOV  V13.D[1], X17
    FMOV  D14, X2
    FMOV  V14.D[1], X8
    FMOV  D15, X6
    FMOV  V15.D[1], X29
    FMOV  D16, X20
    FMOV  V16.D[1], X9
    FMOV  D17, X22
    FMOV  V17.D[1], X3
    FMOV  D18, X3
    FMOV  V18.D[1], X16
    FMOV  D19, X23
    FMOV  V19.D[1], X16
    FMOV  D20, X29
    FMOV  V20.D[1], X5
    FMOV  D21, X22
    FMOV  V21.D[1], X21
    FMOV  D22, X6
    FMOV  V22.D[1], X8
    FMOV  D23, X2
    FMOV  V23.D[1], X7
    FMOV  D24, X5
    FMOV  V24.D[1], X3
    FMOV  D25, X17
    FMOV  V25.D[1], X27
    FMOV  D26, X21
    FMOV  V26.D[1], X27
    FMOV  D27, X21
    FMOV  V27.D[1], X3
    FMOV  D28, X27
    FMOV  V28.D[1], X24
    FMOV  D29, X9
    FMOV  V29.D[1], X28
    FMOV  D30, X13
    FMOV  V30.D[1], X2
    FMOV  D31, X5
    FMOV  V31.D[1], X23
    MOVZ  X17, #0xf, LSL #0
TSRTAdvsimdVectorUnsignedOperation_label_8:
    UHSUB  V9.16B, V30.16B, V21.16B
    UMULL2 V1.2D, V31.4S, V25.S[0x1]
    UMLSL2  V21.2D, V20.4S, V22.4S
    UMLSL2  V11.8H, V24.16B, V24.16B
    UMLSL2  V13.8H, V21.16B, V28.16B
    URSRA V6.2D, V1.2D, #26
    UADDLP  V22.4S, V27.8H
    UQRSHRN V12.8B, V26.8H, #6
    UQRSHRN2 V18.4S, V29.2D, #14
    URSRA  V3.4S, V6.4S, #16
    UHADD  V31.2S, V13.2S, V18.2S
    UADDLV  S21, V9.8H
    UMLAL2 V23.2D, V11.4S, V11.S[0x2]
    USUBL  V16.8H, V22.8B, V21.8B
    UQSHRN V30.8B, V12.8H, #1
    UADDLP  V27.2S, V3.4H
    UABDL  V22.8H, V27.8B, V27.8B
    UHSUB  V29.4H, V23.4H, V22.4H
    UABAL  V27.8H, V31.8B, V29.8B
    UQSHL  V11.16B, V30.16B, #0x7
    UMOV W6, V31.H[0x5]
    UQRSHRN2 V31.8H, V16.4S, #8
    UMLSL V25.2D, V11.2S, V27.S[0x1]
    UXTL V13.2D, V31.2S
    UMLSL V11.4S, V25.4H, V14.H[0x6]
    USRA  V18.2S, V11.2S, #27
    UHADD  V31.8B, V13.8B, V18.8B
    URSHR V14.2D, V11.2D, #30
    UQXTN2  V29.8H, V29.4S
    UQRSHRN V22.4H, V2.4S, #3
    UADDLP  V2.4S, V2.8H
    USUBL2  V11.4S, V22.8H, V3.8H
    UXTL V9.8H, V11.8B
    UXTL2 V25.8H, V31.16B
    UMOV W14, V3.S[0x0]
    USUBL2  V23.2D, V20.4S, V9.4S
    UQSHRN V13.8B, V20.8H, #8
    UABA  V20.4H, V18.4H, V9.4H
    UHADD  V22.4S, V19.4S, V14.4S
    USRA V19.2D, V12.2D, #7
    UABAL2  V16.4S, V16.8H, V4.8H
    UQADD  V27.2S, V2.2S, V23.2S
    UADDL2  V9.8H, V29.16B, V16.16B
    USHLL2 V11.8H, V12.16B, #0x1
    USHLL V31.2D, V19.2S, #0xa
    URSRA  V18.2S, V25.2S, #28
    UQSHL  V19.16B, V20.16B, #0x1
    USHLL2 V4.2D, V13.4S, #0x5
    URSHR V13.2D, V11.2D, #54
    UMLSL V30.2D, V31.2S, V18.S[0x1]
    UADDLV  S29, V27.4H
    URSHR  V7.8B, V29.8B, #8
    UMULL2  V16.8H, V4.16B, V19.16B
    URSHR  V14.4H, V22.4H, #4
    UQSHL  V31.16B, V14.16B, V16.16B
    UQXTN  V4.2S, V13.2D
    UABDL  V14.2D, V9.2S, V4.2S
    USHR  V29.8H, V14.8H, #12
    UXTL V20.2D, V31.2S
    UMULL  V13.8H, V29.8B, V29.8B
    UQSHL  V23.8B, V13.8B, #0x1
    URSQRTE  V29.4S, V20.4S
    UMULL V11.2D, V8.2S, V30.S[0x1]
    UABDL  V30.8H, V23.8B, V6.8B
    UMLAL2 V31.2D, V11.4S, V29.S[0x1]
    UABDL  V25.8H, V30.8B, V31.8B
    UADDLV  D4, V25.4S
    UMULL2 V20.2D, V4.4S, V7.S[0x1]
    URSQRTE  V25.2S, V22.2S
    USHR  V12.8B, V10.8B, #4
    URSRA  V10.8H, V24.8H, #1
    UMLAL  V7.2D, V13.2S, V10.2S
    UMLSL2 V18.4S, V31.8H, V7.H[0x1]
    URSHR  V27.8H, V25.8H, #1
    UMLSL2 V4.2D, V2.4S, V18.S[0x1]
    UQSHL  V19.8B, V29.8B, #0x0
    UXTL2 V16.2D, V2.4S
    UADDW2  V11.2D, V15.2D, V12.4S
    UQRSHL  V10.4H, V23.4H, V12.4H
    UQRSHRN V24.2S, V28.2D, #22
    UQSHL  V13.8H, V27.8H, #0xd
    USHLL V14.2D, V14.2S, #0x2
    UQXTN  V7.8B, V20.8H
    USUBL2  V6.4S, V14.8H, V14.8H
    UMULL V14.2D, V24.2S, V4.S[0x3]
    URSRA V24.2D, V7.2D, #34
    UQSHRN2 V23.4S, V24.2D, #22
    URHADD  V2.16B, V3.16B, V13.16B
    UQSHRN V22.4H, V23.4S, #16
    USRA  V23.8H, V22.8H, #4
    UADALP  V18.4S, V14.8H
    UQSHL  V14.8B, V18.8B, #0x3
    UQSHL  V30.4S, V6.4S, V8.4S
    UADDL  V29.4S, V2.4H, V16.4H
    UQRSHRN2 V27.8H, V30.4S, #14
    UHSUB  V6.4S, V10.4S, V4.4S
    UABA  V4.8B, V11.8B, V23.8B
    UMOV W13, V4.S[0x0]
    URSQRTE  V12.4S, V6.4S
    USHLL2 V25.4S, V19.8H, #0x8
    USRA  V23.2S, V14.2S, #4
    USUBL2  V13.4S, V27.8H, V25.8H
    UQSUB  V7.8B, V13.8B, V13.8B
    UMLSL2 V20.4S, V12.8H, V12.H[0x3]
    USRA  V30.2S, V26.2S, #23
    UXTL V3.2D, V23.2S
    UXTL V28.4S, V27.4H
    URSRA  V19.8H, V20.8H, #4
    UMOV W14, V24.H[0x1]
    UMOV W13, V7.B[0xe]
    UQRSHRN2 V23.16B, V28.8H, #5
    UADDLV  S7, V7.8H
    UXTL V13.4S, V30.4H
    UQRSHL  V20.4H, V3.4H, V29.4H
    URSRA  V12.8B, V21.8B, #8
    USRA  V26.2S, V7.2S, #2
    UQRSHRN V24.8B, V19.8H, #1
    UQSHL  V25.4S, V0.4S, #0x15
    UMULL2  V29.4S, V24.8H, V25.8H
    UMOV W13, V23.S[0x0]
    UQRSHRN2 V21.4S, V12.2D, #16
    UHADD  V8.16B, V21.16B, V29.16B
    UQSHRN V0.2S, V8.2D, #7
    UMOV X22, V18.D[0x0]
    UMULL V28.2D, V0.2S, V20.S[0x1]
    URSHL  V20.16B, V26.16B, V28.16B
    URSHR  V3.16B, V20.16B, #1
    USUBL2  V24.2D, V26.4S, V13.4S
    UABDL2  V13.4S, V24.8H, V24.8H
    UQRSHRN V25.2S, V13.2D, #3
    USUBW2  V14.2D, V25.2D, V25.4S
    UABAL  V25.8H, V3.8B, V3.8B
    UADDW2  V27.2D, V25.2D, V25.4S
    USRA  V23.8H, V27.8H, #16
    UXTL V18.2D, V23.2S
    UMULL2 V0.4S, V14.8H, V14.H[0x5]
    URSRA  V14.4S, V0.4S, #16
    URSRA  V26.2S, V14.2S, #8
    UADDW  V7.4S, V26.4S, V18.4H
    UQSHL  V30.8B, V20.8B, #0x7
    UMLSL2 V28.4S, V29.8H, V2.H[0x6]
    UQRSHRN2 V3.16B, V26.8H, #6
    UQSUB  V29.16B, V18.16B, V21.16B
    UXTL2 V25.2D, V18.4S
    USHLL2 V24.8H, V18.16B, #0x2
    URSRA  V13.8B, V14.8B, #2
    UQRSHRN V23.2S, V27.2D, #4
    USUBL2  V20.2D, V25.4S, V28.4S
    URSRA V8.2D, V13.2D, #43
    UMOV W20, V7.S[0x3]
    UADDLV  D12, V8.4S
    URSHR  V14.8H, V30.8H, #11
    UHSUB  V8.8B, V3.8B, V3.8B
    UQSHRN2 V28.4S, V29.2D, #2
    UMOV W27, V28.H[0x2]
    USHR  V2.4H, V8.4H, #10
    USQADD  V27.2S, V2.2S
    USHR  V30.4S, V27.4S, #9
    UHSUB  V3.8H, V23.8H, V30.8H
    UMULL2 V30.4S, V24.8H, V1.H[0x7]
    UQSHRN V18.2S, V12.2D, #30
    UADDW2  V0.8H, V30.8H, V18.16B
    UMLAL2 V7.4S, V3.8H, V2.H[0x1]
    USRA  V23.4H, V0.4H, #15
    UABD  V12.8B, V7.8B, V14.8B
    UQXTN2  V27.16B, V23.8H
    USRA  V1.8B, V20.8B, #2
    USUBW2  V26.2D, V1.2D, V3.4S
    UXTL V8.8H, V12.8B
    UABAL2  V24.8H, V27.16B, V8.16B
    USHR  V25.2S, V11.2S, #18
    UMLAL2 V29.2D, V26.4S, V25.S[0x3]
    URSQRTE  V18.4S, V24.4S
    URSHR V2.2D, V18.2D, #45
    USHLL V8.4S, V2.4H, #0x6
    UHSUB  V3.8H, V8.8H, V8.8H
    USHR  V25.16B, V3.16B, #6
    UMOV X24, V25.D[0x1]
    UADDW  V25.4S, V25.4S, V14.4H
    UADALP  V30.4S, V3.8H
    UQSHRN V24.8B, V0.8H, #8
    UQSHRN2 V26.16B, V8.8H, #4
    UMULL2  V7.4S, V30.8H, V1.8H
    UXTL2 V2.4S, V10.8H
    UQSHRN2 V12.8H, V2.4S, #4
    UXTL2 V20.8H, V8.16B
    USRA  V10.16B, V12.16B, #2
    USHLL2 V14.8H, V14.16B, #0x4
    UHSUB  V18.2S, V31.2S, V17.2S
    UABAL2  V12.2D, V7.4S, V14.4S
    UMOV W15, V29.B[0x5]
    UADDLV  D30, V29.4S
    USHR  V2.4S, V25.4S, #16
    UHSUB  V3.4S, V18.4S, V26.4S
    UQXTN2  V18.16B, V20.8H
    UADDL  V29.8H, V31.8B, V18.8B
    UABAL2  V25.8H, V3.16B, V12.16B
    USRA  V14.2S, V16.2S, #25
    UQRSHRN V8.8B, V29.8H, #5
    UABD  V0.4H, V10.4H, V14.4H
    SUBS  X17, X17, #0x1
    B.NE  TSRTAdvsimdVectorUnsignedOperation_label_8
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xfff, LSL #16
    SUB  X3, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xa39c, LSL #0
    MOVK  X4, #0xbadb, LSL #16
    MOVK  X4, #0x64e4, LSL #32
    MOVK  X4, #0xcd24, LSL #48
    SUB  X3, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x800, LSL #16
    MRS  X3, FPSR
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, V0.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x1604, LSL #0
    MOVK  X4, #0x3c09, LSL #16
    MOVK  X4, #0x2c32, LSL #32
    MOVK  X4, #0x3c, LSL #48
    FMOV  X3, D0
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, V1.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xae70, LSL #0
    MOVK  X4, #0x9a7b, LSL #16
    MOVK  X4, #0x768d, LSL #32
    MOVK  X4, #0xf9, LSL #48
    FMOV  X3, D1
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, V2.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, D2
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xfff0, LSL #16
    FMOV  X3, V3.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x2003, LSL #0
    MOVK  X4, #0x226d, LSL #16
    MOVK  X4, #0x51be, LSL #32
    MOVK  X4, #0x53d8, LSL #48
    FMOV  X3, D3
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, V4.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xac, LSL #0
    MOVK  X4, #0x11e, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X3, D4
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X3, V5.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X3, D5
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, V6.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x7f29, LSL #0
    MOVK  X4, #0xfef0, LSL #16
    FMOV  X3, D6
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, V7.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, D7
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, V8.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xe0b, LSL #0
    MOVK  X4, #0xd08, LSL #16
    MOVK  X4, #0x201, LSL #32
    MOVK  X4, #0x808, LSL #48
    FMOV  X3, D8
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, V9.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xff, LSL #32
    MOVK  X4, #0xff, LSL #48
    FMOV  X3, D9
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, V10.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x1604, LSL #0
    MOVK  X4, #0x3c09, LSL #16
    MOVK  X4, #0x2c32, LSL #32
    MOVK  X4, #0x3c, LSL #48
    FMOV  X3, D10
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X3, V11.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X3, D11
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, V12.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x5a11, LSL #0
    MOVK  X4, #0xf324, LSL #16
    MOVK  X4, #0xb1c9, LSL #32
    MOVK  X4, #0xf3, LSL #48
    FMOV  X3, D12
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, V13.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, D13
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, V14.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, D14
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X3, V15.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X3, D15
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, V16.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, D16
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X3, V17.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X3, D17
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, V18.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xee77, LSL #0
    MOVK  X4, #0xdf55, LSL #16
    MOVK  X4, #0x1a09, LSL #32
    MOVK  X4, #0xa8aa, LSL #48
    FMOV  X3, D18
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x1000, LSL #0
    MOVK  X4, #0x1000, LSL #32
    FMOV  X3, V19.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xfff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xfff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X3, D19
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, V20.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, D20
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    FMOV  X3, V21.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xdbf8, LSL #0
    MOVK  X4, #0x1, LSL #16
    FMOV  X3, D21
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, V22.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, D22
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, V23.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, D23
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, V24.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, D24
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x20, LSL #0
    FMOV  X3, V25.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x20, LSL #0
    MOVK  X4, #0x110, LSL #32
    MOVK  X4, #0xff, LSL #48
    FMOV  X3, D25
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x20, LSL #16
    FMOV  X3, V26.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xae70, LSL #0
    MOVK  X4, #0x9a7b, LSL #16
    MOVK  X4, #0x768d, LSL #32
    MOVK  X4, #0xf9, LSL #48
    FMOV  X3, D26
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, V27.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, D27
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x8901, LSL #0
    MOVK  X4, #0x3ff, LSL #16
    FMOV  X3, V28.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, D28
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x1b, LSL #0
    MOVK  X4, #0x4e, LSL #16
    MOVK  X4, #0xfe, LSL #32
    MOVK  X4, #0xf9, LSL #48
    FMOV  X3, V29.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x164, LSL #0
    MOVK  X4, #0x1ca, LSL #16
    MOVK  X4, #0x100, LSL #32
    MOVK  X4, #0x19d, LSL #48
    FMOV  X3, D29
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X3, V30.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x2407, LSL #0
    MOVK  X4, #0xffe, LSL #16
    FMOV  X3, D30
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xd749, LSL #0
    MOVK  X4, #0xf63c, LSL #16
    MOVK  X4, #0x28b6, LSL #32
    MOVK  X4, #0x9c3, LSL #48
    FMOV  X3, V31.D[1]
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xdced, LSL #0
    MOVK  X4, #0xbeab, LSL #16
    MOVK  X4, #0x3412, LSL #32
    MOVK  X4, #0x5154, LSL #48
    FMOV  X3, D31
    SUB  X29, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x91b7, LSL #0
    MOVK  X2, #0xe642, LSL #16
    MOVK  X2, #0x894a, LSL #32
    MOVK  X2, #0xe7fa, LSL #48
    MOVZ  X3, #0x6dcd, LSL #0
    MOVK  X3, #0x91b4, LSL #16
    MOVK  X3, #0xe9e1, LSL #32
    MOVK  X3, #0xb772, LSL #48
    MOVZ  X4, #0x781, LSL #0
    MOVK  X4, #0x71bb, LSL #16
    MOVK  X4, #0x8b54, LSL #32
    MOVK  X4, #0xe946, LSL #48
    MOVZ  X5, #0x2de2, LSL #0
    MOVK  X5, #0x404d, LSL #16
    MOVK  X5, #0x378, LSL #32
    MOVK  X5, #0x1a64, LSL #48
    MOVZ  X6, #0xae2f, LSL #0
    MOVK  X6, #0x3b37, LSL #16
    MOVK  X6, #0xf48b, LSL #32
    MOVK  X6, #0x3e6f, LSL #48
    MOVZ  X7, #0x8337, LSL #0
    MOVK  X7, #0x9a66, LSL #16
    MOVK  X7, #0xfc1f, LSL #32
    MOVK  X7, #0x72d9, LSL #48
    MOVZ  X8, #0x60c1, LSL #0
    MOVK  X8, #0xe437, LSL #16
    MOVK  X8, #0x3f7e, LSL #32
    MOVK  X8, #0xb777, LSL #48
    MOVZ  X9, #0x3ce1, LSL #0
    MOVK  X9, #0x4993, LSL #16
    MOVK  X9, #0x3065, LSL #32
    MOVK  X9, #0x8e29, LSL #48
    MOVZ  X10, #0x46c3, LSL #0
    MOVK  X10, #0x51ab, LSL #16
    MOVK  X10, #0xa567, LSL #32
    MOVK  X10, #0x43d7, LSL #48
    MOVZ  X12, #0x1ce4, LSL #0
    MOVK  X12, #0x4bdd, LSL #16
    MOVK  X12, #0xbc41, LSL #32
    MOVK  X12, #0xa714, LSL #48
    MOVZ  X13, #0x8bc8, LSL #0
    MOVK  X13, #0x6074, LSL #16
    MOVK  X13, #0xab13, LSL #32
    MOVK  X13, #0x75ad, LSL #48
    MOVZ  X14, #0xc2e4, LSL #0
    MOVK  X14, #0xca9, LSL #16
    MOVK  X14, #0xde02, LSL #32
    MOVK  X14, #0x3966, LSL #48
    MOVZ  X15, #0x2dd0, LSL #0
    MOVK  X15, #0xb242, LSL #16
    MOVK  X15, #0x6e50, LSL #32
    MOVK  X15, #0x49ba, LSL #48
    MOVZ  X16, #0x149, LSL #0
    MOVK  X16, #0xd9aa, LSL #16
    MOVK  X16, #0x2942, LSL #32
    MOVK  X16, #0x4a7f, LSL #48
    MOVZ  X17, #0xff81, LSL #0
    MOVK  X17, #0xaf6f, LSL #16
    MOVK  X17, #0xce9c, LSL #32
    MOVK  X17, #0x7777, LSL #48
    MOVZ  X20, #0x9895, LSL #0
    MOVK  X20, #0x6f4, LSL #16
    MOVK  X20, #0x883f, LSL #32
    MOVK  X20, #0xea25, LSL #48
    MOVZ  X21, #0xb89e, LSL #0
    MOVK  X21, #0xd9f8, LSL #16
    MOVK  X21, #0xa0f6, LSL #32
    MOVK  X21, #0xf5f5, LSL #48
    MOVZ  X22, #0x397b, LSL #0
    MOVK  X22, #0x7323, LSL #16
    MOVK  X22, #0x81f3, LSL #32
    MOVK  X22, #0x780, LSL #48
    MOVZ  X23, #0x9f6f, LSL #0
    MOVK  X23, #0x9e3a, LSL #16
    MOVK  X23, #0x1fc5, LSL #32
    MOVK  X23, #0x21b7, LSL #48
    MOVZ  X24, #0x4f96, LSL #0
    MOVK  X24, #0x3af9, LSL #16
    MOVK  X24, #0x1551, LSL #32
    MOVK  X24, #0x8982, LSL #48
    MOVZ  X25, #0xe883, LSL #0
    MOVK  X25, #0x556e, LSL #16
    MOVK  X25, #0x11f6, LSL #32
    MOVK  X25, #0xeb8f, LSL #48
    MOVZ  X27, #0xa562, LSL #0
    MOVK  X27, #0x66fb, LSL #16
    MOVK  X27, #0x6384, LSL #32
    MOVK  X27, #0xc433, LSL #48
    MOVZ  X28, #0xc3e9, LSL #0
    MOVK  X28, #0x747e, LSL #16
    MOVK  X28, #0xd471, LSL #32
    MOVK  X28, #0x9971, LSL #48
    MOVZ  X29, #0x80d3, LSL #0
    MOVK  X29, #0x58f6, LSL #16
    MOVK  X29, #0xb93c, LSL #32
    MOVK  X29, #0x648f, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X27
    FMOV  D1, X29
    FMOV  V1.D[1], X28
    FMOV  D2, X22
    FMOV  V2.D[1], X10
    FMOV  D3, X5
    FMOV  V3.D[1], X16
    FMOV  D4, X29
    FMOV  V4.D[1], X5
    FMOV  D5, X23
    FMOV  V5.D[1], X16
    FMOV  D6, X24
    FMOV  V6.D[1], X27
    FMOV  D7, X3
    FMOV  V7.D[1], X17
    FMOV  D8, X23
    FMOV  V8.D[1], X29
    FMOV  D9, X24
    FMOV  V9.D[1], X12
    FMOV  D10, X28
    FMOV  V10.D[1], X6
    FMOV  D11, X20
    FMOV  V11.D[1], X20
    FMOV  D12, X29
    FMOV  V12.D[1], X10
    FMOV  D13, X2
    FMOV  V13.D[1], X7
    FMOV  D14, X14
    FMOV  V14.D[1], X7
    FMOV  D15, X9
    FMOV  V15.D[1], X29
    FMOV  D16, X4
    FMOV  V16.D[1], X17
    FMOV  D17, X14
    FMOV  V17.D[1], X20
    FMOV  D18, X13
    FMOV  V18.D[1], X24
    FMOV  D19, X12
    FMOV  V19.D[1], X2
    FMOV  D20, X10
    FMOV  V20.D[1], X5
    FMOV  D21, X12
    FMOV  V21.D[1], X2
    FMOV  D22, X21
    FMOV  V22.D[1], X8
    FMOV  D23, X9
    FMOV  V23.D[1], X10
    FMOV  D24, X8
    FMOV  V24.D[1], X12
    FMOV  D25, X22
    FMOV  V25.D[1], X16
    FMOV  D26, X7
    FMOV  V26.D[1], X4
    FMOV  D27, X9
    FMOV  V27.D[1], X15
    FMOV  D28, X20
    FMOV  V28.D[1], X23
    FMOV  D29, X16
    FMOV  V29.D[1], X23
    FMOV  D30, X22
    FMOV  V30.D[1], X8
    FMOV  D31, X14
    FMOV  V31.D[1], X17
    MOVZ  X5, #0xf, LSL #0
TSRTAdvsimdVectorUnsignedOperation_label_9:
    UMULL2 V9.4S, V29.8H, V4.H[0x5]
    UQSHL V19.2D, V23.2D, #0x3
    USUBW  V12.8H, V22.8H, V28.8B
    USHLL V10.2D, V9.2S, #0x18
    USHR  V24.8B, V12.8B, #7
    URSHR  V28.16B, V25.16B, #4
    UMOV W23, V30.H[0x6]
    UQRSHRN2 V17.16B, V26.8H, #8
    UADDL2  V0.2D, V27.4S, V17.4S
    URSRA  V11.8H, V31.8H, #3
    UQRSHRN2 V7.16B, V19.8H, #2
    UMLAL2 V10.4S, V24.8H, V0.H[0x2]
    UXTL2 V4.8H, V28.16B
    UADDL  V0.4S, V4.4H, V4.4H
    UADDLP  V25.8H, V7.16B
    UQSHL  V29.2S, V11.2S, #0xb
    UQSHRN2 V17.4S, V29.2D, #5
    UQSHL  V30.8B, V10.8B, #0x1
    URSRA  V12.16B, V0.16B, #2
    UABAL  V28.8H, V17.8B, V12.8B
    USRA  V19.8H, V23.8H, #4
    USQADD  V11.4H, V10.4H
    UQSHL  V24.4H, V28.4H, #0x0
    USHLL2 V22.8H, V11.16B, #0x2
    UHSUB  V12.8H, V24.8H, V25.8H
    USRA V17.2D, V30.2D, #16
    USRA  V26.2S, V17.2S, #5
    URSRA  V0.4S, V26.4S, #5
    USHL  V17.2S, V12.2S, V19.2S
    UMLAL2 V31.4S, V0.8H, V0.H[0x6]
    UQRSHRN V0.4H, V31.4S, #3
    UADDLV  D31, V13.4S
    UXTL V4.2D, V31.2S
    UHADD  V13.8H, V22.8H, V0.8H
    URSRA V23.2D, V17.2D, #27
    UADALP  V10.2S, V23.4H
    UQSHRN2 V29.8H, V10.4S, #13
    UADDLV  S30, V29.4H
    UMULL V29.4S, V4.4H, V13.H[0x3]
    UHADD  V13.16B, V29.16B, V29.16B
    USUBW  V28.2D, V13.2D, V2.2S
    UMLSL V11.2D, V28.2S, V28.S[0x0]
    UMLAL  V12.2D, V30.2S, V24.2S
    USUBW2  V24.4S, V11.4S, V11.8H
    URSRA  V19.2S, V24.2S, #10
    URSHR  V28.2S, V29.2S, #17
    URSRA  V26.4S, V19.4S, #19
    URSHR  V23.4H, V26.4H, #13
    UMOV W28, V23.B[0x6]
    USHLL2 V25.4S, V12.8H, #0xf
    UXTL2 V26.2D, V25.4S
    USHL  V22.8H, V30.8H, V28.8H
    UQRSHL  V12.2S, V22.2S, V22.2S
    USHLL V17.8H, V12.8B, #0x1
    USQADD  V11.2S, V17.2S
    UMLAL  V0.8H, V26.8B, V26.8B
    UMLSL V4.4S, V0.4H, V11.H[0x6]
    USHLL2 V24.4S, V31.8H, #0x2
    URSHR  V25.8H, V15.8H, #10
    UADALP  V30.1D, V15.2S
    URSRA  V13.4S, V25.4S, #4
    URSHR V19.2D, V21.2D, #54
    USHR V28.2D, V16.2D, #53
    UADDL  V21.4S, V25.4H, V2.4H
    UADDLV  D22, V25.4S
    UQSHL V12.2D, V9.2D, #0x6
    USHLL V2.4S, V13.4H, #0xc
    UMLAL2 V16.4S, V13.8H, V4.H[0x3]
    UADALP  V13.4S, V30.8H
    UQSHRN2 V17.16B, V24.8H, #2
    UQXTN2  V9.8H, V19.4S
    UQSHRN2 V11.16B, V2.8H, #6
    UQSHL  V4.4H, V11.4H, V9.4H
    UABAL  V9.8H, V12.8B, V21.8B
    UQSHL  V15.4S, V9.4S, #0x17
    UQRSHL  V12.2D, V15.2D, V17.2D
    UXTL2 V17.4S, V22.8H
    USHL  V23.2S, V16.2S, V17.2S
    USHLL V9.8H, V13.8B, #0x4
    USUBW  V19.4S, V12.4S, V0.4H
    UADDLV  D16, V4.4S
    URSHR  V25.16B, V23.16B, #6
    USQADD  V23.2S, V16.2S
    UQSUB  V2.16B, V23.16B, V19.16B
    USUBL  V0.8H, V9.8B, V9.8B
    USHLL V22.8H, V25.8B, #0x1
    UQSHL V15.2D, V2.2D, #0x2f
    USHR  V25.8H, V0.8H, #8
    UMLAL2 V23.4S, V28.8H, V5.H[0x6]
    USUBW  V16.4S, V23.4S, V23.4H
    UADALP  V28.1D, V15.2S
    UXTL V17.2D, V22.2S
    URSQRTE  V22.2S, V4.2S
    URECPE  V15.4S, V22.4S
    UXTL2 V22.4S, V28.8H
    URSHR  V5.2S, V22.2S, #27
    UADDLV  S19, V15.8H
    USHLL V13.8H, V17.8B, #0x6
    UQRSHRN2 V2.16B, V5.8H, #5
    UXTL2 V17.8H, V25.16B
    UXTL2 V4.8H, V17.16B
    UXTL V5.4S, V4.4H
    UHSUB  V4.16B, V5.16B, V16.16B
    UMOV X8, V19.D[0x0]
    UMULL2 V9.4S, V2.8H, V4.H[0x0]
    USHLL V16.8H, V13.8B, #0x7
    USHR  V25.4S, V9.4S, #18
    UQSHRN2 V5.8H, V25.4S, #12
    UQSHL V0.2D, V16.2D, #0x39
    UADDLV  D12, V5.4S
    UQXTN  V17.8B, V12.8H
    UQRSHL  V12.2D, V0.2D, V17.2D
    UQRSHRN V5.4H, V12.4S, #16
    UQSHRN V16.2S, V15.2D, #17
    URSHR V2.2D, V2.2D, #49
    UMLAL V28.2D, V14.2S, V9.S[0x0]
    UQRSHRN V9.2S, V12.2D, #25
    UQRSHL  V23.4S, V10.4S, V20.4S
    UMLSL V19.4S, V0.4H, V8.H[0x3]
    UMLSL  V15.8H, V2.8B, V17.8B
    USHLL V22.4S, V6.4H, #0xe
    UXTL V17.8H, V3.8B
    USQADD  V20.4S, V5.4S
    URECPE  V4.2S, V20.2S
    UMLSL2 V25.4S, V23.8H, V15.H[0x2]
    USUBL  V5.8H, V25.8B, V16.8B
    USHR  V6.16B, V22.16B, #6
    USHLL2 V14.2D, V17.4S, #0x1f
    USRA  V0.2S, V9.2S, #25
    UXTL V20.4S, V4.4H
    UQSHRN2 V2.16B, V28.8H, #5
    UMLSL  V4.4S, V20.4H, V19.4H
    UMULL2 V16.4S, V5.8H, V4.H[0x3]
    UADDW  V9.2D, V6.2D, V0.2S
    USUBL2  V17.8H, V14.16B, V2.16B
    UXTL2 V2.4S, V17.8H
    UQXTN  V17.4H, V16.4S
    UABDL2  V28.2D, V9.4S, V9.4S
    UMLAL2 V25.2D, V28.4S, V2.S[0x2]
    UMULL V19.2D, V25.2S, V25.S[0x2]
    UQSHRN2 V22.4S, V17.2D, #13
    UQSHRN2 V14.4S, V22.2D, #19
    UMLAL2  V20.2D, V14.4S, V3.4S
    UMOV W10, V19.H[0x7]
    USQADD  V2.8B, V8.8B
    UMOV W7, V27.B[0xe]
    UXTL2 V28.4S, V21.8H
    URSHR V16.2D, V27.2D, #21
    UMLAL2 V8.2D, V27.4S, V10.S[0x3]
    UADDW2  V9.8H, V30.8H, V0.16B
    USHLL V5.2D, V11.2S, #0x2
    UADDW  V0.2D, V9.2D, V4.2S
    USHL  V27.8H, V10.8H, V15.8H
    USHR  V9.4H, V29.4H, #10
    URSQRTE  V30.4S, V20.4S
    UQSUB  V11.8B, V30.8B, V16.8B
    USHLL2 V25.8H, V27.16B, #0x6
    UMULL2 V6.2D, V25.4S, V25.S[0x0]
    UMULL V15.4S, V5.4H, V2.H[0x3]
    UMULL2 V3.4S, V9.8H, V7.H[0x4]
    USRA  V30.2S, V11.2S, #13
    UADDLV  H4, V6.16B
    UMLAL2 V9.4S, V8.8H, V5.H[0x0]
    UMOV W21, V15.B[0x6]
    UMLAL  V27.2D, V28.2S, V9.2S
    URSHR V15.2D, V3.2D, #23
    UMULL2 V10.4S, V30.8H, V0.H[0x7]
    UQRSHRN V20.4H, V10.4S, #12
    UMULL V29.2D, V15.2S, V27.S[0x1]
    UMOV W25, V29.H[0x3]
    UMLSL V16.4S, V20.4H, V4.H[0x4]
    UMULL V8.4S, V15.4H, V9.H[0x0]
    USHLL2 V29.8H, V6.16B, #0x5
    USUBW2  V11.2D, V20.2D, V24.4S
    UQSHRN2 V2.16B, V25.8H, #5
    UMULL2  V30.8H, V18.16B, V22.16B
    UQSHRN V5.2S, V27.2D, #10
    USHLL2 V22.8H, V19.16B, #0x6
    USHL  V28.4S, V22.4S, V26.4S
    USUBL  V24.4S, V4.4H, V7.4H
    UADDLV  D20, V8.4S
    UMULL2 V10.4S, V30.8H, V2.H[0x5]
    URSHR V15.2D, V29.2D, #27
    UMLAL V4.2D, V24.2S, V5.S[0x3]
    UQSUB  V27.2D, V6.2D, V28.2D
    USUBW2  V19.4S, V27.4S, V4.8H
    URSHL  V25.2S, V16.2S, V19.2S
    URHADD  V8.16B, V25.16B, V15.16B
    USUBL  V28.2D, V20.2S, V20.2S
    URHADD  V20.16B, V11.16B, V8.16B
    UABAL  V0.4S, V10.4H, V28.4H
    URSRA V29.2D, V20.2D, #14
    UXTL V26.4S, V29.4H
    UQRSHRN2 V28.16B, V0.8H, #2
    UQSHRN V20.2S, V28.2D, #1
    UQSHRN2 V18.16B, V26.8H, #1
    UQSHL  V2.4S, V23.4S, #0x19
    UABDL  V7.2D, V18.2S, V2.2S
    UHSUB  V23.4S, V20.4S, V7.4S
    UQSHRN V30.8B, V7.8H, #4
    SUBS  X5, X5, #0x1
    B.NE  TSRTAdvsimdVectorUnsignedOperation_label_9
    MOVZ  X17, #0x91b7, LSL #0
    MOVK  X17, #0xe642, LSL #16
    MOVK  X17, #0x894a, LSL #32
    MOVK  X17, #0xe7fa, LSL #48
    SUB  X12, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x6dcd, LSL #0
    MOVK  X17, #0x91b4, LSL #16
    MOVK  X17, #0xe9e1, LSL #32
    MOVK  X17, #0xb772, LSL #48
    SUB  X12, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x781, LSL #0
    MOVK  X17, #0x71bb, LSL #16
    MOVK  X17, #0x8b54, LSL #32
    MOVK  X17, #0xe946, LSL #48
    SUB  X12, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xae2f, LSL #0
    MOVK  X17, #0x3b37, LSL #16
    MOVK  X17, #0xf48b, LSL #32
    MOVK  X17, #0x3e6f, LSL #48
    SUB  X12, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xfefc, LSL #0
    MOVK  X17, #0x5, LSL #16
    SUB  X12, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x3ce1, LSL #0
    MOVK  X17, #0x4993, LSL #16
    MOVK  X17, #0x3065, LSL #32
    MOVK  X17, #0x8e29, LSL #48
    SUB  X12, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x8bc8, LSL #0
    MOVK  X17, #0x6074, LSL #16
    MOVK  X17, #0xab13, LSL #32
    MOVK  X17, #0x75ad, LSL #48
    SUB  X12, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x2dd0, LSL #0
    MOVK  X17, #0xb242, LSL #16
    MOVK  X17, #0x6e50, LSL #32
    MOVK  X17, #0x49ba, LSL #48
    SUB  X12, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x149, LSL #0
    MOVK  X17, #0xd9aa, LSL #16
    MOVK  X17, #0x2942, LSL #32
    MOVK  X17, #0x4a7f, LSL #48
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x9895, LSL #0
    MOVK  X17, #0x6f4, LSL #16
    MOVK  X17, #0x883f, LSL #32
    MOVK  X17, #0xea25, LSL #48
    SUB  X12, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x397b, LSL #0
    MOVK  X17, #0x7323, LSL #16
    MOVK  X17, #0x81f3, LSL #32
    MOVK  X17, #0x780, LSL #48
    SUB  X12, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x4f96, LSL #0
    MOVK  X17, #0x3af9, LSL #16
    MOVK  X17, #0x1551, LSL #32
    MOVK  X17, #0x8982, LSL #48
    SUB  X12, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xa562, LSL #0
    MOVK  X17, #0x66fb, LSL #16
    MOVK  X17, #0x6384, LSL #32
    MOVK  X17, #0xc433, LSL #48
    SUB  X12, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x80d3, LSL #0
    MOVK  X17, #0x58f6, LSL #16
    MOVK  X17, #0xb93c, LSL #32
    MOVK  X17, #0x648f, LSL #48
    SUB  X12, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x800, LSL #16
    MRS  X12, FPSR
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x8000, LSL #16
    FMOV  X12, V0.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xfefb, LSL #0
    MOVK  X17, #0x104, LSL #16
    FMOV  X12, D0
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xc3e9, LSL #0
    MOVK  X17, #0x747e, LSL #16
    MOVK  X17, #0xd471, LSL #32
    MOVK  X17, #0x9971, LSL #48
    FMOV  X12, V1.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x80d3, LSL #0
    MOVK  X17, #0x58f6, LSL #16
    MOVK  X17, #0xb93c, LSL #32
    MOVK  X17, #0x648f, LSL #48
    FMOV  X12, D1
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V2.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X12, D2
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V3.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D3
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V4.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D4
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V5.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    FMOV  X12, D5
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V6.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D6
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x54ec, LSL #0
    MOVK  X17, #0x8a52, LSL #16
    FMOV  X12, V7.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x7437, LSL #0
    MOVK  X17, #0x9f8b, LSL #16
    FMOV  X12, D7
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V8.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D8
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V9.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D9
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V10.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D10
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V11.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D11
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V12.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D12
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V13.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D13
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x1fff, LSL #32
    FMOV  X12, V14.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D14
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V15.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D15
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V16.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D16
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V17.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X12, D17
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V18.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x8bc8, LSL #0
    MOVK  X17, #0x6074, LSL #16
    MOVK  X17, #0xab13, LSL #32
    MOVK  X17, #0x75ad, LSL #48
    FMOV  X12, D18
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V19.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D19
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V20.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X12, D20
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #32
    FMOV  X12, V21.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #32
    FMOV  X12, D21
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V22.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D22
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xd58a, LSL #0
    MOVK  X17, #0xbad6, LSL #16
    FMOV  X12, V23.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x45e4, LSL #0
    MOVK  X17, #0xb03a, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0x7fff, LSL #48
    FMOV  X12, D23
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V24.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x8bc9, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0x6075, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X12, D24
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V25.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D25
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V26.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D26
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V27.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D27
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x41ff, LSL #0
    MOVK  X17, #0xff00, LSL #32
    FMOV  X12, V28.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D28
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V29.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D29
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V30.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #32
    FMOV  X12, D30
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V31.D[1]
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D31
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
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
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X17
    FMOV  V0.D[1], X24
    FMOV  D1, X29
    FMOV  V1.D[1], X9
    FMOV  D2, X23
    FMOV  V2.D[1], X15
    FMOV  D3, X20
    FMOV  V3.D[1], X16
    FMOV  D4, X28
    FMOV  V4.D[1], X21
    FMOV  D5, X22
    FMOV  V5.D[1], X27
    FMOV  D6, X25
    FMOV  V6.D[1], X10
    FMOV  D7, X10
    FMOV  V7.D[1], X13
    FMOV  D8, X12
    FMOV  V8.D[1], X28
    FMOV  D9, X24
    FMOV  V9.D[1], X7
    FMOV  D10, X14
    FMOV  V10.D[1], X8
    FMOV  D11, X21
    FMOV  V11.D[1], X3
    FMOV  D12, X15
    FMOV  V12.D[1], X28
    FMOV  D13, X7
    FMOV  V13.D[1], X23
    FMOV  D14, X15
    FMOV  V14.D[1], X28
    FMOV  D15, X24
    FMOV  V15.D[1], X5
    FMOV  D16, X8
    FMOV  V16.D[1], X22
    FMOV  D17, X14
    FMOV  V17.D[1], X29
    FMOV  D18, X6
    FMOV  V18.D[1], X21
    FMOV  D19, X20
    FMOV  V19.D[1], X5
    FMOV  D20, X27
    FMOV  V20.D[1], X27
    FMOV  D21, X5
    FMOV  V21.D[1], X6
    FMOV  D22, X3
    FMOV  V22.D[1], X2
    FMOV  D23, X5
    FMOV  V23.D[1], X25
    FMOV  D24, X12
    FMOV  V24.D[1], X2
    FMOV  D25, X22
    FMOV  V25.D[1], X8
    FMOV  D26, X22
    FMOV  V26.D[1], X5
    FMOV  D27, X23
    FMOV  V27.D[1], X23
    FMOV  D28, X15
    FMOV  V28.D[1], X20
    FMOV  D29, X13
    FMOV  V29.D[1], X17
    FMOV  D30, X6
    FMOV  V30.D[1], X4
    FMOV  D31, X6
    FMOV  V31.D[1], X5
    MOVZ  X12, #0xf, LSL #0
TSRTAdvsimdVectorUnsignedOperation_label_10:
    UQSHL V12.2D, V31.2D, #0x2f
    UQSHRN2 V17.4S, V30.2D, #8
    UQRSHRN V13.8B, V12.8H, #4
    USHR V28.2D, V17.2D, #37
    USQADD  V22.2D, V27.2D
    USRA  V9.8B, V29.8B, #4
    UHADD  V4.8B, V13.8B, V22.8B
    UHSUB  V12.8H, V26.8H, V4.8H
    URSRA V15.2D, V12.2D, #7
    UADDW  V29.2D, V15.2D, V28.2S
    UADDW2  V0.2D, V9.2D, V29.4S
    USUBL  V4.8H, V0.8B, V25.8B
    UADDW  V25.8H, V4.8H, V4.8B
    UQADD  V8.4S, V25.4S, V24.4S
    USHR  V9.4H, V8.4H, #2
    UADDLV  H27, V14.8B
    UMULL V28.2D, V5.2S, V0.S[0x0]
    UADDW2  V29.8H, V8.8H, V6.16B
    UADDW2  V5.4S, V19.4S, V0.8H
    URSHR V19.2D, V20.2D, #34
    USHLL2 V14.2D, V30.4S, #0x6
    UMLSL2 V12.2D, V2.4S, V3.S[0x2]
    UQSUB  V30.16B, V23.16B, V10.16B
    UQSHRN V25.8B, V14.8H, #2
    UMLAL  V22.2D, V27.2S, V29.2S
    UADDW2  V26.2D, V5.2D, V9.4S
    UMOV X23, V22.D[0x1]
    UMLAL V31.2D, V28.2S, V18.S[0x0]
    UABAL  V18.2D, V30.2S, V16.2S
    USHLL V29.8H, V18.8B, #0x6
    UQSHRN2 V14.4S, V26.2D, #3
    USUBW2  V15.2D, V31.2D, V25.4S
    USUBL  V8.4S, V15.4H, V14.4H
    UXTL2 V30.2D, V29.4S
    USHLL2 V24.2D, V19.4S, #0xf
    UQSHL  V20.4H, V12.4H, #0x3
    UQADD  V14.2D, V8.2D, V30.2D
    URSHR  V4.4H, V20.4H, #3
    USHLL V20.2D, V4.2S, #0x13
    USRA  V6.8H, V20.8H, #1
    USRA  V26.8H, V24.8H, #7
    UADDL  V16.4S, V26.4H, V26.4H
    USRA V27.2D, V6.2D, #34
    USHR  V6.8B, V14.8B, #1
    UMLAL V18.2D, V6.2S, V16.S[0x0]
    UMULL  V28.8H, V18.8B, V18.8B
    UADDLV  D8, V28.4S
    UMOV X4, V8.D[0x0]
    UQSHL  V25.4S, V20.4S, V9.4S
    UMOV W21, V3.S[0x2]
    URECPE  V28.2S, V2.2S
    UQSHRN V29.8B, V6.8H, #8
    UQXTN2  V24.8H, V9.4S
    UQRSHRN V4.4H, V5.4S, #8
    UQRSHRN2 V26.4S, V26.2D, #7
    UHSUB  V6.16B, V5.16B, V10.16B
    URSHR  V2.8H, V0.8H, #16
    UHADD  V0.8H, V2.8H, V26.8H
    URSHR  V2.16B, V27.16B, #6
    UMLSL2 V26.2D, V2.4S, V0.S[0x2]
    UXTL2 V14.2D, V26.4S
    UQRSHRN V15.8B, V28.8H, #7
    UXTL V18.8H, V24.8B
    UADDLV  S8, V18.8H
    UQSHL V10.2D, V14.2D, #0x1f
    USHR  V5.8B, V10.8B, #4
    UABD  V26.8H, V9.8H, V1.8H
    URSRA V14.2D, V8.2D, #54
    USHLL2 V2.4S, V14.8H, #0xe
    UQXTN  V18.2S, V25.2D
    UABD  V25.2S, V26.2S, V4.2S
    UXTL2 V27.8H, V29.16B
    UABDL2  V9.4S, V27.8H, V6.8H
    UABA  V0.8B, V9.8B, V18.8B
    UADDW2  V28.4S, V0.4S, V0.8H
    UMLAL2 V27.4S, V28.8H, V15.H[0x7]
    UMLSL V24.2D, V5.2S, V2.S[0x2]
    UHSUB  V10.2S, V25.2S, V25.2S
    UQSHRN V2.8B, V24.8H, #4
    UADDW  V24.2D, V27.2D, V2.2S
    URSRA  V6.8B, V29.8B, #8
    UXTL2 V14.2D, V10.4S
    UHADD  V4.2S, V24.2S, V14.2S
    USRA  V1.4H, V6.4H, #14
    USHLL V9.8H, V6.8B, #0x7
    UMULL2 V18.2D, V3.4S, V4.S[0x3]
    URSRA  V26.4S, V1.4S, #22
    UXTL2 V19.8H, V18.16B
    USRA  V24.16B, V23.16B, #5
    UMULL2 V23.2D, V19.4S, V9.S[0x3]
    UQSHRN2 V1.8H, V23.4S, #2
    UABA  V0.8B, V26.8B, V26.8B
    UQXTN  V29.8B, V24.8H
    URSHL  V14.16B, V29.16B, V1.16B
    URHADD  V18.16B, V0.16B, V14.16B
    UQSHRN V6.4H, V1.4S, #13
    UXTL V24.4S, V19.4H
    UMULL V4.2D, V29.2S, V7.S[0x2]
    USRA  V10.8B, V5.8B, #6
    UMULL2  V9.8H, V20.16B, V9.16B
    UABDL  V7.4S, V12.4H, V8.4H
    UMULL V19.4S, V22.4H, V7.H[0x0]
    USHLL2 V27.8H, V3.16B, #0x2
    UQSHRN V29.4H, V7.4S, #16
    USHR  V20.8B, V24.8B, #5
    UADDLP  V22.2D, V4.4S
    UXTL V25.4S, V18.4H
    UQSHRN V0.4H, V9.4S, #9
    UQSUB  V14.16B, V20.16B, V19.16B
    USHLL V2.8H, V6.8B, #0x1
    UQADD  V18.2S, V0.2S, V2.2S
    UMOV W23, V12.B[0x7]
    UMLSL2  V8.2D, V4.4S, V25.4S
    UXTL2 V20.2D, V10.4S
    UABD  V26.8H, V29.8H, V27.8H
    UQRSHL  V2.2S, V26.2S, V8.2S
    USUBW2  V9.4S, V14.4S, V2.8H
    UQXTN  V12.2S, V18.2D
    UADDL  V19.2D, V22.2S, V12.2S
    UXTL2 V26.4S, V19.8H
    UQRSHL  V6.8B, V20.8B, V9.8B
    UMLAL2 V29.2D, V6.4S, V26.S[0x0]
    URSRA  V22.16B, V2.16B, #1
    UADALP  V18.4H, V3.8B
    UQSHRN2 V0.4S, V16.2D, #28
    UQSHRN V16.8B, V9.8H, #8
    USHLL2 V14.4S, V26.8H, #0xe
    USHLL V25.8H, V25.8B, #0x6
    UQSHL  V3.4H, V31.4H, #0x7
    URSRA  V19.2S, V10.2S, #27
    UQSUB  V31.8B, V19.8B, V18.8B
    USHLL V4.2D, V31.2S, #0x3
    UABA  V9.2S, V29.2S, V0.2S
    URSQRTE  V10.4S, V16.4S
    UQSHL  V12.16B, V22.16B, #0x3
    UHADD  V20.8H, V25.8H, V22.8H
    UQRSHRN2 V25.8H, V14.4S, #13
    USRA  V16.8H, V3.8H, #1
    UXTL2 V27.4S, V20.8H
    USHLL V2.8H, V4.8B, #0x4
    USHL  V4.4H, V5.4H, V10.4H
    UMLAL V6.4S, V2.4H, V9.H[0x3]
    UMLAL  V22.8H, V12.8B, V6.8B
    URSRA  V5.2S, V25.2S, #18
    UMOV W5, V5.S[0x1]
    UMULL V2.4S, V16.4H, V4.H[0x6]
    URSHR V9.2D, V2.2D, #25
    UQSHRN2 V0.16B, V22.8H, #1
    UMLSL V26.4S, V9.4H, V8.H[0x3]
    UQSHRN2 V26.16B, V26.8H, #6
    UMLAL2  V4.8H, V27.16B, V27.16B
    URSHL  V20.16B, V0.16B, V0.16B
    UADDW2  V29.2D, V20.2D, V4.4S
    URSHR  V10.8H, V26.8H, #8
    UMLAL2 V0.2D, V17.4S, V10.S[0x1]
    UHADD  V27.16B, V0.16B, V0.16B
    UMLSL  V8.4S, V27.4H, V27.4H
    UXTL V2.4S, V8.4H
    UADDW2  V18.2D, V29.2D, V2.4S
    URSRA  V16.2S, V30.2S, #4
    UADDL  V20.4S, V24.4H, V22.4H
    UQRSHRN V9.4H, V8.4S, #16
    USHLL2 V17.8H, V7.16B, #0x7
    UQSHL V29.2D, V26.2D, #0x1d
    UMULL2 V27.4S, V8.8H, V14.H[0x2]
    UQRSHRN2 V0.16B, V26.8H, #8
    USQADD  V26.4S, V28.4S
    UXTL2 V28.2D, V27.4S
    UMULL2 V30.2D, V0.4S, V0.S[0x2]
    URSRA  V5.4S, V29.4S, #10
    UADDW  V14.8H, V5.8H, V5.8B
    USRA  V4.4H, V9.4H, #7
    UQXTN2  V10.16B, V25.8H
    UADDL  V27.2D, V28.2S, V28.2S
    URSRA V25.2D, V27.2D, #30
    USHR  V8.8H, V25.8H, #6
    UHADD  V9.4H, V14.4H, V4.4H
    USHR V5.2D, V17.2D, #21
    UQSHRN2 V15.16B, V26.8H, #7
    UQRSHL  V27.8B, V5.8B, V5.8B
    UXTL2 V24.2D, V15.4S
    UXTL V7.4S, V8.4H
    URSRA  V0.4S, V30.4S, #7
    UMOV X25, V24.D[0x0]
    USUBW  V14.8H, V9.8H, V27.8B
    UQXTN  V5.2S, V10.2D
    UABAL2  V30.4S, V7.8H, V5.8H
    URSHL  V27.2S, V0.2S, V0.2S
    UXTL V24.2D, V27.2S
    USRA  V4.4S, V14.4S, #4
    UXTL V9.8H, V4.8B
    UMLAL2 V15.2D, V27.4S, V30.S[0x3]
    UMLAL2 V4.2D, V15.4S, V24.S[0x1]
    UQSHRN V7.8B, V9.8H, #7
    UADDLV  S8, V4.4H
    UQSUB  V14.8H, V7.8H, V8.8H
    UABDL  V27.8H, V25.8B, V29.8B
    UQRSHRN2 V9.4S, V2.2D, #3
    USHLL2 V30.2D, V24.4S, #0x1f
    USRA  V4.4S, V10.4S, #10
    SUBS  X12, X12, #0x1
    B.NE  TSRTAdvsimdVectorUnsignedOperation_label_10
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x800, LSL #16
    MRS  X9, FPSR
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V0.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D0
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V1.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D1
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V2.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D2
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V3.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D3
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V4.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D4
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V5.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D5
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V6.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D6
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V7.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D7
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V8.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D8
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V9.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D9
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V10.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D10
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V11.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D11
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V12.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D12
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V13.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D13
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V14.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D14
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V15.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    FMOV  X9, D15
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V16.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D16
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V17.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D17
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V18.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D18
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V19.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D19
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V20.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D20
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V21.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D21
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V22.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D22
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V23.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D23
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V24.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D24
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V25.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D25
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V26.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D26
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V27.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D27
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V28.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D28
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V29.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D29
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V30.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D30
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, V31.D[1]
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X9, D31
    SUB  X22, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
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
    FMOV  D0, X23
    FMOV  V0.D[1], X29
    FMOV  D1, X24
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X25
    FMOV  D3, X6
    FMOV  V3.D[1], X9
    FMOV  D4, X27
    FMOV  V4.D[1], X10
    FMOV  D5, X21
    FMOV  V5.D[1], X29
    FMOV  D6, X6
    FMOV  V6.D[1], X25
    FMOV  D7, X7
    FMOV  V7.D[1], X17
    FMOV  D8, X6
    FMOV  V8.D[1], X16
    FMOV  D9, X6
    FMOV  V9.D[1], X8
    FMOV  D10, X13
    FMOV  V10.D[1], X7
    FMOV  D11, X20
    FMOV  V11.D[1], X15
    FMOV  D12, X24
    FMOV  V12.D[1], X4
    FMOV  D13, X14
    FMOV  V13.D[1], X13
    FMOV  D14, X13
    FMOV  V14.D[1], X3
    FMOV  D15, X14
    FMOV  V15.D[1], X14
    FMOV  D16, X3
    FMOV  V16.D[1], X17
    FMOV  D17, X4
    FMOV  V17.D[1], X24
    FMOV  D18, X20
    FMOV  V18.D[1], X14
    FMOV  D19, X22
    FMOV  V19.D[1], X17
    FMOV  D20, X28
    FMOV  V20.D[1], X10
    FMOV  D21, X15
    FMOV  V21.D[1], X25
    FMOV  D22, X27
    FMOV  V22.D[1], X16
    FMOV  D23, X17
    FMOV  V23.D[1], X9
    FMOV  D24, X7
    FMOV  V24.D[1], X27
    FMOV  D25, X28
    FMOV  V25.D[1], X5
    FMOV  D26, X29
    FMOV  V26.D[1], X22
    FMOV  D27, X24
    FMOV  V27.D[1], X3
    FMOV  D28, X12
    FMOV  V28.D[1], X25
    FMOV  D29, X29
    FMOV  V29.D[1], X15
    FMOV  D30, X17
    FMOV  V30.D[1], X12
    FMOV  D31, X28
    FMOV  V31.D[1], X14
    MOVZ  X12, #0xf, LSL #0
TSRTAdvsimdVectorUnsignedOperation_label_11:
    UMLSL2 V5.2D, V24.4S, V27.S[0x0]
    UMLSL V2.2D, V5.2S, V26.S[0x1]
    USHR V14.2D, V2.2D, #51
    UMULL V24.2D, V29.2S, V25.S[0x1]
    UQRSHRN2 V9.8H, V14.4S, #14
    USHLL2 V29.4S, V9.8H, #0x4
    UADDLV  H8, V30.8B
    UMULL2 V24.2D, V28.4S, V28.S[0x1]
    UQRSHRN V23.4H, V24.4S, #6
    UMULL V10.2D, V31.2S, V8.S[0x2]
    UMLSL2 V8.2D, V10.4S, V23.S[0x0]
    USUBL2  V30.2D, V29.4S, V8.4S
    USHLL2 V7.2D, V30.4S, #0x1e
    UQRSHRN2 V27.16B, V17.8H, #1
    UADDLV  S9, V21.8H
    UADDL  V8.8H, V7.8B, V16.8B
    UMLSL2  V29.2D, V2.4S, V8.4S
    UMLSL  V16.2D, V21.2S, V13.2S
    UMLSL2 V31.2D, V5.4S, V13.S[0x3]
    URECPE  V26.2S, V15.2S
    URSHR  V25.4H, V23.4H, #16
    UMULL V5.4S, V26.4H, V8.H[0x0]
    UMOV X5, V8.D[0x0]
    UQSHL  V14.4S, V2.4S, #0x1c
    URSHR  V21.8H, V2.8H, #1
    URSRA  V24.4H, V26.4H, #15
    UMOV W2, V9.H[0x6]
    UQSHRN2 V8.8H, V14.4S, #12
    UQRSHRN2 V30.4S, V27.2D, #8
    UQSHL V14.2D, V8.2D, #0x34
    UQRSHRN V17.8B, V31.8H, #8
    UMLAL2  V31.8H, V5.16B, V16.16B
    UQRSHRN V2.4H, V29.4S, #5
    UQSHL  V13.4H, V25.4H, #0xf
    UMULL2  V23.4S, V22.8H, V24.8H
    URSRA  V26.8B, V13.8B, #2
    UMLSL2 V24.2D, V30.4S, V21.S[0x3]
    UMOV W15, V17.H[0x3]
    UMLAL2 V30.2D, V24.4S, V23.S[0x3]
    URSHR V29.2D, V30.2D, #44
    UMOV W23, V29.H[0x6]
    URECPE  V16.4S, V26.4S
    UABD  V24.4S, V31.4S, V31.4S
    UABA  V9.16B, V3.16B, V24.16B
    USHLL2 V7.8H, V16.16B, #0x2
    UXTL V25.2D, V2.2S
    URSHR V15.2D, V14.2D, #44
    USHL  V15.4H, V15.4H, V9.4H
    UMULL2 V22.4S, V15.8H, V7.H[0x1]
    UMLAL V27.4S, V22.4H, V8.H[0x2]
    URSRA  V5.8B, V25.8B, #6
    UQRSHRN2 V25.16B, V27.8H, #7
    UADDLV  H1, V5.16B
    UMLAL V1.2D, V1.2S, V25.S[0x3]
    UQRSHRN2 V27.8H, V21.4S, #13
    UMLAL2 V17.4S, V22.8H, V4.H[0x0]
    USQADD  V13.4S, V1.4S
    UHSUB  V2.8H, V13.8H, V15.8H
    UADDL  V0.8H, V9.8B, V5.8B
    UMLSL V1.4S, V20.4H, V11.H[0x6]
    UMULL V14.4S, V17.4H, V1.H[0x5]
    UMULL V20.4S, V0.4H, V12.H[0x0]
    URSQRTE  V1.4S, V18.4S
    UABA  V9.8H, V15.8H, V19.8H
    USUBL  V12.8H, V6.8B, V2.8B
    USHR  V22.8H, V18.8H, #4
    UMLAL2 V4.4S, V1.8H, V4.H[0x1]
    URSRA V23.2D, V18.2D, #27
    USUBL2  V25.2D, V25.4S, V8.4S
    USHLL V18.2D, V12.2S, #0xc
    UQSHL  V21.2S, V22.2S, V11.2S
    UMULL  V13.2D, V14.2S, V18.2S
    USRA  V1.2S, V20.2S, #24
    URSHR V0.2D, V4.2D, #18
    UQRSHRN V17.8B, V9.8H, #8
    UXTL2 V5.8H, V17.16B
    USHLL V17.8H, V0.8B, #0x4
    UQSHL V14.2D, V27.2D, #0x10
    UMLAL2 V7.2D, V13.4S, V25.S[0x1]
    UADDW2  V7.8H, V23.8H, V5.16B
    UMULL  V8.2D, V7.2S, V7.2S
    UMULL V20.2D, V21.2S, V21.S[0x0]
    USRA  V0.8B, V17.8B, #8
    USRA V7.2D, V14.2D, #26
    UMOV X23, V0.D[0x1]
    UQRSHL  V5.8B, V1.8B, V7.8B
    URSRA  V25.2S, V20.2S, #20
    UADDLV  S27, V8.4H
    UQSHRN2 V9.4S, V27.2D, #7
    UQRSHRN2 V7.8H, V5.4S, #13
    UQSHRN2 V11.4S, V7.2D, #5
    URSRA  V13.8B, V9.8B, #6
    UADDLP  V1.4H, V11.8B
    UMULL  V9.2D, V13.2S, V13.2S
    UQSHL  V22.16B, V9.16B, #0x1
    USHLL2 V18.4S, V22.8H, #0x8
    UQRSHRN2 V21.4S, V25.2D, #18
    UADALP  V23.2D, V1.4S
    UMOV W21, V21.H[0x0]
    UADDW2  V25.2D, V18.2D, V23.4S
    USHR V21.2D, V23.2D, #18
    UABD  V20.2S, V13.2S, V15.2S
    UADDL  V18.8H, V11.8B, V15.8B
    UMULL V27.2D, V12.2S, V21.S[0x0]
    UXTL V5.2D, V21.2S
    UMLAL V8.4S, V10.4H, V4.H[0x2]
    URSRA  V21.2S, V20.2S, #8
    UQRSHRN2 V9.16B, V23.8H, #3
    USRA  V4.4S, V24.4S, #10
    USHL  V1.8H, V10.8H, V5.8H
    USHLL2 V7.2D, V24.4S, #0xa
    UADDL2  V24.8H, V4.16B, V27.16B
    UMLAL2  V22.4S, V7.8H, V7.8H
    UMULL2 V20.4S, V1.8H, V8.H[0x3]
    UMULL V23.2D, V25.2S, V9.S[0x0]
    UADDW  V15.2D, V30.2D, V23.2S
    USHR V4.2D, V21.2D, #41
    UMLSL V21.4S, V4.4H, V15.H[0x7]
    UMLSL V11.2D, V24.2S, V9.S[0x0]
    URSHR  V12.16B, V22.16B, #4
    UQSHRN V12.2S, V12.2D, #1
    UMLAL V7.2D, V20.2S, V18.S[0x0]
    USHR  V18.8H, V21.8H, #9
    UMLSL2 V5.2D, V17.4S, V12.S[0x2]
    UADDLV  H13, V7.16B
    URSRA  V24.4H, V2.4H, #7
    USRA  V7.2S, V18.2S, #12
    URSHR  V27.4S, V24.4S, #19
    USHR  V22.8H, V27.8H, #11
    USRA  V20.8H, V11.8H, #8
    UQSHRN V4.4H, V22.4S, #6
    USHR V25.2D, V5.2D, #19
    USHLL V5.8H, V7.8B, #0x3
    UABAL2  V27.4S, V25.8H, V25.8H
    UXTL V30.4S, V13.4H
    USRA  V24.8H, V30.8H, #7
    UMLSL V11.2D, V20.2S, V27.S[0x3]
    UMULL V1.2D, V5.2S, V11.S[0x1]
    UABAL  V27.4S, V24.4H, V24.4H
    URSHR  V21.8H, V27.8H, #9
    UQSHL  V7.4S, V21.4S, #0x1a
    USHLL V21.4S, V1.4H, #0x4
    UABDL  V5.4S, V21.4H, V21.4H
    UMLSL V24.4S, V5.4H, V4.H[0x5]
    UQADD  V25.4H, V24.4H, V7.4H
    UMULL  V22.2D, V6.2S, V13.2S
    UXTL V30.4S, V8.4H
    UQSHRN V27.2S, V25.2D, #32
    USUBW2  V25.8H, V22.8H, V1.16B
    UQSHRN V12.2S, V5.2D, #6
    USHR  V11.4H, V3.4H, #8
    UMOV X21, V27.D[0x1]
    URSRA V6.2D, V11.2D, #15
    UMOV W16, V21.S[0x1]
    URSHR V13.2D, V13.2D, #2
    USRA  V18.4S, V7.4S, #30
    UABD  V4.16B, V22.16B, V24.16B
    UADDLV  S11, V23.8H
    UHADD  V7.8B, V24.8B, V17.8B
    UMULL2  V21.4S, V20.8H, V30.8H
    USHR  V8.8H, V13.8H, #8
    URSHR  V27.8B, V8.8B, #4
    UQSHRN V23.2S, V27.2D, #13
    URSHR  V19.8B, V12.8B, #4
    UADDW2  V3.2D, V25.2D, V6.4S
    UHSUB  V1.2S, V18.2S, V4.2S
    UADDW2  V5.2D, V23.2D, V2.4S
    UMOV W14, V5.B[0xf]
    URSHL  V12.2S, V7.2S, V24.2S
    UMLAL2 V11.2D, V1.4S, V19.S[0x1]
    USHL  V27.8H, V11.8H, V12.8H
    UQSHRN2 V15.4S, V3.2D, #19
    USHLL V22.8H, V15.8B, #0x2
    USHLL V17.8H, V21.8B, #0x6
    URSHR  V11.16B, V22.16B, #3
    URSRA  V8.8B, V27.8B, #3
    UADDL  V6.8H, V17.8B, V17.8B
    URSHR  V21.4S, V6.4S, #27
    USHR  V2.4H, V21.4H, #13
    UABA  V6.4S, V2.4S, V2.4S
    UABDL2  V20.4S, V11.8H, V6.8H
    UXTL2 V12.2D, V20.4S
    UQRSHRN2 V13.8H, V8.4S, #14
    USHL  V25.8B, V31.8B, V13.8B
    UQSHRN2 V19.4S, V12.2D, #2
    UQSHL  V24.4H, V19.4H, V19.4H
    UMOV W15, V25.B[0xc]
    UHSUB  V15.2S, V23.2S, V0.2S
    UQRSHRN V6.4H, V29.4S, #14
    URSHR  V27.16B, V14.16B, #3
    UQSHRN V2.4H, V16.4S, #5
    UMLAL V16.2D, V10.2S, V25.S[0x0]
    UABDL2  V21.4S, V13.8H, V5.8H
    USUBW2  V17.4S, V21.4S, V21.8H
    UQADD  V11.2D, V3.2D, V16.2D
    UHADD  V16.2S, V25.2S, V1.2S
    UMULL V25.4S, V7.4H, V6.H[0x5]
    UADDL2  V29.2D, V16.4S, V2.4S
    USHLL2 V3.2D, V31.4S, #0xe
    UMOV W20, V5.H[0x5]
    SUBS  X12, X12, #0x1
    B.NE  TSRTAdvsimdVectorUnsignedOperation_label_11
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X22, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X22, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xb6, LSL #0
    MOVK  X29, #0x3f, LSL #16
    MOVK  X29, #0x86, LSL #32
    MOVK  X29, #0xff, LSL #48
    SUB  X22, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X22, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X22, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X22, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X22, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X22, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X22, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X22, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X22, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X22, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x800, LSL #16
    MRS  X22, FPSR
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V0.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xc0f3, LSL #0
    MOVK  X29, #0x7fcf, LSL #16
    MOVK  X29, #0xd0, LSL #32
    FMOV  X22, D0
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V1.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xffaf, LSL #0
    MOVK  X29, #0xff26, LSL #16
    MOVK  X29, #0xff7b, LSL #32
    MOVK  X29, #0xff58, LSL #48
    FMOV  X22, D1
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V2.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X22, D2
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xc000, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0x3fff, LSL #32
    FMOV  X22, V3.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D3
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V4.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xaa, LSL #0
    MOVK  X29, #0x1b2, LSL #16
    MOVK  X29, #0x109, LSL #32
    MOVK  X29, #0x14e, LSL #48
    FMOV  X22, D4
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V5.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D5
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V6.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D6
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V7.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x76d, LSL #0
    MOVK  X29, #0x659, LSL #16
    MOVK  X29, #0x67c, LSL #32
    MOVK  X29, #0x49f, LSL #48
    FMOV  X22, D7
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V8.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D8
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x6940, LSL #0
    FMOV  X22, V9.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D9
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V10.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D10
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X22, V11.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xcc80, LSL #48
    FMOV  X22, D11
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V12.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D12
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V13.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D13
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    FMOV  X22, V14.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X22, D14
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V15.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x1f86, LSL #0
    MOVK  X29, #0xc018, LSL #16
    MOVK  X29, #0xff98, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X22, D15
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V16.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x7fd6, LSL #0
    MOVK  X29, #0xff93, LSL #16
    MOVK  X29, #0x7fbe, LSL #32
    MOVK  X29, #0x7fac, LSL #48
    FMOV  X22, D16
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V17.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D17
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V18.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x8, LSL #0
    FMOV  X22, D18
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V19.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D19
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V20.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D20
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V21.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D21
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V22.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D22
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V23.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D23
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V24.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D24
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V25.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D25
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V26.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x1f80, LSL #16
    MOVK  X29, #0xa000, LSL #48
    FMOV  X22, D26
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x2020, LSL #16
    MOVK  X29, #0x2020, LSL #32
    FMOV  X22, V27.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x2020, LSL #0
    MOVK  X29, #0x2020, LSL #16
    MOVK  X29, #0x2020, LSL #32
    MOVK  X29, #0x2020, LSL #48
    FMOV  X22, D27
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X22, V28.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X22, D28
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V29.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D29
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V30.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D30
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X22, V31.D[1]
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X29, #0xfffd, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0x2, LSL #32
    FMOV  X22, D31
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x3751, LSL #0
    MOVK  X2, #0x39e0, LSL #16
    MOVK  X2, #0x6c6, LSL #32
    MOVK  X2, #0xab96, LSL #48
    MOVZ  X3, #0xfb17, LSL #0
    MOVK  X3, #0xcb03, LSL #16
    MOVK  X3, #0x3899, LSL #32
    MOVK  X3, #0xd809, LSL #48
    MOVZ  X4, #0xc039, LSL #0
    MOVK  X4, #0x5664, LSL #16
    MOVK  X4, #0xf805, LSL #32
    MOVK  X4, #0xa1d9, LSL #48
    MOVZ  X5, #0x3eb5, LSL #0
    MOVK  X5, #0x1103, LSL #16
    MOVK  X5, #0x944, LSL #32
    MOVK  X5, #0xa31f, LSL #48
    MOVZ  X6, #0xc9db, LSL #0
    MOVK  X6, #0xb894, LSL #16
    MOVK  X6, #0x9df2, LSL #32
    MOVK  X6, #0x682d, LSL #48
    MOVZ  X7, #0x8141, LSL #0
    MOVK  X7, #0xa500, LSL #16
    MOVK  X7, #0x4bd2, LSL #32
    MOVK  X7, #0x523c, LSL #48
    MOVZ  X8, #0xd9ea, LSL #0
    MOVK  X8, #0xd606, LSL #16
    MOVK  X8, #0x8e, LSL #32
    MOVK  X8, #0x64b7, LSL #48
    MOVZ  X9, #0x2e72, LSL #0
    MOVK  X9, #0xbcb5, LSL #16
    MOVK  X9, #0x5f11, LSL #32
    MOVK  X9, #0x228e, LSL #48
    MOVZ  X10, #0x9de9, LSL #0
    MOVK  X10, #0xac0a, LSL #16
    MOVK  X10, #0x750f, LSL #32
    MOVK  X10, #0x84b4, LSL #48
    MOVZ  X12, #0xa4cc, LSL #0
    MOVK  X12, #0xbb52, LSL #16
    MOVK  X12, #0xf9af, LSL #32
    MOVK  X12, #0x8c01, LSL #48
    MOVZ  X13, #0xb92a, LSL #0
    MOVK  X13, #0xce3, LSL #16
    MOVK  X13, #0x43b, LSL #32
    MOVK  X13, #0xfb66, LSL #48
    MOVZ  X14, #0xa9c, LSL #0
    MOVK  X14, #0x6948, LSL #16
    MOVK  X14, #0xbe6b, LSL #32
    MOVK  X14, #0x377, LSL #48
    MOVZ  X15, #0x885a, LSL #0
    MOVK  X15, #0x2d0d, LSL #16
    MOVK  X15, #0xde2c, LSL #32
    MOVK  X15, #0xa5cd, LSL #48
    MOVZ  X16, #0x2eed, LSL #0
    MOVK  X16, #0xda22, LSL #16
    MOVK  X16, #0x380e, LSL #32
    MOVK  X16, #0x6bf4, LSL #48
    MOVZ  X17, #0xdf25, LSL #0
    MOVK  X17, #0x5b68, LSL #16
    MOVK  X17, #0x2e3d, LSL #32
    MOVK  X17, #0x84c, LSL #48
    MOVZ  X20, #0x3021, LSL #0
    MOVK  X20, #0xfe9a, LSL #16
    MOVK  X20, #0xf6e8, LSL #32
    MOVK  X20, #0xf3ed, LSL #48
    MOVZ  X21, #0x4abc, LSL #0
    MOVK  X21, #0xfdbf, LSL #16
    MOVK  X21, #0xfd51, LSL #32
    MOVK  X21, #0x8187, LSL #48
    MOVZ  X22, #0x3188, LSL #0
    MOVK  X22, #0x7d23, LSL #16
    MOVK  X22, #0x3f72, LSL #32
    MOVK  X22, #0xf6eb, LSL #48
    MOVZ  X23, #0x17c5, LSL #0
    MOVK  X23, #0xe381, LSL #16
    MOVK  X23, #0x45d6, LSL #32
    MOVK  X23, #0x407f, LSL #48
    MOVZ  X24, #0xaa80, LSL #0
    MOVK  X24, #0x1a30, LSL #16
    MOVK  X24, #0xfbd3, LSL #32
    MOVK  X24, #0xdeb9, LSL #48
    MOVZ  X25, #0x15b8, LSL #0
    MOVK  X25, #0x50f6, LSL #16
    MOVK  X25, #0x5df0, LSL #32
    MOVK  X25, #0xccbc, LSL #48
    MOVZ  X27, #0x2db5, LSL #0
    MOVK  X27, #0xce15, LSL #16
    MOVK  X27, #0x1168, LSL #32
    MOVK  X27, #0x279e, LSL #48
    MOVZ  X28, #0xb035, LSL #0
    MOVK  X28, #0x2f3d, LSL #16
    MOVK  X28, #0xddbb, LSL #32
    MOVK  X28, #0xd5dc, LSL #48
    MOVZ  X29, #0xd0, LSL #0
    MOVK  X29, #0xac8f, LSL #16
    MOVK  X29, #0x150e, LSL #32
    MOVK  X29, #0x8d96, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X29
    FMOV  D1, X24
    FMOV  V1.D[1], X27
    FMOV  D2, X25
    FMOV  V2.D[1], X8
    FMOV  D3, X14
    FMOV  V3.D[1], X28
    FMOV  D4, X6
    FMOV  V4.D[1], X5
    FMOV  D5, X20
    FMOV  V5.D[1], X3
    FMOV  D6, X16
    FMOV  V6.D[1], X15
    FMOV  D7, X12
    FMOV  V7.D[1], X9
    FMOV  D8, X5
    FMOV  V8.D[1], X2
    FMOV  D9, X21
    FMOV  V9.D[1], X16
    FMOV  D10, X8
    FMOV  V10.D[1], X13
    FMOV  D11, X8
    FMOV  V11.D[1], X17
    FMOV  D12, X23
    FMOV  V12.D[1], X12
    FMOV  D13, X25
    FMOV  V13.D[1], X16
    FMOV  D14, X23
    FMOV  V14.D[1], X20
    FMOV  D15, X24
    FMOV  V15.D[1], X21
    FMOV  D16, X13
    FMOV  V16.D[1], X29
    FMOV  D17, X25
    FMOV  V17.D[1], X25
    FMOV  D18, X20
    FMOV  V18.D[1], X4
    FMOV  D19, X5
    FMOV  V19.D[1], X5
    FMOV  D20, X21
    FMOV  V20.D[1], X28
    FMOV  D21, X15
    FMOV  V21.D[1], X24
    FMOV  D22, X17
    FMOV  V22.D[1], X29
    FMOV  D23, X5
    FMOV  V23.D[1], X14
    FMOV  D24, X3
    FMOV  V24.D[1], X12
    FMOV  D25, X2
    FMOV  V25.D[1], X9
    FMOV  D26, X3
    FMOV  V26.D[1], X15
    FMOV  D27, X16
    FMOV  V27.D[1], X6
    FMOV  D28, X23
    FMOV  V28.D[1], X2
    FMOV  D29, X17
    FMOV  V29.D[1], X24
    FMOV  D30, X21
    FMOV  V30.D[1], X4
    FMOV  D31, X15
    FMOV  V31.D[1], X2
    MOVZ  X2, #0xf, LSL #0
TSRTAdvsimdVectorUnsignedOperation_label_12:
    UMULL V18.2D, V23.2S, V23.S[0x3]
    USHLL V19.8H, V26.8B, #0x3
    UQRSHRN2 V26.4S, V18.2D, #13
    UXTL2 V22.8H, V30.16B
    UQXTN  V30.4H, V31.4S
    UMOV W4, V22.S[0x1]
    UQADD  V23.2S, V28.2S, V25.2S
    USUBW2  V7.8H, V30.8H, V21.16B
    USHR V5.2D, V24.2D, #39
    UXTL V17.2D, V7.2S
    USHR V20.2D, V19.2D, #25
    UMLSL  V6.2D, V5.2S, V17.2S
    UHADD  V3.8H, V23.8H, V26.8H
    URSRA  V5.4S, V29.4S, #14
    UXTL V12.8H, V20.8B
    UABA  V21.8B, V5.8B, V6.8B
    UMLAL2  V29.8H, V3.16B, V3.16B
    UQRSHRN2 V19.4S, V12.2D, #11
    UMULL V22.2D, V19.2S, V21.S[0x1]
    UABAL2  V24.2D, V22.4S, V27.4S
    UQSHL  V31.8H, V24.8H, #0xf
    UQRSHRN V7.4H, V29.4S, #15
    USHLL V30.4S, V7.4H, #0x8
    USHLL2 V29.8H, V31.16B, #0x1
    UHADD  V26.16B, V29.16B, V30.16B
    USRA  V5.8H, V18.8H, #10
    USHLL V28.8H, V7.8B, #0x7
    USHLL2 V24.2D, V1.4S, #0x9
    UQRSHRN V29.4H, V18.4S, #12
    UABDL  V22.4S, V16.4H, V2.4H
    UMOV X9, V0.D[0x0]
    UMLSL V25.4S, V23.4H, V13.H[0x2]
    UQRSHRN V13.2S, V20.2D, #16
    USHLL2 V6.2D, V18.4S, #0x1
    UMULL V19.4S, V26.4H, V6.H[0x1]
    UMLAL V27.4S, V19.4H, V13.H[0x4]
    UMULL  V21.4S, V27.4H, V9.4H
    UQSHRN V2.2S, V21.2D, #27
    UABD  V13.4H, V5.4H, V5.4H
    UABDL  V9.8H, V13.8B, V27.8B
    UMLAL2  V31.8H, V2.16B, V28.16B
    UXTL V20.2D, V31.2S
    UXTL V1.2D, V20.2S
    UMLSL2 V7.4S, V25.8H, V9.H[0x7]
    URSHR  V12.2S, V1.2S, #24
    UXTL V28.8H, V22.8B
    USHR V1.2D, V29.2D, #64
    UMULL V20.4S, V24.4H, V7.H[0x5]
    UQSHL V23.2D, V12.2D, #0x2e
    UQSHL  V21.2S, V2.2S, V1.2S
    UMOV W14, V20.S[0x1]
    USHLL V31.4S, V21.4H, #0x7
    USHL  V6.2D, V28.2D, V31.2D
    UMLAL2  V24.2D, V6.4S, V23.4S
    UMLAL V22.4S, V17.4H, V6.H[0x4]
    UMLAL2 V25.2D, V26.4S, V28.S[0x0]
    UQSHRN V1.8B, V31.8H, #4
    UADDL  V13.2D, V24.2S, V26.2S
    UMLSL2  V12.8H, V15.16B, V7.16B
    URSHR  V21.2S, V18.2S, #21
    URSHR  V7.4S, V30.4S, #4
    UMOV W21, V23.S[0x1]
    UADDL2  V28.4S, V0.8H, V17.8H
    UQSHL V6.2D, V1.2D, #0x19
    UQSHL V2.2D, V8.2D, #0x1d
    UQSHL  V30.8H, V13.8H, V12.8H
    UMLSL V12.2D, V25.2S, V22.S[0x3]
    UQXTN  V23.4H, V21.4S
    USHR  V20.16B, V7.16B, #6
    UMLSL2 V7.2D, V12.4S, V6.S[0x2]
    URECPE  V18.4S, V23.4S
    USHLL V26.8H, V30.8B, #0x5
    UMLSL V30.4S, V2.4H, V2.H[0x6]
    UQRSHRN V17.2S, V20.2D, #12
    UQSHL V29.2D, V18.2D, #0xd
    UQSHL  V8.8H, V12.8H, V26.8H
    UQSHRN V21.4H, V28.4S, #3
    UQRSHRN V22.4H, V21.4S, #6
    UADDL  V15.2D, V22.2S, V8.2S
    USHLL2 V31.2D, V7.4S, #0x1b
    UADALP  V24.8H, V29.16B
    UXTL V25.4S, V24.4H
    UMOV W22, V15.S[0x1]
    UMOV W20, V25.H[0x1]
    UMULL2 V6.2D, V30.4S, V30.S[0x2]
    USRA  V12.8B, V17.8B, #8
    UQXTN  V24.2S, V31.2D
    UQRSHRN2 V18.4S, V24.2D, #8
    UMLSL  V24.4S, V12.4H, V12.4H
    UQADD  V23.8B, V6.8B, V24.8B
    URSHR V15.2D, V23.2D, #15
    USRA  V22.2S, V18.2S, #27
    UABA  V17.2S, V15.2S, V15.2S
    USRA V2.2D, V9.2D, #26
    USHR  V7.4H, V30.4H, #1
    UADDL  V30.8H, V17.8B, V7.8B
    USHLL V25.4S, V30.4H, #0xd
    UQRSHRN2 V7.4S, V27.2D, #2
    UMLSL2  V31.2D, V7.4S, V7.4S
    UMULL2 V30.2D, V17.4S, V25.S[0x0]
    UADDW2  V12.8H, V22.8H, V2.16B
    UMLAL V22.2D, V30.2S, V24.S[0x3]
    UABDL2  V29.8H, V12.16B, V22.16B
    UQSHRN V22.2S, V29.2D, #24
    UMLAL  V12.2D, V22.2S, V22.2S
    UQRSHRN2 V6.4S, V31.2D, #13
    UQRSHL  V2.8B, V12.8B, V22.8B
    UADDL2  V24.4S, V2.8H, V6.8H
    UXTL2 V31.2D, V11.4S
    UQSHL  V9.2S, V25.2S, V1.2S
    UMLAL2 V27.4S, V30.8H, V3.H[0x5]
    UXTL V29.2D, V18.2S
    UQRSHL  V23.2S, V0.2S, V17.2S
    UXTL2 V7.8H, V30.16B
    UABA  V30.4H, V8.4H, V14.4H
    UXTL V25.4S, V15.4H
    UHSUB  V1.4S, V31.4S, V29.4S
    UHADD  V12.16B, V23.16B, V9.16B
    URHADD  V22.4S, V25.4S, V6.4S
    UABAL2  V2.4S, V24.8H, V30.8H
    UADDL  V3.4S, V18.4H, V1.4H
    UABDL  V15.4S, V3.4H, V22.4H
    USHLL2 V14.2D, V15.4S, #0x1f
    URECPE  V30.4S, V27.4S
    UQSHL  V23.8B, V20.8B, #0x1
    UABAL2  V24.4S, V30.8H, V7.8H
    UABDL2  V31.4S, V14.8H, V23.8H
    UXTL V11.4S, V12.4H
    UQSHL  V14.16B, V31.16B, #0x6
    USHLL2 V3.4S, V24.8H, #0x9
    UABAL  V9.2D, V16.2S, V3.2S
    UMLAL2 V12.4S, V2.8H, V9.H[0x1]
    UQSHRN2 V21.8H, V12.4S, #6
    UXTL V23.2D, V21.2S
    UQSHL  V7.8B, V23.8B, V23.8B
    UADDLV  D1, V11.4S
    UXTL V24.4S, V14.4H
    USUBW2  V9.4S, V7.4S, V7.8H
    UQSHRN V12.2S, V1.2D, #14
    USUBL  V29.8H, V12.8B, V24.8B
    UADALP  V30.8H, V9.16B
    UQSHL V0.2D, V29.2D, #0x2f
    USRA V23.2D, V7.2D, #59
    UMLAL V15.2D, V23.2S, V30.S[0x3]
    USHLL V23.8H, V15.8B, #0x5
    USQADD  V24.8B, V4.8B
    UQSHL  V1.8H, V23.8H, #0x0
    USHLL2 V31.2D, V0.4S, #0x11
    UMLSL2 V14.4S, V24.8H, V3.H[0x4]
    UMLSL2 V7.4S, V1.8H, V1.H[0x4]
    USUBL2  V30.2D, V7.4S, V3.4S
    UQSHL  V22.8B, V30.8B, V30.8B
    UMOV W4, V31.H[0x4]
    URECPE  V21.4S, V14.4S
    USHLL2 V11.2D, V22.4S, #0x3
    UADDL  V29.8H, V21.8B, V21.8B
    UMLAL2 V31.2D, V12.4S, V11.S[0x1]
    URSHL  V14.16B, V29.16B, V29.16B
    USHLL V30.8H, V31.8B, #0x3
    UQRSHRN2 V21.4S, V3.2D, #19
    UXTL V9.2D, V30.2S
    UMLAL2  V23.2D, V14.4S, V1.4S
    URSHR V14.2D, V21.2D, #25
    UADDLP  V19.2D, V14.4S
    UMOV W9, V23.B[0x4]
    UMULL V15.2D, V22.2S, V19.S[0x1]
    UADDLV  H12, V15.16B
    UQSHRN V7.4H, V9.4S, #9
    UHSUB  V11.8B, V12.8B, V7.8B
    URSQRTE  V19.4S, V26.4S
    UQSHRN2 V23.4S, V29.2D, #20
    USUBL2  V9.2D, V31.4S, V3.4S
    UQSHL V26.2D, V4.2D, #0x1f
    UMLSL2 V4.4S, V9.8H, V4.H[0x7]
    UABA  V9.2S, V12.2S, V10.2S
    UQSHRN V24.8B, V1.8H, #8
    UADDW2  V14.2D, V6.2D, V26.4S
    USHLL2 V0.8H, V19.16B, #0x5
    UADDL2  V7.2D, V22.4S, V1.4S
    URSHR  V6.16B, V30.16B, #2
    UQSHL V10.2D, V11.2D, #0x22
    UMOV W10, V1.B[0xd]
    UMULL2 V11.2D, V7.4S, V10.S[0x1]
    UQRSHRN V29.2S, V4.2D, #15
    URSHR  V12.8H, V9.8H, #6
    UQSHRN2 V15.8H, V23.4S, #14
    UQSHL V26.2D, V24.2D, #0x25
    UQRSHL  V30.4S, V12.4S, V26.4S
    UMLSL2 V9.4S, V25.8H, V6.H[0x2]
    UMOV W9, V15.H[0x5]
    UMOV W10, V30.S[0x3]
    UADDL  V30.2D, V0.2S, V9.2S
    UXTL2 V0.4S, V29.8H
    UQRSHRN2 V29.8H, V11.4S, #7
    UABD  V23.4H, V14.4H, V30.4H
    UMOV W13, V23.H[0x4]
    UQSHL  V26.4H, V0.4H, #0xb
    UMLSL  V15.4S, V29.4H, V29.4H
    URSHL  V10.8H, V26.8H, V26.8H
    UHSUB  V24.4H, V15.4H, V15.4H
    SUBS  X2, X2, #0x1
    B.NE  TSRTAdvsimdVectorUnsignedOperation_label_12
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0xfb17, LSL #0
    MOVK  X15, #0xcb03, LSL #16
    MOVK  X15, #0x3899, LSL #32
    MOVK  X15, #0xd809, LSL #48
    SUB  X8, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x3eb5, LSL #0
    MOVK  X15, #0x1103, LSL #16
    MOVK  X15, #0x944, LSL #32
    MOVK  X15, #0xa31f, LSL #48
    SUB  X8, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0xc9db, LSL #0
    MOVK  X15, #0xb894, LSL #16
    MOVK  X15, #0x9df2, LSL #32
    MOVK  X15, #0x682d, LSL #48
    SUB  X8, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x8141, LSL #0
    MOVK  X15, #0xa500, LSL #16
    MOVK  X15, #0x4bd2, LSL #32
    MOVK  X15, #0x523c, LSL #48
    SUB  X8, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x2d, LSL #0
    SUB  X8, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0xa4cc, LSL #0
    MOVK  X15, #0xbb52, LSL #16
    MOVK  X15, #0xf9af, LSL #32
    MOVK  X15, #0x8c01, LSL #48
    SUB  X8, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0xfff4, LSL #0
    MOVK  X15, #0xb, LSL #16
    SUB  X8, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x2eed, LSL #0
    MOVK  X15, #0xda22, LSL #16
    MOVK  X15, #0x380e, LSL #32
    MOVK  X15, #0x6bf4, LSL #48
    SUB  X8, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0xdf25, LSL #0
    MOVK  X15, #0x5b68, LSL #16
    MOVK  X15, #0x2e3d, LSL #32
    MOVK  X15, #0x84c, LSL #48
    SUB  X8, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x40, LSL #16
    SUB  X8, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x17c5, LSL #0
    MOVK  X15, #0xe381, LSL #16
    MOVK  X15, #0x45d6, LSL #32
    MOVK  X15, #0x407f, LSL #48
    SUB  X8, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x15b8, LSL #0
    MOVK  X15, #0x50f6, LSL #16
    MOVK  X15, #0x5df0, LSL #32
    MOVK  X15, #0xccbc, LSL #48
    SUB  X8, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x2db5, LSL #0
    MOVK  X15, #0xce15, LSL #16
    MOVK  X15, #0x1168, LSL #32
    MOVK  X15, #0x279e, LSL #48
    SUB  X8, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0xb035, LSL #0
    MOVK  X15, #0x2f3d, LSL #16
    MOVK  X15, #0xddbb, LSL #32
    MOVK  X15, #0xd5dc, LSL #48
    SUB  X8, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0xd0, LSL #0
    MOVK  X15, #0xac8f, LSL #16
    MOVK  X15, #0x150e, LSL #32
    MOVK  X15, #0x8d96, LSL #48
    SUB  X8, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x800, LSL #16
    MRS  X8, FPSR
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V0.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, D0
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x640, LSL #0
    MOVK  X15, #0x500, LSL #16
    FMOV  X8, V1.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0xac0, LSL #0
    MOVK  X15, #0xb60, LSL #16
    FMOV  X8, D1
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x10, LSL #0
    FMOV  X8, V2.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x11e, LSL #0
    MOVK  X15, #0x3c, LSL #16
    MOVK  X15, #0xdf, LSL #32
    MOVK  X15, #0x1a, LSL #48
    FMOV  X8, D2
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x1e00, LSL #0
    MOVK  X15, #0x200, LSL #32
    FMOV  X8, V3.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0xfe00, LSL #0
    MOVK  X15, #0x1ff, LSL #16
    FMOV  X8, D3
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0xe1d4, LSL #0
    MOVK  X15, #0x6de4, LSL #16
    MOVK  X15, #0xac63, LSL #32
    FMOV  X8, V4.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x7db, LSL #0
    MOVK  X15, #0x16bc, LSL #16
    MOVK  X15, #0x4111, LSL #32
    MOVK  X15, #0xc50f, LSL #48
    FMOV  X8, D4
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V5.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x4, LSL #16
    MOVK  X15, #0x4, LSL #48
    FMOV  X8, D5
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V6.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, D6
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V7.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x640, LSL #0
    MOVK  X15, #0x500, LSL #16
    FMOV  X8, D7
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0xe438, LSL #0
    MOVK  X15, #0xa91, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X8, V8.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, D8
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V9.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0xe200, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X8, D9
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V10.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, D10
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V11.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, D11
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V12.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x388, LSL #0
    MOVK  X15, #0x400, LSL #16
    MOVK  X15, #0x400, LSL #32
    MOVK  X15, #0x400, LSL #48
    FMOV  X8, D12
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x8089, LSL #0
    MOVK  X15, #0xfe, LSL #16
    FMOV  X8, V13.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x407f, LSL #0
    MOVK  X15, #0x10b, LSL #16
    FMOV  X8, D13
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xf, LSL #16
    MOVK  X15, #0x1, LSL #32
    MOVK  X15, #0x10, LSL #48
    FMOV  X8, V14.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x4950, LSL #0
    MOVK  X15, #0x5065, LSL #16
    MOVK  X15, #0xfd04, LSL #32
    FMOV  X8, D14
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0xfffe, LSL #0
    MOVK  X15, #0x2f, LSL #16
    MOVK  X15, #0xfffe, LSL #32
    MOVK  X15, #0x1, LSL #48
    FMOV  X8, V15.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0x1, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0x1, LSL #48
    FMOV  X8, D15
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0xd0, LSL #0
    MOVK  X15, #0xac8f, LSL #16
    MOVK  X15, #0x150e, LSL #32
    MOVK  X15, #0x8d96, LSL #48
    FMOV  X8, V16.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0xb92a, LSL #0
    MOVK  X15, #0xce3, LSL #16
    MOVK  X15, #0x43b, LSL #32
    MOVK  X15, #0xfb66, LSL #48
    FMOV  X8, D16
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V17.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x3030, LSL #16
    FMOV  X8, D17
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V18.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X8, D18
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X8, V19.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X8, D19
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V20.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x303, LSL #0
    MOVK  X15, #0x303, LSL #32
    FMOV  X8, D20
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x40, LSL #0
    MOVK  X15, #0x40, LSL #48
    FMOV  X8, V21.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X8, D21
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V22.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7f7f, LSL #16
    MOVK  X15, #0x7f7f, LSL #32
    MOVK  X15, #0x7f7f, LSL #48
    FMOV  X8, D22
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V23.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x4770, LSL #0
    MOVK  X15, #0x3085, LSL #16
    MOVK  X15, #0xfd03, LSL #32
    FMOV  X8, D23
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V24.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, D24
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0xd391, LSL #0
    MOVK  X15, #0x1, LSL #32
    FMOV  X8, V25.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xfe96, LSL #32
    FMOV  X8, D25
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V26.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, D26
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0xc9db, LSL #0
    MOVK  X15, #0xb894, LSL #16
    MOVK  X15, #0x9df2, LSL #32
    MOVK  X15, #0x682d, LSL #48
    FMOV  X8, V27.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x2eed, LSL #0
    MOVK  X15, #0xda22, LSL #16
    MOVK  X15, #0x380e, LSL #32
    MOVK  X15, #0x6bf4, LSL #48
    FMOV  X8, D27
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V28.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, D28
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V29.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X8, D29
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x1fdf, LSL #0
    MOVK  X15, #0x1fe0, LSL #16
    MOVK  X15, #0x1, LSL #32
    FMOV  X8, V30.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x1e0, LSL #0
    MOVK  X15, #0x1fe0, LSL #16
    MOVK  X15, #0x1, LSL #32
    FMOV  X8, D30
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V31.D[1]
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, D31
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorUnsignedOperation_TestFail
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
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X22
    FMOV  V0.D[1], X23
    FMOV  D1, X15
    FMOV  V1.D[1], X27
    FMOV  D2, X13
    FMOV  V2.D[1], X24
    FMOV  D3, X17
    FMOV  V3.D[1], X14
    FMOV  D4, X6
    FMOV  V4.D[1], X16
    FMOV  D5, X29
    FMOV  V5.D[1], X28
    FMOV  D6, X25
    FMOV  V6.D[1], X17
    FMOV  D7, X12
    FMOV  V7.D[1], X20
    FMOV  D8, X5
    FMOV  V8.D[1], X9
    FMOV  D9, X2
    FMOV  V9.D[1], X12
    FMOV  D10, X2
    FMOV  V10.D[1], X21
    FMOV  D11, X14
    FMOV  V11.D[1], X2
    FMOV  D12, X5
    FMOV  V12.D[1], X25
    FMOV  D13, X25
    FMOV  V13.D[1], X4
    FMOV  D14, X13
    FMOV  V14.D[1], X5
    FMOV  D15, X12
    FMOV  V15.D[1], X23
    FMOV  D16, X13
    FMOV  V16.D[1], X3
    FMOV  D17, X25
    FMOV  V17.D[1], X29
    FMOV  D18, X16
    FMOV  V18.D[1], X5
    FMOV  D19, X20
    FMOV  V19.D[1], X21
    FMOV  D20, X22
    FMOV  V20.D[1], X13
    FMOV  D21, X3
    FMOV  V21.D[1], X27
    FMOV  D22, X4
    FMOV  V22.D[1], X15
    FMOV  D23, X21
    FMOV  V23.D[1], X13
    FMOV  D24, X17
    FMOV  V24.D[1], X13
    FMOV  D25, X20
    FMOV  V25.D[1], X7
    FMOV  D26, X5
    FMOV  V26.D[1], X27
    FMOV  D27, X12
    FMOV  V27.D[1], X23
    FMOV  D28, X5
    FMOV  V28.D[1], X24
    FMOV  D29, X14
    FMOV  V29.D[1], X16
    FMOV  D30, X24
    FMOV  V30.D[1], X16
    FMOV  D31, X23
    FMOV  V31.D[1], X4
    MOVZ  X6, #0xf, LSL #0
TSRTAdvsimdVectorUnsignedOperation_label_13:
    USUBW2  V5.2D, V23.2D, V23.4S
    UADDW2  V6.2D, V27.2D, V31.4S
    UQRSHRN V9.8B, V28.8H, #3
    USRA  V1.4S, V19.4S, #9
    UADDLV  H15, V30.16B
    URSHL  V20.16B, V1.16B, V15.16B
    UMULL  V18.8H, V20.8B, V26.8B
    UXTL2 V4.8H, V5.16B
    UQRSHRN2 V28.8H, V4.4S, #3
    URSHR  V22.8H, V18.8H, #5
    USHR  V29.8B, V22.8B, #4
    UABDL2  V2.4S, V6.8H, V28.8H
    UQSHRN2 V5.8H, V9.4S, #5
    UMULL2 V26.4S, V2.8H, V5.H[0x5]
    UQADD  V20.8B, V26.8B, V26.8B
    URSHR  V9.4H, V29.4H, #3
    UABDL2  V5.8H, V20.16B, V25.16B
    UADDW  V19.2D, V5.2D, V9.2S
    USRA  V4.8B, V28.8B, #5
    UHSUB  V20.4S, V29.4S, V31.4S
    UADDLV  S31, V28.4H
    USHR V28.2D, V25.2D, #23
    UMOV W3, V18.H[0x4]
    UQSHRN V27.8B, V23.8H, #4
    UMLAL2  V23.2D, V27.4S, V7.4S
    UADDW  V26.8H, V22.8H, V27.8B
    UHADD  V30.8H, V3.8H, V20.8H
    URSHR  V3.8B, V28.8B, #1
    UQSHL V22.2D, V4.2D, #0x17
    URSHR  V4.16B, V7.16B, #2
    URSHR  V6.2S, V10.2S, #9
    URSHR  V2.4H, V23.4H, #7
    UMOV X14, V2.D[0x0]
    UABAL2  V9.4S, V19.8H, V31.8H
    USHLL V2.4S, V6.4H, #0x7
    UHSUB  V28.8B, V30.8B, V4.8B
    URSHR  V20.8H, V26.8H, #14
    URSQRTE  V10.4S, V22.4S
    URSHL  V7.4H, V10.4H, V3.4H
    UQSHL  V5.4S, V20.4S, #0x1d
    UMOV W4, V9.S[0x0]
    USHLL2 V23.8H, V23.16B, #0x7
    UQSHRN V18.2S, V28.2D, #5
    UMLSL  V22.4S, V23.4H, V7.4H
    URHADD  V9.8H, V5.8H, V2.8H
    UXTL2 V20.8H, V30.16B
    UMOV W22, V18.B[0xa]
    USUBL  V4.4S, V22.4H, V20.4H
    URSRA  V29.4S, V9.4S, #8
    UHADD  V7.8B, V4.8B, V29.8B
    UMLSL2 V26.4S, V15.8H, V4.H[0x0]
    USRA V27.2D, V25.2D, #23
    UQRSHRN2 V10.8H, V26.4S, #10
    UABAL2  V22.2D, V9.4S, V3.4S
    UQRSHRN2 V25.4S, V27.2D, #6
    UADDL  V29.2D, V25.2S, V10.2S
    UQRSHRN V20.2S, V5.2D, #7
    UMLSL2 V27.4S, V13.8H, V7.H[0x2]
    UMOV X5, V21.D[0x0]
    UMLAL2 V18.4S, V18.8H, V2.H[0x6]
    USRA  V6.16B, V27.16B, #6
    UQRSHRN2 V10.4S, V24.2D, #6
    UQSHRN2 V2.16B, V28.8H, #7
    UQRSHL  V15.4H, V27.4H, V6.4H
    USHLL V4.4S, V29.4H, #0x5
    UMLSL  V28.8H, V5.8B, V27.8B
    USHLL2 V5.2D, V5.4S, #0x1
    UQSHRN2 V29.8H, V18.4S, #15
    UABAL2  V26.8H, V20.16B, V28.16B
    USQADD  V27.4H, V15.4H
    USHLL V6.2D, V22.2S, #0x1a
    UMLSL2  V21.8H, V26.16B, V27.16B
    URECPE  V7.4S, V29.4S
    USHR  V28.16B, V4.16B, #5
    UQXTN  V25.8B, V26.8H
    UMLAL2 V24.2D, V6.4S, V28.S[0x1]
    UMULL  V13.8H, V23.8B, V25.8B
    USHR  V23.4S, V7.4S, #18
    UADDLV  H18, V24.8B
    UMLAL2  V24.4S, V5.8H, V10.8H
    UQSHRN V26.2S, V2.2D, #30
    UQSHL  V5.4S, V13.4S, #0xf
    UXTL2 V7.8H, V5.16B
    UMOV W10, V7.B[0xa]
    UABAL  V25.2D, V23.2S, V21.2S
    UABA  V29.8B, V22.8B, V18.8B
    UADDW2  V18.2D, V24.2D, V24.4S
    UQSHRN2 V10.16B, V26.8H, #2
    UQSUB  V26.16B, V10.16B, V29.16B
    USHLL2 V22.2D, V26.4S, #0x13
    UMLSL2 V29.2D, V22.4S, V18.S[0x2]
    UMLSL2 V26.2D, V25.4S, V25.S[0x0]
    UQRSHRN2 V2.16B, V29.8H, #8
    UMLSL  V13.2D, V29.2S, V26.2S
    UQRSHRN V6.4H, V2.4S, #1
    USHLL2 V5.2D, V6.4S, #0x15
    USRA V7.2D, V13.2D, #16
    UABAL2  V26.4S, V5.8H, V7.8H
    UQSHL  V23.4S, V9.4S, #0x2
    UQXTN  V9.4H, V17.4S
    URSRA V13.2D, V10.2D, #22
    UABDL  V6.8H, V4.8B, V13.8B
    UQSHRN2 V28.8H, V16.4S, #2
    URSRA V7.2D, V30.2D, #42
    UQSHL  V5.8B, V8.8B, V21.8B
    UMOV W25, V1.B[0x2]
    URSHR  V17.4H, V6.4H, #15
    UXTL2 V6.2D, V26.4S
    UQSHRN2 V16.8H, V17.4S, #11
    UADDLV  D10, V21.4S
    UADDW  V22.2D, V3.2D, V27.2S
    UMLSL V13.2D, V10.2S, V6.S[0x1]
    UMULL V4.4S, V23.4H, V13.H[0x1]
    UADDL  V6.8H, V4.8B, V16.8B
    UMLAL V2.2D, V9.2S, V5.S[0x3]
    UADDL2  V16.8H, V6.16B, V2.16B
    UQRSHRN2 V27.4S, V22.2D, #25
    UQRSHRN2 V10.16B, V27.8H, #1
    UQADD  V3.2D, V12.2D, V10.2D
    UADALP  V29.2D, V28.4S
    UQXTN  V6.8B, V16.8H
    UQSHL  V27.8B, V7.8B, #0x3
    USQADD  V14.8H, V3.8H
    UADDW  V17.4S, V21.4S, V27.4H
    USUBW2  V16.2D, V29.2D, V17.4S
    URSHR  V26.4S, V16.4S, #11
    UHADD  V28.8B, V6.8B, V26.8B
    UABDL2  V12.8H, V14.16B, V14.16B
    UMLSL2  V14.4S, V12.8H, V28.8H
    UMULL2 V23.4S, V26.8H, V0.H[0x6]
    UHADD  V16.8H, V24.8H, V1.8H
    USHLL2 V7.2D, V20.4S, #0x12
    UMULL2  V27.8H, V22.16B, V26.16B
    UMULL  V8.2D, V7.2S, V18.2S
    UQSHRN2 V22.16B, V30.8H, #3
    UMLAL V2.4S, V11.4H, V12.H[0x5]
    UMLAL2 V1.2D, V1.4S, V12.S[0x0]
    UHADD  V20.4S, V20.4S, V10.4S
    UQXTN  V30.4H, V16.4S
    USUBW2  V0.8H, V14.8H, V8.16B
    USUBW  V17.2D, V22.2D, V23.2S
    USHLL2 V13.8H, V18.16B, #0x2
    UQRSHRN2 V18.4S, V20.2D, #19
    UMLAL2 V23.4S, V18.8H, V14.H[0x7]
    UXTL V29.8H, V13.8B
    USUBW2  V24.4S, V1.4S, V21.8H
    UMULL2 V20.2D, V0.4S, V27.S[0x0]
    UHSUB  V28.4S, V20.4S, V29.4S
    USRA  V12.8H, V2.8H, #9
    UQRSHL  V26.4H, V12.4H, V17.4H
    USHLL V17.2D, V6.2S, #0x1b
    UQRSHL  V10.2D, V30.2D, V30.2D
    UQSHRN V30.4H, V19.4S, #1
    UXTL2 V7.4S, V28.8H
    UQSHRN2 V28.8H, V23.4S, #15
    UMLSL V6.4S, V24.4H, V11.H[0x0]
    UMULL  V14.8H, V26.8B, V10.8B
    USHLL2 V8.8H, V7.16B, #0x4
    UXTL2 V30.2D, V30.4S
    USUBW2  V7.4S, V17.4S, V30.8H
    USHR  V22.8H, V29.8H, #8
    UXTL2 V11.2D, V28.4S
    UABAL2  V12.4S, V14.8H, V11.8H
    UADALP  V29.8H, V12.16B
    UMULL2 V11.4S, V8.8H, V6.H[0x6]
    UMLSL2 V19.4S, V11.8H, V11.H[0x4]
    UABA  V10.16B, V28.16B, V19.16B
    UMLAL2  V28.4S, V7.8H, V10.8H
    UQSHL  V14.8B, V28.8B, #0x4
    UADDLV  S19, V22.4H
    UABDL2  V6.4S, V14.8H, V7.8H
    UXTL2 V12.4S, V29.8H
    UADDW  V29.4S, V19.4S, V19.4H
    USRA V22.2D, V12.2D, #30
    UABDL  V2.4S, V6.4H, V6.4H
    UMLSL2 V26.4S, V2.8H, V6.H[0x6]
    UADDL2  V11.4S, V26.8H, V22.8H
    URSHL  V7.8H, V11.8H, V29.8H
    UQRSHRN2 V29.8H, V12.4S, #10
    UQSHL  V8.16B, V26.16B, #0x7
    UQSUB  V2.4S, V2.4S, V17.4S
    URSRA  V26.2S, V1.2S, #29
    UQSHL  V30.4S, V0.4S, V0.4S
    USHR  V19.8H, V12.8H, #13
    UABDL  V11.4S, V17.4H, V5.4H
    UMLSL V28.2D, V19.2S, V2.S[0x2]
    UQRSHRN2 V17.8H, V23.4S, #1
    USHR  V1.8B, V16.8B, #5
    USRA V12.2D, V26.2D, #57
    UABA  V0.8B, V28.8B, V29.8B
    UMULL V6.2D, V23.2S, V0.S[0x3]
    URHADD  V14.2S, V6.2S, V7.2S
    UQSHRN V22.2S, V8.2D, #32
    UABAL2  V28.8H, V22.16B, V30.16B
    UMLSL V5.2D, V30.2S, V11.S[0x0]
    USHLL V19.8H, V1.8B, #0x3
    UMLSL V22.2D, V5.2S, V19.S[0x0]
    UABAL2  V2.4S, V28.8H, V28.8H
    UABDL2  V29.2D, V22.4S, V22.4S
    UMOV W24, V17.S[0x3]
    SUBS  X6, X6, #0x1
    B.NE  TSRTAdvsimdVectorUnsignedOperation_label_13
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x800, LSL #16
    MRS  X12, FPSR
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V0.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, D0
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V1.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, D1
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V2.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, D2
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V3.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, D3
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V4.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x6800, LSL #16
    MOVK  X8, #0xd000, LSL #32
    MOVK  X8, #0x1a, LSL #48
    FMOV  X12, D4
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V5.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0xff, LSL #0
    FMOV  X12, D5
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V6.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, D6
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V7.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, D7
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V8.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0xff, LSL #0
    FMOV  X12, D8
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V9.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xffff, LSL #16
    FMOV  X12, D9
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V10.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0xff, LSL #0
    MOVK  X8, #0x3f, LSL #16
    FMOV  X12, D10
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x8002, LSL #0
    MOVK  X8, #0x6, LSL #32
    FMOV  X12, V11.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0xff, LSL #0
    FMOV  X12, D11
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V12.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, D12
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V13.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, D13
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V14.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, D14
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V15.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, D15
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V16.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, D16
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V17.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8002, LSL #32
    MOVK  X8, #0x6, LSL #48
    FMOV  X12, D17
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V18.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, D18
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V19.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, D19
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V20.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, D20
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V21.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, D21
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V22.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, D22
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V23.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, D23
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V24.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, D24
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x3fff, LSL #0
    FMOV  X12, V25.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x3fff, LSL #0
    FMOV  X12, D25
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V26.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x60, LSL #0
    FMOV  X12, D26
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V27.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, D27
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V28.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, D28
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V29.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, D29
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V30.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, D30
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, V31.D[1]
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X12, D31
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorUnsignedOperation_TestFail
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
    FMOV  V0.D[1], X25
    FMOV  D1, X24
    FMOV  V1.D[1], X28
    FMOV  D2, X29
    FMOV  V2.D[1], X15
    FMOV  D3, X21
    FMOV  V3.D[1], X16
    FMOV  D4, X27
    FMOV  V4.D[1], X14
    FMOV  D5, X4
    FMOV  V5.D[1], X2
    FMOV  D6, X22
    FMOV  V6.D[1], X10
    FMOV  D7, X24
    FMOV  V7.D[1], X15
    FMOV  D8, X22
    FMOV  V8.D[1], X24
    FMOV  D9, X7
    FMOV  V9.D[1], X7
    FMOV  D10, X25
    FMOV  V10.D[1], X13
    FMOV  D11, X15
    FMOV  V11.D[1], X15
    FMOV  D12, X20
    FMOV  V12.D[1], X24
    FMOV  D13, X15
    FMOV  V13.D[1], X27
    FMOV  D14, X15
    FMOV  V14.D[1], X4
    FMOV  D15, X5
    FMOV  V15.D[1], X17
    FMOV  D16, X27
    FMOV  V16.D[1], X20
    FMOV  D17, X22
    FMOV  V17.D[1], X8
    FMOV  D18, X8
    FMOV  V18.D[1], X16
    FMOV  D19, X8
    FMOV  V19.D[1], X4
    FMOV  D20, X13
    FMOV  V20.D[1], X23
    FMOV  D21, X14
    FMOV  V21.D[1], X7
    FMOV  D22, X5
    FMOV  V22.D[1], X28
    FMOV  D23, X15
    FMOV  V23.D[1], X20
    FMOV  D24, X21
    FMOV  V24.D[1], X8
    FMOV  D25, X7
    FMOV  V25.D[1], X16
    FMOV  D26, X15
    FMOV  V26.D[1], X4
    FMOV  D27, X27
    FMOV  V27.D[1], X24
    FMOV  D28, X12
    FMOV  V28.D[1], X4
    FMOV  D29, X25
    FMOV  V29.D[1], X8
    FMOV  D30, X25
    FMOV  V30.D[1], X29
    FMOV  D31, X23
    FMOV  V31.D[1], X17
    MOVZ  X22, #0xf, LSL #0
TSRTAdvsimdVectorUnsignedOperation_label_14:
    USHL  V28.2S, V23.2S, V25.2S
    UMOV W16, V28.S[0x2]
    UABDL  V23.2D, V20.2S, V29.2S
    UQRSHRN V19.4H, V31.4S, #2
    UMOV W5, V30.H[0x1]
    UMLSL2 V19.4S, V27.8H, V1.H[0x0]
    UMOV W14, V19.S[0x2]
    USHR V14.2D, V23.2D, #36
    USUBL2  V30.8H, V26.16B, V14.16B
    USHL  V5.2D, V30.2D, V30.2D
    UMULL  V8.2D, V24.2S, V5.2S
    UMULL V16.4S, V8.4H, V8.H[0x0]
    UABD  V26.2S, V16.2S, V16.2S
    UQSHRN2 V25.4S, V17.2D, #25
    UXTL2 V27.8H, V21.16B
    UMLAL2 V17.2D, V26.4S, V24.S[0x0]
    UQRSHRN V1.4H, V20.4S, #12
    UHSUB  V24.4H, V12.4H, V25.4H
    UADDL  V19.8H, V26.8B, V8.8B
    USHR  V16.4H, V24.4H, #11
    UQSHL  V12.2D, V29.2D, V31.2D
    UMLAL V28.2D, V23.2S, V22.S[0x3]
    USQADD  V29.8H, V8.8H
    UQSHRN2 V24.16B, V15.8H, #4
    UQSHRN V5.2S, V1.2D, #20
    UQRSHRN2 V20.16B, V28.8H, #1
    UMULL V14.4S, V24.4H, V5.H[0x3]
    URSRA  V22.4S, V16.4S, #27
    UXTL V30.2D, V22.2S
    UXTL V5.4S, V17.4H
    USRA V1.2D, V10.2D, #51
    USRA  V10.16B, V30.16B, #8
    UQSHRN2 V15.8H, V19.4S, #14
    UADDW  V21.2D, V29.2D, V5.2S
    UMLSL2  V28.4S, V12.8H, V12.8H
    UQXTN  V5.8B, V1.8H
    UQSHL  V24.2S, V14.2S, #0x1f
    UXTL V26.8H, V21.8B
    UQSHRN2 V12.16B, V20.8H, #4
    USUBW  V20.2D, V12.2D, V28.2S
    URSRA V14.2D, V10.2D, #3
    UHSUB  V16.8H, V14.8H, V24.8H
    UQSHRN V8.4H, V20.4S, #3
    USRA  V30.4S, V8.4S, #24
    UMLAL2 V25.4S, V15.8H, V15.H[0x7]
    UMOV W20, V30.B[0xf]
    UQRSHRN2 V14.8H, V5.4S, #1
    UQRSHRN2 V29.4S, V14.2D, #1
    URSHR  V28.16B, V16.16B, #6
    UXTL V14.8H, V25.8B
    UQSHRN2 V16.4S, V2.2D, #31
    USHR  V22.4S, V27.4S, #5
    UABDL2  V8.2D, V29.4S, V22.4S
    UADALP  V30.4H, V8.8B
    UQSHL  V17.8H, V14.8H, #0x1
    USUBW  V14.8H, V28.8H, V30.8B
    UQXTN  V30.2S, V26.2D
    UMLAL2 V19.4S, V16.8H, V12.H[0x0]
    UADDW2  V24.4S, V19.4S, V17.8H
    UQRSHRN2 V12.4S, V14.2D, #4
    UQRSHRN2 V14.8H, V30.4S, #13
    UADDW2  V30.4S, V14.4S, V24.8H
    USHLL2 V17.2D, V12.4S, #0xb
    UMLSL2 V26.2D, V17.4S, V30.S[0x2]
    UQSHRN V28.2S, V14.2D, #31
    UHSUB  V22.4S, V21.4S, V21.4S
    UQSHL  V25.8B, V30.8B, #0x1
    UXTL V24.8H, V25.8B
    URSHR  V27.2S, V0.2S, #11
    UADDLV  S12, V1.8H
    USRA  V19.2S, V8.2S, #26
    USHLL2 V16.2D, V10.4S, #0x1f
    UXTL2 V21.2D, V12.4S
    UXTL2 V25.2D, V21.4S
    USHLL2 V15.2D, V4.4S, #0x1
    URSHR V0.2D, V19.2D, #52
    USHR V17.2D, V22.2D, #15
    URSHR  V12.4S, V26.4S, #28
    UABDL2  V10.4S, V15.8H, V28.8H
    UQSHL V4.2D, V17.2D, #0x10
    UMULL V21.4S, V27.4H, V10.H[0x7]
    URHADD  V10.4H, V23.4H, V21.4H
    URSHR  V21.2S, V24.2S, #26
    UQRSHRN2 V24.8H, V19.4S, #16
    UMULL2  V5.4S, V12.8H, V24.8H
    USHL  V1.4S, V4.4S, V11.4S
    URHADD  V24.8H, V16.8H, V25.8H
    URSRA  V22.8B, V0.8B, #7
    UMOV W23, V10.H[0x5]
    UMLSL2 V8.2D, V22.4S, V1.S[0x1]
    UABD  V27.2S, V24.2S, V24.2S
    UMLAL2  V23.4S, V8.8H, V21.8H
    UQSHRN2 V26.8H, V23.4S, #15
    UQSUB  V24.2D, V5.2D, V27.2D
    UMLAL V14.4S, V26.4H, V3.H[0x6]
    UMOV X28, V14.D[0x1]
    UMLSL V28.2D, V15.2S, V21.S[0x1]
    UMLAL2 V4.2D, V1.4S, V6.S[0x1]
    UMLAL V0.2D, V25.2S, V6.S[0x2]
    USHLL2 V5.4S, V2.8H, #0x2
    UABD  V8.8B, V7.8B, V25.8B
    UABA  V22.4S, V11.4S, V22.4S
    UMLSL V14.2D, V9.2S, V22.S[0x3]
    UADDLV  D7, V13.4S
    USRA  V1.4H, V31.4H, #9
    UMLAL V25.4S, V24.4H, V14.H[0x2]
    UQXTN2  V26.16B, V25.8H
    UQRSHRN V23.2S, V28.2D, #13
    UABA  V10.8H, V17.8H, V4.8H
    UADDLP  V3.1D, V26.2S
    UXTL2 V26.4S, V1.8H
    UADDLV  S11, V23.8H
    USHLL2 V1.2D, V10.4S, #0xd
    UQXTN2  V9.16B, V26.8H
    USHR  V31.8H, V0.8H, #13
    UQRSHRN V23.4H, V8.4S, #5
    UMLSL2  V13.2D, V9.4S, V7.4S
    UMOV W20, V31.S[0x2]
    URSHR  V7.2S, V3.2S, #21
    USHL  V26.4H, V5.4H, V11.4H
    UABAL  V24.2D, V1.2S, V1.2S
    URSHL  V10.8B, V23.8B, V7.8B
    UADDL2  V0.8H, V10.16B, V13.16B
    UQSHL  V5.8H, V26.8H, #0xb
    UMLSL2  V17.2D, V0.4S, V5.4S
    UMULL V3.4S, V24.4H, V15.H[0x1]
    UQRSHL  V31.2D, V17.2D, V3.2D
    USHL  V8.8H, V22.8H, V4.8H
    UQXTN2  V17.16B, V8.8H
    UQSHRN2 V15.8H, V28.4S, #1
    UMULL V11.2D, V2.2S, V23.S[0x1]
    USHR  V4.4S, V25.4S, #22
    URSHR  V25.8H, V12.8H, #15
    URSQRTE  V0.2S, V19.2S
    UABA  V23.4S, V9.4S, V31.4S
    UQSHL V5.2D, V0.2D, #0x35
    URSHR  V2.4S, V1.4S, #23
    UXTL V28.8H, V30.8B
    USHLL2 V19.4S, V28.8H, #0x4
    UMULL V14.2D, V4.2S, V4.S[0x0]
    UQSHL  V30.8B, V5.8B, #0x6
    URSHR  V1.2S, V23.2S, #26
    URHADD  V10.16B, V25.16B, V17.16B
    UMLSL V12.2D, V19.2S, V1.S[0x0]
    URSHL  V5.2S, V30.2S, V12.2S
    UMLAL  V4.2D, V2.2S, V10.2S
    UMLSL  V2.4S, V14.4H, V14.4H
    USUBL2  V0.4S, V11.8H, V4.8H
    UADDLV  D31, V2.4S
    UXTL V12.2D, V5.2S
    UQRSHRN2 V24.4S, V0.2D, #7
    UQSHRN2 V14.16B, V24.8H, #1
    UQSHL  V28.4H, V31.4H, V12.4H
    UHSUB  V23.8H, V14.8H, V14.8H
    URECPE  V9.4S, V23.4S
    UQRSHL  V24.2S, V28.2S, V15.2S
    UQSHL V22.2D, V9.2D, #0x8
    UMULL  V5.4S, V24.4H, V22.4H
    UABDL  V8.8H, V14.8B, V17.8B
    UQSHL V30.2D, V4.2D, #0x1
    UXTL V1.8H, V6.8B
    UMLAL2 V6.2D, V11.4S, V22.S[0x0]
    USHLL2 V28.8H, V28.16B, #0x4
    UMLSL2  V25.4S, V28.8H, V20.8H
    UQRSHRN V14.8B, V0.8H, #5
    UXTL V17.2D, V15.2S
    UMULL2 V9.4S, V11.8H, V14.H[0x0]
    USRA  V23.8B, V28.8B, #7
    UMLAL2 V12.2D, V6.4S, V10.S[0x3]
    USHLL V4.4S, V5.4H, #0x6
    UADDLP  V24.8H, V23.16B
    URECPE  V20.2S, V30.2S
    UHSUB  V6.2S, V25.2S, V1.2S
    USHR V14.2D, V9.2D, #50
    USRA  V9.4H, V17.4H, #3
    URSRA  V2.8H, V0.8H, #13
    URSRA  V10.8H, V12.8H, #7
    URSHR  V15.8B, V20.8B, #5
    UQSHL  V31.2S, V2.2S, #0x1e
    UMLSL V17.2D, V24.2S, V4.S[0x1]
    UQRSHRN2 V5.16B, V10.8H, #7
    URSRA  V10.2S, V15.2S, #8
    UMLSL2  V11.8H, V14.16B, V9.16B
    USQADD  V24.4S, V6.4S
    UMLSL2  V15.4S, V10.8H, V24.8H
    UADDL  V25.4S, V8.4H, V17.4H
    URSRA V28.2D, V31.2D, #37
    UADALP  V10.4H, V25.8B
    UXTL V1.2D, V15.2S
    USUBW  V22.8H, V28.8H, V23.8B
    USRA  V15.4H, V22.4H, #1
    UMOV W28, V11.H[0x5]
    UMLAL V17.2D, V1.2S, V5.S[0x1]
    USUBW2  V31.4S, V17.4S, V10.8H
    UQRSHL  V10.2S, V31.2S, V31.2S
    URSHR  V30.2S, V15.2S, #9
    URSRA V24.2D, V10.2D, #38
    UQSHL V1.2D, V1.2D, #0x25
    URSHL  V10.4S, V1.4S, V1.4S
    USUBL  V15.4S, V24.4H, V10.4H
    SUBS  X22, X22, #0x1
    B.NE  TSRTAdvsimdVectorUnsignedOperation_label_14
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x4, LSL #0
    SUB  X7, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x800, LSL #16
    MRS  X7, FPSR
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V0.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D0
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X7, V1.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X7, D1
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V2.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D2
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V3.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D3
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V4.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D4
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x404, LSL #0
    MOVK  X17, #0x404, LSL #32
    FMOV  X7, V5.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D5
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V6.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x7faa, LSL #0
    MOVK  X17, #0xffc0, LSL #16
    MOVK  X17, #0x7fa0, LSL #32
    MOVK  X17, #0xff80, LSL #48
    FMOV  X7, D6
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V7.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x10, LSL #0
    FMOV  X7, D7
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V8.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D8
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V9.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D9
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x8000, LSL #16
    MOVK  X17, #0x8000, LSL #48
    FMOV  X7, V10.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x8000, LSL #16
    MOVK  X17, #0x8000, LSL #48
    FMOV  X7, D10
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V11.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D11
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    FMOV  X7, V12.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    FMOV  X7, D12
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X7, V13.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X7, D13
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V14.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D14
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x8000, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X7, V15.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x8000, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X7, D15
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x4000, LSL #48
    FMOV  X7, V16.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x4000, LSL #48
    FMOV  X7, D16
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V17.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D17
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X7, V18.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X7, D18
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xff0, LSL #0
    MOVK  X17, #0xff0, LSL #32
    FMOV  X7, V19.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x20, LSL #0
    MOVK  X17, #0xff0, LSL #32
    FMOV  X7, D19
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V20.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X7, D20
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V21.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D21
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V22.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D22
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V23.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D23
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V24.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D24
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V25.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D25
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V26.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D26
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V27.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D27
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V28.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D28
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0x4040, LSL #32
    MOVK  X17, #0x40, LSL #48
    FMOV  X7, V29.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0x807d, LSL #32
    MOVK  X17, #0x807e, LSL #48
    FMOV  X7, D29
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V30.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x404, LSL #0
    MOVK  X17, #0x4, LSL #16
    MOVK  X17, #0x404, LSL #32
    MOVK  X17, #0x4, LSL #48
    FMOV  X7, D30
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V31.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D31
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x850, LSL #0
    MOVK  X2, #0xfaa1, LSL #16
    MOVK  X2, #0xb63f, LSL #32
    MOVK  X2, #0xa59c, LSL #48
    MOVZ  X3, #0xf7d3, LSL #0
    MOVK  X3, #0x710e, LSL #16
    MOVK  X3, #0x79ed, LSL #32
    MOVK  X3, #0x130d, LSL #48
    MOVZ  X4, #0x9d12, LSL #0
    MOVK  X4, #0x3294, LSL #16
    MOVK  X4, #0x5bca, LSL #32
    MOVK  X4, #0xded7, LSL #48
    MOVZ  X5, #0x556f, LSL #0
    MOVK  X5, #0x84c7, LSL #16
    MOVK  X5, #0x9246, LSL #32
    MOVK  X5, #0xb5e5, LSL #48
    MOVZ  X6, #0x940b, LSL #0
    MOVK  X6, #0xc4ae, LSL #16
    MOVK  X6, #0x23e6, LSL #32
    MOVK  X6, #0xe613, LSL #48
    MOVZ  X7, #0xe177, LSL #0
    MOVK  X7, #0xb9ad, LSL #16
    MOVK  X7, #0x819b, LSL #32
    MOVK  X7, #0x652f, LSL #48
    MOVZ  X8, #0xbcc0, LSL #0
    MOVK  X8, #0x38d7, LSL #16
    MOVK  X8, #0xcbdb, LSL #32
    MOVK  X8, #0x4fe9, LSL #48
    MOVZ  X9, #0x71de, LSL #0
    MOVK  X9, #0x88e5, LSL #16
    MOVK  X9, #0x3f0, LSL #32
    MOVK  X9, #0xaccf, LSL #48
    MOVZ  X10, #0xbb7, LSL #0
    MOVK  X10, #0x3bbf, LSL #16
    MOVK  X10, #0x26a9, LSL #32
    MOVK  X10, #0x39c7, LSL #48
    MOVZ  X12, #0xd6e1, LSL #0
    MOVK  X12, #0x5e5b, LSL #16
    MOVK  X12, #0xd3b2, LSL #32
    MOVK  X12, #0xd25f, LSL #48
    MOVZ  X13, #0x6342, LSL #0
    MOVK  X13, #0x6cf4, LSL #16
    MOVK  X13, #0xa3e8, LSL #32
    MOVK  X13, #0xd8b0, LSL #48
    MOVZ  X14, #0xbde7, LSL #0
    MOVK  X14, #0x9a33, LSL #16
    MOVK  X14, #0xc9e9, LSL #32
    MOVK  X14, #0xa6aa, LSL #48
    MOVZ  X15, #0x5331, LSL #0
    MOVK  X15, #0x2741, LSL #16
    MOVK  X15, #0x28a3, LSL #32
    MOVK  X15, #0xb395, LSL #48
    MOVZ  X16, #0x32c6, LSL #0
    MOVK  X16, #0xdebc, LSL #16
    MOVK  X16, #0xf9ea, LSL #32
    MOVK  X16, #0x7090, LSL #48
    MOVZ  X17, #0x7b9, LSL #0
    MOVK  X17, #0xebdc, LSL #16
    MOVK  X17, #0x27cb, LSL #32
    MOVK  X17, #0xeb6c, LSL #48
    MOVZ  X20, #0x247f, LSL #0
    MOVK  X20, #0xa129, LSL #16
    MOVK  X20, #0xf018, LSL #32
    MOVK  X20, #0x74c9, LSL #48
    MOVZ  X21, #0xbac8, LSL #0
    MOVK  X21, #0xf44b, LSL #16
    MOVK  X21, #0x4ac3, LSL #32
    MOVK  X21, #0x584d, LSL #48
    MOVZ  X22, #0x6b66, LSL #0
    MOVK  X22, #0xf47e, LSL #16
    MOVK  X22, #0xff5e, LSL #32
    MOVK  X22, #0x176, LSL #48
    MOVZ  X23, #0x5f5e, LSL #0
    MOVK  X23, #0x7294, LSL #16
    MOVK  X23, #0x7199, LSL #32
    MOVK  X23, #0xe5ef, LSL #48
    MOVZ  X24, #0x59f7, LSL #0
    MOVK  X24, #0x64e, LSL #16
    MOVK  X24, #0x6953, LSL #32
    MOVK  X24, #0xc924, LSL #48
    MOVZ  X25, #0xb124, LSL #0
    MOVK  X25, #0xd9d5, LSL #16
    MOVK  X25, #0x2e43, LSL #32
    MOVK  X25, #0x49c8, LSL #48
    MOVZ  X27, #0x330d, LSL #0
    MOVK  X27, #0xc49d, LSL #16
    MOVK  X27, #0x67b8, LSL #32
    MOVK  X27, #0x8736, LSL #48
    MOVZ  X28, #0x55d4, LSL #0
    MOVK  X28, #0x6291, LSL #16
    MOVK  X28, #0x373c, LSL #32
    MOVK  X28, #0xdc49, LSL #48
    MOVZ  X29, #0xb394, LSL #0
    MOVK  X29, #0x5ef, LSL #16
    MOVK  X29, #0xe7f1, LSL #32
    MOVK  X29, #0x4bd8, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X21
    FMOV  D1, X25
    FMOV  V1.D[1], X28
    FMOV  D2, X29
    FMOV  V2.D[1], X27
    FMOV  D3, X2
    FMOV  V3.D[1], X29
    FMOV  D4, X17
    FMOV  V4.D[1], X15
    FMOV  D5, X7
    FMOV  V5.D[1], X24
    FMOV  D6, X20
    FMOV  V6.D[1], X2
    FMOV  D7, X28
    FMOV  V7.D[1], X4
    FMOV  D8, X24
    FMOV  V8.D[1], X25
    FMOV  D9, X17
    FMOV  V9.D[1], X21
    FMOV  D10, X3
    FMOV  V10.D[1], X21
    FMOV  D11, X15
    FMOV  V11.D[1], X21
    FMOV  D12, X12
    FMOV  V12.D[1], X4
    FMOV  D13, X14
    FMOV  V13.D[1], X9
    FMOV  D14, X10
    FMOV  V14.D[1], X5
    FMOV  D15, X23
    FMOV  V15.D[1], X28
    FMOV  D16, X29
    FMOV  V16.D[1], X28
    FMOV  D17, X25
    FMOV  V17.D[1], X14
    FMOV  D18, X3
    FMOV  V18.D[1], X12
    FMOV  D19, X24
    FMOV  V19.D[1], X17
    FMOV  D20, X3
    FMOV  V20.D[1], X7
    FMOV  D21, X21
    FMOV  V21.D[1], X17
    FMOV  D22, X20
    FMOV  V22.D[1], X12
    FMOV  D23, X4
    FMOV  V23.D[1], X10
    FMOV  D24, X16
    FMOV  V24.D[1], X24
    FMOV  D25, X5
    FMOV  V25.D[1], X13
    FMOV  D26, X12
    FMOV  V26.D[1], X22
    FMOV  D27, X29
    FMOV  V27.D[1], X23
    FMOV  D28, X6
    FMOV  V28.D[1], X13
    FMOV  D29, X15
    FMOV  V29.D[1], X6
    FMOV  D30, X25
    FMOV  V30.D[1], X27
    FMOV  D31, X2
    FMOV  V31.D[1], X22
    MOVZ  X25, #0xf, LSL #0
TSRTAdvsimdVectorUnsignedOperation_label_15:
    UADDLP  V14.2D, V28.4S
    UMULL2 V18.4S, V19.8H, V14.H[0x5]
    USRA  V25.4S, V30.4S, #1
    UHADD  V23.2S, V18.2S, V24.2S
    URSHR  V0.8H, V25.8H, #2
    UMULL  V26.4S, V23.4H, V23.4H
    UADDW  V9.4S, V26.4S, V31.4H
    URSRA  V10.8H, V29.8H, #3
    UQRSHRN2 V1.8H, V0.4S, #16
    UQSHRN V27.8B, V1.8H, #6
    USRA  V7.2S, V27.2S, #21
    UMLSL  V12.4S, V7.4H, V9.4H
    USHR  V9.8H, V12.8H, #7
    UADDLV  D27, V9.4S
    USUBL  V25.2D, V10.2S, V10.2S
    USUBW  V23.8H, V25.8H, V27.8B
    UQSHRN V9.2S, V4.2D, #9
    USUBW  V30.8H, V6.8H, V16.8B
    UMLAL2 V17.2D, V1.4S, V17.S[0x3]
    URECPE  V25.2S, V24.2S
    UADDLV  D24, V15.4S
    USUBW  V27.2D, V0.2D, V27.2S
    UMLAL V10.2D, V11.2S, V8.S[0x3]
    USQADD  V18.4S, V31.4S
    UQRSHRN V11.8B, V9.8H, #5
    USHLL2 V4.2D, V25.4S, #0x8
    UMLAL  V9.8H, V10.8B, V4.8B
    USHLL2 V7.4S, V30.8H, #0x3
    URSHR  V10.8H, V13.8H, #15
    USHLL2 V1.8H, V7.16B, #0x2
    USHLL2 V12.4S, V23.8H, #0xf
    UADDLV  H25, V10.16B
    UMLAL V13.4S, V25.4H, V1.H[0x1]
    UMLAL V31.4S, V11.4H, V9.H[0x2]
    UQSHL  V8.16B, V18.16B, V27.16B
    UQRSHRN V7.8B, V8.8H, #5
    UMULL  V0.4S, V17.4H, V12.4H
    URSHR V25.2D, V24.2D, #49
    USHLL2 V23.2D, V13.4S, #0x1
    USQADD  V27.8H, V23.8H
    UMLAL2  V17.8H, V7.16B, V27.16B
    UQXTN2  V7.16B, V17.8H
    UQXTN  V4.4H, V25.4S
    UADDW2  V30.8H, V4.8H, V4.16B
    UQRSHRN2 V1.4S, V31.2D, #31
    UMLSL V18.4S, V31.4H, V0.H[0x2]
    UQXTN2  V25.4S, V30.2D
    UQSHRN2 V15.8H, V7.4S, #12
    URSHR  V30.8B, V1.8B, #5
    UQADD  V31.4H, V30.4H, V15.4H
    UQXTN2  V12.4S, V31.2D
    UMLSL2 V1.4S, V12.8H, V12.H[0x5]
    USHL  V11.8B, V18.8B, V1.8B
    USUBW  V31.4S, V0.4S, V11.4H
    UMLAL V4.2D, V25.2S, V25.S[0x2]
    UADDL  V11.8H, V31.8B, V31.8B
    UADDLV  H7, V4.16B
    UABAL  V17.4S, V11.4H, V11.4H
    UQSHRN2 V27.16B, V17.8H, #3
    URSRA  V30.4S, V27.4S, #20
    UQRSHRN2 V12.8H, V7.4S, #8
    USHLL2 V0.4S, V12.8H, #0x6
    UMLSL V18.2D, V30.2S, V30.S[0x2]
    USHL  V27.2S, V18.2S, V0.2S
    UQSUB  V15.4S, V13.4S, V16.4S
    UMULL V4.2D, V26.2S, V5.S[0x3]
    USHLL2 V26.4S, V16.8H, #0x1
    UMLAL V13.2D, V10.2S, V3.S[0x2]
    USRA  V30.8H, V16.8H, #9
    URSRA V23.2D, V4.2D, #37
    UXTL2 V7.2D, V6.4S
    UQRSHRN2 V12.8H, V23.4S, #16
    UMLSL  V23.2D, V22.2S, V4.2S
    UADDW2  V11.8H, V19.8H, V29.16B
    UMOV W24, V7.B[0x2]
    UQSHRN V10.4H, V15.4S, #6
    UMLSL2 V0.4S, V11.8H, V13.H[0x5]
    UMLAL V16.4S, V30.4H, V12.H[0x3]
    USRA V1.2D, V23.2D, #6
    UADDL  V30.2D, V26.2S, V26.2S
    USRA  V6.2S, V10.2S, #21
    UMULL V18.2D, V27.2S, V30.S[0x1]
    URSRA  V3.4H, V0.4H, #11
    UQSHRN V17.8B, V27.8H, #4
    USUBL2  V25.8H, V6.16B, V6.16B
    USHLL2 V27.8H, V7.16B, #0x5
    UMLAL  V22.2D, V3.2S, V16.2S
    USHR  V29.8H, V1.8H, #13
    UQSUB  V5.16B, V25.16B, V18.16B
    USHR  V5.8H, V29.8H, #3
    UMULL V16.4S, V27.4H, V5.H[0x0]
    UQSHRN2 V12.4S, V22.2D, #28
    UABA  V22.2S, V12.2S, V17.2S
    UADALP  V29.2S, V16.4H
    USHR  V17.2S, V22.2S, #16
    UQSHL  V22.4H, V17.4H, #0x3
    USHR  V10.2S, V22.2S, #5
    UADALP  V27.2D, V23.4S
    USRA  V5.4H, V2.4H, #12
    USUBL2  V17.4S, V5.8H, V27.8H
    UQRSHRN V19.4H, V29.4S, #4
    UQXTN2  V1.4S, V19.2D
    UADDW  V12.4S, V17.4S, V1.4H
    URSHR V11.2D, V10.2D, #41
    UQSUB  V22.4S, V11.4S, V11.4S
    UQRSHRN V17.4H, V15.4S, #11
    UQRSHRN V3.8B, V23.8H, #6
    UQADD  V16.8B, V17.8B, V3.8B
    UADDL  V19.8H, V16.8B, V16.8B
    UQRSHRN2 V26.16B, V12.8H, #5
    USHR  V15.8B, V19.8B, #4
    USRA  V19.8H, V22.8H, #16
    UQRSHRN V25.8B, V26.8H, #5
    UABAL  V7.4S, V15.4H, V15.4H
    UMOV X7, V7.D[0x1]
    USUBW  V22.4S, V25.4S, V25.4H
    UQRSHRN V1.8B, V22.8H, #6
    UQSHRN V23.4H, V1.4S, #5
    UMOV W2, V23.S[0x1]
    URSRA V23.2D, V4.2D, #34
    UMOV W9, V29.B[0x3]
    URECPE  V12.4S, V21.4S
    USHR  V4.8B, V9.8B, #3
    UMULL V22.2D, V31.2S, V2.S[0x3]
    UXTL V3.8H, V28.8B
    UHSUB  V25.16B, V12.16B, V7.16B
    USHLL V27.4S, V5.4H, #0x5
    UQRSHRN V26.2S, V21.2D, #17
    UQXTN  V12.2S, V2.2D
    UQSHL  V16.8B, V3.8B, #0x7
    USHR  V29.4S, V23.4S, #22
    UADDL2  V1.2D, V27.4S, V12.4S
    UXTL V3.8H, V4.8B
    UMULL2 V12.4S, V19.8H, V1.H[0x6]
    USUBL2  V9.8H, V3.16B, V22.16B
    UQRSHL  V23.2D, V29.2D, V9.2D
    UMLSL V9.2D, V26.2S, V23.S[0x2]
    UQXTN2  V23.8H, V16.4S
    UQXTN  V15.8B, V12.8H
    UQSHL  V7.4H, V17.4H, #0x5
    UQXTN  V28.8B, V25.8H
    UABD  V21.4H, V23.4H, V9.4H
    UQSHRN2 V31.4S, V15.2D, #23
    UMLAL2  V4.4S, V31.8H, V7.8H
    UMULL  V9.8H, V21.8B, V21.8B
    UXTL2 V12.8H, V23.16B
    UXTL V2.2D, V4.2S
    UXTL2 V17.2D, V28.4S
    USRA  V25.2S, V12.2S, #19
    UQSHRN2 V26.4S, V9.2D, #20
    URSHR  V22.8B, V26.8B, #3
    USHL  V5.2S, V22.2S, V2.2S
    USRA  V16.2S, V17.2S, #18
    UMULL2 V1.2D, V25.4S, V5.S[0x1]
    UMLSL2 V12.2D, V1.4S, V16.S[0x3]
    USHR  V15.4H, V8.4H, #7
    UMLAL2 V4.2D, V6.4S, V3.S[0x1]
    UABAL  V5.8H, V8.8B, V21.8B
    UABD  V23.8B, V27.8B, V17.8B
    UMULL2 V1.2D, V6.4S, V19.S[0x2]
    UQSUB  V26.4S, V5.4S, V30.4S
    UQXTN2  V28.8H, V29.4S
    UMULL2 V19.2D, V29.4S, V1.S[0x3]
    URSQRTE  V25.4S, V13.4S
    USHR  V9.4H, V31.4H, #1
    USUBW  V16.8H, V9.8H, V23.8B
    URECPE  V27.2S, V16.2S
    URSQRTE  V22.4S, V12.4S
    USRA  V17.2S, V15.2S, #9
    UADDL  V12.2D, V22.2S, V27.2S
    USHLL2 V16.4S, V4.8H, #0xd
    UQSHRN2 V8.8H, V26.4S, #5
    UABA  V4.8H, V16.8H, V31.8H
    USHL  V31.8H, V28.8H, V25.8H
    UMLAL2 V13.2D, V19.4S, V8.S[0x2]
    UQXTN2  V21.8H, V4.4S
    UQSHL  V29.4S, V17.4S, #0x1d
    URSRA  V9.4S, V31.4S, #27
    UMULL2  V25.4S, V12.8H, V5.8H
    UQSHL V19.2D, V21.2D, #0x29
    UMLSL V12.4S, V9.4H, V9.H[0x7]
    UADDW  V23.4S, V12.4S, V12.4H
    USQADD  V5.8H, V29.8H
    UXTL2 V30.4S, V19.8H
    UQXTN2  V27.16B, V25.8H
    UADDLP  V25.2S, V27.4H
    UABAL  V26.8H, V25.8B, V23.8B
    UMLAL  V8.4S, V13.4H, V26.4H
    USHL  V29.16B, V30.16B, V5.16B
    UMULL2 V28.4S, V8.8H, V8.H[0x4]
    UMOV X5, V28.D[0x0]
    UQRSHRN2 V23.4S, V22.2D, #30
    URECPE  V25.2S, V26.2S
    UHADD  V15.2S, V24.2S, V15.2S
    USHLL V17.8H, V8.8B, #0x6
    UMLAL2 V30.2D, V29.4S, V0.S[0x3]
    UQRSHRN V21.8B, V4.8H, #6
    UQRSHRN V26.2S, V24.2D, #31
    UQRSHRN V28.4H, V15.4S, #8
    UMLAL2 V12.2D, V0.4S, V15.S[0x0]
    SUBS  X25, X25, #0x1
    B.NE  TSRTAdvsimdVectorUnsignedOperation_label_15
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0xf7d3, LSL #0
    MOVK  X14, #0x710e, LSL #16
    MOVK  X14, #0x79ed, LSL #32
    MOVK  X14, #0x130d, LSL #48
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x9d12, LSL #0
    MOVK  X14, #0x3294, LSL #16
    MOVK  X14, #0x5bca, LSL #32
    MOVK  X14, #0xded7, LSL #48
    SUB  X13, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x3001, LSL #0
    MOVK  X14, #0xd23e, LSL #16
    SUB  X13, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x940b, LSL #0
    MOVK  X14, #0xc4ae, LSL #16
    MOVK  X14, #0x23e6, LSL #32
    MOVK  X14, #0xe613, LSL #48
    SUB  X13, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0xbb7, LSL #0
    MOVK  X14, #0x3bbf, LSL #16
    MOVK  X14, #0x26a9, LSL #32
    MOVK  X14, #0x39c7, LSL #48
    SUB  X13, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0xd6e1, LSL #0
    MOVK  X14, #0x5e5b, LSL #16
    MOVK  X14, #0xd3b2, LSL #32
    MOVK  X14, #0xd25f, LSL #48
    SUB  X13, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x5331, LSL #0
    MOVK  X14, #0x2741, LSL #16
    MOVK  X14, #0x28a3, LSL #32
    MOVK  X14, #0xb395, LSL #48
    SUB  X13, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x32c6, LSL #0
    MOVK  X14, #0xdebc, LSL #16
    MOVK  X14, #0xf9ea, LSL #32
    MOVK  X14, #0x7090, LSL #48
    SUB  X13, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x7b9, LSL #0
    MOVK  X14, #0xebdc, LSL #16
    MOVK  X14, #0x27cb, LSL #32
    MOVK  X14, #0xeb6c, LSL #48
    SUB  X13, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x247f, LSL #0
    MOVK  X14, #0xa129, LSL #16
    MOVK  X14, #0xf018, LSL #32
    MOVK  X14, #0x74c9, LSL #48
    SUB  X13, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0xbac8, LSL #0
    MOVK  X14, #0xf44b, LSL #16
    MOVK  X14, #0x4ac3, LSL #32
    MOVK  X14, #0x584d, LSL #48
    SUB  X13, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x6b66, LSL #0
    MOVK  X14, #0xf47e, LSL #16
    MOVK  X14, #0xff5e, LSL #32
    MOVK  X14, #0x176, LSL #48
    SUB  X13, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x5f5e, LSL #0
    MOVK  X14, #0x7294, LSL #16
    MOVK  X14, #0x7199, LSL #32
    MOVK  X14, #0xe5ef, LSL #48
    SUB  X13, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x330d, LSL #0
    MOVK  X14, #0xc49d, LSL #16
    MOVK  X14, #0x67b8, LSL #32
    MOVK  X14, #0x8736, LSL #48
    SUB  X13, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x55d4, LSL #0
    MOVK  X14, #0x6291, LSL #16
    MOVK  X14, #0x373c, LSL #32
    MOVK  X14, #0xdc49, LSL #48
    SUB  X13, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0xb394, LSL #0
    MOVK  X14, #0x5ef, LSL #16
    MOVK  X14, #0xe7f1, LSL #32
    MOVK  X14, #0x4bd8, LSL #48
    SUB  X13, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x800, LSL #16
    MRS  X13, FPSR
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V0.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, D0
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V1.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, D1
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V2.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, D2
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V3.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, D3
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V4.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, D4
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0xff, LSL #0
    MOVK  X14, #0xff, LSL #16
    FMOV  X13, V5.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0xff, LSL #0
    MOVK  X14, #0x3, LSL #16
    FMOV  X13, D5
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V6.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x9c70, LSL #0
    MOVK  X14, #0xa129, LSL #16
    MOVK  X14, #0x600a, LSL #32
    MOVK  X14, #0x74ca, LSL #48
    FMOV  X13, D6
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V7.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    FMOV  X13, D7
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0xe7ff, LSL #0
    MOVK  X14, #0xffff, LSL #32
    FMOV  X13, V8.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x80fa, LSL #0
    MOVK  X14, #0x87, LSL #16
    MOVK  X14, #0xfbde, LSL #32
    MOVK  X14, #0x1, LSL #48
    FMOV  X13, D8
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V9.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x20, LSL #0
    FMOV  X13, D9
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V10.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x3f, LSL #0
    MOVK  X14, #0x7ff, LSL #32
    FMOV  X13, D10
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V11.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x4, LSL #0
    FMOV  X13, D11
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0xfffe, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0x1, LSL #32
    FMOV  X13, V12.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0xfffe, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0x1, LSL #32
    FMOV  X13, D12
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0xd944, LSL #0
    MOVK  X14, #0x48b5, LSL #16
    MOVK  X14, #0x9ff, LSL #32
    MOVK  X14, #0xaccf, LSL #48
    FMOV  X13, V13.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x86fa, LSL #0
    MOVK  X14, #0x53f5, LSL #16
    MOVK  X14, #0xcff8, LSL #32
    MOVK  X14, #0xa6aa, LSL #48
    FMOV  X13, D13
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V14.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x25e, LSL #0
    MOVK  X14, #0x1, LSL #16
    FMOV  X13, D14
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V15.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x2fbb, LSL #0
    MOVK  X14, #0x1, LSL #16
    MOVK  X14, #0xff, LSL #32
    FMOV  X13, D15
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V16.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, D16
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x3780, LSL #0
    MOVK  X14, #0x3ec0, LSL #16
    MOVK  X14, #0x40, LSL #32
    FMOV  X13, V17.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x3e80, LSL #0
    MOVK  X14, #0x2000, LSL #16
    MOVK  X14, #0x21c0, LSL #32
    FMOV  X13, D17
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V18.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, D18
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V19.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xfe00, LSL #32
    MOVK  X14, #0x7, LSL #48
    FMOV  X13, D19
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0xe177, LSL #0
    MOVK  X14, #0xb9ad, LSL #16
    MOVK  X14, #0x819b, LSL #32
    MOVK  X14, #0x652f, LSL #48
    FMOV  X13, V20.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0xf7d3, LSL #0
    MOVK  X14, #0x710e, LSL #16
    MOVK  X14, #0x79ed, LSL #32
    MOVK  X14, #0x130d, LSL #48
    FMOV  X13, D20
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V21.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, D21
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    FMOV  X13, V22.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    FMOV  X13, D22
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    FMOV  X13, V23.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0xfffc, LSL #0
    MOVK  X14, #0x1, LSL #48
    FMOV  X13, D23
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V24.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x5f77, LSL #0
    MOVK  X14, #0x2, LSL #16
    FMOV  X13, D24
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V25.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    FMOV  X13, D25
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V26.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, D26
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0xfeff, LSL #0
    MOVK  X14, #0xfeff, LSL #16
    FMOV  X13, V27.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    FMOV  X13, D27
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V28.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x130, LSL #0
    MOVK  X14, #0x1, LSL #16
    FMOV  X13, D28
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V29.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, D29
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V30.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, D30
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0x3ff, LSL #0
    FMOV  X13, V31.D[1]
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    FMOV  X13, D31
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorUnsignedOperation_TestFail
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
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X20
    FMOV  V0.D[1], X21
    FMOV  D1, X8
    FMOV  V1.D[1], X22
    FMOV  D2, X10
    FMOV  V2.D[1], X12
    FMOV  D3, X27
    FMOV  V3.D[1], X29
    FMOV  D4, X15
    FMOV  V4.D[1], X17
    FMOV  D5, X28
    FMOV  V5.D[1], X25
    FMOV  D6, X16
    FMOV  V6.D[1], X24
    FMOV  D7, X23
    FMOV  V7.D[1], X13
    FMOV  D8, X21
    FMOV  V8.D[1], X10
    FMOV  D9, X4
    FMOV  V9.D[1], X22
    FMOV  D10, X2
    FMOV  V10.D[1], X4
    FMOV  D11, X23
    FMOV  V11.D[1], X27
    FMOV  D12, X25
    FMOV  V12.D[1], X25
    FMOV  D13, X15
    FMOV  V13.D[1], X12
    FMOV  D14, X29
    FMOV  V14.D[1], X7
    FMOV  D15, X6
    FMOV  V15.D[1], X29
    FMOV  D16, X16
    FMOV  V16.D[1], X10
    FMOV  D17, X20
    FMOV  V17.D[1], X25
    FMOV  D18, X10
    FMOV  V18.D[1], X4
    FMOV  D19, X5
    FMOV  V19.D[1], X22
    FMOV  D20, X13
    FMOV  V20.D[1], X22
    FMOV  D21, X22
    FMOV  V21.D[1], X2
    FMOV  D22, X16
    FMOV  V22.D[1], X28
    FMOV  D23, X23
    FMOV  V23.D[1], X21
    FMOV  D24, X9
    FMOV  V24.D[1], X28
    FMOV  D25, X10
    FMOV  V25.D[1], X7
    FMOV  D26, X22
    FMOV  V26.D[1], X17
    FMOV  D27, X25
    FMOV  V27.D[1], X5
    FMOV  D28, X28
    FMOV  V28.D[1], X8
    FMOV  D29, X13
    FMOV  V29.D[1], X16
    FMOV  D30, X15
    FMOV  V30.D[1], X4
    FMOV  D31, X21
    FMOV  V31.D[1], X15
    MOVZ  X23, #0xf, LSL #0
TSRTAdvsimdVectorUnsignedOperation_label_16:
    UADDL  V4.8H, V30.8B, V22.8B
    UADDL2  V13.8H, V23.16B, V31.16B
    UQRSHRN V11.8B, V25.8H, #2
    UMLAL V18.4S, V29.4H, V13.H[0x7]
    UQSHL  V28.2S, V28.2S, #0x1b
    UQSHRN V13.8B, V26.8H, #2
    UQXTN  V7.4H, V27.4S
    UADDLV  S25, V28.8H
    UADDLV  S1, V7.8H
    UADDL  V13.4S, V13.4H, V4.4H
    USHLL V19.8H, V25.8B, #0x2
    UQRSHRN2 V26.8H, V18.4S, #1
    UMOV W15, V26.S[0x0]
    UQSHL  V1.16B, V1.16B, #0x0
    USHLL V5.2D, V11.2S, #0x1e
    UQSHL  V16.2D, V5.2D, V5.2D
    UQSHRN2 V20.4S, V16.2D, #12
    URSHR  V29.4H, V13.4H, #13
    USHR  V23.4H, V1.4H, #11
    UMLSL V13.2D, V23.2S, V23.S[0x3]
    USUBL  V31.8H, V20.8B, V13.8B
    USHLL V28.4S, V31.4H, #0x3
    USRA  V18.8H, V29.8H, #4
    UADDL  V16.8H, V28.8B, V28.8B
    URSHR V23.2D, V19.2D, #51
    UMULL2 V31.4S, V16.8H, V5.H[0x6]
    URSHR  V11.2S, V23.2S, #18
    UXTL2 V13.4S, V31.8H
    UQSHRN V1.2S, V18.2D, #9
    URSHL  V25.16B, V1.16B, V11.16B
    UQSHRN2 V16.16B, V18.8H, #8
    URECPE  V5.4S, V16.4S
    UADDW  V19.2D, V30.2D, V5.2S
    UABDL  V16.4S, V25.4H, V19.4H
    UADDLV  D26, V16.4S
    UQSHRN2 V20.8H, V26.4S, #8
    UXTL2 V25.8H, V13.16B
    URSQRTE  V28.2S, V25.2S
    UQSHRN2 V13.16B, V20.8H, #2
    UABAL2  V11.2D, V28.4S, V28.4S
    UXTL2 V28.4S, V13.8H
    UQSHL  V1.2S, V28.2S, #0x7
    UMLSL V13.2D, V11.2S, V11.S[0x0]
    UXTL V31.4S, V27.4H
    UQSHRN V25.2S, V31.2D, #32
    UXTL V18.4S, V25.4H
    USHR  V5.2S, V18.2S, #7
    UQADD  V31.2D, V13.2D, V1.2D
    UQSHL  V28.8H, V31.8H, #0xc
    UMLAL2 V27.2D, V28.4S, V28.S[0x2]
    USHR V20.2D, V19.2D, #55
    USHR  V18.2S, V24.2S, #8
    UMLAL2  V1.4S, V5.8H, V18.8H
    UABAL  V16.8H, V20.8B, V20.8B
    UQRSHL  V11.4S, V28.4S, V24.4S
    UMULL  V25.4S, V27.4H, V1.4H
    UQSUB  V19.4H, V11.4H, V16.4H
    UQSHRN2 V26.16B, V19.8H, #2
    UQSHL  V20.8H, V26.8H, #0x2
    USHR V16.2D, V25.2D, #61
    UQADD  V25.8B, V16.8B, V16.8B
    UABAL  V1.2D, V25.2S, V20.2S
    URSRA V5.2D, V10.2D, #59
    USHR V25.2D, V14.2D, #6
    USHLL V20.2D, V27.2S, #0xe
    UADDLV  H28, V12.8B
    USRA  V26.16B, V19.16B, #3
    UQSHRN V10.2S, V14.2D, #12
    UMULL2  V11.8H, V2.16B, V7.16B
    UADALP  V24.1D, V22.2S
    UMOV X22, V28.D[0x0]
    UQSHL  V31.16B, V10.16B, #0x4
    UQRSHRN V16.2S, V11.2D, #10
    URSRA  V18.16B, V25.16B, #8
    USUBW  V19.4S, V24.4S, V26.4H
    UQSHRN2 V11.16B, V31.8H, #3
    UQRSHL  V10.4S, V16.4S, V16.4S
    UMLSL V16.4S, V1.4H, V1.H[0x1]
    UQSHRN V13.8B, V19.8H, #1
    UMLAL2 V31.2D, V20.4S, V20.S[0x1]
    UQSHRN V2.8B, V10.8H, #4
    UMLSL2 V10.2D, V11.4S, V28.S[0x0]
    UMULL V22.4S, V2.4H, V5.H[0x3]
    UABDL2  V24.8H, V18.16B, V18.16B
    UQSHL  V12.4H, V22.4H, V22.4H
    URSHR  V27.16B, V12.16B, #7
    USHR  V26.16B, V10.16B, #1
    UQSUB  V10.8B, V26.8B, V26.8B
    USHLL2 V25.2D, V10.4S, #0xb
    USHR V5.2D, V27.2D, #45
    UADDW2  V20.8H, V16.8H, V16.16B
    USHLL2 V14.2D, V31.4S, #0x16
    UMULL V11.4S, V16.4H, V14.H[0x4]
    UQSHRN2 V19.16B, V24.8H, #3
    UQSHRN2 V27.16B, V19.8H, #2
    UXTL V18.2D, V25.2S
    UADDLV  D12, V5.4S
    UADDL2  V31.8H, V13.16B, V12.16B
    UADDL2  V7.4S, V15.8H, V18.8H
    USUBW  V24.4S, V7.4S, V20.4H
    USHR  V22.8H, V11.8H, #2
    UHSUB  V13.4H, V22.4H, V29.4H
    URSHR  V26.4H, V13.4H, #6
    UMLSL2 V11.4S, V26.8H, V9.H[0x5]
    UADDLP  V28.4S, V27.8H
    URSRA V18.2D, V24.2D, #12
    UQXTN2  V5.4S, V18.2D
    USHLL V13.4S, V5.4H, #0x9
    UQRSHL  V19.2S, V13.2S, V11.2S
    UMULL2  V7.4S, V28.8H, V28.8H
    USHLL2 V26.2D, V19.4S, #0x2
    UADDLV  H28, V7.16B
    UMULL2 V10.4S, V28.8H, V7.H[0x3]
    UADDLV  S18, V31.4H
    USHLL2 V7.2D, V26.4S, #0x10
    UMLAL V19.2D, V7.2S, V7.S[0x1]
    URSRA V9.2D, V18.2D, #10
    UQSHL  V18.8H, V9.8H, #0x2
    UMLSL V13.2D, V18.2S, V14.S[0x3]
    UXTL2 V27.8H, V19.16B
    UMLSL V7.2D, V13.2S, V10.S[0x1]
    UMLSL2  V20.2D, V27.4S, V27.4S
    UMULL2 V31.4S, V12.8H, V7.H[0x0]
    USHR V19.2D, V31.2D, #10
    UQSHRN2 V31.4S, V19.2D, #23
    UMULL V11.2D, V31.2S, V20.S[0x2]
    UMLAL V9.2D, V24.2S, V22.S[0x2]
    UQRSHRN2 V20.8H, V11.4S, #13
    UABDL  V26.8H, V7.8B, V20.8B
    UABA  V27.2S, V16.2S, V12.2S
    UQRSHRN V11.4H, V18.4S, #2
    UXTL2 V12.2D, V10.4S
    USHLL2 V16.4S, V16.8H, #0x4
    UMULL V10.2D, V9.2S, V25.S[0x3]
    UMLSL2 V19.2D, V9.4S, V10.S[0x1]
    URSRA  V7.2S, V16.2S, #5
    UABDL  V25.2D, V7.2S, V2.2S
    UXTL2 V14.8H, V16.16B
    UMLAL V24.4S, V26.4H, V12.H[0x1]
    UQRSHRN2 V7.4S, V24.2D, #12
    UQRSHRN V13.8B, V24.8H, #5
    UMULL2 V10.4S, V18.8H, V8.H[0x5]
    UADDLV  S24, V28.4H
    USQADD  V22.16B, V13.16B
    UQADD  V23.8H, V10.8H, V11.8H
    UMULL V20.4S, V24.4H, V14.H[0x5]
    UMLSL2 V26.4S, V27.8H, V7.H[0x5]
    UADDW  V11.8H, V22.8H, V26.8B
    UQRSHRN V9.4H, V25.4S, #1
    USQADD  V28.2D, V9.2D
    USHLL V2.8H, V23.8B, #0x3
    UQRSHL  V22.4S, V19.4S, V19.4S
    UQRSHRN2 V19.4S, V20.2D, #24
    UMLSL V18.2D, V19.2S, V2.S[0x1]
    UADDL2  V12.4S, V18.8H, V22.8H
    UQSHL  V16.8B, V11.8B, #0x5
    UABDL  V9.4S, V28.4H, V28.4H
    UADDLV  S25, V9.8H
    UQRSHRN2 V28.16B, V1.8H, #3
    UMLSL2 V10.4S, V25.8H, V12.H[0x5]
    UABAL2  V13.4S, V10.8H, V10.8H
    UQSHL  V24.8B, V16.8B, #0x3
    UQADD  V23.4H, V24.4H, V28.4H
    UMLSL2 V10.4S, V23.8H, V13.H[0x0]
    UABA  V14.8B, V7.8B, V30.8B
    UMLAL V16.4S, V25.4H, V7.H[0x7]
    UXTL2 V8.8H, V1.16B
    UHSUB  V7.8B, V10.8B, V23.8B
    UMLAL2 V28.2D, V18.4S, V15.S[0x2]
    UQSHRN2 V12.8H, V13.4S, #14
    UQRSHL  V22.8B, V15.8B, V21.8B
    UMLAL2 V9.2D, V13.4S, V15.S[0x3]
    URSHR  V18.2S, V22.2S, #31
    USUBL  V24.8H, V20.8B, V0.8B
    UXTL V11.2D, V14.2S
    USHR V14.2D, V18.2D, #27
    UQRSHRN V30.4H, V16.4S, #4
    URSQRTE  V20.4S, V11.4S
    UMULL V18.4S, V7.4H, V8.H[0x3]
    UQSHRN V7.4H, V9.4S, #10
    UADDLV  S9, V14.8H
    URSQRTE  V8.4S, V20.4S
    UQRSHRN2 V14.8H, V7.4S, #10
    USHLL2 V11.4S, V12.8H, #0xa
    UMLSL2 V20.4S, V30.8H, V4.H[0x6]
    UHSUB  V22.4H, V11.4H, V28.4H
    UMLAL  V10.4S, V8.4H, V22.4H
    UQSHL  V23.8B, V24.8B, #0x4
    USHLL V0.4S, V20.4H, #0x5
    UMLSL2  V22.2D, V10.4S, V23.4S
    URSHL  V28.4H, V0.4H, V18.4H
    URSRA  V7.4S, V9.4S, #17
    UMULL2 V16.2D, V7.4S, V14.S[0x2]
    USHLL2 V9.8H, V22.16B, #0x6
    USUBW  V22.8H, V16.8H, V9.8B
    UQRSHRN2 V1.4S, V22.2D, #16
    UMOV X22, V28.D[0x0]
    URSRA  V8.2S, V26.2S, #24
    UHSUB  V30.16B, V25.16B, V19.16B
    USHLL V0.8H, V3.8B, #0x5
    SUBS  X23, X23, #0x1
    B.NE  TSRTAdvsimdVectorUnsignedOperation_label_16
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x84, LSL #0
    MOVK  X4, #0x42, LSL #16
    SUB  X27, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffe0, LSL #0
    MOVK  X4, #0x1f, LSL #16
    MOVK  X4, #0xffe0, LSL #32
    MOVK  X4, #0x1f, LSL #48
    SUB  X27, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x800, LSL #16
    MRS  X27, FPSR
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V0.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, D0
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V1.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xff7f, LSL #0
    MOVK  X4, #0x84, LSL #16
    MOVK  X4, #0xff80, LSL #32
    MOVK  X4, #0x7f, LSL #48
    FMOV  X27, D1
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V2.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, D2
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V3.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, D3
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V4.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, D4
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X27, V5.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, D5
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V6.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, D6
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V7.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, D7
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V8.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #16
    MOVK  X4, #0x1, LSL #32
    MOVK  X4, #0x8000, LSL #48
    FMOV  X27, D8
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V9.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, D9
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #32
    MOVK  X4, #0xff, LSL #48
    FMOV  X27, V10.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #32
    MOVK  X4, #0xff, LSL #48
    FMOV  X27, D10
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V11.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xfc00, LSL #0
    MOVK  X4, #0x3ff, LSL #16
    MOVK  X4, #0xfc00, LSL #32
    MOVK  X4, #0x3ff, LSL #48
    FMOV  X27, D11
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    FMOV  X27, V12.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, D12
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V13.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xff02, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X27, D13
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V14.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, D14
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V15.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, D15
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V16.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, D16
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V17.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, D17
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V18.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, D18
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V19.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, D19
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X27, V20.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X27, D20
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V21.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, D21
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V22.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, D22
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V23.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xff, LSL #0
    MOVK  X4, #0xf0, LSL #16
    MOVK  X4, #0x20, LSL #32
    FMOV  X27, D23
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V24.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xee, LSL #0
    MOVK  X4, #0xf, LSL #16
    MOVK  X4, #0x2, LSL #32
    FMOV  X27, D24
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V25.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, D25
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x6c, LSL #0
    MOVK  X4, #0xbc, LSL #16
    MOVK  X4, #0xfe, LSL #32
    FMOV  X27, V26.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x84, LSL #0
    MOVK  X4, #0x42, LSL #16
    MOVK  X4, #0xbe, LSL #32
    MOVK  X4, #0xff, LSL #48
    FMOV  X27, D26
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V27.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x4284, LSL #0
    MOVK  X4, #0xff7c, LSL #16
    MOVK  X4, #0xbbf0, LSL #32
    MOVK  X4, #0xffff, LSL #48
    FMOV  X27, D27
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V28.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0xffe0, LSL #0
    MOVK  X4, #0x1f, LSL #16
    MOVK  X4, #0xffe0, LSL #32
    MOVK  X4, #0x1f, LSL #48
    FMOV  X27, D28
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V29.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x1, LSL #0
    MOVK  X4, #0x2, LSL #32
    FMOV  X27, D29
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V30.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, D30
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V31.D[1]
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, D31
    SUB  X29, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorUnsignedOperation_TestFail
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
    FMOV  D0, X24
    FMOV  V0.D[1], X27
    FMOV  D1, X23
    FMOV  V1.D[1], X29
    FMOV  D2, X28
    FMOV  V2.D[1], X25
    FMOV  D3, X4
    FMOV  V3.D[1], X22
    FMOV  D4, X4
    FMOV  V4.D[1], X4
    FMOV  D5, X25
    FMOV  V5.D[1], X24
    FMOV  D6, X21
    FMOV  V6.D[1], X27
    FMOV  D7, X23
    FMOV  V7.D[1], X8
    FMOV  D8, X5
    FMOV  V8.D[1], X23
    FMOV  D9, X5
    FMOV  V9.D[1], X29
    FMOV  D10, X16
    FMOV  V10.D[1], X17
    FMOV  D11, X4
    FMOV  V11.D[1], X17
    FMOV  D12, X8
    FMOV  V12.D[1], X4
    FMOV  D13, X15
    FMOV  V13.D[1], X24
    FMOV  D14, X9
    FMOV  V14.D[1], X13
    FMOV  D15, X6
    FMOV  V15.D[1], X14
    FMOV  D16, X23
    FMOV  V16.D[1], X9
    FMOV  D17, X9
    FMOV  V17.D[1], X5
    FMOV  D18, X23
    FMOV  V18.D[1], X16
    FMOV  D19, X20
    FMOV  V19.D[1], X14
    FMOV  D20, X23
    FMOV  V20.D[1], X9
    FMOV  D21, X25
    FMOV  V21.D[1], X8
    FMOV  D22, X21
    FMOV  V22.D[1], X28
    FMOV  D23, X13
    FMOV  V23.D[1], X28
    FMOV  D24, X25
    FMOV  V24.D[1], X14
    FMOV  D25, X25
    FMOV  V25.D[1], X20
    FMOV  D26, X21
    FMOV  V26.D[1], X8
    FMOV  D27, X27
    FMOV  V27.D[1], X13
    FMOV  D28, X5
    FMOV  V28.D[1], X16
    FMOV  D29, X3
    FMOV  V29.D[1], X17
    FMOV  D30, X12
    FMOV  V30.D[1], X24
    FMOV  D31, X20
    FMOV  V31.D[1], X27
    MOVZ  X9, #0xf, LSL #0
TSRTAdvsimdVectorUnsignedOperation_label_17:
    UHADD  V9.2S, V24.2S, V17.2S
    UMLSL2  V6.4S, V9.8H, V25.8H
    UQSHRN2 V6.16B, V26.8H, #7
    UABAL2  V15.4S, V27.8H, V27.8H
    UQSHRN2 V7.8H, V31.4S, #3
    UQADD  V26.4H, V30.4H, V7.4H
    USHLL2 V5.4S, V15.8H, #0x6
    URSHR  V2.2S, V26.2S, #16
    UQXTN  V21.4H, V29.4S
    UMLAL2 V12.4S, V22.8H, V6.H[0x4]
    UQRSHL  V3.2D, V5.2D, V28.2D
    URECPE  V6.4S, V3.4S
    UQRSHRN2 V5.16B, V6.8H, #6
    USHR  V0.4S, V5.4S, #6
    UMOV W17, V2.H[0x3]
    UADALP  V28.4H, V0.8B
    UQSHRN2 V3.4S, V21.2D, #9
    URSQRTE  V31.2S, V3.2S
    UXTL2 V27.8H, V28.16B
    UXTL2 V29.2D, V12.4S
    UMULL  V30.8H, V31.8B, V29.8B
    UQRSHRN V26.8B, V30.8H, #8
    UABAL2  V7.4S, V26.8H, V27.8H
    UABDL2  V12.2D, V21.4S, V24.4S
    URSHR  V2.4S, V0.4S, #8
    URSRA  V22.8H, V13.8H, #3
    UXTL2 V15.4S, V16.8H
    UMULL2 V5.2D, V27.4S, V29.S[0x3]
    UMLAL2  V9.4S, V25.8H, V12.8H
    UQRSHRN V26.4H, V18.4S, #8
    USQADD  V3.2S, V6.2S
    USHLL V25.4S, V25.4H, #0xb
    UXTL V6.4S, V25.4H
    UQSHL  V6.8H, V26.8H, #0x8
    USHLL2 V27.4S, V2.8H, #0x9
    UQRSHRN V28.4H, V15.4S, #8
    UQSHL  V29.16B, V7.16B, #0x7
    USHLL2 V30.4S, V5.8H, #0x4
    URHADD  V0.4S, V22.4S, V3.4S
    UQRSHRN2 V15.4S, V6.2D, #26
    UMLAL2 V17.2D, V0.4S, V15.S[0x3]
    UADDW2  V12.8H, V29.8H, V17.16B
    UMULL  V2.4S, V28.4H, V30.4H
    UADDL  V28.2D, V12.2S, V27.2S
    USHLL2 V7.4S, V9.8H, #0x2
    UMULL2 V26.4S, V4.8H, V2.H[0x3]
    USUBW2  V2.2D, V7.2D, V26.4S
    USHR  V30.2S, V28.2S, #12
    UMULL2 V21.4S, V30.8H, V2.H[0x4]
    UADDLV  S26, V1.8H
    USHR  V4.8H, V25.8H, #6
    UMLSL V25.4S, V20.4H, V0.H[0x4]
    UADALP  V9.4H, V19.8B
    UMOV X22, V3.D[0x1]
    UADDW2  V13.2D, V30.2D, V11.4S
    UXTL2 V5.8H, V6.16B
    UADALP  V0.2D, V10.4S
    USHLL V12.8H, V18.8B, #0x3
    URSRA  V2.2S, V28.2S, #15
    URSHR V1.2D, V12.2D, #21
    UMLSL2 V22.4S, V21.8H, V2.H[0x7]
    UMLAL2 V7.2D, V26.4S, V13.S[0x3]
    USUBW  V18.2D, V7.2D, V5.2S
    USUBL2  V10.2D, V4.4S, V0.4S
    UMULL2 V19.2D, V9.4S, V25.S[0x0]
    UQRSHRN2 V25.8H, V19.4S, #4
    UABAL  V21.4S, V22.4H, V18.4H
    UQSHRN V13.8B, V21.8H, #6
    UXTL V3.4S, V10.4H
    UQRSHRN V28.8B, V13.8H, #7
    UABD  V9.16B, V1.16B, V1.16B
    USUBW2  V20.8H, V25.8H, V9.16B
    UQSUB  V7.8H, V3.8H, V28.8H
    URSHR V12.2D, V7.2D, #59
    URSHR  V1.2S, V20.2S, #21
    USHLL2 V6.4S, V1.8H, #0x1
    UQSHRN V7.4H, V6.4S, #16
    URSRA  V4.8B, V12.8B, #7
    UHADD  V2.8B, V4.8B, V31.8B
    USUBL2  V5.8H, V2.16B, V7.16B
    USUBW2  V19.8H, V7.8H, V13.16B
    USUBL  V21.4S, V20.4H, V19.4H
    UHADD  V10.8B, V1.8B, V14.8B
    UMLSL  V0.8H, V17.8B, V4.8B
    URSHR V25.2D, V25.2D, #38
    UQSHRN V6.4H, V6.4S, #13
    USQADD  V20.2D, V9.2D
    UADDLP  V14.2D, V0.4S
    UMLAL2  V3.8H, V31.16B, V14.16B
    UABD  V28.4S, V25.4S, V0.4S
    UQRSHRN V12.8B, V8.8H, #6
    UMLAL  V4.2D, V12.2S, V26.2S
    USHLL V1.8H, V12.8B, #0x6
    UQSHL  V31.4H, V5.4H, V19.4H
    UXTL V19.8H, V4.8B
    UMOV W15, V6.S[0x3]
    UQRSHRN2 V5.16B, V12.8H, #8
    URSRA  V25.8B, V31.8B, #8
    UQRSHRN2 V17.4S, V28.2D, #30
    UMULL V14.4S, V21.4H, V10.H[0x5]
    UADDLP  V9.4H, V20.8B
    USUBW2  V26.8H, V3.8H, V12.16B
    UQRSHRN V13.4H, V9.4S, #11
    UMLAL  V8.2D, V17.2S, V26.2S
    UQSHRN2 V6.4S, V1.2D, #30
    UMULL2 V9.4S, V25.8H, V13.H[0x2]
    UABD  V0.2S, V8.2S, V9.2S
    UMLAL  V17.2D, V5.2S, V0.2S
    UMLSL2  V12.2D, V19.4S, V17.4S
    UQSHRN2 V2.16B, V14.8H, #3
    UMLAL2  V1.8H, V6.16B, V6.16B
    UQRSHRN V14.4H, V12.4S, #5
    UQRSHRN V6.2S, V14.2D, #9
    URSRA  V8.4H, V7.4H, #13
    USRA  V7.8H, V2.8H, #11
    UMLSL2 V17.4S, V7.8H, V1.H[0x1]
    USRA  V3.4H, V17.4H, #16
    URSHR  V4.8B, V3.8B, #3
    UMLAL2 V9.2D, V8.4S, V6.S[0x2]
    UQRSHRN2 V25.16B, V4.8H, #1
    UADDLP  V14.2S, V25.4H
    UQXTN2  V26.16B, V9.8H
    UMLSL  V8.2D, V26.2S, V14.2S
    URSRA  V13.4S, V4.4S, #25
    UQSHRN V2.4H, V1.4S, #8
    UMULL2 V7.2D, V13.4S, V17.S[0x0]
    UQSHL  V12.16B, V8.16B, #0x2
    UXTL2 V1.8H, V7.16B
    USHL  V25.4H, V26.4H, V2.4H
    UADDW2  V3.2D, V22.2D, V26.4S
    USHLL2 V2.2D, V28.4S, #0x19
    UADDW  V4.4S, V27.4S, V14.4H
    UMOV W21, V28.S[0x1]
    USUBW2  V27.8H, V15.8H, V17.16B
    USHLL2 V8.8H, V7.16B, #0x3
    UMLAL2 V15.4S, V16.8H, V0.H[0x4]
    UQSHL  V16.2S, V4.2S, #0x16
    USHLL2 V0.8H, V16.16B, #0x3
    UMLSL2 V17.4S, V8.8H, V15.H[0x6]
    UMLSL  V8.8H, V12.8B, V12.8B
    URSRA  V28.16B, V8.16B, #6
    UQRSHRN V15.4H, V27.4S, #15
    UABDL  V27.4S, V15.4H, V1.4H
    URSRA  V12.4H, V28.4H, #4
    UQSHRN V4.4H, V2.4S, #16
    UADDW2  V6.4S, V0.4S, V0.8H
    UQSUB  V26.4H, V3.4H, V17.4H
    UMULL2 V7.2D, V25.4S, V12.S[0x1]
    USHLL2 V15.2D, V9.4S, #0x1
    UQSHRN V2.8B, V27.8H, #3
    URSRA  V1.4S, V6.4S, #5
    USHLL V8.2D, V26.2S, #0x2
    UQRSHRN2 V9.4S, V15.2D, #28
    UMLSL V22.4S, V4.4H, V4.H[0x1]
    UXTL V3.2D, V7.2S
    UQRSHL  V28.16B, V2.16B, V2.16B
    USHLL V6.4S, V22.4H, #0x5
    UQXTN  V17.4H, V9.4S
    UMULL2 V4.4S, V6.8H, V3.H[0x0]
    UMULL V7.4S, V28.4H, V6.H[0x0]
    UQRSHRN V26.8B, V17.8H, #7
    UMLAL2  V25.4S, V8.8H, V26.8H
    URSQRTE  V9.4S, V25.4S
    USUBW2  V6.4S, V4.4S, V7.8H
    USHR  V12.16B, V6.16B, #5
    UQRSHRN2 V15.8H, V9.4S, #13
    UADDL2  V22.2D, V1.4S, V12.4S
    UQRSHRN V26.2S, V15.2D, #7
    UADDL  V1.4S, V22.4H, V22.4H
    UABA  V3.4S, V1.4S, V26.4S
    UADDW  V28.8H, V21.8H, V20.8B
    UQSHRN2 V17.8H, V6.4S, #1
    UQRSHRN V2.8B, V28.8H, #2
    UQRSHRN V21.4H, V24.4S, #8
    UMULL  V26.2D, V11.2S, V26.2S
    UQSHL  V22.16B, V4.16B, #0x4
    UMOV W15, V10.B[0x9]
    UQRSHRN2 V10.8H, V8.4S, #9
    UQRSHRN V27.4H, V16.4S, #12
    UQRSHRN2 V20.8H, V22.4S, #1
    UMULL2  V1.2D, V30.4S, V25.4S
    URSRA  V25.2S, V1.2S, #21
    UMULL2 V12.4S, V10.8H, V5.H[0x3]
    USRA  V6.16B, V12.16B, #1
    URSHR  V7.4S, V22.4S, #4
    UMLSL  V6.2D, V7.2S, V3.2S
    UMLSL2  V1.4S, V26.8H, V6.8H
    URSRA V12.2D, V21.2D, #3
    UXTL V22.2D, V12.2S
    URSQRTE  V9.2S, V2.2S
    UQSHRN V2.8B, V27.8H, #5
    UABD  V21.8H, V1.8H, V17.8H
    UQSHL  V4.2S, V22.2S, #0x14
    URSRA V24.2D, V9.2D, #44
    UMULL V16.2D, V25.2S, V25.S[0x3]
    UMLSL2 V27.2D, V4.4S, V21.S[0x3]
    UMLAL2  V12.4S, V20.8H, V27.8H
    USUBL2  V5.2D, V2.4S, V12.4S
    UADALP  V20.1D, V16.2S
    USUBW2  V25.8H, V20.8H, V5.16B
    SUBS  X9, X9, #0x1
    B.NE  TSRTAdvsimdVectorUnsignedOperation_label_17
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X7, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X7, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X7, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X7, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X7, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X7, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X7, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X7, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X7, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X7, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffe0, LSL #0
    MOVK  X23, #0x1f, LSL #16
    SUB  X7, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X7, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X7, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X7, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X7, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X7, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x800, LSL #16
    MRS  X7, FPSR
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V0.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D0
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V1.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D1
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V2.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xff00, LSL #0
    FMOV  X7, D2
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V3.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X7, D3
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V4.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    FMOV  X7, D4
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V5.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D5
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V6.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D6
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V7.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D7
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V8.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x6800, LSL #0
    MOVK  X23, #0x8000, LSL #16
    MOVK  X23, #0x3, LSL #32
    FMOV  X7, D8
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V9.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X7, D9
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    FMOV  X7, V10.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D10
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X7, V11.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X7, D11
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V12.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x1c00, LSL #0
    MOVK  X23, #0xe000, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0x1fff, LSL #48
    FMOV  X7, D12
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V13.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D13
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V14.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D14
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X7, V15.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D15
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V16.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D16
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V17.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D17
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V18.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D18
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V19.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D19
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V20.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D20
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V21.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D21
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0x1fff, LSL #16
    FMOV  X7, V22.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x1c00, LSL #0
    MOVK  X23, #0xe000, LSL #16
    FMOV  X7, D22
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X7, V23.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X7, D23
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X7, V24.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xef, LSL #16
    FMOV  X7, D24
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V25.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D25
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x1, LSL #0
    MOVK  X23, #0xfffe, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X7, V26.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D26
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V27.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xffff, LSL #16
    FMOV  X7, D27
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V28.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D28
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V29.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D29
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V30.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D30
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V31.D[1]
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, D31
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X2, #0x3d23, LSL #0
    MOVK  X2, #0x79e2, LSL #16
    MOVK  X2, #0x206b, LSL #32
    MOVK  X2, #0xe985, LSL #48
    MOVZ  X3, #0xbfe0, LSL #0
    MOVK  X3, #0xf02a, LSL #16
    MOVK  X3, #0x2c10, LSL #32
    MOVK  X3, #0x4318, LSL #48
    MOVZ  X4, #0xf4ef, LSL #0
    MOVK  X4, #0xcef4, LSL #16
    MOVK  X4, #0xb2c4, LSL #32
    MOVK  X4, #0xd265, LSL #48
    MOVZ  X5, #0x87ab, LSL #0
    MOVK  X5, #0x82d3, LSL #16
    MOVK  X5, #0xd15c, LSL #32
    MOVK  X5, #0x91f3, LSL #48
    MOVZ  X6, #0x6175, LSL #0
    MOVK  X6, #0x4617, LSL #16
    MOVK  X6, #0x4d6c, LSL #32
    MOVK  X6, #0x7132, LSL #48
    MOVZ  X7, #0x561c, LSL #0
    MOVK  X7, #0xe1f1, LSL #16
    MOVK  X7, #0xe479, LSL #32
    MOVK  X7, #0xd0cf, LSL #48
    MOVZ  X8, #0x8640, LSL #0
    MOVK  X8, #0x793c, LSL #16
    MOVK  X8, #0xee51, LSL #32
    MOVK  X8, #0x56ee, LSL #48
    MOVZ  X9, #0x6002, LSL #0
    MOVK  X9, #0x7b8e, LSL #16
    MOVK  X9, #0xea88, LSL #32
    MOVK  X9, #0x9562, LSL #48
    MOVZ  X10, #0xdffb, LSL #0
    MOVK  X10, #0x5bd3, LSL #16
    MOVK  X10, #0x3d5c, LSL #32
    MOVK  X10, #0x761d, LSL #48
    MOVZ  X12, #0xf303, LSL #0
    MOVK  X12, #0x5ce7, LSL #16
    MOVK  X12, #0xf282, LSL #32
    MOVK  X12, #0x2c39, LSL #48
    MOVZ  X13, #0x2f92, LSL #0
    MOVK  X13, #0xd490, LSL #16
    MOVK  X13, #0xa823, LSL #32
    MOVK  X13, #0x7da7, LSL #48
    MOVZ  X14, #0x6805, LSL #0
    MOVK  X14, #0x154f, LSL #16
    MOVK  X14, #0x6f60, LSL #32
    MOVK  X14, #0x91b6, LSL #48
    MOVZ  X15, #0x32cb, LSL #0
    MOVK  X15, #0xbc73, LSL #16
    MOVK  X15, #0x150, LSL #32
    MOVK  X15, #0x91ef, LSL #48
    MOVZ  X16, #0x22d4, LSL #0
    MOVK  X16, #0x789b, LSL #16
    MOVK  X16, #0x2bfb, LSL #32
    MOVK  X16, #0xa07b, LSL #48
    MOVZ  X17, #0xd998, LSL #0
    MOVK  X17, #0xaa95, LSL #16
    MOVK  X17, #0x9cb1, LSL #32
    MOVK  X17, #0xb01c, LSL #48
    MOVZ  X20, #0x887e, LSL #0
    MOVK  X20, #0xedba, LSL #16
    MOVK  X20, #0xa803, LSL #32
    MOVK  X20, #0x8b57, LSL #48
    MOVZ  X21, #0x7a7a, LSL #0
    MOVK  X21, #0xd938, LSL #16
    MOVK  X21, #0x16b0, LSL #32
    MOVK  X21, #0x1b92, LSL #48
    MOVZ  X22, #0xe188, LSL #0
    MOVK  X22, #0xfc68, LSL #16
    MOVK  X22, #0x7310, LSL #32
    MOVK  X22, #0x3c0a, LSL #48
    MOVZ  X23, #0x5600, LSL #0
    MOVK  X23, #0x914e, LSL #16
    MOVK  X23, #0x51a2, LSL #32
    MOVK  X23, #0xb518, LSL #48
    MOVZ  X24, #0x9ef7, LSL #0
    MOVK  X24, #0x6841, LSL #16
    MOVK  X24, #0xd552, LSL #32
    MOVK  X24, #0xf52b, LSL #48
    MOVZ  X25, #0x950c, LSL #0
    MOVK  X25, #0xe989, LSL #16
    MOVK  X25, #0x338a, LSL #32
    MOVK  X25, #0x4f1a, LSL #48
    MOVZ  X27, #0x3212, LSL #0
    MOVK  X27, #0x2e36, LSL #16
    MOVK  X27, #0x6608, LSL #32
    MOVK  X27, #0xd213, LSL #48
    MOVZ  X28, #0xfdf8, LSL #0
    MOVK  X28, #0x7acb, LSL #16
    MOVK  X28, #0x7ba, LSL #32
    MOVK  X28, #0x1046, LSL #48
    MOVZ  X29, #0x7cf0, LSL #0
    MOVK  X29, #0x5e88, LSL #16
    MOVK  X29, #0xf0e9, LSL #32
    MOVK  X29, #0xd470, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X28
    FMOV  D1, X29
    FMOV  V1.D[1], X27
    FMOV  D2, X8
    FMOV  V2.D[1], X20
    FMOV  D3, X29
    FMOV  V3.D[1], X8
    FMOV  D4, X21
    FMOV  V4.D[1], X27
    FMOV  D5, X17
    FMOV  V5.D[1], X3
    FMOV  D6, X16
    FMOV  V6.D[1], X21
    FMOV  D7, X17
    FMOV  V7.D[1], X25
    FMOV  D8, X10
    FMOV  V8.D[1], X22
    FMOV  D9, X6
    FMOV  V9.D[1], X20
    FMOV  D10, X3
    FMOV  V10.D[1], X22
    FMOV  D11, X13
    FMOV  V11.D[1], X17
    FMOV  D12, X7
    FMOV  V12.D[1], X2
    FMOV  D13, X16
    FMOV  V13.D[1], X29
    FMOV  D14, X17
    FMOV  V14.D[1], X7
    FMOV  D15, X16
    FMOV  V15.D[1], X3
    FMOV  D16, X16
    FMOV  V16.D[1], X10
    FMOV  D17, X7
    FMOV  V17.D[1], X29
    FMOV  D18, X4
    FMOV  V18.D[1], X17
    FMOV  D19, X14
    FMOV  V19.D[1], X17
    FMOV  D20, X6
    FMOV  V20.D[1], X9
    FMOV  D21, X13
    FMOV  V21.D[1], X6
    FMOV  D22, X14
    FMOV  V22.D[1], X10
    FMOV  D23, X6
    FMOV  V23.D[1], X4
    FMOV  D24, X15
    FMOV  V24.D[1], X22
    FMOV  D25, X13
    FMOV  V25.D[1], X17
    FMOV  D26, X21
    FMOV  V26.D[1], X27
    FMOV  D27, X13
    FMOV  V27.D[1], X12
    FMOV  D28, X7
    FMOV  V28.D[1], X14
    FMOV  D29, X17
    FMOV  V29.D[1], X13
    FMOV  D30, X28
    FMOV  V30.D[1], X28
    FMOV  D31, X9
    FMOV  V31.D[1], X21
    MOVZ  X12, #0xf, LSL #0
TSRTAdvsimdVectorUnsignedOperation_label_18:
    USUBL2  V0.2D, V27.4S, V24.4S
    USHR  V28.16B, V20.16B, #6
    URSHR  V11.16B, V29.16B, #1
    UMLAL2 V5.2D, V28.4S, V30.S[0x1]
    USHL  V29.2D, V31.2D, V26.2D
    UHSUB  V3.16B, V0.16B, V22.16B
    USUBW  V20.8H, V25.8H, V29.8B
    UMLSL2 V31.2D, V3.4S, V11.S[0x3]
    USUBL  V8.4S, V5.4H, V20.4H
    UMLAL  V30.8H, V23.8B, V31.8B
    UQSHL  V29.4S, V30.4S, #0xe
    USUBW2  V16.4S, V29.4S, V29.8H
    UQXTN2  V5.8H, V8.4S
    UADDL2  V22.8H, V5.16B, V5.16B
    USUBW2  V23.8H, V16.8H, V22.16B
    URSRA V11.2D, V11.2D, #51
    UQSHRN2 V11.16B, V27.8H, #5
    URHADD  V27.8H, V4.8H, V3.8H
    UMLAL2  V29.8H, V26.16B, V20.16B
    USUBW  V24.8H, V28.8H, V19.8B
    UQSUB  V31.4H, V24.4H, V2.4H
    USHLL2 V24.8H, V8.16B, #0x6
    UMLAL2 V5.4S, V7.8H, V12.H[0x0]
    UMLSL  V19.8H, V12.8B, V0.8B
    USHLL2 V7.4S, V12.8H, #0x8
    UXTL2 V25.2D, V5.4S
    URSHR  V12.8H, V19.8H, #3
    URSRA V22.2D, V25.2D, #25
    UADDL2  V30.8H, V11.16B, V11.16B
    UMULL V19.4S, V6.4H, V12.H[0x4]
    UMULL2 V16.4S, V30.8H, V15.H[0x0]
    UADDLV  S11, V7.4H
    UQRSHRN2 V8.16B, V27.8H, #8
    UQSHRN2 V2.8H, V24.4S, #15
    UQSHRN2 V25.8H, V23.4S, #3
    URSRA V0.2D, V25.2D, #10
    USHLL2 V28.8H, V16.16B, #0x7
    USUBL2  V5.4S, V0.8H, V22.8H
    UMOV W8, V29.H[0x6]
    UXTL V15.8H, V19.8B
    URSHR  V19.16B, V11.16B, #5
    USHLL V29.4S, V8.4H, #0xe
    UMULL V25.4S, V5.4H, V2.H[0x3]
    USHLL V23.8H, V15.8B, #0x6
    UMLSL V0.4S, V31.4H, V10.H[0x2]
    UQRSHRN V27.2S, V0.2D, #7
    UQXTN  V6.8B, V23.8H
    UXTL V4.2D, V28.2S
    USHLL2 V11.2D, V25.4S, #0x11
    UQXTN2  V7.4S, V11.2D
    UMOV X8, V29.D[0x1]
    USHLL V23.4S, V27.4H, #0x2
    UMLAL V22.2D, V19.2S, V19.S[0x2]
    UABA  V28.8B, V6.8B, V6.8B
    UQSHRN V29.8B, V4.8H, #7
    USHR  V30.4H, V29.4H, #9
    USRA  V0.8H, V7.8H, #16
    UMULL  V15.4S, V23.4H, V23.4H
    URSHR  V19.16B, V22.16B, #2
    URSHR  V2.2S, V0.2S, #8
    UMULL V4.2D, V9.2S, V2.S[0x0]
    USHR  V6.8H, V15.8H, #16
    URSHR  V31.4S, V1.4S, #19
    UQRSHRN2 V23.8H, V31.4S, #14
    UADDW  V5.4S, V28.4S, V6.4H
    URSRA  V27.2S, V4.2S, #5
    UMLSL  V11.8H, V12.8B, V27.8B
    URSRA  V12.2S, V11.2S, #10
    UADDLV  D6, V12.4S
    UQSUB  V28.2S, V19.2S, V23.2S
    UMLAL2  V31.8H, V6.16B, V30.16B
    UQSHRN2 V1.4S, V5.2D, #29
    UMOV X3, V28.D[0x1]
    USHLL2 V29.8H, V16.16B, #0x5
    UMLSL V30.4S, V29.4H, V9.H[0x7]
    USHLL2 V15.8H, V30.16B, #0x2
    UMLSL V5.2D, V31.2S, V15.S[0x2]
    USHR  V31.4S, V5.4S, #7
    UQRSHRN2 V2.16B, V1.8H, #8
    USHLL2 V16.8H, V2.16B, #0x3
    UMLAL V2.2D, V31.2S, V16.S[0x0]
    UMOV W2, V11.S[0x3]
    UQSHRN V6.2S, V28.2D, #10
    UQSHRN2 V22.4S, V23.2D, #32
    UQSHL V23.2D, V3.2D, #0x8
    URSHR V19.2D, V6.2D, #39
    UMULL2 V5.2D, V16.4S, V13.S[0x3]
    UQSHRN2 V29.8H, V19.4S, #8
    UMULL2 V4.4S, V15.8H, V12.H[0x3]
    UXTL2 V0.2D, V4.4S
    UQXTN2  V28.16B, V13.8H
    UMLAL2 V1.2D, V29.4S, V20.S[0x3]
    UABD  V31.8B, V31.8B, V24.8B
    UABA  V6.2S, V3.2S, V5.2S
    UQSHRN V30.8B, V0.8H, #3
    UADDW  V0.8H, V6.8H, V29.8B
    UQXTN  V13.8B, V25.8H
    UXTL V5.8H, V22.8B
    USHLL V24.2D, V30.2S, #0x2
    UQXTN  V29.4H, V27.4S
    UMOV X13, V28.D[0x0]
    UMLAL  V4.8H, V13.8B, V24.8B
    UXTL2 V15.2D, V23.4S
    USHLL V27.8H, V0.8B, #0x1
    URSHR  V30.4H, V15.4H, #12
    UMULL2 V12.4S, V4.8H, V1.H[0x4]
    UMLAL2  V15.2D, V31.4S, V5.4S
    URSRA  V11.2S, V30.2S, #1
    URSRA  V3.4S, V29.4S, #26
    UMLSL2 V6.2D, V27.4S, V2.S[0x2]
    UQXTN  V20.2S, V6.2D
    UQRSHL  V30.2D, V20.2D, V12.2D
    USHLL2 V27.4S, V30.8H, #0xe
    UABDL2  V5.2D, V11.4S, V15.4S
    USRA  V25.2S, V3.2S, #5
    UQRSHRN2 V6.16B, V27.8H, #4
    UMULL2 V24.2D, V6.4S, V5.S[0x1]
    USHR  V0.4S, V25.4S, #29
    USHR  V2.4S, V20.4S, #25
    UHADD  V20.16B, V2.16B, V24.16B
    URSRA  V31.4H, V20.4H, #10
    USUBW  V30.8H, V31.8H, V0.8B
    UXTL V31.8H, V15.8B
    USHL  V3.2S, V19.2S, V0.2S
    UQSHRN2 V0.16B, V10.8H, #2
    URSHR  V1.8B, V20.8B, #1
    UQRSHRN V15.4H, V21.4S, #16
    USHR V29.2D, V3.2D, #55
    URSRA V5.2D, V4.2D, #36
    UMLSL V19.2D, V4.2S, V25.S[0x3]
    UQSHRN V21.2S, V4.2D, #3
    UADDW  V3.2D, V31.2D, V17.2S
    UMLSL V20.4S, V3.4H, V9.H[0x1]
    UMLSL  V25.2D, V29.2S, V0.2S
    USQADD  V4.2S, V30.2S
    UMULL2  V12.2D, V1.4S, V15.4S
    UMULL2 V10.4S, V5.8H, V5.H[0x0]
    USHLL2 V3.4S, V10.8H, #0x6
    UABDL  V2.2D, V20.2S, V25.2S
    UADDL  V24.2D, V12.2S, V19.2S
    URSHR V9.2D, V21.2D, #42
    URHADD  V17.4H, V9.4H, V4.4H
    UXTL2 V19.2D, V3.4S
    UADDL  V11.2D, V19.2S, V12.2S
    UQXTN  V29.8B, V11.8H
    UABA  V31.4S, V24.4S, V2.4S
    UQSHRN V4.8B, V31.8H, #3
    UQSHL  V4.2S, V17.2S, V17.2S
    UXTL V0.4S, V29.4H
    UQRSHRN2 V24.16B, V0.8H, #2
    UADDL2  V9.4S, V4.8H, V4.8H
    URHADD  V12.4S, V24.4S, V24.4S
    UABAL2  V24.2D, V12.4S, V12.4S
    UXTL V12.2D, V9.2S
    USQADD  V2.16B, V12.16B
    UMLAL2 V29.4S, V24.8H, V2.H[0x5]
    UQSHL  V12.4S, V2.4S, #0xf
    UADALP  V0.2D, V4.4S
    UMLSL  V21.4S, V10.4H, V8.4H
    UADDLP  V9.4H, V17.8B
    UXTL V2.8H, V17.8B
    URSRA  V19.16B, V3.16B, #5
    UXTL V8.4S, V5.4H
    UQSHRN2 V4.16B, V30.8H, #4
    URSHL  V31.4S, V12.4S, V4.4S
    UMOV W29, V9.H[0x3]
    USRA  V4.4S, V31.4S, #8
    UMLAL V31.4S, V4.4H, V8.H[0x7]
    UABDL  V24.8H, V19.8B, V2.8B
    UADDL2  V10.8H, V21.16B, V21.16B
    UQSHRN V19.2S, V29.2D, #15
    UQSHRN2 V29.16B, V19.8H, #8
    UABDL2  V19.4S, V29.8H, V0.8H
    UHADD  V29.4H, V10.4H, V19.4H
    URSRA  V11.2S, V31.2S, #10
    UQRSHRN V17.2S, V24.2D, #27
    URSHR  V24.4H, V11.4H, #11
    URHADD  V12.8B, V29.8B, V29.8B
    USHR  V10.2S, V12.2S, #29
    USHLL2 V19.4S, V17.8H, #0xc
    UMULL V17.4S, V24.4H, V10.H[0x5]
    URSRA V9.2D, V19.2D, #46
    UADDLP  V3.4S, V9.8H
    UXTL2 V8.2D, V3.4S
    USRA  V31.16B, V8.16B, #7
    UABDL  V9.8H, V31.8B, V31.8B
    UXTL2 V8.2D, V9.4S
    UHSUB  V2.4S, V17.4S, V8.4S
    UABD  V8.4H, V4.4H, V10.4H
    UMLSL  V12.8H, V23.8B, V10.8B
    USHR  V0.8H, V31.8H, #4
    USHR  V4.2S, V20.2S, #29
    URSQRTE  V23.4S, V21.4S
    UQSHL V21.2D, V4.2D, #0x14
    UABAL2  V9.4S, V11.8H, V14.8H
    USUBW2  V3.8H, V0.8H, V25.16B
    URECPE  V20.2S, V16.2S
    UQRSHRN V19.2S, V14.2D, #23
    UADDLV  S24, V19.4H
    UQRSHRN V17.4H, V24.4S, #15
    SUBS  X12, X12, #0x1
    B.NE  TSRTAdvsimdVectorUnsignedOperation_label_18
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xe020, LSL #16
    SUB  X14, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xf4ef, LSL #0
    MOVK  X23, #0xcef4, LSL #16
    MOVK  X23, #0xb2c4, LSL #32
    MOVK  X23, #0xd265, LSL #48
    SUB  X14, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x87ab, LSL #0
    MOVK  X23, #0x82d3, LSL #16
    MOVK  X23, #0xd15c, LSL #32
    MOVK  X23, #0x91f3, LSL #48
    SUB  X14, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x6175, LSL #0
    MOVK  X23, #0x4617, LSL #16
    MOVK  X23, #0x4d6c, LSL #32
    MOVK  X23, #0x7132, LSL #48
    SUB  X14, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x3e01, LSL #16
    MOVK  X23, #0xc000, LSL #32
    MOVK  X23, #0x3fff, LSL #48
    SUB  X14, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x6002, LSL #0
    MOVK  X23, #0x7b8e, LSL #16
    MOVK  X23, #0xea88, LSL #32
    MOVK  X23, #0x9562, LSL #48
    SUB  X14, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xdffb, LSL #0
    MOVK  X23, #0x5bd3, LSL #16
    MOVK  X23, #0x3d5c, LSL #32
    MOVK  X23, #0x761d, LSL #48
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x120, LSL #0
    MOVK  X23, #0x3e, LSL #16
    MOVK  X23, #0x40, LSL #32
    MOVK  X23, #0x40, LSL #48
    SUB  X14, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x32cb, LSL #0
    MOVK  X23, #0xbc73, LSL #16
    MOVK  X23, #0x150, LSL #32
    MOVK  X23, #0x91ef, LSL #48
    SUB  X14, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x22d4, LSL #0
    MOVK  X23, #0x789b, LSL #16
    MOVK  X23, #0x2bfb, LSL #32
    MOVK  X23, #0xa07b, LSL #48
    SUB  X14, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xd998, LSL #0
    MOVK  X23, #0xaa95, LSL #16
    MOVK  X23, #0x9cb1, LSL #32
    MOVK  X23, #0xb01c, LSL #48
    SUB  X14, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x887e, LSL #0
    MOVK  X23, #0xedba, LSL #16
    MOVK  X23, #0xa803, LSL #32
    MOVK  X23, #0x8b57, LSL #48
    SUB  X14, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x7a7a, LSL #0
    MOVK  X23, #0xd938, LSL #16
    MOVK  X23, #0x16b0, LSL #32
    MOVK  X23, #0x1b92, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xe188, LSL #0
    MOVK  X23, #0xfc68, LSL #16
    MOVK  X23, #0x7310, LSL #32
    MOVK  X23, #0x3c0a, LSL #48
    SUB  X14, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x9ef7, LSL #0
    MOVK  X23, #0x6841, LSL #16
    MOVK  X23, #0xd552, LSL #32
    MOVK  X23, #0xf52b, LSL #48
    SUB  X14, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x950c, LSL #0
    MOVK  X23, #0xe989, LSL #16
    MOVK  X23, #0x338a, LSL #32
    MOVK  X23, #0x4f1a, LSL #48
    SUB  X14, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x3212, LSL #0
    MOVK  X23, #0x2e36, LSL #16
    MOVK  X23, #0x6608, LSL #32
    MOVK  X23, #0xd213, LSL #48
    SUB  X14, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xfdf8, LSL #0
    MOVK  X23, #0x7acb, LSL #16
    MOVK  X23, #0x7ba, LSL #32
    MOVK  X23, #0x1046, LSL #48
    SUB  X14, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xff, LSL #0
    SUB  X14, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x800, LSL #16
    MRS  X14, FPSR
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xfff, LSL #16
    FMOV  X14, V0.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xfff, LSL #0
    MOVK  X23, #0xfff, LSL #16
    FMOV  X14, D0
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V1.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x20, LSL #0
    FMOV  X14, D1
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V2.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D2
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xfff, LSL #16
    FMOV  X14, V3.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xfff, LSL #0
    MOVK  X23, #0xfff, LSL #16
    FMOV  X14, D3
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V4.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D4
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V5.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D5
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V6.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffc0, LSL #0
    MOVK  X23, #0xff81, LSL #16
    MOVK  X23, #0xff81, LSL #32
    MOVK  X23, #0xff81, LSL #48
    FMOV  X14, D6
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V7.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D7
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V8.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xff, LSL #16
    FMOV  X14, D8
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xe479, LSL #0
    MOVK  X23, #0xd0cf, LSL #32
    FMOV  X14, V9.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x561c, LSL #0
    MOVK  X23, #0xe1f1, LSL #32
    FMOV  X14, D9
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V10.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D10
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V11.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x40, LSL #16
    FMOV  X14, D11
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V12.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D12
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V13.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D13
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x561c, LSL #0
    MOVK  X23, #0xe1f1, LSL #16
    MOVK  X23, #0xe479, LSL #32
    MOVK  X23, #0xd0cf, LSL #48
    FMOV  X14, V14.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xd998, LSL #0
    MOVK  X23, #0xaa95, LSL #16
    MOVK  X23, #0x9cb1, LSL #32
    MOVK  X23, #0xb01c, LSL #48
    FMOV  X14, D14
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V15.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D15
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V16.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D16
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V17.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x8, LSL #0
    FMOV  X14, D17
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xd998, LSL #0
    MOVK  X23, #0xaa95, LSL #16
    MOVK  X23, #0x9cb1, LSL #32
    MOVK  X23, #0xb01c, LSL #48
    FMOV  X14, V18.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xf4ef, LSL #0
    MOVK  X23, #0xcef4, LSL #16
    MOVK  X23, #0xb2c4, LSL #32
    MOVK  X23, #0xd265, LSL #48
    FMOV  X14, D18
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V19.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X14, D19
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V20.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X14, D20
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V21.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D21
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V22.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x27e, LSL #0
    MOVK  X23, #0x1fe, LSL #16
    MOVK  X23, #0x1fe, LSL #32
    MOVK  X23, #0x1fe, LSL #48
    FMOV  X14, D22
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X14, V23.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X14, D23
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V24.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xfffc, LSL #0
    MOVK  X23, #0x3, LSL #16
    FMOV  X14, D24
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V25.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x1000, LSL #0
    MOVK  X23, #0x7fc, LSL #16
    MOVK  X23, #0xffc, LSL #32
    MOVK  X23, #0x7fc, LSL #48
    FMOV  X14, D25
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x3212, LSL #0
    MOVK  X23, #0x2e36, LSL #16
    MOVK  X23, #0x6608, LSL #32
    MOVK  X23, #0xd213, LSL #48
    FMOV  X14, V26.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x7a7a, LSL #0
    MOVK  X23, #0xd938, LSL #16
    MOVK  X23, #0x16b0, LSL #32
    MOVK  X23, #0x1b92, LSL #48
    FMOV  X14, D26
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V27.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D27
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V28.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x120, LSL #0
    MOVK  X23, #0x3e, LSL #16
    MOVK  X23, #0x40, LSL #32
    MOVK  X23, #0x40, LSL #48
    FMOV  X14, D28
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V29.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D29
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V30.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x100, LSL #0
    MOVK  X23, #0x3c00, LSL #16
    MOVK  X23, #0x3fc0, LSL #32
    MOVK  X23, #0x3fc0, LSL #48
    FMOV  X14, D30
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xffff, LSL #16
    FMOV  X14, V31.D[1]
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    FMOV  X14, D31
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorUnsignedOperation_TestFail
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
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X16
    FMOV  V0.D[1], X3
    FMOV  D1, X22
    FMOV  V1.D[1], X15
    FMOV  D2, X27
    FMOV  V2.D[1], X17
    FMOV  D3, X23
    FMOV  V3.D[1], X25
    FMOV  D4, X28
    FMOV  V4.D[1], X21
    FMOV  D5, X20
    FMOV  V5.D[1], X24
    FMOV  D6, X29
    FMOV  V6.D[1], X16
    FMOV  D7, X12
    FMOV  V7.D[1], X29
    FMOV  D8, X14
    FMOV  V8.D[1], X24
    FMOV  D9, X10
    FMOV  V9.D[1], X4
    FMOV  D10, X15
    FMOV  V10.D[1], X16
    FMOV  D11, X9
    FMOV  V11.D[1], X28
    FMOV  D12, X5
    FMOV  V12.D[1], X12
    FMOV  D13, X7
    FMOV  V13.D[1], X5
    FMOV  D14, X13
    FMOV  V14.D[1], X7
    FMOV  D15, X23
    FMOV  V15.D[1], X27
    FMOV  D16, X25
    FMOV  V16.D[1], X5
    FMOV  D17, X29
    FMOV  V17.D[1], X28
    FMOV  D18, X23
    FMOV  V18.D[1], X23
    FMOV  D19, X16
    FMOV  V19.D[1], X8
    FMOV  D20, X3
    FMOV  V20.D[1], X20
    FMOV  D21, X23
    FMOV  V21.D[1], X25
    FMOV  D22, X25
    FMOV  V22.D[1], X3
    FMOV  D23, X5
    FMOV  V23.D[1], X9
    FMOV  D24, X5
    FMOV  V24.D[1], X2
    FMOV  D25, X24
    FMOV  V25.D[1], X23
    FMOV  D26, X22
    FMOV  V26.D[1], X14
    FMOV  D27, X2
    FMOV  V27.D[1], X3
    FMOV  D28, X23
    FMOV  V28.D[1], X6
    FMOV  D29, X14
    FMOV  V29.D[1], X22
    FMOV  D30, X20
    FMOV  V30.D[1], X9
    FMOV  D31, X22
    FMOV  V31.D[1], X4
    MOVZ  X22, #0xf, LSL #0
TSRTAdvsimdVectorUnsignedOperation_label_19:
    UADDW  V14.8H, V28.8H, V22.8B
    UQSHRN2 V16.8H, V19.4S, #1
    UABAL  V28.2D, V29.2S, V14.2S
    UQRSHRN V13.8B, V26.8H, #6
    URSQRTE  V5.4S, V30.4S
    UMLAL2 V7.4S, V31.8H, V13.H[0x6]
    UXTL2 V20.2D, V25.4S
    UMULL2 V14.4S, V7.8H, V4.H[0x1]
    UADDW2  V31.2D, V20.2D, V16.4S
    UQSHRN V0.4H, V28.4S, #9
    UQSHRN V2.8B, V5.8H, #4
    USUBL2  V5.2D, V0.4S, V14.4S
    UXTL2 V30.2D, V2.4S
    USHR  V22.4H, V30.4H, #16
    UABA  V5.8B, V24.8B, V31.8B
    UHSUB  V0.8H, V22.8H, V5.8H
    UQXTN2  V9.16B, V0.8H
    USHL  V5.2S, V9.2S, V9.2S
    UQSHL V26.2D, V5.2D, #0x32
    UMULL2 V5.4S, V26.8H, V14.H[0x1]
    UQSHL  V26.8H, V5.8H, #0xf
    UMULL  V5.2D, V26.2S, V13.2S
    UADDLV  H16, V5.8B
    UQSUB  V0.8B, V4.8B, V26.8B
    UQRSHL  V9.4H, V22.4H, V2.4H
    UQRSHRN2 V14.16B, V13.8H, #5
    UQSHL  V25.4S, V1.4S, #0x1a
    UADDLV  D5, V23.4S
    UQRSHRN2 V31.16B, V19.8H, #7
    UQSHL V30.2D, V6.2D, #0x24
    UQSHRN2 V26.16B, V26.8H, #8
    URSHR  V23.2S, V16.2S, #24
    UADDL2  V19.8H, V0.16B, V9.16B
    URSHL  V24.8B, V23.8B, V30.8B
    URSRA  V1.16B, V5.16B, #7
    UQSHRN2 V4.8H, V26.4S, #3
    URSRA  V5.4S, V24.4S, #5
    USHR  V9.16B, V19.16B, #3
    UMLSL  V26.2D, V5.2S, V31.2S
    UMLAL2 V30.2D, V14.4S, V14.S[0x2]
    USHLL2 V23.4S, V9.8H, #0xa
    URSQRTE  V2.4S, V23.4S
    USHLL2 V24.4S, V2.8H, #0xe
    UADDLP  V6.2D, V24.4S
    URSHR V13.2D, V25.2D, #1
    UMLAL  V31.8H, V17.8B, V1.8B
    UABD  V16.4S, V31.4S, V4.4S
    UMOV X13, V26.D[0x1]
    UMOV W6, V10.H[0x1]
    USHLL2 V23.8H, V6.16B, #0x4
    USHLL V22.4S, V13.4H, #0x4
    UQSHL  V6.8B, V30.8B, #0x3
    URSHR  V10.2S, V16.2S, #2
    UMULL2 V25.4S, V23.8H, V10.H[0x1]
    UQRSHRN V26.4H, V6.4S, #11
    USHR  V31.2S, V22.2S, #26
    UADDW2  V17.2D, V26.2D, V25.4S
    UMLSL2 V14.4S, V17.8H, V1.H[0x7]
    USHLL2 V2.2D, V31.4S, #0x1
    UMLSL  V9.2D, V2.2S, V2.2S
    URSRA V24.2D, V9.2D, #4
    UHSUB  V1.4S, V24.4S, V14.4S
    UMULL V30.4S, V9.4H, V13.H[0x7]
    UXTL V5.2D, V11.2S
    UHSUB  V2.8H, V0.8H, V21.8H
    USUBW2  V9.8H, V8.8H, V21.16B
    UABAL2  V19.8H, V17.16B, V15.16B
    UMLAL2 V17.4S, V11.8H, V7.H[0x0]
    UQRSHRN2 V15.16B, V20.8H, #8
    UABD  V4.8H, V21.8H, V7.8H
    UMULL V16.2D, V30.2S, V9.S[0x3]
    URSRA  V23.2S, V1.2S, #14
    UQRSHRN V31.8B, V5.8H, #2
    UXTL V20.4S, V2.4H
    USUBW  V24.4S, V17.4S, V20.4H
    UMULL V13.4S, V9.4H, V11.H[0x0]
    UMLAL V17.2D, V13.2S, V16.S[0x2]
    UQSHRN2 V9.8H, V23.4S, #16
    UABA  V0.16B, V9.16B, V15.16B
    USHR V21.2D, V0.2D, #35
    URECPE  V11.2S, V21.2S
    UHSUB  V0.8H, V11.8H, V19.8H
    URSQRTE  V5.4S, V4.4S
    URSHL  V20.4S, V5.4S, V24.4S
    USHLL V13.2D, V31.2S, #0xd
    URECPE  V15.4S, V20.4S
    UMLAL V9.4S, V15.4H, V15.H[0x1]
    UADDL2  V15.2D, V17.4S, V0.4S
    UQSHRN V0.2S, V13.2D, #12
    USRA  V31.16B, V9.16B, #8
    USHR  V23.4S, V15.4S, #23
    UMULL2  V4.8H, V23.16B, V0.16B
    UXTL2 V2.4S, V4.8H
    USRA  V4.2S, V31.2S, #1
    USUBW2  V8.2D, V2.2D, V4.4S
    UQRSHRN2 V31.16B, V30.8H, #4
    UMLAL V16.4S, V28.4H, V10.H[0x2]
    UMULL2  V7.2D, V20.4S, V0.4S
    UMOV W28, V17.S[0x2]
    UXTL V4.4S, V1.4H
    UQSHRN2 V1.4S, V19.2D, #15
    USHLL V13.8H, V14.8B, #0x7
    UABAL2  V9.2D, V18.4S, V19.4S
    UABAL  V15.4S, V17.4H, V9.4H
    UADDW2  V23.2D, V2.2D, V28.4S
    UADDL  V17.4S, V23.4H, V7.4H
    UABAL  V24.8H, V15.8B, V15.8B
    URSQRTE  V23.4S, V23.4S
    URSRA  V2.4H, V23.4H, #15
    USHLL V30.2D, V24.2S, #0x1f
    UMLAL V24.2D, V13.2S, V17.S[0x0]
    URHADD  V14.16B, V2.16B, V2.16B
    UQRSHRN V19.2S, V21.2D, #15
    URSRA  V18.4H, V24.4H, #8
    URSHL  V24.4H, V19.4H, V1.4H
    UADDL  V15.8H, V14.8B, V24.8B
    UMLSL2 V31.4S, V4.8H, V10.H[0x4]
    UADDLP  V10.4H, V15.8B
    URSHR  V24.16B, V18.16B, #8
    UXTL V13.8H, V30.8B
    UQSHL  V23.8B, V24.8B, #0x7
    UQRSHRN V28.4H, V23.4S, #1
    UQRSHL  V2.2D, V28.2D, V31.2D
    UADDL2  V20.4S, V8.8H, V10.8H
    UQRSHRN V7.8B, V20.8H, #3
    UMLSL V0.2D, V2.2S, V7.S[0x1]
    UQRSHRN V30.2S, V16.2D, #22
    UMULL2 V10.4S, V0.8H, V13.H[0x5]
    UXTL2 V21.2D, V17.4S
    UMOV W10, V6.H[0x2]
    URSHR V20.2D, V30.2D, #27
    URSHR V9.2D, V1.2D, #20
    UQSHRN V19.2S, V9.2D, #23
    UXTL2 V13.4S, V19.8H
    UMLAL V1.4S, V13.4H, V10.H[0x2]
    UMOV W14, V1.H[0x7]
    UADDW  V4.4S, V20.4S, V20.4H
    URHADD  V7.4S, V4.4S, V4.4S
    UADDL2  V4.4S, V21.8H, V7.8H
    UXTL2 V13.2D, V12.4S
    UMLAL V21.4S, V13.4H, V15.H[0x3]
    UMULL2  V12.4S, V18.8H, V9.8H
    URSHR  V17.2S, V2.2S, #7
    UMOV X14, V4.D[0x1]
    USHLL2 V7.8H, V24.16B, #0x4
    UQRSHRN2 V16.4S, V3.2D, #26
    USUBL  V20.4S, V13.4H, V11.4H
    UQADD  V10.2D, V20.2D, V0.2D
    UQSHRN V11.8B, V10.8H, #5
    UQSHRN2 V1.4S, V30.2D, #21
    URSRA  V15.4S, V30.4S, #14
    UQSHRN V2.4H, V27.4S, #5
    UMLAL2  V4.4S, V1.8H, V21.8H
    URSRA  V19.8H, V26.8H, #9
    UQSHL  V9.2S, V17.2S, #0x9
    UQSHL  V10.8H, V16.8H, V19.8H
    URSHR  V18.16B, V4.16B, #6
    UQSHRN2 V21.16B, V9.8H, #5
    USHLL2 V30.4S, V18.8H, #0x5
    USHLL2 V3.2D, V30.4S, #0xd
    URSHR  V19.16B, V2.16B, #3
    UMOV W2, V19.H[0x0]
    UQRSHRN2 V1.4S, V7.2D, #22
    UMLAL2  V30.2D, V11.4S, V15.4S
    UQRSHRN2 V0.4S, V3.2D, #8
    UQSHL  V9.2D, V10.2D, V30.2D
    USRA V17.2D, V1.2D, #34
    USHR  V30.8B, V0.8B, #3
    URHADD  V15.8H, V17.8H, V30.8H
    UQSHRN2 V0.8H, V15.4S, #14
    UMOV W27, V9.S[0x1]
    UADDLV  D18, V0.4S
    UMULL2 V0.4S, V21.8H, V12.H[0x6]
    USUBL2  V30.4S, V0.8H, V0.8H
    UXTL V17.2D, V18.2S
    UADDLV  H1, V16.16B
    UQSHRN2 V16.8H, V30.4S, #11
    UMLAL V4.4S, V16.4H, V1.H[0x1]
    UMULL V12.4S, V4.4H, V12.H[0x7]
    UADDLV  D4, V17.4S
    UADDLP  V15.4H, V12.8B
    URSHR  V16.4S, V4.4S, #18
    UMOV W29, V15.B[0xe]
    UMULL2 V17.4S, V29.8H, V2.H[0x5]
    UQSHL  V10.4H, V27.4H, V9.4H
    USRA  V29.2S, V16.2S, #18
    UMOV W12, V10.B[0xb]
    UQSHL V18.2D, V25.2D, #0x3f
    UMULL2 V30.2D, V31.4S, V9.S[0x2]
    UHADD  V15.8B, V20.8B, V1.8B
    URSQRTE  V12.4S, V7.4S
    USUBW2  V20.2D, V30.2D, V17.4S
    URSRA  V30.8B, V5.8B, #1
    UMULL  V25.4S, V26.4H, V17.4H
    USHLL V2.2D, V10.2S, #0x2
    UMULL2 V10.4S, V27.8H, V13.H[0x6]
    UABAL2  V0.8H, V30.16B, V25.16B
    UMOV W15, V29.H[0x3]
    UQRSHRN2 V17.16B, V0.8H, #2
    UMLAL V4.2D, V10.2S, V12.S[0x2]
    SUBS  X22, X22, #0x1
    B.NE  TSRTAdvsimdVectorUnsignedOperation_label_19
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x800, LSL #16
    MRS  X17, FPSR
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V0.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, D0
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V1.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, D1
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V2.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, D2
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V3.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, D3
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V4.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x9480, LSL #0
    MOVK  X23, #0x402, LSL #16
    FMOV  X17, D4
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x8000, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X17, V5.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X17, D5
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V6.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, D6
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V7.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, D7
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V8.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, D8
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V9.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, D9
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V10.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, D10
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V11.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xff, LSL #0
    MOVK  X23, #0xff, LSL #16
    MOVK  X23, #0xff00, LSL #32
    MOVK  X23, #0xff00, LSL #48
    FMOV  X17, D11
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X17, V12.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X17, D12
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    FMOV  X17, V13.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    FMOV  X17, D13
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V14.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x2, LSL #0
    MOVK  X23, #0x2, LSL #16
    MOVK  X23, #0x2, LSL #32
    MOVK  X23, #0x2, LSL #48
    FMOV  X17, D14
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V15.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, D15
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V16.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x101, LSL #0
    FMOV  X17, D16
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V17.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, D17
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V18.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, D18
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V19.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, D19
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V20.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, D20
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    FMOV  X17, V21.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, D21
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V22.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, D22
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V23.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x80, LSL #0
    FMOV  X17, D23
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V24.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x1, LSL #0
    FMOV  X17, D24
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V25.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, D25
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V26.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, D26
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V27.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, D27
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V28.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x40, LSL #0
    FMOV  X17, D28
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V29.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, D29
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V30.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x8080, LSL #0
    MOVK  X23, #0x8080, LSL #16
    MOVK  X23, #0x8080, LSL #32
    MOVK  X23, #0x8080, LSL #48
    FMOV  X17, D30
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V31.D[1]
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X23, #0x4040, LSL #0
    MOVK  X23, #0xffff, LSL #32
    FMOV  X17, D31
    SUB  X4, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
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
    FMOV  D1, X29
    FMOV  V1.D[1], X27
    FMOV  D2, X15
    FMOV  V2.D[1], X22
    FMOV  D3, X24
    FMOV  V3.D[1], X7
    FMOV  D4, X13
    FMOV  V4.D[1], X7
    FMOV  D5, X9
    FMOV  V5.D[1], X7
    FMOV  D6, X2
    FMOV  V6.D[1], X14
    FMOV  D7, X24
    FMOV  V7.D[1], X12
    FMOV  D8, X23
    FMOV  V8.D[1], X16
    FMOV  D9, X21
    FMOV  V9.D[1], X13
    FMOV  D10, X13
    FMOV  V10.D[1], X20
    FMOV  D11, X25
    FMOV  V11.D[1], X8
    FMOV  D12, X16
    FMOV  V12.D[1], X6
    FMOV  D13, X27
    FMOV  V13.D[1], X9
    FMOV  D14, X9
    FMOV  V14.D[1], X3
    FMOV  D15, X21
    FMOV  V15.D[1], X14
    FMOV  D16, X17
    FMOV  V16.D[1], X5
    FMOV  D17, X29
    FMOV  V17.D[1], X12
    FMOV  D18, X8
    FMOV  V18.D[1], X3
    FMOV  D19, X20
    FMOV  V19.D[1], X27
    FMOV  D20, X24
    FMOV  V20.D[1], X21
    FMOV  D21, X23
    FMOV  V21.D[1], X27
    FMOV  D22, X3
    FMOV  V22.D[1], X16
    FMOV  D23, X28
    FMOV  V23.D[1], X20
    FMOV  D24, X17
    FMOV  V24.D[1], X17
    FMOV  D25, X27
    FMOV  V25.D[1], X14
    FMOV  D26, X2
    FMOV  V26.D[1], X22
    FMOV  D27, X23
    FMOV  V27.D[1], X10
    FMOV  D28, X20
    FMOV  V28.D[1], X6
    FMOV  D29, X29
    FMOV  V29.D[1], X7
    FMOV  D30, X25
    FMOV  V30.D[1], X5
    FMOV  D31, X14
    FMOV  V31.D[1], X7
    MOVZ  X5, #0xf, LSL #0
TSRTAdvsimdVectorUnsignedOperation_label_20:
    URSHR  V30.4S, V26.4S, #15
    URSQRTE  V11.2S, V18.2S
    UQSHL V19.2D, V24.2D, #0x37
    UABA  V2.8B, V31.8B, V20.8B
    URSRA  V28.16B, V11.16B, #4
    UADDLP  V2.1D, V28.2S
    URSHR  V25.4H, V29.4H, #15
    USQADD  V29.16B, V30.16B
    UQSHL  V22.4H, V27.4H, #0x2
    UMLAL2 V26.4S, V29.8H, V2.H[0x1]
    UQSHRN V24.8B, V23.8H, #4
    UXTL V3.2D, V3.2S
    URSHR V28.2D, V19.2D, #9
    URSRA  V30.4S, V16.4S, #31
    UMLSL V4.4S, V3.4H, V10.H[0x4]
    UADALP  V24.1D, V26.2S
    UMULL2 V23.2D, V24.4S, V24.S[0x0]
    URSRA  V10.8B, V30.8B, #5
    UXTL2 V29.2D, V10.4S
    UQSHL  V12.8H, V28.8H, V29.8H
    URSRA  V24.2S, V23.2S, #24
    UMULL  V20.2D, V22.2S, V30.2S
    URSRA  V2.4S, V4.4S, #28
    USUBW2  V4.4S, V2.4S, V20.8H
    UXTL2 V11.4S, V24.8H
    UABDL2  V28.4S, V11.8H, V12.8H
    UMLAL  V12.2D, V28.2S, V25.2S
    UXTL2 V3.2D, V12.4S
    UADDLV  H24, V3.16B
    UMLSL V11.4S, V4.4H, V4.H[0x4]
    UABDL2  V19.2D, V24.4S, V11.4S
    UQRSHRN2 V20.4S, V28.2D, #15
    URSHL  V23.16B, V8.16B, V21.16B
    UMOV X12, V10.D[0x1]
    UQSHRN2 V29.16B, V27.8H, #7
    UQSHRN V26.4H, V16.4S, #11
    UABAL  V8.2D, V7.2S, V2.2S
    UMLSL  V12.2D, V20.2S, V3.2S
    UMLSL2 V22.4S, V10.8H, V10.H[0x5]
    UMLAL2  V18.8H, V24.16B, V27.16B
    UMLSL2 V27.2D, V4.4S, V22.S[0x3]
    UQSHL  V22.4H, V27.4H, #0xc
    UQRSHL  V25.2D, V19.2D, V21.2D
    UMULL V16.4S, V7.4H, V15.H[0x2]
    USHL  V3.16B, V8.16B, V23.16B
    UMOV W8, V26.S[0x1]
    URSHL  V24.8B, V29.8B, V3.8B
    UADDW  V7.2D, V25.2D, V24.2S
    USHR V26.2D, V12.2D, #14
    USHR V23.2D, V18.2D, #59
    USQADD  V3.8B, V23.8B
    UQSUB  V24.16B, V3.16B, V3.16B
    UMOV X24, V24.D[0x1]
    USUBL  V20.2D, V22.2S, V22.2S
    URSHL  V11.8H, V16.8H, V26.8H
    UADDW2  V8.4S, V7.4S, V20.8H
    UABD  V24.16B, V8.16B, V8.16B
    UMLAL V16.4S, V24.4H, V11.H[0x5]
    URSHR  V7.4H, V18.4H, #14
    UMULL2 V29.4S, V28.8H, V1.H[0x2]
    UQXTN  V12.4H, V23.4S
    UQSHL  V15.4S, V23.4S, V26.4S
    URSHR V1.2D, V16.2D, #60
    UMLAL V26.4S, V22.4H, V9.H[0x4]
    USHLL V28.2D, V13.2S, #0x6
    UQRSHRN V3.4H, V0.4S, #2
    UQSHRN2 V25.16B, V26.8H, #6
    UQRSHRN2 V26.16B, V14.8H, #2
    URSHR V27.2D, V3.2D, #39
    UMLSL2  V8.8H, V7.16B, V7.16B
    UABDL2  V7.4S, V27.8H, V1.8H
    UQRSHRN2 V24.16B, V29.8H, #4
    UMLAL2 V11.4S, V8.8H, V6.H[0x3]
    UMLAL  V18.4S, V12.4H, V7.4H
    UMLSL V9.2D, V15.2S, V24.S[0x0]
    USQADD  V29.4S, V26.4S
    UQRSHL  V27.4S, V21.4S, V25.4S
    UQRSHL  V0.2S, V9.2S, V28.2S
    UHSUB  V15.8B, V0.8B, V0.8B
    UADDLP  V0.2S, V15.4H
    UMLSL V20.2D, V0.2S, V0.S[0x3]
    UABD  V26.2S, V11.2S, V11.2S
    URSHR  V16.4S, V26.4S, #26
    UMULL2  V0.4S, V16.8H, V16.8H
    URSHR  V11.8H, V0.8H, #14
    UHADD  V23.4H, V11.4H, V11.4H
    UXTL V22.2D, V27.2S
    UQSHL V1.2D, V29.2D, #0x18
    URSRA V7.2D, V22.2D, #44
    URSRA  V15.4H, V7.4H, #2
    USUBW  V14.4S, V23.4S, V15.4H
    UMLAL2  V0.4S, V18.8H, V14.8H
    USRA V24.2D, V0.2D, #29
    USRA  V22.16B, V20.16B, #1
    UADALP  V21.2S, V1.4H
    UQSHL  V20.16B, V24.16B, #0x5
    USHLL V7.8H, V22.8B, #0x3
    UMLSL2 V11.2D, V21.4S, V20.S[0x3]
    UMULL2  V22.4S, V17.8H, V11.8H
    UQSHRN2 V14.8H, V22.4S, #15
    URHADD  V23.8H, V7.8H, V7.8H
    UMLAL2 V26.2D, V14.4S, V23.S[0x2]
    UQSHL  V24.2S, V15.2S, #0xc
    UADDLV  S18, V31.8H
    UXTL2 V16.4S, V28.8H
    UXTL V31.8H, V27.8B
    UMLAL2 V21.4S, V15.8H, V10.H[0x5]
    UABD  V0.2S, V24.2S, V22.2S
    UQRSHRN2 V20.16B, V28.8H, #2
    UXTL2 V22.4S, V16.8H
    UHSUB  V1.2S, V16.2S, V11.2S
    USUBL  V28.4S, V9.4H, V10.4H
    UABAL2  V9.4S, V18.8H, V23.8H
    UQRSHRN V14.4H, V1.4S, #12
    UMLSL V15.2D, V20.2S, V0.S[0x2]
    UMLSL2  V10.2D, V15.4S, V22.4S
    USHLL2 V18.8H, V31.16B, #0x2
    UMULL2 V24.2D, V26.4S, V10.S[0x3]
    UQSHL  V16.16B, V28.16B, #0x5
    USRA V31.2D, V14.2D, #13
    UQRSHRN2 V11.16B, V5.8H, #1
    URECPE  V23.4S, V20.4S
    UADDLV  H10, V21.16B
    UQSHRN2 V22.4S, V18.2D, #17
    UHADD  V28.4H, V10.4H, V28.4H
    UXTL2 V20.2D, V9.4S
    UMLAL2 V10.4S, V28.8H, V0.H[0x2]
    UMULL2  V28.2D, V23.4S, V31.4S
    UADDLV  S21, V20.8H
    UQSUB  V9.4H, V24.4H, V21.4H
    URSHL  V1.8H, V22.8H, V12.8H
    URSHL  V24.4S, V16.4S, V28.4S
    UMLAL2 V14.2D, V11.4S, V24.S[0x2]
    UXTL V16.4S, V1.4H
    UQRSHL  V31.2D, V10.2D, V10.2D
    USRA  V1.16B, V16.16B, #5
    UQSHRN2 V18.8H, V1.4S, #14
    UMULL V5.2D, V18.2S, V9.S[0x1]
    UMLAL2 V9.4S, V5.8H, V14.H[0x7]
    USRA  V11.16B, V9.16B, #6
    USHL  V0.2D, V31.2D, V11.2D
    UQSHL  V28.8H, V15.8H, #0x1
    UQRSHRN2 V23.8H, V27.4S, #10
    USHR  V24.4S, V25.4S, #32
    UXTL2 V21.8H, V24.16B
    UQRSHL  V25.16B, V18.16B, V21.16B
    UMULL2 V26.4S, V6.8H, V3.H[0x6]
    UMLSL V15.2D, V19.2S, V10.S[0x0]
    UADDLP  V22.1D, V20.2S
    URSRA V31.2D, V26.2D, #24
    UMLAL V11.2D, V22.2S, V26.S[0x0]
    UQSHRN V5.2S, V1.2D, #17
    UMULL V10.4S, V20.4H, V15.H[0x2]
    UABDL2  V12.4S, V17.8H, V14.8H
    UMOV X14, V0.D[0x0]
    UMULL  V27.2D, V12.2S, V23.2S
    USHLL V3.2D, V28.2S, #0x18
    UADALP  V16.8H, V3.16B
    UMULL  V17.4S, V10.4H, V16.4H
    UMLSL V15.4S, V17.4H, V2.H[0x6]
    UMOV W12, V12.S[0x3]
    USUBL  V14.4S, V11.4H, V15.4H
    USHLL V9.2D, V25.2S, #0x2
    UADDLV  S23, V9.8H
    USHLL V26.8H, V14.8B, #0x6
    UMULL2  V6.4S, V26.8H, V27.8H
    URSRA V21.2D, V5.2D, #36
    UQADD  V16.4S, V31.4S, V31.4S
    UADDW2  V20.4S, V16.4S, V6.8H
    USHLL V16.2D, V23.2S, #0x16
    URSHR  V5.2S, V21.2S, #4
    UMOV W24, V5.S[0x0]
    URSHR V11.2D, V16.2D, #6
    UQRSHRN2 V0.16B, V11.8H, #3
    UADDLV  D23, V20.4S
    UXTL V22.8H, V7.8B
    UQRSHRN V19.2S, V0.2D, #30
    UMULL2 V6.2D, V22.4S, V23.S[0x1]
    UQXTN  V11.8B, V6.8H
    UADDLP  V16.4H, V19.8B
    UXTL V15.2D, V11.2S
    URSHR  V7.8H, V16.8H, #3
    UADDL2  V22.4S, V15.8H, V15.8H
    UMLSL2 V28.4S, V7.8H, V7.H[0x2]
    UQSHL V21.2D, V28.2D, #0xd
    UABAL2  V19.4S, V29.8H, V22.8H
    UXTL2 V22.8H, V19.16B
    UADDLP  V31.4S, V21.8H
    UQSHL  V11.4H, V22.4H, #0x8
    USHLL V21.4S, V31.4H, #0x7
    UMLAL  V22.8H, V21.8B, V21.8B
    UQXTN  V26.8B, V22.8H
    USQADD  V20.8B, V11.8B
    UHSUB  V7.8B, V26.8B, V20.8B
    UMLAL2 V28.4S, V12.8H, V12.H[0x7]
    UQSHRN V31.2S, V5.2D, #29
    UXTL V23.4S, V0.4H
    USHLL V5.8H, V17.8B, #0x6
    UMLAL V16.4S, V13.4H, V6.H[0x0]
    UQRSHRN2 V29.4S, V17.2D, #7
    SUBS  X5, X5, #0x1
    B.NE  TSRTAdvsimdVectorUnsignedOperation_label_20
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x800, LSL #16
    MRS  X16, FPSR
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V0.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D0
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V1.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x40, LSL #0
    FMOV  X16, D1
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V2.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x2022, LSL #0
    MOVK  X22, #0x2020, LSL #16
    FMOV  X16, D2
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V3.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D3
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V4.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x2022, LSL #0
    MOVK  X22, #0x2020, LSL #16
    FMOV  X16, D4
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V5.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D5
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V6.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D6
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V7.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D7
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V8.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D8
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V9.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D9
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V10.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D10
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V11.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D11
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V12.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D12
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    FMOV  X16, V13.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    FMOV  X16, D13
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V14.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D14
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V15.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D15
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V16.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D16
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V17.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D17
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V18.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D18
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V19.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D19
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V20.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D20
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V21.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D21
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V22.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D22
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V23.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D23
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V24.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D24
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V25.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D25
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V26.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D26
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V27.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D27
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V28.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D28
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V29.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D29
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V30.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D30
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, V31.D[1]
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X16, D31
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorUnsignedOperation_TestFail

TSRTAdvsimdVectorUnsignedOperation_TestEnd:
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
TSRTAdvsimdVectorUnsignedOperation_TestFail:
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
