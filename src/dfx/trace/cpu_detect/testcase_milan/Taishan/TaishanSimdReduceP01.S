.global TaishanSimdReduceP01

.text
.p2align 4

TaishanSimdReduceP01:

TaishanSimdReduceP01_TestBegin:
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
    MOVK  X2, #0xfff8, LSL #48
    MOVK  X2, #0xb7e2, LSL #32
    MOVK  X2, #0xb7fc, LSL #16
    MOVK  X2, #0xc9cc, LSL #0
    MOVK  X3, #0x139d, LSL #48
    MOVK  X3, #0x456c, LSL #32
    MOVK  X3, #0x537d, LSL #16
    MOVK  X3, #0x1434, LSL #0
    MOVK  X4, #0x64d9, LSL #48
    MOVK  X4, #0xab2d, LSL #32
    MOVK  X4, #0x6a90, LSL #16
    MOVK  X4, #0x30a0, LSL #0
    MOVK  X5, #0xa13a, LSL #48
    MOVK  X5, #0xf04b, LSL #32
    MOVK  X5, #0x6a97, LSL #16
    MOVK  X5, #0xec1a, LSL #0
    MOVK  X6, #0x2311, LSL #48
    MOVK  X6, #0x83ca, LSL #32
    MOVK  X6, #0x764e, LSL #16
    MOVK  X6, #0x62b3, LSL #0
    MOVK  X7, #0xdc8, LSL #48
    MOVK  X7, #0x3613, LSL #32
    MOVK  X7, #0xd68c, LSL #16
    MOVK  X7, #0x57ca, LSL #0
    MOVK  X8, #0x845f, LSL #48
    MOVK  X8, #0x8fce, LSL #32
    MOVK  X8, #0x359b, LSL #16
    MOVK  X8, #0x3d2d, LSL #0
    MOVK  X9, #0xb451, LSL #48
    MOVK  X9, #0xecd3, LSL #32
    MOVK  X9, #0x9885, LSL #16
    MOVK  X9, #0x676b, LSL #0
    MOVK  X10, #0x40f7, LSL #48
    MOVK  X10, #0xb106, LSL #32
    MOVK  X10, #0x8382, LSL #16
    MOVK  X10, #0x5222, LSL #0
    MOVK  X11, #0xeb5c, LSL #48
    MOVK  X11, #0x107b, LSL #32
    MOVK  X11, #0xf320, LSL #16
    MOVK  X11, #0x416a, LSL #0
    MOVK  X12, #0x8504, LSL #48
    MOVK  X12, #0x16d0, LSL #32
    MOVK  X12, #0xe406, LSL #16
    MOVK  X12, #0x3b92, LSL #0
    MOVK  X13, #0x171f, LSL #48
    MOVK  X13, #0x9c98, LSL #32
    MOVK  X13, #0xed7, LSL #16
    MOVK  X13, #0xe959, LSL #0
    MOVK  X14, #0x94c7, LSL #48
    MOVK  X14, #0xf579, LSL #32
    MOVK  X14, #0x4376, LSL #16
    MOVK  X14, #0xab24, LSL #0
    MOVK  X15, #0x41bf, LSL #48
    MOVK  X15, #0x674f, LSL #32
    MOVK  X15, #0x4b17, LSL #16
    MOVK  X15, #0x3238, LSL #0
    MOVK  X16, #0x343, LSL #48
    MOVK  X16, #0xe79d, LSL #32
    MOVK  X16, #0xc702, LSL #16
    MOVK  X16, #0xccb, LSL #0
    MOVK  X17, #0xcbe2, LSL #48
    MOVK  X17, #0x938b, LSL #32
    MOVK  X17, #0xce36, LSL #16
    MOVK  X17, #0x5e9c, LSL #0
    MOVK  X18, #0xb450, LSL #48
    MOVK  X18, #0xbc4a, LSL #32
    MOVK  X18, #0xdf36, LSL #16
    MOVK  X18, #0xd31f, LSL #0
    MOVK  X19, #0x2db5, LSL #48
    MOVK  X19, #0x875d, LSL #32
    MOVK  X19, #0xeb35, LSL #16
    MOVK  X19, #0x727c, LSL #0
    MOVK  X20, #0xef75, LSL #48
    MOVK  X20, #0x735f, LSL #32
    MOVK  X20, #0xa348, LSL #16
    MOVK  X20, #0x7279, LSL #0
    MOVK  X21, #0xd1e1, LSL #48
    MOVK  X21, #0x56cb, LSL #32
    MOVK  X21, #0x420c, LSL #16
    MOVK  X21, #0x5bb6, LSL #0
    MOVK  X22, #0xe0e7, LSL #48
    MOVK  X22, #0xf691, LSL #32
    MOVK  X22, #0x14f1, LSL #16
    MOVK  X22, #0x32bd, LSL #0
    MOVK  X23, #0xfb73, LSL #48
    MOVK  X23, #0xcac8, LSL #32
    MOVK  X23, #0xf1c3, LSL #16
    MOVK  X23, #0x2203, LSL #0
    MOVK  X25, #0x2ab5, LSL #48
    MOVK  X25, #0x93df, LSL #32
    MOVK  X25, #0x6860, LSL #16
    MOVK  X25, #0x7c1, LSL #0
    MOVK  X26, #0x36c2, LSL #48
    MOVK  X26, #0x36fc, LSL #32
    MOVK  X26, #0xd4e6, LSL #16
    MOVK  X26, #0xa3b4, LSL #0
    MOVK  X27, #0xc2e1, LSL #48
    MOVK  X27, #0xea78, LSL #32
    MOVK  X27, #0x5b24, LSL #16
    MOVK  X27, #0x4ae4, LSL #0
    MOVK  X28, #0x8623, LSL #48
    MOVK  X28, #0x66ee, LSL #32
    MOVK  X28, #0xe468, LSL #16
    MOVK  X28, #0xa0f1, LSL #0
    MOVK  X29, #0xf7c9, LSL #48
    MOVK  X29, #0x7727, LSL #32
    MOVK  X29, #0xe71f, LSL #16
    MOVK  X29, #0xf47c, LSL #0
    SUBS  W10, W3, #0x4ec, LSL #12
    MOVZ  X3, #0x4a94, LSL #0
    MOVK  X3, #0xcfba, LSL #16
    MSR  FPCR, X3
    MRS  X2, FPSR
    MOVZ  X9, #0xff60, LSL #0
    MOVK  X9, #0x7ff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    AND  X2, X2, X9
    MOVZ  X9, #0x0, LSL #0
    ORR  X2, X2, X9
    MSR  FPSR, X2
    ISB  SY
    MOVZ  X2, #0x2502, LSL #0
    MOVK  X2, #0x86f2, LSL #16
    MOVK  X2, #0xe5a6, LSL #32
    MOVK  X2, #0x65fc, LSL #48
    MOVZ  X3, #0x534b, LSL #0
    MOVK  X3, #0x3a2c, LSL #16
    MOVK  X3, #0x2ded, LSL #32
    MOVK  X3, #0x47b, LSL #48
    MOVZ  X4, #0x2d9d, LSL #0
    MOVK  X4, #0x956, LSL #16
    MOVK  X4, #0xba6e, LSL #32
    MOVK  X4, #0xf896, LSL #48
    MOVZ  X5, #0x69fc, LSL #0
    MOVK  X5, #0xc22c, LSL #16
    MOVK  X5, #0x353c, LSL #32
    MOVK  X5, #0x65a6, LSL #48
    MOVZ  X6, #0x6c53, LSL #0
    MOVK  X6, #0xd631, LSL #16
    MOVK  X6, #0xde5d, LSL #32
    MOVK  X6, #0xdeb9, LSL #48
    MOVZ  X7, #0xc938, LSL #0
    MOVK  X7, #0xa52b, LSL #16
    MOVK  X7, #0x45f9, LSL #32
    MOVK  X7, #0xb31e, LSL #48
    MOVZ  X8, #0x9406, LSL #0
    MOVK  X8, #0x7698, LSL #16
    MOVK  X8, #0xd11b, LSL #32
    MOVK  X8, #0xe3e1, LSL #48
    MOVZ  X9, #0x70a0, LSL #0
    MOVK  X9, #0x4967, LSL #16
    MOVK  X9, #0xecb4, LSL #32
    MOVK  X9, #0x2824, LSL #48
    MOVZ  X10, #0x1610, LSL #0
    MOVK  X10, #0xcae9, LSL #16
    MOVK  X10, #0xcaeb, LSL #32
    MOVK  X10, #0xc872, LSL #48
    MOVZ  X11, #0x3129, LSL #0
    MOVK  X11, #0x766, LSL #16
    MOVK  X11, #0x7cb7, LSL #32
    MOVK  X11, #0xdf84, LSL #48
    MOVZ  X12, #0xdb83, LSL #0
    MOVK  X12, #0x4c0c, LSL #16
    MOVK  X12, #0x50d5, LSL #32
    MOVK  X12, #0x2b99, LSL #48
    MOVZ  X13, #0xe13e, LSL #0
    MOVK  X13, #0xdd79, LSL #16
    MOVK  X13, #0x405a, LSL #32
    MOVK  X13, #0xf830, LSL #48
    MOVZ  X14, #0x5a4a, LSL #0
    MOVK  X14, #0x19dc, LSL #16
    MOVK  X14, #0xf422, LSL #32
    MOVK  X14, #0xc22b, LSL #48
    MOVZ  X15, #0x8b88, LSL #0
    MOVK  X15, #0x3cc3, LSL #16
    MOVK  X15, #0x63ab, LSL #32
    MOVK  X15, #0x5a06, LSL #48
    MOVZ  X16, #0x6877, LSL #0
    MOVK  X16, #0xa71a, LSL #16
    MOVK  X16, #0xfb, LSL #32
    MOVK  X16, #0xedeb, LSL #48
    MOVZ  X17, #0xb49f, LSL #0
    MOVK  X17, #0xb542, LSL #16
    MOVK  X17, #0xfbc1, LSL #32
    MOVK  X17, #0xe5e3, LSL #48
    MOVZ  X18, #0x9671, LSL #0
    MOVK  X18, #0x6842, LSL #16
    MOVK  X18, #0x3e69, LSL #32
    MOVK  X18, #0x2845, LSL #48
    MOVZ  X19, #0x6c0d, LSL #0
    MOVK  X19, #0xfb12, LSL #16
    MOVK  X19, #0x12ba, LSL #32
    MOVK  X19, #0xc762, LSL #48
    MOVZ  X20, #0xc80d, LSL #0
    MOVK  X20, #0xd1f7, LSL #16
    MOVK  X20, #0x149, LSL #32
    MOVK  X20, #0x1a98, LSL #48
    MOVZ  X21, #0xe6ed, LSL #0
    MOVK  X21, #0xacdb, LSL #16
    MOVK  X21, #0x1685, LSL #32
    MOVK  X21, #0x6783, LSL #48
    MOVZ  X22, #0x81bc, LSL #0
    MOVK  X22, #0xfdc0, LSL #16
    MOVK  X22, #0xcb2e, LSL #32
    MOVK  X22, #0xbd5b, LSL #48
    MOVZ  X23, #0xa2f3, LSL #0
    MOVK  X23, #0xc3b5, LSL #16
    MOVK  X23, #0x5025, LSL #32
    MOVK  X23, #0x9136, LSL #48
    MOVZ  X25, #0xcdc, LSL #0
    MOVK  X25, #0x4df9, LSL #16
    MOVK  X25, #0xa3d6, LSL #32
    MOVK  X25, #0x901e, LSL #48
    MOVZ  X26, #0xc2e2, LSL #0
    MOVK  X26, #0xa078, LSL #16
    MOVK  X26, #0x1200, LSL #32
    MOVK  X26, #0x3de5, LSL #48
    MOVZ  X27, #0x23eb, LSL #0
    MOVK  X27, #0x16c9, LSL #16
    MOVK  X27, #0xc14f, LSL #32
    MOVK  X27, #0x97c9, LSL #48
    MOVZ  X28, #0x93c2, LSL #0
    MOVK  X28, #0xf15d, LSL #16
    MOVK  X28, #0xd968, LSL #32
    MOVK  X28, #0x883e, LSL #48
    MOVZ  X29, #0x203f, LSL #0
    MOVK  X29, #0xb99c, LSL #16
    MOVK  X29, #0x7837, LSL #32
    MOVK  X29, #0xb5db, LSL #48
    FMOV  D0, X15
    FMOV  V0.D[1], X7
    FMOV  D1, X8
    FMOV  V1.D[1], X19
    FMOV  D2, X2
    FMOV  V2.D[1], X15
    FMOV  D3, X13
    FMOV  V3.D[1], X25
    FMOV  D4, X17
    FMOV  V4.D[1], X9
    FMOV  D5, X6
    FMOV  V5.D[1], X15
    FMOV  D6, X9
    FMOV  V6.D[1], X7
    FMOV  D7, X16
    FMOV  V7.D[1], X28
    FMOV  D8, X25
    FMOV  V8.D[1], X22
    FMOV  D9, X17
    FMOV  V9.D[1], X29
    FMOV  D10, X4
    FMOV  V10.D[1], X19
    FMOV  D11, X28
    FMOV  V11.D[1], X19
    FMOV  D12, X17
    FMOV  V12.D[1], X3
    FMOV  D13, X20
    FMOV  V13.D[1], X13
    FMOV  D14, X22
    FMOV  V14.D[1], X22
    FMOV  D15, X9
    FMOV  V15.D[1], X8
    FMOV  D16, X28
    FMOV  V16.D[1], X29
    FMOV  D17, X5
    FMOV  V17.D[1], X28
    FMOV  D18, X5
    FMOV  V18.D[1], X13
    FMOV  D19, X3
    FMOV  V19.D[1], X21
    FMOV  D20, X2
    FMOV  V20.D[1], X22
    FMOV  D21, X20
    FMOV  V21.D[1], X6
    FMOV  D22, X19
    FMOV  V22.D[1], X25
    FMOV  D23, X18
    FMOV  V23.D[1], X17
    FMOV  D24, X25
    FMOV  V24.D[1], X16
    FMOV  D25, X17
    FMOV  V25.D[1], X2
    FMOV  D26, X12
    FMOV  V26.D[1], X16
    FMOV  D27, X29
    FMOV  V27.D[1], X16
    FMOV  D28, X4
    FMOV  V28.D[1], X22
    FMOV  D29, X18
    FMOV  V29.D[1], X12
    FMOV  D30, X7
    FMOV  V30.D[1], X9
    FMOV  D31, X27
    FMOV  V31.D[1], X29
    MOVZ  X9, #0xa, LSL #0
TaishanSimdReduceP01_label_0:
    FCMGT  S28, S11, S25
    USHR  V26.8H, V29.8H, #1
    ORR  V27.4H, #0x51, LSL #8
    FMAXP D30, V4.2D
    FCVTZU D16, D1, #31
    ZIP1  V11.4S, V15.4S, V27.4S
    SQSUB  H11, H18, H3
    SQDMLAL  V28.4S, V3.4H, V6.4H
    CMGE  V27.2D, V21.2D, V28.2D
    SQNEG  H9, H16
    SMULL2 V9.2D, V14.4S, V23.S[0x2]
    SSHLL2 V16.4S, V17.8H, #0xd
    SQDMLAL  S24, H22, H24
    UMULL V9.4S, V3.4H, V11.H[0x3]
    URSRA  V16.8B, V26.8B, #3
    SXTL2 V14.2D, V4.4S
    BIC  V31.4S, #0x31, LSL #16
    REV64  V14.16B, V7.16B
    ADD  D18, D12, D9
    SQNEG  H28, H12
    SQSHRUN V27.8B, V18.8H, #1
    UQRSHL  H9, H29, H19
    CNT  V11.8B, V21.8B
    SQSHRUN S14, D6, #3
    MUL  V13.2S, V14.2S, V1.2S
    UHSUB  V11.8H, V30.8H, V4.8H
    UMULL V13.4S, V27.4H, V14.H[0x2]
    UQSHL  V8.2S, V4.2S, #0x2
    SQSHL S7, S18, #0x7
    SQDMULH  S16, S25, S10
    SRI V31.2D, V18.2D, #29
    MLS  V30.8H, V11.8H, V2.H[0x6]
    SQRSHRUN H25, S11, #12
    DUP V11.2D, X6
    RSHRN V30.8B, V28.8H, #1
    SQDMLAL S12, H27, V5.H[0x2]
    USHLL2 V31.4S, V3.8H, #0x3
    FCMGE  S12, S8, S25
    UMLSL2  V6.4S, V20.8H, V22.8H
    UQSHRN V31.8B, V6.8H, #5
    MOVI  V24.8H, #0xdc
    MLS  V29.2S, V0.2S, V21.S[0x3]
    SCVTF D28, D29, #34
    SQRSHL  S24, S28, S4
    FCMLE  V20.2S, V1.2S, #0.0
    URSHL  V8.16B, V15.16B, V18.16B
    PMUL  V7.8B, V28.8B, V1.8B
    UQXTN  V19.4H, V24.4S
    FCMLE  D7, D1, #0.0
    FMULX  V31.2D, V1.2D, V17.2D
    BIC  V15.4S, #0xac
    SQDMULH  V17.8H, V3.8H, V15.H[0x5]
    SQRSHRN H16, S12, #6
    CMGE  V22.2S, V13.2S, #0
    UMLAL2 V14.2D, V1.4S, V29.S[0x1]
    SADDLV  D18, V23.4S
    CMGE  D23, D3, #0
    RSHRN V31.4H, V27.4S, #7
    FCVTPS  S19, S25
    SMLAL V21.4S, V12.4H, V10.H[0x7]
    URSRA  V7.4H, V10.4H, #5
    SSHLL V31.8H, V11.8B, #0x2
    DUP S24, V18.S[0x1]
    UMULL2 V22.2D, V24.4S, V25.S[0x3]
    UQSHL S8, S22, #0x6
    SMLAL V26.2D, V1.2S, V27.S[0x3]
    SQXTUN  B14, H22
    SQSHL B23, B14, #0x4
    SSHR  V26.8H, V21.8H, #9
    FMAX  V9.2D, V8.2D, V22.2D
    FCVTMS  S19, S13
    BSL  V9.8B, V20.8B, V11.8B
    SSUBL  V27.2D, V16.2S, V27.2S
    FRINTM  V23.4S, V7.4S
    SADDL  V23.8H, V8.8B, V20.8B
    UMLAL2  V18.2D, V31.4S, V27.4S
    FMINNM  V6.4S, V11.4S, V15.4S
    FMLA S21, S4, V20.S[0x3]
    FCVTAU  S9, S6
    BSL  V23.16B, V22.16B, V27.16B
    FCVTZU  D19, D26
    SQDMLSL V31.2D, V27.2S, V2.S[0x0]
    INS V14.H[0x6], V10.H[0x4]
    SQSUB  B7, B7, B24
    USQADD  D3, D11
    UADALP  V14.4S, V7.8H
    SMULL V30.2D, V7.2S, V1.S[0x0]
    SMLAL V24.2D, V31.2S, V18.S[0x0]
    FMUL V15.2D, V1.2D, V8.D[0x0]
    CMEQ  V14.16B, V13.16B, V31.16B
    SQDMULH  V9.4H, V3.4H, V7.H[0x3]
    UQSHL H24, H1, #0x1
    INS V17.D[0x1], X2
    SQRSHL  D8, D19, D2
    SQSHRUN H21, S4, #5
    SQABS  D21, D30
    FCMGT  S12, S11, S4
    SRSHR D20, D11, #1
    MOV D10, V26.D[0x1]
    UQADD  V31.2D, V5.2D, V15.2D
    URSHL  D2, D21, D18
    FRECPS  V3.4S, V21.4S, V4.4S
    SLI  V16.8H, V3.8H, #0xe
    FRINTZ  V5.4S, V8.4S
    FCMGT  S2, S2, #0.0
    SQABS  V25.16B, V25.16B
    CMEQ  D13, D18, #0
    SMOV  X26, V23.H[0x2]
    SQSHRN V18.2S, V31.2D, #31
    SMLAL2 V1.4S, V13.8H, V3.H[0x5]
    TRN2  V30.4H, V30.4H, V17.4H
    SABDL2  V5.4S, V17.8H, V18.8H
    SQABS  B5, B26
    UQSHL D0, D28, #0x3a
    SADDLP  V14.2D, V29.4S
    DUP V3.8B, W15
    SMLAL2 V23.4S, V8.8H, V13.H[0x6]
    SMULL2  V9.2D, V6.4S, V13.4S
    SQDMLSL  D9, S1, S15
    SMOV  X13, V0.S[0x3]
    SQNEG  D31, D8
    FCMLE  V26.2D, V28.2D, #0.0
    USHL  V7.4H, V28.4H, V26.4H
    UMINV  B16, V29.8B
    FCVTAU  S18, S22
    SQXTUN  B31, H13
    USUBL2  V1.2D, V2.4S, V25.4S
    UMLAL V0.2D, V21.2S, V16.S[0x3]
    FMLA S20, S30, V4.S[0x3]
    FCVTZS S17, S18, #9
    UABD  V15.2S, V9.2S, V28.2S
    UQSUB  H9, H27, H17
    SQSHLU V3.2D, V30.2D, #0xa
    SQRSHL  D11, D13, D28
    SABDL2  V26.4S, V13.8H, V5.8H
    CMGE  D12, D31, D1
    AND  V0.16B, V9.16B, V16.16B
    UQADD  S21, S23, S23
    FMAXNMP  V2.2S, V28.2S, V17.2S
    FRINTM  V9.2D, V28.2D
    URSHR  V31.2S, V17.2S, #31
    SMLAL V21.2D, V2.2S, V13.S[0x2]
    URSHR  V15.2S, V21.2S, #11
    SMINV  H22, V20.4H
    FCMEQ  S17, S15, S9
    FMLA V1.2D, V23.2D, V29.D[0x1]
    FMULX D10, D7, V15.D[0x0]
    FMULX  V22.4S, V0.4S, V3.4S
    SQDMULH  H3, H7, H12
    USRA D0, D15, #25
    UMAXV  B13, V15.16B
    SHRN2 V11.8H, V27.4S, #16
    DUP  V23.8B, V9.B[0xb]
    DUP H25, V5.H[0x7]
    EOR  V7.16B, V15.16B, V22.16B
    UMLAL V11.2D, V23.2S, V13.S[0x3]
    SCVTF D15, D0, #35
    SQDMLSL2 V15.4S, V30.8H, V5.H[0x5]
    SQSHRN S9, D23, #5
    DUP  V24.4S, V30.S[0x3]
    USRA  V29.2S, V14.2S, #6
    SCVTF  V12.2S, V4.2S, #23
    SQRSHRN2 V20.8H, V4.4S, #11
    SMAXP  V29.8H, V23.8H, V9.8H
    CMGE  D30, D9, #0
    SHRN V27.8B, V14.8H, #4
    FCVTNU  V2.2D, V20.2D
    FCMLT  S21, S4, #0.0
    SMIN  V0.4H, V13.4H, V6.4H
    BIT  V6.16B, V26.16B, V15.16B
    XTN  V6.2S, V8.2D
    UQSHRN S6, D11, #5
    SQSHRUN V1.4H, V14.4S, #7
    UMAXP  V28.8B, V23.8B, V14.8B
    UQSHL D29, D6, #0x12
    MOV V22.B[0x0], V5.B[0x4]
    CMGT  V12.4H, V21.4H, #0
    FADDP D21, V13.2D
    SQRSHRUN S27, D17, #13
    SQDMLSL  V11.4S, V6.4H, V2.4H
    SLI V9.2D, V2.2D, #0xf
    SQSHRUN2 V0.4S, V10.2D, #14
    SQRSHRN B22, H24, #6
    FABS  V27.2D, V16.2D
    FMAXV  S21, V15.4S
    UZP2  V8.4S, V15.4S, V16.4S
    FMLS  V15.4S, V30.4S, V10.4S
    FABS  V15.2D, V13.2D
    UQSHL  H15, H13, H27
    UMLAL2 V22.4S, V20.8H, V13.H[0x7]
    MOVI  V26.8H, #0x22, LSL #8
    FRECPX  D27, D12
    UQADD  B16, B18, B17
    USHR D24, D16, #52
    USHR  V17.4S, V27.4S, #18
    SHL V2.2D, V18.2D, #0xe
    RSUBHN2  V12.8H, V10.4S, V13.4S
    SUQADD  S22, S6
    USUBL  V27.2D, V8.2S, V24.2S
    SQSHLU D16, D7, #0x15
    SUBS  X9, X9, #0x1
    B.NE  TaishanSimdReduceP01_label_0
    MOVZ  X6, #0x2502, LSL #0
    MOVK  X6, #0x86f2, LSL #16
    MOVK  X6, #0xe5a6, LSL #32
    MOVK  X6, #0x65fc, LSL #48
    SUB  X11, X6, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    MOVZ  X21, #0x534b, LSL #0
    MOVK  X21, #0x3a2c, LSL #16
    MOVK  X21, #0x2ded, LSL #32
    MOVK  X21, #0x47b, LSL #48
    SUB  X17, X21, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    MOVZ  X11, #0x2d9d, LSL #0
    MOVK  X11, #0x956, LSL #16
    MOVK  X11, #0xba6e, LSL #32
    MOVK  X11, #0xf896, LSL #48
    SUB  X5, X11, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    MOVZ  X14, #0x2502, LSL #0
    MOVK  X14, #0x86f2, LSL #16
    MOVK  X14, #0xe5a6, LSL #32
    MOVK  X14, #0x65fc, LSL #48
    SUB  X22, X14, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    MOVZ  X26, #0xc938, LSL #0
    MOVK  X26, #0xa52b, LSL #16
    MOVK  X26, #0x45f9, LSL #32
    MOVK  X26, #0xb31e, LSL #48
    SUB  X28, X26, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    MOVZ  X27, #0x9406, LSL #0
    MOVK  X27, #0x7698, LSL #16
    MOVK  X27, #0xd11b, LSL #32
    MOVK  X27, #0xe3e1, LSL #48
    SUB  X26, X27, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X10, X18, X9
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    MOVZ  X10, #0x2d9d, LSL #0
    MOVK  X10, #0x956, LSL #16
    MOVK  X10, #0xba6e, LSL #32
    MOVK  X10, #0xf896, LSL #48
    SUB  X21, X10, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X13
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    MOVZ  X29, #0x2502, LSL #0
    MOVK  X29, #0x86f2, LSL #16
    MOVK  X29, #0xe5a6, LSL #32
    MOVK  X29, #0x65fc, LSL #48
    SUB  X19, X29, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X17, X6, X16
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X26, X23, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    MOVZ  X4, #0xcdc, LSL #0
    MOVK  X4, #0x4df9, LSL #16
    MOVK  X4, #0xa3d6, LSL #32
    MOVK  X4, #0x901e, LSL #48
    SUB  X9, X4, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    MOVZ  X23, #0x2502, LSL #0
    MOVK  X23, #0x86f2, LSL #16
    MOVK  X23, #0xe5a6, LSL #32
    MOVK  X23, #0x65fc, LSL #48
    SUB  X16, X23, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X19, V2.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X19, D2
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    FMOV  X23, D3
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X15, #0x70a0, LSL #0
    MOVK  X15, #0x4967, LSL #16
    MOVK  X15, #0xecb4, LSL #32
    MOVK  X15, #0x2824, LSL #48
    SUB  X17, X15, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X3, D4
    MOVZ  X15, #0xb49f, LSL #0
    MOVK  X15, #0xb542, LSL #16
    MOVK  X15, #0xfbc1, LSL #32
    MOVK  X15, #0xe5e3, LSL #48
    SUB  X17, X15, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X8, D5
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X26, D6
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X17, X13, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X22, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X22, D7
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X29, V8.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    FMOV  X29, D8
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    FMOV  X15, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X15, D9
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X19, V10.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X19, D10
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X28, D11
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X4, X22, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X4, D12
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X6, D13
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X9, D14
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X29, X19, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X13, D15
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X23, D16
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X21, V17.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X21, D17
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x1ff8, LSL #32
    SUB  X8, X26, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X20, D18
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X23, D19
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X9, #0x8000, LSL #0
    MOVK  X9, #0x8000, LSL #16
    MOVK  X9, #0x7fff, LSL #32
    MOVK  X9, #0x7fff, LSL #48
    SUB  X18, X9, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X10, D20
    MOVZ  X9, #0xb62a, LSL #0
    MOVK  X9, #0xeb18, LSL #16
    SUB  X18, X9, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X23, D21
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X17, X6, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X13, D22
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0x7fff, LSL #16
    SUB  X17, X6, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X2, D23
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X5, V25.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X5, D25
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X19, V26.D[1]
    MOVZ  X3, #0x2200, LSL #0
    MOVK  X3, #0x2200, LSL #16
    MOVK  X3, #0x2200, LSL #32
    MOVK  X3, #0x2200, LSL #48
    SUB  X13, X3, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X19, D26
    MOVZ  X3, #0x2200, LSL #0
    MOVK  X3, #0x2200, LSL #16
    MOVK  X3, #0x2200, LSL #32
    MOVK  X3, #0x2200, LSL #48
    SUB  X13, X3, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X26, D27
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X21, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X21, D28
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X29, X7, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X26, D29
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xfffc, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0x3, LSL #48
    SUB  X10, X5, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X17
    FMOV  V0.D[1], X16
    FMOV  D1, X3
    FMOV  V1.D[1], X13
    FMOV  D2, X26
    FMOV  V2.D[1], X3
    FMOV  D3, X3
    FMOV  V3.D[1], X25
    FMOV  D4, X19
    FMOV  V4.D[1], X29
    FMOV  D5, X23
    FMOV  V5.D[1], X21
    FMOV  D6, X13
    FMOV  V6.D[1], X8
    FMOV  D7, X8
    FMOV  V7.D[1], X27
    FMOV  D8, X5
    FMOV  V8.D[1], X26
    FMOV  D9, X17
    FMOV  V9.D[1], X22
    FMOV  D10, X19
    FMOV  V10.D[1], X14
    FMOV  D11, X19
    FMOV  V11.D[1], X3
    FMOV  D12, X5
    FMOV  V12.D[1], X2
    FMOV  D13, X23
    FMOV  V13.D[1], X19
    FMOV  D14, X2
    FMOV  V14.D[1], X26
    FMOV  D15, X4
    FMOV  V15.D[1], X28
    FMOV  D16, X20
    FMOV  V16.D[1], X25
    FMOV  D17, X4
    FMOV  V17.D[1], X22
    FMOV  D18, X12
    FMOV  V18.D[1], X18
    FMOV  D19, X5
    FMOV  V19.D[1], X4
    FMOV  D20, X17
    FMOV  V20.D[1], X9
    FMOV  D21, X15
    FMOV  V21.D[1], X3
    FMOV  D22, X9
    FMOV  V22.D[1], X22
    FMOV  D23, X22
    FMOV  V23.D[1], X22
    FMOV  D24, X21
    FMOV  V24.D[1], X3
    FMOV  D25, X2
    FMOV  V25.D[1], X10
    FMOV  D26, X22
    FMOV  V26.D[1], X5
    FMOV  D27, X18
    FMOV  V27.D[1], X9
    FMOV  D28, X26
    FMOV  V28.D[1], X27
    FMOV  D29, X17
    FMOV  V29.D[1], X7
    FMOV  D30, X7
    FMOV  V30.D[1], X29
    FMOV  D31, X11
    FMOV  V31.D[1], X18
    MOVZ  X25, #0xa, LSL #0
TaishanSimdReduceP01_label_83:
    USHLL V18.2D, V22.2S, #0x3
    SQRDMULH  H29, H4, H23
    SQDMLSL2 V12.4S, V28.8H, V5.H[0x4]
    UCVTF  V3.4S, V1.4S, #23
    FCVTPS  V15.4S, V18.4S
    UQSHL D2, D2, #0x2f
    SRI  V13.16B, V2.16B, #2
    FNEG  V17.2D, V28.2D
    FMULX  S17, S0, S0
    RSHRN V29.4H, V29.4S, #1
    UMLSL V12.4S, V13.4H, V15.H[0x6]
    MVN  V22.8B, V12.8B
    FRINTI  V19.2S, V27.2S
    SQDMULH  V3.4H, V0.4H, V13.4H
    SQSUB  H7, H23, H17
    FMIN  V1.2D, V11.2D, V8.2D
    SHL  V21.4S, V8.4S, #0x3
    SSRA  V21.8H, V20.8H, #16
    FCVTMS  V19.4S, V21.4S
    MLS  V1.2S, V22.2S, V16.S[0x2]
    UMULL2 V14.4S, V13.8H, V8.H[0x7]
    UQRSHRN B13, H1, #6
    SQSHLU H19, H3, #0xb
    SQRDMULH  V3.2S, V8.2S, V25.2S
    FCVTPU  D5, D16
    ADDHN  V20.4H, V8.4S, V17.4S
    SHRN2 V18.4S, V1.2D, #4
    SQNEG  S29, S16
    UMAXV  H11, V20.8H
    SQSHL  V25.8H, V18.8H, V11.8H
    FCMLT  V7.2D, V17.2D, #0.0
    ABS  V2.16B, V0.16B
    FCMEQ  S24, S23, #0.0
    SMAXV  B29, V16.16B
    SQSHRN2 V6.16B, V3.8H, #7
    UXTL2 V20.4S, V31.8H
    UQSHL H21, H16, #0xb
    SQSHRN V30.4H, V17.4S, #6
    SRSRA V12.2D, V8.2D, #36
    FRECPE  D24, D28
    UMULL2 V23.2D, V31.4S, V8.S[0x0]
    MOV  W5, V2.S[0x1]
    SQSHLU  V30.2S, V30.2S, #0x16
    SQDMLAL  S31, H28, H30
    BIT  V2.8B, V18.8B, V22.8B
    REV32  V0.4H, V24.4H
    URSHR  V7.4S, V4.4S, #24
    USQADD  V4.4S, V20.4S
    UQSUB  B30, B18, B15
    UMULL V15.4S, V11.4H, V4.H[0x2]
    CMGT  V6.4H, V8.4H, V28.4H
    SQSHRUN2 V26.16B, V0.8H, #5
    UADDW2  V20.2D, V3.2D, V15.4S
    URSHL  D16, D29, D13
    SMAXP  V30.4H, V22.4H, V14.4H
    MUL  V12.2S, V20.2S, V7.2S
    SRI D1, D17, #44
    MOVI  V24.8H, #0xe
    FCMGT  V24.4S, V15.4S, #0.0
    FMOV  V30.2S, #-18.00000000
    SQRDMULH H17, H0, V8.H[0x5]
    MVNI  V16.4H, #0xd8, LSL #8
    ORR  V26.2S, #0x3d
    FCVTNU  V30.4S, V26.4S
    SQSUB  B22, B13, B27
    MOV  V23.8B, V1.8B
    FCMGE  V25.2S, V13.2S, #0.0
    FRINTI  V16.4S, V6.4S
    USHLL2 V23.2D, V27.4S, #0xf
    MVNI  V4.2S, #0x77, MSL #16
    SSRA V0.2D, V25.2D, #5
    MOVI  V27.8H, #0x2f, LSL #8
    FCMEQ  D18, D3, #0.0
    UMLAL V30.4S, V18.4H, V14.H[0x4]
    USHL  D30, D27, D15
    CMHI  D24, D26, D7
    SSHL  D20, D3, D29
    SRSRA  V4.4S, V20.4S, #15
    FMAX  V10.4S, V16.4S, V0.4S
    SUQADD  D11, D1
    FMLA S24, S7, V21.S[0x2]
    SSHR  V25.8H, V4.8H, #16
    CMGE  D0, D2, #0
    SMAXP  V27.2S, V23.2S, V13.2S
    MLS  V22.8H, V6.8H, V1.H[0x3]
    SQRSHRUN2 V23.16B, V12.8H, #8
    RADDHN  V27.4H, V11.4S, V12.4S
    SHRN V24.2S, V30.2D, #3
    SSHL  V8.4S, V2.4S, V4.4S
    URSRA  V16.2S, V14.2S, #19
    SQXTN  S15, D9
    SQSHL  D7, D4, D7
    BIC  V1.2S, #0x15, LSL #8
    UQSUB  D21, D0, D30
    UQXTN  B13, H10
    FCMGT  D11, D13, D14
    CLS  V1.8B, V21.8B
    ADD  V14.2S, V12.2S, V13.2S
    USHL  V30.4H, V0.4H, V21.4H
    FCVTMU  V1.2D, V29.2D
    SLI  V7.4S, V20.4S, #0x17
    INS V24.H[0x4], V23.H[0x1]
    SSRA V13.2D, V25.2D, #3
    MOVI  V28.16B, #0x29
    FCVTPS  D25, D28
    FCMLE  D13, D13, #0.0
    SQDMULL S11, H30, V8.H[0x5]
    UQRSHRN V25.4H, V27.4S, #11
    CMGT  V3.4S, V10.4S, #0
    SMULL  V24.4S, V9.4H, V23.4H
    FMINNM  V24.4S, V20.4S, V0.4S
    INS V1.H[0x3], V29.H[0x0]
    SABDL  V12.4S, V23.4H, V7.4H
    SABAL2  V11.2D, V24.4S, V20.4S
    UQXTN  B7, H4
    FMIN  V14.2S, V4.2S, V13.2S
    DUP  V20.8B, V0.B[0x4]
    UQSHRN2 V16.16B, V0.8H, #3
    UQRSHRN B25, H26, #4
    UMAX  V5.4S, V28.4S, V18.4S
    SHL  V11.4H, V18.4H, #0x3
    USQADD  V0.4S, V9.4S
    SXTL2 V4.4S, V3.8H
    CMHS  V3.2D, V21.2D, V13.2D
    URSRA D1, D27, #50
    SSUBW  V30.4S, V20.4S, V14.4H
    FNEG  V1.4S, V9.4S
    RBIT  V22.16B, V30.16B
    FCMGE  V23.2S, V10.2S, #0.0
    SCVTF  V9.4S, V26.4S, #23
    FCVTZS  S31, S0
    SRHADD  V17.8B, V16.8B, V12.8B
    SQDMULH S24, S23, V12.S[0x1]
    URSHR D5, D3, #28
    SMULL  V25.2D, V11.2S, V14.2S
    CMGE  V17.16B, V4.16B, V12.16B
    SQDMLAL D3, S24, V28.S[0x1]
    FRINTM  V10.4S, V11.4S
    SMAXV  B9, V3.16B
    UABD  V8.16B, V14.16B, V31.16B
    FCVTMS  S3, S13
    SQSHRUN S31, D8, #10
    MOV V31.S[0x1], W13
    USRA  V14.4S, V25.4S, #3
    SUQADD  H6, H26
    FRINTI  V23.2S, V0.2S
    UABDL  V21.2D, V12.2S, V15.2S
    DUP V28.4S, W12
    FACGT  D4, D24, D27
    FMULX V6.2S, V17.2S, V11.S[0x0]
    FRECPX  D19, D18
    FMINNMP D18, V16.2D
    UMOV W8, V14.H[0x1]
    UQSHRN V5.8B, V31.8H, #5
    FRINTP  V31.4S, V9.4S
    SQDMLAL  V6.4S, V7.4H, V31.4H
    SADDLV  H7, V1.8B
    MOV V6.B[0xe], V19.B[0x0]
    FMLA S10, S4, V4.S[0x3]
    FRSQRTS  D2, D12, D25
    FCMGT  V22.2D, V0.2D, #0.0
    UZP2  V27.4H, V13.4H, V23.4H
    SLI  V10.4S, V8.4S, #0x1b
    UQSHL  V17.16B, V11.16B, #0x5
    SQSHRUN V28.4H, V16.4S, #1
    SQRSHRUN H19, S8, #7
    FRECPE  D3, D16
    SQSHRN S2, D28, #24
    FMAXNMP S14, V0.2S
    SADDLP  V31.4H, V7.8B
    SLI  V3.4H, V20.4H, #0xe
    ADDV  S15, V21.4S
    SUBHN  V12.4H, V31.4S, V8.4S
    UZP1  V13.8B, V9.8B, V15.8B
    UMLSL2 V26.4S, V19.8H, V7.H[0x3]
    SQSHLU D10, D11, #0x16
    SRSHR  V1.2S, V9.2S, #12
    FCVTMS  S23, S21
    SQDMULH S8, S0, V9.S[0x2]
    SQXTN2  V12.8H, V8.4S
    USHR  V15.8B, V2.8B, #5
    SQRSHRN B0, H24, #6
    AND  V24.8B, V17.8B, V4.8B
    UMLSL  V15.2D, V15.2S, V30.2S
    FMLA S17, S25, V30.S[0x0]
    SQRSHL  V28.16B, V8.16B, V2.16B
    SLI  V0.4S, V26.4S, #0x9
    FRSQRTS  S30, S2, S31
    UQSHL  V19.2S, V15.2S, V22.2S
    URSRA V27.2D, V9.2D, #48
    FCMGE  V12.4S, V16.4S, #0.0
    SQDMULL  V17.2D, V11.2S, V28.2S
    SRI V4.2D, V21.2D, #32
    INS V31.D[0x1], V18.D[0x1]
    BIC  V5.8B, V29.8B, V11.8B
    SQDMULL  V30.2D, V9.2S, V25.2S
    SMAXV  B23, V1.8B
    UQSHL V12.2D, V1.2D, #0x1
    FMAXP  V0.2D, V5.2D, V25.2D
    SQRSHRN H0, S1, #4
    SUBS  X25, X25, #0x1
    B.NE  TaishanSimdReduceP01_label_83
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X5
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    MOVZ  X5, #0x8000, LSL #0
    SUB  X25, X5, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X27, X8, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X22, X23, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X13, X22, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X19
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X27, X3, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X26, X19, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X18, D2
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X9, D3
    MOVZ  X4, #0xc000, LSL #0
    MOVK  X4, #0xc000, LSL #16
    MOVK  X4, #0xc000, LSL #32
    MOVK  X4, #0xfff0, LSL #48
    SUB  X22, X4, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X5
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    FMOV  X5, D4
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X5
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X17, D5
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X14, D6
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    MOVK  X25, #0x7fc0, LSL #48
    SUB  X8, X25, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X16, D7
    MOVZ  X3, #0xff00, LSL #0
    SUB  X8, X3, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X7, D8
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X7, X10, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X8, D9
    MOVZ  X10, #0x0, LSL #0
    SUB  X7, X10, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X11, D10
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X10, D11
    MOVZ  X14, #0xfff8, LSL #0
    MOVK  X14, #0xfff8, LSL #16
    MOVK  X14, #0xfff8, LSL #32
    MOVK  X14, #0xfff8, LSL #48
    SUB  X5, X14, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X22, V12.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X20, X17, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X22, D12
    MOVZ  X17, #0x0, LSL #0
    SUB  X20, X17, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X17, V13.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X17, D13
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x8, LSL #32
    SUB  X16, X3, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X16, D14
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x7fc0, LSL #16
    SUB  X17, X2, X16
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X12, D15
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X6, X20, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X13, D16
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X15, D17
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X5, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X5, D18
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    FMOV  X3, D19
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X26, D20
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X5, X4, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X25, #0x8, LSL #0
    SUB  X4, X25, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X23, D21
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X6, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X6, D22
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X28, D23
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x200, LSL #16
    MOVK  X8, #0x81bc, LSL #32
    MOVK  X8, #0xfffc, LSL #48
    SUB  X16, X8, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X7, D25
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x200, LSL #16
    MOVK  X8, #0x81bc, LSL #32
    MOVK  X8, #0xfffc, LSL #48
    SUB  X16, X8, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X25, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X25, D26
    MOVZ  X13, #0x3d, LSL #0
    MOVK  X13, #0x3d, LSL #32
    SUB  X9, X13, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X17, D27
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7fc0, LSL #32
    MOVK  X7, #0x7fc0, LSL #48
    SUB  X8, X7, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X27, D28
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X8, X9, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X18, D29
    MOVZ  X9, #0x0, LSL #0
    SUB  X8, X9, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
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
    FMOV  D0, X2
    FMOV  V0.D[1], X23
    FMOV  D1, X21
    FMOV  V1.D[1], X22
    FMOV  D2, X29
    FMOV  V2.D[1], X12
    FMOV  D3, X26
    FMOV  V3.D[1], X10
    FMOV  D4, X6
    FMOV  V4.D[1], X13
    FMOV  D5, X28
    FMOV  V5.D[1], X10
    FMOV  D6, X2
    FMOV  V6.D[1], X11
    FMOV  D7, X5
    FMOV  V7.D[1], X11
    FMOV  D8, X18
    FMOV  V8.D[1], X15
    FMOV  D9, X6
    FMOV  V9.D[1], X21
    FMOV  D10, X6
    FMOV  V10.D[1], X2
    FMOV  D11, X21
    FMOV  V11.D[1], X28
    FMOV  D12, X22
    FMOV  V12.D[1], X19
    FMOV  D13, X28
    FMOV  V13.D[1], X6
    FMOV  D14, X17
    FMOV  V14.D[1], X12
    FMOV  D15, X10
    FMOV  V15.D[1], X18
    FMOV  D16, X28
    FMOV  V16.D[1], X19
    FMOV  D17, X17
    FMOV  V17.D[1], X12
    FMOV  D18, X11
    FMOV  V18.D[1], X8
    FMOV  D19, X25
    FMOV  V19.D[1], X11
    FMOV  D20, X18
    FMOV  V20.D[1], X11
    FMOV  D21, X3
    FMOV  V21.D[1], X18
    FMOV  D22, X7
    FMOV  V22.D[1], X3
    FMOV  D23, X20
    FMOV  V23.D[1], X7
    FMOV  D24, X26
    FMOV  V24.D[1], X25
    FMOV  D25, X29
    FMOV  V25.D[1], X19
    FMOV  D26, X17
    FMOV  V26.D[1], X2
    FMOV  D27, X25
    FMOV  V27.D[1], X28
    FMOV  D28, X20
    FMOV  V28.D[1], X9
    FMOV  D29, X7
    FMOV  V29.D[1], X29
    FMOV  D30, X27
    FMOV  V30.D[1], X11
    FMOV  D31, X26
    FMOV  V31.D[1], X16
    MOVZ  X3, #0xf, LSL #0
TaishanSimdReduceP01_label_166:
    SMULL2 V16.4S, V10.8H, V9.H[0x5]
    UADDW  V26.8H, V26.8H, V0.8B
    UQRSHL  H13, H28, H12
    USUBW  V20.4S, V1.4S, V3.4H
    FCMEQ  V24.2S, V23.2S, #0.0
    SQSHL B26, B3, #0x3
    SADDW  V16.8H, V29.8H, V7.8B
    SQXTN  S19, D14
    FMULX  S30, S13, S23
    SMULL V27.4S, V22.4H, V0.H[0x6]
    SHL  V25.8H, V16.8H, #0xf
    SMLAL2 V23.2D, V21.4S, V25.S[0x2]
    FRINTN  V10.2D, V26.2D
    SQRSHL  H1, H26, H9
    MLA  V24.8H, V13.8H, V8.H[0x2]
    SSUBW2  V24.4S, V10.4S, V0.8H
    SQSHL  D25, D17, D26
    FMLS  V24.2S, V12.2S, V20.2S
    SQDMLAL D13, S10, V18.S[0x0]
    SQDMLSL  D3, S25, S19
    SQDMLAL2 V24.2D, V21.4S, V29.S[0x0]
    SSUBL2  V8.4S, V1.8H, V13.8H
    FADDP D17, V14.2D
    SQSHRUN S24, D9, #22
    FRSQRTE  S17, S31
    UQSHL  V28.8H, V24.8H, #0x2
    RADDHN2  V0.8H, V28.4S, V12.4S
    SMULL2 V8.4S, V7.8H, V4.H[0x5]
    SQSHRN V26.4H, V30.4S, #16
    FADD  V14.4S, V31.4S, V20.4S
    RSHRN V8.2S, V27.2D, #6
    SABDL2  V24.2D, V8.4S, V22.4S
    SQSHL  S16, S26, S8
    SSHR D29, D5, #18
    UQADD  D5, D21, D29
    USHL  V15.2D, V2.2D, V0.2D
    MOV V18.S[0x0], V22.S[0x2]
    UMAXP  V17.2S, V25.2S, V28.2S
    SMOV W19, V3.B[0xb]
    SQSHLU  V22.8B, V20.8B, #0x3
    UMLSL  V30.4S, V3.4H, V22.4H
    FCMGE  S15, S15, S31
    SQRDMULH  S2, S8, S19
    MLA  V7.4S, V15.4S, V8.S[0x1]
    SUQADD  B7, B7
    SXTL2 V15.8H, V15.16B
    SQDMULL2 V25.2D, V1.4S, V13.S[0x3]
    SQDMLSL  D25, S26, S3
    SUB  D8, D14, D13
    FADD  V28.2D, V12.2D, V29.2D
    MOV  X12, V27.D[0x1]
    SQDMULH H12, H21, V1.H[0x5]
    FCMLT  S5, S25, #0.0
    PMULL  V22.1Q, V31.1D, V11.1D
    SQDMLAL2  V28.2D, V27.4S, V31.4S
    SQDMULL V6.4S, V1.4H, V8.H[0x5]
    FCVTZU  D16, D28
    CMEQ  V8.2S, V30.2S, V24.2S
    SUQADD  V14.16B, V29.16B
    SQRSHRUN S22, D16, #10
    FCMEQ  S24, S21, #0.0
    UZP2  V16.2D, V21.2D, V21.2D
    SQNEG  S22, S20
    SCVTF S22, S15, #22
    FMULX  D11, D24, D15
    UQSHRN V8.4H, V26.4S, #13
    FMULX  V24.2D, V12.2D, V28.2D
    DUP V0.2D, V12.D[0x1]
    FMIN  V3.2D, V7.2D, V30.2D
    URECPE  V8.4S, V10.4S
    UMLAL2  V10.8H, V23.16B, V0.16B
    FADD  V13.2S, V21.2S, V18.2S
    UQRSHRN H0, S16, #4
    SMLSL V24.4S, V2.4H, V6.H[0x2]
    DUP  V3.16B, V15.B[0x4]
    FCMGT  V15.4S, V20.4S, V22.4S
    FACGT  S29, S7, S14
    FMAXNMP S25, V8.2S
    CMEQ  V29.8B, V25.8B, #0
    FCVTMS  D9, D16
    SHRN2 V15.8H, V29.4S, #4
    SCVTF  V5.2S, V22.2S, #10
    FCMEQ  D27, D28, #0.0
    SRHADD  V0.2S, V3.2S, V11.2S
    INS V15.H[0x2], V10.H[0x4]
    FMLS V9.4S, V4.4S, V3.S[0x2]
    SQRDMULH  S23, S0, S7
    FDIV  V23.2S, V21.2S, V3.2S
    INS V23.S[0x1], V6.S[0x0]
    SXTL2 V3.2D, V24.4S
    CMLT  V24.8B, V26.8B, #0
    SHRN V20.4H, V3.4S, #13
    FRECPE  S24, S13
    SMULL2 V23.2D, V21.4S, V1.S[0x1]
    USQADD  D11, D23
    SRSRA  V3.8H, V16.8H, #15
    UQADD  V9.8B, V7.8B, V13.8B
    CMEQ  V16.8H, V5.8H, #0
    MOV V3.D[0x0], V23.D[0x0]
    SQSHL  V28.8B, V9.8B, V25.8B
    FCMLT  V26.2S, V19.2S, #0.0
    DUP D15, V16.D[0x1]
    MOVI  V0.2S, #0x78, MSL #8
    SCVTF D0, D0, #5
    SQDMULL2 V20.4S, V16.8H, V14.H[0x5]
    SABD  V30.2S, V20.2S, V8.2S
    SQDMULH  S6, S4, S24
    SQNEG  S4, S21
    UMULL2  V16.2D, V19.4S, V23.4S
    SQSHRUN V13.4H, V16.4S, #3
    FMAXV  S27, V5.4S
    SABA  V9.8B, V27.8B, V30.8B
    URSHR V25.2D, V21.2D, #4
    SQRDMULH S0, S3, V3.S[0x1]
    SQRSHRUN V16.4H, V29.4S, #14
    UADDL  V7.2D, V1.2S, V24.2S
    FCVTMU  S10, S9
    UQRSHL  H3, H16, H31
    SQSHL H25, H19, #0x2
    USQADD  H10, H5
    MUL  V23.8H, V6.8H, V15.H[0x3]
    UQSHL  S24, S26, S10
    UMULL2 V27.2D, V23.4S, V3.S[0x2]
    SUB  V28.2D, V13.2D, V16.2D
    UMULL V28.4S, V8.4H, V4.H[0x5]
    FCVTZS  S27, S29
    FCVTNU  S6, S10
    USUBW  V25.8H, V19.8H, V29.8B
    SQSHLU V20.2D, V10.2D, #0x34
    CNT  V14.16B, V24.16B
    SRSHR D26, D30, #40
    UMINV  S26, V19.4S
    FMULX V27.2S, V5.2S, V12.S[0x3]
    SQDMLSL2  V18.2D, V3.4S, V24.4S
    MOV V0.D[0x1], V27.D[0x1]
    UADDLV  D18, V18.4S
    SUQADD  H17, H3
    CMGE  V8.2D, V8.2D, #0
    FCVTPU  V4.4S, V13.4S
    UQSHL  V10.8B, V27.8B, #0x1
    RADDHN  V18.4H, V22.4S, V28.4S
    CMLT  D16, D25, #0
    UQSHL V29.2D, V11.2D, #0x20
    SMAXV  S10, V10.4S
    CMGE  V27.2S, V22.2S, V19.2S
    SQSHLU V17.2D, V11.2D, #0x14
    UQADD  B17, B25, B1
    MOV B27, V31.B[0xf]
    SQXTN  H8, S13
    FMAXV  S22, V26.4S
    SQDMULH  V28.8H, V13.8H, V4.H[0x0]
    FMUL S31, S13, V20.S[0x0]
    SQRSHRUN B2, H4, #6
    SQDMLAL V19.4S, V16.4H, V9.H[0x2]
    FCVTAS  D11, D15
    SXTL V15.2D, V11.2S
    UMLSL  V1.8H, V16.8B, V19.8B
    CNT  V1.16B, V11.16B
    FCVTAU  S13, S10
    UQRSHRN2 V18.4S, V2.2D, #32
    SQADD  B3, B25, B26
    RSUBHN2  V9.8H, V4.4S, V18.4S
    SQRSHL  V18.16B, V6.16B, V17.16B
    UMLSL2  V26.8H, V29.16B, V0.16B
    UXTL2 V22.8H, V0.16B
    FADD  V24.4S, V28.4S, V12.4S
    SSUBW2  V20.2D, V0.2D, V25.4S
    UMAXV  H0, V10.8H
    SQDMULL S8, H15, V2.H[0x2]
    UCVTF S5, S28, #14
    DUP S17, V26.S[0x1]
    FMAXNM  V30.4S, V24.4S, V31.4S
    SQSHRN V29.8B, V18.8H, #1
    SCVTF D16, D20, #10
    SQDMLSL  D28, S4, S2
    SQDMULH H19, H10, V8.H[0x1]
    FCVTZS  V9.4S, V13.4S, #13
    UQRSHRN V2.2S, V4.2D, #22
    TRN1  V1.8B, V29.8B, V18.8B
    CMGE  D25, D12, #0
    SQSUB  D16, D12, D29
    UQSHRN V15.8B, V28.8H, #8
    SUB  V11.2D, V16.2D, V26.2D
    USHLL V8.4S, V2.4H, #0x9
    UQRSHL  S2, S18, S15
    SSHLL2 V30.4S, V2.8H, #0x6
    SMOV W22, V12.H[0x1]
    SQDMULL  S31, H1, H8
    SQSHLU S20, S10, #0x1b
    UMLAL2 V9.4S, V15.8H, V2.H[0x4]
    SQNEG  H21, H29
    FACGE  S14, S28, S24
    SQSHL  B7, B19, B7
    UMAXV  B18, V24.8B
    UCVTF V28.2D, V19.2D, #10
    SQDMULH S29, S30, V26.S[0x3]
    UMLAL V1.4S, V15.4H, V7.H[0x7]
    SQRDMULH H11, H4, V15.H[0x6]
    SQSHLU  V5.4S, V31.4S, #0x1f
    SHRN2 V0.16B, V2.8H, #8
    SUBS  X3, X3, #0x1
    B.NE  TaishanSimdReduceP01_label_166
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X20, X14, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X9, X29, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X25, X5, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X13, X17, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X3, X8, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X20, X5, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X6, X5, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X27, X12, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X22, X27, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X16, X8, X16
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X12, X4, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X19
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X5, X29, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X25
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X17, X26, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X4, X18, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X17, X13, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X23, D2
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X2, D3
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X29, D4
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X14, D5
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X12, X28, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    FMOV  X18, D6
    MOVZ  X28, #0x0, LSL #0
    SUB  X12, X28, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    FMOV  X21, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X21, D7
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X28, D8
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X28, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X28, D9
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X18, D10
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X18, V11.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X27, X14, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X18, D11
    MOVZ  X14, #0x0, LSL #0
    SUB  X27, X14, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X4, D12
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X8, D13
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X19, D14
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X3, X15, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X29, D15
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X20, D16
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X19, V17.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X11, X3, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X19, D17
    MOVZ  X3, #0x0, LSL #0
    SUB  X11, X3, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X13, X3, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X22, D18
    MOVZ  X3, #0x0, LSL #0
    SUB  X13, X3, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X3, D19
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    FMOV  X2, D20
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X20, X22, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X10, D21
    MOVZ  X22, #0x0, LSL #0
    SUB  X20, X22, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X27, D22
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X16, D23
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X9, D25
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X6, X14, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X20, D26
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X13, D27
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X25, X22, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    FMOV  X8, D28
    MOVZ  X22, #0x0, LSL #0
    SUB  X25, X22, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X9, D29
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    MOVZ  X2, #0xbb00, LSL #0
    MOVK  X2, #0xf150, LSL #16
    MOVK  X2, #0x8d72, LSL #32
    MOVK  X2, #0xe8ba, LSL #48
    MOVZ  X3, #0x6908, LSL #0
    MOVK  X3, #0xbf72, LSL #16
    MOVK  X3, #0x366e, LSL #32
    MOVK  X3, #0xa2e6, LSL #48
    MOVZ  X4, #0xfde2, LSL #0
    MOVK  X4, #0x3732, LSL #16
    MOVK  X4, #0x66e2, LSL #32
    MOVK  X4, #0x283c, LSL #48
    MOVZ  X5, #0xa7f1, LSL #0
    MOVK  X5, #0xaf8c, LSL #16
    MOVK  X5, #0xe32d, LSL #32
    MOVK  X5, #0x57ee, LSL #48
    MOVZ  X6, #0x6d90, LSL #0
    MOVK  X6, #0x851b, LSL #16
    MOVK  X6, #0x1621, LSL #32
    MOVK  X6, #0xa83d, LSL #48
    MOVZ  X7, #0xefd8, LSL #0
    MOVK  X7, #0x17a2, LSL #16
    MOVK  X7, #0xa92a, LSL #32
    MOVK  X7, #0x662e, LSL #48
    MOVZ  X8, #0xfa0b, LSL #0
    MOVK  X8, #0x667c, LSL #16
    MOVK  X8, #0x5c4b, LSL #32
    MOVK  X8, #0x141d, LSL #48
    MOVZ  X9, #0x9c25, LSL #0
    MOVK  X9, #0xd6a0, LSL #16
    MOVK  X9, #0x8560, LSL #32
    MOVK  X9, #0x80ec, LSL #48
    MOVZ  X10, #0x3bd1, LSL #0
    MOVK  X10, #0xb756, LSL #16
    MOVK  X10, #0xd7e5, LSL #32
    MOVK  X10, #0x838f, LSL #48
    MOVZ  X11, #0xfb76, LSL #0
    MOVK  X11, #0xc213, LSL #16
    MOVK  X11, #0xe063, LSL #32
    MOVK  X11, #0x6f51, LSL #48
    MOVZ  X12, #0x4f8d, LSL #0
    MOVK  X12, #0xff6e, LSL #16
    MOVK  X12, #0xd2fc, LSL #32
    MOVK  X12, #0x133c, LSL #48
    MOVZ  X13, #0x58e9, LSL #0
    MOVK  X13, #0xffb4, LSL #16
    MOVK  X13, #0x8687, LSL #32
    MOVK  X13, #0xa53, LSL #48
    MOVZ  X14, #0xdc70, LSL #0
    MOVK  X14, #0xb709, LSL #16
    MOVK  X14, #0x4b43, LSL #32
    MOVK  X14, #0x3cbf, LSL #48
    MOVZ  X15, #0xf274, LSL #0
    MOVK  X15, #0xad86, LSL #16
    MOVK  X15, #0x73a3, LSL #32
    MOVK  X15, #0xedcd, LSL #48
    MOVZ  X16, #0x8f, LSL #0
    MOVK  X16, #0x36bc, LSL #16
    MOVK  X16, #0xc76c, LSL #32
    MOVK  X16, #0xd3c3, LSL #48
    MOVZ  X17, #0x3044, LSL #0
    MOVK  X17, #0x9bf2, LSL #16
    MOVK  X17, #0x60e1, LSL #32
    MOVK  X17, #0x87f7, LSL #48
    MOVZ  X18, #0x2756, LSL #0
    MOVK  X18, #0x70c1, LSL #16
    MOVK  X18, #0xdd42, LSL #32
    MOVK  X18, #0x3f6d, LSL #48
    MOVZ  X19, #0x6398, LSL #0
    MOVK  X19, #0x9e99, LSL #16
    MOVK  X19, #0xd69a, LSL #32
    MOVK  X19, #0xc07e, LSL #48
    MOVZ  X20, #0x92df, LSL #0
    MOVK  X20, #0xfbfe, LSL #16
    MOVK  X20, #0x2cf6, LSL #32
    MOVK  X20, #0x1a8c, LSL #48
    MOVZ  X21, #0x8ba2, LSL #0
    MOVK  X21, #0x358d, LSL #16
    MOVK  X21, #0xbd0, LSL #32
    MOVK  X21, #0x3b06, LSL #48
    MOVZ  X22, #0x13f4, LSL #0
    MOVK  X22, #0x5507, LSL #16
    MOVK  X22, #0xd747, LSL #32
    MOVK  X22, #0xc8a5, LSL #48
    MOVZ  X23, #0x9a0, LSL #0
    MOVK  X23, #0xc1c4, LSL #16
    MOVK  X23, #0x36fe, LSL #32
    MOVK  X23, #0x1f81, LSL #48
    MOVZ  X25, #0xa3e7, LSL #0
    MOVK  X25, #0x9568, LSL #16
    MOVK  X25, #0xe1c7, LSL #32
    MOVK  X25, #0xd010, LSL #48
    MOVZ  X26, #0xb99c, LSL #0
    MOVK  X26, #0x7a93, LSL #16
    MOVK  X26, #0xad76, LSL #32
    MOVK  X26, #0x2b56, LSL #48
    MOVZ  X27, #0x59b8, LSL #0
    MOVK  X27, #0xcd68, LSL #16
    MOVK  X27, #0x7705, LSL #32
    MOVK  X27, #0x6fbb, LSL #48
    MOVZ  X28, #0xf00c, LSL #0
    MOVK  X28, #0x3e47, LSL #16
    MOVK  X28, #0x33b4, LSL #32
    MOVK  X28, #0x5110, LSL #48
    MOVZ  X29, #0x5615, LSL #0
    MOVK  X29, #0xced3, LSL #16
    MOVK  X29, #0x167d, LSL #32
    MOVK  X29, #0x62ff, LSL #48
    FMOV  D0, X11
    FMOV  V0.D[1], X20
    FMOV  D1, X28
    FMOV  V1.D[1], X12
    FMOV  D2, X27
    FMOV  V2.D[1], X26
    FMOV  D3, X19
    FMOV  V3.D[1], X20
    FMOV  D4, X17
    FMOV  V4.D[1], X2
    FMOV  D5, X5
    FMOV  V5.D[1], X23
    FMOV  D6, X6
    FMOV  V6.D[1], X13
    FMOV  D7, X27
    FMOV  V7.D[1], X29
    FMOV  D8, X23
    FMOV  V8.D[1], X15
    FMOV  D9, X9
    FMOV  V9.D[1], X12
    FMOV  D10, X11
    FMOV  V10.D[1], X12
    FMOV  D11, X19
    FMOV  V11.D[1], X13
    FMOV  D12, X14
    FMOV  V12.D[1], X17
    FMOV  D13, X17
    FMOV  V13.D[1], X13
    FMOV  D14, X14
    FMOV  V14.D[1], X23
    FMOV  D15, X13
    FMOV  V15.D[1], X15
    FMOV  D16, X22
    FMOV  V16.D[1], X10
    FMOV  D17, X8
    FMOV  V17.D[1], X11
    FMOV  D18, X29
    FMOV  V18.D[1], X17
    FMOV  D19, X10
    FMOV  V19.D[1], X15
    FMOV  D20, X14
    FMOV  V20.D[1], X15
    FMOV  D21, X27
    FMOV  V21.D[1], X22
    FMOV  D22, X4
    FMOV  V22.D[1], X20
    FMOV  D23, X9
    FMOV  V23.D[1], X7
    FMOV  D24, X18
    FMOV  V24.D[1], X15
    FMOV  D25, X3
    FMOV  V25.D[1], X10
    FMOV  D26, X14
    FMOV  V26.D[1], X19
    FMOV  D27, X17
    FMOV  V27.D[1], X8
    FMOV  D28, X10
    FMOV  V28.D[1], X7
    FMOV  D29, X21
    FMOV  V29.D[1], X5
    FMOV  D30, X14
    FMOV  V30.D[1], X25
    FMOV  D31, X22
    FMOV  V31.D[1], X3
    MOVZ  X29, #0xa, LSL #0
TaishanSimdReduceP01_label_247:
    USQADD  H31, H28
    SQNEG  D19, D27
    MOV  V21.16B, V26.16B
    FRINTN  V1.4S, V24.4S
    MUL  V11.4H, V18.4H, V8.H[0x3]
    UQSHRN H20, S15, #15
    SQDMULL2  V15.2D, V8.4S, V31.4S
    SADDW2  V9.8H, V28.8H, V8.16B
    SQDMLSL2 V12.2D, V31.4S, V19.S[0x3]
    UMAX  V11.16B, V19.16B, V17.16B
    SHSUB  V11.4H, V2.4H, V28.4H
    SCVTF  S21, S18
    SUQADD  D26, D17
    SRSRA  V15.8H, V22.8H, #6
    FSUB  V21.4S, V20.4S, V22.4S
    MOVI  V6.2D, #18374687579183251455
    TRN2  V8.2S, V18.2S, V10.2S
    SADDLV  D26, V4.4S
    SSRA  V9.4S, V13.4S, #21
    FCVTZS  D11, D9
    SMLSL V7.2D, V1.2S, V9.S[0x0]
    SQSHL B28, B7, #0x6
    FDIV  V16.4S, V29.4S, V22.4S
    FCVTMS  V29.2S, V22.2S
    CMHI  D15, D4, D17
    FCMLE  S8, S18, #0.0
    SQDMLAL2 V16.4S, V7.8H, V15.H[0x6]
    SQRDMULH  S7, S7, S29
    SRSHR D6, D26, #27
    SQDMLAL V7.2D, V29.2S, V22.S[0x2]
    FABD  D26, D26, D26
    BSL  V16.16B, V0.16B, V28.16B
    SMIN  V0.4S, V24.4S, V11.4S
    DUP V21.8H, W6
    MUL  V30.8H, V4.8H, V6.H[0x5]
    FABD  V15.4S, V1.4S, V10.4S
    UQSHRN B20, H31, #7
    SQDMLAL  S26, H17, H16
    SADDLV  S17, V19.8H
    FRSQRTS  V8.2D, V17.2D, V27.2D
    SMAXV  S10, V15.4S
    SQSHLU S28, S20, #0x8
    UQSHL V9.2D, V7.2D, #0x3
    SQRSHRN S6, D10, #21
    UQRSHRN2 V22.4S, V6.2D, #8
    SXTL2 V5.4S, V4.8H
    SRSHL  V25.2S, V13.2S, V1.2S
    FMULX V10.2D, V16.2D, V1.D[0x1]
    FMINP  V13.2S, V1.2S, V21.2S
    USHLL2 V18.4S, V15.8H, #0xc
    SQXTUN  B26, H15
    DUP H29, V11.H[0x4]
    USHLL2 V5.2D, V20.4S, #0xd
    UABA  V8.16B, V9.16B, V16.16B
    TBL  V22.8B, { V0.16B, V1.16B, V2.16B, V3.16B }, V28.8B
    FCMGT  D2, D11, #0.0
    SMULL2  V21.2D, V19.4S, V5.4S
    SQSHRN2 V23.8H, V23.4S, #8
    UZP1  V17.2S, V13.2S, V9.2S
    CMHS  V13.16B, V29.16B, V24.16B
    CMEQ  D5, D12, #0
    NEG  D15, D25
    SUB  D22, D6, D12
    FCVTMU  V24.4S, V13.4S
    DUP  V28.2S, V7.S[0x1]
    SQSHLU  V24.2S, V3.2S, #0x16
    URSHR  V24.8B, V11.8B, #2
    SMINV  B11, V12.8B
    INS V7.H[0x4], V0.H[0x3]
    SQRSHRUN2 V26.16B, V0.8H, #1
    SQXTUN  H24, S21
    SQRSHRN2 V9.16B, V26.8H, #3
    UQSUB  S25, S19, S24
    PMUL  V28.16B, V28.16B, V2.16B
    CMHI  D21, D4, D27
    UQSHL  B19, B3, B24
    SQSUB  D27, D6, D5
    ORR  V11.4S, #0xcc, LSL #16
    FCVTXN  S12, D8
    DUP B14, V6.B[0x3]
    SQDMLAL2  V9.2D, V12.4S, V23.4S
    MOV V15.H[0x2], V11.H[0x5]
    FCVTPU  V27.2S, V8.2S
    FMAXNMP D5, V6.2D
    SMULL V25.2D, V11.2S, V7.S[0x3]
    UQRSHRN S13, D28, #7
    UXTL2 V26.2D, V7.4S
    SQSHLU  V19.8B, V2.8B, #0x4
    UQRSHRN2 V28.8H, V29.4S, #11
    SXTL V26.2D, V28.2S
    UQSHL  S21, S28, S6
    FRSQRTE  S15, S28
    INS V7.S[0x0], V24.S[0x0]
    SMOV  X5, V25.S[0x3]
    SQSHL D7, D21, #0x2a
    FCMGT  D19, D29, D20
    SQDMLAL S26, H27, V11.H[0x2]
    FMINNMP  V6.4S, V13.4S, V21.4S
    CMGE  D4, D29, #0
    SQSHRN2 V2.16B, V29.8H, #3
    FRSQRTS  D29, D7, D17
    SQDMLSL2 V24.2D, V27.4S, V7.S[0x3]
    FRSQRTS  S9, S8, S8
    SQRSHRN V24.2S, V7.2D, #30
    FMLA V14.2D, V3.2D, V9.D[0x1]
    SRSRA V28.2D, V20.2D, #15
    SQXTUN  H25, S15
    CMEQ  D24, D7, #0
    UQADD  B11, B21, B10
    FMLA V26.2D, V14.2D, V23.D[0x1]
    USHLL2 V4.8H, V11.16B, #0x6
    USQADD  D19, D23
    SQDMLSL  S25, H8, H14
    RSHRN V4.4H, V27.4S, #14
    SQDMLSL  V7.2D, V20.2S, V27.2S
    ADDV  H3, V15.8H
    DUP  V13.4S, V22.S[0x2]
    SQSHRUN H17, S9, #15
    MOV  V19.16B, V23.16B
    URSRA  V5.2S, V6.2S, #22
    FCVTNS  D21, D9
    FABS  V3.2S, V24.2S
    SUB  D7, D25, D2
    FCVTZU D7, D10, #62
    SQSHL  S8, S5, S13
    FABD  S18, S20, S4
    RSHRN V26.2S, V6.2D, #14
    SCVTF  V17.2S, V5.2S, #15
    SMLSL V3.2D, V15.2S, V17.S[0x1]
    DUP H6, V29.H[0x1]
    SQSHRUN2 V23.16B, V11.8H, #1
    SQSHRUN B6, H5, #5
    SADDW  V15.4S, V11.4S, V8.4H
    MLS  V6.2S, V21.2S, V19.2S
    SSHL  D12, D24, D21
    UMAXP  V21.8B, V22.8B, V6.8B
    ADDP  V24.2S, V5.2S, V27.2S
    SQSHRUN V14.2S, V21.2D, #14
    CMGT  V15.16B, V0.16B, #0
    MUL  V4.4H, V12.4H, V22.4H
    UQADD  H22, H1, H28
    SQRSHL  B29, B31, B30
    FADDP D11, V25.2D
    FCVTZS V30.2D, V21.2D, #13
    SQRSHRUN2 V19.16B, V4.8H, #8
    INS V26.S[0x1], W14
    SSHR V4.2D, V30.2D, #4
    SQRSHRN2 V21.8H, V17.4S, #14
    SHRN V2.4H, V28.4S, #15
    INS V21.D[0x1], V23.D[0x1]
    USUBL  V21.8H, V5.8B, V0.8B
    FMULX  S17, S16, S5
    SRSHR  V26.16B, V18.16B, #4
    FRECPS  V16.4S, V17.4S, V1.4S
    FCMGT  V3.2S, V26.2S, #0.0
    SQDMULH H29, H22, V9.H[0x7]
    SSHLL V21.4S, V16.4H, #0x7
    UQSHL H15, H20, #0x6
    SLI  V6.4H, V1.4H, #0x5
    FMOV  V24.2S, #-26.00000000
    UABAL  V1.4S, V17.4H, V5.4H
    MLS  V14.4H, V3.4H, V0.H[0x7]
    SUB  V2.8H, V25.8H, V7.8H
    MOVI  V7.4S, #0xcd
    FMLS S17, S8, V20.S[0x0]
    FCVTZU  V31.4S, V11.4S
    UADDLV  D17, V11.4S
    SQRSHL  B23, B17, B7
    SHL  V8.4H, V15.4H, #0x6
    FMLA V31.2D, V23.2D, V14.D[0x1]
    USUBW2  V25.8H, V10.8H, V21.16B
    UQXTN  S29, D20
    FRSQRTS  V9.4S, V26.4S, V30.4S
    SMINP  V28.4S, V5.4S, V5.4S
    SABA  V23.8B, V10.8B, V11.8B
    FMULX  V16.2S, V16.2S, V2.2S
    UQADD  H25, H8, H21
    FCVTAU  S19, S2
    RSUBHN  V13.2S, V16.2D, V0.2D
    FCVTZU  V11.4S, V1.4S
    SLI  V25.2S, V2.2S, #0x11
    CMGE  D31, D25, #0
    SQRSHL  D2, D29, D19
    UADALP  V16.2D, V28.4S
    UADDL2  V17.4S, V14.8H, V24.8H
    UQXTN  B18, H15
    FCMGE  D21, D28, #0.0
    SABAL  V31.2D, V9.2S, V3.2S
    SADDL2  V7.4S, V14.8H, V31.8H
    FCVTZS D6, D21, #8
    SQDMLSL V12.2D, V1.2S, V1.S[0x0]
    SQSHL  V30.8H, V24.8H, V22.8H
    SQABS  S27, S7
    UMOV W17, V17.S[0x3]
    FCVTZU  V14.2S, V25.2S
    CMEQ  D1, D6, D21
    MLA  V7.4S, V16.4S, V8.S[0x0]
    SQSHLU  V19.8B, V2.8B, #0x2
    SQDMLAL2  V9.4S, V10.8H, V9.8H
    FMINP S14, V28.2S
    SUBS  X29, X29, #0x1
    B.NE  TaishanSimdReduceP01_label_247
    MOVZ  X5, #0xbb00, LSL #0
    MOVK  X5, #0xf150, LSL #16
    MOVK  X5, #0x8d72, LSL #32
    MOVK  X5, #0xe8ba, LSL #48
    SUB  X9, X5, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    MOVZ  X29, #0x6908, LSL #0
    MOVK  X29, #0xbf72, LSL #16
    MOVK  X29, #0x366e, LSL #32
    MOVK  X29, #0xa2e6, LSL #48
    SUB  X8, X29, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X4, #0xfde2, LSL #0
    MOVK  X4, #0x3732, LSL #16
    MOVK  X4, #0x66e2, LSL #32
    MOVK  X4, #0x283c, LSL #48
    SUB  X3, X4, X4
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    MOVZ  X25, #0xbb00, LSL #0
    MOVK  X25, #0xf150, LSL #16
    MOVK  X25, #0x8d72, LSL #32
    MOVK  X25, #0xe8ba, LSL #48
    SUB  X17, X25, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    MOVZ  X13, #0x6d90, LSL #0
    MOVK  X13, #0x851b, LSL #16
    MOVK  X13, #0x1621, LSL #32
    MOVK  X13, #0xa83d, LSL #48
    SUB  X12, X13, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    MOVZ  X9, #0xefd8, LSL #0
    MOVK  X9, #0x17a2, LSL #16
    MOVK  X9, #0xa92a, LSL #32
    MOVK  X9, #0x662e, LSL #48
    SUB  X25, X9, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    MOVZ  X29, #0xefd8, LSL #0
    MOVK  X29, #0x17a2, LSL #16
    MOVK  X29, #0xa92a, LSL #32
    MOVK  X29, #0x662e, LSL #48
    SUB  X14, X29, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    MOVZ  X13, #0x3bd1, LSL #0
    MOVK  X13, #0xb756, LSL #16
    MOVK  X13, #0xd7e5, LSL #32
    MOVK  X13, #0x838f, LSL #48
    SUB  X3, X13, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    MOVZ  X25, #0x3bd1, LSL #0
    MOVK  X25, #0xb756, LSL #16
    MOVK  X25, #0xd7e5, LSL #32
    MOVK  X25, #0x838f, LSL #48
    SUB  X27, X25, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    MOVZ  X17, #0xf274, LSL #0
    MOVK  X17, #0xad86, LSL #16
    MOVK  X17, #0x73a3, LSL #32
    MOVK  X17, #0xedcd, LSL #48
    SUB  X18, X17, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    MOVZ  X6, #0xf274, LSL #0
    MOVK  X6, #0xad86, LSL #16
    MOVK  X6, #0x73a3, LSL #32
    MOVK  X6, #0xedcd, LSL #48
    SUB  X26, X6, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    MOVZ  X3, #0x6398, LSL #0
    MOVK  X3, #0x9e99, LSL #16
    MOVK  X3, #0xd69a, LSL #32
    MOVK  X3, #0xc07e, LSL #48
    SUB  X21, X3, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    MOVZ  X15, #0x92df, LSL #0
    MOVK  X15, #0xfbfe, LSL #16
    MOVK  X15, #0x2cf6, LSL #32
    MOVK  X15, #0x1a8c, LSL #48
    SUB  X13, X15, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    MOVZ  X9, #0x9a0, LSL #0
    MOVK  X9, #0xc1c4, LSL #16
    MOVK  X9, #0x36fe, LSL #32
    MOVK  X9, #0x1f81, LSL #48
    SUB  X8, X9, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X15, #0x3bd1, LSL #0
    MOVK  X15, #0xb756, LSL #16
    MOVK  X15, #0xd7e5, LSL #32
    MOVK  X15, #0x838f, LSL #48
    SUB  X12, X15, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    MOVZ  X4, #0xf00c, LSL #0
    MOVK  X4, #0x3e47, LSL #16
    MOVK  X4, #0x33b4, LSL #32
    MOVK  X4, #0x5110, LSL #48
    SUB  X6, X4, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X26, X16, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    FMOV  X27, V2.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X27, D2
    MOVZ  X7, #0xff, LSL #0
    SUB  X22, X7, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X17, V3.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X17, D3
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X25, V4.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X25, D4
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X2, X22, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X28, D5
    MOVZ  X22, #0x0, LSL #0
    SUB  X2, X22, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    FMOV  X20, D6
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X14, X22, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X23, D7
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x3fc0, LSL #32
    SUB  X14, X22, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X20, X21, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X3, D8
    MOVZ  X21, #0xf000, LSL #0
    SUB  X20, X21, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X21, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x3fc0, LSL #16
    MOVK  X13, #0x3fc0, LSL #48
    SUB  X11, X13, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X21, D9
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x3fc0, LSL #16
    MOVK  X13, #0x3fc0, LSL #48
    SUB  X11, X13, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X21, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X20, X22, X21
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X21, D10
    MOVZ  X22, #0x0, LSL #0
    SUB  X20, X22, X21
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X18, X7, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X17, D11
    MOVZ  X7, #0x0, LSL #0
    SUB  X18, X7, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x6e00, LSL #32
    MOVK  X25, #0xe1c9, LSL #48
    SUB  X7, X25, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X2, D12
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0x6dff, LSL #32
    MOVK  X25, #0xe1c9, LSL #48
    SUB  X7, X25, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X21, V13.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X21, D13
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0x3e2f, LSL #16
    SUB  X18, X25, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X13, X19, X12
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X12, D14
    MOVZ  X19, #0x0, LSL #0
    SUB  X13, X19, X12
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X27, X5, X23
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X23, D15
    MOVZ  X5, #0x3fc0, LSL #0
    SUB  X27, X5, X23
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X10, X2, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X4, D16
    MOVZ  X2, #0x0, LSL #0
    SUB  X10, X2, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X10, D17
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X25, V18.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X25, D18
    MOVZ  X22, #0xff, LSL #0
    SUB  X11, X22, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X25, V19.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X26, X23, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    FMOV  X25, D19
    MOVZ  X23, #0x0, LSL #0
    SUB  X26, X23, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    FMOV  X17, D20
    MOVZ  X6, #0xff, LSL #0
    SUB  X25, X6, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X10, X3, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X13, D21
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X10, X3, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X21, V22.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X21, D22
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X6, D23
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X4, D25
    MOVZ  X29, #0xf000, LSL #0
    MOVK  X29, #0xfffe, LSL #16
    SUB  X5, X29, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X3, D26
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X7, D27
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X6, D28
TaishanSimdReduceP01_label_201:
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
TaishanSimdReduceP01_label_217:
    FMOV  X10, V29.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X10, D29
    MOVZ  X18, #0xff, LSL #0
    SUB  X23, X18, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X15
    FMOV  V0.D[1], X28
    FMOV  D1, X4
    FMOV  V1.D[1], X14
    FMOV  D2, X17
    FMOV  V2.D[1], X23
    FMOV  D3, X21
    FMOV  V3.D[1], X29
    FMOV  D4, X5
    FMOV  V4.D[1], X28
    FMOV  D5, X14
    FMOV  V5.D[1], X28
    FMOV  D6, X20
    FMOV  V6.D[1], X25
    FMOV  D7, X7
    FMOV  V7.D[1], X3
    FMOV  D8, X26
    FMOV  V8.D[1], X6
    FMOV  D9, X16
    FMOV  V9.D[1], X6
    FMOV  D10, X8
    FMOV  V10.D[1], X16
    FMOV  D11, X12
    FMOV  V11.D[1], X15
    FMOV  D12, X2
    FMOV  V12.D[1], X27
    FMOV  D13, X7
    FMOV  V13.D[1], X10
    FMOV  D14, X3
    FMOV  V14.D[1], X5
    FMOV  D15, X15
    FMOV  V15.D[1], X29
    FMOV  D16, X26
    FMOV  V16.D[1], X10
    FMOV  D17, X21
    FMOV  V17.D[1], X17
    FMOV  D18, X12
    FMOV  V18.D[1], X15
    FMOV  D19, X18
    FMOV  V19.D[1], X12
    FMOV  D20, X16
    FMOV  V20.D[1], X25
    FMOV  D21, X25
    FMOV  V21.D[1], X5
    FMOV  D22, X10
    FMOV  V22.D[1], X2
    FMOV  D23, X16
    FMOV  V23.D[1], X11
    FMOV  D24, X12
    FMOV  V24.D[1], X14
    FMOV  D25, X10
    FMOV  V25.D[1], X21
    FMOV  D26, X7
    FMOV  V26.D[1], X19
    FMOV  D27, X17
    FMOV  V27.D[1], X29
    FMOV  D28, X9
    FMOV  V28.D[1], X19
    FMOV  D29, X3
    FMOV  V29.D[1], X21
    FMOV  D30, X12
    FMOV  V30.D[1], X23
    FMOV  D31, X13
    FMOV  V31.D[1], X15
    MOVZ  X14, #0xa, LSL #0
TaishanSimdReduceP01_label_327:
    UQSHL V17.2D, V29.2D, #0x14
    SQRSHRN B12, H9, #7
    FMLS V27.4S, V29.4S, V10.S[0x2]
    CMGT  D25, D17, #0
    SMINV  H12, V22.4H
    FCMLE  D11, D10, #0.0
    FMLS V27.2S, V16.2S, V31.S[0x0]
    SQRSHRN H12, S31, #4
    USHLL2 V26.2D, V31.4S, #0x3
    FCMGE  V11.4S, V14.4S, V9.4S
    SQXTN  B10, H10
    SQRSHL  V5.8B, V29.8B, V10.8B
    AND  V12.8B, V30.8B, V5.8B
    EOR  V27.8B, V5.8B, V29.8B
    FADDP  V23.4S, V18.4S, V8.4S
    SXTL2 V20.2D, V6.4S
    AND  V11.8B, V4.8B, V4.8B
    SADDLV  S27, V12.4H
    FCVTAU  V19.2S, V24.2S
    UQRSHRN2 V5.4S, V11.2D, #13
    SQSHL D17, D19, #0x0
    UQSUB  V23.8H, V19.8H, V18.8H
    CMHS  D2, D29, D12
    SQADD  B27, B13, B6
    MUL  V27.4H, V28.4H, V12.H[0x2]
    UMINV  S16, V10.4S
    SQRSHL  V2.2D, V26.2D, V12.2D
    SMOV  X21, V7.S[0x2]
    SQSUB  V4.2D, V4.2D, V8.2D
    ADDV  S9, V17.4S
    FSUB  V10.2S, V13.2S, V2.2S
    SQNEG  D11, D12
    UADDL2  V18.8H, V26.16B, V13.16B
    FCVTXN  V28.2S, V11.2D
    FCMGE  D27, D12, #0.0
    USRA  V12.4H, V20.4H, #9
    USHR  V29.16B, V31.16B, #2
    TBL  V18.16B, { V31.16B, V0.16B, V1.16B }, V15.16B
    SQDMULL  D27, S5, S30
    SCVTF S25, S12, #18
    SMINV  H30, V21.8H
    FRINTX  V9.2D, V15.2D
    URHADD  V20.4S, V2.4S, V0.4S
    SQNEG  H10, H9
    UQSHL B5, B4, #0x6
    RSHRN2 V12.16B, V22.8H, #7
    UMAXP  V5.2S, V28.2S, V14.2S
    UQSHL D12, D20, #0xa
    MOV V17.D[0x0], X26
    MUL  V16.4H, V3.4H, V4.H[0x6]
    FCMGT  D29, D10, #0.0
    FACGT  V18.2S, V2.2S, V4.2S
    SMLSL2 V3.4S, V20.8H, V10.H[0x1]
    UZP2  V27.8H, V6.8H, V14.8H
    FMUL S30, S24, V25.S[0x3]
    SSHLL V3.8H, V3.8B, #0x6
    FMAXNMP D14, V2.2D
    SSRA  V22.8B, V29.8B, #2
    BIC  V24.4H, #0x72, LSL #8
    UQXTN2  V21.4S, V4.2D
    RSHRN V5.2S, V11.2D, #8
    UADDLV  D13, V25.4S
    SADDW  V4.4S, V9.4S, V19.4H
    FCVTZS  S18, S16
    SQDMULL V6.2D, V30.2S, V22.S[0x1]
    USUBW2  V10.8H, V22.8H, V30.16B
    SQSHL V13.2D, V3.2D, #0xc
    UQXTN  S16, D16
    RSHRN V27.2S, V17.2D, #7
    TRN2  V17.4H, V3.4H, V26.4H
    SQSHRN H2, S6, #6
    SSUBL  V30.2D, V19.2S, V15.2S
    FCVTPU  D17, D28
    CMHS  V1.2S, V10.2S, V20.2S
    URSHR D22, D26, #38
    SQRSHRN V18.8B, V15.8H, #7
    FADD  V2.2S, V21.2S, V31.2S
    FCMGT  S13, S9, S26
    FMAXV  S26, V4.4S
    FCMGT  S28, S5, S4
    SQSHRN H14, S13, #4
    MVNI  V20.8H, #0x68
    FRECPS  S13, S18, S17
    SADDW2  V28.2D, V6.2D, V26.4S
    SMLSL2  V14.2D, V4.4S, V20.4S
    FACGE  D12, D15, D21
    USUBW  V5.2D, V2.2D, V1.2S
    FRECPS  S31, S20, S3
    SRI D25, D7, #37
    UQSHL B4, B18, #0x5
    UABAL  V17.2D, V2.2S, V12.2S
    CMGE  V12.2S, V13.2S, #0
    SMOV  X6, V9.S[0x2]
TaishanSimdReduceP01_label_152:
    DUP V27.16B, W6
    REV32  V5.8H, V14.8H
    SQADD  H0, H5, H28
    BIT  V25.8B, V17.8B, V6.8B
    BIT  V31.16B, V25.16B, V28.16B
    FMULX V30.4S, V3.4S, V8.S[0x0]
    FRINTP  V21.2D, V5.2D
    FRINTA  V15.2D, V21.2D
    DUP S28, V5.S[0x3]
    FRINTA  V26.4S, V8.4S
    UMAXV  B19, V30.8B
    SSHR  V14.8H, V5.8H, #12
    SMLSL2  V12.4S, V18.8H, V21.8H
    NOT  V24.8B, V4.8B
    SQDMLAL V1.2D, V11.2S, V23.S[0x1]
    RSHRN2 V26.8H, V5.4S, #4
    FMUL V1.4S, V27.4S, V20.S[0x1]
    FCVTNU  D0, D27
    SMIN  V0.8B, V9.8B, V16.8B
    SQSHRN V14.2S, V17.2D, #30
    SQDMLSL  V27.4S, V26.4H, V4.4H
    SMAX  V11.4H, V6.4H, V25.4H
    FCMEQ  D29, D8, #0.0
    SSRA  V31.2S, V2.2S, #26
    SHL V23.2D, V14.2D, #0x21
    FMAXNMP  V8.2D, V21.2D, V14.2D
    SQSHRUN S17, D0, #23
    UMULL2  V31.8H, V1.16B, V3.16B
    DUP V21.2D, V30.D[0x0]
    SQSHL  V1.8H, V0.8H, V24.8H
    UQADD  B14, B19, B6
    SSHLL V2.2D, V28.2S, #0x9
    SQSHL  V3.8H, V4.8H, V18.8H
    EXT  V25.16B, V10.16B, V9.16B, #0x0
    FCVTPS  D14, D28
    FMULX  V1.2D, V9.2D, V16.2D
    UADDLV  H10, V29.16B
    SQRSHRUN V18.4H, V25.4S, #16
    UXTL2 V13.4S, V4.8H
    SQRDMULH H27, H1, V14.H[0x1]
    PMULL  V9.8H, V17.8B, V31.8B
    SQDMLSL2 V24.2D, V18.4S, V27.S[0x3]
    FRINTI  V3.2S, V20.2S
    TBX  V16.16B, { V16.16B, V17.16B, V18.16B, V19.16B }, V10.16B
    FCVTPS  D16, D2
    SMAXV  H6, V1.4H
    UQSHL  V20.2S, V4.2S, #0x1f
    SHRN2 V20.4S, V31.2D, #26
    USRA  V14.16B, V13.16B, #2
    RSHRN2 V11.16B, V31.8H, #7
    INS V23.S[0x3], V0.S[0x3]
    SQSHL S5, S7, #0x6
    FRINTX  V9.4S, V23.4S
    SQDMULL V14.2D, V25.2S, V24.S[0x1]
    SHL  V30.16B, V24.16B, #0x4
    UQRSHRN V28.4H, V25.4S, #11
    URSHL  D7, D10, D1
    UQSHL  S17, S7, S18
    PMULL2  V11.8H, V29.16B, V31.16B
    SUQADD  H30, H2
    SQABS  S16, S23
    USRA V2.2D, V2.2D, #58
    FMINP  V5.4S, V19.4S, V30.4S
    UMLAL V3.4S, V10.4H, V7.H[0x3]
    UQSHRN2 V27.8H, V30.4S, #14
    URSHL  D5, D14, D23
    UABA  V14.8H, V18.8H, V7.8H
    FRSQRTS  D16, D3, D9
    SQRSHRN2 V3.16B, V6.8H, #5
    INS V30.S[0x1], V1.S[0x1]
    SCVTF  V18.2S, V26.2S
    MVNI  V27.4S, #0xa8, MSL #16
    FACGT  S15, S0, S26
    SRSRA D30, D5, #14
    FCVTMS  S25, S5
    FCVTNU  V31.2S, V2.2S
    SQSHLU  V14.8H, V24.8H, #0xe
    SQSHL  V22.8H, V1.8H, #0x2
    UQSHL  V26.2S, V22.2S, #0x16
    SQSHRN V19.2S, V6.2D, #1
    MOV V19.B[0x4], W16
    FCVTZS S11, S3, #10
    SQRSHRN2 V15.4S, V16.2D, #24
    SQSHRN S11, D18, #24
    XTN  V25.2S, V17.2D
    INS V2.D[0x0], X12
    FCVTAS  S19, S11
    UABA  V21.2S, V11.2S, V16.2S
    UADDL  V10.4S, V17.4H, V12.4H
    FCMGE  S30, S0, #0.0
    SMLAL2 V0.4S, V17.8H, V1.H[0x7]
    SQSHRN2 V9.16B, V25.8H, #2
    FACGT  V26.2S, V11.2S, V22.2S
    URSRA D24, D1, #36
    UQSHL V5.2D, V22.2D, #0x10
    INS V15.S[0x1], V10.S[0x1]
    SQDMLSL D18, S10, V25.S[0x1]
    FMAXP S18, V21.2S
    SRSRA V16.2D, V8.2D, #60
    USHR D3, D0, #51
    DUP  V25.4S, V5.S[0x2]
    SQRDMULH S25, S20, V21.S[0x1]
    MOV H21, V15.H[0x0]
    UMINV  B2, V3.8B
    SQDMLAL2  V5.2D, V10.4S, V12.4S
    SQDMULL2  V26.2D, V17.4S, V3.4S
    FSUB  V25.2D, V11.2D, V2.2D
    SUBS  X14, X14, #0x1
    B.NE  TaishanSimdReduceP01_label_327
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X28, X7, X4
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X19, X12, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X14, X29, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X10
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X9, X20, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X11, X3, X17
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X19
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    MOVZ  X28, #0x0, LSL #0
TaishanSimdReduceP01_label_71:
    SUB  X20, X28, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X29
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X14, D2
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X25, X29, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    FMOV  X14, D3
    MOVZ  X29, #0x0, LSL #0
    SUB  X25, X29, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X6, D4
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X17
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X17, D5
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X17
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X16, X14, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X29, D6
    MOVZ  X14, #0x0, LSL #0
    SUB  X16, X14, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X6, D7
    MOVZ  X26, #0x7f8, LSL #0
    SUB  X28, X26, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X11, X23, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X6, D8
    MOVZ  X23, #0x0, LSL #0
    SUB  X11, X23, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X12, #0x7f, LSL #0
    SUB  X16, X12, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X2, D9
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #32
    SUB  X9, X29, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X14, D10
    MOVZ  X29, #0x7f7, LSL #0
    MOVK  X29, #0x1, LSL #16
    MOVK  X29, #0xffff, LSL #32
    SUB  X9, X29, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X22, V11.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X22, D11
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X19, V12.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X19
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X19, D12
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X2, X9, X19
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X18, D13
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X20, D14
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x7fff, LSL #16
    SUB  X7, X10, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X11, D15
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xffff, LSL #32
    SUB  X7, X10, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X20, D16
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x3ff8, LSL #48
    SUB  X13, X9, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X13, D17
    MOVZ  X5, #0x7f8, LSL #0
    SUB  X22, X5, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X11, D18
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x3ff8, LSL #16
    SUB  X7, X16, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X10, V19.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X10, D19
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X5, D20
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X20, D21
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X19, V22.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X19, D22
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X25, V23.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X25, D23
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x6, LSL #32
    SUB  X4, X15, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X5, V25.D[1]
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #48
    SUB  X8, X11, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X5, D25
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #48
    SUB  X8, X11, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X12, D26
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xff57, LSL #16
    MOVK  X3, #0xff57, LSL #48
    SUB  X22, X3, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X16, D27
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xff57, LSL #16
    MOVK  X3, #0xff57, LSL #48
    SUB  X22, X3, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X9, D28
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X4, D29
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X15, X23, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
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
    FMOV  V0.D[1], X26
    FMOV  D1, X19
    FMOV  V1.D[1], X15
    FMOV  D2, X29
    FMOV  V2.D[1], X12
    FMOV  D3, X23
    FMOV  V3.D[1], X13
    FMOV  D4, X15
    FMOV  V4.D[1], X29
    FMOV  D5, X16
    FMOV  V5.D[1], X28
    FMOV  D6, X21
    FMOV  V6.D[1], X23
    FMOV  D7, X20
    FMOV  V7.D[1], X15
    FMOV  D8, X7
    FMOV  V8.D[1], X7
    FMOV  D9, X12
    FMOV  V9.D[1], X29
    FMOV  D10, X25
    FMOV  V10.D[1], X14
    FMOV  D11, X18
    FMOV  V11.D[1], X22
    FMOV  D12, X22
    FMOV  V12.D[1], X29
    FMOV  D13, X20
    FMOV  V13.D[1], X11
    FMOV  D14, X2
    FMOV  V14.D[1], X5
    FMOV  D15, X27
    FMOV  V15.D[1], X8
    FMOV  D16, X5
    FMOV  V16.D[1], X25
    FMOV  D17, X2
    FMOV  V17.D[1], X8
    FMOV  D18, X20
    FMOV  V18.D[1], X16
    FMOV  D19, X12
    FMOV  V19.D[1], X28
    FMOV  D20, X3
    FMOV  V20.D[1], X17
    FMOV  D21, X28
    FMOV  V21.D[1], X23
    FMOV  D22, X20
    FMOV  V22.D[1], X19
    FMOV  D23, X9
    FMOV  V23.D[1], X8
    FMOV  D24, X22
    FMOV  V24.D[1], X7
    FMOV  D25, X16
    FMOV  V25.D[1], X21
    FMOV  D26, X23
    FMOV  V26.D[1], X21
    FMOV  D27, X3
    FMOV  V27.D[1], X21
    FMOV  D28, X20
    FMOV  V28.D[1], X23
    FMOV  D29, X19
    FMOV  V29.D[1], X3
    FMOV  D30, X17
    FMOV  V30.D[1], X16
    FMOV  D31, X7
    FMOV  V31.D[1], X25
    MOVZ  X27, #0xf, LSL #0
TaishanSimdReduceP01_label_408:
    FABD  S26, S8, S31
    INS V11.B[0xf], W4
    SQXTUN  S27, D25
    ADDHN  V28.8B, V30.8H, V12.8H
    MOV V6.H[0x6], W9
    FSUB  V10.4S, V10.4S, V22.4S
    FCMGE  D28, D22, D24
    SUQADD  D10, D23
    RSHRN V11.2S, V6.2D, #13
    SMLAL V19.4S, V15.4H, V6.H[0x6]
    UQRSHRN V10.8B, V17.8H, #2
    SQRSHL  B6, B28, B24
    SABDL2  V28.8H, V14.16B, V13.16B
    SSHLL V29.4S, V28.4H, #0x2
    RADDHN  V27.2S, V19.2D, V12.2D
    FMOV  V30.2S, #-0.17187500
    SHLL  V3.8H, V28.8B, #8
    SQRDMULH S17, S26, V31.S[0x2]
    FCMEQ  V30.4S, V15.4S, V29.4S
    SABA  V9.8H, V24.8H, V29.8H
    SMLAL V29.2D, V0.2S, V19.S[0x0]
    FCVTZS V29.2D, V30.2D, #52
    ABS  V0.16B, V8.16B
    MOV V24.S[0x3], V6.S[0x1]
    MOV V27.D[0x0], V25.D[0x0]
    SUQADD  B11, B0
    DUP V4.2D, V18.D[0x0]
    FMIN  V30.4S, V18.4S, V10.4S
    SQSHL  D19, D8, D22
    UQADD  H5, H29, H3
    USRA  V12.2S, V15.2S, #3
    SQDMLAL S9, H3, V5.H[0x4]
    EOR  V17.8B, V24.8B, V18.8B
    SQDMLSL  D8, S26, S20
    SQRDMULH  V25.4S, V10.4S, V26.4S
    FRECPS  D10, D31, D12
    SQSHL S30, S22, #0x1
    SQABS  B30, B11
    SCVTF  S20, S27
    SQDMLAL D21, S14, V12.S[0x3]
    UMAXV  H14, V1.4H
    CMTST  D1, D3, D1
    SQSHRN B5, H14, #1
    UHADD  V6.4H, V28.4H, V29.4H
    SMLSL2  V22.4S, V17.8H, V1.8H
    SQDMULH H31, H31, V5.H[0x5]
    NEG  V31.8B, V26.8B
    FMLS V24.2S, V20.2S, V29.S[0x0]
    SRSRA  V26.16B, V31.16B, #5
    SUBHN  V5.2S, V21.2D, V25.2D
    UADDLP  V25.8H, V23.16B
    CMGE  V25.8H, V28.8H, #0
    FMULX S1, S3, V7.S[0x0]
    FRSQRTS  V31.4S, V1.4S, V19.4S
    MOV V29.S[0x3], V13.S[0x1]
    SQRDMULH  S31, S19, S28
    SSRA D15, D7, #28
    SMLAL  V30.2D, V26.2S, V17.2S
    MOVI  V12.8B, #0x5f
    SQDMULL V22.2D, V16.2S, V10.S[0x1]
    UMLSL V13.4S, V20.4H, V15.H[0x5]
    USUBW  V30.8H, V29.8H, V29.8B
    UQXTN  V31.4H, V10.4S
    FCMGT  D9, D31, D25
    UMLSL2  V24.4S, V12.8H, V9.8H
    URSHR  V1.8H, V30.8H, #16
    SQDMLSL  D22, S22, S29
    FMIN  V13.2D, V31.2D, V11.2D
    FCVTAS  S11, S27
    SHRN2 V17.4S, V6.2D, #5
    SQRDMULH  S23, S10, S27
    SQNEG  S1, S14
    SADDLP  V16.4H, V6.8B
    UQRSHRN B16, H16, #5
    FCVTZS  V23.4S, V22.4S
    SQDMULH  S0, S3, S13
    FCVTZU  V30.4S, V17.4S
    SQXTUN  B20, H12
    UXTL2 V9.8H, V31.16B
    SMULL2 V11.4S, V4.8H, V3.H[0x1]
    RSHRN V29.8B, V18.8H, #6
    UQSHL  D22, D7, D1
    SQDMULL S25, H6, V9.H[0x1]
    FMAXNMP D18, V23.2D
    FMUL S4, S25, V18.S[0x2]
    RSHRN V17.4H, V10.4S, #13
    SADDLV  D29, V20.4S
    SSHLL V3.4S, V4.4H, #0x1
    FMAX  V3.2S, V30.2S, V31.2S
    MOV D28, V22.D[0x1]
    FCVTZS S21, S25, #14
    ORR  V9.2S, #0x6b, LSL #16
    FRINTA  V12.2D, V15.2D
    SQDMLAL  S14, H3, H17
    SSRA  V4.4S, V15.4S, #3
    FCVTPS  D21, D31
    SSHR D15, D17, #13
    SQSHLU  V10.4H, V23.4H, #0x6
    UMLSL2  V28.8H, V17.16B, V31.16B
    FACGT  D12, D11, D0
    SHL  V12.4H, V6.4H, #0x7
    MLA  V3.8B, V13.8B, V6.8B
    SMINV  S6, V3.4S
    FMINNMP  V18.4S, V20.4S, V10.4S
    RSHRN V7.4H, V18.4S, #1
    BIC  V25.2S, #0x37, LSL #16
    SQSHRUN S11, D17, #27
    FRINTA  V31.4S, V7.4S
    FMUL V11.4S, V7.4S, V18.S[0x0]
    USRA  V19.2S, V18.2S, #21
    SUB  V25.2S, V26.2S, V20.2S
    MOVI  V7.2D, #18374966855153483775
    UQRSHRN V0.4H, V22.4S, #8
    FCVTNU  V28.2S, V14.2S
    SHRN2 V30.8H, V13.4S, #12
    CMEQ  V22.8H, V8.8H, V6.8H
    SQXTUN  H1, S11
    SQSHRUN V20.4H, V1.4S, #7
    SUQADD  H4, H31
    SQSHL  H12, H11, H18
    FACGT  S22, S20, S15
    UADDL  V22.4S, V22.4H, V25.4H
    SMOV  X9, V13.B[0xb]
    UQXTN  S29, D1
    SMLSL2 V3.2D, V22.4S, V3.S[0x1]
    SQDMULH  V7.2S, V22.2S, V11.S[0x2]
    SQABS  S15, S17
    SSHLL V25.4S, V8.4H, #0x1
    FABD  S0, S18, S28
    DUP V16.4S, W20
    FRECPS  V19.2S, V26.2S, V0.2S
    SQSHRN2 V15.8H, V16.4S, #16
    FMULX  D21, D25, D0
    INS V30.D[0x1], V19.D[0x0]
    UQSHL  V30.8H, V9.8H, #0x8
    RSHRN V19.8B, V25.8H, #1
    SQSHRUN V22.2S, V20.2D, #1
    FCVTPS  D22, D7
    SMOV  X3, V13.S[0x0]
    SQDMULH  H11, H1, H7
    FCVTZU  V23.2D, V3.2D
    SQSHRN S13, D12, #17
    FCMLE  V29.2S, V3.2S, #0.0
    SQRSHRUN H6, S19, #4
    SQDMLAL2 V8.2D, V8.4S, V7.S[0x2]
    FCMEQ  D3, D28, D21
    FCVTMS  S28, S15
    SQSHL  S22, S15, S0
    FCMGE  V11.2S, V20.2S, #0.0
    SQDMULL  V9.2D, V3.2S, V7.2S
    CLZ  V29.16B, V6.16B
    FMLS S31, S7, V15.S[0x3]
    SSHR  V4.2S, V12.2S, #15
    FRSQRTE  V21.2S, V12.2S
    SQDMLSL2  V30.4S, V31.8H, V14.8H
    CMLE  V29.4H, V25.4H, #0
    SQADD  D26, D28, D17
    NOT  V12.8B, V26.8B
    SQSHLU  V3.2S, V2.2S, #0x4
    SQRSHL  H19, H12, H16
    SQSUB  D29, D12, D21
    FCMLT  D6, D31, #0.0
    FACGT  V23.4S, V18.4S, V9.4S
    URSHR D23, D11, #43
    UQSHRN H4, S17, #10
    FCVTPS  V4.4S, V23.4S
    USHR  V29.2S, V15.2S, #30
    ADDV  B29, V7.8B
    SMLAL V11.4S, V8.4H, V7.H[0x1]
    FACGT  S27, S27, S21
    FRINTZ  V15.2S, V11.2S
    SQRDMULH  H24, H16, H9
    SHL  V19.4H, V19.4H, #0x8
    ADDV  S29, V29.4S
    SQXTUN  V30.4H, V4.4S
    FRSQRTE  V30.2S, V20.2S
    FCVTNS  V23.4S, V16.4S
    INS V13.D[0x1], V17.D[0x1]
    UQRSHRN S19, D6, #21
    FRINTN  V3.2D, V14.2D
    USHLL2 V11.4S, V6.8H, #0x4
    SRI D19, D12, #1
    SSHR  V30.4H, V23.4H, #3
    SABD  V21.4S, V24.4S, V10.4S
    FCMLE  S21, S15, #0.0
    CLZ  V13.16B, V15.16B
    FCMLT  S29, S31, #0.0
    SQDMLAL2  V24.2D, V14.4S, V21.4S
    ABS  D21, D11
    SCVTF  V25.4S, V8.4S
    MOV B31, V30.B[0xb]
    FNEG  V14.4S, V25.4S
    MOV V12.D[0x0], X6
    RADDHN  V8.2S, V19.2D, V4.2D
    SRI  V19.8B, V27.8B, #4
    CMHI  D4, D18, D9
    FMINV  S14, V31.4S
    FCMLE  D7, D14, #0.0
    UHSUB  V12.8B, V10.8B, V30.8B
    FMAXNMP D9, V30.2D
    SUBS  X27, X27, #0x1
    B.NE  TaishanSimdReduceP01_label_408
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X27, X15, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X3, X16, X4
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X2, X5, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X3, X6, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X15, X28, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X13, X14, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X9
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X6, X4, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X14, X19, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X25, X7, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X7, X9, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X8, X7, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X13, X4, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X23, X17, X23
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X23, X29, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X28, X19, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X4, X21, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X27, V2.D[1]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X9, X7, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X27, D2
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X9, X7, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X22, V3.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X22, D3
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X5, D4
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X22, V5.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X22, D5
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X16, D6
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X15, V7.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X12, X10, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    FMOV  X15, D7
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X12, X10, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X15, D8
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #16
    SUB  X22, X12, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    FMOV  X16, D9
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X16, D10
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X8, D11
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X10, D12
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X21, #0x808, LSL #0
    MOVK  X21, #0x808, LSL #16
    MOVK  X21, #0x808, LSL #32
    MOVK  X21, #0x808, LSL #48
    SUB  X29, X21, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X12, D13
    MOVZ  X21, #0x808, LSL #0
    MOVK  X21, #0x100, LSL #16
    MOVK  X21, #0x808, LSL #32
    MOVK  X21, #0x100, LSL #48
    SUB  X29, X21, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X11, D14
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X28, D15
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x7fc0, LSL #16
    MOVK  X3, #0x7fc0, LSL #48
    SUB  X4, X3, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X13, X4, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X17, D16
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X13, X4, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X26, D17
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X27, D18
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X12, D19
    MOVZ  X7, #0xf0f0, LSL #0
    MOVK  X7, #0xf0f0, LSL #16
    MOVK  X7, #0xf0f0, LSL #32
    MOVK  X7, #0x70f0, LSL #48
    SUB  X27, X7, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X14, D20
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X19, V21.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X19, D21
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X5, X20, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X9, D22
    MOVZ  X20, #0x0, LSL #0
    SUB  X5, X20, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X29, D23
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X12, D25
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0xcf00, LSL #16
    SUB  X17, X2, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    FMOV  X20, D26
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    FMOV  X18, V27.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X18, D27
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X10, X3, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X18, D28
    MOVZ  X3, #0x0, LSL #0
    SUB  X10, X3, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X19, V29.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X19, D29
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    MOVZ  X2, #0x836a, LSL #0
    MOVK  X2, #0xa05d, LSL #16
    MOVK  X2, #0x1cd8, LSL #32
    MOVK  X2, #0xdbd0, LSL #48
    MOVZ  X3, #0x2208, LSL #0
    MOVK  X3, #0xf52, LSL #16
    MOVK  X3, #0xfc7b, LSL #32
    MOVK  X3, #0xe7cf, LSL #48
    MOVZ  X4, #0x4bb0, LSL #0
    MOVK  X4, #0x302a, LSL #16
    MOVK  X4, #0x3bd3, LSL #32
    MOVK  X4, #0x22fd, LSL #48
    MOVZ  X5, #0x9136, LSL #0
    MOVK  X5, #0xb698, LSL #16
    MOVK  X5, #0x8988, LSL #32
    MOVK  X5, #0x46cf, LSL #48
    MOVZ  X6, #0xba2d, LSL #0
    MOVK  X6, #0xd6a5, LSL #16
    MOVK  X6, #0x13fb, LSL #32
    MOVK  X6, #0x8a39, LSL #48
    MOVZ  X7, #0x8a2c, LSL #0
    MOVK  X7, #0xd8e2, LSL #16
    MOVK  X7, #0xa7aa, LSL #32
    MOVK  X7, #0x7f46, LSL #48
    MOVZ  X8, #0x34b1, LSL #0
    MOVK  X8, #0x6c6a, LSL #16
    MOVK  X8, #0x9682, LSL #32
    MOVK  X8, #0xa760, LSL #48
    MOVZ  X9, #0xcc18, LSL #0
    MOVK  X9, #0xc3fa, LSL #16
    MOVK  X9, #0x4429, LSL #32
    MOVK  X9, #0x82db, LSL #48
    MOVZ  X10, #0x82ae, LSL #0
    MOVK  X10, #0x9474, LSL #16
    MOVK  X10, #0x90a, LSL #32
    MOVK  X10, #0x7455, LSL #48
    MOVZ  X11, #0x3355, LSL #0
    MOVK  X11, #0xdd03, LSL #16
    MOVK  X11, #0xf766, LSL #32
    MOVK  X11, #0xda01, LSL #48
    MOVZ  X12, #0xb90a, LSL #0
    MOVK  X12, #0xb17b, LSL #16
    MOVK  X12, #0x619d, LSL #32
    MOVK  X12, #0x101f, LSL #48
    MOVZ  X13, #0x73d9, LSL #0
    MOVK  X13, #0x16b0, LSL #16
    MOVK  X13, #0xc9d1, LSL #32
    MOVK  X13, #0x58ad, LSL #48
    MOVZ  X14, #0xac38, LSL #0
    MOVK  X14, #0xf5b0, LSL #16
    MOVK  X14, #0xcf73, LSL #32
    MOVK  X14, #0xda38, LSL #48
    MOVZ  X15, #0x26d0, LSL #0
    MOVK  X15, #0x66e8, LSL #16
    MOVK  X15, #0xc955, LSL #32
    MOVK  X15, #0xb6ef, LSL #48
    MOVZ  X16, #0xd211, LSL #0
    MOVK  X16, #0x4f1a, LSL #16
    MOVK  X16, #0x96e8, LSL #32
    MOVK  X16, #0x7346, LSL #48
    MOVZ  X17, #0xdc3a, LSL #0
    MOVK  X17, #0x2db4, LSL #16
    MOVK  X17, #0xfd2f, LSL #32
    MOVK  X17, #0x9a16, LSL #48
    MOVZ  X18, #0xd4b4, LSL #0
    MOVK  X18, #0xf8dc, LSL #16
    MOVK  X18, #0xed9, LSL #32
    MOVK  X18, #0x9153, LSL #48
    MOVZ  X19, #0x83c4, LSL #0
    MOVK  X19, #0xd7f9, LSL #16
    MOVK  X19, #0xb942, LSL #32
    MOVK  X19, #0xf4a0, LSL #48
    MOVZ  X20, #0x11ab, LSL #0
    MOVK  X20, #0x3352, LSL #16
    MOVK  X20, #0x6528, LSL #32
    MOVK  X20, #0xb435, LSL #48
TaishanSimdReduceP01_label_141:
    MOVZ  X21, #0x3287, LSL #0
    MOVK  X21, #0xdb92, LSL #16
    MOVK  X21, #0xa3ef, LSL #32
    MOVK  X21, #0xc9e6, LSL #48
    MOVZ  X22, #0xc99f, LSL #0
    MOVK  X22, #0x7f40, LSL #16
    MOVK  X22, #0x1d86, LSL #32
    MOVK  X22, #0x15fe, LSL #48
    MOVZ  X23, #0x83ee, LSL #0
    MOVK  X23, #0x5b6a, LSL #16
    MOVK  X23, #0x6622, LSL #32
    MOVK  X23, #0x9a74, LSL #48
    MOVZ  X25, #0x12d2, LSL #0
    MOVK  X25, #0x5c34, LSL #16
    MOVK  X25, #0x601a, LSL #32
    MOVK  X25, #0x639a, LSL #48
    MOVZ  X26, #0x8165, LSL #0
    MOVK  X26, #0x8c56, LSL #16
    MOVK  X26, #0x487a, LSL #32
    MOVK  X26, #0xe05f, LSL #48
    MOVZ  X27, #0xfca9, LSL #0
    MOVK  X27, #0x8547, LSL #16
    MOVK  X27, #0x9d13, LSL #32
    MOVK  X27, #0x2eeb, LSL #48
    MOVZ  X28, #0x3256, LSL #0
    MOVK  X28, #0x56d8, LSL #16
    MOVK  X28, #0x1dc1, LSL #32
    MOVK  X28, #0xb173, LSL #48
    MOVZ  X29, #0x65ab, LSL #0
    MOVK  X29, #0xeeba, LSL #16
    MOVK  X29, #0x45bc, LSL #32
    MOVK  X29, #0x1430, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X25
    FMOV  D1, X5
    FMOV  V1.D[1], X3
    FMOV  D2, X2
    FMOV  V2.D[1], X9
    FMOV  D3, X5
    FMOV  V3.D[1], X27
    FMOV  D4, X19
    FMOV  V4.D[1], X14
    FMOV  D5, X9
    FMOV  V5.D[1], X28
    FMOV  D6, X10
    FMOV  V6.D[1], X29
    FMOV  D7, X16
    FMOV  V7.D[1], X17
    FMOV  D8, X7
    FMOV  V8.D[1], X4
    FMOV  D9, X8
    FMOV  V9.D[1], X17
    FMOV  D10, X25
    FMOV  V10.D[1], X7
    FMOV  D11, X6
    FMOV  V11.D[1], X28
    FMOV  D12, X12
    FMOV  V12.D[1], X23
    FMOV  D13, X14
    FMOV  V13.D[1], X26
    FMOV  D14, X28
    FMOV  V14.D[1], X25
    FMOV  D15, X8
    FMOV  V15.D[1], X26
    FMOV  D16, X27
    FMOV  V16.D[1], X5
    FMOV  D17, X13
    FMOV  V17.D[1], X26
    FMOV  D18, X23
    FMOV  V18.D[1], X7
    FMOV  D19, X25
    FMOV  V19.D[1], X22
    FMOV  D20, X3
    FMOV  V20.D[1], X4
    FMOV  D21, X12
    FMOV  V21.D[1], X17
    FMOV  D22, X7
    FMOV  V22.D[1], X15
    FMOV  D23, X8
    FMOV  V23.D[1], X3
    FMOV  D24, X2
    FMOV  V24.D[1], X7
    FMOV  D25, X3
    FMOV  V25.D[1], X5
    FMOV  D26, X27
    FMOV  V26.D[1], X27
    FMOV  D27, X20
    FMOV  V27.D[1], X3
    FMOV  D28, X6
    FMOV  V28.D[1], X9
    FMOV  D29, X2
    FMOV  V29.D[1], X10
    FMOV  D30, X25
    FMOV  V30.D[1], X12
    FMOV  D31, X21
    FMOV  V31.D[1], X16
    MOVZ  X10, #0xa, LSL #0
TaishanSimdReduceP01_label_491:
    UMOV W19, V2.S[0x0]
    SQDMULL  S7, H27, H16
    SABAL2  V10.8H, V2.16B, V19.16B
    UQSHRN S27, D5, #31
    FCVTMS  V22.2D, V7.2D
    URSRA D29, D23, #17
    FMAXP S0, V12.2S
    SQDMULH H0, H27, V1.H[0x4]
    SXTL V8.4S, V23.4H
    DUP V1.2D, V16.D[0x0]
    FCMEQ  S25, S16, #0.0
    SADALP  V6.8H, V31.16B
    SQRSHRN B29, H23, #7
    SQXTN  B28, H16
    MLA  V11.4S, V25.4S, V30.S[0x3]
    SHRN2 V1.16B, V17.8H, #4
    SQADD  H16, H18, H18
    SSHLL V2.4S, V10.4H, #0xc
    UQSHRN V0.2S, V0.2D, #18
    SMLSL V21.2D, V26.2S, V0.S[0x2]
    TBL  V19.8B, { V23.16B, V24.16B, V25.16B, V26.16B }, V1.8B
    SMAXV  B10, V0.16B
    USHLL V15.4S, V2.4H, #0x5
    FCMGE  V8.2S, V16.2S, #0.0
    URSHR  V27.4S, V19.4S, #32
    SQDMULH H18, H24, V2.H[0x0]
    FCVTZS  D23, D31
    SQABS  S0, S26
    UMLSL2 V13.4S, V25.8H, V5.H[0x5]
    FCVTMU  V17.2D, V2.2D
    SQABS  V7.8B, V10.8B
    FMLA V11.2D, V30.2D, V19.D[0x1]
    SMULL2 V18.2D, V7.4S, V30.S[0x0]
    SXTL V3.2D, V20.2S
    SQDMLAL2  V7.4S, V3.8H, V11.8H
    FCMGE  S15, S31, S12
    USHR  V12.2S, V7.2S, #3
    SMOV  X12, V23.B[0x8]
    SQDMLSL2  V12.2D, V5.4S, V7.4S
    UMULL V6.2D, V11.2S, V19.S[0x1]
    SMIN  V9.4H, V25.4H, V0.4H
    MLA  V18.4S, V15.4S, V28.4S
    SSHLL2 V9.8H, V19.16B, #0x7
    CMLE  V13.8H, V20.8H, #0
    FACGE  D10, D16, D25
    FRECPE  S4, S15
    SMLAL V5.2D, V15.2S, V5.S[0x0]
    SRSRA  V17.2S, V12.2S, #16
    SMLSL V9.4S, V16.4H, V0.H[0x5]
    FCVTPS  S5, S21
    SSUBL2  V27.2D, V8.4S, V3.4S
    SUBHN2  V7.4S, V11.2D, V30.2D
    SSRA  V3.4S, V18.4S, #23
    FRECPS  S1, S12, S14
    SQSHRN B7, H12, #7
    USUBW2  V21.8H, V8.8H, V4.16B
    SMAXV  B21, V23.16B
    INS V28.H[0x6], W3
    FMAX  V23.2D, V4.2D, V22.2D
    SMINP  V8.4H, V6.4H, V26.4H
    SQRSHRN2 V25.4S, V6.2D, #18
    SMULL2 V22.4S, V17.8H, V5.H[0x3]
    FRECPS  V18.2D, V14.2D, V1.2D
    RSHRN V5.8B, V2.8H, #4
    UQSHL  H30, H12, H0
    SQADD  B6, B30, B4
    SABDL2  V14.8H, V27.16B, V14.16B
    UXTL V25.2D, V5.2S
    UMULL2 V10.4S, V31.8H, V13.H[0x2]
    FCVTZS  V17.4S, V27.4S
    SQRSHRN2 V28.8H, V18.4S, #11
    CMLT  D22, D22, #0
    DUP V4.2D, V8.D[0x0]
    SADDLV  S2, V27.8H
    UQSHL  B21, B6, B11
    UQRSHRN V27.2S, V29.2D, #2
    FDIV  V2.2D, V6.2D, V1.2D
    SQSHRUN V1.4H, V25.4S, #7
    UQSHL  H13, H14, H26
    SQSHRUN V28.4H, V12.4S, #5
    URSRA  V3.4H, V6.4H, #6
    SSHLL V16.2D, V31.2S, #0x11
    FCVTZU D8, D1, #2
    SMINV  B28, V9.16B
    SQDMULL S20, H16, V4.H[0x3]
    SSHR  V22.2S, V18.2S, #30
    FCVTAU  D30, D27
    USRA D0, D31, #39
    MOV V27.H[0x5], W7
    SQDMLAL  V29.4S, V11.4H, V1.4H
    USUBW  V27.8H, V14.8H, V26.8B
    UCVTF  V28.4S, V14.4S, #27
    SRSHR  V4.4S, V2.4S, #5
    UADALP  V29.1D, V6.2S
    URSHR V6.2D, V5.2D, #30
    FCVTZU  S2, S12
    SXTL2 V8.8H, V17.16B
    URSHL  D26, D18, D1
    RSHRN V27.4H, V21.4S, #9
    FMINNMP S25, V6.2S
    FCVTZU  S19, S29
    SQRSHRN2 V0.8H, V2.4S, #14
    CMGT  V14.4H, V22.4H, #0
    SMAX  V9.4S, V29.4S, V20.4S
    UQADD  S6, S27, S17
    SQRSHRN V3.4H, V2.4S, #1
    SQSHLU B19, B3, #0x5
    FCMEQ  V12.2S, V13.2S, #0.0
    SQRSHRUN2 V0.8H, V20.4S, #5
    SXTL V28.2D, V9.2S
    FMINV  S24, V24.4S
    FABD  V5.4S, V29.4S, V28.4S
    CMGE  V7.16B, V31.16B, V17.16B
    NOT  V22.16B, V5.16B
    FRINTN  V24.2D, V27.2D
    FCMEQ  V18.2S, V14.2S, V25.2S
    SSUBL  V27.4S, V0.4H, V11.4H
    SRSHR V21.2D, V6.2D, #28
    FRECPE  V16.2S, V2.2S
    RSUBHN2  V7.8H, V27.4S, V16.4S
    INS V1.B[0xd], V22.B[0xc]
    UQSHL  V10.16B, V17.16B, V16.16B
    SQRSHRN B10, H20, #5
    MOVI  V31.8H, #0xa0
    UQSHL D24, D16, #0x11
    FCMEQ  V16.2D, V5.2D, V6.2D
    SSHLL V17.8H, V2.8B, #0x6
    SCVTF  D9, D21
    REV16  V4.16B, V28.16B
    MOV H22, V11.H[0x1]
    SCVTF  D24, D0
    SMOV W11, V20.H[0x5]
    SABD  V15.8H, V29.8H, V14.8H
    USQADD  B3, B17
    SQRSHRUN V14.8B, V5.8H, #4
    FCVTZS V3.2D, V16.2D, #2
    SQDMULL2  V1.2D, V24.4S, V1.4S
    SQRSHL  H10, H4, H23
    SQSHRN B21, H14, #7
    FACGE  D30, D4, D15
    USRA D0, D11, #6
    SRSRA D22, D9, #1
    SQRDMULH H12, H13, V10.H[0x1]
    MOV V20.D[0x1], V11.D[0x1]
    SSHL  V29.4H, V14.4H, V5.4H
    UZP2  V19.8B, V4.8B, V18.8B
    CMEQ  V2.8H, V10.8H, V9.8H
    TRN2  V17.2D, V25.2D, V3.2D
    MLA  V7.8B, V20.8B, V0.8B
    SQSUB  S24, S13, S16
    UCVTF S17, S22, #19
    FCVTPS  V30.2D, V28.2D
    SQSUB  D23, D16, D12
    SADALP  V31.8H, V29.16B
    UMLAL2  V24.2D, V15.4S, V21.4S
    SQSHL  S13, S25, S23
    DUP V29.16B, W6
    SRSRA D12, D31, #24
    SMULL  V18.4S, V30.4H, V12.4H
    FMUL D31, D17, V29.D[0x1]
    SQNEG  S24, S10
    ZIP1  V4.16B, V2.16B, V0.16B
    SMLSL V8.2D, V18.2S, V23.S[0x2]
    SQSHRUN S28, D29, #21
    SADDLV  S7, V26.8H
    SQADD  H13, H17, H10
    UMAXV  B31, V6.8B
    UMOV X18, V1.D[0x0]
    SQSHL D16, D23, #0x39
    AND  V9.8B, V26.8B, V30.8B
    SQRSHL  D14, D27, D19
    INS V1.B[0x4], W11
    UMLSL2 V6.2D, V27.4S, V26.S[0x0]
    UQRSHRN H26, S22, #13
    USHLL V20.8H, V12.8B, #0x4
    ZIP1  V9.4S, V6.4S, V5.4S
    UQSHRN2 V4.4S, V5.2D, #8
    BSL  V8.16B, V2.16B, V22.16B
    CNT  V19.8B, V10.8B
    UXTL V9.4S, V23.4H
    SQSHRUN V25.2S, V20.2D, #26
    UMULL2 V28.2D, V26.4S, V27.S[0x2]
    SQSHL  V5.8H, V16.8H, #0x3
    BIC  V31.8B, V12.8B, V1.8B
    SHRN2 V13.16B, V3.8H, #8
    ADDV  B3, V14.16B
    SQRDMULH S16, S10, V27.S[0x3]
    SSHLL2 V26.2D, V6.4S, #0x4
    SQDMLSL V29.4S, V26.4H, V4.H[0x0]
    SQSHRN S17, D13, #30
    UADDW  V27.8H, V25.8H, V5.8B
    SRI  V3.16B, V6.16B, #3
    SQRSHRUN2 V0.16B, V7.8H, #1
    CMLT  V3.2S, V27.2S, #0
    MOV V26.B[0x2], V21.B[0x8]
    UQSHRN2 V20.8H, V10.4S, #8
    SMLSL  V27.8H, V12.8B, V4.8B
    SCVTF  S28, S8
    SQADD  S1, S5, S19
    UMLAL V9.2D, V1.2S, V0.S[0x1]
    SUBS  X10, X10, #0x1
    B.NE  TaishanSimdReduceP01_label_491
    MOVZ  X10, #0x836a, LSL #0
    MOVK  X10, #0xa05d, LSL #16
    MOVK  X10, #0x1cd8, LSL #32
    MOVK  X10, #0xdbd0, LSL #48
    SUB  X11, X10, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    MOVZ  X3, #0x2208, LSL #0
    MOVK  X3, #0xf52, LSL #16
    MOVK  X3, #0xfc7b, LSL #32
    MOVK  X3, #0xe7cf, LSL #48
    SUB  X19, X3, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    MOVZ  X13, #0x4bb0, LSL #0
    MOVK  X13, #0x302a, LSL #16
    MOVK  X13, #0x3bd3, LSL #32
    MOVK  X13, #0x22fd, LSL #48
    SUB  X8, X13, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X16, #0x9136, LSL #0
    MOVK  X16, #0xb698, LSL #16
    MOVK  X16, #0x8988, LSL #32
    MOVK  X16, #0x46cf, LSL #48
    SUB  X4, X16, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    MOVZ  X6, #0xba2d, LSL #0
    MOVK  X6, #0xd6a5, LSL #16
    MOVK  X6, #0x13fb, LSL #32
    MOVK  X6, #0x8a39, LSL #48
    SUB  X20, X6, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    MOVZ  X16, #0x8a2c, LSL #0
    MOVK  X16, #0xd8e2, LSL #16
    MOVK  X16, #0xa7aa, LSL #32
    MOVK  X16, #0x7f46, LSL #48
    SUB  X25, X16, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X21, X11, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    MOVZ  X12, #0xcc18, LSL #0
    MOVK  X12, #0xc3fa, LSL #16
    MOVK  X12, #0x4429, LSL #32
    MOVK  X12, #0x82db, LSL #48
    SUB  X8, X12, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X14, #0x836a, LSL #0
    MOVK  X14, #0xa05d, LSL #16
    MOVK  X14, #0x1cd8, LSL #32
    MOVK  X14, #0xdbd0, LSL #48
    SUB  X10, X14, X10
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X11
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    MOVZ  X3, #0xcc18, LSL #0
    MOVK  X3, #0xc3fa, LSL #16
    MOVK  X3, #0x4429, LSL #32
    MOVK  X3, #0x82db, LSL #48
    SUB  X14, X3, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    MOVZ  X13, #0x4bb0, LSL #0
    MOVK  X13, #0x302a, LSL #16
    MOVK  X13, #0x3bd3, LSL #32
    MOVK  X13, #0x22fd, LSL #48
    SUB  X23, X13, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X15
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    MOVZ  X19, #0x8a2c, LSL #0
    MOVK  X19, #0xd8e2, LSL #16
    MOVK  X19, #0xa7aa, LSL #32
    MOVK  X19, #0x7f46, LSL #48
    SUB  X22, X19, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    MOVZ  X11, #0xdc3a, LSL #0
    MOVK  X11, #0x2db4, LSL #16
    MOVK  X11, #0xfd2f, LSL #32
    MOVK  X11, #0x9a16, LSL #48
    SUB  X5, X11, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    MOVZ  X11, #0x8a2c, LSL #0
    MOVK  X11, #0xd8e2, LSL #16
    MOVK  X11, #0xa7aa, LSL #32
    MOVK  X11, #0x7f46, LSL #48
    SUB  X29, X11, X19
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X13, #0x8165, LSL #0
    MOVK  X13, #0x8c56, LSL #16
    MOVK  X13, #0x487a, LSL #32
    MOVK  X13, #0xe05f, LSL #48
    SUB  X8, X13, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X18, #0xfca9, LSL #0
    MOVK  X18, #0x8547, LSL #16
    MOVK  X18, #0x9d13, LSL #32
    MOVK  X18, #0x2eeb, LSL #48
    SUB  X11, X18, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X10, V2.D[1]
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X27, X28, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X10, D2
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    SUB  X27, X28, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X8, X21, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X4, D3
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X8, X21, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X8, D4
    MOVZ  X28, #0xe8ff, LSL #0
    MOVK  X28, #0x96ff, LSL #16
    MOVK  X28, #0x5aff, LSL #32
    MOVK  X28, #0xefff, LSL #48
    SUB  X5, X28, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X19, V5.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X17, X20, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X19, D5
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0xf000, LSL #48
    SUB  X17, X20, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X8, D6
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #16
    SUB  X20, X14, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X8, X9, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X2, D7
    MOVZ  X9, #0x4000, LSL #0
    SUB  X8, X9, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X28, D8
    MOVZ  X23, #0xd6a5, LSL #0
    MOVK  X23, #0x2010, LSL #48
    SUB  X10, X23, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #32
    SUB  X15, X21, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X12, D9
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #32
    SUB  X15, X21, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X16, D10
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X17, #0x3256, LSL #0
    MOVK  X17, #0x56d8, LSL #16
    MOVK  X17, #0x1dc1, LSL #32
    MOVK  X17, #0xb173, LSL #48
    SUB  X5, X17, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X7, D11
    MOVZ  X17, #0xba2d, LSL #0
    MOVK  X17, #0xd6a5, LSL #16
    MOVK  X17, #0x13fb, LSL #32
    MOVK  X17, #0x8a39, LSL #48
    SUB  X5, X17, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X10, D12
    MOVZ  X11, #0xa001, LSL #0
    MOVK  X11, #0xa000, LSL #16
    SUB  X8, X11, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X7
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X7, D13
    MOVZ  X26, #0xa500, LSL #0
    SUB  X27, X26, X7
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X16
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    FMOV  X16, D14
    MOVZ  X6, #0x45d3, LSL #0
    MOVK  X6, #0x295b, LSL #32
    SUB  X12, X6, X16
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    FMOV  X6, V15.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X12, X23, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    FMOV  X6, D15
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x1, LSL #32
    SUB  X12, X23, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X14, X22, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X9, D16
    MOVZ  X22, #0x0, LSL #0
    SUB  X14, X22, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X8, D17
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X16, D18
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X9, D19
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X5, X19, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X11, D20
    MOVZ  X19, #0x10, LSL #0
    MOVK  X19, #0xa00, LSL #16
    MOVK  X19, #0xa00, LSL #48
    SUB  X5, X19, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X3, X20, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X10, D21
    MOVZ  X20, #0x0, LSL #0
    SUB  X3, X20, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X9, D22
    MOVZ  X14, #0xd6a5, LSL #0
    MOVK  X14, #0x2010, LSL #48
    SUB  X28, X14, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X10, V23.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X10, D23
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X18, X15, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X9, D25
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X20, X26, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X3, D26
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xf0, LSL #48
    SUB  X17, X14, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X9, D27
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xf6ff, LSL #16
    MOVK  X14, #0xd840, LSL #48
    SUB  X17, X14, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X12, D28
    MOVZ  X29, #0xa500, LSL #0
    MOVK  X29, #0x4756, LSL #16
    SUB  X5, X29, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X25, V29.D[1]
    MOVZ  X5, #0x2d2d, LSL #0
    MOVK  X5, #0x2d2d, LSL #16
    MOVK  X5, #0x2d2d, LSL #32
    MOVK  X5, #0x2d2d, LSL #48
    SUB  X15, X5, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X25, D29
    MOVZ  X5, #0x2d2d, LSL #0
    MOVK  X5, #0x2d2d, LSL #16
    MOVK  X5, #0x2d2d, LSL #32
    MOVK  X5, #0x2d2d, LSL #48
    SUB  X15, X5, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X20
    FMOV  V0.D[1], X13
    FMOV  D1, X8
    FMOV  V1.D[1], X23
    FMOV  D2, X10
    FMOV  V2.D[1], X11
    FMOV  D3, X13
    FMOV  V3.D[1], X28
    FMOV  D4, X27
    FMOV  V4.D[1], X19
    FMOV  D5, X13
    FMOV  V5.D[1], X15
    FMOV  D6, X23
    FMOV  V6.D[1], X3
    FMOV  D7, X29
    FMOV  V7.D[1], X10
    FMOV  D8, X16
    FMOV  V8.D[1], X27
    FMOV  D9, X20
    FMOV  V9.D[1], X14
    FMOV  D10, X18
    FMOV  V10.D[1], X21
    FMOV  D11, X27
    FMOV  V11.D[1], X17
    FMOV  D12, X16
    FMOV  V12.D[1], X4
    FMOV  D13, X9
    FMOV  V13.D[1], X23
    FMOV  D14, X20
    FMOV  V14.D[1], X7
    FMOV  D15, X2
    FMOV  V15.D[1], X7
    FMOV  D16, X14
    FMOV  V16.D[1], X13
    FMOV  D17, X9
    FMOV  V17.D[1], X12
    FMOV  D18, X10
    FMOV  V18.D[1], X6
    FMOV  D19, X7
    FMOV  V19.D[1], X4
    FMOV  D20, X13
    FMOV  V20.D[1], X7
    FMOV  D21, X23
    FMOV  V21.D[1], X10
    FMOV  D22, X18
    FMOV  V22.D[1], X5
    FMOV  D23, X4
    FMOV  V23.D[1], X23
    FMOV  D24, X2
    FMOV  V24.D[1], X20
    FMOV  D25, X7
    FMOV  V25.D[1], X12
    FMOV  D26, X29
    FMOV  V26.D[1], X16
    FMOV  D27, X27
    FMOV  V27.D[1], X5
    FMOV  D28, X27
    FMOV  V28.D[1], X6
    FMOV  D29, X10
    FMOV  V29.D[1], X28
    FMOV  D30, X5
    FMOV  V30.D[1], X20
    FMOV  D31, X4
    FMOV  V31.D[1], X25
    MOVZ  X11, #0xa, LSL #0
TaishanSimdReduceP01_label_572:
    FCVTPS  D11, D7
    CMEQ  V1.4H, V10.4H, V6.4H
    CMGE  V2.8H, V10.8H, V28.8H
    SQDMULL V19.4S, V15.4H, V1.H[0x7]
    SQABS  V6.16B, V24.16B
    UCVTF D19, D18, #39
    REV16  V19.16B, V1.16B
    UADDLV  H27, V30.16B
    CMEQ  V21.4S, V6.4S, V29.4S
    SMOV W6, V21.H[0x0]
    MOVI  V7.8B, #0x97
    SQADD  B7, B29, B21
    URSHR V24.2D, V11.2D, #43
    SLI  V4.4S, V24.4S, #0x1d
    SQDMULL2 V4.2D, V9.4S, V29.S[0x1]
    UMAXV  H21, V10.4H
    SABAL  V17.4S, V0.4H, V4.4H
    XTN  V12.2S, V27.2D
    UQRSHRN S19, D31, #18
    ADDHN2  V11.4S, V12.2D, V7.2D
    SQSUB  V7.2D, V16.2D, V11.2D
    UQSHL H2, H20, #0xd
    UQSUB  H11, H21, H21
    USQADD  B23, B5
    UXTL2 V29.2D, V28.4S
    FCVTZS  V2.2D, V15.2D
    SQABS  B1, B11
    UQSHL V26.2D, V21.2D, #0x17
    UMULL  V1.4S, V12.4H, V27.4H
    SQADD  B30, B24, B27
    TRN1  V10.4S, V27.4S, V11.4S
    UMAX  V8.8H, V9.8H, V9.8H
    ADDHN2  V26.16B, V8.8H, V3.8H
    RADDHN  V11.2S, V3.2D, V15.2D
    SSHL  V2.8B, V21.8B, V25.8B
    FMAXP S4, V8.2S
    SQDMLSL  V5.4S, V10.4H, V1.4H
    MOV V12.B[0xe], V9.B[0x3]
    SQDMULL  V1.2D, V2.2S, V17.2S
    SMLSL2 V3.4S, V8.8H, V3.H[0x5]
    MOV V13.D[0x1], V1.D[0x0]
    SQABS  S30, S9
    SQDMULL2 V10.4S, V21.8H, V11.H[0x1]
    SMAXV  B3, V10.8B
    FABD  D26, D28, D31
    FCVTAU  V14.2S, V25.2S
    FCVTNS  S15, S1
    SHADD  V15.4H, V4.4H, V14.4H
    SQRSHL  H21, H10, H13
    FCVTMU  S31, S31
    UABAL2  V1.4S, V10.8H, V28.8H
    SABA  V5.8H, V29.8H, V27.8H
    DUP S0, V26.S[0x1]
    ADDHN  V1.4H, V11.4S, V12.4S
    SSRA  V17.4S, V11.4S, #4
    SRSHL  D3, D13, D8
    UQSHL  S7, S25, S31
    SQDMLAL2  V27.4S, V18.8H, V22.8H
    RSHRN2 V18.16B, V23.8H, #4
    SUB  D26, D14, D22
    SRSHR D4, D12, #50
    SQRSHRUN H15, S14, #12
    FCVTMS  V14.2S, V17.2S
    SQSHRUN V7.4H, V10.4S, #8
    FCMEQ  V10.4S, V13.4S, V12.4S
    MVNI  V26.2S, #0x5d, LSL #24
    SQRSHRUN2 V16.16B, V15.8H, #4
    SQRSHRUN2 V18.16B, V16.8H, #8
    SMULL2 V1.4S, V14.8H, V0.H[0x5]
    SQSHRN2 V27.8H, V29.4S, #4
    SHLL  V20.2D, V26.2S, #32
    FMUL D26, D31, V21.D[0x1]
    RSUBHN2  V29.16B, V4.8H, V28.8H
    SXTL V3.4S, V28.4H
    SQSHRN V7.8B, V14.8H, #4
    UQRSHRN B3, H4, #8
    FCVTZU V20.2D, V5.2D, #25
    FCMGT  V17.2S, V17.2S, #0.0
    UCVTF S15, S2, #19
    SMINV  H30, V28.4H
    UQRSHL  B1, B5, B6
    CMGT  D1, D0, D7
    FCMEQ  D15, D23, #0.0
    SQRSHL  B21, B4, B7
    UQSHRN2 V17.16B, V28.8H, #5
    FMULX  S20, S14, S24
    SQRSHL  B16, B0, B23
    FMAX  V18.2S, V11.2S, V8.2S
    SABD  V15.4S, V14.4S, V6.4S
    UQRSHRN2 V26.4S, V8.2D, #31
    CMHI  D30, D12, D14
    DUP V2.8B, W9
    FCVTPU  D15, D1
    FCVTNS  V2.2D, V4.2D
    SADDW2  V16.4S, V8.4S, V4.8H
    UQSUB  H6, H26, H9
    SRSHR V21.2D, V27.2D, #61
    SSHL  D22, D29, D6
    SQNEG  V8.4S, V7.4S
    SRSHL  D19, D19, D18
    MOVI  D30, #16711935
    SQSHRUN2 V22.8H, V0.4S, #2
    SQRDMULH  V18.4S, V2.4S, V3.S[0x1]
    UQSHL V30.2D, V10.2D, #0x2f
    SQRSHRN V23.2S, V26.2D, #12
    USHLL2 V11.4S, V8.8H, #0xc
    UABDL2  V30.4S, V16.8H, V9.8H
    REV32  V22.8H, V30.8H
    SRSHR  V0.16B, V18.16B, #1
    UQADD  S20, S29, S21
    SQRSHL  B11, B23, B24
    SQRDMULH  V26.4H, V6.4H, V7.H[0x6]
    FSUB  V27.2D, V25.2D, V15.2D
    FCVTAU  D7, D17
    MOV  X7, V21.D[0x0]
    UABDL2  V9.8H, V16.16B, V10.16B
    SQSHRN2 V2.8H, V4.4S, #14
    SRI  V28.2S, V12.2S, #9
    MVNI  V4.2S, #0x75
    MOV V16.D[0x0], X17
    FCVTZU V22.2D, V16.2D, #48
    INS V26.D[0x1], V11.D[0x0]
    PMUL  V10.8B, V12.8B, V11.8B
    FRSQRTE  D21, D31
    SQSHLU  V7.2S, V7.2S, #0x12
    DUP B31, V17.B[0xe]
    SMULL2 V19.4S, V23.8H, V14.H[0x5]
    UMLAL  V20.2D, V20.2S, V31.2S
    SSHLL V10.2D, V17.2S, #0x14
    SQDMULL  V20.2D, V18.2S, V25.2S
    FMINV  S17, V7.4S
    INS V18.S[0x0], W9
    FMLA D21, D14, V22.D[0x0]
    XTN2  V19.16B, V6.8H
    CMHS  D25, D21, D9
    USRA D16, D9, #64
    SADALP  V8.2S, V4.4H
    UQADD  D8, D7, D9
    UQSHRN2 V17.4S, V7.2D, #29
    USHR V31.2D, V7.2D, #49
    CMGE  V27.4S, V21.4S, V3.4S
    SXTL2 V10.2D, V10.4S
    FCMGE  S20, S13, S12
    SQDMLAL2  V7.4S, V28.8H, V15.8H
    FCVTPU  V18.2D, V11.2D
    UABDL  V22.2D, V10.2S, V31.2S
    SXTL2 V17.4S, V31.8H
    SMAXV  H13, V12.4H
    FCVTZS  V30.4S, V19.4S
    SADDL2  V3.2D, V31.4S, V3.4S
    SHSUB  V18.16B, V13.16B, V26.16B
    SQDMLAL2 V25.2D, V30.4S, V11.S[0x3]
    SMLAL2 V8.2D, V7.4S, V11.S[0x3]
    SQSHLU  V20.8H, V8.8H, #0xc
    FMULX D13, D11, V31.D[0x1]
    SHRN V23.8B, V23.8H, #1
    FCVTMS  V4.2S, V22.2S
    SMOV  X10, V29.S[0x2]
    FCVTMS  D31, D11
    SCVTF  S17, S10
    UQSHRN B12, H24, #5
    SHL  V17.2S, V11.2S, #0x2
    SMOV  X27, V23.B[0x1]
    SQADD  V27.8B, V19.8B, V28.8B
    SSHR  V28.8H, V20.8H, #7
    SQDMULH  H26, H5, H20
    UQSHRN2 V14.16B, V7.8H, #8
    FMULX D29, D7, V4.D[0x0]
    ORR  V5.8B, V16.8B, V3.8B
    MOV S14, V31.S[0x1]
    SMLSL2 V9.2D, V30.4S, V18.S[0x2]
    SQXTUN  B9, H8
    FCVTNU  S26, S28
    FCMEQ  D26, D24, D28
    UQSHRN H19, S13, #5
    SMLAL2  V1.8H, V4.16B, V0.16B
    SQRDMULH H31, H12, V11.H[0x5]
    UQXTN  V31.2S, V5.2D
    UQXTN  B29, H7
    SLI  V2.2S, V29.2S, #0x8
    CMTST  D9, D11, D31
    SXTL V15.4S, V28.4H
    UQRSHRN S26, D15, #20
    FRINTX  V14.2D, V19.2D
    MOV V8.D[0x0], V21.D[0x0]
    SABD  V17.16B, V15.16B, V1.16B
    MOV B16, V4.B[0xd]
    ADDHN2  V26.16B, V14.8H, V11.8H
    SQSHL  V21.8H, V24.8H, #0x6
    ABS  V8.16B, V21.16B
    SQSHLU  V18.16B, V18.16B, #0x3
    SQDMLSL D7, S24, V17.S[0x1]
    SSHLL2 V27.8H, V2.16B, #0x1
    RSUBHN  V17.8B, V9.8H, V22.8H
    SQSHL B24, B27, #0x4
    UQRSHRN V10.8B, V29.8H, #2
    SQRSHRN B13, H3, #5
    SSHLL2 V31.2D, V7.4S, #0x7
    FMULX  S16, S25, S14
    UXTL V28.8H, V29.8B
    SUBS  X11, X11, #0x1
    B.NE  TaishanSimdReduceP01_label_572
    MOVZ  X15, #0x0, LSL #0
    SUB  X14, X15, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X5
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X14, X16, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X7
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X10
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X14
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X19, X26, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X20
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X11, X19, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X17, X6, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X19, X5, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X16, D2
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X21, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X10, X4, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X21, D3
    MOVZ  X4, #0x0, LSL #0
    SUB  X10, X4, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X13, V4.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X13, D4
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X18, D5
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X14, X27, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X12, D6
    MOVZ  X27, #0x0, LSL #0
    SUB  X14, X27, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    FMOV  X29, D7
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X2, D8
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X11, D9
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X11, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X23, D11
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X10, D12
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X29, D13
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X17, D14
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X20, X18, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X10, D15
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X20, X18, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    FMOV  X6, D16
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7fc0, LSL #16
    SUB  X12, X18, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X16, D17
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    FMOV  X17, D18
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X9, D19
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X5, D20
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X4, X28, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X7, D21
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X10
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X10, D22
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X10
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X21, V23.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X21, D23
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X15, D25
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X22, X2, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X4, V26.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X4, D26
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X6, X21, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X15, V27.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X15, D27
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X7
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X7, D28
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X7
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    FMOV  X27, D29
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
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
    FMOV  D1, X6
    FMOV  V1.D[1], X28
    FMOV  D2, X17
    FMOV  V2.D[1], X18
    FMOV  D3, X11
    FMOV  V3.D[1], X14
    FMOV  D4, X9
    FMOV  V4.D[1], X17
    FMOV  D5, X23
    FMOV  V5.D[1], X21
    FMOV  D6, X29
    FMOV  V6.D[1], X19
    FMOV  D7, X10
    FMOV  V7.D[1], X28
    FMOV  D8, X7
    FMOV  V8.D[1], X11
    FMOV  D9, X25
    FMOV  V9.D[1], X2
    FMOV  D10, X27
    FMOV  V10.D[1], X10
    FMOV  D11, X15
    FMOV  V11.D[1], X26
    FMOV  D12, X10
    FMOV  V12.D[1], X3
    FMOV  D13, X14
    FMOV  V13.D[1], X9
    FMOV  D14, X19
    FMOV  V14.D[1], X23
    FMOV  D15, X27
    FMOV  V15.D[1], X9
    FMOV  D16, X19
    FMOV  V16.D[1], X26
    FMOV  D17, X20
    FMOV  V17.D[1], X25
    FMOV  D18, X25
    FMOV  V18.D[1], X21
    FMOV  D19, X5
    FMOV  V19.D[1], X3
    FMOV  D20, X13
    FMOV  V20.D[1], X5
    FMOV  D21, X16
    FMOV  V21.D[1], X17
    FMOV  D22, X19
    FMOV  V22.D[1], X4
    FMOV  D23, X10
    FMOV  V23.D[1], X26
    FMOV  D24, X17
    FMOV  V24.D[1], X5
    FMOV  D25, X27
    FMOV  V25.D[1], X20
    FMOV  D26, X7
    FMOV  V26.D[1], X22
    FMOV  D27, X21
    FMOV  V27.D[1], X18
    FMOV  D28, X17
    FMOV  V28.D[1], X23
    FMOV  D29, X14
    FMOV  V29.D[1], X4
    FMOV  D30, X3
    FMOV  V30.D[1], X21
    FMOV  D31, X3
    FMOV  V31.D[1], X21
    MOVZ  X16, #0xf, LSL #0
TaishanSimdReduceP01_label_650:
    CMTST  V5.8B, V21.8B, V30.8B
    FRSQRTE  S16, S14
    SXTL2 V14.4S, V19.8H
    INS V17.H[0x7], V29.H[0x4]
    UMLAL2 V8.4S, V28.8H, V12.H[0x7]
    SQSUB  V28.8H, V31.8H, V9.8H
    SHL V0.2D, V11.2D, #0xc
    USHL  D15, D24, D23
    USHLL V27.2D, V4.2S, #0x17
    SMLSL V14.4S, V2.4H, V10.H[0x1]
    SMINV  S17, V0.4S
    FMLS  V16.4S, V26.4S, V21.4S
    FMUL V25.4S, V6.4S, V24.S[0x3]
    FCVTZU  D3, D27
    FMAXP  V22.2S, V1.2S, V4.2S
    FACGT  S10, S1, S30
    UCVTF  V3.2S, V4.2S, #24
    SQXTUN  B25, H20
    SQSHRUN2 V20.4S, V2.2D, #1
    SMAXV  S2, V6.4S
    FMIN  V12.2S, V27.2S, V23.2S
    MOV V26.S[0x3], W7
    FRINTX  V11.2S, V26.2S
    SADDLP  V9.1D, V29.2S
    SMLSL V31.2D, V6.2S, V27.S[0x1]
    SMIN  V31.8B, V3.8B, V10.8B
    SQSHRN2 V16.4S, V14.2D, #19
    FCVTMS  V1.2S, V23.2S
    FMIN  V15.2D, V19.2D, V23.2D
    SHRN V13.2S, V17.2D, #24
    FCMLT  D12, D27, #0.0
    SQRSHL  V25.16B, V26.16B, V7.16B
    FCMEQ  D5, D15, #0.0
    FCVTAU  D2, D4
    UQSHRN S26, D12, #9
    CMGT  D1, D12, D5
    URSHR  V20.2S, V24.2S, #18
    URSRA  V27.8H, V0.8H, #1
    SMOV  X12, V27.S[0x1]
    FCMLT  V29.2S, V1.2S, #0.0
    FCVTPS  V13.4S, V11.4S
    SABA  V13.16B, V26.16B, V16.16B
    SABA  V28.4H, V13.4H, V5.4H
    FSUB  V7.2S, V31.2S, V25.2S
    SUQADD  V20.4H, V15.4H
    SMAXV  H29, V14.4H
    SMLSL V5.2D, V21.2S, V19.S[0x0]
    SSHLL2 V25.2D, V14.4S, #0x9
    SRI  V12.16B, V27.16B, #4
    ADD  V24.2S, V12.2S, V22.2S
    SMOV  X25, V6.B[0xe]
    URSHL  D6, D0, D27
    SSRA D12, D22, #4
    SADDL2  V29.2D, V26.4S, V17.4S
    SQRSHRUN V2.2S, V8.2D, #17
    UMULL2 V6.4S, V21.8H, V14.H[0x0]
    MOV D2, V1.D[0x0]
    UQADD  S25, S9, S6
    FMULX V4.2D, V31.2D, V16.D[0x1]
    CMGT  V27.8H, V31.8H, #0
    FCVTXN2  V2.4S, V20.2D
    UQRSHL  D2, D19, D19
    FMUL S11, S13, V12.S[0x3]
    UADDLV  S21, V29.8H
    CLS  V20.2S, V26.2S
    SQRSHRUN V28.8B, V7.8H, #4
    SADDLV  S16, V10.4H
    SQSHRUN V24.4H, V20.4S, #15
    UQSHRN2 V1.8H, V28.4S, #8
    FCVTAU  S19, S13
    INS V10.B[0xd], V4.B[0xb]
    SSUBW  V8.8H, V15.8H, V29.8B
    URSQRTE  V27.2S, V12.2S
    FMLS  V4.2D, V7.2D, V24.2D
    FRECPS  S1, S19, S9
    FCMGT  V13.2S, V7.2S, V29.2S
    SLI D24, D24, #0x10
    SMAXV  H8, V2.4H
    SQSHRN2 V9.4S, V12.2D, #3
    DUP D17, V11.D[0x1]
    SQSUB  V7.4H, V25.4H, V9.4H
    SQSHL S26, S15, #0x11
    SQDMLSL  S12, H8, H15
    SQRDMULH  S25, S1, S11
    FCVTPS  V7.2S, V30.2S
    URSRA V30.2D, V24.2D, #45
    UABA  V3.8B, V29.8B, V11.8B
    FMINNMV  S26, V8.4S
    CLS  V16.16B, V26.16B
    INS V7.B[0x3], W14
    FMUL V29.2D, V0.2D, V28.D[0x0]
    UQXTN  V2.2S, V30.2D
    FMUL V26.2D, V17.2D, V29.D[0x0]
    SQRDMULH H15, H30, V0.H[0x1]
    UMULL V9.4S, V8.4H, V14.H[0x3]
    CMHS  V2.8H, V14.8H, V24.8H
    FCVTZU S11, S0, #10
    UXTL V12.2D, V17.2S
    UQXTN  V28.2S, V0.2D
    MOV V18.S[0x1], V31.S[0x3]
    UQRSHL  B2, B1, B14
    MLA  V16.4H, V8.4H, V12.H[0x0]
    USHLL V3.4S, V15.4H, #0x8
    USHLL V14.2D, V22.2S, #0xb
    SABAL2  V29.4S, V20.8H, V0.8H
    FNEG  V13.4S, V26.4S
    URHADD  V2.16B, V31.16B, V23.16B
    FCVTZU  S9, S21
    SMOV  X3, V5.S[0x3]
    CNT  V28.16B, V25.16B
    SQRSHRUN V30.8B, V18.8H, #3
    SQSHRN B9, H8, #8
    RSHRN V27.2S, V15.2D, #28
    FCVTZS  V9.2S, V7.2S, #31
    URECPE  V25.2S, V19.2S
    UQSHL H28, H0, #0xb
    SQDMLSL2 V20.2D, V10.4S, V15.S[0x2]
    UQSHRN2 V0.16B, V31.8H, #5
    SQSUB  S15, S13, S12
    SSHR  V1.8B, V16.8B, #3
    MOV  X13, V31.D[0x0]
    SMAXV  S19, V3.4S
    SQDMLAL2  V4.4S, V8.8H, V1.8H
    UCVTF S2, S31, #29
    UQSHL S19, S19, #0x13
    FSQRT  V5.2S, V10.2S
    SRSRA V27.2D, V26.2D, #5
    SHL V0.2D, V4.2D, #0x2d
    ZIP2  V10.2D, V8.2D, V31.2D
    CMGT  V22.2D, V9.2D, V19.2D
    URSHR V16.2D, V2.2D, #45
    USHLL2 V29.8H, V29.16B, #0x3
    SMAXV  H25, V13.8H
    FCVTPU  D31, D10
    FCMLE  D22, D29, #0.0
    SADDW2  V24.2D, V13.2D, V25.4S
    UQXTN2  V12.16B, V15.8H
    USQADD  B8, B3
    FMINNMP D7, V25.2D
    UADDLV  H22, V23.8B
    SQSHL  D22, D7, D17
    SQRSHRUN2 V25.4S, V15.2D, #7
    SQSHL  B31, B13, B11
    BIC  V11.8H, #0x52, LSL #8
    UXTL2 V5.8H, V25.16B
    SQDMLSL V0.4S, V25.4H, V7.H[0x4]
    PMULL  V25.8H, V5.8B, V23.8B
    XTN2  V29.8H, V16.4S
    UMLSL V8.4S, V10.4H, V3.H[0x2]
    FCVTZU  D24, D6
    CMLT  D10, D19, #0
    UZP1  V5.16B, V12.16B, V19.16B
    FMLA V11.2D, V10.2D, V5.D[0x1]
    ZIP1  V16.2D, V26.2D, V14.2D
    SQRSHRN V25.2S, V16.2D, #11
    UMLAL V29.4S, V14.4H, V14.H[0x0]
    SSUBW2  V29.8H, V22.8H, V22.16B
    URSHR  V30.4S, V22.4S, #8
    SQSHL H6, H22, #0x2
    BIC  V17.2S, #0xc9, LSL #8
    FRINTI  V26.2D, V8.2D
    FCVTNS  D6, D14
    SHLL2  V21.2D, V20.4S, #32
    SQDMLAL2 V0.4S, V0.8H, V4.H[0x4]
    USHR  V17.8B, V4.8B, #7
    SQDMLSL2 V21.2D, V25.4S, V10.S[0x0]
    RADDHN2  V8.8H, V3.4S, V29.4S
    FCVTPU  D20, D25
    INS V21.H[0x3], V1.H[0x1]
    UQSHL  B30, B17, B16
    FCVTPU  V26.4S, V1.4S
    SQDMLSL2 V16.2D, V10.4S, V13.S[0x2]
    SLI D0, D0, #0x3c
    SADDL2  V17.4S, V17.8H, V14.8H
    SQDMULL V1.2D, V11.2S, V22.S[0x0]
    UQRSHL  B20, B15, B4
    SQSHLU S27, S6, #0x1f
    SSUBL2  V14.8H, V8.16B, V19.16B
    UABD  V29.16B, V9.16B, V12.16B
    SQRSHRUN S22, D18, #17
    SQSHL  V29.2S, V21.2S, #0xe
    UQRSHRN V5.4H, V22.4S, #5
    CMLE  D5, D14, #0
    DUP  V22.2S, V24.S[0x1]
    USHLL2 V28.4S, V30.8H, #0x4
    SQSHL  V4.8B, V29.8B, #0x5
    CMGT  V11.2D, V10.2D, #0
    SHL  V11.4S, V21.4S, #0xf
    BIC  V30.4S, #0xd, LSL #16
    MOV V0.D[0x0], V8.D[0x1]
    UMINV  H29, V18.8H
    SQNEG  V26.2D, V17.2D
    CMHI  V23.8B, V17.8B, V26.8B
    SLI  V1.4H, V22.4H, #0xa
    SSHL  D26, D0, D1
    UMLAL2  V13.2D, V16.4S, V3.4S
    SQXTUN2  V30.16B, V18.8H
    UABA  V12.8B, V6.8B, V22.8B
    CMTST  V29.8B, V8.8B, V21.8B
    FABS  V30.2D, V21.2D
    SUBS  X16, X16, #0x1
    B.NE  TaishanSimdReduceP01_label_650
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X8, X18, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X27, X13, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X6, X4, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X20, X15, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X16, X26, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X19, X18, X9
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X17, X12, X10
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X2, X28, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X14, X27, X14
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X18
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X19
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X14, X22, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X22
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X15, X23, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X16, X8, X26
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X7, X9, X27
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X29
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    FMOV  X4, D2
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X5, X19, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X8, D3
    MOVZ  X19, #0x0, LSL #0
    SUB  X5, X19, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X27, D4
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X8, D5
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X13, X23, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X25, D6
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X8, D7
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X16, D8
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X16, D9
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x8000, LSL #16
    SUB  X29, X19, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X13, D10
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X14, X6, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X16, D11
    MOVZ  X6, #0x0, LSL #0
    SUB  X14, X6, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X14, D12
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #16
    MOVK  X4, #0x8000, LSL #48
    SUB  X11, X4, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X28, D13
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #16
    MOVK  X4, #0x8000, LSL #48
    SUB  X11, X4, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X28, D14
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X17, V15.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X17, D15
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x8000, LSL #16
    SUB  X13, X10, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    FMOV  X28, D16
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X27, D17
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X29, X6, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X22, D18
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X29, X6, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X6, D19
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X5, D20
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X29, D21
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X26, D22
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X19, X5, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X2, D23
    MOVZ  X5, #0x0, LSL #0
    SUB  X19, X5, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X27, V25.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X27, D25
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X28, D26
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X17, D27
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X19, X8, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X12, D28
    MOVZ  X8, #0x0, LSL #0
    SUB  X19, X8, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X22, V29.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X22, D29
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    MOVZ  X2, #0x357c, LSL #0
    MOVK  X2, #0xc882, LSL #16
    MOVK  X2, #0x5292, LSL #32
    MOVK  X2, #0xe942, LSL #48
    MOVZ  X3, #0x7b2a, LSL #0
    MOVK  X3, #0x5f75, LSL #16
    MOVK  X3, #0x5a6e, LSL #32
    MOVK  X3, #0xbbc9, LSL #48
    MOVZ  X4, #0x3407, LSL #0
    MOVK  X4, #0x2eda, LSL #16
    MOVK  X4, #0x6bbb, LSL #32
    MOVK  X4, #0xb875, LSL #48
    MOVZ  X5, #0xb512, LSL #0
    MOVK  X5, #0xf180, LSL #16
    MOVK  X5, #0x83d6, LSL #32
    MOVK  X5, #0xa3c8, LSL #48
    MOVZ  X6, #0x2aa4, LSL #0
    MOVK  X6, #0xc44c, LSL #16
    MOVK  X6, #0x80c0, LSL #32
    MOVK  X6, #0x2658, LSL #48
    MOVZ  X7, #0x33b8, LSL #0
    MOVK  X7, #0x36fc, LSL #16
    MOVK  X7, #0x3f19, LSL #32
    MOVK  X7, #0xc57f, LSL #48
    MOVZ  X8, #0x262d, LSL #0
    MOVK  X8, #0x941f, LSL #16
    MOVK  X8, #0x9fa2, LSL #32
    MOVK  X8, #0x7aa0, LSL #48
    MOVZ  X9, #0x18b8, LSL #0
    MOVK  X9, #0x4a67, LSL #16
    MOVK  X9, #0x5455, LSL #32
    MOVK  X9, #0x1a32, LSL #48
    MOVZ  X10, #0x7dcd, LSL #0
    MOVK  X10, #0x35c7, LSL #16
    MOVK  X10, #0xbd21, LSL #32
    MOVK  X10, #0x9e0f, LSL #48
    MOVZ  X11, #0x6393, LSL #0
    MOVK  X11, #0x3789, LSL #16
    MOVK  X11, #0x12d7, LSL #32
    MOVK  X11, #0x6762, LSL #48
    MOVZ  X12, #0xbc18, LSL #0
    MOVK  X12, #0x3c7f, LSL #16
    MOVK  X12, #0xd179, LSL #32
    MOVK  X12, #0xd9d9, LSL #48
    MOVZ  X13, #0xe062, LSL #0
    MOVK  X13, #0xaea9, LSL #16
    MOVK  X13, #0xc027, LSL #32
    MOVK  X13, #0x411a, LSL #48
    MOVZ  X14, #0x3e46, LSL #0
    MOVK  X14, #0xd2c4, LSL #16
    MOVK  X14, #0x91f5, LSL #32
    MOVK  X14, #0x3e8c, LSL #48
    MOVZ  X15, #0x23d9, LSL #0
    MOVK  X15, #0x5f04, LSL #16
    MOVK  X15, #0x541, LSL #32
    MOVK  X15, #0x528b, LSL #48
    MOVZ  X16, #0xa643, LSL #0
    MOVK  X16, #0x124, LSL #16
    MOVK  X16, #0x9705, LSL #32
    MOVK  X16, #0xc35, LSL #48
    MOVZ  X17, #0x872c, LSL #0
    MOVK  X17, #0x3744, LSL #16
    MOVK  X17, #0x45b6, LSL #32
    MOVK  X17, #0x8dcf, LSL #48
    MOVZ  X18, #0xa57c, LSL #0
    MOVK  X18, #0x6d87, LSL #16
    MOVK  X18, #0x35c1, LSL #32
    MOVK  X18, #0x2e8, LSL #48
    MOVZ  X19, #0x4d07, LSL #0
    MOVK  X19, #0xbd2a, LSL #16
    MOVK  X19, #0x17d5, LSL #32
    MOVK  X19, #0x717f, LSL #48
    MOVZ  X20, #0xa5fb, LSL #0
    MOVK  X20, #0xba98, LSL #16
    MOVK  X20, #0xa910, LSL #32
    MOVK  X20, #0x3ef6, LSL #48
    MOVZ  X21, #0x135c, LSL #0
    MOVK  X21, #0xc00d, LSL #16
    MOVK  X21, #0x4a46, LSL #32
    MOVK  X21, #0x714c, LSL #48
    MOVZ  X22, #0x2265, LSL #0
    MOVK  X22, #0x490b, LSL #16
    MOVK  X22, #0xc4d8, LSL #32
    MOVK  X22, #0xa8b4, LSL #48
    MOVZ  X23, #0x8667, LSL #0
    MOVK  X23, #0xcd53, LSL #16
    MOVK  X23, #0xa8ab, LSL #32
    MOVK  X23, #0x38ba, LSL #48
    MOVZ  X25, #0xbf57, LSL #0
    MOVK  X25, #0xaa78, LSL #16
    MOVK  X25, #0xa117, LSL #32
    MOVK  X25, #0x498a, LSL #48
    MOVZ  X26, #0x199b, LSL #0
    MOVK  X26, #0x2393, LSL #16
    MOVK  X26, #0xd637, LSL #32
    MOVK  X26, #0x5355, LSL #48
    MOVZ  X27, #0x4121, LSL #0
    MOVK  X27, #0xca04, LSL #16
    MOVK  X27, #0xea4c, LSL #32
    MOVK  X27, #0x235d, LSL #48
    MOVZ  X28, #0x3fd, LSL #0
    MOVK  X28, #0x8741, LSL #16
    MOVK  X28, #0xdbb9, LSL #32
    MOVK  X28, #0xe2f9, LSL #48
    MOVZ  X29, #0xd49f, LSL #0
    MOVK  X29, #0x5fe4, LSL #16
    MOVK  X29, #0x62e4, LSL #32
    MOVK  X29, #0x964, LSL #48
    FMOV  D0, X14
    FMOV  V0.D[1], X10
    FMOV  D1, X15
    FMOV  V1.D[1], X26
    FMOV  D2, X22
    FMOV  V2.D[1], X27
    FMOV  D3, X27
    FMOV  V3.D[1], X20
    FMOV  D4, X26
    FMOV  V4.D[1], X9
    FMOV  D5, X28
    FMOV  V5.D[1], X7
    FMOV  D6, X22
    FMOV  V6.D[1], X10
    FMOV  D7, X11
    FMOV  V7.D[1], X29
    FMOV  D8, X13
    FMOV  V8.D[1], X8
    FMOV  D9, X3
    FMOV  V9.D[1], X20
    FMOV  D10, X18
    FMOV  V10.D[1], X27
    FMOV  D11, X7
    FMOV  V11.D[1], X6
    FMOV  D12, X3
    FMOV  V12.D[1], X20
    FMOV  D13, X9
    FMOV  V13.D[1], X10
    FMOV  D14, X6
    FMOV  V14.D[1], X11
    FMOV  D15, X25
    FMOV  V15.D[1], X12
    FMOV  D16, X25
    FMOV  V16.D[1], X18
    FMOV  D17, X2
    FMOV  V17.D[1], X12
    FMOV  D18, X9
    FMOV  V18.D[1], X23
    FMOV  D19, X13
    FMOV  V19.D[1], X29
    FMOV  D20, X6
    FMOV  V20.D[1], X21
    FMOV  D21, X18
    FMOV  V21.D[1], X16
    FMOV  D22, X9
    FMOV  V22.D[1], X18
    FMOV  D23, X14
    FMOV  V23.D[1], X16
    FMOV  D24, X3
    FMOV  V24.D[1], X4
    FMOV  D25, X28
    FMOV  V25.D[1], X23
    FMOV  D26, X12
    FMOV  V26.D[1], X14
    FMOV  D27, X29
    FMOV  V27.D[1], X21
    FMOV  D28, X8
    FMOV  V28.D[1], X12
    FMOV  D29, X6
    FMOV  V29.D[1], X19
    FMOV  D30, X7
    FMOV  V30.D[1], X13
    FMOV  D31, X13
    FMOV  V31.D[1], X20
    MOVZ  X19, #0xa, LSL #0
TaishanSimdReduceP01_label_729:
    BIC  V4.8H, #0x16
    SMINV  S23, V26.4S
    UQXTN  V27.2S, V13.2D
    SXTL V2.8H, V25.8B
    SSHLL V12.8H, V27.8B, #0x6
    FCVTZU  S10, S29
    SRSHR  V9.4H, V29.4H, #5
    SMINV  S28, V28.4S
    SADDW  V10.8H, V25.8H, V2.8B
    SQNEG  D31, D26
    FMLA V2.4S, V11.4S, V18.S[0x3]
    CMLT  D17, D3, #0
    SMOV W26, V11.H[0x3]
    UMULL2  V28.8H, V12.16B, V4.16B
    FCMGT  S14, S25, S21
    SQSHL  V21.2D, V9.2D, V6.2D
    FMLA  V4.2S, V10.2S, V14.2S
    FCMGT  V10.4S, V26.4S, #0.0
    SQADD  S11, S4, S17
    UMINV  S20, V22.4S
    SQSHL  D27, D6, D7
    CMLE  V26.2D, V2.2D, #0
    SQRSHRUN B17, H12, #6
    SQSHRN2 V9.8H, V0.4S, #7
    SRSHL  V9.16B, V24.16B, V25.16B
    FMINNMP  V10.2D, V23.2D, V20.2D
    SQRSHRN V8.2S, V31.2D, #29
    UMOV X20, V20.D[0x0]
    USHLL2 V7.8H, V3.16B, #0x2
    SMAXV  B22, V30.16B
    SQSHLU  V28.16B, V24.16B, #0x4
    SABDL2  V12.4S, V21.8H, V10.8H
    URSHL  D27, D26, D9
    FMINNM  V1.2D, V21.2D, V28.2D
    SQRDMULH  V3.2S, V26.2S, V17.2S
    SSHLL2 V15.4S, V25.8H, #0x4
    FRECPE  V2.2S, V12.2S
    FCVTZS  S30, S6
    FCVTZU D12, D31, #12
    UQSHL  H26, H30, H31
    SMULL2 V2.2D, V20.4S, V22.S[0x1]
    UQRSHL  B30, B3, B25
    USRA  V28.4H, V27.4H, #2
    UMAXV  H3, V29.4H
    FMUL  V19.2D, V6.2D, V25.2D
    FMULX V1.2D, V1.2D, V8.D[0x1]
    UQRSHRN V7.8B, V17.8H, #3
    SQADD  B29, B8, B23
    UABAL  V20.8H, V9.8B, V19.8B
    URSRA  V0.4S, V1.4S, #3
    FCVTAS  D2, D11
    FNEG  V30.4S, V16.4S
    SUQADD  B8, B7
    SQDMLSL V31.4S, V9.4H, V3.H[0x2]
    SQXTN2  V5.4S, V29.2D
    SQSHRUN2 V5.4S, V24.2D, #24
    RADDHN2  V19.4S, V15.2D, V21.2D
    SQSUB  S27, S4, S30
    UMAX  V0.16B, V6.16B, V2.16B
    FRECPS  D16, D8, D3
    FCMGE  S22, S0, S18
    SQNEG  S21, S21
    SSHR  V17.4S, V23.4S, #21
    SMOV  X22, V22.H[0x6]
    SQDMLSL D7, S19, V4.S[0x0]
    SQSHLU H7, H30, #0x9
    FRECPS  D7, D31, D21
    SQSHLU B31, B23, #0x6
    UMOV W18, V17.S[0x2]
    CMLT  D27, D0, #0
    SRSHR  V15.16B, V1.16B, #7
    FRSQRTE  D13, D29
    UQSHL D22, D31, #0x2d
    USUBW  V25.2D, V2.2D, V1.2S
    SXTL2 V18.2D, V30.4S
    SQDMLSL  D10, S13, S24
    UQADD  S30, S4, S17
    SCVTF  D31, D28
    UMINV  H19, V23.8H
    UMAXV  B16, V2.8B
    SQDMULL V31.2D, V12.2S, V14.S[0x2]
    SRI  V20.4S, V31.4S, #6
    UQSHRN2 V4.16B, V25.8H, #3
    FCVTXN2  V14.4S, V5.2D
    FMINNMP  V19.4S, V4.4S, V6.4S
    FCVTZU  D13, D7
    ADDV  H8, V0.8H
    USHR  V5.8H, V23.8H, #5
    FCMGT  D17, D12, D25
    SQRSHL  H4, H14, H14
    URSRA  V22.4S, V4.4S, #29
    CNT  V19.8B, V22.8B
    URECPE  V30.2S, V30.2S
    FCVTXN  S18, D6
    URSRA  V31.8B, V14.8B, #4
    SQDMLAL2  V23.4S, V14.8H, V12.8H
    CMEQ  D0, D7, #0
    SMLAL V15.4S, V7.4H, V12.H[0x1]
    SHRN2 V22.16B, V21.8H, #6
    UMLAL V28.2D, V1.2S, V12.S[0x0]
    SQSHL  B17, B19, B13
    URSRA V13.2D, V24.2D, #21
    FRINTP  V13.2D, V4.2D
    INS V21.S[0x1], V28.S[0x1]
    SQSHRUN H9, S13, #3
    ADDHN  V31.4H, V26.4S, V6.4S
    UQSHRN2 V15.4S, V31.2D, #17
    SSUBL2  V6.8H, V3.16B, V19.16B
    SUQADD  B3, B22
    SQDMLSL2  V14.4S, V1.8H, V20.8H
    SMLAL2  V12.2D, V1.4S, V24.4S
    SQRSHRN V14.4H, V20.4S, #11
    FNEG  V18.2S, V22.2S
    URSHL  V15.16B, V9.16B, V18.16B
    FRSQRTS  S17, S15, S18
    SSHLL2 V17.8H, V8.16B, #0x1
    SQDMULH  V28.8H, V8.8H, V10.H[0x6]
    FMULX V29.2D, V26.2D, V25.D[0x0]
    UQSHL  H20, H9, H16
    RSHRN V7.8B, V9.8H, #7
    FMAXP S28, V29.2S
    SLI  V20.16B, V30.16B, #0x2
    FCMEQ  S17, S6, S31
    SQNEG  H0, H5
    SQRSHRN V14.2S, V1.2D, #23
    FCVTAU  V8.2D, V11.2D
    SRSRA  V15.16B, V10.16B, #4
    SRSHR  V18.2S, V26.2S, #6
    SQSHLU  V19.16B, V24.16B, #0x3
    FCVTAS  S28, S20
    SQSHLU B24, B10, #0x5
    SQDMLSL2 V29.2D, V2.4S, V20.S[0x2]
    SMINV  S9, V8.4S
    PMUL  V23.16B, V30.16B, V15.16B
    UQRSHRN2 V0.8H, V13.4S, #14
    SQSHL V20.2D, V21.2D, #0x28
    SQSHL D8, D17, #0x26
    SQRSHL  V24.4H, V2.4H, V15.4H
    SMLSL2 V14.4S, V29.8H, V10.H[0x7]
    UQSHL B17, B22, #0x3
    UMULL2  V27.4S, V10.8H, V9.8H
    UQXTN  S8, D17
    UMULL2 V15.4S, V26.8H, V0.H[0x4]
    SMAXV  S20, V15.4S
    FMUL V31.4S, V6.4S, V15.S[0x0]
    SXTL V29.8H, V13.8B
    NEG  D27, D24
    FCVTNU  V4.4S, V3.4S
    SADDL  V3.8H, V9.8B, V31.8B
    DUP V23.2S, W13
    FCVTXN  V31.2S, V3.2D
    FCMGE  V25.2S, V4.2S, #0.0
    ADDP  D13, V17.2D
    USHR V27.2D, V6.2D, #34
    SHSUB  V11.4S, V24.4S, V13.4S
    SQSUB  V18.2S, V17.2S, V27.2S
    SABAL  V24.2D, V2.2S, V4.2S
    SMULL2 V27.4S, V27.8H, V0.H[0x6]
    SSHR  V28.4S, V26.4S, #31
    ABS  D26, D14
    FCVTZS  V5.2D, V10.2D
    SQDMULL  D2, S6, S18
    SRSHR  V8.2S, V26.2S, #5
    SQRSHL  B15, B24, B5
    SSHR  V6.2S, V21.2S, #9
    UQSHL B10, B3, #0x7
    UMOV X28, V12.D[0x0]
    SSRA  V7.4H, V25.4H, #4
    SSHR D27, D31, #34
    SADDLV  H22, V2.8B
    USHR V31.2D, V7.2D, #43
    USRA  V28.4H, V22.4H, #6
    FMUL V18.2S, V31.2S, V10.S[0x2]
    NOT  V31.8B, V6.8B
    FCMLT  D8, D3, #0.0
    FCVTPS  D28, D4
    URSHL  D24, D5, D11
    SQRSHRN B3, H20, #1
    FRINTA  V18.2D, V29.2D
    SXTL2 V31.4S, V5.8H
    UQSUB  B27, B30, B16
    SCVTF  D9, D29
    SABAL2  V4.8H, V25.16B, V29.16B
    SQADD  B28, B27, B22
    FMLS D10, D7, V20.D[0x1]
    SQDMLSL V20.2D, V21.2S, V25.S[0x0]
    SQSHLU B7, B19, #0x2
    SUQADD  D12, D28
    DUP  V20.16B, V11.B[0x3]
    UQRSHL  D9, D11, D29
    FMIN  V24.4S, V24.4S, V18.4S
    FMIN  V8.4S, V11.4S, V31.4S
    FRSQRTE  V21.4S, V16.4S
    SQSHRN H6, S15, #14
    UQRSHRN V5.8B, V16.8H, #1
    UCVTF  V8.2S, V2.2S
    SXTL2 V25.8H, V3.16B
    UMAXV  H12, V17.8H
    SUQADD  B17, B11
    DUP B16, V29.B[0x8]
    SUBS  X19, X19, #0x1
    B.NE  TaishanSimdReduceP01_label_729
    MOVZ  X26, #0x357c, LSL #0
    MOVK  X26, #0xc882, LSL #16
    MOVK  X26, #0x5292, LSL #32
    MOVK  X26, #0xe942, LSL #48
    SUB  X14, X26, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    MOVZ  X19, #0x7b2a, LSL #0
    MOVK  X19, #0x5f75, LSL #16
    MOVK  X19, #0x5a6e, LSL #32
    MOVK  X19, #0xbbc9, LSL #48
    SUB  X13, X19, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    MOVZ  X29, #0x3407, LSL #0
    MOVK  X29, #0x2eda, LSL #16
    MOVK  X29, #0x6bbb, LSL #32
    MOVK  X29, #0xb875, LSL #48
    SUB  X27, X29, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    MOVZ  X22, #0xb512, LSL #0
    MOVK  X22, #0xf180, LSL #16
    MOVK  X22, #0x83d6, LSL #32
    MOVK  X22, #0xa3c8, LSL #48
    SUB  X15, X22, X5
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    MOVZ  X9, #0x2aa4, LSL #0
    MOVK  X9, #0xc44c, LSL #16
    MOVK  X9, #0x80c0, LSL #32
    MOVK  X9, #0x2658, LSL #48
    SUB  X7, X9, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X14, X12, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    MOVZ  X11, #0x262d, LSL #0
    MOVK  X11, #0x941f, LSL #16
    MOVK  X11, #0x9fa2, LSL #32
    MOVK  X11, #0x7aa0, LSL #48
    SUB  X21, X11, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    MOVZ  X17, #0x2aa4, LSL #0
    MOVK  X17, #0xc44c, LSL #16
    MOVK  X17, #0x80c0, LSL #32
    MOVK  X17, #0x2658, LSL #48
    SUB  X12, X17, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    MOVZ  X9, #0x7dcd, LSL #0
    MOVK  X9, #0x35c7, LSL #16
    MOVK  X9, #0xbd21, LSL #32
    MOVK  X9, #0x9e0f, LSL #48
    SUB  X13, X9, X10
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0x262d, LSL #0
    MOVK  X7, #0x941f, LSL #16
    MOVK  X7, #0x9fa2, LSL #32
    MOVK  X7, #0x7aa0, LSL #48
    SUB  X4, X7, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    MOVZ  X20, #0x2aa4, LSL #0
    MOVK  X20, #0xc44c, LSL #16
    MOVK  X20, #0x80c0, LSL #32
    MOVK  X20, #0x2658, LSL #48
    SUB  X26, X20, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    MOVZ  X27, #0x7b2a, LSL #0
    MOVK  X27, #0x5f75, LSL #16
    MOVK  X27, #0x5a6e, LSL #32
    MOVK  X27, #0xbbc9, LSL #48
    SUB  X12, X27, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    MOVZ  X22, #0xb512, LSL #0
    MOVK  X22, #0xf180, LSL #16
    MOVK  X22, #0x83d6, LSL #32
    MOVK  X22, #0xa3c8, LSL #48
    SUB  X28, X22, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    MOVZ  X15, #0x8667, LSL #0
    MOVK  X15, #0xcd53, LSL #16
    MOVK  X15, #0xa8ab, LSL #32
    MOVK  X15, #0x38ba, LSL #48
    SUB  X29, X15, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    MOVZ  X2, #0xbf57, LSL #0
    MOVK  X2, #0xaa78, LSL #16
    MOVK  X2, #0xa117, LSL #32
    MOVK  X2, #0x498a, LSL #48
    SUB  X9, X2, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    MOVZ  X22, #0x7b2a, LSL #0
    MOVK  X22, #0x5f75, LSL #16
    MOVK  X22, #0x5a6e, LSL #32
    MOVK  X22, #0xbbc9, LSL #48
    SUB  X23, X22, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X18, D2
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X23, X21, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X13, D3
    MOVZ  X21, #0x0, LSL #0
    SUB  X23, X21, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X7, D4
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X6, D5
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X25, D6
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X2, D7
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X20
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    FMOV  X20, D8
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X20
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X3, D9
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X6, D10
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7ff8, LSL #48
    SUB  X15, X19, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X23, D11
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X7, D12
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X28, X22, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X12, D13
    MOVZ  X22, #0x0, LSL #0
    SUB  X28, X22, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X17, D14
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X17, V15.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X17, D15
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
TaishanSimdReduceP01_label_496:
    FMOV  X10, D16
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X27, D17
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X17
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X17, D18
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X17
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X14, D19
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X5, D20
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x7f80, LSL #16
    MOVK  X26, #0x7f80, LSL #48
    SUB  X17, X26, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X7, D21
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x7f80, LSL #16
    MOVK  X26, #0x7f80, LSL #48
    SUB  X17, X26, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X21, V22.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X21
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X21, D22
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X21
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X17, D23
    MOVZ  X29, #0xe062, LSL #0
    MOVK  X29, #0xaea9, LSL #16
    MOVK  X29, #0xe062, LSL #32
    MOVK  X29, #0xaea9, LSL #48
    SUB  X19, X29, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X5, V25.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X5
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X5, D25
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X5
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X17, D26
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X15, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X15, D27
    MOVZ  X7, #0xff, LSL #0
    SUB  X17, X7, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X4, D28
    MOVZ  X27, #0xff, LSL #0
    SUB  X7, X27, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X12, X28, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    FMOV  X9, D29
    MOVZ  X28, #0x0, LSL #0
    SUB  X12, X28, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X7
    FMOV  V0.D[1], X14
    FMOV  D1, X12
    FMOV  V1.D[1], X15
    FMOV  D2, X10
    FMOV  V2.D[1], X15
    FMOV  D3, X5
    FMOV  V3.D[1], X14
    FMOV  D4, X6
    FMOV  V4.D[1], X14
    FMOV  D5, X17
    FMOV  V5.D[1], X12
    FMOV  D6, X29
    FMOV  V6.D[1], X13
    FMOV  D7, X7
    FMOV  V7.D[1], X7
    FMOV  D8, X15
    FMOV  V8.D[1], X9
    FMOV  D9, X7
    FMOV  V9.D[1], X6
    FMOV  D10, X5
    FMOV  V10.D[1], X16
    FMOV  D11, X5
    FMOV  V11.D[1], X28
    FMOV  D12, X5
    FMOV  V12.D[1], X14
    FMOV  D13, X9
    FMOV  V13.D[1], X6
    FMOV  D14, X13
    FMOV  V14.D[1], X28
    FMOV  D15, X25
    FMOV  V15.D[1], X4
    FMOV  D16, X6
    FMOV  V16.D[1], X29
    FMOV  D17, X26
    FMOV  V17.D[1], X27
    FMOV  D18, X5
    FMOV  V18.D[1], X18
    FMOV  D19, X27
    FMOV  V19.D[1], X12
    FMOV  D20, X17
    FMOV  V20.D[1], X19
    FMOV  D21, X26
    FMOV  V21.D[1], X12
    FMOV  D22, X15
    FMOV  V22.D[1], X15
    FMOV  D23, X29
    FMOV  V23.D[1], X20
    FMOV  D24, X20
    FMOV  V24.D[1], X21
    FMOV  D25, X16
    FMOV  V25.D[1], X15
    FMOV  D26, X17
    FMOV  V26.D[1], X12
    FMOV  D27, X18
    FMOV  V27.D[1], X28
    FMOV  D28, X13
    FMOV  V28.D[1], X18
    FMOV  D29, X27
    FMOV  V29.D[1], X6
    FMOV  D30, X27
    FMOV  V30.D[1], X16
    FMOV  D31, X6
    FMOV  V31.D[1], X25
    MOVZ  X13, #0xa, LSL #0
TaishanSimdReduceP01_label_810:
    FCVTPS  D28, D29
    UMINV  S26, V30.4S
    SSHLL V15.8H, V26.8B, #0x6
    UMIN  V4.4H, V12.4H, V31.4H
    DUP H28, V1.H[0x2]
    SHLL  V18.8H, V31.8B, #8
    SQDMLAL V25.4S, V31.4H, V6.H[0x0]
    RSHRN2 V27.8H, V15.4S, #15
    FCVTAS  S31, S30
    REV64  V2.4H, V21.4H
    SADDW  V24.4S, V12.4S, V20.4H
    UHSUB  V31.16B, V17.16B, V4.16B
    FCVTZS S28, S20, #25
    FMLS D22, D8, V28.D[0x0]
    SQDMULL2 V19.2D, V30.4S, V8.S[0x2]
    FSQRT  V19.2D, V18.2D
    SQSHLU  V0.8B, V28.8B, #0x5
    SRI  V17.16B, V29.16B, #4
    FMAXNMP  V24.2S, V17.2S, V21.2S
    SQDMULL D0, S9, V5.S[0x3]
    SQDMLSL2 V11.4S, V24.8H, V1.H[0x6]
    SMOV  X10, V10.S[0x2]
    SQSHL  V21.4H, V0.4H, #0x5
    FRINTX  V28.4S, V21.4S
    UMLSL2 V8.4S, V28.8H, V12.H[0x7]
    SQDMLSL S6, H8, V9.H[0x3]
    SUB  D26, D10, D31
    FACGT  V21.2D, V17.2D, V9.2D
    SRI  V3.8B, V2.8B, #2
    UXTL V26.8H, V30.8B
    SQRSHRN V21.4H, V29.4S, #16
    FRSQRTS  S22, S5, S29
    SQXTN  B18, H29
    FABD  V18.2D, V11.2D, V4.2D
    SHRN V12.2S, V4.2D, #29
    SHRN V7.4H, V3.4S, #4
    FMULX V6.4S, V7.4S, V6.S[0x0]
    FRSQRTS  V10.2D, V17.2D, V11.2D
    FMINNMP S19, V24.2S
    UMULL V24.2D, V1.2S, V9.S[0x1]
    SQSHLU V21.2D, V6.2D, #0x39
    SMLAL2 V21.2D, V26.4S, V10.S[0x2]
    SQNEG  S18, S31
    DUP B9, V25.B[0x5]
    SADDL2  V25.2D, V26.4S, V9.4S
    SQDMLAL V4.2D, V30.2S, V10.S[0x3]
    UMLAL2 V8.4S, V28.8H, V9.H[0x5]
    SQABS  H31, H11
    UQSHL  V18.4H, V11.4H, #0xe
    SQDMULL  V1.4S, V16.4H, V3.4H
    SMULL V9.2D, V17.2S, V20.S[0x3]
    FMAXNM  V6.4S, V26.4S, V15.4S
    UQSHRN2 V14.4S, V29.2D, #4
    FCVTNS  D29, D3
    UMLSL2 V10.2D, V15.4S, V24.S[0x3]
    USHR V23.2D, V7.2D, #5
    SSHL  V15.8H, V24.8H, V21.8H
    SQXTUN  B10, H22
    SABDL2  V19.4S, V24.8H, V14.8H
    SHRN2 V17.8H, V25.4S, #2
    SMIN  V4.2S, V25.2S, V6.2S
    USUBW2  V22.8H, V26.8H, V12.16B
    ADD  V0.4H, V3.4H, V22.4H
    SQSUB  S22, S25, S3
    SADDW  V15.4S, V23.4S, V4.4H
    UQXTN2  V20.8H, V9.4S
    SMOV W20, V14.H[0x2]
    SSHR  V31.16B, V27.16B, #2
    PMULL  V9.1Q, V29.1D, V21.1D
    SSHLL2 V17.4S, V28.8H, #0x9
    SMULL  V30.8H, V26.8B, V12.8B
    SLI D15, D25, #0x1f
    SQSHL H17, H19, #0xd
    SABDL  V3.4S, V20.4H, V3.4H
    UQXTN  H11, S13
    SUQADD  D0, D20
    RSUBHN2  V3.16B, V17.8H, V9.8H
    SQDMLAL2  V18.2D, V0.4S, V7.4S
    CMGE  V15.8H, V6.8H, #0
    SQRSHL  H26, H10, H6
    UADDLV  H14, V10.8B
    FSQRT  V26.2S, V15.2S
    FRSQRTE  D11, D25
    CMEQ  V15.8B, V6.8B, #0
    DUP S10, V5.S[0x2]
    TRN1  V28.8H, V1.8H, V0.8H
    SQSHRN V8.2S, V24.2D, #6
    SCVTF V30.2D, V10.2D, #60
    SRI  V15.8H, V21.8H, #5
    SSHR  V19.2S, V22.2S, #25
    SSHL  D20, D3, D26
    SUQADD  S15, S7
    SABDL  V24.8H, V15.8B, V21.8B
    FRSQRTE  V6.2D, V0.2D
    FCVTNU  D17, D13
    USRA  V28.2S, V0.2S, #10
    UQSHL  D24, D12, D28
    FRSQRTE  V12.2S, V12.2S
    UQXTN  B13, H17
    SHRN2 V16.16B, V3.8H, #8
    FCVTZU  S27, S28
    SQNEG  V23.4H, V9.4H
    FRINTI  V6.4S, V12.4S
    UMOV X14, V21.D[0x1]
    FCVTMS  D24, D14
    MOVI  V7.4S, #0x75
    SMULL2 V29.2D, V30.4S, V14.S[0x1]
    FRECPE  V9.4S, V14.4S
    SQRSHRN S0, D0, #30
    SCVTF  V13.4S, V18.4S
    CMEQ  D9, D20, #0
    FADD  V13.2S, V16.2S, V25.2S
    BIC  V17.16B, V6.16B, V18.16B
    SRSRA  V24.8B, V22.8B, #4
    SQABS  B4, B30
    SSHL  V5.16B, V28.16B, V0.16B
    SRI V30.2D, V0.2D, #23
    MOV V4.D[0x1], V26.D[0x0]
    SMLAL2 V24.4S, V26.8H, V0.H[0x2]
    FCMGT  S25, S14, S12
    CMLE  D3, D4, #0
    FMULX V18.2D, V4.2D, V26.D[0x0]
    SQSHLU  V21.4S, V5.4S, #0x4
    SQDMULL V22.4S, V0.4H, V7.H[0x5]
    SHADD  V22.4S, V17.4S, V27.4S
    FMOV  V1.2D, #0.26562500
    SSRA D28, D9, #46
    USQADD  D5, D6
    DUP V14.8B, W22
    FMULX  S15, S13, S7
    FMINNM  V12.2D, V24.2D, V10.2D
    FMINV  S28, V25.4S
    SQSHL  S14, S24, S26
    SQSUB  D9, D16, D21
    FMINNM  V24.2S, V21.2S, V27.2S
    FABD  V22.2D, V0.2D, V7.2D
    SCVTF D0, D6, #42
    XTN  V12.8B, V13.8H
    USUBL  V27.4S, V29.4H, V4.4H
    SQXTN  B0, H22
    UMOV W22, V24.S[0x2]
    SMLAL V1.2D, V17.2S, V5.S[0x0]
    FRECPS  S22, S26, S25
    URSHR  V12.8H, V30.8H, #14
    SQXTN  H20, S14
    SRSRA D15, D28, #61
    SLI  V18.8H, V22.8H, #0xe
    CMEQ  V29.8H, V28.8H, #0
    UCVTF  S29, S3
    SQRSHRUN V0.8B, V18.8H, #5
    SQDMULL V14.2D, V1.2S, V10.S[0x2]
    SQDMLSL2 V7.4S, V30.8H, V8.H[0x0]
    SQSHLU D4, D15, #0x33
    USHR  V10.16B, V13.16B, #4
    SMAXV  B2, V27.16B
    FCVTPS  V21.4S, V9.4S
    USHR  V12.4S, V4.4S, #5
    SQDMULL2 V0.2D, V10.4S, V13.S[0x0]
    REV64  V30.4H, V27.4H
    MOV B14, V20.B[0x4]
    FCMGT  S9, S24, #0.0
    SQSHLU H9, H20, #0xb
    FCVTAU  S11, S31
    SSHL  D8, D31, D4
    SABAL  V9.4S, V27.4H, V31.4H
    MOV  X16, V23.D[0x1]
    SQSHRN H7, S29, #6
    DUP V13.2S, W10
    MVNI  V9.4H, #0xbf
    FACGT  V4.2S, V20.2S, V5.2S
    FRINTZ  V21.2D, V0.2D
    SQXTN  H2, S15
    SQSHL  H12, H15, H14
    SQDMULL  V24.4S, V2.4H, V23.4H
    MOV V22.D[0x0], X14
    ADD  V10.2D, V11.2D, V1.2D
    SHRN2 V7.4S, V0.2D, #24
    MOV V0.D[0x1], V24.D[0x0]
    REV16  V23.8B, V23.8B
    REV16  V17.8B, V14.8B
    CMHI  V2.8B, V17.8B, V12.8B
    SQSHRUN V0.2S, V2.2D, #12
    FMAXP  V14.2S, V30.2S, V1.2S
    URECPE  V29.4S, V17.4S
    SHRN V23.4H, V4.4S, #1
    SQDMLAL V23.2D, V14.2S, V18.S[0x1]
    USHR  V6.2S, V8.2S, #30
    SQSHRN H9, S21, #9
    TRN2  V10.16B, V31.16B, V29.16B
    FRINTP  V14.4S, V18.4S
    UXTL2 V4.8H, V22.16B
    UQSHL D11, D2, #0x3c
    USQADD  V7.4S, V29.4S
    UQADD  H15, H21, H7
    SMULL2 V31.4S, V7.8H, V4.H[0x2]
    UQSHRN V20.2S, V26.2D, #25
    FCVTZS  V1.4S, V1.4S, #32
    FMULX V3.2D, V20.2D, V0.D[0x0]
    SQRSHL  V17.8B, V10.8B, V31.8B
    SLI  V7.16B, V29.16B, #0x4
    SUBS  X13, X13, #0x1
    B.NE  TaishanSimdReduceP01_label_810
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X26, X19, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X28, X8, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    MOVZ  X12, #0xff00, LSL #0
    MOVK  X12, #0xff00, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X9, X12, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    MOVZ  X8, #0xff00, LSL #0
    MOVK  X8, #0xff00, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X10, X8, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X23, X19, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X17
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X6, X23, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X16, X21, X19
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X19, X5, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X3, X18, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X27
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X13, D2
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X20, X17, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X16, D3
    MOVZ  X17, #0x0, LSL #0
    SUB  X20, X17, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X2, D4
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X17, D5
    MOVZ  X13, #0xfff0, LSL #0
    MOVK  X13, #0x7fbe, LSL #16
    MOVK  X13, #0x7f80, LSL #48
    SUB  X14, X13, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X12, D6
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X11, #0xf0f0, LSL #0
    MOVK  X11, #0xf0f0, LSL #16
    MOVK  X11, #0xf0f0, LSL #32
    MOVK  X11, #0xf0f0, LSL #48
    SUB  X15, X11, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X12, D7
    MOVZ  X11, #0xfffe, LSL #0
    MOVK  X11, #0xf0f0, LSL #16
    MOVK  X11, #0xf0f0, LSL #32
    MOVK  X11, #0xf0f0, LSL #48
    SUB  X15, X11, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X23, D8
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
TaishanSimdReduceP01_label_253:
    FMOV  X14, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X14, D9
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X22, #0xff00, LSL #0
    MOVK  X22, #0xff00, LSL #16
    MOVK  X22, #0xff00, LSL #32
    MOVK  X22, #0xff00, LSL #48
    SUB  X29, X22, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X17, D10
    MOVZ  X22, #0xff00, LSL #0
    MOVK  X22, #0xff00, LSL #16
    MOVK  X22, #0xff00, LSL #32
    MOVK  X22, #0xff00, LSL #48
    SUB  X29, X22, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X23, D11
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X14, D12
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X28, D13
    MOVZ  X18, #0xff00, LSL #0
    MOVK  X18, #0xff00, LSL #16
    MOVK  X18, #0xff00, LSL #32
    MOVK  X18, #0xff00, LSL #48
    SUB  X15, X18, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x4000, LSL #16
    MOVK  X7, #0x4000, LSL #48
    SUB  X26, X7, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    FMOV  X9, D14
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X2, D15
    MOVZ  X9, #0x7ffe, LSL #0
    SUB  X14, X9, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X25, V16.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X25, D16
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X13, D17
    MOVZ  X22, #0xff00, LSL #0
    MOVK  X22, #0xff00, LSL #16
    MOVK  X22, #0xff00, LSL #32
    MOVK  X22, #0xff00, LSL #48
    SUB  X4, X22, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X27, #0x3fff, LSL #0
    MOVK  X27, #0x3fff, LSL #16
TaishanSimdReduceP01_label_46:
    MOVK  X27, #0x3fff, LSL #32
    MOVK  X27, #0x3fef, LSL #48
    SUB  X19, X27, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X13, D18
    MOVZ  X27, #0x0, LSL #0
    SUB  X19, X27, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X11, D19
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X19, X27, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X14, D20
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X19, X27, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X6, D21
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X12, D22
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X27, D23
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X10, V25.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X10, D25
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X11, D26
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7fc0, LSL #16
    MOVK  X16, #0x7fc0, LSL #48
    SUB  X22, X16, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X11, D27
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X29, D28
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X22, V29.D[1]
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X19, X17, X22
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X22, D29
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X19, X17, X22
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
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
    FMOV  D0, X8
    FMOV  V0.D[1], X17
    FMOV  D1, X19
    FMOV  V1.D[1], X3
    FMOV  D2, X12
    FMOV  V2.D[1], X14
    FMOV  D3, X19
    FMOV  V3.D[1], X22
    FMOV  D4, X19
    FMOV  V4.D[1], X29
    FMOV  D5, X26
    FMOV  V5.D[1], X16
    FMOV  D6, X29
    FMOV  V6.D[1], X8
    FMOV  D7, X18
    FMOV  V7.D[1], X28
    FMOV  D8, X8
    FMOV  V8.D[1], X2
    FMOV  D9, X11
    FMOV  V9.D[1], X26
    FMOV  D10, X22
    FMOV  V10.D[1], X5
    FMOV  D11, X21
    FMOV  V11.D[1], X23
    FMOV  D12, X19
    FMOV  V12.D[1], X25
    FMOV  D13, X17
    FMOV  V13.D[1], X8
    FMOV  D14, X16
    FMOV  V14.D[1], X15
    FMOV  D15, X19
    FMOV  V15.D[1], X12
    FMOV  D16, X28
    FMOV  V16.D[1], X20
    FMOV  D17, X9
    FMOV  V17.D[1], X8
    FMOV  D18, X19
    FMOV  V18.D[1], X12
    FMOV  D19, X12
    FMOV  V19.D[1], X15
    FMOV  D20, X19
    FMOV  V20.D[1], X16
    FMOV  D21, X10
    FMOV  V21.D[1], X20
    FMOV  D22, X10
    FMOV  V22.D[1], X8
    FMOV  D23, X8
    FMOV  V23.D[1], X21
    FMOV  D24, X5
    FMOV  V24.D[1], X8
    FMOV  D25, X28
    FMOV  V25.D[1], X2
    FMOV  D26, X27
    FMOV  V26.D[1], X15
    FMOV  D27, X16
    FMOV  V27.D[1], X23
    FMOV  D28, X16
    FMOV  V28.D[1], X10
    FMOV  D29, X9
    FMOV  V29.D[1], X21
    FMOV  D30, X8
    FMOV  V30.D[1], X21
    FMOV  D31, X13
    FMOV  V31.D[1], X27
    MOVZ  X12, #0xf, LSL #0
TaishanSimdReduceP01_label_891:
    SQDMLSL2 V1.2D, V1.4S, V4.S[0x1]
    FCMLE  D7, D22, #0.0
    FMLA V26.2S, V15.2S, V21.S[0x1]
    FCVTXN2  V2.4S, V31.2D
    ORN  V18.8B, V30.8B, V18.8B
    SABAL  V16.4S, V8.4H, V2.4H
    FCVTZS V28.2D, V1.2D, #41
    SSUBL  V29.2D, V0.2S, V16.2S
    SUQADD  H19, H6
    SXTL V16.8H, V11.8B
    FCVTZS  S3, S11
    SQRSHRUN2 V31.16B, V10.8H, #1
    ZIP1  V14.2D, V16.2D, V1.2D
    CMGT  D14, D16, D15
    REV32  V7.4H, V18.4H
    SQSHLU H8, H6, #0x8
    USHLL V26.8H, V21.8B, #0x3
    SQRSHRN B14, H18, #4
    SQSHRUN S27, D3, #11
    SQSHL S2, S8, #0x1e
    SXTL V28.8H, V9.8B
    SSRA  V1.8H, V25.8H, #7
    USRA  V20.4S, V2.4S, #5
    SQABS  H9, H4
    SQADD  S26, S2, S14
    SQDMLAL D30, S23, V29.S[0x2]
    UMOV X2, V4.D[0x0]
    MOV V26.B[0xc], W7
    MLA  V13.4S, V4.4S, V18.S[0x1]
    FMAXV  S29, V2.4S
    SQDMLAL2 V25.2D, V25.4S, V17.S[0x1]
    UABD  V2.8B, V12.8B, V14.8B
    DUP  V28.8H, V27.H[0x6]
    MOVI  D14, #18374686483966590975
    UQRSHRN H24, S25, #15
    SQRSHL  S7, S1, S26
    SXTL2 V8.2D, V20.4S
    SQSUB  V0.4H, V30.4H, V9.4H
    TRN1  V28.8H, V5.8H, V3.8H
    SQNEG  V2.4H, V12.4H
    UQSUB  S10, S7, S31
    CMGE  D13, D9, D23
    SQRSHRN V20.4H, V27.4S, #15
    SQADD  S24, S30, S7
    SLI V29.2D, V24.2D, #0x17
    DUP  V18.4H, V0.H[0x3]
    SMLSL V27.4S, V21.4H, V9.H[0x0]
    FMLS V0.2S, V13.2S, V4.S[0x2]
    DUP V16.8B, W12
    CMLT  V15.8H, V28.8H, #0
    SQSUB  S31, S23, S29
    SQRSHRUN V11.2S, V14.2D, #24
    SQSUB  V14.2D, V30.2D, V6.2D
    MLS  V29.8H, V16.8H, V11.H[0x4]
    FCVTZU D13, D30, #51
    SQDMLAL2 V4.4S, V27.8H, V3.H[0x7]
    CMGT  D9, D25, #0
    SUB  V17.8B, V10.8B, V12.8B
    CMEQ  D1, D7, #0
    SSHLL2 V10.2D, V26.4S, #0xa
    PMULL  V29.8H, V19.8B, V10.8B
    UQRSHRN H6, S20, #8
    SQRSHL  S31, S23, S14
    UHSUB  V8.8H, V17.8H, V5.8H
    SQDMULL V23.4S, V31.4H, V15.H[0x7]
    SQNEG  B26, B21
    SHL V6.2D, V1.2D, #0xd
    FRECPS  S15, S30, S30
    UXTL2 V2.8H, V10.16B
    SQSHL  V25.4H, V2.4H, #0x0
    SMOV  X29, V11.H[0x6]
    SQABS  D13, D13
    FACGE  S28, S18, S23
    SQRSHRN S15, D8, #19
    USRA V24.2D, V19.2D, #27
    SMAXV  B15, V8.16B
    CMLT  V13.2S, V9.2S, #0
    XTN  V5.4H, V2.4S
    ORR  V11.8B, V9.8B, V4.8B
    SQABS  D28, D24
    SQDMULL V29.4S, V2.4H, V12.H[0x5]
    UCVTF V20.2D, V0.2D, #18
    SHL  V28.16B, V8.16B, #0x3
    UQXTN2  V8.16B, V14.8H
    ADD  V18.2S, V31.2S, V23.2S
    UQSHL V19.2D, V6.2D, #0x9
    UQSHL D25, D19, #0x2c
    SHL V25.2D, V21.2D, #0xa
    FABS  V10.2S, V31.2S
    UQSUB  V4.4H, V18.4H, V24.4H
    MVN  V20.8B, V24.8B
    CMEQ  V24.8H, V6.8H, #0
    CMLT  V29.4H, V15.4H, #0
    FRSQRTE  D19, D11
    MOV V2.D[0x0], X11
    FRINTX  V2.2S, V14.2S
    SQRDMULH  H23, H14, H8
    SSUBW  V0.8H, V9.8H, V10.8B
    DUP D15, V12.D[0x1]
    SLI D25, D19, #0x14
    SUQADD  H23, H28
    SLI  V17.16B, V26.16B, #0x0
    URSRA  V21.4H, V4.4H, #8
    FCMGE  V7.2D, V16.2D, V7.2D
    USRA  V23.2S, V30.2S, #22
    SADDLV  H4, V3.8B
    SRSHL  D26, D2, D6
    UZP1  V15.8B, V14.8B, V28.8B
    FRSQRTS  S14, S9, S22
    FCMLT  S15, S16, #0.0
    FCVTZS V1.2D, V5.2D, #19
    SRSHR D29, D14, #26
    FMULX D18, D11, V0.D[0x1]
    SXTL2 V5.8H, V23.16B
    URSHL  D30, D26, D17
    SHL  V25.4S, V25.4S, #0x1e
    ZIP2  V29.8B, V23.8B, V13.8B
    SQDMULL V9.2D, V5.2S, V10.S[0x1]
    SQDMULH H31, H21, V3.H[0x6]
    SQDMLSL D19, S24, V29.S[0x3]
    USHR  V1.8B, V27.8B, #2
    SQSHL  S10, S4, S9
    UABD  V12.16B, V29.16B, V4.16B
    FCVTMS  V2.2S, V30.2S
    SUBHN2  V29.16B, V17.8H, V19.8H
    SQDMULH  S2, S30, S8
    FRINTM  V15.4S, V31.4S
    SRSHL  V1.16B, V21.16B, V16.16B
    MVNI  V28.4S, #0x88, MSL #8
    SQRSHRN V24.4H, V20.4S, #4
    SHLL  V9.2D, V9.2S, #32
    SQDMLAL V13.2D, V11.2S, V9.S[0x0]
    UHADD  V12.4S, V24.4S, V1.4S
    UQSHL  B22, B1, B24
    MOVI  V29.4S, #0x23, LSL #16
    SHRN V19.4H, V4.4S, #2
    UMLAL V25.2D, V18.2S, V6.S[0x2]
    FCMGT  V5.4S, V7.4S, #0.0
    SMINV  S14, V26.4S
    UABA  V21.4S, V17.4S, V13.4S
    UQRSHRN B27, H19, #2
    SQRSHRN S20, D19, #20
    FMLS V10.2D, V1.2D, V19.D[0x0]
    USUBW  V7.2D, V30.2D, V29.2S
    UCVTF S6, S18, #20
    FRINTZ  V10.2D, V23.2D
    FRECPX  D29, D6
    SQDMLSL2 V31.4S, V9.8H, V15.H[0x6]
    SQDMLSL  D12, S25, S7
    ABS  V0.8B, V23.8B
    SMAXV  H3, V10.4H
    SQDMULL D28, S13, V4.S[0x2]
    SMLAL V11.4S, V21.4H, V5.H[0x3]
    FMULX  V30.2S, V12.2S, V5.2S
    MLA  V10.4S, V2.4S, V23.S[0x0]
    UQSHL D21, D11, #0x14
    URSRA  V19.4S, V15.4S, #4
    NOT  V6.16B, V19.16B
    FCMGT  V18.2S, V4.2S, V5.2S
    ADDV  H19, V6.4H
    DUP  V30.4H, V30.H[0x1]
    SQDMLSL2  V5.4S, V5.8H, V29.8H
    MOV V11.D[0x0], V11.D[0x0]
    UQSHL  H29, H1, H3
    SQRSHRUN B25, H19, #5
    UQRSHL  D11, D30, D20
    SSRA  V4.8H, V2.8H, #13
    SMAXV  B3, V1.8B
    CMGT  V3.8H, V27.8H, #0
    FRINTN  V9.4S, V1.4S
    SQRSHRUN2 V20.8H, V29.4S, #1
    SSHLL2 V17.8H, V27.16B, #0x5
    SMLAL2 V6.2D, V20.4S, V31.S[0x0]
    SMAXV  H11, V18.8H
    SSHR  V28.8H, V20.8H, #13
    USUBW2  V7.8H, V24.8H, V28.16B
    FCVTXN  S6, D6
    SSHLL V11.8H, V11.8B, #0x7
    SQXTUN  S27, D28
    SRHADD  V28.2S, V8.2S, V4.2S
    SLI  V6.8H, V9.8H, #0xb
    SQABS  B23, B12
    FMLA D15, D20, V15.D[0x0]
    UMLSL2 V16.2D, V0.4S, V15.S[0x2]
    SMINV  B10, V0.16B
    FACGT  D5, D11, D2
    FRECPE  S24, S25
    SADDL2  V3.8H, V27.16B, V4.16B
TaishanSimdReduceP01_label_776:
    CMGE  D24, D27, D29
    SADDW2  V28.4S, V3.4S, V1.8H
    UQSHL S16, S31, #0xd
    FMINP  V6.2S, V22.2S, V19.2S
    SQRDMULH  V30.4S, V7.4S, V10.S[0x0]
    FMINNMP S20, V3.2S
    RSHRN V6.8B, V13.8H, #2
    MOV B12, V26.B[0x5]
    FCVTAU  V23.4S, V13.4S
    MOV V23.S[0x0], V18.S[0x2]
    SQADD  H2, H19, H7
    UQRSHRN B9, H5, #3
    SUBS  X12, X12, #0x1
    B.NE  TaishanSimdReduceP01_label_891
    MOVZ  X6, #0x0, LSL #0
    SUB  X4, X6, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X23, X29, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X4
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X27, X29, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X28, X15, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X22, X10, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X10, X11, X9
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X17, X15, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X5, X17, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X29, X9, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X7, X23, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X28, X20, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X5, X26, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X6, X27, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X9, X26, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X11, X20, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X18, X16, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X9, X21, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X14, X7, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    FMOV  X22, V2.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X22, D2
    MOVZ  X5, #0xfffc, LSL #0
    SUB  X20, X5, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X5, V3.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X5, D3
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X11, X23, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X5, D4
    MOVZ  X23, #0x0, LSL #0
    SUB  X11, X23, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X9, X29, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X7, D5
    MOVZ  X29, #0x0, LSL #0
    SUB  X9, X29, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X27, D6
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X20, D7
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X29, X12, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X6, D8
    MOVZ  X12, #0x0, LSL #0
    SUB  X29, X12, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X5, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X5, D9
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X4, D10
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X21, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X21, D11
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X11, D12
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X7, D13
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X16, D14
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X10, D15
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X15, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X4, X20, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X29, D17
    MOVZ  X20, #0x0, LSL #0
    SUB  X4, X20, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X22, D18
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X13, D19
    MOVZ  X2, #0xfffc, LSL #0
    SUB  X3, X2, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X28, D20
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X22, V21.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X22, D21
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X16, D22
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X22, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X22, D23
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X26, X19, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    FMOV  X23, D25
    MOVZ  X19, #0x0, LSL #0
    SUB  X26, X19, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X2
TaishanSimdReduceP01_label_475:
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X2, D26
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X4, D27
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X21, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X21, D28
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X27
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X27, D29
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X27
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    MOVZ  X2, #0x8cb2, LSL #0
    MOVK  X2, #0xf0b3, LSL #16
    MOVK  X2, #0x901f, LSL #32
    MOVK  X2, #0x154, LSL #48
    MOVZ  X3, #0x38ce, LSL #0
    MOVK  X3, #0xfc9c, LSL #16
    MOVK  X3, #0x5b47, LSL #32
    MOVK  X3, #0xf894, LSL #48
    MOVZ  X4, #0x7711, LSL #0
    MOVK  X4, #0xe5aa, LSL #16
    MOVK  X4, #0x8675, LSL #32
    MOVK  X4, #0xf36d, LSL #48
    MOVZ  X5, #0xbba7, LSL #0
    MOVK  X5, #0x630a, LSL #16
    MOVK  X5, #0x5a45, LSL #32
    MOVK  X5, #0x5ba2, LSL #48
    MOVZ  X6, #0xfa7d, LSL #0
    MOVK  X6, #0xf1c2, LSL #16
    MOVK  X6, #0xbd5d, LSL #32
    MOVK  X6, #0x73c, LSL #48
    MOVZ  X7, #0x695d, LSL #0
    MOVK  X7, #0x94df, LSL #16
    MOVK  X7, #0x21e8, LSL #32
    MOVK  X7, #0xde52, LSL #48
    MOVZ  X8, #0x58b2, LSL #0
    MOVK  X8, #0xd845, LSL #16
    MOVK  X8, #0x3bbc, LSL #32
    MOVK  X8, #0x3ed3, LSL #48
    MOVZ  X9, #0x33fa, LSL #0
    MOVK  X9, #0xac4a, LSL #16
    MOVK  X9, #0x73cd, LSL #32
    MOVK  X9, #0x848e, LSL #48
    MOVZ  X10, #0xbc28, LSL #0
    MOVK  X10, #0xa894, LSL #16
    MOVK  X10, #0x629c, LSL #32
    MOVK  X10, #0xf345, LSL #48
    MOVZ  X11, #0x339a, LSL #0
    MOVK  X11, #0xb963, LSL #16
    MOVK  X11, #0x1897, LSL #32
    MOVK  X11, #0xd4fa, LSL #48
    MOVZ  X12, #0xeb58, LSL #0
    MOVK  X12, #0x664, LSL #16
    MOVK  X12, #0xcff4, LSL #32
    MOVK  X12, #0xfce2, LSL #48
    MOVZ  X13, #0x53f, LSL #0
    MOVK  X13, #0x47a0, LSL #16
    MOVK  X13, #0x5e78, LSL #32
    MOVK  X13, #0xb00f, LSL #48
    MOVZ  X14, #0x749, LSL #0
    MOVK  X14, #0x1378, LSL #16
    MOVK  X14, #0xa40a, LSL #32
    MOVK  X14, #0x62ba, LSL #48
    MOVZ  X15, #0xab28, LSL #0
    MOVK  X15, #0x6538, LSL #16
    MOVK  X15, #0x74c, LSL #32
    MOVK  X15, #0xa38e, LSL #48
    MOVZ  X16, #0x2b9a, LSL #0
    MOVK  X16, #0xaf0a, LSL #16
    MOVK  X16, #0x6c50, LSL #32
    MOVK  X16, #0xc4ca, LSL #48
    MOVZ  X17, #0x4340, LSL #0
    MOVK  X17, #0x93cf, LSL #16
    MOVK  X17, #0xb7e1, LSL #32
    MOVK  X17, #0xd79, LSL #48
    MOVZ  X18, #0x658d, LSL #0
    MOVK  X18, #0x2904, LSL #16
    MOVK  X18, #0xd5ad, LSL #32
    MOVK  X18, #0x2f4f, LSL #48
    MOVZ  X19, #0xb3cb, LSL #0
    MOVK  X19, #0x73ab, LSL #16
    MOVK  X19, #0x8465, LSL #32
    MOVK  X19, #0x2cd7, LSL #48
    MOVZ  X20, #0x8b8a, LSL #0
    MOVK  X20, #0x129e, LSL #16
    MOVK  X20, #0x72d7, LSL #32
    MOVK  X20, #0x2b, LSL #48
    MOVZ  X21, #0xb453, LSL #0
    MOVK  X21, #0x27b3, LSL #16
    MOVK  X21, #0xebaf, LSL #32
    MOVK  X21, #0x5305, LSL #48
    MOVZ  X22, #0xfdc2, LSL #0
    MOVK  X22, #0x16c8, LSL #16
    MOVK  X22, #0xcad6, LSL #32
    MOVK  X22, #0x7b4e, LSL #48
    MOVZ  X23, #0x622a, LSL #0
    MOVK  X23, #0x216a, LSL #16
    MOVK  X23, #0x4c05, LSL #32
    MOVK  X23, #0x7bff, LSL #48
    MOVZ  X25, #0x8dac, LSL #0
    MOVK  X25, #0x4ceb, LSL #16
    MOVK  X25, #0x1771, LSL #32
    MOVK  X25, #0x942f, LSL #48
    MOVZ  X26, #0xffe3, LSL #0
    MOVK  X26, #0x9c3b, LSL #16
    MOVK  X26, #0xecc0, LSL #32
    MOVK  X26, #0x8b6c, LSL #48
    MOVZ  X27, #0x33db, LSL #0
    MOVK  X27, #0x2e37, LSL #16
    MOVK  X27, #0xee1e, LSL #32
    MOVK  X27, #0xa504, LSL #48
    MOVZ  X28, #0x47c2, LSL #0
    MOVK  X28, #0x1966, LSL #16
    MOVK  X28, #0x5b60, LSL #32
    MOVK  X28, #0x279e, LSL #48
    MOVZ  X29, #0x1f1e, LSL #0
    MOVK  X29, #0x39bf, LSL #16
    MOVK  X29, #0x3d0b, LSL #32
    MOVK  X29, #0xae8a, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X2
    FMOV  D1, X28
    FMOV  V1.D[1], X20
    FMOV  D2, X22
    FMOV  V2.D[1], X7
    FMOV  D3, X6
    FMOV  V3.D[1], X26
    FMOV  D4, X15
    FMOV  V4.D[1], X22
    FMOV  D5, X10
    FMOV  V5.D[1], X6
    FMOV  D6, X21
    FMOV  V6.D[1], X7
    FMOV  D7, X18
    FMOV  V7.D[1], X26
    FMOV  D8, X27
    FMOV  V8.D[1], X2
    FMOV  D9, X20
    FMOV  V9.D[1], X9
    FMOV  D10, X22
    FMOV  V10.D[1], X4
    FMOV  D11, X11
    FMOV  V11.D[1], X18
    FMOV  D12, X12
    FMOV  V12.D[1], X11
    FMOV  D13, X9
    FMOV  V13.D[1], X25
    FMOV  D14, X11
    FMOV  V14.D[1], X13
    FMOV  D15, X13
    FMOV  V15.D[1], X7
    FMOV  D16, X23
    FMOV  V16.D[1], X2
    FMOV  D17, X20
    FMOV  V17.D[1], X6
    FMOV  D18, X17
    FMOV  V18.D[1], X11
    FMOV  D19, X7
    FMOV  V19.D[1], X17
    FMOV  D20, X16
    FMOV  V20.D[1], X28
    FMOV  D21, X12
    FMOV  V21.D[1], X14
    FMOV  D22, X11
    FMOV  V22.D[1], X2
    FMOV  D23, X25
    FMOV  V23.D[1], X29
    FMOV  D24, X20
    FMOV  V24.D[1], X27
    FMOV  D25, X14
    FMOV  V25.D[1], X20
    FMOV  D26, X23
    FMOV  V26.D[1], X25
    FMOV  D27, X11
    FMOV  V27.D[1], X16
    FMOV  D28, X5
    FMOV  V28.D[1], X25
    FMOV  D29, X8
    FMOV  V29.D[1], X10
    FMOV  D30, X13
    FMOV  V30.D[1], X25
    FMOV  D31, X3
    FMOV  V31.D[1], X13
    MOVZ  X3, #0xa, LSL #0
TaishanSimdReduceP01_label_971:
    FNEG  V20.4S, V28.4S
    SQDMLAL2 V31.4S, V11.8H, V0.H[0x5]
    UMLSL  V19.8H, V2.8B, V20.8B
    SLI V13.2D, V10.2D, #0x3f
    UMINV  B21, V24.16B
    UMULL V29.4S, V26.4H, V4.H[0x7]
    UMULL  V31.2D, V24.2S, V27.2S
    UQSUB  H24, H12, H5
    SSUBW2  V9.8H, V8.8H, V4.16B
    SRSHR  V1.4H, V20.4H, #3
    SQSHL D28, D12, #0x3d
    INS V26.H[0x7], V29.H[0x3]
    USHR  V14.16B, V28.16B, #5
    FCMGT  S4, S5, #0.0
    SMULL  V18.8H, V19.8B, V23.8B
    FACGE  S19, S9, S17
    CLS  V8.8B, V17.8B
    SQDMLAL V20.2D, V11.2S, V21.S[0x1]
    UMOV W13, V22.H[0x0]
    UCVTF V5.2D, V25.2D, #20
    SMOV  X28, V10.B[0x5]
    SMULL  V5.8H, V31.8B, V17.8B
    SXTL2 V18.4S, V2.8H
    SXTL V0.2D, V8.2S
    USHLL V28.8H, V15.8B, #0x5
    SQSHRN2 V11.8H, V11.4S, #12
    URSHL  V18.8H, V24.8H, V10.8H
    FRECPS  D22, D14, D17
    SLI V10.2D, V11.2D, #0x8
    MLS  V14.4S, V30.4S, V14.S[0x1]
    UCVTF S27, S18, #14
    URSHL  V31.16B, V13.16B, V21.16B
    FCMGE  V22.2S, V6.2S, V22.2S
    CMEQ  V15.8H, V26.8H, #0
    FMULX  D15, D2, D31
    MUL  V7.4H, V15.4H, V0.H[0x6]
    FCMEQ  D4, D8, D6
    FMLS D24, D5, V9.D[0x0]
    SADDW  V24.2D, V22.2D, V27.2S
    FMULX V19.4S, V25.4S, V15.S[0x2]
    MOVI  D7, #18446463698227756800
    UQADD  D1, D9, D2
    USRA  V0.4H, V20.4H, #8
    SQSHL  V17.16B, V0.16B, #0x0
    FABS  V0.2S, V13.2S
    SQDMLAL2 V30.4S, V22.8H, V6.H[0x2]
    UQRSHL  B30, B6, B25
    SRSHR  V17.4S, V30.4S, #23
    ADDHN2  V3.4S, V14.2D, V5.2D
    SMLAL2 V16.2D, V23.4S, V16.S[0x3]
    UQXTN  H14, S14
    FACGE  S29, S16, S10
    SQDMULH S19, S23, V10.S[0x0]
    SABAL2  V18.4S, V14.8H, V25.8H
    SMLAL V21.4S, V24.4H, V10.H[0x3]
    SQSHRUN2 V21.4S, V29.2D, #20
    FDIV  V19.4S, V0.4S, V25.4S
    ADDP  D5, V17.2D
    URECPE  V5.4S, V11.4S
    SMLAL  V15.4S, V16.4H, V12.4H
    SADDLV  S11, V15.8H
    SQDMULL V0.4S, V3.4H, V2.H[0x0]
    UQRSHRN2 V30.8H, V17.4S, #4
    SQSHRN2 V29.16B, V6.8H, #2
    SADDLV  H22, V24.8B
    FMAXP  V25.2S, V0.2S, V19.2S
    SADDL  V16.4S, V2.4H, V25.4H
    FMINP  V8.4S, V9.4S, V6.4S
    FRINTI  V8.2S, V13.2S
    SMLAL2 V15.4S, V31.8H, V13.H[0x7]
    FMULX  D12, D1, D11
    URSRA  V10.16B, V9.16B, #8
    SQRSHL  S13, S22, S12
    UXTL2 V21.2D, V29.4S
    SQSHL S10, S16, #0x9
    SHADD  V13.8H, V31.8H, V19.8H
    SUQADD  S18, S8
    SRSHR D21, D22, #59
    SMOV W19, V21.B[0x7]
    SQRSHL  V13.8H, V2.8H, V31.8H
    SQXTUN  H10, S5
    UQSHRN V15.2S, V6.2D, #32
    UMLSL2 V16.2D, V30.4S, V18.S[0x1]
    FACGE  D22, D16, D21
    SQDMULL2 V7.2D, V19.4S, V26.S[0x1]
    UMINP  V13.2S, V10.2S, V17.2S
    SQABS  V15.8B, V30.8B
    SQDMULL  V26.4S, V3.4H, V4.4H
    SQSHRN V30.4H, V11.4S, #14
    UABDL  V26.4S, V6.4H, V12.4H
    SQNEG  V13.8B, V13.8B
    SQRSHRN H1, S5, #6
    FMUL  V26.2D, V2.2D, V1.2D
    FMLS S5, S21, V2.S[0x2]
    UQRSHRN2 V31.16B, V23.8H, #5
    UQSHL  S11, S13, S30
    URSRA  V31.2S, V30.2S, #16
    SMIN  V18.2S, V3.2S, V22.2S
    FCMLE  D22, D2, #0.0
    UCVTF  S9, S18
    RSUBHN  V9.2S, V18.2D, V26.2D
    CMLE  V18.16B, V15.16B, #0
    SQDMLAL D19, S11, V7.S[0x2]
    FCMEQ  S17, S15, S5
    UQSHRN V9.2S, V26.2D, #4
    ABS  D15, D2
    UMLSL2 V25.2D, V10.4S, V28.S[0x2]
    PMULL2  V29.8H, V4.16B, V30.16B
    FABS  V29.2S, V15.2S
    SQSUB  B18, B15, B29
    UQRSHL  S17, S21, S2
    UMULL2 V26.2D, V13.4S, V1.S[0x1]
    DUP B19, V0.B[0x8]
    DUP S5, V10.S[0x3]
    SQRSHRUN V5.4H, V15.4S, #8
    SQRSHL  D13, D21, D15
    FCVTZU  S3, S7
    FRINTZ  V2.2S, V31.2S
    FRECPS  V28.2D, V19.2D, V26.2D
    SQRDMULH  S26, S6, S6
    UQADD  V6.2S, V15.2S, V4.2S
    SQDMLAL D19, S28, V18.S[0x1]
    SQSHRN V26.2S, V22.2D, #6
    UXTL V5.4S, V2.4H
    BIF  V25.16B, V21.16B, V28.16B
    SLI  V26.8H, V17.8H, #0x8
    SQRSHRN H16, S21, #5
    SQXTUN2  V26.4S, V18.2D
    EXT  V13.8B, V15.8B, V30.8B, #0x3
    FCVTMS  D0, D27
TaishanSimdReduceP01_label_318:
    FCMGT  V9.2D, V13.2D, #0.0
    SQSHRN V16.2S, V31.2D, #20
    NEG  D2, D24
    SMLAL2  V11.8H, V6.16B, V31.16B
    FCVTXN  S7, D29
    UQXTN  V29.2S, V11.2D
    UADALP  V29.4S, V30.8H
    UMLAL2 V12.2D, V6.4S, V25.S[0x1]
    SQSUB  H21, H16, H14
    FCMGE  V7.2S, V5.2S, V18.2S
    SSHL  V11.2S, V14.2S, V12.2S
    UQSHRN S18, D11, #8
    FCMGE  V7.4S, V11.4S, #0.0
    BIT  V31.8B, V16.8B, V31.8B
    SMAX  V31.8B, V5.8B, V28.8B
    USHR V13.2D, V27.2D, #64
    FMOV  V15.2S, #-3.87500000
    SQSHRN2 V7.4S, V15.2D, #16
    SQXTN2  V4.16B, V30.8H
    FCMLE  D16, D17, #0.0
    UQSHL  V24.16B, V11.16B, V0.16B
    UXTL2 V5.2D, V19.4S
    SMAXV  H30, V22.8H
    SQSHRUN H18, S19, #11
    UCVTF D7, D25, #15
    UQXTN  H14, S25
    SMLAL2 V11.2D, V10.4S, V21.S[0x3]
    FCVTZS D4, D22, #45
    FCVTPU  D23, D24
    USUBL2  V0.4S, V2.8H, V24.8H
    FABD  V12.4S, V29.4S, V28.4S
    UZP1  V21.8H, V28.8H, V24.8H
    BIC  V25.4H, #0x81, LSL #8
    FCVTMS  D15, D12
    SQDMULL  V2.4S, V31.4H, V26.4H
    UQRSHRN V29.4H, V21.4S, #12
    URSRA V0.2D, V21.2D, #11
    ORR  V4.4H, #0xb6, LSL #8
    FCVTXN2  V15.4S, V14.2D
    RSHRN2 V29.16B, V24.8H, #8
    FCVTZU D5, D21, #15
    FCMLT  S15, S5, #0.0
    SQDMULH H2, H29, V1.H[0x7]
    UXTL2 V2.4S, V2.8H
    FCMLE  V20.2D, V0.2D, #0.0
    SQDMLSL  V12.4S, V18.4H, V24.4H
    SQXTUN2  V18.8H, V5.4S
    SSUBW  V17.8H, V6.8H, V4.8B
    SSUBL  V22.2D, V10.2S, V16.2S
    DUP V21.16B, W16
    UQSHL V18.2D, V24.2D, #0x26
    FCMGT  V1.2S, V29.2S, #0.0
    FRECPS  D26, D31, D0
    SQDMLSL S16, H23, V5.H[0x6]
    SRI D29, D12, #29
    CMGE  V8.2S, V21.2S, #0
    TBL  V11.8B, { V5.16B, V6.16B, V7.16B, V8.16B }, V1.8B
    CNT  V19.16B, V22.16B
    ADDV  B28, V16.8B
    REV32  V24.16B, V29.16B
    SMOV W9, V14.B[0x9]
    FCMGE  S15, S28, S6
    UMLSL2  V2.4S, V5.8H, V3.8H
    SADDL2  V21.4S, V24.8H, V22.8H
    USHR  V4.2S, V11.2S, #25
    SQRDMULH  S28, S19, S21
    FMUL  V17.4S, V18.4S, V30.4S
    USQADD  B9, B4
    SQRSHRN2 V24.16B, V14.8H, #6
    CMHI  V6.16B, V14.16B, V9.16B
    SUBS  X3, X3, #0x1
    B.NE  TaishanSimdReduceP01_label_971
    MOVZ  X12, #0x8cb2, LSL #0
    MOVK  X12, #0xf0b3, LSL #16
    MOVK  X12, #0x901f, LSL #32
    MOVK  X12, #0x154, LSL #48
    SUB  X27, X12, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X19, X14, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    MOVZ  X2, #0x7711, LSL #0
    MOVK  X2, #0xe5aa, LSL #16
    MOVK  X2, #0x8675, LSL #32
    MOVK  X2, #0xf36d, LSL #48
    SUB  X18, X2, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    MOVZ  X18, #0xbba7, LSL #0
    MOVK  X18, #0x630a, LSL #16
    MOVK  X18, #0x5a45, LSL #32
    MOVK  X18, #0x5ba2, LSL #48
    SUB  X2, X18, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    MOVZ  X5, #0xfa7d, LSL #0
    MOVK  X5, #0xf1c2, LSL #16
    MOVK  X5, #0xbd5d, LSL #32
    MOVK  X5, #0x73c, LSL #48
    SUB  X13, X5, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    MOVZ  X12, #0x695d, LSL #0
    MOVK  X12, #0x94df, LSL #16
    MOVK  X12, #0x21e8, LSL #32
    MOVK  X12, #0xde52, LSL #48
    SUB  X27, X12, X7
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    MOVZ  X16, #0x58b2, LSL #0
    MOVK  X16, #0xd845, LSL #16
    MOVK  X16, #0x3bbc, LSL #32
    MOVK  X16, #0x3ed3, LSL #48
    SUB  X10, X16, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    MOVZ  X6, #0x339a, LSL #0
    MOVK  X6, #0xb963, LSL #16
    MOVK  X6, #0x1897, LSL #32
    MOVK  X6, #0xd4fa, LSL #48
    SUB  X26, X6, X11
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    MOVZ  X9, #0x695d, LSL #0
    MOVK  X9, #0x94df, LSL #16
    MOVK  X9, #0x21e8, LSL #32
    MOVK  X9, #0xde52, LSL #48
    SUB  X3, X9, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    MOVZ  X19, #0xab28, LSL #0
    MOVK  X19, #0x6538, LSL #16
    MOVK  X19, #0x74c, LSL #32
    MOVK  X19, #0xa38e, LSL #48
    SUB  X16, X19, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0x4340, LSL #0
    MOVK  X7, #0x93cf, LSL #16
    MOVK  X7, #0xb7e1, LSL #32
    MOVK  X7, #0xd79, LSL #48
    SUB  X23, X7, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    MOVZ  X13, #0xbba7, LSL #0
    MOVK  X13, #0x630a, LSL #16
    MOVK  X13, #0x5a45, LSL #32
    MOVK  X13, #0x5ba2, LSL #48
    SUB  X9, X13, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    MOVZ  X16, #0xab28, LSL #0
    MOVK  X16, #0x6538, LSL #16
    MOVK  X16, #0x74c, LSL #32
    MOVK  X16, #0xa38e, LSL #48
    SUB  X20, X16, X19
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X20
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    MOVZ  X27, #0xfdc2, LSL #0
    MOVK  X27, #0x16c8, LSL #16
    MOVK  X27, #0xcad6, LSL #32
    MOVK  X27, #0x7b4e, LSL #48
    SUB  X25, X27, X22
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    MOVZ  X11, #0xfdc2, LSL #0
    MOVK  X11, #0x16c8, LSL #16
    MOVK  X11, #0xcad6, LSL #32
    MOVK  X11, #0x7b4e, LSL #48
    SUB  X20, X11, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    MOVZ  X14, #0x1f1e, LSL #0
    MOVK  X14, #0x39bf, LSL #16
    MOVK  X14, #0x3d0b, LSL #32
    MOVK  X14, #0xae8a, LSL #48
    SUB  X17, X14, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X22, V2.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X10, X28, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X22, D2
    MOVZ  X28, #0x0, LSL #0
    SUB  X10, X28, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X12, D3
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X22, V4.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X22, D4
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X7, D5
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X19, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X19, D6
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X2, D7
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x42e0, LSL #48
    SUB  X29, X9, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X22, V8.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X22, D8
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X11, D9
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X17, D10
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X5, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X5, D11
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x4000, LSL #48
    SUB  X6, X8, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X7, D12
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x4000, LSL #48
    SUB  X6, X8, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X27, V13.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X27, D13
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    FMOV  X2, D14
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X12, D15
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X6, X3, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X23, D16
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X7, X14, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X2, D17
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X28, D18
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xffc0, LSL #32
    MOVK  X21, #0x3f, LSL #48
    SUB  X15, X21, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X15, V19.D[1]
    MOVZ  X17, #0x1, LSL #0
    SUB  X12, X17, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    FMOV  X15, D19
    MOVZ  X17, #0x1, LSL #0
    SUB  X12, X17, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X7, X6, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X8, D20
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X7, X6, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X14, X11, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X13, D21
    MOVZ  X11, #0x1, LSL #0
    SUB  X14, X11, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X5, #0x1, LSL #0
    SUB  X3, X5, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X17, D22
    MOVZ  X5, #0x1, LSL #0
    SUB  X3, X5, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X26, D23
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X6, V25.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    FMOV  X6, D25
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x4000, LSL #48
    SUB  X12, X16, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X2, D26
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x4000, LSL #48
    SUB  X23, X3, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
TaishanSimdReduceP01_label_871:
    FMOV  X16, V27.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X16, D27
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X4, D28
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X16, D29
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x12, LSL #32
    SUB  X7, X15, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X21
    FMOV  V0.D[1], X25
    FMOV  D1, X22
    FMOV  V1.D[1], X23
    FMOV  D2, X13
    FMOV  V2.D[1], X5
    FMOV  D3, X15
    FMOV  V3.D[1], X19
    FMOV  D4, X28
    FMOV  V4.D[1], X29
    FMOV  D5, X13
    FMOV  V5.D[1], X22
    FMOV  D6, X27
    FMOV  V6.D[1], X17
    FMOV  D7, X26
    FMOV  V7.D[1], X19
    FMOV  D8, X27
    FMOV  V8.D[1], X15
    FMOV  D9, X22
    FMOV  V9.D[1], X20
    FMOV  D10, X7
    FMOV  V10.D[1], X23
    FMOV  D11, X4
    FMOV  V11.D[1], X23
    FMOV  D12, X8
    FMOV  V12.D[1], X7
    FMOV  D13, X12
    FMOV  V13.D[1], X7
    FMOV  D14, X9
    FMOV  V14.D[1], X29
    FMOV  D15, X20
    FMOV  V15.D[1], X6
    FMOV  D16, X6
    FMOV  V16.D[1], X23
    FMOV  D17, X3
    FMOV  V17.D[1], X13
    FMOV  D18, X13
    FMOV  V18.D[1], X9
    FMOV  D19, X3
    FMOV  V19.D[1], X7
    FMOV  D20, X23
    FMOV  V20.D[1], X6
    FMOV  D21, X20
    FMOV  V21.D[1], X27
    FMOV  D22, X29
    FMOV  V22.D[1], X29
    FMOV  D23, X25
    FMOV  V23.D[1], X25
    FMOV  D24, X4
    FMOV  V24.D[1], X3
    FMOV  D25, X17
    FMOV  V25.D[1], X19
    FMOV  D26, X18
    FMOV  V26.D[1], X27
    FMOV  D27, X2
    FMOV  V27.D[1], X12
    FMOV  D28, X21
    FMOV  V28.D[1], X6
    FMOV  D29, X29
    FMOV  V29.D[1], X21
    FMOV  D30, X21
    FMOV  V30.D[1], X20
    FMOV  D31, X26
    FMOV  V31.D[1], X7
    MOVZ  X18, #0xa, LSL #0
TaishanSimdReduceP01_label_1048:
    SXTL V1.4S, V22.4H
    SQRSHL  H15, H10, H13
    DUP V18.2D, V29.D[0x0]
    SQDMLSL2 V31.4S, V27.8H, V7.H[0x1]
    SSUBL  V0.4S, V28.4H, V23.4H
    DUP D3, V2.D[0x1]
    INS V11.B[0xd], W19
    SQSHL  V3.16B, V30.16B, #0x6
    MLS  V13.2S, V12.2S, V14.S[0x3]
    SRSRA  V2.16B, V9.16B, #1
    MVN  V24.16B, V9.16B
    INS V26.H[0x6], V14.H[0x1]
    UADDW  V28.8H, V24.8H, V2.8B
    ORN  V17.16B, V12.16B, V7.16B
    ORR  V0.8B, V17.8B, V14.8B
    UQRSHRN V19.2S, V27.2D, #17
    SQSHL B2, B5, #0x7
    USHLL2 V14.8H, V5.16B, #0x1
    URSRA  V7.4H, V11.4H, #14
    SRI  V13.8H, V7.8H, #15
    UMOV W23, V22.S[0x3]
    URHADD  V3.8B, V14.8B, V26.8B
    DUP H17, V9.H[0x3]
    UQSHRN V28.4H, V4.4S, #12
    SRSHL  D0, D9, D0
    FACGE  V4.2S, V2.2S, V2.2S
    SUQADD  B23, B22
    SRSRA  V10.4H, V9.4H, #3
    UMOV W19, V19.H[0x3]
    UMINV  H24, V17.4H
    SQRSHRN V28.4H, V1.4S, #2
    SSHLL V11.8H, V10.8B, #0x2
    UMOV W16, V9.B[0xb]
    SADDW  V5.8H, V23.8H, V8.8B
    FMAX  V30.2D, V22.2D, V13.2D
    UQADD  V24.16B, V30.16B, V4.16B
    FCVTZU S26, S18, #6
    FRECPS  S14, S29, S0
    UMULL  V31.8H, V26.8B, V6.8B
    FCVTZS V30.2D, V24.2D, #19
    SQSHLU B19, B30, #0x1
    ADD  V4.8H, V24.8H, V6.8H
    SQSHL  V19.8H, V11.8H, #0x4
    TBL  V14.16B, { V5.16B, V6.16B, V7.16B }, V23.16B
    UMOV X8, V14.D[0x0]
    REV64  V4.4S, V3.4S
    SADDL  V26.8H, V19.8B, V19.8B
    SMOV  X13, V17.S[0x2]
    SQSUB  H12, H1, H2
    SMLSL V4.4S, V1.4H, V13.H[0x3]
    UXTL2 V27.4S, V14.8H
    UQSHL S7, S13, #0x6
    SXTL V18.8H, V7.8B
    SLI  V1.2S, V31.2S, #0x1b
    ORR  V27.2S, #0xab
    SQRDMULH S4, S27, V12.S[0x3]
    UQSUB  H8, H30, H1
    UQSHRN V3.4H, V8.4S, #5
    SQDMLAL  D19, S26, S20
    CMLE  V24.8B, V30.8B, #0
    SQSHL  H0, H19, H10
    SXTL2 V27.4S, V11.8H
    SRSHR  V28.8H, V22.8H, #13
    UADDW2  V2.2D, V28.2D, V1.4S
    CMHI  D22, D17, D4
    SQXTN  H7, S8
    CMTST  V22.16B, V15.16B, V7.16B
    SSRA V18.2D, V26.2D, #23
    MVNI  V8.8H, #0x38, LSL #8
    USHR  V3.16B, V7.16B, #2
    UQRSHRN H18, S10, #14
    SMLSL  V10.4S, V7.4H, V12.4H
    FMULX  D22, D25, D30
    SMINV  H16, V24.8H
    FMAXV  S5, V12.4S
    FMINNM  V10.4S, V12.4S, V2.4S
    FCMLT  V1.2S, V24.2S, #0.0
    SHL D24, D29, #0x5
    SQRSHRN2 V29.8H, V19.4S, #10
    ZIP1  V10.2D, V3.2D, V26.2D
    CMHS  D8, D25, D11
    SQXTUN  H11, S24
    SQDMULH  S8, S31, S10
    UMINV  H13, V13.8H
    USUBL2  V3.4S, V24.8H, V13.8H
    SQRSHRUN2 V18.8H, V1.4S, #9
    FCMEQ  D5, D24, #0.0
    CMEQ  V5.2D, V16.2D, #0
    FMOV  V23.2D, #3.62500000
    MOV V20.D[0x1], V28.D[0x1]
    SQABS  D18, D22
    MOVI  D2, #18374686483949879295
    SMULL2 V13.4S, V5.8H, V14.H[0x2]
    FMINNMV  S11, V23.4S
    FMINP S2, V25.2S
    UQSHL  V29.8B, V16.8B, #0x2
    SQSHRN V13.2S, V8.2D, #12
    FCMGT  V23.2S, V17.2S, V13.2S
    PMULL  V23.1Q, V25.1D, V18.1D
    SQRSHL  S22, S0, S4
    FMULX V5.2D, V11.2D, V2.D[0x0]
    UQRSHRN2 V29.16B, V25.8H, #8
    URSHR V7.2D, V16.2D, #16
    FCMGE  S31, S3, S20
    SMOV  X21, V24.B[0xb]
    MOV V13.B[0x3], V31.B[0x5]
    FCMGT  D29, D23, #0.0
    SUQADD  B25, B3
    SQRSHRN2 V12.8H, V17.4S, #16
    USHLL V28.2D, V6.2S, #0x5
    UADDLV  H5, V2.8B
    DUP H23, V10.H[0x7]
    SQSUB  D21, D12, D30
    FMINP  V22.2D, V10.2D, V20.2D
    FCMLE  D29, D2, #0.0
    SQSUB  H11, H7, H22
    SQDMLSL2 V26.2D, V4.4S, V16.S[0x2]
    UXTL V16.2D, V17.2S
    SADDLP  V25.8H, V6.16B
    SQRSHRUN B29, H3, #3
    SABAL2  V17.4S, V26.8H, V25.8H
    SMLSL2 V29.4S, V20.8H, V13.H[0x1]
    SQDMULH  H9, H29, H7
    MOV B0, V29.B[0xe]
    INS V12.S[0x1], W12
    SQXTN  H6, S25
    SQSHRUN2 V9.8H, V12.4S, #7
    REV32  V29.4H, V20.4H
    UQXTN2  V28.16B, V13.8H
    SQRSHRN S2, D22, #30
    DUP D27, V1.D[0x1]
    SQRSHRN V7.2S, V22.2D, #28
    SMULL2 V25.4S, V3.8H, V2.H[0x0]
    SQDMLSL  V18.4S, V0.4H, V26.4H
    FCVTZS  S17, S17
    USRA  V23.2S, V6.2S, #7
    SQRDMULH H11, H22, V5.H[0x4]
    UABAL2  V12.4S, V23.8H, V18.8H
    FRINTN  V10.2S, V0.2S
    RSHRN2 V28.4S, V13.2D, #29
    UQRSHL  B28, B18, B19
    FCVTZU  V29.2S, V27.2S, #16
    UMAXV  B5, V1.16B
    FRINTZ  V2.2D, V5.2D
    SQSHL S12, S5, #0xd
    FABD  S16, S26, S5
    FMAX  V5.2D, V27.2D, V28.2D
    SUQADD  H28, H15
    SQRSHRUN2 V2.16B, V10.8H, #5
    SRSHR V15.2D, V13.2D, #64
    FACGE  D2, D9, D9
    SQXTN2  V30.16B, V27.8H
    URSRA  V10.4H, V22.4H, #5
    MOV  V23.8B, V21.8B
    MOV V21.S[0x0], V15.S[0x1]
    USHL  D2, D26, D19
    SQRSHRUN B12, H20, #3
    SQRSHRUN V27.2S, V13.2D, #29
    INS V13.D[0x0], X15
    FCVTMU  D1, D5
    MOV B1, V18.B[0x3]
    UQRSHL  B20, B21, B2
    SQDMLAL2 V10.4S, V1.8H, V14.H[0x5]
    MOVI  V7.2D, #18374686483966590720
    FRSQRTE  S28, S16
    BSL  V27.16B, V26.16B, V7.16B
    SQDMLAL S16, H5, V1.H[0x7]
    INS V27.H[0x5], W17
    EOR  V22.8B, V9.8B, V16.8B
    SQSHRUN V29.2S, V19.2D, #16
    FRINTI  V30.2S, V29.2S
    FMULX  S7, S28, S23
    FCVTMU  S18, S29
    SQSHRUN2 V27.16B, V26.8H, #4
    SQXTN2  V9.4S, V6.2D
    FMAXP D9, V19.2D
    SSHR  V17.4S, V9.4S, #18
    UMLAL V22.2D, V17.2S, V15.S[0x2]
    FCVTPU  V5.2S, V1.2S
    FMLA S13, S14, V10.S[0x2]
    UQSHRN V12.8B, V19.8H, #5
    MOV V24.D[0x1], X19
    FRSQRTE  S19, S13
    FMAXNM  V31.4S, V13.4S, V30.4S
    SMLAL V31.2D, V7.2S, V1.S[0x0]
    SCVTF S18, S17, #3
    UQRSHL  H19, H12, H28
    SQDMLAL V13.4S, V14.4H, V2.H[0x1]
    FCVTAU  S24, S22
    FCVTAU  V24.2S, V14.2S
    SQRDMULH  V24.4H, V18.4H, V15.H[0x6]
    SCVTF S15, S9, #29
    UQSHL D16, D3, #0x2b
    FCMGT  S18, S8, S0
    CMHI  V11.4H, V4.4H, V23.4H
    CMHS  D25, D5, D9
    SQXTUN  H0, S10
    FCVTZS D2, D27, #19
    FCVTAS  V25.4S, V6.4S
    ADDHN  V1.8B, V30.8H, V29.8H
    SUBS  X18, X18, #0x1
    B.NE  TaishanSimdReduceP01_label_1048
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X20, X17, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X6, X29, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X10
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X11
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X20, X22, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X4, X20, X15
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X19
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X6, D2
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x8000, LSL #48
    SUB  X14, X21, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X28, D3
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X10, D4
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X25, V5.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X25, D5
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X15, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X15, D6
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X14, D7
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x4000, LSL #16
    SUB  X5, X18, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X20, D8
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X17, V9.D[1]
TaishanSimdReduceP01_label_27:
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X17, D9
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X9, D10
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X14, X19, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X10, D11
    MOVZ  X19, #0x0, LSL #0
    SUB  X14, X19, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X27, X17, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X13, D12
    MOVZ  X17, #0x0, LSL #0
    SUB  X27, X17, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X8, D13
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X4, D14
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X12, D15
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X23
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X23, D16
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X23
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X26, X2, X11
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    FMOV  X11, D17
    MOVZ  X2, #0x0, LSL #0
    SUB  X26, X2, X11
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X2, D18
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X11, D19
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X15, D20
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X17, X22, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X23, D21
    MOVZ  X22, #0x0, LSL #0
    SUB  X17, X22, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X8, D22
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X22, V23.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X22, D23
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X2, D25
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X4, V26.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X4, D26
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X21, V27.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X2, X15, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X21, D27
    MOVZ  X15, #0xff00, LSL #0
    MOVK  X15, #0xffff, LSL #16
TaishanSimdReduceP01_label_361:
    MOVK  X15, #0xff00, LSL #48
    SUB  X2, X15, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X5, V28.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X20, X11, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X5, D28
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x7f80, LSL #16
    SUB  X20, X11, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X18, X3, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X12, D29
    MOVZ  X3, #0x0, LSL #0
    SUB  X18, X3, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
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
    FMOV  V0.D[1], X8
    FMOV  D1, X19
    FMOV  V1.D[1], X23
    FMOV  D2, X11
    FMOV  V2.D[1], X28
    FMOV  D3, X25
    FMOV  V3.D[1], X26
    FMOV  D4, X6
    FMOV  V4.D[1], X5
    FMOV  D5, X2
    FMOV  V5.D[1], X21
    FMOV  D6, X13
    FMOV  V6.D[1], X22
    FMOV  D7, X5
    FMOV  V7.D[1], X20
    FMOV  D8, X14
    FMOV  V8.D[1], X21
    FMOV  D9, X6
    FMOV  V9.D[1], X6
    FMOV  D10, X8
    FMOV  V10.D[1], X26
    FMOV  D11, X19
    FMOV  V11.D[1], X19
    FMOV  D12, X5
    FMOV  V12.D[1], X21
    FMOV  D13, X9
    FMOV  V13.D[1], X2
    FMOV  D14, X2
    FMOV  V14.D[1], X13
    FMOV  D15, X11
    FMOV  V15.D[1], X10
    FMOV  D16, X28
    FMOV  V16.D[1], X2
    FMOV  D17, X26
    FMOV  V17.D[1], X3
    FMOV  D18, X14
    FMOV  V18.D[1], X20
    FMOV  D19, X8
    FMOV  V19.D[1], X18
    FMOV  D20, X29
    FMOV  V20.D[1], X12
    FMOV  D21, X12
    FMOV  V21.D[1], X16
    FMOV  D22, X16
    FMOV  V22.D[1], X7
    FMOV  D23, X25
    FMOV  V23.D[1], X10
    FMOV  D24, X28
    FMOV  V24.D[1], X16
    FMOV  D25, X13
    FMOV  V25.D[1], X22
    FMOV  D26, X2
    FMOV  V26.D[1], X9
    FMOV  D27, X25
    FMOV  V27.D[1], X2
    FMOV  D28, X29
    FMOV  V28.D[1], X12
    FMOV  D29, X13
    FMOV  V29.D[1], X20
    FMOV  D30, X7
    FMOV  V30.D[1], X9
    FMOV  D31, X23
    FMOV  V31.D[1], X27
    MOVZ  X5, #0xf, LSL #0
TaishanSimdReduceP01_label_1124:
    UMLSL2 V7.4S, V11.8H, V10.H[0x7]
    FDIV  V12.4S, V10.4S, V20.4S
    UQXTN2  V31.16B, V23.8H
    SRI  V9.8B, V4.8B, #5
    FCMLT  D16, D14, #0.0
    CMGE  V29.8H, V22.8H, #0
    FCVTZS  V9.4S, V14.4S, #27
    PMUL  V24.8B, V17.8B, V25.8B
    BIC  V29.4H, #0x81, LSL #8
    SRSHR V9.2D, V13.2D, #15
    CMLT  V10.4H, V15.4H, #0
    SQDMLSL D6, S26, V7.S[0x1]
    FCMEQ  V23.4S, V30.4S, V8.4S
    MOVI  V23.4S, #0x6c, LSL #24
    MLS  V14.8H, V29.8H, V26.8H
    USHLL V24.4S, V19.4H, #0xb
    EXT  V18.8B, V11.8B, V29.8B, #0x0
    SMULL V12.4S, V25.4H, V13.H[0x6]
    SMLAL2  V23.4S, V0.8H, V13.8H
    TRN1  V25.8B, V4.8B, V31.8B
    SQRSHL  D1, D6, D31
    UQSHL  V6.16B, V21.16B, #0x7
    SQDMLAL  V29.4S, V0.4H, V30.4H
    URSQRTE  V31.4S, V18.4S
    FCVTZS  V14.2S, V1.2S
    SQSHL S28, S24, #0x10
    UMAX  V1.16B, V25.16B, V1.16B
    SUBHN  V0.2S, V18.2D, V25.2D
    FCVTZU V3.2D, V29.2D, #57
    SSRA V13.2D, V14.2D, #62
    SQSHL  V12.8B, V15.8B, #0x6
    UQSHRN S21, D8, #23
    URSHR  V15.4S, V1.4S, #11
    SHRN2 V27.4S, V29.2D, #7
    USRA  V6.2S, V17.2S, #31
    SRI  V28.2S, V21.2S, #30
    INS V0.S[0x0], V24.S[0x0]
    TRN1  V6.2S, V9.2S, V25.2S
    FCVTZU  V0.4S, V30.4S, #32
    NEG  V9.4H, V23.4H
    FCMLE  D19, D13, #0.0
    SQSHRN2 V0.8H, V6.4S, #4
    SQRSHRUN V31.4H, V12.4S, #3
    ADDV  B10, V5.16B
    ZIP1  V12.4S, V25.4S, V1.4S
    MOV V6.B[0x1], V8.B[0x6]
    SQSHL V8.2D, V1.2D, #0x2
    UQRSHL  B10, B31, B31
    DUP B15, V5.B[0x8]
    SUBHN2  V0.8H, V0.4S, V26.4S
    FRINTX  V7.4S, V13.4S
    FMIN  V1.4S, V26.4S, V28.4S
    MOV H7, V19.H[0x3]
    FCMEQ  V31.2D, V10.2D, V29.2D
    UXTL V20.2D, V5.2S
    UQSHL  V20.2S, V6.2S, #0x11
    FMAXNM  V25.2D, V24.2D, V0.2D
    SQXTN  H25, S20
    FCVTPS  V1.2S, V19.2S
    FRSQRTE  V13.4S, V23.4S
    FACGT  D22, D22, D22
    UMLAL  V2.8H, V9.8B, V22.8B
    SMOV  X2, V24.H[0x5]
    FABD  S14, S27, S24
    CMEQ  D10, D5, D16
    FRSQRTS  S27, S22, S28
    SRSRA  V2.2S, V0.2S, #4
    FMULX D2, D23, V16.D[0x1]
    SQSHRUN2 V30.4S, V0.2D, #8
    FCVTZU  V28.2S, V11.2S
    MLA  V10.2S, V11.2S, V25.2S
    UMLSL  V22.2D, V30.2S, V1.2S
    SQABS  D24, D29
    SADALP  V31.2S, V9.4H
    SQDMULL2 V29.2D, V30.4S, V2.S[0x1]
    SQNEG  V12.4S, V16.4S
    FCVTXN  V29.2S, V28.2D
    DUP V25.2D, X19
    FMLS  V7.4S, V29.4S, V20.4S
    SQSHL  B12, B23, B31
    XTN  V12.2S, V9.2D
    FRSQRTE  V0.4S, V15.4S
    UMOV W29, V15.H[0x2]
    FCVTZS  V19.4S, V14.4S
    INS V4.S[0x3], V0.S[0x2]
    SQADD  D13, D25, D6
    FCVTNS  D26, D13
    UQSHL S7, S30, #0x1e
    UABAL2  V24.8H, V15.16B, V3.16B
    SRI  V1.8B, V12.8B, #2
    UQSHL  V16.2S, V25.2S, #0xe
    FRSQRTE  D24, D20
    UMLSL2 V26.2D, V10.4S, V7.S[0x2]
    SQDMLAL  S18, H25, H24
    UQSHL  D17, D2, D12
    CMHS  D1, D29, D6
TaishanSimdReduceP01_label_889:
    SABAL2  V19.2D, V9.4S, V11.4S
    SHSUB  V25.2S, V28.2S, V31.2S
    SSRA  V17.4H, V19.4H, #6
    USHR  V12.2S, V16.2S, #20
    FCVTZS  D1, D23
    FCMGE  D17, D22, D4
    UQRSHL  B24, B23, B24
    UMAX  V28.16B, V1.16B, V1.16B
    SQABS  B9, B7
    FCVTXN2  V12.4S, V2.2D
    SQDMLAL D27, S16, V12.S[0x0]
    UXTL2 V26.2D, V6.4S
    SHLL  V23.8H, V31.8B, #8
    FCVTMU  D14, D24
    UABAL2  V26.2D, V10.4S, V26.4S
    SHRN V7.4H, V28.4S, #7
    FMINNM  V15.4S, V9.4S, V19.4S
    FNEG  V16.2D, V24.2D
    FCVTZS  V13.4S, V12.4S, #5
    FMLS V27.2D, V16.2D, V5.D[0x1]
    FRECPE  D13, D19
    SQXTUN  H0, S23
    UQXTN2  V9.4S, V14.2D
    SQSHL  V8.8H, V24.8H, #0xd
    FCMLT  D22, D2, #0.0
    UQSHL S2, S12, #0xd
    SMOV  X28, V9.H[0x7]
    SRI D16, D19, #52
    UADALP  V14.4H, V7.8B
    FMINP D9, V6.2D
    SSRA  V26.4H, V10.4H, #12
    SADDLP  V30.8H, V16.16B
    SQDMLSL2  V8.4S, V23.8H, V9.8H
    UMOV X29, V8.D[0x0]
    ABS  D18, D10
    ORR  V9.8B, V24.8B, V16.8B
    FADDP D20, V5.2D
    SQSUB  H22, H31, H13
    FCMGT  S18, S11, S25
    SUQADD  H29, H0
    MOV V17.H[0x1], W16
    SSHLL V14.4S, V17.4H, #0x1
    ADD  V14.16B, V6.16B, V14.16B
    SQRSHL  V12.8B, V27.8B, V11.8B
    SQSHL  S27, S1, S9
    UQRSHRN V22.8B, V1.8H, #5
    FCVTZU V8.2D, V6.2D, #6
    FCVTZU  D23, D0
    CMLE  D21, D19, #0
    FMLS D21, D4, V18.D[0x0]
    SUQADD  S1, S10
    MOV  V14.16B, V5.16B
    SQSUB  B13, B23, B12
    FCMEQ  S28, S1, #0.0
    UQRSHRN B8, H28, #1
    SSHLL V27.8H, V29.8B, #0x4
    FACGT  D26, D29, D29
    UHADD  V5.2S, V26.2S, V27.2S
    SQDMULL D14, S12, V8.S[0x0]
    SQRSHRUN V2.2S, V1.2D, #23
    FMULX V0.2D, V21.2D, V5.D[0x1]
    FCMEQ  S8, S19, #0.0
    FRSQRTS  S11, S11, S8
    SQSHRN B31, H20, #3
    SCVTF  S4, S24
    SSHLL V23.8H, V18.8B, #0x1
    UQSUB  S6, S23, S23
    FCVTAS  S22, S16
    EXT  V29.8B, V1.8B, V7.8B, #0x0
    SMLSL2  V28.2D, V31.4S, V28.4S
    UQSHL  V18.2S, V24.2S, #0x10
    SXTL2 V27.4S, V13.8H
    SQRSHRUN2 V17.8H, V6.4S, #3
    SMOV  X16, V2.B[0x2]
    SQRSHRUN S24, D19, #3
    UABDL2  V12.8H, V10.16B, V4.16B
    UQSHRN H31, S26, #13
    UQSHL H15, H6, #0x0
    UMLAL  V24.2D, V12.2S, V1.2S
    ORR  V8.16B, V22.16B, V18.16B
    UMLAL2  V18.4S, V27.8H, V13.8H
    USUBL  V14.2D, V26.2S, V25.2S
    SQDMULL2 V25.4S, V30.8H, V5.H[0x5]
    SQRSHRN S17, D30, #26
    FMOV  V0.2S, #-2.87500000
    SRSHL  V22.2S, V24.2S, V12.2S
    SHADD  V30.4S, V7.4S, V12.4S
    SQDMLSL  D28, S3, S22
    SQSHL  D17, D27, D15
    SUQADD  V26.16B, V6.16B
    SQXTUN  S31, D6
    SUQADD  B26, B10
    FRINTM  V0.2D, V25.2D
    UMULL V30.2D, V19.2S, V28.S[0x0]
    SQSHL  V0.4S, V4.4S, #0x1b
    ADD  D4, D17, D24
    URSHL  V14.16B, V19.16B, V31.16B
    USRA  V30.16B, V29.16B, #8
    USHR  V28.4H, V28.4H, #3
    FRINTX  V7.2D, V14.2D
    CMLE  V13.2S, V10.2S, #0
    UABDL2  V28.2D, V3.4S, V1.4S
    FCVTMS  V25.2S, V11.2S
    SCVTF  S30, S28
    SUBS  X5, X5, #0x1
    B.NE  TaishanSimdReduceP01_label_1124
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X2
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X23, X26, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X6, X12, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X18, X13, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X12, X17, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X9, X10, X9
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X13, X6, X10
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X29, X10, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X23, X18, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X21, X28, X15
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X19, X11, X16
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X17, X11, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X26, X21, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X11, X25, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X22, X14, X22
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X4, X28, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X26, X28, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X23, X10, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X9, D2
    MOVZ  X10, #0x100, LSL #0
    SUB  X29, X10, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X14, X12, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X6, D3
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X14, X12, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X2, D4
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X20, D5
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X19, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X19, D6
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X17, D7
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X21, X11, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X19, D8
    MOVZ  X11, #0x0, LSL #0
    SUB  X21, X11, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X13, D9
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x8000, LSL #48
    SUB  X28, X21, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X25, X22, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    FMOV  X29, D10
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X25, X22, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X21, X14, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X28, D11
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x7fc0, LSL #16
    SUB  X21, X14, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X11, D12
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X2, D13
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X4, X21, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X7
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X7, D14
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X7
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X13, D15
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X18, D16
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x8000, LSL #48
    SUB  X23, X9, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X8, D17
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X21, V18.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X21, D18
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X26, D19
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X9
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X9, D20
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X9
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X29, D21
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x7ff8, LSL #48
    SUB  X6, X3, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X10, D22
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X18, D23
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X28, D25
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X14, X6, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X9, D26
    MOVZ  X6, #0x7f, LSL #0
    SUB  X14, X6, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X14, X11, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X23, D27
    MOVZ  X11, #0x0, LSL #0
    SUB  X14, X11, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X13, D28
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X27, D29
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0x7fff, LSL #16
    SUB  X2, X12, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    MOVZ  X2, #0x6f5d, LSL #0
    MOVK  X2, #0x5f83, LSL #16
    MOVK  X2, #0x8602, LSL #32
    MOVK  X2, #0x3db1, LSL #48
    MOVZ  X3, #0x8d9a, LSL #0
    MOVK  X3, #0x995, LSL #16
    MOVK  X3, #0x9358, LSL #32
    MOVK  X3, #0x16d3, LSL #48
    MOVZ  X4, #0x96c7, LSL #0
    MOVK  X4, #0xde75, LSL #16
    MOVK  X4, #0xa959, LSL #32
    MOVK  X4, #0x66b3, LSL #48
    MOVZ  X5, #0xa762, LSL #0
    MOVK  X5, #0x5f4, LSL #16
    MOVK  X5, #0x4736, LSL #32
    MOVK  X5, #0x5256, LSL #48
    MOVZ  X6, #0xed5c, LSL #0
    MOVK  X6, #0x7e90, LSL #16
    MOVK  X6, #0x183a, LSL #32
    MOVK  X6, #0xe01d, LSL #48
    MOVZ  X7, #0x65f9, LSL #0
    MOVK  X7, #0xa586, LSL #16
    MOVK  X7, #0xe816, LSL #32
    MOVK  X7, #0x6d7a, LSL #48
    MOVZ  X8, #0xda89, LSL #0
    MOVK  X8, #0x4c16, LSL #16
    MOVK  X8, #0x7452, LSL #32
    MOVK  X8, #0xa33f, LSL #48
    MOVZ  X9, #0xce7, LSL #0
    MOVK  X9, #0xa66, LSL #16
    MOVK  X9, #0xb474, LSL #32
    MOVK  X9, #0x9ea4, LSL #48
    MOVZ  X10, #0x5c6a, LSL #0
    MOVK  X10, #0x423f, LSL #16
    MOVK  X10, #0x8b4d, LSL #32
    MOVK  X10, #0x9851, LSL #48
    MOVZ  X11, #0x29a3, LSL #0
    MOVK  X11, #0x8eba, LSL #16
    MOVK  X11, #0xd32f, LSL #32
    MOVK  X11, #0xa4d6, LSL #48
    MOVZ  X12, #0xdd36, LSL #0
    MOVK  X12, #0x60cf, LSL #16
    MOVK  X12, #0x105d, LSL #32
    MOVK  X12, #0xa056, LSL #48
    MOVZ  X13, #0xea1d, LSL #0
    MOVK  X13, #0xede, LSL #16
    MOVK  X13, #0xb81e, LSL #32
    MOVK  X13, #0xcb3, LSL #48
    MOVZ  X14, #0x4b4f, LSL #0
    MOVK  X14, #0x58d1, LSL #16
    MOVK  X14, #0x5a5e, LSL #32
    MOVK  X14, #0xec13, LSL #48
    MOVZ  X15, #0xa7a, LSL #0
    MOVK  X15, #0x27, LSL #16
    MOVK  X15, #0xe62d, LSL #32
    MOVK  X15, #0x9e55, LSL #48
    MOVZ  X16, #0x23d8, LSL #0
    MOVK  X16, #0x5b6d, LSL #16
    MOVK  X16, #0xdd18, LSL #32
    MOVK  X16, #0xb37, LSL #48
    MOVZ  X17, #0xc613, LSL #0
    MOVK  X17, #0x3840, LSL #16
    MOVK  X17, #0x38c8, LSL #32
    MOVK  X17, #0x48a7, LSL #48
    MOVZ  X18, #0x1313, LSL #0
    MOVK  X18, #0xc6ec, LSL #16
    MOVK  X18, #0xe5b3, LSL #32
    MOVK  X18, #0x8038, LSL #48
    MOVZ  X19, #0x8ab9, LSL #0
    MOVK  X19, #0xbd32, LSL #16
    MOVK  X19, #0x7c1, LSL #32
    MOVK  X19, #0x5d78, LSL #48
    MOVZ  X20, #0xc5e5, LSL #0
    MOVK  X20, #0xd2ab, LSL #16
    MOVK  X20, #0x39c3, LSL #32
    MOVK  X20, #0x8280, LSL #48
    MOVZ  X21, #0x7960, LSL #0
    MOVK  X21, #0x4549, LSL #16
    MOVK  X21, #0xc680, LSL #32
    MOVK  X21, #0xfa15, LSL #48
    MOVZ  X22, #0x7f4, LSL #0
    MOVK  X22, #0x7a66, LSL #16
    MOVK  X22, #0x723a, LSL #32
    MOVK  X22, #0xe5b6, LSL #48
    MOVZ  X23, #0x428b, LSL #0
    MOVK  X23, #0xfc9c, LSL #16
    MOVK  X23, #0x25c6, LSL #32
TaishanSimdReduceP01_label_1061:
    MOVK  X23, #0x4e5, LSL #48
    MOVZ  X25, #0xa05d, LSL #0
    MOVK  X25, #0x6d06, LSL #16
    MOVK  X25, #0x8362, LSL #32
    MOVK  X25, #0x53bb, LSL #48
    MOVZ  X26, #0xa4df, LSL #0
    MOVK  X26, #0x320e, LSL #16
    MOVK  X26, #0x8978, LSL #32
    MOVK  X26, #0xa685, LSL #48
    MOVZ  X27, #0xa968, LSL #0
    MOVK  X27, #0x7d8f, LSL #16
    MOVK  X27, #0xb76b, LSL #32
    MOVK  X27, #0x6fdb, LSL #48
    MOVZ  X28, #0x2c39, LSL #0
    MOVK  X28, #0xb545, LSL #16
    MOVK  X28, #0x1ff5, LSL #32
    MOVK  X28, #0xad45, LSL #48
    MOVZ  X29, #0x80e6, LSL #0
    MOVK  X29, #0x46b9, LSL #16
    MOVK  X29, #0x40d0, LSL #32
    MOVK  X29, #0xeae8, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X18
    FMOV  D1, X28
    FMOV  V1.D[1], X17
    FMOV  D2, X23
    FMOV  V2.D[1], X13
    FMOV  D3, X15
    FMOV  V3.D[1], X5
    FMOV  D4, X25
    FMOV  V4.D[1], X27
    FMOV  D5, X29
    FMOV  V5.D[1], X22
    FMOV  D6, X28
    FMOV  V6.D[1], X25
    FMOV  D7, X16
    FMOV  V7.D[1], X25
    FMOV  D8, X8
    FMOV  V8.D[1], X22
    FMOV  D9, X15
    FMOV  V9.D[1], X12
    FMOV  D10, X18
    FMOV  V10.D[1], X23
    FMOV  D11, X18
    FMOV  V11.D[1], X26
    FMOV  D12, X27
    FMOV  V12.D[1], X12
    FMOV  D13, X3
    FMOV  V13.D[1], X18
    FMOV  D14, X27
    FMOV  V14.D[1], X9
    FMOV  D15, X15
    FMOV  V15.D[1], X16
    FMOV  D16, X26
    FMOV  V16.D[1], X4
    FMOV  D17, X16
    FMOV  V17.D[1], X19
    FMOV  D18, X10
    FMOV  V18.D[1], X17
    FMOV  D19, X21
    FMOV  V19.D[1], X20
    FMOV  D20, X28
    FMOV  V20.D[1], X5
    FMOV  D21, X20
    FMOV  V21.D[1], X27
    FMOV  D22, X17
    FMOV  V22.D[1], X15
    FMOV  D23, X17
TaishanSimdReduceP01_label_410:
    FMOV  V23.D[1], X11
    FMOV  D24, X17
    FMOV  V24.D[1], X29
    FMOV  D25, X15
    FMOV  V25.D[1], X22
    FMOV  D26, X6
    FMOV  V26.D[1], X19
    FMOV  D27, X3
    FMOV  V27.D[1], X6
    FMOV  D28, X27
    FMOV  V28.D[1], X28
    FMOV  D29, X7
    FMOV  V29.D[1], X20
    FMOV  D30, X6
    FMOV  V30.D[1], X26
    FMOV  D31, X17
    FMOV  V31.D[1], X10
TaishanSimdReduceP01_label_457:
    MOVZ  X19, #0xa, LSL #0
TaishanSimdReduceP01_label_1202:
    SMULL2 V0.2D, V13.4S, V20.S[0x0]
    SSRA  V3.4H, V12.4H, #11
    SMLSL2 V16.4S, V24.8H, V3.H[0x5]
    FCVTNS  D25, D0
    SQRSHRUN V0.2S, V21.2D, #22
    SQXTN  B16, H16
    FCMGT  V21.2S, V2.2S, V7.2S
    EXT  V19.16B, V29.16B, V15.16B, #0x0
    UCVTF D5, D27, #51
    SQRSHL  B28, B5, B5
    UQSUB  H24, H14, H28
    FMAXNM  V26.2D, V30.2D, V0.2D
    UQRSHRN2 V30.8H, V19.4S, #2
    REV32  V19.4H, V19.4H
    CLS  V28.4H, V5.4H
    SQRSHL  B21, B18, B25
    SQDMULL S23, H20, V3.H[0x7]
    SQRSHRUN2 V0.16B, V16.8H, #7
    SQNEG  B24, B11
    SQDMULL  S1, H31, H11
    SXTL2 V30.4S, V20.8H
    SLI  V26.4H, V16.4H, #0x5
    UQRSHL  D7, D30, D25
    SABAL2  V29.2D, V20.4S, V26.4S
    USQADD  B22, B14
    FCMEQ  V4.4S, V30.4S, V25.4S
    SSUBW2  V19.8H, V3.8H, V7.16B
    UADDLV  D4, V11.4S
    MOV B29, V0.B[0xb]
    UMULL2 V24.2D, V9.4S, V26.S[0x3]
    NEG  D13, D20
    FNEG  V18.4S, V7.4S
    INS V7.H[0x6], W2
    SRSRA  V30.8B, V24.8B, #5
    XTN  V26.8B, V1.8H
    SXTL V21.4S, V16.4H
    INS V5.D[0x1], X19
    DUP S19, V9.S[0x3]
    FMAXNMV  S28, V15.4S
    FMLA V4.4S, V7.4S, V14.S[0x1]
    FRINTP  V11.2D, V21.2D
    RSUBHN2  V28.8H, V1.4S, V30.4S
    UMAX  V5.8B, V30.8B, V31.8B
    UMOV W17, V13.H[0x4]
    FCMLE  D25, D4, #0.0
    SQDMLAL  V28.4S, V21.4H, V2.4H
    DUP D21, V10.D[0x1]
    UMULL  V15.8H, V20.8B, V31.8B
    UQADD  B11, B27, B16
    FCVTNS  S4, S19
    NEG  V3.16B, V9.16B
    UXTL2 V28.4S, V18.8H
    FMAXNMP S3, V15.2S
    SHL D26, D2, #0x7
    RSUBHN  V16.2S, V11.2D, V20.2D
    RADDHN2  V18.4S, V14.2D, V30.2D
    USHR V10.2D, V2.2D, #22
    REV64  V15.16B, V2.16B
    SQDMULH  H7, H28, H0
    FCVTNU  V4.4S, V10.4S
    SQXTN  V14.8B, V29.8H
    SQXTN  H4, S26
    MOVI  V14.8H, #0x40
    SQSHRUN2 V1.16B, V28.8H, #8
    SQXTN  V15.4H, V15.4S
    SQSHLU  V24.8B, V29.8B, #0x0
    USHL  D29, D30, D4
    FMAX  V13.2S, V6.2S, V14.2S
    FCMEQ  V11.2S, V24.2S, #0.0
    SXTL V11.8H, V23.8B
    SSHR D6, D22, #19
    UADALP  V30.1D, V8.2S
    MLS  V4.4H, V12.4H, V13.H[0x0]
    ADDV  B6, V29.8B
    UQSHL D15, D23, #0x35
    SSRA D29, D7, #57
    FACGE  V27.4S, V10.4S, V5.4S
    CMHI  D11, D12, D26
    UQRSHL  D11, D22, D5
    INS V28.S[0x0], V1.S[0x1]
    SLI  V7.2S, V16.2S, #0xa
    SSUBL2  V22.4S, V25.8H, V17.8H
    SLI  V22.2S, V22.2S, #0x16
    SQSHRN2 V30.16B, V26.8H, #3
    UQSHL  V26.2S, V10.2S, #0xa
    CMEQ  V24.4H, V20.4H, #0
    MOV  W18, V15.S[0x1]
    USHR  V12.8H, V26.8H, #6
    USHR  V1.2S, V15.2S, #9
    FCVTZS S0, S26, #14
    UMOV W14, V17.B[0xc]
    FMULX S20, S9, V28.S[0x3]
    USRA D29, D12, #35
    CMLE  D25, D29, #0
    DUP V16.2D, V27.D[0x0]
    FADDP S29, V2.2S
    FCMEQ  S24, S13, #0.0
    INS V12.S[0x0], V2.S[0x2]
    FRECPS  V25.2S, V22.2S, V0.2S
    MOV B20, V10.B[0xa]
    UQRSHRN B14, H30, #8
    SXTL V12.4S, V24.4H
    FMULX  D27, D23, D10
    CNT  V4.16B, V11.16B
    SQSHRN2 V7.8H, V25.4S, #9
    FCVTZS  D22, D13
    UQRSHL  V25.8B, V0.8B, V9.8B
    FMINP  V9.4S, V1.4S, V23.4S
    USQADD  D8, D27
    CMLE  V9.4H, V11.4H, #0
TaishanSimdReduceP01_label_1154:
    SQABS  S24, S28
    UADALP  V4.2D, V24.4S
    SQABS  B28, B7
    BIC  V5.2S, #0x82, LSL #8
    UQSHL  B13, B26, B26
    SMLAL2 V31.4S, V11.8H, V8.H[0x1]
    SQRDMULH  S31, S10, S16
    SHL  V25.4H, V13.4H, #0xb
    UQSHL  S4, S28, S26
    FCVTAS  D20, D13
    SADDLV  D30, V24.4S
    UQXTN  S4, D24
    SQNEG  B15, B27
    SUQADD  D20, D22
    SQXTN  V13.8B, V4.8H
    UQRSHRN V15.2S, V16.2D, #9
    SQDMLSL  S5, H25, H30
    FCVTNU  D24, D9
    SQSHLU D0, D4, #0x26
    FACGT  V28.2S, V9.2S, V7.2S
    UMLSL  V27.4S, V26.4H, V6.4H
    SQDMULL2 V17.2D, V25.4S, V20.S[0x2]
    SQRSHRUN2 V22.8H, V21.4S, #4
    UMULL2 V16.2D, V0.4S, V16.S[0x0]
    FMLA D7, D15, V30.D[0x1]
    UQSHRN S18, D7, #23
    SHRN2 V0.8H, V12.4S, #13
    UQSHRN H14, S5, #9
    EOR  V16.16B, V12.16B, V18.16B
    FDIV  V30.2D, V21.2D, V4.2D
    MOVI  V22.16B, #0x21
    URSRA  V27.2S, V8.2S, #27
    FCMGT  V11.4S, V6.4S, V10.4S
    MLS  V28.4S, V15.4S, V26.S[0x3]
    CMLT  V4.2D, V15.2D, #0
    FRINTZ  V7.2D, V11.2D
    SSRA  V26.16B, V7.16B, #3
    UABAL2  V11.8H, V14.16B, V12.16B
    FCVTAU  V12.2D, V0.2D
    ORR  V16.2S, #0x45, LSL #16
    SABDL2  V0.8H, V27.16B, V27.16B
    MVNI  V24.8H, #0x49, LSL #8
    SQDMLSL D19, S5, V22.S[0x3]
    FRSQRTS  V7.2D, V20.2D, V6.2D
    SMAXP  V24.2S, V8.2S, V13.2S
    URSHR  V6.4S, V21.4S, #11
    CMGE  D3, D2, #0
    SQRSHL  B11, B15, B12
    UMULL V27.2D, V23.2S, V7.S[0x2]
    UMOV W28, V14.B[0xe]
    FDIV  V3.2D, V3.2D, V26.2D
    UMAX  V28.4H, V14.4H, V0.4H
    SQRSHRN2 V14.4S, V22.2D, #3
    UQXTN2  V6.16B, V18.8H
    UQXTN  S13, D20
    SQSHLU S7, S21, #0x1c
    SSHR  V28.8H, V11.8H, #1
    ADDV  S30, V21.4S
    UQSHL V15.2D, V9.2D, #0x37
    FRECPX  S12, S8
    AND  V10.16B, V8.16B, V6.16B
    SQXTUN  B17, H31
    FMULX V11.2S, V28.2S, V18.S[0x0]
    UADDLV  D9, V20.4S
    SQDMLAL V4.2D, V19.2S, V16.S[0x2]
    UADDL  V4.8H, V0.8B, V20.8B
    SQSHRN H28, S17, #12
    FMINNMP D12, V6.2D
    SQRSHRUN H3, S29, #4
    SQDMLAL S1, H9, V10.H[0x4]
    UQSHRN V4.2S, V8.2D, #16
    FACGT  D6, D12, D3
    ADDP  D17, V21.2D
    FMUL V5.4S, V24.4S, V6.S[0x3]
    SADDL2  V18.8H, V23.16B, V17.16B
    SRI  V10.8H, V30.8H, #15
    FMLS V5.2D, V0.2D, V2.D[0x1]
    SQSUB  V1.4S, V16.4S, V6.4S
    RSHRN2 V6.8H, V0.4S, #10
    SQSHL D10, D9, #0x27
    UQSHL  D6, D6, D30
    UMAXV  B21, V7.16B
    SRHADD  V25.8B, V18.8B, V8.8B
    SXTL2 V31.2D, V8.4S
    FRECPE  V4.4S, V12.4S
    SQRSHRUN2 V3.8H, V31.4S, #5
    SABD  V24.4H, V25.4H, V25.4H
    UADDW  V23.4S, V1.4S, V24.4H
    USQADD  S31, S18
    FRINTX  V18.2D, V21.2D
    SUBS  X19, X19, #0x1
    B.NE  TaishanSimdReduceP01_label_1202
    MOVZ  X9, #0x6f5d, LSL #0
    MOVK  X9, #0x5f83, LSL #16
    MOVK  X9, #0x8602, LSL #32
    MOVK  X9, #0x3db1, LSL #48
    SUB  X14, X9, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    MOVZ  X12, #0x8d9a, LSL #0
    MOVK  X12, #0x995, LSL #16
    MOVK  X12, #0x9358, LSL #32
    MOVK  X12, #0x16d3, LSL #48
    SUB  X25, X12, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    MOVZ  X25, #0x96c7, LSL #0
    MOVK  X25, #0xde75, LSL #16
    MOVK  X25, #0xa959, LSL #32
    MOVK  X25, #0x66b3, LSL #48
    SUB  X26, X25, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    MOVZ  X21, #0xa762, LSL #0
    MOVK  X21, #0x5f4, LSL #16
    MOVK  X21, #0x4736, LSL #32
    MOVK  X21, #0x5256, LSL #48
    SUB  X20, X21, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    MOVZ  X15, #0xed5c, LSL #0
    MOVK  X15, #0x7e90, LSL #16
    MOVK  X15, #0x183a, LSL #32
    MOVK  X15, #0xe01d, LSL #48
    SUB  X4, X15, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    MOVZ  X10, #0x65f9, LSL #0
    MOVK  X10, #0xa586, LSL #16
    MOVK  X10, #0xe816, LSL #32
    MOVK  X10, #0x6d7a, LSL #48
    SUB  X23, X10, X7
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    MOVZ  X3, #0xda89, LSL #0
    MOVK  X3, #0x4c16, LSL #16
    MOVK  X3, #0x7452, LSL #32
    MOVK  X3, #0xa33f, LSL #48
    SUB  X17, X3, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    MOVZ  X6, #0x6f5d, LSL #0
    MOVK  X6, #0x5f83, LSL #16
    MOVK  X6, #0x8602, LSL #32
    MOVK  X6, #0x3db1, LSL #48
    SUB  X27, X6, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    MOVZ  X12, #0x65f9, LSL #0
    MOVK  X12, #0xa586, LSL #16
    MOVK  X12, #0xe816, LSL #32
    MOVK  X12, #0x6d7a, LSL #48
    SUB  X13, X12, X10
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    MOVZ  X18, #0x29a3, LSL #0
    MOVK  X18, #0x8eba, LSL #16
    MOVK  X18, #0xd32f, LSL #32
    MOVK  X18, #0xa4d6, LSL #48
    SUB  X27, X18, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    MOVZ  X13, #0x65f9, LSL #0
    MOVK  X13, #0xa586, LSL #16
    MOVK  X13, #0xe816, LSL #32
    MOVK  X13, #0x6d7a, LSL #48
    SUB  X28, X13, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    MOVZ  X16, #0x65f9, LSL #0
    MOVK  X16, #0xa586, LSL #16
    MOVK  X16, #0xe816, LSL #32
    MOVK  X16, #0x6d7a, LSL #48
    SUB  X3, X16, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    MOVZ  X16, #0xed5c, LSL #0
    MOVK  X16, #0x7e90, LSL #16
    MOVK  X16, #0x183a, LSL #32
    MOVK  X16, #0xe01d, LSL #48
    SUB  X20, X16, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    MOVZ  X20, #0xed5c, LSL #0
    MOVK  X20, #0x7e90, LSL #16
    MOVK  X20, #0x183a, LSL #32
    MOVK  X20, #0xe01d, LSL #48
    SUB  X4, X20, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    MOVZ  X15, #0x29a3, LSL #0
    MOVK  X15, #0x8eba, LSL #16
    MOVK  X15, #0xd32f, LSL #32
    MOVK  X15, #0xa4d6, LSL #48
    SUB  X22, X15, X18
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    MOVZ  X19, #0xed5c, LSL #0
    MOVK  X19, #0x7e90, LSL #16
    MOVK  X19, #0x183a, LSL #32
    MOVK  X19, #0xe01d, LSL #48
    SUB  X2, X19, X20
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    MOVZ  X19, #0xa762, LSL #0
    MOVK  X19, #0x5f4, LSL #16
    MOVK  X19, #0x4736, LSL #32
    MOVK  X19, #0x5256, LSL #48
    SUB  X8, X19, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X22
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X27, X25, X26
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    MOVZ  X28, #0x80e6, LSL #0
    MOVK  X28, #0x46b9, LSL #16
    MOVK  X28, #0x40d0, LSL #32
    MOVK  X28, #0xeae8, LSL #48
    SUB  X19, X28, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X3, V2.D[1]
    MOVZ  X27, #0xea1d, LSL #0
    MOVK  X27, #0xede, LSL #16
    MOVK  X27, #0xb81e, LSL #32
    MOVK  X27, #0xcb3, LSL #48
    SUB  X9, X27, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X3, D2
    MOVZ  X27, #0x428b, LSL #0
    MOVK  X27, #0xfc9c, LSL #16
    MOVK  X27, #0x25c6, LSL #32
    MOVK  X27, #0x4e5, LSL #48
    SUB  X9, X27, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X9
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X9, D3
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X9
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X22, V4.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x7f80, LSL #16
    MOVK  X12, #0x7f80, LSL #48
    SUB  X23, X12, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X22, D4
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x7f80, LSL #16
    MOVK  X12, #0x7f80, LSL #48
    SUB  X23, X12, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X19, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x8000, LSL #48
TaishanSimdReduceP01_label_765:
    SUB  X11, X2, X19
TaishanSimdReduceP01_label_379:
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
TaishanSimdReduceP01_label_177:
    FMOV  X19, D5
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x8000, LSL #48
    SUB  X11, X2, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X20
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X20, D6
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X20
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X17, D7
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X15, X29, X5
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X5, D8
    MOVZ  X29, #0xda89, LSL #0
    MOVK  X29, #0x4c16, LSL #16
    MOVK  X29, #0x7452, LSL #32
    MOVK  X29, #0xa33f, LSL #48
    SUB  X15, X29, X5
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X8, D9
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X27, V10.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X27, D10
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X19, X26, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X8, D11
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x7fc0, LSL #16
    MOVK  X26, #0x7fc0, LSL #48
    SUB  X19, X26, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X14, D12
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X21, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X14, X29, X21
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X21, D13
    MOVZ  X29, #0x0, LSL #0
    SUB  X14, X29, X21
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0x7fff, LSL #48
    SUB  X22, X5, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X8, D14
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X17, V15.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X17, D15
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X29, X7, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    FMOV  X11, D16
TaishanSimdReduceP01_label_1200:
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x45, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X12, X14, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X3, D17
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X29, X12, X26
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X26, D18
    MOVZ  X12, #0x0, LSL #0
    SUB  X29, X12, X26
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X15, V19.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X7, X5, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X15, D19
    MOVZ  X5, #0x0, LSL #0
    SUB  X7, X5, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X29, D20
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X22, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X7, X5, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X22, D21
    MOVZ  X5, #0x0, LSL #0
    SUB  X7, X5, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X11, #0x2121, LSL #0
    MOVK  X11, #0x2121, LSL #16
    MOVK  X11, #0x2121, LSL #32
    MOVK  X11, #0x2121, LSL #48
    SUB  X14, X11, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X13, D22
    MOVZ  X11, #0x2121, LSL #0
    MOVK  X11, #0x2121, LSL #16
    MOVK  X11, #0x2121, LSL #32
    MOVK  X11, #0x2121, LSL #48
    SUB  X14, X11, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X10, X4, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X12, D23
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x45, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X10, X4, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X5, V25.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
TaishanSimdReduceP01_label_131:
    FMOV  X5, D25
    MOVZ  X11, #0xedc5, LSL #0
    MOVK  X11, #0x260b, LSL #16
    MOVK  X11, #0x3a29, LSL #32
    MOVK  X11, #0xd220, LSL #48
    SUB  X17, X11, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X23, D26
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0x4c00, LSL #32
    SUB  X28, X18, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X16, D27
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X25, D28
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    FMOV  X8, D29
    MOVZ  X16, #0x428b, LSL #0
    MOVK  X16, #0xfc9c, LSL #16
    SUB  X25, X16, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
TaishanSimdReduceP01_label_1012:
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X5
    FMOV  V0.D[1], X11
    FMOV  D1, X19
    FMOV  V1.D[1], X10
    FMOV  D2, X14
    FMOV  V2.D[1], X15
    FMOV  D3, X16
    FMOV  V3.D[1], X8
    FMOV  D4, X18
    FMOV  V4.D[1], X22
    FMOV  D5, X16
    FMOV  V5.D[1], X17
    FMOV  D6, X29
    FMOV  V6.D[1], X23
    FMOV  D7, X25
    FMOV  V7.D[1], X16
    FMOV  D8, X26
    FMOV  V8.D[1], X29
    FMOV  D9, X5
    FMOV  V9.D[1], X16
    FMOV  D10, X28
    FMOV  V10.D[1], X7
    FMOV  D11, X3
    FMOV  V11.D[1], X18
    FMOV  D12, X22
    FMOV  V12.D[1], X7
    FMOV  D13, X16
    FMOV  V13.D[1], X16
    FMOV  D14, X13
    FMOV  V14.D[1], X29
    FMOV  D15, X5
    FMOV  V15.D[1], X22
    FMOV  D16, X5
    FMOV  V16.D[1], X14
    FMOV  D17, X22
    FMOV  V17.D[1], X10
    FMOV  D18, X25
    FMOV  V18.D[1], X12
    FMOV  D19, X8
    FMOV  V19.D[1], X15
    FMOV  D20, X5
    FMOV  V20.D[1], X23
    FMOV  D21, X2
    FMOV  V21.D[1], X22
    FMOV  D22, X23
    FMOV  V22.D[1], X29
    FMOV  D23, X11
    FMOV  V23.D[1], X29
    FMOV  D24, X26
    FMOV  V24.D[1], X21
    FMOV  D25, X8
    FMOV  V25.D[1], X20
    FMOV  D26, X29
    FMOV  V26.D[1], X21
    FMOV  D27, X5
    FMOV  V27.D[1], X21
    FMOV  D28, X9
    FMOV  V28.D[1], X9
    FMOV  D29, X25
    FMOV  V29.D[1], X9
    FMOV  D30, X10
    FMOV  V30.D[1], X12
    FMOV  D31, X5
    FMOV  V31.D[1], X9
    MOVZ  X26, #0xa, LSL #0
TaishanSimdReduceP01_label_1277:
    NEG  V22.8H, V16.8H
    MOV V6.S[0x3], W2
    MOV  V18.8B, V23.8B
    FCVTPS  V0.4S, V21.4S
    FMLS S19, S6, V23.S[0x0]
    INS V25.B[0x0], V23.B[0x5]
    SSHR  V5.16B, V21.16B, #6
    SQDMULH S4, S15, V25.S[0x1]
    UQRSHRN2 V29.16B, V7.8H, #1
    SLI V0.2D, V31.2D, #0x5
    FCMLE  D12, D27, #0.0
    ADDHN2  V16.16B, V16.8H, V21.8H
    UMOV W2, V15.S[0x0]
    SQSHRN V19.2S, V11.2D, #24
    SSUBL  V14.8H, V15.8B, V1.8B
    SMULL V7.2D, V20.2S, V28.S[0x2]
    DUP  V7.16B, V5.B[0xf]
    SRI D4, D21, #6
    SQADD  V19.16B, V0.16B, V15.16B
    SQNEG  B12, B28
    DUP  V12.8B, V18.B[0x4]
    UCVTF S16, S8, #19
    UMOV W2, V20.S[0x3]
    FCMLT  D2, D29, #0.0
    FMINNMP  V4.2D, V2.2D, V19.2D
    USRA  V1.16B, V22.16B, #2
    FABD  V8.4S, V21.4S, V16.4S
    SADDLP  V4.2D, V15.4S
    SABDL2  V25.2D, V12.4S, V23.4S
    RSHRN2 V7.16B, V1.8H, #1
    UADDL2  V26.4S, V11.8H, V24.8H
    XTN2  V7.4S, V6.2D
    SHLL2  V21.8H, V20.16B, #8
    USRA D6, D14, #10
    FCVTNU  D8, D23
    SMLAL V24.4S, V3.4H, V7.H[0x5]
    SQSHLU S6, S25, #0x9
    UQSHRN2 V13.16B, V19.8H, #2
    SSUBL2  V9.8H, V11.16B, V14.16B
    USQADD  S27, S24
    FMAXP  V20.4S, V6.4S, V19.4S
    SQSHL  V20.8H, V17.8H, #0xc
    MUL  V11.4S, V6.4S, V19.S[0x1]
    UQXTN2  V2.4S, V28.2D
    CMLT  D0, D24, #0
    SRSRA V30.2D, V19.2D, #63
    UMULL  V28.4S, V21.4H, V7.4H
    RSHRN V1.8B, V4.8H, #4
    CMEQ  V23.8B, V2.8B, V2.8B
    SQSHRN2 V21.8H, V26.4S, #8
    MOVI  V18.8H, #0x5d, LSL #8
    FMINP D4, V6.2D
    FMLA V4.2S, V17.2S, V29.S[0x1]
    FCMGE  S14, S19, S6
    SSHR  V8.16B, V6.16B, #5
    UADDLV  H28, V31.8B
    FMLS V1.2D, V19.2D, V20.D[0x0]
    SQDMULL  S9, H5, H21
    SMLSL V7.4S, V31.4H, V11.H[0x4]
    USRA D9, D24, #23
    FRINTN  V18.4S, V21.4S
    FCVTMU  V22.2S, V18.2S
    BSL  V14.16B, V18.16B, V28.16B
    FRECPX  S13, S0
    RSUBHN2  V29.16B, V5.8H, V0.8H
    SRI D19, D5, #13
    FCVTZS D29, D19, #22
    SMULL2 V10.2D, V30.4S, V31.S[0x3]
    SRSRA  V16.2S, V15.2S, #9
    AND  V8.16B, V21.16B, V0.16B
    FADDP  V12.2D, V24.2D, V11.2D
    UQSUB  B1, B14, B28
    SQRSHRUN2 V0.8H, V9.4S, #15
    MOVI  V19.16B, #0xf8
    SADDLV  S7, V11.8H
    SADDLP  V30.8H, V22.16B
    SQDMULH  V10.8H, V28.8H, V15.H[0x2]
    FCVTZU  V22.2S, V20.2S
    MLA  V0.4S, V28.4S, V25.S[0x1]
    UQADD  B24, B28, B30
    XTN  V9.4H, V23.4S
    SQSUB  S9, S4, S7
    MLS  V30.4S, V0.4S, V11.4S
    SQRSHL  D31, D10, D14
    SRSRA D28, D2, #62
    SMINV  S23, V13.4S
    TRN1  V22.4H, V29.4H, V26.4H
    SQRSHRN2 V11.4S, V29.2D, #27
    SMLAL V22.2D, V26.2S, V10.S[0x1]
    SQDMLSL S13, H13, V1.H[0x7]
    SQSHRN H5, S30, #12
    FCVTZS  D20, D3
    MOVI  V15.2D, #72056494526300160
    USHLL2 V19.8H, V0.16B, #0x7
    URHADD  V18.2S, V30.2S, V23.2S
    TRN2  V19.2D, V24.2D, V8.2D
    SQRDMULH S2, S10, V13.S[0x0]
    SQRSHL  D11, D25, D29
    SMLAL2 V22.4S, V17.8H, V9.H[0x7]
    SMOV W7, V11.B[0x8]
    AND  V12.16B, V30.16B, V18.16B
    UQSHL H4, H27, #0x1
    UZP1  V13.4S, V10.4S, V23.4S
    ABS  D9, D24
    RSHRN2 V3.4S, V24.2D, #26
    DUP S7, V18.S[0x0]
    SXTL2 V21.8H, V9.16B
    SQDMULH  V20.4H, V8.4H, V11.H[0x3]
    FCMGE  D27, D25, #0.0
    SSHL  V28.8B, V18.8B, V17.8B
    URHADD  V1.8H, V5.8H, V31.8H
    FRECPE  S3, S8
    BIT  V15.8B, V19.8B, V24.8B
    USUBW  V29.2D, V14.2D, V23.2S
    FACGE  V23.4S, V23.4S, V31.4S
    SQSHRUN2 V31.16B, V1.8H, #3
    SMLSL V18.4S, V30.4H, V3.H[0x2]
    UMLAL V31.2D, V31.2S, V22.S[0x0]
    SMIN  V11.4H, V12.4H, V22.4H
    DUP H29, V10.H[0x5]
    SABAL  V26.8H, V1.8B, V18.8B
    SSRA D0, D23, #11
    UQSHL S14, S6, #0xa
    MOVI  V15.4S, #0x9e, LSL #8
    MOVI  V3.8H, #0x1, LSL #8
    RSHRN V10.2S, V2.2D, #19
    MLA  V17.2S, V3.2S, V19.S[0x1]
    USUBW2  V20.8H, V30.8H, V22.16B
    FCVTMU  S8, S21
    UMULL  V2.4S, V0.4H, V5.4H
    UMOV X18, V19.D[0x1]
    UQADD  S8, S4, S12
    MVNI  V6.4S, #0xf5, LSL #8
    USUBL2  V1.8H, V1.16B, V7.16B
    URSRA  V11.2S, V26.2S, #20
    FADDP D25, V31.2D
    UCVTF  D0, D17
    FRECPE  D6, D30
    SMLAL2 V10.4S, V29.8H, V6.H[0x7]
    UCVTF  S17, S0
    FMUL D29, D4, V6.D[0x0]
    FRECPX  S20, S2
    SSHLL V1.2D, V8.2S, #0x1f
    SQSHL D15, D7, #0x7
    SQRSHRUN2 V20.16B, V2.8H, #7
    UMLSL2 V20.2D, V31.4S, V11.S[0x3]
    FADDP S22, V6.2S
    FACGT  S6, S22, S26
    SCVTF  V19.2D, V1.2D
    SQSHL  V19.8B, V20.8B, #0x2
    USRA V1.2D, V13.2D, #46
    USHL  V4.2S, V21.2S, V5.2S
    FADDP D28, V15.2D
    NOT  V0.16B, V3.16B
    SQXTUN  S2, D30
    SSRA D17, D1, #37
    UXTL2 V8.2D, V14.4S
    FCVTZU  V23.2S, V9.2S, #5
    SRI  V4.16B, V5.16B, #5
    FMAXNMP D11, V4.2D
    FRINTM  V8.2S, V5.2S
    SQSHRN2 V7.16B, V7.8H, #8
    SMOV  X27, V4.S[0x1]
    UXTL V18.2D, V5.2S
    SQRSHRUN S0, D18, #10
    SMULL2 V20.2D, V19.4S, V28.S[0x0]
    UCVTF  S22, S29
    CMGT  D17, D7, D17
    SCVTF  D25, D22
    MOVI  V23.2S, #0x78
    UXTL2 V18.4S, V25.8H
    UADALP  V14.8H, V10.16B
    UXTL2 V20.2D, V0.4S
    FRINTI  V21.2D, V17.2D
    SABD  V15.4S, V11.4S, V9.4S
    UXTL V1.4S, V24.4H
    FMLA V22.4S, V16.4S, V7.S[0x3]
    XTN  V18.2S, V8.2D
    FMUL V23.2D, V19.2D, V18.D[0x1]
    URSRA  V29.8H, V12.8H, #11
    INS V0.B[0x4], V31.B[0xe]
    FMLA V9.2D, V7.2D, V27.D[0x0]
    FCMGE  S4, S15, #0.0
    SQDMULL2 V14.2D, V20.4S, V16.S[0x1]
    UXTL2 V9.4S, V4.8H
    ORR  V29.2S, #0xaa, LSL #24
    FACGE  S1, S10, S16
    FABD  S7, S18, S8
    SSUBL  V31.4S, V25.4H, V1.4H
    UMULL2 V0.2D, V12.4S, V10.S[0x3]
    USHLL2 V10.2D, V15.4S, #0x14
    SHLL  V24.8H, V6.8B, #8
    SUQADD  D19, D19
    FMULX S17, S27, V6.S[0x0]
    SQADD  S16, S16, S11
    SQDMLAL  V0.2D, V21.2S, V20.2S
    SQSHLU V19.2D, V18.2D, #0x11
    FCMEQ  V5.4S, V18.4S, V4.4S
TaishanSimdReduceP01_label_227:
    UQSUB  V5.8B, V5.8B, V13.8B
    SLI V17.2D, V13.2D, #0x2
    SUBS  X26, X26, #0x1
    B.NE  TaishanSimdReduceP01_label_1277
    MOVZ  X8, #0x0, LSL #0
    SUB  X28, X8, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X3
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X5
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    MOVZ  X20, #0x0, LSL #0
TaishanSimdReduceP01_label_663:
    SUB  X19, X20, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X7, X5, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X5, X19, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X19, X12, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X7, X10, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X29, D2
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X16, #0x100, LSL #0
    MOVK  X16, #0x100, LSL #16
    MOVK  X16, #0x100, LSL #32
    MOVK  X16, #0x100, LSL #48
    SUB  X22, X16, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X11, D3
    MOVZ  X16, #0x100, LSL #0
    MOVK  X16, #0x100, LSL #16
    MOVK  X16, #0x100, LSL #32
    MOVK  X16, #0x100, LSL #48
    SUB  X22, X16, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X2, D4
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X28, X9, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X12, D5
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X11, X28, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X25, D6
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X19, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X19, D7
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X20, D8
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X17, V9.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X17
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X17, D9
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X17
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X5, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X3, X22, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X5, D10
    MOVZ  X22, #0x0, LSL #0
    SUB  X3, X22, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X8, D11
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X16, D12
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X9, X12, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X16, D13
    MOVZ  X12, #0x0, LSL #0
    SUB  X9, X12, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X3, D14
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X26, X9, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    FMOV  X28, D15
    MOVZ  X9, #0x2, LSL #0
    SUB  X26, X9, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X5, X19, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X6, D16
    MOVZ  X19, #0x0, LSL #0
    SUB  X5, X19, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X10, X18, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X12, D17
    MOVZ  X18, #0x0, LSL #0
    SUB  X10, X18, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X27, D18
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X28, D19
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X2, D20
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X23, D21
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X3, D22
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X9, D23
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X21, V25.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X21, D25
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X16, D26
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X26, D27
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X28, X5, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X7, D28
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X3, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X27, X25, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X3, D29
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xaa00, LSL #16
    MOVK  X25, #0xfff8, LSL #48
    SUB  X27, X25, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
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
    FMOV  D1, X5
    FMOV  V1.D[1], X14
    FMOV  D2, X21
    FMOV  V2.D[1], X5
    FMOV  D3, X25
    FMOV  V3.D[1], X18
    FMOV  D4, X9
    FMOV  V4.D[1], X17
    FMOV  D5, X8
    FMOV  V5.D[1], X25
    FMOV  D6, X12
    FMOV  V6.D[1], X29
    FMOV  D7, X9
    FMOV  V7.D[1], X28
    FMOV  D8, X18
    FMOV  V8.D[1], X7
    FMOV  D9, X20
    FMOV  V9.D[1], X19
    FMOV  D10, X19
    FMOV  V10.D[1], X18
    FMOV  D11, X26
    FMOV  V11.D[1], X12
    FMOV  D12, X29
    FMOV  V12.D[1], X28
    FMOV  D13, X5
    FMOV  V13.D[1], X4
    FMOV  D14, X12
    FMOV  V14.D[1], X13
    FMOV  D15, X3
    FMOV  V15.D[1], X10
    FMOV  D16, X29
    FMOV  V16.D[1], X4
    FMOV  D17, X15
    FMOV  V17.D[1], X22
    FMOV  D18, X16
    FMOV  V18.D[1], X16
    FMOV  D19, X14
    FMOV  V19.D[1], X22
    FMOV  D20, X23
    FMOV  V20.D[1], X26
    FMOV  D21, X18
    FMOV  V21.D[1], X28
    FMOV  D22, X27
    FMOV  V22.D[1], X28
    FMOV  D23, X25
    FMOV  V23.D[1], X12
    FMOV  D24, X14
    FMOV  V24.D[1], X5
    FMOV  D25, X27
    FMOV  V25.D[1], X7
    FMOV  D26, X8
    FMOV  V26.D[1], X17
    FMOV  D27, X7
    FMOV  V27.D[1], X2
    FMOV  D28, X22
    FMOV  V28.D[1], X3
    FMOV  D29, X12
    FMOV  V29.D[1], X18
    FMOV  D30, X16
    FMOV  V30.D[1], X29
    FMOV  D31, X27
    FMOV  V31.D[1], X5
    MOVZ  X13, #0xf, LSL #0
TaishanSimdReduceP01_label_1354:
    SQRSHRUN V31.8B, V27.8H, #6
    SXTL V4.8H, V16.8B
    SQDMLSL2 V4.2D, V31.4S, V31.S[0x0]
    SHL  V2.4S, V20.4S, #0x11
    TBX  V15.16B, { V27.16B, V28.16B, V29.16B, V30.16B }, V22.16B
    SSRA  V21.4H, V24.4H, #16
    FRSQRTE  D22, D7
    SQXTN  B8, H15
    SMLAL  V11.2D, V9.2S, V9.2S
    FSQRT  V13.4S, V29.4S
    CLZ  V1.4S, V23.4S
    FMOV  V19.2D, #27.00000000
    UQRSHRN V1.4H, V22.4S, #8
    ADDP  V19.16B, V13.16B, V26.16B
    UXTL2 V8.4S, V25.8H
    SRI  V31.16B, V24.16B, #6
    FMLS D22, D8, V6.D[0x1]
    FCVTMU  D2, D4
    UMULL V26.4S, V13.4H, V0.H[0x6]
    FCVTNU  S5, S30
    SABD  V3.16B, V14.16B, V8.16B
    SQDMULL S8, H1, V3.H[0x5]
    SSHR V28.2D, V7.2D, #41
    SQXTN  V2.8B, V15.8H
    FMAXNMP S4, V17.2S
    FRINTP  V11.2S, V31.2S
    SMAXV  B11, V11.16B
    FRECPE  D21, D25
    SSHR D23, D29, #31
    SQRSHRUN2 V7.8H, V30.4S, #2
    SRI  V2.8B, V31.8B, #5
    EOR  V27.16B, V13.16B, V31.16B
    CMLT  D2, D22, #0
    FRECPE  D18, D28
    FCVTNU  D19, D2
    SQDMLAL2 V1.2D, V9.4S, V18.S[0x0]
    CMGT  D11, D12, D19
    ORR  V0.16B, V24.16B, V16.16B
    UMLAL  V8.8H, V8.8B, V2.8B
    CMGE  V21.2D, V23.2D, V27.2D
    FMAXNMP  V17.4S, V29.4S, V6.4S
    UQSHL  B13, B1, B11
    TRN1  V9.2D, V11.2D, V20.2D
    UQSHRN2 V23.8H, V17.4S, #1
    SMLAL V18.2D, V15.2S, V22.S[0x1]
    SQSHLU  V3.2S, V28.2S, #0x18
    CLS  V14.8H, V8.8H
    CMLE  V28.16B, V24.16B, #0
    FRECPS  D0, D14, D19
    SQRSHRUN2 V6.8H, V1.4S, #16
    SQSHL  V13.8B, V31.8B, #0x5
    FCVTPS  D3, D7
    SQDMLSL  V9.2D, V21.2S, V26.2S
    CMGE  D16, D12, D18
    FMLA  V21.2D, V16.2D, V25.2D
    UADDW2  V22.8H, V23.8H, V24.16B
    URSHR  V3.8B, V4.8B, #6
    SSHLL2 V1.4S, V18.8H, #0xe
    UMAXV  S6, V12.4S
    FMUL V9.2D, V26.2D, V24.D[0x1]
    SCVTF  S20, S26
    SQSHRUN2 V2.8H, V28.4S, #14
    ADDV  B21, V22.16B
    UQRSHRN2 V19.16B, V22.8H, #3
    MVNI  V7.4S, #0x60, LSL #8
    UMAXV  H25, V23.8H
    SMOV  X23, V1.S[0x2]
    SQNEG  S16, S28
    SQNEG  S17, S7
    SMULL2 V16.4S, V1.8H, V3.H[0x5]
    SQSHLU  V19.8B, V13.8B, #0x2
    FCMLE  V13.2D, V19.2D, #0.0
    SUQADD  D30, D2
    SQDMULH  H13, H17, H18
    URSHR  V19.8H, V27.8H, #1
    MOV V9.S[0x2], V0.S[0x2]
    SQDMULH H22, H13, V5.H[0x7]
    FMAXP  V5.2S, V29.2S, V24.2S
    UQRSHRN2 V7.16B, V4.8H, #1
    URSHR  V9.4H, V24.4H, #10
    SHRN V5.8B, V29.8H, #1
    CMGE  D14, D28, #0
    FCMEQ  S8, S30, S16
    AND  V3.8B, V2.8B, V30.8B
    FCVTAU  V5.2D, V23.2D
    BSL  V2.16B, V22.16B, V1.16B
    FCVTZS  V21.2S, V1.2S, #32
    SQSHLU  V9.16B, V12.16B, #0x6
    UABAL2  V3.8H, V15.16B, V16.16B
    FCVTNU  S30, S27
    SSHL  V7.4S, V17.4S, V15.4S
    SMULL V23.4S, V14.4H, V11.H[0x7]
    SRSHR  V21.8H, V24.8H, #5
    SQDMULL V17.2D, V8.2S, V11.S[0x2]
    SSHLL V15.4S, V21.4H, #0xa
    FADDP  V21.4S, V18.4S, V27.4S
    UMAXV  S2, V16.4S
    FACGE  S17, S4, S21
    MOV S12, V18.S[0x3]
    SQRDMULH  V29.8H, V18.8H, V2.H[0x4]
    UQRSHL  B20, B0, B9
    CMHS  D11, D18, D24
    SRHADD  V14.16B, V16.16B, V18.16B
    UADDLV  D5, V10.4S
    MUL  V21.8H, V10.8H, V0.8H
    UMLSL  V0.2D, V4.2S, V24.2S
    SQDMULH  V29.4S, V21.4S, V8.4S
    SQDMLAL  D9, S8, S23
    SUBHN2  V27.4S, V12.2D, V19.2D
    SQDMULH  V15.4H, V23.4H, V24.4H
    FRECPS  V28.4S, V28.4S, V11.4S
    FMLS V1.2S, V17.2S, V18.S[0x0]
    URSRA D11, D30, #43
    SMINP  V22.8B, V20.8B, V24.8B
    UADDLV  H15, V2.16B
    SQRDMULH  S15, S19, S15
    UQSHL  V8.8B, V6.8B, #0x1
    SQRSHRN2 V17.8H, V16.4S, #13
    SMULL V11.4S, V27.4H, V2.H[0x1]
    SMLSL  V12.2D, V31.2S, V5.2S
    FACGE  V30.2D, V1.2D, V31.2D
    XTN2  V14.16B, V5.8H
    FCMGT  D17, D10, D22
    URSRA V17.2D, V0.2D, #42
    FMUL S7, S17, V7.S[0x3]
    FCVTAU  S16, S5
    SQRDMULH  V18.4H, V25.4H, V1.H[0x2]
    SRSRA  V20.8B, V31.8B, #4
    FMAXNMP D8, V29.2D
    RADDHN  V16.4H, V8.4S, V28.4S
    SABDL  V0.2D, V24.2S, V1.2S
    UQSHRN2 V12.16B, V8.8H, #8
    MOV V17.S[0x0], W12
    MOV D2, V25.D[0x0]
    USRA V0.2D, V27.2D, #29
    UADALP  V26.4S, V31.8H
    UXTL V8.8H, V9.8B
    UMULL2  V31.4S, V12.8H, V29.8H
    SQDMULL S9, H10, V5.H[0x6]
    SMULL V12.2D, V5.2S, V25.S[0x1]
    SQSUB  V8.2S, V18.2S, V5.2S
    SQDMULL  S31, H5, H14
    FCVTZU S27, S15, #9
    MOVI  V23.2D, #18446462603011096575
    SMAXP  V11.8H, V9.8H, V20.8H
    FMINP  V2.2D, V31.2D, V26.2D
    FABD  V22.2D, V18.2D, V26.2D
    FMLA D16, D17, V17.D[0x0]
    CMGE  V3.4S, V25.4S, V30.4S
    FCVTPS  V25.4S, V16.4S
    UADDLV  S17, V29.8H
    SQRSHRN V6.8B, V16.8H, #5
    SRI  V31.8H, V27.8H, #13
    SMULL2  V18.8H, V15.16B, V25.16B
    SHRN2 V22.16B, V15.8H, #6
    FCVTZU V19.2D, V5.2D, #36
    FACGE  D2, D18, D16
    SQRSHL  D8, D26, D13
    UMLSL2 V26.4S, V27.8H, V12.H[0x0]
    FABD  D7, D8, D11
    SSHLL2 V8.2D, V6.4S, #0x18
    SQXTUN  H22, S31
    SQSHLU  V18.4S, V3.4S, #0x2
    UMAXV  B10, V27.8B
    SSHLL2 V29.2D, V5.4S, #0x2
    MOV  V31.8B, V23.8B
    UABDL2  V8.2D, V17.4S, V8.4S
    MLA  V2.8B, V10.8B, V26.8B
    INS V31.B[0x4], V2.B[0x5]
    SQDMULL2 V11.2D, V18.4S, V2.S[0x0]
    SMINV  B31, V29.8B
    SUQADD  S11, S23
    SRSHL  D7, D22, D1
    FMAXNM  V6.4S, V19.4S, V1.4S
    INS V27.S[0x2], V14.S[0x0]
    SQADD  V13.2S, V8.2S, V18.2S
    SQNEG  B13, B11
    SQRDMULH H16, H6, V5.H[0x7]
    SLI D6, D18, #0x33
    UQSHL  D14, D31, D25
    UQSHL  V14.16B, V16.16B, #0x0
    SMOV  X8, V9.H[0x0]
    SQXTN  S11, D11
    MOV S11, V12.S[0x2]
    DUP  V19.8H, V17.H[0x6]
    FMINNM  V7.2D, V16.2D, V31.2D
    SSHR  V23.8H, V29.8H, #15
    USHR V26.2D, V12.2D, #26
    SXTL V21.4S, V9.4H
    FCMEQ  S14, S26, S13
    MOV  X7, V17.D[0x1]
    SRSHL  D3, D2, D18
    SMLAL2 V31.2D, V6.4S, V3.S[0x3]
    FCMGT  S30, S31, S31
    SMLSL2  V13.2D, V1.4S, V11.4S
    SRSRA  V25.2S, V10.2S, #25
    FMINNMV  S25, V15.4S
    RBIT  V8.16B, V17.16B
    SQSHRUN V7.2S, V27.2D, #28
    SUQADD  V16.2D, V15.2D
    SUBS  X13, X13, #0x1
    B.NE  TaishanSimdReduceP01_label_1354
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X28, X8, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X13, X11, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X6, X21, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X25, X3, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X7, X5, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X23, X8, X8
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X2, X8, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X22, X7, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X21, X6, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X21, X23, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X2, X11, X14
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X14, X19, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X8, X15, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X28, X7, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X18
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X13, X7, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X21, X12, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X27, X14, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X29, X3, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X7, X5, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X5, X17, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X12, D2
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X4, D3
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X8, D4
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X19, V5.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X23, X22, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X19, D5
    MOVZ  X22, #0x0, LSL #0
    SUB  X23, X22, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X27, X14, X23
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X23, D6
    MOVZ  X14, #0x0, LSL #0
    SUB  X27, X14, X23
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X23, D7
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X6, D8
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X22, V9.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X22, D9
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X14, X22, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X2, D10
    MOVZ  X22, #0x0, LSL #0
    SUB  X14, X22, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X13, D11
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X29, V12.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X3, X22, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X29, D12
    MOVZ  X22, #0x0, LSL #0
    SUB  X3, X22, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X21, V13.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X21, D13
    MOVZ  X18, #0x1, LSL #0
    SUB  X22, X18, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X17, D14
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X20, X16, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X29, D15
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X10, D16
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X2, X15, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X29, D17
    MOVZ  X15, #0x0, LSL #0
    SUB  X2, X15, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X2, D18
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X21, V19.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X21, D19
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X13, D20
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    FMOV  X8, D21
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X14, D22
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X8, D23
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X22, V25.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X8, X28, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X22, D25
    MOVZ  X28, #0x0, LSL #0
    SUB  X8, X28, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X6, D26
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X7, D27
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X19, V28.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7fc0, LSL #16
    MOVK  X17, #0x7fc0, LSL #48
    SUB  X13, X17, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X19, D28
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7fc0, LSL #16
    MOVK  X17, #0x7fc0, LSL #48
    SUB  X13, X17, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    FMOV  X27, D29
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    MOVZ  X2, #0x564, LSL #0
    MOVK  X2, #0x4b43, LSL #16
    MOVK  X2, #0xdd6a, LSL #32
    MOVK  X2, #0xfc0d, LSL #48
    MOVZ  X3, #0x5bfb, LSL #0
    MOVK  X3, #0x1957, LSL #16
    MOVK  X3, #0x679, LSL #32
    MOVK  X3, #0xa40f, LSL #48
    MOVZ  X4, #0x6afc, LSL #0
    MOVK  X4, #0xf32d, LSL #16
    MOVK  X4, #0x4484, LSL #32
    MOVK  X4, #0xad8b, LSL #48
    MOVZ  X5, #0xf3c7, LSL #0
    MOVK  X5, #0x2703, LSL #16
    MOVK  X5, #0xb34b, LSL #32
    MOVK  X5, #0x2638, LSL #48
    MOVZ  X6, #0x160c, LSL #0
    MOVK  X6, #0xa235, LSL #16
    MOVK  X6, #0x981e, LSL #32
    MOVK  X6, #0x2428, LSL #48
    MOVZ  X7, #0x19cc, LSL #0
    MOVK  X7, #0x7e11, LSL #16
    MOVK  X7, #0x4bd2, LSL #32
    MOVK  X7, #0x4e80, LSL #48
    MOVZ  X8, #0xeeec, LSL #0
    MOVK  X8, #0xac3c, LSL #16
    MOVK  X8, #0x8976, LSL #32
    MOVK  X8, #0x2ea2, LSL #48
    MOVZ  X9, #0x3cc, LSL #0
    MOVK  X9, #0x2ae8, LSL #16
    MOVK  X9, #0xe444, LSL #32
    MOVK  X9, #0xbe15, LSL #48
    MOVZ  X10, #0x6279, LSL #0
    MOVK  X10, #0x91fc, LSL #16
    MOVK  X10, #0xcbb3, LSL #32
    MOVK  X10, #0x73b3, LSL #48
    MOVZ  X11, #0x8070, LSL #0
    MOVK  X11, #0xd428, LSL #16
    MOVK  X11, #0x2543, LSL #32
    MOVK  X11, #0xad60, LSL #48
    MOVZ  X12, #0xb14a, LSL #0
    MOVK  X12, #0x40f9, LSL #16
    MOVK  X12, #0x434d, LSL #32
    MOVK  X12, #0xe1f4, LSL #48
    MOVZ  X13, #0x47ec, LSL #0
    MOVK  X13, #0x47bf, LSL #16
    MOVK  X13, #0x6263, LSL #32
    MOVK  X13, #0xdd18, LSL #48
    MOVZ  X14, #0x84d, LSL #0
    MOVK  X14, #0x6115, LSL #16
    MOVK  X14, #0x59cc, LSL #32
    MOVK  X14, #0xcf89, LSL #48
    MOVZ  X15, #0x5336, LSL #0
    MOVK  X15, #0xa05c, LSL #16
    MOVK  X15, #0x8a50, LSL #32
    MOVK  X15, #0x98d0, LSL #48
    MOVZ  X16, #0xc439, LSL #0
    MOVK  X16, #0x87e, LSL #16
    MOVK  X16, #0xbd9d, LSL #32
    MOVK  X16, #0xc690, LSL #48
    MOVZ  X17, #0x1856, LSL #0
    MOVK  X17, #0xc145, LSL #16
    MOVK  X17, #0xce6e, LSL #32
    MOVK  X17, #0x4cb6, LSL #48
    MOVZ  X18, #0x32a2, LSL #0
    MOVK  X18, #0x39a4, LSL #16
    MOVK  X18, #0x7d53, LSL #32
    MOVK  X18, #0x7a5b, LSL #48
    MOVZ  X19, #0x94e3, LSL #0
    MOVK  X19, #0xd3d1, LSL #16
    MOVK  X19, #0xeb4c, LSL #32
    MOVK  X19, #0xae90, LSL #48
    MOVZ  X20, #0xd1, LSL #0
    MOVK  X20, #0x7cb0, LSL #16
    MOVK  X20, #0xa9e3, LSL #32
    MOVK  X20, #0xcd6b, LSL #48
    MOVZ  X21, #0x891, LSL #0
    MOVK  X21, #0x1785, LSL #16
    MOVK  X21, #0xa9bd, LSL #32
    MOVK  X21, #0x1c97, LSL #48
    MOVZ  X22, #0x7677, LSL #0
    MOVK  X22, #0xcde0, LSL #16
    MOVK  X22, #0x1271, LSL #32
    MOVK  X22, #0x6d80, LSL #48
    MOVZ  X23, #0x8a08, LSL #0
    MOVK  X23, #0xa2d1, LSL #16
    MOVK  X23, #0xe4bb, LSL #32
    MOVK  X23, #0xa176, LSL #48
    MOVZ  X25, #0x1503, LSL #0
    MOVK  X25, #0xfdfa, LSL #16
    MOVK  X25, #0x1d05, LSL #32
TaishanSimdReduceP01_label_1002:
    MOVK  X25, #0xe518, LSL #48
    MOVZ  X26, #0xa102, LSL #0
    MOVK  X26, #0x979c, LSL #16
    MOVK  X26, #0xce96, LSL #32
    MOVK  X26, #0x170e, LSL #48
    MOVZ  X27, #0x228d, LSL #0
    MOVK  X27, #0xcaf7, LSL #16
    MOVK  X27, #0x9290, LSL #32
    MOVK  X27, #0xb379, LSL #48
    MOVZ  X28, #0xe04, LSL #0
    MOVK  X28, #0x1d69, LSL #16
    MOVK  X28, #0x6605, LSL #32
    MOVK  X28, #0x6d6e, LSL #48
    MOVZ  X29, #0x76cf, LSL #0
    MOVK  X29, #0xa5cf, LSL #16
    MOVK  X29, #0x29ce, LSL #32
    MOVK  X29, #0x5284, LSL #48
    FMOV  D0, X12
    FMOV  V0.D[1], X17
    FMOV  D1, X28
    FMOV  V1.D[1], X17
    FMOV  D2, X18
    FMOV  V2.D[1], X25
    FMOV  D3, X23
    FMOV  V3.D[1], X29
    FMOV  D4, X11
    FMOV  V4.D[1], X25
    FMOV  D5, X6
    FMOV  V5.D[1], X5
    FMOV  D6, X23
    FMOV  V6.D[1], X20
    FMOV  D7, X5
    FMOV  V7.D[1], X22
    FMOV  D8, X15
    FMOV  V8.D[1], X17
    FMOV  D9, X29
    FMOV  V9.D[1], X3
    FMOV  D10, X4
    FMOV  V10.D[1], X12
    FMOV  D11, X10
    FMOV  V11.D[1], X9
    FMOV  D12, X18
    FMOV  V12.D[1], X8
    FMOV  D13, X22
    FMOV  V13.D[1], X29
    FMOV  D14, X4
    FMOV  V14.D[1], X28
    FMOV  D15, X14
    FMOV  V15.D[1], X21
    FMOV  D16, X12
    FMOV  V16.D[1], X10
    FMOV  D17, X8
    FMOV  V17.D[1], X19
    FMOV  D18, X15
    FMOV  V18.D[1], X22
    FMOV  D19, X21
    FMOV  V19.D[1], X8
    FMOV  D20, X25
    FMOV  V20.D[1], X5
    FMOV  D21, X13
    FMOV  V21.D[1], X21
    FMOV  D22, X10
    FMOV  V22.D[1], X22
    FMOV  D23, X21
    FMOV  V23.D[1], X25
    FMOV  D24, X5
    FMOV  V24.D[1], X20
    FMOV  D25, X27
    FMOV  V25.D[1], X12
    FMOV  D26, X18
    FMOV  V26.D[1], X29
    FMOV  D27, X14
    FMOV  V27.D[1], X28
    FMOV  D28, X19
    FMOV  V28.D[1], X7
    FMOV  D29, X20
    FMOV  V29.D[1], X3
    FMOV  D30, X5
    FMOV  V30.D[1], X22
    FMOV  D31, X29
    FMOV  V31.D[1], X6
    MOVZ  X16, #0xa, LSL #0
TaishanSimdReduceP01_label_1428:
    SQXTUN  H12, S6
    SRHADD  V24.8H, V3.8H, V27.8H
    SSHR  V31.8B, V9.8B, #7
    FCMLT  D17, D25, #0.0
    SSHLL V26.8H, V2.8B, #0x7
    FRSQRTE  S10, S27
    UMLAL  V5.4S, V28.4H, V5.4H
    UQXTN  S14, D3
    FADDP  V29.4S, V13.4S, V10.4S
    SADDL2  V23.2D, V25.4S, V16.4S
    SADDLV  S30, V26.4H
    SQRSHRUN2 V16.8H, V21.4S, #15
    UQRSHL  H7, H5, H31
    SHL V27.2D, V14.2D, #0x1e
    DUP V11.2S, W10
    CMGE  D5, D20, D11
    FRECPE  D8, D24
    SSUBL  V26.2D, V8.2S, V5.2S
    ADDV  S9, V17.4S
    SQRSHL  D9, D28, D3
    UCVTF V5.2D, V26.2D, #21
    SQSHRUN H8, S21, #9
    FMOV  V26.4S, #12.50000000
    SQSHRN V6.8B, V23.8H, #5
    UADDW2  V29.4S, V28.4S, V25.8H
    SUQADD  V7.4H, V2.4H
    UQSHRN2 V16.4S, V15.2D, #2
    UQSHL  B4, B30, B16
    FMLS V7.2D, V23.2D, V18.D[0x0]
    SQRSHRUN2 V13.16B, V21.8H, #2
    FCVTNS  D31, D24
    USUBW  V23.4S, V3.4S, V17.4H
    SADDL2  V18.8H, V5.16B, V13.16B
    FCVTZS  S30, S25
    UMULL V8.2D, V4.2S, V16.S[0x0]
    FMUL S24, S2, V22.S[0x1]
    SMIN  V9.2S, V25.2S, V15.2S
    UMAXV  B7, V12.8B
    SQDMULH  V15.8H, V26.8H, V8.H[0x1]
    FACGT  D14, D6, D6
    FCVTMU  V19.2S, V14.2S
    SMULL V29.4S, V24.4H, V2.H[0x4]
    MOV  W7, V8.S[0x3]
    UMINV  S31, V17.4S
    UMLAL V30.4S, V31.4H, V9.H[0x1]
    FCMGT  V17.2S, V4.2S, #0.0
    UMINV  H23, V12.4H
    UCVTF  S28, S1
    UQSHL  V28.4S, V18.4S, #0xd
    URSHR  V16.4H, V29.4H, #10
    MVNI  V3.2S, #0x90, MSL #16
    SMLSL  V14.8H, V3.8B, V10.8B
    UABD  V17.8H, V14.8H, V16.8H
    UCVTF  V7.2D, V20.2D
    UQSHL  V19.16B, V0.16B, #0x7
    SQSHRN V7.8B, V15.8H, #5
    FCVTAU  V27.2D, V4.2D
    ABS  V19.8H, V9.8H
    FCVTMU  D30, D9
    ADD  D22, D2, D6
    SRSRA  V6.16B, V28.16B, #6
    SMOV  X10, V31.S[0x1]
    FCVTNU  D25, D10
    USQADD  H9, H10
    CMGT  D16, D28, D24
    SSRA  V18.8H, V27.8H, #4
    SSRA  V12.8B, V19.8B, #3
    UXTL2 V9.4S, V7.8H
    FACGE  D27, D18, D8
    SQSHL B17, B22, #0x1
    ADDV  B17, V29.8B
    SQDMLAL  S16, H10, H5
    SADDLV  S4, V25.8H
    SQDMULL2 V31.4S, V4.8H, V7.H[0x0]
    URSHR D8, D27, #26
    SQDMLAL  S21, H23, H18
    FDIV  V6.2D, V6.2D, V7.2D
    SQRSHRN V31.4H, V29.4S, #14
    UMINV  H4, V12.4H
    MOVI  V14.4S, #0xd2
    MUL  V2.2S, V31.2S, V25.2S
    FCMGE  V9.2S, V6.2S, V31.2S
    NOT  V17.8B, V24.8B
    SSHR  V29.4S, V16.4S, #10
    UMULL2  V11.2D, V22.4S, V6.4S
    FABD  S8, S9, S29
    SHLL2  V9.4S, V4.8H, #16
    UMAX  V9.8B, V31.8B, V15.8B
    ORR  V24.4H, #0xcd
    SQSUB  D1, D2, D21
    SQSUB  B7, B2, B31
    ZIP2  V17.4H, V12.4H, V24.4H
    UQSHRN V25.4H, V18.4S, #13
    UCVTF D8, D20, #12
    URSRA  V25.8H, V29.8H, #3
    UQRSHRN2 V26.16B, V18.8H, #7
    SSHLL2 V5.4S, V17.8H, #0xc
    FCVTZS D5, D22, #11
    UMINV  S22, V27.4S
    FCVTZS  V10.4S, V15.4S
    FACGE  V9.2D, V4.2D, V26.2D
    MOV  W2, V16.S[0x3]
    CMGT  D6, D19, #0
    SSHLL V4.8H, V9.8B, #0x2
    SMULL2 V24.4S, V7.8H, V8.H[0x5]
    FCVTZS  S31, S7
    FSUB  V11.4S, V2.4S, V10.4S
    FCVTPS  S26, S0
    SQDMULH  S4, S18, S28
    UQSHL D3, D14, #0x2e
    SQSHL V26.2D, V4.2D, #0x27
    UQRSHRN2 V11.16B, V5.8H, #5
    FRINTP  V9.2D, V8.2D
    SHLL2  V6.8H, V15.16B, #8
    UHSUB  V15.8H, V3.8H, V23.8H
    SCVTF V30.2D, V15.2D, #46
    FRSQRTE  S8, S28
    DUP V16.8H, W27
    SQXTUN  V17.2S, V14.2D
    FCMEQ  D27, D17, #0.0
    FCMEQ  S11, S12, S7
    SQSHL  D19, D14, D19
    CMLE  V19.8B, V12.8B, #0
    URSHR  V11.2S, V0.2S, #18
    DUP V10.2D, X11
TaishanSimdReduceP01_label_1125:
    MVNI  V8.4H, #0x9f, LSL #8
    UMLAL2  V4.4S, V9.8H, V0.8H
    FCVTNS  D17, D17
    SMOV  X17, V4.H[0x4]
    SQSHRUN2 V30.4S, V0.2D, #14
    FCVTNU  S17, S8
    URSHR  V25.4H, V4.4H, #11
    PMULL2  V23.1Q, V8.2D, V23.2D
    FMAXNMP D25, V7.2D
    UQXTN2  V17.16B, V23.8H
    SSRA D14, D17, #7
    SUQADD  S16, S28
    SMOV W18, V16.H[0x5]
    MUL  V8.4S, V9.4S, V9.4S
    INS V14.B[0x2], W12
    SMOV  X22, V29.S[0x1]
    SQDMULL  S26, H22, H4
    SADDL  V1.4S, V24.4H, V9.4H
    SQDMULL2 V25.2D, V2.4S, V14.S[0x1]
    FCVTPS  V8.4S, V10.4S
    CMGT  D29, D30, D5
    FCMLE  S8, S29, #0.0
    SQDMULL V15.4S, V8.4H, V12.H[0x1]
    SQXTN  H25, S17
    SQRSHRN H15, S14, #4
    UHADD  V11.2S, V31.2S, V4.2S
    UMLSL  V6.2D, V4.2S, V19.2S
    SRSHL  V5.2D, V22.2D, V23.2D
    SQRDMULH S5, S25, V22.S[0x1]
    FMINP D1, V19.2D
    CMLT  D27, D20, #0
    SMINP  V5.4S, V26.4S, V11.4S
    SRSHR  V1.4S, V15.4S, #26
    FCVTNU  V14.2S, V1.2S
    SQSHRN2 V14.4S, V26.2D, #21
    SMULL  V17.8H, V20.8B, V23.8B
    SSHLL V6.2D, V15.2S, #0x1e
    UQSUB  S10, S6, S25
    CMEQ  D16, D16, D13
    UQADD  V20.4S, V27.4S, V20.4S
    FCVTXN  S17, D5
    FMAXP D10, V21.2D
    USHR V14.2D, V12.2D, #9
    UQSHRN V9.2S, V31.2D, #1
    AND  V23.8B, V4.8B, V16.8B
    FCVTNU  V5.2S, V23.2S
    UQSHL  H2, H23, H29
    CMGE  D2, D7, #0
    SRSHR V5.2D, V31.2D, #13
    SXTL2 V17.4S, V9.8H
    SQNEG  S31, S10
    SABAL2  V23.2D, V14.4S, V15.4S
    UQXTN2  V4.16B, V20.8H
    UABAL2  V26.2D, V14.4S, V4.4S
    FMUL D2, D12, V2.D[0x1]
    UADDLP  V9.2S, V31.4H
    SADDL2  V8.4S, V7.8H, V21.8H
    SHRN V5.8B, V25.8H, #7
    UQADD  S16, S12, S13
    SMLSL V14.2D, V7.2S, V13.S[0x2]
    MVNI  V25.4S, #0x56, MSL #8
    USUBW  V11.8H, V10.8H, V9.8B
    SADDLV  D25, V11.4S
    FCVTZS  V4.2D, V20.2D
    FADDP  V15.4S, V29.4S, V11.4S
    SQDMLAL  D13, S15, S4
    CNT  V25.8B, V9.8B
    SQSHL D17, D0, #0x1b
    FCVTAU  D13, D4
    SQDMLSL V29.2D, V10.2S, V13.S[0x1]
    FCVTZU  V9.4S, V13.4S, #26
    FABD  S14, S19, S4
    MVN  V8.8B, V4.8B
    URSRA D5, D23, #64
    URSHR  V13.16B, V25.16B, #2
    SUBS  X16, X16, #0x1
    B.NE  TaishanSimdReduceP01_label_1428
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X13, #0x5bfb, LSL #0
    MOVK  X13, #0x1957, LSL #16
    MOVK  X13, #0x679, LSL #32
    MOVK  X13, #0xa40f, LSL #48
    SUB  X3, X13, X3
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    MOVZ  X6, #0x6afc, LSL #0
    MOVK  X6, #0xf32d, LSL #16
    MOVK  X6, #0x4484, LSL #32
    MOVK  X6, #0xad8b, LSL #48
    SUB  X7, X6, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    MOVZ  X16, #0xf3c7, LSL #0
    MOVK  X16, #0x2703, LSL #16
    MOVK  X16, #0xb34b, LSL #32
    MOVK  X16, #0x2638, LSL #48
    SUB  X10, X16, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    MOVZ  X2, #0x6afc, LSL #0
    MOVK  X2, #0xf32d, LSL #16
    MOVK  X2, #0x4484, LSL #32
    MOVK  X2, #0xad8b, LSL #48
    SUB  X26, X2, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X21, X20, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0x3cc, LSL #0
    MOVK  X7, #0x2ae8, LSL #16
    MOVK  X7, #0xe444, LSL #32
    MOVK  X7, #0xbe15, LSL #48
    SUB  X28, X7, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X8, X21, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X20, #0x8070, LSL #0
    MOVK  X20, #0xd428, LSL #16
    MOVK  X20, #0x2543, LSL #32
    MOVK  X20, #0xad60, LSL #48
    SUB  X19, X20, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    MOVZ  X26, #0xb14a, LSL #0
    MOVK  X26, #0x40f9, LSL #16
    MOVK  X26, #0x434d, LSL #32
    MOVK  X26, #0xe1f4, LSL #48
    SUB  X14, X26, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    MOVZ  X2, #0x5bfb, LSL #0
    MOVK  X2, #0x1957, LSL #16
    MOVK  X2, #0x679, LSL #32
    MOVK  X2, #0xa40f, LSL #48
    SUB  X5, X2, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    MOVZ  X8, #0x5336, LSL #0
    MOVK  X8, #0xa05c, LSL #16
    MOVK  X8, #0x8a50, LSL #32
    MOVK  X8, #0x98d0, LSL #48
    SUB  X2, X8, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    MOVZ  X9, #0xf3c7, LSL #0
    MOVK  X9, #0x2703, LSL #16
    MOVK  X9, #0xb34b, LSL #32
    MOVK  X9, #0x2638, LSL #48
    SUB  X6, X9, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X25, X5, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X27, X3, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X26, X2, X22
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    MOVZ  X11, #0x8a08, LSL #0
    MOVK  X11, #0xa2d1, LSL #16
    MOVK  X11, #0xe4bb, LSL #32
    MOVK  X11, #0xa176, LSL #48
    SUB  X18, X11, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X14, X12, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    MOVZ  X23, #0x76cf, LSL #0
    MOVK  X23, #0xa5cf, LSL #16
    MOVK  X23, #0x29ce, LSL #32
    MOVK  X23, #0x5284, LSL #48
    SUB  X19, X23, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    FMOV  X8, D2
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    FMOV  X19, V3.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X19, D3
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X18, D4
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X17, D5
    MOVZ  X9, #0xff, LSL #0
    SUB  X16, X9, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X4, D6
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xc000, LSL #16
    MOVK  X18, #0x1fff, LSL #32
    SUB  X11, X18, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X25, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X28, X19, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X25, D7
    MOVZ  X19, #0x0, LSL #0
    SUB  X28, X19, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X9, X12, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X16, D8
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X9, X12, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X15, V9.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X15, D9
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X17, D10
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X20, D11
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X17, X28, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X20, D12
    MOVZ  X28, #0x0, LSL #0
    SUB  X17, X28, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X2, D13
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X12, D14
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7fc0, LSL #16
    SUB  X2, X19, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X19, V15.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X19, D15
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    SUB  X27, X20, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X18, D16
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X2, D17
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #48
    SUB  X7, X16, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xfffe, LSL #16
    MOVK  X5, #0xff8f, LSL #32
    MOVK  X5, #0x40, LSL #48
    SUB  X22, X5, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X17, D18
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    SUB  X22, X5, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X7, D19
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X21, X5, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X19, V20.D[1]
    MOVZ  X8, #0xf3c7, LSL #0
    MOVK  X8, #0x2703, LSL #16
    MOVK  X8, #0xb34b, LSL #32
    MOVK  X8, #0x2638, LSL #48
    SUB  X11, X8, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X19, D20
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X11, X8, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X19, X7, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X23, D21
    MOVZ  X7, #0x47ec, LSL #0
    MOVK  X7, #0x47bf, LSL #16
    SUB  X19, X7, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X12, D22
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X28, D23
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X8, D25
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X22, V26.D[1]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X29, X7, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X22, D26
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X29, X7, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X4, D27
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X4, X16, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X20, D28
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X4, X16, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X10, X28, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X14, D29
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X10, X28, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X15
    FMOV  V0.D[1], X8
    FMOV  D1, X29
    FMOV  V1.D[1], X7
    FMOV  D2, X22
    FMOV  V2.D[1], X20
    FMOV  D3, X11
    FMOV  V3.D[1], X27
    FMOV  D4, X4
    FMOV  V4.D[1], X25
    FMOV  D5, X29
    FMOV  V5.D[1], X27
    FMOV  D6, X8
    FMOV  V6.D[1], X8
    FMOV  D7, X6
    FMOV  V7.D[1], X20
    FMOV  D8, X3
    FMOV  V8.D[1], X2
    FMOV  D9, X18
    FMOV  V9.D[1], X8
    FMOV  D10, X18
    FMOV  V10.D[1], X6
    FMOV  D11, X3
    FMOV  V11.D[1], X15
    FMOV  D12, X18
    FMOV  V12.D[1], X26
    FMOV  D13, X26
    FMOV  V13.D[1], X25
    FMOV  D14, X29
    FMOV  V14.D[1], X5
    FMOV  D15, X4
    FMOV  V15.D[1], X28
    FMOV  D16, X2
TaishanSimdReduceP01_label_378:
    FMOV  V16.D[1], X9
    FMOV  D17, X23
    FMOV  V17.D[1], X12
    FMOV  D18, X11
    FMOV  V18.D[1], X26
    FMOV  D19, X22
    FMOV  V19.D[1], X18
    FMOV  D20, X29
    FMOV  V20.D[1], X25
    FMOV  D21, X9
    FMOV  V21.D[1], X5
    FMOV  D22, X25
    FMOV  V22.D[1], X11
    FMOV  D23, X9
    FMOV  V23.D[1], X7
    FMOV  D24, X17
    FMOV  V24.D[1], X12
    FMOV  D25, X3
    FMOV  V25.D[1], X19
    FMOV  D26, X17
    FMOV  V26.D[1], X7
    FMOV  D27, X16
    FMOV  V27.D[1], X22
    FMOV  D28, X18
    FMOV  V28.D[1], X23
    FMOV  D29, X4
    FMOV  V29.D[1], X25
    FMOV  D30, X5
    FMOV  V30.D[1], X17
    FMOV  D31, X15
    FMOV  V31.D[1], X2
    MOVZ  X11, #0xa, LSL #0
TaishanSimdReduceP01_label_1502:
    URSHR  V11.8H, V30.8H, #2
    SADDLV  D25, V12.4S
    UQSHRN H9, S25, #5
    USUBL2  V20.4S, V31.8H, V24.8H
    URSHR  V27.8B, V29.8B, #5
    SADDW  V3.4S, V19.4S, V5.4H
    CMHS  D8, D14, D17
    SADDW  V11.2D, V15.2D, V30.2S
    SMULL2 V3.2D, V24.4S, V4.S[0x3]
    UHSUB  V1.2S, V11.2S, V16.2S
    SQABS  H3, H14
    USHLL V26.2D, V9.2S, #0xb
    UADDW2  V20.2D, V10.2D, V3.4S
    FDIV  V30.2S, V27.2S, V3.2S
    FCVTMU  V25.2D, V28.2D
    REV32  V16.8B, V0.8B
    FMLS V21.2D, V18.2D, V0.D[0x0]
    CMHS  D10, D15, D17
    UHADD  V25.16B, V6.16B, V26.16B
    ZIP2  V2.2D, V20.2D, V22.2D
    FMINNMV  S1, V1.4S
    FADD  V25.4S, V30.4S, V16.4S
    SQRSHRN2 V19.4S, V12.2D, #14
    CMEQ  V30.4H, V14.4H, V0.4H
    SLI  V9.8H, V0.8H, #0x8
    SMOV  X17, V16.S[0x2]
    SQRSHRUN V26.2S, V4.2D, #29
    SQDMLAL V6.4S, V1.4H, V6.H[0x7]
    SMLAL2 V14.2D, V6.4S, V8.S[0x2]
    USHR  V15.8B, V14.8B, #6
    CMEQ  V8.8B, V30.8B, V9.8B
    SQSUB  B1, B14, B12
    SHLL2  V30.8H, V12.16B, #8
    CMLT  D13, D8, #0
    MOVI  V20.2S, #0xe7, MSL #16
    SHRN V7.2S, V26.2D, #11
    SQRSHL  D5, D23, D14
    SQRDMULH S30, S21, V26.S[0x1]
    SQRSHRUN S2, D5, #7
    UQSHL  V22.16B, V2.16B, V16.16B
    SQXTN  B23, H27
    SQXTUN  H6, S3
    FCVTNS  S9, S14
    MLS  V21.8H, V8.8H, V30.8H
    UMLSL2  V6.4S, V4.8H, V26.8H
    SQXTN  S31, D3
    SQSHLU H27, H25, #0x0
    UADDW  V26.4S, V28.4S, V12.4H
    DUP  V3.4S, V0.S[0x3]
    SQRSHRN2 V8.16B, V26.8H, #4
    FMLS V12.4S, V28.4S, V25.S[0x3]
    UQXTN  S8, D27
    USQADD  H5, H5
    SRI V2.2D, V18.2D, #5
    RSHRN V5.8B, V0.8H, #6
    FCMGT  D26, D27, D14
    SXTL V16.8H, V2.8B
    SQNEG  V23.2D, V14.2D
    SHRN V3.8B, V5.8H, #4
    UQSUB  B30, B16, B6
    SRSRA D7, D13, #7
    FMLA D12, D1, V7.D[0x1]
    SQSHL  V25.4S, V25.4S, #0x2
    SQRSHRUN2 V0.4S, V12.2D, #13
    SRI  V1.16B, V29.16B, #4
    SMIN  V18.2S, V11.2S, V23.2S
    FCVTNS  V12.2S, V18.2S
    MLA  V24.4H, V13.4H, V10.H[0x7]
    CMGE  D29, D26, #0
    SHADD  V29.8H, V12.8H, V29.8H
    UQSHRN H14, S2, #6
    SQRDMULH  H3, H28, H29
    UMAXP  V26.8B, V24.8B, V1.8B
    INS V21.D[0x1], X7
    USHLL V6.8H, V24.8B, #0x1
    SQDMULL  D12, S15, S30
    FCVTPS  S9, S19
    SQSHRN S22, D14, #20
    SQADD  S16, S22, S26
    FRINTP  V2.2S, V26.2S
    FCMEQ  V17.4S, V12.4S, #0.0
    SQSHRUN V1.2S, V3.2D, #32
    SMAXV  H1, V11.8H
    SQDMULL D27, S11, V8.S[0x3]
    SMOV  X3, V8.H[0x4]
    UXTL V8.8H, V10.8B
    FRINTP  V25.2D, V18.2D
    DUP V17.2S, W6
    URSQRTE  V10.4S, V0.4S
    SRSRA D7, D23, #35
    SRI  V1.8H, V30.8H, #4
    URSHR  V2.8H, V1.8H, #12
    UMOV W26, V18.H[0x6]
    FCMEQ  D30, D13, D12
    ADDV  S30, V21.4S
    SSHL  D7, D24, D7
    URSHL  D3, D1, D5
    SQSHRN V23.4H, V18.4S, #14
    RSHRN2 V22.8H, V30.4S, #1
    FMLA S3, S12, V15.S[0x1]
    FMAXNMV  S22, V15.4S
    UMOV W14, V17.S[0x2]
    SQSHL  V7.2S, V11.2S, V2.2S
    UQXTN  V25.2S, V14.2D
    UCVTF S11, S23, #24
    SQDMLSL V3.2D, V14.2S, V13.S[0x0]
    USQADD  B30, B27
    CMGE  V23.8B, V30.8B, #0
    AND  V6.8B, V1.8B, V30.8B
    MOV V12.H[0x2], W11
    SHSUB  V8.16B, V5.16B, V15.16B
    SQDMULH  H17, H18, H25
    SABA  V10.4S, V30.4S, V26.4S
    SUB  V18.4H, V15.4H, V16.4H
    SQRSHRUN V5.4H, V19.4S, #8
    URSHR V7.2D, V16.2D, #23
    SQSHL D11, D13, #0x28
    SQDMLSL2 V3.2D, V27.4S, V6.S[0x3]
    UMINP  V16.8H, V2.8H, V11.8H
    SQXTN2  V29.8H, V24.4S
    FCMGE  V12.2S, V8.2S, V23.2S
    UQSHL  V1.16B, V3.16B, #0x3
    UQRSHRN V17.2S, V19.2D, #22
    NOT  V19.16B, V3.16B
    SQNEG  V7.4S, V16.4S
    USHLL2 V4.2D, V24.4S, #0x16
    DUP B10, V10.B[0x2]
    FMULX D10, D23, V3.D[0x0]
    FMULX  V10.4S, V24.4S, V0.4S
    CMTST  V0.2D, V18.2D, V16.2D
    UCVTF  V27.2D, V30.2D
    SQRDMULH  S17, S7, S14
    SMLSL V30.2D, V26.2S, V16.S[0x1]
    SQRSHL  B12, B4, B8
    SQNEG  D30, D17
    SQDMLSL D27, S26, V1.S[0x1]
    UMINV  H29, V2.4H
    SHL D0, D19, #0xe
    CMLE  D16, D18, #0
    SRSHR  V10.16B, V18.16B, #8
    SQDMULL S31, H15, V1.H[0x2]
    SCVTF  S0, S28
    FACGE  S14, S14, S0
    SQDMLAL2 V6.4S, V30.8H, V4.H[0x0]
    SQSHLU  V13.16B, V18.16B, #0x6
    FMINP S3, V13.2S
    FCMGT  D21, D9, D0
    UMOV W10, V17.H[0x6]
    SMLSL V30.2D, V9.2S, V9.S[0x2]
    UMINV  B17, V27.8B
    FMULX  D29, D0, D26
    SXTL2 V1.4S, V4.8H
    UABDL2  V28.8H, V3.16B, V1.16B
    SQSHRUN H26, S29, #12
    DUP H6, V5.H[0x1]
    CNT  V30.8B, V28.8B
    MOVI  V18.4S, #0x74, MSL #8
    SXTL V1.8H, V27.8B
    SQDMLSL V15.2D, V16.2S, V9.S[0x0]
    UXTL2 V15.4S, V30.8H
    UMLAL V4.4S, V25.4H, V12.H[0x4]
    FRINTA  V17.2S, V17.2S
    SXTL2 V11.8H, V18.16B
    SXTL2 V28.8H, V14.16B
    MOVI  D26, #71776119077928960
    UHADD  V17.8H, V19.8H, V9.8H
    BIC  V6.2S, #0xe0, LSL #16
    ADDV  B9, V8.16B
    USUBL2  V12.4S, V11.8H, V28.8H
    INS V12.B[0x9], V29.B[0x1]
    UABAL  V24.8H, V5.8B, V13.8B
    UMOV W16, V21.B[0x1]
    SMOV  X10, V11.B[0xa]
    SSRA  V3.16B, V14.16B, #3
    SMLSL2 V25.2D, V17.4S, V29.S[0x3]
    UQSHRN B13, H10, #4
    SSHL  V3.8H, V14.8H, V17.8H
    FCMGE  V0.2S, V0.2S, V19.2S
    FCVTZU D6, D4, #24
    MOV V2.H[0x5], V27.H[0x7]
    FRECPS  D27, D2, D24
    SMOV  X2, V14.B[0x4]
    FCVTZU  V27.2S, V25.2S, #10
    SQRSHRUN2 V3.4S, V21.2D, #21
    FCMGE  V3.2D, V3.2D, V4.2D
    FMLS S7, S9, V25.S[0x2]
    CMHS  D24, D15, D6
    USHLL V13.2D, V31.2S, #0x5
    FCVTNS  D27, D0
    SQSHRUN V13.2S, V21.2D, #7
    SQDMLSL D5, S27, V15.S[0x3]
    UQSHL S25, S10, #0x9
    FCVTMU  V6.2S, V9.2S
    SRI  V29.8B, V10.8B, #8
    SQRSHRN S7, D24, #15
    UMLAL  V3.8H, V14.8B, V25.8B
    UQXTN  S9, D24
    SQRSHRN2 V2.4S, V12.2D, #22
    UABDL  V27.8H, V4.8B, V2.8B
    FCVTPU  D5, D22
    SUBS  X11, X11, #0x1
    B.NE  TaishanSimdReduceP01_label_1502
    MOVZ  X20, #0x0, LSL #0
    SUB  X2, X20, X2
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X19, X7, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0x74, LSL #0
    SUB  X8, X7, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X25, X5, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X20, X28, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X27, X25, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X19, X11, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X23
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X14, X29, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X29
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X22, #0xd000, LSL #0
    MOVK  X22, #0x1, LSL #16
    SUB  X23, X22, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X9, D2
    MOVZ  X22, #0x0, LSL #0
    SUB  X23, X22, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X5, V3.D[1]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X19, X9, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X5, D3
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X19, X9, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X20, D4
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X25, V5.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X25, D5
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X14, D6
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X29, D7
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X22, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X22, D8
    MOVZ  X6, #0xfefe, LSL #0
    MOVK  X6, #0xfefe, LSL #16
    SUB  X29, X6, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X21, X14, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X3, D9
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X21, X14, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X19, V10.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X19
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X19, D10
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X19
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0x74, LSL #16
    SUB  X13, X17, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X28, D11
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0x74, LSL #16
    SUB  X13, X17, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X17, X14, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X8, D12
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0x74, LSL #32
    SUB  X17, X14, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdReduceP01_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X4, D13
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X2, D14
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X21, X25, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X8, D15
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X19, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X19, D16
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdReduceP01_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X5, #0x7fff, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    MOVK  X5, #0x7fff, LSL #32
    MOVK  X5, #0x7fff, LSL #48
    SUB  X21, X5, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X3, D17
    MOVZ  X5, #0x7fff, LSL #0
    MOVK  X5, #0x3fff, LSL #16
    MOVK  X5, #0x7fff, LSL #32
    MOVK  X5, #0x7fff, LSL #48
    SUB  X21, X5, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X23, #0x74ff, LSL #0
    MOVK  X23, #0x74ff, LSL #32
    SUB  X20, X23, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X27, D18
    MOVZ  X23, #0x74ff, LSL #0
    MOVK  X23, #0x74ff, LSL #32
    SUB  X20, X23, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X25, X8, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    FMOV  X9, D19
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0x7fff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X25, X8, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X17, D20
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xe7, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xe7, LSL #48
    SUB  X6, X19, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X9, D21
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X4, D22
    MOVZ  X15, #0x303, LSL #0
    MOVK  X15, #0x303, LSL #16
    SUB  X8, X15, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X14, D23
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X10, X22, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X29, V25.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X29, D25
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X28, X19, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X15, D26
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xff, LSL #16
    MOVK  X19, #0xff, LSL #48
    SUB  X28, X19, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X26
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X26, D27
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X26
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X4, D28
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X15, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X15, D29
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
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
    FMOV  V0.D[1], X28
    FMOV  D1, X20
    FMOV  V1.D[1], X27
    FMOV  D2, X9
    FMOV  V2.D[1], X22
    FMOV  D3, X22
    FMOV  V3.D[1], X19
    FMOV  D4, X29
    FMOV  V4.D[1], X11
    FMOV  D5, X8
    FMOV  V5.D[1], X13
    FMOV  D6, X22
    FMOV  V6.D[1], X25
    FMOV  D7, X23
    FMOV  V7.D[1], X3
    FMOV  D8, X10
    FMOV  V8.D[1], X22
    FMOV  D9, X17
    FMOV  V9.D[1], X9
    FMOV  D10, X23
    FMOV  V10.D[1], X16
    FMOV  D11, X27
    FMOV  V11.D[1], X10
    FMOV  D12, X25
    FMOV  V12.D[1], X20
    FMOV  D13, X21
    FMOV  V13.D[1], X11
    FMOV  D14, X21
    FMOV  V14.D[1], X11
    FMOV  D15, X17
    FMOV  V15.D[1], X4
    FMOV  D16, X18
    FMOV  V16.D[1], X28
    FMOV  D17, X11
    FMOV  V17.D[1], X10
    FMOV  D18, X2
    FMOV  V18.D[1], X10
    FMOV  D19, X5
    FMOV  V19.D[1], X12
    FMOV  D20, X3
    FMOV  V20.D[1], X28
    FMOV  D21, X17
    FMOV  V21.D[1], X13
    FMOV  D22, X4
    FMOV  V22.D[1], X4
    FMOV  D23, X27
    FMOV  V23.D[1], X29
    FMOV  D24, X4
    FMOV  V24.D[1], X25
    FMOV  D25, X17
    FMOV  V25.D[1], X2
    FMOV  D26, X19
    FMOV  V26.D[1], X12
    FMOV  D27, X22
    FMOV  V27.D[1], X14
    FMOV  D28, X23
    FMOV  V28.D[1], X28
    FMOV  D29, X14
    FMOV  V29.D[1], X29
    FMOV  D30, X29
    FMOV  V30.D[1], X20
    FMOV  D31, X29
    FMOV  V31.D[1], X10
    MOVZ  X4, #0xf, LSL #0
TaishanSimdReduceP01_label_1579:
    UQSHRN2 V29.8H, V16.4S, #9
    DUP H1, V27.H[0x5]
    MOV V24.D[0x1], V6.D[0x0]
    SRSRA  V18.8H, V14.8H, #8
    SMLSL V25.4S, V0.4H, V12.H[0x4]
    UMULL V26.4S, V26.4H, V1.H[0x0]
    SQSHL  V28.8H, V2.8H, V24.8H
    FMAXNM  V3.4S, V19.4S, V31.4S
    SQABS  H17, H25
    SQABS  H18, H17
    USHL  V3.4H, V15.4H, V23.4H
    SSRA  V23.4H, V10.4H, #11
    FCVTPU  V4.2D, V28.2D
    SSHR  V18.4H, V16.4H, #5
    UQSHL B4, B17, #0x0
    SADDW2  V0.2D, V26.2D, V16.4S
    FRINTZ  V30.2D, V5.2D
    FCVTMU  D0, D16
    UCVTF V18.2D, V28.2D, #55
    URSHR  V7.8H, V19.8H, #16
    UQADD  H8, H16, H3
    URSHR V5.2D, V30.2D, #15
    SHSUB  V19.4H, V4.4H, V28.4H
    ADDV  H2, V19.4H
    FCMGE  S0, S2, #0.0
    UQSHRN V0.2S, V0.2D, #6
    SMOV W26, V5.B[0xc]
    FCVTNS  V23.2D, V2.2D
    SRI  V14.4S, V18.4S, #23
    FCVTXN  S28, D8
    CMHI  V13.16B, V16.16B, V20.16B
    XTN  V10.2S, V26.2D
    DUP V2.2D, X2
    UXTL V0.8H, V2.8B
    UQSUB  S10, S22, S11
    UQADD  S30, S0, S20
    URSHR  V20.16B, V22.16B, #1
    UQSHL H5, H8, #0xe
    SUQADD  S17, S4
    SQSHRUN V3.2S, V27.2D, #32
    SQSHRUN2 V7.16B, V27.8H, #7
    UMINV  H7, V10.4H
    FRECPS  V20.2D, V27.2D, V30.2D
    USUBL2  V8.8H, V13.16B, V3.16B
    SQDMLAL V4.2D, V5.2S, V0.S[0x3]
    UQADD  D7, D16, D27
    FCMLT  S2, S10, #0.0
    FMAXNMP S23, V12.2S
    UABDL  V4.2D, V18.2S, V7.2S
    FCVTNS  D20, D8
    FADDP S2, V16.2S
    UQSHL  B12, B20, B28
    SSHR  V8.4S, V17.4S, #17
    UQSUB  S12, S25, S7
    FCVTAS  V23.4S, V1.4S
    SQDMULH  V23.4H, V20.4H, V0.H[0x6]
    SQSHRN B13, H2, #2
    UQSHL  V16.8B, V6.8B, #0x0
    UABA  V12.16B, V7.16B, V21.16B
    FADD  V23.2S, V17.2S, V27.2S
    FMUL V26.2D, V31.2D, V19.D[0x1]
    SQADD  S14, S31, S10
    FCMGE  V20.4S, V11.4S, V3.4S
    FCVTZS  S5, S25
    SQRSHRUN V8.8B, V6.8H, #4
    FMAXP  V19.2D, V9.2D, V20.2D
    REV32  V11.4H, V29.4H
    UMLSL V24.2D, V14.2S, V24.S[0x3]
    SQRSHRUN V20.8B, V30.8H, #6
    SQRSHRN V11.4H, V13.4S, #4
    USHR  V21.8B, V1.8B, #3
    SQRSHRN V14.2S, V23.2D, #24
    UMLAL2  V4.8H, V15.16B, V12.16B
    DUP S20, V10.S[0x2]
    FACGT  D19, D18, D11
    UXTL2 V16.8H, V5.16B
    UQSHRN B24, H12, #2
    BIF  V26.16B, V1.16B, V29.16B
    DUP V8.8B, W11
    SQRDMULH  V17.2S, V6.2S, V26.S[0x1]
    SSUBW2  V22.4S, V9.4S, V26.8H
    ORR  V24.2S, #0x6d, LSL #16
    RSHRN2 V22.4S, V7.2D, #29
    FCVTPS  D25, D15
    TRN2  V0.4S, V4.4S, V15.4S
    ORR  V14.8H, #0x29
    MOV V30.D[0x1], X12
    RSHRN V9.8B, V0.8H, #7
    UMLSL  V15.8H, V15.8B, V2.8B
    SQSHRN V28.4H, V23.4S, #8
    FMAXNMP D18, V20.2D
    FCMLT  D26, D4, #0.0
    SQRSHRN2 V3.8H, V11.4S, #2
    SQNEG  H14, H23
    FMULX S4, S15, V2.S[0x1]
    UMLSL V4.4S, V22.4H, V8.H[0x7]
    UQRSHL  D25, D23, D19
    UXTL V20.8H, V11.8B
    SQSHRN2 V6.16B, V5.8H, #2
    SRSHR  V18.4H, V17.4H, #16
    FACGE  V12.2S, V14.2S, V30.2S
    MOV  W16, V30.S[0x0]
    SQADD  D26, D15, D9
    SUB  D17, D18, D2
    FSUB  V26.2S, V24.2S, V20.2S
    SCVTF D14, D3, #12
    FRECPE  S4, S10
    SMOV  X9, V14.H[0x6]
    DUP B19, V12.B[0x2]
    SQRSHRN H4, S4, #14
    SSHLL2 V25.4S, V8.8H, #0x2
    SQSHRUN2 V18.16B, V17.8H, #1
    SQRSHRN V10.8B, V23.8H, #2
    SADDLV  D6, V21.4S
    SRI  V8.8H, V17.8H, #5
    USQADD  V26.2S, V20.2S
    FADDP D13, V2.2D
    UQSHRN V30.8B, V26.8H, #6
    USHL  D23, D23, D2
    UCVTF S28, S21, #5
    FCMEQ  V16.2S, V15.2S, V12.2S
    FRSQRTS  S17, S8, S29
    FMAXP D26, V12.2D
    UQXTN  S22, D17
    XTN  V16.8B, V0.8H
    SQXTN  V5.2S, V15.2D
    ADDV  H8, V18.8H
    SQRSHRN V2.8B, V16.8H, #2
    SQNEG  S22, S5
    SQDMULL2  V21.4S, V4.8H, V12.8H
    FMLS  V22.2D, V0.2D, V31.2D
    CMEQ  D20, D20, D23
    FMINNMV  S24, V19.4S
    SSHLL2 V8.2D, V30.4S, #0x16
    FRINTN  V2.4S, V20.4S
    CMLE  D25, D23, #0
    FRSQRTS  S3, S12, S14
    CMLT  V25.16B, V14.16B, #0
    DUP  V12.16B, V0.B[0x7]
    UQRSHRN2 V5.16B, V3.8H, #1
    CMEQ  D10, D28, D23
    SUB  D2, D14, D1
    SQRSHL  H20, H0, H30
    SABDL  V18.2D, V20.2S, V1.2S
    UMULL  V24.8H, V1.8B, V23.8B
    SQABS  H7, H31
    UMULL V30.2D, V3.2S, V8.S[0x2]
    BSL  V6.8B, V23.8B, V22.8B
    FADDP  V5.2D, V7.2D, V20.2D
    SQABS  H4, H30
    MOV V5.B[0x5], V28.B[0x7]
    SQSHL B24, B10, #0x6
    RSUBHN2  V20.8H, V10.4S, V18.4S
TaishanSimdReduceP01_label_251:
    FCVTZU D2, D23, #29
    URSHR  V6.8H, V8.8H, #3
    UMLAL2 V7.4S, V3.8H, V4.H[0x5]
    MUL  V25.8B, V20.8B, V8.8B
    SSUBL  V30.4S, V17.4H, V30.4H
    CMGE  V6.4S, V24.4S, #0
    MOV  V21.8B, V21.8B
    UCVTF  D9, D12
    FRINTM  V1.2D, V4.2D
    URSHR V8.2D, V16.2D, #14
    UQXTN  S2, D15
    UMLSL  V12.4S, V27.4H, V31.4H
    UADDLV  H28, V17.8B
    INS V30.H[0x2], V23.H[0x6]
    SSHLL2 V24.4S, V12.8H, #0x9
    SUBHN2  V21.8H, V24.4S, V30.4S
    CMGE  V17.4S, V28.4S, #0
    USQADD  S0, S6
    SSRA V18.2D, V10.2D, #23
    UQSHRN B28, H21, #7
    SQRSHL  H28, H2, H14
    URSRA  V10.8H, V12.8H, #1
    FMLS D18, D0, V1.D[0x0]
    SQNEG  B22, B19
    MOVI  V1.2D, #72056498821201920
    SQDMLAL2  V28.4S, V0.8H, V14.8H
    SQXTUN  S26, D17
    SQSUB  S21, S25, S15
    USQADD  D10, D2
    SQDMLAL S20, H31, V7.H[0x4]
    SQRSHRUN H30, S26, #7
    SHLL  V28.2D, V25.2S, #32
    FCMGE  D5, D2, #0.0
    FMOV  V31.2D, #5.75000000
    SQRSHRUN V6.4H, V30.4S, #13
    SQADD  V9.4H, V30.4H, V17.4H
    USUBL  V11.8H, V28.8B, V18.8B
    FCMLE  V10.2S, V8.2S, #0.0
    UQRSHRN V25.2S, V19.2D, #31
    USRA  V9.8B, V5.8B, #2
    SQDMLAL V8.2D, V26.2S, V22.S[0x0]
    SRSRA D12, D15, #27
    FCVTZS  V25.2S, V0.2S
    URECPE  V0.2S, V23.2S
    CMGE  V11.16B, V15.16B, #0
    FMAXNMP  V10.2S, V0.2S, V2.2S
    CMEQ  V19.2S, V13.2S, V10.2S
    SUBS  X4, X4, #0x1
    B.NE  TaishanSimdReduceP01_label_1579
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X14, X20, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X20, X8, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X12, X8, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X20, X5, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X11, X5, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X12, X25, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdReduceP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X22, X21, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdReduceP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X27, X3, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdReduceP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X26, X8, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    MOVZ  X5, #0xff, LSL #0
    MOVK  X5, #0xff, LSL #16
    SUB  X9, X5, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X6, X23, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X21, X9, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X13, X5, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdReduceP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X14, X15, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X25, X14, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdReduceP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X21, X12, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X7, X10, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdReduceP01_TestFail
    FMOV  X25, V2.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X25, D2
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X16, X15, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X9, D3
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x3fc0, LSL #16
    SUB  X29, X20, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X3, D4
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X3, D5
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X13, X28, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdReduceP01_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X18, D6
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdReduceP01_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X6, D7
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X26, D8
    MOVZ  X16, #0xc5fc, LSL #0
    MOVK  X16, #0x3, LSL #16
    MOVK  X16, #0xfffc, LSL #32
    MOVK  X16, #0x3, LSL #48
    SUB  X23, X16, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdReduceP01_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X6, D9
    MOVZ  X20, #0x3e3e, LSL #0
    MOVK  X20, #0x3e3e, LSL #16
    MOVK  X20, #0x3e3e, LSL #32
    MOVK  X20, #0x3e3e, LSL #48
    SUB  X16, X20, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdReduceP01_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X23, D10
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x7fc0, LSL #16
    SUB  X2, X14, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdReduceP01_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X6, X8, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X20, D11
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xff, LSL #32
    MOVK  X8, #0xff, LSL #48
    SUB  X6, X8, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdReduceP01_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X18, D12
    MOVZ  X6, #0x7c14, LSL #0
    MOVK  X6, #0xe22d, LSL #16
    MOVK  X6, #0x1406, LSL #32
    MOVK  X6, #0x1414, LSL #48
    SUB  X9, X6, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdReduceP01_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    FMOV  X4, D13
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdReduceP01_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X3, X25, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X16, D14
    MOVZ  X25, #0x0, LSL #0
    SUB  X3, X25, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdReduceP01_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X4, D15
    MOVZ  X8, #0xffff, LSL #0
TaishanSimdReduceP01_label_929:
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xcb3f, LSL #32
    MOVK  X8, #0x9670, LSL #48
    SUB  X18, X8, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X11, X19, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X9, D16
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xf17f, LSL #16
    MOVK  X19, #0xffff, LSL #48
    SUB  X11, X19, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X29, X25, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X13, D17
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X29, X25, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X13, D18
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #48
    SUB  X11, X14, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdReduceP01_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X20, D19
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X18, X29, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdReduceP01_TestFail
    FMOV  X25, V20.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X25, D20
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdReduceP01_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X6, D21
    MOVZ  X13, #0x1, LSL #0
    SUB  X19, X13, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X12, D22
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdReduceP01_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X27, D23
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    MOVK  X25, #0x7fc0, LSL #48
    SUB  X28, X25, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdReduceP01_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X14, D25
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdReduceP01_TestFail
    FMOV  X22, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X22, D26
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdReduceP01_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X15, X3, X8
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X8, D27
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X15, X3, X8
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdReduceP01_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X7, D28
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdReduceP01_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X5, X4, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail
    FMOV  X23, D29
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X5, X4, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdReduceP01_TestFail

TaishanSimdReduceP01_TestEnd:
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
TaishanSimdReduceP01_TestFail:
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
