.global TSRTAdvsimdVectorMaxMin

.text
.p2align 4

TSRTAdvsimdVectorMaxMin:

TSRTAdvsimdVectorMaxMin_TestBegin:
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
    MOVZ  X2, #0xfb1, LSL #0
    MOVK  X2, #0x87cc, LSL #16
    MOVK  X2, #0x1122, LSL #32
    MOVK  X2, #0xa7be, LSL #48
    MOVZ  X3, #0x5469, LSL #0
    MOVK  X3, #0x67e8, LSL #16
    MOVK  X3, #0x2f02, LSL #32
    MOVK  X3, #0xf3db, LSL #48
    MOVZ  X5, #0xa732, LSL #0
    MOVK  X5, #0x9dbf, LSL #16
    MOVK  X5, #0x3703, LSL #32
    MOVK  X5, #0xf807, LSL #48
    MOVZ  X6, #0xece, LSL #0
    MOVK  X6, #0x3930, LSL #16
    MOVK  X6, #0x92e0, LSL #32
    MOVK  X6, #0xd903, LSL #48
    MOVZ  X7, #0xdca9, LSL #0
    MOVK  X7, #0x3b0, LSL #16
    MOVK  X7, #0x2fbd, LSL #32
    MOVK  X7, #0xa44, LSL #48
    MOVZ  X9, #0xd786, LSL #0
    MOVK  X9, #0xe78e, LSL #16
    MOVK  X9, #0x9339, LSL #32
    MOVK  X9, #0xf97b, LSL #48
    MOVZ  X10, #0x552a, LSL #0
    MOVK  X10, #0x57dc, LSL #16
    MOVK  X10, #0xe599, LSL #32
    MOVK  X10, #0x148c, LSL #48
    MOVZ  X12, #0x7ff0, LSL #0
    MOVK  X12, #0xb8ae, LSL #16
    MOVK  X12, #0xcfad, LSL #32
    MOVK  X12, #0x25ae, LSL #48
    MOVZ  X13, #0x9cb3, LSL #0
    MOVK  X13, #0x3493, LSL #16
    MOVK  X13, #0x30ac, LSL #32
    MOVK  X13, #0x62b2, LSL #48
    MOVZ  X14, #0xd310, LSL #0
    MOVK  X14, #0xc00a, LSL #16
    MOVK  X14, #0x5e36, LSL #32
    MOVK  X14, #0x936a, LSL #48
    MOVZ  X15, #0xb2e5, LSL #0
    MOVK  X15, #0xb423, LSL #16
    MOVK  X15, #0xfe6a, LSL #32
    MOVK  X15, #0xbea2, LSL #48
    MOVZ  X16, #0x132b, LSL #0
    MOVK  X16, #0xa8a4, LSL #16
    MOVK  X16, #0x3afd, LSL #32
    MOVK  X16, #0x6392, LSL #48
    MOVZ  X17, #0xe8ad, LSL #0
    MOVK  X17, #0x8e39, LSL #16
    MOVK  X17, #0x1a0e, LSL #32
    MOVK  X17, #0xaa82, LSL #48
    MOVZ  X18, #0xe53, LSL #0
    MOVK  X18, #0xb8f7, LSL #16
    MOVK  X18, #0xa716, LSL #32
    MOVK  X18, #0xc4c3, LSL #48
    MOVZ  X19, #0xb693, LSL #0
    MOVK  X19, #0x3830, LSL #16
    MOVK  X19, #0x7e50, LSL #32
    MOVK  X19, #0xab44, LSL #48
    MOVZ  X20, #0x95d6, LSL #0
    MOVK  X20, #0x210, LSL #16
    MOVK  X20, #0xc807, LSL #32
    MOVK  X20, #0x7df0, LSL #48
    MOVZ  X21, #0xed13, LSL #0
    MOVK  X21, #0xbdee, LSL #16
    MOVK  X21, #0xe303, LSL #32
    MOVK  X21, #0x90b6, LSL #48
    MOVZ  X22, #0xa95a, LSL #0
    MOVK  X22, #0x9d57, LSL #16
    MOVK  X22, #0x9ca2, LSL #32
    MOVK  X22, #0xd0b4, LSL #48
    MOVZ  X23, #0xec8b, LSL #0
    MOVK  X23, #0xaf62, LSL #16
    MOVK  X23, #0xa3ed, LSL #32
    MOVK  X23, #0xf31a, LSL #48
    MOVZ  X24, #0x6fd8, LSL #0
    MOVK  X24, #0x855, LSL #16
    MOVK  X24, #0xc40f, LSL #32
    MOVK  X24, #0x7147, LSL #48
    MOVZ  X25, #0xcb5f, LSL #0
    MOVK  X25, #0x7b9b, LSL #16
    MOVK  X25, #0x3d07, LSL #32
    MOVK  X25, #0xcf64, LSL #48
    MOVZ  X26, #0x929f, LSL #0
    MOVK  X26, #0xa6b, LSL #16
    MOVK  X26, #0xe384, LSL #32
    MOVK  X26, #0x9582, LSL #48
    MOVZ  X27, #0x5da1, LSL #0
    MOVK  X27, #0xae18, LSL #16
    MOVK  X27, #0xa23f, LSL #32
    MOVK  X27, #0x71b2, LSL #48
    MOVZ  X28, #0xd01f, LSL #0
    MOVK  X28, #0x9718, LSL #16
    MOVK  X28, #0xa069, LSL #32
    MOVK  X28, #0xccc5, LSL #48
    MOVZ  X29, #0x55d7, LSL #0
    MOVK  X29, #0x8bc9, LSL #16
    MOVK  X29, #0x30cd, LSL #32
    MOVK  X29, #0x247, LSL #48
    MOVZ  X26, #0x91d6, LSL #0
    MOVK  X26, #0x4901, LSL #16
    MOVK  X26, #0xfb50, LSL #32
    MOVK  X26, #0x84b0, LSL #48
    MSR  FPCR, X26
    MOVZ  X26, #0x4c71, LSL #0
    MOVK  X26, #0xd61f, LSL #16
    MOVK  X26, #0x7583, LSL #32
    MOVK  X26, #0xe62f, LSL #48
    MSR  FPSR, X26
    MRS  X22, FPSR
    MOVZ  X3, #0xff60, LSL #0
    MOVK  X3, #0x7ff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    AND  X22, X22, X3
    MOVZ  X3, #0x0, LSL #0
    ORR  X22, X22, X3
    MSR  FPSR, X22
    ISB  SY
    ADDS  X22, X13, X6, LSL #51
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x4663, LSL #0
    MOVK  X2, #0x2275, LSL #16
    MOVK  X2, #0xe53f, LSL #32
    MOVK  X2, #0x47, LSL #48
    MOVZ  X3, #0x9edd, LSL #0
    MOVK  X3, #0x4555, LSL #16
    MOVK  X3, #0xdaa2, LSL #32
    MOVK  X3, #0xa669, LSL #48
    MOVZ  X5, #0xa0d4, LSL #0
    MOVK  X5, #0x251d, LSL #16
    MOVK  X5, #0xcfd1, LSL #32
    MOVK  X5, #0x19a0, LSL #48
    MOVZ  X6, #0x84f9, LSL #0
    MOVK  X6, #0x87ae, LSL #16
    MOVK  X6, #0xe617, LSL #32
    MOVK  X6, #0x21f1, LSL #48
    MOVZ  X7, #0x3402, LSL #0
    MOVK  X7, #0x3b0, LSL #16
    MOVK  X7, #0x194f, LSL #32
    MOVK  X7, #0x46e8, LSL #48
    MOVZ  X9, #0x6664, LSL #0
    MOVK  X9, #0x9626, LSL #16
    MOVK  X9, #0xa304, LSL #32
    MOVK  X9, #0xf915, LSL #48
    MOVZ  X10, #0xd4f, LSL #0
    MOVK  X10, #0x7429, LSL #16
    MOVK  X10, #0x23ac, LSL #32
    MOVK  X10, #0xfcb3, LSL #48
    MOVZ  X12, #0xc7e8, LSL #0
    MOVK  X12, #0x453e, LSL #16
    MOVK  X12, #0x9565, LSL #32
    MOVK  X12, #0x3f19, LSL #48
    MOVZ  X13, #0x29b2, LSL #0
    MOVK  X13, #0xc575, LSL #16
    MOVK  X13, #0x9c0a, LSL #32
    MOVK  X13, #0x9353, LSL #48
    MOVZ  X14, #0x69fa, LSL #0
    MOVK  X14, #0x4e68, LSL #16
    MOVK  X14, #0x4c52, LSL #32
    MOVK  X14, #0x1b89, LSL #48
    MOVZ  X15, #0xe792, LSL #0
    MOVK  X15, #0xd595, LSL #16
    MOVK  X15, #0x6bf0, LSL #32
    MOVK  X15, #0x10a9, LSL #48
    MOVZ  X16, #0x788c, LSL #0
    MOVK  X16, #0xc365, LSL #16
    MOVK  X16, #0xd3b1, LSL #32
    MOVK  X16, #0xfa96, LSL #48
    MOVZ  X17, #0x99f2, LSL #0
    MOVK  X17, #0x9836, LSL #16
    MOVK  X17, #0x9170, LSL #32
    MOVK  X17, #0xad8f, LSL #48
    MOVZ  X18, #0xd73e, LSL #0
    MOVK  X18, #0x526a, LSL #16
    MOVK  X18, #0xc2bb, LSL #32
    MOVK  X18, #0x1c34, LSL #48
    MOVZ  X19, #0x47e2, LSL #0
    MOVK  X19, #0xc0af, LSL #16
    MOVK  X19, #0xb308, LSL #32
    MOVK  X19, #0xb17, LSL #48
    MOVZ  X20, #0x3b02, LSL #0
    MOVK  X20, #0x2770, LSL #16
    MOVK  X20, #0x50ec, LSL #32
    MOVK  X20, #0xd530, LSL #48
    MOVZ  X21, #0xe0e3, LSL #0
    MOVK  X21, #0xa86b, LSL #16
    MOVK  X21, #0x3bd8, LSL #32
    MOVK  X21, #0x226e, LSL #48
    MOVZ  X22, #0x7e61, LSL #0
    MOVK  X22, #0xf8af, LSL #16
    MOVK  X22, #0x345b, LSL #32
    MOVK  X22, #0x5620, LSL #48
    MOVZ  X23, #0xe09a, LSL #0
    MOVK  X23, #0x1132, LSL #16
    MOVK  X23, #0x2866, LSL #32
    MOVK  X23, #0x4471, LSL #48
    MOVZ  X24, #0xa623, LSL #0
    MOVK  X24, #0xeb0a, LSL #16
    MOVK  X24, #0x821b, LSL #32
    MOVK  X24, #0xd16e, LSL #48
    MOVZ  X25, #0x938, LSL #0
    MOVK  X25, #0xb22a, LSL #16
    MOVK  X25, #0x84e9, LSL #32
    MOVK  X25, #0x9179, LSL #48
    MOVZ  X26, #0xcf65, LSL #0
    MOVK  X26, #0x62d3, LSL #16
    MOVK  X26, #0x563b, LSL #32
    MOVK  X26, #0xab87, LSL #48
    MOVZ  X27, #0x918f, LSL #0
    MOVK  X27, #0x5be0, LSL #16
    MOVK  X27, #0x982d, LSL #32
    MOVK  X27, #0xe6, LSL #48
    MOVZ  X28, #0x3bb2, LSL #0
    MOVK  X28, #0xcc81, LSL #16
    MOVK  X28, #0xdd9c, LSL #32
    MOVK  X28, #0x334d, LSL #48
    MOVZ  X29, #0x5d5a, LSL #0
    MOVK  X29, #0xc7b3, LSL #16
    MOVK  X29, #0x1315, LSL #32
    MOVK  X29, #0xe50e, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X25
    FMOV  D1, X26
    FMOV  V1.D[1], X27
    FMOV  D2, X29
    FMOV  V2.D[1], X9
    FMOV  D3, X13
    FMOV  V3.D[1], X22
    FMOV  D4, X21
    FMOV  V4.D[1], X19
    FMOV  D5, X9
    FMOV  V5.D[1], X6
    FMOV  D6, X29
    FMOV  V6.D[1], X28
    FMOV  D7, X2
    FMOV  V7.D[1], X14
    FMOV  D8, X24
    FMOV  V8.D[1], X22
    FMOV  D9, X17
    FMOV  V9.D[1], X25
    FMOV  D10, X22
    FMOV  V10.D[1], X24
    FMOV  D11, X14
    FMOV  V11.D[1], X18
    FMOV  D12, X6
    FMOV  V12.D[1], X24
    FMOV  D13, X15
    FMOV  V13.D[1], X2
    FMOV  D14, X28
    FMOV  V14.D[1], X25
    FMOV  D15, X12
    FMOV  V15.D[1], X18
    FMOV  D16, X26
    FMOV  V16.D[1], X10
    FMOV  D17, X6
    FMOV  V17.D[1], X5
    FMOV  D18, X17
    FMOV  V18.D[1], X12
    FMOV  D19, X21
    FMOV  V19.D[1], X23
    FMOV  D20, X19
    FMOV  V20.D[1], X25
    FMOV  D21, X13
    FMOV  V21.D[1], X14
    FMOV  D22, X24
    FMOV  V22.D[1], X18
    FMOV  D23, X13
    FMOV  V23.D[1], X6
    FMOV  D24, X25
    FMOV  V24.D[1], X5
    FMOV  D25, X15
    FMOV  V25.D[1], X5
    FMOV  D26, X23
    FMOV  V26.D[1], X23
    FMOV  D27, X5
    FMOV  V27.D[1], X25
    FMOV  D28, X10
    FMOV  V28.D[1], X12
    FMOV  D29, X18
    FMOV  V29.D[1], X19
    FMOV  D30, X9
    FMOV  V30.D[1], X10
    FMOV  D31, X27
    FMOV  V31.D[1], X7
    MOVZ  X3, #0xf, LSL #0
TSRTAdvsimdVectorMaxMin_label_0:
    FMAXNMP S18, V28.2S
    UMAXP  V25.8B, V31.8B, V30.8B
    FMIN  V15.8H, V25.8H, V22.8H
    UMINV  B11, V26.8B
    UMAXV  H30, V24.8H
    SMIN  V25.8B, V20.8B, V27.8B
    FMAXP  V8.4H, V18.4H, V18.4H
    SMAXV  B16, V29.8B
    UMINV  S28, V15.4S
    UMAXV  B17, V28.16B
    FMINV  S3, V23.4S
    UMINP  V13.2S, V11.2S, V3.2S
    FMIN  V13.4H, V25.4H, V30.4H
    FMAXNMP S26, V13.2S
    UMAX  V28.4S, V9.4S, V26.4S
    UMAXV  S14, V8.4S
    UMAXV  H8, V28.4H
    FMAXNMV  H28, V10.8H
    FMAXNMP D29, V16.2D
    SMAXV  H30, V17.8H
    UMINV  B17, V14.16B
    FMAXNM  V9.4S, V27.4S, V17.4S
    FMIN  V10.2S, V9.2S, V29.2S
    FMAXP  V26.4H, V8.4H, V10.4H
    UMAXV  B27, V28.8B
    FMAX  V24.4H, V26.4H, V27.4H
    SMAXV  S31, V24.4S
    SMINV  S3, V31.4S
    UMINV  B27, V30.8B
    FMAX  V23.2S, V27.2S, V27.2S
    SMAXV  S22, V23.4S
    UMINV  H26, V22.4H
    FMINNMP  V15.2S, V26.2S, V3.2S
    FMAXNMP  V9.2D, V22.2D, V31.2D
    FMAXV  S17, V18.4S
    FMAXV  H11, V1.8H
    FMINP S31, V13.2S
    UMAXV  S25, V0.4S
    FMAXP D18, V12.2D
    FMINNMP  V1.2S, V9.2S, V3.2S
    FMINNM  V10.4H, V0.4H, V27.4H
    FMAXV  H23, V25.8H
    FMINP  V29.8H, V25.8H, V25.8H
    UMINV  S13, V7.4S
    FMAXNMP D8, V13.2D
    SMAXV  B22, V29.16B
    UMINP  V30.16B, V22.16B, V22.16B
    FMINNM  V14.8H, V3.8H, V11.8H
    FMINP  V3.8H, V17.8H, V8.8H
    FMAXP S8, V30.2S
    FMINP  V24.4H, V5.4H, V10.4H
    FMINP H27, V24.2H
    FMAXNMP  V24.4H, V23.4H, V3.4H
    FMINNMV  S5, V15.4S
    FMAXNMP D13, V1.2D
    FMAXP  V29.4S, V24.4S, V8.4S
    UMAXV  H24, V28.8H
    UMINV  B17, V13.8B
    SMAXV  S13, V14.4S
    FMAXNMP  V14.2D, V13.2D, V29.2D
    SMINP  V28.16B, V14.16B, V5.16B
    FMAXV  S5, V27.4S
    FMAX  V7.8H, V28.8H, V17.8H
    UMAXV  S8, V24.4S
    UMINP  V1.4H, V8.4H, V5.4H
    FMAXP  V22.2S, V1.2S, V1.2S
    SMAXV  H14, V7.4H
    FMAXNMP H15, V14.2H
    FMAX  V27.2D, V22.2D, V22.2D
    UMAXP  V23.4H, V15.4H, V15.4H
    FMAXP H15, V5.2H
    FMINNMP  V17.8H, V15.8H, V9.8H
    FMINNMV  H11, V17.4H
    FMINV  S24, V11.4S
    FMAXNM  V1.4S, V27.4S, V24.4S
    FMAXNMP S22, V23.2S
    FMAXNMP  V7.4H, V1.4H, V22.4H
    FMAXP  V11.8H, V2.8H, V18.8H
    FMINNMP H29, V25.2H
    FMAXP  V14.4S, V29.4S, V24.4S
    FMAXNMP H5, V18.2H
    SMAXV  B3, V22.16B
    FMINP  V9.4H, V6.4H, V11.4H
    FMINNMP  V23.8H, V23.8H, V2.8H
    FMAXNMP D11, V0.2D
    FMAX  V2.8H, V11.8H, V9.8H
    FMINP S29, V27.2S
    FMAXP  V0.8H, V15.8H, V30.8H
    FMAXP S1, V5.2S
    FMINNMP H28, V1.2H
    FMINP S30, V17.2S
    UMAXV  H8, V23.4H
    FMIN  V9.4S, V2.4S, V7.4S
    UMINP  V2.8B, V29.8B, V9.8B
    SMAXV  S26, V28.4S
    FMAXNMP  V27.2S, V8.2S, V8.2S
    FMINP D11, V3.2D
    FMINNMP D29, V14.2D
    FMINNMP D24, V0.2D
    FMINP S1, V24.2S
    UMIN  V17.4H, V2.4H, V1.4H
    FMAXNMP  V5.2S, V11.2S, V27.2S
    SMAXV  B25, V29.16B
    SMAXV  S28, V5.4S
    UMAXV  B6, V17.16B
    FMAXNMP S3, V6.2S
    FMAXP S15, V28.2S
    FMINP D23, V26.2D
    FMINNM  V26.2S, V30.2S, V23.2S
    UMINV  S2, V3.4S
    FMAXNM  V22.4S, V25.4S, V2.4S
    SMIN  V25.4H, V26.4H, V15.4H
    FMINNMP S29, V22.2S
    UMAXV  S24, V25.4S
    FMAXNMP H11, V24.2H
    UMAXV  H27, V11.4H
    FMINP H0, V27.2H
    FMAXNM  V1.2D, V29.2D, V29.2D
    SMINP  V23.8B, V0.8B, V0.8B
    FMAX  V6.2S, V23.2S, V1.2S
    FMAXNMP  V14.8H, V11.8H, V5.8H
    SMAXV  B17, V28.16B
    FMAXNMP S5, V10.2S
    FMAXNM  V3.2D, V17.2D, V12.2D
    FMINP H28, V3.2H
    FMAXP  V11.4H, V25.4H, V16.4H
    FMINNMP H25, V10.2H
    FMAXP  V22.4H, V3.4H, V7.4H
    SMAXP  V24.4H, V19.4H, V14.4H
    UMIN  V17.4S, V11.4S, V21.4S
    FMINP  V12.4H, V9.4H, V27.4H
    FMINP  V30.8H, V16.8H, V30.8H
    UMAXP  V14.16B, V30.16B, V22.16B
    FMAXP H0, V24.2H
    FMINP S26, V25.2S
    SMINV  H7, V20.8H
    FMINNMP  V30.2S, V0.2S, V0.2S
    FMINP  V3.4S, V5.4S, V6.4S
    FMAXNMV  H20, V26.4H
    FMINV  S1, V28.4S
    FMAX  V19.8H, V7.8H, V14.8H
    FMIN  V5.8H, V17.8H, V19.8H
    FMINP  V19.4H, V12.4H, V1.4H
    SMIN  V26.8B, V30.8B, V17.8B
    FMAXNM  V0.2D, V3.2D, V19.2D
    SMIN  V28.8H, V5.8H, V5.8H
    SMINV  H12, V28.4H
    FMAXNMP S23, V12.2S
    FMAXP D6, V0.2D
    FMAX  V14.4H, V20.4H, V26.4H
    FMIN  V28.2S, V12.2S, V14.2S
    FMINP D20, V23.2D
    UMAXV  H22, V20.8H
    FMINV  H1, V6.4H
    FMINV  H14, V1.4H
    SMINV  S23, V22.4S
    SMINP  V20.8B, V23.8B, V28.8B
    SMINV  H30, V20.4H
    UMAXV  S22, V14.4S
    FMAXP S0, V0.2S
    FMAXP D19, V22.2D
    FMAXNMP S1, V19.2S
    FMINNMP H23, V30.2H
    FMAXNMV  H12, V0.8H
    FMINNMP S7, V23.2S
    FMIN  V5.2S, V12.2S, V7.2S
    FMIN  V7.4H, V1.4H, V30.4H
    FMINP  V19.8H, V7.8H, V7.8H
    FMAXNMP  V22.4H, V5.4H, V5.4H
    FMAXP  V26.4H, V19.4H, V19.4H
    SMAXV  H20, V22.8H
    FMAXP  V1.8H, V26.8H, V20.8H
    UMINV  H19, V1.4H
    FMINNMV  S17, V13.4S
    UMINV  S3, V15.4S
    FMAXNMP  V26.4H, V4.4H, V28.4H
    UMAXP  V28.2S, V17.2S, V2.2S
    FMINNMV  H2, V25.4H
    FMAXV  S6, V16.4S
    FMINNM  V30.8H, V30.8H, V23.8H
    FMINNM  V16.4S, V13.4S, V12.4S
    FMINNMP S20, V4.2S
    UMINV  H13, V20.8H
    FMINV  H12, V30.8H
    FMINNM  V1.8H, V28.8H, V2.8H
    UMINP  V22.2S, V16.2S, V26.2S
    SMINV  H7, V1.8H
    FMAXNM  V14.8H, V3.8H, V13.8H
    FMINP  V20.4S, V19.4S, V14.4S
    FMINNM  V0.4H, V12.4H, V18.4H
    SMAXV  S25, V22.4S
    UMAXV  S13, V25.4S
    UMIN  V15.16B, V7.16B, V20.16B
    SMAXV  B30, V0.16B
    SMINV  S0, V13.4S
    FMAXNMV  S7, V6.4S
    FMAXP  V4.4S, V15.4S, V15.4S
    FMAXNMP H13, V4.2H
    FMINP D6, V30.2D
    UMINP  V17.8H, V6.8H, V7.8H
    SUBS  X3, X3, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_0
    MOVZ  X17, #0x4663, LSL #0
    MOVK  X17, #0x2275, LSL #16
    MOVK  X17, #0xe53f, LSL #32
    MOVK  X17, #0x47, LSL #48
    SUB  X19, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xa0d4, LSL #0
    MOVK  X17, #0x251d, LSL #16
    MOVK  X17, #0xcfd1, LSL #32
    MOVK  X17, #0x19a0, LSL #48
    SUB  X19, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x84f9, LSL #0
    MOVK  X17, #0x87ae, LSL #16
    MOVK  X17, #0xe617, LSL #32
    MOVK  X17, #0x21f1, LSL #48
    SUB  X19, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x3402, LSL #0
    MOVK  X17, #0x3b0, LSL #16
    MOVK  X17, #0x194f, LSL #32
    MOVK  X17, #0x46e8, LSL #48
    SUB  X19, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x6664, LSL #0
    MOVK  X17, #0x9626, LSL #16
    MOVK  X17, #0xa304, LSL #32
    MOVK  X17, #0xf915, LSL #48
    SUB  X19, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xd4f, LSL #0
    MOVK  X17, #0x7429, LSL #16
    MOVK  X17, #0x23ac, LSL #32
    MOVK  X17, #0xfcb3, LSL #48
    SUB  X19, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xc7e8, LSL #0
    MOVK  X17, #0x453e, LSL #16
    MOVK  X17, #0x9565, LSL #32
    MOVK  X17, #0x3f19, LSL #48
    SUB  X19, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x29b2, LSL #0
    MOVK  X17, #0xc575, LSL #16
    MOVK  X17, #0x9c0a, LSL #32
    MOVK  X17, #0x9353, LSL #48
    SUB  X19, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x69fa, LSL #0
    MOVK  X17, #0x4e68, LSL #16
    MOVK  X17, #0x4c52, LSL #32
    MOVK  X17, #0x1b89, LSL #48
    SUB  X19, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xe792, LSL #0
    MOVK  X17, #0xd595, LSL #16
    MOVK  X17, #0x6bf0, LSL #32
    MOVK  X17, #0x10a9, LSL #48
    SUB  X19, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x788c, LSL #0
    MOVK  X17, #0xc365, LSL #16
    MOVK  X17, #0xd3b1, LSL #32
    MOVK  X17, #0xfa96, LSL #48
    SUB  X19, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xd73e, LSL #0
    MOVK  X17, #0x526a, LSL #16
    MOVK  X17, #0xc2bb, LSL #32
    MOVK  X17, #0x1c34, LSL #48
    SUB  X19, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xe0e3, LSL #0
    MOVK  X17, #0xa86b, LSL #16
    MOVK  X17, #0x3bd8, LSL #32
    MOVK  X17, #0x226e, LSL #48
    SUB  X19, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x7e61, LSL #0
    MOVK  X17, #0xf8af, LSL #16
    MOVK  X17, #0x345b, LSL #32
    MOVK  X17, #0x5620, LSL #48
    SUB  X19, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xe09a, LSL #0
    MOVK  X17, #0x1132, LSL #16
    MOVK  X17, #0x2866, LSL #32
    MOVK  X17, #0x4471, LSL #48
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xa623, LSL #0
    MOVK  X17, #0xeb0a, LSL #16
    MOVK  X17, #0x821b, LSL #32
    MOVK  X17, #0xd16e, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x938, LSL #0
    MOVK  X17, #0xb22a, LSL #16
    MOVK  X17, #0x84e9, LSL #32
    MOVK  X17, #0x9179, LSL #48
    SUB  X19, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xcf65, LSL #0
    MOVK  X17, #0x62d3, LSL #16
    MOVK  X17, #0x563b, LSL #32
    MOVK  X17, #0xab87, LSL #48
    SUB  X19, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x918f, LSL #0
    MOVK  X17, #0x5be0, LSL #16
    MOVK  X17, #0x982d, LSL #32
    MOVK  X17, #0xe6, LSL #48
    SUB  X19, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x3bb2, LSL #0
    MOVK  X17, #0xcc81, LSL #16
    MOVK  X17, #0xdd9c, LSL #32
    MOVK  X17, #0x334d, LSL #48
    SUB  X19, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x5d5a, LSL #0
    MOVK  X17, #0xc7b3, LSL #16
    MOVK  X17, #0x1315, LSL #32
    MOVK  X17, #0xe50e, LSL #48
    SUB  X19, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x80, LSL #0
    MRS  X19, FPSR
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V0.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D0
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V1.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D1
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V2.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D2
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V3.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D3
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V4.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D4
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V5.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D5
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V6.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D6
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V7.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D7
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V8.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D8
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V9.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D9
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V10.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D10
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V11.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D11
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V12.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D12
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V13.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D13
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V14.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D14
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V15.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D15
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V16.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D16
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V17.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D17
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V18.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D18
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V19.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D19
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V20.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D20
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x69fa, LSL #0
    MOVK  X17, #0x4e68, LSL #16
    MOVK  X17, #0x4c52, LSL #32
    MOVK  X17, #0x1b89, LSL #48
    FMOV  X19, V21.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x29b2, LSL #0
    MOVK  X17, #0xc575, LSL #16
    MOVK  X17, #0x9c0a, LSL #32
    MOVK  X17, #0x9353, LSL #48
    FMOV  X19, D21
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V22.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D22
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V23.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D23
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V24.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D24
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V25.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D25
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V26.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D26
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V27.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D27
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V28.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D28
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V29.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D29
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V30.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D30
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, V31.D[1]
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X19, D31
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
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
    FMOV  D0, X18
    FMOV  V0.D[1], X20
    FMOV  D1, X21
    FMOV  V1.D[1], X19
    FMOV  D2, X29
    FMOV  V2.D[1], X27
    FMOV  D3, X22
    FMOV  V3.D[1], X17
    FMOV  D4, X23
    FMOV  V4.D[1], X24
    FMOV  D5, X25
    FMOV  V5.D[1], X28
    FMOV  D6, X26
    FMOV  V6.D[1], X2
    FMOV  D7, X7
    FMOV  V7.D[1], X5
    FMOV  D8, X12
    FMOV  V8.D[1], X27
    FMOV  D9, X12
    FMOV  V9.D[1], X22
    FMOV  D10, X18
    FMOV  V10.D[1], X16
    FMOV  D11, X12
    FMOV  V11.D[1], X7
    FMOV  D12, X25
    FMOV  V12.D[1], X12
    FMOV  D13, X10
    FMOV  V13.D[1], X7
    FMOV  D14, X17
    FMOV  V14.D[1], X14
    FMOV  D15, X24
    FMOV  V15.D[1], X13
    FMOV  D16, X16
    FMOV  V16.D[1], X9
    FMOV  D17, X15
    FMOV  V17.D[1], X19
    FMOV  D18, X14
    FMOV  V18.D[1], X10
    FMOV  D19, X3
    FMOV  V19.D[1], X17
    FMOV  D20, X20
    FMOV  V20.D[1], X24
    FMOV  D21, X12
    FMOV  V21.D[1], X13
    FMOV  D22, X22
    FMOV  V22.D[1], X15
    FMOV  D23, X12
    FMOV  V23.D[1], X24
    FMOV  D24, X10
    FMOV  V24.D[1], X22
    FMOV  D25, X13
    FMOV  V25.D[1], X7
    FMOV  D26, X18
    FMOV  V26.D[1], X6
    FMOV  D27, X29
    FMOV  V27.D[1], X14
    FMOV  D28, X3
    FMOV  V28.D[1], X25
    FMOV  D29, X12
    FMOV  V29.D[1], X27
    FMOV  D30, X3
    FMOV  V30.D[1], X2
    FMOV  D31, X10
    FMOV  V31.D[1], X14
    MOVZ  X20, #0xf, LSL #0
TSRTAdvsimdVectorMaxMin_label_1:
    UMAX  V5.8H, V21.8H, V26.8H
    FMINP D13, V27.2D
    UMINV  S25, V24.4S
    UMAXV  S17, V5.4S
    FMINP  V20.8H, V20.8H, V28.8H
    FMAXP  V20.4H, V31.4H, V29.4H
    FMAXP H0, V30.2H
    FMINP S21, V13.2S
    FMINNMP  V27.4S, V20.4S, V21.4S
    FMINV  S22, V17.4S
    FMAXNMP  V5.8H, V27.8H, V22.8H
    FMAXNM  V23.4S, V25.4S, V0.4S
    FMAXNM  V12.4S, V23.4S, V5.4S
    FMAXP  V27.8H, V27.8H, V17.8H
    FMAXNM  V17.8H, V25.8H, V3.8H
    SMINV  H23, V2.8H
    FMIN  V28.4H, V4.4H, V16.4H
    FMINNMV  S22, V19.4S
    FMAXNMP D21, V18.2D
    SMAXP  V3.4S, V20.4S, V4.4S
    FMINNM  V29.2D, V25.2D, V27.2D
    SMAX  V13.8B, V27.8B, V24.8B
    UMINV  S20, V29.4S
    UMAXV  S4, V3.4S
    FMAXP  V29.2D, V4.2D, V21.2D
    FMAXNMP  V19.8H, V29.8H, V20.8H
    FMINNM  V18.2S, V22.2S, V13.2S
    FMINP  V0.2S, V28.2S, V18.2S
    UMAXV  S13, V19.4S
    SMAXV  H19, V25.8H
    UMAX  V28.16B, V19.16B, V13.16B
    FMINP S2, V23.2S
    FMINP S16, V28.2S
    FMAXNMP D20, V2.2D
    FMINNM  V19.4H, V12.4H, V17.4H
    FMINV  S5, V20.4S
    FMINNMP  V3.4H, V0.4H, V5.4H
    FMIN  V20.2D, V19.2D, V3.2D
    FMINNMV  H2, V16.8H
    UMAX  V21.8B, V20.8B, V2.8B
    FMINNM  V17.4H, V9.4H, V22.4H
    FMAXNMP  V23.4H, V27.4H, V27.4H
    UMAXV  B13, V21.8B
    FMAX  V4.8H, V12.8H, V0.8H
    FMAXNMV  S20, V6.4S
    FMINP H3, V17.2H
    FMAXP  V27.4S, V24.4S, V29.4S
    FMINV  H30, V9.4H
    FMINNMV  S5, V18.4S
    UMIN  V17.2S, V1.2S, V8.2S
    FMAX  V16.8H, V30.8H, V23.8H
    UMINV  S21, V20.4S
    FMINV  S9, V21.4S
    FMINNMP S22, V9.2S
    FMINP  V18.4S, V27.4S, V22.4S
    FMINNMP D20, V8.2D
    FMINNMV  H1, V13.8H
    SMIN  V19.8H, V3.8H, V4.8H
    FMINP  V4.8H, V16.8H, V5.8H
    UMIN  V29.4S, V4.4S, V19.4S
    FMAXNMV  H3, V1.4H
    FMINNMP D9, V17.2D
    FMIN  V6.4S, V3.4S, V9.4S
    FMINNMP  V8.4H, V22.4H, V6.4H
    FMINP S24, V8.2S
    FMAX  V6.8H, V24.8H, V24.8H
    SMINV  H27, V6.8H
    UMAXV  S12, V20.4S
    FMAXNM  V21.4H, V18.4H, V29.4H
    UMINV  H16, V12.8H
    SMAXV  H23, V16.4H
    FMINNM  V16.4S, V27.4S, V23.4S
    FMAXNMP H12, V16.2H
    FMAX  V22.8H, V12.8H, V12.8H
    UMINP  V12.8B, V21.8B, V22.8B
    FMAX  V22.4H, V7.4H, V29.4H
    SMIN  V29.2S, V4.2S, V15.2S
    FMINNMP H19, V8.2H
    UMINV  S7, V0.4S
    FMAX  V20.8H, V17.8H, V29.8H
    FMINP H18, V22.2H
    FMIN  V22.8H, V16.8H, V29.8H
    UMIN  V23.2S, V19.2S, V2.2S
    FMAXP  V27.4S, V31.4S, V3.4S
    UMINV  B31, V24.16B
    SMAXV  S13, V6.4S
    FMINP  V15.2D, V22.2D, V20.2D
    SMINV  B20, V31.8B
    FMAXP  V17.2S, V7.2S, V23.2S
    FMINNM  V29.2S, V13.2S, V20.2S
    FMAXV  H6, V18.8H
    SMAX  V16.4H, V6.4H, V17.4H
    SMAX  V8.4S, V27.4S, V12.4S
    UMAX  V3.8B, V15.8B, V29.8B
    FMAXNMP H19, V3.2H
    SMAXV  H20, V19.8H
    SMAX  V21.16B, V16.16B, V20.16B
    FMINNM  V4.8H, V8.8H, V8.8H
    UMAXV  H29, V4.8H
    FMINP D20, V21.2D
    SMINV  B22, V20.16B
    FMINP D4, V29.2D
    FMAXNM  V21.8H, V22.8H, V4.8H
    FMAXP  V12.2D, V9.2D, V8.2D
    SMAXV  S13, V13.4S
    SMINV  B4, V18.8B
    FMINV  S20, V10.4S
    FMINNMV  S19, V0.4S
    FMINNMP D8, V19.2D
    FMAX  V9.8H, V22.8H, V25.8H
    SMAXV  B18, V0.16B
    FMAXV  H22, V18.4H
    SMAXV  S16, V13.4S
    SMAXP  V15.8B, V16.8B, V17.8B
    FMINP  V25.4H, V11.4H, V5.4H
    SMAXV  H29, V12.8H
    FMAXP H19, V21.2H
    FMINP D11, V9.2D
    UMINP  V10.16B, V18.16B, V19.16B
    FMINP  V18.4S, V8.4S, V25.4S
    FMINV  H0, V29.4H
    FMAXV  S9, V10.4S
    UMINV  H8, V4.4H
    FMAXV  S16, V18.4S
    FMAXNMP D4, V11.2D
    FMINNMP  V19.8H, V16.8H, V22.8H
    FMAXP  V11.2S, V9.2S, V4.2S
    UMAX  V10.8B, V19.8B, V19.8B
    FMAXNM  V5.8H, V10.8H, V15.8H
    SMINV  H15, V0.8H
    UMAXP  V0.4H, V8.4H, V5.4H
    FMAXNMV  S25, V11.4S
    SMAX  V9.4H, V0.4H, V25.4H
    FMINNMV  S8, V9.4S
    FMAXNMP S5, V8.2S
    FMAXNMV  S18, V15.4S
    FMINV  S8, V18.4S
    FMINNMP D18, V8.2D
    UMIN  V29.4H, V18.4H, V18.4H
    FMAXNMV  S18, V29.4S
    UMINV  B4, V5.16B
    FMAXNM  V25.8H, V27.8H, V18.8H
    FMAXNMV  S19, V25.4S
    FMINNMP  V16.8H, V4.8H, V4.8H
    SMAXV  B10, V16.16B
    UMAXV  H9, V10.8H
    UMAXV  S8, V9.4S
    FMAXNMP  V10.4S, V19.4S, V23.4S
    FMINNMP H0, V8.2H
    FMAXNMP  V8.2S, V0.2S, V10.2S
    SMINV  H10, V26.4H
    SMAXP  V16.8B, V17.8B, V5.8B
    FMIN  V5.4S, V15.4S, V9.4S
    FMINP  V29.8H, V15.8H, V27.8H
    FMAXV  S23, V14.4S
    UMAXV  H22, V13.8H
    FMINV  H17, V31.4H
    SMINP  V19.16B, V8.16B, V0.16B
    UMINV  S0, V15.4S
    SMAXV  B11, V0.16B
    UMIN  V0.4S, V11.4S, V23.4S
    FMAXP D9, V16.2D
    FMAXP D26, V17.2D
    FMINV  H25, V26.4H
    UMAXV  H17, V16.4H
    SMINV  B18, V10.8B
    FMINP  V27.4S, V18.4S, V14.4S
    UMINV  S11, V29.4S
    FMAXNMP S23, V11.2S
    FMAXP H13, V9.2H
    SMAXP  V16.8H, V0.8H, V17.8H
    FMINP D29, V22.2D
    FMINP S18, V27.2S
    UMAXV  S27, V19.4S
    FMINNMP H9, V5.2H
    UMINV  B26, V16.16B
    FMIN  V16.8H, V9.8H, V8.8H
    SMINV  S14, V16.4S
    FMINNMP S19, V27.2S
    FMINNMP D5, V14.2D
    FMAXP  V27.2S, V5.2S, V26.2S
    UMINP  V8.4H, V19.4H, V25.4H
    FMAXNM  V11.4S, V27.4S, V28.4S
    FMINNMP D10, V18.2D
    FMAXNMV  S15, V13.4S
    FMAXNMV  H14, V8.8H
    SMINV  S17, V14.4S
    FMAXP H9, V10.2H
    UMAX  V22.8B, V11.8B, V29.8B
    FMAXNMP  V0.4S, V9.4S, V9.4S
    SMINV  B26, V15.16B
    FMAXNM  V11.2S, V17.2S, V22.2S
    FMINV  S18, V0.4S
    SMINV  B16, V18.8B
    FMAXV  H22, V26.4H
    UMIN  V10.8B, V23.8B, V22.8B
    SMINV  H23, V11.4H
    SMINP  V17.8H, V10.8H, V16.8H
    FMAXP  V18.4H, V23.4H, V8.4H
    FMINNM  V13.4H, V17.4H, V18.4H
    SUBS  X20, X20, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_1
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x80, LSL #0
    MRS  X6, FPSR
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V0.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D0
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V1.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D1
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V2.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D2
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V3.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D3
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V4.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D4
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V5.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D5
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V6.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D6
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V7.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D7
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V8.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D8
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V9.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D9
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V10.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D10
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V11.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D11
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V12.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D12
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V13.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D13
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V14.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D14
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V15.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D15
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V16.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D16
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V17.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D17
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V18.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D18
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V19.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D19
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V20.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D20
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V21.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D21
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V22.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D22
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V23.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D23
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V24.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D24
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V25.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D25
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V26.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D26
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V27.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D27
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V28.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D28
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V29.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D29
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V30.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D30
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, V31.D[1]
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X6, D31
    SUB  X21, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
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
    FMOV  D0, X25
    FMOV  V0.D[1], X29
    FMOV  D1, X24
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X26
    FMOV  D3, X6
    FMOV  V3.D[1], X10
    FMOV  D4, X23
    FMOV  V4.D[1], X19
    FMOV  D5, X5
    FMOV  V5.D[1], X22
    FMOV  D6, X9
    FMOV  V6.D[1], X15
    FMOV  D7, X9
    FMOV  V7.D[1], X6
    FMOV  D8, X13
    FMOV  V8.D[1], X28
    FMOV  D9, X5
    FMOV  V9.D[1], X21
    FMOV  D10, X3
    FMOV  V10.D[1], X25
    FMOV  D11, X6
    FMOV  V11.D[1], X20
    FMOV  D12, X22
    FMOV  V12.D[1], X7
    FMOV  D13, X18
    FMOV  V13.D[1], X20
    FMOV  D14, X17
    FMOV  V14.D[1], X7
    FMOV  D15, X21
    FMOV  V15.D[1], X3
    FMOV  D16, X17
    FMOV  V16.D[1], X17
    FMOV  D17, X22
    FMOV  V17.D[1], X29
    FMOV  D18, X16
    FMOV  V18.D[1], X26
    FMOV  D19, X21
    FMOV  V19.D[1], X18
    FMOV  D20, X23
    FMOV  V20.D[1], X16
    FMOV  D21, X21
    FMOV  V21.D[1], X6
    FMOV  D22, X16
    FMOV  V22.D[1], X12
    FMOV  D23, X28
    FMOV  V23.D[1], X20
    FMOV  D24, X6
    FMOV  V24.D[1], X24
    FMOV  D25, X9
    FMOV  V25.D[1], X23
    FMOV  D26, X26
    FMOV  V26.D[1], X25
    FMOV  D27, X12
    FMOV  V27.D[1], X19
    FMOV  D28, X21
    FMOV  V28.D[1], X3
    FMOV  D29, X25
    FMOV  V29.D[1], X24
    FMOV  D30, X27
    FMOV  V30.D[1], X20
    FMOV  D31, X22
    FMOV  V31.D[1], X28
    MOVZ  X13, #0xf, LSL #0
TSRTAdvsimdVectorMaxMin_label_2:
    FMINNMP S15, V31.2S
    FMAXNM  V11.4S, V24.4S, V29.4S
    FMINV  H6, V27.4H
    FMAXNM  V20.2S, V6.2S, V30.2S
    UMINP  V30.16B, V23.16B, V11.16B
    FMINNMV  H29, V28.8H
    FMAXP D18, V29.2D
    SMAX  V30.2S, V15.2S, V26.2S
    FMAXP D9, V30.2D
    FMINNMP D24, V20.2D
    FMAXNMP S29, V24.2S
    UMAXV  S27, V18.4S
    UMINV  H6, V27.8H
    SMINV  B0, V6.16B
    FMINNMP S29, V25.2S
    FMINP  V5.2D, V0.2D, V29.2D
    SMINV  H28, V5.8H
    SMIN  V27.2S, V9.2S, V28.2S
    SMAXV  H23, V1.8H
    FMAXV  S28, V2.4S
    FMINP D18, V27.2D
    FMAX  V6.2S, V21.2S, V8.2S
    FMAXNMP D11, V14.2D
    SMAXV  H9, V15.8H
    SMAX  V14.8B, V30.8B, V17.8B
    FMIN  V15.2D, V5.2D, V8.2D
    FMIN  V0.4S, V7.4S, V22.4S
    UMAX  V2.8B, V0.8B, V0.8B
    FMAXNMV  H27, V9.8H
    FMAX  V29.2S, V18.2S, V11.2S
    UMAX  V17.2S, V28.2S, V23.2S
    UMINV  S0, V6.4S
    FMAXNMP  V1.4H, V12.4H, V15.4H
    SMAXV  B22, V1.8B
    UMINV  H30, V14.4H
    FMAXV  H1, V30.4H
    FMINP  V21.4S, V1.4S, V2.4S
    FMINP D9, V21.2D
    FMAXNMP D20, V29.2D
    SMINV  B5, V17.16B
    FMINP D30, V22.2D
    SMAXP  V14.4S, V6.4S, V17.4S
    FMINV  S29, V31.4S
    FMAXNM  V22.4S, V20.4S, V30.4S
    FMINNM  V2.4S, V0.4S, V1.4S
    SMINP  V9.4S, V22.4S, V22.4S
    UMAXP  V18.4S, V5.4S, V2.4S
    FMINNM  V1.4H, V27.4H, V9.4H
    FMINP S27, V14.2S
    SMAXV  S20, V1.4S
    SMAXP  V6.4H, V20.4H, V29.4H
    FMINP H31, V25.2H
    UMAXV  H15, V31.4H
    FMAXNMP H14, V6.2H
    FMINP  V6.8H, V18.8H, V14.8H
    FMINNMV  S17, V6.4S
    FMINNMP  V25.2S, V17.2S, V14.2S
    FMAXNM  V1.4S, V27.4S, V25.4S
    UMAX  V18.8H, V1.8H, V1.8H
    UMINP  V23.2S, V18.2S, V15.2S
    FMINNMP  V29.4H, V7.4H, V9.4H
    FMAXNM  V31.4H, V1.4H, V13.4H
    UMIN  V6.8H, V30.8H, V8.8H
    SMINP  V15.8B, V22.8B, V5.8B
    UMIN  V21.4H, V16.4H, V31.4H
    UMINV  H9, V7.8H
    FMINP D18, V4.2D
    FMINP  V17.4S, V16.4S, V12.4S
    SMINV  S0, V6.4S
    UMIN  V22.4S, V1.4S, V13.4S
    FMINNM  V20.8H, V23.8H, V23.8H
    FMINNMP H1, V18.2H
    FMIN  V14.2D, V20.2D, V30.2D
    SMINV  H27, V17.8H
    FMINNMP D17, V15.2D
    FMAXP S15, V9.2S
    FMINP H8, V22.2H
    FMINV  S30, V27.4S
    FMINNM  V25.2D, V0.2D, V1.2D
    FMINV  H7, V8.8H
    SMAXV  H8, V21.8H
    UMAXV  H31, V30.4H
    SMINV  S20, V14.4S
    FMAXP S9, V25.2S
    FMAXP S13, V20.2S
    FMINP S18, V9.2S
    FMINV  S22, V15.4S
    FMINNMP D4, V7.2D
    SMINP  V27.16B, V8.16B, V22.16B
    SMAX  V22.4H, V31.4H, V13.4H
    FMINNMP S23, V17.2S
    FMAXV  H15, V27.4H
    FMAXNMV  S31, V15.4S
    UMINV  B25, V18.8B
    FMINP D20, V25.2D
    FMAXP S17, V20.2S
    FMAXP  V25.2D, V22.2D, V4.2D
    SMAX  V0.2S, V24.2S, V31.2S
    SMINV  B18, V17.8B
    FMINNMV  H17, V25.8H
    SMAXV  B30, V17.16B
    FMINNMV  H17, V0.4H
    FMINP  V20.4S, V17.4S, V18.4S
    FMAX  V25.2D, V23.2D, V23.2D
    FMAXNMP H15, V30.2H
    FMAXNMV  S0, V15.4S
    FMINP  V18.2D, V20.2D, V0.2D
    FMINNM  V27.8H, V18.8H, V10.8H
    FMINNMP  V24.8H, V27.8H, V25.8H
    FMAXNMP D13, V24.2D
    FMAXNMV  H17, V2.4H
    FMINV  S27, V15.4S
    FMINP  V14.8H, V30.8H, V7.8H
    FMAXP H22, V26.2H
    SMIN  V31.8H, V30.8H, V6.8H
    FMIN  V15.8H, V29.8H, V13.8H
    SMINV  B7, V21.8B
    UMAXV  H20, V31.4H
    FMINP H4, V17.2H
    FMIN  V0.2D, V27.2D, V25.2D
    UMAX  V25.2S, V14.2S, V10.2S
    FMAXNM  V23.8H, V4.8H, V10.8H
    FMAXP S31, V10.2S
    SMAX  V22.2S, V15.2S, V4.2S
    FMIN  V27.2S, V9.2S, V11.2S
    SMINV  B10, V13.8B
    FMINNMP  V1.4S, V22.4S, V25.4S
    FMINNMP  V30.4H, V7.4H, V7.4H
    UMINV  H7, V23.4H
    FMAXNM  V15.4H, V20.4H, V20.4H
    FMAXV  S2, V0.4S
    FMAXP S11, V10.2S
    UMAXV  S13, V11.4S
    UMINV  H6, V1.4H
    SMINP  V25.8H, V15.8H, V6.8H
    FMAXP D9, V7.2D
    FMINNMP H11, V9.2H
    FMINNMP H6, V24.2H
    FMAXP  V14.2D, V2.2D, V0.2D
    FMAXNMV  H24, V11.8H
    SMINV  H23, V14.4H
    FMINNMP H9, V27.2H
    FMAXNMP  V22.2D, V13.2D, V30.2D
    FMAXNMP H20, V22.2H
    UMINV  B22, V24.16B
    SMINV  S24, V25.4S
    SMINV  H7, V31.8H
    FMINNM  V10.8H, V6.8H, V7.8H
    UMINV  H25, V10.8H
    FMAX  V31.2D, V24.2D, V24.2D
    UMINV  S30, V31.4S
    UMAXV  H27, V23.4H
    FMAXV  S1, V9.4S
    UMAXP  V2.16B, V1.16B, V27.16B
    FMINNMP D15, V30.2D
    FMAXNMV  H13, V20.8H
    FMAXNMV  H7, V25.4H
    SMINP  V10.4H, V2.4H, V13.4H
    SMAXV  S25, V10.4S
    FMAX  V9.4H, V22.4H, V22.4H
    FMAXNMP S20, V25.2S
    FMINNM  V30.4S, V20.4S, V20.4S
    UMINP  V23.8B, V27.8B, V30.8B
    FMAXNMP S27, V15.2S
    FMAXNM  V20.2D, V9.2D, V24.2D
    FMINNMV  S6, V27.4S
    UMIN  V15.2S, V7.2S, V23.2S
    FMINP D24, V6.2D
    UMAX  V30.2S, V24.2S, V20.2S
    SMAX  V20.4H, V15.4H, V15.4H
    UMAX  V31.2S, V30.2S, V30.2S
    FMIN  V2.4S, V31.4S, V12.4S
    FMAX  V6.2S, V2.2S, V2.2S
    SMINP  V10.16B, V20.16B, V6.16B
    SMAXP  V2.2S, V14.2S, V26.2S
    FMAX  V14.2S, V28.2S, V24.2S
    FMAXNMP S22, V22.2S
    FMAXNMV  S7, V18.4S
    FMINP S13, V12.2S
    SMINP  V18.8H, V4.8H, V22.8H
    UMAXV  H25, V13.4H
    FMAXNMP S22, V22.2S
    SMINV  S31, V19.4S
    FMAXV  H26, V1.4H
    FMAXP  V23.4S, V26.4S, V2.4S
    SMAX  V12.16B, V31.16B, V7.16B
    FMAXNMP S15, V29.2S
    SMAXP  V1.2S, V15.2S, V10.2S
    SMINV  B4, V25.16B
    SMAX  V7.2S, V4.2S, V6.2S
    FMINNM  V13.4S, V18.4S, V23.4S
    SMAXP  V30.8H, V14.8H, V14.8H
    SMINV  S26, V22.4S
    FMAXP D28, V30.2D
    FMAX  V23.4H, V12.4H, V26.4H
    SMAX  V2.16B, V23.16B, V13.16B
    FMAXV  S10, V7.4S
    FMAXV  S22, V1.4S
    UMAXV  B7, V28.16B
    FMINP  V1.2S, V2.2S, V24.2S
    SUBS  X13, X13, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_2
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X14, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X14, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X14, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X14, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X14, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X14, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X14, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X14, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X14, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X14, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X14, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X14, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X14, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X14, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X14, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X14, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X14, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X14, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X14, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X14, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x80, LSL #0
    MRS  X14, FPSR
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V0.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D0
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V1.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D1
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V2.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D2
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X14, V3.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X14, D3
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V4.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D4
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V5.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D5
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V6.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D6
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V7.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D7
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V8.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D8
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V9.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D9
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V10.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D10
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V11.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D11
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V12.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D12
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V13.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D13
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V14.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D14
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V15.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D15
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X14, V16.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X14, D16
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V17.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D17
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V18.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D18
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X14, V19.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X14, D19
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V20.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D20
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V21.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D21
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V22.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D22
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V23.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D23
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V24.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D24
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V25.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D25
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V26.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D26
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V27.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D27
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V28.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D28
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V29.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D29
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V30.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, D30
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V31.D[1]
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    FMOV  X14, D31
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x596a, LSL #0
    MOVK  X2, #0xc18c, LSL #16
    MOVK  X2, #0xb213, LSL #32
    MOVK  X2, #0xc53f, LSL #48
    MOVZ  X3, #0x309a, LSL #0
    MOVK  X3, #0xdda4, LSL #16
    MOVK  X3, #0x9ac6, LSL #32
    MOVK  X3, #0x1b0d, LSL #48
    MOVZ  X5, #0x5749, LSL #0
    MOVK  X5, #0x1410, LSL #16
    MOVK  X5, #0x224f, LSL #32
    MOVK  X5, #0xb6dc, LSL #48
    MOVZ  X6, #0xb8c1, LSL #0
    MOVK  X6, #0xd599, LSL #16
    MOVK  X6, #0xb9d9, LSL #32
    MOVK  X6, #0xbfc7, LSL #48
    MOVZ  X7, #0xe40b, LSL #0
    MOVK  X7, #0xfff8, LSL #16
    MOVK  X7, #0xdfa1, LSL #32
    MOVK  X7, #0xde76, LSL #48
    MOVZ  X9, #0x88cb, LSL #0
    MOVK  X9, #0x1d69, LSL #16
    MOVK  X9, #0xef7c, LSL #32
    MOVK  X9, #0x2381, LSL #48
    MOVZ  X10, #0xbd4, LSL #0
    MOVK  X10, #0x916d, LSL #16
    MOVK  X10, #0xc890, LSL #32
    MOVK  X10, #0x6f3c, LSL #48
    MOVZ  X12, #0x11a2, LSL #0
    MOVK  X12, #0x530c, LSL #16
    MOVK  X12, #0x233, LSL #32
    MOVK  X12, #0x9c2b, LSL #48
    MOVZ  X13, #0x93e1, LSL #0
    MOVK  X13, #0x680d, LSL #16
    MOVK  X13, #0xcbe1, LSL #32
    MOVK  X13, #0xc6d0, LSL #48
    MOVZ  X14, #0xf465, LSL #0
    MOVK  X14, #0x359d, LSL #16
    MOVK  X14, #0xdc18, LSL #32
    MOVK  X14, #0xf4d, LSL #48
    MOVZ  X15, #0xaafd, LSL #0
    MOVK  X15, #0x1e93, LSL #16
    MOVK  X15, #0xfa42, LSL #32
    MOVK  X15, #0x6615, LSL #48
    MOVZ  X16, #0xf360, LSL #0
    MOVK  X16, #0x23ef, LSL #16
    MOVK  X16, #0x881d, LSL #32
    MOVK  X16, #0xf2f8, LSL #48
    MOVZ  X17, #0x3091, LSL #0
    MOVK  X17, #0x85a4, LSL #16
    MOVK  X17, #0xd2ae, LSL #32
    MOVK  X17, #0xeb60, LSL #48
    MOVZ  X18, #0xf284, LSL #0
    MOVK  X18, #0xb347, LSL #16
    MOVK  X18, #0xc19d, LSL #32
    MOVK  X18, #0x29a1, LSL #48
    MOVZ  X19, #0x7a12, LSL #0
    MOVK  X19, #0xe3fa, LSL #16
    MOVK  X19, #0xa0db, LSL #32
    MOVK  X19, #0xb3a0, LSL #48
    MOVZ  X20, #0x3293, LSL #0
    MOVK  X20, #0xbb8f, LSL #16
    MOVK  X20, #0xfe12, LSL #32
    MOVK  X20, #0xb7ff, LSL #48
    MOVZ  X21, #0x199e, LSL #0
    MOVK  X21, #0xfcf, LSL #16
    MOVK  X21, #0xb129, LSL #32
    MOVK  X21, #0xe58, LSL #48
    MOVZ  X22, #0x37c2, LSL #0
    MOVK  X22, #0x44b8, LSL #16
    MOVK  X22, #0xfcc3, LSL #32
    MOVK  X22, #0x7484, LSL #48
    MOVZ  X23, #0x4223, LSL #0
    MOVK  X23, #0xe768, LSL #16
    MOVK  X23, #0x13bc, LSL #32
    MOVK  X23, #0xdb14, LSL #48
    MOVZ  X24, #0x375e, LSL #0
    MOVK  X24, #0xfb67, LSL #16
    MOVK  X24, #0x7fb5, LSL #32
    MOVK  X24, #0x2604, LSL #48
    MOVZ  X25, #0x228a, LSL #0
    MOVK  X25, #0xf7df, LSL #16
    MOVK  X25, #0xfd63, LSL #32
    MOVK  X25, #0xd5cf, LSL #48
    MOVZ  X26, #0x8109, LSL #0
    MOVK  X26, #0xeac8, LSL #16
    MOVK  X26, #0x37d1, LSL #32
    MOVK  X26, #0x2881, LSL #48
    MOVZ  X27, #0xaeb1, LSL #0
    MOVK  X27, #0xcdb1, LSL #16
    MOVK  X27, #0xc740, LSL #32
    MOVK  X27, #0x717, LSL #48
    MOVZ  X28, #0x4df6, LSL #0
    MOVK  X28, #0x6399, LSL #16
    MOVK  X28, #0x3a10, LSL #32
    MOVK  X28, #0xd063, LSL #48
    MOVZ  X29, #0xbdbb, LSL #0
    MOVK  X29, #0xdc56, LSL #16
    MOVK  X29, #0x62cf, LSL #32
    MOVK  X29, #0x2cbe, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X26
    FMOV  D1, X29
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X6
    FMOV  D3, X5
    FMOV  V3.D[1], X29
    FMOV  D4, X2
    FMOV  V4.D[1], X2
    FMOV  D5, X15
    FMOV  V5.D[1], X21
    FMOV  D6, X23
    FMOV  V6.D[1], X3
    FMOV  D7, X16
    FMOV  V7.D[1], X20
    FMOV  D8, X9
    FMOV  V8.D[1], X27
    FMOV  D9, X22
    FMOV  V9.D[1], X3
    FMOV  D10, X22
    FMOV  V10.D[1], X17
    FMOV  D11, X23
    FMOV  V11.D[1], X29
    FMOV  D12, X26
    FMOV  V12.D[1], X23
    FMOV  D13, X5
    FMOV  V13.D[1], X29
    FMOV  D14, X21
    FMOV  V14.D[1], X5
    FMOV  D15, X20
    FMOV  V15.D[1], X3
    FMOV  D16, X7
    FMOV  V16.D[1], X9
    FMOV  D17, X10
    FMOV  V17.D[1], X19
    FMOV  D18, X29
    FMOV  V18.D[1], X29
    FMOV  D19, X14
    FMOV  V19.D[1], X2
    FMOV  D20, X13
    FMOV  V20.D[1], X16
    FMOV  D21, X20
    FMOV  V21.D[1], X16
    FMOV  D22, X20
    FMOV  V22.D[1], X15
    FMOV  D23, X17
    FMOV  V23.D[1], X9
    FMOV  D24, X9
    FMOV  V24.D[1], X6
    FMOV  D25, X25
    FMOV  V25.D[1], X21
    FMOV  D26, X16
    FMOV  V26.D[1], X24
    FMOV  D27, X19
    FMOV  V27.D[1], X22
    FMOV  D28, X3
    FMOV  V28.D[1], X16
    FMOV  D29, X20
    FMOV  V29.D[1], X21
    FMOV  D30, X19
    FMOV  V30.D[1], X18
    FMOV  D31, X2
    FMOV  V31.D[1], X15
    MOVZ  X10, #0xf, LSL #0
TSRTAdvsimdVectorMaxMin_label_3:
    FMINNMP D12, V26.2D
    SMAXV  H18, V25.8H
    FMAXNMV  S25, V28.4S
    UMAXV  H6, V29.4H
    FMINNMP S20, V27.2S
    FMINNM  V0.4S, V25.4S, V18.4S
    FMINNMV  H8, V31.8H
    FMAXNMP  V6.4S, V20.4S, V0.4S
    FMAXNMP H27, V30.2H
    FMINNMV  S28, V6.4S
    SMINV  H20, V28.4H
    SMAX  V27.4H, V27.4H, V12.4H
    SMINV  B31, V27.16B
    FMIN  V10.8H, V8.8H, V8.8H
    UMINV  B17, V10.16B
    SMINV  S27, V16.4S
    UMAX  V4.4H, V27.4H, V4.4H
    FMAXNM  V19.2D, V20.2D, V17.2D
    UMINV  S29, V31.4S
    FMAXNMP  V25.2S, V4.2S, V29.2S
    FMAXV  H31, V19.8H
    FMAXNMP D26, V31.2D
    SMAXV  H12, V25.8H
    FMINNM  V18.8H, V12.8H, V26.8H
    FMINP  V2.8H, V28.8H, V7.8H
    SMAXV  B30, V19.16B
    FMINNMP H31, V31.2H
    FMINP H8, V14.2H
    FMINV  S0, V22.4S
    FMIN  V26.4S, V20.4S, V0.4S
    FMAXP  V22.2S, V8.2S, V31.2S
    FMAXNM  V31.2D, V16.2D, V29.2D
    FMINNMP  V27.2S, V18.2S, V5.2S
    UMINV  H12, V4.4H
    SMAX  V8.8B, V29.8B, V30.8B
    UMAXP  V19.4H, V21.4H, V10.4H
    UMAX  V20.4H, V3.4H, V8.4H
    SMAXP  V17.16B, V7.16B, V12.16B
    SMAXP  V18.8B, V15.8B, V11.8B
    FMAXNMV  S14, V2.4S
    FMAXNMP S23, V14.2S
    FMINNM  V15.4H, V18.4H, V26.4H
    UMINP  V10.16B, V17.16B, V20.16B
    SMIN  V25.8B, V10.8B, V15.8B
    FMAXNMP S20, V31.2S
    FMINNMV  H11, V19.8H
    FMINP H14, V23.2H
    FMAXNMP  V17.2D, V27.2D, V27.2D
    FMAX  V2.4H, V22.4H, V25.4H
    FMAXNMP D5, V16.2D
    FMINNMP  V16.4H, V20.4H, V0.4H
    FMINP  V25.8H, V16.8H, V16.8H
    FMAXP D28, V16.2D
    FMINNMV  H29, V25.8H
    FMINV  H23, V5.4H
    FMINNMP  V16.4H, V2.4H, V29.4H
    FMAXNMP  V26.2S, V23.2S, V14.2S
    FMAX  V12.8H, V11.8H, V17.8H
    SMINV  B18, V12.16B
    FMINV  H2, V18.8H
    UMINP  V0.4H, V26.4H, V28.4H
    FMAXNM  V26.8H, V2.8H, V0.8H
    FMINV  S29, V26.4S
    UMINV  H0, V29.4H
    FMINNM  V17.4H, V3.4H, V16.4H
    SMAX  V19.8B, V17.8B, V17.8B
    UMINP  V18.8H, V19.8H, V0.8H
    FMINNM  V5.4H, V26.4H, V11.4H
    FMAXP  V28.4S, V13.4S, V31.4S
    FMAXNMV  S12, V0.4S
    UMAXV  S20, V31.4S
    FMAX  V14.4H, V16.4H, V26.4H
    FMINNMP  V29.2S, V29.2S, V31.2S
    FMINP  V13.8H, V15.8H, V10.8H
    FMAXP H26, V25.2H
    FMINNMV  S11, V14.4S
    UMINV  B2, V13.16B
    SMINV  H25, V5.8H
    FMAX  V5.4S, V21.4S, V28.4S
    FMAXP D13, V29.2D
    SMIN  V0.4H, V25.4H, V18.4H
    UMINV  B28, V0.8B
    FMINNM  V18.4S, V26.4S, V5.4S
    FMINNMP  V29.2S, V28.2S, V20.2S
    SMIN  V25.4S, V2.4S, V15.4S
    FMINNM  V5.8H, V12.8H, V12.8H
    FMAXV  H16, V13.4H
    FMAXP D21, V18.2D
    FMAX  V18.8H, V25.8H, V11.8H
    FMAXNMV  H14, V18.4H
    UMAX  V19.8B, V14.8B, V5.8B
    SMAXV  H15, V23.8H
    SMAXV  S31, V19.4S
    FMAXNMP D0, V29.2D
    FMAX  V20.4S, V16.4S, V31.4S
    FMINNMP D31, V0.2D
    FMAX  V25.4S, V21.4S, V15.4S
    UMAXV  H0, V23.4H
    FMINP D15, V20.2D
    SMIN  V20.2S, V15.2S, V25.2S
    FMINV  H28, V3.8H
    FMINNMP  V19.4S, V0.4S, V21.4S
    FMINP  V23.4H, V19.4H, V20.4H
    UMAXV  H13, V31.8H
    UMAX  V14.4H, V13.4H, V23.4H
    FMINNMV  S19, V14.4S
    UMAXV  B13, V28.8B
    FMAXNMP  V5.4S, V13.4S, V13.4S
    FMINNMP  V23.2D, V19.2D, V5.2D
    FMAX  V16.8H, V3.8H, V8.8H
    FMINNMP  V14.2D, V16.2D, V5.2D
    UMAXV  B0, V17.16B
    UMAXV  B15, V22.16B
    UMAXV  B16, V0.8B
    SMINV  S31, V31.4S
    FMINNMP  V0.8H, V18.8H, V24.8H
    FMAXNMP D24, V27.2D
    FMAXP  V25.4H, V22.4H, V10.4H
    SMAXP  V13.8B, V9.8B, V30.8B
    SMINV  S3, V13.4S
    FMINP D22, V25.2D
    FMINP  V9.4H, V15.4H, V14.4H
    UMAX  V30.8H, V9.8H, V24.8H
    SMAX  V25.8H, V30.8H, V13.8H
    FMAXP  V17.4H, V23.4H, V25.4H
    FMINP H9, V17.2H
    SMINV  B23, V3.8B
    FMINNMP D8, V23.2D
    FMINV  H15, V0.8H
    UMIN  V17.16B, V8.16B, V15.16B
    UMINV  H18, V17.8H
    FMIN  V14.4H, V19.4H, V9.4H
    FMAXP D3, V16.2D
    FMINNMP  V27.8H, V22.8H, V31.8H
    FMAXP S22, V27.2S
    UMINV  H5, V3.8H
    FMINNMP H24, V5.2H
    FMAXNMP H10, V24.2H
    UMAXP  V13.8H, V18.8H, V18.8H
    SMAXV  H19, V14.8H
    UMAXP  V30.2S, V13.2S, V13.2S
    SMINV  H27, V10.4H
    FMAXP D23, V30.2D
    FMINNM  V31.4H, V23.4H, V22.4H
    FMAX  V14.8H, V19.8H, V30.8H
    FMAXP S16, V14.2S
    FMAXP S17, V16.2S
    FMAX  V18.4H, V17.4H, V5.4H
    FMINP  V23.4H, V31.4H, V18.4H
    FMINP H30, V27.2H
    SMAXV  H0, V23.4H
    FMINNMP H3, V30.2H
    FMAXNMV  S30, V0.4S
    FMAX  V23.2D, V3.2D, V22.2D
    SMAXV  H0, V0.8H
    FMINNMP S3, V3.2S
    FMINP S16, V0.2S
    FMAXP  V17.2S, V16.2S, V30.2S
    FMAXP  V9.4S, V3.4S, V23.4S
    FMAXNM  V24.8H, V9.8H, V17.8H
    FMAX  V27.4S, V29.4S, V15.4S
    SMAXV  B16, V15.16B
    SMINV  S23, V17.4S
    UMAXV  B22, V28.8B
    FMINNMV  S10, V16.4S
    FMINP  V29.4H, V19.4H, V6.4H
    FMINNM  V19.4S, V9.4S, V4.4S
    FMINP D3, V11.2D
    UMIN  V16.2S, V2.2S, V14.2S
    FMAXP  V14.4S, V27.4S, V16.4S
    FMINNMP D11, V10.2D
    FMINNMP H6, V3.2H
    SMAXV  H0, V24.8H
    FMINV  H4, V23.8H
    FMAXNMP H9, V22.2H
    FMINNMP D17, V14.2D
    FMAX  V27.4S, V17.4S, V17.4S
    FMAXP S15, V19.2S
    SMINV  H23, V29.8H
    UMIN  V2.8B, V23.8B, V27.8B
    UMINV  H24, V2.4H
    FMINP  V16.2D, V8.2D, V0.2D
    SMAXP  V22.16B, V9.16B, V21.16B
    UMAX  V17.8B, V15.8B, V22.8B
    UMAXV  H15, V11.8H
    FMAXNMP  V19.8H, V6.8H, V15.8H
    SMINV  H10, V17.4H
    UMINV  H27, V24.4H
    FMINNMP  V29.2D, V4.2D, V19.2D
    UMIN  V19.4S, V29.4S, V16.4S
    SMAXV  B6, V28.16B
    FMAXNMP D22, V19.2D
    UMINV  B3, V22.8B
    FMINNMV  S29, V10.4S
    UMINV  B4, V3.8B
    FMINP  V23.2S, V27.2S, V6.2S
    FMINP D16, V23.2D
    FMAXNMP  V6.4S, V16.4S, V29.4S
    UMINV  S2, V4.4S
    FMAXV  H3, V2.4H
    SUBS  X10, X10, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_3
    MOVZ  X6, #0x596a, LSL #0
    MOVK  X6, #0xc18c, LSL #16
    MOVK  X6, #0xb213, LSL #32
    MOVK  X6, #0xc53f, LSL #48
    SUB  X22, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x309a, LSL #0
    MOVK  X6, #0xdda4, LSL #16
    MOVK  X6, #0x9ac6, LSL #32
    MOVK  X6, #0x1b0d, LSL #48
    SUB  X22, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x5749, LSL #0
    MOVK  X6, #0x1410, LSL #16
    MOVK  X6, #0x224f, LSL #32
    MOVK  X6, #0xb6dc, LSL #48
    SUB  X22, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0xe40b, LSL #0
    MOVK  X6, #0xfff8, LSL #16
    MOVK  X6, #0xdfa1, LSL #32
    MOVK  X6, #0xde76, LSL #48
    SUB  X22, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x88cb, LSL #0
    MOVK  X6, #0x1d69, LSL #16
    MOVK  X6, #0xef7c, LSL #32
    MOVK  X6, #0x2381, LSL #48
    SUB  X22, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x11a2, LSL #0
    MOVK  X6, #0x530c, LSL #16
    MOVK  X6, #0x233, LSL #32
    MOVK  X6, #0x9c2b, LSL #48
    SUB  X22, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x93e1, LSL #0
    MOVK  X6, #0x680d, LSL #16
    MOVK  X6, #0xcbe1, LSL #32
    MOVK  X6, #0xc6d0, LSL #48
    SUB  X22, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0xf465, LSL #0
    MOVK  X6, #0x359d, LSL #16
    MOVK  X6, #0xdc18, LSL #32
    MOVK  X6, #0xf4d, LSL #48
    SUB  X22, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0xaafd, LSL #0
    MOVK  X6, #0x1e93, LSL #16
    MOVK  X6, #0xfa42, LSL #32
    MOVK  X6, #0x6615, LSL #48
    SUB  X22, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0xf360, LSL #0
    MOVK  X6, #0x23ef, LSL #16
    MOVK  X6, #0x881d, LSL #32
    MOVK  X6, #0xf2f8, LSL #48
    SUB  X22, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x3091, LSL #0
    MOVK  X6, #0x85a4, LSL #16
    MOVK  X6, #0xd2ae, LSL #32
    MOVK  X6, #0xeb60, LSL #48
    SUB  X22, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0xf284, LSL #0
    MOVK  X6, #0xb347, LSL #16
    MOVK  X6, #0xc19d, LSL #32
    MOVK  X6, #0x29a1, LSL #48
    SUB  X22, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x3293, LSL #0
    MOVK  X6, #0xbb8f, LSL #16
    MOVK  X6, #0xfe12, LSL #32
    MOVK  X6, #0xb7ff, LSL #48
    SUB  X22, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x199e, LSL #0
    MOVK  X6, #0xfcf, LSL #16
    MOVK  X6, #0xb129, LSL #32
    MOVK  X6, #0xe58, LSL #48
    SUB  X22, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x4223, LSL #0
    MOVK  X6, #0xe768, LSL #16
    MOVK  X6, #0x13bc, LSL #32
    MOVK  X6, #0xdb14, LSL #48
    SUB  X22, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x375e, LSL #0
    MOVK  X6, #0xfb67, LSL #16
    MOVK  X6, #0x7fb5, LSL #32
    MOVK  X6, #0x2604, LSL #48
    SUB  X22, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x228a, LSL #0
    MOVK  X6, #0xf7df, LSL #16
    MOVK  X6, #0xfd63, LSL #32
    MOVK  X6, #0xd5cf, LSL #48
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x8109, LSL #0
    MOVK  X6, #0xeac8, LSL #16
    MOVK  X6, #0x37d1, LSL #32
    MOVK  X6, #0x2881, LSL #48
    SUB  X22, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0xaeb1, LSL #0
    MOVK  X6, #0xcdb1, LSL #16
    MOVK  X6, #0xc740, LSL #32
    MOVK  X6, #0x717, LSL #48
    SUB  X22, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x4df6, LSL #0
    MOVK  X6, #0x6399, LSL #16
    MOVK  X6, #0x3a10, LSL #32
    MOVK  X6, #0xd063, LSL #48
    SUB  X22, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0xbdbb, LSL #0
    MOVK  X6, #0xdc56, LSL #16
    MOVK  X6, #0x62cf, LSL #32
    MOVK  X6, #0x2cbe, LSL #48
    SUB  X22, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x80, LSL #0
    MRS  X22, FPSR
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V0.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D0
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x4df6, LSL #0
    MOVK  X6, #0x6399, LSL #16
    MOVK  X6, #0x3a10, LSL #32
    MOVK  X6, #0xd063, LSL #48
    FMOV  X22, V1.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0xbdbb, LSL #0
    MOVK  X6, #0xdc56, LSL #16
    MOVK  X6, #0x62cf, LSL #32
    MOVK  X6, #0x2cbe, LSL #48
    FMOV  X22, D1
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V2.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D2
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V3.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D3
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V4.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D4
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V5.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D5
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V6.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D6
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x3293, LSL #0
    MOVK  X6, #0xbb8f, LSL #16
    MOVK  X6, #0xfe12, LSL #32
    MOVK  X6, #0xb7ff, LSL #48
    FMOV  X22, V7.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0xf360, LSL #0
    MOVK  X6, #0x23ef, LSL #16
    MOVK  X6, #0x881d, LSL #32
    MOVK  X6, #0xf2f8, LSL #48
    FMOV  X22, D7
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V8.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D8
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V9.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D9
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V10.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D10
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V11.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D11
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V12.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D12
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V13.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D13
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V14.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D14
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V15.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D15
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V16.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D16
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V17.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D17
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V18.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D18
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V19.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D19
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V20.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D20
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V21.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D21
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V22.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D22
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V23.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D23
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V24.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D24
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V25.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D25
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V26.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D26
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V27.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D27
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V28.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D28
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V29.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D29
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V30.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D30
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, V31.D[1]
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X22, D31
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
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
    FMOV  D0, X24
    FMOV  V0.D[1], X15
    FMOV  D1, X27
    FMOV  V1.D[1], X29
    FMOV  D2, X26
    FMOV  V2.D[1], X28
    FMOV  D3, X25
    FMOV  V3.D[1], X19
    FMOV  D4, X22
    FMOV  V4.D[1], X12
    FMOV  D5, X23
    FMOV  V5.D[1], X21
    FMOV  D6, X6
    FMOV  V6.D[1], X19
    FMOV  D7, X26
    FMOV  V7.D[1], X14
    FMOV  D8, X12
    FMOV  V8.D[1], X29
    FMOV  D9, X16
    FMOV  V9.D[1], X10
    FMOV  D10, X23
    FMOV  V10.D[1], X17
    FMOV  D11, X21
    FMOV  V11.D[1], X29
    FMOV  D12, X9
    FMOV  V12.D[1], X14
    FMOV  D13, X6
    FMOV  V13.D[1], X16
    FMOV  D14, X9
    FMOV  V14.D[1], X24
    FMOV  D15, X20
    FMOV  V15.D[1], X15
    FMOV  D16, X7
    FMOV  V16.D[1], X29
    FMOV  D17, X2
    FMOV  V17.D[1], X29
    FMOV  D18, X5
    FMOV  V18.D[1], X13
    FMOV  D19, X21
    FMOV  V19.D[1], X10
    FMOV  D20, X19
    FMOV  V20.D[1], X19
    FMOV  D21, X24
    FMOV  V21.D[1], X28
    FMOV  D22, X12
    FMOV  V22.D[1], X15
    FMOV  D23, X25
    FMOV  V23.D[1], X18
    FMOV  D24, X19
    FMOV  V24.D[1], X9
    FMOV  D25, X14
    FMOV  V25.D[1], X15
    FMOV  D26, X16
    FMOV  V26.D[1], X19
    FMOV  D27, X10
    FMOV  V27.D[1], X3
    FMOV  D28, X10
    FMOV  V28.D[1], X18
    FMOV  D29, X25
    FMOV  V29.D[1], X22
    FMOV  D30, X2
    FMOV  V30.D[1], X17
    FMOV  D31, X12
    FMOV  V31.D[1], X14
    MOVZ  X24, #0xf, LSL #0
TSRTAdvsimdVectorMaxMin_label_4:
    FMINNM  V5.4S, V24.4S, V29.4S
    FMAXP  V6.8H, V26.8H, V26.8H
    FMAXNMP D13, V25.2D
    SMAXV  B1, V5.8B
    FMIN  V26.4S, V1.4S, V31.4S
    SMINV  B0, V23.8B
    FMAXNMV  S17, V27.4S
    FMINNMV  S22, V6.4S
    FMAXNMV  S30, V22.4S
    SMAXV  H12, V13.8H
    FMINNMV  H8, V26.8H
    SMINP  V16.8B, V0.8B, V8.8B
    FMINNMV  H13, V30.8H
    UMAX  V17.4S, V17.4S, V16.4S
    FMINNMV  H8, V12.4H
    FMINNMP H29, V17.2H
    UMAXV  B25, V13.8B
    FMAXNM  V27.2S, V25.2S, V25.2S
    FMINP  V13.2S, V8.2S, V8.2S
    FMINP S22, V27.2S
    UMINV  S25, V22.4S
    SMINV  S6, V13.4S
    SMAXP  V27.4H, V29.4H, V28.4H
    FMINP D22, V27.2D
    FMAXP H0, V25.2H
    FMAXP S23, V6.2S
    FMIN  V25.8H, V0.8H, V22.8H
    FMAX  V13.2D, V18.2D, V25.2D
    UMIN  V26.2S, V13.2S, V23.2S
    FMAXNMP S30, V17.2S
    SMINV  H28, V11.8H
    FMINNMP S6, V22.2S
    FMAXNMP S18, V14.2S
    SMINP  V12.4H, V6.4H, V1.4H
    FMINP  V6.2S, V14.2S, V2.2S
    UMINV  H16, V1.4H
    FMINNMP H25, V25.2H
    SMINV  S10, V19.4S
    FMINNMP D23, V28.2D
    FMINNMP  V29.8H, V10.8H, V25.8H
    FMINP D1, V29.2D
    UMAXP  V27.8B, V26.8B, V26.8B
    FMAXP D13, V16.2D
    UMINP  V11.4H, V23.4H, V30.4H
    FMINNMV  H16, V6.4H
    FMAX  V22.2D, V18.2D, V16.2D
    FMAXNMP  V30.4H, V27.4H, V12.4H
    UMINV  B26, V22.8B
    UMINV  B22, V13.8B
    UMAXV  H13, V11.4H
    UMAXV  H2, V1.4H
    UMINV  S28, V2.4S
    FMAXNMP H23, V13.2H
    UMAXV  S17, V28.4S
    FMINV  S1, V22.4S
    FMAXP  V22.2D, V30.2D, V17.2D
    SMINV  B2, V22.16B
    UMINP  V13.8B, V26.8B, V26.8B
    FMINNM  V17.4H, V13.4H, V13.4H
    FMINNM  V16.4H, V2.4H, V17.4H
    UMAX  V30.8B, V23.8B, V1.8B
    FMINNMV  H18, V30.4H
    FMINV  S11, V18.4S
    SMIN  V27.8H, V11.8H, V11.8H
    FMAXP S13, V16.2S
    FMAXP D22, V13.2D
    FMAXNMV  H2, V27.8H
    FMAXP D18, V22.2D
    SMINV  S28, V18.4S
    SMAXV  H11, V28.8H
    FMINNMV  S17, V11.4S
    FMAXP S13, V2.2S
    FMAXNMV  H26, V17.8H
    UMINP  V17.8B, V26.8B, V26.8B
    UMINP  V26.16B, V13.16B, V13.16B
    FMAXP H16, V26.2H
    UMINV  H26, V16.4H
    FMAXNM  V13.2S, V26.2S, V17.2S
    FMINP  V26.4S, V30.4S, V13.4S
    SMAX  V28.16B, V23.16B, V21.16B
    FMAXNMP  V14.8H, V18.8H, V22.8H
    FMINP D11, V27.2D
    UMAXV  B1, V28.8B
    FMINNMP D30, V28.2D
    FMAXV  S23, V12.4S
    SMINV  S24, V15.4S
    FMINNMV  H12, V5.8H
    FMINP  V16.2S, V9.2S, V11.2S
    FMAXNMV  H9, V31.4H
    FMINNMV  H2, V26.4H
    FMAXV  S5, V14.4S
    SMINV  S28, V1.4S
    FMAXP  V31.4H, V5.4H, V12.4H
    FMINNMP  V11.4H, V9.4H, V31.4H
    FMAXNMP H15, V23.2H
    FMAXNMP  V27.2S, V15.2S, V10.2S
    FMINP  V22.8H, V2.8H, V27.8H
    SMAX  V14.4S, V11.4S, V16.4S
    UMIN  V11.4H, V22.4H, V30.4H
    FMINNM  V18.4H, V24.4H, V24.4H
    SMAXP  V17.4H, V14.4H, V11.4H
    FMIN  V11.2D, V17.2D, V28.2D
    FMINNMV  H1, V11.4H
    FMINNMP H24, V27.2H
    FMAXNMV  H28, V24.4H
    FMINP D9, V18.2D
    FMINP D21, V28.2D
    UMAXP  V24.2S, V1.2S, V1.2S
    FMINNMP H12, V27.2H
    UMAXV  H25, V12.4H
    FMINV  S26, V25.4S
    FMINP  V23.4H, V2.4H, V21.4H
    FMINNMP H5, V9.2H
    FMINNMV  H18, V7.4H
    SMAXV  H31, V18.8H
    FMINP H11, V31.2H
    UMINV  H25, V24.8H
    FMAXNMP  V31.8H, V26.8H, V25.8H
    FMINP  V14.4H, V31.4H, V31.4H
    UMINV  S28, V14.4S
    SMINV  S12, V5.4S
    FMAXNMP S24, V25.2S
    FMINNMP S18, V23.2S
    FMINNMP D25, V11.2D
    FMINNM  V21.4H, V28.4H, V18.4H
    FMAXNMV  H7, V24.8H
    FMAX  V26.4H, V27.4H, V7.4H
    FMAXNMP S31, V12.2S
    UMINV  S9, V25.4S
    UMAXV  S5, V31.4S
    SMINV  H11, V5.4H
    UMAXV  S14, V21.4S
    FMIN  V24.2S, V14.2S, V14.2S
    FMAXNMP  V23.4S, V21.4S, V11.4S
    FMAXP H25, V26.2H
    SMAXV  H14, V23.4H
    FMINNMP  V11.4H, V9.4H, V25.4H
    SMAXV  B23, V11.8B
    FMINP  V12.2S, V24.2S, V2.2S
    SMAXV  S5, V14.4S
    FMINP  V31.4H, V5.4H, V5.4H
    FMIN  V11.4S, V23.4S, V23.4S
    FMAXP S5, V11.2S
    FMAXNMP  V14.8H, V12.8H, V31.8H
    UMAXP  V7.8H, V5.8H, V5.8H
    UMINV  B27, V14.8B
    FMINV  H24, V20.4H
    FMAXP  V23.4S, V7.4S, V27.4S
    SMAX  V25.8B, V24.8B, V23.8B
    FMAXP S11, V6.2S
    SMIN  V27.4S, V6.4S, V1.4S
    UMAXV  S31, V4.4S
    FMAXNMP H23, V5.2H
    FMIN  V2.8H, V14.8H, V2.8H
    UMAXP  V12.2S, V28.2S, V14.2S
    FMAXNM  V28.4H, V23.4H, V16.4H
    UMIN  V20.8B, V11.8B, V1.8B
    FMAX  V9.4H, V22.4H, V12.4H
    SMAXV  S7, V1.4S
    FMINNMP  V22.8H, V31.8H, V22.8H
    FMAXV  S1, V16.4S
    FMINNMP  V12.2D, V20.2D, V7.2D
    FMINP H23, V2.2H
    FMAXP D6, V28.2D
    FMINNMP H20, V12.2H
    FMIN  V31.8H, V25.8H, V27.8H
    FMINNMP S2, V6.2S
    FMINNMV  S25, V2.4S
    UMINV  B2, V17.8B
    FMINNMP  V11.2D, V20.2D, V9.2D
    FMINNMP D17, V22.2D
    FMINNMP  V24.2S, V1.2S, V31.2S
    FMAX  V12.2S, V10.2S, V17.2S
    UMAXV  S6, V11.4S
    FMAXP  V14.8H, V24.8H, V23.8H
    UMAXP  V17.4S, V15.4S, V31.4S
    FMINNMV  H24, V6.4H
    FMAXP  V20.2S, V24.2S, V2.2S
    UMINV  S22, V17.4S
    UMINV  H27, V20.8H
    SMAX  V11.8B, V25.8B, V25.8B
    SMAXV  H15, V11.4H
    SMAXV  S1, V24.4S
    UMAXV  B17, V14.8B
    UMINV  S28, V22.4S
    SMIN  V10.16B, V12.16B, V22.16B
    FMINP H7, V17.2H
    FMAXNMP  V16.4H, V28.4H, V1.4H
    FMINNMP H25, V16.2H
    UMAXV  B20, V25.8B
    FMAXNMP S1, V20.2S
    FMAXNMP  V14.4S, V10.4S, V27.4S
    FMINNMP  V27.8H, V7.8H, V14.8H
    SMAX  V11.4H, V1.4H, V15.4H
    UMAXV  S7, V11.4S
    SMINP  V6.4H, V27.4H, V27.4H
    SMAXV  B22, V7.16B
    SMAXV  B9, V22.8B
    FMINP  V28.4S, V6.4S, V26.4S
    FMINP H24, V28.2H
    SUBS  X24, X24, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_4
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x80, LSL #0
    MRS  X3, FPSR
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V0.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D0
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V1.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D1
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V2.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D2
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V3.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D3
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V4.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D4
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V5.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D5
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V6.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D6
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V7.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D7
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V8.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D8
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V9.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D9
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V10.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D10
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V11.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D11
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V12.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D12
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V13.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D13
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V14.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D14
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V15.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D15
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V16.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D16
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V17.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D17
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V18.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D18
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V19.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D19
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V20.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D20
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V21.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D21
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V22.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D22
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V23.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D23
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V24.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D24
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V25.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D25
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V26.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D26
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V27.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D27
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V28.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D28
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V29.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D29
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V30.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D30
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V31.D[1]
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D31
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
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
    FMOV  D0, X23
    FMOV  V0.D[1], X29
    FMOV  D1, X28
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X27
    FMOV  D3, X13
    FMOV  V3.D[1], X16
    FMOV  D4, X2
    FMOV  V4.D[1], X16
    FMOV  D5, X7
    FMOV  V5.D[1], X28
    FMOV  D6, X29
    FMOV  V6.D[1], X19
    FMOV  D7, X21
    FMOV  V7.D[1], X14
    FMOV  D8, X13
    FMOV  V8.D[1], X13
    FMOV  D9, X6
    FMOV  V9.D[1], X21
    FMOV  D10, X3
    FMOV  V10.D[1], X15
    FMOV  D11, X7
    FMOV  V11.D[1], X27
    FMOV  D12, X12
    FMOV  V12.D[1], X9
    FMOV  D13, X28
    FMOV  V13.D[1], X17
    FMOV  D14, X27
    FMOV  V14.D[1], X14
    FMOV  D15, X16
    FMOV  V15.D[1], X6
    FMOV  D16, X2
    FMOV  V16.D[1], X6
    FMOV  D17, X17
    FMOV  V17.D[1], X10
    FMOV  D18, X29
    FMOV  V18.D[1], X22
    FMOV  D19, X20
    FMOV  V19.D[1], X17
    FMOV  D20, X14
    FMOV  V20.D[1], X24
    FMOV  D21, X9
    FMOV  V21.D[1], X6
    FMOV  D22, X21
    FMOV  V22.D[1], X25
    FMOV  D23, X23
    FMOV  V23.D[1], X14
    FMOV  D24, X21
    FMOV  V24.D[1], X25
    FMOV  D25, X7
    FMOV  V25.D[1], X14
    FMOV  D26, X7
    FMOV  V26.D[1], X6
    FMOV  D27, X17
    FMOV  V27.D[1], X9
    FMOV  D28, X10
    FMOV  V28.D[1], X12
    FMOV  D29, X18
    FMOV  V29.D[1], X23
    FMOV  D30, X18
    FMOV  V30.D[1], X18
    FMOV  D31, X29
    FMOV  V31.D[1], X14
    MOVZ  X9, #0xf, LSL #0
TSRTAdvsimdVectorMaxMin_label_5:
    SMAX  V0.16B, V27.16B, V31.16B
    FMAXNMP S27, V28.2S
    FMAXP  V21.4H, V23.4H, V29.4H
    FMAXNMV  S18, V25.4S
    FMINV  H5, V24.4H
    FMAXNMP H18, V26.2H
    SMAXV  H2, V5.8H
    FMAXNMV  H3, V30.8H
    FMINNMV  S26, V21.4S
    FMAXNMP  V3.4H, V22.4H, V18.4H
    FMAXNMV  H22, V3.8H
    FMINNMP D13, V0.2D
    FMINNM  V21.4H, V26.4H, V27.4H
    FMINNMP S7, V13.2S
    UMAX  V22.8H, V7.8H, V7.8H
    UMINV  H29, V2.4H
    FMINP H24, V29.2H
    SMAXV  B25, V24.16B
    FMINNMP  V26.2S, V25.2S, V21.2S
    FMINP  V18.4H, V22.4H, V26.4H
    UMINP  V29.4S, V16.4S, V21.4S
    FMINP D22, V3.2D
    UMINV  B24, V22.8B
    SMAXV  H30, V23.8H
    FMINNMP D5, V31.2D
    FMINNM  V25.4H, V31.4H, V16.4H
    FMINNMV  S2, V11.4S
    FMAX  V23.8H, V9.8H, V3.8H
    FMINNMP  V3.4H, V9.4H, V30.4H
    UMAXV  B16, V20.16B
    FMINNMV  H22, V18.4H
    FMAXP D13, V23.2D
    FMIN  V30.4S, V24.4S, V29.4S
    SMINV  B9, V30.8B
    FMAXNM  V11.2D, V5.2D, V9.2D
    UMINV  S7, V2.4S
    SMINV  S18, V25.4S
    FMIN  V23.4S, V18.4S, V18.4S
    SMINP  V31.4H, V7.4H, V8.4H
    SMINV  B21, V11.16B
    FMAXP S0, V21.2S
    FMINP D11, V13.2D
    FMINNM  V13.4S, V11.4S, V16.4S
    FMAXP H16, V13.2H
    FMINV  S7, V23.4S
    FMINV  S21, V16.4S
    FMAXNM  V16.4S, V0.4S, V22.4S
    FMAXP D11, V16.2D
    SMIN  V0.4S, V28.4S, V3.4S
    FMINV  H23, V7.8H
    FMINP  V8.8H, V21.8H, V23.8H
    SMINV  B18, V8.16B
    FMIN  V30.8H, V0.8H, V18.8H
    FMINP  V7.4H, V11.4H, V11.4H
    UMINV  B16, V30.16B
    FMINNMP H25, V7.2H
    FMAXNMV  H28, V31.4H
    FMINNMP D22, V25.2D
    FMINP H13, V16.2H
    FMINV  H7, V13.8H
    FMINNM  V18.2S, V28.2S, V22.2S
    SMAXV  H24, V18.8H
    FMAXNMV  S3, V7.4S
    FMAXNMV  H22, V24.4H
    FMAXV  H8, V2.8H
    FMINNMV  S28, V8.4S
    FMAXP S16, V28.2S
    FMAXP  V6.2D, V4.2D, V3.2D
    UMAXP  V18.8H, V6.8H, V6.8H
    FMAXNMP  V0.4H, V16.4H, V18.4H
    FMAXP D11, V0.2D
    FMAXNMV  S21, V28.4S
    UMINV  H2, V11.4H
    FMINNMP  V0.4H, V2.4H, V21.4H
    UMINV  S18, V0.4S
    FMINNMP  V23.4S, V22.4S, V22.4S
    FMAXV  H28, V18.4H
    FMINNMP  V13.8H, V23.8H, V23.8H
    UMINV  B6, V13.16B
    FMAXNMV  H8, V6.8H
    SMINV  B30, V8.8B
    FMAXV  S0, V28.4S
    FMIN  V28.8H, V0.8H, V30.8H
    FMINV  H18, V9.8H
    SMINV  B13, V31.8B
    FMAXNMP  V30.2S, V26.2S, V20.2S
    FMINP D16, V21.2D
    FMINP  V23.2D, V25.2D, V18.2D
    FMINNMP D9, V28.2D
    FMAXNMP H11, V2.2H
    FMINNMP S31, V7.2S
    FMINNMV  S0, V18.4S
    FMAX  V8.4H, V21.4H, V12.4H
    FMINNMP  V7.4H, V13.4H, V11.4H
    FMAXNMP  V28.4H, V30.4H, V21.4H
    SMAXV  H2, V9.4H
    FMINNMV  H18, V28.8H
    FMINNMV  S13, V17.4S
    FMAXV  S9, V23.4S
    FMINNM  V20.8H, V18.8H, V16.8H
    FMAXP  V23.2D, V8.2D, V0.2D
    FMINP  V28.4S, V2.4S, V23.4S
    UMAX  V8.4S, V7.4S, V9.4S
    FMINNMP H9, V8.2H
    SMAXV  B12, V31.16B
    UMAXV  H16, V13.8H
    UMAXV  S26, V9.4S
    FMAXNMP D13, V12.2D
    UMAXV  B2, V28.16B
    FMINNMP  V23.8H, V16.8H, V26.8H
    FMIN  V16.4S, V20.4S, V20.4S
    UMIN  V0.4S, V13.4S, V13.4S
    FMINP D18, V14.2D
    UMINP  V9.16B, V18.16B, V18.16B
    FMAXP  V28.4H, V4.4H, V9.4H
    FMAXNMP H14, V2.2H
    FMAXP H18, V19.2H
    FMINNMP S19, V28.2S
    UMAXP  V26.4S, V23.4S, V0.4S
    SMIN  V8.16B, V14.16B, V14.16B
    FMAXNMP D20, V18.2D
    SMAXV  B13, V20.16B
    FMAXNMP D23, V8.2D
    FMINNMP  V4.8H, V23.8H, V19.8H
    FMAXNM  V31.8H, V16.8H, V4.8H
    FMAXNMP  V16.4H, V31.4H, V31.4H
    FMINNMP D2, V13.2D
    FMINP  V12.4H, V2.4H, V2.4H
    FMINP S19, V26.2S
    UMAXV  H26, V19.4H
    UMINV  S28, V26.4S
    FMAXNM  V2.8H, V11.8H, V28.8H
    FMIN  V0.8H, V16.8H, V2.8H
    FMAXP S26, V0.2S
    UMAXV  S31, V12.4S
    FMINV  S0, V26.4S
    FMINNMP  V28.8H, V0.8H, V0.8H
    UMINV  H16, V31.8H
    FMINNMP  V11.4S, V16.4S, V28.4S
    FMINV  S12, V12.4S
    FMAXV  S26, V12.4S
    FMAXNMP D14, V5.2D
    FMINNMP  V19.8H, V2.8H, V12.8H
    UMINV  S13, V11.4S
    FMAXNMP  V2.2D, V24.2D, V30.2D
    FMAXP  V24.4H, V11.4H, V6.4H
    FMAXP  V0.2D, V6.2D, V19.2D
    FMINV  H12, V27.4H
    FMINP  V6.2D, V22.2D, V28.2D
    FMINNMV  S4, V14.4S
    SMAXV  B31, V10.16B
    FMAXP  V22.2S, V31.2S, V2.2S
    FMAXNMP  V2.2S, V0.2S, V12.2S
    FMINV  H0, V26.4H
    FMINNMV  S12, V2.4S
    SMAXV  H31, V24.4H
    FMAXP D10, V6.2D
    UMINV  S30, V4.4S
    FMAXNMP D6, V13.2D
    FMAXP S26, V31.2S
    FMINP H16, V0.2H
    SMINV  H2, V22.4H
    UMINP  V28.2S, V10.2S, V0.2S
    FMINNMP  V0.8H, V26.8H, V30.8H
    FMAXV  H4, V16.4H
    UMAXV  B19, V28.8B
    FMINNM  V22.4H, V12.4H, V2.4H
    FMAXNM  V10.2D, V19.2D, V19.2D
    FMAXNMP  V14.4H, V0.4H, V3.4H
    FMAXV  S13, V10.4S
    FMINNM  V2.2D, V14.2D, V22.2D
    FMAX  V22.2D, V6.2D, V6.2D
    UMAX  V27.2S, V4.2S, V22.2S
    FMIN  V24.2S, V2.2S, V13.2S
    SMIN  V19.8H, V27.8H, V24.8H
    UMAXP  V12.8B, V10.8B, V1.8B
    SMAXV  H29, V29.8H
    UMAXP  V2.4H, V22.4H, V18.4H
    FMINNMP S6, V29.2S
    FMAX  V4.4S, V30.4S, V7.4S
    UMAX  V26.8B, V26.8B, V19.8B
    FMINNMP H3, V16.2H
    UMIN  V27.4H, V28.4H, V27.4H
    UMINV  B7, V14.8B
    FMINP S30, V24.2S
    FMAXNMP H0, V12.2H
    SMAX  V14.4S, V9.4S, V29.4S
    SMAX  V9.4H, V27.4H, V4.4H
    UMAXV  H19, V2.8H
    UMAXV  H2, V6.8H
    SMINV  H22, V26.4H
    SMIN  V13.4S, V22.4S, V0.4S
    SMINV  S18, V14.4S
    FMAXNMP D0, V3.2D
    FMAXP S10, V2.2S
    FMAXNMP S27, V7.2S
    SMINV  S16, V27.4S
    UMAXV  H1, V30.8H
    UMIN  V4.8B, V19.8B, V10.8B
    UMAXV  B26, V4.16B
    SUBS  X9, X9, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_5
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X5, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X5, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X5, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X5, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X5, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X5, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X5, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X5, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X5, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X5, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X5, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X5, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X5, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X5, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X5, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X5, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X5, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x80, LSL #0
    MRS  X5, FPSR
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V0.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D0
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V1.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D1
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V2.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D2
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V3.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D3
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V4.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D4
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V5.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D5
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V6.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D6
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V7.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D7
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V8.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D8
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V9.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D9
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V10.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D10
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V11.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D11
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V12.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D12
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V13.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D13
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V14.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D14
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    FMOV  X5, V15.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    FMOV  X5, D15
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V16.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D16
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    FMOV  X5, V17.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    FMOV  X5, D17
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V18.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D18
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V19.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0xffff, LSL #0
    FMOV  X5, D19
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V20.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D20
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V21.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D21
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V22.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D22
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V23.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D23
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V24.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D24
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V25.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D25
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V26.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D26
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V27.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D27
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V28.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D28
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V29.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D29
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V30.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D30
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V31.D[1]
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, D31
    SUB  X28, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xb35f, LSL #0
    MOVK  X2, #0xf475, LSL #16
    MOVK  X2, #0x2d9a, LSL #32
    MOVK  X2, #0x92e3, LSL #48
    MOVZ  X3, #0x1a3, LSL #0
    MOVK  X3, #0x7118, LSL #16
    MOVK  X3, #0xa213, LSL #32
    MOVK  X3, #0x4d0a, LSL #48
    MOVZ  X5, #0x4a17, LSL #0
    MOVK  X5, #0xfd33, LSL #16
    MOVK  X5, #0xa13d, LSL #32
    MOVK  X5, #0x4d45, LSL #48
    MOVZ  X6, #0xf92d, LSL #0
    MOVK  X6, #0xa72d, LSL #16
    MOVK  X6, #0x4465, LSL #32
    MOVK  X6, #0x461e, LSL #48
    MOVZ  X7, #0x6261, LSL #0
    MOVK  X7, #0x97a5, LSL #16
    MOVK  X7, #0xa649, LSL #32
    MOVK  X7, #0x1990, LSL #48
    MOVZ  X9, #0x8e31, LSL #0
    MOVK  X9, #0x4ace, LSL #16
    MOVK  X9, #0xa71b, LSL #32
    MOVK  X9, #0xde38, LSL #48
    MOVZ  X10, #0xbd18, LSL #0
    MOVK  X10, #0x800e, LSL #16
    MOVK  X10, #0xd7c7, LSL #32
    MOVK  X10, #0xc910, LSL #48
    MOVZ  X12, #0x10ba, LSL #0
    MOVK  X12, #0x2b41, LSL #16
    MOVK  X12, #0x6ebf, LSL #32
    MOVK  X12, #0xf360, LSL #48
    MOVZ  X13, #0x5328, LSL #0
    MOVK  X13, #0xbabd, LSL #16
    MOVK  X13, #0xf745, LSL #32
    MOVK  X13, #0x28c8, LSL #48
    MOVZ  X14, #0x208d, LSL #0
    MOVK  X14, #0x9fc8, LSL #16
    MOVK  X14, #0x8f9, LSL #32
    MOVK  X14, #0x9adc, LSL #48
    MOVZ  X15, #0x1fea, LSL #0
    MOVK  X15, #0xf80d, LSL #16
    MOVK  X15, #0xf158, LSL #32
    MOVK  X15, #0xb299, LSL #48
    MOVZ  X16, #0x9454, LSL #0
    MOVK  X16, #0xc887, LSL #16
    MOVK  X16, #0xd563, LSL #32
    MOVK  X16, #0xe70c, LSL #48
    MOVZ  X17, #0xcd77, LSL #0
    MOVK  X17, #0xcac0, LSL #16
    MOVK  X17, #0xd910, LSL #32
    MOVK  X17, #0x2236, LSL #48
    MOVZ  X18, #0x9dba, LSL #0
    MOVK  X18, #0xa21b, LSL #16
    MOVK  X18, #0xce46, LSL #32
    MOVK  X18, #0xe28b, LSL #48
    MOVZ  X19, #0x811c, LSL #0
    MOVK  X19, #0x7a3a, LSL #16
    MOVK  X19, #0x8161, LSL #32
    MOVK  X19, #0x4893, LSL #48
    MOVZ  X20, #0x24a7, LSL #0
    MOVK  X20, #0x4805, LSL #16
    MOVK  X20, #0x271d, LSL #32
    MOVK  X20, #0x7218, LSL #48
    MOVZ  X21, #0xc945, LSL #0
    MOVK  X21, #0xb7a8, LSL #16
    MOVK  X21, #0x78a3, LSL #32
    MOVK  X21, #0xdd85, LSL #48
    MOVZ  X22, #0x5323, LSL #0
    MOVK  X22, #0x6504, LSL #16
    MOVK  X22, #0x53c9, LSL #32
    MOVK  X22, #0x20a0, LSL #48
    MOVZ  X23, #0x9849, LSL #0
    MOVK  X23, #0xdbc4, LSL #16
    MOVK  X23, #0xf5e9, LSL #32
    MOVK  X23, #0x757c, LSL #48
    MOVZ  X24, #0xef1f, LSL #0
    MOVK  X24, #0xb9a2, LSL #16
    MOVK  X24, #0x1f7a, LSL #32
    MOVK  X24, #0x8136, LSL #48
    MOVZ  X25, #0xa3fc, LSL #0
    MOVK  X25, #0x4e57, LSL #16
    MOVK  X25, #0x4ff8, LSL #32
    MOVK  X25, #0x51b7, LSL #48
    MOVZ  X26, #0x79d7, LSL #0
    MOVK  X26, #0xe2f6, LSL #16
    MOVK  X26, #0xe4c8, LSL #32
    MOVK  X26, #0x348b, LSL #48
    MOVZ  X27, #0x5286, LSL #0
    MOVK  X27, #0x4695, LSL #16
    MOVK  X27, #0xce9f, LSL #32
    MOVK  X27, #0xa848, LSL #48
    MOVZ  X28, #0x9508, LSL #0
    MOVK  X28, #0x3240, LSL #16
    MOVK  X28, #0x2af5, LSL #32
    MOVK  X28, #0x2218, LSL #48
    MOVZ  X29, #0x7c9d, LSL #0
    MOVK  X29, #0xe5a7, LSL #16
    MOVK  X29, #0xd4ad, LSL #32
    MOVK  X29, #0x4aca, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X24
    FMOV  D1, X26
    FMOV  V1.D[1], X28
    FMOV  D2, X29
    FMOV  V2.D[1], X3
    FMOV  D3, X22
    FMOV  V3.D[1], X3
    FMOV  D4, X22
    FMOV  V4.D[1], X28
    FMOV  D5, X12
    FMOV  V5.D[1], X12
    FMOV  D6, X5
    FMOV  V6.D[1], X12
    FMOV  D7, X27
    FMOV  V7.D[1], X29
    FMOV  D8, X14
    FMOV  V8.D[1], X28
    FMOV  D9, X22
    FMOV  V9.D[1], X20
    FMOV  D10, X26
    FMOV  V10.D[1], X3
    FMOV  D11, X7
    FMOV  V11.D[1], X9
    FMOV  D12, X18
    FMOV  V12.D[1], X12
    FMOV  D13, X10
    FMOV  V13.D[1], X24
    FMOV  D14, X13
    FMOV  V14.D[1], X27
    FMOV  D15, X18
    FMOV  V15.D[1], X22
    FMOV  D16, X9
    FMOV  V16.D[1], X5
    FMOV  D17, X26
    FMOV  V17.D[1], X17
    FMOV  D18, X10
    FMOV  V18.D[1], X24
    FMOV  D19, X17
    FMOV  V19.D[1], X24
    FMOV  D20, X18
    FMOV  V20.D[1], X9
    FMOV  D21, X12
    FMOV  V21.D[1], X17
    FMOV  D22, X24
    FMOV  V22.D[1], X29
    FMOV  D23, X12
    FMOV  V23.D[1], X12
    FMOV  D24, X15
    FMOV  V24.D[1], X28
    FMOV  D25, X21
    FMOV  V25.D[1], X17
    FMOV  D26, X14
    FMOV  V26.D[1], X27
    FMOV  D27, X25
    FMOV  V27.D[1], X26
    FMOV  D28, X2
    FMOV  V28.D[1], X7
    FMOV  D29, X25
    FMOV  V29.D[1], X5
    FMOV  D30, X2
    FMOV  V30.D[1], X19
    FMOV  D31, X14
    FMOV  V31.D[1], X17
    MOVZ  X20, #0xf, LSL #0
TSRTAdvsimdVectorMaxMin_label_6:
    FMINNM  V30.2D, V31.2D, V22.2D
    SMINV  B0, V25.16B
    UMAXV  H16, V26.4H
    FMINP D31, V21.2D
    SMAX  V19.8H, V24.8H, V28.8H
    UMINV  H10, V29.4H
    UMAXV  B8, V30.8B
    FMIN  V20.4H, V23.4H, V10.4H
    FMINNMP  V0.4H, V8.4H, V27.4H
    FMINNMP D22, V0.2D
    FMAXP S23, V4.2S
    FMINNM  V8.2S, V23.2S, V31.2S
    UMAXP  V2.8H, V16.8H, V8.8H
    UMINV  H8, V2.4H
    FMINP S21, V19.2S
    UMAXV  H25, V20.4H
    FMINNMV  H20, V8.4H
    FMAXNM  V19.4S, V20.4S, V22.4S
    FMAXNM  V26.4S, V19.4S, V19.4S
    FMINNM  V27.4S, V21.4S, V21.4S
    FMINP  V21.2D, V27.2D, V26.2D
    SMAXP  V12.16B, V25.16B, V21.16B
    UMINP  V29.8B, V20.8B, V23.8B
    FMINNMV  H20, V28.4H
    FMAXNMP H10, V10.2H
    SMAXP  V22.8B, V14.8B, V25.8B
    FMAXNMV  S25, V2.4S
    FMAXP  V16.4H, V22.4H, V29.4H
    FMAXP  V26.8H, V31.8H, V8.8H
    FMINNM  V22.2D, V13.2D, V17.2D
    FMAX  V14.4S, V31.4S, V3.4S
    FMINV  S23, V17.4S
    UMAXV  H31, V10.8H
    UMAXV  S21, V31.4S
    FMAXNM  V19.2S, V14.2S, V21.2S
    FMINV  S28, V19.4S
    FMIN  V10.8H, V12.8H, V25.8H
    UMAXV  H25, V29.4H
    FMINP  V3.2S, V20.2S, V10.2S
    FMINP S4, V22.2S
    FMAXNMP D8, V12.2D
    FMIN  V17.4S, V8.4S, V3.4S
    FMAX  V31.2S, V16.2S, V25.2S
    FMINNMV  S13, V28.4S
    UMAXV  H29, V17.8H
    SMIN  V2.4S, V16.4S, V27.4S
    SMAXV  S21, V13.4S
    SMINV  H28, V23.8H
    FMAXP D10, V31.2D
    FMINNM  V17.4S, V4.4S, V10.4S
    UMAXV  B14, V29.16B
    FMINV  H21, V14.4H
    FMINNMP D1, V17.2D
    SMINV  S13, V2.4S
    SMINV  B16, V21.8B
    SMAXV  S22, V26.4S
    FMAXNMV  S2, V28.4S
    FMINNM  V19.2D, V4.2D, V22.2D
    FMAX  V12.4H, V1.4H, V19.4H
    SMAXV  H26, V12.8H
    FMINNM  V31.4H, V26.4H, V26.4H
    SMINV  H20, V9.4H
    FMINNMP H25, V16.2H
    UMAXV  B21, V2.8B
    FMAXNMP  V8.8H, V31.8H, V31.8H
    SMINV  S27, V8.4S
    FMAXNMP  V1.8H, V21.8H, V27.8H
    FMINNMV  S31, V25.4S
    FMINP S8, V13.2S
    UMAXP  V2.8H, V8.8H, V31.8H
    FMAXNMP  V14.8H, V17.8H, V20.8H
    SMINV  S26, V1.4S
    FMINV  H12, V25.4H
    SMINV  B19, V12.16B
    FMAXV  H9, V26.4H
    UMINV  H25, V9.4H
    FMAXNMP  V16.8H, V2.8H, V2.8H
    FMINNM  V29.4S, V14.4S, V19.4S
    FMAXP  V21.4S, V29.4S, V25.4S
    FMINNM  V13.4S, V21.4S, V23.4S
    FMAXNM  V23.2S, V13.2S, V16.2S
    FMINNMP S1, V19.2S
    FMINNMP D16, V3.2D
    UMINV  S21, V23.4S
    FMAXP S9, V20.2S
    FMAXNMP H29, V7.2H
    FMINNMV  S8, V10.4S
    SMINV  B19, V31.16B
    FMINNM  V23.2S, V28.2S, V30.2S
    SMINV  H25, V10.4H
    UMINP  V13.4S, V19.4S, V23.4S
    FMINNMP D3, V8.2D
    FMINNMP D20, V13.2D
    SMINV  H31, V20.4H
    FMINNM  V13.4S, V0.4S, V21.4S
    UMAXP  V21.2S, V3.2S, V31.2S
    FMAXNMV  S7, V29.4S
    SMINP  V30.16B, V25.16B, V1.16B
    SMAX  V31.4S, V30.4S, V9.4S
    UMINV  H28, V7.4H
    UMAXP  V7.2S, V13.2S, V13.2S
    FMAXNMP  V13.4H, V7.4H, V16.4H
    FMAXP D14, V28.2D
    FMINNMP H28, V20.2H
    SMAXV  S10, V13.4S
    UMINV  S20, V21.4S
    FMAXNMP  V2.4S, V10.4S, V1.4S
    FMINV  S8, V20.4S
    FMAXP  V23.2S, V8.2S, V28.2S
    FMINP D30, V14.2D
    UMINP  V0.8B, V30.8B, V31.8B
    UMAXV  B20, V2.16B
    FMIN  V16.8H, V20.8H, V0.8H
    FMINNMP S8, V23.2S
    FMINNMP S7, V16.2S
    UMINV  S13, V8.4S
    FMINNM  V3.2S, V7.2S, V13.2S
    SMAXV  H25, V1.4H
    FMINP D1, V26.2D
    FMAX  V2.2S, V24.2S, V11.2S
    SMINV  S20, V18.4S
    FMAXV  H10, V22.4H
    FMAXP  V30.4H, V29.4H, V25.4H
    FMINP  V23.4H, V5.4H, V19.4H
    UMAXV  B21, V11.16B
    SMAX  V22.16B, V19.16B, V20.16B
    FMAXV  S14, V29.4S
    FMINNMP  V9.2D, V22.2D, V3.2D
    FMAXNMP  V18.4H, V23.4H, V21.4H
    UMAXV  B23, V10.8B
    FMINP D16, V18.2D
    FMAXP S24, V30.2S
    FMAXNM  V28.2D, V23.2D, V23.2D
    FMAXP D11, V24.2D
    FMINNMP H31, V2.2H
    FMINNMP D0, V28.2D
    SMINV  S20, V0.4S
    FMIN  V18.4H, V14.4H, V20.4H
    FMINNM  V13.2D, V16.2D, V31.2D
    FMAXNMP H21, V13.2H
    FMINNMV  S10, V11.4S
    FMINNMV  H22, V9.4H
    UMIN  V14.2S, V18.2S, V1.2S
    FMAXP S3, V21.2S
    FMINNMP D20, V14.2D
    SMAXV  H31, V20.4H
    FMAX  V28.4H, V10.4H, V31.4H
    FMINP D13, V28.2D
    FMINV  S18, V7.4S
    UMIN  V10.2S, V22.2S, V18.2S
    SMIN  V28.8B, V13.8B, V10.8B
    FMINP S10, V3.2S
    FMINV  H7, V1.4H
    SMINP  V14.4S, V28.4S, V28.4S
    SMAXV  H18, V14.4H
    FMAXNM  V16.4S, V10.4S, V18.4S
    SMIN  V28.4H, V7.4H, V15.4H
    FMINNMP  V9.4H, V16.4H, V16.4H
    FMINP S11, V28.2S
    FMAXNMP D1, V11.2D
    FMAXNMP H16, V9.2H
    SMINV  H9, V1.8H
    FMINNMP  V23.2S, V16.2S, V9.2S
    SMINV  B31, V1.16B
    FMAXNMP H20, V18.2H
    SMAXP  V3.2S, V15.2S, V19.2S
    FMINNM  V13.4H, V12.4H, V18.4H
    SMINV  B14, V11.8B
    FMAXV  H28, V15.4H
    FMIN  V16.2S, V25.2S, V13.2S
    SMAXV  H15, V0.4H
    UMINP  V7.4H, V3.4H, V11.4H
    UMINV  H3, V28.4H
    FMINNMV  S9, V2.4S
    SMIN  V19.4H, V8.4H, V14.4H
    FMAXNMP  V22.4H, V20.4H, V16.4H
    FMAXNMV  H1, V9.4H
    UMAX  V10.4H, V23.4H, V22.4H
    FMINNMP  V9.2S, V31.2S, V31.2S
    FMAXP  V25.8H, V19.8H, V10.8H
    FMINP H2, V7.2H
    SMINV  S13, V25.4S
    FMINNMP  V7.2D, V2.2D, V13.2D
    SMIN  V25.8B, V15.8B, V7.8B
    FMAXP  V15.8H, V3.8H, V1.8H
    FMINP S31, V15.2S
    FMINNMV  H22, V9.8H
    FMAXNMV  H2, V22.4H
    FMAXNMP D1, V2.2D
    SMAXV  H8, V1.8H
    FMINV  H1, V31.8H
    SMAXV  H13, V14.8H
    UMINP  V20.8B, V8.8B, V1.8B
    FMAXP S31, V25.2S
    FMAXV  S2, V0.4S
    SMAX  V14.16B, V2.16B, V13.16B
    SMIN  V12.2S, V31.2S, V20.2S
    SMAXV  H22, V12.4H
    SMIN  V3.2S, V14.2S, V14.2S
    UMAXP  V13.2S, V3.2S, V22.2S
    SUBS  X20, X20, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_6
    MOVZ  X22, #0xb35f, LSL #0
    MOVK  X22, #0xf475, LSL #16
    MOVK  X22, #0x2d9a, LSL #32
    MOVK  X22, #0x92e3, LSL #48
    SUB  X17, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x1a3, LSL #0
    MOVK  X22, #0x7118, LSL #16
    MOVK  X22, #0xa213, LSL #32
    MOVK  X22, #0x4d0a, LSL #48
    SUB  X17, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x4a17, LSL #0
    MOVK  X22, #0xfd33, LSL #16
    MOVK  X22, #0xa13d, LSL #32
    MOVK  X22, #0x4d45, LSL #48
    SUB  X17, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0xf92d, LSL #0
    MOVK  X22, #0xa72d, LSL #16
    MOVK  X22, #0x4465, LSL #32
    MOVK  X22, #0x461e, LSL #48
    SUB  X17, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x6261, LSL #0
    MOVK  X22, #0x97a5, LSL #16
    MOVK  X22, #0xa649, LSL #32
    MOVK  X22, #0x1990, LSL #48
    SUB  X17, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x8e31, LSL #0
    MOVK  X22, #0x4ace, LSL #16
    MOVK  X22, #0xa71b, LSL #32
    MOVK  X22, #0xde38, LSL #48
    SUB  X17, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x10ba, LSL #0
    MOVK  X22, #0x2b41, LSL #16
    MOVK  X22, #0x6ebf, LSL #32
    MOVK  X22, #0xf360, LSL #48
    SUB  X17, X22, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x5328, LSL #0
    MOVK  X22, #0xbabd, LSL #16
    MOVK  X22, #0xf745, LSL #32
    MOVK  X22, #0x28c8, LSL #48
    SUB  X17, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x208d, LSL #0
    MOVK  X22, #0x9fc8, LSL #16
    MOVK  X22, #0x8f9, LSL #32
    MOVK  X22, #0x9adc, LSL #48
    SUB  X17, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x1fea, LSL #0
    MOVK  X22, #0xf80d, LSL #16
    MOVK  X22, #0xf158, LSL #32
    MOVK  X22, #0xb299, LSL #48
    SUB  X17, X22, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x9454, LSL #0
    MOVK  X22, #0xc887, LSL #16
    MOVK  X22, #0xd563, LSL #32
    MOVK  X22, #0xe70c, LSL #48
    SUB  X17, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x9dba, LSL #0
    MOVK  X22, #0xa21b, LSL #16
    MOVK  X22, #0xce46, LSL #32
    MOVK  X22, #0xe28b, LSL #48
    SUB  X17, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x811c, LSL #0
    MOVK  X22, #0x7a3a, LSL #16
    MOVK  X22, #0x8161, LSL #32
    MOVK  X22, #0x4893, LSL #48
    SUB  X17, X22, X19
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X17, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0xc945, LSL #0
    MOVK  X22, #0xb7a8, LSL #16
    MOVK  X22, #0x78a3, LSL #32
    MOVK  X22, #0xdd85, LSL #48
    SUB  X17, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x9849, LSL #0
    MOVK  X22, #0xdbc4, LSL #16
    MOVK  X22, #0xf5e9, LSL #32
    MOVK  X22, #0x757c, LSL #48
    SUB  X17, X22, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0xef1f, LSL #0
    MOVK  X22, #0xb9a2, LSL #16
    MOVK  X22, #0x1f7a, LSL #32
    MOVK  X22, #0x8136, LSL #48
    SUB  X17, X22, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0xa3fc, LSL #0
    MOVK  X22, #0x4e57, LSL #16
    MOVK  X22, #0x4ff8, LSL #32
    MOVK  X22, #0x51b7, LSL #48
    SUB  X17, X22, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x79d7, LSL #0
    MOVK  X22, #0xe2f6, LSL #16
    MOVK  X22, #0xe4c8, LSL #32
    MOVK  X22, #0x348b, LSL #48
    SUB  X17, X22, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x5286, LSL #0
    MOVK  X22, #0x4695, LSL #16
    MOVK  X22, #0xce9f, LSL #32
    MOVK  X22, #0xa848, LSL #48
    SUB  X17, X22, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x9508, LSL #0
    MOVK  X22, #0x3240, LSL #16
    MOVK  X22, #0x2af5, LSL #32
    MOVK  X22, #0x2218, LSL #48
    SUB  X17, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x7c9d, LSL #0
    MOVK  X22, #0xe5a7, LSL #16
    MOVK  X22, #0xd4ad, LSL #32
    MOVK  X22, #0x4aca, LSL #48
    SUB  X17, X22, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x80, LSL #0
    MRS  X17, FPSR
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V0.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D0
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V1.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D1
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V2.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D2
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V3.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D3
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V4.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D4
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x10ba, LSL #0
    MOVK  X22, #0x2b41, LSL #16
    MOVK  X22, #0x6ebf, LSL #32
    MOVK  X22, #0xf360, LSL #48
    FMOV  X17, V5.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x10ba, LSL #0
    MOVK  X22, #0x2b41, LSL #16
    MOVK  X22, #0x6ebf, LSL #32
    MOVK  X22, #0xf360, LSL #48
    FMOV  X17, D5
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x10ba, LSL #0
    MOVK  X22, #0x2b41, LSL #16
    MOVK  X22, #0x6ebf, LSL #32
    MOVK  X22, #0xf360, LSL #48
    FMOV  X17, V6.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x4a17, LSL #0
    MOVK  X22, #0xfd33, LSL #16
    MOVK  X22, #0xa13d, LSL #32
    MOVK  X22, #0x4d45, LSL #48
    FMOV  X17, D6
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V7.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D7
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V8.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D8
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V9.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D9
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V10.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D10
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V11.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D11
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V12.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D12
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V13.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D13
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V14.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D14
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V15.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D15
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V16.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D16
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V17.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D17
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V18.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D18
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V19.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D19
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V20.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D20
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V21.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D21
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V22.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D22
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V23.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D23
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V24.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D24
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V25.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D25
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V26.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D26
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V27.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D27
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V28.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D28
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V29.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D29
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V30.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D30
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V31.D[1]
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, D31
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
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
    FMOV  D0, X15
    FMOV  V0.D[1], X26
    FMOV  D1, X25
    FMOV  V1.D[1], X13
    FMOV  D2, X18
    FMOV  V2.D[1], X20
    FMOV  D3, X29
    FMOV  V3.D[1], X21
    FMOV  D4, X23
    FMOV  V4.D[1], X28
    FMOV  D5, X24
    FMOV  V5.D[1], X27
    FMOV  D6, X22
    FMOV  V6.D[1], X5
    FMOV  D7, X5
    FMOV  V7.D[1], X15
    FMOV  D8, X19
    FMOV  V8.D[1], X6
    FMOV  D9, X13
    FMOV  V9.D[1], X5
    FMOV  D10, X29
    FMOV  V10.D[1], X25
    FMOV  D11, X25
    FMOV  V11.D[1], X15
    FMOV  D12, X3
    FMOV  V12.D[1], X27
    FMOV  D13, X14
    FMOV  V13.D[1], X3
    FMOV  D14, X13
    FMOV  V14.D[1], X5
    FMOV  D15, X13
    FMOV  V15.D[1], X24
    FMOV  D16, X5
    FMOV  V16.D[1], X16
    FMOV  D17, X15
    FMOV  V17.D[1], X20
    FMOV  D18, X28
    FMOV  V18.D[1], X13
    FMOV  D19, X28
    FMOV  V19.D[1], X25
    FMOV  D20, X5
    FMOV  V20.D[1], X2
    FMOV  D21, X29
    FMOV  V21.D[1], X23
    FMOV  D22, X3
    FMOV  V22.D[1], X21
    FMOV  D23, X27
    FMOV  V23.D[1], X6
    FMOV  D24, X19
    FMOV  V24.D[1], X20
    FMOV  D25, X20
    FMOV  V25.D[1], X19
    FMOV  D26, X16
    FMOV  V26.D[1], X26
    FMOV  D27, X16
    FMOV  V27.D[1], X20
    FMOV  D28, X19
    FMOV  V28.D[1], X23
    FMOV  D29, X15
    FMOV  V29.D[1], X13
    FMOV  D30, X25
    FMOV  V30.D[1], X17
    FMOV  D31, X17
    FMOV  V31.D[1], X27
    MOVZ  X22, #0xf, LSL #0
TSRTAdvsimdVectorMaxMin_label_7:
    FMIN  V8.8H, V26.8H, V25.8H
    SMINV  B27, V20.16B
    FMINNMV  S0, V27.4S
    FMINNMP D9, V24.2D
    UMAXV  S15, V9.4S
    SMAXP  V26.8H, V15.8H, V29.8H
    SMINV  B14, V26.8B
    FMINP D23, V0.2D
    FMAXNM  V13.4S, V31.4S, V30.4S
    SMINV  H18, V22.8H
    FMAXV  S30, V31.4S
    FMAXNMP D19, V14.2D
    FMINNMP  V26.8H, V28.8H, V8.8H
    FMAX  V10.2D, V18.2D, V30.2D
    UMAXV  B22, V20.16B
    FMINNM  V15.2S, V26.2S, V19.2S
    SMAXV  S20, V13.4S
    UMAXP  V29.16B, V10.16B, V15.16B
    FMAX  V19.4H, V23.4H, V29.4H
    FMIN  V29.4H, V19.4H, V22.4H
    FMAXNM  V15.8H, V29.8H, V29.8H
    UMAXV  H10, V15.8H
    FMAXV  H28, V20.4H
    SMINV  S26, V28.4S
    FMINNMP  V0.4H, V10.4H, V10.4H
    FMINNMP  V14.8H, V26.8H, V0.8H
    FMAXNMV  S9, V2.4S
    FMINNMP  V15.8H, V15.8H, V1.8H
    FMAXNM  V2.8H, V10.8H, V5.8H
    FMAXP D18, V29.2D
    FMAXP  V8.4S, V12.4S, V20.4S
    SMINP  V5.4H, V10.4H, V11.4H
    FMAXP D20, V21.2D
    FMAX  V28.4H, V16.4H, V12.4H
    FMAXNMP H16, V18.2H
    SMINP  V22.16B, V14.16B, V20.16B
    FMAXNMP  V20.8H, V22.8H, V22.8H
    FMINNMP S26, V9.2S
    FMINP S13, V28.2S
    FMINP D0, V2.2D
    FMAXP H1, V0.2H
    FMINNMP H14, V16.2H
    FMINP D16, V26.2D
    FMINV  S0, V20.4S
    FMINNMP D26, V5.2D
    FMAXP D22, V26.2D
    FMIN  V23.2D, V22.2D, V2.2D
    UMAX  V21.4S, V15.4S, V23.4S
    SMIN  V29.16B, V14.16B, V0.16B
    SMAXV  S20, V21.4S
    SMIN  V26.2S, V29.2S, V1.2S
    FMAXNMP D15, V26.2D
    UMINV  H9, V20.4H
    FMINP S11, V13.2S
    FMINNMP  V22.4H, V11.4H, V11.4H
    FMAXP  V1.4H, V22.4H, V15.4H
    SMAX  V15.4S, V1.4S, V16.4S
    FMINNMP  V21.4H, V8.4H, V9.4H
    FMAXV  H29, V21.8H
    FMINP  V22.2S, V15.2S, V15.2S
    FMINV  H26, V29.4H
    FMAXNMP H13, V12.2H
    FMAXNMP  V8.8H, V22.8H, V13.8H
    FMINV  S11, V26.4S
    FMINP S29, V11.2S
    UMAXV  B20, V29.16B
    SMAXP  V0.8B, V20.8B, V8.8B
    FMINV  S15, V11.4S
    FMAXNMP S14, V4.2S
    SMAXV  B26, V30.16B
    FMAXNMP  V4.4S, V7.4S, V5.4S
    UMINV  H7, V2.8H
    SMAX  V2.4S, V1.4S, V18.4S
    FMINNM  V9.2D, V17.2D, V28.2D
    UMAX  V13.2S, V20.2S, V15.2S
    FMAXP  V5.8H, V16.8H, V3.8H
    FMAXNMP  V30.4S, V7.4S, V5.4S
    FMAXNMP S21, V30.2S
    FMAXNMP S1, V26.2S
    FMINNMP S18, V2.2S
    FMAX  V26.2D, V14.2D, V21.2D
    FMINP D17, V0.2D
    FMAXNMP H0, V9.2H
    FMAXP S22, V13.2S
    FMINNMP  V28.4H, V17.4H, V18.4H
    FMAXNMV  S2, V0.4S
    FMIN  V7.8H, V4.8H, V4.8H
    FMINNMP  V21.8H, V7.8H, V22.8H
    FMIN  V16.8H, V28.8H, V21.8H
    FMINP H30, V21.2H
    SMAX  V21.4H, V16.4H, V2.4H
    SMIN  V15.16B, V1.16B, V1.16B
    SMAX  V0.4S, V21.4S, V15.4S
    FMAXP S13, V26.2S
    FMAXV  S7, V29.4S
    FMAXNMP  V4.4S, V7.4S, V30.4S
    SMAX  V9.8H, V13.8H, V13.8H
    SMINP  V30.16B, V0.16B, V29.16B
    FMINNMP S18, V10.2S
    FMINP S5, V9.2S
    FMINNMP D9, V5.2D
    FMAXP H20, V9.2H
    FMINV  H2, V20.4H
    FMINP D22, V4.2D
    FMINNMP D17, V30.2D
    SMINP  V20.16B, V15.16B, V23.16B
    SMINP  V10.4H, V22.4H, V2.4H
    UMAXV  B30, V18.8B
    UMINP  V9.4H, V19.4H, V30.4H
    FMAXNMV  S29, V17.4S
    FMINV  S14, V29.4S
    SMAXP  V4.4S, V14.4S, V20.4S
    SMINP  V7.4H, V4.4H, V4.4H
    FMINP  V18.8H, V9.8H, V10.8H
    FMINP  V5.4H, V18.4H, V18.4H
    FMAXNM  V0.2S, V5.2S, V5.2S
    FMINNMV  H9, V7.4H
    FMINNMV  H30, V9.8H
    FMINV  S20, V0.4S
    FMINNMV  H15, V7.4H
    SMINP  V7.8H, V30.8H, V30.8H
    FMAXP  V17.2S, V20.2S, V7.2S
    FMAXNM  V22.2D, V10.2D, V15.2D
    FMINNMP  V2.4H, V22.4H, V22.4H
    UMAX  V13.8B, V17.8B, V17.8B
    FMINNMV  S14, V1.4S
    UMINP  V22.8H, V14.8H, V14.8H
    FMINP D29, V13.2D
    FMINNMP H13, V29.2H
    FMINP S15, V13.2S
    UMAXV  S30, V22.4S
    FMAXNMV  S22, V30.4S
    FMAXNMP  V1.2S, V22.2S, V25.2S
    FMINP S10, V15.2S
    UMAXP  V14.2S, V1.2S, V2.2S
    FMAXP S17, V10.2S
    UMAXV  H29, V17.8H
    SMINV  B10, V14.8B
    SMINP  V13.16B, V29.16B, V29.16B
    UMAXV  S20, V13.4S
    FMINP  V15.4H, V10.4H, V10.4H
    SMINV  S30, V15.4S
    FMINP S14, V30.2S
    FMAXNMV  S25, V15.4S
    FMAXP H22, V25.2H
    UMINP  V10.4S, V22.4S, V14.4S
    FMINP H1, V10.2H
    FMAXNMP S29, V1.2S
    FMAXNMP H13, V20.2H
    FMAXP S17, V13.2S
    FMINV  S25, V29.4S
    FMINNMP  V14.8H, V17.8H, V25.8H
    FMAXNMV  H22, V13.8H
    UMAX  V2.16B, V15.16B, V3.16B
    FMAXP  V25.4H, V22.4H, V23.4H
    SMAXV  H23, V29.8H
    UMAX  V10.8H, V6.8H, V14.8H
    UMAXV  S14, V25.4S
    FMINP  V20.2S, V0.2S, V3.2S
    SMAXP  V30.8B, V16.8B, V24.8B
    FMAXP  V16.8H, V25.8H, V31.8H
    FMIN  V25.4S, V19.4S, V23.4S
    UMINV  H19, V28.4H
    SMAXV  H3, V15.4H
    SMINP  V31.8B, V20.8B, V19.8B
    UMAXV  S20, V2.4S
    UMINV  S2, V30.4S
    FMAXNM  V17.8H, V10.8H, V2.8H
    FMAXP H29, V14.2H
    FMINNMP D23, V31.2D
    UMINP  V15.4S, V20.4S, V16.4S
    FMINP D19, V15.2D
    UMINV  B0, V25.16B
    FMINNMP  V14.8H, V19.8H, V3.8H
    FMINNMP D20, V23.2D
    SMIN  V3.8H, V20.8H, V4.8H
    SMAXV  S23, V17.4S
    UMAXP  V28.2S, V23.2S, V28.2S
    SMAXV  B17, V28.8B
    FMINNMP H30, V29.2H
    FMAXP  V15.2D, V30.2D, V30.2D
    FMAXNMP H28, V17.2H
    FMINV  H10, V11.4H
    FMINNMP D6, V28.2D
    UMINV  B28, V10.16B
    FMINP  V16.8H, V3.8H, V0.8H
    SMAX  V29.8B, V14.8B, V14.8B
    FMINNMP  V2.2D, V6.2D, V18.2D
    FMINNMP D14, V15.2D
    FMINP  V25.8H, V28.8H, V16.8H
    FMINP H15, V20.2H
    FMIN  V28.8H, V15.8H, V2.8H
    FMAXNMP D6, V14.2D
    SMINV  B10, V6.16B
    FMAXP  V14.8H, V10.8H, V28.8H
    FMAXNMV  H15, V25.8H
    FMAX  V3.8H, V14.8H, V15.8H
    SMINV  H2, V3.4H
    UMINV  B20, V2.8B
    FMINNMV  H3, V29.4H
    SUBS  X22, X22, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_7
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x80, LSL #0
    MRS  X15, FPSR
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V0.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D0
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V1.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D1
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V2.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D2
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V3.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D3
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V4.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D4
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V5.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D5
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V6.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D6
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V7.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D7
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V8.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D8
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V9.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D9
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V10.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D10
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V11.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D11
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V12.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D12
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V13.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D13
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V14.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D14
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V15.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D15
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V16.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D16
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V17.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D17
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V18.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D18
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V19.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D19
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V20.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D20
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V21.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D21
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V22.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D22
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V23.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D23
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V24.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D24
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V25.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D25
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V26.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D26
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V27.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D27
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V28.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D28
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V29.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D29
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V30.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D30
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V31.D[1]
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D31
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
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
    FMOV  V0.D[1], X27
    FMOV  D1, X25
    FMOV  V1.D[1], X29
    FMOV  D2, X28
    FMOV  V2.D[1], X23
    FMOV  D3, X26
    FMOV  V3.D[1], X24
    FMOV  D4, X14
    FMOV  V4.D[1], X24
    FMOV  D5, X21
    FMOV  V5.D[1], X10
    FMOV  D6, X15
    FMOV  V6.D[1], X7
    FMOV  D7, X18
    FMOV  V7.D[1], X10
    FMOV  D8, X13
    FMOV  V8.D[1], X16
    FMOV  D9, X29
    FMOV  V9.D[1], X26
    FMOV  D10, X6
    FMOV  V10.D[1], X16
    FMOV  D11, X22
    FMOV  V11.D[1], X3
    FMOV  D12, X16
    FMOV  V12.D[1], X13
    FMOV  D13, X18
    FMOV  V13.D[1], X7
    FMOV  D14, X7
    FMOV  V14.D[1], X21
    FMOV  D15, X25
    FMOV  V15.D[1], X2
    FMOV  D16, X10
    FMOV  V16.D[1], X5
    FMOV  D17, X14
    FMOV  V17.D[1], X17
    FMOV  D18, X14
    FMOV  V18.D[1], X2
    FMOV  D19, X28
    FMOV  V19.D[1], X27
    FMOV  D20, X28
    FMOV  V20.D[1], X14
    FMOV  D21, X22
    FMOV  V21.D[1], X9
    FMOV  D22, X12
    FMOV  V22.D[1], X27
    FMOV  D23, X6
    FMOV  V23.D[1], X15
    FMOV  D24, X10
    FMOV  V24.D[1], X9
    FMOV  D25, X2
    FMOV  V25.D[1], X20
    FMOV  D26, X14
    FMOV  V26.D[1], X3
    FMOV  D27, X21
    FMOV  V27.D[1], X5
    FMOV  D28, X5
    FMOV  V28.D[1], X25
    FMOV  D29, X17
    FMOV  V29.D[1], X26
    FMOV  D30, X16
    FMOV  V30.D[1], X23
    FMOV  D31, X20
    FMOV  V31.D[1], X6
    MOVZ  X25, #0xf, LSL #0
TSRTAdvsimdVectorMaxMin_label_8:
    FMAX  V25.2D, V27.2D, V26.2D
    FMINP S3, V25.2S
    SMINV  B13, V24.16B
    UMINP  V20.16B, V28.16B, V28.16B
    FMINV  S27, V3.4S
    FMINNMP  V29.4S, V30.4S, V20.4S
    FMIN  V3.4S, V13.4S, V27.4S
    FMAXP  V30.2D, V22.2D, V3.2D
    SMAXV  B0, V21.16B
    UMINV  B28, V31.16B
    UMIN  V0.8B, V29.8B, V28.8B
    FMAXNMP D15, V30.2D
    SMAXV  H16, V0.4H
    UMINP  V31.2S, V15.2S, V15.2S
    UMINV  S26, V31.4S
    SMAX  V20.4S, V16.4S, V26.4S
    FMINV  H26, V18.8H
    FMINP  V23.2S, V4.2S, V7.2S
    SMAXP  V29.8B, V28.8B, V29.8B
    FMAXNMP D25, V8.2D
    UMIN  V13.8B, V11.8B, V26.8B
    FMAXNMP  V28.4S, V26.4S, V22.4S
    UMAXV  H8, V4.4H
    UMAXV  B4, V22.8B
    UMINV  S21, V16.4S
    UMAX  V27.4H, V28.4H, V13.4H
    UMAXP  V16.2S, V25.2S, V8.2S
    UMIN  V31.4S, V4.4S, V21.4S
    SMAXV  S4, V20.4S
    SMIN  V8.2S, V4.2S, V16.2S
    UMAXV  B13, V23.8B
    SMAXV  S30, V8.4S
    UMAXV  S21, V30.4S
    FMINNMP  V25.2S, V31.2S, V27.2S
    FMINNM  V18.4S, V11.4S, V25.4S
    FMAXNMP H7, V29.2H
    SMAX  V0.16B, V7.16B, V13.16B
    UMINV  H4, V21.8H
    FMINP H16, V4.2H
    UMAXV  B11, V16.8B
    FMAXP H4, V6.2H
    FMAX  V7.8H, V18.8H, V11.8H
    UMAXV  B23, V4.8B
    FMINV  H11, V23.8H
    FMAXNMP  V4.8H, V0.8H, V0.8H
    SMINV  B26, V4.16B
    FMINP S4, V26.2S
    FMINP  V0.4H, V4.4H, V4.4H
    FMINV  S20, V0.4S
    SMAXV  H30, V11.4H
    FMINV  H26, V20.4H
    FMINV  S13, V7.4S
    FMINP  V0.2S, V30.2S, V13.2S
    FMAXNMV  S6, V0.4S
    FMAXP D18, V6.2D
    FMINP D16, V15.2D
    FMAXP H27, V26.2H
    FMAXP S7, V9.2S
    FMAXNM  V15.4S, V16.4S, V2.4S
    FMAXNMP H23, V18.2H
    FMINNMP  V30.4H, V23.4H, V27.4H
    FMAXP S0, V30.2S
    FMAXNMV  H6, V7.4H
    UMAXV  S18, V0.4S
    FMINNMP D30, V18.2D
    FMINNMP  V29.8H, V15.8H, V6.8H
    FMINP H13, V30.2H
    FMAXNMP S20, V29.2S
    UMAXV  H4, V20.8H
    SMINV  B15, V13.16B
    SMAX  V27.4H, V1.4H, V15.4H
    FMAXV  S29, V18.4S
    SMAXP  V1.16B, V4.16B, V29.16B
    SMINV  B16, V1.16B
    SMIN  V11.4H, V6.4H, V16.4H
    FMAXNM  V15.4S, V11.4S, V11.4S
    FMINNMP S1, V15.2S
    UMAX  V11.4S, V6.4S, V1.4S
    FMAXNMP H6, V11.2H
    FMINNM  V9.2D, V22.2D, V27.2D
    SMAX  V30.16B, V6.16B, V9.16B
    FMINNMP  V13.8H, V3.8H, V31.8H
    SMAX  V29.4S, V24.4S, V8.4S
    SMAXV  S22, V17.4S
    FMINNMP  V4.8H, V6.8H, V20.8H
    FMAXNMP  V20.4S, V28.4S, V26.4S
    SMINV  H2, V1.8H
    FMINP S9, V16.2S
    FMINP S18, V11.2S
    FMINP S27, V13.2S
    FMINNMP D6, V2.2D
    FMAXNMV  S15, V9.4S
    UMAXV  S1, V29.4S
    FMINNMV  H9, V18.4H
    FMAXNMP H31, V15.2H
    FMAXP S29, V1.2S
    FMAXP D24, V10.2D
    FMAXP S17, V9.2S
    SMAXV  H13, V24.4H
    FMINV  H15, V13.8H
    FMAXNMP  V18.8H, V31.8H, V30.8H
    FMAXNMV  S3, V18.4S
    UMAXV  S11, V15.4S
    FMAXNMV  S31, V20.4S
    UMIN  V28.8B, V4.8B, V22.8B
    FMAXNMP  V2.2D, V23.2D, V17.2D
    UMAXV  H26, V6.8H
    FMAX  V16.4H, V26.4H, V29.4H
    SMAXP  V15.8B, V16.8B, V27.8B
    FMINNMP H26, V3.2H
    SMAXV  S1, V28.4S
    SMAX  V9.4S, V2.4S, V15.4S
    UMAXV  S10, V11.4S
    SMIN  V3.4S, V26.4S, V31.4S
    FMAXNMV  S28, V3.4S
    FMINNMP H16, V18.2H
    FMAXNMP D15, V1.2D
    FMAXNMP  V6.4S, V10.4S, V9.4S
    FMAXNMV  H20, V15.8H
    FMINNMP  V24.2S, V20.2S, V20.2S
    FMAXP D11, V16.2D
    FMAXNMP S16, V28.2S
    UMAXV  S26, V16.4S
    FMAX  V20.2D, V24.2D, V26.2D
    FMAXNMV  S27, V6.4S
    UMINV  B30, V11.8B
    SMAXV  S2, V27.4S
    UMAXP  V26.16B, V8.16B, V20.16B
    UMINV  B27, V10.8B
    FMINNMV  H15, V30.4H
    UMINV  H1, V15.4H
    SMINV  S3, V1.4S
    FMAX  V9.8H, V3.8H, V2.8H
    FMIN  V18.2S, V9.2S, V9.2S
    SMAXP  V15.4S, V18.4S, V18.4S
    FMAXV  S10, V26.4S
    FMINP S8, V15.2S
    UMAX  V11.2S, V27.2S, V27.2S
    UMAX  V30.8H, V11.8H, V10.8H
    FMAXNMP S31, V16.2S
    UMAXP  V20.2S, V18.2S, V30.2S
    FMAXP S10, V31.2S
    FMAX  V27.2D, V10.2D, V21.2D
    SMINP  V26.4H, V20.4H, V27.4H
    SMAXV  S15, V8.4S
    SMINV  S8, V15.4S
    FMAXNM  V27.8H, V26.8H, V8.8H
    UMINV  H6, V1.4H
    FMAXNMP H31, V15.2H
    FMAXP S11, V26.2S
    FMINNMP S15, V19.2S
    FMIN  V9.4S, V18.4S, V21.4S
    FMINP S3, V31.2S
    FMINP D8, V31.2D
    UMAXV  B10, V26.16B
    FMINNMP S19, V17.2S
    FMAXNM  V20.8H, V11.8H, V27.8H
    SMIN  V18.8H, V15.8H, V11.8H
    FMIN  V2.8H, V10.8H, V6.8H
    UMAX  V1.4S, V9.4S, V2.4S
    FMINP  V11.2D, V8.2D, V1.2D
    FMINNMP  V30.4H, V11.4H, V18.4H
    SMINV  S15, V19.4S
    UMAXV  S21, V20.4S
    UMAXV  S16, V3.4S
    UMAX  V31.8H, V30.8H, V8.8H
    FMAXP D3, V21.2D
    FMAXNMP  V21.4S, V31.4S, V3.4S
    SMINV  S30, V21.4S
    FMIN  V3.4H, V30.4H, V16.4H
    SMAXV  B31, V15.16B
    FMINNMP D20, V3.2D
    UMAXP  V14.4H, V31.4H, V1.4H
    FMINV  S31, V20.4S
    FMAXNM  V11.8H, V14.8H, V14.8H
    FMINNM  V18.4H, V30.4H, V11.4H
    FMAXNMP  V15.4H, V18.4H, V18.4H
    SMINV  B11, V15.16B
    FMINNMP S30, V11.2S
    FMINP S19, V31.2S
    FMINP D21, V19.2D
    FMINV  S18, V30.4S
    SMAXV  B8, V5.8B
    UMIN  V31.4H, V1.4H, V18.4H
    FMAXP H1, V0.2H
    FMAXNMP H15, V8.2H
    FMAXP  V19.8H, V15.8H, V15.8H
    SMIN  V18.16B, V19.16B, V19.16B
    UMAX  V5.4H, V1.4H, V18.4H
    FMAX  V30.4H, V31.4H, V27.4H
    UMIN  V14.8B, V7.8B, V30.8B
    FMAXV  S0, V21.4S
    FMIN  V20.4H, V14.4H, V0.4H
    SMIN  V11.16B, V5.16B, V20.16B
    FMINV  S8, V1.4S
    FMAXV  S3, V2.4S
    FMINNMP  V16.4H, V14.4H, V19.4H
    FMINNMP S19, V13.2S
    FMINNMP D13, V10.2D
    UMAXV  H10, V12.8H
    SUBS  X25, X25, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_8
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X16, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X16, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X16, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X16, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X16, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X16, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X16, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X16, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X16, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X16, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X16, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X16, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X16, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X16, X9, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X16, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X16, X9, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X16, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X16, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X16, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X16, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x80, LSL #0
    MRS  X16, FPSR
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V0.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D0
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V1.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D1
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V2.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D2
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V3.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D3
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V4.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D4
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V5.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D5
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V6.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D6
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V7.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D7
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V8.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D8
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V9.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D9
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V10.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0xffff, LSL #0
    FMOV  X16, D10
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V11.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D11
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    FMOV  X16, V12.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    FMOV  X16, D12
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V13.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D13
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V14.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D14
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V15.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D15
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V16.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D16
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V17.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D17
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V18.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D18
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V19.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D19
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V20.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D20
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V21.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D21
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V22.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D22
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V23.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D23
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V24.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D24
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V25.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D25
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V26.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D26
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V27.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D27
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V28.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D28
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V29.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D29
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V30.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D30
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, V31.D[1]
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X16, D31
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x2327, LSL #0
    MOVK  X2, #0x5770, LSL #16
    MOVK  X2, #0xcc53, LSL #32
    MOVK  X2, #0x131b, LSL #48
    MOVZ  X3, #0xad02, LSL #0
    MOVK  X3, #0xfc15, LSL #16
    MOVK  X3, #0xb037, LSL #32
    MOVK  X3, #0x2d1d, LSL #48
    MOVZ  X5, #0x5451, LSL #0
    MOVK  X5, #0xe73f, LSL #16
    MOVK  X5, #0x7ecb, LSL #32
    MOVK  X5, #0x475e, LSL #48
    MOVZ  X6, #0x5530, LSL #0
    MOVK  X6, #0x9905, LSL #16
    MOVK  X6, #0x56db, LSL #32
    MOVK  X6, #0xfc6f, LSL #48
    MOVZ  X7, #0x2e65, LSL #0
    MOVK  X7, #0xb382, LSL #16
    MOVK  X7, #0x4c2a, LSL #32
    MOVK  X7, #0xf939, LSL #48
    MOVZ  X9, #0x4362, LSL #0
    MOVK  X9, #0xd5bc, LSL #16
    MOVK  X9, #0x686f, LSL #32
    MOVK  X9, #0xfd1f, LSL #48
    MOVZ  X10, #0x8d9a, LSL #0
    MOVK  X10, #0xe0c9, LSL #16
    MOVK  X10, #0xfcbf, LSL #32
    MOVK  X10, #0xebfa, LSL #48
    MOVZ  X12, #0x39b2, LSL #0
    MOVK  X12, #0x3d4e, LSL #16
    MOVK  X12, #0x2d19, LSL #32
    MOVK  X12, #0x1a2f, LSL #48
    MOVZ  X13, #0xef7f, LSL #0
    MOVK  X13, #0xbd4b, LSL #16
    MOVK  X13, #0xfd63, LSL #32
    MOVK  X13, #0xe836, LSL #48
    MOVZ  X14, #0x7a42, LSL #0
    MOVK  X14, #0xcdb, LSL #16
    MOVK  X14, #0x2a10, LSL #32
    MOVK  X14, #0x2c93, LSL #48
    MOVZ  X15, #0xd450, LSL #0
    MOVK  X15, #0x43e3, LSL #16
    MOVK  X15, #0x86e0, LSL #32
    MOVK  X15, #0x52f8, LSL #48
    MOVZ  X16, #0x24cf, LSL #0
    MOVK  X16, #0x8ee1, LSL #16
    MOVK  X16, #0x4235, LSL #32
    MOVK  X16, #0x71bc, LSL #48
    MOVZ  X17, #0x28a1, LSL #0
    MOVK  X17, #0xd0b2, LSL #16
    MOVK  X17, #0x9fea, LSL #32
    MOVK  X17, #0x838b, LSL #48
    MOVZ  X18, #0x1e80, LSL #0
    MOVK  X18, #0x241b, LSL #16
    MOVK  X18, #0x9a8d, LSL #32
    MOVK  X18, #0xfd02, LSL #48
    MOVZ  X19, #0x433c, LSL #0
    MOVK  X19, #0xe677, LSL #16
    MOVK  X19, #0xae5c, LSL #32
    MOVK  X19, #0xf038, LSL #48
    MOVZ  X20, #0x6239, LSL #0
    MOVK  X20, #0x834f, LSL #16
    MOVK  X20, #0x889a, LSL #32
    MOVK  X20, #0x18c9, LSL #48
    MOVZ  X21, #0xcc5e, LSL #0
    MOVK  X21, #0x4223, LSL #16
    MOVK  X21, #0xf6c, LSL #32
    MOVK  X21, #0x6e93, LSL #48
    MOVZ  X22, #0x1564, LSL #0
    MOVK  X22, #0x8b70, LSL #16
    MOVK  X22, #0xc2db, LSL #32
    MOVK  X22, #0xabf4, LSL #48
    MOVZ  X23, #0x3af9, LSL #0
    MOVK  X23, #0x6952, LSL #16
    MOVK  X23, #0xc0c6, LSL #32
    MOVK  X23, #0xa80d, LSL #48
    MOVZ  X24, #0xc49b, LSL #0
    MOVK  X24, #0x2b84, LSL #16
    MOVK  X24, #0x6ad2, LSL #32
    MOVK  X24, #0x80e7, LSL #48
    MOVZ  X25, #0x2ef8, LSL #0
    MOVK  X25, #0x6bc, LSL #16
    MOVK  X25, #0xc8f8, LSL #32
    MOVK  X25, #0x48c2, LSL #48
    MOVZ  X26, #0xb429, LSL #0
    MOVK  X26, #0xecfa, LSL #16
    MOVK  X26, #0x894c, LSL #32
    MOVK  X26, #0xced5, LSL #48
    MOVZ  X27, #0xf9f8, LSL #0
    MOVK  X27, #0x91b5, LSL #16
    MOVK  X27, #0xb893, LSL #32
    MOVK  X27, #0xa950, LSL #48
    MOVZ  X28, #0xc7b3, LSL #0
    MOVK  X28, #0x5916, LSL #16
    MOVK  X28, #0x490f, LSL #32
    MOVK  X28, #0x4cf2, LSL #48
    MOVZ  X29, #0x5bcb, LSL #0
    MOVK  X29, #0x45e4, LSL #16
    MOVK  X29, #0x8c17, LSL #32
    MOVK  X29, #0xaa3e, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X25
    FMOV  D1, X29
    FMOV  V1.D[1], X26
    FMOV  D2, X28
    FMOV  V2.D[1], X27
    FMOV  D3, X22
    FMOV  V3.D[1], X22
    FMOV  D4, X9
    FMOV  V4.D[1], X28
    FMOV  D5, X3
    FMOV  V5.D[1], X22
    FMOV  D6, X18
    FMOV  V6.D[1], X6
    FMOV  D7, X5
    FMOV  V7.D[1], X22
    FMOV  D8, X2
    FMOV  V8.D[1], X22
    FMOV  D9, X27
    FMOV  V9.D[1], X6
    FMOV  D10, X13
    FMOV  V10.D[1], X28
    FMOV  D11, X2
    FMOV  V11.D[1], X21
    FMOV  D12, X12
    FMOV  V12.D[1], X29
    FMOV  D13, X10
    FMOV  V13.D[1], X6
    FMOV  D14, X2
    FMOV  V14.D[1], X3
    FMOV  D15, X19
    FMOV  V15.D[1], X28
    FMOV  D16, X22
    FMOV  V16.D[1], X24
    FMOV  D17, X3
    FMOV  V17.D[1], X9
    FMOV  D18, X12
    FMOV  V18.D[1], X17
    FMOV  D19, X17
    FMOV  V19.D[1], X29
    FMOV  D20, X7
    FMOV  V20.D[1], X13
    FMOV  D21, X22
    FMOV  V21.D[1], X10
    FMOV  D22, X17
    FMOV  V22.D[1], X23
    FMOV  D23, X17
    FMOV  V23.D[1], X16
    FMOV  D24, X17
    FMOV  V24.D[1], X25
    FMOV  D25, X13
    FMOV  V25.D[1], X19
    FMOV  D26, X23
    FMOV  V26.D[1], X12
    FMOV  D27, X7
    FMOV  V27.D[1], X20
    FMOV  D28, X19
    FMOV  V28.D[1], X19
    FMOV  D29, X25
    FMOV  V29.D[1], X6
    FMOV  D30, X29
    FMOV  V30.D[1], X16
    FMOV  D31, X20
    FMOV  V31.D[1], X7
    MOVZ  X2, #0xf, LSL #0
TSRTAdvsimdVectorMaxMin_label_9:
    FMAXNMP H21, V22.2H
    FMINNMP  V13.2S, V25.2S, V26.2S
    UMINV  H7, V24.4H
    FMINNMP  V7.8H, V30.8H, V7.8H
    UMAXP  V15.8H, V7.8H, V13.8H
    FMINNMP D12, V20.2D
    FMAXNMP  V24.2D, V27.2D, V31.2D
    FMINNMP D23, V21.2D
    UMAX  V18.8H, V29.8H, V23.8H
    FMINNM  V20.4H, V18.4H, V24.4H
    FMINP S5, V28.2S
    UMAXV  S24, V12.4S
    UMAXV  S2, V17.4S
    FMINNM  V22.2D, V15.2D, V24.2D
    FMINNM  V7.2S, V22.2S, V22.2S
    FMIN  V21.8H, V7.8H, V7.8H
    FMAXNMP  V13.2D, V21.2D, V20.2D
    FMINNMP D20, V5.2D
    FMINNMP H26, V20.2H
    FMAXP  V22.8H, V2.8H, V13.8H
    FMINP  V17.2S, V22.2S, V1.2S
    FMINP  V12.4H, V17.4H, V30.4H
    FMINV  S17, V12.4S
    UMINV  S25, V26.4S
    FMAXP D12, V25.2D
    UMAX  V13.4H, V17.4H, V7.4H
    FMAXP D31, V13.2D
    FMINV  S5, V12.4S
    UMAXV  B24, V5.8B
    SMAX  V5.4S, V28.4S, V31.4S
    UMAXP  V15.4H, V24.4H, V24.4H
    FMAX  V31.8H, V15.8H, V13.8H
    FMINNMV  H24, V31.4H
    FMAXV  S27, V24.4S
    FMINV  H30, V5.4H
    SMINV  B22, V27.16B
    FMINV  S12, V22.4S
    UMAX  V28.4H, V12.4H, V30.4H
    UMINV  B13, V0.8B
    SMIN  V12.8H, V4.8H, V16.8H
    FMAX  V2.2D, V11.2D, V6.2D
    FMAXV  H27, V8.8H
    UMAXP  V17.2S, V29.2S, V16.2S
    UMAXV  B30, V19.16B
    UMINV  H22, V2.8H
    SMINV  S8, V1.4S
    SMAXV  B0, V19.8B
    UMIN  V26.8H, V17.8H, V27.8H
    UMIN  V5.8H, V13.8H, V28.8H
    FMINNMP  V15.2S, V5.2S, V0.2S
    SMINV  B4, V11.8B
    SMAXP  V11.4S, V15.4S, V4.4S
    FMAXNMP  V13.2D, V11.2D, V22.2D
    FMINNMP S4, V26.2S
    FMAXNMP S15, V30.2S
    FMINP D28, V4.2D
    FMINV  H2, V13.8H
    FMIN  V6.4H, V8.4H, V2.4H
    FMINNMP  V17.2D, V15.2D, V21.2D
    FMINP H16, V17.2H
    FMINNMP D19, V6.2D
    SMAXP  V6.8B, V16.8B, V12.8B
    FMAXV  H17, V19.4H
    FMAXNM  V19.4H, V28.4H, V28.4H
    FMAXP H2, V17.2H
    SMINV  B29, V2.16B
    FMAXV  S11, V6.4S
    SMAXP  V4.16B, V11.16B, V11.16B
    FMAXNMP H0, V19.2H
    UMAXV  B5, V4.16B
    FMAXP S12, V5.2S
    FMAXNM  V13.4H, V29.4H, V17.4H
    FMAXNMV  H30, V0.8H
    SMAXP  V16.8B, V12.8B, V12.8B
    FMIN  V11.2S, V16.2S, V12.2S
    FMAXNMV  H19, V20.4H
    UMIN  V4.4S, V11.4S, V13.4S
    FMINNMP H0, V4.2H
    UMAX  V11.16B, V0.16B, V0.16B
    FMAXV  H8, V19.4H
    FMINP  V4.4S, V8.4S, V8.4S
    FMAX  V28.2D, V20.2D, V30.2D
    FMINNM  V8.8H, V28.8H, V28.8H
    FMAXP H6, V11.2H
    FMAXP S5, V6.2S
    UMAXV  S11, V8.4S
    FMINNMV  S17, V4.4S
    SMIN  V13.2S, V11.2S, V17.2S
    FMINV  S19, V5.4S
    FMAXP S30, V19.2S
    FMINP H8, V30.2H
    FMINP H19, V13.2H
    FMAX  V4.2S, V19.2S, V19.2S
    FMAXNMP S0, V4.2S
    UMINV  S12, V8.4S
    FMAX  V8.4H, V0.4H, V0.4H
    SMINV  B11, V17.8B
    UMINV  H17, V11.8H
    UMINP  V5.16B, V8.16B, V17.16B
    FMIN  V30.4S, V12.4S, V5.4S
    FMINP  V0.2D, V16.2D, V9.2D
    SMAXV  H16, V9.4H
    FMAXNMP  V4.2D, V8.2D, V19.2D
    FMINNMP S13, V4.2S
    FMAXNMP S11, V12.2S
    SMINV  H12, V14.4H
    FMAXNM  V14.2D, V2.2D, V7.2D
    SMAXV  B5, V30.16B
    FMAXNMP  V4.4H, V14.4H, V0.4H
    FMAXV  S7, V10.4S
    SMINV  B19, V14.8B
    UMINV  H20, V3.4H
    FMAXP S9, V16.2S
    FMINP D17, V19.2D
    SMAXV  H6, V22.4H
    FMINNMV  H8, V7.4H
    SMAXV  H19, V9.8H
    FMINNMV  S22, V17.4S
    FMAXP  V16.2D, V22.2D, V6.2D
    FMINP H6, V19.2H
    FMINNMP S10, V16.2S
    UMAX  V14.8H, V11.8H, V8.8H
    SMINV  H1, V4.8H
    FMINNMV  S11, V10.4S
    UMINV  B20, V20.16B
    FMINP  V3.4H, V6.4H, V6.4H
    SMINV  H30, V13.8H
    FMAXNMV  H16, V14.4H
    FMAXNMV  S2, V1.4S
    FMAX  V10.2D, V11.2D, V20.2D
    FMAXP  V20.2D, V3.2D, V3.2D
    SMINV  H4, V10.8H
    FMIN  V13.2D, V4.2D, V4.2D
    FMINNMP  V0.8H, V13.8H, V30.8H
    FMINNMP  V10.2S, V20.2S, V2.2S
    FMAXP H4, V10.2H
    SMAX  V3.4H, V16.4H, V0.4H
    FMAXNMP H8, V4.2H
    SMINV  S19, V3.4S
    FMAXP  V6.4H, V19.4H, V8.4H
    SMINV  S14, V26.4S
    FMAXNMV  S13, V22.4S
    FMAXP  V11.8H, V9.8H, V15.8H
    FMAXNMP S2, V23.2S
    UMINV  H22, V20.8H
    FMAXV  S17, V11.4S
    FMINP  V3.2S, V26.2S, V13.2S
    UMAXP  V26.4S, V15.4S, V12.4S
    FMAXNMV  H1, V5.4H
    FMINP  V10.2D, V26.2D, V12.2D
    FMAX  V26.4H, V18.4H, V27.4H
    FMIN  V19.8H, V26.8H, V26.8H
    FMINP  V30.2D, V19.2D, V22.2D
    FMINNMV  H9, V1.4H
    FMINNM  V12.8H, V9.8H, V2.8H
    FMINNM  V23.2D, V3.2D, V28.2D
    SMINV  H4, V12.4H
    SMAXV  B0, V30.8B
    FMINNMP  V8.4S, V17.4S, V23.4S
    SMINP  V30.8B, V8.8B, V10.8B
    FMINNMP D27, V0.2D
    UMINV  S9, V30.4S
    FMAXNMV  H18, V4.8H
    FMINP  V30.8H, V27.8H, V27.8H
    FMAXNM  V26.2D, V30.2D, V18.2D
    FMAXNMP S5, V26.2S
    SMINP  V22.16B, V9.16B, V9.16B
    FMAXNMP S4, V22.2S
    FMAXNM  V9.4H, V4.4H, V5.4H
    FMAXV  H27, V9.8H
    FMAXP D18, V14.2D
    FMINNMP  V26.4H, V27.4H, V27.4H
    FMINV  S12, V26.4S
    FMAXNMP D22, V18.2D
    UMAXV  B28, V22.16B
    FMAXNMV  H0, V12.4H
    SMIN  V17.2S, V0.2S, V0.2S
    FMAXNM  V9.8H, V17.8H, V17.8H
    FMINNMP D3, V9.2D
    FMINP  V22.4S, V3.4S, V25.4S
    FMAXV  S27, V28.4S
    SMAXP  V2.4S, V22.4S, V22.4S
    SMAXV  S8, V2.4S
    SMAXP  V3.8H, V8.8H, V15.8H
    FMINP S30, V3.2S
    FMAXNM  V26.8H, V27.8H, V30.8H
    SMAX  V14.8B, V11.8B, V15.8B
    FMINP D0, V11.2D
    FMAXV  H9, V24.4H
    SMAXV  H17, V13.4H
    FMIN  V11.2S, V29.2S, V30.2S
    SMIN  V4.16B, V27.16B, V2.16B
    FMINP S13, V10.2S
    SMAXV  H18, V12.4H
    FMINNMP  V27.4H, V25.4H, V18.4H
    FMINV  H5, V26.4H
    FMINNMP D15, V9.2D
    SMAX  V10.8H, V4.8H, V4.8H
    FMAXNM  V21.2D, V15.2D, V14.2D
    FMINNMV  H13, V0.4H
    SUBS  X2, X2, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_9
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xad02, LSL #0
    MOVK  X16, #0xfc15, LSL #16
    MOVK  X16, #0xb037, LSL #32
    MOVK  X16, #0x2d1d, LSL #48
    SUB  X6, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x5451, LSL #0
    MOVK  X16, #0xe73f, LSL #16
    MOVK  X16, #0x7ecb, LSL #32
    MOVK  X16, #0x475e, LSL #48
    SUB  X6, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x2e65, LSL #0
    MOVK  X16, #0xb382, LSL #16
    MOVK  X16, #0x4c2a, LSL #32
    MOVK  X16, #0xf939, LSL #48
    SUB  X6, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x4362, LSL #0
    MOVK  X16, #0xd5bc, LSL #16
    MOVK  X16, #0x686f, LSL #32
    MOVK  X16, #0xfd1f, LSL #48
    SUB  X6, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x8d9a, LSL #0
    MOVK  X16, #0xe0c9, LSL #16
    MOVK  X16, #0xfcbf, LSL #32
    MOVK  X16, #0xebfa, LSL #48
    SUB  X6, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x39b2, LSL #0
    MOVK  X16, #0x3d4e, LSL #16
    MOVK  X16, #0x2d19, LSL #32
    MOVK  X16, #0x1a2f, LSL #48
    SUB  X6, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xef7f, LSL #0
    MOVK  X16, #0xbd4b, LSL #16
    MOVK  X16, #0xfd63, LSL #32
    MOVK  X16, #0xe836, LSL #48
    SUB  X6, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x7a42, LSL #0
    MOVK  X16, #0xcdb, LSL #16
    MOVK  X16, #0x2a10, LSL #32
    MOVK  X16, #0x2c93, LSL #48
    SUB  X6, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xd450, LSL #0
    MOVK  X16, #0x43e3, LSL #16
    MOVK  X16, #0x86e0, LSL #32
    MOVK  X16, #0x52f8, LSL #48
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x28a1, LSL #0
    MOVK  X16, #0xd0b2, LSL #16
    MOVK  X16, #0x9fea, LSL #32
    MOVK  X16, #0x838b, LSL #48
    SUB  X6, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x1e80, LSL #0
    MOVK  X16, #0x241b, LSL #16
    MOVK  X16, #0x9a8d, LSL #32
    MOVK  X16, #0xfd02, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x6239, LSL #0
    MOVK  X16, #0x834f, LSL #16
    MOVK  X16, #0x889a, LSL #32
    MOVK  X16, #0x18c9, LSL #48
    SUB  X6, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xcc5e, LSL #0
    MOVK  X16, #0x4223, LSL #16
    MOVK  X16, #0xf6c, LSL #32
    MOVK  X16, #0x6e93, LSL #48
    SUB  X6, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x1564, LSL #0
    MOVK  X16, #0x8b70, LSL #16
    MOVK  X16, #0xc2db, LSL #32
    MOVK  X16, #0xabf4, LSL #48
    SUB  X6, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x3af9, LSL #0
    MOVK  X16, #0x6952, LSL #16
    MOVK  X16, #0xc0c6, LSL #32
    MOVK  X16, #0xa80d, LSL #48
    SUB  X6, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xc49b, LSL #0
    MOVK  X16, #0x2b84, LSL #16
    MOVK  X16, #0x6ad2, LSL #32
    MOVK  X16, #0x80e7, LSL #48
    SUB  X6, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x2ef8, LSL #0
    MOVK  X16, #0x6bc, LSL #16
    MOVK  X16, #0xc8f8, LSL #32
    MOVK  X16, #0x48c2, LSL #48
    SUB  X6, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xb429, LSL #0
    MOVK  X16, #0xecfa, LSL #16
    MOVK  X16, #0x894c, LSL #32
    MOVK  X16, #0xced5, LSL #48
    SUB  X6, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xf9f8, LSL #0
    MOVK  X16, #0x91b5, LSL #16
    MOVK  X16, #0xb893, LSL #32
    MOVK  X16, #0xa950, LSL #48
    SUB  X6, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xc7b3, LSL #0
    MOVK  X16, #0x5916, LSL #16
    MOVK  X16, #0x490f, LSL #32
    MOVK  X16, #0x4cf2, LSL #48
    SUB  X6, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x5bcb, LSL #0
    MOVK  X16, #0x45e4, LSL #16
    MOVK  X16, #0x8c17, LSL #32
    MOVK  X16, #0xaa3e, LSL #48
    SUB  X6, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x81, LSL #0
    MRS  X6, FPSR
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V0.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D0
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V1.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D1
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V2.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D2
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V3.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D3
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V4.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D4
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V5.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D5
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V6.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D6
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V7.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D7
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V8.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D8
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V9.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D9
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V10.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D10
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V11.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D11
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V12.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D12
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V13.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D13
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V14.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D14
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V15.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D15
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V16.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D16
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V17.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D17
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V18.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D18
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V19.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D19
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V20.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D20
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V21.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D21
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V22.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D22
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V23.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D23
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V24.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D24
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V25.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D25
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V26.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D26
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V27.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D27
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V28.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D28
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V29.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D29
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V30.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D30
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V31.D[1]
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D31
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
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
    FMOV  D0, X25
    FMOV  V0.D[1], X2
    FMOV  D1, X20
    FMOV  V1.D[1], X16
    FMOV  D2, X18
    FMOV  V2.D[1], X22
    FMOV  D3, X29
    FMOV  V3.D[1], X24
    FMOV  D4, X19
    FMOV  V4.D[1], X21
    FMOV  D5, X15
    FMOV  V5.D[1], X27
    FMOV  D6, X28
    FMOV  V6.D[1], X26
    FMOV  D7, X19
    FMOV  V7.D[1], X24
    FMOV  D8, X22
    FMOV  V8.D[1], X17
    FMOV  D9, X16
    FMOV  V9.D[1], X13
    FMOV  D10, X24
    FMOV  V10.D[1], X14
    FMOV  D11, X25
    FMOV  V11.D[1], X2
    FMOV  D12, X10
    FMOV  V12.D[1], X3
    FMOV  D13, X18
    FMOV  V13.D[1], X16
    FMOV  D14, X7
    FMOV  V14.D[1], X19
    FMOV  D15, X25
    FMOV  V15.D[1], X13
    FMOV  D16, X23
    FMOV  V16.D[1], X29
    FMOV  D17, X22
    FMOV  V17.D[1], X18
    FMOV  D18, X7
    FMOV  V18.D[1], X12
    FMOV  D19, X28
    FMOV  V19.D[1], X3
    FMOV  D20, X13
    FMOV  V20.D[1], X26
    FMOV  D21, X12
    FMOV  V21.D[1], X10
    FMOV  D22, X24
    FMOV  V22.D[1], X12
    FMOV  D23, X17
    FMOV  V23.D[1], X26
    FMOV  D24, X16
    FMOV  V24.D[1], X22
    FMOV  D25, X28
    FMOV  V25.D[1], X9
    FMOV  D26, X19
    FMOV  V26.D[1], X24
    FMOV  D27, X23
    FMOV  V27.D[1], X13
    FMOV  D28, X29
    FMOV  V28.D[1], X23
    FMOV  D29, X22
    FMOV  V29.D[1], X21
    FMOV  D30, X26
    FMOV  V30.D[1], X19
    FMOV  D31, X22
    FMOV  V31.D[1], X19
    MOVZ  X29, #0xf, LSL #0
TSRTAdvsimdVectorMaxMin_label_10:
    SMIN  V31.4H, V29.4H, V29.4H
    FMINNMV  S8, V31.4S
    FMINV  S17, V27.4S
    UMINV  B28, V26.8B
    FMAXV  S30, V17.4S
    FMINNMP D16, V8.2D
    UMAXV  B6, V28.8B
    FMAXNMP  V28.2D, V6.2D, V30.2D
    FMAX  V23.2D, V28.2D, V28.2D
    SMINV  B25, V24.8B
    FMAXNMP H28, V25.2H
    FMAXP  V19.4H, V28.4H, V16.4H
    SMAXV  H17, V23.4H
    UMINV  S30, V19.4S
    FMAXP  V15.2D, V31.2D, V17.2D
    SMINP  V14.8B, V15.8B, V30.8B
    SMIN  V9.16B, V29.16B, V0.16B
    FMINV  S26, V18.4S
    FMINNMP D17, V20.2D
    UMINV  S0, V2.4S
    FMAXP H27, V30.2H
    UMIN  V15.4S, V21.4S, V8.4S
    FMINNMV  H31, V22.8H
    UMIN  V6.16B, V7.16B, V2.16B
    FMAXNM  V31.2S, V14.2S, V15.2S
    SMAX  V29.8B, V17.8B, V9.8B
    FMAXNMP  V15.2S, V14.2S, V26.2S
    SMAXV  H2, V0.8H
    FMINNM  V19.2D, V31.2D, V27.2D
    FMINNMP H16, V15.2H
    FMAXNM  V9.2S, V16.2S, V19.2S
    FMAXV  S30, V6.4S
    SMAX  V17.8B, V2.8B, V9.8B
    FMINP H7, V17.2H
    FMINP D8, V29.2D
    SMAXP  V18.4S, V30.4S, V30.4S
    FMINP D20, V7.2D
    FMAXNMP D25, V12.2D
    FMIN  V30.2D, V25.2D, V8.2D
    FMINP H9, V18.2H
    SMINP  V21.4H, V20.4H, V20.4H
    FMINNMP D25, V21.2D
    UMIN  V8.8B, V25.8B, V25.8B
    FMAX  V6.4S, V8.4S, V8.4S
    SMAXV  H26, V9.8H
    FMAXNMP S12, V30.2S
    UMAXV  H0, V6.4H
    FMINP H7, V26.2H
    FMINNM  V21.2D, V12.2D, V12.2D
    SMAXV  B29, V0.8B
    FMINP  V2.2S, V29.2S, V7.2S
    FMAXNMP H7, V21.2H
    UMAXV  S0, V2.4S
    FMINP  V21.4H, V7.4H, V18.4H
    SMIN  V8.4H, V21.4H, V21.4H
    FMINP  V16.4H, V8.4H, V8.4H
    FMINV  H2, V16.8H
    FMINP H18, V2.2H
    FMIN  V16.2D, V0.2D, V0.2D
    FMAXNMV  H2, V16.4H
    SMAXV  B25, V2.8B
    UMINV  B29, V25.8B
    FMINP  V17.4S, V29.4S, V18.4S
    FMINP  V8.4S, V16.4S, V5.4S
    UMINV  H16, V18.8H
    FMAXP  V7.2S, V7.2S, V21.2S
    FMINNMP  V12.2S, V16.2S, V28.2S
    FMINNMV  H26, V4.4H
    SMAXV  H4, V7.8H
    FMINNMV  S29, V14.4S
    SMIN  V16.8B, V30.8B, V27.8B
    FMINV  S14, V31.4S
    SMINV  S5, V6.4S
    FMAXNM  V25.4H, V5.4H, V16.4H
    FMAXV  H7, V26.4H
    UMAX  V0.4S, V17.4S, V17.4S
    FMAX  V17.8H, V14.8H, V0.8H
    SMINV  B28, V12.16B
    UMINV  B21, V7.8B
    FMINNMP  V2.8H, V28.8H, V25.8H
    FMAXP D27, V29.2D
    FMINP  V7.8H, V4.8H, V21.8H
    FMINV  H4, V8.4H
    SMIN  V30.2S, V27.2S, V17.2S
    FMINV  H28, V2.8H
    SMAXV  S21, V28.4S
    FMINNMV  H2, V7.4H
    FMIN  V14.2S, V30.2S, V21.2S
    FMINNMP D26, V4.2D
    SMAXV  B0, V28.8B
    FMAXP  V16.4S, V0.4S, V0.4S
    UMAXV  S4, V16.4S
    FMAXP  V25.4H, V2.4H, V4.4H
    FMAXP  V12.4S, V25.4S, V14.4S
    UMAXV  B8, V26.16B
    FMAX  V2.2S, V8.2S, V12.2S
    FMAXNMV  S27, V17.4S
    FMINP S21, V6.2S
    UMAXV  S16, V5.4S
    FMINNMP H25, V1.2H
    FMINNM  V28.4H, V15.4H, V13.4H
    FMAXP  V1.4S, V25.4S, V27.4S
    UMAXV  B14, V31.16B
    FMIN  V31.4S, V2.4S, V18.4S
    UMINV  S13, V17.4S
    FMAXNMV  S2, V16.4S
    FMAXV  H18, V14.8H
    FMAXNMP H30, V23.2H
    FMINP H15, V7.2H
    FMINNMP D17, V21.2D
    FMINP S7, V1.2S
    FMAXNM  V5.8H, V29.8H, V28.8H
    UMINV  H0, V13.8H
    FMAXNMP  V26.8H, V7.8H, V0.8H
    FMIN  V8.4H, V30.4H, V5.4H
    FMAXP  V21.8H, V2.8H, V8.8H
    SMINV  B25, V31.8B
    FMINNMP D1, V25.2D
    FMINNM  V14.2D, V18.2D, V18.2D
    UMIN  V7.8B, V14.8B, V14.8B
    FMAXNMV  H25, V17.8H
    FMAXNM  V12.8H, V21.8H, V6.8H
    FMAXNM  V27.4H, V25.4H, V26.4H
    SMINV  S5, V15.4S
    FMINNMP  V26.4H, V27.4H, V5.4H
    FMAXP  V27.8H, V26.8H, V26.8H
    SMIN  V16.2S, V7.2S, V27.2S
    UMINV  B5, V16.16B
    UMAX  V15.8B, V1.8B, V1.8B
    FMAXP  V21.4H, V3.4H, V15.4H
    UMAXV  H3, V5.8H
    FMINP H2, V3.2H
    FMAX  V15.4S, V12.4S, V21.4S
    UMAXV  B18, V15.8B
    FMAXNMV  H5, V18.8H
    FMINNMV  H12, V5.4H
    FMAXNMV  H18, V12.4H
    FMAXNMP H29, V2.2H
    UMINV  B26, V18.16B
    FMINNMV  H25, V26.8H
    UMAX  V27.16B, V29.16B, V25.16B
    SMINV  H8, V26.8H
    FMAXP  V21.4H, V0.4H, V29.4H
    SMAXV  H15, V28.4H
    SMINV  B25, V3.8B
    UMAXV  H17, V5.4H
    FMINV  H29, V4.4H
    UMINV  S18, V13.4S
    FMAXNMP S12, V4.2S
    SMINV  B5, V27.8B
    FMAXP  V26.8H, V18.8H, V8.8H
    SMINV  S4, V21.4S
    FMAXNMP H2, V15.2H
    FMINV  H0, V2.4H
    FMAXNMV  H28, V0.4H
    SMINV  B15, V4.16B
    UMINV  B3, V25.16B
    UMAXP  V25.8H, V12.8H, V3.8H
    FMINNMP  V27.8H, V17.8H, V15.8H
    UMINP  V0.4S, V25.4S, V28.4S
    FMAXP  V15.4H, V29.4H, V27.4H
    FMIN  V25.4H, V5.4H, V5.4H
    FMINNM  V3.2S, V0.2S, V0.2S
    UMAX  V2.4S, V26.4S, V26.4S
    FMAXP  V4.4H, V15.4H, V15.4H
    FMAXP H15, V25.2H
    SMINP  V21.8B, V3.8B, V11.8B
    FMAXNMV  S12, V11.4S
    UMIN  V8.2S, V12.2S, V12.2S
    UMINV  B13, V15.8B
    SMAXP  V15.8H, V21.8H, V2.8H
    FMINP H28, V15.2H
    FMIN  V18.8H, V5.8H, V4.8H
    SMAXV  B3, V18.16B
    UMAXV  S11, V28.4S
    SMIN  V17.4S, V11.4S, V3.4S
    FMINNMP H28, V13.2H
    FMINP  V15.8H, V28.8H, V28.8H
    FMAXNMV  S3, V15.4S
    FMAXP  V12.8H, V17.8H, V8.8H
    FMAXV  S25, V3.4S
    FMINP S11, V12.2S
    UMAXV  S12, V11.4S
    SMAXP  V5.4S, V25.4S, V25.4S
    FMAXP D13, V5.2D
    SMINV  S21, V12.4S
    FMAXV  S5, V21.4S
    SMAXV  H28, V13.4H
    FMINNMP D25, V28.2D
    FMAXP  V11.4S, V5.4S, V5.4S
    FMINP D0, V11.2D
    FMINNMV  S3, V25.4S
    FMAX  V8.8H, V3.8H, V3.8H
    FMAXNMP H17, V8.2H
    FMINV  H28, V0.4H
    SMAXV  S12, V28.4S
    FMAX  V15.8H, V12.8H, V17.8H
    FMINP  V8.4S, V12.4S, V30.4S
    UMIN  V4.8B, V5.8B, V3.8B
    SMAXV  H21, V3.8H
    SUBS  X29, X29, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_10
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x81, LSL #0
    MRS  X16, FPSR
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V0.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D0
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V1.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D1
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V2.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D2
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V3.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D3
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V4.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D4
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V5.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D5
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V6.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D6
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V7.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D7
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V8.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D8
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V9.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D9
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V10.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D10
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V11.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D11
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V12.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D12
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V13.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D13
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V14.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D14
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V15.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D15
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V16.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D16
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V17.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D17
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V18.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D18
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V19.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D19
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V20.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D20
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V21.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D21
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V22.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D22
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V23.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D23
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V24.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D24
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V25.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D25
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V26.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D26
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V27.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D27
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V28.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D28
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V29.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D29
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V30.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D30
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, V31.D[1]
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X16, D31
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
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
    FMOV  D0, X25
    FMOV  V0.D[1], X26
    FMOV  D1, X27
    FMOV  V1.D[1], X29
    FMOV  D2, X28
    FMOV  V2.D[1], X15
    FMOV  D3, X9
    FMOV  V3.D[1], X19
    FMOV  D4, X18
    FMOV  V4.D[1], X29
    FMOV  D5, X7
    FMOV  V5.D[1], X23
    FMOV  D6, X18
    FMOV  V6.D[1], X5
    FMOV  D7, X6
    FMOV  V7.D[1], X29
    FMOV  D8, X16
    FMOV  V8.D[1], X7
    FMOV  D9, X9
    FMOV  V9.D[1], X12
    FMOV  D10, X23
    FMOV  V10.D[1], X3
    FMOV  D11, X22
    FMOV  V11.D[1], X14
    FMOV  D12, X21
    FMOV  V12.D[1], X21
    FMOV  D13, X10
    FMOV  V13.D[1], X7
    FMOV  D14, X18
    FMOV  V14.D[1], X25
    FMOV  D15, X16
    FMOV  V15.D[1], X2
    FMOV  D16, X20
    FMOV  V16.D[1], X25
    FMOV  D17, X21
    FMOV  V17.D[1], X19
    FMOV  D18, X25
    FMOV  V18.D[1], X9
    FMOV  D19, X23
    FMOV  V19.D[1], X19
    FMOV  D20, X21
    FMOV  V20.D[1], X25
    FMOV  D21, X9
    FMOV  V21.D[1], X27
    FMOV  D22, X5
    FMOV  V22.D[1], X28
    FMOV  D23, X3
    FMOV  V23.D[1], X19
    FMOV  D24, X21
    FMOV  V24.D[1], X6
    FMOV  D25, X17
    FMOV  V25.D[1], X29
    FMOV  D26, X25
    FMOV  V26.D[1], X27
    FMOV  D27, X17
    FMOV  V27.D[1], X13
    FMOV  D28, X6
    FMOV  V28.D[1], X16
    FMOV  D29, X23
    FMOV  V29.D[1], X23
    FMOV  D30, X19
    FMOV  V30.D[1], X28
    FMOV  D31, X21
    FMOV  V31.D[1], X17
    MOVZ  X22, #0xf, LSL #0
TSRTAdvsimdVectorMaxMin_label_11:
    SMAXV  H12, V29.8H
    FMINNMP H4, V27.2H
    FMAXNM  V31.8H, V4.8H, V30.8H
    SMINV  B28, V24.16B
    SMAXP  V29.8B, V12.8B, V26.8B
    FMAXP S9, V31.2S
    SMAXV  H25, V28.8H
    FMAXNM  V31.8H, V9.8H, V25.8H
    FMAXNMP H22, V29.2H
    FMINV  S9, V22.4S
    FMAXNMV  H25, V9.8H
    UMAXV  H10, V23.4H
    FMINV  H22, V31.8H
    FMAXNM  V14.4H, V10.4H, V22.4H
    UMIN  V26.16B, V14.16B, V25.16B
    FMINP H14, V25.2H
    FMINNMP H10, V7.2H
    FMINNMV  H19, V18.4H
    FMINNM  V7.2S, V23.2S, V24.2S
    FMAXNMP  V22.2D, V17.2D, V16.2D
    FMAXNMP  V8.2S, V11.2S, V0.2S
    SMAXV  S30, V10.4S
    FMINP H17, V21.2H
    FMAXP  V4.2D, V7.2D, V23.2D
    UMINV  B16, V30.8B
    FMAXP S25, V8.2S
    UMAXV  H18, V10.4H
    SMAXV  S24, V19.4S
    FMAXP H30, V22.2H
    FMINNM  V11.8H, V24.8H, V17.8H
    FMAXP S31, V3.2S
    UMINV  B17, V14.8B
    FMINNMP  V22.2D, V30.2D, V16.2D
    FMIN  V24.4H, V4.4H, V4.4H
    FMAXP S4, V26.2S
    FMINNMP S26, V11.2S
    FMAXNMP H11, V25.2H
    FMAXV  S0, V31.4S
    FMAXNMV  H7, V0.8H
    SMINP  V0.16B, V11.16B, V17.16B
    SMAX  V14.4S, V26.4S, V4.4S
    UMAXV  B19, V18.8B
    FMINP S10, V22.2S
    UMAXV  H30, V0.8H
    FMAXV  H8, V14.4H
    FMAXV  S25, V24.4S
    FMAXNM  V26.8H, V25.8H, V8.8H
    UMAXV  H0, V7.4H
    SMAXP  V7.2S, V0.2S, V19.2S
    SMINP  V19.4H, V30.4H, V30.4H
    SMAXP  V4.4H, V10.4H, V7.4H
    UMINV  H7, V13.8H
    FMAXNMV  S31, V7.4S
    FMIN  V14.8H, V26.8H, V19.8H
    FMAXNMP H11, V31.2H
    FMIN  V24.4H, V14.4H, V11.4H
    UMAXV  B31, V4.16B
    FMAXNM  V25.8H, V20.8H, V31.8H
    UMAXP  V19.8B, V24.8B, V25.8B
    FMINV  S18, V7.4S
    UMAX  V8.4S, V24.4S, V14.4S
    FMAXP H14, V31.2H
    SMINV  S30, V26.4S
    FMAX  V13.4H, V21.4H, V23.4H
    UMAX  V23.8B, V5.8B, V4.8B
    FMAX  V24.8H, V2.8H, V20.8H
    UMAXV  H17, V0.4H
    UMINP  V20.16B, V17.16B, V19.16B
    FMINV  S0, V24.4S
    SMINV  S4, V1.4S
    FMIN  V10.8H, V13.8H, V4.8H
    FMINP S21, V8.2S
    FMAXV  H7, V14.4H
    FMINNMP S11, V30.2S
    SMIN  V14.8B, V11.8B, V0.8B
    FMINV  H11, V10.4H
    FMINP  V8.4H, V21.4H, V20.4H
    FMINNM  V2.4H, V11.4H, V23.4H
    UMAXV  S17, V21.4S
    FMINNMV  H20, V7.8H
    SMAXV  S5, V14.4S
    FMINNMP S24, V20.2S
    FMINP  V7.4H, V24.4H, V8.4H
    SMAXV  S4, V18.4S
    FMAXNMV  S18, V5.4S
    FMAXNMP  V23.4H, V17.4H, V17.4H
    FMINP  V21.2D, V18.2D, V7.2D
    FMAXP  V13.2S, V2.2S, V15.2S
    FMINNMV  H1, V13.8H
    UMAXV  S15, V1.4S
    FMAXNM  V10.2D, V23.2D, V15.2D
    FMAX  V14.4H, V21.4H, V10.4H
    FMAXP D11, V14.2D
    FMINNMP  V0.2S, V11.2S, V4.2S
    FMAXNMP D20, V7.2D
    FMINP D5, V30.2D
    UMAXV  B17, V5.8B
    FMAXV  S2, V10.4S
    FMAXNM  V10.2S, V0.2S, V1.2S
    SMAXV  H7, V21.4H
    SMAX  V15.8B, V5.8B, V12.8B
    FMINP D8, V26.2D
    FMINP D0, V7.2D
    UMAXV  S5, V6.4S
    UMINV  B1, V10.16B
    SMINV  H6, V13.8H
    FMAXNMV  S10, V20.4S
    FMAXP S12, V17.2S
    FMINP  V14.2S, V27.2S, V12.2S
    FMAXNM  V23.2D, V2.2D, V1.2D
    FMAXP D17, V0.2D
    UMAX  V21.4H, V8.4H, V8.4H
    UMAX  V11.4S, V15.4S, V5.4S
    FMAXV  S13, V23.4S
    FMAXV  H4, V6.4H
    SMINV  H1, V4.4H
    UMINV  S15, V13.4S
    SMAXV  H30, V11.4H
    FMAXNMP D4, V30.2D
    FMIN  V23.2S, V1.2S, V10.2S
    SMINP  V8.4S, V15.4S, V23.4S
    FMAXNMV  S26, V8.4S
    UMAXV  S30, V26.4S
    FMINNMP  V7.2S, V21.2S, V21.2S
    FMINV  H6, V4.8H
    FMAXP H13, V14.2H
    FMAXNMP H5, V30.2H
    FMAXNMP D1, V7.2D
    UMINV  H20, V13.8H
    FMINP D7, V13.2D
    FMINNMP S30, V17.2S
    UMAXP  V11.8H, V6.8H, V7.8H
    FMINP  V12.4S, V21.4S, V20.4S
    FMAXNMV  S10, V5.4S
    FMINNM  V5.2D, V10.2D, V30.2D
    FMAXNMP  V13.4H, V1.4H, V12.4H
    FMINNMP H1, V10.2H
    FMAX  V26.8H, V11.8H, V11.8H
    SMINV  S23, V5.4S
    FMINV  S15, V26.4S
    FMAXNM  V30.4S, V1.4S, V15.4S
    FMAXV  S25, V23.4S
    FMAX  V11.2S, V25.2S, V25.2S
    SMAXV  S8, V9.4S
    FMINV  H17, V13.4H
    FMAXV  S12, V24.4S
    FMAXP D25, V12.2D
    UMAXV  B5, V30.8B
    FMINNMV  S10, V5.4S
    FMAXNMP D26, V10.2D
    FMAXV  H23, V26.8H
    FMINNMP H7, V23.2H
    FMAXP S20, V17.2S
    UMIN  V17.8B, V11.8B, V25.8B
    FMAXNMP  V9.8H, V20.8H, V8.8H
    SMAXV  B13, V7.8B
    FMINNMP S11, V2.2S
    FMAXNMP  V10.2S, V17.2S, V17.2S
    FMAXP  V24.8H, V9.8H, V10.8H
    FMINNMV  H30, V11.4H
    FMINP  V6.2S, V13.2S, V13.2S
    FMAXNMV  S26, V6.4S
    UMAXV  B8, V1.16B
    UMINV  B23, V26.16B
    FMINNMV  S26, V23.4S
    FMAXNMP H13, V30.2H
    FMAXNM  V23.4S, V8.4S, V13.4S
    SMINV  B15, V23.16B
    FMINP D25, V26.2D
    UMAX  V10.16B, V25.16B, V24.16B
    FMINP  V13.2S, V15.2S, V10.2S
    FMAXNMV  H1, V11.8H
    FMINP  V30.2S, V26.2S, V25.2S
    FMIN  V23.4H, V30.4H, V5.4H
    FMAXV  S9, V14.4S
    FMINP D24, V3.2D
    FMINNMP D15, V12.2D
    SMINV  H25, V4.8H
    UMINV  H5, V0.4H
    UMAXV  S12, V25.4S
    SMAXV  B26, V8.16B
    SMAXV  B10, V12.16B
    FMAXNMP  V4.4S, V5.4S, V24.4S
    SMINV  S11, V13.4S
    UMINP  V24.8B, V7.8B, V1.8B
    FMINNM  V14.4H, V10.4H, V4.4H
    FMINNMV  H8, V24.4H
    UMINV  B30, V26.16B
    UMINV  H26, V30.4H
    FMINNMV  H24, V23.4H
    FMINP D0, V24.2D
    FMINV  H12, V9.4H
    FMAXNMP  V30.2S, V14.2S, V12.2S
    FMINNMP  V23.2S, V15.2S, V11.2S
    FMINNMP S24, V0.2S
    FMAXNMP S0, V23.2S
    FMAXP S12, V24.2S
    FMAXNMP H14, V26.2H
    UMAXV  H26, V14.4H
    FMAXP D24, V26.2D
    SUBS  X22, X22, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_11
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x81, LSL #0
    MRS  X19, FPSR
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V0.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D0
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V1.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D1
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V2.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D2
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X19, V3.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X19, D3
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    FMOV  X19, V4.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D4
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V5.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D5
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V6.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D6
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V7.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D7
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V8.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D8
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V9.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    FMOV  X19, D9
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V10.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D10
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V11.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D11
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V12.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D12
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V13.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D13
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V14.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D14
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V15.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D15
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V16.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D16
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V17.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D17
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V18.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D18
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V19.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D19
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V20.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D20
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V21.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D21
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V22.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D22
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V23.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D23
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V24.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D24
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V25.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D25
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V26.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D26
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X19, V27.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X19, D27
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V28.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D28
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V29.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D29
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V30.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D30
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, V31.D[1]
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X19, D31
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x2b3d, LSL #0
    MOVK  X2, #0x4fb, LSL #16
    MOVK  X2, #0xa148, LSL #32
    MOVK  X2, #0x577c, LSL #48
    MOVZ  X3, #0x38f3, LSL #0
    MOVK  X3, #0x6744, LSL #16
    MOVK  X3, #0x3144, LSL #32
    MOVK  X3, #0x555e, LSL #48
    MOVZ  X5, #0x7e5f, LSL #0
    MOVK  X5, #0x207e, LSL #16
    MOVK  X5, #0x1f55, LSL #32
    MOVK  X5, #0x4237, LSL #48
    MOVZ  X6, #0xe215, LSL #0
    MOVK  X6, #0xf144, LSL #16
    MOVK  X6, #0x8120, LSL #32
    MOVK  X6, #0xdda7, LSL #48
    MOVZ  X7, #0x2e61, LSL #0
    MOVK  X7, #0x55b8, LSL #16
    MOVK  X7, #0x9027, LSL #32
    MOVK  X7, #0x8a84, LSL #48
    MOVZ  X9, #0x59f0, LSL #0
    MOVK  X9, #0x3874, LSL #16
    MOVK  X9, #0xa6a5, LSL #32
    MOVK  X9, #0xc7f6, LSL #48
    MOVZ  X10, #0xf598, LSL #0
    MOVK  X10, #0xe68d, LSL #16
    MOVK  X10, #0xb96f, LSL #32
    MOVK  X10, #0xca21, LSL #48
    MOVZ  X12, #0xb0bd, LSL #0
    MOVK  X12, #0x3860, LSL #16
    MOVK  X12, #0x84f1, LSL #32
    MOVK  X12, #0xd790, LSL #48
    MOVZ  X13, #0xbb8d, LSL #0
    MOVK  X13, #0x78d2, LSL #16
    MOVK  X13, #0x1f4c, LSL #32
    MOVK  X13, #0xb8ef, LSL #48
    MOVZ  X14, #0x567d, LSL #0
    MOVK  X14, #0xd477, LSL #16
    MOVK  X14, #0xfe5, LSL #32
    MOVK  X14, #0xf505, LSL #48
    MOVZ  X15, #0xeb7c, LSL #0
    MOVK  X15, #0xa52b, LSL #16
    MOVK  X15, #0x85c7, LSL #32
    MOVK  X15, #0x1baa, LSL #48
    MOVZ  X16, #0xae98, LSL #0
    MOVK  X16, #0x9a8, LSL #16
    MOVK  X16, #0xe44, LSL #32
    MOVK  X16, #0x8794, LSL #48
    MOVZ  X17, #0x88b7, LSL #0
    MOVK  X17, #0x29ee, LSL #16
    MOVK  X17, #0xdbfa, LSL #32
    MOVK  X17, #0x1c41, LSL #48
    MOVZ  X18, #0x2ea1, LSL #0
    MOVK  X18, #0xb61a, LSL #16
    MOVK  X18, #0x1ff7, LSL #32
    MOVK  X18, #0xa0e6, LSL #48
    MOVZ  X19, #0x2abb, LSL #0
    MOVK  X19, #0x6e6f, LSL #16
    MOVK  X19, #0x69be, LSL #32
    MOVK  X19, #0x3c1f, LSL #48
    MOVZ  X20, #0x7eab, LSL #0
    MOVK  X20, #0x2bf9, LSL #16
    MOVK  X20, #0x6775, LSL #32
    MOVK  X20, #0xfd12, LSL #48
    MOVZ  X21, #0x4668, LSL #0
    MOVK  X21, #0x32f3, LSL #16
    MOVK  X21, #0xfd43, LSL #32
    MOVK  X21, #0xcaa5, LSL #48
    MOVZ  X22, #0x3554, LSL #0
    MOVK  X22, #0x4770, LSL #16
    MOVK  X22, #0x742, LSL #32
    MOVK  X22, #0x6505, LSL #48
    MOVZ  X23, #0x3d34, LSL #0
    MOVK  X23, #0x7714, LSL #16
    MOVK  X23, #0xd25d, LSL #32
    MOVK  X23, #0xf6d6, LSL #48
    MOVZ  X24, #0x9e2f, LSL #0
    MOVK  X24, #0xdb64, LSL #16
    MOVK  X24, #0xd325, LSL #32
    MOVK  X24, #0x9f11, LSL #48
    MOVZ  X25, #0x1514, LSL #0
    MOVK  X25, #0xceea, LSL #16
    MOVK  X25, #0x8d50, LSL #32
    MOVK  X25, #0x857b, LSL #48
    MOVZ  X26, #0xdfd6, LSL #0
    MOVK  X26, #0xb0c0, LSL #16
    MOVK  X26, #0xdd5, LSL #32
    MOVK  X26, #0x2041, LSL #48
    MOVZ  X27, #0xf97c, LSL #0
    MOVK  X27, #0xffaf, LSL #16
    MOVK  X27, #0x5ada, LSL #32
    MOVK  X27, #0xede8, LSL #48
    MOVZ  X28, #0xa387, LSL #0
    MOVK  X28, #0x76e, LSL #16
    MOVK  X28, #0x5030, LSL #32
    MOVK  X28, #0x8f19, LSL #48
    MOVZ  X29, #0xec11, LSL #0
    MOVK  X29, #0x76bf, LSL #16
    MOVK  X29, #0x1cf5, LSL #32
    MOVK  X29, #0x934d, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X26
    FMOV  D1, X28
    FMOV  V1.D[1], X29
    FMOV  D2, X27
    FMOV  V2.D[1], X24
    FMOV  D3, X6
    FMOV  V3.D[1], X20
    FMOV  D4, X22
    FMOV  V4.D[1], X14
    FMOV  D5, X28
    FMOV  V5.D[1], X15
    FMOV  D6, X15
    FMOV  V6.D[1], X13
    FMOV  D7, X5
    FMOV  V7.D[1], X24
    FMOV  D8, X9
    FMOV  V8.D[1], X26
    FMOV  D9, X3
    FMOV  V9.D[1], X13
    FMOV  D10, X26
    FMOV  V10.D[1], X9
    FMOV  D11, X5
    FMOV  V11.D[1], X29
    FMOV  D12, X16
    FMOV  V12.D[1], X12
    FMOV  D13, X14
    FMOV  V13.D[1], X14
    FMOV  D14, X25
    FMOV  V14.D[1], X23
    FMOV  D15, X6
    FMOV  V15.D[1], X6
    FMOV  D16, X20
    FMOV  V16.D[1], X2
    FMOV  D17, X16
    FMOV  V17.D[1], X5
    FMOV  D18, X17
    FMOV  V18.D[1], X3
    FMOV  D19, X21
    FMOV  V19.D[1], X26
    FMOV  D20, X28
    FMOV  V20.D[1], X20
    FMOV  D21, X24
    FMOV  V21.D[1], X14
    FMOV  D22, X7
    FMOV  V22.D[1], X13
    FMOV  D23, X12
    FMOV  V23.D[1], X28
    FMOV  D24, X12
    FMOV  V24.D[1], X25
    FMOV  D25, X29
    FMOV  V25.D[1], X27
    FMOV  D26, X24
    FMOV  V26.D[1], X15
    FMOV  D27, X25
    FMOV  V27.D[1], X24
    FMOV  D28, X10
    FMOV  V28.D[1], X6
    FMOV  D29, X10
    FMOV  V29.D[1], X19
    FMOV  D30, X18
    FMOV  V30.D[1], X22
    FMOV  D31, X24
    FMOV  V31.D[1], X22
    MOVZ  X24, #0xf, LSL #0
TSRTAdvsimdVectorMaxMin_label_12:
    UMINV  B25, V31.8B
    FMIN  V12.2S, V25.2S, V25.2S
    SMINV  H16, V26.8H
    FMINNM  V11.2S, V12.2S, V28.2S
    UMINV  B23, V16.16B
    FMAXNM  V18.2D, V30.2D, V27.2D
    FMAXNMP D2, V23.2D
    UMAXP  V23.4S, V18.4S, V24.4S
    FMINP  V18.4S, V29.4S, V29.4S
    SMAX  V30.4S, V11.4S, V18.4S
    FMAXNMV  H29, V23.8H
    UMINV  H25, V2.4H
    FMINNMP S11, V30.2S
    FMAXNMV  H1, V11.8H
    UMAXV  S23, V1.4S
    UMINV  S19, V25.4S
    SMINV  B19, V19.8B
    SMAXP  V31.4H, V23.4H, V23.4H
    UMAXV  S7, V31.4S
    SMAX  V10.16B, V29.16B, V29.16B
    FMINNMP D29, V19.2D
    FMIN  V16.2D, V8.2D, V29.2D
    FMAXP  V27.4H, V7.4H, V16.4H
    FMINNM  V8.4S, V10.4S, V10.4S
    UMINV  B29, V27.16B
    FMINNMV  H24, V8.8H
    FMINNM  V7.4S, V24.4S, V29.4S
    FMINV  S11, V9.4S
    FMAX  V10.2D, V28.2D, V5.2D
    FMINV  H2, V4.8H
    FMAXNMV  H4, V15.8H
    FMAXP H9, V19.2H
    SMAX  V15.2S, V3.2S, V28.2S
    FMAXV  H18, V14.8H
    FMIN  V30.8H, V29.8H, V11.8H
    FMINV  H31, V14.4H
    FMINV  H14, V9.8H
    SMAXV  B16, V30.16B
    FMAXNMP S19, V14.2S
    FMAXP S30, V31.2S
    FMINNMP  V29.2D, V7.2D, V4.2D
    FMAXNMP S9, V29.2S
    FMAXNM  V5.2D, V15.2D, V14.2D
    SMINV  B27, V10.8B
    FMINNM  V15.8H, V27.8H, V18.8H
    FMINNM  V11.4H, V19.4H, V25.4H
    SMINV  B25, V30.8B
    FMAXNMV  S28, V16.4S
    FMINNMP  V24.8H, V5.8H, V9.8H
    FMINV  H7, V24.8H
    FMAXP D29, V15.2D
    FMAXV  H24, V7.4H
    FMIN  V14.2S, V11.2S, V24.2S
    FMINV  H31, V2.4H
    FMINP  V5.4H, V31.4H, V28.4H
    FMINP D30, V29.2D
    UMINV  B2, V13.8B
    UMINP  V24.8B, V25.8B, V25.8B
    FMAX  V11.4H, V2.4H, V24.4H
    FMAXP D7, V14.2D
    FMAXP  V13.2D, V30.2D, V16.2D
    FMINP H16, V13.2H
    FMINP H2, V5.2H
    FMINV  H29, V2.8H
    UMAX  V4.8H, V29.8H, V29.8H
    SMINV  H25, V7.4H
    FMAXNM  V28.4S, V16.4S, V11.4S
    SMINV  B9, V28.8B
    FMINP  V14.8H, V4.8H, V4.8H
    FMINP D4, V25.2D
    FMAXP  V28.2D, V9.2D, V4.2D
    FMAXP D25, V31.2D
    UMINV  S31, V14.4S
    SMINV  B29, V31.16B
    FMINNMP H7, V29.2H
    FMINP S31, V7.2S
    FMINP D16, V25.2D
    FMIN  V11.8H, V29.8H, V28.8H
    FMAXNMP H5, V11.2H
    FMAX  V29.4S, V5.4S, V31.4S
    UMINV  S30, V16.4S
    FMINP  V13.2D, V30.2D, V29.2D
    FMAXP H2, V21.2H
    FMINV  S9, V9.4S
    FMINNMV  H24, V2.8H
    UMINV  B30, V10.16B
    FMAXP D5, V22.2D
    FMINNMP H7, V25.2H
    FMINNMP  V28.8H, V5.8H, V27.8H
    FMAXP H22, V8.2H
    UMAXV  H27, V25.4H
    UMINV  B14, V15.8B
    FMAXV  H16, V27.4H
    UMAXP  V21.8B, V22.8B, V30.8B
    FMAX  V30.8H, V28.8H, V9.8H
    FMINP H11, V14.2H
    FMAXNMP D9, V30.2D
    FMINNMV  H2, V9.4H
    FMAXP H31, V11.2H
    SMINV  H27, V31.8H
    FMINNM  V4.2D, V13.2D, V16.2D
    FMINNMP S30, V21.2S
    UMINV  B21, V27.8B
    FMAXNM  V9.2S, V30.2S, V7.2S
    FMINNMP  V8.2D, V2.2D, V24.2D
    FMAX  V10.8H, V21.8H, V4.8H
    FMAXP S25, V10.2S
    SMAXV  B2, V9.8B
    FMAXP H22, V8.2H
    FMINP D31, V22.2D
    FMAXNM  V4.4S, V25.4S, V25.4S
    FMINNMP S22, V4.2S
    UMINP  V11.16B, V2.16B, V22.16B
    UMAXV  B8, V31.16B
    FMAXP H31, V8.2H
    SMAXV  S2, V31.4S
    FMAXV  H30, V11.4H
    FMAXP H10, V30.2H
    FMINNM  V9.4S, V8.4S, V10.4S
    FMINNM  V11.4H, V2.4H, V9.4H
    FMAX  V25.2S, V11.2S, V28.2S
    FMAXP  V9.4H, V23.4H, V30.4H
    FMINNMP H31, V6.2H
    UMINV  H22, V8.4H
    SMAXV  H4, V23.4H
    UMINV  S6, V22.4S
    UMINP  V22.8B, V0.8B, V12.8B
    SMINV  B30, V1.16B
    FMIN  V1.2D, V1.2D, V29.2D
    FMAXNMP  V8.4H, V18.4H, V31.4H
    FMINNMP D23, V0.2D
    FMAXV  H21, V6.8H
    SMINP  V31.8H, V21.8H, V29.8H
    UMINV  H6, V24.4H
    FMINV  S20, V0.4S
    FMAXNMP  V21.2S, V20.2S, V8.2S
    FMAXNMV  S20, V21.4S
    FMAX  V12.2D, V30.2D, V23.2D
    FMINNMP  V0.4H, V1.4H, V20.4H
    SMINV  S24, V31.4S
    SMINV  B1, V25.16B
    FMAXP H20, V22.2H
    SMINV  B8, V4.8B
    FMINV  S30, V8.4S
    FMAXNMV  H18, V9.4H
    FMAXNMP  V29.2D, V6.2D, V6.2D
    FMINNMP S21, V29.2S
    UMAXV  S10, V30.4S
    SMINP  V30.8B, V7.8B, V12.8B
    UMINP  V7.8H, V30.8H, V30.8H
    FMINNMP S8, V18.2S
    FMINP  V29.4S, V20.4S, V0.4S
    SMIN  V6.8B, V26.8B, V10.8B
    UMINV  H18, V29.8H
    FMINNMV  S12, V21.4S
    FMINNMP  V12.4S, V1.4S, V18.4S
    FMAXP  V9.2S, V12.2S, V24.2S
    FMAXP S0, V7.2S
    UMINV  B12, V9.16B
    FMINNMP  V24.4H, V31.4H, V8.4H
    FMINP  V22.2S, V6.2S, V6.2S
    FMAXNMP H6, V0.2H
    FMINNMP D25, V22.2D
    FMINNM  V29.2S, V25.2S, V12.2S
    FMAXNMP D12, V29.2D
    FMAXP  V4.4H, V19.4H, V6.4H
    SMAX  V23.16B, V4.16B, V29.16B
    FMINP  V25.2S, V23.2S, V24.2S
    FMAXP  V22.2D, V30.2D, V12.2D
    FMAXNMP  V12.8H, V25.8H, V25.8H
    SMAX  V20.2S, V22.2S, V22.2S
    UMIN  V22.8H, V12.8H, V12.8H
    SMAXV  H0, V20.4H
    FMAXNMP D9, V0.2D
    FMAXNMP S23, V22.2S
    FMAX  V8.2D, V9.2D, V23.2D
    UMINV  B31, V1.8B
    FMAXNMV  H20, V25.8H
    SMAX  V1.8H, V29.8H, V13.8H
    FMINNMP  V4.8H, V8.8H, V31.8H
    FMAXV  S0, V2.4S
    FMAXNMP  V9.4H, V28.4H, V1.4H
    UMINV  S28, V11.4S
    FMINNMV  H2, V28.4H
    FMINNMP  V6.4S, V9.4S, V7.4S
    FMAXNMP  V11.2S, V2.2S, V11.2S
    FMAX  V23.4H, V1.4H, V11.4H
    SMAX  V22.2S, V16.2S, V23.2S
    UMINP  V13.8H, V21.8H, V28.8H
    FMAXP  V2.8H, V9.8H, V29.8H
    FMINP H24, V5.2H
    FMINP  V30.2D, V11.2D, V17.2D
    FMAXP H25, V2.2H
    UMAXP  V7.8H, V4.8H, V24.8H
    FMAXNMP  V1.4H, V7.4H, V20.4H
    UMAXV  H20, V0.4H
    FMAXP H9, V13.2H
    UMINV  S2, V6.4S
    UMIN  V12.4S, V1.4S, V22.4S
    UMINP  V11.8H, V2.8H, V12.8H
    SUBS  X24, X24, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_12
    MOVZ  X20, #0x2b3d, LSL #0
    MOVK  X20, #0x4fb, LSL #16
    MOVK  X20, #0xa148, LSL #32
    MOVK  X20, #0x577c, LSL #48
    SUB  X23, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x38f3, LSL #0
    MOVK  X20, #0x6744, LSL #16
    MOVK  X20, #0x3144, LSL #32
    MOVK  X20, #0x555e, LSL #48
    SUB  X23, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x7e5f, LSL #0
    MOVK  X20, #0x207e, LSL #16
    MOVK  X20, #0x1f55, LSL #32
    MOVK  X20, #0x4237, LSL #48
    SUB  X23, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0xe215, LSL #0
    MOVK  X20, #0xf144, LSL #16
    MOVK  X20, #0x8120, LSL #32
    MOVK  X20, #0xdda7, LSL #48
    SUB  X23, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x2e61, LSL #0
    MOVK  X20, #0x55b8, LSL #16
    MOVK  X20, #0x9027, LSL #32
    MOVK  X20, #0x8a84, LSL #48
    SUB  X23, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x59f0, LSL #0
    MOVK  X20, #0x3874, LSL #16
    MOVK  X20, #0xa6a5, LSL #32
    MOVK  X20, #0xc7f6, LSL #48
    SUB  X23, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0xf598, LSL #0
    MOVK  X20, #0xe68d, LSL #16
    MOVK  X20, #0xb96f, LSL #32
    MOVK  X20, #0xca21, LSL #48
    SUB  X23, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0xb0bd, LSL #0
    MOVK  X20, #0x3860, LSL #16
    MOVK  X20, #0x84f1, LSL #32
    MOVK  X20, #0xd790, LSL #48
    SUB  X23, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0xbb8d, LSL #0
    MOVK  X20, #0x78d2, LSL #16
    MOVK  X20, #0x1f4c, LSL #32
    MOVK  X20, #0xb8ef, LSL #48
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0xeb7c, LSL #0
    MOVK  X20, #0xa52b, LSL #16
    MOVK  X20, #0x85c7, LSL #32
    MOVK  X20, #0x1baa, LSL #48
    SUB  X23, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0xae98, LSL #0
    MOVK  X20, #0x9a8, LSL #16
    MOVK  X20, #0xe44, LSL #32
    MOVK  X20, #0x8794, LSL #48
    SUB  X23, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x88b7, LSL #0
    MOVK  X20, #0x29ee, LSL #16
    MOVK  X20, #0xdbfa, LSL #32
    MOVK  X20, #0x1c41, LSL #48
    SUB  X23, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x2ea1, LSL #0
    MOVK  X20, #0xb61a, LSL #16
    MOVK  X20, #0x1ff7, LSL #32
    MOVK  X20, #0xa0e6, LSL #48
    SUB  X23, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x2abb, LSL #0
    MOVK  X20, #0x6e6f, LSL #16
    MOVK  X20, #0x69be, LSL #32
    MOVK  X20, #0x3c1f, LSL #48
    SUB  X23, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x4668, LSL #0
    MOVK  X20, #0x32f3, LSL #16
    MOVK  X20, #0xfd43, LSL #32
    MOVK  X20, #0xcaa5, LSL #48
    SUB  X23, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x3554, LSL #0
    MOVK  X20, #0x4770, LSL #16
    MOVK  X20, #0x742, LSL #32
    MOVK  X20, #0x6505, LSL #48
    SUB  X23, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x1514, LSL #0
    MOVK  X20, #0xceea, LSL #16
    MOVK  X20, #0x8d50, LSL #32
    MOVK  X20, #0x857b, LSL #48
    SUB  X23, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0xdfd6, LSL #0
    MOVK  X20, #0xb0c0, LSL #16
    MOVK  X20, #0xdd5, LSL #32
    MOVK  X20, #0x2041, LSL #48
    SUB  X23, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0xf97c, LSL #0
    MOVK  X20, #0xffaf, LSL #16
    MOVK  X20, #0x5ada, LSL #32
    MOVK  X20, #0xede8, LSL #48
    SUB  X23, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0xa387, LSL #0
    MOVK  X20, #0x76e, LSL #16
    MOVK  X20, #0x5030, LSL #32
    MOVK  X20, #0x8f19, LSL #48
    SUB  X23, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0xec11, LSL #0
    MOVK  X20, #0x76bf, LSL #16
    MOVK  X20, #0x1cf5, LSL #32
    MOVK  X20, #0x934d, LSL #48
    SUB  X23, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x81, LSL #0
    MRS  X23, FPSR
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V0.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D0
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V1.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D1
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V2.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D2
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x7eab, LSL #0
    MOVK  X20, #0x2bf9, LSL #16
    MOVK  X20, #0x6775, LSL #32
    MOVK  X20, #0xfd12, LSL #48
    FMOV  X23, V3.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0xe215, LSL #0
    MOVK  X20, #0xf144, LSL #16
    MOVK  X20, #0x8120, LSL #32
    MOVK  X20, #0xdda7, LSL #48
    FMOV  X23, D3
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V4.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D4
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V5.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D5
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V6.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D6
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V7.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D7
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V8.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D8
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V9.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D9
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V10.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D10
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V11.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D11
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V12.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D12
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V13.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D13
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V14.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D14
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V15.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D15
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V16.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D16
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x7e5f, LSL #0
    MOVK  X20, #0x207e, LSL #16
    MOVK  X20, #0x1f55, LSL #32
    MOVK  X20, #0x4237, LSL #48
    FMOV  X23, V17.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0xae98, LSL #0
    MOVK  X20, #0x9a8, LSL #16
    MOVK  X20, #0xe44, LSL #32
    MOVK  X20, #0x8794, LSL #48
    FMOV  X23, D17
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V18.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D18
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V19.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D19
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V20.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D20
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V21.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D21
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V22.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D22
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V23.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D23
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V24.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D24
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V25.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D25
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0xeb7c, LSL #0
    MOVK  X20, #0xa52b, LSL #16
    MOVK  X20, #0x85c7, LSL #32
    MOVK  X20, #0x1baa, LSL #48
    FMOV  X23, V26.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x9e2f, LSL #0
    MOVK  X20, #0xdb64, LSL #16
    MOVK  X20, #0xd325, LSL #32
    MOVK  X20, #0x9f11, LSL #48
    FMOV  X23, D26
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V27.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D27
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V28.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D28
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V29.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x9e00, LSL #0
    MOVK  X20, #0xdb00, LSL #16
    MOVK  X20, #0x9e00, LSL #32
    MOVK  X20, #0xdb00, LSL #48
    FMOV  X23, D29
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0xae98, LSL #0
    MOVK  X20, #0x9a8, LSL #16
    MOVK  X20, #0xe44, LSL #32
    MOVK  X20, #0x8794, LSL #48
    FMOV  X23, V30.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D30
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, V31.D[1]
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X23, D31
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
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
    FMOV  V0.D[1], X16
    FMOV  D1, X13
    FMOV  V1.D[1], X17
    FMOV  D2, X6
    FMOV  V2.D[1], X18
    FMOV  D3, X22
    FMOV  V3.D[1], X27
    FMOV  D4, X29
    FMOV  V4.D[1], X28
    FMOV  D5, X26
    FMOV  V5.D[1], X21
    FMOV  D6, X23
    FMOV  V6.D[1], X25
    FMOV  D7, X24
    FMOV  V7.D[1], X15
    FMOV  D8, X26
    FMOV  V8.D[1], X20
    FMOV  D9, X5
    FMOV  V9.D[1], X7
    FMOV  D10, X18
    FMOV  V10.D[1], X10
    FMOV  D11, X16
    FMOV  V11.D[1], X29
    FMOV  D12, X26
    FMOV  V12.D[1], X24
    FMOV  D13, X12
    FMOV  V13.D[1], X2
    FMOV  D14, X6
    FMOV  V14.D[1], X2
    FMOV  D15, X16
    FMOV  V15.D[1], X3
    FMOV  D16, X19
    FMOV  V16.D[1], X25
    FMOV  D17, X6
    FMOV  V17.D[1], X26
    FMOV  D18, X19
    FMOV  V18.D[1], X19
    FMOV  D19, X9
    FMOV  V19.D[1], X27
    FMOV  D20, X29
    FMOV  V20.D[1], X12
    FMOV  D21, X9
    FMOV  V21.D[1], X5
    FMOV  D22, X6
    FMOV  V22.D[1], X17
    FMOV  D23, X27
    FMOV  V23.D[1], X27
    FMOV  D24, X9
    FMOV  V24.D[1], X24
    FMOV  D25, X29
    FMOV  V25.D[1], X16
    FMOV  D26, X25
    FMOV  V26.D[1], X27
    FMOV  D27, X21
    FMOV  V27.D[1], X21
    FMOV  D28, X2
    FMOV  V28.D[1], X26
    FMOV  D29, X17
    FMOV  V29.D[1], X9
    FMOV  D30, X6
    FMOV  V30.D[1], X18
    FMOV  D31, X15
    FMOV  V31.D[1], X26
    MOVZ  X23, #0xf, LSL #0
TSRTAdvsimdVectorMaxMin_label_13:
    UMINV  B5, V30.8B
    FMAXV  S24, V25.4S
    FMAXNMV  S30, V31.4S
    UMINV  H31, V20.8H
    FMINP D18, V5.2D
    FMAXNMV  S10, V24.4S
    UMAXV  S24, V26.4S
    FMAXV  S12, V18.4S
    FMAXNMP  V2.4S, V29.4S, V27.4S
    FMAXNMP H31, V28.2H
    SMAXV  B2, V10.16B
    FMAXP  V7.8H, V30.8H, V12.8H
    SMAXP  V15.4H, V24.4H, V31.4H
    UMAX  V4.8H, V2.8H, V7.8H
    FMAXV  H18, V4.4H
    UMAXV  B24, V15.8B
    UMAXV  S5, V18.4S
    FMAXNM  V25.2D, V24.2D, V24.2D
    UMAXV  S26, V25.4S
    UMINV  S2, V5.4S
    UMINV  H29, V26.8H
    FMAXV  S25, V2.4S
    FMINV  H27, V25.4H
    SMAXP  V5.8H, V10.8H, V27.8H
    FMAXNMV  S20, V5.4S
    SMINV  S18, V29.4S
    FMINV  S4, V20.4S
    FMINNMV  H31, V18.8H
    FMINP  V27.4S, V31.4S, V4.4S
    UMIN  V2.8B, V14.8B, V6.8B
    FMINNMV  H5, V26.4H
    FMAXNMP S30, V20.2S
    SMAXV  H7, V18.4H
    FMAXV  S25, V27.4S
    SMINV  S31, V16.4S
    FMINNMP  V28.4S, V9.4S, V2.4S
    FMINNMV  S2, V29.4S
    FMAXP  V24.4H, V13.4H, V7.4H
    FMINNMV  H27, V17.4H
    SMINV  B26, V2.16B
    UMINV  B2, V20.8B
    FMINNMP S17, V27.2S
    FMAXNM  V4.2D, V30.2D, V30.2D
    SMINP  V14.2S, V4.2S, V5.2S
    FMAXNMV  S30, V17.4S
    FMINNM  V5.8H, V14.8H, V24.8H
    SMAX  V7.16B, V31.16B, V31.16B
    FMAXNMP S31, V28.2S
    FMAXV  S9, V3.4S
    FMINNMP D17, V26.2D
    FMAXNMP S24, V2.2S
    FMAXNMP S28, V30.2S
    FMAXV  H29, V24.8H
    FMINP  V24.2D, V25.2D, V9.2D
    UMINP  V4.16B, V31.16B, V17.16B
    FMAXP  V14.4H, V5.4H, V29.4H
    FMAXP  V27.4S, V7.4S, V7.4S
    FMIN  V30.8H, V28.8H, V28.8H
    SMAXV  B3, V30.8B
    FMAXP S30, V14.2S
    FMAXNMV  S2, V27.4S
    FMINP S5, V2.2S
    SMINV  H27, V5.4H
    FMAXNM  V5.4S, V30.4S, V27.4S
    UMINV  B14, V3.16B
    FMAX  V9.8H, V5.8H, V4.8H
    FMAXNMP S31, V14.2S
    FMINNMP  V20.4H, V24.4H, V24.4H
    FMINNM  V28.2S, V9.2S, V9.2S
    FMINP S2, V31.2S
    UMAXV  H30, V20.4H
    FMINNMV  H24, V2.8H
    SMINV  S29, V24.4S
    SMAXV  S9, V29.4S
    FMAXP H29, V9.2H
    FMAXP H24, V30.2H
    FMINNMP D25, V28.2D
    SMINV  H27, V25.4H
    FMAX  V31.2D, V31.2D, V27.2D
    SMINP  V3.2S, V29.2S, V29.2S
    FMAX  V27.4H, V3.4H, V31.4H
    FMAXNM  V28.2D, V24.2D, V24.2D
    FMAXNM  V20.4H, V27.4H, V7.4H
    UMAXV  S31, V20.4S
    FMINNMP D14, V28.2D
    FMAXP  V21.2S, V14.2S, V31.2S
    UMAXP  V27.16B, V29.16B, V15.16B
    UMAXV  B9, V25.8B
    SMAXV  B29, V25.8B
    UMAXP  V3.16B, V13.16B, V24.16B
    FMINP H25, V0.2H
    FMINNMP D4, V23.2D
    UMINP  V14.2S, V4.2S, V31.2S
    UMINV  B15, V19.16B
    FMINNM  V30.2S, V12.2S, V8.2S
    FMAX  V0.2S, V14.2S, V27.2S
    FMINNMP  V7.4H, V15.4H, V3.4H
    FMAXNMP H13, V25.2H
    UMINV  B24, V7.16B
    FMINNMV  H25, V29.8H
    FMAXNM  V7.4S, V0.4S, V30.4S
    UMAXV  H27, V25.8H
    SMINP  V28.8B, V7.8B, V13.8B
    FMINNM  V8.8H, V24.8H, V24.8H
    FMAXV  S23, V28.4S
    FMAXNMV  H20, V27.4H
    SMAXP  V29.8B, V23.8B, V23.8B
    FMAXNMV  H3, V9.4H
    FMAXNMP S31, V8.2S
    SMINP  V9.2S, V20.2S, V20.2S
    UMINV  S30, V29.4S
    FMAXNM  V15.4H, V31.4H, V3.4H
    FMINP  V25.4H, V9.4H, V15.4H
    FMINNMV  H4, V21.4H
    UMINV  H19, V30.8H
    FMINP  V23.2D, V19.2D, V19.2D
    UMAXV  S30, V28.4S
    FMAXNMV  S9, V30.4S
    FMAX  V24.4S, V25.4S, V25.4S
    FMAXNMV  S13, V24.4S
    FMINP S25, V23.2S
    FMAXV  H24, V25.4H
    FMAXNMP S28, V29.2S
    FMAXP S31, V28.2S
    UMIN  V30.8B, V13.8B, V4.8B
    FMAXNMP H23, V30.2H
    FMINV  H29, V23.8H
    SMINV  S8, V31.4S
    FMINP  V31.4H, V9.4H, V24.4H
    FMAXV  H27, V29.4H
    FMINNMV  H3, V8.8H
    FMAXNM  V25.2D, V3.2D, V16.2D
    FMINNMP S29, V25.2S
    FMAXP  V16.2S, V27.2S, V29.2S
    SMAX  V15.16B, V31.16B, V2.16B
    FMAXNMP  V30.2S, V16.2S, V1.2S
    UMAX  V25.2S, V15.2S, V15.2S
    FMAXV  S16, V30.4S
    FMAXNMP H28, V16.2H
    FMINNMP  V15.8H, V28.8H, V25.8H
    FMINP H23, V26.2H
    FMINV  H9, V0.8H
    FMINNM  V31.4S, V15.4S, V30.4S
    FMINNMV  H15, V13.8H
    FMIN  V3.4H, V17.4H, V24.4H
    SMINV  H24, V16.4H
    UMINV  H17, V9.4H
    FMAXNMP  V30.4S, V25.4S, V30.4S
    FMINNMV  S1, V1.4S
    FMAXNMP H8, V16.2H
    SMAXP  V29.8B, V15.8B, V23.8B
    SMINV  S4, V8.4S
    SMINV  B2, V1.8B
    FMIN  V27.2D, V4.2D, V31.2D
    FMAXNMP D13, V27.2D
    FMINNMP D31, V30.2D
    FMAXV  S22, V29.4S
    FMINP  V23.4H, V24.4H, V13.4H
    FMIN  V8.4S, V23.4S, V17.4S
    FMAXP D16, V22.2D
    SMIN  V23.4H, V8.4H, V2.4H
    SMINV  B22, V21.16B
    FMINP  V26.4H, V31.4H, V3.4H
    FMAXNMP  V8.4S, V8.4S, V26.4S
    FMAXNMP  V0.4S, V8.4S, V23.4S
    UMAXV  B30, V0.8B
    FMAX  V26.8H, V22.8H, V16.8H
    FMINNMP H8, V30.2H
    FMAXP  V23.2D, V26.2D, V8.2D
    FMIN  V27.4H, V13.4H, V26.4H
    UMIN  V0.8B, V21.8B, V7.8B
    FMINNMP D26, V12.2D
    FMINP D22, V28.2D
    UMIN  V24.4H, V26.4H, V18.4H
    FMAXP D2, V2.2D
    FMIN  V12.4S, V1.4S, V10.4S
    SMAXV  H8, V8.8H
    UMAXV  S21, V11.4S
    FMAXNMV  H10, V22.4H
    SMINV  H7, V12.8H
    FMAXNMV  S4, V2.4S
    UMIN  V16.4S, V24.4S, V24.4S
    FMAXNMP  V17.2D, V16.2D, V16.2D
    SMAXV  B11, V17.16B
    FMAXNMV  S30, V21.4S
    UMINP  V21.2S, V11.2S, V10.2S
    FMAXP D17, V8.2D
    FMINP D10, V7.2D
    SMAX  V31.8B, V18.8B, V30.8B
    FMAXV  H24, V0.8H
    FMAXNMV  S7, V10.4S
    FMINNMV  H11, V31.4H
    FMINP S18, V27.2S
    FMAXNM  V30.4H, V4.4H, V11.4H
    FMINV  H0, V17.8H
    SMIN  V28.2S, V18.2S, V0.2S
    FMAXNMV  S2, V28.4S
    UMAXV  B8, V24.8B
    FMIN  V12.8H, V7.8H, V21.8H
    FMAXNMP H21, V26.2H
    SUBS  X23, X23, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_13
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x81, LSL #0
    MRS  X15, FPSR
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V0.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D0
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V1.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D1
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V2.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D2
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V3.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D3
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V4.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D4
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V5.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D5
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V6.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D6
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V7.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D7
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V8.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D8
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V9.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D9
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V10.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D10
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V11.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D11
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V12.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D12
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V13.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D13
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V14.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D14
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V15.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D15
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V16.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D16
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V17.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D17
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V18.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D18
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V19.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D19
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V20.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D20
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V21.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D21
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V22.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D22
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V23.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D23
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V24.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D24
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V25.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D25
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V26.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D26
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V27.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D27
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V28.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D28
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V29.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D29
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V30.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D30
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V31.D[1]
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, D31
    SUB  X21, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
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
    FMOV  V0.D[1], X25
    FMOV  D1, X24
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X29
    FMOV  D3, X28
    FMOV  V3.D[1], X14
    FMOV  D4, X7
    FMOV  V4.D[1], X13
    FMOV  D5, X18
    FMOV  V5.D[1], X5
    FMOV  D6, X7
    FMOV  V6.D[1], X20
    FMOV  D7, X3
    FMOV  V7.D[1], X29
    FMOV  D8, X3
    FMOV  V8.D[1], X12
    FMOV  D9, X5
    FMOV  V9.D[1], X29
    FMOV  D10, X21
    FMOV  V10.D[1], X19
    FMOV  D11, X17
    FMOV  V11.D[1], X5
    FMOV  D12, X16
    FMOV  V12.D[1], X7
    FMOV  D13, X14
    FMOV  V13.D[1], X20
    FMOV  D14, X14
    FMOV  V14.D[1], X16
    FMOV  D15, X9
    FMOV  V15.D[1], X25
    FMOV  D16, X2
    FMOV  V16.D[1], X20
    FMOV  D17, X2
    FMOV  V17.D[1], X7
    FMOV  D18, X3
    FMOV  V18.D[1], X24
    FMOV  D19, X14
    FMOV  V19.D[1], X20
    FMOV  D20, X25
    FMOV  V20.D[1], X3
    FMOV  D21, X22
    FMOV  V21.D[1], X27
    FMOV  D22, X13
    FMOV  V22.D[1], X25
    FMOV  D23, X13
    FMOV  V23.D[1], X6
    FMOV  D24, X14
    FMOV  V24.D[1], X6
    FMOV  D25, X28
    FMOV  V25.D[1], X2
    FMOV  D26, X3
    FMOV  V26.D[1], X7
    FMOV  D27, X14
    FMOV  V27.D[1], X24
    FMOV  D28, X23
    FMOV  V28.D[1], X26
    FMOV  D29, X25
    FMOV  V29.D[1], X23
    FMOV  D30, X14
    FMOV  V30.D[1], X14
    FMOV  D31, X17
    FMOV  V31.D[1], X25
    MOVZ  X17, #0xf, LSL #0
TSRTAdvsimdVectorMaxMin_label_14:
    FMINNM  V2.8H, V18.8H, V23.8H
    SMIN  V18.4H, V28.4H, V30.4H
    FMINP  V20.2D, V29.2D, V29.2D
    FMAXNMV  S13, V20.4S
    FMAXNMV  H31, V2.4H
    UMIN  V4.4S, V31.4S, V18.4S
    FMINP D27, V25.2D
    FMINV  S12, V13.4S
    FMAXNMP H23, V4.2H
    FMINP H1, V27.2H
    FMAXP  V16.2D, V12.2D, V12.2D
    FMAXNMP D21, V16.2D
    FMINNMP  V25.4S, V21.4S, V23.4S
    FMINP D7, V25.2D
    FMIN  V30.4H, V7.4H, V7.4H
    FMAX  V20.4H, V30.4H, V1.4H
    FMAXNMP H11, V26.2H
    UMAXV  H22, V11.4H
    UMINV  H16, V22.8H
    SMIN  V11.8B, V16.8B, V16.8B
    UMINV  B26, V20.16B
    SMAXP  V22.2S, V26.2S, V11.2S
    UMAXV  H20, V30.4H
    FMAXP  V30.2S, V11.2S, V10.2S
    FMIN  V7.8H, V11.8H, V31.8H
    FMINP  V26.4H, V21.4H, V15.4H
    FMAXP S1, V11.2S
    SMIN  V16.4S, V14.4S, V11.4S
    SMAXP  V12.4S, V2.4S, V17.4S
    FMINP  V27.8H, V7.8H, V5.8H
    FMINP  V21.4S, V26.4S, V10.4S
    SMIN  V25.4S, V17.4S, V31.4S
    FMAXP S15, V30.2S
    UMAXP  V30.8H, V15.8H, V15.8H
    FMAXNM  V31.8H, V22.8H, V12.8H
    FMINP D7, V1.2D
    FMAXNMV  S1, V16.4S
    FMINNMV  S14, V30.4S
    FMAXNM  V30.4S, V29.4S, V25.4S
    UMAXV  S23, V20.4S
    UMAXP  V29.2S, V1.2S, V7.2S
    FMAXNMP D7, V14.2D
    FMINP S30, V27.2S
    FMAXNMP  V26.4S, V30.4S, V7.4S
    FMINNMP S27, V31.2S
    FMINNM  V31.4H, V27.4H, V7.4H
    SMAXV  B17, V26.8B
    FMAXNMV  H25, V31.8H
    SMAXP  V12.8B, V13.8B, V21.8B
    FMINP  V26.4H, V29.4H, V29.4H
    FMAXV  H27, V23.4H
    UMINP  V23.8H, V17.8H, V26.8H
    UMAX  V1.4S, V23.4S, V27.4S
    FMINV  S15, V12.4S
    UMAXV  H22, V1.8H
    SMIN  V23.8H, V15.8H, V22.8H
    FMINV  S7, V23.4S
    SMINP  V31.2S, V7.2S, V7.2S
    FMIN  V12.8H, V25.8H, V25.8H
    SMINV  B30, V12.16B
    UMINV  B14, V30.16B
    FMINP  V25.2S, V31.2S, V0.2S
    FMAXNM  V12.2S, V25.2S, V25.2S
    FMAXP  V22.4H, V12.4H, V12.4H
    UMINV  S17, V14.4S
    UMINV  H1, V22.8H
    FMAXNM  V26.8H, V8.8H, V1.8H
    FMAXNMP H1, V0.2H
    FMAX  V14.4S, V1.4S, V1.4S
    FMAX  V30.2D, V14.2D, V14.2D
    FMAXV  S7, V17.4S
    UMAXV  H1, V26.8H
    FMAXNMP  V15.8H, V18.8H, V1.8H
    FMINNMP H23, V15.2H
    FMAXNMP S0, V23.2S
    UMINV  H17, V21.8H
    FMINNMP D18, V30.2D
    FMAXNMP D8, V7.2D
    SMIN  V14.8B, V17.8B, V8.8B
    UMINV  H26, V14.4H
    SMINV  S23, V26.4S
    FMINNMP D27, V18.2D
    FMINNMV  S22, V5.4S
    FMINP  V21.8H, V27.8H, V23.8H
    FMAXNMV  S14, V21.4S
    SMAXV  H1, V0.4H
    FMAXP  V17.8H, V6.8H, V1.8H
    SMIN  V21.16B, V14.16B, V17.16B
    SMAXV  B0, V21.16B
    FMINNM  V8.4S, V0.4S, V22.4S
    FMINNMP S15, V8.2S
    UMAX  V18.8B, V14.8B, V2.8B
    SMAXP  V17.8B, V10.8B, V19.8B
    SMAXP  V8.8B, V15.8B, V1.8B
    FMAXV  S22, V3.4S
    FMAX  V14.2D, V2.2D, V11.2D
    FMAXNMP H5, V1.2H
    UMINV  H26, V4.8H
    FMAXNMV  H2, V16.8H
    SMAX  V10.8H, V8.8H, V7.8H
    SMAXV  B0, V31.16B
    FMAXP  V31.4H, V2.4H, V18.4H
    SMAXV  S6, V17.4S
    SMIN  V1.8H, V6.8H, V5.8H
    FMAXNMV  S4, V26.4S
    UMIN  V17.8B, V7.8B, V8.8B
    FMAXNMV  S5, V22.4S
    UMINV  H21, V1.4H
    SMINV  S18, V14.4S
    FMINNM  V16.4H, V31.4H, V0.4H
    FMAXP  V2.2D, V4.2D, V21.2D
    UMAXP  V27.8H, V17.8H, V18.8H
    FMAXV  S6, V16.4S
    FMAXP  V1.4S, V6.4S, V5.4S
    FMAXNMV  S15, V27.4S
    FMAXNMP H26, V10.2H
    FMAXV  S10, V26.4S
    UMIN  V7.8B, V1.8B, V10.8B
    UMAXV  H26, V2.4H
    FMINP  V4.8H, V20.8H, V15.8H
    FMINNMP D19, V26.2D
    SMINV  S26, V4.4S
    SMINP  V21.4H, V19.4H, V26.4H
    FMAXV  H16, V7.8H
    FMINNMP H18, V16.2H
    FMAX  V16.4S, V18.4S, V18.4S
    FMINNMP  V19.2D, V21.2D, V16.2D
    FMAXNMV  H14, V23.8H
    FMAXP S31, V20.2S
    SMAXP  V4.4H, V18.4H, V0.4H
    UMAXP  V8.8H, V28.8H, V7.8H
    FMIN  V26.2D, V29.2D, V31.2D
    FMINP  V29.4S, V24.4S, V31.4S
    SMINV  B31, V3.16B
    FMAX  V22.2S, V3.2S, V26.2S
    SMAXV  B26, V16.16B
    FMAXP S23, V3.2S
    FMAXNMV  H24, V19.4H
    FMINP  V3.8H, V16.8H, V4.8H
    FMINNMP H0, V29.2H
    SMINV  H18, V24.4H
    FMINP  V7.2D, V31.2D, V26.2D
    FMINNMV  H19, V3.4H
    FMAXNMP S26, V7.2S
    FMINNMP  V28.2S, V19.2S, V14.2S
    UMAXV  S20, V22.4S
    FMINV  S3, V11.4S
    SMIN  V29.8H, V14.8H, V23.8H
    FMINNM  V22.4S, V26.4S, V0.4S
    FMINP S19, V24.2S
    SMAXV  S16, V8.4S
    FMAXP  V8.4H, V28.4H, V3.4H
    UMINV  S26, V18.4S
    FMIN  V23.2D, V19.2D, V26.2D
    SMIN  V31.16B, V16.16B, V20.16B
    UMINP  V16.4S, V29.4S, V31.4S
    FMAXNM  V24.4H, V16.4H, V22.4H
    SMINV  H7, V8.4H
    FMAX  V21.2D, V23.2D, V24.2D
    FMAXP S23, V21.2S
    FMINNMV  S20, V14.4S
    FMINNM  V4.8H, V10.8H, V20.8H
    FMAXP H18, V7.2H
    UMINV  S24, V18.4S
    FMINNMP  V21.4H, V24.4H, V4.4H
    FMINP D11, V23.2D
    FMAX  V20.2D, V1.2D, V11.2D
    FMAXNMP S18, V20.2S
    UMAXP  V10.4H, V21.4H, V18.4H
    FMAXNMP S14, V26.2S
    UMAXV  H23, V11.8H
    FMINV  S19, V7.4S
    FMAXNMP H4, V5.2H
    UMAXP  V22.8H, V0.8H, V13.8H
    FMAXP  V26.4S, V1.4S, V8.4S
    SMINV  B3, V19.16B
    SMIN  V31.8B, V7.8B, V10.8B
    SMAXV  H28, V20.8H
    SMAX  V21.8H, V13.8H, V5.8H
    FMAXP D11, V4.2D
    SMINP  V16.4H, V23.4H, V22.4H
    FMIN  V19.4H, V14.4H, V3.4H
    FMAXV  S10, V16.4S
    FMINV  S13, V11.4S
    FMINNMV  H24, V21.8H
    UMAX  V18.4S, V20.4S, V28.4S
    FMAXNM  V30.8H, V31.8H, V24.8H
    FMINP D31, V19.2D
    FMINV  H11, V18.4H
    FMAXNMV  H22, V26.4H
    FMAXP D21, V22.2D
    FMAXP  V20.8H, V31.8H, V13.8H
    FMAXP  V26.4H, V10.4H, V20.4H
    FMAXNMP D18, V11.2D
    FMAXNMP  V16.2D, V30.2D, V30.2D
    FMAXP  V23.8H, V26.8H, V21.8H
    FMAXNMP D21, V23.2D
    SMAXP  V7.4H, V18.4H, V21.4H
    UMAXV  B24, V16.8B
    FMINP D23, V7.2D
    SUBS  X17, X17, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_14
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X3, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X3, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X3, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X3, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X3, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X3, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X3, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X3, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X3, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X3, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X3, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X3, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X3, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X3, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X3, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X3, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X3, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X3, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X3, X18, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X3, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X3, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X3, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x81, LSL #0
    MRS  X3, FPSR
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V0.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D0
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V1.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D1
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V2.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D2
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V3.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D3
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V4.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D4
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V5.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D5
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V6.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D6
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V7.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D7
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V8.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D8
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    FMOV  X3, V9.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    FMOV  X3, D9
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V10.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D10
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V11.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D11
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V12.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D12
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V13.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D13
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V14.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D14
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V15.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D15
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V16.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D16
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V17.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D17
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V18.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D18
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V19.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D19
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V20.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D20
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V21.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D21
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V22.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D22
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V23.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D23
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V24.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D24
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V25.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D25
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V26.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D26
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V27.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D27
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V28.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D28
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V29.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D29
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V30.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D30
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V31.D[1]
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D31
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xae65, LSL #0
    MOVK  X2, #0x13f4, LSL #16
    MOVK  X2, #0x59, LSL #32
    MOVK  X2, #0xfa3b, LSL #48
    MOVZ  X3, #0x3b1d, LSL #0
    MOVK  X3, #0x1aa1, LSL #16
    MOVK  X3, #0x2cca, LSL #32
    MOVK  X3, #0x7eab, LSL #48
    MOVZ  X5, #0xac7, LSL #0
    MOVK  X5, #0xbd8e, LSL #16
    MOVK  X5, #0x79cc, LSL #32
    MOVK  X5, #0xa26c, LSL #48
    MOVZ  X6, #0x6033, LSL #0
    MOVK  X6, #0xfdba, LSL #16
    MOVK  X6, #0x478b, LSL #32
    MOVK  X6, #0xb8cb, LSL #48
    MOVZ  X7, #0x1a06, LSL #0
    MOVK  X7, #0x6c19, LSL #16
    MOVK  X7, #0x9ca, LSL #32
    MOVK  X7, #0x212a, LSL #48
    MOVZ  X9, #0xf093, LSL #0
    MOVK  X9, #0x1797, LSL #16
    MOVK  X9, #0x536d, LSL #32
    MOVK  X9, #0xd21d, LSL #48
    MOVZ  X10, #0x3f82, LSL #0
    MOVK  X10, #0x7f36, LSL #16
    MOVK  X10, #0x78be, LSL #32
    MOVK  X10, #0x8679, LSL #48
    MOVZ  X12, #0xafd7, LSL #0
    MOVK  X12, #0xd5f, LSL #16
    MOVK  X12, #0xe831, LSL #32
    MOVK  X12, #0xb6de, LSL #48
    MOVZ  X13, #0x1bc1, LSL #0
    MOVK  X13, #0xa23c, LSL #16
    MOVK  X13, #0xb660, LSL #32
    MOVK  X13, #0x4894, LSL #48
    MOVZ  X14, #0x907b, LSL #0
    MOVK  X14, #0xc123, LSL #16
    MOVK  X14, #0x8cfc, LSL #32
    MOVK  X14, #0x771a, LSL #48
    MOVZ  X15, #0xfa29, LSL #0
    MOVK  X15, #0xf8a8, LSL #16
    MOVK  X15, #0xcca7, LSL #32
    MOVK  X15, #0xeb4c, LSL #48
    MOVZ  X16, #0x425b, LSL #0
    MOVK  X16, #0xb0c0, LSL #16
    MOVK  X16, #0xe395, LSL #32
    MOVK  X16, #0xa219, LSL #48
    MOVZ  X17, #0x1b2d, LSL #0
    MOVK  X17, #0x4503, LSL #16
    MOVK  X17, #0x2f69, LSL #32
    MOVK  X17, #0xbddf, LSL #48
    MOVZ  X18, #0x891, LSL #0
    MOVK  X18, #0x485c, LSL #16
    MOVK  X18, #0x181a, LSL #32
    MOVK  X18, #0x7fc1, LSL #48
    MOVZ  X19, #0x1c41, LSL #0
    MOVK  X19, #0xb65f, LSL #16
    MOVK  X19, #0x6a5, LSL #32
    MOVK  X19, #0x2e0, LSL #48
    MOVZ  X20, #0xcfa8, LSL #0
    MOVK  X20, #0x63a8, LSL #16
    MOVK  X20, #0xb0a0, LSL #32
    MOVK  X20, #0x1ed2, LSL #48
    MOVZ  X21, #0x2fe, LSL #0
    MOVK  X21, #0x9b7d, LSL #16
    MOVK  X21, #0xbe1c, LSL #32
    MOVK  X21, #0xc81c, LSL #48
    MOVZ  X22, #0xc1ed, LSL #0
    MOVK  X22, #0x984c, LSL #16
    MOVK  X22, #0xeaab, LSL #32
    MOVK  X22, #0x1c8d, LSL #48
    MOVZ  X23, #0xbc0a, LSL #0
    MOVK  X23, #0x96ef, LSL #16
    MOVK  X23, #0x266a, LSL #32
    MOVK  X23, #0xd6a7, LSL #48
    MOVZ  X24, #0x249c, LSL #0
    MOVK  X24, #0x9c14, LSL #16
    MOVK  X24, #0xb8f3, LSL #32
    MOVK  X24, #0x8b84, LSL #48
    MOVZ  X25, #0x21e1, LSL #0
    MOVK  X25, #0x9ba8, LSL #16
    MOVK  X25, #0x729f, LSL #32
    MOVK  X25, #0x3b60, LSL #48
    MOVZ  X26, #0xc98d, LSL #0
    MOVK  X26, #0xd9d2, LSL #16
    MOVK  X26, #0x3dc2, LSL #32
    MOVK  X26, #0x9a73, LSL #48
    MOVZ  X27, #0xde83, LSL #0
    MOVK  X27, #0xb8f9, LSL #16
    MOVK  X27, #0x6089, LSL #32
    MOVK  X27, #0x348d, LSL #48
    MOVZ  X28, #0x10d2, LSL #0
    MOVK  X28, #0xb6be, LSL #16
    MOVK  X28, #0xbcc8, LSL #32
    MOVK  X28, #0xff50, LSL #48
    MOVZ  X29, #0xe15f, LSL #0
    MOVK  X29, #0xd20b, LSL #16
    MOVK  X29, #0x7fd4, LSL #32
    MOVK  X29, #0xf139, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X28
    FMOV  D1, X23
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X24
    FMOV  D3, X5
    FMOV  V3.D[1], X6
    FMOV  D4, X18
    FMOV  V4.D[1], X25
    FMOV  D5, X29
    FMOV  V5.D[1], X24
    FMOV  D6, X12
    FMOV  V6.D[1], X7
    FMOV  D7, X18
    FMOV  V7.D[1], X29
    FMOV  D8, X16
    FMOV  V8.D[1], X24
    FMOV  D9, X29
    FMOV  V9.D[1], X17
    FMOV  D10, X27
    FMOV  V10.D[1], X26
    FMOV  D11, X12
    FMOV  V11.D[1], X24
    FMOV  D12, X23
    FMOV  V12.D[1], X7
    FMOV  D13, X27
    FMOV  V13.D[1], X29
    FMOV  D14, X26
    FMOV  V14.D[1], X16
    FMOV  D15, X28
    FMOV  V15.D[1], X12
    FMOV  D16, X9
    FMOV  V16.D[1], X18
    FMOV  D17, X29
    FMOV  V17.D[1], X14
    FMOV  D18, X14
    FMOV  V18.D[1], X6
    FMOV  D19, X28
    FMOV  V19.D[1], X23
    FMOV  D20, X23
    FMOV  V20.D[1], X18
    FMOV  D21, X22
    FMOV  V21.D[1], X21
    FMOV  D22, X18
    FMOV  V22.D[1], X14
    FMOV  D23, X24
    FMOV  V23.D[1], X21
    FMOV  D24, X24
    FMOV  V24.D[1], X26
    FMOV  D25, X27
    FMOV  V25.D[1], X23
    FMOV  D26, X6
    FMOV  V26.D[1], X17
    FMOV  D27, X22
    FMOV  V27.D[1], X29
    FMOV  D28, X9
    FMOV  V28.D[1], X21
    FMOV  D29, X22
    FMOV  V29.D[1], X18
    FMOV  D30, X29
    FMOV  V30.D[1], X28
    FMOV  D31, X14
    FMOV  V31.D[1], X12
    MOVZ  X18, #0xf, LSL #0
TSRTAdvsimdVectorMaxMin_label_15:
    UMINV  B24, V31.8B
    FMAXV  H24, V27.8H
    SMAX  V4.2S, V28.2S, V23.2S
    FMAX  V3.4S, V25.4S, V22.4S
    FMINNMV  H4, V26.8H
    FMINP D26, V24.2D
    SMAXP  V19.4S, V3.4S, V3.4S
    UMIN  V19.4S, V29.4S, V4.4S
    UMINV  B31, V26.8B
    FMINNMP S20, V4.2S
    SMAXV  B16, V19.16B
    FMINP D2, V20.2D
    FMINP H6, V16.2H
    FMINNMP  V28.2S, V31.2S, V30.2S
    SMINV  S12, V2.4S
    FMAXNM  V4.2D, V6.2D, V12.2D
    FMAX  V3.8H, V4.8H, V4.8H
    FMIN  V20.8H, V3.8H, V28.8H
    UMAXV  B16, V13.16B
    FMINP  V24.4S, V30.4S, V1.4S
    FMINP  V19.8H, V13.8H, V3.8H
    FMINNMP  V23.8H, V22.8H, V10.8H
    FMAXNMP  V30.2D, V31.2D, V10.2D
    FMINP H29, V15.2H
    UMIN  V4.16B, V23.16B, V7.16B
    SMIN  V25.4H, V27.4H, V6.4H
    FMINNMV  H1, V23.4H
    SMINP  V7.4H, V20.4H, V1.4H
    UMINV  H3, V16.4H
    FMINP H26, V19.2H
    UMINV  S12, V3.4S
    FMAXP D28, V30.2D
    FMAXP D2, V0.2D
    UMINV  B16, V29.16B
    FMINNM  V9.8H, V4.8H, V24.8H
    SMINV  H22, V12.8H
    SMAXV  B12, V25.8B
    FMINP  V31.2S, V26.2S, V28.2S
    SMAXV  H20, V12.4H
    UMIN  V19.4S, V7.4S, V7.4S
    FMAXV  S10, V16.4S
    FMAXP S26, V19.2S
    FMINNMP H1, V26.2H
    FMAX  V19.2D, V1.2D, V2.2D
    FMAXV  H27, V19.8H
    UMINV  S12, V9.4S
    SMINP  V28.4H, V20.4H, V10.4H
    FMINNMP  V10.2D, V22.2D, V31.2D
    SMAX  V7.4S, V27.4S, V12.4S
    UMIN  V24.2S, V12.2S, V10.2S
    FMINP H23, V28.2H
    SMAXP  V16.4S, V23.4S, V24.4S
    FMINP D25, V16.2D
    FMAXNMP D31, V7.2D
    UMAXV  H16, V25.8H
    SMAXP  V25.2S, V16.2S, V19.2S
    SMAXP  V12.8B, V25.8B, V25.8B
    SMAX  V19.8H, V12.8H, V12.8H
    FMINNMP H9, V31.2H
    FMAXNM  V28.8H, V19.8H, V9.8H
    FMINNMP D20, V16.2D
    FMINNMP  V22.2D, V21.2D, V11.2D
    UMAXP  V1.4H, V14.4H, V20.4H
    FMAX  V7.8H, V14.8H, V16.8H
    SMAXV  B4, V23.8B
    FMAXNMP  V27.2S, V26.2S, V3.2S
    UMINV  S31, V5.4S
    SMAXV  S24, V23.4S
    FMINNMP D2, V31.2D
    SMIN  V20.8B, V14.8B, V19.8B
    FMINNMP D19, V27.2D
    FMINNMP S9, V19.2S
    FMAXP  V16.2S, V4.2S, V22.2S
    UMINP  V21.2S, V9.2S, V28.2S
    FMAXNMP S12, V21.2S
    SMAX  V19.4H, V1.4H, V1.4H
    FMIN  V10.4H, V16.4H, V2.4H
    FMINNMP D1, V12.2D
    SMAXV  S23, V19.4S
    FMAXNMP S25, V24.2S
    FMINNMP  V31.4H, V23.4H, V10.4H
    FMAXNMP  V27.2S, V1.2S, V20.2S
    FMINP  V23.4S, V7.4S, V25.4S
    FMAXP D10, V31.2D
    FMINNMV  H1, V10.8H
    FMINNMP S22, V27.2S
    FMINNMP H16, V26.2H
    FMAXV  H26, V23.4H
    FMAXNM  V20.2D, V22.2D, V1.2D
    FMINP  V19.8H, V20.8H, V20.8H
    FMINNMV  H9, V19.8H
    FMAXP  V24.4H, V9.4H, V9.4H
    UMAXV  H19, V16.8H
    SMINV  H10, V26.4H
    FMINNMP D1, V24.2D
    UMINV  H23, V19.8H
    FMINNM  V16.4H, V23.4H, V23.4H
    FMINNMV  S31, V10.4S
    FMAXP H9, V1.2H
    UMAX  V10.8H, V9.8H, V9.8H
    FMINNMP S1, V16.2S
    FMAXV  H9, V18.4H
    FMINV  H27, V1.8H
    FMIN  V23.4H, V27.4H, V31.4H
    FMAXNM  V31.4S, V9.4S, V23.4S
    FMAXNMP S1, V10.2S
    SMINV  H26, V16.8H
    SMAXV  S18, V31.4S
    UMINV  H19, V26.4H
    FMAXP S31, V1.2S
    FMINNM  V1.2D, V18.2D, V19.2D
    FMAXNMP  V7.2S, V1.2S, V31.2S
    SMAXV  S1, V16.4S
    SMAXP  V31.2S, V24.2S, V2.2S
    FMAX  V22.2D, V2.2D, V9.2D
    FMINNMP  V26.2S, V31.2S, V26.2S
    FMIN  V18.4H, V4.4H, V3.4H
    UMAXV  S4, V11.4S
    FMINP  V20.2D, V24.2D, V21.2D
    FMAXP D16, V7.2D
    FMIN  V23.2S, V12.2S, V6.2S
    UMINV  S7, V10.4S
    SMAXV  H9, V1.8H
    FMINP  V24.2D, V22.2D, V22.2D
    SMIN  V21.4S, V24.4S, V14.4S
    UMAXV  S19, V24.4S
    FMINV  H6, V20.4H
    SMAXV  H31, V26.8H
    FMAXNMP  V14.2D, V31.2D, V31.2D
    FMINNMP S24, V16.2S
    FMAXNMP S16, V23.2S
    FMAXNMP  V3.2S, V14.2S, V7.2S
    FMAX  V26.4H, V29.4H, V3.4H
    FMINNM  V1.8H, V18.8H, V4.8H
    FMAXP  V11.2D, V1.2D, V1.2D
    UMINV  H3, V9.4H
    UMINV  H10, V21.8H
    FMAXNMV  H2, V10.8H
    SMAX  V9.4H, V2.4H, V11.4H
    FMINP  V31.8H, V19.8H, V9.8H
    FMINNMV  S19, V6.4S
    FMINP H23, V19.2H
    FMAXNM  V22.4S, V26.4S, V16.4S
    FMAXP D26, V3.2D
    FMIN  V2.8H, V24.8H, V24.8H
    UMAXV  H20, V2.4H
    FMINP S2, V22.2S
    FMAX  V3.8H, V2.8H, V20.8H
    FMAXP S9, V21.2S
    FMAXP H14, V31.2H
    UMAXV  S12, V23.4S
    SMINV  H11, V14.4H
    FMINP  V29.8H, V26.8H, V11.8H
    FMAXNMP H14, V27.2H
    FMINNMP S24, V3.2S
    UMIN  V20.8B, V9.8B, V19.8B
    FMAXNMP S21, V12.2S
    FMINP  V16.4S, V21.4S, V14.4S
    FMAXP H22, V24.2H
    FMINNMP D14, V29.2D
    UMAXV  S29, V16.4S
    FMINP S18, V20.2S
    FMIN  V4.2S, V29.2S, V22.2S
    SMINV  H16, V14.8H
    FMINNMP  V11.4S, V18.4S, V18.4S
    SMAXV  H27, V11.8H
    FMINP H18, V4.2H
    FMAXP H23, V16.2H
    SMAX  V26.8B, V18.8B, V23.8B
    SMAXV  S31, V23.4S
    FMAXV  H24, V31.4H
    FMINV  S22, V27.4S
    FMAXP S20, V15.2S
    FMINNMP D14, V22.2D
    SMAXP  V2.8B, V24.8B, V14.8B
    SMINV  H23, V20.8H
    FMAXNMP H21, V7.2H
    FMAXNMP S7, V26.2S
    FMAXP  V29.2S, V21.2S, V7.2S
    UMAXV  B11, V23.8B
    UMINV  H18, V29.4H
    SMIN  V4.8B, V2.8B, V18.8B
    FMINNMP S16, V11.2S
    UMINP  V18.4S, V16.4S, V4.4S
    FMINV  S31, V19.4S
    FMINNM  V11.2S, V29.2S, V8.2S
    FMINNMP S2, V0.2S
    FMINP H26, V29.2H
    SMINV  H8, V28.4H
    FMAXP  V21.2D, V8.2D, V13.2D
    UMINV  S28, V3.4S
    SMINV  S22, V1.4S
    FMAXP  V8.4H, V25.4H, V23.4H
    FMAX  V27.8H, V26.8H, V31.8H
    FMAXNMP S0, V28.2S
    FMINNMV  S16, V5.4S
    FMAXP S1, V21.2S
    FMAXNM  V4.4H, V11.4H, V22.4H
    SMAXV  H29, V2.4H
    FMAXNMP  V25.4H, V18.4H, V27.4H
    SUBS  X18, X18, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_15
    MOVZ  X6, #0x3b1d, LSL #0
    MOVK  X6, #0x1aa1, LSL #16
    MOVK  X6, #0x2cca, LSL #32
    MOVK  X6, #0x7eab, LSL #48
    SUB  X2, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0xac7, LSL #0
    MOVK  X6, #0xbd8e, LSL #16
    MOVK  X6, #0x79cc, LSL #32
    MOVK  X6, #0xa26c, LSL #48
    SUB  X2, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0xf093, LSL #0
    MOVK  X6, #0x1797, LSL #16
    MOVK  X6, #0x536d, LSL #32
    MOVK  X6, #0xd21d, LSL #48
    SUB  X2, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x3f82, LSL #0
    MOVK  X6, #0x7f36, LSL #16
    MOVK  X6, #0x78be, LSL #32
    MOVK  X6, #0x8679, LSL #48
    SUB  X2, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0xafd7, LSL #0
    MOVK  X6, #0xd5f, LSL #16
    MOVK  X6, #0xe831, LSL #32
    MOVK  X6, #0xb6de, LSL #48
    SUB  X2, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x1bc1, LSL #0
    MOVK  X6, #0xa23c, LSL #16
    MOVK  X6, #0xb660, LSL #32
    MOVK  X6, #0x4894, LSL #48
    SUB  X2, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x907b, LSL #0
    MOVK  X6, #0xc123, LSL #16
    MOVK  X6, #0x8cfc, LSL #32
    MOVK  X6, #0x771a, LSL #48
    SUB  X2, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0xfa29, LSL #0
    MOVK  X6, #0xf8a8, LSL #16
    MOVK  X6, #0xcca7, LSL #32
    MOVK  X6, #0xeb4c, LSL #48
    SUB  X2, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x425b, LSL #0
    MOVK  X6, #0xb0c0, LSL #16
    MOVK  X6, #0xe395, LSL #32
    MOVK  X6, #0xa219, LSL #48
    SUB  X2, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x1b2d, LSL #0
    MOVK  X6, #0x4503, LSL #16
    MOVK  X6, #0x2f69, LSL #32
    MOVK  X6, #0xbddf, LSL #48
    SUB  X2, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x1c41, LSL #0
    MOVK  X6, #0xb65f, LSL #16
    MOVK  X6, #0x6a5, LSL #32
    MOVK  X6, #0x2e0, LSL #48
    SUB  X2, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0xcfa8, LSL #0
    MOVK  X6, #0x63a8, LSL #16
    MOVK  X6, #0xb0a0, LSL #32
    MOVK  X6, #0x1ed2, LSL #48
    SUB  X2, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x2fe, LSL #0
    MOVK  X6, #0x9b7d, LSL #16
    MOVK  X6, #0xbe1c, LSL #32
    MOVK  X6, #0xc81c, LSL #48
    SUB  X2, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0xc1ed, LSL #0
    MOVK  X6, #0x984c, LSL #16
    MOVK  X6, #0xeaab, LSL #32
    MOVK  X6, #0x1c8d, LSL #48
    SUB  X2, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0xbc0a, LSL #0
    MOVK  X6, #0x96ef, LSL #16
    MOVK  X6, #0x266a, LSL #32
    MOVK  X6, #0xd6a7, LSL #48
    SUB  X2, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x249c, LSL #0
    MOVK  X6, #0x9c14, LSL #16
    MOVK  X6, #0xb8f3, LSL #32
    MOVK  X6, #0x8b84, LSL #48
    SUB  X2, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x21e1, LSL #0
    MOVK  X6, #0x9ba8, LSL #16
    MOVK  X6, #0x729f, LSL #32
    MOVK  X6, #0x3b60, LSL #48
    SUB  X2, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0xc98d, LSL #0
    MOVK  X6, #0xd9d2, LSL #16
    MOVK  X6, #0x3dc2, LSL #32
    MOVK  X6, #0x9a73, LSL #48
    SUB  X2, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0xde83, LSL #0
    MOVK  X6, #0xb8f9, LSL #16
    MOVK  X6, #0x6089, LSL #32
    MOVK  X6, #0x348d, LSL #48
    SUB  X2, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x10d2, LSL #0
    MOVK  X6, #0xb6be, LSL #16
    MOVK  X6, #0xbcc8, LSL #32
    MOVK  X6, #0xff50, LSL #48
    SUB  X2, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0xe15f, LSL #0
    MOVK  X6, #0xd20b, LSL #16
    MOVK  X6, #0x7fd4, LSL #32
    MOVK  X6, #0xf139, LSL #48
    SUB  X2, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x81, LSL #0
    MRS  X2, FPSR
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V0.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, D0
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V1.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, D1
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V2.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, D2
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V3.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, D3
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V4.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, D4
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x249c, LSL #0
    MOVK  X6, #0x9c14, LSL #16
    MOVK  X6, #0xb8f3, LSL #32
    MOVK  X6, #0x8b84, LSL #48
    FMOV  X2, V5.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0xe15f, LSL #0
    MOVK  X6, #0xd20b, LSL #16
    MOVK  X6, #0x7fd4, LSL #32
    MOVK  X6, #0xf139, LSL #48
    FMOV  X2, D5
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V6.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, D6
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V7.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, D7
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V8.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, D8
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V9.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, D9
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V10.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, D10
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V11.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, D11
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V12.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, D12
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0xe15f, LSL #0
    MOVK  X6, #0xd20b, LSL #16
    MOVK  X6, #0x7fd4, LSL #32
    MOVK  X6, #0xf139, LSL #48
    FMOV  X2, V13.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0xde83, LSL #0
    MOVK  X6, #0xb8f9, LSL #16
    MOVK  X6, #0x6089, LSL #32
    MOVK  X6, #0x348d, LSL #48
    FMOV  X2, D13
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V14.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, D14
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0xafd7, LSL #0
    MOVK  X6, #0xd5f, LSL #16
    MOVK  X6, #0xe831, LSL #32
    MOVK  X6, #0xb6de, LSL #48
    FMOV  X2, V15.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x10d2, LSL #0
    MOVK  X6, #0xb6be, LSL #16
    MOVK  X6, #0xbcc8, LSL #32
    MOVK  X6, #0xff50, LSL #48
    FMOV  X2, D15
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V16.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x7fd4, LSL #0
    MOVK  X6, #0xf139, LSL #16
    FMOV  X2, D16
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x907b, LSL #0
    MOVK  X6, #0xc123, LSL #16
    MOVK  X6, #0x8cfc, LSL #32
    MOVK  X6, #0x771a, LSL #48
    FMOV  X2, V17.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0xe15f, LSL #0
    MOVK  X6, #0xd20b, LSL #16
    MOVK  X6, #0x7fd4, LSL #32
    MOVK  X6, #0xf139, LSL #48
    FMOV  X2, D17
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V18.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, D18
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V19.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, D19
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V20.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x10d2, LSL #0
    MOVK  X6, #0xb6be, LSL #16
    FMOV  X2, D20
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0xde83, LSL #0
    MOVK  X6, #0xb8f9, LSL #16
    MOVK  X6, #0x6089, LSL #32
    MOVK  X6, #0x348d, LSL #48
    FMOV  X2, V21.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, D21
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V22.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, D22
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V23.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0xb6be, LSL #0
    FMOV  X2, D23
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V24.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, D24
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V25.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, D25
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V26.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, D26
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V27.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, D27
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V28.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, D28
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V29.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, D29
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V30.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, D30
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V31.D[1]
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, D31
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
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
    FMOV  D0, X20
    FMOV  V0.D[1], X26
    FMOV  D1, X14
    FMOV  V1.D[1], X18
    FMOV  D2, X19
    FMOV  V2.D[1], X28
    FMOV  D3, X24
    FMOV  V3.D[1], X29
    FMOV  D4, X22
    FMOV  V4.D[1], X21
    FMOV  D5, X23
    FMOV  V5.D[1], X10
    FMOV  D6, X27
    FMOV  V6.D[1], X25
    FMOV  D7, X13
    FMOV  V7.D[1], X27
    FMOV  D8, X23
    FMOV  V8.D[1], X12
    FMOV  D9, X14
    FMOV  V9.D[1], X13
    FMOV  D10, X10
    FMOV  V10.D[1], X5
    FMOV  D11, X27
    FMOV  V11.D[1], X24
    FMOV  D12, X23
    FMOV  V12.D[1], X13
    FMOV  D13, X10
    FMOV  V13.D[1], X29
    FMOV  D14, X29
    FMOV  V14.D[1], X21
    FMOV  D15, X22
    FMOV  V15.D[1], X2
    FMOV  D16, X3
    FMOV  V16.D[1], X23
    FMOV  D17, X29
    FMOV  V17.D[1], X9
    FMOV  D18, X16
    FMOV  V18.D[1], X12
    FMOV  D19, X14
    FMOV  V19.D[1], X28
    FMOV  D20, X27
    FMOV  V20.D[1], X5
    FMOV  D21, X5
    FMOV  V21.D[1], X27
    FMOV  D22, X23
    FMOV  V22.D[1], X6
    FMOV  D23, X3
    FMOV  V23.D[1], X16
    FMOV  D24, X27
    FMOV  V24.D[1], X12
    FMOV  D25, X6
    FMOV  V25.D[1], X19
    FMOV  D26, X13
    FMOV  V26.D[1], X28
    FMOV  D27, X19
    FMOV  V27.D[1], X10
    FMOV  D28, X13
    FMOV  V28.D[1], X29
    FMOV  D29, X27
    FMOV  V29.D[1], X27
    FMOV  D30, X14
    FMOV  V30.D[1], X16
    FMOV  D31, X15
    FMOV  V31.D[1], X27
    MOVZ  X10, #0xf, LSL #0
TSRTAdvsimdVectorMaxMin_label_16:
    FMAX  V14.4H, V22.4H, V23.4H
    FMINV  H26, V14.8H
    FMAXNM  V14.8H, V27.8H, V31.8H
    SMIN  V22.8B, V25.8B, V24.8B
    FMAXNMP H16, V30.2H
    SMAXV  S6, V22.4S
    FMINNMP D23, V28.2D
    FMINNMP  V30.8H, V26.8H, V26.8H
    FMAXNMP S12, V21.2S
    SMAXV  H0, V6.4H
    UMAX  V22.8H, V0.8H, V0.8H
    FMAXV  S27, V31.4S
    FMAXP D12, V14.2D
    FMAXP H23, V16.2H
    FMINNMP H1, V30.2H
    UMINV  B0, V12.16B
    FMAX  V25.2D, V22.2D, V22.2D
    FMAX  V29.2D, V29.2D, V27.2D
    UMAXV  S30, V1.4S
    UMINP  V28.8B, V31.8B, V23.8B
    FMAX  V31.4H, V0.4H, V25.4H
    FMINNMP S7, V28.2S
    FMINP H21, V30.2H
    FMINNMV  S28, V31.4S
    FMINP  V7.8H, V7.8H, V28.8H
    FMAXP D6, V7.2D
    UMINV  H30, V21.8H
    FMINP D25, V30.2D
    FMINP  V21.8H, V6.8H, V29.8H
    UMINV  S7, V25.4S
    FMAXV  H1, V21.8H
    SMAXV  H27, V7.8H
    FMAXNMV  S24, V1.4S
    FMAXNMV  S25, V31.4S
    SMINV  H31, V25.4H
    SMINV  H25, V24.8H
    FMINNM  V28.4S, V25.4S, V18.4S
    SMAX  V25.8B, V27.8B, V28.8B
    FMINP  V23.8H, V25.8H, V25.8H
    FMAX  V21.2S, V31.2S, V31.2S
    FMAX  V28.8H, V21.8H, V23.8H
    UMAXP  V18.4H, V20.4H, V15.4H
    FMINNMP H1, V24.2H
    FMIN  V24.8H, V9.8H, V5.8H
    UMINV  H31, V16.4H
    FMAXV  H0, V21.8H
    SMIN  V30.4H, V13.4H, V1.4H
    FMINNMP D7, V11.2D
    SMAXV  H21, V19.4H
    SMINV  H27, V15.4H
    FMINNMV  H19, V7.8H
    FMINP H23, V24.2H
    FMAXNMP S20, V23.2S
    FMINP  V5.4H, V28.4H, V28.4H
    UMIN  V24.2S, V31.2S, V0.2S
    FMINP H23, V24.2H
    FMINP S31, V30.2S
    FMAXNM  V15.4H, V21.4H, V19.4H
    FMAXP H30, V27.2H
    FMAXNMV  H7, V18.4H
    UMIN  V28.8H, V21.8H, V31.8H
    FMINNM  V27.4H, V15.4H, V23.4H
    FMAXP S13, V5.2S
    FMINNM  V16.2D, V13.2D, V13.2D
    SMAXV  S31, V30.4S
    UMIN  V15.4H, V16.4H, V31.4H
    FMINP  V11.8H, V20.8H, V15.8H
    SMINP  V16.4S, V21.4S, V7.4S
    UMINV  B21, V16.8B
    FMINP S18, V21.2S
    FMINV  H19, V18.8H
    SMINP  V20.4S, V19.4S, V20.4S
    FMINP  V15.4H, V27.4H, V11.4H
    FMAXP D19, V20.2D
    FMINNMP  V0.2S, V5.2S, V28.2S
    FMINV  S31, V15.4S
    SMINV  H23, V31.4H
    UMIN  V31.4S, V23.4S, V23.4S
    FMAXP S5, V31.2S
    FMAXP S21, V0.2S
    UMINV  B13, V21.16B
    UMIN  V24.8H, V13.8H, V3.8H
    FMINNMV  H21, V5.4H
    FMIN  V20.4H, V19.4H, V19.4H
    SMINV  S10, V21.4S
    SMINP  V3.4S, V20.4S, V10.4S
    UMAXP  V30.8H, V24.8H, V24.8H
    UMAXP  V20.2S, V3.2S, V3.2S
    FMINP H3, V20.2H
    UMAXV  H13, V3.4H
    FMINP D19, V13.2D
    FMAXP S27, V30.2S
    FMAXV  H15, V10.4H
    FMINNMP D5, V19.2D
    FMAXNMP D21, V12.2D
    FMAXP  V24.8H, V21.8H, V27.8H
    SMINV  H7, V5.8H
    FMINNMV  S10, V13.4S
    FMINP H27, V10.2H
    SMINV  H10, V15.8H
    FMINNMP D30, V7.2D
    SMINV  B3, V30.16B
    FMAXP S7, V3.2S
    FMINV  H3, V7.8H
    SMIN  V5.16B, V3.16B, V24.16B
    SMAXP  V30.8B, V5.8B, V10.8B
    FMAXNMP  V24.4H, V27.4H, V30.4H
    SMINV  B15, V23.16B
    FMINNMV  H12, V28.8H
    SMINV  B30, V18.16B
    FMINP  V27.8H, V8.8H, V10.8H
    SMINV  H10, V15.8H
    SMINV  S21, V4.4S
    FMAXNM  V13.2S, V15.2S, V29.2S
    FMINP  V5.4S, V18.4S, V25.4S
    FMAXNM  V29.2D, V18.2D, V26.2D
    FMINNMV  S28, V29.4S
    FMAXP H15, V5.2H
    SMAXV  H23, V30.8H
    FMAXP S8, V15.2S
    FMAXP D7, V13.2D
    SMAXV  H19, V28.4H
    FMAXV  S4, V19.4S
    UMAXV  H3, V8.4H
    UMAX  V30.8B, V21.8B, V24.8B
    UMAX  V21.8B, V10.8B, V10.8B
    SMINP  V26.8B, V3.8B, V12.8B
    FMAXP H25, V30.2H
    FMIN  V24.4S, V18.4S, V23.4S
    FMAXNM  V29.4S, V7.4S, V7.4S
    FMINNMV  S12, V4.4S
    UMINV  S10, V27.4S
    UMAXV  H1, V25.8H
    UMAXV  B3, V24.16B
    FMINNMP  V18.4S, V12.4S, V21.4S
    SMAXV  H12, V26.8H
    UMINV  S5, V12.4S
    UMAXP  V12.2S, V18.2S, V1.2S
    FMINP H1, V3.2H
    FMAXV  H24, V12.4H
    FMAXNM  V23.8H, V29.8H, V31.8H
    UMAXV  S26, V10.4S
    FMAX  V15.8H, V1.8H, V26.8H
    SMAXV  B4, V24.8B
    FMINNM  V21.2D, V13.2D, V5.2D
    FMINV  H8, V21.4H
    FMAXP  V18.2S, V23.2S, V8.2S
    UMINV  H10, V24.4H
    FMINV  H30, V15.4H
    SMINP  V24.4H, V18.4H, V4.4H
    FMINNM  V7.2D, V10.2D, V10.2D
    FMAXP  V19.4S, V22.4S, V7.4S
    FMINNMP D3, V19.2D
    SMAXV  B5, V30.16B
    FMAXP H7, V24.2H
    UMINV  B23, V3.8B
    UMINV  H18, V7.4H
    FMINNM  V10.4H, V23.4H, V20.4H
    FMINNMV  H22, V10.8H
    UMAXP  V4.8H, V18.8H, V5.8H
    SMAXP  V1.8B, V22.8B, V4.8B
    FMAXNM  V8.2D, V27.2D, V29.2D
    FMAXNMP H26, V16.2H
    SMIN  V10.4H, V18.4H, V26.4H
    SMAXP  V12.16B, V3.16B, V22.16B
    FMAXNMP  V4.4H, V4.4H, V3.4H
    SMINP  V16.4H, V16.4H, V22.4H
    UMINV  H15, V20.4H
    UMINV  S19, V2.4S
    FMINV  H29, V26.4H
    SMINP  V23.16B, V19.16B, V1.16B
    FMAXP S22, V8.2S
    SMAX  V7.4S, V29.4S, V22.4S
    FMIN  V22.2S, V7.2S, V10.2S
    FMAXNMV  S2, V22.4S
    FMAXNMP  V7.4H, V2.4H, V12.4H
    FMAXP  V10.4S, V7.4S, V7.4S
    FMAX  V5.8H, V16.8H, V10.8H
    UMINV  S3, V4.4S
    FMAXNMP  V19.2D, V23.2D, V23.2D
    UMINV  S8, V15.4S
    FMAXP S27, V5.2S
    UMIN  V1.2S, V3.2S, V27.2S
    FMINV  S26, V19.4S
    UMAXP  V19.4S, V26.4S, V1.4S
    FMINV  S10, V19.4S
    FMAXP  V29.8H, V10.8H, V8.8H
    FMINNM  V27.8H, V9.8H, V7.8H
    FMAXNMP S20, V18.2S
    FMINNMV  H22, V29.4H
    UMIN  V4.4S, V5.4S, V27.4S
    FMAX  V2.4H, V16.4H, V21.4H
    FMINP  V3.4H, V22.4H, V3.4H
    UMIN  V11.16B, V11.16B, V31.16B
    FMINNMP S5, V27.2S
    FMINP S8, V20.2S
    FMINNMP  V26.4H, V2.4H, V30.4H
    FMINNM  V15.2D, V6.2D, V15.2D
    SMAXV  S22, V14.4S
    FMAX  V23.4H, V7.4H, V26.4H
    SUBS  X10, X10, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_16
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x81, LSL #0
    MRS  X15, FPSR
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V0.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D0
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V1.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D1
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V2.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D2
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V3.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D3
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V4.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D4
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V5.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D5
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V6.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D6
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V7.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D7
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V8.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D8
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V9.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D9
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V10.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D10
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V11.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D11
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V12.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D12
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V13.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D13
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V14.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D14
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V15.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D15
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V16.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D16
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V17.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D17
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V18.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D18
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V19.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D19
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V20.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D20
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V21.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D21
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V22.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D22
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V23.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D23
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V24.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D24
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V25.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D25
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V26.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D26
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V27.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D27
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V28.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D28
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V29.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D29
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V30.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D30
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, V31.D[1]
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X15, D31
    SUB  X14, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
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
    FMOV  V0.D[1], X28
    FMOV  D1, X29
    FMOV  V1.D[1], X25
    FMOV  D2, X27
    FMOV  V2.D[1], X21
    FMOV  D3, X24
    FMOV  V3.D[1], X17
    FMOV  D4, X7
    FMOV  V4.D[1], X15
    FMOV  D5, X2
    FMOV  V5.D[1], X10
    FMOV  D6, X27
    FMOV  V6.D[1], X29
    FMOV  D7, X24
    FMOV  V7.D[1], X5
    FMOV  D8, X7
    FMOV  V8.D[1], X5
    FMOV  D9, X13
    FMOV  V9.D[1], X14
    FMOV  D10, X22
    FMOV  V10.D[1], X27
    FMOV  D11, X25
    FMOV  V11.D[1], X13
    FMOV  D12, X25
    FMOV  V12.D[1], X19
    FMOV  D13, X20
    FMOV  V13.D[1], X26
    FMOV  D14, X3
    FMOV  V14.D[1], X9
    FMOV  D15, X19
    FMOV  V15.D[1], X9
    FMOV  D16, X20
    FMOV  V16.D[1], X13
    FMOV  D17, X12
    FMOV  V17.D[1], X26
    FMOV  D18, X19
    FMOV  V18.D[1], X9
    FMOV  D19, X20
    FMOV  V19.D[1], X20
    FMOV  D20, X6
    FMOV  V20.D[1], X25
    FMOV  D21, X2
    FMOV  V21.D[1], X28
    FMOV  D22, X24
    FMOV  V22.D[1], X9
    FMOV  D23, X19
    FMOV  V23.D[1], X6
    FMOV  D24, X27
    FMOV  V24.D[1], X6
    FMOV  D25, X10
    FMOV  V25.D[1], X13
    FMOV  D26, X19
    FMOV  V26.D[1], X18
    FMOV  D27, X2
    FMOV  V27.D[1], X14
    FMOV  D28, X20
    FMOV  V28.D[1], X21
    FMOV  D29, X27
    FMOV  V29.D[1], X3
    FMOV  D30, X26
    FMOV  V30.D[1], X6
    FMOV  D31, X25
    FMOV  V31.D[1], X25
    MOVZ  X10, #0xf, LSL #0
TSRTAdvsimdVectorMaxMin_label_17:
    FMINV  H22, V27.4H
    FMINP  V18.2S, V18.2S, V29.2S
    FMAXNMP  V26.4S, V22.4S, V25.4S
    FMINP  V3.8H, V30.8H, V23.8H
    FMINNMP  V15.4S, V28.4S, V24.4S
    FMINNMP  V20.8H, V26.8H, V18.8H
    FMAXNM  V9.8H, V3.8H, V31.8H
    UMAXP  V7.8B, V20.8B, V9.8B
    FMAX  V22.2S, V15.2S, V15.2S
    FMAXP  V23.2S, V7.2S, V7.2S
    UMAXV  B30, V22.8B
    FMINNMV  H4, V30.4H
    FMAXV  H7, V23.4H
    FMINNM  V27.8H, V7.8H, V7.8H
    FMAX  V25.8H, V4.8H, V27.8H
    FMINNMV  H28, V21.4H
    SMINV  H21, V21.4H
    UMAX  V18.4H, V26.4H, V27.4H
    FMINP  V29.4H, V17.4H, V7.4H
    SMAXV  S7, V11.4S
    SMINV  S23, V29.4S
    UMAXP  V24.16B, V7.16B, V7.16B
    FMINNMP  V22.8H, V25.8H, V26.8H
    FMAX  V29.4H, V30.4H, V4.4H
    FMINNMP  V3.2D, V2.2D, V29.2D
    FMAXP D31, V22.2D
    UMAX  V11.4S, V2.4S, V15.4S
    FMINNMP S15, V14.2S
    FMAXV  S7, V15.4S
    FMAXP H17, V24.2H
    FMAX  V2.2D, V3.2D, V23.2D
    FMAXNMV  H20, V31.4H
    FMAXNMV  S9, V18.4S
    FMINNMP H14, V11.2H
    SMAXV  S30, V7.4S
    SMINV  S23, V17.4S
    FMIN  V29.8H, V2.8H, V30.8H
    FMINP  V18.4H, V29.4H, V29.4H
    FMINP H7, V18.2H
    FMAXNM  V18.4H, V7.4H, V14.4H
    FMINP H17, V9.2H
    SMAXV  S27, V28.4S
    UMAXV  H7, V21.8H
    FMAXP  V2.4S, V27.4S, V13.4S
    FMAXP D30, V18.2D
    SMINP  V28.8H, V17.8H, V20.8H
    FMINP H29, V23.2H
    UMIN  V23.8B, V2.8B, V29.8B
    SMINP  V17.16B, V7.16B, V23.16B
    FMINNMP  V26.4S, V17.4S, V30.4S
    FMINNM  V11.4H, V26.4H, V28.4H
    FMAX  V2.4H, V25.4H, V13.4H
    FMAXNMP  V9.8H, V0.8H, V19.8H
    FMAXNMP S14, V5.2S
    FMINNM  V7.2D, V29.2D, V14.2D
    FMAXNMP D14, V18.2D
    SMAXV  H15, V12.8H
    FMINNMP  V28.8H, V4.8H, V9.8H
    FMAXNMP D21, V2.2D
    UMAXV  S27, V21.4S
    FMAXNM  V20.8H, V4.8H, V19.8H
    UMAXP  V31.8B, V15.8B, V3.8B
    SMIN  V18.8H, V31.8H, V4.8H
    SMINP  V23.2S, V12.2S, V31.2S
    FMAXNMP  V9.4H, V3.4H, V29.4H
    SMIN  V4.2S, V28.2S, V28.2S
    UMINV  B3, V11.8B
    FMINNM  V12.8H, V3.8H, V7.8H
    FMAX  V5.2S, V18.2S, V9.2S
    FMIN  V11.8H, V5.8H, V27.8H
    FMAXNMP S29, V11.2S
    FMINNMP  V2.2D, V12.2D, V12.2D
    FMAXP  V12.2D, V20.2D, V29.2D
    SMINV  H28, V2.4H
    FMAXNMP  V29.2S, V4.2S, V28.2S
    UMAXP  V19.8B, V23.8B, V29.8B
    SMINP  V15.2S, V12.2S, V12.2S
    FMAXP  V31.8H, V19.8H, V14.8H
    FMINNMV  S28, V31.4S
    UMINP  V21.8H, V15.8H, V28.8H
    FMAXNMV  H4, V20.4H
    FMAXP  V3.4S, V17.4S, V14.4S
    FMAXP H11, V24.2H
    FMINP  V20.2D, V30.2D, V29.2D
    FMAXV  S7, V9.4S
    SMINV  B30, V1.16B
    FMIN  V18.8H, V29.8H, V20.8H
    UMAXP  V31.8H, V9.8H, V2.8H
    FMINV  S5, V26.4S
    FMAXNMP S1, V21.2S
    FMAXNM  V27.2S, V30.2S, V3.2S
    FMINV  S12, V5.4S
    FMAXV  S14, V3.4S
    FMAX  V29.8H, V7.8H, V4.8H
    FMAXNMP  V17.8H, V18.8H, V14.8H
    FMAXNM  V20.4H, V11.4H, V31.4H
    FMAXNMP  V11.8H, V1.8H, V17.8H
    FMAXNMP  V15.2S, V15.2S, V12.2S
    UMAX  V23.2S, V20.2S, V15.2S
    FMINP  V30.2S, V27.2S, V27.2S
    FMAXNMV  H2, V23.8H
    UMINV  B21, V11.16B
    FMAXNM  V14.2D, V29.2D, V21.2D
    SMINV  S5, V26.4S
    FMAXV  H23, V30.4H
    SMAXV  H11, V2.8H
    FMAXNMP S15, V11.2S
    FMAXV  H9, V23.4H
    FMAXP  V12.4H, V14.4H, V14.4H
    SMAX  V14.16B, V15.16B, V15.16B
    SMIN  V26.4H, V9.4H, V12.4H
    FMAX  V12.4H, V14.4H, V26.4H
    FMAXNM  V27.4S, V5.4S, V5.4S
    FMINNMP S3, V12.2S
    FMINP  V4.4H, V27.4H, V27.4H
    FMINV  H5, V4.8H
    FMAXNMP  V15.2S, V3.2S, V3.2S
    FMAXNMV  H9, V6.4H
    UMAX  V23.2S, V9.2S, V15.2S
    FMINNM  V26.2S, V5.2S, V23.2S
    FMINV  H4, V7.4H
    FMAX  V29.8H, V28.8H, V26.8H
    FMAXNMP D28, V29.2D
    SMAXV  H15, V28.8H
    FMINNM  V14.2S, V20.2S, V11.2S
    FMAXNMV  S5, V31.4S
    UMAX  V21.4S, V31.4S, V27.4S
    SMAX  V20.4H, V2.4H, V1.4H
    UMAXV  H30, V3.8H
    FMINNMV  H23, V0.4H
    FMINV  S7, V26.4S
    SMAX  V21.8B, V23.8B, V7.8B
    FMINP  V11.2D, V21.2D, V21.2D
    SMINV  H21, V4.4H
    FMINP S28, V21.2S
    UMINV  S27, V14.4S
    FMINNMP S3, V11.2S
    FMINP S29, V28.2S
    FMAX  V9.2D, V27.2D, V30.2D
    FMINV  H31, V29.4H
    UMINV  S12, V20.4S
    FMINNMP S7, V5.2S
    FMINP  V5.2S, V1.2S, V15.2S
    FMINNMP  V15.8H, V3.8H, V30.8H
    FMAXNMV  H6, V15.4H
    FMINNMP D20, V4.2D
    FMAXV  H0, V5.8H
    FMAXV  H26, V9.8H
    SMINP  V4.8B, V31.8B, V31.8B
    UMINV  B2, V7.8B
    FMINNM  V9.8H, V20.8H, V12.8H
    FMINV  S29, V2.4S
    FMINNMP  V7.4H, V29.4H, V29.4H
    FMINP D11, V6.2D
    UMAXV  B1, V0.8B
    FMAXP D30, V7.2D
    FMINNM  V7.8H, V26.8H, V4.8H
    FMAXNMP  V15.4H, V9.4H, V7.4H
    FMIN  V20.8H, V11.8H, V30.8H
    FMINNM  V11.4H, V1.4H, V1.4H
    FMINP H5, V20.2H
    FMIN  V7.2S, V5.2S, V5.2S
    FMINNMP  V21.4S, V11.4S, V28.4S
    FMAXP S3, V21.2S
    FMINNM  V31.4S, V7.4S, V7.4S
    FMINNMP S7, V15.2S
    FMINP H9, V7.2H
    UMIN  V27.4H, V3.4H, V3.4H
    FMAXNM  V2.2S, V9.2S, V31.2S
    SMIN  V5.2S, V27.2S, V27.2S
    FMINP  V21.4H, V2.4H, V5.4H
    SMAX  V20.8B, V1.8B, V13.8B
    FMAXNMV  H5, V11.8H
    FMINP H26, V8.2H
    SMINP  V27.8B, V13.8B, V17.8B
    UMAXV  B15, V21.16B
    UMAX  V2.8H, V9.8H, V19.8H
    FMINNMP H28, V12.2H
    FMAXP D30, V18.2D
    FMAXV  H18, V27.8H
    FMAX  V27.2S, V6.2S, V21.2S
    FMINV  H31, V27.4H
    SMINP  V8.4H, V5.4H, V26.4H
    FMAX  V19.2D, V15.2D, V2.2D
    FMINP H1, V28.2H
    FMINP S3, V1.2S
    SMIN  V2.16B, V8.16B, V20.16B
    SMINP  V8.8H, V3.8H, V31.8H
    FMAXP  V12.2D, V8.2D, V29.2D
    FMAXP S7, V20.2S
    FMAXP D6, V19.2D
    FMINNMP  V1.8H, V18.8H, V30.8H
    UMIN  V21.4S, V2.4S, V6.4S
    FMINP S6, V21.2S
    FMAXP  V27.2S, V1.2S, V12.2S
    FMAXNMV  S12, V27.4S
    FMAXP H11, V7.2H
    FMAX  V20.2D, V6.2D, V12.2D
    FMAXP S29, V20.2S
    FMINV  S20, V13.4S
    SUBS  X10, X10, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_17
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x81, LSL #0
    MRS  X6, FPSR
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V0.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, D0
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V1.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, D1
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V2.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, D2
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V3.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, D3
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V4.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, D4
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V5.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, D5
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V6.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, D6
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V7.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, D7
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V8.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, D8
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V9.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, D9
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X6, V10.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X6, D10
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V11.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, D11
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V12.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, D12
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X6, V13.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X6, D13
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V14.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, D14
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V15.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, D15
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X6, V16.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X6, D16
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V17.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, D17
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V18.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    FMOV  X6, D18
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V19.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, D19
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V20.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    FMOV  X6, D20
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V21.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, D21
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V22.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, D22
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V23.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, D23
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V24.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, D24
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V25.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, D25
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V26.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, D26
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V27.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, D27
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V28.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, D28
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V29.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, D29
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V30.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, D30
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, V31.D[1]
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X6, D31
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x8032, LSL #0
    MOVK  X2, #0x5419, LSL #16
    MOVK  X2, #0xe27f, LSL #32
    MOVK  X2, #0x4632, LSL #48
    MOVZ  X3, #0xbccb, LSL #0
    MOVK  X3, #0xaab3, LSL #16
    MOVK  X3, #0xa41f, LSL #32
    MOVK  X3, #0xaa5d, LSL #48
    MOVZ  X5, #0xd065, LSL #0
    MOVK  X5, #0x6e5, LSL #16
    MOVK  X5, #0x2a83, LSL #32
    MOVK  X5, #0x3cce, LSL #48
    MOVZ  X6, #0x82c8, LSL #0
    MOVK  X6, #0xf0ef, LSL #16
    MOVK  X6, #0x9e63, LSL #32
    MOVK  X6, #0x9066, LSL #48
    MOVZ  X7, #0xdacc, LSL #0
    MOVK  X7, #0xf506, LSL #16
    MOVK  X7, #0xaf2b, LSL #32
    MOVK  X7, #0x4824, LSL #48
    MOVZ  X9, #0xc023, LSL #0
    MOVK  X9, #0x1ccd, LSL #16
    MOVK  X9, #0x9759, LSL #32
    MOVK  X9, #0x51e, LSL #48
    MOVZ  X10, #0x7bd4, LSL #0
    MOVK  X10, #0xd8a8, LSL #16
    MOVK  X10, #0x47be, LSL #32
    MOVK  X10, #0x2649, LSL #48
    MOVZ  X12, #0x2d1b, LSL #0
    MOVK  X12, #0x4b57, LSL #16
    MOVK  X12, #0x4407, LSL #32
    MOVK  X12, #0x390b, LSL #48
    MOVZ  X13, #0x90ee, LSL #0
    MOVK  X13, #0x5bda, LSL #16
    MOVK  X13, #0x1d, LSL #32
    MOVK  X13, #0x2dc0, LSL #48
    MOVZ  X14, #0x1925, LSL #0
    MOVK  X14, #0x1a4c, LSL #16
    MOVK  X14, #0xfb72, LSL #32
    MOVK  X14, #0x2832, LSL #48
    MOVZ  X15, #0x370a, LSL #0
    MOVK  X15, #0xabff, LSL #16
    MOVK  X15, #0x15d3, LSL #32
    MOVK  X15, #0x4161, LSL #48
    MOVZ  X16, #0x7c40, LSL #0
    MOVK  X16, #0x4ed8, LSL #16
    MOVK  X16, #0x1be7, LSL #32
    MOVK  X16, #0xb231, LSL #48
    MOVZ  X17, #0x4523, LSL #0
    MOVK  X17, #0x1676, LSL #16
    MOVK  X17, #0x8a66, LSL #32
    MOVK  X17, #0x6c6e, LSL #48
    MOVZ  X18, #0x22c9, LSL #0
    MOVK  X18, #0x99b9, LSL #16
    MOVK  X18, #0xd5d3, LSL #32
    MOVK  X18, #0x7c90, LSL #48
    MOVZ  X19, #0xd508, LSL #0
    MOVK  X19, #0x8076, LSL #16
    MOVK  X19, #0xc7a2, LSL #32
    MOVK  X19, #0xfc9f, LSL #48
    MOVZ  X20, #0x5837, LSL #0
    MOVK  X20, #0x2da, LSL #16
    MOVK  X20, #0x5a69, LSL #32
    MOVK  X20, #0xadc0, LSL #48
    MOVZ  X21, #0x78b1, LSL #0
    MOVK  X21, #0x9cd0, LSL #16
    MOVK  X21, #0xd66b, LSL #32
    MOVK  X21, #0xf6ba, LSL #48
    MOVZ  X22, #0xaa9e, LSL #0
    MOVK  X22, #0x4b7a, LSL #16
    MOVK  X22, #0x5ad6, LSL #32
    MOVK  X22, #0x90ab, LSL #48
    MOVZ  X23, #0xd1a9, LSL #0
    MOVK  X23, #0xf887, LSL #16
    MOVK  X23, #0x6dd0, LSL #32
    MOVK  X23, #0x979d, LSL #48
    MOVZ  X24, #0xebb2, LSL #0
    MOVK  X24, #0xb415, LSL #16
    MOVK  X24, #0x2509, LSL #32
    MOVK  X24, #0xb162, LSL #48
    MOVZ  X25, #0x61e7, LSL #0
    MOVK  X25, #0x2736, LSL #16
    MOVK  X25, #0x8ca7, LSL #32
    MOVK  X25, #0xee6, LSL #48
    MOVZ  X26, #0xb67d, LSL #0
    MOVK  X26, #0x560e, LSL #16
    MOVK  X26, #0x61b, LSL #32
    MOVK  X26, #0xccf8, LSL #48
    MOVZ  X27, #0xc126, LSL #0
    MOVK  X27, #0x274d, LSL #16
    MOVK  X27, #0x769e, LSL #32
    MOVK  X27, #0x568f, LSL #48
    MOVZ  X28, #0x4e9d, LSL #0
    MOVK  X28, #0xb56b, LSL #16
    MOVK  X28, #0xc4bd, LSL #32
    MOVK  X28, #0x1548, LSL #48
    MOVZ  X29, #0x32e2, LSL #0
    MOVK  X29, #0x4810, LSL #16
    MOVK  X29, #0xaec8, LSL #32
    MOVK  X29, #0xbaf8, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X27
    FMOV  D1, X25
    FMOV  V1.D[1], X23
    FMOV  D2, X29
    FMOV  V2.D[1], X28
    FMOV  D3, X17
    FMOV  V3.D[1], X23
    FMOV  D4, X14
    FMOV  V4.D[1], X16
    FMOV  D5, X15
    FMOV  V5.D[1], X6
    FMOV  D6, X2
    FMOV  V6.D[1], X23
    FMOV  D7, X19
    FMOV  V7.D[1], X7
    FMOV  D8, X16
    FMOV  V8.D[1], X10
    FMOV  D9, X13
    FMOV  V9.D[1], X26
    FMOV  D10, X19
    FMOV  V10.D[1], X28
    FMOV  D11, X28
    FMOV  V11.D[1], X28
    FMOV  D12, X25
    FMOV  V12.D[1], X29
    FMOV  D13, X15
    FMOV  V13.D[1], X16
    FMOV  D14, X2
    FMOV  V14.D[1], X6
    FMOV  D15, X16
    FMOV  V15.D[1], X12
    FMOV  D16, X5
    FMOV  V16.D[1], X10
    FMOV  D17, X17
    FMOV  V17.D[1], X25
    FMOV  D18, X25
    FMOV  V18.D[1], X21
    FMOV  D19, X16
    FMOV  V19.D[1], X23
    FMOV  D20, X14
    FMOV  V20.D[1], X2
    FMOV  D21, X29
    FMOV  V21.D[1], X25
    FMOV  D22, X16
    FMOV  V22.D[1], X21
    FMOV  D23, X26
    FMOV  V23.D[1], X5
    FMOV  D24, X28
    FMOV  V24.D[1], X19
    FMOV  D25, X23
    FMOV  V25.D[1], X14
    FMOV  D26, X2
    FMOV  V26.D[1], X18
    FMOV  D27, X12
    FMOV  V27.D[1], X19
    FMOV  D28, X26
    FMOV  V28.D[1], X12
    FMOV  D29, X26
    FMOV  V29.D[1], X7
    FMOV  D30, X20
    FMOV  V30.D[1], X27
    FMOV  D31, X21
    FMOV  V31.D[1], X25
    MOVZ  X21, #0xf, LSL #0
TSRTAdvsimdVectorMaxMin_label_18:
    FMINNM  V7.8H, V25.8H, V24.8H
    FMAXNMV  S15, V23.4S
    UMIN  V3.8H, V30.8H, V21.8H
    UMAXP  V25.8B, V19.8B, V22.8B
    UMINV  S23, V31.4S
    UMAXV  H24, V3.8H
    SMAXV  H29, V27.4H
    UMINP  V6.4S, V25.4S, V29.4S
    FMAXP H7, V6.2H
    FMINNMV  H18, V7.4H
    FMINP S10, V15.2S
    FMAX  V8.8H, V23.8H, V28.8H
    SMAXV  B21, V10.16B
    FMINNMP  V2.4H, V21.4H, V21.4H
    FMAXNMP  V21.4H, V8.4H, V24.4H
    FMAXNMP  V7.2D, V21.2D, V26.2D
    FMAXP  V23.4H, V7.4H, V2.4H
    SMAXV  S30, V23.4S
    UMAXP  V19.8H, V18.8H, V30.8H
    SMINV  H22, V17.4H
    SMINV  H24, V26.8H
    UMINV  B31, V29.16B
    FMINP S17, V23.2S
    SMAXP  V6.2S, V21.2S, V27.2S
    FMAXNMP  V30.8H, V2.8H, V21.8H
    FMAXNMV  H26, V24.4H
    FMAXP  V7.4H, V17.4H, V22.4H
    SMAXV  B10, V1.16B
    UMINV  H18, V25.8H
    UMINP  V22.8B, V9.8B, V31.8B
    FMINV  S28, V28.4S
    FMINNMP D24, V28.2D
    UMAX  V8.4S, V2.4S, V6.4S
    FMAXNM  V15.8H, V0.8H, V19.8H
    FMINP  V19.4H, V24.4H, V8.4H
    FMINV  S25, V30.4S
    FMINNMP D31, V0.2D
    FMIN  V21.4H, V25.4H, V15.4H
    SMINV  B28, V21.8B
    FMINV  H29, V28.4H
    FMINP S1, V26.2S
    FMINP H30, V7.2H
    SMAXV  S28, V29.4S
    SMAX  V17.4H, V25.4H, V19.4H
    FMAXNM  V2.8H, V31.8H, V31.8H
    UMINP  V31.2S, V1.2S, V2.2S
    FMAXNMV  H8, V30.8H
    FMAX  V15.4H, V17.4H, V31.4H
    FMAXNM  V30.4S, V8.4S, V18.4S
    FMAXP  V1.4S, V22.4S, V28.4S
    FMAXNMP H6, V1.2H
    FMAXP H21, V15.2H
    FMINNM  V31.4H, V21.4H, V30.4H
    SMINV  H17, V6.4H
    FMAXNMV  S0, V31.4S
    UMAXV  H8, V0.4H
    SMIN  V6.8B, V8.8B, V17.8B
    FMINP H28, V10.2H
    SMAXV  H0, V28.4H
    FMIN  V9.2S, V0.2S, V0.2S
    FMAXP  V18.8H, V9.8H, V9.8H
    UMAXV  S25, V18.4S
    FMINP  V9.8H, V6.8H, V25.8H
    FMAXP D31, V14.2D
    UMINV  B30, V2.16B
    FMAXNMP  V21.4H, V7.4H, V1.4H
    FMIN  V25.2D, V9.2D, V18.2D
    FMINV  H22, V30.8H
    FMINNMP S8, V9.2S
    FMAXP  V14.8H, V8.8H, V19.8H
    FMINNMP S8, V20.2S
    UMAXV  S0, V17.4S
    FMIN  V10.4H, V14.4H, V10.4H
    UMINV  B14, V8.16B
    FMINNMP S28, V11.2S
    UMAX  V1.8H, V26.8H, V10.8H
    UMINV  H6, V3.8H
    FMAXNMP  V7.4H, V1.4H, V14.4H
    FMINP  V20.4H, V21.4H, V27.4H
    FMINP  V18.2S, V28.2S, V19.2S
    SMAXV  B15, V18.8B
    FMAXNMV  H11, V22.8H
    FMAXV  H3, V20.8H
    FMINNM  V9.8H, V25.8H, V3.8H
    FMAXV  H2, V6.4H
    SMAXV  B4, V15.8B
    FMINNMP S18, V9.2S
    SMINP  V26.4S, V2.4S, V18.4S
    SMINV  S28, V11.4S
    FMINNMP D2, V4.2D
    FMAXP  V10.4H, V7.4H, V7.4H
    SMAXV  B8, V2.8B
    SMINV  B4, V26.8B
    FMAXNM  V11.4H, V8.4H, V4.4H
    SMINP  V6.8B, V11.8B, V28.8B
    SMINP  V27.4S, V6.4S, V6.4S
    FMINNM  V26.2S, V27.2S, V27.2S
    SMINV  H15, V26.4H
    FMINP  V21.2D, V10.2D, V15.2D
    UMAXV  H2, V21.8H
    FMAXP  V15.4S, V2.4S, V2.4S
    FMINV  H4, V0.4H
    UMINV  H10, V4.4H
    FMAXNMV  S7, V17.4S
    FMINNMP  V26.4H, V15.4H, V7.4H
    FMAXNM  V27.2S, V10.2S, V26.2S
    FMINNM  V11.2D, V10.2D, V13.2D
    SMAX  V9.4H, V7.4H, V22.4H
    UMINV  B17, V6.16B
    FMAXNMP H10, V6.2H
    FMAXNMP  V8.2S, V30.2S, V7.2S
    FMAX  V28.4H, V26.4H, V18.4H
    UMINP  V18.4S, V15.4S, V20.4S
    UMAXV  H15, V25.4H
    SMINV  H17, V28.4H
    FMINP  V4.8H, V27.8H, V0.8H
    FMINNM  V25.4S, V9.4S, V27.4S
    SMAX  V13.4S, V18.4S, V25.4S
    FMAXNMV  S22, V13.4S
    FMAXP H18, V4.2H
    FMAXV  S21, V11.4S
    UMINV  B9, V21.8B
    FMINNMV  H30, V18.8H
    FMINP D21, V22.2D
    FMAXNM  V2.2D, V10.2D, V9.2D
    FMINNMV  S10, V30.4S
    FMAXNMP D7, V21.2D
    UMINV  S24, V10.4S
    FMIN  V11.4H, V3.4H, V7.4H
    SMAXP  V6.8B, V30.8B, V24.8B
    UMINV  H0, V2.4H
    FMINP D4, V8.2D
    FMINNMP S18, V11.2S
    FMIN  V7.2D, V25.2D, V18.2D
    FMINNMP  V10.4S, V17.4S, V17.4S
    FMINNMV  S22, V6.4S
    UMINP  V24.8B, V22.8B, V22.8B
    FMAXP  V9.4H, V0.4H, V4.4H
    UMAXP  V3.4S, V9.4S, V9.4S
    UMAXP  V11.8H, V3.8H, V7.8H
    FMINNMP S0, V10.2S
    FMINNMP D21, V24.2D
    SMAX  V30.4H, V11.4H, V21.4H
    FMINP H25, V0.2H
    SMAXP  V17.8B, V25.8B, V8.8B
    FMAXNMP D4, V30.2D
    UMINP  V22.4S, V4.4S, V17.4S
    FMAXP  V9.4H, V10.4H, V16.4H
    FMINP  V24.4H, V26.4H, V6.4H
    FMAXP D10, V5.2D
    FMINV  H30, V24.4H
    SMAXV  H2, V1.4H
    FMINV  S21, V29.4S
    FMAXNMV  H26, V14.8H
    FMINP  V14.8H, V14.8H, V8.8H
    SMINP  V6.16B, V16.16B, V0.16B
    FMINNMV  S17, V10.4S
    FMAXP H0, V14.2H
    FMINNMP S16, V9.2S
    FMINNMP S25, V22.2S
    SMIN  V10.2S, V25.2S, V30.2S
    UMAX  V22.8H, V2.8H, V17.8H
    SMIN  V25.16B, V21.16B, V16.16B
    UMAXV  S4, V25.4S
    FMAXNM  V30.2S, V31.2S, V10.2S
    FMINNMP  V2.4H, V30.4H, V30.4H
    SMINP  V1.16B, V22.16B, V26.16B
    FMIN  V24.2D, V17.2D, V6.2D
    UMAX  V31.8H, V0.8H, V24.8H
    SMINP  V16.2S, V31.2S, V4.2S
    FMAXP D30, V2.2D
    FMINNM  V29.2D, V16.2D, V8.2D
    SMINV  B17, V1.16B
    FMINNMP S5, V30.2S
    FMAXP H0, V17.2H
    UMAXV  B25, V29.16B
    FMAXV  H8, V0.8H
    FMINNMP  V30.8H, V25.8H, V8.8H
    FMINNMV  S4, V5.4S
    FMIN  V21.2D, V4.2D, V7.2D
    FMAXNMP  V10.4S, V21.4S, V30.4S
    FMAXNM  V29.4S, V31.4S, V10.4S
    FMIN  V14.2S, V20.2S, V16.2S
    FMAXNMP  V7.8H, V5.8H, V19.8H
    FMAXNMP  V20.2S, V21.2S, V6.2S
    SMINV  H24, V26.8H
    FMINV  H22, V14.4H
    FMAXNMP  V2.4S, V19.4S, V6.4S
    UMINP  V6.8H, V5.8H, V6.8H
    SMINV  S17, V2.4S
    FMINNMP  V21.2S, V0.2S, V8.2S
    SMAX  V2.8H, V6.8H, V2.8H
    FMINP S26, V21.2S
    FMINP D31, V5.2D
    FMAXNMP H16, V22.2H
    SMINP  V22.8H, V24.8H, V20.8H
    FMINV  H10, V17.4H
    FMAXNMP S21, V22.2S
    FMINNMP D8, V2.2D
    FMAXNMV  H19, V16.4H
    SUBS  X21, X21, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_18
    MOVZ  X5, #0x8032, LSL #0
    MOVK  X5, #0x5419, LSL #16
    MOVK  X5, #0xe27f, LSL #32
    MOVK  X5, #0x4632, LSL #48
    SUB  X14, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0xbccb, LSL #0
    MOVK  X5, #0xaab3, LSL #16
    MOVK  X5, #0xa41f, LSL #32
    MOVK  X5, #0xaa5d, LSL #48
    SUB  X14, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x82c8, LSL #0
    MOVK  X5, #0xf0ef, LSL #16
    MOVK  X5, #0x9e63, LSL #32
    MOVK  X5, #0x9066, LSL #48
    SUB  X14, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0xdacc, LSL #0
    MOVK  X5, #0xf506, LSL #16
    MOVK  X5, #0xaf2b, LSL #32
    MOVK  X5, #0x4824, LSL #48
    SUB  X14, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0xc023, LSL #0
    MOVK  X5, #0x1ccd, LSL #16
    MOVK  X5, #0x9759, LSL #32
    MOVK  X5, #0x51e, LSL #48
    SUB  X14, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x7bd4, LSL #0
    MOVK  X5, #0xd8a8, LSL #16
    MOVK  X5, #0x47be, LSL #32
    MOVK  X5, #0x2649, LSL #48
    SUB  X14, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x2d1b, LSL #0
    MOVK  X5, #0x4b57, LSL #16
    MOVK  X5, #0x4407, LSL #32
    MOVK  X5, #0x390b, LSL #48
    SUB  X14, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x90ee, LSL #0
    MOVK  X5, #0x5bda, LSL #16
    MOVK  X5, #0x1d, LSL #32
    MOVK  X5, #0x2dc0, LSL #48
    SUB  X14, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x370a, LSL #0
    MOVK  X5, #0xabff, LSL #16
    MOVK  X5, #0x15d3, LSL #32
    MOVK  X5, #0x4161, LSL #48
    SUB  X14, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x7c40, LSL #0
    MOVK  X5, #0x4ed8, LSL #16
    MOVK  X5, #0x1be7, LSL #32
    MOVK  X5, #0xb231, LSL #48
    SUB  X14, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x4523, LSL #0
    MOVK  X5, #0x1676, LSL #16
    MOVK  X5, #0x8a66, LSL #32
    MOVK  X5, #0x6c6e, LSL #48
    SUB  X14, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x22c9, LSL #0
    MOVK  X5, #0x99b9, LSL #16
    MOVK  X5, #0xd5d3, LSL #32
    MOVK  X5, #0x7c90, LSL #48
    SUB  X14, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0xd508, LSL #0
    MOVK  X5, #0x8076, LSL #16
    MOVK  X5, #0xc7a2, LSL #32
    MOVK  X5, #0xfc9f, LSL #48
    SUB  X14, X5, X19
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0xaa9e, LSL #0
    MOVK  X5, #0x4b7a, LSL #16
    MOVK  X5, #0x5ad6, LSL #32
    MOVK  X5, #0x90ab, LSL #48
    SUB  X14, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0xd1a9, LSL #0
    MOVK  X5, #0xf887, LSL #16
    MOVK  X5, #0x6dd0, LSL #32
    MOVK  X5, #0x979d, LSL #48
    SUB  X14, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0xebb2, LSL #0
    MOVK  X5, #0xb415, LSL #16
    MOVK  X5, #0x2509, LSL #32
    MOVK  X5, #0xb162, LSL #48
    SUB  X14, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x61e7, LSL #0
    MOVK  X5, #0x2736, LSL #16
    MOVK  X5, #0x8ca7, LSL #32
    MOVK  X5, #0xee6, LSL #48
    SUB  X14, X5, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0xb67d, LSL #0
    MOVK  X5, #0x560e, LSL #16
    MOVK  X5, #0x61b, LSL #32
    MOVK  X5, #0xccf8, LSL #48
    SUB  X14, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0xc126, LSL #0
    MOVK  X5, #0x274d, LSL #16
    MOVK  X5, #0x769e, LSL #32
    MOVK  X5, #0x568f, LSL #48
    SUB  X14, X5, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x4e9d, LSL #0
    MOVK  X5, #0xb56b, LSL #16
    MOVK  X5, #0xc4bd, LSL #32
    MOVK  X5, #0x1548, LSL #48
    SUB  X14, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x32e2, LSL #0
    MOVK  X5, #0x4810, LSL #16
    MOVK  X5, #0xaec8, LSL #32
    MOVK  X5, #0xbaf8, LSL #48
    SUB  X14, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x81, LSL #0
    MRS  X14, FPSR
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V0.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D0
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V1.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D1
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V2.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D2
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V3.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D3
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V4.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D4
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V5.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D5
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V6.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D6
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V7.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D7
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V8.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D8
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V9.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D9
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V10.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D10
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V11.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D11
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x32e2, LSL #0
    MOVK  X5, #0x4810, LSL #16
    MOVK  X5, #0xaec8, LSL #32
    MOVK  X5, #0xbaf8, LSL #48
    FMOV  X14, V12.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x61e7, LSL #0
    MOVK  X5, #0x2736, LSL #16
    MOVK  X5, #0x8ca7, LSL #32
    MOVK  X5, #0xee6, LSL #48
    FMOV  X14, D12
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V13.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D13
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V14.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D14
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V15.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D15
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V16.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D16
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V17.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D17
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V18.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D18
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V19.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D19
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V20.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D20
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V21.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D21
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V22.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D22
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V23.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D23
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V24.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D24
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V25.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D25
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V26.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D26
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V27.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D27
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V28.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D28
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V29.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D29
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V30.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D30
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V31.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D31
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
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
    FMOV  V0.D[1], X27
    FMOV  D1, X15
    FMOV  V1.D[1], X17
    FMOV  D2, X16
    FMOV  V2.D[1], X18
    FMOV  D3, X23
    FMOV  V3.D[1], X19
    FMOV  D4, X29
    FMOV  V4.D[1], X20
    FMOV  D5, X22
    FMOV  V5.D[1], X26
    FMOV  D6, X25
    FMOV  V6.D[1], X24
    FMOV  D7, X28
    FMOV  V7.D[1], X18
    FMOV  D8, X17
    FMOV  V8.D[1], X13
    FMOV  D9, X14
    FMOV  V9.D[1], X22
    FMOV  D10, X24
    FMOV  V10.D[1], X10
    FMOV  D11, X27
    FMOV  V11.D[1], X15
    FMOV  D12, X29
    FMOV  V12.D[1], X6
    FMOV  D13, X25
    FMOV  V13.D[1], X28
    FMOV  D14, X25
    FMOV  V14.D[1], X14
    FMOV  D15, X9
    FMOV  V15.D[1], X27
    FMOV  D16, X3
    FMOV  V16.D[1], X6
    FMOV  D17, X26
    FMOV  V17.D[1], X17
    FMOV  D18, X3
    FMOV  V18.D[1], X27
    FMOV  D19, X9
    FMOV  V19.D[1], X21
    FMOV  D20, X5
    FMOV  V20.D[1], X19
    FMOV  D21, X6
    FMOV  V21.D[1], X26
    FMOV  D22, X17
    FMOV  V22.D[1], X5
    FMOV  D23, X21
    FMOV  V23.D[1], X26
    FMOV  D24, X5
    FMOV  V24.D[1], X29
    FMOV  D25, X18
    FMOV  V25.D[1], X6
    FMOV  D26, X17
    FMOV  V26.D[1], X28
    FMOV  D27, X2
    FMOV  V27.D[1], X24
    FMOV  D28, X27
    FMOV  V28.D[1], X24
    FMOV  D29, X25
    FMOV  V29.D[1], X14
    FMOV  D30, X22
    FMOV  V30.D[1], X3
    FMOV  D31, X23
    FMOV  V31.D[1], X26
    MOVZ  X29, #0xf, LSL #0
TSRTAdvsimdVectorMaxMin_label_19:
    SMINP  V10.4H, V23.4H, V26.4H
    FMINNMP D16, V30.2D
    SMAXP  V30.16B, V16.16B, V31.16B
    SMINV  B19, V20.8B
    FMINNMP  V19.8H, V21.8H, V22.8H
    FMIN  V5.4S, V19.4S, V19.4S
    SMINV  H17, V5.8H
    FMAXP  V27.2S, V25.2S, V10.2S
    FMINP S1, V30.2S
    FMINV  H0, V17.4H
    FMINNMP H26, V28.2H
    FMAXP D6, V29.2D
    FMAXNMP S13, V6.2S
    FMIN  V30.8H, V13.8H, V1.8H
    FMINP D23, V30.2D
    UMAXV  H30, V23.4H
    FMINV  S1, V27.4S
    UMAXV  B25, V1.8B
    UMIN  V22.4S, V0.4S, V13.4S
    FMAXNMP S5, V30.2S
    FMAXP S27, V26.2S
    SMIN  V26.8B, V5.8B, V27.8B
    FMAXP H6, V25.2H
    SMAXP  V5.4H, V6.4H, V22.4H
    FMAXNM  V29.8H, V5.8H, V26.8H
    FMAXP D19, V19.2D
    FMINP H13, V4.2H
    FMAXNMP D1, V23.2D
    UMINV  S4, V20.4S
    FMAXNM  V27.4H, V12.4H, V17.4H
    UMAXP  V31.4S, V22.4S, V18.4S
    UMAXV  H26, V25.4H
    FMIN  V30.4H, V1.4H, V12.4H
    FMINP H22, V4.2H
    FMAXP S17, V28.2S
    SMAX  V1.4H, V19.4H, V29.4H
    FMINP  V19.4H, V31.4H, V26.4H
    FMINP D10, V22.2D
    FMAXNMP  V5.2D, V30.2D, V27.2D
    FMAXNMP  V28.8H, V5.8H, V19.8H
    FMAXNMP S31, V27.2S
    SMINP  V12.8H, V13.8H, V13.8H
    SMAXV  B20, V28.8B
    FMINP S5, V10.2S
    UMIN  V25.8B, V5.8B, V17.8B
    SMAX  V19.8H, V1.8H, V31.8H
    FMAXNM  V18.4H, V12.4H, V12.4H
    SMINV  B30, V30.16B
    SMINP  V29.4S, V25.4S, V30.4S
    UMINV  H25, V29.4H
    SMAXV  S17, V18.4S
    FMIN  V5.8H, V20.8H, V19.8H
    FMAXNM  V4.8H, V5.8H, V25.8H
    FMINP  V27.2S, V4.2S, V17.2S
    FMAXNMP D23, V21.2D
    UMINV  B5, V1.8B
    FMAXP H22, V13.2H
    FMAX  V13.4H, V24.4H, V0.4H
    UMAXP  V28.4S, V15.4S, V21.4S
    FMINP  V1.4H, V13.4H, V20.4H
    FMINNMP  V17.4S, V27.4S, V30.4S
    FMAX  V10.4H, V20.4H, V9.4H
    FMAXNMV  H31, V18.4H
    FMAX  V12.2S, V5.2S, V25.2S
    FMAXNMP S13, V13.2S
    FMAXV  H4, V17.4H
    UMAXV  S15, V4.4S
    SMINV  B24, V23.16B
    FMINNMP  V27.2D, V22.2D, V22.2D
    FMINNMV  S20, V31.4S
    SMINV  H29, V28.4H
    SMINV  B5, V15.16B
    FMAX  V19.4H, V27.4H, V29.4H
    FMINNMV  H18, V5.8H
    UMAX  V25.2S, V12.2S, V18.2S
    FMAXP D30, V25.2D
    FMAXP S5, V10.2S
    SMAXP  V18.4H, V13.4H, V1.4H
    FMINNM  V17.8H, V24.8H, V19.8H
    FMAXP  V9.8H, V17.8H, V17.8H
    SMINV  B19, V20.16B
    SMINV  H17, V19.8H
    FMINV  S19, V30.4S
    FMAXP D12, V19.2D
    UMINP  V13.8H, V5.8H, V12.8H
    FMINV  H10, V17.4H
    FMAXNMV  S25, V18.4S
    FMINNMV  H31, V25.4H
    FMINNMP S30, V13.2S
    SMAXV  B19, V9.16B
    UMAXV  B1, V20.8B
    UMINV  S29, V19.4S
    UMINV  S5, V30.4S
    SMINP  V22.2S, V1.2S, V5.2S
    FMAXP H24, V10.2H
    UMAXV  B27, V29.16B
    FMINNM  V19.2S, V24.2S, V31.2S
    FMAXP H12, V7.2H
    UMIN  V17.4H, V19.4H, V12.4H
    FMAXNMP S19, V17.2S
    FMAXNM  V10.4H, V19.4H, V27.4H
    UMIN  V5.2S, V20.2S, V23.2S
    FMAXNMV  H20, V22.4H
    FMINP D25, V10.2D
    FMAXNMP D11, V20.2D
    SMINP  V18.16B, V11.16B, V1.16B
    FMINNMV  H30, V5.8H
    FMAXNMV  S23, V25.4S
    FMINNMV  H7, V30.4H
    FMINNMP H24, V7.2H
    FMAXNMP S22, V24.2S
    FMINV  S24, V22.4S
    SMAXV  S5, V18.4S
    FMAXNM  V10.8H, V5.8H, V12.8H
    SMINV  S1, V23.4S
    SMAXV  S27, V24.4S
    FMINP D22, V27.2D
    SMAXV  B25, V10.16B
    FMAXP H10, V25.2H
    FMAXNMP S12, V10.2S
    FMIN  V29.2S, V12.2S, V12.2S
    FMINNMV  S27, V1.4S
    FMINNMV  H5, V25.8H
    FMAXNM  V17.8H, V5.8H, V27.8H
    FMAX  V31.8H, V29.8H, V22.8H
    SMINV  B12, V31.8B
    FMAX  V10.4S, V12.4S, V12.4S
    FMAXP D23, V10.2D
    FMINP H29, V23.2H
    UMAXP  V18.4S, V17.4S, V17.4S
    FMINNMP H23, V29.2H
    SMAX  V5.16B, V23.16B, V23.16B
    FMIN  V12.2S, V5.2S, V18.2S
    SMAX  V31.8B, V1.8B, V27.8B
    FMAXP H23, V19.2H
    SMAXV  S29, V2.4S
    FMAXNMP H10, V5.2H
    UMINP  V22.16B, V20.16B, V2.16B
    UMAXV  B30, V1.16B
    SMAXP  V2.8B, V26.8B, V10.8B
    UMINV  H17, V11.4H
    FMINNMV  H20, V18.8H
    FMAXP  V10.4S, V26.4S, V29.4S
    FMAXNMP  V5.4H, V12.4H, V25.4H
    FMINNMP S25, V23.2S
    FMAXP S27, V22.2S
    FMINP  V22.4H, V20.4H, V30.4H
    SMAXP  V19.4S, V2.4S, V31.4S
    FMINP  V2.4S, V5.4S, V19.4S
    UMAX  V1.16B, V25.16B, V2.16B
    FMAXP  V26.2D, V27.2D, V22.2D
    FMINNMV  H2, V0.4H
    FMAXP  V30.2S, V17.2S, V2.2S
    FMAXNMP  V23.2S, V10.2S, V30.2S
    FMAXNMV  S19, V26.4S
    FMAXP  V0.2D, V1.2D, V23.2D
    UMAXV  H2, V19.8H
    SMAXV  S31, V0.4S
    FMAXNMP  V26.8H, V31.8H, V2.8H
    FMINNMP D25, V19.2D
    FMINNMP H14, V28.2H
    UMAXV  B29, V9.8B
    FMINP S12, V17.2S
    FMINP  V30.8H, V27.8H, V15.8H
    FMAXNM  V2.8H, V1.8H, V3.8H
    FMAXP  V18.4S, V24.4S, V1.4S
    FMAXNMP H10, V0.2H
    FMIN  V1.2S, V29.2S, V10.2S
    FMAXP  V28.8H, V26.8H, V27.8H
    UMAX  V17.8B, V30.8B, V25.8B
    FMINNMP S10, V14.2S
    FMIN  V27.2S, V2.2S, V12.2S
    FMINNMV  S29, V1.4S
    FMINV  H15, V18.4H
    FMINP  V30.8H, V28.8H, V29.8H
    FMINV  S18, V17.4S
    FMINNMP H14, V10.2H
    FMIN  V1.4H, V27.4H, V14.4H
    UMINV  B0, V23.16B
    FMINV  H12, V15.8H
    SMINV  S14, V12.4S
    UMAXV  S3, V16.4S
    SMAXV  H25, V18.4H
    FMINNMV  H24, V3.4H
    SMAXP  V3.4S, V24.4S, V30.4S
    SMINV  S23, V14.4S
    FMAXNMP  V16.4H, V23.4H, V3.4H
    FMINP H30, V1.2H
    FMAXNMP  V3.2D, V0.2D, V25.2D
    FMINNMP S12, V3.2S
    UMAX  V28.4S, V12.4S, V16.4S
    FMINP  V17.2S, V27.2S, V30.2S
    FMAXNMP  V10.8H, V28.8H, V6.8H
    SMAX  V27.16B, V17.16B, V10.16B
    FMINNM  V25.4S, V7.4S, V25.4S
    SMINP  V12.4S, V2.4S, V10.4S
    UMAXV  S16, V14.4S
    FMINP D29, V27.2D
    FMAXV  H3, V15.4H
    FMINP  V27.2D, V2.2D, V0.2D
    SUBS  X29, X29, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_19
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X14
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X21
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x81, LSL #0
    MRS  X3, FPSR
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V0.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D0
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V1.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D1
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V2.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D2
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V3.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D3
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V4.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D4
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V5.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D5
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V6.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D6
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V7.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D7
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V8.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D8
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V9.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D9
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V10.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D10
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V11.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D11
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V12.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D12
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V13.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D13
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V14.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D14
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V15.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D15
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V16.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D16
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V17.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D17
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V18.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D18
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V19.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D19
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V20.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D20
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V21.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D21
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V22.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D22
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V23.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D23
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V24.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D24
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V25.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D25
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V26.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D26
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V27.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D27
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V28.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D28
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V29.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D29
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V30.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D30
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, V31.D[1]
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X3, D31
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorMaxMin_TestFail
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
    FMOV  D0, X25
    FMOV  V0.D[1], X26
    FMOV  D1, X29
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X23
    FMOV  D3, X27
    FMOV  V3.D[1], X13
    FMOV  D4, X12
    FMOV  V4.D[1], X27
    FMOV  D5, X20
    FMOV  V5.D[1], X2
    FMOV  D6, X23
    FMOV  V6.D[1], X2
    FMOV  D7, X24
    FMOV  V7.D[1], X14
    FMOV  D8, X21
    FMOV  V8.D[1], X23
    FMOV  D9, X27
    FMOV  V9.D[1], X10
    FMOV  D10, X2
    FMOV  V10.D[1], X20
    FMOV  D11, X17
    FMOV  V11.D[1], X12
    FMOV  D12, X18
    FMOV  V12.D[1], X26
    FMOV  D13, X22
    FMOV  V13.D[1], X20
    FMOV  D14, X23
    FMOV  V14.D[1], X29
    FMOV  D15, X16
    FMOV  V15.D[1], X20
    FMOV  D16, X2
    FMOV  V16.D[1], X12
    FMOV  D17, X5
    FMOV  V17.D[1], X18
    FMOV  D18, X27
    FMOV  V18.D[1], X20
    FMOV  D19, X10
    FMOV  V19.D[1], X7
    FMOV  D20, X10
    FMOV  V20.D[1], X14
    FMOV  D21, X23
    FMOV  V21.D[1], X9
    FMOV  D22, X16
    FMOV  V22.D[1], X3
    FMOV  D23, X23
    FMOV  V23.D[1], X21
    FMOV  D24, X25
    FMOV  V24.D[1], X18
    FMOV  D25, X3
    FMOV  V25.D[1], X24
    FMOV  D26, X3
    FMOV  V26.D[1], X25
    FMOV  D27, X2
    FMOV  V27.D[1], X27
    FMOV  D28, X12
    FMOV  V28.D[1], X14
    FMOV  D29, X13
    FMOV  V29.D[1], X9
    FMOV  D30, X6
    FMOV  V30.D[1], X16
    FMOV  D31, X12
    FMOV  V31.D[1], X3
    MOVZ  X21, #0xf, LSL #0
TSRTAdvsimdVectorMaxMin_label_20:
    UMAXV  B4, V25.16B
    FMINV  H23, V31.8H
    FMAXV  S31, V29.4S
    FMIN  V19.2D, V28.2D, V23.2D
    SMAXV  B2, V27.16B
    FMINNMP  V3.8H, V22.8H, V26.8H
    FMINP  V13.2D, V24.2D, V30.2D
    FMINP H29, V19.2H
    UMAXP  V16.4S, V21.4S, V29.4S
    FMINP S0, V3.2S
    SMINV  B20, V17.16B
    UMAXV  H1, V2.8H
    FMAXP S8, V14.2S
    FMINNMV  H17, V0.8H
    FMAXNMP D2, V1.2D
    FMAX  V30.4H, V8.4H, V2.4H
    SMIN  V25.8B, V16.8B, V5.8B
    FMAXNMP  V26.8H, V17.8H, V25.8H
    FMAXNMP H17, V20.2H
    FMINNMP D0, V31.2D
    FMINP H3, V30.2H
    SMAXP  V31.8H, V13.8H, V13.8H
    SMAX  V14.16B, V31.16B, V3.16B
    SMAXV  H21, V4.4H
    FMINNMV  H16, V14.8H
    FMINP  V1.2S, V26.2S, V20.2S
    FMAXNM  V14.4H, V1.4H, V1.4H
    SMINV  H8, V0.8H
    FMAXNMP D0, V21.2D
    SMINV  B26, V14.8B
    FMAXP D14, V16.2D
    SMAXP  V29.2S, V17.2S, V8.2S
    FMINP H2, V0.2H
    FMINNM  V30.4H, V2.4H, V2.4H
    FMAXNMP S0, V29.2S
    FMAX  V5.8H, V0.8H, V14.8H
    SMINV  B21, V5.16B
    FMINV  H2, V26.4H
    FMAXNMV  H29, V2.4H
    FMINNMV  S16, V30.4S
    FMINNMP H1, V16.2H
    FMIN  V25.8H, V29.8H, V1.8H
    FMAXP  V8.4S, V25.4S, V25.4S
    SMIN  V31.4S, V21.4S, V8.4S
    SMINP  V8.4H, V12.4H, V13.4H
    UMAX  V17.2S, V25.2S, V0.2S
    UMAXV  S30, V11.4S
    FMAXNMP  V3.4H, V20.4H, V1.4H
    FMINNMP  V1.4S, V12.4S, V14.4S
    FMAXNMP H2, V31.2H
    FMAXNMV  H31, V7.8H
    FMINV  H0, V17.4H
    FMINV  H14, V19.4H
    SMAXV  H7, V7.8H
    FMAXV  H13, V14.4H
    FMINV  S6, V0.4S
    FMINV  S19, V0.4S
    UMAXV  B0, V30.8B
    FMAXP S11, V0.2S
    FMAXNMV  S12, V11.4S
    FMINNMV  H0, V6.8H
    UMIN  V29.4S, V1.4S, V12.4S
    FMINP S1, V8.2S
    FMINV  H6, V29.8H
    FMAXP  V29.4S, V0.4S, V6.4S
    FMIN  V0.2S, V19.2S, V19.2S
    FMAXP  V14.4S, V31.4S, V13.4S
    FMAXNMP  V17.4H, V7.4H, V7.4H
    FMIN  V13.2S, V29.2S, V0.2S
    FMINP  V20.4H, V1.4H, V2.4H
    UMAX  V6.8H, V20.8H, V14.8H
    UMAXV  H25, V13.4H
    FMINP  V19.8H, V6.8H, V6.8H
    UMINP  V6.8H, V17.8H, V19.8H
    UMINV  H19, V25.4H
    FMAXNMV  H30, V19.4H
    FMAXP  V29.4H, V30.4H, V30.4H
    FMAXNMV  S13, V6.4S
    FMAX  V11.8H, V29.8H, V29.8H
    FMINNM  V20.2S, V29.2S, V11.2S
    FMAXNMP  V6.8H, V20.8H, V20.8H
    FMAXP  V14.8H, V13.8H, V6.8H
    FMAXP S8, V1.2S
    UMINP  V12.8B, V16.8B, V23.8B
    FMINNMP D30, V1.2D
    SMAXP  V0.16B, V13.16B, V0.16B
    FMINNMV  H31, V30.4H
    UMIN  V6.8B, V22.8B, V20.8B
    UMIN  V2.2S, V20.2S, V1.2S
    FMINNMV  S19, V11.4S
    FMAXV  H25, V20.8H
    FMAXNM  V16.4H, V8.4H, V3.4H
    FMIN  V13.4S, V0.4S, V12.4S
    FMAXP S1, V25.2S
    SMINV  H11, V14.8H
    FMAXNMP  V7.4S, V1.4S, V11.4S
    FMAXNMP D12, V13.2D
    UMINV  H23, V2.8H
    FMINNMP  V13.8H, V19.8H, V12.8H
    FMAXNMP  V17.4S, V31.4S, V6.4S
    SMAXV  B6, V16.8B
    SMINP  V19.16B, V6.16B, V6.16B
    FMINNM  V30.4S, V17.4S, V19.4S
    SMINV  B22, V13.8B
    SMAXV  S16, V7.4S
    FMAXP  V2.4H, V16.4H, V23.4H
    FMAXNMP H13, V30.2H
    FMINNMP S29, V22.2S
    FMAXP  V0.2S, V2.2S, V13.2S
    UMINV  B31, V0.8B
    FMAXP  V20.2D, V29.2D, V31.2D
    FMINP  V6.2S, V16.2S, V23.2S
    FMAXNMV  H25, V2.8H
    FMAXP H17, V0.2H
    UMAX  V12.8H, V10.8H, V6.8H
    UMAXP  V3.8H, V26.8H, V20.8H
    UMIN  V2.2S, V18.2S, V24.2S
    FMINNMV  S19, V22.4S
    FMINNMP  V20.2D, V8.2D, V28.2D
    FMIN  V23.2D, V21.2D, V22.2D
    FMINP H22, V25.2H
    FMAXP  V21.4S, V11.4S, V20.4S
    FMINNMP D16, V0.2D
    FMINNMV  H14, V21.4H
    UMIN  V8.16B, V17.16B, V14.16B
    FMAXP H26, V12.2H
    FMINP D13, V26.2D
    FMAXP S25, V23.2S
    FMINNMP D26, V25.2D
    FMINP H10, V26.2H
    FMINNMV  H20, V22.4H
    SMINP  V26.8B, V8.8B, V20.8B
    SMAXP  V8.4H, V26.4H, V14.4H
    FMINNMV  S12, V10.4S
    FMINNMV  H21, V16.8H
    FMINNMP D10, V12.2D
    FMINNMP  V12.8H, V2.8H, V13.8H
    FMAXNMP H11, V8.2H
    FMINP D20, V12.2D
    FMAXP S26, V20.2S
    FMINP D23, V11.2D
    FMINNM  V12.8H, V21.8H, V23.8H
    FMAXNMP  V8.4H, V10.4H, V12.4H
    SMIN  V6.16B, V19.16B, V8.16B
    FMINNM  V17.4H, V26.4H, V3.4H
    FMIN  V23.4S, V17.4S, V6.4S
    FMAXV  S8, V23.4S
    SMAXV  B17, V29.8B
    SMAXV  B28, V10.16B
    FMAXP  V11.8H, V17.8H, V28.8H
    FMAXNMV  S29, V7.4S
    FMINP S12, V9.2S
    SMINV  B2, V23.8B
    UMINV  B19, V23.16B
    FMAXP S20, V22.2S
    FMAXP  V13.4S, V20.4S, V23.4S
    FMINNMV  H20, V12.4H
    FMAXNMP  V9.2D, V22.2D, V26.2D
    SMAX  V10.8B, V1.8B, V16.8B
    FMAXV  S23, V28.4S
    FMINNMV  S17, V8.4S
    FMINNMV  S14, V23.4S
    FMINNMV  S26, V11.4S
    FMINNMV  S22, V20.4S
    UMINV  S21, V19.4S
    UMAX  V16.8H, V14.8H, V22.8H
    UMINP  V14.2S, V16.2S, V16.2S
    FMAXNMP  V7.2S, V9.2S, V10.2S
    UMAXP  V10.2S, V17.2S, V13.2S
    SMINV  B23, V21.8B
    FMIN  V8.4H, V26.4H, V19.4H
    SMAXV  B22, V14.16B
    UMAXV  H20, V29.4H
    FMAXP H29, V7.2H
    FMIN  V12.4S, V29.4S, V23.4S
    FMINNM  V9.4S, V10.4S, V12.4S
    SMIN  V13.4S, V9.4S, V20.4S
    UMAXV  B9, V22.8B
    FMIN  V19.4S, V8.4S, V13.4S
    SMAXV  S20, V9.4S
    UMAXV  S10, V20.4S
    FMINNMP D26, V19.2D
    FMINP H23, V10.2H
    UMAXV  B19, V26.8B
    SMAXV  B13, V19.16B
    FMAXP  V20.8H, V13.8H, V23.8H
    UMINV  S19, V6.4S
    FMINV  H8, V21.4H
    FMINNMV  H16, V10.4H
    FMINP H10, V12.2H
    FMINV  S6, V25.4S
    FMINNMP D13, V6.2D
    FMINNMV  S29, V0.4S
    UMIN  V9.8H, V19.8H, V13.8H
    FMINNMP S0, V21.2S
    FMAX  V21.8H, V13.8H, V25.8H
    UMAXV  B25, V24.16B
    FMAXP  V13.4H, V21.4H, V10.4H
    FMAXP H21, V11.2H
    FMIN  V24.4S, V20.4S, V0.4S
    SUBS  X21, X21, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_20
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X12, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X12, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X12, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X12, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X12, X19, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X12, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X12, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X12, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X12, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X12, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X12, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X12, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X12, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X12, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X12, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X12, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X12, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X12, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X12, X19, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X12, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X12, X19, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x81, LSL #0
    MRS  X12, FPSR
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V0.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D0
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V1.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D1
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V2.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D2
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V3.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D3
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V4.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D4
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V5.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D5
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V6.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D6
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V7.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D7
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V8.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D8
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V9.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D9
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V10.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D10
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V11.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D11
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V12.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D12
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V13.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D13
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V14.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D14
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X12, V15.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X12, D15
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V16.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D16
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V17.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D17
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X12, V18.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X12, D18
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V19.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D19
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V20.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D20
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V21.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D21
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V22.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D22
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V23.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D23
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V24.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D24
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V25.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D25
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V26.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D26
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X12, V27.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X12, D27
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V28.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D28
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V29.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D29
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V30.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D30
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V31.D[1]
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D31
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail

TSRTAdvsimdVectorMaxMin_TestEnd:
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
TSRTAdvsimdVectorMaxMin_TestFail:
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
