.global TaishanSimdComplexP01

.text
.p2align 4

TaishanSimdComplexP01:

TaishanSimdComplexP01_TestBegin:
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
    MOVK  X2, #0xbbc5, LSL #48
    MOVK  X2, #0xa8c1, LSL #32
    MOVK  X2, #0xbac0, LSL #16
    MOVK  X2, #0x7fa9, LSL #0
    MOVK  X3, #0x397c, LSL #48
    MOVK  X3, #0x80ed, LSL #32
    MOVK  X3, #0x7592, LSL #16
    MOVK  X3, #0x8d96, LSL #0
    MOVK  X4, #0x1c61, LSL #48
    MOVK  X4, #0x88da, LSL #32
    MOVK  X4, #0x33dc, LSL #16
    MOVK  X4, #0x70b, LSL #0
    MOVK  X5, #0xebac, LSL #48
    MOVK  X5, #0x1828, LSL #32
    MOVK  X5, #0xe24f, LSL #16
    MOVK  X5, #0xa5c4, LSL #0
    MOVK  X6, #0x70cc, LSL #48
    MOVK  X6, #0xa68e, LSL #32
    MOVK  X6, #0x6b47, LSL #16
    MOVK  X6, #0x984d, LSL #0
    MOVK  X7, #0xfbf9, LSL #48
    MOVK  X7, #0x1826, LSL #32
    MOVK  X7, #0x84d5, LSL #16
    MOVK  X7, #0x35d1, LSL #0
    MOVK  X8, #0xcfa0, LSL #48
    MOVK  X8, #0xde47, LSL #32
    MOVK  X8, #0x172f, LSL #16
    MOVK  X8, #0xbf46, LSL #0
    MOVK  X9, #0xccdf, LSL #48
    MOVK  X9, #0x33fa, LSL #32
    MOVK  X9, #0x839c, LSL #16
    MOVK  X9, #0x1741, LSL #0
    MOVK  X10, #0xeb51, LSL #48
    MOVK  X10, #0x230b, LSL #32
    MOVK  X10, #0x650e, LSL #16
    MOVK  X10, #0x4aaa, LSL #0
    MOVK  X11, #0xf51a, LSL #48
    MOVK  X11, #0x9d8a, LSL #32
    MOVK  X11, #0x8647, LSL #16
    MOVK  X11, #0xccba, LSL #0
    MOVK  X12, #0x8abe, LSL #48
    MOVK  X12, #0x3603, LSL #32
    MOVK  X12, #0x5f3c, LSL #16
    MOVK  X12, #0xae65, LSL #0
    MOVK  X13, #0xa396, LSL #48
    MOVK  X13, #0x382e, LSL #32
    MOVK  X13, #0x3a3b, LSL #16
    MOVK  X13, #0xfac8, LSL #0
    MOVK  X14, #0xd1f7, LSL #48
    MOVK  X14, #0x5d55, LSL #32
    MOVK  X14, #0x5895, LSL #16
    MOVK  X14, #0x72ba, LSL #0
    MOVK  X15, #0x8aa3, LSL #48
    MOVK  X15, #0x6987, LSL #32
    MOVK  X15, #0xa90c, LSL #16
    MOVK  X15, #0xa0df, LSL #0
    MOVK  X16, #0xd5d1, LSL #48
    MOVK  X16, #0xf6e, LSL #32
    MOVK  X16, #0xf82a, LSL #16
    MOVK  X16, #0x2c6f, LSL #0
    MOVK  X17, #0x2184, LSL #48
    MOVK  X17, #0x648e, LSL #32
    MOVK  X17, #0x7461, LSL #16
    MOVK  X17, #0x5659, LSL #0
    MOVK  X18, #0x1ad9, LSL #48
    MOVK  X18, #0x77e3, LSL #32
    MOVK  X18, #0xc758, LSL #16
    MOVK  X18, #0x8d4f, LSL #0
    MOVK  X19, #0x8d19, LSL #48
    MOVK  X19, #0x887, LSL #32
    MOVK  X19, #0x8806, LSL #16
    MOVK  X19, #0x37b, LSL #0
    MOVK  X20, #0xfc03, LSL #48
    MOVK  X20, #0x4937, LSL #32
    MOVK  X20, #0xa0f8, LSL #16
    MOVK  X20, #0x221c, LSL #0
    MOVK  X21, #0x6d49, LSL #48
    MOVK  X21, #0xca69, LSL #32
    MOVK  X21, #0x29a3, LSL #16
    MOVK  X21, #0x3e86, LSL #0
    MOVK  X22, #0xd252, LSL #48
    MOVK  X22, #0xd470, LSL #32
    MOVK  X22, #0x94a4, LSL #16
    MOVK  X22, #0x14b, LSL #0
    MOVK  X23, #0x4f48, LSL #48
    MOVK  X23, #0x9ea1, LSL #32
    MOVK  X23, #0x76a4, LSL #16
    MOVK  X23, #0x26, LSL #0
    MOVK  X24, #0x467b, LSL #48
    MOVK  X24, #0x59e3, LSL #32
    MOVK  X24, #0xcccc, LSL #16
    MOVK  X24, #0x651c, LSL #0
    MOVK  X25, #0x9fce, LSL #48
    MOVK  X25, #0x782c, LSL #32
    MOVK  X25, #0xb038, LSL #16
    MOVK  X25, #0x653b, LSL #0
    MOVK  X26, #0x6bd8, LSL #48
    MOVK  X26, #0x3ae4, LSL #32
    MOVK  X26, #0x4990, LSL #16
    MOVK  X26, #0xa0ec, LSL #0
    MOVK  X28, #0x4737, LSL #48
    MOVK  X28, #0x5336, LSL #32
    MOVK  X28, #0xb536, LSL #16
    MOVK  X28, #0x63dd, LSL #0
    MOVK  X29, #0x2c62, LSL #48
    MOVK  X29, #0x9743, LSL #32
    MOVK  X29, #0xbd23, LSL #16
    MOVK  X29, #0x832e, LSL #0
    SUBS  X24, X23, X13, ASR #14
    MOVZ  X7, #0xaeb7, LSL #0
    MOVK  X7, #0x7453, LSL #16
    MSR  FPCR, X7
    MRS  X22, FPSR
    MOVZ  X29, #0xff60, LSL #0
    MOVK  X29, #0x7ff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    AND  X22, X22, X29
    MOVZ  X29, #0x0, LSL #0
    ORR  X22, X22, X29
    MSR  FPSR, X22
    ISB  SY
    MOVZ  X2, #0xf2f9, LSL #0
    MOVK  X2, #0x73bf, LSL #16
    MOVK  X2, #0xa56, LSL #32
    MOVK  X2, #0xac26, LSL #48
    MOVZ  X3, #0x79c4, LSL #0
    MOVK  X3, #0xd835, LSL #16
    MOVK  X3, #0xc994, LSL #32
    MOVK  X3, #0x3a8b, LSL #48
    MOVZ  X4, #0xace1, LSL #0
    MOVK  X4, #0xe719, LSL #16
    MOVK  X4, #0xaeb2, LSL #32
    MOVK  X4, #0x9f28, LSL #48
    MOVZ  X5, #0xe111, LSL #0
    MOVK  X5, #0x135c, LSL #16
    MOVK  X5, #0xe090, LSL #32
    MOVK  X5, #0x2c9f, LSL #48
    MOVZ  X6, #0x6d0, LSL #0
    MOVK  X6, #0xf8bb, LSL #16
    MOVK  X6, #0xb4ac, LSL #32
    MOVK  X6, #0xadaf, LSL #48
    MOVZ  X7, #0x5407, LSL #0
    MOVK  X7, #0xc1fa, LSL #16
    MOVK  X7, #0xa021, LSL #32
    MOVK  X7, #0x5caf, LSL #48
    MOVZ  X8, #0xf96c, LSL #0
    MOVK  X8, #0xd416, LSL #16
    MOVK  X8, #0x6b4c, LSL #32
    MOVK  X8, #0x4115, LSL #48
    MOVZ  X9, #0xb222, LSL #0
    MOVK  X9, #0xdedc, LSL #16
    MOVK  X9, #0x5bf6, LSL #32
    MOVK  X9, #0xee86, LSL #48
    MOVZ  X10, #0x362c, LSL #0
    MOVK  X10, #0x2bd0, LSL #16
    MOVK  X10, #0xc524, LSL #32
    MOVK  X10, #0xdb5b, LSL #48
    MOVZ  X11, #0x4326, LSL #0
    MOVK  X11, #0x430, LSL #16
    MOVK  X11, #0x9eb3, LSL #32
    MOVK  X11, #0x2ed5, LSL #48
    MOVZ  X12, #0xcc41, LSL #0
    MOVK  X12, #0x2e1d, LSL #16
    MOVK  X12, #0x26de, LSL #32
    MOVK  X12, #0x3804, LSL #48
    MOVZ  X13, #0xe591, LSL #0
    MOVK  X13, #0x88, LSL #16
    MOVK  X13, #0x89b, LSL #32
    MOVK  X13, #0x4ce5, LSL #48
    MOVZ  X14, #0x188e, LSL #0
    MOVK  X14, #0x2ff7, LSL #16
    MOVK  X14, #0x67fe, LSL #32
    MOVK  X14, #0xcc92, LSL #48
    MOVZ  X15, #0x1474, LSL #0
    MOVK  X15, #0x5e6d, LSL #16
    MOVK  X15, #0x4877, LSL #32
    MOVK  X15, #0xac95, LSL #48
    MOVZ  X16, #0x8936, LSL #0
    MOVK  X16, #0x7906, LSL #16
    MOVK  X16, #0xff8b, LSL #32
    MOVK  X16, #0xaabd, LSL #48
    MOVZ  X17, #0xc6a4, LSL #0
    MOVK  X17, #0x15d7, LSL #16
    MOVK  X17, #0x7ce3, LSL #32
    MOVK  X17, #0xf742, LSL #48
    MOVZ  X18, #0x70ca, LSL #0
    MOVK  X18, #0x1520, LSL #16
    MOVK  X18, #0x6455, LSL #32
    MOVK  X18, #0x5665, LSL #48
    MOVZ  X19, #0x5d0d, LSL #0
    MOVK  X19, #0xa061, LSL #16
    MOVK  X19, #0xb1bd, LSL #32
    MOVK  X19, #0x40b8, LSL #48
    MOVZ  X20, #0x75f0, LSL #0
    MOVK  X20, #0xf911, LSL #16
    MOVK  X20, #0x8111, LSL #32
    MOVK  X20, #0xb8be, LSL #48
    MOVZ  X21, #0xf98e, LSL #0
    MOVK  X21, #0x914a, LSL #16
    MOVK  X21, #0xc747, LSL #32
    MOVK  X21, #0x7d16, LSL #48
    MOVZ  X22, #0x50b0, LSL #0
    MOVK  X22, #0xec7a, LSL #16
    MOVK  X22, #0x3e1e, LSL #32
    MOVK  X22, #0x9dd7, LSL #48
    MOVZ  X23, #0x715b, LSL #0
    MOVK  X23, #0x663, LSL #16
    MOVK  X23, #0x42ec, LSL #32
    MOVK  X23, #0x8665, LSL #48
    MOVZ  X24, #0xaa90, LSL #0
    MOVK  X24, #0x66dd, LSL #16
    MOVK  X24, #0x3d57, LSL #32
    MOVK  X24, #0xefda, LSL #48
    MOVZ  X25, #0xe320, LSL #0
    MOVK  X25, #0x446b, LSL #16
    MOVK  X25, #0x1f82, LSL #32
    MOVK  X25, #0x56c5, LSL #48
    MOVZ  X26, #0x978a, LSL #0
    MOVK  X26, #0x1dbd, LSL #16
    MOVK  X26, #0x6a28, LSL #32
    MOVK  X26, #0xe402, LSL #48
    MOVZ  X28, #0x5002, LSL #0
    MOVK  X28, #0x88c3, LSL #16
    MOVK  X28, #0x9df4, LSL #32
    MOVK  X28, #0xb05e, LSL #48
    MOVZ  X29, #0xf8a6, LSL #0
    MOVK  X29, #0x90f7, LSL #16
    MOVK  X29, #0xf305, LSL #32
    MOVK  X29, #0x4881, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X2
    FMOV  D1, X23
    FMOV  V1.D[1], X10
    FMOV  D2, X9
    FMOV  V2.D[1], X21
    FMOV  D3, X8
    FMOV  V3.D[1], X28
    FMOV  D4, X19
    FMOV  V4.D[1], X14
    FMOV  D5, X16
    FMOV  V5.D[1], X20
    FMOV  D6, X11
    FMOV  V6.D[1], X26
    FMOV  D7, X17
    FMOV  V7.D[1], X12
    FMOV  D8, X14
    FMOV  V8.D[1], X4
    FMOV  D9, X8
    FMOV  V9.D[1], X17
    FMOV  D10, X3
    FMOV  V10.D[1], X8
    FMOV  D11, X26
    FMOV  V11.D[1], X12
    FMOV  D12, X28
    FMOV  V12.D[1], X24
    FMOV  D13, X8
    FMOV  V13.D[1], X9
    FMOV  D14, X20
    FMOV  V14.D[1], X10
    FMOV  D15, X26
    FMOV  V15.D[1], X26
    FMOV  D16, X29
    FMOV  V16.D[1], X7
    FMOV  D17, X7
    FMOV  V17.D[1], X9
    FMOV  D18, X7
    FMOV  V18.D[1], X12
    FMOV  D19, X11
    FMOV  V19.D[1], X17
    FMOV  D20, X28
    FMOV  V20.D[1], X21
    FMOV  D21, X5
    FMOV  V21.D[1], X24
    FMOV  D22, X8
    FMOV  V22.D[1], X20
    FMOV  D23, X14
    FMOV  V23.D[1], X15
    FMOV  D24, X9
    FMOV  V24.D[1], X9
    FMOV  D25, X5
    FMOV  V25.D[1], X21
    FMOV  D26, X13
    FMOV  V26.D[1], X12
    FMOV  D27, X24
    FMOV  V27.D[1], X5
    FMOV  D28, X24
    FMOV  V28.D[1], X17
    FMOV  D29, X4
    FMOV  V29.D[1], X24
    FMOV  D30, X10
    FMOV  V30.D[1], X20
    FMOV  D31, X5
    FMOV  V31.D[1], X21
    MOVZ  X7, #0xa, LSL #0
TaishanSimdComplexP01_label_0:
    UMINP  V28.4H, V29.4H, V6.4H
    FADDP S28, V27.2S
    FADDP D6, V13.2D
    FMAXP  V7.2S, V10.2S, V25.2S
    UMINP  V24.4S, V28.4S, V11.4S
    FADDP  V12.2S, V31.2S, V9.2S
    UMAXP  V6.8H, V26.8H, V26.8H
    FMINNMP  V25.2S, V11.2S, V24.2S
    SMINP  V21.16B, V22.16B, V31.16B
    SMINP  V30.8B, V11.8B, V26.8B
    SMINP  V9.2S, V1.2S, V29.2S
    ADDP  V15.4S, V25.4S, V31.4S
    UMAXP  V15.8H, V21.8H, V0.8H
    FMINP  V16.2S, V23.2S, V2.2S
    FMINNMP S16, V21.2S
    FMINP  V18.2S, V9.2S, V30.2S
    FMAXP  V14.2D, V2.2D, V8.2D
    FMAXNMP  V13.2S, V0.2S, V28.2S
    UMAXP  V23.8B, V14.8B, V13.8B
    FMAXP D25, V15.2D
    FMAXP S18, V13.2S
    FMINNMP  V21.2S, V19.2S, V8.2S
    ADDP  V30.2D, V22.2D, V10.2D
    FMINNMP  V30.4S, V6.4S, V6.4S
    ADDP  V10.4S, V30.4S, V23.4S
    FMINP  V2.4S, V5.4S, V11.4S
    FMINNMP D7, V21.2D
    FMINP D29, V16.2D
    UMAXP  V2.8B, V1.8B, V17.8B
    ADDP  D13, V1.2D
    FADDP D6, V13.2D
    FMINP D18, V1.2D
    FMAXNMP D25, V5.2D
    FMINNMP S2, V16.2S
    ADDP  D22, V7.2D
    UMINP  V21.8B, V26.8B, V2.8B
    SMINP  V10.4H, V24.4H, V9.4H
    FMINNMP  V2.4S, V21.4S, V8.4S
    UMINP  V24.8H, V1.8H, V8.8H
    FADDP D26, V15.2D
    FMAXP  V19.4S, V23.4S, V19.4S
    FMAXP S19, V19.2S
    FMINP D15, V6.2D
    FMINP S6, V6.2S
    UMAXP  V19.16B, V20.16B, V3.16B
    FMAXNMP S9, V6.2S
    FMINNMP D17, V1.2D
    UMINP  V23.2S, V4.2S, V2.2S
    FMAXP D2, V9.2D
    FADDP D17, V22.2D
    FMAXP  V25.2D, V21.2D, V24.2D
    FMAXNMP  V0.2D, V12.2D, V21.2D
    SMAXP  V6.4S, V12.4S, V16.4S
    FMINNMP S20, V5.2S
    ADDP  D18, V0.2D
    FMINNMP S26, V31.2S
    FMAXNMP D28, V21.2D
    FMAXP D31, V18.2D
    FMINP D7, V3.2D
    UMINP  V24.4H, V15.4H, V1.4H
    FADDP D21, V28.2D
    FMINP  V23.4S, V6.4S, V8.4S
    FADDP  V8.2D, V3.2D, V23.2D
    FMINNMP  V15.2D, V31.2D, V28.2D
    FMAXNMP S8, V8.2S
    FADDP S22, V28.2S
    FMINP  V20.2D, V18.2D, V5.2D
    FMAXP D0, V20.2D
    FMINP  V26.4S, V7.4S, V8.4S
    FMINP D22, V21.2D
    ADDP  D4, V13.2D
    SMAXP  V2.8H, V16.8H, V2.8H
    SMINP  V20.4H, V13.4H, V23.4H
    FMINNMP D15, V12.2D
    FMAXP D16, V21.2D
    FMAXP S15, V19.2S
    FMINNMP S16, V20.2S
    ADDP  V26.2D, V15.2D, V0.2D
    FMAXNMP D25, V12.2D
    FADDP  V23.2S, V17.2S, V6.2S
    ADDP  D4, V17.2D
    UMAXP  V3.4S, V28.4S, V4.4S
    FADDP D21, V24.2D
    UMINP  V14.4H, V10.4H, V23.4H
    FMAXP  V12.4S, V18.4S, V2.4S
    FMINNMP S14, V14.2S
    FMAXNMP D27, V14.2D
    FMINNMP S19, V7.2S
    FMAXNMP  V22.4S, V19.4S, V29.4S
    FMAXP D0, V18.2D
    SMINP  V13.4H, V22.4H, V16.4H
    SMINP  V4.8H, V21.8H, V26.8H
    SMINP  V0.8H, V23.8H, V9.8H
    FMAXNMP D14, V25.2D
    FMAXNMP  V20.4S, V15.4S, V18.4S
    FMINNMP S15, V13.2S
    FADDP S5, V17.2S
    FMAXNMP  V27.2S, V24.2S, V2.2S
    ADDP  D17, V25.2D
    FMINNMP  V15.4S, V4.4S, V9.4S
    FMINP  V7.4S, V27.4S, V26.4S
    FMINP S17, V3.2S
    FMAXP  V15.2S, V20.2S, V13.2S
    UMAXP  V9.4S, V18.4S, V26.4S
    FADDP  V20.2S, V27.2S, V20.2S
    FMAXP S7, V31.2S
    FMINP  V19.2D, V27.2D, V28.2D
    SMAXP  V13.2S, V6.2S, V30.2S
    UMAXP  V3.2S, V17.2S, V16.2S
    FMAXNMP  V27.2D, V15.2D, V19.2D
    FMAXP  V13.4S, V26.4S, V20.4S
    UMINP  V5.8H, V23.8H, V14.8H
    ADDP  V9.2S, V5.2S, V1.2S
    FADDP  V26.4S, V18.4S, V19.4S
    FMINNMP D0, V15.2D
    FMINNMP S7, V0.2S
    FMINNMP D13, V20.2D
    SMAXP  V13.8H, V0.8H, V3.8H
    FMAXNMP S26, V6.2S
    ADDP  V23.8H, V23.8H, V17.8H
    FMAXP S14, V20.2S
    ADDP  V15.8H, V16.8H, V0.8H
    SMAXP  V7.2S, V28.2S, V16.2S
    FMAXP  V30.4S, V4.4S, V18.4S
    FADDP  V31.2D, V22.2D, V13.2D
    FMINP S3, V22.2S
    SMINP  V18.2S, V23.2S, V6.2S
    ADDP  D27, V1.2D
    UMINP  V14.4S, V8.4S, V22.4S
    UMAXP  V14.8B, V30.8B, V25.8B
    FMINNMP S23, V15.2S
    FMINP S29, V26.2S
    FMINP S23, V17.2S
    SMINP  V10.8B, V8.8B, V21.8B
    FMAXP  V15.2D, V22.2D, V12.2D
    FMINNMP  V18.2D, V30.2D, V6.2D
    FMAXNMP D2, V26.2D
    UMINP  V11.8H, V18.8H, V28.8H
    SMINP  V3.8H, V12.8H, V26.8H
    FMAXP  V20.2S, V7.2S, V4.2S
    ADDP  D8, V5.2D
    FMINNMP  V21.4S, V13.4S, V2.4S
    FMAXP  V14.4S, V12.4S, V2.4S
    SMINP  V6.2S, V26.2S, V28.2S
    FMINNMP  V12.4S, V24.4S, V0.4S
    FMINP D7, V26.2D
    UMINP  V21.4H, V0.4H, V30.4H
    FMAXP D5, V14.2D
    FMAXNMP S0, V6.2S
    FMAXP S22, V0.2S
    FMINNMP D18, V3.2D
    ADDP  D2, V7.2D
    FMINNMP  V25.2S, V18.2S, V29.2S
    UMINP  V7.16B, V3.16B, V5.16B
    FMINNMP S10, V21.2S
    SMINP  V27.2S, V7.2S, V17.2S
    FMAXP S4, V28.2S
    FADDP  V13.2S, V23.2S, V28.2S
    FADDP  V11.2S, V20.2S, V11.2S
    FMINNMP S21, V8.2S
    ADDP  D25, V14.2D
    SMINP  V14.8H, V14.8H, V22.8H
    FADDP  V30.2S, V7.2S, V16.2S
    FMAXNMP D10, V12.2D
    ADDP  D2, V25.2D
    SMAXP  V25.8H, V7.8H, V6.8H
    SMAXP  V23.8B, V29.8B, V25.8B
    ADDP  V27.4S, V9.4S, V16.4S
    UMINP  V14.4S, V7.4S, V14.4S
    ADDP  V14.4S, V5.4S, V24.4S
    SMAXP  V0.4S, V3.4S, V10.4S
    FMAXP S4, V28.2S
    FMINNMP S20, V29.2S
    FADDP S4, V20.2S
    FMAXP  V15.2S, V23.2S, V29.2S
    SMAXP  V14.4H, V12.4H, V13.4H
    UMINP  V17.8B, V27.8B, V7.8B
    ADDP  V30.4H, V6.4H, V15.4H
    UMINP  V0.8H, V21.8H, V7.8H
    FMINNMP S13, V9.2S
    FMAXNMP S6, V13.2S
    FMINNMP D25, V18.2D
    FMINNMP D5, V19.2D
    FMINP  V15.4S, V6.4S, V5.4S
    FMINNMP  V23.4S, V19.4S, V25.4S
    SMAXP  V16.2S, V31.2S, V18.2S
    FMINNMP S17, V29.2S
    UMAXP  V26.16B, V30.16B, V14.16B
    FMINP S29, V19.2S
    FADDP S3, V27.2S
    FMAXP S1, V4.2S
    FMINNMP D25, V19.2D
    UMAXP  V8.4H, V21.4H, V13.4H
    FADDP D6, V18.2D
    FMINP S25, V14.2S
    FMAXNMP D4, V23.2D
    SMAXP  V10.16B, V0.16B, V30.16B
    SMAXP  V31.8B, V0.8B, V5.8B
    FMAXP  V26.2D, V25.2D, V4.2D
    FADDP D0, V5.2D
    SUBS  X7, X7, #0x1
    B.NE  TaishanSimdComplexP01_label_0
    MOVZ  X13, #0xf2f9, LSL #0
    MOVK  X13, #0x73bf, LSL #16
    MOVK  X13, #0xa56, LSL #32
    MOVK  X13, #0xac26, LSL #48
    SUB  X22, X13, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0x79c4, LSL #0
    MOVK  X16, #0xd835, LSL #16
    MOVK  X16, #0xc994, LSL #32
    MOVK  X16, #0x3a8b, LSL #48
    SUB  X7, X16, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    MOVZ  X19, #0xace1, LSL #0
    MOVK  X19, #0xe719, LSL #16
    MOVK  X19, #0xaeb2, LSL #32
    MOVK  X19, #0x9f28, LSL #48
    SUB  X12, X19, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    MOVZ  X13, #0xe111, LSL #0
    MOVK  X13, #0x135c, LSL #16
    MOVK  X13, #0xe090, LSL #32
    MOVK  X13, #0x2c9f, LSL #48
    SUB  X6, X13, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X18, X7, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    MOVZ  X29, #0xf96c, LSL #0
    MOVK  X29, #0xd416, LSL #16
    MOVK  X29, #0x6b4c, LSL #32
    MOVK  X29, #0x4115, LSL #48
    SUB  X10, X29, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X10
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    MOVZ  X23, #0x4326, LSL #0
    MOVK  X23, #0x430, LSL #16
    MOVK  X23, #0x9eb3, LSL #32
    MOVK  X23, #0x2ed5, LSL #48
    SUB  X26, X23, X11
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X4, X18, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    MOVZ  X2, #0x188e, LSL #0
    MOVK  X2, #0x2ff7, LSL #16
    MOVK  X2, #0x67fe, LSL #32
    MOVK  X2, #0xcc92, LSL #48
    SUB  X26, X2, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    MOVZ  X7, #0x79c4, LSL #0
    MOVK  X7, #0xd835, LSL #16
    MOVK  X7, #0xc994, LSL #32
    MOVK  X7, #0x3a8b, LSL #48
    SUB  X13, X7, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X18
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0xace1, LSL #0
    MOVK  X20, #0xe719, LSL #16
    MOVK  X20, #0xaeb2, LSL #32
    MOVK  X20, #0x9f28, LSL #48
    SUB  X18, X20, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    MOVZ  X28, #0xace1, LSL #0
    MOVK  X28, #0xe719, LSL #16
    MOVK  X28, #0xaeb2, LSL #32
    MOVK  X28, #0x9f28, LSL #48
    SUB  X17, X28, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0xaa90, LSL #0
    MOVK  X16, #0x66dd, LSL #16
    MOVK  X16, #0x3d57, LSL #32
    MOVK  X16, #0xefda, LSL #48
    SUB  X14, X16, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    MOVZ  X6, #0xace1, LSL #0
    MOVK  X6, #0xe719, LSL #16
    MOVK  X6, #0xaeb2, LSL #32
    MOVK  X6, #0x9f28, LSL #48
    SUB  X25, X6, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    MOVZ  X15, #0xf96c, LSL #0
    MOVK  X15, #0xd416, LSL #16
    MOVK  X15, #0x6b4c, LSL #32
    MOVK  X15, #0x4115, LSL #48
    SUB  X11, X15, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X25, X29, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X12, D2
    MOVZ  X29, #0x0, LSL #0
    SUB  X25, X29, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X19, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X19
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X19, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X19
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X12, D4
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X19, V5.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X19, D5
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X9, D6
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X11, D7
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X19, D8
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X14, D9
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X29, D10
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X19, V11.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X19, D11
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X14, D12
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X26, D13
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X22, V14.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X22, D14
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X3, V15.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X3, D15
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X2, D16
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X29, D17
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X3, D18
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X7, D19
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X16, D20
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X5, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X5, D21
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X13, D22
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X21, V23.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X3, X22, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X21, D23
    MOVZ  X22, #0x0, LSL #0
    SUB  X3, X22, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X6, D24
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X10, X3, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X23, D25
    MOVZ  X3, #0x0, LSL #0
    SUB  X10, X3, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X9, D26
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X22, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X22
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X22, D28
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X22
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X8, D29
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
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
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X15
    FMOV  V0.D[1], X21
    FMOV  D1, X25
    FMOV  V1.D[1], X21
    FMOV  D2, X24
    FMOV  V2.D[1], X24
    FMOV  D3, X6
    FMOV  V3.D[1], X25
    FMOV  D4, X14
    FMOV  V4.D[1], X8
    FMOV  D5, X28
    FMOV  V5.D[1], X3
    FMOV  D6, X6
    FMOV  V6.D[1], X26
    FMOV  D7, X26
    FMOV  V7.D[1], X29
    FMOV  D8, X2
    FMOV  V8.D[1], X13
    FMOV  D9, X25
    FMOV  V9.D[1], X24
    FMOV  D10, X13
    FMOV  V10.D[1], X11
    FMOV  D11, X10
    FMOV  V11.D[1], X5
    FMOV  D12, X10
    FMOV  V12.D[1], X26
    FMOV  D13, X22
    FMOV  V13.D[1], X10
    FMOV  D14, X6
    FMOV  V14.D[1], X13
    FMOV  D15, X18
    FMOV  V15.D[1], X16
    FMOV  D16, X21
    FMOV  V16.D[1], X9
    FMOV  D17, X16
    FMOV  V17.D[1], X26
    FMOV  D18, X29
    FMOV  V18.D[1], X2
    FMOV  D19, X19
    FMOV  V19.D[1], X22
    FMOV  D20, X16
    FMOV  V20.D[1], X26
    FMOV  D21, X10
    FMOV  V21.D[1], X10
    FMOV  D22, X4
    FMOV  V22.D[1], X16
    FMOV  D23, X21
    FMOV  V23.D[1], X23
    FMOV  D24, X10
    FMOV  V24.D[1], X4
    FMOV  D25, X4
    FMOV  V25.D[1], X24
    FMOV  D26, X4
    FMOV  V26.D[1], X13
    FMOV  D27, X18
    FMOV  V27.D[1], X5
    FMOV  D28, X20
    FMOV  V28.D[1], X20
    FMOV  D29, X19
    FMOV  V29.D[1], X22
    FMOV  D30, X26
    FMOV  V30.D[1], X8
    FMOV  D31, X21
    FMOV  V31.D[1], X5
    MOVZ  X15, #0xa, LSL #0
TaishanSimdComplexP01_label_83:
    FMINP  V30.2S, V27.2S, V5.2S
    UMINP  V6.2S, V31.2S, V6.2S
    UMINP  V24.8H, V26.8H, V1.8H
    SMAXP  V25.8H, V4.8H, V28.8H
    FMINP  V30.2S, V10.2S, V30.2S
    ADDP  V3.4S, V31.4S, V21.4S
    FMINP S6, V6.2S
    SMINP  V22.8B, V29.8B, V0.8B
    FMAXNMP  V26.4S, V4.4S, V12.4S
    FMAXP D2, V11.2D
    FMAXNMP D24, V11.2D
    FADDP D12, V26.2D
    ADDP  V14.4H, V25.4H, V5.4H
    UMAXP  V9.8B, V1.8B, V8.8B
    FMAXNMP  V21.2D, V9.2D, V22.2D
    FMINNMP  V2.4S, V17.4S, V13.4S
    UMINP  V24.2S, V29.2S, V14.2S
    FMINNMP  V20.2D, V7.2D, V11.2D
    FMAXNMP  V7.4S, V14.4S, V31.4S
    SMAXP  V8.4H, V25.4H, V6.4H
    ADDP  D28, V15.2D
    FMAXNMP  V22.2D, V26.2D, V21.2D
    ADDP  D11, V30.2D
    FADDP S22, V27.2S
    FMAXNMP S13, V7.2S
    FADDP  V29.4S, V15.4S, V30.4S
    FMINP D11, V27.2D
    SMAXP  V4.2S, V7.2S, V7.2S
    FADDP  V3.2S, V11.2S, V8.2S
    UMINP  V3.2S, V15.2S, V3.2S
    SMAXP  V27.4S, V27.4S, V30.4S
    FMINP D8, V16.2D
    FADDP S13, V2.2S
    ADDP  D16, V19.2D
    FMAXNMP D2, V21.2D
    FMINNMP  V7.4S, V22.4S, V21.4S
    FMINNMP D26, V21.2D
    FADDP D29, V21.2D
    FMAXP  V23.4S, V15.4S, V11.4S
    SMINP  V10.8H, V15.8H, V26.8H
    FMINP D15, V18.2D
    SMINP  V28.4S, V26.4S, V7.4S
    ADDP  V8.8H, V18.8H, V30.8H
    FMAXNMP D28, V16.2D
    FADDP  V13.2S, V3.2S, V2.2S
    FADDP D6, V2.2D
    FADDP S4, V9.2S
    FMAXNMP D11, V9.2D
    UMINP  V5.8B, V18.8B, V21.8B
    SMAXP  V11.2S, V7.2S, V12.2S
    FADDP  V20.2D, V16.2D, V15.2D
    FMINP  V2.2D, V6.2D, V8.2D
    FMAXP  V2.2D, V23.2D, V16.2D
    SMINP  V0.4H, V0.4H, V15.4H
    ADDP  V15.8H, V17.8H, V23.8H
    FADDP S8, V15.2S
    UMAXP  V18.8B, V15.8B, V0.8B
    FADDP S30, V3.2S
    FMAXP  V4.2S, V26.2S, V4.2S
    FMINP  V8.2S, V20.2S, V8.2S
    FMAXP  V2.4S, V8.4S, V7.4S
    FMINP S8, V8.2S
    FADDP D19, V28.2D
    SMAXP  V6.8B, V25.8B, V27.8B
    FMINP D30, V1.2D
    FMINNMP D3, V0.2D
    ADDP  V2.4H, V25.4H, V6.4H
    FADDP  V10.2D, V15.2D, V20.2D
    FMINNMP  V0.4S, V2.4S, V5.4S
    FMINNMP D13, V3.2D
    UMAXP  V20.4S, V10.4S, V2.4S
    FMINNMP S20, V26.2S
    ADDP  V8.4S, V15.4S, V2.4S
    ADDP  V29.2S, V7.2S, V11.2S
    FMAXP S29, V4.2S
    FMINP S18, V11.2S
    FADDP S25, V0.2S
    FMAXP D31, V29.2D
    FMINNMP  V13.2S, V31.2S, V13.2S
    UMAXP  V13.8B, V4.8B, V1.8B
    FADDP D8, V12.2D
    FMAXNMP  V17.2D, V24.2D, V18.2D
    UMINP  V0.16B, V5.16B, V27.16B
    UMINP  V12.2S, V28.2S, V24.2S
    FMINP D23, V4.2D
    FMAXNMP D10, V20.2D
    UMINP  V3.2S, V20.2S, V11.2S
    SMAXP  V1.4H, V4.4H, V3.4H
    UMINP  V11.8H, V16.8H, V12.8H
    SMINP  V21.8H, V15.8H, V3.8H
    ADDP  V7.2S, V0.2S, V18.2S
    UMAXP  V28.2S, V20.2S, V7.2S
    FMINP  V17.2D, V11.2D, V13.2D
    FMINNMP  V14.4S, V17.4S, V28.4S
    FMAXP  V4.2S, V23.2S, V31.2S
    ADDP  D31, V16.2D
    FMAXNMP S27, V6.2S
    SMAXP  V20.8H, V13.8H, V17.8H
    SMAXP  V27.4S, V17.4S, V18.4S
    FMINNMP D23, V16.2D
    UMINP  V17.2S, V0.2S, V30.2S
    FMINNMP S1, V17.2S
    FMAXNMP S25, V18.2S
    FADDP D28, V27.2D
    FMAXNMP  V29.2S, V20.2S, V23.2S
    FMAXNMP D3, V12.2D
    FMINNMP  V13.4S, V23.4S, V5.4S
    FMINP D4, V7.2D
    FMAXNMP S23, V5.2S
    UMAXP  V21.8B, V20.8B, V29.8B
    ADDP  V7.4S, V29.4S, V6.4S
    FMAXNMP D16, V5.2D
    FMINP S12, V25.2S
    FMINP S12, V14.2S
    SMAXP  V19.4S, V26.4S, V9.4S
    UMAXP  V26.8H, V21.8H, V2.8H
    FMINNMP D20, V9.2D
    FMAXP  V6.2S, V22.2S, V12.2S
    FMAXP D27, V6.2D
    SMAXP  V23.4H, V30.4H, V30.4H
    FMINNMP  V20.2D, V10.2D, V2.2D
    FMAXP D3, V23.2D
    UMINP  V2.8B, V18.8B, V28.8B
    FMINNMP  V16.4S, V22.4S, V0.4S
    FMINP S14, V13.2S
    UMINP  V31.2S, V4.2S, V13.2S
    UMAXP  V27.2S, V17.2S, V8.2S
    FMINNMP D22, V29.2D
    ADDP  V30.2S, V1.2S, V26.2S
    UMAXP  V4.4H, V10.4H, V31.4H
    FMINNMP D24, V0.2D
    SMAXP  V7.16B, V22.16B, V2.16B
    FMAXNMP  V14.2D, V20.2D, V18.2D
    SMAXP  V27.8B, V28.8B, V11.8B
    FMINNMP  V8.4S, V19.4S, V20.4S
    FMINP S0, V3.2S
    FMAXP  V10.2S, V21.2S, V18.2S
    ADDP  D31, V24.2D
    ADDP  V30.4H, V1.4H, V14.4H
    FADDP S1, V8.2S
    FMINP D7, V0.2D
    FADDP D27, V1.2D
    FMAXP D26, V26.2D
    SMAXP  V14.2S, V17.2S, V11.2S
    FMINNMP  V17.2S, V20.2S, V27.2S
    ADDP  D29, V11.2D
    ADDP  V10.16B, V24.16B, V13.16B
    FADDP S29, V0.2S
    FMINNMP  V4.2D, V5.2D, V19.2D
    FMAXP D5, V5.2D
    FMAXNMP S19, V30.2S
    ADDP  V23.2S, V19.2S, V12.2S
    FMAXNMP S19, V8.2S
    FMINP  V11.4S, V26.4S, V9.4S
    FMINNMP S29, V31.2S
    FMINNMP D7, V7.2D
    FMAXNMP S31, V6.2S
    FMAXNMP  V21.4S, V31.4S, V17.4S
    FMAXP D20, V31.2D
    FADDP  V0.2S, V6.2S, V12.2S
    UMAXP  V0.4S, V17.4S, V3.4S
    FMINNMP  V6.2D, V28.2D, V15.2D
    FMINNMP S29, V27.2S
    FADDP S24, V14.2S
    FMAXNMP S22, V8.2S
    FMINP D27, V14.2D
    FMAXP S6, V20.2S
    FMAXNMP D28, V10.2D
    UMAXP  V20.8H, V14.8H, V16.8H
    FMAXNMP  V7.2S, V7.2S, V14.2S
    ADDP  D31, V29.2D
    FMAXP S20, V8.2S
    FMINNMP D23, V4.2D
    FMINNMP S28, V19.2S
    ADDP  D19, V21.2D
    FADDP  V12.4S, V17.4S, V18.4S
    FMINNMP D0, V24.2D
    FMINP S18, V16.2S
    FADDP S18, V11.2S
    UMAXP  V16.16B, V29.16B, V4.16B
    FADDP D18, V29.2D
    FMAXNMP  V12.4S, V8.4S, V20.4S
    ADDP  V12.4H, V4.4H, V20.4H
    UMINP  V8.2S, V9.2S, V29.2S
    FMINNMP D22, V8.2D
    SMINP  V17.4H, V28.4H, V16.4H
    SMAXP  V19.4S, V3.4S, V7.4S
    SMAXP  V14.4H, V4.4H, V7.4H
    FMAXNMP D25, V10.2D
    UMINP  V5.4H, V3.4H, V15.4H
    FADDP D11, V30.2D
    FADDP D24, V21.2D
    SMINP  V18.4H, V28.4H, V18.4H
    ADDP  D25, V4.2D
    SMINP  V25.4H, V20.4H, V22.4H
    FMINP  V4.2S, V15.2S, V10.2S
    ADDP  D15, V4.2D
    ADDP  V17.16B, V31.16B, V1.16B
    FMINNMP D1, V14.2D
    FMINNMP D22, V24.2D
    SUBS  X15, X15, #0x1
    B.NE  TaishanSimdComplexP01_label_83
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X10, X13, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X11
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X24, X8, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X18
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X7, V2.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X22, X21, X7
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X7, D2
    MOVZ  X21, #0x0, LSL #0
    SUB  X22, X21, X7
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X4, X24, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X26, D3
    MOVZ  X24, #0x0, LSL #0
    SUB  X4, X24, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X14, D4
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X21, V5.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X19, X8, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    FMOV  X21, D5
    MOVZ  X8, #0x0, LSL #0
    SUB  X19, X8, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X9, D6
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X10, V7.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X10, D7
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X22, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X22, D8
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X10, D9
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X3, D10
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X10, D11
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X25, V12.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X25
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X25, D12
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X25
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X14, D13
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X2, X15, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X26, D14
    MOVZ  X15, #0x0, LSL #0
    SUB  X2, X15, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X21, V15.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X28, X19, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X21, D15
    MOVZ  X19, #0x0, LSL #0
    SUB  X28, X19, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X28, X19, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X8, D16
    MOVZ  X19, #0x0, LSL #0
    SUB  X28, X19, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X16, D17
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X14, D18
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X16, D19
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X4, X8, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X9, D20
    MOVZ  X8, #0x0, LSL #0
    SUB  X4, X8, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X23, X13, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X11, D21
    MOVZ  X13, #0x0, LSL #0
    SUB  X23, X13, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X6, X25, X15
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X15, D22
    MOVZ  X25, #0x0, LSL #0
    SUB  X6, X25, X15
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X14, D23
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X5, V24.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X5, D24
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X12, D25
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X28, D26
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X23, D28
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X22, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X8, X2, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X22, D29
    MOVZ  X2, #0x0, LSL #0
    SUB  X8, X2, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
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
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X8
    FMOV  D1, X7
    FMOV  V1.D[1], X25
    FMOV  D2, X19
    FMOV  V2.D[1], X18
    FMOV  D3, X28
    FMOV  V3.D[1], X14
    FMOV  D4, X29
    FMOV  V4.D[1], X19
    FMOV  D5, X24
    FMOV  V5.D[1], X26
    FMOV  D6, X13
    FMOV  V6.D[1], X26
    FMOV  D7, X20
    FMOV  V7.D[1], X25
    FMOV  D8, X13
    FMOV  V8.D[1], X24
    FMOV  D9, X21
    FMOV  V9.D[1], X10
    FMOV  D10, X7
    FMOV  V10.D[1], X21
    FMOV  D11, X2
    FMOV  V11.D[1], X2
    FMOV  D12, X8
    FMOV  V12.D[1], X23
    FMOV  D13, X4
    FMOV  V13.D[1], X28
    FMOV  D14, X13
    FMOV  V14.D[1], X21
    FMOV  D15, X11
    FMOV  V15.D[1], X18
    FMOV  D16, X29
    FMOV  V16.D[1], X29
    FMOV  D17, X11
    FMOV  V17.D[1], X18
    FMOV  D18, X10
    FMOV  V18.D[1], X9
    FMOV  D19, X8
    FMOV  V19.D[1], X21
    FMOV  D20, X29
    FMOV  V20.D[1], X5
    FMOV  D21, X3
    FMOV  V21.D[1], X23
    FMOV  D22, X3
    FMOV  V22.D[1], X28
    FMOV  D23, X10
    FMOV  V23.D[1], X22
    FMOV  D24, X17
    FMOV  V24.D[1], X12
    FMOV  D25, X26
    FMOV  V25.D[1], X12
    FMOV  D26, X9
    FMOV  V26.D[1], X20
    FMOV  D27, X6
    FMOV  V27.D[1], X21
    FMOV  D28, X9
    FMOV  V28.D[1], X20
    FMOV  D29, X21
    FMOV  V29.D[1], X18
    FMOV  D30, X13
    FMOV  V30.D[1], X22
    FMOV  D31, X28
    FMOV  V31.D[1], X29
    MOVZ  X3, #0xf, LSL #0
TaishanSimdComplexP01_label_165:
    ADDP  D7, V24.2D
    FMAXP S9, V3.2S
    FADDP  V0.2D, V25.2D, V27.2D
    FMAXP  V0.2S, V29.2S, V14.2S
    FMINNMP  V18.4S, V25.4S, V2.4S
    FMAXP  V16.4S, V9.4S, V15.4S
    UMAXP  V24.8B, V1.8B, V27.8B
    FMAXNMP D24, V13.2D
    ADDP  D4, V9.2D
    ADDP  V14.2S, V29.2S, V21.2S
    FMINNMP D3, V21.2D
    FMAXNMP D3, V3.2D
    UMINP  V16.4H, V15.4H, V21.4H
    FMAXNMP  V18.2D, V8.2D, V24.2D
    UMAXP  V30.4H, V24.4H, V2.4H
    FMAXNMP  V29.2S, V28.2S, V3.2S
    SMAXP  V14.4H, V16.4H, V15.4H
    FMINNMP S13, V11.2S
    FADDP D19, V0.2D
    FMAXNMP S30, V4.2S
    FMINNMP S7, V14.2S
    FMINNMP S29, V14.2S
    UMAXP  V15.4S, V28.4S, V24.4S
    UMAXP  V15.2S, V25.2S, V25.2S
    FMINP D23, V15.2D
    FMINNMP D16, V25.2D
    SMINP  V31.4S, V19.4S, V22.4S
    FMINNMP S21, V15.2S
    FMINNMP S30, V23.2S
    UMAXP  V1.2S, V4.2S, V26.2S
    FADDP D8, V3.2D
    FMAXNMP  V6.2D, V29.2D, V1.2D
    SMAXP  V14.16B, V11.16B, V15.16B
    FADDP S25, V13.2S
    FMINNMP D2, V25.2D
    SMINP  V21.4H, V28.4H, V25.4H
    FADDP S28, V16.2S
    FMAXNMP S3, V15.2S
    FADDP D31, V26.2D
    FMINP D13, V16.2D
    FMINNMP S13, V5.2S
    ADDP  D13, V2.2D
    ADDP  D11, V15.2D
    FMAXP D0, V26.2D
    FMAXP  V15.2S, V0.2S, V9.2S
    FMINNMP D16, V10.2D
    FMAXP  V31.4S, V26.4S, V9.4S
    FADDP D0, V6.2D
    FMINNMP S18, V7.2S
    FMINP  V5.2S, V26.2S, V1.2S
    FMAXNMP D29, V25.2D
    ADDP  V9.4H, V6.4H, V12.4H
    FMINNMP D26, V23.2D
    UMINP  V11.2S, V1.2S, V28.2S
    FMINNMP  V20.2S, V6.2S, V2.2S
    SMINP  V11.16B, V31.16B, V13.16B
    FMINNMP  V16.2D, V13.2D, V13.2D
    FMINNMP D23, V7.2D
    FMAXP D30, V11.2D
    FMINNMP D0, V11.2D
    ADDP  V21.8H, V30.8H, V16.8H
    FMINNMP D4, V13.2D
    FMAXNMP S1, V23.2S
    SMAXP  V17.4S, V23.4S, V17.4S
    FMINP D18, V6.2D
    FADDP  V18.2S, V31.2S, V8.2S
    FMAXP  V20.2S, V3.2S, V19.2S
    FADDP S4, V0.2S
    SMINP  V10.4H, V0.4H, V12.4H
    FMINNMP  V27.2D, V25.2D, V1.2D
    UMINP  V18.4H, V17.4H, V29.4H
    FMINNMP S15, V19.2S
    UMAXP  V16.2S, V3.2S, V27.2S
    UMINP  V3.16B, V10.16B, V14.16B
    ADDP  V3.4S, V10.4S, V2.4S
    FMAXNMP D24, V7.2D
    FADDP S15, V3.2S
    FMINNMP S5, V22.2S
    FMAXNMP D9, V28.2D
    FMINP  V20.2S, V14.2S, V23.2S
    FMAXNMP D4, V3.2D
    ADDP  D18, V26.2D
    FMAXP  V13.2D, V6.2D, V26.2D
    FMINP D30, V17.2D
    ADDP  D22, V3.2D
    FMINP  V23.2S, V29.2S, V15.2S
    FMAXP D12, V15.2D
    FADDP S23, V22.2S
    UMINP  V4.2S, V13.2S, V3.2S
    UMAXP  V21.4H, V16.4H, V1.4H
    ADDP  V18.8B, V29.8B, V0.8B
    FMAXNMP D17, V11.2D
    SMINP  V11.8H, V26.8H, V4.8H
    FMINNMP  V2.2S, V6.2S, V12.2S
    FMAXP  V24.4S, V15.4S, V7.4S
    FADDP S16, V10.2S
    UMAXP  V18.4H, V24.4H, V4.4H
    FMINP S29, V6.2S
    FMAXNMP  V0.2S, V15.2S, V6.2S
    FADDP D25, V20.2D
    ADDP  D10, V26.2D
    UMINP  V31.2S, V30.2S, V1.2S
    UMAXP  V15.8B, V14.8B, V25.8B
    FADDP D25, V31.2D
    FMAXNMP S3, V21.2S
    FMAXNMP S31, V18.2S
    SMAXP  V28.16B, V5.16B, V1.16B
    ADDP  V21.4S, V29.4S, V12.4S
    FADDP  V6.2D, V16.2D, V20.2D
    FMAXNMP S16, V7.2S
    FMINP S17, V20.2S
    FMAXP D2, V11.2D
    UMAXP  V2.8B, V8.8B, V15.8B
    FMAXNMP S1, V16.2S
    FMINNMP D18, V11.2D
    ADDP  V22.8H, V8.8H, V11.8H
    FADDP  V23.2S, V20.2S, V18.2S
    FADDP  V17.2S, V21.2S, V23.2S
    FMAXNMP D5, V20.2D
    FMAXNMP  V10.2S, V0.2S, V25.2S
    FMINP  V22.4S, V24.4S, V29.4S
    FADDP S1, V18.2S
    FMAXP  V16.4S, V20.4S, V1.4S
    SMAXP  V12.4S, V26.4S, V5.4S
    ADDP  D20, V27.2D
    FMINP  V19.2S, V17.2S, V10.2S
    UMAXP  V9.8B, V18.8B, V14.8B
    FMAXNMP  V15.4S, V2.4S, V30.4S
    FMINNMP D16, V8.2D
    FMINP D1, V7.2D
    FADDP S15, V12.2S
    FMINNMP  V3.4S, V8.4S, V6.4S
    FMAXNMP S21, V24.2S
    FMINP  V11.2S, V2.2S, V11.2S
    FADDP  V8.2S, V29.2S, V31.2S
    FMAXNMP  V24.4S, V22.4S, V29.4S
    FMAXNMP  V18.4S, V7.4S, V8.4S
    FMAXNMP  V23.2S, V17.2S, V22.2S
    FMINNMP  V3.2D, V20.2D, V12.2D
    FMINP  V6.2S, V18.2S, V26.2S
    FMAXP  V6.2D, V1.2D, V12.2D
    SMAXP  V19.4H, V13.4H, V25.4H
    FMAXP  V24.4S, V0.4S, V18.4S
    FMINNMP D21, V28.2D
    UMAXP  V6.16B, V29.16B, V2.16B
    FADDP D14, V31.2D
    SMINP  V29.8H, V11.8H, V30.8H
    FMAXP S19, V28.2S
    ADDP  V15.2S, V19.2S, V1.2S
    FMINP S23, V27.2S
    UMINP  V28.8B, V15.8B, V18.8B
    FADDP D18, V21.2D
    FMINNMP S18, V23.2S
    FMINP S6, V8.2S
    UMAXP  V10.8H, V9.8H, V8.8H
    ADDP  V3.8B, V20.8B, V27.8B
    FADDP D28, V6.2D
    FMAXP D25, V15.2D
    FMAXP S6, V7.2S
    ADDP  D22, V23.2D
    UMINP  V19.2S, V20.2S, V17.2S
    FMAXP S18, V20.2S
    FMAXP  V27.2S, V23.2S, V31.2S
    FADDP  V15.2S, V30.2S, V5.2S
    FMAXNMP  V19.2D, V27.2D, V5.2D
    FADDP S9, V20.2S
    FMAXP  V4.2S, V10.2S, V4.2S
    ADDP  V25.4H, V8.4H, V22.4H
    FMAXP  V25.2D, V11.2D, V22.2D
    FMAXNMP D4, V2.2D
    UMINP  V12.2S, V16.2S, V18.2S
    FMAXNMP D3, V31.2D
    FMINNMP D1, V25.2D
    FMAXP D28, V13.2D
    FMINP  V17.4S, V15.4S, V19.4S
    FMAXNMP S22, V22.2S
    FADDP  V9.2D, V1.2D, V29.2D
    FMINNMP D3, V6.2D
    FMINP  V15.4S, V1.4S, V4.4S
    FADDP  V13.4S, V24.4S, V11.4S
    FMINNMP D29, V12.2D
    UMAXP  V21.8H, V15.8H, V7.8H
    FMINNMP S3, V16.2S
    FMAXNMP S8, V28.2S
    FMAXNMP  V28.2S, V16.2S, V8.2S
    ADDP  D8, V6.2D
    SMINP  V13.2S, V23.2S, V0.2S
    UMAXP  V22.4S, V28.4S, V8.4S
    FMAXP D0, V21.2D
    FADDP  V2.4S, V9.4S, V0.4S
    FMAXP D23, V3.2D
    FMINNMP  V31.4S, V13.4S, V12.4S
    FMINNMP D9, V22.2D
    FMINNMP  V27.2S, V7.2S, V0.2S
    FADDP D18, V3.2D
    FMAXP S17, V1.2S
    SMAXP  V23.2S, V10.2S, V0.2S
    SMINP  V15.4S, V17.4S, V6.4S
    SMAXP  V2.4S, V17.4S, V14.4S
    FMAXP D12, V22.2D
    SUBS  X3, X3, #0x1
    B.NE  TaishanSimdComplexP01_label_165
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X10, X5, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X7, X14, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X2, X26, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X28, X29, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X14, X12, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X12, X16, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X3, X9, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X8, X26, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X18
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X19, X26, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X16, X17, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X8, X24, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X22, X4, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X7, X14, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X28, X20, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X15, X16, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X5, V2.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X5, D2
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X13, X24, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X4, D3
    MOVZ  X24, #0x0, LSL #0
    SUB  X13, X24, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    FMOV  X10, D4
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    FMOV  X25, V5.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X25, D5
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X22, V6.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X22, D6
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X8, D7
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X28, D8
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X26, D9
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X26
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X26, D10
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X26
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X26, X13, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X6, D11
    MOVZ  X13, #0x0, LSL #0
    SUB  X26, X13, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X14, D12
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X11, D13
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X25, V14.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X25, D14
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X6, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X6, D15
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X24, X15, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X6, D16
    MOVZ  X15, #0x0, LSL #0
    SUB  X24, X15, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X12, X28, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X11, D17
    MOVZ  X28, #0x0, LSL #0
    SUB  X12, X28, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X24
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X24, D18
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X24
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X12, D19
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X17, D20
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X17, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X17, D21
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X25, V22.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X14, X15, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X25, D22
    MOVZ  X15, #0x0, LSL #0
    SUB  X14, X15, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X25, V23.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X25, D23
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X10, D24
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X19, V25.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X19, D25
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X7, D26
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X23, D28
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X8, D29
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    MOVZ  X2, #0x7499, LSL #0
    MOVK  X2, #0x1adf, LSL #16
    MOVK  X2, #0x178d, LSL #32
    MOVK  X2, #0x9b2, LSL #48
    MOVZ  X3, #0x8167, LSL #0
    MOVK  X3, #0x6ea8, LSL #16
    MOVK  X3, #0xb00d, LSL #32
    MOVK  X3, #0x1713, LSL #48
    MOVZ  X4, #0x3b67, LSL #0
    MOVK  X4, #0x8f77, LSL #16
    MOVK  X4, #0xcd85, LSL #32
    MOVK  X4, #0x7eff, LSL #48
    MOVZ  X5, #0x64ab, LSL #0
    MOVK  X5, #0xf5a0, LSL #16
    MOVK  X5, #0x1855, LSL #32
    MOVK  X5, #0x77f, LSL #48
    MOVZ  X6, #0xa191, LSL #0
    MOVK  X6, #0x37f6, LSL #16
    MOVK  X6, #0x5ca0, LSL #32
    MOVK  X6, #0xdc88, LSL #48
    MOVZ  X7, #0x6d58, LSL #0
    MOVK  X7, #0x2321, LSL #16
    MOVK  X7, #0xb96, LSL #32
    MOVK  X7, #0x2eb9, LSL #48
    MOVZ  X8, #0xf4ae, LSL #0
    MOVK  X8, #0xd63f, LSL #16
    MOVK  X8, #0xc132, LSL #32
    MOVK  X8, #0x17ec, LSL #48
    MOVZ  X9, #0x5c39, LSL #0
    MOVK  X9, #0x2323, LSL #16
    MOVK  X9, #0x864, LSL #32
    MOVK  X9, #0x6cf8, LSL #48
    MOVZ  X10, #0xc056, LSL #0
    MOVK  X10, #0x91ac, LSL #16
    MOVK  X10, #0x2d05, LSL #32
    MOVK  X10, #0xffd6, LSL #48
    MOVZ  X11, #0x2d22, LSL #0
    MOVK  X11, #0x7415, LSL #16
    MOVK  X11, #0x1b34, LSL #32
    MOVK  X11, #0x4868, LSL #48
    MOVZ  X12, #0x73b, LSL #0
    MOVK  X12, #0x1c6, LSL #16
    MOVK  X12, #0x8fc7, LSL #32
    MOVK  X12, #0x4c59, LSL #48
    MOVZ  X13, #0x21d0, LSL #0
    MOVK  X13, #0xad5, LSL #16
    MOVK  X13, #0xacca, LSL #32
    MOVK  X13, #0xaa3a, LSL #48
    MOVZ  X14, #0x1add, LSL #0
    MOVK  X14, #0x4ac6, LSL #16
    MOVK  X14, #0x5465, LSL #32
    MOVK  X14, #0x376d, LSL #48
    MOVZ  X15, #0x22df, LSL #0
    MOVK  X15, #0xae61, LSL #16
    MOVK  X15, #0xecfd, LSL #32
    MOVK  X15, #0x34b6, LSL #48
    MOVZ  X16, #0xd495, LSL #0
    MOVK  X16, #0x7a88, LSL #16
    MOVK  X16, #0x7396, LSL #32
    MOVK  X16, #0xf6d7, LSL #48
    MOVZ  X17, #0xfc57, LSL #0
    MOVK  X17, #0x59f1, LSL #16
    MOVK  X17, #0xb8ab, LSL #32
    MOVK  X17, #0x9d05, LSL #48
    MOVZ  X18, #0xb9b8, LSL #0
    MOVK  X18, #0xa99a, LSL #16
    MOVK  X18, #0x90f4, LSL #32
    MOVK  X18, #0x3bee, LSL #48
    MOVZ  X19, #0x4e45, LSL #0
    MOVK  X19, #0x674f, LSL #16
    MOVK  X19, #0x1aec, LSL #32
    MOVK  X19, #0x13c8, LSL #48
    MOVZ  X20, #0x206, LSL #0
    MOVK  X20, #0xccb, LSL #16
    MOVK  X20, #0x6ec7, LSL #32
    MOVK  X20, #0x1353, LSL #48
    MOVZ  X21, #0xcbf2, LSL #0
    MOVK  X21, #0xd778, LSL #16
    MOVK  X21, #0x2635, LSL #32
    MOVK  X21, #0xc2da, LSL #48
    MOVZ  X22, #0x77dc, LSL #0
    MOVK  X22, #0xedc0, LSL #16
    MOVK  X22, #0x2c25, LSL #32
    MOVK  X22, #0xb1a, LSL #48
    MOVZ  X23, #0x3e3a, LSL #0
    MOVK  X23, #0x7e23, LSL #16
    MOVK  X23, #0x49d7, LSL #32
    MOVK  X23, #0x5eac, LSL #48
    MOVZ  X24, #0xdcc3, LSL #0
    MOVK  X24, #0xca55, LSL #16
    MOVK  X24, #0xfbe, LSL #32
    MOVK  X24, #0x3fee, LSL #48
    MOVZ  X25, #0x4f79, LSL #0
    MOVK  X25, #0x48cd, LSL #16
    MOVK  X25, #0x10cf, LSL #32
    MOVK  X25, #0xac20, LSL #48
    MOVZ  X26, #0xf614, LSL #0
    MOVK  X26, #0x9b5f, LSL #16
    MOVK  X26, #0xae8c, LSL #32
    MOVK  X26, #0xe549, LSL #48
    MOVZ  X28, #0xfbfe, LSL #0
    MOVK  X28, #0x48fb, LSL #16
    MOVK  X28, #0x823b, LSL #32
    MOVK  X28, #0xcf86, LSL #48
    MOVZ  X29, #0x7f8d, LSL #0
    MOVK  X29, #0x723, LSL #16
    MOVK  X29, #0x29c7, LSL #32
    MOVK  X29, #0x4c44, LSL #48
    FMOV  D0, X15
    FMOV  V0.D[1], X4
    FMOV  D1, X26
    FMOV  V1.D[1], X14
    FMOV  D2, X22
    FMOV  V2.D[1], X22
    FMOV  D3, X26
    FMOV  V3.D[1], X26
    FMOV  D4, X15
    FMOV  V4.D[1], X28
    FMOV  D5, X29
    FMOV  V5.D[1], X11
    FMOV  D6, X13
    FMOV  V6.D[1], X25
    FMOV  D7, X2
    FMOV  V7.D[1], X5
    FMOV  D8, X29
    FMOV  V8.D[1], X17
    FMOV  D9, X28
    FMOV  V9.D[1], X14
    FMOV  D10, X29
    FMOV  V10.D[1], X14
    FMOV  D11, X16
    FMOV  V11.D[1], X14
    FMOV  D12, X6
    FMOV  V12.D[1], X7
    FMOV  D13, X13
    FMOV  V13.D[1], X11
    FMOV  D14, X24
    FMOV  V14.D[1], X19
    FMOV  D15, X6
    FMOV  V15.D[1], X6
    FMOV  D16, X19
    FMOV  V16.D[1], X20
    FMOV  D17, X7
    FMOV  V17.D[1], X22
    FMOV  D18, X23
    FMOV  V18.D[1], X9
    FMOV  D19, X21
    FMOV  V19.D[1], X10
    FMOV  D20, X28
    FMOV  V20.D[1], X21
    FMOV  D21, X16
    FMOV  V21.D[1], X9
    FMOV  D22, X16
    FMOV  V22.D[1], X20
    FMOV  D23, X21
    FMOV  V23.D[1], X24
    FMOV  D24, X26
    FMOV  V24.D[1], X21
    FMOV  D25, X21
    FMOV  V25.D[1], X11
    FMOV  D26, X13
    FMOV  V26.D[1], X18
    FMOV  D27, X26
    FMOV  V27.D[1], X7
    FMOV  D28, X10
    FMOV  V28.D[1], X22
    FMOV  D29, X2
    FMOV  V29.D[1], X6
    FMOV  D30, X25
    FMOV  V30.D[1], X24
    FMOV  D31, X14
    FMOV  V31.D[1], X5
    MOVZ  X22, #0xa, LSL #0
TaishanSimdComplexP01_label_248:
    FMAXP S28, V25.2S
    FADDP D11, V7.2D
    FMINP  V13.4S, V4.4S, V17.4S
    FMINNMP D23, V31.2D
    FMAXNMP D2, V25.2D
    FMAXP D22, V26.2D
    UMINP  V29.4H, V11.4H, V11.4H
    FADDP  V10.4S, V0.4S, V28.4S
    ADDP  V0.2D, V28.2D, V2.2D
    ADDP  V30.4S, V13.4S, V3.4S
    UMAXP  V9.8B, V25.8B, V13.8B
    FMINP  V1.4S, V1.4S, V11.4S
    SMINP  V17.2S, V27.2S, V12.2S
    UMINP  V29.4H, V29.4H, V0.4H
    FADDP S29, V1.2S
    FADDP  V5.2S, V14.2S, V3.2S
    FMINNMP D26, V25.2D
    FMAXNMP  V22.2S, V4.2S, V24.2S
    FMINNMP  V3.4S, V2.4S, V16.4S
    UMAXP  V4.4S, V21.4S, V19.4S
    FMAXP S28, V1.2S
    FMAXNMP S30, V3.2S
    FMINP  V3.2D, V23.2D, V21.2D
    FMAXNMP D25, V16.2D
    FMAXNMP D4, V9.2D
    FADDP D30, V29.2D
    FMINNMP S21, V28.2S
    SMAXP  V21.8H, V5.8H, V4.8H
    UMINP  V0.4S, V24.4S, V11.4S
    FMAXP D11, V19.2D
    FMINNMP S23, V3.2S
    FMINNMP D19, V1.2D
    UMAXP  V11.4S, V29.4S, V2.4S
    FMINNMP  V5.2D, V7.2D, V22.2D
    ADDP  D21, V2.2D
    UMINP  V27.8H, V24.8H, V5.8H
    UMINP  V19.8B, V26.8B, V29.8B
    ADDP  D16, V18.2D
    FMINNMP S13, V11.2S
    FADDP D21, V11.2D
    FMINNMP  V16.2S, V1.2S, V27.2S
    FMAXNMP  V14.4S, V9.4S, V17.4S
    FMAXP  V3.2S, V25.2S, V28.2S
    ADDP  V25.2D, V22.2D, V28.2D
    UMAXP  V16.4H, V2.4H, V4.4H
    FMINNMP  V27.2S, V13.2S, V7.2S
    FMAXNMP D25, V18.2D
    FMINP S5, V23.2S
    ADDP  D30, V26.2D
    ADDP  D21, V16.2D
    FMAXP D21, V7.2D
    UMINP  V1.2S, V30.2S, V30.2S
    SMINP  V4.4S, V5.4S, V0.4S
    FMINP  V26.4S, V3.4S, V21.4S
    FADDP  V16.4S, V15.4S, V24.4S
    SMINP  V29.2S, V27.2S, V25.2S
    FMINNMP D12, V0.2D
    FMINNMP S26, V30.2S
    FMAXNMP D29, V5.2D
    FMAXNMP  V26.4S, V17.4S, V0.4S
    ADDP  D7, V26.2D
    ADDP  V28.2S, V25.2S, V23.2S
    FADDP D19, V11.2D
    FMINNMP  V29.2D, V27.2D, V7.2D
    UMAXP  V12.8H, V30.8H, V27.8H
    FMINP  V10.2D, V4.2D, V20.2D
    FMAXNMP  V14.4S, V19.4S, V30.4S
    FMINP S5, V22.2S
    SMINP  V5.4S, V18.4S, V6.4S
    UMAXP  V28.16B, V14.16B, V24.16B
    FMINP  V26.2D, V6.2D, V23.2D
    FMINNMP D29, V3.2D
    FMINP  V29.2S, V20.2S, V19.2S
    ADDP  D20, V15.2D
    FADDP D25, V7.2D
    FMINP D3, V10.2D
    FMINP D14, V21.2D
    FADDP  V12.4S, V20.4S, V4.4S
    FMINP  V25.4S, V5.4S, V21.4S
    FADDP D2, V28.2D
    SMINP  V18.4S, V26.4S, V4.4S
    FMINP  V14.2S, V23.2S, V23.2S
    FMAXP S16, V20.2S
    FMINP S4, V14.2S
    FMINNMP  V14.4S, V0.4S, V23.4S
    UMAXP  V7.4S, V24.4S, V21.4S
    FMINNMP S23, V3.2S
    FADDP S9, V20.2S
    UMAXP  V25.4S, V29.4S, V19.4S
    FMAXP  V6.2D, V18.2D, V4.2D
    FMINNMP S14, V18.2S
    FMINP  V22.2S, V26.2S, V21.2S
    FMINP D7, V18.2D
    FMINP D20, V9.2D
    FMINNMP D5, V28.2D
    SMINP  V0.4S, V28.4S, V29.4S
    FMINP  V22.2S, V1.2S, V27.2S
    FMINP  V2.2D, V19.2D, V20.2D
    FADDP D15, V18.2D
    FMAXP S20, V16.2S
    FMAXP S28, V0.2S
    ADDP  V20.8H, V8.8H, V23.8H
    FMAXNMP  V30.2S, V24.2S, V17.2S
    UMINP  V7.8B, V25.8B, V21.8B
    FMINP  V9.2S, V3.2S, V1.2S
    FADDP S18, V5.2S
    SMINP  V12.2S, V4.2S, V7.2S
    FMINNMP S21, V31.2S
    FMINNMP D21, V6.2D
    FMAXP  V14.2D, V11.2D, V2.2D
    FMAXNMP S8, V11.2S
    FMINNMP  V7.4S, V9.4S, V19.4S
    FMINNMP  V7.2D, V22.2D, V11.2D
    FMAXP D31, V30.2D
    FMINP S15, V20.2S
    FMINP  V31.2D, V21.2D, V20.2D
    UMINP  V0.16B, V23.16B, V3.16B
    ADDP  D0, V22.2D
    FMINP D31, V31.2D
    FMINP  V1.4S, V12.4S, V24.4S
    SMINP  V29.8B, V31.8B, V1.8B
    FMINNMP  V19.2S, V5.2S, V21.2S
    FMAXP D30, V7.2D
    FMINP  V8.2D, V18.2D, V9.2D
    FMAXNMP S10, V4.2S
    ADDP  V5.2D, V25.2D, V24.2D
    FADDP S19, V29.2S
    FADDP D6, V21.2D
    UMAXP  V24.2S, V5.2S, V3.2S
    FMINNMP S28, V16.2S
    FMAXP  V21.4S, V3.4S, V2.4S
    FMAXP S24, V23.2S
    FMINNMP D14, V11.2D
    FMAXNMP S0, V13.2S
    FMAXNMP  V27.4S, V27.4S, V10.4S
    FMINP  V27.4S, V30.4S, V12.4S
    FADDP D7, V20.2D
    FADDP S31, V20.2S
    UMAXP  V17.8H, V21.8H, V3.8H
    FMAXP D3, V9.2D
    FMAXP  V22.2D, V12.2D, V29.2D
    ADDP  D19, V16.2D
    FMAXNMP  V2.4S, V2.4S, V3.4S
    FMAXP  V11.2D, V5.2D, V11.2D
    FMAXNMP S3, V8.2S
    ADDP  V25.4H, V31.4H, V16.4H
    UMAXP  V0.4H, V20.4H, V21.4H
    FMINNMP  V6.2S, V17.2S, V8.2S
    FMINP D19, V25.2D
    FMINP S22, V31.2S
    FMAXNMP D29, V5.2D
    FMINNMP D4, V16.2D
    FMAXNMP S2, V27.2S
    FMAXP  V1.2S, V21.2S, V19.2S
    FMAXNMP S25, V12.2S
    FMAXP  V28.2D, V17.2D, V9.2D
    FADDP  V7.2S, V7.2S, V27.2S
    FMAXP D7, V0.2D
    FMINNMP S12, V0.2S
    UMAXP  V1.4S, V4.4S, V10.4S
    FMAXNMP D25, V10.2D
    SMAXP  V4.8B, V10.8B, V2.8B
    FADDP S30, V7.2S
    FMINP D22, V17.2D
    FMINNMP S3, V25.2S
    FMINP S27, V27.2S
    SMAXP  V3.16B, V20.16B, V19.16B
    FMINP  V11.2D, V21.2D, V5.2D
    FMAXP  V17.2S, V17.2S, V2.2S
    FMINP  V12.2D, V28.2D, V3.2D
    FMINP S12, V26.2S
    FADDP  V25.2D, V2.2D, V4.2D
    FMINP D12, V4.2D
    FMINP S30, V16.2S
    UMINP  V22.8B, V4.8B, V21.8B
    SMAXP  V25.4H, V1.4H, V8.4H
    SMINP  V20.16B, V0.16B, V2.16B
    UMINP  V5.8B, V5.8B, V4.8B
    UMINP  V5.2S, V7.2S, V17.2S
    FMAXNMP S27, V25.2S
    FMAXNMP S11, V19.2S
    FADDP S18, V21.2S
    FADDP S15, V19.2S
    SMINP  V26.8H, V13.8H, V13.8H
    SMAXP  V28.4S, V13.4S, V18.4S
    FADDP  V16.4S, V27.4S, V7.4S
    FMINP  V20.4S, V10.4S, V0.4S
    ADDP  D17, V3.2D
    FMAXNMP S6, V6.2S
    FMINNMP D13, V7.2D
    FMINNMP S4, V6.2S
    ADDP  D22, V1.2D
    SMAXP  V29.16B, V25.16B, V19.16B
    FMINNMP  V8.2S, V29.2S, V3.2S
    FMAXNMP  V8.2D, V8.2D, V22.2D
    FADDP S24, V29.2S
    FMAXP  V8.2S, V22.2S, V14.2S
    FMINNMP S5, V7.2S
    FMAXNMP D26, V5.2D
    FADDP S2, V20.2S
    SUBS  X22, X22, #0x1
    B.NE  TaishanSimdComplexP01_label_248
    MOVZ  X19, #0x7499, LSL #0
    MOVK  X19, #0x1adf, LSL #16
    MOVK  X19, #0x178d, LSL #32
    MOVK  X19, #0x9b2, LSL #48
    SUB  X14, X19, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    MOVZ  X5, #0x8167, LSL #0
    MOVK  X5, #0x6ea8, LSL #16
    MOVK  X5, #0xb00d, LSL #32
    MOVK  X5, #0x1713, LSL #48
    SUB  X21, X5, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    MOVZ  X19, #0x3b67, LSL #0
    MOVK  X19, #0x8f77, LSL #16
    MOVK  X19, #0xcd85, LSL #32
    MOVK  X19, #0x7eff, LSL #48
    SUB  X6, X19, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0x8167, LSL #0
    MOVK  X16, #0x6ea8, LSL #16
    MOVK  X16, #0xb00d, LSL #32
    MOVK  X16, #0x1713, LSL #48
    SUB  X24, X16, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    MOVZ  X8, #0x6d58, LSL #0
    MOVK  X8, #0x2321, LSL #16
    MOVK  X8, #0xb96, LSL #32
    MOVK  X8, #0x2eb9, LSL #48
    SUB  X25, X8, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    MOVZ  X3, #0x6d58, LSL #0
    MOVK  X3, #0x2321, LSL #16
    MOVK  X3, #0xb96, LSL #32
    MOVK  X3, #0x2eb9, LSL #48
    SUB  X14, X3, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    MOVZ  X18, #0x5c39, LSL #0
    MOVK  X18, #0x2323, LSL #16
    MOVK  X18, #0x864, LSL #32
    MOVK  X18, #0x6cf8, LSL #48
    SUB  X25, X18, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    MOVZ  X3, #0xc056, LSL #0
    MOVK  X3, #0x91ac, LSL #16
    MOVK  X3, #0x2d05, LSL #32
    MOVK  X3, #0xffd6, LSL #48
    SUB  X10, X3, X10
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    MOVZ  X11, #0x2d22, LSL #0
    MOVK  X11, #0x7415, LSL #16
    MOVK  X11, #0x1b34, LSL #32
    MOVK  X11, #0x4868, LSL #48
    SUB  X26, X11, X11
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    MOVZ  X23, #0x73b, LSL #0
    MOVK  X23, #0x1c6, LSL #16
    MOVK  X23, #0x8fc7, LSL #32
    MOVK  X23, #0x4c59, LSL #48
    SUB  X18, X23, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    MOVZ  X7, #0x21d0, LSL #0
    MOVK  X7, #0xad5, LSL #16
    MOVK  X7, #0xacca, LSL #32
    MOVK  X7, #0xaa3a, LSL #48
    SUB  X12, X7, X13
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X6, X23, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    MOVZ  X2, #0x22df, LSL #0
    MOVK  X2, #0xae61, LSL #16
    MOVK  X2, #0xecfd, LSL #32
    MOVK  X2, #0x34b6, LSL #48
    SUB  X13, X2, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0x8167, LSL #0
    MOVK  X16, #0x6ea8, LSL #16
    MOVK  X16, #0xb00d, LSL #32
    MOVK  X16, #0x1713, LSL #48
    SUB  X20, X16, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    MOVZ  X15, #0xfc57, LSL #0
    MOVK  X15, #0x59f1, LSL #16
    MOVK  X15, #0xb8ab, LSL #32
    MOVK  X15, #0x9d05, LSL #48
    SUB  X13, X15, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X12, X24, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    MOVZ  X13, #0x3b67, LSL #0
    MOVK  X13, #0x8f77, LSL #16
    MOVK  X13, #0xcd85, LSL #32
    MOVK  X13, #0x7eff, LSL #48
    SUB  X11, X13, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X20, X11, X25
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    MOVZ  X10, #0x7f8d, LSL #0
    MOVK  X10, #0x723, LSL #16
    MOVK  X10, #0x29c7, LSL #32
    MOVK  X10, #0x4c44, LSL #48
    SUB  X23, X10, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X4, D2
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X10, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X10, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X22, V4.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X6, X8, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X22, D4
    MOVZ  X8, #0x0, LSL #0
    SUB  X6, X8, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X16, D5
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X22, V6.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X22, D6
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X3, D7
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X5, D8
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X21, V9.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X21
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X21, D9
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X21
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X15, V10.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X15, D10
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X29, D11
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X19, X11, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    FMOV  X20, D12
    MOVZ  X11, #0x0, LSL #0
    SUB  X19, X11, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X6, D13
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X7, D14
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X28, D15
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X20, X28, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X2, D16
    MOVZ  X28, #0x0, LSL #0
    SUB  X20, X28, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X21, X11, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X29, D17
    MOVZ  X11, #0x0, LSL #0
    SUB  X21, X11, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X6, D18
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X10, V19.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X10, D19
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X11, D20
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X10, D21
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X15, D22
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X10, X3, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X2, D23
    MOVZ  X3, #0x0, LSL #0
    SUB  X10, X3, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X23, D24
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X8, D25
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X16, D26
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X22, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X22, D28
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X14, D29
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
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
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X26
    FMOV  V0.D[1], X11
    FMOV  D1, X17
    FMOV  V1.D[1], X18
    FMOV  D2, X9
    FMOV  V2.D[1], X29
    FMOV  D3, X8
    FMOV  V3.D[1], X7
    FMOV  D4, X5
    FMOV  V4.D[1], X6
    FMOV  D5, X2
    FMOV  V5.D[1], X3
    FMOV  D6, X8
    FMOV  V6.D[1], X23
    FMOV  D7, X15
    FMOV  V7.D[1], X14
    FMOV  D8, X20
    FMOV  V8.D[1], X22
    FMOV  D9, X7
    FMOV  V9.D[1], X29
    FMOV  D10, X29
    FMOV  V10.D[1], X29
    FMOV  D11, X28
    FMOV  V11.D[1], X16
    FMOV  D12, X16
    FMOV  V12.D[1], X21
    FMOV  D13, X6
    FMOV  V13.D[1], X28
    FMOV  D14, X8
    FMOV  V14.D[1], X29
    FMOV  D15, X22
    FMOV  V15.D[1], X7
    FMOV  D16, X3
    FMOV  V16.D[1], X18
    FMOV  D17, X7
    FMOV  V17.D[1], X3
    FMOV  D18, X21
    FMOV  V18.D[1], X3
TaishanSimdComplexP01_label_197:
    FMOV  D19, X8
    FMOV  V19.D[1], X3
    FMOV  D20, X21
    FMOV  V20.D[1], X22
    FMOV  D21, X22
    FMOV  V21.D[1], X16
    FMOV  D22, X9
    FMOV  V22.D[1], X17
    FMOV  D23, X12
    FMOV  V23.D[1], X8
    FMOV  D24, X7
    FMOV  V24.D[1], X5
    FMOV  D25, X13
    FMOV  V25.D[1], X5
    FMOV  D26, X21
    FMOV  V26.D[1], X7
    FMOV  D27, X15
    FMOV  V27.D[1], X2
    FMOV  D28, X5
    FMOV  V28.D[1], X10
    FMOV  D29, X12
    FMOV  V29.D[1], X7
    FMOV  D30, X23
    FMOV  V30.D[1], X17
    FMOV  D31, X8
    FMOV  V31.D[1], X23
    MOVZ  X9, #0xa, LSL #0
TaishanSimdComplexP01_label_331:
    FMAXP S22, V0.2S
    FMINP S5, V30.2S
    FMINNMP S23, V28.2S
    FMAXP  V26.2D, V3.2D, V5.2D
    SMINP  V9.2S, V13.2S, V18.2S
    FMINNMP  V18.2D, V19.2D, V16.2D
    FMAXP D24, V12.2D
    FMINP S31, V29.2S
    FMAXNMP D23, V21.2D
    FADDP S21, V27.2S
    SMINP  V18.4S, V17.4S, V9.4S
    FMAXNMP S18, V1.2S
    FADDP S25, V13.2S
    FMINNMP  V21.2D, V15.2D, V18.2D
    FMAXNMP  V7.4S, V17.4S, V22.4S
    FMAXNMP  V25.2D, V21.2D, V22.2D
    FMINNMP D5, V29.2D
    SMAXP  V20.2S, V13.2S, V13.2S
    FMAXP  V14.4S, V12.4S, V0.4S
    FMAXNMP D9, V14.2D
    ADDP  D19, V7.2D
    FMAXP S20, V19.2S
    FMAXP  V27.2D, V12.2D, V8.2D
    SMINP  V23.8B, V4.8B, V25.8B
    ADDP  V1.4S, V4.4S, V28.4S
    FADDP S24, V7.2S
    SMINP  V30.8H, V2.8H, V5.8H
    FADDP  V12.4S, V20.4S, V3.4S
    UMINP  V24.2S, V19.2S, V11.2S
    SMINP  V16.16B, V14.16B, V1.16B
    FMAXNMP  V17.4S, V31.4S, V17.4S
    FMINNMP D27, V10.2D
    FMAXP D30, V13.2D
    UMAXP  V4.4S, V5.4S, V25.4S
    ADDP  V24.4H, V20.4H, V16.4H
    FMAXP D30, V28.2D
    FMINNMP  V14.2S, V20.2S, V16.2S
    FMINNMP D2, V12.2D
    FMAXP  V11.2D, V30.2D, V12.2D
    ADDP  V10.2S, V2.2S, V2.2S
    SMAXP  V12.8H, V18.8H, V8.8H
    ADDP  D29, V8.2D
    SMINP  V6.16B, V16.16B, V19.16B
    FMAXP S23, V1.2S
    FMINP D29, V31.2D
    UMAXP  V2.2S, V12.2S, V27.2S
    FMINNMP  V23.4S, V16.4S, V20.4S
    FMAXP D17, V0.2D
    FMAXNMP D0, V18.2D
    FMAXP  V14.4S, V9.4S, V23.4S
    FADDP S26, V29.2S
    FMAXNMP  V4.2D, V29.2D, V11.2D
    UMAXP  V5.16B, V23.16B, V26.16B
    UMAXP  V29.4H, V16.4H, V23.4H
    FMAXP S0, V6.2S
    FADDP S28, V19.2S
    FMINP D4, V19.2D
    FMINP  V10.4S, V0.4S, V8.4S
    SMAXP  V14.4H, V5.4H, V11.4H
    FMAXNMP D17, V9.2D
    FMAXP S23, V14.2S
    ADDP  D20, V23.2D
    ADDP  D14, V2.2D
    FMAXP  V4.2S, V10.2S, V16.2S
    FMINP D6, V12.2D
    FMINP  V4.2D, V20.2D, V1.2D
    FMINNMP  V12.4S, V22.4S, V4.4S
    FMINP  V21.2S, V15.2S, V26.2S
    FMAXNMP D26, V0.2D
    FMINNMP D19, V12.2D
    FMINP D28, V8.2D
    FMAXNMP D18, V3.2D
    FADDP  V23.2S, V6.2S, V2.2S
    FMINP S28, V18.2S
    FMINP D19, V16.2D
    FMAXP D28, V21.2D
    FMINP D2, V29.2D
    UMAXP  V12.8H, V10.8H, V11.8H
    FMAXP  V24.4S, V23.4S, V11.4S
    FMINNMP S22, V31.2S
    UMINP  V28.4S, V11.4S, V30.4S
    FMAXNMP S16, V24.2S
    FMAXP D29, V8.2D
    SMAXP  V3.8H, V25.8H, V5.8H
    FMINP D24, V14.2D
    FMINNMP S8, V11.2S
    FADDP D17, V26.2D
    FMAXNMP S9, V6.2S
    FMAXNMP S16, V1.2S
    FMINP D29, V24.2D
    FMINP  V2.4S, V7.4S, V28.4S
    FMAXNMP  V1.4S, V2.4S, V25.4S
    FMAXP  V11.2S, V1.2S, V17.2S
    FMAXP D12, V0.2D
    FMAXP  V30.2S, V23.2S, V30.2S
    ADDP  V28.8H, V16.8H, V19.8H
    FMINNMP S19, V2.2S
    SMINP  V1.16B, V26.16B, V12.16B
    FMAXNMP S9, V18.2S
    FADDP D16, V2.2D
    ADDP  D23, V17.2D
    FMAXP  V6.2D, V23.2D, V8.2D
    FMAXNMP  V18.4S, V11.4S, V23.4S
    FMAXNMP  V8.2S, V27.2S, V29.2S
    UMINP  V1.8B, V2.8B, V31.8B
    FMINNMP D30, V9.2D
    SMINP  V22.8H, V25.8H, V31.8H
    FADDP  V18.4S, V11.4S, V6.4S
    FMAXNMP S13, V15.2S
    FMINNMP D5, V16.2D
    SMAXP  V5.4H, V31.4H, V16.4H
    FMINP  V8.2S, V5.2S, V30.2S
    FMINNMP S13, V25.2S
    UMAXP  V17.2S, V23.2S, V18.2S
    FMAXNMP D1, V12.2D
    FMINP S4, V26.2S
    FADDP  V31.2D, V5.2D, V4.2D
    SMINP  V31.8H, V19.8H, V28.8H
    FMAXNMP  V6.2S, V18.2S, V11.2S
    SMINP  V15.8B, V23.8B, V24.8B
    UMINP  V1.16B, V4.16B, V31.16B
    FADDP D11, V30.2D
    FMINNMP  V8.2S, V12.2S, V5.2S
    SMINP  V29.8H, V3.8H, V28.8H
    FMAXNMP S10, V25.2S
    ADDP  D26, V7.2D
    SMAXP  V27.16B, V19.16B, V30.16B
    FMINNMP D26, V5.2D
    FMAXNMP S0, V23.2S
    FMINNMP D26, V6.2D
    ADDP  D6, V12.2D
    FMAXP S2, V7.2S
    FMINP S16, V7.2S
    FMINNMP  V27.2D, V1.2D, V15.2D
    FMAXNMP S2, V0.2S
    UMAXP  V9.8H, V29.8H, V11.8H
    FMAXNMP S16, V14.2S
    FMAXP S14, V28.2S
    FMAXNMP S19, V26.2S
    ADDP  D21, V7.2D
    FADDP D13, V3.2D
    FMINNMP D29, V13.2D
    UMINP  V15.2S, V25.2S, V6.2S
    FMAXP S15, V18.2S
    FADDP D16, V30.2D
    FADDP S5, V5.2S
    UMAXP  V16.4S, V5.4S, V1.4S
    FMINP S5, V12.2S
    FADDP D23, V21.2D
    FMAXP  V9.2D, V26.2D, V23.2D
    FMINP D8, V19.2D
    SMINP  V18.16B, V5.16B, V8.16B
    FMAXNMP D23, V11.2D
    FMAXP D2, V1.2D
    FMAXNMP S0, V13.2S
    ADDP  D16, V14.2D
    FMINP  V24.2D, V9.2D, V23.2D
    FMAXNMP  V10.2S, V11.2S, V8.2S
    FMINP D28, V12.2D
    FADDP D19, V0.2D
    ADDP  D3, V30.2D
    FMINP  V31.2D, V2.2D, V15.2D
    UMINP  V21.16B, V16.16B, V30.16B
    ADDP  V29.8H, V27.8H, V18.8H
    SMAXP  V29.8B, V4.8B, V6.8B
    FMAXP S24, V31.2S
    FMAXNMP  V6.4S, V2.4S, V26.4S
    FMAXNMP D2, V10.2D
    FMINNMP S20, V4.2S
    FADDP  V18.2S, V29.2S, V19.2S
    FMINP  V0.2S, V9.2S, V12.2S
    ADDP  D27, V19.2D
    FMAXP S22, V6.2S
    FMAXP D28, V28.2D
    FMAXNMP D1, V10.2D
    FMAXP D30, V2.2D
    FMAXNMP D25, V10.2D
    SMAXP  V7.4S, V28.4S, V13.4S
    ADDP  V2.4S, V6.4S, V17.4S
    ADDP  V7.2D, V28.2D, V13.2D
    FADDP S22, V17.2S
    FMAXNMP S2, V7.2S
    FMINP  V21.2D, V25.2D, V20.2D
    FMAXP S11, V0.2S
    SMAXP  V26.8B, V10.8B, V12.8B
    FADDP S16, V19.2S
    FADDP S25, V13.2S
    FMAXP S25, V9.2S
    FMINP  V6.2S, V16.2S, V0.2S
    FMAXNMP D31, V20.2D
    FMINNMP D8, V11.2D
    FMINNMP S22, V3.2S
    SMAXP  V9.2S, V19.2S, V1.2S
    FADDP  V8.4S, V31.4S, V1.4S
    FMAXP S18, V16.2S
    FADDP  V30.2S, V28.2S, V26.2S
    ADDP  V13.8H, V12.8H, V0.8H
    ADDP  V7.4S, V14.4S, V5.4S
    FMINP S20, V10.2S
    FMINP  V17.4S, V7.4S, V10.4S
    SUBS  X9, X9, #0x1
    B.NE  TaishanSimdComplexP01_label_331
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X13
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X17
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X21, X9, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X28, X13, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X19, X20, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X26
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X28, D2
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X2, D3
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X5, D4
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X14, D5
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X24, D6
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X5, V7.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X5, D7
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X9, D8
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X10, D9
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X19, X20, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    FMOV  X8, D10
    MOVZ  X20, #0x0, LSL #0
    SUB  X19, X20, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    FMOV  X15, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X15, D11
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X4, D12
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X19, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X20, X15, X19
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X19, D13
    MOVZ  X15, #0x0, LSL #0
    SUB  X20, X15, X19
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X15, X29, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X6, D14
    MOVZ  X29, #0x0, LSL #0
    SUB  X15, X29, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X21, X12, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X23, D15
    MOVZ  X12, #0x0, LSL #0
    SUB  X21, X12, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X4, D16
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X8, D17
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X19, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X19, D18
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X3, D19
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X13, D20
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X18, D21
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X13, D22
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X6, D23
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X9, V24.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X9, D24
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X4, D25
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X17, D26
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X11, D28
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X7, D29
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
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
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X14
    FMOV  V0.D[1], X24
    FMOV  D1, X20
    FMOV  V1.D[1], X10
    FMOV  D2, X25
    FMOV  V2.D[1], X22
    FMOV  D3, X5
    FMOV  V3.D[1], X20
    FMOV  D4, X28
    FMOV  V4.D[1], X20
    FMOV  D5, X29
    FMOV  V5.D[1], X6
    FMOV  D6, X14
    FMOV  V6.D[1], X15
    FMOV  D7, X6
    FMOV  V7.D[1], X23
    FMOV  D8, X17
    FMOV  V8.D[1], X12
    FMOV  D9, X23
    FMOV  V9.D[1], X20
    FMOV  D10, X10
    FMOV  V10.D[1], X29
    FMOV  D11, X20
    FMOV  V11.D[1], X9
    FMOV  D12, X9
    FMOV  V12.D[1], X7
    FMOV  D13, X19
    FMOV  V13.D[1], X19
    FMOV  D14, X3
    FMOV  V14.D[1], X4
    FMOV  D15, X6
    FMOV  V15.D[1], X28
    FMOV  D16, X17
    FMOV  V16.D[1], X10
    FMOV  D17, X29
    FMOV  V17.D[1], X28
    FMOV  D18, X9
    FMOV  V18.D[1], X28
    FMOV  D19, X29
    FMOV  V19.D[1], X22
    FMOV  D20, X10
    FMOV  V20.D[1], X3
    FMOV  D21, X15
    FMOV  V21.D[1], X5
    FMOV  D22, X19
    FMOV  V22.D[1], X2
    FMOV  D23, X26
    FMOV  V23.D[1], X4
    FMOV  D24, X5
    FMOV  V24.D[1], X25
    FMOV  D25, X12
    FMOV  V25.D[1], X14
    FMOV  D26, X23
    FMOV  V26.D[1], X25
    FMOV  D27, X2
    FMOV  V27.D[1], X17
    FMOV  D28, X18
    FMOV  V28.D[1], X28
    FMOV  D29, X20
    FMOV  V29.D[1], X26
    FMOV  D30, X4
    FMOV  V30.D[1], X26
    FMOV  D31, X6
    FMOV  V31.D[1], X23
    MOVZ  X16, #0xf, LSL #0
TaishanSimdComplexP01_label_414:
    UMINP  V18.4S, V29.4S, V29.4S
    FMAXP D30, V28.2D
    ADDP  V26.4S, V14.4S, V27.4S
    UMINP  V30.8B, V26.8B, V23.8B
    FMAXP S28, V26.2S
    UMAXP  V30.16B, V13.16B, V14.16B
    FADDP S24, V1.2S
    SMINP  V21.4H, V28.4H, V1.4H
    FMINNMP  V27.2D, V9.2D, V7.2D
    FADDP D28, V12.2D
    SMINP  V6.8H, V31.8H, V23.8H
    FMINP D6, V0.2D
    FMAXP D7, V23.2D
    FMAXNMP S14, V28.2S
    FMINNMP  V24.2S, V16.2S, V30.2S
    ADDP  D19, V23.2D
    FMAXNMP D2, V18.2D
    SMAXP  V7.4H, V9.4H, V2.4H
    FMINP  V24.4S, V7.4S, V27.4S
    FMINNMP D6, V12.2D
    FADDP D7, V0.2D
    FMINNMP D18, V12.2D
    UMINP  V0.4H, V8.4H, V1.4H
    FMAXP  V12.4S, V3.4S, V6.4S
    SMAXP  V27.4H, V24.4H, V9.4H
    FADDP D20, V23.2D
    FMINNMP  V29.2D, V2.2D, V3.2D
    FMAXNMP S20, V7.2S
    FADDP D2, V7.2D
    UMAXP  V26.4H, V14.4H, V14.4H
    FADDP  V30.4S, V20.4S, V10.4S
    FMINP S7, V15.2S
    FMINNMP D1, V2.2D
    ADDP  V22.4S, V21.4S, V30.4S
    FMAXP D15, V23.2D
    FMAXNMP D17, V6.2D
    SMAXP  V18.4H, V25.4H, V5.4H
    FMINNMP S17, V29.2S
    FADDP S1, V31.2S
    SMAXP  V5.8H, V5.8H, V20.8H
    FMAXNMP  V14.4S, V19.4S, V11.4S
    ADDP  D24, V8.2D
    UMINP  V1.8H, V10.8H, V17.8H
    FMINNMP D9, V1.2D
    FMINNMP  V6.2S, V0.2S, V27.2S
    FMAXNMP S2, V25.2S
    FMAXP D21, V22.2D
    FADDP D11, V15.2D
    UMAXP  V24.8B, V21.8B, V3.8B
    FMINNMP D2, V24.2D
    FMINNMP  V29.2D, V11.2D, V28.2D
    FMAXP  V21.2D, V8.2D, V23.2D
    FMINNMP S9, V21.2S
    FMAXP D6, V1.2D
    FMAXNMP S10, V24.2S
    FMAXP S28, V4.2S
    FMAXP  V30.2S, V2.2S, V31.2S
    FADDP D3, V6.2D
    FMAXNMP  V6.2S, V29.2S, V30.2S
    FMINNMP D28, V26.2D
    FMAXP D31, V14.2D
    FMAXNMP S26, V24.2S
    FMINNMP S14, V2.2S
    FADDP D18, V28.2D
    FMINP D11, V25.2D
    SMINP  V31.4S, V6.4S, V20.4S
    FMINNMP S19, V25.2S
    SMINP  V31.2S, V21.2S, V28.2S
    FMINNMP  V13.2D, V0.2D, V27.2D
    FMAXP D8, V14.2D
    FADDP  V15.2D, V1.2D, V2.2D
    FADDP D20, V6.2D
    UMINP  V16.16B, V24.16B, V30.16B
    FADDP D29, V31.2D
    UMINP  V21.2S, V3.2S, V13.2S
    FMAXP  V19.2D, V19.2D, V0.2D
    SMAXP  V30.8B, V7.8B, V16.8B
    UMAXP  V19.4H, V8.4H, V15.4H
    SMINP  V18.16B, V14.16B, V9.16B
    FMAXNMP S20, V12.2S
    UMAXP  V12.16B, V19.16B, V25.16B
    FMAXNMP S31, V9.2S
    ADDP  D7, V21.2D
    UMAXP  V10.16B, V11.16B, V2.16B
    SMAXP  V29.2S, V16.2S, V11.2S
    FMINP D19, V30.2D
    FMINP S15, V19.2S
    FADDP  V18.2D, V10.2D, V17.2D
    FMAXP D7, V29.2D
    FMAXP S31, V24.2S
    FADDP  V8.2D, V0.2D, V11.2D
    FMAXNMP S12, V26.2S
    FMAXP D11, V0.2D
    FMINP D28, V24.2D
    ADDP  V6.2D, V29.2D, V26.2D
    FMINNMP S15, V20.2S
    FMINNMP  V16.4S, V24.4S, V18.4S
    FMINNMP D14, V28.2D
    FMINP  V12.4S, V0.4S, V14.4S
    FMAXP  V29.2S, V16.2S, V19.2S
    FMAXNMP S23, V13.2S
    UMINP  V19.16B, V16.16B, V14.16B
    ADDP  D0, V11.2D
    FMAXNMP  V23.2D, V13.2D, V1.2D
    FMINP D29, V16.2D
    FMAXNMP S13, V16.2S
    FADDP D0, V26.2D
    FMAXP  V2.2S, V22.2S, V23.2S
    SMINP  V12.4S, V21.4S, V14.4S
    FMINNMP S0, V28.2S
    FMINNMP D24, V14.2D
    FMINNMP D30, V6.2D
    FMAXP  V26.4S, V11.4S, V0.4S
    UMINP  V13.16B, V19.16B, V19.16B
    FADDP S29, V17.2S
    FMINP S0, V5.2S
    ADDP  V18.2D, V30.2D, V24.2D
    UMAXP  V22.4H, V11.4H, V25.4H
    UMAXP  V26.8B, V25.8B, V8.8B
    FMAXP D7, V3.2D
    FMINP  V20.2D, V13.2D, V19.2D
    FMAXNMP D7, V8.2D
    SMAXP  V4.2S, V7.2S, V0.2S
    FMAXP S7, V29.2S
    UMINP  V31.8B, V11.8B, V21.8B
    FMAXP D5, V2.2D
    FADDP S9, V8.2S
    ADDP  D30, V29.2D
    FADDP D20, V21.2D
    FMINP S1, V1.2S
    FMINP S15, V1.2S
    FMINNMP S15, V21.2S
    FMINP D13, V15.2D
    SMAXP  V31.8H, V0.8H, V22.8H
    FADDP D17, V7.2D
    FMINNMP D11, V1.2D
    FMAXP D14, V4.2D
    UMINP  V26.16B, V29.16B, V6.16B
    FMINP D15, V3.2D
    FMINNMP  V30.2S, V3.2S, V23.2S
    UMINP  V20.16B, V6.16B, V1.16B
    FMAXNMP D14, V8.2D
    FMINP D22, V14.2D
    ADDP  V2.4H, V29.4H, V11.4H
    FADDP D20, V27.2D
    FADDP  V5.2S, V27.2S, V20.2S
    SMAXP  V8.16B, V3.16B, V27.16B
    FMAXNMP S15, V4.2S
    FADDP S25, V1.2S
    ADDP  D14, V1.2D
    FMINNMP S15, V25.2S
    SMAXP  V15.2S, V22.2S, V7.2S
    FADDP  V13.4S, V31.4S, V22.4S
    FMINNMP D17, V25.2D
    FMINP D11, V0.2D
    FMAXP S4, V18.2S
    ADDP  V12.4S, V28.4S, V29.4S
    UMINP  V22.8H, V14.8H, V23.8H
    ADDP  D3, V30.2D
    FMINNMP S8, V26.2S
    UMINP  V9.16B, V20.16B, V18.16B
    FMAXP D3, V1.2D
    FADDP S27, V10.2S
    UMINP  V20.8H, V13.8H, V8.8H
    SMINP  V12.16B, V0.16B, V10.16B
    FMAXNMP  V22.2D, V4.2D, V29.2D
    FMINNMP D31, V23.2D
    FMAXNMP D9, V3.2D
    FMAXP D14, V2.2D
    UMINP  V16.4S, V28.4S, V12.4S
    FMINNMP  V25.2D, V11.2D, V28.2D
    FMAXNMP S7, V9.2S
    UMAXP  V25.16B, V13.16B, V23.16B
    FMAXNMP S30, V31.2S
    SMINP  V27.16B, V17.16B, V11.16B
    FMAXP S30, V11.2S
    FMAXP  V6.2D, V21.2D, V16.2D
    FMAXP  V14.4S, V23.4S, V5.4S
    FADDP D23, V5.2D
    FMINP  V4.2S, V15.2S, V9.2S
    FMINP D30, V14.2D
    FMAXNMP  V30.2D, V21.2D, V31.2D
    FMAXNMP D28, V12.2D
    SMINP  V20.4H, V4.4H, V1.4H
    FMAXP S2, V18.2S
    UMINP  V10.4H, V30.4H, V11.4H
    SMAXP  V19.4S, V2.4S, V8.4S
    FMINNMP  V7.4S, V15.4S, V23.4S
    FMAXP  V12.2S, V8.2S, V5.2S
    FADDP  V18.4S, V1.4S, V7.4S
    SMAXP  V7.8B, V8.8B, V28.8B
    FMAXNMP D20, V16.2D
    FMAXP D29, V14.2D
    FADDP D22, V10.2D
    FADDP D16, V29.2D
    FMAXNMP D5, V8.2D
    FMINNMP  V13.4S, V6.4S, V23.4S
    UMAXP  V25.16B, V27.16B, V19.16B
    FMAXNMP  V14.2D, V5.2D, V3.2D
    FMAXNMP S0, V4.2S
    SUBS  X16, X16, #0x1
    B.NE  TaishanSimdComplexP01_label_414
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X20, X11, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X16, X17, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X2, X3, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X19, X6, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X17, X10, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X19, X10, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X14, X15, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X17, X29, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X19, X16, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X9, X15, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X25, X6, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X21, X4, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X22, X8, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X20, X2, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X12, X28, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X28, X14, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X8, X18, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X11, D2
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X22, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X20, X15, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X22, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X20, X15, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X12, D4
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X17, D5
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X3, V6.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X3, D6
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X22, V7.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X22, D7
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X23, D8
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X21, V9.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X4, X8, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X21, D9
    MOVZ  X8, #0x0, LSL #0
    SUB  X4, X8, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X23, D10
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X22, V11.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X22, D11
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X5, V12.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X5, D12
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X19, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X19
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X19, D13
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X19
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X9, D14
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X10, D15
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X5, V16.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X18, X3, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X5, D16
    MOVZ  X3, #0x0, LSL #0
    SUB  X18, X3, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X12, D17
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X26, D18
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X10, V19.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X10, D19
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X18, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X18, D20
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X23, D21
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X24, D22
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X19, V23.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X19, D23
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X28, D24
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X12, D25
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X21, V26.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X21, D26
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X16, D28
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X19, V29.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X19
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X19, D29
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X19
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    MOVZ  X2, #0xbe4, LSL #0
    MOVK  X2, #0xcbd, LSL #16
    MOVK  X2, #0x1148, LSL #32
    MOVK  X2, #0xb13c, LSL #48
    MOVZ  X3, #0xf883, LSL #0
    MOVK  X3, #0xfec1, LSL #16
    MOVK  X3, #0xb34b, LSL #32
    MOVK  X3, #0x916f, LSL #48
    MOVZ  X4, #0xc596, LSL #0
    MOVK  X4, #0xbc23, LSL #16
    MOVK  X4, #0x6cac, LSL #32
    MOVK  X4, #0x327d, LSL #48
    MOVZ  X5, #0x4867, LSL #0
    MOVK  X5, #0x7dc0, LSL #16
    MOVK  X5, #0x74c8, LSL #32
    MOVK  X5, #0x7dae, LSL #48
    MOVZ  X6, #0xf869, LSL #0
    MOVK  X6, #0x8139, LSL #16
    MOVK  X6, #0xa53e, LSL #32
    MOVK  X6, #0x2424, LSL #48
    MOVZ  X7, #0xc201, LSL #0
    MOVK  X7, #0xb76b, LSL #16
    MOVK  X7, #0x2114, LSL #32
    MOVK  X7, #0x17e9, LSL #48
    MOVZ  X8, #0xfcea, LSL #0
    MOVK  X8, #0xc4e9, LSL #16
    MOVK  X8, #0xedbd, LSL #32
    MOVK  X8, #0xa2bf, LSL #48
    MOVZ  X9, #0xd48c, LSL #0
    MOVK  X9, #0xaa1b, LSL #16
    MOVK  X9, #0x5845, LSL #32
    MOVK  X9, #0x4629, LSL #48
    MOVZ  X10, #0x5f96, LSL #0
    MOVK  X10, #0x9121, LSL #16
    MOVK  X10, #0x62a, LSL #32
    MOVK  X10, #0x61be, LSL #48
    MOVZ  X11, #0x8cd8, LSL #0
    MOVK  X11, #0x20f7, LSL #16
    MOVK  X11, #0xa15f, LSL #32
    MOVK  X11, #0xfb5a, LSL #48
    MOVZ  X12, #0x4a02, LSL #0
    MOVK  X12, #0x9620, LSL #16
    MOVK  X12, #0x470c, LSL #32
    MOVK  X12, #0xf81f, LSL #48
    MOVZ  X13, #0x3e35, LSL #0
    MOVK  X13, #0x2cb1, LSL #16
    MOVK  X13, #0xdbf7, LSL #32
    MOVK  X13, #0x3e16, LSL #48
    MOVZ  X14, #0x6f9f, LSL #0
    MOVK  X14, #0x2b15, LSL #16
    MOVK  X14, #0xf097, LSL #32
    MOVK  X14, #0x7999, LSL #48
    MOVZ  X15, #0xd909, LSL #0
    MOVK  X15, #0xce66, LSL #16
    MOVK  X15, #0xa3bb, LSL #32
    MOVK  X15, #0x457, LSL #48
    MOVZ  X16, #0xc17d, LSL #0
    MOVK  X16, #0x3a0, LSL #16
    MOVK  X16, #0x5e32, LSL #32
    MOVK  X16, #0x6103, LSL #48
    MOVZ  X17, #0xe088, LSL #0
    MOVK  X17, #0x91d6, LSL #16
    MOVK  X17, #0x4638, LSL #32
    MOVK  X17, #0x8b45, LSL #48
    MOVZ  X18, #0x3cee, LSL #0
    MOVK  X18, #0x85fc, LSL #16
    MOVK  X18, #0x1626, LSL #32
    MOVK  X18, #0xafeb, LSL #48
    MOVZ  X19, #0xeccc, LSL #0
    MOVK  X19, #0x428c, LSL #16
    MOVK  X19, #0x159e, LSL #32
    MOVK  X19, #0x8db, LSL #48
    MOVZ  X20, #0x7aa1, LSL #0
    MOVK  X20, #0xf40f, LSL #16
    MOVK  X20, #0x51b8, LSL #32
    MOVK  X20, #0x56b, LSL #48
    MOVZ  X21, #0x43b9, LSL #0
    MOVK  X21, #0x5e45, LSL #16
    MOVK  X21, #0x7821, LSL #32
    MOVK  X21, #0x130a, LSL #48
    MOVZ  X22, #0xbb1, LSL #0
    MOVK  X22, #0xfbc2, LSL #16
    MOVK  X22, #0x7c93, LSL #32
    MOVK  X22, #0x2b06, LSL #48
    MOVZ  X23, #0xaa4, LSL #0
    MOVK  X23, #0x1b1, LSL #16
    MOVK  X23, #0x7e07, LSL #32
    MOVK  X23, #0x65b2, LSL #48
    MOVZ  X24, #0x4b6b, LSL #0
    MOVK  X24, #0xf27a, LSL #16
    MOVK  X24, #0x5918, LSL #32
    MOVK  X24, #0x4b47, LSL #48
    MOVZ  X25, #0x4b3, LSL #0
    MOVK  X25, #0x4a44, LSL #16
    MOVK  X25, #0x4456, LSL #32
    MOVK  X25, #0x9eec, LSL #48
    MOVZ  X26, #0x1085, LSL #0
    MOVK  X26, #0x42cf, LSL #16
    MOVK  X26, #0x48a6, LSL #32
    MOVK  X26, #0x6b1c, LSL #48
    MOVZ  X28, #0x15b3, LSL #0
    MOVK  X28, #0x2a9c, LSL #16
    MOVK  X28, #0xde39, LSL #32
    MOVK  X28, #0xfc47, LSL #48
    MOVZ  X29, #0xa1fa, LSL #0
    MOVK  X29, #0xb5ce, LSL #16
    MOVK  X29, #0x35a3, LSL #32
    MOVK  X29, #0xa96a, LSL #48
    FMOV  D0, X16
    FMOV  V0.D[1], X26
    FMOV  D1, X4
    FMOV  V1.D[1], X23
    FMOV  D2, X29
    FMOV  V2.D[1], X24
    FMOV  D3, X18
    FMOV  V3.D[1], X15
    FMOV  D4, X18
    FMOV  V4.D[1], X15
    FMOV  D5, X12
    FMOV  V5.D[1], X23
    FMOV  D6, X6
    FMOV  V6.D[1], X16
    FMOV  D7, X7
    FMOV  V7.D[1], X25
    FMOV  D8, X20
    FMOV  V8.D[1], X14
    FMOV  D9, X2
    FMOV  V9.D[1], X12
    FMOV  D10, X7
    FMOV  V10.D[1], X29
    FMOV  D11, X13
    FMOV  V11.D[1], X28
    FMOV  D12, X23
    FMOV  V12.D[1], X6
    FMOV  D13, X25
    FMOV  V13.D[1], X14
    FMOV  D14, X7
    FMOV  V14.D[1], X10
    FMOV  D15, X21
    FMOV  V15.D[1], X9
    FMOV  D16, X6
    FMOV  V16.D[1], X6
    FMOV  D17, X19
    FMOV  V17.D[1], X6
    FMOV  D18, X28
    FMOV  V18.D[1], X28
    FMOV  D19, X18
    FMOV  V19.D[1], X18
    FMOV  D20, X8
    FMOV  V20.D[1], X2
    FMOV  D21, X17
    FMOV  V21.D[1], X2
    FMOV  D22, X10
    FMOV  V22.D[1], X3
    FMOV  D23, X6
    FMOV  V23.D[1], X10
    FMOV  D24, X20
    FMOV  V24.D[1], X13
    FMOV  D25, X19
    FMOV  V25.D[1], X9
    FMOV  D26, X18
    FMOV  V26.D[1], X25
    FMOV  D27, X19
    FMOV  V27.D[1], X25
    FMOV  D28, X21
    FMOV  V28.D[1], X21
    FMOV  D29, X3
    FMOV  V29.D[1], X15
    FMOV  D30, X3
    FMOV  V30.D[1], X15
    FMOV  D31, X25
    FMOV  V31.D[1], X21
    MOVZ  X13, #0xa, LSL #0
TaishanSimdComplexP01_label_492:
    FADDP S21, V23.2S
    FADDP S19, V27.2S
    FMINP  V18.2D, V8.2D, V15.2D
    FMINP D16, V24.2D
    FMAXNMP S20, V15.2S
    FMAXNMP S30, V22.2S
    FADDP D23, V2.2D
    FMAXP  V19.4S, V20.4S, V11.4S
    FMAXP  V28.4S, V16.4S, V3.4S
    FADDP D26, V21.2D
    FMINP  V1.4S, V0.4S, V30.4S
    FADDP  V18.2D, V11.2D, V14.2D
    FADDP  V19.2S, V25.2S, V17.2S
    FMINNMP  V12.2D, V23.2D, V20.2D
    FMAXP D10, V14.2D
    FMAXP  V3.4S, V15.4S, V30.4S
    FMINNMP  V27.4S, V6.4S, V21.4S
    FMINNMP  V9.2D, V4.2D, V11.2D
    FADDP  V2.4S, V12.4S, V3.4S
    FADDP D17, V1.2D
    FMAXP S6, V18.2S
    FADDP S3, V17.2S
    FADDP D18, V12.2D
    FMAXP  V27.2D, V14.2D, V22.2D
    SMAXP  V5.4H, V3.4H, V4.4H
    FMINP D30, V4.2D
    UMINP  V26.8H, V17.8H, V5.8H
    FMAXP S31, V20.2S
    FMINNMP D16, V15.2D
    FMAXP S16, V14.2S
    FADDP D23, V10.2D
    UMINP  V24.2S, V11.2S, V0.2S
    FMINP S30, V29.2S
    SMAXP  V28.4H, V18.4H, V24.4H
    FMAXNMP D9, V12.2D
    FMINNMP D0, V26.2D
    UMAXP  V17.8B, V28.8B, V17.8B
    FMINP S21, V9.2S
    FMAXP S8, V0.2S
    FADDP S30, V11.2S
    UMAXP  V11.16B, V23.16B, V11.16B
    FADDP D8, V23.2D
    FADDP D26, V26.2D
    FMAXNMP D31, V31.2D
    FMINP D22, V11.2D
    UMAXP  V22.8B, V27.8B, V13.8B
    FMINNMP D31, V4.2D
    ADDP  D22, V16.2D
    FMINP S15, V7.2S
    FMAXP S16, V15.2S
    FMINP  V28.4S, V7.4S, V4.4S
    FADDP  V19.4S, V26.4S, V0.4S
    ADDP  D9, V8.2D
    SMAXP  V20.4H, V19.4H, V18.4H
    ADDP  D16, V25.2D
    FADDP D21, V7.2D
    ADDP  D18, V30.2D
    SMINP  V21.16B, V9.16B, V21.16B
    FMINNMP S7, V7.2S
    UMAXP  V19.16B, V23.16B, V27.16B
    FMAXNMP D16, V30.2D
    FMAXNMP S9, V25.2S
    FMAXNMP  V21.2D, V0.2D, V30.2D
    FMAXNMP D20, V23.2D
    FMAXNMP S10, V8.2S
    FADDP D26, V12.2D
    ADDP  V17.16B, V7.16B, V20.16B
    FMAXNMP S28, V13.2S
    FMINNMP D20, V30.2D
    FMINNMP S28, V27.2S
    FMINNMP S5, V20.2S
    FMINNMP D20, V26.2D
    FADDP  V16.2D, V13.2D, V17.2D
    FMINP S6, V2.2S
    ADDP  V27.2D, V16.2D, V20.2D
    FMINNMP  V8.4S, V22.4S, V23.4S
    FADDP S11, V25.2S
    FMAXP D18, V21.2D
    SMAXP  V15.8B, V15.8B, V8.8B
    FMAXP  V29.4S, V0.4S, V5.4S
    SMAXP  V19.4S, V21.4S, V15.4S
    ADDP  V16.4H, V24.4H, V2.4H
    FMINP S2, V10.2S
    FMINP D9, V18.2D
    FMINNMP D6, V1.2D
    FMINNMP  V10.2D, V1.2D, V30.2D
    FMAXP D1, V18.2D
    FMINP  V28.4S, V28.4S, V7.4S
    UMAXP  V25.4S, V2.4S, V28.4S
    FMAXP D13, V18.2D
    ADDP  D26, V22.2D
    ADDP  V28.2S, V29.2S, V7.2S
    FMINNMP D12, V12.2D
    UMINP  V10.4S, V0.4S, V3.4S
    FMINNMP D28, V8.2D
    FMAXP  V25.4S, V4.4S, V13.4S
    FADDP  V16.2D, V21.2D, V5.2D
    FMINP D6, V12.2D
    FMAXNMP  V21.2S, V21.2S, V15.2S
    FMAXNMP  V1.4S, V15.4S, V28.4S
    FMAXNMP D29, V3.2D
    FMINP S3, V16.2S
    FMAXP  V21.2D, V5.2D, V4.2D
    FADDP D7, V1.2D
    FMINNMP  V9.2D, V2.2D, V12.2D
    FMINNMP S29, V15.2S
    FMINP D24, V10.2D
    FMAXNMP  V10.4S, V19.4S, V12.4S
    FMINP S3, V6.2S
    FMAXP D13, V7.2D
    FMAXP S25, V8.2S
    UMAXP  V0.2S, V5.2S, V3.2S
    SMAXP  V20.8B, V29.8B, V28.8B
    FADDP  V22.2D, V4.2D, V22.2D
    FMAXNMP  V2.2S, V12.2S, V21.2S
    FMAXNMP D9, V25.2D
    FMAXNMP S1, V29.2S
    FADDP  V29.4S, V27.4S, V20.4S
    UMINP  V1.16B, V4.16B, V16.16B
    FMINNMP D22, V13.2D
    FMAXP S8, V4.2S
    FMINNMP  V24.2S, V10.2S, V26.2S
    FADDP D16, V9.2D
    UMINP  V8.4S, V21.4S, V21.4S
    FADDP D14, V16.2D
    FMINP S26, V11.2S
    FMAXP D21, V2.2D
    FMINNMP D13, V9.2D
    FMAXNMP  V29.2S, V27.2S, V21.2S
    ADDP  D21, V3.2D
    SMINP  V29.4S, V17.4S, V3.4S
    SMINP  V8.4H, V3.4H, V8.4H
    FMINP S30, V11.2S
    UMINP  V28.2S, V25.2S, V7.2S
    FMINNMP D17, V30.2D
    FMAXNMP D8, V29.2D
    SMAXP  V13.16B, V6.16B, V3.16B
    FMAXP  V16.2S, V12.2S, V3.2S
    FMAXP D26, V17.2D
    FADDP  V2.2D, V30.2D, V4.2D
    UMINP  V14.8B, V3.8B, V12.8B
    UMINP  V19.2S, V29.2S, V2.2S
    FADDP S9, V15.2S
    FMAXP  V4.2D, V11.2D, V25.2D
    UMINP  V23.16B, V8.16B, V23.16B
    UMINP  V8.4H, V26.4H, V15.4H
    FMINP  V20.2S, V4.2S, V29.2S
    FMAXNMP  V19.4S, V19.4S, V3.4S
    FADDP S13, V1.2S
    FADDP S12, V2.2S
    FMAXP D18, V6.2D
    FMAXNMP  V13.4S, V8.4S, V27.4S
    FMINP S17, V9.2S
    SMINP  V26.8B, V14.8B, V3.8B
    FADDP  V7.2D, V9.2D, V15.2D
    FMAXNMP D23, V16.2D
    SMINP  V17.4H, V11.4H, V5.4H
    FADDP  V18.2S, V9.2S, V21.2S
    SMINP  V20.8B, V14.8B, V1.8B
    SMAXP  V31.2S, V10.2S, V3.2S
    FMINNMP  V13.2S, V4.2S, V1.2S
    FADDP  V15.2D, V19.2D, V12.2D
    SMAXP  V5.4H, V4.4H, V15.4H
    FMAXNMP D9, V4.2D
    SMAXP  V25.16B, V30.16B, V11.16B
    FMAXP  V30.2D, V27.2D, V8.2D
    FMINP  V27.4S, V25.4S, V19.4S
    UMAXP  V21.8H, V7.8H, V26.8H
    FADDP  V22.2D, V15.2D, V27.2D
    FADDP D25, V16.2D
    FMINNMP  V23.4S, V10.4S, V27.4S
    UMAXP  V30.4H, V19.4H, V0.4H
    FADDP S3, V12.2S
    FADDP D30, V17.2D
    ADDP  D5, V13.2D
    UMAXP  V30.4S, V4.4S, V23.4S
    FADDP  V7.4S, V4.4S, V7.4S
    FMINNMP S1, V16.2S
    SMAXP  V6.4H, V6.4H, V1.4H
    ADDP  V3.2D, V5.2D, V0.2D
    FMINNMP  V15.2D, V21.2D, V0.2D
    FMAXNMP  V9.4S, V7.4S, V26.4S
    FMAXNMP  V1.2D, V30.2D, V7.2D
    FMINNMP D3, V13.2D
    FMINNMP D28, V19.2D
    FMINNMP D8, V25.2D
    FADDP D20, V9.2D
    FMINNMP S12, V0.2S
    FMINP S28, V13.2S
    UMAXP  V19.4H, V29.4H, V24.4H
    FMAXP  V20.4S, V22.4S, V14.4S
    FADDP  V15.2S, V23.2S, V4.2S
    UMAXP  V1.8H, V13.8H, V19.8H
    FMINNMP  V0.2D, V30.2D, V7.2D
    FMINNMP  V30.2S, V18.2S, V0.2S
    FADDP S31, V18.2S
    UMAXP  V17.4H, V9.4H, V12.4H
    SMAXP  V27.8B, V2.8B, V21.8B
    SMAXP  V29.2S, V4.2S, V17.2S
    FMAXNMP  V0.2S, V11.2S, V1.2S
    SUBS  X13, X13, #0x1
    B.NE  TaishanSimdComplexP01_label_492
    MOVZ  X4, #0xbe4, LSL #0
    MOVK  X4, #0xcbd, LSL #16
    MOVK  X4, #0x1148, LSL #32
    MOVK  X4, #0xb13c, LSL #48
    SUB  X10, X4, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0xf883, LSL #0
    MOVK  X20, #0xfec1, LSL #16
    MOVK  X20, #0xb34b, LSL #32
    MOVK  X20, #0x916f, LSL #48
    SUB  X4, X20, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    MOVZ  X23, #0x4867, LSL #0
    MOVK  X23, #0x7dc0, LSL #16
    MOVK  X23, #0x74c8, LSL #32
    MOVK  X23, #0x7dae, LSL #48
    SUB  X25, X23, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    MOVZ  X28, #0xf869, LSL #0
    MOVK  X28, #0x8139, LSL #16
    MOVK  X28, #0xa53e, LSL #32
    MOVK  X28, #0x2424, LSL #48
    SUB  X24, X28, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    MOVZ  X5, #0xc201, LSL #0
    MOVK  X5, #0xb76b, LSL #16
    MOVK  X5, #0x2114, LSL #32
    MOVK  X5, #0x17e9, LSL #48
    SUB  X19, X5, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    MOVZ  X14, #0xfcea, LSL #0
    MOVK  X14, #0xc4e9, LSL #16
    MOVK  X14, #0xedbd, LSL #32
    MOVK  X14, #0xa2bf, LSL #48
    SUB  X5, X14, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    MOVZ  X21, #0x8cd8, LSL #0
    MOVK  X21, #0x20f7, LSL #16
    MOVK  X21, #0xa15f, LSL #32
    MOVK  X21, #0xfb5a, LSL #48
    SUB  X24, X21, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    MOVZ  X29, #0x4a02, LSL #0
    MOVK  X29, #0x9620, LSL #16
    MOVK  X29, #0x470c, LSL #32
    MOVK  X29, #0xf81f, LSL #48
    SUB  X15, X29, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0xfcea, LSL #0
    MOVK  X16, #0xc4e9, LSL #16
    MOVK  X16, #0xedbd, LSL #32
    MOVK  X16, #0xa2bf, LSL #48
    SUB  X23, X16, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    MOVZ  X9, #0xfcea, LSL #0
    MOVK  X9, #0xc4e9, LSL #16
    MOVK  X9, #0xedbd, LSL #32
    MOVK  X9, #0xa2bf, LSL #48
    SUB  X18, X9, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    MOVZ  X18, #0xe088, LSL #0
    MOVK  X18, #0x91d6, LSL #16
    MOVK  X18, #0x4638, LSL #32
    MOVK  X18, #0x8b45, LSL #48
    SUB  X28, X18, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    MOVZ  X18, #0xe088, LSL #0
    MOVK  X18, #0x91d6, LSL #16
    MOVK  X18, #0x4638, LSL #32
    MOVK  X18, #0x8b45, LSL #48
    SUB  X15, X18, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X19
TaishanSimdComplexP01_label_481:
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    MOVZ  X15, #0xf883, LSL #0
    MOVK  X15, #0xfec1, LSL #16
    MOVK  X15, #0xb34b, LSL #32
    MOVK  X15, #0x916f, LSL #48
    SUB  X16, X15, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    MOVZ  X15, #0x8cd8, LSL #0
    MOVK  X15, #0x20f7, LSL #16
    MOVK  X15, #0xa15f, LSL #32
    MOVK  X15, #0xfb5a, LSL #48
    SUB  X5, X15, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    MOVZ  X5, #0xbb1, LSL #0
    MOVK  X5, #0xfbc2, LSL #16
    MOVK  X5, #0x7c93, LSL #32
    MOVK  X5, #0x2b06, LSL #48
    SUB  X3, X5, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    MOVZ  X29, #0x1085, LSL #0
    MOVK  X29, #0x42cf, LSL #16
    MOVK  X29, #0x48a6, LSL #32
    MOVK  X29, #0x6b1c, LSL #48
    SUB  X17, X29, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    MOVZ  X5, #0x1085, LSL #0
    MOVK  X5, #0x42cf, LSL #16
    MOVK  X5, #0x48a6, LSL #32
    MOVK  X5, #0x6b1c, LSL #48
    SUB  X19, X5, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    FMOV  X21, V2.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X13, X19, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X21, D2
    MOVZ  X19, #0x0, LSL #0
    SUB  X13, X19, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X8
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X8, D3
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X8
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    FMOV  X17, D4
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X20, D5
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X22, V6.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X7, X11, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X22, D6
    MOVZ  X11, #0x0, LSL #0
    SUB  X7, X11, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X29, D7
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X22, V8.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X22, D8
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X6, D9
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X19, X20, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    FMOV  X3, D10
    MOVZ  X20, #0x0, LSL #0
    SUB  X19, X20, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X23, D11
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X14, D12
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X18, D13
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X24, D14
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X17, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X17, D15
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X28, D16
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X26, D17
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X16, D18
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X10, V19.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X10, D19
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X28, D20
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X16, D21
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X7, D22
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X9, D23
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X25, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X7, X11, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X25, D24
    MOVZ  X11, #0x0, LSL #0
    SUB  X7, X11, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X24, X22, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X17, D25
    MOVZ  X22, #0x0, LSL #0
    SUB  X24, X22, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X6, X25, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X23, D26
    MOVZ  X25, #0x0, LSL #0
    SUB  X6, X25, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X6, D28
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X12, D29
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
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
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X18
TaishanSimdComplexP01_label_396:
    FMOV  V0.D[1], X18
    FMOV  D1, X22
    FMOV  V1.D[1], X22
    FMOV  D2, X15
    FMOV  V2.D[1], X3
    FMOV  D3, X19
    FMOV  V3.D[1], X20
    FMOV  D4, X17
    FMOV  V4.D[1], X28
    FMOV  D5, X5
    FMOV  V5.D[1], X8
    FMOV  D6, X24
    FMOV  V6.D[1], X28
    FMOV  D7, X23
    FMOV  V7.D[1], X29
    FMOV  D8, X7
    FMOV  V8.D[1], X11
    FMOV  D9, X28
    FMOV  V9.D[1], X21
    FMOV  D10, X24
    FMOV  V10.D[1], X29
    FMOV  D11, X6
    FMOV  V11.D[1], X24
    FMOV  D12, X28
    FMOV  V12.D[1], X18
    FMOV  D13, X16
    FMOV  V13.D[1], X5
    FMOV  D14, X22
    FMOV  V14.D[1], X18
    FMOV  D15, X18
    FMOV  V15.D[1], X7
    FMOV  D16, X18
    FMOV  V16.D[1], X22
    FMOV  D17, X18
    FMOV  V17.D[1], X20
    FMOV  D18, X11
    FMOV  V18.D[1], X16
    FMOV  D19, X11
    FMOV  V19.D[1], X10
    FMOV  D20, X11
    FMOV  V20.D[1], X17
    FMOV  D21, X6
    FMOV  V21.D[1], X3
    FMOV  D22, X21
    FMOV  V22.D[1], X28
    FMOV  D23, X7
    FMOV  V23.D[1], X10
    FMOV  D24, X9
    FMOV  V24.D[1], X9
    FMOV  D25, X24
    FMOV  V25.D[1], X9
    FMOV  D26, X2
    FMOV  V26.D[1], X7
    FMOV  D27, X3
    FMOV  V27.D[1], X4
    FMOV  D28, X18
    FMOV  V28.D[1], X4
    FMOV  D29, X11
    FMOV  V29.D[1], X4
    FMOV  D30, X19
    FMOV  V30.D[1], X8
    FMOV  D31, X24
    FMOV  V31.D[1], X4
    MOVZ  X17, #0xa, LSL #0
TaishanSimdComplexP01_label_571:
    FMINP S30, V10.2S
    UMAXP  V27.16B, V2.16B, V0.16B
    FMINNMP  V4.4S, V0.4S, V8.4S
    FMINP S29, V24.2S
    SMINP  V3.16B, V31.16B, V12.16B
    FMAXP D9, V29.2D
    FMAXP  V5.2D, V23.2D, V12.2D
    FMAXNMP D21, V30.2D
    FMINP  V30.4S, V14.4S, V10.4S
    UMINP  V18.2S, V21.2S, V4.2S
TaishanSimdComplexP01_label_380:
    FMINP  V9.2S, V12.2S, V3.2S
    FADDP S23, V24.2S
    FMAXNMP  V1.2D, V5.2D, V18.2D
    FADDP D30, V14.2D
    FADDP  V27.2S, V21.2S, V29.2S
    FMINP  V23.2S, V27.2S, V12.2S
    FADDP  V24.4S, V8.4S, V21.4S
    ADDP  D5, V27.2D
    FADDP  V31.4S, V3.4S, V12.4S
    FMAXNMP S2, V31.2S
    FMAXNMP D18, V24.2D
    FMAXP D21, V12.2D
    FMAXNMP  V1.2S, V0.2S, V28.2S
    ADDP  V12.8B, V15.8B, V1.8B
    FADDP S4, V8.2S
    FMINNMP  V16.4S, V12.4S, V8.4S
    FMINP  V29.4S, V27.4S, V27.4S
    FMAXP D8, V18.2D
    FMAXNMP S30, V1.2S
    FADDP D23, V31.2D
    FADDP D10, V31.2D
    UMINP  V3.4S, V24.4S, V2.4S
    FMAXNMP D7, V28.2D
    ADDP  V5.2S, V10.2S, V13.2S
    UMINP  V13.2S, V29.2S, V4.2S
    FMAXP S12, V2.2S
    FMINNMP  V15.2D, V11.2D, V30.2D
    FADDP  V5.2D, V25.2D, V30.2D
    FMAXP  V29.2D, V5.2D, V28.2D
    SMINP  V8.16B, V27.16B, V8.16B
    FADDP  V1.4S, V23.4S, V14.4S
    UMAXP  V24.8B, V14.8B, V18.8B
    FMINP S4, V1.2S
    UMINP  V22.8B, V3.8B, V14.8B
    FMAXP D13, V15.2D
    UMAXP  V18.2S, V11.2S, V0.2S
    SMINP  V25.8B, V0.8B, V19.8B
    FADDP S0, V31.2S
    FMINP D5, V1.2D
    FMAXNMP S2, V10.2S
    FADDP S0, V6.2S
    SMAXP  V28.4S, V9.4S, V22.4S
    FMAXP  V23.4S, V4.4S, V5.4S
    FMAXNMP S27, V5.2S
    FMINNMP  V19.4S, V30.4S, V24.4S
    SMINP  V6.4S, V27.4S, V14.4S
    FADDP D21, V19.2D
    FMAXNMP  V28.4S, V18.4S, V18.4S
    UMAXP  V3.8H, V6.8H, V16.8H
    FMAXP D23, V3.2D
    FMINP S1, V5.2S
    FMAXP  V8.2D, V21.2D, V0.2D
    ADDP  D14, V20.2D
    SMINP  V26.2S, V21.2S, V24.2S
    FMINNMP S0, V0.2S
    FMINNMP  V26.2S, V24.2S, V4.2S
    ADDP  D25, V24.2D
    FMINP  V3.2S, V23.2S, V27.2S
    FMAXNMP  V2.2S, V23.2S, V23.2S
    FADDP  V8.2S, V15.2S, V23.2S
    ADDP  D21, V31.2D
    FADDP D28, V21.2D
    FMINNMP D24, V29.2D
    SMAXP  V25.8B, V3.8B, V18.8B
    FMINNMP  V0.2S, V25.2S, V22.2S
    UMAXP  V6.4H, V19.4H, V22.4H
    FMAXNMP S5, V19.2S
    FMAXP S29, V14.2S
    FMAXNMP D14, V24.2D
    FADDP S8, V2.2S
    FMAXP  V24.4S, V20.4S, V30.4S
    FMINP  V3.2D, V27.2D, V20.2D
    FMINNMP  V16.4S, V23.4S, V20.4S
    SMINP  V4.4H, V0.4H, V29.4H
    SMAXP  V16.16B, V0.16B, V11.16B
    FMINNMP S30, V15.2S
    UMINP  V7.4S, V31.4S, V25.4S
    FMINNMP D1, V24.2D
    FADDP  V18.2D, V23.2D, V9.2D
    UMINP  V13.8H, V1.8H, V4.8H
    FMAXNMP D27, V3.2D
    SMAXP  V25.4S, V21.4S, V31.4S
    FMAXNMP S23, V16.2S
    FMINP D27, V2.2D
    FMAXP S25, V13.2S
    FMINP S20, V5.2S
    SMINP  V12.4H, V2.4H, V9.4H
    FMAXNMP S26, V30.2S
    SMINP  V2.4H, V11.4H, V28.4H
    FMINNMP D20, V26.2D
    FMINP S29, V10.2S
    FMAXNMP D15, V27.2D
    SMAXP  V16.2S, V31.2S, V31.2S
    FMAXP D30, V19.2D
    FMAXP D28, V0.2D
    FMINP  V27.4S, V9.4S, V17.4S
    FMAXP S27, V10.2S
    FMAXNMP D18, V5.2D
    FMAXNMP S19, V22.2S
    FMINNMP D15, V24.2D
    FADDP  V22.2S, V21.2S, V31.2S
    FMAXNMP S0, V17.2S
    ADDP  D23, V26.2D
    FMINNMP  V7.4S, V27.4S, V1.4S
    SMAXP  V27.4H, V17.4H, V3.4H
    ADDP  V17.8H, V8.8H, V2.8H
    FMINP D19, V16.2D
    FMAXNMP D18, V6.2D
    FMAXNMP D22, V11.2D
    FMAXP D31, V22.2D
    ADDP  D4, V14.2D
    FMAXNMP S24, V0.2S
    SMINP  V10.8B, V4.8B, V3.8B
    UMAXP  V4.2S, V10.2S, V14.2S
    FMAXNMP  V0.2S, V9.2S, V18.2S
    FADDP  V26.2S, V4.2S, V11.2S
    FMINNMP S24, V27.2S
    FMAXP  V0.4S, V12.4S, V25.4S
    FMINNMP  V23.4S, V1.4S, V11.4S
    FMAXNMP S23, V28.2S
    UMAXP  V4.2S, V22.2S, V2.2S
    FMINP D1, V27.2D
    FMINNMP D14, V16.2D
    FMINP S18, V25.2S
    ADDP  V19.4H, V6.4H, V23.4H
    ADDP  D30, V21.2D
    FMAXP S16, V2.2S
    FMAXP  V3.4S, V29.4S, V7.4S
    ADDP  V5.4S, V21.4S, V17.4S
    SMINP  V3.16B, V29.16B, V15.16B
    FMINP S1, V8.2S
    SMAXP  V17.2S, V18.2S, V20.2S
    FMINNMP D11, V29.2D
    UMAXP  V22.4S, V31.4S, V29.4S
    FMAXNMP S0, V21.2S
    FMAXNMP  V20.2D, V1.2D, V22.2D
    UMAXP  V9.8H, V30.8H, V10.8H
    FMINP D20, V19.2D
    FMAXP S27, V30.2S
    FMAXP S2, V4.2S
    SMINP  V14.4H, V26.4H, V29.4H
    ADDP  V29.2D, V31.2D, V28.2D
    FADDP  V24.2D, V18.2D, V10.2D
    FADDP  V0.2S, V2.2S, V17.2S
    FMINP S27, V7.2S
    SMINP  V17.4S, V13.4S, V9.4S
    FMINNMP D26, V7.2D
    FMINP S4, V15.2S
    SMINP  V29.8H, V12.8H, V13.8H
    FMAXNMP D5, V15.2D
    UMINP  V10.16B, V4.16B, V18.16B
    FMAXNMP D24, V31.2D
    FADDP  V4.2S, V8.2S, V9.2S
    FMAXNMP S14, V10.2S
    FMAXNMP D29, V22.2D
    UMINP  V31.8H, V26.8H, V10.8H
    FMINP  V13.4S, V15.4S, V30.4S
    SMAXP  V0.4H, V14.4H, V18.4H
    FMAXNMP  V22.2D, V13.2D, V0.2D
    FMAXP S7, V10.2S
    FMINP  V14.2S, V25.2S, V26.2S
    FMINNMP D3, V12.2D
    FMINP D24, V16.2D
    UMINP  V23.8H, V27.8H, V6.8H
    FMINNMP D2, V31.2D
    FMINP  V31.4S, V11.4S, V29.4S
    UMINP  V12.8H, V14.8H, V24.8H
    UMINP  V21.2S, V0.2S, V31.2S
    ADDP  V4.8H, V29.8H, V18.8H
    FMAXNMP  V3.2S, V22.2S, V11.2S
    FMAXP D27, V3.2D
    FMAXP D23, V5.2D
    FMINP  V8.2D, V18.2D, V9.2D
    FMINNMP D31, V2.2D
    FMINP D0, V7.2D
    FMINP  V31.4S, V0.4S, V23.4S
    UMINP  V20.8H, V0.8H, V29.8H
    FMINP  V22.4S, V13.4S, V29.4S
    FMAXNMP  V21.2S, V3.2S, V14.2S
    FMINP S29, V16.2S
    FADDP S31, V5.2S
    FMINNMP  V11.2D, V28.2D, V11.2D
    FMINP D27, V29.2D
    FMAXNMP D24, V4.2D
    FMAXP S20, V8.2S
    SMAXP  V20.4H, V22.4H, V8.4H
    UMAXP  V19.8H, V15.8H, V5.8H
    SMAXP  V16.8B, V3.8B, V24.8B
    UMAXP  V31.8B, V27.8B, V15.8B
    FMINP  V10.2D, V24.2D, V31.2D
    SUBS  X17, X17, #0x1
    B.NE  TaishanSimdComplexP01_label_571
    MOVZ  X17, #0x0, LSL #0
    SUB  X21, X17, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X19, X20, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X9
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X22, X17, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X22
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X10, X13, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X20, X6, X25
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X5, V2.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X21, X11, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X5, D2
    MOVZ  X11, #0x0, LSL #0
    SUB  X21, X11, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X5, V3.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X5, D3
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X15, V4.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X15, D4
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X24, D5
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X7, D6
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X25, V7.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X25, D7
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X19, X11, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    FMOV  X4, D8
    MOVZ  X11, #0x0, LSL #0
    SUB  X19, X11, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X2, D9
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X3, D10
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X19, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X14, X29, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X19, D11
    MOVZ  X29, #0x0, LSL #0
    SUB  X14, X29, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X24, V12.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X24, D12
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X23, D13
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X16, D14
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X24, D15
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X19, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X19, D16
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X14, D17
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X11, D18
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X2, D19
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X25, X22, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X29, D20
    MOVZ  X22, #0x0, LSL #0
    SUB  X25, X22, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X2, D21
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X29, V22.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X29, D22
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X8
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X8, D23
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X8
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X9, V24.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X9, D24
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X8, D25
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X17, D26
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X21, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X21, D28
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X9, D29
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
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
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X12
    FMOV  D1, X19
    FMOV  V1.D[1], X24
    FMOV  D2, X18
    FMOV  V2.D[1], X2
    FMOV  D3, X28
    FMOV  V3.D[1], X17
    FMOV  D4, X29
    FMOV  V4.D[1], X19
    FMOV  D5, X12
    FMOV  V5.D[1], X26
    FMOV  D6, X8
    FMOV  V6.D[1], X7
    FMOV  D7, X4
    FMOV  V7.D[1], X8
    FMOV  D8, X4
    FMOV  V8.D[1], X11
    FMOV  D9, X5
    FMOV  V9.D[1], X14
    FMOV  D10, X24
    FMOV  V10.D[1], X2
    FMOV  D11, X29
    FMOV  V11.D[1], X17
    FMOV  D12, X7
    FMOV  V12.D[1], X23
    FMOV  D13, X26
    FMOV  V13.D[1], X18
    FMOV  D14, X9
    FMOV  V14.D[1], X9
    FMOV  D15, X9
    FMOV  V15.D[1], X3
    FMOV  D16, X16
    FMOV  V16.D[1], X8
    FMOV  D17, X8
    FMOV  V17.D[1], X14
    FMOV  D18, X7
    FMOV  V18.D[1], X29
    FMOV  D19, X7
    FMOV  V19.D[1], X28
    FMOV  D20, X12
    FMOV  V20.D[1], X28
    FMOV  D21, X10
    FMOV  V21.D[1], X9
    FMOV  D22, X3
    FMOV  V22.D[1], X2
    FMOV  D23, X24
    FMOV  V23.D[1], X16
    FMOV  D24, X26
    FMOV  V24.D[1], X3
    FMOV  D25, X7
    FMOV  V25.D[1], X29
    FMOV  D26, X3
    FMOV  V26.D[1], X7
    FMOV  D27, X23
    FMOV  V27.D[1], X28
    FMOV  D28, X25
    FMOV  V28.D[1], X13
    FMOV  D29, X12
    FMOV  V29.D[1], X12
    FMOV  D30, X10
    FMOV  V30.D[1], X28
    FMOV  D31, X28
    FMOV  V31.D[1], X11
    MOVZ  X18, #0xf, LSL #0
TaishanSimdComplexP01_label_651:
    FMINNMP D14, V9.2D
    FMINP D3, V17.2D
    FMINNMP  V28.2S, V30.2S, V25.2S
    UMAXP  V0.8B, V24.8B, V12.8B
    ADDP  V27.4S, V4.4S, V1.4S
    FMINNMP  V22.2D, V23.2D, V29.2D
    FMAXP D10, V28.2D
    FADDP D26, V15.2D
    FADDP D13, V19.2D
    FMAXNMP D4, V3.2D
    FADDP D19, V20.2D
    FADDP S19, V7.2S
    FMAXNMP S14, V13.2S
    FMAXP D1, V23.2D
    ADDP  D27, V11.2D
    FMAXP  V30.2S, V17.2S, V13.2S
    FMINP D20, V9.2D
    FMINNMP D6, V29.2D
    ADDP  V26.2S, V20.2S, V23.2S
    ADDP  D14, V31.2D
    FMAXNMP D19, V25.2D
    FADDP  V6.2S, V15.2S, V4.2S
    FADDP D12, V24.2D
    FMINNMP S14, V10.2S
    SMAXP  V0.8B, V28.8B, V24.8B
    FADDP D6, V22.2D
    FMINP  V9.2D, V20.2D, V30.2D
    FMINP  V9.2S, V7.2S, V19.2S
    SMAXP  V9.4H, V0.4H, V8.4H
    FMAXNMP  V13.2S, V21.2S, V12.2S
    FADDP D14, V14.2D
    ADDP  V26.4H, V28.4H, V24.4H
    FMAXP D6, V23.2D
    FMAXP  V7.2D, V27.2D, V4.2D
    FMAXP S11, V21.2S
    FADDP  V17.2S, V15.2S, V29.2S
    FMAXNMP S12, V5.2S
    FMAXP D22, V25.2D
    UMINP  V15.8H, V30.8H, V25.8H
    FMAXP  V11.2S, V25.2S, V12.2S
    FMAXNMP S1, V23.2S
    FMAXNMP D17, V12.2D
    FADDP S17, V20.2S
    ADDP  V11.4S, V11.4S, V29.4S
    FMINP  V8.2D, V12.2D, V3.2D
    FMINNMP  V5.2S, V16.2S, V30.2S
    FMINP D3, V31.2D
    FMINP  V26.2D, V7.2D, V29.2D
    ADDP  V17.8H, V7.8H, V4.8H
    FMINP S5, V31.2S
    FMAXP  V30.2S, V25.2S, V24.2S
    FMINNMP D6, V0.2D
    FMAXNMP D8, V5.2D
    FMINP S22, V18.2S
    FMAXNMP D12, V22.2D
    FMINNMP  V18.4S, V19.4S, V23.4S
    SMAXP  V0.4H, V20.4H, V13.4H
    SMAXP  V30.2S, V7.2S, V30.2S
    ADDP  D22, V18.2D
    FMINP S29, V20.2S
    FMAXNMP  V23.2S, V23.2S, V24.2S
    FMINNMP D7, V16.2D
    FADDP  V28.4S, V16.4S, V4.4S
    FMINNMP  V8.2D, V27.2D, V30.2D
    FMINNMP  V19.2D, V28.2D, V25.2D
    UMAXP  V15.8H, V17.8H, V20.8H
    FADDP D10, V1.2D
    FMINP  V24.2D, V0.2D, V24.2D
    FMINNMP  V13.2S, V2.2S, V14.2S
    SMAXP  V22.4H, V19.4H, V24.4H
    UMINP  V22.16B, V13.16B, V14.16B
    UMAXP  V23.4S, V10.4S, V0.4S
    UMAXP  V3.16B, V27.16B, V17.16B
    FMAXP D17, V12.2D
    FMINNMP S19, V29.2S
    FADDP D29, V8.2D
    FADDP  V31.4S, V29.4S, V14.4S
    FMINNMP  V3.2S, V7.2S, V1.2S
    SMINP  V22.8B, V15.8B, V2.8B
    UMAXP  V20.8H, V31.8H, V24.8H
    FMAXNMP  V14.4S, V11.4S, V25.4S
    FMAXP S22, V27.2S
    FMAXNMP S25, V3.2S
    FMAXNMP S12, V17.2S
    FMAXP  V19.2D, V0.2D, V31.2D
    FMAXP  V25.2S, V7.2S, V6.2S
    FMINP  V3.2S, V1.2S, V4.2S
    FMAXNMP  V30.4S, V31.4S, V31.4S
    FMINP  V2.4S, V30.4S, V12.4S
    FMINP  V17.2D, V30.2D, V15.2D
    FMAXNMP  V23.4S, V1.4S, V21.4S
    ADDP  D20, V21.2D
    ADDP  V9.8H, V14.8H, V12.8H
    FMINP S29, V26.2S
    FMINNMP S11, V5.2S
    FADDP D21, V11.2D
    FADDP D22, V10.2D
    UMAXP  V22.8B, V23.8B, V12.8B
    SMINP  V18.16B, V29.16B, V24.16B
    UMINP  V23.4S, V31.4S, V14.4S
    UMINP  V14.4S, V5.4S, V12.4S
    FMAXNMP  V14.4S, V17.4S, V0.4S
    FMINNMP  V19.2S, V1.2S, V13.2S
    UMINP  V13.8B, V19.8B, V17.8B
    FMINNMP D4, V9.2D
    ADDP  V14.4H, V4.4H, V28.4H
    FADDP  V11.2S, V25.2S, V2.2S
    ADDP  V26.4H, V29.4H, V1.4H
    FMINP S20, V21.2S
    FMAXNMP D13, V21.2D
    FADDP S3, V3.2S
    ADDP  V14.4S, V24.4S, V14.4S
    ADDP  D23, V30.2D
    FMAXNMP D14, V30.2D
    FMAXNMP  V16.4S, V29.4S, V30.4S
    UMAXP  V5.8H, V13.8H, V3.8H
    FADDP D19, V25.2D
    UMAXP  V6.2S, V28.2S, V1.2S
    FADDP S14, V14.2S
    ADDP  V3.4S, V22.4S, V2.4S
    SMAXP  V26.8B, V18.8B, V6.8B
    UMAXP  V17.4S, V0.4S, V24.4S
    FADDP  V15.2D, V29.2D, V0.2D
    UMAXP  V7.2S, V6.2S, V24.2S
    ADDP  D21, V30.2D
    FMAXP  V30.2S, V4.2S, V6.2S
    FMINP S4, V1.2S
    FMINNMP  V9.4S, V4.4S, V23.4S
    FMINP  V23.2S, V30.2S, V12.2S
    FMAXP D14, V19.2D
    FMAXP S14, V16.2S
    FADDP  V18.2D, V22.2D, V18.2D
    FMINNMP  V11.2D, V23.2D, V3.2D
    FMAXNMP S7, V14.2S
    FMINNMP S28, V23.2S
    FADDP D5, V7.2D
    FMAXP  V1.2S, V9.2S, V28.2S
    ADDP  V20.4S, V19.4S, V5.4S
    FMINNMP  V14.2D, V3.2D, V4.2D
    ADDP  V6.4S, V5.4S, V22.4S
    FMINNMP  V15.2S, V1.2S, V19.2S
    FMINNMP D28, V31.2D
    UMINP  V20.8B, V23.8B, V6.8B
    FMAXNMP D20, V13.2D
    FMAXP D13, V27.2D
    FMINNMP S1, V22.2S
    FMINP  V0.4S, V11.4S, V23.4S
    FMAXP S19, V13.2S
    ADDP  D21, V22.2D
    FMINP  V9.2D, V7.2D, V16.2D
    FMINNMP D0, V31.2D
    UMAXP  V8.4H, V18.4H, V17.4H
    FADDP S17, V29.2S
    FMINNMP S14, V5.2S
    FADDP S27, V23.2S
    ADDP  V20.16B, V7.16B, V12.16B
    ADDP  V0.8H, V24.8H, V28.8H
    FMAXP S29, V17.2S
    SMINP  V15.4S, V19.4S, V26.4S
    FMINNMP S28, V14.2S
    FMAXNMP  V7.2S, V1.2S, V25.2S
    FMAXNMP S10, V21.2S
    FMAXP S5, V26.2S
    FMAXP  V22.2S, V3.2S, V13.2S
    FMAXP  V17.2S, V17.2S, V10.2S
    FMAXP  V12.4S, V10.4S, V10.4S
    FMAXNMP D19, V23.2D
    FADDP D5, V18.2D
    FADDP  V16.2D, V5.2D, V31.2D
    SMINP  V2.2S, V15.2S, V3.2S
    FMINNMP  V4.2S, V24.2S, V2.2S
    FADDP  V27.2D, V6.2D, V2.2D
    FMAXNMP  V30.4S, V8.4S, V28.4S
    FMAXP D28, V28.2D
    FMINNMP  V11.2D, V12.2D, V22.2D
    FMINNMP D31, V20.2D
    FMINNMP S21, V13.2S
    FMAXP  V28.2S, V5.2S, V15.2S
    FADDP D18, V11.2D
    FMINP  V10.2D, V22.2D, V13.2D
    FMINP D22, V27.2D
    FMINP D27, V30.2D
    SMINP  V4.4S, V25.4S, V7.4S
    FMAXNMP D4, V23.2D
    FMINNMP D3, V13.2D
    FMINP  V16.4S, V10.4S, V11.4S
    ADDP  V29.4S, V22.4S, V31.4S
    FMINP  V16.2S, V20.2S, V4.2S
    FADDP D19, V4.2D
    FMINP S25, V20.2S
    UMAXP  V27.2S, V26.2S, V13.2S
    FADDP S17, V28.2S
    FMAXP S22, V2.2S
    FMAXP S19, V22.2S
    FMINP D22, V8.2D
    FMINNMP D23, V18.2D
    FADDP D7, V22.2D
    SMINP  V24.4S, V30.4S, V30.4S
    FMINP D6, V7.2D
    FMAXP  V10.2S, V2.2S, V28.2S
    SUBS  X18, X18, #0x1
    B.NE  TaishanSimdComplexP01_label_651
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X4, X20, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X9, X25, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X17, X6, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X4, X17, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X14, X11, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X9, X14, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X13, X19, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X13, X4, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X28, X3, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X28, X9, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X11, X17, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X21, X4, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X12, X9, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X18, X2, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X12, X16, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X29, X28, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X19, X20, X25
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X21, X11, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X20, X24, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    FMOV  X22, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X22, D2
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X4, D3
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X6, X18, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X9, D4
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X6, X18, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X10, D5
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X4, D6
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X10, V7.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X10, D7
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X5, D8
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X15, V9.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X15, D9
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X6, X8, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X26, D10
    MOVZ  X8, #0x0, LSL #0
    SUB  X6, X8, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X24, D11
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X2, D12
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X7, D13
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X20, D14
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X21, V15.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X21, D15
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X8, X2, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X20, D16
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X8, X2, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X6, D17
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X14, D18
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X24, D19
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X23, D20
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X26, X9, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X15, D21
    MOVZ  X9, #0x0, LSL #0
    SUB  X26, X9, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X13, D22
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X5, V23.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X5, D23
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X6, D24
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X17, D25
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X25, X8, X20
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X20, D26
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xffff, LSL #32
    SUB  X25, X8, X20
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X14, D28
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X9, D29
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    MOVZ  X2, #0x283f, LSL #0
    MOVK  X2, #0x9dff, LSL #16
    MOVK  X2, #0x5d76, LSL #32
    MOVK  X2, #0xdc34, LSL #48
    MOVZ  X3, #0x9abf, LSL #0
    MOVK  X3, #0xddb, LSL #16
    MOVK  X3, #0x767b, LSL #32
    MOVK  X3, #0x1fe3, LSL #48
    MOVZ  X4, #0x2328, LSL #0
    MOVK  X4, #0x252c, LSL #16
    MOVK  X4, #0x44a4, LSL #32
    MOVK  X4, #0x85f5, LSL #48
    MOVZ  X5, #0x75c3, LSL #0
    MOVK  X5, #0x3e7c, LSL #16
    MOVK  X5, #0x7cc, LSL #32
    MOVK  X5, #0x846d, LSL #48
    MOVZ  X6, #0xb8ab, LSL #0
    MOVK  X6, #0xab67, LSL #16
    MOVK  X6, #0xd716, LSL #32
    MOVK  X6, #0xa6b8, LSL #48
    MOVZ  X7, #0x8409, LSL #0
    MOVK  X7, #0x1abb, LSL #16
    MOVK  X7, #0xd32b, LSL #32
    MOVK  X7, #0x3de0, LSL #48
    MOVZ  X8, #0x313b, LSL #0
    MOVK  X8, #0xef86, LSL #16
    MOVK  X8, #0x6c96, LSL #32
    MOVK  X8, #0x7260, LSL #48
    MOVZ  X9, #0xed80, LSL #0
    MOVK  X9, #0x53be, LSL #16
    MOVK  X9, #0xc702, LSL #32
    MOVK  X9, #0x3ae3, LSL #48
    MOVZ  X10, #0xac2b, LSL #0
    MOVK  X10, #0xd7d6, LSL #16
    MOVK  X10, #0x970b, LSL #32
    MOVK  X10, #0x3a3, LSL #48
    MOVZ  X11, #0x225d, LSL #0
    MOVK  X11, #0x5a88, LSL #16
    MOVK  X11, #0xcb4, LSL #32
    MOVK  X11, #0xa918, LSL #48
    MOVZ  X12, #0x1906, LSL #0
    MOVK  X12, #0xa660, LSL #16
    MOVK  X12, #0xa9ef, LSL #32
    MOVK  X12, #0xf292, LSL #48
    MOVZ  X13, #0xb8c3, LSL #0
    MOVK  X13, #0x66ae, LSL #16
    MOVK  X13, #0xc278, LSL #32
    MOVK  X13, #0x153b, LSL #48
    MOVZ  X14, #0x3617, LSL #0
    MOVK  X14, #0xf020, LSL #16
    MOVK  X14, #0x7939, LSL #32
    MOVK  X14, #0xda40, LSL #48
    MOVZ  X15, #0xc364, LSL #0
    MOVK  X15, #0xc887, LSL #16
    MOVK  X15, #0xda15, LSL #32
    MOVK  X15, #0xdfe3, LSL #48
    MOVZ  X16, #0xa4ab, LSL #0
    MOVK  X16, #0x70c9, LSL #16
    MOVK  X16, #0x1ac1, LSL #32
    MOVK  X16, #0xb5b3, LSL #48
    MOVZ  X17, #0xf0f5, LSL #0
    MOVK  X17, #0xd43e, LSL #16
    MOVK  X17, #0x60b8, LSL #32
    MOVK  X17, #0x1713, LSL #48
    MOVZ  X18, #0xd072, LSL #0
    MOVK  X18, #0xe3a4, LSL #16
    MOVK  X18, #0xc332, LSL #32
    MOVK  X18, #0x33cd, LSL #48
    MOVZ  X19, #0xb9d0, LSL #0
    MOVK  X19, #0x4705, LSL #16
    MOVK  X19, #0x85ce, LSL #32
    MOVK  X19, #0xf22e, LSL #48
    MOVZ  X20, #0x7932, LSL #0
    MOVK  X20, #0xbfd9, LSL #16
    MOVK  X20, #0x797d, LSL #32
    MOVK  X20, #0x2d1f, LSL #48
    MOVZ  X21, #0xcdb, LSL #0
    MOVK  X21, #0x3d1a, LSL #16
    MOVK  X21, #0x9329, LSL #32
    MOVK  X21, #0x41ae, LSL #48
    MOVZ  X22, #0xbb9b, LSL #0
    MOVK  X22, #0x50f8, LSL #16
    MOVK  X22, #0x736f, LSL #32
    MOVK  X22, #0x69fa, LSL #48
    MOVZ  X23, #0x8fe7, LSL #0
    MOVK  X23, #0x8cf4, LSL #16
    MOVK  X23, #0xf0c9, LSL #32
    MOVK  X23, #0x3c0b, LSL #48
    MOVZ  X24, #0xb12a, LSL #0
    MOVK  X24, #0x2abe, LSL #16
    MOVK  X24, #0xc465, LSL #32
    MOVK  X24, #0xc803, LSL #48
    MOVZ  X25, #0x67a, LSL #0
    MOVK  X25, #0xd6e6, LSL #16
    MOVK  X25, #0x8c64, LSL #32
    MOVK  X25, #0xc178, LSL #48
    MOVZ  X26, #0x6d5e, LSL #0
    MOVK  X26, #0xa2d7, LSL #16
    MOVK  X26, #0x9d77, LSL #32
    MOVK  X26, #0x5e78, LSL #48
    MOVZ  X28, #0x3d2, LSL #0
    MOVK  X28, #0xc5bd, LSL #16
    MOVK  X28, #0x1760, LSL #32
    MOVK  X28, #0x65b9, LSL #48
    MOVZ  X29, #0x4480, LSL #0
    MOVK  X29, #0x8995, LSL #16
    MOVK  X29, #0x5ea5, LSL #32
    MOVK  X29, #0xd7d9, LSL #48
    FMOV  D0, X16
    FMOV  V0.D[1], X21
    FMOV  D1, X4
    FMOV  V1.D[1], X26
    FMOV  D2, X28
    FMOV  V2.D[1], X11
    FMOV  D3, X28
    FMOV  V3.D[1], X7
    FMOV  D4, X5
    FMOV  V4.D[1], X7
    FMOV  D5, X18
    FMOV  V5.D[1], X6
    FMOV  D6, X11
    FMOV  V6.D[1], X23
    FMOV  D7, X22
    FMOV  V7.D[1], X19
    FMOV  D8, X29
    FMOV  V8.D[1], X16
    FMOV  D9, X19
    FMOV  V9.D[1], X24
    FMOV  D10, X29
    FMOV  V10.D[1], X13
    FMOV  D11, X6
    FMOV  V11.D[1], X20
    FMOV  D12, X6
    FMOV  V12.D[1], X20
    FMOV  D13, X18
    FMOV  V13.D[1], X14
    FMOV  D14, X18
    FMOV  V14.D[1], X22
    FMOV  D15, X12
    FMOV  V15.D[1], X18
    FMOV  D16, X10
    FMOV  V16.D[1], X18
    FMOV  D17, X17
    FMOV  V17.D[1], X20
    FMOV  D18, X10
    FMOV  V18.D[1], X7
    FMOV  D19, X22
    FMOV  V19.D[1], X18
    FMOV  D20, X29
    FMOV  V20.D[1], X18
    FMOV  D21, X5
    FMOV  V21.D[1], X15
    FMOV  D22, X2
    FMOV  V22.D[1], X28
    FMOV  D23, X4
    FMOV  V23.D[1], X14
    FMOV  D24, X28
    FMOV  V24.D[1], X6
    FMOV  D25, X19
    FMOV  V25.D[1], X20
    FMOV  D26, X28
    FMOV  V26.D[1], X21
    FMOV  D27, X28
    FMOV  V27.D[1], X5
    FMOV  D28, X6
    FMOV  V28.D[1], X22
    FMOV  D29, X14
    FMOV  V29.D[1], X15
    FMOV  D30, X16
    FMOV  V30.D[1], X12
    FMOV  D31, X29
    FMOV  V31.D[1], X2
    MOVZ  X25, #0xa, LSL #0
TaishanSimdComplexP01_label_730:
    FMAXNMP  V24.2S, V29.2S, V13.2S
    FMAXP  V22.2D, V18.2D, V21.2D
    FMAXP D28, V29.2D
    FMAXP D6, V24.2D
    FADDP S26, V31.2S
    FMINP  V8.2D, V6.2D, V26.2D
    FMAXP S11, V22.2S
    FADDP S19, V29.2S
    FADDP  V8.2S, V15.2S, V15.2S
    FMAXNMP D9, V25.2D
    ADDP  V27.8H, V11.8H, V23.8H
    FMINP D14, V27.2D
    FADDP S8, V6.2S
    ADDP  V23.4S, V31.4S, V23.4S
    FMINNMP D31, V15.2D
    FMAXP S16, V3.2S
    ADDP  D19, V14.2D
    FMAXNMP D16, V25.2D
    FADDP S0, V17.2S
    FMINNMP  V0.4S, V8.4S, V16.4S
    FMAXP  V28.4S, V16.4S, V19.4S
    FMINNMP D9, V18.2D
    UMINP  V25.8B, V3.8B, V23.8B
    UMAXP  V3.8H, V8.8H, V30.8H
    UMAXP  V26.2S, V8.2S, V29.2S
    FMINP D5, V27.2D
    FMINNMP  V8.2S, V7.2S, V30.2S
    SMAXP  V9.8B, V17.8B, V15.8B
    FMINNMP S5, V0.2S
    ADDP  V6.2D, V16.2D, V9.2D
    FMINNMP  V24.4S, V1.4S, V27.4S
    ADDP  V7.8H, V7.8H, V1.8H
    FMINNMP S8, V19.2S
    FMAXNMP D10, V17.2D
    FMAXNMP  V6.2D, V8.2D, V23.2D
    UMINP  V5.8H, V1.8H, V11.8H
    FMAXNMP S1, V27.2S
    SMINP  V29.4S, V11.4S, V30.4S
    UMINP  V27.4H, V18.4H, V11.4H
    UMAXP  V12.16B, V24.16B, V29.16B
    FADDP D26, V31.2D
    FMINNMP D31, V12.2D
    FMINP S30, V25.2S
    SMINP  V9.4H, V4.4H, V7.4H
    SMINP  V22.4S, V4.4S, V8.4S
    FMINP D8, V26.2D
    SMINP  V25.16B, V3.16B, V9.16B
    SMAXP  V0.16B, V6.16B, V13.16B
    FMINNMP  V0.2D, V17.2D, V4.2D
    FMAXNMP S9, V2.2S
    FADDP D3, V29.2D
    FADDP D3, V4.2D
    FMINNMP S7, V8.2S
    FADDP S31, V17.2S
    FADDP  V26.2D, V30.2D, V31.2D
    FMAXP  V24.2S, V17.2S, V29.2S
    ADDP  V19.8B, V2.8B, V3.8B
    FMAXP D12, V30.2D
    ADDP  D2, V22.2D
    UMAXP  V4.4S, V12.4S, V27.4S
    UMAXP  V23.4H, V12.4H, V12.4H
    FMAXNMP D20, V20.2D
    FMAXNMP S12, V4.2S
    ADDP  V19.16B, V30.16B, V1.16B
    FMAXNMP D7, V25.2D
    FMAXP S7, V29.2S
    SMINP  V11.2S, V14.2S, V23.2S
    FMINP D29, V2.2D
    FADDP  V10.4S, V14.4S, V24.4S
    FMINNMP D8, V3.2D
    FMINNMP  V31.2S, V7.2S, V3.2S
    FADDP D4, V29.2D
    FMINP  V21.2D, V4.2D, V18.2D
    FMINNMP D20, V2.2D
    FMAXNMP  V21.4S, V10.4S, V26.4S
    SMINP  V7.2S, V0.2S, V12.2S
    FMAXP D27, V29.2D
    FADDP  V13.2D, V19.2D, V8.2D
    FMINP  V6.4S, V23.4S, V17.4S
    FMAXP  V5.4S, V17.4S, V3.4S
    FMAXP  V16.2S, V18.2S, V10.2S
    FMAXP D11, V6.2D
    ADDP  D27, V31.2D
    FMINP S13, V27.2S
    FMAXP  V4.2D, V20.2D, V28.2D
    ADDP  D22, V4.2D
    FMAXP  V20.4S, V7.4S, V3.4S
    FMINP S16, V2.2S
    FADDP  V27.2D, V29.2D, V21.2D
    FMAXP D9, V29.2D
    FMINP S8, V26.2S
    FMINNMP S5, V9.2S
    FMAXP D11, V12.2D
    UMINP  V24.8H, V17.8H, V0.8H
    FMINP S16, V27.2S
    UMINP  V14.4S, V15.4S, V16.4S
    ADDP  D7, V22.2D
    FMINP D8, V11.2D
    SMAXP  V13.8H, V5.8H, V5.8H
    SMINP  V10.16B, V28.16B, V13.16B
    FMAXNMP S7, V18.2S
    FMAXP S23, V31.2S
    FMAXP D20, V14.2D
    FMAXNMP S20, V28.2S
    FMINNMP S6, V19.2S
    ADDP  V12.16B, V24.16B, V6.16B
    ADDP  D6, V9.2D
    SMINP  V11.2S, V27.2S, V3.2S
    FMAXP D22, V10.2D
    FMAXP  V13.2S, V8.2S, V31.2S
    FADDP  V26.2D, V10.2D, V22.2D
    FADDP S14, V11.2S
    ADDP  V2.4H, V7.4H, V25.4H
    FADDP  V12.2D, V3.2D, V30.2D
    ADDP  V16.16B, V12.16B, V15.16B
    FMAXNMP S19, V27.2S
    SMAXP  V30.4S, V20.4S, V28.4S
    FMINNMP D20, V15.2D
    FMINP  V18.2S, V10.2S, V4.2S
    FADDP S14, V4.2S
    FMINP D22, V13.2D
    FMAXP  V13.2S, V1.2S, V13.2S
    UMINP  V13.16B, V27.16B, V4.16B
    FMAXP  V13.2S, V31.2S, V4.2S
    FMAXNMP D6, V4.2D
    UMINP  V22.4H, V20.4H, V22.4H
    ADDP  V30.16B, V29.16B, V14.16B
    UMAXP  V27.8B, V11.8B, V18.8B
    UMAXP  V29.2S, V31.2S, V25.2S
    UMINP  V5.8H, V4.8H, V14.8H
    FADDP S14, V4.2S
    UMINP  V13.4H, V7.4H, V20.4H
    FMAXP  V4.2S, V12.2S, V4.2S
    SMINP  V31.16B, V12.16B, V28.16B
    FADDP D5, V17.2D
    FMAXP D0, V1.2D
    ADDP  V1.4S, V7.4S, V21.4S
    FMINP D11, V18.2D
    SMAXP  V25.16B, V0.16B, V22.16B
    FMAXNMP S22, V17.2S
    SMAXP  V20.4H, V1.4H, V15.4H
    FMINNMP S11, V11.2S
    FMAXNMP S12, V22.2S
    FMINP  V3.2S, V31.2S, V31.2S
    FADDP D13, V20.2D
    FMAXP  V28.2D, V21.2D, V29.2D
    FMAXNMP D14, V6.2D
    FMINNMP D6, V8.2D
    FMAXNMP D27, V28.2D
    FADDP D5, V22.2D
    FADDP  V31.2S, V31.2S, V9.2S
    FADDP  V27.2D, V25.2D, V8.2D
    UMINP  V24.4H, V7.4H, V16.4H
    FMAXP S31, V0.2S
    FADDP  V17.2D, V22.2D, V4.2D
    FMAXP D28, V11.2D
    FMINP  V0.4S, V28.4S, V28.4S
    FMAXNMP  V17.2D, V13.2D, V12.2D
    FMAXP D17, V29.2D
    FMINNMP S6, V29.2S
    FMAXP D4, V0.2D
    FMAXP D5, V2.2D
    UMAXP  V21.2S, V3.2S, V20.2S
    FMINNMP  V25.4S, V17.4S, V2.4S
    UMAXP  V14.8H, V8.8H, V18.8H
    FMINP S11, V11.2S
    SMINP  V26.8H, V6.8H, V7.8H
    SMAXP  V23.16B, V4.16B, V29.16B
    ADDP  V4.8B, V22.8B, V20.8B
    FADDP D3, V4.2D
    FMINP  V13.4S, V0.4S, V5.4S
    FMAXNMP  V14.2D, V2.2D, V2.2D
    UMINP  V20.4S, V31.4S, V21.4S
    FMINP  V17.4S, V28.4S, V16.4S
    FMINP D11, V28.2D
    FMINNMP  V21.4S, V23.4S, V26.4S
    FMINNMP D0, V21.2D
    UMAXP  V25.4S, V24.4S, V9.4S
    FMAXNMP D30, V31.2D
    FMINNMP S21, V29.2S
    FMAXP  V25.2S, V9.2S, V21.2S
    FMAXP S6, V11.2S
    FADDP  V10.2D, V8.2D, V10.2D
    FMINNMP S14, V12.2S
    FADDP D4, V18.2D
    FMINNMP S7, V3.2S
    FMINP S8, V9.2S
    FMINNMP  V9.2S, V13.2S, V3.2S
    FMINP D18, V21.2D
    FMAXNMP S5, V0.2S
    FMAXNMP S6, V9.2S
    FMAXP  V0.2D, V12.2D, V30.2D
    UMINP  V15.8B, V16.8B, V7.8B
    FMINNMP S15, V26.2S
    FMAXNMP D15, V6.2D
    SMINP  V7.4S, V16.4S, V15.4S
    FMINP D7, V4.2D
    FMAXP D9, V0.2D
    FMINP  V10.4S, V20.4S, V20.4S
    FMINNMP D13, V5.2D
    SUBS  X25, X25, #0x1
    B.NE  TaishanSimdComplexP01_label_730
    MOVZ  X19, #0x283f, LSL #0
    MOVK  X19, #0x9dff, LSL #16
    MOVK  X19, #0x5d76, LSL #32
    MOVK  X19, #0xdc34, LSL #48
    SUB  X6, X19, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    MOVZ  X5, #0x9abf, LSL #0
    MOVK  X5, #0xddb, LSL #16
    MOVK  X5, #0x767b, LSL #32
    MOVK  X5, #0x1fe3, LSL #48
    SUB  X25, X5, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    MOVZ  X9, #0x2328, LSL #0
    MOVK  X9, #0x252c, LSL #16
    MOVK  X9, #0x44a4, LSL #32
    MOVK  X9, #0x85f5, LSL #48
    SUB  X22, X9, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    MOVZ  X22, #0x9abf, LSL #0
    MOVK  X22, #0xddb, LSL #16
    MOVK  X22, #0x767b, LSL #32
    MOVK  X22, #0x1fe3, LSL #48
    SUB  X15, X22, X5
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    MOVZ  X15, #0x8409, LSL #0
    MOVK  X15, #0x1abb, LSL #16
    MOVK  X15, #0xd32b, LSL #32
    MOVK  X15, #0x3de0, LSL #48
    SUB  X2, X15, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    MOVZ  X8, #0x313b, LSL #0
    MOVK  X8, #0xef86, LSL #16
    MOVK  X8, #0x6c96, LSL #32
    MOVK  X8, #0x7260, LSL #48
    SUB  X20, X8, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0x2328, LSL #0
    MOVK  X20, #0x252c, LSL #16
    MOVK  X20, #0x44a4, LSL #32
    MOVK  X20, #0x85f5, LSL #48
    SUB  X8, X20, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    MOVZ  X25, #0xac2b, LSL #0
    MOVK  X25, #0xd7d6, LSL #16
    MOVK  X25, #0x970b, LSL #32
    MOVK  X25, #0x3a3, LSL #48
    SUB  X12, X25, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    MOVZ  X19, #0x225d, LSL #0
    MOVK  X19, #0x5a88, LSL #16
    MOVK  X19, #0xcb4, LSL #32
    MOVK  X19, #0xa918, LSL #48
    SUB  X8, X19, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    MOVZ  X22, #0xb8c3, LSL #0
    MOVK  X22, #0x66ae, LSL #16
    MOVK  X22, #0xc278, LSL #32
    MOVK  X22, #0x153b, LSL #48
    SUB  X18, X22, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    MOVZ  X18, #0x3617, LSL #0
    MOVK  X18, #0xf020, LSL #16
    MOVK  X18, #0x7939, LSL #32
    MOVK  X18, #0xda40, LSL #48
    SUB  X16, X18, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    MOVZ  X15, #0x8409, LSL #0
    MOVK  X15, #0x1abb, LSL #16
    MOVK  X15, #0xd32b, LSL #32
    MOVK  X15, #0x3de0, LSL #48
    SUB  X8, X15, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    MOVZ  X15, #0xf0f5, LSL #0
    MOVK  X15, #0xd43e, LSL #16
    MOVK  X15, #0x60b8, LSL #32
    MOVK  X15, #0x1713, LSL #48
    SUB  X22, X15, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    MOVZ  X15, #0x3617, LSL #0
    MOVK  X15, #0xf020, LSL #16
    MOVK  X15, #0x7939, LSL #32
    MOVK  X15, #0xda40, LSL #48
    SUB  X10, X15, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    MOVZ  X9, #0x225d, LSL #0
    MOVK  X9, #0x5a88, LSL #16
    MOVK  X9, #0xcb4, LSL #32
    MOVK  X9, #0xa918, LSL #48
    SUB  X19, X9, X19
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    MOVZ  X8, #0x2328, LSL #0
    MOVK  X8, #0x252c, LSL #16
    MOVK  X8, #0x44a4, LSL #32
    MOVK  X8, #0x85f5, LSL #48
    SUB  X23, X8, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    MOVZ  X9, #0xcdb, LSL #0
    MOVK  X9, #0x3d1a, LSL #16
    MOVK  X9, #0x9329, LSL #32
    MOVK  X9, #0x41ae, LSL #48
    SUB  X5, X9, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X23
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    MOVZ  X23, #0xb12a, LSL #0
    MOVK  X23, #0x2abe, LSL #16
    MOVK  X23, #0xc465, LSL #32
    MOVK  X23, #0xc803, LSL #48
    SUB  X24, X23, X24
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0xac2b, LSL #0
    MOVK  X20, #0xd7d6, LSL #16
    MOVK  X20, #0x970b, LSL #32
    MOVK  X20, #0x3a3, LSL #48
    SUB  X13, X20, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    MOVZ  X9, #0x3d2, LSL #0
    MOVK  X9, #0xc5bd, LSL #16
    MOVK  X9, #0x1760, LSL #32
    MOVK  X9, #0x65b9, LSL #48
    SUB  X15, X9, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X13, D2
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x84, LSL #32
    SUB  X10, X14, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X11, D3
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X7, D4
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X13, D5
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X7
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X7, D6
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X7
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X15, V7.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X15, D7
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X15, X29, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X4, D8
    MOVZ  X29, #0x0, LSL #0
    SUB  X15, X29, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X2, D9
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X11, X24, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X6, D10
    MOVZ  X24, #0x0, LSL #0
    SUB  X11, X24, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X10, D11
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X13
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X13, D12
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X13
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X9, D13
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X18, V14.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X18, D14
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X16, D15
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X2, D16
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X26, X2, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X8, D17
    MOVZ  X2, #0x0, LSL #0
    SUB  X26, X2, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X11, D18
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X4, D19
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X4, D20
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X11, D21
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X9, D22
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X19, V23.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X19, D23
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X10, D24
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X17, D25
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X18, D26
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X23, D28
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X3, V29.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X3, D29
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x84, LSL #32
    SUB  X9, X16, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
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
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X17
    FMOV  V0.D[1], X8
    FMOV  D1, X15
    FMOV  V1.D[1], X20
    FMOV  D2, X13
    FMOV  V2.D[1], X15
    FMOV  D3, X16
    FMOV  V3.D[1], X7
    FMOV  D4, X14
    FMOV  V4.D[1], X26
    FMOV  D5, X11
    FMOV  V5.D[1], X15
    FMOV  D6, X3
    FMOV  V6.D[1], X23
    FMOV  D7, X29
    FMOV  V7.D[1], X4
    FMOV  D8, X20
    FMOV  V8.D[1], X28
    FMOV  D9, X4
    FMOV  V9.D[1], X11
    FMOV  D10, X23
    FMOV  V10.D[1], X20
    FMOV  D11, X26
    FMOV  V11.D[1], X28
    FMOV  D12, X13
    FMOV  V12.D[1], X23
    FMOV  D13, X17
TaishanSimdComplexP01_label_201:
    FMOV  V13.D[1], X10
TaishanSimdComplexP01_label_752:
    FMOV  D14, X21
    FMOV  V14.D[1], X28
TaishanSimdComplexP01_label_58:
    FMOV  D15, X2
    FMOV  V15.D[1], X24
    FMOV  D16, X26
    FMOV  V16.D[1], X13
    FMOV  D17, X13
    FMOV  V17.D[1], X17
    FMOV  D18, X16
    FMOV  V18.D[1], X19
    FMOV  D19, X20
    FMOV  V19.D[1], X12
    FMOV  D20, X28
    FMOV  V20.D[1], X28
    FMOV  D21, X16
    FMOV  V21.D[1], X12
    FMOV  D22, X17
    FMOV  V22.D[1], X24
    FMOV  D23, X12
    FMOV  V23.D[1], X20
    FMOV  D24, X17
    FMOV  V24.D[1], X24
    FMOV  D25, X12
    FMOV  V25.D[1], X8
    FMOV  D26, X16
    FMOV  V26.D[1], X2
    FMOV  D27, X3
    FMOV  V27.D[1], X12
    FMOV  D28, X8
    FMOV  V28.D[1], X28
    FMOV  D29, X19
    FMOV  V29.D[1], X20
    FMOV  D30, X2
    FMOV  V30.D[1], X8
    FMOV  D31, X10
    FMOV  V31.D[1], X28
    MOVZ  X14, #0xa, LSL #0
TaishanSimdComplexP01_label_810:
    FMINNMP  V3.2D, V28.2D, V22.2D
    UMAXP  V4.2S, V7.2S, V5.2S
    FMINNMP D11, V5.2D
    FMAXNMP S6, V5.2S
    FADDP  V31.4S, V27.4S, V5.4S
    UMAXP  V31.4S, V21.4S, V10.4S
    FMINP S12, V14.2S
    FMINNMP  V10.4S, V23.4S, V25.4S
    FMAXP D29, V5.2D
    FMAXNMP  V12.4S, V16.4S, V2.4S
    FMINP D29, V6.2D
    UMAXP  V0.8B, V21.8B, V3.8B
    FMINNMP D23, V3.2D
    SMINP  V4.8H, V16.8H, V9.8H
    FMAXP D10, V14.2D
    FMINNMP S20, V27.2S
    FMAXP  V26.4S, V24.4S, V22.4S
    FMINP S13, V8.2S
    FADDP  V30.2S, V27.2S, V30.2S
    FMINP S2, V3.2S
    UMINP  V31.4S, V17.4S, V24.4S
    FMAXP  V21.2S, V13.2S, V21.2S
    UMAXP  V29.2S, V12.2S, V7.2S
    FMAXP  V27.2D, V11.2D, V10.2D
    FADDP D25, V23.2D
    FMINNMP D28, V28.2D
    UMAXP  V1.4H, V17.4H, V31.4H
    FADDP  V26.2S, V18.2S, V31.2S
    FMINP S3, V12.2S
    FMINNMP  V22.4S, V24.4S, V17.4S
    FMAXP D17, V11.2D
    FMAXP S1, V24.2S
    FMINNMP S18, V10.2S
    FADDP D23, V1.2D
    FMINNMP S0, V17.2S
    FMINNMP  V28.2S, V20.2S, V5.2S
    FMINNMP  V29.4S, V23.4S, V15.4S
    FMAXNMP S12, V19.2S
    FMAXP S18, V0.2S
    FMAXP D30, V16.2D
    SMAXP  V21.8B, V20.8B, V1.8B
    FMINNMP D1, V28.2D
    FMINP S0, V25.2S
    FMAXNMP S12, V16.2S
    FMAXNMP D30, V26.2D
    FMAXP D21, V11.2D
    FMINNMP  V21.2D, V29.2D, V28.2D
    UMINP  V17.2S, V18.2S, V25.2S
    ADDP  D28, V4.2D
    FADDP  V9.2D, V28.2D, V4.2D
    SMINP  V9.16B, V31.16B, V30.16B
    FMINNMP S24, V4.2S
    FMAXNMP S8, V24.2S
    FMAXP S22, V10.2S
    FMINP S16, V7.2S
    FADDP  V31.2S, V2.2S, V18.2S
    FADDP D28, V2.2D
    UMAXP  V18.4S, V22.4S, V8.4S
    FMINP S15, V21.2S
    UMAXP  V22.4S, V0.4S, V9.4S
    FMINP D17, V9.2D
    SMAXP  V11.8H, V14.8H, V29.8H
    FADDP D15, V10.2D
    ADDP  D25, V17.2D
    FMAXP S22, V17.2S
    FMINNMP S17, V7.2S
    UMINP  V24.8H, V26.8H, V28.8H
    SMINP  V22.8H, V9.8H, V16.8H
    FMINNMP  V22.4S, V7.4S, V7.4S
    FMAXNMP S23, V23.2S
    FMINNMP S12, V17.2S
    UMAXP  V14.4H, V17.4H, V24.4H
    FMAXP S27, V4.2S
    SMAXP  V25.8H, V4.8H, V4.8H
    SMAXP  V22.16B, V8.16B, V30.16B
    ADDP  V23.4S, V30.4S, V8.4S
    FMINP D29, V23.2D
    FADDP S31, V28.2S
    FADDP  V13.4S, V15.4S, V9.4S
    FMINNMP  V9.4S, V4.4S, V19.4S
    SMINP  V0.2S, V19.2S, V24.2S
    ADDP  D0, V15.2D
    UMAXP  V21.8B, V19.8B, V17.8B
    FADDP D1, V1.2D
    ADDP  D13, V21.2D
    FMAXP S26, V19.2S
    FMINNMP D17, V21.2D
    FMAXNMP  V7.4S, V3.4S, V0.4S
    FMAXP S26, V25.2S
    FMINNMP  V19.2D, V3.2D, V14.2D
    FMAXNMP S27, V31.2S
    FADDP  V3.2D, V13.2D, V12.2D
    FADDP D4, V21.2D
    SMINP  V22.2S, V16.2S, V26.2S
    FADDP  V29.2S, V9.2S, V23.2S
    FMAXP S4, V17.2S
    FMINNMP D2, V29.2D
    FMAXP D9, V11.2D
    FADDP D18, V25.2D
    FMAXP S12, V31.2S
    SMINP  V18.8H, V23.8H, V18.8H
    ADDP  D11, V27.2D
    UMAXP  V16.8H, V19.8H, V31.8H
    FMINP D15, V15.2D
    FMINP D5, V22.2D
    FMAXP D31, V24.2D
    FMINP S2, V23.2S
    FMAXP  V14.2S, V16.2S, V3.2S
    FMAXP  V24.4S, V12.4S, V29.4S
    FMAXP  V3.2S, V8.2S, V18.2S
    FMINP D21, V0.2D
    FMINP D26, V23.2D
    FMAXP D4, V21.2D
    UMAXP  V25.2S, V13.2S, V27.2S
    FMAXNMP S2, V8.2S
    ADDP  D26, V3.2D
    SMAXP  V17.4S, V9.4S, V31.4S
    FADDP  V6.4S, V24.4S, V11.4S
    UMAXP  V30.4H, V2.4H, V23.4H
    FMAXP S12, V8.2S
    FMINP S20, V10.2S
    SMINP  V15.8B, V25.8B, V12.8B
    FMINNMP D1, V0.2D
    FMAXNMP S30, V26.2S
    FADDP  V14.4S, V28.4S, V6.4S
    FMAXNMP S11, V10.2S
    FMINP S13, V1.2S
    UMINP  V8.4H, V22.4H, V14.4H
    UMAXP  V17.16B, V5.16B, V9.16B
    ADDP  D4, V18.2D
    FADDP D27, V4.2D
    ADDP  D2, V17.2D
    FMAXP S6, V6.2S
    FMAXNMP  V31.2S, V20.2S, V28.2S
    SMINP  V2.16B, V16.16B, V2.16B
    FMINP  V25.2S, V30.2S, V12.2S
    FMAXP S2, V14.2S
    SMINP  V2.8H, V11.8H, V13.8H
    FMAXNMP  V29.2D, V10.2D, V2.2D
    FMAXNMP S11, V6.2S
    FMAXNMP D28, V6.2D
    SMINP  V4.4H, V10.4H, V20.4H
    ADDP  V16.16B, V10.16B, V9.16B
    FMAXNMP D27, V15.2D
    SMAXP  V22.8B, V24.8B, V16.8B
    FMAXNMP  V9.2S, V0.2S, V7.2S
    FMINP S13, V9.2S
    FMAXNMP S21, V22.2S
    FADDP D8, V13.2D
    FADDP  V0.2S, V1.2S, V28.2S
    UMAXP  V0.2S, V1.2S, V11.2S
    FMINP D26, V18.2D
    UMINP  V19.4H, V22.4H, V17.4H
    UMAXP  V29.4H, V9.4H, V31.4H
    ADDP  D19, V20.2D
    FMINP  V29.2S, V19.2S, V2.2S
    FMINNMP S1, V14.2S
    FMINP D13, V8.2D
    ADDP  V30.8B, V7.8B, V3.8B
    FADDP D12, V3.2D
    FADDP  V11.2S, V23.2S, V2.2S
    FADDP D0, V20.2D
    FMAXP S26, V4.2S
    FMAXNMP D31, V11.2D
    FADDP D5, V8.2D
    FMINP  V9.2S, V6.2S, V28.2S
    ADDP  V10.16B, V24.16B, V28.16B
    UMAXP  V13.4H, V31.4H, V29.4H
    FMAXNMP D31, V7.2D
    UMAXP  V12.2S, V5.2S, V18.2S
    FMAXP D11, V14.2D
    FMINP D3, V30.2D
    FADDP D0, V28.2D
    FMAXNMP S7, V7.2S
    FMAXP D20, V3.2D
    SMINP  V28.4H, V11.4H, V4.4H
    FMINNMP S20, V7.2S
    FMAXP D25, V0.2D
    FMAXP  V1.2S, V14.2S, V29.2S
    FMAXP D19, V13.2D
    FMINP  V24.4S, V0.4S, V30.4S
    FMINNMP D28, V7.2D
    FMINNMP D20, V27.2D
    FMAXP  V3.4S, V15.4S, V20.4S
    FMAXP S1, V28.2S
    ADDP  D29, V12.2D
    FADDP D9, V8.2D
    FMINP S26, V0.2S
    FMINNMP S23, V14.2S
    FMINP D5, V17.2D
    FMINP S8, V9.2S
    FMINNMP S17, V30.2S
    SMINP  V13.4H, V4.4H, V10.4H
    FMAXP  V31.4S, V27.4S, V27.4S
    FMINP  V22.2D, V7.2D, V30.2D
    FMAXNMP  V18.2S, V27.2S, V19.2S
    FADDP D20, V19.2D
    FMINNMP  V31.4S, V5.4S, V31.4S
    SMINP  V11.8B, V23.8B, V22.8B
    FMINP  V0.4S, V7.4S, V3.4S
    SUBS  X14, X14, #0x1
    B.NE  TaishanSimdComplexP01_label_810
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X28, X7, X3
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X9
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X3, X25, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X15, X29, X13
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X16, X14, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X19, X11, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X20, X11, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X20
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X20, X13, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X6, X8, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X7, X26, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X20, X17, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X26, D2
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X26, X15, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X29, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X26, X15, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X20, D4
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X2, D5
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X22, V6.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X22, D6
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X28, D7
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X10, V8.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X9, X20, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X10, D8
    MOVZ  X20, #0x0, LSL #0
    SUB  X9, X20, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X26, D9
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X9, D10
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X23, D11
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X19, V12.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X19
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X19, D12
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X19
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X12, D13
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X25, X5, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X6, D14
    MOVZ  X5, #0x0, LSL #0
    SUB  X25, X5, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X10, D15
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X8, D16
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    FMOV  X29, D17
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X29, D18
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X26, D19
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X17
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X17, D20
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X17
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X16, D21
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X14, D22
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X14, D23
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X12, D24
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X21, V25.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X21, D25
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X23, D26
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X5, X16, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X14, D28
    MOVZ  X16, #0x0, LSL #0
    SUB  X5, X16, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X19, V29.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X19, D29
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
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
TaishanSimdComplexP01_label_587:
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
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X4
    FMOV  V0.D[1], X25
    FMOV  D1, X4
    FMOV  V1.D[1], X10
    FMOV  D2, X22
    FMOV  V2.D[1], X5
    FMOV  D3, X3
    FMOV  V3.D[1], X21
    FMOV  D4, X9
    FMOV  V4.D[1], X23
    FMOV  D5, X21
    FMOV  V5.D[1], X9
    FMOV  D6, X10
    FMOV  V6.D[1], X21
    FMOV  D7, X14
    FMOV  V7.D[1], X11
    FMOV  D8, X17
    FMOV  V8.D[1], X10
    FMOV  D9, X25
    FMOV  V9.D[1], X11
    FMOV  D10, X29
    FMOV  V10.D[1], X19
    FMOV  D11, X28
    FMOV  V11.D[1], X13
    FMOV  D12, X24
    FMOV  V12.D[1], X9
    FMOV  D13, X23
    FMOV  V13.D[1], X21
    FMOV  D14, X14
    FMOV  V14.D[1], X18
    FMOV  D15, X19
    FMOV  V15.D[1], X16
    FMOV  D16, X22
    FMOV  V16.D[1], X11
    FMOV  D17, X9
    FMOV  V17.D[1], X16
    FMOV  D18, X5
    FMOV  V18.D[1], X19
    FMOV  D19, X22
    FMOV  V19.D[1], X11
    FMOV  D20, X23
    FMOV  V20.D[1], X9
    FMOV  D21, X22
    FMOV  V21.D[1], X8
    FMOV  D22, X29
    FMOV  V22.D[1], X14
    FMOV  D23, X18
    FMOV  V23.D[1], X5
    FMOV  D24, X14
    FMOV  V24.D[1], X24
    FMOV  D25, X11
    FMOV  V25.D[1], X14
    FMOV  D26, X20
    FMOV  V26.D[1], X14
    FMOV  D27, X9
    FMOV  V27.D[1], X20
    FMOV  D28, X11
    FMOV  V28.D[1], X22
    FMOV  D29, X16
    FMOV  V29.D[1], X6
    FMOV  D30, X26
    FMOV  V30.D[1], X2
    FMOV  D31, X11
    FMOV  V31.D[1], X8
    MOVZ  X13, #0xf, LSL #0
TaishanSimdComplexP01_label_888:
    FADDP D20, V27.2D
    FMAXP S26, V8.2S
    UMINP  V12.4S, V11.4S, V24.4S
    FMINNMP  V13.4S, V21.4S, V30.4S
    ADDP  V20.2D, V25.2D, V14.2D
    FMINP  V11.2S, V27.2S, V1.2S
    UMINP  V2.4H, V5.4H, V31.4H
    SMINP  V31.2S, V5.2S, V3.2S
    ADDP  D12, V24.2D
    FMAXNMP S2, V8.2S
    FMINP D15, V27.2D
    FMAXNMP D26, V5.2D
    UMAXP  V0.8B, V17.8B, V31.8B
    FMINP  V13.4S, V21.4S, V27.4S
    FMINNMP D29, V12.2D
    FMAXP S1, V20.2S
    FMAXNMP  V7.2S, V28.2S, V5.2S
    FMINNMP S29, V10.2S
    FMINP  V22.2D, V7.2D, V8.2D
    FMINNMP S13, V8.2S
    SMAXP  V10.4S, V9.4S, V29.4S
    ADDP  V21.2D, V11.2D, V8.2D
    SMINP  V9.16B, V2.16B, V17.16B
    UMINP  V0.4H, V2.4H, V14.4H
    UMAXP  V14.16B, V4.16B, V1.16B
    UMINP  V11.4S, V4.4S, V14.4S
    UMAXP  V22.8B, V2.8B, V2.8B
    FMINP S25, V27.2S
    FMAXNMP D12, V13.2D
    UMINP  V29.8H, V15.8H, V17.8H
    FMINNMP  V27.4S, V1.4S, V19.4S
    FMINP  V23.2S, V10.2S, V19.2S
    FMAXNMP D6, V23.2D
    ADDP  V20.4S, V27.4S, V16.4S
    SMINP  V21.16B, V12.16B, V27.16B
    FMINNMP D6, V17.2D
    FMAXP S30, V15.2S
    FMINP D30, V30.2D
    ADDP  V16.2D, V9.2D, V0.2D
    UMINP  V26.8B, V9.8B, V9.8B
    UMAXP  V9.2S, V31.2S, V26.2S
    FADDP S27, V21.2S
    FMAXNMP D17, V21.2D
    FADDP D17, V13.2D
    SMAXP  V9.2S, V7.2S, V16.2S
    FMAXP D14, V10.2D
    FADDP S14, V10.2S
    FMAXP D3, V5.2D
    FMAXP S29, V13.2S
    ADDP  D25, V23.2D
    SMAXP  V31.8B, V6.8B, V27.8B
    FADDP S20, V0.2S
    ADDP  D30, V9.2D
    FMINP S12, V25.2S
    UMINP  V15.8B, V26.8B, V8.8B
    UMAXP  V11.2S, V21.2S, V31.2S
    UMAXP  V2.8B, V3.8B, V17.8B
    ADDP  D28, V8.2D
    FMINNMP  V27.2S, V11.2S, V14.2S
    FMINP D7, V5.2D
    FMINP D12, V24.2D
    FADDP  V27.2D, V30.2D, V11.2D
    UMINP  V21.8H, V11.8H, V13.8H
    FMAXNMP  V16.2D, V12.2D, V25.2D
    FADDP D26, V13.2D
    FMINP  V9.2S, V10.2S, V15.2S
    FMINNMP S20, V22.2S
    FMAXNMP S8, V16.2S
    FMAXP D25, V28.2D
    ADDP  V14.16B, V19.16B, V17.16B
    UMAXP  V0.2S, V21.2S, V26.2S
    FMINP  V9.4S, V11.4S, V31.4S
    FMAXNMP S8, V4.2S
    FMAXP  V0.4S, V0.4S, V25.4S
    FMINP  V3.2D, V20.2D, V29.2D
    ADDP  V9.4S, V31.4S, V17.4S
    FMAXNMP S4, V28.2S
    FADDP S29, V23.2S
    FMINNMP D29, V13.2D
    FMAXNMP  V18.2S, V2.2S, V17.2S
    FMINNMP S29, V30.2S
    FMINNMP  V27.4S, V9.4S, V5.4S
    FMINNMP S10, V3.2S
    FADDP D16, V31.2D
    FMINP  V8.4S, V7.4S, V7.4S
    FADDP D19, V24.2D
    UMAXP  V29.4H, V8.4H, V6.4H
    FMINP D13, V21.2D
    FMINNMP D10, V6.2D
    FMINP S27, V27.2S
    UMINP  V24.4H, V17.4H, V11.4H
    FADDP  V3.2S, V12.2S, V25.2S
    UMINP  V7.8H, V6.8H, V20.8H
    FMINP  V16.4S, V0.4S, V18.4S
    FMINP D22, V6.2D
    SMINP  V30.8B, V25.8B, V20.8B
    UMINP  V5.4H, V1.4H, V29.4H
    FADDP S2, V3.2S
    FMAXNMP  V21.4S, V9.4S, V30.4S
    FMINNMP D15, V10.2D
    UMINP  V24.16B, V30.16B, V30.16B
    UMAXP  V11.4S, V21.4S, V17.4S
    UMAXP  V24.8B, V6.8B, V27.8B
    FMINNMP D17, V13.2D
    FMINP  V30.2S, V26.2S, V2.2S
    FMAXNMP D9, V12.2D
    UMAXP  V31.4H, V25.4H, V25.4H
    FADDP S27, V10.2S
    FMINP D12, V15.2D
    SMAXP  V26.2S, V8.2S, V16.2S
    FADDP S11, V20.2S
    SMAXP  V29.2S, V30.2S, V17.2S
    UMAXP  V18.8B, V16.8B, V3.8B
    SMAXP  V27.4S, V15.4S, V6.4S
    FMINNMP S29, V15.2S
    FADDP S2, V2.2S
    FADDP D4, V8.2D
    SMAXP  V6.4S, V10.4S, V31.4S
    FADDP D26, V30.2D
    FMAXNMP D5, V19.2D
    FMINP S6, V14.2S
    ADDP  V28.16B, V1.16B, V19.16B
    FMINNMP D21, V13.2D
    FMAXP S18, V27.2S
    FMAXNMP S1, V18.2S
    ADDP  V9.16B, V5.16B, V20.16B
    FMINNMP  V17.2S, V18.2S, V25.2S
    FMAXP D3, V19.2D
    FADDP D19, V10.2D
    ADDP  D5, V29.2D
    ADDP  D3, V11.2D
    FMAXNMP S25, V15.2S
    FMAXP  V8.2D, V23.2D, V4.2D
    SMINP  V25.2S, V9.2S, V26.2S
    FMAXNMP D4, V8.2D
    ADDP  D17, V14.2D
    ADDP  V4.16B, V7.16B, V28.16B
    ADDP  V29.16B, V8.16B, V6.16B
    FMINP  V4.4S, V21.4S, V17.4S
    FMINP  V25.2D, V1.2D, V4.2D
    UMAXP  V5.8H, V19.8H, V9.8H
    FMINNMP S16, V0.2S
    UMAXP  V3.8H, V16.8H, V26.8H
    UMINP  V9.4S, V15.4S, V17.4S
    SMINP  V11.4H, V5.4H, V31.4H
    FMAXP D25, V23.2D
    FMINP D27, V18.2D
    SMAXP  V8.4H, V2.4H, V6.4H
    FMINNMP D1, V15.2D
    FMINNMP D16, V25.2D
    FMINNMP  V1.4S, V6.4S, V31.4S
    FMAXP S29, V0.2S
    FMINNMP D19, V13.2D
    FMAXNMP D14, V21.2D
    FMAXNMP S21, V15.2S
    FMINP D4, V13.2D
    FADDP  V12.4S, V9.4S, V8.4S
    FMINP  V31.2D, V29.2D, V9.2D
    FMINNMP  V20.2S, V2.2S, V17.2S
    FMINNMP S17, V8.2S
    ADDP  V16.8B, V17.8B, V23.8B
    FMAXNMP S16, V21.2S
    FMAXP  V1.4S, V19.4S, V26.4S
    FMINNMP S7, V1.2S
    FMAXNMP D28, V7.2D
    FMINNMP D6, V23.2D
    FMAXNMP D24, V29.2D
    FMINP  V9.2D, V21.2D, V18.2D
    FMAXP S11, V15.2S
    FMAXP  V15.4S, V25.4S, V29.4S
    FMINNMP S13, V20.2S
    FMAXP S11, V21.2S
    FMAXP D23, V15.2D
    FADDP S13, V18.2S
    FMINP D9, V16.2D
    FMAXNMP S21, V31.2S
    UMAXP  V22.4S, V24.4S, V6.4S
    FMAXNMP  V15.2S, V27.2S, V16.2S
    FMAXP D6, V30.2D
    FMAXP  V26.4S, V13.4S, V19.4S
    FMINNMP S13, V28.2S
    SMINP  V0.2S, V23.2S, V0.2S
    FMAXNMP D14, V24.2D
    FMAXP  V7.2S, V26.2S, V7.2S
    FMAXNMP S0, V20.2S
    FMAXNMP  V27.2D, V29.2D, V11.2D
    FADDP  V2.2S, V23.2S, V7.2S
    UMAXP  V4.8B, V16.8B, V27.8B
    FMINNMP  V6.2D, V4.2D, V24.2D
    SMINP  V6.4S, V18.4S, V21.4S
    UMINP  V6.8H, V14.8H, V8.8H
    UMINP  V15.4H, V13.4H, V9.4H
    FMINP  V27.2S, V16.2S, V0.2S
    UMAXP  V25.4S, V23.4S, V13.4S
    SMAXP  V16.8B, V28.8B, V25.8B
    FADDP D17, V31.2D
    SMINP  V25.8H, V4.8H, V17.8H
    FADDP S20, V2.2S
    FMAXP  V18.4S, V18.4S, V23.4S
    FMINP D12, V22.2D
    SUBS  X13, X13, #0x1
    B.NE  TaishanSimdComplexP01_label_888
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X17, X15, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X11, X8, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X15, X22, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X29, X13, X5
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X9, X6, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X25, X19, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X13, X24, X13
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X14, X18, X14
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X16
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X5, X3, X19
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X11, X22, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X24, X9, X22
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X16, X21, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X25
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X2, X20, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X15, X18, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X3, V2.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X3, D2
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X5, V3.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X5, D3
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X18, D4
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x1, LSL #32
    SUB  X17, X25, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X20, D5
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X7, D6
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X5, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X5, D7
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X11, X24, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X18, D8
    MOVZ  X24, #0x1, LSL #0
    SUB  X11, X24, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X14, D9
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X6, D10
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X15, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X15, D11
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X8, D12
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X15, D13
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X21, V14.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X21, D14
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X22, V15.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X22, D15
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X28, D16
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X23, X13, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X29, D17
    MOVZ  X13, #0x0, LSL #0
    SUB  X23, X13, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X28, D18
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X26, D19
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X4, X5, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X12, D20
    MOVZ  X5, #0x0, LSL #0
    SUB  X4, X5, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X7, D21
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X11, D22
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X22, V23.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X22, D23
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X13, X22, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X23, D24
    MOVZ  X22, #0x0, LSL #0
    SUB  X13, X22, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X13, X7, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X8, D25
    MOVZ  X7, #0x0, LSL #0
    SUB  X13, X7, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X12, D26
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X7
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X7, D28
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X7
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X4, D29
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    MOVZ  X2, #0x646, LSL #0
    MOVK  X2, #0xaadb, LSL #16
    MOVK  X2, #0xfe6f, LSL #32
    MOVK  X2, #0xf90e, LSL #48
    MOVZ  X3, #0x15a, LSL #0
    MOVK  X3, #0x6e17, LSL #16
    MOVK  X3, #0xfb8f, LSL #32
    MOVK  X3, #0xb30c, LSL #48
    MOVZ  X4, #0x844, LSL #0
    MOVK  X4, #0x752e, LSL #16
    MOVK  X4, #0x4614, LSL #32
    MOVK  X4, #0xeda0, LSL #48
    MOVZ  X5, #0xd3e2, LSL #0
    MOVK  X5, #0xfb52, LSL #16
    MOVK  X5, #0x1ec6, LSL #32
    MOVK  X5, #0x1e83, LSL #48
    MOVZ  X6, #0x7eac, LSL #0
    MOVK  X6, #0xe34d, LSL #16
    MOVK  X6, #0xd360, LSL #32
    MOVK  X6, #0xbc60, LSL #48
    MOVZ  X7, #0x6865, LSL #0
    MOVK  X7, #0x859d, LSL #16
    MOVK  X7, #0xca4c, LSL #32
    MOVK  X7, #0x32ee, LSL #48
    MOVZ  X8, #0x1e19, LSL #0
    MOVK  X8, #0x1a1e, LSL #16
    MOVK  X8, #0x97e8, LSL #32
    MOVK  X8, #0xb87f, LSL #48
    MOVZ  X9, #0x6bd, LSL #0
    MOVK  X9, #0x7d5b, LSL #16
    MOVK  X9, #0x3a60, LSL #32
    MOVK  X9, #0xf91b, LSL #48
    MOVZ  X10, #0xa8bf, LSL #0
    MOVK  X10, #0xa39f, LSL #16
    MOVK  X10, #0xdce9, LSL #32
    MOVK  X10, #0x88e3, LSL #48
    MOVZ  X11, #0x83ff, LSL #0
    MOVK  X11, #0xd185, LSL #16
    MOVK  X11, #0x80dc, LSL #32
    MOVK  X11, #0x4c86, LSL #48
    MOVZ  X12, #0x6361, LSL #0
    MOVK  X12, #0x3c8, LSL #16
    MOVK  X12, #0x13df, LSL #32
    MOVK  X12, #0xf0ec, LSL #48
    MOVZ  X13, #0x8c1b, LSL #0
    MOVK  X13, #0x821f, LSL #16
    MOVK  X13, #0x6300, LSL #32
    MOVK  X13, #0xd948, LSL #48
    MOVZ  X14, #0x279, LSL #0
    MOVK  X14, #0x14bc, LSL #16
    MOVK  X14, #0x23a4, LSL #32
    MOVK  X14, #0xf5fc, LSL #48
    MOVZ  X15, #0xba53, LSL #0
    MOVK  X15, #0xdc8e, LSL #16
    MOVK  X15, #0x9938, LSL #32
    MOVK  X15, #0x468e, LSL #48
    MOVZ  X16, #0xa726, LSL #0
    MOVK  X16, #0x92e5, LSL #16
    MOVK  X16, #0x8f15, LSL #32
    MOVK  X16, #0x1691, LSL #48
    MOVZ  X17, #0xd0f9, LSL #0
    MOVK  X17, #0xd472, LSL #16
    MOVK  X17, #0x7156, LSL #32
    MOVK  X17, #0x772f, LSL #48
    MOVZ  X18, #0x1497, LSL #0
    MOVK  X18, #0x5015, LSL #16
    MOVK  X18, #0xb61b, LSL #32
    MOVK  X18, #0x5601, LSL #48
    MOVZ  X19, #0x91aa, LSL #0
    MOVK  X19, #0xf5a, LSL #16
    MOVK  X19, #0x832c, LSL #32
    MOVK  X19, #0x7c14, LSL #48
    MOVZ  X20, #0x6ab1, LSL #0
    MOVK  X20, #0x147f, LSL #16
    MOVK  X20, #0x561, LSL #32
    MOVK  X20, #0x6e6f, LSL #48
    MOVZ  X21, #0xe52c, LSL #0
    MOVK  X21, #0x68e7, LSL #16
    MOVK  X21, #0xf449, LSL #32
    MOVK  X21, #0x7c1c, LSL #48
    MOVZ  X22, #0x7b08, LSL #0
    MOVK  X22, #0x600b, LSL #16
    MOVK  X22, #0x4f72, LSL #32
    MOVK  X22, #0x57d5, LSL #48
    MOVZ  X23, #0xea8b, LSL #0
    MOVK  X23, #0x8b15, LSL #16
    MOVK  X23, #0xe135, LSL #32
    MOVK  X23, #0xaa2b, LSL #48
    MOVZ  X24, #0xb4a9, LSL #0
    MOVK  X24, #0xcf6a, LSL #16
    MOVK  X24, #0xa39c, LSL #32
    MOVK  X24, #0xc74c, LSL #48
    MOVZ  X25, #0x6d9b, LSL #0
    MOVK  X25, #0xbeda, LSL #16
    MOVK  X25, #0x3ee4, LSL #32
    MOVK  X25, #0x4382, LSL #48
    MOVZ  X26, #0xf033, LSL #0
    MOVK  X26, #0x4679, LSL #16
    MOVK  X26, #0xa7bb, LSL #32
    MOVK  X26, #0x6e3e, LSL #48
    MOVZ  X28, #0x396c, LSL #0
    MOVK  X28, #0x496a, LSL #16
    MOVK  X28, #0xce8e, LSL #32
    MOVK  X28, #0xe53a, LSL #48
    MOVZ  X29, #0x38b3, LSL #0
    MOVK  X29, #0xbe4c, LSL #16
    MOVK  X29, #0xbf5, LSL #32
    MOVK  X29, #0x3538, LSL #48
    FMOV  D0, X18
    FMOV  V0.D[1], X24
    FMOV  D1, X17
    FMOV  V1.D[1], X4
    FMOV  D2, X10
    FMOV  V2.D[1], X26
    FMOV  D3, X10
    FMOV  V3.D[1], X16
    FMOV  D4, X3
    FMOV  V4.D[1], X25
    FMOV  D5, X7
    FMOV  V5.D[1], X24
    FMOV  D6, X29
    FMOV  V6.D[1], X24
    FMOV  D7, X29
    FMOV  V7.D[1], X8
    FMOV  D8, X18
    FMOV  V8.D[1], X8
    FMOV  D9, X10
    FMOV  V9.D[1], X5
    FMOV  D10, X13
    FMOV  V10.D[1], X2
    FMOV  D11, X26
    FMOV  V11.D[1], X2
    FMOV  D12, X17
    FMOV  V12.D[1], X24
    FMOV  D13, X8
    FMOV  V13.D[1], X20
    FMOV  D14, X15
    FMOV  V14.D[1], X18
    FMOV  D15, X13
    FMOV  V15.D[1], X26
    FMOV  D16, X14
    FMOV  V16.D[1], X3
    FMOV  D17, X2
    FMOV  V17.D[1], X2
    FMOV  D18, X10
    FMOV  V18.D[1], X20
    FMOV  D19, X12
    FMOV  V19.D[1], X5
    FMOV  D20, X25
    FMOV  V20.D[1], X29
    FMOV  D21, X22
    FMOV  V21.D[1], X14
    FMOV  D22, X24
    FMOV  V22.D[1], X22
    FMOV  D23, X3
    FMOV  V23.D[1], X18
    FMOV  D24, X29
    FMOV  V24.D[1], X6
    FMOV  D25, X22
    FMOV  V25.D[1], X2
    FMOV  D26, X4
    FMOV  V26.D[1], X14
    FMOV  D27, X24
    FMOV  V27.D[1], X20
    FMOV  D28, X10
    FMOV  V28.D[1], X25
    FMOV  D29, X19
    FMOV  V29.D[1], X4
    FMOV  D30, X7
    FMOV  V30.D[1], X15
    FMOV  D31, X25
    FMOV  V31.D[1], X28
    MOVZ  X7, #0xa, LSL #0
TaishanSimdComplexP01_label_968:
    FADDP  V18.4S, V29.4S, V16.4S
    ADDP  D18, V25.2D
    FADDP D25, V17.2D
    FADDP  V3.4S, V27.4S, V25.4S
    FADDP D18, V10.2D
    FMINP D11, V4.2D
    FADDP D10, V18.2D
    FMINP  V31.4S, V11.4S, V7.4S
    FMAXP  V13.4S, V18.4S, V15.4S
    FMINNMP  V26.2D, V19.2D, V28.2D
    FMAXNMP S7, V6.2S
    FMINNMP  V18.4S, V27.4S, V23.4S
    FADDP D3, V15.2D
    FMINNMP D13, V9.2D
    SMINP  V30.4S, V24.4S, V25.4S
    FMINNMP  V6.4S, V8.4S, V10.4S
    UMINP  V17.2S, V31.2S, V13.2S
    FMINP  V14.4S, V17.4S, V29.4S
    SMINP  V7.2S, V23.2S, V9.2S
    FMINNMP S29, V25.2S
    FMINNMP  V19.2D, V26.2D, V31.2D
    UMINP  V11.4H, V15.4H, V27.4H
    ADDP  D29, V3.2D
    ADDP  D15, V5.2D
    FADDP D5, V24.2D
    UMINP  V18.16B, V31.16B, V2.16B
    FMINP S23, V30.2S
    SMINP  V26.2S, V21.2S, V21.2S
    FMAXNMP S5, V23.2S
    SMINP  V11.8H, V11.8H, V23.8H
    ADDP  V18.2D, V18.2D, V9.2D
    UMAXP  V25.16B, V31.16B, V21.16B
    FMAXNMP S22, V11.2S
    FADDP  V17.2D, V23.2D, V8.2D
    FMINP D10, V21.2D
    FMINP  V5.2D, V25.2D, V26.2D
    UMAXP  V14.8B, V8.8B, V17.8B
    UMINP  V8.4S, V11.4S, V27.4S
    FMAXNMP S11, V17.2S
    ADDP  D7, V30.2D
    SMINP  V31.8B, V18.8B, V14.8B
    FMINP  V2.4S, V24.4S, V14.4S
    FMINP D23, V16.2D
    FADDP D8, V6.2D
    FMINNMP D26, V9.2D
    FMINP D25, V30.2D
    SMAXP  V11.2S, V21.2S, V26.2S
    FMINP  V25.4S, V25.4S, V13.4S
    FADDP  V17.2S, V23.2S, V19.2S
    FADDP S31, V23.2S
    FADDP S28, V10.2S
    FMAXNMP  V17.2S, V3.2S, V4.2S
    ADDP  D17, V9.2D
    FADDP D26, V9.2D
    FMINNMP  V10.2D, V27.2D, V15.2D
    UMINP  V8.4H, V26.4H, V15.4H
    FMINP S5, V1.2S
    FMAXP D17, V20.2D
    ADDP  D18, V8.2D
    FMINP S4, V5.2S
    FMAXNMP D4, V28.2D
    SMAXP  V9.8H, V19.8H, V26.8H
    SMINP  V19.8H, V30.8H, V12.8H
    UMINP  V6.4S, V30.4S, V29.4S
    SMINP  V1.4S, V1.4S, V30.4S
    FMINNMP D12, V22.2D
    FMINNMP D31, V29.2D
    FMINP  V2.2S, V4.2S, V10.2S
    FMINNMP D9, V12.2D
    FMAXP  V8.2D, V17.2D, V29.2D
    ADDP  D19, V7.2D
    SMINP  V9.4S, V4.4S, V28.4S
    SMAXP  V29.16B, V6.16B, V6.16B
    FMAXP S3, V16.2S
    FMAXP  V22.4S, V7.4S, V12.4S
    SMAXP  V12.8B, V25.8B, V26.8B
    ADDP  V14.4H, V5.4H, V2.4H
    FMAXP D8, V6.2D
    FMAXP D13, V6.2D
    FMINP S12, V11.2S
    SMINP  V16.8B, V28.8B, V13.8B
    FMINNMP S4, V15.2S
    FMAXP D7, V30.2D
    FMINP S11, V24.2S
    FADDP D28, V0.2D
    FMINP  V5.2D, V31.2D, V3.2D
    ADDP  V0.4H, V24.4H, V29.4H
    FMINNMP S14, V14.2S
    FADDP D19, V1.2D
    UMINP  V24.4H, V19.4H, V20.4H
    FMINP S1, V31.2S
    FADDP S1, V6.2S
    FADDP  V16.2D, V31.2D, V8.2D
    SMAXP  V26.8B, V10.8B, V11.8B
    FMAXP  V15.2D, V29.2D, V4.2D
    ADDP  D13, V15.2D
    FMAXP  V11.4S, V9.4S, V13.4S
    UMAXP  V3.8H, V5.8H, V7.8H
    FADDP D30, V19.2D
    FADDP S3, V19.2S
    FMAXP D13, V19.2D
    FMAXNMP D9, V24.2D
    FADDP D30, V4.2D
    FMINP  V3.4S, V24.4S, V27.4S
    FMAXNMP  V30.2S, V21.2S, V6.2S
    ADDP  D27, V5.2D
    ADDP  D5, V27.2D
    UMINP  V22.8H, V11.8H, V24.8H
    FMAXNMP  V13.2S, V23.2S, V19.2S
    UMINP  V27.8H, V18.8H, V20.8H
    FMINNMP  V2.4S, V17.4S, V8.4S
    SMINP  V1.16B, V12.16B, V16.16B
    FMAXP D23, V15.2D
    SMINP  V18.4S, V15.4S, V15.4S
    FADDP S22, V27.2S
    FMAXNMP S21, V26.2S
    FMAXNMP S0, V4.2S
    UMAXP  V29.2S, V21.2S, V24.2S
    FMAXP  V13.2S, V2.2S, V31.2S
    FMAXNMP  V8.2D, V0.2D, V25.2D
    FMAXNMP  V21.4S, V27.4S, V9.4S
    FMAXNMP D22, V5.2D
    UMAXP  V1.8B, V8.8B, V3.8B
    FMAXP  V5.2D, V31.2D, V24.2D
    SMINP  V31.4S, V23.4S, V25.4S
    FMINNMP S9, V18.2S
    FMINP S8, V31.2S
    FMAXP D21, V29.2D
    FMINP S22, V17.2S
    FMINP S29, V16.2S
    FMINP D11, V7.2D
    FMAXNMP  V31.2D, V2.2D, V8.2D
    UMAXP  V6.4S, V13.4S, V6.4S
    ADDP  D31, V10.2D
    FADDP D30, V27.2D
    FMAXP  V31.2S, V28.2S, V17.2S
    FADDP D17, V19.2D
    SMINP  V10.4H, V29.4H, V29.4H
    FMINP D1, V31.2D
    FMAXP S21, V3.2S
    FMAXP S2, V22.2S
    FMINNMP S9, V5.2S
    FMINNMP D25, V1.2D
    UMAXP  V13.8B, V1.8B, V7.8B
    FMAXNMP S27, V25.2S
    FMINNMP S13, V10.2S
    FMAXNMP S7, V10.2S
    FMINP  V9.2D, V16.2D, V9.2D
    ADDP  V11.4S, V25.4S, V16.4S
    ADDP  V10.2D, V29.2D, V12.2D
    UMINP  V8.8B, V10.8B, V21.8B
    FADDP  V5.4S, V22.4S, V11.4S
    FMAXP S24, V19.2S
    FMAXNMP S8, V22.2S
    FMINNMP S13, V27.2S
    FMAXNMP D30, V5.2D
    UMINP  V1.4H, V2.4H, V1.4H
    FMINNMP D7, V19.2D
    FMINP S8, V17.2S
    FADDP S30, V20.2S
    SMINP  V27.8H, V28.8H, V17.8H
    FMINP S22, V27.2S
    ADDP  D25, V7.2D
    FMINNMP D4, V7.2D
    FMAXNMP  V4.2D, V27.2D, V24.2D
    ADDP  D28, V30.2D
    FMINNMP S17, V4.2S
    FMAXNMP  V27.4S, V1.4S, V17.4S
    ADDP  V24.2D, V16.2D, V27.2D
    FMINNMP D7, V7.2D
    SMINP  V16.16B, V25.16B, V2.16B
    UMINP  V11.4H, V18.4H, V22.4H
    FMAXNMP D30, V0.2D
    SMAXP  V20.16B, V30.16B, V29.16B
    FADDP D19, V24.2D
    FMAXP D21, V8.2D
    FMAXNMP  V22.2S, V20.2S, V25.2S
    FMINP S13, V18.2S
    FMAXP  V7.4S, V25.4S, V16.4S
    FMINP D31, V13.2D
    FMAXP S26, V31.2S
    FMINNMP S8, V28.2S
    FMINNMP D28, V26.2D
    UMINP  V22.4S, V30.4S, V30.4S
    FMINP  V16.4S, V1.4S, V18.4S
    FADDP S10, V3.2S
    UMAXP  V8.8B, V11.8B, V5.8B
    SMINP  V31.16B, V10.16B, V12.16B
    FMINNMP  V28.2S, V4.2S, V6.2S
    SMAXP  V28.4S, V9.4S, V16.4S
    FMAXP S30, V19.2S
    FADDP S22, V1.2S
    FADDP D8, V25.2D
    FMINNMP D4, V7.2D
    ADDP  D28, V2.2D
    UMINP  V27.8B, V0.8B, V8.8B
    FMAXNMP  V26.2D, V28.2D, V5.2D
    UMINP  V17.2S, V15.2S, V21.2S
    FMINP D18, V13.2D
    ADDP  V4.8B, V3.8B, V10.8B
    SUBS  X7, X7, #0x1
    B.NE  TaishanSimdComplexP01_label_968
    MOVZ  X2, #0x646, LSL #0
    MOVK  X2, #0xaadb, LSL #16
    MOVK  X2, #0xfe6f, LSL #32
    MOVK  X2, #0xf90e, LSL #48
    SUB  X12, X2, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    MOVZ  X15, #0x15a, LSL #0
    MOVK  X15, #0x6e17, LSL #16
    MOVK  X15, #0xfb8f, LSL #32
    MOVK  X15, #0xb30c, LSL #48
    SUB  X7, X15, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    MOVZ  X21, #0x844, LSL #0
    MOVK  X21, #0x752e, LSL #16
    MOVK  X21, #0x4614, LSL #32
    MOVK  X21, #0xeda0, LSL #48
    SUB  X10, X21, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    MOVZ  X4, #0xd3e2, LSL #0
    MOVK  X4, #0xfb52, LSL #16
    MOVK  X4, #0x1ec6, LSL #32
    MOVK  X4, #0x1e83, LSL #48
    SUB  X17, X4, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    MOVZ  X14, #0x7eac, LSL #0
    MOVK  X14, #0xe34d, LSL #16
    MOVK  X14, #0xd360, LSL #32
    MOVK  X14, #0xbc60, LSL #48
    SUB  X20, X14, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X19, X7, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    MOVZ  X6, #0x1e19, LSL #0
    MOVK  X6, #0x1a1e, LSL #16
    MOVK  X6, #0x97e8, LSL #32
    MOVK  X6, #0xb87f, LSL #48
    SUB  X16, X6, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0x6bd, LSL #0
    MOVK  X16, #0x7d5b, LSL #16
    MOVK  X16, #0x3a60, LSL #32
    MOVK  X16, #0xf91b, LSL #48
    SUB  X13, X16, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X2, X29, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X13
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    MOVZ  X21, #0x7eac, LSL #0
    MOVK  X21, #0xe34d, LSL #16
    MOVK  X21, #0xd360, LSL #32
    MOVK  X21, #0xbc60, LSL #48
    SUB  X29, X21, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    MOVZ  X23, #0x15a, LSL #0
    MOVK  X23, #0x6e17, LSL #16
    MOVK  X23, #0xfb8f, LSL #32
    MOVK  X23, #0xb30c, LSL #48
    SUB  X3, X23, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    MOVZ  X8, #0x6bd, LSL #0
    MOVK  X8, #0x7d5b, LSL #16
    MOVK  X8, #0x3a60, LSL #32
    MOVK  X8, #0xf91b, LSL #48
    SUB  X4, X8, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X17
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X4, X8, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    MOVZ  X13, #0x7eac, LSL #0
    MOVK  X13, #0xe34d, LSL #16
    MOVK  X13, #0xd360, LSL #32
    MOVK  X13, #0xbc60, LSL #48
    SUB  X25, X13, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    MOVZ  X26, #0x15a, LSL #0
    MOVK  X26, #0x6e17, LSL #16
    MOVK  X26, #0xfb8f, LSL #32
    MOVK  X26, #0xb30c, LSL #48
    SUB  X16, X26, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    MOVZ  X10, #0xb4a9, LSL #0
    MOVK  X10, #0xcf6a, LSL #16
    MOVK  X10, #0xa39c, LSL #32
    MOVK  X10, #0xc74c, LSL #48
    SUB  X15, X10, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    MOVZ  X15, #0x15a, LSL #0
    MOVK  X15, #0x6e17, LSL #16
    MOVK  X15, #0xfb8f, LSL #32
    MOVK  X15, #0xb30c, LSL #48
    SUB  X28, X15, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X9, X24, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X9, D2
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X5, V3.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X5
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X5, D3
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X5
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X25, X22, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X28, D4
    MOVZ  X22, #0x0, LSL #0
    SUB  X25, X22, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X16, D5
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X26, D6
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X14, X15, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X26, D7
    MOVZ  X15, #0x0, LSL #0
    SUB  X14, X15, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X6, X18, X3
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X3, D8
    MOVZ  X18, #0x0, LSL #0
    SUB  X6, X18, X3
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X28, V9.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X28, D9
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X2, D10
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X21, X12, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X14, D11
    MOVZ  X12, #0x0, LSL #0
    SUB  X21, X12, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X25, X29, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X2, D12
    MOVZ  X29, #0x0, LSL #0
    SUB  X25, X29, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X20, X15, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X8, D13
    MOVZ  X15, #0x0, LSL #0
    SUB  X20, X15, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X23, D14
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X4, D15
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X15, D16
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X2, D17
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X7, D18
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X6, D19
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X23, D20
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X25, V21.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X25, D21
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X28, D22
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X24, D23
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X28, D24
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X19, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X19, D25
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X2, D26
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X17, V28.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X17, D28
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X24, D29
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
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
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X10
    FMOV  V0.D[1], X18
    FMOV  D1, X16
    FMOV  V1.D[1], X22
    FMOV  D2, X18
    FMOV  V2.D[1], X15
    FMOV  D3, X22
    FMOV  V3.D[1], X11
    FMOV  D4, X11
    FMOV  V4.D[1], X6
    FMOV  D5, X28
    FMOV  V5.D[1], X29
    FMOV  D6, X2
    FMOV  V6.D[1], X9
    FMOV  D7, X10
    FMOV  V7.D[1], X7
    FMOV  D8, X16
    FMOV  V8.D[1], X12
    FMOV  D9, X13
    FMOV  V9.D[1], X21
    FMOV  D10, X20
    FMOV  V10.D[1], X7
    FMOV  D11, X8
    FMOV  V11.D[1], X17
    FMOV  D12, X8
    FMOV  V12.D[1], X24
    FMOV  D13, X9
    FMOV  V13.D[1], X5
    FMOV  D14, X19
    FMOV  V14.D[1], X5
    FMOV  D15, X12
    FMOV  V15.D[1], X29
    FMOV  D16, X14
    FMOV  V16.D[1], X22
    FMOV  D17, X28
    FMOV  V17.D[1], X7
    FMOV  D18, X5
    FMOV  V18.D[1], X7
    FMOV  D19, X28
    FMOV  V19.D[1], X19
    FMOV  D20, X22
    FMOV  V20.D[1], X14
    FMOV  D21, X19
    FMOV  V21.D[1], X3
    FMOV  D22, X12
    FMOV  V22.D[1], X20
    FMOV  D23, X3
    FMOV  V23.D[1], X19
    FMOV  D24, X8
    FMOV  V24.D[1], X8
    FMOV  D25, X2
    FMOV  V25.D[1], X14
    FMOV  D26, X18
    FMOV  V26.D[1], X8
    FMOV  D27, X26
    FMOV  V27.D[1], X15
    FMOV  D28, X29
    FMOV  V28.D[1], X14
    FMOV  D29, X24
    FMOV  V29.D[1], X3
    FMOV  D30, X22
    FMOV  V30.D[1], X5
    FMOV  D31, X18
    FMOV  V31.D[1], X29
    MOVZ  X28, #0xa, LSL #0
TaishanSimdComplexP01_label_1046:
    ADDP  D7, V10.2D
    UMINP  V24.2S, V12.2S, V12.2S
    FMINP S3, V18.2S
    FMINP  V29.2S, V3.2S, V11.2S
    ADDP  D26, V13.2D
    FMINNMP S10, V25.2S
    FMAXNMP  V23.2D, V21.2D, V18.2D
    FMAXNMP D31, V20.2D
    FMINP  V0.4S, V12.4S, V28.4S
    FMINNMP S18, V2.2S
    FADDP D17, V20.2D
    FADDP  V24.2D, V25.2D, V5.2D
    FMAXNMP D7, V28.2D
    SMINP  V22.8B, V10.8B, V10.8B
    SMAXP  V23.4H, V11.4H, V16.4H
    FMAXP D1, V21.2D
    FMAXP  V17.2S, V17.2S, V26.2S
    FMAXNMP S22, V21.2S
    FMINP S19, V0.2S
    FADDP  V7.4S, V29.4S, V7.4S
    FMINP S30, V29.2S
    FMINP  V4.2D, V24.2D, V31.2D
    FMAXNMP S21, V22.2S
    FMAXNMP S1, V7.2S
    FADDP D15, V18.2D
    FMAXNMP  V16.4S, V4.4S, V15.4S
    FMAXP S12, V5.2S
    UMAXP  V24.2S, V12.2S, V25.2S
    ADDP  V3.8H, V18.8H, V9.8H
    SMAXP  V21.2S, V27.2S, V18.2S
    ADDP  V21.8B, V1.8B, V27.8B
    FMINP D26, V14.2D
    ADDP  D10, V13.2D
    FMAXNMP  V20.2S, V8.2S, V5.2S
    FMINP  V22.2S, V14.2S, V19.2S
    SMAXP  V2.16B, V6.16B, V13.16B
    FMAXNMP  V3.2D, V3.2D, V19.2D
    FMINP S19, V20.2S
    FADDP S7, V28.2S
    FMINNMP  V13.2S, V21.2S, V27.2S
    FMINNMP S8, V8.2S
    FMAXNMP  V19.4S, V20.4S, V7.4S
    FADDP  V19.4S, V22.4S, V24.4S
    FMAXNMP D5, V19.2D
    FMAXNMP D0, V18.2D
    FMAXNMP  V20.2D, V10.2D, V31.2D
    FMAXP  V31.2D, V26.2D, V0.2D
    FMAXP D28, V3.2D
    FMINP S31, V30.2S
    ADDP  V18.4S, V21.4S, V8.4S
    UMINP  V5.8B, V2.8B, V31.8B
    FMAXNMP D7, V28.2D
    FMAXP S12, V16.2S
    ADDP  V8.2D, V17.2D, V13.2D
    FMINNMP  V24.2D, V20.2D, V2.2D
    ADDP  V16.16B, V13.16B, V18.16B
    FMAXP S7, V16.2S
    FADDP S26, V15.2S
    FMINNMP D12, V2.2D
    FMINNMP S17, V15.2S
    FMINNMP D1, V2.2D
    ADDP  D0, V8.2D
    FMAXNMP S10, V17.2S
    FMAXP  V31.2D, V27.2D, V10.2D
    FMAXNMP S14, V27.2S
    FMAXP D10, V15.2D
    FADDP D11, V15.2D
    FMINP S23, V30.2S
    FMINP S2, V26.2S
    SMAXP  V29.8B, V9.8B, V31.8B
    FMINP D23, V14.2D
    FMINP D20, V11.2D
    FADDP  V5.4S, V10.4S, V30.4S
    FMAXP S24, V13.2S
    FMAXP D21, V16.2D
    FMINNMP  V22.2S, V28.2S, V26.2S
    FMAXP  V24.2D, V10.2D, V17.2D
    FMINNMP  V9.2S, V27.2S, V0.2S
    FMAXNMP S8, V31.2S
    FMAXNMP S1, V17.2S
    FMAXP S4, V12.2S
    SMINP  V31.8B, V21.8B, V1.8B
    FMAXNMP  V20.2D, V28.2D, V17.2D
    FMINP S31, V17.2S
    ADDP  V1.8B, V29.8B, V20.8B
    FMAXP S9, V26.2S
    FMINNMP D13, V25.2D
    FMINNMP S16, V14.2S
    UMAXP  V3.2S, V18.2S, V12.2S
    FADDP S8, V31.2S
    UMAXP  V2.16B, V23.16B, V0.16B
    SMINP  V13.4H, V11.4H, V21.4H
    UMAXP  V27.4S, V14.4S, V4.4S
    FMINNMP  V27.2S, V25.2S, V17.2S
    FMINP  V6.2D, V28.2D, V29.2D
    FMAXNMP S12, V1.2S
    FADDP S9, V22.2S
    FMINNMP D13, V11.2D
    ADDP  D4, V13.2D
    FADDP  V18.4S, V6.4S, V24.4S
    FMAXNMP  V6.2S, V20.2S, V8.2S
    FADDP  V6.2D, V0.2D, V5.2D
    FMINNMP S13, V26.2S
    FMAXP  V26.4S, V28.4S, V10.4S
    FMINP  V22.2D, V21.2D, V16.2D
    FMINP  V19.4S, V16.4S, V26.4S
    FADDP D2, V5.2D
    FADDP S31, V27.2S
    FADDP S26, V18.2S
    FADDP  V14.2D, V1.2D, V25.2D
    FMINNMP S22, V11.2S
    FMAXNMP D14, V1.2D
    ADDP  V1.4S, V0.4S, V12.4S
    FMINP S10, V11.2S
    FMINNMP D22, V27.2D
    SMINP  V19.8B, V0.8B, V23.8B
    FMAXNMP  V22.2D, V4.2D, V5.2D
    UMINP  V10.2S, V13.2S, V21.2S
    FMAXNMP S20, V3.2S
    FADDP S8, V12.2S
    SMAXP  V8.4S, V14.4S, V27.4S
    FMINNMP D27, V16.2D
    FMINP  V0.2S, V12.2S, V22.2S
    FMAXNMP  V12.2D, V17.2D, V11.2D
    FMINP D26, V12.2D
    FMAXP S26, V1.2S
    UMINP  V14.8H, V20.8H, V29.8H
    FMINP D9, V0.2D
    FMINP  V21.2D, V29.2D, V21.2D
    UMINP  V0.4H, V25.4H, V1.4H
    FADDP D15, V9.2D
    FMAXNMP  V9.2D, V1.2D, V3.2D
    FMAXP  V19.2S, V19.2S, V11.2S
    UMINP  V11.16B, V10.16B, V22.16B
    FADDP  V11.4S, V28.4S, V6.4S
    FMAXNMP S1, V16.2S
    FMAXP S17, V9.2S
    FMINP  V13.2S, V14.2S, V15.2S
    ADDP  D23, V14.2D
    ADDP  D11, V28.2D
    ADDP  V21.8H, V8.8H, V14.8H
    FMAXP D12, V17.2D
    ADDP  D13, V15.2D
    FMINNMP  V12.2S, V25.2S, V5.2S
    FMAXNMP D11, V16.2D
    FMAXNMP D17, V16.2D
    FADDP D12, V30.2D
    UMINP  V23.8H, V6.8H, V23.8H
    SMAXP  V3.2S, V14.2S, V1.2S
    FMINNMP S19, V9.2S
    FMINP  V21.2S, V26.2S, V26.2S
    FMINP S18, V16.2S
    FMINP  V13.2D, V21.2D, V24.2D
    FMAXP S14, V25.2S
    FMAXP  V11.4S, V14.4S, V14.4S
    FADDP D5, V13.2D
    FMINNMP D27, V17.2D
    UMINP  V24.2S, V5.2S, V6.2S
    FMINNMP  V3.4S, V6.4S, V19.4S
    UMAXP  V0.2S, V15.2S, V31.2S
    FMINP S26, V5.2S
    SMAXP  V12.4S, V11.4S, V16.4S
    FMAXP S10, V17.2S
    FMAXP D18, V23.2D
    FMAXNMP D21, V22.2D
    FMAXNMP D16, V14.2D
    FMAXP S30, V4.2S
    FMINNMP D5, V12.2D
    FADDP S3, V25.2S
    SMAXP  V11.16B, V5.16B, V22.16B
    UMINP  V3.4H, V12.4H, V19.4H
    FMINNMP  V6.4S, V4.4S, V12.4S
    FMINNMP S29, V11.2S
    FMAXNMP S26, V22.2S
    FMAXP S15, V10.2S
    SMAXP  V7.2S, V6.2S, V1.2S
    UMINP  V19.2S, V6.2S, V29.2S
    FMINP  V0.2D, V1.2D, V1.2D
    ADDP  D15, V8.2D
    FMINNMP  V21.2S, V18.2S, V19.2S
    FMAXP S13, V2.2S
    FMAXNMP D8, V7.2D
    FMAXP D12, V24.2D
    FMINP S26, V15.2S
    FMAXP D20, V25.2D
    SMINP  V14.16B, V30.16B, V4.16B
    FMAXNMP S15, V17.2S
    FMAXNMP D26, V15.2D
    FMAXP S30, V5.2S
    SMAXP  V14.2S, V4.2S, V0.2S
    FADDP  V10.2S, V13.2S, V3.2S
    FMAXP D6, V23.2D
    FMAXNMP S0, V11.2S
    SMINP  V10.8H, V24.8H, V21.8H
    FMINNMP  V21.4S, V10.4S, V2.4S
    FMINP  V26.2S, V13.2S, V9.2S
    UMINP  V17.8H, V19.8H, V13.8H
    UMINP  V15.4H, V20.4H, V1.4H
    FMINP D4, V9.2D
    FMAXP  V29.2S, V4.2S, V11.2S
    SUBS  X28, X28, #0x1
    B.NE  TaishanSimdComplexP01_label_1046
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X24, X2, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X26, X16, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X4, X8, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X24, X22, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X21, X20, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X19, X7, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X17, X6, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X26
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X26, D2
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X26
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X5, X17, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X2, D3
    MOVZ  X17, #0x0, LSL #0
    SUB  X5, X17, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X15, V4.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X15, D4
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X10, D5
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X5, V6.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X5, D6
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X25, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X25, D7
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X18, D8
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X13, D9
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X22, V10.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X3, X18, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X22, D10
    MOVZ  X18, #0x0, LSL #0
    SUB  X3, X18, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X13, D11
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X17, X20, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X18, D12
    MOVZ  X20, #0x0, LSL #0
    SUB  X17, X20, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X2, D13
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X29, D14
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X8, D15
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X8, X9, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X23, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X8, X9, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X28, D17
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X11, D18
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X13, X7, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X28, D19
    MOVZ  X7, #0x0, LSL #0
    SUB  X13, X7, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X18, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X10, X28, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X18, D20
    MOVZ  X28, #0x0, LSL #0
    SUB  X10, X28, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X15, D21
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X8, D22
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X28, D23
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X3, D24
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X17, D25
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X29, D26
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X21, X17, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X3, D28
    MOVZ  X17, #0x0, LSL #0
    SUB  X21, X17, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X25, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X12, X24, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X25, D29
    MOVZ  X24, #0x0, LSL #0
    SUB  X12, X24, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
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
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X16
    FMOV  D1, X29
    FMOV  V1.D[1], X19
    FMOV  D2, X10
    FMOV  V2.D[1], X18
    FMOV  D3, X21
    FMOV  V3.D[1], X22
    FMOV  D4, X19
    FMOV  V4.D[1], X22
    FMOV  D5, X28
    FMOV  V5.D[1], X25
    FMOV  D6, X15
    FMOV  V6.D[1], X3
    FMOV  D7, X25
    FMOV  V7.D[1], X13
    FMOV  D8, X12
    FMOV  V8.D[1], X20
    FMOV  D9, X24
    FMOV  V9.D[1], X23
    FMOV  D10, X22
    FMOV  V10.D[1], X14
    FMOV  D11, X15
    FMOV  V11.D[1], X14
    FMOV  D12, X24
    FMOV  V12.D[1], X2
    FMOV  D13, X10
    FMOV  V13.D[1], X13
    FMOV  D14, X8
    FMOV  V14.D[1], X8
    FMOV  D15, X6
    FMOV  V15.D[1], X13
    FMOV  D16, X21
    FMOV  V16.D[1], X26
    FMOV  D17, X21
    FMOV  V17.D[1], X26
    FMOV  D18, X14
    FMOV  V18.D[1], X19
    FMOV  D19, X19
    FMOV  V19.D[1], X24
    FMOV  D20, X6
    FMOV  V20.D[1], X9
    FMOV  D21, X21
    FMOV  V21.D[1], X21
    FMOV  D22, X13
    FMOV  V22.D[1], X12
    FMOV  D23, X5
    FMOV  V23.D[1], X12
    FMOV  D24, X24
    FMOV  V24.D[1], X7
    FMOV  D25, X12
    FMOV  V25.D[1], X21
    FMOV  D26, X20
    FMOV  V26.D[1], X3
    FMOV  D27, X10
    FMOV  V27.D[1], X25
    FMOV  D28, X9
    FMOV  V28.D[1], X26
    FMOV  D29, X13
    FMOV  V29.D[1], X2
    FMOV  D30, X28
    FMOV  V30.D[1], X15
    FMOV  D31, X28
    FMOV  V31.D[1], X28
    MOVZ  X16, #0xf, LSL #0
TaishanSimdComplexP01_label_1125:
    FMINP D20, V9.2D
    FADDP S26, V15.2S
    UMINP  V31.2S, V7.2S, V2.2S
    FMAXNMP S9, V31.2S
    FMAXP  V19.2D, V12.2D, V20.2D
    FMINNMP  V3.4S, V2.4S, V0.4S
    FMAXP  V14.2S, V16.2S, V19.2S
    FMAXNMP S14, V2.2S
    FMINP  V3.2S, V28.2S, V28.2S
    ADDP  D12, V15.2D
    FMINP S15, V29.2S
    FADDP S25, V31.2S
    FMINP  V31.4S, V27.4S, V25.4S
    FMINNMP  V15.2D, V24.2D, V14.2D
    ADDP  V29.2S, V10.2S, V11.2S
    FMINNMP D27, V9.2D
    FMINP S28, V5.2S
    FMINNMP S20, V2.2S
    FMINP  V23.2S, V9.2S, V1.2S
    UMINP  V1.8B, V28.8B, V29.8B
    UMAXP  V20.4H, V14.4H, V9.4H
    FADDP  V25.4S, V12.4S, V17.4S
    FMAXNMP S25, V25.2S
    FADDP S19, V25.2S
    FMAXP S16, V14.2S
    FMAXP  V14.2S, V12.2S, V24.2S
    FMAXP S11, V22.2S
    FADDP  V0.4S, V11.4S, V18.4S
    FMINNMP S8, V5.2S
    ADDP  D7, V31.2D
    FMAXNMP  V29.4S, V26.4S, V14.4S
    UMINP  V27.16B, V9.16B, V16.16B
    FMAXP  V26.4S, V22.4S, V2.4S
    FMINNMP D31, V19.2D
    FMINNMP S30, V3.2S
    FADDP  V8.4S, V23.4S, V7.4S
    ADDP  D23, V7.2D
    FMAXNMP D3, V10.2D
    FMINP S24, V15.2S
    FMAXP  V14.2S, V14.2S, V28.2S
    SMAXP  V28.16B, V1.16B, V27.16B
    FMAXNMP D9, V30.2D
    FADDP  V14.4S, V19.4S, V12.4S
    FMINP S29, V8.2S
    FMINP D2, V14.2D
    UMINP  V27.16B, V22.16B, V9.16B
    ADDP  V8.2D, V6.2D, V9.2D
    ADDP  V25.8B, V2.8B, V18.8B
    FMINP D0, V30.2D
    SMINP  V27.8H, V15.8H, V25.8H
    UMAXP  V19.4H, V30.4H, V21.4H
    FMAXP D26, V10.2D
    FMAXNMP S5, V0.2S
    FMAXP  V9.4S, V23.4S, V13.4S
    UMAXP  V14.4H, V19.4H, V28.4H
    ADDP  D13, V9.2D
    ADDP  V17.8H, V1.8H, V21.8H
    FMINNMP  V24.4S, V24.4S, V22.4S
    SMINP  V23.4S, V13.4S, V6.4S
    FADDP D21, V31.2D
    FMINP  V15.2D, V3.2D, V10.2D
    ADDP  V12.16B, V4.16B, V31.16B
    UMINP  V31.4S, V9.4S, V31.4S
    FMAXP S23, V21.2S
    FMINP D13, V20.2D
    FMINNMP  V7.4S, V4.4S, V30.4S
    FADDP S9, V17.2S
    FMINNMP D6, V22.2D
    FMAXNMP D18, V17.2D
    FMINNMP  V12.2S, V19.2S, V26.2S
    FMAXP S4, V5.2S
    FMAXP  V23.2S, V5.2S, V13.2S
    FMAXP D24, V28.2D
    FMAXP D23, V0.2D
    SMINP  V14.8B, V13.8B, V24.8B
    FMAXP D2, V5.2D
    FMINNMP  V31.4S, V6.4S, V1.4S
    FADDP S8, V25.2S
    ADDP  V30.4S, V18.4S, V0.4S
    FADDP S28, V9.2S
    FMINP S30, V1.2S
    FMAXP D31, V3.2D
    FADDP S15, V25.2S
    FMAXP  V9.2D, V12.2D, V13.2D
    SMINP  V17.16B, V28.16B, V4.16B
    FMINNMP S17, V5.2S
    FMAXP  V4.2D, V15.2D, V20.2D
    FADDP  V19.4S, V1.4S, V0.4S
    FADDP  V10.4S, V21.4S, V31.4S
    FADDP  V21.2D, V9.2D, V7.2D
    FADDP D4, V15.2D
    SMAXP  V18.4S, V14.4S, V5.4S
    FADDP S12, V18.2S
    FMINNMP  V30.2D, V1.2D, V7.2D
    UMAXP  V22.8H, V7.8H, V10.8H
    FMAXP S26, V13.2S
    SMAXP  V9.8H, V0.8H, V30.8H
    FMINP  V27.2D, V8.2D, V3.2D
    FADDP D18, V8.2D
    FMINP  V6.4S, V2.4S, V14.4S
    FMAXNMP S1, V27.2S
    SMAXP  V2.16B, V28.16B, V12.16B
    SMINP  V1.8B, V1.8B, V0.8B
    FMAXP S14, V8.2S
    FMINP S0, V8.2S
    FMAXP D4, V1.2D
    ADDP  V10.2S, V21.2S, V10.2S
    FMINP D14, V6.2D
    FMAXP S22, V5.2S
    FADDP  V18.2S, V5.2S, V17.2S
    FMINP D8, V17.2D
    FMINP S21, V28.2S
    FMINNMP D12, V0.2D
    FMINP S4, V23.2S
    UMAXP  V7.8B, V23.8B, V6.8B
    FADDP  V9.4S, V2.4S, V9.4S
    ADDP  V30.16B, V31.16B, V16.16B
    FMAXP  V1.4S, V13.4S, V16.4S
    FADDP S23, V19.2S
    FMAXNMP D19, V14.2D
    FMINP  V11.2S, V10.2S, V9.2S
    SMAXP  V17.4H, V19.4H, V11.4H
    ADDP  V28.4H, V17.4H, V5.4H
    FMINP  V6.4S, V14.4S, V0.4S
    SMINP  V1.4S, V10.4S, V0.4S
    FMAXNMP  V17.2S, V15.2S, V0.2S
    FMINNMP  V28.2S, V6.2S, V6.2S
    FMINP D12, V9.2D
    UMAXP  V0.8H, V16.8H, V18.8H
    FMINP S10, V29.2S
    UMAXP  V9.4S, V1.4S, V10.4S
    ADDP  V13.2D, V4.2D, V30.2D
    FMINNMP  V15.2D, V6.2D, V22.2D
    FMINP D0, V17.2D
    FMINP S31, V21.2S
    FMINP  V23.2D, V19.2D, V2.2D
    SMAXP  V9.4H, V14.4H, V5.4H
    SMAXP  V24.8H, V9.8H, V3.8H
    FMAXP S24, V15.2S
    FMINNMP S15, V3.2S
    FMAXP S12, V13.2S
    FMAXP  V26.2S, V28.2S, V30.2S
    FMINNMP  V7.2D, V3.2D, V11.2D
    UMINP  V9.4S, V29.4S, V18.4S
    ADDP  V21.2S, V5.2S, V3.2S
    FMINNMP D22, V25.2D
    UMAXP  V26.8H, V14.8H, V7.8H
    FMAXP  V23.2D, V22.2D, V0.2D
    FMINP D31, V5.2D
    FMAXP D27, V23.2D
    ADDP  D9, V17.2D
    FADDP D27, V10.2D
    FMINNMP S1, V12.2S
    FMINNMP  V1.2S, V29.2S, V0.2S
    FADDP D21, V3.2D
    FMINNMP S25, V15.2S
    FMAXNMP S16, V15.2S
    SMINP  V2.4H, V18.4H, V24.4H
    FMINNMP S24, V29.2S
    FMAXP D5, V1.2D
    ADDP  V28.4S, V28.4S, V5.4S
    UMAXP  V25.16B, V0.16B, V31.16B
    FMINNMP S0, V3.2S
    FMAXP S21, V2.2S
    FMINP D26, V18.2D
    FMINNMP S31, V29.2S
    FMINNMP S3, V24.2S
    FMAXNMP D3, V15.2D
    FMINP  V2.2S, V16.2S, V10.2S
    FADDP  V26.4S, V9.4S, V30.4S
    FMAXNMP  V12.2D, V16.2D, V24.2D
    FMAXP  V6.4S, V0.4S, V10.4S
    FMAXP  V30.2D, V11.2D, V13.2D
    FMAXNMP S26, V21.2S
    SMAXP  V28.4S, V15.4S, V25.4S
    FMAXP D6, V6.2D
    FADDP D28, V27.2D
    UMAXP  V4.2S, V2.2S, V18.2S
    UMINP  V15.8H, V9.8H, V7.8H
    FMAXNMP S27, V2.2S
    UMAXP  V18.8B, V1.8B, V2.8B
    FMAXNMP  V2.4S, V13.4S, V25.4S
    UMINP  V27.8H, V5.8H, V16.8H
    FMINP D4, V8.2D
    FMINP  V17.2S, V9.2S, V5.2S
    FMAXP S6, V31.2S
    UMAXP  V13.2S, V13.2S, V10.2S
    UMAXP  V16.8B, V17.8B, V27.8B
    ADDP  D7, V3.2D
    FMAXP  V0.4S, V2.4S, V17.4S
    FMINNMP  V3.2D, V28.2D, V26.2D
    FMINNMP  V23.4S, V30.4S, V17.4S
    SMINP  V4.16B, V1.16B, V12.16B
    FMAXP S24, V1.2S
    FMAXP  V8.2S, V17.2S, V31.2S
    FMINNMP S8, V30.2S
    FMAXNMP S24, V27.2S
    SMINP  V24.8H, V4.8H, V29.8H
    FADDP D22, V27.2D
    FMINNMP S12, V21.2S
    SUBS  X16, X16, #0x1
    B.NE  TaishanSimdComplexP01_label_1125
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X2, X8, X2
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X5, X14, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X23, X22, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X8, X11, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X16, X23, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X25, X4, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X4, X8, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X20, X14, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X3, X14, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X14, X22, X14
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X28, X13, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X17
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X7, X19, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X16, X3, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X9, X11, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X5, X7, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X25
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X28, X22, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X6, X29, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X18, D2
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xfc, LSL #32
    SUB  X17, X11, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X13, D3
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X14, D4
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X3, D5
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X17, D6
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X26, D7
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X19, D8
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X25, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X25, D9
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X17, X28, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X2, D10
    MOVZ  X28, #0x0, LSL #0
    SUB  X17, X28, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X9, X12, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X2, D11
    MOVZ  X12, #0x0, LSL #0
    SUB  X9, X12, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X8, D12
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X17, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X17, D13
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X20, X17, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X28, D14
    MOVZ  X17, #0x0, LSL #0
    SUB  X20, X17, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X21, V15.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X18, X23, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X21, D15
    MOVZ  X23, #0x0, LSL #0
    SUB  X18, X23, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X18, D16
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X28, X7, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X12, D17
    MOVZ  X7, #0x0, LSL #0
    SUB  X28, X7, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X23, D18
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X7, D19
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X5, D20
    MOVZ  X12, #0xfc, LSL #0
    SUB  X4, X12, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X18, D21
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X16, D22
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X9, D23
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X16, D24
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X13, D25
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X22, V26.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X22, D26
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X10, D28
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X8, D29
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    MOVZ  X2, #0x1624, LSL #0
    MOVK  X2, #0xeab7, LSL #16
    MOVK  X2, #0x7566, LSL #32
    MOVK  X2, #0xd72b, LSL #48
    MOVZ  X3, #0x4702, LSL #0
    MOVK  X3, #0x8459, LSL #16
    MOVK  X3, #0x995f, LSL #32
    MOVK  X3, #0x72ea, LSL #48
    MOVZ  X4, #0xb85d, LSL #0
    MOVK  X4, #0xa1be, LSL #16
    MOVK  X4, #0x7fe6, LSL #32
    MOVK  X4, #0x6816, LSL #48
    MOVZ  X5, #0xf3d6, LSL #0
    MOVK  X5, #0xd632, LSL #16
    MOVK  X5, #0x438a, LSL #32
    MOVK  X5, #0xf495, LSL #48
    MOVZ  X6, #0xb9cb, LSL #0
    MOVK  X6, #0xdc66, LSL #16
    MOVK  X6, #0xb7e4, LSL #32
    MOVK  X6, #0xab8c, LSL #48
    MOVZ  X7, #0xa4b3, LSL #0
    MOVK  X7, #0x656e, LSL #16
    MOVK  X7, #0x398f, LSL #32
    MOVK  X7, #0x3394, LSL #48
    MOVZ  X8, #0xdfca, LSL #0
    MOVK  X8, #0x9941, LSL #16
    MOVK  X8, #0xd958, LSL #32
    MOVK  X8, #0xc0df, LSL #48
    MOVZ  X9, #0x9e64, LSL #0
    MOVK  X9, #0xcb53, LSL #16
    MOVK  X9, #0xe7ee, LSL #32
    MOVK  X9, #0xbe11, LSL #48
    MOVZ  X10, #0x9a78, LSL #0
    MOVK  X10, #0x598, LSL #16
    MOVK  X10, #0xb36f, LSL #32
    MOVK  X10, #0x7023, LSL #48
    MOVZ  X11, #0xeb81, LSL #0
    MOVK  X11, #0x1a89, LSL #16
    MOVK  X11, #0x8ae3, LSL #32
    MOVK  X11, #0x49e2, LSL #48
    MOVZ  X12, #0x8022, LSL #0
    MOVK  X12, #0x100f, LSL #16
    MOVK  X12, #0xbf78, LSL #32
    MOVK  X12, #0x156d, LSL #48
    MOVZ  X13, #0x8f37, LSL #0
    MOVK  X13, #0xda9f, LSL #16
    MOVK  X13, #0xa41d, LSL #32
    MOVK  X13, #0x19fe, LSL #48
    MOVZ  X14, #0xf76b, LSL #0
    MOVK  X14, #0x4112, LSL #16
    MOVK  X14, #0xfcc5, LSL #32
    MOVK  X14, #0xaf2a, LSL #48
    MOVZ  X15, #0x2f6b, LSL #0
    MOVK  X15, #0x777, LSL #16
    MOVK  X15, #0xa01e, LSL #32
    MOVK  X15, #0x91b1, LSL #48
    MOVZ  X16, #0xae98, LSL #0
    MOVK  X16, #0x3c82, LSL #16
    MOVK  X16, #0xe2c9, LSL #32
    MOVK  X16, #0xfd4c, LSL #48
    MOVZ  X17, #0xc9d9, LSL #0
    MOVK  X17, #0xeb7, LSL #16
    MOVK  X17, #0x9852, LSL #32
    MOVK  X17, #0x8aee, LSL #48
    MOVZ  X18, #0x1c3b, LSL #0
    MOVK  X18, #0xc4bd, LSL #16
    MOVK  X18, #0x69ec, LSL #32
    MOVK  X18, #0x3775, LSL #48
    MOVZ  X19, #0x97e2, LSL #0
    MOVK  X19, #0x1233, LSL #16
    MOVK  X19, #0xf09a, LSL #32
    MOVK  X19, #0xad97, LSL #48
    MOVZ  X20, #0x834b, LSL #0
    MOVK  X20, #0xdabe, LSL #16
    MOVK  X20, #0xf780, LSL #32
    MOVK  X20, #0x304b, LSL #48
    MOVZ  X21, #0xc3a0, LSL #0
    MOVK  X21, #0x7692, LSL #16
    MOVK  X21, #0xc47b, LSL #32
    MOVK  X21, #0x7712, LSL #48
    MOVZ  X22, #0x389b, LSL #0
    MOVK  X22, #0xeb99, LSL #16
    MOVK  X22, #0x2f43, LSL #32
    MOVK  X22, #0x1078, LSL #48
    MOVZ  X23, #0x960d, LSL #0
    MOVK  X23, #0x7e26, LSL #16
    MOVK  X23, #0x1d0e, LSL #32
    MOVK  X23, #0x4e86, LSL #48
    MOVZ  X24, #0xeeac, LSL #0
    MOVK  X24, #0x83cf, LSL #16
    MOVK  X24, #0x6e23, LSL #32
    MOVK  X24, #0xf502, LSL #48
    MOVZ  X25, #0x8201, LSL #0
    MOVK  X25, #0x3595, LSL #16
    MOVK  X25, #0x7e98, LSL #32
    MOVK  X25, #0x519e, LSL #48
    MOVZ  X26, #0x772d, LSL #0
    MOVK  X26, #0x5127, LSL #16
    MOVK  X26, #0xe60e, LSL #32
    MOVK  X26, #0x31aa, LSL #48
    MOVZ  X28, #0x42c1, LSL #0
    MOVK  X28, #0x7c06, LSL #16
    MOVK  X28, #0x74e, LSL #32
    MOVK  X28, #0x4d07, LSL #48
    MOVZ  X29, #0x59d6, LSL #0
    MOVK  X29, #0xbad0, LSL #16
    MOVK  X29, #0x1e7, LSL #32
    MOVK  X29, #0x54bb, LSL #48
    FMOV  D0, X17
    FMOV  V0.D[1], X29
    FMOV  D1, X14
    FMOV  V1.D[1], X26
    FMOV  D2, X5
    FMOV  V2.D[1], X7
    FMOV  D3, X23
    FMOV  V3.D[1], X18
    FMOV  D4, X25
    FMOV  V4.D[1], X29
    FMOV  D5, X5
    FMOV  V5.D[1], X6
    FMOV  D6, X21
    FMOV  V6.D[1], X2
    FMOV  D7, X3
    FMOV  V7.D[1], X28
    FMOV  D8, X20
    FMOV  V8.D[1], X24
    FMOV  D9, X18
    FMOV  V9.D[1], X19
    FMOV  D10, X20
    FMOV  V10.D[1], X20
    FMOV  D11, X21
    FMOV  V11.D[1], X7
    FMOV  D12, X6
    FMOV  V12.D[1], X17
    FMOV  D13, X11
    FMOV  V13.D[1], X10
    FMOV  D14, X14
    FMOV  V14.D[1], X26
    FMOV  D15, X18
    FMOV  V15.D[1], X15
    FMOV  D16, X20
    FMOV  V16.D[1], X20
    FMOV  D17, X7
    FMOV  V17.D[1], X22
    FMOV  D18, X26
    FMOV  V18.D[1], X10
    FMOV  D19, X15
    FMOV  V19.D[1], X17
    FMOV  D20, X25
    FMOV  V20.D[1], X17
    FMOV  D21, X7
    FMOV  V21.D[1], X5
    FMOV  D22, X2
    FMOV  V22.D[1], X11
    FMOV  D23, X10
    FMOV  V23.D[1], X11
    FMOV  D24, X18
    FMOV  V24.D[1], X23
    FMOV  D25, X20
    FMOV  V25.D[1], X3
    FMOV  D26, X24
    FMOV  V26.D[1], X29
    FMOV  D27, X5
    FMOV  V27.D[1], X23
    FMOV  D28, X23
    FMOV  V28.D[1], X16
    FMOV  D29, X26
    FMOV  V29.D[1], X25
    FMOV  D30, X19
    FMOV  V30.D[1], X25
    FMOV  D31, X10
    FMOV  V31.D[1], X4
    MOVZ  X17, #0xa, LSL #0
TaishanSimdComplexP01_label_1205:
    FADDP  V11.4S, V29.4S, V20.4S
    FMINNMP D18, V0.2D
    SMAXP  V24.8H, V31.8H, V21.8H
    FADDP  V25.4S, V28.4S, V15.4S
    SMAXP  V2.2S, V2.2S, V27.2S
    SMINP  V4.8H, V30.8H, V3.8H
    FMINNMP S2, V1.2S
    ADDP  D28, V9.2D
    FMINNMP D28, V21.2D
    ADDP  D7, V18.2D
    ADDP  V11.2S, V7.2S, V7.2S
    FADDP S12, V9.2S
    FMAXP  V16.4S, V31.4S, V14.4S
    FMAXNMP  V1.2S, V4.2S, V31.2S
    FMAXNMP  V25.2S, V19.2S, V12.2S
    UMINP  V2.8B, V3.8B, V30.8B
    FADDP S22, V11.2S
    FMINP  V27.2S, V18.2S, V5.2S
    FMAXNMP  V5.2D, V7.2D, V5.2D
    FMINP S21, V14.2S
    FMAXNMP  V28.2D, V5.2D, V25.2D
    FMAXNMP D16, V21.2D
    FMAXNMP D24, V30.2D
    UMAXP  V25.4H, V22.4H, V2.4H
    FADDP D1, V27.2D
    UMAXP  V0.4H, V20.4H, V28.4H
    FMAXP  V16.2D, V26.2D, V16.2D
    FMAXNMP S5, V27.2S
    FMAXP S0, V29.2S
    FMAXP  V3.2S, V9.2S, V24.2S
    FADDP  V15.2S, V20.2S, V0.2S
    FMINNMP D19, V6.2D
    FADDP S23, V13.2S
    FMAXNMP D20, V12.2D
    UMINP  V6.2S, V25.2S, V15.2S
    FMAXNMP S27, V19.2S
    UMINP  V12.8B, V21.8B, V31.8B
    FMINP  V6.2S, V4.2S, V9.2S
    FMINNMP S10, V24.2S
    FMAXNMP S17, V31.2S
    FMINNMP S10, V8.2S
    UMINP  V3.4S, V17.4S, V22.4S
    UMINP  V11.8H, V31.8H, V23.8H
    ADDP  D29, V11.2D
    ADDP  V31.8B, V1.8B, V24.8B
    FMAXNMP D2, V6.2D
    FMAXNMP  V23.2S, V31.2S, V5.2S
    FMINNMP D2, V14.2D
    FMAXNMP S16, V21.2S
    FADDP S23, V21.2S
    SMAXP  V19.8H, V27.8H, V24.8H
    FMINP D12, V20.2D
    FMAXP  V17.4S, V24.4S, V29.4S
    FMINP D20, V30.2D
    SMAXP  V2.8H, V31.8H, V20.8H
    FMINNMP D20, V31.2D
    FMINP D21, V30.2D
    FMAXP  V31.2D, V29.2D, V19.2D
    FMAXNMP  V12.2S, V9.2S, V31.2S
    FMAXNMP D21, V23.2D
    UMAXP  V22.8H, V22.8H, V16.8H
    FMAXP  V19.2D, V28.2D, V12.2D
    UMAXP  V4.8B, V12.8B, V14.8B
    FADDP S10, V9.2S
    UMINP  V31.16B, V4.16B, V27.16B
    ADDP  V22.8H, V27.8H, V27.8H
    FADDP  V17.2D, V17.2D, V31.2D
    FMINNMP S28, V15.2S
    FMINP  V15.2S, V20.2S, V31.2S
    FADDP D29, V5.2D
    FADDP D25, V10.2D
    FMINP D0, V28.2D
    FMINP S1, V19.2S
    FMAXP S18, V24.2S
    UMAXP  V6.4S, V5.4S, V30.4S
    FMINP D6, V22.2D
    SMINP  V17.16B, V30.16B, V31.16B
    ADDP  V27.4H, V0.4H, V0.4H
    FMAXP  V18.4S, V21.4S, V6.4S
    FMINP S15, V20.2S
    SMINP  V23.4H, V31.4H, V22.4H
    FMINNMP S29, V12.2S
    SMINP  V20.4S, V1.4S, V16.4S
    FADDP S10, V25.2S
    FMAXNMP S2, V3.2S
    FMINNMP D13, V8.2D
    FMINNMP S23, V27.2S
    FMINP D18, V11.2D
    FMAXP  V19.2S, V27.2S, V27.2S
    UMINP  V10.8B, V1.8B, V24.8B
    FMAXP  V29.4S, V31.4S, V10.4S
    ADDP  V31.4H, V4.4H, V7.4H
    FMINP D26, V23.2D
    FMINP S21, V18.2S
    SMINP  V29.2S, V5.2S, V8.2S
    FMAXP D15, V17.2D
    FMINP D30, V25.2D
    FMINP D28, V26.2D
    ADDP  D15, V2.2D
    FMINP D1, V4.2D
    FMINNMP S15, V28.2S
    FMAXP  V18.2S, V15.2S, V26.2S
    FMAXP  V13.4S, V28.4S, V12.4S
    UMAXP  V28.8H, V19.8H, V11.8H
    FMINP S26, V27.2S
    ADDP  V31.4H, V5.4H, V30.4H
    SMAXP  V0.4H, V18.4H, V1.4H
    ADDP  V9.8B, V29.8B, V19.8B
    FADDP  V22.2S, V21.2S, V24.2S
    FMINNMP D7, V22.2D
    FMAXP D26, V7.2D
    FMAXP S21, V28.2S
    FMINP D13, V13.2D
    ADDP  D13, V21.2D
    FMAXP  V4.4S, V2.4S, V27.4S
    FMINP S3, V11.2S
    FADDP S10, V15.2S
    FMINNMP S15, V21.2S
    FMAXNMP D5, V30.2D
    FMINNMP S14, V27.2S
    FMINNMP  V25.4S, V12.4S, V18.4S
    FMINP  V30.4S, V13.4S, V25.4S
    FMAXNMP S5, V15.2S
    FADDP D21, V0.2D
    FMAXNMP  V20.4S, V8.4S, V9.4S
    FMAXP  V2.4S, V20.4S, V3.4S
    FADDP  V27.4S, V11.4S, V27.4S
    UMAXP  V15.4S, V25.4S, V23.4S
    FADDP D27, V24.2D
    FADDP S10, V14.2S
    ADDP  V30.8B, V0.8B, V22.8B
    SMAXP  V28.16B, V19.16B, V5.16B
    FMAXP  V23.2S, V31.2S, V24.2S
    FMAXP D4, V17.2D
    FMAXNMP  V16.4S, V4.4S, V25.4S
    FMAXNMP  V16.2S, V7.2S, V31.2S
    FMINP  V10.2S, V20.2S, V7.2S
    FMINP S14, V16.2S
    FMAXNMP  V22.2S, V31.2S, V5.2S
    ADDP  D23, V15.2D
    FMINP D16, V27.2D
    FADDP S25, V28.2S
    ADDP  V3.2S, V2.2S, V25.2S
    FMINNMP  V28.2S, V2.2S, V10.2S
    FMAXNMP S6, V29.2S
    FMAXNMP  V30.2D, V22.2D, V6.2D
    FMAXP D29, V21.2D
    FMAXP S23, V23.2S
    FMAXNMP D30, V29.2D
    FADDP  V15.2S, V16.2S, V9.2S
    SMINP  V7.16B, V25.16B, V6.16B
    FMINNMP  V9.2S, V20.2S, V21.2S
    FMINP S22, V31.2S
    SMAXP  V10.2S, V1.2S, V30.2S
    FADDP S27, V23.2S
    FMINNMP  V0.2S, V27.2S, V11.2S
    FMINP  V20.2S, V23.2S, V7.2S
    ADDP  D3, V20.2D
    FADDP S7, V12.2S
    FADDP S30, V23.2S
    FMINNMP  V20.2D, V30.2D, V10.2D
    FMAXNMP S15, V31.2S
    FMINNMP S5, V6.2S
    ADDP  D0, V5.2D
    FMINNMP  V5.4S, V23.4S, V27.4S
    FMINP  V26.2D, V13.2D, V25.2D
    FMAXNMP S8, V1.2S
    FMINNMP  V15.4S, V21.4S, V4.4S
    UMINP  V31.2S, V0.2S, V30.2S
    SMAXP  V9.2S, V11.2S, V12.2S
    FADDP S24, V12.2S
    FADDP S1, V7.2S
    FMINP D22, V12.2D
    FMINNMP  V8.2S, V26.2S, V26.2S
    FMINP  V29.2D, V0.2D, V26.2D
    FMINP S17, V5.2S
    FMAXP S30, V17.2S
    UMINP  V16.8B, V20.8B, V9.8B
    ADDP  D22, V14.2D
    FMINNMP  V22.2S, V14.2S, V5.2S
    FMAXNMP  V11.4S, V30.4S, V25.4S
    ADDP  D9, V11.2D
    FADDP  V9.2S, V28.2S, V7.2S
    FMINP S4, V11.2S
    FMAXP S1, V1.2S
    FMAXNMP S3, V21.2S
    FMAXNMP  V16.4S, V2.4S, V26.4S
    FMAXNMP D18, V25.2D
    SMINP  V17.8B, V10.8B, V9.8B
    ADDP  V4.8H, V18.8H, V2.8H
    UMAXP  V14.4H, V7.4H, V15.4H
    ADDP  V19.4S, V12.4S, V10.4S
    SMINP  V10.8H, V18.8H, V7.8H
    UMAXP  V6.16B, V11.16B, V31.16B
    FMINP D0, V10.2D
    FADDP S15, V7.2S
    FADDP D8, V2.2D
    FMAXP  V9.2S, V3.2S, V4.2S
    UMAXP  V10.4H, V10.4H, V21.4H
    FMAXP S28, V23.2S
    SUBS  X17, X17, #0x1
    B.NE  TaishanSimdComplexP01_label_1205
    MOVZ  X5, #0x1624, LSL #0
    MOVK  X5, #0xeab7, LSL #16
    MOVK  X5, #0x7566, LSL #32
    MOVK  X5, #0xd72b, LSL #48
    SUB  X16, X5, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    MOVZ  X28, #0x4702, LSL #0
    MOVK  X28, #0x8459, LSL #16
    MOVK  X28, #0x995f, LSL #32
    MOVK  X28, #0x72ea, LSL #48
    SUB  X13, X28, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    MOVZ  X28, #0xb85d, LSL #0
    MOVK  X28, #0xa1be, LSL #16
    MOVK  X28, #0x7fe6, LSL #32
    MOVK  X28, #0x6816, LSL #48
    SUB  X6, X28, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    MOVZ  X21, #0x1624, LSL #0
    MOVK  X21, #0xeab7, LSL #16
    MOVK  X21, #0x7566, LSL #32
    MOVK  X21, #0xd72b, LSL #48
    SUB  X28, X21, X5
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X17, X20, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0xa4b3, LSL #0
    MOVK  X16, #0x656e, LSL #16
    MOVK  X16, #0x398f, LSL #32
    MOVK  X16, #0x3394, LSL #48
    SUB  X7, X16, X7
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0xdfca, LSL #0
    MOVK  X20, #0x9941, LSL #16
    MOVK  X20, #0xd958, LSL #32
    MOVK  X20, #0xc0df, LSL #48
    SUB  X11, X20, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    MOVZ  X10, #0x9e64, LSL #0
    MOVK  X10, #0xcb53, LSL #16
    MOVK  X10, #0xe7ee, LSL #32
    MOVK  X10, #0xbe11, LSL #48
    SUB  X3, X10, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    MOVZ  X25, #0x9e64, LSL #0
    MOVK  X25, #0xcb53, LSL #16
    MOVK  X25, #0xe7ee, LSL #32
    MOVK  X25, #0xbe11, LSL #48
    SUB  X23, X25, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X11
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    MOVZ  X17, #0x8022, LSL #0
    MOVK  X17, #0x100f, LSL #16
    MOVK  X17, #0xbf78, LSL #32
    MOVK  X17, #0x156d, LSL #48
    SUB  X8, X17, X12
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X13
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0xf76b, LSL #0
    MOVK  X20, #0x4112, LSL #16
    MOVK  X20, #0xfcc5, LSL #32
    MOVK  X20, #0xaf2a, LSL #48
    SUB  X17, X20, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0x2f6b, LSL #0
    MOVK  X20, #0x777, LSL #16
    MOVK  X20, #0xa01e, LSL #32
    MOVK  X20, #0x91b1, LSL #48
    SUB  X8, X20, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    MOVZ  X9, #0xa4b3, LSL #0
    MOVK  X9, #0x656e, LSL #16
    MOVK  X9, #0x398f, LSL #32
    MOVK  X9, #0x3394, LSL #48
    SUB  X21, X9, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X4, X24, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0x1c3b, LSL #0
    MOVK  X24, #0xc4bd, LSL #16
    MOVK  X24, #0x69ec, LSL #32
    MOVK  X24, #0x3775, LSL #48
    SUB  X23, X24, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    MOVZ  X17, #0x97e2, LSL #0
    MOVK  X17, #0x1233, LSL #16
    MOVK  X17, #0xf09a, LSL #32
    MOVK  X17, #0xad97, LSL #48
    SUB  X23, X17, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    MOVZ  X21, #0x2f6b, LSL #0
    MOVK  X21, #0x777, LSL #16
    MOVK  X21, #0xa01e, LSL #32
    MOVK  X21, #0x91b1, LSL #48
    SUB  X15, X21, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    MOVZ  X10, #0x2f6b, LSL #0
    MOVK  X10, #0x777, LSL #16
    MOVK  X10, #0xa01e, LSL #32
    MOVK  X10, #0x91b1, LSL #48
    SUB  X11, X10, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    MOVZ  X22, #0x389b, LSL #0
    MOVK  X22, #0xeb99, LSL #16
    MOVK  X22, #0x2f43, LSL #32
    MOVK  X22, #0x1078, LSL #48
    SUB  X16, X22, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    MOVZ  X28, #0x1c3b, LSL #0
    MOVK  X28, #0xc4bd, LSL #16
    MOVK  X28, #0x69ec, LSL #32
    MOVK  X28, #0x3775, LSL #48
    SUB  X5, X28, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X4, X8, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    MOVZ  X21, #0x772d, LSL #0
    MOVK  X21, #0x5127, LSL #16
    MOVK  X21, #0xe60e, LSL #32
    MOVK  X21, #0x31aa, LSL #48
    SUB  X2, X21, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    MOVZ  X21, #0x1c3b, LSL #0
    MOVK  X21, #0xc4bd, LSL #16
    MOVK  X21, #0x69ec, LSL #32
    MOVK  X21, #0x3775, LSL #48
    SUB  X3, X21, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X4, D2
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X9, D3
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X17, D4
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X24, D5
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
TaishanSimdComplexP01_label_930:
    FMOV  X23, V6.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X23, D6
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X3, D7
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X19, X25, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    FMOV  X23, D8
    MOVZ  X25, #0x0, LSL #0
    SUB  X19, X25, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X11, D9
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X21, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X21, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X28, X15, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X7, D11
    MOVZ  X15, #0x0, LSL #0
    SUB  X28, X15, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X6, D12
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X7, D13
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X17, D14
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X5, V15.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X5
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X5, D15
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X5
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X9, D16
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X19, V17.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X19, D17
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X17, D18
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X8, D19
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X18, V20.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X5, X12, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X18, D20
    MOVZ  X12, #0x0, LSL #0
    SUB  X5, X12, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X6, D21
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X24, D22
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X17, D23
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X21, V24.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X21, D24
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X21, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X21, D25
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X17, D26
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X29, D28
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X25, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X25, D29
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
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
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X19
    FMOV  V0.D[1], X7
    FMOV  D1, X8
    FMOV  V1.D[1], X24
    FMOV  D2, X9
    FMOV  V2.D[1], X10
    FMOV  D3, X21
    FMOV  V3.D[1], X16
    FMOV  D4, X10
    FMOV  V4.D[1], X22
    FMOV  D5, X5
    FMOV  V5.D[1], X12
    FMOV  D6, X18
    FMOV  V6.D[1], X22
    FMOV  D7, X20
    FMOV  V7.D[1], X5
    FMOV  D8, X16
    FMOV  V8.D[1], X25
    FMOV  D9, X3
    FMOV  V9.D[1], X5
    FMOV  D10, X22
    FMOV  V10.D[1], X13
    FMOV  D11, X29
    FMOV  V11.D[1], X8
    FMOV  D12, X3
    FMOV  V12.D[1], X11
    FMOV  D13, X12
    FMOV  V13.D[1], X2
    FMOV  D14, X26
    FMOV  V14.D[1], X29
    FMOV  D15, X20
    FMOV  V15.D[1], X9
    FMOV  D16, X21
    FMOV  V16.D[1], X11
    FMOV  D17, X26
    FMOV  V17.D[1], X14
    FMOV  D18, X15
    FMOV  V18.D[1], X15
    FMOV  D19, X29
    FMOV  V19.D[1], X19
    FMOV  D20, X13
    FMOV  V20.D[1], X29
    FMOV  D21, X9
    FMOV  V21.D[1], X13
    FMOV  D22, X6
    FMOV  V22.D[1], X13
    FMOV  D23, X6
    FMOV  V23.D[1], X9
    FMOV  D24, X9
    FMOV  V24.D[1], X26
    FMOV  D25, X24
    FMOV  V25.D[1], X28
    FMOV  D26, X29
    FMOV  V26.D[1], X25
    FMOV  D27, X15
    FMOV  V27.D[1], X21
    FMOV  D28, X16
    FMOV  V28.D[1], X9
    FMOV  D29, X21
    FMOV  V29.D[1], X14
    FMOV  D30, X15
    FMOV  V30.D[1], X17
    FMOV  D31, X4
    FMOV  V31.D[1], X8
    MOVZ  X8, #0xa, LSL #0
TaishanSimdComplexP01_label_1282:
    ADDP  D18, V11.2D
    FMAXP D9, V4.2D
    FMAXP  V15.2S, V0.2S, V2.2S
    SMINP  V30.16B, V15.16B, V8.16B
    FADDP S1, V4.2S
    UMINP  V16.4H, V5.4H, V22.4H
    FMAXNMP D31, V1.2D
    FMINP  V7.2S, V19.2S, V27.2S
    FMAXP S29, V10.2S
    UMAXP  V28.16B, V31.16B, V12.16B
    FADDP S14, V17.2S
    FMINP  V6.4S, V4.4S, V14.4S
    FMINNMP S24, V21.2S
    ADDP  D11, V28.2D
    UMINP  V21.4H, V11.4H, V2.4H
    FMINNMP  V29.2S, V27.2S, V29.2S
    ADDP  V19.8B, V30.8B, V28.8B
    FADDP  V17.4S, V26.4S, V30.4S
    FMINP D29, V17.2D
    FADDP  V11.2S, V9.2S, V18.2S
    FMAXNMP S15, V24.2S
    UMAXP  V27.2S, V31.2S, V6.2S
    FMAXP S8, V2.2S
    FMINP D16, V29.2D
    FMAXNMP  V28.2D, V24.2D, V11.2D
    FADDP  V28.2S, V29.2S, V21.2S
    ADDP  V2.4S, V15.4S, V28.4S
    FMAXP D10, V28.2D
    FMINP D22, V17.2D
    FADDP  V23.2D, V9.2D, V24.2D
    FMAXNMP D2, V22.2D
    FMAXNMP D30, V25.2D
    SMAXP  V7.2S, V9.2S, V7.2S
    UMINP  V1.2S, V24.2S, V22.2S
    FMINNMP D7, V8.2D
    FMINP D25, V26.2D
    FMAXNMP  V11.2D, V23.2D, V19.2D
    FMAXP D11, V27.2D
    FMAXNMP S18, V14.2S
    FADDP D0, V6.2D
    FMAXP D11, V11.2D
    UMINP  V0.8H, V6.8H, V29.8H
    FADDP D7, V18.2D
    UMINP  V11.4S, V1.4S, V0.4S
    FADDP S11, V2.2S
    FMINNMP  V18.4S, V24.4S, V4.4S
    FMINNMP D7, V1.2D
    FMAXP  V30.4S, V10.4S, V9.4S
    FMAXP S30, V5.2S
    SMINP  V3.8B, V31.8B, V16.8B
    FMAXNMP D10, V14.2D
    FMINP  V28.2S, V12.2S, V25.2S
    FMAXP  V27.4S, V29.4S, V29.4S
    FMAXP D1, V3.2D
    FADDP  V23.2S, V29.2S, V8.2S
    FMINP S23, V22.2S
    UMAXP  V30.4H, V22.4H, V24.4H
    FMAXP S30, V12.2S
    FMINP S20, V18.2S
    UMINP  V19.4S, V13.4S, V1.4S
    FMAXNMP  V30.2S, V5.2S, V19.2S
    SMINP  V21.16B, V26.16B, V13.16B
    SMAXP  V8.8B, V6.8B, V13.8B
    FMAXNMP S1, V3.2S
    FMAXNMP D14, V16.2D
    ADDP  V17.4S, V2.4S, V22.4S
    ADDP  V15.8H, V0.8H, V30.8H
    FMAXNMP  V14.2S, V4.2S, V7.2S
    UMINP  V9.8H, V0.8H, V11.8H
    FADDP  V8.4S, V24.4S, V4.4S
    SMAXP  V26.8H, V9.8H, V12.8H
    ADDP  D21, V12.2D
    FMAXP S24, V15.2S
    UMAXP  V19.4H, V25.4H, V21.4H
    FMINP S10, V16.2S
    FMINNMP  V27.4S, V5.4S, V4.4S
    ADDP  V3.8B, V30.8B, V27.8B
    ADDP  V9.8B, V16.8B, V6.8B
    UMINP  V10.8H, V19.8H, V15.8H
    FMAXNMP D11, V8.2D
    FADDP S13, V11.2S
    FADDP  V7.4S, V18.4S, V12.4S
    ADDP  D18, V28.2D
    FADDP D20, V27.2D
    FMINNMP S23, V19.2S
    UMAXP  V1.4H, V22.4H, V10.4H
    ADDP  V22.16B, V1.16B, V10.16B
    FMAXNMP  V5.2D, V8.2D, V16.2D
    FMINNMP D5, V31.2D
    FMINP D11, V11.2D
    UMAXP  V24.4H, V12.4H, V18.4H
    SMAXP  V12.4S, V21.4S, V30.4S
    FMINNMP  V28.4S, V4.4S, V15.4S
    FMAXNMP S23, V17.2S
    FADDP S17, V17.2S
    FADDP D4, V8.2D
    FMAXP S24, V5.2S
    FMAXP  V3.2S, V26.2S, V9.2S
    ADDP  V15.16B, V27.16B, V14.16B
    FMAXNMP S8, V13.2S
    FMINNMP S21, V25.2S
    ADDP  V18.8H, V11.8H, V23.8H
    FMINP S7, V20.2S
    FMINP  V23.2S, V6.2S, V13.2S
    FMAXNMP  V24.2D, V18.2D, V17.2D
    FMAXNMP  V24.2D, V0.2D, V25.2D
    FMINP S31, V25.2S
    FMAXP  V18.4S, V14.4S, V6.4S
    UMAXP  V25.2S, V12.2S, V24.2S
    FMAXNMP D29, V3.2D
    FMINP  V29.2D, V27.2D, V20.2D
    FMAXNMP S5, V9.2S
    FMINP D0, V10.2D
    ADDP  D11, V8.2D
    FADDP S19, V20.2S
    UMAXP  V5.2S, V15.2S, V7.2S
    FMINP D31, V13.2D
    FMINP S30, V24.2S
    FMAXNMP D14, V25.2D
    FMAXP S27, V26.2S
    FMAXNMP D29, V22.2D
    FMINNMP S26, V31.2S
    FMAXP S29, V31.2S
    FMINP  V16.4S, V31.4S, V3.4S
    FMAXNMP D14, V28.2D
    FMINP  V22.4S, V6.4S, V10.4S
    UMINP  V31.4S, V30.4S, V21.4S
    FMINNMP D22, V8.2D
    FADDP  V20.2D, V24.2D, V25.2D
    FADDP D26, V5.2D
    FADDP  V5.2D, V14.2D, V16.2D
    FADDP S10, V27.2S
    FMINNMP D1, V27.2D
    FMINP  V12.4S, V28.4S, V19.4S
    FMAXNMP  V30.2S, V16.2S, V29.2S
    FADDP D31, V7.2D
    FMAXNMP S24, V20.2S
    FMINP  V27.4S, V7.4S, V0.4S
    FMAXP S11, V13.2S
    FMINNMP  V22.4S, V13.4S, V1.4S
    FADDP  V18.2D, V12.2D, V26.2D
    FMINP D22, V16.2D
    FMAXNMP  V14.4S, V28.4S, V5.4S
    FMINNMP S29, V24.2S
    FMAXP  V4.2S, V7.2S, V16.2S
    SMINP  V19.4H, V28.4H, V30.4H
    UMAXP  V10.8B, V22.8B, V20.8B
    FMAXNMP  V30.4S, V10.4S, V26.4S
    FMINP  V0.2D, V12.2D, V22.2D
    FMINNMP S20, V1.2S
    FMAXNMP  V11.2S, V30.2S, V18.2S
    FMINP S1, V13.2S
    UMAXP  V12.16B, V3.16B, V19.16B
    UMINP  V10.8H, V26.8H, V25.8H
    FMAXNMP D16, V18.2D
    FMINNMP D19, V24.2D
    SMAXP  V10.4S, V1.4S, V29.4S
    UMINP  V30.16B, V21.16B, V12.16B
    FADDP S3, V0.2S
    UMAXP  V21.8B, V22.8B, V13.8B
    FMINNMP D8, V22.2D
    FMINNMP S5, V12.2S
    FMAXNMP  V20.4S, V8.4S, V14.4S
    FMINP D30, V23.2D
    FMINP D19, V11.2D
    FADDP  V22.2S, V2.2S, V13.2S
    FMAXNMP S13, V26.2S
    FMINP S22, V15.2S
    ADDP  D1, V16.2D
    UMINP  V20.4H, V11.4H, V27.4H
    FADDP S2, V12.2S
    FMAXNMP D13, V30.2D
    FADDP  V1.2S, V29.2S, V21.2S
    FMINP  V21.2S, V25.2S, V23.2S
    FADDP  V2.4S, V9.4S, V21.4S
    FMINNMP S25, V4.2S
    FMINNMP D28, V12.2D
    FMINP S20, V23.2S
    ADDP  V19.2S, V31.2S, V20.2S
    FMINP  V4.2S, V27.2S, V23.2S
    FMAXNMP S26, V30.2S
    FMAXP  V20.2S, V10.2S, V16.2S
    FMAXP S13, V18.2S
    FMINNMP  V18.2D, V25.2D, V19.2D
    FMAXNMP  V26.2S, V6.2S, V26.2S
    FMAXNMP  V9.4S, V6.4S, V15.4S
    FADDP  V2.2S, V20.2S, V13.2S
    FMAXP S6, V26.2S
    FMAXP S27, V18.2S
    FADDP D15, V14.2D
    ADDP  V29.16B, V14.16B, V1.16B
    UMAXP  V28.4S, V7.4S, V10.4S
    FMINNMP D4, V23.2D
    FMAXNMP D19, V0.2D
    FMAXP S22, V10.2S
    UMAXP  V23.8B, V22.8B, V1.8B
    SMAXP  V27.4H, V6.4H, V1.4H
    UMINP  V10.16B, V15.16B, V4.16B
    FMAXP D17, V16.2D
    FMAXNMP S16, V10.2S
    SUBS  X8, X8, #0x1
    B.NE  TaishanSimdComplexP01_label_1282
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X2, X20, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X4
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X24, X25, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X8, X24, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X25, X20, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X20
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X22
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X12, X11, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X13, X24, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X21, X9, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X13, D2
    MOVZ  X9, #0x0, LSL #0
    SUB  X21, X9, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X16, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X25, X20, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X17, D4
    MOVZ  X20, #0x0, LSL #0
    SUB  X25, X20, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X9, D5
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X10, X18, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X13, D6
    MOVZ  X18, #0x0, LSL #0
    SUB  X10, X18, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X4, V7.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X4, D7
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X24, X7, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X23, D8
    MOVZ  X7, #0x0, LSL #0
    SUB  X24, X7, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X11, D9
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X13
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X13, D10
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X13
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X10, D11
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X24, X20, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X18, D12
    MOVZ  X20, #0x0, LSL #0
    SUB  X24, X20, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X24, V13.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X24, D13
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X4, X8, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X9, D14
    MOVZ  X8, #0x0, LSL #0
    SUB  X4, X8, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X7, X3, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X16, D15
    MOVZ  X3, #0x0, LSL #0
    SUB  X7, X3, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X12, X24, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X4, D16
    MOVZ  X24, #0x0, LSL #0
    SUB  X12, X24, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X18, X9, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X16, D17
    MOVZ  X9, #0x0, LSL #0
    SUB  X18, X9, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X5, V18.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X5, D18
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X25, V19.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X25, D19
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X2, D20
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X9, D21
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X4, D22
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X15, V23.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X15, D23
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X25, V24.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X25, D24
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X24
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X24, D25
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X24
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X15
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X15, D26
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X15
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X15, V28.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X15, D28
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X15, V29.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X15, D29
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
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
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X25
    FMOV  D1, X24
    FMOV  V1.D[1], X25
    FMOV  D2, X8
    FMOV  V2.D[1], X26
    FMOV  D3, X24
    FMOV  V3.D[1], X23
    FMOV  D4, X13
    FMOV  V4.D[1], X12
    FMOV  D5, X7
    FMOV  V5.D[1], X22
    FMOV  D6, X22
    FMOV  V6.D[1], X24
    FMOV  D7, X14
    FMOV  V7.D[1], X12
    FMOV  D8, X15
    FMOV  V8.D[1], X23
    FMOV  D9, X7
    FMOV  V9.D[1], X4
    FMOV  D10, X24
    FMOV  V10.D[1], X10
    FMOV  D11, X28
    FMOV  V11.D[1], X22
    FMOV  D12, X22
    FMOV  V12.D[1], X19
    FMOV  D13, X20
    FMOV  V13.D[1], X13
    FMOV  D14, X17
    FMOV  V14.D[1], X18
    FMOV  D15, X16
    FMOV  V15.D[1], X13
    FMOV  D16, X12
    FMOV  V16.D[1], X4
    FMOV  D17, X8
    FMOV  V17.D[1], X26
    FMOV  D18, X9
    FMOV  V18.D[1], X24
    FMOV  D19, X13
    FMOV  V19.D[1], X26
    FMOV  D20, X6
    FMOV  V20.D[1], X3
    FMOV  D21, X26
    FMOV  V21.D[1], X22
    FMOV  D22, X14
    FMOV  V22.D[1], X5
    FMOV  D23, X25
    FMOV  V23.D[1], X16
    FMOV  D24, X9
    FMOV  V24.D[1], X9
    FMOV  D25, X10
    FMOV  V25.D[1], X28
    FMOV  D26, X20
    FMOV  V26.D[1], X2
    FMOV  D27, X29
    FMOV  V27.D[1], X7
    FMOV  D28, X8
    FMOV  V28.D[1], X2
    FMOV  D29, X2
    FMOV  V29.D[1], X15
    FMOV  D30, X9
    FMOV  V30.D[1], X2
    FMOV  D31, X2
    FMOV  V31.D[1], X14
    MOVZ  X15, #0xf, LSL #0
TaishanSimdComplexP01_label_1355:
    FMINNMP D11, V8.2D
    FADDP D3, V19.2D
    FMAXNMP D25, V27.2D
    SMINP  V16.16B, V0.16B, V3.16B
    FADDP D25, V1.2D
    FMAXNMP D18, V14.2D
    SMINP  V24.4S, V25.4S, V8.4S
    FMAXNMP D24, V9.2D
    ADDP  D0, V23.2D
    FMINNMP  V6.2D, V31.2D, V4.2D
    ADDP  V24.8H, V27.8H, V9.8H
    FMAXNMP S1, V14.2S
    ADDP  V5.8B, V11.8B, V6.8B
    SMINP  V23.8H, V30.8H, V20.8H
    SMAXP  V10.8B, V10.8B, V25.8B
    FMINNMP D29, V4.2D
    ADDP  D8, V13.2D
    FADDP S22, V20.2S
    FADDP S7, V24.2S
    FMINNMP S10, V1.2S
    FMAXNMP D28, V17.2D
    FADDP  V30.2D, V19.2D, V22.2D
    FMINP  V17.2D, V21.2D, V2.2D
    UMAXP  V4.8B, V12.8B, V20.8B
    ADDP  V22.8H, V0.8H, V2.8H
    FMINNMP D12, V7.2D
    ADDP  V21.16B, V24.16B, V31.16B
    FMAXP D10, V21.2D
    ADDP  D25, V19.2D
    FMAXNMP D1, V31.2D
    ADDP  D26, V7.2D
    UMAXP  V29.4S, V29.4S, V28.4S
    FADDP  V21.2S, V26.2S, V14.2S
    FMAXP S21, V13.2S
    FADDP D7, V24.2D
    FMAXNMP S30, V2.2S
    FMAXP S17, V7.2S
    FMINP D31, V31.2D
    FMAXNMP D4, V26.2D
    ADDP  V21.2D, V29.2D, V4.2D
    FMAXP S9, V23.2S
    FADDP  V26.2S, V24.2S, V22.2S
    FADDP D6, V19.2D
    FMINP  V7.4S, V27.4S, V13.4S
    FADDP  V31.4S, V14.4S, V6.4S
    SMINP  V21.16B, V28.16B, V4.16B
    FADDP  V15.4S, V11.4S, V1.4S
    ADDP  V8.4S, V24.4S, V24.4S
    FMINNMP  V0.2D, V2.2D, V24.2D
    UMAXP  V16.4H, V2.4H, V26.4H
    FMINNMP  V5.2S, V18.2S, V7.2S
    SMINP  V9.8H, V21.8H, V20.8H
    ADDP  V2.4S, V4.4S, V25.4S
    ADDP  D17, V18.2D
    FMAXNMP S11, V4.2S
    FADDP S23, V27.2S
    ADDP  D13, V8.2D
    FADDP S30, V28.2S
    FMAXNMP S27, V2.2S
    FMINP S12, V8.2S
    FMINNMP  V12.2D, V2.2D, V20.2D
    SMINP  V26.2S, V20.2S, V5.2S
    UMINP  V7.4S, V28.4S, V7.4S
    FMINP D24, V0.2D
    FMAXNMP  V8.2D, V4.2D, V27.2D
    FMAXP S19, V6.2S
    FMAXNMP D22, V20.2D
    ADDP  V5.4S, V7.4S, V0.4S
    ADDP  D11, V5.2D
    FADDP  V7.4S, V3.4S, V4.4S
    FMAXNMP S28, V8.2S
    FMAXP S10, V17.2S
    UMAXP  V2.16B, V4.16B, V5.16B
    FMAXNMP S26, V10.2S
    UMINP  V26.2S, V27.2S, V12.2S
    FMINNMP  V16.2D, V7.2D, V12.2D
    FMINP  V15.2S, V5.2S, V12.2S
    FADDP  V24.2D, V12.2D, V27.2D
    FMINP D19, V30.2D
    ADDP  V4.4S, V4.4S, V22.4S
    FMAXNMP D2, V27.2D
    FMAXNMP  V19.4S, V3.4S, V17.4S
    FMINP  V14.2S, V7.2S, V5.2S
    FMAXP  V18.4S, V29.4S, V27.4S
    SMAXP  V4.16B, V28.16B, V23.16B
    FADDP S6, V22.2S
    ADDP  D16, V20.2D
    FMAXNMP D3, V18.2D
    SMINP  V20.8B, V28.8B, V2.8B
    FMINP S14, V7.2S
    FMINP D3, V21.2D
    SMINP  V17.4H, V3.4H, V31.4H
    FMAXP  V8.4S, V4.4S, V7.4S
    FADDP S16, V18.2S
    FMINP  V22.2S, V23.2S, V17.2S
    FMAXNMP D26, V15.2D
    UMAXP  V25.4H, V19.4H, V8.4H
    FADDP  V14.2S, V24.2S, V8.2S
    FMINP D29, V15.2D
    FMINP  V10.2S, V20.2S, V25.2S
    UMINP  V30.16B, V10.16B, V12.16B
    FMAXP  V26.4S, V24.4S, V17.4S
    FMINP S24, V26.2S
    UMAXP  V3.4S, V30.4S, V29.4S
    FMAXP  V24.2S, V3.2S, V12.2S
    SMAXP  V24.16B, V13.16B, V14.16B
    FMAXP  V24.2D, V16.2D, V17.2D
    FMINP S13, V9.2S
    FMINP S8, V15.2S
    FMAXNMP  V16.2D, V9.2D, V9.2D
    FMINNMP S27, V29.2S
    UMINP  V6.8H, V28.8H, V22.8H
    FMINNMP D11, V13.2D
    SMAXP  V6.16B, V31.16B, V12.16B
    FMINNMP D4, V7.2D
    FMAXNMP  V9.2S, V25.2S, V8.2S
    ADDP  D8, V12.2D
    ADDP  V12.8H, V19.8H, V1.8H
    FMAXP  V11.4S, V3.4S, V2.4S
    FADDP D1, V4.2D
    ADDP  D5, V9.2D
    FMINNMP  V28.2D, V5.2D, V11.2D
    FADDP  V26.2D, V29.2D, V30.2D
    ADDP  V29.2S, V25.2S, V11.2S
    ADDP  D26, V27.2D
    FMINNMP  V10.2D, V26.2D, V20.2D
    FADDP D17, V30.2D
    FADDP  V18.2D, V18.2D, V6.2D
    FMAXNMP S22, V0.2S
    FMINNMP D20, V6.2D
    FMINP D4, V24.2D
    FMAXNMP  V26.2S, V16.2S, V4.2S
    FADDP D29, V28.2D
    ADDP  V24.4H, V7.4H, V31.4H
    FMINP S31, V12.2S
    UMAXP  V23.2S, V16.2S, V11.2S
    FMAXNMP D19, V18.2D
    FMAXP D10, V8.2D
    FMAXNMP  V27.2S, V5.2S, V25.2S
    ADDP  D4, V17.2D
    FADDP S0, V6.2S
    ADDP  D15, V12.2D
    UMAXP  V0.16B, V8.16B, V14.16B
    FADDP  V17.2S, V20.2S, V11.2S
    FMINNMP  V18.2D, V5.2D, V21.2D
    UMINP  V22.4S, V7.4S, V24.4S
    ADDP  D31, V22.2D
    FADDP  V1.4S, V15.4S, V16.4S
    UMINP  V28.8H, V24.8H, V26.8H
    ADDP  D26, V0.2D
    UMAXP  V10.8B, V31.8B, V30.8B
    FMAXNMP  V24.4S, V30.4S, V24.4S
    FMAXNMP D14, V13.2D
    FADDP D13, V8.2D
    ADDP  D25, V18.2D
    SMAXP  V23.8H, V4.8H, V24.8H
    FMAXP D13, V1.2D
    FADDP  V7.2S, V29.2S, V25.2S
    SMINP  V17.4H, V27.4H, V23.4H
    FMAXNMP  V24.4S, V13.4S, V21.4S
    FMAXNMP D3, V31.2D
    SMINP  V28.8H, V9.8H, V28.8H
    FMINP  V16.4S, V0.4S, V6.4S
    ADDP  V9.2S, V16.2S, V10.2S
    UMAXP  V16.4H, V26.4H, V22.4H
    FMAXNMP S24, V11.2S
    FMAXP  V8.4S, V1.4S, V3.4S
    UMAXP  V27.4H, V0.4H, V22.4H
    SMAXP  V28.8B, V16.8B, V22.8B
    FMINNMP  V21.2S, V29.2S, V18.2S
    FADDP D23, V5.2D
    SMINP  V22.16B, V29.16B, V13.16B
    FMINP S15, V4.2S
    ADDP  V27.8H, V9.8H, V13.8H
    FADDP S23, V17.2S
    FMINNMP D28, V0.2D
    FADDP D28, V29.2D
    FMINP S2, V15.2S
    FMAXNMP  V31.2D, V17.2D, V0.2D
    FMINP D29, V28.2D
    FADDP D5, V21.2D
    FMINP  V15.2D, V25.2D, V23.2D
    FMINNMP D2, V22.2D
    FMAXP S30, V13.2S
    FMINNMP  V1.4S, V13.4S, V27.4S
    SMINP  V27.4S, V3.4S, V4.4S
    FMINNMP  V4.2D, V8.2D, V24.2D
    FADDP  V5.2S, V15.2S, V11.2S
    FMAXP D2, V1.2D
    FMINNMP S0, V8.2S
    FMAXP S31, V27.2S
    SMINP  V20.2S, V31.2S, V28.2S
    ADDP  D14, V20.2D
    ADDP  D0, V18.2D
    FADDP  V9.4S, V0.4S, V18.4S
    FMAXP  V5.2S, V8.2S, V13.2S
    FMAXNMP D28, V24.2D
    FMAXNMP  V24.2D, V17.2D, V24.2D
    FMINP  V23.4S, V2.4S, V29.4S
    UMAXP  V31.2S, V22.2S, V9.2S
    SUBS  X15, X15, #0x1
    B.NE  TaishanSimdComplexP01_label_1355
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X2, X29, X2
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X11, X12, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X11, X12, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X8, X24, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X16, X28, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X20, X11, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X6, X4, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X20, X8, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X11
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X29, X26, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X4, X21, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X22, X14, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X2, X22, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X7, X5, X17
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X9, X21, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X3, X21, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X20
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X18, X10, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X22
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X17, X25, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X24, X23, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X26, X17, X26
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X15, V2.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X15, D2
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X20, D3
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X18, X23, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X5, D4
    MOVZ  X23, #0x0, LSL #0
    SUB  X18, X23, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X21, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X21, D5
    MOVZ  X9, #0x1, LSL #0
    MOVK  X9, #0x1, LSL #32
    SUB  X7, X9, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X14, D6
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x1, LSL #32
    SUB  X29, X2, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X14, X6, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X24, D7
    MOVZ  X6, #0x0, LSL #0
    SUB  X14, X6, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X11, D8
    MOVZ  X2, #0x1, LSL #0
    SUB  X22, X2, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X10, D9
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X12, D10
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X23, D11
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X15, V12.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X11, X23, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X15, D12
    MOVZ  X23, #0x1, LSL #0
    SUB  X11, X23, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X28, D13
    MOVZ  X11, #0x1, LSL #0
    SUB  X17, X11, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X11, D14
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X6, V15.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X10, X2, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X6, D15
    MOVZ  X2, #0x0, LSL #0
    SUB  X10, X2, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X12, D16
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X10, D17
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X2, D18
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X21, V19.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X21, D19
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x1, LSL #32
    SUB  X12, X26, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X12, D20
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X15, D21
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X12, X10, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X4, D22
    MOVZ  X10, #0x0, LSL #0
    SUB  X12, X10, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X26, D23
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X16, D24
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X3, V25.D[1]
TaishanSimdComplexP01_label_1199:
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X3, D25
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X7, D26
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X24, V28.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X24, D28
TaishanSimdComplexP01_label_898:
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X10, D29
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    MOVZ  X2, #0x97e3, LSL #0
    MOVK  X2, #0xe51d, LSL #16
    MOVK  X2, #0x2adc, LSL #32
    MOVK  X2, #0x2134, LSL #48
    MOVZ  X3, #0x72b0, LSL #0
    MOVK  X3, #0x103c, LSL #16
    MOVK  X3, #0x8cf4, LSL #32
    MOVK  X3, #0xcb71, LSL #48
    MOVZ  X4, #0xd366, LSL #0
    MOVK  X4, #0x7a16, LSL #16
    MOVK  X4, #0x7fee, LSL #32
    MOVK  X4, #0x5575, LSL #48
    MOVZ  X5, #0x3fc4, LSL #0
    MOVK  X5, #0x66c7, LSL #16
    MOVK  X5, #0x3b11, LSL #32
    MOVK  X5, #0x8c42, LSL #48
    MOVZ  X6, #0x70ba, LSL #0
    MOVK  X6, #0x2c3e, LSL #16
    MOVK  X6, #0x804a, LSL #32
    MOVK  X6, #0x44c5, LSL #48
    MOVZ  X7, #0x415b, LSL #0
    MOVK  X7, #0xeeab, LSL #16
    MOVK  X7, #0x2f03, LSL #32
    MOVK  X7, #0x8465, LSL #48
    MOVZ  X8, #0xfa67, LSL #0
    MOVK  X8, #0x34b5, LSL #16
    MOVK  X8, #0x4bbb, LSL #32
    MOVK  X8, #0x2242, LSL #48
    MOVZ  X9, #0x17ef, LSL #0
    MOVK  X9, #0x18b0, LSL #16
    MOVK  X9, #0xa99c, LSL #32
    MOVK  X9, #0xc557, LSL #48
    MOVZ  X10, #0x5539, LSL #0
    MOVK  X10, #0x5ca2, LSL #16
    MOVK  X10, #0xa8ad, LSL #32
    MOVK  X10, #0xeced, LSL #48
    MOVZ  X11, #0x61bc, LSL #0
    MOVK  X11, #0x8eae, LSL #16
    MOVK  X11, #0xf05f, LSL #32
    MOVK  X11, #0xf82b, LSL #48
    MOVZ  X12, #0x59de, LSL #0
    MOVK  X12, #0xa0c6, LSL #16
    MOVK  X12, #0x5aa0, LSL #32
    MOVK  X12, #0xc44f, LSL #48
    MOVZ  X13, #0x4944, LSL #0
    MOVK  X13, #0xf106, LSL #16
    MOVK  X13, #0xae55, LSL #32
    MOVK  X13, #0xcdb9, LSL #48
    MOVZ  X14, #0x929b, LSL #0
    MOVK  X14, #0xf800, LSL #16
    MOVK  X14, #0x4ae2, LSL #32
    MOVK  X14, #0x4e20, LSL #48
    MOVZ  X15, #0xb3e5, LSL #0
    MOVK  X15, #0x5934, LSL #16
    MOVK  X15, #0xf9f0, LSL #32
    MOVK  X15, #0x51cb, LSL #48
    MOVZ  X16, #0xeeac, LSL #0
    MOVK  X16, #0xf8b3, LSL #16
    MOVK  X16, #0xf59e, LSL #32
    MOVK  X16, #0x3aef, LSL #48
    MOVZ  X17, #0x70e7, LSL #0
    MOVK  X17, #0xe5ce, LSL #16
    MOVK  X17, #0x97f, LSL #32
    MOVK  X17, #0x9d8a, LSL #48
    MOVZ  X18, #0xde44, LSL #0
    MOVK  X18, #0x673, LSL #16
    MOVK  X18, #0x9262, LSL #32
    MOVK  X18, #0x6fb4, LSL #48
    MOVZ  X19, #0x274d, LSL #0
    MOVK  X19, #0xb61c, LSL #16
    MOVK  X19, #0x235d, LSL #32
    MOVK  X19, #0x490a, LSL #48
    MOVZ  X20, #0x6c1f, LSL #0
    MOVK  X20, #0x4d77, LSL #16
    MOVK  X20, #0x93d4, LSL #32
    MOVK  X20, #0xe100, LSL #48
    MOVZ  X21, #0x1366, LSL #0
    MOVK  X21, #0xdae3, LSL #16
    MOVK  X21, #0xc893, LSL #32
    MOVK  X21, #0xc52, LSL #48
    MOVZ  X22, #0xe4f4, LSL #0
    MOVK  X22, #0x9b8b, LSL #16
    MOVK  X22, #0x6710, LSL #32
    MOVK  X22, #0x29c8, LSL #48
    MOVZ  X23, #0x46d8, LSL #0
    MOVK  X23, #0x8327, LSL #16
    MOVK  X23, #0x68dd, LSL #32
    MOVK  X23, #0xe690, LSL #48
    MOVZ  X24, #0xe891, LSL #0
    MOVK  X24, #0xdce2, LSL #16
    MOVK  X24, #0x7627, LSL #32
    MOVK  X24, #0x1751, LSL #48
    MOVZ  X25, #0xaa6d, LSL #0
    MOVK  X25, #0xf8ed, LSL #16
    MOVK  X25, #0x7ab3, LSL #32
    MOVK  X25, #0x152c, LSL #48
    MOVZ  X26, #0x624d, LSL #0
    MOVK  X26, #0x7c84, LSL #16
    MOVK  X26, #0x1948, LSL #32
    MOVK  X26, #0xf36a, LSL #48
    MOVZ  X28, #0x3a47, LSL #0
    MOVK  X28, #0xa75d, LSL #16
    MOVK  X28, #0x63a0, LSL #32
    MOVK  X28, #0xb130, LSL #48
    MOVZ  X29, #0xf141, LSL #0
    MOVK  X29, #0x3bbc, LSL #16
    MOVK  X29, #0xfde2, LSL #32
    MOVK  X29, #0x4152, LSL #48
    FMOV  D0, X15
    FMOV  V0.D[1], X17
    FMOV  D1, X10
    FMOV  V1.D[1], X17
    FMOV  D2, X25
    FMOV  V2.D[1], X24
    FMOV  D3, X29
    FMOV  V3.D[1], X26
    FMOV  D4, X15
    FMOV  V4.D[1], X5
    FMOV  D5, X2
    FMOV  V5.D[1], X6
    FMOV  D6, X2
    FMOV  V6.D[1], X10
    FMOV  D7, X14
    FMOV  V7.D[1], X10
    FMOV  D8, X15
    FMOV  V8.D[1], X6
    FMOV  D9, X19
    FMOV  V9.D[1], X22
    FMOV  D10, X11
    FMOV  V10.D[1], X5
    FMOV  D11, X2
    FMOV  V11.D[1], X17
    FMOV  D12, X20
    FMOV  V12.D[1], X2
    FMOV  D13, X29
    FMOV  V13.D[1], X8
    FMOV  D14, X12
    FMOV  V14.D[1], X25
    FMOV  D15, X29
    FMOV  V15.D[1], X9
    FMOV  D16, X3
    FMOV  V16.D[1], X13
    FMOV  D17, X28
    FMOV  V17.D[1], X13
    FMOV  D18, X10
    FMOV  V18.D[1], X13
    FMOV  D19, X28
    FMOV  V19.D[1], X12
    FMOV  D20, X11
    FMOV  V20.D[1], X3
    FMOV  D21, X22
    FMOV  V21.D[1], X19
    FMOV  D22, X10
    FMOV  V22.D[1], X5
    FMOV  D23, X9
    FMOV  V23.D[1], X28
    FMOV  D24, X3
    FMOV  V24.D[1], X24
    FMOV  D25, X2
    FMOV  V25.D[1], X7
    FMOV  D26, X18
    FMOV  V26.D[1], X15
    FMOV  D27, X13
    FMOV  V27.D[1], X11
    FMOV  D28, X17
    FMOV  V28.D[1], X3
    FMOV  D29, X28
    FMOV  V29.D[1], X20
    FMOV  D30, X7
    FMOV  V30.D[1], X24
    FMOV  D31, X26
    FMOV  V31.D[1], X4
    MOVZ  X20, #0xa, LSL #0
TaishanSimdComplexP01_label_1430:
    FMINNMP  V22.4S, V23.4S, V17.4S
    FMAXNMP S24, V1.2S
    FMINP D4, V27.2D
    FMINNMP S13, V19.2S
    FMAXP  V6.2D, V0.2D, V22.2D
    SMINP  V11.4H, V30.4H, V11.4H
    FMINP  V10.4S, V16.4S, V12.4S
    ADDP  D5, V9.2D
    FMAXP D26, V2.2D
    FMINNMP  V2.2D, V2.2D, V14.2D
    UMAXP  V9.8B, V15.8B, V31.8B
    FMINNMP S22, V14.2S
    FADDP S21, V16.2S
    FMAXNMP  V22.2D, V0.2D, V27.2D
    FMINNMP D2, V29.2D
    FMINNMP  V13.4S, V14.4S, V24.4S
    FMAXP  V28.4S, V20.4S, V31.4S
    FMAXNMP S2, V21.2S
    FMAXNMP D6, V24.2D
    UMINP  V10.4S, V12.4S, V5.4S
    ADDP  D12, V12.2D
    FMINNMP  V30.2S, V29.2S, V13.2S
    FADDP  V28.2S, V11.2S, V18.2S
    FADDP D15, V0.2D
    ADDP  V14.8B, V28.8B, V29.8B
    FMAXNMP  V5.2S, V14.2S, V9.2S
    FMINP  V25.2D, V4.2D, V22.2D
    FMINP S14, V22.2S
    ADDP  D23, V19.2D
    FMINNMP D19, V28.2D
    FADDP S16, V16.2S
    FMINNMP S30, V12.2S
    FMINNMP D0, V31.2D
    FMAXNMP S26, V2.2S
    FMINP  V29.2D, V11.2D, V29.2D
    ADDP  D30, V3.2D
    FMAXNMP  V0.2D, V21.2D, V12.2D
    UMAXP  V0.4S, V18.4S, V21.4S
    FMAXP S6, V20.2S
    SMINP  V13.4S, V24.4S, V26.4S
    FMAXP  V26.2S, V14.2S, V31.2S
    FMAXP S19, V6.2S
    FMAXP D16, V8.2D
    FADDP  V14.4S, V12.4S, V9.4S
    SMINP  V2.8H, V26.8H, V20.8H
    FADDP  V31.4S, V23.4S, V0.4S
    FMAXP S4, V29.2S
    FMAXNMP S22, V11.2S
    SMINP  V19.8H, V24.8H, V3.8H
    FMAXNMP  V25.2S, V31.2S, V30.2S
    FADDP D13, V21.2D
    ADDP  V23.8H, V5.8H, V13.8H
    SMAXP  V25.8H, V0.8H, V14.8H
    FMINP D24, V9.2D
    FMINNMP D6, V15.2D
    FMINP S13, V19.2S
    FMINP D5, V13.2D
    FMINNMP  V19.2S, V4.2S, V29.2S
    ADDP  D0, V15.2D
    FMAXP  V6.4S, V12.4S, V16.4S
    FMINNMP S22, V2.2S
    SMAXP  V0.4H, V22.4H, V23.4H
    FMINP D17, V7.2D
    FADDP  V0.4S, V17.4S, V25.4S
    FMINNMP  V24.2D, V7.2D, V24.2D
    FADDP S15, V13.2S
    UMINP  V27.4H, V9.4H, V18.4H
    FMAXP S21, V26.2S
    FMINNMP S3, V21.2S
    FMINNMP S27, V3.2S
    FMAXP  V5.2S, V23.2S, V27.2S
    FMINP S8, V13.2S
    FMAXP D2, V28.2D
    SMINP  V24.8B, V22.8B, V16.8B
    FADDP S20, V6.2S
    FMAXP S10, V26.2S
    SMINP  V8.2S, V19.2S, V0.2S
    FADDP S24, V22.2S
    FMAXNMP  V2.2D, V1.2D, V25.2D
    FMINNMP D23, V2.2D
    FMAXP S0, V21.2S
    FMINNMP S17, V14.2S
    FMINNMP D12, V21.2D
    FMINP S5, V23.2S
    FMAXNMP S23, V6.2S
    FMAXNMP S6, V14.2S
    FMINNMP D26, V20.2D
    FMAXP D14, V3.2D
    FMAXNMP D16, V10.2D
    FMAXP S6, V25.2S
    FMINNMP S19, V0.2S
    FADDP  V15.2D, V18.2D, V22.2D
    FMAXP  V15.4S, V13.4S, V8.4S
    FMAXP D18, V4.2D
    FMINP  V6.2S, V31.2S, V22.2S
    FMINP  V19.4S, V28.4S, V8.4S
    FMINNMP  V7.2S, V0.2S, V0.2S
    FADDP S15, V10.2S
    FMAXP D19, V4.2D
    SMAXP  V23.16B, V30.16B, V11.16B
    SMAXP  V8.8H, V16.8H, V0.8H
    UMINP  V23.16B, V24.16B, V24.16B
    FADDP D27, V9.2D
    ADDP  D11, V20.2D
    FADDP S28, V26.2S
    FMAXP  V6.4S, V18.4S, V10.4S
    SMINP  V16.4H, V19.4H, V13.4H
    FMAXNMP S21, V24.2S
    FMINP  V10.4S, V6.4S, V2.4S
    FMINP D14, V7.2D
    SMAXP  V22.8H, V13.8H, V14.8H
    FMAXNMP  V15.2S, V20.2S, V8.2S
    FMINNMP  V15.2S, V24.2S, V12.2S
    FADDP D13, V10.2D
    FADDP D12, V28.2D
    ADDP  D6, V22.2D
    FADDP S9, V26.2S
    UMINP  V0.4S, V28.4S, V0.4S
    FADDP S30, V14.2S
    UMAXP  V7.8B, V24.8B, V5.8B
    FMAXNMP D4, V4.2D
    FMAXP S31, V3.2S
    FADDP D16, V21.2D
    FMAXP S6, V10.2S
    SMAXP  V31.4S, V5.4S, V1.4S
    FADDP S31, V10.2S
    FMINP D20, V29.2D
    FMAXNMP  V17.2D, V3.2D, V28.2D
    FMINP S10, V11.2S
    FMINP  V5.2S, V13.2S, V20.2S
    FADDP D22, V15.2D
    FADDP S1, V22.2S
    FMINP  V26.2D, V27.2D, V27.2D
    FMAXNMP  V1.2S, V30.2S, V4.2S
    FMAXP D7, V16.2D
    ADDP  V25.16B, V0.16B, V1.16B
    ADDP  D24, V9.2D
    FMINP D15, V17.2D
    FMAXNMP  V7.2D, V24.2D, V26.2D
    FADDP D9, V0.2D
    FADDP  V18.2D, V7.2D, V29.2D
    FMAXNMP S26, V10.2S
    FMINP  V10.4S, V30.4S, V31.4S
    FMINP D1, V2.2D
    ADDP  D0, V15.2D
    FADDP S28, V13.2S
    SMAXP  V22.4H, V28.4H, V2.4H
    FADDP D5, V9.2D
    SMAXP  V17.2S, V17.2S, V9.2S
    FADDP S9, V21.2S
    FMINNMP S20, V26.2S
    FMAXP S9, V6.2S
    FADDP D2, V20.2D
    SMAXP  V9.8H, V5.8H, V25.8H
    ADDP  D12, V20.2D
    FMAXP S3, V20.2S
    FMAXNMP S8, V1.2S
    FADDP S21, V2.2S
    FMINP  V16.2D, V13.2D, V26.2D
    FADDP D24, V16.2D
    FMAXP S30, V25.2S
    UMAXP  V25.16B, V8.16B, V19.16B
    FADDP  V17.4S, V31.4S, V2.4S
    FMAXNMP S17, V21.2S
    UMINP  V0.4H, V18.4H, V16.4H
    SMINP  V9.2S, V2.2S, V3.2S
    FADDP  V30.2D, V13.2D, V20.2D
    FMINNMP D28, V5.2D
    FADDP S12, V7.2S
    FMINP  V1.2S, V5.2S, V8.2S
    FMINNMP D31, V13.2D
    FADDP D27, V28.2D
    FMAXP S4, V20.2S
    FMINNMP D18, V7.2D
    FMAXP  V31.2D, V2.2D, V27.2D
    FMINNMP D13, V10.2D
    FMAXP S4, V5.2S
    ADDP  V10.8H, V3.8H, V12.8H
    FMINNMP D0, V2.2D
    FMINP  V7.2S, V3.2S, V18.2S
    FMINNMP D24, V10.2D
    SMINP  V24.8H, V24.8H, V19.8H
    FMAXNMP S7, V0.2S
    FADDP  V24.4S, V20.4S, V17.4S
    FMINNMP S3, V9.2S
    FMINNMP D27, V18.2D
    UMAXP  V7.4H, V22.4H, V2.4H
    UMINP  V10.8H, V21.8H, V15.8H
    SMINP  V3.8H, V11.8H, V23.8H
    ADDP  V20.4H, V5.4H, V4.4H
    SMINP  V25.4S, V20.4S, V15.4S
    ADDP  V17.8H, V12.8H, V16.8H
    FMAXP S24, V14.2S
    FMAXP S4, V11.2S
    FMAXP  V29.4S, V13.4S, V14.4S
    FMINP  V1.2D, V20.2D, V31.2D
    FMINNMP S1, V27.2S
    FMINP  V31.2D, V10.2D, V27.2D
    ADDP  V20.16B, V28.16B, V10.16B
    FMAXP S26, V6.2S
    SUBS  X20, X20, #0x1
    B.NE  TaishanSimdComplexP01_label_1430
    MOVZ  X15, #0x97e3, LSL #0
    MOVK  X15, #0xe51d, LSL #16
    MOVK  X15, #0x2adc, LSL #32
    MOVK  X15, #0x2134, LSL #48
    SUB  X11, X15, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    MOVZ  X4, #0x72b0, LSL #0
    MOVK  X4, #0x103c, LSL #16
    MOVK  X4, #0x8cf4, LSL #32
    MOVK  X4, #0xcb71, LSL #48
    SUB  X10, X4, X3
TaishanSimdComplexP01_label_140:
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    MOVZ  X28, #0x72b0, LSL #0
    MOVK  X28, #0x103c, LSL #16
    MOVK  X28, #0x8cf4, LSL #32
    MOVK  X28, #0xcb71, LSL #48
    SUB  X2, X28, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    MOVZ  X14, #0x3fc4, LSL #0
    MOVK  X14, #0x66c7, LSL #16
    MOVK  X14, #0x3b11, LSL #32
    MOVK  X14, #0x8c42, LSL #48
    SUB  X24, X14, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    MOVZ  X28, #0x70ba, LSL #0
    MOVK  X28, #0x2c3e, LSL #16
    MOVK  X28, #0x804a, LSL #32
    MOVK  X28, #0x44c5, LSL #48
    SUB  X8, X28, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    MOVZ  X26, #0x415b, LSL #0
    MOVK  X26, #0xeeab, LSL #16
    MOVK  X26, #0x2f03, LSL #32
    MOVK  X26, #0x8465, LSL #48
    SUB  X16, X26, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0x17ef, LSL #0
    MOVK  X24, #0x18b0, LSL #16
    MOVK  X24, #0xa99c, LSL #32
    MOVK  X24, #0xc557, LSL #48
    SUB  X28, X24, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    MOVZ  X19, #0x59de, LSL #0
    MOVK  X19, #0xa0c6, LSL #16
    MOVK  X19, #0x5aa0, LSL #32
    MOVK  X19, #0xc44f, LSL #48
    SUB  X6, X19, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    MOVZ  X25, #0x3fc4, LSL #0
    MOVK  X25, #0x66c7, LSL #16
    MOVK  X25, #0x3b11, LSL #32
    MOVK  X25, #0x8c42, LSL #48
    SUB  X29, X25, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    MOVZ  X15, #0x97e3, LSL #0
    MOVK  X15, #0xe51d, LSL #16
    MOVK  X15, #0x2adc, LSL #32
    MOVK  X15, #0x2134, LSL #48
    SUB  X11, X15, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X26, X23, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    MOVZ  X12, #0x70e7, LSL #0
    MOVK  X12, #0xe5ce, LSL #16
    MOVK  X12, #0x97f, LSL #32
    MOVK  X12, #0x9d8a, LSL #48
    SUB  X24, X12, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    MOVZ  X19, #0xde44, LSL #0
    MOVK  X19, #0x673, LSL #16
    MOVK  X19, #0x9262, LSL #32
    MOVK  X19, #0x6fb4, LSL #48
    SUB  X23, X19, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    MOVZ  X12, #0xde44, LSL #0
    MOVK  X12, #0x673, LSL #16
    MOVK  X12, #0x9262, LSL #32
    MOVK  X12, #0x6fb4, LSL #48
    SUB  X3, X12, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X20
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    MOVZ  X7, #0xe4f4, LSL #0
    MOVK  X7, #0x9b8b, LSL #16
    MOVK  X7, #0x6710, LSL #32
    MOVK  X7, #0x29c8, LSL #48
    SUB  X25, X7, X22
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X3, X28, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X25
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X28, D2
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X19, V3.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X19, D3
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X9, D4
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X2, D5
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X11, D6
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X26, D7
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X14, D8
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    FMOV  X22, V9.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X22
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X22, D9
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X22
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X5, V10.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X5, D10
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X20, D11
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X11, D12
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X2, D13
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X18, V14.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X18
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X18, D14
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X18
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X5, X16, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X8, D15
    MOVZ  X16, #0x0, LSL #0
    SUB  X5, X16, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X6, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X24, D17
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X9
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X9, D18
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X9
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X2, D19
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X12
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X12, D20
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X12
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X23
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X23, D21
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X23
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X13, D22
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X29, D23
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X3, D24
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X7, D25
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X4, V26.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X4, D26
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X23, D28
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X12, D29
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
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
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X21
    FMOV  V0.D[1], X14
    FMOV  D1, X22
    FMOV  V1.D[1], X8
    FMOV  D2, X17
    FMOV  V2.D[1], X15
    FMOV  D3, X19
    FMOV  V3.D[1], X10
    FMOV  D4, X13
    FMOV  V4.D[1], X22
    FMOV  D5, X7
    FMOV  V5.D[1], X7
    FMOV  D6, X5
    FMOV  V6.D[1], X15
    FMOV  D7, X6
    FMOV  V7.D[1], X8
    FMOV  D8, X26
    FMOV  V8.D[1], X13
    FMOV  D9, X20
    FMOV  V9.D[1], X28
    FMOV  D10, X11
    FMOV  V10.D[1], X18
    FMOV  D11, X13
    FMOV  V11.D[1], X10
    FMOV  D12, X6
    FMOV  V12.D[1], X4
    FMOV  D13, X29
    FMOV  V13.D[1], X26
    FMOV  D14, X22
    FMOV  V14.D[1], X6
    FMOV  D15, X11
    FMOV  V15.D[1], X16
    FMOV  D16, X18
    FMOV  V16.D[1], X15
    FMOV  D17, X8
    FMOV  V17.D[1], X24
    FMOV  D18, X7
    FMOV  V18.D[1], X8
    FMOV  D19, X9
    FMOV  V19.D[1], X19
    FMOV  D20, X8
    FMOV  V20.D[1], X26
    FMOV  D21, X5
    FMOV  V21.D[1], X2
    FMOV  D22, X20
    FMOV  V22.D[1], X11
    FMOV  D23, X25
    FMOV  V23.D[1], X25
    FMOV  D24, X5
    FMOV  V24.D[1], X22
    FMOV  D25, X7
    FMOV  V25.D[1], X7
    FMOV  D26, X26
    FMOV  V26.D[1], X22
    FMOV  D27, X8
    FMOV  V27.D[1], X20
    FMOV  D28, X29
    FMOV  V28.D[1], X17
    FMOV  D29, X16
    FMOV  V29.D[1], X4
    FMOV  D30, X22
    FMOV  V30.D[1], X2
    FMOV  D31, X9
    FMOV  V31.D[1], X22
    MOVZ  X13, #0xa, LSL #0
TaishanSimdComplexP01_label_1505:
    UMINP  V25.4S, V28.4S, V2.4S
    FMAXP  V8.2S, V1.2S, V16.2S
    FADDP S0, V10.2S
    FMAXNMP  V31.2D, V1.2D, V29.2D
    ADDP  V6.4S, V7.4S, V24.4S
    FMINP S6, V28.2S
    FMAXNMP D4, V27.2D
    FMINNMP S24, V25.2S
    FMINP  V23.2S, V17.2S, V11.2S
    SMINP  V11.4H, V4.4H, V10.4H
    UMAXP  V23.16B, V15.16B, V17.16B
    FMAXP D5, V6.2D
    UMINP  V13.4S, V17.4S, V21.4S
    UMINP  V15.2S, V31.2S, V12.2S
    FMINP S16, V10.2S
    FMINNMP  V5.4S, V17.4S, V9.4S
    FADDP D28, V5.2D
    FMAXNMP  V30.4S, V27.4S, V13.4S
    FMAXP  V4.2D, V21.2D, V26.2D
    SMAXP  V2.4S, V21.4S, V26.4S
    FMAXP S27, V19.2S
    FMAXP S0, V2.2S
    FADDP  V0.2S, V1.2S, V11.2S
    SMINP  V12.16B, V23.16B, V27.16B
    ADDP  D29, V30.2D
    FMAXNMP  V28.4S, V4.4S, V2.4S
    FMINNMP  V4.2S, V4.2S, V31.2S
    SMAXP  V24.8H, V0.8H, V8.8H
    FMAXP S12, V31.2S
    FMAXNMP S24, V27.2S
    FMINP  V31.4S, V16.4S, V29.4S
    UMAXP  V2.2S, V26.2S, V20.2S
    SMINP  V12.4S, V28.4S, V4.4S
    SMINP  V15.8B, V15.8B, V23.8B
    FADDP S7, V0.2S
    FMAXNMP S17, V30.2S
    FMINNMP D30, V4.2D
    FADDP D5, V11.2D
    ADDP  V7.4S, V25.4S, V21.4S
    FMINP  V25.2D, V2.2D, V7.2D
    FMAXP D5, V4.2D
    FMINP  V24.2D, V4.2D, V29.2D
    FMAXP  V31.2S, V21.2S, V14.2S
    FMINP S12, V19.2S
    UMINP  V10.8H, V25.8H, V0.8H
    FMAXNMP S26, V1.2S
    ADDP  V10.4H, V1.4H, V10.4H
    ADDP  V6.2S, V11.2S, V4.2S
    FMINNMP D15, V20.2D
    FMAXNMP S26, V28.2S
    FMAXP S29, V7.2S
    FMINP S11, V1.2S
    FMAXP S9, V19.2S
    FMINNMP D30, V9.2D
    FMAXNMP  V20.4S, V17.4S, V28.4S
    FMINNMP S13, V0.2S
    UMAXP  V8.4H, V0.4H, V15.4H
    FMAXP  V23.4S, V7.4S, V4.4S
    UMAXP  V17.8H, V3.8H, V6.8H
    FMAXP  V14.2S, V2.2S, V31.2S
    FMINP D26, V11.2D
    FMINP  V4.2S, V13.2S, V13.2S
    FMINP D7, V1.2D
    FADDP D14, V30.2D
    FMINNMP  V1.2D, V23.2D, V1.2D
    FMINNMP S1, V4.2S
    FMAXNMP  V19.2D, V12.2D, V3.2D
    FMAXP S28, V5.2S
    SMINP  V6.4H, V4.4H, V5.4H
    FMINP S12, V21.2S
    FMINNMP S8, V2.2S
    SMAXP  V14.8H, V13.8H, V3.8H
    SMAXP  V16.4S, V24.4S, V20.4S
    UMAXP  V7.16B, V20.16B, V28.16B
    FADDP  V6.2D, V10.2D, V27.2D
    FMAXNMP S6, V13.2S
    UMINP  V13.16B, V16.16B, V7.16B
    FMINNMP D5, V10.2D
    FMAXP D7, V21.2D
    FMINP D29, V21.2D
    FMINNMP D4, V20.2D
    FADDP D19, V6.2D
    FMAXP  V5.4S, V7.4S, V6.4S
    FADDP  V1.2S, V25.2S, V23.2S
    FMAXP  V13.2S, V11.2S, V15.2S
    SMAXP  V17.4S, V20.4S, V31.4S
    FADDP S30, V24.2S
    FMAXNMP D14, V15.2D
    FMINNMP D30, V4.2D
    FMINP S16, V28.2S
    ADDP  V30.2D, V27.2D, V19.2D
    SMAXP  V30.16B, V3.16B, V24.16B
    FMINNMP D19, V18.2D
    FMAXNMP S21, V14.2S
    FMINNMP  V13.4S, V9.4S, V10.4S
    UMINP  V30.4S, V2.4S, V11.4S
    FMINP D21, V27.2D
    SMINP  V1.8B, V17.8B, V5.8B
    FMAXP D29, V11.2D
    FMAXNMP D8, V3.2D
    FADDP D16, V24.2D
    FADDP S7, V28.2S
    UMINP  V10.4H, V8.4H, V21.4H
    FMAXP S10, V7.2S
    FMINP S5, V9.2S
    FADDP S21, V1.2S
    FMINNMP D19, V5.2D
    SMAXP  V20.4H, V24.4H, V27.4H
    FMAXNMP D10, V0.2D
    FMINP S30, V30.2S
    FADDP D14, V10.2D
    SMINP  V6.8H, V21.8H, V12.8H
    SMAXP  V16.16B, V16.16B, V2.16B
    FADDP S6, V25.2S
    FADDP D16, V7.2D
    SMAXP  V2.2S, V16.2S, V8.2S
    FADDP  V25.2S, V17.2S, V28.2S
    ADDP  V25.8H, V12.8H, V1.8H
    FMAXNMP D26, V21.2D
    SMINP  V1.2S, V8.2S, V5.2S
    FMINP  V21.2S, V13.2S, V2.2S
    FMINP  V25.2S, V31.2S, V3.2S
    FMINP D20, V23.2D
    FMINNMP S4, V9.2S
    ADDP  V14.8H, V19.8H, V29.8H
    FMINNMP S1, V29.2S
    UMAXP  V14.8B, V5.8B, V30.8B
    FADDP S12, V9.2S
    SMINP  V9.8B, V29.8B, V14.8B
    FADDP  V20.4S, V7.4S, V30.4S
    UMINP  V5.4H, V14.4H, V6.4H
    SMINP  V20.2S, V6.2S, V19.2S
    FMINNMP D0, V2.2D
    FMINP S25, V10.2S
    FMAXNMP D25, V28.2D
    FMINNMP  V10.2S, V28.2S, V4.2S
    FMAXNMP  V1.2D, V9.2D, V12.2D
    FMAXP  V2.4S, V21.4S, V2.4S
    FMINNMP S5, V8.2S
    FMAXNMP  V16.4S, V19.4S, V14.4S
    FMAXP  V19.4S, V12.4S, V8.4S
    ADDP  V1.2S, V21.2S, V21.2S
    FMAXNMP S29, V1.2S
    SMINP  V11.4S, V9.4S, V2.4S
    SMINP  V26.8H, V2.8H, V0.8H
    UMINP  V20.8H, V23.8H, V10.8H
    FADDP S1, V3.2S
    UMAXP  V21.8B, V25.8B, V14.8B
    SMAXP  V26.4H, V5.4H, V31.4H
    FMINNMP  V14.2S, V8.2S, V26.2S
    FADDP D28, V29.2D
    FADDP  V9.2S, V25.2S, V28.2S
    FADDP S20, V11.2S
    FADDP  V15.2D, V9.2D, V21.2D
    FMINP S15, V11.2S
    UMAXP  V26.4H, V30.4H, V14.4H
    FADDP D18, V28.2D
    FMAXNMP S21, V11.2S
    UMAXP  V28.8H, V22.8H, V7.8H
    ADDP  D1, V1.2D
    FMINNMP D26, V21.2D
    FMINNMP S22, V20.2S
    UMAXP  V15.2S, V28.2S, V22.2S
    SMINP  V28.8B, V9.8B, V9.8B
    FMAXNMP  V0.2D, V21.2D, V25.2D
    ADDP  D23, V13.2D
    FMAXNMP  V31.2D, V23.2D, V7.2D
    UMAXP  V28.8H, V31.8H, V28.8H
    FMINP S19, V7.2S
    UMAXP  V13.8H, V31.8H, V31.8H
    FMINNMP D18, V15.2D
    FMAXP D28, V0.2D
    FMAXNMP S13, V11.2S
    FMINP D20, V22.2D
    FMINP D13, V15.2D
    ADDP  D6, V26.2D
    FMINNMP  V13.2S, V29.2S, V19.2S
    FMINP S31, V28.2S
    SMAXP  V3.16B, V14.16B, V30.16B
    FMINNMP D30, V5.2D
    FMINP S19, V7.2S
    FADDP D13, V10.2D
    FMAXNMP D12, V13.2D
    FMINP S5, V12.2S
    FMAXNMP S6, V7.2S
    FMAXNMP S26, V25.2S
    FMAXP S24, V21.2S
    SMAXP  V5.4S, V10.4S, V24.4S
    SMAXP  V8.2S, V12.2S, V14.2S
    FMAXP S8, V15.2S
    FMAXNMP D31, V11.2D
    FMINNMP S28, V30.2S
    ADDP  V10.4H, V29.4H, V6.4H
    FMINNMP S25, V15.2S
TaishanSimdComplexP01_label_139:
    UMAXP  V28.16B, V13.16B, V24.16B
    FMINNMP S5, V28.2S
    FMAXNMP S15, V5.2S
    ADDP  D7, V21.2D
    UMINP  V25.16B, V29.16B, V9.16B
    ADDP  V22.2S, V31.2S, V8.2S
    SUBS  X13, X13, #0x1
    B.NE  TaishanSimdComplexP01_label_1505
TaishanSimdComplexP01_label_231:
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X24, X9, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X20, X17, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X23, X21, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X2, X29, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X8, X9, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X22
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X23
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X26, X13, X26
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdComplexP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    FMOV  X19, V2.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X13, X12, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X19, D2
    MOVZ  X12, #0x0, LSL #0
    SUB  X13, X12, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X8, X2, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X11, D3
    MOVZ  X2, #0x0, LSL #0
    SUB  X8, X2, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X6, D4
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X21, V5.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X11, X23, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X21, D5
    MOVZ  X23, #0x0, LSL #0
    SUB  X11, X23, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X7, D6
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X13, D7
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X28, D8
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X22, V9.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X22, D9
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X6, D10
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X18, X21, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X23, D11
    MOVZ  X21, #0x0, LSL #0
    SUB  X18, X21, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X18, D12
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X11, D13
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    FMOV  X26, D14
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdComplexP01_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X9, D15
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X23, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X19, V17.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X19, D17
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X21, V18.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X21, D18
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X22, V19.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X22, D19
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X3, V20.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X22, X23, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X3, D20
    MOVZ  X23, #0x0, LSL #0
    SUB  X22, X23, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    FMOV  X28, V21.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X28, D21
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X14, X6, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X24, D22
    MOVZ  X6, #0x0, LSL #0
    SUB  X14, X6, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X6, D23
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X2, D24
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdComplexP01_TestFail
    FMOV  X21, V25.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X21, D25
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X15, D26
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X4, D28
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X20, X13, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X16, D29
    MOVZ  X13, #0x0, LSL #0
    SUB  X20, X13, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
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
    MOVZ  X19, #0xffff, LSL #0
TaishanSimdComplexP01_label_802:
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
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X11
    FMOV  D1, X13
    FMOV  V1.D[1], X24
    FMOV  D2, X6
    FMOV  V2.D[1], X29
    FMOV  D3, X14
    FMOV  V3.D[1], X25
    FMOV  D4, X26
    FMOV  V4.D[1], X23
    FMOV  D5, X3
    FMOV  V5.D[1], X11
    FMOV  D6, X20
    FMOV  V6.D[1], X18
    FMOV  D7, X25
    FMOV  V7.D[1], X11
    FMOV  D8, X18
    FMOV  V8.D[1], X29
    FMOV  D9, X4
    FMOV  V9.D[1], X28
    FMOV  D10, X23
    FMOV  V10.D[1], X29
    FMOV  D11, X16
    FMOV  V11.D[1], X14
    FMOV  D12, X10
    FMOV  V12.D[1], X16
    FMOV  D13, X9
    FMOV  V13.D[1], X25
    FMOV  D14, X9
    FMOV  V14.D[1], X16
    FMOV  D15, X3
    FMOV  V15.D[1], X20
    FMOV  D16, X29
    FMOV  V16.D[1], X18
    FMOV  D17, X15
    FMOV  V17.D[1], X10
    FMOV  D18, X8
    FMOV  V18.D[1], X22
    FMOV  D19, X20
    FMOV  V19.D[1], X2
    FMOV  D20, X3
    FMOV  V20.D[1], X18
    FMOV  D21, X24
    FMOV  V21.D[1], X15
    FMOV  D22, X4
    FMOV  V22.D[1], X10
    FMOV  D23, X2
    FMOV  V23.D[1], X29
    FMOV  D24, X13
    FMOV  V24.D[1], X12
    FMOV  D25, X5
    FMOV  V25.D[1], X13
    FMOV  D26, X6
    FMOV  V26.D[1], X16
    FMOV  D27, X18
    FMOV  V27.D[1], X4
    FMOV  D28, X16
    FMOV  V28.D[1], X7
    FMOV  D29, X4
    FMOV  V29.D[1], X9
    FMOV  D30, X4
    FMOV  V30.D[1], X18
    FMOV  D31, X7
    FMOV  V31.D[1], X17
    MOVZ  X10, #0xf, LSL #0
TaishanSimdComplexP01_label_1579:
    FMAXNMP S17, V22.2S
    FMINP D1, V4.2D
    SMINP  V27.4H, V31.4H, V24.4H
    FMAXNMP D7, V13.2D
    FMINP S21, V24.2S
    FMINNMP  V13.4S, V1.4S, V21.4S
    FMINNMP  V25.2S, V16.2S, V11.2S
    FMINNMP S7, V29.2S
    FADDP D26, V12.2D
    FMINP D17, V9.2D
    UMAXP  V0.4S, V13.4S, V23.4S
    ADDP  V11.8B, V25.8B, V22.8B
    SMINP  V30.8H, V29.8H, V0.8H
    FMAXP S24, V23.2S
    SMAXP  V28.16B, V1.16B, V0.16B
    FMAXP D10, V0.2D
    FMAXP D11, V9.2D
    FMAXP  V19.2D, V14.2D, V7.2D
    FMINNMP  V22.4S, V9.4S, V28.4S
    FADDP D5, V18.2D
    FMAXP  V24.2S, V23.2S, V9.2S
    UMAXP  V26.4S, V30.4S, V27.4S
    SMINP  V28.2S, V28.2S, V30.2S
    FADDP D3, V15.2D
    FMINNMP  V22.4S, V19.4S, V23.4S
    FMINNMP D24, V12.2D
    FMINNMP S12, V28.2S
    SMAXP  V17.4H, V11.4H, V9.4H
    FMINNMP D0, V8.2D
    FADDP  V30.2S, V11.2S, V7.2S
    FMAXP  V26.2D, V19.2D, V25.2D
    FMINNMP D24, V10.2D
    FMINNMP S3, V24.2S
    FMAXNMP  V7.4S, V16.4S, V30.4S
    FMINP  V25.2S, V26.2S, V15.2S
    FMAXP S12, V21.2S
    UMINP  V28.8B, V30.8B, V22.8B
    FMAXP D2, V20.2D
    FMINP D1, V12.2D
    FMAXP D7, V25.2D
    FADDP  V18.4S, V30.4S, V5.4S
    FMAXP S28, V27.2S
    FMINP  V28.4S, V9.4S, V11.4S
    FMINP S10, V3.2S
    UMAXP  V7.8H, V31.8H, V16.8H
    FMAXP S15, V26.2S
    FMAXNMP D18, V2.2D
    FADDP S30, V11.2S
    FMAXP  V28.2D, V28.2D, V1.2D
    FMAXP D9, V20.2D
    SMAXP  V8.4S, V2.4S, V24.4S
TaishanSimdComplexP01_label_16:
    FMAXP D17, V1.2D
    FMAXP  V24.2S, V9.2S, V11.2S
    FMINP  V10.2S, V16.2S, V31.2S
    FMAXNMP D21, V22.2D
    UMAXP  V22.4S, V15.4S, V25.4S
    FMINNMP D7, V2.2D
    SMAXP  V23.16B, V18.16B, V23.16B
    FMAXP S18, V8.2S
    FMINP D4, V12.2D
    SMAXP  V29.4H, V4.4H, V16.4H
    FMAXP S16, V8.2S
    FMINNMP S5, V24.2S
    FMINNMP S24, V6.2S
    UMINP  V16.8H, V23.8H, V15.8H
    SMINP  V26.8H, V25.8H, V9.8H
    FMAXP  V19.2D, V19.2D, V31.2D
    SMINP  V11.4H, V28.4H, V2.4H
    FADDP  V20.4S, V15.4S, V25.4S
    FADDP D11, V27.2D
    FADDP D28, V1.2D
    UMAXP  V6.4H, V2.4H, V22.4H
    FMINP D0, V1.2D
    FMAXP S19, V3.2S
    FMAXP S22, V23.2S
    SMAXP  V0.8H, V15.8H, V19.8H
    FMAXNMP  V25.4S, V19.4S, V15.4S
    ADDP  V4.2S, V10.2S, V25.2S
    FMINP D25, V13.2D
    SMINP  V3.4S, V10.4S, V16.4S
    FMAXNMP  V16.2S, V10.2S, V5.2S
    UMAXP  V1.8H, V19.8H, V12.8H
    FMAXP S10, V30.2S
    FADDP D31, V31.2D
    FADDP  V27.2S, V16.2S, V13.2S
    FMINNMP D1, V2.2D
    FADDP D23, V28.2D
    UMAXP  V26.4S, V20.4S, V29.4S
    FADDP  V5.4S, V14.4S, V11.4S
    FMAXP D23, V28.2D
    FMINP D16, V12.2D
    FADDP D3, V26.2D
    FMINNMP  V27.4S, V3.4S, V23.4S
    FMINP D11, V25.2D
    FMINNMP D14, V21.2D
    FMINP S9, V31.2S
    FADDP  V15.4S, V6.4S, V6.4S
    FMAXP D24, V12.2D
    UMINP  V27.8B, V29.8B, V30.8B
    FADDP D22, V20.2D
    UMAXP  V11.4S, V15.4S, V20.4S
    FADDP  V30.2D, V24.2D, V22.2D
    FMAXP  V24.2S, V13.2S, V7.2S
    FMINNMP D2, V9.2D
    ADDP  D9, V24.2D
    UMINP  V8.4S, V2.4S, V24.4S
    FMAXP D0, V28.2D
    FMINP S8, V16.2S
    UMINP  V23.8B, V11.8B, V2.8B
    FADDP S22, V10.2S
    FMAXNMP D0, V10.2D
    FADDP D8, V9.2D
    UMINP  V19.4S, V18.4S, V22.4S
    FMAXNMP  V9.4S, V11.4S, V8.4S
    FMAXNMP D23, V14.2D
    FMAXP  V12.2D, V21.2D, V7.2D
    FMINP S19, V16.2S
    FMINP D3, V4.2D
    ADDP  D4, V12.2D
    FMINP  V29.4S, V21.4S, V19.4S
    FMAXP D30, V16.2D
    SMINP  V23.8B, V19.8B, V3.8B
    UMINP  V28.8B, V11.8B, V22.8B
    FMAXNMP S1, V9.2S
    ADDP  V28.4S, V18.4S, V28.4S
    FADDP  V2.2D, V8.2D, V10.2D
    FADDP D15, V29.2D
    ADDP  D7, V21.2D
    FMAXP  V12.4S, V9.4S, V18.4S
    SMAXP  V22.4S, V17.4S, V25.4S
    UMINP  V15.16B, V18.16B, V10.16B
    UMAXP  V25.2S, V6.2S, V2.2S
    FMAXP S21, V2.2S
    FMAXNMP  V12.2D, V8.2D, V29.2D
    FMAXNMP D5, V23.2D
    FADDP D9, V7.2D
    FMAXNMP S16, V28.2S
    FADDP  V9.4S, V24.4S, V3.4S
    FADDP D3, V17.2D
    FMINNMP  V31.2D, V14.2D, V12.2D
    FMINP  V10.2S, V31.2S, V26.2S
    FMINP D27, V1.2D
    SMINP  V2.4S, V17.4S, V11.4S
    FMINP S5, V17.2S
    FMAXNMP D13, V10.2D
    ADDP  V28.4S, V15.4S, V1.4S
    FMINP  V24.2S, V9.2S, V29.2S
    ADDP  V9.4S, V19.4S, V10.4S
    FADDP S4, V22.2S
    FMAXNMP  V30.4S, V30.4S, V17.4S
    SMAXP  V15.4H, V11.4H, V29.4H
    ADDP  D10, V11.2D
    FADDP S10, V9.2S
    ADDP  D5, V5.2D
    FMAXP  V17.2D, V3.2D, V15.2D
    ADDP  D27, V28.2D
    UMINP  V24.2S, V17.2S, V10.2S
    FMAXP  V31.2S, V24.2S, V13.2S
    FMINP S21, V24.2S
    ADDP  V6.8H, V11.8H, V24.8H
    FADDP  V21.4S, V23.4S, V5.4S
    ADDP  D15, V13.2D
    FMAXP  V8.2S, V4.2S, V4.2S
    FADDP S23, V0.2S
    ADDP  V27.2S, V6.2S, V24.2S
    FMINNMP  V21.2S, V8.2S, V7.2S
    FADDP D30, V13.2D
    SMAXP  V3.2S, V29.2S, V11.2S
    FMINNMP D16, V31.2D
    SMINP  V12.2S, V19.2S, V25.2S
    UMAXP  V14.4S, V6.4S, V24.4S
    FMINNMP S17, V5.2S
    UMAXP  V8.2S, V17.2S, V15.2S
    FMAXP  V14.2S, V13.2S, V5.2S
    UMAXP  V31.2S, V2.2S, V4.2S
    FMAXNMP  V4.2D, V31.2D, V12.2D
    FMINNMP S10, V4.2S
    FMAXNMP  V7.4S, V6.4S, V25.4S
    FMINNMP S26, V5.2S
    FADDP  V23.2S, V26.2S, V20.2S
    FMAXNMP S31, V8.2S
    UMAXP  V14.2S, V24.2S, V24.2S
    FADDP S23, V14.2S
    FMAXP D30, V22.2D
    FMAXP D10, V19.2D
    UMAXP  V0.16B, V10.16B, V21.16B
    FMAXP  V27.4S, V23.4S, V7.4S
    SMINP  V27.4H, V4.4H, V31.4H
    FADDP S5, V24.2S
    FADDP D2, V22.2D
    FMAXP  V5.2D, V27.2D, V7.2D
    FADDP D7, V17.2D
    ADDP  D24, V26.2D
    FMINNMP S6, V13.2S
    FMAXNMP D3, V6.2D
    ADDP  D25, V16.2D
    FMINP D16, V13.2D
    FMINNMP D24, V5.2D
    FMINP  V4.2D, V30.2D, V4.2D
    FMINP S20, V17.2S
    SUBS  X10, X10, #0x1
    B.NE  TaishanSimdComplexP01_label_1579
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X28, X11, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X23, X16, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X11, X17, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X24, X28, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X7, X19, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X2, X15, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdComplexP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X3, X2, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X13, X26, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X29, X4, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X28, X2, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdComplexP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X13
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X8, X9, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X4, X26, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X21, X3, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdComplexP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X21, X22, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X20
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdComplexP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X5, X20, X22
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdComplexP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X15, X29, X26
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdComplexP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X20, X23, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X14, D2
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X24, D3
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdComplexP01_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X18, D4
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdComplexP01_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X23
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
TaishanSimdComplexP01_label_1337:
    FMOV  X23, D5
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X23
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X19, V6.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X19
TaishanSimdComplexP01_label_511:
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X19, D6
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdComplexP01_TestFail
    FMOV  X21, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X21, D7
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X4, X20, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X3, D8
    MOVZ  X20, #0x0, LSL #0
    SUB  X4, X20, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdComplexP01_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X26, D9
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdComplexP01_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X8, D10
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdComplexP01_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X7, D11
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdComplexP01_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X20, X4, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X26, D12
    MOVZ  X4, #0x0, LSL #0
    SUB  X20, X4, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdComplexP01_TestFail
    FMOV  X22, V13.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X22, D13
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X29, X12, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X9, D14
    MOVZ  X12, #0x0, LSL #0
    SUB  X29, X12, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X21, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X10, X18, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X21, D15
    MOVZ  X18, #0x0, LSL #0
    SUB  X10, X18, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X13, D16
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X25, V17.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X25, D17
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdComplexP01_TestFail
    FMOV  X25, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X25, D18
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdComplexP01_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X12, D19
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdComplexP01_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X17, D20
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdComplexP01_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X20, D21
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X18, X7, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X10, D22
    MOVZ  X7, #0x0, LSL #0
    SUB  X18, X7, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdComplexP01_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X9, X24, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X16, D23
    MOVZ  X24, #0x0, LSL #0
    SUB  X9, X24, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X15, V24.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X13, X12, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X15, D24
    MOVZ  X12, #0x0, LSL #0
    SUB  X13, X12, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X14, D25
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdComplexP01_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X2, D26
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdComplexP01_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X20, D28
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdComplexP01_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail
    FMOV  X18, D29
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdComplexP01_TestFail

TaishanSimdComplexP01_TestEnd:
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
TaishanSimdComplexP01_TestFail:
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
