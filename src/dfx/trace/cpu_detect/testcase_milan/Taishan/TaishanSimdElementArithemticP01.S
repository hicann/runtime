.global TaishanSimdElementArithemticP01

.text
.p2align 4

TaishanSimdElementArithemticP01:

TaishanSimdElementArithemticP01_TestBegin:
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
    MOVK  X2, #0x1f71, LSL #48
    MOVK  X2, #0x3af5, LSL #32
    MOVK  X2, #0x46b9, LSL #16
    MOVK  X2, #0xad5f, LSL #0
    MOVK  X3, #0x1321, LSL #48
    MOVK  X3, #0xe817, LSL #32
    MOVK  X3, #0x3142, LSL #16
    MOVK  X3, #0x908a, LSL #0
    MOVK  X4, #0x32dd, LSL #48
    MOVK  X4, #0xe43e, LSL #32
    MOVK  X4, #0xaa99, LSL #16
    MOVK  X4, #0x2b5b, LSL #0
    MOVK  X5, #0x7f4d, LSL #48
    MOVK  X5, #0x65f7, LSL #32
    MOVK  X5, #0x7292, LSL #16
    MOVK  X5, #0x4b8c, LSL #0
    MOVK  X6, #0x5b96, LSL #48
    MOVK  X6, #0x7993, LSL #32
    MOVK  X6, #0x8f80, LSL #16
    MOVK  X6, #0x8ad7, LSL #0
    MOVK  X7, #0xffe3, LSL #48
    MOVK  X7, #0x24fb, LSL #32
    MOVK  X7, #0x66ab, LSL #16
    MOVK  X7, #0xd8c4, LSL #0
    MOVK  X8, #0xdb4c, LSL #48
    MOVK  X8, #0x3fa1, LSL #32
    MOVK  X8, #0xa273, LSL #16
    MOVK  X8, #0xf41b, LSL #0
    MOVK  X9, #0x5391, LSL #48
    MOVK  X9, #0xb7b1, LSL #32
    MOVK  X9, #0xfb11, LSL #16
    MOVK  X9, #0x607, LSL #0
    MOVK  X10, #0xbcd3, LSL #48
    MOVK  X10, #0x55df, LSL #32
    MOVK  X10, #0x19a3, LSL #16
    MOVK  X10, #0xd29c, LSL #0
    MOVK  X11, #0x7eb0, LSL #48
    MOVK  X11, #0x4989, LSL #32
    MOVK  X11, #0xccda, LSL #16
    MOVK  X11, #0x49c3, LSL #0
    MOVK  X12, #0xf84d, LSL #48
    MOVK  X12, #0x1a2b, LSL #32
    MOVK  X12, #0x1092, LSL #16
    MOVK  X12, #0x7199, LSL #0
    MOVK  X13, #0x84f9, LSL #48
    MOVK  X13, #0x99b4, LSL #32
    MOVK  X13, #0xf8d4, LSL #16
    MOVK  X13, #0x1e72, LSL #0
    MOVK  X14, #0x57ee, LSL #48
    MOVK  X14, #0x1580, LSL #32
    MOVK  X14, #0xb1f1, LSL #16
    MOVK  X14, #0xcfc3, LSL #0
    MOVK  X15, #0xb4a0, LSL #48
    MOVK  X15, #0x5af5, LSL #32
    MOVK  X15, #0x755a, LSL #16
    MOVK  X15, #0xb64f, LSL #0
    MOVK  X16, #0xa220, LSL #48
    MOVK  X16, #0xfec4, LSL #32
    MOVK  X16, #0xec41, LSL #16
    MOVK  X16, #0xff6f, LSL #0
    MOVK  X17, #0x6c3a, LSL #48
    MOVK  X17, #0x8484, LSL #32
    MOVK  X17, #0x23e6, LSL #16
    MOVK  X17, #0xa525, LSL #0
    MOVK  X18, #0xa129, LSL #48
    MOVK  X18, #0x9f2d, LSL #32
    MOVK  X18, #0x4c7a, LSL #16
    MOVK  X18, #0x5c54, LSL #0
    MOVK  X20, #0xcb97, LSL #48
    MOVK  X20, #0xe59e, LSL #32
    MOVK  X20, #0x7422, LSL #16
    MOVK  X20, #0x9a45, LSL #0
    MOVK  X21, #0x270f, LSL #48
    MOVK  X21, #0xf193, LSL #32
    MOVK  X21, #0x8847, LSL #16
    MOVK  X21, #0x45a3, LSL #0
    MOVK  X22, #0x432c, LSL #48
    MOVK  X22, #0xa97a, LSL #32
    MOVK  X22, #0xc795, LSL #16
    MOVK  X22, #0xe856, LSL #0
    MOVK  X23, #0xac02, LSL #48
    MOVK  X23, #0x90ae, LSL #32
    MOVK  X23, #0xcb34, LSL #16
    MOVK  X23, #0xfb63, LSL #0
    MOVK  X24, #0x5c83, LSL #48
    MOVK  X24, #0x80a7, LSL #32
    MOVK  X24, #0x2ea9, LSL #16
    MOVK  X24, #0x985a, LSL #0
    MOVK  X25, #0xc338, LSL #48
    MOVK  X25, #0xda73, LSL #32
    MOVK  X25, #0xc84, LSL #16
    MOVK  X25, #0xd6ee, LSL #0
    MOVK  X26, #0x71c7, LSL #48
    MOVK  X26, #0x21da, LSL #32
    MOVK  X26, #0x29d4, LSL #16
    MOVK  X26, #0x75f5, LSL #0
    MOVK  X27, #0x8a35, LSL #48
    MOVK  X27, #0x4ade, LSL #32
    MOVK  X27, #0xb3f4, LSL #16
    MOVK  X27, #0xa4b1, LSL #0
    MOVK  X28, #0xff60, LSL #48
    MOVK  X28, #0x26a1, LSL #32
    MOVK  X28, #0x9c95, LSL #16
    MOVK  X28, #0x4951, LSL #0
    MOVK  X29, #0xa70a, LSL #48
    MOVK  X29, #0xe4b0, LSL #32
    MOVK  X29, #0x50ee, LSL #16
    MOVK  X29, #0xfc20, LSL #0
    SUBS  W28, W28, W6, ASR #6
    MOVZ  X17, #0x50d3, LSL #0
    MOVK  X17, #0xe476, LSL #16
    MSR  FPCR, X17
    MRS  X4, FPSR
    MOVZ  X9, #0xff60, LSL #0
    MOVK  X9, #0x7ff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    AND  X4, X4, X9
    MOVZ  X9, #0x0, LSL #0
    ORR  X4, X4, X9
    MSR  FPSR, X4
    ISB  SY
    MOVZ  X2, #0x4f62, LSL #0
    MOVK  X2, #0x2eac, LSL #16
    MOVK  X2, #0x91da, LSL #32
    MOVK  X2, #0xe29e, LSL #48
    MOVZ  X3, #0x3c14, LSL #0
    MOVK  X3, #0x50bb, LSL #16
    MOVK  X3, #0x973c, LSL #32
    MOVK  X3, #0x5520, LSL #48
    MOVZ  X4, #0xe6a8, LSL #0
    MOVK  X4, #0x159b, LSL #16
    MOVK  X4, #0x8580, LSL #32
    MOVK  X4, #0x5c49, LSL #48
    MOVZ  X5, #0x7a25, LSL #0
    MOVK  X5, #0x3d50, LSL #16
    MOVK  X5, #0xba25, LSL #32
    MOVK  X5, #0xd8a, LSL #48
    MOVZ  X6, #0xfd08, LSL #0
    MOVK  X6, #0xc028, LSL #16
    MOVK  X6, #0x830, LSL #32
    MOVK  X6, #0xa456, LSL #48
    MOVZ  X7, #0xdd63, LSL #0
    MOVK  X7, #0xa819, LSL #16
    MOVK  X7, #0xe387, LSL #32
    MOVK  X7, #0xfb2a, LSL #48
    MOVZ  X8, #0x3c71, LSL #0
    MOVK  X8, #0xe259, LSL #16
    MOVK  X8, #0xf780, LSL #32
    MOVK  X8, #0x9002, LSL #48
    MOVZ  X9, #0x65b6, LSL #0
    MOVK  X9, #0xcf82, LSL #16
    MOVK  X9, #0xf2dd, LSL #32
    MOVK  X9, #0xad32, LSL #48
    MOVZ  X10, #0x2894, LSL #0
    MOVK  X10, #0xba61, LSL #16
    MOVK  X10, #0x5bf0, LSL #32
    MOVK  X10, #0x5b94, LSL #48
    MOVZ  X11, #0x2635, LSL #0
    MOVK  X11, #0x8fd1, LSL #16
    MOVK  X11, #0x1a35, LSL #32
    MOVK  X11, #0x9a6f, LSL #48
    MOVZ  X12, #0xc53d, LSL #0
    MOVK  X12, #0x457d, LSL #16
    MOVK  X12, #0xe210, LSL #32
    MOVK  X12, #0xd727, LSL #48
    MOVZ  X13, #0xdc74, LSL #0
    MOVK  X13, #0xdb15, LSL #16
    MOVK  X13, #0xbeb3, LSL #32
    MOVK  X13, #0xc6ba, LSL #48
    MOVZ  X14, #0xd528, LSL #0
    MOVK  X14, #0x2eff, LSL #16
    MOVK  X14, #0x55a9, LSL #32
    MOVK  X14, #0xd414, LSL #48
    MOVZ  X15, #0x476e, LSL #0
    MOVK  X15, #0x9903, LSL #16
    MOVK  X15, #0x544f, LSL #32
    MOVK  X15, #0x21e2, LSL #48
    MOVZ  X16, #0x38a3, LSL #0
    MOVK  X16, #0x1ff0, LSL #16
    MOVK  X16, #0x4223, LSL #32
    MOVK  X16, #0x6e2e, LSL #48
    MOVZ  X17, #0xdc24, LSL #0
    MOVK  X17, #0x6168, LSL #16
    MOVK  X17, #0xe828, LSL #32
    MOVK  X17, #0x19d2, LSL #48
    MOVZ  X18, #0xfe85, LSL #0
    MOVK  X18, #0xcbd6, LSL #16
    MOVK  X18, #0xcd37, LSL #32
    MOVK  X18, #0x8218, LSL #48
    MOVZ  X20, #0x9341, LSL #0
    MOVK  X20, #0xa91f, LSL #16
    MOVK  X20, #0x9a3f, LSL #32
    MOVK  X20, #0x74f2, LSL #48
    MOVZ  X21, #0x6d38, LSL #0
    MOVK  X21, #0xbab3, LSL #16
    MOVK  X21, #0xab04, LSL #32
    MOVK  X21, #0x3532, LSL #48
    MOVZ  X22, #0xa174, LSL #0
    MOVK  X22, #0xb2e3, LSL #16
    MOVK  X22, #0x89c0, LSL #32
    MOVK  X22, #0x1e3c, LSL #48
    MOVZ  X23, #0x8c3c, LSL #0
    MOVK  X23, #0xcea6, LSL #16
    MOVK  X23, #0x7948, LSL #32
    MOVK  X23, #0x614d, LSL #48
    MOVZ  X24, #0x4a3d, LSL #0
    MOVK  X24, #0xe87b, LSL #16
    MOVK  X24, #0x6777, LSL #32
    MOVK  X24, #0x9db1, LSL #48
    MOVZ  X25, #0x13a8, LSL #0
    MOVK  X25, #0xe082, LSL #16
    MOVK  X25, #0x7184, LSL #32
    MOVK  X25, #0xbd47, LSL #48
    MOVZ  X26, #0xdd32, LSL #0
    MOVK  X26, #0xe32c, LSL #16
    MOVK  X26, #0x8bb1, LSL #32
    MOVK  X26, #0x2c69, LSL #48
    MOVZ  X27, #0x2834, LSL #0
    MOVK  X27, #0xc09b, LSL #16
    MOVK  X27, #0x824, LSL #32
    MOVK  X27, #0x6fad, LSL #48
    MOVZ  X28, #0x3428, LSL #0
    MOVK  X28, #0x68c6, LSL #16
    MOVK  X28, #0xb1e3, LSL #32
    MOVK  X28, #0xe642, LSL #48
    MOVZ  X29, #0x492b, LSL #0
    MOVK  X29, #0xae6d, LSL #16
    MOVK  X29, #0x8c30, LSL #32
    MOVK  X29, #0x3e99, LSL #48
    FMOV  D0, X3
    FMOV  V0.D[1], X20
    FMOV  D1, X21
    FMOV  V1.D[1], X17
    FMOV  D2, X29
    FMOV  V2.D[1], X14
    FMOV  D3, X25
    FMOV  V3.D[1], X24
    FMOV  D4, X27
    FMOV  V4.D[1], X28
    FMOV  D5, X24
    FMOV  V5.D[1], X12
    FMOV  D6, X3
    FMOV  V6.D[1], X14
    FMOV  D7, X8
    FMOV  V7.D[1], X6
    FMOV  D8, X14
    FMOV  V8.D[1], X21
    FMOV  D9, X25
    FMOV  V9.D[1], X27
    FMOV  D10, X28
    FMOV  V10.D[1], X3
    FMOV  D11, X2
    FMOV  V11.D[1], X4
    FMOV  D12, X24
    FMOV  V12.D[1], X13
    FMOV  D13, X5
    FMOV  V13.D[1], X23
    FMOV  D14, X26
    FMOV  V14.D[1], X10
    FMOV  D15, X6
    FMOV  V15.D[1], X9
    FMOV  D16, X28
    FMOV  V16.D[1], X12
    FMOV  D17, X14
    FMOV  V17.D[1], X2
    FMOV  D18, X23
    FMOV  V18.D[1], X4
    FMOV  D19, X24
    FMOV  V19.D[1], X9
    FMOV  D20, X5
    FMOV  V20.D[1], X24
    FMOV  D21, X27
    FMOV  V21.D[1], X21
    FMOV  D22, X10
    FMOV  V22.D[1], X27
    FMOV  D23, X13
    FMOV  V23.D[1], X4
    FMOV  D24, X3
    FMOV  V24.D[1], X17
    FMOV  D25, X26
    FMOV  V25.D[1], X16
    FMOV  D26, X10
    FMOV  V26.D[1], X13
    FMOV  D27, X21
    FMOV  V27.D[1], X23
    FMOV  D28, X10
    FMOV  V28.D[1], X11
    FMOV  D29, X9
    FMOV  V29.D[1], X27
    FMOV  D30, X13
    FMOV  V30.D[1], X29
    FMOV  D31, X2
    FMOV  V31.D[1], X4
    MOVZ  X23, #0xa, LSL #0
TaishanSimdElementArithemticP01_label_0:
    UMAXV  B8, V29.16B
    ADDV  S29, V21.4S
    SMINV  H26, V27.4H
    UMAXV  B19, V30.8B
    UMAXV  S22, V5.4S
    FMAXNMV  S21, V1.4S
    UMAXV  B16, V29.16B
    SMINV  S7, V26.4S
    ADDV  S25, V9.4S
    SMAXV  S3, V19.4S
    SMINV  B5, V16.16B
    ADDV  H31, V18.4H
    ADDV  B24, V13.16B
    UMAXV  S21, V21.4S
    SMAXV  H27, V30.8H
    SADDLV  D7, V26.4S
    UADDLV  S13, V10.8H
    UMINV  H24, V20.4H
    UMAXV  H16, V7.8H
    UMAXV  H13, V30.4H
    FMINV  S30, V28.4S
    UADDLV  S2, V24.4H
    SMINV  B2, V22.16B
    UADDLV  D6, V12.4S
    SMINV  B21, V8.16B
    SMAXV  S7, V27.4S
    UMAXV  B14, V30.8B
    UMINV  S25, V24.4S
    FMAXNMV  S21, V7.4S
    FMAXNMV  S22, V0.4S
    UMINV  H29, V15.8H
    UADDLV  S26, V17.8H
    FMINNMV  S1, V1.4S
    UMINV  B6, V1.8B
    FMINNMV  S7, V31.4S
    SMAXV  S3, V25.4S
    SMINV  S4, V3.4S
    FMINV  S21, V4.4S
    SMAXV  S23, V21.4S
    ADDV  H23, V1.8H
    SMINV  S8, V29.4S
    UMAXV  H15, V13.4H
    SADDLV  D29, V28.4S
    ADDV  H29, V21.8H
    UMAXV  H9, V30.8H
    ADDV  S7, V17.4S
    UADDLV  H22, V0.8B
    UMINV  S15, V12.4S
    SMINV  B2, V0.16B
    SMAXV  S9, V4.4S
    UADDLV  D26, V24.4S
    UMINV  H20, V18.8H
    ADDV  H28, V30.8H
    ADDV  H6, V14.4H
    UMAXV  S29, V23.4S
    ADDV  S19, V14.4S
    FMINV  S21, V31.4S
    SADDLV  S2, V15.4H
    UADDLV  S1, V9.8H
    UMAXV  B22, V3.16B
    UMINV  B7, V20.8B
    SMINV  H20, V12.8H
    SMAXV  H19, V31.8H
    UADDLV  H6, V1.8B
    UMINV  H19, V21.4H
    SMAXV  B23, V2.8B
    UADDLV  H22, V15.8B
    ADDV  B20, V8.8B
    FMINNMV  S9, V19.4S
    UADDLV  S6, V22.4H
    FMINV  S29, V12.4S
    UMAXV  H9, V3.8H
    FMAXNMV  S12, V4.4S
    SMAXV  B18, V5.16B
    UADDLV  S21, V20.8H
    UADDLV  D0, V7.4S
    UMAXV  H2, V20.4H
    SADDLV  S20, V12.8H
    SADDLV  D23, V15.4S
    ADDV  H7, V15.4H
    SMAXV  S22, V9.4S
    FMINV  S7, V19.4S
    SADDLV  D31, V12.4S
    SADDLV  D0, V8.4S
    ADDV  B15, V7.8B
    SADDLV  H19, V25.16B
    SADDLV  H2, V8.8B
    UADDLV  D0, V6.4S
    FMINNMV  S23, V24.4S
    SADDLV  S11, V30.4H
    SADDLV  D10, V2.4S
    FMAXV  S13, V0.4S
    UADDLV  H20, V14.16B
    UMAXV  B23, V21.16B
    SMINV  S18, V11.4S
    SMAXV  H18, V17.8H
    SADDLV  H31, V1.8B
    UMINV  S21, V13.4S
    SADDLV  D18, V10.4S
    SMINV  S7, V29.4S
    ADDV  S9, V16.4S
    FMINV  S3, V1.4S
    FMINNMV  S31, V7.4S
    UMAXV  B13, V31.16B
    FMINNMV  S2, V7.4S
    SMINV  B12, V21.8B
    UADDLV  H18, V9.8B
    UMAXV  B24, V7.16B
    SMINV  S5, V24.4S
    UADDLV  H21, V10.8B
    UMAXV  B27, V3.8B
    SMAXV  B29, V30.8B
    UMAXV  S21, V1.4S
    UADDLV  S31, V19.8H
    FMINNMV  S6, V5.4S
    FMINNMV  S28, V5.4S
    SMAXV  B16, V24.16B
    FMAXNMV  S5, V10.4S
    ADDV  H21, V21.4H
    ADDV  S23, V0.4S
    SMINV  S15, V28.4S
    FMINV  S5, V15.4S
    UMINV  H31, V16.4H
    UMINV  H26, V26.8H
    UMINV  B6, V28.16B
    UMINV  S25, V31.4S
    FMINV  S20, V28.4S
    SADDLV  H15, V29.8B
    SMINV  S31, V3.4S
    SADDLV  S6, V23.8H
    UADDLV  S0, V6.8H
    UMAXV  H3, V4.4H
    SMINV  S19, V0.4S
    SMAXV  S16, V28.4S
    FMAXNMV  S24, V6.4S
    UMINV  H8, V11.4H
    ADDV  H12, V27.4H
    FMINV  S23, V19.4S
    SMINV  B0, V12.16B
    ADDV  H12, V4.4H
    ADDV  B1, V16.16B
    FMAXV  S24, V5.4S
    ADDV  S12, V25.4S
    UADDLV  S20, V2.8H
    UADDLV  H23, V11.8B
    UMAXV  S6, V16.4S
    ADDV  H25, V2.4H
    ADDV  S14, V28.4S
    UADDLV  D15, V20.4S
    SADDLV  S30, V25.4H
    UMAXV  H28, V25.4H
    UMAXV  B11, V26.16B
    SADDLV  H10, V26.8B
    UMINV  S20, V26.4S
    SADDLV  H8, V26.16B
    FMAXNMV  S23, V3.4S
    SMINV  B16, V27.16B
    SMAXV  B24, V12.8B
    UADDLV  S26, V25.4H
    SMAXV  B31, V31.16B
    UADDLV  D20, V5.4S
    FMAXNMV  S15, V21.4S
    SMINV  H4, V18.4H
    UADDLV  D26, V25.4S
    FMAXV  S16, V7.4S
    UMAXV  H7, V30.8H
    SMAXV  S9, V27.4S
    UADDLV  S14, V20.8H
    SMINV  B13, V31.8B
    SMAXV  H7, V20.8H
    UMINV  S3, V25.4S
    UADDLV  S8, V11.4H
    FMINNMV  S13, V27.4S
    SADDLV  D6, V9.4S
    SADDLV  H1, V21.16B
    UMAXV  H11, V12.8H
    UMINV  S17, V12.4S
    SMINV  B12, V24.8B
    ADDV  B12, V8.8B
    UADDLV  H29, V5.16B
    ADDV  H1, V29.8H
    SMAXV  B24, V10.16B
    SMINV  S10, V19.4S
    UMINV  B28, V1.16B
    FMINV  S0, V8.4S
    FMAXNMV  S12, V0.4S
    SMINV  S17, V15.4S
    SMINV  S18, V26.4S
    SMAXV  B22, V19.8B
    UMINV  B29, V17.8B
    SMINV  H30, V17.4H
    UADDLV  D19, V12.4S
    FMAXV  S25, V17.4S
    SMAXV  S29, V30.4S
    SMINV  S24, V22.4S
    FMINV  S8, V31.4S
    UMAXV  B26, V25.8B
    SMINV  B15, V25.16B
    UADDLV  H1, V19.8B
    SMINV  H20, V14.4H
    SUBS  X23, X23, #0x1
    B.NE  TaishanSimdElementArithemticP01_label_0
    MOVZ  X18, #0x4f62, LSL #0
    MOVK  X18, #0x2eac, LSL #16
    MOVK  X18, #0x91da, LSL #32
    MOVK  X18, #0xe29e, LSL #48
    SUB  X25, X18, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X20, #0x3c14, LSL #0
    MOVK  X20, #0x50bb, LSL #16
    MOVK  X20, #0x973c, LSL #32
    MOVK  X20, #0x5520, LSL #48
    SUB  X10, X20, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X21, #0xe6a8, LSL #0
    MOVK  X21, #0x159b, LSL #16
    MOVK  X21, #0x8580, LSL #32
    MOVK  X21, #0x5c49, LSL #48
    SUB  X8, X21, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X6, #0x7a25, LSL #0
    MOVK  X6, #0x3d50, LSL #16
    MOVK  X6, #0xba25, LSL #32
    MOVK  X6, #0xd8a, LSL #48
    SUB  X11, X6, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X15, #0x7a25, LSL #0
    MOVK  X15, #0x3d50, LSL #16
    MOVK  X15, #0xba25, LSL #32
    MOVK  X15, #0xd8a, LSL #48
    SUB  X2, X15, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X18, #0xdd63, LSL #0
    MOVK  X18, #0xa819, LSL #16
    MOVK  X18, #0xe387, LSL #32
    MOVK  X18, #0xfb2a, LSL #48
    SUB  X28, X18, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X18, #0x65b6, LSL #0
    MOVK  X18, #0xcf82, LSL #16
    MOVK  X18, #0xf2dd, LSL #32
    MOVK  X18, #0xad32, LSL #48
    SUB  X28, X18, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X21, #0xc53d, LSL #0
    MOVK  X21, #0x457d, LSL #16
    MOVK  X21, #0xe210, LSL #32
    MOVK  X21, #0xd727, LSL #48
    SUB  X3, X21, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X18, #0xdc74, LSL #0
    MOVK  X18, #0xdb15, LSL #16
    MOVK  X18, #0xbeb3, LSL #32
    MOVK  X18, #0xc6ba, LSL #48
    SUB  X23, X18, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X29, #0xd528, LSL #0
    MOVK  X29, #0x2eff, LSL #16
    MOVK  X29, #0x55a9, LSL #32
    MOVK  X29, #0xd414, LSL #48
    SUB  X3, X29, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X13, #0x7a25, LSL #0
    MOVK  X13, #0x3d50, LSL #16
    MOVK  X13, #0xba25, LSL #32
    MOVK  X13, #0xd8a, LSL #48
    SUB  X8, X13, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X20, #0x38a3, LSL #0
    MOVK  X20, #0x1ff0, LSL #16
    MOVK  X20, #0x4223, LSL #32
    MOVK  X20, #0x6e2e, LSL #48
    SUB  X11, X20, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X25, #0xdc24, LSL #0
    MOVK  X25, #0x6168, LSL #16
    MOVK  X25, #0xe828, LSL #32
    MOVK  X25, #0x19d2, LSL #48
    SUB  X23, X25, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X5, #0xdc74, LSL #0
    MOVK  X5, #0xdb15, LSL #16
    MOVK  X5, #0xbeb3, LSL #32
    MOVK  X5, #0xc6ba, LSL #48
    SUB  X26, X5, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X6, #0x38a3, LSL #0
    MOVK  X6, #0x1ff0, LSL #16
    MOVK  X6, #0x4223, LSL #32
    MOVK  X6, #0x6e2e, LSL #48
    SUB  X26, X6, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X16, #0xc53d, LSL #0
    MOVK  X16, #0x457d, LSL #16
    MOVK  X16, #0xe210, LSL #32
    MOVK  X16, #0xd727, LSL #48
    SUB  X24, X16, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X13, #0xa174, LSL #0
    MOVK  X13, #0xb2e3, LSL #16
    MOVK  X13, #0x89c0, LSL #32
    MOVK  X13, #0x1e3c, LSL #48
    SUB  X4, X13, X22
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X25, #0xdc24, LSL #0
    MOVK  X25, #0x6168, LSL #16
    MOVK  X25, #0xe828, LSL #32
    MOVK  X25, #0x19d2, LSL #48
    SUB  X6, X25, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X13, #0xd528, LSL #0
    MOVK  X13, #0x2eff, LSL #16
    MOVK  X13, #0x55a9, LSL #32
    MOVK  X13, #0xd414, LSL #48
    SUB  X29, X13, X29
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D2
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, D3
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, D4
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X13, X24, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, D5
    MOVZ  X24, #0x0, LSL #0
    SUB  X13, X24, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, D6
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, V7.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, D7
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, D8
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, D9
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X24, X2, X26
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, D10
    MOVZ  X2, #0x0, LSL #0
    SUB  X24, X2, X26
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X17, D11
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X26
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, D12
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X26
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, D13
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X7, X10, X12
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D14
    MOVZ  X10, #0x0, LSL #0
    SUB  X7, X10, X12
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, D15
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, D16
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, D17
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X22, X21, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, D18
    MOVZ  X21, #0x0, LSL #0
    SUB  X22, X21, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, D20
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, D21
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, D22
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, D23
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, V24.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X3, X16, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, D24
    MOVZ  X16, #0x0, LSL #0
    SUB  X3, X16, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, V25.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, D25
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, V26.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, D26
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, D27
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X18, X21, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, D28
    MOVZ  X21, #0x0, LSL #0
    SUB  X18, X21, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X9, X24, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X20, D29
    MOVZ  X24, #0x0, LSL #0
    SUB  X9, X24, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
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
    FMOV  D0, X2
    FMOV  V0.D[1], X3
    FMOV  D1, X27
    FMOV  V1.D[1], X6
    FMOV  D2, X27
    FMOV  V2.D[1], X22
    FMOV  D3, X23
    FMOV  V3.D[1], X18
    FMOV  D4, X10
    FMOV  V4.D[1], X9
    FMOV  D5, X7
    FMOV  V5.D[1], X6
    FMOV  D6, X26
    FMOV  V6.D[1], X6
    FMOV  D7, X25
    FMOV  V7.D[1], X8
    FMOV  D8, X28
    FMOV  V8.D[1], X15
    FMOV  D9, X17
    FMOV  V9.D[1], X29
    FMOV  D10, X11
    FMOV  V10.D[1], X27
    FMOV  D11, X18
    FMOV  V11.D[1], X7
    FMOV  D12, X20
    FMOV  V12.D[1], X6
    FMOV  D13, X6
    FMOV  V13.D[1], X25
    FMOV  D14, X6
    FMOV  V14.D[1], X15
    FMOV  D15, X26
    FMOV  V15.D[1], X25
    FMOV  D16, X3
    FMOV  V16.D[1], X24
    FMOV  D17, X25
    FMOV  V17.D[1], X23
    FMOV  D18, X3
    FMOV  V18.D[1], X13
    FMOV  D19, X20
    FMOV  V19.D[1], X20
    FMOV  D20, X9
    FMOV  V20.D[1], X20
    FMOV  D21, X7
    FMOV  V21.D[1], X17
    FMOV  D22, X9
    FMOV  V22.D[1], X10
    FMOV  D23, X16
    FMOV  V23.D[1], X26
    FMOV  D24, X7
    FMOV  V24.D[1], X27
    FMOV  D25, X7
    FMOV  V25.D[1], X24
    FMOV  D26, X3
    FMOV  V26.D[1], X15
    FMOV  D27, X9
    FMOV  V27.D[1], X2
    FMOV  D28, X16
    FMOV  V28.D[1], X20
    FMOV  D29, X23
    FMOV  V29.D[1], X26
    FMOV  D30, X29
    FMOV  V30.D[1], X26
    FMOV  D31, X10
    FMOV  V31.D[1], X21
    MOVZ  X20, #0xa, LSL #0
TaishanSimdElementArithemticP01_label_81:
    UADDLV  D25, V24.4S
    ADDV  B29, V28.8B
    UMAXV  B14, V17.16B
    UADDLV  S27, V30.4H
    SADDLV  D20, V11.4S
    FMAXV  S9, V16.4S
    UMAXV  S27, V31.4S
    SMAXV  B22, V11.8B
    FMINNMV  S0, V14.4S
    SMAXV  S5, V0.4S
    UADDLV  H30, V18.16B
    UADDLV  S7, V18.8H
    UMINV  B10, V24.8B
    UMINV  S10, V30.4S
    SADDLV  S21, V7.4H
    UMAXV  S14, V20.4S
    UMINV  S17, V31.4S
    SMAXV  H7, V22.8H
    UMINV  B26, V8.8B
    FMINV  S7, V15.4S
    ADDV  B0, V9.8B
    UMAXV  H26, V8.8H
    UADDLV  S21, V15.8H
    FMAXNMV  S10, V21.4S
    UMINV  S16, V21.4S
    SMINV  H8, V13.4H
    UMINV  B21, V19.8B
    ADDV  S25, V19.4S
    SMINV  B27, V21.16B
    FMINNMV  S18, V27.4S
    FMAXNMV  S8, V21.4S
    UMINV  H25, V26.4H
    UMAXV  B25, V19.16B
    SMAXV  H19, V4.4H
    FMAXNMV  S22, V20.4S
    SMINV  S20, V0.4S
    SMINV  B31, V26.8B
    SADDLV  H22, V27.16B
    UMAXV  B20, V16.8B
    UMINV  S29, V14.4S
    SMINV  B5, V25.16B
    FMAXNMV  S14, V22.4S
    UMINV  S20, V20.4S
    SMINV  H16, V31.4H
    SADDLV  H24, V23.16B
    SMINV  H13, V15.8H
    UMAXV  S24, V30.4S
    UMAXV  B17, V13.16B
    SMAXV  H31, V5.8H
    SMAXV  S30, V30.4S
    UMAXV  B29, V24.8B
    UMAXV  B27, V9.8B
    SMINV  B25, V29.8B
    SMAXV  B29, V18.8B
    SMINV  H13, V10.4H
    FMINNMV  S20, V22.4S
    UMINV  H9, V4.8H
    SMAXV  B11, V29.16B
    UMAXV  S22, V2.4S
    FMINV  S24, V30.4S
    SMAXV  H9, V9.8H
    SMINV  H5, V29.8H
    FMAXV  S7, V15.4S
    UMINV  B5, V28.16B
    UADDLV  S10, V26.8H
    SMAXV  S17, V31.4S
    UMAXV  H23, V1.8H
    ADDV  B18, V3.8B
    SMINV  B31, V9.16B
    FMAXV  S11, V0.4S
    UMINV  H7, V26.8H
    UADDLV  D2, V4.4S
    SMAXV  B2, V31.16B
    SADDLV  D16, V25.4S
    SADDLV  S2, V20.4H
    UMAXV  B25, V11.8B
    UADDLV  H30, V28.16B
    SADDLV  H21, V28.16B
    SADDLV  H15, V18.8B
    SADDLV  D8, V0.4S
    UADDLV  S21, V25.8H
    UADDLV  S20, V13.8H
    FMINV  S1, V4.4S
    SADDLV  H5, V9.16B
    FMAXV  S23, V27.4S
    UMINV  B26, V17.8B
    SMAXV  S31, V9.4S
    UMINV  H9, V7.8H
    ADDV  B20, V7.16B
    SMAXV  S10, V13.4S
    SADDLV  D27, V10.4S
    ADDV  B21, V17.16B
    UADDLV  S15, V9.8H
    SADDLV  S31, V27.8H
    UMINV  S2, V31.4S
    UMINV  H29, V23.8H
    UMINV  H11, V12.8H
    FMAXNMV  S25, V26.4S
    UADDLV  S26, V12.4H
    FMAXV  S10, V29.4S
    ADDV  H28, V26.4H
    ADDV  H11, V20.4H
    ADDV  B26, V20.8B
    UADDLV  D13, V27.4S
    UMAXV  B11, V7.8B
    FMINV  S2, V7.4S
    FMAXV  S18, V10.4S
    FMAXNMV  S23, V21.4S
    SMAXV  H21, V15.4H
    SMAXV  B30, V18.16B
    SADDLV  D27, V18.4S
    SADDLV  S4, V18.4H
    SMAXV  B15, V22.16B
    UMINV  B11, V10.16B
    UMINV  H24, V1.4H
    UMINV  B11, V17.8B
    SMAXV  S23, V18.4S
    SADDLV  S12, V8.4H
    UMINV  S21, V26.4S
    FMAXNMV  S19, V11.4S
    UMAXV  H23, V21.8H
    FMINV  S1, V21.4S
    SMINV  B9, V2.8B
    SADDLV  H10, V22.16B
    ADDV  B28, V17.16B
    UMINV  S14, V30.4S
    FMAXV  S30, V25.4S
    FMAXV  S2, V11.4S
    UADDLV  S17, V16.8H
    UADDLV  D17, V0.4S
    UADDLV  S20, V23.4H
    UMINV  H7, V1.8H
    SADDLV  H21, V17.8B
    UADDLV  S25, V13.4H
    UMINV  S1, V21.4S
    SADDLV  S15, V15.4H
    UADDLV  D16, V13.4S
    SADDLV  S18, V2.4H
    SADDLV  S22, V18.8H
    SADDLV  D7, V18.4S
    UMINV  S11, V26.4S
    FMAXNMV  S26, V8.4S
    UADDLV  S0, V10.8H
    UMINV  H15, V21.8H
    UADDLV  H12, V27.16B
    SMAXV  H4, V20.4H
    ADDV  B31, V6.8B
    SMINV  H3, V13.8H
    SADDLV  S12, V8.4H
    SMAXV  S1, V27.4S
    SMAXV  S13, V26.4S
    ADDV  H20, V2.8H
    SMINV  B3, V18.8B
    SMAXV  S3, V20.4S
    SADDLV  H10, V0.16B
    FMINNMV  S9, V26.4S
    FMINV  S8, V26.4S
    ADDV  S11, V9.4S
    UADDLV  S18, V27.8H
    SADDLV  H12, V29.16B
    SMAXV  S9, V23.4S
    SMAXV  S11, V15.4S
    SMAXV  H30, V22.8H
    UADDLV  D4, V30.4S
    SMINV  B11, V10.16B
    UADDLV  D24, V31.4S
    FMAXV  S23, V31.4S
    UADDLV  H2, V4.8B
    SMINV  B18, V4.16B
    ADDV  B4, V25.16B
    FMINNMV  S1, V7.4S
    FMINV  S15, V31.4S
    UMINV  S7, V20.4S
    FMINV  S18, V19.4S
    FMAXV  S12, V19.4S
    UADDLV  H28, V8.8B
    SMINV  B3, V16.16B
    ADDV  H29, V22.8H
    SADDLV  D6, V4.4S
    FMINNMV  S22, V4.4S
    SADDLV  D3, V21.4S
    FMINNMV  S31, V30.4S
    FMINNMV  S24, V26.4S
    UMINV  B18, V6.8B
    UMAXV  H25, V17.8H
    UADDLV  D15, V13.4S
    FMAXV  S29, V17.4S
    SMINV  S15, V25.4S
    FMINNMV  S16, V18.4S
    ADDV  S1, V18.4S
    SMAXV  H2, V0.4H
    ADDV  B0, V5.8B
    UADDLV  S29, V11.4H
    ADDV  H19, V30.4H
    SMINV  B21, V29.8B
    SADDLV  D26, V6.4S
    UMINV  S23, V19.4S
    SADDLV  D20, V11.4S
    SMINV  S21, V3.4S
    FMAXNMV  S10, V2.4S
    SUBS  X20, X20, #0x1
    B.NE  TaishanSimdElementArithemticP01_label_81
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X7, X5, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X2, X27, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X7
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X13, X18, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X7, X3, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X6, X29, X15
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X27, X22, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X24, X7, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X13, X3, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X12, X9, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X15, X6, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, D2
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, V3.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X22
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, D3
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X22
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, D4
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, D5
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, V6.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, D6
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, D7
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X14, X27, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, D8
    MOVZ  X27, #0x0, LSL #0
    SUB  X14, X27, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D9
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D10
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, D11
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, V12.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, D12
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X14, X15, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, D13
    MOVZ  X15, #0x0, LSL #0
    SUB  X14, X15, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, V14.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X22
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, D14
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X22
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, V15.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X8, X21, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, D15
    MOVZ  X21, #0x0, LSL #0
    SUB  X8, X21, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D16
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X21, X12, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, D17
    MOVZ  X12, #0x0, LSL #0
    SUB  X21, X12, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, D18
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X3
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, D20
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X3
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X14, X29, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, D21
    MOVZ  X29, #0x0, LSL #0
    SUB  X14, X29, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, D22
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D23
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, V24.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, D24
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X2, X15, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, D25
    MOVZ  X15, #0x0, LSL #0
    SUB  X2, X15, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X24, X9, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D26
    MOVZ  X9, #0x0, LSL #0
    SUB  X24, X9, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, D27
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, D28
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, D29
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
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
    FMOV  D0, X3
    FMOV  V0.D[1], X27
    FMOV  D1, X23
    FMOV  V1.D[1], X13
    FMOV  D2, X7
    FMOV  V2.D[1], X17
    FMOV  D3, X2
    FMOV  V3.D[1], X29
    FMOV  D4, X9
    FMOV  V4.D[1], X5
    FMOV  D5, X7
    FMOV  V5.D[1], X28
    FMOV  D6, X18
    FMOV  V6.D[1], X22
    FMOV  D7, X8
    FMOV  V7.D[1], X22
    FMOV  D8, X5
    FMOV  V8.D[1], X29
    FMOV  D9, X6
    FMOV  V9.D[1], X21
    FMOV  D10, X22
    FMOV  V10.D[1], X4
    FMOV  D11, X12
    FMOV  V11.D[1], X10
    FMOV  D12, X22
    FMOV  V12.D[1], X18
    FMOV  D13, X22
    FMOV  V13.D[1], X8
    FMOV  D14, X12
    FMOV  V14.D[1], X16
    FMOV  D15, X2
    FMOV  V15.D[1], X4
    FMOV  D16, X21
    FMOV  V16.D[1], X9
    FMOV  D17, X24
    FMOV  V17.D[1], X28
    FMOV  D18, X23
    FMOV  V18.D[1], X22
    FMOV  D19, X8
    FMOV  V19.D[1], X13
    FMOV  D20, X9
    FMOV  V20.D[1], X17
    FMOV  D21, X14
    FMOV  V21.D[1], X29
    FMOV  D22, X16
    FMOV  V22.D[1], X29
    FMOV  D23, X21
    FMOV  V23.D[1], X25
    FMOV  D24, X23
    FMOV  V24.D[1], X13
    FMOV  D25, X2
    FMOV  V25.D[1], X25
    FMOV  D26, X8
    FMOV  V26.D[1], X11
    FMOV  D27, X25
    FMOV  V27.D[1], X8
    FMOV  D28, X2
    FMOV  V28.D[1], X13
    FMOV  D29, X25
    FMOV  V29.D[1], X17
    FMOV  D30, X29
    FMOV  V30.D[1], X4
    FMOV  D31, X22
    FMOV  V31.D[1], X28
    MOVZ  X7, #0xf, LSL #0
TaishanSimdElementArithemticP01_label_161:
    FMAXNMV  S20, V20.4S
    UADDLV  H26, V23.16B
    UMAXV  B18, V31.8B
    ADDV  S3, V6.4S
    UADDLV  D18, V24.4S
    SMAXV  S3, V10.4S
    ADDV  H15, V15.8H
    SADDLV  D6, V16.4S
    SADDLV  S9, V0.4H
    SMAXV  S22, V14.4S
    SADDLV  H15, V4.8B
    SMAXV  H22, V2.8H
    FMAXNMV  S27, V2.4S
    UADDLV  D30, V28.4S
    UMINV  H27, V10.8H
    UMINV  H25, V10.4H
    ADDV  S5, V2.4S
    SADDLV  H29, V22.8B
    FMAXNMV  S9, V12.4S
    ADDV  B5, V7.8B
    FMINNMV  S26, V18.4S
    UMAXV  B0, V9.16B
    ADDV  H25, V29.4H
    UADDLV  S18, V30.4H
    SADDLV  S10, V13.8H
    ADDV  S18, V20.4S
    UMAXV  B20, V11.8B
    SMINV  S9, V6.4S
    SMINV  S0, V23.4S
    UADDLV  D29, V24.4S
    UMINV  B25, V16.16B
    UMINV  H12, V19.8H
    SMINV  B19, V27.16B
    FMAXNMV  S19, V15.4S
    UMINV  S22, V0.4S
    FMAXV  S27, V5.4S
    UMAXV  S0, V20.4S
    UMINV  B28, V10.8B
    UMAXV  B25, V0.8B
    SMAXV  H15, V9.4H
    UADDLV  S26, V19.4H
    SMINV  B28, V29.16B
    UMAXV  B7, V1.16B
    SMAXV  B24, V19.8B
    UADDLV  S2, V2.4H
    UADDLV  D15, V18.4S
    SMINV  H18, V7.8H
    UADDLV  H30, V28.16B
    FMAXV  S1, V16.4S
    SMINV  H26, V6.8H
    UMINV  S25, V0.4S
    ADDV  S4, V26.4S
    FMINV  S15, V26.4S
    ADDV  B11, V29.16B
    SMAXV  B15, V21.8B
    SADDLV  H12, V25.8B
    SMAXV  B29, V17.8B
    UADDLV  S11, V17.4H
    UMINV  H0, V1.8H
    ADDV  S15, V6.4S
    FMAXNMV  S26, V19.4S
    FMINV  S22, V17.4S
    UMINV  H17, V8.4H
    SMINV  H19, V26.8H
    UMAXV  B19, V1.16B
    SADDLV  S15, V31.8H
    SMINV  H21, V20.4H
    ADDV  H0, V1.8H
    UADDLV  H29, V3.16B
    SADDLV  D26, V4.4S
    SMAXV  H11, V28.4H
    UMAXV  H26, V28.8H
    UMAXV  H10, V6.4H
    UMINV  S8, V9.4S
    SMINV  H25, V11.8H
    UMINV  S22, V20.4S
    UADDLV  S14, V22.4H
    UMINV  H15, V25.8H
    UMAXV  B8, V22.16B
    SADDLV  D3, V1.4S
    UADDLV  D11, V3.4S
    SMINV  B23, V17.8B
    FMINV  S19, V23.4S
    SMAXV  H9, V13.4H
    SMAXV  S8, V28.4S
    UMINV  B11, V10.16B
    SMAXV  S0, V13.4S
    FMAXNMV  S27, V10.4S
    UMAXV  B29, V0.8B
    UMAXV  S9, V12.4S
    FMINV  S28, V27.4S
    SADDLV  D5, V16.4S
    ADDV  S24, V28.4S
    UMAXV  H11, V5.4H
    UMINV  H24, V18.8H
    ADDV  B15, V19.16B
    UMAXV  S4, V3.4S
    UMAXV  B0, V8.16B
    UADDLV  S23, V20.4H
    FMAXV  S15, V10.4S
    FMINV  S8, V27.4S
    FMINV  S13, V19.4S
    SADDLV  S0, V3.4H
    UMINV  H18, V2.4H
    UMAXV  H10, V2.8H
    ADDV  B11, V17.16B
    UADDLV  D31, V9.4S
    ADDV  S10, V7.4S
    UMAXV  S13, V7.4S
    UADDLV  H6, V4.16B
    SADDLV  D13, V7.4S
    SADDLV  H2, V26.8B
    SADDLV  S23, V13.8H
    FMINNMV  S0, V23.4S
    UMINV  H12, V20.4H
    SADDLV  S12, V31.4H
    SMINV  S18, V18.4S
    SADDLV  S26, V6.4H
    SADDLV  S26, V14.8H
    UMINV  S5, V5.4S
    SMAXV  S24, V0.4S
    FMAXNMV  S13, V13.4S
    UMINV  S31, V24.4S
    UMAXV  B0, V23.16B
    SADDLV  S11, V31.4H
    UMAXV  H8, V20.8H
    UMAXV  S14, V4.4S
    UADDLV  D25, V8.4S
    UMINV  B31, V16.16B
    SADDLV  D15, V15.4S
    UADDLV  H1, V14.16B
    SMINV  S19, V5.4S
    UMAXV  S6, V1.4S
    SMINV  B31, V4.8B
    SMINV  H27, V30.8H
    SMAXV  H2, V12.8H
    UMAXV  B26, V31.16B
    UMAXV  B28, V21.8B
    SADDLV  S6, V1.4H
    ADDV  B27, V0.8B
    UMAXV  S24, V5.4S
    UMINV  S16, V18.4S
    SMINV  B20, V6.8B
    FMAXV  S25, V16.4S
    FMAXV  S19, V15.4S
    FMINV  S6, V29.4S
    ADDV  S5, V1.4S
    UADDLV  S3, V2.8H
    SMINV  B10, V30.16B
    FMAXV  S10, V6.4S
    SMINV  H10, V1.8H
    FMAXNMV  S23, V18.4S
    UADDLV  H25, V12.8B
    ADDV  S10, V10.4S
    UADDLV  S8, V7.8H
    UMAXV  B21, V10.8B
    UMINV  S10, V23.4S
    UADDLV  D10, V15.4S
    UADDLV  H5, V20.16B
    ADDV  H30, V13.4H
    SMINV  B24, V29.16B
    SMINV  B7, V7.16B
    SMAXV  S12, V13.4S
    SADDLV  D16, V16.4S
    ADDV  B15, V30.8B
    UMAXV  S13, V15.4S
    UMAXV  B25, V9.8B
    SMINV  S4, V7.4S
    SMAXV  B23, V31.16B
    UMINV  S6, V18.4S
    SADDLV  D31, V22.4S
    UMINV  H15, V22.8H
    FMINNMV  S2, V13.4S
    FMAXV  S27, V15.4S
    FMINV  S4, V12.4S
    SADDLV  D9, V8.4S
    SADDLV  H12, V18.8B
    UADDLV  S10, V13.4H
    SMAXV  B27, V3.8B
    UMAXV  B1, V25.16B
    UMAXV  S20, V25.4S
    UADDLV  D26, V20.4S
    SADDLV  D4, V27.4S
    UADDLV  H24, V12.16B
    UMAXV  B2, V12.16B
    UMAXV  H31, V12.8H
    SADDLV  S31, V27.4H
    SMAXV  S13, V26.4S
    FMINV  S9, V29.4S
    SADDLV  D27, V24.4S
    UMINV  H4, V17.4H
    UADDLV  S27, V24.4H
    SMINV  S18, V13.4S
    UMINV  S16, V12.4S
    ADDV  H11, V8.8H
    SMAXV  B25, V3.8B
    UADDLV  H26, V30.8B
    SMINV  H22, V10.8H
    UMINV  S13, V1.4S
    UADDLV  D29, V22.4S
    SUBS  X7, X7, #0x1
    B.NE  TaishanSimdElementArithemticP01_label_161
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X11, X25, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X14, X12, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X22, X13, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X14, X8, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X26, X25, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X26, X6, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X24, X2, X9
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X28, X8, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X15, X11, X13
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X21, X20, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X28, X20, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X20, X13, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X10, X14, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X16, X7, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, D2
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D3
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, D4
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, D5
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, D6
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, D7
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, D8
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, D9
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, V10.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, D10
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X10, X4, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D11
    MOVZ  X4, #0x0, LSL #0
    SUB  X10, X4, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, V12.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, D12
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, D13
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, D14
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X24, X14, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D15
    MOVZ  X14, #0x0, LSL #0
    SUB  X24, X14, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D17
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X10
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, D18
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X10
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X29, X15, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, D20
    MOVZ  X15, #0x0, LSL #0
    SUB  X29, X15, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, D21
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V22.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X27, X14, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D22
    MOVZ  X14, #0x0, LSL #0
    SUB  X27, X14, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, D23
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, D24
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, D25
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, D26
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, D27
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X27, X8, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D28
    MOVZ  X8, #0x0, LSL #0
    SUB  X27, X8, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X17, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X17, D29
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0xb264, LSL #0
    MOVK  X2, #0xdc2b, LSL #16
    MOVK  X2, #0x22d7, LSL #32
    MOVK  X2, #0x35db, LSL #48
    MOVZ  X3, #0x5163, LSL #0
    MOVK  X3, #0xb45e, LSL #16
    MOVK  X3, #0xfd69, LSL #32
    MOVK  X3, #0x5dfa, LSL #48
    MOVZ  X4, #0x90d4, LSL #0
    MOVK  X4, #0x8cd0, LSL #16
    MOVK  X4, #0xec73, LSL #32
    MOVK  X4, #0x54b4, LSL #48
    MOVZ  X5, #0x38f, LSL #0
    MOVK  X5, #0xc4f4, LSL #16
    MOVK  X5, #0x7951, LSL #32
    MOVK  X5, #0xbbc, LSL #48
    MOVZ  X6, #0x6dd5, LSL #0
    MOVK  X6, #0x86e, LSL #16
    MOVK  X6, #0x4069, LSL #32
    MOVK  X6, #0x5c50, LSL #48
    MOVZ  X7, #0xa5fa, LSL #0
    MOVK  X7, #0x46e5, LSL #16
    MOVK  X7, #0xfe33, LSL #32
    MOVK  X7, #0xfb2, LSL #48
    MOVZ  X8, #0x743b, LSL #0
    MOVK  X8, #0xa442, LSL #16
    MOVK  X8, #0x15e6, LSL #32
    MOVK  X8, #0xaaa1, LSL #48
    MOVZ  X9, #0x5290, LSL #0
    MOVK  X9, #0x215d, LSL #16
    MOVK  X9, #0x3f24, LSL #32
    MOVK  X9, #0x17a9, LSL #48
    MOVZ  X10, #0xb8ad, LSL #0
    MOVK  X10, #0x2554, LSL #16
    MOVK  X10, #0x9f94, LSL #32
    MOVK  X10, #0x76f1, LSL #48
    MOVZ  X11, #0x407, LSL #0
    MOVK  X11, #0x8f0b, LSL #16
    MOVK  X11, #0x9697, LSL #32
    MOVK  X11, #0x4da9, LSL #48
    MOVZ  X12, #0xae9e, LSL #0
    MOVK  X12, #0x8c3b, LSL #16
    MOVK  X12, #0x9045, LSL #32
    MOVK  X12, #0x55c, LSL #48
    MOVZ  X13, #0x37db, LSL #0
    MOVK  X13, #0x7b33, LSL #16
    MOVK  X13, #0xeae5, LSL #32
    MOVK  X13, #0xbed8, LSL #48
    MOVZ  X14, #0x5a09, LSL #0
    MOVK  X14, #0xd0e2, LSL #16
    MOVK  X14, #0xb0d6, LSL #32
    MOVK  X14, #0x3526, LSL #48
    MOVZ  X15, #0x7912, LSL #0
    MOVK  X15, #0x5361, LSL #16
    MOVK  X15, #0xc2e1, LSL #32
    MOVK  X15, #0xe890, LSL #48
    MOVZ  X16, #0xfb2a, LSL #0
    MOVK  X16, #0x766e, LSL #16
    MOVK  X16, #0xadd2, LSL #32
    MOVK  X16, #0xf81f, LSL #48
    MOVZ  X17, #0x9e40, LSL #0
    MOVK  X17, #0xaf1d, LSL #16
    MOVK  X17, #0x4169, LSL #32
    MOVK  X17, #0xe40e, LSL #48
    MOVZ  X18, #0x738e, LSL #0
    MOVK  X18, #0x7bfa, LSL #16
    MOVK  X18, #0xdc39, LSL #32
    MOVK  X18, #0x2a0, LSL #48
    MOVZ  X20, #0xdc93, LSL #0
    MOVK  X20, #0x94b6, LSL #16
    MOVK  X20, #0x5001, LSL #32
    MOVK  X20, #0x776b, LSL #48
    MOVZ  X21, #0x1b3f, LSL #0
    MOVK  X21, #0x91f, LSL #16
    MOVK  X21, #0xba3c, LSL #32
    MOVK  X21, #0x6316, LSL #48
    MOVZ  X22, #0x386c, LSL #0
    MOVK  X22, #0x5044, LSL #16
    MOVK  X22, #0x4b7a, LSL #32
    MOVK  X22, #0x51da, LSL #48
    MOVZ  X23, #0x49fe, LSL #0
    MOVK  X23, #0xd5f0, LSL #16
    MOVK  X23, #0x5c8, LSL #32
    MOVK  X23, #0x6827, LSL #48
    MOVZ  X24, #0xf341, LSL #0
    MOVK  X24, #0xf9e5, LSL #16
    MOVK  X24, #0xcb43, LSL #32
    MOVK  X24, #0xa452, LSL #48
    MOVZ  X25, #0x6112, LSL #0
    MOVK  X25, #0x421, LSL #16
    MOVK  X25, #0x7eaa, LSL #32
    MOVK  X25, #0x17f, LSL #48
    MOVZ  X26, #0x6f2c, LSL #0
    MOVK  X26, #0xeb34, LSL #16
    MOVK  X26, #0xba5c, LSL #32
    MOVK  X26, #0x3007, LSL #48
    MOVZ  X27, #0x9f5d, LSL #0
    MOVK  X27, #0x6b2f, LSL #16
    MOVK  X27, #0x2e65, LSL #32
    MOVK  X27, #0x8cd5, LSL #48
    MOVZ  X28, #0xfab0, LSL #0
    MOVK  X28, #0x5ee7, LSL #16
    MOVK  X28, #0x2da9, LSL #32
    MOVK  X28, #0xb8e1, LSL #48
    MOVZ  X29, #0x524a, LSL #0
    MOVK  X29, #0x1bea, LSL #16
    MOVK  X29, #0x333, LSL #32
    MOVK  X29, #0xf475, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X26
    FMOV  D1, X15
    FMOV  V1.D[1], X23
    FMOV  D2, X4
    FMOV  V2.D[1], X28
    FMOV  D3, X13
    FMOV  V3.D[1], X23
    FMOV  D4, X15
    FMOV  V4.D[1], X29
    FMOV  D5, X27
    FMOV  V5.D[1], X10
    FMOV  D6, X8
    FMOV  V6.D[1], X8
    FMOV  D7, X9
    FMOV  V7.D[1], X4
    FMOV  D8, X15
    FMOV  V8.D[1], X3
    FMOV  D9, X7
    FMOV  V9.D[1], X24
    FMOV  D10, X8
    FMOV  V10.D[1], X9
    FMOV  D11, X23
    FMOV  V11.D[1], X6
    FMOV  D12, X8
    FMOV  V12.D[1], X24
    FMOV  D13, X11
    FMOV  V13.D[1], X16
    FMOV  D14, X28
    FMOV  V14.D[1], X5
    FMOV  D15, X28
TaishanSimdElementArithemticP01_label_167:
    FMOV  V15.D[1], X23
    FMOV  D16, X7
    FMOV  V16.D[1], X2
    FMOV  D17, X12
    FMOV  V17.D[1], X4
    FMOV  D18, X25
    FMOV  V18.D[1], X15
    FMOV  D19, X22
    FMOV  V19.D[1], X18
    FMOV  D20, X7
    FMOV  V20.D[1], X13
    FMOV  D21, X25
    FMOV  V21.D[1], X9
    FMOV  D22, X26
    FMOV  V22.D[1], X28
    FMOV  D23, X3
    FMOV  V23.D[1], X6
    FMOV  D24, X4
    FMOV  V24.D[1], X4
    FMOV  D25, X18
    FMOV  V25.D[1], X3
    FMOV  D26, X12
    FMOV  V26.D[1], X14
    FMOV  D27, X29
    FMOV  V27.D[1], X15
    FMOV  D28, X26
    FMOV  V28.D[1], X5
    FMOV  D29, X28
    FMOV  V29.D[1], X16
    FMOV  D30, X16
    FMOV  V30.D[1], X25
    FMOV  D31, X17
    FMOV  V31.D[1], X24
    MOVZ  X20, #0xa, LSL #0
TaishanSimdElementArithemticP01_label_241:
    UMAXV  H28, V27.4H
    UMAXV  H21, V17.4H
    SADDLV  S28, V14.8H
    FMINNMV  S8, V16.4S
    ADDV  B26, V21.8B
    FMAXNMV  S22, V15.4S
    SMAXV  S5, V28.4S
    UMAXV  S10, V17.4S
    SMINV  B5, V17.16B
    FMAXNMV  S6, V29.4S
    FMAXV  S9, V13.4S
    UADDLV  S31, V28.4H
    SADDLV  H10, V9.16B
    SMAXV  H4, V25.4H
    SMINV  B20, V4.16B
    UMINV  B10, V9.16B
    ADDV  H11, V25.4H
    SMINV  S1, V31.4S
    UMINV  H6, V6.8H
    UADDLV  S4, V30.4H
    SADDLV  H0, V7.16B
    ADDV  B10, V6.16B
    SMAXV  H29, V11.4H
    UMAXV  H20, V24.8H
    UMINV  B1, V17.8B
    ADDV  H15, V14.4H
    UMINV  S24, V28.4S
    FMAXV  S4, V28.4S
    UADDLV  H30, V16.8B
    UMINV  B14, V20.8B
    SMINV  B28, V31.8B
    SMAXV  H9, V30.8H
    SMINV  S17, V26.4S
    SMAXV  B0, V0.16B
    FMAXV  S7, V9.4S
    FMINV  S12, V11.4S
    SADDLV  S1, V28.4H
    SADDLV  S27, V1.8H
    UADDLV  D30, V29.4S
    UMAXV  S15, V8.4S
    FMAXV  S5, V31.4S
    SADDLV  H4, V13.8B
    SADDLV  H28, V30.8B
    SADDLV  D17, V2.4S
    UMINV  H7, V26.4H
    SMAXV  S11, V21.4S
    SMINV  S11, V26.4S
    SMAXV  H7, V0.4H
    SMAXV  S9, V1.4S
    UMAXV  B26, V20.16B
    UMINV  B20, V18.16B
    ADDV  H3, V29.4H
    SMINV  B0, V2.16B
    SMINV  S0, V3.4S
    UMAXV  B0, V11.8B
    FMINV  S27, V1.4S
    UMAXV  S21, V5.4S
    FMINNMV  S31, V23.4S
    FMAXNMV  S27, V21.4S
    SMAXV  H4, V8.8H
    UMINV  B24, V16.16B
    FMINV  S24, V0.4S
    SADDLV  H5, V21.16B
    SMINV  B11, V10.8B
    UMINV  B20, V7.8B
    SMINV  B12, V5.8B
    SMINV  H15, V27.4H
    SADDLV  S13, V27.4H
    ADDV  H1, V1.4H
    FMAXNMV  S13, V24.4S
    SMAXV  B9, V22.8B
    SADDLV  D15, V12.4S
    UMAXV  B9, V8.8B
    UMINV  S18, V21.4S
    ADDV  S14, V6.4S
    SMINV  H7, V0.4H
    ADDV  S11, V7.4S
    SADDLV  H1, V9.16B
    UMAXV  S22, V22.4S
    ADDV  S20, V7.4S
    ADDV  B14, V2.8B
    SMAXV  S31, V17.4S
    SMINV  B31, V10.16B
    FMINNMV  S3, V31.4S
    ADDV  H11, V24.8H
    FMAXNMV  S4, V28.4S
    FMINNMV  S24, V12.4S
    SMINV  S7, V24.4S
    SADDLV  H0, V8.8B
    SMAXV  H14, V10.4H
    FMAXNMV  S24, V21.4S
    UMINV  H12, V17.8H
    FMINV  S1, V19.4S
    UADDLV  D6, V5.4S
    FMAXNMV  S8, V8.4S
    FMAXV  S0, V2.4S
    UMAXV  H8, V1.4H
    SMAXV  B8, V3.8B
    UMINV  B6, V17.16B
    ADDV  H17, V30.4H
    FMINNMV  S20, V1.4S
    SMAXV  H10, V31.8H
    ADDV  H6, V2.4H
    UMINV  S20, V11.4S
    UMINV  H28, V1.4H
    SADDLV  D10, V6.4S
    ADDV  S0, V12.4S
    FMINV  S30, V8.4S
    SMINV  H18, V1.8H
    UMAXV  H4, V5.4H
    ADDV  S25, V19.4S
    FMAXNMV  S19, V11.4S
    ADDV  H6, V0.8H
    FMAXNMV  S3, V30.4S
    FMINNMV  S29, V3.4S
    SMINV  S4, V10.4S
    FMAXV  S14, V25.4S
    SMAXV  H14, V1.4H
    UMAXV  B8, V17.16B
    SADDLV  H11, V6.16B
    UMINV  S20, V21.4S
    FMAXV  S5, V7.4S
    SMINV  B18, V8.8B
    UADDLV  D3, V22.4S
    SMINV  H25, V28.4H
    SMINV  B19, V25.8B
    FMINNMV  S6, V17.4S
    UMINV  S2, V24.4S
    FMAXV  S20, V11.4S
    ADDV  S29, V3.4S
    UMINV  S24, V29.4S
    UMINV  H23, V19.4H
    UMINV  H7, V25.8H
    UADDLV  D26, V1.4S
    UMAXV  S16, V30.4S
    SMINV  B28, V8.16B
    UADDLV  S15, V22.8H
    SMINV  S22, V16.4S
    SMINV  B11, V31.16B
    SMINV  B0, V6.16B
    SMINV  H18, V23.8H
    UMAXV  H1, V13.4H
    SMINV  H7, V29.8H
    SMAXV  S30, V20.4S
    SMAXV  S6, V11.4S
    ADDV  H8, V27.8H
    ADDV  S10, V21.4S
    UMAXV  H6, V23.4H
    UMINV  B17, V12.16B
    UMINV  S12, V27.4S
    SADDLV  H0, V30.16B
    SADDLV  H24, V7.8B
    UMAXV  S20, V18.4S
    FMINV  S7, V30.4S
    UADDLV  H10, V20.8B
    ADDV  H18, V30.4H
    SMAXV  H24, V8.4H
    SADDLV  H25, V31.8B
    ADDV  S16, V7.4S
    SADDLV  D21, V26.4S
    SADDLV  D27, V27.4S
    SMAXV  B27, V13.16B
    UADDLV  S5, V10.8H
    UADDLV  S17, V23.4H
    SMINV  S29, V24.4S
    SMAXV  H19, V11.8H
    SMAXV  S20, V31.4S
    SMINV  B19, V18.16B
    FMINV  S13, V26.4S
    SMINV  H30, V3.8H
    SADDLV  S8, V30.4H
    FMINNMV  S4, V12.4S
    UADDLV  S31, V10.4H
    SADDLV  D7, V2.4S
    SMAXV  S17, V2.4S
    SMINV  S8, V23.4S
    FMAXV  S19, V26.4S
    SMAXV  B18, V14.8B
    UMINV  H6, V9.8H
    FMINV  S27, V13.4S
    UMINV  B10, V1.16B
    UMINV  S11, V23.4S
    SMAXV  S25, V19.4S
    ADDV  S25, V11.4S
    SMAXV  H27, V2.4H
    ADDV  B20, V7.16B
    SMINV  H21, V28.8H
    SMINV  H1, V21.8H
    SMINV  H27, V11.4H
    SADDLV  D22, V26.4S
    SMINV  H8, V27.8H
    FMAXV  S20, V29.4S
    UMINV  H16, V6.4H
    UADDLV  S14, V25.4H
    UADDLV  H8, V23.16B
    SMAXV  S29, V8.4S
    ADDV  H13, V29.8H
    SMINV  S17, V10.4S
    UMAXV  B18, V17.16B
    SADDLV  D24, V8.4S
    SUBS  X20, X20, #0x1
    B.NE  TaishanSimdElementArithemticP01_label_241
    MOVZ  X7, #0xb264, LSL #0
    MOVK  X7, #0xdc2b, LSL #16
    MOVK  X7, #0x22d7, LSL #32
    MOVK  X7, #0x35db, LSL #48
    SUB  X4, X7, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X25, #0x5163, LSL #0
    MOVK  X25, #0xb45e, LSL #16
    MOVK  X25, #0xfd69, LSL #32
    MOVK  X25, #0x5dfa, LSL #48
    SUB  X26, X25, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X23, #0x38f, LSL #0
    MOVK  X23, #0xc4f4, LSL #16
    MOVK  X23, #0x7951, LSL #32
    MOVK  X23, #0xbbc, LSL #48
    SUB  X20, X23, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X28, #0x6dd5, LSL #0
    MOVK  X28, #0x86e, LSL #16
    MOVK  X28, #0x4069, LSL #32
    MOVK  X28, #0x5c50, LSL #48
    SUB  X18, X28, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0x743b, LSL #0
    MOVK  X3, #0xa442, LSL #16
    MOVK  X3, #0x15e6, LSL #32
    MOVK  X3, #0xaaa1, LSL #48
    SUB  X10, X3, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X10, X2, X10
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X14, #0x407, LSL #0
    MOVK  X14, #0x8f0b, LSL #16
    MOVK  X14, #0x9697, LSL #32
    MOVK  X14, #0x4da9, LSL #48
    SUB  X17, X14, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X8, #0xae9e, LSL #0
    MOVK  X8, #0x8c3b, LSL #16
    MOVK  X8, #0x9045, LSL #32
    MOVK  X8, #0x55c, LSL #48
    SUB  X27, X8, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X9, #0x37db, LSL #0
    MOVK  X9, #0x7b33, LSL #16
    MOVK  X9, #0xeae5, LSL #32
    MOVK  X9, #0xbed8, LSL #48
    SUB  X4, X9, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X10, #0x407, LSL #0
    MOVK  X10, #0x8f0b, LSL #16
    MOVK  X10, #0x9697, LSL #32
    MOVK  X10, #0x4da9, LSL #48
    SUB  X25, X10, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0x7912, LSL #0
    MOVK  X2, #0x5361, LSL #16
    MOVK  X2, #0xc2e1, LSL #32
    MOVK  X2, #0xe890, LSL #48
    SUB  X23, X2, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X28, X4, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X18, #0x1b3f, LSL #0
    MOVK  X18, #0x91f, LSL #16
    MOVK  X18, #0xba3c, LSL #32
    MOVK  X18, #0x6316, LSL #48
    SUB  X22, X18, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X21, #0xf341, LSL #0
    MOVK  X21, #0xf9e5, LSL #16
    MOVK  X21, #0xcb43, LSL #32
    MOVK  X21, #0xa452, LSL #48
    SUB  X11, X21, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X24, X15, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0x524a, LSL #0
    MOVK  X12, #0x1bea, LSL #16
    MOVK  X12, #0x333, LSL #32
    MOVK  X12, #0xf475, LSL #48
    SUB  X27, X12, X29
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D2
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D3
    MOVZ  X4, #0x6def, LSL #0
    SUB  X5, X4, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, D4
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D5
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, D6
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, D7
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, D8
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, V9.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X25
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, D9
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X25
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X2, X29, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, D10
    MOVZ  X29, #0x0, LSL #0
    SUB  X2, X29, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, V11.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, D11
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, V12.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, D12
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, D13
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, V14.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X24, X15, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, D14
    MOVZ  X15, #0x0, LSL #0
    SUB  X24, X15, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, D15
    MOVZ  X2, #0x6def, LSL #0
    SUB  X7, X2, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X11, X24, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, D16
    MOVZ  X24, #0x0, LSL #0
    SUB  X11, X24, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, D17
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, D18
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D20
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D21
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X5, X20, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, D22
    MOVZ  X20, #0x0, LSL #0
    SUB  X5, X20, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X18
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, D23
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X18
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X20, D24
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, D25
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, D26
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, D27
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X8, X24, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, D28
    MOVZ  X24, #0x0, LSL #0
    SUB  X8, X24, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X28, X3, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, D29
    MOVZ  X3, #0x0, LSL #0
    SUB  X28, X3, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
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
    FMOV  D0, X4
    FMOV  V0.D[1], X5
    FMOV  D1, X13
    FMOV  V1.D[1], X7
    FMOV  D2, X6
    FMOV  V2.D[1], X11
    FMOV  D3, X8
    FMOV  V3.D[1], X13
    FMOV  D4, X11
    FMOV  V4.D[1], X28
    FMOV  D5, X27
    FMOV  V5.D[1], X22
    FMOV  D6, X29
    FMOV  V6.D[1], X16
    FMOV  D7, X23
    FMOV  V7.D[1], X14
    FMOV  D8, X16
    FMOV  V8.D[1], X16
    FMOV  D9, X25
    FMOV  V9.D[1], X2
    FMOV  D10, X28
    FMOV  V10.D[1], X13
    FMOV  D11, X24
    FMOV  V11.D[1], X25
    FMOV  D12, X7
    FMOV  V12.D[1], X28
    FMOV  D13, X22
    FMOV  V13.D[1], X23
    FMOV  D14, X24
    FMOV  V14.D[1], X25
    FMOV  D15, X22
    FMOV  V15.D[1], X3
    FMOV  D16, X20
    FMOV  V16.D[1], X14
    FMOV  D17, X17
    FMOV  V17.D[1], X8
    FMOV  D18, X22
    FMOV  V18.D[1], X14
    FMOV  D19, X15
    FMOV  V19.D[1], X20
    FMOV  D20, X7
    FMOV  V20.D[1], X9
    FMOV  D21, X3
    FMOV  V21.D[1], X21
    FMOV  D22, X17
    FMOV  V22.D[1], X17
    FMOV  D23, X26
    FMOV  V23.D[1], X3
    FMOV  D24, X13
    FMOV  V24.D[1], X3
    FMOV  D25, X11
    FMOV  V25.D[1], X14
    FMOV  D26, X4
    FMOV  V26.D[1], X15
    FMOV  D27, X29
    FMOV  V27.D[1], X8
    FMOV  D28, X22
    FMOV  V28.D[1], X4
    FMOV  D29, X10
    FMOV  V29.D[1], X4
    FMOV  D30, X6
    FMOV  V30.D[1], X11
    FMOV  D31, X17
    FMOV  V31.D[1], X8
    MOVZ  X21, #0xa, LSL #0
TaishanSimdElementArithemticP01_label_316:
    SMAXV  H16, V28.8H
    UMINV  B16, V19.8B
    UADDLV  S20, V20.4H
    SMAXV  B24, V23.16B
    SMAXV  H16, V18.8H
    UMAXV  H28, V27.8H
    UMAXV  S6, V18.4S
    SMINV  B17, V21.8B
    SMAXV  S7, V20.4S
    ADDV  B26, V19.8B
    UADDLV  H10, V25.16B
    ADDV  B16, V3.16B
    FMAXV  S21, V29.4S
    UADDLV  S29, V24.8H
    SMAXV  H23, V7.8H
    SMAXV  B0, V14.16B
    UMINV  S30, V19.4S
    SADDLV  S15, V24.8H
    UADDLV  D6, V23.4S
    UMAXV  S0, V17.4S
    UADDLV  H5, V25.16B
    SMAXV  S27, V30.4S
    UMAXV  H6, V4.4H
    FMINNMV  S5, V0.4S
    SMAXV  H18, V10.8H
    UADDLV  D1, V0.4S
    SMINV  B8, V26.8B
    ADDV  B26, V19.8B
    SMINV  S14, V16.4S
    UMAXV  B15, V29.16B
    UADDLV  S21, V28.4H
    SADDLV  S8, V10.8H
    FMAXNMV  S23, V2.4S
    FMINV  S20, V19.4S
    ADDV  H3, V12.8H
    FMINNMV  S13, V20.4S
    SMINV  H7, V21.8H
    ADDV  S24, V29.4S
    UMINV  H20, V20.4H
    FMINNMV  S6, V0.4S
    UADDLV  S17, V30.4H
    UMINV  S14, V20.4S
    FMAXV  S20, V17.4S
    UMINV  S20, V13.4S
    FMAXV  S6, V26.4S
    SADDLV  S3, V24.8H
    UMINV  B17, V22.16B
    FMAXV  S20, V20.4S
    ADDV  B1, V15.16B
    SMINV  B24, V25.16B
    UMAXV  H23, V8.8H
    UMAXV  B9, V4.8B
    UMAXV  B8, V23.16B
    UMINV  B11, V8.16B
    UMAXV  S11, V5.4S
    SADDLV  S7, V2.8H
    SADDLV  H16, V24.8B
    SADDLV  S11, V2.4H
    SMINV  B31, V26.16B
    SMINV  H16, V3.4H
    FMINV  S1, V1.4S
    UMAXV  S10, V25.4S
    UADDLV  D31, V15.4S
    ADDV  B26, V25.8B
    SADDLV  S8, V4.4H
    UADDLV  S6, V28.8H
    UMAXV  B17, V28.16B
    FMAXV  S11, V14.4S
    UADDLV  H15, V20.16B
    SMAXV  B31, V6.16B
    ADDV  H6, V1.8H
    FMINV  S10, V25.4S
    UMINV  H26, V15.8H
    FMAXV  S24, V4.4S
    SMINV  H26, V28.8H
    FMAXV  S7, V8.4S
    SMAXV  B31, V18.8B
    UADDLV  D4, V18.4S
    SMAXV  B23, V17.16B
    UMINV  B26, V10.16B
    ADDV  H26, V2.8H
    ADDV  B22, V28.8B
    UADDLV  H28, V28.8B
    SMINV  H8, V15.8H
    ADDV  B26, V21.8B
    UMAXV  S6, V22.4S
    UMAXV  H8, V5.8H
    UMAXV  B26, V12.16B
    UADDLV  D18, V25.4S
    UADDLV  D23, V9.4S
    SMINV  B0, V18.16B
    UMINV  H12, V14.8H
    FMAXV  S15, V31.4S
    SMAXV  B26, V30.8B
    UADDLV  S10, V14.4H
    UMINV  S17, V10.4S
    FMAXNMV  S28, V10.4S
    ADDV  H19, V19.8H
    UMAXV  S9, V19.4S
    UADDLV  S6, V28.8H
    FMAXNMV  S2, V15.4S
    SMAXV  B20, V14.16B
    SMAXV  H24, V21.4H
    SMINV  H6, V14.4H
    ADDV  B30, V20.16B
    SMAXV  S30, V7.4S
    SMINV  H6, V6.4H
    FMINV  S17, V20.4S
    ADDV  H15, V28.4H
    FMAXNMV  S18, V22.4S
    UADDLV  D12, V24.4S
    ADDV  H5, V13.4H
    FMINNMV  S15, V31.4S
    UMAXV  B18, V17.16B
    FMINNMV  S21, V16.4S
    SADDLV  S12, V30.8H
    ADDV  S22, V9.4S
    SADDLV  S13, V20.4H
    ADDV  B20, V0.8B
    UMINV  H31, V3.4H
    UMAXV  S6, V2.4S
    SADDLV  S20, V7.4H
    SADDLV  H2, V6.8B
    UADDLV  D2, V25.4S
    FMINNMV  S19, V8.4S
    ADDV  H24, V27.8H
    FMINV  S15, V27.4S
    UMAXV  B31, V25.16B
    SADDLV  S5, V7.8H
    SADDLV  D31, V6.4S
    FMINNMV  S22, V7.4S
    SMAXV  H12, V30.8H
    SMAXV  S14, V24.4S
    FMAXNMV  S8, V12.4S
    FMINV  S5, V11.4S
    SMINV  S9, V21.4S
    UMAXV  B14, V12.16B
    SMAXV  H25, V14.8H
    UADDLV  H20, V0.8B
    UMAXV  S21, V3.4S
    SMINV  B11, V16.8B
    FMAXNMV  S13, V21.4S
    UADDLV  S19, V27.8H
    FMAXNMV  S0, V3.4S
    ADDV  S3, V31.4S
    SMINV  B12, V3.8B
    UMAXV  B15, V23.16B
    SMINV  H19, V21.4H
    UMAXV  S26, V18.4S
    UMAXV  S24, V2.4S
    SADDLV  H2, V21.16B
    UMINV  S9, V18.4S
    UADDLV  H31, V28.16B
    FMINV  S14, V22.4S
    SMAXV  H0, V26.4H
    UADDLV  D19, V21.4S
    UMAXV  S28, V9.4S
    SMINV  H22, V18.8H
    UADDLV  H14, V10.8B
    FMAXNMV  S26, V23.4S
    SMINV  S27, V28.4S
    UMAXV  H27, V16.4H
    SMINV  S16, V2.4S
    UMAXV  H27, V14.4H
    UMINV  B21, V16.8B
    SADDLV  D3, V30.4S
    FMAXNMV  S30, V25.4S
    SMAXV  B16, V14.8B
    UMINV  B27, V9.8B
    SMAXV  B21, V29.16B
    SMAXV  B18, V25.16B
    FMINNMV  S26, V21.4S
    UMAXV  B13, V22.8B
    UADDLV  H26, V24.16B
    UMAXV  S13, V3.4S
    SADDLV  H29, V5.16B
    UMAXV  S4, V25.4S
    ADDV  B28, V13.8B
    UMAXV  H24, V4.8H
    ADDV  S22, V30.4S
    FMINV  S7, V4.4S
    UMAXV  B20, V17.8B
    UMAXV  S2, V16.4S
    SMINV  H0, V7.8H
    UMAXV  H8, V0.8H
    SADDLV  S16, V20.8H
    UMAXV  B0, V6.16B
    FMAXV  S29, V7.4S
    FMAXV  S31, V18.4S
    UMAXV  H18, V26.4H
    SMINV  B7, V6.8B
    UADDLV  D23, V2.4S
    SADDLV  S4, V28.4H
    FMAXNMV  S8, V11.4S
    ADDV  B11, V26.8B
    SMAXV  S7, V22.4S
    SMAXV  B12, V2.8B
    SMAXV  B16, V20.8B
    FMINNMV  S6, V17.4S
    SADDLV  S21, V30.4H
    SUBS  X21, X21, #0x1
    B.NE  TaishanSimdElementArithemticP01_label_316
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X2, X15, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X18, X23, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X14, X28, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X16, X14, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X24, X9, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
TaishanSimdElementArithemticP01_label_79:
    SUB  X15, X17, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X21, X20, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X14, X6, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X26
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, D2
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X17, X20, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, D3
    MOVZ  X20, #0x0, LSL #0
    SUB  X17, X20, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, D4
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, D5
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, V6.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, D6
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, D7
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, D8
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D9
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, D10
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D11
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, D12
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, D13
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, V14.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, D14
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, D15
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, D16
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, D17
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, D18
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, V20.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, D20
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, D21
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X9
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, D22
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X9
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X4
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, D23
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X4
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, D24
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X17, D25
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, D26
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X23, X13, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, D27
    MOVZ  X13, #0x0, LSL #0
    SUB  X23, X13, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D28
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D29
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
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
    FMOV  D0, X5
    FMOV  V0.D[1], X27
    FMOV  D1, X15
    FMOV  V1.D[1], X9
    FMOV  D2, X8
    FMOV  V2.D[1], X15
    FMOV  D3, X15
    FMOV  V3.D[1], X22
    FMOV  D4, X4
    FMOV  V4.D[1], X9
    FMOV  D5, X16
    FMOV  V5.D[1], X22
    FMOV  D6, X12
    FMOV  V6.D[1], X28
    FMOV  D7, X17
    FMOV  V7.D[1], X21
    FMOV  D8, X4
    FMOV  V8.D[1], X15
    FMOV  D9, X3
    FMOV  V9.D[1], X29
    FMOV  D10, X11
    FMOV  V10.D[1], X7
    FMOV  D11, X24
    FMOV  V11.D[1], X8
    FMOV  D12, X17
    FMOV  V12.D[1], X28
    FMOV  D13, X24
    FMOV  V13.D[1], X28
    FMOV  D14, X22
    FMOV  V14.D[1], X18
    FMOV  D15, X11
    FMOV  V15.D[1], X26
    FMOV  D16, X5
    FMOV  V16.D[1], X20
    FMOV  D17, X3
    FMOV  V17.D[1], X26
    FMOV  D18, X22
    FMOV  V18.D[1], X7
    FMOV  D19, X28
    FMOV  V19.D[1], X13
    FMOV  D20, X28
    FMOV  V20.D[1], X28
    FMOV  D21, X10
    FMOV  V21.D[1], X25
    FMOV  D22, X13
    FMOV  V22.D[1], X11
    FMOV  D23, X27
    FMOV  V23.D[1], X10
    FMOV  D24, X23
    FMOV  V24.D[1], X22
    FMOV  D25, X27
    FMOV  V25.D[1], X11
    FMOV  D26, X13
    FMOV  V26.D[1], X15
    FMOV  D27, X7
    FMOV  V27.D[1], X14
    FMOV  D28, X24
    FMOV  V28.D[1], X25
    FMOV  D29, X4
    FMOV  V29.D[1], X5
    FMOV  D30, X26
    FMOV  V30.D[1], X3
    FMOV  D31, X10
    FMOV  V31.D[1], X12
    MOVZ  X25, #0xf, LSL #0
TaishanSimdElementArithemticP01_label_391:
    SADDLV  D13, V27.4S
    UMINV  S14, V13.4S
    UADDLV  D21, V5.4S
    FMINNMV  S29, V26.4S
    SMINV  S25, V24.4S
    UMINV  B13, V14.8B
    FMINNMV  S18, V31.4S
    SADDLV  H0, V23.8B
    SMINV  S14, V2.4S
    SADDLV  S13, V30.4H
    UADDLV  D12, V28.4S
    SADDLV  D7, V21.4S
    SMAXV  B31, V29.16B
    UADDLV  H24, V18.16B
    UMAXV  S18, V18.4S
    UADDLV  H26, V14.8B
    SMINV  B21, V15.8B
    ADDV  S15, V13.4S
    SADDLV  H2, V27.16B
    ADDV  B21, V1.16B
    UMAXV  B18, V13.16B
    SADDLV  D25, V26.4S
    UADDLV  H0, V27.8B
    ADDV  S0, V8.4S
    SMAXV  H14, V10.4H
    SMAXV  H29, V0.4H
    UMINV  S31, V27.4S
    ADDV  S18, V22.4S
    ADDV  H26, V1.4H
    SMINV  S5, V27.4S
    SADDLV  S7, V18.8H
    UADDLV  D14, V4.4S
    SMINV  H31, V17.8H
    UMINV  S4, V11.4S
    SMINV  H23, V8.8H
    FMAXNMV  S29, V7.4S
    SADDLV  H3, V22.16B
    UMAXV  B22, V31.8B
    SADDLV  H28, V16.16B
    ADDV  B26, V30.16B
    FMAXNMV  S5, V18.4S
    FMINV  S13, V25.4S
    UMAXV  H22, V14.4H
    UADDLV  H28, V29.16B
    SMINV  H18, V3.4H
    FMINNMV  S29, V23.4S
    SMINV  H19, V22.4H
    SADDLV  D19, V16.4S
    FMINV  S11, V22.4S
    FMAXV  S23, V1.4S
    UMINV  H7, V29.4H
    UADDLV  D21, V10.4S
    SADDLV  D8, V14.4S
    UMINV  B0, V20.8B
    SMINV  B21, V9.16B
    UMINV  H11, V14.4H
    SMINV  S5, V5.4S
    FMAXNMV  S2, V11.4S
    FMAXNMV  S25, V0.4S
    UMAXV  B26, V6.16B
    ADDV  H10, V7.8H
    FMINNMV  S3, V25.4S
    UMAXV  B30, V20.8B
    FMINV  S14, V16.4S
    UMINV  H23, V11.8H
    FMINNMV  S20, V9.4S
    FMINV  S20, V28.4S
    SADDLV  H9, V2.16B
    ADDV  S25, V26.4S
    SADDLV  S29, V25.4H
    SMAXV  H15, V19.8H
    UMINV  H10, V5.4H
    ADDV  S13, V16.4S
    SMINV  H9, V18.8H
    SMINV  B13, V13.8B
    UADDLV  D30, V14.4S
    UMAXV  H11, V3.8H
    SADDLV  D23, V3.4S
    ADDV  B26, V13.8B
    UADDLV  H20, V9.16B
    FMAXNMV  S12, V26.4S
    UADDLV  S17, V19.4H
    UADDLV  S4, V15.4H
    SMINV  H23, V17.4H
    UADDLV  S1, V28.4H
    UADDLV  D22, V8.4S
    SADDLV  H4, V15.16B
    UMAXV  B29, V29.16B
    ADDV  S30, V16.4S
    SMINV  B5, V2.16B
    SMINV  H30, V20.8H
    UMAXV  H6, V25.4H
    SMAXV  S3, V6.4S
    SMAXV  B16, V22.16B
    UADDLV  S12, V31.8H
    UMAXV  B23, V9.16B
    FMAXV  S1, V9.4S
    UADDLV  S12, V1.8H
    UMAXV  B12, V0.8B
    UADDLV  H3, V9.8B
    UADDLV  D5, V12.4S
    SMAXV  H7, V22.8H
    ADDV  H19, V2.8H
    ADDV  B1, V0.16B
    SMINV  B19, V6.8B
    FMAXNMV  S0, V15.4S
    ADDV  H3, V15.8H
    SMINV  H31, V26.4H
    UMINV  H31, V19.8H
    UMINV  S1, V20.4S
    FMAXV  S8, V9.4S
    ADDV  B12, V22.16B
    UADDLV  H12, V15.16B
    FMINV  S25, V15.4S
    SMINV  B6, V11.8B
    UADDLV  D24, V5.4S
    UMINV  S17, V10.4S
    SMAXV  S15, V2.4S
    FMINV  S15, V0.4S
    UMAXV  H11, V1.8H
    FMINV  S3, V0.4S
    ADDV  S30, V7.4S
    FMAXV  S12, V3.4S
    SADDLV  S8, V8.4H
    UADDLV  D17, V10.4S
    FMAXV  S29, V20.4S
    SADDLV  H6, V25.8B
    SMINV  S7, V27.4S
    ADDV  S15, V13.4S
    SADDLV  D8, V5.4S
    UMAXV  S2, V4.4S
    UMAXV  S13, V10.4S
    SMAXV  H24, V29.4H
    ADDV  S10, V4.4S
    ADDV  B8, V21.8B
    SMAXV  S24, V31.4S
    ADDV  B20, V13.8B
    SADDLV  D19, V3.4S
    SMINV  B19, V30.16B
    SMINV  B7, V11.16B
    UMINV  B16, V23.16B
    SADDLV  S1, V16.4H
    FMINV  S14, V23.4S
    SMINV  B13, V6.16B
    UMAXV  S15, V14.4S
    UMINV  B15, V7.16B
    SADDLV  D4, V11.4S
    UMAXV  H20, V20.4H
    UMINV  S0, V4.4S
    FMAXV  S21, V26.4S
    FMINV  S10, V22.4S
    UADDLV  D6, V9.4S
    UMAXV  S31, V27.4S
    UMINV  S31, V5.4S
    UADDLV  S8, V2.8H
    SMAXV  H10, V5.8H
    SMINV  B12, V30.8B
    FMAXV  S3, V6.4S
    SADDLV  S4, V5.8H
    SMINV  B21, V10.8B
    ADDV  B30, V0.8B
    FMAXV  S20, V10.4S
    SMINV  S14, V30.4S
    UMINV  S13, V13.4S
    SADDLV  H5, V19.8B
    SADDLV  D25, V9.4S
    SMINV  H30, V6.4H
    SMINV  S31, V0.4S
    UMINV  H23, V12.4H
    FMAXV  S23, V2.4S
    SMINV  B22, V7.8B
    UADDLV  D31, V30.4S
    SADDLV  S19, V14.8H
    ADDV  H6, V30.8H
    UMAXV  H30, V18.8H
    SMINV  S14, V14.4S
    SMAXV  S13, V30.4S
    SMAXV  H23, V19.8H
    SMINV  H11, V24.8H
    SMAXV  B28, V0.16B
    UMAXV  H11, V25.8H
    UMAXV  S10, V15.4S
    ADDV  B15, V26.8B
    UMINV  B20, V27.8B
    UMAXV  S17, V1.4S
    SADDLV  S7, V11.4H
    SMAXV  S0, V15.4S
    UMAXV  H18, V16.8H
    UADDLV  S15, V2.4H
    SMINV  H13, V31.8H
    UMINV  B25, V21.8B
    SMAXV  H6, V27.8H
    ADDV  B6, V20.8B
    SMAXV  B0, V21.8B
    UADDLV  S6, V25.8H
    UADDLV  D31, V3.4S
    UMINV  H7, V24.4H
    FMAXNMV  S2, V10.4S
    ADDV  S30, V0.4S
    FMINV  S7, V0.4S
    SUBS  X25, X25, #0x1
    B.NE  TaishanSimdElementArithemticP01_label_391
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X28, X3, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X10, X14, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X8, X28, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X28, X26, X5
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X29, X8, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X16, X10, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X9, X7, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X12, X27, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X24, X14, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X29, X28, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X21, X3, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X18, X14, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X13, X6, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X18
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X28, X13, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X27, X22, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X8, X10, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X6, X9, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, D2
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X29, X4, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D3
    MOVZ  X4, #0x0, LSL #0
    SUB  X29, X4, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D4
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X21, X23, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, D5
    MOVZ  X23, #0x0, LSL #0
    SUB  X21, X23, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X20, X22, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, D6
    MOVZ  X22, #0x0, LSL #0
    SUB  X20, X22, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, D7
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, D8
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, D9
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, D11
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X29, X15, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D12
    MOVZ  X15, #0x0, LSL #0
    SUB  X29, X15, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X4, X8, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D13
    MOVZ  X8, #0x0, LSL #0
    SUB  X4, X8, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, V14.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, D14
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, D15
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X17, X27, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, D16
    MOVZ  X27, #0x0, LSL #0
    SUB  X17, X27, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X20, X11, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D17
    MOVZ  X11, #0x0, LSL #0
    SUB  X20, X11, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, D18
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X21, X17, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, D20
    MOVZ  X17, #0xff, LSL #0
    SUB  X21, X17, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, V21.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X5, X12, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, D21
    MOVZ  X12, #0x0, LSL #0
    SUB  X5, X12, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, D22
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X3
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, D23
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X3
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, D24
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, D25
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D26
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, V27.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X14, X13, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, D27
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X14, X13, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D28
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, D29
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0x51e9, LSL #0
    MOVK  X2, #0xfaa7, LSL #16
    MOVK  X2, #0x662, LSL #32
    MOVK  X2, #0x40c, LSL #48
    MOVZ  X3, #0x76ff, LSL #0
    MOVK  X3, #0xf2d0, LSL #16
    MOVK  X3, #0x5b4, LSL #32
    MOVK  X3, #0xc73a, LSL #48
    MOVZ  X4, #0xfa4, LSL #0
    MOVK  X4, #0x4127, LSL #16
    MOVK  X4, #0xe6c0, LSL #32
    MOVK  X4, #0x5ae1, LSL #48
    MOVZ  X5, #0x2e19, LSL #0
    MOVK  X5, #0xeabf, LSL #16
    MOVK  X5, #0x1b30, LSL #32
    MOVK  X5, #0xe23d, LSL #48
    MOVZ  X6, #0xaab2, LSL #0
    MOVK  X6, #0xc582, LSL #16
    MOVK  X6, #0x2768, LSL #32
    MOVK  X6, #0x702, LSL #48
    MOVZ  X7, #0x495d, LSL #0
    MOVK  X7, #0xe3a0, LSL #16
    MOVK  X7, #0x33d4, LSL #32
    MOVK  X7, #0xb20c, LSL #48
    MOVZ  X8, #0x49e3, LSL #0
    MOVK  X8, #0xf488, LSL #16
    MOVK  X8, #0x5886, LSL #32
    MOVK  X8, #0x9af3, LSL #48
    MOVZ  X9, #0x5e9f, LSL #0
    MOVK  X9, #0xb618, LSL #16
    MOVK  X9, #0xc6e2, LSL #32
    MOVK  X9, #0x9ab0, LSL #48
    MOVZ  X10, #0x37f1, LSL #0
    MOVK  X10, #0x6be0, LSL #16
    MOVK  X10, #0x418c, LSL #32
    MOVK  X10, #0x5426, LSL #48
    MOVZ  X11, #0xe78f, LSL #0
    MOVK  X11, #0xc382, LSL #16
    MOVK  X11, #0x91d8, LSL #32
    MOVK  X11, #0xc258, LSL #48
    MOVZ  X12, #0x618d, LSL #0
    MOVK  X12, #0x6d88, LSL #16
    MOVK  X12, #0x4434, LSL #32
    MOVK  X12, #0x4615, LSL #48
    MOVZ  X13, #0x4ecc, LSL #0
    MOVK  X13, #0xfe75, LSL #16
    MOVK  X13, #0xfb01, LSL #32
    MOVK  X13, #0x617e, LSL #48
    MOVZ  X14, #0x39ea, LSL #0
    MOVK  X14, #0xcafb, LSL #16
    MOVK  X14, #0x14b3, LSL #32
    MOVK  X14, #0xecf1, LSL #48
    MOVZ  X15, #0xce84, LSL #0
    MOVK  X15, #0x5fcf, LSL #16
    MOVK  X15, #0x8dda, LSL #32
    MOVK  X15, #0x44c7, LSL #48
    MOVZ  X16, #0xa444, LSL #0
    MOVK  X16, #0x6db1, LSL #16
    MOVK  X16, #0xfbf8, LSL #32
    MOVK  X16, #0xbab9, LSL #48
    MOVZ  X17, #0xe79, LSL #0
    MOVK  X17, #0xb9f9, LSL #16
    MOVK  X17, #0x9f12, LSL #32
    MOVK  X17, #0x400e, LSL #48
    MOVZ  X18, #0x19f8, LSL #0
    MOVK  X18, #0x498d, LSL #16
    MOVK  X18, #0xbe33, LSL #32
    MOVK  X18, #0x3513, LSL #48
    MOVZ  X20, #0x6124, LSL #0
    MOVK  X20, #0xf51b, LSL #16
    MOVK  X20, #0x36be, LSL #32
    MOVK  X20, #0x9398, LSL #48
    MOVZ  X21, #0x22aa, LSL #0
    MOVK  X21, #0xd118, LSL #16
    MOVK  X21, #0x967f, LSL #32
    MOVK  X21, #0xd980, LSL #48
    MOVZ  X22, #0xa7dc, LSL #0
    MOVK  X22, #0xea5d, LSL #16
    MOVK  X22, #0xf1c9, LSL #32
    MOVK  X22, #0xddc8, LSL #48
    MOVZ  X23, #0x7108, LSL #0
    MOVK  X23, #0xc7e3, LSL #16
    MOVK  X23, #0x6fee, LSL #32
    MOVK  X23, #0x19f2, LSL #48
    MOVZ  X24, #0x21ec, LSL #0
    MOVK  X24, #0xbdf0, LSL #16
    MOVK  X24, #0xb5d9, LSL #32
    MOVK  X24, #0x7fea, LSL #48
    MOVZ  X25, #0xa370, LSL #0
    MOVK  X25, #0x4490, LSL #16
    MOVK  X25, #0x987c, LSL #32
    MOVK  X25, #0x95ef, LSL #48
    MOVZ  X26, #0x692e, LSL #0
    MOVK  X26, #0x8e76, LSL #16
    MOVK  X26, #0x4dd4, LSL #32
    MOVK  X26, #0xd9dc, LSL #48
    MOVZ  X27, #0x3eb1, LSL #0
    MOVK  X27, #0xa60b, LSL #16
    MOVK  X27, #0x3988, LSL #32
    MOVK  X27, #0x52eb, LSL #48
    MOVZ  X28, #0xfe93, LSL #0
    MOVK  X28, #0x5e67, LSL #16
    MOVK  X28, #0xd427, LSL #32
    MOVK  X28, #0xfc9d, LSL #48
    MOVZ  X29, #0x6e38, LSL #0
    MOVK  X29, #0x9bd5, LSL #16
    MOVK  X29, #0xf82e, LSL #32
    MOVK  X29, #0xadca, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X22
    FMOV  D1, X29
    FMOV  V1.D[1], X10
    FMOV  D2, X9
    FMOV  V2.D[1], X26
    FMOV  D3, X11
    FMOV  V3.D[1], X26
    FMOV  D4, X28
    FMOV  V4.D[1], X27
    FMOV  D5, X15
    FMOV  V5.D[1], X12
    FMOV  D6, X3
    FMOV  V6.D[1], X17
    FMOV  D7, X11
    FMOV  V7.D[1], X27
    FMOV  D8, X24
    FMOV  V8.D[1], X22
    FMOV  D9, X24
    FMOV  V9.D[1], X17
    FMOV  D10, X17
    FMOV  V10.D[1], X20
    FMOV  D11, X23
    FMOV  V11.D[1], X28
    FMOV  D12, X24
    FMOV  V12.D[1], X20
    FMOV  D13, X18
    FMOV  V13.D[1], X26
    FMOV  D14, X28
    FMOV  V14.D[1], X9
    FMOV  D15, X23
    FMOV  V15.D[1], X12
    FMOV  D16, X8
    FMOV  V16.D[1], X15
    FMOV  D17, X15
    FMOV  V17.D[1], X6
    FMOV  D18, X3
    FMOV  V18.D[1], X27
    FMOV  D19, X9
    FMOV  V19.D[1], X28
    FMOV  D20, X8
    FMOV  V20.D[1], X21
    FMOV  D21, X21
    FMOV  V21.D[1], X14
    FMOV  D22, X11
    FMOV  V22.D[1], X4
    FMOV  D23, X10
    FMOV  V23.D[1], X20
    FMOV  D24, X4
    FMOV  V24.D[1], X22
    FMOV  D25, X16
    FMOV  V25.D[1], X11
    FMOV  D26, X16
    FMOV  V26.D[1], X18
    FMOV  D27, X5
    FMOV  V27.D[1], X9
    FMOV  D28, X3
    FMOV  V28.D[1], X11
    FMOV  D29, X17
    FMOV  V29.D[1], X29
    FMOV  D30, X10
    FMOV  V30.D[1], X23
    FMOV  D31, X6
    FMOV  V31.D[1], X20
    MOVZ  X14, #0xa, LSL #0
TaishanSimdElementArithemticP01_label_466:
    SMINV  S16, V0.4S
    SADDLV  S3, V16.4H
    UMAXV  H4, V31.4H
    SMAXV  S14, V27.4S
    SMINV  B31, V24.8B
    ADDV  B26, V4.8B
    UMAXV  B22, V13.8B
    UMINV  B10, V17.16B
    FMINV  S23, V3.4S
    FMINV  S7, V29.4S
    SADDLV  H4, V0.8B
    SMINV  B13, V26.16B
    FMINNMV  S12, V19.4S
    ADDV  S14, V4.4S
    SADDLV  S12, V29.4H
    FMAXV  S27, V31.4S
    FMAXNMV  S22, V26.4S
    UADDLV  S7, V11.8H
    SADDLV  S7, V10.8H
    UMAXV  S17, V22.4S
    FMINNMV  S30, V3.4S
    ADDV  S25, V9.4S
    SADDLV  H21, V31.16B
    ADDV  B17, V22.8B
    UADDLV  D29, V4.4S
    FMAXNMV  S11, V22.4S
    ADDV  H4, V30.4H
    SADDLV  D7, V15.4S
    SMAXV  B31, V16.16B
    SMINV  B6, V18.8B
    SMAXV  B19, V21.16B
    ADDV  H14, V4.8H
    UADDLV  H26, V5.16B
    UMAXV  B23, V5.8B
    SADDLV  H8, V26.16B
    FMAXNMV  S11, V24.4S
    SMINV  H4, V28.4H
    SMINV  H9, V16.8H
    FMAXV  S23, V26.4S
    SMAXV  H6, V13.8H
    UMINV  H21, V6.4H
    ADDV  B17, V7.16B
    UADDLV  S4, V20.4H
    SADDLV  S17, V30.8H
    UMINV  H14, V11.4H
    FMINV  S21, V16.4S
    SMINV  H26, V26.4H
    UMINV  S18, V18.4S
    FMAXV  S4, V15.4S
    SMINV  B24, V29.8B
    SMINV  S12, V8.4S
    FMINV  S24, V14.4S
    UMINV  H21, V9.4H
    UMINV  S7, V9.4S
    UMAXV  H18, V14.4H
    UMINV  S16, V25.4S
    SADDLV  D14, V28.4S
    UMINV  H26, V25.4H
    UMINV  B15, V9.16B
    UMAXV  B23, V8.16B
    SMAXV  B28, V23.8B
    UMINV  B11, V2.16B
    UMINV  H31, V9.8H
    UADDLV  H17, V16.8B
    SADDLV  H14, V30.8B
    SADDLV  D8, V31.4S
    UMINV  H16, V26.4H
    UADDLV  D11, V7.4S
    SADDLV  H29, V5.16B
    UADDLV  H16, V16.16B
    UMINV  H23, V15.4H
    SMAXV  H2, V31.8H
    SMINV  H25, V0.8H
    UADDLV  S28, V27.8H
    SMAXV  S9, V27.4S
    SMINV  S5, V20.4S
    FMAXNMV  S7, V10.4S
    FMAXNMV  S9, V15.4S
    UMINV  B9, V26.16B
    SADDLV  D10, V13.4S
    UMAXV  S21, V17.4S
    UADDLV  H26, V9.16B
    UMAXV  S2, V18.4S
    UMAXV  H2, V20.4H
    ADDV  H21, V29.8H
    UMINV  B5, V7.16B
    UADDLV  S23, V30.8H
    ADDV  B5, V0.16B
    ADDV  B7, V4.16B
    ADDV  B12, V28.8B
    FMAXV  S26, V11.4S
    SMINV  S4, V22.4S
    SADDLV  D11, V29.4S
    SMINV  B15, V4.8B
    UMINV  H27, V27.4H
    SMINV  H20, V21.8H
    SADDLV  D15, V8.4S
    SMINV  H20, V16.4H
    UMINV  S15, V26.4S
    UMINV  H10, V12.8H
    SMINV  B29, V9.16B
    UMAXV  S8, V0.4S
    FMAXNMV  S6, V4.4S
    SADDLV  H21, V11.16B
    UADDLV  H21, V27.8B
    ADDV  H5, V4.4H
    SMINV  H28, V14.4H
    FMINV  S29, V12.4S
    UMAXV  H11, V23.8H
    FMAXNMV  S26, V7.4S
    FMINNMV  S8, V10.4S
    SMINV  H8, V2.8H
    FMINNMV  S6, V26.4S
    SMAXV  B29, V27.16B
    SADDLV  S6, V0.4H
    SADDLV  H23, V21.8B
    FMAXNMV  S27, V19.4S
    FMAXV  S31, V27.4S
    UMINV  B17, V23.16B
    SMAXV  H1, V11.8H
    UADDLV  S7, V7.8H
    SMINV  H21, V7.8H
    UADDLV  S18, V3.8H
    SADDLV  H30, V26.8B
    UMAXV  S4, V30.4S
    UADDLV  D25, V31.4S
    UMINV  S13, V7.4S
    SMINV  S24, V13.4S
    ADDV  H24, V17.8H
    UMINV  H5, V4.4H
    UADDLV  D27, V10.4S
    ADDV  S18, V30.4S
    FMAXNMV  S30, V29.4S
    UMAXV  S17, V0.4S
    SMAXV  H14, V1.4H
    SMINV  B18, V11.8B
    FMAXNMV  S31, V24.4S
    UADDLV  S30, V9.4H
    SMAXV  H13, V30.8H
    SMINV  S26, V21.4S
    UADDLV  H4, V2.8B
    FMINV  S7, V7.4S
    UADDLV  S0, V13.4H
    SADDLV  S19, V22.8H
    ADDV  H5, V5.4H
    UMINV  B7, V30.16B
    FMINNMV  S24, V21.4S
    SMAXV  S11, V23.4S
    SMINV  S1, V30.4S
    UMINV  H29, V0.4H
    UADDLV  S26, V29.8H
    UADDLV  D13, V1.4S
    SADDLV  H21, V18.8B
    UADDLV  D29, V11.4S
    SMINV  H24, V4.4H
    UADDLV  S2, V29.8H
    SADDLV  H16, V14.16B
    SMAXV  H9, V10.4H
    UMINV  B11, V1.16B
    FMINNMV  S1, V3.4S
    UMAXV  B2, V10.16B
    UMINV  S27, V21.4S
    FMAXV  S22, V8.4S
    SMAXV  S1, V4.4S
    UADDLV  H11, V5.8B
    FMAXV  S7, V28.4S
    UADDLV  S19, V22.4H
    SMAXV  B21, V12.16B
    SMINV  S9, V22.4S
    FMAXV  S23, V22.4S
    SMAXV  S26, V11.4S
    UMINV  H10, V4.8H
    FMINNMV  S4, V10.4S
    SMINV  S1, V7.4S
    FMAXV  S23, V4.4S
    FMINNMV  S23, V27.4S
    UMAXV  S16, V16.4S
    FMINNMV  S2, V4.4S
    SMINV  H25, V11.4H
    UMINV  B4, V3.16B
    FMAXNMV  S16, V28.4S
    SMAXV  H12, V15.4H
    UMINV  S29, V16.4S
    ADDV  H18, V7.4H
    ADDV  S1, V25.4S
    SMAXV  H21, V7.4H
    SMAXV  H4, V4.8H
    UMAXV  B12, V25.16B
    UMINV  B7, V7.16B
    SADDLV  H19, V3.8B
    SMINV  B5, V7.16B
    UMAXV  S7, V4.4S
    FMINNMV  S25, V25.4S
    ADDV  B19, V1.16B
    UMAXV  B23, V11.8B
    FMINNMV  S29, V22.4S
    UADDLV  H14, V28.8B
    ADDV  B18, V13.16B
    UMAXV  B22, V18.8B
    SMINV  H27, V23.8H
    SUBS  X14, X14, #0x1
    B.NE  TaishanSimdElementArithemticP01_label_466
    MOVZ  X27, #0x51e9, LSL #0
    MOVK  X27, #0xfaa7, LSL #16
    MOVK  X27, #0x662, LSL #32
    MOVK  X27, #0x40c, LSL #48
    SUB  X4, X27, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X20, #0x76ff, LSL #0
    MOVK  X20, #0xf2d0, LSL #16
    MOVK  X20, #0x5b4, LSL #32
    MOVK  X20, #0xc73a, LSL #48
    SUB  X24, X20, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0x2e19, LSL #0
    MOVK  X3, #0xeabf, LSL #16
    MOVK  X3, #0x1b30, LSL #32
    MOVK  X3, #0xe23d, LSL #48
    SUB  X8, X3, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X20, #0xaab2, LSL #0
    MOVK  X20, #0xc582, LSL #16
    MOVK  X20, #0x2768, LSL #32
    MOVK  X20, #0x702, LSL #48
    SUB  X6, X20, X6
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X29, #0x495d, LSL #0
    MOVK  X29, #0xe3a0, LSL #16
    MOVK  X29, #0x33d4, LSL #32
    MOVK  X29, #0xb20c, LSL #48
    SUB  X11, X29, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X13, #0x5e9f, LSL #0
    MOVK  X13, #0xb618, LSL #16
    MOVK  X13, #0xc6e2, LSL #32
    MOVK  X13, #0x9ab0, LSL #48
    SUB  X23, X13, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X26, #0x37f1, LSL #0
    MOVK  X26, #0x6be0, LSL #16
    MOVK  X26, #0x418c, LSL #32
    MOVK  X26, #0x5426, LSL #48
    SUB  X18, X26, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X25, #0x618d, LSL #0
    MOVK  X25, #0x6d88, LSL #16
    MOVK  X25, #0x4434, LSL #32
    MOVK  X25, #0x4615, LSL #48
    SUB  X8, X25, X12
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X16, #0x5e9f, LSL #0
    MOVK  X16, #0xb618, LSL #16
    MOVK  X16, #0xc6e2, LSL #32
    MOVK  X16, #0x9ab0, LSL #48
    SUB  X25, X16, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X18, #0x5e9f, LSL #0
    MOVK  X18, #0xb618, LSL #16
    MOVK  X18, #0xc6e2, LSL #32
    MOVK  X18, #0x9ab0, LSL #48
    SUB  X26, X18, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X24, #0xe79, LSL #0
    MOVK  X24, #0xb9f9, LSL #16
    MOVK  X24, #0x9f12, LSL #32
    MOVK  X24, #0x400e, LSL #48
    SUB  X3, X24, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X18, #0x5e9f, LSL #0
    MOVK  X18, #0xb618, LSL #16
    MOVK  X18, #0xc6e2, LSL #32
    MOVK  X18, #0x9ab0, LSL #48
    SUB  X8, X18, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X26, #0xaab2, LSL #0
    MOVK  X26, #0xc582, LSL #16
    MOVK  X26, #0x2768, LSL #32
    MOVK  X26, #0x702, LSL #48
    SUB  X4, X26, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X10, #0x22aa, LSL #0
    MOVK  X10, #0xd118, LSL #16
    MOVK  X10, #0x967f, LSL #32
    MOVK  X10, #0xd980, LSL #48
    SUB  X8, X10, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X24, #0xa7dc, LSL #0
    MOVK  X24, #0xea5d, LSL #16
    MOVK  X24, #0xf1c9, LSL #32
    MOVK  X24, #0xddc8, LSL #48
    SUB  X18, X24, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X23
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X27, #0xa7dc, LSL #0
    MOVK  X27, #0xea5d, LSL #16
    MOVK  X27, #0xf1c9, LSL #32
    MOVK  X27, #0xddc8, LSL #48
    SUB  X21, X27, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X12, X24, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X16, #0xaab2, LSL #0
    MOVK  X16, #0xc582, LSL #16
    MOVK  X16, #0x2768, LSL #32
    MOVK  X16, #0x702, LSL #48
    SUB  X15, X16, X26
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X10, #0xa7dc, LSL #0
    MOVK  X10, #0xea5d, LSL #16
    MOVK  X10, #0xf1c9, LSL #32
    MOVK  X10, #0xddc8, LSL #48
    SUB  X6, X10, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X16, #0xfe93, LSL #0
    MOVK  X16, #0x5e67, LSL #16
    MOVK  X16, #0xd427, LSL #32
    MOVK  X16, #0xfc9d, LSL #48
    SUB  X6, X16, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X27, #0x495d, LSL #0
    MOVK  X27, #0xe3a0, LSL #16
    MOVK  X27, #0x33d4, LSL #32
    MOVK  X27, #0xb20c, LSL #48
    SUB  X26, X27, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, D2
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D3
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, D4
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, D5
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, D6
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, D7
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, D8
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, D9
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D10
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, D11
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, D12
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, V13.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, D13
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X28, X22, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, D14
    MOVZ  X22, #0x0, LSL #0
    SUB  X28, X22, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X6, X29, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, D15
    MOVZ  X29, #0x0, LSL #0
    SUB  X6, X29, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, V16.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, D16
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, D17
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D18
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, D20
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, D21
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, V22.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, D22
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D23
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, D24
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, D25
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, D26
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, D27
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, D28
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, D29
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
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
    FMOV  D0, X20
    FMOV  V0.D[1], X15
    FMOV  D1, X26
    FMOV  V1.D[1], X10
    FMOV  D2, X18
    FMOV  V2.D[1], X25
    FMOV  D3, X18
    FMOV  V3.D[1], X12
    FMOV  D4, X27
    FMOV  V4.D[1], X16
    FMOV  D5, X25
    FMOV  V5.D[1], X29
    FMOV  D6, X24
    FMOV  V6.D[1], X12
    FMOV  D7, X28
    FMOV  V7.D[1], X21
    FMOV  D8, X4
    FMOV  V8.D[1], X9
    FMOV  D9, X12
    FMOV  V9.D[1], X12
    FMOV  D10, X7
    FMOV  V10.D[1], X9
    FMOV  D11, X14
    FMOV  V11.D[1], X7
    FMOV  D12, X4
    FMOV  V12.D[1], X24
    FMOV  D13, X6
    FMOV  V13.D[1], X20
    FMOV  D14, X6
    FMOV  V14.D[1], X20
    FMOV  D15, X18
    FMOV  V15.D[1], X12
    FMOV  D16, X24
    FMOV  V16.D[1], X5
    FMOV  D17, X16
    FMOV  V17.D[1], X14
    FMOV  D18, X7
    FMOV  V18.D[1], X9
    FMOV  D19, X23
    FMOV  V19.D[1], X6
    FMOV  D20, X9
    FMOV  V20.D[1], X6
    FMOV  D21, X16
    FMOV  V21.D[1], X21
    FMOV  D22, X5
    FMOV  V22.D[1], X20
    FMOV  D23, X18
    FMOV  V23.D[1], X4
    FMOV  D24, X17
    FMOV  V24.D[1], X28
    FMOV  D25, X26
    FMOV  V25.D[1], X13
    FMOV  D26, X23
    FMOV  V26.D[1], X20
    FMOV  D27, X22
    FMOV  V27.D[1], X29
    FMOV  D28, X6
    FMOV  V28.D[1], X11
    FMOV  D29, X5
    FMOV  V29.D[1], X14
    FMOV  D30, X18
    FMOV  V30.D[1], X15
    FMOV  D31, X4
    FMOV  V31.D[1], X6
    MOVZ  X13, #0xa, LSL #0
TaishanSimdElementArithemticP01_label_544:
    ADDV  B17, V31.8B
    UADDLV  H25, V30.16B
    SMINV  S15, V3.4S
    SADDLV  D0, V1.4S
    SMAXV  B26, V25.16B
    FMAXV  S31, V30.4S
    UADDLV  H6, V3.8B
    SADDLV  H4, V21.16B
    FMAXV  S29, V14.4S
    UMAXV  S8, V29.4S
    UADDLV  S15, V0.4H
    UMINV  S8, V9.4S
    SMAXV  S22, V12.4S
    SMINV  B23, V22.16B
    SMAXV  S24, V8.4S
    UMAXV  H8, V13.4H
    ADDV  S22, V25.4S
    UMINV  H10, V2.8H
    UADDLV  H12, V30.8B
    UMAXV  S27, V15.4S
    SMAXV  H23, V3.4H
    UMINV  B17, V26.8B
    UMINV  H23, V2.4H
    ADDV  S11, V15.4S
    SADDLV  S29, V21.8H
    SMINV  B0, V24.16B
    ADDV  H0, V4.8H
    UADDLV  S0, V9.4H
    ADDV  B23, V16.16B
    UMINV  B10, V11.16B
    UMAXV  S11, V6.4S
    ADDV  B9, V14.8B
    SMINV  S8, V31.4S
    SADDLV  D21, V15.4S
    SADDLV  S27, V29.8H
    SMAXV  B15, V24.16B
    UADDLV  D20, V25.4S
    FMAXNMV  S8, V9.4S
    SMAXV  B15, V6.16B
    ADDV  B13, V27.16B
    SMINV  S1, V31.4S
    ADDV  B26, V1.8B
    SMINV  S24, V3.4S
    UMAXV  S1, V20.4S
    FMINNMV  S30, V22.4S
    UADDLV  D20, V25.4S
    SMINV  S0, V13.4S
    SMAXV  S26, V15.4S
    SADDLV  H0, V13.16B
    UMAXV  H23, V6.4H
    UMAXV  B6, V13.8B
    SMAXV  H24, V24.8H
    SMINV  S29, V1.4S
    FMINNMV  S30, V30.4S
    SMAXV  S20, V13.4S
    SMAXV  H12, V22.8H
    UMAXV  B3, V22.8B
    UADDLV  S30, V25.4H
    FMAXNMV  S4, V10.4S
    SMINV  S25, V24.4S
    SMAXV  B27, V26.16B
    UMINV  H9, V30.8H
    UMAXV  H9, V1.8H
    SADDLV  D10, V23.4S
    UADDLV  D25, V16.4S
    UMINV  H0, V10.4H
    FMAXV  S19, V20.4S
    UADDLV  D13, V5.4S
    SADDLV  S21, V29.4H
    UADDLV  S23, V15.4H
    SMINV  S31, V4.4S
    ADDV  B31, V10.16B
    FMINNMV  S23, V20.4S
    UMAXV  S31, V21.4S
    ADDV  B17, V23.16B
    ADDV  H25, V21.4H
    SMAXV  B20, V1.8B
    SADDLV  H2, V27.16B
    SMAXV  B4, V31.8B
    SMAXV  B2, V17.8B
    UMINV  B3, V16.8B
    UMINV  H17, V2.4H
    UMINV  H18, V7.8H
    FMAXV  S29, V29.4S
    FMAXV  S28, V13.4S
    SMINV  H5, V11.8H
    ADDV  S13, V3.4S
    UADDLV  H31, V25.8B
    UADDLV  D12, V6.4S
    ADDV  S27, V1.4S
    SMINV  B18, V4.8B
    UADDLV  H11, V17.8B
    UMAXV  B10, V22.8B
    UADDLV  S22, V0.8H
    FMINNMV  S24, V24.4S
    SMINV  B29, V25.8B
    UMAXV  B25, V30.8B
    UMAXV  B12, V18.16B
    FMINV  S5, V12.4S
    SADDLV  H1, V27.8B
    FMINNMV  S0, V31.4S
    FMINV  S22, V7.4S
    FMINNMV  S1, V15.4S
    SMAXV  B18, V5.8B
    UMAXV  S29, V30.4S
    UMAXV  B13, V18.8B
    SMINV  H10, V29.4H
    UADDLV  H15, V31.8B
    UMAXV  S11, V7.4S
    UMAXV  B14, V24.8B
    UMINV  B29, V21.8B
    SMAXV  B0, V16.16B
    FMINNMV  S12, V25.4S
    FMINNMV  S15, V3.4S
    SMINV  S7, V27.4S
    SADDLV  S6, V11.8H
    ADDV  S15, V24.4S
    FMAXV  S23, V12.4S
    FMINV  S6, V15.4S
    FMINV  S12, V10.4S
    UMINV  B5, V12.8B
    UMINV  S30, V26.4S
    ADDV  B2, V25.8B
    UMINV  B4, V7.8B
    UMAXV  H4, V21.4H
    UMAXV  B13, V14.16B
    FMINNMV  S31, V11.4S
    SMINV  H21, V22.4H
    FMINV  S0, V18.4S
    SMAXV  S8, V30.4S
    FMAXNMV  S26, V8.4S
    FMINNMV  S21, V4.4S
    SMINV  B17, V4.16B
    UADDLV  D28, V12.4S
    SADDLV  S25, V3.4H
    UMAXV  B21, V20.8B
    UMAXV  H1, V16.8H
    UADDLV  H0, V2.16B
    SMAXV  H2, V10.4H
    ADDV  B10, V14.16B
    ADDV  S0, V24.4S
    ADDV  B14, V6.16B
    SMINV  S11, V8.4S
    FMAXV  S16, V21.4S
    UMINV  B18, V24.8B
    UADDLV  H7, V3.16B
    ADDV  H19, V31.4H
    UMAXV  H30, V25.8H
    SMINV  S2, V20.4S
    FMAXNMV  S31, V6.4S
    SMINV  S10, V29.4S
    FMAXNMV  S16, V8.4S
    SMINV  B12, V30.16B
    UADDLV  S20, V8.4H
    ADDV  B26, V31.16B
    UADDLV  D3, V10.4S
    UMINV  B31, V18.16B
    ADDV  S31, V3.4S
    FMINV  S18, V31.4S
    UMINV  H10, V28.4H
    UADDLV  D30, V7.4S
    UADDLV  S25, V4.8H
    UADDLV  S15, V26.4H
    UMINV  H26, V24.4H
    UADDLV  H29, V20.8B
    SADDLV  D19, V25.4S
    SMAXV  S22, V21.4S
    FMINNMV  S0, V10.4S
    UMINV  H26, V29.4H
    UMAXV  H8, V23.8H
    UMINV  B22, V15.16B
    SADDLV  D30, V25.4S
    UMAXV  S16, V30.4S
    UMAXV  B13, V19.16B
    SADDLV  H22, V5.8B
    UMAXV  B4, V16.8B
    UMINV  S10, V11.4S
    UMAXV  S8, V17.4S
    SADDLV  S15, V1.8H
    SADDLV  S21, V26.4H
    SMAXV  H13, V16.8H
    UADDLV  S19, V12.4H
    FMAXNMV  S29, V18.4S
    ADDV  B0, V3.16B
    SADDLV  H18, V9.8B
    UMINV  H30, V15.4H
    FMAXNMV  S5, V17.4S
    SMAXV  B10, V9.16B
    ADDV  H1, V23.4H
    UMAXV  B12, V16.8B
    SADDLV  D8, V4.4S
    SMINV  S30, V5.4S
    SMINV  S27, V9.4S
    UMINV  S18, V15.4S
    ADDV  H24, V25.4H
    SADDLV  D5, V26.4S
    ADDV  B11, V30.16B
    ADDV  S0, V12.4S
    FMINNMV  S3, V11.4S
    SMINV  S12, V3.4S
    SUBS  X13, X13, #0x1
    B.NE  TaishanSimdElementArithemticP01_label_544
    MOVZ  X20, #0x0, LSL #0
    SUB  X3, X20, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X8
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X15
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X11, X24, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X23, X15, X23
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X22, X17, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X10
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, D2
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X10
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, V3.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, D3
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, D4
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X12
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D5
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X12
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X12
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D6
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X12
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, V7.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, D7
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, D8
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X29
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, D9
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X29
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, D10
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, D11
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X17, V12.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X17, D12
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, V13.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, D13
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, D14
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, D15
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, D16
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, D17
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D18
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, D20
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X17, V21.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X13, X18, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X17, D21
    MOVZ  X18, #0x0, LSL #0
    SUB  X13, X18, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, D22
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, D23
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, D24
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X27, X3, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, D25
    MOVZ  X3, #0x0, LSL #0
    SUB  X27, X3, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D26
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, D27
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X21, X11, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D28
    MOVZ  X11, #0x0, LSL #0
    SUB  X21, X11, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, D29
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
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
    FMOV  D0, X24
    FMOV  V0.D[1], X24
    FMOV  D1, X3
    FMOV  V1.D[1], X2
    FMOV  D2, X7
    FMOV  V2.D[1], X12
    FMOV  D3, X16
    FMOV  V3.D[1], X29
    FMOV  D4, X8
    FMOV  V4.D[1], X23
    FMOV  D5, X24
    FMOV  V5.D[1], X21
    FMOV  D6, X18
    FMOV  V6.D[1], X7
    FMOV  D7, X14
    FMOV  V7.D[1], X28
    FMOV  D8, X9
    FMOV  V8.D[1], X16
    FMOV  D9, X25
    FMOV  V9.D[1], X28
    FMOV  D10, X27
    FMOV  V10.D[1], X29
    FMOV  D11, X8
    FMOV  V11.D[1], X9
    FMOV  D12, X10
    FMOV  V12.D[1], X13
    FMOV  D13, X14
    FMOV  V13.D[1], X14
    FMOV  D14, X18
    FMOV  V14.D[1], X5
    FMOV  D15, X3
    FMOV  V15.D[1], X18
    FMOV  D16, X10
    FMOV  V16.D[1], X28
    FMOV  D17, X29
    FMOV  V17.D[1], X14
    FMOV  D18, X28
    FMOV  V18.D[1], X14
    FMOV  D19, X9
    FMOV  V19.D[1], X8
    FMOV  D20, X13
    FMOV  V20.D[1], X20
    FMOV  D21, X29
    FMOV  V21.D[1], X17
    FMOV  D22, X25
    FMOV  V22.D[1], X13
    FMOV  D23, X25
    FMOV  V23.D[1], X12
    FMOV  D24, X8
    FMOV  V24.D[1], X25
    FMOV  D25, X12
    FMOV  V25.D[1], X10
    FMOV  D26, X17
    FMOV  V26.D[1], X14
    FMOV  D27, X22
    FMOV  V27.D[1], X7
    FMOV  D28, X8
    FMOV  V28.D[1], X24
    FMOV  D29, X7
    FMOV  V29.D[1], X6
    FMOV  D30, X24
    FMOV  V30.D[1], X3
    FMOV  D31, X26
    FMOV  V31.D[1], X8
    MOVZ  X17, #0xf, LSL #0
TaishanSimdElementArithemticP01_label_618:
    FMAXV  S0, V23.4S
    SMAXV  S0, V3.4S
    FMINNMV  S19, V26.4S
    SMAXV  S0, V29.4S
    SMINV  B25, V26.16B
    SMAXV  S25, V27.4S
    UADDLV  H19, V8.8B
    SMINV  S27, V24.4S
    FMINNMV  S28, V28.4S
    UADDLV  S6, V14.8H
    UMAXV  B31, V30.8B
    UMINV  H13, V12.8H
    UMAXV  H22, V0.8H
    UADDLV  S15, V6.4H
    UMINV  S28, V9.4S
    FMAXV  S26, V18.4S
    UMAXV  S25, V16.4S
    UMINV  B15, V15.8B
    UADDLV  D27, V1.4S
    ADDV  H26, V26.8H
    SMAXV  S22, V26.4S
    UMINV  S20, V0.4S
    UMAXV  B13, V31.8B
    SMINV  S26, V6.4S
    UMINV  B6, V30.8B
    SMAXV  H6, V5.4H
    SMINV  B17, V24.8B
    UMAXV  S23, V8.4S
    SMINV  H26, V13.8H
    SADDLV  D20, V22.4S
    ADDV  S24, V2.4S
    SADDLV  H23, V22.8B
    SMAXV  B23, V4.16B
    UMAXV  B24, V7.8B
    FMAXV  S0, V6.4S
    FMINNMV  S27, V1.4S
    UADDLV  H27, V20.8B
    ADDV  B23, V0.16B
    UMAXV  H0, V27.4H
    ADDV  H5, V27.8H
    SMAXV  H3, V0.4H
    UMAXV  H13, V16.8H
    ADDV  H31, V31.8H
    SMAXV  S5, V20.4S
    SMINV  H7, V7.4H
    SMINV  B3, V13.16B
    SADDLV  D5, V26.4S
    FMINV  S24, V6.4S
    UMAXV  S22, V21.4S
    SMINV  S21, V28.4S
    UADDLV  H8, V24.16B
    ADDV  B10, V7.16B
    SMINV  B22, V19.16B
    SMAXV  B11, V16.16B
    SMINV  H7, V30.4H
    SMAXV  S21, V13.4S
    ADDV  H17, V17.8H
    FMINNMV  S30, V27.4S
    SADDLV  S10, V9.8H
    FMAXV  S26, V12.4S
    SADDLV  D1, V22.4S
    SADDLV  D13, V28.4S
    UMINV  H12, V20.4H
    UMAXV  S30, V30.4S
    SMINV  B19, V6.16B
    SMINV  B5, V31.8B
    SMAXV  H8, V15.8H
    UADDLV  H5, V26.16B
    SMINV  S31, V15.4S
    FMAXV  S0, V22.4S
    FMAXNMV  S7, V19.4S
    UMINV  B2, V18.16B
    FMINV  S28, V18.4S
    UMINV  H20, V18.4H
    ADDV  B10, V27.16B
    SADDLV  D12, V30.4S
    UADDLV  S2, V19.4H
    SMAXV  B19, V11.8B
    SADDLV  H12, V28.16B
    UMAXV  S14, V20.4S
    SMINV  H14, V15.4H
    UMINV  B6, V16.8B
    FMAXNMV  S31, V29.4S
    SMINV  H1, V31.4H
    UMINV  B10, V5.16B
    UMAXV  B16, V9.16B
    UMAXV  H2, V17.4H
    UADDLV  H9, V7.16B
    SMAXV  B7, V2.8B
    SMAXV  H5, V10.4H
    ADDV  B9, V16.8B
    UADDLV  D25, V7.4S
    UMINV  S18, V28.4S
    UADDLV  D26, V25.4S
    SMAXV  H19, V7.8H
    UMAXV  B29, V28.16B
    SMAXV  B17, V29.16B
    UMAXV  B17, V31.8B
    SADDLV  S0, V19.4H
    UADDLV  H2, V22.16B
    ADDV  B4, V18.8B
    ADDV  S26, V4.4S
    UMAXV  S4, V19.4S
    SMINV  B24, V31.16B
    SADDLV  H31, V16.16B
    ADDV  B21, V29.16B
    SADDLV  H21, V19.16B
    ADDV  B5, V9.16B
    SMINV  B13, V11.8B
    UADDLV  H16, V11.16B
    UADDLV  D12, V11.4S
    SADDLV  S21, V11.4H
    SMINV  H25, V12.4H
    UMINV  S12, V21.4S
    UADDLV  S17, V11.4H
    UADDLV  H21, V22.8B
    SMAXV  S10, V8.4S
    UMINV  H27, V15.4H
    UADDLV  H2, V6.16B
    SMAXV  H6, V9.8H
    SMINV  H2, V12.4H
    SMAXV  S3, V22.4S
    ADDV  B0, V4.8B
    UMINV  B17, V7.8B
    FMAXV  S16, V1.4S
    SMINV  S23, V11.4S
    UMAXV  H7, V5.8H
    FMAXV  S21, V25.4S
    UMINV  B18, V4.8B
    UMINV  S29, V1.4S
    UMAXV  S8, V16.4S
    UMAXV  H16, V10.4H
    UMAXV  B17, V4.8B
    FMAXV  S17, V26.4S
    SMINV  H24, V24.8H
    SADDLV  H11, V2.8B
    UADDLV  H16, V19.16B
    FMINNMV  S0, V8.4S
    SMINV  S22, V12.4S
    ADDV  B31, V9.8B
    UMINV  B1, V3.16B
    SADDLV  S8, V15.4H
    UADDLV  S26, V7.8H
    FMINNMV  S5, V2.4S
    UMINV  H12, V15.4H
    SMAXV  S15, V18.4S
    FMAXNMV  S29, V17.4S
    ADDV  S17, V22.4S
    SADDLV  D9, V16.4S
    UMAXV  H9, V11.4H
    SMAXV  H18, V16.4H
    UMINV  H7, V25.8H
    ADDV  H2, V14.4H
    UMINV  H22, V24.8H
    SADDLV  D20, V18.4S
    SMINV  B14, V24.16B
    UMINV  S28, V17.4S
    SMINV  S10, V22.4S
    ADDV  S20, V25.4S
    SMINV  B25, V14.16B
    SMINV  S5, V25.4S
    UMAXV  B25, V27.16B
    UMAXV  H24, V27.8H
    UMAXV  S0, V24.4S
    FMAXV  S9, V10.4S
    UMAXV  H19, V10.8H
    UMINV  B29, V0.8B
    SADDLV  H11, V31.16B
    UMAXV  B3, V20.16B
    FMAXV  S24, V9.4S
    UMAXV  B3, V0.8B
    UMAXV  S5, V20.4S
    SMAXV  H0, V2.8H
    SMAXV  H14, V10.4H
    FMAXNMV  S9, V28.4S
    SMAXV  S28, V18.4S
    UADDLV  S12, V9.4H
    SADDLV  S22, V3.4H
    ADDV  B31, V11.16B
    FMAXV  S11, V28.4S
    ADDV  S9, V20.4S
    UMINV  B10, V2.16B
    SMINV  B0, V0.8B
    SMINV  H18, V2.4H
    SMINV  S20, V3.4S
    ADDV  H11, V1.4H
    UADDLV  H5, V14.16B
    UADDLV  D5, V5.4S
    SADDLV  D25, V3.4S
    FMINNMV  S24, V5.4S
    SADDLV  S1, V22.4H
    UADDLV  H4, V20.8B
    UMINV  B3, V31.16B
    FMAXNMV  S28, V1.4S
    SMAXV  S1, V21.4S
    UMINV  H25, V12.8H
    UADDLV  D13, V14.4S
    UADDLV  H13, V9.8B
    UADDLV  D2, V27.4S
    ADDV  H30, V21.4H
    SUBS  X17, X17, #0x1
    B.NE  TaishanSimdElementArithemticP01_label_618
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X11, X8, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X13, X23, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X14, X27, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X14, X25, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X14, X13, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X7, X11, X7
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X7, X26, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X15, X29, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X10, X24, X10
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X4, X13, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X8, X2, X12
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X28, X3, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X13, X24, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X3, X11, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X20, X6, X20
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X20, X17, X21
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X26, X8, X22
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X21, X29, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X7, X27, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X6, X18, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X29, X5, X29
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, D2
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, D3
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D4
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, D5
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, V6.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, D6
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X24, X28, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, D7
    MOVZ  X28, #0x0, LSL #0
    SUB  X24, X28, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, D8
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, D9
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X25, X22, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, D10
    MOVZ  X22, #0x0, LSL #0
    SUB  X25, X22, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, V11.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, D11
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, D12
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, D13
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, D14
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, V15.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, D15
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, D17
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X13, X24, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, D18
    MOVZ  X24, #0x0, LSL #0
    SUB  X13, X24, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, D20
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, D21
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, D22
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, D23
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D24
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, V25.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, D25
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, D26
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, V27.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, D27
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D28
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, D29
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0xa23e, LSL #0
    MOVK  X2, #0xf963, LSL #16
    MOVK  X2, #0x4f53, LSL #32
    MOVK  X2, #0xcc2b, LSL #48
    MOVZ  X3, #0x413d, LSL #0
    MOVK  X3, #0x4b5f, LSL #16
    MOVK  X3, #0x44e6, LSL #32
    MOVK  X3, #0xa719, LSL #48
    MOVZ  X4, #0xb120, LSL #0
    MOVK  X4, #0x58dc, LSL #16
    MOVK  X4, #0x87cf, LSL #32
    MOVK  X4, #0x390d, LSL #48
    MOVZ  X5, #0x168, LSL #0
    MOVK  X5, #0xb475, LSL #16
    MOVK  X5, #0x2b7d, LSL #32
    MOVK  X5, #0xe52e, LSL #48
    MOVZ  X6, #0x7448, LSL #0
    MOVK  X6, #0xf994, LSL #16
    MOVK  X6, #0xff1b, LSL #32
    MOVK  X6, #0x88ef, LSL #48
    MOVZ  X7, #0x6252, LSL #0
    MOVK  X7, #0xeee3, LSL #16
    MOVK  X7, #0x578e, LSL #32
    MOVK  X7, #0x735d, LSL #48
    MOVZ  X8, #0x3048, LSL #0
    MOVK  X8, #0x1f8d, LSL #16
    MOVK  X8, #0x45db, LSL #32
    MOVK  X8, #0x3e87, LSL #48
    MOVZ  X9, #0x5f90, LSL #0
    MOVK  X9, #0xb68, LSL #16
    MOVK  X9, #0x8bec, LSL #32
    MOVK  X9, #0x3a52, LSL #48
    MOVZ  X10, #0x6cd4, LSL #0
    MOVK  X10, #0xe1f8, LSL #16
    MOVK  X10, #0xf419, LSL #32
    MOVK  X10, #0x306a, LSL #48
    MOVZ  X11, #0xfe4a, LSL #0
    MOVK  X11, #0x3c6, LSL #16
    MOVK  X11, #0x65b, LSL #32
    MOVK  X11, #0xc79c, LSL #48
    MOVZ  X12, #0x52eb, LSL #0
    MOVK  X12, #0x56e8, LSL #16
    MOVK  X12, #0x95e1, LSL #32
    MOVK  X12, #0xa762, LSL #48
    MOVZ  X13, #0xba33, LSL #0
    MOVK  X13, #0x28ee, LSL #16
    MOVK  X13, #0x5dd5, LSL #32
    MOVK  X13, #0x9a57, LSL #48
    MOVZ  X14, #0xd42b, LSL #0
    MOVK  X14, #0x114, LSL #16
    MOVK  X14, #0x90b9, LSL #32
    MOVK  X14, #0x5d9b, LSL #48
    MOVZ  X15, #0x6f6, LSL #0
    MOVK  X15, #0x46a8, LSL #16
    MOVK  X15, #0x2691, LSL #32
    MOVK  X15, #0x22b4, LSL #48
    MOVZ  X16, #0xa60b, LSL #0
    MOVK  X16, #0x69f5, LSL #16
    MOVK  X16, #0x85a8, LSL #32
    MOVK  X16, #0xf2fb, LSL #48
    MOVZ  X17, #0x2285, LSL #0
    MOVK  X17, #0x65dc, LSL #16
    MOVK  X17, #0xaf11, LSL #32
    MOVK  X17, #0xad05, LSL #48
    MOVZ  X18, #0xa28e, LSL #0
    MOVK  X18, #0x691f, LSL #16
    MOVK  X18, #0xb869, LSL #32
    MOVK  X18, #0xdc89, LSL #48
    MOVZ  X20, #0x806, LSL #0
    MOVK  X20, #0x37b0, LSL #16
    MOVK  X20, #0x9266, LSL #32
    MOVK  X20, #0x3ffa, LSL #48
    MOVZ  X21, #0x9331, LSL #0
    MOVK  X21, #0x1095, LSL #16
    MOVK  X21, #0x79dd, LSL #32
    MOVK  X21, #0xc7d5, LSL #48
    MOVZ  X22, #0x4397, LSL #0
    MOVK  X22, #0x759a, LSL #16
    MOVK  X22, #0x5fcb, LSL #32
    MOVK  X22, #0x4461, LSL #48
    MOVZ  X23, #0xde7d, LSL #0
    MOVK  X23, #0x42d1, LSL #16
    MOVK  X23, #0x59f8, LSL #32
    MOVK  X23, #0x845, LSL #48
    MOVZ  X24, #0x9e01, LSL #0
    MOVK  X24, #0x43ca, LSL #16
    MOVK  X24, #0xc2f4, LSL #32
    MOVK  X24, #0x61c0, LSL #48
    MOVZ  X25, #0x9975, LSL #0
    MOVK  X25, #0x81b6, LSL #16
    MOVK  X25, #0x3c62, LSL #32
    MOVK  X25, #0x999b, LSL #48
    MOVZ  X26, #0x95e2, LSL #0
    MOVK  X26, #0xa28e, LSL #16
    MOVK  X26, #0xc0d4, LSL #32
    MOVK  X26, #0xc1db, LSL #48
    MOVZ  X27, #0xa8b9, LSL #0
    MOVK  X27, #0xc849, LSL #16
    MOVK  X27, #0xae58, LSL #32
    MOVK  X27, #0xdd, LSL #48
    MOVZ  X28, #0x6f3a, LSL #0
    MOVK  X28, #0xfdc1, LSL #16
    MOVK  X28, #0xdd02, LSL #32
    MOVK  X28, #0x649a, LSL #48
    MOVZ  X29, #0x88f3, LSL #0
    MOVK  X29, #0xb256, LSL #16
    MOVK  X29, #0x62da, LSL #32
    MOVK  X29, #0xdafd, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X23
    FMOV  D1, X22
    FMOV  V1.D[1], X4
    FMOV  D2, X25
    FMOV  V2.D[1], X26
    FMOV  D3, X24
    FMOV  V3.D[1], X27
    FMOV  D4, X13
    FMOV  V4.D[1], X28
    FMOV  D5, X12
    FMOV  V5.D[1], X16
    FMOV  D6, X4
    FMOV  V6.D[1], X7
    FMOV  D7, X17
    FMOV  V7.D[1], X5
    FMOV  D8, X23
    FMOV  V8.D[1], X2
    FMOV  D9, X13
    FMOV  V9.D[1], X3
    FMOV  D10, X28
    FMOV  V10.D[1], X22
    FMOV  D11, X12
    FMOV  V11.D[1], X28
    FMOV  D12, X24
    FMOV  V12.D[1], X21
    FMOV  D13, X9
    FMOV  V13.D[1], X22
    FMOV  D14, X12
    FMOV  V14.D[1], X5
    FMOV  D15, X24
    FMOV  V15.D[1], X17
    FMOV  D16, X2
    FMOV  V16.D[1], X4
    FMOV  D17, X2
    FMOV  V17.D[1], X7
    FMOV  D18, X14
    FMOV  V18.D[1], X3
    FMOV  D19, X25
    FMOV  V19.D[1], X12
    FMOV  D20, X28
    FMOV  V20.D[1], X18
    FMOV  D21, X13
    FMOV  V21.D[1], X16
    FMOV  D22, X8
    FMOV  V22.D[1], X13
    FMOV  D23, X16
    FMOV  V23.D[1], X25
    FMOV  D24, X11
    FMOV  V24.D[1], X16
    FMOV  D25, X15
    FMOV  V25.D[1], X20
    FMOV  D26, X9
    FMOV  V26.D[1], X12
    FMOV  D27, X22
    FMOV  V27.D[1], X15
    FMOV  D28, X5
    FMOV  V28.D[1], X11
    FMOV  D29, X18
    FMOV  V29.D[1], X22
    FMOV  D30, X14
    FMOV  V30.D[1], X18
    FMOV  D31, X11
    FMOV  V31.D[1], X2
    MOVZ  X25, #0xa, LSL #0
TaishanSimdElementArithemticP01_label_692:
    SADDLV  H25, V1.8B
    UMAXV  H27, V20.4H
    FMINNMV  S5, V25.4S
    SMINV  H20, V21.8H
    UADDLV  H14, V19.8B
    SMINV  H27, V10.4H
    UMAXV  B6, V11.8B
    SADDLV  D21, V5.4S
    UADDLV  S20, V28.8H
    FMINV  S0, V9.4S
    SMINV  B31, V22.16B
    UMINV  B12, V16.16B
    ADDV  S20, V22.4S
    UADDLV  H10, V10.8B
    UADDLV  H12, V22.16B
    SADDLV  S23, V31.4H
    UADDLV  H17, V27.16B
    SADDLV  D30, V0.4S
    SMAXV  S5, V6.4S
    SMINV  B14, V8.8B
    SMAXV  H18, V24.4H
    ADDV  H15, V7.4H
    UADDLV  S2, V1.8H
    UMINV  B19, V28.16B
    SMINV  S9, V2.4S
    FMINNMV  S10, V28.4S
    SADDLV  H19, V9.16B
    UADDLV  H9, V18.16B
    SADDLV  D30, V4.4S
    UADDLV  H30, V8.16B
    SMAXV  S13, V12.4S
    SADDLV  H22, V18.16B
    SADDLV  H24, V10.16B
    UMAXV  H9, V2.4H
    UADDLV  S12, V12.8H
    SMAXV  H15, V10.8H
    SMAXV  B19, V16.16B
    SMINV  S0, V6.4S
    SADDLV  S9, V18.4H
    UMAXV  B22, V19.16B
    SMAXV  B7, V18.8B
    SMAXV  H7, V14.4H
    SADDLV  H26, V21.16B
    UMINV  H27, V7.4H
    FMINV  S16, V1.4S
    SADDLV  S7, V9.4H
    UADDLV  H14, V23.16B
    FMINNMV  S0, V14.4S
    UADDLV  D0, V0.4S
    UADDLV  D28, V14.4S
    FMINNMV  S22, V30.4S
    FMINNMV  S12, V15.4S
    FMAXV  S23, V18.4S
    FMINNMV  S13, V23.4S
    UMAXV  H14, V16.4H
    UMINV  H22, V15.8H
    SMINV  B1, V6.16B
    SADDLV  S0, V9.8H
    UADDLV  D17, V6.4S
    SADDLV  H29, V27.16B
    UADDLV  D18, V29.4S
    FMAXNMV  S15, V31.4S
    SMAXV  S17, V12.4S
    UMAXV  B28, V21.8B
    UMINV  H29, V24.4H
    ADDV  S25, V10.4S
    SADDLV  H14, V23.8B
    FMINNMV  S3, V28.4S
    UMINV  S17, V6.4S
    UADDLV  H9, V14.8B
    SMINV  S22, V29.4S
    ADDV  S18, V12.4S
    SADDLV  H18, V27.16B
    UMAXV  B28, V20.8B
    ADDV  H19, V16.4H
    SMAXV  S1, V29.4S
    UADDLV  H29, V0.16B
    FMINV  S18, V28.4S
    ADDV  H27, V20.8H
    UMAXV  B21, V27.16B
    SADDLV  H22, V8.16B
    UMINV  B27, V31.8B
    SADDLV  S1, V20.4H
    UMAXV  H24, V12.8H
    FMINNMV  S11, V3.4S
    SADDLV  S1, V11.8H
    SMAXV  H19, V8.8H
    UMINV  S31, V17.4S
    FMAXV  S16, V28.4S
    UMAXV  S10, V16.4S
    SMINV  B27, V16.8B
    ADDV  S20, V20.4S
    UMAXV  H9, V7.8H
    UADDLV  D28, V3.4S
    UMAXV  H10, V31.8H
    SADDLV  D7, V26.4S
    ADDV  B12, V8.8B
    ADDV  H25, V27.8H
    UADDLV  S19, V9.8H
    UMAXV  S25, V18.4S
    SMAXV  S6, V23.4S
    SMINV  S6, V18.4S
    SMINV  S30, V2.4S
    UMINV  S12, V28.4S
    UMAXV  H27, V4.4H
    FMINV  S22, V15.4S
    SADDLV  H5, V24.8B
    SADDLV  D16, V12.4S
    UMAXV  B27, V28.16B
    UMINV  S12, V12.4S
    UADDLV  S28, V6.4H
    UADDLV  S30, V20.4H
    UMAXV  B20, V30.16B
    UADDLV  S29, V10.8H
    SMINV  H17, V2.4H
    FMINNMV  S12, V7.4S
    SMAXV  H10, V11.8H
    UMAXV  H22, V5.4H
    UMINV  H4, V15.4H
    UMAXV  S5, V22.4S
    SMINV  H14, V25.4H
    UMINV  H16, V17.8H
    UADDLV  S10, V11.4H
    UMAXV  H12, V22.8H
    UMINV  H28, V11.4H
    UADDLV  D22, V29.4S
    SMINV  S30, V12.4S
    UMINV  S12, V10.4S
    UMINV  S21, V26.4S
    UADDLV  S30, V27.8H
    SMINV  B12, V10.8B
    FMAXV  S13, V5.4S
    ADDV  H14, V23.8H
    UMAXV  S11, V17.4S
    SMAXV  H11, V18.4H
    ADDV  H20, V16.8H
    SMINV  S29, V23.4S
    UADDLV  S21, V2.4H
    SADDLV  H25, V26.8B
    SMAXV  H14, V30.4H
    FMAXV  S27, V30.4S
    FMAXNMV  S25, V14.4S
    SMINV  B24, V17.8B
    ADDV  S28, V30.4S
    ADDV  B17, V4.16B
    SMAXV  H1, V13.4H
    UADDLV  H3, V29.16B
    ADDV  H8, V0.8H
    UMINV  B3, V8.8B
    FMAXV  S1, V26.4S
    UADDLV  S16, V18.4H
    UADDLV  H8, V30.8B
    SADDLV  H14, V14.16B
    SMINV  S20, V13.4S
    UMAXV  S13, V0.4S
    SADDLV  S14, V9.4H
    SADDLV  H7, V1.16B
    SMAXV  S7, V18.4S
    SADDLV  D11, V14.4S
    ADDV  H28, V16.4H
    UMINV  B14, V31.8B
    UMAXV  B30, V31.8B
    FMINV  S2, V26.4S
    UADDLV  S3, V4.8H
    SADDLV  S7, V26.4H
    FMAXV  S3, V3.4S
    SMINV  H14, V3.8H
    SMAXV  S24, V22.4S
    ADDV  S21, V5.4S
    UMAXV  B2, V26.8B
    UADDLV  S27, V19.4H
    SMINV  S3, V18.4S
    UADDLV  S15, V3.4H
    FMINNMV  S30, V9.4S
    SMAXV  S21, V27.4S
    ADDV  H31, V13.8H
    SMINV  S15, V4.4S
    FMINNMV  S5, V4.4S
    ADDV  B22, V19.8B
    SADDLV  D11, V14.4S
    SMAXV  H13, V15.8H
    ADDV  H24, V27.8H
    FMAXNMV  S26, V14.4S
    SMINV  B20, V25.8B
    SMAXV  S12, V28.4S
    FMAXNMV  S9, V18.4S
    FMAXNMV  S18, V25.4S
    ADDV  S16, V7.4S
    UMINV  H3, V27.4H
    UMAXV  H25, V12.4H
    SMINV  S21, V3.4S
    SADDLV  S4, V18.4H
    UMINV  S4, V8.4S
    UADDLV  D20, V12.4S
    SMAXV  H6, V19.4H
    ADDV  B7, V15.16B
    SADDLV  D4, V6.4S
    FMINV  S4, V1.4S
    FMAXV  S6, V27.4S
    ADDV  H4, V17.4H
    SUBS  X25, X25, #0x1
    B.NE  TaishanSimdElementArithemticP01_label_692
    MOVZ  X7, #0xa23e, LSL #0
    MOVK  X7, #0xf963, LSL #16
    MOVK  X7, #0x4f53, LSL #32
    MOVK  X7, #0xcc2b, LSL #48
    SUB  X11, X7, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0x413d, LSL #0
    MOVK  X12, #0x4b5f, LSL #16
    MOVK  X12, #0x44e6, LSL #32
    MOVK  X12, #0xa719, LSL #48
    SUB  X16, X12, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0xb120, LSL #0
    MOVK  X3, #0x58dc, LSL #16
    MOVK  X3, #0x87cf, LSL #32
    MOVK  X3, #0x390d, LSL #48
    SUB  X24, X3, X4
TaishanSimdElementArithemticP01_label_478:
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X9, #0x168, LSL #0
    MOVK  X9, #0xb475, LSL #16
    MOVK  X9, #0x2b7d, LSL #32
    MOVK  X9, #0xe52e, LSL #48
    SUB  X18, X9, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X17, #0x7448, LSL #0
    MOVK  X17, #0xf994, LSL #16
    MOVK  X17, #0xff1b, LSL #32
    MOVK  X17, #0x88ef, LSL #48
    SUB  X8, X17, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X28, #0xa23e, LSL #0
    MOVK  X28, #0xf963, LSL #16
    MOVK  X28, #0x4f53, LSL #32
    MOVK  X28, #0xcc2b, LSL #48
    SUB  X9, X28, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X6, X25, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X11, #0x6cd4, LSL #0
    MOVK  X11, #0xe1f8, LSL #16
    MOVK  X11, #0xf419, LSL #32
    MOVK  X11, #0x306a, LSL #48
    SUB  X29, X11, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X4, #0x6cd4, LSL #0
    MOVK  X4, #0xe1f8, LSL #16
    MOVK  X4, #0xf419, LSL #32
    MOVK  X4, #0x306a, LSL #48
    SUB  X2, X4, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X7, #0x413d, LSL #0
    MOVK  X7, #0x4b5f, LSL #16
    MOVK  X7, #0x44e6, LSL #32
    MOVK  X7, #0xa719, LSL #48
    SUB  X6, X7, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X4, #0xba33, LSL #0
    MOVK  X4, #0x28ee, LSL #16
    MOVK  X4, #0x5dd5, LSL #32
    MOVK  X4, #0x9a57, LSL #48
    SUB  X29, X4, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X9, #0xd42b, LSL #0
    MOVK  X9, #0x114, LSL #16
    MOVK  X9, #0x90b9, LSL #32
    MOVK  X9, #0x5d9b, LSL #48
    SUB  X7, X9, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X28, #0x6f6, LSL #0
    MOVK  X28, #0x46a8, LSL #16
    MOVK  X28, #0x2691, LSL #32
    MOVK  X28, #0x22b4, LSL #48
    SUB  X8, X28, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X22, #0x7448, LSL #0
    MOVK  X22, #0xf994, LSL #16
    MOVK  X22, #0xff1b, LSL #32
    MOVK  X22, #0x88ef, LSL #48
    SUB  X16, X22, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X13, #0x806, LSL #0
    MOVK  X13, #0x37b0, LSL #16
    MOVK  X13, #0x9266, LSL #32
    MOVK  X13, #0x3ffa, LSL #48
    SUB  X15, X13, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0x7448, LSL #0
    MOVK  X2, #0xf994, LSL #16
    MOVK  X2, #0xff1b, LSL #32
    MOVK  X2, #0x88ef, LSL #48
    SUB  X18, X2, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X25, #0xde7d, LSL #0
    MOVK  X25, #0x42d1, LSL #16
    MOVK  X25, #0x59f8, LSL #32
    MOVK  X25, #0x845, LSL #48
    SUB  X24, X25, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X10, #0xde7d, LSL #0
    MOVK  X10, #0x42d1, LSL #16
    MOVK  X10, #0x59f8, LSL #32
    MOVK  X10, #0x845, LSL #48
    SUB  X27, X10, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X8, #0x6f6, LSL #0
    MOVK  X8, #0x46a8, LSL #16
    MOVK  X8, #0x2691, LSL #32
    MOVK  X8, #0x22b4, LSL #48
    SUB  X17, X8, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X20, D2
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, V3.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X7, X11, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, D3
    MOVZ  X11, #0x0, LSL #0
    SUB  X7, X11, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, D4
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, D5
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, D6
    MOVZ  X26, #0x65b, LSL #0
    SUB  X3, X26, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, D7
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, D8
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X26, X28, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D9
    MOVZ  X28, #0x0, LSL #0
    SUB  X26, X28, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X27, X22, X16
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, D10
    MOVZ  X22, #0x0, LSL #0
    SUB  X27, X22, X16
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D11
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, V12.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X20, X17, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, D12
    MOVZ  X17, #0x0, LSL #0
    SUB  X20, X17, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, D13
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, D14
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X17, V15.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X18, X3, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X17, D15
    MOVZ  X3, #0x0, LSL #0
    SUB  X18, X3, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, D16
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, D17
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, D18
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, D20
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, D21
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, D22
    MOVZ  X10, #0x61, LSL #0
    SUB  X9, X10, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D23
    MOVZ  X14, #0x65b, LSL #0
    SUB  X5, X14, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, D24
    MOVZ  X15, #0x65b, LSL #0
    SUB  X6, X15, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, D25
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X13, X3, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, D26
    MOVZ  X3, #0x0, LSL #0
    SUB  X13, X3, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, D27
    MOVZ  X25, #0x65b, LSL #0
    SUB  X7, X25, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X13
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D28
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X13
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X21, X17, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, D29
    MOVZ  X17, #0x0, LSL #0
    SUB  X21, X17, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
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
    FMOV  V0.D[1], X12
    FMOV  D1, X22
    FMOV  V1.D[1], X7
    FMOV  D2, X6
    FMOV  V2.D[1], X26
    FMOV  D3, X23
    FMOV  V3.D[1], X26
    FMOV  D4, X26
    FMOV  V4.D[1], X16
    FMOV  D5, X15
    FMOV  V5.D[1], X13
    FMOV  D6, X28
    FMOV  V6.D[1], X23
    FMOV  D7, X24
    FMOV  V7.D[1], X9
    FMOV  D8, X8
    FMOV  V8.D[1], X27
    FMOV  D9, X18
    FMOV  V9.D[1], X22
    FMOV  D10, X27
    FMOV  V10.D[1], X24
    FMOV  D11, X7
    FMOV  V11.D[1], X7
    FMOV  D12, X18
    FMOV  V12.D[1], X27
    FMOV  D13, X26
    FMOV  V13.D[1], X18
    FMOV  D14, X16
    FMOV  V14.D[1], X6
    FMOV  D15, X4
    FMOV  V15.D[1], X12
    FMOV  D16, X6
    FMOV  V16.D[1], X27
    FMOV  D17, X29
    FMOV  V17.D[1], X11
    FMOV  D18, X29
    FMOV  V18.D[1], X16
    FMOV  D19, X6
    FMOV  V19.D[1], X27
    FMOV  D20, X24
    FMOV  V20.D[1], X26
    FMOV  D21, X12
    FMOV  V21.D[1], X5
    FMOV  D22, X8
    FMOV  V22.D[1], X26
    FMOV  D23, X12
    FMOV  V23.D[1], X8
    FMOV  D24, X17
    FMOV  V24.D[1], X12
    FMOV  D25, X17
    FMOV  V25.D[1], X8
    FMOV  D26, X24
    FMOV  V26.D[1], X20
    FMOV  D27, X22
    FMOV  V27.D[1], X21
    FMOV  D28, X25
    FMOV  V28.D[1], X21
    FMOV  D29, X10
    FMOV  V29.D[1], X22
    FMOV  D30, X23
    FMOV  V30.D[1], X28
    FMOV  D31, X26
    FMOV  V31.D[1], X12
    MOVZ  X20, #0xa, LSL #0
TaishanSimdElementArithemticP01_label_762:
    UMINV  B25, V29.16B
    ADDV  H30, V6.8H
    SMAXV  H24, V10.4H
    UMINV  B1, V26.16B
    SMINV  S9, V14.4S
    SMINV  B9, V23.8B
    SMAXV  S17, V28.4S
    FMAXV  S1, V10.4S
    FMAXNMV  S7, V9.4S
    UADDLV  D1, V30.4S
    UADDLV  D1, V29.4S
    UMAXV  H31, V26.4H
    ADDV  B27, V7.16B
    SADDLV  D11, V21.4S
    UMINV  H23, V22.8H
    SMAXV  H17, V28.4H
    FMAXV  S6, V30.4S
    UMINV  H31, V19.4H
    ADDV  B11, V3.16B
    SMINV  S22, V12.4S
    UMINV  B5, V22.16B
    SMINV  S27, V30.4S
    SMAXV  H22, V20.8H
    UADDLV  S21, V7.8H
    FMAXNMV  S21, V31.4S
    SMAXV  B7, V22.16B
    FMINV  S5, V25.4S
    FMINNMV  S17, V22.4S
    UMAXV  B6, V27.8B
    SADDLV  H18, V21.8B
    SADDLV  D5, V29.4S
    FMAXNMV  S30, V17.4S
    ADDV  H20, V22.4H
    FMAXV  S0, V3.4S
    UMAXV  H10, V5.8H
    UMAXV  S15, V22.4S
    UMINV  B1, V23.16B
    SADDLV  S10, V25.4H
    SADDLV  D26, V18.4S
    SMINV  H30, V31.4H
    SMAXV  H28, V15.4H
    UMAXV  B9, V1.8B
    ADDV  B21, V4.8B
    UMAXV  B10, V6.16B
    UMAXV  S4, V20.4S
    UMAXV  H15, V17.4H
    SMINV  S7, V15.4S
    SMINV  S27, V0.4S
    UMAXV  B27, V10.8B
    UADDLV  S9, V23.8H
    UMAXV  B21, V5.16B
    SMAXV  S27, V23.4S
    UADDLV  S8, V3.8H
    UMINV  H1, V17.8H
    ADDV  H17, V30.4H
    SMINV  S11, V31.4S
    FMINNMV  S18, V22.4S
    FMAXNMV  S6, V6.4S
    SADDLV  S11, V21.8H
    UMAXV  S7, V9.4S
    ADDV  B27, V9.16B
    UMAXV  S1, V14.4S
    UADDLV  S29, V27.8H
    UMINV  B18, V7.16B
    SMAXV  S11, V0.4S
    SMINV  B17, V22.16B
    SMAXV  S11, V6.4S
    SADDLV  S9, V10.8H
    SMAXV  B4, V9.8B
    SADDLV  H11, V10.8B
    UADDLV  D5, V17.4S
    SMINV  H28, V27.4H
    SMINV  S6, V28.4S
    ADDV  H1, V30.4H
    UMAXV  S29, V16.4S
    UADDLV  D1, V13.4S
    SMAXV  S4, V23.4S
    UADDLV  S8, V18.4H
    SADDLV  D29, V4.4S
    UADDLV  S23, V11.4H
    SADDLV  H12, V9.16B
    SMAXV  S5, V15.4S
    UADDLV  H4, V10.16B
    UADDLV  D11, V19.4S
    UADDLV  S21, V25.4H
    UADDLV  H22, V5.16B
    SMAXV  H26, V11.4H
    UADDLV  H7, V18.16B
    UMINV  B14, V6.8B
    UMINV  S5, V5.4S
    UMINV  S14, V11.4S
    SMINV  H11, V21.8H
    UMINV  H21, V25.4H
    SMAXV  S6, V3.4S
    FMAXV  S8, V15.4S
    FMAXNMV  S27, V0.4S
    UMINV  B18, V23.8B
    FMAXNMV  S10, V25.4S
    UADDLV  S8, V14.8H
    UADDLV  H9, V23.16B
    SADDLV  H31, V18.8B
    UADDLV  S2, V1.4H
    UMAXV  B21, V29.8B
    FMAXV  S10, V15.4S
    UMINV  H29, V13.8H
    SADDLV  D29, V0.4S
    FMAXV  S15, V3.4S
    FMAXNMV  S20, V6.4S
    SMAXV  H23, V29.4H
    UMINV  H28, V7.8H
    SADDLV  S12, V19.4H
    FMAXNMV  S18, V27.4S
    SMAXV  S6, V13.4S
    FMINV  S23, V15.4S
    FMINV  S9, V28.4S
    ADDV  H3, V10.4H
    SMINV  H1, V24.4H
    SMINV  S9, V29.4S
    SADDLV  D3, V28.4S
    SADDLV  H12, V1.8B
    UMINV  B20, V29.16B
    UMAXV  S20, V14.4S
    UADDLV  S2, V23.4H
    UMAXV  S27, V12.4S
    UMINV  S3, V19.4S
    UADDLV  S29, V15.4H
    ADDV  S9, V23.4S
    UADDLV  S30, V19.8H
    UMINV  H3, V10.8H
    FMINNMV  S13, V16.4S
    FMAXNMV  S20, V23.4S
    FMAXV  S9, V13.4S
    ADDV  H7, V23.4H
    UMINV  S24, V29.4S
    UMINV  H4, V19.4H
    SADDLV  S15, V30.4H
    FMAXNMV  S29, V15.4S
    UADDLV  S29, V2.8H
    UMAXV  H15, V5.4H
    SMAXV  S18, V26.4S
    UMAXV  S5, V13.4S
    SMAXV  S18, V28.4S
    UADDLV  D28, V26.4S
    SMINV  B31, V19.8B
    SMAXV  B4, V13.8B
    UMINV  S8, V21.4S
    UMINV  H30, V31.4H
    UMINV  H13, V16.8H
    ADDV  S30, V24.4S
    UMINV  B3, V6.8B
    ADDV  S7, V2.4S
    SMAXV  B0, V26.8B
    UADDLV  S29, V3.8H
    UADDLV  S27, V10.8H
    FMINNMV  S24, V12.4S
    SMAXV  S24, V0.4S
    SMAXV  S4, V17.4S
    UADDLV  S28, V8.8H
    SADDLV  H2, V18.8B
    UMAXV  B9, V24.16B
    UADDLV  H31, V10.16B
    SADDLV  S28, V20.8H
    UMINV  H30, V27.4H
    FMAXNMV  S10, V30.4S
    FMAXNMV  S0, V9.4S
    SMAXV  B20, V4.16B
    SMINV  H29, V12.8H
    SMAXV  B19, V18.8B
    UMAXV  S5, V30.4S
    SMAXV  B5, V21.8B
    ADDV  S19, V24.4S
    FMAXNMV  S8, V20.4S
    UADDLV  D24, V3.4S
    UMAXV  S17, V31.4S
    SADDLV  D8, V22.4S
    UMINV  H26, V15.4H
    ADDV  S29, V13.4S
    UMINV  B4, V7.8B
    SADDLV  S21, V19.8H
    UMAXV  B9, V8.16B
    SMAXV  S13, V30.4S
    SMINV  S11, V22.4S
    UMAXV  B27, V11.8B
    SMINV  H19, V27.4H
    SMINV  B18, V14.16B
    UMINV  B5, V5.16B
    SMINV  H21, V21.8H
    SMAXV  B7, V21.16B
    SMAXV  H29, V2.4H
    FMAXV  S5, V21.4S
    UMAXV  S27, V8.4S
    UMAXV  B31, V9.16B
    SMAXV  H2, V15.4H
    SMAXV  S22, V13.4S
    ADDV  H15, V13.4H
    SADDLV  S25, V22.4H
    SADDLV  H14, V21.16B
    SMAXV  H4, V15.8H
    ADDV  H4, V24.8H
    UADDLV  H27, V23.8B
    SUBS  X20, X20, #0x1
    B.NE  TaishanSimdElementArithemticP01_label_762
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X20, X17, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X12, X9, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X10
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X17, X6, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X13, X18, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X25, X20, X22
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X27
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X23, X22, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X29
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, D2
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, V3.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, D3
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, D4
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, D5
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, D6
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, V7.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, D7
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X20, X28, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D8
    MOVZ  X28, #0x0, LSL #0
    SUB  X20, X28, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, D9
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, V10.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, D10
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, D11
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D12
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D13
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X27
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, D14
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X27
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, D15
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X23, X17, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, D16
    MOVZ  X17, #0x0, LSL #0
    SUB  X23, X17, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, V17.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, D17
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X20, D18
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D20
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, D21
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, V22.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, D22
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, D23
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, V24.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, D24
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, D25
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, D26
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, V27.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, D27
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, D28
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, D29
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
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
    FMOV  D0, X21
    FMOV  V0.D[1], X14
    FMOV  D1, X14
    FMOV  V1.D[1], X7
    FMOV  D2, X28
    FMOV  V2.D[1], X2
    FMOV  D3, X8
    FMOV  V3.D[1], X20
    FMOV  D4, X14
    FMOV  V4.D[1], X14
    FMOV  D5, X24
    FMOV  V5.D[1], X21
    FMOV  D6, X11
    FMOV  V6.D[1], X11
    FMOV  D7, X20
    FMOV  V7.D[1], X21
    FMOV  D8, X28
    FMOV  V8.D[1], X7
    FMOV  D9, X14
    FMOV  V9.D[1], X7
    FMOV  D10, X24
    FMOV  V10.D[1], X17
    FMOV  D11, X15
    FMOV  V11.D[1], X18
    FMOV  D12, X16
    FMOV  V12.D[1], X6
    FMOV  D13, X26
    FMOV  V13.D[1], X3
    FMOV  D14, X29
    FMOV  V14.D[1], X21
    FMOV  D15, X16
    FMOV  V15.D[1], X11
    FMOV  D16, X27
    FMOV  V16.D[1], X14
    FMOV  D17, X27
    FMOV  V17.D[1], X13
    FMOV  D18, X18
    FMOV  V18.D[1], X18
    FMOV  D19, X14
    FMOV  V19.D[1], X18
    FMOV  D20, X16
    FMOV  V20.D[1], X16
    FMOV  D21, X9
    FMOV  V21.D[1], X28
    FMOV  D22, X17
    FMOV  V22.D[1], X2
    FMOV  D23, X4
    FMOV  V23.D[1], X22
    FMOV  D24, X28
    FMOV  V24.D[1], X5
    FMOV  D25, X15
    FMOV  V25.D[1], X13
    FMOV  D26, X26
    FMOV  V26.D[1], X18
    FMOV  D27, X16
    FMOV  V27.D[1], X26
    FMOV  D28, X5
    FMOV  V28.D[1], X17
    FMOV  D29, X28
    FMOV  V29.D[1], X20
    FMOV  D30, X13
    FMOV  V30.D[1], X16
    FMOV  D31, X18
    FMOV  V31.D[1], X5
    MOVZ  X3, #0xf, LSL #0
TaishanSimdElementArithemticP01_label_836:
    UADDLV  D2, V14.4S
    SMAXV  S31, V22.4S
    UMINV  B11, V27.8B
    FMINNMV  S24, V4.4S
    ADDV  H25, V21.8H
    FMAXNMV  S6, V23.4S
    UMAXV  S20, V12.4S
    FMINNMV  S8, V21.4S
    UMAXV  B27, V28.16B
    SADDLV  S27, V11.8H
    UMINV  S3, V15.4S
    FMINV  S5, V20.4S
    ADDV  B11, V4.16B
    SADDLV  D5, V9.4S
    SMINV  B8, V31.8B
    UMAXV  B6, V2.16B
    FMAXNMV  S18, V18.4S
    UMINV  H2, V10.8H
    SMAXV  S1, V28.4S
    SMAXV  H29, V15.4H
    UMINV  S24, V30.4S
    SMINV  B0, V18.16B
    ADDV  S24, V6.4S
    SMINV  H21, V12.4H
    SADDLV  H26, V0.16B
    UMAXV  B9, V6.16B
    SMAXV  S30, V18.4S
    SMINV  B15, V8.16B
    UMAXV  H26, V22.8H
    SMAXV  S17, V25.4S
    UADDLV  H18, V27.8B
    UMINV  B3, V22.8B
    SMAXV  H0, V29.4H
    UMAXV  H0, V1.8H
    SADDLV  H21, V0.8B
    SADDLV  S27, V17.4H
    SADDLV  S26, V7.8H
    UADDLV  D31, V9.4S
    UMAXV  B19, V29.16B
    SMAXV  B17, V19.16B
    FMINNMV  S16, V21.4S
    SMINV  H1, V18.8H
    FMINV  S14, V3.4S
    FMAXV  S12, V6.4S
    UMINV  S12, V0.4S
    UMAXV  S19, V4.4S
    UADDLV  D20, V4.4S
    SMAXV  B14, V5.16B
    UMAXV  B3, V8.16B
    UADDLV  D20, V16.4S
    FMAXNMV  S6, V18.4S
    ADDV  H8, V19.4H
    ADDV  S0, V27.4S
    ADDV  S25, V16.4S
    ADDV  B22, V29.8B
    SMAXV  H17, V8.4H
    SMAXV  H3, V10.4H
    SMINV  B21, V17.16B
    SMAXV  H31, V4.4H
    UMINV  H31, V27.4H
    SADDLV  D8, V6.4S
    SMAXV  B10, V20.16B
    FMAXV  S6, V3.4S
    FMAXV  S12, V22.4S
    ADDV  S6, V4.4S
    SMAXV  S28, V22.4S
    SMAXV  S11, V5.4S
    SMAXV  B10, V18.16B
    UMINV  H6, V1.4H
    FMAXNMV  S29, V3.4S
    ADDV  B12, V3.16B
    SMAXV  S25, V31.4S
    FMAXV  S16, V13.4S
    SMINV  H7, V1.4H
    SADDLV  D0, V24.4S
    SADDLV  D16, V17.4S
    SADDLV  D12, V5.4S
    SMINV  B30, V4.16B
    ADDV  S3, V21.4S
    SMINV  S8, V17.4S
    UMINV  H6, V1.8H
    UMAXV  S24, V29.4S
    UADDLV  S1, V27.4H
    FMINNMV  S27, V22.4S
    UMINV  B16, V25.8B
    FMINV  S21, V23.4S
    SMINV  S25, V7.4S
    SADDLV  H16, V7.8B
    SMAXV  H9, V11.4H
    SADDLV  S23, V17.8H
    FMINV  S30, V2.4S
    SMAXV  S22, V24.4S
    SMINV  H7, V21.8H
    SADDLV  D18, V2.4S
    UMAXV  S18, V25.4S
    SMAXV  S7, V2.4S
    SADDLV  D4, V6.4S
    UADDLV  H23, V25.16B
    UMINV  S7, V11.4S
    ADDV  B7, V30.8B
    ADDV  H24, V7.8H
    UADDLV  H29, V2.8B
    FMINV  S13, V17.4S
    SMINV  B20, V1.8B
    FMAXNMV  S19, V0.4S
    UADDLV  D16, V30.4S
    SMAXV  B3, V18.8B
    FMINV  S2, V8.4S
    UMAXV  H10, V22.8H
    ADDV  H21, V25.8H
    UADDLV  H2, V15.8B
    ADDV  B8, V11.8B
    UMINV  S11, V1.4S
    UADDLV  S7, V26.8H
    SMINV  B24, V9.16B
    UMAXV  S26, V9.4S
    SADDLV  H22, V19.16B
    UMAXV  B26, V21.16B
    ADDV  S19, V29.4S
    SMAXV  H21, V9.8H
    UMINV  H25, V2.8H
    SMINV  H10, V31.8H
    SMAXV  S9, V12.4S
    UMINV  B15, V1.8B
    ADDV  S1, V1.4S
    SADDLV  D14, V17.4S
    SMINV  S11, V20.4S
    UMAXV  B6, V22.16B
    ADDV  H9, V22.4H
    FMINV  S24, V10.4S
    ADDV  B14, V8.16B
    SMINV  S15, V3.4S
    FMAXV  S3, V20.4S
    UMINV  H26, V31.4H
    SADDLV  D2, V9.4S
    FMINV  S17, V21.4S
    UADDLV  H12, V18.16B
    SMAXV  H22, V7.8H
    SADDLV  D27, V19.4S
    UADDLV  D27, V4.4S
    SMINV  B23, V10.8B
    SMAXV  S5, V24.4S
    UMAXV  H30, V26.4H
    FMAXV  S4, V29.4S
    UMINV  B11, V25.8B
    SMAXV  B9, V12.16B
    SMINV  B4, V10.8B
    UADDLV  D22, V28.4S
    FMINV  S13, V15.4S
    SADDLV  H19, V31.8B
    FMAXV  S31, V18.4S
    SMAXV  H18, V27.4H
    UMINV  H20, V8.8H
    SMINV  H9, V15.8H
    FMINNMV  S17, V13.4S
    SMAXV  B15, V28.8B
    SMINV  H21, V10.4H
    SMINV  H20, V16.8H
    ADDV  B17, V4.16B
    UMAXV  H12, V9.8H
    UMAXV  B6, V27.8B
    ADDV  H27, V9.8H
    SMINV  S1, V16.4S
    ADDV  H8, V29.8H
    SMAXV  H1, V18.4H
    SMINV  B17, V6.16B
    UMAXV  B23, V5.8B
    UADDLV  H19, V31.8B
    SMINV  B6, V27.16B
    UMAXV  B10, V16.8B
    SADDLV  S10, V29.4H
    SMAXV  B30, V15.8B
    UMAXV  H19, V5.4H
    UMINV  H9, V21.8H
    UADDLV  S4, V1.8H
    UMINV  S25, V12.4S
    FMAXV  S13, V6.4S
    ADDV  B29, V26.16B
    SADDLV  S7, V19.8H
    ADDV  S20, V8.4S
    UMAXV  B5, V13.8B
    UMAXV  B27, V22.16B
    UMAXV  B31, V9.8B
    UMAXV  B12, V23.16B
    FMINV  S26, V30.4S
    UADDLV  H20, V31.16B
    UMAXV  B19, V26.8B
    SMINV  S28, V23.4S
    ADDV  S16, V1.4S
    UMINV  S22, V8.4S
    SMAXV  H24, V17.8H
    FMINNMV  S17, V5.4S
    UMINV  S13, V20.4S
    SMINV  H24, V7.8H
    UMINV  H4, V23.4H
    UMAXV  H8, V16.8H
    SMAXV  H17, V20.4H
    UADDLV  D12, V23.4S
    UADDLV  D5, V7.4S
    UMINV  S1, V11.4S
    SUBS  X3, X3, #0x1
    B.NE  TaishanSimdElementArithemticP01_label_836
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X17, X13, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X7, X10, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X6, X4, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X24, X10, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X27, X22, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X18, X12, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X4, X13, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X9, X5, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X24, X25, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X12, X8, X13
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X3, X16, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X7, X11, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X12, X28, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X21, X28, X21
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X21, X16, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X24
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X15, X20, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X4, X6, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X28, X29, X28
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X15, X14, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X8, X9, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, D2
    MOVZ  X9, #0x0, LSL #0
    SUB  X8, X9, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, D3
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, D4
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, V5.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, D5
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, V6.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X22
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, D6
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X22
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, D7
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, V8.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, D8
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, D9
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X3
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, D10
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X3
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, D11
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X17, X22, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, D12
    MOVZ  X22, #0x0, LSL #0
    SUB  X17, X22, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D13
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, D14
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X25, X8, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, D15
    MOVZ  X8, #0x0, LSL #0
    SUB  X25, X8, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X14, X29, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, D16
    MOVZ  X29, #0x0, LSL #0
    SUB  X14, X29, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, D17
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, D18
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, D20
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, D21
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X6, X27, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D22
    MOVZ  X27, #0x0, LSL #0
    SUB  X6, X27, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, D23
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, D24
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X8
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, D25
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X8
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, D26
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X17, X22, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D27
    MOVZ  X22, #0x0, LSL #0
    SUB  X17, X22, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, D28
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, D29
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0x1b1b, LSL #0
    MOVK  X2, #0xf162, LSL #16
    MOVK  X2, #0xa461, LSL #32
    MOVK  X2, #0x17b6, LSL #48
    MOVZ  X3, #0x921a, LSL #0
    MOVK  X3, #0xce, LSL #16
    MOVK  X3, #0xadd9, LSL #32
    MOVK  X3, #0xd417, LSL #48
    MOVZ  X4, #0xdb65, LSL #0
    MOVK  X4, #0x69f6, LSL #16
    MOVK  X4, #0x91ef, LSL #32
    MOVK  X4, #0xc3de, LSL #48
    MOVZ  X5, #0x6bc8, LSL #0
    MOVK  X5, #0x6149, LSL #16
    MOVK  X5, #0x267a, LSL #32
    MOVK  X5, #0xebd2, LSL #48
    MOVZ  X6, #0x8009, LSL #0
    MOVK  X6, #0xe7c7, LSL #16
    MOVK  X6, #0x6b16, LSL #32
    MOVK  X6, #0x7e53, LSL #48
    MOVZ  X7, #0x5ad3, LSL #0
    MOVK  X7, #0xfe0f, LSL #16
    MOVK  X7, #0xe74d, LSL #32
    MOVK  X7, #0x2d86, LSL #48
    MOVZ  X8, #0x9365, LSL #0
    MOVK  X8, #0x1fff, LSL #16
    MOVK  X8, #0xbd26, LSL #32
    MOVK  X8, #0x1569, LSL #48
    MOVZ  X9, #0x27b1, LSL #0
    MOVK  X9, #0x94ea, LSL #16
    MOVK  X9, #0x1aa, LSL #32
    MOVK  X9, #0x6bbe, LSL #48
    MOVZ  X10, #0x563, LSL #0
    MOVK  X10, #0x1d16, LSL #16
    MOVK  X10, #0xe9e7, LSL #32
    MOVK  X10, #0x7a74, LSL #48
    MOVZ  X11, #0xce6d, LSL #0
    MOVK  X11, #0x95de, LSL #16
    MOVK  X11, #0x8866, LSL #32
    MOVK  X11, #0x8d0d, LSL #48
    MOVZ  X12, #0xcac1, LSL #0
    MOVK  X12, #0x636, LSL #16
    MOVK  X12, #0x6b0e, LSL #32
    MOVK  X12, #0x822f, LSL #48
    MOVZ  X13, #0x5d57, LSL #0
    MOVK  X13, #0x1e9e, LSL #16
    MOVK  X13, #0x6679, LSL #32
    MOVK  X13, #0xb55d, LSL #48
    MOVZ  X14, #0xb68f, LSL #0
    MOVK  X14, #0xd4df, LSL #16
    MOVK  X14, #0xc508, LSL #32
    MOVK  X14, #0x3b8, LSL #48
    MOVZ  X15, #0xb07d, LSL #0
    MOVK  X15, #0x1499, LSL #16
    MOVK  X15, #0x4368, LSL #32
    MOVK  X15, #0x26f3, LSL #48
    MOVZ  X16, #0x9178, LSL #0
    MOVK  X16, #0x8781, LSL #16
    MOVK  X16, #0xa65a, LSL #32
    MOVK  X16, #0x67e9, LSL #48
    MOVZ  X17, #0xb43b, LSL #0
    MOVK  X17, #0x60ac, LSL #16
    MOVK  X17, #0xaa30, LSL #32
    MOVK  X17, #0x3af8, LSL #48
    MOVZ  X18, #0xbc16, LSL #0
    MOVK  X18, #0x9d4b, LSL #16
    MOVK  X18, #0xd3f7, LSL #32
    MOVK  X18, #0xed96, LSL #48
    MOVZ  X20, #0x4676, LSL #0
    MOVK  X20, #0x2476, LSL #16
    MOVK  X20, #0x51cd, LSL #32
    MOVK  X20, #0x75d1, LSL #48
    MOVZ  X21, #0x8946, LSL #0
    MOVK  X21, #0x1098, LSL #16
    MOVK  X21, #0x9738, LSL #32
    MOVK  X21, #0xf75b, LSL #48
    MOVZ  X22, #0x2733, LSL #0
    MOVK  X22, #0x136e, LSL #16
    MOVK  X22, #0xcb4, LSL #32
    MOVK  X22, #0xe8d2, LSL #48
    MOVZ  X23, #0xd16f, LSL #0
    MOVK  X23, #0xd251, LSL #16
    MOVK  X23, #0x8bf3, LSL #32
    MOVK  X23, #0x655a, LSL #48
    MOVZ  X24, #0x2044, LSL #0
    MOVK  X24, #0x2919, LSL #16
    MOVK  X24, #0x73a3, LSL #32
    MOVK  X24, #0x13bd, LSL #48
    MOVZ  X25, #0x982e, LSL #0
    MOVK  X25, #0x24f3, LSL #16
    MOVK  X25, #0x3ed7, LSL #32
    MOVK  X25, #0x572f, LSL #48
    MOVZ  X26, #0xf7b6, LSL #0
    MOVK  X26, #0x9ca8, LSL #16
    MOVK  X26, #0x5214, LSL #32
    MOVK  X26, #0xf707, LSL #48
    MOVZ  X27, #0xd685, LSL #0
    MOVK  X27, #0x5ed1, LSL #16
    MOVK  X27, #0x1b0, LSL #32
    MOVK  X27, #0x2263, LSL #48
    MOVZ  X28, #0x66d6, LSL #0
    MOVK  X28, #0x3b, LSL #16
    MOVK  X28, #0x64d9, LSL #32
    MOVK  X28, #0xa646, LSL #48
    MOVZ  X29, #0xe1d5, LSL #0
    MOVK  X29, #0xbc0, LSL #16
    MOVK  X29, #0x32c1, LSL #32
    MOVK  X29, #0x50d8, LSL #48
    FMOV  D0, X8
    FMOV  V0.D[1], X9
    FMOV  D1, X27
    FMOV  V1.D[1], X6
    FMOV  D2, X6
    FMOV  V2.D[1], X2
    FMOV  D3, X14
    FMOV  V3.D[1], X26
    FMOV  D4, X25
    FMOV  V4.D[1], X18
    FMOV  D5, X5
    FMOV  V5.D[1], X29
    FMOV  D6, X13
    FMOV  V6.D[1], X15
    FMOV  D7, X13
    FMOV  V7.D[1], X3
    FMOV  D8, X25
    FMOV  V8.D[1], X24
    FMOV  D9, X7
    FMOV  V9.D[1], X9
    FMOV  D10, X7
    FMOV  V10.D[1], X16
    FMOV  D11, X24
    FMOV  V11.D[1], X23
    FMOV  D12, X14
    FMOV  V12.D[1], X22
    FMOV  D13, X6
    FMOV  V13.D[1], X11
    FMOV  D14, X26
    FMOV  V14.D[1], X10
    FMOV  D15, X15
    FMOV  V15.D[1], X13
    FMOV  D16, X6
    FMOV  V16.D[1], X3
    FMOV  D17, X24
    FMOV  V17.D[1], X12
    FMOV  D18, X13
    FMOV  V18.D[1], X27
    FMOV  D19, X17
    FMOV  V19.D[1], X4
    FMOV  D20, X10
    FMOV  V20.D[1], X17
    FMOV  D21, X11
    FMOV  V21.D[1], X20
    FMOV  D22, X6
    FMOV  V22.D[1], X15
    FMOV  D23, X9
    FMOV  V23.D[1], X6
    FMOV  D24, X2
    FMOV  V24.D[1], X6
    FMOV  D25, X13
    FMOV  V25.D[1], X23
    FMOV  D26, X6
    FMOV  V26.D[1], X13
    FMOV  D27, X26
    FMOV  V27.D[1], X13
    FMOV  D28, X9
    FMOV  V28.D[1], X5
    FMOV  D29, X5
    FMOV  V29.D[1], X11
    FMOV  D30, X20
    FMOV  V30.D[1], X26
    FMOV  D31, X5
    FMOV  V31.D[1], X6
    MOVZ  X18, #0xa, LSL #0
TaishanSimdElementArithemticP01_label_913:
    UMAXV  H30, V11.8H
    UADDLV  H22, V12.16B
    SMAXV  B31, V23.8B
    UMINV  B12, V20.8B
    UADDLV  S4, V8.4H
    SADDLV  S23, V27.8H
    UMAXV  H18, V2.8H
    UMINV  B3, V24.8B
    SADDLV  S26, V13.4H
    SMAXV  H16, V28.8H
    ADDV  H26, V24.4H
    SMINV  H12, V22.8H
    ADDV  B28, V30.8B
    SADDLV  H13, V28.16B
    SADDLV  D31, V29.4S
    FMAXV  S8, V0.4S
    FMAXV  S25, V23.4S
    UMAXV  B11, V8.8B
    SMINV  B26, V13.8B
    ADDV  S11, V16.4S
    SMAXV  S25, V20.4S
    SMINV  B20, V2.8B
    UMAXV  S11, V8.4S
    ADDV  B2, V23.8B
    SADDLV  S2, V16.8H
    SMAXV  H8, V8.8H
    SMAXV  S3, V1.4S
    FMAXNMV  S26, V21.4S
    SMINV  S18, V20.4S
    UMINV  B16, V25.16B
    SADDLV  D27, V8.4S
    FMINNMV  S31, V11.4S
    SMINV  S15, V28.4S
    FMAXNMV  S2, V23.4S
    SMINV  H14, V29.4H
    SADDLV  S20, V14.4H
    SADDLV  H4, V5.16B
    SMAXV  B5, V20.8B
    SMAXV  B13, V17.16B
    SMAXV  H12, V1.8H
    SMINV  S30, V27.4S
    FMINV  S16, V16.4S
    ADDV  S8, V4.4S
    UADDLV  H21, V16.8B
    UMINV  S31, V27.4S
    UADDLV  H0, V9.8B
    ADDV  B31, V21.16B
    SADDLV  H25, V22.16B
    UADDLV  S0, V20.4H
    UMAXV  B30, V31.16B
    UMAXV  B2, V23.16B
    SADDLV  H5, V3.8B
    UADDLV  H20, V8.16B
    FMAXV  S8, V7.4S
    SADDLV  H28, V27.16B
    UMAXV  S1, V16.4S
    UADDLV  S22, V26.4H
    UMAXV  B8, V3.8B
    UMINV  B4, V0.16B
    UMAXV  S27, V24.4S
    SMAXV  H6, V7.4H
    UMAXV  S1, V27.4S
    SADDLV  D9, V5.4S
    SMINV  B25, V16.16B
    SMAXV  S6, V6.4S
    FMINV  S18, V2.4S
    UMINV  B22, V20.16B
    SADDLV  D10, V5.4S
    UMINV  S8, V30.4S
    SMAXV  H16, V11.4H
    FMINV  S20, V27.4S
    UADDLV  H7, V1.8B
    SMINV  H2, V7.8H
    SMAXV  H18, V12.4H
    SMAXV  B28, V20.16B
    UADDLV  H28, V17.8B
    FMAXV  S1, V4.4S
    UMINV  H30, V25.4H
    UADDLV  S14, V11.4H
    UMAXV  B26, V10.8B
    ADDV  B17, V8.16B
    UADDLV  H22, V17.16B
    SADDLV  H16, V12.8B
    SMAXV  S5, V14.4S
    UMAXV  S19, V3.4S
    SMINV  H4, V20.4H
    FMAXNMV  S20, V9.4S
    UMAXV  H3, V22.4H
    ADDV  H24, V10.8H
    UMAXV  H27, V17.8H
    FMAXV  S28, V14.4S
    ADDV  H13, V8.4H
    SMINV  B28, V22.16B
    FMAXNMV  S6, V24.4S
    FMINNMV  S17, V1.4S
    UMINV  H13, V19.4H
    ADDV  S4, V7.4S
    SMINV  S20, V14.4S
    UADDLV  D2, V31.4S
    FMINV  S19, V21.4S
    UADDLV  H3, V9.8B
    UADDLV  D26, V18.4S
    SADDLV  D8, V18.4S
    UMINV  B27, V11.16B
    ADDV  S30, V22.4S
    SMAXV  S14, V12.4S
    ADDV  S28, V19.4S
    ADDV  B31, V3.8B
    FMINNMV  S20, V20.4S
    ADDV  B30, V27.8B
    UADDLV  H20, V1.8B
    UMINV  H26, V30.8H
    ADDV  S8, V27.4S
    UMAXV  S10, V11.4S
    UMAXV  B24, V8.8B
    ADDV  B24, V22.16B
    ADDV  S0, V14.4S
    SMAXV  H8, V2.4H
    SMAXV  B26, V19.8B
    SMAXV  B20, V25.8B
    FMAXV  S31, V19.4S
    SMAXV  H3, V10.4H
    SMAXV  B4, V17.16B
    UADDLV  D28, V6.4S
    SMINV  H17, V18.4H
    UMINV  H0, V21.8H
    FMINNMV  S20, V5.4S
    SADDLV  S14, V22.8H
    UMINV  H24, V21.4H
    FMINNMV  S5, V4.4S
    UMAXV  H11, V24.4H
    SADDLV  S16, V2.8H
    SMINV  H21, V18.4H
    SMINV  S12, V0.4S
    UMINV  H19, V27.4H
    UADDLV  S13, V20.4H
    UMAXV  H11, V10.4H
    ADDV  H5, V14.4H
    SMINV  S8, V11.4S
    SMAXV  S15, V28.4S
    FMAXNMV  S12, V21.4S
    UMAXV  B22, V15.8B
    SADDLV  D10, V5.4S
    SMINV  H25, V22.4H
    UADDLV  D10, V20.4S
    SMAXV  H10, V3.4H
    UADDLV  D16, V5.4S
    SMINV  S17, V14.4S
    ADDV  H11, V6.8H
    SMINV  B28, V31.16B
    ADDV  H12, V20.8H
    ADDV  B8, V29.16B
    FMINNMV  S4, V16.4S
    UADDLV  H3, V27.8B
    FMAXV  S3, V14.4S
    SMINV  B26, V21.8B
    SMAXV  B0, V31.16B
    SMAXV  S6, V31.4S
    UMINV  H3, V12.4H
    FMAXNMV  S25, V17.4S
    SMINV  B10, V6.16B
    SMAXV  B21, V30.8B
    SMINV  S1, V4.4S
    UADDLV  H16, V29.16B
    UMAXV  H11, V13.8H
    UMINV  H31, V3.4H
    ADDV  B13, V10.16B
    FMAXV  S3, V19.4S
    SMAXV  H12, V27.4H
    ADDV  B19, V0.16B
    FMINV  S20, V14.4S
    UMINV  B1, V13.16B
    SMINV  B20, V21.16B
    FMAXV  S3, V7.4S
    SMAXV  H4, V26.4H
    UMINV  S0, V16.4S
    ADDV  S19, V11.4S
    FMAXV  S31, V20.4S
    UMINV  H9, V0.4H
    SMINV  S3, V30.4S
    UMINV  B21, V17.8B
    UMAXV  S18, V5.4S
    UMINV  B31, V23.16B
    FMAXNMV  S3, V0.4S
    FMAXNMV  S18, V6.4S
    SMINV  B11, V12.8B
    UADDLV  H25, V31.16B
    UMAXV  B14, V3.8B
    ADDV  H0, V26.4H
    SMAXV  S27, V28.4S
    FMINNMV  S13, V10.4S
    UMAXV  B15, V18.16B
    SMINV  H19, V8.8H
    ADDV  B0, V29.16B
    UMAXV  S22, V25.4S
    FMINNMV  S2, V26.4S
    SMINV  B1, V16.16B
    FMAXV  S11, V31.4S
    SMINV  S10, V30.4S
    UMINV  H26, V24.8H
    SUBS  X18, X18, #0x1
    B.NE  TaishanSimdElementArithemticP01_label_913
    MOVZ  X28, #0x1b1b, LSL #0
    MOVK  X28, #0xf162, LSL #16
    MOVK  X28, #0xa461, LSL #32
    MOVK  X28, #0x17b6, LSL #48
    SUB  X18, X28, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0x921a, LSL #0
    MOVK  X3, #0xce, LSL #16
    MOVK  X3, #0xadd9, LSL #32
    MOVK  X3, #0xd417, LSL #48
    SUB  X9, X3, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X15, #0xdb65, LSL #0
    MOVK  X15, #0x69f6, LSL #16
    MOVK  X15, #0x91ef, LSL #32
    MOVK  X15, #0xc3de, LSL #48
    SUB  X14, X15, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0x6bc8, LSL #0
    MOVK  X12, #0x6149, LSL #16
    MOVK  X12, #0x267a, LSL #32
    MOVK  X12, #0xebd2, LSL #48
    SUB  X3, X12, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0x8009, LSL #0
    MOVK  X3, #0xe7c7, LSL #16
    MOVK  X3, #0x6b16, LSL #32
    MOVK  X3, #0x7e53, LSL #48
    SUB  X2, X3, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X6, #0x5ad3, LSL #0
    MOVK  X6, #0xfe0f, LSL #16
    MOVK  X6, #0xe74d, LSL #32
    MOVK  X6, #0x2d86, LSL #48
    SUB  X25, X6, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X21, #0x9365, LSL #0
    MOVK  X21, #0x1fff, LSL #16
    MOVK  X21, #0xbd26, LSL #32
    MOVK  X21, #0x1569, LSL #48
    SUB  X20, X21, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X25, #0x563, LSL #0
    MOVK  X25, #0x1d16, LSL #16
    MOVK  X25, #0xe9e7, LSL #32
    MOVK  X25, #0x7a74, LSL #48
    SUB  X22, X25, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0xce6d, LSL #0
    MOVK  X12, #0x95de, LSL #16
    MOVK  X12, #0x8866, LSL #32
    MOVK  X12, #0x8d0d, LSL #48
    SUB  X15, X12, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0xce6d, LSL #0
    MOVK  X2, #0x95de, LSL #16
    MOVK  X2, #0x8866, LSL #32
    MOVK  X2, #0x8d0d, LSL #48
    SUB  X11, X2, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X14, #0x5d57, LSL #0
    MOVK  X14, #0x1e9e, LSL #16
    MOVK  X14, #0x6679, LSL #32
    MOVK  X14, #0xb55d, LSL #48
    SUB  X5, X14, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X29, #0x5d57, LSL #0
    MOVK  X29, #0x1e9e, LSL #16
    MOVK  X29, #0x6679, LSL #32
    MOVK  X29, #0xb55d, LSL #48
    SUB  X7, X29, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X10, X28, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X21, #0xb43b, LSL #0
    MOVK  X21, #0x60ac, LSL #16
    MOVK  X21, #0xaa30, LSL #32
    MOVK  X21, #0x3af8, LSL #48
    SUB  X29, X21, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X18
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X27, X5, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X10, #0xb43b, LSL #0
    MOVK  X10, #0x60ac, LSL #16
    MOVK  X10, #0xaa30, LSL #32
    MOVK  X10, #0x3af8, LSL #48
    SUB  X22, X10, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0xd16f, LSL #0
    MOVK  X3, #0xd251, LSL #16
    MOVK  X3, #0x8bf3, LSL #32
    MOVK  X3, #0x655a, LSL #48
    SUB  X15, X3, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X6, #0x2044, LSL #0
    MOVK  X6, #0x2919, LSL #16
    MOVK  X6, #0x73a3, LSL #32
    MOVK  X6, #0x13bd, LSL #48
    SUB  X21, X6, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X5, #0x563, LSL #0
    MOVK  X5, #0x1d16, LSL #16
    MOVK  X5, #0xe9e7, LSL #32
    MOVK  X5, #0x7a74, LSL #48
    SUB  X18, X5, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X6, #0xf7b6, LSL #0
    MOVK  X6, #0x9ca8, LSL #16
    MOVK  X6, #0x5214, LSL #32
    MOVK  X6, #0xf707, LSL #48
    SUB  X9, X6, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X22, X23, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, D2
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D3
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, D4
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, D5
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, D6
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X27, X14, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, D7
    MOVZ  X14, #0x0, LSL #0
    SUB  X27, X14, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D8
    MOVZ  X11, #0x70, LSL #0
    SUB  X10, X11, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, V9.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X17, X22, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, D9
    MOVZ  X22, #0x0, LSL #0
    SUB  X17, X22, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, D10
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, D11
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, D12
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, D13
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, V14.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, D14
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, D15
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, V16.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, D16
    MOVZ  X3, #0x870, LSL #0
    SUB  X4, X3, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D17
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, D18
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, D20
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X17, V21.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X17, D21
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, V22.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, D22
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, D23
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, V24.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, D24
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, V25.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X26, X15, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, D25
    MOVZ  X15, #0x0, LSL #0
    SUB  X26, X15, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X7, X10, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, D26
    MOVZ  X10, #0x0, LSL #0
    SUB  X7, X10, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X20, D27
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, D28
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, V29.D[1]
    MOVZ  X2, #0xce6d, LSL #0
    MOVK  X2, #0x95de, LSL #16
    MOVK  X2, #0x8866, LSL #32
    MOVK  X2, #0x8d0d, LSL #48
    SUB  X11, X2, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, D29
    MOVZ  X2, #0x6bc8, LSL #0
    MOVK  X2, #0x6149, LSL #16
    MOVK  X2, #0x267a, LSL #32
    MOVK  X2, #0xebd2, LSL #48
    SUB  X11, X2, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
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
    FMOV  D1, X17
    FMOV  V1.D[1], X21
    FMOV  D2, X8
    FMOV  V2.D[1], X13
    FMOV  D3, X23
    FMOV  V3.D[1], X14
    FMOV  D4, X24
    FMOV  V4.D[1], X6
    FMOV  D5, X24
    FMOV  V5.D[1], X6
    FMOV  D6, X18
    FMOV  V6.D[1], X9
    FMOV  D7, X22
    FMOV  V7.D[1], X10
    FMOV  D8, X20
    FMOV  V8.D[1], X29
    FMOV  D9, X28
    FMOV  V9.D[1], X9
    FMOV  D10, X24
    FMOV  V10.D[1], X17
    FMOV  D11, X6
    FMOV  V11.D[1], X28
    FMOV  D12, X12
    FMOV  V12.D[1], X13
    FMOV  D13, X12
    FMOV  V13.D[1], X21
    FMOV  D14, X23
    FMOV  V14.D[1], X10
    FMOV  D15, X4
    FMOV  V15.D[1], X10
    FMOV  D16, X20
    FMOV  V16.D[1], X5
    FMOV  D17, X21
    FMOV  V17.D[1], X23
    FMOV  D18, X14
    FMOV  V18.D[1], X22
    FMOV  D19, X18
    FMOV  V19.D[1], X15
    FMOV  D20, X21
    FMOV  V20.D[1], X15
    FMOV  D21, X26
    FMOV  V21.D[1], X17
    FMOV  D22, X28
    FMOV  V22.D[1], X14
    FMOV  D23, X29
    FMOV  V23.D[1], X3
    FMOV  D24, X29
    FMOV  V24.D[1], X3
    FMOV  D25, X18
    FMOV  V25.D[1], X20
    FMOV  D26, X10
    FMOV  V26.D[1], X23
    FMOV  D27, X10
    FMOV  V27.D[1], X20
    FMOV  D28, X29
    FMOV  V28.D[1], X15
    FMOV  D29, X16
    FMOV  V29.D[1], X20
    FMOV  D30, X9
    FMOV  V30.D[1], X26
    FMOV  D31, X27
    FMOV  V31.D[1], X9
    MOVZ  X15, #0xa, LSL #0
TaishanSimdElementArithemticP01_label_978:
    SMAXV  S0, V19.4S
    SMINV  B14, V22.8B
    ADDV  H30, V23.4H
    UADDLV  H0, V29.8B
    SMAXV  H14, V17.4H
    ADDV  H20, V5.8H
    SMINV  S24, V13.4S
    UMINV  B26, V28.8B
    SMAXV  H25, V0.8H
    UMAXV  H19, V28.8H
    SMINV  S29, V6.4S
    UMAXV  H31, V8.8H
    UMAXV  H3, V15.8H
    UMAXV  H8, V23.8H
    UMINV  B10, V27.16B
    FMAXV  S24, V26.4S
    ADDV  B19, V14.16B
    SADDLV  D5, V19.4S
    ADDV  H30, V5.8H
    ADDV  B17, V0.8B
    UMINV  H13, V25.8H
    UMINV  B4, V10.8B
    SADDLV  D30, V3.4S
    ADDV  B24, V2.8B
    FMAXV  S27, V27.4S
    SMAXV  H4, V27.4H
    UMAXV  S16, V19.4S
    SADDLV  D24, V14.4S
    UMINV  S22, V16.4S
    UADDLV  H26, V18.8B
    FMAXV  S30, V28.4S
    SMAXV  S28, V14.4S
    UADDLV  H5, V11.16B
    UMAXV  B10, V22.8B
    SMINV  S13, V3.4S
    UMAXV  H23, V22.8H
    SMAXV  B18, V28.8B
    SADDLV  D7, V17.4S
    UMAXV  B10, V9.16B
    SMAXV  B15, V10.8B
    SMAXV  H1, V28.8H
    FMINNMV  S26, V8.4S
    FMINNMV  S22, V20.4S
    UADDLV  S30, V3.8H
    UMAXV  B31, V2.8B
    UADDLV  H7, V6.8B
    UADDLV  H23, V26.16B
    SMINV  B21, V27.16B
    UADDLV  H18, V14.16B
    SMINV  S10, V11.4S
    ADDV  H5, V17.4H
    UMAXV  H4, V14.8H
    UMAXV  S27, V12.4S
    SMINV  H10, V11.8H
    UMAXV  B8, V19.8B
    UADDLV  D13, V29.4S
    UADDLV  S22, V3.8H
    UMINV  S20, V22.4S
    FMINNMV  S0, V0.4S
    FMAXV  S12, V31.4S
    SADDLV  H9, V3.8B
    UADDLV  D7, V3.4S
    FMINNMV  S27, V29.4S
    UMAXV  H17, V30.4H
    SMAXV  H9, V23.4H
    SADDLV  D12, V27.4S
    FMINNMV  S27, V21.4S
    SMINV  S6, V2.4S
    FMAXNMV  S25, V28.4S
    ADDV  S6, V3.4S
    FMAXV  S16, V5.4S
    ADDV  H22, V14.4H
    SMINV  S20, V19.4S
    FMINNMV  S11, V8.4S
    UMAXV  S21, V26.4S
    ADDV  B21, V25.16B
    ADDV  S1, V31.4S
    UADDLV  S23, V2.4H
    UMINV  S9, V29.4S
    FMAXNMV  S19, V14.4S
    UADDLV  H2, V31.8B
    UMAXV  H29, V12.8H
    SMINV  S26, V12.4S
    ADDV  B16, V8.8B
    UADDLV  D3, V6.4S
    SADDLV  D7, V23.4S
    ADDV  H10, V11.4H
    UMINV  S23, V5.4S
    SMINV  H23, V26.4H
    ADDV  S29, V22.4S
    UMAXV  B5, V24.16B
    SMINV  S14, V5.4S
    SMAXV  S27, V26.4S
    FMAXV  S17, V25.4S
    SMINV  B12, V27.16B
    ADDV  H20, V28.4H
    UADDLV  D8, V8.4S
    ADDV  H26, V18.4H
    UMINV  S3, V26.4S
    FMAXNMV  S11, V2.4S
    FMINNMV  S5, V1.4S
    SMAXV  H28, V31.8H
    UMINV  B14, V9.16B
    UMINV  S23, V18.4S
    SADDLV  D18, V0.4S
    UMINV  B18, V0.8B
    ADDV  B2, V21.16B
    FMAXV  S28, V0.4S
    SADDLV  D28, V27.4S
    UMAXV  B15, V25.8B
    SADDLV  S30, V26.8H
    FMAXNMV  S5, V31.4S
    UADDLV  D16, V21.4S
    SADDLV  S21, V12.8H
    SADDLV  D9, V19.4S
    SADDLV  H14, V12.16B
    UMINV  H29, V10.8H
    UMAXV  H0, V23.8H
    SMINV  S1, V1.4S
    UMAXV  B13, V3.16B
    UMINV  B4, V12.8B
    UMAXV  H9, V4.4H
    UMAXV  B15, V30.8B
    ADDV  S5, V3.4S
    UMINV  H4, V5.4H
    SADDLV  D15, V25.4S
    UADDLV  H27, V29.16B
    SMAXV  H11, V12.4H
    SADDLV  D9, V13.4S
    SMINV  B12, V30.16B
    UMINV  B18, V21.8B
    UADDLV  D1, V2.4S
    UMAXV  S31, V4.4S
    FMAXV  S10, V6.4S
    SMAXV  B4, V9.16B
    FMINV  S4, V2.4S
    SADDLV  H10, V23.8B
    ADDV  H0, V21.4H
    UMAXV  H9, V31.8H
    UADDLV  S3, V8.8H
    SMAXV  B8, V30.8B
    ADDV  B13, V15.8B
    SADDLV  D31, V14.4S
    SMAXV  B29, V4.16B
    SMINV  B25, V25.8B
    UMAXV  S30, V6.4S
    SMINV  B21, V12.16B
    UMINV  H31, V27.4H
    SMINV  S30, V0.4S
    UMAXV  H18, V9.4H
    UADDLV  H15, V27.8B
    FMAXV  S20, V30.4S
    SADDLV  D14, V7.4S
    SMAXV  B3, V14.8B
    FMINNMV  S12, V29.4S
    FMAXV  S14, V29.4S
    SMAXV  H28, V27.4H
    ADDV  S17, V0.4S
    SMINV  H9, V4.4H
    SADDLV  H22, V4.16B
    FMAXNMV  S0, V26.4S
    SMINV  H9, V17.4H
    SMAXV  S7, V5.4S
    SMAXV  B17, V16.16B
    UMAXV  H8, V18.8H
    SADDLV  S3, V2.8H
    SMAXV  S19, V17.4S
    UADDLV  D9, V9.4S
    UMAXV  H4, V0.8H
    SADDLV  H5, V13.16B
    SMINV  B25, V20.16B
    FMAXV  S26, V12.4S
    ADDV  H31, V5.8H
    FMINNMV  S27, V25.4S
    SADDLV  D7, V21.4S
    SMAXV  H0, V0.8H
    UMINV  B12, V5.8B
    SMAXV  S0, V9.4S
    FMINV  S22, V25.4S
    SMINV  B16, V31.16B
    ADDV  H8, V5.8H
    UMAXV  H19, V9.8H
    UMAXV  H16, V2.4H
    UADDLV  D8, V6.4S
    UMINV  B13, V17.8B
    ADDV  B20, V19.16B
    SMINV  H26, V17.4H
    UADDLV  D28, V20.4S
    ADDV  H3, V9.4H
    ADDV  S3, V10.4S
    UMINV  S27, V31.4S
    UMAXV  B22, V30.16B
    ADDV  H12, V3.4H
    SMINV  B2, V9.16B
    UADDLV  S18, V16.4H
    SADDLV  H5, V18.8B
    UADDLV  S11, V31.8H
    SADDLV  S0, V27.8H
    ADDV  H23, V22.4H
    FMAXV  S5, V5.4S
    SUBS  X15, X15, #0x1
    B.NE  TaishanSimdElementArithemticP01_label_978
    MOVZ  X7, #0x0, LSL #0
    SUB  X13, X7, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X12, X24, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X6, X23, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X8, X24, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X26, X2, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X15
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X17
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X20, X13, X25
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X29
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, D2
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X27, X25, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X20, D3
    MOVZ  X25, #0x0, LSL #0
    SUB  X27, X25, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, D4
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, V5.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, D5
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X17, D6
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, D7
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, D8
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, D9
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X4, X20, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, D10
    MOVZ  X20, #0x0, LSL #0
    SUB  X4, X20, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X7, X5, X12
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D11
    MOVZ  X5, #0x0, LSL #0
    SUB  X7, X5, X12
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, D12
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, D13
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, V14.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, D14
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, D15
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, D16
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, D17
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, D18
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, D20
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D21
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, D22
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, D23
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X29
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, D24
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X29
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, D25
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D26
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, D27
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, D28
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, D29
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
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
    FMOV  D0, X10
    FMOV  V0.D[1], X4
    FMOV  D1, X21
    FMOV  V1.D[1], X27
    FMOV  D2, X6
    FMOV  V2.D[1], X26
    FMOV  D3, X7
    FMOV  V3.D[1], X28
    FMOV  D4, X7
    FMOV  V4.D[1], X10
    FMOV  D5, X15
    FMOV  V5.D[1], X29
    FMOV  D6, X16
    FMOV  V6.D[1], X25
    FMOV  D7, X24
    FMOV  V7.D[1], X3
    FMOV  D8, X12
    FMOV  V8.D[1], X15
    FMOV  D9, X28
    FMOV  V9.D[1], X9
    FMOV  D10, X5
    FMOV  V10.D[1], X8
    FMOV  D11, X27
    FMOV  V11.D[1], X15
    FMOV  D12, X8
    FMOV  V12.D[1], X9
    FMOV  D13, X16
    FMOV  V13.D[1], X29
    FMOV  D14, X20
    FMOV  V14.D[1], X16
    FMOV  D15, X14
    FMOV  V15.D[1], X3
    FMOV  D16, X2
    FMOV  V16.D[1], X2
    FMOV  D17, X16
    FMOV  V17.D[1], X15
    FMOV  D18, X13
    FMOV  V18.D[1], X16
    FMOV  D19, X8
    FMOV  V19.D[1], X11
    FMOV  D20, X27
    FMOV  V20.D[1], X11
    FMOV  D21, X4
    FMOV  V21.D[1], X3
    FMOV  D22, X16
    FMOV  V22.D[1], X26
    FMOV  D23, X21
    FMOV  V23.D[1], X28
    FMOV  D24, X7
    FMOV  V24.D[1], X16
    FMOV  D25, X17
    FMOV  V25.D[1], X26
    FMOV  D26, X28
    FMOV  V26.D[1], X3
    FMOV  D27, X11
    FMOV  V27.D[1], X21
    FMOV  D28, X28
    FMOV  V28.D[1], X4
    FMOV  D29, X7
    FMOV  V29.D[1], X3
    FMOV  D30, X28
    FMOV  V30.D[1], X5
    FMOV  D31, X3
    FMOV  V31.D[1], X10
    MOVZ  X7, #0xf, LSL #0
TaishanSimdElementArithemticP01_label_1051:
    ADDV  S25, V28.4S
    SMINV  B24, V21.16B
    UMAXV  B29, V2.8B
    SADDLV  D19, V29.4S
    UMINV  S0, V26.4S
    FMAXV  S14, V20.4S
    ADDV  B16, V4.16B
    ADDV  B24, V25.16B
    SMINV  B27, V16.8B
    UADDLV  S3, V16.4H
    SMAXV  H23, V15.4H
    SADDLV  S20, V14.4H
    UMINV  S5, V9.4S
    SADDLV  H26, V31.8B
    FMAXV  S14, V18.4S
    UMAXV  H7, V4.4H
    SMINV  S19, V30.4S
    SADDLV  S22, V19.4H
    UMINV  H24, V10.4H
    SMINV  B30, V7.8B
    SMINV  H22, V24.4H
    FMAXNMV  S26, V16.4S
    FMAXNMV  S6, V10.4S
    UADDLV  S17, V23.4H
    UADDLV  D17, V31.4S
    SADDLV  D19, V13.4S
    SMAXV  S24, V29.4S
    UADDLV  D9, V15.4S
    ADDV  B20, V10.8B
    UADDLV  D7, V17.4S
    SMAXV  H1, V6.8H
    SMINV  S9, V11.4S
    SMINV  S18, V24.4S
    FMINNMV  S10, V15.4S
    ADDV  B3, V30.8B
    UMAXV  H30, V4.8H
    FMINNMV  S9, V25.4S
    UMAXV  H20, V31.8H
    SADDLV  S12, V22.4H
    FMINV  S13, V16.4S
    SMINV  B31, V14.16B
    SADDLV  S3, V26.4H
    UADDLV  D15, V28.4S
    ADDV  S26, V9.4S
    FMINNMV  S8, V2.4S
    UMINV  S4, V22.4S
    FMAXV  S25, V29.4S
    SMAXV  H20, V6.8H
    SMAXV  B24, V7.8B
    UMAXV  S7, V11.4S
    FMAXNMV  S17, V17.4S
    UADDLV  S15, V19.4H
    UMINV  S30, V20.4S
    FMINNMV  S13, V22.4S
    SADDLV  S6, V22.8H
    SADDLV  D10, V23.4S
    FMINNMV  S9, V10.4S
    FMAXNMV  S18, V28.4S
    ADDV  H11, V11.4H
    SMINV  S2, V23.4S
    SADDLV  S19, V3.8H
    SMAXV  H23, V13.4H
    UADDLV  D21, V9.4S
    SMINV  B16, V7.8B
    UMAXV  B19, V12.16B
    ADDV  H28, V0.8H
    ADDV  H22, V5.4H
    SADDLV  H22, V3.8B
    UMINV  H15, V30.4H
    ADDV  S21, V2.4S
    UMAXV  H8, V20.8H
    ADDV  B12, V28.8B
    UADDLV  D23, V2.4S
    ADDV  S19, V24.4S
    UMAXV  S23, V10.4S
    UADDLV  S16, V18.4H
    SMAXV  H30, V1.4H
    SADDLV  S6, V26.4H
    UMINV  S21, V28.4S
    ADDV  H15, V8.8H
    SMAXV  H0, V24.4H
    FMINV  S15, V18.4S
    SMINV  B5, V28.16B
    SMAXV  S2, V8.4S
    ADDV  S7, V29.4S
    ADDV  H17, V10.8H
    SMINV  B28, V21.8B
    UADDLV  H7, V11.16B
    SADDLV  S7, V24.4H
    SMAXV  B17, V17.16B
    UMAXV  H10, V10.4H
    UMAXV  H8, V28.4H
    FMINV  S16, V17.4S
    SMAXV  B0, V29.16B
    UMINV  B12, V5.16B
    FMINNMV  S8, V30.4S
    UMINV  H16, V23.4H
    SADDLV  D14, V21.4S
    UADDLV  S27, V21.4H
    UMINV  H6, V4.8H
    SMINV  H25, V23.8H
    UMINV  H10, V5.4H
    UMINV  B0, V12.16B
    UMAXV  S2, V5.4S
    UMAXV  S0, V8.4S
    SADDLV  H26, V28.8B
    SMINV  H11, V24.8H
    SMINV  S21, V18.4S
    FMAXNMV  S17, V6.4S
    SADDLV  D23, V16.4S
    FMAXV  S0, V5.4S
    UMAXV  S14, V29.4S
    SADDLV  S17, V17.8H
    SADDLV  H20, V30.16B
    UMINV  B11, V4.8B
    ADDV  S14, V30.4S
    UADDLV  S4, V22.4H
    FMAXNMV  S29, V16.4S
    SMINV  B30, V26.8B
    SMAXV  S7, V9.4S
    UADDLV  D30, V21.4S
    FMINV  S8, V13.4S
    SADDLV  S9, V12.8H
    UMINV  H23, V31.8H
    SMAXV  S12, V12.4S
    FMAXV  S3, V1.4S
    SMAXV  B16, V1.8B
    FMINV  S7, V9.4S
    ADDV  H13, V13.8H
    UMINV  B30, V13.8B
    UADDLV  H2, V4.16B
    ADDV  H24, V10.8H
    SMINV  S7, V5.4S
    UMAXV  B27, V6.8B
    UADDLV  H7, V22.8B
    SMINV  B5, V10.16B
    ADDV  B20, V23.16B
    ADDV  H6, V2.8H
    FMAXNMV  S26, V10.4S
    SMAXV  H19, V27.8H
    UADDLV  H1, V24.16B
    ADDV  H24, V3.8H
    UMAXV  S9, V8.4S
    FMAXV  S28, V31.4S
    SADDLV  D6, V24.4S
    UMAXV  S4, V20.4S
    UMINV  B20, V26.8B
    FMAXV  S7, V11.4S
    SADDLV  S22, V28.4H
    SMAXV  S5, V26.4S
    SADDLV  S22, V16.4H
    FMINNMV  S4, V28.4S
    SMAXV  S5, V1.4S
    SMINV  B6, V28.16B
    SMINV  H13, V28.4H
    SMAXV  H1, V17.4H
    UADDLV  S5, V1.4H
    ADDV  S2, V9.4S
    SADDLV  H11, V20.16B
    FMINNMV  S8, V5.4S
    SADDLV  H31, V24.16B
    UMINV  S31, V1.4S
    UADDLV  S6, V8.4H
    FMAXV  S18, V8.4S
    UADDLV  S16, V29.4H
    UMAXV  B15, V19.16B
    UMAXV  B26, V21.16B
    FMAXNMV  S14, V3.4S
    UMAXV  H12, V31.4H
    UADDLV  H17, V10.8B
    SADDLV  D8, V0.4S
    UADDLV  H0, V29.16B
    UMINV  S28, V26.4S
    UMAXV  H4, V17.8H
    UADDLV  D20, V15.4S
    SMINV  S20, V1.4S
    SADDLV  H21, V11.16B
    SADDLV  D25, V6.4S
    UMINV  S19, V15.4S
    SADDLV  S16, V28.8H
    UMINV  H29, V19.8H
    SMAXV  B19, V14.8B
    UMINV  B9, V25.8B
    FMAXV  S16, V2.4S
    UMAXV  H22, V4.8H
    UMAXV  H30, V26.4H
    UMINV  B13, V2.16B
    SMINV  H16, V11.4H
    UMINV  B29, V14.8B
    ADDV  S6, V18.4S
    ADDV  B1, V20.8B
    UMINV  S7, V22.4S
    SMINV  S6, V21.4S
    SMAXV  B19, V23.8B
    SMINV  H11, V9.4H
    SMINV  B15, V26.16B
    ADDV  S9, V15.4S
    SMAXV  H10, V9.8H
    SMINV  B23, V20.16B
    SMAXV  H16, V18.4H
    SUBS  X7, X7, #0x1
    B.NE  TaishanSimdElementArithemticP01_label_1051
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X24, X4, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X11, X3, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X9, X13, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X9, X23, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X3, X14, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X5, X22, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X29, X23, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X24, X9, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X8, X24, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X6, X22, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X13, X11, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X14, X23, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X8, X25, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X2, X29, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X17, X10, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X21, X9, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X25, X17, X25
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X27, X3, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X9, X15, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X17, D2
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, D3
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, V4.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, D4
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, D5
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, D6
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, V7.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, D7
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, D8
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X27, X25, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, D9
    MOVZ  X25, #0x0, LSL #0
    SUB  X27, X25, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, D11
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, D12
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, D13
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, D14
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, D15
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D16
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X23, X21, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, D17
    MOVZ  X21, #0x0, LSL #0
    SUB  X23, X21, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X29, X28, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, D18
    MOVZ  X28, #0x0, LSL #0
    SUB  X29, X28, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, D20
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, D21
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X23, X17, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, D22
    MOVZ  X17, #0x0, LSL #0
    SUB  X23, X17, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, V23.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, D23
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D24
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, V25.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, D25
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, D26
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X4, X6, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, D27
    MOVZ  X6, #0x0, LSL #0
    SUB  X4, X6, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, D28
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X14, X11, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, D29
    MOVZ  X11, #0x0, LSL #0
    SUB  X14, X11, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0x161c, LSL #0
    MOVK  X2, #0xe7ed, LSL #16
    MOVK  X2, #0x45fc, LSL #32
    MOVK  X2, #0x86e, LSL #48
    MOVZ  X3, #0xe302, LSL #0
    MOVK  X3, #0x9dcb, LSL #16
    MOVK  X3, #0x70d5, LSL #32
    MOVK  X3, #0x7909, LSL #48
    MOVZ  X4, #0x35d, LSL #0
    MOVK  X4, #0x8ed3, LSL #16
    MOVK  X4, #0x47a9, LSL #32
    MOVK  X4, #0x4bc3, LSL #48
    MOVZ  X5, #0x3317, LSL #0
    MOVK  X5, #0x6147, LSL #16
    MOVK  X5, #0xae4d, LSL #32
    MOVK  X5, #0xf202, LSL #48
    MOVZ  X6, #0xfaf4, LSL #0
    MOVK  X6, #0x5f1f, LSL #16
    MOVK  X6, #0x5e4, LSL #32
    MOVK  X6, #0x51a3, LSL #48
    MOVZ  X7, #0x4824, LSL #0
    MOVK  X7, #0x842, LSL #16
    MOVK  X7, #0x3f7a, LSL #32
    MOVK  X7, #0x2a6a, LSL #48
    MOVZ  X8, #0x6dbc, LSL #0
    MOVK  X8, #0x6695, LSL #16
    MOVK  X8, #0x26a1, LSL #32
    MOVK  X8, #0x15b5, LSL #48
    MOVZ  X9, #0xb2eb, LSL #0
    MOVK  X9, #0x39db, LSL #16
    MOVK  X9, #0x3b30, LSL #32
    MOVK  X9, #0xf12c, LSL #48
    MOVZ  X10, #0xb4fb, LSL #0
    MOVK  X10, #0x492f, LSL #16
    MOVK  X10, #0xc236, LSL #32
    MOVK  X10, #0xb805, LSL #48
    MOVZ  X11, #0x43ab, LSL #0
    MOVK  X11, #0x44bd, LSL #16
    MOVK  X11, #0xed1a, LSL #32
    MOVK  X11, #0x68d4, LSL #48
    MOVZ  X12, #0xc145, LSL #0
    MOVK  X12, #0x86d9, LSL #16
    MOVK  X12, #0x5e51, LSL #32
    MOVK  X12, #0xf14b, LSL #48
    MOVZ  X13, #0x35ee, LSL #0
    MOVK  X13, #0x1d36, LSL #16
    MOVK  X13, #0x9eff, LSL #32
    MOVK  X13, #0xb9a4, LSL #48
    MOVZ  X14, #0xb057, LSL #0
    MOVK  X14, #0xf9b1, LSL #16
    MOVK  X14, #0x7d4d, LSL #32
    MOVK  X14, #0x87f9, LSL #48
    MOVZ  X15, #0xa5c2, LSL #0
    MOVK  X15, #0x6c1c, LSL #16
    MOVK  X15, #0xa25b, LSL #32
    MOVK  X15, #0xb959, LSL #48
    MOVZ  X16, #0x4b45, LSL #0
    MOVK  X16, #0x783d, LSL #16
    MOVK  X16, #0x54c3, LSL #32
    MOVK  X16, #0x51d6, LSL #48
    MOVZ  X17, #0x2b41, LSL #0
    MOVK  X17, #0xa86f, LSL #16
    MOVK  X17, #0x3b2e, LSL #32
    MOVK  X17, #0x20a5, LSL #48
    MOVZ  X18, #0x35e3, LSL #0
    MOVK  X18, #0xb359, LSL #16
    MOVK  X18, #0x1953, LSL #32
    MOVK  X18, #0x7827, LSL #48
    MOVZ  X20, #0xd4f9, LSL #0
    MOVK  X20, #0x2429, LSL #16
    MOVK  X20, #0x1de7, LSL #32
    MOVK  X20, #0xbb70, LSL #48
    MOVZ  X21, #0xa7d9, LSL #0
    MOVK  X21, #0x649f, LSL #16
    MOVK  X21, #0xe422, LSL #32
    MOVK  X21, #0xa617, LSL #48
    MOVZ  X22, #0x7a24, LSL #0
    MOVK  X22, #0xbc48, LSL #16
    MOVK  X22, #0x7b46, LSL #32
    MOVK  X22, #0x8197, LSL #48
    MOVZ  X23, #0xe87c, LSL #0
    MOVK  X23, #0xb7df, LSL #16
    MOVK  X23, #0xacb7, LSL #32
    MOVK  X23, #0x8d12, LSL #48
    MOVZ  X24, #0xf0b1, LSL #0
    MOVK  X24, #0xac44, LSL #16
    MOVK  X24, #0x27ca, LSL #32
    MOVK  X24, #0x1ce6, LSL #48
    MOVZ  X25, #0xa87, LSL #0
    MOVK  X25, #0xccaf, LSL #16
    MOVK  X25, #0x827b, LSL #32
    MOVK  X25, #0x48a1, LSL #48
    MOVZ  X26, #0x7bb7, LSL #0
    MOVK  X26, #0x5247, LSL #16
    MOVK  X26, #0xf2a6, LSL #32
    MOVK  X26, #0x5d04, LSL #48
    MOVZ  X27, #0x1fbd, LSL #0
    MOVK  X27, #0x3bdf, LSL #16
    MOVK  X27, #0xf333, LSL #32
    MOVK  X27, #0x4288, LSL #48
    MOVZ  X28, #0x95ac, LSL #0
    MOVK  X28, #0x9a52, LSL #16
    MOVK  X28, #0x4c00, LSL #32
    MOVK  X28, #0x6a29, LSL #48
    MOVZ  X29, #0x1b41, LSL #0
    MOVK  X29, #0x8272, LSL #16
    MOVK  X29, #0x86b9, LSL #32
    MOVK  X29, #0x7ce3, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X4
    FMOV  D1, X13
    FMOV  V1.D[1], X14
    FMOV  D2, X21
    FMOV  V2.D[1], X26
    FMOV  D3, X11
    FMOV  V3.D[1], X27
    FMOV  D4, X4
    FMOV  V4.D[1], X22
    FMOV  D5, X17
    FMOV  V5.D[1], X28
    FMOV  D6, X8
    FMOV  V6.D[1], X21
    FMOV  D7, X4
    FMOV  V7.D[1], X16
    FMOV  D8, X18
    FMOV  V8.D[1], X25
    FMOV  D9, X3
    FMOV  V9.D[1], X29
    FMOV  D10, X20
    FMOV  V10.D[1], X8
    FMOV  D11, X9
    FMOV  V11.D[1], X29
    FMOV  D12, X22
    FMOV  V12.D[1], X21
    FMOV  D13, X27
    FMOV  V13.D[1], X11
    FMOV  D14, X11
    FMOV  V14.D[1], X18
    FMOV  D15, X23
    FMOV  V15.D[1], X18
    FMOV  D16, X5
    FMOV  V16.D[1], X16
    FMOV  D17, X18
    FMOV  V17.D[1], X6
    FMOV  D18, X10
    FMOV  V18.D[1], X3
    FMOV  D19, X23
    FMOV  V19.D[1], X29
    FMOV  D20, X5
    FMOV  V20.D[1], X6
    FMOV  D21, X11
    FMOV  V21.D[1], X27
    FMOV  D22, X21
    FMOV  V22.D[1], X17
    FMOV  D23, X18
    FMOV  V23.D[1], X21
    FMOV  D24, X20
    FMOV  V24.D[1], X23
    FMOV  D25, X17
    FMOV  V25.D[1], X15
    FMOV  D26, X3
    FMOV  V26.D[1], X4
    FMOV  D27, X18
    FMOV  V27.D[1], X10
    FMOV  D28, X18
    FMOV  V28.D[1], X29
    FMOV  D29, X17
    FMOV  V29.D[1], X18
    FMOV  D30, X5
    FMOV  V30.D[1], X13
    FMOV  D31, X3
    FMOV  V31.D[1], X29
    MOVZ  X3, #0xa, LSL #0
TaishanSimdElementArithemticP01_label_1128:
    UADDLV  D31, V21.4S
    SMINV  S29, V18.4S
    SADDLV  D24, V19.4S
    SMAXV  S4, V8.4S
    FMINNMV  S30, V29.4S
    SMINV  S12, V22.4S
    UADDLV  S0, V5.4H
    SMAXV  S8, V22.4S
    UADDLV  S31, V7.8H
    SMAXV  S30, V3.4S
    SMAXV  H29, V17.8H
    UADDLV  D1, V1.4S
    UADDLV  D18, V29.4S
    UMAXV  B15, V18.16B
    SMINV  H30, V2.4H
    FMAXV  S14, V8.4S
    UMAXV  H5, V13.8H
    UMAXV  B8, V29.8B
    ADDV  B10, V7.8B
    ADDV  B8, V16.8B
    SMAXV  H8, V19.8H
    UMINV  S6, V26.4S
    UMAXV  S27, V14.4S
    FMAXNMV  S31, V11.4S
    UMINV  H19, V4.4H
    SMINV  S22, V8.4S
    SMINV  S29, V30.4S
    FMINNMV  S6, V31.4S
    ADDV  S8, V11.4S
    SADDLV  D5, V23.4S
    SADDLV  S18, V19.8H
    UADDLV  H25, V10.16B
    UADDLV  D5, V9.4S
    ADDV  H14, V11.8H
    UMINV  H17, V0.4H
    UMAXV  S27, V8.4S
    FMINV  S22, V22.4S
    UMINV  H26, V6.4H
    UADDLV  H5, V15.16B
    SADDLV  H11, V18.16B
    ADDV  H29, V3.8H
    SADDLV  S29, V30.8H
    UMAXV  B24, V0.8B
    SMINV  H24, V5.8H
    SMAXV  B3, V3.8B
    FMAXNMV  S30, V18.4S
    SMINV  B18, V6.16B
    UADDLV  S11, V7.8H
    FMAXNMV  S10, V30.4S
    SADDLV  H22, V27.8B
    FMINV  S17, V28.4S
    ADDV  H9, V14.4H
    UADDLV  H26, V29.16B
    UMAXV  S20, V17.4S
    SMINV  S24, V0.4S
    UMINV  H18, V15.8H
    ADDV  H14, V30.4H
    ADDV  H0, V14.4H
    SMAXV  S0, V9.4S
    UMINV  S26, V6.4S
    UMAXV  H17, V17.4H
    SMINV  S7, V9.4S
    ADDV  S9, V27.4S
    UMINV  H17, V10.4H
    FMAXNMV  S10, V19.4S
    SMAXV  B10, V13.8B
    SMINV  H27, V31.8H
    SADDLV  D19, V5.4S
    UMINV  S26, V27.4S
    UADDLV  H11, V17.16B
    UADDLV  S17, V9.4H
    FMAXNMV  S27, V9.4S
    UMAXV  S18, V23.4S
    FMINV  S19, V31.4S
    SADDLV  H11, V3.8B
    UMINV  H24, V0.4H
    SMINV  H17, V20.4H
    ADDV  S0, V23.4S
    ADDV  B15, V31.8B
    UADDLV  S28, V26.4H
    SMINV  B9, V4.16B
    ADDV  H26, V4.8H
    FMAXV  S26, V4.4S
    FMAXNMV  S24, V2.4S
    FMINNMV  S4, V20.4S
    SMAXV  S6, V4.4S
    UMINV  H29, V15.4H
    UMINV  B5, V3.16B
TaishanSimdElementArithemticP01_label_777:
    UMAXV  S29, V3.4S
    SMINV  S28, V12.4S
    SMAXV  H20, V6.8H
    UADDLV  D12, V21.4S
    UMAXV  S29, V22.4S
    FMINNMV  S23, V27.4S
    UMAXV  H4, V9.8H
    FMINNMV  S23, V11.4S
    UADDLV  H7, V26.8B
    SMAXV  H25, V29.4H
    UADDLV  D15, V18.4S
    SADDLV  S19, V2.8H
    UADDLV  S31, V17.4H
    FMAXV  S5, V4.4S
    ADDV  B7, V12.8B
    SADDLV  H7, V24.8B
    UMINV  H21, V9.4H
    UMINV  B23, V4.8B
    UADDLV  S18, V20.8H
    UMINV  H4, V5.4H
    UMINV  B18, V18.8B
    SMINV  H5, V15.4H
    UADDLV  H2, V30.8B
    SMINV  S19, V14.4S
    SMAXV  H4, V12.8H
    FMINV  S1, V9.4S
    FMAXV  S14, V2.4S
    SMAXV  B7, V24.8B
    UMAXV  H20, V22.4H
    SMAXV  H15, V20.4H
    ADDV  B24, V6.8B
    SMINV  H26, V13.4H
    SMAXV  B23, V27.8B
    UMAXV  H21, V22.8H
    UMINV  S19, V9.4S
    SADDLV  H12, V1.16B
    SMAXV  B17, V24.8B
    SMINV  S0, V16.4S
    UMINV  S19, V13.4S
    UMINV  H3, V4.8H
    SMAXV  H8, V20.8H
    SADDLV  H29, V17.16B
    UMINV  S4, V3.4S
    ADDV  S3, V4.4S
    SMINV  B7, V18.16B
    SMAXV  S31, V20.4S
    FMINV  S21, V12.4S
    UADDLV  D0, V23.4S
    UMAXV  B8, V9.16B
    SMAXV  S25, V17.4S
    SMAXV  H15, V16.8H
    UMINV  S17, V23.4S
    SMAXV  S11, V13.4S
    SMINV  S20, V25.4S
    UMAXV  H29, V24.8H
    ADDV  H25, V12.8H
    ADDV  S2, V23.4S
    SADDLV  H18, V18.8B
    SADDLV  H26, V13.16B
    SMAXV  H9, V20.4H
    FMAXNMV  S12, V23.4S
    SMAXV  B5, V10.16B
    SMINV  H22, V7.4H
    FMAXV  S18, V5.4S
    SADDLV  H27, V11.8B
    FMAXV  S18, V16.4S
    UMINV  H10, V7.4H
    SADDLV  S4, V7.4H
    UMINV  H30, V12.8H
    UMAXV  S14, V14.4S
    UADDLV  S15, V27.4H
    ADDV  S0, V6.4S
    SMAXV  H29, V20.8H
    SMAXV  B5, V20.16B
    UMINV  B13, V31.8B
    UMAXV  H24, V1.4H
    UMAXV  B14, V0.16B
    UMAXV  H8, V7.4H
    ADDV  H29, V23.4H
    UADDLV  S18, V5.4H
    SMAXV  H29, V20.4H
    ADDV  S22, V18.4S
    FMAXV  S17, V2.4S
    FMAXNMV  S11, V9.4S
    SMINV  B17, V27.16B
    UADDLV  D30, V24.4S
    SADDLV  D0, V13.4S
    SMAXV  B20, V7.16B
    UADDLV  D10, V3.4S
    ADDV  B15, V14.16B
    SADDLV  D14, V14.4S
    SADDLV  H2, V25.16B
    ADDV  H23, V11.4H
    SMAXV  S11, V30.4S
    UMAXV  S13, V3.4S
    UMAXV  S17, V11.4S
    SMINV  H30, V15.4H
    FMAXNMV  S31, V10.4S
    UMAXV  B25, V30.16B
    SMINV  B27, V4.8B
    SMINV  S26, V5.4S
    SMINV  H30, V4.4H
    SMAXV  B23, V11.16B
    UADDLV  S23, V8.4H
    SMINV  H3, V14.4H
    FMINNMV  S30, V14.4S
    UADDLV  H29, V10.8B
    UMINV  S26, V8.4S
    UMAXV  H8, V22.4H
    SMINV  S4, V8.4S
    UMINV  S9, V20.4S
    UMINV  H1, V0.8H
    SUBS  X3, X3, #0x1
    B.NE  TaishanSimdElementArithemticP01_label_1128
    MOVZ  X23, #0x161c, LSL #0
    MOVK  X23, #0xe7ed, LSL #16
    MOVK  X23, #0x45fc, LSL #32
    MOVK  X23, #0x86e, LSL #48
    SUB  X2, X23, X2
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X11, X24, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X4, #0x35d, LSL #0
    MOVK  X4, #0x8ed3, LSL #16
    MOVK  X4, #0x47a9, LSL #32
    MOVK  X4, #0x4bc3, LSL #48
    SUB  X7, X4, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X17, #0x3317, LSL #0
    MOVK  X17, #0x6147, LSL #16
    MOVK  X17, #0xae4d, LSL #32
    MOVK  X17, #0xf202, LSL #48
    SUB  X24, X17, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X6, #0xfaf4, LSL #0
    MOVK  X6, #0x5f1f, LSL #16
    MOVK  X6, #0x5e4, LSL #32
    MOVK  X6, #0x51a3, LSL #48
    SUB  X25, X6, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X3, X16, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X22, #0x6dbc, LSL #0
    MOVK  X22, #0x6695, LSL #16
    MOVK  X22, #0x26a1, LSL #32
    MOVK  X22, #0x15b5, LSL #48
    SUB  X28, X22, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X20, #0xb2eb, LSL #0
    MOVK  X20, #0x39db, LSL #16
    MOVK  X20, #0x3b30, LSL #32
    MOVK  X20, #0xf12c, LSL #48
    SUB  X22, X20, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X8, #0xb4fb, LSL #0
    MOVK  X8, #0x492f, LSL #16
    MOVK  X8, #0xc236, LSL #32
    MOVK  X8, #0xb805, LSL #48
    SUB  X17, X8, X10
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X16, #0x35ee, LSL #0
    MOVK  X16, #0x1d36, LSL #16
    MOVK  X16, #0x9eff, LSL #32
    MOVK  X16, #0xb9a4, LSL #48
    SUB  X13, X16, X13
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X17, #0xb057, LSL #0
    MOVK  X17, #0xf9b1, LSL #16
    MOVK  X17, #0x7d4d, LSL #32
    MOVK  X17, #0x87f9, LSL #48
    SUB  X29, X17, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X29, #0xa5c2, LSL #0
    MOVK  X29, #0x6c1c, LSL #16
    MOVK  X29, #0xa25b, LSL #32
    MOVK  X29, #0xb959, LSL #48
    SUB  X28, X29, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X20, #0x35ee, LSL #0
    MOVK  X20, #0x1d36, LSL #16
    MOVK  X20, #0x9eff, LSL #32
    MOVK  X20, #0xb9a4, LSL #48
    SUB  X6, X20, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X5, #0xb057, LSL #0
    MOVK  X5, #0xf9b1, LSL #16
    MOVK  X5, #0x7d4d, LSL #32
    MOVK  X5, #0x87f9, LSL #48
    SUB  X14, X5, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X21, #0x35e3, LSL #0
    MOVK  X21, #0xb359, LSL #16
    MOVK  X21, #0x1953, LSL #32
    MOVK  X21, #0x7827, LSL #48
    SUB  X24, X21, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X13, #0x35ee, LSL #0
    MOVK  X13, #0x1d36, LSL #16
    MOVK  X13, #0x9eff, LSL #32
    MOVK  X13, #0xb9a4, LSL #48
    SUB  X14, X13, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0x35e3, LSL #0
    MOVK  X12, #0xb359, LSL #16
    MOVK  X12, #0x1953, LSL #32
    MOVK  X12, #0x7827, LSL #48
    SUB  X24, X12, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X21, X11, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X27, #0x7bb7, LSL #0
    MOVK  X27, #0x5247, LSL #16
    MOVK  X27, #0xf2a6, LSL #32
    MOVK  X27, #0x5d04, LSL #48
    SUB  X17, X27, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X29, #0x7bb7, LSL #0
    MOVK  X29, #0x5247, LSL #16
    MOVK  X29, #0xf2a6, LSL #32
    MOVK  X29, #0x5d04, LSL #48
    SUB  X8, X29, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0x7bb7, LSL #0
    MOVK  X3, #0x5247, LSL #16
    MOVK  X3, #0xf2a6, LSL #32
    MOVK  X3, #0x5d04, LSL #48
    SUB  X5, X3, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, V2.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, D2
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D3
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, D4
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D5
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, D6
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X18
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, D7
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X18
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, D8
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D9
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X14, X15, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, D10
    MOVZ  X15, #0x0, LSL #0
    SUB  X14, X15, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D11
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D12
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, D13
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, D14
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, V15.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, D15
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X21, #0x4b45, LSL #0
    MOVK  X21, #0x783d, LSL #16
    MOVK  X21, #0x54c3, LSL #32
    MOVK  X21, #0x51d6, LSL #48
    SUB  X27, X21, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, D16
    MOVZ  X21, #0x3317, LSL #0
    MOVK  X21, #0x6147, LSL #16
    MOVK  X21, #0xae4d, LSL #32
    MOVK  X21, #0xf202, LSL #48
    SUB  X27, X21, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, D17
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, D18
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, D20
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D21
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, D22
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X13, X7, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, D23
    MOVZ  X7, #0x0, LSL #0
    SUB  X13, X7, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D24
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, D25
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X15, X29, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, D26
    MOVZ  X29, #0x0, LSL #0
    SUB  X15, X29, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X29, X26, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, D27
    MOVZ  X26, #0x0, LSL #0
    SUB  X29, X26, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, D28
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, D29
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
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
    FMOV  D0, X10
    FMOV  V0.D[1], X12
    FMOV  D1, X6
    FMOV  V1.D[1], X27
    FMOV  D2, X24
    FMOV  V2.D[1], X13
    FMOV  D3, X18
    FMOV  V3.D[1], X3
    FMOV  D4, X17
    FMOV  V4.D[1], X28
    FMOV  D5, X24
    FMOV  V5.D[1], X15
    FMOV  D6, X4
    FMOV  V6.D[1], X4
TaishanSimdElementArithemticP01_label_785:
    FMOV  D7, X9
    FMOV  V7.D[1], X6
    FMOV  D8, X10
    FMOV  V8.D[1], X13
    FMOV  D9, X16
    FMOV  V9.D[1], X23
    FMOV  D10, X28
    FMOV  V10.D[1], X27
    FMOV  D11, X23
    FMOV  V11.D[1], X3
    FMOV  D12, X2
    FMOV  V12.D[1], X23
    FMOV  D13, X25
    FMOV  V13.D[1], X14
    FMOV  D14, X17
    FMOV  V14.D[1], X17
    FMOV  D15, X26
    FMOV  V15.D[1], X26
    FMOV  D16, X14
    FMOV  V16.D[1], X9
    FMOV  D17, X21
    FMOV  V17.D[1], X22
    FMOV  D18, X16
    FMOV  V18.D[1], X7
    FMOV  D19, X22
    FMOV  V19.D[1], X16
    FMOV  D20, X21
    FMOV  V20.D[1], X13
    FMOV  D21, X5
    FMOV  V21.D[1], X14
    FMOV  D22, X7
    FMOV  V22.D[1], X27
    FMOV  D23, X22
    FMOV  V23.D[1], X7
    FMOV  D24, X6
    FMOV  V24.D[1], X16
    FMOV  D25, X10
    FMOV  V25.D[1], X7
    FMOV  D26, X27
    FMOV  V26.D[1], X4
    FMOV  D27, X13
    FMOV  V27.D[1], X15
    FMOV  D28, X14
    FMOV  V28.D[1], X5
    FMOV  D29, X14
    FMOV  V29.D[1], X25
    FMOV  D30, X17
    FMOV  V30.D[1], X11
    FMOV  D31, X6
    FMOV  V31.D[1], X14
    MOVZ  X16, #0xa, LSL #0
TaishanSimdElementArithemticP01_label_1196:
    UMINV  B13, V4.8B
    UMAXV  H19, V5.8H
    UMINV  S26, V28.4S
    FMAXV  S30, V21.4S
    SMINV  S6, V0.4S
    UMINV  S2, V11.4S
    SMINV  B27, V29.16B
    SMAXV  S22, V25.4S
    SMINV  S19, V6.4S
    FMINNMV  S12, V2.4S
    UMAXV  B23, V30.8B
    FMINNMV  S30, V25.4S
    SMINV  B0, V3.16B
    SMAXV  S15, V24.4S
    UADDLV  S15, V27.4H
    SADDLV  H13, V2.16B
    ADDV  S18, V18.4S
    UADDLV  D24, V8.4S
    UMAXV  B13, V28.8B
    SMINV  H28, V2.8H
    SADDLV  S28, V2.8H
    SADDLV  D26, V13.4S
    UADDLV  D15, V0.4S
    ADDV  B28, V12.8B
    SADDLV  H20, V20.8B
    SMINV  B31, V28.8B
    UMINV  H16, V26.8H
    UMAXV  S28, V28.4S
    UADDLV  S11, V22.4H
    SMAXV  S8, V27.4S
    SADDLV  S18, V2.4H
    UMINV  S0, V20.4S
    UMINV  B15, V8.8B
    UMAXV  B15, V25.16B
    UMINV  B31, V12.8B
    SMAXV  S20, V23.4S
    UADDLV  H1, V7.16B
    SMINV  H19, V25.8H
    UMAXV  H5, V3.4H
    UADDLV  D5, V8.4S
    UMAXV  B15, V18.16B
    FMAXV  S5, V26.4S
    ADDV  S17, V18.4S
    UADDLV  H21, V13.8B
    SADDLV  D6, V27.4S
    UMAXV  S8, V8.4S
    SMAXV  H24, V17.4H
    UMAXV  S21, V31.4S
    UMINV  B22, V22.16B
    SADDLV  D30, V27.4S
    UMAXV  B10, V3.16B
    ADDV  B25, V6.8B
    UADDLV  H21, V25.8B
    SMAXV  B22, V26.16B
    SMINV  H17, V19.8H
    SADDLV  H20, V8.8B
    ADDV  B17, V19.16B
    SADDLV  S18, V19.4H
    UADDLV  H12, V23.8B
    SMINV  B13, V19.16B
    FMAXV  S24, V11.4S
    UMINV  B14, V13.8B
    SMINV  H27, V27.4H
    FMAXNMV  S15, V0.4S
    SMAXV  B26, V10.8B
    UADDLV  D5, V24.4S
    FMAXV  S5, V9.4S
    SMINV  B3, V2.16B
    UADDLV  S16, V18.8H
    ADDV  S25, V6.4S
    SMAXV  H8, V11.8H
    ADDV  H25, V18.4H
    SMINV  S13, V25.4S
    FMINV  S12, V26.4S
    ADDV  H2, V26.4H
    UADDLV  D26, V22.4S
    UADDLV  D15, V15.4S
    SMINV  H18, V22.4H
    SMAXV  B3, V1.8B
    SADDLV  H17, V11.16B
    SMAXV  S23, V23.4S
    FMAXNMV  S25, V20.4S
    FMAXV  S27, V24.4S
    SADDLV  H22, V1.16B
    SMINV  S10, V18.4S
    ADDV  S2, V9.4S
    SMAXV  B27, V22.16B
    FMINV  S24, V21.4S
    UADDLV  H9, V17.8B
    SMINV  B24, V6.16B
    FMAXNMV  S6, V18.4S
    UMINV  S29, V26.4S
    FMINV  S23, V23.4S
    UMAXV  S8, V22.4S
    SMINV  H23, V3.4H
    UMINV  B3, V3.16B
    ADDV  B15, V27.16B
    UADDLV  H29, V16.8B
    UMINV  B12, V15.8B
    SADDLV  H25, V27.8B
    FMAXNMV  S10, V30.4S
    SADDLV  D18, V9.4S
    UADDLV  S12, V23.4H
    SMINV  H6, V15.4H
    SMINV  H15, V30.4H
    UADDLV  S27, V21.4H
    UMINV  H22, V17.8H
    SADDLV  D8, V5.4S
    FMINNMV  S0, V28.4S
    SADDLV  D11, V22.4S
    SADDLV  D21, V26.4S
    SMAXV  H15, V18.8H
    SADDLV  H16, V16.8B
    SMINV  H19, V0.8H
    UMAXV  S20, V12.4S
    UMAXV  H5, V18.4H
    FMINV  S25, V26.4S
    UMAXV  H0, V25.4H
    UMINV  H30, V21.4H
    UADDLV  D0, V13.4S
    SADDLV  H15, V3.8B
    SMINV  B26, V18.8B
    SMAXV  S25, V21.4S
    UMINV  B9, V20.8B
    FMAXV  S13, V3.4S
    SMINV  B20, V17.16B
    SMINV  H17, V30.8H
    SMINV  B24, V8.8B
    UMINV  S30, V11.4S
    SMINV  H31, V30.4H
    FMAXNMV  S27, V7.4S
    UMINV  S11, V26.4S
    SADDLV  D18, V0.4S
    UADDLV  D13, V27.4S
    UADDLV  H14, V31.16B
    SADDLV  D12, V22.4S
    FMINV  S6, V31.4S
    SMAXV  H12, V2.8H
    SMINV  H5, V14.8H
    SADDLV  D23, V15.4S
    SMAXV  H17, V15.8H
    FMINV  S3, V18.4S
    ADDV  H19, V18.4H
    UMAXV  B18, V3.16B
    UMAXV  B15, V23.16B
    UMINV  H13, V14.4H
    SMAXV  B27, V4.16B
    UMAXV  B9, V18.8B
    ADDV  S6, V18.4S
    SMAXV  B9, V19.16B
    ADDV  S16, V7.4S
    FMINV  S7, V22.4S
    FMAXV  S18, V0.4S
    UMINV  H6, V3.4H
    SADDLV  D18, V10.4S
    ADDV  B17, V11.8B
    FMAXV  S29, V4.4S
    SMAXV  H31, V7.8H
    UMAXV  B14, V17.8B
    SMINV  H26, V8.4H
    FMAXNMV  S27, V20.4S
    UADDLV  H19, V27.16B
    SMAXV  B11, V9.8B
    ADDV  B7, V26.8B
    SMAXV  B8, V10.16B
    SADDLV  H29, V22.8B
    UMINV  B29, V10.8B
    UMAXV  S31, V29.4S
    SMAXV  H5, V2.4H
    SMAXV  S21, V27.4S
    UMINV  B31, V23.16B
    SMAXV  S5, V8.4S
    SMINV  H24, V12.8H
    SADDLV  D0, V8.4S
    ADDV  H25, V28.8H
    ADDV  B26, V19.16B
    SMAXV  H31, V21.4H
    FMINNMV  S9, V19.4S
    SMAXV  H20, V4.8H
    SMAXV  H0, V2.8H
    UMAXV  H6, V27.4H
    UADDLV  D17, V30.4S
    SMINV  S11, V7.4S
    UADDLV  D24, V30.4S
    SADDLV  D28, V20.4S
    ADDV  S20, V12.4S
    UADDLV  D13, V13.4S
    UMAXV  S4, V22.4S
    FMINNMV  S4, V9.4S
    ADDV  H12, V8.4H
    UADDLV  D31, V25.4S
    SADDLV  S21, V15.8H
    UMAXV  S8, V19.4S
    SADDLV  H29, V27.16B
    SMAXV  H29, V2.4H
    FMAXV  S10, V7.4S
    SADDLV  S4, V30.4H
    ADDV  H2, V25.4H
    SADDLV  S10, V3.4H
    SMAXV  H26, V6.4H
    SUBS  X16, X16, #0x1
    B.NE  TaishanSimdElementArithemticP01_label_1196
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X4
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X5
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X7
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X13
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X12, X24, X16
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X18
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X20, X28, X20
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X26, X23, X22
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X26
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X12, X24, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X28, X3, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X17, X28, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D2
    MOVZ  X28, #0x0, LSL #0
    SUB  X17, X28, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, D3
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, V4.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, D4
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, V5.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, D5
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X3, X18, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, D6
    MOVZ  X18, #0x0, LSL #0
    SUB  X3, X18, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, V7.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X17, X14, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, D7
    MOVZ  X14, #0x0, LSL #0
    SUB  X17, X14, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, D8
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D9
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D10
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, V11.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, D11
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, V12.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, D12
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, D13
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, V14.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, D14
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, V15.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, D15
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D16
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, V17.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, D17
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D18
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, D20
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X28, X17, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, D21
    MOVZ  X17, #0x0, LSL #0
    SUB  X28, X17, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D22
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, D23
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, D24
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, D25
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, V26.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, D26
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D27
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, D28
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, V29.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, D29
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
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
    FMOV  D0, X15
    FMOV  V0.D[1], X29
    FMOV  D1, X8
    FMOV  V1.D[1], X7
    FMOV  D2, X5
    FMOV  V2.D[1], X25
    FMOV  D3, X8
    FMOV  V3.D[1], X22
    FMOV  D4, X26
    FMOV  V4.D[1], X28
    FMOV  D5, X23
    FMOV  V5.D[1], X7
    FMOV  D6, X28
    FMOV  V6.D[1], X21
    FMOV  D7, X6
    FMOV  V7.D[1], X21
    FMOV  D8, X29
    FMOV  V8.D[1], X13
    FMOV  D9, X22
    FMOV  V9.D[1], X3
    FMOV  D10, X28
    FMOV  V10.D[1], X4
    FMOV  D11, X21
    FMOV  V11.D[1], X24
    FMOV  D12, X28
    FMOV  V12.D[1], X9
    FMOV  D13, X14
    FMOV  V13.D[1], X17
    FMOV  D14, X15
    FMOV  V14.D[1], X21
    FMOV  D15, X29
    FMOV  V15.D[1], X27
    FMOV  D16, X3
    FMOV  V16.D[1], X23
    FMOV  D17, X26
    FMOV  V17.D[1], X25
    FMOV  D18, X11
    FMOV  V18.D[1], X21
    FMOV  D19, X11
    FMOV  V19.D[1], X18
    FMOV  D20, X8
    FMOV  V20.D[1], X3
    FMOV  D21, X9
    FMOV  V21.D[1], X24
    FMOV  D22, X21
    FMOV  V22.D[1], X26
    FMOV  D23, X5
    FMOV  V23.D[1], X25
    FMOV  D24, X9
    FMOV  V24.D[1], X13
    FMOV  D25, X29
    FMOV  V25.D[1], X9
    FMOV  D26, X17
    FMOV  V26.D[1], X27
    FMOV  D27, X14
    FMOV  V27.D[1], X21
    FMOV  D28, X20
    FMOV  V28.D[1], X13
    FMOV  D29, X4
    FMOV  V29.D[1], X24
    FMOV  D30, X28
    FMOV  V30.D[1], X23
    FMOV  D31, X17
    FMOV  V31.D[1], X23
    MOVZ  X26, #0xf, LSL #0
TaishanSimdElementArithemticP01_label_1271:
    FMINNMV  S22, V30.4S
    ADDV  S15, V14.4S
    ADDV  S1, V0.4S
    ADDV  B6, V29.16B
    SADDLV  S20, V11.4H
    UMINV  H25, V23.8H
    FMAXV  S12, V31.4S
    FMINNMV  S24, V13.4S
    UMAXV  S11, V3.4S
    UMINV  B9, V6.16B
    FMAXV  S29, V26.4S
    FMAXV  S13, V1.4S
    SMINV  H7, V31.8H
    UMINV  B13, V16.8B
    UMAXV  S8, V29.4S
    UADDLV  H30, V28.16B
    UMINV  B15, V23.16B
    UADDLV  H17, V21.16B
    SMAXV  B26, V4.8B
    SMINV  B12, V13.16B
TaishanSimdElementArithemticP01_label_1034:
    SMAXV  H17, V11.4H
    UMAXV  S5, V25.4S
    UMINV  B4, V23.8B
    FMINNMV  S5, V22.4S
    UMAXV  B1, V10.16B
    FMAXV  S26, V29.4S
    UADDLV  D19, V26.4S
    SMAXV  S19, V15.4S
    FMAXNMV  S27, V30.4S
    FMINV  S12, V4.4S
    ADDV  S2, V1.4S
    UMINV  H18, V23.4H
    SMINV  B10, V31.16B
    UMAXV  S5, V31.4S
    SADDLV  D31, V22.4S
    ADDV  H13, V5.4H
    SMAXV  H8, V25.8H
    SMINV  B24, V20.8B
    ADDV  B22, V9.8B
    SMINV  S29, V29.4S
    SADDLV  D5, V7.4S
    FMINNMV  S21, V5.4S
    SADDLV  S7, V5.4H
    FMAXNMV  S29, V6.4S
    SADDLV  S24, V31.8H
    SADDLV  D1, V9.4S
    SADDLV  S23, V26.8H
    FMAXNMV  S22, V14.4S
    SMINV  S25, V4.4S
    SMAXV  H17, V25.8H
    UMINV  B0, V27.8B
    FMAXNMV  S0, V10.4S
    UADDLV  D14, V21.4S
    ADDV  H20, V0.4H
    SMINV  B18, V0.16B
    UADDLV  H3, V14.16B
    SMINV  H21, V17.8H
    UMINV  H10, V5.4H
    FMINNMV  S15, V1.4S
    SADDLV  H17, V20.16B
    FMAXV  S4, V14.4S
    SMAXV  H20, V27.8H
    UMINV  S30, V22.4S
    ADDV  H9, V6.8H
    UMAXV  H30, V18.8H
    UADDLV  S29, V18.8H
    UMINV  S5, V26.4S
    UMAXV  H24, V15.4H
    SADDLV  D30, V22.4S
    SADDLV  S18, V0.4H
    FMINV  S16, V21.4S
    SMINV  S16, V26.4S
    SMAXV  H30, V20.8H
    UMAXV  B7, V7.16B
    UADDLV  S9, V11.8H
    UMINV  S0, V26.4S
    SMAXV  B1, V27.8B
    FMAXNMV  S13, V0.4S
    UMINV  H17, V14.4H
    UMINV  S13, V1.4S
    SMINV  B20, V24.8B
    UADDLV  H24, V12.16B
    ADDV  B24, V14.16B
    SMINV  S5, V16.4S
    SMAXV  B19, V12.16B
    ADDV  S7, V21.4S
    FMAXV  S4, V23.4S
    ADDV  H7, V16.4H
    SMAXV  B4, V30.8B
    SMAXV  B22, V16.8B
    SADDLV  D25, V17.4S
    SADDLV  S4, V19.4H
    SADDLV  D3, V1.4S
    FMINNMV  S7, V26.4S
    FMAXNMV  S31, V17.4S
    SMINV  H29, V1.4H
    ADDV  S5, V25.4S
    UMAXV  S30, V13.4S
    UMAXV  B25, V19.8B
    FMINNMV  S23, V10.4S
    FMINNMV  S1, V24.4S
    ADDV  S28, V23.4S
    SADDLV  H5, V7.8B
    ADDV  H22, V6.4H
    SMAXV  S7, V30.4S
    UMAXV  S1, V31.4S
    SADDLV  D26, V24.4S
    UMINV  B22, V4.8B
    SMAXV  S3, V5.4S
    FMINNMV  S10, V22.4S
    ADDV  S29, V25.4S
    UMAXV  B4, V19.16B
    SADDLV  S18, V0.4H
    FMAXV  S31, V17.4S
    SADDLV  D12, V23.4S
    SADDLV  D22, V13.4S
    UADDLV  H18, V1.16B
    UMINV  B30, V3.16B
    UMAXV  S24, V18.4S
    SMAXV  S22, V1.4S
    UMINV  B13, V21.8B
    FMINV  S1, V0.4S
    SMAXV  B17, V7.8B
    SMAXV  S25, V31.4S
    UMAXV  H19, V20.4H
    FMAXNMV  S19, V23.4S
    UADDLV  S12, V10.4H
    FMAXNMV  S21, V4.4S
    ADDV  B3, V16.8B
    UMINV  S0, V26.4S
    SADDLV  H19, V11.16B
    UMINV  B28, V21.8B
    UMAXV  S12, V10.4S
    SMINV  B10, V5.16B
    UMINV  H23, V4.4H
    ADDV  B31, V15.16B
    FMINV  S14, V31.4S
    UADDLV  D29, V10.4S
    SMAXV  B30, V7.16B
    UMAXV  S11, V11.4S
    ADDV  H11, V8.4H
    SMINV  H1, V15.8H
    SMINV  H26, V20.8H
    FMAXNMV  S10, V20.4S
    ADDV  S3, V5.4S
    UMINV  B3, V26.16B
    SMINV  S6, V3.4S
    UMAXV  H12, V1.4H
    UADDLV  H31, V11.16B
    UMINV  H12, V5.4H
    FMINNMV  S28, V9.4S
    SMINV  S7, V29.4S
    UADDLV  S11, V26.4H
    FMINV  S30, V4.4S
    ADDV  B26, V29.16B
    ADDV  B18, V3.8B
    SMINV  B20, V1.8B
    UMAXV  H11, V3.8H
    UMAXV  H28, V7.4H
    FMINV  S9, V3.4S
    FMAXV  S22, V26.4S
    UMINV  H18, V28.8H
    UMINV  B19, V13.8B
    SMAXV  S26, V5.4S
    ADDV  S3, V13.4S
    UMINV  H3, V18.8H
    SMAXV  H12, V4.4H
    ADDV  B27, V13.16B
    FMINV  S19, V2.4S
    SMAXV  S9, V24.4S
    UMINV  B13, V9.8B
    SMAXV  H19, V19.8H
    SMINV  S23, V22.4S
    FMINNMV  S30, V13.4S
    FMAXV  S31, V20.4S
    FMAXV  S28, V3.4S
    SMINV  S2, V30.4S
    FMINNMV  S29, V5.4S
    SMINV  H27, V25.8H
    SADDLV  D11, V25.4S
    SADDLV  D2, V21.4S
    SMAXV  S23, V19.4S
    SMAXV  H1, V15.8H
    UMAXV  B4, V12.16B
    SADDLV  S5, V13.8H
    UMAXV  B8, V20.16B
    UMAXV  H9, V22.8H
    UMINV  B10, V25.8B
    SMAXV  S20, V22.4S
    UMINV  S29, V25.4S
    FMINV  S18, V14.4S
    SMAXV  S9, V22.4S
    ADDV  H14, V21.8H
    ADDV  H8, V25.4H
    UADDLV  D5, V10.4S
    SMAXV  B0, V5.16B
    UADDLV  S16, V21.4H
    UMAXV  H7, V13.4H
    FMINNMV  S13, V15.4S
    SMAXV  S26, V22.4S
    SUBS  X26, X26, #0x1
    B.NE  TaishanSimdElementArithemticP01_label_1271
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X14, X27, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X2, X7, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X28, X26, X4
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X5, X12, X5
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X12, X25, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X21, X8, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X12, X21, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X11, X3, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X6, X3, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X20, X17, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X20, X3, X13
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X16, X27, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X9, X29, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X6, X27, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X16, X21, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X27, X26, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X11, X3, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X27, X5, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X29, X23, X25
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X26, X3, X26
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, D2
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D4
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, D5
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, D6
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, V7.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, D7
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, D8
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, V9.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, D9
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, D10
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D11
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X20, D12
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, D13
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X20, X21, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, D14
    MOVZ  X21, #0x0, LSL #0
    SUB  X20, X21, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, V15.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, D15
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, D16
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D17
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, V18.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, D18
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, D20
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X29, X12, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D21
    MOVZ  X12, #0x0, LSL #0
    SUB  X29, X12, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, V22.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X27, X17, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, D22
    MOVZ  X17, #0x0, LSL #0
    SUB  X27, X17, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X20, D23
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, D24
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D25
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, V26.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, D26
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, D27
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X22, X17, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, D28
    MOVZ  X17, #0x0, LSL #0
    SUB  X22, X17, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X16
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, D29
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X16
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0xc45, LSL #0
    MOVK  X2, #0xb232, LSL #16
    MOVK  X2, #0x1e38, LSL #32
    MOVK  X2, #0x3f40, LSL #48
    MOVZ  X3, #0xb25e, LSL #0
    MOVK  X3, #0xc8ad, LSL #16
    MOVK  X3, #0xe765, LSL #32
    MOVK  X3, #0x8f19, LSL #48
TaishanSimdElementArithemticP01_label_655:
    MOVZ  X4, #0xaf07, LSL #0
    MOVK  X4, #0xfa44, LSL #16
    MOVK  X4, #0xc73d, LSL #32
    MOVK  X4, #0xf2de, LSL #48
    MOVZ  X5, #0x44c5, LSL #0
    MOVK  X5, #0x419c, LSL #16
    MOVK  X5, #0x79e0, LSL #32
    MOVK  X5, #0xbd19, LSL #48
    MOVZ  X6, #0x865c, LSL #0
    MOVK  X6, #0xd8a7, LSL #16
    MOVK  X6, #0xd303, LSL #32
    MOVK  X6, #0xb470, LSL #48
    MOVZ  X7, #0xc9d3, LSL #0
    MOVK  X7, #0xdaca, LSL #16
    MOVK  X7, #0x1d37, LSL #32
    MOVK  X7, #0x1c17, LSL #48
    MOVZ  X8, #0x97c0, LSL #0
    MOVK  X8, #0xc3ce, LSL #16
    MOVK  X8, #0x5297, LSL #32
    MOVK  X8, #0x8289, LSL #48
    MOVZ  X9, #0x72b2, LSL #0
    MOVK  X9, #0x33cc, LSL #16
    MOVK  X9, #0x71c2, LSL #32
    MOVK  X9, #0x2928, LSL #48
    MOVZ  X10, #0xffa8, LSL #0
    MOVK  X10, #0x8ec9, LSL #16
    MOVK  X10, #0xf6d5, LSL #32
    MOVK  X10, #0x9b9f, LSL #48
    MOVZ  X11, #0x5b95, LSL #0
    MOVK  X11, #0xffe9, LSL #16
    MOVK  X11, #0xf612, LSL #32
TaishanSimdElementArithemticP01_label_1333:
    MOVK  X11, #0x440b, LSL #48
    MOVZ  X12, #0x5ff1, LSL #0
    MOVK  X12, #0x1703, LSL #16
    MOVK  X12, #0xd292, LSL #32
    MOVK  X12, #0x1824, LSL #48
    MOVZ  X13, #0x9cf2, LSL #0
    MOVK  X13, #0xa721, LSL #16
    MOVK  X13, #0x2456, LSL #32
    MOVK  X13, #0x747f, LSL #48
    MOVZ  X14, #0xb4c5, LSL #0
    MOVK  X14, #0x887f, LSL #16
    MOVK  X14, #0x6da6, LSL #32
    MOVK  X14, #0xe105, LSL #48
    MOVZ  X15, #0x41dd, LSL #0
    MOVK  X15, #0xaf1c, LSL #16
    MOVK  X15, #0x7690, LSL #32
    MOVK  X15, #0xffa, LSL #48
    MOVZ  X16, #0x2a36, LSL #0
    MOVK  X16, #0x32f4, LSL #16
    MOVK  X16, #0x897, LSL #32
    MOVK  X16, #0x2140, LSL #48
    MOVZ  X17, #0x512, LSL #0
    MOVK  X17, #0x164a, LSL #16
    MOVK  X17, #0x6231, LSL #32
    MOVK  X17, #0xf183, LSL #48
    MOVZ  X18, #0x3e39, LSL #0
    MOVK  X18, #0x99e3, LSL #16
    MOVK  X18, #0x787e, LSL #32
    MOVK  X18, #0xcb80, LSL #48
    MOVZ  X20, #0x12f7, LSL #0
    MOVK  X20, #0x83dc, LSL #16
    MOVK  X20, #0x8575, LSL #32
    MOVK  X20, #0x13da, LSL #48
    MOVZ  X21, #0xeec2, LSL #0
    MOVK  X21, #0xb15d, LSL #16
    MOVK  X21, #0x70fb, LSL #32
    MOVK  X21, #0x5864, LSL #48
    MOVZ  X22, #0xce16, LSL #0
    MOVK  X22, #0x5e0, LSL #16
    MOVK  X22, #0xefeb, LSL #32
    MOVK  X22, #0xb724, LSL #48
    MOVZ  X23, #0x5a4f, LSL #0
    MOVK  X23, #0x1429, LSL #16
    MOVK  X23, #0x5e57, LSL #32
    MOVK  X23, #0x3542, LSL #48
    MOVZ  X24, #0x6ebf, LSL #0
    MOVK  X24, #0x16e8, LSL #16
    MOVK  X24, #0xf536, LSL #32
    MOVK  X24, #0x285a, LSL #48
    MOVZ  X25, #0x3254, LSL #0
    MOVK  X25, #0xc749, LSL #16
    MOVK  X25, #0x6522, LSL #32
    MOVK  X25, #0x4932, LSL #48
    MOVZ  X26, #0x15cc, LSL #0
    MOVK  X26, #0xab9, LSL #16
    MOVK  X26, #0xf44b, LSL #32
    MOVK  X26, #0x4736, LSL #48
    MOVZ  X27, #0x66e7, LSL #0
    MOVK  X27, #0xa0ec, LSL #16
    MOVK  X27, #0xb9eb, LSL #32
    MOVK  X27, #0x537a, LSL #48
    MOVZ  X28, #0xe1fd, LSL #0
    MOVK  X28, #0xb213, LSL #16
    MOVK  X28, #0xa10d, LSL #32
    MOVK  X28, #0xe5cd, LSL #48
    MOVZ  X29, #0x7034, LSL #0
    MOVK  X29, #0xf1, LSL #16
    MOVK  X29, #0x32e1, LSL #32
    MOVK  X29, #0x3ec7, LSL #48
    FMOV  D0, X18
    FMOV  V0.D[1], X7
    FMOV  D1, X2
    FMOV  V1.D[1], X10
    FMOV  D2, X22
    FMOV  V2.D[1], X25
    FMOV  D3, X13
    FMOV  V3.D[1], X3
    FMOV  D4, X5
    FMOV  V4.D[1], X12
    FMOV  D5, X3
    FMOV  V5.D[1], X21
    FMOV  D6, X5
    FMOV  V6.D[1], X28
    FMOV  D7, X18
    FMOV  V7.D[1], X16
    FMOV  D8, X9
    FMOV  V8.D[1], X17
    FMOV  D9, X15
    FMOV  V9.D[1], X17
    FMOV  D10, X11
    FMOV  V10.D[1], X9
    FMOV  D11, X9
    FMOV  V11.D[1], X10
    FMOV  D12, X7
    FMOV  V12.D[1], X11
    FMOV  D13, X22
    FMOV  V13.D[1], X21
    FMOV  D14, X12
    FMOV  V14.D[1], X24
    FMOV  D15, X25
    FMOV  V15.D[1], X4
    FMOV  D16, X28
    FMOV  V16.D[1], X15
    FMOV  D17, X17
    FMOV  V17.D[1], X26
    FMOV  D18, X20
    FMOV  V18.D[1], X22
    FMOV  D19, X6
    FMOV  V19.D[1], X14
    FMOV  D20, X11
    FMOV  V20.D[1], X14
    FMOV  D21, X10
    FMOV  V21.D[1], X28
    FMOV  D22, X27
    FMOV  V22.D[1], X17
    FMOV  D23, X11
    FMOV  V23.D[1], X10
    FMOV  D24, X21
    FMOV  V24.D[1], X16
    FMOV  D25, X9
    FMOV  V25.D[1], X4
    FMOV  D26, X18
    FMOV  V26.D[1], X22
    FMOV  D27, X26
    FMOV  V27.D[1], X9
    FMOV  D28, X21
    FMOV  V28.D[1], X4
    FMOV  D29, X28
    FMOV  V29.D[1], X17
    FMOV  D30, X13
    FMOV  V30.D[1], X27
    FMOV  D31, X16
    FMOV  V31.D[1], X5
    MOVZ  X26, #0xa, LSL #0
TaishanSimdElementArithemticP01_label_1340:
    UMINV  B5, V20.16B
    UADDLV  D2, V8.4S
    SMINV  B16, V17.8B
    UMINV  B16, V28.8B
    UMINV  S23, V5.4S
    FMINNMV  S25, V9.4S
    FMINNMV  S31, V30.4S
    SMAXV  S31, V6.4S
    UMAXV  B10, V27.8B
    FMAXV  S8, V29.4S
    UADDLV  H2, V5.8B
    UADDLV  D20, V16.4S
    SADDLV  S21, V30.8H
    UMINV  B8, V10.16B
    SMINV  S17, V16.4S
    SMAXV  H29, V18.8H
    SMAXV  S1, V26.4S
    SADDLV  S29, V19.4H
    FMAXV  S21, V7.4S
    SMINV  H17, V31.4H
    UADDLV  S26, V20.4H
    SMAXV  H0, V15.8H
    SADDLV  H31, V10.16B
    FMAXV  S31, V28.4S
    SMINV  H4, V27.8H
    FMAXNMV  S19, V5.4S
    FMINV  S22, V17.4S
    SMAXV  H22, V5.8H
    UADDLV  S2, V4.4H
    UMINV  H22, V21.8H
    UMAXV  H0, V20.4H
    UMAXV  S20, V28.4S
    SADDLV  D7, V4.4S
    UMAXV  B9, V11.8B
    FMINV  S25, V18.4S
    UMINV  B17, V9.16B
    UMAXV  H8, V21.4H
    FMINNMV  S23, V2.4S
    SMAXV  S7, V26.4S
    FMINV  S23, V4.4S
    SADDLV  D4, V8.4S
    SADDLV  H6, V27.16B
    SMAXV  S8, V12.4S
    UMAXV  B4, V5.8B
    FMAXNMV  S11, V19.4S
    ADDV  B6, V8.8B
    SMINV  B25, V10.16B
    SMAXV  B31, V0.8B
    FMAXV  S26, V6.4S
    SMINV  S9, V0.4S
    UMINV  S18, V1.4S
    FMAXV  S14, V22.4S
    SADDLV  D6, V25.4S
    FMAXNMV  S15, V19.4S
    SMAXV  S16, V15.4S
    SMINV  B25, V5.16B
    UADDLV  S19, V27.4H
    UMAXV  B10, V22.16B
    SMAXV  H17, V28.4H
    FMAXNMV  S15, V9.4S
    UADDLV  S16, V27.4H
    SMINV  B10, V6.8B
    SMAXV  S9, V8.4S
    SMAXV  B0, V22.8B
    UMAXV  H17, V8.4H
    UMINV  B14, V29.8B
    SADDLV  H8, V0.16B
    ADDV  B8, V6.8B
    SMAXV  B28, V2.8B
    ADDV  S0, V14.4S
    UMAXV  S4, V30.4S
    UADDLV  D8, V26.4S
    UMAXV  B14, V16.8B
    FMINNMV  S11, V4.4S
    FMAXV  S27, V29.4S
    ADDV  S18, V12.4S
    UMAXV  B12, V24.8B
    SMAXV  H5, V15.4H
    UMAXV  H2, V14.4H
    FMAXV  S0, V2.4S
    SMAXV  S15, V18.4S
    UMAXV  H11, V24.8H
    FMINV  S19, V10.4S
    UADDLV  H20, V19.16B
    SMAXV  S27, V21.4S
    UMINV  H2, V30.8H
    UADDLV  D8, V31.4S
    UMINV  H10, V21.8H
    UADDLV  H18, V23.16B
    FMAXV  S20, V24.4S
    SADDLV  H25, V22.16B
    SMINV  H14, V13.8H
    SADDLV  S26, V30.4H
    SADDLV  H19, V4.16B
    UMAXV  H8, V16.4H
    UMAXV  H19, V16.4H
    SMINV  B23, V10.16B
    SMINV  S16, V5.4S
    SMAXV  B5, V27.8B
    SMAXV  S5, V11.4S
    UMINV  H26, V25.4H
    UMAXV  B14, V15.8B
    SADDLV  H20, V15.16B
    FMAXV  S22, V8.4S
    UMINV  S19, V12.4S
    SMAXV  S31, V1.4S
    SMAXV  H20, V23.4H
    FMINV  S12, V28.4S
    UMINV  H6, V26.8H
    UMAXV  S23, V19.4S
    UMINV  S10, V24.4S
    UMINV  B26, V12.8B
    SADDLV  D23, V2.4S
    SMINV  H18, V11.4H
    ADDV  S10, V1.4S
    UMINV  B4, V28.16B
    FMAXNMV  S2, V1.4S
    SADDLV  H21, V18.16B
    ADDV  S28, V30.4S
    UMINV  B2, V30.16B
    FMAXV  S8, V6.4S
    FMAXV  S19, V12.4S
    UMINV  B22, V21.16B
    UMINV  H2, V8.4H
    SMAXV  B14, V29.8B
    ADDV  B6, V26.16B
    UADDLV  S16, V3.8H
    UMAXV  H16, V24.8H
    UADDLV  S25, V17.8H
    SMAXV  B1, V14.16B
    UADDLV  D18, V11.4S
    UMAXV  B24, V30.16B
    ADDV  H27, V15.4H
    UMINV  H6, V14.8H
    UADDLV  D14, V8.4S
    SADDLV  H28, V17.16B
    UMAXV  S21, V6.4S
    SMAXV  B8, V29.8B
    UMINV  B28, V1.16B
    SMAXV  S13, V22.4S
    FMINV  S16, V17.4S
    SADDLV  D15, V12.4S
    ADDV  B15, V21.16B
    UMAXV  S18, V27.4S
    SMAXV  S8, V14.4S
    FMAXNMV  S21, V1.4S
    UMINV  H30, V3.4H
    UMAXV  B12, V28.16B
    ADDV  H22, V21.8H
    UMAXV  B28, V21.8B
    UMINV  S10, V24.4S
    SMAXV  S14, V17.4S
    UMINV  B29, V8.16B
    UMAXV  H15, V2.4H
    FMAXNMV  S2, V18.4S
    SMAXV  H4, V24.8H
    SMINV  H30, V17.8H
    SADDLV  S7, V6.8H
    SADDLV  S2, V13.4H
    UMINV  H20, V20.4H
    SMINV  S15, V16.4S
    SMAXV  H20, V1.8H
    SMINV  B25, V29.8B
    SADDLV  H31, V26.8B
    SMAXV  B18, V27.16B
    FMINV  S23, V14.4S
    UMAXV  H0, V26.8H
    ADDV  H6, V22.4H
    SMINV  S28, V12.4S
    UMINV  B5, V18.8B
    FMINNMV  S24, V11.4S
    SMINV  H26, V29.8H
    ADDV  S5, V27.4S
    SMAXV  S16, V30.4S
    SMINV  S29, V10.4S
    UMAXV  H3, V4.4H
    ADDV  B3, V9.8B
    FMINV  S13, V15.4S
    SADDLV  H0, V3.16B
    FMINV  S22, V31.4S
    UMAXV  H11, V0.8H
    UADDLV  S5, V21.8H
    FMAXNMV  S0, V15.4S
    SMINV  B23, V12.8B
    SMAXV  B10, V5.16B
    ADDV  S5, V22.4S
    UMINV  S22, V3.4S
    ADDV  B3, V30.8B
    SADDLV  S9, V30.4H
    ADDV  B11, V3.8B
    ADDV  H6, V23.8H
    SMAXV  H7, V7.8H
    FMINV  S26, V10.4S
    SADDLV  S26, V3.8H
    SMAXV  H30, V6.4H
    UMINV  H4, V12.8H
    SMAXV  B26, V13.8B
    SMINV  H17, V26.4H
    FMAXNMV  S21, V15.4S
    ADDV  S23, V28.4S
    SUBS  X26, X26, #0x1
    B.NE  TaishanSimdElementArithemticP01_label_1340
    MOVZ  X7, #0xc45, LSL #0
    MOVK  X7, #0xb232, LSL #16
    MOVK  X7, #0x1e38, LSL #32
    MOVK  X7, #0x3f40, LSL #48
    SUB  X8, X7, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X28, #0xb25e, LSL #0
    MOVK  X28, #0xc8ad, LSL #16
    MOVK  X28, #0xe765, LSL #32
    MOVK  X28, #0x8f19, LSL #48
    SUB  X8, X28, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X23, #0xaf07, LSL #0
    MOVK  X23, #0xfa44, LSL #16
    MOVK  X23, #0xc73d, LSL #32
    MOVK  X23, #0xf2de, LSL #48
    SUB  X29, X23, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X20, #0x44c5, LSL #0
    MOVK  X20, #0x419c, LSL #16
    MOVK  X20, #0x79e0, LSL #32
    MOVK  X20, #0xbd19, LSL #48
    SUB  X2, X20, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0x865c, LSL #0
    MOVK  X12, #0xd8a7, LSL #16
    MOVK  X12, #0xd303, LSL #32
    MOVK  X12, #0xb470, LSL #48
    SUB  X29, X12, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X13, #0xc45, LSL #0
    MOVK  X13, #0xb232, LSL #16
    MOVK  X13, #0x1e38, LSL #32
    MOVK  X13, #0x3f40, LSL #48
    SUB  X7, X13, X7
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0x72b2, LSL #0
    MOVK  X2, #0x33cc, LSL #16
    MOVK  X2, #0x71c2, LSL #32
    MOVK  X2, #0x2928, LSL #48
    SUB  X23, X2, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X26, #0xffa8, LSL #0
    MOVK  X26, #0x8ec9, LSL #16
    MOVK  X26, #0xf6d5, LSL #32
    MOVK  X26, #0x9b9f, LSL #48
    SUB  X4, X26, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0x5b95, LSL #0
    MOVK  X12, #0xffe9, LSL #16
    MOVK  X12, #0xf612, LSL #32
    MOVK  X12, #0x440b, LSL #48
    SUB  X2, X12, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X24, #0x5b95, LSL #0
    MOVK  X24, #0xffe9, LSL #16
    MOVK  X24, #0xf612, LSL #32
    MOVK  X24, #0x440b, LSL #48
    SUB  X10, X24, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X24, #0xc45, LSL #0
    MOVK  X24, #0xb232, LSL #16
    MOVK  X24, #0x1e38, LSL #32
    MOVK  X24, #0x3f40, LSL #48
    SUB  X18, X24, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X24, #0xb4c5, LSL #0
    MOVK  X24, #0x887f, LSL #16
    MOVK  X24, #0x6da6, LSL #32
    MOVK  X24, #0xe105, LSL #48
    SUB  X9, X24, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X17, #0x41dd, LSL #0
    MOVK  X17, #0xaf1c, LSL #16
    MOVK  X17, #0x7690, LSL #32
    MOVK  X17, #0xffa, LSL #48
    SUB  X13, X17, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X28, #0x41dd, LSL #0
    MOVK  X28, #0xaf1c, LSL #16
    MOVK  X28, #0x7690, LSL #32
    MOVK  X28, #0xffa, LSL #48
    SUB  X5, X28, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X24, #0x44c5, LSL #0
    MOVK  X24, #0x419c, LSL #16
    MOVK  X24, #0x79e0, LSL #32
    MOVK  X24, #0xbd19, LSL #48
    SUB  X23, X24, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X23, #0xeec2, LSL #0
    MOVK  X23, #0xb15d, LSL #16
    MOVK  X23, #0x70fb, LSL #32
    MOVK  X23, #0x5864, LSL #48
    SUB  X26, X23, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X21, #0xce16, LSL #0
    MOVK  X21, #0x5e0, LSL #16
    MOVK  X21, #0xefeb, LSL #32
    MOVK  X21, #0xb724, LSL #48
    SUB  X17, X21, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X13, #0xeec2, LSL #0
    MOVK  X13, #0xb15d, LSL #16
    MOVK  X13, #0x70fb, LSL #32
    MOVK  X13, #0x5864, LSL #48
    SUB  X10, X13, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X11, #0x44c5, LSL #0
    MOVK  X11, #0x419c, LSL #16
    MOVK  X11, #0x79e0, LSL #32
    MOVK  X11, #0xbd19, LSL #48
    SUB  X27, X11, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X9, #0x3254, LSL #0
    MOVK  X9, #0xc749, LSL #16
    MOVK  X9, #0x6522, LSL #32
    MOVK  X9, #0x4932, LSL #48
    SUB  X6, X9, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X17, #0x41dd, LSL #0
    MOVK  X17, #0xaf1c, LSL #16
    MOVK  X17, #0x7690, LSL #32
    MOVK  X17, #0xffa, LSL #48
    SUB  X2, X17, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X20, X21, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, D2
    MOVZ  X21, #0x0, LSL #0
    SUB  X20, X21, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X17, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X17, D3
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X27, X14, X29
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, D4
    MOVZ  X14, #0x0, LSL #0
    SUB  X27, X14, X29
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X29
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, D5
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X29
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
TaishanSimdElementArithemticP01_label_971:
    FMOV  X24, D6
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, D7
TaishanSimdElementArithemticP01_label_1099:
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X25, X5, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, D8
    MOVZ  X5, #0x0, LSL #0
    SUB  X25, X5, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X4
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, D9
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X4
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, D10
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, V11.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, D11
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, D12
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, V13.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, D13
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, D14
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, D15
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X21, X20, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, D16
    MOVZ  X20, #0x0, LSL #0
    SUB  X21, X20, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, D17
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, D18
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, D20
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, D21
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, V22.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X4, X20, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, D22
    MOVZ  X20, #0x0, LSL #0
    SUB  X4, X20, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X17, D23
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, D24
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X20, D25
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    FMOV  X17, D26
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X11, D27
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, D28
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X20, D29
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
TaishanSimdElementArithemticP01_label_1382:
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
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
    FMOV  V0.D[1], X18
    FMOV  D1, X27
    FMOV  V1.D[1], X27
    FMOV  D2, X16
    FMOV  V2.D[1], X10
    FMOV  D3, X3
    FMOV  V3.D[1], X20
    FMOV  D4, X4
    FMOV  V4.D[1], X29
    FMOV  D5, X22
    FMOV  V5.D[1], X15
    FMOV  D6, X4
    FMOV  V6.D[1], X8
    FMOV  D7, X28
    FMOV  V7.D[1], X25
    FMOV  D8, X6
    FMOV  V8.D[1], X3
    FMOV  D9, X27
    FMOV  V9.D[1], X25
    FMOV  D10, X22
    FMOV  V10.D[1], X4
    FMOV  D11, X4
    FMOV  V11.D[1], X25
    FMOV  D12, X22
    FMOV  V12.D[1], X13
    FMOV  D13, X17
    FMOV  V13.D[1], X15
    FMOV  D14, X2
    FMOV  V14.D[1], X14
    FMOV  D15, X22
    FMOV  V15.D[1], X8
    FMOV  D16, X16
    FMOV  V16.D[1], X26
    FMOV  D17, X4
    FMOV  V17.D[1], X29
    FMOV  D18, X7
    FMOV  V18.D[1], X17
    FMOV  D19, X24
    FMOV  V19.D[1], X29
    FMOV  D20, X25
    FMOV  V20.D[1], X7
    FMOV  D21, X4
    FMOV  V21.D[1], X26
    FMOV  D22, X9
    FMOV  V22.D[1], X2
    FMOV  D23, X14
    FMOV  V23.D[1], X25
    FMOV  D24, X17
    FMOV  V24.D[1], X17
    FMOV  D25, X18
    FMOV  V25.D[1], X24
    FMOV  D26, X17
    FMOV  V26.D[1], X8
    FMOV  D27, X2
    FMOV  V27.D[1], X7
    FMOV  D28, X8
    FMOV  V28.D[1], X10
    FMOV  D29, X24
    FMOV  V29.D[1], X14
    FMOV  D30, X12
    FMOV  V30.D[1], X13
    FMOV  D31, X13
    FMOV  V31.D[1], X27
    MOVZ  X26, #0xa, LSL #0
TaishanSimdElementArithemticP01_label_1405:
    UMINV  H21, V25.8H
    UADDLV  S2, V27.4H
    UADDLV  S23, V24.8H
    ADDV  B26, V25.8B
    FMAXV  S0, V14.4S
    ADDV  S11, V2.4S
    SMINV  B21, V27.8B
    UADDLV  D20, V22.4S
    UADDLV  H15, V30.8B
    FMAXV  S7, V13.4S
    FMINNMV  S18, V0.4S
    UMINV  S9, V26.4S
    SMINV  H28, V20.4H
    UADDLV  D7, V25.4S
    ADDV  H10, V20.8H
    SMAXV  B15, V31.8B
    UADDLV  S0, V6.4H
    FMINNMV  S9, V9.4S
    SADDLV  S9, V2.8H
    SMINV  H26, V24.4H
    SADDLV  D15, V7.4S
    UMINV  B0, V18.16B
    FMINV  S19, V22.4S
    FMINNMV  S13, V28.4S
    SMINV  S16, V18.4S
    UMINV  H24, V17.8H
    SMAXV  B0, V25.16B
    SMAXV  S20, V0.4S
    ADDV  H11, V20.4H
    UMINV  B30, V16.16B
    SADDLV  S6, V6.4H
    UADDLV  D6, V25.4S
    UMAXV  B6, V19.16B
    SMAXV  B25, V18.8B
    UADDLV  D9, V25.4S
    UADDLV  S14, V27.8H
    SADDLV  H26, V15.8B
    FMINV  S8, V2.4S
    FMAXNMV  S13, V23.4S
    FMINNMV  S27, V31.4S
    SMINV  H23, V4.4H
    FMINV  S14, V23.4S
    SMINV  H19, V13.8H
    SMAXV  S14, V28.4S
    SMINV  H2, V14.8H
    UADDLV  D18, V21.4S
    SMAXV  H13, V0.4H
    ADDV  S11, V26.4S
    FMAXV  S8, V21.4S
    UMAXV  H27, V23.8H
    UADDLV  D1, V29.4S
    SADDLV  D5, V25.4S
    SADDLV  H12, V28.16B
    SADDLV  S17, V21.4H
    UMAXV  H12, V1.8H
    ADDV  H14, V12.8H
    SADDLV  D4, V21.4S
    UMINV  B0, V25.8B
    SMINV  H9, V26.4H
    SADDLV  H13, V1.16B
    UADDLV  H2, V5.8B
    UMAXV  H10, V4.8H
    SMAXV  B15, V13.16B
    UMAXV  S24, V19.4S
    UMINV  H16, V6.8H
    SADDLV  S0, V14.8H
    UMAXV  B16, V18.16B
    UMINV  B27, V23.16B
    UMINV  B24, V16.16B
    UMINV  S12, V9.4S
    SMAXV  B14, V11.16B
    FMAXV  S6, V11.4S
    SADDLV  H25, V6.8B
    FMAXV  S12, V0.4S
    UMAXV  B7, V25.8B
    ADDV  H17, V31.4H
    UMAXV  B28, V22.16B
    SADDLV  S7, V12.8H
    FMAXNMV  S8, V11.4S
    SADDLV  D22, V24.4S
    SMAXV  S12, V31.4S
    SMINV  B14, V22.8B
    FMAXNMV  S13, V6.4S
    UMAXV  H13, V14.8H
    SMAXV  S8, V2.4S
    UMINV  S28, V29.4S
    SMAXV  S0, V30.4S
    UADDLV  H15, V9.16B
    SADDLV  D23, V25.4S
    UADDLV  D21, V3.4S
    SMINV  S30, V7.4S
    ADDV  H18, V24.4H
    UMAXV  H29, V2.4H
    SADDLV  S10, V28.8H
    UMINV  S11, V5.4S
    UMAXV  H13, V15.4H
    UADDLV  D9, V8.4S
    SMAXV  S6, V13.4S
    ADDV  H6, V11.8H
    ADDV  H26, V28.4H
    UADDLV  H29, V0.8B
    UMINV  S26, V3.4S
    UADDLV  S3, V4.8H
    SMINV  H28, V9.4H
    SMAXV  B26, V0.8B
    SADDLV  S15, V13.8H
    SADDLV  D22, V10.4S
    UADDLV  H4, V6.8B
    UMINV  H17, V2.4H
    SADDLV  D28, V5.4S
    FMINV  S18, V11.4S
    ADDV  B27, V18.16B
    SADDLV  D0, V27.4S
    SMINV  H29, V2.8H
    FMINNMV  S22, V12.4S
    FMAXV  S15, V2.4S
    SMAXV  S24, V31.4S
    UMAXV  S22, V12.4S
    ADDV  S29, V29.4S
    UMINV  S23, V18.4S
    ADDV  S15, V26.4S
    SMINV  B24, V30.16B
    SMINV  H8, V14.4H
    SMAXV  H7, V15.4H
    UMAXV  S14, V22.4S
    ADDV  S14, V1.4S
    SMAXV  B2, V22.8B
    ADDV  S13, V16.4S
    FMAXNMV  S15, V27.4S
    UMINV  S24, V18.4S
    UADDLV  S0, V5.4H
    UMAXV  B22, V24.16B
    FMAXNMV  S23, V30.4S
    ADDV  B12, V8.8B
    UMAXV  S25, V24.4S
    SMINV  B15, V5.8B
    UMINV  H5, V6.4H
    UADDLV  D0, V25.4S
    SADDLV  D18, V21.4S
    SADDLV  H24, V28.16B
    FMAXV  S20, V27.4S
    UADDLV  D2, V21.4S
    FMINV  S24, V24.4S
    SMINV  B25, V9.8B
    SMAXV  H8, V24.4H
    FMAXV  S25, V26.4S
    SMINV  H29, V22.4H
    SADDLV  H9, V29.8B
    FMINNMV  S28, V1.4S
    UMAXV  B1, V7.8B
    UMAXV  H3, V26.4H
    SMINV  S30, V31.4S
    SMINV  B28, V14.16B
    SMAXV  H1, V30.4H
    UMINV  H27, V9.8H
    FMAXV  S26, V27.4S
    SADDLV  S30, V24.4H
    UMINV  B29, V30.16B
    ADDV  H2, V8.8H
    SADDLV  S8, V6.4H
    UADDLV  D15, V10.4S
    UADDLV  S16, V1.8H
    SMINV  S11, V30.4S
    FMINNMV  S21, V17.4S
    UADDLV  H4, V21.16B
    UMINV  H11, V15.4H
    FMINNMV  S17, V1.4S
    SADDLV  D27, V13.4S
    UMAXV  B16, V25.8B
    SMAXV  S0, V17.4S
    ADDV  H19, V20.4H
    UMINV  B17, V4.8B
    ADDV  S11, V17.4S
    ADDV  H5, V8.8H
    SMINV  S14, V28.4S
    SMAXV  B24, V24.8B
    FMAXNMV  S19, V2.4S
    FMINV  S29, V27.4S
    SADDLV  S30, V19.8H
    UADDLV  D4, V16.4S
    UADDLV  D22, V5.4S
    ADDV  H7, V7.4H
    SMINV  S22, V16.4S
    SADDLV  D14, V8.4S
    SMINV  H1, V7.8H
    FMINV  S29, V14.4S
    SADDLV  H1, V8.8B
    UMINV  B12, V7.8B
    SMINV  S29, V6.4S
    UMAXV  B7, V23.8B
    FMAXNMV  S30, V2.4S
    UMINV  H22, V29.8H
    UADDLV  S3, V0.4H
    SMAXV  H9, V7.8H
    UMAXV  S8, V29.4S
    FMINV  S17, V22.4S
    SMAXV  S21, V10.4S
    UADDLV  D19, V10.4S
    FMINV  S31, V16.4S
    SMAXV  S17, V1.4S
    SUBS  X26, X26, #0x1
    B.NE  TaishanSimdElementArithemticP01_label_1405
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X21, X12, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X29, X26, X5
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X16, X21, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X4, X8, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X9
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X8, X21, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X24, X14, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X11, X24, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X28, D2
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, V3.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X22, D3
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X5, X12, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, D4
    MOVZ  X12, #0x0, LSL #0
    SUB  X5, X12, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, D5
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, V6.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, D6
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, V7.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X25
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X25, D7
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X25
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, D8
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, D9
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D10
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X17, D11
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, V12.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, D12
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, D13
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V14.D[1]
TaishanSimdElementArithemticP01_label_1417:
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D14
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, D15
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, D16
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D17
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X7, X26, X10
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, D18
    MOVZ  X26, #0x0, LSL #0
    SUB  X7, X26, X10
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X7
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X7, D20
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X7
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X26
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X26, D21
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X26
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, D22
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X14, X29, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, D23
    MOVZ  X29, #0x0, LSL #0
    SUB  X14, X29, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, D24
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, D25
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, D26
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, D27
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X3, D28
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
    FMOV  X27, D29
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdElementArithemticP01_TestFail
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
    FMOV  D0, X29
    FMOV  V0.D[1], X13
    FMOV  D1, X26
    FMOV  V1.D[1], X16
    FMOV  D2, X18
    FMOV  V2.D[1], X5
    FMOV  D3, X2
    FMOV  V3.D[1], X6
    FMOV  D4, X14
    FMOV  V4.D[1], X8
    FMOV  D5, X8
    FMOV  V5.D[1], X17
    FMOV  D6, X12
    FMOV  V6.D[1], X28
    FMOV  D7, X27
    FMOV  V7.D[1], X6
    FMOV  D8, X26
    FMOV  V8.D[1], X28
    FMOV  D9, X4
    FMOV  V9.D[1], X10
    FMOV  D10, X2
    FMOV  V10.D[1], X4
    FMOV  D11, X6
    FMOV  V11.D[1], X6
    FMOV  D12, X28
    FMOV  V12.D[1], X5
    FMOV  D13, X23
    FMOV  V13.D[1], X27
    FMOV  D14, X2
    FMOV  V14.D[1], X27
    FMOV  D15, X6
    FMOV  V15.D[1], X11
    FMOV  D16, X18
    FMOV  V16.D[1], X16
    FMOV  D17, X18
    FMOV  V17.D[1], X20
    FMOV  D18, X18
    FMOV  V18.D[1], X10
    FMOV  D19, X9
    FMOV  V19.D[1], X11
    FMOV  D20, X28
    FMOV  V20.D[1], X27
    FMOV  D21, X6
    FMOV  V21.D[1], X11
    FMOV  D22, X28
    FMOV  V22.D[1], X20
    FMOV  D23, X17
    FMOV  V23.D[1], X4
    FMOV  D24, X7
    FMOV  V24.D[1], X6
    FMOV  D25, X14
    FMOV  V25.D[1], X21
    FMOV  D26, X10
    FMOV  V26.D[1], X9
    FMOV  D27, X8
    FMOV  V27.D[1], X18
    FMOV  D28, X5
    FMOV  V28.D[1], X18
    FMOV  D29, X10
    FMOV  V29.D[1], X12
    FMOV  D30, X10
    FMOV  V30.D[1], X8
    FMOV  D31, X28
    FMOV  V31.D[1], X7
    MOVZ  X6, #0xf, LSL #0
TaishanSimdElementArithemticP01_label_1475:
    UMINV  H28, V23.8H
    FMAXV  S19, V4.4S
    FMINV  S13, V23.4S
    UMAXV  H22, V1.4H
    ADDV  S30, V17.4S
    FMAXV  S28, V28.4S
    SMINV  B28, V12.8B
    UMINV  S28, V16.4S
    UADDLV  S21, V22.8H
    SADDLV  S15, V28.4H
    UADDLV  S10, V25.4H
    UMINV  S31, V0.4S
    FMAXNMV  S3, V4.4S
    UADDLV  D15, V30.4S
    SMAXV  H2, V13.8H
    SMINV  S31, V19.4S
    UMAXV  B2, V24.8B
    UADDLV  H12, V9.16B
    SMAXV  H26, V29.4H
    UMAXV  B13, V15.8B
    UMAXV  H20, V7.8H
    UADDLV  D6, V7.4S
    ADDV  S23, V8.4S
    SMINV  H29, V26.4H
    FMAXV  S1, V28.4S
    SADDLV  D19, V19.4S
    SMAXV  S4, V28.4S
    FMINNMV  S10, V21.4S
    ADDV  S6, V15.4S
    SMAXV  B13, V19.8B
    FMINNMV  S25, V12.4S
    UADDLV  D4, V20.4S
    UADDLV  D23, V2.4S
    UMINV  B4, V24.8B
    SADDLV  H7, V4.16B
    UMINV  S15, V26.4S
    FMINNMV  S12, V25.4S
    UMINV  S0, V18.4S
    UMINV  B3, V22.8B
    FMAXV  S30, V20.4S
    UMAXV  B20, V10.16B
    SMAXV  B28, V26.16B
    SADDLV  S4, V19.8H
    UADDLV  D1, V29.4S
    SMAXV  H11, V13.8H
    FMINV  S11, V22.4S
    UMAXV  B6, V10.8B
    ADDV  B31, V20.8B
    SMINV  H2, V31.4H
    SMINV  S24, V5.4S
    UMAXV  H13, V26.8H
    FMINNMV  S16, V20.4S
    UMAXV  S24, V14.4S
    ADDV  S29, V9.4S
    UMAXV  S14, V5.4S
    UMINV  S21, V21.4S
    SADDLV  S20, V27.8H
    UMAXV  H27, V25.8H
    UMAXV  H18, V28.4H
    UMAXV  B9, V1.8B
    UMINV  H0, V12.8H
    UMAXV  B7, V22.16B
    UMINV  B20, V12.16B
    SMAXV  B11, V5.16B
    FMINNMV  S28, V12.4S
    UMINV  S12, V26.4S
    SADDLV  H21, V8.16B
    UMINV  H9, V7.8H
    UMAXV  S3, V6.4S
    FMINV  S7, V13.4S
    UADDLV  D8, V13.4S
    UMINV  S3, V2.4S
    UADDLV  D2, V12.4S
    ADDV  S7, V7.4S
    SADDLV  S14, V12.8H
    SADDLV  H25, V2.8B
    ADDV  S15, V26.4S
    UADDLV  D13, V11.4S
    ADDV  S13, V2.4S
    UADDLV  H1, V2.16B
    UADDLV  D8, V13.4S
    ADDV  H13, V15.4H
    UMAXV  B9, V1.8B
    SADDLV  S3, V25.8H
    UMAXV  S1, V25.4S
    UMAXV  H28, V21.4H
    FMAXV  S15, V7.4S
    SADDLV  D27, V15.4S
    UMINV  H8, V25.8H
    ADDV  S26, V1.4S
    UADDLV  H14, V26.16B
    SMAXV  B22, V1.8B
    UADDLV  H28, V10.8B
    UADDLV  H28, V22.8B
    ADDV  B23, V21.8B
    SADDLV  H8, V30.16B
    SMAXV  B3, V31.8B
    FMAXV  S3, V3.4S
    ADDV  H14, V24.4H
    ADDV  B24, V20.8B
    ADDV  H25, V24.4H
    SMINV  H24, V14.8H
    UMINV  S11, V14.4S
    FMINV  S28, V17.4S
    SMINV  S8, V2.4S
    UADDLV  H1, V22.16B
    ADDV  H29, V29.8H
    SMAXV  B18, V14.8B
    SMINV  B28, V26.8B
    UMINV  B25, V13.16B
    FMINV  S3, V31.4S
    UMAXV  H3, V2.8H
    SMAXV  S31, V24.4S
    UMINV  B11, V8.16B
    ADDV  B8, V7.8B
    ADDV  S17, V12.4S
    ADDV  B11, V12.8B
    FMAXV  S14, V26.4S
    SMAXV  S0, V30.4S
    UADDLV  H8, V18.16B
    FMAXNMV  S2, V14.4S
    UADDLV  D14, V22.4S
    SMINV  H14, V11.8H
    SADDLV  D28, V29.4S
    UMAXV  S13, V25.4S
    UMINV  H1, V24.8H
    SMAXV  S15, V26.4S
    UMINV  H8, V3.4H
    SMINV  S14, V30.4S
    SMAXV  H17, V2.4H
    SMAXV  H12, V30.4H
    SADDLV  S28, V5.4H
    ADDV  H9, V21.4H
    UADDLV  H19, V30.16B
    UMINV  S31, V31.4S
    UMAXV  H10, V25.8H
    UADDLV  H12, V5.8B
    SMINV  H3, V15.4H
    SMAXV  H13, V27.8H
    UADDLV  S5, V16.8H
    FMINV  S30, V24.4S
    FMINV  S26, V27.4S
    SMAXV  H26, V27.4H
    FMAXV  S25, V16.4S
    FMAXNMV  S29, V13.4S
    SMAXV  H26, V20.8H
    SMAXV  S15, V30.4S
    UMINV  H30, V26.4H
    SADDLV  S1, V8.4H
    ADDV  S17, V14.4S
    FMINV  S10, V5.4S
    SMINV  H2, V4.8H
    UMINV  H9, V2.8H
    UADDLV  H12, V30.8B
    ADDV  S8, V27.4S
    SADDLV  D3, V9.4S
    FMAXV  S25, V29.4S
    UMAXV  S27, V31.4S
    UADDLV  S26, V21.4H
    SMAXV  S26, V22.4S
    FMAXNMV  S10, V14.4S
    SMINV  S22, V1.4S
    SMAXV  S14, V24.4S
    UMINV  S30, V30.4S
    SMINV  B30, V30.8B
    UMINV  H21, V20.8H
    SMINV  S23, V29.4S
    UADDLV  S23, V29.4H
    UMAXV  H13, V9.8H
    ADDV  S30, V17.4S
    UADDLV  H31, V4.8B
    UMINV  B30, V11.8B
    UMAXV  S4, V12.4S
    SMAXV  B24, V23.8B
    FMAXNMV  S12, V16.4S
    UADDLV  D18, V29.4S
    UMAXV  B14, V12.16B
    SMAXV  S25, V18.4S
    SADDLV  H22, V10.8B
    SMINV  H3, V22.4H
    FMAXV  S31, V20.4S
    UMINV  S14, V3.4S
    UADDLV  S0, V25.4H
    UMAXV  B2, V8.16B
    FMAXV  S20, V14.4S
    UADDLV  H22, V22.8B
    SMINV  H21, V12.4H
    SADDLV  S29, V6.8H
    FMAXV  S6, V22.4S
    UMINV  B31, V10.16B
    UMINV  B8, V8.16B
    FMAXNMV  S30, V28.4S
    SMINV  S29, V0.4S
    SMINV  S10, V9.4S
    FMINNMV  S12, V24.4S
    UMINV  H19, V1.8H
    UADDLV  H31, V9.8B
    SADDLV  S8, V28.8H
    FMINV  S23, V22.4S
    SMAXV  H16, V23.8H
    SUBS  X6, X6, #0x1
    B.NE  TaishanSimdElementArithemticP01_label_1475
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X18, X29, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X12, X15, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X15, X25, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X5, X6, X5
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X29, X26, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X12, X3, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X11, X25, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X8, X5, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X20, X28, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X24, X29, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X2, X23, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X24, X28, X22
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X14, X20, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X13, X3, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X29, X9, X25
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X27
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X18, X22, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X14, X28, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D2
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D3
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, D4
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, D5
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X8, X21, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, D6
    MOVZ  X21, #0x0, LSL #0
TaishanSimdElementArithemticP01_label_357:
    SUB  X8, X21, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X18, D7
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X24, X22, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, D8
    MOVZ  X22, #0x0, LSL #0
    SUB  X24, X22, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X10, D9
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D10
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X14, X29, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X2, D11
    MOVZ  X29, #0x0, LSL #0
    SUB  X14, X29, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, V12.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X5
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, D12
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X5
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X16, D13
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, V14.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X24, X9, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, D14
    MOVZ  X9, #0x0, LSL #0
    SUB  X24, X9, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X24, D15
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X15
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X15, D16
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X15
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X6, D17
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X23, D18
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, D20
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X12, X10, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    FMOV  X8, D21
    MOVZ  X10, #0x0, LSL #0
    SUB  X12, X10, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X14, X27, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X12, D22
    MOVZ  X27, #0x0, LSL #0
    SUB  X14, X27, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, V23.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X21, D23
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X5, D24
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X13, D25
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X4, D26
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X29, D27
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X26, X2, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X9, D28
    MOVZ  X2, #0x0, LSL #0
    SUB  X26, X2, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail
    FMOV  X14, D29
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdElementArithemticP01_TestFail

TaishanSimdElementArithemticP01_TestEnd:
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
TaishanSimdElementArithemticP01_TestFail:
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
