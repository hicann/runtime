.global TaishanSimdWideNarryArthemticP01

.text
.p2align 4

TaishanSimdWideNarryArthemticP01:

TaishanSimdWideNarryArthemticP01_TestBegin:
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
    MOVK  X2, #0x5f52, LSL #48
    MOVK  X2, #0xc3b5, LSL #32
    MOVK  X2, #0x2d39, LSL #16
    MOVK  X2, #0x1adc, LSL #0
    MOVK  X3, #0xf391, LSL #48
    MOVK  X3, #0x7bf2, LSL #32
    MOVK  X3, #0x8bec, LSL #16
    MOVK  X3, #0x752, LSL #0
    MOVK  X4, #0x85d0, LSL #48
    MOVK  X4, #0x259a, LSL #32
    MOVK  X4, #0xcf98, LSL #16
    MOVK  X4, #0x9cc8, LSL #0
    MOVK  X5, #0xb764, LSL #48
    MOVK  X5, #0xf4d3, LSL #32
    MOVK  X5, #0x558, LSL #16
    MOVK  X5, #0x7f0f, LSL #0
    MOVK  X6, #0x6095, LSL #48
    MOVK  X6, #0x3905, LSL #32
    MOVK  X6, #0xf12b, LSL #16
    MOVK  X6, #0x978b, LSL #0
    MOVK  X7, #0x4812, LSL #48
    MOVK  X7, #0x2a52, LSL #32
    MOVK  X7, #0x21, LSL #16
    MOVK  X7, #0xdf76, LSL #0
    MOVK  X8, #0x4069, LSL #48
    MOVK  X8, #0xc1a6, LSL #32
    MOVK  X8, #0xea3, LSL #16
    MOVK  X8, #0x8a4b, LSL #0
    MOVK  X9, #0xa5f1, LSL #48
    MOVK  X9, #0xb7e8, LSL #32
    MOVK  X9, #0x7e29, LSL #16
    MOVK  X9, #0x27b4, LSL #0
    MOVK  X10, #0xf527, LSL #48
    MOVK  X10, #0xcdcc, LSL #32
    MOVK  X10, #0x65d6, LSL #16
    MOVK  X10, #0x6a19, LSL #0
    MOVK  X11, #0xf31d, LSL #48
    MOVK  X11, #0xbbe, LSL #32
    MOVK  X11, #0x7caf, LSL #16
    MOVK  X11, #0x19bd, LSL #0
    MOVK  X12, #0xa583, LSL #48
    MOVK  X12, #0x5bc6, LSL #32
    MOVK  X12, #0xa6df, LSL #16
    MOVK  X12, #0x7dea, LSL #0
    MOVK  X13, #0x1a04, LSL #48
    MOVK  X13, #0x4ad3, LSL #32
    MOVK  X13, #0x10a4, LSL #16
    MOVK  X13, #0x9951, LSL #0
    MOVK  X14, #0xd4ce, LSL #48
    MOVK  X14, #0xef37, LSL #32
    MOVK  X14, #0x2dcd, LSL #16
    MOVK  X14, #0x8cd7, LSL #0
    MOVK  X15, #0xf400, LSL #48
    MOVK  X15, #0x3474, LSL #32
    MOVK  X15, #0xe0fd, LSL #16
    MOVK  X15, #0x603e, LSL #0
    MOVK  X16, #0xba2, LSL #48
    MOVK  X16, #0xb999, LSL #32
    MOVK  X16, #0xa8e1, LSL #16
    MOVK  X16, #0x5388, LSL #0
    MOVK  X17, #0xd69, LSL #48
    MOVK  X17, #0x7c46, LSL #32
    MOVK  X17, #0x4092, LSL #16
    MOVK  X17, #0x9b35, LSL #0
    MOVK  X18, #0x9487, LSL #48
    MOVK  X18, #0x184a, LSL #32
    MOVK  X18, #0xbd10, LSL #16
    MOVK  X18, #0xf5c8, LSL #0
    MOVK  X19, #0x48e5, LSL #48
    MOVK  X19, #0x396c, LSL #32
    MOVK  X19, #0xcc86, LSL #16
    MOVK  X19, #0x9634, LSL #0
    MOVK  X20, #0x40a, LSL #48
    MOVK  X20, #0x14d3, LSL #32
    MOVK  X20, #0x8a07, LSL #16
    MOVK  X20, #0xd75, LSL #0
    MOVK  X21, #0x5ee6, LSL #48
    MOVK  X21, #0xf0fd, LSL #32
    MOVK  X21, #0x92b8, LSL #16
    MOVK  X21, #0x751f, LSL #0
    MOVK  X22, #0x4664, LSL #48
    MOVK  X22, #0x8682, LSL #32
    MOVK  X22, #0x245d, LSL #16
    MOVK  X22, #0x4c54, LSL #0
    MOVK  X23, #0x675c, LSL #48
    MOVK  X23, #0x5194, LSL #32
    MOVK  X23, #0xfdce, LSL #16
    MOVK  X23, #0x67c0, LSL #0
    MOVK  X24, #0xaa31, LSL #48
    MOVK  X24, #0x49c3, LSL #32
    MOVK  X24, #0x89aa, LSL #16
    MOVK  X24, #0xec5a, LSL #0
    MOVK  X26, #0x3427, LSL #48
    MOVK  X26, #0xbf94, LSL #32
    MOVK  X26, #0xe7a1, LSL #16
    MOVK  X26, #0xc951, LSL #0
    MOVK  X27, #0x3361, LSL #48
    MOVK  X27, #0xe5c0, LSL #32
    MOVK  X27, #0xe3, LSL #16
    MOVK  X27, #0x2b8, LSL #0
    MOVK  X28, #0xc294, LSL #48
    MOVK  X28, #0xa17b, LSL #32
    MOVK  X28, #0x3a71, LSL #16
    MOVK  X28, #0xf9, LSL #0
    MOVK  X29, #0xb3e1, LSL #48
    MOVK  X29, #0xa5c8, LSL #32
    MOVK  X29, #0x6a06, LSL #16
    MOVK  X29, #0x2311, LSL #0
    SUBS  W19, W29, W27, SXTW #0
    MOVZ  X11, #0x7b37, LSL #0
    MOVK  X11, #0x28ae, LSL #16
    MSR  FPCR, X11
    MRS  X3, FPSR
    MOVZ  X24, #0xff60, LSL #0
    MOVK  X24, #0x7ff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    AND  X3, X3, X24
    MOVZ  X24, #0x0, LSL #0
    ORR  X3, X3, X24
    MSR  FPSR, X3
    ISB  SY
    MOVZ  X2, #0x317a, LSL #0
    MOVK  X2, #0x24b6, LSL #16
    MOVK  X2, #0x4e10, LSL #32
    MOVK  X2, #0xea3f, LSL #48
    MOVZ  X3, #0xe93d, LSL #0
    MOVK  X3, #0xec4, LSL #16
    MOVK  X3, #0xd9fb, LSL #32
    MOVK  X3, #0x5851, LSL #48
    MOVZ  X4, #0x767d, LSL #0
    MOVK  X4, #0x6d2d, LSL #16
    MOVK  X4, #0xc92e, LSL #32
    MOVK  X4, #0x5584, LSL #48
    MOVZ  X5, #0xa2c5, LSL #0
    MOVK  X5, #0x8397, LSL #16
    MOVK  X5, #0xf806, LSL #32
    MOVK  X5, #0x6157, LSL #48
    MOVZ  X6, #0x800, LSL #0
    MOVK  X6, #0xf81c, LSL #16
    MOVK  X6, #0xa32c, LSL #32
    MOVK  X6, #0xbe1f, LSL #48
    MOVZ  X7, #0xeb9d, LSL #0
    MOVK  X7, #0x62be, LSL #16
    MOVK  X7, #0x8649, LSL #32
    MOVK  X7, #0x9d5e, LSL #48
    MOVZ  X8, #0xbe1e, LSL #0
    MOVK  X8, #0xf992, LSL #16
    MOVK  X8, #0x1f5, LSL #32
    MOVK  X8, #0x169, LSL #48
    MOVZ  X9, #0x9598, LSL #0
    MOVK  X9, #0x3b43, LSL #16
    MOVK  X9, #0x871f, LSL #32
    MOVK  X9, #0xcbec, LSL #48
    MOVZ  X10, #0x5602, LSL #0
    MOVK  X10, #0xb6d7, LSL #16
    MOVK  X10, #0xd43b, LSL #32
    MOVK  X10, #0xb164, LSL #48
    MOVZ  X11, #0x45ee, LSL #0
    MOVK  X11, #0x4c9b, LSL #16
    MOVK  X11, #0xab19, LSL #32
    MOVK  X11, #0xe160, LSL #48
    MOVZ  X12, #0xe9ea, LSL #0
    MOVK  X12, #0xdd3f, LSL #16
    MOVK  X12, #0xfc2, LSL #32
    MOVK  X12, #0x45eb, LSL #48
    MOVZ  X13, #0x38ce, LSL #0
    MOVK  X13, #0xf3a4, LSL #16
    MOVK  X13, #0x89dc, LSL #32
    MOVK  X13, #0x3065, LSL #48
    MOVZ  X14, #0x80cb, LSL #0
    MOVK  X14, #0x38f6, LSL #16
    MOVK  X14, #0x50aa, LSL #32
    MOVK  X14, #0xf4c8, LSL #48
    MOVZ  X15, #0x426e, LSL #0
    MOVK  X15, #0x1334, LSL #16
    MOVK  X15, #0xfa11, LSL #32
    MOVK  X15, #0x4570, LSL #48
    MOVZ  X16, #0x7083, LSL #0
    MOVK  X16, #0x654f, LSL #16
    MOVK  X16, #0x307e, LSL #32
    MOVK  X16, #0x1d4b, LSL #48
    MOVZ  X17, #0x4bfc, LSL #0
    MOVK  X17, #0x8465, LSL #16
    MOVK  X17, #0xb212, LSL #32
    MOVK  X17, #0x87db, LSL #48
    MOVZ  X18, #0x43d3, LSL #0
    MOVK  X18, #0xc460, LSL #16
    MOVK  X18, #0xd791, LSL #32
    MOVK  X18, #0x1c94, LSL #48
    MOVZ  X19, #0x6de0, LSL #0
    MOVK  X19, #0xb825, LSL #16
    MOVK  X19, #0x3436, LSL #32
    MOVK  X19, #0xc8b4, LSL #48
    MOVZ  X20, #0x3566, LSL #0
    MOVK  X20, #0xdf1d, LSL #16
    MOVK  X20, #0xa8a2, LSL #32
    MOVK  X20, #0x47cb, LSL #48
    MOVZ  X21, #0xef9, LSL #0
    MOVK  X21, #0x52f3, LSL #16
    MOVK  X21, #0x98a6, LSL #32
    MOVK  X21, #0x5d79, LSL #48
    MOVZ  X22, #0x7757, LSL #0
    MOVK  X22, #0x20ec, LSL #16
    MOVK  X22, #0x864d, LSL #32
    MOVK  X22, #0x9ca5, LSL #48
    MOVZ  X23, #0x6b43, LSL #0
    MOVK  X23, #0x439d, LSL #16
    MOVK  X23, #0x1dfd, LSL #32
    MOVK  X23, #0x8552, LSL #48
    MOVZ  X24, #0xe62e, LSL #0
    MOVK  X24, #0x196a, LSL #16
    MOVK  X24, #0xdeb2, LSL #32
    MOVK  X24, #0x8a7f, LSL #48
    MOVZ  X26, #0x48b5, LSL #0
    MOVK  X26, #0xf7bc, LSL #16
    MOVK  X26, #0xc607, LSL #32
    MOVK  X26, #0x555c, LSL #48
    MOVZ  X27, #0xeb27, LSL #0
    MOVK  X27, #0x4c0, LSL #16
    MOVK  X27, #0x8a80, LSL #32
    MOVK  X27, #0xf552, LSL #48
    MOVZ  X28, #0x4837, LSL #0
    MOVK  X28, #0x9636, LSL #16
    MOVK  X28, #0x3acf, LSL #32
    MOVK  X28, #0xd772, LSL #48
    MOVZ  X29, #0x7503, LSL #0
    MOVK  X29, #0xd36a, LSL #16
    MOVK  X29, #0x119a, LSL #32
    MOVK  X29, #0x8ee1, LSL #48
    FMOV  D0, X8
    FMOV  V0.D[1], X26
    FMOV  D1, X10
    FMOV  V1.D[1], X24
    FMOV  D2, X22
    FMOV  V2.D[1], X9
    FMOV  D3, X16
    FMOV  V3.D[1], X11
    FMOV  D4, X19
    FMOV  V4.D[1], X9
    FMOV  D5, X10
    FMOV  V5.D[1], X29
    FMOV  D6, X5
    FMOV  V6.D[1], X9
    FMOV  D7, X7
    FMOV  V7.D[1], X20
    FMOV  D8, X23
    FMOV  V8.D[1], X4
    FMOV  D9, X11
    FMOV  V9.D[1], X4
    FMOV  D10, X2
    FMOV  V10.D[1], X3
    FMOV  D11, X7
    FMOV  V11.D[1], X18
    FMOV  D12, X11
    FMOV  V12.D[1], X6
    FMOV  D13, X9
    FMOV  V13.D[1], X19
    FMOV  D14, X10
    FMOV  V14.D[1], X10
    FMOV  D15, X3
    FMOV  V15.D[1], X28
    FMOV  D16, X11
    FMOV  V16.D[1], X17
    FMOV  D17, X4
    FMOV  V17.D[1], X2
    FMOV  D18, X13
    FMOV  V18.D[1], X15
    FMOV  D19, X22
    FMOV  V19.D[1], X6
    FMOV  D20, X12
    FMOV  V20.D[1], X6
    FMOV  D21, X26
    FMOV  V21.D[1], X17
    FMOV  D22, X16
    FMOV  V22.D[1], X4
    FMOV  D23, X13
    FMOV  V23.D[1], X17
    FMOV  D24, X2
    FMOV  V24.D[1], X20
    FMOV  D25, X6
    FMOV  V25.D[1], X24
    FMOV  D26, X9
    FMOV  V26.D[1], X24
    FMOV  D27, X27
    FMOV  V27.D[1], X19
    FMOV  D28, X29
    FMOV  V28.D[1], X28
    FMOV  D29, X22
    FMOV  V29.D[1], X10
    FMOV  D30, X23
    FMOV  V30.D[1], X12
    FMOV  D31, X6
    FMOV  V31.D[1], X11
    MOVZ  X3, #0xa, LSL #0
TaishanSimdWideNarryArthemticP01_label_0:
    FMLA V0.4S, V23.4S, V25.S[0x1]
    MLS  V28.2S, V15.2S, V27.S[0x1]
    MUL  V2.2S, V16.2S, V15.S[0x0]
    FMUL V20.4S, V24.4S, V10.S[0x1]
    SQRDMULH H28, H6, V0.H[0x2]
    MUL  V22.4H, V18.4H, V0.H[0x1]
    FMULX V0.2D, V21.2D, V31.D[0x1]
    MUL  V22.8H, V22.8H, V1.H[0x3]
    MUL  V5.4H, V29.4H, V3.H[0x0]
    FMLS V30.4S, V20.4S, V19.S[0x3]
    FMLA V11.2S, V2.2S, V21.S[0x0]
    UMULL V21.2D, V22.2S, V14.S[0x2]
    FMULX S26, S18, V9.S[0x3]
    MUL  V22.4S, V31.4S, V0.S[0x0]
    UMULL V31.2D, V5.2S, V28.S[0x2]
    FMULX S22, S19, V14.S[0x2]
    SQRDMULH H2, H1, V1.H[0x6]
    UMULL2 V26.2D, V27.4S, V25.S[0x0]
    SQRDMULH  H20, H10, H9
    FMULX D26, D6, V3.D[0x1]
    SQRDMULH  H29, H19, H27
    SQRDMULH H31, H12, V10.H[0x5]
    FMUL V2.2S, V3.2S, V27.S[0x2]
    FMLA S12, S29, V11.S[0x3]
    SQRDMULH  H11, H12, H30
    SQRDMULH H29, H22, V5.H[0x4]
    FMUL V16.4S, V11.4S, V24.S[0x2]
    FMUL S19, S25, V13.S[0x0]
    UMULL2 V2.2D, V10.4S, V25.S[0x1]
    FMLS V31.2D, V18.2D, V9.D[0x0]
    MUL  V30.8H, V22.8H, V2.H[0x5]
    MLA  V4.8H, V14.8H, V9.H[0x6]
    UMULL2 V14.4S, V5.8H, V1.H[0x1]
    FMULX S28, S26, V31.S[0x3]
    FMLS D12, D5, V28.D[0x0]
    FMLA D26, D29, V29.D[0x0]
    SQRDMULH  V23.8H, V29.8H, V9.H[0x2]
    FMUL S12, S4, V4.S[0x1]
    MLS  V0.4H, V26.4H, V12.H[0x7]
    SQRDMULH  S23, S19, S3
    FMULX S1, S10, V22.S[0x0]
    MUL  V17.2S, V2.2S, V14.S[0x3]
    UMULL V17.4S, V19.4H, V7.H[0x0]
    FMULX S2, S9, V11.S[0x1]
    UMULL2 V0.4S, V25.8H, V6.H[0x3]
    UMULL2 V18.4S, V6.8H, V5.H[0x1]
    FMLA V0.2D, V27.2D, V23.D[0x1]
    UMULL2 V8.4S, V25.8H, V10.H[0x3]
    FMLS D3, D14, V1.D[0x0]
    FMLS S4, S21, V23.S[0x0]
    FMLS V29.2D, V20.2D, V31.D[0x1]
    FMLS V9.2D, V27.2D, V2.D[0x0]
    MUL  V28.4H, V24.4H, V13.H[0x1]
    FMULX D31, D5, V9.D[0x0]
    FMULX V13.2D, V9.2D, V1.D[0x1]
    FMLA S8, S21, V7.S[0x3]
    FMLA V8.2D, V19.2D, V19.D[0x1]
    FMUL S23, S17, V0.S[0x2]
    MUL  V7.4S, V28.4S, V20.S[0x2]
    MLA  V12.4H, V7.4H, V0.H[0x3]
    MLS  V23.4S, V2.4S, V27.S[0x1]
    MLS  V27.4S, V27.4S, V14.S[0x0]
    UMULL2 V6.2D, V13.4S, V21.S[0x0]
    SQRDMULH  H9, H8, H7
    SQRDMULH  V3.4H, V11.4H, V15.H[0x0]
    FMLA V6.2D, V24.2D, V21.D[0x0]
    UMULL2 V18.4S, V4.8H, V13.H[0x4]
    SQRDMULH  S5, S0, S6
    SQRDMULH H9, H5, V10.H[0x0]
    FMLS S29, S4, V26.S[0x0]
    FMULX D29, D12, V30.D[0x0]
    FMLS V27.2D, V15.2D, V31.D[0x1]
    SQRDMULH  S12, S0, S24
    SQRDMULH  S29, S12, S4
    FMUL D15, D3, V11.D[0x0]
    FMUL D1, D9, V31.D[0x0]
    FMLA V29.4S, V25.4S, V14.S[0x3]
    FMLS D28, D18, V17.D[0x0]
    SQRDMULH  V2.2S, V24.2S, V28.S[0x1]
    FMLA V16.2D, V30.2D, V27.D[0x1]
    UMULL V31.4S, V24.4H, V0.H[0x4]
    FMUL V31.2D, V29.2D, V26.D[0x1]
    FMLS V7.2D, V2.2D, V26.D[0x0]
    FMLS V8.2S, V8.2S, V2.S[0x0]
    FMLS V11.2S, V11.2S, V10.S[0x2]
    MLS  V29.2S, V22.2S, V15.S[0x0]
    SQRDMULH  V22.2S, V10.2S, V8.S[0x0]
    SQRDMULH  S19, S13, S20
    MLA  V2.2S, V29.2S, V1.S[0x0]
    FMUL S21, S23, V15.S[0x1]
    MUL  V31.4S, V18.4S, V15.S[0x1]
    MUL  V16.4S, V16.4S, V26.S[0x1]
    FMLS S19, S2, V0.S[0x2]
    FMLA S29, S19, V26.S[0x3]
    SQRDMULH S3, S17, V30.S[0x0]
    FMULX D29, D8, V1.D[0x1]
    UMULL V26.2D, V15.2S, V23.S[0x0]
    FMLA S12, S5, V11.S[0x1]
    FMLA V28.2S, V17.2S, V18.S[0x3]
    FMUL V24.2D, V15.2D, V28.D[0x0]
    SQRDMULH S15, S2, V3.S[0x3]
    UMULL2 V12.4S, V13.8H, V3.H[0x7]
    FMUL S21, S16, V16.S[0x1]
    SQRDMULH  S0, S0, S1
    FMLA D0, D25, V2.D[0x0]
    SQRDMULH  S29, S24, S30
    SQRDMULH  H3, H25, H21
    SQRDMULH H29, H15, V1.H[0x6]
    FMLA S2, S10, V6.S[0x2]
    SQRDMULH  H30, H19, H6
    MLS  V19.4S, V5.4S, V24.S[0x1]
    MLS  V28.2S, V8.2S, V24.S[0x0]
    SQRDMULH  V27.8H, V6.8H, V1.8H
    SQRDMULH  S26, S6, S6
    FMLS S9, S6, V11.S[0x3]
    FMULX D13, D7, V19.D[0x0]
    FMLA V17.2S, V2.2S, V23.S[0x0]
    FMULX V10.2D, V3.2D, V30.D[0x0]
    UMULL2 V24.4S, V17.8H, V15.H[0x4]
    SQRDMULH  V5.4H, V15.4H, V13.H[0x7]
    UMULL2 V23.2D, V8.4S, V10.S[0x0]
    SQRDMULH H17, H5, V2.H[0x5]
    SQRDMULH  V12.4H, V12.4H, V13.H[0x4]
    MLS  V13.2S, V25.2S, V14.S[0x3]
    UMULL V3.4S, V5.4H, V1.H[0x7]
    FMLA V1.2D, V19.2D, V9.D[0x0]
    FMLA D9, D24, V9.D[0x1]
    UMULL V26.2D, V11.2S, V18.S[0x3]
    FMUL V27.4S, V27.4S, V18.S[0x2]
    SQRDMULH  S17, S16, S23
    FMULX S12, S13, V7.S[0x2]
    SQRDMULH  V19.4S, V30.4S, V12.S[0x3]
    UMULL V19.4S, V3.4H, V8.H[0x0]
    MLA  V1.2S, V19.2S, V25.S[0x0]
    MUL  V9.4S, V14.4S, V24.S[0x3]
    FMLS V23.2D, V11.2D, V17.D[0x1]
    MLA  V26.8H, V2.8H, V8.H[0x1]
    FMLA S16, S9, V11.S[0x1]
    UMULL V24.2D, V27.2S, V13.S[0x3]
    SQRDMULH S7, S15, V17.S[0x1]
    UMULL2 V6.2D, V7.4S, V8.S[0x1]
    FMUL D1, D16, V25.D[0x1]
    MUL  V15.4S, V26.4S, V5.S[0x2]
    FMULX V6.2S, V19.2S, V28.S[0x0]
    UMULL V24.2D, V19.2S, V7.S[0x0]
    FMLA S31, S10, V31.S[0x3]
    MLS  V16.4S, V4.4S, V31.S[0x3]
    FMUL D28, D20, V1.D[0x0]
    FMUL D23, D30, V17.D[0x1]
    MUL  V19.8H, V1.8H, V12.H[0x0]
    UMULL2 V3.4S, V1.8H, V14.H[0x7]
    MLS  V3.8H, V22.8H, V7.H[0x4]
    MUL  V17.4S, V24.4S, V24.S[0x3]
    SQRDMULH  V2.2S, V25.2S, V24.S[0x2]
    MUL  V7.4S, V10.4S, V30.S[0x3]
    FMLS D6, D12, V14.D[0x0]
    UMULL V13.4S, V11.4H, V10.H[0x5]
    SQRDMULH  H27, H24, H3
    MUL  V14.4S, V26.4S, V9.S[0x2]
    FMUL D3, D15, V6.D[0x0]
    FMUL V28.2S, V31.2S, V8.S[0x0]
    FMLS V4.2D, V14.2D, V30.D[0x0]
    MLA  V6.4H, V17.4H, V6.H[0x1]
    FMLA D31, D10, V13.D[0x0]
    FMUL D8, D24, V6.D[0x1]
    FMLA V2.2S, V25.2S, V16.S[0x3]
    FMLS S11, S0, V17.S[0x0]
    SQRDMULH  V3.2S, V17.2S, V8.2S
    FMUL S9, S21, V18.S[0x3]
    FMUL V3.2D, V27.2D, V21.D[0x0]
    UMULL V20.2D, V29.2S, V17.S[0x3]
    FMUL V26.2S, V4.2S, V22.S[0x0]
    UMULL V22.2D, V21.2S, V9.S[0x2]
    UMULL V2.4S, V2.4H, V12.H[0x6]
    FMLA V23.2D, V27.2D, V20.D[0x0]
    FMLS V21.2S, V9.2S, V17.S[0x0]
    SQRDMULH S31, S21, V11.S[0x1]
    FMLA V24.4S, V25.4S, V28.S[0x0]
    FMUL D27, D6, V27.D[0x1]
    FMULX V27.4S, V3.4S, V1.S[0x2]
    FMLS S26, S1, V28.S[0x1]
    MUL  V14.8H, V0.8H, V15.H[0x3]
    MLA  V28.8H, V30.8H, V15.H[0x3]
    FMUL D6, D13, V21.D[0x1]
    FMUL D18, D16, V22.D[0x1]
    FMUL V22.4S, V14.4S, V29.S[0x1]
    FMLS S24, S4, V6.S[0x3]
    FMLS V13.2S, V10.2S, V25.S[0x2]
    FMLA V30.2D, V6.2D, V29.D[0x1]
    SQRDMULH  V16.4H, V12.4H, V26.4H
    FMLA V3.2D, V21.2D, V26.D[0x1]
    FMLA S22, S30, V11.S[0x2]
    SQRDMULH  V5.4S, V14.4S, V29.S[0x1]
    SQRDMULH S6, S20, V18.S[0x2]
    SQRDMULH  V28.4H, V6.4H, V9.H[0x3]
    MLA  V29.4H, V18.4H, V10.H[0x1]
    FMLA S23, S11, V7.S[0x2]
    UMULL2 V10.4S, V15.8H, V7.H[0x7]
    SQRDMULH  V0.2S, V27.2S, V21.S[0x3]
    SQRDMULH  S20, S6, S7
    SUBS  X3, X3, #0x1
    B.NE  TaishanSimdWideNarryArthemticP01_label_0
    MOVZ  X17, #0x317a, LSL #0
    MOVK  X17, #0x24b6, LSL #16
    MOVK  X17, #0x4e10, LSL #32
    MOVK  X17, #0xea3f, LSL #48
    SUB  X3, X17, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X8, #0x767d, LSL #0
    MOVK  X8, #0x6d2d, LSL #16
    MOVK  X8, #0xc92e, LSL #32
    MOVK  X8, #0x5584, LSL #48
    SUB  X11, X8, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X5, #0xa2c5, LSL #0
    MOVK  X5, #0x8397, LSL #16
    MOVK  X5, #0xf806, LSL #32
    MOVK  X5, #0x6157, LSL #48
    SUB  X22, X5, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X5, #0x800, LSL #0
    MOVK  X5, #0xf81c, LSL #16
    MOVK  X5, #0xa32c, LSL #32
    MOVK  X5, #0xbe1f, LSL #48
    SUB  X14, X5, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X22, #0xeb9d, LSL #0
    MOVK  X22, #0x62be, LSL #16
    MOVK  X22, #0x8649, LSL #32
    MOVK  X22, #0x9d5e, LSL #48
    SUB  X17, X22, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X7, #0x767d, LSL #0
    MOVK  X7, #0x6d2d, LSL #16
    MOVK  X7, #0xc92e, LSL #32
    MOVK  X7, #0x5584, LSL #48
    SUB  X11, X7, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X16, #0x9598, LSL #0
    MOVK  X16, #0x3b43, LSL #16
    MOVK  X16, #0x871f, LSL #32
    MOVK  X16, #0xcbec, LSL #48
    SUB  X8, X16, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X7, X10, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X27, #0xe9ea, LSL #0
    MOVK  X27, #0xdd3f, LSL #16
    MOVK  X27, #0xfc2, LSL #32
    MOVK  X27, #0x45eb, LSL #48
    SUB  X17, X27, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X27, #0x38ce, LSL #0
    MOVK  X27, #0xf3a4, LSL #16
    MOVK  X27, #0x89dc, LSL #32
    MOVK  X27, #0x3065, LSL #48
    SUB  X15, X27, X13
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X7, X11, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X11, #0x9598, LSL #0
    MOVK  X11, #0x3b43, LSL #16
    MOVK  X11, #0x871f, LSL #32
    MOVK  X11, #0xcbec, LSL #48
    SUB  X27, X11, X16
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X27, #0x43d3, LSL #0
    MOVK  X27, #0xc460, LSL #16
    MOVK  X27, #0xd791, LSL #32
    MOVK  X27, #0x1c94, LSL #48
    SUB  X16, X27, X18
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X7, #0x6de0, LSL #0
    MOVK  X7, #0xb825, LSL #16
    MOVK  X7, #0x3436, LSL #32
    MOVK  X7, #0xc8b4, LSL #48
    SUB  X10, X7, X19
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X21, #0x3566, LSL #0
    MOVK  X21, #0xdf1d, LSL #16
    MOVK  X21, #0xa8a2, LSL #32
    MOVK  X21, #0x47cb, LSL #48
    SUB  X19, X21, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X4, #0x3566, LSL #0
    MOVK  X4, #0xdf1d, LSL #16
    MOVK  X4, #0xa8a2, LSL #32
    MOVK  X4, #0x47cb, LSL #48
    SUB  X10, X4, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X19, #0xeb9d, LSL #0
    MOVK  X19, #0x62be, LSL #16
    MOVK  X19, #0x8649, LSL #32
    MOVK  X19, #0x9d5e, LSL #48
    SUB  X23, X19, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X23
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X21, #0xe62e, LSL #0
    MOVK  X21, #0x196a, LSL #16
    MOVK  X21, #0xdeb2, LSL #32
    MOVK  X21, #0x8a7f, LSL #48
    SUB  X10, X21, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X13, #0x48b5, LSL #0
    MOVK  X13, #0xf7bc, LSL #16
    MOVK  X13, #0xc607, LSL #32
    MOVK  X13, #0x555c, LSL #48
    SUB  X10, X13, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X27, #0x4837, LSL #0
    MOVK  X27, #0x9636, LSL #16
    MOVK  X27, #0x3acf, LSL #32
    MOVK  X27, #0xd772, LSL #48
    SUB  X10, X27, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, D2
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X28, X4, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, D3
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #48
    SUB  X28, X4, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #48
    SUB  X10, X14, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, D4
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0x7f7f, LSL #16
    SUB  X10, X14, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, D5
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, D6
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X28, X15, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D7
    MOVZ  X15, #0x0, LSL #0
    SUB  X28, X15, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, D8
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X12
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, D9
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X12
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, D10
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, D11
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x8000, LSL #16
    SUB  X2, X17, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, D12
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, V13.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X28, X4, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, D13
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #16
    MOVK  X4, #0x8000, LSL #48
    SUB  X28, X4, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, D14
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, V15.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, D15
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, V16.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X21, X20, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, D16
    MOVZ  X20, #0x0, LSL #0
    SUB  X21, X20, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, V17.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X14, X27, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, D17
    MOVZ  X27, #0x0, LSL #0
    SUB  X14, X27, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, D18
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, V19.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, D19
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, D20
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X22
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, D21
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x8000, LSL #16
    MOVK  X2, #0x8000, LSL #48
    SUB  X5, X2, X22
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X11, X19, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, D22
    MOVZ  X19, #0x0, LSL #0
    SUB  X11, X19, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, D23
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8000, LSL #16
    SUB  X6, X13, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X20, X11, X19
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, D24
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0x7fff, LSL #16
    SUB  X20, X11, X19
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X3, X28, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, D26
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0x7fff, LSL #16
    SUB  X3, X28, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X28, X22, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, D27
    MOVZ  X22, #0x0, LSL #0
    SUB  X28, X22, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X26
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, D28
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X26
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, D29
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
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
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X7
    FMOV  V0.D[1], X17
    FMOV  D1, X19
    FMOV  V1.D[1], X11
    FMOV  D2, X13
    FMOV  V2.D[1], X16
    FMOV  D3, X29
    FMOV  V3.D[1], X21
    FMOV  D4, X26
    FMOV  V4.D[1], X5
    FMOV  D5, X18
    FMOV  V5.D[1], X16
    FMOV  D6, X16
    FMOV  V6.D[1], X18
    FMOV  D7, X4
    FMOV  V7.D[1], X3
    FMOV  D8, X24
    FMOV  V8.D[1], X17
    FMOV  D9, X28
    FMOV  V9.D[1], X16
    FMOV  D10, X4
    FMOV  V10.D[1], X11
    FMOV  D11, X21
    FMOV  V11.D[1], X22
    FMOV  D12, X4
    FMOV  V12.D[1], X27
    FMOV  D13, X6
    FMOV  V13.D[1], X26
    FMOV  D14, X15
    FMOV  V14.D[1], X19
    FMOV  D15, X10
    FMOV  V15.D[1], X17
    FMOV  D16, X15
    FMOV  V16.D[1], X26
    FMOV  D17, X27
    FMOV  V17.D[1], X22
    FMOV  D18, X13
    FMOV  V18.D[1], X18
    FMOV  D19, X7
    FMOV  V19.D[1], X7
    FMOV  D20, X22
    FMOV  V20.D[1], X12
    FMOV  D21, X16
    FMOV  V21.D[1], X15
    FMOV  D22, X20
    FMOV  V22.D[1], X4
    FMOV  D23, X10
    FMOV  V23.D[1], X26
    FMOV  D24, X16
    FMOV  V24.D[1], X14
    FMOV  D25, X13
    FMOV  V25.D[1], X23
    FMOV  D26, X18
    FMOV  V26.D[1], X29
    FMOV  D27, X21
    FMOV  V27.D[1], X5
    FMOV  D28, X9
    FMOV  V28.D[1], X23
    FMOV  D29, X14
    FMOV  V29.D[1], X17
    FMOV  D30, X14
    FMOV  V30.D[1], X13
    FMOV  D31, X24
    FMOV  V31.D[1], X15
    MOVZ  X22, #0xa, LSL #0
TaishanSimdWideNarryArthemticP01_label_83:
    FMUL V0.2D, V13.2D, V21.D[0x0]
    SQRDMULH S17, S10, V28.S[0x3]
    FMLA S17, S17, V24.S[0x1]
    FMUL S18, S27, V19.S[0x0]
    FMLS V18.2D, V27.2D, V15.D[0x0]
    FMUL V27.2D, V5.2D, V18.D[0x1]
    MUL  V10.2S, V10.2S, V2.S[0x0]
    FMULX V7.4S, V6.4S, V18.S[0x2]
    MUL  V26.2S, V19.2S, V21.S[0x3]
    UMULL V30.2D, V20.2S, V8.S[0x1]
    UMULL2 V6.2D, V30.4S, V6.S[0x2]
    FMULX V24.2D, V13.2D, V9.D[0x1]
    FMLA S17, S8, V0.S[0x2]
    FMULX V3.2D, V23.2D, V13.D[0x1]
    FMLS V16.2D, V10.2D, V12.D[0x1]
    MUL  V8.8H, V9.8H, V12.H[0x7]
    UMULL2 V27.4S, V7.8H, V7.H[0x0]
    UMULL2 V29.2D, V19.4S, V26.S[0x0]
    FMLS S20, S9, V7.S[0x3]
    FMUL V30.2D, V6.2D, V6.D[0x1]
    SQRDMULH  V7.4S, V8.4S, V18.S[0x1]
    FMULX S16, S20, V26.S[0x1]
    FMLA V17.2D, V16.2D, V4.D[0x1]
    UMULL2 V8.2D, V30.4S, V27.S[0x0]
    FMLA V21.2D, V2.2D, V23.D[0x1]
    MUL  V29.4S, V10.4S, V31.S[0x1]
    FMUL S15, S6, V23.S[0x1]
    MLA  V8.8H, V7.8H, V7.H[0x7]
    UMULL V29.4S, V11.4H, V9.H[0x0]
    FMLS S5, S21, V17.S[0x2]
    MLA  V3.4H, V5.4H, V1.H[0x1]
    SQRDMULH  V19.2S, V15.2S, V11.S[0x3]
    UMULL V8.2D, V12.2S, V19.S[0x2]
    UMULL V5.4S, V12.4H, V7.H[0x7]
    UMULL V18.2D, V16.2S, V8.S[0x1]
    SQRDMULH S7, S3, V5.S[0x1]
    FMUL S17, S28, V7.S[0x0]
    FMUL V27.2S, V25.2S, V28.S[0x3]
    FMLA D9, D21, V23.D[0x1]
    FMULX D29, D20, V26.D[0x1]
    FMULX V29.4S, V22.4S, V16.S[0x1]
    FMLS V29.2D, V13.2D, V13.D[0x1]
    FMUL V26.2D, V3.2D, V9.D[0x1]
    FMLS S23, S30, V14.S[0x2]
    FMLA V21.2D, V30.2D, V17.D[0x0]
    SQRDMULH  V13.4S, V3.4S, V25.S[0x3]
    FMLA D14, D0, V16.D[0x0]
    FMLA S2, S19, V20.S[0x0]
    UMULL2 V9.4S, V16.8H, V1.H[0x6]
    SQRDMULH  H22, H16, H24
    SQRDMULH  V4.4S, V9.4S, V7.S[0x2]
    SQRDMULH S15, S26, V15.S[0x0]
    SQRDMULH  V5.8H, V27.8H, V24.8H
    MLS  V9.4S, V30.4S, V1.S[0x2]
    SQRDMULH  S29, S0, S2
    FMUL D13, D23, V0.D[0x1]
    FMLS D20, D15, V21.D[0x1]
    MUL  V28.2S, V28.2S, V25.S[0x3]
    UMULL V27.2D, V15.2S, V4.S[0x0]
    UMULL2 V9.4S, V11.8H, V12.H[0x7]
    SQRDMULH  S5, S18, S12
    FMUL S0, S12, V23.S[0x3]
    FMUL S6, S27, V25.S[0x3]
    FMULX V28.4S, V29.4S, V4.S[0x3]
    FMUL D30, D5, V3.D[0x0]
    FMLS S21, S6, V29.S[0x0]
    UMULL2 V27.4S, V28.8H, V0.H[0x0]
    MLS  V16.2S, V6.2S, V6.S[0x1]
    FMLA V25.2D, V18.2D, V17.D[0x0]
    SQRDMULH  S26, S23, S9
    FMLA V12.4S, V6.4S, V15.S[0x1]
    SQRDMULH  V30.4H, V14.4H, V2.H[0x7]
    FMLS D5, D7, V20.D[0x1]
    SQRDMULH  V30.8H, V18.8H, V15.H[0x7]
    SQRDMULH  V6.4H, V29.4H, V16.4H
    FMULX V23.2S, V3.2S, V30.S[0x1]
    SQRDMULH  S7, S21, S0
    MLA  V1.2S, V25.2S, V12.S[0x2]
    MLA  V18.8H, V19.8H, V6.H[0x4]
    FMULX S11, S1, V3.S[0x1]
    MUL  V5.8H, V14.8H, V5.H[0x5]
    FMUL S28, S4, V26.S[0x3]
    UMULL V25.4S, V12.4H, V2.H[0x4]
    SQRDMULH  V16.8H, V14.8H, V18.8H
    MLA  V15.2S, V2.2S, V13.S[0x1]
    FMLS D18, D17, V14.D[0x0]
    FMULX S23, S19, V21.S[0x2]
    FMULX D27, D3, V17.D[0x0]
    SQRDMULH  V23.2S, V13.2S, V15.S[0x1]
    UMULL2 V3.2D, V1.4S, V0.S[0x1]
    MLS  V21.4H, V9.4H, V13.H[0x6]
    MLA  V17.2S, V6.2S, V9.S[0x1]
    FMLA V23.2S, V12.2S, V1.S[0x2]
    FMLA S11, S11, V18.S[0x0]
    MLS  V26.4S, V0.4S, V26.S[0x1]
    SQRDMULH  V4.2S, V5.2S, V31.S[0x3]
    FMLS V6.2S, V20.2S, V20.S[0x2]
    MLS  V10.2S, V16.2S, V11.S[0x2]
    FMLS S21, S8, V27.S[0x1]
    FMUL D22, D20, V17.D[0x0]
    FMULX S25, S30, V26.S[0x3]
    UMULL V5.4S, V14.4H, V13.H[0x1]
    SQRDMULH  V15.8H, V10.8H, V28.8H
    FMULX S1, S0, V0.S[0x0]
    FMUL S21, S12, V9.S[0x3]
    MLS  V10.4S, V24.4S, V24.S[0x0]
    FMLS D3, D17, V28.D[0x1]
    FMLS D17, D25, V6.D[0x1]
    FMLA V23.4S, V23.4S, V23.S[0x3]
    MLS  V27.4H, V25.4H, V3.H[0x3]
    MUL  V22.4H, V13.4H, V12.H[0x0]
    MLA  V17.4S, V21.4S, V25.S[0x1]
    MLS  V16.4S, V26.4S, V31.S[0x3]
    UMULL2 V23.2D, V12.4S, V5.S[0x3]
    SQRDMULH  V19.4S, V19.4S, V4.S[0x2]
    FMLS S26, S23, V15.S[0x3]
    FMULX V8.4S, V1.4S, V11.S[0x3]
    FMULX V5.2D, V17.2D, V8.D[0x1]
    SQRDMULH  S26, S19, S23
    FMLA S12, S1, V13.S[0x2]
    UMULL V7.4S, V19.4H, V7.H[0x3]
    FMLS S31, S7, V15.S[0x2]
    MLS  V2.4H, V9.4H, V5.H[0x5]
    UMULL2 V9.4S, V5.8H, V7.H[0x1]
    MLS  V21.2S, V2.2S, V30.S[0x1]
    FMLS V24.2S, V3.2S, V15.S[0x3]
    SQRDMULH  S1, S7, S23
    FMUL S18, S30, V16.S[0x2]
    MUL  V1.2S, V27.2S, V22.S[0x3]
    MLS  V21.2S, V3.2S, V9.S[0x3]
    MLS  V10.4S, V14.4S, V19.S[0x2]
    UMULL V28.2D, V12.2S, V31.S[0x2]
    FMLS S5, S18, V1.S[0x2]
    SQRDMULH  H21, H14, H14
    MLA  V4.4H, V14.4H, V1.H[0x4]
    FMUL D23, D8, V12.D[0x1]
    SQRDMULH  V18.8H, V3.8H, V4.8H
    UMULL2 V1.4S, V10.8H, V0.H[0x2]
    MLS  V24.4H, V13.4H, V8.H[0x1]
    FMUL V4.2D, V26.2D, V18.D[0x0]
    UMULL V8.4S, V17.4H, V7.H[0x0]
    FMUL D19, D29, V23.D[0x0]
    SQRDMULH S4, S3, V31.S[0x3]
    MLA  V24.8H, V7.8H, V11.H[0x7]
    FMULX V12.2S, V26.2S, V31.S[0x3]
    FMLS S23, S22, V23.S[0x1]
    FMULX V11.4S, V18.4S, V9.S[0x1]
    FMULX V24.4S, V22.4S, V6.S[0x3]
    SQRDMULH  V8.2S, V9.2S, V24.2S
    UMULL2 V31.2D, V30.4S, V21.S[0x1]
    FMUL V2.2S, V15.2S, V31.S[0x0]
    FMULX V19.2D, V9.2D, V21.D[0x0]
    SQRDMULH  V19.2S, V18.2S, V1.2S
    FMLS S26, S8, V14.S[0x0]
    UMULL2 V27.2D, V9.4S, V24.S[0x2]
    FMULX V31.2S, V22.2S, V8.S[0x0]
    FMULX D12, D26, V10.D[0x1]
    FMULX D23, D5, V10.D[0x1]
    FMLA V12.2D, V0.2D, V4.D[0x0]
    FMUL V25.2D, V17.2D, V14.D[0x0]
    UMULL V2.4S, V29.4H, V6.H[0x1]
    FMLA V4.2D, V2.2D, V25.D[0x1]
    SQRDMULH  V7.2S, V15.2S, V5.2S
    MLS  V0.8H, V13.8H, V4.H[0x4]
    MUL  V12.4S, V22.4S, V29.S[0x0]
    FMLA D17, D11, V9.D[0x1]
    FMLS S25, S19, V14.S[0x3]
    FMLS V3.2S, V7.2S, V2.S[0x3]
    SQRDMULH  V0.4S, V12.4S, V17.4S
    FMULX V13.2D, V2.2D, V26.D[0x0]
    FMULX V19.2D, V12.2D, V30.D[0x0]
    MUL  V3.4H, V11.4H, V12.H[0x0]
    FMULX D20, D29, V6.D[0x0]
    FMLA D29, D30, V21.D[0x1]
    SQRDMULH S17, S23, V13.S[0x0]
    MLS  V16.4S, V7.4S, V6.S[0x2]
    SQRDMULH  S7, S7, S5
    UMULL V29.2D, V23.2S, V0.S[0x2]
    SQRDMULH  V11.8H, V26.8H, V31.8H
    FMUL S1, S25, V22.S[0x0]
    FMLS V9.2D, V13.2D, V29.D[0x0]
    MLS  V21.4H, V29.4H, V2.H[0x7]
    SQRDMULH H5, H17, V8.H[0x4]
    FMUL S13, S4, V18.S[0x0]
    FMULX S20, S27, V20.S[0x3]
    FMLS V24.4S, V25.4S, V29.S[0x0]
    MLS  V22.4H, V23.4H, V15.H[0x0]
    FMLS S27, S13, V3.S[0x1]
    UMULL V14.2D, V21.2S, V14.S[0x1]
    SQRDMULH  H27, H19, H16
    FMLS V19.2D, V3.2D, V9.D[0x1]
    FMUL S21, S12, V27.S[0x0]
    UMULL2 V23.2D, V24.4S, V19.S[0x1]
    FMUL V17.2D, V11.2D, V22.D[0x1]
    FMLA S18, S11, V4.S[0x0]
    SQRDMULH H14, H22, V15.H[0x3]
    FMUL S22, S21, V14.S[0x2]
    UMULL V20.2D, V27.2S, V29.S[0x0]
    MUL  V14.8H, V23.8H, V3.H[0x3]
    UMULL2 V19.2D, V28.4S, V16.S[0x1]
    SUBS  X22, X22, #0x1
    B.NE  TaishanSimdWideNarryArthemticP01_label_83
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X13, X22, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X9, X20, X12
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X28, X4, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X28, X22, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X7, X10, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X26
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X27
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X13, X3, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, D2
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, D3
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, D4
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, D5
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, D6
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x8000, LSL #48
    SUB  X22, X7, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, V7.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, D7
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, D8
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, V9.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #48
    SUB  X8, X15, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, D9
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #48
    SUB  X8, X15, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, D10
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X18, X9, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, D11
    MOVZ  X9, #0x0, LSL #0
    SUB  X18, X9, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, V12.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, D12
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, D13
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X7, X26, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, D14
    MOVZ  X26, #0x0, LSL #0
    SUB  X7, X26, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X17, V15.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X17, D15
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X9, X17, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, D16
    MOVZ  X17, #0x0, LSL #0
    SUB  X9, X17, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, D17
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, D18
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, D19
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, D20
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, D21
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, V22.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X19, X12, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, D22
    MOVZ  X12, #0x0, LSL #0
    SUB  X19, X12, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X7, X10, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D23
    MOVZ  X10, #0x0, LSL #0
    SUB  X7, X10, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x8000, LSL #16
    MOVK  X7, #0x8000, LSL #48
    SUB  X15, X7, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X6, D24
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x8000, LSL #48
    SUB  X15, X7, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, V26.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, D26
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #16
    SUB  X17, X8, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D27
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, D28
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X23, X13, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, D29
    MOVZ  X13, #0x0, LSL #0
    SUB  X23, X13, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
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
    FMOV  V0.D[1], X6
    FMOV  D1, X27
    FMOV  V1.D[1], X27
    FMOV  D2, X18
    FMOV  V2.D[1], X28
    FMOV  D3, X6
    FMOV  V3.D[1], X18
    FMOV  D4, X14
    FMOV  V4.D[1], X10
    FMOV  D5, X7
    FMOV  V5.D[1], X12
    FMOV  D6, X21
    FMOV  V6.D[1], X16
    FMOV  D7, X22
    FMOV  V7.D[1], X20
    FMOV  D8, X20
    FMOV  V8.D[1], X12
    FMOV  D9, X27
    FMOV  V9.D[1], X21
    FMOV  D10, X28
    FMOV  V10.D[1], X9
    FMOV  D11, X15
    FMOV  V11.D[1], X15
    FMOV  D12, X29
    FMOV  V12.D[1], X14
    FMOV  D13, X22
    FMOV  V13.D[1], X21
    FMOV  D14, X28
    FMOV  V14.D[1], X11
    FMOV  D15, X28
    FMOV  V15.D[1], X14
    FMOV  D16, X14
    FMOV  V16.D[1], X26
    FMOV  D17, X4
    FMOV  V17.D[1], X21
    FMOV  D18, X9
    FMOV  V18.D[1], X13
    FMOV  D19, X29
    FMOV  V19.D[1], X9
    FMOV  D20, X10
    FMOV  V20.D[1], X23
    FMOV  D21, X14
    FMOV  V21.D[1], X24
    FMOV  D22, X29
    FMOV  V22.D[1], X12
    FMOV  D23, X4
    FMOV  V23.D[1], X21
    FMOV  D24, X28
    FMOV  V24.D[1], X12
    FMOV  D25, X27
    FMOV  V25.D[1], X23
    FMOV  D26, X8
    FMOV  V26.D[1], X12
    FMOV  D27, X21
    FMOV  V27.D[1], X29
    FMOV  D28, X14
    FMOV  V28.D[1], X24
    FMOV  D29, X14
    FMOV  V29.D[1], X21
    FMOV  D30, X6
    FMOV  V30.D[1], X21
    FMOV  D31, X4
    FMOV  V31.D[1], X9
    MOVZ  X28, #0xf, LSL #0
TaishanSimdWideNarryArthemticP01_label_166:
    MUL  V26.2S, V24.2S, V21.S[0x3]
    FMUL V20.2D, V10.2D, V15.D[0x1]
    MLA  V30.4S, V8.4S, V26.S[0x0]
    MUL  V31.4H, V22.4H, V11.H[0x5]
    SQRDMULH  V16.2S, V13.2S, V20.2S
    SQRDMULH H30, H11, V6.H[0x3]
    MUL  V8.4H, V18.4H, V3.H[0x3]
    MLS  V19.4S, V2.4S, V10.S[0x3]
    FMULX V28.2D, V17.2D, V11.D[0x0]
    FMUL V10.2S, V31.2S, V24.S[0x0]
    FMLS D7, D23, V8.D[0x0]
    FMUL V19.2D, V16.2D, V14.D[0x1]
    FMULX V8.2D, V19.2D, V17.D[0x1]
    FMLS V1.2D, V6.2D, V21.D[0x1]
    SQRDMULH  H4, H29, H29
    MLA  V7.4S, V15.4S, V20.S[0x2]
    FMLA D15, D9, V5.D[0x1]
    FMUL V26.2D, V1.2D, V23.D[0x0]
    SQRDMULH S6, S24, V10.S[0x1]
    SQRDMULH H24, H4, V0.H[0x7]
    MUL  V10.2S, V3.2S, V8.S[0x1]
    SQRDMULH  V2.4S, V1.4S, V0.S[0x1]
    MLS  V4.4H, V29.4H, V5.H[0x7]
    MUL  V22.4S, V10.4S, V14.S[0x3]
    FMUL S20, S15, V3.S[0x1]
    SQRDMULH  H9, H3, H5
    FMUL V30.4S, V12.4S, V10.S[0x1]
    FMULX V30.2D, V11.2D, V5.D[0x1]
    FMUL S18, S2, V11.S[0x0]
    FMUL D16, D7, V20.D[0x0]
    MUL  V26.4S, V24.4S, V4.S[0x3]
    UMULL V22.4S, V6.4H, V13.H[0x0]
    UMULL V14.2D, V28.2S, V11.S[0x2]
    FMUL D10, D23, V29.D[0x1]
    SQRDMULH  V7.2S, V11.2S, V18.S[0x2]
    FMULX D0, D27, V10.D[0x0]
    MUL  V16.4H, V0.4H, V0.H[0x2]
    FMULX V24.2D, V1.2D, V28.D[0x0]
    MLS  V14.8H, V2.8H, V6.H[0x3]
    MUL  V23.2S, V17.2S, V22.S[0x0]
    UMULL2 V28.2D, V1.4S, V16.S[0x3]
    FMLS V29.2D, V1.2D, V9.D[0x1]
    UMULL2 V22.2D, V12.4S, V29.S[0x3]
    FMULX D28, D12, V21.D[0x0]
    SQRDMULH H15, H2, V14.H[0x3]
    MUL  V3.8H, V3.8H, V10.H[0x3]
    FMULX D24, D10, V21.D[0x1]
    MLS  V3.4S, V28.4S, V20.S[0x0]
    FMLA V15.2D, V27.2D, V10.D[0x0]
    SQRDMULH  V22.4H, V19.4H, V6.4H
    FMULX V6.2S, V16.2S, V22.S[0x3]
    FMLS D27, D28, V7.D[0x1]
    FMLS D8, D12, V9.D[0x1]
    MUL  V11.8H, V19.8H, V0.H[0x7]
    UMULL V19.2D, V10.2S, V23.S[0x2]
    FMLS D3, D25, V22.D[0x0]
    FMLA V3.2D, V5.2D, V4.D[0x1]
    MLA  V16.4H, V6.4H, V12.H[0x0]
    MLA  V31.2S, V20.2S, V6.S[0x3]
    FMLA V13.2S, V10.2S, V16.S[0x0]
    FMUL V16.2D, V17.2D, V15.D[0x0]
    MLS  V21.4S, V28.4S, V31.S[0x3]
    FMLA S22, S6, V26.S[0x3]
    MLA  V21.2S, V30.2S, V11.S[0x2]
    FMUL S6, S30, V13.S[0x1]
    SQRDMULH  V16.4H, V29.4H, V15.H[0x3]
    MLS  V0.4S, V15.4S, V24.S[0x3]
    FMULX V3.2D, V26.2D, V28.D[0x0]
    FMUL V21.2D, V19.2D, V19.D[0x1]
    SQRDMULH  V9.2S, V23.2S, V23.S[0x3]
    FMLA V1.2D, V17.2D, V26.D[0x0]
    SQRDMULH  H0, H11, H13
    MUL  V31.4H, V10.4H, V13.H[0x3]
    FMULX V25.2S, V22.2S, V18.S[0x1]
    FMLS D1, D29, V0.D[0x0]
    FMLS V11.2S, V27.2S, V6.S[0x2]
    UMULL V26.4S, V18.4H, V1.H[0x7]
    FMLA S18, S16, V5.S[0x3]
    FMLS D11, D21, V18.D[0x1]
    FMLS S31, S19, V18.S[0x2]
    FMLA D0, D7, V7.D[0x1]
    FMULX V3.2D, V8.2D, V0.D[0x1]
    SQRDMULH  V10.8H, V14.8H, V13.H[0x3]
    SQRDMULH  H5, H28, H24
    MLA  V11.4H, V21.4H, V10.H[0x5]
    FMLS V13.2D, V16.2D, V29.D[0x1]
    UMULL2 V13.4S, V6.8H, V2.H[0x5]
    FMLA S22, S0, V27.S[0x2]
    MLA  V29.2S, V5.2S, V8.S[0x1]
    FMLS V31.2D, V0.2D, V2.D[0x1]
    FMUL S17, S19, V18.S[0x0]
    UMULL V23.4S, V2.4H, V1.H[0x7]
    SQRDMULH  V2.4H, V15.4H, V11.4H
    UMULL2 V8.4S, V1.8H, V3.H[0x3]
    SQRDMULH H13, H5, V5.H[0x0]
    FMLS S31, S22, V31.S[0x1]
    UMULL V5.2D, V7.2S, V18.S[0x3]
    SQRDMULH  V14.2S, V16.2S, V9.S[0x2]
    FMLA D7, D1, V29.D[0x1]
    MLS  V30.4H, V13.4H, V0.H[0x0]
    FMUL S26, S11, V26.S[0x3]
    FMLA V19.2D, V22.2D, V24.D[0x1]
    SQRDMULH  H20, H7, H8
    FMLS V26.4S, V26.4S, V22.S[0x1]
    FMLA S27, S26, V18.S[0x0]
    FMUL D26, D3, V27.D[0x0]
    MUL  V21.2S, V31.2S, V19.S[0x0]
    SQRDMULH  V4.2S, V17.2S, V14.2S
    FMULX S5, S10, V25.S[0x2]
    MUL  V28.4S, V23.4S, V20.S[0x1]
    FMUL D12, D12, V7.D[0x0]
    MLA  V12.4H, V10.4H, V2.H[0x3]
    SQRDMULH  V18.4H, V19.4H, V12.4H
    SQRDMULH  V25.2S, V4.2S, V0.S[0x3]
    FMULX D5, D17, V9.D[0x0]
    MLS  V28.4H, V26.4H, V8.H[0x2]
    SQRDMULH S28, S30, V11.S[0x0]
    FMUL V13.2S, V12.2S, V1.S[0x1]
    FMLS V28.4S, V19.4S, V13.S[0x2]
    MLA  V21.8H, V21.8H, V12.H[0x4]
    SQRDMULH  V18.4S, V6.4S, V10.4S
    MUL  V21.2S, V20.2S, V22.S[0x1]
    SQRDMULH  V2.2S, V25.2S, V6.S[0x0]
    FMLS S25, S11, V1.S[0x0]
    MLS  V5.8H, V7.8H, V10.H[0x3]
    FMLS V9.4S, V10.4S, V21.S[0x2]
    FMLS D18, D11, V27.D[0x1]
    FMUL V22.2D, V4.2D, V28.D[0x1]
    FMULX S29, S9, V20.S[0x0]
    UMULL V14.2D, V13.2S, V9.S[0x1]
    SQRDMULH H1, H11, V5.H[0x7]
    FMUL V26.2D, V7.2D, V2.D[0x1]
    UMULL2 V6.2D, V2.4S, V9.S[0x2]
    SQRDMULH  V12.4H, V5.4H, V1.H[0x4]
    UMULL2 V0.2D, V31.4S, V17.S[0x2]
    FMLA D22, D2, V27.D[0x0]
    MLS  V24.8H, V6.8H, V3.H[0x7]
    FMLA D14, D20, V0.D[0x1]
    FMULX D21, D19, V14.D[0x0]
    SQRDMULH H17, H21, V1.H[0x7]
    FMUL V24.4S, V4.4S, V11.S[0x2]
    SQRDMULH  V26.2S, V21.2S, V23.S[0x3]
    FMUL D24, D31, V8.D[0x1]
TaishanSimdWideNarryArthemticP01_label_63:
    FMUL D29, D20, V2.D[0x1]
    FMLA V25.2S, V7.2S, V29.S[0x0]
    FMULX S25, S10, V18.S[0x1]
    MLS  V30.8H, V0.8H, V15.H[0x1]
    SQRDMULH  V7.4H, V23.4H, V2.H[0x5]
    FMULX S2, S11, V17.S[0x1]
    FMLS V1.2D, V22.2D, V7.D[0x1]
    UMULL2 V18.2D, V1.4S, V2.S[0x0]
    SQRDMULH H30, H5, V7.H[0x7]
    FMULX S31, S18, V22.S[0x1]
    FMUL D5, D2, V9.D[0x1]
    FMUL V22.2D, V31.2D, V0.D[0x1]
    FMUL S28, S11, V4.S[0x3]
    FMLA D25, D2, V0.D[0x1]
    FMLA V7.2S, V20.2S, V23.S[0x2]
    FMLS D2, D24, V17.D[0x1]
    FMLA V28.2D, V17.2D, V0.D[0x0]
    FMLA D14, D6, V28.D[0x1]
    FMLA V1.2S, V16.2S, V14.S[0x1]
    MLS  V27.4H, V28.4H, V1.H[0x2]
    UMULL2 V18.2D, V27.4S, V10.S[0x3]
    UMULL V18.2D, V14.2S, V3.S[0x0]
    MLS  V8.2S, V14.2S, V25.S[0x1]
    UMULL V27.4S, V24.4H, V7.H[0x4]
    MUL  V26.4S, V19.4S, V21.S[0x0]
    FMLS D18, D16, V18.D[0x0]
    FMLA V17.4S, V9.4S, V8.S[0x0]
    SQRDMULH  V22.2S, V27.2S, V27.S[0x0]
    UMULL2 V0.2D, V0.4S, V26.S[0x0]
    MLS  V0.8H, V4.8H, V3.H[0x5]
    FMUL V17.2D, V31.2D, V29.D[0x0]
    FMLS S24, S14, V22.S[0x2]
    SQRDMULH  V0.2S, V0.2S, V26.2S
    MUL  V28.2S, V12.2S, V7.S[0x3]
    SQRDMULH S19, S24, V11.S[0x3]
    FMULX S7, S26, V9.S[0x2]
    FMLS V9.4S, V6.4S, V22.S[0x3]
    MUL  V2.4H, V9.4H, V15.H[0x5]
    SQRDMULH S16, S18, V18.S[0x0]
    FMLA V0.2D, V28.2D, V12.D[0x1]
    UMULL V16.4S, V7.4H, V4.H[0x1]
    FMLS S4, S5, V14.S[0x3]
    SQRDMULH H27, H11, V14.H[0x7]
    MUL  V16.4S, V4.4S, V3.S[0x3]
    FMLA D14, D7, V27.D[0x0]
    MLA  V7.4S, V14.4S, V19.S[0x3]
    FMLA V1.2D, V29.2D, V16.D[0x0]
    MLS  V26.8H, V10.8H, V0.H[0x7]
    MLS  V17.8H, V15.8H, V11.H[0x0]
    SQRDMULH S12, S23, V25.S[0x2]
    UMULL2 V24.2D, V15.4S, V14.S[0x2]
    FMUL V21.2D, V29.2D, V14.D[0x1]
    MLA  V13.8H, V20.8H, V2.H[0x4]
    FMLA D7, D15, V6.D[0x1]
    MLA  V26.8H, V16.8H, V12.H[0x7]
    FMLS S11, S4, V17.S[0x0]
    SQRDMULH H21, H25, V5.H[0x3]
    SUBS  X28, X28, #0x1
    B.NE  TaishanSimdWideNarryArthemticP01_label_166
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X12, X16, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X20, X2, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X27, X18, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X22, X16, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X23, X22, X7
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X23, X29, X8
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X4, X19, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X20, X23, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X14, X28, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X8, X21, X12
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X23, X12, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X4, X12, X15
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X28, X2, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X16, X26, X18
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X11, X18, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X21
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X22
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X20, X11, X23
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X15, X12, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X20, X5, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X23, X5, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, D2
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, V3.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, D3
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #48
    SUB  X9, X14, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X21, X11, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, D4
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #16
    SUB  X21, X11, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, D5
    MOVZ  X13, #0x1, LSL #0
    MOVK  X13, #0x8000, LSL #48
    SUB  X18, X13, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D6
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D7
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #16
    SUB  X5, X4, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, D8
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x8000, LSL #16
    MOVK  X21, #0x8000, LSL #48
    SUB  X10, X21, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, D9
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x8000, LSL #16
    MOVK  X21, #0x8000, LSL #48
    SUB  X10, X21, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X9, X12, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, D10
    MOVZ  X12, #0x0, LSL #0
    SUB  X9, X12, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, V11.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X23, X21, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, D11
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x8000, LSL #16
    SUB  X23, X21, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V12.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D12
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, D13
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x8000, LSL #16
    SUB  X29, X7, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X26
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, D14
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x4000, LSL #48
    SUB  X15, X13, X26
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X3, X18, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, D15
    MOVZ  X18, #0x0, LSL #0
    SUB  X3, X18, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, D16
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, V17.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, D17
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X9, X20, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, D18
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x8000, LSL #48
    SUB  X9, X20, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, D19
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, D20
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, V21.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, D21
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, D22
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, D23
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, D24
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X6, D26
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D27
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X17, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X17, D28
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, V29.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, D29
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X2, #0xe7ab, LSL #0
    MOVK  X2, #0xdbb2, LSL #16
    MOVK  X2, #0xc979, LSL #32
    MOVK  X2, #0x5f32, LSL #48
    MOVZ  X3, #0xf6fe, LSL #0
    MOVK  X3, #0x18da, LSL #16
    MOVK  X3, #0xf3c9, LSL #32
    MOVK  X3, #0x622d, LSL #48
    MOVZ  X4, #0xd458, LSL #0
    MOVK  X4, #0xa32, LSL #16
    MOVK  X4, #0x795b, LSL #32
    MOVK  X4, #0x37ef, LSL #48
    MOVZ  X5, #0x1a2e, LSL #0
    MOVK  X5, #0x9a5e, LSL #16
    MOVK  X5, #0x1a53, LSL #32
    MOVK  X5, #0x8062, LSL #48
    MOVZ  X6, #0xb2c2, LSL #0
    MOVK  X6, #0xb6ab, LSL #16
    MOVK  X6, #0xa0ab, LSL #32
    MOVK  X6, #0x24d9, LSL #48
    MOVZ  X7, #0x4a60, LSL #0
    MOVK  X7, #0xa653, LSL #16
    MOVK  X7, #0xeb2c, LSL #32
    MOVK  X7, #0xfa9f, LSL #48
    MOVZ  X8, #0x8234, LSL #0
    MOVK  X8, #0xbee3, LSL #16
    MOVK  X8, #0xc2c3, LSL #32
    MOVK  X8, #0xe9ca, LSL #48
    MOVZ  X9, #0x5548, LSL #0
    MOVK  X9, #0x1318, LSL #16
    MOVK  X9, #0xedbb, LSL #32
    MOVK  X9, #0xeb12, LSL #48
    MOVZ  X10, #0xff36, LSL #0
    MOVK  X10, #0x8029, LSL #16
    MOVK  X10, #0x4d47, LSL #32
    MOVK  X10, #0xfbeb, LSL #48
    MOVZ  X11, #0x20d0, LSL #0
    MOVK  X11, #0xeb5, LSL #16
    MOVK  X11, #0x594d, LSL #32
    MOVK  X11, #0xb722, LSL #48
    MOVZ  X12, #0x43c7, LSL #0
    MOVK  X12, #0xdfc1, LSL #16
    MOVK  X12, #0xf99c, LSL #32
    MOVK  X12, #0x113b, LSL #48
    MOVZ  X13, #0x2f92, LSL #0
    MOVK  X13, #0x7a4d, LSL #16
    MOVK  X13, #0x8559, LSL #32
    MOVK  X13, #0x1730, LSL #48
    MOVZ  X14, #0x19e3, LSL #0
    MOVK  X14, #0xd1b4, LSL #16
    MOVK  X14, #0x3d4, LSL #32
    MOVK  X14, #0x32be, LSL #48
    MOVZ  X15, #0x1608, LSL #0
    MOVK  X15, #0x9540, LSL #16
    MOVK  X15, #0xf78b, LSL #32
    MOVK  X15, #0xbf16, LSL #48
    MOVZ  X16, #0x5e1c, LSL #0
    MOVK  X16, #0xe42, LSL #16
    MOVK  X16, #0x2f2e, LSL #32
    MOVK  X16, #0xd6e, LSL #48
    MOVZ  X17, #0x1d2a, LSL #0
    MOVK  X17, #0xf2c2, LSL #16
    MOVK  X17, #0x64ef, LSL #32
    MOVK  X17, #0x59b9, LSL #48
    MOVZ  X18, #0xddbb, LSL #0
    MOVK  X18, #0xbfc, LSL #16
    MOVK  X18, #0x49fe, LSL #32
    MOVK  X18, #0x4ec4, LSL #48
    MOVZ  X19, #0x4b39, LSL #0
    MOVK  X19, #0xe26, LSL #16
    MOVK  X19, #0xfd8a, LSL #32
    MOVK  X19, #0x3602, LSL #48
    MOVZ  X20, #0xbe22, LSL #0
    MOVK  X20, #0xde71, LSL #16
    MOVK  X20, #0xba2e, LSL #32
    MOVK  X20, #0xb80a, LSL #48
    MOVZ  X21, #0x1b3e, LSL #0
    MOVK  X21, #0xc299, LSL #16
    MOVK  X21, #0xf2b2, LSL #32
    MOVK  X21, #0xc105, LSL #48
    MOVZ  X22, #0xcdce, LSL #0
    MOVK  X22, #0x3487, LSL #16
    MOVK  X22, #0x5139, LSL #32
    MOVK  X22, #0xa5a8, LSL #48
    MOVZ  X23, #0x45e9, LSL #0
    MOVK  X23, #0xff07, LSL #16
    MOVK  X23, #0xeaea, LSL #32
    MOVK  X23, #0xc87a, LSL #48
    MOVZ  X24, #0xa291, LSL #0
    MOVK  X24, #0x7db9, LSL #16
    MOVK  X24, #0x2afe, LSL #32
    MOVK  X24, #0xdd26, LSL #48
    MOVZ  X26, #0x830e, LSL #0
    MOVK  X26, #0x163a, LSL #16
    MOVK  X26, #0xdec, LSL #32
    MOVK  X26, #0x5eb8, LSL #48
    MOVZ  X27, #0x1dcf, LSL #0
    MOVK  X27, #0x543a, LSL #16
    MOVK  X27, #0x8562, LSL #32
    MOVK  X27, #0x2eed, LSL #48
    MOVZ  X28, #0x4e81, LSL #0
    MOVK  X28, #0x583, LSL #16
    MOVK  X28, #0x3727, LSL #32
    MOVK  X28, #0xef8b, LSL #48
    MOVZ  X29, #0xa09d, LSL #0
    MOVK  X29, #0x94ec, LSL #16
    MOVK  X29, #0x50dc, LSL #32
    MOVK  X29, #0x8abd, LSL #48
    FMOV  D0, X20
    FMOV  V0.D[1], X21
    FMOV  D1, X29
    FMOV  V1.D[1], X24
    FMOV  D2, X10
    FMOV  V2.D[1], X22
    FMOV  D3, X26
    FMOV  V3.D[1], X23
    FMOV  D4, X14
    FMOV  V4.D[1], X11
    FMOV  D5, X28
    FMOV  V5.D[1], X16
    FMOV  D6, X14
    FMOV  V6.D[1], X16
    FMOV  D7, X19
    FMOV  V7.D[1], X26
    FMOV  D8, X12
    FMOV  V8.D[1], X5
    FMOV  D9, X3
    FMOV  V9.D[1], X24
    FMOV  D10, X14
    FMOV  V10.D[1], X21
    FMOV  D11, X12
    FMOV  V11.D[1], X16
    FMOV  D12, X6
    FMOV  V12.D[1], X29
    FMOV  D13, X6
    FMOV  V13.D[1], X16
    FMOV  D14, X5
    FMOV  V14.D[1], X7
    FMOV  D15, X26
    FMOV  V15.D[1], X3
    FMOV  D16, X2
    FMOV  V16.D[1], X11
    FMOV  D17, X27
    FMOV  V17.D[1], X20
    FMOV  D18, X5
    FMOV  V18.D[1], X6
    FMOV  D19, X21
    FMOV  V19.D[1], X6
    FMOV  D20, X14
    FMOV  V20.D[1], X20
    FMOV  D21, X8
    FMOV  V21.D[1], X11
    FMOV  D22, X20
    FMOV  V22.D[1], X7
    FMOV  D23, X29
    FMOV  V23.D[1], X24
    FMOV  D24, X19
    FMOV  V24.D[1], X14
    FMOV  D25, X2
    FMOV  V25.D[1], X23
    FMOV  D26, X3
    FMOV  V26.D[1], X14
    FMOV  D27, X6
    FMOV  V27.D[1], X14
    FMOV  D28, X7
    FMOV  V28.D[1], X29
    FMOV  D29, X12
    FMOV  V29.D[1], X24
    FMOV  D30, X3
    FMOV  V30.D[1], X27
    FMOV  D31, X13
    FMOV  V31.D[1], X6
    MOVZ  X7, #0xa, LSL #0
TaishanSimdWideNarryArthemticP01_label_249:
    FMUL V25.2D, V30.2D, V26.D[0x0]
    FMUL V27.2D, V18.2D, V11.D[0x0]
    FMULX V24.4S, V24.4S, V29.S[0x3]
    MLA  V30.8H, V14.8H, V7.H[0x3]
    FMLA V30.2D, V28.2D, V27.D[0x1]
    SQRDMULH  V2.4S, V30.4S, V29.S[0x3]
    FMLS S2, S22, V11.S[0x1]
    SQRDMULH  V27.4S, V31.4S, V1.4S
    FMLS V20.2D, V25.2D, V15.D[0x0]
    UMULL V15.4S, V23.4H, V14.H[0x7]
    MLA  V24.2S, V19.2S, V14.S[0x2]
    MLA  V25.4H, V19.4H, V15.H[0x1]
    FMLS V13.2S, V25.2S, V2.S[0x0]
    FMUL V11.2D, V28.2D, V11.D[0x1]
    FMLA D9, D22, V28.D[0x0]
    SQRDMULH  V15.8H, V8.8H, V5.H[0x5]
    MUL  V30.4H, V31.4H, V0.H[0x1]
    UMULL V27.2D, V2.2S, V12.S[0x0]
    SQRDMULH  H12, H29, H14
    FMLA D10, D13, V19.D[0x1]
    FMULX D31, D18, V2.D[0x1]
    SQRDMULH  S23, S0, S13
    FMLA V31.4S, V13.4S, V20.S[0x3]
    UMULL2 V17.2D, V18.4S, V3.S[0x2]
    FMLA V23.4S, V26.4S, V30.S[0x2]
    MLS  V15.8H, V14.8H, V2.H[0x5]
    FMLA V14.4S, V25.4S, V5.S[0x3]
    FMLA S28, S7, V25.S[0x2]
    MLA  V6.8H, V7.8H, V3.H[0x0]
    UMULL2 V11.4S, V29.8H, V7.H[0x4]
    MLA  V16.4H, V18.4H, V13.H[0x5]
    MLA  V10.4S, V6.4S, V15.S[0x0]
    FMLS D11, D6, V10.D[0x0]
    UMULL V27.2D, V29.2S, V21.S[0x2]
    UMULL V28.4S, V26.4H, V6.H[0x0]
    FMUL D24, D7, V19.D[0x1]
    MUL  V7.2S, V12.2S, V30.S[0x2]
    FMULX V11.2S, V26.2S, V3.S[0x3]
    MLS  V31.4H, V7.4H, V14.H[0x4]
    SQRDMULH S21, S4, V23.S[0x1]
    UMULL2 V16.2D, V20.4S, V7.S[0x0]
    UMULL2 V21.4S, V22.8H, V1.H[0x4]
    FMULX V14.2D, V0.2D, V13.D[0x0]
    FMULX S19, S16, V27.S[0x2]
    FMLS S9, S12, V2.S[0x3]
    FMLS V14.2D, V12.2D, V1.D[0x0]
    FMLA S18, S10, V10.S[0x3]
    FMLA S27, S8, V19.S[0x2]
    SQRDMULH S12, S11, V9.S[0x3]
    FMLS S19, S15, V22.S[0x0]
    SQRDMULH  V17.4H, V5.4H, V12.H[0x5]
    FMLA S7, S28, V24.S[0x3]
    FMLS S31, S11, V5.S[0x2]
    FMLS V6.4S, V7.4S, V28.S[0x2]
    UMULL2 V30.4S, V21.8H, V5.H[0x1]
    FMLS V20.2D, V21.2D, V17.D[0x1]
    SQRDMULH H31, H3, V14.H[0x2]
    UMULL V25.2D, V26.2S, V3.S[0x2]
    FMLA D11, D29, V13.D[0x0]
    MLS  V8.2S, V3.2S, V28.S[0x1]
    FMULX V5.2D, V8.2D, V10.D[0x1]
    MLA  V19.2S, V1.2S, V7.S[0x3]
    MLA  V12.4H, V16.4H, V14.H[0x5]
    UMULL2 V26.2D, V15.4S, V28.S[0x0]
    UMULL V12.2D, V3.2S, V5.S[0x2]
    FMULX V15.2D, V1.2D, V10.D[0x0]
    SQRDMULH  H31, H20, H9
    UMULL2 V19.2D, V1.4S, V14.S[0x0]
    FMUL V6.2D, V1.2D, V4.D[0x0]
    FMLS S14, S8, V18.S[0x2]
    FMULX D21, D22, V2.D[0x0]
    SQRDMULH  V14.2S, V0.2S, V26.S[0x3]
    MUL  V29.4S, V25.4S, V28.S[0x3]
    UMULL V12.4S, V28.4H, V6.H[0x4]
    FMULX D7, D20, V0.D[0x0]
    UMULL2 V10.2D, V28.4S, V16.S[0x3]
    FMUL V29.2S, V21.2S, V22.S[0x2]
    MLA  V7.2S, V6.2S, V0.S[0x1]
    FMLA D6, D18, V9.D[0x1]
    UMULL2 V13.4S, V4.8H, V1.H[0x0]
    FMULX S12, S11, V22.S[0x3]
    UMULL V4.4S, V19.4H, V12.H[0x0]
    MLS  V3.4S, V23.4S, V21.S[0x3]
    MLS  V5.4H, V19.4H, V5.H[0x2]
    SQRDMULH  V25.2S, V31.2S, V4.2S
    UMULL2 V27.4S, V0.8H, V9.H[0x4]
    MUL  V26.2S, V25.2S, V13.S[0x0]
    FMULX S14, S19, V24.S[0x1]
    FMLA V28.2D, V7.2D, V13.D[0x1]
    FMUL S21, S1, V9.S[0x0]
    FMUL S25, S18, V3.S[0x0]
    UMULL V20.2D, V10.2S, V0.S[0x0]
    MLS  V31.4H, V6.4H, V6.H[0x2]
    SQRDMULH  H3, H13, H15
    UMULL V9.4S, V4.4H, V4.H[0x2]
    FMUL V31.2D, V2.2D, V12.D[0x1]
    FMLS V27.2D, V5.2D, V24.D[0x1]
    FMLS V11.2D, V30.2D, V27.D[0x1]
    FMUL V1.2S, V23.2S, V26.S[0x1]
    FMLS D14, D27, V29.D[0x0]
    FMLS V16.2S, V21.2S, V28.S[0x0]
    FMLA V11.4S, V16.4S, V11.S[0x0]
    SQRDMULH  V16.2S, V2.2S, V13.S[0x1]
    UMULL2 V28.4S, V7.8H, V5.H[0x7]
    FMLA V20.2D, V25.2D, V28.D[0x1]
    UMULL2 V24.4S, V9.8H, V1.H[0x1]
    SQRDMULH  V6.4H, V7.4H, V13.H[0x7]
    FMUL V3.2D, V6.2D, V4.D[0x1]
    MLS  V9.8H, V21.8H, V9.H[0x7]
    FMUL V9.2D, V20.2D, V1.D[0x1]
    FMUL V14.4S, V13.4S, V19.S[0x2]
    FMUL V4.4S, V2.4S, V25.S[0x3]
    UMULL2 V7.4S, V24.8H, V7.H[0x6]
    FMLA D8, D6, V0.D[0x0]
    FMUL S0, S24, V21.S[0x3]
    SQRDMULH  V31.2S, V28.2S, V24.2S
    SQRDMULH H23, H3, V1.H[0x6]
    SQRDMULH  H0, H26, H11
    MLS  V14.4S, V19.4S, V16.S[0x0]
    SQRDMULH H6, H9, V13.H[0x0]
    UMULL2 V25.4S, V13.8H, V5.H[0x4]
    SQRDMULH S21, S19, V31.S[0x2]
    FMULX V20.2S, V14.2S, V7.S[0x2]
    SQRDMULH  V8.2S, V8.2S, V0.S[0x3]
    FMLS V3.4S, V13.4S, V17.S[0x3]
    FMULX S16, S16, V15.S[0x0]
    FMLA S12, S11, V12.S[0x2]
    MLS  V30.4H, V11.4H, V4.H[0x2]
    SQRDMULH  V26.2S, V2.2S, V26.S[0x1]
    FMUL V11.2D, V16.2D, V10.D[0x0]
    FMLA D17, D10, V1.D[0x1]
    FMULX S24, S15, V8.S[0x1]
    UMULL2 V0.2D, V13.4S, V26.S[0x0]
    FMUL D1, D7, V20.D[0x1]
    SQRDMULH  S0, S10, S5
    FMULX D4, D17, V17.D[0x0]
    UMULL2 V7.2D, V0.4S, V28.S[0x1]
    SQRDMULH  S9, S31, S7
    SQRDMULH  H28, H23, H1
    FMLS S28, S31, V26.S[0x3]
    FMLA V9.4S, V13.4S, V8.S[0x1]
    SQRDMULH  V24.2S, V2.2S, V30.S[0x0]
    FMULX D5, D10, V17.D[0x1]
    UMULL V30.2D, V17.2S, V2.S[0x3]
    SQRDMULH  S2, S16, S26
    FMLA V20.4S, V8.4S, V30.S[0x2]
    UMULL V21.2D, V5.2S, V1.S[0x3]
    MUL  V28.2S, V21.2S, V17.S[0x0]
    SQRDMULH  V11.2S, V13.2S, V31.S[0x2]
    FMUL S6, S5, V0.S[0x3]
    FMULX V22.4S, V2.4S, V18.S[0x2]
    FMUL S8, S3, V5.S[0x3]
    MLS  V14.2S, V26.2S, V18.S[0x3]
    SQRDMULH  V27.4H, V11.4H, V8.H[0x1]
    MUL  V31.4H, V24.4H, V0.H[0x7]
    FMLS V6.2S, V10.2S, V1.S[0x0]
    MUL  V20.4S, V1.4S, V21.S[0x0]
    UMULL2 V21.2D, V10.4S, V16.S[0x3]
    UMULL2 V6.4S, V22.8H, V13.H[0x5]
    FMUL V3.2S, V28.2S, V18.S[0x0]
    SQRDMULH  V11.4S, V19.4S, V27.S[0x1]
    MUL  V22.8H, V4.8H, V5.H[0x5]
    FMLS V8.2S, V22.2S, V21.S[0x3]
    SQRDMULH S2, S0, V7.S[0x1]
    SQRDMULH  V29.2S, V2.2S, V5.S[0x3]
    SQRDMULH  V16.4S, V9.4S, V11.S[0x1]
    FMLS D16, D29, V29.D[0x1]
    FMLS V13.2D, V25.2D, V1.D[0x0]
    FMLS D30, D13, V8.D[0x0]
    MUL  V16.2S, V28.2S, V2.S[0x1]
    FMUL V26.2S, V7.2S, V26.S[0x0]
    FMLA S30, S17, V14.S[0x0]
    FMLS S7, S4, V19.S[0x3]
    SQRDMULH  S2, S14, S9
    MLS  V0.4S, V3.4S, V9.S[0x3]
    SQRDMULH  V16.4S, V15.4S, V13.4S
    FMUL D5, D29, V26.D[0x0]
    FMULX S25, S19, V31.S[0x0]
    FMLA V7.4S, V26.4S, V21.S[0x3]
    SQRDMULH  V5.2S, V26.2S, V22.2S
    MLA  V0.4S, V9.4S, V6.S[0x0]
    FMUL V18.4S, V11.4S, V0.S[0x0]
    FMULX V31.2S, V6.2S, V23.S[0x1]
    UMULL2 V22.2D, V15.4S, V30.S[0x1]
    SQRDMULH  H4, H17, H16
    FMULX V4.2S, V16.2S, V2.S[0x3]
    MLS  V8.8H, V7.8H, V12.H[0x5]
    FMLA V26.4S, V3.4S, V12.S[0x3]
    FMLA S29, S8, V20.S[0x0]
    SQRDMULH H12, H21, V4.H[0x4]
    FMLS D9, D1, V29.D[0x0]
    FMULX V19.4S, V31.4S, V22.S[0x1]
    FMLS S27, S13, V13.S[0x3]
    FMULX D28, D24, V27.D[0x1]
    FMUL D18, D7, V25.D[0x1]
    FMLS S14, S6, V7.S[0x2]
    SQRDMULH  S20, S4, S24
    FMLA V0.2D, V13.2D, V27.D[0x0]
    FMULX V19.4S, V10.4S, V5.S[0x3]
    FMLA S6, S4, V16.S[0x1]
    SUBS  X7, X7, #0x1
    B.NE  TaishanSimdWideNarryArthemticP01_label_249
    MOVZ  X20, #0xe7ab, LSL #0
    MOVK  X20, #0xdbb2, LSL #16
    MOVK  X20, #0xc979, LSL #32
    MOVK  X20, #0x5f32, LSL #48
    SUB  X5, X20, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X21, #0xf6fe, LSL #0
    MOVK  X21, #0x18da, LSL #16
    MOVK  X21, #0xf3c9, LSL #32
    MOVK  X21, #0x622d, LSL #48
    SUB  X28, X21, X3
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X22, #0xd458, LSL #0
    MOVK  X22, #0xa32, LSL #16
    MOVK  X22, #0x795b, LSL #32
    MOVK  X22, #0x37ef, LSL #48
    SUB  X12, X22, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X6, #0xb2c2, LSL #0
    MOVK  X6, #0xb6ab, LSL #16
    MOVK  X6, #0xa0ab, LSL #32
    MOVK  X6, #0x24d9, LSL #48
    SUB  X24, X6, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X24, X8, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X22, #0x5548, LSL #0
    MOVK  X22, #0x1318, LSL #16
    MOVK  X22, #0xedbb, LSL #32
    MOVK  X22, #0xeb12, LSL #48
    SUB  X13, X22, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X18, #0xff36, LSL #0
    MOVK  X18, #0x8029, LSL #16
    MOVK  X18, #0x4d47, LSL #32
    MOVK  X18, #0xfbeb, LSL #48
    SUB  X28, X18, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X9, X12, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X24, #0x19e3, LSL #0
    MOVK  X24, #0xd1b4, LSL #16
    MOVK  X24, #0x3d4, LSL #32
    MOVK  X24, #0x32be, LSL #48
    SUB  X29, X24, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X10, #0x1608, LSL #0
    MOVK  X10, #0x9540, LSL #16
    MOVK  X10, #0xf78b, LSL #32
    MOVK  X10, #0xbf16, LSL #48
    SUB  X11, X10, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X20, #0x1d2a, LSL #0
    MOVK  X20, #0xf2c2, LSL #16
    MOVK  X20, #0x64ef, LSL #32
    MOVK  X20, #0x59b9, LSL #48
    SUB  X24, X20, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X9, #0xff36, LSL #0
    MOVK  X9, #0x8029, LSL #16
    MOVK  X9, #0x4d47, LSL #32
    MOVK  X9, #0xfbeb, LSL #48
    SUB  X19, X9, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X24, X15, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X5, #0x1d2a, LSL #0
    MOVK  X5, #0xf2c2, LSL #16
    MOVK  X5, #0x64ef, LSL #32
    MOVK  X5, #0x59b9, LSL #48
    SUB  X11, X5, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X26, #0xf6fe, LSL #0
    MOVK  X26, #0x18da, LSL #16
    MOVK  X26, #0xf3c9, LSL #32
    MOVK  X26, #0x622d, LSL #48
    SUB  X23, X26, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X22
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X26
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X9
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, D2
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X9
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D3
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X10, X28, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D4
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0x7fff, LSL #48
    SUB  X10, X28, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, V5.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, D5
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X29, X15, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, D6
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0x7fff, LSL #16
    SUB  X29, X15, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, D7
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x8000, LSL #16
    SUB  X28, X24, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, D8
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x8000, LSL #16
    MOVK  X29, #0x8000, LSL #48
    SUB  X18, X29, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, D9
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8000, LSL #48
    SUB  X14, X13, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X4, X6, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, D10
    MOVZ  X6, #0x0, LSL #0
    SUB  X4, X6, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, D11
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, V12.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, D12
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x8000, LSL #48
    SUB  X19, X7, X9
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, D13
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x8000, LSL #48
    SUB  X19, X7, X9
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X21, X20, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X17, D14
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x8000, LSL #16
    SUB  X21, X20, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x8000, LSL #48
    SUB  X11, X26, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, D15
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x8000, LSL #48
    SUB  X11, X26, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0x7fff, LSL #48
    SUB  X2, X10, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, D16
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0x7fff, LSL #48
    SUB  X2, X10, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D17
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, D18
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, D19
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, D20
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X15, X29, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, D21
    MOVZ  X29, #0x0, LSL #0
    SUB  X15, X29, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, D22
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, D23
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, D24
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, D26
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, D27
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, D28
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, V29.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X15
TaishanSimdWideNarryArthemticP01_label_78:
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, D29
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x8000, LSL #16
    SUB  X17, X23, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
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
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X16
    FMOV  V0.D[1], X13
    FMOV  D1, X23
    FMOV  V1.D[1], X9
    FMOV  D2, X6
    FMOV  V2.D[1], X14
    FMOV  D3, X9
    FMOV  V3.D[1], X15
    FMOV  D4, X20
    FMOV  V4.D[1], X18
    FMOV  D5, X17
    FMOV  V5.D[1], X20
    FMOV  D6, X23
    FMOV  V6.D[1], X14
    FMOV  D7, X18
    FMOV  V7.D[1], X15
    FMOV  D8, X10
    FMOV  V8.D[1], X22
    FMOV  D9, X15
    FMOV  V9.D[1], X18
    FMOV  D10, X23
    FMOV  V10.D[1], X26
    FMOV  D11, X5
    FMOV  V11.D[1], X11
    FMOV  D12, X21
    FMOV  V12.D[1], X29
    FMOV  D13, X20
    FMOV  V13.D[1], X6
    FMOV  D14, X23
    FMOV  V14.D[1], X26
    FMOV  D15, X12
    FMOV  V15.D[1], X11
    FMOV  D16, X13
    FMOV  V16.D[1], X10
    FMOV  D17, X15
    FMOV  V17.D[1], X16
    FMOV  D18, X14
    FMOV  V18.D[1], X29
    FMOV  D19, X27
    FMOV  V19.D[1], X22
    FMOV  D20, X2
    FMOV  V20.D[1], X6
    FMOV  D21, X5
    FMOV  V21.D[1], X12
    FMOV  D22, X11
    FMOV  V22.D[1], X14
    FMOV  D23, X11
    FMOV  V23.D[1], X19
    FMOV  D24, X5
    FMOV  V24.D[1], X10
    FMOV  D25, X18
    FMOV  V25.D[1], X13
    FMOV  D26, X9
    FMOV  V26.D[1], X6
    FMOV  D27, X11
    FMOV  V27.D[1], X13
    FMOV  D28, X3
    FMOV  V28.D[1], X6
    FMOV  D29, X29
    FMOV  V29.D[1], X21
    FMOV  D30, X19
    FMOV  V30.D[1], X27
    FMOV  D31, X27
    FMOV  V31.D[1], X6
    MOVZ  X8, #0xa, LSL #0
TaishanSimdWideNarryArthemticP01_label_332:
    FMUL S3, S22, V13.S[0x1]
    FMUL D30, D14, V30.D[0x0]
    FMLS V20.2S, V30.2S, V13.S[0x1]
    FMLA S31, S31, V0.S[0x2]
    FMLA V18.2S, V31.2S, V28.S[0x2]
    FMLA V14.4S, V4.4S, V28.S[0x3]
    FMULX S14, S14, V17.S[0x3]
    SQRDMULH  V13.2S, V8.2S, V5.S[0x1]
    SQRDMULH  H17, H31, H4
    SQRDMULH  V5.8H, V20.8H, V29.8H
    MLS  V21.8H, V14.8H, V13.H[0x4]
    MLS  V20.8H, V10.8H, V3.H[0x0]
    MLA  V26.2S, V15.2S, V21.S[0x1]
    SQRDMULH  V5.4S, V29.4S, V14.S[0x3]
    SQRDMULH S31, S2, V15.S[0x0]
    SQRDMULH  S4, S26, S20
    FMLS V8.4S, V7.4S, V26.S[0x0]
    UMULL2 V31.4S, V22.8H, V12.H[0x2]
    FMULX D8, D29, V17.D[0x1]
    FMUL V29.2S, V30.2S, V28.S[0x2]
    MUL  V0.2S, V23.2S, V18.S[0x0]
    FMULX S13, S2, V7.S[0x0]
    UMULL V8.2D, V21.2S, V16.S[0x3]
    FMLA D13, D12, V26.D[0x1]
    MLS  V4.4H, V6.4H, V14.H[0x5]
    FMLS V1.4S, V2.4S, V3.S[0x1]
    FMULX D0, D7, V25.D[0x1]
    FMULX S5, S2, V20.S[0x2]
    FMULX V31.2D, V21.2D, V7.D[0x0]
    FMLS D17, D18, V16.D[0x0]
    MLS  V11.2S, V16.2S, V19.S[0x3]
    FMULX V23.2S, V20.2S, V4.S[0x2]
    SQRDMULH  V31.4S, V0.4S, V8.S[0x3]
    MUL  V22.4H, V26.4H, V1.H[0x7]
    MUL  V0.4S, V15.4S, V30.S[0x2]
    MLS  V18.2S, V28.2S, V12.S[0x2]
    SQRDMULH  V1.4H, V1.4H, V5.H[0x5]
    UMULL V23.4S, V3.4H, V7.H[0x5]
    FMUL V17.2D, V22.2D, V12.D[0x0]
    FMULX S21, S22, V25.S[0x3]
    UMULL2 V22.4S, V25.8H, V13.H[0x7]
    FMUL V15.2S, V0.2S, V31.S[0x0]
    FMLS D22, D15, V13.D[0x1]
    FMLA V3.4S, V15.4S, V22.S[0x1]
    FMLA V5.2S, V20.2S, V7.S[0x3]
    FMULX V23.2D, V29.2D, V28.D[0x0]
    MLA  V31.4H, V5.4H, V12.H[0x4]
    FMLS V31.2S, V8.2S, V30.S[0x0]
    UMULL2 V21.2D, V25.4S, V15.S[0x2]
    FMLA S14, S30, V22.S[0x3]
    FMLA V18.4S, V12.4S, V26.S[0x1]
    MLA  V26.4S, V19.4S, V5.S[0x2]
    FMLS D15, D5, V21.D[0x0]
    FMLA V18.2S, V0.2S, V21.S[0x0]
    FMULX V14.2S, V2.2S, V17.S[0x1]
    MUL  V19.4S, V12.4S, V18.S[0x2]
    FMLS S3, S2, V13.S[0x3]
    MLS  V26.4H, V1.4H, V5.H[0x2]
    UMULL2 V11.4S, V15.8H, V9.H[0x1]
    FMULX V12.4S, V7.4S, V17.S[0x3]
    MLS  V18.2S, V11.2S, V28.S[0x2]
    FMULX V12.2S, V22.2S, V0.S[0x1]
    FMULX D14, D20, V21.D[0x1]
    FMLA V3.4S, V23.4S, V11.S[0x2]
    FMUL V21.4S, V14.4S, V9.S[0x2]
    FMLA S21, S30, V11.S[0x0]
    FMLA V29.4S, V19.4S, V10.S[0x0]
    FMLS V10.2D, V20.2D, V3.D[0x0]
    SQRDMULH  S10, S5, S5
    FMUL V28.2D, V11.2D, V22.D[0x1]
    UMULL2 V0.2D, V14.4S, V5.S[0x2]
    FMUL V30.2S, V19.2S, V6.S[0x1]
    MLA  V29.8H, V0.8H, V0.H[0x5]
    FMLS D20, D17, V7.D[0x1]
    FMULX V14.2D, V31.2D, V6.D[0x1]
    FMULX D23, D6, V10.D[0x0]
    SQRDMULH  H16, H10, H28
    UMULL2 V21.2D, V1.4S, V0.S[0x0]
    SQRDMULH  V5.2S, V23.2S, V30.2S
    UMULL V15.4S, V5.4H, V12.H[0x1]
    FMLS V9.2S, V5.2S, V5.S[0x3]
    MLA  V24.2S, V2.2S, V27.S[0x0]
    SQRDMULH  V21.8H, V29.8H, V4.H[0x7]
    FMUL D0, D3, V7.D[0x0]
    SQRDMULH  S26, S1, S27
    MLS  V8.4S, V24.4S, V0.S[0x1]
    SQRDMULH  V7.4S, V16.4S, V6.S[0x3]
    MLA  V3.4S, V17.4S, V18.S[0x0]
    FMULX S14, S17, V0.S[0x0]
    MUL  V19.8H, V20.8H, V5.H[0x4]
    MUL  V29.8H, V12.8H, V6.H[0x6]
    SQRDMULH  V6.2S, V28.2S, V9.2S
    MLS  V12.8H, V13.8H, V11.H[0x4]
    SQRDMULH H9, H24, V15.H[0x1]
    FMLA V8.2D, V21.2D, V1.D[0x0]
    MLS  V10.4H, V26.4H, V9.H[0x2]
    SQRDMULH  V7.8H, V7.8H, V14.8H
    FMUL S16, S7, V20.S[0x1]
    UMULL V8.4S, V18.4H, V14.H[0x3]
    FMLS V21.2D, V27.2D, V15.D[0x1]
    FMUL D31, D30, V11.D[0x0]
    FMULX V31.2D, V8.2D, V10.D[0x1]
    SQRDMULH  V21.2S, V31.2S, V6.S[0x0]
    FMULX V11.2D, V26.2D, V14.D[0x1]
    FMULX D9, D25, V24.D[0x0]
    FMLS S28, S12, V21.S[0x2]
    MLA  V14.8H, V11.8H, V15.H[0x3]
    SQRDMULH  H24, H14, H30
    FMUL S0, S1, V21.S[0x1]
    FMULX S26, S3, V7.S[0x0]
    FMULX S29, S20, V9.S[0x0]
    FMLS V20.4S, V0.4S, V1.S[0x1]
    SQRDMULH S14, S5, V24.S[0x0]
    UMULL2 V30.2D, V8.4S, V28.S[0x0]
    UMULL2 V5.2D, V16.4S, V13.S[0x0]
    FMULX V15.2S, V7.2S, V4.S[0x3]
    MLA  V4.4S, V20.4S, V12.S[0x0]
    MLA  V4.8H, V18.8H, V15.H[0x7]
    FMLS D26, D12, V14.D[0x1]
    SQRDMULH  V18.2S, V31.2S, V25.S[0x3]
    SQRDMULH  H29, H4, H30
    MLA  V10.8H, V6.8H, V11.H[0x3]
    FMLS S21, S15, V21.S[0x0]
    SQRDMULH  S19, S16, S15
    FMLA D14, D5, V10.D[0x0]
    MUL  V14.2S, V6.2S, V0.S[0x0]
    FMULX V5.2S, V26.2S, V4.S[0x1]
    FMLA V6.2D, V1.2D, V0.D[0x1]
    FMLA S21, S26, V9.S[0x1]
    FMUL D8, D7, V10.D[0x0]
    MLS  V10.2S, V1.2S, V18.S[0x1]
    FMLA V14.4S, V9.4S, V30.S[0x2]
    SQRDMULH H15, H18, V9.H[0x5]
    MLA  V14.4H, V25.4H, V6.H[0x1]
    FMULX S12, S2, V29.S[0x1]
    SQRDMULH  S9, S11, S4
    FMLA V6.2D, V31.2D, V26.D[0x0]
    FMLS S0, S6, V26.S[0x1]
    FMLA S5, S10, V19.S[0x1]
    FMULX S18, S15, V31.S[0x0]
    UMULL2 V28.4S, V30.8H, V13.H[0x5]
    FMULX S11, S16, V29.S[0x3]
    FMLA V22.2S, V2.2S, V4.S[0x0]
    SQRDMULH  V14.8H, V0.8H, V11.H[0x4]
    MLA  V5.8H, V26.8H, V13.H[0x1]
    MLS  V18.2S, V22.2S, V7.S[0x0]
    SQRDMULH  H26, H16, H23
    MLS  V26.2S, V12.2S, V18.S[0x1]
    MLA  V4.2S, V5.2S, V5.S[0x1]
    MUL  V16.8H, V31.8H, V6.H[0x3]
    FMUL V7.4S, V30.4S, V10.S[0x1]
    MLS  V16.8H, V22.8H, V1.H[0x5]
    FMLS V13.2D, V16.2D, V30.D[0x1]
    FMULX V21.2D, V27.2D, V9.D[0x1]
    MLA  V29.8H, V7.8H, V5.H[0x4]
    FMLS V4.2D, V6.2D, V20.D[0x1]
    FMLA V8.2D, V23.2D, V1.D[0x0]
    UMULL2 V4.2D, V14.4S, V3.S[0x1]
    FMLS S3, S26, V27.S[0x3]
    FMLS D9, D28, V27.D[0x0]
    FMLS S6, S9, V4.S[0x0]
    MUL  V22.4S, V15.4S, V12.S[0x0]
    SQRDMULH  S13, S21, S20
    MUL  V24.8H, V19.8H, V3.H[0x4]
    FMUL S18, S29, V17.S[0x3]
    UMULL2 V10.4S, V1.8H, V0.H[0x4]
    FMULX S8, S15, V30.S[0x0]
    FMULX S27, S8, V31.S[0x3]
    FMLS V5.2D, V5.2D, V0.D[0x0]
    MLA  V6.4S, V13.4S, V24.S[0x0]
    MLS  V5.8H, V4.8H, V3.H[0x2]
    MUL  V14.2S, V10.2S, V22.S[0x0]
    MLA  V22.4H, V6.4H, V0.H[0x3]
    SQRDMULH H22, H11, V11.H[0x4]
    FMUL V15.4S, V11.4S, V24.S[0x3]
    MLS  V11.2S, V10.2S, V17.S[0x3]
    FMLS D29, D15, V16.D[0x0]
    FMULX D30, D0, V7.D[0x1]
    SQRDMULH  S5, S8, S31
    FMUL V19.2S, V12.2S, V30.S[0x1]
    MLA  V18.2S, V14.2S, V29.S[0x1]
    MLA  V11.4S, V4.4S, V12.S[0x2]
    MLA  V21.2S, V23.2S, V24.S[0x1]
    FMLA D31, D17, V13.D[0x0]
    SQRDMULH  V11.4H, V5.4H, V6.H[0x6]
    SQRDMULH S16, S10, V30.S[0x2]
    UMULL V21.4S, V2.4H, V8.H[0x2]
    MUL  V29.4S, V6.4S, V7.S[0x2]
    FMUL S9, S15, V16.S[0x2]
    MLA  V20.2S, V4.2S, V31.S[0x2]
    MLA  V12.4H, V7.4H, V14.H[0x1]
    MUL  V0.4S, V17.4S, V8.S[0x1]
    FMUL V18.2S, V27.2S, V9.S[0x3]
    UMULL V11.4S, V22.4H, V0.H[0x4]
    SQRDMULH  S3, S26, S2
    SQRDMULH  V19.8H, V26.8H, V10.8H
    FMLA V25.2D, V22.2D, V4.D[0x0]
    FMLA V13.2S, V12.2S, V1.S[0x1]
    SQRDMULH S12, S16, V20.S[0x0]
    FMUL V2.2D, V1.2D, V2.D[0x0]
    SUBS  X8, X8, #0x1
    B.NE  TaishanSimdWideNarryArthemticP01_label_332
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X4
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X9
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X12
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X10, X4, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X4, X5, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X16
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X18, X3, X18
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X28, X19, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X3, X22, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X21, X14, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X10, X18, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X5, X20, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, D2
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, V3.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, D3
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, D4
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, D5
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, V6.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X23, X13, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, D6
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8000, LSL #16
    SUB  X23, X13, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, D7
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D8
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D9
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8000, LSL #16
    SUB  X8, X13, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X17, D10
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D11
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X8, X28, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, D12
    MOVZ  X28, #0x0, LSL #0
    SUB  X8, X28, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, V13.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X14, X27, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, D13
    MOVZ  X27, #0x0, LSL #0
    SUB  X14, X27, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, D14
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, D15
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x8000, LSL #16
    SUB  X26, X10, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, D16
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D17
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X24, X28, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, D18
    MOVZ  X28, #0x0, LSL #0
    SUB  X24, X28, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X13, X12, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D19
    MOVZ  X12, #0x0, LSL #0
    SUB  X13, X12, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X4
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, D20
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x8000, LSL #16
    MOVK  X2, #0x8000, LSL #48
    SUB  X28, X2, X4
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, D21
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, D22
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, D23
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X28, X13, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, D24
    MOVZ  X13, #0x0, LSL #0
    SUB  X28, X13, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, D26
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, D27
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, D28
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, V29.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, D29
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
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
    FMOV  V0.D[1], X2
    FMOV  D1, X11
    FMOV  V1.D[1], X22
    FMOV  D2, X26
    FMOV  V2.D[1], X7
    FMOV  D3, X19
    FMOV  V3.D[1], X4
    FMOV  D4, X23
    FMOV  V4.D[1], X14
    FMOV  D5, X17
    FMOV  V5.D[1], X20
    FMOV  D6, X22
    FMOV  V6.D[1], X28
    FMOV  D7, X24
    FMOV  V7.D[1], X3
    FMOV  D8, X5
    FMOV  V8.D[1], X28
    FMOV  D9, X8
    FMOV  V9.D[1], X18
    FMOV  D10, X20
    FMOV  V10.D[1], X11
    FMOV  D11, X19
    FMOV  V11.D[1], X19
    FMOV  D12, X11
    FMOV  V12.D[1], X17
    FMOV  D13, X11
    FMOV  V13.D[1], X3
    FMOV  D14, X22
    FMOV  V14.D[1], X14
    FMOV  D15, X12
    FMOV  V15.D[1], X22
    FMOV  D16, X26
    FMOV  V16.D[1], X26
    FMOV  D17, X22
    FMOV  V17.D[1], X17
    FMOV  D18, X7
    FMOV  V18.D[1], X11
    FMOV  D19, X17
    FMOV  V19.D[1], X19
    FMOV  D20, X11
    FMOV  V20.D[1], X10
    FMOV  D21, X15
    FMOV  V21.D[1], X17
    FMOV  D22, X13
    FMOV  V22.D[1], X12
    FMOV  D23, X11
    FMOV  V23.D[1], X11
    FMOV  D24, X20
    FMOV  V24.D[1], X24
    FMOV  D25, X6
    FMOV  V25.D[1], X22
    FMOV  D26, X15
    FMOV  V26.D[1], X13
    FMOV  D27, X15
    FMOV  V27.D[1], X22
    FMOV  D28, X23
    FMOV  V28.D[1], X22
    FMOV  D29, X16
    FMOV  V29.D[1], X18
    FMOV  D30, X18
    FMOV  V30.D[1], X21
    FMOV  D31, X6
    FMOV  V31.D[1], X18
    MOVZ  X20, #0xf, LSL #0
TaishanSimdWideNarryArthemticP01_label_415:
    SQRDMULH H28, H24, V4.H[0x3]
    FMLS V28.4S, V20.4S, V11.S[0x1]
    UMULL V22.4S, V0.4H, V14.H[0x5]
    MLA  V15.4S, V18.4S, V20.S[0x1]
    SQRDMULH  V22.2S, V13.2S, V4.S[0x1]
    FMLS S14, S8, V5.S[0x0]
    SQRDMULH  V28.4S, V25.4S, V24.4S
    FMLA S24, S31, V27.S[0x2]
    FMLA V25.2D, V9.2D, V14.D[0x1]
    SQRDMULH  V6.2S, V29.2S, V30.S[0x3]
    SQRDMULH  V7.4H, V21.4H, V6.H[0x7]
    FMUL S26, S9, V23.S[0x3]
    FMUL D16, D27, V8.D[0x0]
    FMULX D0, D14, V3.D[0x1]
    MLA  V8.2S, V15.2S, V13.S[0x1]
    SQRDMULH  V6.4H, V4.4H, V10.H[0x1]
    SQRDMULH  S20, S28, S27
    FMULX V8.2D, V0.2D, V18.D[0x0]
    UMULL V13.4S, V10.4H, V13.H[0x3]
    FMULX V31.2D, V27.2D, V29.D[0x0]
    MLS  V7.8H, V21.8H, V11.H[0x3]
    FMUL D16, D14, V3.D[0x1]
    FMULX V22.2D, V24.2D, V25.D[0x0]
    FMUL S14, S2, V22.S[0x3]
    MLA  V3.4S, V31.4S, V28.S[0x1]
    FMLA D30, D26, V4.D[0x0]
    FMLA S28, S20, V11.S[0x0]
    FMUL D15, D14, V9.D[0x1]
    FMULX S24, S7, V13.S[0x0]
    UMULL V30.2D, V16.2S, V9.S[0x3]
    FMUL V1.2D, V0.2D, V10.D[0x1]
    FMUL S26, S22, V8.S[0x2]
    FMLS D13, D9, V10.D[0x1]
    SQRDMULH S10, S10, V3.S[0x1]
    FMLS V31.2D, V2.2D, V21.D[0x0]
    FMLA S15, S20, V23.S[0x2]
    FMLA S20, S12, V24.S[0x0]
    SQRDMULH  V13.2S, V31.2S, V11.2S
    FMLS V6.2D, V4.2D, V2.D[0x1]
    MUL  V24.4S, V13.4S, V6.S[0x1]
    FMUL S12, S14, V26.S[0x3]
    SQRDMULH  V25.4S, V31.4S, V26.4S
    SQRDMULH  S18, S11, S9
    SQRDMULH  S22, S30, S16
    FMLS V17.2S, V3.2S, V4.S[0x2]
    UMULL V3.4S, V27.4H, V15.H[0x6]
    SQRDMULH  V13.4S, V28.4S, V19.S[0x0]
    FMLS D1, D7, V13.D[0x0]
    FMLA V17.4S, V5.4S, V24.S[0x2]
    MUL  V0.2S, V1.2S, V13.S[0x0]
    FMUL S18, S23, V30.S[0x2]
    MLA  V8.4S, V10.4S, V5.S[0x3]
    MLA  V18.4H, V16.4H, V13.H[0x7]
    MLA  V0.2S, V20.2S, V8.S[0x3]
    SQRDMULH  V0.4S, V9.4S, V18.S[0x2]
    FMUL V11.2S, V9.2S, V21.S[0x3]
    UMULL2 V26.4S, V22.8H, V15.H[0x3]
    UMULL V16.4S, V5.4H, V6.H[0x7]
    MLA  V22.8H, V2.8H, V11.H[0x2]
    FMLS V17.2D, V18.2D, V26.D[0x0]
    SQRDMULH  H15, H5, H9
    UMULL V15.2D, V1.2S, V18.S[0x0]
    FMUL D18, D12, V9.D[0x1]
    SQRDMULH  V8.4H, V24.4H, V13.H[0x2]
    MUL  V7.2S, V25.2S, V9.S[0x3]
    FMULX V12.4S, V1.4S, V22.S[0x3]
    MLS  V23.8H, V23.8H, V0.H[0x5]
    FMULX S15, S23, V19.S[0x1]
    FMLA S24, S4, V31.S[0x3]
    SQRDMULH S7, S17, V15.S[0x3]
    SQRDMULH S16, S3, V21.S[0x1]
    UMULL V12.4S, V3.4H, V7.H[0x1]
    FMLS V27.2D, V13.2D, V14.D[0x1]
    FMLS S0, S14, V17.S[0x2]
    FMUL V17.4S, V24.4S, V0.S[0x3]
    UMULL2 V16.4S, V20.8H, V5.H[0x2]
    UMULL V23.2D, V13.2S, V30.S[0x3]
    MLA  V10.4S, V20.4S, V22.S[0x0]
    FMULX V16.2D, V12.2D, V8.D[0x0]
    FMLS D1, D3, V30.D[0x1]
    FMLS V30.4S, V7.4S, V10.S[0x1]
    SQRDMULH  V8.2S, V18.2S, V19.2S
    FMULX V29.2D, V27.2D, V13.D[0x0]
    SQRDMULH  H10, H1, H1
    FMLS V11.2D, V6.2D, V27.D[0x0]
    FMLA V16.4S, V9.4S, V30.S[0x1]
    MLS  V9.4S, V10.4S, V30.S[0x0]
    MUL  V30.2S, V7.2S, V3.S[0x3]
    FMULX S0, S0, V26.S[0x3]
    UMULL V25.4S, V26.4H, V0.H[0x2]
    MLA  V12.8H, V12.8H, V3.H[0x6]
    FMULX V30.2D, V9.2D, V22.D[0x0]
    MLA  V4.8H, V29.8H, V1.H[0x5]
    UMULL2 V14.2D, V6.4S, V5.S[0x1]
    SQRDMULH H18, H5, V4.H[0x7]
    FMUL S20, S1, V17.S[0x3]
    FMUL S28, S10, V3.S[0x3]
    UMULL V10.4S, V30.4H, V10.H[0x7]
    SQRDMULH  V17.8H, V4.8H, V7.H[0x1]
    FMUL S20, S13, V6.S[0x1]
    SQRDMULH S24, S13, V23.S[0x2]
    FMLA D30, D1, V19.D[0x1]
    FMLS S25, S9, V28.S[0x0]
    FMUL D13, D14, V5.D[0x0]
    SQRDMULH  V9.2S, V6.2S, V20.S[0x1]
    MUL  V22.4S, V15.4S, V6.S[0x2]
    FMUL V5.2D, V26.2D, V8.D[0x0]
    UMULL2 V1.4S, V13.8H, V14.H[0x0]
    SQRDMULH  V21.8H, V14.8H, V12.H[0x2]
    SQRDMULH  H26, H10, H29
    FMULX S12, S20, V3.S[0x2]
    FMLA V31.2S, V9.2S, V31.S[0x1]
    SQRDMULH  V15.2S, V1.2S, V17.S[0x0]
    FMULX V28.2S, V16.2S, V9.S[0x1]
    SQRDMULH  S25, S8, S5
    SQRDMULH S29, S15, V18.S[0x3]
    SQRDMULH H0, H26, V12.H[0x5]
    FMLS V21.2S, V11.2S, V24.S[0x1]
    MUL  V1.4S, V7.4S, V7.S[0x1]
    FMLA S15, S25, V30.S[0x2]
    FMLS S0, S22, V23.S[0x3]
    FMUL V29.2D, V7.2D, V19.D[0x1]
    FMLA V17.4S, V30.4S, V10.S[0x2]
    FMUL V23.2D, V20.2D, V19.D[0x0]
    SQRDMULH  S31, S23, S27
    FMLA V3.4S, V16.4S, V28.S[0x1]
    SQRDMULH  V17.4S, V24.4S, V11.S[0x2]
    FMULX V6.2D, V0.2D, V2.D[0x1]
    FMLS D10, D4, V6.D[0x0]
    MLS  V15.4S, V9.4S, V15.S[0x3]
    UMULL V31.4S, V24.4H, V1.H[0x2]
    FMUL S9, S29, V23.S[0x2]
    MLS  V14.8H, V4.8H, V1.H[0x3]
    SQRDMULH H23, H9, V12.H[0x5]
    MLS  V15.8H, V2.8H, V0.H[0x0]
    UMULL2 V25.2D, V15.4S, V15.S[0x3]
    FMLS V25.2D, V29.2D, V27.D[0x0]
    FMLA S10, S15, V14.S[0x1]
    MLS  V0.4S, V10.4S, V10.S[0x1]
    MUL  V10.4S, V10.4S, V22.S[0x2]
    FMLA V21.2D, V15.2D, V31.D[0x1]
    FMULX S8, S5, V10.S[0x0]
    SQRDMULH S3, S28, V21.S[0x0]
    SQRDMULH  V6.4S, V14.4S, V7.S[0x0]
    FMLS D16, D20, V16.D[0x0]
    SQRDMULH H16, H16, V9.H[0x1]
    FMUL S13, S11, V21.S[0x2]
    FMUL D21, D23, V2.D[0x0]
    FMULX D8, D3, V30.D[0x1]
    FMLS D20, D6, V4.D[0x0]
    FMUL S16, S18, V16.S[0x1]
    FMULX D31, D29, V15.D[0x0]
    FMLA V17.2D, V24.2D, V17.D[0x0]
    SQRDMULH  H24, H4, H20
    SQRDMULH  V14.8H, V12.8H, V5.H[0x7]
    MLS  V21.8H, V22.8H, V14.H[0x3]
    SQRDMULH  S13, S5, S19
    MLA  V22.8H, V13.8H, V0.H[0x3]
    FMUL V4.4S, V1.4S, V14.S[0x3]
    MLS  V10.8H, V14.8H, V13.H[0x7]
    FMUL D18, D17, V3.D[0x1]
    FMUL D14, D15, V2.D[0x1]
    FMLA S25, S18, V6.S[0x3]
    MLA  V20.4H, V20.4H, V4.H[0x1]
    UMULL V24.2D, V12.2S, V1.S[0x0]
    FMUL V21.2D, V9.2D, V29.D[0x0]
    FMLA D6, D31, V26.D[0x0]
    FMULX D25, D16, V24.D[0x1]
    UMULL2 V20.4S, V9.8H, V6.H[0x7]
    FMLA S17, S12, V1.S[0x2]
    MLS  V21.2S, V17.2S, V13.S[0x0]
    FMLS V24.4S, V26.4S, V31.S[0x1]
    UMULL2 V10.2D, V14.4S, V26.S[0x2]
    MLA  V8.4S, V14.4S, V25.S[0x1]
    MUL  V6.2S, V1.2S, V23.S[0x3]
    FMULX S20, S30, V20.S[0x0]
    MLS  V13.4S, V26.4S, V24.S[0x3]
    MLA  V23.4S, V3.4S, V12.S[0x0]
    FMLA V4.4S, V21.4S, V13.S[0x0]
    UMULL V6.4S, V26.4H, V10.H[0x1]
    FMUL S8, S22, V9.S[0x2]
    SQRDMULH  V19.4H, V13.4H, V0.H[0x3]
    FMLS V8.2D, V12.2D, V4.D[0x1]
    FMULX V23.4S, V23.4S, V17.S[0x2]
    MLA  V20.8H, V11.8H, V10.H[0x1]
    UMULL2 V19.4S, V3.8H, V10.H[0x1]
    FMLS V7.2D, V14.2D, V1.D[0x0]
    FMLA D19, D29, V8.D[0x1]
    MLA  V7.4H, V29.4H, V4.H[0x3]
    FMLS V7.2S, V20.2S, V23.S[0x0]
    FMLA V9.2D, V29.2D, V28.D[0x1]
    UMULL2 V30.2D, V2.4S, V29.S[0x3]
    MUL  V9.4H, V31.4H, V8.H[0x1]
    FMULX V11.2D, V31.2D, V17.D[0x0]
    FMUL S19, S31, V5.S[0x0]
    FMULX S17, S9, V30.S[0x1]
    SQRDMULH  V13.4H, V18.4H, V15.H[0x5]
    UMULL V6.4S, V29.4H, V3.H[0x2]
    FMULX V15.2D, V12.2D, V23.D[0x0]
    UMULL V18.2D, V13.2S, V28.S[0x1]
    SUBS  X20, X20, #0x1
    B.NE  TaishanSimdWideNarryArthemticP01_label_415
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X17, X18, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X3, X20, X3
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X7, X6, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X23, X17, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X26, X15, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X13, X22, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X15, X20, X8
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X14, X22, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X18, X7, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X3, X27, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X20, X23, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X8, X9, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X29, X20, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X20, X11, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X18, X24, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X6, X29, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X24, X22, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X28, X18, X28
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X29, X18, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X6, D2
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X29, X18, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, D3
    MOVZ  X13, #0x1, LSL #0
    MOVK  X13, #0x8000, LSL #16
    SUB  X22, X13, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X13, X18, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, D4
    MOVZ  X18, #0x0, LSL #0
    SUB  X13, X18, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, D5
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X10, X18, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, D6
    MOVZ  X18, #0x0, LSL #0
    SUB  X10, X18, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, V7.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, D7
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0x7fff, LSL #48
    SUB  X15, X10, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x8000, LSL #48
    SUB  X9, X19, X13
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, D8
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x8000, LSL #16
    SUB  X9, X19, X13
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, V9.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X15
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, D9
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X15
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X17, X6, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, D10
    MOVZ  X6, #0x0, LSL #0
    SUB  X17, X6, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, V11.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X5, X19, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, D11
    MOVZ  X19, #0x0, LSL #0
    SUB  X5, X19, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, D12
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X18, X11, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, D13
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, D14
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X6, X11, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, D15
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X23, X13, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, D16
    MOVZ  X13, #0x0, LSL #0
    SUB  X23, X13, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X14, X19, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, D17
    MOVZ  X19, #0x0, LSL #0
    SUB  X14, X19, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X10
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, D18
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X10
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, D19
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, D20
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X15
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, D21
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X15
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, D22
    MOVZ  X24, #0x1, LSL #0
    MOVK  X24, #0x8000, LSL #16
    SUB  X28, X24, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D23
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0x7fff, LSL #16
    SUB  X15, X24, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x8000, LSL #16
    MOVK  X6, #0x8000, LSL #48
    SUB  X29, X6, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, D24
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x8000, LSL #16
    MOVK  X6, #0x8000, LSL #48
    SUB  X29, X6, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, D26
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X14, X26, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, D27
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X14, X26, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, D28
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x8000, LSL #16
    MOVK  X3, #0x8000, LSL #48
    SUB  X6, X3, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X21, X17, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, D29
    MOVZ  X17, #0x0, LSL #0
    SUB  X21, X17, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X2, #0xf003, LSL #0
    MOVK  X2, #0x4097, LSL #16
    MOVK  X2, #0x9a40, LSL #32
    MOVK  X2, #0xba63, LSL #48
    MOVZ  X3, #0x51fb, LSL #0
    MOVK  X3, #0x8e0, LSL #16
    MOVK  X3, #0x86a6, LSL #32
    MOVK  X3, #0x96e6, LSL #48
    MOVZ  X4, #0x2801, LSL #0
    MOVK  X4, #0x606e, LSL #16
    MOVK  X4, #0xfbd0, LSL #32
    MOVK  X4, #0x8a0e, LSL #48
    MOVZ  X5, #0x7786, LSL #0
    MOVK  X5, #0xc1e9, LSL #16
    MOVK  X5, #0x8e0, LSL #32
    MOVK  X5, #0x9f8, LSL #48
    MOVZ  X6, #0xbaee, LSL #0
    MOVK  X6, #0x1655, LSL #16
    MOVK  X6, #0xa614, LSL #32
    MOVK  X6, #0xf4b1, LSL #48
    MOVZ  X7, #0x445, LSL #0
    MOVK  X7, #0xbedd, LSL #16
    MOVK  X7, #0x2a02, LSL #32
    MOVK  X7, #0xd7e2, LSL #48
    MOVZ  X8, #0x2225, LSL #0
    MOVK  X8, #0xab43, LSL #16
    MOVK  X8, #0x9872, LSL #32
    MOVK  X8, #0x6477, LSL #48
    MOVZ  X9, #0x5398, LSL #0
    MOVK  X9, #0xe9ad, LSL #16
    MOVK  X9, #0xad8e, LSL #32
    MOVK  X9, #0xefd0, LSL #48
    MOVZ  X10, #0x5372, LSL #0
    MOVK  X10, #0xbbad, LSL #16
    MOVK  X10, #0xa8eb, LSL #32
    MOVK  X10, #0x599f, LSL #48
    MOVZ  X11, #0x3401, LSL #0
    MOVK  X11, #0x7eda, LSL #16
    MOVK  X11, #0x647, LSL #32
    MOVK  X11, #0x4d73, LSL #48
    MOVZ  X12, #0xa2bd, LSL #0
    MOVK  X12, #0xfb93, LSL #16
    MOVK  X12, #0x360, LSL #32
    MOVK  X12, #0xd1cb, LSL #48
    MOVZ  X13, #0xdec3, LSL #0
    MOVK  X13, #0x8b1f, LSL #16
    MOVK  X13, #0xe51e, LSL #32
    MOVK  X13, #0x5586, LSL #48
    MOVZ  X14, #0xee9b, LSL #0
    MOVK  X14, #0x773b, LSL #16
    MOVK  X14, #0x39d3, LSL #32
    MOVK  X14, #0x83b3, LSL #48
    MOVZ  X15, #0x7636, LSL #0
    MOVK  X15, #0xa251, LSL #16
    MOVK  X15, #0x55f0, LSL #32
    MOVK  X15, #0x2992, LSL #48
    MOVZ  X16, #0xbcca, LSL #0
    MOVK  X16, #0xaf6c, LSL #16
    MOVK  X16, #0xb72, LSL #32
    MOVK  X16, #0xa3da, LSL #48
    MOVZ  X17, #0x1fe8, LSL #0
    MOVK  X17, #0xc7aa, LSL #16
    MOVK  X17, #0x2a9c, LSL #32
    MOVK  X17, #0xe6cb, LSL #48
    MOVZ  X18, #0x39cd, LSL #0
    MOVK  X18, #0xefe8, LSL #16
    MOVK  X18, #0x8218, LSL #32
    MOVK  X18, #0xc6c2, LSL #48
    MOVZ  X19, #0x8a7b, LSL #0
    MOVK  X19, #0xf232, LSL #16
    MOVK  X19, #0x48db, LSL #32
    MOVK  X19, #0xf0f5, LSL #48
    MOVZ  X20, #0xbb39, LSL #0
    MOVK  X20, #0x4d05, LSL #16
    MOVK  X20, #0xc008, LSL #32
    MOVK  X20, #0xc7f4, LSL #48
    MOVZ  X21, #0x97d8, LSL #0
    MOVK  X21, #0xa9ae, LSL #16
    MOVK  X21, #0x6eec, LSL #32
    MOVK  X21, #0x339b, LSL #48
    MOVZ  X22, #0xd235, LSL #0
    MOVK  X22, #0x9c32, LSL #16
    MOVK  X22, #0xdd3b, LSL #32
    MOVK  X22, #0xa580, LSL #48
    MOVZ  X23, #0x9cf3, LSL #0
    MOVK  X23, #0x394b, LSL #16
    MOVK  X23, #0x92f6, LSL #32
    MOVK  X23, #0xa5bd, LSL #48
    MOVZ  X24, #0xe4aa, LSL #0
    MOVK  X24, #0x2ba4, LSL #16
    MOVK  X24, #0x3ad9, LSL #32
    MOVK  X24, #0xb0a1, LSL #48
    MOVZ  X26, #0xa690, LSL #0
    MOVK  X26, #0x884, LSL #16
    MOVK  X26, #0xe312, LSL #32
    MOVK  X26, #0x120d, LSL #48
    MOVZ  X27, #0xa4a5, LSL #0
    MOVK  X27, #0x2e72, LSL #16
    MOVK  X27, #0x3178, LSL #32
    MOVK  X27, #0xfbee, LSL #48
    MOVZ  X28, #0x508f, LSL #0
    MOVK  X28, #0x3e66, LSL #16
    MOVK  X28, #0xc642, LSL #32
    MOVK  X28, #0x4f75, LSL #48
    MOVZ  X29, #0x6925, LSL #0
    MOVK  X29, #0xfe9b, LSL #16
    MOVK  X29, #0x9ec4, LSL #32
    MOVK  X29, #0x49d1, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X8
    FMOV  D1, X17
    FMOV  V1.D[1], X20
    FMOV  D2, X6
    FMOV  V2.D[1], X29
    FMOV  D3, X27
    FMOV  V3.D[1], X27
    FMOV  D4, X7
    FMOV  V4.D[1], X14
    FMOV  D5, X18
    FMOV  V5.D[1], X11
    FMOV  D6, X5
    FMOV  V6.D[1], X3
    FMOV  D7, X13
    FMOV  V7.D[1], X2
    FMOV  D8, X29
    FMOV  V8.D[1], X26
    FMOV  D9, X9
    FMOV  V9.D[1], X18
    FMOV  D10, X29
    FMOV  V10.D[1], X4
    FMOV  D11, X26
    FMOV  V11.D[1], X3
    FMOV  D12, X9
    FMOV  V12.D[1], X15
    FMOV  D13, X22
    FMOV  V13.D[1], X9
    FMOV  D14, X6
    FMOV  V14.D[1], X5
    FMOV  D15, X8
    FMOV  V15.D[1], X24
    FMOV  D16, X23
    FMOV  V16.D[1], X26
    FMOV  D17, X12
    FMOV  V17.D[1], X29
    FMOV  D18, X8
    FMOV  V18.D[1], X14
    FMOV  D19, X4
    FMOV  V19.D[1], X20
    FMOV  D20, X12
    FMOV  V20.D[1], X29
    FMOV  D21, X20
    FMOV  V21.D[1], X2
    FMOV  D22, X8
    FMOV  V22.D[1], X8
    FMOV  D23, X10
    FMOV  V23.D[1], X10
    FMOV  D24, X22
    FMOV  V24.D[1], X23
    FMOV  D25, X21
    FMOV  V25.D[1], X28
    FMOV  D26, X3
    FMOV  V26.D[1], X28
    FMOV  D27, X3
    FMOV  V27.D[1], X26
    FMOV  D28, X10
    FMOV  V28.D[1], X15
    FMOV  D29, X10
    FMOV  V29.D[1], X19
    FMOV  D30, X13
    FMOV  V30.D[1], X10
    FMOV  D31, X24
    FMOV  V31.D[1], X29
    MOVZ  X17, #0xa, LSL #0
TaishanSimdWideNarryArthemticP01_label_498:
    FMLS S22, S7, V27.S[0x3]
    FMLA V23.4S, V28.4S, V19.S[0x0]
    FMULX V5.2S, V0.2S, V15.S[0x2]
    MLA  V12.4H, V28.4H, V5.H[0x4]
    SQRDMULH H26, H19, V11.H[0x3]
    SQRDMULH H25, H23, V10.H[0x4]
    SQRDMULH H23, H8, V6.H[0x2]
    SQRDMULH  H21, H23, H31
    UMULL2 V21.2D, V1.4S, V31.S[0x2]
    MLS  V8.4H, V11.4H, V8.H[0x2]
    SQRDMULH S8, S14, V25.S[0x1]
    FMLA D29, D29, V6.D[0x1]
    MLA  V26.8H, V8.8H, V15.H[0x7]
    SQRDMULH  H23, H24, H8
    SQRDMULH H30, H21, V5.H[0x4]
    SQRDMULH S29, S22, V5.S[0x1]
    FMUL V25.2D, V26.2D, V1.D[0x0]
    UMULL2 V12.2D, V30.4S, V20.S[0x2]
    MLS  V18.4S, V13.4S, V26.S[0x0]
    FMLA S22, S10, V27.S[0x3]
    FMLS V17.2D, V25.2D, V10.D[0x1]
    MLS  V24.2S, V12.2S, V17.S[0x1]
    SQRDMULH  V21.4H, V27.4H, V23.4H
    MLA  V28.8H, V18.8H, V12.H[0x6]
    FMLS S17, S9, V8.S[0x0]
    FMLA V6.2D, V26.2D, V9.D[0x1]
    FMLA V14.2S, V3.2S, V15.S[0x3]
    SQRDMULH  V26.2S, V14.2S, V1.S[0x2]
    SQRDMULH  V14.8H, V30.8H, V29.8H
    FMLS D23, D15, V21.D[0x1]
    SQRDMULH H28, H27, V8.H[0x0]
    FMULX D5, D30, V15.D[0x0]
    SQRDMULH  H3, H2, H30
    MLA  V2.2S, V22.2S, V23.S[0x0]
    MLA  V24.2S, V12.2S, V17.S[0x0]
    FMUL V6.2S, V0.2S, V15.S[0x2]
    SQRDMULH  H5, H19, H15
    MLA  V24.8H, V31.8H, V1.H[0x7]
    FMLA D2, D26, V14.D[0x0]
    FMLA V4.2S, V11.2S, V28.S[0x3]
    FMULX D27, D23, V4.D[0x0]
    FMLA D22, D27, V22.D[0x1]
    FMLS V30.2D, V8.2D, V23.D[0x0]
    MLA  V11.4S, V30.4S, V26.S[0x1]
    FMLA D27, D27, V3.D[0x0]
    FMLS D16, D25, V0.D[0x1]
    FMULX S31, S19, V17.S[0x0]
    FMUL V24.2D, V11.2D, V7.D[0x0]
    MLA  V14.4H, V14.4H, V8.H[0x1]
    FMUL S14, S26, V6.S[0x0]
    FMUL D11, D31, V31.D[0x0]
    FMLA S15, S14, V2.S[0x3]
    SQRDMULH  V14.2S, V25.2S, V17.S[0x0]
    UMULL2 V21.2D, V1.4S, V1.S[0x2]
    UMULL V26.4S, V9.4H, V4.H[0x1]
    MLA  V18.2S, V1.2S, V28.S[0x1]
    FMLA D18, D11, V17.D[0x1]
    FMLS S4, S15, V5.S[0x0]
    MLS  V11.4H, V18.4H, V4.H[0x2]
    MLA  V17.2S, V4.2S, V11.S[0x3]
    UMULL2 V18.2D, V14.4S, V19.S[0x1]
    MLA  V27.2S, V24.2S, V15.S[0x3]
    MLS  V29.4S, V3.4S, V10.S[0x3]
    FMLA V5.2S, V26.2S, V3.S[0x1]
    FMLA S29, S12, V17.S[0x1]
    FMUL V16.2S, V4.2S, V13.S[0x1]
    FMULX S17, S25, V1.S[0x3]
    FMUL V0.2S, V10.2S, V19.S[0x0]
    UMULL V28.4S, V24.4H, V14.H[0x2]
    FMLA V9.2D, V15.2D, V21.D[0x0]
    SQRDMULH S2, S2, V30.S[0x2]
    UMULL V8.4S, V10.4H, V15.H[0x1]
    FMUL V16.2S, V11.2S, V19.S[0x3]
    SQRDMULH S14, S12, V11.S[0x0]
    FMLS S18, S4, V15.S[0x3]
    MLA  V17.2S, V20.2S, V4.S[0x1]
    UMULL2 V31.4S, V19.8H, V14.H[0x0]
    UMULL2 V12.4S, V5.8H, V2.H[0x4]
    SQRDMULH  S18, S31, S12
    MLS  V24.4S, V1.4S, V18.S[0x1]
    MUL  V17.8H, V0.8H, V14.H[0x4]
    MLA  V21.8H, V27.8H, V1.H[0x2]
    FMLS S24, S31, V3.S[0x3]
    SQRDMULH  V1.2S, V17.2S, V12.2S
    FMLS V3.4S, V16.4S, V24.S[0x1]
    SQRDMULH  H19, H16, H24
    UMULL V7.4S, V10.4H, V13.H[0x1]
    SQRDMULH  V30.8H, V24.8H, V0.H[0x4]
    FMLA D11, D22, V29.D[0x1]
    MLA  V8.4S, V19.4S, V9.S[0x0]
    FMULX V4.4S, V14.4S, V17.S[0x1]
    UMULL2 V4.2D, V26.4S, V29.S[0x2]
    MLA  V14.2S, V27.2S, V13.S[0x0]
    SQRDMULH  H18, H10, H29
    MLS  V21.4S, V19.4S, V22.S[0x0]
    UMULL2 V3.4S, V9.8H, V12.H[0x3]
    UMULL2 V28.2D, V1.4S, V2.S[0x0]
    FMLA V30.2D, V8.2D, V12.D[0x0]
    SQRDMULH S6, S5, V11.S[0x1]
    UMULL2 V7.4S, V0.8H, V14.H[0x1]
    FMUL V13.4S, V15.4S, V4.S[0x1]
    FMLS V28.2D, V18.2D, V12.D[0x0]
    MUL  V22.8H, V27.8H, V6.H[0x0]
    SQRDMULH  S12, S28, S13
    FMLS D23, D22, V12.D[0x0]
    MUL  V31.4H, V13.4H, V1.H[0x5]
    FMLS D27, D16, V21.D[0x1]
    FMUL V22.2D, V2.2D, V27.D[0x0]
    FMLS D12, D28, V19.D[0x1]
    MLA  V6.2S, V11.2S, V3.S[0x0]
    FMULX D17, D13, V10.D[0x0]
    SQRDMULH S5, S26, V22.S[0x0]
    FMULX D10, D10, V31.D[0x0]
    SQRDMULH  V10.4H, V10.4H, V11.H[0x3]
    SQRDMULH S29, S29, V22.S[0x2]
    MLS  V4.2S, V5.2S, V22.S[0x0]
    FMLA V15.4S, V30.4S, V26.S[0x0]
    SQRDMULH S14, S29, V9.S[0x3]
    UMULL V12.2D, V26.2S, V12.S[0x2]
    FMUL S21, S10, V15.S[0x1]
    SQRDMULH H21, H12, V9.H[0x0]
    FMUL V9.2D, V25.2D, V7.D[0x1]
    UMULL V18.4S, V25.4H, V6.H[0x5]
    MUL  V22.8H, V2.8H, V7.H[0x6]
    FMLA S9, S29, V10.S[0x2]
    FMLS V9.4S, V4.4S, V5.S[0x2]
    FMUL D15, D2, V4.D[0x1]
    FMULX V23.2D, V28.2D, V10.D[0x0]
    SQRDMULH  V15.4H, V26.4H, V3.H[0x1]
    SQRDMULH  V1.4H, V30.4H, V15.H[0x4]
    FMLA V16.2D, V12.2D, V15.D[0x0]
    SQRDMULH  V12.4S, V14.4S, V17.4S
    SQRDMULH  V31.2S, V3.2S, V23.S[0x0]
    MUL  V7.8H, V7.8H, V10.H[0x6]
    SQRDMULH  V22.8H, V10.8H, V12.8H
TaishanSimdWideNarryArthemticP01_label_410:
    MLS  V29.4S, V1.4S, V19.S[0x0]
    FMULX S18, S16, V15.S[0x1]
    FMLS V5.2D, V13.2D, V19.D[0x0]
    FMLA S7, S30, V7.S[0x0]
    SQRDMULH  V20.8H, V19.8H, V6.H[0x4]
    FMLA S11, S15, V10.S[0x1]
    FMLA V14.2D, V5.2D, V31.D[0x1]
    MUL  V25.2S, V6.2S, V19.S[0x1]
    FMLS V2.2D, V9.2D, V17.D[0x0]
    FMULX S25, S25, V23.S[0x1]
    MUL  V22.8H, V20.8H, V11.H[0x4]
    MUL  V27.4H, V10.4H, V15.H[0x0]
    FMULX V27.2S, V6.2S, V7.S[0x0]
    MLS  V23.4H, V11.4H, V3.H[0x6]
    SQRDMULH H29, H12, V14.H[0x6]
    FMULX S15, S18, V23.S[0x3]
    UMULL V0.2D, V15.2S, V19.S[0x2]
    FMULX V19.2D, V22.2D, V25.D[0x1]
    SQRDMULH  V25.4S, V17.4S, V13.S[0x2]
    FMLS V4.4S, V11.4S, V5.S[0x3]
    FMLS D6, D15, V10.D[0x1]
    SQRDMULH  S24, S4, S2
    SQRDMULH H24, H28, V7.H[0x4]
    FMULX D15, D20, V3.D[0x0]
    MLA  V24.2S, V19.2S, V25.S[0x1]
    FMUL D3, D2, V19.D[0x1]
    FMLS V3.2D, V24.2D, V8.D[0x0]
    FMULX D3, D4, V28.D[0x1]
    SQRDMULH  V5.4H, V4.4H, V6.4H
    FMLA S6, S0, V8.S[0x2]
    SQRDMULH S19, S11, V21.S[0x1]
    MUL  V6.4H, V11.4H, V1.H[0x1]
    MUL  V8.4H, V2.4H, V0.H[0x1]
    FMLA V16.4S, V29.4S, V10.S[0x1]
    UMULL V22.2D, V6.2S, V8.S[0x2]
    MLA  V2.4S, V13.4S, V12.S[0x3]
    MLS  V8.2S, V8.2S, V25.S[0x3]
    UMULL2 V26.4S, V0.8H, V7.H[0x1]
    FMULX S23, S8, V16.S[0x0]
    FMULX S19, S7, V1.S[0x0]
    FMLS V3.2S, V3.2S, V27.S[0x2]
    MLS  V22.4H, V20.4H, V10.H[0x5]
    MLA  V2.2S, V13.2S, V5.S[0x3]
    MLA  V22.8H, V19.8H, V1.H[0x3]
    SQRDMULH H10, H2, V5.H[0x7]
    FMULX D0, D24, V12.D[0x1]
    FMLA D20, D30, V1.D[0x0]
    FMLS V26.2D, V20.2D, V13.D[0x0]
    FMULX S21, S23, V10.S[0x0]
    MLS  V0.8H, V13.8H, V11.H[0x0]
    SQRDMULH S7, S23, V29.S[0x1]
    FMLS V31.2S, V16.2S, V12.S[0x0]
    FMUL V17.4S, V3.4S, V0.S[0x0]
    UMULL V17.2D, V10.2S, V17.S[0x2]
    FMULX V25.2D, V21.2D, V13.D[0x1]
    MLS  V19.4S, V13.4S, V26.S[0x3]
    UMULL2 V23.4S, V11.8H, V1.H[0x7]
    FMUL V8.2D, V19.2D, V29.D[0x0]
    SQRDMULH  V16.4S, V4.4S, V31.4S
    SQRDMULH  V25.4H, V6.4H, V13.H[0x3]
    UMULL2 V22.2D, V9.4S, V12.S[0x2]
    FMLS D3, D29, V8.D[0x1]
    SQRDMULH  V23.4H, V17.4H, V24.4H
    FMLA V1.2D, V25.2D, V17.D[0x1]
    MLS  V27.4H, V7.4H, V10.H[0x7]
    SUBS  X17, X17, #0x1
    B.NE  TaishanSimdWideNarryArthemticP01_label_498
    MOVZ  X18, #0xf003, LSL #0
    MOVK  X18, #0x4097, LSL #16
    MOVK  X18, #0x9a40, LSL #32
    MOVK  X18, #0xba63, LSL #48
    SUB  X17, X18, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X26, #0x51fb, LSL #0
    MOVK  X26, #0x8e0, LSL #16
    MOVK  X26, #0x86a6, LSL #32
    MOVK  X26, #0x96e6, LSL #48
    SUB  X2, X26, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X4, #0x2801, LSL #0
    MOVK  X4, #0x606e, LSL #16
    MOVK  X4, #0xfbd0, LSL #32
    MOVK  X4, #0x8a0e, LSL #48
    SUB  X22, X4, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X29, #0x7786, LSL #0
    MOVK  X29, #0xc1e9, LSL #16
    MOVK  X29, #0x8e0, LSL #32
    MOVK  X29, #0x9f8, LSL #48
    SUB  X18, X29, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X6, #0xbaee, LSL #0
    MOVK  X6, #0x1655, LSL #16
    MOVK  X6, #0xa614, LSL #32
    MOVK  X6, #0xf4b1, LSL #48
    SUB  X5, X6, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X29, #0x445, LSL #0
    MOVK  X29, #0xbedd, LSL #16
    MOVK  X29, #0x2a02, LSL #32
    MOVK  X29, #0xd7e2, LSL #48
    SUB  X15, X29, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X13, #0x2225, LSL #0
    MOVK  X13, #0xab43, LSL #16
    MOVK  X13, #0x9872, LSL #32
    MOVK  X13, #0x6477, LSL #48
    SUB  X2, X13, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X20, #0x5398, LSL #0
    MOVK  X20, #0xe9ad, LSL #16
    MOVK  X20, #0xad8e, LSL #32
    MOVK  X20, #0xefd0, LSL #48
    SUB  X18, X20, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X19, #0x5372, LSL #0
    MOVK  X19, #0xbbad, LSL #16
    MOVK  X19, #0xa8eb, LSL #32
    MOVK  X19, #0x599f, LSL #48
    SUB  X13, X19, X10
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X3, #0x3401, LSL #0
    MOVK  X3, #0x7eda, LSL #16
    MOVK  X3, #0x647, LSL #32
    MOVK  X3, #0x4d73, LSL #48
    SUB  X24, X3, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X16, #0xa2bd, LSL #0
    MOVK  X16, #0xfb93, LSL #16
    MOVK  X16, #0x360, LSL #32
    MOVK  X16, #0xd1cb, LSL #48
    SUB  X21, X16, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X27, #0xee9b, LSL #0
    MOVK  X27, #0x773b, LSL #16
    MOVK  X27, #0x39d3, LSL #32
    MOVK  X27, #0x83b3, LSL #48
    SUB  X11, X27, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X15
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X7, #0xa2bd, LSL #0
    MOVK  X7, #0xfb93, LSL #16
    MOVK  X7, #0x360, LSL #32
    MOVK  X7, #0xd1cb, LSL #48
    SUB  X22, X7, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X8, X24, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X29, #0x5398, LSL #0
    MOVK  X29, #0xe9ad, LSL #16
    MOVK  X29, #0xad8e, LSL #32
    MOVK  X29, #0xefd0, LSL #48
    SUB  X23, X29, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X17, #0x51fb, LSL #0
    MOVK  X17, #0x8e0, LSL #16
    MOVK  X17, #0x86a6, LSL #32
    MOVK  X17, #0x96e6, LSL #48
    SUB  X20, X17, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X27, #0x508f, LSL #0
    MOVK  X27, #0x3e66, LSL #16
    MOVK  X27, #0xc642, LSL #32
    MOVK  X27, #0x4f75, LSL #48
    SUB  X5, X27, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X17, #0x5398, LSL #0
    MOVK  X17, #0xe9ad, LSL #16
    MOVK  X17, #0xad8e, LSL #32
    MOVK  X17, #0xefd0, LSL #48
    SUB  X26, X17, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X6, D2
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, D3
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #16
    MOVK  X8, #0x8000, LSL #48
    SUB  X9, X8, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D4
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, D5
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, V6.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, D6
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, D7
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, V8.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, D8
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x8000, LSL #16
    MOVK  X10, #0x8000, LSL #48
    SUB  X22, X10, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, D9
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x8000, LSL #16
    MOVK  X10, #0x8000, LSL #48
    SUB  X22, X10, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, V10.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, D10
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, D11
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X8, X2, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, D12
    MOVZ  X2, #0x0, LSL #0
    SUB  X8, X2, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, D13
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x8000, LSL #48
    SUB  X17, X6, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D14
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x8000, LSL #48
    SUB  X17, X6, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, D15
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D16
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, V17.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, D17
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D18
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, D19
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D20
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, D21
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, D22
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D23
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X6, X23, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, D24
    MOVZ  X23, #0x0, LSL #0
    SUB  X6, X23, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #48
    SUB  X4, X12, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D26
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #48
    SUB  X4, X12, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X20, X21, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, D27
    MOVZ  X21, #0x0, LSL #0
    SUB  X20, X21, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x8000, LSL #48
    SUB  X6, X18, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, D28
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x8000, LSL #48
    SUB  X6, X18, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, V29.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, D29
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
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
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X29
    FMOV  V0.D[1], X4
    FMOV  D1, X22
    FMOV  V1.D[1], X28
    FMOV  D2, X10
    FMOV  V2.D[1], X18
    FMOV  D3, X15
    FMOV  V3.D[1], X24
    FMOV  D4, X19
    FMOV  V4.D[1], X6
    FMOV  D5, X23
    FMOV  V5.D[1], X16
    FMOV  D6, X11
    FMOV  V6.D[1], X7
    FMOV  D7, X29
    FMOV  V7.D[1], X10
    FMOV  D8, X24
    FMOV  V8.D[1], X16
    FMOV  D9, X3
    FMOV  V9.D[1], X24
    FMOV  D10, X3
    FMOV  V10.D[1], X7
    FMOV  D11, X6
    FMOV  V11.D[1], X4
    FMOV  D12, X14
    FMOV  V12.D[1], X3
    FMOV  D13, X13
    FMOV  V13.D[1], X12
    FMOV  D14, X29
    FMOV  V14.D[1], X29
    FMOV  D15, X13
    FMOV  V15.D[1], X13
    FMOV  D16, X26
    FMOV  V16.D[1], X16
    FMOV  D17, X29
    FMOV  V17.D[1], X26
    FMOV  D18, X28
    FMOV  V18.D[1], X14
    FMOV  D19, X27
    FMOV  V19.D[1], X23
    FMOV  D20, X17
    FMOV  V20.D[1], X20
    FMOV  D21, X21
    FMOV  V21.D[1], X16
    FMOV  D22, X28
    FMOV  V22.D[1], X20
    FMOV  D23, X13
    FMOV  V23.D[1], X6
    FMOV  D24, X10
    FMOV  V24.D[1], X23
    FMOV  D25, X14
    FMOV  V25.D[1], X19
    FMOV  D26, X6
    FMOV  V26.D[1], X20
    FMOV  D27, X12
    FMOV  V27.D[1], X11
    FMOV  D28, X11
    FMOV  V28.D[1], X28
    FMOV  D29, X9
    FMOV  V29.D[1], X24
    FMOV  D30, X5
    FMOV  V30.D[1], X24
    FMOV  D31, X2
    FMOV  V31.D[1], X3
    MOVZ  X4, #0xa, LSL #0
TaishanSimdWideNarryArthemticP01_label_580:
    FMLA V14.2S, V6.2S, V16.S[0x0]
    FMLS S25, S18, V20.S[0x2]
    SQRDMULH  H13, H8, H10
    MUL  V24.4S, V28.4S, V8.S[0x0]
    FMLS V8.4S, V31.4S, V1.S[0x0]
    SQRDMULH H2, H19, V13.H[0x0]
    FMUL V13.4S, V30.4S, V30.S[0x2]
    SQRDMULH  V27.4S, V14.4S, V1.S[0x2]
    MLA  V15.2S, V17.2S, V20.S[0x3]
    FMUL V4.2D, V8.2D, V8.D[0x1]
    FMULX V30.2D, V19.2D, V25.D[0x0]
    FMLA S7, S17, V22.S[0x1]
    FMULX D2, D19, V2.D[0x0]
    FMUL D30, D23, V31.D[0x0]
    SQRDMULH  V26.4H, V28.4H, V14.H[0x6]
    FMLS D8, D14, V29.D[0x1]
    MLS  V14.2S, V13.2S, V13.S[0x1]
    FMUL V28.2D, V8.2D, V13.D[0x0]
    SQRDMULH  V4.2S, V21.2S, V13.S[0x1]
    FMLA V20.4S, V29.4S, V4.S[0x1]
    FMULX V18.4S, V29.4S, V14.S[0x3]
    UMULL2 V18.4S, V27.8H, V9.H[0x7]
    SQRDMULH H17, H30, V14.H[0x7]
    FMUL S11, S14, V19.S[0x1]
    FMUL D28, D9, V17.D[0x0]
    SQRDMULH  S20, S10, S2
    SQRDMULH  V23.2S, V11.2S, V20.S[0x1]
    UMULL2 V27.2D, V0.4S, V23.S[0x0]
    SQRDMULH  H22, H0, H30
    SQRDMULH H14, H3, V6.H[0x7]
    MUL  V28.8H, V18.8H, V8.H[0x7]
    FMULX S26, S2, V9.S[0x2]
    SQRDMULH  V19.2S, V22.2S, V10.S[0x1]
    MLA  V31.2S, V16.2S, V17.S[0x0]
    FMUL D7, D8, V9.D[0x1]
    FMLA V4.2S, V7.2S, V8.S[0x3]
    FMLA D29, D18, V31.D[0x1]
    SQRDMULH S29, S30, V9.S[0x3]
    MUL  V31.8H, V9.8H, V1.H[0x2]
    MUL  V9.4S, V31.4S, V25.S[0x2]
    MLA  V0.4S, V15.4S, V19.S[0x1]
    FMLA S0, S20, V13.S[0x0]
    FMUL S4, S19, V3.S[0x2]
    FMLS S31, S13, V14.S[0x3]
    MUL  V27.2S, V28.2S, V18.S[0x2]
    FMLA V15.2S, V9.2S, V31.S[0x1]
    SQRDMULH  H7, H3, H0
    FMLA S15, S18, V26.S[0x1]
    UMULL V20.2D, V26.2S, V23.S[0x2]
    FMLA D27, D30, V9.D[0x0]
    SQRDMULH  S14, S2, S21
    FMULX V29.2D, V30.2D, V13.D[0x0]
    MLS  V2.8H, V5.8H, V1.H[0x1]
    MUL  V4.4S, V22.4S, V22.S[0x0]
    SQRDMULH  V3.4S, V10.4S, V23.S[0x2]
    FMLA S9, S24, V0.S[0x1]
    FMLA D20, D10, V27.D[0x0]
    FMLS V7.4S, V7.4S, V26.S[0x3]
    MLA  V20.4S, V16.4S, V1.S[0x1]
    SQRDMULH H1, H19, V3.H[0x2]
    SQRDMULH S17, S2, V14.S[0x3]
    FMUL S1, S14, V18.S[0x2]
    FMUL V24.4S, V11.4S, V24.S[0x2]
    MUL  V30.4H, V24.4H, V15.H[0x3]
    MLA  V27.4H, V26.4H, V10.H[0x7]
    FMLS V13.2S, V28.2S, V10.S[0x0]
    SQRDMULH  V15.2S, V13.2S, V25.S[0x0]
    SQRDMULH  V22.4S, V16.4S, V25.4S
    FMLA S25, S25, V6.S[0x0]
    FMULX V26.2S, V27.2S, V11.S[0x0]
    FMULX S15, S17, V26.S[0x3]
    SQRDMULH  V15.2S, V28.2S, V31.S[0x1]
    SQRDMULH  H23, H22, H16
    FMLS V29.2D, V26.2D, V14.D[0x1]
    MLS  V22.8H, V0.8H, V15.H[0x4]
    MUL  V30.8H, V17.8H, V2.H[0x4]
    UMULL2 V25.4S, V27.8H, V12.H[0x1]
    FMLA D26, D30, V1.D[0x1]
    FMLS S7, S4, V6.S[0x2]
    SQRDMULH H2, H8, V7.H[0x3]
    FMLA V21.2S, V14.2S, V23.S[0x2]
    FMUL V6.2D, V7.2D, V25.D[0x1]
    UMULL V24.2D, V2.2S, V14.S[0x3]
    FMLA S31, S2, V24.S[0x2]
    UMULL V17.4S, V12.4H, V8.H[0x1]
    FMLA S13, S12, V21.S[0x1]
    FMUL V10.4S, V1.4S, V12.S[0x3]
    FMUL D1, D12, V3.D[0x0]
    MUL  V9.4H, V20.4H, V2.H[0x1]
    FMLA V24.2D, V23.2D, V31.D[0x0]
    UMULL2 V23.4S, V25.8H, V8.H[0x6]
    UMULL2 V27.4S, V3.8H, V14.H[0x4]
    UMULL2 V30.2D, V0.4S, V1.S[0x1]
    MUL  V30.8H, V19.8H, V11.H[0x5]
    FMULX D20, D17, V7.D[0x0]
    SQRDMULH  V16.2S, V24.2S, V20.2S
    FMLS D22, D30, V4.D[0x0]
    FMUL D16, D28, V7.D[0x0]
    MUL  V8.2S, V22.2S, V10.S[0x0]
    FMLA V17.4S, V13.4S, V13.S[0x2]
    UMULL2 V14.2D, V16.4S, V15.S[0x1]
    FMLS V9.2D, V1.2D, V21.D[0x1]
    FMULX V20.2D, V18.2D, V30.D[0x1]
    MLA  V7.4H, V21.4H, V12.H[0x0]
    FMUL D31, D7, V2.D[0x1]
    FMULX V6.4S, V23.4S, V22.S[0x3]
    SQRDMULH  V15.4H, V31.4H, V12.H[0x1]
    UMULL2 V21.2D, V19.4S, V18.S[0x0]
    UMULL2 V30.4S, V27.8H, V9.H[0x6]
    FMUL V6.4S, V24.4S, V29.S[0x3]
    FMULX V22.2D, V16.2D, V16.D[0x1]
    FMLS V18.2D, V3.2D, V3.D[0x1]
    FMLA S12, S22, V4.S[0x0]
    MUL  V15.8H, V16.8H, V13.H[0x2]
    FMLA S14, S6, V19.S[0x1]
    FMLA S20, S25, V31.S[0x2]
    FMUL V11.2D, V19.2D, V20.D[0x0]
    FMUL V11.2S, V12.2S, V18.S[0x1]
    MUL  V9.4S, V17.4S, V19.S[0x0]
    SQRDMULH  V10.4H, V13.4H, V11.H[0x2]
    UMULL V14.4S, V14.4H, V12.H[0x5]
    FMULX V17.2D, V6.2D, V9.D[0x0]
    SQRDMULH S9, S15, V27.S[0x3]
    FMLS D7, D12, V12.D[0x0]
    SQRDMULH  V22.2S, V23.2S, V9.2S
    MLS  V7.4H, V15.4H, V2.H[0x0]
    FMLS V27.2S, V1.2S, V14.S[0x1]
    FMLS V27.2S, V27.2S, V13.S[0x3]
    FMULX V18.2S, V12.2S, V30.S[0x0]
    UMULL2 V18.2D, V16.4S, V21.S[0x2]
    MUL  V21.2S, V18.2S, V22.S[0x0]
    FMUL V2.2D, V12.2D, V0.D[0x0]
    SQRDMULH  V3.8H, V26.8H, V1.H[0x4]
    MUL  V13.4H, V22.4H, V5.H[0x4]
    MLS  V16.8H, V10.8H, V3.H[0x6]
    FMULX D21, D20, V4.D[0x1]
    FMLS V11.2S, V4.2S, V2.S[0x2]
    FMULX V17.2S, V16.2S, V9.S[0x0]
    SQRDMULH  S4, S13, S24
    MUL  V6.4H, V20.4H, V13.H[0x1]
    FMUL S31, S20, V0.S[0x3]
    FMULX V22.4S, V30.4S, V24.S[0x1]
    MLS  V17.8H, V11.8H, V13.H[0x1]
    FMLA V2.4S, V8.4S, V13.S[0x1]
    SQRDMULH  V28.2S, V7.2S, V22.S[0x0]
    FMLS V7.2D, V2.2D, V3.D[0x1]
    MUL  V31.8H, V28.8H, V13.H[0x4]
    SQRDMULH S21, S27, V20.S[0x2]
    FMLS D14, D29, V5.D[0x1]
    FMLS D4, D6, V9.D[0x1]
    FMUL V11.2S, V14.2S, V4.S[0x3]
    FMUL S19, S12, V13.S[0x2]
    FMULX D16, D10, V28.D[0x0]
    FMLA D20, D14, V14.D[0x0]
    FMLS S31, S8, V31.S[0x2]
    MLS  V22.8H, V31.8H, V10.H[0x6]
    MLA  V19.4S, V14.4S, V3.S[0x3]
    MLS  V16.4H, V5.4H, V3.H[0x6]
    FMLA V20.2S, V26.2S, V26.S[0x0]
    FMLS V12.2D, V3.2D, V15.D[0x1]
    FMLA V0.2D, V10.2D, V24.D[0x1]
    SQRDMULH  S29, S20, S13
    FMULX D29, D14, V11.D[0x0]
    FMUL V19.2S, V27.2S, V19.S[0x2]
    UMULL2 V0.4S, V2.8H, V9.H[0x7]
    MLA  V11.4S, V30.4S, V16.S[0x2]
    FMLA D10, D15, V9.D[0x0]
    FMUL V28.2D, V30.2D, V29.D[0x0]
    SQRDMULH  H21, H2, H5
    MLS  V22.4H, V13.4H, V11.H[0x3]
    FMLS V2.2D, V20.2D, V29.D[0x0]
    FMLA V1.4S, V8.4S, V19.S[0x2]
    SQRDMULH  V22.2S, V24.2S, V12.2S
    FMLS V9.2D, V25.2D, V26.D[0x1]
    SQRDMULH  V21.8H, V23.8H, V4.H[0x2]
    MLS  V27.2S, V3.2S, V29.S[0x0]
    MLA  V0.8H, V22.8H, V0.H[0x4]
    FMLS V11.2D, V5.2D, V26.D[0x1]
    FMLS D21, D14, V21.D[0x1]
    FMLS S25, S31, V4.S[0x3]
    MLA  V20.8H, V29.8H, V3.H[0x7]
    SQRDMULH  S20, S20, S31
    FMUL S19, S19, V2.S[0x3]
    FMUL S11, S12, V8.S[0x2]
    SQRDMULH  V2.2S, V17.2S, V18.S[0x1]
    SQRDMULH  V4.2S, V31.2S, V18.S[0x0]
    FMULX D31, D11, V12.D[0x0]
    SQRDMULH  V27.8H, V20.8H, V7.H[0x1]
    UMULL V24.4S, V14.4H, V5.H[0x7]
    MUL  V9.2S, V9.2S, V18.S[0x0]
    FMLA V13.4S, V7.4S, V1.S[0x0]
    FMLS S22, S9, V11.S[0x3]
    FMUL D0, D15, V4.D[0x0]
    SQRDMULH  V30.8H, V0.8H, V6.H[0x5]
    MLS  V17.4S, V8.4S, V8.S[0x3]
    FMLS V26.2S, V9.2S, V23.S[0x3]
    FMULX D3, D23, V22.D[0x0]
    SQRDMULH  V27.2S, V14.2S, V1.2S
    SQRDMULH  V2.4H, V13.4H, V12.H[0x2]
    MLS  V24.4S, V16.4S, V12.S[0x0]
    SUBS  X4, X4, #0x1
    B.NE  TaishanSimdWideNarryArthemticP01_label_580
    MOVZ  X22, #0x0, LSL #0
    SUB  X28, X22, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X6, X8, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X16, X14, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X29, X12, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X15
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X17, X28, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X24, X20, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X3, X28, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X10, X18, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, D2
    MOVZ  X18, #0x0, LSL #0
    SUB  X10, X18, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, V3.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, D3
TaishanSimdWideNarryArthemticP01_label_180:
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X8, X2, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, D4
    MOVZ  X2, #0x0, LSL #0
    SUB  X8, X2, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, V5.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, D5
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, D6
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #48
    SUB  X3, X15, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, D7
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #16
    SUB  X3, X15, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, D8
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, D9
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, D10
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, D11
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #48
    SUB  X21, X11, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, D12
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #48
    SUB  X21, X11, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x8000, LSL #48
    SUB  X3, X20, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, D13
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x8000, LSL #16
    SUB  X3, X20, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, V14.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X20, X21, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, D14
    MOVZ  X21, #0x0, LSL #0
    SUB  X20, X21, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, D15
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, D16
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X6, X24, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, D17
    MOVZ  X24, #0x0, LSL #0
    SUB  X6, X24, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X13, X24, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, D18
    MOVZ  X24, #0x0, LSL #0
    SUB  X13, X24, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X24, X9, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D19
    MOVZ  X9, #0x0, LSL #0
    SUB  X24, X9, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D20
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, V21.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X17, X27, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, D21
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x8000, LSL #48
    SUB  X17, X27, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X17, D22
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #16
    SUB  X16, X4, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, D23
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X19
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, D24
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X19
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X21, X23, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, D26
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x8000, LSL #16
    MOVK  X23, #0x8000, LSL #48
    SUB  X21, X23, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, D27
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, D28
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, D29
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
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
    FMOV  D0, X12
    FMOV  V0.D[1], X4
    FMOV  D1, X28
    FMOV  V1.D[1], X4
    FMOV  D2, X27
    FMOV  V2.D[1], X17
    FMOV  D3, X5
    FMOV  V3.D[1], X16
    FMOV  D4, X5
    FMOV  V4.D[1], X8
    FMOV  D5, X29
    FMOV  V5.D[1], X17
    FMOV  D6, X4
    FMOV  V6.D[1], X13
    FMOV  D7, X7
    FMOV  V7.D[1], X5
    FMOV  D8, X17
    FMOV  V8.D[1], X21
    FMOV  D9, X18
    FMOV  V9.D[1], X23
    FMOV  D10, X20
    FMOV  V10.D[1], X2
    FMOV  D11, X3
    FMOV  V11.D[1], X5
    FMOV  D12, X5
    FMOV  V12.D[1], X26
    FMOV  D13, X21
    FMOV  V13.D[1], X2
    FMOV  D14, X24
    FMOV  V14.D[1], X17
    FMOV  D15, X28
    FMOV  V15.D[1], X29
    FMOV  D16, X20
    FMOV  V16.D[1], X8
    FMOV  D17, X7
    FMOV  V17.D[1], X16
    FMOV  D18, X5
    FMOV  V18.D[1], X10
    FMOV  D19, X16
    FMOV  V19.D[1], X28
    FMOV  D20, X24
    FMOV  V20.D[1], X28
    FMOV  D21, X15
    FMOV  V21.D[1], X13
    FMOV  D22, X15
    FMOV  V22.D[1], X5
    FMOV  D23, X17
    FMOV  V23.D[1], X19
    FMOV  D24, X8
    FMOV  V24.D[1], X7
    FMOV  D25, X5
    FMOV  V25.D[1], X9
    FMOV  D26, X10
    FMOV  V26.D[1], X19
    FMOV  D27, X29
    FMOV  V27.D[1], X7
    FMOV  D28, X9
    FMOV  V28.D[1], X17
    FMOV  D29, X8
    FMOV  V29.D[1], X20
    FMOV  D30, X4
    FMOV  V30.D[1], X13
    FMOV  D31, X2
    FMOV  V31.D[1], X17
    MOVZ  X6, #0xf, LSL #0
TaishanSimdWideNarryArthemticP01_label_663:
    UMULL2 V19.4S, V31.8H, V15.H[0x2]
    SQRDMULH S19, S1, V4.S[0x2]
    FMUL D20, D29, V22.D[0x1]
    FMLA S8, S25, V26.S[0x1]
    FMLS V22.2D, V24.2D, V30.D[0x1]
    FMLA S0, S20, V20.S[0x3]
    FMULX V17.2S, V5.2S, V9.S[0x0]
    FMLS S27, S3, V27.S[0x3]
    MUL  V8.2S, V0.2S, V16.S[0x0]
    FMLA V30.2D, V19.2D, V5.D[0x1]
    UMULL2 V22.4S, V27.8H, V7.H[0x0]
    UMULL2 V15.4S, V8.8H, V14.H[0x2]
    SQRDMULH H30, H13, V1.H[0x7]
    SQRDMULH  H13, H22, H9
    FMLA D15, D5, V20.D[0x0]
    UMULL2 V9.4S, V15.8H, V6.H[0x5]
    UMULL V31.2D, V16.2S, V13.S[0x0]
    FMLA V2.2S, V25.2S, V0.S[0x2]
    FMLA D21, D2, V8.D[0x0]
    FMLS V1.4S, V3.4S, V20.S[0x2]
    FMLA S3, S27, V12.S[0x2]
    FMUL D19, D16, V28.D[0x1]
    SQRDMULH  V14.8H, V26.8H, V0.H[0x3]
    FMULX S14, S0, V14.S[0x2]
    FMULX S25, S21, V12.S[0x2]
    FMLA S12, S13, V21.S[0x3]
    MUL  V9.2S, V26.2S, V2.S[0x3]
    UMULL V20.2D, V0.2S, V31.S[0x1]
    MUL  V8.4H, V28.4H, V4.H[0x0]
    SQRDMULH  V8.2S, V16.2S, V27.S[0x2]
    FMLA D26, D28, V28.D[0x1]
    FMLA D5, D6, V30.D[0x1]
    FMLS V21.2D, V24.2D, V16.D[0x1]
    FMULX S24, S18, V19.S[0x3]
    MUL  V4.8H, V7.8H, V8.H[0x2]
    MLS  V17.4S, V14.4S, V31.S[0x2]
    UMULL2 V5.2D, V26.4S, V20.S[0x3]
    UMULL V14.4S, V11.4H, V12.H[0x0]
    FMLS S9, S1, V4.S[0x2]
    SQRDMULH H3, H20, V2.H[0x5]
    FMUL V18.2D, V25.2D, V31.D[0x0]
    UMULL V7.4S, V9.4H, V14.H[0x4]
    FMLA D19, D18, V8.D[0x0]
    FMUL V17.4S, V25.4S, V3.S[0x2]
    SQRDMULH H3, H27, V10.H[0x0]
    FMUL V18.2S, V16.2S, V11.S[0x2]
    FMULX V19.4S, V15.4S, V7.S[0x1]
    FMLS V12.4S, V30.4S, V8.S[0x0]
    UMULL V12.2D, V15.2S, V25.S[0x3]
    FMLA V15.4S, V6.4S, V5.S[0x1]
    FMLA V14.2D, V13.2D, V5.D[0x0]
    SQRDMULH H2, H18, V6.H[0x0]
    UMULL2 V22.4S, V9.8H, V9.H[0x0]
    MLS  V22.2S, V25.2S, V14.S[0x1]
    UMULL V2.4S, V15.4H, V1.H[0x3]
    FMUL S24, S22, V16.S[0x3]
    MLA  V21.2S, V20.2S, V4.S[0x2]
    MUL  V3.8H, V11.8H, V1.H[0x5]
    SQRDMULH  H17, H9, H24
    FMUL D20, D10, V12.D[0x1]
    FMUL V25.2D, V30.2D, V23.D[0x0]
    UMULL2 V5.2D, V16.4S, V2.S[0x0]
    SQRDMULH  V3.4S, V28.4S, V31.4S
    FMULX D3, D31, V9.D[0x1]
    MUL  V22.2S, V23.2S, V15.S[0x3]
    MUL  V24.4H, V13.4H, V5.H[0x4]
    SQRDMULH  H16, H22, H2
    SQRDMULH  V24.8H, V12.8H, V14.H[0x4]
    FMULX V1.2D, V9.2D, V12.D[0x1]
    FMLA V27.2S, V30.2S, V22.S[0x1]
    UMULL2 V1.4S, V11.8H, V15.H[0x4]
    MLA  V4.4S, V23.4S, V14.S[0x0]
    FMLA V17.4S, V16.4S, V27.S[0x0]
    UMULL V2.2D, V9.2S, V24.S[0x2]
    FMULX V10.2D, V4.2D, V4.D[0x0]
    FMLS V16.2S, V4.2S, V17.S[0x3]
    FMLS V15.4S, V1.4S, V3.S[0x3]
    FMUL V18.2D, V30.2D, V17.D[0x0]
    MLA  V1.4S, V2.4S, V11.S[0x3]
    MUL  V9.4S, V15.4S, V27.S[0x3]
    FMLS S14, S18, V17.S[0x2]
    UMULL2 V25.2D, V13.4S, V17.S[0x1]
    MUL  V10.2S, V12.2S, V20.S[0x2]
    SQRDMULH  S28, S20, S15
    SQRDMULH  S25, S22, S22
    SQRDMULH  V21.8H, V16.8H, V2.H[0x5]
    SQRDMULH  H25, H10, H26
    SQRDMULH  V1.2S, V5.2S, V6.S[0x0]
    MLA  V2.8H, V12.8H, V8.H[0x0]
    MLS  V31.4H, V3.4H, V4.H[0x4]
    FMLS D31, D6, V8.D[0x0]
    FMULX V17.4S, V5.4S, V6.S[0x2]
    FMUL D9, D10, V8.D[0x0]
    FMLS S28, S31, V13.S[0x3]
    FMULX V27.4S, V15.4S, V3.S[0x2]
    MLS  V3.8H, V8.8H, V12.H[0x3]
    UMULL V15.2D, V12.2S, V12.S[0x1]
    SQRDMULH S17, S5, V12.S[0x1]
    UMULL2 V2.4S, V0.8H, V12.H[0x5]
    MUL  V14.4H, V24.4H, V2.H[0x1]
    FMLS S2, S30, V16.S[0x1]
    FMULX S30, S5, V16.S[0x1]
    UMULL2 V20.4S, V1.8H, V3.H[0x4]
    FMLA V20.2D, V6.2D, V1.D[0x0]
    MLA  V18.4S, V30.4S, V17.S[0x0]
    FMULX V1.2D, V24.2D, V21.D[0x0]
    UMULL V17.4S, V19.4H, V0.H[0x5]
    FMULX D4, D30, V23.D[0x0]
    FMLA D24, D23, V20.D[0x1]
    MUL  V15.8H, V24.8H, V8.H[0x0]
    MLA  V28.8H, V21.8H, V14.H[0x2]
    FMLA D20, D8, V27.D[0x0]
    FMLS V6.2D, V5.2D, V13.D[0x0]
    MUL  V8.8H, V14.8H, V2.H[0x6]
    FMULX D27, D17, V29.D[0x1]
    SQRDMULH  V17.8H, V26.8H, V3.H[0x3]
    FMLA V18.2D, V26.2D, V12.D[0x0]
    MLA  V19.8H, V5.8H, V10.H[0x0]
    UMULL V24.2D, V3.2S, V17.S[0x3]
    SQRDMULH  V31.8H, V3.8H, V2.H[0x0]
    MLS  V1.2S, V17.2S, V10.S[0x1]
    FMUL V26.4S, V18.4S, V1.S[0x2]
    MUL  V16.4H, V5.4H, V8.H[0x1]
    MLA  V2.4S, V5.4S, V10.S[0x1]
    UMULL V17.2D, V16.2S, V7.S[0x2]
    MLA  V28.4H, V26.4H, V9.H[0x6]
    FMLS V16.2D, V2.2D, V13.D[0x1]
    FMULX V20.2S, V27.2S, V19.S[0x0]
    FMLS D23, D27, V10.D[0x0]
    SQRDMULH H9, H8, V2.H[0x6]
    SQRDMULH H20, H19, V6.H[0x1]
    SQRDMULH  V14.4S, V6.4S, V0.S[0x2]
    MLS  V9.8H, V30.8H, V3.H[0x7]
    MUL  V16.4H, V7.4H, V8.H[0x6]
    FMULX D28, D17, V19.D[0x1]
    SQRDMULH  V14.2S, V12.2S, V19.S[0x3]
    UMULL2 V5.2D, V24.4S, V27.S[0x2]
    FMLA V14.2S, V20.2S, V30.S[0x2]
    MLS  V5.4H, V18.4H, V2.H[0x1]
    UMULL2 V27.4S, V15.8H, V9.H[0x5]
    SQRDMULH  V13.8H, V19.8H, V3.H[0x4]
    MLS  V24.2S, V2.2S, V11.S[0x2]
    MUL  V26.4H, V11.4H, V10.H[0x6]
    SQRDMULH  S5, S17, S15
    MLS  V20.4S, V27.4S, V26.S[0x1]
    MLA  V3.8H, V27.8H, V6.H[0x0]
    UMULL V9.4S, V23.4H, V3.H[0x0]
    MLS  V15.4H, V14.4H, V10.H[0x7]
    UMULL2 V15.2D, V19.4S, V26.S[0x2]
    FMUL V4.2D, V28.2D, V11.D[0x1]
    SQRDMULH  V17.4H, V26.4H, V9.H[0x1]
    FMLA V4.4S, V26.4S, V13.S[0x1]
    SQRDMULH  V19.2S, V15.2S, V4.S[0x0]
    SQRDMULH H13, H2, V1.H[0x6]
    SQRDMULH  V4.2S, V11.2S, V22.S[0x1]
    FMLS V18.4S, V24.4S, V12.S[0x1]
    MLA  V15.4S, V18.4S, V1.S[0x3]
    FMLS V1.2D, V10.2D, V31.D[0x0]
    FMLS D1, D17, V10.D[0x1]
    FMUL V5.4S, V15.4S, V0.S[0x0]
    MUL  V16.8H, V21.8H, V9.H[0x1]
    UMULL V21.2D, V24.2S, V4.S[0x1]
    MUL  V18.2S, V24.2S, V20.S[0x2]
    FMLA V21.4S, V18.4S, V22.S[0x3]
    SQRDMULH  V9.4S, V22.4S, V11.4S
    FMUL S21, S2, V23.S[0x1]
    FMLS V6.2D, V30.2D, V11.D[0x1]
    FMLS S11, S9, V4.S[0x0]
    MUL  V26.4H, V21.4H, V7.H[0x6]
    FMLA V1.2D, V2.2D, V13.D[0x1]
    MLS  V26.8H, V26.8H, V8.H[0x3]
    MLS  V3.4S, V3.4S, V12.S[0x0]
    SQRDMULH S19, S13, V3.S[0x2]
    MLA  V2.4S, V25.4S, V4.S[0x3]
    FMLA V30.2D, V14.2D, V21.D[0x1]
    MUL  V1.2S, V15.2S, V9.S[0x3]
    MLS  V2.2S, V19.2S, V28.S[0x3]
    FMUL D1, D27, V6.D[0x1]
    MLS  V2.4H, V26.4H, V1.H[0x1]
    FMLS V29.4S, V26.4S, V25.S[0x0]
    FMLS D26, D9, V11.D[0x0]
    FMULX V11.2D, V7.2D, V5.D[0x1]
    FMLS D9, D19, V11.D[0x1]
    UMULL2 V16.4S, V0.8H, V10.H[0x2]
    SQRDMULH  V25.8H, V17.8H, V9.8H
    SQRDMULH  V2.8H, V3.8H, V0.H[0x2]
    FMLA V0.2D, V4.2D, V25.D[0x1]
    FMULX D27, D0, V26.D[0x1]
    SQRDMULH  V27.4S, V19.4S, V13.4S
    SQRDMULH S17, S8, V17.S[0x0]
    MLA  V4.2S, V24.2S, V16.S[0x2]
    FMLA D29, D5, V29.D[0x0]
    MLA  V27.2S, V15.2S, V28.S[0x0]
    SQRDMULH  V14.4H, V27.4H, V2.H[0x3]
    UMULL V12.2D, V12.2S, V21.S[0x1]
    FMULX V0.2D, V29.2D, V23.D[0x0]
    MLS  V15.4S, V8.4S, V28.S[0x0]
    FMULX V12.2D, V12.2D, V28.D[0x0]
    FMLA V12.4S, V2.4S, V14.S[0x0]
    FMUL S17, S28, V28.S[0x2]
    SUBS  X6, X6, #0x1
    B.NE  TaishanSimdWideNarryArthemticP01_label_663
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X16, X11, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X4, X8, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X8, X3, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X29, X26, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X7, X4, X10
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X13, X20, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X19, X4, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X29, X20, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X15, X9, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X14, X28, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X19, X26, X19
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X5, X21, X20
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X9, X2, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X6, X19, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X8, X13, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X22, X23, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X17, X22, X16
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, D2
    MOVZ  X22, #0x0, LSL #0
    SUB  X17, X22, X16
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, D3
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, D4
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X19, X4, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, D5
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X19, X4, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X9, X3, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D6
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X9, X3, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, V7.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, D7
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, D8
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D9
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X16, X19, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, D10
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X27, X21, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, D11
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X27, X21, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, V12.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, D12
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, D13
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, D14
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X9, X24, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D15
    MOVZ  X24, #0x0, LSL #0
    SUB  X9, X24, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X17, X6, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, D16
    MOVZ  X6, #0x0, LSL #0
    SUB  X17, X6, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X3, X22, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, D17
    MOVZ  X22, #0x0, LSL #0
    SUB  X3, X22, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X9, X12, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, D18
    MOVZ  X12, #0x0, LSL #0
    SUB  X9, X12, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, D19
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, V20.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, D20
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, V21.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, D21
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X8, X11, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X15
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, D22
    MOVZ  X26, #0x1, LSL #0
    MOVK  X26, #0x1, LSL #32
    SUB  X4, X26, X15
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X26, X28, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, D23
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X26, X28, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D24
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #16
    SUB  X17, X16, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X13, X7, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, D26
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x8000, LSL #48
    SUB  X13, X7, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, V27.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, D27
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, D28
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, D29
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X9, X16, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X2, #0xfc0c, LSL #0
    MOVK  X2, #0x2889, LSL #16
    MOVK  X2, #0xbbf3, LSL #32
    MOVK  X2, #0x1f00, LSL #48
    MOVZ  X3, #0x827, LSL #0
    MOVK  X3, #0x82df, LSL #16
    MOVK  X3, #0x90a, LSL #32
    MOVK  X3, #0xac22, LSL #48
    MOVZ  X4, #0x6d4a, LSL #0
    MOVK  X4, #0xf5d8, LSL #16
    MOVK  X4, #0x34aa, LSL #32
    MOVK  X4, #0x557c, LSL #48
    MOVZ  X5, #0x71e3, LSL #0
    MOVK  X5, #0x94a4, LSL #16
    MOVK  X5, #0xa8ac, LSL #32
    MOVK  X5, #0xa1d, LSL #48
    MOVZ  X6, #0x88d5, LSL #0
    MOVK  X6, #0xb671, LSL #16
    MOVK  X6, #0x54d3, LSL #32
    MOVK  X6, #0x48bd, LSL #48
    MOVZ  X7, #0xb5a1, LSL #0
    MOVK  X7, #0xcaae, LSL #16
    MOVK  X7, #0xfa0e, LSL #32
    MOVK  X7, #0x6fac, LSL #48
    MOVZ  X8, #0xfdce, LSL #0
    MOVK  X8, #0x5f9f, LSL #16
    MOVK  X8, #0xb231, LSL #32
    MOVK  X8, #0xddf8, LSL #48
    MOVZ  X9, #0x4a3f, LSL #0
    MOVK  X9, #0x2e1, LSL #16
    MOVK  X9, #0xcced, LSL #32
    MOVK  X9, #0x6a19, LSL #48
    MOVZ  X10, #0x98a, LSL #0
    MOVK  X10, #0x477c, LSL #16
    MOVK  X10, #0x6ff1, LSL #32
    MOVK  X10, #0x435a, LSL #48
    MOVZ  X11, #0xbe2, LSL #0
    MOVK  X11, #0x86b6, LSL #16
    MOVK  X11, #0xd926, LSL #32
    MOVK  X11, #0xc1e7, LSL #48
    MOVZ  X12, #0xfe2d, LSL #0
    MOVK  X12, #0x5563, LSL #16
    MOVK  X12, #0xbb25, LSL #32
    MOVK  X12, #0xf103, LSL #48
    MOVZ  X13, #0x4bdc, LSL #0
    MOVK  X13, #0x3d2a, LSL #16
    MOVK  X13, #0x3cd5, LSL #32
    MOVK  X13, #0x255f, LSL #48
    MOVZ  X14, #0xfcff, LSL #0
    MOVK  X14, #0xd3d1, LSL #16
    MOVK  X14, #0x932e, LSL #32
    MOVK  X14, #0x22ae, LSL #48
    MOVZ  X15, #0x455, LSL #0
    MOVK  X15, #0xb6cc, LSL #16
    MOVK  X15, #0x22af, LSL #32
    MOVK  X15, #0x3a45, LSL #48
    MOVZ  X16, #0xc4fd, LSL #0
    MOVK  X16, #0x2cc7, LSL #16
    MOVK  X16, #0xcf4b, LSL #32
    MOVK  X16, #0xe729, LSL #48
    MOVZ  X17, #0x5387, LSL #0
    MOVK  X17, #0x9103, LSL #16
    MOVK  X17, #0xb952, LSL #32
    MOVK  X17, #0xb9c3, LSL #48
    MOVZ  X18, #0x5904, LSL #0
    MOVK  X18, #0xfe92, LSL #16
    MOVK  X18, #0x3371, LSL #32
    MOVK  X18, #0x31bb, LSL #48
    MOVZ  X19, #0x22e, LSL #0
    MOVK  X19, #0xb0e, LSL #16
    MOVK  X19, #0x9000, LSL #32
    MOVK  X19, #0xc7ca, LSL #48
    MOVZ  X20, #0x707, LSL #0
    MOVK  X20, #0x4590, LSL #16
    MOVK  X20, #0x795e, LSL #32
    MOVK  X20, #0x3bd3, LSL #48
    MOVZ  X21, #0x1023, LSL #0
    MOVK  X21, #0xd01d, LSL #16
    MOVK  X21, #0x4ec8, LSL #32
    MOVK  X21, #0xfed, LSL #48
    MOVZ  X22, #0x7f53, LSL #0
    MOVK  X22, #0x89f8, LSL #16
    MOVK  X22, #0x4ae1, LSL #32
    MOVK  X22, #0x20c5, LSL #48
    MOVZ  X23, #0x579c, LSL #0
    MOVK  X23, #0x24e1, LSL #16
    MOVK  X23, #0xf41e, LSL #32
    MOVK  X23, #0x83ec, LSL #48
    MOVZ  X24, #0x9532, LSL #0
    MOVK  X24, #0x391a, LSL #16
    MOVK  X24, #0x86bd, LSL #32
    MOVK  X24, #0x755d, LSL #48
    MOVZ  X26, #0xf061, LSL #0
    MOVK  X26, #0xb14e, LSL #16
    MOVK  X26, #0xef35, LSL #32
    MOVK  X26, #0x3374, LSL #48
    MOVZ  X27, #0xf0a4, LSL #0
    MOVK  X27, #0x9817, LSL #16
    MOVK  X27, #0x3b8f, LSL #32
    MOVK  X27, #0xb0dd, LSL #48
    MOVZ  X28, #0x6e47, LSL #0
    MOVK  X28, #0x76dc, LSL #16
    MOVK  X28, #0xdc08, LSL #32
    MOVK  X28, #0x246d, LSL #48
    MOVZ  X29, #0x6831, LSL #0
    MOVK  X29, #0x1ee8, LSL #16
    MOVK  X29, #0x67d8, LSL #32
    MOVK  X29, #0xdc9d, LSL #48
    FMOV  D0, X4
    FMOV  V0.D[1], X13
    FMOV  D1, X2
    FMOV  V1.D[1], X29
    FMOV  D2, X8
    FMOV  V2.D[1], X20
    FMOV  D3, X2
    FMOV  V3.D[1], X28
    FMOV  D4, X10
    FMOV  V4.D[1], X13
    FMOV  D5, X7
    FMOV  V5.D[1], X29
    FMOV  D6, X16
    FMOV  V6.D[1], X27
    FMOV  D7, X12
    FMOV  V7.D[1], X18
    FMOV  D8, X16
    FMOV  V8.D[1], X19
    FMOV  D9, X11
    FMOV  V9.D[1], X19
    FMOV  D10, X19
    FMOV  V10.D[1], X21
    FMOV  D11, X21
    FMOV  V11.D[1], X3
    FMOV  D12, X26
    FMOV  V12.D[1], X21
    FMOV  D13, X10
    FMOV  V13.D[1], X5
    FMOV  D14, X9
    FMOV  V14.D[1], X26
    FMOV  D15, X11
    FMOV  V15.D[1], X14
    FMOV  D16, X18
    FMOV  V16.D[1], X16
    FMOV  D17, X15
    FMOV  V17.D[1], X20
    FMOV  D18, X28
    FMOV  V18.D[1], X4
    FMOV  D19, X2
    FMOV  V19.D[1], X17
    FMOV  D20, X14
    FMOV  V20.D[1], X4
    FMOV  D21, X3
    FMOV  V21.D[1], X3
    FMOV  D22, X2
    FMOV  V22.D[1], X27
    FMOV  D23, X22
    FMOV  V23.D[1], X16
    FMOV  D24, X5
    FMOV  V24.D[1], X19
    FMOV  D25, X4
    FMOV  V25.D[1], X22
    FMOV  D26, X24
    FMOV  V26.D[1], X20
    FMOV  D27, X29
    FMOV  V27.D[1], X8
    FMOV  D28, X2
    FMOV  V28.D[1], X14
    FMOV  D29, X14
    FMOV  V29.D[1], X9
    FMOV  D30, X4
    FMOV  V30.D[1], X19
    FMOV  D31, X17
    FMOV  V31.D[1], X24
    MOVZ  X4, #0xa, LSL #0
TaishanSimdWideNarryArthemticP01_label_744:
    SQRDMULH H6, H5, V12.H[0x7]
    UMULL V23.2D, V31.2S, V25.S[0x3]
    MLS  V31.4H, V19.4H, V12.H[0x1]
    SQRDMULH  V1.4S, V9.4S, V16.4S
    UMULL V27.2D, V31.2S, V22.S[0x0]
    FMULX D1, D16, V27.D[0x1]
    FMUL V25.4S, V1.4S, V21.S[0x3]
    FMLS S23, S25, V25.S[0x0]
    UMULL2 V26.4S, V26.8H, V2.H[0x5]
    FMUL V15.2D, V10.2D, V11.D[0x0]
    FMLA S17, S29, V6.S[0x3]
    FMLS V27.2D, V31.2D, V27.D[0x0]
    UMULL V29.4S, V27.4H, V6.H[0x1]
    FMLA D30, D13, V19.D[0x1]
    UMULL V7.4S, V22.4H, V9.H[0x4]
    MUL  V28.4S, V26.4S, V14.S[0x3]
    MLS  V20.2S, V12.2S, V2.S[0x2]
    FMLA S22, S10, V5.S[0x3]
    SQRDMULH S20, S13, V6.S[0x0]
    FMLA V20.4S, V15.4S, V19.S[0x1]
    FMULX D23, D6, V5.D[0x0]
    FMLS S21, S29, V12.S[0x3]
    FMLS V18.2D, V9.2D, V6.D[0x1]
    FMLA V14.2D, V16.2D, V8.D[0x1]
    FMLS V12.4S, V26.4S, V11.S[0x1]
    FMLA D12, D23, V0.D[0x0]
    UMULL V1.2D, V6.2S, V3.S[0x1]
    FMULX S7, S24, V12.S[0x3]
    FMLS D10, D8, V14.D[0x0]
    UMULL V22.4S, V30.4H, V7.H[0x5]
    FMLA V28.4S, V20.4S, V30.S[0x0]
    MLA  V14.4H, V30.4H, V13.H[0x5]
    FMULX V21.2S, V4.2S, V8.S[0x3]
    SQRDMULH  S14, S18, S1
    FMULX D1, D8, V4.D[0x1]
    SQRDMULH  V23.8H, V20.8H, V10.8H
    FMLS D20, D0, V9.D[0x0]
    FMUL V9.2D, V5.2D, V11.D[0x1]
    UMULL2 V2.2D, V15.4S, V7.S[0x1]
    UMULL V23.2D, V22.2S, V0.S[0x0]
    FMUL D28, D1, V25.D[0x0]
    MUL  V26.2S, V13.2S, V21.S[0x3]
    FMLA D18, D15, V19.D[0x1]
    SQRDMULH S30, S3, V23.S[0x0]
    MLA  V30.4H, V21.4H, V0.H[0x7]
    FMULX D31, D5, V7.D[0x0]
    MLA  V4.8H, V21.8H, V12.H[0x2]
    FMUL V31.2S, V22.2S, V18.S[0x0]
    FMLS D28, D19, V29.D[0x0]
    MUL  V5.4S, V13.4S, V5.S[0x1]
    SQRDMULH  H20, H20, H21
    FMUL S24, S4, V20.S[0x3]
    FMULX D8, D20, V31.D[0x1]
    FMUL V27.2D, V26.2D, V22.D[0x0]
    SQRDMULH  H16, H5, H17
    MLA  V20.2S, V28.2S, V17.S[0x2]
    FMUL D21, D30, V25.D[0x0]
    MUL  V16.2S, V9.2S, V18.S[0x1]
    SQRDMULH  S19, S31, S15
    SQRDMULH  V2.4H, V17.4H, V5.H[0x5]
    MLA  V16.4H, V3.4H, V8.H[0x0]
    FMLS V30.2D, V5.2D, V26.D[0x1]
    FMLA V23.2D, V0.2D, V9.D[0x0]
    FMLS V0.2S, V3.2S, V29.S[0x3]
    UMULL2 V1.4S, V7.8H, V5.H[0x2]
    SQRDMULH  S23, S22, S29
    FMUL V28.2D, V30.2D, V21.D[0x0]
    MLS  V30.8H, V21.8H, V8.H[0x3]
    SQRDMULH  H11, H16, H3
    FMLS V22.2D, V11.2D, V24.D[0x0]
    FMLS D18, D30, V13.D[0x1]
    FMLA V27.2S, V13.2S, V3.S[0x0]
    MUL  V20.8H, V8.8H, V15.H[0x4]
    MUL  V12.4H, V27.4H, V12.H[0x7]
    MLS  V7.4H, V4.4H, V1.H[0x3]
    MLA  V12.4H, V31.4H, V12.H[0x1]
    FMUL V8.2S, V19.2S, V7.S[0x1]
    MLA  V6.4H, V15.4H, V13.H[0x5]
    FMUL V22.2S, V7.2S, V3.S[0x2]
    FMLA V4.4S, V28.4S, V23.S[0x3]
    FMLA V29.2D, V20.2D, V16.D[0x1]
    SQRDMULH  V24.4S, V15.4S, V3.S[0x0]
    FMLA D31, D12, V15.D[0x1]
    MUL  V5.4H, V5.4H, V0.H[0x6]
    FMUL V16.2D, V29.2D, V23.D[0x1]
    MUL  V9.2S, V0.2S, V9.S[0x2]
    UMULL V19.4S, V8.4H, V6.H[0x2]
    FMLA V3.2S, V28.2S, V2.S[0x3]
    FMULX D8, D27, V18.D[0x0]
    SQRDMULH H18, H27, V9.H[0x4]
    UMULL2 V24.2D, V11.4S, V17.S[0x2]
    FMLA V5.2D, V20.2D, V0.D[0x1]
    FMLS V12.2D, V7.2D, V2.D[0x0]
    MLA  V14.4H, V20.4H, V7.H[0x5]
    SQRDMULH  V5.4S, V11.4S, V27.S[0x2]
    FMUL V28.2S, V29.2S, V24.S[0x0]
    FMLS V24.2D, V14.2D, V14.D[0x0]
    FMULX V25.2D, V18.2D, V25.D[0x1]
    FMLA D1, D15, V12.D[0x1]
    FMLS S19, S20, V22.S[0x1]
    SQRDMULH H25, H5, V13.H[0x7]
    UMULL2 V19.2D, V7.4S, V30.S[0x3]
    FMULX V12.2S, V13.2S, V1.S[0x2]
    MUL  V8.4H, V6.4H, V3.H[0x5]
    FMUL S24, S25, V25.S[0x1]
    FMLS V23.2D, V13.2D, V30.D[0x0]
    SQRDMULH S14, S17, V7.S[0x3]
    FMLA D19, D7, V10.D[0x0]
    MLS  V16.2S, V23.2S, V9.S[0x2]
    SQRDMULH  S22, S16, S7
    FMULX V0.2S, V2.2S, V10.S[0x3]
    MUL  V27.4H, V20.4H, V15.H[0x1]
    MUL  V14.4H, V18.4H, V2.H[0x2]
    MLA  V3.8H, V23.8H, V3.H[0x0]
    MLS  V7.4S, V3.4S, V15.S[0x1]
    FMLS D27, D0, V31.D[0x0]
    FMLA V12.2S, V17.2S, V25.S[0x0]
    MUL  V20.4H, V3.4H, V14.H[0x5]
    SQRDMULH  V10.2S, V24.2S, V1.S[0x0]
    SQRDMULH H1, H27, V15.H[0x5]
    FMLA V10.4S, V2.4S, V31.S[0x3]
    FMLA D17, D19, V30.D[0x0]
    FMUL V24.2D, V20.2D, V12.D[0x1]
    MLS  V22.8H, V6.8H, V6.H[0x0]
    FMULX D22, D11, V23.D[0x1]
    MLS  V19.2S, V13.2S, V25.S[0x2]
    FMULX V7.2D, V4.2D, V7.D[0x1]
    FMLA V14.4S, V4.4S, V14.S[0x1]
    MUL  V1.2S, V20.2S, V5.S[0x1]
    UMULL2 V18.4S, V16.8H, V9.H[0x0]
    SQRDMULH  V2.4H, V10.4H, V12.H[0x1]
    MLA  V31.2S, V25.2S, V19.S[0x0]
    MLA  V26.8H, V8.8H, V14.H[0x6]
    FMLS S15, S1, V0.S[0x2]
    MLA  V0.4H, V13.4H, V9.H[0x2]
    FMULX V3.2D, V23.2D, V26.D[0x0]
    SQRDMULH  V9.8H, V17.8H, V16.8H
    FMULX S2, S15, V22.S[0x2]
    FMULX S20, S31, V23.S[0x1]
    MUL  V31.4S, V24.4S, V20.S[0x1]
    FMLA S22, S29, V24.S[0x2]
    FMULX S25, S3, V23.S[0x0]
    SQRDMULH  S26, S11, S30
    UMULL2 V9.4S, V9.8H, V4.H[0x5]
    SQRDMULH S22, S9, V27.S[0x1]
    FMLA D19, D31, V0.D[0x1]
    UMULL V2.4S, V28.4H, V9.H[0x4]
    FMLS S11, S6, V4.S[0x2]
    FMLS S5, S27, V7.S[0x3]
    MLA  V10.2S, V1.2S, V29.S[0x1]
    UMULL V13.4S, V19.4H, V14.H[0x4]
    MLS  V13.4S, V10.4S, V9.S[0x0]
    SQRDMULH H28, H3, V7.H[0x7]
    FMLS V28.4S, V16.4S, V20.S[0x3]
    SQRDMULH  V16.8H, V6.8H, V4.8H
    MLS  V25.8H, V19.8H, V2.H[0x2]
    SQRDMULH  S8, S20, S31
    FMLA S20, S9, V0.S[0x3]
    SQRDMULH  V2.4S, V24.4S, V12.S[0x3]
    MLA  V30.2S, V20.2S, V31.S[0x0]
    FMLA V13.2D, V15.2D, V29.D[0x1]
    FMLA D19, D29, V31.D[0x0]
    SQRDMULH  V30.4S, V28.4S, V0.4S
    FMLA V28.2S, V26.2S, V15.S[0x0]
    FMLS V8.2D, V16.2D, V1.D[0x0]
    SQRDMULH  V4.8H, V18.8H, V0.H[0x6]
    FMLA S26, S7, V9.S[0x1]
    FMLS V17.2D, V29.2D, V15.D[0x1]
    UMULL V31.4S, V7.4H, V7.H[0x3]
    SQRDMULH  V20.2S, V31.2S, V31.S[0x2]
    MLS  V12.2S, V10.2S, V27.S[0x1]
    FMUL S6, S13, V31.S[0x2]
    FMLA S2, S25, V3.S[0x3]
    FMLA V19.2D, V17.2D, V3.D[0x0]
    MLS  V18.8H, V17.8H, V14.H[0x6]
    MLA  V14.8H, V19.8H, V3.H[0x7]
    FMLS D4, D15, V5.D[0x0]
    FMLA V28.2D, V22.2D, V4.D[0x1]
    MUL  V12.8H, V10.8H, V9.H[0x0]
    SQRDMULH  V12.4S, V8.4S, V5.4S
    FMLA V0.4S, V8.4S, V14.S[0x2]
    FMLA V6.4S, V27.4S, V5.S[0x1]
    FMLA V26.4S, V19.4S, V4.S[0x0]
    FMLS V11.2S, V5.2S, V5.S[0x3]
    FMUL V6.4S, V30.4S, V19.S[0x1]
    SQRDMULH  S22, S17, S19
    FMLA S28, S21, V8.S[0x0]
    MUL  V27.8H, V13.8H, V1.H[0x2]
    FMLA S17, S12, V31.S[0x3]
    UMULL V8.2D, V27.2S, V4.S[0x0]
    SQRDMULH  V0.4S, V25.4S, V25.S[0x2]
    UMULL2 V18.2D, V11.4S, V18.S[0x0]
    FMLA D1, D11, V0.D[0x0]
    SQRDMULH  H11, H7, H22
    FMLS S2, S11, V0.S[0x2]
    SQRDMULH  H2, H28, H15
    FMUL D0, D22, V6.D[0x0]
    SQRDMULH  V7.4S, V20.4S, V19.S[0x1]
    UMULL2 V30.4S, V25.8H, V14.H[0x6]
    SQRDMULH  V9.2S, V0.2S, V29.S[0x1]
    SUBS  X4, X4, #0x1
    B.NE  TaishanSimdWideNarryArthemticP01_label_744
    MOVZ  X8, #0xfc0c, LSL #0
    MOVK  X8, #0x2889, LSL #16
    MOVK  X8, #0xbbf3, LSL #32
    MOVK  X8, #0x1f00, LSL #48
    SUB  X17, X8, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X18, #0x827, LSL #0
    MOVK  X18, #0x82df, LSL #16
    MOVK  X18, #0x90a, LSL #32
    MOVK  X18, #0xac22, LSL #48
    SUB  X15, X18, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X6, #0x71e3, LSL #0
    MOVK  X6, #0x94a4, LSL #16
    MOVK  X6, #0xa8ac, LSL #32
    MOVK  X6, #0xa1d, LSL #48
    SUB  X5, X6, X5
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X8, #0x71e3, LSL #0
    MOVK  X8, #0x94a4, LSL #16
    MOVK  X8, #0xa8ac, LSL #32
    MOVK  X8, #0xa1d, LSL #48
    SUB  X16, X8, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X10, #0xb5a1, LSL #0
    MOVK  X10, #0xcaae, LSL #16
    MOVK  X10, #0xfa0e, LSL #32
    MOVK  X10, #0x6fac, LSL #48
    SUB  X29, X10, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X9, #0x71e3, LSL #0
    MOVK  X9, #0x94a4, LSL #16
    MOVK  X9, #0xa8ac, LSL #32
    MOVK  X9, #0xa1d, LSL #48
    SUB  X28, X9, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X13, #0x71e3, LSL #0
    MOVK  X13, #0x94a4, LSL #16
    MOVK  X13, #0xa8ac, LSL #32
    MOVK  X13, #0xa1d, LSL #48
    SUB  X14, X13, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X27, #0xb5a1, LSL #0
    MOVK  X27, #0xcaae, LSL #16
    MOVK  X27, #0xfa0e, LSL #32
    MOVK  X27, #0x6fac, LSL #48
    SUB  X21, X27, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X28, #0xbe2, LSL #0
    MOVK  X28, #0x86b6, LSL #16
    MOVK  X28, #0xd926, LSL #32
    MOVK  X28, #0xc1e7, LSL #48
    SUB  X15, X28, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X20, #0xfe2d, LSL #0
    MOVK  X20, #0x5563, LSL #16
    MOVK  X20, #0xbb25, LSL #32
    MOVK  X20, #0xf103, LSL #48
    SUB  X26, X20, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X12, #0x71e3, LSL #0
    MOVK  X12, #0x94a4, LSL #16
    MOVK  X12, #0xa8ac, LSL #32
    MOVK  X12, #0xa1d, LSL #48
    SUB  X29, X12, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X5, X12, X15
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X19, X11, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X10, #0x827, LSL #0
    MOVK  X10, #0x82df, LSL #16
    MOVK  X10, #0x90a, LSL #32
    MOVK  X10, #0xac22, LSL #48
    SUB  X23, X10, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X3, #0xfe2d, LSL #0
    MOVK  X3, #0x5563, LSL #16
    MOVK  X3, #0xbb25, LSL #32
    MOVK  X3, #0xf103, LSL #48
    SUB  X9, X3, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X4, X5, X22
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X9, X29, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X29, #0x9532, LSL #0
    MOVK  X29, #0x391a, LSL #16
    MOVK  X29, #0x86bd, LSL #32
    MOVK  X29, #0x755d, LSL #48
    SUB  X27, X29, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X26, X15, X26
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X27
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X19, #0xbe2, LSL #0
    MOVK  X19, #0x86b6, LSL #16
    MOVK  X19, #0xd926, LSL #32
    MOVK  X19, #0xc1e7, LSL #48
    SUB  X9, X19, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X14, #0x9532, LSL #0
    MOVK  X14, #0x391a, LSL #16
    MOVK  X14, #0x86bd, LSL #32
    MOVK  X14, #0x755d, LSL #48
    SUB  X22, X14, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D2
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, D3
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X29, X26, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, D4
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x8000, LSL #48
    SUB  X29, X26, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, D5
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, D6
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, D7
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, D8
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, V9.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, D9
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, V10.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, D10
TaishanSimdWideNarryArthemticP01_label_784:
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, D11
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V12.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D12
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X27, X3, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, D13
    MOVZ  X3, #0x0, LSL #0
    SUB  X27, X3, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #48
    SUB  X7, X11, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, D14
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #48
    SUB  X7, X11, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, V15.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, D15
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x8000, LSL #16
    SUB  X20, X7, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, V16.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, D16
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, D17
    MOVZ  X26, #0xb092, LSL #0
TaishanSimdWideNarryArthemticP01_label_70:
    MOVK  X26, #0xddd9, LSL #16
    SUB  X14, X26, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, D18
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x8000, LSL #48
    SUB  X4, X9, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, D19
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X26, X2, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, D20
    MOVZ  X2, #0x0, LSL #0
    SUB  X26, X2, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, D21
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, D22
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, D23
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, D24
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x8000, LSL #48
    SUB  X29, X19, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, D26
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, V27.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, D27
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X5, X12, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, D28
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #16
    SUB  X5, X12, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, D29
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
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
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X15
    FMOV  V0.D[1], X10
    FMOV  D1, X24
    FMOV  V1.D[1], X20
    FMOV  D2, X3
    FMOV  V2.D[1], X24
    FMOV  D3, X26
    FMOV  V3.D[1], X4
    FMOV  D4, X4
    FMOV  V4.D[1], X18
    FMOV  D5, X16
    FMOV  V5.D[1], X28
    FMOV  D6, X2
    FMOV  V6.D[1], X19
    FMOV  D7, X13
    FMOV  V7.D[1], X22
    FMOV  D8, X23
    FMOV  V8.D[1], X3
    FMOV  D9, X18
    FMOV  V9.D[1], X8
    FMOV  D10, X4
    FMOV  V10.D[1], X11
    FMOV  D11, X4
    FMOV  V11.D[1], X15
    FMOV  D12, X27
    FMOV  V12.D[1], X24
    FMOV  D13, X24
    FMOV  V13.D[1], X18
    FMOV  D14, X6
    FMOV  V14.D[1], X11
    FMOV  D15, X7
    FMOV  V15.D[1], X4
    FMOV  D16, X13
    FMOV  V16.D[1], X14
    FMOV  D17, X24
    FMOV  V17.D[1], X16
    FMOV  D18, X26
    FMOV  V18.D[1], X15
    FMOV  D19, X4
    FMOV  V19.D[1], X13
    FMOV  D20, X4
    FMOV  V20.D[1], X20
    FMOV  D21, X13
    FMOV  V21.D[1], X20
    FMOV  D22, X7
    FMOV  V22.D[1], X26
    FMOV  D23, X15
    FMOV  V23.D[1], X22
    FMOV  D24, X18
    FMOV  V24.D[1], X14
    FMOV  D25, X17
    FMOV  V25.D[1], X7
    FMOV  D26, X3
    FMOV  V26.D[1], X26
    FMOV  D27, X24
    FMOV  V27.D[1], X26
    FMOV  D28, X23
    FMOV  V28.D[1], X28
    FMOV  D29, X7
    FMOV  V29.D[1], X28
    FMOV  D30, X15
    FMOV  V30.D[1], X22
    FMOV  D31, X15
    FMOV  V31.D[1], X2
    MOVZ  X28, #0xa, LSL #0
TaishanSimdWideNarryArthemticP01_label_825:
    FMLS V19.2D, V20.2D, V1.D[0x1]
    FMULX V13.2S, V12.2S, V11.S[0x0]
    FMULX S6, S31, V9.S[0x0]
    MLS  V30.4H, V25.4H, V9.H[0x0]
    SQRDMULH  V17.4H, V17.4H, V10.H[0x3]
    FMLS D22, D20, V31.D[0x0]
    MLA  V29.2S, V29.2S, V8.S[0x0]
    MUL  V28.4H, V27.4H, V9.H[0x6]
    FMUL D25, D31, V16.D[0x0]
    SQRDMULH H26, H15, V4.H[0x6]
    FMLA V16.2D, V0.2D, V8.D[0x0]
    UMULL2 V16.4S, V26.8H, V11.H[0x0]
    MUL  V27.4S, V18.4S, V26.S[0x2]
    FMLA V13.2D, V14.2D, V9.D[0x1]
    SQRDMULH  H30, H29, H2
    FMUL S12, S28, V21.S[0x2]
    SQRDMULH  S23, S3, S29
    SQRDMULH H14, H25, V3.H[0x1]
    MLS  V11.8H, V12.8H, V10.H[0x4]
    MLS  V6.4H, V20.4H, V2.H[0x6]
    SQRDMULH  S6, S9, S1
    SQRDMULH S1, S19, V20.S[0x1]
    SQRDMULH S31, S21, V14.S[0x2]
    FMULX D19, D26, V5.D[0x1]
    SQRDMULH  V9.8H, V29.8H, V2.H[0x4]
    FMLS S31, S12, V9.S[0x0]
    SQRDMULH  V12.8H, V23.8H, V9.H[0x6]
    FMUL V8.2D, V25.2D, V7.D[0x1]
    FMLA V10.2D, V3.2D, V21.D[0x0]
    FMULX D11, D20, V27.D[0x0]
    FMLA S6, S15, V6.S[0x0]
    UMULL V29.4S, V16.4H, V7.H[0x1]
    SQRDMULH  H1, H17, H6
    MLA  V26.4S, V6.4S, V14.S[0x0]
    SQRDMULH  V27.2S, V31.2S, V25.S[0x3]
    MLA  V23.2S, V19.2S, V22.S[0x3]
    MLA  V18.4H, V8.4H, V3.H[0x2]
    SQRDMULH  H8, H22, H17
    FMULX D10, D26, V1.D[0x0]
    MLA  V10.8H, V13.8H, V11.H[0x3]
    MLA  V4.4H, V16.4H, V5.H[0x2]
    MUL  V30.8H, V2.8H, V11.H[0x2]
    UMULL2 V3.4S, V23.8H, V8.H[0x4]
    MLA  V18.4H, V6.4H, V5.H[0x0]
    FMULX D17, D27, V3.D[0x0]
    FMULX S27, S0, V28.S[0x2]
    FMLA D21, D22, V18.D[0x0]
    SQRDMULH  V23.4S, V14.4S, V23.4S
    SQRDMULH  H21, H5, H17
    FMULX D6, D23, V19.D[0x1]
    FMUL S15, S16, V28.S[0x1]
    FMUL S27, S0, V30.S[0x2]
    MUL  V15.4S, V4.4S, V1.S[0x0]
    MUL  V10.2S, V10.2S, V13.S[0x2]
    SQRDMULH  V0.4H, V14.4H, V23.4H
    UMULL2 V10.2D, V11.4S, V8.S[0x1]
    SQRDMULH  V7.8H, V29.8H, V25.8H
    SQRDMULH S18, S21, V6.S[0x0]
    UMULL2 V18.2D, V3.4S, V26.S[0x1]
    FMULX S1, S27, V19.S[0x1]
    FMLS V10.2D, V24.2D, V5.D[0x0]
    SQRDMULH S16, S30, V20.S[0x2]
    FMLA D23, D15, V23.D[0x1]
    UMULL2 V19.2D, V26.4S, V10.S[0x2]
    SQRDMULH H26, H23, V9.H[0x5]
    SQRDMULH  H13, H21, H10
    FMLS V28.2D, V31.2D, V16.D[0x0]
    FMULX D20, D11, V4.D[0x0]
    FMLS V19.2D, V22.2D, V24.D[0x1]
    FMULX S0, S30, V12.S[0x0]
    SQRDMULH  V19.2S, V13.2S, V24.S[0x1]
    FMULX S18, S19, V28.S[0x3]
    MUL  V6.4H, V3.4H, V12.H[0x4]
    FMULX D19, D9, V19.D[0x0]
    MLS  V26.8H, V18.8H, V8.H[0x2]
    FMLA D28, D17, V31.D[0x0]
    FMLA S14, S22, V17.S[0x3]
    UMULL V30.2D, V18.2S, V12.S[0x2]
    UMULL V4.2D, V8.2S, V7.S[0x0]
    SQRDMULH  H26, H6, H11
    MUL  V11.4H, V1.4H, V8.H[0x4]
    FMULX V10.2D, V3.2D, V27.D[0x0]
    FMUL V27.2S, V4.2S, V21.S[0x1]
    FMULX S30, S21, V10.S[0x2]
    MLA  V24.8H, V3.8H, V9.H[0x7]
    FMUL V14.2D, V27.2D, V17.D[0x1]
    FMULX D26, D22, V20.D[0x0]
    MUL  V29.8H, V13.8H, V5.H[0x6]
    SQRDMULH  S26, S23, S6
    SQRDMULH  V24.2S, V10.2S, V19.S[0x2]
    SQRDMULH  S7, S3, S28
    FMULX S9, S3, V4.S[0x3]
    FMUL D11, D29, V3.D[0x0]
    MLA  V5.2S, V11.2S, V30.S[0x2]
    FMULX S8, S16, V29.S[0x3]
    SQRDMULH S13, S16, V26.S[0x1]
    UMULL V10.4S, V4.4H, V10.H[0x5]
    FMLS S5, S1, V18.S[0x1]
    FMULX S5, S15, V6.S[0x1]
    UMULL V0.4S, V15.4H, V10.H[0x5]
    MUL  V15.2S, V14.2S, V19.S[0x2]
    FMLA S7, S4, V16.S[0x1]
    FMULX S2, S24, V12.S[0x2]
    FMUL V15.2S, V25.2S, V31.S[0x3]
    SQRDMULH  H25, H22, H12
    UMULL2 V21.4S, V17.8H, V2.H[0x7]
    SQRDMULH S7, S19, V17.S[0x3]
    MUL  V18.2S, V15.2S, V8.S[0x1]
    UMULL2 V13.2D, V9.4S, V6.S[0x1]
    MUL  V21.8H, V5.8H, V5.H[0x4]
    FMLS V16.2D, V18.2D, V2.D[0x1]
    SQRDMULH  V13.2S, V3.2S, V16.S[0x2]
    FMULX D11, D9, V18.D[0x1]
    MLA  V5.8H, V20.8H, V7.H[0x7]
    FMULX V31.2D, V7.2D, V0.D[0x0]
    MUL  V19.4S, V30.4S, V24.S[0x1]
    SQRDMULH H5, H19, V9.H[0x3]
    FMUL D25, D12, V4.D[0x1]
    SQRDMULH  V17.4S, V17.4S, V13.S[0x0]
    SQRDMULH  S7, S25, S31
    UMULL2 V14.4S, V8.8H, V12.H[0x6]
    SQRDMULH  H13, H12, H28
    MUL  V21.4S, V28.4S, V3.S[0x0]
    FMUL D10, D21, V20.D[0x1]
    SQRDMULH H2, H3, V10.H[0x6]
    FMULX D24, D5, V3.D[0x0]
    UMULL2 V11.2D, V7.4S, V10.S[0x1]
    SQRDMULH  V11.4H, V24.4H, V1.H[0x6]
    MUL  V23.4H, V1.4H, V9.H[0x1]
    FMLS V14.2D, V9.2D, V2.D[0x0]
    MUL  V7.2S, V17.2S, V23.S[0x0]
    SQRDMULH  H14, H7, H31
    SQRDMULH  V27.2S, V11.2S, V19.2S
    MLS  V12.8H, V1.8H, V14.H[0x4]
    FMUL S17, S11, V14.S[0x3]
    MLS  V13.4S, V13.4S, V27.S[0x3]
    UMULL2 V29.4S, V16.8H, V1.H[0x4]
    MLS  V13.4H, V8.4H, V0.H[0x0]
    SQRDMULH  H9, H17, H29
    FMLA V28.4S, V14.4S, V0.S[0x2]
    FMLS V14.2D, V2.2D, V9.D[0x0]
    FMUL D7, D15, V18.D[0x0]
    UMULL2 V12.2D, V4.4S, V20.S[0x0]
    FMUL V23.2D, V27.2D, V21.D[0x1]
    FMLS D1, D1, V1.D[0x0]
    MLA  V9.4H, V19.4H, V11.H[0x6]
    FMLA V17.2D, V0.2D, V10.D[0x1]
    FMUL V3.4S, V14.4S, V13.S[0x3]
    FMLA D26, D24, V3.D[0x1]
    SQRDMULH H9, H1, V5.H[0x2]
    MUL  V1.4H, V29.4H, V14.H[0x0]
    FMULX V12.4S, V3.4S, V0.S[0x0]
    SQRDMULH  H12, H2, H23
    FMULX V13.2S, V4.2S, V4.S[0x0]
    FMULX V21.2D, V13.2D, V23.D[0x1]
    FMLS S4, S21, V26.S[0x0]
    SQRDMULH  V17.4S, V1.4S, V24.S[0x1]
    FMLS D12, D25, V26.D[0x1]
    SQRDMULH H11, H17, V9.H[0x6]
    FMLA V11.2S, V31.2S, V12.S[0x2]
    SQRDMULH  V27.4S, V7.4S, V9.4S
    SQRDMULH S7, S4, V1.S[0x1]
    FMLA V11.4S, V7.4S, V24.S[0x1]
    SQRDMULH  H1, H3, H1
    FMLA S20, S27, V1.S[0x1]
    SQRDMULH  V5.2S, V16.2S, V3.S[0x0]
    UMULL2 V11.2D, V29.4S, V16.S[0x0]
    MLS  V13.4H, V30.4H, V11.H[0x6]
    MLS  V27.2S, V5.2S, V3.S[0x1]
    SQRDMULH H11, H20, V0.H[0x2]
    MLS  V20.4H, V3.4H, V15.H[0x1]
    MLA  V20.2S, V14.2S, V2.S[0x0]
    MUL  V15.8H, V20.8H, V11.H[0x7]
    SQRDMULH H7, H17, V4.H[0x6]
    FMULX S3, S24, V31.S[0x3]
    UMULL V24.2D, V10.2S, V24.S[0x0]
    FMLS V2.4S, V3.4S, V14.S[0x0]
    UMULL V11.2D, V27.2S, V2.S[0x3]
    FMULX V13.2S, V30.2S, V2.S[0x0]
    FMUL V19.2D, V24.2D, V3.D[0x0]
    FMUL S21, S19, V3.S[0x0]
    SQRDMULH H23, H21, V2.H[0x0]
    MLA  V13.8H, V1.8H, V0.H[0x4]
    SQRDMULH  H27, H9, H2
    MUL  V17.4S, V8.4S, V4.S[0x1]
    MLA  V24.8H, V27.8H, V1.H[0x7]
    SQRDMULH  S11, S28, S29
    SQRDMULH  V19.4H, V22.4H, V0.H[0x6]
    FMLS V23.2D, V7.2D, V7.D[0x0]
    SQRDMULH  S29, S29, S7
    MLA  V29.2S, V22.2S, V17.S[0x1]
    SQRDMULH  H14, H7, H6
    FMLA D30, D5, V22.D[0x1]
    MLS  V25.4H, V12.4H, V13.H[0x1]
    FMLS V31.2S, V26.2S, V2.S[0x1]
    SQRDMULH  H14, H8, H25
    FMULX D8, D3, V26.D[0x0]
    MLS  V21.8H, V8.8H, V5.H[0x2]
    SQRDMULH  V29.4H, V22.4H, V26.4H
    FMLS V1.4S, V9.4S, V5.S[0x1]
    SUBS  X28, X28, #0x1
    B.NE  TaishanSimdWideNarryArthemticP01_label_825
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X12, X9, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X7, X26, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X7
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X12, X11, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X9
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X11
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X28, X13, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X15
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X5, X20, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X10, X3, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X28, X3, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, V2.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x8000, LSL #48
    SUB  X17, X15, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, D2
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x8000, LSL #48
    SUB  X17, X15, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, D4
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x8000, LSL #16
    SUB  X18, X17, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, V5.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, D5
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, D6
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X3, X18, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, D7
    MOVZ  X18, #0x0, LSL #0
    SUB  X3, X18, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, D8
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x8000, LSL #48
    SUB  X29, X6, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X17, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X17, D9
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, V10.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, D10
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, D11
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V12.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X18, X23, X29
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D12
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x8000, LSL #48
    SUB  X18, X23, X29
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X14, X28, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D13
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8000, LSL #16
    MOVK  X28, #0x8000, LSL #48
    SUB  X14, X28, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, D14
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, V15.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, D15
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x8000, LSL #48
    SUB  X29, X10, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, D16
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x8000, LSL #48
    SUB  X29, X10, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, D17
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, V18.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, D18
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, D19
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, D20
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, D21
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X17, D22
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8000, LSL #48
    SUB  X5, X13, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x8000, LSL #48
    SUB  X15, X5, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, D23
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x8000, LSL #48
    SUB  X15, X5, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D24
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X10
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, D26
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x8000, LSL #48
    SUB  X17, X2, X10
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, D27
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D28
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x8000, LSL #48
    SUB  X8, X27, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X4, X20, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, D29
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fff, LSL #48
    SUB  X4, X20, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
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
    FMOV  V0.D[1], X24
    FMOV  D1, X28
    FMOV  V1.D[1], X23
    FMOV  D2, X27
    FMOV  V2.D[1], X29
    FMOV  D3, X14
    FMOV  V3.D[1], X18
    FMOV  D4, X7
    FMOV  V4.D[1], X17
    FMOV  D5, X22
    FMOV  V5.D[1], X3
    FMOV  D6, X2
    FMOV  V6.D[1], X4
    FMOV  D7, X16
    FMOV  V7.D[1], X4
    FMOV  D8, X2
    FMOV  V8.D[1], X9
    FMOV  D9, X24
    FMOV  V9.D[1], X23
    FMOV  D10, X7
    FMOV  V10.D[1], X3
    FMOV  D11, X13
    FMOV  V11.D[1], X7
    FMOV  D12, X3
    FMOV  V12.D[1], X24
    FMOV  D13, X4
    FMOV  V13.D[1], X27
    FMOV  D14, X11
    FMOV  V14.D[1], X28
    FMOV  D15, X9
    FMOV  V15.D[1], X3
    FMOV  D16, X13
    FMOV  V16.D[1], X2
    FMOV  D17, X18
    FMOV  V17.D[1], X23
    FMOV  D18, X4
    FMOV  V18.D[1], X3
    FMOV  D19, X28
    FMOV  V19.D[1], X17
    FMOV  D20, X27
    FMOV  V20.D[1], X18
    FMOV  D21, X21
    FMOV  V21.D[1], X19
    FMOV  D22, X2
    FMOV  V22.D[1], X28
    FMOV  D23, X28
    FMOV  V23.D[1], X22
TaishanSimdWideNarryArthemticP01_label_808:
    FMOV  D24, X2
    FMOV  V24.D[1], X26
    FMOV  D25, X22
    FMOV  V25.D[1], X22
    FMOV  D26, X21
    FMOV  V26.D[1], X12
    FMOV  D27, X3
    FMOV  V27.D[1], X12
    FMOV  D28, X23
    FMOV  V28.D[1], X16
    FMOV  D29, X2
    FMOV  V29.D[1], X17
    FMOV  D30, X5
    FMOV  V30.D[1], X28
    FMOV  D31, X3
    FMOV  V31.D[1], X29
    MOVZ  X4, #0xf, LSL #0
TaishanSimdWideNarryArthemticP01_label_907:
    FMLA S20, S1, V18.S[0x2]
    MLA  V29.2S, V20.2S, V28.S[0x2]
    MUL  V15.4H, V25.4H, V9.H[0x5]
    SQRDMULH  V9.4S, V0.4S, V7.4S
    MLA  V13.8H, V23.8H, V3.H[0x1]
    SQRDMULH  V24.8H, V30.8H, V15.H[0x4]
    MUL  V22.8H, V14.8H, V9.H[0x1]
    FMULX D17, D18, V3.D[0x0]
    SQRDMULH  V16.2S, V15.2S, V11.S[0x0]
    SQRDMULH  H14, H17, H30
    SQRDMULH  V15.8H, V13.8H, V7.H[0x7]
    MLS  V19.2S, V5.2S, V12.S[0x1]
    MLS  V19.8H, V14.8H, V12.H[0x7]
    FMUL D3, D29, V9.D[0x1]
    FMLA V14.2D, V3.2D, V9.D[0x1]
    FMULX D13, D18, V26.D[0x1]
    SQRDMULH H29, H23, V11.H[0x1]
    FMLS V19.2D, V18.2D, V8.D[0x0]
    FMLA V18.2D, V26.2D, V13.D[0x0]
    FMLA V17.2D, V19.2D, V18.D[0x0]
    SQRDMULH  V5.2S, V30.2S, V20.S[0x2]
    SQRDMULH  V15.8H, V15.8H, V3.H[0x3]
    FMULX D27, D5, V12.D[0x1]
    UMULL2 V24.2D, V5.4S, V27.S[0x3]
    MLS  V2.4S, V31.4S, V15.S[0x3]
    FMUL S27, S11, V12.S[0x3]
    FMLA V4.2S, V8.2S, V5.S[0x1]
    SQRDMULH  V20.2S, V2.2S, V16.S[0x3]
    FMLS D2, D21, V7.D[0x0]
    MLA  V19.2S, V21.2S, V3.S[0x2]
    FMUL V11.4S, V17.4S, V23.S[0x1]
    MLS  V19.4S, V11.4S, V30.S[0x3]
    FMLS D6, D20, V15.D[0x0]
    FMLA D1, D14, V2.D[0x0]
    SQRDMULH  V31.8H, V11.8H, V2.8H
    FMUL S15, S4, V16.S[0x1]
    UMULL2 V27.4S, V8.8H, V15.H[0x5]
    FMLS S30, S7, V6.S[0x2]
    FMUL V18.2D, V19.2D, V12.D[0x0]
    FMLS D9, D22, V13.D[0x1]
    MUL  V3.4H, V0.4H, V8.H[0x3]
    SQRDMULH  H4, H7, H24
    FMUL S26, S6, V1.S[0x0]
    UMULL V14.2D, V16.2S, V18.S[0x2]
    FMLA V1.2D, V11.2D, V16.D[0x1]
    FMUL S4, S30, V30.S[0x3]
    FMUL S18, S7, V18.S[0x2]
    UMULL2 V14.2D, V18.4S, V27.S[0x1]
    FMUL V10.2S, V8.2S, V20.S[0x2]
    FMLS V9.2S, V15.2S, V0.S[0x3]
    FMLS S17, S6, V14.S[0x0]
    UMULL V18.2D, V8.2S, V28.S[0x0]
    UMULL2 V11.2D, V21.4S, V22.S[0x0]
    UMULL V31.4S, V15.4H, V9.H[0x7]
    FMULX V2.2S, V15.2S, V20.S[0x2]
    FMULX V2.2D, V11.2D, V3.D[0x1]
    SQRDMULH H8, H16, V1.H[0x7]
    FMLA V6.4S, V19.4S, V2.S[0x1]
    FMLA V3.2D, V4.2D, V31.D[0x1]
    FMULX D2, D29, V19.D[0x0]
    SQRDMULH  S6, S21, S15
    MUL  V22.8H, V9.8H, V3.H[0x5]
    FMLA D6, D23, V6.D[0x0]
    FMLS V21.2S, V19.2S, V13.S[0x1]
    UMULL V29.4S, V2.4H, V10.H[0x5]
    FMULX D11, D24, V26.D[0x0]
    SQRDMULH  H19, H25, H2
    FMUL D19, D28, V14.D[0x0]
    UMULL2 V2.2D, V22.4S, V13.S[0x0]
    FMLS S2, S12, V11.S[0x0]
    SQRDMULH  V15.4H, V23.4H, V18.4H
    FMLS S17, S6, V4.S[0x1]
    FMLA V12.2D, V29.2D, V3.D[0x0]
    FMULX D13, D18, V8.D[0x1]
    FMLS S27, S0, V7.S[0x1]
    FMULX V12.2D, V28.2D, V16.D[0x1]
    SQRDMULH S5, S18, V12.S[0x2]
    FMUL V27.4S, V22.4S, V20.S[0x0]
    FMLS V24.4S, V6.4S, V21.S[0x3]
    FMLS V19.2D, V18.2D, V29.D[0x1]
    FMLA V31.4S, V5.4S, V18.S[0x1]
    MUL  V7.4H, V27.4H, V8.H[0x3]
    FMLS V27.2S, V16.2S, V18.S[0x2]
    FMLA D9, D18, V3.D[0x1]
    MLS  V0.4H, V9.4H, V4.H[0x1]
    SQRDMULH  V20.2S, V17.2S, V18.S[0x0]
    SQRDMULH  V28.4S, V20.4S, V1.S[0x3]
    MLA  V2.4S, V5.4S, V8.S[0x1]
    SQRDMULH  V11.4S, V17.4S, V23.S[0x2]
    FMULX V28.2D, V8.2D, V16.D[0x0]
    FMULX S17, S22, V12.S[0x0]
    SQRDMULH  V25.4S, V0.4S, V17.S[0x2]
    FMLS S12, S2, V31.S[0x1]
    SQRDMULH  H28, H12, H27
    FMLS D28, D15, V0.D[0x1]
    FMLA V17.2D, V26.2D, V8.D[0x0]
    SQRDMULH S31, S13, V1.S[0x0]
    SQRDMULH  V18.2S, V19.2S, V9.S[0x3]
    UMULL2 V15.4S, V23.8H, V3.H[0x0]
    MUL  V11.8H, V11.8H, V0.H[0x3]
    FMLA V27.4S, V25.4S, V26.S[0x1]
    UMULL2 V13.2D, V2.4S, V13.S[0x0]
    MLS  V16.4S, V11.4S, V19.S[0x0]
    FMULX V12.2D, V5.2D, V5.D[0x0]
    SQRDMULH  V0.8H, V20.8H, V12.H[0x6]
    SQRDMULH  H28, H11, H30
    FMULX V2.4S, V12.4S, V4.S[0x0]
    FMLS V5.2D, V2.2D, V24.D[0x0]
    UMULL2 V3.4S, V21.8H, V7.H[0x1]
    SQRDMULH  V10.2S, V31.2S, V28.S[0x1]
    FMUL V20.2D, V17.2D, V16.D[0x0]
    UMULL V22.4S, V8.4H, V3.H[0x5]
    SQRDMULH  S4, S18, S23
    FMULX D14, D14, V10.D[0x1]
    FMUL V15.4S, V20.4S, V19.S[0x3]
    MLA  V29.2S, V21.2S, V13.S[0x0]
    FMLS S5, S21, V17.S[0x2]
    FMUL V19.2S, V1.2S, V27.S[0x1]
    UMULL V5.2D, V14.2S, V2.S[0x2]
    FMUL D15, D6, V24.D[0x1]
    UMULL2 V13.4S, V21.8H, V7.H[0x3]
    UMULL2 V22.4S, V10.8H, V13.H[0x5]
    MUL  V31.8H, V19.8H, V13.H[0x3]
    FMLS V9.2D, V29.2D, V29.D[0x1]
    SQRDMULH  H29, H8, H12
    FMLA D4, D19, V29.D[0x0]
    SQRDMULH  S4, S4, S19
    FMLS S28, S28, V19.S[0x2]
    MUL  V16.4H, V0.4H, V13.H[0x6]
    SQRDMULH  V25.4H, V27.4H, V3.H[0x6]
    UMULL2 V31.4S, V9.8H, V0.H[0x5]
    FMLA V5.2D, V5.2D, V6.D[0x1]
    FMUL V27.4S, V29.4S, V27.S[0x3]
    FMLA D13, D29, V19.D[0x1]
    FMLA V18.4S, V16.4S, V2.S[0x3]
    SQRDMULH H14, H13, V2.H[0x3]
    FMUL V6.2S, V4.2S, V28.S[0x3]
    FMULX V5.2D, V9.2D, V13.D[0x0]
    FMULX S31, S20, V30.S[0x2]
    FMUL V31.2D, V24.2D, V1.D[0x1]
    UMULL2 V7.4S, V20.8H, V13.H[0x0]
    SQRDMULH S29, S2, V18.S[0x2]
    FMLA S6, S12, V29.S[0x0]
    FMULX D27, D29, V19.D[0x1]
    FMUL D25, D15, V31.D[0x1]
    FMULX V14.2S, V12.2S, V25.S[0x2]
TaishanSimdWideNarryArthemticP01_label_745:
    MLS  V24.4H, V26.4H, V5.H[0x6]
    FMLS S21, S9, V7.S[0x2]
    SQRDMULH H12, H27, V4.H[0x5]
    SQRDMULH  V4.4H, V0.4H, V11.4H
    FMULX V14.2D, V20.2D, V14.D[0x0]
    SQRDMULH  V16.4S, V6.4S, V3.4S
    FMLA D11, D21, V15.D[0x1]
    SQRDMULH  V1.4H, V16.4H, V11.H[0x0]
    FMUL S2, S13, V16.S[0x2]
    FMLA V0.4S, V21.4S, V12.S[0x3]
    SQRDMULH  S0, S14, S29
    SQRDMULH  S1, S7, S2
    MLS  V7.4H, V7.4H, V15.H[0x7]
    FMLS V13.2S, V2.2S, V25.S[0x2]
    FMLS V1.4S, V23.4S, V11.S[0x2]
    FMLA D2, D7, V28.D[0x0]
    FMLS V23.2S, V16.2S, V19.S[0x2]
    FMULX S0, S10, V1.S[0x2]
    UMULL V27.4S, V11.4H, V4.H[0x0]
    MLA  V16.2S, V23.2S, V21.S[0x3]
    MLA  V9.8H, V1.8H, V13.H[0x3]
    MUL  V3.4S, V23.4S, V24.S[0x1]
    FMLA S9, S15, V28.S[0x0]
    SQRDMULH  V0.2S, V17.2S, V15.S[0x3]
    FMUL D8, D10, V17.D[0x1]
    FMULX D8, D0, V3.D[0x1]
    FMLS S23, S16, V22.S[0x3]
    SQRDMULH  V26.2S, V4.2S, V28.2S
    UMULL2 V10.2D, V23.4S, V14.S[0x0]
    SQRDMULH S23, S17, V10.S[0x2]
    SQRDMULH  V31.2S, V19.2S, V10.2S
    MLS  V9.2S, V19.2S, V27.S[0x0]
    FMLA S26, S2, V12.S[0x1]
    FMULX V7.2S, V28.2S, V14.S[0x2]
    SQRDMULH  H27, H22, H5
    UMULL2 V10.2D, V29.4S, V12.S[0x1]
    SQRDMULH  V14.4S, V11.4S, V14.S[0x3]
    FMUL D14, D25, V14.D[0x0]
    UMULL2 V9.2D, V24.4S, V16.S[0x3]
    SQRDMULH  H18, H28, H30
    MLA  V29.2S, V13.2S, V0.S[0x1]
    FMLA V14.2D, V26.2D, V4.D[0x1]
    MLS  V24.2S, V17.2S, V11.S[0x1]
    FMULX S23, S3, V0.S[0x3]
    FMLS S5, S10, V9.S[0x1]
    SQRDMULH  S7, S14, S31
    UMULL2 V21.4S, V29.8H, V4.H[0x6]
    UMULL2 V24.4S, V29.8H, V3.H[0x6]
    FMLS V8.2D, V13.2D, V25.D[0x0]
    FMLS V12.2D, V1.2D, V3.D[0x0]
    SQRDMULH  V0.4H, V29.4H, V28.4H
    MLS  V8.4H, V28.4H, V7.H[0x1]
    SQRDMULH  V12.4H, V6.4H, V5.H[0x6]
    UMULL V3.4S, V0.4H, V8.H[0x3]
    SUBS  X4, X4, #0x1
    B.NE  TaishanSimdWideNarryArthemticP01_label_907
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X2, X9, X2
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X23, X15, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X4
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X29, X10, X5
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X20, X14, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X7, X23, X7
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X21, X26, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X4, X27, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X14, X21, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X18, X16, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X5, X24, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X29, X14, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X15, X9, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X15
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X20, X19, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X11, X10, X17
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X26, X28, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X13, X8, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X17, X12, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X28, X14, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X6, X15, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, D2
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, D3
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, D4
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, D5
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x8000, LSL #16
    SUB  X10, X23, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, V6.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X19
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, D6
    MOVZ  X14, #0xfffe, LSL #0
    MOVK  X14, #0x7fff, LSL #16
    SUB  X29, X14, X19
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X27, X19, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X17, D7
    MOVZ  X19, #0x0, LSL #0
    SUB  X27, X19, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, D8
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X18, X4, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, D9
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, V10.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X13, X3, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, D10
    MOVZ  X3, #0x0, LSL #0
    SUB  X13, X3, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, D11
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, D12
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, V13.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X20, X17, X21
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, D13
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x8000, LSL #16
    MOVK  X17, #0x8000, LSL #48
    SUB  X20, X17, X21
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D14
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X9, X7, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D15
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x8000, LSL #48
    SUB  X2, X6, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X19, X11, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, D16
    MOVZ  X11, #0x0, LSL #0
    SUB  X19, X11, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, D17
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, D18
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, D19
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0x7fff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0x7fff, LSL #48
    SUB  X11, X7, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, D20
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, D21
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, D22
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D23
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, D24
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X9, X17, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, D26
    MOVZ  X17, #0x0, LSL #0
    SUB  X9, X17, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X7
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, D27
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X7
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, D28
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #16
    SUB  X12, X16, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, D29
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X2, #0xd0f8, LSL #0
    MOVK  X2, #0xb82f, LSL #16
    MOVK  X2, #0x9b3f, LSL #32
    MOVK  X2, #0x5da4, LSL #48
    MOVZ  X3, #0xe45, LSL #0
    MOVK  X3, #0xfdf2, LSL #16
    MOVK  X3, #0xace5, LSL #32
    MOVK  X3, #0x69d7, LSL #48
    MOVZ  X4, #0x3ef1, LSL #0
    MOVK  X4, #0xe5ef, LSL #16
    MOVK  X4, #0x847, LSL #32
    MOVK  X4, #0x955a, LSL #48
    MOVZ  X5, #0xf69c, LSL #0
    MOVK  X5, #0x7e49, LSL #16
    MOVK  X5, #0xf710, LSL #32
    MOVK  X5, #0x8bc5, LSL #48
    MOVZ  X6, #0xcc11, LSL #0
    MOVK  X6, #0xd4cf, LSL #16
    MOVK  X6, #0x1e42, LSL #32
    MOVK  X6, #0xe829, LSL #48
    MOVZ  X7, #0xf6a7, LSL #0
    MOVK  X7, #0x8da9, LSL #16
    MOVK  X7, #0xbba5, LSL #32
    MOVK  X7, #0xe354, LSL #48
    MOVZ  X8, #0x8f6a, LSL #0
    MOVK  X8, #0x6fbb, LSL #16
    MOVK  X8, #0xf3f3, LSL #32
    MOVK  X8, #0x135e, LSL #48
    MOVZ  X9, #0xe998, LSL #0
    MOVK  X9, #0xa88b, LSL #16
    MOVK  X9, #0x3293, LSL #32
    MOVK  X9, #0xb8f4, LSL #48
    MOVZ  X10, #0x5236, LSL #0
    MOVK  X10, #0x9a30, LSL #16
    MOVK  X10, #0xea98, LSL #32
    MOVK  X10, #0x70f5, LSL #48
    MOVZ  X11, #0x7868, LSL #0
    MOVK  X11, #0x843, LSL #16
    MOVK  X11, #0x6a0f, LSL #32
    MOVK  X11, #0x1381, LSL #48
    MOVZ  X12, #0x8c55, LSL #0
    MOVK  X12, #0xd73a, LSL #16
    MOVK  X12, #0x38a4, LSL #32
    MOVK  X12, #0xffd, LSL #48
    MOVZ  X13, #0xde48, LSL #0
    MOVK  X13, #0x1f7b, LSL #16
    MOVK  X13, #0xa31f, LSL #32
    MOVK  X13, #0x3f73, LSL #48
    MOVZ  X14, #0x3b37, LSL #0
    MOVK  X14, #0x42c3, LSL #16
    MOVK  X14, #0xaaf, LSL #32
    MOVK  X14, #0xe8d1, LSL #48
    MOVZ  X15, #0x707e, LSL #0
    MOVK  X15, #0x85dd, LSL #16
    MOVK  X15, #0x254d, LSL #32
    MOVK  X15, #0x6eb1, LSL #48
    MOVZ  X16, #0xa04f, LSL #0
    MOVK  X16, #0xed97, LSL #16
    MOVK  X16, #0xc613, LSL #32
    MOVK  X16, #0xfb6e, LSL #48
    MOVZ  X17, #0xc4d2, LSL #0
    MOVK  X17, #0x1776, LSL #16
    MOVK  X17, #0x757c, LSL #32
    MOVK  X17, #0xadeb, LSL #48
    MOVZ  X18, #0xb9bb, LSL #0
    MOVK  X18, #0x4109, LSL #16
    MOVK  X18, #0xa045, LSL #32
    MOVK  X18, #0xf1f5, LSL #48
    MOVZ  X19, #0x4004, LSL #0
    MOVK  X19, #0xe384, LSL #16
    MOVK  X19, #0xb03e, LSL #32
    MOVK  X19, #0x62e3, LSL #48
    MOVZ  X20, #0xbdd0, LSL #0
    MOVK  X20, #0x871f, LSL #16
    MOVK  X20, #0x2ce6, LSL #32
    MOVK  X20, #0x7b8f, LSL #48
    MOVZ  X21, #0x626e, LSL #0
    MOVK  X21, #0x9875, LSL #16
    MOVK  X21, #0xb724, LSL #32
    MOVK  X21, #0xe87c, LSL #48
    MOVZ  X22, #0x3fee, LSL #0
    MOVK  X22, #0x7c63, LSL #16
    MOVK  X22, #0xf3d, LSL #32
    MOVK  X22, #0xeb67, LSL #48
    MOVZ  X23, #0x360f, LSL #0
    MOVK  X23, #0x7d80, LSL #16
    MOVK  X23, #0xa855, LSL #32
    MOVK  X23, #0x43f2, LSL #48
    MOVZ  X24, #0x4f11, LSL #0
    MOVK  X24, #0x423d, LSL #16
    MOVK  X24, #0xc9fa, LSL #32
    MOVK  X24, #0x414c, LSL #48
    MOVZ  X26, #0xff15, LSL #0
    MOVK  X26, #0xd4, LSL #16
    MOVK  X26, #0x7dd2, LSL #32
    MOVK  X26, #0x6b7c, LSL #48
    MOVZ  X27, #0xe030, LSL #0
    MOVK  X27, #0x94c0, LSL #16
    MOVK  X27, #0xac9f, LSL #32
    MOVK  X27, #0xd71b, LSL #48
    MOVZ  X28, #0x3608, LSL #0
    MOVK  X28, #0x6f00, LSL #16
    MOVK  X28, #0x8279, LSL #32
    MOVK  X28, #0xadee, LSL #48
    MOVZ  X29, #0x8628, LSL #0
    MOVK  X29, #0xc7ac, LSL #16
    MOVK  X29, #0xadf0, LSL #32
    MOVK  X29, #0xee91, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X2
    FMOV  D1, X28
    FMOV  V1.D[1], X7
    FMOV  D2, X14
    FMOV  V2.D[1], X18
    FMOV  D3, X23
    FMOV  V3.D[1], X14
    FMOV  D4, X20
    FMOV  V4.D[1], X9
    FMOV  D5, X17
    FMOV  V5.D[1], X27
    FMOV  D6, X26
    FMOV  V6.D[1], X6
    FMOV  D7, X23
    FMOV  V7.D[1], X8
    FMOV  D8, X14
    FMOV  V8.D[1], X10
    FMOV  D9, X24
    FMOV  V9.D[1], X10
    FMOV  D10, X15
    FMOV  V10.D[1], X8
    FMOV  D11, X29
    FMOV  V11.D[1], X18
    FMOV  D12, X24
    FMOV  V12.D[1], X17
    FMOV  D13, X9
    FMOV  V13.D[1], X18
    FMOV  D14, X14
    FMOV  V14.D[1], X24
    FMOV  D15, X17
    FMOV  V15.D[1], X13
    FMOV  D16, X10
    FMOV  V16.D[1], X9
    FMOV  D17, X28
    FMOV  V17.D[1], X12
    FMOV  D18, X17
    FMOV  V18.D[1], X8
    FMOV  D19, X12
    FMOV  V19.D[1], X16
    FMOV  D20, X4
    FMOV  V20.D[1], X6
    FMOV  D21, X13
    FMOV  V21.D[1], X23
    FMOV  D22, X3
    FMOV  V22.D[1], X10
    FMOV  D23, X11
    FMOV  V23.D[1], X4
    FMOV  D24, X4
    FMOV  V24.D[1], X3
    FMOV  D25, X11
    FMOV  V25.D[1], X24
    FMOV  D26, X5
    FMOV  V26.D[1], X10
    FMOV  D27, X20
    FMOV  V27.D[1], X24
    FMOV  D28, X6
    FMOV  V28.D[1], X6
    FMOV  D29, X8
    FMOV  V29.D[1], X22
    FMOV  D30, X9
    FMOV  V30.D[1], X23
    FMOV  D31, X24
    FMOV  V31.D[1], X5
    MOVZ  X9, #0xa, LSL #0
TaishanSimdWideNarryArthemticP01_label_988:
    MUL  V15.4H, V23.4H, V15.H[0x0]
    UMULL V7.2D, V29.2S, V20.S[0x3]
    FMULX S30, S1, V17.S[0x0]
    SQRDMULH  H22, H30, H20
    FMULX V2.2S, V6.2S, V28.S[0x1]
    FMLS S17, S20, V19.S[0x1]
    SQRDMULH S31, S6, V9.S[0x0]
    MUL  V2.2S, V2.2S, V13.S[0x2]
    SQRDMULH  V10.2S, V14.2S, V19.S[0x1]
    FMLS V16.2D, V15.2D, V24.D[0x0]
    FMLA D13, D27, V29.D[0x1]
    MUL  V22.2S, V13.2S, V23.S[0x2]
    SQRDMULH  V23.4H, V4.4H, V1.H[0x5]
    SQRDMULH  H6, H7, H16
    FMULX V28.4S, V4.4S, V25.S[0x1]
    UMULL V25.4S, V7.4H, V1.H[0x5]
    SQRDMULH  V19.2S, V28.2S, V8.S[0x1]
    UMULL V26.4S, V26.4H, V9.H[0x6]
    FMLA D18, D16, V6.D[0x1]
    FMLS S8, S25, V11.S[0x2]
    SQRDMULH  S10, S29, S4
    FMLS S4, S6, V21.S[0x2]
    SQRDMULH  V10.8H, V1.8H, V0.H[0x2]
    FMLA V26.4S, V20.4S, V3.S[0x1]
    FMLA D15, D26, V11.D[0x0]
    FMLA V30.2S, V28.2S, V25.S[0x3]
    FMUL S13, S23, V31.S[0x1]
    FMLS S15, S29, V15.S[0x1]
    FMLS V14.2D, V0.2D, V8.D[0x1]
    SQRDMULH S4, S23, V31.S[0x2]
    MUL  V3.4S, V0.4S, V6.S[0x1]
    FMULX D31, D10, V14.D[0x0]
    FMLA S28, S20, V23.S[0x3]
    FMULX V19.2D, V3.2D, V11.D[0x1]
    SQRDMULH  H16, H1, H30
    FMLS V16.2D, V18.2D, V22.D[0x0]
    FMUL S0, S4, V8.S[0x3]
    FMLS V25.2D, V15.2D, V9.D[0x1]
    FMLS S7, S15, V22.S[0x1]
    FMLS V13.4S, V9.4S, V11.S[0x3]
    UMULL2 V9.4S, V7.8H, V1.H[0x4]
    FMULX S9, S10, V25.S[0x3]
    FMULX V3.2S, V31.2S, V23.S[0x2]
    FMUL V3.2S, V12.2S, V0.S[0x3]
    FMULX V3.2S, V21.2S, V14.S[0x1]
    FMUL V20.2D, V20.2D, V0.D[0x1]
    SQRDMULH  S20, S17, S20
    FMLA V4.2D, V14.2D, V5.D[0x0]
    FMUL S27, S4, V11.S[0x2]
    FMLA V0.2D, V22.2D, V11.D[0x0]
    FMUL D3, D25, V17.D[0x1]
    MUL  V10.4S, V5.4S, V0.S[0x3]
    UMULL V20.4S, V15.4H, V14.H[0x2]
    SQRDMULH  V8.4S, V20.4S, V20.S[0x2]
    FMLA D9, D22, V14.D[0x0]
    FMUL V4.2D, V20.2D, V4.D[0x0]
    MLA  V29.8H, V19.8H, V3.H[0x1]
    FMULX V23.4S, V13.4S, V13.S[0x3]
    UMULL2 V4.2D, V23.4S, V20.S[0x2]
    UMULL V27.2D, V13.2S, V13.S[0x2]
    UMULL V19.2D, V11.2S, V3.S[0x2]
    SQRDMULH H9, H20, V15.H[0x4]
    SQRDMULH  V20.8H, V12.8H, V21.8H
    MUL  V3.4H, V24.4H, V12.H[0x4]
    FMLA D15, D3, V21.D[0x0]
    MUL  V25.4H, V23.4H, V1.H[0x4]
    FMULX S19, S2, V30.S[0x1]
    UMULL2 V4.2D, V8.4S, V16.S[0x1]
    SQRDMULH  H12, H19, H20
    UMULL V0.2D, V7.2S, V1.S[0x0]
    FMLA V19.2D, V13.2D, V22.D[0x0]
    SQRDMULH  S30, S19, S25
    FMUL S7, S14, V22.S[0x3]
    UMULL V4.4S, V14.4H, V7.H[0x4]
    FMLS V30.2S, V30.2S, V29.S[0x1]
    FMULX V21.4S, V11.4S, V15.S[0x3]
    FMULX S4, S5, V27.S[0x1]
    FMLA V12.2S, V29.2S, V4.S[0x3]
    MLA  V10.4S, V21.4S, V8.S[0x2]
    SQRDMULH  V7.8H, V11.8H, V12.H[0x2]
    SQRDMULH S20, S8, V30.S[0x1]
    MLS  V8.8H, V0.8H, V7.H[0x5]
    FMUL V9.2D, V7.2D, V1.D[0x0]
    FMULX D28, D28, V31.D[0x0]
    MLA  V27.4S, V16.4S, V26.S[0x1]
    FMLS D13, D31, V16.D[0x1]
    UMULL2 V28.2D, V16.4S, V14.S[0x1]
    FMULX D5, D22, V21.D[0x0]
    FMLA S3, S16, V21.S[0x3]
    FMLS D5, D31, V10.D[0x0]
    UMULL V2.4S, V31.4H, V15.H[0x1]
    UMULL V30.4S, V28.4H, V12.H[0x0]
    SQRDMULH  V17.2S, V28.2S, V13.S[0x2]
    FMLA S17, S26, V24.S[0x3]
    UMULL2 V29.4S, V8.8H, V10.H[0x4]
    FMLS D1, D30, V17.D[0x1]
    FMUL S30, S22, V16.S[0x3]
    FMUL V9.2D, V13.2D, V30.D[0x0]
    FMUL D20, D1, V20.D[0x0]
    FMLA D14, D12, V11.D[0x0]
    SQRDMULH  H9, H15, H14
    FMUL D25, D22, V1.D[0x1]
    FMULX V12.2D, V13.2D, V11.D[0x1]
    MLS  V27.2S, V21.2S, V11.S[0x0]
    FMLA D4, D30, V27.D[0x0]
    FMULX V3.2S, V7.2S, V15.S[0x0]
    FMLA S31, S5, V23.S[0x2]
    SQRDMULH  V4.8H, V1.8H, V29.8H
    FMUL S20, S28, V2.S[0x1]
    MLS  V8.2S, V28.2S, V4.S[0x0]
    MLS  V17.4H, V21.4H, V8.H[0x5]
    UMULL2 V1.2D, V21.4S, V19.S[0x0]
    MLA  V9.8H, V10.8H, V9.H[0x6]
    FMULX V4.4S, V29.4S, V10.S[0x0]
    FMUL V24.2D, V10.2D, V9.D[0x1]
    SQRDMULH  V13.8H, V2.8H, V3.H[0x1]
    FMULX V13.2S, V14.2S, V20.S[0x2]
    MLS  V17.2S, V26.2S, V12.S[0x0]
    MLA  V17.8H, V10.8H, V3.H[0x1]
    MLA  V7.4S, V11.4S, V31.S[0x2]
    FMLA S24, S23, V5.S[0x2]
    MUL  V25.2S, V23.2S, V27.S[0x0]
    FMUL V4.2D, V20.2D, V8.D[0x1]
    FMLA S26, S18, V21.S[0x3]
    FMULX D1, D9, V4.D[0x1]
    FMULX V13.2D, V10.2D, V23.D[0x0]
    SQRDMULH S21, S17, V11.S[0x1]
    FMUL V1.2S, V29.2S, V16.S[0x3]
    MLA  V6.8H, V14.8H, V15.H[0x3]
    MLA  V29.2S, V23.2S, V11.S[0x0]
    UMULL2 V26.2D, V7.4S, V9.S[0x2]
    MLA  V26.4H, V16.4H, V15.H[0x7]
    SQRDMULH  S24, S11, S19
    SQRDMULH  V16.4H, V22.4H, V10.4H
    FMUL V14.4S, V3.4S, V9.S[0x3]
    FMUL S26, S27, V31.S[0x0]
    SQRDMULH  H12, H19, H4
    MLA  V16.8H, V21.8H, V10.H[0x3]
    UMULL2 V2.2D, V25.4S, V29.S[0x0]
    SQRDMULH  H29, H24, H6
    FMULX D29, D17, V31.D[0x0]
    FMLA S9, S10, V31.S[0x1]
    FMLA V24.2S, V14.2S, V22.S[0x3]
    FMULX S2, S10, V22.S[0x0]
    SQRDMULH H15, H0, V9.H[0x2]
    FMULX D19, D3, V23.D[0x1]
    MLS  V24.8H, V17.8H, V2.H[0x4]
    SQRDMULH  V17.4S, V25.4S, V30.S[0x2]
    SQRDMULH H12, H5, V1.H[0x4]
    FMUL V14.2D, V29.2D, V11.D[0x0]
    FMLA V15.2D, V15.2D, V8.D[0x1]
    MLS  V8.4H, V14.4H, V8.H[0x0]
    UMULL2 V31.4S, V21.8H, V6.H[0x1]
    FMLS V28.2D, V19.2D, V28.D[0x0]
    FMULX S10, S10, V7.S[0x0]
    SQRDMULH S0, S30, V0.S[0x3]
    FMLS D2, D17, V22.D[0x0]
    FMLA V0.4S, V21.4S, V22.S[0x0]
    MLS  V17.4H, V28.4H, V4.H[0x0]
    FMLS D3, D15, V17.D[0x0]
    FMULX V11.4S, V11.4S, V20.S[0x3]
    SQRDMULH  S23, S23, S22
    FMLA D13, D20, V25.D[0x0]
    FMUL V16.4S, V0.4S, V8.S[0x2]
    FMLA V29.2S, V8.2S, V24.S[0x3]
    FMULX V27.4S, V30.4S, V2.S[0x1]
    FMLS V6.2D, V22.2D, V22.D[0x1]
    FMLS V17.2D, V31.2D, V17.D[0x0]
    SQRDMULH S5, S0, V13.S[0x2]
    FMULX V24.2S, V27.2S, V21.S[0x3]
    FMLA V4.4S, V13.4S, V22.S[0x0]
    MUL  V12.4S, V13.4S, V23.S[0x0]
    SQRDMULH  V27.8H, V0.8H, V7.8H
    SQRDMULH  S30, S13, S19
    UMULL V9.2D, V2.2S, V20.S[0x2]
    SQRDMULH  V1.4S, V2.4S, V12.4S
    FMLA V4.2D, V4.2D, V22.D[0x0]
    MUL  V25.8H, V16.8H, V3.H[0x4]
    FMULX S9, S1, V14.S[0x0]
    UMULL V31.4S, V2.4H, V13.H[0x0]
    SQRDMULH H10, H31, V10.H[0x5]
    FMLA V6.2D, V10.2D, V0.D[0x1]
    MUL  V26.4H, V11.4H, V3.H[0x3]
    SQRDMULH  S6, S17, S27
    UMULL2 V0.4S, V12.8H, V10.H[0x2]
    FMLS D10, D5, V11.D[0x0]
    FMULX V23.2D, V13.2D, V12.D[0x0]
    FMULX V25.2D, V12.2D, V28.D[0x0]
    FMULX V20.4S, V4.4S, V24.S[0x3]
    FMULX V9.2D, V10.2D, V21.D[0x0]
    UMULL V13.4S, V8.4H, V14.H[0x4]
    MLS  V0.2S, V3.2S, V2.S[0x2]
    MLS  V12.8H, V9.8H, V11.H[0x6]
    MLA  V19.4S, V1.4S, V12.S[0x0]
    MUL  V9.2S, V21.2S, V19.S[0x2]
    SQRDMULH  V27.2S, V12.2S, V24.2S
    SQRDMULH  H30, H5, H20
    MLS  V19.8H, V28.8H, V7.H[0x0]
    MUL  V16.8H, V21.8H, V9.H[0x1]
    SQRDMULH H6, H22, V1.H[0x7]
    SUBS  X9, X9, #0x1
    B.NE  TaishanSimdWideNarryArthemticP01_label_988
    MOVZ  X12, #0xd0f8, LSL #0
    MOVK  X12, #0xb82f, LSL #16
    MOVK  X12, #0x9b3f, LSL #32
    MOVK  X12, #0x5da4, LSL #48
    SUB  X13, X12, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X13, #0xe45, LSL #0
    MOVK  X13, #0xfdf2, LSL #16
    MOVK  X13, #0xace5, LSL #32
    MOVK  X13, #0x69d7, LSL #48
    SUB  X20, X13, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X17, #0x3ef1, LSL #0
    MOVK  X17, #0xe5ef, LSL #16
    MOVK  X17, #0x847, LSL #32
    MOVK  X17, #0x955a, LSL #48
    SUB  X16, X17, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X13, #0xf69c, LSL #0
    MOVK  X13, #0x7e49, LSL #16
    MOVK  X13, #0xf710, LSL #32
    MOVK  X13, #0x8bc5, LSL #48
    SUB  X5, X13, X5
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X7, #0xcc11, LSL #0
    MOVK  X7, #0xd4cf, LSL #16
    MOVK  X7, #0x1e42, LSL #32
    MOVK  X7, #0xe829, LSL #48
    SUB  X28, X7, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X13, #0xcc11, LSL #0
    MOVK  X13, #0xd4cf, LSL #16
    MOVK  X13, #0x1e42, LSL #32
    MOVK  X13, #0xe829, LSL #48
    SUB  X28, X13, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X2, #0x8f6a, LSL #0
    MOVK  X2, #0x6fbb, LSL #16
    MOVK  X2, #0xf3f3, LSL #32
    MOVK  X2, #0x135e, LSL #48
    SUB  X22, X2, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X23, #0x5236, LSL #0
    MOVK  X23, #0x9a30, LSL #16
    MOVK  X23, #0xea98, LSL #32
    MOVK  X23, #0x70f5, LSL #48
    SUB  X5, X23, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X11, #0x7868, LSL #0
    MOVK  X11, #0x843, LSL #16
    MOVK  X11, #0x6a0f, LSL #32
    MOVK  X11, #0x1381, LSL #48
    SUB  X15, X11, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X10, #0xd0f8, LSL #0
    MOVK  X10, #0xb82f, LSL #16
    MOVK  X10, #0x9b3f, LSL #32
    MOVK  X10, #0x5da4, LSL #48
    SUB  X15, X10, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X4, #0xcc11, LSL #0
    MOVK  X4, #0xd4cf, LSL #16
    MOVK  X4, #0x1e42, LSL #32
    MOVK  X4, #0xe829, LSL #48
    SUB  X22, X4, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X3, #0x3b37, LSL #0
    MOVK  X3, #0x42c3, LSL #16
    MOVK  X3, #0xaaf, LSL #32
    MOVK  X3, #0xe8d1, LSL #48
    SUB  X24, X3, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X13, X12, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X13, #0x3ef1, LSL #0
    MOVK  X13, #0xe5ef, LSL #16
    MOVK  X13, #0x847, LSL #32
    MOVK  X13, #0x955a, LSL #48
    SUB  X6, X13, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X7, #0xb9bb, LSL #0
    MOVK  X7, #0x4109, LSL #16
    MOVK  X7, #0xa045, LSL #32
    MOVK  X7, #0xf1f5, LSL #48
    SUB  X6, X7, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X26, #0x4004, LSL #0
    MOVK  X26, #0xe384, LSL #16
TaishanSimdWideNarryArthemticP01_label_665:
    MOVK  X26, #0xb03e, LSL #32
    MOVK  X26, #0x62e3, LSL #48
    SUB  X16, X26, X19
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X4, X6, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X26, #0x626e, LSL #0
    MOVK  X26, #0x9875, LSL #16
    MOVK  X26, #0xb724, LSL #32
    MOVK  X26, #0xe87c, LSL #48
    SUB  X13, X26, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X26, #0x5236, LSL #0
    MOVK  X26, #0x9a30, LSL #16
    MOVK  X26, #0xea98, LSL #32
    MOVK  X26, #0x70f5, LSL #48
    SUB  X27, X26, X23
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X3, X16, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X2, #0x5236, LSL #0
    MOVK  X2, #0x9a30, LSL #16
    MOVK  X2, #0xea98, LSL #32
    MOVK  X2, #0x70f5, LSL #48
    SUB  X5, X2, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X27, #0x8628, LSL #0
    MOVK  X27, #0xc7ac, LSL #16
    MOVK  X27, #0xadf0, LSL #32
    MOVK  X27, #0xee91, LSL #48
    SUB  X8, X27, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, D2
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8000, LSL #48
    SUB  X6, X28, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D3
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x8000, LSL #16
    MOVK  X29, #0x8000, LSL #48
    SUB  X22, X29, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X13, X24, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D4
    MOVZ  X24, #0x0, LSL #0
    SUB  X13, X24, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V5.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D5
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, V6.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X22, X17, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, D6
    MOVZ  X17, #0x0, LSL #0
    SUB  X22, X17, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D7
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X5, X20, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X6, D8
    MOVZ  X20, #0x0, LSL #0
    SUB  X5, X20, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, V9.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, D9
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D10
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x8000, LSL #48
    SUB  X24, X9, X4
TaishanSimdWideNarryArthemticP01_label_111:
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, D11
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x8000, LSL #16
    MOVK  X9, #0x8000, LSL #48
    SUB  X24, X9, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, V12.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, D12
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, D13
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #48
    SUB  X22, X4, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, D14
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #48
    SUB  X22, X4, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, V15.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X7, X26, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, D15
    MOVZ  X26, #0x0, LSL #0
    SUB  X7, X26, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, D16
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #48
    SUB  X10, X15, X19
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, D17
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #48
    SUB  X10, X15, X19
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, D18
    MOVZ  X8, #0xc4d2, LSL #0
    MOVK  X8, #0x1776, LSL #16
    MOVK  X8, #0x757c, LSL #32
    MOVK  X8, #0xadeb, LSL #48
    SUB  X13, X8, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X21
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, D19
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x8000, LSL #48
    SUB  X15, X7, X21
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, V20.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, D20
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X12, X10, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, D21
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x7fff, LSL #16
    SUB  X12, X10, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, D22
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, D23
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X3, X18, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, D24
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x8000, LSL #48
    SUB  X3, X18, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, D26
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, V27.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, D27
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x4000, LSL #48
    SUB  X11, X7, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, D28
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, V29.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, D29
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
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
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X10
    FMOV  V0.D[1], X11
    FMOV  D1, X20
    FMOV  V1.D[1], X19
    FMOV  D2, X7
    FMOV  V2.D[1], X5
    FMOV  D3, X21
    FMOV  V3.D[1], X17
    FMOV  D4, X29
    FMOV  V4.D[1], X18
    FMOV  D5, X18
    FMOV  V5.D[1], X28
    FMOV  D6, X14
    FMOV  V6.D[1], X20
    FMOV  D7, X28
    FMOV  V7.D[1], X23
    FMOV  D8, X9
    FMOV  V8.D[1], X9
    FMOV  D9, X21
    FMOV  V9.D[1], X20
    FMOV  D10, X2
    FMOV  V10.D[1], X23
    FMOV  D11, X2
    FMOV  V11.D[1], X24
    FMOV  D12, X2
    FMOV  V12.D[1], X22
    FMOV  D13, X16
    FMOV  V13.D[1], X18
    FMOV  D14, X12
    FMOV  V14.D[1], X2
    FMOV  D15, X21
    FMOV  V15.D[1], X21
    FMOV  D16, X6
    FMOV  V16.D[1], X15
    FMOV  D17, X2
    FMOV  V17.D[1], X19
    FMOV  D18, X6
    FMOV  V18.D[1], X18
    FMOV  D19, X4
    FMOV  V19.D[1], X7
    FMOV  D20, X20
    FMOV  V20.D[1], X10
    FMOV  D21, X12
    FMOV  V21.D[1], X5
    FMOV  D22, X19
    FMOV  V22.D[1], X4
    FMOV  D23, X16
    FMOV  V23.D[1], X7
    FMOV  D24, X6
    FMOV  V24.D[1], X2
    FMOV  D25, X4
    FMOV  V25.D[1], X6
    FMOV  D26, X5
    FMOV  V26.D[1], X13
    FMOV  D27, X2
    FMOV  V27.D[1], X6
    FMOV  D28, X7
    FMOV  V28.D[1], X18
    FMOV  D29, X5
    FMOV  V29.D[1], X20
    FMOV  D30, X4
    FMOV  V30.D[1], X10
    FMOV  D31, X18
    FMOV  V31.D[1], X5
    MOVZ  X24, #0xa, LSL #0
TaishanSimdWideNarryArthemticP01_label_1069:
    SQRDMULH S20, S28, V5.S[0x3]
    FMLS S25, S27, V18.S[0x0]
    FMULX S27, S17, V27.S[0x0]
    FMUL D30, D15, V2.D[0x0]
    SQRDMULH  H31, H25, H13
    SQRDMULH  H23, H14, H5
    SQRDMULH  V19.4S, V30.4S, V5.4S
    MUL  V20.8H, V19.8H, V12.H[0x2]
    FMLA S5, S24, V19.S[0x0]
    FMLS V3.2S, V22.2S, V23.S[0x3]
    FMULX V13.2D, V3.2D, V4.D[0x1]
    FMUL D5, D29, V29.D[0x1]
    SQRDMULH  V29.8H, V20.8H, V18.8H
    FMULX S29, S11, V18.S[0x1]
    FMLS D31, D6, V26.D[0x1]
    FMLA S27, S27, V8.S[0x1]
    FMULX D26, D22, V6.D[0x0]
    SQRDMULH S11, S10, V31.S[0x1]
    FMLS S6, S11, V10.S[0x3]
    FMLA V8.2D, V14.2D, V6.D[0x1]
    MLA  V8.2S, V6.2S, V14.S[0x2]
    FMLA D29, D6, V13.D[0x0]
    FMLA D11, D8, V26.D[0x1]
    FMULX V4.2S, V10.2S, V12.S[0x3]
    FMLA V9.2D, V20.2D, V5.D[0x1]
    FMLS V23.4S, V3.4S, V3.S[0x1]
    FMULX S29, S8, V15.S[0x3]
    FMULX D17, D27, V20.D[0x1]
    FMULX V1.4S, V28.4S, V17.S[0x3]
    FMLA D25, D4, V17.D[0x1]
    MUL  V25.8H, V28.8H, V15.H[0x0]
    SQRDMULH  V29.8H, V30.8H, V8.H[0x4]
    FMLS V11.2D, V14.2D, V7.D[0x1]
    SQRDMULH  V10.8H, V22.8H, V6.H[0x6]
    FMLS S14, S5, V4.S[0x1]
    FMLA S14, S2, V7.S[0x0]
    FMLA V9.2D, V8.2D, V16.D[0x0]
    SQRDMULH  S14, S26, S17
    UMULL V14.2D, V1.2S, V9.S[0x0]
    FMLS D2, D25, V20.D[0x0]
    FMULX V3.2D, V24.2D, V23.D[0x1]
    FMUL V3.4S, V13.4S, V2.S[0x3]
    FMLA S4, S29, V4.S[0x1]
    MUL  V3.8H, V21.8H, V4.H[0x3]
    FMUL V23.2D, V11.2D, V24.D[0x1]
    FMLS V29.2D, V14.2D, V21.D[0x1]
    SQRDMULH  S19, S14, S3
    UMULL2 V17.4S, V13.8H, V5.H[0x7]
    FMLS V9.2S, V12.2S, V10.S[0x1]
    UMULL V23.4S, V26.4H, V10.H[0x3]
    FMUL V30.2D, V17.2D, V4.D[0x1]
    MLS  V12.4H, V19.4H, V11.H[0x1]
    FMULX V26.2D, V27.2D, V10.D[0x1]
    FMULX S15, S29, V4.S[0x0]
    FMULX V24.4S, V24.4S, V12.S[0x0]
    SQRDMULH S14, S3, V22.S[0x0]
    SQRDMULH  H1, H5, H2
    FMULX S13, S9, V5.S[0x3]
    FMLA D23, D24, V23.D[0x0]
    SQRDMULH  V10.2S, V20.2S, V23.2S
    MLS  V5.4H, V26.4H, V13.H[0x2]
    FMLA V16.2D, V31.2D, V11.D[0x1]
    FMUL V13.2D, V15.2D, V11.D[0x0]
    FMULX V8.2D, V16.2D, V22.D[0x1]
    SQRDMULH H17, H2, V13.H[0x4]
    MLA  V6.4H, V8.4H, V3.H[0x7]
    UMULL V5.4S, V24.4H, V3.H[0x3]
    SQRDMULH  V22.4S, V1.4S, V14.S[0x3]
    FMUL S18, S26, V19.S[0x0]
    MLA  V10.4S, V9.4S, V25.S[0x3]
    UMULL V21.4S, V30.4H, V13.H[0x5]
    SQRDMULH  V9.2S, V18.2S, V21.2S
    SQRDMULH S29, S6, V17.S[0x3]
    MLA  V5.4H, V0.4H, V15.H[0x7]
    MLS  V25.4H, V31.4H, V6.H[0x5]
    SQRDMULH H27, H0, V6.H[0x0]
    FMLS S26, S17, V30.S[0x2]
    MUL  V5.2S, V25.2S, V10.S[0x0]
    MLS  V8.8H, V6.8H, V15.H[0x5]
    FMLA V24.2D, V13.2D, V6.D[0x1]
    MUL  V19.4S, V25.4S, V31.S[0x2]
    SQRDMULH  S18, S26, S12
    FMLA V22.2D, V5.2D, V14.D[0x1]
    MLS  V6.8H, V6.8H, V14.H[0x3]
    FMUL V9.2D, V19.2D, V17.D[0x1]
    MUL  V21.8H, V23.8H, V2.H[0x1]
    UMULL2 V2.2D, V19.4S, V18.S[0x3]
    FMLS S1, S1, V26.S[0x0]
    FMUL V10.2D, V17.2D, V26.D[0x1]
    SQRDMULH  V15.8H, V8.8H, V0.H[0x4]
    SQRDMULH S27, S18, V27.S[0x2]
    FMULX V10.2D, V20.2D, V9.D[0x1]
    MLA  V2.4S, V16.4S, V21.S[0x0]
    UMULL V3.4S, V28.4H, V11.H[0x2]
    SQRDMULH  V26.4S, V10.4S, V14.S[0x2]
    UMULL V29.4S, V18.4H, V11.H[0x3]
    FMULX V16.2S, V22.2S, V14.S[0x0]
    MLS  V29.2S, V18.2S, V31.S[0x3]
    FMULX S8, S27, V2.S[0x0]
    FMLA V25.4S, V9.4S, V12.S[0x2]
    MLA  V8.4S, V15.4S, V22.S[0x1]
    FMUL D0, D1, V6.D[0x0]
    MLS  V21.4S, V2.4S, V0.S[0x2]
    FMLS D9, D26, V12.D[0x1]
    MUL  V1.4H, V28.4H, V0.H[0x6]
    UMULL2 V24.2D, V29.4S, V7.S[0x0]
    FMLS V9.2D, V21.2D, V15.D[0x0]
    SQRDMULH  H16, H6, H25
    FMLS V25.2D, V30.2D, V3.D[0x1]
    MLS  V6.8H, V9.8H, V11.H[0x6]
    SQRDMULH  S14, S4, S31
    FMULX S17, S10, V4.S[0x0]
    FMULX V29.4S, V10.4S, V10.S[0x3]
    SQRDMULH  V9.2S, V21.2S, V5.S[0x1]
    FMLS V0.2D, V9.2D, V16.D[0x0]
    SQRDMULH H23, H4, V10.H[0x5]
    FMLA V20.2D, V20.2D, V10.D[0x1]
    MLS  V12.4H, V2.4H, V11.H[0x6]
    FMLA V12.2D, V29.2D, V26.D[0x0]
    UMULL V20.2D, V8.2S, V27.S[0x2]
    UMULL2 V10.4S, V5.8H, V7.H[0x4]
    MLS  V29.4S, V1.4S, V25.S[0x2]
    FMULX V30.2S, V10.2S, V9.S[0x0]
    FMLS V24.2D, V12.2D, V27.D[0x1]
    UMULL V14.4S, V28.4H, V1.H[0x5]
    FMULX D30, D13, V22.D[0x0]
    SQRDMULH  H27, H12, H28
    FMLS S10, S1, V14.S[0x3]
    FMLS V30.4S, V19.4S, V19.S[0x2]
    SQRDMULH  V7.4H, V3.4H, V22.4H
    UMULL V21.4S, V4.4H, V0.H[0x3]
    MLS  V23.2S, V8.2S, V25.S[0x2]
    FMLS S8, S24, V26.S[0x3]
    MLS  V17.2S, V19.2S, V24.S[0x3]
    FMUL D28, D24, V23.D[0x1]
    FMLS S7, S14, V30.S[0x2]
    FMULX D16, D3, V16.D[0x1]
    FMLA V29.2S, V25.2S, V29.S[0x3]
    SQRDMULH  V13.4S, V4.4S, V16.4S
    FMUL V17.2D, V16.2D, V6.D[0x0]
    FMLS S9, S2, V8.S[0x2]
    FMULX V28.4S, V13.4S, V8.S[0x1]
    FMUL V1.4S, V9.4S, V9.S[0x2]
    FMULX D8, D21, V28.D[0x1]
    MLS  V25.8H, V6.8H, V3.H[0x0]
    FMUL V17.2S, V17.2S, V19.S[0x3]
    FMLS D6, D8, V15.D[0x1]
    FMLA V13.4S, V14.4S, V10.S[0x0]
    FMLS V22.2D, V19.2D, V30.D[0x0]
    MLS  V28.8H, V27.8H, V1.H[0x2]
    UMULL2 V10.4S, V1.8H, V4.H[0x3]
    SQRDMULH  V25.8H, V4.8H, V13.H[0x1]
    UMULL2 V16.4S, V17.8H, V11.H[0x1]
    UMULL2 V26.2D, V5.4S, V13.S[0x2]
    SQRDMULH  H24, H9, H28
    FMLA V8.2D, V31.2D, V22.D[0x1]
    MUL  V23.2S, V22.2S, V24.S[0x0]
    MUL  V25.2S, V23.2S, V14.S[0x3]
    FMUL V5.2D, V5.2D, V16.D[0x1]
    FMUL V8.2D, V30.2D, V3.D[0x1]
    SQRDMULH H7, H0, V15.H[0x3]
    UMULL V18.4S, V15.4H, V4.H[0x4]
    FMULX V8.2D, V30.2D, V18.D[0x1]
    FMLS D29, D22, V19.D[0x0]
    FMLA S1, S27, V10.S[0x3]
    FMLA S7, S27, V24.S[0x3]
    FMLS V20.2S, V16.2S, V8.S[0x3]
    MUL  V20.4H, V5.4H, V13.H[0x6]
    SQRDMULH  V9.2S, V17.2S, V14.S[0x0]
    FMULX V25.4S, V14.4S, V29.S[0x1]
    UMULL2 V30.4S, V22.8H, V14.H[0x7]
    SQRDMULH  V1.4S, V19.4S, V28.4S
    SQRDMULH  V9.4H, V6.4H, V15.H[0x3]
    MLS  V22.8H, V24.8H, V15.H[0x0]
    FMUL V17.4S, V26.4S, V1.S[0x3]
    FMLS D15, D3, V2.D[0x0]
    FMUL D18, D16, V18.D[0x1]
    FMUL V28.2D, V22.2D, V3.D[0x1]
    FMUL V9.4S, V7.4S, V26.S[0x1]
    FMLA D17, D18, V22.D[0x0]
    FMUL V25.2D, V28.2D, V6.D[0x0]
    UMULL V12.2D, V5.2S, V0.S[0x1]
    FMUL D30, D11, V12.D[0x1]
    MLA  V16.2S, V9.2S, V14.S[0x1]
    MLS  V15.2S, V2.2S, V25.S[0x2]
    FMULX S0, S28, V22.S[0x0]
    FMLS S8, S18, V10.S[0x1]
    FMLA V17.4S, V1.4S, V4.S[0x0]
    MUL  V20.4H, V28.4H, V1.H[0x7]
    UMULL V8.2D, V5.2S, V23.S[0x3]
    MLS  V8.2S, V7.2S, V26.S[0x1]
    MLA  V2.4S, V20.4S, V4.S[0x1]
    FMUL V2.2S, V17.2S, V24.S[0x1]
    FMULX S19, S0, V30.S[0x0]
    SQRDMULH  V5.8H, V31.8H, V8.H[0x2]
    SQRDMULH  S2, S0, S29
    UMULL V21.4S, V17.4H, V11.H[0x7]
    SQRDMULH  V25.2S, V8.2S, V7.2S
    SQRDMULH S8, S8, V30.S[0x3]
    FMLS V10.2D, V23.2D, V14.D[0x1]
    SUBS  X24, X24, #0x1
    B.NE  TaishanSimdWideNarryArthemticP01_label_1069
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X3, X14, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X3, X22, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X7
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X8
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X28, X13, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X19, X14, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X19, X5, X15
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X12, X28, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X15, X6, X26
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X29
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, V2.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, D2
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, D3
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X5, X19, X20
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, D4
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x8000, LSL #16
    SUB  X5, X19, X20
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, D5
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, D6
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8000, LSL #16
    SUB  X7, X13, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, D7
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X28
TaishanSimdWideNarryArthemticP01_label_834:
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, D8
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, D9
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #48
    SUB  X12, X16, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, D10
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #48
    SUB  X12, X16, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, V11.D[1]
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #48
    SUB  X17, X14, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, D11
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #48
    SUB  X17, X14, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
TaishanSimdWideNarryArthemticP01_label_589:
    FMOV  X4, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, D12
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #16
    MOVK  X14, #0x8000, LSL #48
    SUB  X21, X14, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D13
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #16
    MOVK  X14, #0x8000, LSL #48
    SUB  X21, X14, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X19, X20, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, D14
    MOVZ  X20, #0x0, LSL #0
    SUB  X19, X20, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, D15
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x8000, LSL #48
    SUB  X14, X26, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, D16
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #16
    MOVK  X11, #0x8000, LSL #48
    SUB  X26, X11, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, D17
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #16
    MOVK  X11, #0x8000, LSL #48
    SUB  X26, X11, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, V18.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, D18
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, V19.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, D19
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, D20
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, V21.D[1]
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x4000, LSL #48
    SUB  X19, X11, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, D21
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x4000, LSL #48
    SUB  X19, X11, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, D22
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, D23
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, D24
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X12
TaishanSimdWideNarryArthemticP01_label_616:
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, D26
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, D27
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, D28
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, V29.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, D29
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x8000, LSL #48
    SUB  X9, X26, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
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
    FMOV  V0.D[1], X17
    FMOV  D1, X19
    FMOV  V1.D[1], X27
    FMOV  D2, X2
    FMOV  V2.D[1], X14
    FMOV  D3, X3
    FMOV  V3.D[1], X11
    FMOV  D4, X29
    FMOV  V4.D[1], X7
    FMOV  D5, X12
    FMOV  V5.D[1], X28
    FMOV  D6, X8
    FMOV  V6.D[1], X5
    FMOV  D7, X9
    FMOV  V7.D[1], X20
    FMOV  D8, X6
    FMOV  V8.D[1], X27
    FMOV  D9, X23
    FMOV  V9.D[1], X14
    FMOV  D10, X28
    FMOV  V10.D[1], X24
    FMOV  D11, X13
    FMOV  V11.D[1], X13
    FMOV  D12, X24
    FMOV  V12.D[1], X15
    FMOV  D13, X14
    FMOV  V13.D[1], X28
    FMOV  D14, X27
    FMOV  V14.D[1], X10
    FMOV  D15, X22
    FMOV  V15.D[1], X19
    FMOV  D16, X27
    FMOV  V16.D[1], X22
    FMOV  D17, X18
    FMOV  V17.D[1], X8
    FMOV  D18, X15
    FMOV  V18.D[1], X16
    FMOV  D19, X4
    FMOV  V19.D[1], X28
    FMOV  D20, X4
    FMOV  V20.D[1], X14
    FMOV  D21, X26
    FMOV  V21.D[1], X10
    FMOV  D22, X7
    FMOV  V22.D[1], X26
    FMOV  D23, X16
    FMOV  V23.D[1], X8
    FMOV  D24, X6
    FMOV  V24.D[1], X28
    FMOV  D25, X29
    FMOV  V25.D[1], X16
    FMOV  D26, X27
    FMOV  V26.D[1], X26
    FMOV  D27, X4
    FMOV  V27.D[1], X2
    FMOV  D28, X17
    FMOV  V28.D[1], X2
    FMOV  D29, X8
    FMOV  V29.D[1], X13
    FMOV  D30, X6
    FMOV  V30.D[1], X11
    FMOV  D31, X4
    FMOV  V31.D[1], X15
    MOVZ  X7, #0xf, LSL #0
TaishanSimdWideNarryArthemticP01_label_1151:
    UMULL2 V16.2D, V30.4S, V20.S[0x2]
    MUL  V0.2S, V19.2S, V11.S[0x2]
    MLA  V25.8H, V31.8H, V3.H[0x2]
    SQRDMULH  H29, H29, H11
    UMULL2 V16.4S, V21.8H, V13.H[0x0]
    FMLA S27, S20, V15.S[0x1]
    UMULL V3.2D, V12.2S, V16.S[0x2]
    MUL  V0.4H, V21.4H, V10.H[0x5]
    MLS  V24.4S, V30.4S, V26.S[0x0]
    SQRDMULH H5, H21, V15.H[0x0]
    SQRDMULH  V25.4H, V24.4H, V5.H[0x5]
    MUL  V21.8H, V3.8H, V9.H[0x1]
    SQRDMULH S21, S30, V7.S[0x3]
    FMUL S0, S29, V25.S[0x2]
    SQRDMULH S21, S29, V31.S[0x2]
    FMUL D15, D14, V22.D[0x0]
    SQRDMULH  V31.8H, V29.8H, V14.8H
    MLA  V25.8H, V6.8H, V0.H[0x1]
    MUL  V31.4H, V6.4H, V13.H[0x2]
    FMUL V21.2D, V5.2D, V31.D[0x0]
    SQRDMULH  S30, S18, S13
    FMLS V28.2D, V7.2D, V17.D[0x0]
    FMLS V30.2D, V10.2D, V8.D[0x0]
    FMUL V13.2S, V20.2S, V1.S[0x3]
    MUL  V9.4S, V6.4S, V17.S[0x1]
    FMLA D7, D10, V27.D[0x1]
    MLA  V30.4S, V15.4S, V12.S[0x2]
    FMLS V17.2D, V13.2D, V13.D[0x1]
    UMULL2 V26.2D, V0.4S, V13.S[0x3]
    FMULX D24, D7, V3.D[0x0]
    UMULL V22.4S, V3.4H, V6.H[0x5]
    FMLA V5.2S, V20.2S, V17.S[0x3]
    SQRDMULH S11, S26, V30.S[0x1]
    MUL  V28.2S, V14.2S, V28.S[0x3]
    FMULX S25, S8, V27.S[0x1]
    FMULX V28.2D, V2.2D, V22.D[0x0]
    UMULL2 V19.4S, V13.8H, V13.H[0x1]
    FMULX D26, D1, V3.D[0x0]
    FMULX D11, D16, V11.D[0x1]
    FMUL S25, S11, V14.S[0x0]
    UMULL V22.4S, V28.4H, V7.H[0x1]
    FMUL V23.2S, V5.2S, V4.S[0x2]
    MUL  V24.2S, V0.2S, V12.S[0x1]
    FMUL D2, D8, V15.D[0x0]
    FMLA V11.2D, V6.2D, V3.D[0x0]
    MLS  V2.4S, V20.4S, V15.S[0x3]
    FMLA D13, D19, V31.D[0x1]
    FMULX D16, D23, V12.D[0x0]
    FMLA S14, S20, V6.S[0x2]
    MUL  V6.4H, V23.4H, V4.H[0x1]
    SQRDMULH H9, H3, V9.H[0x7]
    FMUL D6, D24, V18.D[0x0]
    FMLA V17.2D, V27.2D, V10.D[0x0]
    FMLA V17.2S, V17.2S, V17.S[0x1]
    MUL  V30.4H, V22.4H, V11.H[0x6]
    FMLS V21.2D, V19.2D, V26.D[0x1]
    FMUL V30.2S, V18.2S, V0.S[0x3]
    SQRDMULH  V16.4H, V29.4H, V9.H[0x3]
    SQRDMULH S13, S25, V22.S[0x0]
    SQRDMULH  H4, H2, H3
    FMLA D10, D1, V21.D[0x0]
    UMULL2 V24.2D, V17.4S, V16.S[0x2]
    FMLS V6.2D, V16.2D, V20.D[0x1]
    FMUL V19.4S, V14.4S, V10.S[0x1]
    FMULX D4, D8, V23.D[0x1]
    UMULL2 V19.4S, V3.8H, V5.H[0x6]
    FMLS D2, D15, V15.D[0x1]
    FMLS V4.2S, V4.2S, V21.S[0x3]
    SQRDMULH H13, H2, V4.H[0x6]
    UMULL2 V9.4S, V20.8H, V13.H[0x7]
    FMULX D20, D22, V0.D[0x0]
    SQRDMULH  V27.2S, V7.2S, V2.S[0x0]
    SQRDMULH  S19, S28, S18
    UMULL2 V13.4S, V13.8H, V13.H[0x2]
    SQRDMULH  V8.8H, V2.8H, V6.H[0x6]
    SQRDMULH S4, S24, V12.S[0x3]
    MUL  V20.8H, V29.8H, V3.H[0x1]
    MUL  V27.8H, V22.8H, V10.H[0x5]
    SQRDMULH H12, H27, V12.H[0x3]
    FMUL V24.2D, V24.2D, V28.D[0x0]
    UMULL V15.4S, V1.4H, V12.H[0x0]
    UMULL V25.4S, V1.4H, V1.H[0x2]
    FMULX S25, S25, V20.S[0x1]
    UMULL V27.2D, V6.2S, V12.S[0x2]
    MLA  V10.4S, V9.4S, V27.S[0x1]
    FMLA V1.4S, V1.4S, V7.S[0x2]
    FMLS V19.2S, V19.2S, V25.S[0x0]
    UMULL V14.4S, V25.4H, V8.H[0x6]
    FMULX D22, D13, V14.D[0x1]
    MLS  V15.4S, V10.4S, V5.S[0x2]
    FMULX S19, S13, V10.S[0x0]
    SQRDMULH  V23.8H, V0.8H, V16.8H
    SQRDMULH S19, S7, V28.S[0x0]
    FMULX S15, S14, V2.S[0x1]
    MLS  V21.4H, V1.4H, V14.H[0x7]
    FMLA S29, S7, V2.S[0x2]
    FMUL V20.4S, V26.4S, V20.S[0x1]
    FMULX D15, D6, V14.D[0x1]
    SQRDMULH  S28, S13, S8
    MLA  V5.2S, V8.2S, V12.S[0x1]
    UMULL2 V13.2D, V23.4S, V17.S[0x3]
    FMLA S25, S27, V25.S[0x3]
    FMLS V8.2D, V9.2D, V16.D[0x0]
    FMULX S16, S1, V18.S[0x3]
    FMLS D18, D20, V1.D[0x1]
    FMLS S10, S19, V26.S[0x0]
    UMULL2 V17.2D, V26.4S, V2.S[0x2]
    SQRDMULH  V2.4S, V14.4S, V19.4S
    MLS  V0.2S, V5.2S, V13.S[0x0]
    FMUL V25.2D, V16.2D, V18.D[0x0]
    SQRDMULH  V9.4H, V25.4H, V28.4H
    FMLS V21.4S, V31.4S, V11.S[0x2]
    FMUL V11.2D, V17.2D, V21.D[0x1]
    SQRDMULH  H28, H10, H19
    SQRDMULH  V2.4S, V20.4S, V20.S[0x3]
    FMUL D6, D5, V8.D[0x1]
    FMULX V7.2S, V6.2S, V11.S[0x3]
    MLA  V14.8H, V13.8H, V4.H[0x1]
    SQRDMULH  V27.2S, V28.2S, V26.S[0x1]
    MLA  V14.4S, V18.4S, V0.S[0x2]
    FMLS V2.2D, V0.2D, V1.D[0x0]
    SQRDMULH H20, H25, V8.H[0x1]
    FMLS V30.4S, V7.4S, V26.S[0x1]
    UMULL2 V14.4S, V28.8H, V1.H[0x1]
    UMULL V1.2D, V16.2S, V28.S[0x3]
    SQRDMULH  V4.4H, V7.4H, V15.H[0x2]
    UMULL V20.2D, V31.2S, V11.S[0x0]
    SQRDMULH H17, H3, V12.H[0x3]
    FMLS S19, S15, V19.S[0x2]
    FMLA D27, D16, V9.D[0x1]
    FMULX V7.2D, V24.2D, V0.D[0x0]
    MLS  V16.4H, V5.4H, V4.H[0x4]
    FMULX S10, S5, V5.S[0x1]
    FMUL S21, S28, V2.S[0x3]
    UMULL V23.2D, V7.2S, V13.S[0x2]
    SQRDMULH  V8.2S, V8.2S, V0.2S
    SQRDMULH  S26, S26, S29
    MUL  V29.2S, V14.2S, V6.S[0x2]
    UMULL V10.2D, V16.2S, V17.S[0x1]
    FMUL S17, S3, V30.S[0x0]
    FMUL V1.2D, V11.2D, V2.D[0x0]
    FMUL D21, D30, V31.D[0x1]
    FMULX S24, S4, V10.S[0x1]
    FMULX V27.2D, V10.2D, V19.D[0x1]
    FMUL D17, D21, V20.D[0x1]
    UMULL2 V1.4S, V29.8H, V3.H[0x4]
    FMULX D28, D26, V27.D[0x0]
    FMLA D1, D18, V25.D[0x0]
    MUL  V14.8H, V24.8H, V3.H[0x0]
    FMLS V0.2D, V15.2D, V17.D[0x1]
    FMLS S28, S11, V9.S[0x0]
    UMULL V13.4S, V5.4H, V7.H[0x3]
    UMULL2 V18.4S, V2.8H, V14.H[0x0]
    MLS  V8.4H, V3.4H, V0.H[0x7]
    FMLS D6, D13, V0.D[0x1]
    MUL  V5.2S, V2.2S, V19.S[0x3]
    MLS  V19.8H, V4.8H, V8.H[0x5]
    FMUL S5, S21, V11.S[0x2]
    MUL  V12.4S, V29.4S, V8.S[0x3]
    FMULX D6, D23, V29.D[0x0]
    FMLS V11.2D, V30.2D, V29.D[0x0]
    SQRDMULH  V20.4S, V18.4S, V13.S[0x2]
    MLS  V13.4S, V28.4S, V7.S[0x3]
    SQRDMULH  V20.4H, V30.4H, V8.H[0x3]
    FMUL D30, D17, V29.D[0x0]
    FMLA D17, D19, V11.D[0x0]
    FMUL D30, D24, V19.D[0x0]
    FMLA D25, D27, V16.D[0x1]
    FMLS S29, S10, V27.S[0x1]
    FMUL V19.2D, V30.2D, V17.D[0x1]
    FMUL S12, S31, V10.S[0x0]
    MLA  V8.4S, V20.4S, V11.S[0x2]
    FMULX V5.2S, V30.2S, V13.S[0x3]
    SQRDMULH  V12.4S, V2.4S, V0.S[0x3]
    FMULX V25.2D, V28.2D, V17.D[0x0]
    FMLS S15, S26, V1.S[0x3]
    FMUL V10.2D, V16.2D, V2.D[0x0]
    FMLA V7.2D, V19.2D, V13.D[0x0]
    MUL  V1.2S, V5.2S, V25.S[0x0]
    FMUL S7, S14, V16.S[0x2]
    FMUL D1, D10, V3.D[0x0]
    SQRDMULH S30, S19, V23.S[0x1]
    SQRDMULH  S16, S12, S19
    FMUL V15.2S, V29.2S, V5.S[0x2]
    UMULL V3.2D, V30.2S, V0.S[0x1]
    FMLS S30, S8, V30.S[0x3]
    SQRDMULH  H1, H7, H11
    MLA  V28.2S, V21.2S, V26.S[0x2]
    FMLS V13.4S, V11.4S, V28.S[0x0]
    FMULX D8, D0, V0.D[0x1]
    MLA  V30.2S, V27.2S, V15.S[0x2]
    FMLS S8, S23, V20.S[0x2]
    MUL  V14.8H, V16.8H, V3.H[0x1]
    FMULX V31.2D, V22.2D, V1.D[0x1]
    FMLS V5.2S, V20.2S, V12.S[0x3]
    SQRDMULH  H13, H31, H5
    FMULX V30.2S, V2.2S, V12.S[0x0]
    SQRDMULH  H8, H0, H20
    FMLA V22.2D, V17.2D, V20.D[0x1]
    SQRDMULH S10, S15, V3.S[0x1]
    SUBS  X7, X7, #0x1
    B.NE  TaishanSimdWideNarryArthemticP01_label_1151
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X2, X20, X2
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X3, X6, X3
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X6, X23, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X18, X27, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X2, X23, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X9
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X9, X20, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X23, X20, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X8, X19, X12
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X11, X21, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X21, X27, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X8, X28, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
TaishanSimdWideNarryArthemticP01_label_95:
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X2, X8, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X13, X17, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X4, X13, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X11, X8, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X28, X16, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X16, X21, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X11, X16, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X28, X3, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x8000, LSL #48
    SUB  X24, X7, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X17, D2
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x8000, LSL #48
    SUB  X24, X7, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, D3
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X6, D4
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, V5.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, D5
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0x7fff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0x7fff, LSL #48
    SUB  X12, X20, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, D6
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X9, X29, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D7
    MOVZ  X29, #0x0, LSL #0
    SUB  X9, X29, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D8
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, V9.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X14, X6, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, D9
    MOVZ  X6, #0x0, LSL #0
    SUB  X14, X6, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X3, X14, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, D10
    MOVZ  X14, #0x0, LSL #0
    SUB  X3, X14, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x8000, LSL #48
    SUB  X12, X22, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, D11
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x8000, LSL #48
    SUB  X12, X22, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, V12.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0x7fff, LSL #48
    SUB  X17, X15, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, D12
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0x7fff, LSL #48
    SUB  X17, X15, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X28, X19, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, D13
    MOVZ  X19, #0x0, LSL #0
    SUB  X28, X19, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, V14.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X5, X12, X22
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, D14
    MOVZ  X12, #0x0, LSL #0
    SUB  X5, X12, X22
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, D15
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x8000, LSL #16
    SUB  X9, X18, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, D16
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, D17
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x8000, LSL #48
    SUB  X15, X10, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, D18
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, D19
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D20
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, V21.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, D21
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, D22
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8000, LSL #48
    SUB  X16, X13, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, D23
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, D24
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, D26
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, D27
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X27, X3, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, D28
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x8000, LSL #16
    SUB  X27, X3, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X6, D29
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x8000, LSL #16
    SUB  X4, X22, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X2, #0x3db8, LSL #0
    MOVK  X2, #0xf8fc, LSL #16
    MOVK  X2, #0x71a4, LSL #32
    MOVK  X2, #0xfdb, LSL #48
    MOVZ  X3, #0xbf0e, LSL #0
    MOVK  X3, #0xdd70, LSL #16
    MOVK  X3, #0x832, LSL #32
    MOVK  X3, #0xcfcf, LSL #48
    MOVZ  X4, #0x7cb2, LSL #0
    MOVK  X4, #0xb89a, LSL #16
    MOVK  X4, #0xb585, LSL #32
    MOVK  X4, #0x6745, LSL #48
    MOVZ  X5, #0x6a75, LSL #0
    MOVK  X5, #0xe89c, LSL #16
    MOVK  X5, #0xb72d, LSL #32
    MOVK  X5, #0x4465, LSL #48
    MOVZ  X6, #0x544c, LSL #0
    MOVK  X6, #0xd2c3, LSL #16
    MOVK  X6, #0x2b4f, LSL #32
    MOVK  X6, #0x90a7, LSL #48
    MOVZ  X7, #0x381b, LSL #0
    MOVK  X7, #0x3ecd, LSL #16
    MOVK  X7, #0x46c, LSL #32
    MOVK  X7, #0x3940, LSL #48
    MOVZ  X8, #0xe624, LSL #0
    MOVK  X8, #0xdc1c, LSL #16
    MOVK  X8, #0xb86b, LSL #32
    MOVK  X8, #0x3649, LSL #48
    MOVZ  X9, #0xd1e4, LSL #0
    MOVK  X9, #0x1522, LSL #16
    MOVK  X9, #0x513f, LSL #32
    MOVK  X9, #0xd404, LSL #48
    MOVZ  X10, #0x4fbf, LSL #0
    MOVK  X10, #0x9065, LSL #16
    MOVK  X10, #0x3075, LSL #32
    MOVK  X10, #0xcee4, LSL #48
    MOVZ  X11, #0x899e, LSL #0
    MOVK  X11, #0x99f4, LSL #16
    MOVK  X11, #0xa7f2, LSL #32
    MOVK  X11, #0x7b1c, LSL #48
    MOVZ  X12, #0x9469, LSL #0
    MOVK  X12, #0xf852, LSL #16
    MOVK  X12, #0x3c71, LSL #32
    MOVK  X12, #0x5abb, LSL #48
    MOVZ  X13, #0xadbb, LSL #0
    MOVK  X13, #0xd5fa, LSL #16
    MOVK  X13, #0x8d3, LSL #32
    MOVK  X13, #0xc683, LSL #48
    MOVZ  X14, #0xf256, LSL #0
    MOVK  X14, #0xceba, LSL #16
    MOVK  X14, #0xbd71, LSL #32
    MOVK  X14, #0x81fe, LSL #48
    MOVZ  X15, #0x2b7d, LSL #0
    MOVK  X15, #0x61ed, LSL #16
    MOVK  X15, #0x5a49, LSL #32
    MOVK  X15, #0x27c2, LSL #48
    MOVZ  X16, #0xf794, LSL #0
    MOVK  X16, #0x7208, LSL #16
    MOVK  X16, #0x36fb, LSL #32
    MOVK  X16, #0xbbd5, LSL #48
    MOVZ  X17, #0x1ce8, LSL #0
    MOVK  X17, #0x9b, LSL #16
    MOVK  X17, #0x83f0, LSL #32
    MOVK  X17, #0x43d, LSL #48
    MOVZ  X18, #0xd746, LSL #0
    MOVK  X18, #0xf322, LSL #16
    MOVK  X18, #0x3068, LSL #32
    MOVK  X18, #0x1615, LSL #48
    MOVZ  X19, #0x3614, LSL #0
    MOVK  X19, #0xefb3, LSL #16
    MOVK  X19, #0xc67, LSL #32
    MOVK  X19, #0x8592, LSL #48
    MOVZ  X20, #0x6dc, LSL #0
    MOVK  X20, #0x9580, LSL #16
    MOVK  X20, #0x8795, LSL #32
    MOVK  X20, #0x90ec, LSL #48
    MOVZ  X21, #0x7f7f, LSL #0
    MOVK  X21, #0x9890, LSL #16
    MOVK  X21, #0x8786, LSL #32
    MOVK  X21, #0x8942, LSL #48
    MOVZ  X22, #0x151, LSL #0
    MOVK  X22, #0xdb1, LSL #16
    MOVK  X22, #0x619d, LSL #32
    MOVK  X22, #0xc4d, LSL #48
    MOVZ  X23, #0x36c3, LSL #0
    MOVK  X23, #0xf586, LSL #16
    MOVK  X23, #0x297c, LSL #32
    MOVK  X23, #0x670b, LSL #48
    MOVZ  X24, #0x5477, LSL #0
    MOVK  X24, #0xfaf5, LSL #16
    MOVK  X24, #0xb817, LSL #32
    MOVK  X24, #0x7b4c, LSL #48
    MOVZ  X26, #0x32ad, LSL #0
    MOVK  X26, #0x9160, LSL #16
    MOVK  X26, #0x7ba4, LSL #32
    MOVK  X26, #0x1e03, LSL #48
    MOVZ  X27, #0x15ac, LSL #0
    MOVK  X27, #0x37dc, LSL #16
    MOVK  X27, #0xb238, LSL #32
    MOVK  X27, #0x9bc1, LSL #48
    MOVZ  X28, #0x8006, LSL #0
    MOVK  X28, #0x6ec9, LSL #16
    MOVK  X28, #0xc057, LSL #32
    MOVK  X28, #0xd912, LSL #48
    MOVZ  X29, #0xe23d, LSL #0
    MOVK  X29, #0xbbd3, LSL #16
    MOVK  X29, #0xd9eb, LSL #32
    MOVK  X29, #0x2ee7, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X20
    FMOV  D1, X2
    FMOV  V1.D[1], X27
    FMOV  D2, X29
    FMOV  V2.D[1], X17
    FMOV  D3, X10
    FMOV  V3.D[1], X28
    FMOV  D4, X15
    FMOV  V4.D[1], X26
    FMOV  D5, X18
    FMOV  V5.D[1], X7
    FMOV  D6, X29
    FMOV  V6.D[1], X19
    FMOV  D7, X27
    FMOV  V7.D[1], X6
    FMOV  D8, X17
    FMOV  V8.D[1], X17
    FMOV  D9, X29
    FMOV  V9.D[1], X3
    FMOV  D10, X4
    FMOV  V10.D[1], X11
    FMOV  D11, X26
    FMOV  V11.D[1], X12
    FMOV  D12, X10
    FMOV  V12.D[1], X3
    FMOV  D13, X11
    FMOV  V13.D[1], X5
    FMOV  D14, X12
    FMOV  V14.D[1], X23
    FMOV  D15, X7
    FMOV  V15.D[1], X23
    FMOV  D16, X9
    FMOV  V16.D[1], X10
    FMOV  D17, X19
    FMOV  V17.D[1], X2
    FMOV  D18, X10
    FMOV  V18.D[1], X14
    FMOV  D19, X20
    FMOV  V19.D[1], X6
    FMOV  D20, X5
    FMOV  V20.D[1], X8
    FMOV  D21, X18
    FMOV  V21.D[1], X12
    FMOV  D22, X28
    FMOV  V22.D[1], X24
    FMOV  D23, X11
    FMOV  V23.D[1], X24
    FMOV  D24, X6
    FMOV  V24.D[1], X26
    FMOV  D25, X2
    FMOV  V25.D[1], X27
    FMOV  D26, X16
    FMOV  V26.D[1], X27
    FMOV  D27, X14
    FMOV  V27.D[1], X18
    FMOV  D28, X4
    FMOV  V28.D[1], X16
    FMOV  D29, X17
    FMOV  V29.D[1], X4
    FMOV  D30, X14
    FMOV  V30.D[1], X5
    FMOV  D31, X22
    FMOV  V31.D[1], X10
    MOVZ  X23, #0xa, LSL #0
TaishanSimdWideNarryArthemticP01_label_1233:
    FMULX D14, D12, V27.D[0x1]
    UMULL V9.4S, V14.4H, V8.H[0x2]
    SQRDMULH  H29, H28, H25
    SQRDMULH H26, H24, V10.H[0x1]
    FMULX S9, S7, V16.S[0x3]
    FMULX V4.4S, V27.4S, V8.S[0x1]
    FMLS D29, D22, V9.D[0x0]
    SQRDMULH  V12.4S, V22.4S, V15.S[0x1]
    FMULX D26, D23, V0.D[0x0]
    SQRDMULH S3, S16, V20.S[0x0]
    FMLA V18.2D, V14.2D, V16.D[0x0]
    FMLA V18.2D, V11.2D, V30.D[0x0]
    MLA  V18.4H, V27.4H, V12.H[0x5]
    FMUL V25.2D, V9.2D, V6.D[0x1]
    MLS  V5.4S, V0.4S, V11.S[0x1]
    SQRDMULH  H31, H27, H1
    MLA  V7.4H, V20.4H, V2.H[0x2]
    SQRDMULH  V23.4H, V23.4H, V11.H[0x6]
    SQRDMULH  V15.4S, V11.4S, V2.S[0x1]
    FMULX V9.2S, V5.2S, V30.S[0x2]
    FMUL S28, S9, V26.S[0x2]
    UMULL2 V1.4S, V17.8H, V2.H[0x3]
    SQRDMULH S29, S7, V24.S[0x3]
    SQRDMULH H24, H0, V12.H[0x0]
    FMULX V9.2S, V4.2S, V25.S[0x2]
    FMLA S11, S16, V9.S[0x1]
    SQRDMULH  H30, H1, H2
    FMLA V9.2D, V24.2D, V2.D[0x0]
    MUL  V20.8H, V20.8H, V3.H[0x6]
    UMULL2 V23.4S, V22.8H, V7.H[0x1]
    SQRDMULH  H18, H18, H17
    FMUL D22, D6, V16.D[0x1]
    SQRDMULH  V9.4H, V26.4H, V10.4H
    FMLS S10, S12, V7.S[0x2]
    FMLS V10.2D, V24.2D, V27.D[0x0]
    SQRDMULH  V8.8H, V31.8H, V9.H[0x6]
    FMULX V7.2D, V9.2D, V16.D[0x0]
    FMLA V6.2S, V14.2S, V22.S[0x0]
    FMLA S26, S29, V11.S[0x2]
    FMLS V17.2D, V13.2D, V22.D[0x0]
    FMLA V30.2S, V0.2S, V0.S[0x1]
    UMULL2 V30.4S, V21.8H, V15.H[0x5]
    FMLS V18.4S, V3.4S, V3.S[0x2]
    FMLS D1, D25, V2.D[0x1]
    FMLA D12, D17, V3.D[0x1]
    UMULL2 V23.4S, V17.8H, V4.H[0x0]
    SQRDMULH  V30.4S, V16.4S, V14.S[0x3]
    FMULX D9, D5, V9.D[0x0]
    FMUL V24.2D, V3.2D, V13.D[0x0]
    FMLS V3.4S, V9.4S, V15.S[0x1]
    MLS  V25.2S, V28.2S, V5.S[0x2]
    UMULL2 V26.2D, V7.4S, V4.S[0x2]
    SQRDMULH  V7.4H, V28.4H, V3.H[0x2]
    SQRDMULH H28, H3, V6.H[0x2]
    SQRDMULH S22, S3, V18.S[0x1]
    FMULX V30.2S, V3.2S, V11.S[0x1]
    FMUL S13, S12, V12.S[0x3]
    SQRDMULH  H6, H4, H22
    SQRDMULH  V27.4H, V24.4H, V0.4H
    UMULL V13.2D, V10.2S, V28.S[0x1]
    SQRDMULH  H0, H19, H31
    FMUL S18, S5, V8.S[0x1]
    FMULX V12.2D, V5.2D, V23.D[0x1]
    SQRDMULH H21, H13, V11.H[0x2]
    SQRDMULH  V19.2S, V26.2S, V20.2S
    MLA  V1.4H, V15.4H, V4.H[0x5]
    FMLS V4.4S, V29.4S, V25.S[0x2]
    FMLS V14.2S, V31.2S, V18.S[0x0]
    UMULL2 V25.4S, V29.8H, V6.H[0x5]
    UMULL2 V15.4S, V19.8H, V3.H[0x5]
    UMULL2 V26.4S, V15.8H, V14.H[0x1]
    MLA  V19.4H, V25.4H, V7.H[0x3]
    SQRDMULH  V0.8H, V29.8H, V12.8H
    SQRDMULH  V22.8H, V10.8H, V2.H[0x4]
    UMULL2 V25.4S, V20.8H, V1.H[0x1]
    SQRDMULH  S23, S4, S12
    FMLA V20.2D, V10.2D, V28.D[0x1]
    FMULX D20, D21, V1.D[0x0]
    FMLS S8, S5, V5.S[0x2]
    MUL  V7.4S, V30.4S, V2.S[0x3]
    FMUL V5.2D, V26.2D, V8.D[0x1]
    MLA  V24.4S, V11.4S, V0.S[0x1]
    SQRDMULH H30, H7, V9.H[0x6]
    SQRDMULH  V17.4S, V22.4S, V0.S[0x2]
    SQRDMULH  S25, S15, S25
    UMULL V21.4S, V21.4H, V2.H[0x0]
    FMLA V19.2D, V30.2D, V30.D[0x1]
    FMULX V19.4S, V24.4S, V7.S[0x1]
    UMULL V29.4S, V12.4H, V7.H[0x4]
    FMLA D7, D1, V27.D[0x0]
    SQRDMULH  H7, H15, H23
    MLA  V8.4H, V27.4H, V12.H[0x6]
    SQRDMULH  V22.4H, V2.4H, V5.H[0x2]
    FMLA V6.4S, V4.4S, V6.S[0x2]
    FMUL S7, S8, V24.S[0x3]
    UMULL V5.4S, V8.4H, V13.H[0x4]
    MLA  V30.8H, V8.8H, V8.H[0x6]
    FMUL V13.2D, V6.2D, V9.D[0x1]
    FMUL V11.2D, V21.2D, V31.D[0x0]
    SQRDMULH  V8.2S, V0.2S, V24.S[0x3]
    FMLA V16.2D, V10.2D, V26.D[0x1]
    SQRDMULH H4, H30, V7.H[0x0]
    MLS  V29.4H, V22.4H, V13.H[0x6]
    MLA  V24.8H, V22.8H, V3.H[0x3]
    FMUL V4.2S, V16.2S, V16.S[0x0]
    SQRDMULH H4, H15, V5.H[0x7]
    MUL  V23.4S, V29.4S, V2.S[0x0]
    UMULL2 V7.2D, V25.4S, V13.S[0x1]
    UMULL V11.2D, V26.2S, V10.S[0x2]
    SQRDMULH S6, S3, V1.S[0x2]
    SQRDMULH  V6.8H, V0.8H, V5.H[0x7]
    UMULL2 V2.2D, V18.4S, V11.S[0x2]
    FMUL D9, D15, V12.D[0x1]
    SQRDMULH  H9, H19, H5
    SQRDMULH  V19.2S, V18.2S, V21.S[0x1]
    MUL  V24.4S, V13.4S, V12.S[0x1]
    MLA  V22.4H, V6.4H, V7.H[0x1]
    FMUL S21, S5, V0.S[0x3]
    SQRDMULH  V5.2S, V7.2S, V21.2S
    UMULL2 V9.4S, V22.8H, V7.H[0x6]
    FMUL D22, D13, V26.D[0x0]
    SQRDMULH  V16.8H, V9.8H, V23.8H
    FMUL D21, D2, V5.D[0x0]
    FMLS S17, S17, V7.S[0x1]
    FMLS D18, D21, V3.D[0x1]
    FMULX V29.4S, V22.4S, V22.S[0x2]
    UMULL2 V17.4S, V0.8H, V15.H[0x0]
    SQRDMULH  V4.4S, V14.4S, V17.S[0x3]
    FMUL S25, S15, V18.S[0x2]
    MLA  V25.4S, V31.4S, V13.S[0x0]
    UMULL V3.2D, V29.2S, V7.S[0x0]
    FMULX D10, D16, V0.D[0x0]
    FMUL D5, D1, V3.D[0x0]
    FMLA V3.2S, V4.2S, V30.S[0x1]
    FMLS V22.2S, V7.2S, V10.S[0x3]
    FMLS D0, D27, V18.D[0x0]
    SQRDMULH  H0, H12, H27
    UMULL V11.4S, V19.4H, V1.H[0x7]
    FMULX V24.2S, V2.2S, V6.S[0x1]
    MLA  V3.4H, V27.4H, V5.H[0x1]
    FMLA V21.2D, V9.2D, V26.D[0x0]
    SQRDMULH  H16, H8, H18
    FMLA S10, S4, V24.S[0x1]
    FMUL V25.2S, V5.2S, V0.S[0x1]
    FMUL V11.2S, V21.2S, V10.S[0x2]
    FMUL D11, D7, V12.D[0x1]
    UMULL2 V16.4S, V9.8H, V9.H[0x3]
    FMUL D7, D7, V3.D[0x1]
    FMLS S5, S8, V6.S[0x0]
    FMULX S27, S12, V5.S[0x2]
    FMULX S10, S1, V29.S[0x1]
    SQRDMULH S22, S1, V28.S[0x1]
    FMUL S4, S18, V8.S[0x2]
    MUL  V25.4S, V2.4S, V14.S[0x1]
    FMUL D18, D21, V8.D[0x0]
    MLA  V14.4H, V4.4H, V11.H[0x1]
    SQRDMULH  V19.2S, V6.2S, V31.S[0x2]
    MUL  V5.2S, V30.2S, V28.S[0x0]
    UMULL2 V14.2D, V1.4S, V15.S[0x0]
    FMUL D9, D16, V7.D[0x0]
    SQRDMULH S14, S11, V10.S[0x3]
    FMLS V13.2D, V25.2D, V28.D[0x0]
    UMULL V22.2D, V0.2S, V1.S[0x0]
    MLA  V18.8H, V14.8H, V14.H[0x1]
    UMULL V1.2D, V16.2S, V26.S[0x0]
    UMULL V3.2D, V19.2S, V21.S[0x2]
    UMULL2 V22.2D, V6.4S, V28.S[0x2]
    FMLA D11, D27, V29.D[0x1]
    MUL  V18.4S, V8.4S, V12.S[0x3]
    SQRDMULH S7, S11, V5.S[0x0]
    FMLA D5, D20, V28.D[0x0]
    FMLS V15.2D, V31.2D, V1.D[0x1]
    SQRDMULH S25, S16, V21.S[0x2]
    FMLA V20.4S, V22.4S, V18.S[0x1]
    MLA  V24.4S, V19.4S, V0.S[0x2]
    MLS  V7.4H, V30.4H, V5.H[0x7]
    MLS  V3.4H, V3.4H, V9.H[0x5]
    FMLS D15, D20, V23.D[0x1]
    FMLA V10.2D, V16.2D, V12.D[0x0]
    FMLA D0, D21, V5.D[0x0]
    FMLA V19.2S, V14.2S, V3.S[0x3]
    MLA  V8.4S, V14.4S, V5.S[0x3]
    FMLA D23, D26, V19.D[0x0]
    FMUL S20, S8, V14.S[0x1]
    SQRDMULH S3, S13, V25.S[0x1]
    FMUL V17.4S, V14.4S, V31.S[0x2]
    MUL  V23.4S, V12.4S, V8.S[0x0]
    FMULX S16, S23, V24.S[0x0]
    MLA  V22.8H, V5.8H, V7.H[0x5]
    UMULL V23.2D, V12.2S, V7.S[0x1]
    SQRDMULH H30, H14, V10.H[0x0]
    FMULX S24, S19, V11.S[0x3]
    UMULL V15.4S, V9.4H, V8.H[0x1]
    MLS  V29.8H, V9.8H, V13.H[0x6]
    UMULL V29.2D, V25.2S, V0.S[0x2]
    FMLS V6.4S, V14.4S, V28.S[0x3]
    FMLA V10.2S, V5.2S, V24.S[0x0]
    FMULX V5.2D, V31.2D, V26.D[0x1]
    FMLA D11, D23, V28.D[0x1]
    SQRDMULH  V20.8H, V24.8H, V12.H[0x7]
    SUBS  X23, X23, #0x1
    B.NE  TaishanSimdWideNarryArthemticP01_label_1233
    MOVZ  X24, #0x3db8, LSL #0
    MOVK  X24, #0xf8fc, LSL #16
    MOVK  X24, #0x71a4, LSL #32
    MOVK  X24, #0xfdb, LSL #48
    SUB  X12, X24, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X4, #0xbf0e, LSL #0
    MOVK  X4, #0xdd70, LSL #16
    MOVK  X4, #0x832, LSL #32
    MOVK  X4, #0xcfcf, LSL #48
    SUB  X10, X4, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X18, #0xbf0e, LSL #0
    MOVK  X18, #0xdd70, LSL #16
    MOVK  X18, #0x832, LSL #32
    MOVK  X18, #0xcfcf, LSL #48
    SUB  X3, X18, X4
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X19, #0x6a75, LSL #0
    MOVK  X19, #0xe89c, LSL #16
    MOVK  X19, #0xb72d, LSL #32
    MOVK  X19, #0x4465, LSL #48
    SUB  X29, X19, X5
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X26, #0x544c, LSL #0
    MOVK  X26, #0xd2c3, LSL #16
    MOVK  X26, #0x2b4f, LSL #32
    MOVK  X26, #0x90a7, LSL #48
    SUB  X24, X26, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X10, #0x381b, LSL #0
    MOVK  X10, #0x3ecd, LSL #16
    MOVK  X10, #0x46c, LSL #32
    MOVK  X10, #0x3940, LSL #48
    SUB  X20, X10, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X16, #0xe624, LSL #0
    MOVK  X16, #0xdc1c, LSL #16
    MOVK  X16, #0xb86b, LSL #32
    MOVK  X16, #0x3649, LSL #48
    SUB  X2, X16, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X14, #0xd1e4, LSL #0
    MOVK  X14, #0x1522, LSL #16
    MOVK  X14, #0x513f, LSL #32
    MOVK  X14, #0xd404, LSL #48
    SUB  X29, X14, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X20, #0x381b, LSL #0
    MOVK  X20, #0x3ecd, LSL #16
    MOVK  X20, #0x46c, LSL #32
    MOVK  X20, #0x3940, LSL #48
    SUB  X13, X20, X10
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X13, #0x899e, LSL #0
    MOVK  X13, #0x99f4, LSL #16
    MOVK  X13, #0xa7f2, LSL #32
    MOVK  X13, #0x7b1c, LSL #48
    SUB  X27, X13, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X5, #0x899e, LSL #0
    MOVK  X5, #0x99f4, LSL #16
    MOVK  X5, #0xa7f2, LSL #32
    MOVK  X5, #0x7b1c, LSL #48
    SUB  X11, X5, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X4, #0xd1e4, LSL #0
    MOVK  X4, #0x1522, LSL #16
    MOVK  X4, #0x513f, LSL #32
    MOVK  X4, #0xd404, LSL #48
    SUB  X22, X4, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X29, #0x2b7d, LSL #0
    MOVK  X29, #0x61ed, LSL #16
    MOVK  X29, #0x5a49, LSL #32
    MOVK  X29, #0x27c2, LSL #48
    SUB  X10, X29, X15
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X14, #0xe624, LSL #0
    MOVK  X14, #0xdc1c, LSL #16
    MOVK  X14, #0xb86b, LSL #32
    MOVK  X14, #0x3649, LSL #48
    SUB  X15, X14, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X5, #0x1ce8, LSL #0
    MOVK  X5, #0x9b, LSL #16
    MOVK  X5, #0x83f0, LSL #32
    MOVK  X5, #0x43d, LSL #48
    SUB  X16, X5, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X26, #0xbf0e, LSL #0
    MOVK  X26, #0xdd70, LSL #16
    MOVK  X26, #0x832, LSL #32
    MOVK  X26, #0xcfcf, LSL #48
    SUB  X9, X26, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X13, #0x381b, LSL #0
    MOVK  X13, #0x3ecd, LSL #16
    MOVK  X13, #0x46c, LSL #32
    MOVK  X13, #0x3940, LSL #48
    SUB  X27, X13, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X27, X5, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X4, #0xbf0e, LSL #0
    MOVK  X4, #0xdd70, LSL #16
    MOVK  X4, #0x832, LSL #32
    MOVK  X4, #0xcfcf, LSL #48
    SUB  X8, X4, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X20, #0x8006, LSL #0
    MOVK  X20, #0x6ec9, LSL #16
    MOVK  X20, #0xc057, LSL #32
    MOVK  X20, #0xd912, LSL #48
    SUB  X16, X20, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X19, #0x2b7d, LSL #0
    MOVK  X19, #0x61ed, LSL #16
    MOVK  X19, #0x5a49, LSL #32
    MOVK  X19, #0x27c2, LSL #48
    SUB  X28, X19, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, D2
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X10, X3, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, D4
    MOVZ  X3, #0x0, LSL #0
    SUB  X10, X3, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, D5
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, V6.D[1]
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #16
    MOVK  X4, #0x8000, LSL #48
    SUB  X24, X4, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, D6
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #16
    MOVK  X4, #0x8000, LSL #48
    SUB  X24, X4, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, D7
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, D8
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X7, X26, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, D9
    MOVZ  X26, #0x0, LSL #0
    SUB  X7, X26, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X13, X3, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, D10
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x8000, LSL #16
    SUB  X13, X3, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, V11.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, D11
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V12.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D12
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #48
    SUB  X15, X14, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, D13
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #48
    SUB  X15, X14, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X6, D14
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, V15.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, D15
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X18, X9, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X18, X9, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, D17
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, D18
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, D19
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X28, X13, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D20
    MOVZ  X13, #0x0, LSL #0
    SUB  X28, X13, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X3, X22, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, D21
    MOVZ  X22, #0x0, LSL #0
    SUB  X3, X22, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, D22
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, D23
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, V24.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, D24
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, D26
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, D27
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, D28
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, D29
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
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
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X4
    FMOV  V0.D[1], X17
    FMOV  D1, X18
    FMOV  V1.D[1], X13
    FMOV  D2, X2
    FMOV  V2.D[1], X29
    FMOV  D3, X14
    FMOV  V3.D[1], X24
    FMOV  D4, X17
    FMOV  V4.D[1], X4
    FMOV  D5, X19
    FMOV  V5.D[1], X28
    FMOV  D6, X26
    FMOV  V6.D[1], X22
    FMOV  D7, X27
    FMOV  V7.D[1], X8
    FMOV  D8, X20
    FMOV  V8.D[1], X21
    FMOV  D9, X27
    FMOV  V9.D[1], X18
    FMOV  D10, X26
    FMOV  V10.D[1], X24
    FMOV  D11, X21
    FMOV  V11.D[1], X2
    FMOV  D12, X5
    FMOV  V12.D[1], X13
    FMOV  D13, X22
    FMOV  V13.D[1], X14
    FMOV  D14, X24
    FMOV  V14.D[1], X5
    FMOV  D15, X8
    FMOV  V15.D[1], X9
    FMOV  D16, X11
    FMOV  V16.D[1], X11
    FMOV  D17, X3
    FMOV  V17.D[1], X7
    FMOV  D18, X13
    FMOV  V18.D[1], X23
    FMOV  D19, X28
    FMOV  V19.D[1], X11
    FMOV  D20, X20
    FMOV  V20.D[1], X28
    FMOV  D21, X22
    FMOV  V21.D[1], X24
    FMOV  D22, X23
    FMOV  V22.D[1], X29
    FMOV  D23, X14
    FMOV  V23.D[1], X18
    FMOV  D24, X24
    FMOV  V24.D[1], X22
    FMOV  D25, X15
    FMOV  V25.D[1], X17
    FMOV  D26, X20
    FMOV  V26.D[1], X22
    FMOV  D27, X11
    FMOV  V27.D[1], X2
    FMOV  D28, X11
    FMOV  V28.D[1], X10
    FMOV  D29, X14
    FMOV  V29.D[1], X22
    FMOV  D30, X18
    FMOV  V30.D[1], X18
    FMOV  D31, X15
    FMOV  V31.D[1], X26
    MOVZ  X18, #0xa, LSL #0
TaishanSimdWideNarryArthemticP01_label_1315:
    FMLS V9.2S, V23.2S, V17.S[0x0]
    FMLA D9, D20, V29.D[0x0]
TaishanSimdWideNarryArthemticP01_label_1078:
    SQRDMULH  V16.8H, V1.8H, V19.8H
    MLS  V6.2S, V28.2S, V22.S[0x2]
    SQRDMULH  H13, H16, H19
    MLS  V13.4H, V27.4H, V3.H[0x6]
    MUL  V30.4S, V8.4S, V15.S[0x0]
    MUL  V20.8H, V14.8H, V8.H[0x4]
    SQRDMULH  S28, S9, S5
    SQRDMULH  S11, S10, S3
    FMLS D27, D28, V22.D[0x0]
    SQRDMULH S8, S1, V19.S[0x1]
    FMLA D26, D21, V6.D[0x0]
    FMULX S2, S15, V30.S[0x2]
    FMLS S16, S30, V31.S[0x2]
    SQRDMULH H14, H23, V15.H[0x6]
    SQRDMULH H15, H25, V6.H[0x6]
    UMULL2 V15.4S, V9.8H, V10.H[0x3]
    MLA  V8.2S, V29.2S, V22.S[0x0]
    SQRDMULH  V26.4H, V19.4H, V14.H[0x5]
    FMULX D16, D13, V23.D[0x0]
    FMLS V16.2D, V25.2D, V10.D[0x0]
    FMULX D16, D2, V15.D[0x1]
    UMULL V22.4S, V31.4H, V0.H[0x2]
    FMULX V13.2S, V9.2S, V2.S[0x1]
    SQRDMULH H5, H5, V11.H[0x2]
    FMULX V24.2D, V6.2D, V8.D[0x0]
    FMULX V31.2S, V16.2S, V31.S[0x0]
    SQRDMULH H5, H25, V15.H[0x2]
    SQRDMULH  V14.4S, V25.4S, V23.S[0x1]
    FMLS S15, S17, V29.S[0x0]
    MLS  V1.8H, V0.8H, V1.H[0x0]
    FMULX D11, D19, V10.D[0x0]
    SQRDMULH S29, S21, V8.S[0x2]
    FMULX V16.2D, V27.2D, V21.D[0x0]
    MLA  V25.2S, V30.2S, V4.S[0x2]
    SQRDMULH  V16.2S, V22.2S, V2.S[0x3]
    UMULL V19.4S, V29.4H, V5.H[0x4]
    FMULX D4, D9, V25.D[0x1]
    SQRDMULH  V10.4H, V31.4H, V20.4H
    SQRDMULH  H24, H9, H30
    UMULL2 V30.4S, V7.8H, V5.H[0x0]
    FMLS V4.4S, V23.4S, V21.S[0x3]
    FMULX S0, S19, V2.S[0x2]
    FMUL D14, D19, V4.D[0x0]
    FMUL V27.2S, V8.2S, V10.S[0x3]
    FMLA V1.2S, V23.2S, V26.S[0x2]
    FMUL V19.4S, V5.4S, V22.S[0x1]
    SQRDMULH  V25.2S, V27.2S, V17.S[0x3]
    FMULX V21.4S, V3.4S, V25.S[0x3]
    FMUL V9.2D, V3.2D, V22.D[0x0]
    FMUL V26.2D, V24.2D, V30.D[0x0]
    FMLA S16, S7, V24.S[0x2]
    UMULL V16.2D, V14.2S, V8.S[0x3]
    SQRDMULH S17, S4, V25.S[0x0]
    FMLS S9, S25, V4.S[0x3]
    FMULX V16.2D, V9.2D, V11.D[0x1]
    FMUL S26, S30, V4.S[0x2]
    SQRDMULH  S21, S2, S9
    FMUL D19, D21, V2.D[0x0]
    FMUL S11, S4, V13.S[0x2]
    UMULL V27.2D, V12.2S, V6.S[0x3]
    UMULL2 V26.4S, V17.8H, V14.H[0x0]
    MLS  V1.8H, V2.8H, V2.H[0x3]
    SQRDMULH  S12, S8, S1
    SQRDMULH H16, H6, V3.H[0x3]
    MUL  V12.8H, V12.8H, V12.H[0x7]
    SQRDMULH  S31, S13, S12
    MLS  V12.2S, V19.2S, V7.S[0x0]
    FMULX V17.2D, V25.2D, V5.D[0x0]
    FMLA V6.2D, V12.2D, V11.D[0x1]
    SQRDMULH  V9.4H, V5.4H, V11.H[0x3]
    FMULX V25.2D, V25.2D, V5.D[0x0]
    FMLA S1, S18, V25.S[0x1]
    SQRDMULH  H4, H16, H18
    FMUL S17, S23, V24.S[0x1]
    FMULX V27.2D, V13.2D, V25.D[0x0]
    SQRDMULH  V17.8H, V5.8H, V10.H[0x6]
    FMLA D16, D13, V21.D[0x0]
    SQRDMULH  H14, H18, H23
    SQRDMULH  V18.4S, V26.4S, V18.S[0x0]
    SQRDMULH  S24, S0, S23
    FMLA V8.4S, V27.4S, V19.S[0x2]
    SQRDMULH S24, S13, V17.S[0x1]
    FMUL S3, S4, V4.S[0x2]
    MUL  V7.4S, V23.4S, V3.S[0x3]
    UMULL V14.4S, V31.4H, V13.H[0x0]
    FMLA S23, S5, V4.S[0x1]
    UMULL V26.2D, V13.2S, V24.S[0x2]
    FMLA V0.2D, V20.2D, V14.D[0x0]
    FMLS D6, D7, V20.D[0x1]
    MUL  V1.8H, V19.8H, V14.H[0x3]
    FMLA D1, D1, V21.D[0x1]
    FMLS V25.2D, V22.2D, V13.D[0x1]
    SQRDMULH  H23, H18, H4
    MLS  V7.4H, V6.4H, V15.H[0x7]
    FMUL V7.2D, V18.2D, V29.D[0x0]
    MLS  V21.2S, V11.2S, V8.S[0x1]
    FMLA V10.4S, V14.4S, V26.S[0x3]
    SQRDMULH H24, H17, V5.H[0x3]
    FMULX S0, S0, V24.S[0x0]
    MLS  V11.4H, V2.4H, V14.H[0x4]
    SQRDMULH  S18, S10, S24
    SQRDMULH  H27, H27, H9
    FMLS V17.2S, V31.2S, V11.S[0x3]
    MUL  V25.4H, V21.4H, V4.H[0x0]
    FMLA S0, S6, V31.S[0x1]
    FMLS S16, S22, V13.S[0x1]
    FMLS S1, S20, V16.S[0x2]
    FMLA S11, S24, V2.S[0x1]
    FMLS S20, S28, V26.S[0x1]
    FMLA S25, S6, V23.S[0x3]
    FMLA D21, D7, V7.D[0x0]
    FMUL D17, D2, V18.D[0x1]
    MUL  V24.2S, V26.2S, V27.S[0x3]
    FMULX V9.2D, V22.2D, V23.D[0x1]
    MLA  V19.2S, V11.2S, V30.S[0x2]
    FMLS S9, S9, V31.S[0x2]
    FMULX V12.2D, V5.2D, V18.D[0x0]
    UMULL V2.4S, V14.4H, V13.H[0x2]
    MLA  V12.4S, V1.4S, V2.S[0x2]
    FMLA V31.4S, V31.4S, V13.S[0x2]
    FMLA V26.2S, V12.2S, V4.S[0x1]
    SQRDMULH  S13, S9, S1
    SQRDMULH  V3.4H, V13.4H, V0.H[0x7]
    SQRDMULH H27, H31, V8.H[0x3]
    FMLS S3, S19, V12.S[0x2]
    SQRDMULH  S10, S27, S4
    FMUL V22.2D, V22.2D, V22.D[0x1]
    SQRDMULH  V2.4H, V5.4H, V16.4H
    SQRDMULH  V28.8H, V26.8H, V1.8H
    FMLA S14, S17, V8.S[0x1]
    MUL  V19.8H, V10.8H, V13.H[0x0]
    FMULX V8.2S, V13.2S, V31.S[0x0]
    MUL  V10.8H, V21.8H, V2.H[0x7]
    FMUL D18, D6, V21.D[0x0]
    SQRDMULH H22, H20, V5.H[0x7]
    SQRDMULH H24, H24, V3.H[0x7]
    FMLS V29.4S, V3.4S, V9.S[0x0]
    SQRDMULH  V27.4S, V11.4S, V6.S[0x1]
    FMUL S5, S23, V23.S[0x3]
    SQRDMULH H6, H4, V11.H[0x0]
    FMLS S29, S10, V31.S[0x1]
    FMULX S26, S20, V25.S[0x2]
    FMUL S7, S23, V3.S[0x0]
    UMULL V28.2D, V1.2S, V9.S[0x2]
    MLA  V26.8H, V20.8H, V8.H[0x2]
    FMULX V16.4S, V19.4S, V31.S[0x1]
    FMULX V7.2D, V12.2D, V1.D[0x0]
    MUL  V1.8H, V24.8H, V9.H[0x7]
    SQRDMULH H16, H23, V9.H[0x4]
    UMULL V23.2D, V29.2S, V2.S[0x2]
    FMUL V4.2D, V6.2D, V4.D[0x0]
    FMLS S5, S25, V12.S[0x2]
    SQRDMULH  V30.4S, V5.4S, V0.S[0x2]
    UMULL V27.2D, V8.2S, V21.S[0x0]
    SQRDMULH  S11, S8, S20
    FMLS V10.2D, V25.2D, V30.D[0x0]
    FMULX V11.2S, V27.2S, V25.S[0x3]
    MLA  V12.4S, V1.4S, V22.S[0x3]
    UMULL2 V29.4S, V0.8H, V4.H[0x4]
    SQRDMULH  V18.8H, V17.8H, V2.8H
    FMULX V6.2D, V13.2D, V1.D[0x0]
    FMLS V19.2D, V28.2D, V29.D[0x0]
    FMLA D31, D29, V23.D[0x1]
    FMUL D9, D31, V30.D[0x1]
    FMLS D11, D26, V26.D[0x0]
    FMULX S27, S20, V1.S[0x3]
    SQRDMULH  V18.8H, V18.8H, V24.8H
    SQRDMULH  S17, S31, S3
    SQRDMULH  V8.4S, V31.4S, V22.S[0x1]
    UMULL2 V26.2D, V31.4S, V25.S[0x2]
    FMUL V27.2S, V8.2S, V17.S[0x2]
    SQRDMULH  V17.8H, V11.8H, V3.H[0x5]
    FMULX D9, D7, V18.D[0x1]
    MLS  V5.4H, V9.4H, V2.H[0x7]
    FMLA D15, D3, V29.D[0x0]
    SQRDMULH  S28, S7, S13
    SQRDMULH  V23.8H, V26.8H, V9.H[0x2]
    FMUL V2.2D, V2.2D, V13.D[0x1]
    FMUL V2.4S, V16.4S, V30.S[0x1]
    SQRDMULH S30, S7, V14.S[0x2]
    FMLA D12, D10, V19.D[0x0]
    FMLA V23.2S, V2.2S, V29.S[0x3]
    FMULX S19, S17, V20.S[0x3]
    SQRDMULH  V9.8H, V14.8H, V1.8H
    FMUL V19.2D, V9.2D, V17.D[0x0]
    FMULX D20, D16, V25.D[0x1]
    SQRDMULH  V16.8H, V4.8H, V15.H[0x6]
    MUL  V11.4H, V5.4H, V7.H[0x0]
    SQRDMULH H24, H18, V10.H[0x5]
    UMULL V18.2D, V25.2S, V27.S[0x3]
    UMULL2 V15.4S, V29.8H, V13.H[0x7]
    MLA  V31.8H, V30.8H, V12.H[0x1]
    FMLA V21.2D, V31.2D, V28.D[0x1]
    FMLS D13, D13, V10.D[0x0]
    MLA  V3.4H, V15.4H, V14.H[0x2]
    FMLA V2.2D, V3.2D, V25.D[0x1]
    UMULL2 V12.2D, V24.4S, V4.S[0x0]
    UMULL2 V25.4S, V9.8H, V6.H[0x7]
    SUBS  X18, X18, #0x1
    B.NE  TaishanSimdWideNarryArthemticP01_label_1315
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X5
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X8
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X9, X24, X9
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X27, X17, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X3, X28, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X15
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X19, X3, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X28, X15, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X27
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X13, X18, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, D2
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D3
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8000, LSL #16
    SUB  X16, X28, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, D4
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, D5
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8000, LSL #16
    SUB  X18, X28, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, D6
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, D7
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X23, X22, X7
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, D8
    MOVZ  X22, #0x0, LSL #0
    SUB  X23, X22, X7
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X28, X19, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, D9
    MOVZ  X19, #0x0, LSL #0
    SUB  X28, X19, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x8000, LSL #48
    SUB  X11, X2, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, D10
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x8000, LSL #48
    SUB  X11, X2, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, D11
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, D12
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, D13
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0x7fff, LSL #16
    SUB  X29, X24, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D14
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #16
    SUB  X9, X8, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, D15
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, D16
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X20, X11, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X6, D17
    MOVZ  X11, #0x0, LSL #0
    SUB  X20, X11, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D18
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, V19.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, D19
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, V20.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, D20
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X15
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, D21
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X15
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, V22.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, D22
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D23
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, D24
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, D26
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, D27
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, D28
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, D29
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
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
    FMOV  D0, X17
    FMOV  V0.D[1], X9
TaishanSimdWideNarryArthemticP01_label_421:
    FMOV  D1, X28
    FMOV  V1.D[1], X21
    FMOV  D2, X21
    FMOV  V2.D[1], X29
    FMOV  D3, X17
    FMOV  V3.D[1], X11
    FMOV  D4, X27
    FMOV  V4.D[1], X2
    FMOV  D5, X21
    FMOV  V5.D[1], X23
    FMOV  D6, X14
    FMOV  V6.D[1], X18
    FMOV  D7, X14
    FMOV  V7.D[1], X11
    FMOV  D8, X18
    FMOV  V8.D[1], X20
    FMOV  D9, X27
    FMOV  V9.D[1], X13
    FMOV  D10, X14
    FMOV  V10.D[1], X29
    FMOV  D11, X10
    FMOV  V11.D[1], X11
    FMOV  D12, X22
    FMOV  V12.D[1], X18
    FMOV  D13, X3
    FMOV  V13.D[1], X18
    FMOV  D14, X13
    FMOV  V14.D[1], X21
    FMOV  D15, X14
    FMOV  V15.D[1], X20
    FMOV  D16, X22
    FMOV  V16.D[1], X21
    FMOV  D17, X21
    FMOV  V17.D[1], X19
    FMOV  D18, X18
    FMOV  V18.D[1], X21
    FMOV  D19, X9
    FMOV  V19.D[1], X15
    FMOV  D20, X5
    FMOV  V20.D[1], X7
    FMOV  D21, X21
    FMOV  V21.D[1], X6
    FMOV  D22, X20
    FMOV  V22.D[1], X11
    FMOV  D23, X9
    FMOV  V23.D[1], X4
    FMOV  D24, X12
    FMOV  V24.D[1], X16
    FMOV  D25, X18
    FMOV  V25.D[1], X22
    FMOV  D26, X8
    FMOV  V26.D[1], X17
    FMOV  D27, X11
    FMOV  V27.D[1], X21
    FMOV  D28, X22
    FMOV  V28.D[1], X17
    FMOV  D29, X29
    FMOV  V29.D[1], X10
    FMOV  D30, X17
    FMOV  V30.D[1], X29
    FMOV  D31, X12
    FMOV  V31.D[1], X9
    MOVZ  X23, #0xf, LSL #0
TaishanSimdWideNarryArthemticP01_label_1396:
    FMULX V18.2D, V5.2D, V2.D[0x0]
    FMULX D4, D21, V28.D[0x0]
    MUL  V26.8H, V4.8H, V0.H[0x5]
    FMULX V10.2D, V25.2D, V18.D[0x1]
    FMLS D31, D17, V29.D[0x1]
    MUL  V9.4S, V5.4S, V30.S[0x2]
    FMULX V14.2D, V22.2D, V23.D[0x0]
    UMULL2 V3.4S, V20.8H, V15.H[0x0]
    FMLS D21, D27, V21.D[0x1]
    SQRDMULH H5, H7, V2.H[0x3]
    UMULL V9.4S, V22.4H, V1.H[0x6]
    FMLS V25.2S, V1.2S, V26.S[0x3]
    MUL  V1.4S, V4.4S, V4.S[0x2]
    FMULX S25, S30, V26.S[0x0]
    UMULL2 V10.4S, V25.8H, V9.H[0x1]
    MUL  V19.4S, V15.4S, V0.S[0x2]
    FMULX S27, S3, V0.S[0x1]
    FMLA V29.4S, V10.4S, V2.S[0x2]
    FMULX S8, S26, V25.S[0x2]
    UMULL2 V14.4S, V22.8H, V1.H[0x3]
    FMLA S16, S31, V4.S[0x3]
    FMULX S30, S20, V21.S[0x2]
    MLS  V19.4S, V12.4S, V30.S[0x1]
    MLA  V14.4S, V6.4S, V9.S[0x1]
    FMLS S7, S7, V5.S[0x2]
    FMULX V24.2D, V27.2D, V23.D[0x1]
    SQRDMULH  V29.4S, V19.4S, V15.4S
    FMLS V24.2S, V11.2S, V12.S[0x3]
    FMLA V21.2D, V29.2D, V6.D[0x1]
    FMULX V24.2S, V29.2S, V24.S[0x0]
    FMULX S2, S31, V0.S[0x2]
    FMLA V3.2D, V7.2D, V4.D[0x0]
    FMLA D27, D14, V20.D[0x0]
    MLA  V17.8H, V27.8H, V3.H[0x0]
    FMULX V21.4S, V2.4S, V21.S[0x2]
    SQRDMULH  V7.4S, V23.4S, V24.S[0x1]
    FMULX V16.2S, V8.2S, V26.S[0x1]
    SQRDMULH S8, S10, V19.S[0x2]
    UMULL V22.4S, V3.4H, V9.H[0x0]
    SQRDMULH  V14.4S, V5.4S, V20.S[0x3]
    FMLS D23, D2, V30.D[0x1]
    FMLA D7, D14, V12.D[0x1]
    FMLA D1, D22, V31.D[0x1]
    MLA  V4.2S, V14.2S, V25.S[0x3]
    FMULX V7.4S, V8.4S, V8.S[0x3]
    FMLS S15, S7, V16.S[0x1]
    SQRDMULH H21, H23, V7.H[0x0]
    FMLS D6, D1, V28.D[0x1]
    SQRDMULH  V4.4S, V31.4S, V0.4S
    SQRDMULH H22, H9, V6.H[0x4]
    MUL  V16.8H, V16.8H, V2.H[0x7]
    SQRDMULH S6, S1, V2.S[0x1]
    FMULX S21, S10, V31.S[0x2]
    FMULX V14.2D, V11.2D, V16.D[0x1]
    UMULL V13.2D, V18.2S, V23.S[0x1]
    MLS  V2.4S, V25.4S, V8.S[0x0]
    FMLA V11.2D, V10.2D, V4.D[0x1]
    MUL  V24.8H, V22.8H, V12.H[0x3]
    SQRDMULH  V24.8H, V3.8H, V5.H[0x4]
    MLA  V8.4S, V16.4S, V10.S[0x3]
    SQRDMULH  V15.4H, V5.4H, V5.H[0x4]
    SQRDMULH  S21, S31, S9
    FMULX S19, S5, V24.S[0x0]
    FMULX V30.4S, V21.4S, V5.S[0x2]
    UMULL V21.4S, V13.4H, V1.H[0x5]
    SQRDMULH H14, H24, V9.H[0x7]
    MLA  V0.8H, V26.8H, V12.H[0x2]
    MLS  V19.4S, V15.4S, V5.S[0x3]
    FMULX V30.2D, V19.2D, V27.D[0x1]
    FMLA D29, D2, V2.D[0x0]
    FMULX S30, S12, V13.S[0x2]
    UMULL V0.4S, V29.4H, V5.H[0x1]
    FMULX S16, S25, V24.S[0x0]
    MLS  V24.4S, V17.4S, V1.S[0x3]
    FMLA V23.2S, V21.2S, V16.S[0x0]
    FMLA D4, D21, V19.D[0x0]
    MLS  V8.8H, V16.8H, V4.H[0x0]
    UMULL V22.2D, V8.2S, V0.S[0x2]
    FMULX S14, S4, V26.S[0x3]
    FMULX V17.2D, V27.2D, V5.D[0x0]
    FMLS S31, S18, V2.S[0x2]
    SQRDMULH  H20, H5, H31
    SQRDMULH  H20, H29, H29
    UMULL V23.2D, V23.2S, V11.S[0x2]
    FMULX V20.2D, V24.2D, V20.D[0x1]
    FMLA S20, S14, V15.S[0x2]
    FMULX V4.2D, V8.2D, V10.D[0x1]
    FMLA S23, S23, V24.S[0x3]
    UMULL V2.2D, V27.2S, V20.S[0x1]
    UMULL V18.4S, V17.4H, V15.H[0x7]
    FMLA S4, S8, V12.S[0x0]
    MLA  V26.2S, V19.2S, V29.S[0x0]
    SQRDMULH S28, S3, V18.S[0x3]
    FMLA D8, D10, V23.D[0x0]
    FMLA V9.2S, V20.2S, V1.S[0x2]
    MLS  V28.4H, V9.4H, V2.H[0x6]
    SQRDMULH  V6.4S, V20.4S, V30.4S
    FMLA V1.4S, V20.4S, V4.S[0x1]
    MUL  V24.2S, V16.2S, V26.S[0x2]
    SQRDMULH S11, S4, V5.S[0x2]
    FMULX V27.2S, V21.2S, V14.S[0x2]
    SQRDMULH  V12.8H, V8.8H, V14.H[0x7]
    MLA  V28.4S, V27.4S, V26.S[0x1]
TaishanSimdWideNarryArthemticP01_label_1311:
    FMLA V6.2D, V28.2D, V4.D[0x1]
    SQRDMULH S30, S1, V6.S[0x2]
    FMLA V24.4S, V19.4S, V7.S[0x0]
    FMULX V7.2D, V30.2D, V28.D[0x1]
    MUL  V31.4H, V11.4H, V7.H[0x0]
    SQRDMULH  V26.2S, V7.2S, V7.S[0x3]
    FMUL S31, S15, V28.S[0x0]
    FMULX S16, S30, V21.S[0x3]
    FMLS D31, D17, V12.D[0x0]
    UMULL V19.2D, V21.2S, V8.S[0x0]
    SQRDMULH  V23.4H, V24.4H, V30.4H
    FMLA V10.4S, V5.4S, V18.S[0x3]
    FMLA V23.2S, V15.2S, V13.S[0x0]
    MLS  V20.2S, V17.2S, V15.S[0x1]
    FMLS D13, D18, V16.D[0x1]
    FMLS S3, S26, V8.S[0x3]
    FMUL V2.2S, V17.2S, V11.S[0x2]
    FMLA V27.2S, V2.2S, V20.S[0x3]
    FMLA D29, D14, V11.D[0x0]
    FMLA S6, S3, V26.S[0x0]
    FMUL S20, S26, V10.S[0x1]
    SQRDMULH  S21, S31, S20
    MUL  V26.4S, V21.4S, V19.S[0x1]
    SQRDMULH  H2, H18, H1
    FMLA D15, D13, V19.D[0x0]
    MUL  V5.4H, V8.4H, V15.H[0x7]
    FMLS V9.4S, V28.4S, V9.S[0x3]
    SQRDMULH  V13.2S, V12.2S, V25.S[0x2]
    FMUL V3.2D, V2.2D, V9.D[0x0]
    FMULX V29.4S, V28.4S, V27.S[0x3]
    SQRDMULH S12, S5, V30.S[0x0]
    SQRDMULH  V30.2S, V7.2S, V13.2S
    MUL  V4.8H, V24.8H, V10.H[0x0]
    FMULX V16.4S, V4.4S, V6.S[0x3]
    FMULX S31, S11, V14.S[0x3]
    MUL  V11.2S, V6.2S, V22.S[0x0]
    FMLS S16, S20, V31.S[0x2]
    FMUL S27, S23, V13.S[0x2]
    MLS  V20.8H, V27.8H, V4.H[0x4]
    UMULL V9.4S, V21.4H, V6.H[0x1]
    FMULX S28, S18, V25.S[0x0]
    SQRDMULH S17, S9, V26.S[0x0]
    FMLS D14, D18, V23.D[0x0]
    MUL  V31.4H, V26.4H, V14.H[0x1]
TaishanSimdWideNarryArthemticP01_label_187:
    UMULL2 V11.2D, V14.4S, V16.S[0x0]
    SQRDMULH  V1.4H, V15.4H, V10.H[0x1]
    FMLA V28.2S, V25.2S, V16.S[0x3]
    FMLS V20.2D, V7.2D, V24.D[0x0]
    UMULL2 V9.2D, V13.4S, V17.S[0x1]
    FMULX V13.2S, V4.2S, V15.S[0x2]
    FMLA D31, D7, V21.D[0x1]
    FMULX D14, D9, V5.D[0x0]
    FMULX D7, D30, V1.D[0x0]
    MLS  V17.4S, V15.4S, V10.S[0x0]
    UMULL2 V14.2D, V22.4S, V15.S[0x3]
    MUL  V22.8H, V26.8H, V11.H[0x4]
    FMULX S8, S26, V4.S[0x0]
    FMLA V26.2D, V2.2D, V1.D[0x0]
    MLS  V24.2S, V27.2S, V22.S[0x2]
    FMUL S11, S14, V16.S[0x0]
    FMULX V10.2S, V14.2S, V13.S[0x0]
    FMUL V19.4S, V30.4S, V25.S[0x2]
    UMULL2 V1.2D, V20.4S, V25.S[0x2]
    MLS  V28.4H, V24.4H, V10.H[0x0]
TaishanSimdWideNarryArthemticP01_label_555:
    UMULL V29.4S, V24.4H, V7.H[0x7]
    FMUL V28.2S, V3.2S, V19.S[0x3]
    SQRDMULH H22, H24, V15.H[0x7]
    FMLS V26.2S, V9.2S, V7.S[0x3]
    FMLA S3, S29, V13.S[0x1]
    FMLA D22, D19, V0.D[0x1]
    FMLS V16.2S, V20.2S, V0.S[0x2]
    MLA  V28.2S, V31.2S, V26.S[0x3]
    UMULL V5.2D, V19.2S, V27.S[0x2]
    SQRDMULH S31, S30, V15.S[0x2]
    SQRDMULH H10, H6, V5.H[0x2]
    MUL  V0.4S, V0.4S, V31.S[0x1]
    FMLA V1.4S, V4.4S, V2.S[0x0]
    MUL  V22.2S, V17.2S, V17.S[0x3]
    MUL  V10.8H, V17.8H, V11.H[0x4]
    SQRDMULH S8, S14, V1.S[0x1]
    UMULL V17.4S, V0.4H, V6.H[0x4]
    FMUL V17.2D, V18.2D, V1.D[0x0]
    SQRDMULH  S28, S19, S20
    SQRDMULH  S17, S30, S2
    SQRDMULH  V2.4H, V28.4H, V9.H[0x2]
    FMLS D14, D22, V8.D[0x1]
    FMUL V3.4S, V30.4S, V6.S[0x3]
    MLA  V31.8H, V17.8H, V15.H[0x7]
    MUL  V25.4H, V10.4H, V9.H[0x2]
    FMUL S4, S2, V11.S[0x3]
    FMULX D12, D14, V0.D[0x0]
    SQRDMULH H9, H12, V6.H[0x2]
    FMLS S11, S28, V4.S[0x1]
    SQRDMULH H25, H13, V5.H[0x6]
    FMLA V30.2D, V25.2D, V25.D[0x0]
    FMLA V31.4S, V14.4S, V3.S[0x3]
    FMUL V8.4S, V4.4S, V19.S[0x3]
    SUBS  X23, X23, #0x1
    B.NE  TaishanSimdWideNarryArthemticP01_label_1396
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X6, X9, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X24, X15, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X22, X20, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X12, X20, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X26, X20, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X7, X21, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X11, X12, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X19, X8, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X17, X9, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X5, X3, X15
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X8, X28, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X23, X17, X23
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X22, X23, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X7, X29, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X7, X12, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, V2.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, D2
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, V3.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X8, X28, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, D3
    MOVZ  X28, #0x0, LSL #0
    SUB  X8, X28, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D4
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, D5
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, D6
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #16
    SUB  X8, X14, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, D7
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X27, X19, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, D8
    MOVZ  X19, #0x0, LSL #0
    SUB  X27, X19, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D9
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X2, X27, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, D10
    MOVZ  X27, #0x0, LSL #0
    SUB  X2, X27, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D11
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x8000, LSL #16
    SUB  X9, X2, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, D12
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x8000, LSL #48
    SUB  X4, X3, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X29, X26, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, D13
    MOVZ  X26, #0x0, LSL #0
    SUB  X29, X26, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, D14
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #48
    SUB  X3, X8, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, D15
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x8000, LSL #48
    SUB  X22, X19, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, D16
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x8000, LSL #16
    SUB  X13, X27, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, D17
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, D18
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, D19
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x8000, LSL #48
    SUB  X11, X3, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, D20
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x8000, LSL #48
    SUB  X11, X3, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, D21
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, D22
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, V23.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, D23
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, D24
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, D26
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #16
    MOVK  X16, #0x8000, LSL #48
    SUB  X7, X16, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, D27
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, D28
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X9, X20, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D29
    MOVZ  X20, #0x0, LSL #0
    SUB  X9, X20, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X2, #0x2e03, LSL #0
    MOVK  X2, #0x2f0f, LSL #16
    MOVK  X2, #0xe087, LSL #32
    MOVK  X2, #0x4395, LSL #48
    MOVZ  X3, #0xb470, LSL #0
    MOVK  X3, #0x6f0d, LSL #16
    MOVK  X3, #0xfe4a, LSL #32
    MOVK  X3, #0x2859, LSL #48
    MOVZ  X4, #0xf27b, LSL #0
    MOVK  X4, #0x4491, LSL #16
    MOVK  X4, #0xbb21, LSL #32
    MOVK  X4, #0x731, LSL #48
    MOVZ  X5, #0x9383, LSL #0
    MOVK  X5, #0xe0b2, LSL #16
    MOVK  X5, #0x74a3, LSL #32
    MOVK  X5, #0xe406, LSL #48
    MOVZ  X6, #0xf7f4, LSL #0
    MOVK  X6, #0x2447, LSL #16
    MOVK  X6, #0x213e, LSL #32
    MOVK  X6, #0xed2c, LSL #48
    MOVZ  X7, #0x8c6b, LSL #0
    MOVK  X7, #0x9932, LSL #16
    MOVK  X7, #0xd643, LSL #32
    MOVK  X7, #0xf347, LSL #48
    MOVZ  X8, #0x72f, LSL #0
    MOVK  X8, #0x10f2, LSL #16
    MOVK  X8, #0x278f, LSL #32
    MOVK  X8, #0xa573, LSL #48
    MOVZ  X9, #0xb9bf, LSL #0
    MOVK  X9, #0x532c, LSL #16
    MOVK  X9, #0xd2d4, LSL #32
    MOVK  X9, #0xd951, LSL #48
    MOVZ  X10, #0xf102, LSL #0
    MOVK  X10, #0xc87c, LSL #16
    MOVK  X10, #0x4a9e, LSL #32
    MOVK  X10, #0x55af, LSL #48
    MOVZ  X11, #0x333a, LSL #0
    MOVK  X11, #0xd42d, LSL #16
    MOVK  X11, #0x68c, LSL #32
    MOVK  X11, #0xf05e, LSL #48
    MOVZ  X12, #0x3c9f, LSL #0
    MOVK  X12, #0xf219, LSL #16
    MOVK  X12, #0xd478, LSL #32
    MOVK  X12, #0xa417, LSL #48
    MOVZ  X13, #0x1dc, LSL #0
    MOVK  X13, #0xe4c, LSL #16
    MOVK  X13, #0xcdc2, LSL #32
    MOVK  X13, #0x3836, LSL #48
    MOVZ  X14, #0x2773, LSL #0
    MOVK  X14, #0x2fae, LSL #16
    MOVK  X14, #0xd010, LSL #32
    MOVK  X14, #0x9407, LSL #48
    MOVZ  X15, #0x91b0, LSL #0
    MOVK  X15, #0xe9ef, LSL #16
    MOVK  X15, #0x666f, LSL #32
    MOVK  X15, #0x84f7, LSL #48
    MOVZ  X16, #0xc368, LSL #0
    MOVK  X16, #0x50a3, LSL #16
    MOVK  X16, #0xe06e, LSL #32
    MOVK  X16, #0xdd1, LSL #48
    MOVZ  X17, #0x8285, LSL #0
    MOVK  X17, #0x8417, LSL #16
    MOVK  X17, #0x8410, LSL #32
    MOVK  X17, #0x8f47, LSL #48
    MOVZ  X18, #0x3d37, LSL #0
    MOVK  X18, #0x9622, LSL #16
    MOVK  X18, #0x8d0f, LSL #32
    MOVK  X18, #0x71ec, LSL #48
    MOVZ  X19, #0x528e, LSL #0
    MOVK  X19, #0xff9b, LSL #16
    MOVK  X19, #0x4985, LSL #32
    MOVK  X19, #0xab6, LSL #48
    MOVZ  X20, #0xc84c, LSL #0
    MOVK  X20, #0xb521, LSL #16
    MOVK  X20, #0x2af1, LSL #32
    MOVK  X20, #0xd827, LSL #48
    MOVZ  X21, #0x6a59, LSL #0
    MOVK  X21, #0x40e4, LSL #16
    MOVK  X21, #0xf26, LSL #32
    MOVK  X21, #0xa98c, LSL #48
    MOVZ  X22, #0x2b9, LSL #0
    MOVK  X22, #0xd0ab, LSL #16
    MOVK  X22, #0x8fae, LSL #32
    MOVK  X22, #0x8bf, LSL #48
    MOVZ  X23, #0x98bb, LSL #0
    MOVK  X23, #0x4706, LSL #16
    MOVK  X23, #0x959f, LSL #32
    MOVK  X23, #0xa63d, LSL #48
    MOVZ  X24, #0xe617, LSL #0
    MOVK  X24, #0x8a21, LSL #16
    MOVK  X24, #0xa0b8, LSL #32
    MOVK  X24, #0x5842, LSL #48
    MOVZ  X26, #0x5d33, LSL #0
    MOVK  X26, #0xf216, LSL #16
    MOVK  X26, #0xd680, LSL #32
    MOVK  X26, #0x9b35, LSL #48
    MOVZ  X27, #0x9b8f, LSL #0
    MOVK  X27, #0x6040, LSL #16
    MOVK  X27, #0x2627, LSL #32
    MOVK  X27, #0xfa73, LSL #48
    MOVZ  X28, #0x77f4, LSL #0
    MOVK  X28, #0x24c3, LSL #16
    MOVK  X28, #0x851f, LSL #32
    MOVK  X28, #0xec8c, LSL #48
    MOVZ  X29, #0x208b, LSL #0
    MOVK  X29, #0x8def, LSL #16
    MOVK  X29, #0x1e86, LSL #32
    MOVK  X29, #0x1889, LSL #48
    FMOV  D0, X20
    FMOV  V0.D[1], X19
    FMOV  D1, X7
    FMOV  V1.D[1], X24
    FMOV  D2, X11
    FMOV  V2.D[1], X29
    FMOV  D3, X19
    FMOV  V3.D[1], X8
    FMOV  D4, X28
    FMOV  V4.D[1], X5
    FMOV  D5, X27
    FMOV  V5.D[1], X28
    FMOV  D6, X15
    FMOV  V6.D[1], X4
    FMOV  D7, X8
    FMOV  V7.D[1], X17
    FMOV  D8, X19
    FMOV  V8.D[1], X19
    FMOV  D9, X12
    FMOV  V9.D[1], X18
    FMOV  D10, X4
    FMOV  V10.D[1], X20
    FMOV  D11, X13
    FMOV  V11.D[1], X8
    FMOV  D12, X11
    FMOV  V12.D[1], X20
    FMOV  D13, X3
    FMOV  V13.D[1], X8
    FMOV  D14, X20
    FMOV  V14.D[1], X5
    FMOV  D15, X9
    FMOV  V15.D[1], X19
    FMOV  D16, X20
    FMOV  V16.D[1], X18
    FMOV  D17, X20
    FMOV  V17.D[1], X21
    FMOV  D18, X13
    FMOV  V18.D[1], X21
    FMOV  D19, X29
    FMOV  V19.D[1], X14
    FMOV  D20, X3
    FMOV  V20.D[1], X19
    FMOV  D21, X2
    FMOV  V21.D[1], X22
    FMOV  D22, X16
    FMOV  V22.D[1], X24
    FMOV  D23, X29
    FMOV  V23.D[1], X19
    FMOV  D24, X13
    FMOV  V24.D[1], X22
    FMOV  D25, X28
    FMOV  V25.D[1], X2
    FMOV  D26, X13
    FMOV  V26.D[1], X22
    FMOV  D27, X10
    FMOV  V27.D[1], X21
    FMOV  D28, X18
    FMOV  V28.D[1], X20
    FMOV  D29, X14
    FMOV  V29.D[1], X27
    FMOV  D30, X5
    FMOV  V30.D[1], X20
    FMOV  D31, X20
    FMOV  V31.D[1], X28
    MOVZ  X12, #0xa, LSL #0
TaishanSimdWideNarryArthemticP01_label_1476:
    MLS  V2.8H, V7.8H, V15.H[0x4]
    FMLA S16, S29, V30.S[0x0]
    FMLA V19.2S, V9.2S, V27.S[0x0]
    SQRDMULH  V3.2S, V14.2S, V13.S[0x3]
    MLA  V3.4S, V26.4S, V20.S[0x1]
    FMLS V1.2S, V18.2S, V26.S[0x2]
    SQRDMULH H13, H21, V6.H[0x5]
    MLA  V28.2S, V31.2S, V12.S[0x3]
    MUL  V15.4H, V28.4H, V12.H[0x5]
    FMULX V17.2D, V25.2D, V3.D[0x0]
    FMUL S24, S19, V28.S[0x1]
    FMLS V23.2D, V20.2D, V25.D[0x1]
    MLS  V20.2S, V26.2S, V7.S[0x2]
    MUL  V7.4H, V24.4H, V8.H[0x6]
    SQRDMULH H31, H23, V15.H[0x1]
    SQRDMULH  H25, H26, H27
    UMULL V25.2D, V4.2S, V6.S[0x0]
    MLS  V11.8H, V1.8H, V0.H[0x0]
    FMULX D6, D21, V1.D[0x1]
    FMLA D19, D3, V1.D[0x0]
    FMULX V15.2D, V4.2D, V6.D[0x0]
    SQRDMULH  V7.4H, V15.4H, V29.4H
    MUL  V20.2S, V31.2S, V5.S[0x1]
    FMUL S23, S21, V25.S[0x2]
    MUL  V17.2S, V25.2S, V13.S[0x3]
    MUL  V15.4S, V9.4S, V11.S[0x3]
    MLA  V31.8H, V26.8H, V13.H[0x5]
    UMULL V3.4S, V20.4H, V12.H[0x1]
    MLA  V31.8H, V5.8H, V13.H[0x3]
    SQRDMULH H25, H13, V5.H[0x0]
    FMLS V24.2D, V25.2D, V26.D[0x0]
    FMLA V14.4S, V21.4S, V24.S[0x0]
    FMLA S2, S25, V26.S[0x2]
    SQRDMULH  V31.2S, V15.2S, V23.S[0x2]
    FMLS D17, D13, V26.D[0x0]
    FMLA V21.2D, V25.2D, V24.D[0x0]
    SQRDMULH  V29.2S, V6.2S, V9.2S
    MUL  V26.8H, V7.8H, V13.H[0x6]
    FMUL V5.2D, V23.2D, V25.D[0x0]
    FMUL D2, D0, V29.D[0x1]
    FMLA V21.4S, V18.4S, V18.S[0x0]
    UMULL V3.2D, V9.2S, V20.S[0x1]
    SQRDMULH  V28.4S, V3.4S, V26.S[0x1]
    FMLS V21.2S, V16.2S, V26.S[0x2]
    FMLS V17.4S, V22.4S, V25.S[0x1]
    FMLS D27, D5, V12.D[0x1]
    MLS  V28.8H, V11.8H, V2.H[0x6]
    UMULL V29.4S, V28.4H, V6.H[0x7]
    FMLA S6, S7, V24.S[0x0]
    MUL  V14.8H, V21.8H, V14.H[0x0]
    MLA  V21.2S, V21.2S, V0.S[0x1]
    SQRDMULH  S23, S17, S25
    SQRDMULH H2, H24, V5.H[0x2]
    MUL  V14.2S, V31.2S, V13.S[0x0]
    FMULX V20.2D, V6.2D, V27.D[0x1]
    MLA  V7.4H, V3.4H, V0.H[0x5]
    UMULL V18.2D, V30.2S, V7.S[0x3]
    FMLA V7.2D, V18.2D, V29.D[0x1]
    UMULL V26.2D, V8.2S, V29.S[0x2]
    FMUL V7.4S, V13.4S, V7.S[0x2]
    UMULL2 V30.4S, V29.8H, V12.H[0x1]
    FMULX D16, D25, V2.D[0x1]
    MLA  V26.2S, V11.2S, V10.S[0x2]
    SQRDMULH  H8, H31, H13
    MUL  V30.4S, V29.4S, V9.S[0x0]
    FMULX S27, S6, V28.S[0x0]
    FMLS D23, D20, V10.D[0x1]
    MLA  V6.2S, V26.2S, V30.S[0x1]
    SQRDMULH  V2.2S, V12.2S, V27.S[0x0]
    FMLA S19, S30, V23.S[0x1]
    FMLS S11, S11, V20.S[0x2]
    FMULX S25, S27, V17.S[0x3]
    SQRDMULH S16, S7, V30.S[0x1]
    UMULL V29.4S, V28.4H, V5.H[0x3]
    MLA  V16.8H, V16.8H, V6.H[0x4]
    FMULX S30, S12, V27.S[0x3]
    FMUL S8, S14, V12.S[0x0]
    FMUL S6, S16, V28.S[0x0]
    FMULX S28, S31, V7.S[0x3]
    FMUL V25.2D, V5.2D, V10.D[0x1]
    FMLS S12, S29, V5.S[0x1]
    FMULX V17.2S, V0.2S, V19.S[0x1]
    MLA  V19.8H, V0.8H, V11.H[0x5]
    FMUL V12.2D, V2.2D, V28.D[0x1]
    FMLA V15.4S, V15.4S, V20.S[0x3]
    FMULX D25, D23, V4.D[0x1]
    FMUL V18.2D, V28.2D, V3.D[0x0]
    FMLS V3.2D, V9.2D, V0.D[0x1]
    MLS  V22.4S, V24.4S, V23.S[0x0]
    SQRDMULH  V28.2S, V24.2S, V22.S[0x3]
    FMLS S5, S15, V11.S[0x1]
    FMULX V5.2S, V12.2S, V4.S[0x2]
    UMULL2 V9.2D, V17.4S, V23.S[0x2]
    FMLS D31, D26, V28.D[0x1]
    FMULX S3, S21, V18.S[0x3]
    UMULL2 V11.2D, V22.4S, V4.S[0x3]
    UMULL2 V9.4S, V6.8H, V7.H[0x7]
    MLS  V31.8H, V28.8H, V15.H[0x6]
    MUL  V7.4S, V20.4S, V17.S[0x1]
    FMUL D19, D26, V26.D[0x0]
    FMUL V26.4S, V21.4S, V7.S[0x1]
    SQRDMULH  S7, S7, S18
    UMULL V7.2D, V13.2S, V24.S[0x0]
    FMUL V7.2D, V1.2D, V4.D[0x1]
    FMLA V29.2D, V25.2D, V21.D[0x1]
    MUL  V15.8H, V29.8H, V2.H[0x1]
    FMUL D3, D25, V23.D[0x0]
    FMLA D3, D19, V9.D[0x1]
    MUL  V28.4S, V2.4S, V2.S[0x0]
    FMLA V18.2D, V19.2D, V3.D[0x1]
    FMLA D15, D8, V11.D[0x1]
    FMUL D13, D31, V15.D[0x1]
    SQRDMULH  V11.4H, V9.4H, V7.H[0x5]
    FMLA D2, D7, V1.D[0x0]
    MLS  V28.8H, V26.8H, V11.H[0x4]
    SQRDMULH  S10, S30, S18
    FMLA V9.2S, V0.2S, V28.S[0x1]
    MLS  V15.4S, V19.4S, V30.S[0x0]
    FMLS V13.2D, V15.2D, V2.D[0x0]
    SQRDMULH  V20.4H, V4.4H, V4.H[0x1]
    FMLA V11.2D, V26.2D, V7.D[0x0]
    MUL  V15.4S, V16.4S, V13.S[0x0]
    FMUL V11.4S, V20.4S, V0.S[0x0]
    SQRDMULH  S1, S25, S10
    SQRDMULH H0, H28, V9.H[0x4]
    UMULL V23.4S, V30.4H, V3.H[0x0]
    FMLA V18.4S, V22.4S, V11.S[0x1]
    FMLA D15, D22, V0.D[0x1]
    SQRDMULH  H26, H11, H30
    SQRDMULH  V22.4S, V13.4S, V0.S[0x1]
    MLS  V22.4S, V6.4S, V29.S[0x2]
    FMUL V27.4S, V29.4S, V15.S[0x2]
    SQRDMULH  S7, S26, S1
    MLA  V9.4H, V8.4H, V4.H[0x1]
    MLA  V4.2S, V6.2S, V22.S[0x3]
    FMLA D8, D30, V31.D[0x0]
    SQRDMULH S1, S13, V15.S[0x2]
    MLS  V11.4S, V6.4S, V23.S[0x2]
    SQRDMULH  H31, H16, H9
    FMUL V9.2D, V9.2D, V24.D[0x1]
    FMULX V2.2D, V16.2D, V13.D[0x1]
    SQRDMULH H24, H8, V12.H[0x1]
    FMLS V25.2D, V12.2D, V14.D[0x0]
    FMLA D30, D22, V14.D[0x0]
    UMULL2 V21.4S, V13.8H, V5.H[0x0]
    FMLA V3.2D, V23.2D, V23.D[0x0]
    UMULL2 V19.2D, V2.4S, V9.S[0x1]
    MUL  V28.8H, V13.8H, V2.H[0x7]
    UMULL2 V29.2D, V6.4S, V21.S[0x0]
    MUL  V29.4S, V23.4S, V27.S[0x1]
    MLA  V18.4S, V30.4S, V26.S[0x1]
    SQRDMULH H12, H23, V14.H[0x7]
    FMLS V2.2S, V29.2S, V0.S[0x2]
    MLS  V10.8H, V27.8H, V14.H[0x3]
    MLA  V3.4S, V9.4S, V23.S[0x2]
    FMULX S18, S23, V17.S[0x2]
    MLA  V23.2S, V20.2S, V18.S[0x0]
    SQRDMULH  V20.4S, V29.4S, V24.S[0x0]
    SQRDMULH  V20.2S, V1.2S, V27.2S
    FMUL S21, S28, V28.S[0x2]
    MLA  V21.4H, V23.4H, V11.H[0x2]
    FMLA D25, D24, V23.D[0x1]
TaishanSimdWideNarryArthemticP01_label_1368:
    SQRDMULH  V0.4H, V12.4H, V1.H[0x1]
    MLA  V28.4S, V2.4S, V1.S[0x1]
    FMUL S28, S0, V10.S[0x0]
    FMLS V30.2D, V28.2D, V26.D[0x1]
    MLA  V2.2S, V25.2S, V13.S[0x1]
    FMULX V24.2D, V28.2D, V10.D[0x1]
    FMULX V22.2D, V0.2D, V18.D[0x1]
    UMULL V19.2D, V1.2S, V26.S[0x1]
    FMUL D6, D20, V9.D[0x0]
    FMULX V22.2D, V18.2D, V6.D[0x0]
    SQRDMULH  V29.4H, V22.4H, V11.H[0x7]
    SQRDMULH S17, S16, V0.S[0x0]
    SQRDMULH  V13.8H, V8.8H, V3.H[0x2]
    FMLA D23, D21, V1.D[0x1]
    FMLS V13.2D, V31.2D, V25.D[0x0]
    FMLA S19, S12, V19.S[0x0]
    FMLS V29.2D, V17.2D, V23.D[0x0]
    SQRDMULH  V31.4H, V18.4H, V1.H[0x0]
    FMULX D29, D4, V19.D[0x0]
    UMULL V9.4S, V13.4H, V8.H[0x5]
    UMULL2 V21.4S, V25.8H, V11.H[0x6]
    UMULL2 V1.2D, V22.4S, V6.S[0x3]
    SQRDMULH  V31.4S, V18.4S, V24.S[0x2]
    SQRDMULH  S27, S9, S18
    SQRDMULH S3, S28, V0.S[0x0]
    FMLA V2.2D, V3.2D, V1.D[0x1]
    SQRDMULH  S30, S11, S23
    MUL  V31.8H, V10.8H, V11.H[0x4]
    MLA  V21.2S, V18.2S, V4.S[0x2]
    MLS  V9.2S, V13.2S, V17.S[0x2]
    SQRDMULH  V4.2S, V7.2S, V6.2S
    FMLS S2, S0, V10.S[0x0]
    FMULX V22.2D, V18.2D, V24.D[0x1]
    FMLA S27, S29, V10.S[0x1]
    FMLS V18.2D, V8.2D, V2.D[0x0]
    UMULL V2.2D, V21.2S, V5.S[0x3]
    SQRDMULH  V26.4S, V17.4S, V23.S[0x0]
    FMLS S0, S8, V24.S[0x2]
    SUBS  X12, X12, #0x1
    B.NE  TaishanSimdWideNarryArthemticP01_label_1476
    MOVZ  X13, #0x2e03, LSL #0
    MOVK  X13, #0x2f0f, LSL #16
    MOVK  X13, #0xe087, LSL #32
    MOVK  X13, #0x4395, LSL #48
    SUB  X11, X13, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X10, #0xb470, LSL #0
    MOVK  X10, #0x6f0d, LSL #16
    MOVK  X10, #0xfe4a, LSL #32
    MOVK  X10, #0x2859, LSL #48
    SUB  X24, X10, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X3, #0xf27b, LSL #0
    MOVK  X3, #0x4491, LSL #16
    MOVK  X3, #0xbb21, LSL #32
    MOVK  X3, #0x731, LSL #48
    SUB  X21, X3, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X12, #0x9383, LSL #0
    MOVK  X12, #0xe0b2, LSL #16
    MOVK  X12, #0x74a3, LSL #32
    MOVK  X12, #0xe406, LSL #48
    SUB  X3, X12, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X2, #0xf7f4, LSL #0
    MOVK  X2, #0x2447, LSL #16
    MOVK  X2, #0x213e, LSL #32
    MOVK  X2, #0xed2c, LSL #48
    SUB  X23, X2, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X21, #0x8c6b, LSL #0
    MOVK  X21, #0x9932, LSL #16
    MOVK  X21, #0xd643, LSL #32
    MOVK  X21, #0xf347, LSL #48
    SUB  X27, X21, X7
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X15, #0x72f, LSL #0
    MOVK  X15, #0x10f2, LSL #16
    MOVK  X15, #0x278f, LSL #32
    MOVK  X15, #0xa573, LSL #48
    SUB  X8, X15, X8
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X19, #0xb9bf, LSL #0
    MOVK  X19, #0x532c, LSL #16
    MOVK  X19, #0xd2d4, LSL #32
    MOVK  X19, #0xd951, LSL #48
    SUB  X12, X19, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X24, #0xb470, LSL #0
    MOVK  X24, #0x6f0d, LSL #16
    MOVK  X24, #0xfe4a, LSL #32
    MOVK  X24, #0x2859, LSL #48
    SUB  X21, X24, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X4, #0x2e03, LSL #0
    MOVK  X4, #0x2f0f, LSL #16
    MOVK  X4, #0xe087, LSL #32
    MOVK  X4, #0x4395, LSL #48
    SUB  X2, X4, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X11, #0x2773, LSL #0
    MOVK  X11, #0x2fae, LSL #16
    MOVK  X11, #0xd010, LSL #32
    MOVK  X11, #0x9407, LSL #48
    SUB  X12, X11, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X16, X14, X16
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X13, #0x8285, LSL #0
    MOVK  X13, #0x8417, LSL #16
    MOVK  X13, #0x8410, LSL #32
    MOVK  X13, #0x8f47, LSL #48
    SUB  X16, X13, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X23, #0x3d37, LSL #0
    MOVK  X23, #0x9622, LSL #16
    MOVK  X23, #0x8d0f, LSL #32
    MOVK  X23, #0x71ec, LSL #48
    SUB  X21, X23, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X10, #0xb9bf, LSL #0
    MOVK  X10, #0x532c, LSL #16
    MOVK  X10, #0xd2d4, LSL #32
    MOVK  X10, #0xd951, LSL #48
    SUB  X9, X10, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X20, #0xc84c, LSL #0
    MOVK  X20, #0xb521, LSL #16
    MOVK  X20, #0x2af1, LSL #32
    MOVK  X20, #0xd827, LSL #48
    SUB  X22, X20, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X26, X19, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X7, #0x3d37, LSL #0
    MOVK  X7, #0x9622, LSL #16
    MOVK  X7, #0x8d0f, LSL #32
    MOVK  X7, #0x71ec, LSL #48
    SUB  X9, X7, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X15, #0xb470, LSL #0
    MOVK  X15, #0x6f0d, LSL #16
    MOVK  X15, #0xfe4a, LSL #32
    MOVK  X15, #0x2859, LSL #48
    SUB  X26, X15, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X17, #0x77f4, LSL #0
    MOVK  X17, #0x24c3, LSL #16
    MOVK  X17, #0x851f, LSL #32
    MOVK  X17, #0xec8c, LSL #48
    SUB  X20, X17, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X21, #0x208b, LSL #0
    MOVK  X21, #0x8def, LSL #16
    MOVK  X21, #0x1e86, LSL #32
    MOVK  X21, #0x1889, LSL #48
TaishanSimdWideNarryArthemticP01_label_736:
    SUB  X26, X21, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, D2
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X11, D3
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X9, X29, X24
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, D4
    MOVZ  X29, #0x0, LSL #0
    SUB  X9, X29, X24
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, D5
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, V6.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, D6
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #48
    SUB  X28, X11, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, V7.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X15
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, D7
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X15
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, D8
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x8000, LSL #48
    SUB  X7, X6, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, D9
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, D10
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, V11.D[1]
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x8000, LSL #16
    MOVK  X23, #0x8000, LSL #48
    SUB  X18, X23, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, D11
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x8000, LSL #16
    MOVK  X23, #0x8000, LSL #48
    SUB  X18, X23, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, D12
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, D13
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, D14
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X10, X24, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, D15
    MOVZ  X24, #0x0, LSL #0
    SUB  X10, X24, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, V16.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X5
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, D16
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X5
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X27, X19, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, D17
    MOVZ  X19, #0x0, LSL #0
    SUB  X27, X19, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x8000, LSL #48
    SUB  X21, X27, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, D18
    MOVZ  X27, #0x0, LSL #0
    SUB  X21, X27, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, D19
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, V20.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X7, X26, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, D20
    MOVZ  X26, #0x0, LSL #0
    SUB  X7, X26, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, D21
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X19, X12, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D22
    MOVZ  X12, #0x0, LSL #0
    SUB  X19, X12, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, D23
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, D24
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, D26
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X11, X3, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D27
    MOVZ  X3, #0x0, LSL #0
    SUB  X11, X3, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, D28
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X6, D29
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
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
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X20
    FMOV  V0.D[1], X20
    FMOV  D1, X24
    FMOV  V1.D[1], X19
    FMOV  D2, X15
    FMOV  V2.D[1], X19
    FMOV  D3, X8
    FMOV  V3.D[1], X23
    FMOV  D4, X29
    FMOV  V4.D[1], X8
    FMOV  D5, X24
    FMOV  V5.D[1], X9
    FMOV  D6, X23
    FMOV  V6.D[1], X28
    FMOV  D7, X24
    FMOV  V7.D[1], X12
    FMOV  D8, X19
    FMOV  V8.D[1], X26
    FMOV  D9, X24
    FMOV  V9.D[1], X17
    FMOV  D10, X5
    FMOV  V10.D[1], X13
    FMOV  D11, X17
    FMOV  V11.D[1], X27
    FMOV  D12, X26
    FMOV  V12.D[1], X5
    FMOV  D13, X8
    FMOV  V13.D[1], X28
    FMOV  D14, X13
    FMOV  V14.D[1], X16
    FMOV  D15, X14
    FMOV  V15.D[1], X8
    FMOV  D16, X11
    FMOV  V16.D[1], X14
    FMOV  D17, X24
    FMOV  V17.D[1], X24
    FMOV  D18, X8
    FMOV  V18.D[1], X2
    FMOV  D19, X3
    FMOV  V19.D[1], X26
    FMOV  D20, X29
    FMOV  V20.D[1], X24
    FMOV  D21, X19
    FMOV  V21.D[1], X17
    FMOV  D22, X14
    FMOV  V22.D[1], X27
    FMOV  D23, X17
    FMOV  V23.D[1], X12
    FMOV  D24, X8
    FMOV  V24.D[1], X2
    FMOV  D25, X3
    FMOV  V25.D[1], X20
    FMOV  D26, X13
    FMOV  V26.D[1], X29
    FMOV  D27, X24
    FMOV  V27.D[1], X15
    FMOV  D28, X10
    FMOV  V28.D[1], X24
    FMOV  D29, X3
    FMOV  V29.D[1], X22
    FMOV  D30, X14
    FMOV  V30.D[1], X13
    FMOV  D31, X27
    FMOV  V31.D[1], X13
    MOVZ  X23, #0xa, LSL #0
TaishanSimdWideNarryArthemticP01_label_1555:
    SQRDMULH  H25, H12, H17
    UMULL V18.4S, V25.4H, V9.H[0x4]
    FMLA D20, D31, V7.D[0x0]
    FMUL S17, S29, V3.S[0x1]
    SQRDMULH  H20, H31, H13
    UMULL V20.4S, V27.4H, V6.H[0x3]
    UMULL V17.4S, V12.4H, V1.H[0x0]
    SQRDMULH S1, S28, V6.S[0x1]
    MLS  V14.8H, V12.8H, V12.H[0x3]
    MLA  V12.4H, V18.4H, V1.H[0x0]
    FMULX D23, D20, V20.D[0x1]
    MUL  V14.2S, V17.2S, V9.S[0x0]
    SQRDMULH S4, S7, V27.S[0x1]
    UMULL2 V24.2D, V23.4S, V30.S[0x1]
    FMUL V24.2D, V7.2D, V3.D[0x1]
    FMLS V24.4S, V18.4S, V12.S[0x3]
    UMULL2 V9.2D, V24.4S, V10.S[0x0]
    FMUL V24.4S, V9.4S, V10.S[0x0]
    FMLS V24.2D, V12.2D, V19.D[0x0]
    FMUL V8.4S, V24.4S, V14.S[0x2]
    FMULX V1.2D, V4.2D, V23.D[0x0]
    FMLS D11, D11, V6.D[0x0]
    FMLA D22, D23, V11.D[0x1]
    SQRDMULH  V22.2S, V11.2S, V21.S[0x2]
    UMULL2 V19.2D, V25.4S, V20.S[0x0]
    FMLA D1, D1, V1.D[0x1]
    MLS  V12.4H, V20.4H, V1.H[0x6]
    MLA  V1.2S, V29.2S, V6.S[0x3]
    FMULX V14.2S, V11.2S, V0.S[0x1]
    FMLS S3, S5, V19.S[0x0]
    MUL  V23.2S, V6.2S, V28.S[0x3]
    FMLA S4, S18, V31.S[0x3]
    FMLA V2.2S, V18.2S, V11.S[0x1]
    SQRDMULH  S8, S0, S15
    MLS  V28.4S, V0.4S, V1.S[0x3]
    UMULL V17.2D, V23.2S, V20.S[0x1]
    MLS  V15.2S, V29.2S, V1.S[0x3]
    SQRDMULH S28, S3, V9.S[0x0]
    FMLS D27, D2, V13.D[0x1]
    MUL  V29.2S, V12.2S, V13.S[0x0]
    FMLA V15.2D, V0.2D, V31.D[0x1]
    SQRDMULH  S30, S27, S30
    FMLA D12, D16, V5.D[0x1]
    FMLA S4, S10, V25.S[0x1]
    MLA  V25.4H, V23.4H, V7.H[0x4]
    FMUL V0.2D, V24.2D, V25.D[0x0]
    MLA  V1.8H, V31.8H, V12.H[0x4]
    MUL  V27.4H, V31.4H, V0.H[0x0]
    SQRDMULH  S19, S17, S22
    FMUL V15.2S, V16.2S, V4.S[0x3]
    MLS  V22.4H, V3.4H, V0.H[0x5]
    SQRDMULH  H19, H23, H11
    FMLS V23.4S, V10.4S, V13.S[0x3]
    MUL  V10.8H, V3.8H, V12.H[0x7]
    FMULX S17, S7, V5.S[0x2]
    UMULL2 V14.4S, V9.8H, V15.H[0x3]
    SQRDMULH  H2, H5, H2
    FMLS D12, D5, V9.D[0x0]
    FMUL V6.4S, V14.4S, V2.S[0x1]
    SQRDMULH H16, H19, V11.H[0x5]
    FMLS V25.2D, V12.2D, V4.D[0x0]
    FMULX V23.2D, V30.2D, V14.D[0x0]
    MUL  V4.4S, V15.4S, V29.S[0x2]
    FMUL D31, D20, V5.D[0x1]
    FMULX D30, D13, V31.D[0x1]
    SQRDMULH H23, H20, V11.H[0x5]
    FMUL D22, D18, V27.D[0x1]
    MUL  V20.2S, V7.2S, V26.S[0x1]
    FMULX D7, D2, V0.D[0x1]
    MUL  V19.4H, V22.4H, V10.H[0x4]
    FMLS V6.2D, V26.2D, V3.D[0x0]
    UMULL V29.4S, V14.4H, V3.H[0x6]
    FMUL V23.2D, V13.2D, V29.D[0x1]
    FMLA V24.2D, V9.2D, V20.D[0x1]
    FMLS V7.2D, V25.2D, V16.D[0x1]
    FMLS S12, S13, V31.S[0x3]
    SQRDMULH  V28.4H, V12.4H, V4.H[0x1]
    MUL  V25.8H, V15.8H, V9.H[0x6]
    FMULX V16.4S, V27.4S, V24.S[0x3]
    FMLA V18.2D, V5.2D, V12.D[0x0]
    FMULX V20.2D, V18.2D, V13.D[0x1]
    UMULL V6.4S, V10.4H, V7.H[0x2]
    FMUL V15.2D, V17.2D, V9.D[0x0]
    FMLS V25.2D, V14.2D, V6.D[0x1]
    SQRDMULH  V23.4H, V31.4H, V30.4H
    FMULX V29.4S, V7.4S, V23.S[0x3]
    SQRDMULH S6, S20, V19.S[0x1]
    SQRDMULH  V0.8H, V20.8H, V14.H[0x6]
    FMLA V16.4S, V23.4S, V2.S[0x1]
    FMLS D22, D28, V7.D[0x1]
    FMLS S29, S23, V12.S[0x3]
    FMULX V1.2D, V6.2D, V29.D[0x0]
    FMLA V5.4S, V5.4S, V28.S[0x2]
    SQRDMULH H11, H30, V15.H[0x6]
    FMUL S3, S15, V25.S[0x2]
    FMLA S30, S15, V0.S[0x2]
    MUL  V3.2S, V2.2S, V25.S[0x3]
    FMLA D1, D6, V13.D[0x1]
    UMULL2 V9.2D, V21.4S, V19.S[0x2]
    MLS  V28.8H, V10.8H, V9.H[0x3]
    MUL  V18.4H, V26.4H, V5.H[0x5]
    FMUL S11, S29, V16.S[0x0]
    FMULX D25, D14, V3.D[0x0]
    UMULL2 V23.2D, V22.4S, V11.S[0x0]
    MLA  V9.4H, V31.4H, V14.H[0x3]
    FMULX V11.2S, V8.2S, V12.S[0x1]
    UMULL2 V8.4S, V8.8H, V15.H[0x1]
    SQRDMULH  H16, H10, H2
    FMLA S25, S10, V18.S[0x1]
    UMULL V23.2D, V31.2S, V5.S[0x3]
    FMULX D0, D0, V20.D[0x1]
    SQRDMULH H27, H6, V2.H[0x0]
    SQRDMULH  H11, H29, H15
    FMLS S1, S11, V27.S[0x3]
    UMULL2 V5.4S, V31.8H, V6.H[0x3]
    FMLA V30.2D, V30.2D, V16.D[0x0]
    UMULL V3.4S, V28.4H, V3.H[0x4]
    FMLA D13, D1, V16.D[0x1]
    FMLS V30.4S, V27.4S, V9.S[0x3]
    MLS  V27.8H, V13.8H, V9.H[0x6]
    FMUL V31.2D, V16.2D, V25.D[0x0]
    UMULL2 V31.2D, V26.4S, V11.S[0x3]
    MLS  V25.4S, V19.4S, V14.S[0x1]
    UMULL2 V4.4S, V4.8H, V1.H[0x6]
    UMULL V20.4S, V12.4H, V2.H[0x5]
    UMULL2 V4.4S, V3.8H, V10.H[0x3]
    SQRDMULH  V27.2S, V1.2S, V29.S[0x0]
    FMULX V14.2D, V29.2D, V28.D[0x1]
    UMULL V27.4S, V7.4H, V1.H[0x6]
    SQRDMULH H10, H14, V5.H[0x3]
    SQRDMULH  V9.2S, V25.2S, V4.S[0x0]
    UMULL V14.4S, V5.4H, V13.H[0x1]
    UMULL V2.4S, V29.4H, V14.H[0x6]
    FMLS D11, D27, V26.D[0x0]
    SQRDMULH H21, H10, V7.H[0x1]
    FMULX S30, S15, V2.S[0x2]
    FMLA S7, S29, V6.S[0x2]
    FMLA V16.2S, V26.2S, V29.S[0x2]
    SQRDMULH  V31.4H, V19.4H, V19.4H
    FMLS V24.2S, V22.2S, V14.S[0x2]
    SQRDMULH  V19.4S, V19.4S, V5.4S
    SQRDMULH  H7, H13, H12
    SQRDMULH S22, S6, V11.S[0x0]
    MUL  V26.8H, V11.8H, V13.H[0x6]
    FMULX V24.2D, V28.2D, V20.D[0x1]
    FMLS V13.2D, V3.2D, V30.D[0x0]
    MLS  V3.4S, V24.4S, V24.S[0x1]
    UMULL2 V9.2D, V5.4S, V28.S[0x2]
    SQRDMULH  V30.4H, V31.4H, V14.H[0x7]
    FMUL D24, D1, V12.D[0x1]
    SQRDMULH H13, H16, V6.H[0x2]
    FMULX V26.2D, V25.2D, V8.D[0x1]
    SQRDMULH  V10.4S, V14.4S, V29.4S
    SQRDMULH  V9.2S, V13.2S, V21.S[0x2]
    FMLS D10, D4, V2.D[0x1]
    UMULL2 V10.4S, V10.8H, V14.H[0x2]
    MLA  V5.4H, V4.4H, V9.H[0x0]
    SQRDMULH S24, S10, V5.S[0x3]
    UMULL2 V6.4S, V29.8H, V2.H[0x3]
    FMULX S20, S15, V12.S[0x2]
    MLA  V8.4H, V14.4H, V6.H[0x1]
    SQRDMULH  V23.4S, V3.4S, V20.S[0x3]
    UMULL V15.4S, V14.4H, V11.H[0x3]
    SQRDMULH  V9.8H, V14.8H, V3.H[0x5]
    FMULX S27, S16, V16.S[0x0]
    FMULX V26.2S, V11.2S, V25.S[0x2]
    FMULX S5, S23, V6.S[0x2]
    FMLS V8.2S, V25.2S, V24.S[0x3]
    MLS  V9.2S, V30.2S, V19.S[0x2]
    FMULX V8.2D, V6.2D, V11.D[0x0]
    FMLA V19.2D, V30.2D, V26.D[0x0]
    UMULL2 V30.2D, V15.4S, V31.S[0x2]
    UMULL2 V2.2D, V6.4S, V11.S[0x2]
    FMUL V28.2S, V14.2S, V17.S[0x0]
    MUL  V11.4H, V19.4H, V6.H[0x1]
    SQRDMULH H23, H23, V11.H[0x7]
    UMULL2 V30.4S, V8.8H, V3.H[0x7]
    MLS  V27.8H, V30.8H, V15.H[0x1]
    FMLA D27, D27, V8.D[0x0]
    MLS  V17.8H, V2.8H, V3.H[0x4]
    MUL  V4.8H, V23.8H, V4.H[0x2]
    FMULX V11.2D, V19.2D, V18.D[0x0]
    SQRDMULH  V29.4H, V14.4H, V15.H[0x6]
    SQRDMULH  V23.2S, V5.2S, V14.S[0x1]
    SQRDMULH  S26, S12, S10
    SQRDMULH  S29, S27, S9
    MUL  V15.2S, V4.2S, V8.S[0x3]
    MUL  V7.8H, V19.8H, V14.H[0x6]
    FMLS V27.2D, V11.2D, V1.D[0x1]
    FMLS S31, S20, V16.S[0x0]
    MLS  V4.4S, V8.4S, V24.S[0x0]
    FMUL S31, S31, V3.S[0x0]
    UMULL2 V3.4S, V24.8H, V12.H[0x4]
    FMULX V17.2D, V10.2D, V27.D[0x1]
    FMULX V5.2D, V19.2D, V17.D[0x1]
    FMLA V2.2D, V4.2D, V10.D[0x1]
    MUL  V14.4S, V18.4S, V29.S[0x1]
    SQRDMULH  V29.4H, V17.4H, V23.4H
    FMLA V4.2D, V9.2D, V29.D[0x0]
    FMLA D1, D2, V26.D[0x1]
    SUBS  X23, X23, #0x1
    B.NE  TaishanSimdWideNarryArthemticP01_label_1555
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X10, X28, X10
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X14
TaishanSimdWideNarryArthemticP01_label_1006:
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X6, X29, X15
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X20, X13, X20
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X21
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X21, X14, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X24
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X29
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, V2.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, D2
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X16, D3
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, D4
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x8000, LSL #48
    SUB  X9, X20, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, D5
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x8000, LSL #48
    SUB  X9, X20, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, D6
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X26, D7
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x8000, LSL #48
    SUB  X21, X3, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, D8
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x8000, LSL #48
    SUB  X21, X3, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, V9.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, D9
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, D10
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x8000, LSL #48
    SUB  X18, X23, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, D11
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x8000, LSL #48
    SUB  X18, X23, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, V12.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, D12
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #16
    SUB  X11, X4, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X9, X24, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, D13
    MOVZ  X24, #0x0, LSL #0
    SUB  X9, X24, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, D14
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X24, X9, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, D15
    MOVZ  X9, #0x0, LSL #0
    SUB  X24, X9, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, V16.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X7, X26, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, D16
    MOVZ  X26, #0x0, LSL #0
    SUB  X7, X26, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X8, D17
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X2, D18
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x8000, LSL #48
    SUB  X17, X7, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, D19
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x8000, LSL #48
    SUB  X17, X7, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X11, X3, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, D20
    MOVZ  X3, #0x0, LSL #0
    SUB  X11, X3, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X18
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, D21
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X18
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X10
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, D22
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X10
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X3, D23
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D24
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X28, D26
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, V27.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, D27
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8000, LSL #48
    SUB  X22, X28, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X6, D28
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X18, D29
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
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
    FMOV  V0.D[1], X2
    FMOV  D1, X16
    FMOV  V1.D[1], X2
    FMOV  D2, X20
    FMOV  V2.D[1], X29
    FMOV  D3, X29
    FMOV  V3.D[1], X2
    FMOV  D4, X6
    FMOV  V4.D[1], X12
    FMOV  D5, X7
    FMOV  V5.D[1], X9
    FMOV  D6, X29
    FMOV  V6.D[1], X8
    FMOV  D7, X28
    FMOV  V7.D[1], X19
    FMOV  D8, X11
    FMOV  V8.D[1], X14
    FMOV  D9, X20
    FMOV  V9.D[1], X22
    FMOV  D10, X3
    FMOV  V10.D[1], X28
    FMOV  D11, X19
    FMOV  V11.D[1], X9
    FMOV  D12, X19
    FMOV  V12.D[1], X7
    FMOV  D13, X7
    FMOV  V13.D[1], X18
    FMOV  D14, X4
    FMOV  V14.D[1], X12
    FMOV  D15, X24
    FMOV  V15.D[1], X29
    FMOV  D16, X7
    FMOV  V16.D[1], X23
    FMOV  D17, X13
    FMOV  V17.D[1], X28
    FMOV  D18, X8
    FMOV  V18.D[1], X17
    FMOV  D19, X6
    FMOV  V19.D[1], X15
    FMOV  D20, X15
    FMOV  V20.D[1], X27
    FMOV  D21, X13
    FMOV  V21.D[1], X13
    FMOV  D22, X19
    FMOV  V22.D[1], X28
    FMOV  D23, X2
    FMOV  V23.D[1], X11
    FMOV  D24, X20
    FMOV  V24.D[1], X29
    FMOV  D25, X28
    FMOV  V25.D[1], X20
    FMOV  D26, X23
    FMOV  V26.D[1], X27
    FMOV  D27, X7
    FMOV  V27.D[1], X3
    FMOV  D28, X10
    FMOV  V28.D[1], X12
    FMOV  D29, X6
    FMOV  V29.D[1], X2
    FMOV  D30, X7
    FMOV  V30.D[1], X3
    FMOV  D31, X16
    FMOV  V31.D[1], X13
    MOVZ  X17, #0xf, LSL #0
TaishanSimdWideNarryArthemticP01_label_1633:
    FMUL V20.4S, V6.4S, V22.S[0x3]
    FMULX V10.2S, V19.2S, V16.S[0x1]
    UMULL2 V31.4S, V16.8H, V10.H[0x7]
    MLA  V28.4H, V3.4H, V9.H[0x3]
    SQRDMULH S3, S23, V2.S[0x2]
    SQRDMULH  V24.8H, V5.8H, V13.H[0x3]
    UMULL V12.4S, V0.4H, V0.H[0x0]
    UMULL V26.4S, V2.4H, V11.H[0x3]
    FMLA V22.2D, V23.2D, V18.D[0x1]
    SQRDMULH H31, H1, V7.H[0x1]
    UMULL2 V18.4S, V1.8H, V5.H[0x5]
    SQRDMULH  V3.8H, V15.8H, V8.H[0x0]
    FMLS S12, S2, V17.S[0x0]
TaishanSimdWideNarryArthemticP01_label_170:
    FMUL V14.2D, V2.2D, V3.D[0x0]
    FMLA V26.2S, V23.2S, V7.S[0x1]
    SQRDMULH H21, H7, V11.H[0x4]
    FMULX D18, D16, V8.D[0x0]
    FMUL V24.2D, V29.2D, V14.D[0x0]
    FMUL V8.2D, V21.2D, V22.D[0x1]
    UMULL2 V10.2D, V31.4S, V15.S[0x1]
    SQRDMULH  V30.4S, V9.4S, V24.4S
    FMUL D0, D18, V28.D[0x0]
    SQRDMULH  S14, S12, S7
    FMLA S1, S22, V1.S[0x3]
    FMLA D1, D6, V14.D[0x1]
    UMULL2 V23.4S, V13.8H, V4.H[0x4]
    FMUL V13.4S, V24.4S, V18.S[0x1]
    FMUL S24, S20, V16.S[0x2]
    MUL  V14.4S, V10.4S, V29.S[0x2]
    SQRDMULH  H27, H8, H25
    FMLA S22, S19, V0.S[0x1]
    FMULX D22, D17, V16.D[0x0]
    FMULX V10.4S, V27.4S, V30.S[0x3]
    FMLS V1.2D, V11.2D, V10.D[0x1]
    FMULX V23.2S, V16.2S, V14.S[0x1]
    FMLS V15.4S, V11.4S, V22.S[0x0]
    UMULL V24.2D, V30.2S, V22.S[0x0]
    FMUL S8, S20, V13.S[0x1]
    FMUL S16, S8, V1.S[0x1]
    SQRDMULH S22, S31, V18.S[0x3]
    FMUL V18.2D, V7.2D, V9.D[0x1]
    FMULX D17, D13, V16.D[0x0]
    FMUL D18, D2, V30.D[0x1]
    UMULL2 V31.4S, V2.8H, V13.H[0x2]
    SQRDMULH S22, S13, V17.S[0x0]
    FMULX V8.2D, V21.2D, V20.D[0x0]
    UMULL2 V23.2D, V6.4S, V18.S[0x0]
    MLS  V1.4H, V25.4H, V2.H[0x6]
    FMLS V11.2D, V9.2D, V14.D[0x1]
    MLS  V31.4S, V19.4S, V28.S[0x3]
    FMLA V17.2D, V30.2D, V10.D[0x1]
    SQRDMULH  V1.2S, V2.2S, V21.2S
    FMUL V28.2D, V5.2D, V19.D[0x0]
    FMLA S25, S17, V22.S[0x0]
    MLS  V29.4H, V29.4H, V8.H[0x0]
    FMLA V8.2D, V25.2D, V0.D[0x0]
    SQRDMULH  H11, H20, H18
    MUL  V6.8H, V1.8H, V8.H[0x4]
    SQRDMULH  S12, S6, S15
    FMLS D27, D6, V26.D[0x1]
    UMULL V23.4S, V16.4H, V12.H[0x7]
    UMULL V24.4S, V8.4H, V8.H[0x7]
    FMULX V23.2D, V13.2D, V22.D[0x1]
    FMUL V12.2D, V31.2D, V11.D[0x1]
    FMULX V17.2S, V10.2S, V17.S[0x2]
    FMLA D19, D24, V13.D[0x1]
    FMUL V21.4S, V10.4S, V8.S[0x1]
    SQRDMULH  V17.4S, V2.4S, V15.S[0x0]
    MLS  V18.4S, V25.4S, V25.S[0x2]
    FMLS V15.4S, V18.4S, V6.S[0x2]
    UMULL2 V18.2D, V22.4S, V25.S[0x0]
    UMULL2 V2.4S, V6.8H, V5.H[0x6]
    SQRDMULH S7, S20, V7.S[0x2]
    MLA  V28.2S, V21.2S, V20.S[0x1]
    MUL  V13.4S, V18.4S, V26.S[0x2]
    UMULL V8.2D, V1.2S, V23.S[0x1]
    FMLS V27.2D, V6.2D, V31.D[0x1]
    UMULL2 V19.2D, V26.4S, V15.S[0x3]
    FMULX V12.2S, V16.2S, V24.S[0x1]
    FMLA V31.2D, V4.2D, V16.D[0x1]
    SQRDMULH  V17.8H, V4.8H, V14.8H
    MLA  V13.4S, V19.4S, V24.S[0x1]
    MLA  V27.4S, V19.4S, V24.S[0x1]
    FMLA V17.2D, V21.2D, V4.D[0x1]
    SQRDMULH H20, H6, V12.H[0x5]
    UMULL2 V31.4S, V11.8H, V13.H[0x6]
    FMLA V11.2D, V17.2D, V10.D[0x0]
    FMLS D21, D14, V10.D[0x1]
    MUL  V17.2S, V31.2S, V26.S[0x2]
    FMLS D22, D1, V2.D[0x1]
    FMUL S25, S12, V6.S[0x1]
    MLA  V5.4H, V17.4H, V3.H[0x4]
    FMULX S29, S14, V5.S[0x1]
    FMLS D11, D5, V4.D[0x1]
    FMLS V20.4S, V24.4S, V29.S[0x1]
    UMULL V18.2D, V5.2S, V7.S[0x3]
    SQRDMULH H24, H26, V13.H[0x1]
    SQRDMULH S21, S28, V18.S[0x3]
    SQRDMULH  H22, H2, H27
    FMUL V3.2D, V4.2D, V8.D[0x1]
    SQRDMULH H23, H3, V7.H[0x1]
    UMULL2 V10.4S, V4.8H, V11.H[0x4]
    UMULL V22.2D, V19.2S, V31.S[0x0]
    MUL  V17.4H, V31.4H, V3.H[0x1]
    FMUL D17, D9, V7.D[0x1]
    FMLA D16, D19, V4.D[0x0]
    MUL  V5.4H, V25.4H, V14.H[0x3]
    UMULL2 V29.2D, V31.4S, V7.S[0x2]
    MLA  V19.8H, V21.8H, V15.H[0x7]
    FMUL S28, S28, V19.S[0x1]
    MUL  V5.4S, V23.4S, V21.S[0x3]
    FMULX V6.2D, V3.2D, V21.D[0x0]
    SQRDMULH S12, S9, V6.S[0x1]
    SQRDMULH  V9.8H, V4.8H, V12.H[0x3]
    UMULL V13.2D, V26.2S, V25.S[0x0]
    FMLS V25.4S, V28.4S, V0.S[0x3]
    FMUL D24, D19, V27.D[0x0]
    SQRDMULH  V18.8H, V20.8H, V4.H[0x0]
    FMULX V13.2S, V26.2S, V27.S[0x3]
    FMULX S22, S25, V9.S[0x0]
    MUL  V11.4H, V3.4H, V2.H[0x4]
    FMULX D11, D5, V31.D[0x1]
    FMUL V15.2D, V22.2D, V20.D[0x0]
    MLA  V15.4H, V31.4H, V10.H[0x5]
    MUL  V23.2S, V3.2S, V17.S[0x3]
    FMULX V31.2D, V22.2D, V12.D[0x0]
    FMLA D12, D24, V27.D[0x0]
    FMLA S22, S22, V22.S[0x0]
    FMLS V20.2S, V0.2S, V0.S[0x2]
    FMUL V13.2D, V25.2D, V0.D[0x0]
    SQRDMULH  V19.8H, V26.8H, V10.H[0x1]
    FMUL D2, D19, V25.D[0x0]
    FMULX S23, S3, V2.S[0x0]
    FMUL D25, D10, V25.D[0x1]
    SQRDMULH  V11.4S, V11.4S, V11.S[0x2]
    SQRDMULH  V14.8H, V1.8H, V12.H[0x2]
    UMULL V29.2D, V9.2S, V13.S[0x0]
    UMULL2 V15.4S, V12.8H, V12.H[0x1]
    FMLS V24.2D, V27.2D, V31.D[0x0]
    FMUL V26.2D, V8.2D, V24.D[0x1]
    SQRDMULH  V13.2S, V23.2S, V3.2S
    FMUL D28, D19, V8.D[0x1]
    SQRDMULH  V2.2S, V9.2S, V23.2S
    FMUL D30, D13, V25.D[0x1]
    SQRDMULH H15, H26, V13.H[0x3]
    FMLS V17.2D, V6.2D, V7.D[0x0]
    MUL  V17.4S, V24.4S, V11.S[0x3]
    FMULX V22.2D, V0.2D, V15.D[0x1]
    FMLA S15, S29, V23.S[0x0]
    FMLA V17.2S, V28.2S, V3.S[0x2]
    SQRDMULH  H24, H10, H8
    FMLA S24, S24, V24.S[0x3]
    FMULX V21.2S, V14.2S, V1.S[0x2]
    FMLA S14, S9, V24.S[0x3]
    SQRDMULH  H13, H11, H2
    SQRDMULH  H15, H26, H25
    SQRDMULH S0, S18, V8.S[0x2]
    SQRDMULH H20, H1, V0.H[0x2]
    SQRDMULH S15, S13, V30.S[0x0]
    UMULL V25.2D, V22.2S, V21.S[0x2]
    FMULX D2, D16, V17.D[0x0]
    FMLA D20, D15, V7.D[0x1]
    FMULX V14.4S, V12.4S, V3.S[0x3]
    SQRDMULH  H4, H17, H6
    FMUL D25, D6, V1.D[0x1]
    FMLA V28.2D, V20.2D, V16.D[0x0]
    FMLA V25.2D, V11.2D, V19.D[0x0]
    SQRDMULH  V13.4H, V29.4H, V12.H[0x4]
    SQRDMULH  V27.2S, V16.2S, V14.S[0x2]
    SQRDMULH S9, S1, V21.S[0x2]
    MLS  V22.4S, V25.4S, V19.S[0x3]
    FMULX D0, D26, V5.D[0x0]
    FMLA V28.4S, V0.4S, V28.S[0x1]
    UMULL V21.2D, V5.2S, V23.S[0x3]
    FMLA S15, S10, V12.S[0x3]
    FMLA D22, D27, V1.D[0x0]
    FMLA V27.2D, V10.2D, V19.D[0x0]
    MUL  V7.4H, V28.4H, V4.H[0x1]
    FMUL V2.2S, V26.2S, V3.S[0x2]
    SQRDMULH  V22.4H, V31.4H, V1.H[0x5]
    FMULX V13.2S, V6.2S, V17.S[0x2]
    FMLS V9.2S, V7.2S, V12.S[0x1]
    UMULL2 V4.4S, V7.8H, V9.H[0x4]
    SQRDMULH  H7, H2, H10
    FMLS D16, D16, V22.D[0x0]
    UMULL2 V20.2D, V8.4S, V27.S[0x1]
    FMLA D30, D19, V13.D[0x0]
    FMUL S4, S4, V15.S[0x2]
    FMLA V7.2D, V3.2D, V23.D[0x0]
    FMULX D1, D23, V16.D[0x1]
    FMUL S24, S31, V1.S[0x1]
    SQRDMULH H23, H13, V1.H[0x7]
    SQRDMULH  V5.8H, V6.8H, V6.H[0x0]
    SQRDMULH S11, S16, V23.S[0x2]
    FMLS D26, D28, V3.D[0x1]
    FMULX D9, D20, V7.D[0x0]
    SQRDMULH  V3.2S, V13.2S, V10.S[0x2]
    MUL  V7.2S, V14.2S, V1.S[0x1]
    FMLA V7.2D, V16.2D, V27.D[0x1]
    FMUL D31, D22, V10.D[0x0]
    SUBS  X17, X17, #0x1
    B.NE  TaishanSimdWideNarryArthemticP01_label_1633
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X15, X16, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X4, X26, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X10, X2, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X10, X26, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X5, X14, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X6, X11, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X20, X14, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X6, X26, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X23, X15, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X10, X24, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X14, X12, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X14, X7, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X15, X27, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X20
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X29, X9, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X14, X3, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X28, X11, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X14, X22, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X14, D2
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, V3.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X7, X10, X27
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, D3
    MOVZ  X10, #0x0, LSL #0
    SUB  X7, X10, X27
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, D4
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
TaishanSimdWideNarryArthemticP01_label_1535:
    FMOV  X10, D5
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X23, D6
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X24, D7
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, D8
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, V9.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, D9
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X22, D10
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, D11
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X4, D12
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X7, D13
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X12, D14
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, D15
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X15, D16
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x8000, LSL #16
    SUB  X9, X10, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X5, D17
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X20, X13, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X29, D18
    MOVZ  X13, #0x0, LSL #0
    SUB  X20, X13, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, D19
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, D20
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, V21.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X19, D21
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X20, D22
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X9, D23
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, D24
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X6, D26
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #48
    SUB  X17, X11, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X13, D27
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X21, D28
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail
    FMOV  X27, D29
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdWideNarryArthemticP01_TestFail

TaishanSimdWideNarryArthemticP01_TestEnd:
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
TaishanSimdWideNarryArthemticP01_TestFail:
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
